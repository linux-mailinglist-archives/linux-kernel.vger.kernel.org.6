Return-Path: <linux-kernel+bounces-354656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 941929940A5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13B6B1F21999
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BED205E36;
	Tue,  8 Oct 2024 07:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="TcEKpRWQ"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2132.outbound.protection.outlook.com [40.107.249.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57EE1DED4F;
	Tue,  8 Oct 2024 07:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728372299; cv=fail; b=Y609gMqAO6LYR5SCz5X7EqgYJ2/bWEwJy0PVW59OWfv88RFI5I43C3pHhKOlPgkoBkXTqUOBtVg4Z+qAgOFJPFu7SjXeL3hEO1MbK/npEDYkEcAFJTsMBpXRH5twhy0iKn/NQuqeKIsmhmoT66kfRbcUnVPDw77QvXhRJzkjeD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728372299; c=relaxed/simple;
	bh=YBaq6H8V1HlzBhYqc9ebw6t2RqejoydJaD5y1NS1pHU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fQ2qkwp+6+QkpjJtrJJrP1v2mJzL767IRFmubCfhDmhY4Jh3tW12RkYXPQvZdnCZb1J3Ub9aCva98ZGwhjdlsKELpghMe5tU3LhR89cFlxnkAgDgqOjjJ0sm12NlcupZ8vZI560cLSOUvYyPiCkUFpYhUbpCqUCPosCW/Pn38xE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b=TcEKpRWQ; arc=fail smtp.client-ip=40.107.249.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bw4dRk8lBgD0cy5lyAegUWb8MPSeDFCR6DljpFRXwsL10GdmRsjVydBC/uJh19Gq0xn8VbK3rsLvZwsFRKpDXguiDIV+hfn9ys1oBW7eVCFTwsC8580pXhmrVpbK6RvPxQADTbB41A3tZj56o4/k/NhiV9xUBTpbkIt6vM3Q6ZHFuFDTrJDt/yt3IFSGQNIOz5AWT4zJszhI8+RQGrOrDVdkydTSQTV0w4CMpxaLPG/KoHVrNakHjsKhjcsONzs+TseMi3tunv0xwVnVUnhX8iSnMgh6UtwMAzosRCRUzHweqvAfodytRbDlY6CdhHGadXoStZMHL7QUF1iO4YhfGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VquHWuGMr72rsJQ/Zvi6ln+7JpiTv8wweAoGyXVz1po=;
 b=RXZWkjG5958sg2UDZdcfNyRvss9mXXXzgnSmeosfj50ltYOvAgIHuojOuDQVHGKKjrYXKVuOWQIMVczztv3yzxPnoUA2v6G2NNQJ5E5Qhy7u5AuEzOkN4B8LxWBKKc8GsUtMaSzlKQOrnreEgRIlSuiuUzb2kyh3q3CP8YewTk6C8tbs12slJuNyOp4aHwZiXCmL896DA9DH/j4UdJ3iCHPvAKXREOPaYEryi4HGif8iCny83zXGK5rleXoa3g6IxG3gYXDnwil41MZs/Teg0+kJZ+gVFJaByftCkVm5r5NIauHoZuNC4hft/bdQs2JfhlZnhE/EraGcF1YXsieSnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VquHWuGMr72rsJQ/Zvi6ln+7JpiTv8wweAoGyXVz1po=;
 b=TcEKpRWQPsU+sZ/Gi6oGj8RoZP7elePTdW47usWBlKclzwl9Y7czj1vGcOe1WE/SAPHGdnz4mjUw9oikXkuOitu538FkAu5D9DTg7J0d575UuCKkZfrYlEMgU4HXGEUX5sL+YBNhlFSXnIWsXR4H0vtvjd5Dz+cDr4ttdSSBWX8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by AS8PR10MB5949.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:528::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Tue, 8 Oct
 2024 07:24:54 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.8048.013; Tue, 8 Oct 2024
 07:24:54 +0000
Message-ID: <75f02c1c-e492-479e-a623-b9562aaed4ea@kontron.de>
Date: Tue, 8 Oct 2024 09:24:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] Add support for Kontron OSM-S i.MX8MP SoM and
 carrier boards
To: Frieder Schrempf <frieder@fris.de>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
 Conor Dooley <conor.dooley@microchip.com>, Fabio Estevam
 <festevam@gmail.com>, Francesco Dolcini <francesco.dolcini@toradex.com>,
 Gregor Herburger <gregor.herburger@ew.tq-group.com>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Joao Paulo Goncalves <joao.goncalves@toradex.com>,
 Josua Mayer <josua@solid-run.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Mathieu Othacehe <m.othacehe@gmail.com>, Michael Walle <mwalle@kernel.org>,
 Parthiban Nallathambi <parthiban@linumiz.com>, Peng Fan <peng.fan@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20240904085415.645031-1-frieder@fris.de>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20240904085415.645031-1-frieder@fris.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::16) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|AS8PR10MB5949:EE_
X-MS-Office365-Filtering-Correlation-Id: c6ecfda0-47d1-4bd8-6830-08dce76a4e10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VTY0ZCtFMTlmQjhNZVlXTDBDbnQzejFDNXFpSERKYVZ2MksxZUY4b2lyRXow?=
 =?utf-8?B?VVZ0OG5XaHdDOFo5KzMxQlRFUDlBeHRkems3ZFpSeWJtOGRJblVuYkxYVVla?=
 =?utf-8?B?ZzZNZUtEcVhLZnA5MjdnVmVXcW9xSGIzWXRUL2UyYlBXZE1BMzIwUWN1Wmlm?=
 =?utf-8?B?UzNCME8yWVJNTjR4VS9seVUrWFFNYkVJRlJ3YVltNU91WDRZSy9LazQ2RTRR?=
 =?utf-8?B?YlRLKzZzZ0xRc3dybk8zWStpMjdlZjlGdG5NL3BjRmJhcEZmR1RPMlRyaDAx?=
 =?utf-8?B?NHplMzRlU3JDOGJIL0V0UjFHREdsRzlGNmlsUi9CekhOenU4OFN1OUNlUkk0?=
 =?utf-8?B?V0dSRHJuSm9TcE5RY3dGY0Q2UlBtMEhjaXpWTzNrb2VTeXFxZzYwQUl1RG1V?=
 =?utf-8?B?Tkh6bXI0S0hGclpJZmNLSGdTNlJYN3h5VDRsTGdnSUo1K0hRYmJiSCtzTU10?=
 =?utf-8?B?ZnM0OUZ4ZGg1czJoU1dSVzFhcTZQYVRJRzEvM05DS3k5dWxHcGFrL1ZuR0xr?=
 =?utf-8?B?M3VFOXAyZTBERzdYMXExelNVc3RYMXBaSk94ekplTzB2K2x2a1pzcTE1T0VO?=
 =?utf-8?B?UjQzcExaNzVlSkJKeHdSZ1NQL3FJTDZ4Q3VWS25KQU44eWNyNnlUeWhUdi9l?=
 =?utf-8?B?M0JLNDgyQ0pWL2FqSEJaL05xWFE4R0tTSG5kUnNqbFIxWkxvK09VOVF2N0pj?=
 =?utf-8?B?N2Vac253MzAwMVpXOUU0QklWbDFiWVlMUVRwZmI4cE9QMXhYNTlSVTdrd2kx?=
 =?utf-8?B?UG41d1M4RVIzY1hpcFIybHo2R2tvaEFkMi9xTUtHcDlZNUhybm54KzhGWWNu?=
 =?utf-8?B?SjFaQU9CNTVaWnZ2VTI5YXFJM1dHSExJZzh2YXc0Q0hTdVJRNkh5c0Excml0?=
 =?utf-8?B?R0FPZEpoYWtvOTh4YWszb09INkhyaExDSzFiaUhaS2hFMFpibzEvTGhNeW51?=
 =?utf-8?B?c1cwMUlBSGpEVVJDMW5BeERlS0lla1JWQ0N1UkJBRVF2eTRiMnlxUEU1VWhV?=
 =?utf-8?B?eVE2NDVsZVlqOUNYT1l1S0xIV2lqdFhoVW11dHVEN2ZxL3kzTWV6ak5DbWZo?=
 =?utf-8?B?cTNiM2NNK1V4dVg4dUtSR21hYXlQWUUvQmwvK2pHM253S25Zb01mOVYzdjVu?=
 =?utf-8?B?SFVPNVJIUVgzM1JyVTh4aHV3ZDlxNjk3Uzg0WHUrL2U1QUZON1o3bUxqVXZ1?=
 =?utf-8?B?aVVLOVI3WE03WnBGRGpoeGZiT1BteUFaZGRIeldUdVZld05aRWkvT3diUS9X?=
 =?utf-8?B?WGxKRUpWRE0yV0I3RElpMFZVd1VqTHZ3T1BMbldYdlRka1ZwYWp6MFNNNVAz?=
 =?utf-8?B?TmRzc2JyT3E2U0d4YUg5eEU5bWgrazZINnlLVU5mN2VBN2ZVbEVwcHgzZmRz?=
 =?utf-8?B?NEpYSlZ3SzQzVFl6WE53YlFYWXVXUkY5ZG5OSHlUOElQdm0ySUVESEpyclBL?=
 =?utf-8?B?WkcvUThXZjYwei9IOW1odytNR1dlUklYSkJMV0p3MEZvRjRuZ1lrYVVBNTBL?=
 =?utf-8?B?QVRVQ3ZEYXI2U1dCTEVmVkJDVVdZRFFsNkUvSjJSaWsyTytUdVBRS1RrYTY1?=
 =?utf-8?B?akxnYi8wY0FPY0FVMldCQTFRS2x3NVg5dGd1eUt0UWxxQzNObG5scXpDV253?=
 =?utf-8?B?eURSMGxXUkN0dEdiRHRmKzBkUk1yUjltYkNWc0k3M0F4RVNBT0IrQmhTNkph?=
 =?utf-8?B?Q0JMTjNjakNPaU15VnNqRzdKdWpwWFRBNm15VFpRYXAvUXJUM242MWc3UzhF?=
 =?utf-8?Q?+JbH+5lCt9XbIaz/5bITAvQVMgeTUAwaOZ/yMVg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SkRSMVlkUzAxYTl6QzR1YnVPUTJCSnk1a2FvK3hsVlI0NURiYzc2b3J2eU1B?=
 =?utf-8?B?bUdhdlhpWm5kWUlYcU5LQkRVQzdQcEI3bE9abWFyY1lJb2FtWnJka2xEb2Ry?=
 =?utf-8?B?Z3JhTlNmeTZQcmhNM0p4Y2FkM2xOUWI2NjI5TEdITEJZRkV2RldoYVZ4WVhH?=
 =?utf-8?B?V0N3QmVUUHo5UjdnaW5kdW9FSzBrSzlGeC85VTdPVk92UmNHOWtHRzk5c2Y2?=
 =?utf-8?B?Y0xXMGdWbmZINk1rSEp4dU1QbjZaSTFzY25yNnQ4MjFhUGUrSFJXQ0ZEYmNY?=
 =?utf-8?B?MGYwZ1FTanlJQlZvSCt4M1lQNEU0ZlYvMTVTamwveFVIVTdNdmJRRHpsSU9t?=
 =?utf-8?B?VEttdHcxVk95eUowRUhLQWtKOUx2bTdXY0NzWVd3dGoxeTFUbXFoN1hTdklB?=
 =?utf-8?B?ek5GU3N6QXlncTZsR3JHTEhWUWVKQngzZGpKOWhFZlp0ak5wajFMMG1xUU5N?=
 =?utf-8?B?dVZLQ3ZvNWhpT2xDanRzUTZ5aTU4ZnlHa0kzTjMyclptRnhsWFVXVlNjcUo5?=
 =?utf-8?B?Z0ZZdzNVcTdBQ0ZvZ3dTb0pIZXNpaUxxaWxrRFF1Y3l0M0NLckhQYjhoVmZ0?=
 =?utf-8?B?QmZrTzZjSmtDM1ZHVFViOHpLQjQrN3VEWXR0dEdjaVp5QWM0QjJRbTJ2bnBt?=
 =?utf-8?B?SUFiVkZvQ2NzZW9aODNPbmsxUFN0bHVRdWhDUktvNi9TSmt1L25sa2VDem1J?=
 =?utf-8?B?cS83aVhmZmVRYnlNdkNBTWVCWTFUaUtEVDNpSk93cWRWdE5RU3E4ZTFhTlVY?=
 =?utf-8?B?ZFRhMk14cWc3aERNL3gwUjRlNUJSeGJYdnZOdGdpRVpyclhrUld4MjZRYkpa?=
 =?utf-8?B?SFBKRCtwTjRVK0l2TlhNSUFNdzlpWFlDUkNFeHkyTForMjlXRWtIZUw1UVJz?=
 =?utf-8?B?YUY5V3dWSDNNMUYybmx2QjN4MGlRcmZ5c1lMMS85ZXpyQjlycWZ1T0ZLTlpv?=
 =?utf-8?B?RG0rNTZkUDY1NzdvQW1JWUowM2FJSmxkbU1IL1lZT042NDI4Ulo5NzdQVnpW?=
 =?utf-8?B?anJRL1krNjg2ZndueXdKKytMUHZDRCsvcVdNWm93ODdaK3RTMDRvaWRyQU9Y?=
 =?utf-8?B?dkFxbTMza3NJdFQ1STBvQWZIdis4RmM2RnZOaVJub1JDeEJJTG1SN0JxaWYr?=
 =?utf-8?B?NkNxbnFLZVdqdXgwT0xWdDNRRGVlTS9leUEwMElEQ3VxK2hBQWdiZmRzME81?=
 =?utf-8?B?d3AwMWxmRnpXbzE1amNzOC9tVzk2YlFFS2p2STE5cnB2Q2VyRDI5QlZvR2VV?=
 =?utf-8?B?WlBMUFgvNVpidEM4VUNjVHlDK1lCRHZVc3kwZ2RVc3owWU1KZVdybTgxMnd3?=
 =?utf-8?B?djZSam83T0kyeFN6NVZFZUpTR2pvUERiK0g2WC9IMzNqdlI4TnJqRjVuckxj?=
 =?utf-8?B?MUlYK2wzYlJsK2pYVEY1ODhjdmJFVkk2RHdUdUZSRXpvem8xOC9xVDZySTJq?=
 =?utf-8?B?bGlMaitORUQzbjlDbnc3Y1pmazMvL1ZVM09Qb1VMUCsrMnRFNEFXdmpsamRy?=
 =?utf-8?B?V0NmS2k2d2Q4UEpOQU1heU5NRURuTVlsNnJOdWxkeUcyU05qdHVPY2dOY0Nx?=
 =?utf-8?B?bHNXL2I5YjVvMGdLbWlnbEMvdDcrdi80M1prNkl6bStQVTJVUzhaMEJGNlhK?=
 =?utf-8?B?b0VTS2JYeXcyT3NiQ2NQQThYUnJrVXJTTFBndXJrelhWWHgrS0Qyem9CYUdj?=
 =?utf-8?B?dnduYnZvVzNicUFsNHRWK2hKNVgzNGZhbDcrZnQ0Yms2bERWRmpGSnVmNkI5?=
 =?utf-8?B?ZnZTV2NVNlRYS3BIclhybXpVUlJEZDNZR3ZWVzhKZkEwL0ZvUTBhU2crMmpL?=
 =?utf-8?B?eVVqSVMxNzZyOXp6UGErZWJla3lzbFI2T1c0U0JpSGpyQXFDQ2hIaXhUYkd5?=
 =?utf-8?B?ekp6ckdISDMzV0FmN3krS2w2S0s0aGFWZUdWU05DRTZCejVSa2gxMmlvOENI?=
 =?utf-8?B?K0pJOU8vNEw1RnlhdWgwbkJwTTgzcWY2SDg4NllJdlh6RzV5b2JuVXQ4emxa?=
 =?utf-8?B?a1gzMGNqYVlYbVJQYzl5M2pFYjAxV09mZWhXU0FES2g5cWtBSGx1cndpWjFQ?=
 =?utf-8?B?bFFSMVV6dER3cVM4ZGY2MFRkdEVtTGEyeU5MYTIyVUhVMnJJOGUyaHFQS1lh?=
 =?utf-8?B?MnRLYkFLMzd2N1U2Ly9CV096V1l3UEZrS202OXVUS1NYbGF1S0dsaVFOVm1I?=
 =?utf-8?B?eEE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ecfda0-47d1-4bd8-6830-08dce76a4e10
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 07:24:54.4228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NbE4UYnMqx9dZzEX5GGKphENXNBI/tQmdKTdWmXzcpO9ZoJj0dnr8kYLZRDDYg1l6v5K8Mman75XKSu37/s8g7DSVJVQcZrOw3jEn662wfI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB5949

On 04.09.24 10:53 AM, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> Patch 1: board DT bindings
> Patch 2: OSM-S i.MX8MP SoM and BL carrier board devicetrees
> Patch 3: i.MX8MP SMARC module and eval carrier board devicetrees
> 
> Changes for v3:
> 
> * Address Shawn's review comments (thanks!)
> * Fix HDMI DDC interface
> * Fix gpio-hog pinctrl in DL devicetree
> * Fix DT check warnings in DL devicetree
> * Adjust LVDS panel node to match that of proposed DL i.MX8MM
> 
> Changes for v2:
> 
> DT bindings (patch1):
> * Add tags from Krzysztof and Conor (thanks!)
> 
> SMARC DTs (patch 3):
> * Fix GPIO labels
> * Add support for TPM chip on SMARC module
> * Disable PWM in favor of GPIO5 on SMARC carrier
> * Enable LCDIF node to make HDMI work
> * Add support for GPIO expanders on SMARC carrier
> * Remove SPI flash as its removable and should be in an overlay
> * Add CAN regulators to fix transceiver enable
> 
> Frieder Schrempf (3):
>   dt-bindings: arm: fsl: Add Kontron i.MX8MP OSM-S based boards
>   arm64: dts: Add support for Kontron OSM-S i.MX8MP SoM and BL carrier
>     board
>   arm64: dts: Add support for Kontron i.MX8MP SMARC module and eval
>     carrier

Gentle ping for this series. Shawn, can you apply this for v6.13, please?

Thanks
Frieder

