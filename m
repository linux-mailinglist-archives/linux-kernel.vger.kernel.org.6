Return-Path: <linux-kernel+bounces-349929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8156D98FD79
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 08:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF04FB21E4A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 06:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36F37E796;
	Fri,  4 Oct 2024 06:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XcwPa/u+"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8003D97F
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 06:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728024336; cv=none; b=cr2ettvtw+86dIzlL/qqXauoO8yvI1fLBvmbEd1z91wuoDpkbsM5eeKvKEXR64Z1ZFe6fnZAOo5uXitECgYHoxl7XZYtNEvtYd6afvbRCRKZRQqV/3cGFOVotITh4+/lap9IyFSyvu6E4RsmnPsbjE2QVp5XuCZGpmBinTQOqAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728024336; c=relaxed/simple;
	bh=mL2W2tJrDMQeo1z+yDtY45KIaV/M8fHOjbAIS4+Vjz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YTnHEH19OmFw593Jhw/OxoEopDdEybj3eNOBdag4C8WYPoX3p2Z278x1DJtft9TYRjRU+jMtrlvlnyxrfhBQsBE2WAQVQmVKh/NjxmWcT6aaxw673OqoKdKzfaL/HtULN3b9ElSdz4eaR5SZQoJ8Q5tlsxMUc831+nIhnD7p2cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XcwPa/u+; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5e5b57127e6so882725eaf.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 23:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728024333; x=1728629133; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mL2W2tJrDMQeo1z+yDtY45KIaV/M8fHOjbAIS4+Vjz4=;
        b=XcwPa/u+oQV6Se4VwG2bbsjXpK82/SRysuAmFy/N1EJZXyA6KuVNfNAHbNYSgOER/s
         vvQ+vim622dxkPr7Q21Bx7TT8UhX0wx1Pfced+2PZfqTkMR7K+DwbUw860n5cP6kkvk+
         2kkgEp/aw+uhADezIdHUVV/QxsjHNh8VXszlnOHHLdOf4RnLjl3nWfjPWoUB+FcQoCR+
         9uBAra0mKGKZTLRVIB8BN9+0v76ChhGyu9kRP8NKo+XPPHhTlKRnI6oQoQflZqij4vI2
         kKHF1Jw0UwTuzEli6kO+ETAmQJJvO/Up31lUn9xhuwh/yQmJ5bMa0UkPzHHwJYlCAHhJ
         evnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728024333; x=1728629133;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mL2W2tJrDMQeo1z+yDtY45KIaV/M8fHOjbAIS4+Vjz4=;
        b=fa796s07YFB2/YU0SSN4i2DEoPQu30045LD2OSnX5y4x+zKWH2XDQQrknetKwdca+q
         Fw15VDvZDk/FsglnhH+KUMSz2qIEch0xSNEILFjOpggFqMF6AsX648xMLACCrqRR6W7u
         rxyq4A9fYhzyHz7ZTMt5jTT9fm/6ALYQA1+EyY5vZYoaqPbIUorTZ0dfWHCDIsFuwxNa
         s2cPMO9EohOUbAAIR41g7bfekBJibIOLo4XH1vdiiVLO3CQsWwSzp5xYTEzDRCwhtkCp
         6wK2gQQcRhZK9iEe1tHxiDMs8i14X3SUumpmIBiURY+O9JnMwGxOw5yP8FkFN3OXEJo7
         4L4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVC5FEdULIIyqoM/6Zoqq0LtebYgFaa/9MCmZ3xdioY0CppCFLo813UEAPSAGmzBMzIulFzPGWbFlbQTU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB0WBfyh/47YY2e7oyJBjXF2n6QoGCzNiVOsW7h5H9ZYrF7PlE
	4EcPGkABff6TkBILMZTEL/ResBidJeryWIsSRqycvDKXpo3Wd1I2QCRR79e/nB1r6hX8LOOrVcA
	cthKWWdUmbLRiJs2Kk/VeuQan0zoPKA2UAFXe
X-Google-Smtp-Source: AGHT+IH4Qhk7cAgNm6q1FriBC0eeLIQyCLkkZYNvfP5aKV2GbglNqvRSEqLE9XFLJqJynYRgllNS+XWQ5R7JRKSBfyU=
X-Received: by 2002:a05:6870:364e:b0:278:14b6:a8f7 with SMTP id
 586e51a60fabf-287c20219d4mr1335084fac.42.1728024333180; Thu, 03 Oct 2024
 23:45:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911064535.557650-1-feng.tang@intel.com> <d3dd32ba-2866-40ce-ad2b-a147dcd2bf86@suse.cz>
In-Reply-To: <d3dd32ba-2866-40ce-ad2b-a147dcd2bf86@suse.cz>
From: Marco Elver <elver@google.com>
Date: Fri, 4 Oct 2024 08:44:54 +0200
Message-ID: <CANpmjNM5XjwwSc8WrDE9=FGmSScftYrbsvC+db+82GaMPiQqvQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm/slub: Improve data handling of krealloc() when
 orig_size is enabled
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Feng Tang <feng.tang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, David Gow <davidgow@google.com>, 
	Danilo Krummrich <dakr@kernel.org>, Alexander Potapenko <glider@google.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-mm@kvack.org, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Oct 2024 at 12:42, Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 9/11/24 08:45, Feng Tang wrote:
> > Danilo Krummrich's patch [1] raised one problem about krealloc() that
> > its caller doesn't pass the old request size, say the object is 64
> > bytes kmalloc one, but caller originally only requested 48 bytes. Then
> > when krealloc() shrinks or grows in the same object, or allocate a new
> > bigger object, it lacks this 'original size' information to do accurate
> > data preserving or zeroing (when __GFP_ZERO is set).
> >
> > Thus with slub debug redzone and object tracking enabled, parts of the
> > object after krealloc() might contain redzone data instead of zeroes,
> > which is violating the __GFP_ZERO guarantees. Good thing is in this
> > case, kmalloc caches do have this 'orig_size' feature, which could be
> > used to improve the situation here.
> >
> > To make the 'orig_size' accurate, we adjust some kasan/slub meta data
> > handling. Also add a slub kunit test case for krealloc().
> >
> > This patchset has dependency over patches in both -mm tree and -slab
> > trees, so it is written based on linux-next tree '20240910' version.
> >
> > [1]. https://lore.kernel.org/lkml/20240812223707.32049-1-dakr@kernel.org/
>
> Thanks, added to slab/for-next

This series just hit -next, and we're seeing several "KFENCE: memory
corruption ...". Here's one:
https://lore.kernel.org/all/66ff8bf6.050a0220.49194.0453.GAE@google.com/

One more (no link):

> ==================================================================
> BUG: KFENCE: memory corruption in xfs_iext_destroy_node+0xab/0x670 fs/xfs/libxfs/xfs_iext_tree.c:1051
>
> Corrupted memory at 0xffff88823bf5a0d0 [ 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 ] (in kfence-#172):
> xfs_iext_destroy_node+0xab/0x670 fs/xfs/libxfs/xfs_iext_tree.c:1051
> xfs_iext_destroy+0x66/0x100 fs/xfs/libxfs/xfs_iext_tree.c:1062
> xfs_inode_free_callback+0x91/0x1d0 fs/xfs/xfs_icache.c:145
> rcu_do_batch kernel/rcu/tree.c:2567 [inline]
[...]
>
> kfence-#172: 0xffff88823bf5a000-0xffff88823bf5a0cf, size=208, cache=kmalloc-256
>
> allocated by task 5494 on cpu 0 at 101.266046s (0.409225s ago):
> __do_krealloc mm/slub.c:4784 [inline]
> krealloc_noprof+0xd6/0x2e0 mm/slub.c:4838
> xfs_iext_realloc_root fs/xfs/libxfs/xfs_iext_tree.c:613 [inline]
[...]
>
> freed by task 16 on cpu 0 at 101.573936s (0.186416s ago):
> xfs_iext_destroy_node+0xab/0x670 fs/xfs/libxfs/xfs_iext_tree.c:1051
> xfs_iext_destroy+0x66/0x100 fs/xfs/libxfs/xfs_iext_tree.c:1062
> xfs_inode_free_callback+0x91/0x1d0 fs/xfs/xfs_icache.c:145
[...]
>
> CPU: 0 UID: 0 PID: 16 Comm: ksoftirqd/0 Not tainted 6.12.0-rc1-next-20241003-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> ==================================================================

Unfortunately there's no reproducer yet it seems. Unless it's
immediately obvious to say what's wrong, is it possible to take this
series out of -next to confirm this series is causing the memory
corruptions? Syzbot should then stop finding these crashes.

Thanks,
-- Marco

