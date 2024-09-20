Return-Path: <linux-kernel+bounces-334337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 735C097D5E6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 14:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0CCC281B88
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 12:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8578116DC33;
	Fri, 20 Sep 2024 12:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="crb0Ewag";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="crb0Ewag"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2083.outbound.protection.outlook.com [40.107.22.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0981316A94F
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 12:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.83
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726837070; cv=fail; b=rX/BrF4Xhr4923Yue2/FOt1sLcGMGvyeo72RB8D1i0hotpdtQBk1vZSROewrX51wpOUbSvbApHHKpy7/Jxkx4+kFHAUOmX1iaSV4JN6nIpHZuORQbiY6tnVqdGX6yETxqG1ZJGM5BiHJEFa3PTriY1+O/mXO5mjgwmaRqRXImRo=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726837070; c=relaxed/simple;
	bh=rUnM7jfISkeKw3RhdY6Xime4yqrSbTq+Hk6iEqX68Nw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rWsZEkV/hLgCicS7HoDRUFkJ7f3sBgpxPMZas5NPbQwR9127+PKJH58g+5LWz7VXodVf+Vv9K1SsXqjpVe7ICCgTg8CxeHEfnV1ZTmat4C1xkUlDjzWV6or6wqB1NQtBVehBsjBLxIgQnxhaRHPQqd/nkxWIGLRz24Cw+nwTkPE=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=crb0Ewag; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=crb0Ewag; arc=fail smtp.client-ip=40.107.22.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=eO3E7YWClXhO4SGU+lz4hdYCtrPBdCylb86iT4bdLOhXgVkvvg5Zd60RHDTq6/PoAR/onZz89L7dIscVG+DHuo5rr2VWn6K6KbcGEdvfd2mJ16iNhahB3hTRzHtJSAvQO8XB8skwhOYekZxnGpzvocrqolKeyJjOnDx3jSJxxwXM6lP2ZIFG9avoPv+mSxLo9XIBTg1skywnDu1zlsfWjL2J0pO39JlHhV9K2KgZiDuWfD5B3A7I82UuSyF5BfNLCvF95AHKMoX5Eo9fVq15ao3NU+aCpoXoivBZqVoslk+4wiWQLMs1CjyV7KuPDCP/VAZAGT+SXt79e+Gje17ALg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zYO0QqocPJIzjWrKEgPLjGdjlh9i7BqdLlSIVfcEBeE=;
 b=sAVq0vCc7JX5ZmhJ5u464RBfh7pITvmoS6rXWRfmB8IdouPd8jduTqfnROrMYihhZzLaH8p/rEM5GJJZF4swMIXLDyrjXtewy0uIcqNoXC5YhqMmv23rJhIlahTt05UYF11JUSNOT1HpREL+IrFSc8EtAaw0F/ogTRxHhvDhQgEhXg1WFoLYZXAHhgrNn9MiLxqEHhN9WAJRqojBvWF09H/YpSb5lVnAjpW8tHEPUsEH4670I0VTEo4SZll1W6+QmYatWZZbcTbwnOelVDHbVqeoB/8FZlBP49ZBIYwbTW4Lwzu04WOmDSVuR0ztMDQoj1GcnfS8LMQJ1vohdlmscQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYO0QqocPJIzjWrKEgPLjGdjlh9i7BqdLlSIVfcEBeE=;
 b=crb0EwagPHP0zqQVvlRMOZ/LZjdHTxp9Z4R/XM3CHuFNgl6AjkRkWAFjJxXDVYW+WCRGYoJ8UP+CiGBvlzPG8m/A1xkFCI7Nn9mWoxK9J2idRwuvV9bPu5Kaqn9yGvvd13zlO7TRaTezbjsI/IrYiEtQHqANa0qumPm7BXcOVBU=
Received: from DB8PR04CA0019.eurprd04.prod.outlook.com (2603:10a6:10:110::29)
 by DBBPR08MB5977.eurprd08.prod.outlook.com (2603:10a6:10:209::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.9; Fri, 20 Sep
 2024 12:57:40 +0000
Received: from DB1PEPF000509F1.eurprd03.prod.outlook.com
 (2603:10a6:10:110:cafe::a9) by DB8PR04CA0019.outlook.office365.com
 (2603:10a6:10:110::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Fri, 20 Sep 2024 12:57:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB1PEPF000509F1.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7918.13
 via Frontend Transport; Fri, 20 Sep 2024 12:57:38 +0000
Received: ("Tessian outbound 3e266b55d80f:v465"); Fri, 20 Sep 2024 12:57:38 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: aebbd4d71fed9037
X-TessianGatewayMetadata: +He0AW6+kpgm95nmalve7HhBzJE/RJsbzBTXPOnKxCInqK99mymKaPgL1RsWAehEfGMRt5KnCxF9J0lAyRFVbRZ9tBRusR2D4nXAFh6jvuDhi3LW4ftSx0esC4tF8Hm7Y8EQM0/mlY41SYKb6RP6Qlfky6k73XLoHg4q1CA+KuI=
X-CR-MTA-TID: 64aa7808
Received: from Le14fed95c0de.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id B4ECF1E7-B40B-43E1-A70C-69159B970675.1;
	Fri, 20 Sep 2024 12:57:31 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Le14fed95c0de.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 20 Sep 2024 12:57:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mup8pOo+Gkbhz5+9qyBrBEOgGG2LUGU6U9DUVIm80YGVw8/biezm7ExSVYQRVlesuhLJKjvv80RlvFNk+oM3KCMR3pMOS6vH72L6WKuFk+YYzP/WLtI/b7GXsKbPwcz7V0Ggs5kb/ZVGTBKiawEJPMyLgpvTmAjup+Jc4apjP//w4jbaV52kq+CqiqTnCu7yJI8TNmbvQ4xDhxIFJch7ZNQQ0ZEwOW6pDCRxJEmRNVnIdIiGoM0jwhI5tV8F1sgI/jJBFfAHkeHP3m4drpzYbjLRAOrumrjHhR2Tlwl/mZYxq7NtMhl4MyxKvWzDpBSfVn/6xJx9GqgZqi37OoeHNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zYO0QqocPJIzjWrKEgPLjGdjlh9i7BqdLlSIVfcEBeE=;
 b=DPUDba5fmzSQdR6Ij9plkcF95eoXBfmC82oACJS839Kh+KqkFfH/xvd+GEd7L9WNmzMhuNEMaami06nxO9j9vQI0/RzmA11U1vmdiSTpRBE9LKbYyetcrHkPxZL/Xc6CLjzbBkaCEVKUIiEQMfRHMhdui8/5Rpa+ABuvldgsT/33yu3KCVaLmF03gj2PEBdOqI/cqaLY73wmAfYEz1nkZZ6TJEzRrm+jlaCjg2mBSiOFdncKuKJloMkLlRT7SiH7c6VVLsAVhtiAajDFGoIjU5Nubvw2gpQhm84p08ndKfmHtxcBvM9hWoVSZfBEuCbPlbH5+WZ7JU4oiMrolXQWtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYO0QqocPJIzjWrKEgPLjGdjlh9i7BqdLlSIVfcEBeE=;
 b=crb0EwagPHP0zqQVvlRMOZ/LZjdHTxp9Z4R/XM3CHuFNgl6AjkRkWAFjJxXDVYW+WCRGYoJ8UP+CiGBvlzPG8m/A1xkFCI7Nn9mWoxK9J2idRwuvV9bPu5Kaqn9yGvvd13zlO7TRaTezbjsI/IrYiEtQHqANa0qumPm7BXcOVBU=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AS8PR08MB6263.eurprd08.prod.outlook.com (2603:10a6:20b:290::9)
 by PAWPR08MB10239.eurprd08.prod.outlook.com (2603:10a6:102:367::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Fri, 20 Sep
 2024 12:57:28 +0000
Received: from AS8PR08MB6263.eurprd08.prod.outlook.com
 ([fe80::12b5:3f0a:2090:fa7c]) by AS8PR08MB6263.eurprd08.prod.outlook.com
 ([fe80::12b5:3f0a:2090:fa7c%4]) with mapi id 15.20.8005.008; Fri, 20 Sep 2024
 12:57:28 +0000
Message-ID: <4cecd255-fb07-4ca8-8cfa-7d00b60b9fc9@arm.com>
Date: Fri, 20 Sep 2024 13:57:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 RESEND 1/5] drm: panthor: expose some fw information
 through the query ioctl
To: Daniel Almeida <daniel.almeida@collabora.com>, liviu.dudau@arm.com,
 steven.price@arm.com, carsten.haitzler@arm.com,
 boris.brezillon@collabora.com, robh@kernel.org, faith.ekstrand@collabora.com
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 nd <nd@arm.com>
References: <20240710225011.275153-1-daniel.almeida@collabora.com>
 <20240821143826.3720-1-daniel.almeida@collabora.com>
 <20240821143826.3720-2-daniel.almeida@collabora.com>
Content-Language: en-US
From: Mihail Atanassov <mihail.atanassov@arm.com>
In-Reply-To: <20240821143826.3720-2-daniel.almeida@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0120.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::36) To AS8PR08MB6263.eurprd08.prod.outlook.com
 (2603:10a6:20b:290::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR08MB6263:EE_|PAWPR08MB10239:EE_|DB1PEPF000509F1:EE_|DBBPR08MB5977:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ee542df-b7ee-45d2-b474-08dcd973ce12
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?b3JNdk5qaDJvbEpPb3VlT1kxdm40M1BoOUtIdEdQRTF2eW1rYlk1L3BkVnFO?=
 =?utf-8?B?dDh4cEpwT0JNSFd2THhJeWhtTmZzUXFhWGJ0K3Nwa0tRdGZtU3UwUjlFa0Jv?=
 =?utf-8?B?dWcrSWoyb1k1Ly9FTFcvckRyczI1dFgvUXQ1UkNxektSajlqdjNsOE8zVTRm?=
 =?utf-8?B?MmpVMG1wR2VyUFF5QVIrNGNZVmorT1pRQnBQRDNaQ1JhZGxEY0dMajM2QUJS?=
 =?utf-8?B?RkhHWU9ONXU0cEVQV25ldEdrcVRiN0tlT081NUp5aHJJTFF2OG5oRHo1aEhR?=
 =?utf-8?B?alI4OFNzZkpXVTFFcXJLeCtPeEIvTmt3bHpXRVdybGM4WG0yRXZVdVBldUFz?=
 =?utf-8?B?QUFZZmNzYkxSeEFlR2NLNUtIWG1zZzE4eTN5ZnM5MTg4c3RWNEdHRUExcUtX?=
 =?utf-8?B?L3FyMnpnQ1VpbWxRWVR1R2M4NGFKVll0cEJ1bHVhZnoxYXRKN1p1d3duMDFI?=
 =?utf-8?B?SjJmekVocVc3NDl2M2s4bW5JUE1OUHV0bk5XUFlqZzVXbUxMR3BOSGZIYUNO?=
 =?utf-8?B?cFYwdHFmSXdKT0NSNlp4OFNoMVMvYk5UMEg4bStWTkc5aGRUMGlacWRqRHp4?=
 =?utf-8?B?S3NndkZGS1V1dzArbFo4cHhvTll1UEpyMzZaQzk0ajVObHVZclZ6TmxaZUFS?=
 =?utf-8?B?T3VucllnOUZETmtEYmxQVzBQRGFRWHZhVUJodDNUbXhXMWlJZnlXdVArUUxp?=
 =?utf-8?B?eHBFQXVTbUlMQlh1aW9XMEpsNTA4VW0ra20zU2dPVlNCSStDcVlrY0VSeWta?=
 =?utf-8?B?dE56NDJWajRFdGw1TTBpZDhlQmNNYVFHWk4yZ0plUlFUUHk5K3FjU2RZOFBY?=
 =?utf-8?B?TmgzaHJTOEtqdlhST1VaM0RyeENGVkYzYUl0ODFudFNOTXlhS1YydVJrQjZq?=
 =?utf-8?B?RUEwTjBYVXF5SDFEMWp3a2ZJdGxGeGFtekpYR3RIaVpwTVhsOHpZTDA4QkVY?=
 =?utf-8?B?SVR3SnhkVzI1dWZrQ1h1b2hsWm0vSjFwb3ptZ2ROMFptVGlYd2h0VnNOWXJ6?=
 =?utf-8?B?aHBFS1dGYnhUY2VKTkNacjF2VVE4c0FJcUM5ei9pN2ZLWDVUenlaTXlCblgz?=
 =?utf-8?B?cGt6Ky85QzlTOFQ0NUJiNktpZ0VSaDNaclFGN3Z1VFFiUGZJQlZFWEUrWWdl?=
 =?utf-8?B?LzlyVUJ4UHNBL281Z0hMWmJwRkcyeHM3VFlnT0gySUZkNTBmdGRPYXg4T0Nm?=
 =?utf-8?B?REloelNZYTJrNG5MS2kzcUlMMUJGa0lUaUI3VllvdXR0MWpZU3RmOW5BdHFz?=
 =?utf-8?B?UExUekl3bks4eFhUaXZmQ1Zxc0I5akt1NUJhWS9TM2ZuNC91bHhlVUZWK3Rx?=
 =?utf-8?B?VHB2T1BHMThMaU1BWW9WSk1abnlYTTZZcUZjQys2Q24wN3BMVFNtRkZsNDRH?=
 =?utf-8?B?THl1VFJoZVZtVUNhL0NnY3oyQ1VYQ0ltUDJHZzg5ZHdJQkJjVU1VN01iU29H?=
 =?utf-8?B?d0wwdFloTlhBNkkwSjZXZENVRUxtQXo5KzB5NnUwY3cvL05meW9QUGxnZkVD?=
 =?utf-8?B?dEpEbnV4WURBVnJ2SWx0YkhVZWUrTEVtL3JLTjFvK3FKU0h1L2cyWGdUdGJH?=
 =?utf-8?B?VnB4cUtHWU54Q0JHRlhrZFJ6QkgxMk9kMjZCeHZVdFViMFEwOWlRbUNxdW9R?=
 =?utf-8?B?eWI2elRqZVBrbTlKckwrb3Y4TVp0WFlDRVlaRk1NMDhVSUxzRUp0eE9CYVVY?=
 =?utf-8?B?Y1FJbVc4Q1h3bmFFZWtDeldtWFdtVWJqUk1wNmtMOUhLdXhlNnZWTVRWUDQ3?=
 =?utf-8?Q?xoXS5soziWKv2HnMNs=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB6263.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10239
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:20b:290::9];domain=AS8PR08MB6263.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F1.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	2a98cbcc-b547-4ff9-e100-08dcd973c859
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?THdnOFNraE8xeFdCcUJFdEJwMkhtdmRBZitqVS9ESHNPWldjakhZS09ocm5L?=
 =?utf-8?B?ZU1WRFRrcHhXT0FiOWZ5RGZONkFGRWlrYkd6dXY4ekQxL3c2K2xFeEJ5Qzhi?=
 =?utf-8?B?S2g3L3FsNGhrOE5kWlU3S2QreHhzYkQ3eTI4Y052ckhrZDZsMGF4RjJEOHhV?=
 =?utf-8?B?Zi81Q2F6MGNLOGQrYTB1NFVrbDNCTTlhS08zM2JlRkdLY01WZ00wK2NzQUNw?=
 =?utf-8?B?MXpETlFTU0MzRGhTa09mcnc1Rm1qUFA2d1ZoN0k0L1pWc0FlY2kzcGJWY2Vr?=
 =?utf-8?B?dUV3VWV0c3NKMlIwZU5rTG95cUo3NTRONDkxamUrbzk2QWswdHlxR0pxQkxR?=
 =?utf-8?B?ZFV6K2NGNUVIOUJjaXpqNlFWZkdid3owM3A1Uy9MU1Y1ekZLK1QzbVpkc2RF?=
 =?utf-8?B?VTFDZmhSclA2YXBCOXhJcytZb0ZOTFpCT0x2bi9XenJBRTFOVEkzV0YwM3la?=
 =?utf-8?B?cjFVZmZtUXUwbUlWaEZGZXY0clJiL0lsNE1QVXZ3d0FvQU1WeEd2TE00NXkv?=
 =?utf-8?B?YUZvL2FiQVVMT0tkWXIwMVRwdXpzcmJVd0VOOGRjTDhTNGVxQnZINWdRMjdo?=
 =?utf-8?B?L09WaFNPSTB4M0NLUkprQ2RBS3hma1JsdEdSVm42WkEyeUxkdXBvOCt0MGMx?=
 =?utf-8?B?MGEyeStNSTI0TFlFMFNubHNjVXZFRnYvVDgycDJ6OTFQcmFlL1kzYXFJbW1k?=
 =?utf-8?B?SmhaSEZmY3BxcmQrWHlJc1BPTDJhWkF2dmVya1FlUHJGZ21VWTBHcFE2NE0r?=
 =?utf-8?B?WFFyNGdJdW9OdmhJM2ZUaDdLQnVWZm1kcXp2TDZmRVhrYkVPd1FVM1RTRXBU?=
 =?utf-8?B?MGJML3dKSTZ5bzZlRmZKOS9MYm1aZUUwRnY2aGhETUxBdXRiU1Z6QUZ5OFNP?=
 =?utf-8?B?Z3BMbjdSTUt2NFd6V0xpT3hEdGtYVms0c0tlN0RvZWRnZHpMd2RVYXJsVjVy?=
 =?utf-8?B?UWhxN3lpQjArRzJ0L25wZnhFU09td0lFbUZiSm5acnJob0hNN05iNWZBVlU2?=
 =?utf-8?B?K0NiTFZFUGdGOGt3ZVN4RFVBV2t2U2xIcDJxVFZpWnlkZnZ2L2d0ZTArNllY?=
 =?utf-8?B?U3RFR3BCS1hnSklHNkUwZjc1ekhmT0FKWWZPZXk4VXkrWmVoaDVreUdsdm03?=
 =?utf-8?B?N1dLTVNlRjNyZHIvaytIQjlkNTREQXBDd0d4ckhudEJ2ZVNUYlhJYmxxSUZY?=
 =?utf-8?B?UitjZXMvZStjbDdrLys2Z0ZtekJtcWtCY2lLV0J3ZGIvMzdaYnYySDB5Tkdu?=
 =?utf-8?B?YWlXazFMR2txYVF0WVFtWGFKY2FsSk15d1JmSlhoTjRmY1hqalVteWtUSlFE?=
 =?utf-8?B?blpBZjVOQ3FML2xpU2ZqdEs3b3JwdVg3VnBjdXpGY1JvWVNYYWtXMEh1VjlJ?=
 =?utf-8?B?L1l6V0Fjb29wRUNrRHYxSmhPaGtqc2F6VFBwYjhYemlCelNOcFp0TDVncVhm?=
 =?utf-8?B?dnF4WXRHcS81WHBJTnJKMFZLMXBCS2NnQ2JNcUR5Sm9Na2NJalkxNk44WHl2?=
 =?utf-8?B?eXZuRUZKcWNLUXZUanJORHRPMGVicHErVGFYWmhKcUU4TUh2eTRYQ21yZmhF?=
 =?utf-8?B?NHhoWGVqQkZRbWovc0k5NFd3TS9Rb3RNM1VNbThFMy92VGFsM1loOGlLaFRq?=
 =?utf-8?B?Z25QNjA5Y0tNSG1NYmxPVEhxeG9yTXlUd25VK0RDZWdldk1rR2hxdUVwK0dy?=
 =?utf-8?B?NkUrWHpVeVdBblJlUVZxeGFVdExjMTJsSUgvVmZIUkptcjFtd1g0blB6bE1v?=
 =?utf-8?B?OHpsRzZLc3pVd1hmeEw1L1BwK1c5YXpjeWQ1SjNWcUJsNURNS28ya2EyK2wr?=
 =?utf-8?B?Z0xtU2NhcjBzT0ZkaG9BNlU4R29oaE9kUFViSGE3MVFwUVlmbk5aRXNNU3RK?=
 =?utf-8?Q?ezoNU1HZnrmhX?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(35042699022)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 12:57:38.1566
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ee542df-b7ee-45d2-b474-08dcd973ce12
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F1.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB5977

Hi Daniel,

On 21/08/2024 15:37, Daniel Almeida wrote:
> This is of interest to userspace, and similar in nature to the GPU
> and CSIF information we already return in the query ioctl.
> 
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> ---
>   drivers/gpu/drm/panthor/panthor_device.h |  3 +++
>   drivers/gpu/drm/panthor/panthor_drv.c    |  8 ++++++++
>   drivers/gpu/drm/panthor/panthor_sched.c  |  5 +++++
>   include/uapi/drm/panthor_drm.h           | 19 +++++++++++++++++++
>   4 files changed, 35 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
> index e388c0472ba7..224c53dcfe6d 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.h
> +++ b/drivers/gpu/drm/panthor/panthor_device.h
> @@ -100,6 +100,9 @@ struct panthor_device {
>   	/** @csif_info: Command stream interface information. */
>   	struct drm_panthor_csif_info csif_info;
>   
> +	/** @fw_info: Firmware info for the global interface */
> +	struct drm_panthor_fw_info fw_info;
> +
>   	/** @gpu: GPU management data. */
>   	struct panthor_gpu *gpu;
>   
> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
> index b8a84f26b3ef..fb30e119d9bf 100644
> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> @@ -164,6 +164,7 @@ panthor_get_uobj_array(const struct drm_panthor_obj_array *in, u32 min_stride,
>   	_Generic(_obj_name, \
>   		 PANTHOR_UOBJ_DECL(struct drm_panthor_gpu_info, tiler_present), \
>   		 PANTHOR_UOBJ_DECL(struct drm_panthor_csif_info, pad), \
> +		 PANTHOR_UOBJ_DECL(struct drm_panthor_fw_info, instr_features), \
>   		 PANTHOR_UOBJ_DECL(struct drm_panthor_sync_op, timeline_value), \
>   		 PANTHOR_UOBJ_DECL(struct drm_panthor_queue_submit, syncs), \
>   		 PANTHOR_UOBJ_DECL(struct drm_panthor_queue_create, ringbuf_size), \
> @@ -765,6 +766,10 @@ static int panthor_ioctl_dev_query(struct drm_device *ddev, void *data, struct d
>   			args->size = sizeof(ptdev->csif_info);
>   			return 0;
>   
> +		case DRM_PANTHOR_DEV_QUERY_FW_INFO:
> +			args->size = sizeof(ptdev->fw_info);
> +			return 0;
> +
>   		default:
>   			return -EINVAL;
>   		}
> @@ -777,6 +782,9 @@ static int panthor_ioctl_dev_query(struct drm_device *ddev, void *data, struct d
>   	case DRM_PANTHOR_DEV_QUERY_CSIF_INFO:
>   		return PANTHOR_UOBJ_SET(args->pointer, args->size, ptdev->csif_info);
>   
> +	case DRM_PANTHOR_DEV_QUERY_FW_INFO:
> +		return PANTHOR_UOBJ_SET(args->pointer, args->size, ptdev->fw_info);
> +
>   	default:
>   		return -EINVAL;
>   	}
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index 79ffcbc41d78..e0ecc8bcfaae 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -3495,6 +3495,11 @@ int panthor_sched_init(struct panthor_device *ptdev)
>   	ptdev->csif_info.cs_slot_count = sched->cs_slot_count;
>   	ptdev->csif_info.scoreboard_slot_count = sched->sb_slot_count;
>   
> +	ptdev->fw_info.version = glb_iface->control->version;
> +	ptdev->fw_info.features = glb_iface->control->features;
> +	ptdev->fw_info.group_num = glb_iface->control->group_num;
> +	ptdev->fw_info.instr_features = glb_iface->control->instr_features;
> +
>   	sched->last_tick = 0;
>   	sched->resched_target = U64_MAX;
>   	sched->tick_period = msecs_to_jiffies(10);
> diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
> index aaed8e12ad0b..e235cf452460 100644
> --- a/include/uapi/drm/panthor_drm.h
> +++ b/include/uapi/drm/panthor_drm.h
> @@ -260,6 +260,9 @@ enum drm_panthor_dev_query_type {
>   
>   	/** @DRM_PANTHOR_DEV_QUERY_CSIF_INFO: Query command-stream interface information. */
>   	DRM_PANTHOR_DEV_QUERY_CSIF_INFO,
> +
> +	/** @DRM_PANTHOR_DEV_QUERY_FW_INFO: Query firmware information */
> +	DRM_PANTHOR_DEV_QUERY_FW_INFO,
>   };
>   
>   /**
> @@ -377,6 +380,22 @@ struct drm_panthor_csif_info {
>   	__u32 pad;
>   };
>   
> +/** struct drm_panthor_fw_info - FW information
> + *
> + * Structure grouping all queryable information relating to the global FW interface.
> + */
> +
> +struct drm_panthor_fw_info {
> +	/** @version: Global interface version */
> +	__u32 version;
> +	/** @features: Global interface features */
> +	__u32 features;
> +	/** @group_num: Number of CSG interfaces */
> +	__u32 group_num;
> +	/** @instr_features: Instrumentation features */
> +	__u32 instr_features;

This field doesn't appear to be used at all in this series or in the 
Mesa MR [1], besides decoding it. Can it be removed?

[1] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/30651

> +};
> +
>   /**
>    * struct drm_panthor_dev_query - Arguments passed to DRM_PANTHOR_IOCTL_DEV_QUERY
>    */

-- 
Mihail Atanassov <mihail.atanassov@arm.com>


