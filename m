Return-Path: <linux-kernel+bounces-340202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 162E8986FCC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 11:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3803D1C24A67
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464611AAE0E;
	Thu, 26 Sep 2024 09:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="N5xBRn3/"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B287213D62B;
	Thu, 26 Sep 2024 09:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727342214; cv=none; b=sFhvVze1sadgJZ5Z/ohDncU2EuuDYjznk+CTOkHw3vwgwmrnt63D5laIy9g/gACXgVVefmLlM+NlhVicFHBoTrVYKsJjagm77ulKwgerpgclfJwSruApBEnmBVukj0ugMpyiDCcT2wat0O9tVxHaQ7ygvTaTZXp+fjCtbFeyfLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727342214; c=relaxed/simple;
	bh=0BlbGVh+p4w4Xnjx5fHUiQzH/RWNpSzToWJXCIACgVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XEF8sxQEnO7R5f92TMpkPFHq3j2PzO2cK2CYmvI/kI999cDWmjmTH/ti/+EPyNPzYZdo7SYFyLttdsW+wpmVkSLL6bGKexguCxns1/OCGaTn8Cxf/7/hBk46fuMzGE/m40Ebcomj7TKAfSsnVnexIeNnJdBzzaxAvyorg/+mZdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=N5xBRn3/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48PMuIUE021497;
	Thu, 26 Sep 2024 09:16:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dHhLGruJU4O8oAVTjdKMxeK0yqgvEmrqgOdPQtlQBfQ=; b=N5xBRn3/orZGLVBi
	XzsuoSwXIZK3j7lFfUw7l8S3btaa9nssal88asliKkjW9ekEzassB9WZ7M5Z/toN
	YZOMoSN5iSjrpjif8CYKadfmjFUDLeuRQvPpVDvJxVrj0XW22lBP7IrQmgsCXuhj
	UHWU20shzhtTUFpo1uX5BWvDA/J55UjKSnvSr56nkAG/sW7KZpmVIoojXn8dEBxQ
	UemSzRhJKKndcAhPteevhTD0YqBSipN1TfhV6+StRW9Hgq9pXe+6wJwnQzGQ/3NK
	yjB+WcN0dCGy4UHQrqVF0Al8MPT39SC93vurTQxofO6IKmxgVRsHoF5DYsSa9PFK
	dYSTZg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41sqe9eqx5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Sep 2024 09:16:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48Q9GhNR027771
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Sep 2024 09:16:43 GMT
Received: from [10.218.35.239] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 26 Sep
 2024 02:16:41 -0700
Message-ID: <47689c2e-505e-461c-88dd-d178a7fdd087@quicinc.com>
Date: Thu, 26 Sep 2024 14:46:38 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: u_serial: fix null-ptr-deref in gs_start_io
To: hbuczynski <hubert.buczynski94@gmail.com>, <balbi@kernel.org>,
        <gregkh@linuxfoundation.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        hubert.buczynski <Hubert.Buczynski.ext@feig.de>
References: <20240926064910.17429-1-hubert.buczynski94@gmail.com>
Content-Language: en-US
From: Prashanth K <quic_prashk@quicinc.com>
In-Reply-To: <20240926064910.17429-1-hubert.buczynski94@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ZLTM5lSsg2KzXFcW32QKWYJciaLpnUsP
X-Proofpoint-GUID: ZLTM5lSsg2KzXFcW32QKWYJciaLpnUsP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=785 spamscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 phishscore=0 impostorscore=0 clxscore=1011
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409260062



On 26-09-24 12:19 pm, hbuczynski wrote:
> From: "hubert.buczynski" <Hubert.Buczynski.ext@feig.de>
> 
> The commit "5a444bea usb: gadget: u_serial: Set start_delayed during
> suspend" caused invocation of the gs_start_io in the gserial_resume.
> The gs_start_io doesn't check the ptr of the 'port.tty'. As a result, the
> tty_wakeup function is passed on to the NULL ptr causing kernel panic.
> 
> There is a deterministic scenario leading to the kernel error:
> 1. Set the device in peripheral OTG mode.
> 2. Attach the USB cable to the host.
> 3. Do not take any action on the host side.
> 4. Send data to the host, for example:
> $ echo "hello\n" > /dev/ttyGS0
> 5. Disconnect the USB cable.
> 6. Connect the USB cable and the kernel panic should be visible.
> 
> Fragment of the kernel panic log message:
> 
> Internal error: Oops: 5 [#1] PREEMPT SMP ARM
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper/0 Tainted: P O 5.15.166 #88
> Hardware name: STM32 hDevice Tree Support)
> PC is at tty_wakeup+0x8/0x5c
> LR is at gs_start_io+0x90/0xdc
> pc : [<c0623f74>]    lr : [<c083eeac>]    psr: 60010193
> sp : c1001da0  ip : c32e6944  fp : 80000000
> r10: c32e6934  r9 : c32e6928  r8 : c32e68ec
> r7 : c32e68e0  r6 : c2be6c40  r5 : 00000000  r4 : 00000000
> r3 : 00000000  r2 : 00000000  r1 : 60010193  r0 : 00000000
> Flags: nZC»  IRQs off  FIQs on  Mode SVC_32  ISA ARM Segment none
> Control: 10c5387d  Table: c3ac406a  DAC: 00000051
> Register r0 information: NULL pointer
> Register r1 information: non-paged memory
> Register r2 information: NULL pointer
> Register r3 information: NULL pointer
> Register r4 information: NULL pointer
> Register r5 information: NULL pointer
> [<c0623f74>] (tty_wakeup) from [<c083eeac>] (gs_start_io+0x90/0xdc)
> [<c083eeac>] (gs_start_io) from [<c083f0c0>](gserial_resume+0x6c/0xd4)
> [<c083f0c0>] (gserial_resume) from [<c082a35c>] (composite_resume+0x70/0x10c)
> [<c082a35c>] (composite_resume) from [<c082d668>] (configfs_composite_resume+0x54/0x64)
> [<c082d668>] (configfs_composite_resume) from [<c07c26c4>] (dwc2_handle_wakeup_detected_intr+0x15c/0x2e8)
> [<c07c26c4>] (dwc2_handle_wakeup_detected_intr) from [<c07c2c74>] (dwc2_handle_common_intr+0x424/0x630)
> [<c07c2c74>] (dwc2_handle_common_intr) from [<c0190168>] (__handle_irq_event_percpu+0x50/0x250)
> [<c0190168>] (__handle_irq_event_percpu) from [<c0190440>] (handle_irq_event+0x58/0xc4)
> [<c0190440>] (handle_irq_event) from [<c0194f9c>] (handle_fasteoi_irq+0x9c/0x204)
> [<c0194f9c>] (handle_fasteoi_irq) from [<c018fb2c>] (handle_domain_irq+0x58/0x74)
> [<c018fb2c>] (handle_domain_irq) from [<c0101328>] (gic_handle_irq+0x7c/0x90)
> [<c0101328>] (gic_handle_irq) from [<c0100b7c>] (__irq_svc+0x5c/0x90)
> 
> If the device sends data and does not receive msg from the host then the
> field port->read_started contains a positive value. After disconnecting
> the cable, gserial_suspend() is invoked and the port->start_delayed is set
> to true. Connecting the cable again causes invocation of the
> gserial_resume().
> The callstack after connecting the cable looks like the following:
> gserial_resume()
>   --> gs_start_io()
>     --> tty_wakeup() - with NULL argument
> 
> Fixes: 5a444bea37e2 ("usb: gadget: u_serial: Set start_delayed during suspend")
> 
> Signed-off-by: hubert.buczynski <Hubert.Buczynski.ext@feig.de>
> ---
>  drivers/usb/gadget/function/u_serial.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
> index 5111fcc0cac3..384f219fe01d 100644
> --- a/drivers/usb/gadget/function/u_serial.c
> +++ b/drivers/usb/gadget/function/u_serial.c
> @@ -564,7 +564,7 @@ static int gs_start_io(struct gs_port *port)
>  	port->n_read = 0;
>  	started = gs_start_rx(port);
>  
> -	if (started) {
> +	if (started && port->port.tty) {
>  		gs_start_tx(port);
>  		/* Unblock any pending writes into our circular buffer, in case
>  		 * we didn't in gs_start_tx() */

Commit ffd603f21423 ("usb: gadget: u_serial: Add null pointer check in
gs_start_io") fixed this issue. Please try adding it into your builds.

Regards,
Prashanth K

