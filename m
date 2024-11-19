Return-Path: <linux-kernel+bounces-413938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD919D20BA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 08:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08A28281261
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 07:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB51A15535A;
	Tue, 19 Nov 2024 07:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="boDxwERL"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2132.outbound.protection.outlook.com [40.107.20.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A15147C71
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 07:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732001054; cv=fail; b=iJAcCeI6pUQBuILKlAHkXo9jgBD6thHMfD9OeMYrZ9CLahzEPWgLKsEMTl54MkxeAdD63/TMchbzvjP0NcrNJ321Fwt/cE63qAUe2/+aPMP760kBcFMSDNAq1tlWyOn4fNpuOU215ht81Gm89K2hOgUJJeBqgfSPksDSzf7xEO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732001054; c=relaxed/simple;
	bh=45wQNW7TKsq9V/w21t/ejjx9MF95aL/Y8LGulQnWmWY=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K9/hW48L/cNuw6bBiaSfxzucgaeLyjhO0bK+CMn71cVzmuo1SOCd4FiIz4/kIBUKcqU6GZFnvcqJtamcgwPz6U8rJbkqb1Lz3ayyX2Xeg8t3hsGe3L4crNKYR20m20qmqOg3nnVzOtSf3efdX4yWPTA3nGKOFItlz7XeumBM/aQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=boDxwERL; arc=fail smtp.client-ip=40.107.20.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KLa3e/akOADZCFv2D9PwYFILe+8geO92XL55BK/CHBm0gXW5IQ6BzjCPbE+E6NWWdra/zgzmzFnqq1zZSyZ8xLgRVUtbdWzTSHGN43an/UQIyqhrBp2htCBMIMewcascC7qaQwWnxSHS+RxPbLm4DdOHHZQQVPtji+aBSM+6wUxDljXan4IxsMoqrFtNPZHwiTUZ3VhFwYd2AXH45ZYdClulwoxQBN30RBJHRRxc/zhu7XTjJjbaZMx4xOjNf8nLklbZa3ccun1mjcF4NgFijjZtS7fxMxGNfzqa2R53BNF2vVvF/f/qjWYRZ6fEj41tYUpR4atEl763jYosvpL5bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VEJ8JNMV6csj83hFmjxMyh2tv6myPEht75CxwkJqUnQ=;
 b=Lb7e+dID38W5gUVPm9FwB/hQEIhUot7GN7PrTWO7JQkgJrGmPZxv71qoKTdRjkBUnAptwgRBbINdZfFiAJ0IVfmIHm//RWMz1mFQCRL9EmsumyeV84LjHhaokLy0mAAFfk57L+GxmZio2YQuUtRpJntS97x86IwKzUl5LwIRncKui+M1bBapJxPz8Pmz18w6E3kiiWtUzqVUL9UGmFd7Z79n95afifoGPYXuQVDgl2vjQ9aOvUlsfgxjBhFQ53FzvuOiyzfo2/9ebASzdY8odkt4Eq1WJCbXfqBL3o/ewLgEK6hXGzwEoDJexXiX58/EUwFnIw1MvahIWKPHiqQEoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEJ8JNMV6csj83hFmjxMyh2tv6myPEht75CxwkJqUnQ=;
 b=boDxwERLbWVL77+xZqOOQECO9rYeo0iz06oAJf7RiVl25BMkQ+Df157u876vebhwpn5bxo10gR67ANxKcIcoEfUMwGuSbmNDS4pGjtP0hWkr6d8c2YkOPf1MlGD9EpKArpWLRdR8tdpzlHmNL/o30hB+UQ9h6DFsl5PTNxKBGDbYyxyyrRgb9d9TYKB4xilMjU5zGaSaFotu4nDZGTQOOP9K5bqe76LnrIbdT4C/8tm2Zj4GLuFT0xIMDAliEABT0vbIp8TI671rzVbggfimO574HGyKPxGckm6ufwDuSiBaEOnLEQvrFSPRf39KfPyvvNUO1OkNhqyusEdQ0YKvmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com (2603:10a6:10:471::13)
 by AM9PR08MB6691.eurprd08.prod.outlook.com (2603:10a6:20b:303::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 07:24:08 +0000
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::7261:fca8:8c2e:29ce]) by DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::7261:fca8:8c2e:29ce%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 07:24:08 +0000
Message-ID: <377a6aef-46a7-4492-a44f-b2a46869a9d0@virtuozzo.com>
Date: Tue, 19 Nov 2024 15:24:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: Question about vmalloc(GFP_NOFS)
From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
To: Michal Hocko <mhocko@suse.com>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 lkml <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
References: <112f93f3-455a-4b89-94c9-d12844d972ef@virtuozzo.com>
Content-Language: en-US
In-Reply-To: <112f93f3-455a-4b89-94c9-d12844d972ef@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KU1PR03CA0017.apcprd03.prod.outlook.com
 (2603:1096:802:18::29) To DU0PR08MB9003.eurprd08.prod.outlook.com
 (2603:10a6:10:471::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9003:EE_|AM9PR08MB6691:EE_
X-MS-Office365-Filtering-Correlation-Id: f82a562f-1f99-413f-b598-08dd086b27ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cEIrdkE3V0FXMmQ4a3puQk01cXo4WUxSU0VXVWpjQnJmcEd2K3FlUEIyeCt4?=
 =?utf-8?B?QWxVWk9QTFpWMS9uK0VLc0hBMVdmNkJtU1hsYXlURnhzWjBDV29ZYmlRVDJ1?=
 =?utf-8?B?RUNqR0RqRm1BZDNPYXZaSVpxaWUwL1o3b0hNc2pvOFpCVTZTbFZEWjFuZXFq?=
 =?utf-8?B?OHlCMkJ6RS9mK04rUVN0b0ZmOTJ2YUZXMzg2Q2hSTnlGbS9UN0QzV3JFM0RN?=
 =?utf-8?B?TUlVZXlnelNlTndmTTM3enNRSmV4WkNoYitvV3lkVlQzdWNPeTZXQnFPZWNu?=
 =?utf-8?B?NmRIUHBDT2ZkSCtESGw5aHFWK2xHK3h1WGhZUmZJT0lIVDVZdnVaZHZxSFF4?=
 =?utf-8?B?bTNJSFdjWWVvcGNBU3ZaSGxUUThwWnBYMVNqMHlhcFlOZmJ4MEs0WktwZ3pO?=
 =?utf-8?B?SnlvN0grQW40MnExY3BIeG1JZjRvSDU5RFlrVWlKeWFqV0hqYjdtNUhGaGNO?=
 =?utf-8?B?eHB6ZWxJblVBSnNnbXpPbTI0cS9vREt6b3JGK3JTaHEwSm9lVzBSTEV6SG44?=
 =?utf-8?B?cUg3dFlUZGtKQVkvZjBKNXVvMTJvS2gvWkZQaUhOM0RIK3ZSbGV0cC84UFhC?=
 =?utf-8?B?Zmw4M2hGS3V4RmFhb0U1b3BpZDRZbnNOck1DVnRyUUlkajd3cHVFYzRqN0dU?=
 =?utf-8?B?bUROU0tmRzczUHBiSTVKZEcyd0NXdDE5N1Jkb1FDQ1pUVDVtVHhDbTViUkRD?=
 =?utf-8?B?VU8zQ3NZQ2xqRnNaUFVPUk40cEJuWk9NNzFqRndwNzdMRGhUb2ZFKzF6NE12?=
 =?utf-8?B?eTdiOXl4VWNuS3hEUDNTSU1GU3h0cnVQRXZFK0s1YTFVSDd5ampkUUs2QXZ5?=
 =?utf-8?B?RitsbDM2Z3dIelU2K1JYWFh6QzRVQ1ZyM3o5UUN2eEp1VTY4UU9oUWluN3Vv?=
 =?utf-8?B?SjdGQkViVjlCVVdzdTVuWTJPdTdKWXNYem1wWjRlU2hkZk45RWovZTZ4a0g2?=
 =?utf-8?B?dUpxa3ljZXBDUXFxa1plMTJLR1RmQmZTMysvWDJETVc4Uk9QanUxOER5MC82?=
 =?utf-8?B?MEZNRVd4eWpyV3A3YlZQb2p5RnRyZzRLbjg3b3pRUnRWSlN1UUI1azhFY3Zw?=
 =?utf-8?B?WXp3UE9ta1dqUi9hQkxVbHg0ZlRLRDcwYlBSbzNBbTg1V1F2eFFJUEt1ZjJj?=
 =?utf-8?B?R2VzdTNJNXYvZFRQTWN6UGJxQVVpUWI3bWhIOHpiYnF5bmFUWmdDUExLRFl0?=
 =?utf-8?B?VVBqTTdMdmJ5SUlEeWRrSlRtUEM1NWRqMGI1SDlZWnRSc2VEbkx0clpxTFdU?=
 =?utf-8?B?S2dKN1NEUzlCNUtMUzBqbFVZeGdQb05RWFVCU0ptQUhscElkTUw2SXBhYWZY?=
 =?utf-8?B?MlIvblpnZ3JIMUVzeUIwZllxT0J4OEp2L0xFdG9mWnpmM0RpRmhwaTM5V0hR?=
 =?utf-8?B?UHFEcXBDbjBGYk9DVHk1VXIyTEd3NGZ2RC9NTXFQWkZkZElsRXZtT2I1Mkxn?=
 =?utf-8?B?TlFwTGkyNTM1U2FhcTN0QWY2QVhrak9TbXpwSEczTlpFSHNlbVZ1bGxCWTdY?=
 =?utf-8?B?V0NSVFpVZUxCSkp5bm9pTkxsYnp2TytocGZkalpNa0tJZDBxNVh0L2l1QU1y?=
 =?utf-8?B?cFplWG9Md1ZzTWdFZ0VJdUFmOUpXQmZ2cjl6UlB3Q1VoSzlwVWNwejRjQXpO?=
 =?utf-8?B?czZVcCtEYUJvazVVckVtZ3NzVGVYYXFCZFhHc0grc2RVNEpyY3lGaU5LV0ZR?=
 =?utf-8?B?VzJLSVlqNUdMWEJCWHpmYzlSMzJxUGpKQ09Ib243ZmFIVVJEc3dDWlYxZWRT?=
 =?utf-8?Q?7SAMQTtxgtkP04Z+2DQDbJ6jSJTCQnG2ze3ui9Z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9003.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NG9wbHJCWmxVOHBneGo2UGNkOWxSaTNrYW9Zd3lORWZuLzF5NHlVOFI3NHRT?=
 =?utf-8?B?dzE4WFJxTzExVmVieFRiT2tmeE5pZ2FlbUM4K2IrUGF1YUtneXV1b0VnY0dy?=
 =?utf-8?B?R0wvS1NTbHQrTWs2d3h3dzJYd2k0Smd3bkVlSTJraE5hblNCbDF3OFZ6bVhK?=
 =?utf-8?B?MVl3Q0d5R3RWdGFFMkhWclAzbXc1RU1Ya3V6S3pBMzZoWVl4blN0ZXpmdnZV?=
 =?utf-8?B?WHVKQzZDNzVBcmcydU5JR1QzOVJSTHpad1RnbVJFTncybmZyUExGaG1nOXlJ?=
 =?utf-8?B?NkhzZmU0QlNSbHVtNzR1TUlPYlV4d1MvcXBQSUdjN1BqOTBaOHRlK2hFSW5K?=
 =?utf-8?B?Q3YvN3JTYUhTUGlKL2QxQko4c3NUeUk1UDhQZHE1TTNFcTlBNDB4RGxhVTJS?=
 =?utf-8?B?SHBXSGxmU2djbTE3OEtyN002ZmpvTnFKZ0l4OHdBdXkxVHV2SWpJT0U1M1d3?=
 =?utf-8?B?TUNMZllOOVU1NlhmclBuempsKzNoQWQ1aks4ODV1d09uN2ROeWNGcHBKQmxZ?=
 =?utf-8?B?cFpRaWF4RHNES0tXZzZtYjg3OFFaQjN2U2ZyRzBVWDVKekJBRTY2NXQxd0h3?=
 =?utf-8?B?WXIvb0FaOTg2NDZydDNKZGtoaStjZFFzaSt3VXhOaGdMNmdPOHZQRVk0SXFM?=
 =?utf-8?B?Z3BHYlNMZVB0dmhoZHlqdVRQWlpHNzlNUmdYTFR5eEFjaDNlMFg0Q3pudXlu?=
 =?utf-8?B?V0FsMXRWM3g0bjdsY3hiZ1NzbzlYbUpnT0h0WlgvZGJQUEVwT1RYc1E3Q0lU?=
 =?utf-8?B?a25hSXlLc0VXd1NNbTN0RGw4c1hidm5jd2RJMlZjY1A2N2x3N3lWalVXbTFq?=
 =?utf-8?B?MUxWYU9OWlQ3Y0hGMmxmMng2b2ttMWNvSHZJMDZLVWZNeFpCYkNVNGlJL1VT?=
 =?utf-8?B?U09QV2M4eXdqeGVUQUZoR3Z0THlJbU1rRHoxa28yaUJPUFRmVEsrTVJubnll?=
 =?utf-8?B?OGlhNWo0RTJGOFlTcmZzYmk5czBIYUUySEJiTkduTlpiUVdyTW4xUXQ0cFBZ?=
 =?utf-8?B?YUpoN2V6TlM5NVlMK29qWE9oZkd1cmlNWk9pRTZ6S2l1YWlCc3BoZW94Q1Ex?=
 =?utf-8?B?dGl6NmJOWlA5cS9TUlEzQ3dNTml5MGZ2WVEyS0RIQUVqK3JkUWtpWXIyMkxF?=
 =?utf-8?B?Q3dPUzBkcU9kK2Z0RFliVnJyNXEwZmNDZWlRQ3g0TEFhSytQcWx4a0NmTmtT?=
 =?utf-8?B?cGhwcVdYYkZHK05sYkxoa2Z1WENxOWorUFJ3bXRwaVJ3d2dUTG5QZmUyZFk3?=
 =?utf-8?B?bUpJUVlhQTZldGpDYVF6NWtJNjhUT2VFSmdsL2VWMnMyNDBpaGhGclFZdEpm?=
 =?utf-8?B?Z2VnMVNrd2VNamFPcDhXYlkrSnJ6aWdKWEREcHQ5K2pXZ3JZaUoyU2kxTjQr?=
 =?utf-8?B?QjBDT2Z0eUdBSVJ5eVpvMEgwR0ZmSUxiMTJnQXZhRmEwc1c1aTZIRHU2TzVJ?=
 =?utf-8?B?ZUpxNThXNWNWSzNxREEyakgzVmx1c2RMWkJHRjUwMmZkcnAvSC83ODZadEFS?=
 =?utf-8?B?Z0JBd0xPMmZmUzFHSk1USUEybFd4MnVjeE9veFdyQjZ1RXNFelVSVlFTdXA5?=
 =?utf-8?B?VTRTdzEvTVhSZ09zN1JsRi8xTStvRCtVN1dRdlpHd0tnQURWUGNnTE5zaEow?=
 =?utf-8?B?SHJQcUhmcFpwRnJoS2xNZlpvdGdFa1ZXNmxLUG9xQTRJaDRteGU5TDdwNTBO?=
 =?utf-8?B?NUx0K2ZPVCtJU043YlBSeTg1Z2xUT0pJbUNpRDM0NDBQMTJPUTFuWCtmRU41?=
 =?utf-8?B?K1hMQWpSTS9EWTI5UnQreHBDQW9ySnlEUHVJUi9TbU9iMzhHVkdMelhpWHpF?=
 =?utf-8?B?bVp1KzZPL0NJc0FKemY3Q1pubi9LL09GUEpjN3RJTGdwb2E3TS9tbzY5dW4w?=
 =?utf-8?B?Uk5IZEdwbDVidmIrOFNNMlEwdXdrSGNiaTJxQ2FUM1lHbGpFT0N1UGJrMkJQ?=
 =?utf-8?B?STFkbWU1dWppcHV2cThCelMxSDI3bWloTTV6L0VWTmt1QTFLZ1VmWHJmTXRB?=
 =?utf-8?B?b0R1eC9kYks0R3RSeFpiTW1VS0J3b1pwcndFcVNHN2poS1lEdklxSTBiNFZn?=
 =?utf-8?B?NHZKNWZmZ1BicU1IRDNEYUV3K25JMFMxaUM3NEhNOGVaUWJ2N0IycG4xcDl2?=
 =?utf-8?B?aVhtV3ljdXROckdTdUxUUFBQeTllYXZjcnpzeXlzSFZMOFhYR3hELzBLdVV1?=
 =?utf-8?B?Q0wwQTM2ZXN6bXlsaGRvVkZLU3ZiQm05MmQvMXJZMERFMGQ0aFhLK25pdHM3?=
 =?utf-8?B?TWJrZytiWmpRWURnVHlwaytOVE9RPT0=?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f82a562f-1f99-413f-b598-08dd086b27ac
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9003.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 07:24:07.9472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yJQz9YiUEaOqcDZxT6d+qaWnVlLSdLO0isHIzJNQ25Pgt/+RHKtSbh914cfY2iRK8sEG8d3CNZAvysoGGuAjm6VMFYB51e7HIWtMG0Ic5KI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6691

On 11/19/24 13:48, Pavel Tikhomirov wrote:
> Hello,
> 
> I see that in kernel code we have couple of places where kvmalloc is 
> used with GFP_NOFS flag:
> 
> git grep kvmalloc.*NOFS
> fs/bcachefs/journal_io.c:       new_buf = kvmalloc(new_size, GFP_NOFS| 
> __GFP_NOWARN);
> fs/ext4/xattr.c:                buffer = kvmalloc(value_size, GFP_NOFS);
> fs/f2fs/compress.c:     cc->private = f2fs_kvmalloc(F2FS_I_SB(cc- 
>  >inode), size, GFP_NOFS);
> net/ceph/osdmap.c:      state = kvmalloc(array_size(max, 
> sizeof(*state)), GFP_NOFS);
> net/ceph/osdmap.c:      weight = kvmalloc(array_size(max, 
> sizeof(*weight)), GFP_NOFS);
> net/ceph/osdmap.c:      addr = kvmalloc(array_size(max, sizeof(*addr)), 
> GFP_NOFS);
> 
> and with GFP_NOIO flag too:
> 
> git grep kvmalloc.*NOIO
> drivers/md/dm-integrity.c:      recalc_tags = kvmalloc(recalc_tags_size, 
> GFP_NOIO);
> drivers/md/dm-ioctl.c:  dmi = kvmalloc(param_kernel->data_size, GFP_NOIO 
> | __GFP_HIGH);
> net/ceph/messenger_v2.c:        buf = kvmalloc(len, GFP_NOIO);
> net/ceph/osdmap.c:      work = kvmalloc(work_size, GFP_NOIO);
> 
> And AFAIU documentation https://docs.kernel.org/core-api/gfp_mask-from- 
> fs-io.html#what-about-vmalloc-gfp-nofs vmalloc allocation with GFP_NOFS 
> may end up doing "GFP_KERNEL allocations deep inside the allocator", 
> which can potentially lead to deadlock in IO/FS code paths.
> 
> Does it mean that we should rework all those paths to 
> memalloc_noio_save / memalloc_noio_restore variant? Or is it already 
> safe to use kvmalloc(GFP_NOIO) in modern kernel?
> 
> Or maybe I misunderstand something, sorry in advance if that's the case.
> 

Now when I've already sent a question I seemingly found the answer:

In commit 451769ebb7e79 ("mm/vmalloc: alloc GFP_NO{FS,IO} for vmalloc") 
we add implicit memalloc_noXX_save/memalloc_noXX_restore at this code path:

   +->kvmalloc
     +-> ...
       +-> __kvmalloc_node_noprof
         +-> __vmalloc_node_range_noprof
           +-> __vmalloc_area_node

So kvmalloc should be safe now with GFP_NOIO. Should we correct the 
documentation?

-- 
Best regards, Tikhomirov Pavel
Senior Software Developer, Virtuozzo.


