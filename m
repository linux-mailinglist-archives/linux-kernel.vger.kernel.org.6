Return-Path: <linux-kernel+bounces-312837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C9E969C44
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 13:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA2871F226AF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E911A42DB;
	Tue,  3 Sep 2024 11:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIgCKigd"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C901B12E7
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 11:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725363929; cv=none; b=jueu3fcbBgwF/nKXvwahnhYnkkGEfSS5d/H6sR1glSSlrgPwPRfiXpTHqECDbceVumtj34ErGRqW7bAI5Mhlh//E6yX1jvWGHK1cPafIakhiZPzr9wpKIS4Kw6I1iArWR24ZQrP7xiSAlYi2H37jG6u22yujEJoig+JCvttvmRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725363929; c=relaxed/simple;
	bh=038TNG5+PGlS638p30OIlAFCc6DQbv81N7VRxna1cUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h6lXBtU8eObTHr4JVCNgN5WCGruNmv7d72Wl48/G3eknSiQCrskwlEkP44dyuLLTcoy2xbGXK5y1VLKkQfyunBpHVGWmQ04YEKG2nVRAOVAaGwL07MLCTYNgeK4YS0wAqgsnfqVQA8OqiXO4oyZ61jrbbl3XHxEZZfox+/OKcVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AIgCKigd; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4fee7fa19c8so1487839e0c.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 04:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725363927; x=1725968727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ac8wg5vVxztSH0hsUHH1RGi5ZxFIg+rR7fcxRj41EWc=;
        b=AIgCKigdBQiPsNHRdeOKfzYzxgSE+nVOw3YibLz7hwJ0bqqNL6IRBplMsoVsVxt8L1
         MSIn7YfweXGXYEZ9fb34Sa6gog5qgDDwc6eltYNkJbIpB0oXvDbeMTk+flnmFwJSYtzC
         9Y73loicrjhroyvIfo1lgCV1KrhwxVCfJEKLR/bhG6uMVplBOXOzkPgU6HSuQRP1vZJv
         NJ5qSF+MWT8uObeo79pvQ9oJlTNZ2umtAu5p3ya/IXm+0lASRuW0d2zxkmrfzb7IpKbl
         HnIeNcqkN0gNQyMvqpYbUoCLsvfU/2NUZ2txgph299vppQQKELqgDQF6O8YUlEL4DuRr
         4ySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725363927; x=1725968727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ac8wg5vVxztSH0hsUHH1RGi5ZxFIg+rR7fcxRj41EWc=;
        b=XfEfD3qaNKDutgTnhIgX7UnpfR5CA0/HREsaiGUJUrXKVX86aLoy7do1MnCNDqEF9U
         xzVGFLrg9wv4OLzfvN4Oo7AYfp16Y2V1FDBGXb7OtXKBjrilBy7i5hTCSDGevJpeu7UJ
         BVwYszOoYkkcksFqcdbSK+MTDlLHprBTZmTbPo5ZHE72N3DaBcZy/lAEqnLCbXUY9et9
         0JzneJSflBUOU2aUgYI5wiiXUjZCFQzLV3uSzel1uE2fFTEyH/EkNUVedKIeyETO/lij
         OCAr8vf7AvUP/z3SJWJ4qXz4RA9SpuVHsnoA4gplWAlBP+A0vHbNOLb4HAyXQ6NpbFqs
         a0pw==
X-Forwarded-Encrypted: i=1; AJvYcCUyB5sq3kJ9MfgAd91gZYzG+dCOfpU98V6zjlNFGuYB8XkRXzqN7vYN4awNRmbfgexoFol6h+UCBC1FgSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwPq9lWMmOfK+8wL94ruz8Epn4vfMupajysedIAWlB6+isKHrU
	d+tA4oDspKGv/lH01k63RIMZOEoa1tF+JT+D2/E3F5Z1w993wvODnq+vuHPzrCcOyAr20lKiYJP
	cZrEuPIsbGj7dUMkubuhaMAihjaE=
X-Google-Smtp-Source: AGHT+IHYMvDwkTdUR5bfTMCeqJTcS8otsYNrbeRZ5Yur7qnM4Rq+zwENd+b/UbSwEAoxlAzkelenCAJbOjfJeUxYx6o=
X-Received: by 2002:a05:6122:3b11:b0:4f6:a618:61ce with SMTP id
 71dfb90a1353d-5009db5b0e7mr10178833e0c.7.1725363926973; Tue, 03 Sep 2024
 04:45:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902225009.34576-1-21cnbao@gmail.com> <20240903110109.1696-1-hdanton@sina.com>
In-Reply-To: <20240903110109.1696-1-hdanton@sina.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 3 Sep 2024 19:45:12 +0800
Message-ID: <CAGsJ_4xr-HvqKdh=Q=sVKM+hM+VS1Cf4gqPvq9vDtnQSBO9X=A@mail.gmail.com>
Subject: Re: [PATCH] binder_alloc: Move alloc_page() out of mmap_rwsem to
 reduce the lock duration
To: Hillf Danton <hdanton@sina.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Tangquan Zheng <zhengtangquan@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 7:01=E2=80=AFPM Hillf Danton <hdanton@sina.com> wrot=
e:
>
> On Tue, Sep 03, 2024 at 10:50:09AM +1200, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > The mmap_write_lock() can block all access to the VMAs, for example pag=
e
> > faults. Performing memory allocation while holding this lock may trigge=
r
> > direct reclamation, leading to others being queued in the rwsem for an
> > extended period.
> > We've observed that the allocation can sometimes take more than 300ms,
> > significantly blocking other threads. The user interface sometimes
> > becomes less responsive as a result. To prevent this, let's move the
> > allocation outside of the write lock.
>
> I suspect concurrent allocators make things better wrt response, cutting
> alloc latency down to 10ms for instance in your scenario. Feel free to
> show figures given Tangquan's 48-hour profiling.

Likely.

Concurrent allocators are quite common in PFs which occur
in the same PTE. whoever gets PTL sets PTE, others free the allocated
pages.

>
> > A potential side effect could be an extra alloc_page() for the second
> > thread executing binder_install_single_page() while the first thread
> > has done it earlier. However, according to Tangquan's 48-hour profiling
> > using monkey, the likelihood of this occurring is minimal, with a ratio
> > of only 1 in 2400. Compared to the significantly costly rwsem, this is
> > negligible.
> > On the other hand, holding a write lock without making any VMA
> > modifications appears questionable and likely incorrect. While this
> > patch focuses on reducing the lock duration, future updates may aim
> > to eliminate the write lock entirely.
>
> If spin, better not before taking a look at vm_insert_page().

I have patch 2/3 transitioning to mmap_read_lock, and per_vma_lock is
currently in the
testing queue. At the moment, alloc->spin is in place, but I'm not
entirely convinced
it's the best replacement for the write lock. Let's wait for
Tangquan's test results.

Patch 2 is detailed below, but it has only passed the build-test phase
so far, so
its result is uncertain. I'm sharing it early in case you find it
interesting. And I
am not convinced Commit d1d8875c8c13 ("binder: fix UAF of alloc->vma in
race with munmap()") is a correct fix to really avoid all UAF of alloc->vma=
.

[PATCH]  binder_alloc: Don't use mmap_write_lock for installing page

Commit d1d8875c8c13 ("binder: fix UAF of alloc->vma in race with
munmap()") uses the mmap_rwsem write lock to protect against a race
condition with munmap, where the vma is detached by the write lock,
but pages are zapped by the read lock. This approach is extremely
expensive for the system, though perhaps less so for binder itself,
as the write lock can block all other operations.

As an alternative, we could hold only the read lock and re-check
that the vma hasn't been detached. To protect simultaneous page
installation, we could use alloc->lock instead.

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 drivers/android/binder_alloc.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.=
c
index f20074e23a7c..a2281dfacbbc 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -228,24 +228,17 @@ static int binder_install_single_page(struct
binder_alloc *alloc,
                return -ESRCH;

        /*
-        * Don't allocate page in mmap_write_lock, this can block
-        * mmap_rwsem for a long time; Meanwhile, allocation failure
-        * doesn't necessarily need to return -ENOMEM, if lru_page
-        * has been installed, we can still return 0(success).
+        * Allocation failure doesn't necessarily need to return -ENOMEM,
+        * if lru_page has been installed, we can still return 0(success).
+        * So, defer the !page check until after binder_get_installed_page(=
)
+        * is completed.
         */
        page =3D alloc_page(GFP_KERNEL | __GFP_HIGHMEM | __GFP_ZERO);

-       /*
-        * Protected with mmap_sem in write mode as multiple tasks
-        * might race to install the same page.
-        */
-       mmap_write_lock(alloc->mm);
-       if (binder_get_installed_page(lru_page)) {
-               ret =3D 1;
-               goto out;
-       }
+       mmap_read_lock(alloc->mm);

-       if (!alloc->vma) {
+       /* vma might have been dropped or deattached */
+       if (!alloc->vma || !find_vma(alloc->mm, addr)) {
                pr_err("%d: %s failed, no vma\n", alloc->pid, __func__);
                ret =3D -ESRCH;
                goto out;
@@ -257,18 +250,27 @@ static int binder_install_single_page(struct
binder_alloc *alloc,
                goto out;
        }

+       spin_lock(&alloc->lock);
+       if (binder_get_installed_page(lru_page)) {
+               spin_unlock(&alloc->lock);
+               ret =3D 1;
+               goto out;
+       }
+
        ret =3D vm_insert_page(alloc->vma, addr, page);
        if (ret) {
                pr_err("%d: %s failed to insert page at offset %lx with %d\=
n",
                       alloc->pid, __func__, addr - alloc->buffer, ret);
+               spin_unlock(&alloc->lock);
                ret =3D -ENOMEM;
                goto out;
        }

        /* Mark page installation complete and safe to use */
        binder_set_installed_page(lru_page, page);
+       spin_unlock(&alloc->lock);
 out:
-       mmap_write_unlock(alloc->mm);
+       mmap_read_unlock(alloc->mm);
        mmput_async(alloc->mm);
        if (ret && page)
                __free_page(page);
--
2.39.3 (Apple Git-146)

