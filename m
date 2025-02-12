Return-Path: <linux-kernel+bounces-510889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A216A32342
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D4F618823CA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C002063C7;
	Wed, 12 Feb 2025 10:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oMm7YIZo"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4607E2066C5
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 10:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739354932; cv=none; b=d2P5hU9GFOmuJeQK6cw+xJNUBD+OsNlSPNJAwt+JQnPssDcg3FeDFdFyLhelYhjopiFL/Bt8i/V+TPzgqYFbW6kLKXFjr1dcCurKVGU4/ct831wWUob7zlt4MvsfVmv9xeb/YsVXeWq8zFe6J0ROht8qhqggUsC0PNa+0WiR3s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739354932; c=relaxed/simple;
	bh=TCwfIE/pUasluVSwZTdHWUH2y9kGY+p5IU5lrrQ0aXU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hd0fhGcFqNn8oitgeeoAWQreV3sRsjWtGlSaoIjIZmQqTEW9Td2doAXycL68iiAxm/niYqHSSh58WUBxQ5seLcKTwaCjWZL1WYi82cejxZHSq0VGc1ZC05PhjCFe+f3lfm5rsVhWk/ii/tDVXxlS/tAlLvFC6t746h46Sl5L6pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oMm7YIZo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51C3I7rx010187
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 10:08:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=B21EnyUYOIhZzIf5xVM2mRo1SahizWAydB+
	PPvQassE=; b=oMm7YIZobwLDYtUoNSqzPIWZNhkDJkCirtGEzxbCSz8WKm4YUUU
	rzYtbqDN9Zs+O6DnQCx8tK/28YOGM7xA4m2o72pbddvppru7lX/eYRFTxZ/JYfqo
	Tv04T9FJutBmZeNFZtRZgcQm29ZxBzd92e8HNqKgZITmT/5bY9DdM/qGZTRh5oU3
	ZX/T5eLDVZ+Z5sanm8QXPVTr41dp1tdLpcB9T2Y2RSAlNz/DoxdAWnHTGVGW1F7g
	ScD0tVnUeiKctd+lHdmid3tP/M5C5jRZJ89W2fKzpy/MryMsd6Wt9PDqIoFB6iLI
	g/fm5q1BKZNd7uao4ITlGuR0IC9uJnGpynw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44qcs5fert-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 10:08:48 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-21f49f0bd8fso94750215ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 02:08:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739354927; x=1739959727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B21EnyUYOIhZzIf5xVM2mRo1SahizWAydB+PPvQassE=;
        b=Z1+Ev0VaxYxXhKUk5s+oTKr8L6DlyMX8x0LdeYP4/U9FtbDqaNQWtHlQXQXdJVyjr7
         A46bNscRqmYSEK61JjHnv9FyR+g5AszIt+r5r5TFxyiMMlcuSzvOm0k/vxNggCb/QVVx
         Cb9s6yq1x0eGdaOFb7H3aEMDGeIq6HVDPOI35y92MdCwo+oLkDKP1WbNKB8SXOOD6Wuk
         jkEMLcZbmerTHW/IIIy3Kuiq7vDNw1CQjZOf1MgF5D6DY3o+3ZTOOc4QzewxK6t7r0Lw
         OYF6lgoDMv1HIyo4AynZOy2q4VM5l3loe+ikz4Rrro/F1vcpeuYfEy/6aS753HO4P1Tv
         6ptg==
X-Forwarded-Encrypted: i=1; AJvYcCXVTiz2beMHDz6ZC3AWk0qP0armIE5KWFOFHSBnNojfMxHBpxP30Hi6Y2jiun0ArepuPsnYiMHiCSl9CcM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEIUYgS33jUzECywt9Kll8tWbjjGu+v2iijq5eKNPSbB3+woPM
	0uTQpyXNcqc0lwLG+bPWYq0rIWACcta+UXc6+XPvTh9w0TdZGxO90BnvhgUNq7sfzIXSt7A4ulK
	LEunldtU9vvGi44aFaO9DO8fCiB5IYbGHU1eaVZV7gts/WJGPWqbDOMKWVGM1fY8=
X-Gm-Gg: ASbGnctOdTD8P1cc1Z72p1Nj4gP4Z0nUhdU2DSVeE60qJWWWJZ+ihSdIQQe3fcX4mgX
	tkOwZlWl4/kY70ArZPI+2yPR5z7wjsH+oux4ZDRvqg3HxLpDdzP71Pci35vNFSnW5oZgjFCN56n
	AZ2QaVdtXRyuNc0t1pyGiJOmSesywA9eihKrRRVX0n6zizDdCpSnafVP0ISjNjQHSOutqgz/jKv
	eQamHThxZy3Xey/e6WOSMBqnBLOCQY6OaVA1u8dGMcWrC/OgUAS6H2KZul4kONziT1/4XHontfm
	UEImHnKGA1xb8kj8d1RGWjhBtlJ16g3h1Q==
X-Received: by 2002:a17:903:32c8:b0:21f:5638:2d8 with SMTP id d9443c01a7336-220bbdd906dmr49597975ad.53.1739354927473;
        Wed, 12 Feb 2025 02:08:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5QcjisXpRuziURHZeTlGA14PANI0hISRmK+4kzlfLZqi/cdkjxjyPK2eRmbaTegnFEn+qyw==
X-Received: by 2002:a17:903:32c8:b0:21f:5638:2d8 with SMTP id d9443c01a7336-220bbdd906dmr49597525ad.53.1739354927105;
        Wed, 12 Feb 2025 02:08:47 -0800 (PST)
Received: from hu-prashk-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f365517desm109635795ad.86.2025.02.12.02.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 02:08:46 -0800 (PST)
From: Prashanth K <prashanth.k@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ferry Toth <ftoth@exalondelft.nl>,
        Ricardo B Marliere <ricardo@marliere.net>, Kees Cook <kees@kernel.org>
Cc: linux-usb@vger.kernel.org, Elson Roy Serrao <quic_eserrao@quicinc.com>,
        linux-kernel@vger.kernel.org,
        Prashanth K <prashanth.k@oss.qualcomm.com>, stable@vger.kernel.org
Subject: [PATCH] usb: gadget: u_ether: Set is_suspend flag if remote wakeup fails
Date: Wed, 12 Feb 2025 15:38:40 +0530
Message-Id: <20250212100840.3812153-1-prashanth.k@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: H1agqiKWQN5VOLDnF-WTHAo61ABkAXSi
X-Proofpoint-GUID: H1agqiKWQN5VOLDnF-WTHAo61ABkAXSi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_03,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxlogscore=781 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 adultscore=0 clxscore=1015 mlxscore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502120077

Currently while UDC suspends, u_ether attempts to remote wakeup
the host if there are any pending transfers. However, if remote
wakeup fails, the UDC remains suspended but the is_suspend flag
is not set. And since is_suspend flag isn't set, the subsequent
eth_start_xmit() would queue USB requests to suspended UDC.

To fix this, bail out from gether_suspend() only if remote wakeup
operation is successful.

Cc: stable@vger.kernel.org
Fixes: 0a1af6dfa077 ("usb: gadget: f_ecm: Add suspend/resume and remote wakeup support")
Signed-off-by: Prashanth K <prashanth.k@oss.qualcomm.com>
---
 drivers/usb/gadget/function/u_ether.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
index 09e2838917e2..f58590bf5e02 100644
--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -1052,8 +1052,8 @@ void gether_suspend(struct gether *link)
 		 * There is a transfer in progress. So we trigger a remote
 		 * wakeup to inform the host.
 		 */
-		ether_wakeup_host(dev->port_usb);
-		return;
+		if (!ether_wakeup_host(dev->port_usb))
+			return;
 	}
 	spin_lock_irqsave(&dev->lock, flags);
 	link->is_suspend = true;
-- 
2.25.1


