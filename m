Return-Path: <linux-kernel+bounces-229699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A729172E9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 23:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CA062841BD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 21:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2775017D36B;
	Tue, 25 Jun 2024 21:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="aFSspb/t"
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01olkn2082.outbound.protection.outlook.com [40.92.112.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DF717C211
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 21:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.112.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719349507; cv=fail; b=rx5k7b4UyYnfYfbmCbv0ZJ4xtlnmCuAeywBqr8E/9N3TexD1ZH18gf2XWEgZjyaeq6JhLJ0At9kYWCqegjwCWwsHn1Clhoaw8ZEgq/2EClLWPlb1lrureBuU+/M+nePvehvs5BJi9BzRQ3XmZlDUlt33ZkMgD7X1NRb1O/tcM1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719349507; c=relaxed/simple;
	bh=53f6Qh+KCMEG4/e7vhrxdtGI/BiMj4CVM5Y3iXUVRnc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HPXf91g+Ha5lIgpe7lRPitEmWvORw42elV6To5cU+MqEjZXp9qeGT6epyMW4dqzVwuwvHMDOedXvenb6OpQvlCjaY+oMTqbqSCjdZV0ZPbey7LD+6Wpj6RIEY9lTqESI9UKkMkzeoyHyn84QGlBkKzd3Z9AkdzpCMFQryAN0/Ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=aFSspb/t; arc=fail smtp.client-ip=40.92.112.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QhVCE52AieZUMr9YLdzbSTDafQtTDB/s8K0YTpJ0cLwTyksaghLHLXYC1N9EZLxAJbeu+h/+c7f4dhxrkuM1wFhJidoV12BPVaOKO3CZuI497skvRz4a/O444BlYQlA2IaQ06la3Vh4j8fgHH6Wm2/AVtIZFkapRVoV54z0HnM/ztjB1g2Uh+LJK6YWJKFAnKh1XY0LTp5d++3npatT6U+aApSBZKzLsrxU+szHj3bafXBkXKSxsScLjrou/r1suoB5JgnW88WGZypznyHxTZUAcGY4oQVOfRr40cGDqBEavmzmewANET35AiytMUqnldkC30EKQyC1eAo1yedFREA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=53f6Qh+KCMEG4/e7vhrxdtGI/BiMj4CVM5Y3iXUVRnc=;
 b=QqLVud8GxXYCnXdEXfL8uwJ5zJuX1KdzEBCLOnnBdj4maVvMHEHNduOIvoSHZhVVgqNWylr0sceEv1Fc28lHFGapibC1pqJBq0OkfXZeqpPq8JDYM9W9+aovoYFZnI5XT3uTcVFFEP0J+UOwmNGFGjgRLP0fmn0FpJVyriX5D3ouJjDCuIjGlknPLtouY+DRjSOkyJKx3nGPDlS/mAt53V3pa7viObIn+G3lgJ1yR1OC/d/+BODyInnICCQak2jA1Nx9w0ZJq+wFfAJsb/jCgJS+3ksISHLFTXXVuM8tdqpJrpyW6Jxw45x2155t5ccryZvPYDXAqQ+Z14iWo+e+cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53f6Qh+KCMEG4/e7vhrxdtGI/BiMj4CVM5Y3iXUVRnc=;
 b=aFSspb/tD+QpChvXnzMpVXkVq4XVI2izH33A48Kl3D8i7s0o80g6Gi11QZ0uMaqWwIm2cy89A8F4riutKnjmh0P/8mGifce9iUBHhG53RL/LMh3+fZ15VbHDDuJKOVXYZXyypVXkREHSUuRjyX7soD8kabNwaJvNCQpCwV3NzwaoiAjdkTMkYjtzTmx89G4pl3mEjlOC+SXZqVZr0J1HNLA+T4JxX4b7v9ZUR/JC80TBoOJ3rbTtzjJk+eVcEF1Rh/yRP9gClRNCntav/ZkGv1GgF1a9COHz3kLiU7jlCQyCqJ/y+vb+xvqhPvAzds3ci7U05n8j5XYLkJ/wfNQmfw==
Received: from LO0P265MB6518.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2cf::9)
 by LO2P265MB6312.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:257::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Tue, 25 Jun
 2024 21:05:02 +0000
Received: from LO0P265MB6518.GBRP265.PROD.OUTLOOK.COM
 ([fe80::8417:bf6f:285b:4bd5]) by LO0P265MB6518.GBRP265.PROD.OUTLOOK.COM
 ([fe80::8417:bf6f:285b:4bd5%6]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 21:05:02 +0000
Message-ID:
 <LO0P265MB651875F5320919502439F19CFDD52@LO0P265MB6518.GBRP265.PROD.OUTLOOK.COM>
Subject: Re: [PATCH] Staging: rtl8192e: rtllib_rx: fixed alignment
From: Yusef Aslam <yuzi54780@outlook.com>
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Tue, 25 Jun 2024 22:05:01 +0100
In-Reply-To: <b3d9f694-77c4-45f4-a436-c00a7d6df61a@gmail.com>
References:
 <CWLP265MB651697C43A8A396DE8989CD8FDD52@CWLP265MB6516.GBRP265.PROD.OUTLOOK.COM>
	 <b3d9f694-77c4-45f4-a436-c00a7d6df61a@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
X-TMN: [InfJygLaKURmPFPCofFBIb1IhfMbpwgt]
X-ClientProxiedBy: LO2P265CA0439.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::19) To LO0P265MB6518.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2cf::9)
X-Microsoft-Original-Message-ID:
 <9c839971e9d054a2b269eeffd80849db1553e636.camel@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO0P265MB6518:EE_|LO2P265MB6312:EE_
X-MS-Office365-Filtering-Correlation-Id: 27e041fa-b176-456c-642d-08dc955a7b18
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199026|440099026|3412199023|4302099011|1602099010;
X-Microsoft-Antispam-Message-Info:
	8kIdGo6JMNrIFRKJlKokotuD0rSeyGWem6nQYYCHIwYo6kC4F02EUGjgxa87Q/oT/jdIQnuFd0L+gkxK7EutWYldcUoi4211wN8FtMaTONQXxT3oZ5A+Hf5Op1UF8XXtLExT6AgRY/hdER2XMPhulLmkJ50FLl96pjCS4390qTGYBSP7bJ9A26zMiKOeAXjy1+3psE3dZS7016Y3naBgxY0W+4X/Uu9USrC6sLK7UKCabO+OUsVMmT8ID1vS6ns9XqMJZRNo1tRjYnKyuPACIqMWeZ+QtNuxT0ShlO6yPj9hHIyjqUywiFs35kwqoOH9T/EAjHqWboz5zGc3tXmEqnxT3FKl15JeSYGLClypAJjw7HOQifj+QSfWX2RozLB5wT7HtPLUFY0Ifw9sBHN74kCw66hs0KxmrKjKzSKRvRfIXcfOwYH15+Xe+OCpQXsONhm6rF9hpGFoY3hwaCOOOksu5cwLDzxHzKsl5I90dIuXzOZXrVJFU6vbY7v8P2ePKobO2paJJSdjw+SBhDbFS4zpgEMLCyKlaGIdrBTu/vhcrYqj6rlq91GcBzo5ABX9QdZBuc6nPGI/XmJrpohkN7baECmrFuhaH25+pGkzFGsSUnkH50hX53EMC0CUyetc9HDWSwkAJAQpCQG75T0rIld3Omm9/RoOMNayHXeULPNrYBDQM6u1YzJQLg9CYdkX
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MDVnV0dFejlCSk9wd3RiNDBwbWNWUDFGWFgybGsxNno2MVUvazgvTnplYzBj?=
 =?utf-8?B?QXcwSlB2eUhhNEhybjdSQktodjBuVTNUKzVyOVJ3YlU0SmlQQ2RYVW81QjVi?=
 =?utf-8?B?dXBFQmVHVFUwL3FvQS8vREZWV1pKSjFwMm5NT2kwZHVhdDhZRnkwNTBHUEVs?=
 =?utf-8?B?RW41bTB3OHB0UUQ0Z0EvaXUwUjlJUExVSy93NWwrYUxNVStQQ0RVTXpVZWRU?=
 =?utf-8?B?bTRPZ3NqeUx2am1CRXhVeXVna3VZWEN3eDNrb1hnSjVpVlZxU2lhaHdUVHFm?=
 =?utf-8?B?c1ozR1Z4YkJwV25sd0ttVjFHdzB0aTFEaGhlcENCQWwxMjJBeWZOSkpiNzc2?=
 =?utf-8?B?d2hVeE1kZ1dvTUJPaFU2QzRXMXRGWEtNVUhCTXF4eXRxcWVkaCtwYmxqYnhy?=
 =?utf-8?B?MGlvdksxZlFBUE50YzRCM2hsZVRRVWJ2elVPVUxMWEhISTJIUFEwTmk5Ym82?=
 =?utf-8?B?aFVVMDlnVGdGUWhvVCtmWGpkS0Qzb2xUL3hSaFJmU3dJV0dMOHBadngwdUdk?=
 =?utf-8?B?bCtSbE9SMnUzNk5zc09wby8vRkNEZ21rTEFCVHRDV1VQV3dvWm5zdVZqT211?=
 =?utf-8?B?RmZCN0MvRzJYNHJ4Y0xQZWdZQUYwaHMzWE9ETGVOTU5FUDk1MEZFR0FzdmNm?=
 =?utf-8?B?WXJ4OFhKanhhUXR1YlJKVHQzQktkSUs3Vm9TN2xhaTU3NW9UUHlMS3Vka0FX?=
 =?utf-8?B?QVRRQUFNVlNkZDlqQVRtMURsR3hyczViTFZZVXFkVXNSWWhuUEI2WWVxZTRQ?=
 =?utf-8?B?WGVJMkY2cHFLbkRZMHRGeHFLb1lSeXFjRzI0elpTNHJ5WGozWnYySk5LSnQ0?=
 =?utf-8?B?QU9GWUVCQnkrU1JTalAycjBvNFRpRU5tZURnelp6bWR4NWFVZlJQL2szTm9I?=
 =?utf-8?B?NjNUaE1SWjlveHdlNlh3TGlBYnZSc1BhMW8vcmI2enJCalNCOS80eDIvWnZX?=
 =?utf-8?B?NEFqZFpLUkFwWnkyVlU1TkYyZXhyRFR0VDdmYnJFMm9CbHVKTmhwVll3TE5o?=
 =?utf-8?B?YVJ3L05jWElldzBTekVPK1ZwVkNWQkhma0J0ay9NbEd4UlFMdlBvRUMyc2cx?=
 =?utf-8?B?OER4emxTcE14RnpQTm84VmxldmVKem81M1lrWHlac2hENFlQeUQxeE10dzN3?=
 =?utf-8?B?M1k4L1dmMzFkVXVkMFJYNjFOVURheSt1N2JicnBnZmVIM250ckVSYXNtNmRk?=
 =?utf-8?B?bjNYcm5nTEg5MW1xUlZXT1hSK2R5M0MySjlRdlh6SlE5RXFvZ09IMi9LbjQz?=
 =?utf-8?B?OTlvY0pFSzBrYlF0VysyNXVjYUJuSGRUcjNIUzZvckptRFQwU1EwQVZFZWF0?=
 =?utf-8?B?MURJdXJCNXM2aUM5anJFYStKYmE2WW9BeFF4SlY3T3VFaERyV3UvODZEbUQ2?=
 =?utf-8?B?Z2tkeUF2bUppTmNwV1BPeXlLMzVnUXYyclJTQ2FlcG01Znk5d2dOZXVLUkNB?=
 =?utf-8?B?UWpiVTVtUkt2ak92VnlINkJjU1VobXM1WU1ON0xoTWIySTMvOUFxcUZ6QUYy?=
 =?utf-8?B?RW4rVzZYTnArbFRmZ1RLTW5YeHVoalNKMEpqNlBlbG83eEh3S0NUc2lGNlMy?=
 =?utf-8?B?SmI3U1dBN0M0VExlUlNDbXRLMmZEVUNWemZOeXFTaUhHNU1hRFAvVkp0VGt4?=
 =?utf-8?Q?EghCGJ8DYUcCJQm/MvT+Mh5XjFWo9mflOZmChQPVDXcQ=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e041fa-b176-456c-642d-08dc955a7b18
X-MS-Exchange-CrossTenant-AuthSource: LO0P265MB6518.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 21:05:02.6397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB6312

On Tue, 2024-06-25 at 22:45 +0200, Philipp Hortmann wrote:
> Hi Yusef,

Hi.

> OK the emailaddress of greg was wrong. But you cannot just resend.
> You=20
> need to make a change history.

Ok thank you, I did not know this.

> If you send in a third version of this patch please use a change=20
> history. Description from Dan under:
> https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/
>=20
> Your next patch will be a v3 as this was v2.

Ok thanks for the link, will follow the advice.

