Return-Path: <linux-kernel+bounces-313004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B5A969EEA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 15:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 137CC1F24FA3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 13:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779CC1A726E;
	Tue,  3 Sep 2024 13:20:50 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B781A7241;
	Tue,  3 Sep 2024 13:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725369650; cv=none; b=kRD9+boA8/SPJKqu4r4Nn7IAU9P8gn3QHzmhBVdZ0Ms5rOC0TT5laPcwaGGyl/pLUBuLMYmVpD1xy8c+9Y+6vuPqJGAUhgpgdX8y1wpaiNsHJprfogQf4t1jvt6zjjcOGIXJVAdTuEuSfuAevzN5gIMZS+aOJTJJyNvAkvyIhHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725369650; c=relaxed/simple;
	bh=cM3rv0XpicNOM9aK0xqxXErRTqQmF+yKq6mSltXsMmk=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Eab1PREIHbKurVlPHZA64HTdAF4i9p3OdF3iGgPa2UOKD3ZXigAl22YNPj4DCA6OFG2yZXaR+GBUf/Yq9kKkL59N3vCVZSkOQw77ZW+zjLMrDZVjq67W3Tdi2tGmxjvwdBPQdVwybdL3NJ5hzPrcmZ8bTvL18acw6/7Oe9X7Iac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.105] (31.173.81.58) by msexch01.omp.ru (10.188.4.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 3 Sep
 2024 16:20:27 +0300
Subject: Re: [PATCH] usb: dwc2: drd: fix clock gating on USB role switch
To: Tomas Marek <tomas.marek@elrest.cz>, <hminas@synopsys.com>,
	<gregkh@linuxfoundation.org>
CC: <Arthur.Petrosyan@synopsys.com>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <oleg.karfich@wago.com>
References: <20240903094156.6516-1-tomas.marek@elrest.cz>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <a2ea1fa0-645d-2a16-f396-797e5b96fd45@omp.ru>
Date: Tue, 3 Sep 2024 16:20:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240903094156.6516-1-tomas.marek@elrest.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 09/03/2024 12:48:06
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 187499 [Sep 03 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 32 0.3.32
 766319f57b3d5e49f2c79a76e7d7087b621090df
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.81.58 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info:
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;omp.ru:7.1.1
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.81.58
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 09/03/2024 12:51:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 9/3/2024 10:53:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 9/3/24 12:41 PM, Tomas Marek wrote:

> The dwc2_handle_usb_suspend_intr() function disables gadget clocks in USB
> peripheral mode when no other power-down mode is available (introduced by
> commit 0112b7ce68ea ("usb: dwc2: Update dwc2_handle_usb_suspend_intr function.")).
> However, the dwc2_drd_role_sw_set() USB role update handler attempts to
> read DWC2 registers if the USB role has changed while the USB is in suspend
> mode (when the clocks are gated). This causes the system to hang.
> 
> Release gadget clocks before handling the USB role update.
> 
> Fixes: 0112b7ce68ea ("usb: dwc2: Update dwc2_handle_usb_suspend_intr function.")
> 
> Signed-off-by: Tomas Marek <tomas.marek@elrest.cz>
> ---
>  drivers/usb/dwc2/drd.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/usb/dwc2/drd.c b/drivers/usb/dwc2/drd.c
> index a8605b02115b..ccb33cd1f04b 100644
> --- a/drivers/usb/dwc2/drd.c
> +++ b/drivers/usb/dwc2/drd.c
> @@ -127,6 +127,18 @@ static int dwc2_drd_role_sw_set(struct usb_role_switch *sw, enum usb_role role)
>  			role = USB_ROLE_DEVICE;
>  	}
>  
> +#if IS_ENABLED(CONFIG_USB_DWC2_PERIPHERAL) || \
> +	IS_ENABLED(CONFIG_USB_DWC2_DUAL_ROLE)
> +	if (dwc2_is_device_mode(hsotg)) {

   Why not avoid #ifdef by doing e.g.:

	if ((IS_ENABLED(CONFIG_USB_DWC2_PERIPHERAL) || \
	     IS_ENABLED(CONFIG_USB_DWC2_DUAL_ROLE) &&
	     dwc2_is_device_mode(hsotg)) {

> +		if (hsotg->lx_state == DWC2_L2) {
> +			if (hsotg->params.power_down ==
> +			    DWC2_POWER_DOWN_PARAM_NONE && hsotg->bus_suspended &&
> +			    !hsotg->params.no_clock_gating)

   Well, these *if*s are mergeable too... :-)

> +				dwc2_gadget_exit_clock_gating(hsotg, 0);
> +		}
> +	}
> +#endif
> +
[...]

MBR, Sergey

