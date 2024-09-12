Return-Path: <linux-kernel+bounces-326196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C109764BA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 10:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27928B21198
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 08:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2D4190057;
	Thu, 12 Sep 2024 08:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="NYOzQNZj"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2080.outbound.protection.outlook.com [40.107.22.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D1D18BC27;
	Thu, 12 Sep 2024 08:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726130275; cv=fail; b=fYSOcZIX4AT30nKr2q55BR8rQzPp1OCaeiualRzSMJmaD7JP8/vbUyh2JBW2EH1fvGWQ8SfsQENhmJIvE1tafnCLDnOOLJrBJdCYH8VH+yoSJLWl+8DbZrU2yNk4RhhFbhrseOiQBKW66v9l8TFCW6Es2CMYW1tdxilCso8Xfoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726130275; c=relaxed/simple;
	bh=w8lxtiv6rGDcqtr7vWjpaS+V4MZ7S+kvIu0040jveZU=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=JR8eH3MB7fYsB9BblnJ8Mi5TKDNQhOw4HBMG04oLw6cMrqSWBqo5SxbuysbZIachynBMf6BXN7Jv7hJcqcHiOj9K9Fh8NR+ZDkP1kLnx0u8geHObiSh28O5LCmnhItBDKkT2AFIyJ6g2LTIgE5mtRUzxA8dCd3sx9GSvzaIIRBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=NYOzQNZj; arc=fail smtp.client-ip=40.107.22.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rmlFzzfzB5tINl/HskwmOOBttjYItsFxkJ7yWBnJEVEY0fQmilhygPedTQk3GVrPSi4vGSFn8/YMlexZZBrqujlCl90hh6gTAMxAjr3M0bs6pzFTwvTr8DV76EPiNw1gx/XhLFp4g4aRcwJ4reNl65KUVgVBMc3vQoXgN4/FHtx1iZ527pdnHxxtnsasqINpd1Wi6MehSjsiTjZZZJkk9PZgDnNAvi2qvGbpJoXICirfOVIAf+yJcOCCVtqePpbtknJu7sE50QfNSvtDpi3/isTDFqYFyS7RMPwplV8Ix/dLj4M08ieoTIXMKg+t1VRh+AKxfo9lVEDITc3X5Ez51A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QbdTVDQtDBVfOVlDf+Y/kjNnVNECLu2Y8iFmPYDXTfA=;
 b=d0DNm6r7vZrwR9M3Yi0CLhkUKy1ciUtpa02aF60wHNUBqaKmbSyN6ayjI+h77xtMqc4ERn0Q2vPSWdCdzq6b5GfMjVbNnIuCWJ3t2Fp5HtX2Tzt2roF5RPgNlKynqp18rij3b8mNhGOUtvzhGCy6S9poFYOvHpKHW+SgO42cKOe33NWZdTH3YR9MyLDbvsIxJlrEeRxN0zub6JupbXmHLQwOI5BGI1Py1mWh6tjvYO5odWhHgrup7A9ixAD/yhuGsMwbQQOyDItGLR0cgHw112r4bQLp5f78KC/7+Cu9H6Vljt5yiC/wYjJPQT9JIrcwLBmlX4ZoqTT08SuZf5uj+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QbdTVDQtDBVfOVlDf+Y/kjNnVNECLu2Y8iFmPYDXTfA=;
 b=NYOzQNZjvkhNxXDL7iOmLpJUcB9K7h3rDc4cTdkbV8mY1q9xKdrTKs34jo05M+Ad3aVxIGF4t/y+lWB0snyHK2wq+EFr5l7tSeYAVPpinI3UkUwqeROtlznozlrulXSlIjNqQp+4IV0ClmfUVB6asobZNVi3DEAa3WjpnQvIJ5BnR1yQvF1DNing1+G/LOBbpF4fzVGAjSTrTauEGgj9MYvwfSZ5U7a9zIoPwPiOedX/zPeVer8DZouxUHCwxPnIhg3C5lnhz6FkuEVlD462gm69P2JmyIVG5MInbZprrYOQeJtwlxk+ANLd4ZVIRIdBuk1oAF9FvopuI3hQA1ReQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB6158.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:586::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Thu, 12 Sep
 2024 08:37:48 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7962.016; Thu, 12 Sep 2024
 08:37:42 +0000
Message-ID: <b555ae8e-67a1-4dd3-804c-6db5a82b0625@siemens.com>
Date: Thu, 12 Sep 2024 10:37:39 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v3] USB: serial: pl2303: account for deficits of clones
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Johan Hovold <johan@kernel.org>, linux-usb <linux-usb@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: =?UTF-8?Q?Micha=C5=82_Pecio?= <michal.pecio@gmail.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0450.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB6158:EE_
X-MS-Office365-Filtering-Correlation-Id: a60a8ef0-52fd-4a93-56b0-08dcd3062b24
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eTFQT1R1VEJ3cnA5MVlrOHJTREgxNS9JcTBUNDZ5KzM3OVlCdk8yYXdFdGFh?=
 =?utf-8?B?a0JOajZlT0xSMXo2aVFhQ2dZd1pTNG83UzNTM2JaN29KNWpRQ3hLM1JPV1Mv?=
 =?utf-8?B?Yk4xTXdhUnZGNFdHbEh4TnE0bjNPK045cWhoZVV6ejVNQ0MxSjliNlhYWGlu?=
 =?utf-8?B?bFJySGxOMFphOWVlMjQyVFJwN3NPejU1MXpFeXYwNHBhSk5ORGxMTVRnUEhZ?=
 =?utf-8?B?b0ZON29kZ1pkSzhrMS96dmd3K0lJaVlsQjRyVVJJN1Y5alJzODZqTE1GTDBz?=
 =?utf-8?B?NkI4alZ6Z3hWLzRqMGtuTlE1aHRaZzhwbUhLWE1IS1dzRExTQXJwVGhSRE9P?=
 =?utf-8?B?YTFpNSt2eFQvaCtlREJ1aC9XQUNWd0ZPa1Q2L3Y0OG1RSEhGQWlLbU1tUVI0?=
 =?utf-8?B?NG9jQ3dFTzdoZHlPRm5JRWJWUWtxcCtUUzRnOFROeGJNeGFKNkpTeGsralFC?=
 =?utf-8?B?eU02aGhVQXN5RW9UVzZ3OFE5d1FqK2txY0hKSXhBa051ZTRKTGlTS3JxN012?=
 =?utf-8?B?TmdOZVY2OFlYK1Y3a3V2cVR0MC9DOEl5T0pKTnBNQlBVYVdwNkcrbDg3L3NW?=
 =?utf-8?B?SVNGci9jZnk2a0M2dHFiUmU4cnNHMHIrWjBYVzZnUjVmdnhKZlRnamRRN3pW?=
 =?utf-8?B?V2NteW50TittbVVQZnBzYUF1N2Nla0pibjZRMUNQSzBBdEIyQmRVVUQ0YzFQ?=
 =?utf-8?B?UGRNcVJKdWRrSWFjUEphMStLQ0dLS1dESk9DbmE1amxTbk5LTXBTR2FuT0d4?=
 =?utf-8?B?VUxwNDBPZHJTLzdNSVVBdCs2OWRqR2NpZEJNS0J2bmpEVjFZcmhjcXpkYXZy?=
 =?utf-8?B?b1Y1V1NaL1pyWmRjTFRsSmRzNmpsQk1iVVUxVy9rM3BxZ0RVb21kMyt4M0ZJ?=
 =?utf-8?B?UU0rOGpmL2MvU3cyeEhuVjBOd25venRjZmVYSUVYRE1EK2lMdlFvWEdXQzZ2?=
 =?utf-8?B?V0VuaUdDd0ZocExHMG03RGZxdEpwWDlBSC9kNWliZXI5WERmVkR0eElnQWRP?=
 =?utf-8?B?WnZVSVBsV2taQjdKL0N5eFBuRDgvbW5aZWdtSlFqK1d2T2t6bG9MNjNGOXEr?=
 =?utf-8?B?aW1hekZ0TSs1dFJuWjA1eDFWdzQxeENiUUczSXZqRnNtTkx5WFVKWmFvUnFV?=
 =?utf-8?B?dUdZeHhJVzVlSlB2NCtVUlpDQmhXM0oxZkZLNWc5MTkxeDF3M2RmZmNua0JS?=
 =?utf-8?B?bEltOXVqYTZpYVF2d2Vud1V6UzhtaU9wdm1NWjF5UVlmc2k0NWV5YjMyRjVX?=
 =?utf-8?B?Y0U3SVdQWWVITW82WEIySXk1ekFxY0gwemVFRWJaUnk1c2hqekhKakRVT0t4?=
 =?utf-8?B?R2NHUm8zRU5EQjloSmd5c0ZVaUR3aEMvUXhWczdveS9YNjVqTERuWlFpVXRo?=
 =?utf-8?B?SXc2Q3AvZlRDYysxaTJOd2dQM1lXK2Vabnk1TXBTM2VWTnM2dkRTRVVuOThE?=
 =?utf-8?B?T1IwWWdqcnM0RGVBY1BBL25ndkpOZWhpY1ZwbnVhOG1OQWI1bFpFdys5c0ZI?=
 =?utf-8?B?OWNHeXFiS2NQdXhvNDQweGYvNUs4Mm13Sm4zZlgwN1pMSHBibkdRUDZnS1o1?=
 =?utf-8?B?ZUVOSGdYenFwU2JlZllLdXhhZ2JXVytuQkFiUzNsK3c2ZEt1V3dVRHZRVERx?=
 =?utf-8?B?YVpXSDFmOTVDTHhBOVdEdy8rdFdGcmVicitDbVNpbWlPdzR3SlZmUllpWFVr?=
 =?utf-8?B?cnlCUURrV0Q2aExLejZlUFNWZXVmeko4dzFtQ0pTTG0yRDVhNGRNaVpiOFBr?=
 =?utf-8?B?bW1HSGZ6K3JrbUhyZmNDSXdCN0tTU0NJbUlyM2EvZzByWnRRSFR3eC83MDZV?=
 =?utf-8?B?UDJJaU9lL2trVkxIeXFQQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFZ0TFIzdGJ0R3B3TTI1STJaalVBRWRIVU5USDhiZ1dmaUVvMkxRb0tlWG12?=
 =?utf-8?B?MnRIZHgyTkdwNGdHYk1KZk1DQWxiK2VvVEF4dStGaEZwZkpwaStzUVlCT1hH?=
 =?utf-8?B?VjFIeDc3QktEMjYrSm96Y2dyQVRXT1FkMG1qRGp0R2VqdVN1TWlBbk9tdzF2?=
 =?utf-8?B?czVWMEZwM29QQ1A2ZFJvWE5IblJWcnVCNExRZkJkVHRVSXRJRkhLdnFXUWU5?=
 =?utf-8?B?NDMzbUhGVXZaMGZOOXhwcTZQU0h5WGNNZnBvTlBRUUJ4d1hmckZ0Z2hLSGd6?=
 =?utf-8?B?cFduVHBHN01YTmdEWU1QYWppU0lDcXdwMUxxa2FKRHd4aG9Td3BYT0c5YTNJ?=
 =?utf-8?B?SS9wVGdxR3c3TDl5RWFnRWlqKzZvWENnaTFMYTFaNktTemZzTnNtemdVYWZo?=
 =?utf-8?B?RkdoeGpBYXV2dnJWNHJrODRZVXhHM05kdEM3RXZaZndUQTJDU0tjaFJFODdL?=
 =?utf-8?B?YVFKWUl5eWZqUHBCNEFCMjM1QS9ZSWZaU0dvUWZLYUZPejlQY2lIaEhjTUN2?=
 =?utf-8?B?em90Vi9pM2FBRzNZMmlWbGxjKzBidHVYT3ZSNjZPS3FVaDc5YzJTTWlxWm1v?=
 =?utf-8?B?WkpjTW8zUzI5RC85TUNTUUxCS1VWS2pWcmtvR3JpbFUvbUE2a0UvSU12bDFE?=
 =?utf-8?B?czRVcTJSd2VFc3BXbkJTWlNrT0djckNWM054ZWNUR1JscStzM3BHNWhNK3lM?=
 =?utf-8?B?MFFFaFVJbElHMGVvcmUrTTZmR2FscnFoUEFMQUw2V1kxNUh2M0o5RGMya05w?=
 =?utf-8?B?Y1JRcjl6NnRPTzBhTnI3UVEwR2J4b0VmaEtQbEtGMjBOWjlNNGcvbTVyTDRn?=
 =?utf-8?B?Y01zL1FIY2JwU0hDcEdZanF6UmxhL3RSYjZQMEs2KzFIYmIxSUR4S2RrdWVy?=
 =?utf-8?B?NG1pNFNlZkNJdTVQeGlEUU1JVEhMbDUwS25HK25GNnZ1UU81ekhXQXYzNUxG?=
 =?utf-8?B?b05hWlBWK0FVR0hGT3hQbjNpQVJaNUxiWlVNZUtYaGNvczIwT2l4L1hod1FO?=
 =?utf-8?B?bkFNU2NjTmNuR3k0aXh6RDZwNTNkaGQ4clhYVE9HOGVVaU9SbWtqMXI4bTcy?=
 =?utf-8?B?TS9VY2ZZT1dQa05GbkJxakMxSGwxdmtUQkV0Nk1WQkpUL1FIWldFSWJjY0lt?=
 =?utf-8?B?NG5GZFJtWlJYWi9ENFZvMFB6Q2paQkQxQmlLM0ZoaHA0NWtNYzUreHZpbE1n?=
 =?utf-8?B?NjhPOGZlU3ltVDVPNU1vQXkvTmhvTlFrYjVoUXpmZkdOWUlSc1FSQk1lZjda?=
 =?utf-8?B?US93VVRnRUxDeHh5ZUhGNlRiaktIKy9kS09qTWNsYi9ITkJTcDlvUERnZEEv?=
 =?utf-8?B?KzRjOHBkdEpjMFdzMmNmYTJzaDZ1eTNzR2ZjRHl5VXRvNEVzb21wMzVUV2sx?=
 =?utf-8?B?VDYvVTNGL2o1SVVHeUk2UUlvdG1lekJaZmN4b0lhVXpMMURlWVNWcmFlNmNt?=
 =?utf-8?B?S3B3TUphaGxXYmxQb0NJRlNFZHlGelNuSUpnZ1J1NmRkSVpmT2N5TUo5c0hj?=
 =?utf-8?B?bHgxczVRY2RPOVQ3MDNGaVRNQWhwWFpvU2VtL2ZtYmJzaW14QnRLK0pCU1g0?=
 =?utf-8?B?RjROcW1NaFFnSDgvSWROcmpHVTI5RjlhbkNkYTFxeFNkUXdGR09BNFlrR2FD?=
 =?utf-8?B?M0NQcTFPL2t2emt1V0V1RVpZQkdOdTZ2dGdJdnhnVVJvZnR3cHZhZ3NoL3RT?=
 =?utf-8?B?RVIzcGlBamRFSzk5YXNpZC9yUUcwczc1WlhsNjA4b05qaVNkZXloazd4NmE4?=
 =?utf-8?B?TEhGN3hnb0swWWhGeVJnMTNCd1B4bytETW4zWE1FVmNiSjVXU2V1NE1MWUgy?=
 =?utf-8?B?bjgzQUo5RzJZdG1XazArcmVzZ1I3SFlWMEphelFlWWJodXMxdWVIeTJTaTBa?=
 =?utf-8?B?QTQycHBqYVBIOFBOdXRzeUZjaWNDcmgvUXhEME5GZjkzSW5CeXpmTUt3NklQ?=
 =?utf-8?B?aGl3djlXeDdROHZMekVKNUcxdmZOOHV0anFQdmd0Q0lQalB3RGdlUmU2ZWNk?=
 =?utf-8?B?Vnk1MHF2OUoyeUNITklMbHlZOXlvM3ZNRGtBR01od1JvVENIS2VKWUZwZG5u?=
 =?utf-8?B?bFA3TkNDMmRpc21sVDJmbmIzV0ZzLzVXU3hqWkxrVjVtTmJJK29yTldBT2ww?=
 =?utf-8?B?RjYvbm9NbWtHWHNsZXdldHpja0twK3NkVmpabStaQktCUmptS2hoVXBFeEQ0?=
 =?utf-8?B?NFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a60a8ef0-52fd-4a93-56b0-08dcd3062b24
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 08:37:42.8241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GiZpojBT5oFxuc8cmh3cOakKcnx4iwNNmv0sM87BtW9wW3pjFtVVA4y5jKgV+NgWuxLni2KgXN6uMG3oeeVPxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6158

From: Jan Kiszka <jan.kiszka@siemens.com>

There are apparently incomplete clones of the HXD type chip in use.
Those return -EPIPE on GET_LINE_REQUEST and BREAK_REQUEST. Avoid
flooding the kernel log with those errors. Detect them during startup
and then use the line_settings cache instead of GET_LINE_REQUEST. Signal
missing break support via -ENOTTY.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v3:
 - use quirks field instead of new type (suggested by Michal)

 drivers/usb/serial/pl2303.c | 41 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
index d93f5d584557..bc433178a6b0 100644
--- a/drivers/usb/serial/pl2303.c
+++ b/drivers/usb/serial/pl2303.c
@@ -31,6 +31,7 @@
 #define PL2303_QUIRK_UART_STATE_IDX0		BIT(0)
 #define PL2303_QUIRK_LEGACY			BIT(1)
 #define PL2303_QUIRK_ENDPOINT_HACK		BIT(2)
+#define PL2304_QUIRK_NO_BREAK_GETLINE		BIT(3)
 
 static const struct usb_device_id id_table[] = {
 	{ USB_DEVICE(PL2303_VENDOR_ID, PL2303_PRODUCT_ID),
@@ -466,6 +467,28 @@ static int pl2303_detect_type(struct usb_serial *serial)
 	return -ENODEV;
 }
 
+static bool pl2303_is_hxd_clone(struct usb_serial *serial)
+{
+	struct usb_device *udev = serial->dev;
+	unsigned char *buf;
+	int ret;
+
+	buf = kmalloc(7, GFP_KERNEL);
+	if (!buf) {
+		dev_err(&serial->interface->dev,
+			"could not check for clone type, not enough memory\n");
+		return false;
+	}
+
+	ret = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
+			      GET_LINE_REQUEST, GET_LINE_REQUEST_TYPE,
+			      0, 0, buf, 7, 100);
+
+	kfree(buf);
+
+	return ret == -EPIPE;
+}
+
 static int pl2303_startup(struct usb_serial *serial)
 {
 	struct pl2303_serial_private *spriv;
@@ -488,6 +511,9 @@ static int pl2303_startup(struct usb_serial *serial)
 	spriv->quirks = (unsigned long)usb_get_serial_data(serial);
 	spriv->quirks |= spriv->type->quirks;
 
+	if (type == TYPE_HXD && pl2303_is_hxd_clone(serial))
+		spriv->quirks |= PL2304_QUIRK_NO_BREAK_GETLINE;
+
 	usb_set_serial_data(serial, spriv);
 
 	if (type != TYPE_HXN) {
@@ -724,9 +750,18 @@ static void pl2303_encode_baud_rate(struct tty_struct *tty,
 static int pl2303_get_line_request(struct usb_serial_port *port,
 							unsigned char buf[7])
 {
-	struct usb_device *udev = port->serial->dev;
+	struct usb_serial *serial = port->serial;
+	struct pl2303_serial_private *spriv = usb_get_serial_data(serial);
+	struct usb_device *udev = serial->dev;
 	int ret;
 
+	if (spriv->quirks & PL2304_QUIRK_NO_BREAK_GETLINE) {
+		struct pl2303_private *priv = usb_get_serial_port_data(port);
+
+		memcpy(buf, priv->line_settings, 7);
+		return 0;
+	}
+
 	ret = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
 				GET_LINE_REQUEST, GET_LINE_REQUEST_TYPE,
 				0, 0, buf, 7, 100);
@@ -1063,9 +1098,13 @@ static int pl2303_carrier_raised(struct usb_serial_port *port)
 static int pl2303_set_break(struct usb_serial_port *port, bool enable)
 {
 	struct usb_serial *serial = port->serial;
+	struct pl2303_serial_private *spriv = usb_get_serial_data(serial);
 	u16 state;
 	int result;
 
+	if (spriv->quirks & PL2304_QUIRK_NO_BREAK_GETLINE)
+		return -ENOTTY;
+
 	if (enable)
 		state = BREAK_ON;
 	else
-- 
2.43.0

