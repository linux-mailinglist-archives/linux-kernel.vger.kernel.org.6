Return-Path: <linux-kernel+bounces-203527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 055E88FDC9A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 04:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D769286A16
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 02:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EFC17BA2;
	Thu,  6 Jun 2024 02:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hvfYEtXK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="H727VdW9"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B97440C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 02:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717640145; cv=fail; b=ZXdKGz4o7I2ocU0VpAVf03teVWT/9fyucbw79K+I67znL47n6Z41nWl6I6R0I68pr836tRFtcD8wJaWU80P/nK/yhnhOe7Inur5mvtf7Qfy/c+ToIywWdK/YFPQNfgJ9s9Ah8l3Z32pjSzd1LzrxRiAH7rhnGbT+ir8Kxp+tGLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717640145; c=relaxed/simple;
	bh=k6/WdLk5soflba/GXjhsu5yvLUalH8bXocN3ZZX1Chw=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p9mbaaAD64JKsM+yYi6plIAF9lddqZtMKbB0zrXtlTCQqOaZTSijKIK24wz1Uu5DwPkLW/+MG/dpkfkNxBTEvqeKCGdJcuPeKszCZkEUbBxuAtIIgnGb+hgY4Cch5ICa+88brc3pvK3JFyQJfc8Lyq94KRbw8q40bYkBa/JCv8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hvfYEtXK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=H727VdW9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 455IkCp0026607;
	Thu, 6 Jun 2024 02:15:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=XIf7L2xpQsfpW+cVs2MD4srIsfzWqcQFPlT7IxG+dbg=;
 b=hvfYEtXK1eWSUFw571q2+nfwCcWfCbHzVUCHSWzi9MzdiN99133wh5KBx09D0akrH8i0
 ANfLQpDmpZpixwLelwkjfr0eUZ+sd+gz+Fbjrd1gj3qTDVirwW//6rulnGx8JK0z+Kez
 PqcWewQoGelZ+tz/2z5ZEc/gxF07HrcgbrmKKsIuxphoV5pX0tJdoN9TdoxChWI6o3BN
 kVrLoDU1QEQJRTleOswCAxhyTUooWZE53wK2OdQ68gUnuiuGvld6BgkbWA/pVuGBHsut
 0oo6EnHoUltOiQAADe4egTaurF2jxLYopUWTDzQF697hLTHaT96L0P0v0NydcXAs/GYh yQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbqn2j84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Jun 2024 02:15:19 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45602Cil005594;
	Thu, 6 Jun 2024 02:15:18 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2049.outbound.protection.outlook.com [104.47.55.49])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrmftrwm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Jun 2024 02:15:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xfe6OThkbvgA8NbupuZHxO/ONShHConBupLYjLHKQJLaohKBgCz8MJOYF7nVQkmKxtJtjgeItlvQkrlWfOhGNrlSwC4BcMaYILIxF0/jwXdiE2jGtvJ9Rsg1HwBFFvEGJ6zTBu9hNzYwO1q4blPtheHU4YB3APc0nQI08ejyHkHdcohznBAeIEGHf6/dQwxbBAWfV5Ur+ld+62GWroTvLUam0t0EiEGtdEZ2CcjLNkNMgeEM110gBOCQbCr8izslzgGHHfcXCOOXYASnDbmsR+NE2lAQj82K66Ez4wW3To7gUzvWFE26TeQjrC7UbqnVkZUCxSzK1IYvidpU44fUbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XIf7L2xpQsfpW+cVs2MD4srIsfzWqcQFPlT7IxG+dbg=;
 b=hW2+usqd2cgQo4uaZlHvJb8T0vJlt7qrU9xEiMM2RnHJ3sbjmI51dPzOu2A4zmHG2jKCaBBFhx8V5glBlwlnq0f0nx2x0mznjE6aeuUJhLY7Jm6sxYuc98WQca8IMZw37RNi8mDblZksWs01RjL0wjkW4YfQvUcrUCTg0e29jjzZYqlal+cjH5NNFXAWd00gIkZVxnRAzAcgRCZ61F1meEHl2b9vX4Z5sv2yb3VPPNND4Q3T92787m9fzaZRoss3Ekbml6Fr5o/uV8RZThG7CFxpz+0cUqpQo3RUlHLXDdD72TfUf3gv2Y1K98+R4F+yS5zvauTqCUeoDGHOmVGKtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIf7L2xpQsfpW+cVs2MD4srIsfzWqcQFPlT7IxG+dbg=;
 b=H727VdW9+Q1JZRZ8RsVHgr67TMztHQVlZTTSweUy4SjOJFpW833Pc3g+QJKmgSO5W9Zr0KR62UVafN/Av8dhhI9pny8OIKCJlOhoCUungfSAhOuPYK8dh26fW0HZ38OZqY9uJoz4VmQEA6u25iLDNVHIKTl+NEygak5xgV+k9E8=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by MW6PR10MB7685.namprd10.prod.outlook.com (2603:10b6:303:248::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Thu, 6 Jun
 2024 02:15:16 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%7]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 02:15:15 +0000
Message-ID: <b72a6860-33b3-4d2e-8cca-0ceab7b9d22e@oracle.com>
Date: Wed, 5 Jun 2024 19:15:13 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/18] maple_tree: introduce mas_wr_store_type()
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, zhangpeng.00@bytedance.com,
        willy@infradead.org
References: <20240604174145.563900-1-sidhartha.kumar@oracle.com>
 <20240604174145.563900-5-sidhartha.kumar@oracle.com>
 <hk6t5c4fw564ne4znymgwhoo6blgbtjnk623thr6zgfd25uvjf@pkhk5uqzykww>
Content-Language: en-US
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <hk6t5c4fw564ne4znymgwhoo6blgbtjnk623thr6zgfd25uvjf@pkhk5uqzykww>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0004.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::9) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|MW6PR10MB7685:EE_
X-MS-Office365-Filtering-Correlation-Id: bc9ad946-84eb-4379-c94f-08dc85ce8127
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?R3RIcGpndnVvaHJqek1WM01HeWdDVDQyTU0zdHRoc2tSUWY5S2hzYklrbEdx?=
 =?utf-8?B?WExvd1JWMjBscWY0dm1UREZJbzJvKzlybVNRKy96ZkJOMmMrVFdNMGtsVDA4?=
 =?utf-8?B?SEprN0dTTExpYW40bDR0OVhlM25qamlXMTF4aUxwNGtQVFYyNVQ4cTFSMzNV?=
 =?utf-8?B?bHNuaUErOEdQYnJjRXVEQ2tFYlhOaWxQVUh6YkNzZ3A1aE9WNldOYStnWjh2?=
 =?utf-8?B?YlZxaEN0Mm1nSWFOYU5Hb3NKWHE0SS80NGhid1h5WlhkK2NJMU5OM3ZyQ2I5?=
 =?utf-8?B?aWI3Qjl2aXJFUlJhaXlFVFZTOTV2SzBwQmJSUHdOSEZMZE12dko3bEhXWVR1?=
 =?utf-8?B?WDhkaURNRXg4aktQTDNyci9TL08xRXhDWUQrUE5SRmYrdTNvTUV2YXVFTVhm?=
 =?utf-8?B?Tm9oL3B4MGJvSS9GSVllRlRKUThRcmdna1hpVmF1bXg2K2c1RXJNT3RqSHIr?=
 =?utf-8?B?TkV3by9WcEwyRzBObEttRUVXOU5RVVVROUJscm1yOUVKRVdwREFTY1pDajZW?=
 =?utf-8?B?TGtYaUpiRFoxRlp4MGdQc2IrSDZGTC9ocUd0aUdVZTllazE1dGN6SmNYTS9y?=
 =?utf-8?B?aG9XN3UrWXRCL01Mczh2cnZLcWZtYk5VK0x6bklRc0JFWnFVME1PYVdXdTVu?=
 =?utf-8?B?MmNrenRkOURqRGgvNm4xb0Q4cnp2SWJyZ00ySG1qT29rcGIxVVhOVVUzOStP?=
 =?utf-8?B?UUd0dWo5SXA5WC8vZkN2NzBCOE5ocUV2THRkNk04ZnJYVjhEckhoN040S2xs?=
 =?utf-8?B?d0pkVVRGSXJuK2dCVmJORnlYbDhGcFY1d2ZFcjdROU0xYWQ3WmEvT2txczBs?=
 =?utf-8?B?MktwMDV1K1ZpV1RaeHlrRXlDc0tacmpHOExUK2g1d1JYeFBCY2ZuWWE4bHFa?=
 =?utf-8?B?Y3BCR0NoOWF2dFFVZ3RDVUZkMGl1NFJTOG81K29QZWRibVhDUnk3WWxUS1Bp?=
 =?utf-8?B?SUt0UDQ0anNyUjgxSWp4ckVESGlmczVzeDlyUUxsTytqMVo2WEx2WU1DWVcy?=
 =?utf-8?B?NW9PMVZyZ2lEMWVvVU9mQ0FIekZlNnc3VE9aR1VqUDdpTVB0N2dXM0JGY0dw?=
 =?utf-8?B?Vm9hNU1ETXM4UVd5eTNvZDFURURBVGdqa0JiMzNxTHE0dmEvRkk5bWZ0ZEEv?=
 =?utf-8?B?cTVHMGNoVmJTNERWbE9qRy9WbXRmMytmenhtcXFvTEY1VHJzWUdZMGhMRDJq?=
 =?utf-8?B?SHowTGtTbkhKTmhhcFNLTEI0YVloU0tVT2N5aTRGaHdUTUtuWkpDYXJCNCta?=
 =?utf-8?B?M2J4RjZxL1VLUGJIREtncU5iclFoNFVXK0VqZ0lHY0R6YWpZL3BDTEpLQmNT?=
 =?utf-8?B?TzBqcHd2NWZtVUJwcXNRMitGaGd5UUdtVkhoaG5rcEF4dGMvZFYyZW4zNGVI?=
 =?utf-8?B?UG9JdCttSVZ3Q2k5SUNLUTRjbEpSWEdTMlp5UEV4K1FxVWVYT3MyYkZSOWdv?=
 =?utf-8?B?b3pMRndwaGNaNjdiNEdERWJVUEtUWnVWb2hKRGNYbHdDY0RQQmp6YVpxRkI4?=
 =?utf-8?B?ZkpKTnJmbGhDV0M5K2tma2FodWZvM1NBSUpyR3cyeng1Uk8xaTF4T2NraGpv?=
 =?utf-8?B?aXFYQ3hSNmJydk1CMC9mYmVYSld1TkppRTJZdTlhL2JRVHBTYWVTWERjRFZ6?=
 =?utf-8?B?NDhWZXovNWY4YUdMbG9KQnhDQko1S28wS09GT1dEb2tnY0xSWWc3M3ljSW5q?=
 =?utf-8?B?ZmVzNGxrTGtGK0E1R1Q4QUo3MXVwQzgxRjRBdHptMDM5dk5hbWNqNkRnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TlozL1VhVytuZldmMmprSlNlRkgxZEZkbmhwQ05HZHNjWklibWxYVWNwenNL?=
 =?utf-8?B?SE8rdWF2NmdqTVJUODNWdmIvalEvQVM4NWNlaUNTOUJKZXRiWVdUU3FWbDdQ?=
 =?utf-8?B?Unh1WEtwOGJqSTRUZnpyZ2cxYkxBV0J0cVBiZDNsRVpHTmRiaGNSODVhWktm?=
 =?utf-8?B?VUQ0V1Z3aGoyY2k1cmtxbkwrTlFLcklVWVAxRVJWNjhhbTU1K0c0ZjErSnpX?=
 =?utf-8?B?akpTbTBHOVZ2MlViQzZOY2xEVDMvS1RBckFJa2Jhd1NGbENwd0h5Qk9FTVpG?=
 =?utf-8?B?dzFvaUtVbEhvNTJiVlpFOCs4YUFkQVY0dGlOajU5MDFITFVIZ3pieE1yRllr?=
 =?utf-8?B?OCt2MTJkUjZiaDhzdThUM3N0dUxLV0NzTy9tcWZVcVlQZk9PUlhxYTlTaTYv?=
 =?utf-8?B?a012dEhZY3FSSDR5amlnZmlRaHRGWW1YcUJMSmIveUZlemd4M0t1UUhPK2xV?=
 =?utf-8?B?cjJDR1BSM2xzUWhxZVJCdVV0UkRXV1J1UlhkMVFCSFZtWENBaUVxTTJlTDRx?=
 =?utf-8?B?UE5RcFEwbGV4ejdJWUhUNGhrYnNTMHFrUVVVVU1oSTI5MVJDd3BkQktuazA5?=
 =?utf-8?B?WHN3eDE1UUVtUmZjWklITmNCWVJUamdncmR2bVdUQXBFRHN0c3loeHI3UEVN?=
 =?utf-8?B?VUNSV0pyOFFLOEFSR1dHd3RlRXNnemUzY1VEc05lUEx3eWErMjdnU2tYSCtw?=
 =?utf-8?B?WEo0dWNSWWtvNXliWjgwK1hxbUFEZlpRN0xwYWRhc3orSjROUzZjNEllcWxs?=
 =?utf-8?B?UlVGbjB1OVJWK0d0UUVNMklqRjdaalZIb3MrRHhmQVQrTVNoanJBcENBTnAw?=
 =?utf-8?B?N05BTTAyaXVBRmhvVEEzUG0zUC84ekYrZ3VmcG00WFVQOWlpNnlxVWNGSUEx?=
 =?utf-8?B?Q3lkWmlJbGxidkRNM1NWRHhFOUxDY0p4UWRJWHNGV0JONm1sTUZ5ZUtubU1K?=
 =?utf-8?B?eVBOT1FxNjNqT2hQeFVKUGZ3VGcrelpwUDNvV2wvQ3hQM1llUVpxVnJVVE1U?=
 =?utf-8?B?VElPZ2tLM1kvaXBUQXJhWUErV2pvdmZDd3F4UWsrMkNPeGZNdGRVRVRkV010?=
 =?utf-8?B?aTBHME9qek5Ja0pxdkdzeWlUTUc5bytvL2FudlZSZ3psU1RQRWlWaThMcWRW?=
 =?utf-8?B?anc4OGtyT3hGSmljakpRNTQ5T3lrcmI4d0hRdTAzN2R1RUdVS1BCKzNMMFBH?=
 =?utf-8?B?R3F1bG9SMjlhd3Z2TStNSWswSXlNN3BUYnUyYklRTXBwTXVMNzBLQlhQNU9Z?=
 =?utf-8?B?Y3V1S2ZyaXJuQzZiNlBpZ0xNME1COGZZNlBJQTNWaFpEYk9xRkc5OHZYOUMv?=
 =?utf-8?B?dnNKQ2Y1RENEMnpJQWVoN1NNUThUUUFLMUtXbnBMTVBOQXN2TGkvYUwwR1R5?=
 =?utf-8?B?b3lMSEh4TFM5Z2w1WGxvZDdlUnF0b3VteVkzUldTck0yS1BvUzJZbzRuNkVU?=
 =?utf-8?B?SkV5ZWRVb0FhVXVRNFBRUFJ5WjRJUy9sMy9tTUJ6WmR6RTJLYVJJclBhWWxx?=
 =?utf-8?B?N2JQNWxYQmF1bFBWK2N6amo3UTdMWklHaGJmTlU3OElscWtzekV3OHRoZWor?=
 =?utf-8?B?YlVOTnp0Y2QxZ0JWVWtOR3ArcS9VWCtOR1ZuUzJBcmc4MGF2WEVpOURDL3oz?=
 =?utf-8?B?MVZzL3hhSG03NVI2eHJNQ2hPRjN5UGN5aVJOcGZJSFFXLzhZeHRZSG8xZW1q?=
 =?utf-8?B?T2p4RDJEZGtjYndpWXpvd0wvL2MrUllMWWl4ajg2NU9QOUYyc1RaUGNZanR5?=
 =?utf-8?B?OHB2akhHYk1SOHcyU2lmdStCS0lMUmZCTk1FK2pnQWF4V2dmbEsrZkFsb1VE?=
 =?utf-8?B?TTMrTFYxdzVzdVBxdWVjVmpoOWk1V0VBcStxbHpTUy9GdE0xdGdaUFRTSmlt?=
 =?utf-8?B?WnF6MlhBMTgxWWJzeHFkRU1ZaHQ0WVQ2R3VoaEJwVGNRVGdibWV3bFIzaTd6?=
 =?utf-8?B?NTFKTU5XeThpOUFQV3hCSTRxUlYrbWF6THhqMXJiTDUrRGhoTzFvNzlpd3NQ?=
 =?utf-8?B?RnFnbkR2VFQvOXlXTnQ3bU41RUY1VE5TZjZRa1pFcDZKcmNrWlVQbWR4UE1x?=
 =?utf-8?B?aEtGWWUrbHVXNldKUnBWNFAra0Y4SkhCMHFJcitoQzJIQjVRcE5jTmNFM256?=
 =?utf-8?B?RkIrK0RQOEdPVmpXRXRvdXZBODVGcS9vSUM0S1JEeHB4TldqbUdLWjI5VnNz?=
 =?utf-8?Q?vBcZ7FOyZ2KjqihIODdyS/k=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	J8bo5hBlvJ0sInjOL9piGY6PyTLvfxi4lmtR5neYBFGnw0+7Fj54s658ZC/9X1iGzFABtGF0Nb84EmecgZYu+N4dDM9WxThIOwAMQl2/i9IzMIypRgcNQIWx7dyCNuCtjTYRwlq/xsgitAJjefJc2ba5FNqkYHcdqXL8q/RW/QdxVe9wHL26GPbu612oy+q+ZgihcnydUcn+0InTYozkuA5vhYJ4jvFHZkUpIJGq1KA/8tGeMabWHVnDvdvmvc+gzbRiimlqjQf4EZDw++31NSmBOW2tpwmst8Kd2soKXuVwa8xDTAs3jFa0KBAY/FSrelqoXWUdeeCNj8TowkCxF2Lkp6VwlwyN3tzK8e89Xm58icsusyoUFVDondKAPMGH8lC+mVXjEyFKjMNqS/XmF1I3MVMTpKINlB14RwUMGc1pN6hPy15LuEOqsCFSXq5F5ldmXfIDL1nVkxi6HmsUOg+hLiwmZTs0U53VEPODNcjmxoGyR5kqOAgSGgpzt3wt/Y4owR2z0P93HSBa0UNARiHOJes72PmNYZ1qdvxB24UYv57B7NMk2WrEe5E3YLXDXw/JF4H1PLjUSqt8i+9vG2WxHv0ejQdc6YIdMZqoLN0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc9ad946-84eb-4379-c94f-08dc85ce8127
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 02:15:15.7987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NEAdG7NmblknJsqAqDY5QQBEigKNm40QCx8Q/G7nyJb1h4H4or0mnr7Ertbt1lsCn7L17s/Qs9/iY1Q+mA6Q/Gnty9x2D9Jtq/wDO2PAecE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7685
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-05_08,2024-06-05_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406060016
X-Proofpoint-ORIG-GUID: PNeyW8QPndA-gIqL1rOWMgkype5HifLi
X-Proofpoint-GUID: PNeyW8QPndA-gIqL1rOWMgkype5HifLi

On 6/4/24 12:07 PM, Liam R. Howlett wrote:
> * Sidhartha Kumar <sidhartha.kumar@oracle.com> [240604 13:42]:
>> Introduce mas_wr_store_type() which will set the correct store type
>> based on a walk of the tree.
>>
>> mas_prealloc_calc() is also introduced to abstract the calculation used
>> to determine the number of nodes needed for a store operation.
>>
>> Also, add a test case to validate the ordering for store type checks is
>> correct. This test models a vma expanding and then shrinking which is part
>> of the boot process.
>>
>> mas_wr_preallocate() is introduced as a wrapper function to set the store
>> type and preallcoate enough nodes.
>>
>> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
>> ---

....................

>> diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
>> index f1caf4bcf937..c57979de1576 100644
>> --- a/tools/testing/radix-tree/maple.c
>> +++ b/tools/testing/radix-tree/maple.c
>> @@ -36223,6 +36223,37 @@ static noinline void __init check_mtree_dup(struct maple_tree *mt)
>>   
>>   extern void test_kmem_cache_bulk(void);
>>   
>> +
>> + /* test to simulate expanding a vma from [0x7fffffffe000, 0x7ffffffff000)
>> +  * to [0x7ffde4ca1000, 0x7ffffffff000) and then shrinking the vma to
>> +  * [0x7ffde4ca1000, 0x7ffde4ca2000)
>> +  */
>> +static inline int check_vma_modification(struct maple_tree *mt)
>> +{
>> +	MA_STATE(mas, mt, 0, 0);
> 
> 
> Don't we need locking in here?

Ya, I think I'm also missing a mas_destroy() at the end of this function. I'll 
add mt_lock()/mt_unlock() as well as mas_destroy().

Thanks,
Sid
> 
>> +
>> +	/* vma with old start and old end */
>> +	__mas_set_range(&mas, 0x7fffffffe000, 0x7ffffffff000 - 1);
>> +	mas_preallocate(&mas, xa_mk_value(1), GFP_KERNEL);
>> +	mas_store_prealloc(&mas, xa_mk_value(1));
>> +
>> +	/* next write occurs partly in previous range [0, 0x7fffffffe000)*/
>> +	mas_prev_range(&mas, 0);
>> +	/* expand vma to {0x7ffde4ca1000, 0x7ffffffff000) */
>> +	__mas_set_range(&mas, 0x7ffde4ca1000, 0x7ffffffff000 - 1);
>> +	mas_preallocate(&mas, xa_mk_value(1), GFP_KERNEL);
>> +	mas_store_prealloc(&mas, xa_mk_value(1));
>> +
>> +	/* shrink vma to [0x7ffde4ca1000, 7ffde4ca2000) */
>> +	__mas_set_range(&mas, 0x7ffde4ca2000, 0x7ffffffff000 - 1);
>> +	mas_preallocate(&mas, NULL, GFP_KERNEL);
>> +	mas_store_prealloc(&mas, NULL);
>> +	mt_dump(mt, mt_dump_hex);
>> +
>> +	return 0;
>> +}
>> +
>> +
>>   void farmer_tests(void)
>>   {
>>   	struct maple_node *node;
>> @@ -36230,6 +36261,10 @@ void farmer_tests(void)
>>   
>>   	mt_dump(&tree, mt_dump_dec);
>>   
>> +	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE | MT_FLAGS_LOCK_EXTERN | MT_FLAGS_USE_RCU);
>> +	check_vma_modification(&tree);
>> +	mtree_destroy(&tree);
>> +
>>   	tree.ma_root = xa_mk_value(0);
>>   	mt_dump(&tree, mt_dump_dec);
>>   
>> -- 
>> 2.45.1
>>


