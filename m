Return-Path: <linux-kernel+bounces-333358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A7797C75F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 11:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D66B1C26734
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 09:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6603C19B5A3;
	Thu, 19 Sep 2024 09:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="6Brwtmxq"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11020128.outbound.protection.outlook.com [52.101.51.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0341991AF;
	Thu, 19 Sep 2024 09:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.51.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726739023; cv=fail; b=Obm7jQ6RHI3j9EY1O1X5YqAhT/y9eFsIUiF+qNboBkr0nA8yrdRlWQBWSRC2vsyhwkYd8yVvX0FMq6Mj+klzsPetUagrEDqnj1DvcXHbItXPVPt7qDrDmJCyRjKgDMFirCdh2oCvgVVj3A693jM7lOgOzOYNR77tAomkgN4bfX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726739023; c=relaxed/simple;
	bh=kipOIusl/SWk63W2KDTjVNpoNbncwrtuGjJm/miE3r0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bY97iEojoDqXHPHK197v5AlrrRKFTKsSB86A3Tb5QrT4lUDMOZZ0iaw0mh9i6l41ttwsepQp+MQly/M30q9jlop52SpNykHQClaQXP4K2cz8H4x1MkIhKNcT4E/l2lFiOv1vFYS4nEaZPxYK3/3DxBpoQ6fJswHEN51BIAiP3OI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=6Brwtmxq reason="key not found in DNS"; arc=fail smtp.client-ip=52.101.51.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M8bi/grF/uUC6Ki5TVPCqn6GlNe7EzPOMS96Pvat5Ji4UM7byhge9qTWSdRQ5EhBtDNc7ci6LbIVc6zWIxiSD5zAchszXrXe2lt7wOzMZrLmIx8a93PT3R0/Fcxwb+73NEzyLinEqZ6UZirhotZDa8iPS/vKcj2t3Naz/7V2aRKVMFgAzxzzoecSpIq8Bfml0uXpgwzQ64j+F6xiiY7WSj5raSQALGhLiQ3+cyyop08JUa21VhVFi8GCscnICgdr8v/xYYiYp7pZmLRIUSJz1bX+UiaatDQDv4YvbPzJ7Qo+hPh7x6Hp2bB4VpLxw/6XESXYG6LNFWRuaoMJmpWWbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K6lsVFkQTiOcPFaoihkXs4jGILTbLc3/mjQhGTssBz4=;
 b=BJ2oxjaRsdl8LF6oU/Sf9xZ3GRTyFsdFgyLY4DsclJCd4gqbyltubCPNTLpb0rwwA+HXpYx1u7K9D3BGQJN9nBuNNIoshvYI67fTI9IYBTZS/vxtS3/zO+3tKzebRNlBk/rLU7jxo2V78bwgVGe5ASjsIIzJT04iKbbJde/E1WxYCZVixxn8wTRbgRWabWQ/JMQXrTuvdMSLrL8e101+8ZbH1tiITDTdPiCHvAxFpahRfEcM+yBas3MGQ/QG8OchjMH6d0OosTxDcI4KFkYXpVddrpIOmvt9Ib/3Pvf/VB/KXBrjYo9tIMj/ZB5K/lYnF3CVfkltgEY9EVYhS01p+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6lsVFkQTiOcPFaoihkXs4jGILTbLc3/mjQhGTssBz4=;
 b=6BrwtmxqD/Mt9tCZOoMq5buEvgKBB198ZdDeLQnSdRDIAju4zPaPJOspg6Uktq6Tb1xuHKDH2tSsb7fWK6jJ69r9XM1iiNOxAVF6vuBiegtNpM+FucRIEjaWMNHYptCc2KkxQbQll/SmomM3ycRcLla+lUZu/KgsKxrQboygW3w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BL3PR01MB7057.prod.exchangelabs.com (2603:10b6:208:35c::16) by
 CO1PR01MB6645.prod.exchangelabs.com (2603:10b6:303:f8::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.17; Thu, 19 Sep 2024 09:43:34 +0000
Received: from BL3PR01MB7057.prod.exchangelabs.com
 ([fe80::b69e:5684:ed7c:4d09]) by BL3PR01MB7057.prod.exchangelabs.com
 ([fe80::b69e:5684:ed7c:4d09%4]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 09:43:33 +0000
Message-ID: <d825a93f-be5c-45b9-a8d4-5c412ddec232@amperemail.onmicrosoft.com>
Date: Thu, 19 Sep 2024 16:43:23 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: hwmon: Add adt7462
To: Rob Herring <robh@kernel.org>, Chanh Nguyen <chanh@os.amperecomputing.com>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 OpenBMC Maillist <openbmc@lists.ozlabs.org>,
 Open Source Submission <patches@amperecomputing.com>,
 Phong Vo <phong@os.amperecomputing.com>,
 Thang Nguyen <thang@os.amperecomputing.com>,
 Quan Nguyen <quan@os.amperecomputing.com>,
 Khanh Pham <khpham@amperecomputing.com>
References: <20240918103212.591204-1-chanh@os.amperecomputing.com>
 <20240918220553.GA2216504-robh@kernel.org>
Content-Language: en-US
From: Chanh Nguyen <chanh@amperemail.onmicrosoft.com>
In-Reply-To: <20240918220553.GA2216504-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0029.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::42) To BL3PR01MB7057.prod.exchangelabs.com
 (2603:10b6:208:35c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR01MB7057:EE_|CO1PR01MB6645:EE_
X-MS-Office365-Filtering-Correlation-Id: 152d146c-bba7-46e9-cc2d-08dcd88f868e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UmZZaWxRdjk1NExIQmNuQkk0QW94NUFjVDB0cWdoRzJLU0hTYlQyMHdadjhl?=
 =?utf-8?B?aXo1RTNGdU51R3ZoZCtpeWovUTJJcC8xTUtVT29tMmFFWWJMK3lCejE3aWQv?=
 =?utf-8?B?MXZqeERtME0zR0wxRU9iSC9lb0QycVQwOGtzbi9jektVTktQZEN4cFBGd1hp?=
 =?utf-8?B?SmpiTC8vclQyNHhlLzNVOVJFcEVZZTFIR3BWdEl4aGpVdGhaQXdwQW9qQWg4?=
 =?utf-8?B?MTRKYnRBMzk1T1NmYlI5cEtkczB2WU94QVdRYXVFV3RxWjFvV1ZPMGxjTnVv?=
 =?utf-8?B?RUI3TjhzMzc5NWp0d3ViVExGVnFIT053U3NrQm5sUDRERUhJZXIzRUVQa0Z0?=
 =?utf-8?B?eUZ4dFlQNHloL0VHcGY3TkFhaEpSdy84Tk1IRGtkSmJ0Z3RiK2p5QUMwMzR3?=
 =?utf-8?B?YmZhY0xQWnBTNHNXbDNrcnhsNGlPWTBRakFoZDhpNDd2Z0drRHVVRmMwVTd2?=
 =?utf-8?B?eVA3QUlaQTc0dkgxRnd5QS80TWkyTWRZbUo5a0JWaDJYODNvOHFtMTVLSmRE?=
 =?utf-8?B?VUhydTl2SkcwcitmM3JMZEFKL3FPbkdCRUJmSFcySHEzc0FsOXVkVEwrQkxK?=
 =?utf-8?B?Zk43NENSekd4YWx6NHVTWkUwY3hXVVcyaG1SRGxFclVqTmRHeHVTYVpBUUpE?=
 =?utf-8?B?SVQvZVJTanVodnNOWlR5M2s4ekdlcHdCK0Z3cjlyanlUYmFJVHVySThQVWtQ?=
 =?utf-8?B?VEgyaEVSd0xyUjdHNkF6MFJTdUNEUG96czZpbDNzUDk0S0dPMTdhNWNnYkVi?=
 =?utf-8?B?SnBsU0NIaHprNVEvZEZMZHY3aEhLbUpMTGVUYzBBZnZVNkV1a0NZSkhydGVo?=
 =?utf-8?B?T3ZrUVFwUWJjWENIb29PL0hyeW1LR012cGxLaGt4MVp3SktTaVhIK2VIbFBF?=
 =?utf-8?B?czFZSERhQS9TbHgzeU1mdGE3ZHNNTkVXRDdvNkJGd2NydGhYVmJ5ZDVtZjdB?=
 =?utf-8?B?NlVxMDByMTFjZVBTd0MwbS9uUzA2ZjNxTXVVR0NpdWdpaXNYdU1iSjNPZXFB?=
 =?utf-8?B?WXY5dmwxMnJWMFJLNVhNQzBkbUZRaGxDSzlxR1FMVjFGNjIwLzdISGMxa3g3?=
 =?utf-8?B?c1h3RnRvRmtoZmFwTjVwVDJrcUFiN3Y0QUhRb0haNFpHaFg2Z0xMeHdGMzhQ?=
 =?utf-8?B?RkxiV2dFWkE0MDNYUC85MkxXOEErMGFFQWFWdk1kVHgvazcybW8rNXl2czI2?=
 =?utf-8?B?UVY5cWFtUVlVaGpGUkRrNzBuUWRxU1YxdzduVTJoR3ErNnJtdURHSW94RW4y?=
 =?utf-8?B?OGZBQ3RMKzF5UUJMbUtqdytramRlcjNGVWxHN0l0c3owTjVwZzdOanlCVjhC?=
 =?utf-8?B?TXFIZ3U5NXQvdnhnbEdQeVBBcjNsTTl4OWRLc08rRjJheWdTcjU4THZOL0Vi?=
 =?utf-8?B?SWgveDZ1L0NJc3phd04zUVNVTDJGWmZEZzBWSmhzeVlpS2o5eGU4RDQ0a3Q2?=
 =?utf-8?B?NGtjSGUvaFR0eGl0a29WWlNOTWRRcmJnc0JWNER6R1IvaURMSG1rNkVVMnRD?=
 =?utf-8?B?clluK2c2d0FtSVdSdER6K0VBTWRxdmQvN2IxTVQ1WVZkZ1h0ZHppZXoveHJV?=
 =?utf-8?B?bEFmWW5wNjJoanNjbUlyN3pXblRrMmtZblR3dlgvNUoyOGk1eWFmQ3lwMnBX?=
 =?utf-8?B?K1d3NVVCeC9yQkZsM3lMWWcyVXVVcEFCVFJpdmVGSnRPaCtXS0xOdTloRU8z?=
 =?utf-8?B?TmZ1TWcwN01VWVc4SldvcG5CN2ZOMUdlUFlGa253Rkh1dU12d0FKdmpMUFht?=
 =?utf-8?Q?XaQzY8KZuvl6JdQZWg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR01MB7057.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NytXUG1qNDA2bjA3c2xLelpBWmdKc0FKOGpBd3BaUWZyVWptcVRtSlkyaVRW?=
 =?utf-8?B?OUhHdUM2TSs1RmNHUG9nNUVpMjh3QmFMSXFuVnBVSndxWGdjSGhNM3pCNDJs?=
 =?utf-8?B?bGpVejRlNG9wclFQQkwyak1oV2h6KzAyT2V6NFBHL1VTVTJwOWVJQlVnVHgr?=
 =?utf-8?B?c3htOHFHWmQxUWQ5THA0Y2krWWh0eWxNRHU4VXNLcEpvRjJSYVZJeEg1MzdN?=
 =?utf-8?B?ME9CZis5TjdOU0pDS3FscmlWZmlhZWh4a3FYZjdwWFRoblk5SzVTTHFoT1JY?=
 =?utf-8?B?VnY2SGFodllzYTd2OStzZlR6enJDbEJOb1FRRDBVYjFDQzY2VjhOaWNxT1FU?=
 =?utf-8?B?YVF1Yk05WkNob3duTWJkVDAxN0dMRzNpQ2xEU3NVRS8rMCt6L25lVGpkZkhm?=
 =?utf-8?B?VTAwMEZVWjVzdkhCcHZZWHRHakVlNHYrazl0cDNKZHU2dzdWYnRzendtRXRm?=
 =?utf-8?B?ZTdLSVU1SHl0QzdhUThqQXg2Mk82VVgybkY3QWVoeityakZlOXVtZHZzRjRQ?=
 =?utf-8?B?NGVxY1AvMVhveTlUckhUbWRkajE5U1JRNGpZYUY0OXpWbWIveVBSQ3lyclUy?=
 =?utf-8?B?YUgvU3h2ZEdCdzlzaTZJTW9zdGxkTCthVkRVU2JOOElRdEF3OVFWZ2NwTW51?=
 =?utf-8?B?VHR3TVZYQnd4VFY2KzFpSG5FamdUWlNPbXNTYTJLNy9JUmhHdUlsVXo0c3BH?=
 =?utf-8?B?RkNPWFlYOS9hSFFZQzRWOTJ4RkZ1Y2Zpcks3cWlDa2FRZFFJTktTd2IvWFcr?=
 =?utf-8?B?bGkwVW41eHQ0OXZFVzIwWmxtVDN6NkJtNklKakdacHFyeU9EenJpVW9CZmxw?=
 =?utf-8?B?ZzNnTUpiRVdzb0hhUHZzS1VtK2prR0tHSjdUQUlTS3FjOGVHS2VoT2xkQ29o?=
 =?utf-8?B?T3JqWlZySWl2dDk3clNCbUlicU13NUY3dkpZZjN3Tit2WXN1SVQra0c2T3Bv?=
 =?utf-8?B?bW8xRC9mZ2xmY0M5SWdiRWZ3ZFV0UEZrZWJFeE5qaDdIMmp3SkZ5cFJ1RDVh?=
 =?utf-8?B?M2Q2UjJaZ3JrenpOY1kvVU1LZkE5TktXZWFZUk5KSGxMUnVUanVyVlBWbldY?=
 =?utf-8?B?aXJwYWt4ZENqY1ZDK1dkNzdrZ0VlTlhud29RbGo5djUrZTJtaG9mTmF3c2Zh?=
 =?utf-8?B?QmJqK3RBZndhY01hTnduR0c2S0VYL2xucDN6Qys1MU5Gbi9vMFp6QVZEV0Y2?=
 =?utf-8?B?LzVjbXZwVDVHYndRNmY0NmdEaXBERGJWL3ZnbDYvUWVOMlpXbVp4UDY4cEtt?=
 =?utf-8?B?a0pNZWl2d0h5SWppUTEzQVo0NnNrcWlkUG1lUXVXekNCczl5RCtXdlh0a3Z4?=
 =?utf-8?B?S0pJSkFuZWZaQXRHalQ3RnMwUWxOSnI1ZGdBanRUNm9aUVNFN0dOQTMxTlpq?=
 =?utf-8?B?eWRxaWRHSjN1VE5QUU1oQUNsNG1oNDBRbUN4YlNPSHlsZXAxeG9HakRmR2E5?=
 =?utf-8?B?S0pxcmxXay9NSU9FdWJhYy91NitIYkJla0FNbGc4YzVVa0x1S3o3M3FUZEhH?=
 =?utf-8?B?ZkkyM0RYQ0I1MUQ3QitUaUJ6YUVOYzdrMjZaOEFrdmV2c2I0bmhzL0dOMWFJ?=
 =?utf-8?B?SmhkMXlOL3YxbEo1UDdOTUlCenpTWnM4VXpqaTFrK0pUaERzMUViZS9XQU5S?=
 =?utf-8?B?NVVKV202N2I5QW1VSXF1RDBLanNpSmpiQ1NSeHlrV3MvWm1Ubk01bkx1WEFm?=
 =?utf-8?B?UWxsMVpSVWtjbUUzdzRDK3p0ejFMQ1p0Zm5SVVBIS2ZMWE9DSmgyalkzUzZp?=
 =?utf-8?B?TXlMKzJvd043eUw2a2Z5dzBWbVpKUThrWnJndjFSeUcwdWxTcnlCTWJOVHFY?=
 =?utf-8?B?SkZhd2NBQzJRT0l0WHJsTS9qTmVkcWUyZDJZektxcmN6TjI0dlcwdjJvZEpS?=
 =?utf-8?B?cGFqNWorMm9CVlpyZDRtMmowRlZoZFc5eW1NS1E4dU9hRXZWVEpiaVZTdFpi?=
 =?utf-8?B?MWJBN3BLS1FPU2FocXkwOVUvZUU1bFNYaFBjMlpaVWt4c2tqYmlSWEdSbDNU?=
 =?utf-8?B?azdVRHEyWm8ySmJTaWFQcjVOV0ZJcC9EUTNHMnFLMGc5dGIwKzlkSm1sdW5G?=
 =?utf-8?B?eUdlcXlUbHlyMG1rTWFjREw5ajQrQU1ic0NGQW9KaGFxOTRXZURoZkhFdVFJ?=
 =?utf-8?B?dExadGRBYlQ1NzkrZFlLM2F4TXplSlljampzY3pmMFdsUHNWbSs5YzNSdnBo?=
 =?utf-8?Q?QkzDlcJexQmVguXCvJ3EvOQ=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 152d146c-bba7-46e9-cc2d-08dcd88f868e
X-MS-Exchange-CrossTenant-AuthSource: BL3PR01MB7057.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 09:43:33.7046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3QWoTj1JLMUPAlGrTKPH63UvvxRlIpYP1jV+wcY1AvhwuR7tlrcnvfcFcLTDWxJAAx/uolXSwVLGqngEzPPf8V3PQ/7PucJWTCJKCPigCTot9I9WoefpQoEtK41NHWej
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB6645



On 19/09/2024 05:05, Rob Herring wrote:
> On Wed, Sep 18, 2024 at 10:32:12AM +0000, Chanh Nguyen wrote:
>> Add device tree binding and example for adt7462 device.
>>
>> Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
>> ---
>>   .../bindings/hwmon/onnn,adt7462.yaml          | 51 +++++++++++++++++++
>>   1 file changed, 51 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/hwmon/onnn,adt7462.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/hwmon/onnn,adt7462.yaml b/Documentation/devicetree/bindings/hwmon/onnn,adt7462.yaml
>> new file mode 100644
>> index 000000000000..4a980cca419a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/hwmon/onnn,adt7462.yaml
>> @@ -0,0 +1,51 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/hwmon/onnn,adt7462.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: ON Semiconductor ADT7462 Temperature, Voltage Monitor and Fan Controller
>> +
>> +maintainers:
>> +  - Chanh Nguyen <chanh@os.amperecomputing.com>
>> +
>> +description: |
>> +  The ADT7462 has temperature monitors, voltage monitors and multiple PWN Fan
>> +  controllers.
>> +
>> +  The ADT7462 supports monitoring and controlling up to four PWM Fan Drive
>> +  Outputs and eight TACH Inputs Measures. The ADT7462 supports reading a single
>> +  on chip temperature sensor and three remote temperature sensors. There are up
>> +  to 13 voltage monitoring inputs, ranging from 12V to 0.9V.
>> +
>> +  Datasheets:
>> +    https://www.onsemi.com/pub/Collateral/ADT7462-D.PDF
>> +
>> +properties:
>> +  compatible:
>> +    const: onnn,adt7462
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  resets:
>> +    maxItems: 1
> 
> How would this work? 'resets' generally is used for on-chip devices and
> a reset controller. That doesn't exist at the board level. A standalone
> device typically uses a GPIO lines if there's a s/w controlled reset.
> That would be the 'reset-gpios' property.
> 

Thank Rob for your comments! The ADT7462 includes an active low reset 
pin (Pin #14).

I'll change 'resets' into the 'reset-gpios' property.

The example in the binding will be

examples:
   - |
     i2c {
       #address-cells = <1>;
       #size-cells = <0>;

       hwmon@5c {
         compatible = "onnn,adt7462";
         reg = <0x5c>;
         reset-gpios = <&gpio0 1 GPIO_ACTIVE_LOW>;
       };
     };


> Rob

