Return-Path: <linux-kernel+bounces-317154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C5596DA0B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 15:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF57F286C5D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 13:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833C719D077;
	Thu,  5 Sep 2024 13:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kQm//ty2"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB60199223
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 13:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725542358; cv=none; b=gBjE/AAnd8jLKksayzGQRLhKh3QYDfE46kFAuSqNx7Y7H1KZYODo2nfxfO8Jg/AGWgs8zrVzilM/5T2TCwIp8cAsarnfzBVT+5XBy49ruVPBOMjyVuFAK4/y5Ax4iEK09Fqksj7pPNJszECH7dEmKac/8DSTyOvJrR8zicufdb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725542358; c=relaxed/simple;
	bh=d56znMciUM9p4xw2Um50vWZeZOAnnrETa8h436ky4W0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=ltAUXTmTS9zDeSOyhu73UbNFNIYI5VJFXqI0OuTzV+kF29TBsDNBV48jH35iLDsrBihmt3SLC5dIuSUquj8aTVOnql0EL3F+jMku/LqGUqgIMUyKoI8EF49cER72892F5HkAe2xyEm1uxr/B3IRVDbDcidOQGD8+Pe9jyLcvTAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=kQm//ty2; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240905131913epoutp014c42046c81ae4abe6b36bbb91ecb1b66~yW6DLO3rf3176731767epoutp01J
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 13:19:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240905131913epoutp014c42046c81ae4abe6b36bbb91ecb1b66~yW6DLO3rf3176731767epoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1725542353;
	bh=Q5oSMGvUvflhjBjYJSywUX4j90vdJn3xoPWfXo4SRas=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=kQm//ty2XFX0OBwG95Xc3h5cepsOptI+hdNMbwrmF6jj5I8ju19xK9JQfzVqdbfRJ
	 GFLLDoHz1Pu65GytWtjAqpnTN3IknAAYkQNDifop+25UTZXsdMAfjuG3tez5+6nkz0
	 zLyNYkI2NJ3kivZuuM0qSTZxLMaajn/X00Yso9ds=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240905131912epcas5p4735dc7b7347dd7ac2c46d2e8fc50f6cb~yW6CsBl_t2085920859epcas5p4D;
	Thu,  5 Sep 2024 13:19:12 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4X00Ll4lk2z4x9Pr; Thu,  5 Sep
	2024 13:19:11 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C0.70.09640.FCFA9D66; Thu,  5 Sep 2024 22:19:11 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240905131910epcas5p499bc4779eaf3f55c1e06963e9a496706~yW6Asz1K80727807278epcas5p4F;
	Thu,  5 Sep 2024 13:19:10 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240905131910epsmtrp1056352d44ad66d0289d6bda9e82373cf~yW6Ar5XjO1768417684epsmtrp1e;
	Thu,  5 Sep 2024 13:19:10 +0000 (GMT)
X-AuditID: b6c32a49-a57ff700000025a8-f6-66d9afcf2338
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	3A.EC.08456.ECFA9D66; Thu,  5 Sep 2024 22:19:10 +0900 (KST)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240905131908epsmtip146b655589ff6e8c8c06dfdd517e64cac~yW5_MFScA1548515485epsmtip17;
	Thu,  5 Sep 2024 13:19:07 +0000 (GMT)
Message-ID: <d5552437-119c-4a0f-9d71-6959727b6364@samsung.com>
Date: Thu, 5 Sep 2024 18:49:06 +0530
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
In-Reply-To: <20240905002611.rxlv66zsker2h5w2@synopsys.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEJsWRmVeSWpSXmKPExsWy7bCmuu759TfTDE6+lrd4c3UVq8WdBdOY
	LE4tX8hk0bx4PZvFpD1bWSzuPvzBYnF51xw2i0XLWpktPh39z2qxqnMOUOz7TmaLSQdFLVYt
	OMDuwOuxf+4ado++LasYPbbs/8zo8XmTXABLVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZ
	gaGuoaWFuZJCXmJuqq2Si0+ArltmDtB5SgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSC
	lJwCkwK94sTc4tK8dL281BIrQwMDI1OgwoTsjK3LKwu2eFd8fDSbsYFxim0XIyeHhICJxKrj
	D9i7GLk4hAR2M0rc/T2fDcL5xCgxYeY/JgjnG6PE02lzGGFaPn8+xQyR2MsoseTVQ1aQhJDA
	W0aJ1ev0QWxeATuJr53PmEFsFgEViYZt91kh4oISJ2c+YQGxRQXkJe7fmsEOYgsLBEhcWTID
	bIGIgI7EgRPnwTYzC3SwSizobmMCSTALiEvcejIfyObgYBMwlHh2wgYkzClgLXHx3CJWiBJ5
	ieats8GOkxBYyyHxa+UcdoirXSRu/VwBZQtLvDq+BcqWknjZ3wZlV0usvvORDaK5hVHi8JNv
	UAl7icdHHzGDLGYW0JRYv0sfYhmfRO/vJ2D3SAjwSnS0CUFUq0qcarzMBmFLS9xbco0VosRD
	4tdSXki49bBKTF+ylGUCo8IspGCZheTLWUjemYWweAEjyypGydSC4tz01GLTAsO81HJ4fCfn
	525iBCdeLc8djHcffNA7xMjEwXiIUYKDWUmE97XIjTQh3pTEyqrUovz4otKc1OJDjKbA+JnI
	LCWanA9M/Xkl8YYmlgYmZmZmJpbGZoZK4ryvW+emCAmkJ5akZqemFqQWwfQxcXBKNTB5SxUG
	Zq76p5jtlyS7093ttuZbDcVc/SC1W7Zqfau/PjmySVp5Xv02FV3GL/nXjyxmsTzwp6ap81F3
	+7Qds7n5OJXdDLQ2Osgyn8yNubvmo/DbKSaS+79PNPpYz6WhsYQ7OU16ckvqAy6LKKbTsqyb
	l9yS2pW54N2FZH+rJ6djZj/Reqz4aE5zs6TPBF5VjfLiq4Wu9zeG6aQ/Sizc43Ts56VXfrv+
	sBha18yzzpJe7hojbyhttlVW+cbLHbM2tv4L/PTW6fVbqZumz+XPPQzfy7xr4yGOVTyCtpvS
	27f9z7zj8GbrGVmWwLspgidNp/yJveh56nbu46cZUrXLagKCNVg2iRfw8DmaHy46ukSJpTgj
	0VCLuag4EQDC+Tb0RQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42LZdlhJTvfc+ptpBgf6ZC3eXF3FanFnwTQm
	i1PLFzJZNC9ez2Yxac9WFou7D3+wWFzeNYfNYtGyVmaLT0f/s1qs6pwDFPu+k9li0kFRi1UL
	DrA78Hrsn7uG3aNvyypGjy37PzN6fN4kF8ASxWWTkpqTWZZapG+XwJWxdXllwRbvio+PZjM2
	ME6x7WLk5JAQMJH4/PkUcxcjF4eQwG5GiVXfZ7JAJKQlXs/qYoSwhSVW/nvODlH0mlHi2KdO
	dpAEr4CdxNfOZ8wgNouAikTDtvusEHFBiZMzn4ANEhWQl7h/awZYvbCAn8T0NyfAhooI6Egc
	OHGeCWQos0APq8SXrx9ZIDYAOX8+TGMDqWIWEJe49WQ+UBUHB5uAocSzEzYgYU4Ba4mL5xax
	QpSYSXRthbiUGWhZ89bZzBMYhWYhuWMWkkmzkLTMQtKygJFlFaNkakFxbnpusWGBUV5quV5x
	Ym5xaV66XnJ+7iZGcJxpae1g3LPqg94hRiYOxkOMEhzMSiK8r0VupAnxpiRWVqUW5ccXleak
	Fh9ilOZgURLn/fa6N0VIID2xJDU7NbUgtQgmy8TBKdXApDFVbvr8ymLWnO3HlF9pdrIucDPw
	uvjrZBTr33h79lvnWeNS06d8SGO516brK1OcJdL9QpNxStLVNZyNjD+aZ5yUfmDt8/hx1Pz1
	2xIj1WTWMbmcOv7nfuQrTn7VAp768/aX0h5sv1fDcozljeCDLXuq9EwLW06zHg04tPTE3Ina
	v+bv+HOhMnHj4rtzlY+uePxzz7ep0eUanXkb+I6c+661LcM/aIry/39a0VnbT1ctZ/d8qdz0
	a+KuVbJve0veT2mPcJPd8SMppUel95zFT0bl64XCXyrlnnyemmp0e8a/oMhDm5d4s4c8LS5i
	/LPpSdJtvRinPc8TkwodH14qd03P8Fm7scbhiGIN99bHHEosxRmJhlrMRcWJAAkVvXYiAwAA
X-CMS-MailID: 20240905131910epcas5p499bc4779eaf3f55c1e06963e9a496706
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240905002630epcas5p4532c1e66864e39990376b696aa1f53d7
References: <20240807003806.5owtgwgw2lczg4u5@synopsys.com>
	<b6baeb45-1684-4fcb-8c71-392cb4788c85@samsung.com>
	<20240808011536.oid627ez4ppdfkhp@synopsys.com>
	<b48e7aba-6c54-431f-bbb5-3e5490df0c1a@samsung.com>
	<20240809234227.eriwy5e6leatzdyh@synopsys.com>
	<b273201d-c589-4c57-9d57-ad2affaeade0@samsung.com>
	<20240831005046.5lndwdr7cfm3k3to@synopsys.com>
	<2e678109-8399-48d5-9567-033eab910bca@samsung.com>
	<20240904010322.leqt3pap6lguivg4@synopsys.com>
	<11535d95-c972-4dbe-afb5-de3a44bc4a21@samsung.com>
	<CGME20240905002630epcas5p4532c1e66864e39990376b696aa1f53d7@epcas5p4.samsung.com>
	<20240905002611.rxlv66zsker2h5w2@synopsys.com>


On 9/5/2024 5:56 AM, Thinh Nguyen wrote:
> On Wed, Sep 04, 2024, Selvarasu Ganesan wrote:
>> On 9/4/2024 6:33 AM, Thinh Nguyen wrote:
>>> On Mon, Sep 02, 2024, Selvarasu Ganesan wrote:
>>>> I would like to reconfirm from our end that in our failure scenario, we
>>>> observe that DWC3_EVENT_PENDING is set in evt->flags when the dwc3
>>>> resume sequence is executed, and the dwc->pending_events flag is not
>>>> being set.
>>>>
>>> If the controller is stopped, no event is generated until it's restarted
>>> again. (ie, you should not see GEVNTCOUNT updated after clearing
>>> DCTL.run_stop). If there's no event, no interrupt assertion should come
>>> from the controller.
>>>
>>> If the pending_events is not set and you still see this failure, then
>>> likely that the controller had started, and the interrupt is generated
>>> from the controller event. This occurs along with the interrupt
>>> generated from your connection notification from your setup.
>>
>> I completely agree. My discussion revolves around the handling of the
>> DWC3_EVENT_PENDING flag in all situations. The purpose of using this
>> flag is to prevent the processing of new events if an existing event is
>> still being processed. This flag is set in the top-half interrupt
>> handler and cleared at the end of the bottom-half handler.
>>
>> Now, let's consider scenarios where the bottom half is not scheduled,
>> and a USB reconnect occurs. In this case, there is a possibility that
>> the interrupt line is unmasked in dwc3_event_buffers_setup, and the USB
>> controller begins posting new events. The top-half interrupt handler
>> checks for the DWC3_EVENT_PENDING flag and returns IRQ_HANDLED without
>> processing any new events. However, the USB controller continues to post
>> interrupts until they are acknowledged.
>>
>> Please review the complete sequence once with DWC3_EVENT_PENDING flag.
>>
>> My proposal is to clear or reset the DWC3_EVENT_PENDING flag when
>> unmasking the interrupt line dwc3_event_buffers_setup, apart from
>> bottom-half handler. Clearing the DWC3_EVENT_PENDING flag in
>> dwc3_event_buffers_setup does not cause any harm, as we have implemented
>> a temporary workaround in our test setup to prevent IRQ storms.
>>
>>
>>
>> Working scenarios:
>> ==================
>> 1. Top-half handler:
>>       a. if (evt->flags & DWC3_EVENT_PENDING)
>>           return IRQ_HANDLED;
>>       b. Set DWC3_EVENT_PENDING flag
>>       c. Masking interrupt line
>>
>> 2. Bottom-half handler:
>>       a. Un-masking interrupt line
>>       b. Clear DWC3_EVENT_PENDING flag
>>
>> Failure scenarios:
>> ==================
>> 1. Top-half handler:
>>       a. if (evt->flags & DWC3_EVENT_PENDING)
>>                   return IRQ_HANDLED;
>>       b. Set DWC3_EVENT_PENDING flag
>>       c. Masking interrupt line
> For DWC3_EVENT_PENDING flag to be set at this point (before we start the
> controller), that means that the GEVNTCOUNT was not 0 after
> soft-disconnect and that the pm_runtime_suspended() must be false.

In the top-half code where we set the DWC3_EVENT_PENDING flag, we 
acknowledge GEVNTCOUNT. Therefore, I think it is not necessary for 
GEVNTCOUNT to have a non-zero value until a new event occurs. In fact, 
when we tried to print GEVNTCOUNT in a non-interrupt context, we found 
that it was zero, where we received DWC3_EVENT_PENDING being set in 
non-interrupt context.

>
>> 2. No Bottom-half scheduled:
> Why is the bottom-half not scheduled? Or do you mean it hasn't woken up
> yet before the next top-half coming?

In very rare cases, it is possible in our platform that the CPU may not 
be able to schedule the bottom half of the dwc3 interrupt because a work 
queue lockup has occurred on the same CPU that is attempting to schedule 
the dwc3 thread interrupt. In this case Yes, the bottom-half handler 
hasn't woken up, then initiate an IRQ storm for new events after the 
controller restarts, resulting in no more bottom-half scheduling due to 
the CPU being stuck in processing continuous interrupts and return 
IRQ_HANDLED by checking if (evt->flags & DWC3_EVENT_PENDING).

>
>> 3. USB reconnect: dwc3_event_buffers_setup
>>       a. Un-masking interrupt line
> Do we know that the GEVNTCOUNT is non-zero before starting the
> controller again?

The GEVNTCOUNT value showing as zero that we confirmed by adding debug 
message here.
>
>> 4. Continuous interrupts : Top-half handler:
>>       a. if (evt->flags & DWC3_EVENT_PENDING)
>>                   return IRQ_HANDLED;
>>
>>       a. if (evt->flags & DWC3_EVENT_PENDING)
>>                   return IRQ_HANDLED;
>>
>>       a. if (evt->flags & DWC3_EVENT_PENDING)
>>                   return IRQ_HANDLED;
>> .....
>>
>> .....
>>
>> .....
>>

Sure, I can try implementing the proposed code modifications in our 
testing environment.

But, I am uncertain about how these changes will effectively prevent an 
IRQ storm when the USB controller sequence restarts with the 
DWC3_EVENT_PENDING. The following code will only execute until the 
DWC3_EVENT_PENDING is cleared, at which point the previous bottom-half 
will not be scheduled.

Please correct me if i am wrong in my above understanding.


static irqreturn_t dwc3_check_event_buf(struct dwc3_event_buffer *evt) { 
struct dwc3 *dwc = evt->dwc; u32 amount; u32 count; .....

.....

.....

if (evt->flags & DWC3_EVENT_PENDING) return IRQ_HANDLED; }


Thanks,
Selva
> I don't want the driver to process any stale event after a
> soft-disconnect. Can we try this instead:
>
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index ccc3895dbd7f..a1e6ba92e808 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -544,6 +544,7 @@ static int dwc3_alloc_event_buffers(struct dwc3 *dwc, unsigned int length)
>   int dwc3_event_buffers_setup(struct dwc3 *dwc)
>   {
>   	struct dwc3_event_buffer	*evt;
> +	u32				reg;
>   
>   	if (!dwc->ev_buf)
>   		return 0;
> @@ -556,7 +557,10 @@ int dwc3_event_buffers_setup(struct dwc3 *dwc)
>   			upper_32_bits(evt->dma));
>   	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0),
>   			DWC3_GEVNTSIZ_SIZE(evt->length));
> -	dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), 0);
> +
> +	/* Clear any stale event */
> +	reg = dwc3_readl(dwc->regs, DWC3_GEVNTCOUNT(0));
> +	dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), reg);
>   
>   	return 0;
>   }
> @@ -2484,7 +2488,11 @@ static int dwc3_runtime_resume(struct device *dev)
>   
>   	switch (dwc->current_dr_role) {
>   	case DWC3_GCTL_PRTCAP_DEVICE:
> -		dwc3_gadget_process_pending_events(dwc);
> +		if (dwc->pending_events) {
> +			pm_runtime_put(dwc->dev);
> +			dwc->pending_events = false;
> +			enable_irq(dwc->irq_gadget);
> +		}
>   		break;
>   	case DWC3_GCTL_PRTCAP_HOST:
>   	default:
> @@ -2574,6 +2582,12 @@ static void dwc3_complete(struct device *dev)
>   static const struct dev_pm_ops dwc3_dev_pm_ops = {
>   	SET_SYSTEM_SLEEP_PM_OPS(dwc3_suspend, dwc3_resume)
>   	.complete = dwc3_complete,
> +
> +	/*
> +	 * Runtime suspend halts the controller on disconnection. It replies on
> +	 * platforms with custom connection notification to start the controller
> +	 * again.
> +	 */
>   	SET_RUNTIME_PM_OPS(dwc3_runtime_suspend, dwc3_runtime_resume,
>   			dwc3_runtime_idle)
>   };
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index 1e561fd8b86e..2fa3fd55eb32 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -1673,7 +1673,6 @@ static inline void dwc3_otg_host_init(struct dwc3 *dwc)
>   #if !IS_ENABLED(CONFIG_USB_DWC3_HOST)
>   int dwc3_gadget_suspend(struct dwc3 *dwc);
>   int dwc3_gadget_resume(struct dwc3 *dwc);
> -void dwc3_gadget_process_pending_events(struct dwc3 *dwc);
>   #else
>   static inline int dwc3_gadget_suspend(struct dwc3 *dwc)
>   {
> @@ -1684,10 +1683,6 @@ static inline int dwc3_gadget_resume(struct dwc3 *dwc)
>   {
>   	return 0;
>   }
> -
> -static inline void dwc3_gadget_process_pending_events(struct dwc3 *dwc)
> -{
> -}
>   #endif /* !IS_ENABLED(CONFIG_USB_DWC3_HOST) */
>   
>   #if IS_ENABLED(CONFIG_USB_DWC3_ULPI)
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 89fc690fdf34..a525f7ea5886 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -4490,6 +4490,17 @@ static irqreturn_t dwc3_check_event_buf(struct dwc3_event_buffer *evt)
>   		return IRQ_HANDLED;
>   
>   	count = dwc3_readl(dwc->regs, DWC3_GEVNTCOUNT(0));
> +
> +	/*
> +	 * If the controller is halted, the event count is stale/invalid. Ignore
> +	 * them. This happens if the interrupt assertion is from an out-of-band
> +	 * resume notification.
> +	 */
> +	if (!dwc->pullups_connected && count) {
> +		dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), count);
> +		return IRQ_HANDLED;
> +	}
> +
>   	count &= DWC3_GEVNTCOUNT_MASK;
>   	if (!count)
>   		return IRQ_NONE;
> @@ -4735,14 +4746,3 @@ int dwc3_gadget_resume(struct dwc3 *dwc)
>   
>   	return dwc3_gadget_soft_connect(dwc);
>   }
> -
> -void dwc3_gadget_process_pending_events(struct dwc3 *dwc)
> -{
> -	if (dwc->pending_events) {
> -		dwc3_interrupt(dwc->irq_gadget, dwc->ev_buf);
> -		dwc3_thread_interrupt(dwc->irq_gadget, dwc->ev_buf);
> -		pm_runtime_put(dwc->dev);
> -		dwc->pending_events = false;
> -		enable_irq(dwc->irq_gadget);
> -	}
> -}
>
>
> ---
>
> Thanks,
> Thinh

