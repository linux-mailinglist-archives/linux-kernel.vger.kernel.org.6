Return-Path: <linux-kernel+bounces-376976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1DB9AB84E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 23:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A1081F220BE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 21:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5F21CCEE9;
	Tue, 22 Oct 2024 21:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="INBgQWKj"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA321547ED
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 21:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729631740; cv=none; b=rwv9FtwEFnI27Ev8JOsCeVwa9sucp1YdiLFYp7OlEOGsPwkwndOks0T3Xa9lHhsqrXw/2cp0UK2QPldmN2cZ4IQhMlzFvDVSPSnfVwbtl6tyi1f0bPcqzUTelnZ6vc0p9xQZN+p/mpA7FrCVfCOskUHgYTtQt/YudtvqRrR9pKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729631740; c=relaxed/simple;
	bh=VetiwndxaLki2sIJhGU3TmY3wysvZN9fDImLgRxsAMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=okR5YmBLvynRjxrvwuKC47ysORPhbooN8XKfqDxmgBDZWaYexYSYtWgYCKn7R887qOvbpBQs8IiAGqzlMOQkZX4PjVeRSXNKgmkF5xCVA+EK70wbjKsWCJa9zJzB/lfo7+MzpPgzwswJAtWtNC9eXRePaeCulT4iY4aNAs+XTq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=INBgQWKj; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4315a8cff85so82795e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 14:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729631736; x=1730236536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0rUMb9s0Swo9BEmB7UBEcgRnDzC0gwsdWpcAfzDYUoI=;
        b=INBgQWKj9GCMob+RZY2rqZX92MRsFqsIZcGw0zzeI7F+Gy6g2qU4HD4CR3h5wMc6T+
         a/SCDbp4mSRpoOpunRyKmFCJs1bftSm2J4tbouVLkj/pstAUEe4sTO+587MRYJjFBgYT
         aMCumtKMEGzyjkrYp1XcXUUZUZuXC0hBKFT67flGX1LVGF1ZSbzXtUypkKibNpJiCxoz
         KVEE3ljp5xBRyNg6GoqNTPzqAsIlM0lcnX8oEkBD0ArmiarJZkbfZWOb4iCZ7bVLCd3U
         W0bZJ4iJ8JDm3UkgXcszu2TKsBTipQ/XFZZX+9ekGeDYD7Cwg2Poo7nojGDcH8q14AM0
         EOqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729631736; x=1730236536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0rUMb9s0Swo9BEmB7UBEcgRnDzC0gwsdWpcAfzDYUoI=;
        b=rnOb+z0PUPARf6OkmQd9iLAOE6eO6bxuBUOSor2t/VffEtEL4Qr9G/tfOHbQv+SGVm
         VorLEz7axzYNhDssmO5tSxxyx/Vkza3NZKn0IXwYjmSnRSun4sYlDFIsUtcpIuUDrZDT
         zz4v2gJoW2DfI/PwGyuLwQVTapPIrXamwLrjRjpN3h3Cep9tMPwV33afZicVnnZktOHD
         HfaapM8n2Tkh5eqgpQ55n4ZMgIzXqKLtNdES6iC/Y9St9wahX+l3/Ey589TVOmxoYCfs
         OZFcZvTJcK/zfhH4jYqLZdPEhut7elhK401SnmFPevzT+QoPTbFKnoZA562TP56se4Vg
         +vCg==
X-Forwarded-Encrypted: i=1; AJvYcCXWsc9EfMmH54AzfGgQDtQFk+7SX1Ao0JIySme3xZmKdDV/l0mJPZYxt9ZjDgX4QJWvZ2ZE2jlF3W2vfFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBXjeL2il2YI1XuAOvlRJ08QJLi+qsqJ/zPTf/g2e/ZVcvrMCA
	gUqTqeiljmrq5dJ0Me02mnXCgK2b/5uB8anB8Lpr/aIHolNMKcZNKWoL6vWjOByzdquItYE3TB4
	e2XteNDvyW0pNAJiW54NYIGajx9qNrY1o6baI
X-Google-Smtp-Source: AGHT+IGhSlsgW6MGl5W6fBPRAtDoC93WpnDCJzh2qK5H7Wd9cz2SAe/vsJFE5YFEPhrG10mwkI59xYzNVMZlvnWnVNs=
X-Received: by 2002:a05:600c:3d95:b0:428:e6eb:1340 with SMTP id
 5b1f17b1804b1-431851f9c76mr96625e9.4.1729631736341; Tue, 22 Oct 2024 14:15:36
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1729628198.git.lorenzo.stoakes@oracle.com> <ddc1e43edbb1e8717c2be7fde96b682d8a898836.1729628198.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <ddc1e43edbb1e8717c2be7fde96b682d8a898836.1729628198.git.lorenzo.stoakes@oracle.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 22 Oct 2024 23:14:58 +0200
Message-ID: <CAG48ez0opg3QVC5Gh28=Xox5ARHGLa=Kt_Lp2VivC1SzfThyLQ@mail.gmail.com>
Subject: Re: [PATCH hotfix 6.12 1/8] mm: avoid unsafe VMA hook invocation when
 error arises on mmap hook
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 10:41=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> After an attempted mmap() fails, we are no longer in a situation where we
> can safely interact with VMA hooks. This is currently not enforced, meani=
ng
> that we need complicated handling to ensure we do not incorrectly call
> these hooks.
>
> We can avoid the whole issue by treating the VMA as suspect the moment th=
at
> the file->f_ops->mmap() function reports an error by replacing whatever V=
MA
> operations were installed with a dummy empty set of VMA operations.
>
> We do so through a new helper function internal to mm - mmap_file() - whi=
ch
> is both more logically named than the existing call_mmap() function and
> correctly isolates handling of the vm_op reassignment to mm.
>
> All the existing invocations of call_mmap() outside of mm are ultimately
> nested within the call_mmap() from mm, which we now replace.
>
> It is therefore safe to leave call_mmap() in place as a convenience
> function (and to avoid churn). The invokers are:
>
>      ovl_file_operations -> mmap -> ovl_mmap() -> backing_file_mmap()
>     coda_file_operations -> mmap -> coda_file_mmap()
>      shm_file_operations -> shm_mmap()
> shm_file_operations_huge -> shm_mmap()
>             dma_buf_fops -> dma_buf_mmap_internal -> i915_dmabuf_ops
>                             -> i915_gem_dmabuf_mmap()
>
> None of these callers interact with vm_ops or mappings in a problematic w=
ay
> on error, quickly exiting out.
>
> Reported-by: Jann Horn <jannh@google.com>
> Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() f=
ails")

(I guess the "Fixes" tag here is a little unconventional in that it
doesn't actually point at the commit introducing the issue that this
commit describes, but it does mark to where the fix should be
backported, so I guess it makes sense and I don't have any better
suggestion.)

> Cc: stable <stable@kernel.org>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Jann Horn <jannh@google.com>

