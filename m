Return-Path: <linux-kernel+bounces-220434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6441190E1A7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 04:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A96E1C21B36
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 02:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECDF262BD;
	Wed, 19 Jun 2024 02:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RA9Z/c3D";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="s+mZ28xM"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942E63EA86
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 02:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718764869; cv=fail; b=d5nAm3gx4cHyjnjsS+mytBvYkrMFnjApdDDw1z5L0IvKdTdYSy0ziEaEQXIAsBl1E34ZDpcbQwRT5o0+C9H9zSW6cIgN5Xv0ueLQNehSKgwy79zDri0AW+chEkke1OWnTK0D7NOk3PS5sQ+brcI35zorMwSxeCWt6eARkc5pCAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718764869; c=relaxed/simple;
	bh=I8QWGuoaae1ATMYRuAlHmfCyRS4UMyIxaqSlFXP1hlE=;
	h=References:From:To:Cc:Subject:In-reply-to:Message-ID:Date:
	 Content-Type:MIME-Version; b=PLNRL5LERn4b1oGfuTU4iRsuuRWdRDrs/IN3c0fJ9kux5a/X81jHmTfTQpFzLDzib8gzmmhxUq5GoC9P1urqkR95OozviIEQveXdYdJBB5hH+qFipl+bgk0LEqaxbJskJ8pgRVE+zW89ZCaWJd5EiuRNQ3P2XM2Piy0J28PNSms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RA9Z/c3D; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=s+mZ28xM; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45J1tlYW000428;
	Wed, 19 Jun 2024 02:40:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	references:from:to:cc:subject:in-reply-to:message-id:date
	:content-type:mime-version; s=corp-2023-11-20; bh=LckQ5D8obrAOHx
	ABm2l8COAsvVwYjTeMa9hzftpasYw=; b=RA9Z/c3DlbVqTHo1+qfbdx8AW74VPp
	ZYA4V0QQGGPLeBYV0srloJpQYQYsS5+lE2q6KKJdqCaZc4v3h1Z+zjGqbw0MaZpY
	Mm5/ne8qZLv2phOi/F8ryPX2YoJDO8y96WfMm20tchoGT6hA/u9+rzDvQYoVxw7s
	/fL6FWnLaL0ZRobH13Y7KEo5FxA22g1gLs4jD9X1XjrSEQZSOlq5WoG/U/NBHIJk
	Emo9uYl1AAyMGzXewybDBdRIA4+miN3WyuuS85lsKphVqQoUuvkJvC2fs+h4WoMt
	3b71SRN1wDupatkFeL67l+uhr2uM/oJrQlGt0YWFtjaPIzwPo/cqWRgw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yuj9n8ahq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jun 2024 02:40:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45J1b1hH034815;
	Wed, 19 Jun 2024 02:40:30 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1d8y59a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jun 2024 02:40:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=akoLYr/CMt6f7kb1RlY+FQuBTtVz+rCrl1z4n7OD9fEZdtXIY95bme7R2odlL0K8t/xGYZCJvRyM2EfkOPmQCsNOzCUOrAyv8LsQQSjVDWNbvm1gMTms8fZZ2cwq2eBY03JHoJFQEucN8g2MrjeJNAyTYTbsVn98k3JAkWzqg0h0Y39Xi1m3WnvjM9MuMOdmrDPwhqs/pOB2TY/HvphsasaIKGkv+LRxoFN6nb40uE+dLhaS9MSBHDBKeiU/iDuGVAz0uz2nWspSABMIigiQ4O66HT7QhCqeLvqFyKst+YG1sAgjXHgjrTCoVB5xLOReAAzRr8LXuhL5FjK14qX5tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LckQ5D8obrAOHxABm2l8COAsvVwYjTeMa9hzftpasYw=;
 b=iOXp3ts87Q4agFgXCPcENUIjXIT69wezWHpm0wPLOz89S38evw1MC919o0eCz6BYmOEIACzIa+ZvMENkaARte/EbtlBcpsnMYwfG2/D3eDC8Dd11f+ouDkcoD1GQzmwsZXY82RG5WjVb/CLsnCNuYIlbLgGsxVv1TM6kJ23ivFTknmr4LrPeb84MgmTPWTgBIhxokKSAzxUcT8SHA0OAhKkyQYUwW3pP4uKR4AEyoofuR+jDei0TnPfHL0EMeXOzrq4FhQoJnI4YcGWG6y2ZZ4glwMulTMcedRyaDC/PsZH7ljlOfEDo4gakUlOzM3aP+mtqOLG70kxfGmZ2h4QXkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LckQ5D8obrAOHxABm2l8COAsvVwYjTeMa9hzftpasYw=;
 b=s+mZ28xM+HoXWYXwOYpLrRhqe/SeGO3slqLoPrFeCkVnla8itZKwmAbVU1LU5N8h2YiX13jutjHQBnucTMRlmRuJgVGfieDLRIeFXbxehndP4BSwCYsA9y418TCfqTXvlN/AyiBjeZnfSraXHmMB9uvOMrUpV1klIWPZ5aYcqI8=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA1PR10MB6075.namprd10.prod.outlook.com (2603:10b6:208:3ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 02:40:27 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%3]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 02:40:27 +0000
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
 <2d6ef6d8-6aef-4703-a9c7-90501537cdc5@linux.ibm.com>
 <8734pw51he.fsf@oracle.com>
 <71efae1a-6a27-4e1f-adac-19c1b18e0f0c@linux.ibm.com>
 <bbeca067-ae70-43ff-afab-6d06648c5481@linux.ibm.com>
 <87zfrts1l1.fsf@oracle.com>
 <17555273-a361-48b8-8543-9f63c2b8856b@linux.ibm.com>
 <e7e2126f-40ca-44af-9287-888f4ec34b35@linux.ibm.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, rostedt@goodmis.org, mark.rutland@arm.com,
        juri.lelli@redhat.com, joel@joelfernandes.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        LKML
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 00/35] PREEMPT_AUTO: support lazy rescheduling
In-reply-to: <e7e2126f-40ca-44af-9287-888f4ec34b35@linux.ibm.com>
Message-ID: <871q4td59k.fsf@oracle.com>
Date: Tue, 18 Jun 2024 19:40:23 -0700
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0381.namprd04.prod.outlook.com
 (2603:10b6:303:81::26) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA1PR10MB6075:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c942771-8bcc-4773-3c76-08dc90092d5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|7416011|376011;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?pOvVxt2xn8MLfn5GnVnCfy3T6J0/rWocgTTog8Eh3s0blA0uNa4f/kCm3Jzw?=
 =?us-ascii?Q?iU3YeYUV3ze+7fs3NBvBVqoOJe2CAxNIWNFcT0ZhA7IwNI/Mr8OrfWIeiFGo?=
 =?us-ascii?Q?WvuMaEVzU57pu/k+ybZgofCpAPnW1v5JPkyxTPR4zRtAapRYLh/NcvOU08Dg?=
 =?us-ascii?Q?0vi4zcycV0Pn9ZfNO0tNNukikeFjDHhNOvN8y3SKSyf3UkHGCc1HKwDTrz1t?=
 =?us-ascii?Q?yTwmXPbsvdKSodHOyJq9kPmSj5I2V+Vr7syVx3VZCIznB7tKZZxJwhq5vpDk?=
 =?us-ascii?Q?DNsPJbzpKqAEdrs2cew4a+kbGq/wgDOhjcR/n6OgkSE1v41xSaQA+3dRjxPH?=
 =?us-ascii?Q?mI4I4POLHyhrUuh+ZXNRim0TgezuSXRMwJdLuu5RFny+HheFUdichd2LdvXQ?=
 =?us-ascii?Q?PzB1ueWLyHMlB29PRSEvJTpiDJtfwaVDTU8aUqPpnqredfV9tj8vlakkko7f?=
 =?us-ascii?Q?Te57J0UlGCUl3j3m7+VgaxG70vVXv/wiM9gOELYseU+156drFcIGCMo+FS30?=
 =?us-ascii?Q?EEL02uA1sdQpwE0aDuMyh/5w1N8pTj98N1ZqxWINfmZMApCBFphZtwNCr0yO?=
 =?us-ascii?Q?90TWBgXBCifTX12w1nxEvOp+XMnDuRCJf+WNs2jy1OTmeRDQSxYLYRDGIgI8?=
 =?us-ascii?Q?no2+hqjfXHEEvDA9t72c+wzkxhDCUY0qL1PlK3BW8XUwXFpdvraFtiWfwcoz?=
 =?us-ascii?Q?VEf39UyZX82+bxdTAV0AhEJjUK8sf64gnSothvf/Dyy6Ho2Qaj3TGX9mGgmY?=
 =?us-ascii?Q?sT6Lo2DxVNWYWDs4eridRuZAycwRa6iVmO7uOWZCkuF/D/rl9k4D75eZ19bV?=
 =?us-ascii?Q?2gLfdmJvdcqc5wdTtjFVDJsUxzkcWUmcKhLIxDsSxUOGB+WDdITX5maS6YsI?=
 =?us-ascii?Q?ViBsk2qLQwZc/V/Y0dFkAu8w+BXIXZ7YIJFsbKoAKXJqQH006EKY85+Kxt9M?=
 =?us-ascii?Q?Ue929NUteXZ/Xa60d8zqwNoMoEVv4Rtpx+q170XHyN7Cutv1kMrDF/4WnIgS?=
 =?us-ascii?Q?KI97DN2eSM9gMC0VMYeTefSTqMKHsbCeBQkgkLp+GvaqcVN5Zk4GtsS4wodj?=
 =?us-ascii?Q?zThHhqQu+e3wyWx8CF/VCcQ56UynYGbx+Wx2+Gc2aFyKz3f/OspJsL2X7Gto?=
 =?us-ascii?Q?bAt9Vk8LVsWwYAa4h/AMaBrL4A8HUS6n3VWPCnMjCdCshAGNdZal7Sa+87Nj?=
 =?us-ascii?Q?0XPQgRDod3DV/Ar/tJXNbOgUSbnSuMmid+9U5LvQ28+8qn72BhWgcS0iTuaM?=
 =?us-ascii?Q?AtldeYDnjee3YYkWTpeOoY2fXTOX+tBLUJ+vkUjJ2TebwvytbkaqHz0O3zkC?=
 =?us-ascii?Q?4AecFc9ANZwKxpPRNQqJJmLM?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(7416011)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?xs4HWrCCJYDRTEZftoNV/c+ONwiIPmfaZFiwlJVid9Xj83BxfxdENSJ7EEp5?=
 =?us-ascii?Q?5PDrn0TBbeajkx0w0kX6ks70670Sfm0N9WcYBW8Q9V9m7wGiAhBYBKDc2gmH?=
 =?us-ascii?Q?4WcO40DN7YFFq0J1OFZhBclGO7nTNqgfWEK6rilX789GWPqyhdEDrq59uEWx?=
 =?us-ascii?Q?7MPTv3G93kxUm7NT2xUaZmH5oza/Jh9SkybJ6kRc/nuCxtgnT3krjAuHiB3o?=
 =?us-ascii?Q?Sn0mP2qldfTyXHZWdpEEx1D/BPkixj3BHwAJMCsgwq6yLNtutZyQQcrBNako?=
 =?us-ascii?Q?vr+XYgzRDMuk6gABkC2pwWoBc2zBCV+do8QJv5tIMYytuBpL1wKvefWjikkf?=
 =?us-ascii?Q?pCSP/GYf5mXk2sUw3Rmz9RHe+HvwRqzbtVqBfoFY95x/R1es2ppvTiq104Ia?=
 =?us-ascii?Q?2hbT5s5olXTU6ERBFe3bk7m3xCCWaxRNI4JL7pXxlYb7PL85Y8uxIgyYIUM3?=
 =?us-ascii?Q?COPvF64Y1ML8A1tuMO7l3o8zdUIn323T59HRIUr6vsTFRuKsTvWG9T7dl0/n?=
 =?us-ascii?Q?7pV/XhorKtZxDpvDWnvfhubr0uY7ltdcHbXhIhafiUspWL2BWEgIwHGsXuZ7?=
 =?us-ascii?Q?pdu6KyxQUPCfYGAx/YLR3nBVGiRLP+K9yTxAMuQz1BfvVt0y1nvswqkTCHUv?=
 =?us-ascii?Q?Sk6b7uiL/uxOPFozFT7Qv2pBD9qNzN6D7lNOEcSaZZ8L1h6OIpVHW1Ndy2i8?=
 =?us-ascii?Q?bPhN/yFKEXqI75lujBxfsVMEN2NpqwGiltGI7iBLNNCbONFfJ9XJTTPXne9+?=
 =?us-ascii?Q?WV5PSYevHIZc9Z4RkHIOJX4uNEj1j5HyaaxbhtpWRlEbzZ/ZBVxbbB+PKcx+?=
 =?us-ascii?Q?OYfDAneGhFTyB1vWIUetmlVJ+U3+z532SwvZ+u3S6RH1e2Md0KKW7H1HrhCc?=
 =?us-ascii?Q?CCpFGSgtbQ8yKAHYLx2H3WOK5+UgrAt/pMFoDpdAHOmqKr4yvxoBkizhYqJF?=
 =?us-ascii?Q?6pixyz272h2yIu9FEbvFEsXvR0nBDixa8Id7cbPVsFVtKf+vYBJ6Wf1x+rJy?=
 =?us-ascii?Q?NMEq63H4rJrVkwSpZwr+2fVUJRuxi6XX2Q5hiYa9xffqvvRmHQP8k+p//ehe?=
 =?us-ascii?Q?HKZg5vONSXAL9aEv9QSWsWmkQcu2ymNZIipwov9U5bQL/8p6n0oVxl1Ln2GN?=
 =?us-ascii?Q?3tzqayP4sHRUvFXXCabM6H/UocdXFGVkZ8MpzMsERvg2CmXT6i6BU8oo7eDQ?=
 =?us-ascii?Q?u/CQAabrZ7U1+02YcmtyJfaR2DDNy3CiI4CEGE8dL1IzahgAiMmIeKw2E/P1?=
 =?us-ascii?Q?/x96MERxCHtAFQwPd+KQjiFLd/2R35JtEmFChecGqiojM2I+gfnPvuWQCW61?=
 =?us-ascii?Q?iF0ONUwfQEsOUqJwiiCFeSzGfnOXOcbvCvzfQ3j3VSOMW2Otyquju3t+bhTw?=
 =?us-ascii?Q?pLuODtcZ626MPq5raMKVftI9fQ1JNxxiIoRrFFX2RU29C/h/5Z/NeNv/HuYe?=
 =?us-ascii?Q?IHANhtZF5oUxruUqvEUqN4389PQ4zZhS4yrnzgfH3IIuDNvYSIQ6JYh4IS9P?=
 =?us-ascii?Q?0kqBDMO6mg2JkoCDPS6bOepkLo2FEHe8uahSSIgRbl2+OFUnShzpG0Kou/il?=
 =?us-ascii?Q?+VQTyQuBZLckHXYWDDqM97Ns+Kds1PpZl/Ojqsbx9X0oWzFqmaEReOUeYUsj?=
 =?us-ascii?Q?NQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	qZtQrTOoL6Q/sjk6DRBg7yj4uCM3Sg2LqQacCPbcTIK1i0ABPEB5fXdh2evY4KzUfkxGOISPNLWBavE52un4UezkSa+a9wGt1joatV7KyMkythUNgfuZic/emSxKYmQXqmZrdRsVFukSI0cLwHQisyLfW2bYKrWWypTRIGLdv2KBvV7yqlPEWGheF7qMUX32pmVomr6B7jlSGlp/jZ/y5LIUcyrIIMPzurXGDDNxVpedjsZD89yW2ieYTLftnDDOwbqM6+z/CzrKUZAUJwIDt2Y66m7yIhOmdxxE1xIBB8za/oJ02XnUDC86TJxL1r4ZSAC4idNt60bbJuFZWzn2Ei07gW0yOSjzqHgxZdCXpdaD36Kab+NwvefRx5KEHsKXcvv6t413X2TIE4J5xPFTZDu9yw7VDTr3Y70fy1PVZtaMmO1PrJCEfE4wzmTmU1iCLujG/qKBurw+9yraOp7iKWEMqPRIIbUs/2rnALKiIUN+rnVgctgihwS/AkmQ2vceq/6zZubvaTkQuU01abJHVnArs5P58SJOtLRtauaUBlUiRTmeb2UrINf6hrhv0aMP+P/cQSCvchpUj/wptDwVPk9towlmFCJ2fxfqnFUNs4E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c942771-8bcc-4773-3c76-08dc90092d5a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 02:40:27.3390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nK61pD0acLa2IHs7BHMZC0hi42MCArJlBb8plkc8PYdvhb6RuFB/iASB9KveB54v44ifWzEM0sg8kKX1JiYf59ebK4jdpDbrnwcnHi0PO0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6075
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_08,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406190019
X-Proofpoint-GUID: t66UigU2qFoJnU7PWv730HKuoXrTCQae
X-Proofpoint-ORIG-GUID: t66UigU2qFoJnU7PWv730HKuoXrTCQae


Shrikanth Hegde <sshegde@linux.ibm.com> writes:

> On 6/15/24 8:34 PM, Shrikanth Hegde wrote:
>>
>>
>> On 6/10/24 12:53 PM, Ankur Arora wrote:
>>>
>> _auto.
>>>>
>>>> 6.10-rc1:
>>>> =========
>>>> 10:09:50 AM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
>>>> 09:45:23 AM  all    4.14    0.00   77.57    0.00   16.92    0.00    0.00    0.00    0.00    1.37
>>>> 09:45:24 AM  all    4.42    0.00   77.62    0.00   16.76    0.00    0.00    0.00    0.00    1.20
>>>> 09:45:25 AM  all    4.43    0.00   77.45    0.00   16.94    0.00    0.00    0.00    0.00    1.18
>>>> 09:45:26 AM  all    4.45    0.00   77.87    0.00   16.68    0.00    0.00    0.00    0.00    0.99
>>>>
>>>> PREEMPT_AUTO:
>>>> ===========
>>>> 10:09:50 AM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
>>>> 10:09:56 AM  all    3.11    0.00   72.59    0.00   21.34    0.00    0.00    0.00    0.00    2.96
>>>> 10:09:57 AM  all    3.31    0.00   73.10    0.00   20.99    0.00    0.00    0.00    0.00    2.60
>>>> 10:09:58 AM  all    3.40    0.00   72.83    0.00   20.85    0.00    0.00    0.00    0.00    2.92
>>>> 10:10:00 AM  all    3.21    0.00   72.87    0.00   21.19    0.00    0.00    0.00    0.00    2.73
>>>> 10:10:01 AM  all    3.02    0.00   72.18    0.00   21.08    0.00    0.00    0.00    0.00    3.71
>>>>
>>>> Used bcc tools hardirq and softirq to see if irq are increasing. softirq implied there are more
>>>> timer,sched softirq. Numbers vary between different samples, but trend seems to be similar.
>>>
>>> Yeah, the %sys is lower and %irq, higher. Can you also see where the
>>> increased %irq is? For instance are the resched IPIs numbers greater?
>>
>> Hi Ankur,
>>
>>
>> Used mpstat -I ALL to capture this info for 20 seconds.
>>
>> HARDIRQ per second:
>> ===================
>> 6.10:
>> ===================
>> 18		19		22		23		48	49	50	51	LOC		BCT	LOC2	SPU	PMI	MCE	NMI	WDG	DBL
>> ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
>> 417956.86	1114642.30	1712683.65	2058664.99	0.00	0.00	18.30	0.39	31978.37	0.00	0.35	351.98	0.00	0.00	0.00	6405.54	329189.45
>>
>> Preempt_auto:
>> ===================
>> 18		19		22		23		48	49	50	51	LOC		BCT	LOC2	SPU	PMI	MCE	NMI	WDG	DBL
>> ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
>> 609509.69	1910413.99	1923503.52	2061876.33	0.00	0.00	19.14	0.30	31916.59	0.00	0.45	497.88	0.00	0.00	0.00	6825.49	88247.85
>>
>> 18,19,22,23 are called XIVE interrupts. These are IPI interrupts. I am not sure which type of IPI are these. will have to see why its increasing.
>>
>>
>> SOFTIRQ per second:
>> ===================
>> 6.10:
>> ===================
>> HI	TIMER	NET_TX	NET_RX	BLOCK	IRQ_POLL	TASKLET		SCHED		HRTIMER		RCU
>> 0.00	3966.47	0.00	18.25	0.59	0.00		0.34		12811.00	0.00		9693.95
>>
>> Preempt_auto:
>> ===================
>> HI	TIMER	NET_TX	NET_RX	BLOCK	IRQ_POLL	TASKLET		SCHED		HRTIMER		RCU
>> 0.00	4871.67	0.00	18.94	0.40	0.00		0.25		13518.66	0.00		15732.77
>>
>> Note: RCU softirq seems to increase significantly. Not sure which one triggers. still trying to figure out why.
>> It maybe irq triggering to softirq or softirq causing more IPI.
>>
>>
>>
>> Also, Noticed a below config difference which gets removed in preempt auto. This happens because PREEMPTION make them as N. Made the changes in kernel/Kconfig.locks to get them
>> enabled. I still see the same regression in hackbench. These configs still may need attention?
>>
>> 					6.10				       | 					preempt auto
>>   CONFIG_INLINE_SPIN_UNLOCK_IRQ=y                                              |  CONFIG_UNINLINE_SPIN_UNLOCK=y
>>   CONFIG_INLINE_READ_UNLOCK=y                                                  |  ----------------------------------------------------------------------------
>>   CONFIG_INLINE_READ_UNLOCK_IRQ=y                                              |  ----------------------------------------------------------------------------
>>   CONFIG_INLINE_WRITE_UNLOCK=y                                                 |  ----------------------------------------------------------------------------
>>   CONFIG_INLINE_WRITE_UNLOCK_IRQ=y                                             |  ----------------------------------------------------------------------------
>>
>>
>
> Did an experiment keeping the number of CPU constant, while changing the number of sockets they span across.
> When all CPU belong to same socket, there is no regression w.r.t to PREEMPT_AUTO. Regression starts when the CPUs start
> spanning across sockets.

Ah. That's really interesting. So, upto 160 CPUs was okay?

> Since Preempt auto by default enables preempt count, I think that may cause the regression. I see Powerpc uses generic implementation
> which may not scale well.

Yeah this would explain why I don't see similar behaviour on a 384 CPU
x86 box.

Also, IIRC the powerpc numbers on preempt=full were significantly worse
than preempt=none. That test might also be worth doing once you have the
percpu based method working.

> Will try to shift to percpu based method and see. will get back if I can get that done successfully.

Sounds good to me.


Thanks
Ankur

