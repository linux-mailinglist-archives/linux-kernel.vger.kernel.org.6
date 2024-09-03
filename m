Return-Path: <linux-kernel+bounces-312867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6509E969CA1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 13:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 792CCB22734
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FD11C9849;
	Tue,  3 Sep 2024 11:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ZWeuihdx"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2086.outbound.protection.outlook.com [40.107.215.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0C219F41F;
	Tue,  3 Sep 2024 11:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725364745; cv=fail; b=dUz2hj+sipca419xFs3MJl8gyIK+c2mJpa/CVJUDhrVh+LChFVXYMlwsIQpkYhHWLGn5haQFjgx8zcCLs8N0aDPRsdCRSI6VzzXi2fbbZhAtlRg8j3coMEAVRs5sro5WrgzIX0ylIFPQIHqLu0XLHfRv8C1n2AqbR2civqhGyO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725364745; c=relaxed/simple;
	bh=ccZuL6I4nzwAfrf6Hb9WFVhseQ43F7a50oPierV3rvg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lORM5jXWH2PGl5t6JmOibN9SP7mmOjIIxlKCnKbUoExIe3G3F+daSKCPxSMHXC+C6+Ygoq1CIO471QoYvqmcxsKOeCRQYhWYUIlQ0VE9UqF7Y0G5z8SE8my+Q2tjQHjcPPD41T7WbbZI2nGk0stPmAiWdQNZQDpYESi1jkNTf9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ZWeuihdx; arc=fail smtp.client-ip=40.107.215.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ibG1ExYtwfNwgA0oBUJf1CI6zkKFdMGBJ6uwkd2XMoUYifm76DXo6QKyDqqwsn/rfEu187dy7NZcxuiDoj14hP8bgsYdNe+f9oQKxFx1nSpIiZEAmztFJjpPXLcI/+ExRDQiRZL90u5w3QsqX1kKASDNtL1Z0UwR7ouXFQXz2nbVYFypKz5lNg2F75kmgOzSW0MJzXQliQAmYMZduZrM5TMtcH6mD0RG/484uWb4ZhEQASYtxln3kkGViKK8InhAN0vJqsBEB8YECdbz7utY2DZ6CNTTkeBkXWH+wEPldY9XrIaPxWSRyHklyJXE9uddaPybYOCTa9DNkR2JRH44gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ccZuL6I4nzwAfrf6Hb9WFVhseQ43F7a50oPierV3rvg=;
 b=C8ld/VD2hC5rLW4VMNAPRnJzuTOAvVGpvACBxHeF/avv1cylZBVp+ets/3sS5Ulg71GdoRLg+rPqfy7JfprqyqKls7HtqpSInc59l/C/lQE7+tkOdrgjm8IRt4UOEcRbuCgjDjpYTnKTtlcVmSe70ZdWMT7h+4dm0tsnxLs6Fj5PDkDbsdW7PYxWal8wYB+571aZ6EhlqoKJhHy4vGr3b9R91QsMCRcNpSTiOt/XoAy8Iwmi6EpnO9wKu4yIIALkS09ln765RDgfLm0rXUCKDhFDUBrGXh+QpQiTvlvS29EYAJhlWWy8Q/sARrjiKWA1mUsARy7dBgqoIIB7yEMDWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccZuL6I4nzwAfrf6Hb9WFVhseQ43F7a50oPierV3rvg=;
 b=ZWeuihdx6trXumnj7yNZ/1Fp/qpBHjo2kVC+zXri5kXt9uPvhw3NrsTw+TrB0X1+HxIPUbkPsaT4ayrq30fE3kYxNPRNbrtUdtBCBLbwbaHe2TnwcySRB7+oJsrJxBP8F4ZVXtTX96XBNpBagEIYt/ou87fF7XmR4VqllcYEZlnQCqDBNbj9xpnB1XGQPT9rqoh1WcD2w5zzpVrEQVaElYvz8uaP5bUQXxX6YjBOkRBq/fBTXR0U1ZY97XVBsN1H2qs5srm+PZgj9p+tljUvcCn5RMqu12iaEXsSYFlxGHxJoqhWS5l3XMOxCnMr0VWmH1b5diOUXSLU5iYqgb4wew==
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com (2603:1096:400:358::7)
 by SEZPR06MB5879.apcprd06.prod.outlook.com (2603:1096:101:e4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 11:58:37 +0000
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe]) by TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe%4]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 11:58:37 +0000
From: =?utf-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, Prashanth K
	<quic_prashk@quicinc.com>, "quic_jjohnson@quicinc.com"
	<quic_jjohnson@quicinc.com>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, opensource.kernel
	<opensource.kernel@vivo.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>
Subject:
 =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjldIHVzYjogZ2FkZ2V0OiB1X3NlcmlhbDogQWRk?=
 =?utf-8?B?IG51bGwgcG9pbnRlciBjaGVjayBpbiBnc19yZWFkX2NvbXBsZXRlICYgZ3Nf?=
 =?utf-8?Q?write=5Fcomplete?=
Thread-Topic: [PATCH v9] usb: gadget: u_serial: Add null pointer check in
 gs_read_complete & gs_write_complete
Thread-Index: Adr6Cd+UUO/sbS6xR4e70mPa/mlHZgDwE32AAAtyntA=
Date: Tue, 3 Sep 2024 11:58:37 +0000
Message-ID:
 <TYUPR06MB6217CE82501927931D973EDDD2932@TYUPR06MB6217.apcprd06.prod.outlook.com>
References:
 <TYUPR06MB6217DE28012FFEC5E808DD64D2962@TYUPR06MB6217.apcprd06.prod.outlook.com>
 <2024090338-nutlike-oxymoron-90f0@gregkh>
In-Reply-To: <2024090338-nutlike-oxymoron-90f0@gregkh>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR06MB6217:EE_|SEZPR06MB5879:EE_
x-ms-office365-filtering-correlation-id: 3a604227-897f-489b-e15c-08dccc0fbe8f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QW16NzdxekFad3V3eGY3WExBbElPbEhrNTcvUzQwbnRRNFFkZ1BjYTM3NWpI?=
 =?utf-8?B?VUN1MFhYa2k2K1NnZ0d0TVpDamtlYzBXRVRuSmVQVW5KUWttS1doOE43YVdL?=
 =?utf-8?B?Q3ZZNkJvd0RqcGRHUlpoTEJOeFhudkNWdnRybEZjVndycHQ0ZHZVM3MvbmNv?=
 =?utf-8?B?cXFoUmtOMHFmNkFPV2pxanlZTysxeFZPcW5wc0NmU3JOWDJ0cjkrNW9iWlVw?=
 =?utf-8?B?RW5Ddi91aWFLbjRyeDB1OU1lT2lCVkxaQm5CSTlEbjM1ZG9QdytlMnh2VFpM?=
 =?utf-8?B?eFFTOHBHUmJtTkRPeXdCZlNvNTBFNmpGUU9NcnNoOG9rakg5V3BGSjJYalE0?=
 =?utf-8?B?ZzRNQjd4RURCL3owNUJrVEU1aVhycDVYOVZ3NUt0d294bTJrUFYvaElUZ2tB?=
 =?utf-8?B?L0g4SEliNEw3d0xKblRvODY4azlLeDNscEp2ZkFjSXVONXN3ZFUrVmtQc0o4?=
 =?utf-8?B?b3YzY3V2RGlTemtEZXhBUW5HOTB6ZGtkelRxUVNXTHY2NjBzeGRDbG5mMGg2?=
 =?utf-8?B?MXRTZFNIeXhEeHRrVHNncGVXMWIxTnByWHJjUUR5UGJyTkZVVEswNkQ4Wm81?=
 =?utf-8?B?UUowWStGZlNJNytVaXFwYWxpSUQxT1hKNEUvWUV6K2djMEp1cmdSRVl3RlJJ?=
 =?utf-8?B?NklFR3hZd2RCalM4TG9MVXNGNEpNRC9YeHI3dTErRU0yMnM3MmZNMEFObDRw?=
 =?utf-8?B?WU5nOWNlU1Z1U20rYmpNV3MwWjF6SVVJNHhoYnE4WXF1NHdKcElTb2g1UzNq?=
 =?utf-8?B?UFI4V1FUWjhucGZrLzdjbkx0ZjNUMWhSOSs2MDRrV2oxZW9GOThsdFpZTURC?=
 =?utf-8?B?QTQwZnB5V2Mya0dEV3Mzc1BQcGp6MUdGcHBHMzVHV0p3cDRucWMvVjVmRXhu?=
 =?utf-8?B?TURsdXF4QXMycjZTNzZxYUpYMktmbkN0blNobkgrRFhnOFowMjlEVis1R0Jr?=
 =?utf-8?B?bk44aklLQVlwaFNXQ0g1Y3RzMWFsdkhnTmJtL29DTkUrR3hYQnpQNXVuOVpi?=
 =?utf-8?B?WmZXMG1GRDhRWjF4RHdHelVMSFJEQTcza0lOTEpkaDlTdUd5bENHRGZIdzlX?=
 =?utf-8?B?TUx2cThDaTJwVkJEZlF0RWdpSHNDR3JkWVI3c012c01UYWN5STBLM2d0eUZt?=
 =?utf-8?B?TGRPaVJsK2ZKSThSV2RjMVhxRkp4MWlGMWxoNmt4c1JMMFBVSk52UnhMRGFz?=
 =?utf-8?B?bUU2UHhFMFQvUHJveTlNSlZGcnBDWmN1R0hvc3dVdjhNenRlYkVFWS8wNWNB?=
 =?utf-8?B?cUY5QlBSdURPU2Q1K2NLMFlsMHlLNTlmSVpNdzJnaGFtNmxwK3htdHV5S2ZM?=
 =?utf-8?B?UHV1bE5JaUtFMHVkU1FMeEJVdG4xTjM5UXFDU3ArMjluZjE4MVljTkp3Sit0?=
 =?utf-8?B?bW91VWlQa0ZpclBaWXAwSUIwLzByWkVHamZTRUFxc2krTytYY25hck9mbzVu?=
 =?utf-8?B?SnZXckZMQXJLNmZaNXpISWliNkNuamFXcXFBelFvUDR4VzhSL0h0V2d4TzJD?=
 =?utf-8?B?ZENJcDRmbmdReEx6NmVuSFhGVDJRUnZ2WnUvbTB2a3FJdFJtV1RIdVFRME9X?=
 =?utf-8?B?TWZ1M25ZdHJvK2duS0oxUzhYcFNtSVRTYjUwZXFBMTlJVW9qaUQrQ2FCQUlh?=
 =?utf-8?B?UEVLckNkUklmakFrS0xXRkNBTXE0L2FmaGNWYk03bWJwYW5jZzF6OC9VQ0hu?=
 =?utf-8?B?WHFZbXJWSll1eVVaaE1aNFZIVmVVWFBmaC9tV0h4ZW1remZTSU1MdWN3aHBX?=
 =?utf-8?B?VzBzQlRIcGVPenQ5QlpSVFRCYjl4Zi95TGMrelVMMHlkWHUvNEhQek9YaWRa?=
 =?utf-8?B?RVMvd1QrVGk1T3JyTlhSQWwvcVh5UmN4TTMwUkUzVlBmRzFWNXpMYUhYdmVP?=
 =?utf-8?B?NzdiSVVoT1FIMFRmZGg2WUdIKzUyV1gyWEJxN0JHK0JSYUE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR06MB6217.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WHVOMzhVU215Z250Z3pLZk5VYmVSUzNIemZrck53bGpBRlhnaEp2cTh3Qlcy?=
 =?utf-8?B?cXBndzVJaUxsdC9iTGtFLzFZaFQ1NkFSNXJuQWRRRUdaK0xVZGpYTkQ5TXhk?=
 =?utf-8?B?T1RBUHRBMDdjaDBaeG5Zb3Z5ZW5LYnBlQ0s0alFlbEEvVjQ3cnpFd0NhSjRC?=
 =?utf-8?B?cm9uQUZ4ZEVldVBwaWlWMFdYcC8wMkh5cDBWSHhCOEFHVUU1Z1hiQURqUVkr?=
 =?utf-8?B?bmFkOVFwVCtzNU5yUSszWGY1aEJQaUJJdzBySEdCWVE2VFJUNTNVd1J1enpT?=
 =?utf-8?B?Yzc1SnV1S3VwZm4vL29kRFlpWDJwcGtsTDJyM21maWw4TjJzTXJ1REc4TWVN?=
 =?utf-8?B?REM4WlRwNXNVa3FHd0VITlArd2JwTzJnVGxsdHM1ckdER2Z0S3J3WVdlaml5?=
 =?utf-8?B?QXNwYzlnVi9SU1BpNGlnaTFVNXlYb1h4SnlEUzVUOWJpaE9FWEo2LzhZL1BZ?=
 =?utf-8?B?eUdFR2xocGoxa2R1WG4ydys0R21aTi9Ralo2RU1YOXIrWS9UWXgwZUt3UDM4?=
 =?utf-8?B?U1VYeC9YYlk0MHhQSWdTU2x0Y0IyRnlGbDJvN0FZbk9HOUJJWU9UYXJWM2pJ?=
 =?utf-8?B?ZmNUUTM0YUNjTlVSSHJOY2Nmdkowc2FBNDg2MTZwbW1Nb29qbE5IOXdkOWZB?=
 =?utf-8?B?UXdOU004SVZTMUY3MWpZS1U3RmFyeVRIcTdxMWxZOERuMkV6ZGZqZ05pOEFQ?=
 =?utf-8?B?YmJDeDhaRGdJWmFzRXJMVlJ5WXR6L29jRGwrRk9yRnluY0xmTDdKT3hzcmEz?=
 =?utf-8?B?Q0k3clRXWTVZSGZCLzdUNHZ2VDREdjVUWkp2UnNrY2JkcmZIeURyTEMvQ1Qw?=
 =?utf-8?B?bXBNdWdPNEQrRVQrbERSZDB2aHhuK3dqS3YvdjRnZEZHMm1FODExbE1KeEt1?=
 =?utf-8?B?U2RwRzJuYTF3QkdZVU40a3pkKytBamovZXJIcE5leVI0UHJvOGh2OEpVWXE4?=
 =?utf-8?B?cVJWWnRKODl6UUd4dGRlbnV6MHJaWlhjc1ZxUWttTHE2RTE4R1hyRmIxR25m?=
 =?utf-8?B?ZWJCSE51R25ray9qSW51SW9mbGtJbWYxQnJuQ1Z1bkdtNFdJcTNTNDd3SmNB?=
 =?utf-8?B?UzZqQzhyc1JZSlI1Y1Bjd25heCt3SHV6UFEwekx2bDBUNG82MWdyMmM2YzRa?=
 =?utf-8?B?aGdORU4rbDVodzkyaml5OTZwV05odE1vUGFQRnUyQ3JoZTBzejVKQ2FITlpU?=
 =?utf-8?B?MVlDQjluWDhqQXBOU1ZoWHE4a3JKdVhjMWdKRkxXT3VBSk5ITCtyS1BXckJn?=
 =?utf-8?B?RzVqZWIzSVFOeGlndU5MbUhveXJoU1VOblZPcmovcTVMTjV1cE9OdXQ2QXVp?=
 =?utf-8?B?UXp3RXpKRFFubE1jalNiakt2U3lNdERMU1JjMDVPM3NuUkg3WVZBK0NlZkxw?=
 =?utf-8?B?V1o2WXJMSkJUS0tWSGVHak1QV1d4OXhsVGF6R0NuV2cvcU8vZis0WVRJQWJw?=
 =?utf-8?B?UVhGcm5NMDM0MUxNRWI1ZFhSZzZJWGpoV0pRMFpzeWpwMFA3TlVoOTZ6eTlt?=
 =?utf-8?B?L2RrOUd3em1PbDNiRDR1VVlMOUJZUmRFZkRqTSs1dDNMTkphOTZRYm5sMUlV?=
 =?utf-8?B?UGFEeFRiSnVWR0g1SmI4Y2dpN3dxNzRUZW5FWlJHczdyRHl4WVBYRWxwSG5y?=
 =?utf-8?B?N0dIdVg3QmNqaHpQUk5Jb0NkWlBvb3o5aUxpaC9ZUXA0NFcxTGdyQU1Sd3B3?=
 =?utf-8?B?VjU0Zng1ZFJJTUtpdHhweDk3VFIxckhaalJVR1RQNktIZzR2LzJZZU5JNmpH?=
 =?utf-8?B?WkdjLzdDSUdIOCsvejlXaUhMOU84aWo1UmdpTkV6MVpnaHZzOStma2lIejQx?=
 =?utf-8?B?eHJnMTM1eXZsWUszdFUrNFhTY01QNlVYK3FyUitZSDNmSXh1U3pBdnJBTU1y?=
 =?utf-8?B?dXBpYkF4U3NIMFMyUmdhd0lyZCtDMUkrR3U0RGpPbGtHV3c2bG5KTjNaSlk0?=
 =?utf-8?B?T1QzMWdGMk1aL3B5MUFxeXh3bUkxZzZwMTF2RXU0WTMvOTBqcU8zKzlRdGh1?=
 =?utf-8?B?WHVkWjlsc2VoS3VFaGNJV254UUQ2TFlrZDFoUFAvaGszSlhZYWk3TUQwSlhL?=
 =?utf-8?B?WFM3YTZDa1UwRVlQTXQremd1Y1FnU2MrNWJzczVpZE0wNHl1ejdkVGZ1S0xK?=
 =?utf-8?Q?cKCQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYUPR06MB6217.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a604227-897f-489b-e15c-08dccc0fbe8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2024 11:58:37.3308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7ocrwRmcE8eLhQbhkWTd24UAPmaO8FpSE6CxxwtaC58RVvb6WojkMpfbxcv0zQe3UH5165JbrGgSoZlUwxCHMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5879

SGVsbG8gbGludXggY29tbXVuaXR5IGV4cGVydDoNCg0KPj4gRnJvbTogTGlhbnFpbiBIdSA8aHVs
aWFucWluQHZpdm8uY29tPg0KPj4gDQo+PiBDb25zaWRlcmluZyB0aGF0IGluIHNvbWUgZXh0cmVt
ZSBjYXNlcywgd2hlbiB0aGUgdW5iaW5kIG9wZXJhdGlvbiBpcyANCj4+IGJlaW5nIGV4ZWN1dGVk
LCBnc2VyaWFsX2Rpc2Nvbm5lY3QgaGFzIGFscmVhZHkgY2xlYXJlZCBnc2VyLT5pb3BvcnQsIA0K
Pj4gdHJpZ2dlcmluZyBhIGdhZGdldCByZWNvbmZpZ3VyYXRpb24gYXQgdGhpcyB0aW1lIGFuZCBn
c19yZWFkX2NvbXBsZXRlIA0KPj4gZ2V0cyBjYWxsZWQgYWZ0ZXJ3YXJkcywgd2hpY2ggcmVzdWx0
cyBpbiBhY2Nlc3NpbmcgbnVsbCBwb2ludGVyLCBhZGQgYSANCj4+IG51bGwgcG9pbnRlciBjaGVj
ayB0byBwcmV2ZW50IHRoaXMgc2l0dWF0aW9uLg0KPj4gDQo+PiBBZGRlZCBhIHN0YXRpYyBzcGlu
bG9jayB0byBwcmV2ZW50IGdzZXItPmlvcG9ydCBmcm9tIGJlY29taW5nIG51bGwgDQo+PiBhZnRl
ciB0aGUgbmV3bHkgYWRkZWQgY2hlY2suDQoNCj5JbiBsb29raW5nIGF0IHRoaXMgZnVydGhlciwg
c2hvdWxkbid0IHdlIGp1c3QgYmUgbW92aW5nIGFyb3VuZCB3aGVyZSB3ZSBjYWxsIHVzYl9lcF9k
aXNhYmxlKCkgaW4gZ3NlcmlhbF9kaXNjb25uZWN0KCk/DQoNCj5DYW4ndCB3ZSBzaHV0IGRvd24g
dGhlIGVuZHBvaW50cyBfQkVGT1JFXyB3ZSBzZXQgdGhlIHBvcnQgc3RydWN0dXJlcyB0byBOVUxM
PyAgQWZ0ZXIgdGhlIGVuZHBvaW50cyBhcmUgc3RvcHBlZCwgdGhlbiB3ZSBrbm93IHRoYXQgdGhl
cmUgaXMgbm8gb3V0c3RhbmRpbmcgaS9vIHBvc3NpYmxlIGFuZCB0aGVuIHdlIGNhbiBjbGVhbiB1
cCBwcm9wZXJseT8NCg0KPk5vdCB0byBzYXkgdGhhdCB5b3VyIGNoYW5nZSBkb2Vzbid0IGZpeCB0
aGUgcmFjZSBjb25kaXRpb24gaGVyZSwgYnV0IGNsZWFuaW5nIHVwIHRoaW5ncyBpbiB0aGUgcHJv
cGVyIG9yZGVyIG1pZ2h0IGJlIHRoZSBiZXR0ZXIgd2F5IGFzIHRoZW4gdGhlcmUgY2FuIG5vdCBi
ZSBhbnkgcmFjZSBjb25kaXRpb25zIGF0IGFsbD8NCg0KPkhhdmUgeW91IHRyaWVkIHRoYXQ/DQoN
ClRoYW5rIHlvdSBmb3IgeW91ciBndWlkYW5jZSwgd2Ugc3R1ZGllZCBhbmQgdHJpZWQuDQoNClRo
YW5rcw0K

