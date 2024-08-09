Return-Path: <linux-kernel+bounces-281533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5271294D7DD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 22:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6AFF1F2178F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 20:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE9A166317;
	Fri,  9 Aug 2024 20:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnGDYd68"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCF215EFD0;
	Fri,  9 Aug 2024 20:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723234156; cv=none; b=XFCwg/N1pJXB2tLjpIYzw6aqBYlnxsiCIZ7JKHX+v4AjulfCNVshvz0J4j2BWV7om9gN+A3pFXN6mep38ecYxKtkVyVRg93V3Ik1NUz3AXmYeOFcQbetCjyY0t7ubEbSUAOVLY3J7uagmrTCrHgqaGAcFsD5tdsFstXwDrrEGXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723234156; c=relaxed/simple;
	bh=YYL+Tm+xSF544+4Uj8jAxd5IyskAv/6PRlppzHw96O4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O4+NZNCFMEIiz8C8nY4kcKhWxYo4C8/3CV6xpbJf7J/DY6Io191beBGIKMORVMCZRdmaXBfBl6R30JA8UUtn/a1/uyZ1lFP1SZ7/AQlLZPtGzQC52gEH7LMjjbqkHzCOrLd+TUODVlLWMeMqwfPWzl/FcXv+HN4NJN8o6JZyRik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnGDYd68; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-530e2235688so2616063e87.3;
        Fri, 09 Aug 2024 13:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723234152; x=1723838952; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kbCw2OHW6bxgsmEaRNrnro77X+kz6gP2JISLqvSzSh0=;
        b=LnGDYd68ln/F2gt+QRRzJfvJgR8SFV3EBH32RB8jSkklmMvenKhLoYT+cVIN+64txA
         WL64yOJCKmiBGDtDv5kFYtQfvZcKKTOe5Tyx7K25ubqqKNwwNLz+7LBbCSA9g/0ZpOY2
         nGmWZF6JG6YVG9G+MebfTKNeqJAmBruO5Ya2RIGkLqbC/p1FHGVvmcnTVV3DurHtpr7A
         4ro2LJl7uTIp5JBb+Lis3y49iK1vb0TCMuuqdq8UJicZHhBr93vF+A2ESRmlZWw0KipA
         LC8tt0BoQENdUERnK5+/ST6c008OjJOLiw/eX6CymZj0PGsG4T/M68pjws3HS1W0XRy+
         q2Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723234152; x=1723838952;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kbCw2OHW6bxgsmEaRNrnro77X+kz6gP2JISLqvSzSh0=;
        b=OB8696L76Ewk+WqbKtP7Wx7c+aqVzbGHPOGsH1Y8SJ5GCFl4I1Ed6ApKuMwQKVrjaK
         zFbcdu/JIb4ytVklJwaswuyxai6YntdE1EedDybZii7q/a2hkHfHQ5rAf7z+46DqZMEW
         PbnYN/+oFbHltoSCgLEKqnh7pQm+PVB0gm8FCl0HLDPgINbNMNKdora0GPE3r/3tkcrQ
         S9azp58xkJ5DhduGB1REmM3qPHVRL12RbZaMVjM9aocY68BnGCjHK2UgYyJMWiJyE9Xz
         4X+7rOgY6euEZs8TG5/8h0o0AkXn099X8zgcillqqEcFMZvp5tuRWZbgxz5UE412VLv5
         dA4A==
X-Forwarded-Encrypted: i=1; AJvYcCWqJqexqQJd3q5Vr5LeJLHhcRNrexPLce20+bzop1quQHDw13fOu5AY/EryN3AFwv3e7Vyl4dcqS1EImTu4M20bAsuUE9+bpC50WPhmlZ3hyOpgSlmwHMtyjdc8E052QcOYCWegsXiUaQ==
X-Gm-Message-State: AOJu0YzieyfPnnjm7VEGrC9AjpZfRMMpZHUwIAL/iCGyeFooqWgVhDBV
	moTXrPQ19BNC0J8bj0Z50SyIidsddaTJJoTIOwoCU2Rlcl+ndGyn
X-Google-Smtp-Source: AGHT+IGtD9fwgDO1QCAG/TU600BWSqmUCV8VPZVyEjzxHLENlKiu3All+0Qr3XQg2RUdoCChrFj22w==
X-Received: by 2002:a05:6512:3b9c:b0:52e:76d5:9504 with SMTP id 2adb3069b0e04-530ee9909c6mr1999981e87.3.1723234151175;
        Fri, 09 Aug 2024 13:09:11 -0700 (PDT)
Received: from ?IPV6:2001:678:a5c:1202:4fb5:f16a:579c:6dcb? (soda.int.kasm.eu. [2001:678:a5c:1202:4fb5:f16a:579c:6dcb])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53200ec3abdsm21261e87.80.2024.08.09.13.09.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 13:09:10 -0700 (PDT)
Message-ID: <58ea9e04-d3a8-42e1-9cc3-18c8f141adaf@gmail.com>
Date: Fri, 9 Aug 2024 22:09:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/2] Dynamic Allocation of the reserved_mem array
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>, robh@kernel.org,
 saravanak@google.com
Cc: aisheng.dong@nxp.com, hch@lst.de, m.szyprowski@samsung.com,
 robin.murphy@arm.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, will@kernel.org,
 catalin.marinas@arm.com, kernel@quicinc.com
References: <20240809184814.2703050-1-quic_obabatun@quicinc.com>
Content-Language: en-US, sv-SE
From: Klara Modin <klarasmodin@gmail.com>
In-Reply-To: <20240809184814.2703050-1-quic_obabatun@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 2024-08-09 20:48, Oreoluwa Babatunde wrote:
> The reserved_mem array is used to store data for the different
> reserved memory regions defined in the DT of a device.  The array
> stores information such as region name, node reference, start-address,
> and size of the different reserved memory regions.
> 
> The array is currently statically allocated with a size of
> MAX_RESERVED_REGIONS(64). This means that any system that specifies a
> number of reserved memory regions greater than MAX_RESERVED_REGIONS(64)
> will not have enough space to store the information for all the regions.
> 
> This can be fixed by making the reserved_mem array a dynamically sized
> array which is allocated using memblock_alloc() based on the exact
> number of reserved memory regions defined in the DT.
> 
> On architectures such as arm64, memblock allocated memory is not
> writable until after the page tables have been setup.
> This is an issue because the current implementation initializes the
> reserved memory regions and stores their information in the array before
> the page tables are setup. Hence, dynamically allocating the
> reserved_mem array and attempting to write information to it at this
> point will fail.
> 
> Therefore, the allocation of the reserved_mem array will need to be done
> after the page tables have been setup, which means that the reserved
> memory regions will also need to wait until after the page tables have
> been setup to be stored in the array.
> 
> When processing the reserved memory regions defined in the DT, these
> regions are marked as reserved by calling memblock_reserve(base, size).
> Where:  base = base address of the reserved region.
> 	size = the size of the reserved memory region.
> 
> Depending on if that region is defined using the "no-map" property,
> memblock_mark_nomap(base, size) is also called.
> 
> The "no-map" property is used to indicate to the operating system that a
> mapping of the specified region must NOT be created. This also means
> that no access (including speculative accesses) is allowed on this
> region of memory except when it is coming from the device driver that
> this region of memory is being reserved for.[1]
> 
> Therefore, it is important to call memblock_reserve() and
> memblock_mark_nomap() on all the reserved memory regions before the
> system sets up the page tables so that the system does not unknowingly
> include any of the no-map reserved memory regions in the memory map.
> 
> There are two ways to define how/where a reserved memory region is
> placed in memory:
> i) Statically-placed reserved memory regions
> i.e. regions defined with a set start address and size using the
>       "reg" property in the DT.
> ii) Dynamically-placed reserved memory regions.
> i.e. regions defined by specifying a range of addresses where they can
>       be placed in memory using the "alloc_ranges" and "size" properties
>       in the DT.
> 
> The dynamically-placed reserved memory regions get assigned a start
> address only at runtime. And this needs to  be done before the page
> tables are setup so that memblock_reserve() and memblock_mark_nomap()
> can be called on the allocated region as explained above.
> Since the dynamically allocated reserved_mem array can only be
> available after the page tables have been setup, the information for
> the dynamically-placed reserved memory regions needs to be stored
> somewhere temporarily until the reserved_mem array is available.
> 
> Therefore, this series makes use of a temporary static array to store
> the information of the dynamically-placed reserved memory regions until
> the reserved_mem array is allocated.
> Once the reserved_mem array is available, the information is copied over
> from the temporary array into the reserved_mem array, and the memory for
> the temporary array is freed back to the system.
> 
> The information for the statically-placed reserved memory regions does
> not need to be stored in a temporary array because their starting
> address is already stored in the devicetree.
> Once the reserved_mem array is allocated, the information for the
> statically-placed reserved memory regions is added to the array.
> 
> Note:
> Because of the use of a temporary array to store the information of the
> dynamically-placed reserved memory regions, there still exists a
> limitation of 64 for this particular kind of reserved memory regions.
>  From my observation, these regions are typically small in number and
> hence I expect this to not be an issue for now.
> 
> Patch Versions:
> v7:
> - Make changes to initialize the reserved memory regions earlier in
>    response to issue reported in v6:
>    https://lore.kernel.org/all/20240610213403.GA1697364@thelio-3990X/
> 
> - For the reserved regions to be setup properly,
>    fdt_init_reserved_mem_node() needs to be called on each of the regions
>    before the page tables are setup. Since the function requires a
>    refernece to the devicetree node of each region, we are not able to
>    use the unflattened_devicetree APIs since they are not available until
>    after the page tables have been setup.
>    Hence, revert the use of the unflatten_device APIs as a result of this
>    limitation which was discovered in v6:
>    https://lore.kernel.org/all/986361f4-f000-4129-8214-39f2fb4a90da@gmail.com/
>    https://lore.kernel.org/all/DU0PR04MB9299C3EC247E1FE2C373440F80DE2@DU0PR04MB9299.eurprd04.prod.outlook.com/
> 
> v6:
> https://lore.kernel.org/all/20240528223650.619532-1-quic_obabatun@quicinc.com/
> - Rebased patchset on top of v6.10-rc1.
> - Addressed comments received in v5 such as:
>    1. Switched to using relevant typed functions such as
>       of_property_read_u32(), of_property_present(), etc.
>    2. Switched to using of_address_to_resource() to read the "reg"
>       property of nodes.
>    3. Renamed functions using "of_*" naming scheme instead of "dt_*".
> 
> v5:
> https://lore.kernel.org/all/20240328211543.191876-1-quic_obabatun@quicinc.com/
> - Rebased changes on top of v6.9-rc1.
> - Addressed minor code comments from v4.
> 
> v4:
> https://lore.kernel.org/all/20240308191204.819487-2-quic_obabatun@quicinc.com/
> - Move fdt_init_reserved_mem() back into the unflatten_device_tree()
>    function.
> - Fix warnings found by Kernel test robot:
>    https://lore.kernel.org/all/202401281219.iIhqs1Si-lkp@intel.com/
>    https://lore.kernel.org/all/202401281304.tsu89Kcm-lkp@intel.com/
>    https://lore.kernel.org/all/202401291128.e7tdNh5x-lkp@intel.com/
> 
> v3:
> https://lore.kernel.org/all/20240126235425.12233-1-quic_obabatun@quicinc.com/
> - Make use of __initdata to delete the temporary static array after
>    dynamically allocating memory for reserved_mem array using memblock.
> - Move call to fdt_init_reserved_mem() out of the
>    unflatten_device_tree() function and into architecture specific setup
>    code.
> - Breaking up the changes for the individual architectures into separate
>    patches.
> 
> v2:
> https://lore.kernel.org/all/20231204041339.9902-1-quic_obabatun@quicinc.com/
> - Extend changes to all other relevant architectures by moving
>    fdt_init_reserved_mem() into the unflatten_device_tree() function.
> - Add code to use unflatten devicetree APIs to process the reserved
>    memory regions.
> 
> v1:
> https://lore.kernel.org/all/20231019184825.9712-1-quic_obabatun@quicinc.com/
> 
> References:
> [1]
> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/reserved-memory/reserved-memory.yaml#L79
> 
> Oreoluwa Babatunde (2):
>    of: reserved_mem: Restruture how the reserved memory regions are
>      processed
>    of: reserved_mem: Add code to dynamically allocate reserved_mem array
> 
>   drivers/of/fdt.c             |   5 +-
>   drivers/of/of_private.h      |   3 +-
>   drivers/of/of_reserved_mem.c | 231 +++++++++++++++++++++++++++--------
>   3 files changed, 188 insertions(+), 51 deletions(-)
> 

I did not see anything suspicious on my relevant machines with this 
patch series (Raspberry Pi 1 and 3, Edgerouter 6P).

Regards,
Tested-by: Klara Modin <klarasmodin@gmail.com>

