Return-Path: <linux-kernel+bounces-295014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7AB959560
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 09:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FFD81F21D53
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 07:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF491A2879;
	Wed, 21 Aug 2024 07:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="mzZLNCZw"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2066.outbound.protection.outlook.com [40.107.215.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056DF1A2855
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 07:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724224121; cv=fail; b=LBnOqJol3yBDYQKeGFwrFTo+HDDEpl2q1kH11IS8+RRddchAAIFP+2cPJxtGD/6Sei5hpoZ59ONg79ABrXco49bgAJewnlPyAlrEXAINtdmzReCnxR5l4veJPwq8EL9F49+rZV8DXSbGgEL3bV9AbL0mFx49idQPxjVDfompG3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724224121; c=relaxed/simple;
	bh=sZZJWCVBU5YK4oAaGVU7ZEAvl00Dtd4x2LRKY2IChD0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CDsW7O3U8JlBmWcxqz0r4Kz24lSBnfx5KrH/XxXN4r0SbwWvso2uSTrXQJ3kkkOSqVyYZMVhTiI7IIWOGpXd7zW+hIdXwvqNZsTMNZAHLJxLcKGHwLPwcbmMLFjrgfmc+IpEYsFN5zbTz+Oc94GCA+NVTdf2VSZ2E31QU0uaEbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=mzZLNCZw; arc=fail smtp.client-ip=40.107.215.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YnhQHjko2tBwfe5dORZYlYogfve+VrSeQn5v+kBa8Snpl/lRqgjoSdB7ksJe6c7x0OKJNAiEC6/baLPhKd4pju/AdWHhQ6hjHCOEdd+5MH7MHiO20vyMwEucrNcgINtQ1Jgn+e8tXcupDu4IcDwU8h4aX2i4mmnfx5dG/NZfFZ/41aEONr06eBEptv2F8v6moHDwd1cPB438VycLQ6vY5DS8nuuqxIkW2BHW2HDSU0lEhyk+75naSHYltaCZfnFroEr4oOTArdyfdm3ihy9uExYmXVd6Eg51HhER3h0iT4uBfwUIFSPk/WekDOT5dezeDrLhWkLk/ZssiJPb0u4AtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3ePeK1ywwAE3a0BQFYb3ns61VzX8+Vp/MkUifj29fs=;
 b=PnJBHLHg15sRXBLHsBIxfoDWthfrarXkkZXXZZg8RHzz0v+Kc6+6EDiX9AJ0sB/32LL501g4zbEpq/9BuA4zLtF9ZAXVVYISEHUD6lytpqbsge5BmcQkFNM1wZYzPeUncMvdVegwkvjtnBTQAz6hwaBvA8BYjvxyO9IjN4uUCdna2Oww3kTRN3DyZg4od2uL8xc9M/XgprqNlqYQNsYBKXs/zCcVHX8210mw2pVFlKGTKOpBEW8ucQMIKfr0647ZvxswJQ8hnVXHWS3+IvgEmhHDGktZHFep8ihWaJVCxERMaNE2Zr9X7TFvQLKCtRCylrxPPxAhL9422zn/6mkmyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3ePeK1ywwAE3a0BQFYb3ns61VzX8+Vp/MkUifj29fs=;
 b=mzZLNCZwp1OIsBZAO4vVp/WKLsSof8IiLLlNHJ45BXF1Siywjiw3vbbQbR9y1hBwuotYLxTjxlfQa6WGmCAXF6YK4LqGP/WOaWE8j/7lcWqkq0nuqD+fySzcKetrcfYFY+CLCLm9gb4tD814aM0J0AivofD2BTNuD1Yobpav9A6WBxz+Sq/xuEaHff54jm7SmIGG/w2NaVLa/zFZ6eLr+BPAVZF/3RShD97cJjHP3b+dWLu1i70V6amcTgQ90+3ek7D77YvbBC3kaPM8a3vnNL5k/H4162FotaCPD39Tj0/s6gS52pvFCjW0Iybzgz7uGIdnKtYNeS/SMDXc57xWlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by SEZPR06MB6160.apcprd06.prod.outlook.com (2603:1096:101:f3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 07:08:35 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%5]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 07:08:35 +0000
Message-ID: <b8e9e59c-6486-478a-bd25-ee13cbcc46cc@vivo.com>
Date: Wed, 21 Aug 2024 15:08:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mailbox: sprd: Use devm_clk_get_enabled() helpers
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Jassi Brar <jassisinghbrar@gmail.com>, Orson Zhai <orsonzhai@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>, linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
References: <20240821013901.787555-1-link@vivo.com>
 <8f577565-69b7-4da0-a7fe-2e94bf37948c@wanadoo.fr>
From: Huan Yang <link@vivo.com>
In-Reply-To: <8f577565-69b7-4da0-a7fe-2e94bf37948c@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0047.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::10) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|SEZPR06MB6160:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fe357bc-df2e-4dc1-2f7d-08dcc1b012b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OGI0bW9SeDJ4MzJLbUhHck5RRHN1ams4cFVBOGthNlA2SVNsSTdkUkpHeUdW?=
 =?utf-8?B?NEF0N2pLSG5yTHdrZkc3eUtaQ3VzRXM5bVZWMmFIME4xZ3U2MUNwaHgxbXQ5?=
 =?utf-8?B?andoQWhyK25NbnQzUlRlQzJJQVBhdHdMYTZsQ0tYamw1S1BtZ1VUQW5XejZz?=
 =?utf-8?B?S1VqeHR3Mk5Bcno3cDkzanNCdGNOMmplRERIVUhkdGtPb0JuS3BHalVOaDJp?=
 =?utf-8?B?dWxWRUNmVDVmb0d6UjVCc2MwV0pJSURsaVp1N0JheXkzRmh2M1ZkQTdVOHVl?=
 =?utf-8?B?RHQyNWlVRDZ5VWg4MDc5bmJkWklPMExvalU1TG9iaE51K3lNZnpmRlA1US9R?=
 =?utf-8?B?dHFselNjS1JpeFUzbU85dkQ5OENFdzJwa0JtenBPYTkyZTBldHNoZDRzZkl4?=
 =?utf-8?B?L2xPbk44MGpscC9yQit5VHRFSEU3MEtmWTBZVGhkOWdQNy9sZU1YWHZNL3Z5?=
 =?utf-8?B?b3VMSWl6cTBMYlJOM0ZkU0Q0ZzAvQ0V1ZTFQMGdEcFR3dzVOZzgxRDYvRVRF?=
 =?utf-8?B?S1lPbHRtRlFMcmpkQXhIUStOZUFpSmNjQlVmalBpL1FxcUV4T00ySlNtR0ht?=
 =?utf-8?B?RFphdWF2aDRKUFhJeFdyajRoaUdmWEhvNVlNT1owOW1Mdk1zTHE2WDE0Zk5V?=
 =?utf-8?B?cmg1eTBYRFdXNGFyQnlmNmkycnB2Znd5dnE4OXN0Q1I0anFoSmJlOXRLNmpR?=
 =?utf-8?B?amZxaG5ScDJQRXFScnlld1g4bU1lZUpUMkxyNUdQRy9XczJybjRuNXVqdVBO?=
 =?utf-8?B?T3gyZXRvUmY2bDZ1WGJ2b2R0NWdSMWQ3WWpNeVk1NTVqODF5aGVKYVdwaERC?=
 =?utf-8?B?OEhXNGw3TFZ3Q3dUelpRRFBWbWxKUWtJRlpYUHJUbHUzak9FNmxoWEVYdm5H?=
 =?utf-8?B?ZEZBaCs3MXJLVE16OHFZWVpWYndrL3MrS2pXeGtQWG5US24xZURLdmh5cWdY?=
 =?utf-8?B?VmVjYUVxbXBtWlZ2ZHJ3SWNTaC9RQmI4dkFWVnkvN0VwZnYxdHVDSXd3ZzRj?=
 =?utf-8?B?UVp3QWQ1SWpGdENrTTQ0RFRJMkpVMnFaejlhdnc1Y2dTRFVhejcrVVN1NndN?=
 =?utf-8?B?eHM0OTVMTHdTYktiZjZpUjQvV1RVdkkyZWR0a0NiT0pMdm0wNDlGSit2dmd3?=
 =?utf-8?B?Z0tjNjM1djJFaXdzWTdKQlBQdFM1QUgvV3lTZjhLRHZ2SUhvKzF6QUxEbjUz?=
 =?utf-8?B?TEVoYkd4L2dldTVoa0huMWlnR3JZUExyYUtNam5UcitBanBkS3VTZFZId2pT?=
 =?utf-8?B?cWxSZGNlSld0UU56Vkg2TmpTQW9DOFl1cUQxOXB4djhkSEZNaXRCTFlnQkg0?=
 =?utf-8?B?R1lGUE8xRHV1TExPVlB0NXMrVU1JK1I5MXhGZVY3bFgzTHNObSszVzVPdzNE?=
 =?utf-8?B?aFJjVEZGQlNUQ3lvS21BRG9GUE1RZGExYTltVzYwYy8xZnJzaE1nZjFLVkNj?=
 =?utf-8?B?NWtaY1hhbmMwRHpaK3VFY1QwT1ZNVFRCb2JmRHdHcG8zR3UrN0YwdEorZlFW?=
 =?utf-8?B?Tmw1YmhTMmZneEhxMTljbTI0aFRIUjhtZ2VoSitFTVJsZFI5VkVWMWdDMlNt?=
 =?utf-8?B?cXN3S3ovZTNBM3gwUVloUEhqcU5EaWxwL1ZrcUZNb2hXYWl4bDFaelBkS3NX?=
 =?utf-8?B?YTZxTERnL3NQSU9MelVYS3RROWQ0MkVLdlArc05ZQlBTK2lndkYyVCtQVml2?=
 =?utf-8?B?U1p4VXVMNVhtRTd6aGJ6QnNtUzdrMWxValdpckJROGRkMTJIaHRDWW81RE1C?=
 =?utf-8?B?MURDZUNXQTR3TytjMHZXQkFIcnpDUmIrMHZ6V0pPdFUvckdQNXBHUndxVTdh?=
 =?utf-8?B?L1REQ1puWmo3WmN1cmdOQ3Y4b1B3OENSWmNhd3d6dFRsSDhpdVgrbUVIY2Uy?=
 =?utf-8?B?ZThvdmczVDFRSzRJU0xTc3dnZG51R2pWaGxnVzV6UUQyMXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVdwNEVKN2tINEZESGZJZXhwQzJldXhGKzhleHNWMmtROXMwUGQ2NmZ4T214?=
 =?utf-8?B?UjFWaDBrRk0xRHV2RGpSUlNaelowMGZHK09iaUxhdUN6WEVHalEyVUY1Mzls?=
 =?utf-8?B?TmZaZUMwMExURzYxR3JVRUEvdU5pL2tkb0w2QkpoSEFIVVk0ZExBeEtWQUt4?=
 =?utf-8?B?QXVkd2Yxa2I4dmRCaVpwcTU2dnpWcWs1VDk1QW5yREkwZjUxTythUGNqNGZG?=
 =?utf-8?B?dGMyN1NZKzZyN0dDNE1yb1gwV3NTa240cWd6Q3dOcnlOVFV6VDBxc2pHbk52?=
 =?utf-8?B?aUJjQjVsOFduT0wweC9oVEI2NVNqTnQyZVBWZk5Yc21xOXFnTG9vMDM4ZGxi?=
 =?utf-8?B?WTdBS3BGRC9HdDVrOEhGYkxwelFQSDYycWJPaStabHpBSk8xUFNJcGlZeFFX?=
 =?utf-8?B?Mk12QjdvSEtGODYrclB6QmtLeG9MTEVMUGtKUStpTWl6S2ZCby9KTDJYMUhG?=
 =?utf-8?B?eGRYeDFpckdXbnVHZlpTdXUvN2o0ZnNIMWxkejhuMU5UMFg1d1YwT2RoUCtK?=
 =?utf-8?B?MnNNbkhxY3J3TDNEVWVwd0hJc1g2aTduRU1CNHNKdzFQYnRRWWlsUyt6YkFM?=
 =?utf-8?B?VTBxaWNHQzRVbTYrV3Q0eFdwclhBWGlhMGg4Zms5czJYNk5MSHlrYjFRWWQ4?=
 =?utf-8?B?dCtPdXh6c0hJQXRKYlFSR0wvTnN5VlNrTzVGdFRJWnhOQzVkQkpXNFRGa2xI?=
 =?utf-8?B?bnp0NDJDREdleXFEWGk4VnJ2a2NybDdGWkhoVFdqT0ZldlFveUtLejR0d2Nl?=
 =?utf-8?B?MnhPMHVJRk14MkVHME1sY0ViUHliRmVQWXZtWXl0ZlhLLy9nSXpsUUhaYnJL?=
 =?utf-8?B?aFpQaThzN2VZMUt3aEZ2RHVIa3NpbHlUZzVWUEs3dURuUlR1Tm92MVdXRlph?=
 =?utf-8?B?aUgwV1F2ZHB4MWZEVzA4VDA3THJkaGpNN2piYnNXN3dhdnlkYTE5KzVjQ1Ns?=
 =?utf-8?B?Um9BUFdpc3NsZXB2WGdFNkg2WDN4bGx1SFg3TFZIOGg2M0kzbzFUZHpHZXAw?=
 =?utf-8?B?bVNxQ2EySk44dHdiV1FKdlB4WjRwZFhNZXVoaEV0N0tiK0ppb2xkaGhXTFJn?=
 =?utf-8?B?UVJJVUROWGpYME1tdkZZaUQ4ZmhFdXNPSVJvVERIMjBRQmphZUJLNXo0Vm5Z?=
 =?utf-8?B?VEMrZ01yT05YRVNhUTlMVHhUd2lPRVJkR01CeVZsQWRLNEU0TzZ4MDlBclZm?=
 =?utf-8?B?UVN4aHBheFY1S0FKaVdMTTN2Sm1HOGlic1FKT0h3UGY1VlBjbFRWUDV2SzhX?=
 =?utf-8?B?Q1U4VU5rMmhkQXBwMjFLR1ZkUXBXeDRmTXZVSlUwa3lGZGZPVG9RZnl5cFRx?=
 =?utf-8?B?enF1NkFBTTBoMXlEWThTcEVDR0p2bzN4dFRBZFpIUnpGZkxTUXlKRzlnTDEv?=
 =?utf-8?B?NXVCZTFEMUhNdWZtUFVHcUl2Zm16bW1sdUd0a2Y0RkRyY001RzVJNW4rUWV4?=
 =?utf-8?B?YUlnUzVTTEMzeFIvZlJNUEVFbUUwaHZWRTNBYlIzK212Sk9GRU5KVDN6bVh1?=
 =?utf-8?B?UXE4KzN4bEJXZHQxTmpnclFmWUZ1T0k1ak9xcmN2RW9DbkY1R2M0UVZyQ3dG?=
 =?utf-8?B?cThpVGVOQm8wa2xzM0RnamhwczFGR09hYlhBaWNZTVd2T1V4K3VMNXFXSEcv?=
 =?utf-8?B?ZEE3Yk92eExuR3Q4bkh4aS9ISWVIUi9FMmlFWXoxTEh3M3JVZU9rdFlUNjlQ?=
 =?utf-8?B?dVVMTGxHcDRCTU9Ud3dRcGNEeVJVaFlIenljeWo0ZWxOZVJLV1AxVjhqQ1la?=
 =?utf-8?B?NlozRnZNcW95MXQvczJtWUxtaWl4VmQrSm1XNlIzT1hKc2hES2VZVHV4V2NJ?=
 =?utf-8?B?UHovMXZzWlh2OUJ2WDhaTHdnRUdNOTRpWFY2SGFqUU95bjJjNUQ0cEUyRmpS?=
 =?utf-8?B?bkFEL2tFWXNRdjlVMzlmOVJROTAzSUZTN0tnTVhjdFgyWEU0YkVvemU0YVh2?=
 =?utf-8?B?MEg0VGZjSE96VzVVdXNRTWl3L291aUpoUG4vTE9pSmMrbUplVmsvZ2gzQlNz?=
 =?utf-8?B?M1o1UkFMU2hEUzY5LzdqdFJ0YzJhMnAxbmNnVXo4OFRPNWNqc2ovc1VHY0NN?=
 =?utf-8?B?M0c3OC9GdHk1RkJYU2ZxajZwUVlQTjMzYlJSNndEQ21LOHpEOVBJbnJKWjE2?=
 =?utf-8?Q?viP/HSZr4pmTW2APB0P62KkAq?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fe357bc-df2e-4dc1-2f7d-08dcc1b012b8
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 07:08:35.3861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 71K8UzMEa5tSZnuIM8y7lZrZr+1Lm3OrwvvZbRKkfoG0z1oN0tXNSlB5qQcxFzk79BSD2MJD5EDOeVnvm9Yf7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6160


在 2024/8/21 15:00, Christophe JAILLET 写道:
> Le 21/08/2024 à 03:39, Huan Yang a écrit :
>> The devm_clk_get_enabled() helpers:
>>       - call devm_clk_get()
>>       - call clk_prepare_enable() and register what is needed in 
>> order to
>>        call clk_disable_unprepare() when needed, as a managed resource.
>>
>> This simplifies the code and avoids the calls to 
>> clk_disable_unprepare().
>>
>> Due to clk only used in probe, not in suspend\resume, this pointer can
>> remove from sprd_mbox_priv to save a little memory.
>>
>> Signed-off-by: Huan Yang <link@vivo.com>
>> Suggested-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>
>
> Nitpick: no need to add this S-b. I just made a comment when looking 
> at your patch in order to improve it. I'm not the one that suggested 
> the initial change. All merit is yours.
Your suggestion is helpfull, help this patch be better.
>
> Also, I think that, if used, it should be above your Signed-off.
Hmmm, it's neccessary? If so, I'd like to update it.
>
>
> Reviewed-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>
>> ---
>> v1 -> v2: remove clk pointer from sprd_mbox_priv
>>
>>   drivers/mailbox/sprd-mailbox.c | 25 ++++---------------------
>>   1 file changed, 4 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/mailbox/sprd-mailbox.c 
>> b/drivers/mailbox/sprd-mailbox.c
>> index 9ae57de77d4d..ee8539dfcef5 100644
>> --- a/drivers/mailbox/sprd-mailbox.c
>> +++ b/drivers/mailbox/sprd-mailbox.c
>> @@ -62,7 +62,6 @@ struct sprd_mbox_priv {
>>       void __iomem        *outbox_base;
>>       /*  Base register address for supplementary outbox */
>>       void __iomem        *supp_base;
>> -    struct clk        *clk;
>>       u32            outbox_fifo_depth;
>>         struct mutex        lock;
>> @@ -291,19 +290,13 @@ static const struct mbox_chan_ops sprd_mbox_ops 
>> = {
>>       .shutdown    = sprd_mbox_shutdown,
>>   };
>>   -static void sprd_mbox_disable(void *data)
>> -{
>> -    struct sprd_mbox_priv *priv = data;
>> -
>> -    clk_disable_unprepare(priv->clk);
>> -}
>> -
>>   static int sprd_mbox_probe(struct platform_device *pdev)
>>   {
>>       struct device *dev = &pdev->dev;
>>       struct sprd_mbox_priv *priv;
>>       int ret, inbox_irq, outbox_irq, supp_irq;
>>       unsigned long id, supp;
>> +    struct clk *clk;
>>         priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>>       if (!priv)
>> @@ -331,20 +324,10 @@ static int sprd_mbox_probe(struct 
>> platform_device *pdev)
>>       if (IS_ERR(priv->outbox_base))
>>           return PTR_ERR(priv->outbox_base);
>>   -    priv->clk = devm_clk_get(dev, "enable");
>> -    if (IS_ERR(priv->clk)) {
>> +    clk = devm_clk_get_enabled(dev, "enable");
>> +    if (IS_ERR(clk)) {
>>           dev_err(dev, "failed to get mailbox clock\n");
>> -        return PTR_ERR(priv->clk);
>> -    }
>> -
>> -    ret = clk_prepare_enable(priv->clk);
>> -    if (ret)
>> -        return ret;
>> -
>> -    ret = devm_add_action_or_reset(dev, sprd_mbox_disable, priv);
>> -    if (ret) {
>> -        dev_err(dev, "failed to add mailbox disable action\n");
>> -        return ret;
>> +        return PTR_ERR(clk);
>>       }
>>         inbox_irq = platform_get_irq_byname(pdev, "inbox");
>

