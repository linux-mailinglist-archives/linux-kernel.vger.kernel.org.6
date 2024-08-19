Return-Path: <linux-kernel+bounces-292961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0874957715
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 00:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB8151C22AA8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 22:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794C31DB453;
	Mon, 19 Aug 2024 22:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLD/rkLT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A29D158D81;
	Mon, 19 Aug 2024 22:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724105086; cv=none; b=Hnki5u2YcyA6IqggGx+50DmEKHJALCdZLxmchnCdpPeRBV01m+hSZ99GvRvaPB4EIXcvERF+mYE+2EjyMsN+4p4QF4+VknUD0kZA/n5mKUS8wiol6R08jqp52CePpQPXSO1mFAak1iNCuTDbtHgn8KBvUXx2OSi1p5AgQXFKJ/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724105086; c=relaxed/simple;
	bh=O2+CqhRmpPugQ+4RnyA0V4X7jrOVXUbbDT0/XwJkavc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=srraEZnewfS0v9qXIv6KjPsbMO0RwkSkRxn/b9IZSyULrKKFaztAoUFHFCKBtcbQBp/reuE7LgA2MDX+VpWqYidTW/BvEwDf+nL0Wsrm8X4E0RnFQ4JQf49+DeR7Iv6xLFdY8ByvAWxmznENqmPVvY38gUoWXCz4LD6sSPGMDDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLD/rkLT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C795C4AF14;
	Mon, 19 Aug 2024 22:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724105086;
	bh=O2+CqhRmpPugQ+4RnyA0V4X7jrOVXUbbDT0/XwJkavc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RLD/rkLTY6NyhiChkzCP4wSluHFvYJRiSY7NRSfqqXCE8ubTOA8hK3FpbjsTnybhM
	 S4YvAm4WX3Q2Kcb8EDdkk4uEu4WI2yShiHdx8UxbXVQ+u+GQlijg0EuzKKJqWOugWA
	 RROwMR8yBtSmvTUqjEjLwU1/7f3cRfjNGE6Vh4pMb3OJvsUFICzmGhaNpNRSPJ1p6s
	 BKAc28LWfbN2Isl3jcn2hTKU5nAQmO/FxyKpbKPZWtAz3PqiGpFTojPIyEvyOhfoRf
	 B4UlOhNsXecd2F7CgYvo8PZwl0hxHQGNyUqWLXPNOyYU3eSFHPiegt4bkIAG3aIq+i
	 61bF+oHEwwRXg==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52efef496ccso4088924e87.1;
        Mon, 19 Aug 2024 15:04:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUWloa/QiaINzocR+55IM7bDMvRBQzyl24HqPdE6dKUd4UidHbDQZ6GZwZ0DGfmoJqdVCqTOZorTd36SQdc@vger.kernel.org, AJvYcCUeAjPkuoGFF++ugVWdeCq8lw0a9MlxbyeWjgFcp+5WyfdxBz9nqNZI7365ef09+YIesBNmPBPeOUIW@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+t/sJTpRVyYH36wmSLwoVTcMmpZthRuNw1TbiRk2e9DfWVwzV
	E+r+NdzXUSRArOZP0yvH04QxHp6YGh5ZlGAW3O4neXdzpCHcURivHDSwNMncNVThP9X9ug/MAZP
	4qYeYWTSeEXWV0vq60kn/j8+TZw==
X-Google-Smtp-Source: AGHT+IHYtijN7CreNT7SB8WnmJgcnOe20Rymlewrgo1iNEhleXWnNwHXwVoCONZ09ldNoIQ3ONhXmYFPT5mMVEsRYQU=
X-Received: by 2002:a05:6512:a95:b0:52f:31a:4c08 with SMTP id
 2adb3069b0e04-5333f1c3852mr294124e87.11.1724105084363; Mon, 19 Aug 2024
 15:04:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809184814.2703050-1-quic_obabatun@quicinc.com> <20240809184814.2703050-2-quic_obabatun@quicinc.com>
In-Reply-To: <20240809184814.2703050-2-quic_obabatun@quicinc.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 19 Aug 2024 17:04:32 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL=Pc7FJJevMskvYYOoYZYCKF+db9C2Y7_cm7DZNyTYPw@mail.gmail.com>
Message-ID: <CAL_JsqL=Pc7FJJevMskvYYOoYZYCKF+db9C2Y7_cm7DZNyTYPw@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] of: reserved_mem: Restruture how the reserved
 memory regions are processed
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Cc: saravanak@google.com, klarasmodin@gmail.com, aisheng.dong@nxp.com, 
	hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, will@kernel.org, catalin.marinas@arm.com, 
	kernel@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 1:48=E2=80=AFPM Oreoluwa Babatunde
<quic_obabatun@quicinc.com> wrote:
>
> Reserved memory regions defined in the devicetree can be broken up into
> two groups:
> i) Statically-placed reserved memory regions
> i.e. regions defined with a static start address and size using the
>      "reg" property.
> ii) Dynamically-placed reserved memory regions.
> i.e. regions defined by specifying an address range where they can be
>      placed in memory using the "alloc_ranges" and "size" properties.
>
> These regions are processed and set aside at boot time.
> This is done in two stages as seen below:
>
> Stage 1:
> At this stage, fdt_scan_reserved_mem() scans through the child nodes of
> the reserved_memory node using the flattened devicetree and does the
> following:
>
> 1) If the node represents a statically-placed reserved memory region,
>    i.e. if it is defined using the "reg" property:
>    - Call memblock_reserve() or memblock_mark_nomap() as needed.
>    - Add the information for that region into the reserved_mem array
>      using fdt_reserved_mem_save_node().
>      i.e. fdt_reserved_mem_save_node(node, name, base, size).
>
> 2) If the node represents a dynamically-placed reserved memory region,
>    i.e. if it is defined using "alloc-ranges" and "size" properties:
>    - Add the information for that region to the reserved_mem array with
>      the starting address and size set to 0.
>      i.e. fdt_reserved_mem_save_node(node, name, 0, 0).
>    Note: This region is saved to the array with a starting address of 0
>    because a starting address is not yet allocated for it.
>
> Stage 2:
> After iterating through all the reserved memory nodes and storing their
> relevant information in the reserved_mem array,fdt_init_reserved_mem() is
> called and does the following:
>
> 1) For statically-placed reserved memory regions:
>    - Call the region specific init function using
>      __reserved_mem_init_node().
> 2) For dynamically-placed reserved memory regions:
>    - Call __reserved_mem_alloc_size() which is used to allocate memory
>      for each of these regions, and mark them as nomap if they have the
>      nomap property specified in the DT.
>    - Call the region specific init function.
>
> The current size of the resvered_mem array is 64 as is defined by
> MAX_RESERVED_REGIONS. This means that there is a limitation of 64 for
> how many reserved memory regions can be specified on a system.
> As systems continue to grow more and more complex, the number of
> reserved memory regions needed are also growing and are starting to hit
> this 64 count limit, hence the need to make the reserved_mem array
> dynamically sized (i.e. dynamically allocating memory for the
> reserved_mem array using membock_alloc_*).
>
> On architectures such as arm64, memory allocated using memblock is
> writable only after the page tables have been setup. This means that if
> the reserved_mem array is going to be dynamically allocated, it needs to
> happen after the page tables have been setup, not before.
>
> Since the reserved memory regions are currently being processed and
> added to the array before the page tables are setup, there is a need to
> change the order in which some of the processing is done to allow for
> the reserved_mem array to be dynamically sized.
>
> It is possible to process the statically-placed reserved memory regions
> without needing to store them in the reserved_mem array until after the
> page tables have been setup because all the information stored in the
> array is readily available in the devicetree and can be referenced at
> any time.
> Dynamically-placed reserved memory regions on the other hand get
> assigned a start address only at runtime, and hence need a place to be
> stored once they are allocated since there is no other referrence to the
> start address for these regions.
>
> Hence this patch changes the processing order of the reserved memory
> regions in the following ways:
>
> Step 1:
> fdt_scan_reserved_mem() scans through the child nodes of
> the reserved_memory node using the flattened devicetree and does the
> following:
>
> 1) If the node represents a statically-placed reserved memory region,
>    i.e. if it is defined using the "reg" property:
>    - Call memblock_reserve() or memblock_mark_nomap() as needed.
>    - Call the region specific initialization function for the region
>      using fdt_init_reserved_mem_node().
>
> 2) If the node represents a dynamically-placed reserved memory region,
>    i.e. if it is defined using "alloc-ranges" and "size" properties:
>    - Call __reserved_mem_alloc_size() which will:
>      i) Allocate memory for the reserved region and call
>      memblock_mark_nomap() as needed.
>      ii) Call the region specific initialization function using
>      fdt_init_reserved_mem_node().
>      iii) Save the region information in the reserved_mem array using
>      fdt_reserved_mem_save_node().
>
> Step 2:
> 1) This stage of the reserved memory processing is now only used to add
>    the statically-placed reserved memory regions into the reserved_mem
>    array using fdt_scan_reserved_mem_reg_nodes().
>
> 2) This step is also moved to be after the page tables have been
>    setup. Moving this will allow us to replace the reserved_mem
>    array with a dynamically sized array before storing the rest of
>    these regions.
>
> Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
> ---
>  drivers/of/fdt.c             |   5 +-
>  drivers/of/of_private.h      |   3 +-
>  drivers/of/of_reserved_mem.c | 172 +++++++++++++++++++++++++----------
>  3 files changed, 131 insertions(+), 49 deletions(-)
>
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 68103ad230ee..d4b7aaa70e31 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -511,8 +511,6 @@ void __init early_init_fdt_scan_reserved_mem(void)
>                         break;
>                 memblock_reserve(base, size);
>         }
> -
> -       fdt_init_reserved_mem();
>  }
>
>  /**
> @@ -1239,6 +1237,9 @@ void __init unflatten_device_tree(void)
>         of_alias_scan(early_init_dt_alloc_memory_arch);
>
>         unittest_unflatten_overlay_base();
> +
> +       /* Save the statically-placed regions in the reserved_mem array *=
/
> +       fdt_scan_reserved_mem_reg_nodes();

I'm still not understanding why the unflatttened API doesn't work
here? It was just used in of_alias_scan() above here.

The problem reported is this function uses initial_boot_params, but
that's NULL for x86.

Rob

