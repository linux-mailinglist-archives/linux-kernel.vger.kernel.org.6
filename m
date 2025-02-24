Return-Path: <linux-kernel+bounces-528060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6682AA41313
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 03:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BEEB1645C6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 01:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6BB19B5A3;
	Mon, 24 Feb 2025 01:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="jmGGu8Hs"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2100.outbound.protection.outlook.com [40.107.117.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAAD198E78;
	Mon, 24 Feb 2025 01:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740362254; cv=fail; b=NMUfQ6Xy26UfMjQzJFuV76sPv4JQ8ujxAfxb0K9JT4MnTV+oeTsaqBmNQsIERRhvYqJhj9M2jDpBwhklZk4evA+QJ2nLczea5fzOcw0y6CgblkqnLlWhf70yr1T/sk8rp98IhXgUBQ5Q79g5EaqrQepv68iyGFAmZ7XCzmq/Tb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740362254; c=relaxed/simple;
	bh=2ipgJsR8mZDEPT68K23m2AEfpN3nwiuif/tr4xVd7U8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R37x/jrKsCCU1+vTpuxKb9lL6hdMCpEeMsREzpC1wrNeBezBfXKZX1CrzGnhexkPTmbsT5XmRc9KGXUVaEGwQgms6UpS3xLzxU2YKcoEKNa28/WBOeBjrjO/opcADztskL0eFaLt0/uR2T4QHlf30z9w8xRxzXQvIBInO775Zts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=jmGGu8Hs; arc=fail smtp.client-ip=40.107.117.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yXkeVEKLYjgnsFsKOMXKM+KXURBxXGP1QDlqyYHfJt+EJrNf9Qmg8XYkmaVcGRKMg2fISLUG1l5/TS0ARm3QeMoatQYymAb675kEhyXB2MFHhNk9jjLGgBilNTQxOlzXMVyvNLah923XkETACsC/dP+dPwEq+Ii+s7PZTZpSEzqk1gaUBHnMQxdPMuoFKWZJ+iYxGZJ6cfEu7TzZYGjGbemM88o1anq82RaRHm+Cr4y+LFO7+kWmrzQ3Evs8jMw2Oe5zioimtJap2mG2qzL/hcedbAEVv8NUHGf1jv/AP07IcBjBveOJucmOBXbnR7SLS5+7a/ViwEQZRFPI6kFAgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vTpMcvdP2b+Pccco+XxGzl6Nj4jNqOyHS/9WklWxxtI=;
 b=y/mUE7VwpcnVRd9+fcN1fH8nS1JH9fBfN/hb7WKsV6pk9NqaYUpmTV+JPi2QZpxjAD6/yJi3siK3UfELqhasGsgf8M+v2Qe/VM8dVLfbRXx67LRFkxIsUCNNQeb+R21MUBkhk4iBvrOzK7U+mUnaadAhIdE+nL/3zrWtJUMW4FXxNIrLWBa2zorjL+hoUWClQFmO79Hn528mBZhhfKcTdZg0KoIqwsqh89+8Fr786Itx9tzIongqCT0uC4TdtNkYrwOVFw4YY5qJ7Bum+Na4IZg/92gtOMdl0YxZRHoXqwMdZeu4hMHEVVG7mqPhznkV4wlvjEwtdPflruU70VYInw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTpMcvdP2b+Pccco+XxGzl6Nj4jNqOyHS/9WklWxxtI=;
 b=jmGGu8HsyuwUvoeuYM42XiebnrTmIAPsC2b5UMxnyjzWw5+B2yv8K9zRPdOB0VljaROm5odtAwhv+TurTyUhyAlypgc6p+VFFDO7GgNy6izuj8Rt+aqYhf/Cp/iDT7+6JH1ea0deNqBxRiVx18ix7z7KKO6cKpxe0fkxSU8ZCKQg4GLXpx4h0inymPsK5RpplGGy9MMUECD37gYv0QI0AoEuV/uVxp47qldui+kRrIPiNEwVZLFpRvF3IO18gZlcjVub9KkitiprY0ASEELgo3zwmZsloiA++EJuJUOtnEJPVpKV5aHlwiIKULck5k/Y8OGUcg+RINc8i2/t0wdC6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by TY0PR03MB6680.apcprd03.prod.outlook.com (2603:1096:400:215::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 01:57:29 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123%5]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 01:57:29 +0000
Message-ID: <479d755f-1627-4441-a0a1-84460fe50675@amlogic.com>
Date: Mon, 24 Feb 2025 09:57:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: interrupt-controller: Add support for
 Amlogic A4 and A5 SoCs
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org
References: <20250219-irqchip-gpio-a4-a5-v1-0-3c8e44ae42df@amlogic.com>
 <20250219-irqchip-gpio-a4-a5-v1-1-3c8e44ae42df@amlogic.com>
 <20250221210801.GA81340-robh@kernel.org>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <20250221210801.GA81340-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0114.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::18) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|TY0PR03MB6680:EE_
X-MS-Office365-Filtering-Correlation-Id: af79b93d-344c-4732-1a76-08dd5476981b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UmM1WUE0TnRCUUFqR3I1UnY5MVNxdWJlUFdGSzZML1dnZlFCVjVnUmZ4L1Bz?=
 =?utf-8?B?cG04NWJZSXdTdmpuMFFybUFXRW9oZDlpUHBRVTRjSEh3UDR3U3luM2swWXEr?=
 =?utf-8?B?VGpxdTQvZGtkSkdxdVNvaVdvU3BKeGEzTEZNaU5Rc2RXNWhOUDMyZS85S2pO?=
 =?utf-8?B?V1lQcFYwZ2hIMEJwNlc1VE1ZZHVWd0JqbTNkK3VLNWxYakpEL005ZjZCV0Fx?=
 =?utf-8?B?WkQvend0NklKOU8rRzFidG5Jcjl3UTY3Vit2WldoVytuQWNzVGRzZXkyME10?=
 =?utf-8?B?YUNpYjVKd2l2RWhFK2s4VHhQZFhFYmkxZmtIb3kwdTE5NDFvUVBWZmlwSkd3?=
 =?utf-8?B?RkFnR2FkbXB4Ylp2TzJuWElDYnlrNFNQVDJmUTUxckc0QkVVcVVFbUUwYVJ5?=
 =?utf-8?B?bWVMaXFtWVUyYWpRNVFYM1ViUWRzajlqdGJ2alNrdFZCT2lseTlpaTMvM3Vx?=
 =?utf-8?B?bmpVSlZnRjFOREtCT3ZhWGZCcU91dXlKRnFocWZ0anRSdkhGM1FrZVFzMGNn?=
 =?utf-8?B?NS9nM0FHanRVMkNzKzF2bmx4YjgzUE9uR3hjSFBiVEJIY2VZNE0xOUltdzln?=
 =?utf-8?B?SWhpWXY1NFh5Y1lDbjVKUHJMVkZLRk1IMHlMdWpUKytzSG5zanV4VHFpYXI5?=
 =?utf-8?B?TXVqdmFmLzFhY1VnTnNXekFIZDNQZFZsOWFBZG5KRTk1RHQzeWxvMTZleVdx?=
 =?utf-8?B?Q1B4Vmk2OFNYa3lyM1JWM3RuV2dsKzd0cjVVaEx1MHp0T2kzWHdPeTZkTkd3?=
 =?utf-8?B?QW85b2doVURRSWs1OHJSWFhIckVMLzM5QkVpbVZJMEJVN0ZvV2lMeE10eStO?=
 =?utf-8?B?eCtjN0J1bHJEeU9jZS8yS3M1aUdJTTY5N2pkRzAvZys4RVRLY3paQUtVbjA3?=
 =?utf-8?B?WlNoVzhkRm8zT2ZETTk0K25xM1ZhOTMzM1RSY1BIQkdvUE1FZVRINWNEYi9T?=
 =?utf-8?B?eTVXUUtENFFsZEFwQzJhRmZUc0JVOU5nV3BkRW1XWUVaNWdzdUt0MDdrUEc5?=
 =?utf-8?B?NWE4S3J2dEJJdUEwd0luWlJTeU1NYmcrNjJaR2xNczY5MGpuZUpmT3NRaWNs?=
 =?utf-8?B?RC9tL1plaFJ6OTRyWjkveFEzUlZKMWFJY0loSWlzemtDTjRtdHgydzRWWHNn?=
 =?utf-8?B?QUFmWGFIallsb0RBbjNnY09JVjVWT21EME00akt2MFR6T0U4T1dKQ3pPT01s?=
 =?utf-8?B?OTVFaHFiaXpyS2lBOWx6REhIZUFtZUtSalp0SHhpdE0vMWxTS0JVVEV4YUFi?=
 =?utf-8?B?MWxmM3lQZmdIV1Z3ODhkSENGR0h6dEQrcDQvQVp2UkhnNStiYXJJNlhDeGZi?=
 =?utf-8?B?RytMcnQ1T0JyQ0xUeFRaaWhSODJPN0lJR1ZkRnMzNStNbmd2YytxNzQ1b00r?=
 =?utf-8?B?L2d6WU1pVmZrR2UxZTFpbzgwVHoyVk5HR0pybVhEZnpNRmE5ekFDRnhOVUQ0?=
 =?utf-8?B?bElIUWR1eW9UanlRbTk5S29oS25Jc01LZ0tOYm0wZ2ZEejAyTWx3bTd1Z24x?=
 =?utf-8?B?c0tLajJicEVRcnRnbFpxeUh2NjhvTUIzbzZNM3B0UzVYYUJhd2JBcWVUVDNU?=
 =?utf-8?B?NDAwaW5hYWdRN3BlM09QSGg3L01RZmZFY0V3K2Fpc1VEdThzRTdrRzkvdGRk?=
 =?utf-8?B?d1liZGpCQWpvbnZpQ2lFNTlKdXR3UjZ1bXo5dnBVZklEVnc4SEtseE4vNVR5?=
 =?utf-8?B?eE0wRFAvZnRqNWVUbkljTVZ2UWRKZlZoZy9aMVUrb0VzKzdPanIvczM4dVVT?=
 =?utf-8?B?ZEliaGFiczZFRUo0bjFQV3oxSExnWFB6cDh6N3M1dWJXc080cFUrYXN1dUVH?=
 =?utf-8?B?cWVYLzVpZjJBRnNmRGhlU3FWVjNYWWZxNE16TThrVGRZNzk2a2FCclM0Uk9J?=
 =?utf-8?Q?Avr1rMUGNhrMD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2JObFBRR1ZOOUtiZER2bzdVM2xYL05sQjZ6MTdXZDdxNDdZRHpaN1F0YmhV?=
 =?utf-8?B?eE5UMlpvc0ZCN3ZHSkpkc3p4cjZKcUF4VXpRZkNtemMvSnpqenZmdUdCTzNz?=
 =?utf-8?B?bkRpRmc3VExDMjN0eFIzZjlKMmRDMzRJaDh1dkRxVHNLbVJ0a09kTWFEK0l2?=
 =?utf-8?B?WFpIY3FKQ2EzbnFCZDhBcnlVOGE2bEFXTUF1RXFpMGRCZHpMYTIwMVE0bHZw?=
 =?utf-8?B?bzhhQ3NyS3RTelN4MnNWZ0hOeWtFME9jVEVrbW5PMGlRMU5KMDhtMTFOVHk4?=
 =?utf-8?B?YTg2bEMwN0t4NDlka09tVXJRSms3Q2dzMHZIWWpnWWRXL0FNVWRWYXV4MVAy?=
 =?utf-8?B?UEN4YzdpeG5jTk5iRy9mNkFVNUYra3pycHpudmM3dTlkWlRmYVMycFJoVDFS?=
 =?utf-8?B?amFldkp1ajZPN2tnTlM4MEo0V2tmeEZrUGVyOXFHVDQySEFKMzF1bWhOUFpq?=
 =?utf-8?B?R1ZTaUtVVmdOYStIRnRsS1hhSzUrUXA2VXZ5R1pkQ1Fta2NZb3hXa0xSSjk3?=
 =?utf-8?B?V3NFbTlVb1ZMR3ZzanZWQTczbGttWWFVd1hTRkoyVXY5bE4zbjNPUnlWNEtq?=
 =?utf-8?B?MnN1dDlXTGQ4NmM5TUdrYVdsVG56dU5QR3NDWXFzVkFocEVkeG1mc2p2RHBz?=
 =?utf-8?B?K1JXWFNVOS9laHpHRlhCS1VKcGc4ejd3M0FWWmdJcTJWTFozbEZZd3hNdWVJ?=
 =?utf-8?B?WFlHb0xQbEFFUEN4RXJSNU4vQTZ2UDVOV2tuaSsreUkyNFVCT2FtWWtiOXdI?=
 =?utf-8?B?by9GTzVjN2p3VzRwVURJaUp6R2wwZTRlTGE3N1E5OWF0STFPd1Q0YldweEIy?=
 =?utf-8?B?WkoyM29LZzhZNis2VU5Rb3dVV2xwUE82ZUFhd2xtUlRHdm1LRHQ4M3NTelQ3?=
 =?utf-8?B?SFRXejNEZkt1ZThOTWg4Q3RuMDc1UnZTVHF5YS8zMTRZMjdMRzBBclNuYklm?=
 =?utf-8?B?SG03YkhQNXlhWFhzOEFWeHFsdkpwTjBsNGk2NTk1NlRPMitKZG5NOVRnR2tq?=
 =?utf-8?B?bU5MaXNIRUtBZVF0MmRZY0ZtVnFxZHNNc043Rm83anVVM2UzblVpaStKdFRu?=
 =?utf-8?B?d2hKdGJIZWQyZmVxWnBHUm5TSXhaNzMzaXR5ZGlVbDRwdi9DUHpoOTlFS1d2?=
 =?utf-8?B?S25LREJhWnJpL0RpTUFHNlAvaUxuRWhSU2FBOW13QkhKZXRzK1UrVnVnbTBC?=
 =?utf-8?B?VHR1WmxiaitpSk9wL0JVUVJUc2VTQ2VKbCtiYVVsc3F3Znk5dUF5WXMwblVJ?=
 =?utf-8?B?MWRUZkxHbEc3NVhZUXYwWnlJRkg1L2hGdjN2bFRwcytienQxUnAxTHdWTlFE?=
 =?utf-8?B?Uk5CUG9selpoMzFKdmZQWEhoQ1B5TGJxSHQ3RW02dDZLZ3ZhWHkyU2hiWE5V?=
 =?utf-8?B?d0d5UktKRSt3MVBYVmhKSWtJdUNuYmdJUnMweHZ0bHhOVUpIbjRWVDNVUlpX?=
 =?utf-8?B?UHFyQjNad29ueElBaGczNjYyNE4rSEFHVGpDRXpNYkordFlsVDNXT2dSVXkz?=
 =?utf-8?B?S1VCUkhJUnhHQW9DVDdmVjJIaEtaWlQwMTNtV25LWFliRjI3dHV4UGJDaU1Z?=
 =?utf-8?B?UXpZQ25TaWJ0a2MzOHlwVEhKYWppb285Uk9SL3d1aU1GRU4wYnF3THhmYTFq?=
 =?utf-8?B?aFFPRnBWTlJpRFQ1dTNLWE5KUXd2RVpBR2V4SlV5R0ZGcEV2T1M2SzY1K2o2?=
 =?utf-8?B?Q2s3azhZVjhZdUhqbzFiVFhnVFlvd2EzdXpJWUNyeUVMMjQzT2phQitTdEdJ?=
 =?utf-8?B?VElnQzBPUlBGa20weFhlU2VTS3RnQUtXaXZXdlFYWTRwVkFDWUdzVko1S3pa?=
 =?utf-8?B?OXZYajMvWmx6WlVRMzBtNHI2UmpucmpPYURjU29LUzROZldlUXlHaEpBOVFl?=
 =?utf-8?B?Q2dMZnQzWnBOSHpiVmtaVEVtTitNN3NMWmpiL2JTQXlvcXFrQU82YVo4eTlp?=
 =?utf-8?B?ZU1wak1kNjVmL3hWS1UrbVJWaWRmNlNSN0VZMFpIbEZEemo3RTkxblNHaHl5?=
 =?utf-8?B?TitRTVYwSDc4a05Dd2tKMUg5QVNFM1FJc0J1WTFSMUhkNSs5d0ZZU0txSjZN?=
 =?utf-8?B?QVhWcWhiQkRBdmFuNlI0cTF4UE1LZUEyL2Vuc1NnNzJMNlhadWRieEpiZDZn?=
 =?utf-8?B?ajRITzY3Nk11a2VtYkcvTEk4WGNLYkt5OG44QmhJNnBnK0x5c2FFZ3NvTEN4?=
 =?utf-8?B?T0E9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af79b93d-344c-4732-1a76-08dd5476981b
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 01:57:29.3307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: asT2uPZD5scvpbNZWMsZQANXvnaYOu2IMHSxYzREe+o9/PoCPlBP/zDQg9/42fgvNQxwv4BfK4ZiKXJASNtDxdneJKLlnWqFe45BVLToFhk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6680

Hi Rob,
    Thanks for your advice.

On 2025/2/22 05:08, Rob Herring wrote:
> [ EXTERNAL EMAIL ]
> 
> On Wed, Feb 19, 2025 at 03:29:03PM +0800, Xianwei Zhao wrote:
>> Update dt-binding document for GPIO interrupt controller
>> of Amlogic A4 and A5 SoCs
>>
>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>> ---
>>   .../bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml       | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml
>> index a93744763787..03548ee695bd 100644
>> --- a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml
>> +++ b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml
>> @@ -35,6 +35,9 @@ properties:
>>                 - amlogic,meson-sm1-gpio-intc
>>                 - amlogic,meson-a1-gpio-intc
>>                 - amlogic,meson-s4-gpio-intc
>> +              - amlogic,a4-gpio-intc
>> +              - amlogic,a4-gpio-ao-intc
>> +              - amlogic,a5-gpio-intc
>>                 - amlogic,c3-gpio-intc
>>                 - amlogic,t7-gpio-intc
>>             - const: amlogic,meson-gpio-intc
>> @@ -49,7 +52,7 @@ properties:
>>
>>     amlogic,channel-interrupts:
>>       description: Array with the upstream hwirq numbers
>> -    minItems: 8
>> +    minItems: 2
> 
> There should be an if/then schema that retains 8 as the minimum for the
> existing cases.
> 
Will do.

>>       maxItems: 12
>>       $ref: /schemas/types.yaml#/definitions/uint32-array
>>
>>
>> --
>> 2.37.1
>>

