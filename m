Return-Path: <linux-kernel+bounces-318699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9B796F1C5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 12:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77BB51F24F9C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5641C9EC1;
	Fri,  6 Sep 2024 10:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="LkJdJRq/"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010001.outbound.protection.outlook.com [52.101.128.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFEB1C7B99
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 10:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725619345; cv=fail; b=c3jjEw5/ygr6pNfCGvPssQw1Cr5qCMPqUN28HeHirZu52J/1xNkBUkAItDrc2bDeh9/bRh4fjbSXGrY2Z+OcWs1y8WBeGwrgM/Uc+N5sdLfqZDC27QSuicJ4oKhCY1EI/enhPGF0BUOUaB74kSrFk1StOnuLsxaFpPgeYSSjUAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725619345; c=relaxed/simple;
	bh=7WMjyzFNUWrpzIEVo4jBX1rwWidPhGfvxHnViVDyE3U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OQlQ2mAP6xkByJ8CkbKSVtQ3UMQGX8ZRWDKY7Pd7Avh59YnS+lhT365Vu9NSea44GRx5MMVKSgInyERQnCmRyHZMwT7uZ6YxAa4XpnisdeltEfSByyelyZqndcmKh/6NaGDx9aCW8I0AyPRzTjjEmV+86stWYR0wGy8ZHxJ4PIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=LkJdJRq/; arc=fail smtp.client-ip=52.101.128.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TVQmrePuA7n4/OA2AW4d2IUfDUw4RCWjNjIJM2Pa+so9UfASN+7IabqH12Ew+zlIjvDn8ltpZZLKH91BEeXL7fcDmVPxJ4RptnhLF9cJ9oKs/3kQCUFQTQ+Z/y1zM8PRZNd8uliTkMtPuVyo3+nw0m/2tGvo/79O+PT8VgCXIs+jWWkwIZorFaefYo2gO5C1U/PZih1rGyxf9kzEp5Pl0YEFxia2kezh2LJErh0qFhd2bKeCJw4z730zXgBE6/4CHQMApCxuUhbAVuT5H1LYG8nOwEmdsgZc+xjJw+mdB023qs4sJHzm0aFc/93HJVdS7yBzJK2U7+fbOgltFIKBLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LUGjxvv5EXgZ9zW5GZiciuOA8qxl0QvJCECjKsjK54o=;
 b=KmAVQneV4Vjlu8JMCRd37wnMS2LL1yAv6BveWXwByxR0VaV8o3807HXGDm25nRSkqCBEZO3uPBJrTDSfwTz5F4/BHFgvMg9KcMfLnlTdR28dj602FLN5fpkK33qj6AIyU07ud7eShUHXoGRFgVg33N+zjUvftO9s8FTlUlspy3KNTjpUQZHVo/hyTuYITY0D241wQue6QkRwKCSaVY9svBeFbNAP8+3/JR2cbD/2T+dsTagjeEg11SiBDKOSFXQLurm+Z59bpnq8hplO1dXD1V80r4slvHOVYosWLtS4X0IFzUjHkFWwGME6pt6FXyA7eMQAg6MPcVaKJ46WgTXb6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUGjxvv5EXgZ9zW5GZiciuOA8qxl0QvJCECjKsjK54o=;
 b=LkJdJRq/MMbFGXEKI/SKlbANRG6+31BvYHtbLBEel2Z988OfUvDoWlGew3HY41fub4XcCgox6GfpSK/uj+PwRptLvpDa19dNp+rkhGOxuMBGHqXNwAbaNmsncKZ181wY5Bbj1E5hdiBaWwhn/WFOaSxLXoIm/flaslra+KtI+Rg4GBH5lOVug2iPfEfkelII71IAiSBQIo6OEvN1HpuBFx5hWD2CZRNuhD6T2s18m5qnso15tkncj5ODQHi0KJ0M6XiyeyFX3oM8G7TNxqIkMqCS64zCL1MvJ3EL0ffhailYR3NXu6/xX7JvQ3/B7T06iZblxCDvzV+MsEwK7KWk4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com (2603:1096:301:89::11)
 by TYZPR06MB7192.apcprd06.prod.outlook.com (2603:1096:405:aa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Fri, 6 Sep
 2024 10:42:19 +0000
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5]) by PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5%4]) with mapi id 15.20.7939.017; Fri, 6 Sep 2024
 10:42:19 +0000
From: Wu Bo <bo.wu@vivo.com>
To: Juhyung Park <qkrwngud825@gmail.com>
Cc: Wu Bo <bo.wu@vivo.com>,
	Wu Bo <wubo.oduw@gmail.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 00/13] f2fs: introduce inline tail
Date: Fri,  6 Sep 2024 04:57:27 -0600
Message-Id: <20240906105727.3666561-1-bo.wu@vivo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAD14+f2M+C_21h2bV6=GMhNwgWzLVaCL5jv1SQxsuKoveX6P_w@mail.gmail.com>
References:
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0242.apcprd06.prod.outlook.com
 (2603:1096:4:ac::26) To PSAPR06MB4486.apcprd06.prod.outlook.com
 (2603:1096:301:89::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR06MB4486:EE_|TYZPR06MB7192:EE_
X-MS-Office365-Filtering-Correlation-Id: 98b53fb8-bde7-4b32-e936-08dcce609503
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a0FyK09LNzBES3FUUnRuZ0MvaE9vQXlFbnZzU3FkZVNvZXdPMkR0bDFKSks5?=
 =?utf-8?B?Y2RtYUU3NWVNQXQrT2VzT2N1cGtNNEM1NGRJSC92QVhWN3YwTWUxempVVkcy?=
 =?utf-8?B?ZjZlWHZQeHRmTk5MUVFaWHBqVEtKUGE3TDcweUcrdGdzZWFMNnQ4d0FmZmVk?=
 =?utf-8?B?bHBmNjlibmp0SENSbkJMenUvdWdpcGRHQlIvdEplS0I0R25NOSswU1NhU3dX?=
 =?utf-8?B?bThoUXhBR0pKK1NwS2U1S3pPckNnejA2Qlp6c3ZZSzRwaHVtVGFlZm9FTW8v?=
 =?utf-8?B?RzFKWkRUMVVxK0FnTVBoQlVvMGVESUJmSXczQURGWEpWUkszTFNIZXhESmJz?=
 =?utf-8?B?Q3FjTFBxZGxFV3ZnZlNJb0JRM2JzbEZLN1Q4WTZseDRpdU1VZEl3V3YxVXlk?=
 =?utf-8?B?NisxWU5CNGJPb0JEcFdDc1VnR1NuRnZvbnJRMnVoVWVnbnNLeXFPSnB2R2Jj?=
 =?utf-8?B?dUNzZXBrMjBMQ1dDUmo3ZzBWS05OMjFtQVhCMTVwZFJVK0ZxSmlZWHMwVHhn?=
 =?utf-8?B?Sk1wTHI0OG54eUl5Z3lUandkclUzczcvbVRJeUl4ZWJnbWYraXFkcFVFRWlS?=
 =?utf-8?B?ejROS1ZyZkVCcGQrbE5VVU9hc3B4S1lBTUpTMjBhNU84YlI4djB5eW9iWUU0?=
 =?utf-8?B?WU9qTFNQbEtsM2RoTHlZY2Y4Vll5SzRtcTV2TzJkckxOZzlKcGk4RmhEcjRO?=
 =?utf-8?B?dTkxWUVJdi9ZQndmZEczZEMvQXF5TGt1NlVjZk1zcjJRSXhHbUphWUhWeGxR?=
 =?utf-8?B?YXdnTVJxc0U5U2xLR0tGeUxXSTFYVnB6cXUybDBHd2I0cUsrLzNtYnNITGxj?=
 =?utf-8?B?MHVpdFFab2tjTHlKRWg0bkVycVVmMDZ3Lyt0aThsSDE3YXdhc3VkRTRpS3I3?=
 =?utf-8?B?YS80VWxlUmFJTzZtU3hxZnJtSFpzZnFqaThuUzc5VnFtQnpUSFRjS2hNWDRy?=
 =?utf-8?B?bGdwelBHS2pvb2NPakhNZXNVODMvL1labVNhR0d4VjA1WHlFQlRPTUZtWk5Q?=
 =?utf-8?B?TmZHY0hkaDVJNWZ4OHlPaEFKWitxVXZlcU9pNkd2RXF2a2JYeENsNHVrOHZZ?=
 =?utf-8?B?bGNxTmhmWVNRUzNlOCtZNkFQdEFpMEE3c1ZWb2xMdkZJd3k3QzhYSzVkNDNS?=
 =?utf-8?B?bjB1K1Y0cnJpU29NUjJBOWRCMDk0bWF4bmtWamlBWWV6VzliYlovQ21iRUl1?=
 =?utf-8?B?dXUzRDBPd3hPeHZ2ekN5VHJRL2tscDcrZW4wTWswc0FCMVJyRXlkQk5LYWw2?=
 =?utf-8?B?UzhKZVhFRmd4amNZN2ZTeWdIRENPTUY3V3k5QXRoQmVWNFdIQTlPSi9IY25S?=
 =?utf-8?B?NS90VXhDMEltVVVjRWRwbDM3TmpDUUlMd21qZXorTnlKTDVvbnpvRHJtRGZr?=
 =?utf-8?B?c2RHTXc5RS94dllQckFnTm1pZEJWNFkzQlBSTHVlUEp2bDh4V2JGY1JUOHhI?=
 =?utf-8?B?NTlzZFU0RVovMXBlWkpudGdQbmdHUnJCYW81RmRTVVFVSVFEVlZUcEtINmFM?=
 =?utf-8?B?TWw5cEI3dHlOZXQ5VjU3dzJmS0FTcVFPNDU4ZTQ1M2NmZTBJb1BBT2pRZHpq?=
 =?utf-8?B?YnBESmpvV1N4T2k3THprMlZMVHRCTnVBNStBcEdHSWYvYUUybVZxVytUZC9l?=
 =?utf-8?B?Z2ZUTnRLQzhwLzd2blFNYUVTblNvSEF4azlYdm9pc1ZkakdWYmRyMk1OTmxU?=
 =?utf-8?B?S3dsTmU4RExZeGpRUnlNdFdFYk1KVGdyZnJrM0k1SExkVmxwTGYrTFBPcmJZ?=
 =?utf-8?B?TW5OLzVOYmp0VkpkWXFqNjBYb0c1MGJEM2VGTHNJbnVhN3VQMkQ3NFZaTlA2?=
 =?utf-8?B?ZC9HWU5BK1hOQUsvbGpqWkVkSVA0VXkzT0pPSW1QQzRaOFNGQXhBZit5dDBW?=
 =?utf-8?B?SDRydkl1N094UDZzRVBGM2NDbGxBdUY2cTloT0kvNElOZUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4486.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1JCZjdBYlNBNFl6Z2VCMUR0MFRudU93QjFXc3dzUGtyN3ZSbmhyV2tJR0Uw?=
 =?utf-8?B?Qkw2ZEpJTEYyTnAxdGJnYzBod0Q1cFRVSVExTUZYQ2N3eXlGdnE3R0FBMEhP?=
 =?utf-8?B?SjEvWkVqODlBckxJVklxdmVJNFpId1lienEwYjUzbHNvMkd1NitycmpsNVNH?=
 =?utf-8?B?Q1RmQXRFZGRmd1hXMXpIYzBmWUJkY3hvY0p2Mno3bnhkU3F2WE1kU3l1Z2Fx?=
 =?utf-8?B?bzNpNUloN013UklFV0pDVnpna1VQdTZWMzErVEh5T3M2V3FzYWZBZ0hsSnRx?=
 =?utf-8?B?WllmVHFQYmsyb3ZKWFdWb3IxZ0pKYkllc0IzN2NLZmgyMDhjdldUdm5WVzlx?=
 =?utf-8?B?OFpFcEc0eUFUbDdUUVlqTWhUQzVNenVoL1duUHNtQlpCMHRJY1dBVS9RUFJq?=
 =?utf-8?B?SFEwNkFRYU93SXBIZklnVVowUXNWVUxVRlR3RmhhbmpFelpiZE5RYlcreWRC?=
 =?utf-8?B?QTQxSnRVUS8vbkZYeTlONngyL2R1N1g2OFRYZlpxVWxTOUY4YWh1WEFwL1ZW?=
 =?utf-8?B?Y0FHWGwzMnNxOXZia1BSTnh3SjBCSGwzcGR2RHo2aVNlb0JyTG03dVdpTFcr?=
 =?utf-8?B?YUdJYnYvbk9NeTZmNThKUkJpbnFEbzUxRXpvVDg2RnBHTG13cnpuTWI3Szdo?=
 =?utf-8?B?U0o3ZWp5L3lIL2o4Z21McFh2R3FGVWZLWGRKejJvVzlkWHNnaTNIN3F0OW5O?=
 =?utf-8?B?SGFsVTN1Tlo1MEViUytFamFFZzJJcmJqakdoYzVYSmVwTDFHSEI3ekVIcnhS?=
 =?utf-8?B?WktjSnF5bUgyRGNhTXNFKzYwdFB2ODZYQTA4aDIycTZpS0xYVHpGWGY0UERw?=
 =?utf-8?B?RnZFRXJKMFVaS2I1UGpSOGxDa2duMGtEYVpHV1dBQkM1MUxRdVJBbkxJSjZy?=
 =?utf-8?B?SmQveFQ2eitSeHBRYVVJVE5FUmpGb2VFZXhYQS9QNEFPQzZ5MG5sTllwSHkw?=
 =?utf-8?B?QllvQTBXeFRsM0FZZTNNWU9nSU9WRFJzd1Vpb2ppL3ZIMERoRUY5VFI4Z041?=
 =?utf-8?B?MWpvNDhrOElDQzQ4MWJaK2ZTbytXRVZ4TDdxemw5TFlIQ2I0WHBlV0szc3Bk?=
 =?utf-8?B?YUxBUktnRHNja0gveFZGYk54TmgxdDdtWFV0aG5wYU83ZVhJQ3g2cWNJMm5R?=
 =?utf-8?B?Z3YwUEpCY2ZQU1ovd3p3a1QvcllRU3l0b1dtdVVxRWxqZkdvTld1M0Q1OVV0?=
 =?utf-8?B?dW4vQlpkK1JLL2NsYnFZQ2RTaWRldytTaFFMdkxKS2g0QkkyQlFjRnFKREhY?=
 =?utf-8?B?NERIaE5FaEJHYVFkeU1GeUh0QktQa215aHdaVkZkUGlTd1hGaXRFSG9zUmdw?=
 =?utf-8?B?S1l3b20yMXhQWEdJeldDaDZpQ1gyaU1lZEtDTzVXRHBZeWJqV1ZlWEl5VU5w?=
 =?utf-8?B?eUxkZ01pYUJ2Q2JxYTUrbmtyaENQUkJNc2ppZWtycUllR1daS2pTQkZNeFE1?=
 =?utf-8?B?dGZmUTh2UGllMU1kbHkrT0FvOXRKbnhUcGU4UFZsTTJnakVlejdzbG1RODZQ?=
 =?utf-8?B?WWZXS1JOVDI1UzE0MHp0RC9VaUFRTjg2M3V5T0NPU3hGQzc4NG1wRDZGLzMz?=
 =?utf-8?B?SG1QSkRhZWErTjAzUnhqdFYwbHZBVXFiRkkrUUkyWjZKS3JZaTRoMEsxMlFM?=
 =?utf-8?B?V1VLckpmdU1YWEpjRDV5WC9UR054Q2x5NHZnbFJVdktTUTBMbGdsS21EMzI1?=
 =?utf-8?B?ZDlPZjN6V09wcmk1QnI4bDVRRTVGT29sdkJxQW9BTjA3RzZLRXdsMVdsWDJL?=
 =?utf-8?B?R1ZqdGF1SEVYYWl6d0txUW5yanRtZkR0Wkt1ejZWTGdzMlZkQ0g3TnQzNXJC?=
 =?utf-8?B?QXdFZDhxaEREajY4dHpNcnFYdWgrWHhKS0Z3TE5RNkZqZFlieENMdmhVYTFs?=
 =?utf-8?B?OTh3MXR2R1JXOHErK083TjhhY2xJWVVDdExuWnYwMUNPMHBQQm56OEJydXlV?=
 =?utf-8?B?YXFrNWxFUVFDa3B0dURGaFpNdmJPdnpKY1M3MVpFT3hBcXI1VFRKdkNNU0hs?=
 =?utf-8?B?K1NMcU1tMlZpRjltVjlZZGJRalNtZ2pXZ0lHQmM5ZCtCbDZXOTJDYllMUlIr?=
 =?utf-8?B?akljdDJUYnI0cWRVSnpaeXluMlUwMnZSTk5wWlhwZ0p2UjZlL2pOSnRURFlY?=
 =?utf-8?Q?foMe0o1p5lgZtwK0BHWt1FpHv?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b53fb8-bde7-4b32-e936-08dcce609503
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4486.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 10:42:19.5334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oh4MLXgGrOQjJONYt99KH3kPtMNG+T6ZJSNt3a3oFReKlddUDcFSyR4Re8RsuULmcEfaSOkZlJMHnQ9zkGyopg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7192

On Fri, Sep 06, 2024 at 06:02:42PM +0900, Juhyung Park wrote:
> Hi Wu,
> 
> Interesting patch-set.
> 
> A quick test here on my daily-driver phone's data (785558 inodes) with
> both compression and encryption disabled, copied via rsync to 2 fresh
> f2fs partitions with and without inline tail:
> Before: 170064928KiB
> After: 169249780KiB
> 
> So about 0.48% saved.
> 
Hi Juhyung,

Thanks for your test. If it's not too much trouble, please help check the f2fs
statistics:
cat /sys/kernel/debug/f2fs/status | grep Utilization

However, it’s more likely that the benefits of inline tail are indeed limited on
mobile devices. I previously evaluated the gains on my own phone, and they were
less than 1% too.

From the data on your phone, the average size is 170064928KiB/785558≈200KiB.
Storage space on phones is primarily consumed by multimedia files, so the
proportion of files smaller than 64KB is quite small.

Therefore, compared to phone storage, scenarios like storing Linux source code,
which involve many small files, are more likely to yield noticeable benefits.

However, don't be too disappointed with it, as it can still double the benefits
based on the existing gains from inline data.
Inline data:
https://lore.kernel.org/linux-f2fs-devel/1384096401-25169-1-git-send-email-huajun.li.lee@gmail.com/T/#u

Thanks,
Wu Bo

> Let me know if this is an unexpected result.
> 
> Thanks,
> 
> On Tue, Sep 3, 2024 at 5:42 PM Wu Bo via Linux-f2fs-devel
> <linux-f2fs-devel@lists.sourceforge.net> wrote:
> >
> > The inode in F2FS occupies an entire 4k block. For many small files, this means
> > they consume much more space than their actual size. Therefore, there is
> > significant potential to better utilize the inode block space.
> >
> > Currently, F2FS has two features to make use of the inode block space: inline
> > data and inline xattr.
> >
> > Inline data stores file which size is smaller then 3.5k in inode block. However,
> > for slightly larger small files, there still have much waste.
> > For example, a 5k file requires 3 blocks, totaling 12k of space, which is
> > more than twice the size of the file itself!
> >
> > Additionally, the end of a file often does not occupy an entire block. If we can
> > store the end of the file data within the inode block, we can save an entire
> > block for the file. This is particularly important for small files.
> >
> > In fact, the current inline data is a special case of inline tail, and
> > inline tail is an extension of inline data.
> >
> > To make it simple, inline tail only on small files(<64k). And for larger files,
> > inline tails don't provide any significant benefits.
> >
> > The layout of an inline tail inode block is following:
> >
> > | inode block     | 4096 |     inline tail enable    |
> > | --------------- | ---- | --------------------------|
> > | inode info      | 360  |                           |
> > | --------------- | ---- | --------------------------|
> > |                 |      | extra info         | 0~36 |
> > |                 |      | **compact_addr[16] | 64   |
> > | addr table[923] | 3692 | reserved           | 4    |
> > |                 |      | **tail data        |      |
> > |                 |      | inline_xattr       | 200  |
> > | --------------- | ---- | --------------------------|
> > | nid table[5]    | 20   |
> > | node footer     | 24   |
> >
> > F2fs-tools to support inline tail:
> > https://lore.kernel.org/linux-f2fs-devel/20240903075931.3339584-1-bo.wu@vivo.com
> >
> > I tested inline tail by copying the source code of Linux 6.9.7. The storage
> > space was reduced by approximately 8%. Additionally, due to the reduced IO, the
> > copy time also reduced by around 10%.
> >
> > This patch series has been tested with xfstests by running 'kvm-xfstests -c f2fs
> > -g quick' both with and without the patch; no regressions were observed.
> > The test result is:
> > f2fs/default: 583 tests, 6 failures, 213 skipped, 650 seconds
> >   Failures: generic/050 generic/064 generic/250 generic/252 generic/563
> >       generic/735
> >       Totals: 607 tests, 213 skipped, 30 failures, 0 errors, 579s
> >
> > Wu Bo (13):
> >   f2fs: add inline tail mount option
> >   f2fs: add inline tail disk layout definition
> >   f2fs: implement inline tail write & truncate
> >   f2fs: implement inline tail read & fiemap
> >   f2fs: set inline tail flag when create inode
> >   f2fs: fix address info has been truncated
> >   f2fs: support seek for inline tail
> >   f2fs: convert inline tail when inode expand
> >   f2fs: fix data loss during inline tail writing
> >   f2fs: avoid inlining quota files
> >   f2fs: fix inline tail data lost
> >   f2fs: convert inline tails to avoid potential issues
> >   f2fs: implement inline tail forward recovery
> >
> >  fs/f2fs/data.c     |  93 +++++++++++++++++++++++++-
> >  fs/f2fs/f2fs.h     |  46 ++++++++++++-
> >  fs/f2fs/file.c     |  85 +++++++++++++++++++++++-
> >  fs/f2fs/inline.c   | 159 +++++++++++++++++++++++++++++++++++++++------
> >  fs/f2fs/inode.c    |   6 ++
> >  fs/f2fs/namei.c    |   3 +
> >  fs/f2fs/node.c     |   6 +-
> >  fs/f2fs/recovery.c |   9 ++-
> >  fs/f2fs/super.c    |  25 +++++++
> >  fs/f2fs/verity.c   |   4 ++
> >  10 files changed, 409 insertions(+), 27 deletions(-)
> >
> > --
> > 2.35.3
> >
> >
> >
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

