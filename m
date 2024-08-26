Return-Path: <linux-kernel+bounces-301650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 098FA95F3A1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DD771C21C45
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 14:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C3B4A21;
	Mon, 26 Aug 2024 14:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IUYKh6uY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GDs4r4PK"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174B056B72
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 14:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724681589; cv=fail; b=Lm1EzmmBPvNCjbX/LxInhhsgHQxAoQaSHSQ+OAMb9SNTyNyDWMVoD9hmV8m7/geiPccP6HnU0RRkiMmkDg8VpyscFXafESqGlPFIfstjeW15jGNDmWsdQdm/iMBMXxpPeP4/kltEfOoqEdukN6t07NRyR7vXdjYiAWI3SwkVNMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724681589; c=relaxed/simple;
	bh=apQql/7kukro4R06niqkVCn7cUUyhH+lG4ho5JkH9NA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hzEK8iz8D2nZMd725NqiVMmb/xq5erY51pqKuNMab1eiQN9eB3tHAdl7SIn7RcKHcRxDkoPqOHIpe7FjVAgUnoVgeuvCcukXTfaNgb5wSUeKrF0dJLrK/rBdcJa0cDIMurffBj358l8/z4W3QUg9ngMPaW/b3tWUjG+6GAJ6zWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IUYKh6uY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GDs4r4PK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47QE2bLp020965;
	Mon, 26 Aug 2024 14:12:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=Ol51GYo6wHNb/8vfRN7uSp623/ttEpAL+DPl/MHCkOI=; b=
	IUYKh6uYkoVGCZAe1Mq4rz4e5Yqf63avq8/gE+bNGIWKigiQQ2TfzTaPW9oVw3Pj
	g+GJRI7E3HD8Gj+JIbzlVWpFX9XsN1juUdvRppYlm/OwlUhDsbd2vbLBzBftTGat
	H5R/0oklp6i4LVsfOFAE2z9ai8IEcWX7onRStbiLrU+EwghBsi2nt1yFE6ezdqOQ
	n8zOHobR0NJ1qbqBEudPs2UCfXb7oHf16xMxk0qyejZPagAU2Av2OH8UDHbj7Fcp
	hIC1TaN4x+R/mBERefGxn9dVGpyW7hxzEWlIOmTgipcTNCAQgOCn2AwnCfofa0OZ
	ul82SlXoxZmlaGJ8OMv+Dg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4177hwk6tw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Aug 2024 14:12:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47QDKvfo016835;
	Mon, 26 Aug 2024 14:12:40 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 418a5r1x1f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Aug 2024 14:12:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HJloAW+tx+C1xdX+TEL9q2kRhlfRv82uz/I37jPXcIf/h61fPxvp06blTDEPl4lwuC3Ege63Kim4RuvNFK+/yIx6efwFrYbhFWq3yTXvqz1fJyjk828RzKzokCRE3I/2HvrH2sL5YXcc2bbX1uXm0MtnEAsiNkc0hcq3gDgbWsaCLmlxXsGuauKGGTHRpqTylyu+NODnxfzmcprEtf903ISMCYyfyUoRtTHZ9c53Eer7ZMCMWfair28IsDo+rUw6iTbBgR6zGzLDQDJVCO/LdxmEZIbujlgaUQZ42N7NAr3Fjwc6Xuqpc9frIoMcWw7BnUDmbi78AbjoPKvgW7XNAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ol51GYo6wHNb/8vfRN7uSp623/ttEpAL+DPl/MHCkOI=;
 b=ymJK9umvDyQVZQkbkIzHIoXHO+JlJLb09+JI3hey6h3qJgWLYFYCvAG3g3K/zxEMdlJv0T/4oINynT8YFDdIDuve1e1SfqlmYr+raLU3frs4E2gCWL3SfIbPAeFltxQE2Sg9gGKGPMAhUYCXdaQHAA3sMSYxaIcLn5f3G5nYDXmijwew5uL3VA6Cg3ZWHZ/FwaZFvSwjPeLYf3EgLqmj14pBPJ4AAWqTQocUFJNKF5GV/Yz30ddSh4/cifD68FICV6/64JzlwBWZBh+W/hhaa+voom6h6QA1J46ReGJKu/kbvjMFTtRukQCvRwvoqVeirkAWmpHUrIkCrd+YoedTlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ol51GYo6wHNb/8vfRN7uSp623/ttEpAL+DPl/MHCkOI=;
 b=GDs4r4PKSZhUQtX1XixNklMqgMDGlCxFDM50EpSDf0+g9feqPKJRyPRT2nlBGJvdOhCEPd7upFAfdm1GOZZ/twiaOO0kpshZ2N89Xdx3AxpszdSy7UthoaKLE2QQdgqcaPc2j6W0kfn0qG+gNfWB2gFdngxAVsiqCaWtsPKEiOo=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by PH0PR10MB5848.namprd10.prod.outlook.com (2603:10b6:510:149::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14; Mon, 26 Aug
 2024 14:12:37 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.7918.012; Mon, 26 Aug 2024
 14:12:37 +0000
Date: Mon, 26 Aug 2024 15:12:33 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v7 12/21] mm/vma: Track start and end for munmap in
 vma_munmap_struct
Message-ID: <3ffd3e53-0fcd-4d50-807f-e75e221558a3@lucifer.local>
References: <20240822192543.3359552-1-Liam.Howlett@oracle.com>
 <20240822192543.3359552-13-Liam.Howlett@oracle.com>
 <CAMuHMdW0HuK_26vejYL8nMwULwN8wFWS0-6HH69hOLuHzncwyA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdW0HuK_26vejYL8nMwULwN8wFWS0-6HH69hOLuHzncwyA@mail.gmail.com>
X-ClientProxiedBy: LO2P265CA0068.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::32) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|PH0PR10MB5848:EE_
X-MS-Office365-Filtering-Correlation-Id: 61ee6ddc-84b1-47f3-5914-08dcc5d9235f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QnBzOXBCcktQVGVUZ0IyWXE3WjcwUzJ6L2hIdXkzZDBOQVM0emhLZk4xd3hY?=
 =?utf-8?B?dHJYNTYrWVpqSmVBeDZHemlIK1dWR3QzeFJhQlNpeXlCb3dMUmIrZzRnME9m?=
 =?utf-8?B?b2UzY1c0YzUvL3REK2o4bTVyWkw1bE8zT3NMWkdYWG9OK1M5ajU2QXM4L2Vk?=
 =?utf-8?B?ODdMMnlaMlNObnY3N0poK0kwZDlWcmVWRzBKMzVvUGFUaFFVTlVURkUvSmxX?=
 =?utf-8?B?RDZaN3VzVVgwRm1HZzdPMWVRREVDSFFhcWRlSW1qNkk4VHRoTk15Y2lPc2RK?=
 =?utf-8?B?VmppQnNUWENxYkd4QUhSMWVvODJOR1EzT1V6bW5nOGVMMDNmNndKc2NEMmxS?=
 =?utf-8?B?dHhOakdXK0JFRXBLYi9ZZ3J4OVNMc3hwMGEwVm5LQ1lTRnJIY0lmRGN1cUxK?=
 =?utf-8?B?UjgvbmlxRFYrRlFVRy9ocHQ0c2E5UHlRRlMwUDQ4b0o1OUE5SFZtT25jVFRw?=
 =?utf-8?B?Mndxa2hMTFJyY0VpbGdNaFZvNlM5UUM2MVdNUVRENTdzV2t5dGE5QUN3ZE1n?=
 =?utf-8?B?akhEaEVzejZyN1Q4YU1FYkZheEdKbnc3TlcvU2dhSE9QQ0tvMzNxdUtxMHY0?=
 =?utf-8?B?SVdGMlF6cGRTMU11Rlk2VS80U21yRkJsUTB5dTZDVzJnMkVTeXRWbVdzd1VL?=
 =?utf-8?B?Nkc1UGl1d09SZjBlcDluY29sN284bW9CTDBVcUp0cFZGWS9qYzFYeXU3UjVv?=
 =?utf-8?B?L0dIcmNuVHpKY2lJaFNBUENzRHZZcHFxMXZ2NHpCUy9oOUYrb1YvZVEvZHoy?=
 =?utf-8?B?OWR2Zkd6V0F5WVdDTElIYmVDQnRZdXJjZzFHZDdxSGIzSExwbk1rVFlWclYr?=
 =?utf-8?B?V1hZMVAvd1FNTE1XUWtkMlhMRzd6RnhkbStvY3RRSng1WVNvUU00aWlYbEVC?=
 =?utf-8?B?MlFVREZqbW9IeXZQeVZOOWRzSXV0Mk1JdWZsck5SS3RMUzJJMWk0dnkyRTAy?=
 =?utf-8?B?c3l1QmtVdHNKb2NnWnljVWpWMmNpVzJlMVYxWHBOT05EMG9aL1JpRkU5eFdT?=
 =?utf-8?B?bklYajViZEhTcnE4dDhVMmp2bWNzdjNsNEp5R1V5T2tGcS9leFJkbVJDWGxl?=
 =?utf-8?B?RU9mMFQwZVZ2eU5yRE9McGtMbEZkZXEyVG4yNFJHdDcxdEs1NXZ0dnBOV0xm?=
 =?utf-8?B?UTIrdFhiQWRXTDA1ZnoxS0xQamNtVUxBZ2RBR0tmOFVkbHFIUkJiMUVLZFlk?=
 =?utf-8?B?cDZHQUNTdGhVK0hiRVNLa1FDUEFiSWpIc2xMSUJKbjI1NnNNNHdzeDZoYmVU?=
 =?utf-8?B?TjNHQTRQVXlmelNqbk5tTDJlTVVST2FHbXV5dFZpYk1xbUlYTFl4N2c4M0tF?=
 =?utf-8?B?dk5MMHViS0lxYU1ZS0JxWXBYV3lKSExVd0QrcWZPUDV0bUNQNUxRS3hWUjVF?=
 =?utf-8?B?NU1nOXVibXBRK0VGbUVVOTJnT3RGS0pYTnVpMkNXTjNoOWVsSGtmZTBpMFg0?=
 =?utf-8?B?OHpqMVhMNmlrVXMrWXhTS0kzRkhCd3Fxb2NwNVhna3BhTWFKOUNVWE1oRGJI?=
 =?utf-8?B?VU9HTTluQnRLWFFDM3JST2QrU0FsYkJrODJKRGJyUnRGdDRzR04rWXJxOTlJ?=
 =?utf-8?B?WmxaU1A1YmJRY1B3MEYrYzlSdm1SWVJtR1FkMDZyWVRzTmpPei9mLzRDMnRY?=
 =?utf-8?B?TEV0U2hiWFRIenh0dHRQcVlkS0hrSHdkK2NmVkhVYVYyWVE5WlFDUE5mSlFL?=
 =?utf-8?B?eENEVnl4Yy9iOThJUW1JQUg0UjRQS0JzUlJZa2xjTDNzNXRZOTNCWWs3ZFl1?=
 =?utf-8?Q?i2dHsQt2kh/HKoAW+c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzlaWVFmYitKRi81M0R4N1FtR3J3aHV0TnBHT1JaZVlUWnF6ekVlMEluQ0VM?=
 =?utf-8?B?SlhseThXYmhzODYxK1IzMTVXa25wUFBqazR5VURQMEg1RVFaUUZwNU5MM0dP?=
 =?utf-8?B?WTd3c2pXUzNWbmgxZERqRmhTSERES2p3QURDRlg4MHptNWdQR29kV1BzOUt6?=
 =?utf-8?B?SXJWaDVTZkc5M09id1UwY3E0NXNhUjI4WFBuWE5aSFhZdW1maWdwSlUrSUt5?=
 =?utf-8?B?eFVBT2RyS29TbEMzS1owVXp6V0w1MFAvWlRaWXpwZzJOUlVJTDE3ck93bEh2?=
 =?utf-8?B?MlZ1c0N6TkdURVBxNDAzb1dQT3FSZk1YbEdCY2E2OVRXTHFkL0syeEgvQnRw?=
 =?utf-8?B?TkxKNGhlSGRWRFBnbUNNSkdMZFp6UzQyU2xCWTRzV3pzVVArZ3BBNzRDM1hr?=
 =?utf-8?B?OU1HMER1a1l2U2VzNC9RZTVkcEJHOFJkUksvL3ZaRERTZ01TVFZ2cHM2WW5Y?=
 =?utf-8?B?OU83UnRsWTkxVGtiTE5TcmVPaTVYZTJFR0NrdTVwK2pBR3hWVE1WM3A4bld3?=
 =?utf-8?B?YzNZVlBWdlNWVWM1MDExck5QdUQvZHVYOVBOdUl2SjN1UkpOQnJFdjhBdFo5?=
 =?utf-8?B?b1F6TmV4U25UNG8ya1RQZVYzNHpMdEk1WW16NWhwcWV3VHBRK0gxTVp5T2R5?=
 =?utf-8?B?ektEWk84RzJVQ25yNjZQcjJuMXVTbnptYXJJSFdqeklzSVdVTG9ZMzN2NEE1?=
 =?utf-8?B?NXMwLytvS295UXQvSFFjV1dOVll4dXhaYmpEMTdxcjcyZTZmQ2ZPUnlzYXUx?=
 =?utf-8?B?RDQyRzAxaXVhSXZyNnF6K2o4bE1jOEpxQmh1SUFkdDFtVHFPL3NmSW5udFhS?=
 =?utf-8?B?TDZCVWl4Z3FRSERsNENJV2VjeXlJaHIvaXZjYktHcUo1QWdNamk2a3BDUnpS?=
 =?utf-8?B?clU5MEljQ09wVGRaY0lBdkpRTmxwRU0zam85WHlLcEZhd2dXeVV2Z1ZWallH?=
 =?utf-8?B?MTdLZ3VnTzVPblNKU1pZZDZYckJXaHlFSnJiUmVjOVIwYTVmR3FpbHhtZnZP?=
 =?utf-8?B?dHdvYStJWXZTeVhIL1BCYy9LQ2xFWW5RNzd4TE5Sem96aVNZMDV0dXNTUUc2?=
 =?utf-8?B?M1dWdVllckR2OGdCTStGcjR2MUs3WVVPeVV3dEREc3ZFdzlVaDJ6NFJ6WVEx?=
 =?utf-8?B?MFE0ZnRDL0Fha1pqWjcrNnRERmNqdWcrM2IxY3FSNXVRSVBYaHVuczduYzRz?=
 =?utf-8?B?S1FWS1B5VmNSNjV3bUhUN2cwOHdmWkVHNkNtdzRNeTN5d0p1L3g2OWo1WVVU?=
 =?utf-8?B?ZmdzdjZYMFByN0hxVjFPNHRiUGFQNDZoU0orYTFKVmJiczlUUkRUdUxveVhW?=
 =?utf-8?B?dXRrN2FxeW9sTXd4YWR3SWI5Q0YxeitCellBQ0J5cnpYcDl3N3BMZTI0UUdX?=
 =?utf-8?B?N3ZoR1pHZ3R0cWM0cHZvZC9mWDdqVSttUmIvK2JCNUgwRXhneHdKSGJKOGhr?=
 =?utf-8?B?RzdnL21QUjNoS0lGcDBlRHIzdVZOYTRMLzFRakhCS3ZYTFluSWV4ZVFIZXpU?=
 =?utf-8?B?RjlqeW11ejVGWm1jVU04RHhLUjVFVTIrUDhBTi9qa1lWSUQyMUgrbEhieDlT?=
 =?utf-8?B?L1lGaTdBdXBzVG5BQXprT1hLOE96ejc0V0dXRnphOHhEM0xMVElOMUkwakVU?=
 =?utf-8?B?bUY4Q0RGQS9UNTZWa29PQm82cmEvQ1NxaFhXWG1YOUMwYW55YUFwM0xEVEFP?=
 =?utf-8?B?S3pnU3NmYkNTd2Mwc1RtQkRJRG83TVRlS2pyekJJVkpkdjE4UnFBYzRPY3ln?=
 =?utf-8?B?dE5VajBJSk9UbDFCaDVacWxYNm1xdzlnMml1cVRGMUlwdTRQcU53cFZ2SHFI?=
 =?utf-8?B?QkNmbUpoZHZvcENsay9wZCtsOXZUaVRsNllPUGtzMEN1T2ZHM1VBVDJ1czFS?=
 =?utf-8?B?Wkh4c2d1NDNObEZrNzBURWlvN1dEN2ZDNHB5OGZIM2ExeUtPTmpBT05Wc01N?=
 =?utf-8?B?TjFEVjZlQ2VQSmVGQVBIN2dScitiSVZJT3EvOXVZMVZUa1hHcElZdExOQXNI?=
 =?utf-8?B?dlAxaVd0Zk5tNjNsY2dVS01WK1BweTVnSjBKMDl5S2xlMjArdUhLTGk3UFZi?=
 =?utf-8?B?N3VmL2NLS0E2azlOMkVxSFdQN2pXVjRIU0JLSE5iSEhVRm5OTWt4U3BGOENn?=
 =?utf-8?B?T3g0bmtmeEprZFlQRjFsalVsOEtBWm0zcndNTEtmdE9VcVo3cnB3cTBweDNu?=
 =?utf-8?B?TUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	E5mWgl3tV8vSClLIh4mzDx5sjnquSytN/OEJ/KhJLoBC1XPu4qTmJcKIHj3R2NGBEW7y0ITWK0tUDqvPf4Y5yzgAPhRt17Cz1pscTHv38xU32eA0S42tmN2dJg6jH/5RHsLTkdqoMmdioKt75zN9N3CfoNzUkFcuxC7q1OqK3deWqz3656u4bEPbB5YeltChggkWqAYb7eYy2Y5wMgSpw112PWPOMVdeBAxO9t9QThCwzGydk3uuj8EecfofimgRB4MlRhX2vkczPuN8bjs+z8gVov0XvrW9/xgHP4zygGVnlvYfCLZsD2eusiI1a1EnzFyaxSYt6Spiw7HyZVwURCEmtXYPMCko3CcB1pqfqNzVmwdpoOctwfoJqHdYbyUJ2oP2cBf/cPlg+uoXEtXnKV+rL0PILRmFuh+G6EXSY1Rp0GhBc7+Aoh9jM5cmAJsntW9Gsfin/v21WTFnhr0HnlHvd0dBJQW8+ob35UXFBeZzpDgJ8XMrTK7D/mvc/5UD/hNsxx0eZBz4q7cwfEgU2U1tFhKfHMRZN8mAbwn7GSsnclRajYzixvJBmgi82zIyoaQ/+SBFZQ2UWh9cP8yRul+dZ2G1QN0T9o/zAEM5pCY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61ee6ddc-84b1-47f3-5914-08dcc5d9235f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 14:12:37.3044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HIKYPgGvoUxhmxyjDaDc48dz4PcqXMfx6Q1XOThVxUnEBZ5J81tLIqykweT02MjMysudF5i+Ss5DXgmYa0wyAcZidk4oSIlNgPtPefM/sMg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5848
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-26_11,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408260109
X-Proofpoint-GUID: 6uqlsUCcXLER47m_3ePNMYFhrE35h8tC
X-Proofpoint-ORIG-GUID: 6uqlsUCcXLER47m_3ePNMYFhrE35h8tC

On Mon, Aug 26, 2024 at 04:01:10PM GMT, Geert Uytterhoeven wrote:
> Hi Liam,
>
> On Thu, Aug 22, 2024 at 9:27 PM Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >
> > Set the start and end address for munmap when the prev and next are
> > gathered.  This is needed to avoid incorrect addresses being used during
> > the vms_complete_munmap_vmas() function if the prev/next vma are
> > expanded.
> >
> > Add a new helper vms_complete_pte_clear(), which is needed later and
> > will avoid growing the argument list to unmap_region() beyond the 9 it
> > already has.
> >
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Thanks for your patch, which is now commit ca39aca8db2d78ff ("mm/vma:
> track start and end for munmap in vma_munmap_struct") in next-20240826.
>
> > --- a/mm/vma.h
> > +++ b/mm/vma.h
> > @@ -38,6 +38,8 @@ struct vma_munmap_struct {
> >         struct list_head *uf;           /* Userfaultfd list_head */
> >         unsigned long start;            /* Aligned start addr (inclusive) */
> >         unsigned long end;              /* Aligned end addr (exclusive) */
> > +       unsigned long unmap_start;      /* Unmap PTE start */
> > +       unsigned long unmap_end;        /* Unmap PTE end */
> >         int vma_count;                  /* Number of vmas that will be removed */
> >         unsigned long nr_pages;         /* Number of pages being removed */
> >         unsigned long locked_vm;        /* Number of locked pages */
> > @@ -108,6 +110,8 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
> >         vms->vma_count = 0;
> >         vms->nr_pages = vms->locked_vm = vms->nr_accounted = 0;
> >         vms->exec_vm = vms->stack_vm = vms->data_vm = 0;
> > +       vms->unmap_start = FIRST_USER_ADDRESS;
> > +       vms->unmap_end = USER_PGTABLES_CEILING;
>
> noreply@ellerman.id.au reported build failures for m5272c3_defconfig
> http://kisskb.ellerman.id.au/kisskb/buildresult/15224802/
>
> $ make ARCH=m68k m5272c3_defconfig mm/filemap.o
> In file included from mm/internal.h:22,
>                  from mm/filemap.c:52:
> mm/vma.h: In function ‘init_vma_munmap’:
> mm/vma.h:113:21: error: ‘FIRST_USER_ADDRESS’ undeclared (first use in
> this function)
>   113 |  vms->unmap_start = FIRST_USER_ADDRESS;
>       |                     ^~~~~~~~~~~~~~~~~~
> mm/vma.h:113:21: note: each undeclared identifier is reported only
> once for each function it appears in
> mm/vma.h:114:19: error: ‘USER_PGTABLES_CEILING’ undeclared (first use
> in this function)
>   114 |  vms->unmap_end = USER_PGTABLES_CEILING;
>       |                   ^~~~~~~~~~~~~~~~~~~~~
>
> Both are defined in include/linux/pgtable.h inside #ifdef CONFIG_MMU,
> so they are not available on nommu.

Thanks for the report, this was already resolved (or should be :) via fix-patch
in [0].

[0}:https://lore.kernel.org/all/7d0ea994-f750-49c5-b392-ae7117369cf3@lucifer.local/


>
>
> >  }
> >
> >  int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

