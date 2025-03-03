Return-Path: <linux-kernel+bounces-542458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A14A4C9DE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B8A917B46E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D30421577E;
	Mon,  3 Mar 2025 17:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HWO7Same";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AFkPlV3i"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FFE7080D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 17:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741022482; cv=fail; b=s2ZkjljDpcy8Kpckl82DgDv/tkailTYcSeV6SPKz2rZEkouzRxy5UuOQDuTYEMEVFaBglPBgyQveIV3hMYUs+La5y6GqxaGyS4HHnVZ1IcdbQukWI7SnZRG3Z4P98324TJDPw7eni9hDHOYFUB2iEaTSm4HTZEykKyMHBlCLRrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741022482; c=relaxed/simple;
	bh=9J5WY0u6KuGaqAo6vAjjXohudtZ3sRZtCirzjtLNoNk=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n34qPhC6lkKKckcGvP97liv/Iekuy+qnCpLDSsIvmYC7+h7d4m9XBzk+f48eHHnnZD8vsk4XMznMWH+FnNhcW4DTfNuoWpnjGeMPZd+1seUoQT9lOo/jcI43bbKuc7g3Njk7rbnMWzPSBQcbGG1FCq09Wzd+rXouJASru2mNF9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HWO7Same; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AFkPlV3i; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523GND1i009341;
	Mon, 3 Mar 2025 17:21:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=2KfHG/+djPGuwu3sGo
	9MYxfA2FB/96ZF9FoGwQcG+tI=; b=HWO7SameDvEDTp7EgINusr7LeCRaaKYeQh
	iyKoThEW6uDYOf75EMPicx4ACTd7oWvJqZ2Qn7TiVzTeIJko0feCqMYJDRniwNMf
	+Vxj0cwHikzd78whmx/DnrMISlapFMS5UZZvkGZYzRJXHraN+5DRf9SF6zNM32d5
	lpHlpDAG6tFHyot7mAUIaaLDeb7x/Ym4tekujIpkEtwO2lokVy47Xp3ltidksdyX
	JGCf6BkPWwTCZtKodfBZWoOxXfGfdx89pZ1X16YCHFg4WhtppgfAKvz/t/WsiRqQ
	0QmnMh6wAsRIFaXgvOQCtAfT0HhnewcacRA5bdjQNb/fipIw4CTQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u8wk5kj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 17:21:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 523GHv7R038909;
	Mon, 3 Mar 2025 17:21:02 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpe1usv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 17:21:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JzJ2oyOsQhc/0gz8ozhivskjzAJB2z67HErlWlIGh+DULgK9ePhM+C5hl7nQf55Ix4rr/qlBwGBT/xQ2wbYrcXKmVchOamyS5yZSg5BPQV94R2YQ8rOpE7tvcUHdaPwXSVvblWjhM3Q2w4r/MbxNQjsh6lgyE2HxX3hzfWU3fDWMN4mAIkL7ominjXX5YHe4S3ZxrEvwHFlrfsxFtWHe/2xVM2bIykQb+OFY8VTayn2PVwcBoaQQjgD2A7GrW2xx+iHQWUsC4WsvmvdBq4iAETkHqh1Mj1pRoNNMrpCysc/gPmQm7ug09EkvyYVALvEGRxxYGetHey4Qd1tG+iiYUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2KfHG/+djPGuwu3sGo9MYxfA2FB/96ZF9FoGwQcG+tI=;
 b=Ib0QvZ531xKAlFY/zNQdflg2H2cqjv78YKUsLGTWle634SyN/OkltVVROF0rDT3N+7/90BuigWT9iLHJqxCERONJi+es6XCtvwdQW/5WYDWo0/ZWk/gh9NBkIDGy9PBAjG2EwmyJo5cwV3If21z8Iwxxw9yaYtF4/lhiVhHsPIt+gOb7AbfwE/xJH7AHdMU2nim8/YR9hGrRHKTwC72hlmWjELTsAswtZEhVwRAlvG/A0TiZor88rpWvByoNGw3Q52/mdTMELtLv0tHLxagxrebTZN3ETwtl4r7AV1kL/pkbF+I2PUfPA7lkTUoWj3g3wBpB4VsVxNyWTXZuYhILfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2KfHG/+djPGuwu3sGo9MYxfA2FB/96ZF9FoGwQcG+tI=;
 b=AFkPlV3io8AJ0ncASSon+Ye9Q3yxNeAfJo6+u6iPbmMN+lopqDFqwsqF/ELzJMSJMmfkCgfhrTfwsQ3oeu2F7uA9uwEicJPAuyBFOWR73qjCFZ4YzPS/f+PPMHD/BwI+cBZ9OthUgei+cbwSqR9d+G4/EbfwzzR1zVXsMedgbXQ=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by IA1PR10MB6808.namprd10.prod.outlook.com (2603:10b6:208:428::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 17:20:59 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 17:20:59 +0000
Date: Mon, 3 Mar 2025 17:20:56 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] mm/mremap: refactor mremap() system call
 implementation
Message-ID: <658d7d04-af2b-4f73-9408-2fc13398b2d5@lucifer.local>
References: <cover.1740911247.git.lorenzo.stoakes@oracle.com>
 <e6b80d8f58dd2c6a30643d70405dec3e9a385f7f.1740911247.git.lorenzo.stoakes@oracle.com>
 <g4lus5wcyzcfmvcf4w7yzsaej2dfprwttcqdjh5thvb7qgqiso@hl34vyxbuhe5>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <g4lus5wcyzcfmvcf4w7yzsaej2dfprwttcqdjh5thvb7qgqiso@hl34vyxbuhe5>
X-ClientProxiedBy: LO4P123CA0543.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::15) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|IA1PR10MB6808:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b73a67f-697d-49ee-5b29-08dd5a77c3bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XQCynNsnCjDK20OgAeV7slFTYd2gbCyRkzc1T4r5rNVT//kLnGuBck9iCLw3?=
 =?us-ascii?Q?QLMz02m5L3etP8cPUWI4qYt07k2kHzeIRG++XO95hkGKel04WPLCR0/+aQh+?=
 =?us-ascii?Q?RLh37h/vwETcwjpXXmCMO80AmE9iIC8aHdZwGtKc8OXQsK8e74HozPIBrOHE?=
 =?us-ascii?Q?rIeMZmCpdZfDkdySZwhAKwzgGmA9sUXfucURf26xxk0geuQIgt1txo/oVg8N?=
 =?us-ascii?Q?8+mIqhEDJXkAJshIpQPQmGzf3/x/F7AyKtagv3B6mMiDsQeIi4PgEPvhlqK7?=
 =?us-ascii?Q?5xTOVrUHOs8TvpNDNMdPpVyHlyY6hxRAzExhEqfGIEGP7Xnlks0iXllhU7w+?=
 =?us-ascii?Q?WKP9Qe0a8mVb7VwJyQxoT23e0CIIOCglefE5SJKkF4FsnhjeQx4u8IC9xsKW?=
 =?us-ascii?Q?tZfhr1vaTr4YL4pcuS1JO7aa0BGTUxHK6RLvsmSQybJ+hsJBDYRPhFTEh4Ty?=
 =?us-ascii?Q?K3buzy2W9nmCVDUJlIaUV2XRPBmwsIMcBJP4pPjJ3j69zUT9cms86u0umzz2?=
 =?us-ascii?Q?z5Ftmq9XWv/gIb3tBiv19t/9mp0nKOU0pnST8Bx0nHdNqzpnY54UUmmXAQ03?=
 =?us-ascii?Q?3KR3Me7ExBzoBEwf8LGb7W+EtWTte/1x3ROvXCX71spW1VI56uM6wDxF10pE?=
 =?us-ascii?Q?bTzd5yTLwCY5gvy8qPil/weXDapgMvt1gNjLzW0jEkZ4Ef1XGRTij5Vpk9pE?=
 =?us-ascii?Q?WVsdinbHwiYTy5g7h+F2gMmqFDxCMp8gfUg9RCu1p2B73dCvV0CkJ++J+Ys+?=
 =?us-ascii?Q?z0ZqxZjmiEfzZxydkw3COavNnh6D3MXaGf5K4+dTui/DaGSPfrI0z7+w7s7a?=
 =?us-ascii?Q?zn+d+xKMXzEQ8r+9+6q4T/8pxCz8n4NXzMSv4ciOfbqNBfy+AxMLBrFy3Nq4?=
 =?us-ascii?Q?RvKueOTqspOP7/bpyc5exeejjozGn1BRy6spTe+779Qry3JSWZuWC5c756J1?=
 =?us-ascii?Q?bQcUvFfQcNYgNEjg15NqAeoSCoSZWEsJ0TuuIEKupS9Ak5hg90jM74QVpeFG?=
 =?us-ascii?Q?Zg/nu+yuBCjMqYZI9190nheQyTyZMgoHI0LI9GO0LIie988H9l0jp3KRvSDm?=
 =?us-ascii?Q?0GhDRAFSdR//VFpX9IOQLDQCJ/lZZW5pPJzonU6rxjSIaXL+2KVgFBzcGI7E?=
 =?us-ascii?Q?BLAdEPiU/KR8oSzIFdSGR9y2bQDxIHMYdiv/xmZ2hj2gegq1Bq1NVRGYkTL0?=
 =?us-ascii?Q?r03psJPEX8vKC9c82OLQkrO4Hi2/s9rUFFhuvcTwB30atr5tkNNSnmzbVylv?=
 =?us-ascii?Q?eAcHVlsN9nT3BOec5bwDLNwSTsnAVeE7mDxaTIKZLNqRmIbQasUHM0t/K92I?=
 =?us-ascii?Q?YZvJazdXVKF2kVIW1Sc+3uBYPpXLeXpes5vv9glOJTP7o3dIx/0gAV+iYz9D?=
 =?us-ascii?Q?ZyjfdBb6iPgjEx6I8IHQtacDyJDW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OBgTXLmJOn9sVaUmNYiU+wsUTza80PajbQ+CiUkLPQo+vkOaeO83/wyKTMNE?=
 =?us-ascii?Q?Mwt8Vhm8WNby+ARjkR/cSOKXsniBX8h1V86Mb1A70Uw2DGbnyzdEq8qj7zJn?=
 =?us-ascii?Q?SgY1bHWlYvcaBJBV8uW4PdVQu80nSJucCSXPetsnMKQH/5mzbtJi5OJrmHPk?=
 =?us-ascii?Q?7/1KmA2UQo1uZBZrnqGUxYy5L8szUPJV5TIyUUjvuYXCfBLZM1wzmN94xRU/?=
 =?us-ascii?Q?t8589Io08nBJeqVS9tO+2rdhiQVRp2a4Ia+oSe9wHXbcVHCl2T/P3LA9CsEq?=
 =?us-ascii?Q?WboTOvjtfnc5MWbEvJExBtDMN4O6+ZF6Pk9ZEfGoeyVYmGuW9xk7aR2yUpBC?=
 =?us-ascii?Q?4zpSJhc4gsaFN8AUqBF55Aux7R1aBxjinsjoXUa6Wn7QSUymknjW0axDbVdI?=
 =?us-ascii?Q?X9vDKIIgwGGr4wj3ffuShj3zJ1Mwh0CfizqMxscov6niC1ExphLEuSn9d+Ol?=
 =?us-ascii?Q?5uwgbaq3kLSRev6iUfv3WwvZteWJ+bqUT//t74lZSbM7L/fjKioNXKporW+d?=
 =?us-ascii?Q?+lEfHIX0Il/oucjVNBCptP6B/6L06uUaLOb3OMUWunWQ3iUt5viBMqemT4tM?=
 =?us-ascii?Q?Xsybw2ZHXraC5Muo+FHKkL6S3MYfk3xrwvsZ0ENuIR+RVpbNsiwI0Pdy7MSA?=
 =?us-ascii?Q?CgLI9zPBanW33KeVfyf1sWVRKjJM9j3MqYxpmoyUxBnwKuyGAtIOdseleNkt?=
 =?us-ascii?Q?s5Q7hbLgHi+j77/xJjF8YN6mDYrivTsxGKK6aOSkygajJPjaQc584X9NwkYv?=
 =?us-ascii?Q?1GXZqJciuLKkZk3QmmgG07QornAsT9EQ3en1apJUqXSkVU0H99yTTy2lxbT7?=
 =?us-ascii?Q?5BDIWaoALVNLewLqCWF6+xT64AlbSYWI5BUTXXV0gIBWy+p6IN8awoEGSPF7?=
 =?us-ascii?Q?4l8rZOJiBGbob+2MxmRSqDkjO9L+sRb+bTB8Ev6/+2NMjU0nM0gmxlXJLi7k?=
 =?us-ascii?Q?fTWMXcFOOZy77pdFhb2bmpHZacFeumhzqCQ0UMQC64x1jGSoFYVbFnQee45I?=
 =?us-ascii?Q?so5UWnQEB4gildt6WKPDlsBPXb06W22GgH6U+XVB+5RBHjwUjGS0FuHtIt/d?=
 =?us-ascii?Q?m77ebWHYqDmFxGmJPhxNXufBQ2qLC66ghxEqH1IxLGiZCCNy/rGRkoX7HgW2?=
 =?us-ascii?Q?Xm/2DJ1AcIsGPSWCmKjA3MiizSmzrqUT5VVY8tF1egBvPHxIi4Ks9Bh8RDKT?=
 =?us-ascii?Q?KiVU2YGZqqRHretmzIhqE8YHJGXewwwZ+r69XwIkxgvahjvSIHHLchylZ8Iy?=
 =?us-ascii?Q?etlmPWJ7BzYfvnM8m7bvnNDscMcOWbGZx+65qs0WLDOmMbrjGGGtGh1Xa3WH?=
 =?us-ascii?Q?AAQ1aztcshB6gEaptWz27z6w9A0JpBeRBA+e0uT1L9vCOF/8NvwhwDow7EAX?=
 =?us-ascii?Q?zs/aHFiO4dO4ZrRDnIv6/cD7Wz9H9Xh+3AxrnUZVzmYkmcwqPArlkeEGlSmM?=
 =?us-ascii?Q?dmUtVbXswYjrU1kbcUpfILcN7tx03uPYRIqhT3SRWk7mHJfpWiScDrpwpPZg?=
 =?us-ascii?Q?PasaiT8Nr2vw5n7YSc6ckVklUbTakiw1rpK3+FWYfraqu4SqD4lMpoZ38J/l?=
 =?us-ascii?Q?0uoNbIM0Wah+qJKeD3BUj8RXBqGGI3n147cqVy0hLLjs6PqRGlckXo5OzfNG?=
 =?us-ascii?Q?IQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	btiDMHSIVV1hmSdRobqBkvormuSg/2++NH40a/Ic62d3wNMIcIyHuQNXurRdHP5X6lEOB7erGP5BZcPyp4ir7yg3MdScCEczprsrq6nc6SHfSQ/Iiaxp5/ROQ+mgDbGvcqq49P6HNVMPA1aZPdRg984A7SLzRHEoKPOWwU1dyy6fGZO+e0Nnejf70svHMg82OamEA++YNL6Uj1BlAUEwgtgkjk4JtEkdwDx2hUo+ILm4sCqoZT3w/m6OiSUrSpJoBHeWCUepVBRoXtyqfgvmdQT5e+HGq+sMskIVl7hLJ4fl7Y94koOCRqc1sBYORBfkNtYw15Ox2x1RrKzhg/5Nnv/styreMBP97bNzG19nmvsCSFElCRQPdjovxZ26dM50lEOcXYtGcspmqVi6N0JG3YHg3I334EKUBNWRaZ2vAUrOGRzbYv1oA2c8Jg3URtHPMkRXqwQ3VkuvOB6t7DNroySxBlC1BnY2icjH58kmKTa8t8MKExWvEaOS/dTiJJKnlgCUKiP05zgvjlBG4OHhh6bJZIVsfIlDnZaRfiXeasve2NvuTJyXp0qokGlUE1rTc7YMF6wTyKNuc7t4WXWTgk0qnhm255GrAa3qM3m1pgU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b73a67f-697d-49ee-5b29-08dd5a77c3bf
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 17:20:58.9677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oGMvJXMBu6QayiXoUSNER+hRupG5q1SzH1OPCRI+T0I2b66YYc6cmZtf74891KU7foHIARZrZKDIT3b1kKv1up8VlincqRaA/aRfLqWi9zA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6808
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_08,2025-03-03_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503030132
X-Proofpoint-ORIG-GUID: zhZkBt1asVqXP9cn1zcdBbqCqSVe3ecC
X-Proofpoint-GUID: zhZkBt1asVqXP9cn1zcdBbqCqSVe3ecC

Thanks for taking a look! :) I know this one is a bit painful...

On Mon, Mar 03, 2025 at 12:12:07PM -0500, Liam R. Howlett wrote:
> * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250303 06:08]:
> > Place checks into a separate function so the mremap() system call is less
> > egregiously long, remove unnecessary mremap_to() offset_in_page() check and
> > just check that earlier so we keep all such basic checks together.
> >
> > Separate out the VMA in-place expansion, hugetlb and expand/move logic into
> > separate, readable functions.
> >
> > De-duplicate code where possible, add comments and ensure that all error
> > handling explicitly specifies the error at the point of it occurring rather
> > than setting a prefixed error value and implicitly setting (which is bug
> > prone).
> >
> > This lays the groundwork for subsequent patches further simplifying and
> > extending the mremap() implementation.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >  mm/mremap.c | 405 ++++++++++++++++++++++++++++++++--------------------
> >  1 file changed, 251 insertions(+), 154 deletions(-)
> >
> > diff --git a/mm/mremap.c b/mm/mremap.c
> > index c3e4c86d0b8d..c4abda8dfc57 100644
> > --- a/mm/mremap.c
> > +++ b/mm/mremap.c
> > @@ -942,33 +942,14 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
> >  	unsigned long ret;
> >  	unsigned long map_flags = 0;
> >
> > -	if (offset_in_page(new_addr))
> > -		return -EINVAL;
> > -
> > +	/* Is the new length or address silly? */
> >  	if (new_len > TASK_SIZE || new_addr > TASK_SIZE - new_len)
> >  		return -EINVAL;
> >
> > -	/* Ensure the old/new locations do not overlap */
> > +	/* Ensure the old/new locations do not overlap. */
> >  	if (addr + old_len > new_addr && new_addr + new_len > addr)
> >  		return -EINVAL;
> >
> > -	/*
> > -	 * move_vma() need us to stay 4 maps below the threshold, otherwise
> > -	 * it will bail out at the very beginning.
> > -	 * That is a problem if we have already unmaped the regions here
> > -	 * (new_addr, and old_addr), because userspace will not know the
> > -	 * state of the vma's after it gets -ENOMEM.
> > -	 * So, to avoid such scenario we can pre-compute if the whole
> > -	 * operation has high chances to success map-wise.
> > -	 * Worst-scenario case is when both vma's (new_addr and old_addr) get
> > -	 * split in 3 before unmapping it.
> > -	 * That means 2 more maps (1 for each) to the ones we already hold.
> > -	 * Check whether current map count plus 2 still leads us to 4 maps below
> > -	 * the threshold, otherwise return -ENOMEM here to be more safe.
> > -	 */
> > -	if ((mm->map_count + 2) >= sysctl_max_map_count - 3)
> > -		return -ENOMEM;
> > -
> >  	if (flags & MREMAP_FIXED) {
> >  		/*
> >  		 * In mremap_to().
> > @@ -1035,6 +1016,218 @@ static int vma_expandable(struct vm_area_struct *vma, unsigned long delta)
> >  	return 1;
> >  }
> >
> > +/* Do the mremap() flags require that the new_addr parameter be specified? */
> > +static bool implies_new_addr(unsigned long flags)
> > +{
> > +	return flags & (MREMAP_FIXED | MREMAP_DONTUNMAP);
> > +}
> > +
> > +/*
> > + * Are the parameters passed to mremap() valid? If so return 0, otherwise return
> > + * error.
> > + */
> > +static unsigned long check_mremap_params(unsigned long addr,
> > +					 unsigned long flags,
> > +					 unsigned long old_len,
> > +					 unsigned long new_len,
> > +					 unsigned long new_addr)
>
> If you use two tabs for the arguments this will be more compact and more
> readable.

Sure, but a later commits eliminates this :)

>
> > +{
> > +	/* Ensure no unexpected flag values. */
> > +	if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE | MREMAP_DONTUNMAP))
> > +		return -EINVAL;
> > +
> > +	/* Start address must be page-aligned. */
> > +	if (offset_in_page(addr))
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * We allow a zero old-len as a special case
> > +	 * for DOS-emu "duplicate shm area" thing. But
> > +	 * a zero new-len is nonsensical.
> > +	 */
> > +	if (!PAGE_ALIGN(new_len))
> > +		return -EINVAL;
> > +
> > +	/* Remainder of checks are for cases with specific new_addr. */
> > +	if (!implies_new_addr(flags))
> > +		return 0;
> > +
> > +	/* The new address must be page-aligned. */
> > +	if (offset_in_page(new_addr))
> > +		return -EINVAL;
> > +
> > +	/* A fixed address implies a move. */
> > +	if (!(flags & MREMAP_MAYMOVE))
> > +		return -EINVAL;
> > +
> > +	/* MREMAP_DONTUNMAP does not allow resizing in the process. */
> > +	if (flags & MREMAP_DONTUNMAP && old_len != new_len)
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * move_vma() need us to stay 4 maps below the threshold, otherwise
> > +	 * it will bail out at the very beginning.
> > +	 * That is a problem if we have already unmaped the regions here
> > +	 * (new_addr, and old_addr), because userspace will not know the
> > +	 * state of the vma's after it gets -ENOMEM.
> > +	 * So, to avoid such scenario we can pre-compute if the whole
> > +	 * operation has high chances to success map-wise.
> > +	 * Worst-scenario case is when both vma's (new_addr and old_addr) get
> > +	 * split in 3 before unmapping it.
> > +	 * That means 2 more maps (1 for each) to the ones we already hold.
> > +	 * Check whether current map count plus 2 still leads us to 4 maps below
> > +	 * the threshold, otherwise return -ENOMEM here to be more safe.
> > +	 */
> > +	if ((current->mm->map_count + 2) >= sysctl_max_map_count - 3)
> > +		return -ENOMEM;
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * We know we can expand the VMA in-place by delta pages, so do so.
> > + *
> > + * If we discover the VMA is locked, update mm_struct statistics accordingly and
> > + * indicate so to the caller.
> > + */
> > +static unsigned long expand_vma_inplace(struct vm_area_struct *vma,
> > +					unsigned long delta, bool *locked)
> > +{
> > +	struct mm_struct *mm = current->mm;
> > +	long pages = delta >> PAGE_SHIFT;
> > +	VMA_ITERATOR(vmi, mm, vma->vm_end);
> > +	long charged = 0;
> > +
> > +	if (vma->vm_flags & VM_ACCOUNT) {
> > +		if (security_vm_enough_memory_mm(mm, pages))
> > +			return -ENOMEM;
> > +
> > +		charged = pages;
> > +	}
> > +
> > +	/*
> > +	 * Function vma_merge_extend() is called on the
> > +	 * extension we are adding to the already existing vma,
> > +	 * vma_merge_extend() will merge this extension with the
> > +	 * already existing vma (expand operation itself) and
> > +	 * possibly also with the next vma if it becomes
> > +	 * adjacent to the expanded vma and otherwise
> > +	 * compatible.
> > +	 */
> > +	vma = vma_merge_extend(&vmi, vma, delta);
> > +	if (!vma) {
> > +		vm_unacct_memory(charged);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	vm_stat_account(mm, vma->vm_flags, pages);
> > +	if (vma->vm_flags & VM_LOCKED) {
> > +		mm->locked_vm += pages;
> > +		*locked = true;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static bool align_hugetlb(struct vm_area_struct *vma,
> > +			  unsigned long addr,
> > +			  unsigned long new_addr,
> > +			  unsigned long *old_len_ptr,
> > +			  unsigned long *new_len_ptr,
> > +			  unsigned long *delta_ptr)
> > +{
> > +	unsigned long old_len = *old_len_ptr;
> > +	unsigned long new_len = *new_len_ptr;
> > +	struct hstate *h __maybe_unused = hstate_vma(vma);
> > +
> > +	old_len = ALIGN(old_len, huge_page_size(h));
> > +	new_len = ALIGN(new_len, huge_page_size(h));
> > +
> > +	/* addrs must be huge page aligned */
> > +	if (addr & ~huge_page_mask(h))
> > +		return false;
> > +	if (new_addr & ~huge_page_mask(h))
> > +		return false;
> > +
> > +	/*
> > +	 * Don't allow remap expansion, because the underlying hugetlb
> > +	 * reservation is not yet capable to handle split reservation.
> > +	 */
> > +	if (new_len > old_len)
> > +		return false;
> > +
> > +	*old_len_ptr = old_len;
> > +	*new_len_ptr = new_len;
> > +	*delta_ptr = abs_diff(old_len, new_len);
> > +	return true;
> > +}
> > +
> > +/*
> > + * We are mremap()'ing without specifying a fixed address to move to, but are
> > + * requesting that the VMA's size be increased.
> > + *
> > + * Try to do so in-place, if this fails, then move the VMA to a new location to
> > + * action the change.
> > + */
> > +static unsigned long expand_vma(struct vm_area_struct *vma,
> > +				unsigned long addr, unsigned long old_len,
> > +				unsigned long new_len, unsigned long flags,
> > +				bool *locked_ptr, unsigned long *new_addr_ptr,
> > +				struct vm_userfaultfd_ctx *uf_ptr,
> > +				struct list_head *uf_unmap_ptr)
> > +{
> > +	unsigned long err;
> > +	unsigned long map_flags;
> > +	unsigned long new_addr; /* We ignore any user-supplied one. */
> > +	pgoff_t pgoff;
> > +
> > +	err = resize_is_valid(vma, addr, old_len, new_len, flags);
> > +	if (err)
> > +		return err;
> > +
> > +	/*
> > +	 * [addr, old_len) spans precisely to the end of the VMA, so try to
> > +	 * expand it in-place.
> > +	 */
> > +	if (old_len == vma->vm_end - addr &&
> > +	    vma_expandable(vma, new_len - old_len)) {
> > +		err = expand_vma_inplace(vma, new_len - old_len, locked_ptr);
>
> You use delta twice here (new_len - old_len).  I assume this is
> different in the next patches.
>
> > +		if (IS_ERR_VALUE(err))
> > +			return err;
>
> Doesn't expand_vma_inplace() return 0 on success, error otherwise?

Yeah, this is copying some already dubious logic from the original (trying to
_somewhat_ minimise the delta here).

At any rate, a later commit addresses this!

>
> > +
> > +		/*
> > +		 * We want to populate the newly expanded portion of the VMA to
> > +		 * satisfy the expectation that mlock()'ing a VMA maintains all
> > +		 * of its pages in memory.
> > +		 */
> > +		if (*locked_ptr)
> > +			*new_addr_ptr = addr;
> > +
> > +		/* OK we're done! */
> > +		return addr;
> > +	}
> > +
> > +	/*
> > +	 * We weren't able to just expand or shrink the area,
> > +	 * we need to create a new one and move it.
> > +	 */
> > +
>
> So it's more of an expand_or_move_vma()?

I think that's misleading, because it would be
expand_or_move_and_expand_vma() or expand_in_place_or_move_and_expand()...

Unavoidably we have to abbreviate, I tried to differentiate between the two
cases with the 'in place' stuff.

So we _try_ to do it in place, if not we have to expand elsewhere.

>
> > +	/* We're not allowed to move the VMA, so error out. */
> > +	if (!(flags & MREMAP_MAYMOVE))
> > +		return -ENOMEM;
>
> and by flags we mean... the flags from the syscall.  This gets confusing
> with map_flags.  At least there's only two and not six flags.

3 flags (MREMAP_FIXED, MREMAP_MAYMOVE, MREMAP_DONTUNMAP) :>)

This becomes clearer later, I'm not sure saying mremap_flags really adds
anything but noise though.

>
> > +
> > +	/* Find a new location to move the VMA to. */
> > +	map_flags = (vma->vm_flags & VM_MAYSHARE) ? MAP_SHARED : 0;
> > +	pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
> > +	new_addr = get_unmapped_area(vma->vm_file, 0, new_len, pgoff, map_flags);
> > +	if (IS_ERR_VALUE(new_addr))
> > +		return new_addr;
> > +	*new_addr_ptr = new_addr;
> > +
> > +	return move_vma(vma, addr, old_len, new_len, new_addr,
> > +			locked_ptr, flags, uf_ptr, uf_unmap_ptr);
> > +}
> > +
> >  /*
> >   * Expand (or shrink) an existing mapping, potentially moving it at the
> >   * same time (controlled by the MREMAP_MAYMOVE flag and available VM space)
> > @@ -1048,7 +1241,8 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
> >  {
> >  	struct mm_struct *mm = current->mm;
> >  	struct vm_area_struct *vma;
> > -	unsigned long ret = -EINVAL;
> > +	unsigned long ret;
> > +	unsigned long delta;
> >  	bool locked = false;
> >  	struct vm_userfaultfd_ctx uf = NULL_VM_UFFD_CTX;
> >  	LIST_HEAD(uf_unmap_early);
> > @@ -1067,70 +1261,38 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
> >  	 */
> >  	addr = untagged_addr(addr);
> >
> > -	if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE | MREMAP_DONTUNMAP))
> > -		return ret;
> > -
> > -	if (flags & MREMAP_FIXED && !(flags & MREMAP_MAYMOVE))
> > -		return ret;
> > -
> > -	/*
> > -	 * MREMAP_DONTUNMAP is always a move and it does not allow resizing
> > -	 * in the process.
> > -	 */
> > -	if (flags & MREMAP_DONTUNMAP &&
> > -			(!(flags & MREMAP_MAYMOVE) || old_len != new_len))
> > -		return ret;
> > -
> > -
> > -	if (offset_in_page(addr))
> > +	ret = check_mremap_params(addr, flags, old_len, new_len, new_addr);
> > +	if (ret)
> >  		return ret;
> >
> >  	old_len = PAGE_ALIGN(old_len);
> >  	new_len = PAGE_ALIGN(new_len);
> > +	delta = abs_diff(old_len, new_len);
> >
> > -	/*
> > -	 * We allow a zero old-len as a special case
> > -	 * for DOS-emu "duplicate shm area" thing. But
> > -	 * a zero new-len is nonsensical.
> > -	 */
> > -	if (!new_len)
> > -		return ret;
> > -
> > -	if (mmap_write_lock_killable(current->mm))
> > +	if (mmap_write_lock_killable(mm))
> >  		return -EINTR;
> > +
> >  	vma = vma_lookup(mm, addr);
> >  	if (!vma) {
> >  		ret = -EFAULT;
> >  		goto out;
> >  	}
> >
> > -	/* Don't allow remapping vmas when they have already been sealed */
> > +	/* If mseal()'d, mremap() is prohibited. */
> >  	if (!can_modify_vma(vma)) {
> >  		ret = -EPERM;
> >  		goto out;
> >  	}
>
> This could be delayed to the munmap() call, which will also check to
> ensure this would fail.
>
> It doesn't really cost anything though so I don't think it's worth it
> here.  Maybe something we can keep in mind for the future...

Happy to address but I think would be better in a later commit, as this one
is more like 'keep things the same but restructure', later commits do
deeper changes.

>
> >
> > -	if (is_vm_hugetlb_page(vma)) {
> > -		struct hstate *h __maybe_unused = hstate_vma(vma);
> > -
> > -		old_len = ALIGN(old_len, huge_page_size(h));
> > -		new_len = ALIGN(new_len, huge_page_size(h));
> > -
> > -		/* addrs must be huge page aligned */
> > -		if (addr & ~huge_page_mask(h))
> > -			goto out;
> > -		if (new_addr & ~huge_page_mask(h))
> > -			goto out;
> > -
> > -		/*
> > -		 * Don't allow remap expansion, because the underlying hugetlb
> > -		 * reservation is not yet capable to handle split reservation.
> > -		 */
> > -		if (new_len > old_len)
> > -			goto out;
> > +	/* Align to hugetlb page size, if required. */
> > +	if (is_vm_hugetlb_page(vma) &&
> > +	    !align_hugetlb(vma, addr, new_addr, &old_len, &new_len, &delta)) {
> > +		ret = -EINVAL;
> > +		goto out;
> >  	}
> >
> > -	if (flags & (MREMAP_FIXED | MREMAP_DONTUNMAP)) {
> > +	/* Are we RELOCATING the VMA to a SPECIFIC address? */
> > +	if (implies_new_addr(flags)) {
> >  		ret = mremap_to(addr, old_len, new_addr, new_len,
> >  				&locked, flags, &uf, &uf_unmap_early,
> >  				&uf_unmap);
> > @@ -1138,109 +1300,44 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
> >  	}
> >
> >  	/*
> > -	 * Always allow a shrinking remap: that just unmaps
> > -	 * the unnecessary pages..
> > -	 * do_vmi_munmap does all the needed commit accounting, and
> > -	 * unlocks the mmap_lock if so directed.
> > +	 * From here on in we are only RESIZING the VMA, attempting to do so
> > +	 * in-place, moving the VMA if we cannot.
> >  	 */
> > -	if (old_len >= new_len) {
> > -		VMA_ITERATOR(vmi, mm, addr + new_len);
> >
> > -		if (old_len == new_len) {
> > -			ret = addr;
> > -			goto out;
> > -		}
> > +	/* NO-OP CASE - resizing to the same size. */
> > +	if (new_len == old_len) {
> > +		ret = addr;
> > +		goto out;
> > +	}
> > +
> > +	/* SHRINK CASE. Can always be done in-place. */
> > +	if (new_len < old_len) {
> > +		VMA_ITERATOR(vmi, mm, addr + new_len);
> >
> > -		ret = do_vmi_munmap(&vmi, mm, addr + new_len, old_len - new_len,
> > +		/*
> > +		 * Simply unmap the shrunken portion of the VMA. This does all
> > +		 * the needed commit accounting, unlocking the mmap lock.
> > +		 */
> > +		ret = do_vmi_munmap(&vmi, mm, addr + new_len, delta,
> >  				    &uf_unmap, true);
> >  		if (ret)
> >  			goto out;
> >
> > +		/* We succeeded, mmap lock released for us. */
> >  		ret = addr;
> >  		goto out_unlocked;
> >  	}
> >
> > -	/*
> > -	 * Ok, we need to grow..
> > -	 */
> > -	ret = resize_is_valid(vma, addr, old_len, new_len, flags);
> > -	if (ret)
> > -		goto out;
> > -
> > -	/* old_len exactly to the end of the area..
> > -	 */
> > -	if (old_len == vma->vm_end - addr) {
> > -		unsigned long delta = new_len - old_len;
> > -
> > -		/* can we just expand the current mapping? */
> > -		if (vma_expandable(vma, delta)) {
> > -			long pages = delta >> PAGE_SHIFT;
> > -			VMA_ITERATOR(vmi, mm, vma->vm_end);
> > -			long charged = 0;
> > -
> > -			if (vma->vm_flags & VM_ACCOUNT) {
> > -				if (security_vm_enough_memory_mm(mm, pages)) {
> > -					ret = -ENOMEM;
> > -					goto out;
> > -				}
> > -				charged = pages;
> > -			}
> > -
> > -			/*
> > -			 * Function vma_merge_extend() is called on the
> > -			 * extension we are adding to the already existing vma,
> > -			 * vma_merge_extend() will merge this extension with the
> > -			 * already existing vma (expand operation itself) and
> > -			 * possibly also with the next vma if it becomes
> > -			 * adjacent to the expanded vma and otherwise
> > -			 * compatible.
> > -			 */
> > -			vma = vma_merge_extend(&vmi, vma, delta);
> > -			if (!vma) {
> > -				vm_unacct_memory(charged);
> > -				ret = -ENOMEM;
> > -				goto out;
> > -			}
> > +	/* EXPAND case. We try to do in-place, if we can't, then we move it. */
> > +	ret = expand_vma(vma, addr, old_len, new_len, flags, &locked, &new_addr,
> > +			 &uf, &uf_unmap);
> >
> > -			vm_stat_account(mm, vma->vm_flags, pages);
> > -			if (vma->vm_flags & VM_LOCKED) {
> > -				mm->locked_vm += pages;
> > -				locked = true;
> > -				new_addr = addr;
> > -			}
> > -			ret = addr;
> > -			goto out;
> > -		}
> > -	}
> > -
> > -	/*
> > -	 * We weren't able to just expand or shrink the area,
> > -	 * we need to create a new one and move it..
> > -	 */
> > -	ret = -ENOMEM;
> > -	if (flags & MREMAP_MAYMOVE) {
> > -		unsigned long map_flags = 0;
> > -		if (vma->vm_flags & VM_MAYSHARE)
> > -			map_flags |= MAP_SHARED;
> > -
> > -		new_addr = get_unmapped_area(vma->vm_file, 0, new_len,
> > -					vma->vm_pgoff +
> > -					((addr - vma->vm_start) >> PAGE_SHIFT),
> > -					map_flags);
> > -		if (IS_ERR_VALUE(new_addr)) {
> > -			ret = new_addr;
> > -			goto out;
> > -		}
> > -
> > -		ret = move_vma(vma, addr, old_len, new_len, new_addr,
> > -			       &locked, flags, &uf, &uf_unmap);
> > -	}
> >  out:
> >  	if (offset_in_page(ret))
> >  		locked = false;
> > -	mmap_write_unlock(current->mm);
> > +	mmap_write_unlock(mm);
> >  	if (locked && new_len > old_len)
> > -		mm_populate(new_addr + old_len, new_len - old_len);
> > +		mm_populate(new_addr + old_len, delta);
> >  out_unlocked:
> >  	userfaultfd_unmap_complete(mm, &uf_unmap_early);
> >  	mremap_userfaultfd_complete(&uf, addr, ret, old_len);
> > --
> > 2.48.1
> >

