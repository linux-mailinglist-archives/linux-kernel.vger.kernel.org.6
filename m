Return-Path: <linux-kernel+bounces-524229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1454EA3E0DD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA9BB8004FC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4879420C028;
	Thu, 20 Feb 2025 16:29:55 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4D51FFC4E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740068994; cv=none; b=BblqbsXUxTmZLZFJqUn+c3UcBPPRFe/V5AqherpnhKWQeQN68vzeM+3QE2fSMEQumK+hrKgd80gF/j8oveGXhH7GeF9Swc2t0EWW5lXcxWRirYp/I0Dzw7lpUy4H8UMHc+fwsun6J8XE+GmzWj/JhYGqmKbC8MA7GV6rQWm8ANs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740068994; c=relaxed/simple;
	bh=EH/aEicKEhrMMU0HF44vWoJ4cRxxMoRIn4Oz3FT1rjs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dAvgAkou48thXaC5oDh2FAsCwTNuqb5Coc/hrBkJZdfV6rtixg/jNjFeGskEJxV8z0CtcTt3H8rmHBHWcwXcL2eKgbbFsX/B3x2LIfDnvaM9uuGQiXeRkPhPOoXlrCjQXKScBr/E4XrFaljThbk1RzsG8AZQVvHIO5brXPBwx+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A35A9C4CED1;
	Thu, 20 Feb 2025 16:29:52 +0000 (UTC)
Date: Thu, 20 Feb 2025 11:30:18 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Waiman Long <llong@redhat.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon
 <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Boqun Feng
 <boqun.feng@gmail.com>, Joel Granados <joel.granados@kernel.org>, Anna
 Schumaker <anna.schumaker@oracle.com>, Lance Yang <ioworker0@gmail.com>,
 Kent Overstreet <kent.overstreet@linux.dev>, Yongliang Gao
 <leonylgao@tencent.com>, Tomasz Figa <tfiga@chromium.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org, Linux
 Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH 1/2] hung_task: Show the blocker task if the task is
 hung on mutex
Message-ID: <20250220113018.5d5b4fb9@gandalf.local.home>
In-Reply-To: <3c09df17-79b2-40d4-a560-f6b1ddbbb73e@redhat.com>
References: <173997003868.2137198.9462617208992136056.stgit@mhiramat.tok.corp.google.com>
	<173997004932.2137198.7959507113210521328.stgit@mhiramat.tok.corp.google.com>
	<20250219112308.5d905680@gandalf.local.home>
	<0fa9dd8e-2d83-487e-bfb1-1f5d20cd9fe6@redhat.com>
	<20250219152435.35077ac3@gandalf.local.home>
	<db4ee5e9-56bb-408c-85e7-f93e2c3226dc@redhat.com>
	<20250220075639.298616eb494248d390417977@kernel.org>
	<d8c01f69-34c0-45cf-a532-83544a3a3efd@redhat.com>
	<20250219204153.65ed1f5e@gandalf.local.home>
	<20250220114036.e22e388402a00f7809a81dee@kernel.org>
	<20250219221141.09f9fe48@gandalf.local.home>
	<3c09df17-79b2-40d4-a560-f6b1ddbbb73e@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Feb 2025 08:13:31 -0500
Waiman Long <llong@redhat.com> wrote:

> Another alternative is to encode the locking type into the lowest 2 bits 
> of the address and combined them into a single atomic_long_t data item. 
> Of course, we can only support 4 different types with this scheme.

You could also use the MSB as they are either always all ones or all zeros
depending on the architecture ;-)

-- Steve

