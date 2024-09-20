Return-Path: <linux-kernel+bounces-333908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7462A97CFC6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 03:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB9591F241F1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 01:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E112DB665;
	Fri, 20 Sep 2024 01:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnrfQCIJ"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBDE23D2;
	Fri, 20 Sep 2024 01:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726796452; cv=none; b=sTi0VNxlJVtWSRfltSVCQ/LRONwZFWQZHqfMY5K9AxxgSpHm8o7y0iJJwhyrpfMWgt2icZnjN+Km42O6ro1d8+UH5BuVSeuOR8gvNMZpkmYi4ql2jq8oak/ZigcZpKDKREoQFWKx53LosWw844oOWLYkMUyFSLJr3D2lbqOwNe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726796452; c=relaxed/simple;
	bh=eziTKsgjPGMdQnE/A9++3/4fo8DHopsCW+BJgSBCmA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jdTr9bTBKgd8wZwz62huUnIKUIjpp2jjowinnJcqiX/8KAXAz9kzBbM8sEZToPDHwb2Y7jiuNINWvpeUfueZHAv3TjA7D8PM0tXo5BGavXzGgWd5LTYQ6+n/n9GLHljzr8j2KSC/ROyYlJW4Wq7akgO1idFt+izr9yRLC8T9C/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HnrfQCIJ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2068acc8b98so15148965ad.3;
        Thu, 19 Sep 2024 18:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726796450; x=1727401250; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rb4hcjyzRrztA7HQ5lXB2JoKRSElsKcx9lABvy5tATw=;
        b=HnrfQCIJuZKAUCXgZw5zJbiANga3f0RGoHhsscL+J91gNUx1iLvfIfbiYt5fZAIY9N
         wty8zDojNYpdj9UvgQnw/fB/FgRpSRw8nku5gJupO+KBzn/rpgPo/jrMaxfvXTZv2tKW
         5j8JK7W6jKBUUpqI6gsjE/Q7N5UFPhJgaS1a0Nsh6QFVNJi+l9aSeLmgO8lduF+AIalh
         JxQlSc2l2zWD9/0WggBn3nIVMMvJ4/ByZUERCqE+hQYMjED/ssCB68DseoGGCtyrHjfe
         RX4l2TMmwjlkcTXBVOZdjVYf0lur2BoKkOF1JuUM4fJn7Z8c/G4iDAg7SGvNPvOJsPJ6
         bXdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726796450; x=1727401250;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rb4hcjyzRrztA7HQ5lXB2JoKRSElsKcx9lABvy5tATw=;
        b=w2aDI21clUb8sfN1P6Yn0C4J0y6ZYRZerzv38JDzVpCSNX4hD/RWG9VUAold71hfGW
         jrzvpm3NdHfivgPRhIRx3Duso0QUxCLiHQjF1uF7/5joXCJpdAU7S66cEBeTNbkKtZDs
         wRZv89AyaaIIfXHz0RiZP6V5XAqeG2E8XKI2j7lb7rWsfB0T4D3aHq8vC8EV/28HL/ut
         7ywf2VkcQoT3rs54DJ7Tdo423fbnCY1jes/uTeP28BTcf9TSJaKfoujC9VnAjFu9f2L7
         Q2pP0V8NnnSR+GfEPZNif/hZOUovtJ8+f6JUsSRKcl5dfomD/eTcF84pl28XpPEw6xpR
         mTOg==
X-Forwarded-Encrypted: i=1; AJvYcCWg1EDIXr8tvFHLX8MafundsFf5351+sq3yFtrWHgjTakpgZuwAS2ye0bLD/m5BFC6bwNCcbi0DKbnFfoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMHvYwdsi01aoQUJXZ27dZ4wxEeS03Mag6YXlWF/APR2lw9uNE
	6AH7pZV2fk4EauPW+4kQx7r+bIzD+9NcmGt2ipIRPTErcWUYbQd5
X-Google-Smtp-Source: AGHT+IFgrJTLJgdJPe1NY87oNynlzfRkTRvZlgMJJpkWJKWbWqXPMBW0pdde7RwO1PoucQu+KKDB0w==
X-Received: by 2002:a17:902:db12:b0:207:5cfc:504a with SMTP id d9443c01a7336-208d836cb41mr21984285ad.4.1726796449963;
        Thu, 19 Sep 2024 18:40:49 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2079460111asm86141625ad.90.2024.09.19.18.40.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 18:40:49 -0700 (PDT)
Message-ID: <0818ac2c-98ab-4950-9acf-56f4d0f49538@gmail.com>
Date: Fri, 20 Sep 2024 09:40:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Docs/zh_CN: Translate page_tables.rst to Simplified
 Chinese
To: Pengyu Zhang <zpenya1314@gmail.com>, alexs@kernel.org,
 siyanteng@loongson.cn, corbet@lwn.net, si.yanteng@linux.dev
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 yaxin_wang_uestc@163.com
References: <20240919133825.15606-1-zpenya1314@gmail.com>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <20240919133825.15606-1-zpenya1314@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Reviewed-by: Alex Shi <alexs@kernel.org>

On 9/19/24 9:38 PM, Pengyu Zhang wrote:
> This patch provides a Simplified Chinese translation of the
> "page_tables.rst" document, aimed at improving accessibility
> for Chinese-speaking developers and users.
> 
> The translation prioritizes technical accuracy and readability,
> ensuring that the content remains clear and informative for
> its intended audience.
> 
> Signed-off-by: Pengyu Zhang <zpenya1314@gmail.com>
> ---
> v2->v3:fix issues mentioned by Alex:
> https://lore.kernel.org/all/a7697015-fb68-49d2-9ed0-4ebb3760ec10@gmail.com/
>>>     page_owner
>>>     page_table_check
>>> +   page_tables.rst
>>
>> Is this work? Could you change here to follow existing style?
>>
>> Thanks
> 
> Sorry, I didn't notice that. After make htmldocs, "index.html" has the "页表" url and it work.
> But this is my mistake for not following the style, i have fixed it.
> 
>  Documentation/translations/zh_CN/mm/index.rst |   1 +
>  .../translations/zh_CN/mm/page_tables.rst     | 221 ++++++++++++++++++
>  2 files changed, 222 insertions(+)
>  create mode 100644 Documentation/translations/zh_CN/mm/page_tables.rst
> 
> diff --git a/Documentation/translations/zh_CN/mm/index.rst b/Documentation/translations/zh_CN/mm/index.rst
> index b950dd118be7..960b6d2f3d18 100644
> --- a/Documentation/translations/zh_CN/mm/index.rst
> +++ b/Documentation/translations/zh_CN/mm/index.rst
> @@ -53,6 +53,7 @@ Linux内存管理文档
>     page_migration
>     page_owner
>     page_table_check
> +   page_tables
>     remap_file_pages
>     split_page_table_lock
>     vmalloced-kernel-stacks
> diff --git a/Documentation/translations/zh_CN/mm/page_tables.rst b/Documentation/translations/zh_CN/mm/page_tables.rst
> new file mode 100644
> index 000000000000..7fb56822dae7
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/mm/page_tables.rst
> @@ -0,0 +1,221 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. include:: ../disclaimer-zh_CN.rst
> +
> +:Original: Documentation/mm/page_tables.rst
> +
> +:翻译:
> +
> + 张鹏宇 Pengyu Zhang <zpenya1314@gmail.com>
> +
> +:校译:
> +
> +====
> +页表
> +====
> +
> +分页虚拟内存是随虚拟内存的概念一起于 1962 年在 Ferranti Atlas 计算机上被提出的，
> +这是第一台有分页虚拟内存的计算机。随着时间推移，这个特性被迁移到更新的计算机上，
> +并且成为所有类 Unix 系统实际的特性。在 1985 年，这个特性被包含在了英特尔 80386
> +中，也就是 Linux 1.0 基于的 CPU。
> +
> +页表将 CPU 看到的虚拟地址映射到外部内存总线上看到的物理地址。
> +
> +Linux 将页表定义为一个分级结构，目前有五级。对于支持的每种架构，其代码会根据硬件
> +限制对这个层级结构进行映射。
> +
> +虚拟地址对应的物理地址通常由底层物理页帧引用。 **页帧号(page frame number,pfn)**
> +是页的物理地址（在外部内存总线看到的地址）除以 `PAGE_SIZE` 得到的值。
> +
> +物理内存地址 0 对应 *pfn 0*，而最大的 pfn 对应处理器外部地址总线所能寻址物理地址
> +的最后一页。
> +
> +在页粒度为 4KB 且地址范围为32位的情况下，pfn 0 对应地址0x00000000，pfn 1 对应
> +地址0x00001000，pfn 2 对应地址 0x00002000，以此类推，直到 pfn 0xfffff 对应
> +0xfffff000。如果页粒度为 16KB，则 pfn 分别对应地址 0x00004000、0x00008000
> +... 0xffffc000，pfn 的范围从 0 到 0x3fffff。
> +
> +如你所见，对于 4KB 页面粒度，页基址使用地址的 12-31 位，这就是为什么在这种情况下
> +`PAGE_SHIFT` 被定义为 12，并且 `PAGE_SIZE` 通常由页偏移定义，为 `(1 << PAGE_SHIFT)`。
> +
> +随着内存容量的增加，久而久之层级结构逐渐加深。Linux 最初使用 4KB 页面和一个名为
> +`swapper_pg_dir` 的页表，该页表拥有 1024 个条目(entries)，覆盖 4MB 的内存，
> +事实上Torvald 的第一台计算机正好就有 4MB 物理内存。条目在这张表中被称为 *PTE*:s
> +- 页表条目(page table entries)。
> +
> +软件页表层级结构反映了页表硬件已经变得分层化的事实，而这种分层化的目的是为了节省
> +页表内存并加快地址映射速度。
> +
> +当然，人们可以想象一张拥有大量条目的单一线性的页表将整个内存分为一个个页。而且，
> +这样的页表会非常稀疏，因为虚拟内存中大部分位置通常是未使用的。通过页表分层，虚拟
> +内存中的大量空洞不会浪费宝贵的页表内存，因为只需要在上层页表中将大块的区域标记为
> +未映射即可。
> +
> +另外，在现代处理器中，上层页表条目可以直接指向一个物理地址范围，这使得单个上层
> +页表条目可以连续映射几兆字节甚至几千兆字节的内存范围，从而快捷地实现虚拟地址到
> +物理地址的映射：当你找到一个像这样的大型映射范围时，无需在层级结构中进一步遍历。
> +
> +页表的层级结构目前发展为如下所示::
> +
> +  +-----+
> +  | PGD |
> +  +-----+
> +     |
> +     |   +-----+
> +     +-->| P4D |
> +         +-----+
> +            |
> +            |   +-----+
> +            +-->| PUD |
> +                +-----+
> +                   |
> +                   |   +-----+
> +                   +-->| PMD |
> +                       +-----+
> +                          |
> +                          |   +-----+
> +                          +-->| PTE |
> +                              +-----+
> +
> +
> +不同页表层级的符号含义从最底层开始如下：
> +
> +- **pte**, `pte_t`, `pteval_t` = **页表条目** - 前面提到过。*pte* 是一个由
> +  `PTRS_PER_PTE` 个 `pteval_t` 类型元素组成的数组，每个元素将一个虚拟内存页
> +  映射到一个物理内存页。体系结构定义了 `pteval_t` 的大小和内容。
> +
> +  一个典型的例子是 `pteval_t` 是一个 32 或者 64 位的值，其中高位是 **pfn**，
> +  而低位则一些特定体系架构相关的位，如内存保护。
> +
> +  这个 **条目(entry)** 有点令人困惑，因为在 Linux 1.0 中它确实指的是单层顶级
> +  页表中的单个页表条目，但在首次引入二级页表时，它被重新定义为映射元素的数组。
> +  因此，*pte* 现在指的是最底层的页 *表*，而不是一个页表 *条目*。
> +
> +- **pmd**, `pmd_t`, `pmdval_t` = **页中间目录(Page Middle Directory)**,
> +  位于 *pte* 之上的层级结构，包含 `PTRS_PER_PMD` 个指向 *pte* 的引用。
> +
> +- **pud**, `pud_t`, `pudval_t` = **页上级目录(Page Upper Directory)**
> +  是在其他层级之后引入的，用于处理四级页表。它可能未被使用，或者像我们稍后
> +  讨论的那样被“折叠”。
> +
> +- **p4d**, `p4d_t`, `p4dval_t` = **页四级目录(Page Level 4 Directory)**
> +  是在 *pud* 之后用于处理五级页表引入的。至此，显然需要用数字来替代 *pgd*、
> +  *pmd*、*pud* 等目录层级的名称，不能再继续使用临时的命名方式。这个目录层级
> +  只在实际拥有五级页表的系统上使用，否则它会被折叠。
> +
> +- **pgd**, `pgd_t`, `pgdval_t` = **页全局目录(Page Global Directory)** -
> +  Linux 内核用于处理内核内存的 *PGD* 主页表仍然位于 `swapper_pg_dir`。
> +  但系统中的每个用户空间进程也有自己的内存上下文，因此也有自己的 *pgd*，
> +  它位于 `struct mm_struct` 中，而 `struct mm_struct` 又在每个 `struct task_struct`
> +  中有引用。所以，任务（进程）存在一个形式为 `struct mm_struct` 的内存上下文，
> +  而这个结构体中有一个指向指向相应的页全局目录 `struct pgt_t *pgd` 指针。
> +
> +重申一下：页表层级结构中的每一层都是一个 *指针数组*，所以 *pgd* 包含 `PTRS_PER_PGD`
> +个指向下一层的指针，*p4d* 包含 `PTRS_PER_P4D` 个指向 *pud* 项的指针，依此类推。
> +每一层的指针数量由体系结构定义。::
> +
> +        PMD
> +  --> +-----+           PTE
> +      | ptr |-------> +-----+
> +      | ptr |-        | ptr |-------> PAGE
> +      | ptr | \       | ptr |
> +      | ptr |  \        ...
> +      | ... |   \
> +      | ptr |    \         PTE
> +      +-----+     +----> +-----+
> +                         | ptr |-------> PAGE
> +                         | ptr |
> +                           ...
> +
> +页表折叠
> +========
> +
> +如果架构不使用所有的页表层级，那么这些层级可以被 *折叠*，也就是说被跳过。在
> +访问下一层时，所有在页表上执行的操作都会在编译时增强，以跳过这一层。
> +
> +与架构无关的页表处理代码（例如虚拟内存管理器）需要编写得能够遍历当前的所有五个
> +层级。对于特定架构的代码，也应优先采用这种风格，以便对未来的变化具有更好的适应性。
> +
> +MMU，TLB 和缺页异常
> +===================
> +
> +`内存管理单元(MMU)` 是处理虚拟地址到物理地址转换的硬件组件。它可能会使用相对较小
> +的硬件缓存，如 `转换后备缓冲区(TLB)` 和 `页遍历缓存`，以加快这些地址翻译过程。
> +
> +当 CPU 访存时，它会向 MMU 提供一个虚拟地址。MMU 会首先检查 TLB 或者页遍历缓存
> +（在支持的架构上）是否存在对应的转换结果。如果没有，MMU 会通过遍历来确定物理地址
> +并且建立映射。
> +
> +当页面被写入时，该页的脏位会被设置（即打开）。每个内存页面都有相关的权限位和脏位。
> +后者表明这个页自从被加载到内存以来是否被修改。
> +
> +如果没有任何阻碍，物理内存到头来可以被任意访问并且对物理帧进行请求的操作。
> +
> +MMU 无法找到某些转换有多种原因。有可能是 CPU 试图去访问当前进程没有权限访问的
> +内存，或者因为访问的数据还不在物理内存中。
> +
> +当这些情况发生时，MMU 会触发缺页异常，这是一种异常类型，用于通知 CPU 暂停当前
> +执行并运行一个特殊的函数去处理这些异常。
> +
> +缺页异常有一些常见且预期的原因。这些因素是由称为“懒加载”和“写时复制”的进程管理
> +优化技术来触发的。缺页异常也可能发生在当页帧被交换到持久存储（交换分区或者文件）
> +并从其物理地址移出时。
> +
> +这些技术提高了内存效率，减少了延迟，并且最小化了空间占用。本文档不会深入讨论
> +“懒加载”和“写时复制”的细节，因为这些的主题属于进程地址管理范畴，超出了本文范围。
> +
> +交换技术和前面提到的其他技术不同，因为它是在压力过大下情况下减少内存消耗的一种
> +迫不得已的手段，因此是不受欢迎的。
> +
> +交换不适用于由内核逻辑地址映射的内存。这些地址是内核虚拟地址空间的子集，直接映射
> +一段连续的物理内存。对于提供的任意逻辑地址，它的物理地址可以通过对偏移量进行简单
> +的算数运算来确定。对逻辑地址的访问很快，因为这避免了复杂的页表查找，但代价是这些
> +内存不能被驱逐或置换。
> +
> +如果内核无法为必须存在于物理帧中的数据腾出空间，那么它会调用内存不足(out-of-memory,
> +OOM)杀手，通过杀掉低优先级的进程来腾出空间，直到内存压力下降到安全阈值之下。
> +
> +另外，代码漏洞或指示 CPU 访问的精心制作的恶意地址也可能导致缺页异常。一个进程的
> +线程可以利用指令来访问不属于其地址空间的（非共享）内存，或者试图执行写入只读位置
> +的指令。
> +
> +如果上述情况发生在用户态，内核会向当前线程发送 `段错误` (SIGSEGV)信号。该信号
> +通常导致线程及其所属的进程终止。
> +
> +本文将简化并概述 Linux 内核如何处理这些页面错误、创建表和表项、检查内存是否存在，
> +以及当内存不存在时，如何请求从持久存储或其他设备加载数据，并更新 MMU 及其缓存。
> +
> +前几步取决于设备依赖。大多是架构跳转到 `do_page_fault()`，而 x86 中断处理程序由
> +`DEFINE_IDTENTRY_RAW_ERRORCODE()` 宏定义的，该宏调用 `handle_page_fault()`。
> +
> +无论调用路径如何，所有架构最终都会调用 `handle_mm_fault()`，该函数通常会调用
> +`__handle_mm_fault()` 来执行实际分配页表的任务。
> +
> +如果不幸无法调用 `__handle_mm_fault()` 则意味着虚拟地址指向了无权访问的物理
> +内存区域（至少对于当前上下文如此）。这种情况会导致内核向该进程发送上述的 SIGSEGV
> +信号，并引发前面提到的后果。
> +
> +这些用于查找偏移量的函数名称通常以 `*_offset()` 结尾，其中“\*”可以是 pgd，p4d，
> +pud，pmd 或者 pte；而分配相应层级页表的函数名称是 `*_alloc`，它们按照上述命名
> +约定以对应页表层级的类型命名。
> +
> +页表遍历可能在中间或者上层结束(PMD，PUD)。
> +
> +Linux 支持比通常 4KB 更大的页面（即所谓的 `巨页`）。当使用这种较大的页面时，没有
> +必要使用更低层的页表项(PTE)。巨页通常包含 2MB 到 1GB 的大块连续物理区域，分别由
> +PMD 和 PUD 页表项映射。
> +
> +巨页带来许多好处，如减少 TLB 压力，减少页表开销，提高内存分配效率，以及改善
> +特定工作负载的性能。然而，这些好处也伴随着权衡，如内存浪费和分配难度增加。
> +
> +在遍历和分配的最后，如果没有返回错误，`__handle_mm_fault()` 最终调用 `handle_pte_fault()`
> +通过 `do_fault()` 执行 `do_read_fault()`、 `do_cow_fault()` 和 `do_shared_fault()`。
> +“read”，“cow”和“shared”分别暗示了它处理错误的类型和原因。
> +
> +实际的工作流程实现是非常复杂的。其设计允许 Linux 根据每种架构的特定特性处理缺页
> +异常，同时仍然共享一个通用的整体结构。
> +
> +为了总结 Linux 如何处理缺页中断的概述，需要补充的是，缺页异常处理程序可以通过
> +`pagefault_disable()` 和 `pagefault_enable()` 分别禁用和启用。
> +
> +许多代码路径使用了这两个函数，因为它们需要禁止陷入缺页异常处理程序，主要是为了
> +防止死锁。

