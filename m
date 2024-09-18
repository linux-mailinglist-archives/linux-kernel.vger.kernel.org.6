Return-Path: <linux-kernel+bounces-332238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C794F97B718
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 05:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58D7A1F24143
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 03:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288B88175B;
	Wed, 18 Sep 2024 03:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8WKxh7B"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220059443;
	Wed, 18 Sep 2024 03:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726630872; cv=none; b=Z+g0QjPIPaZVMwo/oVL9iE7ve9hiVqAG2S7zLpmBiRB0l+AYi8F8NIkS1WFNBp1JHlYthR7qmnyjrWGNzdfC2kX6jMFqSaUPdVA0tAI57zCPE/pq0XK5HYIFtPtLANO+8DZQHXhBuDLKGpPI5kvj07JWx7uQQE3LUqnyitvB3jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726630872; c=relaxed/simple;
	bh=bCZzPZWYqHZn5+UdRM0N5JRaIv9is9gDLjo/UcOfl8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g6wXv8RoRhR/ghahECKWug3eNzxPcFKN9rf19VuFgmUb1gri+nBlAHS/2UezVQF0cEuDoh2sHSnXZxO6UzxivFWJNypjgjjrtuf2gVtBRoHxfgj3bKh4NWNaD0XvBC4tgTG8d1yiPOeLur9kpGRkOh5BP6OXP2lsy3At12mfNLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B8WKxh7B; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2d889207d1aso4361159a91.3;
        Tue, 17 Sep 2024 20:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726630869; x=1727235669; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vcv/wo/bsMetwVjkv0KW8azRBxyeY1GL5eezQ0r8Ihk=;
        b=B8WKxh7BiZmqobwp+CFr+/q/C2cT7Iw8YTkt3WnL/UFCmRNqzVR6RtTdlRmD8tE33b
         R94UeaurQIbdyl5tM8oUOfR70NMv8vOU06QfU2GyqrZkhdsv95hLzqhUqZppZrofklBb
         L4dd6Cp8FI0swgZCx0UYeET73DDvDD8D+0arW1PjlIgt9y+BaPp/L5ENJyqG6pT5j+1p
         QWvjbkkr74kmRheNORyyjKtGzKJB+gIC2LE+qL0T3kZDyWipzb7iaNNpbKCmpQWJ0NHZ
         b37Rl+R0mMKvtFfdRdB35kvjTQ+qSmi3KHAVh9yUbUTDYwN1pPzqp38EG4IBcwgOo0mA
         TZ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726630869; x=1727235669;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vcv/wo/bsMetwVjkv0KW8azRBxyeY1GL5eezQ0r8Ihk=;
        b=uSZ0FD2zWbwELTpbtQgfTXjzXwRnJI/D3rUFj5xCUiKoQqHhJYzJjsHFP1PHAanrYu
         bvE1isFI+ogx5bYu2tBL0adY9C9/HW9eR8s7/zfwG2cjFgAPXrnb0wUMjPbFm55NLGVy
         L73WjMrwHmG9HKCbq440eLAZqKdV+UKbskzCrvYQitQrLf/iZFN1cSsadDz/sVy3Y733
         XvM1TQLlhZgivGCjs2UWT+n1h+faFPfXCSe0YK5f2PbwtoRhB1CSepG+PYw1ekRvMMIJ
         IVZJxsUTzm9dPyFl45nCRT9N1J9874r8g+glrNN8VSGpvPTe4swgJ8/qPoE4/BiiaTjC
         TCxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjgjprwRwqTfLU2UTAM4ggTLjyv+uJw5IQpw/QROPVSs5q6LJbzPqmFYt/OPYFijE/JOHDzrQDV7HuKfNq@vger.kernel.org, AJvYcCWqPeGxZsKpDRj5MbzfVfzih9AVABZAjwiJJuXvnhsuKyUTAO1FT40VLFB/GXavvGllyp63K1/Y6xI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoDFnCaWzbkHc/ImOK9x7E2HlSdGmXKrCx0oa2KJMlv0UXmOmm
	N7f8xKSCUSQ0rqGIvF7bEp14B9oN+qjSIlkvweq5EbvT5SKkJUae
X-Google-Smtp-Source: AGHT+IF+fGqCPQuKTDIXFR92LSfntLTVIBfqHAcvcsOsdq2K9ewc2a3xxGh0Qv3JVH7jlK/Nza3lGg==
X-Received: by 2002:a17:90b:4a4a:b0:2d3:d398:3c1e with SMTP id 98e67ed59e1d1-2dba0082fb8mr26040856a91.36.1726630869018;
        Tue, 17 Sep 2024 20:41:09 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd6085a21asm321596a91.2.2024.09.17.20.41.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2024 20:41:08 -0700 (PDT)
Message-ID: <41b27a38-37b8-4411-adf9-2870cccf8878@gmail.com>
Date: Wed, 18 Sep 2024 11:41:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Docs/zh_CN: Translate physical_memory.rst to
 Simplified Chinese
To: jiang.kun2@zte.com.cn, alexs@kernel.org, siyanteng@loongson.cn,
 corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: wang.yaxin@zte.com.cn, fan.yu9@zte.com.cn, xu.xin16@zte.com.cn,
 he.peilin@zte.com.cn, tu.qiang35@zte.com.cn, qiu.yutan@zte.com.cn,
 zhang.yunkai@zte.com.cn
References: <20240918100712484feE1sZoJLFvOnK2pB5LqQ@zte.com.cn>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <20240918100712484feE1sZoJLFvOnK2pB5LqQ@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 9/18/24 10:07 AM, jiang.kun2@zte.com.cn wrote:
> From: Yaxin Wang <wang.yaxin@zte.com.cn>
> This patch translates the "physical_memory.rst" document into
> Simplified Chinese to improve accessibility for Chinese-speaking
> developers and users.
> 
> The translation was done with attention to technical accuracy
> and readability, ensuring that the document remains informative
> and useful in its translated form.
> 
> Signed-off-by: Yaxin Wang <wang.yaxin@zte.com.cn>

I failed to apply this patch on linus/master or next/master branch,
Is it ok on your side?

And could you please adjust your context alignment, make it more neat? 

Thanks
> ---
> v2->v3:
> Some fixes according to:
> https://lore.kernel.org/all/6ad87d5f-a1c6-4d41-9ca4-41bd84907463@linux.dev/
> 1. added the index for physical_memory.rst in the index.rst.
> 2. changed the subject prefix into &apos;Docs/zh_CN: Translate physical_memory.rst
> to Simplified&apos; instead of &apos;Documentation/mm: Translate physical_memory.rst to Simplified&apos;
> 3. this page display correctly in a web browser after running the &apos;make htmldocs&apos;.
> 
> Documentation/translations/zh_CN/mm/index.rst |   1 +
> ../translations/zh_CN/mm/physical_memory.rst | 330 ++++++++++++++++++
> 2 files changed, 331 insertions(+)
> create mode 100644 Documentation/translations/zh_CN/mm/physical_memory.rst
> 
> diff --git a/Documentation/translations/zh_CN/mm/index.rst b/Documentation/translations/zh_CN/mm/index.rst
> index b950dd118be7..eac20a7ec9a6 100644
> --- a/Documentation/translations/zh_CN/mm/index.rst
> +++ b/Documentation/translations/zh_CN/mm/index.rst
> @@ -53,6 +53,7 @@ Linux内存管理文档
> page_migration
> page_owner
> page_table_check
> +   physical_memory
> remap_file_pages
> split_page_table_lock
> vmalloced-kernel-stacks
> diff --git a/Documentation/translations/zh_CN/mm/physical_memory.rst b/Documentation/translations/zh_CN/mm/physical_memory.rst
> new file mode 100644
> index 000000000000..7d9f4c12146a
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/mm/physical_memory.rst
> @@ -0,0 +1,330 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. include:: ../disclaimer-zh_CN.rst
> +
> +:Original: Documentation/mm/physical_memory.rst
> +
> +:翻译:
> +
> +   王亚鑫 Yaxin Wang <wang.yaxin@zte.com.cn>
> +
> +========
> +物理内存
> +========
> +
> +Linux可用于多种架构，因此需要一个与架构无关的抽象来表示物理内存。本章描述了管理运行系统
> +中物理内存的结构。
> +
> +第一个与内存管理相关的主要概念是`非一致性内存访问(NUMA)
> +<https://en.wikipedia.org/wiki/Non-uniform_memory_access>`
> +
> +在多核和多插槽机器中，内存可能被组织成不同的存储区，这些存储区根据与处理器的
> +“不同”而有不同的访问开销。例如，可能为每个CPU分配内存存储区，或者为外围设备
> +在附近分配一个非常适合DMA的内存存储区。
> +
> +每个存储区被称为一个节点，节点在Linux中表示为 ``struct pglist_data``，即使是在UMA架构中
> +也是这样表示。该结构总是通过 ``pg_data_t`` 来引用。特定节点的 ``pg_data_t`` 结构体可以通过
> +NODE_DATA(nid)引用，其中nid被称为该节点的ID。
> +
> +对于非一致性内存访问（NUMA）架构，节点数据结构在引导时由特定于架构的代码早期分配。通常，这些
> +结构在他们所在的内存区上本地分配。对于一致性内存访问（UMA）架构，只使用一个静态的 ``pg_data_t``
> +结构体，称为 ``contig_page_data``。节点将会在 :ref:`节点 <nodes>` 章节中进一步讨论。
> +
> +整个物理内存被划分为一个或多个被称为区域的块，这些区域表示内存的范围。这些范围通常由访问内存
> +的架构限制来决定。在节点内，与特定区域对应的内存范围由 ``struct zone`` 结构体描述，该结构被定义为
> +``zone_t``，每种区域都属于以下描述类型的一种。
> +
> +* ``ZONE_DMA`` 和 ``ZONE_DMA32`` 在历史上代表适用于DMA的内存，这些内存由那些不能访问所
> +  有可寻址内存的外设访问。多年来，已经有了更好、更稳固的接口来获取满足特定DMA需求的内存（这些
> +  接口由 Documentation/core-api/dma-api.rst 文档描述），但是 ``ZONE_DMA`` 和 ``ZONE_DMA32``
> +  仍然表示访问受限的内存范围。
> +
> +取决于架构的不同，这两种区域可以在构建时通过关闭 ``CONFIG_ZONE_DMA`` 和 ``CONFIG_ZONE_DMA32`` 配置选项
> +来禁用。一些64位的平台可能需要这两种区域，因为他们支持具有不同DMA寻址限制的外设。
> +
> +* ``ZONE_NORMAL`` 是普通内存的区域，这种内存可以被内核随时访问。如果DMA设备支持将
> +  数据传输到所有可寻址的内存区域，那么可以在该区域的页面上执行DMA操作。 ``ZONE_NORMAL`` 总是开启的。
> +
> +* ``ZONE_HIGHMEM`` 是指那些没有在内核页表中永久映射的物理内存部分。该区域的内存只能
> +  通过临时映射被内核访问。该区域只在某些32位架构上可用，并且是通过 ``CONFIG_HIGHMEM`` 选项开启。
> +
> +* ``ZONE_MOVABLE`` 是用于可访问的普通内存区域，就像 ``ZONE_NORMAL`` 一样。不同之处在于
> +  ``ZONE_MOVABLE`` 中的大多数页面内容是可移动的。这意味着这些页面的虚拟地址不会改变，
> +  但它们的内容可能会在不同的物理 页面之间移动。通常，在内存热插拔期间填充 ``ZONE_MOVABLE``，
> +  在启动时也可以使用 ``kernelcore`` 、 ``movablecore`` 和 ``movable_node``
> +  这些内核命令行参数来填充。有关更多详细信息，请参阅内核文档
> +  Documentation/mm/page_migration.rst 和
> +  Documentation/admin-guide/mm/memory-hotplug.rst。
> +
> +* ``ZONE_DEVICE`` 表示位于诸如持久性内存（PMEM）和图形处理单元（GPU）等设备上的
> +  内存。它与RAM区域类型有不同的特性，并且它的存在是为了提供 :ref:`struct page<Pages>`
> +  结构和内存映射服务，以便设备驱动程序能识别物理地址范围。 ``ZONE_DEVICE`` 通过配置选项
> +  ``CONFIG_ZONE_DEVICE`` 开启。
> +
> +需要注意的是，许多内核操作只能使用 ``ZONE_NORMAL`` 来执行，因此它是性能最关键区域。
> +区域在 :ref:`区域 <zones>` 节中有更详细的讨论。
> +
> +节点和区域范围之间的关系由固件报告的物理内存映射决定，另外也由内存寻址的架构约束
> +以及内核命令行中的某些参数决定。
> +
> +例如，在具有2GB RAM的x86统一内存架构（UMA）机器上运行32位内核时，整个内存将
> +位于节点0，并且将有三个区域： ``ZONE_DMA``、 ``ZONE_NORMAL`` 和 ``ZONE_HIGHMEM``::
> +
> +  0                                                            2G
> +  +-------------------------------------------------------------+
> +  |                            node 0                           |
> +  +-------------------------------------------------------------+
> +
> +  0         16M                    896M                        2G
> +  +----------+-----------------------+--------------------------+
> +  | ZONE_DMA |      ZONE_NORMAL      |       ZONE_HIGHMEM       |
> +  +----------+-----------------------+--------------------------+
> +
> +
> +在内核构建时关闭 ``ZONE_DMA`` 开启 ``ZONE_DMA32``，并且在具有16GB RAM平均分配在两个节点
> +上的arm64机器上，使用 ``movablecore=80%`` 参数启动时， ``ZONE_DMA32`` 、
> +``ZONE_NORMAL`` 和 ``ZONE_MOVABLE`` 位于节点0，而 ``ZONE_NORMAL`` 和
> +``ZONE_MOVABLE`` 位于节点1::
> +
> +
> + 1G                                9G                         17G
> +  +--------------------------------+ +--------------------------+
> +  |              node 0            | |          node 1          |
> +  +--------------------------------+ +--------------------------+
> +
> +  1G       4G        4200M          9G          9320M          17G
> +  +---------+----------+-----------+ +------------+-------------+
> +  |  DMA32  |  NORMAL  |  MOVABLE  | |   NORMAL   |   MOVABLE   |
> +  +---------+----------+-----------+ +------------+-------------+
> +
> +
> +内存存储区可能位于交错的节点。在下面的例子中，一台x86机器有16GB的RAM分布在4个内存存储区上，偶数编号的内存存储区
> +属于节点0，奇数编号的内存条属于节点1::
> +
> +  0              4G              8G             12G            16G
> +  +-------------+ +-------------+ +-------------+ +-------------+
> +  |    node 0   | |    node 1   | |    node 0   | |    node 1   |
> +  +-------------+ +-------------+ +-------------+ +-------------+
> +
> +  0   16M      4G
> +  +-----+-------+ +-------------+ +-------------+ +-------------+
> +  | DMA | DMA32 | |    NORMAL   | |    NORMAL   | |    NORMAL   |
> +  +-----+-------+ +-------------+ +-------------+ +-------------+
> +
> +在这种情况下，节点0将覆盖从0到12GB的内存范围，而节点1将覆盖从4GB到16GB的内存范围。
> +
> +.. _nodes:
> +
> +节点
> +====
> +
> +正如我们所提到的，内存中的每个节点都由 ``pg_data_t`` 描述，它是由 ``struct pglist_data`` 结构体的类型定义。
> +在分配页面时，默认情况下，Linux使用节点本地分配策略，从离当前运行CPU的最近节点分配内存。由于进程倾向于在同一个
> +CPU上运行，很可能会使用当前节点的内存。分配策略可以由用户控制，如内核文档
> +Documentation/admin-guide/mm/numa_memory_policy.rst 中所述。
> +
> +大多数NUMA（非统一内存访问）架构维护了一个指向节点结构的指针数组。这些实际的结构在启动过程中的早期被分配，
> +这时特定于架构的代码解析了固件报告的物理内存映射。节点初始化的大部分工作是在由 free_area_init()实现的启
> +动过程之后完成，该函数在后面的小节 :ref:`初始化 <initialization>` 中有详细描述。
> +
> +除了节点结构，内核还维护了一个名为 ``node_states`` 的 ``nodemask_t`` 位掩码数组。这个数组中的每个位掩码
> +代表一组特定属性的节点，这些属性由 ``enum node_states`` 定义，定义如下：
> +
> +``N_POSSIBLE``
> +节点可能在某个时刻上线。
> +
> +``N_ONLINE``
> +节点已经上线。
> +
> +``N_NORMAL_MEMORY``
> +节点拥有普通内存。
> +
> +``N_HIGH_MEMORY``
> +节点拥有普通或高端内存。当关闭 ``CONFIG_HIGHMEM`` 配置时，也可以称为 ``N_NORMAL_MEMORY`` 。
> +
> +``N_MEMORY``
> +节点拥有（普通、高端、可移动）内存。
> +
> +``N_CPU``
> +节点拥有一个或多个CPU。
> +
> +对于具有上述属性的每个节点， ``node_states[<property>]`` 掩码中对应于节点ID的位会被置位。
> +
> +例如，对于具有常规内存和CPU的节点2，第二个bit将被设置::
> +
> +  node_states[N_POSSIBLE]
> +  node_states[N_ONLINE]
> +  node_states[N_NORMAL_MEMORY]
> +  node_states[N_HIGH_MEMORY]
> +  node_states[N_MEMORY]
> +  node_states[N_CPU]
> +
> +有关使用节点掩码（nodemasks）可能进行的各种操作，请参考 ``include/linux/nodemask.h``。
> +
> +除此之外，节点掩码（nodemasks）提供用于遍历节点的宏，即 ``for_each_node()`` 和
> + ``for_each_online_node()``。
> +
> +例如，要为每个在线节点调用函数 foo()，可以这样操作::
> +
> +  for_each_online_node(nid) {
> +		  pg_data_t *pgdat = NODE_DATA(nid);
> +
> +		  foo(pgdat);
> +	}
> +
> +节点数据结构
> +------------
> +
> +节点结构 ``struct pglist_data`` 在 ``include/linux/mmzone.h`` 中声明。这里我们将简要描述
> +这个结构体的字段：
> +
> +通用字段
> +~~~~~~~~
> +
> +``node_zones``
> +表示该节点的区域列表。并非所有区域都可能被填充，但这是完整的列表。它被该节点的node_zonelists以及其它
> +节点的node_zonelists引用。
> +
> +``node_zonelists``
> +所有节点中所有区域的列表。此列表定义了分配内存时首选的区域顺序。 ``node_zonelists`` 在核心内存管理
> +结构初始化期间，由 ``mm/page_alloc.c`` 中的 ``build_zonelists()`` 函数设置。
> +
> +``nr_zones``
> +表示此节点中已填充区域的数量。
> +
> +``node_mem_map``
> +对于使用FLATMEM内存模型的UMA系统，0号节点的 ``node_mem_map`` 表示每个物理帧的struct pages数组。
> +
> +``node_page_ext``
> +对于使用FLATMEM内存模型的UMA系统，0号节点的 ``node_page_ext`` 是struct pages的扩展数组。
> +只有在构建时开启了 ``CONFIG_PAGE_EXTENSION`` 选项的内核中才可用。
> +
> +``node_start_pfn``
> +表示此节点中起始页面帧的页面帧号。
> +
> +``node_present_pages``
> +表示此节点中存在的物理页面的总数。
> +
> +``node_spanned_pages``
> +表示包括空洞在内的物理页面范围的总大小。
> +
> +``node_size_lock``
> +一个保护定义节点范围字段的锁。仅在开启了 ``CONFIG_MEMORY_HOTPLUG`` 或
> +``CONFIG_DEFERRED_STRUCT_PAGE_INIT`` 配置选项中的某一个时才定义。提供了
> +``pgdat_resize_lock()`` 和 ``pgdat_resize_unlock()`` 用来操作 ``node_size_lock``，
> +而无需检查 ``CONFIG_MEMORY_HOTPLUG`` 或 ``CONFIG_DEFERRED_STRUCT_PAGE_INIT`` 选项。
> +
> +``node_id``
> +节点的节点ID（NID），从0开始。
> +
> +``totalreserve_pages``
> +这是每个节点保留的页面，这些页面不可用于用户空间分配。
> +
> +``first_deferred_pfn``
> +如果大型机器上的内存初始化被推迟，那么第一个PFN（页帧号）是需要初始化的。在开启了
> +``CONFIG_DEFERRED_STRUCT_PAGE_INIT`` 选项时定义。
> +
> +``deferred_split_queue``
> +每个节点的大页队列，这些大页的拆分被推迟了。仅在开启了 ``CONFIG_TRANSPARENT_HUGEPAGE``
> +配置选项时定义。
> +
> +``__lruvec``
> +每个节点的lruvec持有LRU（最近最少使用）列表和相关参数。仅在禁用了内存控制组（cgroups）
> +时使用。它不应该直接访问，而应该使用 ``mem_cgroup_lruvec()`` 来查找 lruvecs。
> +
> +回收控制
> +~~~~~~~~
> +
> +另见内核文档 Documentation/mm/page_reclaim.rst 文件。
> +
> +``kswapd``
> +每个节点的kswapd内核线程实例。
> +
> +``kswapd_wait``, ``pfmemalloc_wait``, ``reclaim_wait``
> +同步内存回收任务的工作队列。
> +
> +``nr_writeback_throttled``
> +等待写回脏页时，被限制的任务数量。
> +
> +``kswapd_order``
> +控制kswapd尝试回收的order。
> +
> +``kswapd_highest_zoneidx``
> +kswapd线程可以回收的最高区域索引。
> +
> +``kswapd_failures``
> +kswapd无法回收任何页面的运行次数。
> +
> +``min_unmapped_pages``
> +无法回收的未映射文件支持的最小页面数量。由 ``vm.min_unmapped_ratio`` 系统控制台（sysctl）
> +参数决定。在开启 ``CONFIG_NUMA`` 配置时定义。
> +
> +``min_slab_pages``
> +无法回收的SLAB页面的最少数量。由 ``vm.min_slab_ratio`` 系统控制台（sysctl）参数决定。在
> +开启 ``CONFIG_NUMA`` 时定义。
> +
> +``flags``
> +控制回收行为的标志位。
> +
> +内存压缩控制
> +~~~~~~~~~~~~
> +
> +``kcompactd_max_order``
> +kcompactd应尝试实现的页面order。
> +
> +``kcompactd_highest_zoneidx``
> +kcompactd可以压缩的最高区域索引。
> +
> +``kcompactd_wait``
> +同步内存压缩任务的工作队列。
> +
> +``kcompactd``
> +每个节点的kcompactd内核线程实例。
> +
> +``proactive_compact_trigger``
> +决定是否使用主动压缩。由 ``vm.compaction_proactiveness`` 系统控制台（sysctl）参数控制。
> +
> +统计信息
> +~~~~~~~~
> +
> +``per_cpu_nodestats``
> +表示节点的Per-CPU虚拟内存统计信息。
> +
> +``vm_stat``
> +表示节点的虚拟内存统计数据。
> +
> +.. _zones:
> +
> +区域
> +====
> +
> +.. admonition:: Stub
> +
> +  本节内容不完整。请列出并描述相应的字段。
> +
> +.. _pages:
> +
> +页
> +====
> +
> +.. admonition:: Stub
> +
> +  本节内容不完整。请列出并描述相应的字段。
> +
> +页码
> +====
> +
> +.. admonition:: Stub
> +
> +  本节内容不完整。请列出并描述相应的字段。
> +
> +.. _initialization:
> +
> +初始化
> +======
> +
> +.. admonition:: Stub
> +
> +  本节内容不完整。请列出并描述相应的字段。
> +
> +
> --
> 2.27.0

