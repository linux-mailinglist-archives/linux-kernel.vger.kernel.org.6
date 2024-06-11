Return-Path: <linux-kernel+bounces-210393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6823904315
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 20:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD4561C20F28
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 18:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866B681ACA;
	Tue, 11 Jun 2024 18:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b8HQwjlG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qGr4oAUc"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BBF59162
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 18:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718128959; cv=fail; b=bjd9II7PIIOHOgEczFtgZsTA/7DU+Zllg5555wD3cvME58x03/oSH9DSzLCZ2iFWQtJbedKc5iSbE5so/fFIamoF8SHOjzJ6KQmt2cU1AJ8/VP7vQ9u/iQ87GJXArpQRdSiLs7G+bNdOwOzpMr9DjH5KqjSrGzYaHBzeEHO+NuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718128959; c=relaxed/simple;
	bh=ige4gjkJgBojvifjpmFqPADl8rqQyWYK4vlX3BABb1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rS2GzNIL6D/1k89rMm10S1SGBGVg3+S8XSTm/8f0A6upXPVEoMp2x3tmkH17rBDLW1Ql8kK82RZ/dUDPdrvEs9q8hyTHA8mHn2kQV1cmvnBy8kGALlTZU5JRsPHgtmit+cE2/v9APr7MJ67IbPc7CEO54Eob8zrdy+VAZal07kY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b8HQwjlG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qGr4oAUc; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45BFqPDK026906;
	Tue, 11 Jun 2024 18:02:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=DzwidLfB2+Oj4+gECndOMyGaNu4vWwb1mc2Xd3lGz3k=; b=
	b8HQwjlGnarCPuefJnRVLTOazKiTqg2JJ6eJ2gbqgUSOALvJF6BsBJPSxdRz96mk
	7f5pbSkgMbbKYJ1gEIWhU4H4UTpbnj8AXpL4YVT3LLALbG73/pppABCFpPXU54jy
	9xtxKwVdclwoPObIWlQiglwn5tdnE76MFxouGAAlNRsrSZfSP6zjJVgXVzYNCxJj
	IwYDCGJo5CgzxbAGk+wLu8kVyyHCsGgkW3z3inlwAR3sFMd+HlaIdxXrvaJ3Eupu
	5ioW1MEGDpZu0DRIbIFKJ/RkvbOUzka2QKxE2ADHMFlB13nFNbXmVbKcr/YWo+h4
	S1HYXHv/dBjz3IA3i/886w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh1gdh5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jun 2024 18:02:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45BGbsre012576;
	Tue, 11 Jun 2024 18:02:27 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ync9x86xn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jun 2024 18:02:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WVcVZK7pelpYaH/RVTAH6yp9cN/XTIvAMF3RW1mhURKuz/fxBwSuI0OT5ri6Su2l+SufhzmPd/J609bFFOzC0pgKROprN+md8Uy977XW4oKOiUXrCYelm1+hYgjNRNlFUxUUwbFwma3jP3mL2Tg5H/dYARZDlI3a3G5N/wZaUi/rmvkmptqDeKfWtOkGYuTpWwo/yLFtN0f0sZBFcBHMap37wG2zGH7oDnxGmBrp9eWXdRDHk3UILVztnlRFkNdubnXFyk/6k5Fy9XIeqzsbGRmLvtZAy4rce1GVFaqt/vdbQD9HlKHDkpF/9FyBL2W4iduGF3giPaEluASJoSuatg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DzwidLfB2+Oj4+gECndOMyGaNu4vWwb1mc2Xd3lGz3k=;
 b=lt/L1RDPjiNngtQoBtiNIzexkpfx44XwPs06jKl2s7fIzSXfKMkpu5mfX9UAMb/c5wmgdH96QCTknyKzfNPLGkv9OpHpZ7/HAETepqZR9yZLqmj9ZOiTsLyOWqsit6xq7lcwijbPb3p72QtHX4xSYGbOa++5fgaGQfejqLwfJvFvXapMVAOxr1q/Hv/P08SPKJv7y2PYii6PVeGNIdsqqxG5tr1lAMxf3vNUPGGsKP71AIG6jqLfYNnmYFXXeh9zdgu9scfDloqb96AXBgNONtYu6a4dE1PcXeV8C63Qv7oYasMRipYvdZcn0ZYAI+esfMFrpE+hTVhUixxbmlYiCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DzwidLfB2+Oj4+gECndOMyGaNu4vWwb1mc2Xd3lGz3k=;
 b=qGr4oAUcHsiCt/GA6uvWkJVHCHCDyn8Yvq6qPRuIVa2T8/2hXXmdegJuKLFCHIgkdR1e5B6i9+JHyJARSnxhKWxxg9DyeY+s10C1kJiA9MqC2zypJCJFho4fWa1sHwyhsT+uCQulO4HiS15pQTnh12bX6l6RMqPhm8R3Ii6sAVo=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by LV3PR10MB7817.namprd10.prod.outlook.com (2603:10b6:408:1b8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 18:02:25 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7633.037; Tue, 11 Jun 2024
 18:02:25 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 7/8] mm/mmap: Extract validate_mm() from vma_complete()
Date: Tue, 11 Jun 2024 14:01:59 -0400
Message-ID: <20240611180200.711239-8-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240611180200.711239-1-Liam.Howlett@oracle.com>
References: <20240611180200.711239-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0028.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::34) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|LV3PR10MB7817:EE_
X-MS-Office365-Filtering-Correlation-Id: 8378824b-18c7-4d01-6dd3-08dc8a40a63f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|1800799016|366008|376006;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?dMVU7J/jJ0bQ00uLB3NSnV1oBVOBSJK8RxxjPaqZQgNBHKVbNHo0QFTQrLfX?=
 =?us-ascii?Q?FC6v/sq0864WFC/EgeAEvhikMEOj834XlwHLDRKBFhtQRiXXuFxmY1P1u177?=
 =?us-ascii?Q?057OKD+V/rSyvMxZx1t8r1PVboLO6ZWV9EVJb2LLsgJZH0SQmwdnujKjwU0Z?=
 =?us-ascii?Q?WOmC3cqdy3g0tUdjJ04Df2kQZfv4F3RasZ7M8ow0KkDEISmv9Qu9ZoznbS0t?=
 =?us-ascii?Q?1GJzwBSrvQ/leinPnTfQX0eFcZmjM9GcpsFgOLbJGhrhUBd+dT/MZDwLOxA6?=
 =?us-ascii?Q?hIh9gm5Idx2UT941cBGmmeYXW/5m1HSRiY2hltl3biHdLveLVZlldZPrGQjQ?=
 =?us-ascii?Q?RvK3eMAqBd8jy27UTpbNxAg7cz8Nd5H8Ys/EPPvXUhny9UWJtLf6cjvBd/9p?=
 =?us-ascii?Q?zxFkM8fJkGU1pxJUefnK2rPvwbHOCaueCiwCSDKM9KXRKaUceVT3T4DjrYVW?=
 =?us-ascii?Q?Pvv2ik2vQQonsPXVYxgN4lL100KR6gBluIHozWUPmvROBPC6goyRa2dOjfZL?=
 =?us-ascii?Q?JSqH3WTwdihvsz5Rq44KoY93TkI3baNlGrUYCIYzsUB4KlAhij+DwkVa5Y6G?=
 =?us-ascii?Q?j3TRJMhxXK1JwsC+NxII+3VZXvWU1ug5ln/bLhOxh/H14IwH+fH0aDhGY0sW?=
 =?us-ascii?Q?DRqkyQaumgeNFM2BmfMGpwKdLYS6aZRTxNxSV9D5bmWLvXdoEoGuNhASCmBh?=
 =?us-ascii?Q?Ox4Cw3GYYxH4YHuo9ybWdvoyV/M/0utr6+UqoeXO2vH8a5NZXYW/9KTt0rHG?=
 =?us-ascii?Q?UDt+Zo1xV4lFbdGIya/83VPP3Zy4mYxSMdosSba+lCP06JtNwjlk4yy/fYx0?=
 =?us-ascii?Q?d2JI9ABlZKIaAE/1eiiOyhZ5hhZe6gFuKfQocKM5IsR0n+U+lBhLCs7HtQMx?=
 =?us-ascii?Q?tbjiMBjJjcixiHe7aghtqEORVY+7UWbFX/yj7PGVb49KExviTI2JVeTDZPj8?=
 =?us-ascii?Q?jSclmm13aeNV0cv7CQTFzGEdXBq2oWYUt5XBGvjvJg2GjVnUBmcdeCFmovE1?=
 =?us-ascii?Q?IlP8IxkiQt47pwAtbE8IHMeQQWG0MB6dD14pvNJTpuZMl8YjahOHBsDgfAre?=
 =?us-ascii?Q?ULvO44LkHbMab2gkdwH69/r/05N18QNpZ8R5xaEUZGnjo6HimdNmkY9ffuu6?=
 =?us-ascii?Q?ibVY0D58i58ThifTdFvpcCEJrEWVldMZ7j5Ek8nDpvsKGdCJ2ZWvK5pjFFUQ?=
 =?us-ascii?Q?lk4LPuosTeuKCLY38qp1B11iGf7jMBJpzi7F9BJfJa0kPY/SoaS3IDhYbbHa?=
 =?us-ascii?Q?sR0DIhL6dm4iXaUcr9EJuJIWIpIdQBT3s5HCXTlJjCAWq0R6uEhJvbVM7u8S?=
 =?us-ascii?Q?lijB8RerW9UpEStAC6HgmAss?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(1800799016)(366008)(376006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?VNQ1vRrzmDRQ5I+BOLrqOrqSHqbMgYvB8WScX+YZq/Ebwf+Yw4yvfqlq6QX8?=
 =?us-ascii?Q?eJX3pz93g2epm/tfj3P9vN3O8j59VY/2U64nAv9rDVd8FNs5WAf+zYzGcG/6?=
 =?us-ascii?Q?0b8V/OqDje9rTDI8w9mWedMC0pmXRkRKv70PnbBnpR9DS0KEMMYub0tpRVqA?=
 =?us-ascii?Q?dArKOw7CShBl9TCqCtx0AgvmYXDgKOnQCa1yvGq2TJZXyHVFN7/nsmNktNI4?=
 =?us-ascii?Q?6F9BHPswA5RQpJbmJhsPyBBndfurizHGWbVU9eLuJqcgkxlukNulQ9cHMZVy?=
 =?us-ascii?Q?onCLPFW7VJvhHDgqrNZWdLdQozBjYA1ulhJCPwyUEbRMrBkpO1SSTFx+QYsC?=
 =?us-ascii?Q?3cgwPsSdKbGz19x/60n79pEAh1V03yrKLB7shChtbOAt5DstLKNgoVIhpzTf?=
 =?us-ascii?Q?q5v4GhiGOOfhQldwDvalqLuPSWMTWylNNmA3dY9V0K8pBk3ycD700GudjXtC?=
 =?us-ascii?Q?mh5AwYnNJtcuBQpCDcaMxcjeR/8HFhVDQYL/yzwHxmsMAivgUR/g/ixAqpdj?=
 =?us-ascii?Q?l4Y1/ZtfNYuY4kCj40YTSAowyAacA1s3dxQW/vul7zGhD6czJYFhKKejChZf?=
 =?us-ascii?Q?HJ3M/yA/nKbBpqTDU2M9OTdfhKcC6JQE+GveMTZX9gIS/vEMrnNuf2r4BTsJ?=
 =?us-ascii?Q?7PnKWW1vmZKyL8sZdvK8qv+OladGdLYczsVNPwNColgAfHUbTxExA6+1mf/D?=
 =?us-ascii?Q?G9nYIS6LXZF9tJwFaoach9lxgs0jL6J4lOIIHnze+3GHuaCk+VRr00n6A/ya?=
 =?us-ascii?Q?8YTvcOcM/s7wp12EX4y5WIYqOfBdIkp6Q7sGV3/K8JU1Q8DY4oWIyApHti4F?=
 =?us-ascii?Q?zIpocll800qn3ZfxSmiF3KnHM1AHuj//IkKxdCkB0duB9joMlExuwZ/lo5pc?=
 =?us-ascii?Q?7K47Mhff8bMmUGq/FdLr3a50LonooLxsIFUasJVqUM1vfmWfWIxEcB60LLd1?=
 =?us-ascii?Q?1QIqM8Sb84xIkyhGob5QC6dd0GOQYbwMprvaKKD+X7V/aGl77N/4O5Ry3oUp?=
 =?us-ascii?Q?lQfvGHZ62PRX9o20XAMU3EJzbGiIMX/n+pQUAcfhoi7B69OLIik08S5UcTiS?=
 =?us-ascii?Q?mJ3YPkpcbHkrjm0tar+xR59ZDJVt1aaIuVMBuUmKE2Dvmx8TZlFJ8AnW9tqP?=
 =?us-ascii?Q?VVmF80fyKDZrAwbcedDXu06hb2em3dlm2HC3IRG0S33GA/ocOE/SpCY83A3Z?=
 =?us-ascii?Q?v6uF43k7OcNU6M4p2rHv0NuwIta22lDwcGBTKuZw3LndNZoLtOVLa5Jdzb5x?=
 =?us-ascii?Q?D6gLOYUlHZ/YrAg2M3X8cQxm1JL8OXr1vXK2aBH4xfmQPw3simQnq+7V3Z8Y?=
 =?us-ascii?Q?Fn6VppVFJmaehTGMCW/TriN+6Der/lYQGQDSPGiEEJWASzcJzHVZcInRcv2S?=
 =?us-ascii?Q?NYNJt4caCSiQYu7AgNLdsVwawpwllvL89K14vnDYp6N9EZox6lRZzr1Z8MQY?=
 =?us-ascii?Q?eg/Bw5RDR6wiQjnHE/kj5Pf7w0901eDfAZLdvuH1dcqBKFno20X5Z1m2XkLF?=
 =?us-ascii?Q?ExMmBKcWtkVC38A1xRJfgWMPNREGm2v1PWKO6Y4fbwhiA1/W/AcxajW3BSVH?=
 =?us-ascii?Q?7diiWnsoN4kq51kHc2c2y27zJp2+R60ZPJ8OYxFar3Qm8lZWv8kuMIa93HCE?=
 =?us-ascii?Q?sg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	+aTpRKI4Be8pr+4jI4QJGAvqKugDsgk8TgdR4X2kmqMddjXldK1aiS6ldC2YHnRXYdpxYYgG/BUrHv+ilBduzF71LKDETDtLetHXtgyfya2gX5MUld6MqAohjpnVJepOMNz4vo1FfhlosPJJMaEmTws+RPtYizH4xWCE7Fdwch9pYpxXnrx3PFiIAq4Tospmnx8SpS7kEuRb8l49JvsZnIBFRya+cwtVFj7xZjgCf9MBR6lvNPMPAAKKVEB48r6X3a6i9OGltVUetdGYpKgQsL8yniQI6LE/xN4MycxltZxHR2vS2kl3oLLULmDnt1+XCg+cgtfF6gQsKWgYOTUo0HR2lGmEFWvHSCU9OYFjq8XSvGbfOCrT1VTX1ciM/6B7iB2EA1ja2L6jJDnEeJqsLtajDbgwZ8zx2j/kte2BIsDF5KsY3MY89zgnqvGUAzMo7Pv6xRM+TA4zVo2T1YuXpIZ21v3dZd2yx2rKrwgULjHTJyJlyBrz4fLIdoxs33UhoS0yv2nLosQj5GK9HvkkqKh3wv4sAw3yxOCS3b0/VTtzRAnRuNzIYYmtB8WlqJYWWy+oKHiCCZCq7RDLFtsCgJGKevNnAUbIdaWnn6S4WYg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8378824b-18c7-4d01-6dd3-08dc8a40a63f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 18:02:25.2374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /0d3TzjGmzFbQ+5k2hRd2pg6/B1S6mBMf9n93T0B3tqEB/asqVaj7dU4Fu3xKs/no3KdX11FEwVKCFleyTRjXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7817
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_09,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406110123
X-Proofpoint-ORIG-GUID: U_PXfPpToUWq1fxUhMUwCixk-rr7Ugv2
X-Proofpoint-GUID: U_PXfPpToUWq1fxUhMUwCixk-rr7Ugv2

vma_complete() will need to be called during an unsafe time to call
validate_mm().  Extract the call in all places now so that only one
location can be modified in the next change.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index ea3edfa8b22c..5334077964b9 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -605,7 +605,6 @@ static inline void vma_complete(struct vma_prepare *vp,
 	}
 	if (vp->insert && vp->file)
 		uprobe_mmap(vp->insert);
-	validate_mm(mm);
 }
 
 /*
@@ -693,6 +692,7 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	vma_iter_store(vmi, vma);
 
 	vma_complete(&vp, vmi, vma->vm_mm);
+	validate_mm(vma->vm_mm);
 	return 0;
 
 nomem:
@@ -734,6 +734,7 @@ int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	vma_iter_clear(vmi);
 	vma_set_range(vma, start, end, pgoff);
 	vma_complete(&vp, vmi, vma->vm_mm);
+	validate_mm(vma->vm_mm);
 	return 0;
 }
 
@@ -1062,6 +1063,7 @@ static struct vm_area_struct
 	}
 
 	vma_complete(&vp, vmi, mm);
+	validate_mm(mm);
 	khugepaged_enter_vma(res, vm_flags);
 	return res;
 
@@ -2440,6 +2442,7 @@ static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 
 	/* vma_complete stores the new vma */
 	vma_complete(&vp, vmi, vma->vm_mm);
+	validate_mm(vma->vm_mm);
 
 	/* Success. */
 	if (new_below)
@@ -3308,6 +3311,7 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		vma_iter_store(vmi, vma);
 
 		vma_complete(&vp, vmi, mm);
+		validate_mm(mm);
 		khugepaged_enter_vma(vma, flags);
 		goto out;
 	}
-- 
2.43.0


