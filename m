Return-Path: <linux-kernel+bounces-187224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0F48CCEC4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CD691C21F32
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD5E13D257;
	Thu, 23 May 2024 09:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="DCAOMyk3";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="DCAOMyk3"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2087.outbound.protection.outlook.com [40.107.13.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C1913D277
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 09:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.87
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716455207; cv=fail; b=ujzHiNzt8jMKiqS9kA2gWqHUJeIeUQ4jcSGwPnNYPW16YfT/ffOvUQC56ssTh5v2ybiPMwnEG4dGooGE3lt3/Ll+8gyRQvsFJufL3qOgnQJptQluIREB4AOt2xO0prsAs5JC1Fa4IdC3FLy7ML1KXPEcHU/cjktyrU1WXmDtUq0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716455207; c=relaxed/simple;
	bh=1CsEgtsEkRYfO0GDKyIblOfCB4aOQMJ22A6Nz9diG9k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sLCIiosL/0zy0Or0zQtWPZf5wTKzbNej+Y3E9DmkWHqtAbDmg+c+U8Y+qZ6CQ0FVeF4ZwC5NLthahDbRF4tb0dE5RQPGVgLp/05KNnoVZ25GMPQDtdAqzGC2tBeY6RXqSrHzbAhlCQ5jChTgPKBON8Q1vE6jUWAitF6D3SyCkcw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=DCAOMyk3; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=DCAOMyk3; arc=fail smtp.client-ip=40.107.13.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=W2p9fL1t9fjgAGLJBsOIpwa5h94KY6HqSRyjR2eqC7t8ul+fffHNG5Il2u8pBfK8g8tTk2C4yVngTtK4m+GJ8l1s+yYOkK3vjLh2tdE1fs5rZ1UNFhH2STd+SEcnzKAne32ylvJRmNbHrmx5r9TWEpburu4IFlNaBs2K9jk33FHNP8cTCLrzpzO8ZysMQJRvrRl0q1gg7Jel2eOAV6p7aQeudLV7TsFrNTUGqDSSrCI9aqg3v9BRznHzyjAmqQhk2uXAU/pk6NAdFeFTaV+QsGSnOMRbzHPAhBT6IzjFIMSZtV0qS7KwkbDFz5Sc7Qf3sN4Vp77zixUpNKVapQwVyw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4+c7Nl+ZX3wXj5S17xlQS2879IijlYTxShGu9rvRSU=;
 b=aYPbpMI9ewY7w2qPtoZF0nXoyokiPihKmr0j91qYneOW+6oR8p3Vdc4+h+APT/nR0jiJObph35XGWV6H8VmdlNvxABvHTagZYWaMgEfaAC28LtucHtS+XuWvv/RZWlGZi74S5/zztSeQmod2OJZZvYl4QE4dAHiktEJ8OYHM+58bccUqbum4PuE2rR9k0zI/1mbbGyx8VplGUPEMlR2Ea0AgAiYaIejTzWCJ8MSLPSnm4LXJ+0+MpCooA6GpBah/buUmCvP6z7ogTIBC1gVK3QRCUEWRk/8H8AKt6v8MZYv7Eds39v/ehGKjYev/5gm+IMvgbb8ewNp38p+mzTsGkg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4+c7Nl+ZX3wXj5S17xlQS2879IijlYTxShGu9rvRSU=;
 b=DCAOMyk3McT7LiI1UC6UV180voJjb5sotJAFhT1+YgyDHcz0TRBMtmrBzGq8N8C9A/HHtOIW4LTmsPjjCZnhi193+8Yvi5BMD3ZJ8oNccgaaRpCXV+lRl+llEdgmF8xAeh1VgA9qcEykxpWXYBjdgqhxOJPr6rNZMv2Kg3t/WR8=
Received: from AM6P194CA0045.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:84::22)
 by DB9PR08MB7424.eurprd08.prod.outlook.com (2603:10a6:10:36f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.40; Thu, 23 May
 2024 09:06:31 +0000
Received: from AM1PEPF000252DF.eurprd07.prod.outlook.com
 (2603:10a6:209:84:cafe::a) by AM6P194CA0045.outlook.office365.com
 (2603:10a6:209:84::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22 via Frontend
 Transport; Thu, 23 May 2024 09:06:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM1PEPF000252DF.mail.protection.outlook.com (10.167.16.57) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7611.14
 via Frontend Transport; Thu, 23 May 2024 09:06:30 +0000
Received: ("Tessian outbound fffbb209f6c2:v327"); Thu, 23 May 2024 09:06:29 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 9257823a9fdbc809
X-CR-MTA-TID: 64aa7808
Received: from 1e7f5378556f.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 1F627686-2571-494F-8AD5-72366FF2E72A.1;
	Thu, 23 May 2024 09:06:21 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 1e7f5378556f.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 23 May 2024 09:06:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QwVXkkpkb2DXSyLTgDUy2Btyqmmj1pQZ9ApKcZsVeJB+nBNLaLb170lKGmXdwOTLJLIM65VDKc4vnmoewE6UhTtVQSkTaiXIencQiK5+3zyofpSYG1imz6NAMzaVtgpwLA6VpiUPMZ1aFvmDbRoLUaNj6meR9n0H1HJuGgl5w+54FrvzDzBiSYqYyp/MTpfXHHviNpq6yGNSpEjKKJGAvqSlaPbcrak8e2xcAlqGE347Q62lTWQ8+dwA+KL7Xj9Vy4qmnbiAKFV26xHdwRLzOXIZwVpAcWhNOJCTn1LvmPa8V1Ypb9fxIgwP3DWLUa8MEDe2d+hgdReG9q1LFgdRkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4+c7Nl+ZX3wXj5S17xlQS2879IijlYTxShGu9rvRSU=;
 b=fVddymNrdFeEnCbr5n5jTYD+iWqTOgeVaDLSSm6m9hRnJwJ0EHJBR9wcqADgXx4apD/PD/izWjbIdyIZWcab1O3RW/PbUvpTwhpNaZqFZYyXVZsdMArjQ3yOsl4RL10VYR3oEyDcHo1BRudpaVnhpOXxXycoic0wmNk70q2a7hoIHYHLKGyoWL3feVou0TfYWH7fkh9D3pNc9+wdF9tQiRjREeaECCS2hbzkngdITrMuRgKN4XVjrZAKxX2OOJ8TuUONVf/eRdtGLMLrKwx5tcEHF+URi7Ifllo+vpUxvjYQ2SGpCyTr03hIuDAsFy8skecX14LTwh/DenrKGJhDog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4+c7Nl+ZX3wXj5S17xlQS2879IijlYTxShGu9rvRSU=;
 b=DCAOMyk3McT7LiI1UC6UV180voJjb5sotJAFhT1+YgyDHcz0TRBMtmrBzGq8N8C9A/HHtOIW4LTmsPjjCZnhi193+8Yvi5BMD3ZJ8oNccgaaRpCXV+lRl+llEdgmF8xAeh1VgA9qcEykxpWXYBjdgqhxOJPr6rNZMv2Kg3t/WR8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3919.eurprd08.prod.outlook.com (2603:10a6:803:c4::31)
 by PAWPR08MB9006.eurprd08.prod.outlook.com (2603:10a6:102:33f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 23 May
 2024 09:06:15 +0000
Received: from VI1PR08MB3919.eurprd08.prod.outlook.com
 ([fe80::14e2:874a:b20b:78e5]) by VI1PR08MB3919.eurprd08.prod.outlook.com
 ([fe80::14e2:874a:b20b:78e5%4]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 09:06:15 +0000
Message-ID: <e4b472c9-ad8b-4423-81ad-02a1ab231f95@arm.com>
Date: Thu, 23 May 2024 10:06:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH 08/10] sched/fair: Implement delayed dequeue
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
 linux-kernel@vger.kernel.org, kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com, tglx@linutronix.de, efault@gmx.de, nd
 <nd@arm.com>, John Stultz <jstultz@google.com>, Hongyan.Xia2@arm.com
References: <20240405102754.435410987@infradead.org>
 <20240405110010.631664251@infradead.org>
 <3888d7c8-660e-479c-8c10-8295204e5f36@arm.com>
 <1461277e-af68-41e7-947c-9178b55810b1@arm.com>
 <20240425104220.GE21980@noisy.programming.kicks-ass.net>
 <20240425114949.GH12673@noisy.programming.kicks-ass.net>
 <20240426093241.GI12673@noisy.programming.kicks-ass.net>
 <c6152855-ef92-4c24-a3f5-64d4256b6789@arm.com>
 <20240523084548.GI40213@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Luis Machado <luis.machado@arm.com>
In-Reply-To: <20240523084548.GI40213@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0213.namprd04.prod.outlook.com
 (2603:10b6:806:127::8) To VI1PR08MB3919.eurprd08.prod.outlook.com
 (2603:10a6:803:c4::31)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI1PR08MB3919:EE_|PAWPR08MB9006:EE_|AM1PEPF000252DF:EE_|DB9PR08MB7424:EE_
X-MS-Office365-Filtering-Correlation-Id: 81914455-1a60-4b8c-05b1-08dc7b07a30a
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230031|1800799015|7416005|366007|376005;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?WVRDR2VGYi9Kb1d0b3NjbkRJTjNVMCtKcHlnNUVFaXJLeFlxQk1iazBMOFlG?=
 =?utf-8?B?aW9BTFlqejUrdTB5c3gyakFnZEcrUEFHZ0s5VFVnRnlmNXBINHJldHBYY3Ft?=
 =?utf-8?B?VjdTTERTMHZXVU5pSkprMkE2VXlGWHNaVm9rQVhBSFlLZW05TkZFQ2tlTFJZ?=
 =?utf-8?B?QXZZOHRVQVUybERSQnpkVWl4K3Z3cUY2SXRlQVAra2FZWUtoWExORG5MZUpk?=
 =?utf-8?B?akxqL01FL1FOY1psbE9DR09ITHcwY21vRFVCQ2dpK0pCeXdJalorV2VPV2RN?=
 =?utf-8?B?S01tWnBYNmJkVXVHQlk5MXVFT3hLcUlyS3AweDZTMlhPWjc2NTlJWGU2cU9N?=
 =?utf-8?B?QmVYdUtKdS8xMHprb3ZhQktPT3lMbEZWUHdnMHJtdXNoSmxrOTZYdTVXWUZV?=
 =?utf-8?B?OGFtZmVqbmFOK1NuNFE1QjdqSEIzRUdFcVVIY2Z3bk9TV0gvcmk4eFpidlhK?=
 =?utf-8?B?WVo0cHlYY2p1blVQTllhNzltV3BIUzY3bGZZNXB6SXZhOXNIbUhKMmhiVXBJ?=
 =?utf-8?B?ejhUWFdDclY5V1NRVENKSTZrTUJKVmp3M0ZvVW9IRFdyOTdGTmdDZXd5ZjRT?=
 =?utf-8?B?WXdON0loUmsrelBFQzdKRzRWNXhNV0x4M09xNEwxS0MvMEh4dmdlNmZRZ3VN?=
 =?utf-8?B?OHF5b25MWWt1cHJJMGRYcDZDQTVmOUZnaFkrK2lBelhJS0tHZ1JMR04wVTRx?=
 =?utf-8?B?SlRqaHl2QWYwUlpEUGFReEd5NVRVdGk2ZUVCcmpURnBEY1NwVlNIN1c0RG9s?=
 =?utf-8?B?a1puUlRmK3Q5WHMzYmM0V0ZzV2tsSmtCRVJOSFlpRmtBKzNnQ1czVzVUbEMw?=
 =?utf-8?B?Q3BicUVJZVo5SzhsWkZjZmFQRHVXK2JkWUxSdmRZRDFnNjZxbTdUcGJqOC9W?=
 =?utf-8?B?K2c4U25OamxMMGlBWGJpcHlWUEEzVHM4TGNYQzcyYkp1ZXZ3WWdHNnQ3MmVZ?=
 =?utf-8?B?NUVFTnJqUDRpK3F5T3dOdy9rNmpvOVhkdlkrQm1wdjdyQWdQZms5dWQvaXdv?=
 =?utf-8?B?M1d0ZHBPSGZ6TWdMQmFlVzBqN05vdVN4b04veFdzMXRLOGIzbVI1UTZyS3Rw?=
 =?utf-8?B?RWY1bjVmWlNCbG8rUk9oZUdzd1J6WTBHRlJCVFJjOUNiZjlsQjlmckNPZUc0?=
 =?utf-8?B?bDFORGllTmhZNlJvTXl5bEh3ZVNUSDVRZzRDTUEvQjR0Q2ViQ0NFenVhdVl0?=
 =?utf-8?B?SzY1RVNQVHNONDZZdTFjVDZ1cTljekQvaFpDSlFnSE9Cc3p6clN6Rk1Ebmht?=
 =?utf-8?B?MC92RUYxcHRGaUF2QVNNSlFPK21ZbWxncGo2bHBnMGdQTU5sU05tYTZyZU9T?=
 =?utf-8?B?dVRKSXk0eGVBaDNYSDBJczNIZEZKL0ZZUWlVSXhySDFEaHI5Rk5XSU1aQ0lp?=
 =?utf-8?B?Y3dNcWZJTG5BVnp1dDh3dVlEREMvRFpaanVReXpza0w3dmtUeDEyOHBDQlRt?=
 =?utf-8?B?ZVhwbjdYU09vQWQySjFyT2dOdFhsNlpjTjNSZFo0RmdmU0VYdGs1ZkhqWmtN?=
 =?utf-8?B?N012ZjU3NGNOVHMwdGtiZC93NmZGSktRaHd6eXA3TkZYOGQwNkw2WlBJL0VZ?=
 =?utf-8?B?UDk0UFh5bmNnTndib0pEK1UwNFBKQ1IxazIvdWQ1RENYbVRjOW5PK0tkbThD?=
 =?utf-8?B?SlRyazJOR3BFNmx5dTJ4MnJxNDJIWnJ4N0xZV0J0eHBMQVVQRjNVVytHdk9E?=
 =?utf-8?B?S3VsSzlGREZ6ZEdWVDh4aVFVbnJUcXZuZmxXUUxQZExhTXM3eGI1dFhBPT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3919.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9006
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM1PEPF000252DF.eurprd07.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	65664b52-d616-4c6c-699e-08dc7b079973
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|35042699013|1800799015|376005|82310400017|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YlZBTEx1WXA5ZjFkRXRLS2Vac09BZENBbThzR2xCVk03VFN3SVVOeDAwQWJT?=
 =?utf-8?B?NGdKdENjTldzNGRKTVVaZGNqT1J5OXo0a2g0SCtJMG1iYWlrbXY4UUlIdVBW?=
 =?utf-8?B?eXBicm9BYzRZbDcxSTc3TWsyTm50b1lnWk0xS0Y3RFBhYk16VCs0ZjlUa2FK?=
 =?utf-8?B?dWZvcVJqWC8vOWQzTy9scHFkcXpoRHk4OG5MWWwxenhGaUlHZEdMQnZZbWJF?=
 =?utf-8?B?Y0ZPYndUMnFrZi9kV3Q3cmpzVXdiK2FzMjcxdGZLb2NRbndLdExMTmk0eU15?=
 =?utf-8?B?VzZaR0VZVGZwcWVWalVFR0orcThDR3dQVzlsYitWZGl2cnBEd2I2UHdEa3Mw?=
 =?utf-8?B?WnRsaTZnbjRzWitUZmY1OGZkbTdJSEh4Q3hBc0VnUjdJZExiRWMzMlFYKy9y?=
 =?utf-8?B?OXZBSnRYTEJTOHkwTzlpc01iVE5KQldlWkZQVlZqbFBwYUxKK08rU2dCcGdq?=
 =?utf-8?B?VUh4bDBRUlQ2VnRmNnZLQVYxYnUrS2dSbSt0OHJqN3JBM3g4Z1h4dGRjR2pM?=
 =?utf-8?B?cUVTRFJrMWF0dGY3ZVNWNVpodk5OY3VLOXpVWmJWRFh6YWp3NC9JRTdEQ2t3?=
 =?utf-8?B?WXNxRUpCUGJzYkxuSGthM1R6ZTN0WmFkTUZWcjJLd2t4WWxSVEcvcVVIdERQ?=
 =?utf-8?B?SStEZXUzVE8rVG93SnE1b2hJTEJidmZoSndzNTdrSEJWMS9yODFNUS94SEw2?=
 =?utf-8?B?cyszNTdkUWF1L3R0WTNJL3N2ZU96SVhWYU56RTBhVldCU0xEVDRySkx2YlBL?=
 =?utf-8?B?K0lmYmk1RStkYmFCOFh3UWJKSVM0WVJybS9abmV3OXdqL1YweHJrd2pXWEl2?=
 =?utf-8?B?Mkd6SXA0NnVkZUZPbW9EWlp5TUttTGZRL3pjbXI4a1lQMmxkZWtJUW9iV0V4?=
 =?utf-8?B?S3lsRjdSQTA4YTZDLzQyZFdtQjZtN3UvbTNaYWtRUllSSzhvMkcvOUJ3RlRP?=
 =?utf-8?B?N1U5dHVyN2dpSTdtR2NmZVMwZEMzRDZrMGRURzZmRWlWZ1ZwYkErMUNPcW15?=
 =?utf-8?B?cy9uMnY5eGg4ZlhzU3RvbVlVc3NnMHFjVVJXTUpBODFWcnN2bzNFQ1RrSkNq?=
 =?utf-8?B?TXRnc2tFaVV5elZrS0w5NXF0VVNvVDhjZXRlMjhXNVd2cFdxcmw2RDlzTGQ5?=
 =?utf-8?B?Y1paNXA5d3dSY3dBeXBsMFE3eXQvQmRReW5WUEx4aWF3eHRSRk1wTzJQUnhE?=
 =?utf-8?B?OUZ2Y0xteHJTWk9zN2pZcTdGb1VzZFpqS2k5V3JpaEJhOUk5SVNWUG51bUVi?=
 =?utf-8?B?empMTUVBZ0oybmFsWTNUbjRBNWEzcDlRNVBjSnYvYkYwWGNmQTZMUGE1N1RS?=
 =?utf-8?B?UkI4elBIQ1VJUFJaMDlHZmZDMmFmbUVjcHdLcmRLQzNIMjBHejdOSVYwQlo2?=
 =?utf-8?B?cVk2Z2V2MFEzb1BUVFREMjVuTUh4QXpacE9JMVJQWUhIWE5Xa0djaDVnY2FV?=
 =?utf-8?B?MzA0MG9nL0d6K0FJektUemM2RjFNdE5MTnVkTUFXM1Z4ZUoyMU1qMllUVWc2?=
 =?utf-8?B?Y1FPcmRTNzZ0ZUVJY2NPRC94dUtybnJXc0F6eWszUUhLdEF1d0szeklyWUNo?=
 =?utf-8?B?T3QrbTBFVjQ3QzArdmI5QzZEa3RJT2FSYTRuVHUvcDc4VHBlQWNwcmNrbVFw?=
 =?utf-8?B?elVRTlkrSkU0bzllTFl0Qlo3b2xXa0JZaERPOWZmVG5MWWRtWlU5VzVPaU82?=
 =?utf-8?B?c3dPejZibkdUZTNlUklCaEk4L2xWSUhiVjlXSHZrVVhNR3pXZjJrY2lJT09t?=
 =?utf-8?B?Z1ZFczhjYVpEWk02KzlEdUhDaDFEUDlSSU9Uc2cyeDF5V2ZHdFNpU1dMbGZr?=
 =?utf-8?B?L1hiQTJFeDRMOEFJOWNGbVZVTVJPK2w4NVIvbFlMbmdIZTlKNWJ5R2Q3b0Rl?=
 =?utf-8?Q?EEw+eYL9ZLvh2?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(35042699013)(1800799015)(376005)(82310400017)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 09:06:30.6192
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81914455-1a60-4b8c-05b1-08dc7b07a30a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252DF.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7424

Peter,

On 5/23/24 09:45, Peter Zijlstra wrote:
> On Mon, Apr 29, 2024 at 03:33:04PM +0100, Luis Machado wrote:
> 
>> (2) m6.6-eevdf-complete: m6.6-stock plus this series.
>> (3) m6.6-eevdf-complete-no-delay-dequeue: (2) + NO_DELAY_DEQUEUE
> 
>> +------------+------------------------------------------------------+-----------+
>> |  cluster   |                         tag                          | perc_diff |
>> +------------+------------------------------------------------------+-----------+
>> |    CPU     |                   m6.6-stock                         |   0.0%    |
>> |  CPU-Big   |                   m6.6-stock                         |   0.0%    |
>> | CPU-Little |                   m6.6-stock                         |   0.0%    |
>> |  CPU-Mid   |                   m6.6-stock                         |   0.0%    |
>> |    GPU     |                   m6.6-stock                         |   0.0%    |
>> |   Total    |                   m6.6-stock                         |   0.0%    |
> 
>> |    CPU     |        m6.6-eevdf-complete-no-delay-dequeue          |  117.77%  |
>> |  CPU-Big   |        m6.6-eevdf-complete-no-delay-dequeue          |  113.79%  |
>> | CPU-Little |        m6.6-eevdf-complete-no-delay-dequeue          |  97.47%   |
>> |  CPU-Mid   |        m6.6-eevdf-complete-no-delay-dequeue          |  189.0%   |
>> |    GPU     |        m6.6-eevdf-complete-no-delay-dequeue          |  -6.74%   |
>> |   Total    |        m6.6-eevdf-complete-no-delay-dequeue          |  103.84%  |
> 
> This one is still flummoxing me. I've gone over the patch a few times on
> different days and I'm not seeing it. Without DELAY_DEQUEUE it should
> behave as before.
> 
> Let me try and split this patch up into smaller parts such that you can
> try and bisect this.
> 

Same situation on my end. I've been chasing this for some time and I don't fully
understand why things go off the rails energy-wise as soon as DELAY_DEQUEUE is
enabled, now that the load_avg accounting red herring is gone.

I do have one additional piece of information though. Hopefully it will be useful.

Booting the kernel with NO_DELAY_DEQUEUE (default to false), things work fine. Then
if I switch to DELAY_DEQUEUE at runtime, things start using a lot more power.

The interesting bit is if I switch to NO_DELAY_DEQUEUE again at runtime, things don't
go back to normal. Rather they stay the same, using a lot more energy.

I wonder if we're leaving some unbalanced state somewhere while DELAY_DEQUEUE is on,
something that is signalling we have more load/utilization than we actually do.

The PELT signals look reasonable from what I can see. We don't seem to be boosting
frequencies, but we're running things mostly on big cores with DELAY_DEQUEUE on.

I'll keep investigating this. Please let me know if you need some additional data or
testing and I can get that going.

