Return-Path: <linux-kernel+bounces-351634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 965AB99140E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 05:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38E69284F87
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 03:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A97200CB;
	Sat,  5 Oct 2024 03:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d/cHg7bb"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE5B1CF96
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 03:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728099051; cv=none; b=MYG67GIDZcv3sGi2QUTfTzKK9rajwYB+N+V4oncnZuhSBCb6WSYMH4bWMaOGK46GMF1d1+Opf1PEvh1OCA6dB4EbBAycjy/JrvUep2Z/l1FyhZ4wf1JZ8FuC13SzltN6fr+mMlD6c+B0clw6MP160aDhcYhOR/Ngk19CUdL0AVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728099051; c=relaxed/simple;
	bh=UqK45kuu/dMsWFtJJpEVqEkYgLB7qKO0vAgY1KI6nho=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KycM4NZ41Ir0RBq1fH7vJH0FeD5QPik42ghQv81v7B9ucZ+x8O5UJll9XeegmSGeUj/M1Qir4VpBp20N96OncpcJCb6o9E9iMFFE1lHpiuBq7Kte0NGT+KR+rGt+WzZ/GSslnhDsI3FU7pg/2i+4Xle10X0GPbKhBNIiW8ccaZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d/cHg7bb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4952kJFZ011823
	for <linux-kernel@vger.kernel.org>; Sat, 5 Oct 2024 03:30:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=6s7VCqVP3KnymaMoUGSCQs
	9C3jYSDXVFxgivyLLMZjw=; b=d/cHg7bbxQvuxa1/4SWmtA47kgQGgjZljeB53y
	VpHkOXoz+OsdfFBl75bUljkF1i/W2malT/hdMKegwlJjfQI4rRgS91p6BR2teNOj
	xnkYel7pgSvbmGOFMRv1l4VdyM7uaWx1FP2BzQGgAvpeVNfkFQFqZOaXlS6uKAra
	arFrcp2RjyTr5ebfrLOZ54QgVG3aM/IhGSZs4YyXlCuN56S0zNA9pcgWykeHnuPA
	ACaER/sXFAoRjEogY0uJ4mBmlWmLxRRKHd1ieEBWy59/zWQUVFz9N1s3idK81BV1
	25eN9kbFgSJxxHAozhpxTBj2eA0kYfec27nPvfppesc/cbiQ==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42205kbrbw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 03:30:48 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-2878304b155so3395616fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 20:30:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728099047; x=1728703847;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6s7VCqVP3KnymaMoUGSCQs9C3jYSDXVFxgivyLLMZjw=;
        b=dzFE/PyuXS0dgEtGHiJ14uwdhmydfxo3JOpaJtnujyqCAqRehuwrK/vlDDPWC4Gp9P
         9DnDGNex1E3l1fxLUGeYTmFyoQlZu3ZrJehFmc0wPa03xkg/f0VQ5wMPyg5h1HrFNsqQ
         CS1TZtgsZot273BqReQ7aA//oAH0Sp+bpA6OVWsHMzACAYi19QIiOKnYNT9jNYA5uyqI
         WJmeUWXLU+PssaqGgj+7Ds7ahGBUF1VI/w2EY7xhB+YjN8GCLzXP4NpRhJzyxe3qRYGC
         hjflujivKU2tkGD7gDJ7VY7f1OX4hphdrHhBLYB431Gbs+mJ+dj+TU0KRoYR3BL0bY56
         TNrA==
X-Forwarded-Encrypted: i=1; AJvYcCVu9p2B34MuG3ozjUxSDyB1CWbaKaTqydRbPjjJjnmuFGzU5vm/wDyXWaM6wrKmlkP/dnrW32NlwY+kVzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqAHrkuUqJv65/PWzXXT0sHkIswBq0gs0Zci8a5YlvHFOu5Gkl
	al3hzZX9lP2SoV6dRMYhL99JaYHx6+9UZBfOzSdoXGPPKX0QKwjeS3u5pgtV920fYxTnTTtbx/5
	gqYAL+SLNsgJTBEbhH0wy5Ne6cltvhXIPylVNgUa3yuzTxHRZZrODzoAGVWnh1wM=
X-Received: by 2002:a05:6870:a511:b0:278:1bc5:41e4 with SMTP id 586e51a60fabf-287a41244d6mr3964443fac.23.1728099047583;
        Fri, 04 Oct 2024 20:30:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHH4kO/AvLhdnZfQjPcr9KDMTme31O68MuH5LlfP2F/fNuemSbRLVozmVBg57EwQoqlL0NjuA==
X-Received: by 2002:a05:6870:a511:b0:278:1bc5:41e4 with SMTP id 586e51a60fabf-287a41244d6mr3964431fac.23.1728099047241;
        Fri, 04 Oct 2024 20:30:47 -0700 (PDT)
Received: from [192.168.86.60] (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5e7d72bdbb3sm366390eaf.38.2024.10.04.20.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 20:30:45 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Subject: [PATCH 0/2] arm64: dts: qcom: qcs6490-rb3gen2: Describe LED array
Date: Fri, 04 Oct 2024 20:33:41 -0700
Message-Id: <20241004-rb3gen2-leds-v1-0-437cdbb4f6c0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJWzAGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDAwMT3aIk4/TUPCPdnNSUYl2DRJOUlETLJAvj5DQloJaCotS0zAqwcdG
 xtbUAflKczl4AAAA=
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Konrad Dybcio <quic_kdybcio@quicinc.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=656;
 i=bjorn.andersson@oss.qualcomm.com; h=from:subject:message-id;
 bh=UqK45kuu/dMsWFtJJpEVqEkYgLB7qKO0vAgY1KI6nho=;
 b=owEBgwJ8/ZANAwAIAQsfOT8Nma3FAcsmYgBnALOhGfPtHKHJkMzoh9kqVwPHirI0wzzxaJJVe
 KnA3iFcPlmJAkkEAAEIADMWIQQF3gPMXzXqTwlm1SULHzk/DZmtxQUCZwCzoRUcYW5kZXJzc29u
 QGtlcm5lbC5vcmcACgkQCx85Pw2ZrcUonBAAmVtMQsxrQuVJHb/C2wE/Mbjr3mgo+Z01cNRdJbt
 Si6EUnGLlKZhxflk24Z5Xf+uu5ta7AgXP1qpzlOxfOgRzlp6Fcq5Cb7ZucwdmYebttmC4HNY6zw
 zpgI/sgEfhgKDQTkl2FOr0/q15q/yHrsTvqo4DlMoAbvbeW+KhFOrYr2WSYrofxwEJPNnR4q9ol
 6cCrXCP0IMNmBBJ57rU2zPokCnHeBHpQBfCKsYAa/M+Upr/lfyxGpXSgdxl2sDImycr+1a07KKd
 UmAxPYh893161GMpeeSPCjebfOu/0UmLKsHo9oWBCPcLzF/kkQAFtKd5ena7tK6TtHN7hSY3Hdt
 oGyGdrOZFuxk/Vffg4qw2+w9gS2nWMDEoZtOyilmFFRoZk+vodHFF2foYBn7B19lwIAcUhe/arl
 0XbFhN1Dj43fsi/ooCs0DaCdIObn+Uz1LsamyASnpG0w7kLPJIH27sVkhUT4YdDgdicDuK76dVB
 vAcGF4YI0EMk2Y+WgVUvfniTCMX0N89DcEllII7f2oh7PEJcqVl5qbm6Edp9bmmf3q9mLxrRHAg
 qjxaL99LAww/Eu1K+5s9XtG81xIeijVppEpZ5CyFVMxt3aVg0eZNM4YWIUdZXaT5TPaEdug/9rI
 4kwRMU/T0HSLfynZodcGtOQuzo9wqtGd6WMOr5kK4jFI=
X-Developer-Key: i=bjorn.andersson@oss.qualcomm.com; a=openpgp;
 fpr=05DE03CC5F35EA4F0966D5250B1F393F0D99ADC5
X-Proofpoint-GUID: KRL_uNbCOlzMgDE4K2Z99d9mDlI4finr
X-Proofpoint-ORIG-GUID: KRL_uNbCOlzMgDE4K2Z99d9mDlI4finr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=489 malwarescore=0 spamscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410050024

The rb3gen2 has three green LEDs for status indication, describe them.

Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
---
Konrad Dybcio (2):
      arm64: dts: qcom: pmk8350: Add more SDAM slices
      arm64: dts: qcom: qcs6490-rb3gen2: Configure onboard LEDs

 arch/arm64/boot/dts/qcom/pmk8350.dtsi        | 72 ++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 41 ++++++++++++++++
 2 files changed, 113 insertions(+)
---
base-commit: 58ca61c1a866bfdaa5e19fb19a2416764f847d75
change-id: 20241004-rb3gen2-leds-0a4dda9b83cf

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>


