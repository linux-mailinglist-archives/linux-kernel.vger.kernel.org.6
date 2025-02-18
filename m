Return-Path: <linux-kernel+bounces-520476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24947A3AA50
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 22:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52E13189C4B5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 20:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE691C701F;
	Tue, 18 Feb 2025 20:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J9z1cn1m"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935C91B0F17
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 20:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739912059; cv=none; b=cbNxSRXoUpRfL/Zo+Gk++GWXAAEbvCn7mmYu9IxTAUPhb9gbbE1/PGE4IxL6Xqkood3v/6MLbcYVCsEZzzSjwxSMhuYkNsfs4QwRUXvwKipsV6R1dZXL1lgUiqZZDWPdTOKejMlx2O2IcQqtUvPiQClEKKDprkl+A2eoKzSvtYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739912059; c=relaxed/simple;
	bh=u8LzOXgnG/VJDDCdI+lBKEFumZ8TYsXra8WYaJvLsMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m71I/DGxnQcl8ztGNva/8u5B1VFlD2GjH+1+VcBa25/wuaugeg9FrevuDRWgvyBJVtsyUsWTj+UjEViRAEh8DVjnsW12rLTqUWxz80A1hsxmISYzC0aquZSACn2g4PXxDruVxT5iFFWLs9IIwIdnGwKtKRW9CI+LxxD0LEccWOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J9z1cn1m; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739912057; x=1771448057;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=u8LzOXgnG/VJDDCdI+lBKEFumZ8TYsXra8WYaJvLsMs=;
  b=J9z1cn1m46RExQyNPWWdgbe7KA740/6zebHDei1jb4Gn4+H9cOFRAlZj
   QIy0hrw77ibnib3HyuA+mXXYwmATaHAsqHPeRsX6jHOioX8FsuEHSFVAo
   2Mojjg+iM7f/C9x+ozZ43fxc/MYR8cYa349xvLH0Sn5Ynqa7F2a402R+G
   LyeSj4Bu/9Q2E7UAGnlwSjyTMWGeE+XzHto+6DKplOwa/QDR7BY2fpPSb
   wvxIMKiNnzXjHwbE5ez71rrIDEAVCFnErdzEq+cFQS+B4R2pTP/LJvQLv
   EExXrgDEkCjBeLG89mr9aFyZTF0W7YwWxRzps/n2zUIdNhhl0pApm/ysO
   g==;
X-CSE-ConnectionGUID: bGWP73a6R7SxYlCGI3wwuQ==
X-CSE-MsgGUID: RJNfEvoBSbKKtSoBUfywTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="39818632"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="39818632"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 12:54:16 -0800
X-CSE-ConnectionGUID: dQSit8zRSYuvBD07JB9Dfg==
X-CSE-MsgGUID: oREvh3iNRn+GhNj5lLqfrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115401165"
Received: from mgoodin-mobl2.amr.corp.intel.com (HELO [10.125.109.220]) ([10.125.109.220])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 12:54:15 -0800
Message-ID: <fac46937-e0a5-42c1-96ee-65fec4e17551@intel.com>
Date: Tue, 18 Feb 2025 12:54:19 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] x86/microcode/intel_staging: Support mailbox data
 transfer
To: "Chang S. Bae" <chang.seok.bae@intel.com>, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
References: <20241001161042.465584-1-chang.seok.bae@intel.com>
 <20241211014213.3671-1-chang.seok.bae@intel.com>
 <20241211014213.3671-6-chang.seok.bae@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 xsFNBE6HMP0BEADIMA3XYkQfF3dwHlj58Yjsc4E5y5G67cfbt8dvaUq2fx1lR0K9h1bOI6fC
 oAiUXvGAOxPDsB/P6UEOISPpLl5IuYsSwAeZGkdQ5g6m1xq7AlDJQZddhr/1DC/nMVa/2BoY
 2UnKuZuSBu7lgOE193+7Uks3416N2hTkyKUSNkduyoZ9F5twiBhxPJwPtn/wnch6n5RsoXsb
 ygOEDxLEsSk/7eyFycjE+btUtAWZtx+HseyaGfqkZK0Z9bT1lsaHecmB203xShwCPT49Blxz
 VOab8668QpaEOdLGhtvrVYVK7x4skyT3nGWcgDCl5/Vp3TWA4K+IofwvXzX2ON/Mj7aQwf5W
 iC+3nWC7q0uxKwwsddJ0Nu+dpA/UORQWa1NiAftEoSpk5+nUUi0WE+5DRm0H+TXKBWMGNCFn
 c6+EKg5zQaa8KqymHcOrSXNPmzJuXvDQ8uj2J8XuzCZfK4uy1+YdIr0yyEMI7mdh4KX50LO1
 pmowEqDh7dLShTOif/7UtQYrzYq9cPnjU2ZW4qd5Qz2joSGTG9eCXLz5PRe5SqHxv6ljk8mb
 ApNuY7bOXO/A7T2j5RwXIlcmssqIjBcxsRRoIbpCwWWGjkYjzYCjgsNFL6rt4OL11OUF37wL
 QcTl7fbCGv53KfKPdYD5hcbguLKi/aCccJK18ZwNjFhqr4MliQARAQABzUVEYXZpZCBDaHJp
 c3RvcGhlciBIYW5zZW4gKEludGVsIFdvcmsgQWRkcmVzcykgPGRhdmUuaGFuc2VuQGludGVs
 LmNvbT7CwXgEEwECACIFAlQ+9J0CGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEGg1
 lTBwyZKwLZUP/0dnbhDc229u2u6WtK1s1cSd9WsflGXGagkR6liJ4um3XCfYWDHvIdkHYC1t
 MNcVHFBwmQkawxsYvgO8kXT3SaFZe4ISfB4K4CL2qp4JO+nJdlFUbZI7cz/Td9z8nHjMcWYF
 IQuTsWOLs/LBMTs+ANumibtw6UkiGVD3dfHJAOPNApjVr+M0P/lVmTeP8w0uVcd2syiaU5jB
 aht9CYATn+ytFGWZnBEEQFnqcibIaOrmoBLu2b3fKJEd8Jp7NHDSIdrvrMjYynmc6sZKUqH2
 I1qOevaa8jUg7wlLJAWGfIqnu85kkqrVOkbNbk4TPub7VOqA6qG5GCNEIv6ZY7HLYd/vAkVY
 E8Plzq/NwLAuOWxvGrOl7OPuwVeR4hBDfcrNb990MFPpjGgACzAZyjdmYoMu8j3/MAEW4P0z
 F5+EYJAOZ+z212y1pchNNauehORXgjrNKsZwxwKpPY9qb84E3O9KYpwfATsqOoQ6tTgr+1BR
 CCwP712H+E9U5HJ0iibN/CDZFVPL1bRerHziuwuQuvE0qWg0+0SChFe9oq0KAwEkVs6ZDMB2
 P16MieEEQ6StQRlvy2YBv80L1TMl3T90Bo1UUn6ARXEpcbFE0/aORH/jEXcRteb+vuik5UGY
 5TsyLYdPur3TXm7XDBdmmyQVJjnJKYK9AQxj95KlXLVO38lczsFNBFRjzmoBEACyAxbvUEhd
 GDGNg0JhDdezyTdN8C9BFsdxyTLnSH31NRiyp1QtuxvcqGZjb2trDVuCbIzRrgMZLVgo3upr
 MIOx1CXEgmn23Zhh0EpdVHM8IKx9Z7V0r+rrpRWFE8/wQZngKYVi49PGoZj50ZEifEJ5qn/H
 Nsp2+Y+bTUjDdgWMATg9DiFMyv8fvoqgNsNyrrZTnSgoLzdxr89FGHZCoSoAK8gfgFHuO54B
 lI8QOfPDG9WDPJ66HCodjTlBEr/Cwq6GruxS5i2Y33YVqxvFvDa1tUtl+iJ2SWKS9kCai2DR
 3BwVONJEYSDQaven/EHMlY1q8Vln3lGPsS11vSUK3QcNJjmrgYxH5KsVsf6PNRj9mp8Z1kIG
 qjRx08+nnyStWC0gZH6NrYyS9rpqH3j+hA2WcI7De51L4Rv9pFwzp161mvtc6eC/GxaiUGuH
 BNAVP0PY0fqvIC68p3rLIAW3f97uv4ce2RSQ7LbsPsimOeCo/5vgS6YQsj83E+AipPr09Caj
 0hloj+hFoqiticNpmsxdWKoOsV0PftcQvBCCYuhKbZV9s5hjt9qn8CE86A5g5KqDf83Fxqm/
 vXKgHNFHE5zgXGZnrmaf6resQzbvJHO0Fb0CcIohzrpPaL3YepcLDoCCgElGMGQjdCcSQ+Ci
 FCRl0Bvyj1YZUql+ZkptgGjikQARAQABwsFfBBgBAgAJBQJUY85qAhsMAAoJEGg1lTBwyZKw
 l4IQAIKHs/9po4spZDFyfDjunimEhVHqlUt7ggR1Hsl/tkvTSze8pI1P6dGp2XW6AnH1iayn
 yRcoyT0ZJ+Zmm4xAH1zqKjWplzqdb/dO28qk0bPso8+1oPO8oDhLm1+tY+cOvufXkBTm+whm
 +AyNTjaCRt6aSMnA/QHVGSJ8grrTJCoACVNhnXg/R0g90g8iV8Q+IBZyDkG0tBThaDdw1B2l
 asInUTeb9EiVfL/Zjdg5VWiF9LL7iS+9hTeVdR09vThQ/DhVbCNxVk+DtyBHsjOKifrVsYep
 WpRGBIAu3bK8eXtyvrw1igWTNs2wazJ71+0z2jMzbclKAyRHKU9JdN6Hkkgr2nPb561yjcB8
 sIq1pFXKyO+nKy6SZYxOvHxCcjk2fkw6UmPU6/j/nQlj2lfOAgNVKuDLothIxzi8pndB8Jju
 KktE5HJqUUMXePkAYIxEQ0mMc8Po7tuXdejgPMwgP7x65xtfEqI0RuzbUioFltsp1jUaRwQZ
 MTsCeQDdjpgHsj+P2ZDeEKCbma4m6Ez/YWs4+zDm1X8uZDkZcfQlD9NldbKDJEXLIjYWo1PH
 hYepSffIWPyvBMBTW2W5FRjJ4vLRrJSUoEfJuPQ3vW9Y73foyo/qFoURHO48AinGPZ7PC7TF
 vUaNOTjKedrqHkaOcqB185ahG2had0xnFsDPlx5y
In-Reply-To: <20241211014213.3671-6-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/10/24 17:42, Chang S. Bae wrote:
> The staging architecture features a narrowed interface for data transfer.
> Instead of allocating MMIO space based on data chunk size, it utilizes
> two data registers: one for reading and one for writing, enforcing the
> serialization of read and write operations. Additionally, it defines a
> mailbox data format.

So I'm going back and reading this _after_ all of the code. I don't
think I comprehended what "narrowed interface" or "serialization" really
meant when I read this. I was thinking "serializing instructions".

Maybe something like this would help:

Let's say you want to write 2 bytes of data to a device. Typically, the
device would expose 2 bytes of "wide" MMIO space. To send the data to
the device, you could do:

	writeb(buf[0], io_addr + 0);
	writeb(buf[1], io_addr + 1);

But this mailbox is a bit different. Instead of having a "wide"
interface where there is separate MMIO space for each word in a
transaction, it has a "narrow" interface where several words are written
to the same spot in MMIO space:

	writeb(buf[0], io_addr);
	writeb(buf[1], io_addr);

The same goes for the read side.

To me, it's much more akin to talking over a serial port than how I
think of devices attached via MMIO.

> To facilitate data transfer, implement helper functions in line with this
> specified format for reading and writing staging data. This mailbox
> format is a customized version and is not compatible with the existing
> mailbox code, so reuse is not feasible.

This is getting a bit too flowery.

	Implement helper functions that send and receive data to and
	from the device.

	Note: the kernel has support for similar mailboxes. But none of
	them are compatible with this one. Trying to share code resulted
	in a bloated mess, so this code is standalone.

> diff --git a/arch/x86/kernel/cpu/microcode/intel_staging.c b/arch/x86/kernel/cpu/microcode/intel_staging.c
> index 2fc8667cab45..eab6e891db9c 100644
> --- a/arch/x86/kernel/cpu/microcode/intel_staging.c
> +++ b/arch/x86/kernel/cpu/microcode/intel_staging.c
> @@ -3,6 +3,7 @@
>  #define pr_fmt(fmt) "microcode: " fmt
>  #include <linux/delay.h>
>  #include <linux/io.h>
> +#include <linux/pci_ids.h>
>  
>  #include "internal.h"
>  
> @@ -11,17 +12,44 @@
>  
>  #define MBOX_CONTROL_OFFSET	0x0
>  #define MBOX_STATUS_OFFSET	0x4
> +#define MBOX_WRDATA_OFFSET	0x8
> +#define MBOX_RDDATA_OFFSET	0xc
>  
>  #define MASK_MBOX_CTRL_ABORT	BIT(0)
> +#define MASK_MBOX_CTRL_GO	BIT(31)
>  
>  #define MASK_MBOX_STATUS_ERROR	BIT(2)
>  #define MASK_MBOX_STATUS_READY	BIT(31)
>  
> +#define MASK_MBOX_RESP_SUCCESS	BIT(0)
> +#define MASK_MBOX_RESP_PROGRESS	BIT(1)
> +#define MASK_MBOX_RESP_ERROR	BIT(2)
> +
> +#define MBOX_CMD_LOAD		0x3
> +#define MBOX_OBJ_STAGING	0xb
> +#define MBOX_HDR		(PCI_VENDOR_ID_INTEL | (MBOX_OBJ_STAGING << 16))
> +#define MBOX_HDR_SIZE		16
> +
>  #define MBOX_XACTION_LEN	PAGE_SIZE
>  #define MBOX_XACTION_MAX(imgsz)	((imgsz) * 2)
>  #define MBOX_XACTION_TIMEOUT	(10 * MSEC_PER_SEC)
>  
>  #define STAGING_OFFSET_END	0xffffffff
> +#define DWORD_SIZE(s)		((s) / sizeof(u32))
> +
> +static inline u32 read_mbox_dword(void __iomem *base)
> +{
> +	u32 dword = readl(base + MBOX_RDDATA_OFFSET);
> +
> +	/* Inform the read completion to the staging firmware */
> +	writel(0, base + MBOX_RDDATA_OFFSET);
> +	return dword;
> +}

That comment doesn't quite parse for me.  Maybe:

	/* Inform the staging firmware that the read is complete: */

BTW, is this kind of read/write normal for MMIO reads? It looks really
goofy to me, but I don't deal with devices much.

> +static inline void write_mbox_dword(void __iomem *base, u32 dword)
> +{
> +	writel(dword, base + MBOX_WRDATA_OFFSET);
> +}
>  
>  static inline void abort_xaction(void __iomem *base)
>  {
> @@ -30,7 +58,18 @@ static inline void abort_xaction(void __iomem *base)
>  
>  static void request_xaction(void __iomem *base, u32 *chunk, unsigned int chunksize)
>  {
> -	pr_debug_once("Need to implement staging mailbox loading code.\n");
> +	unsigned int i, dwsize = DWORD_SIZE(chunksize);
> +
> +	write_mbox_dword(base, MBOX_HDR);
> +	write_mbox_dword(base, dwsize + DWORD_SIZE(MBOX_HDR_SIZE));
> +
> +	write_mbox_dword(base, MBOX_CMD_LOAD);
> +	write_mbox_dword(base, 0);

This last write is a mystery. Why is it here?

> +
> +	for (i = 0; i < dwsize; i++)
> +		write_mbox_dword(base, chunk[i]);

So, again, I'm a device dummy here. But this _looks_ nonsensical like
the code is just scribbling over itself repeatedly by rewriting data at
'base' over and over.

Would a comment like this help?

/*
 * 'base' is mapped UnCached (UC). Each write shows up at the device
 * as a separate "packet" in program order. That property allows the
 * device to reassemble everything in order on its side.
 */

> +	writel(MASK_MBOX_CTRL_GO, base + MBOX_CONTROL_OFFSET);
>  }

Can we comment the MASK_MBOX_CTRL_GO?  Maybe:

	/*
	 * Tell the device that this chunk is
	 * complete and can be processed.
	 */

>  static enum ucode_state wait_for_xaction(void __iomem *base)
> @@ -55,8 +94,18 @@ static enum ucode_state wait_for_xaction(void __iomem *base)
>  
>  static enum ucode_state read_xaction_response(void __iomem *base, unsigned int *offset)
>  {
> -	pr_debug_once("Need to implement staging response handler.\n");
> -	return UCODE_ERROR;
> +	u32 flag;

	/*
	 * All responses begin with the same header
	 * word and are the same length: 4 dwords.
	 */
	
> +	WARN_ON_ONCE(read_mbox_dword(base) != MBOX_HDR);
> +	WARN_ON_ONCE(read_mbox_dword(base) != DWORD_SIZE(MBOX_HDR_SIZE));
> +
> +	*offset = read_mbox_dword(base);
> +
> +	flag = read_mbox_dword(base);
> +	if (flag & MASK_MBOX_RESP_ERROR)
> +		return UCODE_ERROR;
> +
> +	return UCODE_OK;
>  }
>  
>  static inline unsigned int get_chunksize(unsigned int totalsize, unsigned int offset)


