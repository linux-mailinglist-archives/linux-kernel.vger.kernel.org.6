Return-Path: <linux-kernel+bounces-300312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D8A95E23E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 08:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD1EDB21728
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 06:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675593839C;
	Sun, 25 Aug 2024 06:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mUfb9Un/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="w+JXjK81"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FA328F1;
	Sun, 25 Aug 2024 06:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724568128; cv=fail; b=oF/Mp0z1rlWDbghSR2MUnmvySczuHtOdHVDp2idpBiXsU1SlPzLU+ldzyPMVr0Iy6vsZuH16Q24DeHkzrLiITzO8VTGrZDHEyDckx9xNBabPrraweLDyLUoJOlfmQdfm6xPuEwGuTZ5xAdd7Jbl73BNu7QgtsWUyK1fOGCSgB8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724568128; c=relaxed/simple;
	bh=AjFP+m9+WSUMB+Y374eAg0qI3aFArfOUECkk8aLuUsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=duqvgZW0c6VwuINhDwb6bF2aPC5n10mtGiCAWgkw/M86PVBfFSye3UBS91lFenGr/Bj24ioakHwxt2ru3hwd0ljOAL7xxI9x3919JKfZN0BgejoTUNSG4eX+9bJeaJUeXNbRjullUEViKqk13lgtFy5gTqsj2MYT09p70UaC4xk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mUfb9Un/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=w+JXjK81; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47P5U2Xs002603;
	Sun, 25 Aug 2024 06:41:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=GdZpK+vM3fU2XWGK6/g5PW8BR6UnX2wOC5mF5z+YQ3o=; b=
	mUfb9Un/Cp2JbyxM91+gfQJ/GCv0/V0D0TDpVufb9k+9H97oFtNFxrUCVqq22MdJ
	yYKzpF8CpoAZLvZ70NHo3PXuTGc9BtshOiPMecSlNxbPAWRBNrgdlqFHWmU4Bm36
	xKzlCo+A9besaA3FzIjs3Mgpu+WtbwVv3KL7sKf5EUUvmyVklBst3xNivPeGxuzt
	1QLbmj15NLde/MunoasqM+KiJlIs44pH9EPlPUfpiQoJtDqmnLS328fIkmYjy/Cv
	aHE+/7yAGnxh0pgZ16mynp+33IwVpMtpCGGezpIhpOP39HRML+z3oRi4NyJjoOxH
	PIGoMHrY3UiRrSxrYNx5hg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4177u6h39v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 25 Aug 2024 06:41:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47P6TAkP039394;
	Sun, 25 Aug 2024 06:41:54 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 417ycu0764-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 25 Aug 2024 06:41:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rMDXuV2V7ToS/FDcqKUXN7m4Mju00ps+kumcGWaK7oLX+hm9X7KObl2YKOvJ6J+Y0i2FJVx4mnoIhs12IuVBxwaKXf7JRKYQjru9wMLid7JouF5EiQQJTb8yk70BML1G+vMMIgcv4Pr+xYEDVk6HV7vHBH6JzyNaep75SS6y9Ilb902J0fXSnKjOBwDg9QNwktEbm9QpqoHmnZxWeeCY3vgeE6UIaSIuAHWaoiH30+4lvXOUrgbDsNJhPupiG4BK2djisIX8f/Fky6WR/3b3MNlDmIx+TDcHMBdoifIXA6H9g8HI4sCGp6dHlKl3qveTKEMxBe4YSxn6VXuEpREtkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GdZpK+vM3fU2XWGK6/g5PW8BR6UnX2wOC5mF5z+YQ3o=;
 b=UpjwUQh4wLZ4h5jHaL7LNO/G+v6oJ+Wr8OE0Cl07ut528bNe85OsV6Dj5JiOP42JLtrLM8HHJhjP3xZoUwMscH2f0tTR3XK+LG/34LkZDCzqH2DAetdfkTKd/JYdh7fFYK8tttJ3fBG9XRlM//Khezte9QzptAPt+3xOJacPhguQtay9xnu/nBza5AxY4Smu74CW2fUHQgEsgc9NcfnA+9R6GV8BoojveqgIlbra1FMXJBwXq0aBU7bFSyqvy4ZXIF6c4z4yUEDFwxN/WrgYVpfqcxxSHcCTTL/SzTZA7SRYS8Zsjo9vzU94wg19f/D7ukC/LYZeyyA1nCsOh3Tkww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GdZpK+vM3fU2XWGK6/g5PW8BR6UnX2wOC5mF5z+YQ3o=;
 b=w+JXjK81Vx3qUK2fB8cxI9pILHZjmEQBshJWqL/aXXtYk8tzItgeG5SkH9XPVXTp7If6APPO/Vk/o/tUlDx0BnCAtjjn1BF2SZSHBf+8VbMHvQf9+uESg7gP/P/7C0wjdsmAs+7Um/rmiT1F2bjgQXgdaePWz90zvinO8vpzqx4=
Received: from PH0PR10MB5611.namprd10.prod.outlook.com (2603:10b6:510:f9::16)
 by MN0PR10MB5957.namprd10.prod.outlook.com (2603:10b6:208:3cf::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.9; Sun, 25 Aug
 2024 06:41:45 +0000
Received: from PH0PR10MB5611.namprd10.prod.outlook.com
 ([fe80::d513:a871:bbf9:fce2]) by PH0PR10MB5611.namprd10.prod.outlook.com
 ([fe80::d513:a871:bbf9:fce2%6]) with mapi id 15.20.7918.006; Sun, 25 Aug 2024
 06:41:44 +0000
Date: Sun, 25 Aug 2024 07:39:22 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: zhiguojiang <justinjiang@vivo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, oe-lkp@lists.linux.dev, lkp@intel.com,
        opensource.kernel@vivo.com
Subject: Re: [PATCH v2] vma remove the unneeded avc bound with non-CoWed folio
Message-ID: <ccd9b00b-1f36-4f2c-bd48-47f7a7187772@lucifer.local>
References: <20240823150206.565-1-justinjiang@vivo.com>
 <73ad9540-3fb8-4154-9a4f-30a0a2b03d41@lucifer.local>
 <4dd13a4c-e968-4a3a-98e5-97f28036deff@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4dd13a4c-e968-4a3a-98e5-97f28036deff@vivo.com>
X-ClientProxiedBy: LO4P123CA0584.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::15) To SN4PR10MB5606.namprd10.prod.outlook.com
 (2603:10b6:806:209::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5611:EE_|MN0PR10MB5957:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c0878e3-4b65-4b79-a8a8-08dcc4d0fbce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?LzZLOXBUVEV3S0hzVXRVN2Vtd1Z3em9ZaE5oaEFJWjVaVEpJSnA5MFFvVXVl?=
 =?utf-8?B?ME1Na2I3cWV6N2lzU0V2eC9rQWxsNW1TQk1QWkhQTmM4RjdHaFVYbmM2UFNo?=
 =?utf-8?B?MXJXRGNEMHgrNVdIbTdENDZValNJc3dwQ01Ka1BpdHBHNTZlZ3hBb3NFRHox?=
 =?utf-8?B?aFJDZ0hjSXdNcTdLSDlzM3ZNUW1sbWtseEJBWGFsM2dkM2o1elQzTG5xczBN?=
 =?utf-8?B?Z1hiS3RmekloZmF6OXdxRFZJYk9LNUhhWWVCb1UwaGhOekxUVE5US3dCTHlz?=
 =?utf-8?B?TlA2RGw4c1ZDdS9xazBQTUpDWWxjUklOWkpxZm1oL0tQZ2ZPRE9xSnZnM2JX?=
 =?utf-8?B?ZGQ2WkNpd2xnRmtOOXRqVlZPTWdPbDRqb1dUS29ueUxNVFdnVkNWclJ6QkFV?=
 =?utf-8?B?eHpvNzZpNExFTHBaSzBPWldyQmx2aGpLNlRISm80bkphU3NLbnZDN3crck14?=
 =?utf-8?B?OVRGSCtvWUJGOGEyNFV1L3pCRVY2ZE9yTjgwdnNQbTJSenlILzhsVDdFNjF2?=
 =?utf-8?B?V0x0SytESkRNOGM1NWlWVmgyTHMzVWtEb0FGN0NsU3lSR0tGZDhpWDdMS1hJ?=
 =?utf-8?B?cy9BcWExZlpTYnF5UldRNElKdlcvajg4bkZ6bEd2OFVLeU5lRU4xZGhxUUFv?=
 =?utf-8?B?eldKMzY1TW1SY2JxQzNNVWNDUzFReTJ3bUNUWWt3Y2FOODUrdURXdDVxWWFI?=
 =?utf-8?B?RDl0aUQvYllsWnd0M2lHN0tWVFVqMEhNd0ladXN2a0hjMVJJenNrLzNNaXVr?=
 =?utf-8?B?U1FXR1U2ZEpMaEJYNXo0S1lmaHY0bUhaWVl5cVpBc3JTemZYKzQ3QUEyV0l6?=
 =?utf-8?B?am9GODJiWkNKZXFyNmNDUDFEMlFmUVhXNXlWaEEwaWQ2SjVuV1lxcVU5c1oy?=
 =?utf-8?B?YSs4YmljS1JzcURVdXRXWG5wcnQ0bGh4cHF6RGVrZjIrMkU4bVZvdjJNT1hY?=
 =?utf-8?B?aGU5UHlwOVpXL3VENzVZZktuL3BxY1NPMVVQVGN2N2FCdS9KckljZXBUTS9k?=
 =?utf-8?B?UTVQY1d5VGJnUDhkSlhCM1BzVWxCUlJJeC9WM0NsRyswREhnV3FaVXExN043?=
 =?utf-8?B?K3I1LzBRSGZUeVh0RGt5QlpxNWlJTzR2UGlkUWlSTU8rS2ZseUY3V3F4bHMw?=
 =?utf-8?B?SUhTV0NGaWRVNlJXNVlEZ0piU3piSlZDTk9FajNpZ2ZOd04rTEdrTW5QSVRO?=
 =?utf-8?B?YUVFbGhHbVE0cHZBQXdUNDFFR3R4ZDRKbUtxWGQvWkduLzZmU1I1RlpZQlZz?=
 =?utf-8?B?ZGk0YnBiOEhZSU9rMEphNC8zOGdXMlBMQmE2UTh3SE9NdkhldFZuaUdzS2pz?=
 =?utf-8?B?WVpxbDhSMzVnY28rRjRiQVJBU2pmOVV5M2JjZ1Zoa2pwZmtOSVlwamw2d3c1?=
 =?utf-8?B?T05iSzJCMEdydWhoMVkzTDVyRGdSS2VkR09iWXlqREN3Y2ZUWFUxd3lSYXo0?=
 =?utf-8?B?S0pHR0E4N1VFQWw1YmFlWTRteWM1UUVtNUtkcnNvcTErYzhleVNsbWUvbjR0?=
 =?utf-8?B?VDJVRFdsRmUzakt5Y0dJeGpkRGxoMm5ZenRiK0M3Vy94dHhsdU5OMFR6VUJZ?=
 =?utf-8?B?bVhaSHVSdWwwaTM0VW50RXlSNVhoN1Rma3dWYXI4SC9tWk5ydWRLb2NlbEdB?=
 =?utf-8?B?TTc1dUp5UHpkRGNSUmJ6ejBUUXRRYy9wVEFwYTdhaDZqYmdtQ2w4VEMxdkRs?=
 =?utf-8?B?TmJhZmxJVFUrWDdBWFRBZ2doVERJaS91M0Vvd1p4ckNZNUxteUtvNW1tZlFz?=
 =?utf-8?Q?n2VZRtB5HckeNcOUA9Xqvc+z5j6Zq8/bD1OSaZP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5611.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WjRNOGxJcGMzRHo2R2F3U1JWbUtPTUFjdkEvazFOKzBNTG15blZZeG5WNWdO?=
 =?utf-8?B?Z1ZDVFJVK1k3RW9MdHZSSkQ3VGI3MXFHTlBST3luSnd0eVRpVjEvaHBkRVlm?=
 =?utf-8?B?ajhtcERURXF0ZUd4a3lCTUgzaEZVNkRjSHhOcHB1RzBxYVJJMi9uN3NXVGdN?=
 =?utf-8?B?by95S01GSXlsOTl5VmxadnM0SXM4V0JESkM4ZHRiVkgzajhxM1VYR2R1RHVD?=
 =?utf-8?B?SGNYT0RwNzdjQkVGdUJsSlhVam5CQmx3MTNVeXZTT1hkbEhxN3NQL1RhbU1T?=
 =?utf-8?B?MVVVL2p6dTJYeWJKd0dPRW9XLzVBZDkrdnhjR0hDV0kzMGRYSzFUYnkrWUky?=
 =?utf-8?B?M20yYm50ZUNPRU8rcUs2TXdPZFg5OWFCbjhWTVJaZ3BLL2xOcmlSWGpjcGZz?=
 =?utf-8?B?RVBLajN6YklyNXFpTVMvOGFpa09jV2kxbkwwOEdLekxvMGxMZ0kza0xidjl0?=
 =?utf-8?B?OHBLNVZHbWo1bzNzcEhXNHlMVzlYSWU0TTd1ZnhKMzI3SjhZV3doS1lBd3Jr?=
 =?utf-8?B?U3dLR243ZEthUlphWmFQdU5mRVU5b2FiTFVnbld1ak5sOVFkVWZ6Z2FESUZL?=
 =?utf-8?B?THByS3JuVDhJREFEYjNiTVlrYVB3RFFCaEhTZHFXMTFDWm9xK2VLbXdTOU9N?=
 =?utf-8?B?MEN6Rk9sRVdpZG53aU5HdmNneUg2YXlqYnZnOHRjNkhDZlIyK1B0TnV6TlN5?=
 =?utf-8?B?WjJuMUpMVFdGMlpBTWlCcHJHMTZyNDRvU0Y1VS9xdXkvR2dqalJkd0w3Zity?=
 =?utf-8?B?QnJUMFdvbytOMDg5SkZoTmFKcm1iUmJWWWw3aE9ROC9jYlRLYmVnb2RIb3VE?=
 =?utf-8?B?d2d4UW9WMkZqck9GNkZjNVk3UDhQUmJKM2ozekZOdEVqSk81UzJYaTVRYUFi?=
 =?utf-8?B?akJuT29GZEpFVXBIVWpTWCtiQnVSbVJRejlPM0tGeG9mbis0QlV3MHBiaDhW?=
 =?utf-8?B?Qkg3Sld5cEd3WkRkbFFlVEZvck1LU0lWUnVIczhOd1ZnWlVHN2VPaldscWFE?=
 =?utf-8?B?d1JTYldjUVBWNGtXalVCb1FEQ3ZNd0hlSExNOU0yM3kvY2k0bnpNQnRSZXAx?=
 =?utf-8?B?bFN1RCtYTG5hZG1VRGV0ZlZjNG9uNEQ3NXpjZEhTQjdVQVJpL3Bad0V4bG9j?=
 =?utf-8?B?K0N4N2RCR2hkWEdOcHVWeHIrN1RFeU1sNnYwTFA0c0syNlo3WXlhYWxWWUhs?=
 =?utf-8?B?Q1ZyOWFLSzYxczlpeFlHU2NsT1VVa3hCWGs3dEFHMnh3UnB4eFhDWnNxeUNh?=
 =?utf-8?B?bS9yY0lxcGx4M3VnYmpWcGhSTVRjditoNXJpNVdMNHo1anVOT0FpNkN0K1Vn?=
 =?utf-8?B?YXJvalc1dVlVc1hEQ2hFb3lIaU8rQVdVM2RKemdUdnpYZjFmM3dlNEhNYmJQ?=
 =?utf-8?B?c29MQThaOVBmY2FncHptb0VQTEZpNElOeEZERXJPeENNT1FkQzRYUXhBL1J6?=
 =?utf-8?B?U3RhZVhuaXkveDEyZFRWZkdVSW5xZmZORkNEQjRiS0xGbVZmT1FCZVQ2U0Nw?=
 =?utf-8?B?R3NWbHVkT1VNTUdCUEE5VEgySnFmZGdZanJZM1dLUFkyVFJlSHB0N251UEp4?=
 =?utf-8?B?YXRyaWhrR20rVC84MGJCd245bFZXSmppcWFzTjIxZVorNGduRVVHcCtvQVli?=
 =?utf-8?B?S1FGdlM3cVJUbWlValVudUJnSXd1NWJxZ2JiZ2pINU4vc3VlRlYydm41Nzd6?=
 =?utf-8?B?alZqY2dJaVkzdXRJVzRHL3dkMXY4TFJKd1lkYUFDdXFDc3c4TVlwRGJ2M0ow?=
 =?utf-8?B?YmNsaWpER01ZV3I4RFRDTjNGd1dzUEV0bHZGUEdZRmY3UnlHNTNicURVeGIw?=
 =?utf-8?B?TStKc3l2azBDNnJtMXBHWDRjZFhwZUdGbGo2Sk9ld0Fqdk1rZTZ1eTEwRWxl?=
 =?utf-8?B?M2pxVHp3NForMUhmMitsTlMzTzViYWkwYlpYUWl3OHhDcXVLVWpYYm9GQkxm?=
 =?utf-8?B?V0N1Uk80TDZyTGkzOFcvTlpGdFVYUmVyZWdHQlhISHFzZXpMZHdWODZUKytU?=
 =?utf-8?B?Y0dvWmJSek9UMnlOa1lxTTN2WkZhNXVDWWdzN0ZzcFd6Y25rZ2JpaE5BSzFR?=
 =?utf-8?B?QVR6eVZUaDVZWldSWEUzaFk0QWhIU3ZLQThlcVFkTDk4ODRUUHhWaUZ3Q1g2?=
 =?utf-8?B?SFRTSEZHNlk4QVAxMmVSN01BYjJkRkRQVlZxWE1oSkdLVlZRQ2o0REdiZ1lq?=
 =?utf-8?B?VkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nbr7iFvNzpF2kQsjuExsT+p0PKu+1pidMgO8/ixrSoOMpugIXjJoyVaCVUEt9ArudwxJoAxgw3BcQyVgs+5Ee6RAoG9xpeXKuzcqiUaTPQ1m07eNkWXjtRyfdxshcGDeSVxHmYvhHPXOmqPqSFsZsB3dPJlFgPttmILxEWYQAKQUr4b/DnbRnch/uTQfjmXY5pZcZb4IKkKLVd9vbKya7waTG6DVfpUsP59icSoHJPmfYgGfGqmaRYijgpFZD8BMhe1iAX3WenaNJNL6wP0fAsrter0ZLe5PkwUu7t8E0C8KAfyOrBAzwh5zKbP/7HSDeC7gybYf3uopJei6IUBdoWKN3wUeDQFtnPnJ7d7+bP5ALd7ieTStHl+BG95OewjZTaaaExKdwbCv0u+2KHmN3jBTmEcPfYnCSdzm26v/XaeFJ1axPAR9md34LCHzPOeoMOtcQGAbmY2QOhxh+/UdCR9qEdBGyDy/AHV4ga6wiJWEdSEAAnIl8R5p4YGls40YyyplveRhxo3tdVMaqeo8kJsUluJfWSSNuDukMtTJ0Xv9RfgldN0AhOIyv73Fw8pIpiJJBZH4FO1+YuJl3g1QDagNEo+2U71LelwkcFNW2NY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c0878e3-4b65-4b79-a8a8-08dcc4d0fbce
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5606.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2024 06:41:44.6767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wo3TrvjEe+9eIl/tvkH4iEUDXtOwMonCwyQdd6HKduczS9ZitLlSMIFjCYqWqwuzzrs3WLS6ZkRxP8t0Q+tc3q7YTav6mOi/Q0AQxOKJDDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5957
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-25_03,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408250048
X-Proofpoint-ORIG-GUID: f0iSTzdPKX5dq3PXrxXrOdosDPWIgZjw
X-Proofpoint-GUID: f0iSTzdPKX5dq3PXrxXrOdosDPWIgZjw

On Sun, Aug 25, 2024 at 01:06:40PM GMT, zhiguojiang wrote:
>
>
> 在 2024/8/25 0:26, Lorenzo Stoakes 写道:
> > [Some people who received this message don't often get email from lorenzo.stoakes@oracle.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > On Fri, Aug 23, 2024 at 11:02:06PM GMT, Zhiguo Jiang wrote:
> > > After CoWed by do_wp_page, the vma established a new mapping relationship
> > > with the CoWed folio instead of the non-CoWed folio. However, regarding
> > > the situation where vma->anon_vma and the non-CoWed folio's anon_vma are
> > > not same, the avc binding relationship between them will no longer be
> > > needed, so it is issue for the avc binding relationship still existing
> > > between them.
> > >
> > > This patch will remove the avc binding relationship between vma and the
> > > non-CoWed folio's anon_vma, which each has their own independent
> > > anon_vma. It can also alleviates rmap overhead simultaneously.
> > >
> > > Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
> >
> > NACK (until fixed). This is broken (see below).
> >
> Hi Lorenzo Stoakes,
>
> Thank you for your comments.
> > I'm not seeing any numbers to back anything up here as to why we want to
> > make changes to this incredibly sensitive code?
> I added a debug trace log (as follows) in wp_page_copy() and observed
> that a large number of these orphan avc-objects still exist. I believe
> this will have a certain redundant overhead impact on anonymous folios'
> rmap avcs, so I want to remove it, which is also the most essential
> value of this patch.

Sorry nack to that idea unless you can provide actual _data_ to demonstrate
an overhead.

And even if you did, given the original patch was so completely broken, and
in such a sensitive area, I'm going to need to be VERY confident you didn't
break anything, so we're going to need tests.

>
> -- the vital part of debug trace patch:

Thanks for providing! Will snip for sake of making it easier to reply.

> >
> > Also anon_vma logic is very complicated and confusing, this commit message
> > feels about 3 paragraphs too light.
> >
> > Under what circumstances will vma->anon_vma be different from
> > folio_anon_vma(non_cowed_folio)? etc.
> In anon_vma_fork() --> anon_vma_clone(), child vma is bound with parent
> vma's anon_vma firstly.
>     /*
>      * First, attach the new VMA to the parent VMA's anon_vmas,
>      * so rmap can find non-COWed pages in child processes.
>      */
>     error = anon_vma_clone(vma, pvma);
>
> When child vma->anon_vma is NULL in anon_vma_fork(),
>     /* An existing anon_vma has been reused, all done then. */
>     if (vma->anon_vma)
>         return 0;
>
>     /* Then add our own anon_vma. */
>     anon_vma = anon_vma_alloc();
>
> new anon_vma will be alloced and filled in this child vma->anon_vma.
> Then during CoWed in do_wp_page() --> wp_page_copy(), this child vma's
> new anon_vma will be different from folio_anon_vma(non_cowed_folio).

Thanks for the explanation, but I was suggesting you have to put this in
the commit message rather than in repy to me :)

> > Confusing topics strongly require explanations that help (somewhat)
> > compensate. This is one of them.
> >
> > > ---
> > >
> > > -v2:
> > >   * Solve the kernel test robot noticed "WARNING"
> > >     Reported-by: kernel test robot <oliver.sang@intel.com>
> > >     Closes: https://lore.kernel.org/oe-lkp/202408230938.43f55b4-lkp@intel.com
> > It doesn't.
> >
> > Saw a bunch of warning output in dmesg when running in qemu, bisected it to
> > this commit. The below assert is being fired (did you build this kernel
> > with CONFIG_DEBUG_VM?):
> >
> >          VM_WARN_ON(anon_vma->num_children);
> >
> >  From what I saw, these appear to all be cases where anon_vma->num_children == 0...
> >
> >
> > [    1.905603] ------------[ cut here ]------------
> > [    1.905604] WARNING: CPU: 2 PID: 231 at mm/rmap.c:443 unlink_anon_vmas+0x181/0x1c0
> > [    1.905605] Modules linked in:
> > [    1.905605] CPU: 2 UID: 1000 PID: 231 Comm: zsh Tainted: G        W          6.11.0-rc4+ #49
> > [    1.905606] Tainted: [W]=WARN
> > [    1.905606] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
> > [    1.905607] RIP: 0010:unlink_anon_vmas+0x181/0x1c0
> > [    1.905608] Code: 48 83 7f 40 00 75 1c f0 ff 4f 30 75 ab e8 d7 fd ff ff eb a4 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 90 0f 0b 90 eb de 90 <0f> 0b 90 eb d1 90 0f 0b 90 48 83 c7 08 e8 4d 7c ea ff e9 fc fe ff
> > [    1.905608] RSP: 0018:ffffc90000547cb0 EFLAGS: 00010286
> > [    1.905609] RAX: ffff88817b265390 RBX: ffff88817b265380 RCX: ffff88817b2cb790
> > [    1.905609] RDX: ffff88817b265380 RSI: ffff88817b2cb790 RDI: ffff888179e08888
> > [    1.905610] RBP: dead000000000122 R08: 000000000000000c R09: 0000000000000010
> > [    1.905610] R10: 0000000000000001 R11: 0000000000000000 R12: ffff88817b2cb790
> > [    1.905611] R13: dead000000000100 R14: ffff88817b2cb780 R15: ffff888179e08888
> > 00000000000
> > [    1.905613] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [    1.905613] CR2: 0000555bc5d97390 CR3: 000000017c12c000 CR4: 0000000000750ef0
> > [    1.905614] PKRU: 55555554
> > [    1.905614] Call Trace:
> > [    1.905614]  <TASK>
> > [    1.905615]  ? unlink_anon_vmas+0x181/0x1c0
> > [    1.905615]  ? __warn.cold+0x8e/0xe8
> > [    1.905616]  ? unlink_anon_vmas+0x181/0x1c0
> > [    1.905617]  ? report_bug+0xff/0x140
> > [    1.905618]  ? handle_bug+0x3b/0x70
> > [    1.905619]  ? exc_invalid_op+0x17/0x70
> > [    1.905620]  ? asm_exc_invalid_op+0x1a/0x20
> > [    1.905621]  ? unlink_anon_vmas+0x181/0x1c0
> > [    1.905622]  free_pgtables+0x11f/0x250
> > [    1.905622]  exit_mmap+0x15e/0x380
> > [    1.905624]  mmput+0x54/0x110
> > [    1.905625]  do_exit+0x27e/0xa10
> > [    1.905626]  ? __x64_sys_close+0x37/0x80
> > [    1.905626]  do_group_exit+0x2b/0x80
> > [    1.905628]  __x64_sys_exit_group+0x13/0x20
> > [    1.905629]  x64_sys_call+0x14af/0x14b0
> > [    1.905630]  do_syscall_64+0x9e/0x1a0
> > [    1.905630]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > [    1.905631] RIP: 0033:0x7f4416ae33ad
> > [    1.905632] Code: Unable to access opcode bytes at 0x7f4416ae3383.
> > 000e7
> > [    1.905633] RAX: ffffffffffffffda RBX: 00007f4416d5e3c0 RCX: 00007f4416ae33ad
> > [    1.905633] RDX: 00000000000000e7 RSI: ffffffffffffff88 RDI: 0000000000000000
> > [    1.905633] RBP: 0000555b8eed1378 R08: 0000000000000000 R09: 0000000000000007
> > [    1.905634] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> > [    1.905634] R13: 0000000000000000 R14: 00007ffe7dbe9190 R15: 00007ffe7dbe9110
> > [    1.905635]  </TASK>
> > [    1.905635] ---[ end trace 0000000000000000 ]---
> > [    1.905638] ------------[ cut here ]------------
> >
> >
> > >   * Update comments to more accurately describe this patch.
> > >
> > > -v1:
> > >   https://lore.kernel.org/linux-mm/20240820143359.199-1-justinjiang@vivo.com/
> > >
> > >   include/linux/rmap.h |  1 +
> > >   mm/memory.c          |  8 +++++++
> > >   mm/rmap.c            | 53 ++++++++++++++++++++++++++++++++++++++++++++
> > >   3 files changed, 62 insertions(+)
> > >
> > > diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> > > index 91b5935e8485..8607d28a3146
> > > --- a/include/linux/rmap.h
> > > +++ b/include/linux/rmap.h
> > > @@ -257,6 +257,7 @@ void folio_remove_rmap_ptes(struct folio *, struct page *, int nr_pages,
> > >        folio_remove_rmap_ptes(folio, page, 1, vma)
> > >   void folio_remove_rmap_pmd(struct folio *, struct page *,
> > >                struct vm_area_struct *);
> > > +void folio_remove_anon_avc(struct folio *, struct vm_area_struct *);
> > >
> > >   void hugetlb_add_anon_rmap(struct folio *, struct vm_area_struct *,
> > >                unsigned long address, rmap_t flags);
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index 93c0c25433d0..4c89cb1cb73e
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -3428,6 +3428,14 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
> > >                         * old page will be flushed before it can be reused.
> > >                         */
> > >                        folio_remove_rmap_pte(old_folio, vmf->page, vma);
> > > +
> > > +                     /*
> > > +                      * If the new_folio's anon_vma is different from the
> > > +                      * old_folio's anon_vma, the avc binding relationship
> > > +                      * between vma and the old_folio's anon_vma is removed,
> > > +                      * avoiding rmap redundant overhead.
> > What overhead? Worth spelling out for instance if it's unnecessary to
> > traverse avc's.
> I think this will have a certain redundant overhead impact on anonymous
> folios rmap traverse avcs process.

This is again nowhere near detailed enough, and again I'm asking you to
write this _IN THE COMMENT_ not in review.

I already understand what you're trying to do (I think the fact I provided
a _working_ version of your patch as an attachment in this thread should
give a clue ;), this is for the benefit of people coming to read this code.

> >
> > > +                      */
> > > +                     folio_remove_anon_avc(old_folio, vma);
> > >                }
> > >
> > >                /* Free the old page.. */
> > > diff --git a/mm/rmap.c b/mm/rmap.c
> > > index 1103a536e474..56fc16fcf2a9
> > > --- a/mm/rmap.c
> > > +++ b/mm/rmap.c
> > > @@ -1522,6 +1522,59 @@ void folio_add_file_rmap_pmd(struct folio *folio, struct page *page,
> > >   #endif
> > >   }
> > >
> > > +/**
> > > + * folio_remove_anon_avc - remove the avc binding relationship between
> > > + * folio and vma with different anon_vmas.
> > > + * @folio:   The folio with anon_vma to remove the binded avc from
> > > + * @vma:     The vm area to remove the binded avc with folio's anon_vma
> > > + *
> > > + * The caller is currently used for CoWed scene.
> > Strange turn of phrase,
> >
> > > + */
> > > +void folio_remove_anon_avc(struct folio *folio,
> > I think this should be 'oldfolio'. You're not looking at the copied folio,
> > but the unCoW'd original folio.
> Yes, thanks.
> >
> > > +             struct vm_area_struct *vma)
> > > +{
> > > +     struct anon_vma *anon_vma = folio_anon_vma(folio);
> > > +     pgoff_t pgoff_start, pgoff_end;
> > > +     struct anon_vma_chain *avc;
> > > +
> > > +     /*
> > > +      * Ensure that the vma's anon_vma and the folio's
> > > +      * anon_vma exist and are not same.
> > > +      */
> > > +     if (!folio_test_anon(folio) || unlikely(!anon_vma) ||
> > The folio_test_anon() is already implied by folio_anon_vma() != NULL and
> > doesn't preclude KSM.
> >
> > > +         anon_vma == vma->anon_vma)
> > > +             return;
> > This is all super confusing, the 'parent' is actually anon_vma
> > (oldfolio). The newly created 'child' anon_vma is vma->anon_vma. Should
> > probably rename each accordingly.
> OK.
> >
> >
> > > +
> > > +     pgoff_start = folio_pgoff(folio);
> > > +     pgoff_end = pgoff_start + folio_nr_pages(folio) - 1;
> > > +
> > > +     if (!anon_vma_trylock_write(anon_vma))
> > > +             return;
> > > +
> > > +     anon_vma_interval_tree_foreach(avc, &anon_vma->rb_root,
> > > +                     pgoff_start, pgoff_end) {
> > > +             /*
> > > +              * Find the avc associated with vma from the folio's
> > > +              * anon_vma and remove it.
> > > +              */
> > This is a meaningless comment.
> >
> > This should be something like 'anon_vma_chain objects bind VMAs and
> > anon_vma's. Find the avc binding the unCoW'd folio's anon_vma to the new
> > VMA, and remove it, as it is now redundant.'
> >
> > > +             if (avc->vma == vma) {
> > In testing I found that a lot of the time this isn't found at all... is
> > that expected?
> >
> > > +                     anon_vma_interval_tree_remove(avc, &anon_vma->rb_root);
> > > +                     /*
> > > +                      * When removing the avc with anon_vma that is
> > > +                      * different from the parent anon_vma from parent
> > > +                      * anon_vma->rb_root, the parent num_children
> > > +                      * count value is needed to reduce one.
> > > +                      */
> > This is a really confusing comment. You're not explaining the 'why' you're
> > just essentially asserting that you need to do this, and clearly this is
> > broken.
> >
> > > +                     anon_vma->num_children--;
> > So we know this is broken to start due to VM_WARN_ON() failures.
> >
> > As per above dmesg analysis, sometimes this is zero, so you're
> > underflowing. We definitely need a:
> >
> >          VM_WARN_ON(anon_vma->num_children == 0);
> >
> > At least.
> >
> > But also the naming is broken here too, anon_vma is actually the parent
> > (oldfolio's) anon_vma...
> >
> >
> > This is also just not correct on any level - the anon_vma->num_children
> > field indicates how many child anon_vma objects point at it via
> > anon_vma->parent, NOT avc.
> >
> > You're removing an avc, not disconnecting an anon_vma.
> >
> > So it seems to me you should have logic to remove the avc AND logic to
> > disconnect vma->anon_vma from (parent) anon_vma if it points to it.
> >
> > You'll need to be careful about locking when you do that too, as anon_vma's
> > lock on the root anon_vma, but in isolating the child anon_vma you'd lose
> > this lock.
> >
> > I've tried to write code to fix this but haven't been able to yet, this is
> > fiddly stuff.
> >
> > (I think this might have seemed to work at some point in testing because
> > unlink_anon_vmas() uses the avc list to determine what to unlink, rather
> > than looking at individual anon_vma's but still).
> >
> > > +
> > > +                     list_del(&avc->same_vma);
> > > +                     anon_vma_chain_free(avc);
> > > +                     break;
> > > +             }
> > > +     }
> > > +     anon_vma_unlock_write(anon_vma);
> > > +}
> > > +
> > >   static __always_inline void __folio_remove_rmap(struct folio *folio,
> > >                struct page *page, int nr_pages, struct vm_area_struct *vma,
> > >                enum rmap_level level)
> > > --
> > > 2.39.0
> > >
> > Again I question the value of this change. Are we REALLY seeing a big
> > problem due to unneeded avc's hanging around? This is very sensitive,
> > fiddly, confusing code, do we REALLY want to be playing with it?
> Thank you for helping to identify mang issues with this patch. However,
> I think this will have a certain benefits for anonymous folio rmap
> traverse avc overhead.
> >
> > It'd be good to get some tests though unless you move this to vma.c with
> > its userland testing (probably a good idea actually as Andrew suggested)
> > this might be tricky.
> This patch belongs to anon_vma rmap's content, and it seems more
> appropriate in mm/rmap.c?
> >
> > NACK until the issues are fixed and the approach at least seems more
> > correct.
> Thanks
> Zhiguo
>

Please see the attachment in thread for an example of a working version of
this, this is sadly fundamentally broken.

But you're going to really need to sell this a lot better, provide some
numbers, and provide extensive testing and a much, much better test for
this to stand any chance.

I appreciate what you're trying to do here, and it's not totally crazy, but
we have to be so, so careful around this code.

anon_vma code is horrendously subtle and confusing (I actually had to
reference my unpublished book to remind myself how this stuff works :)), so
we have to tread very carefully.

I definitely think we need ASCII diagrams if we were to go ahead with a new
version of this. But then again I'm a bit of a fan of ASCII diagrams...

Please cc- me on future revisions of this series, thanks :)

