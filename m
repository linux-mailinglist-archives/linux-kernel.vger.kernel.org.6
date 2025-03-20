Return-Path: <linux-kernel+bounces-570112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AEFA6AC3D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7225118909D8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 17:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66980226548;
	Thu, 20 Mar 2025 17:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cps9DzPG"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C2E22618F;
	Thu, 20 Mar 2025 17:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742492404; cv=none; b=sj0PonIYm9bXXPSN9flt3OfbZWqWhp3oZ+1m7IMHddR9kzfqYaOrbdIjvNsnRrKR9tBdTOXQJGY2AHIIMwThjKrnZ6fml/6EolNY4CZM9r1gJ27kizT75o8p6a8Zf8SJyIgG7z9T9WQfXyeYqeXJOwTh3km+0Ldup6hdUHI7ezA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742492404; c=relaxed/simple;
	bh=gpGLVKoREoUi12NpjXgAakIGPXWe4J/DtcP8JYm5+4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tRWLE+Sf6uHjCeN5SMAMCXnJ267bL1uTRHXBn+p/NqaUgxQL+oke9pTezZld5E43paHIS4+tQL1eSxICa3YGL0lvNN1EUTDhVi6cjZV9TmWaLNe2rPREgSGtprHmPRNLiBunttvC4hdqpCIUvSCvp9UWd7enQcLGSikvY+sp7BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cps9DzPG; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cf89f81c5so1245025e9.2;
        Thu, 20 Mar 2025 10:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742492400; x=1743097200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICJPfH1Men5qwSYszeUMQ6QRHz5SpwAhZQR7oJ7/pJ8=;
        b=Cps9DzPGAEGwJdLX7vZyU60BKv8AKLZz/xnxP3J5MzGT8bwKY7LKJACP2+7JS6YO7G
         wM7xEsAMBwRUPNEZo82TNcX6DlRm8YFEvyF5Msxig0djvjHbiKeHjwh61pI0YBq4B1Pt
         EvfFv4MNeIYSwA/qxzHfE8UrUH8IpHFBbPPndGAhx7H654lWFI+GRukDCaEfZwI2C2d5
         iAhBMFH5TWyKLjwgPZCviDVmMBZ6tgZYm4ucHIF7f8SD3xXr/wsG8dYghGpptFRlZVX+
         eP8ScCpNQx33gHWX8GojQGQ6pkyVW0ZofROtkW/r3NgN9a7Q3Th2CqArS0GYc2p5aCm4
         gc+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742492400; x=1743097200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ICJPfH1Men5qwSYszeUMQ6QRHz5SpwAhZQR7oJ7/pJ8=;
        b=IsC+E9LtzGLL2vgC2LK2HoMMhZKwW4Re3jLgc//o9raebxNxIto9DtFpBYh2bn2qki
         zs5wKjjtfGCQDJ93phMEJwcKmoPf9j5gi/9GVr6FNi0vZU1pO2ZFq5QVh3cbSVW9f/za
         1LVd4bAbEvIgg86AoMOf8u6NPJwA+hrRx2P2iswplfdhuZI82IDqULxMGNSFLCypBt6+
         sFHpg31M+VfEVX8YhD0DrOWkh4+CvTdOdaXENQjz1HshiAeSeXysmosidDplLxU108Uh
         mnlHhvVmYggYKIW3m6iwABdypcMtY3Gf9pXx96wh3lyT5RSELagzR6ZnJZv9kzDSXDxt
         /nZw==
X-Forwarded-Encrypted: i=1; AJvYcCVnSXFlSU5p8Za5krAISjm97sKgVMQ9hYDXMiLjfmIj0KFWKXc/Yn3/zCpCjlkpcULPR9tWlAFk0FU6nA30@vger.kernel.org, AJvYcCWfkmmmvr+KbLea3QvwcLvI15SP4Lp/GUPD5MgKyvzSoQ+n3+4zYBcEfsT28Uqz9XM3SYuQLRPr6fg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTqW76WP9tkXX591J6wfnK9lWkJH6eGGG6UtTURmTIhLq8buDy
	Phmm8MXcdijQHOOWElvZ/l1GMI956g77ov8pIqMwOwUh5RYLJlsIINoFKoC79UavzCia2eo5c3T
	th3hOEV7lFxsqJV1wbSLyZ3mMB+8=
X-Gm-Gg: ASbGncv01ocobIWUaOtsG3Y3geWhS/RG/sqpxkbOqY5MzYup8MfO3HdBBByEZF+FY2Q
	6FY6vR1/dRmKsozzj6rW79ghfOrKuEilFvnNAJDrhD7sVNxd2FR/Hjr/bXAzoHyhY2xjI0fC4H4
	z7r9Px+R6NpeK1IWw/WA0Mns2hhMXS3mXlxZNU8JmnJKncZPh2OPKelMD4
X-Google-Smtp-Source: AGHT+IEX+FZMqw/uKIyLvjuLIVQFBZHkjVI/CUtdYx+oxdxQMzv1hpI+TEDGWokkbPtcXqceiLtWpgt7xJ7OwvQ//Fc=
X-Received: by 2002:a05:600c:46c3:b0:43b:bbb9:e25f with SMTP id
 5b1f17b1804b1-43d44d75804mr24674625e9.6.1742492399899; Thu, 20 Mar 2025
 10:39:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739866028.git.maciej.wieczor-retman@intel.com> <383482f87ad4f68690021e0cc75df8143b6babe2.1739866028.git.maciej.wieczor-retman@intel.com>
In-Reply-To: <383482f87ad4f68690021e0cc75df8143b6babe2.1739866028.git.maciej.wieczor-retman@intel.com>
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Date: Thu, 20 Mar 2025 18:39:35 +0100
X-Gm-Features: AQ5f1JqCTLk6bw5pMZNlmkGp7az-6cdHmNjgmKBcGwH1kgc8PZz3csgjGnMk__8
Message-ID: <CAPAsAGxDRv_uFeMYu9TwhBVWHCCtkSxoWY4xmFB_vowMbi8raw@mail.gmail.com>
Subject: Re: [PATCH v2 09/14] mm: Pcpu chunk address tag reset
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Cc: kees@kernel.org, julian.stecklina@cyberus-technology.de, 
	kevinloughlin@google.com, peterz@infradead.org, tglx@linutronix.de, 
	justinstitt@google.com, catalin.marinas@arm.com, wangkefeng.wang@huawei.com, 
	bhe@redhat.com, kirill.shutemov@linux.intel.com, will@kernel.org, 
	ardb@kernel.org, jason.andryuk@amd.com, dave.hansen@linux.intel.com, 
	pasha.tatashin@soleen.com, ndesaulniers@google.com, 
	guoweikang.kernel@gmail.com, dwmw@amazon.co.uk, mark.rutland@arm.com, 
	broonie@kernel.org, apopple@nvidia.com, bp@alien8.de, rppt@kernel.org, 
	kaleshsingh@google.com, richard.weiyang@gmail.com, luto@kernel.org, 
	glider@google.com, pankaj.gupta@amd.com, andreyknvl@gmail.com, 
	pawan.kumar.gupta@linux.intel.com, kuan-ying.lee@canonical.com, 
	tony.luck@intel.com, tj@kernel.org, jgross@suse.com, dvyukov@google.com, 
	baohua@kernel.org, samuel.holland@sifive.com, dennis@kernel.org, 
	akpm@linux-foundation.org, thomas.weissschuh@linutronix.de, surenb@google.com, 
	kbingham@kernel.org, ankita@nvidia.com, nathan@kernel.org, ziy@nvidia.com, 
	xin@zytor.com, rafael.j.wysocki@intel.com, andriy.shevchenko@linux.intel.com, 
	cl@linux.com, jhubbard@nvidia.com, hpa@zytor.com, 
	scott@os.amperecomputing.com, david@redhat.com, jan.kiszka@siemens.com, 
	vincenzo.frascino@arm.com, corbet@lwn.net, maz@kernel.org, mingo@redhat.com, 
	arnd@arndb.de, ytcoode@gmail.com, xur@google.com, morbo@google.com, 
	thiago.bauermann@linaro.org, linux-doc@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-mm@kvack.org, 
	linux-arm-kernel@lists.infradead.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 9:19=E2=80=AFAM Maciej Wieczor-Retman
<maciej.wieczor-retman@intel.com> wrote:
>
> The problem presented here is related to NUMA systems and tag-based
> KASAN mode. Getting to it can be explained in the following points:
>
>         1. A new chunk is created with pcpu_create_chunk() and
>            vm_structs are allocated. On systems with one NUMA node only
>            one is allocated, but with more NUMA nodes at least a second
>            one will be allocated too.
>
>         2. chunk->base_addr is assigned the modified value of
>            vms[0]->addr and thus inherits the tag of this allocated
>            structure.
>
>         3. In pcpu_alloc() for each possible cpu pcpu_chunk_addr() is
>            executed which calculates per cpu pointers that correspond to
>            the vms structure addresses. The calculations are based on
>            adding an offset from a table to chunk->base_addr.
>
> Here the problem presents itself since for addresses based on vms[1] and
> up, the tag will be different than the ones based on vms[0] (base_addr).
> The tag mismatch happens and an error is reported.
>
> Reset the base_addr tag, since it will disable tag checks for pointers
> derived arithmetically from base_addr that would inherit its tag.
>
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> ---
>  mm/percpu-vm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/percpu-vm.c b/mm/percpu-vm.c
> index cd69caf6aa8d..e13750d804f7 100644
> --- a/mm/percpu-vm.c
> +++ b/mm/percpu-vm.c
> @@ -347,7 +347,7 @@ static struct pcpu_chunk *pcpu_create_chunk(gfp_t gfp=
)
>         }
>
>         chunk->data =3D vms;
> -       chunk->base_addr =3D vms[0]->addr - pcpu_group_offsets[0];
> +       chunk->base_addr =3D kasan_reset_tag(vms[0]->addr) - pcpu_group_o=
ffsets[0];

This looks like a generic tags mode bug. I mean that arm64 is also
affected by this.
I assume it just wasn't noticed before because arm64 with multiple
NUMAs are much less common.

With this change tag-mode KASAN won't be able to catch bugus accesses
to pcpu areas.
I'm thinking it would be better to fix this on the pcpu_get_vm_areas()
area side by replacing
this
    for (area =3D 0; area < nr_vms; area++)
        vms[area]->addr =3D kasan_unpoison_vmalloc(vms[area]->addr,
                                             vms[area]->size,
KASAN_VMALLOC_PROT_NORMAL);

with something like
    kasan_unpoison_vmap_areas(vms, nr_vms);
which will unpoison all areas using the same tag.

Thoughts?

