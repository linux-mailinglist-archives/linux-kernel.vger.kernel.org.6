Return-Path: <linux-kernel+bounces-276459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C7C949410
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 116852823FF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA31F1D6DDB;
	Tue,  6 Aug 2024 15:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="V4x/A3es"
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020111.outbound.protection.outlook.com [52.101.56.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8111218D653
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 15:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722956552; cv=fail; b=amuatD/mNF1wNVj77IAarLo5VAv4Ft12/8R+F50jCOmAkiaxvdu4GIbS73BtKvRx/KastK8Plu8ZjigWrCIM837LwhWOludQKWvImDkvTlnHV1gKJePy15ge2wyQvyHP+pjBZyVsC8Fudc0LZb0VcmdzA8AfeLBiezubNcfdQ3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722956552; c=relaxed/simple;
	bh=gTDEd4GAiYxh3z0XX1AVvQ9Q/ReHXVmvzfo/SpPXf20=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QW+4e8TzVbRQS6ZvJYz5vQcTvI1RWX7I0hR/hodyOx/Yg7SF3YBmuyDB0mgSeRrYcAb7XQ7DBM7iSRtrh9g8aD4p6Oug5MBe9MKWPj8wH1dEKPEuHEenkaFx2UyYVaXkqxYUm4VoN/Y6UJTTF+jHLU2x1UhPVpNmfdy6ExRDPMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=V4x/A3es; arc=fail smtp.client-ip=52.101.56.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r2WPZsaHmneiIAGUWRSJdrT5e0AybNHHobghFCyYNQ7ttb71n3gAUxCi6vEd3HkXU4PiOdfJya489+wEJYqBl2w/jIcyWqikfaDBlpt5isuRQZOfH82ERI3Ame+3xoYP/wDxPD095Gf84wG8hG8zZRQURRn5i82m/e144X5L5E1bnzYee1Puqi5xuqziUSQxRPf1uGLfuYsbPMXlUTVU2GwhqA3aP089SWEyLSupFmAgKhOslJZDU/CUEcgzsClzKIhsRKdpTPqw3jWYaK+8enxgGENoQqh7u0etGGHEvTbz2xqOSA7WqIvRxA7mNhbh27lLhNr/Sfr9JpvETC4EPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PVGaf+mmE3Zigbc72m5AKs6QEM+WHif0PXk1d27eVHw=;
 b=KSam4Lo7jgEEWX7+4bzXzxDCeAGu2K0IgNxv5guEPRyBHrBGACwRydAAvUbuZVyrDN6Zzur9FD5KgJ6CdXgNOYkZrI/l1ZxMT5YEKs46ZTY7fCgPIE/hOI3kb97uI1OlA7braZglP7QhoOhk/GC2dmtz43SPydNVxyI5m0K7hJ5D9n4kUqVxzISSOzKqATDJTuGiORiUh0wMWUJBFJY2Z0Cw6QI8gC5GupAXH8HEpb1UxtzNS0xsKuPdIofmQY/a6eS1ubbWVyWozxuO870F1at8Yhj1YguQ7hIygXBXqxa9Sq36i6u+afE27NLNUfjkm9LEYHJIYb2NmzMSS2dQlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVGaf+mmE3Zigbc72m5AKs6QEM+WHif0PXk1d27eVHw=;
 b=V4x/A3esygZVLMBjjAYmIn706mfWpxIR+5gU5TAkQ/s7hBytHFuoSqgLhqHVhKkoU2rycSgVyqO5sUfqckeXg+UcqjiHq6iiWa4wYioKqn0ScByMgxvwBaNp/dVnRoRlQRxKzkFNwe7K0mhIJw2zLT5oHDUmtLOLz8cMwXVCdog=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 MN0PR01MB7657.prod.exchangelabs.com (2603:10b6:208:378::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.26; Tue, 6 Aug 2024 15:02:21 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%5]) with mapi id 15.20.7828.021; Tue, 6 Aug 2024
 15:02:21 +0000
Message-ID: <6f535bb6-2cee-48e6-93f1-ea19887bae74@os.amperecomputing.com>
Date: Tue, 6 Aug 2024 08:02:16 -0700
User-Agent: Mozilla Thunderbird
Reply-To: scclevenger@os.amperecomputing.com
Subject: Re: [PATCH] perf scripts python arm-cs-trace-disasm.py: Skip disasm
 if address continuity is broken
To: James Clark <james.clark@linaro.org>,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
Cc: acme@redhat.com, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 darren@os.amperecomputing.com, james.clark@arm.com, suzuki.poulose@arm.com,
 Leo Yan <leo.yan@arm.com>, Al.Grant@arm.com,
 Mike Leach <mike.leach@linaro.org>
References: <20240719092619.274730-1-gankulkarni@os.amperecomputing.com>
 <7302367c-311f-4655-9a83-3c4034c50086@linaro.org>
 <6920de94-a9c8-47f4-840f-391d1ec85c0c@os.amperecomputing.com>
 <8f6f221b-4c9a-42e1-b8ce-1f492caee184@linaro.org>
 <0a697a54-5dd8-4351-a651-991724690db2@os.amperecomputing.com>
 <ce4af204-874f-404c-a7aa-42dc6693d072@linaro.org>
 <a197123a-be59-4052-9615-cac79ffa357a@os.amperecomputing.com>
 <543813f6-cb1f-4759-b26f-75246750814d@linaro.org>
 <f72038a0-c6b5-4245-8515-3b735ca38cbb@linaro.org>
 <ae1b2d8c-588a-4f0a-b3c9-c869f8dd0f25@os.amperecomputing.com>
 <00fac24c-d664-4ebb-8c60-f4697b7f76c1@linaro.org>
 <8b53a424-19f7-4042-a2db-e1c5d051f9cc@os.amperecomputing.com>
 <6adf84fa-b755-4d7a-957a-9bf01e442238@linaro.org>
 <d71dff17-6f1e-4a67-89c6-7ecc86af0f3a@linaro.org>
Content-Language: en-US
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
Organization: Ampere Computing
In-Reply-To: <d71dff17-6f1e-4a67-89c6-7ecc86af0f3a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5PR15CA0203.namprd15.prod.outlook.com
 (2603:10b6:930:82::25) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|MN0PR01MB7657:EE_
X-MS-Office365-Filtering-Correlation-Id: b1918cf8-9b4d-4a78-794f-08dcb628c59c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c2s5RkhOcSt2R1hGQ0d4T2IycmpMamxTYUJ0NVlKbFZ5OHZiM2tWQWxjZWhV?=
 =?utf-8?B?ZUNPRHVScG9GUDdaaE9EVzZxLzhySHl6dm8vN0hLQnZ5Wm1CM0lHM3FwVjN1?=
 =?utf-8?B?MDR6TFBIL1JXUWc3dCtpblhSdHRRcW5TdG40MkNSR0I1bWEyRFdUNlhtOFl6?=
 =?utf-8?B?cTRaUjRrSkVPQldsWWFURkd4WjFTRjBiSHdJK0d2VTFSZ3F2Z0l0SzZ0L2pW?=
 =?utf-8?B?eTF6cWtCZWxuclkvTXRQNDFtZFJCQTh4NklaN2o1ckFKSUEzWGl6cE8wRkRO?=
 =?utf-8?B?TzhKSzhSN3AvQXM0c3czWVY4UXVMWE9EbEJSVVBnNjhMTk5RdU5tRmRVVmti?=
 =?utf-8?B?RWRMVEJQb1ptdE8rVEtEV1F6cXhsRHhyUFFzUXJ3S0YvTXhIcE4yclB5bkpv?=
 =?utf-8?B?YXFnL1pCdFJsVnJSTVRYMG1QMFBxN1RyM0hWYlhDQzQ1RVFEUUJaMER0MWNj?=
 =?utf-8?B?ZHhMblVLRDQ5WThXZi9uRFV2R1FqRElGSGQyNHJXMlgzNWh6clo4VTRDdnRF?=
 =?utf-8?B?VDBkbERvUjRDdHBJQi9Ec2cvR3BSY2Nma0x6SzNOaFBNaU96WmhsTUJaZ3Jl?=
 =?utf-8?B?Snk3WHNDYWs5OGQ4VitzWEdCOFNyT3kzZStSLzZRQkxkWmJrR0ZWbFl1aTMx?=
 =?utf-8?B?T2drM1czUTFSQWNNeVJvdkFyd1l5RG8rK2FzZXhqOWZhdi9pSVlxZFhXZjI2?=
 =?utf-8?B?TlpZVStralEzcElWdThFNTBYd3pRWmtrMnVMNEh5N1RMcU1GcE92K2RHcEFr?=
 =?utf-8?B?amVBd2pES2Q4S0hyUW1VMTNZZlYzYnNLbWpYVXladjdLSmxtdzZGUHppVmVF?=
 =?utf-8?B?WGRtRnl5cnlhQ25LbjJRSkkzampIWGpyK25Yb1VJeEJ4QnVRY240cjUzL2Fx?=
 =?utf-8?B?bVllajF1UXVBc3psTEkrbWdmSzVzeDNGNWllczZDc2d2ZlBBMyt1VVgrS1BB?=
 =?utf-8?B?S1J0UXFuTHlUVkhMVkgzeXRuQzFGanVheUp5bk55c3YyWjZNUmRyQVNCeE83?=
 =?utf-8?B?ejhvRHE3UFdEd3g0K3c3UmJLQVpKWVhWTHNHWEFJaEtNYXFaeEFPQUVKbVRF?=
 =?utf-8?B?VHM0dWpmYjdlUlhScTBGMDdKR0Z0eG15VTkzUW0xSDBtaDZ1VG5IUExNRjRn?=
 =?utf-8?B?NkFNdFJDZjRzM3ZzL1loVzF1d2ZtR3ppRlB1SGhTNXdLenN4aitYNC9seWo0?=
 =?utf-8?B?OGpOU2E0N3dLa2JORWNrNUs4T1R5bXdVSytWYmI4TldXRXdpbHc4MFBLYzZV?=
 =?utf-8?B?dDNKMjNRQmdMclMvYW15SHBpOHdJR0RSVDZoSkU3WFo3STRZbzJhdjRIdExt?=
 =?utf-8?B?VGMxb252aGs5SC9HYjVQSVpOMUlHYmpDWEN1ZkJIQ2tKaG1sTTBLdjkvN3g3?=
 =?utf-8?B?dHQxbnl3YmEzU3ZrYkgxazJUQ21neURwM0VWLzEwZVlYS1ZsMFcwd1lXT3Ba?=
 =?utf-8?B?NmZZYUVTeEY1QU5aT09vVnpYWCtOWWEwOU84NzlxelZKNmRuWVJLZkFPeGN2?=
 =?utf-8?B?RWRENTFqTnU0Wk5wRVF5T0NqVE1PNFkwalpubTJEdnBRRndWTjc3d1ZJdFFT?=
 =?utf-8?B?bDNvV3VZNFZFdGZRc2RRdDZsYTlPUDFtR2RUOHQ4ZHVUSk1WR1h0Ymp1bFZX?=
 =?utf-8?B?dnRvbm41VG1OR29WMjV5NmR0TjdIU1JqU2VqWExRQk5GMkYwdk9UL2FaZTc5?=
 =?utf-8?B?WEhneGN2YlpaM0xGR2VLSXZLUHhyN0tPbFJFN2dnNGNwZjAvSksxTFliSWky?=
 =?utf-8?Q?oZQpxXeb8TqOREuAZI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0I0UHBmd0ZrYk9DN1FRLzZYRFRrZHBPcVlBa2haS2Jrb3VvVmgvMzhJbmFE?=
 =?utf-8?B?NjRadWR6RTNjbmlhcFdIMnhZWTlrZlhSeU1pT2dGZWpqdm1lcW1EcTE0SUN0?=
 =?utf-8?B?ZWF4UHlzRkh4OGF6cXRvMVN5c1ltODYxdDZRSU8raWRBeE5LSUUzb24vVThu?=
 =?utf-8?B?OTJwRzlyK2tEZDExRE9HdlJobjBidmZiUnY3Z011Rk1kSjk1QW9NT2s0dmx6?=
 =?utf-8?B?SGtaOXBVZjRHbnptRU1MM1NrUEpRMk01ejNDSi9JS3JaNmdVMzlSeVowRlZs?=
 =?utf-8?B?ZWVwdjU5MkczRE0vUHZQb0hvVGFDRkpiUExGVkFoRW9VTEUvSEp2QmZURUtZ?=
 =?utf-8?B?OWdJaUI3aUFpb2VuVjRsY3NQQS90Vy8vamlkeFYvQ2VwMWdMK014MFlQcEdn?=
 =?utf-8?B?QmNFZkwzZ1oremc1TGowcWJhRllRbXA4YXB4ZlhWMHRyYjBpU2xsWkZpZlVw?=
 =?utf-8?B?UWlVNUo2Wm1QYXBmd2J2NXFaeE8ydHR6V0RoRmRLTXAyb1IvV1RLY3BPL3l6?=
 =?utf-8?B?bEJtYVRYV1VpQzVXc0NDdTZhZU9sYUI1cVpzbmQ3NlFHaG1LK0RJMmRpNWNF?=
 =?utf-8?B?QzBvZkNUWEtYTnkrc0cxZzdOaHVQQThFMkJQS2Q1b0NRcS90VWFTYlpCeXVy?=
 =?utf-8?B?OFZ5T2QvWk9ibmZHRU1HbHN5RDAyTTNSdXJpWG9LQ3N3TmR1QzlOVnVvQjFk?=
 =?utf-8?B?alFDV1JwWWtaUk1XWU5CL2JiejVUZllvdkxxNnJvZmE4azA3QWE3MGhWNVYr?=
 =?utf-8?B?YjBWVHRGckQ2dkkxVHdYcWJKbjlHTXZiNEh5amUrSHNmeGthVmwrRWVBVnI2?=
 =?utf-8?B?cWh2OEdORUJXQjh2MlZCaGxzZDdhcGVzdm5Vd1ZiU3UydFlGbzBpS2t6Rm5G?=
 =?utf-8?B?T0NvbXRNWVZuZytkcmt3dmhKbUhoMXZXMC9jUG95YTBNdWtmZFZOdjZkU2dI?=
 =?utf-8?B?TnVsRTcvcEhrTm1PVVludmRZdW8zbVhQbTBEUDNOelZ3UThaWTExY1dSVCtj?=
 =?utf-8?B?MjRtR1B2RFBRYytLeHh6eTEwWU4rQ3U0UmlzNVlaVkVVbWFRRXd1OWhIYlRv?=
 =?utf-8?B?Q2pBKzEvSmVJaGIzL2FaTlQrZ2tuT1VuZForUFN1R3d3bkdtcDNGdFlFdm9K?=
 =?utf-8?B?My9yTVpvMmJ4bVBvdW9oZ05FTU93anhIR2hOOERFTEhTZlBURldkelNtQzc0?=
 =?utf-8?B?aHBmT0xsc0F2KzR6SDg4T3BlWnFNOG1OdnI0OGVvV3ArdzZqYnRLTXQ4QWtY?=
 =?utf-8?B?b0NDYlZpT1p3MW5Wd003bEtrWWtFcXRzZWJyTlV4Q2VZTkszeFdmRlRVWnhC?=
 =?utf-8?B?MkRjSVVMelhCU1ROMHpNOW5Sdk5Zb1cxR3hFTi9vNTFKcmExekxsRzBWVkZI?=
 =?utf-8?B?bmo5MFhwRGlKaHlmL3VrKzE1aUxxc1VLRlQ4MnNNTmtEK25jZTkxZVlMdC9V?=
 =?utf-8?B?RWlnS2pQN0kzaitINXVxa0dDaWpYaFNPUlM0WFZKVGM1OWlsUjhaRXFqMmpF?=
 =?utf-8?B?RlRmcm9QdTV2QVFWMVA2S2RlVGZDeEUyTFVvMXdUVTkxMzhTZ04yVEpBZzJp?=
 =?utf-8?B?ZzMyeW1xdy9Cc0dObXd1YXM5V2xSM3JrSElKUmpaL2VhbTNkMDY1TldId2cw?=
 =?utf-8?B?UnFkQkI2d0lHMXpHaktaN0ZhbmRLeGt3aUpFQ2VBM2gxK2ZMeHB4cHF6R0xF?=
 =?utf-8?B?R2lMc1FaQ3NUcXA5aE02OXFEZ3JYWFNYVi80eUZHN0VsZlpjakJ1ZnBQT1pI?=
 =?utf-8?B?d3RnSGJKR1IrUTdyTlpDa0xxZ0RHNkFmOWp2OGpBWDZvUXp3RmRQZ0FSQmFW?=
 =?utf-8?B?VEtXOWoyMW9mNWR1a3NaZ3JmSFdLQjZYZExiTUtSdXVwSmlWSm94dDRCTXdW?=
 =?utf-8?B?RVBlcWdvVHB5ZVB1YXlmc0l4TjZaV3R1V29WbENaR200UjUrRnQvQlpta2o3?=
 =?utf-8?B?RnZIRWtoUXFIVjB3VThGRGFnSEw0NnpYWDNKNUVJRlMwekVBR2d5YXFURmJL?=
 =?utf-8?B?QXdTT205VGgvN2o5YnkyeTVhdGJpM2E0SmROWnM5RWRPK1E2WnJudDIrUDN3?=
 =?utf-8?B?eHE5ZVpNTUFSVGVDOEdSQzMwU1hBb3pkWFJiQ20yTUEzQitoeFNwdHNIb2FC?=
 =?utf-8?B?Y3dNTHRXVzJNb2F2STRNYVd2cFUzS2U4Z3dlbFdYQlJLUm8yRm0xeHl1U2Qx?=
 =?utf-8?Q?HL5S7KVgy8WO4u+PsugHkGU=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1918cf8-9b4d-4a78-794f-08dcb628c59c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 15:02:21.1673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cv8indrvZpVIEhshr1HDxG72B0WkYQ+9QaHAKAPTW+s+Flo9DBvWsNkGMo0B1d2gbH2gG6eHWen78SmlIVL8aCgsVwCI/8MlBI7OaOLiun6WeNvZnmMYxY2CbHwXnsQ6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR01MB7657



On 8/6/2024 2:57 AM, James Clark wrote:
> 
> 
> On 06/08/2024 10:47 am, James Clark wrote:
>>
>>
>> On 06/08/2024 8:02 am, Ganapatrao Kulkarni wrote:
>>>
>>>
>>> On 05-08-2024 07:29 pm, James Clark wrote:
>>>>
>>>>
>>>> On 05/08/2024 1:22 pm, Ganapatrao Kulkarni wrote:
>>>>>
>>>>>
>>>>> On 01-08-2024 03:30 pm, James Clark wrote:
>>>>>>
>>>>>>
>>>>>> On 24/07/2024 3:45 pm, James Clark wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 24/07/2024 7:38 am, Ganapatrao Kulkarni wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 23-07-2024 09:16 pm, James Clark wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 23/07/2024 4:26 pm, Ganapatrao Kulkarni wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 23-07-2024 06:40 pm, James Clark wrote:
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> On 22/07/2024 11:02 am, Ganapatrao Kulkarni wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> Hi James,
>>>>>>>>>>>>
>>>>>>>>>>>> On 19-07-2024 08:09 pm, James Clark wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> On 19/07/2024 10:26 am, Ganapatrao Kulkarni wrote:
>>>>>>>>>>>>>> To generate the instruction tracing, script uses 2
>>>>>>>>>>>>>> contiguous packets
>>>>>>>>>>>>>> address range. If there a continuity brake due to
>>>>>>>>>>>>>> discontiguous branch
>>>>>>>>>>>>>> address, it is required to reset the tracing and start
>>>>>>>>>>>>>> tracing with the
>>>>>>>>>>>>>> new set of contiguous packets.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Adding change to identify the break and complete the
>>>>>>>>>>>>>> remaining tracing
>>>>>>>>>>>>>> of current packets and restart tracing from new set of
>>>>>>>>>>>>>> packets, if
>>>>>>>>>>>>>> continuity is established.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> Hi Ganapatrao,
>>>>>>>>>>>>>
>>>>>>>>>>>>> Can you add a before and after example of what's changed to
>>>>>>>>>>>>> the commit message? It wasn't immediately obvious to me if
>>>>>>>>>>>>> this is adding missing output, or it was correcting the
>>>>>>>>>>>>> tail end of the output that was previously wrong.
>>>>>>>>>>>>
>>>>>>>>>>>> It is adding tail end of the trace as well avoiding the
>>>>>>>>>>>> segfault of the perf application. With out this change the
>>>>>>>>>>>> perf segfaults with as below log
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> ./perf script
>>>>>>>>>>>> --script=python:./scripts/python/arm-cs-trace-disasm.py --
>>>>>>>>>>>> -d objdump -k ../../vmlinux -v $* > dump
>>>>>>>>>>>> objdump: error: the stop address should be after the start
>>>>>>>>>>>> address
>>>>>>>>>>>> Traceback (most recent call last):
>>>>>>>>>>>>    File "./scripts/python/arm-cs-trace-disasm.py", line 271,
>>>>>>>>>>>> in process_event
>>>>>>>>>>>>      print_disam(dso_fname, dso_vm_start, start_addr,
>>>>>>>>>>>> stop_addr)
>>>>>>>>>>>>    File "./scripts/python/arm-cs-trace-disasm.py", line 105,
>>>>>>>>>>>> in print_disam
>>>>>>>>>>>>      for line in read_disam(dso_fname, dso_start,
>>>>>>>>>>>> start_addr, stop_addr):
>>>>>>>>>>>> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>>>>>>>>>    File "./scripts/python/arm-cs-trace-disasm.py", line 99,
>>>>>>>>>>>> in read_disam
>>>>>>>>>>>>      disasm_output =
>>>>>>>>>>>> check_output(disasm).decode('utf-8').split('\n')
>>>>>>>>>>>>                      ^^^^^^^^^^^^^^^^^^^^
>>>>>>>>>>>>    File "/usr/lib64/python3.12/subprocess.py", line 466, in
>>>>>>>>>>>> check_output
>>>>>>>>>>>>      return run(*popenargs, stdout=PIPE, timeout=timeout,
>>>>>>>>>>>> check=True,
>>>>>>>>>>>> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>>>>>>>>>    File "/usr/lib64/python3.12/subprocess.py", line 571, in run
>>>>>>>>>>>>      raise CalledProcessError(retcode, process.args,
>>>>>>>>>>>> subprocess.CalledProcessError: Command '['objdump', '-d',
>>>>>>>>>>>> '-z', '--start-address=0xffff80008125b758',
>>>>>>>>>>>> '--stop-address=0xffff80008125a934', '../../vmlinux']'
>>>>>>>>>>>> returned non-zero exit status 1.
>>>>>>>>>>>> Fatal Python error: handler_call_die: problem in Python
>>>>>>>>>>>> trace event handler
>>>>>>>>>>>> Python runtime state: initialized
>>>>>>>>>>>>
>>>>>>>>>>>> Current thread 0x0000ffffb05054e0 (most recent call first):
>>>>>>>>>>>>    <no Python frame>
>>>>>>>>>>>>
>>>>>>>>>>>> Extension modules: perf_trace_context, systemd._journal,
>>>>>>>>>>>> systemd._reader, systemd.id128, report._py3report,
>>>>>>>>>>>> _dbus_bindings, problem._py3abrt (total: 7)
>>>>>>>>>>>> Aborted (core dumped)
>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>>> Signed-off-by: Ganapatrao Kulkarni
>>>>>>>>>>>>>> <gankulkarni@os.amperecomputing.com>
>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>>   tools/perf/scripts/python/arm-cs-trace-disasm.py | 10
>>>>>>>>>>>>>> ++++++++++
>>>>>>>>>>>>>>   1 file changed, 10 insertions(+)
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> diff --git
>>>>>>>>>>>>>> a/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>>>>>>>>>>> b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>>>>>>>>>>> index d973c2baed1c..ad10cee2c35e 100755
>>>>>>>>>>>>>> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>>>>>>>>>>> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>>>>>>>>>>> @@ -198,6 +198,10 @@ def process_event(param_dict):
>>>>>>>>>>>>>>           cpu_data[str(cpu) + 'addr'] = addr
>>>>>>>>>>>>>>           return
>>>>>>>>>>>>>> +    if (cpu_data.get(str(cpu) + 'ip') == None):
>>>>>>>>>>>>>> +        cpu_data[str(cpu) + 'ip'] = ip
>>>>>>>>>>>>>> +
>>>>>>>>>>>>>
>>>>>>>>>>>>> Do you need to write into the global cpu_data here? Doesn't
>>>>>>>>>>>>> it get overwritten after you load it back into 'prev_ip'
>>>>>>>>>>>>
>>>>>>>>>>>> No, the logic is same as holding the addr of previous packet.
>>>>>>>>>>>> Saving the previous packet saved ip in to prev_ip before
>>>>>>>>>>>> overwriting with the current packet.
>>>>>>>>>>>
>>>>>>>>>>> It's not exactly the same logic as holding the addr of the
>>>>>>>>>>> previous sample. For addr, we return on the first None, with
>>>>>>>>>>> your change we now "pretend" that the second one is also the
>>>>>>>>>>> previous one:
>>>>>>>>>>>
>>>>>>>>>>>    if (cpu_data.get(str(cpu) + 'addr') == None):
>>>>>>>>>>>      cpu_data[str(cpu) + 'addr'] = addr
>>>>>>>>>>>      return  <----------------------------sample 0 return
>>>>>>>>>>>
>>>>>>>>>>>    if (cpu_data.get(str(cpu) + 'ip') == None):
>>>>>>>>>>>        cpu_data[str(cpu) + 'ip'] = ip <---- sample 1 save but
>>>>>>>>>>> no return
>>>>>>>>>>>
>>>>>>>>>>> Then for sample 1 'prev_ip' is actually now the 'current' IP:
>>>>>>>>>>
>>>>>>>>>> Yes, it is dummy for first packet. Added anticipating that we
>>>>>>>>>> wont hit the discontinuity for the first packet itself.
>>>>>>>>>>
>>>>>>>>>> Can this be changed to more intuitive like below?
>>>>>>>>>>
>>>>>>>>>> diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>>>>>>> b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>>>>>>> index d973c2baed1c..d49f5090059f 100755
>>>>>>>>>> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>>>>>>> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>>>>>>> @@ -198,6 +198,8 @@ def process_event(param_dict):
>>>>>>>>>>                  cpu_data[str(cpu) + 'addr'] = addr
>>>>>>>>>>                  return
>>>>>>>>>>
>>>>>>>>>> +       if (cpu_data.get(str(cpu) + 'ip') != None):
>>>>>>>>>> +               prev_ip = cpu_data[str(cpu) + 'ip']
>>>>>>>>>>
>>>>>>>>>>          if (options.verbose == True):
>>>>>>>>>>                  print("Event type: %s" % name)
>>>>>>>>>> @@ -243,12 +245,18 @@ def process_event(param_dict):
>>>>>>>>>>
>>>>>>>>>>          # Record for previous sample packet
>>>>>>>>>>          cpu_data[str(cpu) + 'addr'] = addr
>>>>>>>>>> +       cpu_data[str(cpu) + 'ip'] = stop_addr
>>>>>>>>>>
>>>>>>>>>>          # Handle CS_ETM_TRACE_ON packet if start_addr=0 and
>>>>>>>>>> stop_addr=4
>>>>>>>>>>          if (start_addr == 0 and stop_addr == 4):
>>>>>>>>>>                  print("CPU%d: CS_ETM_TRACE_ON packet is
>>>>>>>>>> inserted" % cpu)
>>>>>>>>>>                  return
>>>>>>>>>>
>>>>>>>>>> +       if (stop_addr < start_addr and prev_ip != 0):
>>>>>>>>>> +               # Continuity of the Packets broken, set
>>>>>>>>>> start_addr to previous
>>>>>>>>>> +               # packet ip to complete the remaining tracing
>>>>>>>>>> of the address range.
>>>>>>>>>> +               start_addr = prev_ip
>>>>>>>>>> +
>>>>>>>>>>          if (start_addr < int(dso_start) or start_addr >
>>>>>>>>>> int(dso_end)):
>>>>>>>>>>                  print("Start address 0x%x is out of range [
>>>>>>>>>> 0x%x .. 0x%x ] for dso %s" % (start_addr, int(dso_start),
>>>>>>>>>> int(dso_end), dso))
>>>>>>>>>>                  return
>>>>>>>>>>
>>>>>>>>>> Without this patch below is the failure log(with segfault) for
>>>>>>>>>> reference.
>>>>>>>>>>
>>>>>>>>>> [root@sut01sys-r214 perf]# timeout 4s ./perf record -e
>>>>>>>>>> cs_etm// -C 1 dd if=/dev/zero of=/dev/null
>>>>>>>>>> [ perf record: Woken up 1 times to write data ]
>>>>>>>>>> [ perf record: Captured and wrote 1.087 MB perf.data ]
>>>>>>>>>> [root@sut01sys-r214 perf]# ./perf script
>>>>>>>>>> --script=python:./scripts/python/arm-cs-trace-disasm.py -- -d
>>>>>>>>>> objdump -k ../../vmlinux -v $* > dump
>>>>>>>>>> objdump: error: the stop address should be after the start
>>>>>>>>>> address
>>>>>>>>>> Traceback (most recent call last):
>>>>>>>>>>    File "./scripts/python/arm-cs-trace-disasm.py", line 271,
>>>>>>>>>> in process_event
>>>>>>>>>>      print_disam(dso_fname, dso_vm_start, start_addr, stop_addr)
>>>>>>>>>>    File "./scripts/python/arm-cs-trace-disasm.py", line 105,
>>>>>>>>>> in print_disam
>>>>>>>>>>      for line in read_disam(dso_fname, dso_start, start_addr,
>>>>>>>>>> stop_addr):
>>>>>>>>>> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>>>>>>>    File "./scripts/python/arm-cs-trace-disasm.py", line 99, in
>>>>>>>>>> read_disam
>>>>>>>>>>      disasm_output =
>>>>>>>>>> check_output(disasm).decode('utf-8').split('\n')
>>>>>>>>>>                      ^^^^^^^^^^^^^^^^^^^^
>>>>>>>>>>    File "/usr/lib64/python3.12/subprocess.py", line 466, in
>>>>>>>>>> check_output
>>>>>>>>>>      return run(*popenargs, stdout=PIPE, timeout=timeout,
>>>>>>>>>> check=True,
>>>>>>>>>> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>>>>>>>    File "/usr/lib64/python3.12/subprocess.py", line 571, in run
>>>>>>>>>>      raise CalledProcessError(retcode, process.args,
>>>>>>>>>> subprocess.CalledProcessError: Command '['objdump', '-d',
>>>>>>>>>> '-z', '--start-address=0xffff80008125b758',
>>>>>>>>>> '--stop-address=0xffff80008125a934', '../../vmlinux']'
>>>>>>>>>> returned non-zero exit status 1.
>>>>>>>>>> Fatal Python error: handler_call_die: problem in Python trace
>>>>>>>>>> event handler
>>>>>>>>>> Python runtime state: initialized
>>>>>>>>>>
>>>>>>>>>> Current thread 0x0000ffffb90d54e0 (most recent call first):
>>>>>>>>>>    <no Python frame>
>>>>>>>>>>
>>>>>>>>>> Extension modules: perf_trace_context, systemd._journal,
>>>>>>>>>> systemd._reader, systemd.id128, report._py3report,
>>>>>>>>>> _dbus_bindings, problem._py3abrt (total: 7)
>>>>>>>>>> Aborted (core dumped)
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> dump snippet:
>>>>>>>>>> ============
>>>>>>>>>> Event type: branches
>>>>>>>>>> Sample = { cpu: 0001 addr: 0xffff80008030cb00 phys_addr:
>>>>>>>>>> 0x0000000000000000 ip: 0xffff800080313f0c pid: 12720 tid:
>>>>>>>>>> 12720 period: 1 time: 5986372298040 }
>>>>>>>>>>          ffff800080313f04 <__perf_event_header__init_id+0x4c>:
>>>>>>>>>>          ffff800080313f04:       36100094        tbz     w20,
>>>>>>>>>> #2, ffff800080313f14 <__perf_event_header__init_id+0x5c>
>>>>>>>>>>          ffff800080313f08:       f941e6a0        ldr     x0,
>>>>>>>>>> [x21, #968]
>>>>>>>>>>          ffff800080313f0c:       d63f0000        blr     x0
>>>>>>>>>>              perf 12720/12720 [0001]      5986.372298040
>>>>>>>>>> __perf_event_header__init_id+0x54
>>>>>>>>>> .../coresight/linux/kernel/events/core.c  586         return
>>>>>>>>>> event->clock();
>>>>>>>>>> Event type: branches
>>>>>>>>>> Sample = { cpu: 0001 addr: 0xffff8000801bb4a8 phys_addr:
>>>>>>>>>> 0x0000000000000000 ip: 0xffff80008030cb0c pid: 12720 tid:
>>>>>>>>>> 12720 period: 1 time: 5986372298040 }
>>>>>>>>>>          ffff80008030cb00 <local_clock>:
>>>>>>>>>>          ffff80008030cb00:       d503233f        paciasp
>>>>>>>>>>          ffff80008030cb04:       a9bf7bfd        stp     x29,
>>>>>>>>>> x30, [sp, #-16]!
>>>>>>>>>>          ffff80008030cb08:       910003fd        mov     x29, sp
>>>>>>>>>>          ffff80008030cb0c:       97faba67        bl
>>>>>>>>>> ffff8000801bb4a8 <sched_clock>
>>>>>>>>>>              perf 12720/12720 [0001]      5986.372298040
>>>>>>>>>> local_clock+0xc ...t/linux/./include/linux/sched/clock.h   64
>>>>>>>>>> return sched_clock();
>>>>>>>>>> Event type: branches
>>>>>>>>>> Sample = { cpu: 0001 addr: 0xffff80008125a8a8 phys_addr:
>>>>>>>>>> 0x0000000000000000 ip: 0xffff8000801bb4c8 pid: 12720 tid:
>>>>>>>>>> 12720 period: 1 time: 5986372298040 }
>>>>>>>>>>          ffff8000801bb4a8 <sched_clock>:
>>>>>>>>>>          ffff8000801bb4a8:       d503233f        paciasp
>>>>>>>>>>          ffff8000801bb4ac:       a9be7bfd        stp     x29,
>>>>>>>>>> x30, [sp, #-32]!
>>>>>>>>>>          ffff8000801bb4b0:       910003fd        mov     x29, sp
>>>>>>>>>>          ffff8000801bb4b4:       a90153f3        stp     x19,
>>>>>>>>>> x20, [sp, #16]
>>>>>>>>>>          ffff8000801bb4b8:       d5384113        mrs     x19,
>>>>>>>>>> sp_el0
>>>>>>>>>>          ffff8000801bb4bc:       b9401260        ldr     w0,
>>>>>>>>>> [x19, #16]
>>>>>>>>>>          ffff8000801bb4c0:       11000400        add     w0,
>>>>>>>>>> w0, #0x1
>>>>>>>>>>          ffff8000801bb4c4:       b9001260        str     w0,
>>>>>>>>>> [x19, #16]
>>>>>>>>>>          ffff8000801bb4c8:       94427cf8        bl
>>>>>>>>>> ffff80008125a8a8 <sched_clock_noinstr>
>>>>>>>>>>              perf 12720/12720 [0001]      5986.372298040
>>>>>>>>>> sched_clock+0x20 ...sight/linux/kernel/time/sched_clock.c  105
>>>>>>>>>> ns = sched_clock_noinstr();
>>>>>>>>>> Event type: branches
>>>>>>>>>> Sample = { cpu: 0001 addr: 0xffff80008125b758 phys_addr:
>>>>>>>>>> 0x0000000000000000 ip: 0xffff80008125a8e4 pid: 12720 tid:
>>>>>>>>>> 12720 period: 1 time: 5986372298040 }
>>>>>>>>>>          ffff80008125a8a8 <sched_clock_noinstr>:
>>>>>>>>>>          ffff80008125a8a8:       d503233f        paciasp
>>>>>>>>>>          ffff80008125a8ac:       a9bc7bfd        stp     x29,
>>>>>>>>>> x30, [sp, #-64]!
>>>>>>>>>>          ffff80008125a8b0:       910003fd        mov     x29, sp
>>>>>>>>>>          ffff80008125a8b4:       a90153f3        stp     x19,
>>>>>>>>>> x20, [sp, #16]
>>>>>>>>>>          ffff80008125a8b8:       b000e354        adrp    x20,
>>>>>>>>>> ffff800082ec3000 <tick_bc_dev+0x140>
>>>>>>>>>>          ffff80008125a8bc:       910d0294        add     x20,
>>>>>>>>>> x20, #0x340
>>>>>>>>>>          ffff80008125a8c0:       a90363f7        stp     x23,
>>>>>>>>>> x24, [sp, #48]
>>>>>>>>>>          ffff80008125a8c4:       91002297        add     x23,
>>>>>>>>>> x20, #0x8
>>>>>>>>>>          ffff80008125a8c8:       52800518        mov     w24,
>>>>>>>>>> #0x28                  // #40
>>>>>>>>>>          ffff80008125a8cc:       a9025bf5        stp     x21,
>>>>>>>>>> x22, [sp, #32]
>>>>>>>>>>          ffff80008125a8d0:       b9400296        ldr     w22,
>>>>>>>>>> [x20]
>>>>>>>>>>          ffff80008125a8d4:       120002d5        and     w21,
>>>>>>>>>> w22, #0x1
>>>>>>>>>>          ffff80008125a8d8:       9bb87eb5        umull   x21,
>>>>>>>>>> w21, w24
>>>>>>>>>>          ffff80008125a8dc:       8b1502f3        add     x19,
>>>>>>>>>> x23, x21
>>>>>>>>>>          ffff80008125a8e0:       f9400e60        ldr     x0,
>>>>>>>>>> [x19, #24]
>>>>>>>>>>          ffff80008125a8e4:       d63f0000        blr     x0
>>>>>>>>>>              perf 12720/12720 [0001]      5986.372298040
>>>>>>>>>> sched_clock_noinstr+0x3c
>>>>>>>>>> ...sight/linux/kernel/time/sched_clock.c 93                
>>>>>>>>>> cyc = (rd->read_sched_clock() - rd->epoch_cyc) &
>>>>>>>>>> Event type: branches
>>>>>>>>>> Sample = { cpu: 0001 addr: 0xffff8000801bb4cc phys_addr:
>>>>>>>>>> 0x0000000000000000 ip: 0xffff80008125a930 pid: 12720 tid:
>>>>>>>>>> 12720 period: 1 time: 5986372298040 }
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> With fix:
>>>>>>>>>> =========
>>>>>>>>>>
>>>>>>>>>> Event type: branches
>>>>>>>>>> Sample = { cpu: 0001 addr: 0xffff80008030cb00 phys_addr:
>>>>>>>>>> 0x0000000000000000 ip: 0xffff800080313f0c pid: 12720 tid:
>>>>>>>>>> 12720 period: 1 time: 5986372298040 }
>>>>>>>>>>          ffff800080313f04 <__perf_event_header__init_id+0x4c>:
>>>>>>>>>>          ffff800080313f04:       36100094        tbz     w20,
>>>>>>>>>> #2, ffff800080313f14 <__perf_event_header__init_id+0x5c>
>>>>>>>>>>          ffff800080313f08:       f941e6a0        ldr     x0,
>>>>>>>>>> [x21, #968]
>>>>>>>>>>          ffff800080313f0c:       d63f0000        blr     x0
>>>>>>>>>>              perf 12720/12720 [0001]      5986.372298040
>>>>>>>>>> __perf_event_header__init_id+0x54
>>>>>>>>>> .../coresight/linux/kernel/events/core.c  586         return
>>>>>>>>>> event->clock();
>>>>>>>>>> Event type: branches
>>>>>>>>>> Sample = { cpu: 0001 addr: 0xffff8000801bb4a8 phys_addr:
>>>>>>>>>> 0x0000000000000000 ip: 0xffff80008030cb0c pid: 12720 tid:
>>>>>>>>>> 12720 period: 1 time: 5986372298040 }
>>>>>>>>>>          ffff80008030cb00 <local_clock>:
>>>>>>>>>>          ffff80008030cb00:       d503233f        paciasp
>>>>>>>>>>          ffff80008030cb04:       a9bf7bfd        stp     x29,
>>>>>>>>>> x30, [sp, #-16]!
>>>>>>>>>>          ffff80008030cb08:       910003fd        mov     x29, sp
>>>>>>>>>>          ffff80008030cb0c:       97faba67        bl
>>>>>>>>>> ffff8000801bb4a8 <sched_clock>
>>>>>>>>>>              perf 12720/12720 [0001]      5986.372298040
>>>>>>>>>> local_clock+0xc ...t/linux/./include/linux/sched/clock.h   64
>>>>>>>>>> return sched_clock();
>>>>>>>>>> Event type: branches
>>>>>>>>>> Sample = { cpu: 0001 addr: 0xffff80008125a8a8 phys_addr:
>>>>>>>>>> 0x0000000000000000 ip: 0xffff8000801bb4c8 pid: 12720 tid:
>>>>>>>>>> 12720 period: 1 time: 5986372298040 }
>>>>>>>>>>          ffff8000801bb4a8 <sched_clock>:
>>>>>>>>>>          ffff8000801bb4a8:       d503233f        paciasp
>>>>>>>>>>          ffff8000801bb4ac:       a9be7bfd        stp     x29,
>>>>>>>>>> x30, [sp, #-32]!
>>>>>>>>>>          ffff8000801bb4b0:       910003fd        mov     x29, sp
>>>>>>>>>>          ffff8000801bb4b4:       a90153f3        stp     x19,
>>>>>>>>>> x20, [sp, #16]
>>>>>>>>>>          ffff8000801bb4b8:       d5384113        mrs     x19,
>>>>>>>>>> sp_el0
>>>>>>>>>>          ffff8000801bb4bc:       b9401260        ldr     w0,
>>>>>>>>>> [x19, #16]
>>>>>>>>>>          ffff8000801bb4c0:       11000400        add     w0,
>>>>>>>>>> w0, #0x1
>>>>>>>>>>          ffff8000801bb4c4:       b9001260        str     w0,
>>>>>>>>>> [x19, #16]
>>>>>>>>>>          ffff8000801bb4c8:       94427cf8        bl
>>>>>>>>>> ffff80008125a8a8 <sched_clock_noinstr>
>>>>>>>>>>              perf 12720/12720 [0001]      5986.372298040
>>>>>>>>>> sched_clock+0x20 ...sight/linux/kernel/time/sched_clock.c  105
>>>>>>>>>> ns = sched_clock_noinstr();
>>>>>>>>>> Event type: branches
>>>>>>>>>> Sample = { cpu: 0001 addr: 0xffff80008125b758 phys_addr:
>>>>>>>>>> 0x0000000000000000 ip: 0xffff80008125a8e4 pid: 12720 tid:
>>>>>>>>>> 12720 period: 1 time: 5986372298040 }
>>>>>>>>>>          ffff80008125a8a8 <sched_clock_noinstr>:
>>>>>>>>>>          ffff80008125a8a8:       d503233f        paciasp
>>>>>>>>>>          ffff80008125a8ac:       a9bc7bfd        stp     x29,
>>>>>>>>>> x30, [sp, #-64]!
>>>>>>>>>>          ffff80008125a8b0:       910003fd        mov     x29, sp
>>>>>>>>>>          ffff80008125a8b4:       a90153f3        stp     x19,
>>>>>>>>>> x20, [sp, #16]
>>>>>>>>>>          ffff80008125a8b8:       b000e354        adrp    x20,
>>>>>>>>>> ffff800082ec3000 <tick_bc_dev+0x140>
>>>>>>>>>>          ffff80008125a8bc:       910d0294        add     x20,
>>>>>>>>>> x20, #0x340
>>>>>>>>>>          ffff80008125a8c0:       a90363f7        stp     x23,
>>>>>>>>>> x24, [sp, #48]
>>>>>>>>>>          ffff80008125a8c4:       91002297        add     x23,
>>>>>>>>>> x20, #0x8
>>>>>>>>>>          ffff80008125a8c8:       52800518        mov     w24,
>>>>>>>>>> #0x28                  // #40
>>>>>>>>>>          ffff80008125a8cc:       a9025bf5        stp     x21,
>>>>>>>>>> x22, [sp, #32]
>>>>>>>>>>          ffff80008125a8d0:       b9400296        ldr     w22,
>>>>>>>>>> [x20]
>>>>>>>>>>          ffff80008125a8d4:       120002d5        and     w21,
>>>>>>>>>> w22, #0x1
>>>>>>>>>>          ffff80008125a8d8:       9bb87eb5        umull   x21,
>>>>>>>>>> w21, w24
>>>>>>>>>>          ffff80008125a8dc:       8b1502f3        add     x19,
>>>>>>>>>> x23, x21
>>>>>>>>>>          ffff80008125a8e0:       f9400e60        ldr     x0,
>>>>>>>>>> [x19, #24]
>>>>>>>>>>          ffff80008125a8e4:       d63f0000        blr     x0
>>>>>>>>>
>>>>>>>>> It looks like the disassembly now assumes this BLR wasn't
>>>>>>>>> taken. We go from ffff80008125a8e4 straight through to ...
>>>>>>>>>
>>>>>>>>>>              perf 12720/12720 [0001]      5986.372298040
>>>>>>>>>> sched_clock_noinstr+0x3c
>>>>>>>>>> ...sight/linux/kernel/time/sched_clock.c 93                
>>>>>>>>>> cyc = (rd->read_sched_clock() - rd->epoch_cyc) &
>>>>>>>>>> Event type: branches
>>>>>>>>>> Sample = { cpu: 0001 addr: 0xffff8000801bb4cc phys_addr:
>>>>>>>>>> 0x0000000000000000 ip: 0xffff80008125a930 pid: 12720 tid:
>>>>>>>>>> 12720 period: 1 time: 5986372298040 }
>>>>>>>>>>          ffff80008125a8e8 <sched_clock_noinstr+0x40>:
>>>>>>>>>>          ffff80008125a8e8:       f8756ae3        ldr     x3,
>>>>>>>>>> [x23, x21]
>>>>>>>>>
>>>>>>>>> ffff80008125a8e4 which is just the previous one +4. Isn't your
>>>>>>>>> issue actually a decode issue in Perf itself? Why is there a
>>>>>>>>> discontinuity without branch samples being generated where
>>>>>>>>> either the source or destination address is 0?
>>>>>>>>>
>>>>>>>>> What are your record options to create this issue? As I
>>>>>>>>> mentioned in the previous reply I haven't been able to
>>>>>>>>> reproduce it.
>>>>>>>>
>>>>>>>> I am using below perf record command.
>>>>>>>>
>>>>>>>> timeout 4s ./perf record -e cs_etm// -C 1 dd if=/dev/zero
>>>>>>>> of=/dev/null
>>>>>>>>
>>>>>>>
>>>>>>> Thanks I managed to reproduce it. I'll take a look to see if I
>>>>>>> think the issue is somewhere else.
>>>>>>>
>>>>>>
>>>>>> At least for the failures I encountered, the issue is due to the
>>>>>> alternatives runtime instruction patching mechanism. vmlinux ends
>>>>>> up being the wrong image to decode with because a load of branches
>>>>>> are actually turned into nops.
>>>>>>
>>>>>> Can you confirm if you use --kcore instead of vmlinux that you
>>>>>> still get failures:
>>>>>>
>>>>>>    sudo perf record -e cs_etm// -C 1 --kcore -o
>>>>>> <output-folder.data> -- \
>>>>>>      dd if=/dev/zero of=/dev/null
>>>>>>
>>>>>>     perf script -i <output-folder.data> \
>>>>>>      tools/perf/scripts/python/arm-cs-trace-disasm.py -d
>>>>>> llvm-objdump \
>>>>>>      -k <output-folder.data>/kcore_dir/kcore
>>>>>>
>>>>>
>>>>> With below command combination with kcore also the issue is seen,
>>>>> as reported in this email chain.
>>>>>
>>>>> timeout 8s ./perf record -e cs_etm// -C 1 --kcore -o kcore \
>>>>> dd if=/dev/zero of=/dev/null
>>>>>
>>>>> ./perf script -i kcore/data \
>>>>> --script=python:./scripts/python/arm-cs-trace-disasm.py -- \
>>>>> -d objdump -k kcore/kcore_dir/kcore
>>>>>
>>>>>
>>>>> However, with below sequence(same as your command) the issue is
>>>>> *not* seen.
>>>>>
>>>>> timeout 8s ./perf record -e cs_etm// -C 1 --kcore -o kcore \
>>>>> dd if=/dev/zero of=/dev/null
>>>>>
>>>>> ./perf script -i kcore/data ./scripts/python/arm-cs-trace-disasm.py \
>>>>> -- -d objdump -k kcore/kcore_dir/kcore
>>>>>
>>>>> Do you see any issue with the command, which is showing the problem?
>>>>> Also the output log produced by these both commands is different.
>>>>>
>>
>> BTW are you running this on the target or somewhere else? It's
>> suspicious that "-i kcore/data" works at all because there is no
>> kernel image given to Perf. Unless you are running on the target and
>> then I think it will just open the one from /proc. Or maybe it uses
>> /boot/vmlinux by default which also wouldn't work.
>>
>> Also the difference between "--script=python:" and just giving the
>> script name is in the parsing of the arguments following " -- ".
>> Sometimes they're also parsed as Perf arguments (like the -v becomes
>> perf verbose and -k becomes the Perf vmlinux rather than the script).
>>
>> I _think_ you want the " -- " when "--script" is used, and no "--"
>> when it's not. But there are some other combinations and you'll have
>> to debug it to compare your two exact scenarios to see why they're
>> different.
>>
>> But ignoring that issue with the argument format, you mentioned you
>> didn't see the issue any more with one version of --kcore. So I'm
>> assuming that confirms the issue is just a decode image issue, so we
>> shouldn't try to patch this script?
>>
> 
> Although one change we should make to the script is change the example
> to use kcore. We can leave in one vmlinux one as an example if kcore
> isn't available, but add a note that it will fail if any patched code is
> traced (which is almost always).

James, you may recall the year old thread
https://lore.kernel.org/all/ed8cea4c-a261-60ca-f4e1-333ec73cca8f@os.amperecomputing.com.
I described there an awkward workaround Ampere has used to solve the
patched code problem. At the time, it sounded like the maintainers were
interested in getting away from using the python script, mostly for
speed purposes. I didn't see the discussion go any further.

> 
> And make the other fixes to OpenCSD to stop it from making samples that
> go backwards. That will fix the hard exit on the script and turn it into
> a regular descynchronise.
> 
>>>>
>>>> Double check the command I gave. "-i" needs to be the same as "-o"
>>>> (it's the folder, not the data file). I think this could be causing
>>>> your issue. Unless you give it the folder it doesn't open kcore
>>>> along with the data file.
>>>>
>>>
>>> As per 'perf script --help'
>>>
>>>         -i, --input=
>>>             Input file name. (default: perf.data unless stdin is a fifo)
>>>
>>
>> That could probably say "file name, or folder when --kcore is used",
>> if you mean that you think it's not accurate?
>>
>> But when you use --kcore the default folder (not file) name is still
>> perf.data, so the default argument gives you a clue that you're not
>> supposed to descend into the folder.
>>
>>> Also tried just giving dir as you suggested and still the same.
>>>
>>> ./perf script -i kcore
>>> --script=python:./scripts/python/arm-cs-trace-disasm.py -- -d objdump
>>> -k kcore/kcore_dir/kcore
>>>
>>>>> The below diff that you have shared has no effect on the failing case.
>>>>>
>>>>>> But I still think bad decode detection should be moved as much as
>>>>>> possible into OpenCSD and Perf rather than this script. Otherwise
>>>>>> every tool will have to re-implement it, and OpenCSD has a lot
>>>>>> more info to make decisions with.
>>>>>>
>>>>>> One change we can make is to desynchronize when an N atom is an
>>>>>> unconditional branch:
>>>>>>
>>>>>>   diff --git a/decoder/source/etmv4/trc_pkt_decode_etmv4i.cpp
>>>>>> b/decoder/source/etmv4/trc_pkt_decode_etmv4i.cpp
>>>>>> index c557998..3eefd5d 100644
>>>>>> --- a/decoder/source/etmv4/trc_pkt_decode_etmv4i.cpp
>>>>>> +++ b/decoder/source/etmv4/trc_pkt_decode_etmv4i.cpp
>>>>>> @@ -1341,6 +1341,14 @@ ocsd_err_t
>>>>>> TrcPktDecodeEtmV4I::processAtom(const ocsd_atm_val atom)
>>>>>>           //  save recorded next instuction address
>>>>>>           ocsd_vaddr_t nextAddr = m_instr_info.instr_addr;
>>>>>>
>>>>>> +        // must have lost sync if an unconditional branch wasn't
>>>>>> taken
>>>>>> +        if (atom == ATOM_N && !m_instr_info.is_conditional) {
>>>>>> +             m_need_addr = true;
>>>>>> +             m_out_elem.addElemType(m_index_curr_pkt,
>>>>>> OCSD_GEN_TRC_ELEM_NO_SYNC);
>>>>>> +             // wait for next address
>>>>>> +             return OCSD_OK;
>>>>>> +        }
>>>>>> +
>>>>>>
>>>>>> Another one we can spot is when a new address comes that is before
>>>>>> the current decode address (basically the backwards check that you
>>>>>> added).
>>>>>>
>>>>>> There are probably others that can be spotted like an address
>>>>>> appearing after a direct branch that doesn't match the branch target.
>>>>>>
>>>>>> I think at that point, desynchronising should cause the
>>>>>> disassembly script to throw away the last bit, rather than force
>>>>>> it to be printed as in this patch. As I mentioned above in the
>>>>>> thread, it leads to printing disassembly that's implausible and
>>>>>> misleading (where an unconditional branch wasn't taken).
>>>>>
>>>
>>> Thanks,
>>> Ganapat

