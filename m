Return-Path: <linux-kernel+bounces-574833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A6AA6EA8F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 08:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74FE93B7C63
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 07:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F8C253B60;
	Tue, 25 Mar 2025 07:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TD3aPTjI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57781199EB7
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 07:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742887909; cv=none; b=qCMXfne/+yz1BxswuquPYluooHMz6UiNkJnXdrXRZyw+niINM2YORNqrTqVdj/690UmopfKKQa31dg3KR2ail86ICEzCe6G61uhATYtGAyIWnR6/cjQ0sNpLhSogGz2Lc7isM6W9L47BL4rGXtdwcGx68rkhChalRL8yNrYcAGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742887909; c=relaxed/simple;
	bh=IQxe5ZB2omP4K06R4i46loG52z4yhoz/4TI5QBwYyNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDelk7ikQwSruiwcZlE3Md49+3ryL3KJ0pPso5CqvAEyVcQ/RjIp7xExVkLoU6vKU6B+zKqlHZVZPNj16IsmBd+ql/uQeGTbDcnhB5oEJrdgbxDjsyHlZ2o/MctlzYawHf06ZzKB0CTeZey8vi0OF52VJT975Wixe7w9tukPf8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TD3aPTjI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A525C4CEED;
	Tue, 25 Mar 2025 07:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742887908;
	bh=IQxe5ZB2omP4K06R4i46loG52z4yhoz/4TI5QBwYyNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TD3aPTjI/W7X8yRzl5xZy0pUHD6W0BoezoQ4ACPdwQLWfx3iMHRu9qyytbcju6Wr1
	 e+pkOHcnXpIzrHPIl6JINFO9tzhLzDnL9ECrfNVBmn9c43lNtcCNv/H8NEp0aS/PKb
	 7cyeZQe6iAko9Xcufq1fgOuSxT6h6hRGtBrbDg/KJpMbIEEnfTL6KCnpLU6qR2QQr0
	 55uNojT56g/K71aU/1oKi1v/HwhHe2mJ19U6pzHP4YsAW+eeEJ3k7lVZrsNBAI774Y
	 7DB4MifdogsqdD8rpypEmHTT5kMQpzszNgxCk9Hikuo3O5wNrfsgFeqxh8vz+9xI7n
	 uR2k9vu95XKSg==
Date: Tue, 25 Mar 2025 08:31:43 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Oleg Nesterov <oleg@redhat.com>,
	Vernon Lovejoy <vlovejoy@redhat.com>
Subject: Re: [PATCH 2/2] x86/dumpstack: Fix broken unwinding from exception
 stacks
Message-ID: <Z-Jb3xEcQWKn_uqe@gmail.com>
References: <20250325-2025-03-unwind-fixes-v1-0-acd774364768@google.com>
 <20250325-2025-03-unwind-fixes-v1-2-acd774364768@google.com>
 <CAG48ez0=dtR85yhy07jqvq9YC__3ocT_N_hpJMN4v-FfMs-PsA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez0=dtR85yhy07jqvq9YC__3ocT_N_hpJMN4v-FfMs-PsA@mail.gmail.com>


* Jann Horn <jannh@google.com> wrote:

> On Tue, Mar 25, 2025 at 3:01 AM Jann Horn <jannh@google.com> wrote:
> > Originally, get_stack_pointer() used the regs provided by the caller; after
> > that commit, get_stack_pointer() instead uses the regs at the top of the
> > stack frame the unwinder is looking at. Often, there are no such regs at
> > all, and "regs" is NULL, causing get_stack_pointer() to fall back to the
> > task's current stack pointer, which is not what we want here, but probably
> > happens to mostly work. Other times, the original regs will point to
> > another regs frame - in that case, the linear guess unwind logic in
> > show_trace_log_lvl() will start unwinding too far up the stack, causing the
> > first frame found by the proper unwinder to never be visited, resulting in
> > a stack trace consisting purely of guess lines.
> 
> I guess the subject line is kind of misleading - maybe "x86/dumpstack:
> Fix misplaced assignment in unwinder" would be better?

Well, it's a bug and the code is broken that results in subpar stack 
dumps from exception contexts that fall back to the guess-dumper, 
right?

So I've edited the subject line to:

   x86/dumpstack: Fix inaccurate unwinding from exception stacks due to misplaced assignment

But I'd have no problem calling it broken either - even if the bug 
doesn't crash anything.

Thanks,

	Ingo

