Return-Path: <linux-kernel+bounces-169477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1276F8BC93D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDF54280C6B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 08:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237B9140E5F;
	Mon,  6 May 2024 08:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="H6rDGFS3"
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2097.outbound.protection.outlook.com [40.92.98.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B161D53C;
	Mon,  6 May 2024 08:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.98.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714983293; cv=fail; b=M270nN/cRXL5bFbF9kXaQde7lp4Lm7SBJMV0XxPQvxc1oyYvHo34wLa1IBqQhnK4/wHMDU+cSdo2TKHTkVs4dRT/Dy9H8bavq/GdcNLan31zoDtRROr4romif/miUjW9Ek83r8lOM+Uqc2yYFxo0odIC4KOXasGSQyZWeENBg8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714983293; c=relaxed/simple;
	bh=6JmpfOebZo/6eLtqsCkAFXR0oo48itbS9AlRD8XBY80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aGRTgmfkqdhlhwcVXfdEhZWFWdmpxCzRmB8NuI8ihXeOVTIhXxS+lkSK5TVbeU0vuFy2kkhWi0aXf8QJOfBM5SKFlcCLS6jC5XZY+MowEMsaeGpMBwoeRqkaeEvWV1w//Iki09gtxS27Inlaoyv+NnDeMOmR2L+L9N8ImMkJEl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=H6rDGFS3; arc=fail smtp.client-ip=40.92.98.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6opQWMTcio+lb3TD//2nii4e5BFoGUzqm1g9H/x7DU8Ru2ChqVAZM5LF3pkruRuZNXYk1cpUzGcSMuv89uMp+NjEEchPrDTMvx93ddrjUTFnKdIB6VvPfrsDp+8krWkx0bkfPqylhxjDZ2vQFJg7BBnSILZdu2MNMsxcQLivWSXtKsooBzG4h38vS4KyNPP7oktF5WUO+a30QfSLgQgu/DxOIDgRIH3juz3ImXbLCxBst3F8uITstSM0IzoisLjzjoZIjntol1HcOVJAcY0IRtdSXe89uoF/gwgtghJm2hMjsUBIr94NUstOG8iEDz8dkFz8YYweLCLFWO8ezDdKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6JmpfOebZo/6eLtqsCkAFXR0oo48itbS9AlRD8XBY80=;
 b=cxcGSZjQwJTnAInU8Ts9YVK9XY0czlxtOXZ2PwEI32tebfD4jJHUhmSFGI8zQkKvRHJVMTGbGDw2IUedQAfmJ7INdxGSl0qu+ATaP+nHMRPJG648c0D9kPgB6xlw6A9+Qg/fESMFlQGpGPfMRs3JocJbiiwTaGWIwKDR9co2bitEvbLdltgtuhXjwJPvR8d3HeIAmHsp7BbkXwkQj4pD8gnYKR8O58KgL0znFPW4MenE7Rb3hWRznVIisYo9IsH1N0of734a07TUE3oswsuqXBcW+pfC1yrOfOzzzy7q3SgnnSzcTkIE2s9L3TIMEqnrgDNfavFU4Xc5ibq0hdoWPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JmpfOebZo/6eLtqsCkAFXR0oo48itbS9AlRD8XBY80=;
 b=H6rDGFS3VOCCRZA+aSZKZygxEUutDfJ+NkJgayKZ7/mfVJk4J7tNhLsYmvXVfp9mV5nOuorGmlqnNsZ3Py5ZM50ZrSPJPQDOO0zk9WuIEAPkOFO2XpEONq3UpzpSpnGb6WtjRgPHKtY1OhiMBGPT/jyDRQu5PMnTDz2oBmblPT/yUwuBom0b2pjeqV0HBxx2fNQQKFNhjV/QpT26dad+all93KXf2H46MakEKjZ5OsTmbfskzcYyVwLkFa5fEoJWzJB7/XDK8/BnkHXUD8DPXPkAtn1c4u56NZwTkIRl92PQNU1Uhu8mEsibTsy6hdSmDtoXHDmAsPqkEpfQen0QSw==
Received: from TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:209::11)
 by TYTP286MB4105.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:184::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 08:14:49 +0000
Received: from TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f2c3:e53f:2ea9:55c8]) by TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f2c3:e53f:2ea9:55c8%6]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 08:14:49 +0000
From: ArcticLampyrid <ArcticLampyrid@outlook.com>
To: tiwai@suse.de
Cc: sbinding@opensource.cirrus.com, linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org, patches@opensource.cirrus.com,
 rf@opensource.cirrus.com
Subject:
 Re: [PATCH v4 0/1] ALSA: hda/realtek: Fix internal speakers for Legion Y9000X
 2022 IAH7
Date: Mon, 06 May 2024 16:14:44 +0800
Message-ID:
 <TYCP286MB2535C22748EC6F5ADD9AEEE4C41C2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
In-Reply-To:
 <TYCP286MB2535B1F07F7D6E7045B5CA69C41C2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
References:
 <TYCP286MB2535B1F07F7D6E7045B5CA69C41C2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-TMN: [JFMQhsL5WDxO2sEXSLco49GcfND5ymL0hf1iEphgJKM=]
X-ClientProxiedBy: TYCP301CA0005.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::8) To TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:209::11)
X-Microsoft-Original-Message-ID: <2978111.e9J7NaK4W3@qlaptoparch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2535:EE_|TYTP286MB4105:EE_
X-MS-Office365-Filtering-Correlation-Id: 3407faae-77c0-45e5-4064-08dc6da49919
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199019|440099019|3412199016;
X-Microsoft-Antispam-Message-Info:
	7gfy4frzyERR4nmv4oekIp2iv68QNSvIUh6VOsmGpy5nPHEVhQwuDX26aMi6Ff+cURM+9uN8AYB9pvmxa7u8ue2vNIQGkoR0Qf5IgLms+Cjvgon6wHpVN/eyI80Rv8nEn+JhXlB7ZA5tptFo/nNoSI6cCGUjUGKF6n3axZH7+1Np50idM5p29JwC1YyY96kRknV7+bSrUruSk5thimgPneOnclecdJHnwoCTsaHRFqRywImorYOpfsSYqSg3kYOwmunh7VByPKdWyKMn2V84dQpneLH4Y7lfYeLef3IEG+cfnHd35DWkHIcmxsmtJYkesEnBDla0xVbGk4rxjDYRO0XSUoSdMg7A4QmyXN7iHIgni0tycfHpX+uizgrR5oUXOKkp0u3D8lPEoyCAIwlGekfxnXkSMVv9Q1ZNnRE0ik4w4T31G8heAboMe2wVSrTGnJF4gjZFny5rK8N5cSUp35DaEMiW5SdBFb6SBv064sBeX0pFm6DABd4ZTN7xw66UHNUPH0QvQEKFSMqaYitXLzRlqJ9HpSxBPc5GgIj4YyJ/q2oEUJjSa7zMlD3RdJPNSW0eC7HEQ3le/OE+eVToDrtVWjMELITzScHwCaHT2E0=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFFwY0ZyTDNCb2tJQW1lQjlhZFVqZXUxeTc2aGFWeThmS0szY2hhT3hrVUtP?=
 =?utf-8?B?T3M5ZkZZSWlMVWZwZ3pLdVpTT0dWMFlzN1hTTWVMWTlIa25KelR2L3BlQTVm?=
 =?utf-8?B?MHBEblRTU2tEeEcxSGoxVUZtanN6dkdmRXFRM1UwdW94a2Vzd2tZanhadWF5?=
 =?utf-8?B?cEZDYmh6N0MzR0E3bEV3TlVPM3ZGeG9qSlZDdkh3NEFCc05oV3dQZVlkS3lZ?=
 =?utf-8?B?Tm1LdVhNc0N3Ulh6V1FwTDR0SWxnbjRrQzIrY1A4WTRsQ1hDdDVoUFZoM1BY?=
 =?utf-8?B?dUhjNmJ3NVF0elNlMDFXWk05bWdUOTB0Qncxc3VGd0N2citGTkhkVGxjY0V3?=
 =?utf-8?B?aVIyNDU0S1FBRCtWQWRYYWlVbFJ4Z2dFd3dQazd3TnRIcWRnSkhqcFdkTUF6?=
 =?utf-8?B?MDE1VmdSMUkvN2xGMkVqdWsxYXVjMm50cmE1VXFwMlNtbjl2Uko2RTVMZUpB?=
 =?utf-8?B?aWNnaVRobXlwelFJM3NIN0VNUDV6Q244ZkRMcHZ3VU1qR1cyekxvM2JUQkZ2?=
 =?utf-8?B?UndhRWxMb2dQRlBoZUdLSEw3b0o3L2FSSWxIb1h0bjJxRzFaL2xhOUFMUFNl?=
 =?utf-8?B?NDhyT3ZWdWF1RHJnR2hNN2NLaFZ6aXdqekovRFc2TksvMDJqMjB5ZDBpOEVP?=
 =?utf-8?B?bTF2eWZCSC9tYlk2Vk1jRzdEZkFncE03UVhZb1BHdjJuWlZZSlFGZUxjVXk3?=
 =?utf-8?B?TXV1b2dlQnpYQUJpd3JCYnR5LzBkMS9EbFNGK0FlSTJqc25LYXdKNVJXUXdQ?=
 =?utf-8?B?dGlJcFplT01hMVUzK0FIM1FyZDVMeEJXV1B2OUJhaXZmQVBOV2tNeFdTcWow?=
 =?utf-8?B?VWgyNXBJbVJCZVF0ZnRzeTJaZndvS3BvNlIrYlM2bjBRWkFHdkNuVG04NTZQ?=
 =?utf-8?B?ZktYM3BpOUV1TnlCR21qbGh5bk9ZSGhCZWwzT0lRTFIvZmRaZkhEZ0xVRjBM?=
 =?utf-8?B?Z25HM1BXODAzbDA4ckFUT1ZyMHBhbXhuMVV2Wit6RjNZeU1VODNDbktRUGl1?=
 =?utf-8?B?VFRJbnl5WEIrWkFZbXYwUmdQM1BydFZjRlZqUVlYL2JwL3JqNGFtSnNaYmRH?=
 =?utf-8?B?anE4Rzlsb29qR1BNVHpIM1NMc0VQbjAxQjNXQUVmK2pGUG9MYnZsaWlKdmR5?=
 =?utf-8?B?ZG5heUduZWpEZkxZd2N2SXh5YmNmbUduZzlXdHY5YlBydStiMjM0SGtGTW4y?=
 =?utf-8?B?cGtYR0JERlg0YkZ4cUc0RVpibk1MZlFIb3FWZFpGVHBRWlJ5ZFZseEtVY1BO?=
 =?utf-8?B?dGNkV2MvWXJQbFVoU1JJcHFMRHdGNjZlRTNsbHpOTCtxKzRiNW1aenIydXVD?=
 =?utf-8?B?QzNqSlNRdHBPanc5WFlEVDY0cGFzM2ltUVRLcFlSeXU3cGwxRWJ0SDVXNTFi?=
 =?utf-8?B?a2MwNzA1Nm1iSEpmOG5wYlpmT1lJdS9OeHB3OC9KVUFwekYrN29RVjdMd09E?=
 =?utf-8?B?cCtCaVNZREpuRTJGbnBqcGNwTWM2K1o3NXVYTjJWT0kvUVFJdDNXVGVoMS9v?=
 =?utf-8?B?QUN0ODhYNzdrQnE4SklEOUd5bGh4anpqRW9sam9VbmcwbGNORS84NDgxSUhv?=
 =?utf-8?B?Nk1HdFRYVkpwSWRWSkYvWFB5bVUxRDBTV09PcXBJQTdpYjhqVWpaYjBackRG?=
 =?utf-8?B?aWROU0lTcGw1TFRlV012RWhweTFRNllDZFBLbVhuQk5kSk9VSHh6UG1takIy?=
 =?utf-8?Q?HhJ/V+ITy5W50sTIlNNa?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3407faae-77c0-45e5-4064-08dc6da49919
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 08:14:49.1730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTP286MB4105

Track:
Resend here with correct From line: <https://lore.kernel.org/lkml/TYCP286MB2535E8C7B2F9E7EDD75C4382C41C2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM/T/>





