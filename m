Return-Path: <linux-kernel+bounces-215043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E78908DAC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F2D81F244F7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA1310979;
	Fri, 14 Jun 2024 14:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhZLySUa"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901E017C96
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 14:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718376105; cv=none; b=UKiIPK/A+zY8RB4O/haV44ZYeRKGi1O5fK54ezrpsy9CO5AYS4osUF3ON1KuGhWH2k6UZqJlLLUQVVaOtqJUZagMTrfpGs1AIrX8IHLoTXKC+yGaF6FLQYe2j7tke7EPJ2Av1AGZE+SylAjRDPeUiKD1S/5TMiO2B3PzbfD5Zu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718376105; c=relaxed/simple;
	bh=y9OQe3qr0Gx7VmAgMDXRnMq83su/FNL55wFDYVVmHu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EYDlskrVTHszlhxVCvAFGhqLGML7hdabNpdI2Gye0SLcG9UGh2z5AOxioM3ZniG2fCmWWC0vd/7IOD4a8XKLbIeva5AW7T8EUzbNn3aFt8m38nCzbm/AKJ6Xt2urQr9SvDYz6j3BeVfd2BtM34o8YDMMNSQBYrbvo+Sew7e6gjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XhZLySUa; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57c61165af6so2826531a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 07:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718376102; x=1718980902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=COgeoGHN66/htY8IBJh9awShJLxDqgPRVGYjDpSp0Z8=;
        b=XhZLySUaFgkMWQE8tOOuW6HyrFbE3oxv5k3s09gf6L+oBqXMfJfj0qu8V2UhrpEAhR
         pGt1JcQ3PYaL3J+4fsbWxlMJgJ01IpHVntEStS+K0TKKRZepmXNxP52GyrQQygJfPL4J
         FnDaJoRmQv7kijQdH4BSdEGoNwj98uuVCfAA0hyHoiwkspaszhp0+fn683oMSqciUo8I
         iJCmJW5N/5wBxZba2SVyiyfOOs2ZBos5PtBd6Rm83+7J9Hd2JBuq4KoGrpweYU1WTlGG
         qKm2wigoJJFLtHlBaRxxDDAbQY49zSAFNdC1roH3XIdHlulEshz/9lAoL308sNDkrJT5
         jDFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718376102; x=1718980902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=COgeoGHN66/htY8IBJh9awShJLxDqgPRVGYjDpSp0Z8=;
        b=wB/z+6+D+wKeBNWQl4aJ982C1uogHaBaFGCFgLpoxjEM1fTNuP6QLHTfqe54LxxAYZ
         9cB+FbFU42F8PDr+FCeyrYY+x5R66qz30X28UO/y1RclrIb06NgIQzBRUNo+9whi3R2U
         xRTDaAGHiEoiynyvtpfLlzXlUqL4wffSyaVt9QXUfiROMMBrL/1i+C+z4DmR9+3a6ez7
         hwGE/VTSPZ4Yc4ybA4cKxNuW9anA3uPNPgqhO3Fzw/r5aqmHKydRzmCoX98M74niIlNA
         z8TMEPdUnxhM6P5pctaAVdMmO6tfZ0YqBqMLXkpvyUSxKSysKMDRJb+nVkzRAMwr+dRd
         EUiw==
X-Forwarded-Encrypted: i=1; AJvYcCUUbwReSudgoLjUNF+UITFqVv4tuSCkkSdRLc524QF6AUzS7chcYrphR7oVuwJQqMuTdRXWUlie8NQXlST+G2SR9wwki+Cf8v3Gzh+k
X-Gm-Message-State: AOJu0YxCX4WjJZeflkwjsWYlMZ6VlVwrw0rnsM58n4nyniG5emewfQE1
	faXn9yvSDOgs1uRmoJ8/xxazTOTGxjvoWPcMudnnvTw0sfzmcVkfwItIRjU2sOHSIIZfx16CpzE
	bQykVkAehrn3nPv9A/oim6mbko0w=
X-Google-Smtp-Source: AGHT+IHKnx5pwExZmiV5+F1hrfOVQZ5WnJv4drqjDxmRh5En5uNxZYiys302f0rNtLAOKTP99lAsXaV87+xm2u5vNp8=
X-Received: by 2002:a50:d59e:0:b0:57c:9d54:67d5 with SMTP id
 4fb4d7f45d1cf-57cbd8f2946mr1852528a12.29.1718376101681; Fri, 14 Jun 2024
 07:41:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614015138.31461-1-ioworker0@gmail.com> <20240614015138.31461-3-ioworker0@gmail.com>
 <222F10CF-99B0-41F5-AB59-5E65F38B4AEF@nvidia.com>
In-Reply-To: <222F10CF-99B0-41F5-AB59-5E65F38B4AEF@nvidia.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Fri, 14 Jun 2024 22:41:27 +0800
Message-ID: <CAK1f24m7uHpPa75acP_-hHh5bcStegtQJY_2rDqpKeviUhBdzg@mail.gmail.com>
Subject: Re: [PATCH v8 2/3] mm/rmap: integrate PMD-mapped folio splitting into
 pagewalk loop
To: Zi Yan <ziy@nvidia.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, sj@kernel.org, 
	baolin.wang@linux.alibaba.com, maskray@google.com, ryan.roberts@arm.com, 
	david@redhat.com, 21cnbao@gmail.com, mhocko@suse.com, fengwei.yin@intel.com, 
	zokeefe@google.com, shy828301@gmail.com, xiehuan09@gmail.com, 
	libang.li@antgroup.com, wangkefeng.wang@huawei.com, songmuchun@bytedance.com, 
	peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 10:26=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>
> On 13 Jun 2024, at 21:51, Lance Yang wrote:
>
> > In preparation for supporting try_to_unmap_one() to unmap PMD-mapped
> > folios, start the pagewalk first, then call split_huge_pmd_address() to
> > split the folio.
> >
> > Suggested-by: David Hildenbrand <david@redhat.com>
> > Suggested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > Signed-off-by: Lance Yang <ioworker0@gmail.com>
> > ---
> >  include/linux/huge_mm.h |  6 ++++++
> >  include/linux/rmap.h    | 24 +++++++++++++++++++++++
> >  mm/huge_memory.c        | 42 +++++++++++++++++++++--------------------
> >  mm/rmap.c               | 21 +++++++++++++++------
> >  4 files changed, 67 insertions(+), 26 deletions(-)
>
> Thanks.
>
> Acked-by: Zi Yan <ziy@nvidia.com>

Thanks for taking time to review!
Lance

>
> --
> Best Regards,
> Yan, Zi

