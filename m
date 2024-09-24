Return-Path: <linux-kernel+bounces-337577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F4E984BDD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 21:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35ECC1C228E4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 19:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B007113AD05;
	Tue, 24 Sep 2024 19:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="XTZ4uZKg"
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2095.outbound.protection.outlook.com [40.107.121.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAEC12C530;
	Tue, 24 Sep 2024 19:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.121.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727207924; cv=fail; b=rSEaWtVbsj47QCFL+/ZtUI2Z0jynyM2ha7e6hsIckTkuc1hoPKOst7BhEcqIgGJQDAEz/tQ9YSHbR8FfTD3WjGmc4KDUAxvhvq75G8v2ypDXrWYiCRjmexQDK51x9JaGdgOW2mYlrhZHYHc9QronEhxpgDhBmGcGXWSGQnHYipI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727207924; c=relaxed/simple;
	bh=QaSKx08ZNcixAbl2KyYjuou9PuN4RWQSAIqOV0M0uYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PfZ8T0HCegYkBJz6lxQAHI6JixlQmNB4NP5AVchhIWRQVDlAMjmG11mVwMEFRK323xj8jF2eVJMbHLyZ9pEIeFYJCWDib0/zgJsRKBNpqNv3vYSwUua5kwdB252edERdmM8jzQ5Cl8mCvzrQyMtpkspQbfIemDaeQ63JzXmn6ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=XTZ4uZKg; arc=fail smtp.client-ip=40.107.121.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hv58U0kAoEmaAgr/+Q6NEf2pjpbIIGsA+YFeQ00SRc+XjaM9r7RXZVKwciPDD/AbwfxrIq6Y+ro2lySVmmC/Eb//eEwIj0VZYUiwKZpzuUCc5z5BtuyGZMnqGoV4u7hvb1On6YQ6HPnIgshwQimB9raxYV8nnq4M+3m6ha2k6OlwmekG+3S+xfIYt7hN/usMZ9VKSi0VwijYxsfHbeIe9zhAJJJXqIPPiVGKtjZ5qL2dkGAnfnYFcGrYbOcb4x8o0SEpTvP8QyV1vCAVGq1CEJoV6m7khGfZJhe/99wv34mQxHHR4o2S9jCd+rDagksiXanyRuqKfjWoHCt2EW5gBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pf/hi+UKSLJV6qNvnJMnrtcLNl+pBGRIjMiUTjpDu0M=;
 b=wNUVJC405p3DGvddvY/vjkS99bP85HYfccXVvdxk/9b07yPXUQ4CTI11/7uRukFRU6A2O5zq2nVA7HOy2H6EMnzzHPQlknTHgggUJrc/z71W5RgTaAiGGCYN2+XFcu1VaujPTtULSP8JzEeDltin425+4jb+cmBnqpEMSE3PZ8ZzlpL8AMzm5A4vm35wOSnta891eIsB2L9cgMAWOImhdREm/ofKN0EsWcIp/XXBYOt9N74RKbPVmvF1PjQtTaynVj2DCBVAcfXL9tzSnvRSDCL7K14GPTLKM3juL1+OUwZW9uwpmdpUyXW8Mpwy63h9pLqyEiAkBwaNpUfHKllu6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pf/hi+UKSLJV6qNvnJMnrtcLNl+pBGRIjMiUTjpDu0M=;
 b=XTZ4uZKgHx1yBhISoIkgyYoy4MnpF97p3kdNxCC5oCoAVFaevm20nKvPLCFWlL9CglZHhJZWnk0BRAcH9pvQW+7G8gBB5ZjNoFFFsflU6us+ZuspEGA/o6iDO5eqeagoPKYn2CQuPwNAEDHfv1EbpJ97qTG00cPAWo4Q9WTXHg8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO4P265MB6822.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:34a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 19:58:39 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 19:58:39 +0000
Date: Tue, 24 Sep 2024 20:58:37 +0100
From: Gary Guo <gary@garyguo.net>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, ojeda@kernel.org,
 alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com,
 bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com,
 akpm@linux-foundation.org, daniel.almeida@collabora.com,
 faith.ekstrand@collabora.com, boris.brezillon@collabora.com,
 lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com,
 jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com,
 lyude@redhat.com, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH] rust: alloc: pass `old_layout` to `Allocator`
Message-ID: <20240924205837.78618dab.gary@garyguo.net>
In-Reply-To: <ZvK_Q0jsZ0cwnhQK@pollux>
References: <20240911225449.152928-2-dakr@kernel.org>
	<20240921153315.70860-1-dakr@kernel.org>
	<CAH5fLgievsJOe7QET+Wh2c0upygv-nhSnOuTN8K_QkruLwOPgA@mail.gmail.com>
	<20240923171315.64327fe7.gary@garyguo.net>
	<ZvK_Q0jsZ0cwnhQK@pollux>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P123CA0232.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::21) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO4P265MB6822:EE_
X-MS-Office365-Filtering-Correlation-Id: b32762ce-ede1-48ff-01e7-08dcdcd3489a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SzZEOExyak9DcE92bjB6a29KWW1hd3JDbWtGcjJkVlVPTmU1S25UckRSTXEv?=
 =?utf-8?B?QW04aU1zTjQrZEZuWUhFM3BWZjBsQ0E0UWxVNDhQSGRBYmt5TTNoRHpCNmhW?=
 =?utf-8?B?TzZsd01yaSt2SWswSWhRdkxLNXpIeXZmL3NhUXhLeTI1dE5rOS9icDNKTjda?=
 =?utf-8?B?bWJIRzh4MjZUenpKdnUrS05zcnVoT2xjbi9DQ24yWitCemw2cEFiK3NMTDc0?=
 =?utf-8?B?eW5JMlRlbmZOQ004c1J4VlA5K09PNVVwaU93bHNQSjlXOFVyR3JTOWVPZkJH?=
 =?utf-8?B?OUpFTUFoYk44R2RqWTNlWU9VN0lmQWR5Y1hPNW05Q0Z4Zzd4NEJLSzdWVXhh?=
 =?utf-8?B?SW5SSWQwMiswK0huaG94QUVqZ1lFeGNYQldlU1hRZXNISkdBaDJOU0FGdzcv?=
 =?utf-8?B?dnZ5WDN3V0EzVTcyOEROanNmSEpnMDhiTVNTZHhZRW1KcHdGbWJ1VmNHQzQv?=
 =?utf-8?B?c3NxTU85ZTZYRXAyN3VCWFZESVZJa0ExTUYvbG5ZVXQwbmpUbHhaYVJjSjVo?=
 =?utf-8?B?ZDBwOUY3M1gyM0lQb3J3QmlNd20rM24wcHJDWkhQTjRZN2JQNmk1UlJabjQ5?=
 =?utf-8?B?VmNjZGVHdHdZN0d0NDNwb0VzcjBCeGF1TEVmUjJCaFlPRktsT29rM1A1QUlQ?=
 =?utf-8?B?MVoyM2lJMlVNMEdrSGlUWjNMR2YyUVdIWDlsWFJ0NlFJQ3JENTA0WmZrcXNn?=
 =?utf-8?B?L0lKRWI2UDhSS1R1eldQVmRuZHpiejBRbkJFOUVRQUIvTHVMdytpMWxORnlK?=
 =?utf-8?B?RFFEa0dlQzFjSCtHckh6TjRoUTg4WnVVeFNHZmc4THRINnJDdXR0cDNHaE15?=
 =?utf-8?B?N1BJWmdZL1FYdU1WenJyK2ZpcXFmNEc4YlZuVUJQTlM5ZEtnTWFVNlZjNmRj?=
 =?utf-8?B?RkhXL0JwU1ZkVEk2dm5QNDF5VStIZFhXL2FHeHpXRmxTZGR2cUVYekdIZjU1?=
 =?utf-8?B?bVNrSG5UbUErZXRVdTFsdWF2TWQ5V3M0cVZ1Rjc3QnpQQWd6R2JZbWQ4NE5S?=
 =?utf-8?B?LzhGd2h5T0NDdTV4Y0VVdURSVnViNmFmNzQ3U1FPOGJaQ082NTNMWlRMTFFa?=
 =?utf-8?B?UTl0VnUyOWpLUnhQM0NUQUpxUjVhbk50QUJzTHlsbjUrUGNaRFNZc3hnY2Vj?=
 =?utf-8?B?QnhVbk9jTjJKNTNJb251RW1hWFdNOXJCVDNvM29Yc1hHVzY0b21SdDJyTHg1?=
 =?utf-8?B?U0JCUko5UFRTUUNid3FnTlhXTllnWGZYTjlhSjArUElwTHBBU1lRcFQxOHhz?=
 =?utf-8?B?RGEwTFkzekczZm0zcTNOamNOZHB6VXd5TUpFcFRxNFJ0STJCdE15cEJ5QXA3?=
 =?utf-8?B?WjlGK3A4QUlja08zY0VScUFsY1pUSFZRazNGSGNFZm02UEtTS3BDdG5ub01s?=
 =?utf-8?B?MUtLWXhSK3hEU2pYUmZmeExBV0xkOG9qNkhZQlBtOVZwQjNVWEw3RzBldXlK?=
 =?utf-8?B?K015Y0tla3BSTkVNeFJpZXdwN0F2c2x1TmpzcnI2allFVitMK2lHY3h5dWZX?=
 =?utf-8?B?d0ZMRVBkU2dCcythc2hiS0lOUHFxaVNJOEdiVFhZcmFKbnlRS1VjODYrbEZB?=
 =?utf-8?B?SW9wY2hnUVNlbEVyd0x2V3dhV1JxZVlsNjVxZGx2NmVCdVpIdWgzRVkrbDUy?=
 =?utf-8?B?aVdGS0VsTGNJay9IcDhXS1R2amg5d2RIZUtYQUlXOVZJT0JuV2owWHZNajFL?=
 =?utf-8?B?YVFYUXNWWHEreUl4bDlaYzJ6VEc4Y2wrWU5RSTlDa2ZMYjJEWGQ3ZEV3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGJOS1pqK3RESW41SWQ0ZzdGRVJydmdZdVByRFlSZXZyTU5vNUFyNTJMM3VE?=
 =?utf-8?B?T0FSR05xdmFUS3pRTm1JZFpmalBSMHBaYjYzMmJ3ZUlSQWtOUXN5Y2ovMGpD?=
 =?utf-8?B?MngySitCQThBd2V1UmFGaVZsa2N2Q3drRnlJZDdiU3BkczNXaDM4c1RqWHl3?=
 =?utf-8?B?VmJIWENVZFBKWWt6bFJGcjNTdldFc2VnS3VhSE1yQjRlbXpWN0I2aEZzSjdj?=
 =?utf-8?B?cEZDVFhjNWRwazE3ODRqbjJhRWU0ME80QWY3SFRmR2lnZk00TVZjMExNbjdE?=
 =?utf-8?B?UDIrM1ZTVG8zOEhmbWNHUkZHdW9NZkhVNHU0dEdUVytFZlBSUkVIYnV6aGcy?=
 =?utf-8?B?cmlWV3dWdEU2cklYaEVzRHdZczdwTEdiaXJKZXNCRUI5VzcrcjlJSkdpUGw5?=
 =?utf-8?B?WmNCMTB6NE5heFhtNS9IZERTN3dlYi9pQnlQdDBXcVN3dktRWnhvYnR6MHBZ?=
 =?utf-8?B?aTZWSG9rRTIyeUppdkNRS0dudm9WSzY0MEJFcUpuM0xabkRkQlBiTDJYRzNI?=
 =?utf-8?B?STNGcmR4c29NME1VN0hoOWM4eTlDemtZSFFvcms4SjNQQk5IeWp1TWF0Sm0v?=
 =?utf-8?B?VFd6TkQ1R0dnUDc2YlhiVUpNSzIwWmFXNEdFMi9zOXVtTTlURjhuN2NKWTFW?=
 =?utf-8?B?bkRYandBV0lPaVJ6RDhmUGhVS25ZUG9YbEJXanNOa0tiQkxURGpzWmFYVHJD?=
 =?utf-8?B?cWdXajdHaFRmb0lNVmtmYmRDZ3A5cXJQUTd3WHd1OUhuK1NSdTFoUGJSbHNV?=
 =?utf-8?B?TGJxZytJUExJYlV2Zk1PQUNNTlRpTDVVejRUM285MEdnU1FjeWVVYTdXQWhs?=
 =?utf-8?B?dWVKaVcwb3hCMXNld3dDRXdVME16WHo2aTZwS0xZTVRZV3hHVWxjQ3BDMjNJ?=
 =?utf-8?B?TW04RFhZYjVycU9VOENPYU1HOEQyWkhCQmRHdUZIRUFtajBTVXZiVURDNTN3?=
 =?utf-8?B?NlhQQ2Vjb0hlaVJoQm5mVWZBRUdZR3RBdnBNcVdhcExTbVNGMHM5ZzJhRjZm?=
 =?utf-8?B?d3IxTXFUUzlWWE8rUHZaT0pBZUtabVRRUGRXZ0dZR3ZRalhlMklKdnNiRWVS?=
 =?utf-8?B?dW1Pa20vbnF5bkhaYjI1a01IL2dMQmNzNDNsSjJqRSs0NVFBcVFEeWxGN0tw?=
 =?utf-8?B?N3VURWZsWjBrMjQ1Wm1qa0RkdWRCcXFaVFkvTUxoQ3ZUK3FpSjNmQlBtQnZV?=
 =?utf-8?B?TkJiTTNLYk1rb09sdkwxd0FkNFJRc3FIVnNqcGh5c1Y2VFRaRXhIWFVQRXRw?=
 =?utf-8?B?QXNRZ1NaUEhvK1dZbDJmV3AyMW1sbDF2ZnRGd3h0Y2hFNmtWSVAvQmtob1h5?=
 =?utf-8?B?M1c0Rmh5WXhhbXZaYVp6Umx0WDN3eXBEZnJlRUFVdjZUeUU4UTNmZXVkSVVV?=
 =?utf-8?B?UzRLdnE3MjZZY3R5RFlIdWVEZ205ZnYzSFhwRWNrR2d1c3FsLzJJaFA4RmVi?=
 =?utf-8?B?ejhDMG9iWmpYQXYvSlNYTlFqN1VOMVRNSlJLeUNTbFpOanB2WU1yNDU3NnFK?=
 =?utf-8?B?TWM3TjgzUkU5Skhadm92bkM4aVdEZFF6a1hhVExkNFc2Vmxzb0dTTjI1QTlR?=
 =?utf-8?B?TXFQdEY5VzJkVVcvc0pjcWlHK3AwL0g3QXVMNzdpTENyTU02Q0ozdlF2ZzQy?=
 =?utf-8?B?d1ZOWlo5eXVFK1h2MHkvN0hqYXM2OXphbzBkeUhMU0lsSEpWOVlHd1JZNk1j?=
 =?utf-8?B?eWJhcUZEemtsbTdkZzhENWx3ZnVsS3JYY0d3YzFnM2JsN0d2TGdUa1NoZU1p?=
 =?utf-8?B?SkhHRitQS2xvWHdCQmhHNCtJUk5ZelJLZmhuZGgwMS82ZUFIR0cwZWRRbSs1?=
 =?utf-8?B?RTVpSzJaQi9rUU5LU2NvOXRKenFNN0xadXlvbTgwcm1XZ281K2RVTmEyYlY0?=
 =?utf-8?B?c3Q4dk1FZEo3M3dIclR1dyt6YzRBSGorODFqY1cvTGl6NEkvZVhvbExSNWNr?=
 =?utf-8?B?Mk1EMmVGS2NNRzFXZllLQUxIaFNhdVFPSGRIOHpPZzZheVEwSzRXU0xJM0hw?=
 =?utf-8?B?SWM0cnBnR01mMzBCTW5ZZE11OUo2WDNPOEkzK0N4c0NXZDhXS1FwOWJzS29u?=
 =?utf-8?B?aUtidHpjR2ZLZVlPb1J3T1MyM0tCM2RROGJTZDRFd2ZlSGdqVklkdUozTHJ2?=
 =?utf-8?Q?JBeyK+kjWm15LyHmdfXVuJAgj?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b32762ce-ede1-48ff-01e7-08dcdcd3489a
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 19:58:39.5792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VA5lKVjBJR1d8D0zI3whLKLcf78nXjcz+Nzeg/Kf6E3wdAfP2H3R8DNZFOCme0k69zEpRYXog3wX06EJiAt+Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6822

On Tue, 24 Sep 2024 15:31:47 +0200
Danilo Krummrich <dakr@kernel.org> wrote:

> On Mon, Sep 23, 2024 at 05:13:15PM +0100, Gary Guo wrote:
> > On Mon, 23 Sep 2024 15:56:28 +0200
> > Alice Ryhl <aliceryhl@google.com> wrote:
> >  =20
> > > On Sat, Sep 21, 2024 at 5:33=E2=80=AFPM Danilo Krummrich <dakr@kernel=
.org> wrote: =20
> > > > @@ -84,11 +92,18 @@ unsafe fn call(
> > > >          &self,
> > > >          ptr: Option<NonNull<u8>>,
> > > >          layout: Layout,
> > > > +        old_layout: Layout,
> > > >          flags: Flags,
> > > >      ) -> Result<NonNull<[u8]>, AllocError> {
> > > >          let size =3D aligned_size(layout);
> > > >          let ptr =3D match ptr {
> > > > -            Some(ptr) =3D> ptr.as_ptr(),
> > > > +            Some(ptr) =3D> {
> > > > +                if old_layout.size() =3D=3D 0 {
> > > > +                    ptr::null()
> > > > +                } else {
> > > > +                    ptr.as_ptr()
> > > > +                }
> > > > +            }   =20
> > >=20
> > > This is making Allocator work with zero-sized types, which deviates
> > > from std. We should not do that without a reason. What is the reason?
> > >=20
> > > Alice =20
> >=20
> > As Benno said, this makes the API closer to Rust `allocator_api`
> > Allocator trait as opposed to deviation.
> >=20
> > There's one benefit of doing this (discussed with Danilo off-list),
> > which is it removes ZST special casing from caller. This RFC patch
> > simplifies `Box` handling, and if we add this line to the safety doc
> >=20
> > 	`ptr` does not need to be a pointer returned by this
> > 	allocator if the layout is zero-sized.
> >=20
> > then the `Vec` can also be simplified, removing all logics handling ZST
> > specially, except for `Vec::new()` which it forges a well-aligned
> > dangling pointer from nowhere. =20
>=20
> Partially, we still need the additional `Layout` for `Allocator::free`, w=
hich
> in `Vec::drop` and `IntoIter::drop` looks like this:
>=20
> `let layout =3D Layout::array::<T>(self.cap).unwrap();`
>=20

You can add an invariant to `Vec` that the size in bytes does not
exceed `isize::MAX` (which is already true, just not documented as
invariant), and this can be changed to `unwrap_unchecked`.

> I really dislike that this can potentially transform into `BUG()`, but th=
at's
> probably unrelated to this patch series.

