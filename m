Return-Path: <linux-kernel+bounces-391007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FC69B8118
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 18:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 842B11C21EE2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 17:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DA91BE23C;
	Thu, 31 Oct 2024 17:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Jq1AtSWJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ee+TIdyp"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AE61386C9
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 17:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730395341; cv=fail; b=lRNAqxdQnRZNKpV+YmFmju+Z5SeCxVU2YCWP4LhZyLCPv7dRreM3H4Xou5BNg2v5Pac2g9W+UUwmuSlGyQjzHMF7mPPnLFiTgqUrozNE2Zpr2HYATyPziUXTlGZuiD5CMoPxq+k7B+Iasxrsnp/BuULh2mv72zymc0GpxcDpAUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730395341; c=relaxed/simple;
	bh=1tOp+oxyxRgJf1Nf+cWaF7t0al5d2GDMcUO9lOprXkM=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eZlM0Gt1Z2lLD1h9V4ALkbkBWmsYlUZB8twvTnX7W3znQGMZ4z9wVNba4Y3BCi49D///oyQaH2LWjGwr/GqwLmgv1LRSeNdP+cEIvfCGCZ2yMU94X/yTwZMy+HrEzPW4euztlEfmOxkNm5HkFUG3xpRl0zA7IeKDnnyxn4sHSQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Jq1AtSWJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ee+TIdyp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49VGoc3L007863;
	Thu, 31 Oct 2024 17:22:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=7ua23M9yHWYVsln29W
	imABUEuhfEJ4+rU25WBUyoTXk=; b=Jq1AtSWJdL/KUtNAZTyRZ6y+PBmo1YVbGS
	nWMNXAf3BmODxbGzMKSGk8yaekzPsMsoMHO4mXF5+jz5ZbcAGxKCTRZxOU2RlRzd
	udsNTsseujdFd8iNhYx6uw01iRFVKIVboWTc0CKG3B/LgBEs/SZQ/pDCUKEm8UpE
	SUnJmQU40MM+QWR67eDrTLT45TUBV2YVmTNtLsE02vfAqw0g+3O6Zz1WF9YeOd7c
	0vObeHCuMrItVDMhh2O3HYSfGg60lEvnJucQzcZeCcGbdPzYlX6CozfD8ETdp/XA
	/hwCuob3anspj8ceSum1ifJ0b3lHGYz6pUN8QtzNQLLWRru+qAIg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdxtth5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Oct 2024 17:22:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49VHCIRc035093;
	Thu, 31 Oct 2024 17:22:04 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hndan02d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Oct 2024 17:22:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BSiJ6F3Kt4iS4KNFUAXSySCD0vubf4v7OFfz9KvJlQwKll+8Wbpp8UJB8OfMdhtr8mqE7cl2CriOWyC1P6Rpy2IL0VKwFBa8fL2KIA+gUGzBWUTwsM8NnwY6CKooyKXDJyX9K0PC3mJsnAZlYmEOYujehib51rwKXeNZB6kTZsnAZ+PyDPT6adfaACuqvkfO+RtcI7kPuexGBFiWxqwmGfvf72na/yUFArWDfxVKiN1s4xiQ58o1vi/fj46YvlL29c7ZfHI68C/9hrqoV6urLr9mTsdhd7Vl3yrI32pJW84CxCiharyua5HfUTAPZRCLT1zXX4X5VidDljb6gjDCsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ua23M9yHWYVsln29WimABUEuhfEJ4+rU25WBUyoTXk=;
 b=huL4cyvxaFoK2Bv8A++Sbd7YWv8v3pbWkLHBxIiUQQ2FDZiWRUrqptcd9PdUGVY+Z2wHrUlKLEdXq1B1EvXWWPgVB3KZXfi/bKEEfGVrGmfDu+GOSu66SFl5mkhl/vJYJK4Sg2da1TuvrQ6htA8owIn8+OjeQofOHf3Zm6PAneCsCf2K8tP05VRj0tsk9rGcAEYXEIBazGfukwnou5dOYoEXDVmsSPIu3wcDl6uPV6lL3PxpVX/YWleg4UlM2ezToy4MNDRqnNQcsI4RgmkiR98YLoWHCjxgm4cdMPAw3Jr93PNb1ww4M88Hxd8+RUGyMzar8eq9L5HvXlhjpLTfrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ua23M9yHWYVsln29WimABUEuhfEJ4+rU25WBUyoTXk=;
 b=Ee+TIdypX/ZyWAkwWrVNPp/l98lq9R6XCNLq5H4daeckk+zgqFQsKAWWkPqquDzap9dAmKrCeo3gyl+b0wkD5SPy6jjwA3q+mazYFJngeK0zChexxgPXYpxu48VPG9Bd0xqxB0SIu3H+bX2Kcdhss4nd23ffYu7ZsH96VJodtaU=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SA6PR10MB8135.namprd10.prod.outlook.com (2603:10b6:806:440::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 17:22:02 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8114.020; Thu, 31 Oct 2024
 17:22:02 +0000
Date: Thu, 31 Oct 2024 17:21:58 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH] vma: Detect infinite loop in vma tree
Message-ID: <87d38ab4-215f-4981-aad1-1c1ca3708f2b@lucifer.local>
References: <20241031170138.1935115-1-Liam.Howlett@oracle.com>
 <d0174131-1fc5-46d2-af87-a42a72a31487@suse.cz>
 <2hwlqzr4zfqhv2lz5zn5jypzbdbnx6rsnwrupcnxmhkxit26x6@33b3fsjywjmq>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2hwlqzr4zfqhv2lz5zn5jypzbdbnx6rsnwrupcnxmhkxit26x6@33b3fsjywjmq>
X-ClientProxiedBy: LO4P123CA0434.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::7) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SA6PR10MB8135:EE_
X-MS-Office365-Filtering-Correlation-Id: a505ef90-592e-430e-6863-08dcf9d0887e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xM2Pg+D9cu9MCL5QedSD0U/mUBo9i+fDoMz6n2teta2lNSJA2YLbuM5xJaz7?=
 =?us-ascii?Q?y2yxCDAf2cdJ99kMWlln9Sn/qM5QJ54kxfQArRI6cMDPa4mCjpEHBvpd+2ju?=
 =?us-ascii?Q?hYavhmpB3NLaUnjvUxZO2Z3jgUSxq5hR7ZxaLKeD3GoYLaSmU2Nm/VMt3NyE?=
 =?us-ascii?Q?2XmwAHefs5nfAu6Ll3DPYlWjcOS48eLZfcNTFvO4xHe0NLaY5ZW4yOlZQWMz?=
 =?us-ascii?Q?EaXkezfORC3gyCz7FpIDaNlVdFMvtjW25DdGUVXRtLeuVxHlnh5VnD9JjUoe?=
 =?us-ascii?Q?Gz0LQiNdSm49DOtk+KPyIsCDAVP+XX1Dnlex3Bv1ZKssI8MmzNRUEYWv15Mz?=
 =?us-ascii?Q?hCT+5N/+TWB40zvEm+OxVSKgy54GsMObuDu5FYQGJQd3JB0AKVdmOg09f08n?=
 =?us-ascii?Q?xwzhwGHWoEl63gRR/isFD2YvifgUZizH+AtCGdubYkh9NKGIeERm7TO7jKvF?=
 =?us-ascii?Q?rwgW2HLMPgQN80i9Ciqwwl9VlzyCaMvcWNeR6//nzawv8M2c6ylYrfk25Y9M?=
 =?us-ascii?Q?8IHUWo3oHjGMZsm4JIfLLlRkzcvB5IC8b6KRq4QVSvSisWNUElYtLCJ0VIVw?=
 =?us-ascii?Q?c0M/xlrJXo9w2RWxb+uC2cHeemO0ftO2+HSilCuUdUE8nkZl5gN/r0nHq6p0?=
 =?us-ascii?Q?06cMfALjaPbcfRMFHypfRiWc1xTBVrrKq3LJhTH9zJiAMr/o9YCkGyMM4WKG?=
 =?us-ascii?Q?PmKKMPLv60jH76Fb6k+b6zzpcGVOTaY4GBXdc41OtQoQsc96d3n8nBhMoY3W?=
 =?us-ascii?Q?0ET5m1pVsRuvhePRrzgQxcYjlbpWvxbd8vaGTF/mhVBdquRvZ8//OvMyGKKY?=
 =?us-ascii?Q?Xn3UqpZNbTvQT93hC021VWEEOsTnlaJVpFl7nF8xDgFGoYT+YD2Qnmvesqc2?=
 =?us-ascii?Q?w2aTyTGrdC+v6XWQTNT8j71YE5Y+VwLdTpeCJSLton1URaLmSBIJeBPyJFrM?=
 =?us-ascii?Q?SVcguGWyNM8qX7y0jDWT+fgvw3Yy6x+MKzMNqIWjZTcPUhx8svQDP28XnjsU?=
 =?us-ascii?Q?pmiQVqQuiFYqQ0171zddxzOMUcuMPORcEGQ7JXtEziV1BguoK9cVWkU1iBZh?=
 =?us-ascii?Q?uyDqzGM8JcN5G4UVL1Ajfnh5jhbk1zIsduImhfePRHvN2Lqi/hkX0Xg6LbdZ?=
 =?us-ascii?Q?6n8O9nXwwqfTIpTK1TZ+R1vj/lIylRqsBr/45JHm2+j+Pa2klfqvYT44yWtd?=
 =?us-ascii?Q?QwVFFn8K3o2+far9uGwrSSuoW2wbBpLD23NQHuCpNjhlpiOdQpYe+7PM5kMs?=
 =?us-ascii?Q?cUYTfaOSG0TSpiTpcFWR/NS80yPdpluz7lKfAFHC0rSyK9n28BkU/+Vg8ZAA?=
 =?us-ascii?Q?1ReU8FRN7EfwSdGJZhu6lPID?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dpCxaYnbsOqcAPaePCqtSypMAXKwu55PjOVykH/lLy5ok8PJVaoRuMrV2zoG?=
 =?us-ascii?Q?nbvef8AFW/0U2ZqkeuW+gHliETZ0hzG70tWOniltGJ+lMfMNlx4y2jFKJj69?=
 =?us-ascii?Q?8RntgpeyklTG4Y1ZSmxOpJsxAZicv7ljTHOBNuwCiwmRQVEY9x4WpU+dTc4Q?=
 =?us-ascii?Q?I7R6ZYI7a4FJ7BueiXB2EcNQMGkvv5123HNnBRG1F6VJSyQj7zL7wVdvrXq9?=
 =?us-ascii?Q?M8IjDXNDgFm91zAOq0MhAiKEVdmtD0jUga3i+tNpN2pwSpL+sOusZV2xAMSo?=
 =?us-ascii?Q?HJOA1MXoKI1LBJwa3IJ7Y7Z5vZsfTImAj77PYXV6wYgzvDeqMfztzajgLhN+?=
 =?us-ascii?Q?Xmy+2TE482UbEvUOGfukgGOtRy7bW5bCcOC0NG04+CAT12R9KH8sy76hlo7e?=
 =?us-ascii?Q?IkrDpIN9eR83bPYxLAsmtorZUgriiA5ItGT4kdAv+INWIacwZtmM0AH5mhdo?=
 =?us-ascii?Q?ypw9DDwFBFPgQA+vdbQeOjl9qJ6Fk1DC1TurTinnAAFk0ALSI5JaxANSXvEX?=
 =?us-ascii?Q?cgBCeEJLoBER6aYno6KrK42T8VkgVAGR/hPhMAr3jwknNBXL1zXgdbAIka58?=
 =?us-ascii?Q?OUdX6VNAB7nRpbxjUdxmY7OqXEOEEeONfY3V9zkarZjRlhIMWd/vrA0isujA?=
 =?us-ascii?Q?auEZghfR4cAfIU0P0HBOOne3YQT9M+yYPu4GlCX2T+wqqz/NHU/pCsotqAco?=
 =?us-ascii?Q?E6v7GLc0bxph9iuvEIC6PSbdavWqusfOnHZtyNWEj5vLxF4fVrqSeLYZ/S3y?=
 =?us-ascii?Q?BwSNQtCM7ZX5eeHx02BES2wt88he2qXKsBABI+VgXfipj7r5rLvLXsFeAn9b?=
 =?us-ascii?Q?y5g27jaEVhkdzLeDNkJh1cv+xbf/Mm1W/Xj9K5jzHmVU7SWsg8B0E6rQvi0e?=
 =?us-ascii?Q?RqNEjvws3ANUMOLWxrCP1/DZnooV0EQxwzrY4iBzkaXUuIhOoCfBcLH8aD9s?=
 =?us-ascii?Q?IOud5VtQra3sVVztpT4xc02s//PzhxvxJbZ+bYu/ZTFFNK0kI2qlZOXSD1Wt?=
 =?us-ascii?Q?MBVl5gvov16VOBSmoBD5M3YfDHYyxgKQAqCuBOhuMswulE0R/C9rY3OPDWLm?=
 =?us-ascii?Q?DVRb39R6rMfzsOtW6TzaPbEMiq3XrU0VklcKCldmWkRXpqo2B4AWIizHMMQ4?=
 =?us-ascii?Q?JcuZRTvbAGl6bAKkAO0el6FC3xtxVRY5q6Zfm9kitWWwISHZROvL4z0isOOf?=
 =?us-ascii?Q?MSPWX+4CiedIMksZwsPtlvhIHTIN9+DsCRfQjtWZCGScsjaP7oieSYLarS74?=
 =?us-ascii?Q?86JWlmda88Y8kTPkELNYmPgFE5cOyWyGushQb5mKgiOJ4jiAm0KGN0UP8VQm?=
 =?us-ascii?Q?nGsrxwdZmoufCw4ACBzRpajonVDLFdswZJTn+vfJG60anXZrQDhZZ0sZTg68?=
 =?us-ascii?Q?n5b21W/OTT7buRu9hKPzs0tD9WFmemx22iog8SuUwUiw2/QzuD1HZektwNBy?=
 =?us-ascii?Q?c9hanKTAKIKTCgkf/lUR5CPNMaVM9bkWL9YOEh44AmZfdu260UZG3oIQ3xH2?=
 =?us-ascii?Q?mxPHPVB2I2ZhyfOCajrCSf7hZ3wBi95hzdhHI+loSj4IKO2aLw/9335VhUhi?=
 =?us-ascii?Q?IqXfaTUz/IkYbDMVzJqcgWfqV1CqmT/bd+dTteo3aP/TZM4HJ6IoKm2BZInp?=
 =?us-ascii?Q?UQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XzaXNzQYudb4wHrZ09VwK/PucFn/zRnUxOA0Emft09IiCSaUSw/IxGnZWZ+d/V6WX+I0s0c3dJyTB72t4lTgqqkn/cnxETefgMtU0X1UGQHbHbq3VF8Ca9N6A2hr9EcmrPvGXpvI3wfiq/juUxu6VtyhRkVAbnhoSUiaq6kSBBj6WXEmr+T95NNdNGGJqxBYKusnqOPyPJK0BeFc2iT1JXHx04nSpd6Cg5ZQ06R7AE1tgH/P8mSl7FJ/BPJ+MRG/KyMOxvt0WPWCovPf5zmuIu5GwnnEqDmzcI9BTuBKaN5/sC+v+/S0x+l8jkU0NRcONkxw9Pw1lHsZe3yxJS+Zlzm6DX4jEpj/5E+LaviaD2fxvd5u5X0lERfCTWLkCPdY/jsKPf/OS/BhvNaMS45GBUEX79bPP3AQMjw6XAQBMpMESG/o0D400w0LLSTtMaESjF/r0tTGqu+VfGGqOxQugTYJhVVVTFHQxmHBo2CUdvAT9MyRzw56lnznu0Kczb/RYLussXAadg/OAUd+0L8DsyiaJCLa8JvED6jBazog5khGWpn142W94LH1jaYjJo1KkUdEMTv2GNkwZ0M1EpAqE2hnGI780vr9N5nIGuHv9X4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a505ef90-592e-430e-6863-08dcf9d0887e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 17:22:01.9416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FLXBVWGeBa8GAoIG9X8ERnJAzX/rBFVShSWWhKiA6csEUm+x3XsWBazH8vfru2H0oFbqxOgdpZLNoPmHPjLZHEWMYM9zpHh+uxCRg56IeYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8135
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-31_08,2024-10-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410310131
X-Proofpoint-GUID: 6uMwrLblUFU2zXL0EgStqryXBeDj3gy6
X-Proofpoint-ORIG-GUID: 6uMwrLblUFU2zXL0EgStqryXBeDj3gy6

On Thu, Oct 31, 2024 at 01:13:28PM -0400, Liam R. Howlett wrote:
> * Vlastimil Babka <vbabka@suse.cz> [241031 13:07]:
> > On 10/31/24 18:01, Liam R. Howlett wrote:
> > > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> > >
> > > There have been no reported infinite loops in the tree, but checking the
> > > detection of an infinite loop during validation is simple enough.  Add
> > > the detection to the validate_mm() function so that error reports are
> > > clear and don't just report stalls.
> > >
> > > This does not protect against internal maple tree issues, but it does
> > > detect too many vmas being returned from the tree.
> > >
> > > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > > Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > Cc: Vlastimil Babka <vbabka@suse.cz>
> > > Cc: Jann Horn <jannh@google.com>
> > > ---
> > >  mm/vma.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/mm/vma.c b/mm/vma.c
> > > index 68138e8c153e..60ed8cc187ad 100644
> > > --- a/mm/vma.c
> > > +++ b/mm/vma.c
> > > @@ -615,7 +615,8 @@ void validate_mm(struct mm_struct *mm)
> > >  			anon_vma_unlock_read(anon_vma);
> > >  		}
> > >  #endif
> > > -		i++;
> > > +		if (++i > mm->map_count)
> > > +			break;
> >
> > Would it make sense to allow some slack so that the error below can
> > distinguish better between off-by-one/few error from a complete corruption?
> >
> > And in that case assign some special value to "i" (-1?) to make it clear
> > this was triggered?
>
> Yes, probably.  10 would be plenty.  In recent memory I cannot think of
> an example that we exceeded 7 munmap()'s in a single operation -
> although it is easily possible to do.
>
> I like the idea of -1 too, at least someone would come to inspect where
> it came from at that point.

Hm this feels a little arbitrary though... I mean can we race with
map_count at this point or is everything locked down such that no munmaps()
can happen?

Otherwise it feels a bit whack-a-mole.

I agree with Vlastimil though it'd be nice to sort of differentiate, but if
we _absolutely can only iterate mm->map_count times_ here, it might be
worth letting a few more go, then in the next bit of code...

>
> >
> > >  	}
> > >  	if (i != mm->map_count) {
> > >  		pr_emerg("map_count %d vma iterator %d\n", mm->map_count, i);
> >

...here which does indeed imply that i literally cannot be anything but
mm->map_count, I mean I guess we already get to see here how far off we
are.

So yeah something like letting it go 10 more times (maybe like #define
UNUSUALLY_BAD_CORRUPTION_COUNT 10 or something I don't know naming is hard)
just so we can pick that out would be nice.

But I do like the general idea here though!

