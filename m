Return-Path: <linux-kernel+bounces-330666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BBE97A277
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 14:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E48E71C22673
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 12:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CF915574D;
	Mon, 16 Sep 2024 12:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DjY6Eii+"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4CE1514FB
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 12:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726490521; cv=none; b=WsB+wwnovj7Qnm2tz9G9YVCU44n6hG5LnTuQre2U8KdlFk+WkJTKb+1xM1QxRAaJV+JXzmGGjaCBOYtgtLwqx8i9W44d1ql6CEKPiE7t9N0oe+9cEwaLeJ758kDGPO8KBnNhsww+SpP7yX+JduWHT8d5II6Kh/qozeMGZX8DEzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726490521; c=relaxed/simple;
	bh=LVQhGf/phDF9ol7oIFjlYIZ6YfQASkzCPjJQXD/bWow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=MHn3+uPWyMr3mGvUsN5EzOxCN9ipmxAQkb7EJy5rjWGeFl6JVeLm+am3qHpa+9E0wZ//WPCG/wuyBBDEPrchymp1VeAlkyQthacDQKtLIFLT+MRXn9gREMi7reaqfQWUBrseM+CVqsSQqhk2wcQncOu2LiyjsqY2haaTifgzUxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=DjY6Eii+; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240916124150epoutp0405b9851d3f5a9638324f9d2b9ac9bfed~1ufi-Xvgg0971709717epoutp04B
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 12:41:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240916124150epoutp0405b9851d3f5a9638324f9d2b9ac9bfed~1ufi-Xvgg0971709717epoutp04B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1726490510;
	bh=jbpUw94AxqwSx4gxFSFoZGLytJ7WYFOTOim6PSfGg4I=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=DjY6Eii+AAYjc9ilnLm9YxYDA+Q4uYqCO7MLLIApQnHlrHvIqbFUHlVdN/u0i57TJ
	 HKS5T51wpUd7uwir9LtrgIQ8uaIegDoxwZQIdHyh2gpjlYZh3JjspQPOvdP2I46l+A
	 PlQYBNtxOiX5anB9m85JwHRp3S48gY7kH1EfQ8Iw=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240916124149epcas5p425cc2e973ae48acbc7c1207b95b22d76~1ufissW_i0791007910epcas5p4r;
	Mon, 16 Sep 2024 12:41:49 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4X6l0X4dyNz4x9Pr; Mon, 16 Sep
	2024 12:41:48 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	43.DB.08855.C8728E66; Mon, 16 Sep 2024 21:41:48 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240916124148epcas5p1dae1c77d28e79aac184968591c1f8375~1ufhENgl01284312843epcas5p10;
	Mon, 16 Sep 2024 12:41:48 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240916124148epsmtrp28d39448da670e604fab3834dca67535d~1ufhDf2ik0425104251epsmtrp2n;
	Mon, 16 Sep 2024 12:41:48 +0000 (GMT)
X-AuditID: b6c32a44-15fb870000002297-33-66e8278cbf7b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	C9.72.19367.B8728E66; Mon, 16 Sep 2024 21:41:47 +0900 (KST)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240916124146epsmtip2df36b8dfbcb32c9b09e17e482b0e9c03~1uffJ2ERW1921019210epsmtip2J;
	Mon, 16 Sep 2024 12:41:45 +0000 (GMT)
Message-ID: <2cf9624b-8612-46aa-a528-a8948ef4f5e1@samsung.com>
Date: Mon, 16 Sep 2024 18:11:44 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3: Potential fix of possible dwc3 interrupt
 storm
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jh0801.jung@samsung.com" <jh0801.jung@samsung.com>, "dh10.jung@samsung.com"
	<dh10.jung@samsung.com>, "naushad@samsung.com" <naushad@samsung.com>,
	"akash.m5@samsung.com" <akash.m5@samsung.com>, "rc93.raju@samsung.com"
	<rc93.raju@samsung.com>, "taehyun.cho@samsung.com"
	<taehyun.cho@samsung.com>, "hongpooh.kim@samsung.com"
	<hongpooh.kim@samsung.com>, "eomji.oh@samsung.com" <eomji.oh@samsung.com>,
	"shijie.cai@samsung.com" <shijie.cai@samsung.com>
Content-Language: en-US
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
In-Reply-To: <20240913175106.qbav2aigzwaj7pvd@synopsys.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIJsWRmVeSWpSXmKPExsWy7bCmpm6P+os0g/d7lC3eXF3FanFnwTQm
	i1PLFzJZNC9ez2Yxac9WFou7D3+wWFzeNYfNYtGyVmaLT0f/s1qs6pwDFPu+k9li0kFRi1UL
	DrA78Hrsn7uG3aNvyypGjy37PzN6fN4kF8ASlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pm
	YKhraGlhrqSQl5ibaqvk4hOg65aZA3SekkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUg
	JafApECvODG3uDQvXS8vtcTK0MDAyBSoMCE7493xtUwFm+0q/r3namDcb9rFyMEhIWAi0f3Y
	uouRk0NIYDejxPxVXl2MXED2J0aJtqc/meGcW7s3s4BUgTQ8+b+JESKxk1Hi5eM2KOcto8T1
	C0/AqngF7CSeTFnPBLKCRUBV4k+nGkRYUOLkTIgSUQF5ifu3ZrCD2MICARJXlsxgBLFFBHQk
	Dpw4zwQyk1mgg1ViQXcbE0iCWUBc4taT+WAz2QQMJZ6dsAEJcwpYS8y6MB+qRF6ieetssKsl
	BJZySGz/3QR1tYvE5dMH2SFsYYlXx7dA2VISn9/tZYOwqyVW3/nIBtHcwihx+Mk3qCJ7icdH
	HzGDLGYW0JRYv0sfYhmfRO/vJ0yQYOSV6GgTgqhWlTjVeBlqpLTEvSXXWCFsD4knV+dDw+o2
	i8SENS/YJzAqzEIKl1lI3pyF5J9ZCJsXMLKsYpRMLSjOTU9NNi0wzEsth0d3cn7uJkZw2tVy
	2cF4Y/4/vUOMTByMhxglOJiVRHhtfz9NE+JNSaysSi3Kjy8qzUktPsRoCoyficxSosn5wMSf
	VxJvaGJpYGJmZmZiaWxmqCTO+7p1boqQQHpiSWp2ampBahFMHxMHp1QD082zB5Z+3xzQnX51
	+qeJvZzmM1Z7vlP02BpSbKznKXhPwH+ueop/3MWNb+6sunfQJlThe/XFoBepnG73mZlklu5e
	mtvlsuI7w/pGI+0l39eXnDMuP57JsOHuvu2sK9z2VapPTtKyqZ33s/bvxKq9qbMNPK9n+yde
	nVCpYTfRdlXi9EuKN0yMjBxXpif9+rpJdt36i00GUpMPHjizO1PULXPijaCpvdLda9zWbzte
	/anF/Zzgb9lsod+y8953/jK9UV4vcLCY3zX4ufhJ03smTenxgf5vtU+Xb9V6tcPgveSiFxnv
	au/d/PHFnH135QzpMo264uqU+OmeX47V72f3Y30350vt5Nm5Cy/IPf7cvViJpTgj0VCLuag4
	EQDvtxdjRAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42LZdlhJXrdb/UWaQesaa4s3V1exWtxZMI3J
	4tTyhUwWzYvXs1lM2rOVxeLuwx8sFpd3zWGzWLSsldni09H/rBarOucAxb7vZLaYdFDUYtWC
	A+wOvB77565h9+jbsorRY8v+z4wenzfJBbBEcdmkpOZklqUW6dslcGW8O76WqWCzXcW/91wN
	jPtNuxg5OSQETCSe/N/E2MXIxSEksJ1RYsmHPYwQCWmJ17O6oGxhiZX/nrNDFL1mlFi+8Q8b
	SIJXwE7iyZT1TF2MHBwsAqoSfzrVIMKCEidnPmEBsUUF5CXu35rBDmILC/hJTH9zAmymiICO
	xIET55lAZjIL9LBKfPn6kQViwW0WiV07n4NVMQuIS9x6Mh9sAZuAocSzEzYgYU4Ba4lZF0DC
	ICVmEl1bu6DK5SWat85mnsAoNAvJHbOQTJqFpGUWkpYFjCyrGEVTC4pz03OTCwz1ihNzi0vz
	0vWS83M3MYKjSytoB+Oy9X/1DjEycTAeYpTgYFYS4bX9/TRNiDclsbIqtSg/vqg0J7X4EKM0
	B4uSOK9yTmeKkEB6YklqdmpqQWoRTJaJg1OqgYlZfcXubwaCVgdm35srmGlcu21+xqK8KVZz
	VyVf3Bp4aqsRj46G62X/KpuOs2enPM9vi/AvTLgt/Id/cZzck9qL7JJFx8W+vXSeuXDG21m/
	9h3Wi1haKjSl3f2n75SIza8crVfFv+YyMNDrXSZ+S3B1t5pbYdRztoMNPsauN7c+nfd1QZzV
	2a2LdETEDGfr6eVO5I2evK0h7reuZoTA/3nyX/Ncec+HlTRc3rhWL+H+d4cJzd1puVLTVPkk
	Zquqtu3aceXr0+wdrX3zvoSFKxpbHIkuavn21LR5at/L0qgHHDMasn3jX76v8Vpi+yChW/N0
	zIGzU1qmqeln3JFaKjDZ0E5VVbmsr1z5qyjfeyWW4oxEQy3mouJEALUcP98dAwAA
X-CMS-MailID: 20240916124148epcas5p1dae1c77d28e79aac184968591c1f8375
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240911002436epcas5p19be55e1144edd6f77184192c7f22a85e
References: <f9561f03-5f83-4270-b7f3-17b880cfabfe@samsung.com>
	<20240905231825.6r2sp2bapxidur7a@synopsys.com>
	<64d049cc-d55d-4376-b6b9-402eb6f170c0@samsung.com>
	<20240906005935.caugoe3mqqdqwqao@synopsys.com>
	<30ca8527-419b-4e44-a21b-18e494b39076@samsung.com>
	<20240907003946.qn6t3xw65qwl2cn7@synopsys.com>
	<dff83c7d-56b8-481f-af69-8d4262bd54e4@samsung.com>
	<CGME20240911002436epcas5p19be55e1144edd6f77184192c7f22a85e@epcas5p1.samsung.com>
	<20240911002408.gr4fv5vkst7ukxd5@synopsys.com>
	<dd7965fa-9266-46b9-9219-1ef726480a9b@samsung.com>
	<20240913175106.qbav2aigzwaj7pvd@synopsys.com>


On 9/13/2024 11:21 PM, Thinh Nguyen wrote:
> Hi,
>
> On Fri, Sep 13, 2024, Selvarasu Ganesan wrote:
>> Hi Thinh,
>>
>> So far, there have been no reported error instances. But, we suspecting
>> that the issue may be related to our glue driver. In our glue driver, we
>> access the reference of evt->flags when starting or stopping the gadget
>> based on a VBUS notification. We apologize for sharing this information
>> so late, as we only became aware of it recently.
>>
>> The following sequence outlines the possible scenarios of race conditions:
>>
>> Thread#1 (Our glue Driver Sequence)
>> ===================================
>> ->USB VBUS notification
>> ->Start/Stop gadget
>> ->dwc->ev_buf->flags |= BIT(20); (It's for our reference)
>> ->Call dwc3 exynos runtime suspend/resume
>> ->dwc->ev_buf->flags &= ~BIT(20);
>> ->Call dwc3 core runtime suspend/resume
>>
>> Thread#2
>> ========
>> ->dwc3_interrupt()
>> ->evt->flags |= DWC3_EVENT_PENDING;
>> ->dwc3_thread_interrupt()
>> ->evt->flags &= ~DWC3_EVENT_PENDING;
>>
> This is great! That's likely the problem. Glad you found it.
>
>>
>> After our internal discussions, we have decided to remove the
>> unnecessary access to evt->flag in our glue driver. We have made these
>> changes and initiated testing.
>>
>> Thank you for your help so far to understand more into our glue driver code.
>>
>> And We are thinking that it would be fine to reset evt->flag when the
>> USB controller is started, along with the changes you suggested earlier.
>> This additional measure will help prevent similar issues from occurring
>> in the future.
>>
>> Please let us know your thoughts on this proposal. If it is not
>> necessary, we understand and will proceed accordingly.
>>
> You can submit the change I suggested. That's a valid change. However,
> we should not include the reset of the DWC3_EVENT_PENDING flag. Had we
> done this, you may not found the issue above. It serves no purpose for
> the core driver logic and will be an extra burden for us to maintain. (I
> don't want to scratch my head in the future to figure out why that
> change was needed or concern whether it can be removed without causing
> regression).

Yeah I understand.

Please reconfirm the below changes once with commit message. I will post 
new version if this changes are fine.


[PATCH] usb: dwc3: core: Stop processing of pending events if controller 
is halted

This commit addresses an issue where events were being processed when
the controller was in a halted state. To fix this issue by stop
processing the events as the event count was considered stale or
invalid when the controller was halted.

Fixes: fc8bb91bc83e ("usb: dwc3: implement runtime PM")
Cc: stable <stable@kernel.org>
Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
Suggested-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
  drivers/usb/dwc3/core.c   | 17 +++++++++++++++--
  drivers/usb/dwc3/core.h   |  4 ----
  drivers/usb/dwc3/gadget.c | 22 +++++++++++-----------
  3 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 9eb085f359ce..f47b20bc2d1f 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -544,6 +544,7 @@ static int dwc3_alloc_event_buffers(struct dwc3 
*dwc, unsigned int length)
  int dwc3_event_buffers_setup(struct dwc3 *dwc)
  {
         struct dwc3_event_buffer        *evt;
+       u32                             reg;

         if (!dwc->ev_buf)
                 return 0;
@@ -556,8 +557,10 @@ int dwc3_event_buffers_setup(struct dwc3 *dwc)
                         upper_32_bits(evt->dma));
         dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0),
                         DWC3_GEVNTSIZ_SIZE(evt->length));
-       dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), 0);

+       /* Clear any stale event */
+       reg = dwc3_readl(dwc->regs, DWC3_GEVNTCOUNT(0));
+       dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), reg);
         return 0;
  }

@@ -2499,7 +2502,11 @@ static int dwc3_runtime_resume(struct device *dev)

         switch (dwc->current_dr_role) {
         case DWC3_GCTL_PRTCAP_DEVICE:
-               dwc3_gadget_process_pending_events(dwc);
+               if (dwc->pending_events) {
+                       pm_runtime_put(dwc->dev);
+                       dwc->pending_events = false;
+                       enable_irq(dwc->irq_gadget);
+               }
                 break;
         case DWC3_GCTL_PRTCAP_HOST:
         default:
@@ -2589,6 +2596,12 @@ static void dwc3_complete(struct device *dev)
  static const struct dev_pm_ops dwc3_dev_pm_ops = {
         SET_SYSTEM_SLEEP_PM_OPS(dwc3_suspend, dwc3_resume)
         .complete = dwc3_complete,
+
+       /*
+        * Runtime suspend halts the controller on disconnection. It 
replies on
+        * platforms with custom connection notification to start the 
controller
+        * again.
+        */
         SET_RUNTIME_PM_OPS(dwc3_runtime_suspend, dwc3_runtime_resume,
                         dwc3_runtime_idle)
  };
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index c71240e8f7c7..9c508e0c5cdf 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1675,7 +1675,6 @@ static inline void dwc3_otg_host_init(struct dwc3 
*dwc)
  #if !IS_ENABLED(CONFIG_USB_DWC3_HOST)
  int dwc3_gadget_suspend(struct dwc3 *dwc);
  int dwc3_gadget_resume(struct dwc3 *dwc);
-void dwc3_gadget_process_pending_events(struct dwc3 *dwc);
  #else
  static inline int dwc3_gadget_suspend(struct dwc3 *dwc)
  {
@@ -1687,9 +1686,6 @@ static inline int dwc3_gadget_resume(struct dwc3 *dwc)
         return 0;
  }

-static inline void dwc3_gadget_process_pending_events(struct dwc3 *dwc)
-{
-}
  #endif /* !IS_ENABLED(CONFIG_USB_DWC3_HOST) */

  #if IS_ENABLED(CONFIG_USB_DWC3_ULPI)
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 291bc549935b..a32c3a292353 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -4483,6 +4483,17 @@ static irqreturn_t dwc3_check_event_buf(struct 
dwc3_event_buffer *evt)
                 return IRQ_HANDLED;

         count = dwc3_readl(dwc->regs, DWC3_GEVNTCOUNT(0));
+
+       /*
+        * If the controller is halted, the event count is 
stale/invalid. Ignore
+        * them. This happens if the interrupt assertion is from an 
out-of-band
+        * resume notification.
+        */
+       if (!dwc->pullups_connected && count) {
+               dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), count);
+               return IRQ_HANDLED;
+       }
+
         count &= DWC3_GEVNTCOUNT_MASK;
         if (!count)
                 return IRQ_NONE;
@@ -4728,14 +4739,3 @@ int dwc3_gadget_resume(struct dwc3 *dwc)

         return dwc3_gadget_soft_connect(dwc);
  }
-
-void dwc3_gadget_process_pending_events(struct dwc3 *dwc)
-{
-       if (dwc->pending_events) {
-               dwc3_interrupt(dwc->irq_gadget, dwc->ev_buf);
-               dwc3_thread_interrupt(dwc->irq_gadget, dwc->ev_buf);
-               pm_runtime_put(dwc->dev);
-               dwc->pending_events = false;
-               enable_irq(dwc->irq_gadget);
-       }
-}
--
2.17.1

Thanks,
Selva
> Thanks,
> Thinh

