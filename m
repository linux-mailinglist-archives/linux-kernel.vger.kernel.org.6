Return-Path: <linux-kernel+bounces-556887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD4BA5CFE2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB1AB3A6021
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B046264A70;
	Tue, 11 Mar 2025 19:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YDs1bkDc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8505264A81
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 19:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741722559; cv=none; b=FpmL45AD9zLaTBcIXCuHTbAtf3Ul9SqgJrmbLFZ8tqD9jsPSLhbegaQFjX7zt9a0/WYPdXQNs28ir4w1gJOMgAtEEzPjgj7spZcVy9rV76rKcGyY4fkfyCA5e0ps8Dle9Z13FxFAcRdv7BlOkr1A5yGRN1PZumLAhwtfVRtEJ8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741722559; c=relaxed/simple;
	bh=lb+3eIB5E4cbkCyTv4AbOsx/VhSeG3B+x7KApIAeUl4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dX4BeOjb3KbImGqGMjBBy2Hewz9R1k3Ze4qQglhdAvaxnL73W4cgvM20Mn3WQdP9Tc5hvkP0+jye5bheUZf1iRKqdGmgQtICJPpR6o7z5hkrrtUtRwGPzb87ToWLa1Sb8EbY+FnLOrd4Qe/7ZQjkkasftS12Z7IFPpOsXEXvqv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YDs1bkDc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BJ8XX3025304
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 19:49:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=uJ+KtnproCEK/DE4ictchb
	606AaIv+PdZqDhsy1doWU=; b=YDs1bkDceUpWw1o/wPIsSd27hFkXRoBVwTL8iu
	a7QtVBXDHpH8nTjc7q9+MDOw+a8PStp9n0BB/JN7r+GMfkvAWiHvq2f5UC+lEfov
	rS3pVzhd+OB5XPJIfWJEo8/egTaEobWkTEJSUXi0HryziNtY7CRbPdaPgjJFycU4
	vWCdQjy/UZmq3BoAUJkRBFLsXqb2SU9MsihZDWatTCtw60ZtyndVFm4XAiiIgoRX
	OmGeGEBj0aI5fB4AtX+Zmk00AWT/FUCP3aNLX10ate3cfonOcWSsYYnn834Kqtcz
	JZUJfUgEDorXGLNq1GJDKXZ2doWBZAamdnB52l2rfmkv1ieA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2mg2vd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 19:49:16 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2241ae15dcbso120051695ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 12:49:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741722556; x=1742327356;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uJ+KtnproCEK/DE4ictchb606AaIv+PdZqDhsy1doWU=;
        b=kfGslYmEOn3/qx1xYynzpyXju5LbJgeLcN6IAuVArrw8W8/CLnGfo0wqScfGmPRDxH
         Padxm6W4HRKwA4cCIQ9ptoJd3g2hsn6KwjUBqKA/o5aOjhnhLDzdZ7YP32ABVTK9Bbwf
         BwCayFkWOjtPUIOyvHeRPaBiJbaP05sD10dD/jMjoie9fjvUdHk5DQdWaSDOoyD7Kh3P
         z54JYWB7n2pcNQFsmC3l4JJMNVXcjR4kfivHK4dVohusBFRLUEsN1Q7mabO5lUMPPyZH
         Hf7JXbd+zYLli0gwlXKM2Gzxhm1lGAuGQ207xOciEAlcs7PZzanlbg1X9YiOdKmdbI2F
         OmeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUktUMcbA5lliIFPVScVUoxaPCOS1uGQ6zr4LE+gUH3siGq2/JG2fIsSwLpbFfNZ2DIWVLASAzA3tGc5Ms=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVN4Oht77oJDRgRgD64fHzl2FsGfULWvrkFzeZW8qqNmOmuGhD
	WB9Q2GdZAFin+6bkiSxB0nL+7pHJzhloK6ZtbXRc57hHvRXqv+yKlF+1oEPvp0oA+U2mak0a5CA
	THSuY+9VOKPHUAyvQlQMOf5wES+XTHrvu9aftB7DZRDvE1mfcm3b9jDL9BNKNoH0=
X-Gm-Gg: ASbGncv24dEAEvLLXOuDDVqwBqxEXss7wPDfuiqgA//STXd+/0cO3dLABZjMFE6RCw5
	aWaWGbTyuR+lmB5V41VApgGoIP+p2I98J0uIvJ/bP7s42I6P95iPAjj7e2t+KJ+mR+JQL8iWG17
	blUYcULvfY40ikK8rYSqR7TVcoqFuuE6UwtzzIBQJcAr+jX8Bz5sz7GAH0qTCalipTD2T2y1XLA
	GVRIHiFegPOdtAxAWTacbWwDAt/3+Lw9x796HNQLGQK7C9cZpGCuifJgGTt2dMZyZD96Im8Sywm
	3JKcrZCidMEjo6sFRs1gKjfWktAhW5iRPxn7bIhdmWWqqWt9AQOi
X-Received: by 2002:a17:903:40cb:b0:21f:85ee:f2df with SMTP id d9443c01a7336-2242888adfemr284510205ad.15.1741722555809;
        Tue, 11 Mar 2025 12:49:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSpgLwDBd8Si8UBxJzfvvV1/zAfw6r/lhK5mV2ZdDy2fTTd6cfAoHj1s3SajalhCNSRF3jhw==
X-Received: by 2002:a17:903:40cb:b0:21f:85ee:f2df with SMTP id d9443c01a7336-2242888adfemr284509975ad.15.1741722555375;
        Tue, 11 Mar 2025 12:49:15 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a92699sm101813575ad.204.2025.03.11.12.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 12:49:15 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Date: Tue, 11 Mar 2025 12:49:02 -0700
Subject: [PATCH] script: modpost: require a MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-moddesc-error-v1-1-79adedf48d0e@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAK2T0GcC/x3MwQrCMAyA4VcZORtY6xTmq4iHNI0u4FpJVAZj7
 77q8Tv8/woupuJw6VYw+aprLQ3h0AFPVB6Cmpsh9vHUH0PAueYszihm1TBSHocxM58TQWteJnd
 d/r/rrTmRCyajwtPv8tTyWXAmf4vBtu1QTVklfgAAAA==
To: Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>, Arnd Bergmann <arnd@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: nm8oowFbPc8beRhSSOF0u3JxzZbbnreC
X-Authority-Analysis: v=2.4 cv=aKnwqa9m c=1 sm=1 tr=0 ts=67d093bc cx=c_pps a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=YU1Jr47rrnIWNfndT5YA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: nm8oowFbPc8beRhSSOF0u3JxzZbbnreC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_05,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=956 clxscore=1015
 adultscore=0 malwarescore=0 priorityscore=1501 phishscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503110127

Since commit 1fffe7a34c89 ("script: modpost: emit a warning when the
description is missing"), a module without a MODULE_DESCRIPTION() has
resulted in a warning with make W=1. Since that time, all known
instances of this issue have been fixed. Therefore, now make it an
error if a MODULE_DESCRIPTION() is not present.

Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
---
did my treewide cleanup for v6.11, Arnd had a few more stragglers that
he was going to fix. I hope that by posting, some of the 0-day bots
will pick it up and hopefully provide some feedback.

Note: I'm not really sure if *all* of these have been fixed. After I
---
 scripts/mod/modpost.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index c35d22607978..c0b7a869ed24 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1596,8 +1596,8 @@ static void read_symbols(const char *modname)
 						     namespace);
 		}
 
-		if (extra_warn && !get_modinfo(&info, "description"))
-			warn("missing MODULE_DESCRIPTION() in %s\n", modname);
+		if (!get_modinfo(&info, "description"))
+			error("missing MODULE_DESCRIPTION() in %s\n", modname);
 	}
 
 	for (sym = info.symtab_start; sym < info.symtab_stop; sym++) {

---
base-commit: 4d872d51bc9d7b899c1f61534e3dbde72613f627
change-id: 20250311-moddesc-error-2ad949dcc6ba


