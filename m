Return-Path: <linux-kernel+bounces-200061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAFD8FA9F8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 07:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 000A11C21212
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 05:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E1313DDA3;
	Tue,  4 Jun 2024 05:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="sPrX8ZiB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="fzh3W186"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2122.outbound.protection.outlook.com [40.107.7.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1215613D608;
	Tue,  4 Jun 2024 05:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.122
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717478822; cv=fail; b=k8qVb5tyXZkqWmXCkG9J7vif/caB8NWkPFzxuLv3RA4htXrjM9DBczGhOpxTuTXeVXeYak8UOdRXt0TkKX+3QkeHQvoU5PktxP1KLDtOBlsECI/Dr+y5sgMbryE8ZoowHTEVdw4tZwEp//A9QRq6+g8Is0RKGY2aPRDU111iKLY=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717478822; c=relaxed/simple;
	bh=FhALn1tfY5t9s12jNn8MWtP6Aw9O1xPkIr4ySAE6j8I=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AtApKcB3CCf12UuTz+4zQ5vUwZ/yQx44MBIieYi3qRSURWGSf8NC1UugkZWg4Yk9qE+nOouP86DfofekmnEqv/BQrfaOG6g3JT0ApEIeNWP1gLqIUUdaBBJH4kx+lplfY9IgrdbgsFpABskR7SGvfNTmBEqYhg3zPTdk5WCd0wM=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=sPrX8ZiB; dkim=fail (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=fzh3W186 reason="signature verification failed"; arc=fail smtp.client-ip=40.107.7.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=fail;
 b=V66qJmyJzugJhP2TnbAQn4tUENygYfjTrKzZYf7+oSGNrRhLzj54hTQlT6SbuDe/HbSdU8nWSep+oQCAZB4CpTCUZpfPG4Sk6J1SMnh8uUbfPFTW6LsGwWVxRr7NCiVCaJx4aoGyimT5pUB3WRCc9H8+Yh2mtYzQupR/7DABpoIQVx8EBmzPDcmgELo1C4TaqQZBc1A90arb0WswH8qg4Sbu2mP0ucNlIiqXfyohpxNueJaKD0LIOZOwOV5NXzUF4rkHD7lHlOhJX3DzGweXGg7CvhJMpnJ+UCnY2g8PBvaNfZDGBx4Gi3y30ezPgePDdPpx5uSRTs4TlUEnxGH0qA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VbRAV69cpyVPExIEwruzzZwXcZVOkXF+DDcwScutIBI=;
 b=QYpbjeBk2APv6eo0MKeyRZmSno4AyZToWzolxt7EeIwXHmW3gGbuE6mg53m1FH6mf0DC9CTaPrMU/gpctUi7wbCMVxHSnvVJuNRGut4VRnPTXDXfTDwNe/1MHRdhJusOJJuX236WvDs0rVEo3I5LNWxuVaNATDhnb0aJTqZ0isa5HLOVJw5vJa5MT1ONQwq+arNmWsOk8JAVh5mv2kRPMfXcN/qVFlInEp6CkGsktpiMb7eTXDELmeDIW6ZXvt9E6YfpnS/Xu307WXWN/XSkbXdvnuG9AUzgUY1LOTGEA1tI2HcFlgcb7tNmguQaDi+CoE8k0xGYKhmN2CDl9lcgZA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=synopsys.com smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=fail (signature did not verify) header.d=topic.nl; arc=fail (47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbRAV69cpyVPExIEwruzzZwXcZVOkXF+DDcwScutIBI=;
 b=sPrX8ZiBpaNZecufpjSX+MJSkg+grBoQuQoEbnXKGq8lt17gL+pYrA5e421tNJJSbGGIWihHkBqMB5/u8W4zRXsui90MUohGAziZHp76Ty5wt+YAT2zd2ft1LH72NwOFgDSk3Psd9V2qJyCM7sJxVh3HSBpSwf0kJRVadUKqrtDSvqyDJxltKVL66VoSgrHtXR5F29KDqk1K38pRHmlvgk3GfT/4K7Pw1EZFu4uazX0I8cgy25bF0V+R/mBYPCNwAWOak4HFTNvG9P32CXpuDDww6ev1d8K/vsrnixdj8d24WNTAqQszda+ReZ/8Sk0/hpV2LAsbNFo2f1RbgETsKg==
Received: from AM6PR04CA0048.eurprd04.prod.outlook.com (2603:10a6:20b:f0::25)
 by DU0PR04MB9561.eurprd04.prod.outlook.com (2603:10a6:10:312::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 4 Jun
 2024 05:26:55 +0000
Received: from AMS1EPF00000042.eurprd04.prod.outlook.com
 (2603:10a6:20b:f0:cafe::6b) by AM6PR04CA0048.outlook.office365.com
 (2603:10a6:20b:f0::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30 via Frontend
 Transport; Tue, 4 Jun 2024 05:26:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=fail (signature did not verify)
 header.d=topic.nl;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 AMS1EPF00000042.mail.protection.outlook.com (10.167.16.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Tue, 4 Jun 2024 05:26:53 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (104.47.12.50) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 04 Jun 2024 05:26:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A5iX/LxFVBaisS0j+8bwfalUtLMvG/yPiToaJ/gxD/wpEWoWr+DDhKNFtqSjWkjVYnBPqK5kK9tURz6oJKuxGfdfXgH1O+ujvx3GP/fa9E+6L5j/6AdQbGceJldMiJTnvoyZ744lhPMHkQbuTrj1geBFtVEJR05+KPLrNsi1NW+gVl8hB9vf2ATSFs8KwL4wNxxdKcVZPmyJtlUYtwNzHbwiruRpRD9dOOInOPm0/hOO0z5nIv5KUhHKbc2nNRjnlb23e4cJO3pniwSzUQ1RZZ8HEX06Ki7YFy3oQZyOl1FSL63M0XDlSdSAi/Pvy2oW+3hWLKt3qIlwY22/7nN6Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3BAX8XfDGni16P1anc4tR8A69E4xbJlHcSTLr/9lvI=;
 b=aKJ0Hux2AYcc8aQD2aLHHBC5HSw0S47zmEl7uXn3H44mHq+pLpfSUmuT1bhsddJ5we4N4OFly124qC5mPXMeLG41h6xmZlI55W7BVyhB/ozZHPTzldNjac/hAkJMs8cN+hthOMMBpXUwhcP9MZf3arlruhgo6imK5u9mKKsLClHhR08o0dyFPsm/GDPiHpr3XKWkMTfiibxlmDgDZbXuK0brW1FakgGjcR0zA8sOYMOns6mcWu4hxzebFBLssxM41tk0ckc/eM5UewWy2flGgaT3lxchdjP9CQcIX0dQZUNfagZyEPFUllZUotdDNFZ0BaxGvNlhZrQ/nTnYNAQkrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topic.nl; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3BAX8XfDGni16P1anc4tR8A69E4xbJlHcSTLr/9lvI=;
 b=fzh3W186XVzW0LaiCWbZc4ljD9nLLaQ42+ov/HiIDs4wlS6PylvIptbMF3zCZcc8cJXmd62iy+nkvYf/y0J/oZcJAy08XNnBzXGsjD0twhQ7qrYpObMxpvHee7SUvLoQpvdRX/5MhyL2M5Za1zj0pbBLohMHW0E2xLQgpg28P+xRKv98HLk+E8JSZyxfckimVyrG71ai/QPNCWhByZjCXyk0PIw8gWTz5arIWT6VF/l/Z8tDHja1S8MoqEx8/ICvXt783V2TLCKWpLem6Ik/6+LnG3/gmuoL5NQulrPja+4ma/wvj2/p2SLjH8PuEXI2G4/K7qVdSdWOBNNQRjQ+Vw==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by PAXPR04MB8160.eurprd04.prod.outlook.com (2603:10a6:102:1cb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Tue, 4 Jun
 2024 05:26:50 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%5]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 05:26:49 +0000
Message-ID: <0fceefc4-2b3c-41a4-a6ac-d0b6dbacc1f7@topic.nl>
Date: Tue, 4 Jun 2024 07:26:48 +0200
User-Agent: Mozilla Thunderbird
From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH] usb: dwc3: gadget: Inform system of suspended state
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.c5f44c79-75b2-43c1-a791-806fe8b693cd@emailsignatures365.codetwo.com>
 <20240603131304.233403-1-mike.looijmans@topic.nl>
 <20240604010256.4dxamwvcjxug6xfb@synopsys.com>
Content-Language: en-US, nl
Organization: Topic
In-Reply-To: <20240604010256.4dxamwvcjxug6xfb@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR01CA0126.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::31) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|PAXPR04MB8160:EE_|AMS1EPF00000042:EE_|DU0PR04MB9561:EE_
X-MS-Office365-Filtering-Correlation-Id: 4311eec5-adf0-48da-5b3b-08dc8456f18e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230031|366007|376005|52116005|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?a2ozWjJ5ZVZpcDJ3dVhnakR3cE13V2s4bjBhSXpaRlBtVEZBYjEzalcvWUlh?=
 =?utf-8?B?STk0UzgveVBpZTk4anRCTHVWL3MzQ2lnbFJyeVNJeE5RTmtXcWNlOVM1WmJE?=
 =?utf-8?B?Q1Rrd2RJeFU5UEE3aWVJK1VhLzRPVTlWd1d3Z2hSVE4xbmt4akVMTUdDYVkx?=
 =?utf-8?B?Q0I1a3c4T2wzSWZjdXFsQjVQT1JtVVhTUWVSdTlCcFpMeWU4ZlMyd0IwclZJ?=
 =?utf-8?B?YWFtSVF3KzVvZk54Y0RvSG9qZGlUT0VGaHJjdjY2MFRDL3JMdGJPRjhsQ09C?=
 =?utf-8?B?NURELzFPNVZKUWxYOElGRFdGT0MyWTN6SVdpZ1piTjhKK0ZUQ1lrQ1BnRGJ3?=
 =?utf-8?B?aXIwaTBnU3ZsRXNqNjhLaVpYeVlqYU9PT3piTGJkL25ZeDUrSW5oem5ZK3JF?=
 =?utf-8?B?NW5kei9tN080dmZFUzl1V2N1T1R3YnFSa09lYXNJS0RRRjRrRmNtVk9hdFhM?=
 =?utf-8?B?WlRWRkZnQU5WOWFwV1RpR1A2ekM5RkFQTU1KSFovVVh3RUYvTFl1ZDd1cXcw?=
 =?utf-8?B?MzlHVlRWcXZ6dG9sNFdQV0VVRmVOQ3hrZHZCTE5DSWlJS1pjUVRMbzFQUTNL?=
 =?utf-8?B?Q1VLS3lUNnJZL0pTb0lRM3hPNVFpWEt6NTBQbytEdUxjczBCZDdrZmZKNHpr?=
 =?utf-8?B?cFRjaWZmV3lrNjRGZU51RFB3SW14cERveHhVQ25EQ0ZNR1VUcHRGMnBvTWE0?=
 =?utf-8?B?ZEtSMTBmWVpDMTE2aXNIbjVsOHMvMDVXTDZKS09WRHRHNGJOb1B0WGN5K1Y4?=
 =?utf-8?B?emxDSlNMVlpMOFFnVDNHMXZuZHlWQmFzMWtLeXBxS0I5czFxQlI1NEgzZTRm?=
 =?utf-8?B?dDg0cUg0MmhrMTdkMXYxa0hMSTJtcitFQlZ4VTBkUzRwWXZzY3ZEUDJybFVy?=
 =?utf-8?B?VkpaUGdlWHB2K1ZlRGRPUzE5N1ZKZ3duckw5MnJjT2Q1dkhQeS9PbXJma2xx?=
 =?utf-8?B?QW9URWZ4YXBITzFPeHhQaWNkdWlnUXBoT2RiVWtFWGdzYXFDOE45enV1MGdI?=
 =?utf-8?B?aTViR0xXNkZiUXZ5S0kybmh4QTlVcnJ0UHpMbkxLY21DUE9DakRoNzg1MkV0?=
 =?utf-8?B?ZTF5TXBWajVBZ2FQL3N6ZnVCcEVwWEpzNGZUNFB2VjFjQTFJcUhDS21OSXZP?=
 =?utf-8?B?eEFBYVBsNTI2bjZ0SDlaSjdKUGczWmhhOWFVd2Z0djFyRlR4aDN2ZU5aZE94?=
 =?utf-8?B?MFk0cWdEemNHalZGeXhiWWhFRklWMTVnTmFUNWNDNmI2K2h2aGRuVjlLWUNo?=
 =?utf-8?B?RDkwQklLWit3a0FkSUMxYWdOSHIvYmxWM040Nnk5aG1xWEVWNzIwSlRTKzJ6?=
 =?utf-8?B?bGswVTBlS3pRUEdrRXI4N29Fd0lRS3hUcGE1ZGh4Q2JIWHhqdW5OOHJ5OUs2?=
 =?utf-8?B?NGYrQXRuUGt2d3QrSy9hRXJuRnNaU1NYa3hhNUNCdHhNekx5SUQ4bWVIOW56?=
 =?utf-8?B?Wk5kWXhLRG5PYTlyc3JNTVd3RXVncks2bWxmdDB5a0NPTkIyMmczdFk3dXha?=
 =?utf-8?B?L2VqWWNGOFY1c3ZvYmNoRG0yWFJZWHRmd2drWGpScUVzMlJ1NU5SVzRYbnQ5?=
 =?utf-8?B?Wk45OEJWd0t5TGNYeVdRWDhoSnBEV3hqRDA2aU5JdWhWdnFvYVpEMkhVUGlo?=
 =?utf-8?B?VnhNVHRYL3dnNm9TaCtQZCswbUkrL0Q0eDNaemtubHBBczZHWllZRnZkSkNq?=
 =?utf-8?B?dmJQSFkxeHVRcjFYMWJPR212UkV4Z1QxNjFLUE9sRTdnT3RMQ2ZLUFFBPT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8160
X-CodeTwo-MessageID: 7097d2d7-1dfa-42d9-9542-2b4cb81d4f85.20240604052652@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF00000042.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	e59f5b2e-db81-46fb-1a1b-08dc8456ef55
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|1800799015|35042699013|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VCszd2I5NnJTUmRUTUNxV1pQSUpiUExYUkdWVEs4UzBDZlMvZmxxOWl6cFBP?=
 =?utf-8?B?MitkTTJxTGlueWtZUmpZazYzVUNCcWZhSHBuWHdwN290NTRLRnFFTHZKOUdK?=
 =?utf-8?B?V3ZDZUpUSjBONTNWVWZqeTVnaWxFNkF1L08vWDRSWG1QSTJCNFNHczBUZ1VU?=
 =?utf-8?B?RnhEUXh0VUlBMWx3c3FwRFVMdlY0QUpkZVIzdzcwcUQyMzZ0cG4zTGVBTHU3?=
 =?utf-8?B?R2FZYWVQdmR6S2Q4ZGlqaFdtWWRDTTkxeFNWSTRJTnRNdCtMZE1pZTZQdkVW?=
 =?utf-8?B?Uk9NajNuSmh0aTZMcEtkYzBQblpCU3hTd0FGVUNwTnlkZ0RpWmRWTGVGbXJm?=
 =?utf-8?B?YnA1ZHVGcUFERWRKb3lLMHpHMTZqdlJHeFFXMktQWGNraFpjemJCU1VUSndC?=
 =?utf-8?B?SEZ6dTN3a1NvenExWFlPbDlvQTZHM2F4WDZ6UUdlWjJhYnFOVWNmSVdhMUs4?=
 =?utf-8?B?d01XZ1BpZUpIdmJndDB5VFY0VURwYkxRN0R4ajBPNUFKY0dHQmxNT1h1Wkpy?=
 =?utf-8?B?bCswMHJzTmsvN1g5ZjlKZnkvelNsZHdIK0o2YXY5NWxHR0kzKzhlU2lyYjZm?=
 =?utf-8?B?cjhFUWxIbWJvb1I2dGVCNFViOUYramZVZG9HTnZDS0VzdVBZVFp1ZGN2bnhY?=
 =?utf-8?B?QmtQbi9oTVErS1dPSTBUYi9sM0trS2dRT2pTNk00MmRUNVZ6UWFTWGZNYWFr?=
 =?utf-8?B?WFpUOThWR1RGVHRaU3MyRHhrenJaOUhJUHRZM2YyVW9ma21lYUU0dEg0b3hM?=
 =?utf-8?B?eVVBc2d1c243TzNaZ3RLTk9rRGxFSElKdFpQNkwwNHMvNUR1RVlRTmZUOUFt?=
 =?utf-8?B?WHhpMFozYzczd2QrMFd0KzA5LzFKK05kd1RHMXBkdnFwZjc2dDdCZkJ4QWdS?=
 =?utf-8?B?TmU1VjBkWGFYeG8rS0pHaWJ5YUdNVEpjUXJtR0ZXYkl1em12UXRkeWNqWXBG?=
 =?utf-8?B?VUo3VUtWQUdXdWpGS3BFVWxMeU1nSm55ODJOaG13UHprMjVGYkk1WW5KczVN?=
 =?utf-8?B?NnJFcnFCam15V3Bwa0R4V0xaemlWaHh0Zy9rVTJwVjdKTDRsTDJMWitKalds?=
 =?utf-8?B?amZsV0NpRm4rNW14ODh5cXN5YU1PSWIxeGhNUzZocW1qRHF1VHJOU3M2aXh3?=
 =?utf-8?B?V2Y3Nm15aEZpWDhyNmZ3ZUFqeDJteldDT3Jrd3lodUZ2bHN6Rk1nSUpaVURt?=
 =?utf-8?B?QkEveERoYWhwUGYvdlVFQXhXUklWRXo2K29iVGsvOElianBya0lsTGNXNTMw?=
 =?utf-8?B?UHlQVmNRVzhTRnVYRlZ2a01XUXB5N05vNHplZzhLd2tVVlBZNExzTXpGbjNX?=
 =?utf-8?B?ZDRzanA4Mi9IWGQ5VEpjWURoTnZUQzkzQlhjTURUbXBxQjh4ajB0SGQ3QlJM?=
 =?utf-8?B?d3pZV2lLdHI5dE9wMTBrblppODUwbVNYaDdhbmNYMDM0MEZjWldWUFF6cnkw?=
 =?utf-8?B?c2xIUGg3VUNoM2RBa3Y4QXVFdUNMUXZieWE1QjBOTE9wRzF5c2k1Z2J1WVlD?=
 =?utf-8?B?Y1lVdkt0UGJEUk9oY3cyUnp6c0lrT1JUVStvek8zclFlZE5kbFMrVVVMVklh?=
 =?utf-8?B?WkQ3UEp3bEJJcHZJS25ORlVvaE9GblpXTjVvVWF1SjlUT0MwOTNvYmNiZGVl?=
 =?utf-8?B?QW84a0tuM1JaL3VNSWRNM3JXZTVua0R1UjdWN2xlQ3lhM1BBOFlRRUIyV0lU?=
 =?utf-8?B?bmFyOTlrOW0wUmthdEV3ZXRWQkY1TUc3c3VoamRrNVhDV0ptZitqNGgwejhz?=
 =?utf-8?Q?C21CaFCPmL3MHJCgDMBixQeSRx1K/mq9k9LjxKk?=
X-Forefront-Antispam-Report:
	CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(35042699013)(82310400017);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 05:26:53.4147
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4311eec5-adf0-48da-5b3b-08dc8456f18e
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000042.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9561

On 04-06-2024 03:03, Thinh Nguyen wrote:
> Hi,
>
> On Mon, Jun 03, 2024, Mike Looijmans wrote:
>> When disconnecting the USB cable on an LS1028 device, nothing happens
>> in userspace, which keeps thinking everything is still up and running.
>> Turns out that the DWC3 controller only sends DWC3_DEVICE_EVENT_SUSPEND
>> in that case, and not a DWC3_DEVICE_EVENT_DISCONNECT as one would
>> expect. As a result, sysfs attribute "state" remains "configured"
>> until something resets it.
>>
>> Forward the "suspended" state to sysfs, so that the "state" at least
>> changes into "suspended" when one removes the cable, and hence also
>> matches the gadget's state when really suspended.
> On disconnection, did you see disconnect interrupt? If so, it should
> transition to USB_STATE_NOATTACHED. This change doesn't seem to directly
> address your issue. Can you provide the driver tracepoints?

The device doesn't issue a disconnect event, I didn't have tracing=20
enabled in the kernel but added some dev_info() calls to determine what=20
was going on. Added this to dwc3_process_event_entry():

dev_info(dwc->dev, "event: 0x%x type=3D0x%x", event->raw, event->type.type)=
;

When disconnecting the cable from the host, I see this:

[=C2=A0=C2=A0 50.841411] dwc3 3110000.usb: event: 0x6084 type=3D0x42
[=C2=A0=C2=A0 50.841457] dwc3 3110000.usb: event: 0x4086 type=3D0x43
[=C2=A0=C2=A0 50.841494] dwc3 3110000.usb: event: 0x6084 type=3D0x42
[=C2=A0=C2=A0 50.841534] dwc3 3110000.usb: event: 0x4086 type=3D0x43
[=C2=A0=C2=A0 50.841571] dwc3 3110000.usb: event: 0x4086 type=3D0x43
[=C2=A0=C2=A0 52.650990] dwc3 3110000.usb: event: 0x30601 type=3D0x0

The "0x4086" and "0x6084" messages are endpoint events that occur all=20
the time while connected. The last event is the "suspend" one. After=20
that, total silence.

If you need traces, please point me to a description on how to obtain them.


>
> Thanks,
> Thinh
>
>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>> ---
>>
>>   drivers/usb/dwc3/gadget.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index 4df2661f6675..99e8ea9db600 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -4343,6 +4343,7 @@ static void dwc3_gadget_suspend_interrupt(struct d=
wc3 *dwc,
>>   	if (!dwc->suspended && next =3D=3D DWC3_LINK_STATE_U3) {
>>   		dwc->suspended =3D true;
>>   		dwc3_suspend_gadget(dwc);
>> +		usb_gadget_set_state(dwc->gadget, USB_STATE_SUSPENDED);
>>   	}
>>  =20
>>   	dwc->link_state =3D next;
>> --=20
>> 2.34.1
>>
>>
>> Met vriendelijke groet / kind regards,
>>
>> Mike Looijmans


--=20
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl
W: www.topic.nl




