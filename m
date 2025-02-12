Return-Path: <linux-kernel+bounces-511324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E79A32962
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97ED0188B926
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 14:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A9221129C;
	Wed, 12 Feb 2025 14:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="w7h+I4wQ"
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021120.outbound.protection.outlook.com [52.101.100.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EDD211276;
	Wed, 12 Feb 2025 14:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739372301; cv=fail; b=gc5R3xZylTSUAHBLEDVUpW9LLHkyvUXWctvz7iKBRhbB6e8dJyVSuGCCQ97YBFYA/1RBDFJ2Zf3cXlULvh+0AnPYpq1/RcoGmKWswQDp8ylMVxtUEbWAYAZup5jqBO2JZOqOErxsXsH2E0CdeS9TPVJmy/ljeKQb2rgvy+h8PRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739372301; c=relaxed/simple;
	bh=j2emhaAzTHVfctiE0jmnsarNdv7u4xTNnM7Jy4zDrv4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BtBsX9hjCxsbdk0SnnIS1ixcYB88iAaWwedp1wEfKL/iECt61GAYkbwYN48kdLZoAm4jXuPXASq+AMlWM2EQ3FWLFpMBdecIVlbA9mxL/XNJbIBNi6pUr1ZszDUh9eyx+RpG/Dm2G/aeyK0gvmkiAO6xyBENeB/xlVrq185g3+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=w7h+I4wQ; arc=fail smtp.client-ip=52.101.100.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V/+ELdHkLlS8zaroZfl53Gtgbf9fdI3EJi7S1ma8bP5Rw+crvGlbLdl+v4LFjq7ytyIXI0miM6y21v4Vr8JyFUqzCGekSxMLN097wSb1ia1mOuKm3ul5tb1ksuKIKDpSxMpnspGRatKO5uMCdktKg01HbmrrpWDzKzmZXznjYENg1za/eilfwokQ+Hr92op7+3SgcYL0ASlFNtSrDKepIQs+HL8h6RbHCKb0xsXMKsZXR42PlHaent84ZlLCWb6hoj7CKrqhl13pdQj6WJEQGRrYvtz+zz7tnnFhpjqBWMFZHRRHjrsN+C1b6b2Lt/q9jNFzzocXlPoR4jTnBov/kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JC30gvMksfZJ/h2KfOV7PLmIVVcNHia+ma68wCIOWQI=;
 b=YqVd5oHPXQm2sZXJK3zouq70UKbSjWRVhLtBVCB9Ao9JKjLr+ZB2jOxAk4zF0yYZJerKd9fv/5aO8/V/D2JUQB23YHMNosw5TDGBU06jzI1NDJS/H1Rvpa8JyHCmQ90r3w2EO2jEDCBWVXnmQl9qRd9hkm/IndcUf6g8OfTckmRwf/2AP/YzUFmCUKjINRp5GeuujZ9U7W/+Peb9d8ZMrD/NzgsDtqjBJC6yWJ/rEk3LAlhxHi4MqtyFJYVFj4wYWG+YoMpSUgsY3mIbnzOunRaMmiWdm62AWHeceSFojXhzQEI6IgGgjfBJOJLrNIDi8jZqJFfe53PI/CN8LZky2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JC30gvMksfZJ/h2KfOV7PLmIVVcNHia+ma68wCIOWQI=;
 b=w7h+I4wQYoZuo3cerivxJV026dqHNRAByqP8mwI8x+rXhM7c+Bv2EckzrqKlohJ3prmmfWOdM/TVHJ+8nhmioh/89haI1xCVC4Z+9IejMwhgm9IbUhlkUlB//HsCPRRDv9sT/xVHLBx4chYN8MsSL4ArMWf5QdXlXXMoCWPgWEY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:15f::14)
 by LO8P265MB7720.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Wed, 12 Feb
 2025 14:58:16 +0000
Received: from CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM
 ([fe80::4038:9891:8ad7:aa8a]) by CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM
 ([fe80::4038:9891:8ad7:aa8a%7]) with mapi id 15.20.8445.013; Wed, 12 Feb 2025
 14:58:15 +0000
Date: Wed, 12 Feb 2025 14:58:13 +0000
From: Gary Guo <gary@garyguo.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Lyude Paul <lyude@redhat.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Alexander
 Lobakin <aleksander.lobakin@intel.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Lukas Wunner <lukas@wunner.de>, Mark Brown
 <broonie@kernel.org>, =?UTF-8?B?TWHDrXJh?= Canal <mairacanal@riseup.net>,
 Robin Murphy <robin.murphy@arm.com>, Simona Vetter
 <simona.vetter@ffwll.ch>, Zijun Hu <quic_zijuhu@quicinc.com>,
 linux-usb@vger.kernel.org, rust-for-linux@vger.kernel.org, Miguel Ojeda
 <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH v4 2/9] rust/kernel: Add faux device bindings
Message-ID: <20250212145813.3263ac8d@eugeo>
In-Reply-To: <2025021026-exert-accent-b4c6@gregkh>
References: <2025021023-sandstorm-precise-9f5d@gregkh>
	<2025021026-exert-accent-b4c6@gregkh>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P265CA0154.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::11) To CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:15f::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB5186:EE_|LO8P265MB7720:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ddb4e27-2703-4270-efa7-08dd4b75adad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|10070799003|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eXZIMHlsREdFSHUzeGdDQVlsZGNiandRcHlHRndwNU9iQzVZRGF3ZlFrWWti?=
 =?utf-8?B?TU1QYTRFMVZxVmF2M2ZaQUozazNGSTN3L1VOVkxMUkJ3ZytNdXpPOEhHSDZU?=
 =?utf-8?B?K25BbWZLNTlOd2NLU2hkelRldzdpL3lqbHp4VHlUSG9XV2lSMGRTeDZuVFlu?=
 =?utf-8?B?OTYzNlFYSFhNZ2JZOFB3SlBXQk9TT1h4WlBGNXpQRGs2YkFSZStaNk9telhj?=
 =?utf-8?B?MnZ5VC9oQ1JNQjBnc2RRbUhZZEVOL1RhWE9vUmlMUFNtTEU2Q0xXSzVpcEJH?=
 =?utf-8?B?TmNMTU1nUnBsbnhKWk94eVNYeUphZ21GbGE0S3JZSURKOCtqaVJwOVhGcjMr?=
 =?utf-8?B?ODB3bDU3dDdRUnp6cElwK0FoZ3I3VE9qc0EvSlF3YVZYdDh6TVk3Y0p0TXFP?=
 =?utf-8?B?aTF2YnBUenA1anNrRU5rVFBWRFZVQ05GNFRxVVNSK01PTERWc2d4RlhZTHJS?=
 =?utf-8?B?YWZFK3hRSGdpNnFlSU1WY1VMOTcrRzRzcHJOb3Zrd2VqcFQ0UU5OVFhueDNM?=
 =?utf-8?B?aXVzUk9mT0pYQW5tMjlLQ0NpRlppa1J2RTVycERjTGovNEM5akdYUnhkVnhM?=
 =?utf-8?B?UUlXWlZwcWlmNEJtT2dJUFhGcjJ3UlE2UjNDWllRalFVRUhQSHFzZFV3bVkz?=
 =?utf-8?B?T2dKM0puSTJwS0FoTmhuZXE2ellEQlY3SElHc1ZOd21ZNitEVGREWTJwSGJz?=
 =?utf-8?B?NWNjQ2cwaTFjT2VMdjIwQ3BXZGJHOU1SZmZCbjFDblVEZE81alhCcmlUKzBl?=
 =?utf-8?B?a2g0RnBlcG5jUTVTN0tkV1BHT0JCYjJGa1BwM3lYWGRnUDVwNFQ3RGhwQWZx?=
 =?utf-8?B?V1VHLzBBWnF0WmFxb1RycE5KVnZNcTlwUmg4Uys2RFk2Z3I3VUNzNjVvdFQw?=
 =?utf-8?B?T2ljUjQ5QUNKMFIySmtkRWpEMSszenBDVEFnQ2syR0xDeFVaNWZYU2p6ZlFN?=
 =?utf-8?B?TmdXczg0R1dJZkFpMzNqSVk0eldQaXFHdU9SbGxtSFgwZGt2QTBFT3pYWkZE?=
 =?utf-8?B?L1ppWmhrQWMzZVdKTXdJdyt2TkxLWmlFTk92TThlSG94Ri8zNkUwcUNuSHBL?=
 =?utf-8?B?djhISjI1SVh0S3ZNZ1BzZEF3bkEvVCtQK1RjbnFkb3p0MVNnZmZKb0xqZlEw?=
 =?utf-8?B?SUFTemZUUWlpVTRrSVIrR1UxbktON0dQOS9hWlpQcjV6SG1OL1d3K0ZkVkpm?=
 =?utf-8?B?dDg4Qm9XZ29teElWYUFaZndSQ1VWOXhUUGwyYVY2UFlSVlJpQXp4QkRmSWF1?=
 =?utf-8?B?N2NHQXBnMk05NmUveHg1ZTJPTEpQR1NhWHBmbkxqQ0dJTGs2TUJERkVsUWRE?=
 =?utf-8?B?eUlBOUp4VU8wOFpWNlZ0VkY0QkVlY0RUWnBBYm15aitIV2xBM3FTNFNLL29L?=
 =?utf-8?B?YlJqVk9JZXpqSTM4UTUxZUVtelNWZWc3WlU3c0d0SzJscGlZQUFHbU14dlhx?=
 =?utf-8?B?Y1pqL1U5MW1mNGE1Y0tuOFNZWWRFaHBMWmd0OWRVK0xzOVYzaWFDTkRxSmJh?=
 =?utf-8?B?aVJkSTlCaTg4SURzbVhlUFN2OHhXQlZJQjdmM3dyL0xxc2VGRnhieE5YSVc0?=
 =?utf-8?B?SlpkQmpoM3NjMkJSRC92Z2dkQkhWTWJNbVg5Sy9RNStaOE9MeTMyblpJeXli?=
 =?utf-8?B?KzE3WHFPMUZTVXVwV3dCM3BlR2lERm9xL250UFpHbkxIeWJTWHpXdnEzOGhq?=
 =?utf-8?B?aTVTcUtMQ0tRRlhlWDhiSFNhT29HUzkyZUNDUmE3dXoySE4vU1RLUFRoVjdQ?=
 =?utf-8?B?VDNEb2d4dVFQY29JczQxNENRbDFmZ3dWV09CUnF1emIxV1ZsZkFHN3VFNzJx?=
 =?utf-8?B?b1Jub0hjazhYTEdnOVo2bHVyNGdGOUE2TUZySXVlRzdOVHQ2cHZRKzQ2TXg4?=
 =?utf-8?Q?0WuOKl+M9SYkg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2wrVnlod2RNNGNqM1pmeUMvNzdrenBtZFNVNkc1OTNZM0xSTDFCb09UU0Fm?=
 =?utf-8?B?QVkyRkp1Smd0WmlpdjNSVXhHc05RM083d2FITm1pZ2ZFOGxhU05NY1haZnJs?=
 =?utf-8?B?NjV2aU9qdXhIOHZMMFdoVjg3Vzljd3k5VTdpdktjNFVyNTE1Ri9jUUljS3RC?=
 =?utf-8?B?Wi9NL2lVa3dtdzM5NjEzTWptTnFrRmkxZ01ZNXVIV3k1RzVLcmRIcXFUUk4r?=
 =?utf-8?B?bTk4MHFsd0NKVFNTUTA0eTA3Z2Z4MHhmbkJ1RXM3eG5SMTBtT2cyclVpbUZj?=
 =?utf-8?B?clMxNy90aFAwVXJlS2xhcUNhMG5UYXdiZ1dUa2ZlS1Irejl5SjgvY0VZUDBS?=
 =?utf-8?B?Rk13RFBNYVNuamFsbTh3SnQvYloxQjdXOGc5Z3VkdTBQUUZmM1hTa09yMlJN?=
 =?utf-8?B?eTN5a2FzYU5yTHZoRlZaUE05aSs2MFp4MFZWNnRYRVRXeTdYc1kyNmUvZmlO?=
 =?utf-8?B?enFaZERXQ2ZDRzFuT2tiSDNoN1VNYVY3RzRrL1J1UGpLNFE2YVFRd3dkVDcw?=
 =?utf-8?B?M1hrQk5YUGYwV1BQUTZCVkNjRVRIU3U1WHl1dFlzZytweUZXQXl2dFlMOURo?=
 =?utf-8?B?azVEZmdFVzRudmp4YUhWRFJDT3ZDdFFSMGVmTzlPUEFzak52TVdhSnRCV2pF?=
 =?utf-8?B?bldEN0RBMjgyVzE4cVVqV3Rra1BxbXQ4ekpFWnlNK3lOdGYrcU9ubnVTSUQ3?=
 =?utf-8?B?QU9xalFpL1BGSlNGS0lOTmd5UlBHdmRNVzd2Y1pjWk1vd2ZnUXRiMU5yc2Mr?=
 =?utf-8?B?M2hvRWtYZXRsTkVqRTZkaEJSUXNOVjFCL21oTmlGNWZyRGkxeVd0aVlOOCtY?=
 =?utf-8?B?YW9ObjFsdjRMb0p4RGhTZmk3aFh5OGNmTm01bUZyU0RNeHlLVDFBSW9jdklR?=
 =?utf-8?B?cHF2RURpUWtBY3BGcXJ3cjcyZTM3bW1ZcmxxOWFUa3BWOEs2M0JCaXF5QjZP?=
 =?utf-8?B?TlkvMUhKWTBWbFpJUlhlRDAvYjJHd25nVmVHTi9yUDR6ejU1YTNVNGRMZUUy?=
 =?utf-8?B?V2Qwa2hJUVRBazlUYTFITmZ2andqTUpWZ3o5bE1NdjZpKytOOWprbmhEQ3M1?=
 =?utf-8?B?blZ0dFNGRlphZjUwd1BPbnJTTlo1TzY2YWU2Ui9EVy84V1ZOTy9wWnRRbFF6?=
 =?utf-8?B?TWduaFlNV2J3TXBWRjJWREJCSk5pYTk2cmFUandoVmFFTmFza1lwbEVzVW0z?=
 =?utf-8?B?SFA5dW9DL2lSNUFJLzAyUWNBbmlSVWVZR3ROQ1hIU0RNc1oyOHFnMFJzeVB3?=
 =?utf-8?B?bnpQVm9NUVNBSGgxZzNQdUYvdWZHSS9UTzhRVFhWTlhocTNtVHhSTjVZM05H?=
 =?utf-8?B?L05RaHlaKzV6L2I1bkt0a3FSNjZla0tLR3lTRkx1ZmVjNUZVZ3FCUVpITFU0?=
 =?utf-8?B?VEVpajJ6SjlhQVRVajZmNnJGZzBOaVFMLzB3Z0k4NDdaa0t4aW1QcnRHMGsv?=
 =?utf-8?B?bjNmbFJjaER2dzJTNDZDZXFlRFZsM1NJelRYUllsQ1VWOXJQZVh6SUVxRURW?=
 =?utf-8?B?RVEra3p5RG5JVWJCWWVDSUFYa3gzcmpnbmRHQXNReUkyaUl2STVicWxnc2hj?=
 =?utf-8?B?bkxtOGp4OUxVOTM4RG9ZU1MwOTM3M2kzZUNnUzZucXMxMXVqaXRsUFRKZGZ2?=
 =?utf-8?B?ditCS0pWUnZyQUlyTlRZb3BobW44WGx4UkFIQTAxVFF5RFJiLzFxeVBvRW1L?=
 =?utf-8?B?bEtUTi9hOWVIVzZJY0FLRkN3WS9tTjV6MHBVaXJ4MGh4V0plZUVDL3NlZGt1?=
 =?utf-8?B?MXVyb2dmSFlKcWlhR3MrM0VaTGdha3ppTXdBZlVTWjhYdlhKOU50clR2REhX?=
 =?utf-8?B?WjBoSTRmSU5rQTlCcjJOUHUybXQ0MFI3YlVMSDIyQ2NHMHREcTd3MFZoUElv?=
 =?utf-8?B?NDN2bmlRaXFYbUVULy9pOHh6ejFMektFN05RVmJBazJ6cnNvT0xMTW9aTnZI?=
 =?utf-8?B?UmJwZS9VTGRlSG9MWmdISUJPNGM0ZTZlajVYdGMvQ2xHY3BtRjdsZEZEaUM4?=
 =?utf-8?B?SVI1TFp4ek5CNmxtU0VzaC9lb1F1eUxDYlNmZjVtOW5uN2FRd3JlODMzd3VE?=
 =?utf-8?B?WmY2cnJ6eXprckRBUmVoZWpGRnU3Ujl0N0tscUxadnlYT0xmMnNTY085N2NX?=
 =?utf-8?B?WlRaSi91aWZiTFNqY1RINWtMdnlybjhvQjhoU010a09pVE5hcHhaQlhpVXUw?=
 =?utf-8?Q?crb/3EZD9SyeVK24Z1SWvbYe/uc9aCmAOl+aqWmnkomX?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ddb4e27-2703-4270-efa7-08dd4b75adad
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 14:58:15.5487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6u9bus31g/YWDyNK236V9Cdc35SIuQF6GeMndGJtSjhcltvICcYE+nYviVlJC79uL3VGGNVv+tJoAKrhbPN+Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P265MB7720

On Mon, 10 Feb 2025 13:30:26 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> From: Lyude Paul <lyude@redhat.com>
>=20
> This introduces a module for working with faux devices in rust, along wit=
h
> adding sample code to show how the API is used. Unlike other types of
> devices, we don't provide any hooks for device probe/removal - since thes=
e
> are optional for the faux API and are unnecessary in rust.
>=20
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Ma=C3=ADra Canal <mairacanal@riseup.net>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> v4: - new patch added to this series
>     - api tweaked due to parent pointer added to faux_device create
>       function.
> v3: - no change
> v2: - renamed vdev variable to fdev thanks to Mark
>  MAINTAINERS                      |  2 +
>  rust/bindings/bindings_helper.h  |  1 +
>  rust/kernel/faux.rs              | 67 ++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs               |  1 +
>  samples/rust/Kconfig             | 10 +++++
>  samples/rust/Makefile            |  1 +
>  samples/rust/rust_driver_faux.rs | 29 ++++++++++++++
>  7 files changed, 111 insertions(+)
>  create mode 100644 rust/kernel/faux.rs
>  create mode 100644 samples/rust/rust_driver_faux.rs
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 25c86f47353d..19ea159b2309 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7116,8 +7116,10 @@ F:	rust/kernel/device.rs
>  F:	rust/kernel/device_id.rs
>  F:	rust/kernel/devres.rs
>  F:	rust/kernel/driver.rs
> +F:	rust/kernel/faux.rs
>  F:	rust/kernel/platform.rs
>  F:	samples/rust/rust_driver_platform.rs
> +F:	samples/rust/rust_driver_faux.rs
> =20
>  DRIVERS FOR OMAP ADAPTIVE VOLTAGE SCALING (AVS)
>  M:	Nishanth Menon <nm@ti.com>
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h
> index 55354e4dec14..f46cf3bb7069 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -11,6 +11,7 @@
>  #include <linux/blk_types.h>
>  #include <linux/blkdev.h>
>  #include <linux/cred.h>
> +#include <linux/device/faux.h>
>  #include <linux/errname.h>
>  #include <linux/ethtool.h>
>  #include <linux/file.h>
> diff --git a/rust/kernel/faux.rs b/rust/kernel/faux.rs
> new file mode 100644
> index 000000000000..5acc0c02d451
> --- /dev/null
> +++ b/rust/kernel/faux.rs
> @@ -0,0 +1,67 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +//! Abstractions for the faux bus.
> +//!
> +//! This module provides bindings for working with faux devices in kerne=
l modules.
> +//!
> +//! C header: [`include/linux/device/faux.h`]
> +
> +use crate::{bindings, device, error::code::*, prelude::*};
> +use core::ptr::{addr_of_mut, null, null_mut, NonNull};
> +
> +/// The registration of a faux device.
> +///
> +/// This type represents the registration of a [`struct faux_device`]. W=
hen an instance of this type
> +/// is dropped, its respective faux device will be unregistered from the=
 system.
> +///
> +/// # Invariants
> +///
> +/// `self.0` always holds a valid pointer to an initialized and register=
ed [`struct faux_device`].
> +///
> +/// [`struct faux_device`]: srctree/include/linux/device/faux.h
> +#[repr(transparent)]
> +pub struct Registration(NonNull<bindings::faux_device>);
> +
> +impl Registration {
> +    /// Create and register a new faux device with the given name.
> +    pub fn new(name: &CStr) -> Result<Self> {
> +        // SAFETY:
> +        // - `name` is copied by this function into its own storage

I think the comment is missing about the newly added `parent` argument.

Perhaps we can add support in Rust already?

Something simple as like

	pub fn new(name: &CStr, parent: Option<&device::Device>) -> Result<Self> {
	    let dev =3D unsafe { bindings::faux_device_create(name.as_char_ptr(), =
parent.map_or(null_mut(), device::Device::as_raw), null()) };
	    ...
 }

should work (although I haven't tested it).

Best,
Gary

> +        // - `faux_ops` is safe to leave NULL according to the C API
> +        let dev =3D unsafe { bindings::faux_device_create(name.as_char_p=
tr(), null_mut(), null()) };
> +
> +        // The above function will return either a valid device, or NULL=
 on failure
> +        // INVARIANT: The device will remain registered until faux_devic=
e_destroy() is called, which
> +        // happens in our Drop implementation.
> +        Ok(Self(NonNull::new(dev).ok_or(ENODEV)?))
> +    }
> +
> +    fn as_raw(&self) -> *mut bindings::faux_device {
> +        self.0.as_ptr()
> +    }
> +}
> +
> +impl AsRef<device::Device> for Registration {
> +    fn as_ref(&self) -> &device::Device {
> +        // SAFETY: The underlying `device` in `faux_device` is guarantee=
d by the C API to be
> +        // a valid initialized `device`.
> +        unsafe { device::Device::as_ref(addr_of_mut!((*self.as_raw()).de=
v)) }
> +    }
> +}
> +
> +impl Drop for Registration {
> +    fn drop(&mut self) {
> +        // SAFETY: `self.0` is a valid registered faux_device via our ty=
pe invariants.
> +        unsafe { bindings::faux_device_destroy(self.as_raw()) }
> +    }
> +}
> +
> +// SAFETY: The faux device API is thread-safe as guaranteed by the devic=
e core, as long as
> +// faux_device_destroy() is guaranteed to only be called once - which is=
 guaranteed by our type not
> +// having Copy/Clone.
> +unsafe impl Send for Registration {}
> +
> +// SAFETY: The faux device API is thread-safe as guaranteed by the devic=
e core, as long as
> +// faux_device_destroy() is guaranteed to only be called once - which is=
 guaranteed by our type not
> +// having Copy/Clone.
> +unsafe impl Sync for Registration {}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 496ed32b0911..398242f92a96 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -46,6 +46,7 @@
>  pub mod devres;
>  pub mod driver;
>  pub mod error;
> +pub mod faux;
>  #[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]
>  pub mod firmware;
>  pub mod fs;
> diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
> index 918dbead2c0b..3b6eae84b297 100644
> --- a/samples/rust/Kconfig
> +++ b/samples/rust/Kconfig
> @@ -61,6 +61,16 @@ config SAMPLE_RUST_DRIVER_PLATFORM
> =20
>  	  If unsure, say N.
> =20
> +config SAMPLE_RUST_DRIVER_FAUX
> +	tristate "Faux Driver"
> +	help
> +	  This option builds the Rust Faux driver sample.
> +
> +	  To compile this as a module, choose M here:
> +	  the module will be called rust_driver_faux.
> +
> +	  If unsure, say N.
> +
>  config SAMPLE_RUST_HOSTPROGS
>  	bool "Host programs"
>  	help
> diff --git a/samples/rust/Makefile b/samples/rust/Makefile
> index 5a8ab0df0567..0dbc6d90f1ef 100644
> --- a/samples/rust/Makefile
> +++ b/samples/rust/Makefile
> @@ -6,6 +6,7 @@ obj-$(CONFIG_SAMPLE_RUST_MISC_DEVICE)		+=3D rust_misc_dev=
ice.o
>  obj-$(CONFIG_SAMPLE_RUST_PRINT)			+=3D rust_print.o
>  obj-$(CONFIG_SAMPLE_RUST_DRIVER_PCI)		+=3D rust_driver_pci.o
>  obj-$(CONFIG_SAMPLE_RUST_DRIVER_PLATFORM)	+=3D rust_driver_platform.o
> +obj-$(CONFIG_SAMPLE_RUST_DRIVER_FAUX)		+=3D rust_driver_faux.o
> =20
>  rust_print-y :=3D rust_print_main.o rust_print_events.o
> =20
> diff --git a/samples/rust/rust_driver_faux.rs b/samples/rust/rust_driver_=
faux.rs
> new file mode 100644
> index 000000000000..048c6cb98b29
> --- /dev/null
> +++ b/samples/rust/rust_driver_faux.rs
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +//! Rust faux device sample.
> +
> +use kernel::{c_str, faux, prelude::*, Module};
> +
> +module! {
> +    type: SampleModule,
> +    name: "rust_faux_driver",
> +    author: "Lyude Paul",
> +    description: "Rust faux device sample",
> +    license: "GPL",
> +}
> +
> +struct SampleModule {
> +    _reg: faux::Registration,
> +}
> +
> +impl Module for SampleModule {
> +    fn init(_module: &'static ThisModule) -> Result<Self> {
> +        pr_info!("Initialising Rust Faux Device Sample\n");
> +
> +        let reg =3D faux::Registration::new(c_str!("rust-faux-sample-dev=
ice"))?;
> +
> +        dev_info!(reg.as_ref(), "Hello from faux device!\n");
> +
> +        Ok(Self { _reg: reg })
> +    }
> +}


