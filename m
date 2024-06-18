Return-Path: <linux-kernel+bounces-219684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C507F90D67B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5E451C25065
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361BC1CAB9;
	Tue, 18 Jun 2024 15:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="PFkQ76vE"
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2144.outbound.protection.outlook.com [40.92.62.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1152B208A0;
	Tue, 18 Jun 2024 15:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718723039; cv=fail; b=CTRreMWGnD8gPFyEXCX66k6HOQE3S61yphKAIWz5lvpgq2pAtYhtITzR49Zm9id5aUCf4ix5zo9gzZPPh5q/jRMpBVgiuI3u4QUbqlufEp03aYTvE+hy7KIz+nYt6RwYoEuHf3NVPeI5ia2nu2ePwPKiRqzCBVW7uZkChsBW1Ww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718723039; c=relaxed/simple;
	bh=KZmUMGJ2R4BUctimfp7c3VXWE4VatyAmcuCl2oDniRE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EHVS9BdGslEkvEyzTqc/0I3/C4RS3Op3s9eCHlicAHZ75rLXZB5H8Mx9a4gwy1E9S/QzV7Xcdv3Y/qVTst5VVgTDzWmG7kTOMs1s/uNgDbqnzellvXoNAIK7iCJ0NWFA/x/nA7FGsTwj08v1m1wq8md+OwWzzelgK+n8lyg1q9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=PFkQ76vE; arc=fail smtp.client-ip=40.92.62.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0kaYklC8Iqm+LK+YHBica6ZVhtSE0uVBDjpn0n8dhViLHPlz23uaI1v0N1I8X+ydiMv1FafdPsDWD6l2vgL+QxJLMPr2JpbLwpsBwBhH/PbW8k7QJXC/UADex2e5fnHmCNIsLbhUcKwTmjznGIMT0Sg29Uy1suSFrFRPG2WdvwbUliTpJ8cHzkuaFCbrLuPkEcWNAo2hQSe/XJ5tYi3Y14rH+tld6gDh73kznvCdaMGlbBrqoiPfXtwCW3KXha60jAxuUEAEIq8R3ppDbvj6ojFLom8I+KwhTxDaICaO8eV+lgyqn46Dc/catMeQ6nbWveXw1zoGUFBrB2uU7YZcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D3PMbhmIcHQwHTJoxl4VzJyO5ca9jnfp5cNkaqthJ/g=;
 b=cDCGU2PkTo6ZRxY7lrkPIgpODAq8R5DL8b8wqrATVeCEH6y/+ivG3X3M3PbFlgvULPme7s4R8V93p6lYhm7pCH3k37/PA05Ymv5dEdQjBStGvwZDtTI//xUz0LJKCIMfoSX1EYvodW8S6nKZHEdOKqGh/uFjFT2yQL0u2upfoLngfCgVhh45M6ddJ81TpPSxddnfZneJUjtUrQ9CP6Di6JYKDyx/E/SuJNCIQIp5jK9Kfh/PBeDNqsMxXBcMKUWw91OgSzk2F39+NKDFeYTiC4DnIFl5wMxrBGgMMFegyhj8XF2cBGLxgDSpuSkdh7VwKYKuOrB/W17OCEzYlyZrhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3PMbhmIcHQwHTJoxl4VzJyO5ca9jnfp5cNkaqthJ/g=;
 b=PFkQ76vEHR+xaDGAgEFydJUBGsMbJolTJ7ag4Hs+YJAvrw9/kqJnZfqy2nQFNKPeV4ZfMf/7Fhdkfpl9FXMiKZEpG3WvXbV/l6G5VJgf/hRaihXEh336xM8QnzSeS9VQWUfn6eC0RlthgeZ0ngfTiHhy5Q5klhGGnVnzRkDZnphVcX74jCviUykpTx87GaHgNuygD0Hm5eJn1oWojWawCuhg3x3U+vzs30HAMLLJgTXCEqT/Juw9Z5EEr2XfoOpqThZJc7tcs+2lj5xmoiSEtNuFjWKY1TRCBIVfwpRkZwCJGsxUK6Tcgl9Q6gbCl0MREO/DZJlShw0Jh770lR8mGg==
Received: from SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:9b::8) by
 SY6P282MB4005.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1d8::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.31; Tue, 18 Jun 2024 15:03:51 +0000
Received: from SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
 ([fe80::ac24:7d2b:92fe:20c3]) by SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
 ([fe80::ac24:7d2b:92fe:20c3%2]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 15:03:51 +0000
From: Yuntao Dai <d1581209858@live.com>
To: jassisinghbrar@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	unicorn_wang@outlook.com,
	inochiama@outlook.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Yuntao Dai <d1581209858@live.com>
Subject: [PATCH 0/3] riscv: sophgo: add mailbox support for cv18x SoCs
Date: Tue, 18 Jun 2024 23:03:19 +0800
Message-ID:
 <SYBP282MB2238DE0DA19C6EF411B2356CC4CE2@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-TMN: [wzzAo9agJ6Z2G0H/2MwcClOf3eAtPNmX]
X-ClientProxiedBy: TY2PR01CA0021.jpnprd01.prod.outlook.com
 (2603:1096:404:a::33) To SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:9b::8)
X-Microsoft-Original-Message-ID: <20240618150319.4649-1-d1581209858@live.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBP282MB2238:EE_|SY6P282MB4005:EE_
X-MS-Office365-Filtering-Correlation-Id: a06af420-65ae-4005-16ba-08dc8fa7dd15
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199025|3412199022|440099025|1710799023;
X-Microsoft-Antispam-Message-Info:
	JcUjd/HhSzjOP+3a8bUkeLMdggUJpR0M3SeIDTTuksDU6nT2jQ/06Pha2O9XQ2CfMQap4/9ML5lZ3RU761V19TFigDyaROdjxwVT336LOolCzsyJSgWi+F5rMyxkmXb//2eX7G+RFPPBV2rHaTOTa5/yMt518PdJD4fVTjL0U+jW8BrjLEQfWFYki++ue+YJLByxbI1mcfqT5BAhEVtTJSipxHEJQssFx34W4aP6IQfZruzLFCt2ELVVla5gJW8G3RZEW8TJnhz3fIcdr6MBG/LkTyIA8M25GrPUzf/ujQ83Wx9nWxNw4ru5UXG2fMNpRxTa7Oy+NQfN6J0qaytG6282n3LBUrTV7U1WAoOTq/Em73lPfSDXXTyMlTIHkzdsriBQ72H7ZFCRilr8QwofnxgmiGH+5+d1nznJoGe6pIEOUDlQAN8RAllMqbe0ee8IYoa+1bpO5EzytA9ndeF1uTbfrLjRhXJxl/YwMHX2HWp4YqfZ7L2keCULrxO9LFduhnXlmiOrELFWmG4WUUUkJofDj7XD2FHbk1CAX3hg41mb6Xrw2wZof7CqlWlwOo9b1zyZuE5BLXfXlVrW3YWaUVLw1IcZoVi8K/QM1JKG9H4=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RwMQUuZsJCxwAozzv6tVvtLNL0ykm/WL8gZ0/2tKTJNwkYj+2XOXoAtNcymo?=
 =?us-ascii?Q?LRpu2c+FRTZbm0LBaxMNq4N6z5TRynK3DXEGiKBVs25y3Z7VmYzZvr5iHsw3?=
 =?us-ascii?Q?opmKTGgtlhiCdaYNzOTxlVuMMVjTzTwVaw1ioD370NcbENOcuP9QhroHXQru?=
 =?us-ascii?Q?06wjPk8Wnscu6QKKXEcHLKi00BZvUu1gV4DuryM4u8QXPSWGdZ0X5R9vN0s0?=
 =?us-ascii?Q?AT+OAXKe+tXT/1a2qR2aS8m5ywJkO7cHR8WrzJi4kP/QWQ02kvCsoWlBi1JN?=
 =?us-ascii?Q?0h6hUpwrJsf6xhe0eCcRb+YZv+8TTSxf8g/4DEzb+4Dy4IG4oG/rQoSCAPXW?=
 =?us-ascii?Q?Oq1ZLOclqz/PTEaB44iyluH974RUbHBZZIbZBqJKYswcEG83nZ2GCGOWfwIq?=
 =?us-ascii?Q?VSCHiyf40eTl8lTmSiucGFI9e2aQz1S1kqVJNRQ6vArA3gwqyK9LgTlyMuPo?=
 =?us-ascii?Q?f6ul7EDrXaAunoD+aWbsvlpzEYomWGim6HET5JXmWmUykLxpTCXiDqwJ7qUI?=
 =?us-ascii?Q?+8VzNV0dlocjfOMtWga67T1Z7CzHoybla68Sd55SHWeiO/pxSDTPUSaSIyvY?=
 =?us-ascii?Q?7JBi87QsVCUQvqCeyf70mmAeY5y7vk6hTVeFSMu2U65QaUbQzscrEDum14eL?=
 =?us-ascii?Q?c7u+mSgcO7TqHEgxkjcEbXO6ZaHBg80PywKFHmShkXkVjMcX4MXLr0h2sU41?=
 =?us-ascii?Q?J4CJR9nNOG7f+M0VDTdyQafSVSI1xxJT1cKYsBdz/H7KZtzHyuCj9rX/puYT?=
 =?us-ascii?Q?H8KF+9+5SSG7qv+xR6+9LIrhCObGAQml8b7MYfeGNq161rboeqyB6u/9oE5k?=
 =?us-ascii?Q?+hgfZyrDnIv2re4ukIFjIQ+HjCaRrGWcWICRRe9aaASSbBoW9uRSFXudBLve?=
 =?us-ascii?Q?e/b/CgDafj7WscUbl5uTqjWllFHRyNaz3vJGTgekAcpAA88tQMsPd34ia5O1?=
 =?us-ascii?Q?nYR2So8vDyaORCjCZmsmQw21KSMJ8UG5mB+58RXyYmXTIT5Z5pgP1QQ+9+to?=
 =?us-ascii?Q?5THTOTEFzZpojA50G1u14NIs+62Ys3tKBDbL+9VXSVypMf7UMsqWF9lwNktb?=
 =?us-ascii?Q?wa/ZYqEqVZB5Dx92TbSFGP6USEwu7C0ano1Nm+v9ik1HIYWfEFAjMLVW0s0G?=
 =?us-ascii?Q?3fTG6J4OvmYJvy05ja0HWa1XGp270fX7WwWWa04hVGcK0Q680T2vZbaRc9ca?=
 =?us-ascii?Q?QVbq6dHcmKeuCpizd5jC6ZcKyq2P3SKNUiApIgcN4TFIBAKzPCq8xiWgcCk?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a06af420-65ae-4005-16ba-08dc8fa7dd15
X-MS-Exchange-CrossTenant-AuthSource: SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 15:03:51.5615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY6P282MB4005

Add mailbox support for Sophgo cv18x SoCs, and test on both cv1800b SoC for 
milkv-duo and cv1812h SoC for milkv-duo256m

Yuntao Dai (3):
  dt-bindings: mailbox: add Sophgo cv18x SoCs mailbox
  riscv: dts: add mailbox for Sophgo cv18x SoCs
  mailbox: sophgo: add mailbox driver for cv18x SoCs

 .../mailbox/sophgo,cv1800b-mailbox.yaml       |  75 ++++++++
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi        |  11 ++
 drivers/mailbox/Kconfig                       |  11 ++
 drivers/mailbox/Makefile                      |   2 +
 drivers/mailbox/cv1800b-mailbox.c             | 182 ++++++++++++++++++
 5 files changed, 281 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/sophgo,cv1800b-mailbox.yaml
 create mode 100644 drivers/mailbox/cv1800b-mailbox.c

-- 
2.17.1


