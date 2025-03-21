Return-Path: <linux-kernel+bounces-571389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E6AA6BC8F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAD0A1894D56
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46E313B284;
	Fri, 21 Mar 2025 14:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z//dnnHj"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD3D78F29
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 14:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742566064; cv=none; b=jL22E5sXWhHFzsRXOGI1PqCJDx77GiQu/WRgZR2dfyC0ie3ZgbGH/tOi11f9SZ5EHakzhRDY82DzH+uY247hQL191ZT4UjXOvL9WNpSrj/Ovq4hhGUq4XO7soQpd3tVdUDcQwH4LwVHxs5brPUINgcW2fbtI8zj4BzDBcePzrFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742566064; c=relaxed/simple;
	bh=VQ6uT463iY5nWfGzJJw8UhAvf7TtU5jaMLmXMDvVQvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMMb98MkddBBU1RABd6ap9g5oR1e/ha0id1gVMOf7O/YIvaG8tkDq/2lTt/jFVbDp9wKoUB9MBDU5V91ry6PT/9jB4lAhtbbPUgV3+K3QvtKHn6eSaBp5m1zV8m8E2X7IqF6mnLPItTLdFl3UwH+lRikrlIjvlmTnQGJt5/KqZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z//dnnHj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LATBLw000776
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 14:07:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=6Lj3Z0nr75RSpAKjWGnP9fZL
	3PNA1cnRFr4d9rHGNsk=; b=Z//dnnHjV1USlmiQGf37yOyUhg4DIQvaFXtWQLtN
	cE4i/0Pb+XDOU34kh0XgAUjpTq0GIJWtaWay1mOMl/ylIa68msrs31se6HztnLPg
	qlcm1TxEMgth9pWvv54Sq4WpVwDB3LN5lS0zgIBpWNxR5JMZf3aB77JGErg4331z
	3Bc+OXn5U75ajxjSiiPcsCamTNbguOU2DVrFuLdNaqMmHljWoFAaF3EOzG2g8z3m
	4nv9AZED2dGPI9Syh6XvOom+HXqERexyuSp4HXtc5ShHx091J1B/LYlsNFgghlnd
	ZeUvRMVhqXpF+7aBnXlvQ82+7o5g3ztbC0C7H/UPinNENw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45h4u9rwc5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 14:07:41 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4769273691dso38435821cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 07:07:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742566060; x=1743170860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Lj3Z0nr75RSpAKjWGnP9fZL3PNA1cnRFr4d9rHGNsk=;
        b=LyvkuOVy3egXmEGmj7/h/ED7qPSihKr+3PzE0PWOcH99dXynSpES2al1tbgFSy1dhR
         z8IIifPhefddsnYYjDmGooM8eq+JE1bETqXOvT4X6ACD028v88fMa7T1XtPZyj1AXOMC
         9zz/gZhGfwnYvuD99JSN9iLeUNwD+SOWrkVIJtutfNHdwDiPW0Fq3TL9+wfCuc/HGcmm
         whCfP3dfnVbvU/Wuq4OYDEEqfS10A5Z9PD/Lc4qh0qpDbdFHUQjVYAAcyJfWmZ4aOGNY
         kiiLT/a3BxSpCXnZms1goLF/diDJO9O93x05WrYpJAhoLda/oGFTJFaJfFqkNKpl5GQ2
         069g==
X-Forwarded-Encrypted: i=1; AJvYcCV2udDcdg2mbyVMWEgFPXX6jfk65a5jfMQ3m2fcKI3mljq9ZzZCZGe7rMHfwKJ4+7w4e3j2CglI/ePLuwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSLKIhmj6xGHI6zcQ4pa+iOmfy9Z8iwj7ySdiCH8TXdc8mZByq
	LRL+j2dA9pICtU/218ksfVSWlZakGeEyhJERaNbi2Xk8a/r87SmrMnHdW8BKZeuVjly/SXUHG1V
	m8IzfgSrIfqGl1k5265cSIvnTPJvTITHmCz3t/B8TucHav8TvTeszzxnNY3WyYDw=
X-Gm-Gg: ASbGnctH2FlSd6IU78avfJXpLIgilEErNZ5EOivbBoUqiL2aqZNvlNqi0RWyhhiqs3a
	VdhzvP8aBfmexiAUxDAoKaYRmlI+NkKnGIIcg5WrcDTOzkotTxE8ipmc5OonSzbAq6gdOMUwV0W
	g81xFlVW0i+0dSwtHO6sOJrGWyPnLG4jIbG8MSFbLHq/RdE+JBnfzErGyuNmrglPcz7pbRDCMdo
	h4leml8f+7VzRPgLN0aiG0qzk0zByE5bVNC7tQFxSKAxhz4vHGKWUMVZLewUjWfgh4ejtI/2n0F
	RB8Xw68lFPlkgQ7yLeOlsckkmFbwpndKEaM/YTXT+L0NkhLPz1WxShwg8pEk0HlThX02/cMZmzF
	l/FY=
X-Received: by 2002:a05:620a:4051:b0:7c5:9a4f:adf0 with SMTP id af79cd13be357-7c5ba1846e8mr427731885a.33.1742566060335;
        Fri, 21 Mar 2025 07:07:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEN2Hi2Iq/wisLHL4FDbRqBoRtFKfhIdoGegXlkIOLj6uMrHc7E55BfjIOutxbvmBBa/wCXtQ==
X-Received: by 2002:a05:620a:4051:b0:7c5:9a4f:adf0 with SMTP id af79cd13be357-7c5ba1846e8mr427724885a.33.1742566059734;
        Fri, 21 Mar 2025 07:07:39 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad647b8dbsm188937e87.61.2025.03.21.07.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:07:39 -0700 (PDT)
Date: Fri, 21 Mar 2025 16:07:37 +0200
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
Message-ID: <rjfccsym3sziidac5l4ecxsjy3rdulbf5ewhfksdqp35oxcimi@brvgpgme5wpf>
References: <20250320091446.3647918-1-quic_lxu5@quicinc.com>
 <20250320091446.3647918-3-quic_lxu5@quicinc.com>
 <30bba296-8e6f-41ee-880e-2d5ecc8fe5a4@linaro.org>
 <qhriqbm6fcy5vcclfounaaepxcvnck2lb7k2gcpbtrojqzehua@khv5lwdgbysc>
 <9962c517-5c0e-4d46-ac0c-2a7bab550156@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9962c517-5c0e-4d46-ac0c-2a7bab550156@linaro.org>
X-Proofpoint-ORIG-GUID: XQVREzEMglbD_hk8faySmOY2ABcZAmj1
X-Authority-Analysis: v=2.4 cv=FYE3xI+6 c=1 sm=1 tr=0 ts=67dd72ad cx=c_pps a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=d_F73D8V8anS-nGMN7cA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: XQVREzEMglbD_hk8faySmOY2ABcZAmj1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_05,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 impostorscore=0 mlxlogscore=934 mlxscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 spamscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503210103

On Fri, Mar 21, 2025 at 12:23:15PM +0000, Srinivas Kandagatla wrote:
> 
> 
> On 20/03/2025 18:43, Dmitry Baryshkov wrote:
> > On Thu, Mar 20, 2025 at 05:11:20PM +0000, Srinivas Kandagatla wrote:
> > > 
> > > 
> > > On 20/03/2025 09:14, Ling Xu wrote:
> > > > The fastrpc driver has support for 5 types of remoteprocs. There are
> > > > some products which support GPDSP remoteprocs. Add changes to support
> > > > GPDSP remoteprocs.
> > > > 
> > > > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > > > Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
> > > > ---
> > > >    drivers/misc/fastrpc.c | 10 ++++++++--
> > > >    1 file changed, 8 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> > > > index 7b7a22c91fe4..80aa554b3042 100644
> > > > --- a/drivers/misc/fastrpc.c
> > > > +++ b/drivers/misc/fastrpc.c
> > > > @@ -28,7 +28,9 @@
> > > >    #define SDSP_DOMAIN_ID (2)
> > > >    #define CDSP_DOMAIN_ID (3)
> > > >    #define CDSP1_DOMAIN_ID (4)
> > > > -#define FASTRPC_DEV_MAX		5 /* adsp, mdsp, slpi, cdsp, cdsp1 */
> > > > +#define GDSP0_DOMAIN_ID (5)
> > > > +#define GDSP1_DOMAIN_ID (6)
> > > 
> > > We have already made the driver look silly here, Lets not add domain ids for
> > > each instance, which is not a scalable.
> > > 
> > > Domain ids are strictly for a domain not each instance.
> > 
> > Then CDSP1 should also be gone, correct?
> Its already gone as part of the patch that I shared in this discussion.
> 
> I will send a proper patch to list once Ling/Ekansh has agree with it.

I see. For some reason mobile gmail decided that your patch is a quoted
message and ignored it.

-- 
With best wishes
Dmitry

