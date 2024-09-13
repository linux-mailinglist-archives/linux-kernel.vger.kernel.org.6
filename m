Return-Path: <linux-kernel+bounces-327509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 384299776F6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 04:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF4A6286419
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 02:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FA01B12C4;
	Fri, 13 Sep 2024 02:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P00mb7nZ"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCD71AD26C;
	Fri, 13 Sep 2024 02:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726195001; cv=none; b=jUF6QHJ/UwMEjc3zYaa+AhxD0AHDRdYYqfh4wigZ7lab8WgzDRSKIFS9CQZyDfdiJxBoxMK24xksEWXrnA4TArQYhBP0a4n07dFjpctIKXttQAIRGwUWzAxviNPH5GJ8GcxqDD6o3X/XwgOxjU9vF9MpRMfG/kD25LWeshgtFJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726195001; c=relaxed/simple;
	bh=UE2B0onoWqFAXTUEunTnrc6Tptnqi7ktBrOIcgAyktE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VSJNoEgqmpd2q4TLc5LhkJqI9JUSvSKqKRhn4x0qa7mF0KBnSoAv1EW37CMvGmevMGmtQMDUCPOpJFDabQ7gDDSb6sQ0hMBCDr+fBi7Z9sGgPXhDR57Wj1J+YoB2X6cwboUIlaKw4QY4ZuvSsy904cUyBxQzlh0b9ubtRfxYp3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P00mb7nZ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20570b42f24so18918805ad.1;
        Thu, 12 Sep 2024 19:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726194999; x=1726799799; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o86SxSozI17IK3596h9jQ2a5mDd+qxzDg4boXNKkRcs=;
        b=P00mb7nZeUxT6j6AKirTM7Sn3Rv3LvZXt9vxSaFcbYAFh6PwrdpofzGdwYOB35m+Lb
         wzgBoFEtO/5BFrAj3qUwIs8FsofW7JBRTk6jv6E3HzfVHeiWwFOcel5ug1RsuLMUhyLV
         RwsaYBERV1d3fImRIWU8Z5Vpl9p2atzPVkkdV/p2rKuJ7wkmCRoA7OswaJ2WVaL3fAMa
         RaXiqy5FcBw6AbLRKNrMFTc2jLqilGmOByiBfRvYvCR6n6mYnR4R6+0K3pPG85KZks/P
         4awy0e51XIXVXIetMdawXkP6oebWmBZeqAtxSNu//uAVfm6bxmzlU5/dL+sEVDBIs83B
         2QGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726194999; x=1726799799;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o86SxSozI17IK3596h9jQ2a5mDd+qxzDg4boXNKkRcs=;
        b=dQHj+puH/SUHwS3oacuCX1XZLBT9o3TpBYLejTINIMqQMkjndStu6El+OaJ8/5dHRn
         XSVlf+xEb+T73hn/GZW6woW/i0/H0ErjoxfzMXUYLiEc9MQOHdlpymFhytM5x53qVAIE
         1kn4mwtFKMCd/rK/FC0hwWfCe/GT0VJYuTchLwkwajCtJRhrLE88kM4wCPKPCE5SaTEK
         rncPFG9g6RZXC4psfWZuPBEIWqsfy5hY7WbVdEMwMmH9XpuOdSHDF/G7+lMeq+pAcd4B
         2jAvbEpnZ5gK8gIT7EC5oSCmGo4rSD2Gh7PpUjEByzJ5brjDMhwgEx3kgprGZXJCuU0n
         EGmw==
X-Forwarded-Encrypted: i=1; AJvYcCWmG98/j1jw517okWoJDkpcoOd4OM8YrSCAYjzzfOWnZpi2BG7r6P9mYhagt6KhCLTvEnpiHdEOi0s=@vger.kernel.org, AJvYcCXSYbCjnKjFftKLoJzsAluAOVoMMRF9jVvwV3A1azSgLk3OBUZyQSHJxOwNc8WAuW1IlrXq+F99N3ANqAOx@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7nEkYHTB3nHj86hs/9eJw3XXV81GWMPTYUKlA24Iq8ugJNDLr
	yzmQ7bcA7BX9fUbfxEpHWADKaGgHwoI1wDe521nPttoNFQPrUytD
X-Google-Smtp-Source: AGHT+IEZ496IsCZ2n3fw4ynKAmxiwjOSK3aym2Sv0osIoOJPO5n0VS+bjz8d3H/wu49CsA1fwI7H9w==
X-Received: by 2002:a17:903:230c:b0:202:54b8:72d5 with SMTP id d9443c01a7336-2076e44df88mr72574545ad.59.1726194998002;
        Thu, 12 Sep 2024 19:36:38 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076af25557sm20061065ad.36.2024.09.12.19.36.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 19:36:37 -0700 (PDT)
Message-ID: <3c550784-9b31-4688-80a8-e8ee344e7c3e@gmail.com>
Date: Fri, 13 Sep 2024 10:36:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation/mm: Translate page_tables.rst to Simplified
 Chinese
To: Dongliang Mu <mudongliangabcd@gmail.com>,
 Pengyu Zhang <zpenya1314@gmail.com>
Cc: alexs@kernel.org, siyanteng@loongson.cn, corbet@lwn.net,
 si.yanteng@linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, yaxin_wang_uestc@163.com
References: <20240912134743.1760-1-zpenya1314@gmail.com>
 <CAD-N9QXoiRKzGBXSqRABkn=Na6GSmkeTL3-82eVEP+VYARp09g@mail.gmail.com>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <CAD-N9QXoiRKzGBXSqRABkn=Na6GSmkeTL3-82eVEP+VYARp09g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/12/24 10:04 PM, Dongliang Mu wrote:
> On Thu, Sep 12, 2024 at 9:48 PM Pengyu Zhang <zpenya1314@gmail.com> wrote:
>>
>> This patch provides a Simplified Chinese translation of the
>> "page_tables.rst" document, aimed at improving accessibility
>> for Chinese-speaking developers and users.
>>
>> The translation prioritizes technical accuracy and readability,
>> ensuring that the content remains clear and informative for
>> its intended audience.：
>>
>> Signed-off-by: Pengyu Zhang <zpenya1314@gmail.com>
>> ---
> 
> Pengyu,
> 
> when you send a next version(e.g., v2), please use the following instruction:
> 
> git format-patch --subject-prefix="PATCH v2"
> 
> Then add changelog after "---", for example,
> 
> v1->v2: fix issues mentioned by Alex, XXX
> 
> This can help reviewers to understand what you have changed to the
> previous version.
> 
>>  .../translations/zh_CN/mm/page_tables.rst     | 205 ++++++++++++++++++
>>  1 file changed, 205 insertions(+)
>>  create mode 100644 Documentation/translations/zh_CN/mm/page_tables.rst
>>
>> diff --git a/Documentation/translations/zh_CN/mm/page_tables.rst b/Documentation/translations/zh_CN/mm/page_tables.rst
>> new file mode 100644
>> index 000000000000..0a17c3cef4d5
>> --- /dev/null
>> +++ b/Documentation/translations/zh_CN/mm/page_tables.rst

you need give a index for this new file, make it could be found and read well in a web browser.
 
>> @@ -0,0 +1,205 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +===========
>> +   页 表
>> +===========

Also the rst file has its meaningful for all kinds of signs, like the
above '=', you need follow its rules,
https://docutils.sourceforge.io/rst.html
https://en.wikipedia.org/wiki/ReStructuredText

For the contents translation part, it looks nice.

Alex

>> +
>> +分页虚拟内存随虚拟内存的概念一起于1962年在Ferranti Atlas计算机上被提出的，
>> +这是第一台有分页虚拟内存的计算机。随着时间推移，这个特性被迁移到更新的计算机上
>> +并且成为所有类Unix系统实际的特性。在1985年，这个特性被包含在了英特尔80386中，
>> +也就是Linux 1.0基于的CPU。
>> +
>> +页表将CPU看到的虚拟地址映射到外部内存总线上看到的物理地址。
>> +
>> +Linux将页表定义为一个分级结构，目前有五级。对于支持的每种架构，其代码会根据硬件限制
>> +对这个层级结构进行映射。
>> +
>> +虚拟地址对应的物理地址通常由底层物理页帧引用。 **页帧号(page frame number， pfn)**
>> +是页的物理地址（在外部内存总线看到的地址）除以 `PAGE_SIZE `得到的值。
>> +
>> +物理内存地址0对应*pfn 0*，而最大的pfn对应处理器外部地址总线所能寻址物理地址的最后一页。
>> +
>> +在页粒度为4KB且地址范围为32位的情况下，pfn 0对应地址0x00000000，pfn 1对应
>> +地址0x00001000，pfn 2对应地址0x00002000，以此类推，直到pfn 0xfffff对应
>> +0xfffff000。如果页粒度为16KB，则pfn分别对应地址0x00004000、
>> +0x00008000...0xffffc000，pfn的范围从0到0x3fffff。
>> +
>> +如你所见，对于4KB页面粒度，页基址使用地址的12-31位，这就是为什么在这种情况下
>> +`PAGE_SHIFT`被定义为12，并且 `PAGE_SIZE`通常由页偏移定义，为 `(1 << PAGE_SHIFT)`。
>> +
>> +随着内存容量的增加，久而久之层级结构逐渐加深。Linux最初使用4KB页面和一个被称为
>> +`swapper_pg_dir` 的页表，该页表拥有1024个条目(entries)，覆盖4MB的内存，事实上Torvald
>> +的第一台计算机正好就有4MB物理内存。条目在这张表中被称为*PTE*:s -页表项(page table entries)。
>> +
>> +软件页表层级结构反映了页表硬件已经变得分层化的事实，而这种分层化的目的是为了
>> +节省页表内存并加快地址映射速度。
>> +
>> +当然，人们可以想象一张拥有大量条目的单一线性的页表将整个内存分为一个个页。而且，这样的
>> +页表会非常稀疏，因为虚拟内存中大部分位置通常是未使用的。通过页表分层，虚拟内存中的大量空洞
>> +不会浪费宝贵的页表内存，因为只需要在上层页表中将大块的区域标记为未映射即可。
>> +
>> +另外，在现代处理器中，上层页表条目可以直接指向一个物理地址范围，这使得单个上层页表条目
>> +可以连续映射几兆字节甚至几千兆字节的内存范围，从而快捷地实现虚拟地址到物理地址的映射：
>> +当你找到一个像这样的大型映射范围时，无需在层级结构中进一步遍历。
>> +
>> +页表的层级结构目前发展为如下所示::
>> +
>> +  +-----+
>> +  | PGD |
>> +  +-----+
>> +     |
>> +     |   +-----+
>> +     +-->| P4D |
>> +         +-----+
>> +            |
>> +            |   +-----+
>> +            +-->| PUD |
>> +                +-----+
>> +                   |
>> +                   |   +-----+
>> +                   +-->| PMD |
>> +                       +-----+
>> +                          |
>> +                          |   +-----+
>> +                          +-->| PTE |
>> +                              +-----+
>> +
>> +
>> +不同页表层级的符号含义从最底层开始如下：
>> +
>> +- **pte**, `pte_t`, `pteval_t` = **页表条目** - 前面提到过.
>> +  *pte*是一个由 `PTRS_PER_PTE`个 `pteval_t`类型元素组成的数组，每个元素将一个
>> +  虚拟内存页映射到一个物理内存页。体系结构定义了 `pteval_t`的大小和内容。
>> +
>> +  一个典型的例子是 `pteval_t`是一个32或者64位的值，其中高位是**pfn**(页帧号)，
>> +  而低位则一些特定体系架构相关的位，如内存保护。
>> +
>> +  **条目(entry)**这个名字有点令人困惑，因为在Linux 1.0中它确实指的是单层顶级页表中的单个
>> +  页表项，但在首次引入二级页表时，它被被重新定义为映射元素的数组。因此，*pte*现在指的
>> +  是最底层的页*表*，而不是一个页表*条目*。
>> +
>> +- **pmd**, `pmd_t`, `pmdval_t` = **页中间目录(Page Middle Directory)**,
>> +  位于*pte*之上的层级结构，包含 `PTRS_PER_PMD` 个指向*pte*的引用。
>> +
>> +- **pud**, `pud_t`, `pudval_t` = **页上级目录(Page Upper Directory)**是
>> +  在其他层级之后引入的，用于处理四级页表。它可能未被使用，或者像我们稍后讨论的那样
>> +  被“折叠”。
>> +
>> +- **p4d**, `p4d_t`, `p4dval_t` = **页四级目录(Page Level 4 Directory)**
>> +  是在*pud*之后用于处理五级页表引入的。至此，显然需要用数字来替代*pgd*、*pmd*、
>> +  *pud*等目录层级的名称，不能再继续使用临时的命名方式。这个目录层级只在实际拥有
>> +  五级页表的系统上使用，否则它会被折叠。
>> +
>> +- **pgd**, `pgd_t`, `pgdval_t` = **页全局目录(Page Global Directory)** -
>> +  Linux内核用于处理内核内存的*PGD*主页表仍然位于 `swapper_pg_dir`。
>> +  但系统中的每个用户空间进程也有自己的内存上下文，因此也有自己的*pgd*，
>> +  它位于 `struct mm_struct`中，而 `struct mm_struct`又在每个 `struct task_struct`
>> +  中有引用。所以，任务（进程）存在一个形式为 `struct mm_struct`的内存上下文，
>> +  而这个结构体中有一个指向指向相应的页全局目录 `struct pgt_t *pgd`指针。
>> +
>> +重申一下：页表层级结构中的每一层都是一个*指针数组*，所以*pgd*包含 `PTRS_PER_PGD` 个
>> +指向下一层的指针，*p4d* 包含 `PTRS_PER_P4D` 个指向 *pud* 项的指针，依此类推。
>> +每一层的指针数量由体系结构定义。::
>> +
>> +        PMD
>> +  --> +-----+           PTE
>> +      | ptr |-------> +-----+
>> +      | ptr |-        | ptr |-------> PAGE
>> +      | ptr | \       | ptr |
>> +      | ptr |  \        ...
>> +      | ... |   \
>> +      | ptr |    \         PTE
>> +      +-----+     +----> +-----+
>> +                         | ptr |-------> PAGE
>> +                         | ptr |
>> +                           ...
>> +
>> +页表折叠
>> +==================
>> +如果架构不使用所有的页表层级，那么这些层级可以被*折叠*，也就是说被跳过。
>> +在访问下一层时，所有在页表上执行的操作都会在编译时增强，以跳过这一层。
>> +
>> +希望与架构无关的页表处理代码（例如虚拟内存管理器）需要编写得能够遍历当前的
>> +所有五个层级。对于特定架构的代码，也应优先采用这种风格，以便对未来的变化具有
>> +更好的适应性。
>> +
>> +MMU, TLB, and 缺页异常
>> +=========================
>> +
>> +`内存管理单元(MMU)`是处理虚拟地址到物理地址转换的硬件组件。它可能会使用
>> +相对较小的硬件缓存，如 `转换后备缓冲区(TLB)`和 `页遍历缓存`，以加快这些地址翻译过程。
>> +
>> +当CPU访存时，它会向MMU提供一个虚拟地址。MMU会首先检查TLB或者页遍历缓存(在支持的架构上)
>> +是否存在对应的转换结果。如果没有，MMU会通过遍历来确定物理地址并且建立映射。
>> +
>> +当页面被写入时，该页的脏位会被设置(即打开)。每个内存页面都有相关的权限位和脏位。后者表明这个页
>> +自从被加载到内存以来是否被修改。
>> +
>> +如果没有任何阻碍，物理内存到头来可以被任意访问并且对物理帧进行请求的操作。
>> +
>> +MMU无法找到某些转换有多种原因。有可能是CPU试图去访问当前进程没有权限访问的内存，
>> +或者因为访问的数据还不在物理内存中。
>> +
>> +当这些情况发生时，MMU会触发缺页异常，这是一种异常类型，用于通知CPU暂停当前执行
>> +并运行一个特殊的函数去处理这些异常。
>> +
>> +缺页异常有一些常见且预期的原因。这些因素是由称为“懒加载”和“写时复制”的进程管理优化技术
>> +来触发。缺页异常也可能发生在当页帧被交换到持久存储(交换分区或者文件)并从其物理地址移出时。
>> +
>> +这些技术提高了内存效率，减少了延迟，并且最小化了空间占用。本文档不会深入讨论“懒加载”
>> +和“写时复制的细节，因为这些的主题属于进程地址管理范畴，超出了本文范围。
>> +
>> +交换技术和前面提到的其他技术不同，因为它是在压力过大下情况下减少内存消耗的一种迫不得已的手段
>> +，因此是不受欢迎的。
>> +
>> +交换不适用于由内核逻辑地址映射的内存。这些地址是内核虚拟地址空间的子集，直接映射
>> +一段连续的物理内存。对于提供的任意逻辑地址，它的物理地址可以通过对偏移量进行简单的
>> +算数运算来确定。对逻辑地址的访问很快，因为这避免了复杂的页表查找，但代价是这些内存
>> +不能被驱逐或置换。
>> +
>> +如果内核无法为必须存在物理帧中的数据腾出空间，那么它会调用内存不足(out-if-memory, OOM)杀手，
>> +通过杀掉低优先级的进程来腾出空间，直到内存压力下降到安全阈值之下。
>> +
>> +另外，代码漏洞或CPU被指示访问的精心制作的恶意地址也可能导致缺页异常。
>> +一个进程的线程可以利用指令来访问不属于其地址空间的(非共享)内存，或者试图执行
>> +写入只读位置的指令。
>> +
>> +如果上述情况发生在用户态，内核会向当前线程发送 `段错误` (SIGSEGV)信号。这信号
>> +通常导致线程及其所属的进程终止。
>> +
>> +本文将简化并概述Linux内核如何处理这些页面错误、创建表和表项、检查内存是否存在，
>> +以及当内存不存在时，如何请求从持久存储或其他设备加载数据，并更新MMU及其缓存。
>> +
>> +前几步取决于设备依赖。大多是架构跳转到 `do_page_fault()`，而x86中断处理程序由
>> +`DEFINE_IDTENTRY_RAW_ERRORCODE()`宏定义的，该宏调用 `handle_page_fault()`。
>> +
>> +无论调用路径如何，所有架构最终都会调用 `handle_mm_fault()`，该函数通常会调用
>> +`__handle_mm_fault()`来执行实际分配页表的任务。
>> +
>> +如果不幸无法调用 `__handle_mm_fault()`则意味着虚拟地址指向了无权访问的物理内存区域
>> +(至少对于当前上下文如此)。这种情况会导致内核向该进程发送上述的SIGSEGV信号，
>> +并引发前面提到的后果。
>> +
>> +查询偏移量的函数有像 `*_offset()`格式的名字，其中“*”代表pgd，p4d，pud，pmd，pte；
>> +而分层分配对应页表的函数命名为 `*_alloc`，使用上述命名约定以层级命名这些函数。
>> +
>> +页表遍历可能在中间或者上层结束(PMD，PUD)。
>> +
>> +Linux支持比通常4KB更大的页面(即所谓的 `大页`)。当使用这种较大的页面时，没有必要使用更低层
>> +的页表项(PTE)。大页通常包含2MB到1GB的大块连续物理区域，分别由PMD和PUD页表项映射。
>> +
>> +大页带来许多好处，如减少TLB压力，减少页表开销，提高内存分配效率，以及改善特定工作
>> +负载的性能。然而，这些好处也伴随着权衡，如内存浪费和分配难度增加。
>> +
>> +在遍历和分配的最后，如果没有返回错误， `__handle_mm_fault()`最终调用 `handle_pte_fault()`
>> +通过 `do_fault()`执行 `do_read_fault()`、 `do_cow_fault()`和 `do_shared_fault()`。
>> +“read”，“cow”和“shared”分别暗示了它处理错误的类型和原因。
>> +
>> +实际的工作流程实现是非常复杂的。其设计允许 Linux 根据每种架构的特定特性处理缺页异常，
>> +同时仍然共享一个通用的整体结构。
>> +
>> +为了总结 Linux 如何处理缺页中断的概述，需要补充的是，缺页异常处理程序可以通过
>> +`pagefault_disable()`和 `pagefault_enable()`分别禁用和启用。
>> +
>> +许多代码路径使用了这两个函数，因为它们需要禁止陷入缺页异常处理程序，主要是为了防止死锁。
>> +
>> --
>> 2.25.1
>>
>>

