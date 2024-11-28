Return-Path: <linux-kernel+bounces-424839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1729DBA0F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 16:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 464DE165042
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 15:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B04C1B4F1C;
	Thu, 28 Nov 2024 15:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Foa8+6OT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yIyuBfjV"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9825619ABBB
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 15:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732806419; cv=fail; b=KhAVhOKhgHkUo7Jfu0uAPnInHB0zDgoyUAmM16WI3RZIfLEurvhTdZQLtvOwrBOe/ul9N0natLofEc1xLkoOyAfC4hRWNWHDVZ1EEVbI3ycMuCUS/BwX8ll3rhGbHNLlKyVE8S4laGS9YjVHnv0ry7xJJ1XiQjR6I4CYkYbgJSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732806419; c=relaxed/simple;
	bh=uucQPzSFAVNessBGBaoVk1UPPBvkzCQCXP7GXvT8EGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FXKFS3fs9nmv6wYQean5Z2URpu8UDnKMGPQyS5KLzRgaL7FFMFSNTZXmnDvV+3QDlrkXH4x6og7Cl49RGDswk5AkM8nni4sR/KssS+UYa+GZ10wmAfVw0dYd6Z3R3FD9fUmRfYvXqA7hr/rJGKb7ogCe7fylz85HFopNGmJ4mGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Foa8+6OT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yIyuBfjV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ASEHEF5029077;
	Thu, 28 Nov 2024 15:06:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=fucP9TZcpv3nFaY0Gbv55QIlReHIn6dziNcoY5psffc=; b=
	Foa8+6OTwHD6U+EEOxlH/kVEYbQAR3i1/2MLUs8ylyXtei9nwUCOTgbeRpfINquq
	5Q6MNotOH0/yl6M0+ThH0I0t9W8bL1jmTImm7TzwIsTM1K2KdggJ5CRpOVCUgbiC
	eosytAgtYXZQdnHi4jLtBMgn66AwqwyONQSWUbpY/cXAvjL4sljQ8cYgceC0c/rq
	3fa3Zc4CWaMmWvbsufWXN+6vKIlxOhnrrWDRrACRT0Q1tV5HrKypGDGcQDgwSYeA
	gUjf+5veYRebROOGSR6Gywpl0FIOIxHG+ONQxMapUsq2m5QcNN6qMoY0Y3GA72aG
	CUnxBy6hc5BCdI0Kv6F4qQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4366xya0dm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Nov 2024 15:06:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ASCoAdJ039401;
	Thu, 28 Nov 2024 15:06:32 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2174.outbound.protection.outlook.com [104.47.73.174])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4367067rd6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Nov 2024 15:06:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UyimR1ypqav743DhnI5vxXzSEEDYWMZGoAaYWAbWed3CGnxo2EUsiPTSBfFtib64pw9k5KzVQe8wiCyCAbhisCyoYCiEKvNZnRURyVoEoVHLFiyDJefpG44FSbpFcAyfdINd+gu404ZTg3MX+6LOR1aMckQjInBO6YG0LyG7jGslgsIg7dU/3hpYCI1h6rVo01/5IKkIbJeEkeepeeCyvzuaqQAnGxzi/pv7xWthY7/p6/62FlrifWqhkGrJ/LyLLq4bstnFPdqAE4Kl4Osp8kUUIywWDYeOFO7QVb8uEqZV8ofOsZdkpma+bBYK8SuqWKjgIn6ptsCfQo6+SWvjNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fucP9TZcpv3nFaY0Gbv55QIlReHIn6dziNcoY5psffc=;
 b=J+qiue+g0UsRetMoS0zd2mCIM3fNtEmr0D7lCy7PWQG4eMU4w2cHRWzdQuuR0tPMNQVBtH2KoBG+qc0sVcn2amUOH4TvOW/hmA1HMsTJ/1O8c2U6RmFOMX46HfoDdQbZ5c/BbwR6y25d81YmQT8Ujym6pjlbX5t43lKri8bX7BZn/1a8PurMFtSMptD3nALyLJMx+OmWhzU4VO02NE+lyok69XH/zsNXho12LOn1LeqQvI/LLMz4DqQCJb6qpOTjeOmFmvVT34roeA8iLIkppdpy9nxtjbwWYXNLbCpO3I3FjhLRYJxC1jheFhAZ4KMUg8taHu5K4TBlTvjh7/mFGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fucP9TZcpv3nFaY0Gbv55QIlReHIn6dziNcoY5psffc=;
 b=yIyuBfjV/9d/t4RqsKxxb0stezM/8lan1AtYkVVUT47RQdekQNfCX7pqta9UM2GsQK788iMctiQK9Br9fg8pO3ZOGtSkVeVcjQv6Rgo2IzOTKW00Zu2duN5vatrW0bRnrJSkvrlL847GeL67TuzmhYCJIBcBwbr1UvmIa2VGGZA=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CH3PR10MB7958.namprd10.prod.outlook.com (2603:10b6:610:1c9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Thu, 28 Nov
 2024 15:06:28 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 15:06:28 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Shuah Khan <shuah@kernel.org>, Julian Orth <ju.orth@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mm: reinstate ability to map write-sealed memfd mappings read-only
Date: Thu, 28 Nov 2024 15:06:17 +0000
Message-ID: <99fc35d2c62bd2e05571cf60d9f8b843c56069e0.1732804776.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1732804776.git.lorenzo.stoakes@oracle.com>
References: <cover.1732804776.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0463.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::18) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CH3PR10MB7958:EE_
X-MS-Office365-Filtering-Correlation-Id: 63b9bf99-9dd6-4af8-a7ef-08dd0fbe3c41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AOnzsvPivvUwGSh5zDT91KSRhi363SQx/kMIYeLJai1lR3Z27B1gcGh/r9jT?=
 =?us-ascii?Q?y7zUeZWNQk+DuJX/aGBa6D9xmLYOCH9DVzW6DZZkWV0vdCnZ+WYxtVfwFlkB?=
 =?us-ascii?Q?Fbq2YUQHfQYHFjt76IOl637i039msLCjaZyYPDpgVT+r8Pb/gHP6WG3JutMC?=
 =?us-ascii?Q?Z4HtLvzOmp+wbzALgyzQ0iZn5h7MPehlp6aXfyYebmTK0deuuoDK3rMbHvCc?=
 =?us-ascii?Q?mmlRVrfcKVhZ9G1IukOzFHS6NAsuvhrO+0FtJF4HSnWYEoq8zK+OBDPI3juh?=
 =?us-ascii?Q?+1QIn1aYo6XbLXDuY5OzFeXYsjB9TDbOYW5G96o/ExpbxGjh2SeebNAPdHLi?=
 =?us-ascii?Q?f9q79vHzIfPZ+aOyblCUdzdskaoDUQye7TJs5uhxF1DEzL19OHA+PfTXIVtS?=
 =?us-ascii?Q?guyk/tkf5pOm+xTxczxIQoUEVncd5jvGrSODSjrNTQlSR++r6kv6KIj9VzEn?=
 =?us-ascii?Q?Iyz1mgxl5LttTss4fbTtKSK5ytTQf296jG47FIzY2o3khjLPzSLL5KAZdsnn?=
 =?us-ascii?Q?UqN6r7NmOj9k4wbXQVJoIw+zhQ+c0AyoD43PujclZTAnTLfLMwnlfYJ9qCCd?=
 =?us-ascii?Q?vmsUnkScxOH1Ir91I9pC87gSzCEsIkLQqBt5GQCciXqE19wcyjG5ikt/rT7o?=
 =?us-ascii?Q?lnD4SiexCJ+RKuLsegL1VnDabSO5go8oDFfQpX3sk4DfmghgacyHR3oBusLz?=
 =?us-ascii?Q?8muqPFlsmXmleGlabLuWLgDVwlDyH7ixZxjAXaTy4z2Fe3bMokV34vVHnNDs?=
 =?us-ascii?Q?KqXuNGTtJjDvrcSe+1LDzfzykKEEziqfhKwNENmRBP77EP0tlPFq2NOB6JFT?=
 =?us-ascii?Q?ZcgxON6K+/Z7dybcWZd3OC5PsSrgX/pJjc26q3smN/21vFxUX2mF8RnyoEuX?=
 =?us-ascii?Q?IEcOv0N8lO3iLYGOKeGEEc46GfEW9iYR/OQuQ1+xwe2MWtTXVVzYY6sNu5e2?=
 =?us-ascii?Q?j9m7R90EuGAP19YfSYJtFPfrX0gjlIvC/FKGAXP12ISW4dRMu9xEQ4Ui2kpM?=
 =?us-ascii?Q?b33jiEiYoqmpAbJboiB9eLoF1d2+7g6PQyEcKQqD72btzz+PRgJgR6EgU89R?=
 =?us-ascii?Q?1ddmfv/p4dV1gRUZFoyVIrwW3oIysdj/2w//NmwSSgn1gg5UgXra+AeD7qp7?=
 =?us-ascii?Q?e6g3FoucCe2Ujyp9M4bmN3mm+3Ajd7Jj176EZ1Ze64FhXSHIm0CEU57ltebY?=
 =?us-ascii?Q?Kfqr0ZIztcrxU7/GMpiK6ebGbDXEWltGMuAYLsMRbf184/xmCy+Z4kj1DYDj?=
 =?us-ascii?Q?lBi9V0SX7LaruLaA35AlEb0MNCKyB21lNmYDEF0nk+5rOWZQ7YhIW5piiuJk?=
 =?us-ascii?Q?IAFA4fL4ACqosfsWjOgdafONIyJl9Bkm9vAThmx7dVCR6YqBp5QhtPj7dSgK?=
 =?us-ascii?Q?Epi1pKQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ofavroy1XnfDc5AzfVEZfqKb6oIY9c6JTXFYRmkx0WZbEOx4PK1Pc90EUde+?=
 =?us-ascii?Q?VyHz87aMmjpP2OeD/Jolk2pFoH3RP1kKc2YfF1sJZWVG4+cpMbvOVAa+95ES?=
 =?us-ascii?Q?ionnDckGntQKfbpP+1g7N4WgiLl+NetHAH0gFvAvz2J5YBw5meclqPfAtawV?=
 =?us-ascii?Q?ZgSqI+SBV8lCuCnIlDvGfa10Q8JqKDCbajfcZ0QL1CEl/HXpAcOeptArn/Fy?=
 =?us-ascii?Q?izTYGpo3ZjGSI8SUzhvIkF8uL6BsLO82gccfIOQ+HiLA45j+4dVqUgJtAUVz?=
 =?us-ascii?Q?zcP7SjAOoBPwaVMJmnO/siXSXcVj1zpCrHv/nHc/OCukE0BrSUccqxoE4WcI?=
 =?us-ascii?Q?XtuRJxuxAQnZv4+Xi0vZ68Xw1i8ydAcEQj+u5c+2TsyX3i+5QhoJKcpiuyzv?=
 =?us-ascii?Q?VpPnqkSJVYaqgxWhlQnhOHvRVKGa+qumBbfDWVj/gOyyzT5DMLaTWjapJloN?=
 =?us-ascii?Q?Pg4aFg8bpGvsccKuBfFFipQhWsD0BK3ZoQD0V0RQPzPpr1qdn8KoEMynYy1y?=
 =?us-ascii?Q?bJ8OUWiJpYtdk7bameb/RARBEPUbVpvCh8AC+KAfgnlokjW3jsR6/NiAslKc?=
 =?us-ascii?Q?VP29mYDGrJWPfCMg7GJVU+84OvD3Fr6y4MUwb/0MgWdzXDoFz8NkSaN744DL?=
 =?us-ascii?Q?rQERj0uMU+huhkw98m0/IFjtlVCxYFxNX/tZS5gGNegvczOR9434jTFPD8ua?=
 =?us-ascii?Q?505hOpNFd6yxOKgGwUK/ozvqsuOO4OxBuBe4kFK6cWJDSodg+ZgT16GzHRp9?=
 =?us-ascii?Q?C0ULnW0OGpQmvMvkCZm8FRhJHurwCfDCEuY0nbRxnKnWkfKLfTMjtnDT3x9Y?=
 =?us-ascii?Q?k6uaieNumc9ncol2gtZ5xdSbUuNmYkeCYKg+1+pfnaDyZFPpAV6gJ/17NIaj?=
 =?us-ascii?Q?cAsw9Zv1Y2BDl0sIfpqzqQE+3eVy/gNjykZkaQly7Bo3RimQlCfgcvDZSg43?=
 =?us-ascii?Q?Vn5D59M8Lk7GzN248JFGnS88MZO0zdk2DWwEC7xhtqNQcYgYmOH+erBQMvC7?=
 =?us-ascii?Q?4o7Uhx5yniMHGK4dyt6b66OEy5z9DpcOV8c4iVUOHAYaW1MZrpXY75ensYIJ?=
 =?us-ascii?Q?s7wFP0NUVL7VhT1iroUEmsJMTMdzoPZdCoPu5oZMBY9afhggCgG2EcZvvx16?=
 =?us-ascii?Q?wnKxvjQrBueZMtPOMKwxSR6+wWSnuwYa3cs9a7Tsy6TAXL5NJmErB4lCdaGQ?=
 =?us-ascii?Q?S243dyoyG7N+5A9h0f+gYqBKXZNHFL9UzylX8X0EJr91zZMq/VYa/9bxpPiL?=
 =?us-ascii?Q?NDLzmbv/DtYp6UcEnYz/T/9Pf3JtksOitcKWWkUyjrP5zqTklx5u/kMYOCpl?=
 =?us-ascii?Q?RqolZHauG3TsjcuiYf7Gq7L67TpWkoi9dCA7x7nMC30FQP5zo4Cu3gvd/JXW?=
 =?us-ascii?Q?sIbVd21OGUWxW+nuDDI7cFPDDhgwH55goWFRsUaSV5zymjg9iqfc/Vd3VeFP?=
 =?us-ascii?Q?S+4Cl+R+JPVFyqjhm211OOEHHTVGEJNRddfc3J392pt0Se3iD5k+unwRSjV+?=
 =?us-ascii?Q?bMp3SJhR196TIeMHltqYGjbkTtnyfBKMngc3vnHSaFfVfeUoPB/lUuEh4t+5?=
 =?us-ascii?Q?bZnLldoQIcGOAaT1DXT0Nf3Mve8HiJXRmB5y5SDH/WnumDsNaP281CUKgRMx?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XDEJufNTbQ3zdV1/73xl6NlJMfdjXc2abv6BNQUZsFJQSXJb4vsuzOgQR5FTLs0mpPjoUXzb2Is0iA/nq9c31ZwOrHeDVsb98p5dPyHq5aemr2IWy3XEkQANaMVZsTa1lQtaPa7bF36VfTAtfXmkkJM4MyYeC8D0Gy+INqR5dlf+lBdglq0aqTFg8osyu3VbduUpTljLi6X9RyCercyjb9wipB3dV/Fv5kJE1s4FEMHlcwW9kQtfEGPhrdksoY4u5EKXPt4NAAeOZpvg7bDqAI5PfivwlfOVpFT0KbGkPX2rTwd/GwpAth6m87jAvvFrzXuVrgiy7wbqazl63Pr2AERMe7XvNOf9pFgG0yADVW0ngikiPVvbuMkJjkY5uVcbzSrqs8veT1HHhrS07hYgq/EeRWjPoisN7AXcp1qMSwaoRuVlw5rY3NllKcjWj3t0Lu2g1FZnAlTVo8mQG9sAc7LMVrY2gd8gvfK66QbZlDSTxM8mqtLeuTCZGa0OmkzHOsLDnTNXsQL+MKCKobg4HAiu1I6JukOWadToMc1Lmr25B4Gs/mjz8ksBj1SYGDgI7D+QL27Bhx3d+HyeNdyIb3N2HEHv4tpxUBsAY15w/6k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b9bf99-9dd6-4af8-a7ef-08dd0fbe3c41
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 15:06:28.8205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t983o9dYim50ZWk7OFsBtBOIaiUj4dKTYjqsrcNK545CAzRUhrF5Y6uDVIanfipt44XBeXE46N7Us7UIzi0DJTnx/39vBwIXR4ZQddrr0zA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7958
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-28_13,2024-11-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2411280118
X-Proofpoint-ORIG-GUID: 25Myjd7UpdGfHX2JGNRCTFL9VbzoU8Cx
X-Proofpoint-GUID: 25Myjd7UpdGfHX2JGNRCTFL9VbzoU8Cx

In commit 158978945f31 ("mm: perform the mapping_map_writable() check after
call_mmap()") (and preceding changes in the same series) it became possible
to mmap() F_SEAL_WRITE sealed memfd mappings read-only.

This was previously unnecessarily disallowed, despite the man page
documentation indicating that it would be, thereby limiting the usefulness
of F_SEAL_WRITE logic.

We fixed this by adapting logic that existed for the F_SEAL_FUTURE_WRITE
seal (one which disallows future writes to the memfd) to also be used for
F_SEAL_WRITE.

For background - the F_SEAL_FUTURE_WRITE seal clears VM_MAYWRITE for a
read-only mapping to disallow mprotect() from overriding the seal - an
operation performed by seal_check_write(), invoked from shmem_mmap(), the
f_op->mmap() hook used by shmem mappings.

By extending this to F_SEAL_WRITE and critically - checking
mapping_map_writable() to determine if we may map the memfd AFTER we invoke
shmem_mmap() - the desired logic becomes possible. This is because
mapping_map_writable() explicitly checks for VM_MAYWRITE, which we will
have cleared.

Commit 5de195060b2e ("mm: resolve faulty mmap_region() error path
behaviour") unintentionally undid this logic by moving the
mapping_map_writable() check before the shmem_mmap() hook is invoked,
thereby regressing this change.

We reinstate this functionality by moving the check out of shmem_mmap() and
instead performing it in do_mmap() at the point at which VMA flags are
being determined, which seems in any case to be a more appropriate place in
which to make this determination.

In order to achieve this we rework memfd seal logic to allow us access to
this information using existing logic and eliminate the clearing of
VM_MAYWRITE from seal_check_write() which we are performing in do_mmap()
instead.

Reported-by: Julian Orth <ju.orth@gmail.com>
Closes: https://lore.kernel.org/all/CAHijbEUMhvJTN9Xw1GmbM266FXXv=U7s4L_Jem5x3AaPZxrYpQ@mail.gmail.com/
Fixes: 5de195060b2e ("mm: resolve faulty mmap_region() error path behaviour")
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/memfd.h | 14 +++++++++++
 include/linux/mm.h    | 58 +++++++++++++++++++++++++++++--------------
 mm/memfd.c            |  2 +-
 mm/mmap.c             |  4 +++
 4 files changed, 59 insertions(+), 19 deletions(-)

diff --git a/include/linux/memfd.h b/include/linux/memfd.h
index 3f2cf339ceaf..d437e3070850 100644
--- a/include/linux/memfd.h
+++ b/include/linux/memfd.h
@@ -7,6 +7,7 @@
 #ifdef CONFIG_MEMFD_CREATE
 extern long memfd_fcntl(struct file *file, unsigned int cmd, unsigned int arg);
 struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx);
+unsigned int *memfd_file_seals_ptr(struct file *file);
 #else
 static inline long memfd_fcntl(struct file *f, unsigned int c, unsigned int a)
 {
@@ -16,6 +17,19 @@ static inline struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx)
 {
 	return ERR_PTR(-EINVAL);
 }
+
+static inline unsigned int *memfd_file_seals_ptr(struct file *file)
+{
+	return NULL;
+}
 #endif

+/* Retrieve memfd seals associated with the file, if any. */
+static inline unsigned int memfd_file_seals(struct file *file)
+{
+	unsigned int *sealsp = memfd_file_seals_ptr(file);
+
+	return sealsp ? *sealsp : 0;
+}
+
 #endif /* __LINUX_MEMFD_H */
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2bbf73eb53e7..043689a56e8d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4090,6 +4090,37 @@ void mem_dump_obj(void *object);
 static inline void mem_dump_obj(void *object) {}
 #endif

+static inline bool is_write_sealed(int seals)
+{
+	return seals & (F_SEAL_WRITE | F_SEAL_FUTURE_WRITE);
+}
+
+/**
+ * is_readonly_sealed - Checks whether write-sealed but mapped read-only,
+ *                      in which case writes should be disallowing moving
+ *                      forwards.
+ * @seals: the seals to check
+ * @vm_flags: the VMA flags to check
+ *
+ * Returns whether readonly sealed, in which case writess should be disallowed
+ * going forward.
+ */
+static inline bool is_readonly_sealed(int seals, vm_flags_t vm_flags)
+{
+	/*
+	 * Since an F_SEAL_[FUTURE_]WRITE sealed memfd can be mapped as
+	 * MAP_SHARED and read-only, take care to not allow mprotect to
+	 * revert protections on such mappings. Do this only for shared
+	 * mappings. For private mappings, don't need to mask
+	 * VM_MAYWRITE as we still want them to be COW-writable.
+	 */
+	if (is_write_sealed(seals) &&
+	    ((vm_flags & (VM_SHARED | VM_WRITE)) == VM_SHARED))
+		return true;
+
+	return false;
+}
+
 /**
  * seal_check_write - Check for F_SEAL_WRITE or F_SEAL_FUTURE_WRITE flags and
  *                    handle them.
@@ -4101,24 +4132,15 @@ static inline void mem_dump_obj(void *object) {}
  */
 static inline int seal_check_write(int seals, struct vm_area_struct *vma)
 {
-	if (seals & (F_SEAL_WRITE | F_SEAL_FUTURE_WRITE)) {
-		/*
-		 * New PROT_WRITE and MAP_SHARED mmaps are not allowed when
-		 * write seals are active.
-		 */
-		if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_WRITE))
-			return -EPERM;
-
-		/*
-		 * Since an F_SEAL_[FUTURE_]WRITE sealed memfd can be mapped as
-		 * MAP_SHARED and read-only, take care to not allow mprotect to
-		 * revert protections on such mappings. Do this only for shared
-		 * mappings. For private mappings, don't need to mask
-		 * VM_MAYWRITE as we still want them to be COW-writable.
-		 */
-		if (vma->vm_flags & VM_SHARED)
-			vm_flags_clear(vma, VM_MAYWRITE);
-	}
+	if (!is_write_sealed(seals))
+		return 0;
+
+	/*
+	 * New PROT_WRITE and MAP_SHARED mmaps are not allowed when
+	 * write seals are active.
+	 */
+	if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_WRITE))
+		return -EPERM;

 	return 0;
 }
diff --git a/mm/memfd.c b/mm/memfd.c
index c17c3ea701a1..35a370d75c9a 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -170,7 +170,7 @@ static int memfd_wait_for_pins(struct address_space *mapping)
 	return error;
 }

-static unsigned int *memfd_file_seals_ptr(struct file *file)
+unsigned int *memfd_file_seals_ptr(struct file *file)
 {
 	if (shmem_file(file))
 		return &SHMEM_I(file_inode(file))->seals;
diff --git a/mm/mmap.c b/mm/mmap.c
index 386429f7db5a..b1b2a24ef82e 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -47,6 +47,7 @@
 #include <linux/oom.h>
 #include <linux/sched/mm.h>
 #include <linux/ksm.h>
+#include <linux/memfd.h>

 #include <linux/uaccess.h>
 #include <asm/cacheflush.h>
@@ -368,6 +369,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,

 	if (file) {
 		struct inode *inode = file_inode(file);
+		unsigned int seals = memfd_file_seals(file);
 		unsigned long flags_mask;

 		if (!file_mmap_ok(file, inode, pgoff, len))
@@ -408,6 +410,8 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 			vm_flags |= VM_SHARED | VM_MAYSHARE;
 			if (!(file->f_mode & FMODE_WRITE))
 				vm_flags &= ~(VM_MAYWRITE | VM_SHARED);
+			else if (is_readonly_sealed(seals, vm_flags))
+				vm_flags &= ~VM_MAYWRITE;
 			fallthrough;
 		case MAP_PRIVATE:
 			if (!(file->f_mode & FMODE_READ))
--
2.47.0

