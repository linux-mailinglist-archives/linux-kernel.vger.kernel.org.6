Return-Path: <linux-kernel+bounces-571797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C67E2A6C25D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 19:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47ECB174BB6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 18:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF50922F16F;
	Fri, 21 Mar 2025 18:28:32 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F661E7C25
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 18:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742581712; cv=none; b=JXbu7DjcdrIQIeM9981qc8u9+wP0E9vfDEonzeHrRY/BthAuigkXRwxRmejT0pcHqkU7NSt2NE83ji+Y9X3B9Bb7idpo2Zp3ZUOPckkLIaXQ/S+XbTVro1EMJ+s7g06iRqiLYadvs3xXTB3a2dtRPitn05hD7dCGQLv+vVZQ/oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742581712; c=relaxed/simple;
	bh=tXDG0HVPG50ilB7lrvas3miX/VFYLcKIDCgl5UPMr9g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gt4qoFrh5/mTbER/CWWA12Zpb8Q76HSrNXATTM5IzZOHlRHOG5WnB3CVpAgn+MAHToHgRyDUADmk1ax0SbGE4zbymNzbfXHPHqgZ2UWfkLeKJOD0RlS//laRhEpEcRU0cxNdryqaAcWWOyn87L7C8ivLdo7AYYRHJl8pqM1N2Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A469C4CEE3;
	Fri, 21 Mar 2025 18:28:29 +0000 (UTC)
Date: Fri, 21 Mar 2025 14:28:26 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH] tracing: Disable branch profiling in noinstr code
Message-ID: <20250321142826.65a160bf@batman.local.home>
In-Reply-To: <g4rdlv4it35nlftf6uyaewe4b52buho6pvnamjmwd2iu5cq5q2@xh4uluvgaqvn>
References: <52a664ec9e14ef53c39c3d4fa400c2f1d29348c0.1742537096.git.jpoimboe@kernel.org>
	<871puq2uop.ffs@tglx>
	<20250321131248.02114dd7@batman.local.home>
	<g4rdlv4it35nlftf6uyaewe4b52buho6pvnamjmwd2iu5cq5q2@xh4uluvgaqvn>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Mar 2025 10:21:34 -0700
Josh Poimboeuf <jpoimboe@kernel.org> wrote:

> I *basically* did that, albeit in more of a surgical manner by editing a
> lot of the makefiles in arch/x86/*/.
> 
> Let me see if I can figure out how to do that more broadly at the
> arch/x86 level.

Ah, I thought there was a way to do it recursively, but I don't see a
way to do that.

Masahiro, do you know of a way that we can add a CFLAGS option to a
directory and all its siblings without modifying all the Makefiles?

-- Steve

