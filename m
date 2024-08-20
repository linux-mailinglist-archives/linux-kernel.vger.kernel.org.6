Return-Path: <linux-kernel+bounces-293811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED0F958532
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 12:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7881B2594E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 10:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E008118DF84;
	Tue, 20 Aug 2024 10:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Ven4ZR+4"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2062.outbound.protection.outlook.com [40.107.215.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB3618C34F;
	Tue, 20 Aug 2024 10:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724151175; cv=fail; b=mselqqGOaVLOvlf091eGDXUOv6PyKVcVcX6BlTpXe5uq3eCMXWkgL+K7V98SFGdD3fJ+3gCwZ2vAR3hpLBmCJy//+58g7Ye+1zoxYQdhjEWfyuGQqhKcr3H0x15bhvGy/Qxd4omfb7P/7yoxHq8MnLWYbt3XJKyzvI1DAbsWZ60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724151175; c=relaxed/simple;
	bh=CkLMFai7Xzk00/2dDFEIgLkHgVMAsJLHvGMvvL/HJQk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uE4A7kO+whplE0lJVrUEysIpqSGcJGsiGDP3UD8qQ+XxvLX9gxs40WswZ7p6siAbVD73hGkfc0NPItzkgr4pS8XPH1vyzGpLatplqhF56K2yWIMJn/Cxddd7B7wq76ZOb01W8da5IJ8poN2CDd90XAts0DH/M4N6Ts2qOy15zAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Ven4ZR+4; arc=fail smtp.client-ip=40.107.215.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WZZBl1a5Lkv7r1krFuiJEJXRgxpXoEKgi5crDRgJIkdtf6Pl9Ut8gax2ncrp11/nlDDqqN0qC3BDvAVBhSjootL1mXno0kHVv84m2F/RBk76qPtthKYJw3SyMvmMkcyxoFoLwBOPLWRycChh3/wvm9Rsy74IjcYSUREVTxayGpaR8Wo608fXU4gwyRBnXmuTO7D4btgHoOKqyzCaF3qZ/xQJLzXwa4cVp2X2NqgGYMTx+q69OMtHIexfRM3iHbkssrEdzv4X6igch/FJAO+37Wb3p7z5y77xbAd4hfukkP0zUsQ3TgjODRwuMsiX6IyB2u24rUJ0qB2mFKK5AApzFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CkLMFai7Xzk00/2dDFEIgLkHgVMAsJLHvGMvvL/HJQk=;
 b=bw9/Fof3Ubk6dKNpUqOSe9XHy6SMKrut+kK/5Gii2wu1lNwEfbWbv+VhMhIdp6PPp/jTCYLXAYfmHKB1Cj96hCrQSRHO3yKoD7Xu1ZbbsyqMeRDm8j7d8+k6aMLsg40kflb2TO9un3erw2tAXYjtVhlzKnhjyC30qUdYFGZ7mbZKJ637Leytx4hpGrA+9VfDirz7I9b4r9trRPc0VMj/9z588ERLUr6IOXAfyoyoKfKdQ9gyxiLIbtfcBNWKOwqBAAse8qUaRdQyzfCY29G2keqn6u92DGee/6OSBPxts5zgiYrKCaFOQdAIMbq2lOyQujIBS0anocqYycAKYEphmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CkLMFai7Xzk00/2dDFEIgLkHgVMAsJLHvGMvvL/HJQk=;
 b=Ven4ZR+4Xs6bEnoCHb1dHnhL1qnyc6nLxwb2t4kOaNbztH0Yhzv/IOOV9zOrgjOcLtddDIIHKYVIh2nWM6ArkafhYu8pT73zNcGRBUkryht0GR4KiLre1IhQk8nHNA4vd5Ju98AJ+/wcc5nl6//0E9CU4RQkb7b1EKszatWQff5tg2GARDT0gjuH8ckgcHXkLBYGAyCCC8KNueQfXqv9nkeoHVwqoJByw5Bx4cJXFCEef7l3wJBUPIgiUphO1NKeZazBcWtldYAzufucYwqumPAkodj7VyLwasskwD+FnBtSnmaiJxPRRpSxGwmSmc88NLzBP0ZRCmcqanoSPMThNg==
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com (2603:1096:400:358::7)
 by JH0PR06MB6653.apcprd06.prod.outlook.com (2603:1096:990:31::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Tue, 20 Aug
 2024 10:52:47 +0000
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe]) by TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe%4]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 10:52:47 +0000
From: =?utf-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>
To: Prashanth K <quic_prashk@quicinc.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>
CC: "quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	opensource.kernel <opensource.kernel@vivo.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, Michael Nazzareno Trimarchi
	<michael@amarulasolutions.com>
Subject:
 =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjJdIHVzYjogZ2FkZ2V0OiB1X3NlcmlhbDogY2hl?=
 =?utf-8?Q?ck_Null_pointer_in_EP_callback?=
Thread-Topic: [PATCH v2] usb: gadget: u_serial: check Null pointer in EP
 callback
Thread-Index: Adry4ybSh1NbXw2tRg+lDnWYwqiqIwABr+6AAAEq/MA=
Date: Tue, 20 Aug 2024 10:52:47 +0000
Message-ID:
 <TYUPR06MB621757ABDEF795FB39B912FED28D2@TYUPR06MB6217.apcprd06.prod.outlook.com>
References:
 <PUZPR06MB62242AA2715789D100FA2E60D28D2@PUZPR06MB6224.apcprd06.prod.outlook.com>
 <1a81f498-f7dd-86e6-74fa-fdeefad6a7b4@quicinc.com>
In-Reply-To: <1a81f498-f7dd-86e6-74fa-fdeefad6a7b4@quicinc.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR06MB6217:EE_|JH0PR06MB6653:EE_
x-ms-office365-filtering-correlation-id: 492c2ef7-8df0-4a54-2984-08dcc1063a8a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?R3VHOEMwbi85eXQreVRQd081ZDhiNjNGbXdvYjhZay9UM0FqTkpydk42VWgv?=
 =?utf-8?B?ZElMZDVIb29nMUpSOU9PWTgxRDdaeGtRSE9nY2RHTjBwOVFGUkdtSUwrK1lK?=
 =?utf-8?B?RG9yeEMzOU1sN0hzaDZpMFQ1MmlObDBmeVVlK1c2TmJUODc5L2Jac2lXNVdM?=
 =?utf-8?B?KzFLcjdiK0Z0ZG4xd2orcFdTcUVsK05zczFocEs1aXVLRTE1bDZ3bFUvWmxE?=
 =?utf-8?B?d2doRnpYYlptdUJmSEo4cGpuZTVMcnlHMHFnNEFtUldUUUV6K3FrNGl6TUVY?=
 =?utf-8?B?cnc2RnhvSTVhVDk2Qzdac1ZFd3FFUFpVMHJFZ05wdFUvWXJOSXpUTXM2VDR3?=
 =?utf-8?B?VWlYVWI1ekk1S05ld2lxSFVFVDVEYjl4L1VCYWVHeS9CQUpZeHhEYVFKV29N?=
 =?utf-8?B?NlhnZ3QyMFZlRmJQdGR2OU5OMkU3Vm9oUUd3NEdUc3hEaW5YRmZFeW1jQ3dC?=
 =?utf-8?B?Tkg0OVlydzAxTThZQXo2UVBieTlSWkJrbmJzbVlTV0dRaGFHVGxXZzJ4SHpk?=
 =?utf-8?B?NXdSKzEzWGpUNmd6cHNRVm1HZTVFeEdsQXk3NHpZUXFEWEJYVllOTVdGRmU1?=
 =?utf-8?B?RkthTGZzUFBZTmZGcHZFTWJQeW80YnVkamxidFlHSGViYnlLYkRaQWRpckVZ?=
 =?utf-8?B?UXpGQ2N4ZlA5SmZFZUJhT1hRMEJJWFRuKys0TDZKZzlNRG13NDVrWUlpSWpz?=
 =?utf-8?B?T25aelJkR09PMkNnL3FvZkQ2NmFweWpDdGNlUU91RXVjSndDN00yd0xDSXlI?=
 =?utf-8?B?aWxDRk91ajFsYkk2bGI0aUVRUGJWVEZkVkhNZkwzSmJGZm5LN3RZRndMSTFC?=
 =?utf-8?B?QjdhSmdGc0VHbE9lMHVQOXdqTDVCME5nMkVwL29idndCNEhZYlk0MW5GYmRw?=
 =?utf-8?B?R3lPc2JicEJ6QVZjU1l0cC9PeE1qbW14ZnJPVnRoalFicm9rZGZzWFRwZnJr?=
 =?utf-8?B?WC80cWFjQWovMzh0aTFyS0YwQlZQNWd5K05HcGlOZjMrcmhqalpSYzFUaVZ6?=
 =?utf-8?B?MXVrVWc2V2N4eEc0cmkxQmxkVHp2bm4xS1NXbmRmbWE1L2luWFUyT1I4enRJ?=
 =?utf-8?B?WUFNM3MyVWFpZWxFRG5iOXBzNEZvSW9vbTdhTVVhMzdmQlJ4NGV1N2taOThO?=
 =?utf-8?B?MjlyRUUvdjJjUVRoSGF5enpNVWJwZ3Bsd1FKTG52Tzc2RC9ua2NDZFpVdUVZ?=
 =?utf-8?B?c210VzdVaGRiTngrMDN6TEt0ajYyWVhGeGp4ajJyTldWWmNESklXSkRKN3Zt?=
 =?utf-8?B?VndhellQVlF1WWRpTkUwZFBUTGVtbEhaaFlnUGRSZGEycHB0cUxrbm1CVUxV?=
 =?utf-8?B?eW9VS1VuZjZXUWhaVkJNem5YYTlZdHdLVU1HK1dlWTlUYTJvY2Jtd25aZUcv?=
 =?utf-8?B?VTM3S0ZQcVdlZGZLTHpteTlIQUhxSGtTNHd0VDh0SGhhT0p3LzhRWUwxbW1p?=
 =?utf-8?B?dG1JdHF2Z2lSTEFUU3hRYUpWOTU0cVVVcHE2LzhhWm5TbnNzVTVrZnhPMkVI?=
 =?utf-8?B?ei8wdHJaY04xak5EOVE2Rnp2bTV1ZTlrR3FTcXRqaWxaQXRpYi94Y29qdWtt?=
 =?utf-8?B?bWsvanZiNHk5ZkJaNk4rWE95TDdOMFNnYmlRSXUxY1YzSWNTMUlTWVpYRm9N?=
 =?utf-8?B?NmZMWFI4KzNtZ21IOWlXaElEa2psNjVmUSttZDVHcjFjUm5aLzYvOFpvcE9T?=
 =?utf-8?B?QlNUTHJacWNnL1lkZjVIYUEzbkI1VVJGRkRONmNtMWxyN3F1MXdDamROVjhq?=
 =?utf-8?B?U2dFVzZhc2dWMXVPUXBOaWpRZXQ3eFFLa1NkVHkycnVjRU1VdWxSdkJBc2F4?=
 =?utf-8?B?ZUltMVVmV21jZzVCdkszQStVbFp5Y2VabFQxSGtnU09WdzJIeHVKYUJrblda?=
 =?utf-8?B?WXFySUs4MEdPY0R0SUNXWS9OWVJKZ0N3MlJEeHdiL00zU1E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR06MB6217.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RVJYWGRlR1dXSHJjNUtzM01SUEEyb3c4blFtbEo2blNmNGd2dUZZRmtjUFBV?=
 =?utf-8?B?Tmh2VGlQeGJ6aGxhajRoUWFuUk4xMThpZzVLSTNxS2tJVFBjbXYvYVMwdWs3?=
 =?utf-8?B?NkRZU2g5WjB2K2tnQWZBZnVsT0gwSTZad0FHNWlZNXFXVGVjK0l5bi9iN0hX?=
 =?utf-8?B?K0lFODc0ZUVyR0xoT2F1VHlPbzg2UWl1dFU2M2x4L1FrZ2dhSldkMSs1WW5p?=
 =?utf-8?B?aTNONGh3bHRNZi9HTWdqZzV2U2RHY0kvUEdyWm5NY1hqcFJQVWx6dFNkQnRL?=
 =?utf-8?B?bmdoaUJVbm1QSEhCQnoyYmJrcHYzQjBiTHNORTlkT0g5ei83VDdadU1CbXdF?=
 =?utf-8?B?Ukd1Z29Pd2NaMUtVOEYrbXNKK3NYdU11SGVCUnRYZXBiMUhSMSs4VGJ6R3RV?=
 =?utf-8?B?aENCRE85RVlyYU14dDZOWExKK3FvN0wyOFNsd24xcWhHcXgvcFNIQ3RZYVl5?=
 =?utf-8?B?eVdtV3dNeVAxM0hHcjBPZ1E1U3RycXp4em1kcFRzT3B2Y3BMMHRVUFhXdkxp?=
 =?utf-8?B?aXZEMERjQVVNa2NDc3dqR3M4WEZpejh5aXFxNDJpNVUxeUZ4L0J2OFBmbnV4?=
 =?utf-8?B?aEtqQUpKUzB5R20xQy9jS1E4S1JkOTlpdzRoZVZnMFdDLzZZZlBHOEFadmF3?=
 =?utf-8?B?WjlURmF0NHlnUTNZVGcxL1hadU9UYS9nY2w2bWd3MDhJS1MrQkNyaEZ2TnM3?=
 =?utf-8?B?WWhBUkpwdjBJSmFZYUpJVkZjd3owbmQrcEN3R2xFZGo1MzFnR1pSUGVkV2ky?=
 =?utf-8?B?QkkyYmswUDh3eFR0TEwxamZRanlBSTZqL3VvQXJUS2FWSkVDMVlXT3d6VXZR?=
 =?utf-8?B?RUlCMy84YVBWUnhmaVZSb0Y1OFdoYUgrNjNXa0cyZEVDYkd2QkE0SG13Rjdh?=
 =?utf-8?B?bWRzdTVKMFpScGo2WjBuWmJFVlZKT2JRck1iYlNvUzFGZDZGUXdZVnpFWkNS?=
 =?utf-8?B?UFVxRVVEVlhaTEdYbFJodUdrMTJld09NVjl1dHVqVmRqN29RQ2FiN2htVTQ0?=
 =?utf-8?B?Nk1BOEhZRiszK20veFVJeCtLMjM2WndPeUk4Z3YzYnQ5cXhVdm9IYzJTRFFM?=
 =?utf-8?B?UXg1ak9sS0tNaGhYY3lJYk11OC8vY2RzRDlBVUk2TUhUM0tzM3JyRW0zNTVn?=
 =?utf-8?B?cDNRNWhTMUU5enpQVklycjZVcnFzUFZvWXVOakoyMlQyNWtGc3ZnMDB6MU9l?=
 =?utf-8?B?MkVQNE1NK3g2VGtwVG5QTlVyVDhYVm8zalhKOEhVbWlMZ2NLY2JjSDB1QTAr?=
 =?utf-8?B?aUp6OVgwWEhnS0JMQUhXaDZ1MkIvS2liQmgydW50OG8zUm5rTlEvWFNuc0Qw?=
 =?utf-8?B?UU1aemJ2Mk9EU25qdHVlUXRqa1JGaFpFRkxoWkRWVGlGOU45SlBEMWRiQ21G?=
 =?utf-8?B?L2dmNkFCcDhydTFKYnR1ZHBPS2dhUmxnZkVPazlqVWVTWjFIdTlLVTZldFZB?=
 =?utf-8?B?Q2lVQkhIRjY4VDhYcnF5Z0dxc0hibWNnaDJnU2VUR2hiZ0J5TXJLdEFUZUI2?=
 =?utf-8?B?OUhIVHM5NUFTSUVXYXlwM3RIdTIweEtDTmlXNHhNUVIvMVloZHJIS08rd3JN?=
 =?utf-8?B?bWFwK1RzZDliZXk1STV3UjI5N3V4ckNEY0h6M2ZSSXJ6ait5bEIrUzIyOXNQ?=
 =?utf-8?B?OFRKckVhUWxzclZTcldpcHJOMXhFcUdtNzJtVFNBWHBzUjRUMSsvOGhPRThE?=
 =?utf-8?B?d0pOaVVIZTF6UVh3SnlCbVQ1bTZMWXptZGNZS1o2TTdpRTVWcGQ1RzFucjlu?=
 =?utf-8?B?VkRta1dtVGoxUnpsTHEwNU5zeGM0cVdhQVkwN2owMk5xYnpzcGw0OEc3TzdQ?=
 =?utf-8?B?b3BvNFI4aURiVWJTVEVPVS9oYUlKQWxuejBBMnFUTnovMzhFZVREWHlsTXor?=
 =?utf-8?B?b1pzQlJWZmJXaWp1aGFDNDFjVmRzaFBUYlhKYTZQaFhFdi85Y1NUWjRsT0tJ?=
 =?utf-8?B?RkdGRER3TVpjVGV3QlB2Y09VWXM5MFBKS3VlVUYrTTY5NWQxd21TVXduWE5p?=
 =?utf-8?B?TnFaRlk1VkE5RXM0YVNCU1p3c1NGd0J5U1pBYW1ackF4aVFhU2daRENNYXdN?=
 =?utf-8?B?SUVPa3dlRjA1OEErdE0zUVIwSlp6c3IvRkdjZDNlR28yVm10aWNXK3JpVFBl?=
 =?utf-8?Q?vqgw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 492c2ef7-8df0-4a54-2984-08dcc1063a8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 10:52:47.5785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kusamup2o2Csot56BrNg/6lt9qjgcIzy2+ai4izNyzmefGJX6fnxblL8s35trSDMQbo4Bb1glcMDbdbYI4BdcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6653

SGVsbG8gbGludXggY29tbXVuaXR5IGV4cGVydDoNCg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dXNiL2dhZGdldC9mdW5jdGlvbi91X3NlcmlhbC5jIA0KPj4gYi9kcml2ZXJzL3VzYi9nYWRnZXQv
ZnVuY3Rpb24vdV9zZXJpYWwuYw0KPj4gaW5kZXggYjM5NDEwNWU1NWQ2Li42NTYzN2Q1M2JmMDIN
Cj4+IC0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91X3NlcmlhbC5jDQo+PiArKysg
Yi9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vdV9zZXJpYWwuYw0KPj4gQEAgLTQ1NCw2ICs0
NTQsMTQgQEAgc3RhdGljIHZvaWQgZ3NfcmVhZF9jb21wbGV0ZShzdHJ1Y3QgdXNiX2VwICplcCwg
DQo+PiBzdHJ1Y3QgdXNiX3JlcXVlc3QgKnJlcSkgIHsNCj4+ICAJc3RydWN0IGdzX3BvcnQJKnBv
cnQgPSBlcC0+ZHJpdmVyX2RhdGE7DQo+PiAgDQo+PiArCS8qIFdoZW4gcG9ydCBpcyBOVUxMLCBy
ZXR1cm4gdG8gYXZvaWQgcGFuaWMuICovDQo+PiArCWlmICghcG9ydCkNCj4+ICsJCXJldHVybjsN
Cj4+ICsNCg0KPlRoaXMgZG9lc24ndCBwcm90ZWN0IHRoZSBwb3J0IGZyb20gZ29pbmcgdG8gTlVM
TCByaWdodCBhZnRlciB0aGUgYWJvdmUgdGhlIGNoZWNrLiBTaW5jZSB5b3UgbWVudGlvbmVkIGdz
ZXJfZGlzY29ubmVjdCBpcyBtYWtpbmcgcG9ydCB0byBOVUxMLCBhZGQgdGhlIHNlcmlhbF9wb3J0
X2xvY2sgdG8gcHJvdGVjdCBwb3J0IChqdXN0IGxpa2UgaXRzIGRvbmUgb24gZ3Nlcl9kaXNjb25u
ZWN0L3N1c3BlbmQvcmVzdW1lKS4gU29tZXRoaW5nIGxpa2UgdGhpcyB3b3VsZCBkby4NCiAgT0ss
IGl0IGlzIG1vcmUgcmVhc29uYWJsZSB0byBtb2RpZnkgaXQgYXMgZm9sbG93cywgSSB3aWxsIG1v
ZGlmeSBpdCBhZ2Fpbi4NCg0KPmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rp
b24vdV9zZXJpYWwuYw0KPmIvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL3Vfc2VyaWFsLmMN
Cj5pbmRleCBmOTc1ZGMwM2ExOTAuLmEzM2Y4Y2Q4NzFhYyAxMDA2NDQNCj4tLS0gYS9kcml2ZXJz
L3VzYi9nYWRnZXQvZnVuY3Rpb24vdV9zZXJpYWwuYw0KPisrKyBiL2RyaXZlcnMvdXNiL2dhZGdl
dC9mdW5jdGlvbi91X3NlcmlhbC5jDQo+QEAgLTQ1MSwxMCArNDUxLDIxIEBAIHN0YXRpYyB2b2lk
IGdzX3J4X3B1c2goc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQ0KDQo+c3RhdGljIHZvaWQgZ3Nf
cmVhZF9jb21wbGV0ZShzdHJ1Y3QgdXNiX2VwICplcCwgc3RydWN0IHVzYl9yZXF1ZXN0ICpyZXEp
IHsNCj4tICAgICAgIHN0cnVjdCBnc19wb3J0ICAqcG9ydCA9IGVwLT5kcml2ZXJfZGF0YTsNCj4r
ICAgICAgIHN0cnVjdCBnc19wb3J0ICAqcG9ydDsNCj4rICAgICAgIHVuc2lnbmVkIGxvbmcgICBm
bGFnczsNCj4rDQo+KyAgICAgICBzcGluX2xvY2tfaXJxc2F2ZSgmc2VyaWFsX3BvcnRfbG9jaywg
ZmxhZ3MpOw0KPisgICAgICAgcG9ydCA9IGVwLT5kcml2ZXJfZGF0YTsNCj4rDQo+KyAgICAgICBp
ZiAoIXBvcnQpIHsNCj4rICAgICAgICAgICAgICAgc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmc2Vy
aWFsX3BvcnRfbG9jaywgZmxhZ3MpOw0KPisgICAgICAgICAgICAgICByZXR1cm47DQo+KyAgICAg
ICB9DQoNCj4tICAgICAgIC8qIFF1ZXVlIGFsbCByZWNlaXZlZCBkYXRhIHVudGlsIHRoZSB0dHkg
bGF5ZXIgaXMgcmVhZHkgZm9yIGl0LiAqLw0KPiAgICAgICBzcGluX2xvY2soJnBvcnQtPnBvcnRf
bG9jayk7DQo+KyAgICAgICBzcGluX3VubG9jaygmc2VyaWFsX3BvcnRfbG9jayk7DQo+Kw0KPisg
ICAgICAgLyogUXVldWUgYWxsIHJlY2VpdmVkIGRhdGEgdW50aWwgdGhlIHR0eSBsYXllciBpcyBy
ZWFkeSBmb3IgaXQuIA0KPisgKi8NCj4gICAgICAgbGlzdF9hZGRfdGFpbCgmcmVxLT5saXN0LCAm
cG9ydC0+cmVhZF9xdWV1ZSk7DQo+ICAgICAgIHNjaGVkdWxlX2RlbGF5ZWRfd29yaygmcG9ydC0+
cHVzaCwgMCk7DQo+ICAgICAgIHNwaW5fdW5sb2NrKCZwb3J0LT5wb3J0X2xvY2spOw0KPg0KPj4g
IAkvKiBRdWV1ZSBhbGwgcmVjZWl2ZWQgZGF0YSB1bnRpbCB0aGUgdHR5IGxheWVyIGlzIHJlYWR5
IGZvciBpdC4gKi8NCj4+ICAJc3Bpbl9sb2NrKCZwb3J0LT5wb3J0X2xvY2spOw0KPj4gIAlsaXN0
X2FkZF90YWlsKCZyZXEtPmxpc3QsICZwb3J0LT5yZWFkX3F1ZXVlKTsgQEAgLTQ2NSw2ICs0NzMs
MTQgQEAgDQo+PiBzdGF0aWMgdm9pZCBnc193cml0ZV9jb21wbGV0ZShzdHJ1Y3QgdXNiX2VwICpl
cCwgc3RydWN0IHVzYl9yZXF1ZXN0IA0KPj4gKnJlcSkgIHsNCj4+ICAJc3RydWN0IGdzX3BvcnQJ
KnBvcnQgPSBlcC0+ZHJpdmVyX2RhdGE7DQo+PiAgDQo+PiArICAgLyogV2hlbiBwb3J0IGlzIE5V
TEwsIHJldHVybiB0byBhdm9pZCBwYW5pYy4gKi8NCj4+ICsJaWYgKCFwb3J0KQ0KPj4gKwkJcmV0
dXJuOw0KPj4gKw0KPj4gIAlzcGluX2xvY2soJnBvcnQtPnBvcnRfbG9jayk7DQo+PiAgCWxpc3Rf
YWRkKCZyZXEtPmxpc3QsICZwb3J0LT53cml0ZV9wb29sKTsNCj4+ICAJcG9ydC0+d3JpdGVfc3Rh
cnRlZC0tOw0KPlNhbWUgaGVyZSBhbHNvDQoNClRoYW5rcw0K

