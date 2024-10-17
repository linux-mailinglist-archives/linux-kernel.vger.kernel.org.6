Return-Path: <linux-kernel+bounces-370272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 554399A2A33
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 159EC28809B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218331EF950;
	Thu, 17 Oct 2024 16:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qdl14ogP"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE6E1E102D
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 16:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184286; cv=none; b=MFWxTe+iGA7zra5kE5/LYTb9aVE8w/L6OiZcYlPAUXRR3bmIHdG1oL91hKwyn10GmXREA9B9u8rzDjq2jfy9wKd3/Em/qUfO28/pUeDMAN2UZX9TKSclzqbVTsyq8fLuirVicHn1Jqtd/jepNwaEmb7q0VqnINsiNadkz3eU1TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184286; c=relaxed/simple;
	bh=8XB3a7uxPWVYCaQb9TO1KjD2csy1sUqq2mVlddinEQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H+eJwxa4LVgxnkfjREmtm8C3/UFBxYeeZknKhi3f5tQgHIuUbcZg3v1JjsV/beNFURQsjvrfjXWlVhwnWpPwumBmUotSEtWSH/M2BQWfPxonxavVFZD4a2El8uRRPI5Uzeyl2c2goqASW+PvdF1gHrmDmtBzVDgYuX6s6JkMwAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qdl14ogP; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539e66ba398so894e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 09:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729184283; x=1729789083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8XB3a7uxPWVYCaQb9TO1KjD2csy1sUqq2mVlddinEQA=;
        b=qdl14ogP5xgIxkzJD4PDjVxbjUqSH6DG4GYN8NaP9DZ4S79o0E+xefubfDSino+abk
         DeUJFB3mqIDXEA2VaZCE1iqoBiBABc4LNtBR4opnYLlm8XaLc5aR02kFgNWfZd0TCClC
         5PRiFi7xzFVO1VtTwFLTiBQU+cT0xKD0lGaLKp0pdWBUHMj673NDQAi1j17FLRU04z1p
         JSXepI/vdJEKXg1n0avbFrUYNcfNGN+2kQJdopVNP55kQomStPgoXsFkNJ/pKwkJ5+Mf
         BqJ48ENXKCqOkWhAuxQDjjoZ6kRKjI+7AGowUo/yCbLwziZx36RbvXLd4LLQcuOyBiFu
         5K+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729184283; x=1729789083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8XB3a7uxPWVYCaQb9TO1KjD2csy1sUqq2mVlddinEQA=;
        b=Tv9/x56Ej9CtzAwHQeZaMnUY0Zkopib6JYBKdqE5y0T0UiBvGytETj6CgwDl8dxtdS
         O7foLIyVdaO2oQgdK8wmXgGcQeTM0l+MZxI78wxc6NSci0FvtMEUvnHRor4p9p8+Mo2s
         Tk0DzHSAcNQHkY7pyOJTaMKUO4yu3s26xkt9jTdmTPk+UlFriw1NFMa6NKD++gvT4z8s
         9n7NxSbwX4/Ub+0VHInBCJcpW1vZkrlwETjsM3B8sQgicm0k7gTeuKoz8orwiI8fDbXc
         52m67K0x23kkELTffBTFcN8utjdgqVgBbA/nfDrbwO4k6m++DLwL/GmTm41aSC2rQ2Pa
         R7jQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4QKA0NMTHCgJyEX6KNUzquZSsdBvSPdds4TBM+2BVhoDiYWXcv8K1n8KNKKQYweePuiHxtpedVa4f4eg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyazqGR337EultS+fQbJJvU66tPWlbDS/IyQFHWctDzyqQtO7Z
	Pj9hgQoty3AstksAcb4qskd2FN/Php3DZoTS74/3qjFMBnsTdDUCJr8e8UeBGVDcFKp2WPSGMnj
	yEmhD0K3AqOXwzbhsbZpkE7e9slMDdesKCYRH7z7hkmQ0pBsqYwZw
X-Google-Smtp-Source: AGHT+IF6sxueAeebQ+K/v/kvkzKRFCdnShMJs7BNzRIjwiQCbzUDpO4yO96f/vtMBIZUVpSVOO3kE2IgJtfLm39ShC0=
X-Received: by 2002:a05:6512:b22:b0:538:9e44:3034 with SMTP id
 2adb3069b0e04-53a0d20566bmr563106e87.6.1729184282455; Thu, 17 Oct 2024
 09:58:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016-fix-munmap-abort-v1-1-601c94b2240d@google.com> <b5cfb010-c892-49d6-a278-fae0e1a0b0fc@lucifer.local>
In-Reply-To: <b5cfb010-c892-49d6-a278-fae0e1a0b0fc@lucifer.local>
From: Jann Horn <jannh@google.com>
Date: Thu, 17 Oct 2024 18:57:24 +0200
Message-ID: <CAG48ez2-opg-OBmY=Toah0A_qxJ3XmG4VkWHnXe2yqzZf3F2+g@mail.gmail.com>
Subject: Re: [PATCH fix 6.12] mm: mark mas allocation in vms_abort_munmap_vmas
 as __GFP_NOFAIL
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 11:47=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> On Wed, Oct 16, 2024 at 05:07:53PM +0200, Jann Horn wrote:
> > vms_abort_munmap_vmas() is a recovery path where, on entry, some VMAs
> > have already been torn down halfway (in a way we can't undo) but are
> > still present in the maple tree.
> >
> > At this point, we *must* remove the VMAs from the VMA tree, otherwise
> > we get UAF.
> >
> > Because removing VMA tree nodes can require memory allocation, the
> > existing code has an error path which tries to handle this by
> > reattaching the VMAs; but that can't be done safely.
> >
> > A nicer way to fix it would probably be to preallocate enough maple
> > tree nodes for the removal before the point of no return, or something
> > like that; but for now, fix it the easy and kinda ugly way, by marking
> > this allocation __GFP_NOFAIL.
> >
> > Fixes: 4f87153e82c4 ("mm: change failure of MAP_FIXED to restoring the =
gap on failure")
> > Signed-off-by: Jann Horn <jannh@google.com>
>
> I kind of question whether this is real-world achievable (yes I realise y=
ou
> included a repro, but one prodding /sys/kernel/debug bits :>) but to be
> honest at this point I think I feel a lot safer just clearing this here f=
or
> sure. So:

I mean, there is a reason why we have __GFP_NOFAIL, and if you don't
set it, my understanding is that you *can* end up failing allocations
when the page allocator sees no other way to make progress...

I think as a rough sketch, what you'd have to do to hit this issue
without cheating using fault injection might be something like this,
for simplicity assume all of this happens on the same CPU core:

 - make processes A, B, C, D; with A having threads A1 and A2
 - let process A consume most of the available RAM+swap (so that
process A will be killed first by the OOM killer)
 - let thread A2 enter some syscall that will allocate a lot of
order-0 pages without fatal_signal_pending() checks, then
block/preempt it somehow
 - let thread A1 enter an mmap() syscall, then block/preempt it somehow
 - let process B consume remaining available RAM, until B blocks and
the OOM killer decides to reap process A. Note that the OOM killer
starts by basically just setting a flag on the target process and
sending it a fatal signal; only if the target process doesn't exit for
some time after that (OOM_REAPER_DELAY =3D 2 seconds), the OOM killer
starts actively reaping the target's memory
 - let process C allocate as many maple tree nodes as possible (to
drain the slab cache's freelists), until C blocks on memory allocation
 - maybe let process D free one maple tree node or such, so that the
first maple node allocation in mmap() for constructing the detached
tree works?
 - let thread A2 continue - it will have access to ALLOC_OOM memory
reserves, and AFAIU will be able to completely empty out the memory
reserves, and will then hit a __GFP_KERNEL allocation failure
 - once A2 has hit an allocation failure, let thread A1 continue
execution - it, too, should hit a __GFP_KERNEL allocation failure

But I haven't actually tested that.

