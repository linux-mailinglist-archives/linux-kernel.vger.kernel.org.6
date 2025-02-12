Return-Path: <linux-kernel+bounces-511507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95263A32BF4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7211188AEA5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFFA20FA91;
	Wed, 12 Feb 2025 16:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VNNavu5R"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B6C24E4A8
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 16:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739378264; cv=none; b=kZc3xoMLY20boBAiVHQQ+EgB8YKm8bgLD+PlNDrZdNO/hSxB5rHlianaNv1W5UHbFzroGvXxaEPPCaa/EdcSULnWY3zqcJOrbz5p2F4o4qHZtpwcwFzklIK4QksWBHpJulHStb77KzXfZi6RzUuqQ5fY7/wtQ3+n896qGulYNPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739378264; c=relaxed/simple;
	bh=oFmEsmqKLnGWrNiUk/uj6NI/xelNFUkl2fa1/6tmHjE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e9lYeAX2z0ZL7/tcAJfCZbCpvoAQjObQhrgTP0q8clR6x1v/OYqxEU4h1ILl1e6lRbEUd1gPf5e+HyvbHf3cwDR9QbYnGyZLoRqxKmMsZQOtBFjImYZVGEdMZyl3OAM9pq77Zg+josYyRI4gbxj/6Sb8KdyT3DBXqQqrLEYExj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VNNavu5R; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CBW1oL012103
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 16:37:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=y83egAGdzBeY0pvIozCqMkJwXQ+7HxDQxf2
	F6x80cao=; b=VNNavu5R0pRH+qYuBnBuxg18ZYTEfuMWEey813140cQ1P64kE4F
	VMxYuVifUoZhEmbkiHVwk/Hp7R6qy8hQoG9KBtlouUILn+C7OED9ie9Kz+jAAgOV
	6tTlcfqqt95IKypw6wj6VGmGTtcSYwqtyvvqJNLmmuV011M0LwPLUwUCDMVxKLGa
	WB+qbEFSJuJgBuoCO71EJPPagor6WSHMzyBye+ZMfNWew9M7eRnHL7HfZIW8jmwH
	gVxGpZHY1tVh+o3Zj5qrImor2OCZPRGY7ms7FXwKJOqoD5PPNCfqMzTDA63N42ya
	CZGM0byXife94+CkBxzjnDtzjmHGuysnZkw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44qxv3wg3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 16:37:42 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-220caea15ccso8969095ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 08:37:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739378261; x=1739983061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y83egAGdzBeY0pvIozCqMkJwXQ+7HxDQxf2F6x80cao=;
        b=wdaeyFqklSvFsZphjPrX14QT9Sj5IeLwreOLUNlUXq00BT8fcTBR2UtP3HJyweQTRb
         rXTMy5yfp+SWDi88N2d/YyJ7LVZPO3VsGSrQLkPid46Nz3VMyVb793Xkjeem9POh7aiq
         wR9tJT3Z8B1kAByuJU6KK17Da+A5uXuY082VN+QWOWi6vDxGiMVqKqPiCrI5w71dOFkc
         ktJ56wrbAwHqNYNjgi9WdKyNDJBivj2JyVQFfhL1k8oIqzAYfFEU5UesnKUi1BIQoFdI
         Qy0aXvZxJynEmIhMH7BHWclamyy1KhBr4ZMC3ilibEzfh8M5gbCFtpQMxe6ZDm8jZSs0
         EoZA==
X-Forwarded-Encrypted: i=1; AJvYcCW65ecVrPpwaXJ51OdhV65SeXdIvscl456DLYZ+mpZoFs0KOr5rin6eh5iKLVoF2IMUWOB/fUp+jPcJbs4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc5prglpew3SDYnSlTutkY8T2OJHsKFbyaa2CpJB5dH6lYzMqf
	Du2Co+/SNazPkbaIRkBF6XD7kVgryfXtTjvvmw8mRMovflKQZDCg8t1o8OdSd5Ihcg5iJOlf1uh
	mkZYacozpAL58W1k2DNcVHXTHZzS9Q+aURzZ/6sPiLt6U1+94fEFAWRvxTQ8yxjg=
X-Gm-Gg: ASbGncsYviLBj4eGkI8HHZpqq7NyZC6Z5NyKqCbuP9HVJQeLXwmQBBNOTFBGGosUprq
	TzIWmFTmyWB6Iaj55Wa4LbL53YdnEHUEOn5F3809eHf3oFce16eaUHC65JZpbJu5d+iRuc/8nlc
	qIJvhaV8Y60dDEm1yKxka37dbSifZGNslYz7utB7en1t1fhzOslrkoWJLva/hNrVrj/Msbzh+nO
	xQaz4DTcXmzPJF3tHAED3hpVjfguuK+XoycVaLWKw6A5scd2puIPLLiOcY+OMOdVxgBMzg7JrBj
	7laBKcE/Bqdr7OUU5EZc1weZbqHtiiKw
X-Received: by 2002:a05:6a20:a123:b0:1e6:5323:58d1 with SMTP id adf61e73a8af0-1ee5c841268mr5984225637.26.1739378261312;
        Wed, 12 Feb 2025 08:37:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+d2rti2LBF2otvyKFstWvmONRSVusT12UG6tr9uR6qdn+lvkL9PTMuxuPerF6M2zV9ZSfcQ==
X-Received: by 2002:a05:6a20:a123:b0:1e6:5323:58d1 with SMTP id adf61e73a8af0-1ee5c841268mr5984184637.26.1739378260874;
        Wed, 12 Feb 2025 08:37:40 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048ae7fdfsm11248596b3a.83.2025.02.12.08.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 08:37:38 -0800 (PST)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Saranya R <quic_sarar@quicinc.com>, stable@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH v3] soc: qcom: pdr: Fix the potential deadlock
Date: Wed, 12 Feb 2025 22:07:20 +0530
Message-Id: <20250212163720.1577876-1-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 1kjP0NTrlTOpMAh_0kr48FsGZPZciWip
X-Proofpoint-ORIG-GUID: 1kjP0NTrlTOpMAh_0kr48FsGZPZciWip
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_05,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502120123

From: Saranya R <quic_sarar@quicinc.com>

When some client process A call pdr_add_lookup() to add the look up for
the service and does schedule locator work, later a process B got a new
server packet indicating locator is up and call pdr_locator_new_server()
which eventually sets pdr->locator_init_complete to true which process A
sees and takes list lock and queries domain list but it will timeout due
to deadlock as the response will queued to the same qmi->wq and it is
ordered workqueue and process B is not able to complete new server
request work due to deadlock on list lock.

Fix it by removing the unnecessary list iteration as the list iteration
is already being done inside locator work, so avoid it here and just
call schedule_work() here.

       Process A                        Process B

                                     process_scheduled_works()
pdr_add_lookup()                      qmi_data_ready_work()
 process_scheduled_works()             pdr_locator_new_server()
                                         pdr->locator_init_complete=true;
   pdr_locator_work()
    mutex_lock(&pdr->list_lock);

     pdr_locate_service()                  mutex_lock(&pdr->list_lock);

      pdr_get_domain_list()
       pr_err("PDR: %s get domain list
               txn wait failed: %d\n",
               req->service_name,
               ret);


Timeout error log due to deadlock:

"
 PDR: tms/servreg get domain list txn wait failed: -110
 PDR: service lookup for msm/adsp/sensor_pd:tms/servreg failed: -110
"

Thanks to Bjorn and Johan for letting me know that this commit also fixes
an audio regression when using the in-kernel pd-mapper as that makes it
easier to hit this race. [1]

Link: https://lore.kernel.org/lkml/Zqet8iInnDhnxkT9@hovoldconsulting.com/ # [1]
Fixes: fbe639b44a82 ("soc: qcom: Introduce Protection Domain Restart helpers")
CC: stable@vger.kernel.org
Reviewed-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Tested-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Tested-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Saranya R <quic_sarar@quicinc.com>
Co-developed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
Changes in v3:
 - Corrected author and added Co-developed-by for myself.
 - Added T-by and R-by tags.
 - Modified commit message updated with the link of the issue
   which also gets fixed by this commit.

Changes in v2:
 - Added Fixes tag.


 drivers/soc/qcom/pdr_interface.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/soc/qcom/pdr_interface.c b/drivers/soc/qcom/pdr_interface.c
index 328b6153b2be..71be378d2e43 100644
--- a/drivers/soc/qcom/pdr_interface.c
+++ b/drivers/soc/qcom/pdr_interface.c
@@ -75,7 +75,6 @@ static int pdr_locator_new_server(struct qmi_handle *qmi,
 {
 	struct pdr_handle *pdr = container_of(qmi, struct pdr_handle,
 					      locator_hdl);
-	struct pdr_service *pds;
 
 	mutex_lock(&pdr->lock);
 	/* Create a local client port for QMI communication */
@@ -87,12 +86,7 @@ static int pdr_locator_new_server(struct qmi_handle *qmi,
 	mutex_unlock(&pdr->lock);
 
 	/* Service pending lookup requests */
-	mutex_lock(&pdr->list_lock);
-	list_for_each_entry(pds, &pdr->lookups, node) {
-		if (pds->need_locator_lookup)
-			schedule_work(&pdr->locator_work);
-	}
-	mutex_unlock(&pdr->list_lock);
+	schedule_work(&pdr->locator_work);
 
 	return 0;
 }
-- 
2.34.1


