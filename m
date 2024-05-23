Return-Path: <linux-kernel+bounces-187338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4228CD068
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA4991C22863
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF92613E3F3;
	Thu, 23 May 2024 10:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="M0Njoh5H";
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="M0Njoh5H";
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="M0Njoh5H"
Received: from ZR1P278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazon11022018.outbound.protection.outlook.com [52.101.186.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE6B13C9CF
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 10:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.186.18
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716460519; cv=fail; b=WkIg2WfCST4HtikQZ/BTDmEGq8KU20TlzWXC5Taq5CLL6qut/3iK9nnZEgLxsOZDm+ZzGpcrFD/kzUKEYmwDzHyY+PGHWZgyfDuxOuvnThJkWYnRTAoAZmpO+/WHrcyb/mzNXQB34MLLYwbVPYHvg3zrpGLTXyCBVw6IM6Akl1E=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716460519; c=relaxed/simple;
	bh=7RKM1f8y3rxrgqUuWPhwsiEjqe1/546ZM8VNqQVtHXo=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ekDLVx2YeB3q7Ax+i+EOqpYz5kcaFKhyqePCbATdD3Pvu8j3pFMuULvc93eDMIUwuy6+Rh4fddc9y0MFFxFJ9vBglUvGbZR7mmHBIzPiZ4qkFOS8P/n3qIe4l4GkqyOufNZiLKbjXIFIKBIUD5Ncw/2aLdOiIq/XEW82bN3Vtag=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com; spf=pass smtp.mailfrom=duagon.com; dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b=M0Njoh5H; dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b=M0Njoh5H; dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b=M0Njoh5H; arc=fail smtp.client-ip=52.101.186.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=duagon.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=RwwZ1s3xBgwa/sIqnnbKHwoJ1eWQrsYcsU0qriAkBo8dFnWy9w32HFY8f04eRk+f0961DDYw6dFuPEYfexWl9Fm2pO//4yxOTKGelbIiT4Qc1dZtm+DRE/hdK6mbxDs359T2fdNBXYaSBx+8GyQS35d4lWQK7ZQwN7g8NwOzVZrxKe/jfiJY5SuIa0INpxn3e9EiLM09NodNpQJy0pOcAoAB0GOwI9uRkCDD802dwcd4o7pZJVt4g/2fOEjI/ExxkwdWhw+IMZjuxHBWmiotBKwLPQBYlVL8kaci8A9Gq5kv21Nkxkbb8o20FiqfvlAGX2sCw2ubWRPjVdCfqjDYBg==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=klq8fFKpPkCU9+Tvj7oG0LolUdRulW4uoNxZ/o/rQQU=;
 b=mteQl2B/OkOOyzrbhLNtBn1DJfS8PbW8h4gIvng/hZfsWtgaHInYyu3Ve9zPr5+dpXjmwdVbEDOS+yYM+qJQjekZlcC9u9Ii1vpECPaJwXXn2S2cboUhROKlZSenaPs1QsSFwULaGR+vMIDAEctjeHQJYW56EL1DytCatsquQvwEPyCaXTj67EHFmslqDnFNTXvZt5g9/bbmuhixXftsQRbgzdBlliaXomOFfZ7icleHJgSj9ll2E8jyRCVYHHATik5yCTKs48+oVCbIs9IgbWUgoEn7Fd9BGVSZNVbAHjnXmymvh7OM/CLRtpPU+nL6I7YR+OUh4kkhi6L/5oi5Ng==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=pass (sender ip is
 194.38.86.34) smtp.rcpttodomain=gmail.com smtp.mailfrom=duagon.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=duagon.com;
 dkim=pass (signature was verified) header.d=duagon.com; dkim=pass (signature
 was verified) header.d=duagon.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,2,smtp.mailfrom=duagon.com] dkim=[1,2,header.d=duagon.com]
 dmarc=[1,2,header.from=duagon.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=klq8fFKpPkCU9+Tvj7oG0LolUdRulW4uoNxZ/o/rQQU=;
 b=M0Njoh5Hgq44BoxQlLoXKV/D0nkHl5kGHbXvMDZZOsw22QeIs4FPWouPAidWZiCnYXC3oaO4DAbI33PNDF5bxScAKxqfW/u/BJdMa29s+4TUx6GGv28+/wGWk3gJid3iGUclq7N8BC+jRTPA09G+JXIo7jc7LfzUaQdqU3KWMQM=
Received: from DUZPR01CA0033.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::8) by ZR0P278MB1168.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:55::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 23 May
 2024 10:35:10 +0000
Received: from DU2PEPF00028D0F.eurprd03.prod.outlook.com
 (2603:10a6:10:468:cafe::7e) by DUZPR01CA0033.outlook.office365.com
 (2603:10a6:10:468::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22 via Frontend
 Transport; Thu, 23 May 2024 10:35:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.38.86.34)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 194.38.86.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.38.86.34; helo=securemail.duagon.com; pr=C
Received: from securemail.duagon.com (194.38.86.34) by
 DU2PEPF00028D0F.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7587.21
 via Frontend Transport; Thu, 23 May 2024 10:35:09 +0000
Received: from securemail (localhost [127.0.0.1])
	by securemail.duagon.com (Postfix) with SMTP id 4VlPgx06hyzxpB;
	Thu, 23 May 2024 12:35:09 +0200 (CEST)
Received: from ZRZP278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazlp17011005.outbound.protection.outlook.com [40.93.85.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by securemail.duagon.com (Postfix) with ESMTPS;
	Thu, 23 May 2024 12:35:08 +0200 (CEST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=TChAtuHDWPibe9Hk2aDSUlC2USG9IWcwlUFzqf8gN8cGeWMIO1Ax3c5yIv3jqZQaiFfeQQEpd1QqtJ1oAS/wjCtyScapA1EGgH5zaHGOvhSOKOuxqodVaCV5cUCWgO7a2JvJn+s8sWUTQoTaXT3uXhrYWKDyPr5L1yZngtWZUDJtI9a57SAjO0w6XSkaboiH1JcUaLiMv4flrS+cMgdE7ZfhbNI8CefADbS9KrlnrTgz+633i+5Bvv5kQ4SZtU0N8xu+H9kPhLEJea3LpOGFSxLQFniqsbdgAcSR9JhuFKKM5rNlfcxax/QQPlWq7fuPGhEU9skSAWS1j+USH4acgg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=klq8fFKpPkCU9+Tvj7oG0LolUdRulW4uoNxZ/o/rQQU=;
 b=JegkJTwAICEqJKN6sNIPVd3CNNNehwnqOeWzOpHn+Ho8y3emYLWfG3+rfOqn3viTdHTOt914p0HGikDIqH0y1YuAE+X6VgsleZbHTvH+PJArl3Dlfm/Mv/OKFRO/ImXYZz4ktiAjY+MnALIcC7RsdnAHGZ+QGmM7IGjLSJ6X6D0OqsEuYP7iilhPwvFFQugQ6wUBVEYGkOephNaqXvJi3yJa1moKmZ5G6h9F0PT4XaMVsoiOnapNaEPcb6JLNHCZqdJfIiEsNvOMJH0NIbj38/jemAhIQlclhk9Eh1mMx/a29jdBKvnhxtQnBihuNqZbPnF/TxeLrhHJm+A99M5IRQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.79.222.204) smtp.rcpttodomain=gmail.com smtp.mailfrom=duagon.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=duagon.com;
 dkim=pass (signature was verified) header.d=duagon.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=duagon.com] dkim=[1,1,header.d=duagon.com]
 dmarc=[1,1,header.from=duagon.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=klq8fFKpPkCU9+Tvj7oG0LolUdRulW4uoNxZ/o/rQQU=;
 b=M0Njoh5Hgq44BoxQlLoXKV/D0nkHl5kGHbXvMDZZOsw22QeIs4FPWouPAidWZiCnYXC3oaO4DAbI33PNDF5bxScAKxqfW/u/BJdMa29s+4TUx6GGv28+/wGWk3gJid3iGUclq7N8BC+jRTPA09G+JXIo7jc7LfzUaQdqU3KWMQM=
Received: from AS9PR01CA0017.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:540::18) by ZR0P278MB1218.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:80::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 23 May
 2024 10:35:06 +0000
Received: from AM4PEPF00025F9B.EURPRD83.prod.outlook.com
 (2603:10a6:20b:540:cafe::ef) by AS9PR01CA0017.outlook.office365.com
 (2603:10a6:20b:540::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19 via Frontend
 Transport; Thu, 23 May 2024 10:35:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.222.204)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.222.204 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.222.204; helo=de2-emailsignatures-cloud.codetwo.com; pr=C
Received: from de2-emailsignatures-cloud.codetwo.com (20.79.222.204) by
 AM4PEPF00025F9B.mail.protection.outlook.com (10.167.16.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.0 via Frontend Transport; Thu, 23 May 2024 10:35:06 +0000
Received: from ZRZP278CU001.outbound.protection.outlook.com (40.93.85.5) by de2-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Thu, 23 May 2024 10:35:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZmDCRySMcBklY+zzDlnczTvAmGr0Xux3bNo+3McmSwTIfxQXoVe11Id/ol7c2I144Jhp/UZ8B6yJBgQyA77ZXsZtAskaJ+yBQdGQtvt3PhtQIis+C6uR9BdZh8xFUvThT3WqHBCyA0pgfkrCwTMbC6U9kG/PGbOvpIyIRh/Du76IQKDMfAbiCmv8WDiNkemeIGPwpd89TJ0CqZD2vOuRv0X2N+ZwmEeZh4EcQ9JQaOPbjPlu4cKXR1OCyGe+6WkJZhOR8UgdTip0idS0XtX2/tlJEWjTYXHn/vZbuMuU0N46XaIpHzbfWdmxquriofMwpsG1p0qN1fFM8mN+8PR7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=klq8fFKpPkCU9+Tvj7oG0LolUdRulW4uoNxZ/o/rQQU=;
 b=k1ovAldXUtgJ0CFtb1yjfak+Bm8XT6llurnE7epnDwwcPqPhrxPOlKfq66xm0+/tFVHOvNOi42gdXs7APSjEjzd5MvmUhsaxhgfptENkX2w1ZXJNFyE46W3Lod2v4uZqNJCcrP6NcGcOjsvgtQchE0tpMh8KSB8AQC/D5G4vFO2C6f2moVYZ3TpteLJaLio1zSYGjxR2UQd1M6x+tEQPlCxxVISivUeYfj2oExOZehqNOMl3oiidGe3ID9Je25GybEUKJLS//JTA4Qj6Bwn+hbluIm4NohwopeGQ8SfqL/jjzZhIwhhoGKL0QZVVk/tTpX+85B3vDZmNn1CdgmpQ6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=duagon.com; dmarc=pass action=none header.from=duagon.com;
 dkim=pass header.d=duagon.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=klq8fFKpPkCU9+Tvj7oG0LolUdRulW4uoNxZ/o/rQQU=;
 b=M0Njoh5Hgq44BoxQlLoXKV/D0nkHl5kGHbXvMDZZOsw22QeIs4FPWouPAidWZiCnYXC3oaO4DAbI33PNDF5bxScAKxqfW/u/BJdMa29s+4TUx6GGv28+/wGWk3gJid3iGUclq7N8BC+jRTPA09G+JXIo7jc7LfzUaQdqU3KWMQM=
Received: from GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:2e::11)
 by ZR0P278MB1594.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:93::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 23 May
 2024 10:35:03 +0000
Received: from GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ae7a:9620:b675:152e]) by GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ae7a:9620:b675:152e%6]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 10:35:03 +0000
From: =?iso-8859-1?Q?Sanju=E1n_Garc=EDa=2C_Jorge?=
	<Jorge.SanjuanGarcia@duagon.com>
To: "morbidrsa@gmail.com" <morbidrsa@gmail.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jth@kernel.org" <jth@kernel.org>,
	=?iso-8859-1?Q?Rodr=EDguez_Barbarin=2C_Jos=E9_Javier?=
	<josejavier.rodriguez@duagon.com>,
	=?iso-8859-1?Q?Sanju=E1n_Garc=EDa=2C_Jorge?=
	<Jorge.SanjuanGarcia@duagon.com>,
	=?iso-8859-1?Q?Rodr=EDguez_Barbarin=2C_Jos=E9_Javier?=
	<josejavier.rodriguez@duagon.com>
Subject: [PATCH RESEND] mcb: mcb-pci: detect IO mapped devices before
 requesting resources
Thread-Topic: [PATCH RESEND] mcb: mcb-pci: detect IO mapped devices before
 requesting resources
Thread-Index: AQHarPzeZrun6mhMA0Wp2VWIBrhsJw==
Date: Thu, 23 May 2024 10:35:03 +0000
Message-ID: <20240523103430.423340-1-jorge.sanjuangarcia@duagon.com>
Accept-Language: es-ES, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
x-ms-traffictypediagnostic:
	GV0P278MB0516:EE_|ZR0P278MB1594:EE_|AM4PEPF00025F9B:EE_|ZR0P278MB1218:EE_|DU2PEPF00028D0F:EE_|ZR0P278MB1168:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ebcce10-1db6-40ce-066f-08dc7b140561
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
X-Microsoft-Antispam-Message-Info-Original:
 =?iso-8859-1?Q?XBcByJWQnx0RunFy0VgsckSEN5kYp/kEZ6Dm9YEGvygiM0nXw+3sVb0xWI?=
 =?iso-8859-1?Q?1uw2gKG2NodMC/M8l/Tbtzgs0rq0p9RRmV6HcdlWB5EZVK4d7YZ/OsmG7T?=
 =?iso-8859-1?Q?blZxsVty6u/uYEwZ0gw7leVLGhdmi8qwnTSreZHj0iP8o4GSec0jvF+5C3?=
 =?iso-8859-1?Q?9LefDvISvh6g0Rve6EHCtTIZPhtBSzfJ3gc05ZcQKR5UIHs3AgryWyj3zI?=
 =?iso-8859-1?Q?zXhOW4Ie1PeVBy20O3JFrMhzEIsBOuWXNvezoyH1CBPCFtXJEP2wuEPBcS?=
 =?iso-8859-1?Q?ZGckN1SMdFgpUacLct8gEnVQhGXisCjixuNattueDfAVETjeHm69jOFK7B?=
 =?iso-8859-1?Q?xy2YedQff25CSmPVYiKWHtihBCsJEsJiAbs34iHoaoA/PKQi5zDxLIR9el?=
 =?iso-8859-1?Q?J9hmskuuyx3M1DwHkrw5nQmLBmqSnX0mGCL4lR8Q/rL37wStfzCpXW8QYM?=
 =?iso-8859-1?Q?kr8xNfsSatKOKmrsDPUpgguMwuOeJGm9218CDu9sj/p8Uc17jJVmj3b2TW?=
 =?iso-8859-1?Q?77bLtwSiXItHAjXeeKW+HW7eNGc4jSqcUFiTe8w0tXkG8WqzYD6ni4Rydf?=
 =?iso-8859-1?Q?hptQdjpjUdp0NrPKjvS/u1hOkxfJX3SQHSu3A+WJ0XoT8OAArSBQc2WX0H?=
 =?iso-8859-1?Q?GTl+dMMm8WSTQF5x/GCuG2IExjYeVa5yA1DYB3EddnXQHj0z85wPDenr8W?=
 =?iso-8859-1?Q?/hdW8saEa2QD/1e0hVxSHU+QbLL5aivtF9b+BX2hTsT62BQRU2nM10grEt?=
 =?iso-8859-1?Q?PesZIhFPiaeijM83I73Fif+9E8pkR4gYF5Ins56rY2AMTN949RCiyFyho0?=
 =?iso-8859-1?Q?9Kp+i5xBp2+8E6lbtbJe6RETeS1Kmt/AB3lCjSCeyWOV3VNvBtVN3XOx0Z?=
 =?iso-8859-1?Q?atNNSGwoGs+UrIj9ARBfKI3C1f0B/4H5yxiZ9C0G2NhE+wxwmAlJz/kUmJ?=
 =?iso-8859-1?Q?E/XKi5VFu/g6NZPpZ7ARY29IfTRHNwvEcuYC1VX4vREit0VDQXISzI8C3A?=
 =?iso-8859-1?Q?4Ta0ITK1Vyf9PFcZ773qQ4WuPKfLp1X7MXoeEb/4BqB0mAzvgownewtbi+?=
 =?iso-8859-1?Q?oPfLjbaKTWIo9zhK98P7/EhGOihSI6A1H3H71PoLtel25GV99RQ52fLZy3?=
 =?iso-8859-1?Q?Jxt7IuJYnbZnakx3yi2JAiupreFWZl82mRuF5CPjpLoX/v6PK5PjtgHFHy?=
 =?iso-8859-1?Q?ytX9ChyenHvXcDYNjSavSA3vfDT8JHePdOCflm6/RGFnGI7qTfeX7F6/QI?=
 =?iso-8859-1?Q?g2iUgPhrKQRlbbt+1mhTfq5DDGeCucGQo/cc5fEroWJcmLaeAmZVnL40IJ?=
 =?iso-8859-1?Q?lZapvAlcLSiKQ2g2EWYK05ymFrLS1athNHHQxVG65uTbAjAZ0lwTMDrX/I?=
 =?iso-8859-1?Q?Ho15FdiCHGTPt9mJzWQ6nGIz7uFe2WJA=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB1594
X-CodeTwo-MessageID: e94376f8-b8bf-4843-a345-b2d9abe55293.20240523103505@de2-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 1
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00025F9B.EURPRD83.prod.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs:
 007d8f33-0323-426a-1e94-08dc7b140149
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230031|1800799015|36860700004|376005|35042699013|82310400017;
X-Microsoft-Antispam-Message-Info-Original:
 =?iso-8859-1?Q?dIBOSn7m2wKfXG+KeBA/Coe6wWJAi2HQIfTCVevWqhOdH7/bqrrrcK61tf?=
 =?iso-8859-1?Q?0pNplUdQB+LBxIAij1X9n0fROiLRSEm1kzxtqPizC6fNsOI0XoWdDEHii3?=
 =?iso-8859-1?Q?xpmRehsi7ldmGrJVcs0AgLecbcHY8AXF0UQPM24oYCmeWA7i8Xi1bzBV3I?=
 =?iso-8859-1?Q?LCTednjI+Wyt7Fbp57wy0beb6DWVAUdFQH/HnPc1ccv2w6CJdpqvI8E12X?=
 =?iso-8859-1?Q?0yM2PE/53ogJoW3HXWfKeJH7T74Y+6MZZHqUJajZL8W0u02U9D3zSfUKXb?=
 =?iso-8859-1?Q?T2TbbDl6gUcbW6UD3xijKiNGd+IZ26SiwlD4NzmqxX6LeQsZ5wUNjDnoEj?=
 =?iso-8859-1?Q?iioyzpPoMC3Qg+yTP0+02rO6vpj5wwfnA9Vwah+7w3xKQvYXPi976a9SSM?=
 =?iso-8859-1?Q?V2s3amMBbmnZt8PH4QkPcMtZnnrIaTD70fK/Ft/zqAgqhTss20tEWw899l?=
 =?iso-8859-1?Q?4aWt5HwDcHYngD5AxIcSRwSlqj8v+8EQuABxmmDonBWxYh+pK4vDH9kG86?=
 =?iso-8859-1?Q?3MYJgTkoX/EKwYCy4DlJPl4axen27uSO/cs/seaVIrcCz1J1+pBcekDYNE?=
 =?iso-8859-1?Q?Uz0vb9YOkhX2SWLSWZeZu+ic9m0zF6PFKxPe+85tSxMXbD1At4cfs6SUwE?=
 =?iso-8859-1?Q?WKPJhQQrdGb3tizU6KEsydQGfoIY/gigLnjBqt4HtJJkrkeA0vtjbKmBn0?=
 =?iso-8859-1?Q?zyhHI0QOC0UtwD/MgBWq51KBMpZ6v8uEsN3EENhJd7l9e4+4thfvbNdEu4?=
 =?iso-8859-1?Q?tlRv9S4ZInVaBuvubNd5oyzmVsSk1OfXvJRAeilLCcVRh9J86T/9Hio2sk?=
 =?iso-8859-1?Q?6AD2mJc0mfmOBVrRR5tH+/zNCgpozlVOpRkASiYbA+xPMnsLMmgqjTLRs8?=
 =?iso-8859-1?Q?Sxy9eJr4F9orjkZFYD9o4XAUg0YOa8ZDKQBtTBwowsWsBkRlWWjEnoP1k/?=
 =?iso-8859-1?Q?8UNvpWNrvJHDGDhNG7q3m1fHiX5kWYkmc25DYVmdq2DGFRQZ3sFPU4HlwK?=
 =?iso-8859-1?Q?r8b276bnG6zBuD0glqklQVb2WtoJDYVOOnh3N/lJTOVdqZ9WO0/wvHqp7Q?=
 =?iso-8859-1?Q?/pufbaDEmsSn243cWSHhG7jibZlgxju/c5+yxKf8njCzHrfYiwJ/mSuJVA?=
 =?iso-8859-1?Q?ArnzeYs8H/8J70kXSIFynJVIAykpRCoEd7AdaiNB6xknVNvpdeouWF22so?=
 =?iso-8859-1?Q?BWqvvZa1SP4eb8iIXGxrzN60YSznKl/BuSgDYWspj7MznymwrT3hdqNEli?=
 =?iso-8859-1?Q?tmjvIUgtt5etgCP7R/RscDcrCtEfoP8SzATg33ZVhZHMwvNp5nvG6Nzoc+?=
 =?iso-8859-1?Q?j01JunzF2UbCAgiJkkswMSr73ohn27bGXHpYi+3H/ZvIPCCMP+yM+ciSMI?=
 =?iso-8859-1?Q?ZKcWRnkrm89G2iNgl5JODbBawJk/oDP015GFS/hyFmsilROFHXnLzCukG+?=
 =?iso-8859-1?Q?frC/o4cFJt+FmLVE?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:20.79.222.204;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:de2-emailsignatures-cloud.codetwo.com;PTR:de2-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(35042699013)(82310400017);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB1218
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D0F.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	2f24bbb4-7dbb-459f-8fbf-08dc7b14030e
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|1800799015|35042699013|82310400017|376005;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?yAtcto5mSjqtvHyNTtqY/KY8xlh035z8wFQUPJrvmc3Zl7t9IFI7+IACgA?=
 =?iso-8859-1?Q?NgO4Ar3rfjpeU+u/vaiEvyVEbOZcAL2wtQk6ut6+rxoQeX+7pwiYKDrO3P?=
 =?iso-8859-1?Q?xKRT2SAde+/3LgzdmnABbcmWR15wcco6U93CvoBI5vmpLUq25kLHlGBIfF?=
 =?iso-8859-1?Q?AHpTByybFoJ1MADXGfDcxWRWcsekjK2hc4sORCKqz2iFF6ilVnbaLZVLNk?=
 =?iso-8859-1?Q?iC+ZKvb0PrfJmoQV3Xxx1cQTf98zuVG0Hdl0kS6wCMJo8EqPcmEVo4Dkqj?=
 =?iso-8859-1?Q?ut3589JqW5PVlG5zVSzFWAHO7afnvRORfLSjxeZ3xMelacTSKlwz556m81?=
 =?iso-8859-1?Q?tT6FfNf1RtOsXGzei93obaeyDiysdY5PobEk0aDB7jRhNQOxG2goZgpsYJ?=
 =?iso-8859-1?Q?xuICljaPhtimL9N3R5jzkhtZFXk2ht+vgKPINRVIUtehQ7LhKY6xKUmHSP?=
 =?iso-8859-1?Q?lYzRd/JvnTlBE/jV0zPWKpnWpy51PzuU1+29Q0zOITanqgWEu23k+Wavlc?=
 =?iso-8859-1?Q?h9TMjWtUM+p6nD/sa5ZXGPTTVGAOSo2vzZx4WPK/NBP486vXDPPL4zcZ+Q?=
 =?iso-8859-1?Q?qKCVGeDXiU6vAWiAtUPgg5x7fupL/kwV1QKS1mNlgotMfn+idITAKw4vZ/?=
 =?iso-8859-1?Q?1WI0h0r4+Jh/7Ln7FtxaXq1MejFu7AgtE3zHnXL7e2DE7Rh7H4unTDfh7D?=
 =?iso-8859-1?Q?84MFeuy3+v3Yb/4bTss6QxJlYOIqypUVc1OGbKZqla74L1xuh/JfvuarsE?=
 =?iso-8859-1?Q?Wge+PvP3Kw7ZKhAmoWW+vqCrlvLpL+RF08G8UAYMY9CS2fPwOGwmODeMik?=
 =?iso-8859-1?Q?Su4J93476/RucS+v6TmP+4QwfRj8l0nHzs2hHlSquF5CaT/GqzjIrgM1g8?=
 =?iso-8859-1?Q?CgE1A2Ctn1Rr9sN8oPq4qoTwXZy+HcHgImSv7SN0Mp6aE4o4NBwR8AHVQs?=
 =?iso-8859-1?Q?ZJDwX/WPcTxn/6v9lHyjE8lCESIqZkmLonYFrCKWup8Wq1mzjHYbrXcvIP?=
 =?iso-8859-1?Q?BtYhjMApCyxFOD0Xwho7uyO4D3fRLmdEoOXlSx1nglS/vJR28bfvs6aO4X?=
 =?iso-8859-1?Q?XgsmV/IZqlRoJmxwN1oZ3XRS+LzyYMtR9jRTR7C/+EkZMqKoC/wip2Pm/D?=
 =?iso-8859-1?Q?xyYMRLm1YExrPqlvKp9Ve33mrMk96asaO0pLaZ70HhCMs7l1+0W+V7ARWp?=
 =?iso-8859-1?Q?rTRyJrTMLOEqYML8+oM7m0tlbBuCKp7hz03JttWruVfntgFreBKRVXLzS/?=
 =?iso-8859-1?Q?8Es6uBSGMCqfj2Fr/yLnNBC7NaAxz8bJSkIwbd23KKYwVWcs/e6r5BYyhR?=
 =?iso-8859-1?Q?N3MEQQJPEunqQClHDrazfSA4YQeU6dv3NILAYikF0cxW2UuMVZgi/Lq7fO?=
 =?iso-8859-1?Q?AxH6KjbCoP76hFdq3bQkPEUeToyFv6ntMQrIfr+LLKk0mE3rQNnZaEvijk?=
 =?iso-8859-1?Q?mCi0cQWb9Fyrr5ta?=
X-Forefront-Antispam-Report:
	CIP:194.38.86.34;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:securemail.duagon.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(35042699013)(82310400017)(376005);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 10:35:09.6762
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ebcce10-1db6-40ce-066f-08dc7b140561
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[194.38.86.34];Helo=[securemail.duagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0F.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB1168

If the memory region is requested with devm_request_mem_region()
for an IO mapped device it will return an error and mcb-pci will
incorrectly report it with EBUSY code.

Make sure we identify if the reosure is IO mapped and fail early
with a correct ENOTSUPP code.

Reviewed-by: Jose Javier Rodriguez Barbarin <JoseJavier.Rodriguez@duagon.co=
m>
Signed-off-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
---
 drivers/mcb/mcb-pci.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/mcb/mcb-pci.c b/drivers/mcb/mcb-pci.c
index 53d9202ff9a7..3b634ea318c7 100644
--- a/drivers/mcb/mcb-pci.c
+++ b/drivers/mcb/mcb-pci.c
@@ -45,6 +45,14 @@ static int mcb_pci_probe(struct pci_dev *pdev, const str=
uct pci_device_id *id)
 	}
 	pci_set_master(pdev);
=20
+	flags =3D pci_resource_flags(pdev, 0);
+	if (flags & IORESOURCE_IO) {
+		ret =3D -ENOTSUPP;
+		dev_err(&pdev->dev,
+			"IO mapped PCI devices are not supported\n");
+		goto out_disable;
+	}
+
 	priv->mapbase =3D pci_resource_start(pdev, 0);
 	if (!priv->mapbase) {
 		dev_err(&pdev->dev, "No PCI resource\n");
@@ -68,14 +76,6 @@ static int mcb_pci_probe(struct pci_dev *pdev, const str=
uct pci_device_id *id)
 		goto out_disable;
 	}
=20
-	flags =3D pci_resource_flags(pdev, 0);
-	if (flags & IORESOURCE_IO) {
-		ret =3D -ENOTSUPP;
-		dev_err(&pdev->dev,
-			"IO mapped PCI devices are not supported\n");
-		goto out_disable;
-	}
-
 	pci_set_drvdata(pdev, priv);
=20
 	priv->bus =3D mcb_alloc_bus(&pdev->dev);
--=20
2.34.1

