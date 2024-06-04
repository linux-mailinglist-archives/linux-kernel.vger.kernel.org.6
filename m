Return-Path: <linux-kernel+bounces-200249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9728FAD88
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 10:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D635AB20C57
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 08:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41BF1428F0;
	Tue,  4 Jun 2024 08:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="q8nL56G/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="ZfWeXazf"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2100.outbound.protection.outlook.com [40.107.241.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502281411FA;
	Tue,  4 Jun 2024 08:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.100
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717489572; cv=fail; b=dDwZs8KeqBdnkXrZSPnfncqZUyRGs7lWazrMe6rqG3oFufKDj/78O2qoL5y2rhsKr785yhpcXGElMpCPmlvVS/Pfg6NX7MvnEax+u8KdCY2lnQRZTGU0mpU03Gwf17U5IxMDWUuiVN9RNN6d06uFSNb/nieAAQ5gpQO+3UUOwhQ=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717489572; c=relaxed/simple;
	bh=qo1pDnC9jW2zAxk08JrLGnY9ZO7IoDjtLDTS63dxWyE=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A93tk9tYn7YYY8JGInhfhKVLkvOI/MjRZ0gPKJlRE9uvW8ACeb+D0UnjImMIE2NSTMpZi5vG1N+EMr2xgIilIKi6NqsIY1ESGeJLeJ37sp9bcBwq8qqPfxcGj4kCqniPXKiXJ+TVdzO1sdcZ1dKeZb3Hb2HImZZbsLuCOR58q1U=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=q8nL56G/; dkim=fail (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=ZfWeXazf reason="signature verification failed"; arc=fail smtp.client-ip=40.107.241.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=fail;
 b=P4ffoBWL2iYKPp8oPIqZ8gesoXjN/sqWyeYyQmJIzC8kF7pp9W3IwPcuIWEyzZWpfAq8fu0I0y3Qgyt7xKLKZm8abrBLegtgbr+7QguKtH9eq0bxHyyitwf0fcuCua93z6BLODth4yzXv6rjYEfbMpf6oW/MzJsXLGrT/k0mvlKahe+GAYCkGg+N+pYmCSVcv1m9Caw4MZmVXCN90YFjhhxGzUwj+vDyD8+IcPgJfWwhczqjp9BQOn3tAkJCwfa5qhQ6BNH0Lrhpc6ezfdX2G1z7asdupGy3kHLbKu2cpyG64YfkFfiIuehsTuf9dAjWRO/vA8Q/kcXAGjes5dGixA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qo1pDnC9jW2zAxk08JrLGnY9ZO7IoDjtLDTS63dxWyE=;
 b=l/a4a4ycYNItDYDtQafbeW83oCtpvArfb8ihDcj2qtiw59Y4gW/aMMzSrmf/iz7Xb10nSraWkexpXGR0VXmnNOv9zCRFXQhP9v2FhSZISfgQUgAhrnu28vbQpTaWLnad53qR1Rvkt+m7ERRPJqKBYbSwAhKHREcgSOgNd9zJ8v85x3bpbgBugsdVHeMtCkK7mC+m4QJMHuOjCzpWl3IwE/s6Bd7ajnNVYgmsnU96AsEcb8ZBPvBPEHJu/lxnrko5YbQ2YNZz2HGD8FVKqr+BbBS+UYs+dJXkilAhARhrA1vVQzYyOAQybODytR6fXZYa7Hv2ezIjT464AXaQoZThmA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=quicinc.com smtp.mailfrom=topic.nl; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=topic.nl; dkim=fail
 (signature did not verify) header.d=topic.nl; arc=fail (47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qo1pDnC9jW2zAxk08JrLGnY9ZO7IoDjtLDTS63dxWyE=;
 b=q8nL56G/WCkYeSw6MSY6Eaqq94k/f6Am0vlwc01XMQBqrcuCXZXx5sDtF+/HDf/1gcGrsTFcYu9ALtFNkYm8pfDKgvwprfkvZfQMR22A9pb4D+xoZoDjaEOh3q12bCbj2lmHXkGFQ1pc9KQY+scDkHUPcXq9Y0P0bdf1glh/EKo800zswo3em390H3D+NzLs+w231k2bOjrwktki4s5cupQhv1Um6roP1lDfwETln0zjopG1QFGpB2rvujLxMiQDXOJBUC2azkc3bGVw55xWeOJpVduMJKtARpq8C2lIhuY7LDqFBdk1IWEZsO774ZS3SLi29EfcC0psTue1bFr6gQ==
Received: from DB7PR03CA0095.eurprd03.prod.outlook.com (2603:10a6:10:72::36)
 by VI2PR04MB10091.eurprd04.prod.outlook.com (2603:10a6:800:22f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Tue, 4 Jun
 2024 08:26:01 +0000
Received: from DB1PEPF0003922F.eurprd03.prod.outlook.com
 (2603:10a6:10:72:cafe::82) by DB7PR03CA0095.outlook.office365.com
 (2603:10a6:10:72::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31 via Frontend
 Transport; Tue, 4 Jun 2024 08:26:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=fail (signature did not verify)
 header.d=topic.nl;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 DB1PEPF0003922F.mail.protection.outlook.com (10.167.8.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Tue, 4 Jun 2024 08:26:00 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (104.47.18.111) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 04 Jun 2024 08:25:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZhwf8h/TFBKmBdUZtoe3QDi83h7QT7XBo+zMVc7E58GRvuaczgis5aJytcw9iM0VFTxEH1k9UXeec/Nhf6vQC3wP8DKuGWtsgI4o5p/HkIRKhYv0QIEjT0EXcrIjLkYTAJpwXTV22gFUsIGeuusP4zScDCyq/5IWDKGexy2rEGeyDGpPDhs33lFC+CVUcwxhChD7GHKo8QJDD5rfqeHzgUjOAeZ7CMuamHudUB5+RnnNe8HPl57FCk7Dh0I5154YNL6PhWQ6XuUrxnh/nF/Sx381JjUIqWwr8J6bQhNuORkEl6L4BNUxsUBu5qXuzRlt9Yvw+Hj4zLATYaSlpZPDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+qjcOlpHYMyDHbq9MkFc1mcJ5T1TehB8c0WNSIC8oA=;
 b=Jqkn4Y8PNhdKTo4oX6PzMWWiCSY8LQw3yawp2rAnAYfFeeNoHhix5Tx/Y7mimKHi7ulK6Sn2UP7Ub9Z9qAuJWC8xtUs5Bnz9JszBbyYjvHV9U2hHSmJjik86cbQcOtrhyqGTABpwt9jtiDnTjOS3OlNVq8xYijMT0kpzICUgVB6EkYnWyTcJ/egioON2d57fzjY9TD/RveiKyv69zAWLq0MXRDY5zfOOme3vhfiD/4Mnf3K/PcTU2JdOZc++Xq3XFVHtFrPlqwqNjSzLwUcMxZVCm3U8en2IrfcVZLrZCG6+cI0m6xjEOFfBms3kjAFGV0sD0XUn4cosg1SfhZu07A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topic.nl; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+qjcOlpHYMyDHbq9MkFc1mcJ5T1TehB8c0WNSIC8oA=;
 b=ZfWeXazfrrmXktG4uWrlVjjecS7pIFbqt+iOlOHPs6T/ttT9ihUFSXY74cQZonmUopME6iVtD7KNFxYL3bcF0igut+m6pgJI+kztI2WRE6d1g+ycw4yjzndEWBNw9TzEpeYeKvcKauxxosrw2wNnDZ/nsIDZC+D5cPbP3ljX3rxFnUiq8+pKZPScQ/jayrRJ4rnxaCVRAl+rwLxjLsCLzMxVmtQ+j9ZtW7fbEszA2uyCjRxgUwpVWA41G0GbqspKTJBHQmN9B4cRJ7QY/XvAFSWZg7yK3iSfMpWipROJYT1vBJ08jwySmWwRGYKbDH+3SGIDuhGn2Rk2YvBvOReG9w==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by PAXPR04MB8126.eurprd04.prod.outlook.com (2603:10a6:102:1bc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Tue, 4 Jun
 2024 08:25:56 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%5]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 08:25:56 +0000
Message-ID: <9473c090-a21b-4d11-a98d-6083547d9648@topic.nl>
Date: Tue, 4 Jun 2024 10:25:55 +0200
User-Agent: Mozilla Thunderbird
From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH] usb: dwc3: gadget: Inform system of suspended state
To: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.c5f44c79-75b2-43c1-a791-806fe8b693cd@emailsignatures365.codetwo.com>
 <20240603131304.233403-1-mike.looijmans@topic.nl>
 <20240604010256.4dxamwvcjxug6xfb@synopsys.com>
 <0fceefc4-2b3c-41a4-a6ac-d0b6dbacc1f7@topic.nl>
 <91b3af13-e723-4a49-b7f6-06f927c286c9@quicinc.com>
Content-Language: en-US, nl
Organization: Topic
In-Reply-To: <91b3af13-e723-4a49-b7f6-06f927c286c9@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR02CA0222.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::29) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|PAXPR04MB8126:EE_|DB1PEPF0003922F:EE_|VI2PR04MB10091:EE_
X-MS-Office365-Filtering-Correlation-Id: 46e5ba20-532f-4332-7a6e-08dc846ff766
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230031|1800799015|52116005|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?ZTRtVTVNUWQrMklhS3lKbmdDbVpKZHRCOGVsR084b1BwYnJiTnRVVGpGQ2VL?=
 =?utf-8?B?MVNCRllBNzJ6OVpaOFBRdmxpdDhxSlc3bmxubXdXUExVQkVkQXNKVnZwNUFS?=
 =?utf-8?B?VFFsVFl5MDIzMVpWbVZ6MkkycjVkc0tlYk1vTmFYd1d3WHZGT1BoK0M5RVl6?=
 =?utf-8?B?WjY3TGR3NldRZHBXY01DS0t3ME1mM1J3WTV1OFFHMm5OOWs5U1k3UUZEeEFR?=
 =?utf-8?B?YWtnbUEwbkNTQUlKaFMvMUk5WEZnK21RYjROMXRlUzJ6dDdmM2YvVHpPY25T?=
 =?utf-8?B?NUdzcjFTK1gwUmtGeVlRK1VxZ1hvNWpTa01idzBIeFZJamEvdjNRWk1CcW84?=
 =?utf-8?B?U3RoejhjeDdib1V0TDNOdmxDTGs2ZkVlcTFKQXRSRUVKTTRjK2JiMXZESTh6?=
 =?utf-8?B?TVZ3bDZJRGZRelRPUktzRHpNMGh0dUxtWmdOWnpMQ2Z2aDk3dUt3cm9nckR5?=
 =?utf-8?B?WHdBUUJvTGtEbS94QkVzYVg5eTFhcE1YdWhFVTJhYy9hMHNxdTJQaFhVU2VD?=
 =?utf-8?B?TkpYbmkwQUFOUUhkUElUcWozU0dyam9FRGtMK1JYMWFmWGxCbGdVL201M2U1?=
 =?utf-8?B?Q0JkTXd5cnhJaXdLRmNHTldOZmNoZXh3T0JNSG1PTTNlUEkwNUkxQlV6blA5?=
 =?utf-8?B?R2ZPZ093dlFOR3BhSWpJU25MQzlBMzcxVm9pa2tlcWRWY2hMVWRSNi8vTi9B?=
 =?utf-8?B?MnNVdG5XK3lrQThybjJwZFZveHc1RlVQZnc1Qkx0TFpmNk8wQWNoRnc0N0tK?=
 =?utf-8?B?VloyVmoxdllvSm9aSHAyeW5zVE1VT1JYbCswa2VKZldBaTh1cmZ1WHNOSjcy?=
 =?utf-8?B?VkJKUFFiU0M5UDU0SWdDamFHcU5JZWRORG4wRTExSS9oZ2x2SzNxbnpmcHZy?=
 =?utf-8?B?dXlTVUtRdWZMZ012dW9IMWVDWEN6QllhSUhxeUZQSkppQXJZQkpGM3RvaVNn?=
 =?utf-8?B?MVRtMjJ0QWExZjkxNnlYM0tiU1ZjMFlrMkEwMEEzamsyb0dCOEo4YktnMnV1?=
 =?utf-8?B?Tzlac2FNTEE2ZzRnRFBtNGpDNUpzSGxtNTVETGxrdTJCdzFrdUtMdmZ6alp3?=
 =?utf-8?B?cXZGbXFVQWFBenVmZUwzSFdwN2thUHJIOGx4ZE96THlwbSt2andNVVlJRlRz?=
 =?utf-8?B?N0t4NldKOS9KMjRpNnU5S3ppREd0dWRybW8veWhYWFg5ODlKcGZSUUovTlR6?=
 =?utf-8?B?enNDZkhaOGgyRnNGNXFkbEV0dHpTU05JRkRZdzIwN01Xdzkzcy9YaFJMRVJR?=
 =?utf-8?B?ZSs1Y1JQRDR3YmlUcmgxeGU0T0pFVHl6bUh5OC9ZS25xelQ3L2RkcGlDRVNl?=
 =?utf-8?B?dU44WWVoWFh2K2VzS2swelc3V014b0tKMEtCYitTNmxhTERnQmU3ZTJpdVFR?=
 =?utf-8?B?ZW1kZ3d0ZEk2S0F3NFRRYngyR3d3Q2xxNDJIMlZaZjBRbVIyYnh0U0djMHB4?=
 =?utf-8?B?eUYydk1UQmN2VFN2WldKb0NpcEc3bWpybUZMbHlieXBoaysxWnRVQllwclp2?=
 =?utf-8?B?TUlFV0tNSlpmM0RQOXNGeDd2RktsWXJYU1BHRnc1V3JZNHdhaVNhMXExTXE4?=
 =?utf-8?B?TGgwMUljZnR4bmo1aUxvUUdYM2dvZlAweEF1YmhyaU1iUDNrbk1YME5xMlZ2?=
 =?utf-8?B?MGF6Q3pPN1dzMXVPUVdLdTVtSHNpbjlGNmRYaUNKWTFVWmZ6RTRjcjFxUEZ5?=
 =?utf-8?B?ZzFCYUtmSzFFcTI4eFpZYWFqb2ZKdmNDbFhFVmxzeWQ5N0w3Z3ZLREp3PT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8126
X-CodeTwo-MessageID: 99e79d06-7b25-4a4c-88bd-bdb28a2246e8.20240604082559@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF0003922F.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	dff845eb-2919-403e-f1d6-08dc846ff491
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|36860700004|82310400017|35042699013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZWNQU2l4NHo0aU1FRVZHZDNzbEJFUmNBazVNTHYxZUFueEIxWGpoamx3bWdD?=
 =?utf-8?B?YW9ERUdVSGZHSXRNQXJDOHBaTnV2NGdpeS8zTTRHSjFEb0UyWHZsRDNnNmlh?=
 =?utf-8?B?YXJDMDBIQWNHM2xjQWJ5ZlFReXZaT0drWmFURU9LTlNjT2d0YzN2K0RHV084?=
 =?utf-8?B?QTYzMU9aa2tCd3MweW8xd3B2ZlVNRy94MWg1WnJEMVhRZkpYQ3g5YVVEbXBI?=
 =?utf-8?B?cUo5dUcwSTlHMWlMNVUveE95YUd0MTZXZ1hFaHVRUkpvckIyUjI1UmU5am1U?=
 =?utf-8?B?VG1zVFNkdTdCbVRzTEtoeUp6WXllVzkzUzE2c0dvTEIzVFdjMU9vMTY4ZXo5?=
 =?utf-8?B?T3JGamFnN2hpUkp5bHg4Q2IwdVJwbW45UGdmT01DYmlVVjU3TTNFUzN0NlNl?=
 =?utf-8?B?M2p3dm0rYlhhVEhKTGRJc3JPTHlsUTMxVmcvQW5rRmljTjdTdS9IUHBETm9q?=
 =?utf-8?B?cnNjamNQOE1Td2Vycjc1OXE2M3JNWjhCT2p6Z3hWTjlhdmxEV0VKWk5hTVJE?=
 =?utf-8?B?RGR0QlBtMlFJTlA4eWRPdVhhY2pQdUgxSE5lZXFRYzRHS2dmUjRrbVhrbWM5?=
 =?utf-8?B?ZGV5aDFyOHRuM05hNDdidWd4TWl4SzNRUmlqUjBXV0FZU1JublE0VFdjdTdQ?=
 =?utf-8?B?R1V1V0I0MVlHWXlRL3krVmI5ME9DQitscDNFUUFtd1ZvNTltcDRzSkt2UEpB?=
 =?utf-8?B?WHhwYUt0OFFhdlFNMCtrVTVnSlVqTW1XTXBGVE1OQ00xSTF1RjlRVWNiM0Yv?=
 =?utf-8?B?WG1jUitYUlhsbmJaWXE5ZWp3cVZudkJrNGFld2pMZ1RPbjVjYU5KRno2RzQy?=
 =?utf-8?B?eWpRTG5EOUVKQ0RNYmtjL3UxV2lUb0t1SHJvUFI3Uk1kOTVVd3JjLytFbUZG?=
 =?utf-8?B?akU0aVVEMFlRRjI0SnU0eGxtU25OMmxycVJqeTFLYngwR2hWbTFQN3E1bVZv?=
 =?utf-8?B?YWx2UFAwTmd0Nk15dk5tWm1KS2tYUmtRVG05c1ZrZnoxOW1QMDIrSE41a2xx?=
 =?utf-8?B?NzMyM2dObHF2OE5VM0tDNXRUL1dOSHZ6eGttS0d6bHExd2RvMk1NL1R2Z2ht?=
 =?utf-8?B?Z2t5MzJYV1pvSVdOZjV0Z1ZvUFVEb1I1NzdDUmluMlIzWjlzZmxKRit6YW13?=
 =?utf-8?B?K1krS09zWWZWc0JtYmluYkI2NFBHNmM2dks1M1BRZ3hCZTEvRTIzcmR2ajBj?=
 =?utf-8?B?UVk3aWYzSHRvMU1nYjlGaHBHNWpNZnZJYlduaGI0ZE5RazYwUGVUM0xhV0hm?=
 =?utf-8?B?WjEvMUV0UEtnRnpWTkdzbVdFbDhvNlNuMnpiT2Q1RGRwTzhvbXFIRkxQRXV4?=
 =?utf-8?B?NThHUmdVa0dXbk1jd1VjVEQ3alYyazNMOHh0aDEvRTNQT0gwSjgvSE1wKzlw?=
 =?utf-8?B?M3daWmp3WUhqV0pBbUFxSEdrUldGZWppVkd3MEZlUGF0bjNWQklIRVMrMk50?=
 =?utf-8?B?Nlp6STZYVlBuMEhkanl5dnFVdEdwTmVlOFY0UnMydWZpYXZKT2o1aFpxK3Jn?=
 =?utf-8?B?dlN3aVVya1ZhNTNSZGZyMEVsK2xLRWthYjNUaUluOTBOY0QvZG91NmJxeVF0?=
 =?utf-8?B?Uk93UXA1VnJ0M0ljNWk3OFhLMU81UkZ3YU1SeVkrTXBUZHl5VURxUERDb05W?=
 =?utf-8?B?ZExTLzh2eUZkRTlzZFdpcEpiekYrditNVkE5Zk9kMnRNTG1mSWdwSm1KQ0NR?=
 =?utf-8?B?Y2ZsSzF3MElDQ29SZmFGSS9qeHFTQ1NtUmV3RHpnZ0NreHVBeDNoZ3lFZUZN?=
 =?utf-8?Q?ULo7d7T6aM0emdmzxmfHpdSB1hvlauon1Yyb9gc?=
X-Forefront-Antispam-Report:
	CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004)(82310400017)(35042699013);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 08:26:00.5598
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46e5ba20-532f-4332-7a6e-08dc846ff766
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF0003922F.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10091

On 04-06-2024 08:45, Krishna Kurapati PSSNV wrote:
>
>
> On 6/4/2024 10:56 AM, Mike Looijmans wrote:
>> On 04-06-2024 03:03, Thinh Nguyen wrote:
>>> Hi,
>>>
>>> On Mon, Jun 03, 2024, Mike Looijmans wrote:
>>>> When disconnecting the USB cable on an LS1028 device, nothing happens
>>>> in userspace, which keeps thinking everything is still up and running.
>>>> Turns out that the DWC3 controller only sends=20
>>>> DWC3_DEVICE_EVENT_SUSPEND
>>>> in that case, and not a DWC3_DEVICE_EVENT_DISCONNECT as one would
>>>> expect. As a result, sysfs attribute "state" remains "configured"
>>>> until something resets it.
>>>>
>>>> Forward the "suspended" state to sysfs, so that the "state" at least
>>>> changes into "suspended" when one removes the cable, and hence also
>>>> matches the gadget's state when really suspended.
>>> On disconnection, did you see disconnect interrupt? If so, it should
>>> transition to USB_STATE_NOATTACHED. This change doesn't seem to=20
>>> directly
>>> address your issue. Can you provide the driver tracepoints?
>>
>> The device doesn't issue a disconnect event, I didn't have tracing=20
>> enabled in the kernel but added some dev_info() calls to determine=20
>> what was going on. Added this to dwc3_process_event_entry():
>>
>> dev_info(dwc->dev, "event: 0x%x type=3D0x%x", event->raw,=20
>> event->type.type);
>>
>> When disconnecting the cable from the host, I see this:
>>
>> [=C2=A0=C2=A0 50.841411] dwc3 3110000.usb: event: 0x6084 type=3D0x42
>> [=C2=A0=C2=A0 50.841457] dwc3 3110000.usb: event: 0x4086 type=3D0x43
>> [=C2=A0=C2=A0 50.841494] dwc3 3110000.usb: event: 0x6084 type=3D0x42
>> [=C2=A0=C2=A0 50.841534] dwc3 3110000.usb: event: 0x4086 type=3D0x43
>> [=C2=A0=C2=A0 50.841571] dwc3 3110000.usb: event: 0x4086 type=3D0x43
>> [=C2=A0=C2=A0 52.650990] dwc3 3110000.usb: event: 0x30601 type=3D0x0
>>
>> The "0x4086" and "0x6084" messages are endpoint events that occur all=20
>> the time while connected. The last event is the "suspend" one. After=20
>> that, total silence.
>>
>> If you need traces, please point me to a description on how to obtain=20
>> them.
>>
>>
>
> Hi Mike,
>
> =C2=A0I may be wrong, but can you help understand the mechanism as to how=
=20
> disconnect interrupt is generated in your targets. For example, on QC=20
> SoC's, this happens when HS_PHY_CTRL reg VBUS_VALID bit is cleared and=20
> cable is disconnected. This is because the vbus line is not routed to=20
> controller. But from my calls with Synopsys previously, I remember=20
> that the vbus line is routed to the controller as well for other OEMs.=20
> In your SoC, what is the indication to controller that vbus is absent ?
>
The board I'm testing this on is an LS1028ARDB. Looking at the=20
schematic, VBUS is routed to the chip. There's also an LED attached to=20
it, which turns off when I unplug the cable.

In the devicetree, I can't see any hint of NXP-specific "glue" in the=20
DWC3 entries, so it uses the controller "as is":

 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatib=
le =3D "fsl,ls1028a-dwc3", "snps,dwc3";
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D =
<0x0 0x3100000 0x0 0x10000>;
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 snps,dis=
_rxdet_inp3_quirk;
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 snps,qui=
rk-frame-length-adjustment =3D <0x20>;
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 snps,inc=
r-burst-type-adjustment =3D <1>, <4>,=20
<8>, <16>;

The "fsl,ls1028a-dwc3" keyword doesn't actually occur anywhere in the=20
kernel, so it uses plain "snps,dwc3".


> Also, after this happens, do you see the next plug in working ?

Next plugin works, because of a "reset" event at that point that makes=20
everything happy again.

The state remains in "configured" while the cable is out. Plugging the=20
cable back in makes it revert to "default" first, then it goes back into=20
"configured".

--=20
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl
W: www.topic.nl




