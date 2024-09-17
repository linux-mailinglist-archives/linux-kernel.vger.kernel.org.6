Return-Path: <linux-kernel+bounces-331264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA10297AA7A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 05:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8D43B227A6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 03:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4E727442;
	Tue, 17 Sep 2024 03:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILOlg0Ii"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEF81C6A3;
	Tue, 17 Sep 2024 03:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726543371; cv=none; b=NANH3v+ocx+0GokCg+mK1vIazL/jBFGnI7HDGjB8OLitUKY2IZsNiIt5la9+DFHnHnGAoHsR9E8qbEHSbqsIeAXuTbG0KHZLn1zNPjwGk71BXmoariokZ5IL45xiegUav2l5lLAo6w7Y5vUjOPiHaI5xAXS8MX7+iYLMnj1UrPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726543371; c=relaxed/simple;
	bh=oA+WBiiltc86QhQ73GcxPYmdx3xELH0twqcVS0pLxWY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=IINC57NbmUGdzZg5X63dmFvwMXk1ZC/RwLn+mw577ME+cZJXPvB2XrpLhk0Z0bgcY1n+C/1Ta3W+SBHIFetS//9tbXUPtbhgxehpF8+DG3krgKnHzU2wPJ1VDbNAHZxHtB1g1bP82o11auG531OZ2+jTPgrXEaNm10OdsjkyBLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILOlg0Ii; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7db61fd92a1so149949a12.3;
        Mon, 16 Sep 2024 20:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726543369; x=1727148169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HRoDa+OP8QDuDOw6/kSHMLN0m29ZMMXSBvdc4le+TLs=;
        b=ILOlg0IiGxP7DTXmnV+9fDnqV44V++/M0ygomSePo4aL3Vc0qG6oDO0AG+nbw5wWU0
         Hnraw7OMGtYVywDszn9d6loGNwpasNFjzev5Bl64oPWK81zMZovwNukx0y7/blyP4p5h
         +hXqSciBdJZK4R1sYerCDJcaAvlwYFouHeEFdZ+ZgCevawIJoWsrL2l64knNv688uIi7
         7XMNBi8/HYmAcoGL/3u09bsQ/Ftq7TB7DtyA3rEz67i+pybVJLVK9rewyVhouWYC4mzF
         Og+H+YOROQ6F8H8QXCa1AsoH0cVHVw9OOtV0Q2a2/TRdhPAxywmJA303h50p9OavoDUb
         pGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726543369; x=1727148169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HRoDa+OP8QDuDOw6/kSHMLN0m29ZMMXSBvdc4le+TLs=;
        b=JaDw2J6ntlFYSFHhcZG2Jm/yNMaLfHK3f9Ml19iEQ5q4ijfxfgm8STiVIqEhM1DJBU
         LXxxTZ6zZu4EBFyXNtbrqFvwN14cqLRXRD6ckdeEReohgSAnDBK2gxbH/ELI5jR7Nl2I
         OzTx2h3WPvn7Hi2oZ2kBYMaOokGeRJXHbcfKbmzWy3pl3RYHipr4W2FGWNd+w7ws9dhQ
         xI9GKz8kHgCggVlZmFRKhGi4kVJDzHnaqIPdv7eiMlB/DnuD5HpUpmbgZa2z90M2tHA4
         sZayzVxS1ksHIHEoAiEVrj9veQKzoD5Cykvk6PpcFvoWNdMBbbYutjsxCu0jXdHNUsjc
         2xBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsNeSxIzzzGfp8/JogC5f7pyseD7BIAwhnK+mzVAQV8gj+Z8vn+32p8ex4UR3QgJMhSIixlx8QrxUWJ1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOTTT3PX00IGTk1vw9+5blch51fnmQDqRqqTkz2lrvmu8L24RE
	AQVa//R5oPoBu4gkiJjByi/ns8NqwQAcJHhfvLIxXsHVINOKZUIx
X-Google-Smtp-Source: AGHT+IGJilnqTsauTpAVwaCF0Hhts4rbjby8OGDD4jbYSahaHBZW7QD40gUaWT6DzXOnISMzIX//vA==
X-Received: by 2002:a17:903:1d1:b0:205:8820:fe1c with SMTP id d9443c01a7336-2076e361732mr112405635ad.5.1726543368526;
        Mon, 16 Sep 2024 20:22:48 -0700 (PDT)
Received: from aizome.localdomain ([117.172.223.137])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2079475ddd6sm42589735ad.297.2024.09.16.20.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 20:22:48 -0700 (PDT)
From: Pengyu Zhang <zpenya1314@gmail.com>
To: alexs@kernel.org,
	siyanteng@loongson.cn,
	corbet@lwn.net,
	seakeel@gmail.com,
	si.yanteng@linux.dev
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zpenya1314@gmail.com,
	yaxin_wang_uestc@163.com
Subject: [PATCH v2] Docs/zh_CN: Translate page_tables.rst to Simplified Chinese
Date: Tue, 17 Sep 2024 11:22:41 +0800
Message-Id: <20240917032241.27623-1-zpenya1314@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch provides a Simplified Chinese translation of the
"page_tables.rst" document, aimed at improving accessibility
for Chinese-speaking developers and users.

The translation prioritizes technical accuracy and readability,
ensuring that the content remains clear and informative for
its intended audience.

Signed-off-by: Pengyu Zhang <zpenya1314@gmail.com>
---
v1->v2:fix issues mentioned by Alex, Dongliang:
https://lore.kernel.org/linux-doc/3c550784-9b31-4688-80a8-e8ee344e7c3e@gmail.com/
https://lore.kernel.org/linux-doc/CAD-N9QXoiRKzGBXSqRABkn=Na6GSmkeTL3-82eVEP+VYARp09g@mail.gmail.com/
1. Corrected the incorrect use of symbols.
2. Added index for this new file.
3. Adjusted the indentation in the RST file to make it more aesthetically pleasing.
4. Optimized some of the translated sentences.

 Documentation/translations/zh_CN/mm/index.rst |   1 +
 .../translations/zh_CN/mm/page_tables.rst     | 221 ++++++++++++++++++
 2 files changed, 222 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/mm/page_tables.rst

diff --git a/Documentation/translations/zh_CN/mm/index.rst b/Documentation/translations/zh_CN/mm/index.rst
index b950dd118be7..0765d4d9758c 100644
--- a/Documentation/translations/zh_CN/mm/index.rst
+++ b/Documentation/translations/zh_CN/mm/index.rst
@@ -53,6 +53,7 @@ Linux内存管理文档
    page_migration
    page_owner
    page_table_check
+   page_tables.rst
    remap_file_pages
    split_page_table_lock
    vmalloced-kernel-stacks
diff --git a/Documentation/translations/zh_CN/mm/page_tables.rst b/Documentation/translations/zh_CN/mm/page_tables.rst
new file mode 100644
index 000000000000..c280555e74a5
--- /dev/null
+++ b/Documentation/translations/zh_CN/mm/page_tables.rst
@@ -0,0 +1,221 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: Documentation/mm/page_tables.rst
+
+:翻译:
+
+ 张鹏宇 Pengyu Zhang <zpenya1314@gmail.com>
+
+:校译:
+
+====
+页表
+====
+
+分页虚拟内存是随虚拟内存的概念一起于 1962 年在 Ferranti Atlas 计算机上被提出的，
+这是第一台有分页虚拟内存的计算机。随着时间推移，这个特性被迁移到更新的计算机上，
+并且成为所有类 Unix 系统实际的特性。在 1985 年，这个特性被包含在了英特尔 80386
+中，也就是 Linux 1.0 基于的 CPU。
+
+页表将 CPU 看到的虚拟地址映射到外部内存总线上看到的物理地址。
+
+Linux 将页表定义为一个分级结构，目前有五级。对于支持的每种架构，其代码会根据硬件
+限制对这个层级结构进行映射。
+
+虚拟地址对应的物理地址通常由底层物理页帧引用。 **页帧号(page frame number,pfn)**
+是页的物理地址（在外部内存总线看到的地址）除以 `PAGE_SIZE` 得到的值。
+
+物理内存地址 0 对应 *pfn 0*，而最大的 pfn 对应处理器外部地址总线所能寻址物理地址
+的最后一页。
+
+在页粒度为 4KB 且地址范围为32位的情况下，pfn 0 对应地址0x00000000，pfn 1 对应
+地址0x00001000，pfn 2 对应地址 0x00002000，以此类推，直到 pfn 0xfffff 对应
+0xfffff000。如果页粒度为 16KB，则 pfn 分别对应地址 0x00004000、0x00008000
+... 0xffffc000，pfn 的范围从 0 到 0x3fffff。
+
+如你所见，对于 4KB 页面粒度，页基址使用地址的 12-31 位，这就是为什么在这种情况下
+`PAGE_SHIFT` 被定义为 12，并且 `PAGE_SIZE` 通常由页偏移定义，为 `(1 << PAGE_SHIFT)`。
+
+随着内存容量的增加，久而久之层级结构逐渐加深。Linux 最初使用 4KB 页面和一个名为
+`swapper_pg_dir` 的页表，该页表拥有 1024 个条目(entries)，覆盖 4MB 的内存，
+事实上Torvald 的第一台计算机正好就有 4MB 物理内存。条目在这张表中被称为 *PTE*:s
+- 页表条目(page table entries)。
+
+软件页表层级结构反映了页表硬件已经变得分层化的事实，而这种分层化的目的是为了节省
+页表内存并加快地址映射速度。
+
+当然，人们可以想象一张拥有大量条目的单一线性的页表将整个内存分为一个个页。而且，
+这样的页表会非常稀疏，因为虚拟内存中大部分位置通常是未使用的。通过页表分层，虚拟
+内存中的大量空洞不会浪费宝贵的页表内存，因为只需要在上层页表中将大块的区域标记为
+未映射即可。
+
+另外，在现代处理器中，上层页表条目可以直接指向一个物理地址范围，这使得单个上层
+页表条目可以连续映射几兆字节甚至几千兆字节的内存范围，从而快捷地实现虚拟地址到
+物理地址的映射：当你找到一个像这样的大型映射范围时，无需在层级结构中进一步遍历。
+
+页表的层级结构目前发展为如下所示::
+
+  +-----+
+  | PGD |
+  +-----+
+     |
+     |   +-----+
+     +-->| P4D |
+         +-----+
+            |
+            |   +-----+
+            +-->| PUD |
+                +-----+
+                   |
+                   |   +-----+
+                   +-->| PMD |
+                       +-----+
+                          |
+                          |   +-----+
+                          +-->| PTE |
+                              +-----+
+
+
+不同页表层级的符号含义从最底层开始如下：
+
+- **pte**, `pte_t`, `pteval_t` = **页表条目** - 前面提到过。*pte* 是一个由
+  `PTRS_PER_PTE` 个 `pteval_t` 类型元素组成的数组，每个元素将一个虚拟内存页
+  映射到一个物理内存页。体系结构定义了 `pteval_t` 的大小和内容。
+
+  一个典型的例子是 `pteval_t` 是一个 32 或者 64 位的值，其中高位是 **pfn**，
+  而低位则一些特定体系架构相关的位，如内存保护。
+
+  这个 **条目(entry)** 有点令人困惑，因为在 Linux 1.0 中它确实指的是单层顶级
+  页表中的单个页表条目，但在首次引入二级页表时，它被重新定义为映射元素的数组。
+  因此，*pte* 现在指的是最底层的页 *表*，而不是一个页表 *条目*。
+
+- **pmd**, `pmd_t`, `pmdval_t` = **页中间目录(Page Middle Directory)**,
+  位于 *pte* 之上的层级结构，包含 `PTRS_PER_PMD` 个指向 *pte* 的引用。
+
+- **pud**, `pud_t`, `pudval_t` = **页上级目录(Page Upper Directory)**
+  是在其他层级之后引入的，用于处理四级页表。它可能未被使用，或者像我们稍后
+  讨论的那样被“折叠”。
+
+- **p4d**, `p4d_t`, `p4dval_t` = **页四级目录(Page Level 4 Directory)**
+  是在 *pud* 之后用于处理五级页表引入的。至此，显然需要用数字来替代 *pgd*、
+  *pmd*、*pud* 等目录层级的名称，不能再继续使用临时的命名方式。这个目录层级
+  只在实际拥有五级页表的系统上使用，否则它会被折叠。
+
+- **pgd**, `pgd_t`, `pgdval_t` = **页全局目录(Page Global Directory)** -
+  Linux 内核用于处理内核内存的 *PGD* 主页表仍然位于 `swapper_pg_dir`。
+  但系统中的每个用户空间进程也有自己的内存上下文，因此也有自己的 *pgd*，
+  它位于 `struct mm_struct` 中，而 `struct mm_struct` 又在每个 `struct task_struct`
+  中有引用。所以，任务（进程）存在一个形式为 `struct mm_struct` 的内存上下文，
+  而这个结构体中有一个指向指向相应的页全局目录 `struct pgt_t *pgd` 指针。
+
+重申一下：页表层级结构中的每一层都是一个 *指针数组*，所以 *pgd* 包含 `PTRS_PER_PGD`
+个指向下一层的指针，*p4d* 包含 `PTRS_PER_P4D` 个指向 *pud* 项的指针，依此类推。
+每一层的指针数量由体系结构定义。::
+
+        PMD
+  --> +-----+           PTE
+      | ptr |-------> +-----+
+      | ptr |-        | ptr |-------> PAGE
+      | ptr | \       | ptr |
+      | ptr |  \        ...
+      | ... |   \
+      | ptr |    \         PTE
+      +-----+     +----> +-----+
+                         | ptr |-------> PAGE
+                         | ptr |
+                           ...
+
+页表折叠
+========
+
+如果架构不使用所有的页表层级，那么这些层级可以被 *折叠*，也就是说被跳过。在
+访问下一层时，所有在页表上执行的操作都会在编译时增强，以跳过这一层。
+
+与架构无关的页表处理代码（例如虚拟内存管理器）需要编写得能够遍历当前的所有五个
+层级。对于特定架构的代码，也应优先采用这种风格，以便对未来的变化具有更好的适应性。
+
+MMU，TLB 和缺页异常
+===================
+
+`内存管理单元(MMU)` 是处理虚拟地址到物理地址转换的硬件组件。它可能会使用相对较小
+的硬件缓存，如 `转换后备缓冲区(TLB)` 和 `页遍历缓存`，以加快这些地址翻译过程。
+
+当 CPU 访存时，它会向 MMU 提供一个虚拟地址。MMU 会首先检查 TLB 或者页遍历缓存
+（在支持的架构上）是否存在对应的转换结果。如果没有，MMU 会通过遍历来确定物理地址
+并且建立映射。
+
+当页面被写入时，该页的脏位会被设置（即打开）。每个内存页面都有相关的权限位和脏位。
+后者表明这个页自从被加载到内存以来是否被修改。
+
+如果没有任何阻碍，物理内存到头来可以被任意访问并且对物理帧进行请求的操作。
+
+MMU 无法找到某些转换有多种原因。有可能是 CPU 试图去访问当前进程没有权限访问的
+内存，或者因为访问的数据还不在物理内存中。
+
+当这些情况发生时，MMU 会触发缺页异常，这是一种异常类型，用于通知 CPU 暂停当前
+执行并运行一个特殊的函数去处理这些异常。
+
+缺页异常有一些常见且预期的原因。这些因素是由称为“懒加载”和“写时复制”的进程管理
+优化技术来触发的。缺页异常也可能发生在当页帧被交换到持久存储（交换分区或者文件）
+并从其物理地址移出时。
+
+这些技术提高了内存效率，减少了延迟，并且最小化了空间占用。本文档不会深入讨论
+“懒加载”和“写时复制”的细节，因为这些的主题属于进程地址管理范畴，超出了本文范围。
+
+交换技术和前面提到的其他技术不同，因为它是在压力过大下情况下减少内存消耗的一种
+迫不得已的手段，因此是不受欢迎的。
+
+交换不适用于由内核逻辑地址映射的内存。这些地址是内核虚拟地址空间的子集，直接映射
+一段连续的物理内存。对于提供的任意逻辑地址，它的物理地址可以通过对偏移量进行简单
+的算数运算来确定。对逻辑地址的访问很快，因为这避免了复杂的页表查找，但代价是这些
+内存不能被驱逐或置换。
+
+如果内核无法为必须存在于物理帧中的数据腾出空间，那么它会调用内存不足(out-of-memory,
+OOM)杀手，通过杀掉低优先级的进程来腾出空间，直到内存压力下降到安全阈值之下。
+
+另外，代码漏洞或指示 CPU 访问的精心制作的恶意地址也可能导致缺页异常。一个进程的
+线程可以利用指令来访问不属于其地址空间的（非共享）内存，或者试图执行写入只读位置
+的指令。
+
+如果上述情况发生在用户态，内核会向当前线程发送 `段错误` (SIGSEGV)信号。该信号
+通常导致线程及其所属的进程终止。
+
+本文将简化并概述 Linux 内核如何处理这些页面错误、创建表和表项、检查内存是否存在，
+以及当内存不存在时，如何请求从持久存储或其他设备加载数据，并更新 MMU 及其缓存。
+
+前几步取决于设备依赖。大多是架构跳转到 `do_page_fault()`，而 x86 中断处理程序由
+`DEFINE_IDTENTRY_RAW_ERRORCODE()` 宏定义的，该宏调用 `handle_page_fault()`。
+
+无论调用路径如何，所有架构最终都会调用 `handle_mm_fault()`，该函数通常会调用
+`__handle_mm_fault()` 来执行实际分配页表的任务。
+
+如果不幸无法调用 `__handle_mm_fault()` 则意味着虚拟地址指向了无权访问的物理
+内存区域（至少对于当前上下文如此）。这种情况会导致内核向该进程发送上述的 SIGSEGV
+信号，并引发前面提到的后果。
+
+这些用于查找偏移量的函数名称通常以 `*_offset()` 结尾，其中“\*”可以是 pgd，p4d，
+pud，pmd 或者 pte；而分配相应层级页表的函数名称是 `*_alloc`，它们按照上述命名
+约定以对应页表层级的类型命名。
+
+页表遍历可能在中间或者上层结束(PMD，PUD)。
+
+Linux 支持比通常 4KB 更大的页面（即所谓的 `巨页`）。当使用这种较大的页面时，没有
+必要使用更低层的页表项(PTE)。巨页通常包含 2MB 到 1GB 的大块连续物理区域，分别由
+PMD 和 PUD 页表项映射。
+
+巨页带来许多好处，如减少 TLB 压力，减少页表开销，提高内存分配效率，以及改善
+特定工作负载的性能。然而，这些好处也伴随着权衡，如内存浪费和分配难度增加。
+
+在遍历和分配的最后，如果没有返回错误， `__handle_mm_fault()` 最终调用`handle_pte_fault()`
+通过 `do_fault()` 执行 `do_read_fault()`、 `do_cow_fault()` 和 `do_shared_fault()`。
+“read”，“cow”和“shared”分别暗示了它处理错误的类型和原因。
+
+实际的工作流程实现是非常复杂的。其设计允许 Linux 根据每种架构的特定特性处理缺页
+异常，同时仍然共享一个通用的整体结构。
+
+为了总结 Linux 如何处理缺页中断的概述，需要补充的是，缺页异常处理程序可以通过
+`pagefault_disable()` 和 `pagefault_enable()` 分别禁用和启用。
+
+许多代码路径使用了这两个函数，因为它们需要禁止陷入缺页异常处理程序，主要是为了
+防止死锁。
-- 
2.25.1


