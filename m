Return-Path: <linux-kernel+bounces-571388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FCDA6BC8B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D81583B8D33
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE285139CE3;
	Fri, 21 Mar 2025 14:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y5FFyDMu"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E3778F3E
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 14:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742566039; cv=none; b=fRwAyMW2tdatYdnBukF6Vmx3Uwtiu2mXEZnCW1svlDrV+rkixq6d8h92cOqQSEP1BPRYNcBWPLsyD+x7DnhKRgtqcLll7Q90QI47XLKIFnGzANiZd3Ya4BCQKUACexkat1mzNv+JwZH9b6UxPcdS213wX3FRWAZCvqtsBTlfztk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742566039; c=relaxed/simple;
	bh=e/XWsyI6BYdyPdl0XA1XeIvspxRAYhIZaXUiTyMFzjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uEMBlyDQ6b3RBmjkSapZNpNTVWXrbOe8iNBsEEQuEZiV0j77J9kKa/p4OuO4lFh6r0C6R5xWVhpAGQTU+liHlN3q4z7C/Igy/FJORz6Gt5G+XNSwUSV6d6EgfDtKE5VAAxSD4RqVwL5MEQru1YoRV4Y3+L+9YBZKiK+Ity3ENHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y5FFyDMu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LAThlt003188
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 14:07:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=n4dOWXKC6mPXFjDpSYZ/WJvo
	CSfdzk/j2GPOhCYKVDY=; b=Y5FFyDMuplv32vbJvmFlofNE24HcYZWtCbdB9PuP
	bY5dwKhHIUY/GcnqQhj6bH7Dvl2SngTIDpv1h4VbinxQDuuBIT/Jmg6TiP75ozfz
	qmjQSCRr/tCYSKEazwyICdKwwhOU2nG8riMoCPOswFdnY4ZWXNX1DcziyankEY5K
	3NgNK/iK6600o+5oA5IeVMk5j+HLCKyisUQCezbAiOBl9dyj43MHJ3UF05jhn34k
	NrPsDQxH8JQTiLIRZ6RmEKYg8snGFsfJ3l9ZL/+W0qWuu9XVlru/HSERl5VGNHDp
	0zE7o+smmzQQR8SobtgH610Cn1q3vO7Zv5TNgssHrgtqrQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45h4p10yh4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 14:07:14 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c0a3ff7e81so365591985a.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 07:07:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742566031; x=1743170831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4dOWXKC6mPXFjDpSYZ/WJvoCSfdzk/j2GPOhCYKVDY=;
        b=VNNpJpubKBCPYJbtgWceKwQ2Fob4iwdcDHdY5t8R18Wzsn5mqVJqzeYtCkaJtFYve8
         IVsTzyBWCqI2V4tl+tLNT5bbDDrM+52G4CwLGYQAX7+lgPwDgPLyb1BV46NZLoTQwxTW
         sLN5BJzH0UU3ArvisfPd0DoQ+aF5917uHtTLe8ydSkG0r3pAoJLkWX8nZGFzw76YtcuF
         9MnsiQaboSowONabeeTSGkgBHqezRIOCNeI0tEGIIEDMv381ASw7LMb8yV/hkkG+5wVE
         9MTTOz8C/mxAbMjOy0/XMOVKILUNJD0IfdO1UM0QkadscJwvbkQLojGzYNERpxtF0abC
         sFBA==
X-Forwarded-Encrypted: i=1; AJvYcCU5FwqmJz0QojbBGh3580yTKRioJAhyDAsA4vInzKBJ+yNCQU3w1VSyF0GdJGzX6tfit5ofoPLT53LCTNo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGRegIbmHk1DoOfZ0PQyY74BQZvc1AKB/NqQNwmb+1ysQLzvAV
	ntIDNI1P9YeDin1WMIzO194UBkIQNeauiSaJdrwgWDwZOFWZGc+5teX6CpOJRvoXGkOlSDkym1Q
	UyD+B9kQLHePJ2PujNGJxNEDTD/7+ai60+2d0KOEwyN7gY/ZEGBB54Ec3JzaGImI=
X-Gm-Gg: ASbGncsUSJOLgw4l6X/YAndrV3RydH+spe3EvkvCwo8WCOEMs7BJ4SniRB/MRKbv0br
	hTNtdQ3KCzfQhG3VRaIZNJZ5zxv1B8m4L5TgeQKPEepMpnFwyyNCFOkWZtqraxjz0xto/vaqF/O
	zJ1Dy9/sLnwKrTev87lpVKB6b6QMG1u68sbzTXkp6WfsxYI3hsctGVPuafLu1HG7FdNkArLmr/3
	fKBCjgClVTpJpB8FsdMIHR3oZmzpFvwb+8vLJK05zch/+vPlzJWanVEbSvACsWsRr9y9Ruu7s2u
	Wfc/bkTlqyW+/pxCOhQlKkwvA+p7QAc100DWkqhiM2GHUYENxPRz9Gg9OvJ5c85LU5ygio7DZDf
	DuEI=
X-Received: by 2002:a05:620a:40c7:b0:7c5:57e6:ee87 with SMTP id af79cd13be357-7c5ba1e41abmr470565385a.41.1742566030517;
        Fri, 21 Mar 2025 07:07:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCTJNsCfV0EF8Epu2f1YteJvCUL+F4ENn0D4b3RmEfnwrm5SjF78ayOE8NAWz/4oqCHm/szg==
X-Received: by 2002:a05:620a:40c7:b0:7c5:57e6:ee87 with SMTP id af79cd13be357-7c5ba1e41abmr470561485a.41.1742566030053;
        Fri, 21 Mar 2025 07:07:10 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad64fbbcesm194858e87.155.2025.03.21.07.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:07:09 -0700 (PDT)
Date: Fri, 21 Mar 2025 16:07:06 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Ling Xu <quic_lxu5@quicinc.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, amahesh@qti.qualcomm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, quic_kuiw@quicinc.com,
        quic_ekangupt@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 2/3] misc: fastrpc: add support for gpdsp remoteproc
Message-ID: <5r72xrv5rtw6bemh5onygkroyasroviijlta4hvwgm5c5hzvax@3icylchlufu3>
References: <20250320091446.3647918-1-quic_lxu5@quicinc.com>
 <20250320091446.3647918-3-quic_lxu5@quicinc.com>
 <30bba296-8e6f-41ee-880e-2d5ecc8fe5a4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30bba296-8e6f-41ee-880e-2d5ecc8fe5a4@linaro.org>
X-Proofpoint-GUID: 5MxvRHVeHJg_M97Ztm4_wICbbZfXIEH9
X-Proofpoint-ORIG-GUID: 5MxvRHVeHJg_M97Ztm4_wICbbZfXIEH9
X-Authority-Analysis: v=2.4 cv=NZjm13D4 c=1 sm=1 tr=0 ts=67dd7292 cx=c_pps a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8 a=5a3lCsJK5BcCjL_2EzoA:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_05,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503210103

On Thu, Mar 20, 2025 at 05:11:20PM +0000, Srinivas Kandagatla wrote:
> 
> 
> On 20/03/2025 09:14, Ling Xu wrote:
> > The fastrpc driver has support for 5 types of remoteprocs. There are
> > some products which support GPDSP remoteprocs. Add changes to support
> > GPDSP remoteprocs.
> > 
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
> > ---
> >   drivers/misc/fastrpc.c | 10 ++++++++--
> >   1 file changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> > index 7b7a22c91fe4..80aa554b3042 100644
> > --- a/drivers/misc/fastrpc.c
> > +++ b/drivers/misc/fastrpc.c
> > @@ -28,7 +28,9 @@
> >   #define SDSP_DOMAIN_ID (2)
> >   #define CDSP_DOMAIN_ID (3)
> >   #define CDSP1_DOMAIN_ID (4)
> > -#define FASTRPC_DEV_MAX		5 /* adsp, mdsp, slpi, cdsp, cdsp1 */
> > +#define GDSP0_DOMAIN_ID (5)
> > +#define GDSP1_DOMAIN_ID (6)
> 
> We have already made the driver look silly here, Lets not add domain ids for
> each instance, which is not a scalable.
> 
> Domain ids are strictly for a domain not each instance.
> 
> 
> > +#define FASTRPC_DEV_MAX		7 /* adsp, mdsp, slpi, cdsp, cdsp1, gdsp0, gdsp1 */
> >   #define FASTRPC_MAX_SESSIONS	14
> >   #define FASTRPC_MAX_VMIDS	16
> >   #define FASTRPC_ALIGN		128
> > @@ -107,7 +109,9 @@
> >   #define miscdev_to_fdevice(d) container_of(d, struct fastrpc_device, miscdev)
> >   static const char *domains[FASTRPC_DEV_MAX] = { "adsp", "mdsp",
> > -						"sdsp", "cdsp", "cdsp1" };
> > +						"sdsp", "cdsp",
> > +						"cdsp1", "gdsp0",
> > +						"gdsp1" };
> >   struct fastrpc_phy_page {
> >   	u64 addr;		/* physical address */
> >   	u64 size;		/* size of contiguous region */
> > @@ -2338,6 +2342,8 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
> >   		break;
> >   	case CDSP_DOMAIN_ID:
> >   	case CDSP1_DOMAIN_ID:
> > +	case GDSP0_DOMAIN_ID:
> > +	case GDSP1_DOMAIN_ID:
> >   		data->unsigned_support = true;
> >   		/* Create both device nodes so that we can allow both Signed and Unsigned PD */
> >   		err = fastrpc_device_register(rdev, data, true, domains[domain_id]);
> 
> 
> Can you try this patch: only compile tested.
> 
> ---------------------------------->cut<---------------------------------------
> From 3f8607557162e16673b26fa253d11cafdc4444cf Mon Sep 17 00:00:00 2001
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Date: Thu, 20 Mar 2025 17:07:05 +0000
> Subject: [PATCH] misc: fastrpc: cleanup the domain names
> 
> Currently the domain ids are added for each instance of domain, this is
> totally not scalable approch.
> 
> Clean this mess and create domain ids for only domains not its
> instances.
> This patch also moves the domain ids to uapi header as this is required
> for FASTRPC_IOCTL_GET_DSP_INFO ioctl.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/misc/fastrpc.c      | 45 ++++++++++++++++++++-----------------
>  include/uapi/misc/fastrpc.h |  7 ++++++
>  2 files changed, 32 insertions(+), 20 deletions(-)
> 


> diff --git a/include/uapi/misc/fastrpc.h b/include/uapi/misc/fastrpc.h
> index f33d914d8f46..89516abd258f 100644
> --- a/include/uapi/misc/fastrpc.h
> +++ b/include/uapi/misc/fastrpc.h
> @@ -133,6 +133,13 @@ struct fastrpc_mem_unmap {
>  	__s32 reserved[5];
>  };
> 
> +#define ADSP_DOMAIN_ID (0)
> +#define MDSP_DOMAIN_ID (1)
> +#define SDSP_DOMAIN_ID (2)
> +#define CDSP_DOMAIN_ID (3)
> +#define GDSP_DOMAIN_ID (4)

Why are you adding these to uAPI? How are they going to be used by the
userspace?

> +
> +#define FASTRPC_DOMAIN_MAX	4
>  struct fastrpc_ioctl_capability {
>  	__u32 domain;
>  	__u32 attribute_id;
> -- 
> 2.25.1
> 
> 
> ---------------------------------->cut<---------------------------------------

-- 
With best wishes
Dmitry

