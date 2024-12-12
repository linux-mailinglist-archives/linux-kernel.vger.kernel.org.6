Return-Path: <linux-kernel+bounces-442406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 432C09EDC5E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 01:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 510C21888D04
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 00:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5F51C32;
	Thu, 12 Dec 2024 00:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="PI0jQ9sc"
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11021123.outbound.protection.outlook.com [40.93.194.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC4910E3
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 00:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733961914; cv=fail; b=XXbUGvk7gqb2zGu2seU33U4hX17jxtvxrG6AMXGh60s5Zu302CgYPSeVdGW06BRGmZH3Hw3OmXkLq49cZvJvOM/4fyDWO0HcOkDJ9Rdj9fBB/rhZoddEtHhlSIo0wU/xoRBTsCk7rCsBY42tnXPYbDaQ14XKdaNsOF6ajlr9zw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733961914; c=relaxed/simple;
	bh=dtSjjZdeehrOgeh+Gww6odvH6uBNkjcBAujfz90Pde4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FwfRxR62LhkvQpBqtub2u4Fbs7L/T0mDcubUOM/BMPtou0x7Yt64ZYCIvM2gEDP+et2mOVox0LyEVWY2pRuzu/k/FOmUvVf21RxSEVGub6Updlnhk+xvNvgKOlZCvPdZVQ+0xG1wly1Ak6v2AlayZcNBRyNWDB4RnOFcip8oKwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=PI0jQ9sc; arc=fail smtp.client-ip=40.93.194.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RIcDGQNZ6JoQCnSs6/epiHr/h8unXxwtmNo6xICdOATRQVhn7sAhEOBwz3gTzwoJ3xS0gn6OsVAxeUub/1UsLcmUuCa0Y/vm/yCvF9XKKxiK9nzLG+yCYqbJhgbRhqZmnP4J43/QUhp9acHVDUvUtM9TReIXgCvrJ3+j6mpE3F4/TGyFXgDKju8ge7KnxQhnq1agdQvVBnIE1mMxyfJmu6Cza8OeFKqT4iZVk6XlCvsL58CepBAzhk58egA+rwQAM51wksiI+loMw53jTkIajwKt4+Ry3aI2zmIC99YvGi1k+WW9W0qYLCEVCoDkWE9jFlrI4YyUwzjapfOgao8kFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vadH3wRg+YQmvsIncF3jDQV6E77n3W265rnr0cvuXHw=;
 b=IxTU6np8J8ooqhycZtO39mUujuVQ9HZRC0DFNeijoK0OzQHUE3ZIO6v3U8W9ddqNpQFT1EnuuDSn1HuWkKNjsrSV4eY1t89kOd6F7S9EY7JO4VvWWp36KsA9+etv3Bnf5AhaioA004TpJgeAFrp1v+Nxcq24xD3xnKro7tnR2Aqs2ngmeplWncgGQez1WoW2hhnqXbdzlD8HsPxQQlilJ0j+Gi+hKsS/T6Kqa4dZE951nqhoy3hXUwgRdPf8+U6P1rPN5nJosZCnoKlYSvOPRa9aYeMX0kWU4lREEFOfE747E8Wdmq8cSP843gfygCjPZVSnzBlkoetljdgGWt1QfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vadH3wRg+YQmvsIncF3jDQV6E77n3W265rnr0cvuXHw=;
 b=PI0jQ9sc539rPiaZUbaIu6ugUdPstNq2eBATSMYMUp1/C0Pvr3dRgILFm4rnkB4lK2AbIW7f+RiDI20dC1Yspe+tkOnNKp+qJTQRQrs0BRYbWlom5mxVjECMS7DC8CKmLJXRpqJLbYhA1XKUeQyvJBh6zSLYE6M9LGN6CZsT0xw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN0PR01MB6877.prod.exchangelabs.com (2603:10b6:408:161::22) by
 CH7PR01MB8955.prod.exchangelabs.com (2603:10b6:610:250::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15; Thu, 12 Dec 2024 00:05:08 +0000
Received: from BN0PR01MB6877.prod.exchangelabs.com
 ([fe80::91fc:9877:8a2a:d4e0]) by BN0PR01MB6877.prod.exchangelabs.com
 ([fe80::91fc:9877:8a2a:d4e0%4]) with mapi id 15.20.8251.015; Thu, 12 Dec 2024
 00:05:08 +0000
Message-ID: <311c9f5a-b4d2-41e8-a30e-10fcfb8f19ba@os.amperecomputing.com>
Date: Wed, 11 Dec 2024 16:05:04 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] arm64: support FEAT_BBM level 2 and large block
 mapping when rodata=full
To: Will Deacon <will@kernel.org>
Cc: catalin.marinas@arm.com, cl@gentwo.org, scott@os.amperecomputing.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241118181711.962576-1-yang@os.amperecomputing.com>
 <20241210113151.GC14735@willie-the-truck>
 <414b3388-c2e5-45ae-9f1d-c35310fdbf8b@os.amperecomputing.com>
 <20241211223034.GA17836@willie-the-truck>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <20241211223034.GA17836@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::28) To BN0PR01MB6877.prod.exchangelabs.com
 (2603:10b6:408:161::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR01MB6877:EE_|CH7PR01MB8955:EE_
X-MS-Office365-Filtering-Correlation-Id: 706b8907-433a-4f30-fed5-08dd1a40a3ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TzBHRmtJNndDRTcxanJSRm1WU1VpZDBmZlNQY2dWUE1GcUdiRlpDa1dFTGNz?=
 =?utf-8?B?TFp1YnVPeXo1NlVhSk5jUTM4M0lhaUh4S3lObGUyeHBxa1VYa0I0bDdVNi84?=
 =?utf-8?B?UkY2ZzJCb0J1LzgvNzJ4NmE2dXM0M1RCWG1JZVYzdy9RZmlESGNKbDJsWmk0?=
 =?utf-8?B?Y0wrT0ZkbjRhRGRmNXI4bmtWQWlrZXZORFpJVlVTVkhRd2FtRDZxM2VoRnc3?=
 =?utf-8?B?WjFnUm03YWJDbEdHcEprUjdUTG8wTmdkS3ZHdVVuM2M1TFJ2d3p4eHFuZFEv?=
 =?utf-8?B?QVFHRWs0U0ZVNXdCanh6aS9XeVJBbWJZRDJyMCtPNWRPUy9vbTdwTklqZm8v?=
 =?utf-8?B?bjhobnpkWVRSZWYrd09jRmVmYmpwZGdzclZSQkR5N3lGSmZIdEJwaWxyQVRv?=
 =?utf-8?B?NjdPWENQT1ZaZmd0a3hJZmNwbjcwOFlHaHNFQk1iVUl6Q2IycllJY0I0SXFq?=
 =?utf-8?B?MkU5eXZFTVJTdkx3VThHblMyZnBNaUNJbVdPQjVwTDhFTWVjZFMydnQwRlVi?=
 =?utf-8?B?YjdyOUo1ZUVOazBKY2xoUU5KdXhGUld2R3h6SXJ3RmFnOG1oYjVsd3VYaUQz?=
 =?utf-8?B?TkR5Tko2RTVUV3FvMzQwbGVPUXA4cDhUZTZ1N2JRb21IR1ZCT1RQR0ZxZnFa?=
 =?utf-8?B?aWJPZ1o2SXJ2N1B5N1M5MmJCT0VUUGIycTQrV2dMamdqYkZhbnJmN2Y0bGtG?=
 =?utf-8?B?ZStGcG1GYng0N3F6Y3dYblBpU0ZjKzVhR2pvNUt2QUVaSE0ycm9XUXZjSDM3?=
 =?utf-8?B?c0ZGQ1hQbEhFZDFaSXM1a01lRkpadlFWSUs0ZE9ldXJFdFlJM1ZEMStZdVFJ?=
 =?utf-8?B?R0svMUcrZzk4c29ER0k3NWJobFBlMFhmSVNSSFo4cHpUYWJwbzlsTVhnTkc0?=
 =?utf-8?B?ZTN2VEc3WXRLbDBlbWFla3R3SWx6V2hyM0xQY2phbGYycmZxb2VCeG1MZ1M2?=
 =?utf-8?B?TDBFS2RtelpZNE1HcCtqanRxTUYwUlROL0RvZDZ6T3hCQkthM1JEU2gvNGk4?=
 =?utf-8?B?MGpVcnlOVDNldmR6OFVZWEpBa1doWWZIREdRbVpJTHVKL1R5T2V1ZW9zMndG?=
 =?utf-8?B?Y2dDVEZwcmM5YmRKMS80RnNLcEx5VUZGQklWNmpzWWx2SCsrNmZQVi9DNDNs?=
 =?utf-8?B?alVIblQxR2JPVHpOU3BtcXZVeCtkbFBrZnZXK25wRDdZU2tkaGhKbnMwczkr?=
 =?utf-8?B?dGVseWRmRVV5Y2hiTU1zcDdDZVoyUlJaNFpJbjlTemcxT1h6KzhHazN1TWFB?=
 =?utf-8?B?d1NjNnFBMUtGQkdHOUZGMXJGWkJzSXZkV2dyS3ZMcE1LWEplTW5qZFgza2pa?=
 =?utf-8?B?M0ZNNjlBKzJDOHJxUGJCLzZBVzVaYWt2amd5b1hUcy9wRkhBc2xyZmJOZitv?=
 =?utf-8?B?MEVlR21iK1JjaW9sS2tLSkpyNmk1SU9BQzhMZ2tCbTFsTDcxYlJQdlV1WG0y?=
 =?utf-8?B?Wk5pR0hYL2lWMW9idFY2MTlJRE10VzF0R3pmbXR1dU1Gb1ZpWlduSHorRW15?=
 =?utf-8?B?ZlJqekR1UldSWHVqdmloaGdqL1YweGR0Sm9oRDhnaG40LzZaQWJ5N0Q1cDlX?=
 =?utf-8?B?SE5xL1JRZjhIalBveHFadmFPeHllaXQvL1FYdTNxNzg0NEhCb2RhbmI1eEVX?=
 =?utf-8?B?LzlLeGNMUGZLSnJaZ2kxNUUzUlREVEdKRWZFMDNSRFBsUExUbEpiWVF0WjBW?=
 =?utf-8?B?dWNVdUlxOGprZXhOVTE3VVNJa1ZkZGV2RkNQZkdYRDRFejh0YmZlZTN6S3d2?=
 =?utf-8?B?RXVJR3ZxUExuMGdhQkc5UmxvSlhhRVpDRW9ZcE9tT0tzSlNIUEhPY1RkUU9m?=
 =?utf-8?Q?Nu67RGb2DnOLWEYL5zWWWxEAyLnHwXgUgM8E0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR01MB6877.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDJMckZzenJnSkxFVThDbCt1aDRGRnUzMXNxUTFNS0dpZGdGWS9XN2hpMyta?=
 =?utf-8?B?Q3RlQUo5MGR1L2VPeXlVMFRnMStpeHlaa1N2b2hDZDgyckcrZHhGVXBzako5?=
 =?utf-8?B?b25RRW4rbjJwNVNZN0w4RW12VGJNSCt2OGxXK2sxWjNrL21hTWhjNTJBR2lG?=
 =?utf-8?B?T1pVYWtVZ0hnK3VZaUFLajF3YmMxckV3WjJWNmdvMVg5dGNDMnlmQmp4clRF?=
 =?utf-8?B?K0J5STFwVnh2bkFMREZRRW5BYjg0NG44TnVSM2x1UlJ4NklDTzU0MXpmWHVx?=
 =?utf-8?B?WVE2MVRPZE43clhTRW9hOUpvbFNCM25Ya29VQnA0L2l3M0pwOGE1UURoV2F4?=
 =?utf-8?B?NWFUSHNrb3ptNkU5N3p1WEJJOVNqaHh2Q25GRUxpNnVSMXdmSkZiV01NaWp0?=
 =?utf-8?B?TDdraG9FVlgzUlBZNTZadzdzRmpXYWkvd2ZQVW9SYTBPTFd4VDBWYUNBK25M?=
 =?utf-8?B?aDlIVXhSNTh5MEplZURmUnpIWXZiaHlFMldkYTNkV21oT0hLajdZUGFNQ0pI?=
 =?utf-8?B?ekkwYWdkNmZ6M1dIYmI0RjE0WGJ3aUFyb1BBZ3FKYUdBeURDelh5TE5MVTFY?=
 =?utf-8?B?VXljcC9Fa0VETXRlLzRVMUZ6TW5FRDFFUytWR3NCTkxhcmNqcE1sNE8zVmwr?=
 =?utf-8?B?WWxicmpTRDljQSs2bFhISVllTm81Tys0NlZGeVlEa29tZkw0bFNRY1gvRFlN?=
 =?utf-8?B?cnlYLzRmWEtaaXQrR2x5YzV4WHpxaktLWlZ3akpMZit2MUhua1FKaDhsNE5Y?=
 =?utf-8?B?WlQ0eHRVemN4TXhhRmlTSDZ3RjdXSlB1TkVuV1A3STY1bTRrNW1FNGFsNVVh?=
 =?utf-8?B?Q0ZGb2FVTjc4MXBHREZmdUJTUytjTytBdEpDOC91YjBxZkhpWUJSNTZML01a?=
 =?utf-8?B?YlFtajdPR1VLTC9jMkg4Qk55L0tQaDFyamJHZXVEclZEY2NJNnNPQThsdWQr?=
 =?utf-8?B?QXJ5S3gxMmlINmJMN09WVlBLb3RkSGtIdUlZSDhwWFdlMFVvRUJ1ZTVOUGZw?=
 =?utf-8?B?SVgvWTNKRXN3T056amRSeU5adkdJK3A1ZGtBSzI3bzZidnovMDFGWiszbllQ?=
 =?utf-8?B?dkQrTWdnU25pRXkzc090bEp1eG4yRHdoaXRKWXd1SFU2Vkt2YWlsSnA0UHJR?=
 =?utf-8?B?eDdpazNuMm91TC8vQUpTUTJKYnBxNlNjZldScUpSQUx1eVkxU1RKbVNFNWgv?=
 =?utf-8?B?RTdKVGp1bkFsVnpjRS80ZVVSaEU3MVh2L1NIVWxldC9xWWk4MmltcGtPdVRC?=
 =?utf-8?B?TDhZcVM4RzdXTEVWTGZnbm1UTSswdnhXV3VMcXFCV0VtYTdNOWtjUjE5ZjM4?=
 =?utf-8?B?WURwREQ5dVExQmI4cVlrVkdUUmVvZ0I3SU9jeVNTQXBsejk5WE55V3l4UlNG?=
 =?utf-8?B?VHdoUElsSkVuZ2xqUkcvWW1FU3JlNmNYTHpDd2JWZVZycUpMRzVvd3dGYUV3?=
 =?utf-8?B?SVVMNHZ5WGFVcnl3NTBWNmNjSVVBYVdnQXdsVldVSzEwT3Fpc0FjY3MrNXBD?=
 =?utf-8?B?eW1zNlBtZitScjBUMTcvdFpzbUZPUUZIQmRRSjJHUExmeDFWRWJ1eHRUWWpY?=
 =?utf-8?B?Y1U2YVd3cGdwd3FCSmFTNUZzdHoxai8rZ3AwQUxuYXRKbisrdDk0K29NMllp?=
 =?utf-8?B?TU1sRmgySDNSMDlXVTdHTkNIVmxPbmk4UmxkSlNhT2JVb2xjeDhvcHBvNVUw?=
 =?utf-8?B?YjJpWjlpU0VIQ3hLdXlmNTFGNHZMVUliVjJKUVhsQnBIQmtGTTRWQjdPdm9E?=
 =?utf-8?B?eFVyN2RUa3Q0K2RQM3pRNmxjaS8rTTZVUTZSaVYvVlYxcXBDelpsR3JXQjR2?=
 =?utf-8?B?WUtLUXowcVVXZ2JIMHNYdGxnNnNTckVqYUgxVlBPNXNKdWh6Y3hjZTBJd1Fz?=
 =?utf-8?B?YVBjNGFIY25YY0Vud3hWSXR3UGg5ZTdRbDNOMUVONDBlTHMvUFBaQkxVTDR1?=
 =?utf-8?B?QmF4V2dSYzI4RHhSSW9kQ05RWC9jeUd0TkVRZEhhcEtLSnlvSytFUi94Tlo5?=
 =?utf-8?B?aFoxckg3Vm9SZ1RGQjV0ZmJ6cWxrMkFiQmZYak5UYkxqYzJHZFN1R0VpalFK?=
 =?utf-8?B?RGx1d044YmpiQk5HSXA5N1ZqcWFVUk9lOEJhK01uQ3RlNjZFNEN5bHlqZ1kw?=
 =?utf-8?B?dFcxaU9qNm9FMlJWV09sMldWWGRUQU0wZDFFYk1PTGllWTk2cHNJMUR0ZGsx?=
 =?utf-8?Q?Fihnus90OTC048nyki0jJUs=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 706b8907-433a-4f30-fed5-08dd1a40a3ad
X-MS-Exchange-CrossTenant-AuthSource: BN0PR01MB6877.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 00:05:08.4216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PvqmJnr7TyraoaWydwCw6igUO8p0yL1HHPpNS2LAQRfaxAyM1X2kDt1JY13avZLzA94f4Mk0D43gIS0q4X964EKmGTGZeDQdphaGws0LhV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH7PR01MB8955



On 12/11/24 2:30 PM, Will Deacon wrote:
> Hey,
>
> On Tue, Dec 10, 2024 at 11:33:16AM -0800, Yang Shi wrote:
>> On 12/10/24 3:31 AM, Will Deacon wrote:
>>> On Mon, Nov 18, 2024 at 10:16:07AM -0800, Yang Shi wrote:
>>>> When rodata=full kernel linear mapping is mapped by PTE due to arm's
>>>> break-before-make rule.
>>>>
>>>> This resulted in a couple of problems:
>>>>     - performance degradation
>>>>     - more TLB pressure
>>>>     - memory waste for kernel page table
>>>>
>>>> There are some workarounds to mitigate the problems, for example, using
>>>> rodata=on, but this compromises the security measurement.
>>>>
>>>> With FEAT_BBM level 2 support, splitting large block page table to
>>>> smaller ones doesn't need to make the page table entry invalid anymore.
>>>> This allows kernel split large block mapping on the fly.
>>> I think you can still get TLB conflict aborts in this case, so this
>>> doesn't work. Hopefully the architecture can strengthen this in the
>>> future to give you what you need.
>> Thanks for responding. This is a little bit surprising. I thought FEAT_BBM
>> level 2 can handle the TLB conflict gracefully. At least its description
>> made me assume so. And Catalin also mentioned FEAT_BBM level 2 can be used
>> to split vmemmap page table in HVO patch discussion
>> (https://lore.kernel.org/all/Zo68DP6siXfb6ZBR@arm.com/).
>>
>> It sounds a little bit contradicting if the TLB conflict still can happen
>> with FEAT_BBM level 2. It makes the benefit of FEAT_BBM level 2 much less
>> than expected.
> You can read the Arm ARM just as badly as I can :)
>
>   | I_HYQMB
>   |
>   | If any level is supported and the TLB entries are not invalidated after
>   | the writes that modified the translation table entries are completed,
>   | then a TLB conflict abort can be generated because in a TLB there might
>   | be multiple translation table entries that all translate the same IA.
>
> Note *any level*.
>
> Furthermore:
>
>   | R_FWRMB
>   |
>   | If all of the following apply, then a TLB conflict abort is reported
>   | to EL2:
>   | * Level 1 or level 2 is supported.
>   | * Stage 2 translations are enabled in the current translation regime.
>   | * A TLB conflict abort is generated due to changing the block size or
>   |   Contiguous bit.

Thank you so much for pinpointing the document.

>
> I think this series is trying to handle some of this:
>
> https://lore.kernel.org/r/20241211154611.40395-1-miko.lenczewski@arm.com

Thanks for sharing the series. It is new. Yes, both are trying to add 
BBMlv2 support to optimize some usecases.

>
>> Is it out of question to handle the TLB conflict aborts? IIUC we should just
>> need flush TLB then resume, and it doesn't require to hold any locks as
>> well.
> See my reply here:
>
> https://lore.kernel.org/r/20241211210243.GA17155@willie-the-truck

Yeah, it is hard to guarantee recursive TLB conflict abort never happens.

>
>> And I chatted with our architects, I was told the TLB conflict abort doesn't
>> happen on AmpereOne. Maybe this is why I didn't see the problem when I
>> tested the patches.
> I'm actually open to having an MIDR-based lookup for this if its your own
> micro-architecture.

I think it actually makes our life easier. We can just enable BBMlv2 for 
the CPUs which can handle TLB conflict gracefully, so we don't worry 
about handling TLB conflict abort at all. I can implement this in v2.

> Will


