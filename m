Return-Path: <linux-kernel+bounces-396774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 517759BD1C8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 17:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 735DB1C24D53
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B171715CD78;
	Tue,  5 Nov 2024 16:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZtupmHg/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lf5JjO1a"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624F5225D7;
	Tue,  5 Nov 2024 16:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730823051; cv=fail; b=nbNeiWKq/tFtMo50IU6dlrukzWeTKhzpZwYst/SshKaipKI+jHuXOvNBHRzTj6oao9Na/oCEqiPWlThI8Hoo14Zq6TpB/Gi+z1qbu/ydQ6nf54W1wORT7HqirQLmKmaxANxTNngXRqquKjAfb3d39ejsA0WKUk3pm/XBlKeDwow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730823051; c=relaxed/simple;
	bh=rPEyAdpIccYHoZlsCXdwOlfCoHWxqkfS7sV+fPmbK38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F+I5oyuWuIIFCsorz+gDx0fL5i2Aa1Qxqahm3aVzaFmuZq9ExAptZGZS0OrqEUTODrwel/SpbQWo5k6xzqw7WGLAyRRyhYOKyhoXRgdt77gBRL+rgcKcuCqzsnfyASl6KQwb8n0FrykK7sk/+wiCth4HZFp8oUKBlkPFq8aq/o0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZtupmHg/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lf5JjO1a; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5DiYda009214;
	Tue, 5 Nov 2024 16:10:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=p0ylIHUUjwUwXwUti8ys9JG0uCNhpo3Hn3cr/2GPQLY=; b=
	ZtupmHg/68iUkwOLhsI8WbMAiqdM+KtSy09s+OlqOxiCRCRdK72FPHRQCUcYPJla
	BMC4lcLQXnkoXhvqPUTWqxBjmkvkssu3tD3XdBcmb2k9+bkfidrscwilnpeQasKV
	qn89LIjrfwEXfUZyTdqgXpvRouA92bS/PXPDXp4WTBL8lzu5ulYpkczb3ZCoETOf
	m+M640cy1SSC7clYgeH2cyRyVGMgD+lgFjNgMvisJKXckMYAaTFgiJdNG5wIKy7b
	ni8/ZmLlQKxF1clmJLtoRYAg/WxcDyUI0M20eep2Zy0aeUpo1eKHPSHrKjG5xvBZ
	VTwzKGxPsOMPAmmkXmHo6g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ncmt5qp0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Nov 2024 16:10:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5FH75e031448;
	Tue, 5 Nov 2024 16:10:27 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42nah72pvc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Nov 2024 16:10:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VYtNv8vVUA4ZV45LObmfX0pCT/WKHpQrVfbZ6uSePFl2W1uZEWARZx566aD09N5I0sM8iZoSuZmQarTvdEidyI8poyQiVGqJC+Ai56IJinhQjbG6wbARzk6hv7xMMDYj2zW3cRQiQhyxVvfB7pUIp8DPtBUmZIazUtWsO2vSoV4N7WkDy5e+XMclFpJgNFpRdXHHCmC1/JzTyJ7p/zQjIogWJv3C/pqCBIqDkTKJnBBTusKtfglmyygET1glXfKU+G5lNcTmpEV5PsjKaODBntgU8o5m2owsaC8z6ZMP5jtEkQKTZTGPMxw2r1/WbiOJLFwU9zHutxaVkHXla8SEhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p0ylIHUUjwUwXwUti8ys9JG0uCNhpo3Hn3cr/2GPQLY=;
 b=EbcdIlRdxLAO06tX3shhYC5eNqX3XoZ7hB/J3+Z9DxTT1L1uaNpq7hsddVgVJAOaSX5N3jMuhXPwSlvcminbNrMqPjlqXGywBvjFLy1VwCk2a/B78Y5PYyzknFFwhF3F9Jlsh6YAq9fD9Vf955lc3gMuA5h5rDBzuOagcUnn3B4nlzjNLxb3TldUmClOGU1qFEioHH9i40i7VFQEDLpfv4LdD4IBkZvDVkRbYtDveow56f8LKzeNRiEm0BihtJI33ZscCWD7aW/4ZCdhU15h7SNoQv1OIgJPSXSHPn/NHRmf+liBGFcI04manGeqdzqcTSLSTSjWWRVbsYzo2OxOSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0ylIHUUjwUwXwUti8ys9JG0uCNhpo3Hn3cr/2GPQLY=;
 b=lf5JjO1aZFojwmMygfsPQF2LLIUZxKI1I1J3QA46uK9oP0PglSM61VLkU0gOK+5Kf5An4eM02ol6jkhFnmDhenupW3vmEiQVHM1QGV02/Bk+ckn9j2S3dPVpkPN0f8IPTiqkrNcfQO229wPosXdCC+0Kjb8eB2skBQjGSfMqXh8=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CH3PR10MB7807.namprd10.prod.outlook.com (2603:10b6:610:1bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Tue, 5 Nov
 2024 16:10:22 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.018; Tue, 5 Nov 2024
 16:10:22 +0000
Date: Tue, 5 Nov 2024 16:10:17 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Alice Ryhl <aliceryhl@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [RFC PATCH] docs/mm: add VMA locks documentation
Message-ID: <94e4ba07-42bb-4567-b0c9-b719f81dc61b@lucifer.local>
References: <20241101185033.131880-1-lorenzo.stoakes@oracle.com>
 <CAG48ez0qsAM-dkOUDetmNBSK4typ5t_FvMvtGiB7wQsP-G1jVg@mail.gmail.com>
 <2bf6329e-eb3b-4c5e-bd3a-b519eefffd63@lucifer.local>
 <CAG48ez1eeQatc0GC_hfOM_mvwjwQ=89JDmp_U5_diLy7ycjEdQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez1eeQatc0GC_hfOM_mvwjwQ=89JDmp_U5_diLy7ycjEdQ@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0341.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::22) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CH3PR10MB7807:EE_
X-MS-Office365-Filtering-Correlation-Id: 948ae361-b574-4dcc-0a0d-08dcfdb45935
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RzF2RFBuZEQxcEZQMFRvWElwbytud1lnWFJHVVljaTdtVlExT2xzWmlmN1dD?=
 =?utf-8?B?SWljVXB5TUx4MFNTKzh0YzVwM0JROWpmQlFYcExRTHhwWUZCbkNiQkxITWVS?=
 =?utf-8?B?OXQzWkl2cHNxNVExdzliU2VGTGx1MGs2R3pHbUVuSldDbW50YTNoVHdtdW5s?=
 =?utf-8?B?SE16elZBT3EyYTM2NUNHM3BQSDUzb1h1L1BIMWhuazM3TWgzNkZ6VDd5dFZX?=
 =?utf-8?B?Nk4yRzB5cFRuZWo5SWdQT1lLMnhzWFg5ZmgvQVFPdG9qT3RBMDc3aU1EWFln?=
 =?utf-8?B?TTR1S2tiSlVpRDFGYlVaL0JRVG5GdTh6TlI3V0tkZWtkanh5Y2ZoWGpGUmVJ?=
 =?utf-8?B?cUdJR2MralZqTmtTSlJEbHNpNEU1ZGRXaG1taW82ZnllelIzNm41cmFBNkNs?=
 =?utf-8?B?L1dTMW5lUVRJbGh0bFpRd04raDMxVFFrb3grZzBNNWtMaXlINXRlNk0xTzRB?=
 =?utf-8?B?Z28xMlQ4eU9lNHAzZEw0dWFHU0pRTUtSWVU1SXlTcklsWlVic0xiSWZnOWtk?=
 =?utf-8?B?YmhZU3hoQnZ2bzhxd2hMSk5ORnJ6d1Y2dmNKVHVDSnZ0bjVrTXNlSnJxQ1Fn?=
 =?utf-8?B?Q3ZFQjNpMXltbGdYbTkraFJJR0lCRmtPam9vZEJSWVk2TlZqUkMxcGU2Y0w2?=
 =?utf-8?B?eE82VFgvcmFnSmVUSTlWSWpRNEdCRHdtcWtlSUVSaHZaLzFNaFJyQmdMVHk5?=
 =?utf-8?B?WmRjaHBFYXowZC9aeHVEd3VLUW52UUpRNTVYYTBad0hwQVJlMkV4RzZYcm01?=
 =?utf-8?B?ZUdJTlp0T3NuNDlVR0dBdHpJWFllN0l4NHpiTExWSWxNbUxLdWVKODZ2bFhv?=
 =?utf-8?B?bXFsdEhIY21CUS9ZY3MwajlEbUx0Rmlqc01HcDc5ZG5WVklXZXlWUEdGRG5k?=
 =?utf-8?B?dURoT2NaQzR3SE1rRUhoK1pBKy9ObGxBbG9QWmlDTkR0eTc0NnBObVNJN0NH?=
 =?utf-8?B?N0w2RER5dTRxUHQ5clA1OFhEYkhMZEZZUloxZjU1MlFKOUN0czFybHIxOVRF?=
 =?utf-8?B?WmZSTTBRNzFUUWZUMG00VGdMQUhaKzhqWGJEQkVoUmVwVEtTSGoxRm9FK3Mv?=
 =?utf-8?B?KytaeEVDdjZpTUU0NjZYVCsvY2ppQk5XWXg0eWhiaVY1M3dZRGU4Qjh4TTN4?=
 =?utf-8?B?SVBaNXhXZ3JrRXFMcm5GSi9QUU9KNnB1QVdONUFCbWdiVloxUENpbm56SVNR?=
 =?utf-8?B?UXZxYldpREtpTGRBR1phb2V0OENWWS9tcEdvdjdoeHBlWmxTSWxJQzg4WmJj?=
 =?utf-8?B?Q09xVDJVU3Y0dDU1bEx2SjZqL0R0M2ZCd0hnUnBvVWtWUTdKU0lNSmpOa2Y2?=
 =?utf-8?B?MklLbjd3Y3BKbFVaQlFXUEhvbTNpczhEOWl5MmxmalFaU3BsV0g3Wk9qWlpw?=
 =?utf-8?B?MWZ1SklmLzdtOGJRSkpML2VVclBVYVVYbG00K2orK2s1eHlNUTdmdVZFaHRk?=
 =?utf-8?B?SklHaFRnTDQ3cU5MdHBtNTl4dEdIMkRHWGJSU0E3dHo0NGx6dHJiWWtOdE0w?=
 =?utf-8?B?ZHZ4M281TGNKWnhiYnoxd3ZkcnlRcExnamdqRUtabHV3emZRd1Frd04vcFU0?=
 =?utf-8?B?akR6Zjk3aWtrK2FyeUtSbTE5MDRXM2gyZC81WUpPcEhIL05hZHVYNjE4VXd5?=
 =?utf-8?B?ZzErVGQyeUt5WU8vREdNdWR5VnhBMHRDY0dWQmJibXhobkZPblEwaTU0em1N?=
 =?utf-8?B?SnJXRkZrcUVrWncwVi9wN1lwdjdYZTlQN0FMZTIwT1hvSkszOWJJYjRVdU9Y?=
 =?utf-8?Q?RoC4iS3UHcZ4iMsKZcK5qXOClsd7I/ctnrvPpoY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dCtHU3J0MmlXUnZYYXZwRXNTZFNOMHU0VmV2Y1oyRmVOWVpGQ2hsMlR2Tkox?=
 =?utf-8?B?ZTBEcGk3RDhwK1lnMzR6aHVMdC9FTDQwaVhyalFjYXZnSklyQmVGSGp6aGtP?=
 =?utf-8?B?aDZWN0pZbTkwWlFRN0ZWaEs1NFdVNXljaVRuZUtPdDNhNmdGRzlzcks0NUcr?=
 =?utf-8?B?UTUxbDNpM1Fuek1VRi85QzFuemZPV2VTQm5tNS9YQmtBYlA3T2FtUDg2a0Vp?=
 =?utf-8?B?L3IvbjBRTzRnaWR0MTZHK2s0Q3RwektmTHhPVllON1hDSDdQeTFHTEk0SjRz?=
 =?utf-8?B?ZGxLU0ZlZDJHcGduNERHeS9FZVpGa0dCYnpibDgzTEJEQkxXakhPM2J6cSsz?=
 =?utf-8?B?YTJidUd4RFNoQVM0M0Z1ZHNNUXZUeUhDSmY3dVkwYkh6Y2ZmeVAzTCtyMmhP?=
 =?utf-8?B?dHlWOVVlcUQ4dFEwaVFrd25ZQ2dPK0ZlTjF0ZjhmRzE0VG1naDU2MXdUNlNL?=
 =?utf-8?B?ZnlMZmFuMno2NjVyMkpKVFhoYWhoTnBlUi8rM0t4R3pXNUNvQmVMNlRHcnBm?=
 =?utf-8?B?YjBSSXNDS0JGQmRLa2VyejNkZXdzaUZEUmxIZjJwdFY1b1ljUjA5U2p1elli?=
 =?utf-8?B?cFBPeEZyWS9oWkxuTXpYMmI2ZEhzOXI2TGFOdlF2aG9oT1Z6ZnZyek5CaGZY?=
 =?utf-8?B?TG55TlozY21WVVhVN09BWGdhUU1aV1k0RnhtZkhGcTFieW1hZ1Z1aGl5QUJs?=
 =?utf-8?B?V0lEMkxMVVVmNVJzM1dRYUNiOHZiNENBL0NIOFVvOHNHWGp3aGdRN280WnpJ?=
 =?utf-8?B?VW1Jc0xsbW5nU1NmQ2tsZ2kvbkd0M012MmJnaDZOMXBMeVRUUWw4b3RkRWtq?=
 =?utf-8?B?aGE5aHdGbUJmRTV5aUVnVTM1YndPblNSY2E5WmdpU3BNMUlDTzZoV2ZkbzVq?=
 =?utf-8?B?Tk5PZDJpZklzZDNhYjdHTG5CTFI4cDJOQ25BS25aTDhXMjBmWnkzek5reXUx?=
 =?utf-8?B?V0ZmNEc1TlNpYk1ZUkxMb0VmQmZBTXZPNzVxMjZRMjVaZFFXZWkrRlB2YWlx?=
 =?utf-8?B?RVdIb0xwM2xlaHdVVE42ZmNBdWNzZzFoTWIvcW82RWQwSzI3WmdKTXlwd0g2?=
 =?utf-8?B?RExycW1MWGlSaHV6M2NocnNhZG9sY3AxMW9vcm0rRi9VUmk5YWdCZWNXN2Yx?=
 =?utf-8?B?LzBuaDNDRDFRb24wT3VJbzU3VlNwMVhBSmZ0RmNFaHhJRkdkQjFvckFwVHNJ?=
 =?utf-8?B?SXdEV2Y5SklpditCSUg5ZG12RVoxMFhoeGVLa3Y5NDFWVHUzdnpPOTRtaUI3?=
 =?utf-8?B?RmVoNWFVL1ZrOGRobUdCTVdvVC9WMmxCckRkMDVnSGwzbDhlTno0SnZINU5X?=
 =?utf-8?B?WjdMZUlGU2tMYkpUSjJaR0xvM1JEeWdpYUkwdi9TTG1KbDhsK1ovYzA2Unl0?=
 =?utf-8?B?bzF6R3FyNVNTNk9QT0FUeEZaMk9za1U0WmRWdDNHOUUxanZxNm9iS3hFTHM1?=
 =?utf-8?B?QzZOZDJ6Z2h2cTR0OHdIV1AxRnhVL1FsS3YwOCtmb2pGYTdLQUQzTzJSRUd3?=
 =?utf-8?B?YW9qQWE3VWxFQUV4amZQakswUDJ4U1g2ZnFadkRTbzJ0N3ROMnVHWFR3MmxN?=
 =?utf-8?B?VEpmRUlkMjUwd042dnZnQ0g4NmNjc0dZNlc2QlRLcStTQVQ1R1JCdFJ2Rkp6?=
 =?utf-8?B?ekRqUzluZWhNWXFQaUxkTEhpbDB6b3JtcDNEQzg0WVV1aFhQTlVxK2I0alQv?=
 =?utf-8?B?U292SGNuQXh3U1RhRVdSaDJzR3JESTRRa2ROMFM2MDJqU2NoR3JMTDY4dlU0?=
 =?utf-8?B?V2dRUk9kd0ljVXV6MmJSNWtUdXM0WVRkNEdtVWNsU2l4TVJabkJHa3FSQUh2?=
 =?utf-8?B?YjZ3bVZxWlM4RDc2Z3d0UjIyOHRCNVdIeThYV3dLV2t3QmUwZy9ZQ2VBa0pL?=
 =?utf-8?B?MWdJU0FsRU5HV2Q4NFRtVzFOb2t3cmNGbnpsRklNalBiOG5RcXhmL3dNYmhZ?=
 =?utf-8?B?MGhpdXQ1akxxbzJMNGRNeFBuK3VvcXFyYlFCa2xDRlJic2liaFJONEVLdlpV?=
 =?utf-8?B?b0xkakM4VzAvM1kzczJubnZoQnZORHExa21rbmFRMDhyNnNTL0RZdVppNHFL?=
 =?utf-8?B?bmZhRDl0SlIvZlVqVGQyakFUUEVVMnM5Ti9MbDh2dG9mQlJZRk5PT0g3STls?=
 =?utf-8?B?V0diSUxhNDBtdzl4YnVGbHlhbVM1M3Z1VGJlWUQwRG56akc1UU1WTVBtZ2p4?=
 =?utf-8?B?MlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WBtADJPba3g1EJqgYCymwtumh2QCMaZ/YauRBPe+Evw83Rj1iRkmwkyyoHJlW84fzc7FQgqqqGVYFtehlFMD5B8X4ZOlzmQIG9egNKSMrImOECzqznZBIw8532SLHVqnQv09Zj5nEHw+MyDKoKcxYQCP4BSTTdhDsQ4NOT6nBB8sphRiDhbVLlDuRqE/dwJrEMidNeOJuvy3EBob2F7Gi+yy3zXwjKv+nYMsTZsue2/w3GN4f3zPiFK0aUQLDSmgLzlJYuCwXa15l0/1ujypnopVR6oTFmi6oqlP86aHWDjKFifVhkRMwJa9iih4lKmRbjokIPfKFUD1OqDR85LPDIr09D39exfNATGLXmJLQhq8nIOkBV0/atKwn6cV7kBKsXxVqGLBlqoSgNPLa5GwYHxnqrRlXboFCeq5oKj23qBZR1CTnhMD7RE8k1b/toOxxdmtxIBlgAPA1k5J2qZHtkHtKCzdWdn1bHE6wFQPn+s6dW9H2qUxhmsWX/sF4iCaeoE0HRuIN0c5dR+rqcd6tq9MAuNjFgXAVCncUGkyGTF8xqdLP071LPD2wA7QlolghMWaxREtYQvsbpK72CqkSFpApRbyfOw4/4bNapKa6gw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 948ae361-b574-4dcc-0a0d-08dcfdb45935
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 16:10:21.6581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MYONkepKuCdPkkvhEQwL5exOX+5IifJFLSmwa0gyCHAhPYed4s7260FI7foF+fwu7ntvOQ3gzHW4swMeJi/HBMM42IFdEylFJXOPWcMCX9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7807
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-05_06,2024-11-05_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411050125
X-Proofpoint-GUID: KVc-7gFo74Kn54lq7AQx5x-_qx_YqmTs
X-Proofpoint-ORIG-GUID: KVc-7gFo74Kn54lq7AQx5x-_qx_YqmTs

On Mon, Nov 04, 2024 at 10:29:47PM +0100, Jann Horn wrote:
> On Mon, Nov 4, 2024 at 5:42 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> > On Sat, Nov 02, 2024 at 02:45:35AM +0100, Jann Horn wrote:
> > > On Fri, Nov 1, 2024 at 7:50 PM Lorenzo Stoakes
> > > <lorenzo.stoakes@oracle.com> wrote:
> > > > Locking around VMAs is complicated and confusing. While we have a number of
> > > > disparate comments scattered around the place, we seem to be reaching a
> > > > level of complexity that justifies a serious effort at clearly documenting
> > > > how locks are expected to be interacted with when it comes to interacting
> > > > with mm_struct and vm_area_struct objects.
> > > >
> > > > This is especially pertinent as regards efforts to find sensible
> > > > abstractions for these fundamental objects within the kernel rust
> > > > abstraction whose compiler strictly requires some means of expressing these
> > > > rules (and through this expression can help self-document these
> > > > requirements as well as enforce them which is an exciting concept).
> > > >
> > > > The document limits scope to mmap and VMA locks and those that are
> > > > immediately adjacent and relevant to them - so additionally covers page
> > > > table locking as this is so very closely tied to VMA operations (and relies
> > > > upon us handling these correctly).
> > > >
> > > > The document tries to cover some of the nastier and more confusing edge
> > > > cases and concerns especially around lock ordering and page table teardown.
> > > >
> > > > The document also provides some VMA lock internals, which are up to date
> > > > and inclusive of recent changes to recent sequence number changes.
>
> > > > +Overview
> > > > +--------
> > > > +
> > > > +Userland memory ranges are tracked by the kernel via Virtual Memory Areas or
> > > > +'VMA's of type `struct vm_area_struct`.
> > > > +
> > > > +Each VMA describes a virtually contiguous memory range with identical
> > > > +attributes, each of which described by a `struct vm_area_struct`
> > > > +object. Userland access outside of VMAs is invalid except in the case where an
> > > > +adjacent stack VMA could be extended to contain the accessed address.
> > > > +
> > > > +All VMAs are contained within one and only one virtual address space, described
> > > > +by a `struct mm_struct` object which is referenced by all tasks (that is,
> > > > +threads) which share the virtual address space. We refer to this as the `mm`.
> > > > +
> > > > +Each mm object contains a maple tree data structure which describes all VMAs
> > > > +within the virtual address space.
> > >
> > > The gate VMA is special, on architectures that have it: Userland
> > > access to its area is allowed, but the area is outside the VA range
> > > managed by the normal MM code, and the gate VMA is a global object
> > > (not per-MM), and only a few places in MM code can interact with it
> > > (for example, page fault handling can't, but GUP can through
> > > get_gate_page()).
> > >
> > > (I think this also has the fun consequence that vm_normal_page() can
> > > get called on a VMA whose ->vm_mm is NULL, when called from
> > > get_gate_page().)
> >
> > Yeah the gate page is weird, I'm not sure it's worth going into too much detail
> > here, but perhaps a note explaining in effect 'except for the gate page..'
> > unless you think it'd be valuable to go into that in more detail than a passing
> > 'hey of course there's an exception to this!' comment? :)
>
> Yeah I think that's good enough.

Thanks!

>
> > > > +The kernel is designed to be highly scalable against concurrent access to
> > > > +userland memory, so a complicated set of locks are required to ensure no data
> > > > +races or memory corruption occurs.
> > > > +
> > > > +This document explores this locking in detail.
> > > > +
> > > > +.. note::
> > > > +
> > > > +   There are three different things that a user might want to achieve via
> > > > +   locks - the first of which is **stability**. That is - ensuring that the VMA
> > > > +   won't be freed or modified in any way from underneath us.
> > > > +
> > > > +   All MM and VMA locks ensure stability.
> > > > +
> > > > +   Secondly we have locks which allow **reads** but not writes (and which might
> > > > +   be held concurrent with other CPUs who also hold the read lock).
>
> (maybe also note more clearly here that "read" is talking about the
> VMA metadata, so an operation that writes page table entries normally
> counts as "read")

Yeah good point will add a clarification. This aligns with a point Mike raised
about being clear the read/write is not in reference to user data.

>
> > > > +   Finally, we have locks which permit exclusive access to the VMA to allow for
> > > > +   **writes** to the VMA.
> > >
> > > Maybe also mention that there are three major paths you can follow to
> > > reach a VMA? You can come through the mm's VMA tree, you can do an
> > > anon page rmap walk that goes page -> anon_vma -> vma, or you can do a
> > > file rmap walk from the address_space. Which is why just holding the
> > > mmap lock and vma lock in write mode is not enough to permit arbitrary
> > > changes to a VMA struct.
> >
> > I totally agree that adding something about _where_ you can come from is a good
> > idea, will do.
> >
> > However, in terms of the VMA itself, mmap lock and vma lock _are_ sufficient to
> > prevent arbitrary _changes_ to the VMA struct right?
>
> Yes. But the sentence "Finally, we have locks which permit exclusive
> access to the VMA to allow for **writes** to the VMA" kinda sounds as
> if there is a single lock you can take that allows you to write to the
> VMA struct.
>
> > It isn't sufficient to prevent _reading_ of vma metadata fields, nor walking of
> > underlying page tables, so if you're going to do something that changes
> > fundamentals you need to hide it from rmap.
> >
> > Maybe worth going over relevant fields? Or rather adding an additional 'read
> > lock' column?
> >
> > vma->vm_mm ('static' anyway after VMA created)
> > vma->vm_start (change on merge/split)
>
> and on stack expansion :P
> But I guess nowadays that's basically semantically just a special case
> of merge, so no need to explicitly mention it here...

Well actually no... hm I wonder if we should make that call vma_expand()... but
that's another thing :) will clarify this anyway.

>
> > vma->vm_end (change on merge/split)
> > vma->vm_flags (can change)
> > vma->vm_ops ('static' anyway after call_mmap())
> >
> > In any case this is absolutely _crucial_ I agree, will add.
> >
> > >
> > > > +MM and VMA locks
> > > > +----------------
> > > > +
> > > > +There are two key classes of lock utilised when reading and manipulating VMAs -
> > > > +the `mmap_lock` which is a read/write semaphore maintained at the `mm_struct`
> > > > +level of granularity and, if CONFIG_PER_VMA_LOCK is set, a per-VMA lock at the
> > > > +VMA level of granularity.
> > > > +
> > > > +.. note::
> > > > +
> > > > +   Generally speaking, a read/write semaphore is a class of lock which permits
> > > > +   concurrent readers. However a write lock can only be obtained once all
> > > > +   readers have left the critical region (and pending readers made to wait).
> > > > +
> > > > +   This renders read locks on a read/write semaphore concurrent with other
> > > > +   readers and write locks exclusive against all others holding the semaphore.
> > > > +
> > > > +If CONFIG_PER_VMA_LOCK is not set, then things are relatively simple - a write
> > > > +mmap lock gives you exclusive write access to a VMA, and a read lock gives you
> > > > +concurrent read-only access.
> > > > +
> > > > +In the presence of CONFIG_PER_VMA_LOCK, i.e. VMA locks, things are more
> > > > +complicated. In this instance, a write semaphore is no longer enough to gain
> > > > +exclusive access to a VMA, a VMA write lock is also required.
> > > > +
> > > > +The VMA lock is implemented via the use of both a read/write semaphore and
> > > > +per-VMA and per-mm sequence numbers. We go into detail on this in the VMA lock
> > > > +internals section below, so for the time being it is important only to note that
> > > > +we can obtain either a VMA read or write lock.
> > > > +
> > > > +.. note::
> > > > +
> > > > +   VMAs under VMA **read** lock are obtained by the `lock_vma_under_rcu()`
> > > > +   function, and **no** existing mmap or VMA lock must be held, This function
> > >
> > > uffd_move_lock() calls lock_vma_under_rcu() after having already
> > > VMA-locked another VMA with uffd_lock_vma().
> >
> > Oh uffd, how we love you...
> >
> > I think it might be worth adding a note for this exception. Obviously they do
> > some pretty careful manipulation to avoid issues here so probably worth saying
> > 'hey except uffd'
>
> I guess another way to write it would be something like:
>
> "Taking the mmap lock in read mode while you're holding a vma lock is
> forbidden because it can deadlock. Calling lock_vma_under_rcu()
> normally only makes sense when you're not holding the mmap lock
> (otherwise it would be redundant). lock_vma_under_rcu() has trylock
> semantics, and if it fails you need a plan B (which normally is to
> take the mmap lock in read mode instead; notably this would get more
> annoying if you were already holding another VMA lock, because then
> you'd have to drop that first)."?

Will extract some stuff from here and add in.

>
> > > > +   lock, page faults can race against you even if you hold an mmap write lock.
> > > > +
> > > > +VMA Fields
> > > > +----------
> > > > +
> > > > +We examine each field of the `struct vm_area_struct` type in detail in the table
> > > > +below.
> > > > +
> > > > +Reading of each field requires either an mmap read lock or a VMA read lock to be
> > > > +held, except where 'unstable RCU read' is specified, in which case unstable
> > > > +access to the field is permitted under RCU alone.
> > > > +
> > > > +The table specifies which write locks must be held to write to the field.
> > >
> > > vm_start, vm_end and vm_pgoff also require that the associated
> > > address_space and anon_vma (if applicable) are write-locked, and that
> > > their rbtrees are updated as needed.
> >
> > Surely vm_flags too...
>
> Nah, there are a bunch of madvise() operations that change vm_flags,
> and at least the simple ones don't touch rmap locks (I don't know if
> maybe any of the more complex ones do). See MADV_DONTFORK, for example
> - we basically just take the mmap lock in write mode, write-lock the
> VMA, and overwrite the flags.
>
> Not even do_mprotect_pkey() takes rmap locks! Just takes the mmap lock
> in write mode, write-locks the VMA, changes the VM flags, and then
> fixes up all the existing PTEs.

Sure was aware of course about the madvise() cases (which are, thankfully,
always mmap locked), just wondered if there was a need to be careful about flags
in the same way but you're right... :)

>
> > > > +     -
> > > > +     - mmap write, VMA write
> > > > +   * - vm_file
> > > > +     -
> > > > +     - If the VMA is file-backed, points to a `struct file` object describing
> > > > +       the underlying file, if anonymous then `NULL`.
> > > > +     -
> > > > +     - (Static)
> > > > +   * - vm_private_data
> > > > +     -
> > > > +     - A `void *` field for driver-specific metadata.
> > > > +     -
> > > > +     - Driver-mandated.
> > > > +   * - anon_name
> > > > +     - anon name
> > > > +     - A field for storing a `struct anon_vma_name` object providing a name for
> > > > +       anonymous mappings, or `NULL` if none is set or the VMA is file-backed.
> > > > +     -
> > > > +     - mmap write, VMA write
> > > > +   * - swap_readahead_info
> > > > +     - swap
> > > > +     - Metadata used by the swap mechanism to perform readahead.
> > > > +     -
> > > > +     - mmap read
> > > > +   * - vm_region
> > > > +     - nommu
> > > > +     - The containing region for the VMA for architectures which do not
> > > > +       possess an MMU.
> > > > +     - N/A
> > > > +     - N/A
> > > > +   * - vm_policy
> > > > +     - numa
> > > > +     - `mempolicy` object which describes NUMA behaviour of the VMA.
> > > > +     -
> > > > +     - mmap write, VMA write
> > > > +   * - numab_state
> > > > +     - numab
> > > > +     - `vma_numab_state` object which describes the current state of NUMA

> > > > +       balancing in relation to this VMA.
> > > > +     -
> > > > +     - mmap write, VMA write
> > >
> > > I think task_numa_work() is only holding the mmap lock in read mode
> > > when it sets this pointer to a non-NULL value.
> >
> > ugh lord... knew I'd get at least one of these wrong :P
>
> to be fair I think task_numa_work() looks kinda dodgy ^^ I remember
> spending quite a bit of time staring at it at one point (my very
> sparse notes suggest I was looking in that area because I was
> surprised that change_protection() can run with the mmap lock only
> read-locked for some NUMA hinting fault stuff); I don't remember
> whether I concluded that the ->vma_numab_state locking in
> task_numa_work() is fine or just not overly terrible...

Yeah I guess we are documenting _what is_ rather than _what is sane_ anyway :P

>
> > > > +   * - vm_userfaultfd_ctx
> > > > +     -
> > > > +     - Userfaultfd context wrapper object of type `vm_userfaultfd_ctx`, either
> > > > +       of zero size if userfaultfd is disabled, or containing a pointer to an
> > > > +       underlying `userfaultfd_ctx` object which describes userfaultfd metadata.
> > > > +     -
> > > > +     - mmap write, VMA write
> > > > +
> > > > +.. note::
> > > > +
> > > > +   In the config column 'vma lock' configuration means CONFIG_PER_VMA_LOCK,
> > > > +   'anon name' means CONFIG_ANON_VMA_NAME, 'swap' means CONFIG_SWAP, 'nommu'
> > > > +   means that CONFIG_MMU is not set, 'numa' means CONFIG_NUMA and 'numab' means
> > > > +   CONFIG_NUMA_BALANCING'.
> > > > +
> > > > +   In the write lock column '(Static)' means that the field is set only once
> > > > +   upon initialisation of the VMA and not changed after this, the VMA would
> > > > +   either have been under an mmap write and VMA write lock at the time or not
> > > > +   yet inserted into any tree.
> > > > +
> > > > +Page table locks
> > > > +----------------
> > > > +
> > > > +When allocating a P4D, PUD or PMD and setting the relevant entry in the above
> > > > +PGD, P4D or PUD, the `mm->page_table_lock` is acquired to do so. This is
> > > > +acquired in `__p4d_alloc()`, `__pud_alloc()` and `__pmd_alloc()` respectively.
> > > > +
> > > > +.. note::
> > > > +   `__pmd_alloc()` actually invokes `pud_lock()` and `pud_lockptr()` in turn,
> > > > +   however at the time of writing it ultimately references the
> > > > +   `mm->page_table_lock`.
> > > > +
> > > > +Allocating a PTE will either use the `mm->page_table_lock` or, if
> > > > +`USE_SPLIT_PMD_PTLOCKS` is defined, used a lock embedded in the PMD physical
> > > > +page metadata in the form of a `struct ptdesc`, acquired by `pmd_ptdesc()`
> > > > +called from `pmd_lock()` and ultimately `__pte_alloc()`.
> > > >+
> > > > +Finally, modifying the contents of the PTE has special treatment, as this is a
> > > > +lock that we must acquire whenever we want stable and exclusive access to
> > > > +entries pointing to data pages within a PTE, especially when we wish to modify
> > > > +them.
> > >
> > > I guess one other perspective on this would be to focus on the
> > > circumstances under which you're allowed to write entries:
> > >
> > > 0. page tables can be concurrently read by hardware and GUP-fast, so
> > > writes must always be appropriately atomic
> >
> > Yeah I definitely need to mention GUP-fast considerations (and consequently
> > the pXX_lockless..() functions). Thanks for raising that,  important one.
> >
> > > 1. changing a page table entry always requires locking the containing
> > > page table (except when the write is an A/D update by hardware)
> >
> > I think we can ignore the hardware writes altogether, though I think worth
> > adding a 'note' to explain this can happen outside of this framework
> > altogether.
>
> I think it's important to know about the existence of hardware writes
> because it means you need atomic operations when making changes to
> page tables. Like, for example, in many cases when changing a present
> PTE, you can't even use READ_ONCE()/WRITE_ONCE() for PTEs and need
> atomic RMW operations instead - see for example ptep_get_and_clear(),
> which is basically implemented in arch code as an atomic xchg so that
> it can't miss concurrent A/D bit updates.
>
> (The non-SMP version of that on X86 doesn't use atomics, I have no
> idea if that is actually correct or just mostly-working. Either way, I
> guess the !SMP build doesn't matter very much nowadays.)

Ack will document.

>
> > > 2. in page tables higher than PMD level, page table entries that point
> > > to page tables can only be changed to point to something else when
> > > holding all the relevant high-level locks leading to the VMA in
> > > exclusive mode: mmap lock (unless the VMA is detached), VMA lock,
> > > anon_vma, address_space
> >
> > Right this seems mremap()-specific when you say 'change' here :) and of
> > course, we have code that explicitly does this (take_rmap_locks() +
> > drop_rmap_locks()).
>
> munmap and mremap, yes. Basically what I'm trying to express with this
> is "as a reader, you can assume that higher page tables are stable
> just by having some kind of read lock on the VMA or its rmaps".
>
> (IIRC back when this was the rule for all page table levels,
> khugepaged used to do this too, write-locking both the rmap and the
> mm.)

I feel that talking about stability in the page table section is a good
idea also then.

>
> > > 3. PMD entries that point to page tables can be changed while holding
> > > the page table spinlocks for the entry and the table it points to
> >
> > Hm wut? When you say 'entry' what do you mean? Obviously a page table in
>
> By "PMD entry" I mean a pmd_t (located in a Page Middle Directory),
> and by "that point to page tables" I mean "that point to a PTE-level
> page table".
>
> In other words, from the reader perspective (as I think you already
> mentioned further down):
>
> Rule 2 means: From the perspective of a reader who is holding the VMA
> lock in read mode, once you have seen that e.g. a PUD entry
> (overlapping the VMA's virtual address region) points to a PMD page
> table, you know that this PUD entry will keep pointing to that PMD
> table.
>
> Rule 3 means: From the perspective of a reader who is holding the VMA
> lock in read mode, once you have seen that a PMD entry (overlapping
> the VMA's virtual address region) points to a page table, you don't
> know whether this PMD entry will keep pointing to the same page table
> unless you're also holding a spinlock on either the PMD or the page
> table (because khugepaged).

Thanks right I see what you mean.

Might be worth having an explicit THP (thus khugepaged) section? And
perhaps even KSM...

>
> > theory could be changed at any point you don't have it locked and to be
> > sure it hasn't you have to lock + check again.
>
>
> > > 5. entries in "none" state can only be populated with leaf entries
> > > while holding the mmap or vma lock (doing it through the rmap would be
> > > bad because that could race with munmap() zapping data pages in the
> > > region)
> > > 6. leaf entries can be zapped (changed to "none") while holding any
> > > one of mmap lock, vma lock, address_space lock, or anon_vma lock
> >
> > For both 5 and 6 - I'm not sure if we ever zap without holding the mmap
> > lock do we?
> >
> > Unless you're including folio_mkclean() and pfn_mkclean_range()? I guess
> > this is 'strike of the linux kernel terminology' once again :P
> >
> > Yeah in that case sure.
>
> There are a bunch of paths that zap without taking the mmap lock, the
> easiest to reach is probably the ftruncate() syscall:
>
> do_sys_ftruncate -> do_ftruncate -> do_truncate -> notify_change ->
> simple_setattr -> truncate_setsize -> truncate_pagecache ->
> unmap_mapping_range -> unmap_mapping_pages -> unmap_mapping_range_tree
> -> {loop over file rmap tree} -> unmap_mapping_range_vma ->
> zap_page_range_single
>
> GPU drivers and such do it too, search for "unmap_mapping_range".

Yeah sorry I missed unmap_mapping_range(), I don't love the naming around
this...

Might be worth spelling out these paths specifically actually.

>
> But you're right, I was being imprecise - as you pointed out, it's not
> just used for zapping. Maybe the right version of 6 is something like:
>
>     Leaf entries that are not in "none" state can
>     be changed while holding any one of [...].
>
> Though I'm not sure if that is overly broad - I think in practice the
> changes we make under the rmap locks are something like the following,
> though that might be missing some:
>
>  - zapping leaf entries
>  - zapping PMD entries pointing to page tables
>  - clearing A/D bits
>  - migration
>
> > OK so interestingly this really aligns with what Alice said as to this not
> > giving a clear indicator from a user's perspective as to 'what lock do I
> > need to hold'.
> >
> > So I will absolutely address all this and try to get the fundamentals
> > boiled down.
> >
> > Also obviously the exception to your rules are - _freeing_ of higher level
> > page tables because we assume we are in a state where nothing can access
> > them so no such locks are required. But I cover that below.
> >
> > >
> > > And then the rules for readers mostly follow from that:
> > > 1 => holding the appropriate page table lock makes the contents of a
> > > page table stable, except for A/D updates
> > > 2 => page table entries higher than PMD level that point to lower page
> > > tables can be followed without taking page table locks
> >
> > Yeah this is true actually, might be worth mentioning page table walkers
> > here and how they operate as they're instructive on page table locking
> > requirements.
> >
> > > 3+4 => following PMD entries pointing to page tables requires careful
> > > locking, and pte_offset_map_lock() does that for you
> >
> > Well, pte_offset_map_lock() is obtained at the PTE level right?
>
> pte_offset_map_lock() is given a pointer to a PMD entry, and it
> follows the PMD entry to a PTE-level page table. My point here is that
> you can't just simply start a "lock this PTE-level page table"
> operation at the PTE level because by the time you've locked the page
> table, the PMD entry may have changed, and the page table you just
> locked may be empty and doomed to be deleted after RCU delay. So you
> have to use __pte_offset_map_lock(), which takes a pointer to a PMD
> entry, and in a loop, looks up the page table from the PMD entry,
> locks the referenced page table, rechecks that the PMD entry still
> points to the locked page table, and if not, retries all these steps
> until it manages to lock a stable page table.

Right yeah, I mean this is kind of a standard pattern in the kernel though
like:

1. Grab some pointer to something
2. Lock
3. Really make sure it hasn't disappeared from under us
4. If so, unlock and try again
5. Otherwise proceed

You have this pattern with folios too...

But yeah maybe worth spelling this out.

>
> > pmd_lock() at the PMD level (pud_lock() ostensibly at PUD level but this
> > amounts to an mm->page_table_lock anyway there)
>
> > > I think something like
> > > https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#overview-documentation-comments
> > > is supposed to let you include the current version of the comment into
> > > the rendered documentation HTML without having to manually keep things
> > > in sync. I've never used that myself, but there are a bunch of
> > > examples in the tree; for example, grep for "DMA fences overview".
> >
> > Ah, but this isn't a kernel doc is just a raw comment :) so I'm not sure there
> > is a great way of grabbing just that, reliably. Maybe can turn that into a
> > kernel doc comment in a follow up patch or something?
>
> Ah, yeah, sounds reasonable.

Thanks.


I think all this makes me think that we should actually have entirely
separate top level descriptions and internals sections in this document,
which align's again with Alice's comments.

As the level of detail and caveats here mean that if you provide
implementation details everywhere you end up constantly on a tangent
(important, relevant internal details but to a _user_ of the functionality
not so important).

