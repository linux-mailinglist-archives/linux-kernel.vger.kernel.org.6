Return-Path: <linux-kernel+bounces-323163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 788329738C1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 15:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D0F61C24299
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 13:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A8A192D8C;
	Tue, 10 Sep 2024 13:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="L4gy/aaJ"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA3F1922F4
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 13:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725975474; cv=none; b=k0xuPW26b2UtiRpARh6PgchBRNTlFsPfrUGah4Ih+XY7JWvoaZAt9LiWYTpAIX5VNsJrws2HNrCR/BoUlsbsxqISHiskHxwmnI/5MY6KDlZ7Y4LR0DhvtmBDwUFCo74u9V72DNBQ9+EOxNOq+d2eCngI07NgHAifVhMqIOLUYEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725975474; c=relaxed/simple;
	bh=F1nnKjw5JWKrv0UivfX+cMJ6hkeW1uOfmktdZO120YA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:In-Reply-To:
	 Content-Type:References; b=BKK0HRCfPGhmiWcz/gqWjOfJ1Vxz/Booo8BDCHc3Zv205nw9/9j9J42Xozf79SL8f6xLH31RVvwAwbkEgmsAJ18PsDvf/7puZ656HbIWHAxKGQlan4mUJPturmTY6emRbgObP8+OBdwO++MM+y1oKETF5Dzaa6mwwTvPYyO3gys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=L4gy/aaJ; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240910133749epoutp023fb7c733ad1bf9683ae3b3d0192387ec~z5YtwUEh40993009930epoutp02U
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 13:37:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240910133749epoutp023fb7c733ad1bf9683ae3b3d0192387ec~z5YtwUEh40993009930epoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1725975469;
	bh=V2jX6S5jxmXGwvz9YAgIq6JEb5TjbdLJEKL1WqTvCT8=;
	h=Date:From:Subject:To:Cc:In-Reply-To:References:From;
	b=L4gy/aaJ0d3HetKmHB9RCzrje4iWYVVgneWIHs5kwSGn+dUcrco0HMaTnbeWA65rn
	 djdPnoGTTE684PWKwtsSjYy/NxIyefex2oVb0vkozaAICPPwBGjmqdT6rSM9NRgGJ/
	 qMmG/UhQ4kGvmuQRQnParfJta2URUO/zuuZUeb4I=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240910133748epcas5p30b7e5807bba43052efbaa462255ff814~z5YtYnTHs1397213972epcas5p3j;
	Tue, 10 Sep 2024 13:37:48 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4X34Wv4ppnz4x9Px; Tue, 10 Sep
	2024 13:37:47 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	6D.9F.08855.BAB40E66; Tue, 10 Sep 2024 22:37:47 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240910133747epcas5p3d74fd2fcf2efe0507b27c12bcc5f062c~z5YrsZ3Vr0055100551epcas5p3X;
	Tue, 10 Sep 2024 13:37:47 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240910133747epsmtrp2e4c3a2107d0836ce9fc4270346cf9bc6~z5YrrqQlk1375313753epsmtrp2S;
	Tue, 10 Sep 2024 13:37:47 +0000 (GMT)
X-AuditID: b6c32a44-107ff70000002297-48-66e04babc447
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	39.6C.07567.AAB40E66; Tue, 10 Sep 2024 22:37:46 +0900 (KST)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240910133744epsmtip27f2e324b6766ae6c65b461f624cbeea6~z5YpMZHrI2586125861epsmtip2V;
	Tue, 10 Sep 2024 13:37:44 +0000 (GMT)
Message-ID: <dff83c7d-56b8-481f-af69-8d4262bd54e4@samsung.com>
Date: Tue, 10 Sep 2024 19:07:28 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
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
In-Reply-To: <20240907003946.qn6t3xw65qwl2cn7@synopsys.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0xbVRz29N6+FmvuOiqHzrl6zWJKgLVY6mUrzCmabiMGnU4l0VroHSX0
	tdvicBIda4cTpWBjllqogOtA20UIslILpLNInHWOCIzwGKCzUQZDA+g2t9nZ9qLy33e+3/f9
	noeD8LtZQk65wUJSBrUOZ21A/YNicaZv348HJQNjm4lrl7xM4nLrSQYR6WhjENZTnSzC0X8W
	JWZ+uokSo8FmFvFJ+3GEWBm6yyS87zbHuRtfIoTjKwHhbT3HfpynDLnPsJX2Hi9Q9oRWgXK1
	+8EitLhCoSXVGpISkYZSo6bcUJaH79uvelKVI5dIM6W5xGO4yKDWk3l4QWFR5tPlunh7uOh1
	ta4yThWpzWZ8e76CMlZaSJHWaLbk4aRJozPJTFlmtd5caSjLMpCWHVKJJDsnLnytQtu97AEm
	b3bVUuwO+ygIpNcBLgdiMhj0d7DqwAYOH+sD0FnvQhMBPrYC4LHgK3TgOoBNFx3MOsBJOrrD
	z9D8AIAjXV5AP5YAtM1Z2Qk3D8uHo8MzjARGsW3QP+UGNL8RfvtRNFlBgG2Fc1NOdiIpC5PC
	X84rEvQmrAiOeZxJeQqWAc+dH2Yk8iPYCSZsfa82mRPBUuFUtCWJudhOONS2AGh+K7SebUIS
	BogFODD0Theg5yyAtX+NsGm8CS5807OGhXD1twEWjd+EvsvLLNpsA3Awen1NtAv+PHQFSXSK
	YGLYGdxOF7sP1t+OMuit8OCJWj6t3gYjNaNrKTfDWc/42uKU8NZpHr2raRTO/9nOagQi17q1
	uNaN5lo3juv/wq0A9YI00mTWl5GlOSapgTz8371LjfpukPy86QUBMNESywoDBgeEAeQgeAqv
	IX/2IJ+nUb9xhKSMKqpSR5rDICd+nw8QoaDUGP/9BotKKsuVyORyuSz3UbkUT+UtHndr+FiZ
	2kJWkKSJpP71MThc4VGGJ+WhtMKuPlfEx63pTLvX4XNbx6r3Tro7ovlzDvvwYkj8of/7GNmn
	QIeXmyeLD1xkKh6ozzj5vioV/0zfH2t8pIgquXJg/ojHfv/v8o7nD/umq97Ori6heucbXm7s
	UxXXUJqpYt3Ve9prHdeWL4z/8GsTdleBBp596lRaKHCprdAza9vv/Lz/2JJwlbd79+2Z7JW/
	b9h6N7Z4V9noCzclYxjSu0U7ffrjqy/eQqwTKYcavhaEszrDFxYGdzxRNbkyseDYZW97iVs4
	bh0arAuybL5IlX3PcyV/ZPBGoJh49WHFWzvZ2kZVNe/TM4tb/LE7TtWhLwQRv4GasIx9VzM3
	jaNmrVqajlBm9T9gxDpRRQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42LZdlhJXneV94M0g5ZGI4s3V1exWtxZMI3J
	4tTyhUwWzYvXs1lM2rOVxeLuwx8sFpd3zWGzWLSsldni09H/rBarOucAxb7vZLaYdFDUYtWC
	A+wOvB77565h9+jbsorRY8v+z4wenzfJBbBEcdmkpOZklqUW6dslcGVs+riEsWCVUcXbf3/Y
	Gxh3aHUxcnBICJhIbDrk18XIxSEksJtRoqvrIXsXIydQXFri9awuRghbWGLlv+fsEEWvGSXW
	3t7MApLgFbCTuHz+LhOIzSKgKrHt1lxGiLigxMmZT8BqRAXkJe7fmsEOsoxNwFDi2QkbkLCw
	gJ/E9DcnwMpFBHQkDpw4zwQyn1mgh1Xiy9ePLBDLbrNIHPi4hhmkillAXOLWk/lgyzgFrCWO
	LnzFCBE3k+ja2gVly0s0b53NPIFRaBaSO2YhaZ+FpGUWkpYFjCyrGCVTC4pz03OTDQsM81LL
	9YoTc4tL89L1kvNzNzGC40xLYwfjvfn/9A4xMnEwHmKU4GBWEuHtt7uXJsSbklhZlVqUH19U
	mpNafIhRmoNFSZzXcMbsFCGB9MSS1OzU1ILUIpgsEwenVAOTpb7thbJT10/aloswvbr0/uNH
	hebemSufsd1SdxeJWmXv9jbvV4XdUpv9Aao1p9gLovqPrCzboSCYrqDyRyq2fi7zpROcgbsE
	LG4umrU3hSk8q5aPT/Clvmzzks9Hb803S/oi90ONa//5FUu3nL4xdbHlhINcbn+c750NP/Eg
	ktGk5vGaVhXL5hu7n16/3cdxwr9Becvmzxptsx0PzPJmPrhml73Q1xuf+L9Fc7UEi7Z0rGwu
	mPVJv2hNUu6/pLPzb/y/p2W8Q/bKu0fhV197fE47/O7JXovc6xvmP2CeVfWgLnLbD5G3covW
	JYZ8+vGb/3STlM2EU54qXwLe7fh6Kr3gbnZjrXPOCf6Jwk475yixFGckGmoxFxUnAgDHfr62
	IgMAAA==
X-CMS-MailID: 20240910133747epcas5p3d74fd2fcf2efe0507b27c12bcc5f062c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240905002630epcas5p4532c1e66864e39990376b696aa1f53d7
References: <11535d95-c972-4dbe-afb5-de3a44bc4a21@samsung.com>
	<CGME20240905002630epcas5p4532c1e66864e39990376b696aa1f53d7@epcas5p4.samsung.com>
	<20240905002611.rxlv66zsker2h5w2@synopsys.com>
	<d5552437-119c-4a0f-9d71-6959727b6364@samsung.com>
	<20240905211338.omst6jr3okbxkqdh@synopsys.com>
	<f9561f03-5f83-4270-b7f3-17b880cfabfe@samsung.com>
	<20240905231825.6r2sp2bapxidur7a@synopsys.com>
	<64d049cc-d55d-4376-b6b9-402eb6f170c0@samsung.com>
	<20240906005935.caugoe3mqqdqwqao@synopsys.com>
	<30ca8527-419b-4e44-a21b-18e494b39076@samsung.com>
	<20240907003946.qn6t3xw65qwl2cn7@synopsys.com>


On 9/7/2024 6:09 AM, Thinh Nguyen wrote:
> On Sat, Sep 07, 2024, Selvarasu Ganesan wrote:
>> Hi Thinh,
>>
>> I ran the code you recommended on our testing environment and was able
>> to reproduce the issue one time.
>>
>> When evt->flags contains DWC3_EVENT_PENDING, I've included the following
>> debugging information: I added this debug message at the start of
>> dwc3_event_buffers_cleanup and dwc3_event_buffers_setup functions in
>> during suspend and resume.
>>
>> The results were quite interesting . I'm curious to understand how
>> evt->flags is set to DWC3_EVENT_PENDING, and along with DWC3_GEVNTSIZ is
>> equal to 0x1000 during the suspend.
> That is indeed strange.
>
>> Its means that the previous bottom-half handler prior to suspend might
>> still be executing in the middle of the process.
>>
>> Could you please give your suggestions here? And let me know if anything
>> want to test or additional details are required.
>>
>>
>> ##DBG: dwc3_event_buffers_cleanup:
>>    evt->length    :0x1000
>>    evt->lpos      :0x20c
>>    evt->count     :0x0
>>    evt->flags     :0x1 // This is Unexpected if DWC3_GEVNTSIZ(0)(0xc408):
>> 0x00001000. Its means that previous bottom-half handler may be still
>> running in middle
> Perhaps.
>
> But I doubt that's the case since it shouldn't take that long for the
> bottom-half to be completed before the next resume yet the flag is still
> set.
>
>>    DWC3_GEVNTSIZ(0)(0xc408)       : 0x00001000
>>    DWC3_GEVNTCOUNT(0)(0xc40c)     : 0x00000000
>>    DWC3_DCFG(0xc700)              : 0x00e008a8
>>    DWC3_DCTL(0xc704)              : 0x0cf00a00
>>    DWC3_DEVTEN(0xc708)            : 0x00000000
>>    DWC3_DSTS(0xc70c)              : 0x00d20cd1
>>
> The controller status is halted. So there's no problem with
> soft-disconnect. For the interrupt mask in GEVNTSIZ to be cleared,
> that likely means that the bottom-half had probably completed.

Agree, But I am worrying on If the bottom-half is completed, then 
DWC3_EVENT_PENDING must be cleared in evt->flags.
Is there any possibility of a CPU reordering issue when updating 
evt->flags in the bottom-half handler?.
Should I try with wmb() when writing to evt->flags?
>
>> ##DBG: dwc3_event_buffers_setup:
>>    evt->length    :0x1000
>>    evt->lpos      :0x20c
> They fact that evt->lpos did not get updated tells me that there's
> something wrong with memory access to your platform during suspend and
> resume.

Are you expecting the evt->lpos value to be zero here? If so, this is 
expected in our test setup because we avoid writing zero to evt->lpos as 
part of dwc3_event_buffers_cleanup if evt->flags have a value of 1. This 
is simply to track the status of evt->lpos during suspend to resume when 
evt->flags have a value of DWC3_EVENT_PENDING. The following test codes 
for the reference.

--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -505,8 +505,20 @@ static int dwc3_alloc_event_buffers(struct dwc3 
*dwc, unsigned int length)
  int dwc3_event_buffers_setup(struct dwc3 *dwc)
  {
         struct dwc3_event_buffer        *evt;
+       u32                             reg;

         evt = dwc->ev_buf;
+
+       if (evt->flags & DWC3_EVENT_PENDING) {
+               pr_info("evt->length :%x\n", evt->length);
+               pr_info("evt->lpos :%x\n", evt->lpos);
+               pr_info("evt->count :%x\n", evt->count);
+               pr_info("evt->flags :%x\n", evt->flags);
+
+               dwc3_exynos_reg_dump(dwc);
+
+       }
+
         evt->lpos = 0;
         dwc3_writel(dwc->regs, DWC3_GEVNTADRLO(0),
                         lower_32_bits(evt->dma));
@@ -514,8 +526,10 @@ int dwc3_event_buffers_setup(struct dwc3 *dwc)
                         upper_32_bits(evt->dma));
         dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0),
                         DWC3_GEVNTSIZ_SIZE(evt->length));
-       dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), 0);

+       /* Clear any stale event */
+       reg = dwc3_readl(dwc->regs, DWC3_GEVNTCOUNT(0));
+       dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), reg);
         return 0;
  }

@@ -525,7 +539,16 @@ void dwc3_event_buffers_cleanup(struct dwc3 *dwc)

         evt = dwc->ev_buf;

-       evt->lpos = 0;
+       if (evt->flags & DWC3_EVENT_PENDING) {
+               pr_info("evt->length :%x\n", evt->length);
+               pr_info("evt->lpos :%x\n", evt->lpos);
+               pr_info("evt->count :%x\n", evt->count);
+               pr_info("evt->flags :%x\n", evt->flags);
+
+               dwc3_exynos_reg_dump(dwc);
+       } else {
+               evt->lpos = 0;
+       }

>
>>    evt->count     :0x0
>>    evt->flags     :0x1 // Still It's not clearing in during resume.
>>
>>    DWC3_GEVNTSIZ(0)(0xc408)       : 0x00000000
>>    DWC3_GEVNTCOUNT(0)(0xc40c)     : 0x00000000
>>    DWC3_DCFG(0xc700)              : 0x00080800
>>    DWC3_DCTL(0xc704)              : 0x00f00000
>>    DWC3_DEVTEN(0xc708)            : 0x00000000
>>    DWC3_DSTS(0xc70c)              : 0x00d20001
>>
> Please help look into your platform to see what condition triggers this
> memory access issue. If this is a hardware quirk, we can properly update
> the change and note it to be so.

Sure I will try to figure it out. However, we are facing challenges in 
reproducing the issue. There could be a delay in understanding the 
conditions that trigger the memory issue if it is related to a memory issue.

>
> Thanks,
> Thinh
>
> (If possible, for future tests, please dump the dwc3 tracepoints. Many
> thanks for the tests.)

I tried to get dwc3 traces in the failure case, but so far no instances 
have been reported. Our testing is still in progress with enable dwc3 
traces.

I will keep posting once I get the dwc3 traces in the failure scenario.


Thanks,
Selva

