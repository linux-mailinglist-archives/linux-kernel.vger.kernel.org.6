Return-Path: <linux-kernel+bounces-311530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A6C968A24
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1158CB235D0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06151A2652;
	Mon,  2 Sep 2024 14:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="lJRc3ypK"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2079.outbound.protection.outlook.com [40.107.117.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDC01A2638;
	Mon,  2 Sep 2024 14:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725287935; cv=fail; b=lNvYeCfS8MoiGrPnPKBmQ4otxsS7t3gAg7GA0P9LaMnTLsBhpKocDYj3uFxKTPREzn+ZA09k9Tgq0dBxWuHOFxX+FAx5/kSG48BeFJ9vw2E6pAIY1DMPPmgfbHYo9NtOUhj8RoJqMcU4pWqVl9qDNobcOpanrosntpL4Yy2EAb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725287935; c=relaxed/simple;
	bh=P222rMvrTh1KHwvSL7AyxRKJ0ZxZ7Vnz0d1Tpy563Gw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=amg3GTj76I7/rWH+91GcjarxQxZr8BtO7f8Emmtf92l11N9w+rgeFM2MVqL7Ase2embfpT7TiJ6KNqDOH9TpyrhNeL31AGusHlrTR/idVlq53LyYL/VwQFGkVXPDakeLA3myxYG+56l2k1nTec9r78rEFTF30S49CwCCms5RD4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=lJRc3ypK; arc=fail smtp.client-ip=40.107.117.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aeg+gBHeQPOG5+x9T5OBvxH0MOjXyRT8sdy9mrf/rK0D2Ke2UwINC4XNMWRxd2ElSKcfK/mvsErop06ViGb19K9iZbWA33Gx4wmS7njFfQRaEOPq5QlLC44YlrKdt+NVQJYcLSA8Vmf+QqpEl+y2GB3b4iwtHrdO2Iw2gaJWf8sZiWYlybsMdDBOny/itIn81YEEZLge/o1LT4LDpEIRoEC/yXmpHCWvcfRxTu2wroauXf2h5tlZ6PG3ck8rIs5qHxTCbgEVjIKs9bLf4cPjnY3TwxAQaPHY+Jo0HVGQYtP2m8LVC9XtM625M5q5hFaxzqkIsBQgzTmMyklcKah/iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P222rMvrTh1KHwvSL7AyxRKJ0ZxZ7Vnz0d1Tpy563Gw=;
 b=tw7gauszMxSKyedbgLP3jUz4aICAEZMY1XufpFp2TkKlO135nNkj5fC5KzW5k0RLFrlq2eNmzNwN9HF0UH97TOJUoRSzYQk4Q21KDKfmRcwjC6hyxgdUYIuoG65VVIGySR3FWxSmY+QnJNI1lb0Hb4dMeYsVOZHMBQmLPmvprRSPtdNNBspGt5TdeipBMxUgkvH6PbRwyvYMEREHfN4hQ+W/pV3fCFfnLnIUButrctrBWB9ufRZAQb1/vl5jwKiAWLfUjhlM5kiLvvNg9AH6qrmcIe3F6oJYMG4cq/O/Chwu3s70AtbpcFPsMZNalVa67y1Nqdxfda/6vAB31wqvAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P222rMvrTh1KHwvSL7AyxRKJ0ZxZ7Vnz0d1Tpy563Gw=;
 b=lJRc3ypKSIwXcrvLi0pD5dfcdoZLpArBg84dZBAmeHx/sCZhpz53vkcZeT2HlQ1T8FVzW8N02mP5r1xNnEVagxfOTCgTeZovEeyEmpTfQ5j8BWBNIJeNmneE/Rh8hCwDMb1nLS79JnjUn5i/xUYr4NvmHd7QPeW6UUZ9RBOMO/UFMG7eBxx9M4nn1YXa5J8KJNtR7cFSoRVH5E/+UvChClzzfVgZkFKumyuoilAvXMhkkuwVGczxLlo98btvqFMu+q8s8HLGzQoiwko5Zc6Dnaj2KNS1aYpytmoX8nKoihE/dXm8Kizz99FroxWItJh0yvad37WZMFDtEUwjjo8Psw==
Received: from PUZPR06MB6224.apcprd06.prod.outlook.com (2603:1096:301:116::8)
 by SG2PR06MB5132.apcprd06.prod.outlook.com (2603:1096:4:1cf::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 2 Sep
 2024 14:38:48 +0000
Received: from PUZPR06MB6224.apcprd06.prod.outlook.com
 ([fe80::d489:3d1:904e:8b73]) by PUZPR06MB6224.apcprd06.prod.outlook.com
 ([fe80::d489:3d1:904e:8b73%3]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 14:38:48 +0000
From: =?utf-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Michael
 Nazzareno Trimarchi <michael@amarulasolutions.com>, Prashanth K
	<quic_prashk@quicinc.com>
CC: "quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	opensource.kernel <opensource.kernel@vivo.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, =?utf-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>
Subject:
 =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjldIHVzYjogZ2FkZ2V0OiB1X3NlcmlhbDogQWRk?=
 =?utf-8?B?IG51bGwgcG9pbnRlciBjaGVjayBpbiBnc19yZWFkX2NvbXBsZXRlICYgZ3Nf?=
 =?utf-8?Q?write=5Fcomplete?=
Thread-Topic: [PATCH v9] usb: gadget: u_serial: Add null pointer check in
 gs_read_complete & gs_write_complete
Thread-Index: Adr6Cd+UUO/sbS6xR4e70mPa/mlHZgDOySAg
Date: Mon, 2 Sep 2024 14:38:48 +0000
Message-ID:
 <PUZPR06MB6224FF88145DAA364464EA7FD2922@PUZPR06MB6224.apcprd06.prod.outlook.com>
References:
 <TYUPR06MB6217DE28012FFEC5E808DD64D2962@TYUPR06MB6217.apcprd06.prod.outlook.com>
In-Reply-To:
 <TYUPR06MB6217DE28012FFEC5E808DD64D2962@TYUPR06MB6217.apcprd06.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR06MB6224:EE_|SG2PR06MB5132:EE_
x-ms-office365-filtering-correlation-id: 06ae5f3f-7d44-46bd-50f1-08dccb5cf4a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aU1oQmFqemlCckpWdnQ2dkdFakQ1T2JoaldkcHNaVkRWYW5UVzdWcXhPY1VM?=
 =?utf-8?B?dFRhN1lzNmlwUkNOY1VkSyt1TWpRWjBvUEN0aC93OTVmRzJTV0FKM3FtM3JX?=
 =?utf-8?B?TVI3UTc5dzR4RWVhVkJTT09nMzZ3NEUyTVJFaGhiTUNKc0g2L2UxZHRpellO?=
 =?utf-8?B?OE9ZSkhJYUdFRkdzRFN3NThpVmtrSERMcFozdE9xMkM3bkFheFZxMytWNnVu?=
 =?utf-8?B?Qkl0UHdOQXZlSktBcGlBNUl2d3pLWkFWR0IwdHhodGZRQ1hJM2JiQ0hQM2dx?=
 =?utf-8?B?SERGWGkwdzNjbGo2elZPQ1ZNTG95SHh0a0I5bkU5LzRTUVNoUkpBVElDUlBa?=
 =?utf-8?B?TlBpY1pydlFZUkN5MVdEZmVKWFNGMnZNZHNoNXVGbzNpemhaSGdiV0xCMDN2?=
 =?utf-8?B?M2djeHBwSzArYThVK2tZeEVyYXZCVzJrRkQvQXdwQS8xRm9VbklyR0VrOGpv?=
 =?utf-8?B?ZTA4WGM5SXFjdjdicFFzMHBZeWx1Rm5yMEtsbVBlK085OE15UDNqc2pOWFJ3?=
 =?utf-8?B?akRlU0hzV1B2eHZKTHBRcHQ0MGhjN1lmQ1pCT1JjRkJnRUdjdVdwYkpBRndI?=
 =?utf-8?B?TGNzTjRwV0c0VGpUNEQ5TFZuazk0VnpTMjZtaTBaNElvM1dxSHQ2Y1hiVTNY?=
 =?utf-8?B?Tm43WCtuK2k4cmJUVnJOci85VlZaWHNlVVg1bGhoZ0dWV01NQW1zVzhnelA4?=
 =?utf-8?B?SXdxT0MwVkkyUnZsUDNCRW5GczN4WUoyVk1nOEtVVnBQaE5wOGx3VUc4L0ZM?=
 =?utf-8?B?OFBqVzhCWTdlTzMzOXdienF5RU5oSjRjaVlDYTNTWVF2YktvNWxIa3hXaUhO?=
 =?utf-8?B?VkkyRk5VY1BKNEJRS21ISlorMVJZWlpwSy9WRWhKM1RLcUN2byt2b2cwZGxT?=
 =?utf-8?B?aDhyaVhvMWtoL3EyVnVJUHhhbDZkempwSnRTRURWY1p2c040NVJKNFpYN1d5?=
 =?utf-8?B?N3V5ZkFwVmluSUtWaUJqRWJoWlpSSXBVSHk3OWxjWGtDN0JDVk9laElBc1Q5?=
 =?utf-8?B?dkV0UUs2cmowT3BneUJzZmF3UmhxUUliRUNsUGlvaElXS2pOZVdTQ0dFdDJV?=
 =?utf-8?B?SmJiejRla0hGbmRrR05SK1UrRTRnUnhsekM5eWJWWWRRS0ErNzFQczFLa05v?=
 =?utf-8?B?eUcxS1BoWms4VGtHUnNSbGJwaFovajg5ODVLV0kzUCs3UktXTzJWRmovM0VG?=
 =?utf-8?B?MlFJb3doOElzNUhLeTgzVHFteFRZQWVMTmFxOE04Z0RuTXk2TjZ3dkdqejlY?=
 =?utf-8?B?T1JMeFhjbUpWcGFOR01pTkN6WlNoMkxzY0wyVTBYZVVzcHJIVEhleFR3T3lC?=
 =?utf-8?B?MzViVVMvMUQ4aSthWk5vYlpsVU1meUIwTHRRQTJvbEVlc1dKTHdzZE03YVVj?=
 =?utf-8?B?YXhyUEpGYVVHa0REYmIxdmNqRjVlbi9uSC9XQlR6KzhmUFN5Q0tybkRSbitr?=
 =?utf-8?B?bnlsTnFCSk10SU4zeE9qckxuZU1jeEg1M1ZNeklLbnBMcFVoL0ZZT3J5RndP?=
 =?utf-8?B?UXZxK3grV054TTVFSWlZWk1zaHpqTFQ1TmgwYVlLS1lUOTlTMUpGZ21iM3BB?=
 =?utf-8?B?L0k0eS9rdDBRVmd0ZklkS1RWOVR3RWxCc3FWZ1doYXlkUGhSNmZyZVg1aVBL?=
 =?utf-8?B?K1ZKa2gzbjZBNmhMa1FuVGkrS2lIZ2plUnNYWStNRDZCWWtDMXQ0WnBUU2Zi?=
 =?utf-8?B?ZVhUVEw5MXdWZDdWSFljb3RnMlpnZlNiaW43THlSa003b3FrREo0S0pHR2RQ?=
 =?utf-8?B?Q2RpcUN1TStkYTJQS1dWaWx6akJGQlBveVRTNzRwL2lsUTc0TzRuQmFYUEgw?=
 =?utf-8?B?dnhTLzlncC9ld2JKY0lHaFVHRWcxM1hlNU9xQ1F3WjM1RmJMa2p0d3d3RTN3?=
 =?utf-8?B?QUJTcmRROThhb2VOa21PNGhhWU1oSHZ1b3Q3eXpISXY5c0E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB6224.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VlNKdUxNM1B1cmk4dDJMN3U1dDdPUURqdktzK1oxeGNHMW5uK2lDYkFoaHIz?=
 =?utf-8?B?ZWx6L1RaR2doMzUzTnNTSGw5OVE4cTAvN1BMUlErc1JlYk1ISXVSUE93bi9U?=
 =?utf-8?B?MWk2b2dOUUg5U3BvWXNOT0FBQlV5dWpvUlV3QUk1WDZvOGd5RW9IdytRbzVI?=
 =?utf-8?B?Q3JsRHZpWE5pZGVMcVlLTVJGNVo0QlRITmZLdGMxclVGU1FwZUc5dDV1d05z?=
 =?utf-8?B?ZGtTczhlK3dPTzc3OW1UOC9oVFRsSmZJNExBbUFJRjN5MWNOaXNicmI5ckEr?=
 =?utf-8?B?by95b2VwZm4xMzNyRnNnTTFncU5YVUN3eXJBSTgzVjNrN2QxRnNWWXVMWFAv?=
 =?utf-8?B?YytOVXZmTElKYzJHZ3RJRC9adlE0WnhUaEpOYWdnbHF1bTRuU1p2QlQ2Q0JO?=
 =?utf-8?B?d1diemg1R05oU2RBVmZDWENUajBnK3dqUW1JcmxvanNMRDc0c2RjbFlHMDUy?=
 =?utf-8?B?NXV6WjVUbis4MU02bnNPNHNYbjZ2K3BRZEVtMEluQlFtRC84a21ybzc4YUh0?=
 =?utf-8?B?UCsrNVVKOTQ5VVhKSjhEcjlqbDNiY3k4aHRLakoxY2NoNStmSUNYQWxrQ0lv?=
 =?utf-8?B?L3NOM1FHaUlzNFZ3VmJjYVFsOUV4OXdvMzVWb3RnZEt2TFp2QytQcDBKZWhs?=
 =?utf-8?B?WEI1bUZzeHFRZHVRaGpWSjl4dTZrZnBWaFd6UUt4Uk5heVNiRTBMQ05wRnB5?=
 =?utf-8?B?NXA3QjY1MjJvRnNtVThjYStwV3JIZGxYU1JsMEh4T2NnbXZmTHBCOFVFSVZ2?=
 =?utf-8?B?TEdRNlFMSFYwOHM2bVBHbmVYTTdTU3NqUVFpenpHWkNlOWI3RVFQSE1UNmc2?=
 =?utf-8?B?OVIvTEJXWDRLckhNZUxJdzh1SncvLzlrQUM3bVI0VDBwSDh3QkJRa3VOcHJt?=
 =?utf-8?B?WHlhcUNSeGlIOFBLYmovWEJWdHRHK3ZXcHYzbTIvQlRvWDlqQmg3SUNJVVg5?=
 =?utf-8?B?Z3p6eTFVOSt4cDE5WmlqcVgzbGJQNU12a2UxcXc5Zy9UcS81cjRQZjM3dk5z?=
 =?utf-8?B?ZE9RbkxZd2h5ZlQ4V3ZSd0FMY1hiSWpydjZoOGhYdWd3cm03aHhXY0E1bjZU?=
 =?utf-8?B?Szh1RVpzOXI1TWFzOWRndzI1dTk3SVhYMEZkMllnb3FBTE1EcVhja3phSDBl?=
 =?utf-8?B?bkY2dkxoaTBMa3dqV045MGNjbGZ1a0kydlNRMnQ0ZFcxYVJ2aFRBcnlCa3BX?=
 =?utf-8?B?N2kzeGlaR1hJOFczMVBCUEVLNFVCaVA3NzBZRHZCVUZlUXhvdzQ1ODRZMGFl?=
 =?utf-8?B?ZlVHbzZXMU05c3gxeUh1cFdyWXo0THdFYmxqUzQxRlZMTHZWQ1dYVU1aajJa?=
 =?utf-8?B?S3hhcm5iZFJ5UzYxT1ZpTXdaVkttSFpmWnQ2M3hKQmRCRUhiazY4N2VQRWgy?=
 =?utf-8?B?Y0I1WmlDd0hHcldPZ0JlZEs0UUJPT2lpKzIwVDdzNUU3L3F5eDhpTmloT28w?=
 =?utf-8?B?OHZTbUNVanhHckx4amN6eE0zbTZaN09KWTJkQTlYdDRpaG4xNDZqK3dKWHJF?=
 =?utf-8?B?YmlPeEI3aTV0ZkozcVRaVDRWMTFWc2JiT1RBcFduV0JhVkU3aEUrZE93M1k0?=
 =?utf-8?B?VXAxcGsxY0hLdlBaUVFPY0pOL29mWS9LOHN6UjViajJMaXZ3QUdDMndFcUtN?=
 =?utf-8?B?VUZPTG1CaXhGR1RqWFdlSW9yczhFOER3Z20rVDNYRWdER29maTFVR2xzVGJV?=
 =?utf-8?B?dk5UeFFlTE5Wa0VzbWdkVDFiRzNmbkpTb0NFZFBWNU9Pa09hVW1JT0h6WmVs?=
 =?utf-8?B?UURXMUxSQTRqSy9hMmhZV1BpRGRzZnpGMFI2cjZjK3RQcGltM21tSEZmeW10?=
 =?utf-8?B?WDZMcDVjbTJ2ZnBHK1BTbG5ZclY3OUdwSU01a2trdVhGNjFWS3VpdTdJbENK?=
 =?utf-8?B?Nkk2UGZPeU9XdTV4ZndmNGE4QVh2RnAvNlFNOVE2cXJmMDhhQUY3eGplcUtv?=
 =?utf-8?B?ZDFRN3p1WDFEbUlaYitlbzZrN3FmcUIvMVhGdXhPNVpSQkN2WFd1WGtheUda?=
 =?utf-8?B?c0lMY0dDSGFDRko0UDJ3Q2dOMWFDZ01wWWQyMnZxenpleDRJaE9LTzExcUJa?=
 =?utf-8?B?M1RhcUIzV2MzWlFPM1hKNEVRMm90aFV1TlVydmp3b2h4U0h6RkorcExUQmRy?=
 =?utf-8?Q?KMj0=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB6224.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06ae5f3f-7d44-46bd-50f1-08dccb5cf4a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2024 14:38:48.1285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fBWdnF5EmVbfqLFnANb5N6W/6WJXvUGjsU6deaHBMloZm+P6tp3FmbM4sHPzzJshvEZ2r/vmozcu+bZp7WdRAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5132

UGluZy4uLi4uLg0KDQo+RnJvbTogTGlhbnFpbiBIdSA8aHVsaWFucWluQHZpdm8uY29tPg0KPg0K
PkNvbnNpZGVyaW5nIHRoYXQgaW4gc29tZSBleHRyZW1lIGNhc2VzLCB3aGVuIHRoZSB1bmJpbmQg
b3BlcmF0aW9uIGlzIGJlaW5nIGV4ZWN1dGVkLCBnc2VyaWFsX2Rpc2Nvbm5lY3QgaGFzIGFscmVh
ZHkgY2xlYXJlZCBnc2VyLT5pb3BvcnQsIHRyaWdnZXJpbmcgYSBnYWRnZXQgcmVjb25maWd1cmF0
aW9uIGF0IHRoaXMgdGltZSBhbmQgZ3NfcmVhZF9jb21wbGV0ZSBnZXRzIGNhbGxlZCBhZnRlcndh
cmRzLCB3aGljaCByZXN1bHRzIGluIGFjY2Vzc2luZyBudWxsIHBvaW50ZXIsIGFkZCBhIG51bGwg
cG9pbnRlciBjaGVjayB0byBwcmV2ZW50IHRoaXMgc2l0dWF0aW9uLg0KPg0KPkFkZGVkIGEgc3Rh
dGljIHNwaW5sb2NrIHRvIHByZXZlbnQgZ3Nlci0+aW9wb3J0IGZyb20gYmVjb21pbmcgbnVsbCBh
ZnRlciB0aGUgbmV3bHkgYWRkZWQgY2hlY2suDQo+DQo+VW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwg
TlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGF0IHZpcnR1YWwgYWRkcmVzcyAwMDAwMDAwMDAwMDAw
MWE4IHBjIDogZ3NfcmVhZF9jb21wbGV0ZSsweDU4LzB4MjQwIGxyIDogdXNiX2dhZGdldF9naXZl
YmFja19yZXF1ZXN0KzB4NDAvMHgxNjANCj5zcCA6IGZmZmZmZmMwMGYxNTM5YzANCj54Mjk6IGZm
ZmZmZmMwMGYxNTM5YzAgeDI4OiBmZmZmZmY4MDAyYTMwMDAwIHgyNzogMDAwMDAwMDAwMDAwMDAw
MA0KPngyNjogZmZmZmZmODAwMmEzMDAwMCB4MjU6IDAwMDAwMDAwMDAwMDAwMDAgeDI0OiBmZmZm
ZmY4MDAyYTMwMDAwDQo+eDIzOiBmZmZmZmY4MDAyZmY5YTcwIHgyMjogZmZmZmZmODk4ZTdhN2Iw
MCB4MjE6IGZmZmZmZjgwM2M5YWY5ZDgNCj54MjA6IGZmZmZmZjg5OGU3YTdiMDAgeDE5OiAwMDAw
MDAwMDAwMDAwMWE4IHgxODogZmZmZmZmYzAwOTlmZDA5OA0KPngxNzogMDAwMDAwMDAwMDAwMTAw
MCB4MTY6IDAwMDAwMDAwODAwMDAwMDAgeDE1OiAwMDAwMDAwYWMxMjAwMDAwDQo+eDE0OiAwMDAw
MDAwMDAwMDAwMDAzIHgxMzogMDAwMDAwMDAwMDAwZDVlOCB4MTI6IDAwMDAwMDAzNTVjMzE0YWMN
Cj54MTE6IDAwMDAwMDAwMDAwMDAwMTUgeDEwOiAwMDAwMDAwMDAwMDAwMDEyIHg5IDogMDAwMDAw
MDAwMDAwMDAwOA0KPng4IDogMDAwMDAwMDAwMDAwMDAwMCB4NyA6IDAwMDAwMDAwMDAwMDAwMDAg
eDYgOiBmZmZmZmY4ODdjZDEyMDAwDQo+eDUgOiAwMDAwMDAwMDAwMDAwMDAyIHg0IDogZmZmZmZm
YzAwZjliMDdmMCB4MyA6IGZmZmZmZmMwMGYxNTM4ZDANCj54MiA6IDAwMDAwMDAwMDAwMDAwMDEg
eDEgOiAwMDAwMDAwMDAwMDAwMDAwIHgwIDogMDAwMDAwMDAwMDAwMDFhOCBDYWxsIHRyYWNlOg0K
PmdzX3JlYWRfY29tcGxldGUrMHg1OC8weDI0MA0KPnVzYl9nYWRnZXRfZ2l2ZWJhY2tfcmVxdWVz
dCsweDQwLzB4MTYwDQo+ZHdjM19yZW1vdmVfcmVxdWVzdHMrMHgxNzAvMHg0ODQNCj5kd2MzX2Vw
MF9vdXRfc3RhcnQrMHhiMC8weDFkNA0KPl9fZHdjM19nYWRnZXRfc3RhcnQrMHgyNWMvMHg3MjAN
Cj5rcmV0cHJvYmVfdHJhbXBvbGluZS5jZmlfanQrMHgwLzB4OA0KPmtyZXRwcm9iZV90cmFtcG9s
aW5lLmNmaV9qdCsweDAvMHg4DQo+dWRjX2JpbmRfdG9fZHJpdmVyKzB4MWQ4LzB4MzAwDQo+dXNi
X2dhZGdldF9wcm9iZV9kcml2ZXIrMHhhOC8weDFkYw0KPmdhZGdldF9kZXZfZGVzY19VRENfc3Rv
cmUrMHgxM2MvMHgxODgNCj5jb25maWdmc193cml0ZV9pdGVyKzB4MTYwLzB4MWY0DQo+dmZzX3dy
aXRlKzB4MmQwLzB4NDBjDQo+a3N5c193cml0ZSsweDdjLzB4ZjANCj5fX2FybTY0X3N5c193cml0
ZSsweDIwLzB4MzANCj5pbnZva2Vfc3lzY2FsbCsweDYwLzB4MTUwDQo+ZWwwX3N2Y19jb21tb24r
MHg4Yy8weGY4DQo+ZG9fZWwwX3N2YysweDI4LzB4YTANCj5lbDBfc3ZjKzB4MjQvMHg4NA0KPmVs
MHRfNjRfc3luY19oYW5kbGVyKzB4ODgvMHhlYw0KPmVsMHRfNjRfc3luYysweDFiNC8weDFiOA0K
PkNvZGU6IGFhMWYwM2UxIGFhMTMwM2UwIDUyODAwMDIyIDJhMDEwM2U4ICg4OGU4N2U2MikgLS0t
WyBlbmQgdHJhY2UgOTM4ODQ3MzI3YTczOTE3MiBdLS0tIEtlcm5lbCBwYW5pYyAtIG5vdCBzeW5j
aW5nOiBPb3BzOiBGYXRhbCBleGNlcHRpb24NCj4NCj5GaXhlczogYzFkY2E1NjJiZThhICgidXNi
IGdhZGdldDogc3BsaXQgb3V0IHNlcmlhbCBjb3JlIikNCj5DYzogc3RhYmxlQHZnZXIua2VybmVs
Lm9yZw0KPlN1Z2dlc3RlZC1ieTogTWljaGFlbCBOYXp6YXJlbm8gVHJpbWFyY2hpIDxtaWNoYWVs
QGFtYXJ1bGFzb2x1dGlvbnMuY29tPg0KPlN1Z2dlc3RlZC1ieTogUHJhc2hhbnRoIEsgPHF1aWNf
cHJhc2hrQHF1aWNpbmMuY29tPg0KPlNpZ25lZC1vZmYtYnk6IExpYW5xaW4gSHUgPGh1bGlhbnFp
bkB2aXZvLmNvbT4NCj4tLS0NCj52OTogQWRkIGdhZGdldCByZWNvbmZpZ3VyYXRpb24gZGVzY3Jp
cHRpb24gaW4gY29tbWl0IG1lc3NhZ2UuDQo+djg6IFVwZGF0ZWQgcGF0Y2ggc3VibWlzc2lvbiBk
ZXNjcmlwdGlvbiBhcyBzdWdnZXN0ZWQgaW4gdjcgZGlzY3Vzc2lvbi4NCj52NzogUmVtb3ZlIGNv
ZGUgY29tbWVudHMuDQo+djY6IFVwZGF0ZSB0aGUgY29tbWl0IHRleHQuDQo+djU6IEFkZCB0aGUg
Rml4ZXMgdGFnLg0KPnY0OiBDQyBzdGFibGUga2VybmVsLg0KPnYzOiBBZGQgc2VyaWFsX3BvcnRf
bG9jayBwcm90ZWN0aW9uIHdoZW4gY2hlY2tpbmcgcG9ydCBwb2ludGVyLg0KPnYyOiBPcHRpbWl6
ZSBjb2RlIGNvbW1lbnRzLg0KPnYxOiBEZWxldGUgbG9nIHByaW50aW5nLg0KPg0KPiBkcml2ZXJz
L3VzYi9nYWRnZXQvZnVuY3Rpb24vdV9zZXJpYWwuYyB8IDMxICsrKysrKysrKysrKysrKysrKysr
Ky0tLS0tDQo+IDEgZmlsZSBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygt
KQ0KPg0KPmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vdV9zZXJpYWwu
YyBiL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91X3NlcmlhbC5jDQo+aW5kZXggYjM5NDEw
NWU1NWQ2Li42NmQ5MTg1MjNiM2UgMTAwNjQ0DQo+LS0tIGEvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1
bmN0aW9uL3Vfc2VyaWFsLmMNCj4rKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vdV9z
ZXJpYWwuYw0KPkBAIC00NTIsMjAgKzQ1Miw0MSBAQCBzdGF0aWMgdm9pZCBnc19yeF9wdXNoKHN0
cnVjdCB3b3JrX3N0cnVjdCAqd29yaykNCj4gDQo+IHN0YXRpYyB2b2lkIGdzX3JlYWRfY29tcGxl
dGUoc3RydWN0IHVzYl9lcCAqZXAsIHN0cnVjdCB1c2JfcmVxdWVzdCAqcmVxKSAgew0KPi0Jc3Ry
dWN0IGdzX3BvcnQJKnBvcnQgPSBlcC0+ZHJpdmVyX2RhdGE7DQo+KwlzdHJ1Y3QgZ3NfcG9ydAkq
cG9ydDsNCj4rCXVuc2lnbmVkIGxvbmcgIGZsYWdzOw0KPisNCj4rCXNwaW5fbG9ja19pcnFzYXZl
KCZzZXJpYWxfcG9ydF9sb2NrLCBmbGFncyk7DQo+Kwlwb3J0ID0gZXAtPmRyaXZlcl9kYXRhOw0K
PisNCj4rCWlmICghcG9ydCkgew0KPisJCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJnNlcmlhbF9w
b3J0X2xvY2ssIGZsYWdzKTsNCj4rCQlyZXR1cm47DQo+Kwl9DQo+IA0KPi0JLyogUXVldWUgYWxs
IHJlY2VpdmVkIGRhdGEgdW50aWwgdGhlIHR0eSBsYXllciBpcyByZWFkeSBmb3IgaXQuICovDQo+
IAlzcGluX2xvY2soJnBvcnQtPnBvcnRfbG9jayk7DQo+KwlzcGluX3VubG9jaygmc2VyaWFsX3Bv
cnRfbG9jayk7DQo+Kw0KPisJLyogUXVldWUgYWxsIHJlY2VpdmVkIGRhdGEgdW50aWwgdGhlIHR0
eSBsYXllciBpcyByZWFkeSBmb3IgaXQuICovDQo+IAlsaXN0X2FkZF90YWlsKCZyZXEtPmxpc3Qs
ICZwb3J0LT5yZWFkX3F1ZXVlKTsNCj4gCXNjaGVkdWxlX2RlbGF5ZWRfd29yaygmcG9ydC0+cHVz
aCwgMCk7DQo+LQlzcGluX3VubG9jaygmcG9ydC0+cG9ydF9sb2NrKTsNCj4rCXNwaW5fdW5sb2Nr
X2lycXJlc3RvcmUoJnBvcnQtPnBvcnRfbG9jaywgZmxhZ3MpOw0KPiB9DQo+IA0KPiBzdGF0aWMg
dm9pZCBnc193cml0ZV9jb21wbGV0ZShzdHJ1Y3QgdXNiX2VwICplcCwgc3RydWN0IHVzYl9yZXF1
ZXN0ICpyZXEpICB7DQo+LQlzdHJ1Y3QgZ3NfcG9ydAkqcG9ydCA9IGVwLT5kcml2ZXJfZGF0YTsN
Cj4rCXN0cnVjdCBnc19wb3J0CSpwb3J0Ow0KPisJdW5zaWduZWQgbG9uZyAgZmxhZ3M7DQo+Kw0K
PisJc3Bpbl9sb2NrX2lycXNhdmUoJnNlcmlhbF9wb3J0X2xvY2ssIGZsYWdzKTsNCj4rCXBvcnQg
PSBlcC0+ZHJpdmVyX2RhdGE7DQo+Kw0KPisJaWYgKCFwb3J0KSB7DQo+KwkJc3Bpbl91bmxvY2tf
aXJxcmVzdG9yZSgmc2VyaWFsX3BvcnRfbG9jaywgZmxhZ3MpOw0KPisJCXJldHVybjsNCj4rCX0N
Cj4gDQo+IAlzcGluX2xvY2soJnBvcnQtPnBvcnRfbG9jayk7DQo+KwlzcGluX3VubG9jaygmc2Vy
aWFsX3BvcnRfbG9jayk7DQo+IAlsaXN0X2FkZCgmcmVxLT5saXN0LCAmcG9ydC0+d3JpdGVfcG9v
bCk7DQo+IAlwb3J0LT53cml0ZV9zdGFydGVkLS07DQo+IA0KPkBAIC00ODYsNyArNTA3LDcgQEAg
c3RhdGljIHZvaWQgZ3Nfd3JpdGVfY29tcGxldGUoc3RydWN0IHVzYl9lcCAqZXAsIHN0cnVjdCB1
c2JfcmVxdWVzdCAqcmVxKQ0KPiAJCWJyZWFrOw0KPiAJfQ0KPiANCj4tCXNwaW5fdW5sb2NrKCZw
b3J0LT5wb3J0X2xvY2spOw0KPisJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmcG9ydC0+cG9ydF9s
b2NrLCBmbGFncyk7DQo+IH0NCj4gDQo+IHN0YXRpYyB2b2lkIGdzX2ZyZWVfcmVxdWVzdHMoc3Ry
dWN0IHVzYl9lcCAqZXAsIHN0cnVjdCBsaXN0X2hlYWQgKmhlYWQsDQo+LS0NCj4yLjM5LjANCg==

