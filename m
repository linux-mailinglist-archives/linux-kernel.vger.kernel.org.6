Return-Path: <linux-kernel+bounces-276425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8767949373
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E208287A9B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855EB1D47C8;
	Tue,  6 Aug 2024 14:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OFbAwmpt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qdba/zRe"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8671D47A2
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 14:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722955341; cv=fail; b=dayjedKoPjWeptA6URHmwr5Y+T8fClpmbGkVkyn9SkxK++qdYMVBOpgsoiqMdaqdaZ4eA/f2WO859VfmLYQmAI7EdHjJ+xfN/mxCocvIQIxp12+I5laAu+8Dg1uI7KX5fPeCY0esMAPrcDkuf8l/huJ+3SK38ZBogn4BZseWqMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722955341; c=relaxed/simple;
	bh=l2mq4QGDH4fv6s7Yir+L1rA2ka+mebnQ2VjoFXyyufc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lqw9duVjlebzVy0KK2N6UqRsVTAUyQpTDA9OVf+aezhFfxSVnWypwbnuaRXqCuzTGaPXc1hkUaZF7xJjN8y5DnmACfUGq0lpbz8lIbENq1zU824fwbRxWfXUl58cyROYrcsQX5OsExV3S83EPKBvhlyaFdjWqKnLOHK+WAbBQOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OFbAwmpt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qdba/zRe; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 476EWD9v031891;
	Tue, 6 Aug 2024 14:42:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=yX1CCqm2xtaIvNcpaF7Ot0ZfgRvhs2P49wLFBaUpSP4=; b=
	OFbAwmptIKO4SgWlVtMzOrmuWBlUKWvBIxpM11o1QFYyQcipCRXhNK4gClyNZxdI
	JUEOL1uQlxm+5CYLhBoQnCDpaOXekaLq3fb9qmtI65OZlrZSXjjz4sk3955dI+mp
	mVmJQAaoambutXCz1NCr0+3ymCAlo3jm4TzsknHupPbgYgpK8WorCfc5oxggiFP/
	DVr6bK1ChvP+9k2YPyKtPgA+FpyA+VHB6FpvpcP+WZQvwzl21+alDyAkqUFOcl69
	yIKDzTWrWfvh173tKiOgLiZtBXIIxZDWGhMaI4hKnNe9wz+hDBIOL3vxnYdbrOSm
	F4oDuacphXt7WbEs0gHkSg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sce95drs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Aug 2024 14:42:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 476DQxT0035059;
	Tue, 6 Aug 2024 14:42:07 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40sb08y9td-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Aug 2024 14:42:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=St94gGB238hvZixQYuLzFs59n4wcXplbaTJictXXmFfG4mlmb6VLN3/7uOaNP2KMKlLN3kjhLNl5MUewZyvCqUiO6lAlGs/IN1Jikj7WLLrJig1AqM42R9JIbjdQ9diI9BhezAteO4Rq/lV2MOPBPCg7zqwQUtvOX7Rx8iv6vt7oCcMNOdHbrFB9j9aYIFlVQ7qx0XqDFHvnc3CBsoQgJjA0urWHnn5pb6fY3AB/Mezohgt+sgq0Rs57l6o4mG44E6+lsykhZE0fqmZ4VvEmdymqdATe7xih7zERCnJef0Zcvcj3rUZoDjVMOGd4CmK2EUEcJW+gj8T+pyBekntvsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yX1CCqm2xtaIvNcpaF7Ot0ZfgRvhs2P49wLFBaUpSP4=;
 b=UeRxDRVGFDRMGnFqhdpB6ZJUVr235NHfNYL25w1VCDYexkQhiBc8vTdL1fHVztlE1k5ZzTNdWM5OwKwnM/HHeOu6gbnCXE9jZkSrVdVS9Sr0cQX3s94lp0kE36RhiM7s+w9wUSDWuWrXAMJ7W3+fglseMjCOPKrJyo10mhSWL0tzxkzcef8cbx8OtrX4+92+Tak2Aehwn5XBPvhGPKq3MQ7Wbn89bRLOUyR1ELlpjnxIdFbExUOU+V83LxIBuRfnjmzUcEHPnvdz9tf8gvVpNrAIeUzbNsRNQIyPyBsr+J5F3UO7/Ucl+NGEQxxNahkR77OQx757NCtcl5f2Am0GHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yX1CCqm2xtaIvNcpaF7Ot0ZfgRvhs2P49wLFBaUpSP4=;
 b=qdba/zRegwZBFgggRE3c+tutxx4SWjFVaEpdATSL4pWO+UbGQalEkafA3Ulx7oXhvpJxY/J57FhkNPUfC3dDP42XF18nedy7G0j8uT/qT17kfkOBiJXgJeIH/HeKw7GGHbHEf9OZb6y14kAb8Y0HmzqwJechWeaDuqvFbKQlCgs=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CH3PR10MB7702.namprd10.prod.outlook.com (2603:10b6:610:1a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Tue, 6 Aug
 2024 14:42:04 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 14:42:04 +0000
Date: Tue, 6 Aug 2024 15:42:00 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 10/10] mm: rework vm_ops->close() handling on VMA merge
Message-ID: <cd24a5c6-e680-4069-b7a1-6579e0968d3a@lucifer.local>
References: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
 <0afd85543d46fd743c0c71b6f6520f9580174b4f.1722849860.git.lorenzo.stoakes@oracle.com>
 <20240806155555.1125554c@mordecai.tesarici.cz>
 <599a5806-5209-4454-8d4c-60e458905f2c@lucifer.local>
 <20240806162149.5d1de9e1@mordecai.tesarici.cz>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240806162149.5d1de9e1@mordecai.tesarici.cz>
X-ClientProxiedBy: LO4P123CA0433.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::6) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CH3PR10MB7702:EE_
X-MS-Office365-Filtering-Correlation-Id: 79733f29-c94b-4220-7963-08dcb625f079
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TkNlZldXbGlqcWJrTW1LWkl2OG02eGx0b0xJWEdQYWlWRDNPcXByRjNROXZN?=
 =?utf-8?B?TkJINDBLRFBEWWFWd1p6alM1SG5jWmdVRGpDV01CYjYxU1VZNGUzN0Y0TCt5?=
 =?utf-8?B?OENjcVhuK0ZoL1VqQTNZTG5UY3JlLzBxUzB6R3Q0OGxkRDlNZmJnb0dRWHEz?=
 =?utf-8?B?SzBaT05UZFh6bllFb2w0Vk9lNWVhaEVwVWo3T05ZWnJJUVBaS0ovOUhMQjlE?=
 =?utf-8?B?TkQzeHpKQ0EydzM0NFlQUFFOSitZTHQ4Z0hFMDR6QTF0TXJYN1hGQnQ3Tmw3?=
 =?utf-8?B?THg4MGxmVThlTVVNUEhuWm5pY3pyQUF4bFdlVm1sczQyZXcxTVRPUmwzZkNo?=
 =?utf-8?B?bSswelU4b21EVFFQNjkyRE5TZXpVUzBmSDJ5KzkzS3BSQk94RThpYzZIMTBr?=
 =?utf-8?B?UytkNXI1WDh5NlFpaGlQMlo4NTlWWDRMZW5lMVJKVjFJRjAvTFhhd2F6L1BB?=
 =?utf-8?B?TUFDV0FpVkNOU045bmdUVkNEUE11M3Z6SnB5MDN3WitjRWg4TFJMSXpueTRx?=
 =?utf-8?B?VXZBM2c5b2ZLMVA4SFkvbFBLaXYyazNPQzU5cmQzdXJRZkt4M3drN3BxMkJ5?=
 =?utf-8?B?THA2RC9BbCtCNWJDU0tEZitSdVhKbURSek0zbHRZT1BoeDNYZlM1ZnVTampS?=
 =?utf-8?B?TmVhU1IxelF2M0s4MnVhZEpkWUxBWEZPQjUrR2p3SHVZTnlqd1RxdUFWbnk3?=
 =?utf-8?B?RGtIS3owb0QzZ3RqWG5NdXlTRHZIbG9xOVF3YTF6anY2RkJINkl4c3lBa2lx?=
 =?utf-8?B?WkoyNDZtaklRdkxDOGlBOVBWRU9TbFMzbnhTVGVoTWoxZWI2eHZxSThuU0l4?=
 =?utf-8?B?V2JSWEZhcnM5RFJobllqNHBZM20wODc5aG9PK1ZRNmVZTXl6ZjRnRkJMcmt3?=
 =?utf-8?B?cWJZUWVDdWZYRWt0bDl5cWRjejlPNUFkclBKRklFaXRHY09RNzRpKzNFcHpI?=
 =?utf-8?B?dFY3VHV5NkFTYmoxWnBNREhLUUtzTElXZm4vQ0Vxek5NWk1VT0pEZlgyRm1V?=
 =?utf-8?B?NFN3MGJMQWlSK1hWZTdFSU9JN3AwSjI2eENSMm1NeGtCK3BpTlFpK01Jc2NP?=
 =?utf-8?B?d3ZIUkpRZjZXRmZVMmRhT2p2akFvOERPYlF2T2p5K3hxVUF4MHEzb1BaeTB1?=
 =?utf-8?B?TnpZTFFmNG9jTmFjN3hDM3ByNk8zVTBRWUJXSWMrdWZCY0paOHNrMFhDVDVM?=
 =?utf-8?B?ZXlGWGRwSndtZHJmL3BiODVqejVpYThrb01wMXg2U0xRV0JYNExFMUIvMm8y?=
 =?utf-8?B?WWk1ck5BbmNIT1RGSmJsNzYxVlBoRDBzOUhNT2JwQkNsK3BzNUV6ZWtjQ3lq?=
 =?utf-8?B?RkkxRkcyaW1QT2ZoVzZZdjY4MjErTTRkM0xldkMyZXRyK2cvRTJNRHFWYnZl?=
 =?utf-8?B?dk9FVFNVV05FRzV0OWlXclRFcUZyZzVKV25iTmZ0Z1pUWjgycHNLczI5cERk?=
 =?utf-8?B?d01SR3JCWUJtU2g0dGxWTXN6UFZlMHFVQnBUMjFkaTZ3NTVNR3p5Z2lsSG4y?=
 =?utf-8?B?aUFZS3ROV3NwV2tkMWZwQ2JBeUVVWE81U253dWV4dGdLaGVWdEtPeXZobE93?=
 =?utf-8?B?dUczcjdvM1EyaEtVOXR1MjNIaTI1dFRGWFBPZEMwRThYUENHTjErbWR3NjFp?=
 =?utf-8?B?d0FtREtvR1NzalNqYXpjSHpBa09nR3Q5bEVaM0NmVXF5bXl3WEtNQmxsdmJV?=
 =?utf-8?B?V1o5TjdwWGJpcGFUK3pCUjdSY0l1c0gxcitHUTVqbGdhcjY5WXpybFRIZ1ND?=
 =?utf-8?B?VTkwaEJ6bWpMV2pJWHUvTUJ2QzRGMXE4RDVMTDd4dm9UcHZEMmozQldOV3RQ?=
 =?utf-8?B?dDFMVy9jMzJyb0tyc2ppdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RElRcUhGWnF4TDc3aXYrQVZLcTg1LzJWdC9Wd0xmcmdNZi9DdzRPQndHOVVt?=
 =?utf-8?B?V0ZFZjY3TW5hR1l1N1VWZ3JHS3hYMGFFbWp5Ym1xcjkrVlhZb0dFYnh1MzFG?=
 =?utf-8?B?M2xxUkFidFVHZlZWM3ZUcTRFK1ZKcUJKZ0FSdDZuZEpaTFIxcnJrYmpkVDZ5?=
 =?utf-8?B?R3IzMFZvekE4NitFelM4TlBiRW8xVGNITDF5bEZmMGFWT3BldTBoTEIwUCt0?=
 =?utf-8?B?N29xd3hOaVdTU2tVSmRlTW5JQzZBT0dOcW9IK3E5Wms4UUJ5d2xTTzVUU1ZX?=
 =?utf-8?B?emtndHBvTkpOQlcvYkgxSkt5Y1B5dWdON0J6WHI5ekpKdkpyNm90ZjZyWkxE?=
 =?utf-8?B?bjdVak5WKzJwVmN3Tk1Ec2N1SzZuTFNwb1lnYXNmZEhTekttZ3RXNGp5VDFi?=
 =?utf-8?B?U0IydUZPcThPRmhvODFFKzRnamIvekJjZStEZWZGZmkyQXZXN09aVzZ2NklD?=
 =?utf-8?B?alc1OGNOeGM3d05LSFZNRENmTUU0Sm5nTVh4NVZ2bEFmQ0hBVDJBd21JckZI?=
 =?utf-8?B?TzVUWFZSbkhTa1QrR1UreGpVV3g3MlBCb0RrRk9YcjVJamRLd1pHUkN2dmlW?=
 =?utf-8?B?NW84b2J2aEp4RkY2SVR5QjJaMWFxZ1VaeksvM3hZQzFBTVB1L3RRZTRuNmYv?=
 =?utf-8?B?eHhkLzQzek8xNWFra1ZhV3J4QW1VN0hUSlpsL3ErNmtoMlRBUThoZnlhL0oy?=
 =?utf-8?B?Z3RwN1doTVo1NzBpa1VLaHVQVkhPMTFhYWU2cVAwODRPbSsxSmhaQjYvMHUr?=
 =?utf-8?B?NXFZWUdGQVJTZDRVNW03RDJ2eEI2RnZrZ3hEUXZ5L3VSbXMyaUdPYk1NcjdE?=
 =?utf-8?B?V3JiK3VmSlZSWVp1SjBrck1xWWtGNzhtdnpseWpYMVdKMGx5TXFZOHlBczlG?=
 =?utf-8?B?VFI3Y2tEWlVsaGMwNDRwaGUwcXJSQnBEQk9ERWtob0tBR1R6K0FCTFNSS1VP?=
 =?utf-8?B?ajEyMmV1NndTT25pSGVXTWV6VEYveFkyRVlEYThEbzlNR00yQ1BhRW1jc1N4?=
 =?utf-8?B?N0FBQ1dkKzlSNzNUcXRMUFZOU1lmT1pLdVJZRFByU0ZaRVZFWDlkdHFJUHh3?=
 =?utf-8?B?OSs1K2JFZ2R2M3Y1c245aXorUjdjdmVWNjlYRzFCYUp1Ym8raVNnTG1sYUQ3?=
 =?utf-8?B?Q3ltV0prQXlic0hkTkMxa2l2WFJxUWNHUmQrT0R5NEpXNEh4bGtDT0kvVlE3?=
 =?utf-8?B?K01RVk50MzFuaFdFRW94ZWt2K1hOUTlpWVhScFBtUThpQWNZRnYwV3RSV0Nk?=
 =?utf-8?B?QWYwN1NLVTBBQkl5cFM0UUVmUjdMNk1JdHo0YVMwL1VwVHNpODR3M2RBMldZ?=
 =?utf-8?B?YitJYzNibHp2dXZYcXJteXpIamRLK3FOVG0xY01GVDFNZi9ER2wycGVnV2xS?=
 =?utf-8?B?cnhCRithT0JJRmozNlFuZk5IZTE0RG10Q1RVeGwyc0JubHZpZ3Z2QTJMRk9v?=
 =?utf-8?B?RnNvLzYxNURSMWVTamNpdlVlMHhsZ1Jlc3E4emR0akhoL2tobXM3Qk1YbDEv?=
 =?utf-8?B?OVR3L1RRbUhFR0pITTRoZmNBbXNTWGtmZjVVSFJzaWVHeXNNS0J4Mm51eHA2?=
 =?utf-8?B?UTFzcTZER2tiZGpBTGZoMFJHSXJRYUU5VVdpUkEvVm8vbGFPck1lSkJRWUlM?=
 =?utf-8?B?ck9SMERYRHlNa0VjbGlCTGpqVGg3b0tNNmh4L216clR6N1JXT0hPYm1HaUlx?=
 =?utf-8?B?em1BcFVndyt2cm9QNVR3MmFSUHFBZElIM20zQTAzdm5FWGFLUHB1RlQ1dlFh?=
 =?utf-8?B?TVhjNlZ6azVpU2R1Y2NrK3Q3ekZaNFREQ3prU2c2NW96ZTYreWtBdC9Za3Bl?=
 =?utf-8?B?YVZKU3BhUnloQ1VDY1RpVVlaZXBEZnpEV09zdVZUR2poUHFNRExteWJORFJD?=
 =?utf-8?B?c2F4QmVKS3ZuaVdYbXRwcFJhT3E2bU9CMFNlNE9NZXVZMUJ4RlRwVUJ2MEx5?=
 =?utf-8?B?UzhFKzQzZkV0SU1qbmZWb3FicFhKOHU2c0RwNitneVlScGtTai9pY2tvcWlK?=
 =?utf-8?B?S2NrUTRjTHBETjhwQkNXVTRXZVZ2N0tZdzBaMkVmeWZkdTlZY00zMHRCQzhB?=
 =?utf-8?B?aEljL3FiZVpzQUc3dE93MWN2WDROZGI5Qk1HSHhRM1Qxd0FUTG5oYUdoTnVi?=
 =?utf-8?B?azY5cFRwK0QrTzF2SjkzbkU0eGNGNlNTYW54ZzFCMnlwQVcrZjhOU3Riekpa?=
 =?utf-8?B?bHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SIKGJfJUxsv2wM6yjykp4pe84PN7HzCt1QFigpV3xjETl3UozmhfvrORIdEZGBcW6uFeupMSN1Pggv6dzDxe1+nshLy/qd7wvPwZKUJWePp7CX1Ky1t5Yd2Fvx//nA3wIkOl/ADbPum97awLKydKii7a79xsjCKrhNP3bH0NaRUkMjjGnC5uzn7P904Gd06NhdyUkxHgq2ahn7cqO4LrWysJGzGZZ1TsXCi8rihhse3deRn5rH5hF3uYuITazqFgkj3mQFu/OuQrCNFA6ksCoKtX89kF2Zmo+3Xr03S6BypQsyy2NDlu33lKOW7KGF5OqXKaYWrh4yqle4ZSolvyijjC3e+QFza/RKAr6DKaDN8dYHpPJnLdCxtE5xZaTUHl7HkpbcEE80DoJZ1siIjbsLj00miQQA6Jx5mylPMNTyuDZl5JTU4HQ3Pu06aCesGjzx4s6LoIoW7KMfBz2dKpgalCtnrBe1PGYIAJ0njpwH/iGueyPnq1MU6foFlbFdPVjnB77Wq66Do/g/i/NlvkdMcxSV/c6nLWMIaQ+QSG6WnHAQirQDdOumcX37j9HDw4HG5sW59gltwDirICvrJeZwfMVWkpBZHVnQnRwisfU60=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79733f29-c94b-4220-7963-08dcb625f079
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 14:42:04.5180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PMCNwDG6KaqHrTo3BJXFVDQ51TJoR2JEZevHbOdl5ZHfw4vUvYWN2bn5tA5a9pf1AWxKz+hdkw1dvkRU1LewYDBZhAfwRvGnETwnx+B8aZ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7702
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_12,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxlogscore=993 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408060102
X-Proofpoint-GUID: HsEc_qm_tXvrByLM_zVSLLj64TJyHdQh
X-Proofpoint-ORIG-GUID: HsEc_qm_tXvrByLM_zVSLLj64TJyHdQh

On Tue, Aug 06, 2024 at 04:21:49PM GMT, Petr Tesařík wrote:
> On Tue, 6 Aug 2024 15:08:33 +0100
> Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> > On Tue, Aug 06, 2024 at 03:55:55PM GMT, Petr Tesařík wrote:
> > > On Mon,  5 Aug 2024 13:13:57 +0100
> > > Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
> >[...]
> > > > @@ -886,6 +894,8 @@ struct vm_area_struct *vma_merge_new_vma(struct vma_merge_struct *vmg)
> > > >  	unsigned long end = vmg->end;
> > > >  	pgoff_t pgoff = vmg->pgoff;
> > > >  	pgoff_t pglen = PHYS_PFN(end - start);
> > > > +	bool merge_next = false;
> > > > +	struct anon_vma *anon_vma = vmg->anon_vma;
> > >
> > > Calling this "anon_vma" feels a bit too generic. IIUC you want to save
> > > the original vmg->anon_vma in case the VMA turns out to be ummergeable
> > > with the next VMA after vmg->anon_vma has already been modified.
> > >
> > > What about calling it "orig_anon_vma"?
> >
> > I disagree, that'd be unnecessary noise (and this is applicable to _all_
> > the fields).
>
> I'm afraid I don't understand what you mean with _all_ fields. FWIW my
> comment concerns a local variable called "anon_vma", not a struct
> member called "anon_vma".

At the risk of sounding a little rude, it'd be courteous to take the time
to read through and understand the function before reviewing, especially
when doing a drive-by.

We use other fields like start, end, pgoff in a similar way to reset things
if expansion fails.

>
> >
> > Again we come to some trade-off between readability and inherent
> > complexity. I am not a fan of making variable names unnecessarily
> > overwrought.
>
> Then call it "a". ;-)

I don't find these kind of sarcastic comments hugely helpful.

>
> See additional comments below:
>
> >
> > In this case it's just a short-hand, as the only instance where we'd retry
> > the operation anon_vma would be NULL (from mmap_region()), so we reset that
> > to NULL, however strictly we should reset to anon_vma.
> >
> > I'll change that on the next respin just to be strict.
> >
> > >
> > > Petr T
> > >
> > > >
> > > >  	VM_WARN_ON(vmg->vma);
> > > >
> > > > @@ -916,8 +926,9 @@ struct vm_area_struct *vma_merge_new_vma(struct vma_merge_struct *vmg)
> > > >  		vmg->end = next->vm_end;
> > > >  		vmg->vma = next;
> > > >  		vmg->pgoff = next->vm_pgoff - pglen;
> > > > -
> > > >  		vmg->anon_vma = next->anon_vma;
>
> Here, vmg->anon_vma is modified. Original value is lost.

Yes, that's intentional, and a product of how anon_vma objects
function. This may be worth a comment actually.

By this point, is_mergeable_anon_vma() would be been checked between the
VMAs, so either they'd be identical, or (due to the intricacies of
anon_vma) it'd be permitted to overwrite the new VMA's anon_vma.

This is fiddly so I'll add a comment on respin.

>
> > > > +
> > > > +		merge_next = true;
> > > >  	}
> > > >
> > > >  	/* If we can merge with the previous VMA, adjust vmg accordingly. */
> > > > @@ -925,6 +936,16 @@ struct vm_area_struct *vma_merge_new_vma(struct vma_merge_struct *vmg)
> > > >  		vmg->start = prev->vm_start;
> > > >  		vmg->vma = prev;
> > > >  		vmg->pgoff = prev->vm_pgoff;
> > > > +
> > > > +		/*
> > > > +		 * If this merge would result in removal of the next VMA but we
> > > > +		 * are not permitted to do so, reduce the operation to merging
> > > > +		 * prev and vma.
> > > > +		 */
> > > > +		if (merge_next && !can_merge_remove_vma(next)) {
> > > > +			vmg->end = end;
> > > > +			vmg->anon_vma = anon_vma;
>
> But here you need to restore the original value of vmg->anon_vma.
>
> Isn't this why you introduced the local variable "anon_vma"? I believe
> it would be easier to understand its purpose if it includes the "orig_"
> prefix.

I think at some point on review when a bikeshed point is simply being
repeated a review-ee just has to say 'sorry no'.

So, sorry, no.

I don't mean to be rude, but I just don't think it's productive to go in a
loop.

>
> Just my two eurocents.
>
> Petr T

