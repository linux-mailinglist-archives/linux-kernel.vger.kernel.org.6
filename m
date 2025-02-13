Return-Path: <linux-kernel+bounces-513904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B27E9A3500E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 629C116B58A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 21:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65A9266B5A;
	Thu, 13 Feb 2025 21:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NbxLY77H"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6907194AD5
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 21:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739480648; cv=none; b=YvPlT8OCNQ590uUkuyvnQyW+EVTrErhLadntD88lFnaNNzJlbI/vFAolNrQLs7xTgVrRjLNcYRMh8normHEdBTNoYIA3zwjg1NDVhMM5gGQ6cakstrLL/Idf/VmUQU4Js81NJc48YKH1uxJ/Ea/Sa/mnGKsIa3X9goYt3qVZ8Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739480648; c=relaxed/simple;
	bh=YRGZnLfEo00umHgePB/lOxUrXp4t6Vz/QLbBg0QP3mc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VXEdM7eYHjzlNgdEsFw98dwCjB7+/2RdMlLj+6+LgbvRZT4lZ90BIyz7d/H9SVbYisukf6g0f9a2EBjNk6Sq06MaU7cAT4JuGxwI1CVt7TAc0dTFo8gobipsADXwy8ICWJ0T3BYSgsA7LGLtYj6q2o1tcRqL6P9O4/eukQHVmWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NbxLY77H; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DA2GCf001950
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 21:04:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=8VxP/CgXnqLT7dCVI0cxvlRc3vuTuhQDamA
	kGTDrmDw=; b=NbxLY77HESK8z2YTw5p41EtFM4+f1MZ/aI0SAtGTnwKV546D9wr
	i7icOiJES4OIy6pp3GoQaAXzwYxRZ8v2rSDLlnDa1Qgi0TvPYYuQ9K7ncdMvVLXK
	Hlfz2rltDyC5ARp/0tHLquq5RQVgrzNWFB444MR+gHWEENx+UZIGRfuiTHT4XSGP
	GMNCDM3LTkHScSDXFjkxgzzMSwWeuxdVCGeRNDBAW+DIsLCxNt3bPx8MtVYzKj8J
	+YTZgvNDXOw4LNBiENiUbVN9R2fvWPX8IcFE6dPTIT9LcOt5lJMYeZ/wgVJCXHdB
	pdQhYMLbMgKD3yNlH5zb9Zh2x/q1cvw0DVw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44semp9mtx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 21:04:05 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-21f90aec0fdso29343485ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 13:04:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739480645; x=1740085445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8VxP/CgXnqLT7dCVI0cxvlRc3vuTuhQDamAkGTDrmDw=;
        b=Qo6NfZaMFT8UIPflUBFJVSTR/v+ypuCDLDnXhZbkns1/nVuVkhPxA9tVBccQcMPUpu
         lWCspeizG+OHdi9tGjj5ZA4qdNisjpIaqAc+3iFb/I4asx3a1Ydr4L9dFV40TPtLUSXt
         TAuwWhW2da8EDbTUdwRtgtMv2YSlPsdA15RwOGyMi72F7xKk0OsRU80l2uHZQIaVV1tu
         M/QZtEBTJ7Xi3dqsvjkQErJ3VCr676fdhImHOfuoqTvZyvFCAnD2j4BPItS8X6QFEaTd
         cw5C07qGtWq2CQbPiFEWrLDGHlZReWWAAzM2KkqeGsYBFE/YtA9zi0215CEGhs7bmEBq
         pHKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYOMkS50BFl4y0KjqMImCPzqXmcB5BLuaTxZfZUp2OXgaDNLQOzWlcqmenXh5cpNrPI7dCQc05PytHx5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvVzXRh3RYfbZXn8AGL5gBIRyGSYW1cuvqF+WBdOKt5qqzsGap
	Izi048MX8fEl9/i9iO2vZU0qyhbMHrkkiEGRKfuVYhHK/mC3o6BBdnedGud4fX1ShgLutCKjwDo
	N7M3pidG4hTwQCg6vpAcrWeszkO1vePDYSP9A2+Z7dtJhkZJGhADq2qn5UpZr9MA=
X-Gm-Gg: ASbGncvDIjxjD9sx7NTBJuCswtgXhWMMeYKCY9XBT1OKs6n4bCQJ+j6yh9641SR1oFj
	8JIsMJR3GNu4/KaGAmy6AeGf8U7TnBNjEecLiNGg1RGi/X/siZr96FTRiF4GTdb/KI0pVBpgeP3
	O7Q/5lgxN1RloWN+G9+6KOAXRRdNS40dJphs+MEbYcFD6uUH6T3pjnYP8ALLPUwgBadLFyd2rIz
	aHIb5ArPFggLWVWTM+tCem3ykrdbh1yqFbeme9wp1EqXLIr9RQNv75MboJT9Lhn2oHASn3Xt3vM
	pPY/XoAFEOWSTg1X1SpfgHkPKscwUmIDz3Dre85ZAiMb4af+ejnaQzwgR6MbZKsF73Ly
X-Received: by 2002:a17:902:e74d:b0:220:c94b:83a7 with SMTP id d9443c01a7336-220d20e9098mr66059065ad.29.1739480644973;
        Thu, 13 Feb 2025 13:04:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3PVefDcwgu/C99h90ihg+V7iq72uwEndOIuPiYoQ0b1DMyzjKKFzPMqJTWrNTXGvhYvMn1Q==
X-Received: by 2002:a17:902:e74d:b0:220:c94b:83a7 with SMTP id d9443c01a7336-220d20e9098mr66058705ad.29.1739480644579;
        Thu, 13 Feb 2025 13:04:04 -0800 (PST)
Received: from hu-amelende-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220dacfc769sm14339375ad.201.2025.02.13.13.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 13:04:04 -0800 (PST)
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
To: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, david.collins@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] thermal: qcom-spmi-temp-alarm: Add support for new TEMP_ALARM subtypes
Date: Thu, 13 Feb 2025 13:03:59 -0800
Message-Id: <20250213210403.3396392-1-anjelique.melendez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: VhNS265l_FuP5wZ3pqe6h3M9CbnMTYyl
X-Proofpoint-GUID: VhNS265l_FuP5wZ3pqe6h3M9CbnMTYyl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_08,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502130148

Add support in the qcom-spmi-temp-alarm driver for the new PMIC
TEMP_ALARM peripheral subtypes: GEN2 rev 2 and LITE. The GEN2 rev 2
subtype provides greater flexibility in temperature threshold
specification by using an independent register value to configure
each of the three thresholds. The LITE subtype utilizes a simplified
set of control registers to configure two thresholds: warning and
shutdown. While at it refactor the qcom-spmi-temp-alarm driver to limit
code reuse and if/else statements when deciphering between TEMP_ALARM 
peripheral subtypes. 

Also add support to avoid a potential issue on certain versions of
the TEMP_ALARM GEN2 subtype when automatic stage 2 partial shutdown
is disabled.

This patch series is a continuation of older series from 7/2024
(https://lore.kernel.org/all/20240729231259.2122976-1-quic_amelende@quicinc.com/)
but current series has been reworked to address the change in thermal framework to
update .set_trip_temp() callback function variables
(https://lore.kernel.org/all/8392906.T7Z3S40VBb@rjwysocki.net/)


Anjelique Melendez (3):
  thermal: qcom-spmi-temp-alarm: Add temp alarm data struct based on HW
    subtype
  thermal: qcom-spmi-temp-alarm: add support for GEN2 rev 2 PMIC
    peripherals
  thermal: qcom-spmi-temp-alarm: add support for LITE PMIC peripherals

David Collins (1):
  thermal: qcom-spmi-temp-alarm: enable stage 2 shutdown when required

 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 515 ++++++++++++++++++--
 1 file changed, 464 insertions(+), 51 deletions(-)

-- 
2.34.1


