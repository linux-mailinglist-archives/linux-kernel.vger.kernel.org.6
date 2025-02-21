Return-Path: <linux-kernel+bounces-526138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6893A3FA83
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 401DA4415A2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66C6218AAA;
	Fri, 21 Feb 2025 16:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="iHgoxKcs"
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020143.outbound.protection.outlook.com [52.101.196.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605721F4299;
	Fri, 21 Feb 2025 16:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153745; cv=fail; b=qaQXgbd25aTV6F8NsOGxzoevROYepsS9sgK7O5CaBsqdANV2oX4+PQCsmkrxIqPuxlc/S4ZGw70BR4gQXdQhTxYqCZo2SbQejEgBP6c8k8dpyJzwf1K93OIgMznV8uuSP+R7TUEFF/+g5digbQO57mWPxV2s3C9ra67oHcf8gWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153745; c=relaxed/simple;
	bh=3IhL5Xu1+0NNAgLbMgX7gVtiQs/FpCZd8xFMaex7dXE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QagXZTua7/umqUAH0/Opn7d18JUtM+M+KoOdmlEfxe3o2tQpzk+bxiraBH5PkS9huSzOpEMshryriOFgNM49fD1LBac0qwC288HehXXtcGTnV0mh1dyVFH+GAnG8rH3+czSaqZ+liYwXuZoCPJ7q+1e407tsWQb6MYd3FbmJjfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=iHgoxKcs; arc=fail smtp.client-ip=52.101.196.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N2Zxcckqo3P+Eezh2r9wMZAqfgqz2ux8YOqYA5oVTj5Z0QmVNJTRuimyHREECn5lVbDWwKFw6RDDP3Pc3TB353JE1RFfZ+g/Vwd7JCLtzXu0lUI1KYQvwKk5Ndak3DS+TWMkD3868uerDP5oL6PJ7r6fmgir7Oz5rRSvXgjin6t1r5sNiWC6UwqO+nOBqdYCcfyXxV9wB0Cj1Jj8/Z+nDaDvyCiKlE1cEoN2kmkEcYVOMmQblALSrZ6awe+eLFg9/d+6478qMUU/tUN3XK2svaWBXNvba56kthz0tRhOdL4/JgZAzEiw9BI1jMYxOXjTQC2YZHMOKSW6dAXGGPXZeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCbP91QIrQTXBr7EvR054HInZipUGL/THxhKIq70ESs=;
 b=ZbMytng+vqA93MS6qMbPnSDGJbxl6ng3luPMQjNuknaNP1Uq7DNRKeEt6e0b9QyqkN7CKc4U5Kaw7Av9UDObDDjmoawhcYDnG2/ZoO3fZhFsszBgfWSBjayzTyu0OOCnvpKD8C4GbZ7Bw1VakeNWKbJpurmSVHOE7sareQeJdbicheZSZ+v0aq5pktzzUSXi3V1Xf0VH/V7wiqV/K6Q5QwORMl+d/D5Bu29W6LPTRZyzzW2IdUFaoQ2B5h50iHFDaPhwVa1c+E8bY/1OeHCgTVwL9l095sxJ0mj0r6mvhg+zrcPDlxAmDYTGsFlhvggK9XySJldIg70e+MxRY7mqQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCbP91QIrQTXBr7EvR054HInZipUGL/THxhKIq70ESs=;
 b=iHgoxKcs7xsGHJQPrREyQYoy/0f/r3kVvgWd082q2U45avxR9HqQs3AA2FVkZoU3K73LR9LwKBggah97FQRTo7ra92zuPeoM7LCPj/Jjp5rMCs2S0qOQfcKd9bwyKuVH3h5hqs8FwQKrJQRMCM94E5+Qs2B13fNKSoe/aiD6Oww=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CW1P265MB7530.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:214::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 16:02:20 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%4]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 16:02:19 +0000
Date: Fri, 21 Feb 2025 16:02:17 +0000
From: Gary Guo <gary@garyguo.net>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, =?UTF-8?B?QmrDtnJu?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas
 Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
 Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Will Deacon
 <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Mark Rutland
 <mark.rutland@arm.com>, Lyude Paul <lyude@redhat.com>, Wedson Almeida Filho
 <wedsonaf@gmail.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] rust: implement `kernel::sync::Refcount`
Message-ID: <20250221160217.2a6772c3@eugeo>
In-Reply-To: <CAJ-ks9=b5Mw1kQf3xz_VPtp4CkUhw=6xQ-543uXkFgn6wUaOcQ@mail.gmail.com>
References: <20250219201602.1898383-1-gary@garyguo.net>
	<20250219201602.1898383-2-gary@garyguo.net>
	<CAJ-ks9=b5Mw1kQf3xz_VPtp4CkUhw=6xQ-543uXkFgn6wUaOcQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM6P192CA0068.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:82::45) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CW1P265MB7530:EE_
X-MS-Office365-Filtering-Correlation-Id: b1b288ec-5bfc-4d9d-c2c7-08dd52911eab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YzhsdEkwVGNJeTZzK3pMelRrdVlIRFhuclZSanM1L3RMYU81L2hWRUN6ZElQ?=
 =?utf-8?B?OWN4VGV1R1QvN3lsN1U5WXZmUC9Sa0tPeUN0bjMxajlPOG56RUF0NGxyREwx?=
 =?utf-8?B?UjBCWTlTS2t0bVhkVXhSYkFOZE80V3JoVVdWNTFrLys0cEpqZnBvV3dDbEQ5?=
 =?utf-8?B?aVdjNGllUkhFVjhqM3BHUVUxQjQyVGw0Rm9KZlRLdFY3Uit0aTlaMUQwb1Nx?=
 =?utf-8?B?am50bzN0N085QktUQTRMSXZOa3N3VEU5MkxaaTBHUzJKbHlyNHd3dEwwd1dN?=
 =?utf-8?B?R25VUXBKaWlHMnN0dFZaeENCUHJsZWtxNXd0NDlQeGZPTFF6RGcyT2tGRkhJ?=
 =?utf-8?B?WHF6Z1J4LzNmTDdnalF5Tm0xTlBvUXpiWmlOVThaSVNQclFwbFh3QWRYcmdQ?=
 =?utf-8?B?RnBmTTVQSGVKblBZOWxkbzAxclRCWEk0b0M5OTJucEN4eVhHOVh0c3NLQ3Yx?=
 =?utf-8?B?U0JLdHRNRjVsU3VUS1lkRmZLWjlzSnNYcTJHT1Z6dGQ2R0xNTzdJcEloQXZQ?=
 =?utf-8?B?QVdiRE0rZ0w4ajNoaWI2KzRlM3NsekdwS0phS2R5NWVMU1FCSy9Sb1F3RHZh?=
 =?utf-8?B?ZTRNNlljZytaRzBtSEgxcXVUanAvQ25ndWQ4elMwblVUUTVXeUVLS3Z5Wkpx?=
 =?utf-8?B?WmM0dXNmNktXdXlFSUZlVjRtZGppY01oeERKQjZNYXBIRnozbnBDT1pzUGtU?=
 =?utf-8?B?Qk5zTEMwSXpxVHcrajRaSWcvNHV4N0hhUUxNd2puVm85eVFIL3FWc1Q1Z3NJ?=
 =?utf-8?B?WmpteVkwYzlpN1pveWJMMUpqalpOajc4WkYwRk1UTEFLSUl6bitHc1hEcFQ3?=
 =?utf-8?B?NzExSTdmZmZLRGxKeUdlWElpWkdObkttRWU5U0MxUGczNzlTTG5RTUF2Ylha?=
 =?utf-8?B?UW5nUHN1elFEUFJIZE9vNlFHSUh4N2Z5MkIydkRMLzNrcjNrVHV4Z1U2aGMr?=
 =?utf-8?B?M1NBU00vanZkeEQ0bS83TU5wN3BFRDJBNjVJN2ZxYTlaVDUxVXhDbzU4OEY0?=
 =?utf-8?B?RVJnVTlJcy9HVFN3cVNhc3BQaTBCMkFtb0IybCtXcFB1eGN6aVRZU1NseFZB?=
 =?utf-8?B?b0ZocEwyRForczV3WTVYSDR0bmR3bVBRRnZubEZ4dXpkbERXTTcxZ09mdDNZ?=
 =?utf-8?B?NkZlM3RpTUpRSFlzbnFNdE5FYm5POFFwMDNuVmFwc3dZUVFoUU9UbUVvUWdk?=
 =?utf-8?B?c1FQTG4zR21aS3R2bmZUakRnZmZQNStyblVBNVY3Nmxuc3VENTJGSzlPNytw?=
 =?utf-8?B?QUNFTi84cTJZOHprUWZzWjRwWk9sOXZBS1BSR0lkTWM3T09GS2VEVDlMVEpO?=
 =?utf-8?B?NG1tVzJLajg4UHZzMk1nOGE1WUNGMEUxUEprSVlXL2xVRnFqMmQzc2FiTll6?=
 =?utf-8?B?bThQUVc0ZitYY3N1b2NjaWYyUGVnV081dU12ZzF2Z1Z5UlBVdWZkd3FBc3dk?=
 =?utf-8?B?N3NKWjZmbm1TakRSRm5DV0ZuK2U2Qkd3UURBS3RrcDc2K1kyRmZlYUZDWWhR?=
 =?utf-8?B?L1ZTdGRGcy9sR0E4azJmZFBjdzNFYmlkQ1V3NExMNDRWQWIybnZnS0MvbmZ0?=
 =?utf-8?B?YkFSYVhuNXpBUUVKeTNIZzBDQ09xSVJFTG5Ma3ZrMWEyZmhUTVZvVGt6bnBD?=
 =?utf-8?B?OFVGQk5oMFJMTERMVEJEaGFUMXc2SzJEV292RjNxYlZ4WXd2UTN4cmpwVndW?=
 =?utf-8?B?YWZqay9uSnRJU3J1S3FaUXh5SG9OL2dMc1BwaFdXQXNGSk9xem5WUnNDbDV2?=
 =?utf-8?B?YlQyZnBiOTVQVzlXUlNMZnZhMU04eW82dkZpUmd0ZXpDV05aSFByUTM0cFVr?=
 =?utf-8?B?SlVpNU94MnNPMFNLL3M0THFGeUVhQkRjZGNXbVNwbVNsUEpieDF6V2phK203?=
 =?utf-8?Q?ZqNDYqt6BdY04?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUMzQlhpM2N3NXVQOWZsSVBWcXdOZXNHRVhXZ3RyT1J0TnB5NDBnV3poRzUw?=
 =?utf-8?B?NW0xbW5KejV2cXMxQktZbFRaMUNDSjZQcXJ3bG5wLzRGbGplb0UrQXh5NE0z?=
 =?utf-8?B?VUFzSnhhV21WREs3NUtxY0dZd3lERlUzcGhaYXVLdk96enJqRjgwQVZyL3B3?=
 =?utf-8?B?elBNZjFzcGNvNTltSGhCc0Z2aFhweWd4eFVwcGZxTGoxTnNsWU5nSTJQaDAy?=
 =?utf-8?B?VU5UZll4QlQyWWhMMU12L3U4blNJYWNjdG95NkorYitjWTk4MVFYMjAvVHRB?=
 =?utf-8?B?S1h0MDNTOEkxRFNUcjJKRnkvMVZ5NGNiczJUdHE5eVJYc2lOSVFnbkUrbXN1?=
 =?utf-8?B?R2ljZ3FvK0g1Z0V6eUhpZnRkNDFwUVlkaVRncVRucVVtZUVFOEw5dUMvSndV?=
 =?utf-8?B?M2diRXRMMHhEbkpZTE9ZQUZXeW5xcGxLWmFkQXh0UThmS1Boc0VKTU4zNDlR?=
 =?utf-8?B?UEdsSDZOcmJQcWgzQTVqQktKZ0FFcUsyQXc1cVo4M3liMmwvKzR4cUIrOXNy?=
 =?utf-8?B?QWd1RTc5bGNZMndqWkRqYzl6OEtVaXQ4WFJlTnJWUlhIMTljR2FLU1dXS3ZO?=
 =?utf-8?B?dlhWcE1ZeXA2UmZjdUZaNHVtejRjQzN3U3cydXhaRUxwMzJ2bnZOaDR5KzdV?=
 =?utf-8?B?bTdnS0F1RTZJVVFqNnZaSGFIcVpZY25jVWl2OU5SUTZxWHZicGMxSm55NFJs?=
 =?utf-8?B?Nk03NVFycDBNNXJzNU1jSFk5K2hWWjVMUTE1OUJPMm5kQjNvQ1ZRQzFlYm1u?=
 =?utf-8?B?VENVdjhDa25oV1VJWHg1UGRsQ3lxcGtaS1hoaS9TNlFsOW81YlVBUlloZlJF?=
 =?utf-8?B?c3Q1OHV0YThlTC9xQ2dQUVZsUnlPWVl5V2FnUHhCYUJHS09rcVh6VVc2QW5o?=
 =?utf-8?B?Zis1eU40RFY1MXo1Zm8zSUNrZkp5dzJYMkNGa3d0U1RVR2xxYVlmUmw3MTc2?=
 =?utf-8?B?QUhESThmMExyNzlNbm9QZ1RLTHdwM0ROa1FmUklBTDhGeFlTRlhqVHRMZDYy?=
 =?utf-8?B?SEJkZEJqTGRmS3pTUThRVlRmczAzam9nREt5bzg1SllDL3U2eStuM0ZEcVh1?=
 =?utf-8?B?cDgyZmpsY1lFWFFVakRqNGNaUVM4MGtwVEJlb2J6QzFFV2N2MlVVWWttVitX?=
 =?utf-8?B?Z21VcDZFYXZHeTB6eGsrallpNCtVbyt1a1VUNjhwSHdhNGNLSHdnYVdMbkFv?=
 =?utf-8?B?VXdFRHFrcS9laE9yOGxIYVhMcG05UXVsWDR3OHJNaE5yQSs0alRhcGVnZFhV?=
 =?utf-8?B?VzJUdmZEV3VXR21yMG83YTFJNkwyTWJTN3JCZkVvOGwrQW51UW5DNFg5ZGta?=
 =?utf-8?B?bXNzblZmN3Awd1hiSlpaRkQ4S0t4alZZVTRvUCtaa2hjWjBnV2hjeUdsUkt0?=
 =?utf-8?B?K3V1Z0pTenpiQS8yYmluQTVSd2E0MnhQK3Z6USs0S1pIWHdVQzBadUNGdW1a?=
 =?utf-8?B?RXRERDE5bVc0WUxEL3FXMWJQQmVsdS9vRzFaV1pKaHJweDVOcmVrTk1uSFNB?=
 =?utf-8?B?R0dqdFAzNEhlVjhqTHBZUzR1Sm45d2lMNXdkVW40T3pYeG9RdU14R3R5LzI4?=
 =?utf-8?B?NVFLOThsblVJblBVejFBSW50NUZkVlJtSVUvcTdVNmQwVFM2VElPaGFaV0RM?=
 =?utf-8?B?dkFKWEhtYnZGZzNzU05XY3pxNmFkMXhGTUthTW1nTm56ZktRUXpBRDJuNVhq?=
 =?utf-8?B?RjJCTTQ4QXY0U2kyZUZ0Zk5tR1pKRTJZcHFuekJMS2FQSDBDakMzSzgzaHhI?=
 =?utf-8?B?TnJ2cThWYTUwRGNYVXJnU1R2aWNHRldlQXY4ajM4dWRNb0l6RXRIaHJnSGFL?=
 =?utf-8?B?a0E0WmF2ZU43VkNveUV0aDEvbGtaQ1dUQ25vbXJPOVl3VWQ0ZHQwQ2JOb2xP?=
 =?utf-8?B?QUJld1g4bFNJYWZJci9ibndwVml2RlJMK1lCSzJmdGJnUXlMNTMwRHlHYU44?=
 =?utf-8?B?cm5VVnAvellCMzkwY1pYRjNDT01QUFQ5Um9lb0E5SS9lRVdFdHl3R1d4MzM4?=
 =?utf-8?B?LzVTcCtrOEZSSS9YUEk4bjROSVNWUUZ6c0lldTRvckd2VGFyOU5xWllEblMr?=
 =?utf-8?B?bDlRUTJCZ0NTcTBrWmpVdGdoUDczVFdPL25Db3RwZ2xVMnpjbDQ5UFh5S0RL?=
 =?utf-8?B?b1NIaUVIc1Nub2xPYkJScHR0N3NEMVJaZ1pLcC9PVFo0RHJTSkFneHNZZmhW?=
 =?utf-8?Q?bAR0x8I5NitYvSg1aYPUCZg=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b288ec-5bfc-4d9d-c2c7-08dd52911eab
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 16:02:19.6139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hrgBo+N+F62Y6tQ+Fazf5uilXXGIYvFbsChL3vTNh4VwA64FpbDX9d7yNMM8WJ7K+YpkPXnWJ9/zZDejw1T1yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB7530

On Wed, 19 Feb 2025 17:12:19 -0500
Tamir Duberstein <tamird@gmail.com> wrote:

> On Wed, Feb 19, 2025 at 3:17=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote=
:
> >
> > This is a wrapping layer of `include/linux/refcount.h`. Currently the
> > kernel refcount has already been used in `Arc`, however it calls into
> > FFI directly.
> >
> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> > Signed-off-by: Gary Guo <gary@garyguo.net>
> > ---
> >  rust/helpers/refcount.c      | 10 +++++
> >  rust/kernel/sync.rs          |  2 +
> >  rust/kernel/sync/refcount.rs | 86 ++++++++++++++++++++++++++++++++++++
> >  3 files changed, 98 insertions(+)
> >  create mode 100644 rust/kernel/sync/refcount.rs
> >
>
> <snip>
>
> > +    /// Decrement a refcount.
> > +    ///
> > +    /// It will `WARN` on underflow and fail to decrement when saturat=
ed.
> > +    ///
> > +    /// Provides release memory ordering, such that prior loads and st=
ores are done
> > +    /// before.
> > +    #[inline]
> > +    pub fn dec(&self) {
> > +        // SAFETY: `self.as_ptr()` is valid.
> > +        unsafe { bindings::refcount_dec(self.as_ptr()) }
> > +    }
> > +
> > +    /// Decrement a refcount and test if it is 0.
> > +    ///
> > +    /// It will `WARN` on underflow and fail to decrement when saturat=
ed.
> > +    ///
> > +    /// Provides release memory ordering, such that prior loads and st=
ores are done
> > +    /// before, and provides an acquire ordering on success such that =
memory deallocation
> > +    /// must come after.
> > +    ///
> > +    /// Returns true if the resulting refcount is 0, false otherwise.
> > +    #[inline]
> > +    #[must_use =3D "use `dec` instead you do not need to test if it is=
 0"] =20
>=20
> The word "if" seems to be missing?

Ack

>=20
> The C function comment includes this bit:
>=20
>  * Use of this function is not recommended for the normal reference count=
ing
>  * use case in which references are taken and released one at a time.  In=
 these
>  * cases, refcount_dec(), or one of its variants, should instead be used =
to
>  * decrement a reference count.
>=20
> Do we need to include this warning?

I think you're referring to refcount_sub_and_test? This is
refcount_dec_and_test.

Best,
Gary

>=20
>=20
>  [...] =20


