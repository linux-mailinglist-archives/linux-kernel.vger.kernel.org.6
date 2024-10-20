Return-Path: <linux-kernel+bounces-373496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5639A576A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 01:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 682442820CA
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 23:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAB41940AA;
	Sun, 20 Oct 2024 23:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RzoQEOHp"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E330B745F4
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 23:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729465495; cv=fail; b=AMvl2RyBOz7mQo9QWF4GsomHrHgw58fH9QeCijMHncKqV6v6+PMCTQGWMatj8Kjkcu8XMRfY6LbQyfegBh2UgCTLxrVNYt7kWDyuNqZN63D3uWFc9w895TzUR+88808DN8dVknZuVRVW7qJtdYAI6ctxVIAZI0I/+BSf3rZByww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729465495; c=relaxed/simple;
	bh=vGzlefaspJ8RKSEN1Xes5G646xJUsMTMFlh4id3ziTY=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=IMIMvTjdSfQ69TNOUzmSt4IPEp2EhYY9a34zMO7cxl/DVWgPU2UiR2ORoR1kB9Ql61NDodhCmxKDMkyA8SvPGkNXz0sfmzAnkE+hgsw0Hp8+Eo7O/yPB3fdafYHRx8CkgLyito4No82DJ5e2fiX5GpH+gwAFbc+YywG6BB2R9gQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RzoQEOHp; arc=fail smtp.client-ip=40.107.93.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o2p2FDnvd5z1Vx0vlDXSKOSbumZxdCKQ9JRHkzj6dy4++drhsWcvQvJWCQrG51MaCpOOljxKmMfqvSMUcJSyrztfnYu49VzcGvBbSZTypLeDWAB/VCDxTYGiCLnzyDnQ1ZdNrCoQmyFmF++hVX8INRgDXP2D+rMUuo4rij39Luu7C+vAWl6AYiiIvvW4ihc0gY7rasAFtMiM56uL5EHLnfOnQ9vnckkBw4Ynk4cGGa14ZAIzQOkU9D7c1lgjNF/y33h46JQGvOp70iOGd4mSs68t0nyVWAiB53RWsrpRipwqsFlhO8Riy7y/3tWKxsQq0IzPtNWKcKOiEfNjzxOfRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXDhT0GB5P91aRv/yaI/RDsGrtiYMGYQp7MDzrMxJTs=;
 b=sh9dJWbdNBMen0oQ6yOdQ0susceziAfrw0pEVUDg/B+P9vplt1V7Qr1C7c8zQ5AcZMYLT5F1qG9T459NEuUv7C85dDBYki46tSxXuLbOlKFvOvst83lEtRqkAb2chUdNymRIDHJkTf+z1fIvfUy0GkUoz1T93bygJTDxUpurNE1FDbHxAzcn8OuEZb3zWwKjFkFpUsRZLnoDal6YGfckZ7dhSOyHzGpk/dQpMuIWzFhrvc4x4ykgL+6NoamCJ0bEU1aribwi1k7mnzQnaVqma0TWQQGa+0BS/77TIZEt4tNCQA1Ikx9zwUHBOip9ablWbs3vTT+4rCnmFWnf1WwtTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXDhT0GB5P91aRv/yaI/RDsGrtiYMGYQp7MDzrMxJTs=;
 b=RzoQEOHpwF2HIF8wGlfrDLD6KV4PlcNWaYdqyi0WWvgxkD/gIMGYBbtOb3pyvIGiijFmxSH6gLCM+rII6zEW0ED+TwJOqs1rbynEBPx3P2ZE7wm9h/hAu7FaFu/9xndmTDiiJ4beYpJhhu5h2yYJ7ld5wus50GxdQkFErdZ/1uQoIpw19nbSncyZjNpr7Zhj+TMbxC98plEG6OGeGvHgGCz2fqNES44vc8x0Y7IbbKDLW+C0hANfEKroxkXGZ7eXpKi/pf2Gd7VbkUOrIXHZNjpriIUKHlDA7VloCnuAVm8BEsDtpbeygdLhrjrEmUIDDOHL4p9FsQ4kMm8owgW7VA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SA1PR12MB7317.namprd12.prod.outlook.com (2603:10b6:806:2ba::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Sun, 20 Oct
 2024 23:04:50 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%3]) with mapi id 15.20.8069.027; Sun, 20 Oct 2024
 23:04:50 +0000
References: <20241018011711.183642-1-jhubbard@nvidia.com>
 <20241018011711.183642-2-jhubbard@nvidia.com>
 <cc9d692a-846d-4ae4-af4b-c8de8b724df6@redhat.com>
 <ceeb9dd7-bef9-40c8-aead-c1325f1e3a3d@nvidia.com>
User-agent: mu4e 1.10.8; emacs 29.1
From: Alistair Popple <apopple@nvidia.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>, Andrew Morton
 <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-mm@kvack.org, Shigeru Yoshida <syoshida@redhat.com>, Jason Gunthorpe
 <jgg@nvidia.com>, Minchan Kim <minchan@kernel.org>, Pasha Tatashin
 <pasha.tatashin@soleen.com>
Subject: Re: [PATCH v2 1/2] mm/gup: stop leaking pinned pages in low memory
 conditions
Date: Mon, 21 Oct 2024 09:59:39 +1100
In-reply-to: <ceeb9dd7-bef9-40c8-aead-c1325f1e3a3d@nvidia.com>
Message-ID: <8734kqcr5g.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SY8PR01CA0023.ausprd01.prod.outlook.com
 (2603:10c6:10:29c::33) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SA1PR12MB7317:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ab88d13-663b-4dfa-68a5-08dcf15b9951
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NUVjdU9ld1ZYVi9GSlpJeXY1dWVZTEJWT2ovWlRIS3J1cWs1K3Btam0zR3hH?=
 =?utf-8?B?REhCNEFiQ2NMR0NVUTZsT1lLa1BiZDJXL0pDVitDYXlybEZYamQzZ1JmSysw?=
 =?utf-8?B?VXBYRS96REp0b1F6cU5GZUNGSXltNElXaE85NEUyRENiSHJTZVl5ajFzVnBX?=
 =?utf-8?B?NTZNdjBFb3V5NnBCSjFoMTloREJkM2hYTk93cHhBN3BpbENqbld0b2YyV29t?=
 =?utf-8?B?V3U3bFQ1UkJGdzJPaVRPNmFJanR5WG1FV2V2T0Z5cmNWbFpibVRPR2ttWEkv?=
 =?utf-8?B?dzZrM0hwM2tmWG0ySE9LZm01VU9HeWgrNjYwcU1HQ1pBSW5mbEpWZnV0eG5O?=
 =?utf-8?B?UmpuRnNmaldXazNGQmhVa2RsS1J1THJsUXRQQnlYWjZwbGxJVElUclJ3V2gw?=
 =?utf-8?B?Szd0U2RCZGlYdEtTV1h3Ull3dU1NNWYvY3FKUkg1MXFGd0V5WkE4VVBENDBu?=
 =?utf-8?B?Q3ZWVmI3TGtaYldaOHRiWVVNUHNoeVdSL3dwRTFEMUhlN2x4MEZzWW5teTg2?=
 =?utf-8?B?dlJwb3hVcUxkdVNVU2JsdWgrMHYyZ1pkWHFHR3FaWHFidlFzdkxQNnFyWDBR?=
 =?utf-8?B?L3E1d0FZSGpablU0ODV1NjNuek84bGtBb0JhOEZqcW5sTU5lUktsSWUwU2FV?=
 =?utf-8?B?MEVEbDM0S3B5d1AzOFJtbDI4QkZPeHZSbkZVS25ZeHNkRDNJcXp5UTJGK3JU?=
 =?utf-8?B?OG9zZGtMRElwT3pxaTJTb1U5KzZjczhqdEh3eUVtb0FLS2JtTXhpeGlXc1lt?=
 =?utf-8?B?a3pJYVN5RzltUitpZkJpbldCQlUyUjdZYzRKMW9GUHB4NHZYQnoxbHhxNFVY?=
 =?utf-8?B?RjdPajhkL2hOZ0I0Uzh6VXFJY2xGRisxRzdrQ3pKVFp3K2ZvVGcvL3l4cllD?=
 =?utf-8?B?WXpiNDZBZmFrei9HRnJFQUpheHNDWENMRnJpNmk1SUdUa1RKS0kyOHV1UWZm?=
 =?utf-8?B?QXoxb0o3eGkzb1RveTZJZ0FsSkg1ZkxKSTFObm83OTNNcGJXVXUxaHk4R1Bs?=
 =?utf-8?B?WXZ6eGlLQzdFRStseFNMQVNXZE1YUFhzTWsrL1Z4OVNwV053dW1kbjVQTkZM?=
 =?utf-8?B?UEZMR05TWGkzeXdpWmpaeW1KbmhLb1RUTllJL0s5UXZCUjlxNUJ0M3pJY0VM?=
 =?utf-8?B?WGNuK3phdG5KdnBZRFB5MkNRajZtcERIdjM4UndCTzk3c3RDNElsZ204TENa?=
 =?utf-8?B?WEozK080d29TRlpyV25qVTVjL3lBeC9rdG5FR0VhVzFxNEp6UVFONjlpdUZH?=
 =?utf-8?B?VDNJUkJIQWRRZ3hUOXNibXFUTUg5MUJteGl1V2hSUmdTN0pSU2RYTVRhWDV5?=
 =?utf-8?B?RU43VzU0SnU4clJvakxjck1ZanV0ZUZsZDlFYncxODdWWW9QZUxqZytIVkRB?=
 =?utf-8?B?SW5SdExnR3dWSjg0OHJSdkg2VTZqRjRBZFZFVGFSbW1MQlA0aEZqMzYwbDda?=
 =?utf-8?B?ZDlSc3U0SEtmdEw0amsvaUsxZVBsaHRQQkhzdmpLMSt1cjBoaWo0Ujc2WXEz?=
 =?utf-8?B?UmIzLy9vYVB3M3VIL0IzL3hDZnpLNHZ0N293REwwc0pObnlzZVlOYlFNUGMw?=
 =?utf-8?B?SzlrMkx3b3FKVWgxVVEvYWk4ZXhReTh3RjYxOUV1QXZONzRxdVlXMTdiUEFn?=
 =?utf-8?B?VzRvZXdzZWpYSGl5bXVVQ21SRTNLMlhVSjkvRXZZcERIRWhvOHNGU2RXdllJ?=
 =?utf-8?B?QTJEWEtlaE0wQXFiSnR6aUhUS2lRSTU5Y1A5Nmc3NnlnaDFFM1F2V0crWjJ4?=
 =?utf-8?Q?mXU18qzKb0GdLaoIWE4JtI2KnajZe//6JdnSpA9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0dBZ3VkMnE1ak9CVXVJVSszRUc3Mi9EQmF6cVBGV2gwSTlVNGJIUG5OUjNl?=
 =?utf-8?B?cm50YlVoMmxFNWoyODVEN3JNb3hKZjJoN3VjZEg4YWpVZ1pxOHFMYUhGbld4?=
 =?utf-8?B?bVhzNlZoYUJnVGhoK3hUaEZGTnRtOXlvNWh3ZmU0ZHFGQ3ZBcjlHdGdQMjJs?=
 =?utf-8?B?MXpXUngzeEZmOWp5dVRBVU5FYkhqUElDRitTeGNyKzVmTFRpUEZmZFJFL3V6?=
 =?utf-8?B?L2dQMTBzN3plaVB3VlNYTWpvRzVOQllDeVRndjh2bVdaOHY2NWZqTVlBMWlh?=
 =?utf-8?B?Um9pSVluQUpCdDNDZmk0QlU0aXZLL2FrTXBCdVpwZHhxT1RvRnFrQnVnL1FT?=
 =?utf-8?B?RUFjbklhZHB4Nm5IV2JFWTRVSXcxckxodXFTVnoyR3ZhMGg1Z3crbHVmWkZB?=
 =?utf-8?B?enF4RWRzQXlkUmZnNlRBZmMwSTlreTZ1SmpxOUFlUzQ2NWorSVRvNTRiTE9Z?=
 =?utf-8?B?STlzOXoyWjJvQ2pDNWNDZU5MS0ZTRmQ4OWVMY0VNTGJycTdaM1pSRTRGL1U3?=
 =?utf-8?B?aVJIQkFNTkRsUFlQREZ6a1pyd3pWS2hzY0FSK04ycU1PV2hLNWVsWkVtZk1V?=
 =?utf-8?B?S2Z5TmlYTC9IL3d3U2thUDVrbXU2cE1ZbEUvMnFFQzhrY2ZsZFdIRWpPcGli?=
 =?utf-8?B?emlKSGtUQm9iYTlTWnRuL0hpaXFrOGxiM3ZYd3g5c2tmNk11R0ZiczNreXpD?=
 =?utf-8?B?MFNIYndHaFJZY1hQVExzaHd3bWVZVXFQcmlFd045MVZTQ3VWN004dytmaWNP?=
 =?utf-8?B?STBCTHZQTVNEczlnZm9rdk00Z0ZKS2hwL2ZQODM2QWxSeFQ1UlNXZ0lvNHJn?=
 =?utf-8?B?Zng3bkF4bXRZemdJU2o4VFNwMGE3ZktWWHI5bnZFR1lkb29NSzRpSUsrczZp?=
 =?utf-8?B?QkJYMmVCcEV3b3IwN3ZpaHIzYU1QMmUyeldDWWY4enZRSXR5UkNpTENwTzE1?=
 =?utf-8?B?VTM4ZklEVTdrVGJPZmRlYTNTbzc2bzNwRlRhYWMvOXg0RW9oSitLT2lqdERo?=
 =?utf-8?B?M1BPdGhsa0tsbldSbGRUVVNKaWZFZ2NybTYyT0hseEQ0SlA4MkJQSE1pUVFL?=
 =?utf-8?B?TGlSZGhvd1loMmdBcG1mTUgzNTh5QTFUcDVDOFZ3QS9CWU1SeCtiSkwwWk1n?=
 =?utf-8?B?RTV0MWRkNVJ2ZTY5SSt5YjFkclFvbzdBc1hkZTJWZmR6Z2NiVzdxbHd5aUl1?=
 =?utf-8?B?YzhZWFlBQnlTZFBDa1NGclZTbEJrdDFQRWpJNGoxdFFDSWdKNHFnaTd3V3hR?=
 =?utf-8?B?aDg1RGZQbElIdURBM1RmOVdzS0oyRHkzTWlvdHlJK0RmNTA5NktVS3Vwdita?=
 =?utf-8?B?ZmRVaHc1UXdmbk9RRi9rOHRMamN2eklnUmFlQTVLVDJObW0wODFsUk9qWEpV?=
 =?utf-8?B?SlE1OHNZYjFJWjV1eGx2TFZZeXdGRXl2c3Q1SStOT1BSeHpxTC81UEhuZTli?=
 =?utf-8?B?S3JnRTFXQTZpckg0S1phOU5VZGVZb0tsQmlTeWhiOG5YOGhUM2w2SmJxUlNl?=
 =?utf-8?B?TDRYQkZxczRRMENWN3BIdU5EZVluUmxTcW1ZUlA3Wm1Wak90bkpVOFNLU2hZ?=
 =?utf-8?B?ZEc0VWRuZkpJci84V1ZsaVl4ZXlGdVlLWFhhNDdhZVRQUUJaN0IrcXRzSDlG?=
 =?utf-8?B?eldEVUZwelNCNFlwU0F5eVF4NHJPTndmbnA5L3lqWDRNZU5sTUxXbzQwMjFx?=
 =?utf-8?B?NXgrWkNnYlJ0UUNjWUkvTTA1UlNZYWV0a1VlejRTNW1QTVFzOHhyKzZ4bS8y?=
 =?utf-8?B?VWROQlNXV0NLdGxrUFM5eXZhQTBjVEVMTFBpMmpYa3IrVnNTNmdRZTBsZ1hQ?=
 =?utf-8?B?R25Nc2d6UEdWTzcvK0h6K0JhUE5ibnBTQWttYnIrZHZoQk8xMStxdkdPWTNa?=
 =?utf-8?B?cEt3QUZHRkFFWHdVUTdnVmVHSGV0QlJDSVhGd0RGM3NtOW9LUGR6dldRd1Fz?=
 =?utf-8?B?djhOVUpLTkx0eklHSEpFMVM0bHB6S2g1VG9zOWt3bFlFQU5OaUlvaXRLanZP?=
 =?utf-8?B?V1dHdnVXNXhzU21ycE04NjhXRnBqMVRJQkdmUWRQc0ppRzJiM255VlV0aGg2?=
 =?utf-8?B?VXNjYVYvY3hMVm0zYW1lUDVIUSs5aysyckpJTXdUclJIZU1MVGEwVjVUazZN?=
 =?utf-8?Q?A01Yt+PUJZjC95M3uvQOnih2Y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab88d13-663b-4dfa-68a5-08dcf15b9951
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2024 23:04:50.0798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AP+g9d/Otj8pn1JO8ZAhpBGrdv7k7IwRH0X0m9fSxJiw998yzPa8/Ohq2jf7B4ak4kvCqdpTlxyFj+qACjGrEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7317


John Hubbard <jhubbard@nvidia.com> writes:

> On 10/18/24 12:47 AM, David Hildenbrand wrote:
>> On 18.10.24 03:17, John Hubbard wrote:

[...]

> And actually this whole thing of "pin the pages, just for a short time, e=
ven
> though you're not allowed to" is partly why this area is so entertaining.

I'm looking at your v3 but as an aside I disagree with this
statement. AFAIK you're always allowed to pin the pages for a short time
(ie. !FOLL_LONGTERM), or did I misunderstand your comment?

>> diff --git a/mm/gup.c b/mm/gup.c
>> index a82890b46a36..81fc8314e687 100644
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -2403,8 +2403,9 @@ static int migrate_longterm_unpinnable_folios(
>>  =C2=A0 * -EAGAIN. The caller should re-pin the entire range with
>> FOLL_PIN and then
>>  =C2=A0 * call this routine again.
>>  =C2=A0 *
>> - * If an error other than -EAGAIN occurs, this indicates a
>> migration failure.
>> - * The caller should give up, and propagate the error back up the
>> call stack.
>> + * If an error occurs, all folios are unpinned. If an error other than
>> + * -EAGAIN occurs, this indicates a migration failure. The caller
>> should give
>> + * up, and propagate the error back up the call stack.
>>  =C2=A0 *
>>  =C2=A0 * If everything is OK and all folios in the range are allowed to
>> be pinned,
>>  =C2=A0 * then this routine leaves all folios pinned and returns zero fo=
r
>> success.
>> @@ -2437,8 +2438,10 @@ static long
>> check_and_migrate_movable_pages(unsigned long nr_pages,
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 long i, ret;
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 folios =3D kmalloc_array(nr_=
pages, sizeof(*folios),
>> GFP_KERNEL);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!folios)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!folios) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 unpin_user_pages(pages, nr_pages);
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < nr_pages; =
i++)
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 folios[i] =3D page_folio(pages[i]);
>> Then, check_and_migrate_movable_pages() will never return with an
>> error and
>> having folios pinned.
>> If check_and_migrate_movable_pages() ->
>> check_and_migrate_movable_folios()
>> returns "0", all folios remain pinned an no harm is done.
>> Consequently, I think patch #2 is not really required, because it
>> doesn't
>> perform the temporary allocation that could fail with -ENOMEM.
>>=20
>
> Yes!
>
>> Sorry for taking a closer look only now ...
>>=20
>
> It's all still in review, so the timing is perfectly fine. I really
> appreciate the closer look, it's definitely making things better.
>
>
> thanks,


