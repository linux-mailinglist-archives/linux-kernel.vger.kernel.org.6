Return-Path: <linux-kernel+bounces-560676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B67A60801
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 05:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1994817E6C2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 04:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8AD133987;
	Fri, 14 Mar 2025 04:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nbhyrKL3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2977932C85
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 04:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741925348; cv=none; b=T1k0szMgRnkFkeAl5nh+2t/wI4wh2s2iy96AnoM+R1qdXZ5J6i4Zdr78XqiwnGuQwA0tm6X+YFkJeCwPJiLi8nt3J3ETa7gD/WJUHWfCjii1nmrRDhHycDCfYBcq893g+PzE1cFXTRxOpIXPj4CHZdIOMmF8HqBnPJAC7RxGQ0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741925348; c=relaxed/simple;
	bh=2hm4oFuudjY3leJj97GYOrQEZdMR5g3oXtO6AH/CqLQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gZVjBKfwfm6xjRWj768c5HOPHULHkDyZrDi9hmPZRsq5iBIXQ86FNqXw4FurbXxy/S9e7T/wkVX2FF4RFIlk0k1dnL7cmrprGo9MHNiRlWa9iMoeNM4ZeadSO5H9yR3Aykl+IS5RCon2xRbl4RdBivlU5UFt7usrdE230MD+vIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nbhyrKL3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DMtBgM009129
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 04:09:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=7HOztwl1BlNHje49xqIYzj
	ekECQIFNxDOobExn87Uhs=; b=nbhyrKL3cJe0R7usQ1kxDqxxHZJAajeJVRfp+/
	3s3uMhz5GojAUfrpNg+Otw6z5Ir2zW8dgoNobclmXZc22v63RB10Kh7fjNY4GfFW
	f9Yl/wxM1tj46SOmVxa28e2Ln5xR0By8ZCgYY4YCFTavctlnDtfVd4upkw80ic3m
	2dUbBrXGIUDtfQGWiKxqbR/do0lqIxPXa4+oxVS6pq48BNBT187DnzkF1/CQKO5x
	N/ppKSdaB4hTKi/OtzOjKV4g4Y5yneKvdcq0x8812aDFHW2gtV2Vkmv+YnezgXVS
	x2OR7bU3TRVWodmhpxXrmQ4sXWAUE7jal9pxjeVsouyXmfbw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2rfy40-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 04:09:05 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ff82dd6de0so2872626a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 21:09:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741925344; x=1742530144;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7HOztwl1BlNHje49xqIYzjekECQIFNxDOobExn87Uhs=;
        b=o3Ezktw8oeyewl84P46a2631Rew5sAX4V5k1IR4DVZgfZ3J3Qf8Ver9DrDG5XACo5I
         ZBCLlYDe3cvA63YfpTARET1zcrhulz8MLi2+xLM7vt2oqFSYyE5ClVOOiLkBjNp+ZJFf
         Hd3aMB6NLUEzNfKvjppZHDr/Q+LZduw3DFUyCferVMD91wM5NdBJclBowX4uv3jS8KaT
         v44HjgqAmagE6UnOnAuoPFhJoVZvHphyUNDJsyIwEUIGzcuGKjSFvUMknppmyLqtwwyf
         v+0DkjPdMG6uonO+AF7LJ8D1FluQdM+fpEMkmrPYYTMpltfzoIVIjCz/X1a8b9yvpRh+
         GfdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfZZIbqz6Wkg3iditRwxcF5p1NyZme8zjZe+gyO4DVa0G6Iz0FFD4yYMLWT3GE5caB1l00BFxfckI3Prs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZsUcBl4u/UFXecjNsjAjs01EPSnzV4pY+b30U/JynJ3mQ8Ppx
	suvDdbAbzGN3FTWpJbUNfQnWCOWtZuAOmYFt6J5U/fWRQY7IyLoLdNWo9d4ApnTj5TLnVu16iK0
	n5HD+FUaUVFSysl3RHt+HZDC5nnUUcPdQRAlF8PrvuhWiGcR08MNZXF40eHUcRMo=
X-Gm-Gg: ASbGncvXtXSrx81NiBLXv43D6UQXmBvqsublii79v7cRpFpbeocyob5Eq2E+0VB4xyb
	71dCg6TdNia4X5zWQnWJX2h0I4qeUGrqHLBoGCBL66n3bAPRfU8oWC4zGplp0/dIreA2nhBZ1FW
	Q184zgAYKDsjNZJQEOTn0AmQPhsEIastXFUQCTeHBNqK1sqEzUuvR2/rHgjO4FsuuCLfipq5qM0
	lUnA4bm5WMueV6z0eKR+goW7SJjiMXs9+CqpiwL+ZbrkVe/Dm0tFZyQanhno45CxFZG8yGm07mI
	HTGMDDUD5igfLOJfrF30PIhU5xmTMoK51UUWZPsH4oOpp7Q24sgKzl/lbpXc57eoL0SdclJ13e7
	Avk9JEswrwxV8dlnIg0L5RZxuh9vK0WTGd+GsE8/Z
X-Received: by 2002:a17:90b:4fcc:b0:2ee:964e:67ce with SMTP id 98e67ed59e1d1-30151cb5a28mr1471462a91.3.1741925344409;
        Thu, 13 Mar 2025 21:09:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsnybzZypWMeFwM4ZeXpdlnGb8H7ZML9GDt2ImhbrZ9r6HLWFnqOnJw24uJpeF5wfbscxSBA==
X-Received: by 2002:a17:90b:4fcc:b0:2ee:964e:67ce with SMTP id 98e67ed59e1d1-30151cb5a28mr1471433a91.3.1741925344051;
        Thu, 13 Mar 2025 21:09:04 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3015364ecf9sm245239a91.48.2025.03.13.21.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 21:09:03 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Fri, 14 Mar 2025 09:38:53 +0530
Subject: [PATCH wireless-next] wifi: nl80211: store chandef on the correct
 link when starting CAC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-fix_starting_cac_during_mlo-v1-1-3b51617d7ea5@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIANSr02cC/43NTQ6CMBAF4KuQri1hyk+sK+9hDGnLAE2AagcQQ
 7i7lZULY9xMZjIv31sZobdI7BStzONsybohHHCImGnV0CC3VbiZSESepEnOa7uUNCo/2qEpjTJ
 lNfn32neO19pkkGaZSLVkQbh5DPFdv7CH9dghER9wGdk1vFtLo/PPvXuGPfRXzQwceIV5kYMGm
 aI6O6L4PqnOuL6Pw9j5WXyQIH6TIpBSSGOqo5a6gC/ktm0vNLiIjS8BAAA=
X-Change-ID: 20250305-fix_starting_cac_during_mlo-fbc4134423b9
To: Johannes Berg <johannes@sipsolutions.net>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: Johannes Berg <johannes.berg@intel.com>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=D6NHKuRj c=1 sm=1 tr=0 ts=67d3abe1 cx=c_pps a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=akwbo0E0F4SoT0UnkgEA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: ozHCVSAaQ32gLC2EtRTN_J4Qy4ZWDMKs
X-Proofpoint-ORIG-GUID: ozHCVSAaQ32gLC2EtRTN_J4Qy4ZWDMKs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_01,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015 impostorscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503140030

Link ID to store chandef is still being used as 0 even in case of MLO which
is incorrect. This leads to issue during CAC completion where link 0 as well
gets stopped.

Fixes: 0b7798232eee ("wifi: cfg80211/mac80211: use proper link ID for DFS")
Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
 net/wireless/nl80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index aee49d43cf862de684194e8f7b40dbc6a1654707..90baa19f4e845443669d9476c49faf426a3bcc77 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -10177,7 +10177,7 @@ static int nl80211_start_radar_detection(struct sk_buff *skb,
 	switch (wdev->iftype) {
 	case NL80211_IFTYPE_AP:
 	case NL80211_IFTYPE_P2P_GO:
-		wdev->links[0].ap.chandef = chandef;
+		wdev->links[link_id].ap.chandef = chandef;
 		break;
 	case NL80211_IFTYPE_ADHOC:
 		wdev->u.ibss.chandef = chandef;

---
base-commit: 54be64fdf3ba6dbad2f5c48e466e1db43ad74bca
change-id: 20250305-fix_starting_cac_during_mlo-fbc4134423b9


