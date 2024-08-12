Return-Path: <linux-kernel+bounces-283645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C47B294F743
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 21:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 414901F21F44
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 19:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C508F18FC75;
	Mon, 12 Aug 2024 19:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ykjoe5+u"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013035.outbound.protection.outlook.com [52.101.67.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EEF1836ED;
	Mon, 12 Aug 2024 19:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723489698; cv=fail; b=mgLYRIGk+fsgRHvUPKcu931qqiCDPXusr35ZOeeIDFZgY2I4A96N4/3cIL9xgmPGcln9qIosxj18c4/J2sZuibLZfjZ07vzfhQc1DBHDxUTzprZwrTgoeAYmQrI+M5zD9N1UhQOveILjfJfc8f6WiBj9bQtqMsOsghS+8Z1DEl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723489698; c=relaxed/simple;
	bh=2Nb/IUMFz9ofStHNWATznVRZwOe0ebniQNjdErHBwDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H+qx1NAO9vDCUDgx3c2vG1KkSGXZJ7/7G8Mib8v0wFvhx22QS2ek0hRgSZrVnjBM+zFLN4Tg3JDD5a+BHJ+qsC3ypHSCG4ltLuZEpljJja5Lyo46Y81nf7uHWM72pqh0VUY6AO0rCsdY9deolBc3EIp+ZPEISBLdzWm/NrvXDeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ykjoe5+u; arc=fail smtp.client-ip=52.101.67.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RzPdpY6cvll8G5gWJxFdm4rd9HJdM7d7FlVhpnYqlzZUcm9J5FD03oh7jukq4ziKcYxYtPB8BtI2V6XsSEtRIZ+PNZCgzYkRYrDPifNIU2TYdR7cP/+VFWn/EiTLRHfDem4BPNW7X0l1uhS49ShMyag93Bd7VZrpv6hFdQ5/R8Kn6FNIat/kXLVf73JYILv6QpOiqfV+T916O4Pq8grsYa+p9y/DY2JTmnXX+hGNNuN5JULWybU5YjEjBTmlJITQoGk8jzDB1tMZikIdAm5LXNxObi0zWmn4t7t5gMuFK4ENi/8J6iye2UUvPY+9VJTYfjZT5OYcHUK7D0SrY+2bLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wZfJxxwS4UkNODHqpzav/F0NopQXThCw3akYPtB3Srs=;
 b=XInV14JoPLiSZDbT3WJBiRft3aHZiaYzTDgw5cDPWkgGnEK4GHfkM51XqThdZ9GdscHr6rF4qdyUuhRHZXW+FEsPQJrIEVO1wYKtglODRZMvdH5xNS24Enf04Mg0L2dStzkfRZFGlTMQ4oR/G2SfCUC3CWjuQvtRzWnJ1b/S9v2SGUHGha8XsRSOu9scortDI8G/hqCxSQfLRsTlBP6A03Gv3SaWgb/4d67UjbMTbvi4X0Ns9BmtZX4CT718QdQMt9ls8pf/1DjBvox4JkziaI1jIRTkCV2w4ks3pXAFyza5FpDJWk2LOsHZsKZw9JQcYCI9IGH13nyCfCkQhqNkxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZfJxxwS4UkNODHqpzav/F0NopQXThCw3akYPtB3Srs=;
 b=Ykjoe5+uJ5o4a+X3wRkCyoyHLBh1jji1W4VOIkw7PI68wJfrOeqdEZddruKCqI9atTWeIcpc2qSh9dIhW+uJK7SwB+95VsEPwLSMnMKbR4lcwO+1g/IRlBFAhl5/Rn4awwA6+5gMPUnSXBMWquz3COpg9bXzwm49FW5YNHYhZiWDMXxJLOdR5mWRvO9CV20ljTFgaLrpM8M3aRa8jQDQ5S5wue8ZpqIXE99ywa6xRU6uKHQ0V1NAlB4cxskYdKe0N38xuqQbAlPRFD1Ou7VdBQZd+HGNeAnwf29iMOJ2OAI/6JD0/V7K0oosxa7BSJrA2p7yGkgb2ZTq1YwSlNbbSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9773.eurprd04.prod.outlook.com (2603:10a6:10:4ed::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 19:08:13 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 19:08:13 +0000
Date: Mon, 12 Aug 2024 15:08:04 -0400
From: Frank Li <Frank.li@nxp.com>
To: Rob Herring <robh@kernel.org>
Cc: Conor Dooley <conor@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] arm64: dts: lx2160a: Change PCIe compatible string
 to fsl,ls2088a-pcie
Message-ID: <ZrpdlNrs/qqFGhFV@lizhi-Precision-Tower-5810>
References: <20240808153120.3305203-1-Frank.Li@nxp.com>
 <20240808-frosted-voicing-883f4f728527@spud>
 <ZrTphsdTZVsbiGo/@lizhi-Precision-Tower-5810>
 <20240808-linoleum-evasion-ad7111a2afc4@spud>
 <ZrTvB/3GGIhEOItT@lizhi-Precision-Tower-5810>
 <20240809-freewill-compactor-4f441a4a60bb@spud>
 <ZrZNzqDKUaOqzl7k@lizhi-Precision-Tower-5810>
 <CAL_JsqLzvEpXbTk0XjPuErz2nRaTXX1DP9WG8yshULcVv0bS-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqLzvEpXbTk0XjPuErz2nRaTXX1DP9WG8yshULcVv0bS-Q@mail.gmail.com>
X-ClientProxiedBy: SJ0PR13CA0051.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9773:EE_
X-MS-Office365-Filtering-Correlation-Id: e40d3e59-c136-4c2b-cae0-08dcbb021cf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bS9PYjQ3TnVTbVE3T2p6WUh6QWRmS1J1YzV4eWU1TnRFVXZyNkU4VnF1K1Uv?=
 =?utf-8?B?VFQxRUZNYWkzUVE1bEoycjNCQzl1bHN6SEo4SVZTUXlMMEt5Z2doWVFJK25n?=
 =?utf-8?B?KzZqcTQ4dTJKclhqc0VqVXJTQWM1ei8ybEgvckFwWExCcnpLZkFoS0lENUpI?=
 =?utf-8?B?Q0pJMktFM0ZCV2hGcmhtazZKM0Y4dnE5L0JzYXdESU9HZUZnYU1SbTBFenBo?=
 =?utf-8?B?Z2RSMlNleGZocWZYWnRwMTR3aFhxbkYrS0NGaVZCS2s4WWpUSlh3QlpQZE5D?=
 =?utf-8?B?SkRvL0U4Qy9wK3NPZ3dzN2pVZTFBYjlxRTRSdmZDZUlnK0MyWDczeU5RbE80?=
 =?utf-8?B?dVhlRE54RGk0NXY4OEYyQlVGdWljcUxkbDZ5RlphMGFQNG5aT0xoOUc0Skpt?=
 =?utf-8?B?bndQL0ZHME1KbHVzSFFMQjRWYzFyTFFrcEJqbDNZRng5UlNSK3phSlJYbXgv?=
 =?utf-8?B?U3phSlZNSHJ1c1p3djJ3akdxVTNYMDNTZ0g4cHlVM3ZPQzhDNnBuc0dNQVlN?=
 =?utf-8?B?WlRkSnJZVTViSXJiaUQ0M3FLNUR0S0NCVWxEVHhQZ1BuTFFyVzNveThldm15?=
 =?utf-8?B?bmxQRW9ZMDVqQTJUSEdlckk4V1MxTlgzejcrd2ZLWFU2c0x4RGVGSmZOSFBR?=
 =?utf-8?B?YStLcFdOTkY3S01mZ0lDS1ZuTjFCWHFMbjh1SlRqWjR1Z3phS0prYVhKN0Jr?=
 =?utf-8?B?cTMyNUIrTVpIV2g0T0I4eVJ4cEJmekZuZXdTYW9qOXJDNDFZMWdRY3VjSnVG?=
 =?utf-8?B?RDliQkRVUW02cm5BcTcvckplOXBITUxXZENDZHBaU1BHbzBaRmIrRGd1dFZR?=
 =?utf-8?B?Y3EwQTRGdGo0bkFCYjVLMGtBYzBndnhnNG03NE9sMHIvVnV4SXZkMVlTeURv?=
 =?utf-8?B?cnNWbXZGSC9UVTh2VTBITDhiWGJCZlErbUNSYUM0b0E3TVdkeTc2WXdDVHlW?=
 =?utf-8?B?Y005QXp2RHJ5SVVEMG4xZEo1cEtQdXVBZlpZZUlyVjI5alZDaGRQU2dRUStG?=
 =?utf-8?B?M1crdGdWR3ltLzlTSFBsbWU2bnNjQk1tSHNnRXdITllRdzFFeUFSOFRjMFdr?=
 =?utf-8?B?YWo0K2w2dStaclFCSjFOMWJxV0RHbGhQUHhrQ2lZQ25KWDFOc1pKdTMrY2F6?=
 =?utf-8?B?bmpFN3dQSE1GT0Q0RXpRSkFiYzZpSVdXbzlKbGlHTmdUMGZXenhHSjdNcWw2?=
 =?utf-8?B?d0lmREJtTlR3MXBoSjF6V3Y1WEJsbUwvbFVKZDQrZ2M4V1lRWXZBVnQ4VFgw?=
 =?utf-8?B?S1lYVTBuQWluOXdQakJ0Sk91K3VvUWVjTHlpMEdydTBiOUJ3M29yaTJORlRw?=
 =?utf-8?B?R2tuU0txVGdFcFVUdDBrY29EY0VEQlhQVDc1YThSUnh0b3NOUVRLTGV4OU1J?=
 =?utf-8?B?STRURThtbHQ2WjZNV0dxT0xscXdLa3M2WWd3MUVpRjJldlJRT0VaajFsUmEx?=
 =?utf-8?B?bHdHNGNrUkcyMHFUdVhicWoxbStLNUp6K25IZU0rM2QrVmw2eEs4d2NsZmhl?=
 =?utf-8?B?cFcwdkZRaWdIb0xFNVprN3RpbDlrZENkYUl6VlF4Vmw5TzdnNDVJZTN3UTZx?=
 =?utf-8?B?SlVkL3JLMFM0b3dFd0xPNVBHK2h6YXdxcmtUT09RUXVqWHVnd3VQOVlHMjR0?=
 =?utf-8?B?dDk2czJ6ZExFcnlvdFhtdjIrekZxNGxoYitNczYwOGduMEdNY25DUU9Qdjl6?=
 =?utf-8?B?YytRbXpLNjcxRk83QXY3akpnUmR2NFhVU3pWVGVwaXZZTlRDdGZ3TzhWbnll?=
 =?utf-8?B?SFdQdUl6bEJOaUNudUQ4MXBzU0lGRm5rRS9QeVVDbTIvWFJCbzkrTXIzVnhJ?=
 =?utf-8?Q?DPX6GHwuMJGPEZanmOzAWaj0NubIVyHvvLveA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGQ2OHNkZ1lZVnpreVQ2WXpTRFc3cmVxSmhCalNRTHlsSEQ5T2lzODFacXFT?=
 =?utf-8?B?aFUyTGR3VU9kTi8xNlpmZUpYT3hEbG9zOTkvTGNncVVRVk95enEwcDZTMFVZ?=
 =?utf-8?B?Lzc1ei9OT2hVTFUzOGxFTzdGOGRzSkZ2NjlwMXhmSDB0Y3J5S3IyaGE4NDZy?=
 =?utf-8?B?MnJPaDNTanB3RW5IM0d1U3ZFNDdFL3dXcW8wTzdsRnZlWWVjZW51RnFzbURM?=
 =?utf-8?B?YUh0a1o3a0ZHYkg4VW9vZGx4MGtNV0swcWYxRVVYVXdoaklubExMTEdYVUZN?=
 =?utf-8?B?TnV5dmxMMGdwQWx5bUtCOE1DUlh5SjdoVzEzbmI3c2lGK0lkYkErdVlDbCtw?=
 =?utf-8?B?Q3FQcjl0UXJwN3MxckRyWVZhdTd3Nkc4VytncXc4cUVzZ2ttS3JXWFpoazZO?=
 =?utf-8?B?ajJhNjAvNExZRzhOUmdUS3pLUW53ZSt3WXI1NmZjb3VaU2wyUW5Tci9rR00w?=
 =?utf-8?B?c3ZkUmRGVFlnVjQ0d2JXelVDWUZndnFxRHlucVdvS0hEWkwwcDBmNmlDYXRn?=
 =?utf-8?B?bVhQdXdvMnB0NVlWQ1lqeUEwN3g2TnIyTElwRWZpK050YThQTzJBK0dVUUda?=
 =?utf-8?B?SWVSVzRUSGF0Nk0xL0pDVmtrcFNlK0tUbEY2QTRqK0x0TkhyT2J4MXpXcFVR?=
 =?utf-8?B?VnVQN1RKV3JYYnZ2UzdnMjBqZ2xycGlUYWdqUjdFMFZsM253dUx2SzBBeGtP?=
 =?utf-8?B?clNDSDcydTFoV054NTlrYW9YY3QvOWRnb3dwSHJNdWtlUU8rM3c5WFVKdkpY?=
 =?utf-8?B?YUdYalp2WmlqRTYyVVVCbFlHSmVhbnk1VXZsS29OMThpZ3MwT1ZBcmRHM3Yv?=
 =?utf-8?B?emlOSGtpd0ExVTdtRVB4WHljZkFrQnNWdTYrOElEMm5NbFJuQzJ4MWlSRnVm?=
 =?utf-8?B?My90a2JwTi9XalVLdDFTcXJwbllrNmdTRnVVV1oxZ0NveXZiMGRCclhnWEhL?=
 =?utf-8?B?QmNyZ09kYldzWU9GbFloaU5SRFlYQTgvMlhoNVYybndDS1F1TXMvSUY0Nm9m?=
 =?utf-8?B?WjVCTWZkN2dHdnM3S2JjbzM2KzBXNFU5WmpvSE1CZ21HVDNiMS9kaVlFMTk3?=
 =?utf-8?B?clZYZXBXZlRCTHR5Zi90MTlBaGlPMm1LcFg1WFpxM2pLSjdyTVg3ZFArQVVF?=
 =?utf-8?B?TmxOTmhlbU5STkVXYnNzME5uNXhrakpGRWEwUUdHVldvbnkzS3RPQzVuRHZY?=
 =?utf-8?B?QjBjbjYxRE5CVEErMGRvYVJ4RHZtOGd2Q1MvSWp0RDZiMEltM1ZkTFlMQWVv?=
 =?utf-8?B?RFVoLzd6WVllSFpCTU9xYzBkc0NueEpXTWhoWGRzYTBXTFM0aHJWNFJSclNv?=
 =?utf-8?B?SWZLQndUYnJhZ0FFMkJrV0FtZ1YrdlAyN0IrcVJVK1k4WXY0RHN4VkRlSlIr?=
 =?utf-8?B?UmVvM0xkWTNvR28xWTkrY1h5ZDBWM1RkWStwS3FrMFlESWt2YU94Lzl5WjdP?=
 =?utf-8?B?eHNNNFA5eEF6UlhmemoxY2VGRGZZdithUEJTUmpvVkNJMG1MdHU0MSs4MlRF?=
 =?utf-8?B?R1ZLWFhmQVFac2hUSFBFUGxpaEdBR2poOU11anpzYUl3UDl3Rm1ndy9KbjJ2?=
 =?utf-8?B?TUlldlZZR05FMUp4UlUybVF1QnFUdkhYWGgvdzlJQnFZRGhMTTlabHV1TW8v?=
 =?utf-8?B?dWJNR3IwWUZYN0NxMWcwVCtZSzM2M3RDY1cwYklrNVFiMG9ESnN5RHN0ajM4?=
 =?utf-8?B?dlN6dFR5OUNuRDllOHVvdWJzdHJRNm5NbXI3Q0xqYUhZYmxQeGY5YWJiVlQ2?=
 =?utf-8?B?ckkxM3FtSjZlNWg4UUhQemNVbW9mc0xPWE1oWjBFZldhVVp1K1hSSXNUelRS?=
 =?utf-8?B?UHpOQTJrZjBOMjJnWGhXMzFWdFl0YWhJc0xkSWlkL05FbzFhNkR0bC8vQk83?=
 =?utf-8?B?NXlhMEd0aUt6UjlHNDFQcmllTFo2R0NLeFE1bFlHTGdEbXpBVXJjMi9HbDlV?=
 =?utf-8?B?Ui8vYXdTaUJaczFCRjMyUmoxY1FzYklhQW5wdE05WTBGYXR5T0g4NkFBaFgw?=
 =?utf-8?B?bzZ4SzcrY0NCUGlDUlc3RGwxbzQ4c05qME5WTGo1Z2hYL015QkN1Z2hLeVB3?=
 =?utf-8?B?RGlMT05FaklPdThxUHE0djdJeEwva3RNaVZZbDl1VGJxZWNvZEQzbHpjOFlF?=
 =?utf-8?Q?frhk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e40d3e59-c136-4c2b-cae0-08dcbb021cf7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 19:08:13.1228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WxP/diHg1Yc3onaaP61EonKPhfc67omzgx0OftFqNMs1t1z6QBp8J8CBEeLEgVjqS43rvidHP/WNpNXDPo93yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9773

On Mon, Aug 12, 2024 at 11:29:38AM -0600, Rob Herring wrote:
> On Fri, Aug 9, 2024 at 11:11 AM Frank Li <Frank.li@nxp.com> wrote:
> >
> > On Fri, Aug 09, 2024 at 04:07:25PM +0100, Conor Dooley wrote:
> > > On Thu, Aug 08, 2024 at 12:15:03PM -0400, Frank Li wrote:
> > > > On Thu, Aug 08, 2024 at 04:55:14PM +0100, Conor Dooley wrote:
> > > > > On Thu, Aug 08, 2024 at 11:51:34AM -0400, Frank Li wrote:
> > > > > > On Thu, Aug 08, 2024 at 04:34:32PM +0100, Conor Dooley wrote:
> > > > > > > On Thu, Aug 08, 2024 at 11:31:20AM -0400, Frank Li wrote:
> > > > > > > > The mass production lx2160 rev2 use designware PCIe Controller. Old Rev1
> > > > > > > > which use mobivel PCIe controller was not supported. Although uboot
> > > > > > > > fixup can change compatible string fsl,lx2160a-pcie to fsl,ls2088a-pcie
> > > > > > > > since 2019, it is quite confused and should correctly reflect hardware
> > > > > > > > status in fsl-lx2160a.dtsi.
> > > > > > >
> > > > > > > This does not begin to explain why removing the soc-specific compatible,
> > > > > > > and instead putting the compatible for another soc is the right fix.
> > > > > > > Come up with a new compatible for this device, that perhaps falls back
> > > > > > > to the ls2088a, but this change doesn't seem right to me.
> > > > > >
> > > > > > It can't fallback to fsl,ls2088a-pcie if fsl,lx2160a-pcie exist, which are
> > > > > > totally imcompatible between fsl,ls2088a-pcie and fsl,lx2160a-pcie.
> > > > > >
> > > > > > Previous dtb can work just because uboot dynamtic change fsl,lx2160a-pcie
> > > > > > to fsl,ls2088a-pcie when boot kernel.
> > > > > >
> > > > > > fsl,lx2160a-pcie should be removed because Rev1 have not mass productioned.
> > > > >
> > > > > Please re-read what I wrote. I said to come up with a new compatible for
> > > > > this device, not fall back from the existing fsl,lx2160a-pcie to
> > > > > fsl,ls2088a-pcie.
> > > >
> > > > According to my understand, It needn't add new compatible string if nothing
> > > > difference. for example, it use fsl,vf610-i2c for all i2c without add
> > > > new soc-specific fsl,lx2160-i2c.
> > >
> > > No, you should have soc-specific compatibles regardless. Just because
> > > you got away with it once, doesn't mean I'm not going to complain about
> > > it here!
> >
> > Rob:
> >         What's current policy for this? Not only for this one. If new SOC
> > appear such as iMX10 (maybe many derived chip i.MX101, i.MX102...), there
> > are bunch of IPs, Do we need add fsl,imx10* for everyone, which most part
> > is exactly the same as old one and bloat binding doc.
>
> Yes, you do. Do you really know that something in the design hasn't
> changed? Have you compared the RTL between the versions? The only way
> to deal with quirks without changing the DT everytime is by having
> specific compatibles *upfront*.
>
> The "bloat" is never that much because the IP really always changes.
> QCom wanted to (and did) use IP version numbers for the same reasons.
> Guess what, the IP version number changed on almost every SoC.

It is quite dependent on IP itself. Some IP (such as I2C, SPI, UART) is
quite mature. There are not user visual change in difference SOC. for
example in drivers/pci/controller/dwc/pci-layerscape.c:

static const struct of_device_id ls_pcie_of_match[] = {
        { .compatible = "fsl,ls1012a-pcie", .data = &layerscape_drvdata },
        { .compatible = "fsl,ls1021a-pcie", .data = &ls1021a_drvdata },
        { .compatible = "fsl,ls1028a-pcie", .data = &layerscape_drvdata },
        { .compatible = "fsl,ls1043a-pcie", .data = &ls1043a_drvdata },
        { .compatible = "fsl,ls1046a-pcie", .data = &layerscape_drvdata },
        { .compatible = "fsl,ls2080a-pcie", .data = &layerscape_drvdata },
        { .compatible = "fsl,ls2085a-pcie", .data = &layerscape_drvdata },
        { .compatible = "fsl,ls2088a-pcie", .data = &layerscape_drvdata },
        { .compatible = "fsl,ls1088a-pcie", .data = &layerscape_drvdata },

Only 1021 and 1043 have difference, others just copy layerscape_drvdata.
I met similar case in many other drivers.

Can we consider just add new compatible string only when visualable change
happen?

I am confused that some use old SOC compatible string directly, some add
new SOC compatible without any actual change.

>
> The exceptions are really if different SoCs are just different
> packaging or fusing.
>

I see.

>
> In this case, I'm inclined to say just match what u-boot creates, but
> please make that abundantly clear with a comment in the .dts file and
> explain the situation in the commit message. OTOH, just adding a new
> "fsl,lx2160a-dw-pcie" compatible with "fsl,ls2088a-pcie" fallback
> doesn't hurt, and we can just move on from creating a special case.

It is small problem.
In https://lore.kernel.org/all/CAOesGMhz8PYNG_bgMX-6gka77k1hJOZUv6xqJRqATaJ6mFbk6A@mail.gmail.com/
There are still small number user use ver1 even NXP not support Rev1.
According to my best knowledge, rev1 never mass producetion, only few out
of NXP to do evaluation.

I may need create rev1 overlay dtb for old chip and default use rev2.

Frank
>
> Rob

