Return-Path: <linux-kernel+bounces-297519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0E595BA0D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 17:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6561284838
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 15:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373BB1CBEBA;
	Thu, 22 Aug 2024 15:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gtI1o/sG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153E418EAB;
	Thu, 22 Aug 2024 15:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724340393; cv=none; b=kukZJScfFjZJ1v7lNs46wNxTsGs3ZiCxVM/dpdocgiIVnKOkACaOa07ILGuSk4b0pR9/2wCGtnhILyuoPp55mt/O58QCpb7E00Uo06bjhBB3qFDI3ti1/khrmnhP8h4nttja9Q1U+4QddhpclyPLOva0avk+y4Cfh+YA1NmRMzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724340393; c=relaxed/simple;
	bh=6YjPGB/euod+io2A3d4H4RTlTfhzeuaae2zluY6iaf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uFCNe2SIA0SYBG9ZkGv8GrjypIZ6UTul6WCo+PuhYwVs9a1FmzRP5om9HJD5WNRjX9jufavqWLfXTb3dJtkRoTckbnDG5n+ksL+bp+jikIRChmYvUhNQZfAlNxxvMVK+GSIoOC61+aQX2iAR6V48LGZKLhfGs+Vkxfv7qAranTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gtI1o/sG; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724340393; x=1755876393;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6YjPGB/euod+io2A3d4H4RTlTfhzeuaae2zluY6iaf8=;
  b=gtI1o/sGknWTkgzgp4a7fqQifYzUEjcBGdgVTqFV+dvaa+m4YFUyiUbu
   sWEk2VLOEeczMbI8tNS8BHLvTKOzHSbrTEGsatAVb8xmgiBMHDfaFKosk
   lXCmlvEdEh5hRU+ohePcIUUUAeWfZVUBUZq//TBhlUoFTuxlBsLsRDL7w
   0VDXhZT8fjRM+mwSQQzWfND5gsFgxBvhToDFrYAyZ0Qi99syKcFcyxEX4
   K7KrIwsd00ZXqaLeb4wG4a4L33ISHgN4zhUX87IgjEvj6qyDt5vQu9/8x
   mdZ04/qWk1I7lhwIYyjezLA+Pj6t80mIRnzfAlmbFyS0MV0qgAoFdAa8r
   A==;
X-CSE-ConnectionGUID: /lj4CKjXRtS6cTogn5EOyg==
X-CSE-MsgGUID: UBor0OTkQCqKECIK15x/tw==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="33332873"
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="33332873"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 08:26:32 -0700
X-CSE-ConnectionGUID: TzgC5e1IS1KLlqME+k1zHw==
X-CSE-MsgGUID: Usd3LV/9TnKpmTgPKrYQMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="62187114"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orviesa008.jf.intel.com with ESMTP; 22 Aug 2024 08:26:29 -0700
Message-ID: <060bf2de-d231-4ed6-b7cc-cda40bfd397a@linux.intel.com>
Date: Thu, 22 Aug 2024 18:28:33 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] xhci: pci: Put XHCI controllers into D3hot at
 shutdown
To: superm1@kernel.org, Mathias Nyman <mathias.nyman@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 mika.westerberg@linux.intel.com,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20240712185418.937087-1-superm1@kernel.org>
 <20240712185418.937087-3-superm1@kernel.org>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20240712185418.937087-3-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.7.2024 21.54, superm1@kernel.org wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> A workaround was put in place for Haswell systems with spurious events
> to put XHCI controllers into D3hot at shutdown.  This solution actually
> makes sense for all XHCI controllers though because XHCI controllers
> left in D0 by the OS may remain in D0 when the SoC goes into S5.
> 
> Explicitly put all XHCI controllers into D3hot at shutdown and when
> module is unloaded.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/usb/host/xhci-pci.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index 4408d4caf66d2..dde5e4a210719 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -667,9 +667,7 @@ static void xhci_pci_remove(struct pci_dev *dev)
>   		xhci->shared_hcd = NULL;
>   	}
>   
> -	/* Workaround for spurious wakeups at shutdown with HSW */
> -	if (xhci->quirks & XHCI_SPURIOUS_WAKEUP)
> -		pci_set_power_state(dev, PCI_D3hot);
> +	pci_set_power_state(dev, PCI_D3hot);
>   
>   	usb_hcd_pci_remove(dev);

Just noticed these have been the wrong way around for a while (impacting HSW).

We should first call usb_hcd_pci_remove() and then pci_set_power_state(D3),
otherwise we force a fully running xHC into D3.

Note, with this change we end up first calling
pci_disable_device(), then pci_set_power_state(D3)

>   }
> @@ -882,9 +880,7 @@ static void xhci_pci_shutdown(struct usb_hcd *hcd)
>   	xhci_shutdown(hcd);
>   	xhci_cleanup_msix(xhci);
>   
> -	/* Yet another workaround for spurious wakeups at shutdown with HSW */
> -	if (xhci->quirks & XHCI_SPURIOUS_WAKEUP)
> -		pci_set_power_state(pdev, PCI_D3hot);
> +	pci_set_power_state(pdev, PCI_D3hot);

Looks good

Note that we now end up first calling pci_set_power_state(D3) and then
pci_disable_device(). The other way around than the remove case above.
I don't know if it matters.

Thanks
Mathias


