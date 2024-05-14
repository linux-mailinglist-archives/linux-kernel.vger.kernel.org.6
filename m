Return-Path: <linux-kernel+bounces-179116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC7B8C5BE6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 21:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 582DC2822BF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 19:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF36181CE2;
	Tue, 14 May 2024 19:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CQ54EH27"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBF2181334;
	Tue, 14 May 2024 19:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715716492; cv=none; b=tHXCz7LBERXINovZT6qkE6/JzGe9rJleDRHpRkWFdeOP6rvd7Xk4BumxrrXeh+OhYlJAtX6Plnbp147CIZriimAxu61yZXKFHMQLE+kUASEbjy/6u40d9X/UQCiE4l5Vj/uQbR/QVWmmzi1HvztXao6CyeWqqObUYPBeGbPMan4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715716492; c=relaxed/simple;
	bh=Swjs87aJDue7Wd+pJevXnKkvisjA6XSDxsniRTNcx/M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SUa4+VuwVeEwaIkhyJIrlAyOKrVuNrMyOQOf7iAjroRaEwm49AhS2/H3OrhoXj7Kn1X+nRraN/wj0+u/S83+UpQOnFr3IsNujJGXoK8c4FFtAmisJ2IubF0RyibAUA8L5WL/uMXjr85gLt4Qb8HsFvT4IrHCrkgzD+Q0Ib8Bw40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CQ54EH27; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44EIQAZ4015395;
	Tue, 14 May 2024 19:54:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=tfmAGrBYyq7T9Q9kjRG4LT+zggPj1EFXlpm1KphO3SM=;
 b=CQ54EH27ka9qVYpsVssWMor++BzTy1EI6XNoSEBpiN8aSFwRyz0Y6VzJQAY7Q18wdDjM
 SkzzHUfDjQ/AH7IznMe8w8kRlKjZriYcbS+dHJ9+ryYsUUWoghFGgCP08lC7KxS2u3I/
 aYRPS9KbW7jm9OTaqtRtOHwvDK6+LAKDUgqsZBxDzPgplj9eSMiAHmeRT8M251m1WznR
 7Bg+dkeKN0hNEdBePrH0DsJnw4rC+EDs8cuwp+SS7YEukt82D1Om6R8no/EBuQWEepe0
 I23x/daIGlYvW8UFPRO3P0niGveHS+Jwp1558NVyJYrv1JG0Y8Zi6hLWyFKGbXb0fPOz sA== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y4bg40ebb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 19:54:42 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44EHevEN018765;
	Tue, 14 May 2024 19:54:41 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3y2k0tfhpx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 19:54:41 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44EJscOT43057744
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 May 2024 19:54:40 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49D1458061;
	Tue, 14 May 2024 19:54:38 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C8A558075;
	Tue, 14 May 2024 19:54:38 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.107.19])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 May 2024 19:54:37 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-fsi@lists.ozlabs.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        eajames@linux.ibm.com, krzk+dt@kernel.org, conor+dt@kernel.org,
        robh@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au
Subject: [PATCH v5 8/9] dt-bindings: fsi: Document the AST2700 FSI master
Date: Tue, 14 May 2024 14:54:34 -0500
Message-Id: <20240514195435.155372-9-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240514195435.155372-1-eajames@linux.ibm.com>
References: <20240514195435.155372-1-eajames@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: t7V2V6cMVGUkOhyQ4PGWIWaNBWanbNFe
X-Proofpoint-ORIG-GUID: t7V2V6cMVGUkOhyQ4PGWIWaNBWanbNFe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-14_12,2024-05-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 clxscore=1015
 mlxlogscore=986 bulkscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2405010000 definitions=main-2405140142

Add the appropriate compatible string.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 .../devicetree/bindings/fsi/aspeed,ast2600-fsi-master.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/fsi/aspeed,ast2600-fsi-master.yaml b/Documentation/devicetree/bindings/fsi/aspeed,ast2600-fsi-master.yaml
index 2f531c47994bc..fcf7c4b93b78e 100644
--- a/Documentation/devicetree/bindings/fsi/aspeed,ast2600-fsi-master.yaml
+++ b/Documentation/devicetree/bindings/fsi/aspeed,ast2600-fsi-master.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     enum:
       - aspeed,ast2600-fsi-master
+      - aspeed,ast2700-fsi-master
 
   reg:
     maxItems: 1
-- 
2.39.3


