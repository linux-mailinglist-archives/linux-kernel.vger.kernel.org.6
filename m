Return-Path: <linux-kernel+bounces-276304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 292279491E9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDC71283CB5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0281EA0D1;
	Tue,  6 Aug 2024 13:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WoNyEOeo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HZraFgkj"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CD51EA0B1
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 13:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722951849; cv=fail; b=mcXfPhcJMrkSVbQluVp7Y3c259qhvOIPXYXh7/gmnXUJZaoW0veHx+RR5645L1dfdioxEwSfutSl98wJ7XY7buMM8BQExPINb4TrBLNmBvqtXldrNsO2QTkjcZiCrCbinNSLiOpbxinTneCOiUzOLMqjrqO4DM6agug/0kIr/Qc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722951849; c=relaxed/simple;
	bh=0BDE7FRaURATMRStK7gfECa0O+hU4I3jVWBUAF22L1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hQeFaF05fVLsYgUJciMYH86Jk6c/snooJtUJZr0QJ4K/4PdkZelc8tmFmvQqGCBsBs9HdIZFoi9cBh1vNzwDN8QaGZAP3avnApIJhtwux6MVYD/nwbqkxQcP+JTGRHvVF5JGPipjPgRRuKJUWqqq/U/pb2tjih/A5XOwAvv4Pug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WoNyEOeo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HZraFgkj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4765l8fL001723;
	Tue, 6 Aug 2024 13:43:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=Bq2/4T+8hiYvF43CJfF3ldKON/W6mPfd9uZ05U5dBsI=; b=
	WoNyEOeo9Me3okOc0Z7oCCnzkq9SfzoDgRqy6i9aKaJZbKrUcVGFEYYrU8r1ZsER
	Lx99EVKaibWz/bk8wkGSHl34dFWk8cwUE+HE/wh3U6SLGg/ysAN82qnm5HV2SNhM
	dknWuNihNhVHauLzH2P7YdK69+FhOmj5SxGXgSD1c/cR6Nqtf8YAeR9O8Qx9BkZn
	V7NZElMKeYTxkKSUN4a7Qd/B1mLrOqMz0zRe32OXdiLz4+RjPN5ecejv+wYFufIz
	3BL5Jq+XYET8VgHbBSqKTjhFidLrj36EAXS6YXm96AlTFz/GW2kbcZigWTjYNufs
	5pK6R4t7/wqvlA9S9tTHVw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sbfancrn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Aug 2024 13:43:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 476D4D2U018374;
	Tue, 6 Aug 2024 13:43:54 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40sb08p7f3-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Aug 2024 13:43:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OJL6qy9H2ct4sN5cUjOltvcVerYHmj/vqxsMGSJjaV8faS9DfadgiEhhfezerWa6IAJw++a86yWba8iEnb8LeLhlzdvRlPimZxbC2x/ALzdX7twv/lX+a4cBJhM12rbbUZ0NecyHpUPRcGb5WQ3popAUAP8EoVmOp2ncWYfqKuMToAwBrSi7GLhjowRajdd9rhFoYKD3UbEfhgkxO1L+HHEjo/aoz14hY1UfR0oprvy3Tty/iwc79bh7JXbsy7u7ko/HJFkqHkovG+6/BjYQTJShPeH2+kAw0lSc8C8Lb3ds1wt7AMmsa/HQPybj72MOaZ1TonLpnNnSzMoF0MgIPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bq2/4T+8hiYvF43CJfF3ldKON/W6mPfd9uZ05U5dBsI=;
 b=zPYloH2tQCTkQeJY/IzlMOX5kzGLfLsPbJK13vWIgroVvv0UGcGVB4ezskfQqeQGPB+XQpImiWStorgw+xvBXuRfB7J/AcIFIjD7BJHMspq9eZi1T8UuZrLuVNbHoOtL43JfLPeN5sJY1D/DO+tq3mD2tihZ5jEJOUUXISkRYg8ceoGdJ0BI4SpfFUn9RWW/FLgvvj4LJy7hQfneCdGxeSwnfpp9A7XrL4jWneN4TtfAdqRMAOEP3xgph6pUE6QUDNtKFCBhZvMFFBnah7Cv8v2818Yh5uxmCiCaBHJwOhS+fl1Q5+svN9icjGlTI8XzHX09ZKeH+774C9JPw4Jrrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bq2/4T+8hiYvF43CJfF3ldKON/W6mPfd9uZ05U5dBsI=;
 b=HZraFgkjhX+nETyExGsVRGug58CkVUfzRYX3tBiG9h/rXSb0DDE7kUOad3t7lwKT/BFmNJadFThhKIOVplqtXnEIpuArlljLKYA+NvI2/1bgjfOYa5n/Q4TV7bdUX/lnRIhNUHF92Fv++Q/o/JO1+PT9X5ByMp4ogzePSlzJSak=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CH4PR10MB8145.namprd10.prod.outlook.com (2603:10b6:610:235::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Tue, 6 Aug
 2024 13:43:52 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 13:43:52 +0000
Date: Tue, 6 Aug 2024 14:43:48 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 02/10] mm: introduce vma_merge_struct and abstract merge
 parameters
Message-ID: <ddc4c351-d79f-4654-8e0e-63f22afc146f@lucifer.local>
References: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
 <f2d7cc5de8aecc50d353980f62a74a0a6fcec198.1722849859.git.lorenzo.stoakes@oracle.com>
 <20240806144754.447001bc@mordecai.tesarici.cz>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240806144754.447001bc@mordecai.tesarici.cz>
X-ClientProxiedBy: LO2P265CA0490.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::15) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CH4PR10MB8145:EE_
X-MS-Office365-Filtering-Correlation-Id: 44670e66-29cb-4d93-75fb-08dcb61dceaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SjlXTkFMM1ZzSzdkSHdhYUl2VmpWVDJzbGV6WmRNMTU5UGpka0lpN05LaGZw?=
 =?utf-8?B?RlMva1pheGVRWUZUK0prNFk0ZWVON0pSWHR1ekEwSnZnZjJDblhYYzFraWQ5?=
 =?utf-8?B?dnJFeTlDMStVSUpGU0drV0lCZmtndHZqS0dhSzl3M1ZCWUNUWVlMUjNnWm5P?=
 =?utf-8?B?ZjY1bklRTFBVUnhoakM5Mlo3c1kyZVU0UWkwWFJuTTNkVjNlc3g0a2FJbnVL?=
 =?utf-8?B?SU9sbE5tYUpvb1V6dlZvVGhad1VxV0dLemFtQ1lGV0RkeHhnVkpudnJXc2x0?=
 =?utf-8?B?NDhVOTVIY2c2QUd0NklLK2Jrd3B4NWhMVG12OVgvRlJoc2pKZytZZTl4T3hE?=
 =?utf-8?B?R0pQdTRUTnVJQmx0L01ZMXduSHZ6d0tDL0FlTEdZdSt0R3dXSnQyMEZOMjFi?=
 =?utf-8?B?MFczTUNWWXJIei9nMWFnV0YvbHA2dFpEeHNzZHYySHZhN3RsRjlPRnNMTEhm?=
 =?utf-8?B?eENvTWRMdGhYYmdFWlN0R1NsUnE1Nld0UmNuQVMxZm55RDMyb2FEcm9GYTNw?=
 =?utf-8?B?bWZTdUtaQ3Z1dGhaOGIyaFhYQXp2elhrV0ZBSUpKSHZkbXlvSmNZNnkzMnhx?=
 =?utf-8?B?cWlOd2FzUUxzb24xdkEyaDNrdXlHK00zcm93RFZtSUVDTEUwdXdYaWMrQnpx?=
 =?utf-8?B?VE1RTWFRbDZ1Y3JQaUt5NGJRQ2NpK0ZQeHl2MGVYSTZyNm5KMGFIQkhMcmc3?=
 =?utf-8?B?K1ltRDIrREs0M3hyaFlyaTZZcDF2blVuWGpteWxrdWphbUoxYkNlVkNrcVVR?=
 =?utf-8?B?cU9ETnY4U3dEMzZPTFh3WlFSZ3pCZ0NSemVHNUJEb3FJcWpxV05ITndrWitp?=
 =?utf-8?B?WWVkUjFwdjlZQmlIMVdCS1RwT2IwNTR3R1hyRm82WmZJYTJ4OXZOUytjRGVx?=
 =?utf-8?B?b3JJMUFheDVTTVlDVTdBY2tjTVFwa0MwK2MyNEw0dVM1b2tHcHBaZjQ3azlo?=
 =?utf-8?B?U3dmNHpCaHVPWm5wUEVEL2RqWWxIbU5Fd0VtSGFhWkdidEZkYnp4MU5RT0Nl?=
 =?utf-8?B?Sk1wWXNhdVN1dXY3VjY1NUlNNlVXM3RqTWozM2NZYm13VmFpUW5TTUFZMGxz?=
 =?utf-8?B?cHU5dUsxS3JIYjgvVzdtdE1DZXRtOFduY2NuakJRa1hYWlFYUmpQRGFhbFBT?=
 =?utf-8?B?T1VGdjBnK3VwUm9RQ3VrZEk3NXVzNHYzMDU0RWR5MXh5OHBiWC82bmNSU29u?=
 =?utf-8?B?MGExNnlYdFNTdUt6SjhuNHk4OG9vMXBrNWVQN0MyOTRucStqV0FTLzE5NWpG?=
 =?utf-8?B?d0FkRUJVMlBsaldMeitPUVZuays0VXIzTExWaTRra2ZrSTJ3TVpJejJWaVJj?=
 =?utf-8?B?VjRhQy8rQWp5Y01yNEdtTXcyTUtkZ3NtSmdyS3hwS0I2RWsrZlgrUmVJUmZD?=
 =?utf-8?B?dGg3YXlCMWhqK2xFZng2aDlHMWN1RnB2Qk5nK2ZUbVNHZVFVaGRXZEdCYkJJ?=
 =?utf-8?B?SmlDb05NT0M2aVk0cjhzZ1NrdU5saU92TzRuc1NkQVluR0p3ZjBIbEFQSjEw?=
 =?utf-8?B?a3hPLzArRGxMUGpWRE9ZWDdJSXhwaUlub1JoSjFtM1c0aTFXd2s4bTFBK3Q1?=
 =?utf-8?B?VkNucE9lRWd2TUhMdm5jMWZDeGJyVXJaZEdEOWxwb3B1bm9ZUXNHQmMzYjQ1?=
 =?utf-8?B?Qld2U2VTdG5keE9mWnM4UnRJVVFSc0Y5SGE1bDJlQmVTY3hwK09taGZiYVBk?=
 =?utf-8?B?WWZ4QnRzY2hOUG05RkNaZ2hzbjI3SEpONjBCSFdXcFlEMU94YVNZODFSd2w5?=
 =?utf-8?B?RkszZVNoSnliaWlFQjBXaFdMaTJYb3dxaGZUWkt6Vmk0eGloTDlDb1dHTkZp?=
 =?utf-8?B?QXdBaTRJUS8zQmRVdDJmQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUJXRCtYaUVJVVJsa3czYkcvS1JTWThrUWV3ellMdGMwVTZJZTB6YlRBRWxX?=
 =?utf-8?B?dmhzRTZLSGZmbm83cEdVcEJydEVlUWdjcDhsbFB4T3M2Tk5zMU54dDRiRjYz?=
 =?utf-8?B?TkJ0MlpOS0wyY0ZuNGtxV2Rib2oydk8va0haWEZPUVVEV2dJaGhEOTNlQmVx?=
 =?utf-8?B?OUk3WjlCNTJMYlFPZ1lTenlHWlN5b2FWZE9ybUZNUWxmazFXYndzZlVDTDNm?=
 =?utf-8?B?WmVWWDc3K3poYm1FeFcyeHQ0MEtVV2cvc1I1VXNVcjBjSHhXVmU5djJIMWxy?=
 =?utf-8?B?bFE2SGhhRy9mVmw3bkxsdFAvNmtVd01pN1V4ait6VzN0MlBFVnRRdVVzd3JZ?=
 =?utf-8?B?N2c1RlZmYlBSdGh1YXVWa1dSemVudXd6NUpDeWJkN3Vldi96ZXFNWDJFOXZB?=
 =?utf-8?B?UTZpU0NlVElhMlJ1QytWdWh0SVA0blE4c2dWVVFCdFJvUmp2RXM5SjhIaGVz?=
 =?utf-8?B?NXJYUFN6R3ZIMVpoSVlBbk91VitFblo3c1Z5NFpCTXVvQmVWVlJ2KzFkRDJ4?=
 =?utf-8?B?YVd0WE1iV0FpSUV4ZUZPUUZScnArRzlyMU9QcGRBam5LUFVOakRMRkdoTTdZ?=
 =?utf-8?B?NFNyZVRYY0NVcnhCSUJoM1NMN2NvWjgyQ1FuVUFIY3Jyc0NqMkUwd3k1K2E0?=
 =?utf-8?B?bVF6d25BbUNwMWR1b0RESEp0bmZwRDU4K0F2NkJVWDF3bXlNNUZuM3J2UUll?=
 =?utf-8?B?eUphaXc1aFhNQkJQQkpnVkR6bEVSMGovTWsrUXY5eFRURXZUcUlGalM1Zms5?=
 =?utf-8?B?Tkw1MEUvYzNxZFgrcSs0ZEFkNXgwRUR0MUw0clg2aTJZcSs2eTRMWXRPYjM0?=
 =?utf-8?B?b2ZQT1R0NG5kQkJXc1ZiZjZ1aXQvUjBDaHZhV0tlNjdKbUN6cWJzU0svOVdp?=
 =?utf-8?B?VWRPcXR4Zzl3WWQvY3pDVzJuK0ViSDM3eXVHbWlZUGZUSi9qT0xuVFFTbjkr?=
 =?utf-8?B?ZnRkbEh5akk0TmcyOU1ncmU0MG1CWU9SZDZta0V5Z2crRXcvMUlEcjZ0SS9r?=
 =?utf-8?B?Q0g1UG9VNThyblBjWjNJdEowZXovdEtDTmxjQjMxZmpwbkRVNUhhdks2QTdp?=
 =?utf-8?B?UytXNkZBb0xPcGZWeTMrTWdubXpiWVVzQy9YSzlsbE0rTkpvS0RXVjRKSFhk?=
 =?utf-8?B?cE9WQit4dWJMeFBhSEpuZ0t1SElWdkh2dVBQYXBtbVlzY3ZMaVVVbTZWZVhY?=
 =?utf-8?B?cTZUc3R5TUxOUkVTdE04Mm1rWStBbHdZREhBWis4U3NrY1FZSmg0UjI1Skpm?=
 =?utf-8?B?WlIvSkFLbVRaQWRRZDdMSERnZEQyZlREaGpzVnVHeFNiblJLYlpqUE92akJ6?=
 =?utf-8?B?YzBmNjQ1Y1lXOVN4Mzc1ZDhZNGJ5c0lSbk5WUndnamF4eElidzZHNXRaRXEw?=
 =?utf-8?B?SXZHQ0taN0JLeHZ3VGZpSzUwdTdpaWZTZ0diRlhxaXFOQ0pWazY3WkhIcVNG?=
 =?utf-8?B?RDB2UUt2QmFtTWJsOXB1ZnlqRGxqZlJqM1MxUVBjS1paT0E4Mi9uYjZnTmFx?=
 =?utf-8?B?Ujg3M3ZUdzMxVVNoOXh2MS9ObGxnL09ZcjVXcXoyd2ZIOUR3Y2hqT2pxVlZS?=
 =?utf-8?B?Njc5Q1YvczFWRzFOSTZCdGllZkdaNElyU1JKVDRQZ0tLZVJ0NUNoUjVqVVRq?=
 =?utf-8?B?b1RxTlJrd2FXeHRhYnBiemp2RTlyWHJOaWV2T0szamwzKzdpT2RyOXR5NUxI?=
 =?utf-8?B?ODBIVVhOVko3ckQvbzRFc09RYWdyckt3SjBtWFhsQzRYbFhEQXc2VFhJZ2lr?=
 =?utf-8?B?blNYMW5sRXBpaExrRW14eVBhandET2VKU1hxZTFnMUQ2bUxEZURMbmFqeVNC?=
 =?utf-8?B?Z0xIckxwZ0JVYXRrcm5qN3U4T05VWi9mamJiNE5Nc2VNTHIwQWhZRjFzdUcv?=
 =?utf-8?B?SExqZkZWdUpYVGI4NFF3UUhHaS9ETnNRaFBRZG1HTDhMNm5uZDVHMERDRjcx?=
 =?utf-8?B?dHl5bTJNdDMxUGR3aFUyK3R1MlQrYXFsNmhGUG5zZURzQUlTaWk1M0xOdFY2?=
 =?utf-8?B?SWdwZDRXYVFuWDNlWDdqaXJGbHJDQnNNemY4cS96aXRwLzMwZVB1akdkM3Yz?=
 =?utf-8?B?S2IyS3krMXdma25EbjR1UUxBYlM0OUIxVDZhbjhiQ2g5WHJEVG8rclZXdURO?=
 =?utf-8?B?YnlIVkpJZnJFSG50NGxyV0haY1JVcFNqTzJScE01TC9OeUJoVGxVbGFxRU1p?=
 =?utf-8?B?NGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tV4ID98DjTzhXgnvL7n131gypYsR8H49dZUaAnmC73EDxd7+mnuhGyRHG3RS9W7GmLjkBOitKfWEW07ESD42byjDADBqPpyEcNQdssbNJxsfdjIy6uWk0lFSrKddeb5Tr/hFQKR4hjvwB0GdHyhrTcHLPeuSEfljDgBScmYXCOiRjd8ifSNRpttivBzoykL6r6EKLAE8Xdv3q3sj59oj3H3lKT9n7U4aq4P3/h56R9NovFtcCGAf0ea6TxRQ1yDcpw6N1GhaWoRUyHkzPiLan4P+7paHGtKiUlHlJz+c5YGRPPSQ8+P4gjywKKEv3PgKVcCKk9BdEg/8bVx6QjG0/m6wmpKrCnWwpJxECrkx8XNrDas9deGMqxK6GrIPEe4skF783jGUNrKrYtJJKmApHdsJG2dT9aMg2+iE8vEejPCOeaZeFPTw+u2ZiGE1FZsFPRhi4YBSh1Vd/WlXV9ioknuEdszx6AkMK1F0wFwEZRCzTCBzNO7abI+dhJ6WRtQ7FM1CH5gMkH5nA2C+4eQppB5KE+mgvxnkfwJgYszGtwEeCxoR9oBPyzt9+7fBXgQdwwAIS0AzYAbs9s5PWK3C35s/TCeg46/UnJpaPxlsdNM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44670e66-29cb-4d93-75fb-08dcb61dceaa
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 13:43:51.9748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ygtZDpkmUCbOrtZSEI5oyGVSA2418uqRakVoT8JT/RfuTuu4Uvac5HGDlMfgnC5mrapIIi4+mot4N4lQ3gTvyWuKjxSVwQiDJXjTedMdOco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8145
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_11,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408060095
X-Proofpoint-GUID: VVRIB-l6m8nsGY4qFIT9dJXyLjzgNJgZ
X-Proofpoint-ORIG-GUID: VVRIB-l6m8nsGY4qFIT9dJXyLjzgNJgZ

On Tue, Aug 06, 2024 at 02:47:54PM GMT, Petr Tesařík wrote:
> Hi Lorenzo!
>
> On Mon,  5 Aug 2024 13:13:49 +0100
> Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> > Rather than passing around huge numbers of parameters to numerous helper
> > functions, abstract them into a single struct that we thread through the
> > operation.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >  mm/mmap.c |  76 ++++++++------
> >  mm/vma.c  | 297 ++++++++++++++++++++++++++++++++++++++----------------
> >  mm/vma.h  |  92 ++++++++---------
> >  3 files changed, 294 insertions(+), 171 deletions(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 4a9c2329b09a..f931000c561f 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -1369,9 +1369,16 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  	unsigned long end = addr + len;
> >  	unsigned long merge_start = addr, merge_end = end;
> >  	bool writable_file_mapping = false;
> > -	pgoff_t vm_pgoff;
> >  	int error;
> >  	VMA_ITERATOR(vmi, mm, addr);
> > +	struct vma_merge_struct vmg = {
> > +		.vmi = &vmi,
> > +		.start = addr,
> > +		.end = end,
> > +		.flags = vm_flags,
> > +		.pgoff = pgoff,
> > +		.file = file,
> > +	};
> >
> >  	/* Check against address space limit. */
> >  	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
> > @@ -1405,8 +1412,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  		vm_flags |= VM_ACCOUNT;
> >  	}
> >
> > -	next = vma_next(&vmi);
> > -	prev = vma_prev(&vmi);
> > +	next = vmg.next = vma_next(&vmi);
> > +	prev = vmg.prev = vma_prev(&vmi);
>
> So, next is now a shortcut for vmg.next, and prev is a shortcut for
> vmg.prev. ATM there is only one assignment, so no big deal, but I
> wonder if next and prev could be removed instead, same as you replaced
> vm_pgoff with vmg.pgoff.

It's simply to avoid repeatedly referencing vmg.xxx / at least reduce
_some_ churn. Also this will get moved shortly, so it's worth looking at in
final form.

>
> Is the resulting code _too_ ugly?
>
> >  	if (vm_flags & VM_SPECIAL) {
> >  		if (prev)
> >  			vma_iter_next_range(&vmi);
> > @@ -1416,29 +1423,30 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  	/* Attempt to expand an old mapping */
> >  	/* Check next */
> >  	if (next && next->vm_start == end && !vma_policy(next) &&
> > -	    can_vma_merge_before(next, vm_flags, NULL, file, pgoff+pglen,
> > -				 NULL_VM_UFFD_CTX, NULL)) {
> > +	    can_vma_merge_before(&vmg)) {
> >  		merge_end = next->vm_end;
> >  		vma = next;
> > -		vm_pgoff = next->vm_pgoff - pglen;
> > +		vmg.pgoff = next->vm_pgoff - pglen;
> > +	}
> > +
> > +	if (vma) {
> > +		vmg.anon_vma = vma->anon_vma;
> > +		vmg.uffd_ctx = vma->vm_userfaultfd_ctx;
> >  	}
> >
> >  	/* Check prev */
> >  	if (prev && prev->vm_end == addr && !vma_policy(prev) &&
> > -	    (vma ? can_vma_merge_after(prev, vm_flags, vma->anon_vma, file,
> > -				       pgoff, vma->vm_userfaultfd_ctx, NULL) :
> > -		   can_vma_merge_after(prev, vm_flags, NULL, file, pgoff,
> > -				       NULL_VM_UFFD_CTX, NULL))) {
> > +	    can_vma_merge_after(&vmg)) {
> >  		merge_start = prev->vm_start;
> >  		vma = prev;
> > -		vm_pgoff = prev->vm_pgoff;
> > +		vmg.pgoff = prev->vm_pgoff;
> >  	} else if (prev) {
> >  		vma_iter_next_range(&vmi);
> >  	}
> >
> >  	/* Actually expand, if possible */
> >  	if (vma &&
> > -	    !vma_expand(&vmi, vma, merge_start, merge_end, vm_pgoff, next)) {
> > +	    !vma_expand(&vmi, vma, merge_start, merge_end, vmg.pgoff, next)) {
> >  		khugepaged_enter_vma(vma, vm_flags);
> >  		goto expanded;
> >  	}
> > @@ -1790,25 +1798,31 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
> >  	 * Expand the existing vma if possible; Note that singular lists do not
> >  	 * occur after forking, so the expand will only happen on new VMAs.
> >  	 */
> > -	if (vma && vma->vm_end == addr && !vma_policy(vma) &&
> > -	    can_vma_merge_after(vma, flags, NULL, NULL,
> > -				addr >> PAGE_SHIFT, NULL_VM_UFFD_CTX, NULL)) {
> > -		vma_iter_config(vmi, vma->vm_start, addr + len);
> > -		if (vma_iter_prealloc(vmi, vma))
> > -			goto unacct_fail;
> > -
> > -		vma_start_write(vma);
> > -
> > -		init_vma_prep(&vp, vma);
> > -		vma_prepare(&vp);
> > -		vma_adjust_trans_huge(vma, vma->vm_start, addr + len, 0);
> > -		vma->vm_end = addr + len;
> > -		vm_flags_set(vma, VM_SOFTDIRTY);
> > -		vma_iter_store(vmi, vma);
> > -
> > -		vma_complete(&vp, vmi, mm);
> > -		khugepaged_enter_vma(vma, flags);
> > -		goto out;
> > +	if (vma && vma->vm_end == addr && !vma_policy(vma)) {
> > +		struct vma_merge_struct vmg = {
> > +			.prev = vma,
> > +			.flags = flags,
> > +			.pgoff = addr >> PAGE_SHIFT,
> > +		};
> > +
> > +		if (can_vma_merge_after(&vmg)) {
> > +			vma_iter_config(vmi, vma->vm_start, addr + len);
> > +			if (vma_iter_prealloc(vmi, vma))
> > +				goto unacct_fail;
> > +
> > +			vma_start_write(vma);
> > +
> > +			init_vma_prep(&vp, vma);
> > +			vma_prepare(&vp);
> > +			vma_adjust_trans_huge(vma, vma->vm_start, addr + len, 0);
> > +			vma->vm_end = addr + len;
> > +			vm_flags_set(vma, VM_SOFTDIRTY);
> > +			vma_iter_store(vmi, vma);
> > +
> > +			vma_complete(&vp, vmi, mm);
> > +			khugepaged_enter_vma(vma, flags);
> > +			goto out;
> > +		}
> >  	}
> >
> >  	if (vma)
> > diff --git a/mm/vma.c b/mm/vma.c
> > index bf0546fe6eab..20c4ce7712c0 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> > @@ -7,16 +7,18 @@
> >  #include "vma_internal.h"
> >  #include "vma.h"
> >
> > -/*
> > - * If the vma has a ->close operation then the driver probably needs to release
> > - * per-vma resources, so we don't attempt to merge those if the caller indicates
> > - * the current vma may be removed as part of the merge.
> > - */
> > -static inline bool is_mergeable_vma(struct vm_area_struct *vma,
> > -		struct file *file, unsigned long vm_flags,
> > -		struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
> > -		struct anon_vma_name *anon_name, bool may_remove_vma)
> > +static inline bool is_mergeable_vma(struct vma_merge_struct *vmg, bool merge_next)
> >  {
> > +	struct vm_area_struct *vma = merge_next ? vmg->next : vmg->prev;
> > +	/*
> > +	 * If the vma has a ->close operation then the driver probably needs to
> > +	 * release per-vma resources, so we don't attempt to merge those if the
> > +	 * caller indicates the current vma may be removed as part of the merge,
> > +	 * which is the case if we are attempting to merge the next VMA into
> > +	 * this one.
> > +	 */
> > +	bool may_remove_vma = merge_next;
> > +
>
> This variable is used only once. If you want to clarify the double
> meaning of the merge_next parameter, consider moving this comment
> further down to the conditional and merely renaming the parameter.
>
> >  	/*
> >  	 * VM_SOFTDIRTY should not prevent from VMA merging, if we
> >  	 * match the flags but dirty bit -- the caller should mark
> > @@ -25,15 +27,15 @@ static inline bool is_mergeable_vma(struct vm_area_struct *vma,
> >  	 * the kernel to generate new VMAs when old one could be
> >  	 * extended instead.
> >  	 */
> > -	if ((vma->vm_flags ^ vm_flags) & ~VM_SOFTDIRTY)
> > +	if ((vma->vm_flags ^ vmg->flags) & ~VM_SOFTDIRTY)
> >  		return false;
> > -	if (vma->vm_file != file)
> > +	if (vma->vm_file != vmg->file)
> >  		return false;
> >  	if (may_remove_vma && vma->vm_ops && vma->vm_ops->close)
>
> AFAICS this is the only place where may_remove_vma is used.

Yes it is, but the point is to document what we're doing. The compiler
simplifies all this in the generated code.

>
> >  		return false;
> > -	if (!is_mergeable_vm_userfaultfd_ctx(vma, vm_userfaultfd_ctx))
> > +	if (!is_mergeable_vm_userfaultfd_ctx(vma, vmg->uffd_ctx))
> >  		return false;
> > -	if (!anon_vma_name_eq(anon_vma_name(vma), anon_name))
> > +	if (!anon_vma_name_eq(anon_vma_name(vma), vmg->anon_name))
> >  		return false;
> >  	return true;
> >  }
> > @@ -94,16 +96,16 @@ static void init_multi_vma_prep(struct vma_prepare *vp,
> >   * We assume the vma may be removed as part of the merge.
> >   */
> >  bool
> > -can_vma_merge_before(struct vm_area_struct *vma, unsigned long vm_flags,
> > -		struct anon_vma *anon_vma, struct file *file,
> > -		pgoff_t vm_pgoff, struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
> > -		struct anon_vma_name *anon_name)
> > +can_vma_merge_before(struct vma_merge_struct *vmg)
> >  {
> > -	if (is_mergeable_vma(vma, file, vm_flags, vm_userfaultfd_ctx, anon_name, true) &&
> > -	    is_mergeable_anon_vma(anon_vma, vma->anon_vma, vma)) {
> > -		if (vma->vm_pgoff == vm_pgoff)
> > +	pgoff_t pglen = PHYS_PFN(vmg->end - vmg->start);
> > +
> > +	if (is_mergeable_vma(vmg, true) &&
> > +	    is_mergeable_anon_vma(vmg->anon_vma, vmg->next->anon_vma, vmg->next)) {
> > +		if (vmg->next->vm_pgoff == vmg->pgoff + pglen)
> >  			return true;
> >  	}
> > +
> >  	return false;
> >  }
> >
> > @@ -116,18 +118,11 @@ can_vma_merge_before(struct vm_area_struct *vma, unsigned long vm_flags,
> >   *
> >   * We assume that vma is not removed as part of the merge.
> >   */
> > -bool
> > -can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
> > -		struct anon_vma *anon_vma, struct file *file,
> > -		pgoff_t vm_pgoff, struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
> > -		struct anon_vma_name *anon_name)
> > +bool can_vma_merge_after(struct vma_merge_struct *vmg)
> >  {
> > -	if (is_mergeable_vma(vma, file, vm_flags, vm_userfaultfd_ctx, anon_name, false) &&
> > -	    is_mergeable_anon_vma(anon_vma, vma->anon_vma, vma)) {
> > -		pgoff_t vm_pglen;
> > -
> > -		vm_pglen = vma_pages(vma);
> > -		if (vma->vm_pgoff + vm_pglen == vm_pgoff)
> > +	if (is_mergeable_vma(vmg, false) &&
> > +	    is_mergeable_anon_vma(vmg->anon_vma, vmg->prev->anon_vma, vmg->prev)) {
> > +		if (vmg->prev->vm_pgoff + vma_pages(vmg->prev) == vmg->pgoff)
> >  			return true;
> >  	}
> >  	return false;
> > @@ -180,7 +175,7 @@ void unmap_region(struct mm_struct *mm, struct ma_state *mas,
> >   * VMA Iterator will point to the end VMA.
> >   */
> >  static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
> > -		       unsigned long addr, int new_below)
> > +		       unsigned long addr, bool new_below)
> >  {
> >  	struct vma_prepare vp;
> >  	struct vm_area_struct *new;
> > @@ -261,13 +256,14 @@ static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
> >   * Split a vma into two pieces at address 'addr', a new vma is allocated
> >   * either for the first part or the tail.
> >   */
> > -static int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
> > -		     unsigned long addr, int new_below)
> > +static int split_vma(struct vma_merge_struct *vmg, bool new_below)
>
> IMHO this patch is already long enough. Maybe the type change from int
> to bool could be split out to a separate patch to reduce churn here?

I don't really understand this comment. This reduces the number of lines of
code, and it's a line I have to change anyway, so there'd be _more_ churn
to split this out?

I don't think this is really all that important, but it'd be very silly to
split this out in my opinion.

>
> >  {
> > -	if (vma->vm_mm->map_count >= sysctl_max_map_count)
> > +	if (vmg->vma->vm_mm->map_count >= sysctl_max_map_count)
> >  		return -ENOMEM;
> >
> > -	return __split_vma(vmi, vma, addr, new_below);
> > +	return __split_vma(vmg->vmi, vmg->vma,
> > +			   new_below ? vmg->start : vmg->end,
> > +			   new_below);
> >  }
> >
> >  /*
> > @@ -712,7 +708,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
> >  		if (end < vma->vm_end && mm->map_count >= sysctl_max_map_count)
> >  			goto map_count_exceeded;
> >
> > -		error = __split_vma(vmi, vma, start, 1);
> > +		error = __split_vma(vmi, vma, start, true);
> >  		if (error)
> >  			goto start_split_failed;
> >  	}
> > @@ -725,7 +721,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
> >  	do {
> >  		/* Does it split the end? */
> >  		if (next->vm_end > end) {
> > -			error = __split_vma(vmi, next, end, 0);
> > +			error = __split_vma(vmi, next, end, false);
> >  			if (error)
> >  				goto end_split_failed;
> >  		}
> > @@ -934,16 +930,10 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
> >   * **** is not represented - it will be merged and the vma containing the
> >   *      area is returned, or the function will return NULL
> >   */
> > -static struct vm_area_struct
> > -*vma_merge(struct vma_iterator *vmi, struct vm_area_struct *prev,
> > -	   struct vm_area_struct *src, unsigned long addr, unsigned long end,
> > -	   unsigned long vm_flags, pgoff_t pgoff, struct mempolicy *policy,
> > -	   struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
> > -	   struct anon_vma_name *anon_name)
> > +static struct vm_area_struct *vma_merge(struct vma_merge_struct *vmg)
> >  {
> > -	struct mm_struct *mm = src->vm_mm;
> > -	struct anon_vma *anon_vma = src->anon_vma;
> > -	struct file *file = src->vm_file;
> > +	struct mm_struct *mm = container_of(vmg->vmi->mas.tree, struct mm_struct, mm_mt);
> > +	struct vm_area_struct *prev = vmg->prev;
> >  	struct vm_area_struct *curr, *next, *res;
> >  	struct vm_area_struct *vma, *adjust, *remove, *remove2;
> >  	struct vm_area_struct *anon_dup = NULL;
> > @@ -953,16 +943,18 @@ static struct vm_area_struct
> >  	bool merge_prev = false;
> >  	bool merge_next = false;
> >  	bool vma_expanded = false;
> > +	unsigned long addr = vmg->start;
> > +	unsigned long end = vmg->end;
> >  	unsigned long vma_start = addr;
> >  	unsigned long vma_end = end;
> > -	pgoff_t pglen = (end - addr) >> PAGE_SHIFT;
> > +	pgoff_t pglen = PHYS_PFN(end - addr);
> >  	long adj_start = 0;
> >
> >  	/*
> >  	 * We later require that vma->vm_flags == vm_flags,
> >  	 * so this tests vma->vm_flags & VM_SPECIAL, too.
> >  	 */
> > -	if (vm_flags & VM_SPECIAL)
> > +	if (vmg->flags & VM_SPECIAL)
> >  		return NULL;
> >
> >  	/* Does the input range span an existing VMA? (cases 5 - 8) */
> > @@ -970,27 +962,26 @@ static struct vm_area_struct
> >
> >  	if (!curr ||			/* cases 1 - 4 */
> >  	    end == curr->vm_end)	/* cases 6 - 8, adjacent VMA */
> > -		next = vma_lookup(mm, end);
> > +		next = vmg->next = vma_lookup(mm, end);
> >  	else
> > -		next = NULL;		/* case 5 */
> > +		next = vmg->next = NULL;	/* case 5 */
>
> Again, is it worth keeping the "next" variable, or could we replace it
> with "vmg->next" everywhere?

I already responded previously but equally, I'm explicitly using a local
variable to keep the code relatively simple and to not be constantly
ostensibly dereferencing vmg.

>
> No other comments to the rest of this patch.
>
> Petr T
>
> >
> >  	if (prev) {
> >  		vma_start = prev->vm_start;
> >  		vma_pgoff = prev->vm_pgoff;
> >
> >  		/* Can we merge the predecessor? */
> > -		if (addr == prev->vm_end && mpol_equal(vma_policy(prev), policy)
> > -		    && can_vma_merge_after(prev, vm_flags, anon_vma, file,
> > -					   pgoff, vm_userfaultfd_ctx, anon_name)) {
> > +		if (addr == prev->vm_end && mpol_equal(vma_policy(prev), vmg->policy)
> > +		    && can_vma_merge_after(vmg)) {
> > +
> >  			merge_prev = true;
> > -			vma_prev(vmi);
> > +			vma_prev(vmg->vmi);
> >  		}
> >  	}
> >
> >  	/* Can we merge the successor? */
> > -	if (next && mpol_equal(policy, vma_policy(next)) &&
> > -	    can_vma_merge_before(next, vm_flags, anon_vma, file, pgoff+pglen,
> > -				 vm_userfaultfd_ctx, anon_name)) {
> > +	if (next && mpol_equal(vmg->policy, vma_policy(next)) &&
> > +	    can_vma_merge_before(vmg)) {
> >  		merge_next = true;
> >  	}
> >
> > @@ -1041,7 +1032,7 @@ static struct vm_area_struct
> >  				remove = curr;
> >  			} else {			/* case 5 */
> >  				adjust = curr;
> > -				adj_start = (end - curr->vm_start);
> > +				adj_start = end - curr->vm_start;
> >  			}
> >  			if (!err)
> >  				err = dup_anon_vma(prev, curr, &anon_dup);
> > @@ -1081,13 +1072,13 @@ static struct vm_area_struct
> >  		vma_expanded = true;
> >
> >  	if (vma_expanded) {
> > -		vma_iter_config(vmi, vma_start, vma_end);
> > +		vma_iter_config(vmg->vmi, vma_start, vma_end);
> >  	} else {
> > -		vma_iter_config(vmi, adjust->vm_start + adj_start,
> > +		vma_iter_config(vmg->vmi, adjust->vm_start + adj_start,
> >  				adjust->vm_end);
> >  	}
> >
> > -	if (vma_iter_prealloc(vmi, vma))
> > +	if (vma_iter_prealloc(vmg->vmi, vma))
> >  		goto prealloc_fail;
> >
> >  	init_multi_vma_prep(&vp, vma, adjust, remove, remove2);
> > @@ -1099,19 +1090,19 @@ static struct vm_area_struct
> >  	vma_set_range(vma, vma_start, vma_end, vma_pgoff);
> >
> >  	if (vma_expanded)
> > -		vma_iter_store(vmi, vma);
> > +		vma_iter_store(vmg->vmi, vma);
> >
> >  	if (adj_start) {
> >  		adjust->vm_start += adj_start;
> >  		adjust->vm_pgoff += adj_start >> PAGE_SHIFT;
> >  		if (adj_start < 0) {
> >  			WARN_ON(vma_expanded);
> > -			vma_iter_store(vmi, next);
> > +			vma_iter_store(vmg->vmi, next);
> >  		}
> >  	}
> >
> > -	vma_complete(&vp, vmi, mm);
> > -	khugepaged_enter_vma(res, vm_flags);
> > +	vma_complete(&vp, vmg->vmi, mm);
> > +	khugepaged_enter_vma(res, vmg->flags);
> >  	return res;
> >
> >  prealloc_fail:
> > @@ -1119,8 +1110,8 @@ static struct vm_area_struct
> >  		unlink_anon_vmas(anon_dup);
> >
> >  anon_vma_fail:
> > -	vma_iter_set(vmi, addr);
> > -	vma_iter_load(vmi);
> > +	vma_iter_set(vmg->vmi, addr);
> > +	vma_iter_load(vmg->vmi);
> >  	return NULL;
> >  }
> >
> > @@ -1137,38 +1128,141 @@ static struct vm_area_struct
> >   * The function returns either the merged VMA, the original VMA if a split was
> >   * required instead, or an error if the split failed.
> >   */
> > -struct vm_area_struct *vma_modify(struct vma_iterator *vmi,
> > -				  struct vm_area_struct *prev,
> > -				  struct vm_area_struct *vma,
> > -				  unsigned long start, unsigned long end,
> > -				  unsigned long vm_flags,
> > -				  struct mempolicy *policy,
> > -				  struct vm_userfaultfd_ctx uffd_ctx,
> > -				  struct anon_vma_name *anon_name)
> > +static struct vm_area_struct *vma_modify(struct vma_merge_struct *vmg)
> >  {
> > -	pgoff_t pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
> > +	struct vm_area_struct *vma = vmg->vma;
> >  	struct vm_area_struct *merged;
> >
> > -	merged = vma_merge(vmi, prev, vma, start, end, vm_flags,
> > -			   pgoff, policy, uffd_ctx, anon_name);
> > +	/* First, try to merge. */
> > +	merged = vma_merge(vmg);
> >  	if (merged)
> >  		return merged;
> >
> > -	if (vma->vm_start < start) {
> > -		int err = split_vma(vmi, vma, start, 1);
> > +	/* Split any preceding portion of the VMA. */
> > +	if (vma->vm_start < vmg->start) {
> > +		int err = split_vma(vmg, true);
> >
> >  		if (err)
> >  			return ERR_PTR(err);
> >  	}
> >
> > -	if (vma->vm_end > end) {
> > -		int err = split_vma(vmi, vma, end, 0);
> > +	/* Split any trailing portion of the VMA. */
> > +	if (vma->vm_end > vmg->end) {
> > +		int err = split_vma(vmg, false);
> >
> >  		if (err)
> >  			return ERR_PTR(err);
> >  	}
> >
> > -	return vma;
> > +	return vmg->vma;
> > +}
> > +
> > +/* Assumes addr >= vma->vm_start. */
> > +static pgoff_t vma_pgoff_offset(struct vm_area_struct *vma, unsigned long addr)
> > +{
> > +	return vma->vm_pgoff + PHYS_PFN(addr - vma->vm_start);
> > +}
> > +
> > +struct vm_area_struct *vma_modify_flags(struct vma_iterator *vmi,
> > +					struct vm_area_struct *prev,
> > +					struct vm_area_struct *vma,
> > +					unsigned long start, unsigned long end,
> > +					unsigned long new_flags)
> > +{
> > +	struct vma_merge_struct vmg = {
> > +		.vmi = vmi,
> > +		.prev = prev,
> > +		.vma = vma,
> > +		.start = start,
> > +		.end = end,
> > +		.flags = new_flags,
> > +		.pgoff = vma_pgoff_offset(vma, start),
> > +		.file = vma->vm_file,
> > +		.anon_vma = vma->anon_vma,
> > +		.policy = vma_policy(vma),
> > +		.uffd_ctx = vma->vm_userfaultfd_ctx,
> > +		.anon_name = anon_vma_name(vma),
> > +	};
> > +
> > +	return vma_modify(&vmg);
> > +}
> > +
> > +struct vm_area_struct
> > +*vma_modify_flags_name(struct vma_iterator *vmi,
> > +		       struct vm_area_struct *prev,
> > +		       struct vm_area_struct *vma,
> > +		       unsigned long start,
> > +		       unsigned long end,
> > +		       unsigned long new_flags,
> > +		       struct anon_vma_name *new_name)
> > +{
> > +	struct vma_merge_struct vmg = {
> > +		.vmi = vmi,
> > +		.prev = prev,
> > +		.vma = vma,
> > +		.start = start,
> > +		.end = end,
> > +		.flags = new_flags,
> > +		.pgoff = vma_pgoff_offset(vma, start),
> > +		.file = vma->vm_file,
> > +		.anon_vma = vma->anon_vma,
> > +		.policy = vma_policy(vma),
> > +		.uffd_ctx = vma->vm_userfaultfd_ctx,
> > +		.anon_name = new_name,
> > +	};
> > +
> > +	return vma_modify(&vmg);
> > +}
> > +
> > +struct vm_area_struct
> > +*vma_modify_policy(struct vma_iterator *vmi,
> > +		   struct vm_area_struct *prev,
> > +		   struct vm_area_struct *vma,
> > +		   unsigned long start, unsigned long end,
> > +		   struct mempolicy *new_pol)
> > +{
> > +	struct vma_merge_struct vmg = {
> > +		.vmi = vmi,
> > +		.prev = prev,
> > +		.vma = vma,
> > +		.start = start,
> > +		.end = end,
> > +		.flags = vma->vm_flags,
> > +		.pgoff = vma_pgoff_offset(vma, start),
> > +		.file = vma->vm_file,
> > +		.anon_vma = vma->anon_vma,
> > +		.policy = new_pol,
> > +		.uffd_ctx = vma->vm_userfaultfd_ctx,
> > +		.anon_name = anon_vma_name(vma),
> > +	};
> > +
> > +	return vma_modify(&vmg);
> > +}
> > +
> > +struct vm_area_struct
> > +*vma_modify_flags_uffd(struct vma_iterator *vmi,
> > +		       struct vm_area_struct *prev,
> > +		       struct vm_area_struct *vma,
> > +		       unsigned long start, unsigned long end,
> > +		       unsigned long new_flags,
> > +		       struct vm_userfaultfd_ctx new_ctx)
> > +{
> > +	struct vma_merge_struct vmg = {
> > +		.vmi = vmi,
> > +		.prev = prev,
> > +		.vma = vma,
> > +		.start = start,
> > +		.end = end,
> > +		.flags = new_flags,
> > +		.file = vma->vm_file,
> > +		.anon_vma = vma->anon_vma,
> > +		.pgoff = vma_pgoff_offset(vma, start),
> > +		.policy = vma_policy(vma),
> > +		.uffd_ctx = new_ctx,
> > +		.anon_name = anon_vma_name(vma),
> > +	};
> > +
> > +	return vma_modify(&vmg);
> >  }
> >
> >  /*
> > @@ -1180,8 +1274,22 @@ struct vm_area_struct
> >  		   struct vm_area_struct *vma, unsigned long start,
> >  		   unsigned long end, pgoff_t pgoff)
> >  {
> > -	return vma_merge(vmi, prev, vma, start, end, vma->vm_flags, pgoff,
> > -			 vma_policy(vma), vma->vm_userfaultfd_ctx, anon_vma_name(vma));
> > +	struct vma_merge_struct vmg = {
> > +		.vmi = vmi,
> > +		.prev = prev,
> > +		.vma = vma,
> > +		.start = start,
> > +		.end = end,
> > +		.flags = vma->vm_flags,
> > +		.file = vma->vm_file,
> > +		.anon_vma = vma->anon_vma,
> > +		.pgoff = pgoff,
> > +		.policy = vma_policy(vma),
> > +		.uffd_ctx = vma->vm_userfaultfd_ctx,
> > +		.anon_name = anon_vma_name(vma),
> > +	};
> > +
> > +	return vma_merge(&vmg);
> >  }
> >
> >  /*
> > @@ -1193,11 +1301,22 @@ struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
> >  					unsigned long delta)
> >  {
> >  	pgoff_t pgoff = vma->vm_pgoff + vma_pages(vma);
> > +	struct vma_merge_struct vmg = {
> > +		.vmi = vmi,
> > +		.prev = vma,
> > +		.vma = vma,
> > +		.start = vma->vm_end,
> > +		.end = vma->vm_end + delta,
> > +		.flags = vma->vm_flags,
> > +		.file = vma->vm_file,
> > +		.pgoff = pgoff,
> > +		.policy = vma_policy(vma),
> > +		.uffd_ctx = vma->vm_userfaultfd_ctx,
> > +		.anon_name = anon_vma_name(vma),
> > +	};
> >
> >  	/* vma is specified as prev, so case 1 or 2 will apply. */
> > -	return vma_merge(vmi, vma, vma, vma->vm_end, vma->vm_end + delta,
> > -			 vma->vm_flags, pgoff, vma_policy(vma),
> > -			 vma->vm_userfaultfd_ctx, anon_vma_name(vma));
> > +	return vma_merge(&vmg);
> >  }
> >
> >  void unlink_file_vma_batch_init(struct unlink_vma_file_batch *vb)
> > diff --git a/mm/vma.h b/mm/vma.h
> > index 6efdf1768a0a..c31684cc1da6 100644
> > --- a/mm/vma.h
> > +++ b/mm/vma.h
> > @@ -26,6 +26,23 @@ struct unlink_vma_file_batch {
> >  	struct vm_area_struct *vmas[8];
> >  };
> >
> > +/* Represents a VMA merge operation. */
> > +struct vma_merge_struct {
> > +	struct vma_iterator *vmi;
> > +	struct vm_area_struct *prev;
> > +	struct vm_area_struct *next; /* Modified by vma_merge(). */
> > +	struct vm_area_struct *vma; /* Either a new VMA or the one being modified. */
> > +	unsigned long start;
> > +	unsigned long end;
> > +	unsigned long flags;
> > +	pgoff_t pgoff;
> > +	struct file *file;
> > +	struct anon_vma *anon_vma;
> > +	struct mempolicy *policy;
> > +	struct vm_userfaultfd_ctx uffd_ctx;
> > +	struct anon_vma_name *anon_name;
> > +};
> > +
> >  #ifdef CONFIG_DEBUG_VM_MAPLE_TREE
> >  void validate_mm(struct mm_struct *mm);
> >  #else
> > @@ -72,80 +89,53 @@ void unmap_region(struct mm_struct *mm, struct ma_state *mas,
> >  		struct vm_area_struct *next, unsigned long start,
> >  		unsigned long end, unsigned long tree_end, bool mm_wr_locked);
> >
> > -/* Required by mmap_region(). */
> > -bool
> > -can_vma_merge_before(struct vm_area_struct *vma, unsigned long vm_flags,
> > -		struct anon_vma *anon_vma, struct file *file,
> > -		pgoff_t vm_pgoff, struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
> > -		struct anon_vma_name *anon_name);
> > -
> > -/* Required by mmap_region() and do_brk_flags(). */
> > -bool
> > -can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
> > -		struct anon_vma *anon_vma, struct file *file,
> > -		pgoff_t vm_pgoff, struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
> > -		struct anon_vma_name *anon_name);
> > -
> > -struct vm_area_struct *vma_modify(struct vma_iterator *vmi,
> > -				  struct vm_area_struct *prev,
> > -				  struct vm_area_struct *vma,
> > -				  unsigned long start, unsigned long end,
> > -				  unsigned long vm_flags,
> > -				  struct mempolicy *policy,
> > -				  struct vm_userfaultfd_ctx uffd_ctx,
> > -				  struct anon_vma_name *anon_name);
> > +/*
> > + * Can we merge the VMA described by vmg into the following VMA vmg->next?
> > + *
> > + * Required by mmap_region().
> > + */
> > +bool can_vma_merge_before(struct vma_merge_struct *vmg);
> > +
> > +/*
> > + * Can we merge the VMA described by vmg into the preceding VMA vmg->prev?
> > + *
> > + * Required by mmap_region() and do_brk_flags().
> > + */
> > +bool can_vma_merge_after(struct vma_merge_struct *vmg);
> >
> >  /* We are about to modify the VMA's flags. */
> > -static inline struct vm_area_struct
> > -*vma_modify_flags(struct vma_iterator *vmi,
> > -		  struct vm_area_struct *prev,
> > -		  struct vm_area_struct *vma,
> > -		  unsigned long start, unsigned long end,
> > -		  unsigned long new_flags)
> > -{
> > -	return vma_modify(vmi, prev, vma, start, end, new_flags,
> > -			  vma_policy(vma), vma->vm_userfaultfd_ctx,
> > -			  anon_vma_name(vma));
> > -}
> > +struct vm_area_struct *vma_modify_flags(struct vma_iterator *vmi,
> > +					struct vm_area_struct *prev,
> > +					struct vm_area_struct *vma,
> > +					unsigned long start, unsigned long end,
> > +					unsigned long new_flags);
> >
> >  /* We are about to modify the VMA's flags and/or anon_name. */
> > -static inline struct vm_area_struct
> > +struct vm_area_struct
> >  *vma_modify_flags_name(struct vma_iterator *vmi,
> >  		       struct vm_area_struct *prev,
> >  		       struct vm_area_struct *vma,
> >  		       unsigned long start,
> >  		       unsigned long end,
> >  		       unsigned long new_flags,
> > -		       struct anon_vma_name *new_name)
> > -{
> > -	return vma_modify(vmi, prev, vma, start, end, new_flags,
> > -			  vma_policy(vma), vma->vm_userfaultfd_ctx, new_name);
> > -}
> > +		       struct anon_vma_name *new_name);
> >
> >  /* We are about to modify the VMA's memory policy. */
> > -static inline struct vm_area_struct
> > +struct vm_area_struct
> >  *vma_modify_policy(struct vma_iterator *vmi,
> >  		   struct vm_area_struct *prev,
> >  		   struct vm_area_struct *vma,
> >  		   unsigned long start, unsigned long end,
> > -		   struct mempolicy *new_pol)
> > -{
> > -	return vma_modify(vmi, prev, vma, start, end, vma->vm_flags,
> > -			  new_pol, vma->vm_userfaultfd_ctx, anon_vma_name(vma));
> > -}
> > +		   struct mempolicy *new_pol);
> >
> >  /* We are about to modify the VMA's flags and/or uffd context. */
> > -static inline struct vm_area_struct
> > +struct vm_area_struct
> >  *vma_modify_flags_uffd(struct vma_iterator *vmi,
> >  		       struct vm_area_struct *prev,
> >  		       struct vm_area_struct *vma,
> >  		       unsigned long start, unsigned long end,
> >  		       unsigned long new_flags,
> > -		       struct vm_userfaultfd_ctx new_ctx)
> > -{
> > -	return vma_modify(vmi, prev, vma, start, end, new_flags,
> > -			  vma_policy(vma), new_ctx, anon_vma_name(vma));
> > -}
> > +		       struct vm_userfaultfd_ctx new_ctx);
> >
> >  struct vm_area_struct
> >  *vma_merge_new_vma(struct vma_iterator *vmi, struct vm_area_struct *prev,
>

