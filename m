Return-Path: <linux-kernel+bounces-319214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4E696F95F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 18:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D824B21BDC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF221D415D;
	Fri,  6 Sep 2024 16:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CE3s6ofY"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011014.outbound.protection.outlook.com [52.101.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9401D47D6;
	Fri,  6 Sep 2024 16:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725640265; cv=fail; b=EmKHpC/g3ndPTBiv18GpabYxW8EUWUtWB6UJw4na4jEWT7x4gTi3Y6uSH7TYys0YwqefsREV6DjDpLNWvnSwhW+YNXJi9SoHCjwf6bLyP+lDSfUQkeCqIX8JWftA4I0zxpjHwJuhCutEZm89GQywImvXj/MSmJTBF/sPvu8CY4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725640265; c=relaxed/simple;
	bh=2LsMdszPxs7nPZ3WODzvRciDtq3lNGIKklis/0adT+Q=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=odLD9nv1tP2xaDuLjUEB0CCvoYKjOpHMS5Xv6fDM0c3VZtbd2FDV9Y1vfL3baG7q49eBG6aMxseqoQJiNrSWQWr97xBhYe3/QJWGZjNoGZWOmt5pkaqtuQRrcmemFmdlYQiW06KUh4KDFmZJLdF/4EXeo9b8MaoM1aRd4ikEvV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CE3s6ofY; arc=fail smtp.client-ip=52.101.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cn6wi+7FmVwlyLgQy7KI3p6Eg2et1hRPMz4ekKUF8M7U8E7T8PsYrBpOhizrAdN64CDeBi/a4pICTG60mp+1kfgzJgJxpSuVUXDz1QZdGRAaJysAyM5IcZTgt2Zm8np4phbSCsKzkhCA/2i+rzV1NaDJn41clDQG0dN2eO+075KYO5bD4UkgPRyP3qY/ylPK0l3Cpx9K4uAPtRFhrGGXusIw4cgxZnkHMCjjeJP3VVq2SISiKXq1gDHirFP5M8TmT/VDRUCL75+6lEUZB7101azi38jULCOjXSpVbvLnOSl4YMYLIP93HPiG4hEYdknf/ASJ6usIawZT5zpIjReDQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rqy4TY/wNLiJPUHnBtGAWyth+ass9f0B7FvzsQmw1tg=;
 b=w3/2Uq72hfhCgZWD+on+jQ9fO0WcM6vZckC4KVjBBEZyHvkF+5YVaczFbGVKoQQcGka29xezx/Jc02rbDU91BKGUdg569fdnG7JIE2Tar52O8I5kEzbsEe0ESeb2FgTsgiOu3vJJbKr6kMv2h2ZE3bL1zeNTQtJ1HCaLhWitrb3aVdvVqNoBY5RG5mcyvf4cJPpnSU46wYXeq+pClH+S35J13fpA7/ha0EWgf7XpSctUMMyGAkmO6Ri3qSzwn/4W4T5RsEMeMBQjGi8ZkuRT2jJFCakJ9X7nmddo9f6vPCpq6/y0xKiNZnrCweWPVKUpBr3f1xFl4V76RV+WexFzIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rqy4TY/wNLiJPUHnBtGAWyth+ass9f0B7FvzsQmw1tg=;
 b=CE3s6ofYTtA2OCDcphA6IuvE9+N2etE3I0ddO94yycSSyQeY4y9GccY/xxu2Ve2nnRL8Sk6VBeX6BhNdXGRaki3AZrOwfy/gVTOZEoufLztlHFUrfOxmW06mCMjqQe9yX9qxLyUWUup1W/xB+VsflPb3iWbGUUEGTszh3RdSzQgOp50iAkFN7AdvB81bqdLCzovKOH+B0rKtouzlwPInOU2Uch6iylmZ5syuBjFV7TsYvu0UHoi5OMkr+Y6iPWos4qH5bcBKIFJ4PtKkBp2xCdRhZVdu/Sy4L7+QCYPZlxirg3PwfU0A+YiRvsV6HUm9h7MXHBgWkcgEPhtNgzWeSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8405.eurprd04.prod.outlook.com (2603:10a6:102:1c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Fri, 6 Sep
 2024 16:31:01 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7939.017; Fri, 6 Sep 2024
 16:31:01 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 06 Sep 2024 12:30:39 -0400
Subject: [PATCH v5 3/3] usb: dwc3: imx8mp: disable SS_CON and U3 wakeup for
 system sleep
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240906-dwc-mp-v5-3-ea8ec6774e7b@nxp.com>
References: <20240906-dwc-mp-v5-0-ea8ec6774e7b@nxp.com>
In-Reply-To: <20240906-dwc-mp-v5-0-ea8ec6774e7b@nxp.com>
To: Mathias Nyman <mathias.nyman@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, jun.li@nxp.com, 
 Frank Li <Frank.Li@nxp.com>, Xu Yang <xu.yang_2@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725640246; l=2163;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=gC7JEGlw6JQv9GgnXx7tvm51p7QIxUVIu7LJn/D3a5E=;
 b=RyeG6f3hVtlJ8uCO/OpL6DVAaGUdYUFFZvtc5B9lKmrp3esPb1eyVNx4MtPlEh/AGwRGqAJ2S
 0coKm/lzkZ1BpHPHxnSH+8J8ArB42RR4PriJL1SgkTdmW/ioY2iMGYf
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR10CA0016.namprd10.prod.outlook.com
 (2603:10b6:a03:255::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8405:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c4bc0a7-65b2-4c75-9545-08dcce914bab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ekNNY3lGZzhPK01PNVN6cEpOTXpFL3lsaWN4Ums2WEJrZ2hqR2R2MXRWZTNu?=
 =?utf-8?B?TlZ0ZWgwTm5PUEdWNUhVaEZqaW9oamJxckJUVmJhQWFrK2hQSlRIdm12NTBL?=
 =?utf-8?B?YkFNcDF2eTduRUQ4UU5OUHUwWWVzWC83ZHJGV3NVd0lsbEdwZmdEQzFVTVRN?=
 =?utf-8?B?dDVzM1NuL2pGT1dXQ2EzbVNsKytrVEtjVG1GejFuMmNtTlRMaWpqMHEzUEox?=
 =?utf-8?B?Qnp6WUw3dUFOR3V4VFM2b2ZXeWw5bEd6N2J3ZzIwREVjUXBUTS9WYTUyeXhO?=
 =?utf-8?B?TnhnL1RlWEdTZlRsVGRUbHBRTDNWN0FYTlh4STgxTVdDMnZLbytPdXREUE9k?=
 =?utf-8?B?MGU0QUNMMmF2OXhIS0s0NVErYmd5ZmQ2QmxHQjB2NWgzbk9VelAyYi82eW95?=
 =?utf-8?B?VEhXOWRwbS9lcytaVkZvOThhOUM5TjY0Yjk3YmFRb3ZRMHVKSGJCOEdudEZP?=
 =?utf-8?B?RzRxQWNkaGpQSlZrUUdrMHZGb1dNVFgzWWVVZlNHN2RoaURzejh5ektOV1A3?=
 =?utf-8?B?MmhiL1lnYTR3WmU4UEhXTjNnTCtYd0hYZ2hXSDFHd05PZVVJcHVwamtQUGVF?=
 =?utf-8?B?UERtT2xyakRwK1l4TU1FNFRhendrS081eHpjeDY5L2M2Vm9vQWw0U3kxS2xM?=
 =?utf-8?B?V0Vta1haMzBiWFZ4cnVubEdmaXZQUmRMdGpiL1UvN2JBTXJjUnZHemR4TGdE?=
 =?utf-8?B?SDVXZVptaUs1UDdJbzNFVHBkazhZYmRYcUM4Z0lqOFFJSzU0dDNNUGpYbEs5?=
 =?utf-8?B?ekhXQVVDZ1ZPL1RXT3JxYVZmbFBLK0l3RkErNHd2Tkl6V3QzVnZXN0o2eUdi?=
 =?utf-8?B?MUk5MHVNejFNWjMrUUNvanQ2WXBNQkVKOVVFbm5QTk1JbU5ac3h0ZEFxUUdm?=
 =?utf-8?B?VythTXY3Z0YzazRxc0hEdnhmbkV0NDV2VFpTbkVibXBka2hzVlVjNEJ2bmJ4?=
 =?utf-8?B?Z2g0NTQ5eHVVTXVoTTcydFdsRTluWU5UTjl2Vmp0dVE1YkJrL0I2QURvL0VT?=
 =?utf-8?B?NHBmd00wYkIwc1BPOHVOWUpSbjRqYjVyMy9GUzBjTmtJVGhKUFZqNFp1NWRW?=
 =?utf-8?B?Zml3Mlc1WDlwOXZCRitKQ3ZDNGhiQ3dwakdHeEt5djZhYWZjWVBqbzR3VGxL?=
 =?utf-8?B?amxzMHRMSTJrRnV1a2w2QWhUSWdrbVUzUWY1cnpMVVBkUkwzeXRhbEM5Vnll?=
 =?utf-8?B?dVpLSkNDaFRQcUFwRmtzSU5DUDVWdTB3VE5KdDZKZUZRNkg1STJ0dU11OEF1?=
 =?utf-8?B?UWpQaS9UZENMVkpFRnhJN3BETW5zQ2l5MlR4blo4Q1FlZFpCcVJ5MURmMDl2?=
 =?utf-8?B?UGpsNWF4YmM1UkkzTTVGWUQwcFhrOFdlbTVSN0dnMU1TeVZoOXhLZkhXalo5?=
 =?utf-8?B?ZFlId2xMT0hpNzRhWUNldFVQQk1GKzcwWlMwdzhBeG1Cc2NES2dSeWhJckk4?=
 =?utf-8?B?VWZDMDNpNmQ2bHdmdjRnY1k0Mjd2RFlhcXhKWVU3YmFoUGtvWEM5Mk1reE9H?=
 =?utf-8?B?UWFDZGt6WVE0UzhuY0FScUVLR0lKbkR1V1lJU3RWM0ZpU0h1ZjdXQlJjMjJq?=
 =?utf-8?B?ck1mVTBrMnA4QXB3OE5La2lRUGs2TW1XcHVEb0NociswOE1XaENULzlIMGw4?=
 =?utf-8?B?T1hjYXI3b3krMUpiVWRyVE9lQTVPZW9jYkRhVFh2cnNMQ3Y0VUduY1o3WExt?=
 =?utf-8?B?TlRGVVY5U3dSV0p3Z0dOVGQ1WUEzK0RpdkVvdnNjNTA1OTloK1FWRFEyNC9u?=
 =?utf-8?B?cGxaa2NuMkNCcHNBSEsrbzlXMU42WUN1WVFnOHUxRzdYKzEycDRrL0o5N1pz?=
 =?utf-8?B?eE9XSmNBREVtZjFsUWJoc0c1a09YZUk2Si9wemVobEo5L2hhcDJBUDQ2Wmc2?=
 =?utf-8?B?YTNzM210aVpqMy9zOTJlRlVmazZZblVJMHZFZE1aNFRTb2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUlGd0FNSFYzSVlCcmRDMFdkeTRETkpVMHliZkI2TzIxYjE4TExBc0ZtRFdz?=
 =?utf-8?B?djBvQnE5RWhFYjF3UloxK2VYaE4yTUNlWXlQT2xnZllVL0h4WkNoL3J1MFBj?=
 =?utf-8?B?VWwrYmw0RE9CSnErWDVzdldKajR4TzJtQkhsVVJTNmljVGJqM01oc2JFdlJm?=
 =?utf-8?B?ZFVBOFU2aC82RkJBMG4wcWsvd3QrUlcrR0ZSVVhtNW8xcWNaejhpNTBzSjR3?=
 =?utf-8?B?VXhFN3FhQ0dyT2VZMElVMVNoT2pjRzVjTUN4anhhM1FRSStweEE5aURNNXoz?=
 =?utf-8?B?aUlxdVZwZ0hmU0lYcFFSR1ZCUFRaelBQeXl3aVVJaDF5M21VdndPNHZTdE9z?=
 =?utf-8?B?MitnN2FJVDdhMHB2Slo4bU9iV2hJZll6aEVQTCsrLzNxczZ5N096cnoyVnM3?=
 =?utf-8?B?WW1iK3VDMkU0aWwrOW0xV3AvNGp0bVVkblI0QXhWOVhBbEsvS0R5V1N4QVho?=
 =?utf-8?B?VlkrTk1IYUVSS3RxeTh3WkZaK2xJdDRaNk1RbjhwVHFVbldnWTlGc3dqMStn?=
 =?utf-8?B?UytxTGRYNWkvWWl6dXg0ZmQvYmdxanluNTA4VHFRekJpNkowa0pnVWR3bmtY?=
 =?utf-8?B?WUJlRWs1WXJZZGZpRm42amVOcTY5THFQUWN1a2F3aERQUGFXRXA4U3VnN0p5?=
 =?utf-8?B?Q0tJR3pYU1FJWWlzakR2QnFiMVpsdU5aZnlybjFhc0lhQk9YYmxlQlR3d0Zu?=
 =?utf-8?B?Z1RnZVVsRlhQYlp3WitFMkFzY3BMT3NzcWw0TG12UUk4ZE8ycUVLU0podStF?=
 =?utf-8?B?TFVPbEprZHFzcExFSU1hT1p6Ry9lOVJqMmNrRmZOdFl2YnBCbE5RRUhtSnVZ?=
 =?utf-8?B?UHZ0KytjbzErcFh2NHZ4Z2g0OGlCK3hiV2tsdmJjYVV2QTI4eXpoS0J0UzFr?=
 =?utf-8?B?SlY5SWR2aU4zZElFYnlIdWpvai8yMG1CdHUrWjZrNFgzbjNEcktBeU1ZM2Ix?=
 =?utf-8?B?THZ4NnZBSzBtaGY4bWlTeGw2MUFoSExWSVNzVmVtUC9zMGk3c0VZdFhhMXlP?=
 =?utf-8?B?WGY0TFZQSjNvVWd6ei9aUUh2dkpUVWhWckNNL21jQkFjbHg4OHpzNEJrQkZX?=
 =?utf-8?B?OGFsNjZFYXdrOGRJaHNDVVJYdVRpVWVJR1hOaXJiQXBoNlhoeVFINGx1cTll?=
 =?utf-8?B?YjRqL1dVRzlNR1U3a3ZEN0t0NmJUaW0xYTd1TkR5Q1pkNnBWRHpRZ3RtdkVh?=
 =?utf-8?B?alROWFNWbUhtNGs0SXFTTUJXVkZqVldubE9waUZSVUZraVVtOFZMUkdPbXVk?=
 =?utf-8?B?T2ZiNEdWZkFGZExPMjRHK0ZFR29vQVlNS2hJLzRwcFlORno3WVRKQWJBaExo?=
 =?utf-8?B?RUxXdmI4YStyNWtjQmh3b08wY3EyYU82ejBqSHdZV2t1TTF1eVpFQjNCT2cz?=
 =?utf-8?B?dm1rUkl3c2pTeE1WWHV0cGgzdE5CVitYeklzQjBTN0hzSXVoK3Y0RkpxaFQz?=
 =?utf-8?B?b2MxbE14bkkvd3VNVlZrV0xsakdyVW1iT2FIMEpQNDkvSU9iWGM1UWNOVFFY?=
 =?utf-8?B?U3hzY3M4U2tKRmt3YlNRRlVHLzhpZ1VUU2J6b1V4RFFKZGc1c1lGNEFOTGxE?=
 =?utf-8?B?TWRKQ2F4ZUNjbVRxaDdEMmVDSFVhQ2NmM3E4M0V3NngrUWRrU0MrRHlNd3hv?=
 =?utf-8?B?T0YvazNsd21xSTJ6TzhaaHhJTGNtbDNtbmFVcTRTalZ3MGJnTTE3RGNPdjU2?=
 =?utf-8?B?UDFlOXVqVGFVdHRxTEZHai9yS2FrYjNKUERVRUtOQ3BLVWdZdXREZElKUHJ2?=
 =?utf-8?B?dktKYzdLLzlLQ2tTblE4UGo5STVpczcwYmN2UW13MUlZZUxrUHVBd1RNSmR5?=
 =?utf-8?B?ZklwRitHMUtMOVJHR0kwcTFWKzF2MUlKY3F3RXdjWXVUSDljZ1lPem81NXVH?=
 =?utf-8?B?RTVjQUxpWEJIT3BxU0JLTFE4d09sVDdLRVJGWG1qTFF6M3JBb1FkcVNwN0wr?=
 =?utf-8?B?L2JCWThXVGhvbUI1a281OVI4MElSbWlOSHY1RGdpN2JIQnNiUXQvRHdFYXF0?=
 =?utf-8?B?WW1taWkrZk5yb1RZRkRIMXMrakpFWGoxYUVsMUhIVm9TVW0yZWFtbEhOZGg1?=
 =?utf-8?B?ejhkTndvamtCMldMbTdHZVpGOEpiVnVhYmNocEYyS0FWRUdTOXVwSmk0VzBQ?=
 =?utf-8?Q?41bjY9cmRHU723xyao3vu4mbZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c4bc0a7-65b2-4c75-9545-08dcce914bab
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 16:31:01.5893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f0Al+IsFyMql9IPyl8SkDQ80adUWX38GN1gsmQ6HiSoYvub1g94iwmHN0gN2pGgNKV+IFo3vu4rsWExYSsv9dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8405

From: Li Jun <jun.li@nxp.com>

SS_CON and U3 wakeup need 'ref_clk' on. iMX8MP turn off it while system
sleep, So disable these wakeup source and only enable DP/DM wakeup source
for host mode.

Reviewed-by: Xu Yang <xu.yang_2@nxp.com>
Signed-off-by: Li Jun <jun.li@nxp.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v2 to v5
- none
---
 drivers/usb/dwc3/dwc3-imx8mp.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-imx8mp.c b/drivers/usb/dwc3/dwc3-imx8mp.c
index cfb59f6bf5dde..64c0cd1995aa0 100644
--- a/drivers/usb/dwc3/dwc3-imx8mp.c
+++ b/drivers/usb/dwc3/dwc3-imx8mp.c
@@ -97,7 +97,8 @@ static void imx8mp_configure_glue(struct dwc3_imx8mp *dwc3_imx)
 	writel(value, dwc3_imx->glue_base + USB_CTRL1);
 }
 
-static void dwc3_imx8mp_wakeup_enable(struct dwc3_imx8mp *dwc3_imx)
+static void dwc3_imx8mp_wakeup_enable(struct dwc3_imx8mp *dwc3_imx,
+				      pm_message_t msg)
 {
 	struct dwc3	*dwc3 = platform_get_drvdata(dwc3_imx->dwc3);
 	u32		val;
@@ -107,12 +108,14 @@ static void dwc3_imx8mp_wakeup_enable(struct dwc3_imx8mp *dwc3_imx)
 
 	val = readl(dwc3_imx->hsio_blk_base + USB_WAKEUP_CTRL);
 
-	if ((dwc3->current_dr_role == DWC3_GCTL_PRTCAP_HOST) && dwc3->xhci)
-		val |= USB_WAKEUP_EN | USB_WAKEUP_SS_CONN |
-		       USB_WAKEUP_U3_EN | USB_WAKEUP_DPDM_EN;
-	else if (dwc3->current_dr_role == DWC3_GCTL_PRTCAP_DEVICE)
+	if ((dwc3->current_dr_role == DWC3_GCTL_PRTCAP_HOST) && dwc3->xhci) {
+		val |= USB_WAKEUP_EN | USB_WAKEUP_DPDM_EN;
+		if (PMSG_IS_AUTO(msg))
+			val |= USB_WAKEUP_SS_CONN | USB_WAKEUP_U3_EN;
+	} else {
 		val |= USB_WAKEUP_EN | USB_WAKEUP_VBUS_EN |
 		       USB_WAKEUP_VBUS_SRC_SESS_VAL;
+	}
 
 	writel(val, dwc3_imx->hsio_blk_base + USB_WAKEUP_CTRL);
 }
@@ -277,7 +280,7 @@ static int dwc3_imx8mp_suspend(struct dwc3_imx8mp *dwc3_imx, pm_message_t msg)
 
 	/* Wakeup enable */
 	if (PMSG_IS_AUTO(msg) || device_may_wakeup(dwc3_imx->dev))
-		dwc3_imx8mp_wakeup_enable(dwc3_imx);
+		dwc3_imx8mp_wakeup_enable(dwc3_imx, msg);
 
 	dwc3_imx->pm_suspended = true;
 

-- 
2.34.1


