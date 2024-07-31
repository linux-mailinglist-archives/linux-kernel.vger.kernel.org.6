Return-Path: <linux-kernel+bounces-269235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E68B9942F98
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 222DEB24092
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3FE1B0113;
	Wed, 31 Jul 2024 13:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="kf2J2QeO";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="kf2J2QeO"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2084.outbound.protection.outlook.com [40.107.247.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EAE1A76C1;
	Wed, 31 Jul 2024 13:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.84
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722430827; cv=fail; b=MJlciObanBn113nWfvs8rOcgzkYeJoDTjYFPT+ixshi6Mmui9Xz6878At9OgD+aRAfwYxvIdz7gz1oiq/UgjcBgUtONoj9KHkeIdcT/eZVT6uez7YFLb9uUKe3+vWQd+zas96M5brP3IItV6ntmvxt1Ht4wY92vHPHnPI0+xx80=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722430827; c=relaxed/simple;
	bh=5ghhgmyRY0Yxq8wAcW7ynOHT/oXNxwpglETnC4T4pB4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hnugqQ+25GO6lPTMaeBh71WDC0OwZONVFUlVI2fNsyQT4D9C781FQfFb3gqklDNMlDMDVLZwkS3z2D6yFVT9wI26WvX6yRRgnmeekhhRiikFb+/QbpbQ9gOc2RyuWJuUuWLNb1+RTbumdVXURSFMcfgKhX6IsAiJ/ohcWlzpFWA=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=kf2J2QeO; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=kf2J2QeO; arc=fail smtp.client-ip=40.107.247.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=G/J45hcu/KgdHImZqmlBZyITmXHDvHIlu2qbt158HzQK0KA0l770PNPXFfqWzejagixJN+rHGA+tj9l6MS7L1p11tqE50XcHdeBVbhX30vqkcxpnLa9xYpZW/6lTsdc4KtD191FOkVQ61lFI8c8OaXlOISBdf1ScQb/oJFrRgAFXwBPB4+5EhSRB8Cj6i8EdnoKDj1mrmtMBridxIILYivpsYFEqUpNTrMW2kKGoOwJHXdt/magerOuY3L2LyNWfa/Kww5wMiVDQuBngXKh1TtL+FwWki/AaEFabDpZAlF1vVg3VmVqsPt2m5Pxu/PvgWB0bLx6gc74+lFC5O4cnVw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ghhgmyRY0Yxq8wAcW7ynOHT/oXNxwpglETnC4T4pB4=;
 b=CyM4hNDQD6/PPADkaoLYIKyNU9uUoFIxustsQ0m9Pw4pwD/vFkFILgH1fw/XySQhPqkExWGHYEzweoeHRbl3jdWeY6Ldpg8Of8DMCc4q9DOB7ZTKDyU+anAJ9llG0Tbur6lrwhqzrJeIEgGQgLA66u08yiDKBDpl1FRGh0auYoZ13j2dB9YTE5W81f3amoXEnnrdvnjvtpeg+6NpMWu+ZxavvUAVKILvfl7AYmx88cHUZVDxVKffR5NVThQg6nx3FiDsODb2gpxPZ1wm/Qhts8OZH5+fydbsxXvizvn4Ho3j0kLDi8Tb9UWGeDoHryypTJkaBPPn1qI4kMS3pEFYpA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ghhgmyRY0Yxq8wAcW7ynOHT/oXNxwpglETnC4T4pB4=;
 b=kf2J2QeO1AKwGdTmajx5f0Jpc+VI5zWoOR8U6Ke9JsvIpR246wlzPIbU27XtjtAZAjcBiDERzu5uVBP3kFCwUtv/oP/FqMYQAxIpWtbWmEIWsKWz2V9kRnbu82zpbqol9QaMRpOB5d0X4Zz1gpKC20r0IOM7YPCEiIAw3GglHm4=
Received: from DU7P191CA0019.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::33)
 by AS2PR08MB9987.eurprd08.prod.outlook.com (2603:10a6:20b:645::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Wed, 31 Jul
 2024 13:00:21 +0000
Received: from DU6PEPF0000B61E.eurprd02.prod.outlook.com
 (2603:10a6:10:54e:cafe::53) by DU7P191CA0019.outlook.office365.com
 (2603:10a6:10:54e::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.35 via Frontend
 Transport; Wed, 31 Jul 2024 13:00:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DU6PEPF0000B61E.mail.protection.outlook.com (10.167.8.133) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7828.19
 via Frontend Transport; Wed, 31 Jul 2024 13:00:21 +0000
Received: ("Tessian outbound a1d019a80d57:v365"); Wed, 31 Jul 2024 13:00:21 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: d8b7cfd8e4b47311
X-CR-MTA-TID: 64aa7808
Received: from Lb079388d31c9.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id E8B53CD6-662E-4F84-8FAC-837E79DB8F14.1;
	Wed, 31 Jul 2024 13:00:15 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Lb079388d31c9.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 31 Jul 2024 13:00:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wmb5DbqzVMdrqOKei2EtwUPkj8QORuOyysRkBT+6AWrNOQj6ptSjUbXgcfvYy5qkbRV6jAlR23bq2e2qbYJkjDMmXVnW5FDXljqvCdteHTHbaSsCKETwQB7+CIr4aHaG88tpSui0ScJCenGuznmXL4G1U8KcYunKTxGWxS8gtX8VE3L3dYg/SRJYYw2N0e1UJv42iPJ/vUxh2Qc3WtHSMNtXvLBZgeiDk9OdOFbE+BXZcMjJMgCFVjkzHiHgFdQ6+Ahm948NP6Md7kJ/W8e7sKzks+/XFW7Hyjp9g4kCxgFIE08QS6Rk7bSYaxN4yyQ1wFJW63Qx1gP1UWLYCtDtGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ghhgmyRY0Yxq8wAcW7ynOHT/oXNxwpglETnC4T4pB4=;
 b=UXUMOhJU5296nV/qJ+5NOzsb9/mvffeYl1YbH8EVHQfF4pcNg75VqQTjwDu1ubYV7DseuEghv5F7Bp4mQtgHueQYFYbPed3S7l7ErEYZLHlemGZhqg+qkf1QeT2/1R2bs9KUYhUf8bi5IjfK5PHiOBG8IGFnYBtDmPB3ik7viTRbG9Xx0o/NLBo+YigE0PODtjUP2dNFpcfOdLyiPVjgfIdGaenzYFAN1ULvhr+G/Y9kibqVTirydbPdwkXIZ2G+81qSCU1eCWnB1YtHuYWEulvLHV8oHK4473P56weM6YvWlTNG1BeednwFV/cagc9cplzmt7PEdFWkrg3EJYiFgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ghhgmyRY0Yxq8wAcW7ynOHT/oXNxwpglETnC4T4pB4=;
 b=kf2J2QeO1AKwGdTmajx5f0Jpc+VI5zWoOR8U6Ke9JsvIpR246wlzPIbU27XtjtAZAjcBiDERzu5uVBP3kFCwUtv/oP/FqMYQAxIpWtbWmEIWsKWz2V9kRnbu82zpbqol9QaMRpOB5d0X4Zz1gpKC20r0IOM7YPCEiIAw3GglHm4=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DU0PR08MB8639.eurprd08.prod.outlook.com (2603:10a6:10:401::11)
 by AM0PR08MB5441.eurprd08.prod.outlook.com (2603:10a6:208:17d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.19; Wed, 31 Jul
 2024 13:00:12 +0000
Received: from DU0PR08MB8639.eurprd08.prod.outlook.com
 ([fe80::253c:bc53:f4b8:3c7a]) by DU0PR08MB8639.eurprd08.prod.outlook.com
 ([fe80::253c:bc53:f4b8:3c7a%4]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 13:00:12 +0000
Message-ID: <6e1b70a1-6cd7-4a20-90e9-aa8446c74e91@arm.com>
Date: Wed, 31 Jul 2024 14:00:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] firmware: arm_scmi: Create debugfs files for
 counts
Content-Language: en-GB
To: Cristian Marussi <cristian.marussi@arm.com>,
 Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 arm-scmi@vger.kernel.org
References: <20240730093342.3558162-1-luke.parkin@arm.com>
 <20240730093342.3558162-5-luke.parkin@arm.com> <Zqop6qq0jibefw0g@bogus>
 <ZqouwIJUYDJB64xP@pluto> <Zqow0WOz0eVf6fwv@bogus> <Zqo0IWvrdUUNIAGL@pluto>
From: Luke Parkin <luke.parkin@arm.com>
In-Reply-To: <Zqo0IWvrdUUNIAGL@pluto>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0071.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::35) To DU0PR08MB8639.eurprd08.prod.outlook.com
 (2603:10a6:10:401::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DU0PR08MB8639:EE_|AM0PR08MB5441:EE_|DU6PEPF0000B61E:EE_|AS2PR08MB9987:EE_
X-MS-Office365-Filtering-Correlation-Id: d138bf04-8e51-4a87-1660-08dcb160bc68
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?UlpRZkpzUlBVbVB0bTRZbEdvcnAyQm80eFp5d056Qm5iclM5WGQxZzZkVFBG?=
 =?utf-8?B?TWpSbVJYdlBEcjFoMFVpUUJoRnRPN29RejdxcUIzSCs0SnYrMmQvdjBJYk5E?=
 =?utf-8?B?TzIvK2M3bE43RHRRZmRhbUFuYS9rRWJOZEM0cnlJdGpDbmtwQ0RqM2gvKzFF?=
 =?utf-8?B?dnk2SmlGOU9idkhobmhxOUhEeXM1YVVUOWk2SkxSWnkrT25BaFhpZjVKWDVC?=
 =?utf-8?B?bzZSRDU1QkdKc2NxOE1paG1Hc2dINTNDZU9tZ1FTMU1mNnk1UnFYMFYwRDlr?=
 =?utf-8?B?YUY5RjhYY3Z3RUdnVVA2SHNrdmVrTTZjT0pmK2tEcG1CSjlrNHRaYWVMcFNW?=
 =?utf-8?B?ZUdMSUxNUjJCTGU3Y1czUnFORVVqRUtWbXU2RE9tRjFMTFhpcnpMWTQ3cFJa?=
 =?utf-8?B?dDdWcDgybUZJbk5JTlc0aTAydVhjWWkwRXZrM2JsOVJMeTFQZW9BYnpmOXpp?=
 =?utf-8?B?RGxTa3ZzOWgvaEhrRlBSR29rRkU2Q3VDTDV1V05oWk1HNDE2RXZFOG1pdFY0?=
 =?utf-8?B?dzg4b0VXOTRVZDUzYjYxYmVDaXRER3BZc2liVzQ3WnBUY01ZY2xTZnc1Ziti?=
 =?utf-8?B?M0krUmdoUlRWeXpUanU5YzM2OVJzZDVxa0pDcVJXcWdYbDVmRFRkdXpGOFhF?=
 =?utf-8?B?SE14Mm91WTV5ek5LRnpWVUM3YnIrcnVkdUFwTEtNK2VVRklKODI3RVc0Uk9u?=
 =?utf-8?B?Yjdac3F1MXY1b1V6NkRKSHJDbUk2VXJlOG5UMkNOT0MrdmJsa2pxRThVTld6?=
 =?utf-8?B?WVZDd2w4MjRqUmpKTmtvNG15S0ZzUGl2RkxZZUpXMkhCeEIxN0lrNUlmaXc3?=
 =?utf-8?B?M3RMS1FtVC9LYWlmUmxmOGJsWXRvSXQwMUNVdFN2WkNydytHeW1tYjR6VEN5?=
 =?utf-8?B?Ti9LdWxGcFNjcFVFekJRcUM2SHZBRUhra05QTnZ4WFN4K1kwYzNKQ1psVUN0?=
 =?utf-8?B?cEtMMVgwRCsvbUpSTjRtK0hpZnNpaXllcy8rMUFiQ3JjUHpWdXoxNlhDQmll?=
 =?utf-8?B?MVlTbm1SbTNkWHF4LzBTUEkwMjlleHRNNlVhUzdxSWlLTjZvUE4wdGd4MmF5?=
 =?utf-8?B?TWlrQjMxblQ2aEhNV29oblBxdmFmWWtPem5wMjhCSkNrN1ZOMjZWdkpLNXpZ?=
 =?utf-8?B?blJxSnYvS2Q5aGY0cjJWNUMzbHBlSTRMUGhWSlo3ZGwvbnhHRmdwcDAwSEtw?=
 =?utf-8?B?MUEwNlAxMC8zdlZDWWE5WXIyb1ZEWGUxbDdOR3ZEVmpaYW5NVFZwRGxpeDNh?=
 =?utf-8?B?MVdaZWNsbXA2STVYaFFvZkVxQkx3NlNDSzd5cEhXbDlCeVlXaDNFaWlsNzJk?=
 =?utf-8?B?UmdtWmE0WFArTTI5QisvS2p1Qm5MQzNCSWN0Tnk1YmtoNUtMM1RHdk41VVpu?=
 =?utf-8?B?Z1lPL2Zxek1MRm4wa3oyenFSZTBFUGZjT0NkckVjb1R5cUlVRW84VS8yT09H?=
 =?utf-8?B?UnRZRTFVQjlRTXVwN3JoRytKZFo1QWFiQ09iRFhGck5OUjBBUUNWUHJZUUMz?=
 =?utf-8?B?K05MZEpTU0RyTVNINDAvZVZCUUxzMmxSUURCS3RQV3NWUWt1VmFxUFdpYitQ?=
 =?utf-8?B?WDRuV3RXSEVtZFhibGFISC9vMFloTGFhWHI1c1ZERXE5N3VTSXdPOENoOGZC?=
 =?utf-8?B?eXVaUktDWm1Uc3RwMzVoMUEzRC9rcGg5dUNDWWFNUXhWQUJUejBrclRoSXVS?=
 =?utf-8?B?WGczalpzblM3eU5kalZvUlJoMld5SCtZTUtYWVRWM2hsajlyRHBnWDZtaEla?=
 =?utf-8?B?MmpPUFVhTTc4aXBKT00vMWZpdTc0dEY5VHN6V09tSTlDamlQNW1yV1Bkd2tu?=
 =?utf-8?B?OE40U1BCQlVBbTZ5anNWdz09?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB8639.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5441
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:10:401::11];domain=DU0PR08MB8639.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000B61E.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	34d6ba1f-7bd2-4016-948d-08dcb160b69e
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|35042699022|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zm1MbTEzVnJVTFhSWElCRkMySDBEWjEwQStDTEtSZHVna2FnMHltR1V2MmpS?=
 =?utf-8?B?QjRNb2dwaDhVekxXdC9WR09oZWZpc1NCU2ZjMEk1SVJtZzVUTzNGRW12L3hH?=
 =?utf-8?B?S3JWNk9reEtFbkZ1SXdlM2s4TVdZd2huQ2dLcThQd3NlNFZOQ2VWNmh3SnBj?=
 =?utf-8?B?VXlVckpLZUFiMkpNcUhCeFdpdS81KzA0alBCVzBaSHpFSlVzSUZ2K3EzVWdI?=
 =?utf-8?B?TlZlYms1TFd0M2pnRnJiM2JBR2pxYk8wTXJOU0hrMjJrSkFhSGtDQXZRL3Nq?=
 =?utf-8?B?cTVkdSs4Y09taDNBZGp6eHQ4WEpxcjE2cDRoRlZGQ3pOd3EweEN2UktWMktW?=
 =?utf-8?B?WTJyMDBwRi9GYVBmMHkxakNTZE1vcEtsdUxobXYxYzZYTXZnTmVMdzY0T3Vs?=
 =?utf-8?B?SzZNMHF3N1hPemtJM0lCZmhyNWpSSS9wa25GSXhueHJhUmwvR0N0WFQydk9D?=
 =?utf-8?B?cWdseEZjblVHbHB1TlZmbytqNmpMNEVmUkdGaUVTajVKcFRWUnFWM2pDWnk1?=
 =?utf-8?B?SVFSZHlOaTBHOFV1aytONUp0OWxmTjArUU55K0V4V0d5TktXamZBeHJxbmZr?=
 =?utf-8?B?bFdheERFTFU2UVdtbEV5ZUpNZ3FocTZzM2VCVjFHcFpTZnhNN1J3ZlhQalh5?=
 =?utf-8?B?SkxyaUxwelJsd1ZiVEM2VVhvTUtpYmF0RTFvZjJrYndKL2VxYXJySXZaVkZJ?=
 =?utf-8?B?eloydnFmeXJSZGkwLy9zbklxYWRXeGRTTUtkUUYvM04ra29GaVFFM3RqRnl5?=
 =?utf-8?B?V3NTZDRsWGM0aWNXVE9zYmUvalo2bjJoZnRSdWF0WnMyUFpoa1g5WGVKcU5X?=
 =?utf-8?B?MGYxbnIxc290ZWFVeFExenorUWpqWmVQWkdxTVhMNjRDYkhxZWRzQ1hRYlhN?=
 =?utf-8?B?VFFvSzdJR1RFWGRSU25McUpRUWUvQXNKSk9MZU9ZM1VKeHdnVDZ6ampNZ3hq?=
 =?utf-8?B?Y3hqY3hSbkUrNVppOE40L3AwS0dsSW1SM1I2Qzg2SDVyRjN2RG95enVicDQr?=
 =?utf-8?B?UWtBTElwUlBwL2R2YkZ5dFozWmxGdXZOQ1VPaUxkU1pUTFZTSzV6dFRMVlg5?=
 =?utf-8?B?Y2RnVjd4UWp5MWpFR0x6b3lNVHJFaTNJNmpIZzZNcjBtSUZveUJvdmxTcUdH?=
 =?utf-8?B?UmErL0VZbW1qZVBiRjNTSTdyMTVJZTNtS2pzUkRDMkJDT1lFQWRrV0lQNVZZ?=
 =?utf-8?B?QU1GeGw5ZUx0TG9UaG9Ia1hZTmNkaXh5NHNSWFd1SlJacUxHdVNmRWJvazNI?=
 =?utf-8?B?NzVENVNDbWx4VVdJbThjdVhmM3FGZHgrSUdHSWsxSnA2aDZWTnljZzN3WklN?=
 =?utf-8?B?YTVYMHRZTXl6UTRUdGtJSUFmWFZhWlluaHZJbmVrNzRROFhDYVZUOHAydyt0?=
 =?utf-8?B?YTg4SkwrV0hQdFRGVW5hOVh5dWdkL1VOaCs0ZE10TFZyNHh3ZWNaaStBVTAy?=
 =?utf-8?B?M0NQUXRrMVpDTWtDWExJWGllcm5tcHBYbGVoSmZpZU1oTG41T0lJL3JyWG5x?=
 =?utf-8?B?MVBDMnN5dDd5Q1Z2dFJyYXpoMHZaNDlqbG8vWlhQZUpEVWFhSGFPL3NoOTBX?=
 =?utf-8?B?b2N0a1ZiUHlndytTODdER2ltTXNFTlFXSEN4WDE5Ujg4bG1TRXEvVzdDd3lq?=
 =?utf-8?B?N01xRXlpM0ZoQko4SGxJVG9WTkFYeWZUWmFEejZ4MkFVcC9IS0R3TEFGNjRW?=
 =?utf-8?B?N3dSSUlkNzUyMW1VVlNIVWxBaHVpczA5ZURPN2dJRjVpMlkvQ0xGbjlyL1Yz?=
 =?utf-8?B?MUcrRWx3STdTUVFoa1gxMkRkN0Q5SWhiY09Bbk85UzM2Mm1lZXJ0bzFZYlRW?=
 =?utf-8?B?T1M3dndNM0wxaWVEYmY5V3pqR2RzU3h3MWJrd2c5WXJSZEhoVEtCWVU1MkVy?=
 =?utf-8?B?NnR5eHNVRmdXNEwxOGhDZjd1MXdQNjJlM3dIbXhKcmc2Slh3UXQwV29DSDlN?=
 =?utf-8?Q?Y/JEffQ7+i992Nkh2mHKpiIzZPyjUOnK?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(35042699022)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 13:00:21.5526
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d138bf04-8e51-4a87-1660-08dcb160bc68
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B61E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9987

>> Indeed, I hadn't seen it carefully. Do we really need per counter reset ?
>> For me one global reset all with all files read-only should suffice.
>> Let me know if and why you think otherwise.
>
> Well we don't need strictly anything since it is a debug/devel feat, it
> just seemed handy to have a way to just reset one of the counters you are
> actively working on, if you think about a testing or live devel
> scenario...but it is not really needed and I have no strong opinion
> about this...it was just a nice to have I asked Luke to add last minute...
>
From my perspective, there isn't really any drawbacks to allowing writes to the
per counter reset? It's just a nice-to-have without much drawback, unless I'm
missing something.

Thanks,
Luke

