Return-Path: <linux-kernel+bounces-263310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1524293D42D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 15:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38F8B1C23448
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 13:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34E517BB1D;
	Fri, 26 Jul 2024 13:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V1LcRTqk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fIk+oX9n"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C1D23A8
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 13:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722000456; cv=fail; b=D5u7uSSDbfP02C/juLgaPAGDr2xd7mLUMjrrzsDC7qmYvJANi+DaTLGBqvEOvcpoTA0tD7xrVnGAxpdTz6HKbcLHON51lFWlaXfppoL06kD0+vXuWEW/qrwELPX84KhYdjzN9S43ONBTppiMF3r56j+o0V0ZIEUh9Ok7786Ks6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722000456; c=relaxed/simple;
	bh=7HllMQSoU2Ng7LuCEuTArlKMgpih2QXI43L46ydKtiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cbI+3l+sP5pg8yf/Scitza/bj35Oh1InoKM/GYHXC3+2VJ0ZKeIPAVbTt1tHkJpPPzAfnFMmYL9pNBVKseFDn9XzeWA867Nt/SHzbL6ync1d37c/h1JJ9pnQ0K/IEzW5vbc/aClVtwteTGbzgQoCjPlvN+OlBIZP21wWIP7m9bk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V1LcRTqk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fIk+oX9n; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46Q8tZHi022703;
	Fri, 26 Jul 2024 13:27:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=BK5NFgv0M2zzW/9
	PchXAI3ONYvtgMpMkZJxqvXnSZX0=; b=V1LcRTqks6yFytYQ16vocD2kczjcF64
	3r393uVVOeAgtT9WS43Qr6wjQA4qb8Psh5WW1IX9fxkzcf2+VItadiIceVnROri/
	bz4ai8LpwSLreKaVnj1QMQAaNbzfM2LlB0z3pOgaUu/v4PZgZePL4HNzELSDnE3e
	7R+1DTeDatUSrEaA2oIaHPk4yPu6RabHFCA8vNqqK15C9ZIOJSYHKaKOwqRqhPWx
	GIHHCccnMkExVpKQpZySH5JS0zQRdUT7Zqok40+qrB/E9VGEephJySxGk8ITUTOK
	cPXbRFDJBfTOpdzKuVQsGz1Z+sWoMtn4jvKinY00/EPOXzfRSFkpDNw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hgcrnke9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jul 2024 13:27:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46QBiJ1w022107;
	Fri, 26 Jul 2024 13:27:15 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40h27s040n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jul 2024 13:27:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HUZVGsWbdPOKdyfC+slS5R798FCvpVqrEUPY5qGklfBnXJisnEGlQJ3XGTS5TvQ9cswaygy9Cub2bG7BXv98ga2VCxzs4zxIDO6269aCP5hmQhOfpRPOmbWspNyiaTlDRbR2gwtN8iPcw2uaRkg32by0PcDM1MoVFohHi5+MqtE0oKXkn+b6zfGXbakDr+CBZjpqclfbNmTS/I8T/qgfd2Si/mEbRBYNJ4jkrV/3eZSmsPoMMDK9MqusRaUmL9cDrZCywhyB3p0TQav5MkyYDCyEPmQuo3XDOqvl1/Eh4TgRetonBX3703d33fHu5m8jYYDQfh1wCNfgjYDKj6+F/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BK5NFgv0M2zzW/9PchXAI3ONYvtgMpMkZJxqvXnSZX0=;
 b=ZfeQ38kywqrCZWZO35553N0fDgkm901bTHKXel2G89hlfm+lWYJRTNTcG/EBjhuJF6CcIw/OT31L11hmx6txDYnbhLCgaWcStioyJo/JAQaExF1IkH+8awynPbA6SBOJq9OCMHaXgcreMWIJXYSau/1kXYrPmD2qaKb8fCJvFLkByhPEGiX3IZPgXs6fvUKugglqfDJxoBsgl0fTC91TdRK9nAE3+wshRj6QSOfsiX6SedhHdt0N5VXE5CQMjV9WNqNrx/09efOtPY7WX0hT/gm8QuJhTq/b7Ssm/XUqrWsQ2acQYj2Xl5MqASwGAC8EP+Qnbvr8mDrr5WFNeHgnPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BK5NFgv0M2zzW/9PchXAI3ONYvtgMpMkZJxqvXnSZX0=;
 b=fIk+oX9nVrM2qHNA6CjhydRq5oT7N5GePsQDatcfoP5e7J5gA8yxrcGh8wJneY5PMkluKQxC9y/v5rcn83Wnw+xo5WFp1HjxABbWexsFC+NTHPNDMyg38DuXYFgHKwa+QUu4qTzumSijWgfjEHi9Ct4VhTpG33EM8kirXmkW/og=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by IA0PR10MB6891.namprd10.prod.outlook.com (2603:10b6:208:431::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Fri, 26 Jul
 2024 13:27:11 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7784.017; Fri, 26 Jul 2024
 13:27:10 +0000
Date: Fri, 26 Jul 2024 14:27:06 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Laight <David.Laight@aculab.com>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>,
        Arnd Bergmann <arnd@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        "pedro.falcato@gmail.com" <pedro.falcato@gmail.com>,
        Mateusz Guzik <mjguzik@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 4/7] minmax: Simplify signedness check
Message-ID: <f1601a08-6d6e-4074-8f86-4be7869641d8@lucifer.local>
References: <23bdb6fc8d884ceebeb6e8b8653b8cfe@AcuMS.aculab.com>
 <03601661326c4efba4e618ead15fa0e2@AcuMS.aculab.com>
 <ef130c0a-b82f-472f-8c53-f7ef4c236c44@app.fastmail.com>
 <CAHk-=wh_+muDANgpjC6_31QMh4OnKEOgbZiD_MymHxAHRZRyqg@mail.gmail.com>
 <5a129d04e0b84b48ba6c5189a047ac8f@AcuMS.aculab.com>
 <CAHk-=whLcr11D28vu2NotZYn3GNH6BCTK57Zw4d4v7eut39z=g@mail.gmail.com>
 <d48ce3b3-9173-4309-aae6-96be42327f97@lucifer.local>
 <f2ee5fe686f7440ab1e5469a6e560064@AcuMS.aculab.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2ee5fe686f7440ab1e5469a6e560064@AcuMS.aculab.com>
X-ClientProxiedBy: LO4P123CA0519.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::6) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|IA0PR10MB6891:EE_
X-MS-Office365-Filtering-Correlation-Id: b6526877-d1c4-42cc-6a8f-08dcad76a75d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k1W49I+WrLq8WwG8OvIrhWXjYNHmPfw7pdjtLZg0bU4FAi/IS1YIibjcyDc5?=
 =?us-ascii?Q?AptQdpqaYQZ1xjzvZ00B8XXRaIoVtCpla4IeOJ66LDQcKWBFdz0qaLkI1+jx?=
 =?us-ascii?Q?Si5WrYd2MwKzq70TXrEligNp5Ox8Ea4UsmpuyKdiJBoryD7mzDsqVlizimFg?=
 =?us-ascii?Q?MOQ/eSzW1d8JeWVTPXSAvb53OPDqn4o1XUCFHZTKO5PUVJCD1tV1OwdBtK1y?=
 =?us-ascii?Q?4sQlWVfvpSXVuP6Zv9SZqYYgre5LTwwr+RIfsjaBciSiYv5OwhgOOEnKmwmP?=
 =?us-ascii?Q?FPylNWyi0hfQqYDPuGAi3e8hqO36+PPIUleQRv8QN7rqEtnEDSBvizI1MJQj?=
 =?us-ascii?Q?nTr+Z10dYO2oPYpCj6+HEkMTLSyvwf4ozkFmdM1Ynvy05Kos82cthzvV4H/F?=
 =?us-ascii?Q?26Q1dU2bU6AGxHVHJC3EKIyDb6XToBRYM17fm8n9q2xqruAk74J8pIo24P45?=
 =?us-ascii?Q?EdEpSP42O8KaqgbSt+iKcustDu63Y+UOwoFhmdJcmbG3hiTeAOkVdi2+lLGT?=
 =?us-ascii?Q?NrDqh8QwM/y+Z6GjsnHmXGk0PjJqrPayTg4xYAXu5vGiJzReKtw63h2UenIG?=
 =?us-ascii?Q?cs5g7Nn30aO2KXu/q1WsxcPJxpzQL4fZ2JJTLQa4fNWzDyr3fQeCgVoypW/x?=
 =?us-ascii?Q?QsUXy/yfuuL0/DfXmJ11WCMp0/rQSKL/wlf/R20/9Jcd8EIfqDTxZ5Xzgt/v?=
 =?us-ascii?Q?Yj6WM8sxt792+R+qzBGaztDbtbUqHJoL12KwKJYnLZ/b+C4CTD3zcUmBP0RF?=
 =?us-ascii?Q?Odg5Zpa9pFvKN2gYwotoXAZR63baGEG1IL2v/wVbShmlbrndKZsjCxpcF3ta?=
 =?us-ascii?Q?t30GMhl9TvSQF+QrVxHHItcam6Qymygu0b+RRCnIOaUXj+flOEYRub4Kxr4x?=
 =?us-ascii?Q?ZUFiN1cio6vfzndrWm5L3to6jLfZUr/ylDsUCFKIjOEvdK38dx3MK98JmpYy?=
 =?us-ascii?Q?DyMtiJuFJUnT6tMknyE0G/jnPYFOznHy031h7IFnjNZDJ21krqpq65xAAseS?=
 =?us-ascii?Q?K5aIXf9cDzDjfiOJQV3WPfwGl9Pb/nYxfjANVdt2CU+ZD0o8AsR+uSJYoBzo?=
 =?us-ascii?Q?DlsYGl7Elni2WCSLXASD6PqrSBkNAyttF5VE4Z9TvCmMbdE28uK5Q8pmVIqa?=
 =?us-ascii?Q?5qbBrBigHb0nhNbG0eNoAvmBlLF9VcbLrSH9FZGOTV+VRZ2A3mlu81NN2O+y?=
 =?us-ascii?Q?cZDtCbGdwB+Nu8unjQU0rogoSm83nsCuv6G016VACXN9ZvP8sdWRJYxrxHJv?=
 =?us-ascii?Q?yEj6sDMwBYKW8Pzk2iwfh/59BcRmvp9vAwgPj+PSUxpc8teNeljG2c1cuuB3?=
 =?us-ascii?Q?W/sXM6Ipk2kBpcosCbXc5mvMIb2DOQpx5tsWpszsuujKWw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U6MXA9b53dPpqfFesGrOIo8oKmYCmkIaBv4WEfteaewCnqVZnABMYodaf60F?=
 =?us-ascii?Q?jgDLpQUucCS/hxyPaMZ31Jr26F6zyFg5czzWEu6SEYVcQvrYWS+U4vnDA9TN?=
 =?us-ascii?Q?GiLuZr86zXTghmGP0z0SxSBrT4H4lNeDMB1R5VkvQCiyOI1ajnw+YUG0JJF0?=
 =?us-ascii?Q?5z4WlAl/6d4qJrnT0LeKRXu2V+cAxpUPUBIw87bhW7PAp0NjUu+QmuqU98jj?=
 =?us-ascii?Q?1AS5ZPcl4AdksNkbAycxLZ5vhJ/I9w1Jsflh2YUkpQQhqNSK/jQHZqDWVwDn?=
 =?us-ascii?Q?7209DK6a3UuaViHSfA8i6bp4Qmvxbrldn2QrVr7BUyKt8vag13A7s8kepSDo?=
 =?us-ascii?Q?pyotEEEN1rAkUKXeKV/OIKL6EP2k/1M71MEccraF7pCfLi/q7VD0uK+T2HRu?=
 =?us-ascii?Q?BIZhSaDblAgjW3XVIIGBSzi9ZV5lf11FDUBa0NrbcOCWX4UcjCGtbs4+bIyj?=
 =?us-ascii?Q?MCkbxjgJCLzhNSE8o8W5wN3zWgdHgXLB7YkOcc7mnFlFK8oIbUl+ek2IzxuC?=
 =?us-ascii?Q?JujEhBQsQHDPwcJagABveyM4TXqQwtLgpUsMg8zuNZ8yLq3TemRTWNTAqAPk?=
 =?us-ascii?Q?fOGuz+llVwn2Cmu4+rPJNgCD5Y/L01m6Lb86SbHHZ/42nkHtzQG3v/35Vd0X?=
 =?us-ascii?Q?5AQTumtoJKvYnESSpcnlxpgO4iHkDF7z8SxoLMGNsbbDdci+TbPdedOh8A6E?=
 =?us-ascii?Q?z1JJNzoQc18pmb9D0i7d2K/mGVxQeTHvcRVFi0wH0SbS3nszhqmyvfzFUU0A?=
 =?us-ascii?Q?0TDCGajX58quZhJx2I2QIDt8/7swWYrkzGIwbjHq8pcQop3UHk7sIIWerCu2?=
 =?us-ascii?Q?j31k4NiFVdRwaNaxbpCtdBBH3joKPgeZVcdXkgPDroR25KNx3CE83UJE0veI?=
 =?us-ascii?Q?L//QAPPykPTPJ+7o0GI7hJZGscpXybAcAblnkOB6V0Y7AhkLsHnXZ/4KRHqg?=
 =?us-ascii?Q?VRFv2z0Pmx5h0NJqw1l6Om4Ua2hJDglpQh/bDUbx0AOBoc7B1xgqqs50GIin?=
 =?us-ascii?Q?MvgDuJqNcdOjMzjFLa1rudGpLVQXlSc/NQx/zpRVnwNMOibu8WH1W2N9Go41?=
 =?us-ascii?Q?+YsSR8eW2ORm9dkW5tL12KwYNVtZCWmzrSK1iQOtRTegAYYbdkPAPGzqYz/u?=
 =?us-ascii?Q?W4fRFcFaAm6r+NhY8l2iHreLWgxAlde5whLRObn06POw5ZWBij4bcHOkVLT8?=
 =?us-ascii?Q?p3s811wEECWh69Ol/Z3Ggd7LyzQ6aCl7hYsYDqh8OClhiRR0KPYzh+qKWueh?=
 =?us-ascii?Q?qwxoxHaLUd6C84VAuBuHbl9nmSdzNIDYL2UZookXAI4o7JKeav/QN8TQPOtK?=
 =?us-ascii?Q?zYFuUVrri3PLIH3GNnl4H3+/MTEVsOyqljW8hVIDJ9OucasOndNbHtJf1NDR?=
 =?us-ascii?Q?C6GN7YfXUNWe2QXHJS0/jiaVldTqo5+PsrQjVa/YLLcjooLfP8VMF+vz9bhY?=
 =?us-ascii?Q?rAZw6V02S/uwdbPP+cNxPv3+/EY+Vin5++BS78nFlGZdrAXC3J09ktZUglMt?=
 =?us-ascii?Q?w5nacRUvZZPxXi+l1tU+M08eY6KeNmdzpr4hCsXaHmCdQvRAIw81SC++0sGR?=
 =?us-ascii?Q?BQamBEkwXx8nzF/ex1xmLeTN/fxht7AlPcJ8Repv285u+Mu7l2kyT8R3xR6T?=
 =?us-ascii?Q?TI0VFySn8uK2OFp9AyCKcZ+I2apTYWs9WjKdpZUsGS+rGVqpBzie9dT0h0QZ?=
 =?us-ascii?Q?15Z7CA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SB876xjmf0RZr+UDjSjgfzb1cO7SkhWHz2fwo2Oit6CB0XU7TDHB6qyN1gCDKE7K6m7oJbM0IC2rRyG3qWUqVipUaGVy4ckwF5hpuZ243vv5xNzxR7Juk4iRnq6aS0Kd/nPQi+idIaPan18SN6s5fPXIoEwvPZiWUJYinQHWwcwvZ+VfewFe4rrTXWgflVkPDcT68/Eo/96BZ08YQWs5x4SmICQdxql3RC8eMyYok50KerA2nGYZX6EQBaY4O36M+OKmVsxZz6KzCO4Qu4gJ/dYVXpQpH501lVK+oQCtGlps6YVpogkxD4jAdaypLr8iRdxDje822oMruJJ3dm3jhh63R2fu+UujANphQxlSF7lruTeU4aFjAqF5D2KJBlWqeSRIv21/hoB2IGzQd0D4Dy+8P085pFGxrRzZf6c7rLKU6vyVaOukBfCxdqiF7rpZtszZf0MKZyt1vMxJPl24HAcQ/I9R+1iGK6QV5D8gu7fsUku/wSAztsa0b7HiFcQtw+EGvLoVPm92jkAUOrLAmEzDRjXi+NY/t+zwj3slTOn7Mo+0HCdB9L4G+0UbeWdJQjH3EyFDrer10zjIwq4KnqRLge5ESHxWkmoJqQuDro8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6526877-d1c4-42cc-6a8f-08dcad76a75d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 13:27:10.7849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uXz1hHV7apSm8txZVDLXf2p8suwuZxL7Mnz/gEHARV5vpVGiw5GfHiq6KLv7x9OA6bycQS1t7NgmZGPT67DkbUmZeJzVRYO5bjCOiYf6It0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6891
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-26_11,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407260091
X-Proofpoint-GUID: cYe1HN_Et_du5AUgSy5H6ypR_oXhtDNW
X-Proofpoint-ORIG-GUID: cYe1HN_Et_du5AUgSy5H6ypR_oXhtDNW

On Fri, Jul 26, 2024 at 12:57:43PM GMT, David Laight wrote:
> From: Lorenzo Stoakes
> > Sent: 26 July 2024 10:44
> >
> > On Thu, Jul 25, 2024 at 10:02:45AM GMT, Linus Torvalds wrote:

[snip]

> > > Christ. This whole series is a nightmare of "add complexity to deal
> > > with stupid issues".
> > >
> > > But the kernel test robot clearly found even more issues.
> > >
> > > I think we need to just go back to the old code. It was stupid and
> > > limited and caused us to have to be more careful about types than was
> > > strictly necessary.
> >
> > The problem is simply reverting reveals that seemingly a _ton_ of code has
> > come to rely on the relaxed conditions.
> >
> > When I went to gather the numbers for my initial report I had to manually
> > fix up every case which was rather painful, and that was just a defconfig +
> > a few extra options. allmodconfig is likely to be a hellscape.
> >
> > I've not dug deep into the ins + outs of this, so forgive me for being
> > vague (Arnd has a far clearer understanding) - but it seems that the
> > majority of the complexity comes from having to absolutely ensure all this
> > works for compile-time constant values.
>
> The problems arise due to some odd uses, not just the requirement for compile-time
> constants for on-stack array sizes.

Odd implies not many, same argument applies.

[snip]

>
> > Arnd had a look through and determined there weren't _too_ many cases where
> > we need this (for instance array sizes).
> >
> > So I wonder whether we can't just vastly simplify this stuff (and reducing
> > the macro expansion hell) for the usual case, and implement something like
> > cmin()/cmax() or whatever for the true-constant cases?
>
> I did do that in a patch set from much earlier in the year.
> But Linus said they'd need to be MIN() and MAX() and that requires changes
> to a few places where those are already defined.

OK, so what's stopping you from doing that?

In order to implement a MIN()/MAX() you'd need to change call sites only
(should be a managable amount), so we can change this too?

I'm concerned that a solution is being proposed here and then handwaved
away...

Unfortunately a revert is no longer possible (I had to fix up 33 call sites
manually just for my defconfig build to compare perf before/after), so if
the intent is to eliminate the complexity, then we need a practical way
forward.

>
> > > But it was also about a million times simpler, and didn't cause build
> > > time regressions.
>
> Just bugs because people did min_t(short, 65536, 128) and didn't expect zero.
>
> It has to be said that the chances of a min(negative_value, unsigned_constant)
> appearing are pretty slim.
> All these tests are there to trap that case.
>
> There is always the option of disabling the tests for 'normal' build, but
> leaving them there for (say) the W=1 builds.
> Then it won't matter as much if the tests slow down the build a little.

Very much NAK disabling tests as a solution! Also leaving them for a build
that's apparently broken... yeah not a fan.

>
> I think I have tried a W=1 build - but there are too many warnings/errors
> from other places to get anywhere.
> A lot are for 'unsigned_var >= 0' in paths that get optimised away.
> The compiler doesn't help!
>
> 	David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
>

