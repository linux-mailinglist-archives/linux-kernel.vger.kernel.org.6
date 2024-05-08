Return-Path: <linux-kernel+bounces-173440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E2C8C006E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 16:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47D7B1F24C1D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 14:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C328664B;
	Wed,  8 May 2024 14:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qfglWjbP"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2068.outbound.protection.outlook.com [40.107.96.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A595A86621
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 14:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715179690; cv=fail; b=seAroQ0tWAOhF7+YneGR2PugQejRWMrGExufRT4QbrRqBUqpMjwOGEC0zh5xbNTWBTTfxpp1wf1fNJTnuq8Y5yX/fxTjWg5lozvR/+/jUU3I+lPkIw4jCsRjkYXKfNUFlpmygSy33E+YXrvJ4hGyWHOewriR/qhZ9gKj5niFMGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715179690; c=relaxed/simple;
	bh=dIfTwec9IFQIxHWKJtGz61H9tsRdDrPsk00X8fKcHxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O8Me6ao2DDHgzOxvt4bHKLs8/5uYFWI16IYRyIMh7TRe2owssNx3l5y/lLK0fxPKFgiwzTxbdHRxGGGura1IedrQFoUmFV/5o0mdMFkn50o/HHxjrxWyvWkBCJWh/nw3pRZMbgw+ugx2vgiWxiR/dSzsDYkfW2B4Zk0h4FONV+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qfglWjbP; arc=fail smtp.client-ip=40.107.96.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fnLpDs0dRMumcJWjxPiEn7XZdWC+dxTptjool/64XcYB1F0XYvDtxYHMBt1H3LuTk9L3OVlJ4ltLyGwtHRJK+U8qhV2JVuX+Ct2c/q+uaUIJQNvOw2jttqEvwbPfyBe2utrFbpSR3FnrEY+0fTYZT+WG1WbjQ5OSd7NYKu2nqCkJeH2JqDU2cz2cKiWT38JYp91C872sneD/UtE1PJLEcWW1pxHXOi0ysT4grruKnsluCC2t6uveYISQOF3HizT4x6AWcWs08L+tP2tbyqX5j+plA3DpEHeJnoQnk5m5c06p7fs5C53mxpfhT/OxwG5gmNnIE/VahtnJc/JLDQtlpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1mNymdboXNCwAXl/sckavjir8FuOSui69NNGRGSDJpw=;
 b=grPZqeN2r+BwioETUzITrjiZUXMkT9VFci8HNz2tsJtFEf3upE3IYGb9qlKNG1/icvwA8qYJDq78lEoCen6Z39ToX486eYXKOs4aVk7HiG9w0jxlp9fbTjp7lFlslF/wpjq2TPMF5wsNtpOv48jI+uVHXqUKnnvRgpOZfuTc7n00iIz1tXYnxdYVXtxNRzSxeLZPV4Hc40ZbDabezg5tLaa5vl4wxGSXsqavzbt06yV3Cov/qMhyPmWXzh8DtAxi2SomDTcOoLSshKeCK81aXDSGaHsQtccd3k1eREKFlWjONlbSMIgiNt49Ld0arXkyIhyDuHSZ9tx7OP5mcUqBLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1mNymdboXNCwAXl/sckavjir8FuOSui69NNGRGSDJpw=;
 b=qfglWjbPNgLfmOGBJD+M1lnoPZAbBjNZB4holfSSTXOlKcv3XuQLhQjaXKcyoIQ5/eShaiMmWWPEWU3/T0Kg/kIXXv9u11vRfzlhwnNsXbtc8Dye9pgCyl1t9yylOTJ/gdmWxucPAxc107Tk9SrcUtrZqrHrUuK2aax4LCCJkTp/FiH34pvuxuMuh+AjNi3Hg88cfkTAul3zz6hX9jrMhN0DBHmApaEBsO7A2xqEcyxoe5GT2r9HVForSmHtAaisBo8cdkYyixg//cixZ3Fc3/TI+u0fMVHP4wRILHFckxEeMZYb1WzodMVu/Vt/vjBExFIrZOfaleMY5ZROVbdk5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5730.namprd12.prod.outlook.com (2603:10b6:208:385::9)
 by LV8PR12MB9084.namprd12.prod.outlook.com (2603:10b6:408:18e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Wed, 8 May
 2024 14:48:04 +0000
Received: from BL1PR12MB5730.namprd12.prod.outlook.com
 ([fe80::afc:1e4b:7af6:115c]) by BL1PR12MB5730.namprd12.prod.outlook.com
 ([fe80::afc:1e4b:7af6:115c%3]) with mapi id 15.20.7544.045; Wed, 8 May 2024
 14:48:04 +0000
From: Zi Yan <ziy@nvidia.com>
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, sj@kernel.org,
 maskray@google.com, ryan.roberts@arm.com, david@redhat.com,
 21cnbao@gmail.com, mhocko@suse.com, fengwei.yin@intel.com,
 zokeefe@google.com, shy828301@gmail.com, xiehuan09@gmail.com,
 libang.li@antgroup.com, wangkefeng.wang@huawei.com, songmuchun@bytedance.com,
 peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 2/3] mm/rmap: integrate PMD-mapped folio splitting into
 pagewalk loop
Date: Wed, 08 May 2024 10:48:02 -0400
X-Mailer: MailMate (1.14r6030)
Message-ID: <10BA9EED-A2BB-44C2-B80A-26527CDFFA50@nvidia.com>
In-Reply-To: <CAK1f24mpt+ZGow4LLdXKZcwopmkZDrM_eh15SnkEgpiBXTmOwA@mail.gmail.com>
References: <20240501042700.83974-1-ioworker0@gmail.com>
 <20240501042700.83974-3-ioworker0@gmail.com>
 <0077A412-0AF1-4022-8F49-EE77AE601ECB@nvidia.com>
 <CAK1f24mRVam3w9CZkq4O0smGUTVUQfdvA48mqsU+NKxMUxdz1A@mail.gmail.com>
 <B1DA2DA4-AFEA-4541-8DFC-0D815249A064@nvidia.com>
 <CAK1f24mpt+ZGow4LLdXKZcwopmkZDrM_eh15SnkEgpiBXTmOwA@mail.gmail.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_E6AE98E6-4035-442E-84C2-60E6994529CF_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0084.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::29) To BL1PR12MB5730.namprd12.prod.outlook.com
 (2603:10b6:208:385::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5730:EE_|LV8PR12MB9084:EE_
X-MS-Office365-Filtering-Correlation-Id: 31ed9ca0-112f-4547-ecd8-08dc6f6dddea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|7416005|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWtyMy9Xd25mdWl2MXdsem1xQTA5dGJscngyeVNvRHlMdUxablFpZ1JOelcz?=
 =?utf-8?B?TVJkWXNUVkZZcVJtQlpMczVYeDVxTWlBb3FYRlBuUkUvWGgyTmMrcUdUU0xU?=
 =?utf-8?B?azRDK3JUYmJQR3B4M0NzZS9iYytwQ0ZGdVRWbjR6Q3k4WDBSaWFpSjc3Wnls?=
 =?utf-8?B?K0tnQ09NNXNJMFNhYmpuMVpGUGdDeE8zVW1XWm1wMDNyYnRmaGlZaVNLSzVp?=
 =?utf-8?B?SE56a1l6am5kQ1ZNdWxoTmNCL1JJSno5WU9kQS82YWpVaDVpOW93ZVMrcjlG?=
 =?utf-8?B?RU53NVZyaGlRcFBrQ2tLZkZmL2JiMVNkalV1SXFMdnF1STZRNzZKVUFVVzYw?=
 =?utf-8?B?em8vK3dzSUcxdlpWcWFEWitlTFpqb3VwY0ZmaEMzU0F5ZDQrSjRmaVdFMXVt?=
 =?utf-8?B?a250Nlc5VERXcXhLVGRwWUtJMWxGTXhMTDEvWDkwWjVjNXZGMlVGWjkvenJF?=
 =?utf-8?B?blBsMHRZdzVDVng3YjVwaUtTRy9NVVY0Y05xVTFnckJaRTNScXc1ci9RZk4r?=
 =?utf-8?B?Ty9HOVhkTVRFL0xiekw1VlZDT09UcDJ2MEtUTnB6aGRDVHpOdXhXYmFiZENm?=
 =?utf-8?B?UFVEZ3BEMnk2ck5wRDBJN3Zoa2ZITjhUOEUwQUlZSzZRYUIzSnQydkJrMUla?=
 =?utf-8?B?Qm5DZ05JWW5GT1pvRGc2anlsYWRGWGUyZnVRZFhHY1hJUGdEbHpRYzI5dmpQ?=
 =?utf-8?B?d0NhVHhSRjZodEozY2k0RHQ2Yno5Z2MwVGJIWFRGVEZ0cmx5TlZ3UDJZaWpE?=
 =?utf-8?B?dWk4ZG9TekY3YkNXUmQwWVo3VVFwMjh5QTBmdXFTNmhvckJZVVJMQmpQZVYy?=
 =?utf-8?B?QXFtdWQvcytqZXpUUVMwK09rVk9JU1FXbHRlNklPUEJyd2hyZ0JEYWJjcjVI?=
 =?utf-8?B?RkVXam5ITmwzR3U5cEdWbWxOMDhCc080bFpiVkszeFZ3SVdzOHZkWDRTZTgx?=
 =?utf-8?B?T3c1VDZqS05temRESTFYKzJVN2FmQTFzUE1TeTlkTTZMMVVscy9FNFMrZEF2?=
 =?utf-8?B?T1hPVml3RTE0M2RMNExUSkFpeGs3ZlAyK0RmTVQrbVo3WHRvaC9ZOTRlQjgz?=
 =?utf-8?B?RmRKY1k1cW1nOVZrQURwUmI5TDJCbmpxK3FlT2ZNdUFJRFg1Tk1UaHJuSTQw?=
 =?utf-8?B?cDNrclY4NlI1czJnY09WU1kzNUJnWHhrTGtndUxocTdVK3U4L0FETVZLRXZp?=
 =?utf-8?B?UTRxWUI5VGx6cW4vTk9hclk4S04veW9yei9ZVFczSDRDZnhaaDZjUlRRaXVX?=
 =?utf-8?B?R2pwcHViQ1Ruc1NKM0tWUXNqVk94Y1pYZHVXRzJaOEF1TzJaRWVKVnRnNHRZ?=
 =?utf-8?B?ejliU3R5OHQzZU5QVzJqV1pPS0tEblRqWWNIaXhIZFM1M3B2ZFNXQkhJbzdz?=
 =?utf-8?B?REdyOEl1OW1VN2ZuSzVyUXBKMjlFMjV6L3VSRU5iSnVhQ21BS0puSE5sSzN1?=
 =?utf-8?B?U1pvQTZFLzZVWUFnM0tIYXRuV1N4RnRTKzFhUjFBRVB5b0xBT1Z1cUlJbEl5?=
 =?utf-8?B?bGhURDZsNzlRYXBvMUplMU5ZbHAyZzN1azhrQWlpaGJycjdMM2JFeExNN1VE?=
 =?utf-8?B?bjUwR1hkWTZlMEs3bXZXcnd4ZXpNM2FjYU93eW56VjNKZzd0endMTFF0cnBq?=
 =?utf-8?B?UnRsUE44K1dBbldKTy9IQ3lwczVRZUtwRGVsZkdraEkzZ0l3Y2dRd1ZWTVBa?=
 =?utf-8?B?VVl3MlNxZmNQM0pIbjNXMlc4bFllRFJYQXpMdzI5M3ZhZy9YMTUzbEpRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5730.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MUprQlRTWG9qVlROaXNWVXVDL0gydjFYNEF2M1orNVh0RUJsVVhIbTRpczVz?=
 =?utf-8?B?MWpxZk1PT2U3RlFHZ3AwU0ZEOW0rZVIxK05WenBuWGhHbDNCeERYVkRTVmhi?=
 =?utf-8?B?Z21TUnd1S3A3cDVBd2w4dG5NV3lIQkZ6YkE0M0s0ZGhtMlJxUWk4L1oyT0U5?=
 =?utf-8?B?ZVVVa0dEMWliOFYvaUxMQ2ZuTDZHM3lIVXlwdTgrdUFFcW92RXR1VStKdzlt?=
 =?utf-8?B?ZzF2NnhEclpuR2lrUW9LTjRaTHE4N1p4TytKSkZXc3Q1MFo1VGlmK3dZY1J1?=
 =?utf-8?B?aVROSjF6NVZROXk1VDdleG9jRzIzM0NtWGlzcFZHSnpUdW40ZFZ3ejRFT2tR?=
 =?utf-8?B?cmVLaUVYQitkc21ZRHllWkNBTEFQaGdraWU3b0RkQXdSTU5WMWN1amJyVFRq?=
 =?utf-8?B?N0NnYlk0aERsVDRaZ2JDQU5xK0VUYi8zejhkYU5SNEwxRTVQQURENFBuSXAv?=
 =?utf-8?B?UDhaTVpIU05jbkFUdXdvZmk4QWx5OFBjVVVCdlRSZVM0eEh0RUhxNGYyQ2ZW?=
 =?utf-8?B?L1Y0bTY4SHcvU29nNDVXd1lpOVpTZFhlTWlOSm1jS1pFYVRYSzh3dTljbWEz?=
 =?utf-8?B?SHFqcW5pRGRQTU5WTHFsbWNGQzhMNjg2RUM3RG1uV2JJRE9PeUVvd2tacGtO?=
 =?utf-8?B?bi9Wb1gxQ3FPd2xEeU9OSlBiN3JCL3FwMEd4cUZLMG1OelpWQWppWDI3ZG0w?=
 =?utf-8?B?bzZtSm5JT1B4NG9ENTRDU3Z1K1lIdXpiak8yRGxONkdhcFhVcVdBeFh4Zjcz?=
 =?utf-8?B?NkFFejVSS0lFVitNRXMxVzh6TEM4RUVUK1YyU1N3OEt4Yzk5TG9rckkrdGtX?=
 =?utf-8?B?Mzh4TlFrREVSRGNqYzE4NXRJZXQybUtKbjgxZ3JEVXJ0dTJTVjR6dG5QZTly?=
 =?utf-8?B?aWc5NEo2SStiV09XWThMUlhUMUFKTUl0S21Gc1YrVmtFZSttYkhVSVkrTjRS?=
 =?utf-8?B?RjFmUDY5WDlUSUcwbk94Nk90ZTM0RG04MU93ZEV3bHUxRGNrVkNjOXh2elpn?=
 =?utf-8?B?Rk5Vckg1WXlSTEJxa2VZU296RGY4TUxtckw4MWx4NTR1UGNEUTllYkFlMTJz?=
 =?utf-8?B?VHVXdmdjb3J5L2hYY2hRQm5EZ1hWK2F1dWo4eXRHdzBZL011VE55bnhFWFp1?=
 =?utf-8?B?dmt1aTlxdG1Eelc0SkNCMmU2aWVZNkk3R3U0aEVsODE1b0lDdTF5OU9PUlVV?=
 =?utf-8?B?bUNZRkJmNVBmVHorRWl3RW9jN2hzOHBYd1hON0lvS3g2akYxVUlTMGJOVkl2?=
 =?utf-8?B?RzhkL2FvME9oVnhKaFJrblU5VktCa3hmMWZEekdLZXR0VURCcWRzOE9mNGlZ?=
 =?utf-8?B?L2lBeEdZVGxKb1dMZXJSdHdXWkx3aitWQTVWS3l5NVZjMnJmRjBEci9DQ0R5?=
 =?utf-8?B?TUtzZHlnalhYU0JWVE5yQzgrbW5DNGdxTDZTbzVXdmU3bk9LMzdDdUc4cVp5?=
 =?utf-8?B?ZnB0cU5waXkwa1h3bWUvcGFsMXU0VldaU1AyQnRGTzJEZzVZdDN0Y3ZQc2dN?=
 =?utf-8?B?WWJaVHZLeEVDYUVSQnoyMVhQRFVWcm5kSmFCaWdLV0VjbHUyVGd1RHo5TU9j?=
 =?utf-8?B?UHY1WWlUdmtiYUVEODZCKy9BU1JJelRHTFVsWldVSEd6cE5ydGVwOHdUNkFj?=
 =?utf-8?B?ZUtIMFdYR3NDQ20vb1hhKythRGVBaHRjV1FmUHBlN2k5SlBrS0ViRVNPOXpW?=
 =?utf-8?B?SEQrcCtwY3pwV0lhektZR1k3SWxnZk02WE1JSjdBVytjYTFWYW9wQlI0c1F4?=
 =?utf-8?B?WWxPM3BGZzVwek1tMWZMdnFvTHlMZm43c2I0K2s4YXZVWFhkWGlpakYxWEk3?=
 =?utf-8?B?M0FnM1BhZkMrRUtYdFpyaGd0Z2V2T25UQVErTlkway9MOVBPZUYreWg1dFB6?=
 =?utf-8?B?d3BRSXMwRFlvRnlvc3BwdFhRSWY4OFd0TkFxdUNQRzBYY2JXT203REFMWG5i?=
 =?utf-8?B?T21MSkI3dVNSRkplMVZNQnhjZUNlaG5XQmZ0K2hBVW9BMG10QUdpRXlKM3V2?=
 =?utf-8?B?TDVQeittZkRlWGVES1lpMXE3TENRZEplUmsyZkVReWVEZEZlVFJLSnZFTzNM?=
 =?utf-8?B?aUY4NDNZZ29wM2dPS0VKSW9uR2tkMXlOczd4M1FPeXF6QkRFRkkxM0hxVy9t?=
 =?utf-8?Q?MN89Bcmra8MFgbOpkiT10sDK9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ed9ca0-112f-4547-ecd8-08dc6f6dddea
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5730.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 14:48:04.6055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QDTWHtEBrxFwoIM2jy+/01YZ5GeXtP8VvBHCTT/tsQZ0jJhdfVTJtqYuoAF+bxre
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9084

--=_MailMate_E6AE98E6-4035-442E-84C2-60E6994529CF_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 8 May 2024, at 10:35, Lance Yang wrote:

> On Wed, May 8, 2024 at 10:07=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>>
>> On 8 May 2024, at 1:43, Lance Yang wrote:
>>
>>> On Tue, May 7, 2024 at 11:26=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote=
:
>>>>
>>>> On 1 May 2024, at 0:26, Lance Yang wrote:
>>>>
>>>>> In preparation for supporting try_to_unmap_one() to unmap PMD-mappe=
d
>>>>> folios, start the pagewalk first, then call split_huge_pmd_address(=
)
>>>>> to split the folio.
>>>>>
>>>>> Suggested-by: David Hildenbrand <david@redhat.com>
>>>>> Signed-off-by: Lance Yang <ioworker0@gmail.com>
>>>>> ---
>>>>>  include/linux/huge_mm.h | 20 ++++++++++++++++++++
>>>>>  mm/huge_memory.c        | 42 +++++++++++++++++++++----------------=
----
>>>>>  mm/rmap.c               | 24 +++++++++++++++++------
>>>>>  3 files changed, 60 insertions(+), 26 deletions(-)
>>>>>
>>>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>>>> index c8d3ec116e29..38c4b5537715 100644
>>>>> --- a/include/linux/huge_mm.h
>>>>> +++ b/include/linux/huge_mm.h
>>>>> @@ -409,6 +409,20 @@ static inline bool thp_migration_supported(voi=
d)
>>>>>       return IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION);
>>>>>  }
>>>>>
>>>>> +void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned lo=
ng address,
>>>>> +                        pmd_t *pmd, bool freeze, struct folio *fol=
io);
>>>>> +
>>>>> +static inline void align_huge_pmd_range(struct vm_area_struct *vma=
,
>>>>> +                                     unsigned long *start,
>>>>> +                                     unsigned long *end)
>>>>> +{
>>>>> +     *start =3D ALIGN(*start, HPAGE_PMD_SIZE);
>>>>> +     *end =3D ALIGN_DOWN(*end, HPAGE_PMD_SIZE);
>>>>> +
>>>>> +     VM_WARN_ON_ONCE(vma->vm_start > *start);
>>>>> +     VM_WARN_ON_ONCE(vma->vm_end < *end);
>>>>> +}
>>>>> +
>>>>>  #else /* CONFIG_TRANSPARENT_HUGEPAGE */
>>>>>
>>>>>  static inline bool folio_test_pmd_mappable(struct folio *folio)
>>>>> @@ -471,6 +485,12 @@ static inline void __split_huge_pmd(struct vm_=
area_struct *vma, pmd_t *pmd,
>>>>>               unsigned long address, bool freeze, struct folio *fol=
io) {}
>>>>>  static inline void split_huge_pmd_address(struct vm_area_struct *v=
ma,
>>>>>               unsigned long address, bool freeze, struct folio *fol=
io) {}
>>>>> +static inline void split_huge_pmd_locked(struct vm_area_struct *vm=
a,
>>>>> +                                      unsigned long address, pmd_t=
 *pmd,
>>>>> +                                      bool freeze, struct folio *f=
olio) {}
>>>>> +static inline void align_huge_pmd_range(struct vm_area_struct *vma=
,
>>>>> +                                     unsigned long *start,
>>>>> +                                     unsigned long *end) {}
>>>>>
>>>>>  #define split_huge_pud(__vma, __pmd, __address)      \
>>>>>       do { } while (0)
>>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>>> index 8261b5669397..145505a1dd05 100644
>>>>> --- a/mm/huge_memory.c
>>>>> +++ b/mm/huge_memory.c
>>>>> @@ -2584,6 +2584,27 @@ static void __split_huge_pmd_locked(struct v=
m_area_struct *vma, pmd_t *pmd,
>>>>>       pmd_populate(mm, pmd, pgtable);
>>>>>  }
>>>>>
>>>>> +void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned lo=
ng address,
>>>>> +                        pmd_t *pmd, bool freeze, struct folio *fol=
io)
>>>>> +{
>>>>> +     VM_WARN_ON_ONCE(folio && !folio_test_pmd_mappable(folio));
>>>>> +     VM_WARN_ON_ONCE(!IS_ALIGNED(address, HPAGE_PMD_SIZE));
>>>>> +     VM_WARN_ON_ONCE(folio && !folio_test_locked(folio));
>>>>> +     VM_BUG_ON(freeze && !folio);
>>>>> +
>>>>> +     /*
>>>>> +      * When the caller requests to set up a migration entry, we
>>>>> +      * require a folio to check the PMD against. Otherwise, there=

>>>>> +      * is a risk of replacing the wrong folio.
>>>>> +      */
>>>>> +     if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) ||
>>>>> +         is_pmd_migration_entry(*pmd)) {
>>>>> +             if (folio && folio !=3D pmd_folio(*pmd))
>>>>> +                     return;
>>>>> +             __split_huge_pmd_locked(vma, pmd, address, freeze);
>>>>> +     }
>>>>> +}
>>>>> +
>>>>>  void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
>>>>>               unsigned long address, bool freeze, struct folio *fol=
io)
>>>>>  {
>>>>> @@ -2595,26 +2616,7 @@ void __split_huge_pmd(struct vm_area_struct =
*vma, pmd_t *pmd,
>>>>>                               (address & HPAGE_PMD_MASK) + HPAGE_PM=
D_SIZE);
>>>>>       mmu_notifier_invalidate_range_start(&range);
>>>>>       ptl =3D pmd_lock(vma->vm_mm, pmd);
>>>>> -
>>>>> -     /*
>>>>> -      * If caller asks to setup a migration entry, we need a folio=
 to check
>>>>> -      * pmd against. Otherwise we can end up replacing wrong folio=
=2E
>>>>> -      */
>>>>> -     VM_BUG_ON(freeze && !folio);
>>>>> -     VM_WARN_ON_ONCE(folio && !folio_test_locked(folio));
>>>>> -
>>>>> -     if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) ||
>>>>> -         is_pmd_migration_entry(*pmd)) {
>>>>> -             /*
>>>>> -              * It's safe to call pmd_page when folio is set becau=
se it's
>>>>> -              * guaranteed that pmd is present.
>>>>> -              */
>>>>> -             if (folio && folio !=3D pmd_folio(*pmd))
>>>>> -                     goto out;
>>>>> -             __split_huge_pmd_locked(vma, pmd, range.start, freeze=
);
>>>>> -     }
>>>>> -
>>>>> -out:
>>>>> +     split_huge_pmd_locked(vma, range.start, pmd, freeze, folio);
>>>>>       spin_unlock(ptl);
>>>>>       mmu_notifier_invalidate_range_end(&range);
>>>>>  }
>>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>>> index 7e2575d669a9..432601154583 100644
>>>>> --- a/mm/rmap.c
>>>>> +++ b/mm/rmap.c
>>>>> @@ -1636,9 +1636,6 @@ static bool try_to_unmap_one(struct folio *fo=
lio, struct vm_area_struct *vma,
>>>>>       if (flags & TTU_SYNC)
>>>>>               pvmw.flags =3D PVMW_SYNC;
>>>>>
>>>>> -     if (flags & TTU_SPLIT_HUGE_PMD)
>>>>> -             split_huge_pmd_address(vma, address, false, folio);
>>>>> -
>>>>>       /*
>>>>>        * For THP, we have to assume the worse case ie pmd for inval=
idation.
>>>>>        * For hugetlb, it could be much worse if we need to do pud
>>>>> @@ -1650,6 +1647,8 @@ static bool try_to_unmap_one(struct folio *fo=
lio, struct vm_area_struct *vma,
>>>>>       range.end =3D vma_address_end(&pvmw);
>>>>>       mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma->vm_=
mm,
>>>>>                               address, range.end);
>>>>> +     if (flags & TTU_SPLIT_HUGE_PMD)
>>>>> +             align_huge_pmd_range(vma, &range.start, &range.end);
>>>>>       if (folio_test_hugetlb(folio)) {
>>>>>               /*
>>>>>                * If sharing is possible, start and end will be adju=
sted
>>>>> @@ -1664,9 +1663,6 @@ static bool try_to_unmap_one(struct folio *fo=
lio, struct vm_area_struct *vma,
>>>>>       mmu_notifier_invalidate_range_start(&range);
>>>>>
>>>>>       while (page_vma_mapped_walk(&pvmw)) {
>>>>> -             /* Unexpected PMD-mapped THP? */
>>>>> -             VM_BUG_ON_FOLIO(!pvmw.pte, folio);
>>>>> -
>>>>>               /*
>>>>>                * If the folio is in an mlock()d vma, we must not sw=
ap it out.
>>>>>                */
>>>>> @@ -1678,6 +1674,22 @@ static bool try_to_unmap_one(struct folio *f=
olio, struct vm_area_struct *vma,
>>>>>                       goto walk_done_err;
>>>>>               }
>>>>>
>>>>> +             if (!pvmw.pte && (flags & TTU_SPLIT_HUGE_PMD)) {
>>>>> +                     /*
>>>>> +                      * We temporarily have to drop the PTL and st=
art once
>>>>> +                      * again from that now-PTE-mapped page table.=

>>>>> +                      */
>>>>> +                     split_huge_pmd_locked(vma, range.start, pvmw.=
pmd, false,
>>>>> +                                           folio);
>>>>
>>>> Just in case you might miss here, since you will no longer align
>>>> range.start as Baolin mentioned in another email and you have a VM_W=
ARN_ONCE
>>>> in split_huge_pmd_locked(), you will need to align the input address=
 now.
>>>
>>> Thanks for bringing that up!
>>>
>>> I do miss the alignment here when I decide to no longer align range.s=
tart
>>> in another email - thanks!
>>>
>> No problem.
>>
>>> Zi, could I move the alignment here?
>>> IIUC, we will not encounter a partially mapped THP here, and range.st=
art
>>> and range.end should also not beyond the VMA limits.
>>>
>>>                      align_huge_pmd_range(vma, &range.start, &range.e=
nd);
>>>                      split_huge_pmd_locked(vma, range.start, pvmw.pmd=
, false,
>>>                                            folio);
>>
>> I think you can just do
>>
>> split_huge_pmd_locked(vma, ALIGN(range.start, HPAGE_PMD_SIZE), pvmw.pm=
d, false, folio);
>>
>> since range will later be used by mmu_notifier_invalidate_range_end() =
and changing
>> it might cause secondary TLB invalidation issues.
>
> Ok, makes sense to me - thanks!
>
> But we probably cannot use the HPAGE_PMD_SIZE here; it will cause
> broken compilation as seen in v3[1].
>
> Perhaps we still need to add a new alignment function for the huge PMD?=

>
> [1] https://lore.kernel.org/linux-mm/20240429202040.187453-1-sj@kernel.=
org/
>
> Thanks again for the review!
>
Or you can adjust the alignment inside split_huge_pmd_locked(), since it =
can
be called other than __split_huge_pmd().

Hmm, I notice that split_huge_pmd_address() has mmu_notifier ops but your=

split_huge_pmd_locked() does not include them, I wonder if that could cau=
se
issues with mmu_notifier issues. Adding mmu_notifier people to confirm.


--
Best Regards,
Yan, Zi

--=_MailMate_E6AE98E6-4035-442E-84C2-60E6994529CF_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmY7kKIPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUCSoP/i52xDCUvIJpyd43Vm2QvGZeeuINaqGDKudN
m8VKTsshaRthW/LUzgfSk3jdxhcIK/SPE7A4RplaF9AO24YCla6pHzrFZpRLwAKC
/V4boAs970i5NTwIwEXV9cCTS++zFw/Rhotxh3asQwvbUn/YL1sZZG+kBsqwg+qf
e3rhC10izz920hg5HnLMkvG4PFmTD5XfeNGSfGFwHKol4YbZnte+V6EDzlzObL+e
3kae8pfXxevmR6lnGG5Y98sEqFoZjhF11m/fDzD4CmLzTJi878k1T4eS8kTcmkFD
hSw2TDqMpenLsWGqTg+gcvYVZGrP0VkNUUmcnjJDleBgLBuDha+f1wssdYp+rCuN
+Zzrb2TNtTlMQEkIlt2KUjagc3sOfUusfb7TJ+MrLnN4mdqaWEIRTexFURo2Vepo
JoC2FjGV0m/2OCr2Sds4yWWxiBhZVGsBbGHscDzEJBrlG6z8PMg0ERfFL15tcAWO
Tec8ln3n/8lO1d029vnJpbYWgXT7IKJVKEu6bLSjsEgh7p2+un49RcwyFl4vOd/1
U4sZDKslwaaaNIwooDldINMfKHtYaW9tIQaSLgiJN7Dk5ODnB9XYmUrwaTnVKmL8
fsyJh+69dKLi8ONHrK1Kvl+1+uM0z47WsZBdVbi+UZFP2n+SxfilEsjnSwni5gmI
LRfxhdEz
=0s36
-----END PGP SIGNATURE-----

--=_MailMate_E6AE98E6-4035-442E-84C2-60E6994529CF_=--

