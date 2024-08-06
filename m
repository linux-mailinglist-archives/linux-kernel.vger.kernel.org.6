Return-Path: <linux-kernel+bounces-277030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3971B949B55
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 00:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74277B25E04
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D63175D28;
	Tue,  6 Aug 2024 22:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="Bq/yUf1Y"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBDB170A1F
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 22:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722983565; cv=none; b=ShHeBaiAo9x+C/R8kedTCvunPP4rKZ8LuOQ8KL82TFrzxNXKF2djnW3HWqu5r+SLY99Yw3yWw4KbpG8CRJPwe25QmwAxeXIRp5kgF2CNBg7IWFqmrvysBtLSghyJ9FBsXybnv9dK1ARc4mBCyxg5/Axa+v8pxbpZUpSVgv9eZNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722983565; c=relaxed/simple;
	bh=AIFgqGTPqAlr+l3ZC0h5bu/U53+G2p+tdAkS9Efnj9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 Cc:Content-Type; b=YX/KM2KDdrZD/5wTEivLbD1hykK6B/VqTKPXzaU13aGe3w7yw20ejlKFxj3GFRocxYQCSBqgzfcv6+HyUSgOCCnqSJ5L+n16dZGPhBmUGk/T4xIaGZ6AA2wMjjEjBnU/gqJZUgzzFXgsluPxw1YeER+6KKGOUzXlZNh+Ky5D8ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=Bq/yUf1Y; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-44fff73f223so5442191cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 15:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1722983562; x=1723588362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GEKrh9oASaBtp3LjejtNI1CdLoHRrZQ/LRepCSn8ys0=;
        b=Bq/yUf1Yr62887em8Zj1uxN+hW540AwNNxNQ/dO/oOfVFs89uMMrAg6j/BRpR2FvGe
         /VwrGnoTk/tvcTXqqYvbhqdWGMCTjplUYqCFfzv6tdV2D3bQ1MYDs5PLSwYlJJFfXTfo
         PWh6yUi3np54W8Bmanns01UNoH6BZwZpgqQBzxowjzveVIIOw09Dqy2skmiwvyZRYeJu
         4u6ve1WL/G3SnZubASDi/m+jNT4bfl4UUP4Nm7Q+DIp09tU8XeHBwFmxTt4UE0wdg0BL
         admtH0hh8z9IqDj58wB016jzJTkSHKimqucchbm6AI9VYFm0oshqS41m3dtHlJxDgnyf
         6/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722983562; x=1723588362;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GEKrh9oASaBtp3LjejtNI1CdLoHRrZQ/LRepCSn8ys0=;
        b=jIfhOk+0CeEj3o+ju5yUyBk4Vqty4isUP8o0A3U2LSfE0btJ28xYHKQ3T1faLrkyGU
         DA0XxOMBfhAVW6+Mrsha0fLb4Dukm+kNt5jonQaNYuJy3eGZTqHVgOMf2XJa0HcHSc9p
         /SxvsatRcCXo8G7F4NIuQlKXQTxrsSL9evebgiIvlELZzU6DhcfU2rsUvNeCcQDWIBEZ
         YeQa8h4cuzrzTTtLEeZ4bm1IyEeVizhHRJWGk8J/x89SKuHkE5aXj5YDS0yT/YwXO0lq
         nDLhjqc+8Jwf/0JtHYzPp+sWazCp/BRfpwPan6YSTNxWru2qEbzfDK4sbwWBAxd/8Rrv
         SBSw==
X-Forwarded-Encrypted: i=1; AJvYcCXIISslKJGIS/n3EM0ZSrX0Y6XO0AbxOYUym/+JmuICECMNN7ShDFf3BWtUD3pLBXtQhSsiHmS8B8Azl3zUBq5AlAgcn0aAJJbjP/Au
X-Gm-Message-State: AOJu0Yx1OG6DhJvngQrcTE2zAb138RXBE23OUaZOVVRJkrCByPCPtV7H
	o3ICWm06/YiPi9tzigTcTHRW0rJXRxBhQiEegWUeMLxj/E/eX/1ShAwAWjdwJxogYA9DSWe4NKN
	NsZap91xOKmOYf4J6auXdoPEHi5YW72C/41GOMA==
X-Received: by 2002:ac8:5d0f:0:b0:447:ea77:6de0 with SMTP id
 d75a77b69052e-4518926f297mt189647111cf.13.1722983562494; Tue, 06 Aug 2024
 15:32:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605222751.1406125-1-souravpanda@google.com>
 <Zq0tPd2h6alFz8XF@aschofie-mobl2> <CA+CK2bAfgamzFos1M-6AtozEDwRPJzARJOmccfZ=uzKyJ7w=kQ@mail.gmail.com>
 <66b15addf1a80_c144829473@dwillia2-xfh.jf.intel.com.notmuch>
 <CA+CK2bC1ZsT3cuAMDAAUonys3BUxbb2JdnZXs1Ps3NbYZt5W2Q@mail.gmail.com>
 <ZrKNKRfaH7GliS3C@iweiny-mobl> <CA+CK2bDnJsgjK-7H-8qJjdeejKJk7E7m-SDnwXatH4FHr4R0_g@mail.gmail.com>
In-Reply-To: <CA+CK2bDnJsgjK-7H-8qJjdeejKJk7E7m-SDnwXatH4FHr4R0_g@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 6 Aug 2024 18:32:05 -0400
Message-ID: <CA+CK2bChNfuFR3jnFo-iyHiJ0inUGNBgtLXC7o5pgfCN-534AA@mail.gmail.com>
Subject: Re: [PATCH v13] mm: report per-page metadata information
Cc: Dan Williams <dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Sourav Panda <souravpanda@google.com>, corbet@lwn.net, gregkh@linuxfoundation.org, 
	rafael@kernel.org, akpm@linux-foundation.org, mike.kravetz@oracle.com, 
	muchun.song@linux.dev, rppt@kernel.org, david@redhat.com, 
	rdunlap@infradead.org, chenlinxuan@uniontech.com, yang.yang29@zte.com.cn, 
	tomas.mudrunka@gmail.com, bhelgaas@google.com, ivan@cloudflare.com, 
	yosryahmed@google.com, hannes@cmpxchg.org, shakeelb@google.com, 
	kirill.shutemov@linux.intel.com, wangkefeng.wang@huawei.com, 
	adobriyan@gmail.com, vbabka@suse.cz, Liam.Howlett@oracle.com, 
	surenb@google.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	willy@infradead.org, weixugc@google.com, David Rientjes <rientjes@google.com>, 
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, yi.zhang@redhat.com, 
	ira.weiny@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 5:37=E2=80=AFPM Pasha Tatashin <pasha.tatashin@solee=
n.com> wrote:
>
> On Tue, Aug 6, 2024 at 4:53=E2=80=AFPM Ira Weiny <iweiny@iweiny-mobl> wro=
te:
> >
> > On Tue, Aug 06, 2024 at 01:59:54PM -0400, Pasha Tatashin wrote:
> > > On Mon, Aug 5, 2024 at 7:06=E2=80=AFPM Dan Williams <dan.j.williams@i=
ntel.com> wrote:
> > > >
> > > > Pasha Tatashin wrote:
> > > > [..]
> > > > > Thank you for the heads up. Can you please attach a full config f=
ile,
> > > > > also was anyone able to reproduce this problem in qemu with emula=
ted
> > > > > nvdimm?
> > > >
> > > > Yes, I can reproduce the crash just by trying to reconfigure the mo=
de of
> > > > a pmem namespace:
> > > >
> > > > # ndctl create-namespace -m raw -f -e namespace0.0
> > > >
> > > > ...where namespace0.0 results from:
> > > >
> > > >     memmap=3D4G!4G
> > > >
> > > > ...passed on the kernel command line.
> > > >
> > > > Kernel config here:
> > > >
> > > > https://gist.github.com/djbw/143705077103d43a735c179395d4f69a
> > >
> > > Excellent, I was able to reproduce this problem.
> > >
> > > The problem appear to be caused by this code:
> > >
> > > Calling page_pgdat() in depopulate_section_memmap():
> > >
> > > static void depopulate_section_memmap(unsigned long pfn, unsigned lon=
g nr_pages,
> > >                 struct vmem_altmap *altmap)
> > > {
> > >         unsigned long start =3D (unsigned long) pfn_to_page(pfn);
> > >         unsigned long end =3D start + nr_pages * sizeof(struct page);
> > >
> > >         mod_node_page_state(page_pgdat(pfn_to_page(pfn)), NR_MEMMAP,
> > > <<<< We cannot do it.
> > >                             -1L * (DIV_ROUND_UP(end - start, PAGE_SIZ=
E)));
> > >         vmemmap_free(start, end, altmap);
> > > }
> > >
> > > The page_pgdat() returns NULL starting from:
> > > pageunmap_range()
> > >     remove_pfn_range_from_zone() <- page is removed from the zone.
> >
> > Is there any idea on a fix?  I'm seeing the same error.
> >
> > [  561.867431]  ? mod_node_page_state+0x11/0xa0
> > [  561.867963]  section_deactivate+0x2a0/0x2c0
> > [  561.868496]  __remove_pages+0x59/0x90
> > [  561.868975]  arch_remove_memory+0x1a/0x40
> > [  561.869491]  memunmap_pages+0x206/0x3d0
> > [  561.869972]  devres_release_all+0xa8/0xe0
> > [  561.870466]  device_unbind_cleanup+0xe/0x70
> > [  561.870960]  device_release_driver_internal+0x1ca/0x210
> > [  561.871529]  driver_detach+0x47/0x90
> > [  561.871981]  bus_remove_driver+0x6c/0xf0
> >
> > Shall we revert this patch until we figure out a fix?
>
> I am working on a fix, and will send it out in a couple hours.

Patch is posted:
https://lore.kernel.org/all/20240806221454.1971755-2-pasha.tatashin@soleen.=
com/#r

>
> Pasha

