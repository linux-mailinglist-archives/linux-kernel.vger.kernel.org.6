Return-Path: <linux-kernel+bounces-570183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 248D0A6AD36
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E0BE18865AB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB951EC006;
	Thu, 20 Mar 2025 18:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZXuv9jgV"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD1D1EDA2F
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496220; cv=none; b=RIz528fGihBwphLIoWbprxJVuV9JSmcMPl+h6uXY+jQhZlEYZM3x2qU4+JlNtBFz52b9tUwpaBdkQvWGA14HksORQdEiVuBUkUQMJQ+bsLoFWww8KYwL5irne0KtkFsZ3L+dB3ZjGYWM170eUGEEFGpKc/ik+TBn2br4AF0oKCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496220; c=relaxed/simple;
	bh=dEY62deIYUJSirCrYOMEElVt/Ji4rW7/Q6uln6aIjzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJzKsaSh5VDE8IzcqcnRsoGCJxoxI26YKfPpdKK+a9OvK/bjRVg5qgAH3b7kmUjR34ncxKk5QKQbws/bD6i2fnkkLskkG5ojZxyBWklX9LgzSlEPCaW0ovkq4a3OAJ03G9PcZiy0QtVl73gYpOvfZ5woPk+LdG0VOsNfvxTpTF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZXuv9jgV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52KESAiO010963
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:43:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=+ONx5//4UtMuIj9b1Txh1pQb
	rcyKh3E5jAL4BLqN58w=; b=ZXuv9jgVgoDsC5ZU/SvLq5mJ/aS08aIE7x3Zn3Pw
	xIeU5FTc0FymB9NBjJcdnNJAhwIiIZJt0EfvfiR6YVSiNytJcIXwaPZ8znu8e4No
	AwmlBpvDTxpfDDWUeiWRyDGBoUNbzPpOl1WtzwsUqrmimu5pWfzCGChzd4g7qa91
	ZJ2rADlL4xtDjl9ciSD8zmQ/1EShl8BkykG/o4iqyjED8Dx85/CeyJ2rHt5wQaFf
	iNDe6gQSGx+7xVIg6IKxlvIRHmAqyd42VhsxeN2i7bI9w2HPhI17Dv/kObkstrok
	uWBzHerSNNNKMkFzSbo7lqT0kWnr0VraKU92q+fOfY/Odw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45fd1dqcmr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:43:37 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c54e8ad9b3so351390885a.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:43:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742496216; x=1743101016;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ONx5//4UtMuIj9b1Txh1pQbrcyKh3E5jAL4BLqN58w=;
        b=U9OZgzEHjfH93ILZPmJ/Y9h6gz5GFULFvE5GFdoGSir/FijvmfRkt/xfqYTzB9nWlg
         TqMvM3cemFLt3ZnWPgVR5A27VKduJZ/a761mEufGJBM1048enKln/TSs8M9IZbGpIe+i
         lP2AROrcD5nZG3/Oh9Wq+HZSaJiq2A/23Bs1SkfArgGQG60hWwNn7yTP08moIdqHdQXy
         tzVlBQTT8gsFtKCsitp+6ejs1yy5LVD3W4VYWQof+ZsCqMXF/vUUbZPda1aZGYxkIzfh
         GvM93GGASVvWvGGF4Yvvuc6C88VEhSVoVBkzDrmC6Uuf7GCmgBHGwRqkhFbNSptsD9HV
         o5Gg==
X-Forwarded-Encrypted: i=1; AJvYcCWMZWMVpCdE13bQFGLh5v9jYMytD63rjLq7OhFboLafuz+PeYkTvfNrVnON0BkiLMaxMKhZQ38qCj3AhsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNdDgHNywrwzkdLS4gtyluYftO6cbPSQz/XreyHXTVNhN6hIPw
	EU5G9SnFUP8ENL44quaOULVqnqwuITVrBsnon0EopJtp/8m+dfCzVcDBZ/3Zee8gCLQ6zKOhgDc
	2iqijtTi2TsD8N7gkdom5nPPndTgsDh/bMJpEgM7FW3WsRYZy3z2i3AhxUaD5LuM=
X-Gm-Gg: ASbGnct6R+G7bMygvso4Zy9hiGHA89Q0PLKIhHRgfuC7HVosvZ8Qdh6/huGMUUKNpD6
	TiHF6ccu/lh7A3wX0MLEKEdyvfbozOkr9d8X8P6ahpQpcuMapyaA38c8fhKrMRA2DdDl/0s3ZgZ
	GfAyEJHl2Fe08Spnvl3ys6t++8qZhF3smhq8S9qmNm8ySz492MCWJuXD4IgtPGx2hxG1VPgGeLo
	JCb9tCtHHR83LHheEel/g8SclqAOsYSZewFQsL3NOY9kTeulZCCmr5WXXJIs08naXFA5KyHFyXO
	ns9vPmYdVDQfFfxwYLw3fJiSTPa7nw+yEZiQem9eIh01Iq+b92PpTB0P5+t/j2HnTQw8ekJ9+u6
	KSFc=
X-Received: by 2002:a05:620a:2846:b0:7c5:93ad:d2d4 with SMTP id af79cd13be357-7c5b0505fb7mr790743985a.9.1742496216644;
        Thu, 20 Mar 2025 11:43:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIOpxyiAffu/h19LyVC1go0TlaRx2On3Hti1oWXPswumXindR9aN6vgdysZcfnA+vAuG/pvQ==
X-Received: by 2002:a05:620a:2846:b0:7c5:93ad:d2d4 with SMTP id af79cd13be357-7c5b0505fb7mr790739385a.9.1742496216221;
        Thu, 20 Mar 2025 11:43:36 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad63eedf2sm20268e87.0.2025.03.20.11.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:43:34 -0700 (PDT)
Date: Thu, 20 Mar 2025 20:43:31 +0200
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
Message-ID: <qhriqbm6fcy5vcclfounaaepxcvnck2lb7k2gcpbtrojqzehua@khv5lwdgbysc>
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
X-Proofpoint-ORIG-GUID: a9nyTB1R3EKD9Rdw5jDfdoJUzGuXsc6r
X-Proofpoint-GUID: a9nyTB1R3EKD9Rdw5jDfdoJUzGuXsc6r
X-Authority-Analysis: v=2.4 cv=T52MT+KQ c=1 sm=1 tr=0 ts=67dc61d9 cx=c_pps a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=QMmaw6yphwjc_7Rvn6EA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_05,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 mlxscore=0 clxscore=1015
 mlxlogscore=959 lowpriorityscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503200121

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

Then CDSP1 should also be gone, correct?

-- 
With best wishes
Dmitry

