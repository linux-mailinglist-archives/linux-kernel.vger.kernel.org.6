Return-Path: <linux-kernel+bounces-530873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0A2A43990
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DADDC3AB80D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21185262D11;
	Tue, 25 Feb 2025 09:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UvuoQ0WY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E0E2627E6;
	Tue, 25 Feb 2025 09:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740475978; cv=none; b=eb7RX7OjuzfAmBp1EVH6Ui4fT7xKunkudrlc7os9D82bcivaKuuE8v6vHYDRuaJFooIU6GWpSeB+3N8o7Q4ajqOTGTwFR/tMGgCZ7Ta1pG5UQ+hydK09ME5jViDcCC1G7hXtCPtLN06hqYvMazmIRWjfSvQAgLdphiXunNIn/nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740475978; c=relaxed/simple;
	bh=VO+G51UF3rWRuWcNfxbs+DYejBc+3+YybdTX2xscr6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BR/+yPotzx9VK5yk70G/f0Y91XXortIGYZKrEA+XHB6OP33Ikgqxuq39HM4Ahcj5BSaxChreeW6AfViO6UVt+y3Q/yLWWk2BkoIvhrjZllAnatFzuLjawK+S4di6kacS8ASuCekgh+5O/7aClsN3AKbVD83BrWA4Wj32tbLAVR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UvuoQ0WY; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740475978; x=1772011978;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VO+G51UF3rWRuWcNfxbs+DYejBc+3+YybdTX2xscr6w=;
  b=UvuoQ0WY8M4fGLC642CTCiXlbmmbe105mLrre1/eaNnubHz2rJ2y5Yl6
   QHw3D8x0ZzZKdCAtLfIELFrFCn3L2NSLIGnuTNXOOnlXjE0zGXLlNEqC0
   JgPqofpDmbrVUTtDI+fz8Lrvtd181Cb9HbWnOTyCpJr5+UfjMsNrRmiHl
   OqXfPDoENDNmOeIXsslh2CZi0azBv4/bEuQ2yXvSRiSn4iulHQDBDTd5A
   SD+GdkmnEd5nlOjRcB/PfElIaayFLRfpELGs6yRhJF0PefxnCdfridljz
   Di80E3wWmffF1VK1WqmLatOXMX/5b4jNLOtzM5iXlLJEmZYiW4zR+c9Sn
   g==;
X-CSE-ConnectionGUID: GwkcIcHKQpKkEn9bibolFA==
X-CSE-MsgGUID: f00gF9OfS+2N1rRlSq09xg==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="58693237"
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="58693237"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 01:32:57 -0800
X-CSE-ConnectionGUID: KnO1Mn95TQ+LDjIm/0Qzxg==
X-CSE-MsgGUID: kpGWlHU+T1qtwXP4ZTc38g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="121581434"
Received: from unknown (HELO [10.237.72.199]) ([10.237.72.199])
  by orviesa005.jf.intel.com with ESMTP; 25 Feb 2025 01:32:54 -0800
Message-ID: <7a59ca83-133a-4cd1-b7b4-1e70aa7fb746@linux.intel.com>
Date: Tue, 25 Feb 2025 11:33:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] usb: xhci: Unify duplicate inc_enq() code
To: =?UTF-8?Q?Micha=C5=82_Pecio?= <michal.pecio@gmail.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250220234355.2386cb6d@foxbook>
 <20250220234719.5dc47877@foxbook>
 <d59a6694-e0e7-46b7-874e-0c6acd8c9126@linux.intel.com>
 <20250224004542.5861d4dc@foxbook>
 <91e9b2f6-d9f6-460e-965a-bf2d5b13878c@linux.intel.com>
 <20250224220148.4b91de02@foxbook>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20250224220148.4b91de02@foxbook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24.2.2025 23.01, Michał Pecio wrote:
> On Mon, 24 Feb 2025 13:49:29 +0200, Mathias Nyman wrote:
>> Interesting, I wonder if setting the link TRB chain bit would
>> also help with the TRB prefetch issue on VIA VL805 hosts.
> 
> Good idea, but unfortunately not.
> 
> With xhci_hcd quirks=1, which is XHCI_LINK_TRB_QUIRK:
> 
> [    0.543465] pci 0000:0a:00.0: [1106:3483] type 00 class 0x0c0330 PCIe Endpoint
> 
> [  406.745905] xhci_hcd 0000:0a:00.0: xHCI Host Controller
> [  406.745916] xhci_hcd 0000:0a:00.0: new USB bus registered, assigned bus number 11
> [  406.747265] xhci_hcd 0000:0a:00.0: hcc params 0x002841eb hci version 0x100 quirks 0x0000000000000891
> 
> [  407.475672] usb 11-1.4: Found UVC 1.00 device USB2.0 Camera (1e4e:0103)
> 
> [  407.697768] usb 11-1.4: Selecting alternate setting 12 (3060 B/frame bandwidth)
> [  407.700432] usb 11-1.4: Allocated 5 URB buffers of 32x3060 bytes each
> [  407.732047] xhci_hcd 0000:0a:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0005 address=0xffccc000 flags=0x0000]
> [  407.732122] xhci_hcd 0000:0a:00.0: WARNING: Host System Error
> [  407.732133] xhci_hcd 0000:0a:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0005 address=0xffccc000 flags=0x0000]
> [  407.732151] xhci_hcd 0000:0a:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0005 address=0xffccc000 flags=0x0000]
> 
> Link TRBs from debugfs:
> 
>   0 0x00000000ffccbff0: LINK 00000000ffcca000 intr 0 type 'Link' flags i:C:t:C
>   1 0x00000000ffccaff0: LINK 00000000ffccb000 intr 0 type 'Link' flags i:C:T:c

It was worth a shot,
thanks for trying it out

I'll send the original fix to Greg

-Mathias

