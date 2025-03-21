Return-Path: <linux-kernel+bounces-571143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB88EA6B9B7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2959B189325E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 11:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D662206BB;
	Fri, 21 Mar 2025 11:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P8YlAQG1"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AD91F03CA
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 11:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742555885; cv=none; b=uvi85uxyK5JFTs9q7i9mES3MqtJaXe/SqltmG307NJ2XDyBXhaFlbrDqhbfEMxGYq06BzIMAs5t36lRQhjoX503PNMS83O2FHWC9molupR4fmYnUmCNLIIkUnjKRvX1HRLo1bfMm2VxDurSz+sl69b6lCYW7qyXi4LUhC4eF4m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742555885; c=relaxed/simple;
	bh=f1rXoMSurkAvAixN8mEIRxqVUGV9fiv0n2OqrybEd6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DojyyT6vG3DkB/hGFW6YxnP3C809ycFkSgF9rrjL2Z92QIZFcAzuHXeB9nOe12X9IxgF+PCKRbczSh9usqoHtlWBgoEEe7HxHtvzfX0LfObI8F4Qrr33Rmk0MnU7OvSbPulrm+04T7OkF4XbrTDBDpt5Eqyl5tJMUJmMIjBAQL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P8YlAQG1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LATAAd022106
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 11:18:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=DKUSYoHR6fJ9Gx9eEsTaF2oL
	MprzdUw0AcuNtKcNv44=; b=P8YlAQG1SDRbzIqC2q4Nfz0GyHgq+0u+Rc0ZNDHJ
	1ICrxaboFhd5fjVpf9lZzZ6WTjuELXkaX/JUhMlMEAq4+gWgJ61Rrb+GN92V2MRu
	g9DJ1rDQFs4UmkS8mcpS5ZzZJrUMtNqQH2R2tzs0uAF2gvhSpMPidNRKKINUsObh
	tM1v+JOAwJp4pn8lNWXwF0PTJoYDxD62nOyQt3ZtVyDMN87OZ7PCyQAEn8GMHZc6
	su66goVlKESiOHIzaX6T5yyMK0R55ijnjRm/Cux2EzAe6VhKSuodhhT+uKnFibPE
	wxUZFTSndipA94ZqJVY0WIxJTNMB6yOa8waVxqORqC8tag==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45h4wpge7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 11:18:02 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ff798e8c90so2982011a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 04:18:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742555881; x=1743160681;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DKUSYoHR6fJ9Gx9eEsTaF2oLMprzdUw0AcuNtKcNv44=;
        b=jDW5mlU+ObD0knri6IVFKDxpE44qtEatCLsOFq3R2+7mZ2Gsoq0KAvIRKlWp9VsNRZ
         LAjL0jy9jDnagydIREiknCoT+8awzVmalnOHvGbB4YYGU8YAHX0XofCcEjOsACv5DaUw
         AnOxAJ1fJI/O/+W2h6bE+OFe3TlgIKCN4Z5R+vF9fXkiSjSI9sjamvfWnO7q8h8/YBMy
         jOiOlLXI34FFfxrSMvCX1z/CZryTrki1fYpph9GcSK2ITbt9WtDMMmcMbdedPQG9zMbv
         NEMVTGXZ7sAfsrj3oT5fAm+0dbQwaFPP8YNFNhz5+K/ow8FZti6iylf5V3WiU5TYQzv6
         cL+w==
X-Forwarded-Encrypted: i=1; AJvYcCWGlwJlZSDffcaaQSazMXJpbhbh4irV1gdgi24AZIvHmu5jZbPJ0VfDpI/zsppHFe4GWn4UVDTzYCJj1pI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxusLZSS22qaQDj4d/esI2HwZn2/eZtkG/2P6NYNriwwCGj+rEv
	SOkmgx7JgkiyS702w4FAPCeJoqhFfEmTs9jv370vMrxqV9TI68NJJP3qdqkmaoezVdDIlYeRPiZ
	NAJUWKttGC9E5IET96nm6DEx5TagRL26uCS6jy8WacOLuK5eTeSKDoZCoUDiiNYgoaP1UGBS/un
	C+0fOoZE9/kajC1+KnZKymJi83XFqlihZFzbAL/g==
X-Gm-Gg: ASbGncspmJ6f83IsshsHn6nUVCamXggYqcO888Yxb7AacaZoMCje99QOQUn6xeWg0mV
	o8hnVQOO+QEPArrzkWxcYbwYzUI5ZzR3MWuB3iMaAyBxryAFyH+nuZ086SEpljPasQtgztqyN8u
	ErKQm+xx77jYYtX7cLfTSyrimyAXbF
X-Received: by 2002:a17:90b:53c3:b0:2fe:afbc:cd53 with SMTP id 98e67ed59e1d1-3030ff108camr4495956a91.28.1742555881125;
        Fri, 21 Mar 2025 04:18:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYUrRBiFxt4TF2dj2f7+rt3svO89e0vefSuFBivuUS0vkcM09QvsSAFZQaqgBo6AsU157kO11HvgGAwjzYsvk=
X-Received: by 2002:a17:90b:53c3:b0:2fe:afbc:cd53 with SMTP id
 98e67ed59e1d1-3030ff108camr4495906a91.28.1742555880604; Fri, 21 Mar 2025
 04:18:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127044239.578540-1-quic_ekangupt@quicinc.com>
 <20250127044239.578540-5-quic_ekangupt@quicinc.com> <hgox77a7e6zzriltwhzzciau6u2pmil4y3rl5o2l6zkp4fmlmp@q2dai5fxcvtq>
 <49295da9-82d4-45a0-a2a4-fdaa6600c70d@quicinc.com> <an4cvztdkqmrt7w2iaziihlxf4tbox65ze362v2lmycjnqg26y@jizjmh2ki34z>
 <939fcff6-fb93-487b-995b-88e3ff020784@oss.qualcomm.com> <2k6573yrw3dyn3rpwqz4asdpx3nlmj4ornm7kmxv3f4jlc6hzg@qkwn7gqduwri>
 <e46be95c-ca8d-48ce-a616-5f068bd28ebc@oss.qualcomm.com> <4ca8776c-3cc7-4266-8248-4a595fa19e7f@oss.qualcomm.com>
In-Reply-To: <4ca8776c-3cc7-4266-8248-4a595fa19e7f@oss.qualcomm.com>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 21 Mar 2025 13:17:49 +0200
X-Gm-Features: AQ5f1Jqtw8pLC3Jce_RInf4WAkyM5BsJM6J6o4bkxV8dEDbjppN-Wyx9DCzNbwI
Message-ID: <CAO9ioeXVyN+gn=tHP4HsRTs=4AFrrqiyRJw3byxhrcgu4+Quqw@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] misc: fastrpc: Add polling mode support for
 fastRPC driver
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org,
        gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
        linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
        dri-devel@lists.freedesktop.org, arnd@arndb.de
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-ORIG-GUID: w5tEAd4K3_ALkkzJuCOd2SLEJrqQexFH
X-Proofpoint-GUID: w5tEAd4K3_ALkkzJuCOd2SLEJrqQexFH
X-Authority-Analysis: v=2.4 cv=ZN3XmW7b c=1 sm=1 tr=0 ts=67dd4aea cx=c_pps a=0uOsjrqzRL749jD1oC5vDA==:117 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=EdpeIRtKRTEnfPEYN64A:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_04,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 clxscore=1015 phishscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 spamscore=0 mlxscore=0 priorityscore=1501
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503210083

On Fri, 21 Mar 2025 at 12:18, Ekansh Gupta
<ekansh.gupta@oss.qualcomm.com> wrote:
>
>
>
> On 3/20/2025 9:27 PM, Ekansh Gupta wrote:
> >
> > On 3/20/2025 7:45 PM, Dmitry Baryshkov wrote:
> >> On Thu, Mar 20, 2025 at 07:19:31PM +0530, Ekansh Gupta wrote:
> >>> On 1/29/2025 4:10 PM, Dmitry Baryshkov wrote:
> >>>> On Wed, Jan 29, 2025 at 11:12:16AM +0530, Ekansh Gupta wrote:
> >>>>> On 1/29/2025 4:59 AM, Dmitry Baryshkov wrote:
> >>>>>> On Mon, Jan 27, 2025 at 10:12:38AM +0530, Ekansh Gupta wrote:
> >>>>>>> For any remote call to DSP, after sending an invocation message,
> >>>>>>> fastRPC driver waits for glink response and during this time the
> >>>>>>> CPU can go into low power modes. Adding a polling mode support
> >>>>>>> with which fastRPC driver will poll continuously on a memory
> >>>>>>> after sending a message to remote subsystem which will eliminate
> >>>>>>> CPU wakeup and scheduling latencies and reduce fastRPC overhead.
> >>>>>>> With this change, DSP always sends a glink response which will
> >>>>>>> get ignored if polling mode didn't time out.
> >>>>>> Is there a chance to implement actual async I/O protocol with the help
> >>>>>> of the poll() call instead of hiding the polling / wait inside the
> >>>>>> invoke2?
> >>>>> This design is based on the implementation on DSP firmware as of today:
> >>>>> Call flow: https://github.com/quic-ekangupt/fastrpc/blob/invokev2/Docs/invoke_v2.md#5-polling-mode
> >>>>>
> >>>>> Can you please give some reference to the async I/O protocol that you've
> >>>>> suggested? I can check if it can be implemented here.
> >>>> As with the typical poll() call implementation:
> >>>> - write some data using ioctl
> >>>> - call poll() / select() to wait for the data to be processed
> >>>> - read data using another ioctl
> >>>>
> >>>> Getting back to your patch. from you commit message it is not clear,
> >>>> which SoCs support this feature. Reminding you that we are supporting
> >>>> all kinds of platforms, including the ones that are EoLed by Qualcomm.
> >>>>
> >>>> Next, you wrote that in-driver polling eliminates CPU wakeup and
> >>>> scheduling. However this should also increase power consumption. Is
> >>>> there any measurable difference in the latencies, granted that you
> >>>> already use ioctl() syscall, as such there will be two context switches.
> >>>> What is the actual impact?
> >>> Hi Dmitry,
> >>>
> >>> Thank you for your feedback.
> >>>
> >>> I'm currently reworking this change and adding testing details. Regarding the SoC
> >>> support, I'll add all the necessary information.
> >> Please make sure that both the kernel and the userspace can handle the
> >> 'non-supported' case properly.
> > Yes, I will include changes to handle in both userspace and kernel.
>
> I am seeking additional suggestions on handling "non-supported" cases before making the
> changes.
>
> Userspace: To enable DSP side polling, a remote call is made as defined in the DSP image.
> If this call fails, polling mode will not be enabled from userspace.

No. Instead userspace should check with the kernel, which capabilities
are supported. Don't perform API calls which knowingly can fail.

>
> Kernel: Since this is a DSP-specific feature, I plan to add a devicetree property, such
> as "qcom,polling-supported," under the fastrpc node if the DSP supports polling mode.

This doesn't sound like a logical solution. The kernel already knows
the hardware that it is running on. As such, there should be no need
to further describe the hardware in DT. If the DSP firmware can report
its capabilities, use that. If not, extend the schema to add an
SoC-specific compatibility string. As a last resort we can use
of_machine_is_compatible().

>
> Does this approach seem appropriate, or is there a better way to handle this?
>
> Thanks,
> Ekansh
>
> >
> >>> For now, with in-driver
> >>> polling, we are seeing significant performance improvements for calls
> >>> with different sized buffers. On polling supporting platform, I've observed an
> >>> ~80us improvement in latency. You can find more details in the test
> >>> results here:
> >>> https://github.com/quic/fastrpc/pull/134/files#diff-7dbc6537cd3ade7fea5766229cf585db585704e02730efd72e7afc9b148e28ed
> >> Does the improvement come from the CPU not goint to idle or from the
> >> glink response processing?
> > Although both are contributing to performance improvement, the major
> > improvement is coming from CPU not going to idle state.
> >
> > Thanks,
> > Ekansh
> >
> >>> Regarding your concerns about power consumption, while in-driver polling
> >>> eliminates CPU wakeup and scheduling, it does increase power consumption.
> >>> However, the performance gains seem to outweigh this increase.
> >>>
> >>> Do you think the poll implementation that you suggested above could provide similar
> >>> improvements?
> >> No, I agree here. I was more concentrated on userspace polling rather
> >> than hw polling.
> >>
>


-- 
With best wishes
Dmitry

