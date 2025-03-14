Return-Path: <linux-kernel+bounces-561676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5540EA614CD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F92E1B61A42
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F023220127C;
	Fri, 14 Mar 2025 15:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="iM3X7BBe";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="iM3X7BBe"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013056.outbound.protection.outlook.com [40.107.162.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06F81C878E
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 15:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.56
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741965916; cv=fail; b=oZo7XUarj2bOihpIcmo2zeVIoBv3+pqn2XHvK3aBvXH1C+qhkYkcxOU3ztCW0XyC7JPVTzN0t9Fd9XHkd5rIp35CD9OfOwtVS5nbNCS3Kj8jmKcxcX0kbFMeUB8Lsdt1lhC5W0JvdzqB5NHo7mmt26CjDTuyck+/hWSIkl3DwmE=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741965916; c=relaxed/simple;
	bh=gEM0obT+Gjard+R6x8Tf+ZH6Q4RzYAE1aCDkmR9RGc8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HCNuVio2Lgie5UHaUj3TQ6SfWZI7QFxnDltvzT+sa1a5LTM6vIrrsxDzrICkjVaitHZJYJ48M4SIgJLh8HwcJqQ5Owgv048Phec+4DYla2GtsWXjF3oFd1PpoJt4ASKpunG040LH9QdE8fwwG5j+SMwAPmrTe5SYOYfzvfboD0o=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=iM3X7BBe; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=iM3X7BBe; arc=fail smtp.client-ip=40.107.162.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=DGEDkeRlKstCySLGmuJqUwub6w6ECasTnNZ3Iw0cJ2HkKEZM+/62vEr2/kph+TWQMz7coEs2WSBEciQYs55/dKlk27raH9hB/YcYov7KVFrQaZuGYXUvOTJtIw1H/mGgvkvkezF2SaE85eQ1N02khzaEZlC4GrguiGRbXywvICD+BDcD1YI4OpnB6geHzEzbB048OzFK0i5obxuKVNXuSh5rIa/rcI49PKb/s3HGYhIGVShp5l+EnbU69awLqzchI9B23rREV6adjf92gF4+A9YiC3ItTkH90MzTD60CtSx25LXsgMmq9WmkFkee8QvEMwYqS80mHuOvP1piEeL6pg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8gzwYSV5gwBYKcQc0nOtyeb1nit6TTBgM9pxHIg1cg=;
 b=iC8ENu7hzrxrZJ6NRwwDm63NYyJwGgkg2PIEB7fA8p6m25shrOdv8CuEDZUPIESkRnuS6aHHwuSvXYQB6ZU9aa52N/KR9pPminT8natMtIxaO0kLjj3ysCihf+TZLX2xB1yeNyFk4k+kKbb2SpvNop6OXFfxmMfSxJ6S9yvH/9/akr/E+ezQn4ZfvpfIW2AvYAIpVYmPnyTsOB46WQFE00igJPu8hZOZ0VoBqbhaCiIyfRSVMkXzMYpAddMcA3glhoq4up6s9gZffGP0yB2feoCe1soeOXgh40ODIiKUu2BCV0nQE4kmvS1ZHwh6jX6R/fvtjasmNNZCA3nN1LCiaQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8gzwYSV5gwBYKcQc0nOtyeb1nit6TTBgM9pxHIg1cg=;
 b=iM3X7BBe7ZEY9aatLxRTVGSkpOiXUP0hipIxrLMlkkO0z0vUTVZk9kC3FH57nJ1ET+PbHhxZQWWfVpBhWRAKVX0h/WfgtB2sMOKgIvpg1SZMXdsu0xXwjB9F7dlTgOopgSiS+NsTKDQ20ASmyAu32ilLXrT7kDYNjQkp4veWZoo=
Received: from DUZPR01CA0311.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::12) by PA4PR08MB5950.eurprd08.prod.outlook.com
 (2603:10a6:102:e0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.27; Fri, 14 Mar
 2025 15:25:08 +0000
Received: from DB5PEPF00014B9D.eurprd02.prod.outlook.com
 (2603:10a6:10:4ba:cafe::e9) by DUZPR01CA0311.outlook.office365.com
 (2603:10a6:10:4ba::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.24 via Frontend Transport; Fri,
 14 Mar 2025 15:25:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5PEPF00014B9D.mail.protection.outlook.com (10.167.8.164) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20
 via Frontend Transport; Fri, 14 Mar 2025 15:25:08 +0000
Received: ("Tessian outbound 273c03480eca:v594"); Fri, 14 Mar 2025 15:25:07 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: adf5239edfc2d516
X-TessianGatewayMetadata: 7LndFAy9U/lAqxoKR/fdRDGUvsMWaUKRPjkgSuLAKPwW2Nr3rlP1uMbCCMcQhPsW3qbWKdN72zM3wnE+VI8oZ9jn4njU9ogxWFR1LJksNEAM3ItLJIcozej7JGJ0zf0AIQzaA7PrdtIcoqqfJgYxAedVVj3RjFKYPuGzx8utCFaCWmfe3Odu/aZJtMb4LRIPdgqXZI/kkxsNacfqqaSfaw==
X-CR-MTA-TID: 64aa7808
Received: from Lb27a933a4a76.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 4630B1D0-DAB8-445E-9ED4-37954B78E63A.1;
	Fri, 14 Mar 2025 15:25:01 +0000
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Lb27a933a4a76.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Fri, 14 Mar 2025 15:25:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VKyp83fPacuX09LwYs14bAqGkfl6PvjoPaPPjffL5PfPmiHd3avL2dTYFVCxB0q3aux+nZ3U6zQwIJhVLSV5+rjoRsENC+vnA1dIYZvtJ+JnsYz/TqM0+iy1+6wqof+FYpPWaZMPX00dlc+HV5izf/WBFvnioX0eJoWQw7SX9KmpNBk8AmPUWN7IyJyGuKbxxlfsdySQ1FV/CutR9yZ+Vnx0R/mhZ+4jwK9v8wUx+aphHuZs+iCAJsba77UcBR/TFGLK6bTbzgJeHmuHL+6WP89AYlJBKmegLN/dWb4QUzw4mCx3k6jUQr0/ALGbVE275kGTE85DKHff5Pe3aO4T1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8gzwYSV5gwBYKcQc0nOtyeb1nit6TTBgM9pxHIg1cg=;
 b=UHhTs63dstblqSztqVjepG0iaQr4A08tKjooHTCzDncvEF6zMgBuR/ssUjzxnLUZgiN3/btDzr/O6IuYW74MAibQSJ+kQ0VT8j67MtWp1LsvpQ/YNR+5Gor/sAFquUIBiVglLf4oPjKnpdpkBNC0YYaHCvXQ4q/gZ37ebX0SOSKIEI2EHTan4crnbehXZqFYcz9gyQzs5g6XBS9uQZU9y+tk7YMVwgV5GUe5MU+lZbEGVks3tl3TmGgB7hz+9Ch03hyUUg+BFjvbZVMhJYTzxXr/9x/5diz7j57OeFfG/+mXpwOd+qY/WgLfMUo8dPPp+mOtdIP8cQibAJiIvDvkjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8gzwYSV5gwBYKcQc0nOtyeb1nit6TTBgM9pxHIg1cg=;
 b=iM3X7BBe7ZEY9aatLxRTVGSkpOiXUP0hipIxrLMlkkO0z0vUTVZk9kC3FH57nJ1ET+PbHhxZQWWfVpBhWRAKVX0h/WfgtB2sMOKgIvpg1SZMXdsu0xXwjB9F7dlTgOopgSiS+NsTKDQ20ASmyAu32ilLXrT7kDYNjQkp4veWZoo=
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by FRZPR08MB11138.eurprd08.prod.outlook.com
 (2603:10a6:d10:136::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.25; Fri, 14 Mar
 2025 15:24:58 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%6]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 15:24:58 +0000
From: Yeo Reum Yun <YeoReum.Yun@arm.com>
To: Mike Leach <mike.leach@linaro.org>
CC: Suzuki Poulose <Suzuki.Poulose@arm.com>, "james.clark@linaro.org"
	<james.clark@linaro.org>, "alexander.shishkin@linux.intel.com"
	<alexander.shishkin@linux.intel.com>, "coresight@lists.linaro.org"
	<coresight@lists.linaro.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] coresight: prevent deactivate active config while
 enabling the config
Thread-Topic: [PATCH v3 1/1] coresight: prevent deactivate active config while
 enabling the config
Thread-Index: AQHbYrq6r5SrhbLvl0KKCTupVv1Yu7NzG0MAgAAEncU=
Date: Fri, 14 Mar 2025 15:24:58 +0000
Message-ID:
 <GV1PR08MB10521BB7C93822F5124F2D66EFBD22@GV1PR08MB10521.eurprd08.prod.outlook.com>
References: <20250109171956.3535294-1-yeoreum.yun@arm.com>
 <CAJ9a7ViuVntYL62q=WYPkFR3++cyufPdKUHm0FUAPyGy76pB_A@mail.gmail.com>
In-Reply-To:
 <CAJ9a7ViuVntYL62q=WYPkFR3++cyufPdKUHm0FUAPyGy76pB_A@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	GV1PR08MB10521:EE_|FRZPR08MB11138:EE_|DB5PEPF00014B9D:EE_|PA4PR08MB5950:EE_
X-MS-Office365-Filtering-Correlation-Id: 67d935b7-87d6-4e8f-eede-08dd630c6759
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?iso-8859-1?Q?flJFkHYQ34BS5lkt3+X3jhAwZnhX/LX35I5ZkuTbMNZF9DMOEk5lfCs6Zp?=
 =?iso-8859-1?Q?KYmSoXUFWwXwBoCV7J+c+RLtR3JUh6GBaxObVTpORnQdXW8j/E4Edfzy1y?=
 =?iso-8859-1?Q?5hrMTzppd7M0iotQxrpyNNeabIFoCVAL2YnXk39OvGxSyKTCK9bH3P3CEU?=
 =?iso-8859-1?Q?4WiwVrhPwFIf5CfmJ0SLHxWJKk6CX2T5xPV6hlFcN+7ACW7B/iLAkm4mxI?=
 =?iso-8859-1?Q?1cYYSexxT5TrQ6wS9IU94Dkeq+HpxL2LUk65uK9DNdnzJTUFw2cXe51YD3?=
 =?iso-8859-1?Q?3C+3DfE70Nw/qMCsSGcK9Rik0iYIAatDfdolaHwtpy2+MlpsIa+UaCBSIR?=
 =?iso-8859-1?Q?iGCGXA53RJz09bEOf0VTfOAEIOqXwJ20nnbHQsdBi7f0GF52ldJFGA+MGI?=
 =?iso-8859-1?Q?7NhAPOvBzxJ6xjhrdPrBceV3WAsOdVYkfj1FjZgZ37EK/ScPAhgf87wzbb?=
 =?iso-8859-1?Q?CKbFfPgJ6BICk8+XMztlCRrbhzJnsQ2pn9sqEPUJiRoh3mw+TNkSydDw+1?=
 =?iso-8859-1?Q?+eaDNcoFzaTuw0KMQERkJMdFByQG94HKK+W1i00H6WjGiSsYoWNihRx7DC?=
 =?iso-8859-1?Q?RwsJ1yDXVFT2viIrsfkgUjPTQvKKuoGYxBjdlzbXgw/x+d3unN4pRFsub6?=
 =?iso-8859-1?Q?LGRTMHOHYGtpem5dP1/lTuAwY2ihRoicSn6BUa3rbNwKDS/+YmmTj7fXH3?=
 =?iso-8859-1?Q?t00GeechnUGFcMxqCw7Se49A/EcQEKpG9LytSyNiM7EYi9swt24EmDEtOi?=
 =?iso-8859-1?Q?WQqNEPqvLf2CV7oRt9GNgxtos2TgWKD/Fz7vybPK6vWe+cmYCdga3pyP/y?=
 =?iso-8859-1?Q?4Bp98SxYV22atAuisfYxUjvVEcc3npubXdvMWKKOHiRVVBkzHC7ember16?=
 =?iso-8859-1?Q?nniREzEygad7Xu2jV5/Fqc+YdV4bqB7jNB92KjNqDNA+PAlwTLQbX5+xLC?=
 =?iso-8859-1?Q?JbQZocjbp8GApHOq2g8dCnHkE3IbdUZ3gN0Cnm2rGL0quhXuQyi8KC++Id?=
 =?iso-8859-1?Q?oanpYK3SQTauANxgBWvhs6OW1Uk0T9W6BvyWIKMCJjQHwcytekYdKxQhAn?=
 =?iso-8859-1?Q?lod7gXWT4qyJiege7ZmjzyLDNWo8MmNdRjp/khJCANm0i+y95Wsm3N1ZcN?=
 =?iso-8859-1?Q?k62NhrBSVE5aGoCbKMt7u6Q1burEbvoj2+l1Y1MoLjNPsFQWJjARnlKviK?=
 =?iso-8859-1?Q?5IdyHnBn0ehdi0GAJqJ6Atdg5XwdSx2gNRIGT05BpRxEqzl+F5LgVsfH96?=
 =?iso-8859-1?Q?2sCs07jJczs1ayNnPRx5rPgHwnBCorLoBQLJUGIHrhaJzZLQGEyjjwgv5H?=
 =?iso-8859-1?Q?dpD6ZUyQ/mi7N+kVvNtD1d4VmwJQydfLOsQmHC1WHCfSeZkC5gHAhSNLcq?=
 =?iso-8859-1?Q?V5K88OB8/fn0NiP8I+J5JO/0h2okQEIV3GJmy2BSp9imiLC3iwDl8LjgKR?=
 =?iso-8859-1?Q?MDT15YsPlgKb40xQhpxfjT+2FPmAiiOMj2H3mNNBRYjuNDojvDFosYXPgc?=
 =?iso-8859-1?Q?nKIXxgXxSaOFN1vEhMh6sc?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR08MB11138
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:163::20];domain=GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B9D.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	bebe76a4-9928-4baf-9d81-08dd630c61c3
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|14060799003|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?GFQw7z+30LTtypgIwjtLPOHX0m/TkzLjoDsHMiltfn097T39cgYNBMBsWf?=
 =?iso-8859-1?Q?SZ4sjSIdNl9Q/ncs0oI9TaftmSpVBTu9VTqPNcOcKSzfoKzEhDJ5vzXARm?=
 =?iso-8859-1?Q?AiTaS8P2cnkV/nzybLK91UJnUHJSnGsQNsvg1boog6QNnCUWDuj4Wb9oM8?=
 =?iso-8859-1?Q?lEXPa84Grwu82gW81woJ/w6tqbcrsrkmaANwoEM0aODtKqKw2hckZhXGS3?=
 =?iso-8859-1?Q?oOfW7sGV4sh+bLLNkhNUrjk1t25nwE0r3wo+GQm5aFViY08C7Lf8CJ8nN/?=
 =?iso-8859-1?Q?85iJT9cI86Le5/n4IcvRT5qHcJ6CRoV7E4y6yTLM3U3kcvFYoQ2xcmsq8H?=
 =?iso-8859-1?Q?6pOnVdGsF9UnQev4bRQtWePpDFPeRDr/muJnWc0JNsGdVTQQcUIZM3d4Vs?=
 =?iso-8859-1?Q?AnkWt+nkua8Klm37BM3acAoG4XGvkX8C0hT2spf2c9oRg0J+SgsQNyuNup?=
 =?iso-8859-1?Q?8gbrVpnLzBAz4M/wjX92Ya1tng477SFfDZjDQB7Or9SJyi61wwP8wf2c6U?=
 =?iso-8859-1?Q?5ZRONaINFRYrigr6ObaAjQFJfQiS9CkXChsd6k5A6evvIXkwQxxPqHrqD6?=
 =?iso-8859-1?Q?j+/cRwerzeivXK/oD3u6Afm6pfuyyHUlqpZwoVdfr1XH5i16gmaqyBIzeH?=
 =?iso-8859-1?Q?piaruzvsAsLy15F6IqGA8YGkydqw0gdlvzEhLp9JehEze9s0tssVp2czuW?=
 =?iso-8859-1?Q?HrAQ3IsqbsbZPBbWPvBMX78y70XJeWkAPkq0MNKTIZoigLTuJsl7mFSFOM?=
 =?iso-8859-1?Q?hyUnbX03sSPQ8QE9098OKLSuC3nzhUaTdKXJMuShcQg5pyyGWUIVe4b+/E?=
 =?iso-8859-1?Q?MiszduDnzKM7PCwKpcN9CmHvDXcRGi8jc1qniDOS0rAP678yAMs+JT7I0/?=
 =?iso-8859-1?Q?O9KhozurBiVnDfvXzLQjzcF297B53a/dII/Au66h1KMAfdnN48a9nP4P7n?=
 =?iso-8859-1?Q?/W9f5hZrOjwI8PRlf5/QaVZwcc6kTQgopQXx76uzdyjPdZG9bQM3D8PMGO?=
 =?iso-8859-1?Q?3ZEziGse03NWIfbgMpFAke2GhIILiB63wv2EwxhiTlyTzffPSOknaeHHXu?=
 =?iso-8859-1?Q?HBJ3AVX9wabcH6LWawTRMTNPmKS0A3B1QkrNrwYLVaGv3T9fSzcTBJAVAe?=
 =?iso-8859-1?Q?3IIUgpZCPU8FwPecXmFX8TqJVu8oTKdBucY3mzyIOsaKqCalMK6OWyrbxB?=
 =?iso-8859-1?Q?AJa90m7ibfEC33yzoG7Q4HWQZPKZ1oDlTtH9LDKIC8LtSjJqU0EslFO1tx?=
 =?iso-8859-1?Q?NYBcLsGU3R+U4CznMCyzP+kyxd6n1PDnQGT3TGZpJ8TXvbGBq/+CkwzDHx?=
 =?iso-8859-1?Q?GWv1PkEEl2KomvTkG0CIryWnsbCUX6fBNfA4WpH7NUlCntlU04fM5KXB+O?=
 =?iso-8859-1?Q?q3GWnGJ+F8QdK/2nmsxOvPqc3pf3C7kMEIcmXeoUupqtCTZzm9FnTegc7b?=
 =?iso-8859-1?Q?X+Mmxg0JlxIjVS4gOh9/2T+RQ+zPd+sHAJSqh0aH7uy2zjm4BPMbICm7Op?=
 =?iso-8859-1?Q?LejFfdOSAwh6xQoTW+J+xyA1qWf9HOsRMymggB9kIFKkGY+jbGorhT2PoF?=
 =?iso-8859-1?Q?oja6YgI=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(35042699022)(14060799003)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 15:25:08.1182
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d935b7-87d6-4e8f-eede-08dd630c6759
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB5950

Hi, Mike.=0A=
=0A=
> >  static void cscfg_remove_owned_csdev_features(struct coresight_device =
*csdev, void *load_owner)=0A=
> > @@ -867,6 +870,28 @@ void cscfg_csdev_reset_feats(struct coresight_devi=
ce *csdev)=0A=
> >  }=0A=
> >  EXPORT_SYMBOL_GPL(cscfg_csdev_reset_feats);=0A=
> >=0A=
> > +static bool cscfg_config_desc_get(struct cscfg_config_desc *config_des=
c, bool enable)=0A=
> > +{=0A=
> > +       if (enable)=0A=
> > +               return atomic_inc_not_zero(&config_desc->active_cnt);=
=0A=
> > +=0A=
>=0A=
> Not sure why we have an "enable" parameter here - it completely=0A=
> changes the meaning of the function - with no comment at the start.=0A=
=0A=
Sorry. But what I intended is to distinguish=0A=
    - activation of config=0A=
    - enable of activated config.=0A=
Because, current coresight doesn't grab the module reference on enable of a=
ctivate config,=0A=
But It grabs that reference only in activation.=0A=
That's why I used to "enable" parameter to distinguish this=0A=
while I integrate with module_owner count.=0A=
=0A=
> >         list_for_each_entry(config_desc, &cscfg_mgr->config_desc_list, =
item) {=0A=
> >                 if ((unsigned long)config_desc->event_ea->var =3D=3D cf=
g_hash) {=0A=
> > -                       atomic_dec(&config_desc->active_cnt);=0A=
> >                         atomic_dec(&cscfg_mgr->sys_active_cnt);=0A=
> > -                       cscfg_owner_put(config_desc->load_owner);=0A=
> > +                       cscfg_config_desc_put(config_desc);=0A=
> >                         dev_dbg(cscfg_device(), "Deactivate config %s.\=
n", config_desc->name);=0A=
> >                         break;=0A=
> >                 }=0A=
> > @@ -1047,7 +1066,7 @@ int cscfg_csdev_enable_active_config(struct cores=
ight_device *csdev,=0A=
> >                                      unsigned long cfg_hash, int preset=
)=0A=
> >  {=0A=
> >         struct cscfg_config_csdev *config_csdev_active =3D NULL, *confi=
g_csdev_item;=0A=
> > -       const struct cscfg_config_desc *config_desc;=0A=
> > +       struct cscfg_config_desc *config_desc;=0A=
> >         unsigned long flags;=0A=
> >         int err =3D 0;=0A=
> >=0A=
> > @@ -1062,8 +1081,8 @@ int cscfg_csdev_enable_active_config(struct cores=
ight_device *csdev,=0A=
> >         raw_spin_lock_irqsave(&csdev->cscfg_csdev_lock, flags);=0A=
> >         list_for_each_entry(config_csdev_item, &csdev->config_csdev_lis=
t, node) {=0A=
> >                 config_desc =3D config_csdev_item->config_desc;=0A=
> > -               if ((atomic_read(&config_desc->active_cnt)) &&=0A=
> > -                   ((unsigned long)config_desc->event_ea->var =3D=3D c=
fg_hash)) {=0A=
> > +               if (((unsigned long)config_desc->event_ea->var =3D=3D c=
fg_hash) &&=0A=
> > +                               cscfg_config_desc_get(config_desc, true=
)) {=0A=
> >=0A=
> This obfuscates the logic of the comparisons without good reason. With=0A=
> the true parameter, the function does no "get" operation but just=0A=
> replicates the logic being replaced - checking the active_cnt is=0A=
> non-zero.=0A=
>=0A=
> Restore this to the original logic to make it readable again=0A=
=0A=
It's not a replicates of comparsion logic, but if true,=0A=
It get the reference of active_cnt but not get module reference.=0A=
The fundemental fault in the UAF becase of just "atomic_read()"=0A=
so, it should hold reference in here.=0A=
=0A=
So, If you think the cscfg_config_desc_get()'s parameter makes obfuscation,=
=0A=
I think there're two way to modfiy.=0A=
=0A=
    1. cscfg_config_desc_get()/put() always grab/drop the module count. =0A=
    2. remove cscfg_config_desc_get()/put() but just use atomic_XXX(&active=
_cnt) only=0A=
        with cscfg_owner_get()/put()=0A=
 =0A=
Any thougt?=0A=
=0A=
Thanks!=0A=
=0A=
 =0A=

