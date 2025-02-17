Return-Path: <linux-kernel+bounces-517870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B12B8A386D1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FCCF188AD76
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D6821CA0E;
	Mon, 17 Feb 2025 14:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Tl3AnHQk"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2049.outbound.protection.outlook.com [40.107.100.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C23215F64
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 14:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739803518; cv=fail; b=cJsoIgW9SusRRsB9sl1cvVznxI9TrM6o9bdW3LXX19/mpK4oQ0EiAsFePgDmE1Cec4kkf8+Ux5eYdhk1j4RatoaRzI9eaF6A8hhOxunCXPZ8rrsBrkaO4H3uqNSQcKqXVwdhicrIi8BC8aPgYaL8uAwxUfwytWEJ/7u/0OubWgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739803518; c=relaxed/simple;
	bh=lnYBYOASjJWqkO4M0pDlXJcjp0EGQZ+nKa4x+YpPwx0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ian/MCTlwpp386VzOox3L6sdhWE4rRkNwcm0ow7DpOeQzlCa0fIaZXJUW/RQhDNjINhe9WqQEFu17DbT+wOSxiTEFeL72MEES69J1tCpCcjanca06kzI8i3LFTC5cI9+/WKX5Ov10usVd7ki3cqagOnjc+XZ4eNxWlAtvfGNgw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Tl3AnHQk; arc=fail smtp.client-ip=40.107.100.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NEKe/5lNz+pIBRg382QqFtdGP8BXRzKkR7ySj9TzqKB61rMOxlL8hE+JASuebK+en94qCWbVCbpfu+l0ex9AguU7zffwilLd5Gt8xFeS7LRXL4rJhPq9TIJWK7GKrQqZWfJeDXg+qVA9TpfbOrEdKaiMeLmRDg1eJ0WuEDqbnqxPcFx0GF9isg7QvY2RIZkMDQyZzCiWyvp37onRi3QAxw3eTdx7V7AcsYk7I5BoiNjSC2JO/+dRa2vsJ/rNmsElipA5zHSWxGYRZ9ZaS34+BfXAdxC/4VCQhSr3EswdBWfrjVSPgRq0X/Fd9Q7dhxm49XqDHjfmCzGP/MvgyaJMww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kvJBOAYDu62oh7a7/T2uNQkZ4YCwiPjI83T8kCNjWPk=;
 b=bTe8KMBuVasYnKAWrQXd0ExzK8GBA2lq+RSYr1ccXINo4w6CcROzVaWXqAumfYJbYSq4fcBq/HrSMiGYKqwPRIdTmlP5ArgheNDLuJA/EKeWjDJYP1C7ywO8XCCAxzNZyQimSbceK0l0Hi1RVWXFwPqTRkRQ2LajWIRH0CqRVG39gdvhBhFGgWrpOj5oQ4ul/X1T716RYg4HVGvElY2VqVr4tjSAa6OXzKE5uWC9n9KWE2AoM5x2DQS1KCpB1akJUI5BdtMwBd9XhcgV75R+WRlOb1pwUy7bSMuFM8/h28z8lFrXUYaFBDXzlkhPIB8TnyzdkxJmIOCPCkvIOV1YNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kvJBOAYDu62oh7a7/T2uNQkZ4YCwiPjI83T8kCNjWPk=;
 b=Tl3AnHQk0CKkm27NypV5O8iMykDYlNZdlO/q9l5TVU/Uh/S4+ciep0FS80czTQyUM+Z+Z/eWe5i0ZxrBtqBBos01xNLoE/wZV4eDHTptQDek4jEjjoTMPsSDSJcy4mmObKwiU1fxhoRA2I4XFpIfZgYkAUV+OvjrnCxrwj1L8Mo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CY5PR12MB6082.namprd12.prod.outlook.com (2603:10b6:930:2a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Mon, 17 Feb
 2025 14:45:13 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8445.015; Mon, 17 Feb 2025
 14:45:13 +0000
Message-ID: <319df4ca-ea42-4c1a-bc02-88f86cb03e62@amd.com>
Date: Mon, 17 Feb 2025 15:45:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] firmware: xilinx: Dont send linux address to get fpga
 config get status
To: Nava kishore Manne <nava.kishore.manne@amd.com>, ronak.jain@amd.com,
 gregkh@linuxfoundation.org, jay.buddhabhatti@amd.com,
 srinivas.kandagatla@linaro.org, u.kleine-koenig@baylibre.com,
 praveen.teja.kundanala@amd.com, siva.durga.prasad.paladugu@amd.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250207054951.1650534-1-nava.kishore.manne@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20250207054951.1650534-1-nava.kishore.manne@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0049.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::24) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CY5PR12MB6082:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c9f68ad-4aa8-4a71-18fa-08dd4f61afc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXdNS0d1OWFveGovZk0xekl6Vm1DY0pOV2xFb2FpTTlURVNGaGg3NW1GNzNl?=
 =?utf-8?B?bkFKM0RTSlR3ODBHY2hYYjNZSTZSQ0dYVU1QSWhZb3l5bUlLRm9ZU2l0OUFH?=
 =?utf-8?B?VHM3UzhIMC9zeFhxUDQrSk0xSEt2Zm1PbXg5SjAvWHFTVTRPWnJMT0FYQWtS?=
 =?utf-8?B?SVhKNXIyU3BMb3h6TUdkZjU2L1phTm0wMXFvV0xucmRVeFd1NHdHMWV6MXdF?=
 =?utf-8?B?N002Z2dUL3F0bjQzT1pxS0VGYk5zQXZQVW9QMHlYYWorb1RBVm9COFVTOThD?=
 =?utf-8?B?a3pETWI5dDg1MUtycVdnTDdWYmU2M2pVWEhXZFFySjBraGo5Q0h3QlZBVkhx?=
 =?utf-8?B?WlJsQjVTQ2hTc2hYa0h1aEJoVTF3b0ZxeDk3bWhjbHFqRUhEVTV1M0RzRklw?=
 =?utf-8?B?anc4dFB6SFB3THMvWEgrdzZzUnJvcDIyN3EyNkxnT0E1VFJkZ3NLWUdVcU9x?=
 =?utf-8?B?MGd4MkZadmJtSXFnMUVUMU5Mc1NlUlNhMGEybUxscHFWWDFjaUw2Q1FWdHJ3?=
 =?utf-8?B?WG82YWtRZURybkQ3UmpZbm5RU1VvVHBQS0YyWEtybld3TXIxeXZSM3llUC9E?=
 =?utf-8?B?d0ZpUDU2eTBqZUZtQVhhTzcwdlFLcVcwUWM0ZFQ5b0g1Z1pZNlRVM2UyLzhI?=
 =?utf-8?B?bzJ2TXg2ejR3R05XN3RPcXFTSXR0NmFxckE4blhYTW9UV3hncGdLOGtVbU9o?=
 =?utf-8?B?azFzZ1dMTTVqak54cm1vMUhBb0RnWHFvU3VqdXJ4M1UwYko1bStpYzk5cnZG?=
 =?utf-8?B?eERqOE40c05YV1FJV05ZZHJNVW1VSWRXUDllOXhqSGtTRk1XT0xpNHlDWW5r?=
 =?utf-8?B?QVR1ckNacldPNSttTy9wZitzZHNicDhRMys4Q3YvZm1CVnF4b2ovZHJQejUx?=
 =?utf-8?B?ZXo3aWRWeHJoWmdxUVRXV0RXRmVOMzlKVTltalZWZ3IzK0RaQ05YUVlLT2pm?=
 =?utf-8?B?WjQ5Z0QvMXZDZERzaWtKcUVXRE9HeDh1OHlLZ1FHYUlWVk9qRzNIK2dUYlhF?=
 =?utf-8?B?c25NSjZSMWlyUkxtQnZnM3BtRVBpQkhnbjFOUXVBKzljMENNMzNaeHlKY2No?=
 =?utf-8?B?T3pYNVZQQ25rWWVKTHMyaldYZC9xckdZOWNGb2FBem9CV3pYUGpVTW9YN3g0?=
 =?utf-8?B?VUd5Mk8xb1dHbkhpb1Z1emRnY3BSYWZid0JWV0pPQm85QXVTREJyVThacUNz?=
 =?utf-8?B?bHhQRjdSMEk5ZHBuMlUxc21JU0hsY3NZUERYVHRYejRTNC9wU2R6dzVWNXRL?=
 =?utf-8?B?YnFvS0QzRmNQQXU5djZGVlJCd2Z6TTlIKzZtdGwwR1M2VS94NVU2VjN0eFd0?=
 =?utf-8?B?VnJXaktRWnZaZEU3WEVXV2dqaHgxM3loY1AvNXA0M21SY0Z1cFNQNTVpSHB2?=
 =?utf-8?B?L2lCSTVGbzFKTmEzYjNXM2duOWNOV1pzeU9iemlSa1owVXBKc3ZRaGd5enk2?=
 =?utf-8?B?NVJmRHdYaThKY3BHdS9XUXdQKy9MSFpmWjM3ZFdNbi82NTBGSGE1THMvbjBF?=
 =?utf-8?B?eklpUXd1TzJ5RjltWmZmYUNBckFKK1hYRTQvUXpaeTd3a0t1ZXVhK3FTNnNp?=
 =?utf-8?B?VXcxZDN0d3JmbWY5WGZDdE9MakcyUXF6Z2d4YnhpYjcvZysxeEViNGlhdHN2?=
 =?utf-8?B?bnRNeGoyMG9yWkk4R0VzS1JTOGMvTGJLSVNPcTR5dTFrT0RjNFdadnUzRjdi?=
 =?utf-8?B?Q1c4YVR3cFpkQWJKaGYwS0RCOCs2SjVoT0tBUURrM2tuYVlGYXEzV1MybmQw?=
 =?utf-8?B?RklSamlBZ3BPMDlJUjdJTE9tL3lJYTBSUGx3NmRGZ2RjRWhpbnA1clhBNmlB?=
 =?utf-8?B?SGw4QzJqRmwrOVhvSzIyMFF4OXZSMlZQZExNRWdIQzBIUW1ERzF0SmRCMWZX?=
 =?utf-8?B?VXlaMm5hRHNCcjlYREw1OFRJWXZrNDZRb3F2a1pXWGhHT0xtb3d3N0pzT011?=
 =?utf-8?Q?0oFCP2iHXj0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmJQN2hqWjBnN2VBNjZhRDdvUXVsSmthM1Z3cmJoQ0xiekpMME9FOFFOVklM?=
 =?utf-8?B?SlVNaE5WbXZNYU1HVmQ2MUt6QkExUVN2RHRsbEE2d0duTitOQWRtN3pxcFFu?=
 =?utf-8?B?UDBYdXdkbDhkSVdtbmpLbkJUdVZEOWxZRWxhK21LcnRFbGY3OSs2Zit2S0hX?=
 =?utf-8?B?UUZmMjk3ajMwT0JwdUtORnQxSzZwd0l4cjVBTk1HM01MSXkxR3JVWmZxSGJk?=
 =?utf-8?B?Y2poYy8vVzZjUjBIMGJXd3NxQ05KTWx0bTdmSDZpYmJoZGttUzdjOHlISGFY?=
 =?utf-8?B?cVBBalozaTQ1SkJMaEdoQjdjYVpHUkxkcWRmZytuaFVJOWY1WFIzcDZ6ODgz?=
 =?utf-8?B?VjlVMjhnL1AwTXB1M3ZPV29ZWGVZdEJnS0V2OGJ4aE9hTUM4Rjl6UTBvcGY1?=
 =?utf-8?B?M2cxM2Iya0dXVW12SW1TTXNjdHh2akwyS253ZHVsbWVHSHJSNE5rSDFob0U3?=
 =?utf-8?B?SWliOXZuZnptTFlDVlJnNXBTNGVEdkVlMVNyWFZyTHlrSkxuTThodG1GZk1r?=
 =?utf-8?B?R24xelZrRUZvY1lySHBjeUN0NFBuVC9sRTh3SjFSb3N5Z0Q5U2hjQ3ptK1Vj?=
 =?utf-8?B?dk9DVi9sb0dEYStwZHlqSjdwOTNKUU5sd2I5OFlGUHMyZk5nZVUwRFBrWUdE?=
 =?utf-8?B?Z3F6Qm9SU0xsVWhTUlNGWFpONzZlak5BQmE4cC9jL3RCc1BBSC9LVDBJVVoz?=
 =?utf-8?B?Qm01WVBRdTB2eXdyZVVjc2N4OXFrZU5rNUFVRjR2QWIzZ0JaTjNpRE4wWmV4?=
 =?utf-8?B?cWwvUTEza0xoQVoyUGxjUnZjamVCODZIK2ppOXlpYm43aTk0Q1lyOUtpWVZa?=
 =?utf-8?B?Q1diRTFSM1BOZWpvWklJUFlSc3BZSW9CRjk0eVdzT09iZmNCWDI0TEQwd3Az?=
 =?utf-8?B?RU43NkJac2IydVloYjQ3WlZ6UWFUbGtxVHdSazdiYUgrWWVJLzIzRzR2SXNq?=
 =?utf-8?B?MEhZOUd5YnNobDh4SmhSUXNIQTdqVEdqVjJYYmdvckpyT1hoT0tFRnMxWTh5?=
 =?utf-8?B?YUs4TVFKR2hiRFFBZW5jTWhvRVdCdEQxa1BtQkhmS2dUTkw2bnVCK2NyUEF0?=
 =?utf-8?B?Q3pIbU9ScVZ0N3dZdms0aGFRLzJQYlczWFNMR0Y2aVJiM3hLeGwzckRlVjl2?=
 =?utf-8?B?RDNpenVwenZjcDd4YnZuTWhUcVZ6SDZnTDk2cU5NV2t0d2Q0bTNDbkFZS1F2?=
 =?utf-8?B?dWN6QUsyMXdNc0IyOThicHVlNVNPUi9WMGcvdytmQ0RFTTV1QWU5Um9kK1Aw?=
 =?utf-8?B?R2YrbFQ1RjBJSU5HbVNUU0RDMnI1NjlxNEVqRUVwLzZ3Mmg1MDBxREdxWGxJ?=
 =?utf-8?B?N1RqRE0zK2JpY01USGUvWnFpc2g4b3VUSHNLZERVWElGRzVsMCtZdnFVdzRj?=
 =?utf-8?B?cUZOZC9hQnVTdzFJR2M2S2NnWisrQmhJR3lyd0Y1YXJvMzg0bnMwRlZEMktD?=
 =?utf-8?B?Y2VUZk53UEpzdW1VaG5xOEkvVGVtT3MrNFFCaC9YaDNheFNyUVZFcTdocUNC?=
 =?utf-8?B?NFY4WksyWUFrNUZ4U09IT1NCZjQxQ1FCQmwwNExsZlpsSHhpM3d6Uk1RRmRp?=
 =?utf-8?B?dUVpV3lrYmdSNkxqb0dNcTg0RFdyVk1seWl5VUVhbDUza2ZpdHMyZUJHcE5v?=
 =?utf-8?B?MmxGQ2R6WUZaUUw5NDFWZTZSL1ZtazNIMVBmY2ZTL2NyOW9GTHVubHBxTTFp?=
 =?utf-8?B?REo1dUVmOTI0N2ZGNGY0UEJQU0VzN0ltRnVxcFZoNitqcEhxSTNFR3BLWkF3?=
 =?utf-8?B?eG1hTkhKekdQdjdXcllOMkVCVTFkV2FmUnRVSWJlZ3dkVkhlVGIzcG1SZ0tC?=
 =?utf-8?B?QXN1ZEh1OW9sZ1o2cmhEMWQzWk5ydlFLbk5Wa3pCTE9OL1VEOWJtRklvaVR0?=
 =?utf-8?B?d1ZieHNocUthaHRMLys2SDZYUGZTcjU2QzZQdktwQnM5cmw1UmNqVGJBNmlO?=
 =?utf-8?B?NGtMTHQwQlhBYk9nbE5SK1FvaVk2SzFka2N0UXdLaE5IdFZXcU1HL1BYVTBC?=
 =?utf-8?B?V3YzdlhTcHZ3cUF3Z080aUdkK2REYTVzMHhzakJkbjVkWXVIUnpkTXJ5RWxk?=
 =?utf-8?B?SHBaUDJ3TUdtWlNpTEhTdUs1Yy9nSmhSS2MvanZWL0FMNC9vTVM2UUN1SUpI?=
 =?utf-8?Q?qnSdItU6wfZLs7uIbB/rdTKrg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c9f68ad-4aa8-4a71-18fa-08dd4f61afc7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 14:45:13.6851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lv+gMmyFkAfnxewu6HgjhaOabshmWYZr93IGMZBDfhGeptEWc/KvgAeHLZNfeP1k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6082



On 2/7/25 06:49, Nava kishore Manne wrote:
> From: Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com>
> 
> Fpga get config status just returns status through ret_payload and there
> is no need to allocate local buf and send its address through SMC args.
> Moreover, the address that is being passed till now is linux virtual
> address and is incorrect.
> Corresponding modification has been done in the firmware to avoid using the
> address sent by linux.
> 
> Signed-off-by: Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com>
> Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
> ---
> Changes for v2:
>   - Drop the specified patch:
>     https://lore.kernel.org/lkml/DS7PR12MB6070A83267558A7D545E3383CDF72@DS7PR12MB6070.namprd12.prod.outlook.com/
>   - Rebase the patch on v6.14-rc1 without any changes.
> 
>   drivers/firmware/xilinx/zynqmp.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index 720fa8b5d8e9..7356e860e65c 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -1139,17 +1139,13 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_fpga_get_status);
>   int zynqmp_pm_fpga_get_config_status(u32 *value)
>   {
>   	u32 ret_payload[PAYLOAD_ARG_CNT];
> -	u32 buf, lower_addr, upper_addr;
>   	int ret;
>   
>   	if (!value)
>   		return -EINVAL;
>   
> -	lower_addr = lower_32_bits((u64)&buf);
> -	upper_addr = upper_32_bits((u64)&buf);
> -
>   	ret = zynqmp_pm_invoke_fn(PM_FPGA_READ, ret_payload, 4,
> -				  XILINX_ZYNQMP_PM_FPGA_CONFIG_STAT_OFFSET, lower_addr, upper_addr,
> +				  XILINX_ZYNQMP_PM_FPGA_CONFIG_STAT_OFFSET, 0, 0,
>   				  XILINX_ZYNQMP_PM_FPGA_READ_CONFIG_REG);
>   
>   	*value = ret_payload[1];

Applied.
M

