Return-Path: <linux-kernel+bounces-278072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F89394AA80
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 317561C20E3B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCEF84A4D;
	Wed,  7 Aug 2024 14:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="CTMgIKjA"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E588005B
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 14:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723041657; cv=none; b=iIQhK/FKXa1zabv6tD+GGACw6cSjz+4I0N8uahozYFcpIfjzYXZyAUmihAvXenwXjIEs6edEZEHsOnW35AAktqNlUIbZNuxlEisSoA9Ub30m0rFVPwKpXKKhkSHsO4CSkOO8s1BzyENqvxUr36YUwcm2j9CZk4vN8GAKDR2D7w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723041657; c=relaxed/simple;
	bh=0sQ9CcuwNmnt4bKftEBHMaRCYgOPu5Lyc31KuvZDi60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hiNbThfad6vEGhigTPgjN6LaGnImuED25xBFR58UB9lVX8kaRFtZ7xzSwBxrjzHD68yfOGVKUfeKTsnniJM6h3zyK3CqbZoYHNq2+CS3vv6+44tFjX0pIsu+53qCRDWfGGsNfKKOdSJM8iXyJMiFAuLdu5P+eEILhWrlPXCk4LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=CTMgIKjA; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3db2315d7ceso890066b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 07:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1723041655; x=1723646455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3FCSeVm0zgIRrRlVAZ6M3ezYAgjYCe4IP6mmA4qsAbw=;
        b=CTMgIKjAoYTkbGmR10CaM9/t4OEe23W9CqG3xp33wUWeUDuk43oAYEZE9XZzm1SyAe
         LwJB4CzPR/aYTOV3qx2X1EthjLaeJ0fdOSSJKtS9uFjMRZ+OTzdHeiBl7yEGFQEiV2dS
         eZyCRxg/Q0p6armzqtnH+n33SJaJovgbURnnhevFMKIjljlpd6vfXwYHaSLg8IKvpke+
         6Qr4pn3ebBwFq9cqSw1MBZy3vEn4JciAI8m8U213aOlsodlGlOsVPSgiA4DeJComL90G
         N4JwaxitCQduZos4eCzalTg8zraByiiU7lYCLGbD6amrNwxAQQBhK/em4papJIzz8bWH
         qDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723041655; x=1723646455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3FCSeVm0zgIRrRlVAZ6M3ezYAgjYCe4IP6mmA4qsAbw=;
        b=ou+kPZxB4e/XJfC3urDgljs6zABgHME6h5n93wEDa7nRmmTfqE8DhvfpXx6lzUGd3D
         ZyWdwC1LhPepzNICgypK7q74Axqce1W2Lc/urGEG0nvmZy4ByZxckzQWMc/Q2vHHQ4Wh
         xtG8CLji3UNxU8WiuDvqPklPBSp2++5W6h/yztSAsH2zZY0tOnHMuYroak3azY9ye9Ui
         NJH+Er93zx/3+q46zQZgjJfeqXhOpRrPf847a0c61FSj/Kn/yO7Csn3RAr8UvMdcPGIO
         n5GBeldZAJtboiDIgcNzcozC/eXczdWgGsHDad6PbrDs9YL5oj1NBLU7UciglgeNqTSk
         OWsw==
X-Forwarded-Encrypted: i=1; AJvYcCXBsi4phHbJWfelPCqQtYE0DVl1xtl9TtBks3f9nJ8HmGCRHQFo8LL/UiInjX2XpQhg/9DM8UNOD1jp2n6Q93m6vBuzp43KDczQJr+X
X-Gm-Message-State: AOJu0YzGObkMbUyeNffoNz9ZSq9GvNK4vUndkbGk0HXSdeomi4qT5br9
	jgBIy1HuAQj4vNJ/11kYtGu5R14y0EZapnRSET4nqtR48AEAAcNDLPQyLBv1jg8/cMpUghnnKAG
	TaXzB2cxso3AB5c7Q1soGuXDk4LBZUu5WiTwQYw==
X-Google-Smtp-Source: AGHT+IGOXQAzEiXp6xdPGUMTTnKI09YBOs1Vk6kj0LXvCI51MvBrgaaI5JzS3LcBWq8pGTljqab9RWCOjdJxV6Tr6zo=
X-Received: by 2002:a05:6808:130f:b0:3db:251b:c16 with SMTP id
 5614622812f47-3db558397b9mr20918330b6e.42.1723041654777; Wed, 07 Aug 2024
 07:40:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806221454.1971755-1-pasha.tatashin@soleen.com>
 <20240806221454.1971755-2-pasha.tatashin@soleen.com> <345ba221-e094-47e8-9481-562faf4acd85@redhat.com>
 <e780e9af-e23d-44ff-ae0f-a8f4ee098a1c@redhat.com>
In-Reply-To: <e780e9af-e23d-44ff-ae0f-a8f4ee098a1c@redhat.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 7 Aug 2024 10:40:17 -0400
Message-ID: <CA+CK2bBuDu-3XeeAsy4zggOrxTrp84bcZp9p6mQipzc3NqpcSg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: keep nid around during hot-remove
To: David Hildenbrand <david@redhat.com>
Cc: agordeev@linux.ibm.com, akpm@linux-foundation.org, alexghiti@rivosinc.com, 
	aou@eecs.berkeley.edu, ardb@kernel.org, arnd@arndb.de, bhe@redhat.com, 
	bjorn@rivosinc.com, borntraeger@linux.ibm.com, bp@alien8.de, 
	catalin.marinas@arm.com, chenhuacai@kernel.org, chenjiahao16@huawei.com, 
	christophe.leroy@csgroup.eu, dave.hansen@linux.intel.com, 
	dawei.li@shingroup.cn, gerald.schaefer@linux.ibm.com, gor@linux.ibm.com, 
	hca@linux.ibm.com, hpa@zytor.com, kent.overstreet@linux.dev, 
	kernel@xen0n.name, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, loongarch@lists.linux.dev, luto@kernel.org, 
	maobibo@loongson.cn, mark.rutland@arm.com, mcgrof@kernel.org, 
	mingo@redhat.com, mpe@ellerman.id.au, muchun.song@linux.dev, 
	namcao@linutronix.de, naveen@kernel.org, npiggin@gmail.com, osalvador@suse.de, 
	palmer@dabbelt.com, paul.walmsley@sifive.com, peterz@infradead.org, 
	philmd@linaro.org, rdunlap@infradead.org, rientjes@google.com, 
	rppt@kernel.org, ryan.roberts@arm.com, souravpanda@google.com, 
	svens@linux.ibm.com, tglx@linutronix.de, tzimmermann@suse.de, will@kernel.org, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 7:50=E2=80=AFAM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 07.08.24 13:32, David Hildenbrand wrote:
> > On 07.08.24 00:14, Pasha Tatashin wrote:
> >> nid is needed during memory hot-remove in order to account the
> >> information about the memmap overhead that is being removed.
> >>
> >> In addition, we cannot use page_pgdat(pfn_to_page(pfn)) during
> >> hotremove after remove_pfn_range_from_zone().
> >>
> >> We also cannot determine nid from walking through memblocks after
> >> remove_memory_block_devices() is called.
> >>
> >> Therefore, pass nid down from the beginning of hotremove to where
> >> it is used for the accounting purposes.
> >
> > I was happy to finally remove that nid parameter for good in:
> >
> > commit 65a2aa5f482ed0c1b5afb9e6b0b9e0b16bb8b616
> > Author: David Hildenbrand <david@redhat.com>
> > Date:   Tue Sep 7 19:55:04 2021 -0700
> >
> >       mm/memory_hotplug: remove nid parameter from arch_remove_memory()
> >
> > To ask the real question: Do we really need this counter per-nid at all=
?
> >
> > Seems to over-complicate things.
>
> Case in point: I think the handling is wrong?
>
> Just because some memory belongs to a nid doesn't mean that the vmemmap
> was allocated from that nid?

I believe when we hot-add we use nid for the memory that is being
added to account vmemmap, and when we do hot-remove we also use nid of
the memory that is being removed. But, you are correct, this does not
guarantee that the actual vmemmap memory is being allocated or removed
from the given nid.

> Wouldn't we want to look at the actual nid the vmemmap page belongs to
> that we are removing?

I am now looking into converting this counter to be system wide, i.e.
vm_event, it is all done under hotplug lock, so there is no
contention.

Pasha

