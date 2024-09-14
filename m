Return-Path: <linux-kernel+bounces-329506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2320979226
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 18:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9759E284074
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 16:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872B81D0DE6;
	Sat, 14 Sep 2024 16:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="iSOWFWpV"
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2093.outbound.protection.outlook.com [40.107.121.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A9D18E1F;
	Sat, 14 Sep 2024 16:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.121.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726332177; cv=fail; b=RuYxs67i+HJ3bMY0IojqykckoAHKBIOWuGJmO+ca9/A24EvDzWI3RfweNoImDDt0kz2sgjE14o4nIjkOhCffXatoeF7HAhRqU7lpb+C6uDlxq2fXyu7mcflzc22FfpGuSmgjI3gKQQcplJ1jC3j2aEHPt/YVxi/mHXawABVNzWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726332177; c=relaxed/simple;
	bh=N2wRHl5BOzGnrFkyP4QkxYXvKWhkLGj32Xji+mdhkHI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A4sTfQAGDHxARnb17C60RPPuEYB/oDqpVE88ALz5lcDbJsRLTKeDiAK3RwYaow55HNP3vGUxOsumOBL9muuv2xjYiXbJedJaTDGgBRJLUT6db0Z9C3YOCYgpOfKUh0KDEi1dBLZs0eABsn26YLOQJ2x7Cm8uJrgMqtROO54Kgc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=iSOWFWpV; arc=fail smtp.client-ip=40.107.121.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VEJy/0DOBhqmXNaQYvejKZctvb6OGzJp36ODxvQEhQ0i2HZNEef6H+Gi+wfDkugzxJBMVjQHM4PpNrEawlO0ORzBnqSw3NldGVxDKUNb5szTkiAtuPOt+yeIr8WSeS8V0RxvKlHOeQUuj0UCUxXOpqRiLmSOvpO3hJQ9EaoJK/zruqu3FgiIEmJnpgWyFfb6L5jQfK4cNUQO/Nt9O6GIZBnsDa7uSr8aIBGPjE1dusw06P/Y7mSOqYUvmtDrYZteuovOopEq2orQS7YbwtFX+zab8yQ8hfqTvTAtAwqUmv1d8jQcRee15oNdSB00uNZBmoj+tDpC9czKvEqAyWRYsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2wRHl5BOzGnrFkyP4QkxYXvKWhkLGj32Xji+mdhkHI=;
 b=e27C/DY9OU6LQLh/d7t9zb7F6LMZUhmKUpFWrq7NKsPdhhTTg5njUPMa555xP0GgepJa83vM0M7OcHyE+MJqPFMuCm1xvhOyUlm4tgI4U58zdrLfbLfKvllID/tq0sXuazpT1AcYt6RmFv9n/GPy6NMAplk9K0lxWLDEyx5t1mBS+mTfXnT5dm36bVeGQ++5kRnP/uQcJFR2tsGv6Ti/Z0XZ7TlL9sBO/4vHJ9wPkcHVFOkmuKfuBJVXjXtZxOQxh2cJtQ64Y/YbG+0lB5kN6rAPsYnLz3wvlV111cc8Gd7YOeU5kUntEcZCMH9rLSiEz/RSgfIlYddWwyLoL7+GHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2wRHl5BOzGnrFkyP4QkxYXvKWhkLGj32Xji+mdhkHI=;
 b=iSOWFWpVsWg88uEHSl/acEBnWeKkPpGHgR8cOX0fZ5S986w5R/R8BCKlubvSa2LYA3etj8dDMHX0d0tXXRFkw+CIvRWvBh8NSaMh0YFzLIHUCQIkIEHHsxYs6QuAEWgTf4YecWyWywurk/EhGc/SdOuFKMLKwE+3QdMGMJkCGP4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB1873.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:59::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.22; Sat, 14 Sep
 2024 16:42:53 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.7962.022; Sat, 14 Sep 2024
 16:42:53 +0000
Date: Sat, 14 Sep 2024 17:42:49 +0100
From: Gary Guo <gary@garyguo.net>
To: Hridesh MG <hridesh699@gmail.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, Andy
 Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, Dwaipayan Ray
 <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, Miguel
 Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson
 Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice
 Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Shuah Khan
 <skhan@linuxfoundation.org>
Subject: Re: [PATCH v3 2/2] checkpatch: warn on empty rust doc comments
Message-ID: <20240914174249.107a1533.gary@garyguo.net>
In-Reply-To: <CALiyAo=Z7SCwCRD_2rBnQrkF71q4MRyMjqJZy8iWGAuFqOmWUw@mail.gmail.com>
References: <aa1b4059dfac001945745db02b6f6d9db2e5d1cb.1726072795.git.hridesh699@gmail.com>
	<7877d23adba22e2f89a61efc129ecf1b0627510b.1726072795.git.hridesh699@gmail.com>
	<CALiyAo=Z7SCwCRD_2rBnQrkF71q4MRyMjqJZy8iWGAuFqOmWUw@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0158.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::19) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB1873:EE_
X-MS-Office365-Filtering-Correlation-Id: e615ce43-75a5-4cd0-5860-08dcd4dc4725
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?27//6ve2m62QQtEWpBG+2seh/aAsMbF7v0JB5f0SKGE3/VGJlYib8tMOXnFi?=
 =?us-ascii?Q?xpoGnRxh2BNih3kVTgFHVk9KXLCAshLaXF5yktXvk6YDy1Z0BMVBB2ch7SNB?=
 =?us-ascii?Q?C5NgdnQBnKJYu1yATLFX8kbUv9T15eXAfmXWTs+kVIQx6Kf1Olx0V7Wr5jS8?=
 =?us-ascii?Q?h4PlJ/P84nwXSXvHZ1kxWxwi4pFE5JiDMJc8j2Ce3sp9rE9nCo16tA3kQ4y0?=
 =?us-ascii?Q?5yTVNVaBESgpcHO4SF/nQOS1/epAsus2vs1uo2EhxynStYW8w9DNqbgb2Uvl?=
 =?us-ascii?Q?IYTq/oPCtDaRq5PH4O2dubkwbQJUn1BLuL4nquZO7p18b7YHrrGl8gWjGw09?=
 =?us-ascii?Q?l6Lnx4Mv+d0c8wAHCnOqSoqkWw3kad1SKLJHwutoeoUpLHJiQqho8Et9KlyH?=
 =?us-ascii?Q?bORnan5KF5Af3oiOW94k+KUrCLzMe5kFMjacZIhKGueRmi4erAMWXU1GH28q?=
 =?us-ascii?Q?LL3O8TrXKu8y3BIQL00Sg+Y3VsGvewIXQpLFcKgkru1o0OoeNVsJ4voVIhep?=
 =?us-ascii?Q?FT+VknIAEFMt71NIOyqfa3opzkXdhMRxYZhWX/49SvGnPjkWFaSE5w/CqpRH?=
 =?us-ascii?Q?1Z0nHLGjPWa9Cx6x6N8SbbGS6E1KbnQaqOmaDlr+3F8qaG3c+6M7T67F4wuN?=
 =?us-ascii?Q?0r1bQegT1DnfMArZ8QQUCj80p3CmHu8uYaQR9MbS2cGJfkQPnKMzkI8t+cY8?=
 =?us-ascii?Q?79DBvYcXAF2FthPiDIiqci+KuBmUAstt8vEXHYqsBcLjSIFdN2vtfV5lC9oW?=
 =?us-ascii?Q?T459NJc1IRW7caF22JavzSCw6KI9w5PhTvyZKsP+yUBXo0Am0AOO6p8PLi6a?=
 =?us-ascii?Q?i7pIsWn64feLZeyuLyHV/fgOKJyAyXRzjSx/+soz9wnrJ618eZpG77lQ8X+E?=
 =?us-ascii?Q?s6MG2A8OU773Wk98EjjyZknBbU2T8m7Kq2dPZq+dI19sD7NMKJvZ3K8Ob1oy?=
 =?us-ascii?Q?fDOzlXQgSVg3e6InETA2rddjihQCFFbiRQK8vZ0LLyzRSD+P8ZPLPlRZ8IdC?=
 =?us-ascii?Q?NrVxx/gSLNoy74cCoBu/qyTIymT8XAmCQMSm2Msc1W1xnjh20263MX1XMeGf?=
 =?us-ascii?Q?x84xnns8cNLKXJdOREqQgkb3yoViRv2PQJhwyLSAtcSOXmXiSGdXO0ZtYkLV?=
 =?us-ascii?Q?ccrccmKfuvs0DflKtJP4wf/HPp1zGsgjTcs4CSdyhOTizmbKqo3gdU18vMBH?=
 =?us-ascii?Q?atO7Zb8w6afFYqtJGtj/A+WmuuPC6XweccRLWpQqlt/qeAPEtJ8MzRE9Pyjo?=
 =?us-ascii?Q?P5UjWh/mOmqgVeBzgTpQZ+tKVeUvIrChVPZmG0lYaxujUeZX2t7mHQ5Yn9Pg?=
 =?us-ascii?Q?fWmZLWB8u/Qhgv8f0OrhhWCpWxU/FNuRQLotjChlvBEc6A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wbAZFR0206rt4s5p3PKeKfBayCm2mFiwCDAP6z2lmZl/s9JfzjTuT4Vwf7TQ?=
 =?us-ascii?Q?C98Sgp1cJETVhtdMpDTBLbTWrg5P+yXJRSQWW15BC0jY2vU89WpKn3Z0OtBp?=
 =?us-ascii?Q?rx6YGM7MnL9v6jiIDUKxg7x442wD8DlRYCBVJ57l4szuCp0NhhwLrOU5VEoB?=
 =?us-ascii?Q?0E9vHkK9vROVbKX9UthPqOzSVMRXilSW3H5Is3DdLYhPUe54GYqybpI/KMJ5?=
 =?us-ascii?Q?Av7pw3tXlVBsyGQm6uBDY+rBr3duUclgHuY0hZlkcAMoP4Pz1oEclEfCW/sj?=
 =?us-ascii?Q?KL1zIooPIwoMlIPpui7YK/YvtMX7jMj3G3kY8wcjzICtuSh0B4JXyNlhcli5?=
 =?us-ascii?Q?KSZMkyb9uDQBu6uEQNSgZF3vRqScAVrbx8W1P8IaB7n5b5mwzSfUqG7ng4ZC?=
 =?us-ascii?Q?W9SkIr8rs9QuX012q6mVDCS4M3ci8wq4cFSRZti6VfugtOJ902qcBmJ26L5B?=
 =?us-ascii?Q?en3DRl2Xw2kULXExQBWjRGE73F4UrSUUS++m3rw0+4VGPgqJUQBxqpr1ASV5?=
 =?us-ascii?Q?SooK/ZGIZmoWGvU3TICcV+lkeJnRdHwlpzO1dPwNLM1DJyemMsSlPG6MbGHA?=
 =?us-ascii?Q?Zcfy9Q/p7wqp2qGUd3K/743XgOiLpYd1C7jEQroynp2CJ8cPTbFi2WyjXwrU?=
 =?us-ascii?Q?mW1FA3Lb95k/pe1j0Fn651POjfPYTG1vM/f/jVnOETb4hsnjpcHxAJ0GY/r7?=
 =?us-ascii?Q?G/JJWurgfUWI8tF1lyUyzhcDp43ZGbZVf0QhaKKOi9SnOF6KKplVfhd4s6ft?=
 =?us-ascii?Q?NdDTIwjS+3uvNFwrluDAgoCophBN6EcgFNJ0z33GSq5CDVE3TUOTQOdN84qF?=
 =?us-ascii?Q?YaVeoQDV5i73/0/hNZ8BpCZHwh8IBZDk1/UMN+dq1ZLG76sU9dBjvP7HVoy4?=
 =?us-ascii?Q?LGTR30F5hUMUdrJJIpab/TOuUy6FM0j0xce4HxCgvRFXs5N5D2RS3SryRi2O?=
 =?us-ascii?Q?nJiELquVh/iAbaqAyC6qI2INKXsP7TrLL0nQsxqjH5VMk5mOQiqy+csBwtfe?=
 =?us-ascii?Q?q+FdBg+0lQO8yy6eWmHwIaeMP+SQzhHJHcVYHWS9K1ltCy23lTs/AH3QN1iQ?=
 =?us-ascii?Q?pJ3c6SouvpqYU/7daiV5YocFaxX+jJp7p6Yc7xOv3aGJDoUg+Lvin2tE4TdC?=
 =?us-ascii?Q?WXKX5YLUkb6JdzEIosdFIQ8EaP+zUncFBanG8woCCe0VnKlkUUsxRGelsiDP?=
 =?us-ascii?Q?DgmweiLh1KZvOutWrj7nVrj/8jSd30qgxH8tWyCd1slMf+b1bhjnmEgX+I5p?=
 =?us-ascii?Q?S4gseaOiEqUuPAGDiKc1pRqh2ZL7fsS3P+4vTV3rHfmD42+Px4HdnnoT2rNc?=
 =?us-ascii?Q?OPLc73B7bGxn6C2cYXi7Lu45Vr+nvzgkgR4lNdhyNdiirxGfwuaqHk4XAOUZ?=
 =?us-ascii?Q?cdO6wNi1sqVe2U1dH50uzfzZ5vtaXe5WGBwCq78jvGNOS5bQPuNv/DImKxzK?=
 =?us-ascii?Q?DzG1PF6aOkgFjDWbRSupslVkvl8ljexnAz4X/33H/+2DfOz+GUvTY2va0Zga?=
 =?us-ascii?Q?+BbolYL5eWN30wiPV6QTTsuuujKOEDbG1US5wpUDuMpKbWEk2L+KHTi8vHot?=
 =?us-ascii?Q?YKTBXgjevJaE8AlAKyzIQj5v/fccSd7Jugsc6OSRwfXK6ERHjlfeEuQfsc2O?=
 =?us-ascii?Q?mQ=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e615ce43-75a5-4cd0-5860-08dcd4dc4725
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2024 16:42:53.2602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mrl6wjxGijocLRuk9qRoPZmTrmJwmueE/GRQ1XdLJDsf4HEhMgAXMNN4HQ5ndfPEILq1QbfFcnho68BMwJPPtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB1873

On Sat, 14 Sep 2024 21:01:24 +0530
Hridesh MG <hridesh699@gmail.com> wrote:

> Ah, sorry. I did not intend to post this version as a reply to the
> previous thread, I wrongly assumed that editing the patch manually
> wouldn't have side effects. Should I post it again or is this fine?

I don't know what happened, somehow in my email client I saw the old
replies to your v2 patch becomes reply to your v3 patch.

Did you somehow reuse Message-ID between v3 and v2? Not sure how that's
supposed to happen...

Best,
Gary

