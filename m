Return-Path: <linux-kernel+bounces-185239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BE48CB288
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 18:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98F4B283DFA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 16:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0DC130A54;
	Tue, 21 May 2024 16:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4bvxn6Y"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6683B1A1;
	Tue, 21 May 2024 16:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716310488; cv=none; b=Sedejg41Rif2zocDqtVEb3uAfplJWtLIScwI5d56tA4Vmha+6Cc6eB4+P6668GhJrz73vt/O4UFLccjMlMXLwfHN/lXpsdHxErT5ZXP5vXdGXSRjPLWuX6vFzdkeR7KCXa5gzRr5G5L4zuLhKhjm1/cV8v7uruzEQWah+rQU8cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716310488; c=relaxed/simple;
	bh=DCQPlyEtD6UL6L8EecNmTojAZtFsW6r4nV1Dgnw5RBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YbHlWtFEOrZhXZRNVmbwvjbmiJKE0IHTcLhhyX9CDlKwra3/G/r2Hc3dSX3vcZjwUxWl/ncgLxoJM0zMXdnp4i3ZDXeywaQhCHp1MW69LUJl9wKDcv3fHxOJ7VTxPpSTB2ptuXSThmR2bf9T4DtTMPpn8oI0W+9gLJY/EedM0KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4bvxn6Y; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6f4472561f1so657800b3a.0;
        Tue, 21 May 2024 09:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716310485; x=1716915285; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WuEQUeb1KaTEdUftf4fhnMniPpMB8bxPHr/z84gdcd0=;
        b=H4bvxn6YpJCq29nv1OpkxBnDHP/GQe6U21a2F+Hh7kuVEyq1/PxeYvV2+2TqFyINTc
         kD4D3vx4vNkig/VEhw19Kggp3amuncCd8tMgdVIr3Q3WQUAFQnQ2Dssl6ayu+H/WzCDv
         xDBwESFI7trUxWcao/h6VHmM/qePujaZa/CMCxtqSiI8npngLraTJEOYFSh/+AqTdPJz
         TIWaV40A9yUHY5MgACSsiFeZDTxkYOzrPjyyt81980OUhZp0Gm9YQA/8IVmAZ1l47cNX
         xbUM73YkjcHDlDP73MucdhdsnMvvbIdYSWZHYwd0t6CCNaTjznqiq3oFJbkzzGuUU8l9
         EhoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716310485; x=1716915285;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WuEQUeb1KaTEdUftf4fhnMniPpMB8bxPHr/z84gdcd0=;
        b=S43x/LOlp1QdiFsl2QhKl+tB/hizqNlN3JbH6gbY1cTw8U+Xix7sXd9zEZGgU6W3Fr
         iCr2dlT2ibFlKQVOH5IlFQteZee2moxh/BFJ71aRng0dQoJzzeXSsokDx88Kljyy6fbG
         WG0uRgfMQ3BIGfpfc6tjLF+Mv/f29Lt8JBE0aRWZBvTs7GsUZ+j8f1XsoF+SnFcJSATG
         7cyZORb9J7zeswqq5iztG9lNDuPPHqD62ML+A7ChfpZvNIxBGjlHFeSP4p5NDaDL5RHs
         ah9YulekPAIT5x458xE+TBSv01l+YPg8wOZ33GEZPpEVzJB8HdxJFtyu2HKZ2ca3iI1C
         xW5g==
X-Forwarded-Encrypted: i=1; AJvYcCXbTATPbP07ZPT75NjzIFF0OHN/V/oOU1z4aQV5y5eK2tBhbvi+J/r968sjtCRI2Dj48Ay+El6CegGgSv/eLCG20+DnepY+ob04KuUPWUwbmUVr65t1yyy6eE0MI1NPnlBvAp6suoe8
X-Gm-Message-State: AOJu0YznjrvN7h7IIx0uy5/EOtt2/Z33ErRy5P65JC1FX60N6Q1xX18O
	NvmiA4HWPhfNrq3aa7VhXBlzHYk0nM/1WPVuBNH21bO7FD6J1o8r
X-Google-Smtp-Source: AGHT+IHVWmTCk439B7IigsyL+tejxSl1EIS0bslOY8VruvEWDD2tItZc1WMjvoIoBQyYtNy8cdKyLQ==
X-Received: by 2002:a05:6a00:39a5:b0:6f0:c88e:a0dd with SMTP id d2e1a72fcca58-6f4e0384b45mr42358266b3a.28.1716310485191;
        Tue, 21 May 2024 09:54:45 -0700 (PDT)
Received: from [10.4.10.38] (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a828e2sm21018166b3a.72.2024.05.21.09.54.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 09:54:44 -0700 (PDT)
Message-ID: <2b8cea32-b460-4152-8c7e-964031eed990@gmail.com>
Date: Tue, 21 May 2024 12:54:34 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ptdump: add intermediate directory support
To: Maxwell Bland <mbland@motorola.com>, linux-mm@kvack.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
 Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Alexandre Ghiti <alexghiti@rivosinc.com>,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <fik5ys53dbkpkl22o4s7sw7cxi6dqjcpm2f3kno5tyms73jm5y@buo4jsktsnrt>
Content-Language: en-US
From: Jesse Taube <mr.bossman075@gmail.com>
In-Reply-To: <fik5ys53dbkpkl22o4s7sw7cxi6dqjcpm2f3kno5tyms73jm5y@buo4jsktsnrt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/30/24 12:05, Maxwell Bland wrote:
> Add an optional note_non_leaf parameter to ptdump, causing note_page to
> be called on non-leaf descriptors. Implement this functionality on arm64
> by printing table descriptors along with table-specific permission sets.
> 
> For arm64, break (1) the uniform number of columns for each descriptor,
> and (2) the coalescing of large PTE regions, which are now split up by
> PMD. This is a "good" thing since it makes the behavior and protection
> bits set on page tables, such as PXNTable, more explicit.
> 
> Before:
> 0xffff008440210000-0xffff008440400000 1984K PTE ro NX SHD AF NG UXN M...
> 0xffff008440400000-0xffff008441c00000 24M PMD ro NX SHD AF NG BLK UXN...
> 0xffff008441c00000-0xffff008441dc0000 1792K PTE ro NX SHD AF NG UXN M...
> 0xffff008441dc0000-0xffff00844317b000 20204K PTE RW NX SHD AF NG UXN ...
> 
> After (tabulation omitted and spaces condensed):
> 0xffff0fb640200000-0xffff0fb640400000 2M PMD TBL RW x NXTbl UXNTbl ME...
> 0xffff0fb640200000-0xffff0fb640210000 64K PTE RW NX SHD AF NG UXN MEM...
> 0xffff0fb640210000-0xffff0fb640400000 1984K PTE ro NX SHD AF NG UXN M...
> 0xffff0fb640400000-0xffff0fb641c00000 24M PMD BLK ro SHD AF NG NX UXN...
> 0xffff0fb641c00000-0xffff0fb641e00000 2M PMD TBL RW x NXTbl UXNTbl ME...
> 0xffff0fb641c00000-0xffff0fb641dc0000 1792K PTE ro NX SHD AF NG UXN M...
> 0xffff0fb641dc0000-0xffff0fb641e00000 256K PTE RW NX SHD AF NG UXN ME...
> 
> v3:
>    - Added tabulation to delineate entries
>    - Fixed formatting issues with mailer and rebased to mm/linus
> 
> v2:
>    - Rebased onto linux-next/akpm (the incorrect branch)

Typically the patch versions go in the additional comments section under 
the ---
https://www.kernel.org/doc/html/v4.13/process/submitting-patches.html#the-canonical-patch-format

> 
> Signed-off-by: Maxwell Bland <mbland@motorola.com>

When you reply the email client(and git send-email???) seems to send it 
twice?
Very odd im suprised the server didnt filter the dup.
https://lore.kernel.org/all/ZjIwiFa3CMxxtAZ1@arm.com/

> ---
> Thank you again to the maintainers for your review of this patch.
> 
> To Andrew Morton, I apologize for the malformatted patches last week.It
> will hopefully never happen again. I have tested mailing this patch to
> myself and have confirmed it cleanly merges to mm/linus.
> 
>   Documentation/arch/arm64/ptdump.rst | 184 +++++++++++++---------

Typicaly docs are seperated into a seperate commit and sent as a set.

>   arch/arm64/mm/ptdump.c              | 230 +++++++++++++++++++++++++---

As said by Catalin anything that can be seperated into smaller patches 
should be.

>   include/linux/ptdump.h              |   1 +
>   mm/ptdump.c                         |  13 ++
>   4 files changed, 332 insertions(+), 96 deletions(-)
> 
> diff --git a/Documentation/arch/arm64/ptdump.rst b/Documentation/arch/arm64/ptdump.rst
> index 5dcfc5d7cddf..350eea06300e 100644
> --- a/Documentation/arch/arm64/ptdump.rst
> +++ b/Documentation/arch/arm64/ptdump.rst
> @@ -2,25 +2,24 @@
>   Kernel page table dump
>   ======================
>   
> -ptdump is a debugfs interface that provides a detailed dump of the
> -kernel page tables. It offers a comprehensive overview of the kernel
> -virtual memory layout as well as the attributes associated with the
> -various regions in a human-readable format. It is useful to dump the
> -kernel page tables to verify permissions and memory types. Examining the
> -page table entries and permissions helps identify potential security
> -vulnerabilities such as mappings with overly permissive access rights or
> -improper memory protections.
> +ptdump is a debugfs interface that provides a detailed dump of the kernel page
> +tables. It offers a comprehensive overview of the kernel virtual memory layout
> +as well as the attributes associated with the various regions in a
> +human-readable format. It is useful to dump the kernel page tables to verify
> +permissions and memory types. Examining the page table entries and permissions
> +helps identify potential security vulnerabilities such as mappings with overly
> +permissive access rights or improper memory protections.
>   
> -Memory hotplug allows dynamic expansion or contraction of available
> -memory without requiring a system reboot. To maintain the consistency
> -and integrity of the memory management data structures, arm64 makes use
> -of the ``mem_hotplug_lock`` semaphore in write mode. Additionally, in
> -read mode, ``mem_hotplug_lock`` supports an efficient implementation of
> -``get_online_mems()`` and ``put_online_mems()``. These protect the
> -offlining of memory being accessed by the ptdump code.
> +Memory hotplug allows dynamic expansion or contraction of available memory
> +without requiring a system reboot. To maintain the consistency and integrity of
> +the memory management data structures, arm64 makes use of the
> +``mem_hotplug_lock`` semaphore in write mode. Additionally, in read mode,
> +``mem_hotplug_lock`` supports an efficient implementation of
> +``get_online_mems()`` and ``put_online_mems()``. These protect the offlining of
> +memory being accessed by the ptdump code.
>   
> -In order to dump the kernel page tables, enable the following
> -configurations and mount debugfs::
> +In order to dump the kernel page tables, enable the following configurations
> +and mount debugfs::
>   
>    CONFIG_GENERIC_PTDUMP=y
>    CONFIG_PTDUMP_CORE=y
> @@ -29,68 +28,101 @@ configurations and mount debugfs::
>    mount -t debugfs nodev /sys/kernel/debug
>    cat /sys/kernel/debug/kernel_page_tables
>   
> -On analysing the output of ``cat /sys/kernel/debug/kernel_page_tables``
> -one can derive information about the virtual address range of the entry,
> -followed by size of the memory region covered by this entry, the
> -hierarchical structure of the page tables and finally the attributes
> -associated with each page. The page attributes provide information about
> -access permissions, execution capability, type of mapping such as leaf
> -level PTE or block level PGD, PMD and PUD, and access status of a page
> -within the kernel memory. Assessing these attributes can assist in
> -understanding the memory layout, access patterns and security
> -characteristics of the kernel pages.
> +On analysing the output of ``cat /sys/kernel/debug/kernel_page_tables`` one can
> +derive information about the virtual address range of a contiguous group of
> +page table entries, followed by size of the memory region covered by this
> +group, the hierarchical structure of the page tables and finally the attributes
> +associated with each page in the group. Groups are broken up either according
> +to a change in attributes or by parent descriptor, such as a PMD. Note that the
> +set of attributes, and therefore formatting, is not equivalent between entry
> +types. For example, PMD entries have a separate set of attributes from leaf
> +level PTE entries, because they support both the UXNTable and PXNTable
> +permission bits.
> +
> +The page attributes provide information about access permissions, execution
> +capability, type of mapping such as leaf level PTE or block level PGD, PMD and
> +PUD, and access status of a page within the kernel memory. Non-PTE block or
> +page level entries are denoted with either "BLK" or "TBL", respectively.
> +Assessing these attributes can assist in understanding the memory layout,
> +access patterns and security characteristics of the kernel pages.
>   
>   Kernel virtual memory layout example::
>   
> - start address        end address         size             attributes
> - +---------------------------------------------------------------------------------------+
> - | ---[ Linear Mapping start ]---------------------------------------------------------- |
> - | ..................                                                                    |
> - | 0xfff0000000000000-0xfff0000000210000  2112K PTE RW NX SHD AF  UXN  MEM/NORMAL-TAGGED |
> - | 0xfff0000000210000-0xfff0000001c00000 26560K PTE ro NX SHD AF  UXN  MEM/NORMAL        |
> - | ..................                                                                    |
> - | ---[ Linear Mapping end ]------------------------------------------------------------ |
> - +---------------------------------------------------------------------------------------+
> - | ---[ Modules start ]----------------------------------------------------------------- |
> - | ..................                                                                    |
> - | 0xffff800000000000-0xffff800008000000   128M PTE                                      |
> - | ..................                                                                    |
> - | ---[ Modules end ]------------------------------------------------------------------- |
> - +---------------------------------------------------------------------------------------+
> - | ---[ vmalloc() area ]---------------------------------------------------------------- |
> - | ..................                                                                    |
> - | 0xffff800008010000-0xffff800008200000  1984K PTE ro x  SHD AF       UXN  MEM/NORMAL   |
> - | 0xffff800008200000-0xffff800008e00000    12M PTE ro x  SHD AF  CON  UXN  MEM/NORMAL   |
> - | ..................                                                                    |
> - | ---[ vmalloc() end ]----------------------------------------------------------------- |
> - +---------------------------------------------------------------------------------------+
> - | ---[ Fixmap start ]------------------------------------------------------------------ |
> - | ..................                                                                    |
> - | 0xfffffbfffdb80000-0xfffffbfffdb90000    64K PTE ro x  SHD AF  UXN  MEM/NORMAL        |
> - | 0xfffffbfffdb90000-0xfffffbfffdba0000    64K PTE ro NX SHD AF  UXN  MEM/NORMAL        |
> - | ..................                                                                    |
> - | ---[ Fixmap end ]-------------------------------------------------------------------- |
> - +---------------------------------------------------------------------------------------+
> - | ---[ PCI I/O start ]----------------------------------------------------------------- |
> - | ..................                                                                    |
> - | 0xfffffbfffe800000-0xfffffbffff800000    16M PTE                                      |
> - | ..................                                                                    |
> - | ---[ PCI I/O end ]------------------------------------------------------------------- |
> - +---------------------------------------------------------------------------------------+
> - | ---[ vmemmap start ]----------------------------------------------------------------- |
> - | ..................                                                                    |
> - | 0xfffffc0002000000-0xfffffc0002200000     2M PTE RW NX SHD AF  UXN  MEM/NORMAL        |
> - | 0xfffffc0002200000-0xfffffc0020000000   478M PTE                                      |
> - | ..................                                                                    |
> - | ---[ vmemmap end ]------------------------------------------------------------------- |
> - +---------------------------------------------------------------------------------------+
> + start address        end address         size type  leaf    attributes
> + +-----------------------------------------------------------------------------------------------------------------+
> + | ---[ Linear Mapping start ]---                                                                                  |
> + | ...                                                                                                             |
> + | 0xffff0d02c3200000-0xffff0d02c3400000    2M PMD   TBL     RW               x      NXTbl UXNTbl    MEM/NORMAL    |
> + | 0xffff0d02c3200000-0xffff0d02c3218000   96K PTE           ro NX SHD AF NG     UXN    MEM/NORMAL-TAGGED          |
> + | 0xffff0d02c3218000-0xffff0d02c3250000  224K PTE           RW NX SHD AF NG     UXN    MEM/NORMAL-TAGGED          |
> + | 0xffff0d02c3250000-0xffff0d02c33b3000 1420K PTE           ro NX SHD AF NG     UXN    MEM/NORMAL-TAGGED          |
> + | 0xffff0d02c33b3000-0xffff0d02c3400000  308K PTE           RW NX SHD AF NG     UXN    MEM/NORMAL-TAGGED          |
> + | 0xffff0d02c3400000-0xffff0d02c3600000    2M PMD   TBL     RW               x      NXTbl UXNTbl    MEM/NORMAL    |
> + | 0xffff0d02c3400000-0xffff0d02c3600000    2M PTE           RW NX SHD AF NG     UXN    MEM/NORMAL-TAGGED          |
> + | ...                                                                                                             |
> + | 0xffff0d02c3200000-0xffff0d02c3400000    2M PMD   TBL     RW               x      NXTbl UXNTbl    MEM/NORMAL    |
> + | ...                                                                                                             |
> + | ---[ Linear Mapping end ]---                                                                                    |
> + +-----------------------------------------------------------------------------------------------------------------+
> + | ---[ Modules start ]---                                                                                         |
> + | ...                                                                                                             |
> + | 0xffff800000000000-0xffff800000000080 128B PGD   TBL     RW               x     UXNTbl    MEM/NORMAL            |
> + | 0xffff800000000000-0xffff800080000000   2G PUD F BLK     RW               x               MEM/NORMAL            |
> + | ...                                                                                                             |
> + | ---[ Modules end ]---                                                                                           |
> + +-----------------------------------------------------------------------------------------------------------------+
> + | ---[ vmalloc() area ]---                                                                                        |
> + | ...                                                                                                             |
> + | 0xffff800080000000-0xffff8000c0000000   1G PUD   TBL     RW               x     UXNTbl    MEM/NORMAL            |
> + | ...                                                                                                             |
> + | 0xffff800080200000-0xffff800080400000   2M PMD   TBL     RW               x      NXTbl UXNTbl    MEM/NORMAL     |
> + | 0xffff800080200000-0xffff80008022f000 188K PTE           RW NX SHD AF NG     UXN    MEM/NORMAL                  |

It's probably good to add another space between F and BLK to show that F 
is related to the type? Also maybe add docs as to what it means, but I 
may just be dumb and its obvious to others.

> + | 0xffff80008022f000-0xffff800080230000   4K PTE F BLK     RW x                       MEM/NORMAL                  |
> + | 0xffff800080230000-0xffff800080233000  12K PTE           RW NX SHD AF NG     UXN    MEM/NORMAL                  |
> + | 0xffff800080233000-0xffff800080234000   4K PTE F BLK     RW x                       MEM/NORMAL                  |
> + | 0xffff800080234000-0xffff800080237000  12K PTE           RW NX SHD AF NG     UXN    MEM/NORMAL                  |
> + | ...                                                                                                             |
> + | 0xffff800080400000-0xffff800084000000  60M PMD F BLK     RW               x      x     x         MEM/NORMAL     |
> + | ...                                                                                                             |
> + | ---[ vmalloc() end ]---                                                                                         |
> + +-----------------------------------------------------------------------------------------------------------------+
> + | ---[ vmemmap start ]---                                                                                         |
> + | ...                                                                                                             |
> + | 0xfffffe33cb000000-0xfffffe33cc000000  16M PMD   BLK     RW SHD AF NG     NX UXN x     x         MEM/NORMAL     |
> + | 0xfffffe33cc000000-0xfffffe3400000000 832M PMD F BLK     RW               x      x     x         MEM/NORMAL     |
> + | ...                                                                                                             |
> + | ---[ vmemmap end ]---                                                                                           |
> + +-----------------------------------------------------------------------------------------------------------------+
> + | ---[ PCI I/O start ]---                                                                                         |
> + | ...                                                                                                             |
> + | 0xffffffffc0800000-0xffffffffc0810000 64K PTE           RW NX SHD AF NG     UXN    DEVICE/nGnRE                 |
> + | ...                                                                                                             |
> + | ---[ PCI I/O end ]---                                                                                           |
> + +-----------------------------------------------------------------------------------------------------------------+
> + | ---[ Fixmap start ]---                                                                                          |
> + | ...                                                                                                             |
> + | 0xffffffffff5f6000-0xffffffffff5f9000 12K PTE           ro x  SHD AF        UXN    MEM/NORMAL                   |
> + | 0xffffffffff5f9000-0xffffffffff5fa000  4K PTE           ro NX SHD AF NG     UXN    MEM/NORMAL                   |
> + | ...                                                                                                             |
> + | ---[ Fixmap end ]---                                                                                            |
> + +-----------------------------------------------------------------------------------------------------------------+
>   
>   ``cat /sys/kernel/debug/kernel_page_tables`` output::
>   
> - 0xfff0000001c00000-0xfff0000080000000     2020M PTE  RW NX SHD AF   UXN    MEM/NORMAL-TAGGED
> - 0xfff0000080000000-0xfff0000800000000       30G PMD
> - 0xfff0000800000000-0xfff0000800700000        7M PTE  RW NX SHD AF   UXN    MEM/NORMAL-TAGGED
> - 0xfff0000800700000-0xfff0000800710000       64K PTE  ro NX SHD AF   UXN    MEM/NORMAL-TAGGED
> - 0xfff0000800710000-0xfff0000880000000  2089920K PTE  RW NX SHD AF   UXN    MEM/NORMAL-TAGGED
> - 0xfff0000880000000-0xfff0040000000000     4062G PMD
> - 0xfff0040000000000-0xffff800000000000     3964T PGD
> + 0xffff000000000000-0xffff020000000000           2T PGD
> + 0xffff020000000000-0xffff020000000080         128B PGD   TBL     RW               NXTbl UXNTbl    MEM/NORMAL
> +     0xffff020000000000-0xffff023080000000         194G PUD
> +     0xffff023080000000-0xffff0230c0000000           1G PUD   TBL     RW               NXTbl UXNTbl    MEM/NORMAL
> +       0xffff023080000000-0xffff023080200000           2M PMD   TBL     RW               x      NXTbl UXNTbl    MEM/NORMAL
> +         0xffff023080000000-0xffff023080200000           2M PTE           RW NX SHD AF NG     UXN    MEM/NORMAL-TAGGED
> +       0xffff023080200000-0xffff023080400000           2M PMD   TBL     RW               x      NXTbl UXNTbl    MEM/NORMAL
> +         0xffff023080200000-0xffff023080210000          64K PTE           RW NX SHD AF NG     UXN    MEM/NORMAL-TAGGED
> +         0xffff023080210000-0xffff023080400000        1984K PTE           ro NX SHD AF NG     UXN    MEM/NORMAL
> +       0xffff023080400000-0xffff023081c00000          24M PMD   BLK     ro SHD AF NG     NX UXN x     x         MEM/NORMAL
> +       0xffff023081c00000-0xffff023081e00000           2M PMD   TBL     RW               x      NXTbl UXNTbl    MEM/NORMAL
> +         0xffff023081c00000-0xffff023081dd0000        1856K PTE           ro NX SHD AF NG     UXN    MEM/NORMAL
> +         0xffff023081dd0000-0xffff023081e00000         192K PTE           RW NX SHD AF NG     UXN    MEM/NORMAL-TAGGED
> +       0xffff023081e00000-0xffff023082000000           2M PMD   TBL     RW               x      NXTbl UXNTbl    MEM/NORMAL
> +         0xffff023081e00000-0xffff023082000000           2M PTE           RW NX SHD AF NG     UXN    MEM/NORMAL-TAGGED
> +       0xffff023082000000-0xffff023082200000           2M PMD   TBL     RW               x      NXTbl UXNTbl    MEM/NORMAL
> +         0xffff023082000000-0xffff023082200000           2M PTE           RW NX SHD AF NG     UXN    MEM/NORMAL-TAGGED
> diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
> index 6986827e0d64..bd4f1df0c444 100644
> --- a/arch/arm64/mm/ptdump.c
> +++ b/arch/arm64/mm/ptdump.c
> @@ -24,6 +24,7 @@
>   #include <asm/memory.h>
>   #include <asm/pgtable-hwdef.h>
>   #include <asm/ptdump.h>
> +#include <asm/pgalloc.h>
>   
>   
>   #define pt_dump_seq_printf(m, fmt, args...)	\
> @@ -70,6 +71,11 @@ static const struct prot_bits pte_bits[] = {
>   		.val	= PTE_VALID,
>   		.set	= " ",
>   		.clear	= "F",
> +	}, {
> +		.mask	= PTE_TABLE_BIT,
> +		.val	= PTE_TABLE_BIT,
> +		.set	= "   ",
> +		.clear	= "BLK",
>   	}, {
>   		.mask	= PTE_USER,
>   		.val	= PTE_USER,
> @@ -105,11 +111,6 @@ static const struct prot_bits pte_bits[] = {
>   		.val	= PTE_CONT,
>   		.set	= "CON",
>   		.clear	= "   ",
> -	}, {
> -		.mask	= PTE_TABLE_BIT,
> -		.val	= PTE_TABLE_BIT,
> -		.set	= "   ",
> -		.clear	= "BLK",
>   	}, {
>   		.mask	= PTE_UXN,
>   		.val	= PTE_UXN,
> @@ -143,34 +144,208 @@ static const struct prot_bits pte_bits[] = {
>   	}
>   };
>   
> +static const struct prot_bits pmd_bits[] = {
> +	{
> +		.mask	= PMD_SECT_VALID,
> +		.val	= PMD_SECT_VALID,
> +		.set	= " ",
> +		.clear	= "F",
> +	}, {
> +		.mask	= PMD_TABLE_BIT,
> +		.val	= PMD_TABLE_BIT,
> +		.set	= "TBL",
> +		.clear	= "BLK",
> +	}, {
> +		.mask	= PMD_SECT_USER,
> +		.val	= PMD_SECT_USER,
> +		.set	= "USR",
> +		.clear	= "   ",
> +	}, {
> +		.mask	= PMD_SECT_RDONLY,
> +		.val	= PMD_SECT_RDONLY,
> +		.set	= "ro",
> +		.clear	= "RW",
> +	}, {
> +		.mask	= PMD_SECT_S,
> +		.val	= PMD_SECT_S,
> +		.set	= "SHD",
> +		.clear	= "   ",
> +	}, {
> +		.mask	= PMD_SECT_AF,
> +		.val	= PMD_SECT_AF,
> +		.set	= "AF",
> +		.clear	= "  ",
> +	}, {
> +		.mask	= PMD_SECT_NG,
> +		.val	= PMD_SECT_NG,
> +		.set	= "NG",
> +		.clear	= "  ",
> +	}, {
> +		.mask	= PMD_SECT_CONT,
> +		.val	= PMD_SECT_CONT,
> +		.set	= "CON",
> +		.clear	= "   ",
> +	}, {
> +		.mask	= PMD_SECT_PXN,
> +		.val	= PMD_SECT_PXN,
> +		.set	= "NX",
> +		.clear	= "x ",
> +	}, {
> +		.mask	= PMD_SECT_UXN,
> +		.val	= PMD_SECT_UXN,
> +		.set	= "UXN",
> +		.clear	= "   ",
> +	}, {
> +		.mask	= PMD_TABLE_PXN,
> +		.val	= PMD_TABLE_PXN,
> +		.set	= "NXTbl",
> +		.clear	= "x    ",
> +	}, {
> +		.mask	= PMD_TABLE_UXN,
> +		.val	= PMD_TABLE_UXN,
> +		.set	= "UXNTbl",
> +		.clear	= "x     ",
> +	}, {
> +		.mask	= PTE_GP,
> +		.val	= PTE_GP,
> +		.set	= "GP",
> +		.clear	= "  ",
> +	}, {
> +		.mask	= PMD_ATTRINDX_MASK,
> +		.val	= PMD_ATTRINDX(MT_DEVICE_nGnRnE),
> +		.set	= "DEVICE/nGnRnE",
> +	}, {
> +		.mask	= PMD_ATTRINDX_MASK,
> +		.val	= PMD_ATTRINDX(MT_DEVICE_nGnRE),
> +		.set	= "DEVICE/nGnRE",
> +	}, {
> +		.mask	= PMD_ATTRINDX_MASK,
> +		.val	= PMD_ATTRINDX(MT_NORMAL_NC),
> +		.set	= "MEM/NORMAL-NC",
> +	}, {
> +		.mask	= PMD_ATTRINDX_MASK,
> +		.val	= PMD_ATTRINDX(MT_NORMAL),
> +		.set	= "MEM/NORMAL",
> +	}, {
> +		.mask	= PMD_ATTRINDX_MASK,
> +		.val	= PMD_ATTRINDX(MT_NORMAL_TAGGED),
> +		.set	= "MEM/NORMAL-TAGGED",
> +	}
> +};
> +
> +static const struct prot_bits pud_bits[] = {
> +	{
> +		.mask	= PUD_TYPE_SECT,
> +		.val	= PUD_TYPE_SECT,
> +		.set	= " ",
> +		.clear	= "F",
> +	}, {
> +		.mask	= PUD_TABLE_BIT,
> +		.val	= PUD_TABLE_BIT,
> +		.set	= "TBL",
> +		.clear	= "BLK",
> +	}, {
> +		.mask	= PTE_USER,
> +		.val	= PTE_USER,
> +		.set	= "USR",
> +		.clear	= "   ",
> +	}, {
> +		.mask	= PUD_SECT_RDONLY,
> +		.val	= PUD_SECT_RDONLY,
> +		.set	= "ro",
> +		.clear	= "RW",
> +	}, {
> +		.mask	= PTE_SHARED,
> +		.val	= PTE_SHARED,
> +		.set	= "SHD",
> +		.clear	= "   ",
> +	}, {
> +		.mask	= PTE_AF,
> +		.val	= PTE_AF,
> +		.set	= "AF",
> +		.clear	= "  ",
> +	}, {
> +		.mask	= PTE_NG,
> +		.val	= PTE_NG,
> +		.set	= "NG",
> +		.clear	= "  ",
> +	}, {
> +		.mask	= PTE_CONT,
> +		.val	= PTE_CONT,
> +		.set	= "CON",
> +		.clear	= "   ",
> +	}, {
> +		.mask	= PUD_TABLE_PXN,
> +		.val	= PUD_TABLE_PXN,
> +		.set	= "NXTbl",
> +		.clear	= "x    ",
> +	}, {
> +		.mask	= PUD_TABLE_UXN,
> +		.val	= PUD_TABLE_UXN,
> +		.set	= "UXNTbl",
> +		.clear	= "      ",
> +	}, {
> +		.mask	= PTE_GP,
> +		.val	= PTE_GP,
> +		.set	= "GP",
> +		.clear	= "  ",
> +	}, {
> +		.mask	= PMD_ATTRINDX_MASK,
> +		.val	= PMD_ATTRINDX(MT_DEVICE_nGnRnE),
> +		.set	= "DEVICE/nGnRnE",
> +	}, {
> +		.mask	= PMD_ATTRINDX_MASK,
> +		.val	= PMD_ATTRINDX(MT_DEVICE_nGnRE),
> +		.set	= "DEVICE/nGnRE",
> +	}, {
> +		.mask	= PMD_ATTRINDX_MASK,
> +		.val	= PMD_ATTRINDX(MT_NORMAL_NC),
> +		.set	= "MEM/NORMAL-NC",
> +	}, {
> +		.mask	= PMD_ATTRINDX_MASK,
> +		.val	= PMD_ATTRINDX(MT_NORMAL),
> +		.set	= "MEM/NORMAL",
> +	}, {
> +		.mask	= PMD_ATTRINDX_MASK,
> +		.val	= PMD_ATTRINDX(MT_NORMAL_TAGGED),
> +		.set	= "MEM/NORMAL-TAGGED",
> +	}
> +};
> +
>   struct pg_level {
>   	const struct prot_bits *bits;
>   	char name[4];
>   	int num;
>   	u64 mask;
> +	unsigned long size;
>   };
>   
>   static struct pg_level pg_level[] __ro_after_init = {
>   	{ /* pgd */
>   		.name	= "PGD",
> -		.bits	= pte_bits,
> -		.num	= ARRAY_SIZE(pte_bits),
> +		.bits	= pud_bits,
> +		.num	= ARRAY_SIZE(pud_bits),
> +		.size	= PGD_SIZE
>   	}, { /* p4d */
>   		.name	= "P4D",
> -		.bits	= pte_bits,
> -		.num	= ARRAY_SIZE(pte_bits),
> +		.bits	= pud_bits,
> +		.num	= ARRAY_SIZE(pud_bits),
> +		.size	= P4D_SIZE
>   	}, { /* pud */
>   		.name	= "PUD",
> -		.bits	= pte_bits,
> -		.num	= ARRAY_SIZE(pte_bits),
> +		.bits	= pud_bits,
> +		.num	= ARRAY_SIZE(pud_bits),
> +		.size	= PUD_SIZE
>   	}, { /* pmd */
>   		.name	= "PMD",
> -		.bits	= pte_bits,
> -		.num	= ARRAY_SIZE(pte_bits),
> +		.bits	= pmd_bits,
> +		.num	= ARRAY_SIZE(pmd_bits),
> +		.size	= PMD_SIZE
>   	}, { /* pte */
>   		.name	= "PTE",
>   		.bits	= pte_bits,
>   		.num	= ARRAY_SIZE(pte_bits),
> +		.size	= PAGE_SIZE
>   	},
>   };
>   
> @@ -225,8 +400,9 @@ static void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
>   		      u64 val)
>   {
>   	struct pg_state *st = container_of(pt_st, struct pg_state, ptdump);
> -	static const char units[] = "KMGTPE";
> +	static const char units[] = "BKMGTPE";

This doesnt seem to be related to your changes is it?

>   	u64 prot = 0;
> +	int i = 0;
>   
>   	/* check if the current level has been folded dynamically */
>   	if ((level == 1 && mm_p4d_folded(st->mm)) ||
> @@ -241,20 +417,33 @@ static void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
>   		st->current_prot = prot;
>   		st->start_address = addr;
>   		pt_dump_seq_printf(st->seq, "---[ %s ]---\n", st->marker->name);
> -	} else if (prot != st->current_prot || level != st->level ||
> -		   addr >= st->marker[1].start_address) {
> +	} else if ((prot != st->current_prot || level != st->level ||
> +		   addr >= st->marker[1].start_address)) {
>   		const char *unit = units;
>   		unsigned long delta;
>   
> +		for (i = 0; i < st->level; i++)
> +			pt_dump_seq_printf(st->seq, "  ");
> +
>   		if (st->current_prot) {
>   			note_prot_uxn(st, addr);
>   			note_prot_wx(st, addr);
>   		}
>   
> -		pt_dump_seq_printf(st->seq, "0x%016lx-0x%016lx   ",
> -				   st->start_address, addr);
> +		/*
> +		 * Entries are coalesced into a single line, so non-leaf
> +		 * entries have no size relative to start_address
> +		 */
> +		if (st->start_address != addr) {
> +			pt_dump_seq_printf(st->seq, "0x%016lx-0x%016lx   ",
> +					   st->start_address, addr);
> +			delta = (addr - st->start_address);
> +		} else {
> +			pt_dump_seq_printf(st->seq, "0x%016lx-0x%016lx   ", addr,
> +					   addr + pg_level[st->level].size);
> +			delta = (pg_level[st->level].size);
> +		}
>   
> -		delta = (addr - st->start_address) >> 10;
>   		while (!(delta & 1023) && unit[1]) {
>   			delta >>= 10;
>   			unit++;
> @@ -301,7 +490,8 @@ void ptdump_walk(struct seq_file *s, struct ptdump_info *info)
>   			.range = (struct ptdump_range[]){
>   				{info->base_addr, end},
>   				{0, 0}
> -			}
> +			},
> +			.note_non_leaf = true
>   		}
>   	};
>   
> diff --git a/include/linux/ptdump.h b/include/linux/ptdump.h
> index 8dbd51ea8626..b3e793a5c77f 100644
> --- a/include/linux/ptdump.h
> +++ b/include/linux/ptdump.h
> @@ -16,6 +16,7 @@ struct ptdump_state {
>   			  int level, u64 val);
>   	void (*effective_prot)(struct ptdump_state *st, int level, u64 val);
>   	const struct ptdump_range *range;
> +	bool note_non_leaf;
>   };
>   
>   bool ptdump_walk_pgd_level_core(struct seq_file *m,
> diff --git a/mm/ptdump.c b/mm/ptdump.c
> index 106e1d66e9f9..97da7a765b22 100644
> --- a/mm/ptdump.c
> +++ b/mm/ptdump.c
> @@ -41,6 +41,9 @@ static int ptdump_pgd_entry(pgd_t *pgd, unsigned long addr,
>   	if (st->effective_prot)
>   		st->effective_prot(st, 0, pgd_val(val));
>   
> +	if (st->note_non_leaf && !pgd_leaf(val))
> +		st->note_page(st, addr, 0, pgd_val(val));
> +
>   	if (pgd_leaf(val)) {
>   		st->note_page(st, addr, 0, pgd_val(val));
>   		walk->action = ACTION_CONTINUE;
> @@ -64,6 +67,9 @@ static int ptdump_p4d_entry(p4d_t *p4d, unsigned long addr,
>   	if (st->effective_prot)
>   		st->effective_prot(st, 1, p4d_val(val));
>   
> +	if (st->note_non_leaf && !p4d_leaf(val))
> +		st->note_page(st, addr, 1, p4d_val(val));
> +
>   	if (p4d_leaf(val)) {
>   		st->note_page(st, addr, 1, p4d_val(val));
>   		walk->action = ACTION_CONTINUE;
> @@ -87,6 +93,9 @@ static int ptdump_pud_entry(pud_t *pud, unsigned long addr,
>   	if (st->effective_prot)
>   		st->effective_prot(st, 2, pud_val(val));
>   
> +	if (st->note_non_leaf && !pud_leaf(val))
> +		st->note_page(st, addr, 2, pud_val(val));
> +
>   	if (pud_leaf(val)) {
>   		st->note_page(st, addr, 2, pud_val(val));
>   		walk->action = ACTION_CONTINUE;
> @@ -108,6 +117,10 @@ static int ptdump_pmd_entry(pmd_t *pmd, unsigned long addr,
>   
>   	if (st->effective_prot)
>   		st->effective_prot(st, 3, pmd_val(val));
> +
> +	if (st->note_non_leaf && !pmd_leaf(val))
> +		st->note_page(st, addr, 3, pmd_val(val));
> +
>   	if (pmd_leaf(val)) {
>   		st->note_page(st, addr, 3, pmd_val(val));
>   		walk->action = ACTION_CONTINUE;
> 
> base-commit: a93289b830ce783955b22fbe5d1274a464c05acf

