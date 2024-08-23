Return-Path: <linux-kernel+bounces-298382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF3B95C686
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 09:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8B16285585
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 07:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AD213B5B6;
	Fri, 23 Aug 2024 07:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Orag+db9"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2079.outbound.protection.outlook.com [40.107.215.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3DC5FBBA
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 07:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724398031; cv=fail; b=ISxtOy8ycHxu73ydkiIrlzYvVEBRrmvJ7kMdjYC2aU4yM+4jBRA+xzhGdtgeIYrLXCjZJd58ufw6IvQZUqaiDUW5/P9szSR4XsQFe8IwXdifNu4mwjSgIyQyDLANEsU/qlsIpuXRHkD1Ojqo912uBVPstVRC95qkH7hoLMD7W0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724398031; c=relaxed/simple;
	bh=diW9dVgz5nEUaaDb6/z+twqIikTcP8nd0GAx7tbEPX8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LBv8OUSI7iTFr1R4t73J5UgkFFABTgsr3hRarnvycKPCVcccOsCFI0a92VzoX0CEtdL+c5fXASdDjERes+/ZDT31d82cMoqQlhA6f+jGkLGZzDBvkzSdPpBzNMz8OOT+zJjw1qhjL3V97+xnmXP+J4VR+TiZMnXDNLwDDmd+hwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Orag+db9; arc=fail smtp.client-ip=40.107.215.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k7ArrRCMOZQK3zA1XOfN3fazGQX0FfMGVmDJkyKqEtcgald7XKNyBhXpKTMAMM+IWATNVljPSSxzIZtE0cpQKqqAPyaaO0+4Nm3F+kxiVmCXeCUj7Dz09McpzeBjM5hH3fv2/muYqvS4Kl0e1lIQux2mz0ghWaZ70lbE51KNrfMB865XxJmTCl8zoDf4xzQVrepGP36CDMFYrksddNErmMLQj1UG/DW63hG2OxQ7XTrsew82leKSpB3V+gy/bWVtSF5p8FjRfjnqf7435Hll8I9JRch8J6fIpe5J1wU/bfwD16mrDULrf3+NfbKv6AiTer5O6q3BJ6DmppMgPe5ROw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=diW9dVgz5nEUaaDb6/z+twqIikTcP8nd0GAx7tbEPX8=;
 b=vtfFrt2wvphx0eV6n96uLph+eaOM+gDfxCUNSj728k2KbeTjuEQ3KDhWmaQWkeAd3SMQ2pkCxZwLjXqSF+wOIuoB6/kwEFK0l9F4uLa7NCCM9v30+o066zUrjNU15c7BRLRHeu3Ya3QIWx6sjZce6eA6znm//wxWw5/dMmrqNR+nKGmIp6B5EFd8g9sicSUIcjX7XfnygJi3g3ooREeYQMJoNuM+wG9nlEi6LCWjk8NwBmfqOH5hWyqRXwqZkKGoznHhDScpNTjdfgKliUmbaEplbz/B5CyOEOoQGyf756JXCAB2GmRZ/KYGeiobu7nPBYoXj8YViA8nMgHCHTD1Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=diW9dVgz5nEUaaDb6/z+twqIikTcP8nd0GAx7tbEPX8=;
 b=Orag+db9kJ/2k4+13cwXmXkQ09VcfdvyzawmpMeCyvnlxF89IxZuNlTJ9eOsIjg3mnSaE8Ngp26GRQd9XWE2B4YWWM8y5TDO4dMEZJlvQMaMWWidXPiyr4KnvsC+l/8ctFcQnWMydVWgTmCpeXWD4WA85WvE8lDaZfHetGLAzNzfrKFmXIGlG3uh9xLNkj4POjKjLTqIEAfgk1VIAzSctUuFo5RDdMxi2Z5sgHVHAc/8Xl35o6xLs1VZZSWu57LTDPFUUxYj2JiAXt4d+JYASGI2kX7SUVVXiTsg8Hg45acrA4dgh7kfZv1EPDYhV+ju5yWzqbeyJQBKJYcjfad3dw==
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com (2603:1096:400:82::8)
 by KL1PR06MB6944.apcprd06.prod.outlook.com (2603:1096:820:125::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Fri, 23 Aug
 2024 07:27:04 +0000
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70]) by TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70%7]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 07:27:04 +0000
From: =?utf-8?B?5LqO5L286Imv?= <yujiaoliang@vivo.com>
To: Tzung-Bi Shih <tzungbi@kernel.org>
CC: Benson Leung <bleung@chromium.org>, "chrome-platform@lists.linux.dev"
	<chrome-platform@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, opensource.kernel
	<opensource.kernel@vivo.com>
Subject: Re: [PATCH v2] platform/chrome: chromeos_laptop: Use kmemdup_array
 instead of kmemdup for multiple allocation
Thread-Topic: [PATCH v2] platform/chrome: chromeos_laptop: Use kmemdup_array
 instead of kmemdup for multiple allocation
Thread-Index: AQHa870BghnJ9mJdnEWaeYhzq8VCubIzNYOAgAE+tYA=
Date: Fri, 23 Aug 2024 07:27:04 +0000
Message-ID: <2211f64f-5bce-4f90-bfa6-61774357c38b@vivo.com>
References: <20240821112629.596298-1-yujiaoliang@vivo.com>
 <Zscubf28qLgzsUuz@tzungbi-laptop>
In-Reply-To: <Zscubf28qLgzsUuz@tzungbi-laptop>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4461:EE_|KL1PR06MB6944:EE_
x-ms-office365-filtering-correlation-id: a7bc183c-4712-4a1c-1764-08dcc344fc8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UUZsMXJ3dGNqWmVJWXRQZ012UTZvQko5M1BRQllkR2Q0VFFLTGdTeG5sR1lm?=
 =?utf-8?B?d1RpazZwRnBMVmlEemorZWNlQmhKTGdHT1BrZmlMeWxXUW1rSlNHOFR5TTFy?=
 =?utf-8?B?VnY2eDVMcjM5N0tLdDVSR0lxQzVlblZBckV1SzFOOWp1QTVKamRrUmNKeXZZ?=
 =?utf-8?B?SnhLOWcwckd0WEoyQUhxTjVFOU90V2h4azM2YTZLRlNmNUVDemVqZWpjT1FT?=
 =?utf-8?B?bWJEek5xSmFsVmRRQXVGWTBXZE5qSW40WG51b3RYdWtMSldFdWxJN2RDTGJ1?=
 =?utf-8?B?RFhSUFN1S1pQZVBodm1nZHJoWnRISFRIa0NSMUx1cWtTZXl0ODhYNnpPSEhG?=
 =?utf-8?B?RzM1Mzd6UHdTQjVoS2kwM1NMdndJUmpoS3dOTDc3QU5HZ2srM2l4OStGRGZY?=
 =?utf-8?B?SXgwSUo4YjdscTI2Q3k3aDFiK1owTFB0ODlKSllsNGgxdWdVcURJUFkvRDJL?=
 =?utf-8?B?aTA3SE1oek1yS3VYOGVrVWl0NVc0cUFCcnIxU0x4OXJVUEViYjMvdHpBSDMx?=
 =?utf-8?B?TmN0cHlHWmdHdXZDNXVpaTVnUUdjNDNpTnNybncwVWVwM0pLcU5HL1NZNjRq?=
 =?utf-8?B?ZThiOVdkYkxveG9xTXU0R2JZUE9mMmtaWHpwRzZNYlF5Q0xwYW1vZk9SRzdj?=
 =?utf-8?B?T0ZXd3NydWprMXZKRFhMNUxwNmYvU0hiUHZ5Vk1wcW5lL1hzL2lZWG12MUJR?=
 =?utf-8?B?d2FBSUFMT0JHdFpDWE5FTkhPMUVYYnVtcUh1OHlRNkJMSCtpdFlqQVZsVkZI?=
 =?utf-8?B?MDhuRkVDdXg3YkNGL0wzL09MejNPYnVCOGNOVWVIeE5PQUsxVitRY1dPbVJC?=
 =?utf-8?B?L05NSUtXZjNPcmZPeDdwRUFtN1E0cDFGNUtwNGFCNnBkS1g0VDN0UUtvaXhZ?=
 =?utf-8?B?Ym82aHVGZjFuWURYZzFFNWhBWVJrZlRVL0xJck9nMHlIckNDang1YmROWWlT?=
 =?utf-8?B?eExlcGM2ZzdJUDM5UnJLdGFZUzViVGVBSjFEb280R2tLTDhkY2FRYTVOQWwv?=
 =?utf-8?B?VkMyc0RZSmpvOTI5WFc5L2M1a1VXSjU3MnAzaGdsR1d4bXVJRXoyN3EyclVs?=
 =?utf-8?B?Nm41djJzRmRCN2laK2x4YnM2dkE5c0grNFRnN2FSRG9JdHJNaUVkV2Q2VXBm?=
 =?utf-8?B?N1VmVXhnOFQ5Z3FXQ2w1cE90Rk42YVhORVJ3THU4NDJRaGV4dTNIOWRSbkZx?=
 =?utf-8?B?UmZFeExzblg1WlpCRjcxa05MMjFadWh2a2NBSHhXZ2dMWC9Yd0VvTCt4ZVJn?=
 =?utf-8?B?dXZIWFY0UHJIZnhFQXFwRDZRb1p4Q3Q5LzAyQXB1eXJKbmJWM1N1SllGMzJi?=
 =?utf-8?B?ZHdkVmxWa0NjcTMvUHYrVVozT0ZWejhGaXgvRDJYZTZWWE1PSjBqM053VGhF?=
 =?utf-8?B?YXZXTkZOeURTZDVSYUJNSEtJbll4TXc2MndOc0s5eTdnZUNteUk0RVJoUC9n?=
 =?utf-8?B?UmUyNjRwS1g5YzkxY0xONzFiclJTVFY3Y3M4UHBHdUJ4SkpSbzZVOVM5a0NO?=
 =?utf-8?B?elFoSkJCOFRacGlNTTNoMWtOWldTM280d3VGd0JwNVBJM1FaMkNVVHhkQ3Q4?=
 =?utf-8?B?dnJ3R2QrR2RESWljRE1EM29qTTdLeHA4NDJHOFYzRjI3UDFwbSt2ckJFcTky?=
 =?utf-8?B?QTdac3drSUNMNUdXb1kzNWphVG5xRk5aMlVRdXZGVFVMUEVtdnRBcVlVMEZn?=
 =?utf-8?B?WDNvYkxlMjA3WlpsNHpKMHdFdmE1OWRIR2RzMWtkbHE5Q0JkSHhrbm5EMERX?=
 =?utf-8?B?VjVjc2Y5OVNyekw2T1JQb1hmVG1SclRMSnRiR25GOUxRQnNqQVF0cDdQOTdV?=
 =?utf-8?B?WjVaeHdXYjc1eUcva3o4RkU0blQrNGNYMGdrcElmbEI2NnpJTk45TjVpaDU0?=
 =?utf-8?B?bFpGSmJ6VmlneUdRdU5ZMTkzZ2tLNlA5TjNXamJJT3AvbWc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4461.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cmpvdWxBTWxEbWpHejA3SWdLQjJYeERaSVhlYVYrbmRXV1N4cVlvTmdRTWkz?=
 =?utf-8?B?STk5Z3h3eWtqNjlta0VHYktsZnFvSndLeHVPUVQwc21seUZJWGlib0hRVEEv?=
 =?utf-8?B?Q0oxQTBycG9PSFVQaWcrMjg4NDE4dEZST3ZuVzZoOXYzc1pxS2NOdEpwM0ZO?=
 =?utf-8?B?TVhJOVkyc1dlV0tSVGZiMHhrQW1uT0lxd0hPM3kvb0c2V1REWXlJOTNOVzVL?=
 =?utf-8?B?U20rYW9ORXFjbWR1cVV2RkRsdlcrK0VTQjhUMHROZ2lEQ0sydTcrZG9sV0Rn?=
 =?utf-8?B?dGRpSEg5czRqMElxQXMvZERrSzBLUjZVT0VsZWFKaEtCcU9PMkJSOWZKT1ZI?=
 =?utf-8?B?S1RCZ1cza1Fwd0FxN1d0amRla3U0OVlrR0FlY1I0Y28xSUl2VVdWOXBlRGV0?=
 =?utf-8?B?VXR6R1Vwb2dMbmI0K2JyZ0JoU2pUL1NMdWxXbEtJdEE2dzUrdUR2VDJHZEN1?=
 =?utf-8?B?SE9VQm5USkF4MVZjSWllOTMvK3ovT1cycU1vL3UzN09nL2pNUlYvSjlXbnYr?=
 =?utf-8?B?dVJQbTVGVnU1enRzVmpTY1BkaGNlUDBRVTZQZGtBVmtrTVNLdGprR0dDZzhZ?=
 =?utf-8?B?VVpmRVBHVnVkQXQvM1dEcHZSRHltYUxjall1eStTNmVuSnBEcmVIZVZGczhi?=
 =?utf-8?B?OUtUUkpCdjJJeDk0YUdlaFdoQWtScGNnM2EyR1UwdzJUdGpqOTEwVDJabkJH?=
 =?utf-8?B?OERpQVcwRXpncjBGRDVoV1BWQVoxMVZ0TkpQT095K0lSWHBNcnZpRDJ1ZDhn?=
 =?utf-8?B?SURvWmpaSUxTWWdTNm54amJYUjNIS2ppcEhHQTM5Ti9PTTExbWtqRHVGMHRa?=
 =?utf-8?B?RzFSM01oVWtsUXUyZXExS01zajZseUFUNTRiT1VVdDdkOXpiQkNWL0VIOXBX?=
 =?utf-8?B?N2JTczRMRnZqRWlraFlxcElzamZBYTlvMWsrd25sb0czbk5Lc2l6elE5UGt1?=
 =?utf-8?B?bjJLczAvd1FBK2Z2K0JhemF1WEJueDV2QzVUbUNiVlIyZ0NwQkUzZDY1c0FJ?=
 =?utf-8?B?TmF3ci81YTRpQmlGK0JtSFJTbE44MzdiNGZIazhRdFlqUjhWeHg5azB6dTdW?=
 =?utf-8?B?VEJscXRDQkovT21jYUFRbEYrbnNsbEwrRkM1MEdzMVVITmlrUUxjZS9sK1dL?=
 =?utf-8?B?YTAxdnJhSGNyWEs2blpLTDRYZkpaYXlaQnlDQ256SEpmSlJCblNLbVUwKzNh?=
 =?utf-8?B?dHVQUzBDemQrc29TYlNSalZkQnpUZDBERXdETVlQejFHS2VRbEkwRERzMkM2?=
 =?utf-8?B?eStGaUxkT2UwM2ZtQUlhODBnRjg0NTlzMjlrNEZ0MTBkMXY2aGJDcnJTV0Y4?=
 =?utf-8?B?MnZxcW5hL2M1R0ZuNHIxR2lJbkx4dDN1SVhZQ05acWlmK0l2em5uR2RkTVpQ?=
 =?utf-8?B?dkdaZEZyaExGOU1MNUZzbE5Kek1DRVBDZGI0ME1iNUFNVkVaMTkxdS81MXFL?=
 =?utf-8?B?Wm5wcG40UWpJdDVtb0RhSWxOdXRzRGhpN1VPbS9mSEk4K1cwNGtsZ2Z3OGZW?=
 =?utf-8?B?cXJISHFjVzljdk1uSmhvczFST09lNUJsTGZSeFBMWi9xbndqd3N5N3RyL2NZ?=
 =?utf-8?B?NXU2ZjlUd0NiL2JyaS9kL1hnNUVaa3lKZTNhQy9JTGt3QWtBNlMvdWxkbnJl?=
 =?utf-8?B?R3Y3WXJXem1JbkwzNkpSTUxKTFdTeU9qQUZlT3RBNnhKVlVQOW41TnZOYzcz?=
 =?utf-8?B?VjZPT0hsMHNLZVoxSS9LSU1BZis1SjRmSlBlTjFSR2k0L1phR0FwNTliOXJW?=
 =?utf-8?B?ZjRyaGtFalIvWjRtelE3Y2Fua2NGRXJrUXB2WTI2SW5vazBuKzNieWVrTUto?=
 =?utf-8?B?WWxaZDNsSFF1UWVtSWRaais1UzlzSUpVdFVpRmRVcmlvRFEyYis4M3RtVktP?=
 =?utf-8?B?blY3WFd6citJby93MExVdk1ZT09RY0RjcW1HL1BHTk1JZVpXRUdSNk9IZTA5?=
 =?utf-8?B?QVhVc2dXQmJlV296bGZ2djlTVEZ6aHpwaWlBN05zL3o5YjZBa0RYcnl1Q3ll?=
 =?utf-8?B?U2FnbUpmTGllSmxkTlVSOEFoQi8yWUw3TFpjckVaTElwbnc2R0w4QWQ0UUt3?=
 =?utf-8?B?M3Zha0JzbEprN1YzcHZXMFd3Y2s2eXdlZWhCeTk5bXhaaC9MUFBvalo2aUVV?=
 =?utf-8?Q?ej5o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <55ADEA8A5A9EBD4981E533321FE895BA@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4461.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7bc183c-4712-4a1c-1764-08dcc344fc8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2024 07:27:04.1575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KJ7I4lsiO6CjuNotHziZqs0H4DYeV5tCdKRvUE2HNEvFyiCkkaflmy5jIKvBYO22/kwegO8er0inQ2YuVBQZaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6944

5ZyoIDIwMjQvOC8yMiAyMDoyNiwgVHp1bmctQmkgU2hpaCDlhpnpgZM6DQo+IE9uIFdlZCwgQXVn
IDIxLCAyMDI0IGF0IDA3OjI2OjI5UE0gKzA4MDAsIFl1IEppYW9saWFuZyB3cm90ZToNCj4+IHYy
Og0KPj4gLVVzZSBzaXplb2YoKmkyY19wZXJpcGhlcmFscykgaW5zdGVhZCBvZiBzaXplb2YoKnNy
Yy0+aTJjX3BlcmlwaGVyYWxzKQ0KPj4gLUZvcm1hdCBjb2RlDQo+IFBsZWFzZSBtb3ZlIHRoZSBj
aGFuZ2Vsb2dzIGFmdGVyICItLS0iIG5leHQgdGltZSBzbyB0aGF0IHRoZXkgd29uJ3QgYmUgcGFy
dCBvZg0KPiBjb21taXQgbWVzc2FnZS4NCj4NCj4+IFJldmlld2VkLWJ5OiBDaHJpc3RvcGhlIEpB
SUxMRVQgPGNocmlzdG9waGUuamFpbGxldEB3YW5hZG9vLmZyPg0KPiBJIGRpZG4ndCBzZWUgdGhl
IHRhZyB3YXMgcHJvdmlkZWQgaW4gdGhlIG1haWxpbmcgbGlzdC4NCg0KSGksDQoNCkkndmUgdXBk
YXRlZCB0aGUgcG9zaXRpb24gb2YgdGhlIGNoYW5nZWxvZ3MgYW5kIFItYiB0YWdzLiBUaGFua3N+
DQoNCkJlc3QgUmVnYXJkcywNCg0KWXUNCg0K

