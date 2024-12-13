Return-Path: <linux-kernel+bounces-444358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A91339F0576
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 08:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 648EF282D32
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 07:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026911552FC;
	Fri, 13 Dec 2024 07:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs-soprasteria.com header.i=@cs-soprasteria.com header.b="Wrtfd0VX"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2056.outbound.protection.outlook.com [40.107.21.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AF7185B5B
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 07:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734074830; cv=fail; b=gRc9OI7TgC5VVyl3grRpv8z7VYw0qn2P96Yz1CbOAVXQiZ+ZXR7H8oa7cylWEie1SToZB73B+fP9maNI0ayYbOj9+E9zixc07FAnyGVuTmySzjeibk/i099kf3s1e55T/orK2W/YKlpFyCPyaOSqajzlAz0/bEv35Jka9VeFz34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734074830; c=relaxed/simple;
	bh=hdL3UCKYJLbJXvGaCsvSydMZY+u1pV5Ev91i21iPTNw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U2fa9n34AVv7ktSdSFnX9qIOtR06uAJ0zXmUjFeibuChqod0Gmfa6/pVor0A6zgMfVrY9AgaV29pHJRU39cfbJyiJh0xhawmXcmzfwwHZRYWEFUkzXthQ33FaLODcQENcUYpZmwuVPnMQQO2pLM1qCpNcpOGEyIy5a/er/dvrsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs-soprasteria.com; spf=pass smtp.mailfrom=cs-soprasteria.com; dkim=pass (2048-bit key) header.d=cs-soprasteria.com header.i=@cs-soprasteria.com header.b=Wrtfd0VX; arc=fail smtp.client-ip=40.107.21.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs-soprasteria.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs-soprasteria.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BNVnEcfoCiEffcNBryJothiprXT4Pt0CrrI4hE0DWzM/vOKGpsf/6QIPmg+DjJ2RTGPuOQh2PjittWfnjHfxLQsI8kmIomCW0CAPsuEFwAqrfhNl4hQxC46U01/IIk+Ch3Ce1F4kkwdan+re4BYc1exN4Ovl8ks6S73mHn5mlPUT8AGR3G2JVHhzchZsbFITMjKFcwuhHhC7ma1twLbVT63T38BPQr8/+q50j1ekKMiL5rOD0XvBUfWoZ7OKiZD/IDOWqI+kzKgmUzc2CGQT77fpXkex1gMma7dguMtgvUt15FnECSz+1LENEYS3SYXfZfQ4/86jQETsHlfPh9Sd1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hdL3UCKYJLbJXvGaCsvSydMZY+u1pV5Ev91i21iPTNw=;
 b=x2kBnDLNTbu039GSym4y3uKHXZqKink3ymHqz/eYbWWmDBzrUxtHgkPfxYb2OU9BifoWwMBleZvbICGTE910VEOY8yWlH8eahv4QVeODMs8lTwZO+aSQgNcscl3q+LIv7FXOowa2A3YlZDRLaTV5Jrc5w1yV6J5xUobPZODN/LPYU2bjcYc5UCnr/j7JVL27yEQa762Ag/uCo7OGSvqmt1ClzSzQrRyHsK6GPR00EPIj+YU7yDerIZatH51lF6QMeoeLR9zrrPknbkty/8+i4g0BG5FaAWzi7fUfRuyjD7Lz5LQgG5hodFvSJtJS4RyDbMKkmDnbvVQeT77lR+fESw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cs-soprasteria.com; dmarc=pass action=none
 header.from=cs-soprasteria.com; dkim=pass header.d=cs-soprasteria.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs-soprasteria.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdL3UCKYJLbJXvGaCsvSydMZY+u1pV5Ev91i21iPTNw=;
 b=Wrtfd0VXOesybT/CY7vFDtxML8TmqSOlhvxCzClZflhWPXOMFomR6MzAXnY6lXYNiOUGvWtoP5ScVasu+DXKerYnlczEFi5xCit7064cTXyb1olT7lO8rPRNhGlTgo8UIHbwMXI0WIJGt/Km/f7ybG3EfZTehweLT8Ad+sFJ046229ttenTCmHLUxLSo3WO3e9+4cSKJOSPA3m4q2Wd4lL+NlQ9iJJy2oMRTsRpMCjFm8rb67GtYWSd2r2zHoU9k6PAqI2TNCDDtIHngHx7odmuofD0247/hk6iu/Vruy0Pg+81d39jmfrjvqYTV8sn8/CKRFWGq358aNejGOD/zIA==
Received: from PA4PR07MB7455.eurprd07.prod.outlook.com (2603:10a6:102:b9::12)
 by AS8PR07MB9111.eurprd07.prod.outlook.com (2603:10a6:20b:567::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 07:27:03 +0000
Received: from PA4PR07MB7455.eurprd07.prod.outlook.com
 ([fe80::191c:a08d:4945:6288]) by PA4PR07MB7455.eurprd07.prod.outlook.com
 ([fe80::191c:a08d:4945:6288%6]) with mapi id 15.20.8251.008; Fri, 13 Dec 2024
 07:27:03 +0000
From: LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
To: Frederic Weisbecker <frederic@kernel.org>, LKML
	<linux-kernel@vger.kernel.org>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Andrew Morton
	<akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 06/19] soc/qman: test: Use kthread_run_on_cpu()
Thread-Topic: [PATCH 06/19] soc/qman: test: Use kthread_run_on_cpu()
Thread-Index: AQHbS+Mex5HqM2GsQkaLVT6cfvGz17LjyQcA
Date: Fri, 13 Dec 2024 07:27:03 +0000
Message-ID: <986fee5c-8537-498f-83ec-65a7c7c7a71c@cs-soprasteria.com>
References: <20241211154035.75565-1-frederic@kernel.org>
 <20241211154035.75565-7-frederic@kernel.org>
In-Reply-To: <20241211154035.75565-7-frederic@kernel.org>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cs-soprasteria.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR07MB7455:EE_|AS8PR07MB9111:EE_
x-ms-office365-filtering-correlation-id: aa59d417-63ba-458b-bb31-08dd1b478a4a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RW1udzFrNVhQN2NNemR1dnhjZ29WT0RycE5nYUIvaHNUZEtuclhYVFlwQVNh?=
 =?utf-8?B?dXlXL0k4UmxFQ2VOUytvTEdJL2hvWU1raVJnU2VmaUNwVVdwMzNHemhqNlVP?=
 =?utf-8?B?dFUrVWwyQVJ1UlhYemgrNngwb2R3RzdKQ0tBS2FQVmxwYVB2ejJHaWlHTlp0?=
 =?utf-8?B?cHYwaFBseUNnTWhKMlE5Tk9mSDZXZGpxQS9oczRZZjlxVks2eEdTMWhHT1hz?=
 =?utf-8?B?U3ZpaUhNN2J6a1VDKzB0UEZIUmJHRHNLQ1phU0NEVk93dVdCaUMrUUFmWVNy?=
 =?utf-8?B?TFFMb3hmdkQrM0c0M3FmQ0EyVW15bjN2RnFsNGZBd3QrQkdtZ0FrSm9UWDQz?=
 =?utf-8?B?endqQ2EzNjV4TldEdmZVWVVGajltODJXQWhGVUJxdENGTzBCVkNaNURjS1Ey?=
 =?utf-8?B?QmxjalBKZ1ZObHFKcXJqdWsvSzRtRWNtMTJtUmdCS0J3SURoVUhmek9wSFFa?=
 =?utf-8?B?azhIYjgxZGF1T0JicGd6SG1WQW9rTWNwN0ovTUQxcllSN01xbVZjNXhqK3F0?=
 =?utf-8?B?ZGF2Q1V6T1hrQ1VidVFhZllpSVJuOG5kK2dCSU5qRlZLZ29qNGJtaHpEL3dw?=
 =?utf-8?B?ZUdrdXZXZXcvdFZhVTlWVWUxdGtMVlBsUFp2Uk1HMXpxRFBIb3J1aTZ4a0Y2?=
 =?utf-8?B?NVRsL2cvd2dWa3VoZEJBdmQzOFpUOG1PbDVhTVE0UGRmNzlLUWkySFVXclRE?=
 =?utf-8?B?L0NyUG1VaWZaM095bWp2akpLcHkvQUY1WnlCNHM2MWlDWjlaRU5hU29qVWpG?=
 =?utf-8?B?WGZKQjZSSURxbENLcG1CVXpkd2hnSGZCbkNOcVZLUlNuTXdzNU9vMHl4U1kw?=
 =?utf-8?B?ZTd5T1h1ZGVpdjRIR01CemNHVVhxT2cxayt0M2c5T0FidzlYTWZFTGVUbWtZ?=
 =?utf-8?B?NE1YKzM3dUtieFFYUDArM1Z3UVlyV0VWSFNaWGxIcUN5Q01wKzhZUHZOcHo5?=
 =?utf-8?B?WEdIVDlMYlZLSGVRUTN1TlNDRDhEdVc5SjhPMEJtR3hVakRhckwvbDRPcFZJ?=
 =?utf-8?B?dXJXQ3VqTUFpZVJWZ0ttakczUXNCbVZPQmFvTFFWWnBWNHJxRXFvdG9qSG11?=
 =?utf-8?B?NWNCZitHOHUyQ2FUaUNxNmRpdjlkZTJYcE1xYS9qQVEwNGxWbkFOZTVkV0Fw?=
 =?utf-8?B?c0Q5M2pOamNQVzJ3SngwL2FKaFZ2aXhDUzEydmJ2dHNJZXcxTDVRZWRmd3dD?=
 =?utf-8?B?Q1QzVkNPZlJSYkc5R2FCUTR2L2p2NzVhR2NDQlk2SGdQVzNxR2UxQzdOUEc1?=
 =?utf-8?B?blgzZTgyUzYveHZtM25DZEh5RWF5RVUrc0FYQ3lmOXk5MVJ6T0tnejNNemcr?=
 =?utf-8?B?NW0xVXdzM3lMNnMxUklKaGkwOVd1K202Y2ZEUXpoM2lOazB4a3pPaExFUFlY?=
 =?utf-8?B?blFHdUs5eVUrSUlOL3dKK3h0L1N6WmgyUG1hNGZKeUFyQmljWlVySVBVVGll?=
 =?utf-8?B?Rk1KVVVacy82UStQdG9ZK2RTNy9ObFNNb3JWS0gvSDZJTXJ2SWJpWi9ERDlU?=
 =?utf-8?B?L1pESWlHb3VwcVgzbThSMjZKSjk1WGxNL29BU2xxUTJSU3BnRnRhZXZwMUtk?=
 =?utf-8?B?NVJBaS91SUdkUUhDU2dhVm9SSGJsN2pubC9LZjh3RVJtRkloOS9wM0lKcVBw?=
 =?utf-8?B?RUk5YnhiWHhWbGxLcW1nQjB6dWlZQ2Ziem96M1BBOG1GcTJUQTNFc04zNXVr?=
 =?utf-8?B?QzZXNDBzZGp2UXE2UDJURkN1ZFRXblJFYW9HZ09BZWwxVzZRRUdmNmtxY1Vh?=
 =?utf-8?B?OUc2RFplUjlNUmJiTnhXVDE0SWQxRmpOQ2FzTFRKdFN1M0EwYzliZ0NqRE5z?=
 =?utf-8?B?aVRnSHNqeVo1cDYvMGFKU1dLNHMxTTQ0N1d4ZUdyNlg1eFkxVW9GRXcyc2tJ?=
 =?utf-8?B?d1V1MVRtZ2wxbEdoQVE2MnExQkVabHFLd3lHSWNTb1g4UmFKYUJ1SXdpTHVY?=
 =?utf-8?Q?PdQHZ9k3ewPaTGbN4jUH7ikPe1UDwXQi?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR07MB7455.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dlhnRVluU25QM2Z0QzNnRWEzSTdrZjdYT2RNSEFPNUVlZW8yVUd6WFd6Rmtn?=
 =?utf-8?B?Y0FQcnB2N1JNQ1c0RGwwMWRXdlgydURRMHEwU290QzJ5L3VQdVFESEJpSDhV?=
 =?utf-8?B?R0hsaHVzM3RNRXRVeHVCWWRHZHVIR1lEWXp3L3lPcFN6dDRSRXk2blV1Qmxy?=
 =?utf-8?B?VHRRelhjcTMydGZ3Tk5PZlI3eVBhRmpndWc4amxuYjI4VTUvZnhPckZWaE9Q?=
 =?utf-8?B?eDV3VlNpa21nWTJUU1N5SFAvelF0OHlobCtoaHNaaHlJNTAyOTdFTExPMkhH?=
 =?utf-8?B?di9EeG5nQUpPWkY1RDF3Z0VueW9qa2hNalM0WS9SSUtuSVVmV3dkZm5DYmsx?=
 =?utf-8?B?OHdXaWN6REVyVyt6YzR3ci9CUno2U3VSaEZkSmx3V1ViT2VmR3M4UDV6QVdn?=
 =?utf-8?B?RVJ5RG43UXQwSFRGS2xGZFFVSmlFS2JuVWpzSk5GTThOR2NTUW5rUnUyeEJh?=
 =?utf-8?B?OXU4OWlQWDhnUUttZ21PQXY3Y1I1NUpQYVB2bFBVeEFJYmp6NGlyQjN5aldY?=
 =?utf-8?B?UStoUEV3VTl0OEI0THN2NjBhcnZZeTluSXluTm56OHRmK3RkbjgwTXpkYVZZ?=
 =?utf-8?B?Z09HamJSWkExY0tYUWR4NmJBbGUwM0RZL0ovcnpRdjFIQjNwTk9EVk1uMXh1?=
 =?utf-8?B?ZXZKNzF3SUJPOGlaVXZYdGhIalR2ZmlPdlkyVlZXY3NMZE9MU0hBQmRjdW1r?=
 =?utf-8?B?N0hPOEdMQ3pTdzlKVDFFdUFoc1ljcmNtUVdicHJPUVdCaSs2VEJqalVPU2FC?=
 =?utf-8?B?NVNYYWFUQTJZSDVQWGhNS0w3cDJ4ZFFjL3cvRnhUZzQ1MGVFbjhBb09HalFV?=
 =?utf-8?B?OGNIRkpseWRCeFkzMWpOckpod1ZEUnZnMmRpT0RrRDlGc1dLQ0gweEVDeEY5?=
 =?utf-8?B?R3U0eWZPaFhhbWlTTFVGbkdiL0tDelhaRDl1RG01WU9Ra2FQdUhFRVVZclk4?=
 =?utf-8?B?dldGd1NwcXdQM0czbHlPb3VhY2VVeEhiR1VBZjFUaW9CVVluSGF6dTMza2pt?=
 =?utf-8?B?S1ZBUjRnUUpQbW54eXV5eGNkVVh1U0s1dDNlWlZlczM0dHRUSnlNOWppQ1B5?=
 =?utf-8?B?cXM4V3IrVHJyUVNUdVhhbVpERHZXZHBzTVdHOWllVENsaWdqT04wa0xlNUo3?=
 =?utf-8?B?SGNOSWVFUkJhdElOVlNWR1NGeHRpSzhVK1Fmc0hONUNObzZCRlQvNG5ObEk1?=
 =?utf-8?B?aHcrek5YZHV3Z1RLVy9HNEN5REFZSnlraWFVSWpsMjhiekxlZU5OZHVNZGtN?=
 =?utf-8?B?VTM5blBrUmV5aHFKN3o0blRic1ppNDAyZ3c5K3NsVnEwTFI5MFB5K1cxUG9C?=
 =?utf-8?B?QjB4WUs2RG13UGdPOGtoN1dobHhhZGl1QkZvbmlmaGNKZlJYVlBQTDNaa2pq?=
 =?utf-8?B?aHpQN1JPOUMzdlZpZ1BTanhSV0tRV20rOUN4a0lUVzd4TDlvSjdpNmtOVlNK?=
 =?utf-8?B?K1poV0Z1aGNUUUV1VFAvL1BqaHRWampyVVBpQ09Xa1BmVjdONDgzQ01jYkkz?=
 =?utf-8?B?NXIyUmxlankrOEUzQk5JekJndGJvYWFrOFhVdUxlS2ZjNktUV2pqSi9LVDVl?=
 =?utf-8?B?UHZScVRrSGlnUFd3cU0xNHplU3ljalkzNGxjWWV5WkdkdU43V0pCUVlaY0Nl?=
 =?utf-8?B?SmxJREIrZm1QQjhnMXQvK3cybUtndmZPYVNOSnVzU1FwaTFuOXR3YWo2NUta?=
 =?utf-8?B?TlluNGx0MkJPQ0hlYlBETUVUNDBZYStzcGtHb1dhaVJVVFZSSXZhMTQwZjVq?=
 =?utf-8?B?eWJ1TWVmd2dkVXAycWlhSGQxY1orUlErbVZtWlBoMklJc25ZV1pmQXFoZlZX?=
 =?utf-8?B?NVNpQndlVTlIVUpxZEZQQXBYakw4c1RiU08zMDUxcmdlSGpnRDdHaUhiUklm?=
 =?utf-8?B?dVJERy9NVU9iem4yZWt1a0gyK28xcENpNmpyY0xrM0VKVW54bnVwOEQ5c3pt?=
 =?utf-8?B?aDRDeUo5M0hGK29YM3dXSTJGUXNtdWJmSzVQNWxFR3FSSTgrajhsQmJiZ2xM?=
 =?utf-8?B?VUw2Z3BEbTZwaTFIWGoxWGJhYWs1UTNhYmVkRkJzdHR1VWRzalozaVc5cVJh?=
 =?utf-8?B?Qkt4VXpXUnRiTjZ5QXh0WXdGYmgySHo5RU9tR3VjVEg2TkdRY0dVdE5MUnhF?=
 =?utf-8?B?TC81WTZLRU1CMi9HTGJVczlKOGdWR3RJUEVzMkJYR3FRQk5MS3ZXOG5iTklu?=
 =?utf-8?Q?ostCVC4X50ZucpF9qIvxNkc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F7D7DD7166234949A5178134762653A0@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cs-soprasteria.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR07MB7455.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa59d417-63ba-458b-bb31-08dd1b478a4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2024 07:27:03.2642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8b87af7d-8647-4dc7-8df4-5f69a2011bb5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iYaECwIX2PddRGv7phiqsaPALMYISHNVD/irhNop6RKv8y87bYiXHZK47leYOKYKe7Akmbxu6a0Llf4lTn00NU6iBgDW8ovxnO39S2zJtROa2CKbZGWLeUvxV/V3XwOx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB9111
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 04
X-MS-Exchange-CrossPremises-AuthSource: PA4PR07MB7455.eurprd07.prod.outlook.com
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-messagesource: StoreDriver
X-MS-Exchange-CrossPremises-BCC:
X-MS-Exchange-CrossPremises-originalclientipaddress: 88.124.70.171
X-MS-Exchange-CrossPremises-transporttraffictype: Email
X-MS-Exchange-CrossPremises-antispam-scancontext: DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-processed-by-journaling: Journal Agent
X-OrganizationHeadersPreserved: AS8PR07MB9111.eurprd07.prod.outlook.com

DQoNCkxlIDExLzEyLzIwMjQgw6AgMTY6NDAsIEZyZWRlcmljIFdlaXNiZWNrZXIgYSDDqWNyaXTC
oDoNCj4gVXNlIHRoZSBwcm9wZXIgQVBJIGluc3RlYWQgb2Ygb3BlbiBjb2RpbmcgaXQuDQo+IA0K
PiBIb3dldmVyIGl0IGxvb2tzIGxpa2Uga3RocmVhZHMgaGVyZSBjb3VsZCBiZSByZXBsYWNlZCBi
eSB0aGUgdXNlIG9mIGENCj4gcGVyLWNwdSB3b3JrcXVldWUgaW5zdGVhZC4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IEZyZWRlcmljIFdlaXNiZWNrZXIgPGZyZWRlcmljQGtlcm5lbC5vcmc+DQoNCkFj
a2VkLWJ5OiBDaHJpc3RvcGhlIExlcm95IDxjaHJpc3RvcGhlLmxlcm95QGNzZ3JvdXAuZXU+DQoN
Cj4gLS0tDQo+ICAgZHJpdmVycy9zb2MvZnNsL3FibWFuL3FtYW5fdGVzdF9zdGFzaC5jIHwgNiAr
Ky0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL2ZzbC9xYm1hbi9xbWFuX3Rlc3Rfc3Rh
c2guYyBiL2RyaXZlcnMvc29jL2ZzbC9xYm1hbi9xbWFuX3Rlc3Rfc3Rhc2guYw0KPiBpbmRleCBi
N2U4ZTVlYzg4NGMuLmY0ZDNjMjE0NmY0ZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9zb2MvZnNs
L3FibWFuL3FtYW5fdGVzdF9zdGFzaC5jDQo+ICsrKyBiL2RyaXZlcnMvc29jL2ZzbC9xYm1hbi9x
bWFuX3Rlc3Rfc3Rhc2guYw0KPiBAQCAtMTA4LDE0ICsxMDgsMTIgQEAgc3RhdGljIGludCBvbl9h
bGxfY3B1cyhpbnQgKCpmbikodm9pZCkpDQo+ICAgCQkJLmZuID0gZm4sDQo+ICAgCQkJLnN0YXJ0
ZWQgPSBBVE9NSUNfSU5JVCgwKQ0KPiAgIAkJfTsNCj4gLQkJc3RydWN0IHRhc2tfc3RydWN0ICpr
ID0ga3RocmVhZF9jcmVhdGUoYnN0cmFwX2ZuLCAmYnN0cmFwLA0KPiAtCQkJImhvdHBvdGF0byVk
IiwgY3B1KTsNCj4gKwkJc3RydWN0IHRhc2tfc3RydWN0ICprID0ga3RocmVhZF9ydW5fb25fY3B1
KGJzdHJhcF9mbiwgJmJzdHJhcCwNCj4gKwkJCQkJCQkgICBjcHUsICJob3Rwb3RhdG8lZCIpOw0K
PiAgIAkJaW50IHJldDsNCj4gICANCj4gICAJCWlmIChJU19FUlIoaykpDQo+ICAgCQkJcmV0dXJu
IC1FTk9NRU07DQo+IC0JCWt0aHJlYWRfYmluZChrLCBjcHUpOw0KPiAtCQl3YWtlX3VwX3Byb2Nl
c3Moayk7DQo+ICAgCQkvKg0KPiAgIAkJICogSWYgd2UgY2FsbCBrdGhyZWFkX3N0b3AoKSBiZWZv
cmUgdGhlICJ3YWtlIHVwIiBoYXMgaGFkIGFuDQo+ICAgCQkgKiBlZmZlY3QsIHRoZW4gdGhlIHRo
cmVhZCBtYXkgZXhpdCB3aXRoIC1FSU5UUiB3aXRob3V0IGV2ZXINCg0K

