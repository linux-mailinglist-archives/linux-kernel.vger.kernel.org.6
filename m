Return-Path: <linux-kernel+bounces-528463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 645C2A417F1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90FA63AC8A8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A38524337C;
	Mon, 24 Feb 2025 08:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fjWEf4zj"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445D6241CA6
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 08:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740387377; cv=none; b=Ju7NGmBl7uKC/4ZFhzcVOTOvwROuyMsbj9RPHbXQVAESeP5qQaq3sLITEzb+L/3Oz1ANSYo8WzFLbvtWJcI+9QjQWEsgz78Tzs3EZz+zhxy3kLP1e1CNXp8sIbPhTmEwlluThrr84I26m1zZFz50FLG1KXSSETESEbmizg7I7/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740387377; c=relaxed/simple;
	bh=ycAwiMbxF3n0lZ9z26ElUzrRQcR5Owt3AdSg+tGrPXY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H6Pw9blCxIDBrckiasuYqSdR6rl5oli4QKOIzmgEjMO4oyMpayTdwwYRxQVFcLH4wj8V1/0gSK2FALWsSQf+n4KsfMuj6gPQhqwPikMVz26m8+K70yWVlRu8Myy0WmozmniXotBeQgHScatypLJZrD101KHe+2JF1vb3yxv3Kcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fjWEf4zj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O0SEk3021236
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 08:56:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=TeXXCbYN/NL6nm0TIhtB7ORF7skKDF6mo30
	jLzYZfoM=; b=fjWEf4zjHwzpUQY7T33v9fYwr3sykKHfc682wdJSe/YCv1v1WTN
	/lDeRdM5zE6HfRX7eXc0B/B6EtJDLYZ7LgeU8HchSfQO/Bo0tEI5IGprX2UdpglQ
	xMob63sLxVsEEJ0lrktmesHDPH8JuZ15XadXLJnTHEUpjuiK5p6ZJjY9ZfLfg10J
	48v1KKDWw0X7tUj9tI33LKNRCpcp2ifPl5wWavGDQZFI4XRhxVrzf6+wYan9zPQ9
	+rvlGlsWwEq6OSyHj0sOw7mg2JGUU2zHlDRKYN4R5AfqS0jqGiZ6swEGyz/yINqm
	Dhmxz05HyYx7LkVApfyKQ0qSyrXDLLh/pmg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44y5wgmaje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 08:56:14 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-220d6c10a17so94666295ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 00:56:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740387373; x=1740992173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TeXXCbYN/NL6nm0TIhtB7ORF7skKDF6mo30jLzYZfoM=;
        b=ejtgSFc8qGlcsPyD7eEsp9D+SmzFgk3zeh2Y8fzi5zVLCr3ia4JfB7UyQzOf1SujMN
         3cvlkAdjqpOeVtEdptJD5iqFTV+UHWuyXkuM8B70chQkwL3+aIeoMvseWW03s91GAmPN
         HKN9wCPZDZrpRKAFmfU5tmpy0WdlY8o+bBj1P+ob0MZgcayADvSoKy/V7Lss48NMWqlD
         d7wlKEhYfkghmA5GnoHGHkrOslhjNOCRUbaMr7GbOUtOP+8OaOZmWEPMSQK3dIRRWpff
         bd2uCloy+O4KwWzz8+1s0qkj3gy7jc+Ar1R1e0HF+OnczefmWD8NE+nFWvrB5ep1+PbI
         +Q0w==
X-Forwarded-Encrypted: i=1; AJvYcCU/QXBGPnsANShXj+BU1zyG2lNwX1tRjwSxQOYXKGFXIyGAIwl3vHYmexim3vULpQDGHRE+rd92hPE/xVA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywai+hBYESUemz3OtdLkcIePtYakWmTvw6gHwZTswPMjGX3Gi5X
	WDebVDU19vKBwZC51YzKTUQf0NGPeSXDwevHH0mFh8H5leWshwX4RHY38cyFqMbogRM5xQWcqOu
	jQk1j5oz/+rvMXQQrblReWat34V76DIDgJVVayU1odaFu3rnFT81mdsXHrVoRPUs=
X-Gm-Gg: ASbGnctHbehlVUG6h/eN9eZw/chq2/g2HdJxz8imeryuCmHdioTZPMZGy9xp4Z5w3xk
	PKyJvnOhVrrKa+2I4eY8m9MESQt6RzzCbGuoDgwDPvAMrhp01316guxom+onkmVFN0mPyPmEMqo
	uDkpFRw5HhsnElYpbWeh8tgPLz1OlhPmyvChu/t4EBoxh/c3nUblpLN0zgzg4NeYsxUuMphQGP2
	Xva+anVHTckDfJIc987hQq6OCmN3ok/swlJGHmaqfLvUHwBG3A7+3XKDoHhAVP+oufJeUeUtTQJ
	vc0it9XmbVUHHB2/U7+nkZyOF8nMutGzUYuhvqmMjdvi
X-Received: by 2002:a05:6a21:99a7:b0:1ee:c7c8:cae with SMTP id adf61e73a8af0-1eef3cbe826mr22651560637.9.1740387373187;
        Mon, 24 Feb 2025 00:56:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGODOh9bvtWJ+Wd/yTYPKP51Y5HpfVfLQY6VnaKmCSDPUuwobspDsFFqALPPRN8NBLX7OhXIw==
X-Received: by 2002:a05:6a21:99a7:b0:1ee:c7c8:cae with SMTP id adf61e73a8af0-1eef3cbe826mr22651528637.9.1740387372762;
        Mon, 24 Feb 2025 00:56:12 -0800 (PST)
Received: from hu-prashk-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242568af8sm20161399b3a.48.2025.02.24.00.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 00:56:12 -0800 (PST)
From: Prashanth K <prashanth.k@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Bakker <kees@ijzerbout.nl>,
        William McVicker <willmcvicker@google.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prashanth K <prashanth.k@oss.qualcomm.com>, stable@vger.kernel.org
Subject: [PATCH] usb: gadget: Check bmAttributes only if configuration is valid
Date: Mon, 24 Feb 2025 14:26:04 +0530
Message-Id: <20250224085604.417327-1-prashanth.k@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: JvpwHxkdjyuoDxBt_bs7NtPC2xT5hBqY
X-Proofpoint-ORIG-GUID: JvpwHxkdjyuoDxBt_bs7NtPC2xT5hBqY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_03,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 adultscore=0 phishscore=0 mlxlogscore=646 spamscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502240064

If the USB configuration is not valid, then avoid checking for
bmAttributes to prevent null pointer deference.

Cc: stable@vger.kernel.org
Fixes: 40e89ff5750f ("usb: gadget: Set self-powered based on MaxPower and bmAttributes")
Signed-off-by: Prashanth K <prashanth.k@oss.qualcomm.com>
---
 drivers/usb/gadget/composite.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index 4bcf73bae761..869ad99afb48 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -1051,7 +1051,7 @@ static int set_config(struct usb_composite_dev *cdev,
 		usb_gadget_set_remote_wakeup(gadget, 0);
 done:
 	if (power > USB_SELF_POWER_VBUS_MAX_DRAW ||
-	    !(c->bmAttributes & USB_CONFIG_ATT_SELFPOWER))
+	    (c && !(c->bmAttributes & USB_CONFIG_ATT_SELFPOWER)))
 		usb_gadget_clear_selfpowered(gadget);
 	else
 		usb_gadget_set_selfpowered(gadget);
-- 
2.25.1


