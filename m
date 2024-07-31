Return-Path: <linux-kernel+bounces-269040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D8E942CAC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 638EF1F25020
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 11:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9071AC43D;
	Wed, 31 Jul 2024 11:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fN4ElBDK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Xxq5pgvO"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6296145FEF
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 11:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722423807; cv=fail; b=Aq6gZLqCN7B4B5rndPx+M63hH+NIQtjjLaHHOTD391VNlkn+yk6LxWplh0O1np3xJ7moUVNRhpeEpdxretewjhtTMHdpWQSUZuVX7vkdO7n1splNn+bcYu5Aw0oQk1Geui0fB6tcABSdytIlsisdEbLDQsevPo94S0Wu+DJeSRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722423807; c=relaxed/simple;
	bh=QAqacD+kpCUsm4BMHsWESk5MDZGCBoi1gQWxx9vNPBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IOGFQIdQ8E08uDx/gU8BAZNXbVGsK3ZK8MBjU1DnxH12y0LHf10Rno8MjY87jviJlUBOkdZwthE+Zdn52vFUkCVLnZzlU4dwXRepQ/ktht51qvV83iQ77lvr9c0ZYDMDPNDpcmprnnqbnAwsdiKqziKGkiuJfG1ZSfM0D/NeRxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fN4ElBDK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Xxq5pgvO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46V7tkRI017677;
	Wed, 31 Jul 2024 11:02:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=3B6pJQ1/xrkeTBazMw3Ba2Q5E4w2UfH9CJ4/wXd4dRU=; b=
	fN4ElBDKUTUQ9L5pujP+uo9kpnU4+hm6sdzwyP/BAgceJ3UpWkQVtJgSQ8E6D82z
	j1xmSMcibhpNenvi7mcTp4gHUnUx24os+KXA7Zr5XOaiPyCoS3PPgfBQjxDNdXma
	VxZS+v+NiP97GHhnB0hqWldm2gvGE6b5KN38n3rZ7TOLMB5h7z49rxwYKjnIJohy
	Hi0hskwd97R0+bMlGxp3s8zpJPYIdharCoZ2wVYNzkIdCSW9WNn3Dg+uXY/KT9j6
	T0dManD1ie9DuHHmw3BYijsytejTRkOXY3fe2YibrC/U4J5ZmurdTs33V68Y8fai
	N9RNU5hjYOqKAidCJTgaQw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mrxby6ep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jul 2024 11:02:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46VAxhsD024421;
	Wed, 31 Jul 2024 11:02:55 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40pm84feu3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jul 2024 11:02:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gz2MYXqlMH0yujWkzaNNoGmaUoHXliZ4PWwxXamOf4r6P3o6tQKkCxNUTxVOU3e0lp/+XMLvVcRt3cUxHLW/pa2im8tqQrgrrJVj9lwKQ2RfDodWRJa4y8g37wh716rSSl4RKsZaIRSZSynRc+6D74pWIoqDmlzdkKI3R8Kf0Pp0Z6Z3oyPejr5DDWTE7DTkldgy5s1UUeGE5L29lrpe5PpxiPfPA6MRuD7C4LfvL11nPEHO26ChE7GJ308NUQMd6qXVBL/f+lSvzQMApEaEeTeEfvqXPV0FQIJY9qAAN9cjA68RWiJlV0v9hPZShSgFtqtBvoJkff+KnJ3cFtCMEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3B6pJQ1/xrkeTBazMw3Ba2Q5E4w2UfH9CJ4/wXd4dRU=;
 b=qiXiQh8uSwgEw2frV7jAzvKvcQ5U4qmLhrQQnj5XieTK0xf4djjXkfZa/IhwfenJpGNoyms15aecR+CQqA+TnBaqSYJPQgtzM/getNMHMuFElklhi0jrdbyzNtTI9+XPKyx0j5DVrPPWe5SxA56mu/HFZAFxEgdlWxR+8HFVQx7ZCvPxkLf3BasJSCBHwYbF8X/t/T0+3b2T63r4w/WY/eQWSN/5hRFNWrS35bQez2o4QfbhrwAiPEIOJXuE3iBV+b+K1PPvKOVQOMsJt2m2Rd0DAabY0ylvboJkNXBxEMucuv6AQIqQMf7RP8v+Hn+oEZxt7gkqjpaiWcT+OKkd5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3B6pJQ1/xrkeTBazMw3Ba2Q5E4w2UfH9CJ4/wXd4dRU=;
 b=Xxq5pgvOXCT685q/tJQ6Je01APsh4X0CCz3Tho/BsStKspb2JD4GlOdDCUGdqoQPUHS+wD3zV1iWThGFvqpuk8oOJwfpt0somKombIUpHmZZ2t88TBYaClwwLpEm5ETWvKG5AWBIaNIt7c2p8u8Xm9A5E9twQGKkKmDH2L3FDis=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CY8PR10MB7195.namprd10.prod.outlook.com (2603:10b6:930:78::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Wed, 31 Jul
 2024 11:02:53 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 11:02:53 +0000
Date: Wed, 31 Jul 2024 12:02:47 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Oscar Salvador <osalvador@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Peter Xu <peterx@redhat.com>,
        Muchun Song <muchun.song@linux.dev>,
        David Hildenbrand <david@redhat.com>,
        Donet Tom <donettom@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2 6/9] mm: Make hugetlb mappings go through
 mm_get_unmapped_area_vmflags
Message-ID: <8a57e184-4994-4642-959d-44dc7efbceca@lucifer.local>
References: <20240729091018.2152-1-osalvador@suse.de>
 <20240729091018.2152-7-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240729091018.2152-7-osalvador@suse.de>
X-ClientProxiedBy: LO4P265CA0103.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::6) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CY8PR10MB7195:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e571cd3-362e-4608-49e3-08dcb1505308
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MklNQ0gvYWtEL0FpWlUwbzNTeDVibVNhWG5KM1NnMi9vWk9ZQUl1UlROdU9P?=
 =?utf-8?B?TWQvYmF2R0IyUyswdlBDcnNQcjR1eng2eDNNRkV6SDZWbnVMakdvSHY0ZktK?=
 =?utf-8?B?SDBZL0F5MzRlY0UrNlpwNHVSdSs4L01xWGVHZnhkOElDU3E5QzZxU1lWRU5H?=
 =?utf-8?B?cjRqWE5GTHRtZnZ1QkJsaWNSVVVQSmtvVEYvNXd4b0tJekpNRW9mS0pZR3Zl?=
 =?utf-8?B?b29yeFRPbXVPZjFCWktXbHFOR05BTllJNE05R05PaW9hR2RyTGtPT0s3VU9I?=
 =?utf-8?B?QTA2V2E5a0pwL05BYlBnV1FtTFo2Y0NBdWNtOElPazI2S2l4VGRPc3VHckZi?=
 =?utf-8?B?cjdhSEMxQjhsbGNQemo3Y2FweG9PSVYxb0dIaUFKSGNUb3JnbWdHeEZWNnNi?=
 =?utf-8?B?bzBkelVpUnU2eWE1Q3MyWVdBWjZ2SHNHalFCUG84UUc0WmlMQXcxazRrQWdG?=
 =?utf-8?B?eHBlMGY1R3UxNWVBdEtxT3FZaUQ4VkZBMEwrYUJ4NFBiamh4YVZ4WlNISlRT?=
 =?utf-8?B?YVMvdHVtb0kvcGNYcDBSeEJmV29jQkhUZEtlYTMyRW1YV3JNcWMyK3EzbUdU?=
 =?utf-8?B?V3lVZ1JNQkJPUmhuYXBPQlhqazFFWDJJS0Fqa21WTTR2U0tOdFp5MFhMcVVo?=
 =?utf-8?B?Sy9yWXl5UHhHWmtZaGZNYklxSEdIN0tDWXJZL1RPWFRWUjFHTnJpbU8vdHJI?=
 =?utf-8?B?eGZpQUNINDNZWFlTd2dTM3pXQi8va3oyYUhXVmFXN2pUZlE5eFBQRk41dW1Z?=
 =?utf-8?B?U3F6bmVIV3BFUVl4bEpwcG9KTm0ydnVKSldsRzlJTlQzczhtUDBWVXJ5ZFN2?=
 =?utf-8?B?MjBxK1dwdmROMGh6TjY0dFUrTUhHbDhUb2U3MWZHZElUMGxEdGNrQ1hoQ090?=
 =?utf-8?B?VG1aZml5OHVJcWNBK0tsdFlIbjNTMm5ydDRxZGF4cWpoTTBQcU9IUkpmai9m?=
 =?utf-8?B?UU1pM1d6V2NhUWtFclk3TG1pa1p6R3l6VVhJVngveW1nNWl2bnZFR3FRTWtW?=
 =?utf-8?B?MGo5SFFUbXlxY283YktUMlZDbUo4OGNSM2lIdThYb1Q3NWVGbStoaFZNRGlT?=
 =?utf-8?B?RXN4SVVpN0NXYUx3cTEzc282SHRTYndsTytWSmM2bEQxUk0xM25zbG8zQUJJ?=
 =?utf-8?B?bnh2NlhtZGxXdy9FMkkyem82Z1RMK0MyQWFMdEc4VVlLaTkxZDY0UzFENVFj?=
 =?utf-8?B?R0xtTFI4M2QxbUJ3NHhDYVB3b281SmtBTUN2bHNnNkdnbVE5YmRZQ2tXTUdI?=
 =?utf-8?B?aHZUZEZsYnJ4THF5dUh6OXcrbnZmR0J3OGR1MmZpSnMyZUtOUXZOdStWc1VL?=
 =?utf-8?B?Zlh0cWZRdGpUWUI5SC9WMG15ZHBFREprWUNQL0twUzhYUms2TjFwamhOOFRr?=
 =?utf-8?B?Z05pTzZvYnNxWUtFeUFVSWd4UzlxY016eXRQZ2dqeEYvakRDNVFrcEtSYlg3?=
 =?utf-8?B?UmpUL0dhZnd4c1MyWmtpMkNsbnBkUWJjT2VlQ2I1ZHhZbnlDSUYzbFdwUHJR?=
 =?utf-8?B?dmNJLy9lZ2ZPVDlEbS90ZVZnQzc1RVJkTW1ndW5ubWVGR1RtZ0hmTWlINVIy?=
 =?utf-8?B?QlQ0bXVkam53NGlINkZLYnJadVJiOG5sdGVJUmpNY3YxN2s2eDQ3QlloTWpp?=
 =?utf-8?B?dFVpdWlNZlpVVDgza2FzMGdVYnQyU3BtTFBlcFY3eXVtbHBXTUVvZFczQmFS?=
 =?utf-8?B?ZDArTlZUbFFuNzNJaGIzNlhDUjljOXJGT1BhS2ovNC9jcytVcW5DODlpc3Ux?=
 =?utf-8?B?cVlMalR3NG1jMzdzNEJ6YTBmbUdiUE1zRW9CbnBpL29tQzB1NzZyMFNiUHk1?=
 =?utf-8?B?SU1ZNkExSGxnSFVzMnd4QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MytyZnRWQkR1R1V1YTVXU1RMQVQ1TmlaYVM4eGtvYzNGaHBZaWhOcnNrUUtV?=
 =?utf-8?B?UzZXTmszY2dBcEVaZ3hNZXlNeW5QTERuRitncWljVU04aXNUMVdOc1BJbWU2?=
 =?utf-8?B?N0dWeVdiamFOaVFsMUluM3QyOGllU1FqVkhIMVVQTGtKV05VZlhpNW13R1lk?=
 =?utf-8?B?Q3AvditBcVJVcnRlZTVBdzEwS0xkN2twajlyYkZXRmNuS1JoK093ZmtZbWRi?=
 =?utf-8?B?eWY3S256ZU9lb0pZdFlGYmptdERqOGpGbHpmZjBvUmVHR2RBbDV0dFNhVENr?=
 =?utf-8?B?VDJXUWRiU3BsMk9jVGVhNEU3WktGSWh5cWdod0U0SVpBcUhSMjZDVk9ZMUZq?=
 =?utf-8?B?NVlRSjVRYTB0bEVWelRMOTFxeEo3RjA4V1FRV3lXWHRRSUVOdVNQYXBRL3E0?=
 =?utf-8?B?Ky9yRFRvL29hNXJGQkduak9uL3pQY3lPazZZSW9mM2w3MHVFaTFxUlBWcUlR?=
 =?utf-8?B?QW53Sk8xOTg3V3FMSmVGUCtUd3VoS1FaZnhyU1J5S2k0WGEwSFZ3azVJd24z?=
 =?utf-8?B?bGFWdGVYUEluYUFMakNSNk9PeTJxZmppTmZJd1FSdHBQZ21XZkNISHRkZUFT?=
 =?utf-8?B?MzFGbTYvUDFONGRIdlhBZ2JydDZxMjN3eHBqUm04TVZFbC9CODFpeVZ2YjN2?=
 =?utf-8?B?ODdIZFpUaVp3NEVOVXlvU1ZLZ0w0dkx6MkpCV0VTSmtnUFNRM2piN0M1TlVM?=
 =?utf-8?B?a3luV3E3TllGL1ZaWWtEMUpiNFRJVEpWRHp2bjJsRGRaTnlxa1NCNm4vaXNz?=
 =?utf-8?B?R096M1M2SVUrRy9ZWk04ZWUrTXB5ZVY2b21wakZRRjNQU1NNUTZsZ1dhOXBX?=
 =?utf-8?B?eEZrMWx2eGw1cXVTdnZuOWVycGJVVjVta1ZBVVY1VDBra1BpMCt2TFNIL0w5?=
 =?utf-8?B?eGh2QTVpMElZeElDNUkzNTlma2M4TnM4SjUrN0FHYWo5VitUeDc5YSswaWhE?=
 =?utf-8?B?ajgwM1NyS3c1QlRLTzc0aEtMSG0vRi92a1NwZ2lhc3UyaCtHbE1kTlc3bStL?=
 =?utf-8?B?d1NWeG83eVVEcFo1OGM5TDVRdG0xMWlDbnlMdVRFcElOcGltRzlubFREMjVR?=
 =?utf-8?B?L1pETE5QRzhWV2JVNU5XS0VMT3FsMWpkOWRpdDJlTS8zdWdXc2RnTWJRMlF6?=
 =?utf-8?B?bTVhQVFPamxwbk1OVksxaXJkTG9DazBaNzZ3SmxVaXZZajV2OU52WjNYZ1FH?=
 =?utf-8?B?VWZTUnlmK0c5RFJlTkZHenQvTGo4UldlOWZEanFzSExIRGFsODJvSGRtVmIz?=
 =?utf-8?B?REx2Ukg0MzNEYXVCTHhTWVFwU2xTTlZZWW1yU01EcDE5OEdnenY5TXFKMnZX?=
 =?utf-8?B?NkJ5c3hUaXVYTy94eC94RmpBUFd4bHAxZk5EYWVnTlFoUk5jcXVoK2hndEw3?=
 =?utf-8?B?azFXczFtUFlWS0FXN2sySS9pcVo1Wk11QSttOXc0bVdaVWMreXhnQW4zenpV?=
 =?utf-8?B?K21RdTJMM2xZaEdZZjhydFBFODVoSzQrNk9XcHZEaGVxK2RxWUhpWnJoaHFi?=
 =?utf-8?B?MGQ2SnVRUzVrQytzcnF0dkJyWGZEbDU0aEMxZm9LbUtNMUp4ak4vSXdpTnNO?=
 =?utf-8?B?VkpWSlNNK0QrQmF2QnR6UzNZNURBdnZJMGVrek9GSDUvU3l6SHYzRlZXMFlC?=
 =?utf-8?B?dzJOUVVOVjZHQ085dmp1MFRLN2xMK1IvMDIyMGxVbWxCZ1ZFS3MzeHN1S0Vi?=
 =?utf-8?B?MGMyZS9GeGVsMzlySGk2N3lqSGZib3prbThGWUk0eWUwNGRoaVhGMHBpMEZs?=
 =?utf-8?B?S2VyeEZlRktBdXErQXh2OHcySGhzQUZJRUkxUlBlMUlOc0JUWTc5MmN1dmta?=
 =?utf-8?B?dzJvcDdSTzdKNnFkdXVuSC9heEI1REF6RVFYN3JtR1ZJYmlJSDFhUENPOUxu?=
 =?utf-8?B?UkphYWV6ZzBuWUsvL0d2UkhnTXB1ZEJ4U2FTQWxnU0IzTnd4QUJwKzZSSDdq?=
 =?utf-8?B?OWdOSHhFUDQ4TDAyNnBTNmYxZXV5dXJ3eTlIM05lSjNCb1Z4bnN4eURSVlE0?=
 =?utf-8?B?NW5Nc2hONmFlWlpKa01Pc3cvN0tQdGNqMTdPbGY0Rnk4cVowWk95UGpOL3hh?=
 =?utf-8?B?THVJZGFEQTlCN2szMHlLQUcyMXc2amMvR213aDB6ODlhMlFURlNFOENrTnVG?=
 =?utf-8?B?V2NCK0ZoMFZLN3FPTlUvNGVCTEpTS3UwS1VkMUZJckMyK3pmODA5NVlmOEdl?=
 =?utf-8?B?aGZyQm45REVVWnB4M3Q5SjRJZW0xd1M0czVJeE5WQzBiQ0NPc2V3SjBBOC80?=
 =?utf-8?B?ZDhodDBQYXpXeEFJQjA4eHZpVml3PT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QLf9N1Z/XhH/TZJP+41osBwWX/O94WaSlGLIcOYiphlQnF0bB9guAfOunIE8iT3yqlelupwkBP2UK6qsxfI3QViorviAZKIfILooM0kvnkuZ2EK9NBWoMe0Ux7ixmxlt89mUrIm+GywOxT5DtGpEA+KSk/VTYLnrlpYvwO/mwjl2dQB3VpZlB6u3IBJCYOnM/RQU+yWTjiToEqnzmOwQULCqNwUAl6+UNsSc9ASnzZ6W0zuN3VyOAd55QPSlf2+rqwv9GalzrpLDYEJPfe0Wc5mHclJRiPXAIXJwpsu6NfpxS4lambNY2inqGcww8HhU5YIuqy/hoDHbbtKrzlWab8esKjWCGhhQVdfYScOG9G53iqxRr4/i2b9O8NuUs1g4sfAcg+QiDY7EaD33FUBGZUYM1xUvCpSvqO25uEfxn8t89UXf9Wor0/KOLZOPoU+4xr7U8bByqsrPK8ninVyOGPzyIZM8XNGi6dxbNgxSoMtVfKUtpengN3A5wKB8QHIyfG9kEEQGzxhZKlgkSMD3Pb/MN0qQak8RTfsnerzsDUAPWZHSkOBBs5MIo+3/NF8Z6i4rfOVzWB+QeT6JHniFGQRCEqEpQYOeP6dkJfRfaJ4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e571cd3-362e-4608-49e3-08dcb1505308
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 11:02:53.0853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bL4s2T0hIu48fjbspXh5Q16iZrA42JKv4Xmg+qOnnGk5S/xfaD+moGlawq0VZiCf51RI8/k8UOAUnyRFrleOu6G5EM95+BOZPCwrAWMnyIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7195
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-31_08,2024-07-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=944
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407310081
X-Proofpoint-GUID: w2yxuOSuim49V5nSxhSLr2-y9LeBCQ4z
X-Proofpoint-ORIG-GUID: w2yxuOSuim49V5nSxhSLr2-y9LeBCQ4z

On Mon, Jul 29, 2024 at 11:10:15AM GMT, Oscar Salvador wrote:
> Hugetlb mappings will no longer be special cased but rather go through
> the generic mm_get_unmapped_area_vmflags function.
> For that to happen, let us remove the .get_unmapped_area from
> hugetlbfs_file_operations struct, and hint __get_unmapped_area
> that it should not send hugetlb mappings through thp_get_unmapped_area_vmflags
> but through mm_get_unmapped_area_vmflags.
>
> Create also a function called hugetlb_mmap_check_and_align() where a
> couple of safety checks are being done and the addr is aligned to
> the huge page size.
> Otherwise we will have to do this in every single function, which
> duplicates quite a lot of code.
>
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  fs/hugetlbfs/inode.c    | 22 ++++++++++++++--------
>  include/linux/hugetlb.h |  8 +++-----
>  mm/mmap.c               | 15 ++++++++++++++-
>  3 files changed, 31 insertions(+), 14 deletions(-)
>
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 9f6cff356796..5d47a2785a5d 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -258,15 +258,22 @@ generic_hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
>  			pgoff, flags);
>  }
>
> -#ifndef HAVE_ARCH_HUGETLB_UNMAPPED_AREA
> -static unsigned long
> -hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
> -			  unsigned long len, unsigned long pgoff,
> -			  unsigned long flags)
> +unsigned long
> +hugetlb_mmap_check_and_align(struct file *file, unsigned long addr,
> +			     unsigned long len, unsigned long flags)
>  {
> -	return generic_hugetlb_get_unmapped_area(file, addr, len, pgoff, flags);
> +	unsigned long addr0 = 0;
> +	struct hstate *h = hstate_file(file);
> +
> +	if (len & ~huge_page_mask(h))
> +		return -EINVAL;
> +	if ((flags & MAP_FIXED) && prepare_hugepage_range(file, addr, len))
> +		return -EINVAL;
> +	if (addr)
> +		addr0 = ALIGN(addr, huge_page_size(h));
> +
> +	return addr0;
>  }
> -#endif
>
>  /*
>   * Someone wants to read @bytes from a HWPOISON hugetlb @page from @offset.
> @@ -1300,7 +1307,6 @@ static const struct file_operations hugetlbfs_file_operations = {
>  	.read_iter		= hugetlbfs_read_iter,
>  	.mmap			= hugetlbfs_file_mmap,
>  	.fsync			= noop_fsync,
> -	.get_unmapped_area	= hugetlb_get_unmapped_area,

This is causing a NULL pointer deref error in the mm self-tests,
specifically hugepage-shm.

This is because in __get_unmapped_area(), you check to see if the file has
an f_ops->get_unampped_area() however ('wonderfully'...) the shm stuff
wraps it, so this will be shm_get_unmapped_area() which then accesses the
underlying hugetlb file and _unconditionally_ calls
f_op->get_unmapped_area(), which you just made NULL and... kaboom :)

You can't even add null check in to this wrapper as at this point
everything assumes that you _can_ get an unmapped area. So yeah, it's kinda
broken.

This makes me think the whole thing is super-delicate and you probably need
to rethink this approach carefully, or least _very carefully_ audit users
of this operation.

>  	.llseek			= default_llseek,
>  	.fallocate		= hugetlbfs_fallocate,
>  	.fop_flags		= FOP_HUGE_PAGES,
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 0ec14e5e0890..1413cdcfdb1a 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -549,11 +549,9 @@ static inline struct hstate *hstate_inode(struct inode *i)
>  }
>  #endif /* !CONFIG_HUGETLBFS */
>
> -#ifdef HAVE_ARCH_HUGETLB_UNMAPPED_AREA
> -unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
> -					unsigned long len, unsigned long pgoff,
> -					unsigned long flags);
> -#endif /* HAVE_ARCH_HUGETLB_UNMAPPED_AREA */

By doing this you are causing an compilation error (at least on my compiler
with an x86-64 defconfig-based build):

arch/x86/mm/hugetlbpage.c:84:1: error: no previous prototype for
‘hugetlb_get_unmapped_area’ [-Werror=missing-prototypes]
   84 | hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
      | ^~~~~~~~~~~~~~~~~~~~~~~~~

So you need to rethink how you are doing this. I am not sure why we'd leave
these arch-specific bits around unless you're calling into them somehow
elsewhere? But this error suggests you aren't.

> +unsigned long
> +hugetlb_mmap_check_and_align(struct file *file, unsigned long addr,
> +			     unsigned long len, unsigned long flags);
>
>  unsigned long
>  generic_hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 7b623811d82a..f755d8a298c5 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -849,6 +849,7 @@ __get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
>  				  unsigned long, unsigned long, unsigned long)
>  				  = NULL;
>
> +	bool is_hugetlb = false;
>  	unsigned long error = arch_mmap_check(addr, len, flags);
>  	if (error)
>  		return error;
> @@ -857,6 +858,9 @@ __get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
>  	if (len > TASK_SIZE)
>  		return -ENOMEM;
>
> +	if (file && is_file_hugepages(file))
> +		is_hugetlb = true;
> +
>  	if (file) {
>  		if (file->f_op->get_unmapped_area)
>  			get_area = file->f_op->get_unmapped_area;
> @@ -874,11 +878,20 @@ __get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
>
>  	if (get_area) {
>  		addr = get_area(file, addr, len, pgoff, flags);
> -	} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
> +	} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && !is_hugetlb) {
>  		/* Ensures that larger anonymous mappings are THP aligned. */
>  		addr = thp_get_unmapped_area_vmflags(file, addr, len,
>  						     pgoff, flags, vm_flags);
>  	} else {
> +		/*
> +		 * Consolidate hugepages checks in one place, and also align addr
> +		 * to hugepage size.
> +		 */
> +		if (is_hugetlb) {
> +			addr = hugetlb_mmap_check_and_align(file, addr, len, flags);
> +			if (IS_ERR_VALUE(addr))
> +				return addr;
> +		}
>  		addr = mm_get_unmapped_area_vmflags(current->mm, file, addr, len,
>  						    pgoff, flags, vm_flags);
>  	}
> --
> 2.45.2
>

Andrew - could we drop this from mm-unstable until Oscar can respin? As
it's causing the mm self tests to kernel panic and I'm using them a lot in
my testing of a new series thanks :>)

