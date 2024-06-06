Return-Path: <linux-kernel+bounces-203946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E31C08FE269
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2691B2B883
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D70E13F427;
	Thu,  6 Jun 2024 09:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="xJnOkgDR"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2137.outbound.protection.outlook.com [40.107.22.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9371A13E8BE;
	Thu,  6 Jun 2024 09:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717664649; cv=fail; b=GCOGV3rxQC8u5a7iWwM14hSNZeATTI8SkmIpZ8AuT3I55FutLno3d2vlDNOfNvbyHNcWkI63Z4d4O8H7xclVNyu0ObGIpbXctmeusp8OLeFNdq3RpgGMo0U7r0160F1LxzSeWoO2nXqZ1fvl4Bb5FV9oLge3LnV51j+wpZF6hFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717664649; c=relaxed/simple;
	bh=aoQGd5ZliRw15hKnZTHa2KKfY2LRQ+HHwl3dLCuDzEo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=LL8SYLrR7owQ3EUZ1fXXyXKndyg02ZXVv8arYHKmO9KhqJRU8gSffzyzprJPcusjGHLMjsA4JUdSJKAVHAhhdWra6lgWO0PUuQ2X4B1TgkSmO6jRnTlMt2gO4h2Dc0cPJaTdN+QVEENsjjPooczPU6kkcbLIpbsIEqZunbUfdbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=xJnOkgDR; arc=fail smtp.client-ip=40.107.22.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VIFHoQhVJIh1gUvFbUPv/BsQOSCAvful93BDyDkmWn6Hk5nhAA89oz8tv/wIf4/XbtYfYposVgwVOfa+SEdE0lzNr6eMODWwPI2b9z1mgbT9XmqpcnC47tTHJQNwVi7aCyYknJcvgDydHjlHJTMyL4lCcsG00cGhnT7jRsWXBJ8hlzotrlw+waSc+vTPD9272Hgd265ZGAlWlqfjeItdcnGjr5eqkE3T4HRYOidykzOBHhHuFOjtwLF4gnq71hO3VlJ1piMm8L3izRfAXaTgnF+li21fN+j7sQlCIM+Gf6djZm+lXQgNqK2rXkfmyMjx+KbKzR/PKuwTYHJjSQT+Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAB2FzZBvrU7LxEpBzwymNV0PbYDBiDtlljYTeMWBt8=;
 b=iFSyJWdqGKFINUu9ECY5uA2u2AEn6BP9ujlizlHnIh/5Yj74ZETn5hevXxkKNcNQpczA76IAN19sQ4dTZ3xr12XakcMi8RUH7N4Q7Yzx4acOb+BsoWGkwe4wXAZZV2cWESXj4t5qbJP43J0iiX4vKig50D0FydBfqHlGrKeE10yRu8+75PxyVr2xINTPD/CGL/2E/Bl9Ut3R+SPVJ2klRit7Hwprk7fru23P/rd9tM7BMVZ40+YD7Xnum07PhYK7VoJypYWpdG/Kwg0UfVDZqJ9h6DZ+WEabtcJicc2xrMJwOFRNqR/D3MNr/gO9h8Ym45eP/+lDHxmjuNAkwBSd+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAB2FzZBvrU7LxEpBzwymNV0PbYDBiDtlljYTeMWBt8=;
 b=xJnOkgDRqJYcZIW47xe0Ru0JeIfIwGx3QZubukBR7bt8lNxr0Crz7I1ZBik3EIxTPKKa/JzExabr9sQoN3ppjwx/y4QY3KW0IpqAvvICqXMc8P9RYoforqAeMOnmPc8zcm5ZM5nP8CG12YWNujiCqQ2gRW4lhE2d4aSzxuSjZzc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by DB9PR08MB9513.eurprd08.prod.outlook.com (2603:10a6:10:459::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Thu, 6 Jun
 2024 09:04:04 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::a08:11be:8709:f5e1]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::a08:11be:8709:f5e1%4]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 09:04:04 +0000
From: Javier Carrasco <javier.carrasco@wolfvision.net>
Date: Thu, 06 Jun 2024 11:03:56 +0200
Subject: [PATCH 2/3] usb: typec: tipd: add error log to provide firmware
 name and size
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-tps6598x_fw_update_log-v1-2-2b5b8369a0ba@wolfvision.net>
References: <20240606-tps6598x_fw_update_log-v1-0-2b5b8369a0ba@wolfvision.net>
In-Reply-To: <20240606-tps6598x_fw_update_log-v1-0-2b5b8369a0ba@wolfvision.net>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717664643; l=918;
 i=javier.carrasco@wolfvision.net; s=20240320; h=from:subject:message-id;
 bh=aoQGd5ZliRw15hKnZTHa2KKfY2LRQ+HHwl3dLCuDzEo=;
 b=KqpqGvn1uyKtq2if0MePRVBfvfyMu9hlH2Q5e2y7WBhrV84kmnAVYFPdC8AnYdRjrBjDckOiC
 3cSuon7ILc7CycDQN5XEQ0tBIiX15GwD8SCCMcoAnnIrFaeSSkAw8nn
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=Vxk2/0sGIxM8rsKnceszFuSuHVfQwa1Yo8+is7BX2nY=
X-ClientProxiedBy: VI1PR07CA0310.eurprd07.prod.outlook.com
 (2603:10a6:800:130::38) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|DB9PR08MB9513:EE_
X-MS-Office365-Filtering-Correlation-Id: 7501ae53-f733-4cd1-069b-08dc86079d2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|366007|1800799015|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UmZSSElETEFrekczQ3RjdjZSZWpoRFNkOHhydXNMUjk4cFlxbnVzZDlnNnhQ?=
 =?utf-8?B?RGFiVkdlOVNFbFBCNGdTNE5UT0NrRGxsaG5FNVd1NzIrcWxMdEhER3FUZTRM?=
 =?utf-8?B?WkdnT1A1SHEyaVNUWGlTZVVQVmVWb0RUdUxlbXFHVER0QWdiT2pGMDlrQ2dL?=
 =?utf-8?B?c0FqTVVTWlNNekNlK1RaSEg0cE1aMnMrQ1RXcFFpanFkcW5sWTQzN0tkeVYw?=
 =?utf-8?B?dzRlSGFob1VoQzI5OWpWSU9YdWdRWnFwQkZJYmswQzJVeUhjUVZDd3JPRVFY?=
 =?utf-8?B?S2plb1gwRlg0S3ExcWU0N0tuQ0RqbGpPL2g3c2VtS3B2a1RnNHVWN2M3cWVI?=
 =?utf-8?B?UEdRQmxxV2tiSFExMG85NUZLT3N4ZnpRWFlXMVI3YTVUTUpOUGMyV2pLWWdu?=
 =?utf-8?B?V1lob2V1TVMrTWF2bFhuQkVUUXFPNlJzUXhKYWhjeGtoSmpjTERXVzBISmE2?=
 =?utf-8?B?WmdDdTFjcVNiZTRQOFZTa1JqdmR6dXR1amVrYk9mRTVza3lWZC83akRJK2FF?=
 =?utf-8?B?dlN6NnZKMEQrdXphZ3oxR0JjaXBsQStjNW5OaFdDUnBSZlozNTBwVWxZNWM1?=
 =?utf-8?B?RUdMak53WGNneW1VUEN5Q2dFRjc0NlRzdDZxdXhtS0YzbDdLbGFDVGJEMzA4?=
 =?utf-8?B?UVUxZFpwWkFCNWhBd1BXUXJtNkVlMjYvaEhUUUkvZHhHRW5JYVM2NTd4ZFVH?=
 =?utf-8?B?cW1PR3JjWllPTHB1LzI5dytsdHVBTHBHMjJ1NllabmRpYmcrMkgxSW5aaUxT?=
 =?utf-8?B?YndDamlXUVFSMm1vL1hwVTZ6K3ZJVFlYM0Y1b3NTalJkQXJVb0Vzb1d5WFZI?=
 =?utf-8?B?aEs2YmE2MGMrQlpQRmNDNFhTSmxYVFZmSytDOHFBemRiZ1lkdEMxU2x6TWZw?=
 =?utf-8?B?TC82VllwYzZTVnloTFJBc09SSm05Q0hXQ096UTRQKzR4QXh0OVU5bWxucUtr?=
 =?utf-8?B?WHpweXdiZTdPcGx6REhWQ21qVTRnaU93VlBUOE9DTEx2dE1IRTNrVlFtRlRm?=
 =?utf-8?B?SUxnSWQxLzlBS3dRcXV1LzlVNUFLR3lXYWRHaFhDdlgzZXljRG1mejlYVFBE?=
 =?utf-8?B?U1kwb3BGR2owNXNLQnN5WVhXakw3QnFIb0RQa3l1T0F6QlNPL2pQSVhqZDRX?=
 =?utf-8?B?QmxIQWRjaExyTVg5Zlgxd05yckFGcUxOMDcycXhySnhSSTNjaWNORmdUK01M?=
 =?utf-8?B?S0NWaEExVWhhVzUxTThITStuNmpqVkpoK3ZnbU5Tdk1PZDM2OFRVcUptNVAy?=
 =?utf-8?B?c29BOTVqd29BU3JZcUl3c1FPODhUTG9QQTh5dUxZdXIyWmxCTDhVS3BZOVFE?=
 =?utf-8?B?Zlk4cDZVaXk0eXErd29mWUllbnVzVXFEQXRkWDIvUm5hWnZqMElVK1QxY3JR?=
 =?utf-8?B?dWpucGovbFNTdUNzdE1id0ZqUDRhc1ptaGhsVEFzN2NxQWtBTzBSQ1JqVk9P?=
 =?utf-8?B?RXdPbzEvTGdnZzBnMTlnVHZaN1NPS093VG9laGh6bS9SU2xhRG9MYktZcUVx?=
 =?utf-8?B?Wnl5Rm9Gb2RnQTY2bWRtdG1MMzZFaXhKSnZPekhEQ1dickZkVFVCdGo1WkxD?=
 =?utf-8?B?UnVTSG9tb2lJcU5XbDU2QW56WHVnMWxHZERCTmlMM21NMkZBMVhucnRxemIr?=
 =?utf-8?B?NnovdHNRVTFqR3RmaXR2aTNCYUVnL2NaMlNaUGlmanAwemlTUEtadUIzbGtN?=
 =?utf-8?B?dUJ1OENBM2ZUQVpvcndGV0FTdTVTd3ZXSnVNMVI4UVJMdjdaeEErWkNLOVRH?=
 =?utf-8?B?OFZUVHRtSGdXYmVkL050MWlqYmo4KzM1OWhGblRUTlAzNllXVEs4UWJCVUhl?=
 =?utf-8?Q?NksnzsoXiQBtSE1Tm3Cig6z+Aaj/gbj38zrs0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzhlVkVDUC9mS1VYbTZVY2tHLzd3TVhKWXhoUE94anBSZk51TGlYKzdNekFV?=
 =?utf-8?B?QWNaRm5UdkdZLzdpT1l2SSttTzB0NVgzV056NmpqMzJINDhqdFN4MVAzNnV3?=
 =?utf-8?B?UnBlM1F4WGxuL2J3OWY1ZmJjNktaa3pIdXBPY2szNU1FUGRaWHAyWU01WTdW?=
 =?utf-8?B?dzFTc1NrS29lYjlHVTBvS3B4OUNWUGVaaTEvVnRuTExtYVh6MG9JNEZ3eEQ1?=
 =?utf-8?B?YVlQbWhYSURZZWJ4dGREc2dSbnBzQlJydUVQRG5heFFJU2duVGVycHFzUTMr?=
 =?utf-8?B?SXB0WkpUVEQwRFB4R2ljQm50aHZUYUM4amtZNndYaVg2WGJmOG9xWFhSSFdj?=
 =?utf-8?B?OTZvaWZaQzFDdDV5UFJZVVJ6ZTRZbWhhODFINmppTFVTaXhMMHhodmthR3l1?=
 =?utf-8?B?SUorODZLcnFsUWpUVUo1TGVFUmN1WmNoYnJOdXdNU0F0aW9ETnNxZHRoTUdI?=
 =?utf-8?B?K0QzVUFNMWdscGJiQzVSamNidUc4ei9WVnphKzM3NzA0THlaUG9tNkZSRFVM?=
 =?utf-8?B?WlBlZ1hzcCtRTjF1SU5rM2IzeUhHaG5yWTczbjJlYm5ycVV5a21IWllsZmkv?=
 =?utf-8?B?TFNyMXozUzJsbDRINlJmUUFDMFN3VVZyL3l6NkRJQ2w3WFlUK056d1lTYkRq?=
 =?utf-8?B?TUlFbVRpbjdRL1hBK3hxWkdrNWZjOVJmdjZXVVo0NE5tRk9xdjV4bFdWdHZR?=
 =?utf-8?B?LzNLUUxWVlJGWTJ1d2F4Qkd2TElacWdwZERpZElIYThyazFpRUV4eVpYbGQy?=
 =?utf-8?B?M2htc1A2QkQzbmlQSkxMdW9LV3ZRU2ZVMEFXZmpTMlA4SGZLS3Y3QUpyNWhP?=
 =?utf-8?B?akpqeU42L3F2MEUzdE5qdk5ocjZVbUJIU3gyTmlpNzFjYVNHQ0FYWGRlRDBU?=
 =?utf-8?B?bUNKYU1OSTJ4SXpZOGIycVM4Qk11eVA4ZC9PZVpYcEJuanFTb21ObUltTGZE?=
 =?utf-8?B?bitFYjJnWDBwaFpyb3RpZWxWVUxSWE4vb3ZhU1pHQkZFUnRKMERuSWdyYXpS?=
 =?utf-8?B?QnBPOEhDQ293dGhleHYrUEk1ekt2Q2p1QXptbmZOV21BSkI3NU1kbWsxYktm?=
 =?utf-8?B?dUFHSnM2UWZhcHBUb1RwNVp1Q1cxUEs3YTdlNVJpLy96RFdjempIYXVHM1ZY?=
 =?utf-8?B?WXVUZzZieUV4T2E2SXg4a01WYmRHZk5NWFRmaHJBd0tiLzVDTExXSEEvU2pP?=
 =?utf-8?B?MHZQM0JLelR1WEY0L0M1UXRTR1JNcW1DMmZYNXVQdGhRY3FvMllUUjdzeG9o?=
 =?utf-8?B?QUxuNk9xVUkrcjI2V1d0WnU1eXJDY1hDTHJGNUFPMWx6MnJnd0JjdStDbS9l?=
 =?utf-8?B?Y2lWdURmU3Z0OWloQlRtaTE0MnNrOEdPL3I0a0Ira21pZmJIL3R1QkNFNFpi?=
 =?utf-8?B?cWVDUjNqdEhFR3BpYWh5MWhNME5OdWg1TTRtWFNQTEJnd2ZndldKUGN5aXR1?=
 =?utf-8?B?RUdQQWhRc3JWMWQ3eUFLU2JMZzlLMVNOOW56R2xETk00aStvdkx2dlhBdmRa?=
 =?utf-8?B?aWp1amdSNnArUnRZM0ZjMUdCbWE0SS8xQTFmQVI4NlJtbUdiQmJ3K0JFS2px?=
 =?utf-8?B?aE54WWRLdXFtOVRjUFM3MjZWRmNGc2lwTWtkLzN4TzdQZFpvbzdOLytiSWE1?=
 =?utf-8?B?YURBUHVYQ05YVDltRlRoN0F4Um1UaGN2b2pydzJTWEtjWmVaQ2J1OEdtSnNN?=
 =?utf-8?B?Y2hRK0hGTkVJYnRFSENGUktHd3NYYzNMTmtvK1JkNVYxQ1B1ek9qQU1zVnpO?=
 =?utf-8?B?OTNtTUdWNXVPYWFqdG5rUGp3dlB2cjdubUV1elN2NVQ0QzV4TkFnQ0ZpcWpS?=
 =?utf-8?B?Qk9xY3R5bE9IWlVGTmNkenZnUFhzWm13WnBWYk1jS3VmQWV3ZGdRd0FnUXJZ?=
 =?utf-8?B?L3JvUlNqUk9PVFJxSlVYbkxNejUwVXhtZGhQUDdud2hOUmgyNWk1NVhzSUVL?=
 =?utf-8?B?TW56RjltUjRrYTdkclpMaUs3MFhXamxoTEhuUndiZFFSUG1IMGIzaVN1aG5a?=
 =?utf-8?B?dkVGQ0w3ZmJkUmNoU29NdUhUa1JZWWw1eVdYWTRhR01KaHVNMmNJSFgvZnY0?=
 =?utf-8?B?QnAreFREczdOYmwzd1JjYVhLaHBZUFdkZ0tZckk3bE9MVVJ6aTdHL3VBV3Vq?=
 =?utf-8?B?Sy93MUR0QjNQVXhPMXdNY1p3WERoRm5jU1hKTXRSU2FYZjZjRkVDZGFwakhs?=
 =?utf-8?Q?1DAoF3OIBVhVGmjtPU3Wl4o=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 7501ae53-f733-4cd1-069b-08dc86079d2d
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 09:04:04.0570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QnupOk8Y7g0SqtjlwufvtXey6sqeZSIKO+sM6wVBdMBd3tQV8PWvQFgta1vVS8nAIy3XrksKnwkItSqK0nYDoIBYj0vHu8NI/epQ/ZWnTz8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9513

The current error logs do not show the firmware name and size for the
tps6598x. On the other hand, this information is provided for the
tps25750. Both implementations have access to that information, and the
existing message for the tps25750 can be used for the tps6598x without
extra modifications.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 drivers/usb/typec/tipd/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 851b0d02727a..58f6eeffd070 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -1195,6 +1195,10 @@ static int tps6598x_apply_patch(struct tps6598x *tps)
 
 release_fw:
 	release_firmware(fw);
+	if (ret) {
+		dev_err(tps->dev, "Failed to write patch %s of %zu bytes\n",
+			firmware_name, fw->size);
+	}
 
 	return ret;
 };

-- 
2.40.1


