Return-Path: <linux-kernel+bounces-535163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C738EA46FB2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB18216D019
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 23:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498D025D90E;
	Wed, 26 Feb 2025 23:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFJyRvE2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E0A27004B;
	Wed, 26 Feb 2025 23:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740613901; cv=none; b=ORs5oRMEzvirkiwfxgtpRdoX2eziDn9IWQCjtC/Onrsj1ejqA5ivoToNbAxkEJNkSzPGnaPoZKVAXAQ1pDQHiWNy7u150uBM+cMaoLFJjq7g4DMD2kVbspZ8mC8Bk8zO/61yfgMwPe8wPs5Y97Wksjb5JduedQsdU82++Ui6lt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740613901; c=relaxed/simple;
	bh=6EbVlzjJrV2ElwmZxu2gWiXV7FHg40FqwN7t5C4bvEg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=X5EXeXRvIcQX9jfX4wEcV4r9jPMsuCD24vwE5jd6SNUe0C0yuzAdEACwcS7KGYEddyJK/ITa/5UmEr7Fl0NjygI8YwaeUxsZJCyGpiX2U78PRmHhJ9zrx6v1wxPNwd5UH92ukoWuCVVp4Dpb2A8dZZdiGN0F5vozv20bFoPTszA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFJyRvE2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C515DC4CED6;
	Wed, 26 Feb 2025 23:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740613901;
	bh=6EbVlzjJrV2ElwmZxu2gWiXV7FHg40FqwN7t5C4bvEg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KFJyRvE2pX8fYVlh19qwqvU2lMd+tF8yVlrSF8Loo3ndDYgUeptke/zL7HThG1o3X
	 QBgyBwgX+29nhTztQxSTi7NGBT6FklT0jIRYh2CLrBZej40AVW5idPQAxfij/QxzPg
	 Kj5MIJ6BoG57nY3/AovMl92lJFMvDkDTNe+NIGR010cRd2o+G7sCbob5nfk0MFZQuC
	 VqrkSUZcjzJpI4y8ShmIuVwTPRoRnftzvILDBH35r5JdggmTzyRJy0rjap8c+hfaaz
	 GbzDIuIRK9OF6ii/mSg9J52dccfPGdzf3gqQw2DZZq0h7HhJVsR7yNEBg2ctJ7xMDZ
	 ir0ENPyxdMMSg==
Date: Thu, 27 Feb 2025 08:51:36 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Sven Schnelle <svens@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/ftrace: Let fprobe test consider already
 enabled functions
Message-Id: <20250227085136.741479a6719e53b50a0cc489@kernel.org>
In-Reply-To: <20250226111300.5140fa9e@gandalf.local.home>
References: <20250226142703.910860-1-hca@linux.ibm.com>
	<20250226235447.7fab8051b2968277ce6920db@kernel.org>
	<20250226111300.5140fa9e@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 11:13:00 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 26 Feb 2025 23:54:47 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > Hmm, this ftrace selftests has been expected to be run without 
> > any BPF programs... Is there any other issue on other test cases?
> 
> Unfortunately, systemd is starting to add BPF programs :-p
> 
> I noticed that my laptop has users.

Ah, I might need systemd-busybox to build minimum test environment :-(

Thanks,

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

