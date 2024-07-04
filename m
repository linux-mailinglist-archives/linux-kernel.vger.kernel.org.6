Return-Path: <linux-kernel+bounces-241017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA409275D2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 14:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CCB0281C72
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 12:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4BC1ABC23;
	Thu,  4 Jul 2024 12:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="kEmtz3af";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="kEmtz3af"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2085.outbound.protection.outlook.com [40.107.20.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDE725779
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 12:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.85
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720095661; cv=fail; b=Caw9KXPIVwi+EXY2CpEL3rj5yB9dyRkGBbxGcUWDG/cx0QrkvDOlDahGj+QTTzj6tE3ssvX+CYIihEe7Rii7VbtrgKwbRoBoOYZeFZkkI5lEU9qrE5rsr1noEXvw1tDd/h7cLkteUpxRmxsed/4j+paSIZnaXeHcqlfYpU3mL30=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720095661; c=relaxed/simple;
	bh=YPTFivLnAKBSqng0g3zAjmo7qoN/YB7ZbbzSXoS2BNo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pLoa11Ip/DgYFU1ho2PrjFaFwBB0dUffrK60hfM/1OfXTbEvJ0AjYaknbz87YlGtbDAgbvKWx+VETmQjvs3hWv/vJnKuk85FtV4cIp3QOaHX8yzhcyeDEeYjNz9ej5bm8CRkIlwDh7vjpg0xXyevNWRQ78nu8y29jZ84tuiLFD8=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=kEmtz3af; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=kEmtz3af; arc=fail smtp.client-ip=40.107.20.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=UFssArah1im++nXKpydU2xyr0DzrbYuW5/g1+d3ezPPDHUVKGCa8MKMp8/xFQdDYZUfs/h/aS51GUCT42wSSvdTAXEUjwOuupsEAcd+fMSvVyOILCt+SRsxkAJkBPaMcNZGX2QLmGWZzT9PiDGPuC1lXAR6INl3j6sIbRW/iq1VDqHRtVTiEJjCYfbpTl+Iot9/Y8ACEe1wzfkcDsQjFghXve4kP+BHusCV7pHlVntmDJ+dAxHR41O9cellbtVQw5bhGo1zrulGxJNx6+XP9WKRrN2PX+s3JpictPxJC+65lwFLPat8JMjvKIb55biTDkGzm/Ab4bsu4SKwxK8vayw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4RlXIb6t1BX5k7H0SChRCyTGMQfmZ8kkKXPFzXenkpk=;
 b=GC4Lr8MiSjGX0ceIxvp5hNYrhksoFVtYskQ0u+i7M1cQuk8Rtp0X1Ud9w34gDhbsrHEYbQVloNxVdJTISw2HV+SFDXuxV1y/4Hzuy1R6b72DTZWou1nMAsM/O+vty7HKVM5sVNEKlHDX73EUipUb+Zjaey8M+mIPFZXrRN1vCxFI0Fri8DaJfXdZ3wk13A8qhVrm2LfWEZgDadOVPx/juqWkJnTKYj+CB7X8XoYVIoLc3jXHekUfKj9aS3BmOvtR/6MDYnobfVyavfWYICgoDmesuhAbnP27pSIX5o579vMyh0fZmKCFnSz6vr7CraP6qWZb8zQYqS4jJpQIRtUL+g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RlXIb6t1BX5k7H0SChRCyTGMQfmZ8kkKXPFzXenkpk=;
 b=kEmtz3afsixAaGmHaPp2QtKijT3rGux211KsoXfOd3QLTylre1TNbOirFhiWTP6Z8zZ+hxhplA/n8XaowCcWYXDiPdOisJyRHIK57Isxr67G5N1AiZ93TQ7F0Y9BRguxRDb0pnN1EsNcHUJtBgIHVtBlbG7kebvsLNM2Id4H0Ro=
Received: from DUZPR01CA0286.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::12) by DU0PR08MB7543.eurprd08.prod.outlook.com
 (2603:10a6:10:314::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Thu, 4 Jul
 2024 12:20:52 +0000
Received: from DU2PEPF00028D02.eurprd03.prod.outlook.com (2603:10a6:10:4b7::4)
 by DUZPR01CA0286.outlook.office365.com (2603:10a6:10:4b7::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.29 via Frontend Transport; Thu, 4 Jul 2024 12:20:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DU2PEPF00028D02.mail.protection.outlook.com (10.167.242.186) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7741.18
 via Frontend Transport; Thu, 4 Jul 2024 12:20:52 +0000
Received: ("Tessian outbound 97740dd29f4c:v359"); Thu, 04 Jul 2024 12:20:52 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 80647883b78b4917
X-CR-MTA-TID: 64aa7808
Received: from 3c3f4ef71d2a.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id E45D46C1-62E8-488F-ACA0-37D9704678EE.1;
	Thu, 04 Jul 2024 12:20:45 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 3c3f4ef71d2a.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 04 Jul 2024 12:20:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SZNKK8zmOD5xCRSfgldRxpels+uzWpPv4dIBjtqAIOehmu1VTfJ9XtMywkWsCQBGlaV14yLJjZ21LcZLzPEES54L9BiBAFC5JIYA6VuOp+no+x/oE4csgN+a/CcmD/JZUe30LcPQTpALt2ra4tP34qY637m4ifuHGXP76jr5CCiCooYXINxuwaGEBXlL6jOXb/elAHxs1ligMj/WrIXJjDtJ084HsOUzVHbJMnDGfaFtXSS+188fJXC8hPqHaMnKp96WVmQynli+7svsQsSXyOURlHnGiNy8eCqUKJ1XA0Ao31uF1fpC+l6+6mi7OuwWpKXdQ7utjoySUksuboVVkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4RlXIb6t1BX5k7H0SChRCyTGMQfmZ8kkKXPFzXenkpk=;
 b=g9nm9A0J9Z5YoZCH9babqrzaP7QNxCY8eZfO2hAqoACFH5XknnGXhlXzHCC+K89cjY8z4i0sdk1+QHEq4PLalqCPdp4hz7xT3FzxbimEqKp46PON+bsch1BL7HqWqBzCs/hADxzzxJXQlkwBbKafVrFkQ4SIVBmTcvrU/DZy5671P+bbBKzSjA9di0iM2kuc3bZOZdP93CSFeqvZuIlB83h1swX78CgOWQ/JwGSTlrjYcPNA+8LyCNFotrHmxG0CzEXtAPa4CUprszCZMrjJoNa0oyECWJGyiVedGykrOU3dAo5EzGX1M7fKRXgMxEejVKKtGc4Fa/ATcDQ5QQzqJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RlXIb6t1BX5k7H0SChRCyTGMQfmZ8kkKXPFzXenkpk=;
 b=kEmtz3afsixAaGmHaPp2QtKijT3rGux211KsoXfOd3QLTylre1TNbOirFhiWTP6Z8zZ+hxhplA/n8XaowCcWYXDiPdOisJyRHIK57Isxr67G5N1AiZ93TQ7F0Y9BRguxRDb0pnN1EsNcHUJtBgIHVtBlbG7kebvsLNM2Id4H0Ro=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AS2PR08MB8288.eurprd08.prod.outlook.com (2603:10a6:20b:557::8)
 by PAWPR08MB11196.eurprd08.prod.outlook.com (2603:10a6:102:46d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Thu, 4 Jul
 2024 12:20:43 +0000
Received: from AS2PR08MB8288.eurprd08.prod.outlook.com
 ([fe80::85a6:7b0e:5297:24a]) by AS2PR08MB8288.eurprd08.prod.outlook.com
 ([fe80::85a6:7b0e:5297:24a%7]) with mapi id 15.20.7741.017; Thu, 4 Jul 2024
 12:20:43 +0000
Message-ID: <a3f7c1ab-b949-4246-9691-8fc79cdb7001@arm.com>
Date: Thu, 4 Jul 2024 13:20:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Optimize vlag entity placement
To: Fernand Sieber <sieberf@amazon.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
References: <20240704092345.51644-1-sieberf@amazon.com>
Content-Language: en-US
From: Metin Kaya <metin.kaya@arm.com>
In-Reply-To: <20240704092345.51644-1-sieberf@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0180.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::24) To AS2PR08MB8288.eurprd08.prod.outlook.com
 (2603:10a6:20b:557::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS2PR08MB8288:EE_|PAWPR08MB11196:EE_|DU2PEPF00028D02:EE_|DU0PR08MB7543:EE_
X-MS-Office365-Filtering-Correlation-Id: 246090eb-bb18-44d4-0f3a-08dc9c23bf43
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?aWhMUlpDN2dkelFOaFBsWnR1Y1lJeTNrN1JjSWJ6TmFsQzhSNUh5Rm5aVUts?=
 =?utf-8?B?eC9idEFsNE90b2RXdUk4SVZOOEVzdm1kd2xiQW1OR1hOOHBMUjdET281WVJW?=
 =?utf-8?B?a1o1RmozVWFCMzRjZkRucTZSS0NOOFllcHhIdUlrY3NTdmF6dldadkljbnNa?=
 =?utf-8?B?Qm9VRjBpOGF3S2p1TTM3Sk5nb0pEcytEbUxvdVFvbTUwOHZGMGx1YXhSRktJ?=
 =?utf-8?B?OXYyTlJMN004MnhFdmtjNVBKNGlIcmFoYnJHbmpDZzkwb3NJcWJpSi81Q1ZQ?=
 =?utf-8?B?N1ZkZXFSZDI4RkdyVm4wQ3dGamdKREQwOFk5bjZtV0UvKy9JK1BDWFlNc1Uw?=
 =?utf-8?B?NlRmZ3FIbXF3NFVvU3RGWXI3WjI2SFlVZEQ1bVZ2ZmJCUHk1NEk0bzRVS2Vk?=
 =?utf-8?B?VU1HZktNMW9BeXVuS3lIRG1PR3VEWVdOV3ovdXdoMzdnNy9CTnhZYStqN05U?=
 =?utf-8?B?WXNFNnZ5VWVpZHlTMytaQy8wTDZEd2dxOGdoMlJjN2VSUVJVV1V0dm01Rzho?=
 =?utf-8?B?QVVVZkhZZ0w3Y2VIc09OUGdtcGJKUTBOZ3k1NHNXRWpMeVpEZXhueEV5Qjdw?=
 =?utf-8?B?eFEzTjl5a1ZDMHp1cE9acEF6R0E0MUxMUzIxQ2hOeUZqVi9mUFFCb2lqekxz?=
 =?utf-8?B?VWYzTk4yWjJ5OWJuaVViSitXMFpEOStxaisvVHd3djVBNGpCYUloV0pKeGxW?=
 =?utf-8?B?WitBTWZUMXZYTVdBbS9MT2JWbW1EdHlFUkg3S1NycXY3SGxMS3FydzJOcWoy?=
 =?utf-8?B?ZlB5bUIzbUNheFVXWVZ1TEhOeXAweHJ0UllNZjUrU3BaVmVpWWNRcGM2bEhN?=
 =?utf-8?B?UHRXQys2MHllT1Y0UG1xdjc3TnFpdG93ZXFWS0hBQ3N1bzZadkdNYWMvR0tr?=
 =?utf-8?B?QmFKNng4N1ZoSStiL1lFTTA2QkFRaFQ4ZHc0VkVxdVJhbVJWdXBvM2RDUXlM?=
 =?utf-8?B?ckpmbThLSUxBU2dIaGpGODcxMWVjUWVvODJGelFWT0g0dC9nWEl6MXRKQURt?=
 =?utf-8?B?aGtZNDAyMDhNTDIybTlxeS83Nk13djF1anhzS1loNk01WFV6cEVYTEJ5cnA2?=
 =?utf-8?B?WFdNd2xEMERHKzJVWE5ZeldaU1RKZXpXSEVxZHpHOTNqeXBFeFVvUzRPck4y?=
 =?utf-8?B?Y0YvNW1PbUZsTHJpdkxjUzU0U1gvZEFXMkZlZWxzQS95Q0dIbVpUYmhqQXZI?=
 =?utf-8?B?Y2NTQkFkY1ppMEdVSlRGbU52REFvNkVKY2ZXdG5xS1dMVzdEdG03WEVxN3J3?=
 =?utf-8?B?b0pyRFp4L2NPTzNSdEJ3S1Q4NnRqaFRhNHVXelFoVWlrcDhLSWJudEpKdmpo?=
 =?utf-8?B?b3hKRUdrZGZVKy91V0NVckoyY0Y0WHRvVjBEOFp0YTNCMUYwTm11bkN6WU40?=
 =?utf-8?B?cUZrRnBxWnRrUHNqRllKNEV5RVZTc0R5MDV1d2xOeVdXdmFtMVR5SzFsZzZD?=
 =?utf-8?B?UUt4aUJ5WEU4czRRcWYyS2l1ZHhnY0ZtZ1hlZElTZGlUT09NTW04WXRGYlJJ?=
 =?utf-8?B?d1JPTVlNMmVpMm0rWlR1S1piSkRpUlBlMWhQVzl1OWlMbGhmQnU0VkhBRm5X?=
 =?utf-8?B?Vll3NzlJUFhHbUc5ZTdpSFF3YVRWbk42L00yaDJOL0Q1NCs4VCtqV1hnS1FF?=
 =?utf-8?B?T2VJbUdUMUMyb1YrQXlrZldKUWxjRG45Q25zeXhsNU5aaGlVb2YrRXZ6TUVB?=
 =?utf-8?B?bWN0WVFkRXkyQTB3ZlJpaklzTWZsQWhKaitpY3d3c3hlS2pIcTBmMzh6Z3lw?=
 =?utf-8?B?dDBFS2ZGS09qUERFNFM3c1JCVEJSOENyVDkySGlFUGpaZ1Y3NGJDNk05U2hX?=
 =?utf-8?B?TkdjMzVQSVg4QmpJVkhwdz09?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR08MB8288.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB11196
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D02.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	6db57eee-6bd6-4743-ed00-08dc9c23b9b7
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dmtkbHl5amZXUk9PblRVWk9KVXZDaHN2c2pHV3pCRnVrYnF5Q3VqdC9QbWp4?=
 =?utf-8?B?bDlFemFmYVpvaWRWTjZORG00clZYMVJMM1AxRHZ1WTBiUVFWcWFBWkhyMDlw?=
 =?utf-8?B?a2dmdnNUdGU0QmhqWUtyMVhaOFgrNTAySGZ4djJ4K0hTVjRJTG05ekJCRTFr?=
 =?utf-8?B?SlE2MURhdzE4d3h6MjVPSkkvRXVGMCtsME42SFI1T2hLSm1MUmcxSUNtbTha?=
 =?utf-8?B?SjFVbzBDRmZXczc5THIyR2RVM2tmT0t6WFh5NFJ1UW1IeUFVOFpEVXpMRlBJ?=
 =?utf-8?B?WTFKM0lGQVdYTHdJaURNendYVEJIWm9abXBGbkhtZGNWZ1cyNFpiVzlyclhZ?=
 =?utf-8?B?UllkeXlSbDUyZWxDcmM4WmEzQmJZQlp4bFRjUmREM2I1czJlcmdRR1QxMENL?=
 =?utf-8?B?M1JBdUJBZnplbHFDSzlyMkhJRXByVUMybzdtM2xXVndHbW9kQWM1T1BNUVBV?=
 =?utf-8?B?Qy9VczBPUml1bkE3bE9jOWFVZzVVbnRtNUZJdW51SHZ6VDdOTVNWZnc1UU9p?=
 =?utf-8?B?Y3QxazRlWFUvakJxZmNwOUcvMGhqQUZqOWlzeXgrRTlxdGFVbjB2b2VEY0RT?=
 =?utf-8?B?S215d1J0dWFuMEx3bnFUcmVCaXpOQVNmNGZhRXZVamZ4enh6MC9QakpnL1dL?=
 =?utf-8?B?S1JuTU1lbFpXRGcySUFwbjhDOEZWMWU2SXA5UFQrdmZvdXowV01abXo2c3di?=
 =?utf-8?B?KzlEN3duRExjTXpQYWZSSXhRN2FFUDc4WUVsaWxNVzhZSUQvWHQrQVBaTDYw?=
 =?utf-8?B?WmFmTTRKYXpRYVRGR3dJajJaYm5odFQ0a0N0eFNKWjhSM1dtWWp2ZlBtMity?=
 =?utf-8?B?bUFFQkZlUlNHM0RWK2pLN3AzM1Zwb0MzSm1lelNDaWhmazh4V2d4dEZJUmRy?=
 =?utf-8?B?YXkwZzBwZHhkM01vOU1sSTJIWElHbXhocHFuNS9Ma1B5RUw5c3Ewb2hiTEJp?=
 =?utf-8?B?QTBOUVRHWVBoMVRpZ2grb1VUMTJsdDhwWDB1UlVYcm4yYmIveTdDcmdsVzFy?=
 =?utf-8?B?Qlc2bjN5Unc3QUk3RWtCWEpINnlKSS9xS0VpWFAxU1gyaWNXaExzaUdqK1hx?=
 =?utf-8?B?ZGVRN1Brak55cWlsL1U4aWgxbEF6M2hDb08weUQ2WjJtL013MHB1WWFuTDdI?=
 =?utf-8?B?WTZnQ3NkWC9TYThLR29qcXRLajRSSFFDVXUrSng2aWY0VGtpV1ZrSEdxUEZQ?=
 =?utf-8?B?R1l5VEoxT2xCd1dmSlI3Slh4eEd3aDYyTnNLNzFWaGtnM3VONG4wNTlBZEVY?=
 =?utf-8?B?WlRLZmZPL09QT0E4a3l4cllsdngyNGJieDRtWENvK1RHVkk3N1lMdEx6UzhG?=
 =?utf-8?B?anB0VWhSNmp6QjNIRTB1eEFTazEwZWZEWHZWSFRUclc4VXNTWk9HQ2pNQ2Q0?=
 =?utf-8?B?TzlpaGFuQldSRjVsc2txR2RyWEx4WHZMNEcyanBjdmpoeEU2QnZNcWtpbERC?=
 =?utf-8?B?cEkwTG8rT2hreFNWWFBCRUZjcXpodUxUR09GVkMzTFMxRkJXRFkreFZlTDRQ?=
 =?utf-8?B?S2FscnJXSmF5K0gvRUsxNVBNOXdiSXpnQnZxWDZnRDlzeHVVVnZGNGc1V0FT?=
 =?utf-8?B?OXVtTEs4OHlpSUdDdGQvdGpTdHhoL3h2STE1Y3Q4RFUzcHQzMjAxOHE4emdF?=
 =?utf-8?B?NFN5bFNHeVljK1ByTXlEUlFKbEgxRzZ5YWc4KzJzVWNNTitRenpTSkxWZGxT?=
 =?utf-8?B?OUhoSnd0alEyenBVd3VwWVRNcFNkb0g4eFE3T2VZSXh2TUx0Nk1SZHI5TExl?=
 =?utf-8?B?S3R5c1lvNTgvcVNXeU9PbGpKRU54dTRWMlhPNUl2NlRVT2hSMkEvckNtejdC?=
 =?utf-8?B?ZXNoSmEyNG8xZVd2ekVjOVZnUDFxblZuNHAya3g2ckVXT3VCaEtwb1NsbEhr?=
 =?utf-8?B?OHllTjBGRlJiQm9oVjlsS0xCWlpiMnRyVU5WaFZlUFpvaVh6K1JGVzBtYWx0?=
 =?utf-8?Q?vHFgfUU3uerlW+mMhqCteBKevlGGgmKj?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(35042699022)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 12:20:52.3430
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 246090eb-bb18-44d4-0f3a-08dc9c23bf43
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D02.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7543

On 04/07/2024 10:23 am, Fernand Sieber wrote:
> Optimize for common path when placing an entity with no lag.
> Since adjusting a zero lag is always going to produce a zero lag regardless
> of the local load, don't bother about calaculating the adjusting factor.
                                         calculating

> 
> Signed-off-by: Fernand Sieber <sieberf@amazon.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>   kernel/sched/fair.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8a5b1ae0aa55..e78272c87274 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5190,7 +5190,7 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>   	 *
>   	 * EEVDF: placement strategy #1 / #2
>   	 */
> -	if (sched_feat(PLACE_LAG) && cfs_rq->nr_running) {
> +	if (se->vlag && sched_feat(PLACE_LAG) && cfs_rq->nr_running) {
>   		struct sched_entity *curr = cfs_rq->curr;
>   		unsigned long load;
>   

Thanks,


