Return-Path: <linux-kernel+bounces-566949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A16EA67EC5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 22:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E398B4249E7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 21:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4079205E16;
	Tue, 18 Mar 2025 21:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RplT5hpA"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F131DF240
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 21:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742333621; cv=none; b=FBsEWI9FWVhpO0ZyP0wLQScVvuWtpkBRjXKWs2L2gft8Z9BxIIxTU8+hPp2wHLjX45OT8K5Sl/UKkuVGFz4qKNqcR8yG5VvM+njypSmUga0OoGdz9hE5JMQP6Fyhr0A5HbqS4oDMmcAd07M4oQ8hC4qbvKiEM3cyzwMJXLWI81U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742333621; c=relaxed/simple;
	bh=sqeXeuHnI3RYiSCIQdMV5BB625+N1u5xK1q7i3iLlrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G03xD5u6bP2l2E2kDYzi2XKdbkgmpndruGmyN/kAwVWO0qWVp3KnGXtWhe57s8E8DpejNlk8Z9BOXYO6R76Q40+fflZMISudixFjwD6otbD2XYGqoQ7Bz3e6+LNwyi5ru0XHnxREnoNQrUDlqLGe4oSOfk3uTKQ2N3DiGtpYJTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RplT5hpA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52IIatpi027513
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 21:33:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=AUCKkaO6TDmVZC2pTS2bRWbz
	Hyx0XdlYmxeuzuTp2IU=; b=RplT5hpArVosKjvz8ezf/j2kA8MMa0cEy20OEhuK
	azMa1rpDYQh149Bb5odx6Qx7Z97d6vxDXMAAA1+21vnfaLp7LUOjSsD9mw/wCLPW
	zRMdszsra/TaNN765TYR+3SNeI/mB/UHBFkxdlfZXMV2Cf5/6OwQ1h7w/EkVxziT
	tVEaGXRIhzGITZxVTMGtjYcs/pbObdZe5LWH2NbN8ujk9ROnDDYB28Qir1zEkoM2
	z6O80UaAnw/TdhUi6o0G6tgHUyTRx3u6GoTPOIjpMtAdfHBL/4zJvdD1kQPU0anY
	N/7740a/0Ntc2GGDJXwZzBrvNT+g9WlysKmu6GjJBX8fVA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45exwtkbe1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 21:33:39 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c54767e507so323443885a.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:33:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742333618; x=1742938418;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AUCKkaO6TDmVZC2pTS2bRWbzHyx0XdlYmxeuzuTp2IU=;
        b=b/i8Ph7xbQbMPrx0njtYikGylZYzQrJ3kzeCkidpk2SpySAlgOOolN2tJCibMyVHKD
         YFM7/Lg+f9HOzvxYT0+PPq7X11WrzAjDBzZ0/2yoIC+qjSxeGHzGj3S8yqlzlgRXXH5X
         tkrs6W1iJY9nHakv0fsljKUL7Iled5sF7tbpQA7ffTJZ7gwWso/w/SFyeieKanglDqSn
         z6GJtLpb88Lqca4+XMoiXKyMZadQGm2KlBT6Vyqhgy7h5sS4GrAQFMsDv9z7nkQ/9/6V
         eRfUPklDWyRYqIDy8SeY1D4fYCq+gy7pIP2UAjy+P26sHdFjBo04ba5GVWtsm+mzT+/g
         uHSw==
X-Forwarded-Encrypted: i=1; AJvYcCVMsOp2zcxTTv6s5mgrzKGbhKqCr4S/aJ6nzWvgrd6jpdUrABSW9gBRA61bNXhUNQzZwhmM7c0R2kkENeI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+u9R+zzRkCi4vp/17LbBxacwvSE1WjnIZm0pPXFVmqWzw+M7m
	cD8wWmbA3PWBVOCuzFBMpJTUsKVheNGN8gcF1qrK8aenlNlIzVZoisIp6t/81qq3eLOiBF+ixXD
	yWBDfqfq9Waj5ToJCLChEa1zAit9awTyckgOI+JGvIbkZXsH7v4MxM6qYG+p1GDE=
X-Gm-Gg: ASbGnctTJ2lOmtizA67t8wwNGr/rk7Y053jqJ5mAHuaM54QdjgkLam+CRFxKWKd/MRK
	/9NruIK/myN9Dg3i2bwCCZuti1ZRDBWYX5VMiiTwqVwYnHvXmDOPbK9thXg5hXPQ/CFjy33+jVk
	ilvWD3C/2skD4nbObVVPaf3aEolCury5gQhLKWNz3WyeOYkvr8RQbgPV8KrqtJg0bTMe9YB3rRT
	ixHZsjYZWqWCFRPiUP6+pIjLqjgnSxm1VmJHJm7hotdjk/uXdqcfDqQ/4Z8jlPiIfMgGyBIEw7w
	4iCmnn5xYaoa3tUibpHH0pOT7jnSmvyMIY21nBgldnWFVuX1yK6lSnnrIBgbbCMVmyx2bo96oBt
	VXyI=
X-Received: by 2002:a05:620a:4085:b0:7c5:5909:18d8 with SMTP id af79cd13be357-7c5a838f559mr31446685a.14.1742333617947;
        Tue, 18 Mar 2025 14:33:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbNLU06o7v9da0xIANAr1cICtJz+PFbBxgZQ+APOPFsWUarKUtHkA+4idb15eiF4e+aXcIyw==
X-Received: by 2002:a05:620a:4085:b0:7c5:5909:18d8 with SMTP id af79cd13be357-7c5a838f559mr31443785a.14.1742333617654;
        Tue, 18 Mar 2025 14:33:37 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f1dc0dfsm20865471fa.105.2025.03.18.14.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 14:33:36 -0700 (PDT)
Date: Tue, 18 Mar 2025 23:33:35 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Marc Gonzalez <mgonzalez@freebox.fr>,
        Dmitry Baryshkov <lumag@kernel.org>, Arnaud Vrac <avrac@freebox.fr>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 8/8] arm64: dts: qcom: msm8998-yoshino: Add QUSB2PHY VDD
 supply
Message-ID: <4xozday3kuwlp76hqs5ohabmhucb5v5as5mni7wrp25nzhhqqt@3vdii2qnyicp>
References: <20250318-topic-more_dt_bindings_fixes-v1-0-cb36882ea9cc@oss.qualcomm.com>
 <20250318-topic-more_dt_bindings_fixes-v1-8-cb36882ea9cc@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-topic-more_dt_bindings_fixes-v1-8-cb36882ea9cc@oss.qualcomm.com>
X-Proofpoint-GUID: S9Vc3F2CE1f2YG1nzfw5o6UiVhgUkYkt
X-Proofpoint-ORIG-GUID: S9Vc3F2CE1f2YG1nzfw5o6UiVhgUkYkt
X-Authority-Analysis: v=2.4 cv=UoJjN/wB c=1 sm=1 tr=0 ts=67d9e6b3 cx=c_pps a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=czvDKQ4P4fPyK2hnz74A:9 a=CjuIK1q_8ugA:10 a=PkAOt9_mmfBkvtOLxIEI:22
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_10,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=709
 phishscore=0 adultscore=0 clxscore=1015 spamscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503180156

On Tue, Mar 18, 2025 at 07:35:21PM +0100, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Set the supply as required by bindings, to silence the warning:
> 
> 'vdd-supply' is a required property
> 
> The value is inferred from MTP schematics, but it shouldn't change
> between boards due to specific electrical characteristics.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry

