Return-Path: <linux-kernel+bounces-417001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0442E9D4D79
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 14:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE74F281D88
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 13:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4747E1D7E5B;
	Thu, 21 Nov 2024 13:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Yoz2dTHM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eOkJsOaK"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427ED1B0F0C;
	Thu, 21 Nov 2024 13:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732194527; cv=fail; b=cmD+9eG+oFrbGqdc7XT/dDJImINIhW3d7Tx+fpTaTEj+mPOgIxz36cC5DRpsyQe7yVAmI8BpWqILBYBNu0pWm484CHIxaYFpMwkQbtsdazPDZH+5aI6UuTSpXFbpLR9o+KgUG7vPf2fwtmol4Ql9TO3AzYwyamarCDCXU+PJu9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732194527; c=relaxed/simple;
	bh=gX7tP9nHmY+evK2t7q9eFWWfib44zRWUVqc2AUnnFvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HW5/edp2W8l53Zb/RDCadOo+5AS5LnF3r4N47cCoF1gj2aqgwMYTzrKdElsg4z6O5z137tA4m3/Lh7tvwtTnduIQyPFZgsybmcyfv//IdU1Jq8cQmfipcej0AWQ7vE3ozw1KMnVWD7AMaGbpv16Tzq32tCfIHpyb52CJtxvz0j4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Yoz2dTHM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eOkJsOaK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALCtb5e006901;
	Thu, 21 Nov 2024 13:08:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=SEEc+VchNYluCDD+m2+jqx4+24YzQx10nVUo5VJKnvw=; b=
	Yoz2dTHMof+XyArY72B2l3P6AuQStNhQqYzZNr3j+vTIM5KLQ/Xk+KOcGn+pzW75
	jPlx3TYkSgQyRg6JQ4UTaoOcM8mTIY0EnK2nkaig+tEKWxOD8Oias77wU8jcp/t4
	2WlosAS/Ek7FEeRYwKIrLmJYi4W+WQ89nlugrggALAlXBRwLtpNWAl0PKpKfnZQH
	n5hvv4zaVVPO8c5M9/5gl86J23aRcy4ejMsSpxv3L1+NwIYBWo35MVO5b0XcVHHT
	NEHdGboX51rephOUsVYrZbbrK7Jgf/H/h4G+6To3t+r+32S8tagTNFFc3S9hHlRL
	hNnkBXVDPQDoinGbb6kr0g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xkec1q5g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 13:08:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALC9lBJ039272;
	Thu, 21 Nov 2024 13:08:21 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhubh3d3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 13:08:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y8BITR6oZjYZyKNlItj3VvkNJ8ZW/q2MBubwyzz+xeMdHz5gy6e+GhtcF2vnsI6uwr0zDAvNuPZrnOiyfW8/5I0yF9FqYOv0ZNk7tH8EQxRK6wCEpWtMLHMp3YCtp6GifIRWHUvC3glEoi4eufiqCWsJFr3i7agcM5wczoYH/EQ2LMa3fjtJCZMmmyN+S/ZIDTMny/T83DwAUkl7ZIS0+63I9fuKM1wbtk/nji1tU28uPCe83FJBb/F1XYrD98aRwkIR8ELsH+YqsOakPXkKnnY8B7/83wcpG5XpskslcDich/Chk94KUF0b5qcnkBtgqZpElozL2BiHUc6n8xjizg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SEEc+VchNYluCDD+m2+jqx4+24YzQx10nVUo5VJKnvw=;
 b=PB94ivwC28e7jE4HWsL/6f8/ti1IisZEU/IZQdRLyzVTtkXC0qZc78By5dWUA9eeDS837rfUWrnrUjFiMvb+oMw+NAnhYG+8bwkNnoV9ZcHtMcHa4U7b2BedjV38aJCNFnND4W2++lBa0/D8GEqd2ugB3vrthpT0YLerUiPdrq4Hh1NCpJfminKtJ0RmVsKFgx7pWPrtqMNWC15XcdNKHnb6SyGd7+RK00RViDK9T1hwwdAWqfRjJaJ4fpg4j9UrlzjIKR7Sq/UpHGpw3LRRZQh6VHvqE9H4RJVHiUDBPNKieYFZVbR0L+MTRo8ja5h7KsjA0vpzDJlkl38Nq4LOgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEEc+VchNYluCDD+m2+jqx4+24YzQx10nVUo5VJKnvw=;
 b=eOkJsOaK9LkfVbGxMXyfAAMmETb1jtz9Bn8gKQPIj/9mi7BGKsbxDguhzwMeUakWP3sVIk+jdMcxUB1aejahrxpdv0MpTvTJRpwnUY2MOyFJndpeqxEQJocx66Ygsb1JbRa4bCKgxxcFaAOPauL52ddYXVB1kgkIx5rJJ4IiFjo=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by IA1PR10MB6267.namprd10.prod.outlook.com (2603:10b6:208:3a1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Thu, 21 Nov
 2024 13:08:18 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8158.023; Thu, 21 Nov 2024
 13:08:17 +0000
Date: Thu, 21 Nov 2024 13:08:14 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rust-for-linux@vger.kernel.org,
        Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH v8 6/7] mm: rust: add VmAreaNew
Message-ID: <c7c3b9ca-6ce3-4c14-b886-7e6c7262b5bd@lucifer.local>
References: <20241120-vma-v8-0-eb31425da66b@google.com>
 <20241120-vma-v8-6-eb31425da66b@google.com>
 <8755851f-de55-4411-9a8a-80ff69f35905@lucifer.local>
 <CAH5fLgiEjxN14K3QLnfxE-HFes_DmjtGSa9tJxOVJhLOv4sSEA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgiEjxN14K3QLnfxE-HFes_DmjtGSa9tJxOVJhLOv4sSEA@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0570.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::14) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|IA1PR10MB6267:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d651330-6f65-4720-a201-08dd0a2d909f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Tnl6M0kycXNqVTFtMGJXdmJ1YzhKZE9SUU5RYkZIZXRtVnpvYzF6c1UwYmFR?=
 =?utf-8?B?YUhGV1RobnhmSW9Wa1B2RHdPclVhNFJUaDVsbXFzK3phVG9Hci8vQTJWSVh6?=
 =?utf-8?B?VUdKL1dtRXliU2hkZUNhVTFodkQxeUQ5V01JU0huREZiQUxERWNzWmtYU3B6?=
 =?utf-8?B?ZmsxL2tHRlVwcE51VFVFMlFtT2RMbjl1Z21QYkozU2R6cVpOMXNid21FMncv?=
 =?utf-8?B?YWNHMjVCNzdwUDFWS1ppTVorbk13YTRnZVN3RDlWTmc1eGk5UEJhc2NrTGlG?=
 =?utf-8?B?WlFDQWZnM1ZRdFRkT3FEcFJhQUhiMjJjUVNPSmJPcFBNZTYraVppdnZDNVgr?=
 =?utf-8?B?U0toemI3S1EwRjFsTnVXT0t1YkJUM2VvSndtV1lCeW5nT2JKSUtDRkl6OGtW?=
 =?utf-8?B?WDBTWGxZQzAvV2lScnVaQ01OTk5kUUtiTFhabEo0VTI5bUtjMVpJR1VQcHRp?=
 =?utf-8?B?b3A3YWJDY01ZVlczMHNBd3hyU0RaQ2RmMmplUzRiZUFXaFltRGhTdlRZVncy?=
 =?utf-8?B?KzU2VlNoNlBhT0c2b3M3SjFvUUpPVmxYeFZtTnlwVHB1dmduVG1pYUtRcFEr?=
 =?utf-8?B?YTBwamM3djhja2k2RkREN1dkdXJKYjV5dWphRkZJc0QyYmRTN3QxSW11L29L?=
 =?utf-8?B?OEJscjFkMGpzelBUSEhDcTFSbVhlZ0R3Y2VxdVRZcnY4VWp5My9FQ1gxdkwy?=
 =?utf-8?B?UGZtNXV6U3dMK05zR1ZvVk5hUVpxUFE2NUpQSWRJckEyanJZVHBpekdmUVJt?=
 =?utf-8?B?eDhValJnMW9MT0ZPOHdDeFI5ZHFCazcvTXAxOXkvK3Rabmh2Qld1K0RzL3Ns?=
 =?utf-8?B?TXBOQlpOQ3U5dXp4UE81SmMvckpBUXROUENhUDBzTGFGaGkyRE1mNjJtS1FB?=
 =?utf-8?B?aUk0K1FkMEY2V2llNmNaUWNYY3B4NE95eHFZRnJDSDc2T0FHMTFMQXB1NXYz?=
 =?utf-8?B?c29BMHRGaDhYV0ZMd003TmpKMFQ1TEd4bkNFYi9mbzJjOHdiSDlHTE50MDM4?=
 =?utf-8?B?WHArYVU2ZG5pcmFrRFNOTWZxdE8yUXA5YkRPam1XcW9hNzhMcTR0ME5EZzRk?=
 =?utf-8?B?UHBRbksrREZld2ZXaGZObm5mZnFsSms0QWx1LzNXR1pTaGwrUjlOeFJnc3JS?=
 =?utf-8?B?bDNmUldUTUY4V0pVV0t2bWhuT3JkQWJvcFFwQVJ1WWhtWnlEWENyU2VkSFBD?=
 =?utf-8?B?N2xQbVJOeCtMd2c1YXVXZ0EwTVFqRUx6cnhUUDFHYXRTejNUWXlKTVVWSHRp?=
 =?utf-8?B?bmw2cDJaeEExcHpoRFE1ZjF2ZkZaUWxLUmo4RGU4dVBQbkVoQ3hQS1FuRExl?=
 =?utf-8?B?YVpNQjR6dFh2VkVtM0Nqd3JBS2RjbzY0QytYb2NyaUhad1p3cmk2cUtrVlY2?=
 =?utf-8?B?Ty85ak40VHBZUDY2YW5zTWtRS3VHbU9xL1RHVVhGME53TDcxRnFpd2pYQlJk?=
 =?utf-8?B?b3M4U05CVVdjeWgwQ1lIUTV4bjhENFhwWGZ1VG5PVXJ6b04wbVl2Ni9VZG5h?=
 =?utf-8?B?eFdjSHFxSEM0NkM3WDRPa0RHYzYrZlplMFZwVFpDeTN3NDM2STVlK3g1R1pw?=
 =?utf-8?B?cTR5VVpncWdBZFd1TEJjV2NQNkNSNkJDWVBReXdLVTVWV1VrUmJmMlg0Zm85?=
 =?utf-8?B?V0tVSi9DVzBwYTduR1JaSE1yNUx0ZWFKenV6Tlh1Znc3MzA5SlJVMllvME8x?=
 =?utf-8?B?OFA3R01DUm14OGlUbVY4dTYvU1Jxb2Y4SnJQUjFZMXZlMzV6RzQyM2syTzE3?=
 =?utf-8?Q?1fUp6SEEbmSohWy7U1/Ap6gf5Lg2maSPyGvJ0sW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVE1YjVMdzZ5ZmVBY1BxVGJUVS9lbW84b2tHOXZsUHQ1MzVGL1UyZmlSMThL?=
 =?utf-8?B?Wmd0bHBnV1QrL1RIOGpqdlF2TVRGcldpRzVEdEJpcFVSckp0OXlCRzZvNTdS?=
 =?utf-8?B?eFlxRWRFcElTd05LTHVZZkZud2Fia3dDTVVzTzJJc20waDZic1o4MXVCcUdS?=
 =?utf-8?B?aU9qcHFiL3lHK1RaRStKdmVBSXNMdlhsOS9CRzMyN2lLcTc4RWx3bXI0NHdp?=
 =?utf-8?B?TUZMQTVucGJiUU91czJyREwrbTF5bkwrSWhZTEFVYThNZEwyUjU5eDB6QzFl?=
 =?utf-8?B?c1duSzN0azNzZ01QcHJiTVdDNUVScThhNisyaXZHRCs2S0t0YVFFWFYxdVlV?=
 =?utf-8?B?cjVGdnR0RXJ5YVo1WGxDeHNIbzhyanJBNi9zeDE2eE1OTWZmYysrV09ycFZs?=
 =?utf-8?B?eWtyUE85V0lEQ2liLzJKNml3cjRkVVVKZFMrZnVpZjVMV1ZMclhUM3BEK0Uz?=
 =?utf-8?B?ZTZuSy9TTzN2cEVBeE1aUnhSMWtkT0hrUEFlYndWSHJic281ckp0YTduWm5W?=
 =?utf-8?B?WU00d1Fzc09qTlNXcVVubFI2R1EzNTZJZndLQ055UUg0Q3UzNWtBMHVtV0Z2?=
 =?utf-8?B?TWZXZ0RDbUxGVlhoWXZSeDlzRHBhcmdiZlhTMUJtL2xVcHYycXBhbWFsdTUz?=
 =?utf-8?B?Mi9qNE03a3hyRCthUm9uY1VvUGllQy9Ld2g4ZTdCa1BHUVZFR2t0V1hoQ0k4?=
 =?utf-8?B?clhtYWQ3UXNhK0FJa0gzcXhENWEvQTVFYngxMXRPTHJYZFIrRzhJeHdhMDIw?=
 =?utf-8?B?ZkZEenBzTVg3a0lPZVJQczJjbkx3RzMzU3lxNURDeWgzYjRZZmM1OTB1aFRN?=
 =?utf-8?B?NDZsUFIya3lRMFMzSytoZ2pNSDdhRUZkT0MwSk53WUNVQjlJOHdMbnhMTmVk?=
 =?utf-8?B?TFYyaGdXUzdSNE1XbnZjSTFXS3hoSDExbGRVUmNhTlNQdTd5Ujk0eWppVVVq?=
 =?utf-8?B?ZXphK3dVVU1SZjA0NndFSS9qTi9ZVWZOTXJvTFFWUzk0NEdyUTNwbFFIdW9E?=
 =?utf-8?B?TVFtbGFGVWozQjhSWEJ2cVh3c0xvcnRmTFo0QTdaUmU5K2VtTnIxbmp6UDcw?=
 =?utf-8?B?VUFEclU2TW83SGthSmJEcjJkNFNPT3ZsRmxDa2FHY1lBdXdMV2JHRU5vMU1V?=
 =?utf-8?B?UFcvUEJ0WTNjUFJZaGM1aGpyMStFNnp2bThaeXhlT0txZ1pNUXFTL244dlpr?=
 =?utf-8?B?UzZKY2R4SWJKTnVWNnlnU0tqS2tFTmgvcUZ5YWVZdDM0dDlWYUFia05SU2V6?=
 =?utf-8?B?ZjhwSlZxZTUvTmRwelJ1TnY1TkxuSTVndHo4Y1lWSUtKcFhDNTFSMmJUTVdC?=
 =?utf-8?B?dE4zUWdSeVhTOHVnQkZBd0hMVTltakF2Wk1sM0dSbDI2YjhvQTFVNXdnVXlV?=
 =?utf-8?B?dHJUOFRCUnhOeXJ0UGgrNzArYmVkMlRWRlQwc09OdktjWGc1YlNQQ2NvTFZ5?=
 =?utf-8?B?YkNJeTN0YUZNWXIrSkJPWUw0L0NlZy92eFd4Y0NiNkcxVklZQjllT0FQc2xp?=
 =?utf-8?B?c3hueUxrbzVvNy9SYXJVbW5TSWhsV1dNMWgyaTFaQ3pweGpIUlUrcTVjSlZQ?=
 =?utf-8?B?YnRRcWNCWUhSNTBJTzdCTXdxZ1ROcXZscDZaSU5TbkhnOUxnOWgvRnJtaGdH?=
 =?utf-8?B?VTZOc3VhekM5VmlRNWpRMVRBNk8xbWY3ZDdpd3dWeTQ1TFR6TzZwQXJjWWJE?=
 =?utf-8?B?S2RucXI4MUlwaXFzdFJJZUZjcThaUTdiZnJqUU1tQUZnOFoxWVAzVFdxMGVy?=
 =?utf-8?B?dTJycXEzalI2YlNOSWFaeWlkeCs2bU54WjFZU011OGRYNTBNVTg2Q3RrVXJX?=
 =?utf-8?B?N01oNENTREEyVDVtamp5TUJqa0liQVhXQ2JKMmtFYlAyWmxZRjZOZXdlYkVZ?=
 =?utf-8?B?MDMwRGZVUWkxVXBzTGpvWm54RjF0WVk2VmUwS1VFQjJUQnhBdVZzbGViYmJL?=
 =?utf-8?B?TllBeVBPVis2WGhCRGFqcVJyVFZkdXdUMHdLeG8rYmY2M0RvYlhtcnE1MWlG?=
 =?utf-8?B?MTlqL29uT05ncm1YMjhPUy8vcUtNa3VMdHYzL2M5dmVVSFp6T0RpekR6UG0y?=
 =?utf-8?B?NlY2cnN4cnh2eStNaWtRWHMyU2o5eVNTWlE4Z3VjTFRudWF1cFgyZlM1MU9U?=
 =?utf-8?B?c0VkOGxPd0QwOUxMdG5sZHhNSHpxMmlrUW1UQXFqYTh0QVU2SFBUR3E1M01i?=
 =?utf-8?B?MGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	18ugOHIgwYdDfhu31RGQ0Uh+OGk5x1bFHZxuj+4oSDY76DXZ6warBZejfm6EAgItc5na7+ne2ikR4IcCt9kuc164oVsqfOuyXf9VTnIbx1CvqI8bhur0FPalm7CyRG5CUGum77Pr1BW/A+W4pj0eZvYRMVI55TMpjja/m8HtcEas25m/ElI5cQOcR4mDDJRIyrJ0xIaEyq5IaaUwPhbdwyicfxmzmZKuBBhtcrb6Z+4ubK8pLwnXMU7rJASb/qXudqtMmRLko+9CJd1uhK90GN1zv0RuyEufKbOVG2qtp64VK3D4RNXY86qvs5kIKPXxwBJ/5GM2k7//DC4TqodhYHE7AD4+ZpisL0GBwzYxmG6cri0sQ0neVGSlqTMEiUs+DRMsVed0FKt4vJcnNpzBzApgLUGLyUV5fzPI7E9/ULxTspwQFLnmzjBqhal4yYMfJHqIhpE/5OrzPPoKAnDER9Eua0+XPIQ+EXf0Q+Z+ytMTaN5MUBJKdN+HnJi8IHi+6OvNIgfiICDvD67iLA+ZfybsVr6dVi0DHnHsu5PI7tAAliCNHJHfz/4yDJzAXI9EHEhZg1s19N1NEJ0JE09IvJyPiMfz9wGb4kkWsA6s/WA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d651330-6f65-4720-a201-08dd0a2d909f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 13:08:17.5343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 99ErEllbAcKSuMZzifUh6AnsFmAtR3WCZocrIUzb5lL3Ta12Aqs7JhF+FX5Z229ZLWO+vhP0hKWlaGSY5b016Nd21jsbs4a4cNBWb6FpAWU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6267
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-21_09,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411210102
X-Proofpoint-GUID: D7SaHTyk62SaM7iK1JJlbvR2MaufdsNA
X-Proofpoint-ORIG-GUID: D7SaHTyk62SaM7iK1JJlbvR2MaufdsNA

On Thu, Nov 21, 2024 at 12:47:33PM +0100, Alice Ryhl wrote:
> On Wed, Nov 20, 2024 at 9:02 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Wed, Nov 20, 2024 at 02:50:00PM +0000, Alice Ryhl wrote:
> > > When setting up a new vma in an mmap call, you have a bunch of extra
> > > permissions that you normally don't have. This introduces a new
> > > VmAreaNew type that is used for this case.
> >
> > Hm I'm confused by what you mean here. What permissions do you mean?
>
> I just mean that there are additional things you can do, e.g. you can
> set VM_MIXEDMAP.
>
> > Is this to abstract a VMA as passed by f_op->mmap()? I think it would be
> > better to explicitly say this if so.
>
> Yeah, the VmAreaNew type is specifically for f_op->mmap(). I'll be
> more explicit about that.

Yeah this is really critical on this one for me.

>
> > > To avoid setting invalid flag values, the methods for clearing
> > > VM_MAYWRITE and similar involve a check of VM_WRITE, and return an error
> > > if VM_WRITE is set. Trying to use `try_clear_maywrite` without checking
> > > the return value results in a compilation error because the `Result`
> > > type is marked #[must_use].
> >
> > This is nice.
> >
> > Though note that, it is explicitly not permitted to permit writability for
> > a VMA that previously had it disallowed, and we explicitly WARN_ON() this
> > now. Concretely that means a VMA where !(vma->vm_flags & VM_MAYWRITE), you
> > must not vma->vm_flags |= VM_MAYWRITE.
>
> Got it. The API here doesn't allow that, but good to know we can't add
> it in the future.
>
> > > For now, there's only a method for VM_MIXEDMAP and not VM_PFNMAP. When
> > > we add a VM_PFNMAP method, we will need some way to prevent you from
> > > setting both VM_MIXEDMAP and VM_PFNMAP on the same vma.
> >
> > Yes this would be unwise.
> >
> > An aside here - really you should _only_ change flags in this hook (perhaps
> > of course also initialising vma->vm_private_data state), trying to change
> > anything _core_ here would be deeply dangerous.
> >
> > We are far too permissive with this right now, and it's something we want
> > to try ideally to limit in the future.
>
> The previous version just had a function called "set_flags" that could
> be used to set any flags you want. Given Jann's feedback, I had
> restricted it to only allow certain flag changes.

Yes this is a good idea.

>
> > > Signed-off-by: Alice Ryhl <aliceryhl@google.com>

This stuff is sensitive (again, we really need to do something about this in the
VMA code, TBD) so will want to see the v9 respin before ack.

> > > ---
> > >  rust/kernel/mm/virt.rs | 169 ++++++++++++++++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 168 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/rust/kernel/mm/virt.rs b/rust/kernel/mm/virt.rs
> > > index de7f2338810a..22aff8e77854 100644
> > > --- a/rust/kernel/mm/virt.rs
> > > +++ b/rust/kernel/mm/virt.rs
> > > @@ -6,7 +6,7 @@
> > >
> > >  use crate::{
> > >      bindings,
> > > -    error::{to_result, Result},
> > > +    error::{code::EINVAL, to_result, Result},
> > >      page::Page,
> > >      types::Opaque,
> > >  };
> > > @@ -148,6 +148,173 @@ pub fn vm_insert_page(&self, address: usize, page: &Page) -> Result {
> > >      }
> > >  }
> > >
> > > +/// A builder for setting up a vma in an `mmap` call.
> >
> > Would be better to explicitly reference the struct file_operations->mmap()
> > hook and to say that we should only be updating flags and vm_private_data
> > here (though perhaps not worth mentioning _that_ if not explicitly exposed
> > by your interface).
>
> I guess also vm_ops?
>
> > I'm guessing fields are, unless a setter/builder is established, immutable?
>
> If you have a mutable reference, you can always modify fields. When
> you don't want that, fields are made private.
>
> > > +    /// Internal method for updating the vma flags.
> > > +    ///
> > > +    /// # Safety
> > > +    ///
> > > +    /// This must not be used to set the flags to an invalid value.
> > > +    #[inline]
> > > +    unsafe fn update_flags(&self, set: vm_flags_t, unset: vm_flags_t) {
> > > +        let mut flags = self.flags();
> > > +        flags |= set;
> > > +        flags &= !unset;
> > > +
> > > +        // SAFETY: This is not a data race: the vma is undergoing initial setup, so it's not yet
> > > +        // shared. Additionally, `VmAreaNew` is `!Sync`, so it cannot be used to write in parallel.
> > > +        // The caller promises that this does not set the flags to an invalid value.
> > > +        unsafe { (*self.as_ptr()).__bindgen_anon_2.vm_flags = flags };
> >
> > Hm not sure if this is correct. We explicitly maintain a union in struct vm_area_struct as:
> >
> >         union {
> >                 const vm_flags_t vm_flags;
> >                 vm_flags_t __private __vm_flags;
> >         };
> >
> > Where vma->vm_flags is const, and then use helpers like vm_flags_init() to
> > set them, which also do things like assert locks (though not in the init
> > case, of course).
> >
> > So erally we should at least be updating __vm_flags here, though I'm not
> > sure how bindgen treats it?
>
> I don't think using vm_flags vs __vm_flags changes anything on the
> Rust side. The modifications are happening unsafely through a raw
> pointer to something inside Opaque, so Rust isn't going to care about
> stuff like your const annotation; it's unsafe either way.
>
> I'll update this to use __vm_flags instead.

Yeah, I mean _in practice_ byte-for-byte it will make no difference but it'd be
nice just for the purposes of maintaining a similar abstraction.

It might be worth wrapping in something that explicitly references that this is
on init only but I guess _the whole type_ does this.

>
> > > +    /// Try to clear the `VM_MAYREAD` flag, failing if `VM_READ` is set.
> > > +    ///
> > > +    /// This flag indicates whether userspace is allowed to make this vma readable with
> > > +    /// `mprotect()`.
> > > +    #[inline]
> > > +    pub fn try_clear_mayread(&self) -> Result {
> > > +        if self.get_read() {
> > > +            return Err(EINVAL);
> > > +        }
> >
> > This is quite nice! Strong(er) typing for the win, again :>)
>
> :)
>
> Alice

