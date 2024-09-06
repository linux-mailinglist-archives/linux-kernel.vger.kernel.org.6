Return-Path: <linux-kernel+bounces-319341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A2296FB58
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 20:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D295528EDBB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 18:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693381C7B68;
	Fri,  6 Sep 2024 18:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hzxzsxea"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307DA1B85CA;
	Fri,  6 Sep 2024 18:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725647981; cv=none; b=bPxFe6zL+o9t4+YcCF69Y1f11YUEKJqpX2TgLX41ZUK1c/ZMq7FDvlj2/NMlIYoOctRyL35aTAw3M6r8ZYWV0wLMPrXc31FdPZR7oTZ3tLImjxTeNLGcuTNcVuRg65wbGQi9K1xI+F/v/6SN7kpmOvkEd223MuGG4uSkzDJ8ZfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725647981; c=relaxed/simple;
	bh=yiCPeFkySVHpWWcDLB6biske28eaxBYiii9UlIjTp0g=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QCOK0yWneuEKDZRSYYVgvdn2nrGVOgTtiTFZNnpFBq6O0aAUp/IYZEx/iVQEKK83+VWwh0tGUnD2cNfKFq+I9wycvpXCUmqCLIozBEplsAuCMZ0SBrmcEumIR/b+irfMdm3n+S6wHs/6s10wZbgMIj3ZFJUlReLt5thGkQg6QmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hzxzsxea; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725647980; x=1757183980;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=yiCPeFkySVHpWWcDLB6biske28eaxBYiii9UlIjTp0g=;
  b=HzxzsxeaYIryBhoSMVppwqNfPJwTO+JfgNfoEM1h6uJbVQR8yMsh2TkN
   QkXzBq5u74cCMnHYXfCA20MOI+7Q3C62QAB4qP7KLA6DHdF7RQrYECCCi
   S+WmK06sy7WpIapDQ0Uve3t54GeVzd0nfHDD24QkbO4yhJdr3z+dC2//t
   ocJaFDlpfkb3+fORrkhGF6KKBQWBw2nJf1CH0J3/wVNQAGrpgCCcq8kcN
   NoWQ+YgXcFIETkuisSxd9dMWhJXsHA7r62kTzkdl27Eld+zbH6Sr9Gt05
   2uNZjlrKgztw6zyTanKTSVSaGZQeyE+6MKqNzmwrr5fuOoHXbUXHWcUXO
   A==;
X-CSE-ConnectionGUID: 06r+7VyJQmekSa8Z+cGh7g==
X-CSE-MsgGUID: ZNprfaWvR4K3dCPciw1zxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11187"; a="24612572"
X-IronPort-AV: E=Sophos;i="6.10,208,1719903600"; 
   d="scan'208";a="24612572"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 11:39:39 -0700
X-CSE-ConnectionGUID: LWFAnCw8TdKnDdo5H1xbHQ==
X-CSE-MsgGUID: AjteviztS726TAqqpRhrMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,208,1719903600"; 
   d="scan'208";a="65722666"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.157])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 11:39:36 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 6 Sep 2024 21:39:33 +0300 (EEST)
To: Hans de Goede <hdegoede@redhat.com>
cc: Kai-Heng Feng <kai.heng.feng@canonical.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, jorge.lopez2@hp.com, 
    acelan.kao@canonical.com, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org
Subject: Re: [PATCH v3] platform/x86/hp: Avoid spurious wakeup on HP ProOne
 440
In-Reply-To: <3e12ef27-30e4-4b5a-acd6-5d3023a82941@redhat.com>
Message-ID: <322162d3-ce9d-27fd-6ac3-204d46e7256e@linux.intel.com>
References: <20240906053047.459036-1-kai.heng.feng@canonical.com> <3e12ef27-30e4-4b5a-acd6-5d3023a82941@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 6 Sep 2024, Hans de Goede wrote:
> On 9/6/24 7:30 AM, Kai-Heng Feng wrote:
> > The HP ProOne 440 has a power saving design that when the display is
> > off, it also cuts the USB touchscreen device's power off.
> > 
> > This can cause system early wakeup because cutting the power off the
> > touchscreen device creates a disconnect event and prevent the system
> > from suspending:
> > [  445.814574] hub 2-0:1.0: hub_suspend
> > [  445.814652] usb usb2: bus suspend, wakeup 0
> > [  445.824629] xhci_hcd 0000:00:14.0: Port change event, 1-11, id 11, portsc: 0x202a0
> > [  445.824639] xhci_hcd 0000:00:14.0: resume root hub
> > [  445.824651] xhci_hcd 0000:00:14.0: handle_port_status: starting usb1 port polling.
> > [  445.844039] xhci_hcd 0000:00:14.0: PM: pci_pm_suspend(): hcd_pci_suspend+0x0/0x20 returns -16
> > [  445.844058] xhci_hcd 0000:00:14.0: PM: dpm_run_callback(): pci_pm_suspend+0x0/0x1c0 returns -16
> > [  445.844072] xhci_hcd 0000:00:14.0: PM: failed to suspend async: error -16
> > [  446.276101] PM: Some devices failed to suspend, or early wake event detected
> > 
> > So add a quirk to make sure the following is happening:
> > 1. Let the i915 driver suspend first, to ensure the display is off so
> >    system also cuts the USB touchscreen's power.
> > 2. Wait a while to let the USB disconnect event fire and get handled.
> > 3. Since the disconnect event already happened, the xhci's suspend
> >    routine won't be interrupted anymore.
> > 
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> 
> Thanks, patch looks good to me:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> Ilpo, do you plan to do another fixes pull-request for 6.11,
> or shall I add this to for-next to target 6.12-rc1 ?
> 
> Either way works for me. If you plan to do another fixes
> pull-request, note that I plan to post a v2 of the panasonic
> patches this Monday.

Hi Hans,

I was thinking that perhaps one more is necessary the next week.

-- 
 i.


