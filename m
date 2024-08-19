Return-Path: <linux-kernel+bounces-292741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE359573C5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 20:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DF71B21E6F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0046A189B8D;
	Mon, 19 Aug 2024 18:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="i6IGcnXc"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2053.outbound.protection.outlook.com [40.107.21.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9785116B75F
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 18:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724092994; cv=fail; b=PwjM9FEoEhqoZo0af5NNNqPJsm5uAVpzlSm2v658DOp7o2M/5Wd3HmOtfomtMHtmnDpCMz6hr9WXVMUcycnyzRuIAUto4N9D+CPghiCdnLyQ/yYM2NUdWQNKL4yRwYzqNMjeOS3kyrjXz/vNfoqjJiys+nLA6Aw+pMfwaHncxj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724092994; c=relaxed/simple;
	bh=KwmOMx3HCHfB9XL4UYr+WPUBF1CvV9ZrVisMDQMQ1fE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bp+2Mx5f2uAPmOU3miMRRFLJyFwFIjNx2hNx0SUQhRLlhXL/K70IZSCF+LG4kQIeYam06/ak17MrO6u/H6m+DrQ7/+inTBtl7ehrkXK3eLlDx34TLsaZjUt7NAcGLY+/CprUj9A3CQRJ9NM/c3iZVPn2ePaVqCvDfLsLoICanJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=i6IGcnXc; arc=fail smtp.client-ip=40.107.21.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E20C1g2egnttD+wLofLPcpoGtXHDWRMDoilNM/L3LCrRXM8e0rkCWKcZX8wwUoLWGgBbGoqR7rBKzVL5T/A3S6XL72nJYKo9V6v0C+DaeZ91CSkSis16DqPDwvt58+0hu+Z4gYy/49uK5X8OvCkEMs84tSHEYT9fZu56sGpsUwcwg5qVLRZ3zPN1YWXq6fcv94Fs/Jdp0ftc5pGJnM/vK7Eeq4RaRCLgMckULUg5swei3+F8E5mfSUA7tPo1jWTjTmDJkViOP3ALvvBHM12aMyN3ZhS10Pj2CthMLDGrtq5ib5MS/jT3j3L6xxFcx4IIN2vfHt7IoGeiwsKE+p7ycA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSlpzzUSvkDMxHaHBqPEGIsQM2+e9QykGAP2BRNcz9w=;
 b=mUJNa4N/INldOwKDPbgDyn5uShBcaTIsbMcGHrq8F4BZtJxzKk4KZsGXsCEv5OKSlkYivv8af9HtclcqHGKrQVYruI9u959nwKzz3ycZZZziKbwKajLF7e3XbMpAmfOKZnGaFX6GLKIdOVdfYk5dPge9U2TVdY+ffaBoQvJXhd38lczfetQnoFX0xICwLMOYNbvaD0nUoTG3K9I1M7K3n0ZeDCucd5UuuHQO4WT64mcSdEPDWadV9ht/xat/GOoltbudzmu7LyxiK6jcmbNyb8uBj8P/eQElmpiX+HAZhKcqnhcAi/RSk7iruqzvubt0I2pJtvBVqx4/X7C4UtFzVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSlpzzUSvkDMxHaHBqPEGIsQM2+e9QykGAP2BRNcz9w=;
 b=i6IGcnXcw0vhnrhSCt+RXcXDYVKYs0JdIhoAIWQluGgNpfyv2I2ws7kDEPmKAlT2erK762s/ubXcBLZxvoZ1PGSXpyLn+Q3SfdYPGEuWWG5mrJJuh9gRsezFIc+zFBNIgS2FOe7caKr+XxcdakeN+84kxUZB2o12CZVTmq6HIxieMDMCKWuNSneCN5skvLflv4V6sHYGAIs1CoxH+9AQzxG+xgsgjZgxmNGN/k6z9K7OZIJLOUarDM9uTgveVhmZyGdOKzg4DL6ir0wmtsBryBUysh/U9F07Z/gqCRv3UCXG8CSczizxLi2+ced8lmOteZpYKOkFSntsAwlIJYXZZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8801.eurprd04.prod.outlook.com (2603:10a6:20b:42c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 18:43:09 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 18:43:08 +0000
Date: Mon, 19 Aug 2024 14:43:00 -0400
From: Frank Li <Frank.li@nxp.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	"open list:CLOCKSOURCE, CLOCKEVENT DRIVERS" <linux-kernel@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/2] clocksource: imx-tpm: fix return -ETIME when delta
 exceeds INT_MAX
Message-ID: <ZsOSNC/5BvTQAiAe@lizhi-Precision-Tower-5810>
References: <20240725193355.1436005-1-Frank.Li@nxp.com>
 <b88b6200-b92a-4cf3-946a-3c38cff886ec@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b88b6200-b92a-4cf3-946a-3c38cff886ec@linaro.org>
X-ClientProxiedBy: SJ0PR05CA0091.namprd05.prod.outlook.com
 (2603:10b6:a03:334::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8801:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d25384c-df24-4227-a8cd-08dcc07ec538
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MkhvMEFrOTBJMTdMbDlpYkVJYS9jZ2ZLTHlnV2dMTmVnRUl0V3lURTdhYjVC?=
 =?utf-8?B?SkpSMnlJbFNYVGR1Qzd1b3pRbzMydjVISTdheHArdTc3cVZZOHkrb0pCTVRn?=
 =?utf-8?B?UXI4TUZpQ3kyVjh4RHhKY3YxWW5abU5VczdQYTBZd3dac2RBUEo5QWlFNVV6?=
 =?utf-8?B?TE9xazNPZXhMcjI5V1l2YWFreXJQWm5VMm1EMzYxMHlPU1NBNEVSenM5d1U3?=
 =?utf-8?B?RkRnYWt0N1pqUnR4c29kbGhMTGRrbTFaSG83U0VMUzNZaGhrT0VENi9RclZl?=
 =?utf-8?B?QzdPRHNITGx6VldHWWxBdjk4ajhXQnRXSHB5b0hNL3NqeStNNUVaVHBLZUZZ?=
 =?utf-8?B?eGwwVVNlVEV5SXk5eXFXNnE1NlNMRTl2Q0pONGIvRkNVNUFFTHVZMlZFTTJn?=
 =?utf-8?B?ejBDMWNsSWoyTkJCOVcxOWE2eE41bm9DTFJtRURVTHl6OXFTdU5HQnAxZFU0?=
 =?utf-8?B?aG1HYWRHdXBncUx0OUhybTdlM0UzTFlPaDlPWWtDVkhyRFFpbTYzUGRIK1B0?=
 =?utf-8?B?WUNoaDdETkh0a1BEbkQ4Q2UwWDhwdDk4TndvaTZUMm5YZkRmTmZuSDkvSmxl?=
 =?utf-8?B?c1c2OWtjbFVlRHB2N0NSWHZxdU00UXlmaU5GZ05HdG1IR094Q2dyWkZGeUgr?=
 =?utf-8?B?bExDSnJRUFE5YU5iTTNNQ04yblN0TzlOcHd6V1Zlbzd4Y0dBcXlENmNraUlN?=
 =?utf-8?B?MnJxVFRjczZVenlyUkRlbGNXVlVZTnRpV2dmbjJzWkVvY0h0aFh3RWRwbGdX?=
 =?utf-8?B?cEx2TEZ4WFArV2k3SUZnL05KRUUxUjd0aFBHeHA4c291c1c4YXhnVk4zTUxV?=
 =?utf-8?B?VjBjeXU0dzFGMGN4czZQd2R2aE9YT2ZDYjhBNXlvNjEyV04wWnRUczliM2xO?=
 =?utf-8?B?MlM3R3IyQlFlcjE5RUkzTmFKMEJxVy80bW5odGxRMjA1SDJoaDdkY0dGZ2VM?=
 =?utf-8?B?YXdUdWE4czhGTWtUSldvSkJlL04wT1UxMHBWS2V2ZWdyUGIwbVdOZVVJN1Vv?=
 =?utf-8?B?Z2FjK0x6TmozUnJIcFhDM2ZSRkM3a005emVyQWV2Yjl1UUVVb0NaSkw2N25C?=
 =?utf-8?B?cTQ0TFVNNDNkZ09hWHpkQVJKUXBDQmRuRnJlNElnQlUySDMxQ2s4RWRYYUQx?=
 =?utf-8?B?SVRYNHRzc2VxNFZnUldQdFlZWCt6cmVhZ1cyZTlYTUlOajhsMUREZEh1cWw2?=
 =?utf-8?B?aWp1WEV1bnNaVU9YVDJxb2RaQkZaK0V1c1JCREsvRFhqd0pVaG1lV2hwY0VE?=
 =?utf-8?B?d04vNjMzK2dObUxJVjF2ZzBuR3REbUZ2Q2FlK3RDK0cwL1R5NERlUDlnd2x3?=
 =?utf-8?B?bTFFbFFPMm8rWTVZVUhYeVNjSVJVRVBYd0g2NUFtT3NrTDJTdkVabGtnS0Vy?=
 =?utf-8?B?azZONktYYllFTDR3Y1F1cmo5WXp5eUo4S2RucHVkSmRVRWZPNFdkMldiRzE2?=
 =?utf-8?B?eHNUb2lkV2c2c0s4Ym02RElYTHJ0R09rOVhYQkJLR2M3V1ptb01WSHRwK1BQ?=
 =?utf-8?B?MUJEVC9SejRtS0xWbkF5dmV1clBQdWc1blpxVVoyREtuZkErcXJQcGpFZHFy?=
 =?utf-8?B?SzlaYlhGRVdkblFZRGxmZHNYaUN5clJoNGhUWEVmUGczMHBLSnhHQmU3enVu?=
 =?utf-8?B?eHFVb1gvdUt3ajlWdmVCYXdFVWRveno2dEJvNjkwV2VFODNoUnIyd1E1a0VG?=
 =?utf-8?B?WWt1Ylo1VDc5dmtxMUdPT203eFZYRDdaSWdRTkR3aXA1ekdJV2w1UExLWXdH?=
 =?utf-8?B?RTZkcmNtc1o1d3dFMkpYamtwMzJGSEsyMDJmNk1ZeE1HMDkvWTJ4Wi9VcHpM?=
 =?utf-8?Q?MkbaP32b1Wi8BVUT5dJTRHRpkKXevJqxgxQGk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUFRTVM4OE13YWpEb1dVa2djOVZwcFBka3Q2SENEMGJNdjlZbExicEU3OVJS?=
 =?utf-8?B?N1g1cTJPdjN6cnlsTEFDakdjYm44OHl2eXRlK01JYzJXN1RBOWRDSXFjcGVE?=
 =?utf-8?B?MGFJeDdCY1ZUd05xVktHYmZJaEhweTVzSjAzN1p5V29mRlJESHBwWUVGT3o2?=
 =?utf-8?B?MUo2YXAvY2NnSW4ybkM5Z3FRRnJya05tSnMrTTN4N1dsd25ENjdJd3RrVThF?=
 =?utf-8?B?WGhSblV0WWkzZ3pyTGcwVXdSS0NlNXhHZWNQRHljZFdvODgxSFpjUlhZTmpn?=
 =?utf-8?B?b2Nad3hFak5NRFJmS3YxVk1wbnRValFMR0ZucVo0VWY3d2tpeU53SE1KSi95?=
 =?utf-8?B?YWZpMjNyVTlCczBycXRxTzY0blpPWGIxWUlxQllEZ3NCcDBtbkdGZXdVOXp2?=
 =?utf-8?B?bkJkYjdkZFFJN0N4aWtTQVNEWGcwM3RGK09RbXNQVFlWT1RvcGNjbHM2QzFK?=
 =?utf-8?B?K1hiZ1RXUlluZUt5bk5HblBXdzVScEgzOHNYcE5SWi9KVnhPUVExQXBYNXBX?=
 =?utf-8?B?YXlTdkdwYTlpeUlPSXZ0OG5JMmJRKzRwY3JuRlZ1Uy8xRmU0d1BpbG0vYXV4?=
 =?utf-8?B?OWJtNWY2YTJxZWc0QndySzllaWVQVWsza04xWDIrV0FEOS9sTkd0RjZtelFj?=
 =?utf-8?B?bWtuWDdqNUp2YkNoSWxzYWpHUWVGS29ueUhhK2JIU3JIVmxZTGpVQnRNTE10?=
 =?utf-8?B?ZHNrY3Fjb2tGNWE4ODZxMWY3MXFpQWpnbmVocTdNdDZQQ0FqVUU2ZHFrL3dR?=
 =?utf-8?B?NDR4Z3VkN01hb28vTG0yNXJsTUJabHptV242ekoyU1FzS1BPOCtJOFpmU2ZX?=
 =?utf-8?B?RlAyK21WMWVJamZ0VzVBem1ESXhRK0RNcGxzdzV1ck1CemZRQmJwbmFtVTlp?=
 =?utf-8?B?RVRrY2lMQWtFU0xXNG5LVzN0Q1UyUHdaVS8xNXJPZ3M1OEJQNGk1K3VOaVZv?=
 =?utf-8?B?MURudVhuL05DTkVFL21QaEFVbVROTmxVR21uay9VRE9zT3BJL2IzU3ppUkN1?=
 =?utf-8?B?RGQrVGJGSnhxUFd0RjQ3TFNna1gzc0tyakxwc0tJQzA3VHMybHdPZmhPbWhT?=
 =?utf-8?B?WHZYcWZrZGNIMHp0K0RRM3FKNFJ3UDVhS2t6ZmxTOWtmSi8xRFcvcWhFeGps?=
 =?utf-8?B?bkJhaDdHdnBuc295M0J0UkkvQnFCck15ZVVscjY1UUZYMTgvVVBXOEkydEYr?=
 =?utf-8?B?bEJFL3FVMXlUS25FaFpJbVFBYmg1dkx6RTZ6eloya0hjTE9ybUVHaFJDKzAr?=
 =?utf-8?B?TEIzMVFoTlNvR0xlTE95bVRSZ0lJTWIxTHYyR2lkK0VnODBqMnpGd1JvVFVR?=
 =?utf-8?B?OFBvOHRPZURPMnRQL0hac2NiK1BhVDFNNVhHU0hGeEt1SW1VcFFQMnp5UFN1?=
 =?utf-8?B?bENha1NCanpZUGdjM29sM1g5V3g3Z0I5UjNwVWcrdXZOWE5NRFRNQ2F6R3Nr?=
 =?utf-8?B?eVNvQVNkRjJRSzcxVDFsR1p0Tm1ZRFYvSkRLaWNIL1FBTjl6aGJYbnczUzgr?=
 =?utf-8?B?S2FhSEdmTy9iM1daZjNsQ1RucDZTakJBOTc4Tzl0SjY3Wk9ibVhUbGo0QU9r?=
 =?utf-8?B?K1hJOVRsRFBzUUFzSm1OeDZMb1BHZHdheTFTSkhnM21wZ1ZBU2p0UmFFTlNo?=
 =?utf-8?B?WEFSRG5SMTRvQzhUclBXUWNmeG54Uk1iNUt2cjBOVnFNNnNYMStQK0phcS9j?=
 =?utf-8?B?RHlHM2ZoMDlHSklJdUw1MzBWeDdQbHZsak5IVm5tRVJoYys2a3ZKdmI2VzhN?=
 =?utf-8?B?bGlYZHZGUmdOWSt2Zm41aURhWldCdW9QeTJMYW1KbUFXVFdUSUJVbHVtbis4?=
 =?utf-8?B?ZWx1UXliTHp2Ym83SjJmODJGcTQvRHB3djJic3htOE9LdU5YZzh2K2x4S3ZV?=
 =?utf-8?B?eDVZMzNlN0JJMWM3WVdlMWVENCtVU3pVaTlCanVjOEVGU3hBcFliWVRJK3Vu?=
 =?utf-8?B?Ylo1b2liOExXNHZqK3FmVzlvM09MR0dBUS9ZKzJYSUxJZkpwbVBSa1pxaVB3?=
 =?utf-8?B?UEJkNVpUblhDRlc5ZkxBYXlWTEF3NDdvMlJBWXF4RW5YWHhMRlNLU0dBUWda?=
 =?utf-8?B?eTFkeHZ2dHh0a3NCTjlBWVlSN0t0eEpPMndjRXFPa0tXVERVSG16eFRIMDdo?=
 =?utf-8?Q?vpBdWk5zto1NGkK3lAMLQyM73?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d25384c-df24-4227-a8cd-08dcc07ec538
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 18:43:08.8237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BYPPIhSEyd+3cw5Re90LAWIncWpvC9dvGRvyN2q7xDzTW8Bf+ezkuY4EhBkRpo9Tba1fJprWNthTV7xu8/SyLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8801

On Mon, Aug 19, 2024 at 03:21:36PM +0200, Daniel Lezcano wrote:
> On 25/07/2024 21:33, Frank Li wrote:
> > From: Jacky Bai <ping.bai@nxp.com>
> >
> > In tpm_set_next_event(delta), return -ETIME by wrong cast to int when delta
> > is larger than INT_MAX.
>
> Is it something you observed or from your understanding of the code ?

System use this timer to wakeup from lower idle, which core and local timer
turn off. -ETIME may prevent system enter lower idle, or failure wakeup
from lower idle utill counter run overflow. I am not sure how to trigger
this problem.

Assume run at 24Mhz, 1/24us * 0x8000_0000 is around 89s. Problem trigger
only next event bigger 89s, which relative quite big number.

Anyways, the original code is wrong, it claim max delta is 32bit.

Jack bai: any additonal supplement for this?

Frank

>
> > For example:
> >
> > tpm_set_next_event(delta = 0xffff_fffe)
> > {
> >          ...
> >          next = tpm_read_counter(); // assume next is 0x10
> >          next += delta; // next will 0xffff_fffe + 0x10 = 0x1_0000_000e
> >          now = tpm_read_counter();  // now is 0x10
> >          ...
> >
> >          return (int)(next - now) <= 0 ? -ETIME : 0;
> >                       ^^^^^^^^^^
> >                       0x1_0000_000e - 0x10 = 0xffff_fffe, which is -2 when
> >                       cast to int. So return -ETIME.
> > }
> >
> > To fix this, introduce a 'prev' variable and check if 'now - prev' is
> > larger than delta.
> >
> > Cc: <stable@vger.kernel.org>
> > Fixes: 059ab7b82eec ("clocksource/drivers/imx-tpm: Add imx tpm timer support")
> > Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> > Reviewed-by: Peng Fan <peng.fan@nxp.com>
> > Reviewed-by: Ye Li <ye.li@nxp.com>
> > Reviewed-by: Jason Liu <jason.hui.liu@nxp.com>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >   drivers/clocksource/timer-imx-tpm.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/clocksource/timer-imx-tpm.c b/drivers/clocksource/timer-imx-tpm.c
> > index bd64a8a8427f3..cd23caf1e5999 100644
> > --- a/drivers/clocksource/timer-imx-tpm.c
> > +++ b/drivers/clocksource/timer-imx-tpm.c
> > @@ -83,10 +83,10 @@ static u64 notrace tpm_read_sched_clock(void)
> >   static int tpm_set_next_event(unsigned long delta,
> >   				struct clock_event_device *evt)
> >   {
> > -	unsigned long next, now;
> > +	unsigned long next, prev, now;
> > -	next = tpm_read_counter();
> > -	next += delta;
> > +	prev = tpm_read_counter();
> > +	next = prev + delta;
> >   	writel(next, timer_base + TPM_C0V);
> >   	now = tpm_read_counter();
> > @@ -96,7 +96,7 @@ static int tpm_set_next_event(unsigned long delta,
> >   	 * of writing CNT registers which may cause the min_delta event got
> >   	 * missed, so we need add a ETIME check here in case it happened.
> >   	 */
> > -	return (int)(next - now) <= 0 ? -ETIME : 0;
> > +	return (now - prev) >= delta ? -ETIME : 0;
> >   }
> >   static int tpm_set_state_oneshot(struct clock_event_device *evt)
>
>
> --
> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog

