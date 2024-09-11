Return-Path: <linux-kernel+bounces-324104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9E99747F0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 03:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97C51288D8C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 01:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FC324B26;
	Wed, 11 Sep 2024 01:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f04uDkdf"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0928460;
	Wed, 11 Sep 2024 01:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726019198; cv=none; b=YLkI5O4QBicgVXpR8aH2zuIPAU8Yo0IB5S+cdZcjGtPIYtU3YTRM6ZJBsgITf9sFjAPy+LiNn4aEFeDOral7jRULAuzKqgAk3sjJVOQd/whPiFevliHc1AwvZfCvrJZGcf4Cn9HfXeCtEE4EN/+GFFbhs5TyHfvqMAXdW/ARH/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726019198; c=relaxed/simple;
	bh=whr13ZeePl6FZ6wuqv+OvJw6D0WsrMwO4R5u9f3aBL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q7a+dRueoz1uUIRD/OA8y31gnynF0/aH8tA2NOYQRp8W4vGHDbaBRcRzKe3BVolUA/C5yzeGGkBfg/qfGs4WLrB+fs68XIlKQPxzfYOx77YcZyOAEQoJ6m4ijJk8WbqfwuNngTB4O2083G0QQs0xgkmgKIt+XhZq+Fk75/xAzGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f04uDkdf; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-206bd1c6ccdso56805425ad.3;
        Tue, 10 Sep 2024 18:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726019196; x=1726623996; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WAq+j7jQsXpxt914ATKh1C2eKvleUSfmcVB67jc+GKY=;
        b=f04uDkdfRS/V4nxCKpnayLqjVIQiQWV9QrGJ6t7cmoymDtQcDfRYVK6MH/9Nk+u1ab
         9grAKDHfsLFDVu4I+koqrf0vu/MN8THRsSgdDvKDsNGnW0R5uSrqq0e4ubqFE0kpc/yF
         8dpz2cXKcFoh8FP/7dMtSd2+us6d2cF7DERG9mCVvFYUgUu/+jcDaiElLIxAPnD1zTWB
         4AekuyMsxVC3rPdPSM8XK5eZf9X93X9St1RyEJ+xeeH/tOygtqZUMEhZee88cBvtZ2Rb
         1ybwvtV7b3zB5COnzAeF4q/3i+wP/F22y1faIi12mE4fpyGX3M3v999hjed2pu/SZJ/R
         8jSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726019196; x=1726623996;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WAq+j7jQsXpxt914ATKh1C2eKvleUSfmcVB67jc+GKY=;
        b=N7+X4t0pFeIeZGJnRLJiVJFQn7wk2RbPFaHpQEJkNbWd/G2gijVQmcQRg0V4FDPvtz
         k4yy1K9KoyfuSTTKELWeZGtz9HoA3AyI39usbJkmG3xX7PZbcyKdDkf3PurvtRJ+Tt61
         eR671+foFPosPX4aDdeifZtVkk4yrHcd+V83qzWHBjE+nUVPSPVyyNvc82Kh24zuHnQw
         OTDMkzOEe7gSmUgY5/7iBmmm3RZrfduVMHZiTLlPRAn1r5pHLBc5NYuqCh84r6gZlg7Z
         wL9ylfobXa2tTP6ALHwP0GGueKHn5/0Exebkn11rQFbm9h/GbgFcj4A2CGXN8J42e6eQ
         WV0A==
X-Forwarded-Encrypted: i=1; AJvYcCUjo/QvwGZhRqnwQGok63yGE+UGl8BEJzzJZX3YeQOfqPh8whn3g+cddYzLMqjUA1XHF751bzqlqa4=@vger.kernel.org, AJvYcCVmaF6posyhS4B3MhfzEFJM2bJD6z7ZWus0iK+Ac9bdGqCbjLfRlh3Qg9ZOZtxPeDSYB0QVY0O33zaUpHNQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxIGrzBC4bgqeh57/qG7fLpR1XbSrxAZSLVn+bzoVIVhKlKHcLC
	5OHr8IdsVj/LJ/LiG/BNQz7rllSq84lbzeKyT7otu/bFFrXKLeUk
X-Google-Smtp-Source: AGHT+IHyBH+zccg/m0re4rOuSti+79AFsTHHNMFQSA5rkAUODvjFNIpcRPgFgcTwWS1MAqh5unfqJw==
X-Received: by 2002:a17:902:e543:b0:206:8c4a:7bbb with SMTP id d9443c01a7336-2074c79c434mr34076535ad.58.1726019195329;
        Tue, 10 Sep 2024 18:46:35 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710f4c2d8sm54014175ad.297.2024.09.10.18.46.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 18:46:34 -0700 (PDT)
Message-ID: <53f0ef4b-8c46-4c4b-abab-7b9233b8f315@gmail.com>
Date: Wed, 11 Sep 2024 09:46:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Documentation/mm: Translate physical_memory.rst to
 Simplified Chinese
To: jiang.kun2@zte.com.cn, alexs@kernel.org, siyanteng@loongson.cn,
 corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: wang.yaxin@zte.com.cn, fan.yu9@zte.com.cn, xu.xin16@zte.com.cn,
 he.peilin@zte.com.cn, tu.qiang35@zte.com.cn, qiu.yutan@zte.com.cn,
 zhang.yunkai@zte.com.cn
References: <20240904112020232OieLhsFZ_M10gBxJtUieP@zte.com.cn>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <20240904112020232OieLhsFZ_M10gBxJtUieP@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/4/24 11:20 AM, jiang.kun2@zte.com.cn wrote:
> From: Yaxin Wang <wang.yaxin@zte.com.cn>
> 
> This patch translates the "physical_memory.rst" document into
> Simplified Chinese to improve accessibility for Chinese-speaking
> developers and users.
> 
> The translation was done with attention to technical accuracy
> and readability, ensuring that the document remains informative
> and useful in its translated form.
> 
> Signed-off-by: Yaxin Wang <wang.yaxin@zte.com.cn>
> ---
> v1->v2:
> Some fixes according to:
> https://lore.kernel.org/all/1add7be9-0da0-4463-a3ea-80e2fd99bd19@gmail.com/
> 
>  .../translations/zh_CN/mm/physical_memory.rst | 285 ++++++++++++++++++
>  1 file changed, 285 insertions(+)
>  create mode 100644 Documentation/translations/zh_CN/mm/physical_memory.rst
> 
> diff --git a/Documentation/translations/zh_CN/mm/physical_memory.rst b/Documentation/translations/zh_CN/mm/physical_memory.rst
> new file mode 100644
> index 000000000000..810606605c6c
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/mm/physical_memory.rst

new file need a index for website access.
> @@ -0,0 +1,285 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +:Original: Documentation/mm/physical_memory.rst
> +
> +:翻译:
> +
> + 王亚鑫 Yaxin Wang <wang.yaxin@zte.com.cn>
> +
> +===============
> +物理内存
> +===============

这里的'='应该是8个， 2倍于汉字符号。其他符号也类似。

For translation part it's fine. Only the style issue need fixed.
BTW， you have to see the web browser version of your doc after 'make htmldocs',
and 'make pdfdocs' or more is better to have.

Alex

> +
> +Linux可用于多种架构，因此需要一个与架构无关的抽象来表示物理内存。本章描述了管理运行系统
> +中物理内存的结构。
> +
> +第一个与内存管理相关的主要概念是`非一致性内存访问(NUMA)<https://en.wikipedia.org/
> +wiki/Non-uniform_memory_access>`
> +
> +在多核和多插槽机器中，内存可能被组织成不同的存储区，这些存储区根据与处理器的“距离”不同而有不同的
> +访问开销。例如，可能为每个CPU分配内存存储区，或者为外围设备在附近分配一个非常适合DMA的内存存储区。
> +
> +每个存储区被称为一个节点，节点在Linux中表示为 ``struct pglist_data``，即使是在UMA架构中
> +也是这样表示。该结构总是通过 ``pg_data_t``来引用。特定节点的 ``pg_data_t`` 结构体可以通过
> +NODE_DATA(nid)引用，其中nid被称为该节点的ID。
> +
> +对于非一致性内存访问（NUMA）架构，节点数据结构在引导时由特定于架构的代码早期分配。通常，这些
> +结构在他们所在的内存区上本地分配。对于一致性内存访问（UMA）架构，只使用一个静态的 ``pg_data_t``
> +结构体，称为 ``contig_page_data``。节点将会在ref:`Nodes <nodes>`章节中进一步讨论。
> +
> +整个物理内存被划分为一个或多个被称为区域的块，这些区域表示内存的范围。这些范围通常由访问内存
> +的架构限制来决定。在节点内，与特定区域对应的内存范围由 ``struct zone`` 结构体描述，该结构被定义为
> +``zone_t``，每种区域都属于以下描述类型的一种。
> +
> +* ``ZONE_DMA``和 ``ZONE_DMA32``在历史上代表适用于DMA的内存，这些内存由那些不能访问所有可寻址内存的
> +外设访问。多年来，已经有了更好、更稳固的接口来获取满足特定DMA需求的内存（这些接口由Documentation/
> +core-api/dma-api.rst文档描述），但是 ``ZONE_DMA``和 ``ZONE_DMA32``仍然表示访问受限的内存范围。
> +
> +取决于架构的不同，这两种区域可以在构建时通过关闭 ``CONFIG_ZONE_DMA``和 ``CONFIG_ZONE_DMA32``配置选项
> +来禁用。一些64位的平台可能需要这两种区域，因为他们支持具有不同DMA寻址限制的外设。
> +
> +* ``ZONE_NORMAL`` 是普通内存的区域，这种内存可以被内核随时访问。如果DMA设备支持将数据传输到
> +所有可寻址的内存区域，那么可以在该区域的页面上执行DMA操作。 ``ZONE_NORMAL`` 总是开启的。
> +
> +* ``ZONE_HIGHMEM`` 是指那些没有在内核页表中永久映射的物理内存部分。该区域的内存只能通过临时映射
> +被内核访问。该区域只在某些32位架构上可用，并且是通过 ``CONFIG_HIGHMEM`` 选项开启。
> +
> +* ``ZONE_MOVABLE`` 是用于可访问的普通内存区域，就像 ``ZONE_NORMAL`` 一样。不同之处在于 ``ZONE_MOVABLE``
> + 中的大多数页面内容是可移动的。这意味着这些页面的虚拟地址不会改变，但它们的内容可能会在不同的物理
> + 页面之间移动。通常，在内存热插拔期间填充 ``ZONE_MOVABLE``，但在启动时也可以使用 ``kernelcore``、
> + ``movablecore`` 和 ``movable_node`` 这些内核命令行参数来填充。有关更多详细信息，请参阅内核文档
> + Documentation/mm/page_migration.rst 和 Documentation/admin-guide/mm/memory-hotplug.rst。
> +
> +* ``ZONE_DEVICE`` 表示位于诸如持久性内存（PMEM）和图形处理单元（GPU）等设备上的内存。它与RAM区域类型有
> +不同的特性，并且它的存在是为了提供:ref:`struct page <Pages>` 结构和内存映射服务，以便设备驱动程序能识别物理地址
> +范围。 ``ZONE_DEVICE`` 通过配置选项 ``CONFIG_ZONE_DEVICE`` 开启。
> +
> +需要注意的是，许多内核操作只能使用 ``ZONE_NORMAL`` 来执行，因此它是性能最关键区域。区域在
> +:ref:`Zones <zones>` 节中有更详细的讨论。
> +
> +节点和区域范围之间的关系由固件报告的物理内存映射决定，另外也由内存寻址的架构约束以及内核命令行中的某些参数决定。
> +
> +例如，在具有2GB RAM的x86统一内存架构（UMA）机器上运行32位内核时，整个内存将位于节点0，并且将有三个
> +区域： ``ZONE_DMA``、 ``ZONE_NORMAL`` 和 ``ZONE_HIGHMEM``。
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
> +在内核构建时关闭 ``ZONE_DMA`` 开启 ``ZONE_DMA32``，并且在具有16GB RAM平均分配在两个节点上的arm64
> +机器上，使用 ``movablecore=80%`` 参数启动时， ``ZONE_DMA32``、 ``ZONE_NORMAL`` 和
> +``ZONE_MOVABLE`` 位于节点0，而 ``ZONE_NORMAL`` 和 ``ZONE_MOVABLE`` 位于节点1。
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
> +=====
> +
> +正如我们所提到的，内存中的每个节点都由 ``pg_data_t`` 描述，它是由 ``struct pglist_data`` 结构体的类型定义。
> +在分配页面时，默认情况下，Linux使用节点本地分配策略，从离当前运行CPU的最近节点分配内存。由于进程倾向于
> +在同一个CPU上运行，很可能会使用当前节点的内存。分配策略可以由用户控制，如内核文档 Documentation/admin-guide
> +/mm/numa_memory_policy.rst 中所述。
> +
> +大多数NUMA（非统一内存访问）架构维护了一个指向节点结构的指针数组。这些实际的结构在启动过程中的早期被分配，
> +这时特定于架构的代码解析了固件报告的物理内存映射。节点初始化的大部分工作是在由 free_area_init()实现的启
> +动过程之后完成，该函数在后面的小节 :ref:`Initialization <initialization>` 中有详细描述。
> +
> +除了节点结构，内核还维护了一个名为 ``node_states`` 的 ``nodemask_t`` 位掩码数组。这个数组中的每个位掩码代表一组
> +特定属性的节点，这些属性由 ``enum node_states`` 定义，定义如下：
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
> +对于具有上述属性的每个节点， ``node_states[<property>]``掩码中对应于节点ID的位会被置位。
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
> +例如，要为每个在线节点调用函数 foo()，可以这样操作：
> +
> +  for_each_online_node(nid) {
> +		  pg_data_t *pgdat = NODE_DATA(nid);
> +
> +		  foo(pgdat);
> +	}
> +
> +节点数据结构
> +--------------
> +
> +节点结构 ``struct pglist_data`` 在 ``include/linux/mmzone.h`` 中声明。这里我们
> +将简要描述这个结构体的字段：
> +
> +通用字段
> +~~~~~~~
> +
> +``node_zones``
> +该节点的区域列表。并非所有区域都可能被填充，但这是完整的列表。它被该节点的node_zonelists以及其它
> +节点的node_zonelists引用。
> +
> +``node_zonelists``
> +所有节点中所有区域的列表。此列表定义了分配内存时首选的区域顺序。 ``node_zonelists`` 在核心内存管理
> +结构初始化期间，由 ``mm/page_alloc.c`` 中的 ``build_zonelists()`` 函数设置的。
> +
> +``nr_zones``
> +此节点中已填充区域的数量。
> +
> +``node_mem_map``
> +对于使用FLATMEM内存模型的UMA系统，0号节点的 ``node_mem_map`` 表示每个物理帧的 struct pages 数组。
> +
> +``node_page_ext``
> +对于使用FLATMEM内存模型的UMA系统，0号节点的 ``node_page_ext`` 是struct pages的扩展数组。
> +只有在构建时开启了 ``CONFIG_PAGE_EXTENSION`` 选项的内核中才可用。
> +
> +``node_start_pfn``
> +此节点中起始页面帧的页面帧号。
> +
> +``node_present_pages``
> +此节点中存在的物理页面的总数。
> +
> +``node_spanned_pages``
> +包括空洞在内的物理页面范围的总大小。
> +
> +``node_size_lock``
> +一个保护定义节点范围字段的锁。仅在开启了 ``CONFIG_MEMORY_HOTPLUG`` 或
> +``CONFIG_DEFERRED_STRUCT_PAGE_INIT`` 配置选项中的某一个时才定义。提供了
> +``pgdat_resize_lock()`` 和 ``pgdat_resize_unlock()`` 用来操作 ``node_size_lock``，
> +而无需检查 ``CONFIG_MEMORY_HOTPLUG`` 或 ``CONFIG_DEFERRED_STRUCT_PAGE_INIT``选项。
> +
> +``node_id``
> +节点的节点ID（NID），从0开始。
> +
> +``totalreserve_pages``
> +这是每个节点保留的页面，这些页面不可用于用户空间分配。
> +
> +``first_deferred_pfn``
> +如果大型机器上的内存初始化被推迟，那么第一个PFN（页帧号）是需要初始化的。仅在开启了
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
> +~~~~~~~~~~~~~~~
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
> +参数决定。仅在开启 ``CONFIG_NUMA`` 配置时定义。
> +
> +``min_slab_pages``
> +无法回收的SLAB页面的最少数量。由 ``vm.min_slab_ratio`` 系统控制台（sysctl）参数决定。仅在
> +开启 ``CONFIG_NUMA`` 时定义。
> +
> +``flags``
> +控制回收行为的标志位。
> +
> +内存压缩控制
> +~~~~~~~~~~~~~~~~~~
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
> +~~~~~~~~~~
> +
> +``per_cpu_nodestats``
> +节点的Per-CPU虚拟内存统计信息。
> +
> +``vm_stat``
> +节点的虚拟内存统计数据。

