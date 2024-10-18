Return-Path: <linux-kernel+bounces-371847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 361A19A4140
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 16:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DEB61C21F4A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 14:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0D81EE007;
	Fri, 18 Oct 2024 14:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfoY1qxj"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DBA18643;
	Fri, 18 Oct 2024 14:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729262030; cv=none; b=AwBe29jW7CHELlllbbICOPC+9J7K0usCcoqR1CH9NTEJJ1NEOkDquBGjP6UMxCzNV0OtiuAikSlx+Pv6imqVxHQ+B2GUBCel5oo42pos1rlSd2tSpgZ2r23uPzc5ktkRsCV+YyJD0ymOeBSIg0bsi4lYXmkhO0FD4j/WPL1UGnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729262030; c=relaxed/simple;
	bh=hGeLOV5cRgxqY5c7llKv5YNPbRVax3yK+ST2a4XdQ4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GbxbdP3v5MziERAxnuhbQQXXTzXqqA99/biX4XoErnyo92TbY3WQ/qdUrMRvQ+0ftd2tAANYouO0cAFo5sRg5FZkEbRhxXyhIhW8tor91eATzmSFLyQQd3INJyuofrOcghuR5xZ5ARVY4UlHTkjbsRxnrhsLklkymBtg2dPwtUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RfoY1qxj; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6e330b7752cso23565477b3.1;
        Fri, 18 Oct 2024 07:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729262027; x=1729866827; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2cpH3TMEoZo2lCrqppCe3V/KLiY8USrLUUXcB040Sss=;
        b=RfoY1qxj1kXqFVVYQCPl1O0fQI8Hj4VM/xIB7n5MjAre516kvthYfYLTETFMjuimMY
         xWd6ZUOmXPBg7ipW/PraZkMmi/kOjpyWrKlPOX4IjsUr9m60tNvqO19myotA8t9Ah25W
         HoWXQS6T7CNuxdbyyR8kaZJavXLBR4sPnMYNbDQ9HQhOkAY1rMsRLOtHo0xMjLBsYzHW
         F2pUDqkTbm3bsMdlOtTCL4vjmGXIQWpOho8Ktj5VJBMJ0KXvDHWZwInRpiCEmjp+FD2K
         uqqBwKQys3sCbd3cTblMdrhI608vlgqyMYzuic/0wa48s9VSsnGdsPFAnOVtdhET/Ik5
         32eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729262027; x=1729866827;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2cpH3TMEoZo2lCrqppCe3V/KLiY8USrLUUXcB040Sss=;
        b=HLb812oingCMJSMIcHRhJ+nlr0L7OUzw24h3LemF3xqCMaWHjpGT8m2pGUr+viCXDL
         zy8NKo61TSzlj7tEU/d2zDgYbzvwbhJYMschqVSkVqZTo0XysWn3ZI9+/45/Q7SpoQq0
         VsQEmi1tBFp/cGO9HeH58IA9i+GLFOz4ctnUTla7LG5VVysySETkWtFevbmp+iMtoJ7t
         VWa3jn7F8aU7z6Rf+gwT9cBHVl0/QLXTq23LW4QJRNLDWLHCNDzsdRU8KJFTDBLK3UDz
         cL3zhpSoROJYF2Qd2o5n9LsigqkWxsINKw/DuHIlPHLNdIJzvIYMlUkgG7hAeqPlx2qV
         kICQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdkP3tFzTCD0TVkrcFcIYydCXf8adeH8FjVQShpS89mh4iyf6Iirhefvj/l2Frs0HbXOMR185GtUGiynUQ@vger.kernel.org, AJvYcCUta17lwaLL2IsyDgEgydSZAFNjDR1Mj5qP0aLII3VjK8sN5cmMH+jP4A0/Mi5h3F02jbxHw0PeNiU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6srP/ssbu9ZLEx7fz99RoC+lyD4AYI2+7gUKOVtXPb0EWE+UM
	BdttsWUSmzyqQ4dDKWllwl3PahUkmnZi9SJtcY3XOfSLwdjFapI1
X-Google-Smtp-Source: AGHT+IGocgP7CKeNYdNzgAgf13kRmK8+erkIDi3PdbIIte4aq3rJ4kbLEa/Z5HJ4dnkfJcf4q+xktw==
X-Received: by 2002:a05:690c:4883:b0:6e3:7625:15f7 with SMTP id 00721157ae682-6e5a3d5743dmr60775127b3.10.1729262026615;
        Fri, 18 Oct 2024 07:33:46 -0700 (PDT)
Received: from [192.168.2.226] ([107.175.133.150])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5c024ae6dsm3116547b3.116.2024.10.18.07.33.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 07:33:46 -0700 (PDT)
Message-ID: <c95075bc-187b-4d38-b9bc-2f19f29a2231@gmail.com>
Date: Fri, 18 Oct 2024 22:33:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] Docs/zh_CN: Translate physical_memory.rst to
 Simplified Chinese
To: jiang.kun2@zte.com.cn, alexs@kernel.org, siyanteng@loongson.cn,
 corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 mudongliangabcd@gmail.com
Cc: wang.yaxin@zte.com.cn, fan.yu9@zte.com.cn, xu.xin16@zte.com.cn,
 he.peilin@zte.com.cn, tu.qiang35@zte.com.cn, qiu.yutan@zte.com.cn,
 zhang.yunkai@zte.com.cn
References: <20241018141724436H0QeZl1E8_YDGP_Fb0n9F@zte.com.cn>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <20241018141724436H0QeZl1E8_YDGP_Fb0n9F@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jiang,

the translation looks fine, but your patch failed on 'git am':
$ g am ./v6_20241018_jiang_kun2_docs_zh_cn_translate_physical_memory_rst_to_simplified_chinese.mbx 
Applying: Docs/zh_CN: Translate physical_memory.rst to Simplified Chinese
error: patch failed: Documentation/translations/zh_CN/mm/index.rst:53
error: Documentation/translations/zh_CN/mm/index.rst: patch does not apply
error: Documentation/translations/zh_CN/mm/physical_memory.rst: already exists in index
Patch failed at 0001 Docs/zh_CN: Translate physical_memory.rst to Simplified Chinese
hint: Use 'git am --show-current-patch' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

You may like to try 'git format-patch' or 'git send-email'?

Thanks


On 10/18/24 14:17, jiang.kun2@zte.com.cn wrote:
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
> Update to commit 7332f9e45d2e("docs/mm: Physical Memory: Fix grammar")
> 
> Signed-off-by: Yaxin Wang <wang.yaxin@zte.com.cn>
> Signed-off-by: Jiang Kun <jiang.kun2@zte.com.cn>
> Reviewed-by: Yanteng Si <si.yanteng@linux.dev>
> ---
> v5->v6:
> Some fixes according to:
> https://lore.kernel.org/all/8f62f870-3db1-4a9b-944f-336b61d48be9@linux.dev/
> 1. remove some extra apace
> 2. add Reviewed-by: Yanteng Si <si.yanteng@linux.dev>
> 
>  Documentation/translations/zh_CN/mm/index.rst |   1 +
>  .../translations/zh_CN/mm/physical_memory.rst | 356 ++++++++++++++++++
>  2 files changed, 357 insertions(+)
>  create mode 100644 Documentation/translations/zh_CN/mm/physical_memory.rst
> 
> diff --git a/Documentation/translations/zh_CN/mm/index.rst b/Documentation/translations/zh_CN/mm/index.rst
> index b950dd118be7..eac20a7ec9a6 100644
> --- a/Documentation/translations/zh_CN/mm/index.rst
> +++ b/Documentation/translations/zh_CN/mm/index.rst
> @@ -53,6 +53,7 @@ Linux内存管理文档
>     page_migration
>     page_owner
>     page_table_check
> +   physical_memory
>     remap_file_pages
>     split_page_table_lock
>     vmalloced-kernel-stacks
> diff --git a/Documentation/translations/zh_CN/mm/physical_memory.rst b/Documentation/translations/zh_CN/mm/physical_memory.rst
> new file mode 100644
> index 000000000000..83eb7a330606
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/mm/physical_memory.rst
> @@ -0,0 +1,356 @@
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
> +Linux可用于多种架构，因此需要一个与架构无关的抽象来表示物理内存。本章描述
> +了管理运行系统中物理内存的结构。
> +
> +第一个与内存管理相关的主要概念是 `非一致性内存访问(NUMA)
> +<https://en.wikipedia.org/wiki/Non-uniform_memory_access>`
> +
> +在多核和多插槽机器中，内存可能被组织成不同的存储区，这些存储区根据与处理器
> +的距离“不同”而有不同的访问开销。例如，可能为每个CPU分配内存存储区，或者为
> +外围设备在附近分配一个非常适合DMA的内存存储区。
> +
> +每个存储区被称为一个节点，节点在Linux中表示为 ``struct pglist_data``，
> +即使是在UMA架构中也是这样表示。该结构总是通过 ``pg_data_t`` 来引用。特
> +定节点的 ``pg_data_t`` 结构体可以通过NODE_DATA(nid)引用，其中nid被称
> +为该节点的ID。
> +
> +对于非一致性内存访问（NUMA）架构，节点数据结构在引导时由特定于架构的代码早
> +期分配。通常，这些结构在其所在的内存区上本地分配。对于一致性内存访问（UMA）
> +架构，只使用一个静态的 ``pg_data_t`` 结构体，称为 ``contig_page_data``。
> +节点将会在 :ref:`节点 <nodes>` 章节中进一步讨论。
> +
> +整个物理内存被划分为一个或多个被称为区域的块，这些区域表示内存的范围。这
> +些范围通常由访问内存的架构限制来决定。在节点内，与特定区域对应的内存范围
> +由 ``struct zone`` 结构体描述，该结构被定义为 ``zone_t``，每种区域都
> +属于以下描述类型的一种。
> +
> +* ``ZONE_DMA`` 和 ``ZONE_DMA32`` 在历史上代表适用于DMA的内存，这些
> +  内存由那些不能访问所有可寻址内存的外设访问。多年来，已经有了更好、更稳
> +  固的接口来获取满足特定DMA需求的内存（这些接口由
> +  Documentation/core-api/dma-api.rst 文档描述），但是 ``ZONE_DMA``
> +  和 ``ZONE_DMA32`` 仍然表示访问受限的内存范围。
> +
> +取决于架构的不同，这两种区域可以在构建时通过关闭 ``CONFIG_ZONE_DMA`` 和
> +``CONFIG_ZONE_DMA32`` 配置选项来禁用。一些64位的平台可能需要这两种区域，
> +因为他们支持具有不同DMA寻址限制的外设。
> +
> +* ``ZONE_NORMAL`` 是普通内存的区域，这种内存可以被内核随时访问。如果DMA
> +  设备支持将数据传输到所有可寻址的内存区域，那么可在该区域的页面上执行DMA
> +  操作。``ZONE_NORMAL`` 总是开启的。
> +
> +* ``ZONE_HIGHMEM`` 是指那些没有在内核页表中永久映射的物理内存部分。该区
> +  域的内存只能通过临时映射被内核访问。该区域只在某些32位架构上可用，并且是
> +  通过 ``CONFIG_HIGHMEM`` 选项开启。
> +
> +* ``ZONE_MOVABLE`` 是指可访问的普通内存区域，就像 ``ZONE_NORMAL``
> +  一样。不同之处在于 ``ZONE_MOVABLE`` 中的大多数页面内容是可移动的。
> +  这意味着这些页面的虚拟地址不会改变，但它们的内容可能会在不同的物理页面
> +  之间移动。通常，在内存热插拔期间填充 ``ZONE_MOVABLE``，在启动时也可
> +  以使用 ``kernelcore``、``movablecore`` 和 ``movable_node``
> +  这些内核命令行参数来填充。更多详细信息，请参阅内核文档
> +  Documentation/mm/page_migration.rst 和
> +  Documentation/admin-guide/mm/memory-hotplug.rst。
> +
> +* ``ZONE_DEVICE`` 表示位于持久性内存（PMEM）和图形处理单元（GPU）
> +  等设备上的内存。它与RAM区域类型有不同的特性，并且它的存在是为了提供
> +  :ref:`struct page<Pages>` 结构和内存映射服务，以便设备驱动程序能
> +  识别物理地址范围。``ZONE_DEVICE`` 通过 ``CONFIG_ZONE_DEVICE``
> +  选项开启。
> +
> +需要注意的是，许多内核操作只能使用 ``ZONE_NORMAL`` 来执行，因此它是
> +性能最关键区域。区域在 :ref:`区域 <zones>` 章节中有更详细的讨论。
> +
> +节点和区域范围之间的关系由固件报告的物理内存映射决定，另外也由内存寻址
> +的架构约束以及内核命令行中的某些参数决定。
> +
> +例如，在具有2GB RAM的x86统一内存架构（UMA）机器上运行32位内核时，整
> +个内存将位于节点0，并且将有三个区域： ``ZONE_DMA``、 ``ZONE_NORMAL``
> +和 ``ZONE_HIGHMEM``::
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
> +在内核构建时关闭 ``ZONE_DMA`` 开启 ``ZONE_DMA32``，并且具有16GB
> +RAM平均分配在两个节点上的arm64机器上，使用 ``movablecore=80%`` 参数
> +启动时，``ZONE_DMA32``、``ZONE_NORMAL`` 和 ``ZONE_MOVABLE``
> +位于节点0，而 ``ZONE_NORMAL`` 和 ``ZONE_MOVABLE`` 位于节点1::
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
> +内存存储区可能位于交错的节点。在下面的例子中，一台x86机器有16GB的RAM分
> +布在4个内存存储区上，偶数编号的内存存储区属于节点0，奇数编号的内存条属于
> +节点1::
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
> +在这种情况下，节点0将覆盖从0到12GB的内存范围，而节点1将覆盖从4GB到16GB
> +的内存范围。
> +
> +.. _nodes:
> +
> +节点
> +====
> +
> +正如我们所提到的，内存中的每个节点由 ``pg_data_t`` 描述，通过
> +``struct pglist_data`` 结构体的类型定义。在分配页面时，默认情况下，Linux
> +使用节点本地分配策略，从离当前运行CPU的最近节点分配内存。由于进程倾向于在同
> +一个CPU上运行，很可能会使用当前节点的内存。分配策略可以由用户控制，如内核文
> +档 Documentation/admin-guide/mm/numa_memory_policy.rst 中所述。
> +
> +大多数NUMA（非统一内存访问）架构维护了一个指向节点结构的指针数组。这些实际
> +的结构在启动过程中的早期被分配，这时特定于架构的代码解析了固件报告的物理内
> +存映射。节点初始化的大部分工作是在由free_area_init()实现的启动过程之后
> +完成，该函数在后面的小节 :ref:`初始化 <initialization>` 中有详细描述。
> +
> +除了节点结构，内核还维护了一个名为 ``node_states`` 的 ``nodemask_t``
> +位掩码数组。这个数组中的每个位掩码代表一组特定属性的节点，这些属性由
> +``enum node_states`` 定义，定义如下：
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
> +节点拥有普通或高端内存。当关闭 ``CONFIG_HIGHMEM`` 配置时，
> +也可以称为 ``N_NORMAL_MEMORY``。
> +
> +``N_MEMORY``
> +节点拥有（普通、高端、可移动）内存。
> +
> +``N_CPU``
> +节点拥有一个或多个CPU。
> +
> +对于具有上述属性的每个节点，``node_states[<property>]``
> +掩码中对应于节点ID的位会被置位。
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
> +有关使用节点掩码（nodemasks）可能进行的各种操作，请参考
> +``include/linux/nodemask.h``。
> +
> +除此之外，节点掩码（nodemasks）提供用于遍历节点的宏，即
> +``for_each_node()`` 和 ``for_each_online_node()``。
> +
> +例如，要为每个在线节点调用函数 foo()，可以这样操作::
> +
> +  for_each_online_node(nid) {
> +		pg_data_t *pgdat = NODE_DATA(nid);
> +
> +		foo(pgdat);
> +	}
> +
> +节点数据结构
> +------------
> +
> +节点结构 ``struct pglist_data`` 在 ``include/linux/mmzone.h``
> +中声明。这里我们将简要描述这个结构体的字段：
> +
> +通用字段
> +~~~~~~~~
> +
> +``node_zones``
> +表示该节点的区域列表。并非所有区域都可能被填充，但这是
> +完整的列表。它被该节点的node_zonelists以及其它节点的
> +node_zonelists引用。
> +
> +``node_zonelists``
> +表示所有节点中所有区域的列表。此列表定义了分配内存时首选的区域
> +顺序。``node_zonelists`` 在核心内存管理结构初始化期间，
> +由 ``mm/page_alloc.c`` 中的 ``build_zonelists()``
> +函数设置。
> +
> +``nr_zones``
> +表示此节点中已填充区域的数量。
> +
> +``node_mem_map``
> +对于使用FLATMEM内存模型的UMA系统，0号节点的 ``node_mem_map``
> +表示每个物理帧的struct pages数组。
> +
> +``node_page_ext``
> +对于使用FLATMEM内存模型的UMA系统，0号节点的 ``node_page_ext``
> +是struct pages的扩展数组。只有在构建时开启了 ``CONFIG_PAGE_EXTENSION``
> +选项的内核中才可用。
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
> +``CONFIG_DEFERRED_STRUCT_PAGE_INIT`` 配置选项中的某一个时才定义。提
> +供了 ``pgdat_resize_lock()`` 和 ``pgdat_resize_unlock()`` 用来操作
> +``node_size_lock``，而无需检查 ``CONFIG_MEMORY_HOTPLUG`` 或
> +``CONFIG_DEFERRED_STRUCT_PAGE_INIT`` 选项。
> +
> +``node_id``
> +节点的节点ID（NID），从0开始。
> +
> +``totalreserve_pages``
> +这是每个节点保留的页面，这些页面不可用于用户空间分配。
> +
> +``first_deferred_pfn``
> +如果大型机器上的内存初始化被推迟，那么第一个PFN（页帧号）是需要初始化的。
> +在开启了 ``CONFIG_DEFERRED_STRUCT_PAGE_INIT`` 选项时定义。
> +
> +``deferred_split_queue``
> +每个节点的大页队列，这些大页的拆分被推迟了。仅在开启了 ``CONFIG_TRANSPARENT_HUGEPAGE``
> +配置选项时定义。
> +
> +``__lruvec``
> +每个节点的lruvec持有LRU（最近最少使用）列表和相关参数。仅在禁用了内存
> +控制组（cgroups）时使用。它不应该直接访问，而应该使用 ``mem_cgroup_lruvec()``
> +来查找lruvecs。
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
> +无法回收的未映射文件支持的最小页面数量。由 ``vm.min_unmapped_ratio``
> +系统控制台（sysctl）参数决定。在开启 ``CONFIG_NUMA`` 配置时定义。
> +
> +``min_slab_pages``
> +无法回收的SLAB页面的最少数量。由 ``vm.min_slab_ratio`` 系统控制台
> +（sysctl）参数决定。在开启 ``CONFIG_NUMA`` 时定义。
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
> +决定是否使用主动压缩。由 ``vm.compaction_proactiveness`` 系统控
> +制台（sysctl）参数控制。
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

