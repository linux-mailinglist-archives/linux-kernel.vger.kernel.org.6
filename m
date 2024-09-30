Return-Path: <linux-kernel+bounces-343335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 549E99899C3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 06:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC4C71F21853
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 04:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44567136341;
	Mon, 30 Sep 2024 04:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="iK3HsERi"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2059.outbound.protection.outlook.com [40.107.20.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0262F29;
	Mon, 30 Sep 2024 04:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727670832; cv=fail; b=P+2gbV6Bx78v6HDuZXfRnAGRmrk+mYbb1BZjT9npnxg6OB4DWlrj2ZgAHiUQwzDkcVc0EhW6FOK52EB1j99sBWOvreDIjOKaK1mQV8d9MqD/LJy03OacmGiAuP+b/4zPleN/nvr9qrgM1DS4Oq64fiV+yEtLx50z1K1sxNcmRXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727670832; c=relaxed/simple;
	bh=pGARjIttRQ4ssYIsVlpZmhv6sFoN/3rqlRVIf98T+f0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GduyCCpbnhM46MNj0jp9JLrUp+EgqPKG79UovgYRtDC/+zuRKIGe2+WCmjtFzB8YZs7sKIVJhX2Pf+OHxtcDi1/xuoGPaDeDMQ0deWA6h4waWyC5FjkcQlFkRPuQ7eOVk1Z33JPOxQSAosjMYMkhmvSUwI9wW/Dp/3yXIDLbSAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=iK3HsERi; arc=fail smtp.client-ip=40.107.20.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W9ZDWVsH3CSlhnUfdhyTVI8G9g0oosVDQOrJKwyseImJBVhrmgmkbIl62CHmL2oxg5V5BbroQLVZxMsWzE1Dog5WfflZ27+UVoukiRGvfFRTf87DtLfJRrG9AkH3rZ8RzjZpCkTIx++5Vfta4nDgRfa+uaFW77tEq5VcRi2nuGxBJMfoA06jcR12BKxxyXzwWk3xHQIZjUvrV7qvxV3LvD3rsbEeYcmfu3AMjw8FLSbCvojm/1eMe6EvWNWN8KB0Z58DgkXL59j7zf74SPNpjBn2ZMJYjockk7+ROaO3OKZCg4lvYuzKj+tBmkLm9fRjnMak6dDZCVYKVCEZD1vxlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WiboOI8shwLMD8kXEWzor1mh+6Lf6B8tkU849MFfyJU=;
 b=Dn1gdEtlj3A/p4mgBd4XiIQRxpcgcnSEMVINOjI33hjbMB3lhtzQFWLB4qYQVoPg2oKc6+YdqBQ0i+Irpfx6kUHw9m0awaguCXhw4oJ3RW2zciuXWhk8ktWvi6ajcWNV9y6GrEWSgQJ+E11+kkSc25xUkSADz/ilWmNL2b26cRdZopW3kmKhy2jRCjVe9fqtJR3w/qgzuOONqnK6BGjwZAQLk3/krk0Y2gSjEcZsgz68NkYF5yoxAIiEggTNOr17/Os5mMS7iRi5ivDKSqJ3MIppJV3qDcRrDCwqippaIjPwr01+e2zmRg/bsSgCDO0PgGyocZIcFFOHTDC49AezWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.205) smtp.rcpttodomain=collabora.com smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WiboOI8shwLMD8kXEWzor1mh+6Lf6B8tkU849MFfyJU=;
 b=iK3HsERi30Y/kdkd0P9Jt1ii7BytUbG094wmXlIzEZwBB1Twqii3dI2kQWiWcJfcL5tjrGsihktUqifA4p/MHgstjRxtjX/gdKjhrqMvwfNBPTjmx5JlhwQCCvJ5qPHacqzOO1eTwU8cJk1EGMPHgCbsaFrJoP9QgEUtTfVU14Vbt8CRGQe12oIqsPAHQrBh9xJHktr/Y1ThPvds/rvAuhAZCHH+jgpk8nG0l9nLfs4RPxg8paQv9x4ltZ+qTHkIkoqEpcJYemk/p2IbhFdjRwECv3qpwzST4oGa4RRQyqkVrMQnxaT3/yVH/VuItN1fi6HG0rp2KCIGwIQC7Bi2xQ==
Received: from AS4P192CA0023.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5e1::9)
 by AS8PR10MB6651.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:563::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 04:33:45 +0000
Received: from AMS0EPF000001A7.eurprd05.prod.outlook.com
 (2603:10a6:20b:5e1:cafe::55) by AS4P192CA0023.outlook.office365.com
 (2603:10a6:20b:5e1::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26 via Frontend
 Transport; Mon, 30 Sep 2024 04:33:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.205)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.205 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.205; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.205) by
 AMS0EPF000001A7.mail.protection.outlook.com (10.167.16.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Mon, 30 Sep 2024 04:33:45 +0000
Received: from SI-EXCAS2000.de.bosch.com (10.139.217.201) by eop.bosch-org.com
 (139.15.153.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 30 Sep
 2024 06:33:39 +0200
Received: from [10.34.219.93] (10.139.217.196) by SI-EXCAS2000.de.bosch.com
 (10.139.217.201) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 30 Sep
 2024 06:33:39 +0200
Message-ID: <51fe3ee3-0b81-418d-b05f-626dbcea4f57@de.bosch.com>
Date: Mon, 30 Sep 2024 06:33:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] device: rust: change the name function
To: Daniel Almeida <daniel.almeida@collabora.com>,
	=?UTF-8?Q?Guilherme_Gi=C3=A1como_Sim=C3=B5es?= <trintaeoitogc@gmail.com>
CC: <rafael@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
	<boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
	<benno.lossin@proton.me>, <aliceryhl@google.com>, <mcgrof@kernel.org>,
	<russ.weight@linux.dev>, <dakr@redhat.com>, <a.hindborg@kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	<rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <CAM_RzfavjM9VPJhTi1czOSC0BFOc3FUHRMdzFrU9fJE+WJMKbw@mail.gmail.com>
 <32476CD7-74D6-4575-9D93-2FBCD5AE3E10@collabora.com>
Content-Language: en-US
From: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <32476CD7-74D6-4575-9D93-2FBCD5AE3E10@collabora.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A7:EE_|AS8PR10MB6651:EE_
X-MS-Office365-Filtering-Correlation-Id: ef1c4ac1-c992-4921-2a29-08dce1091248
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WkFvbWhMaFc2bnpBdmFXUWprU1UrYlVtUlRlT3VOaVhhOFZNRXM1T2hjcWk1?=
 =?utf-8?B?V3d3SEh6L281NXhDNzRzNERkVVh2ak9MYVI1a2VTQ284N0JFTldYYTlEMnIz?=
 =?utf-8?B?cEhVVlJmZnc5SFphSkxxQlRSRExwZDFsNXdFTnIzZmozZEhnNXl3c1YyN0R5?=
 =?utf-8?B?S0hFR0JuQ3ZoNXc0VFZjVHlIVGFveURrUmFQRUdOU0lPcUNTZFFxYlRaRzNn?=
 =?utf-8?B?ZDlYVVNpUUVUS3dIVytVd2t4bUJlQlg5K09yN0lrNWZTSUxJbGRFWVN5WDI1?=
 =?utf-8?B?K3VhdStvVWN5dThSTHpVTjVTV2RKV3dtdmNqbHIrZVhNQnZyQnZvdjJ1S1R4?=
 =?utf-8?B?N0VDYWlwMG9HMUlXWUtlZzdNbHdVeEowNzY5Z3RBMjV5ZGN0aENrekpsWHZ5?=
 =?utf-8?B?OEVUSnFnTDZJOFZGYjJyMk5pUlZDNFE5ZnBJTHpVMWlCQ3NCM210NFdIODYv?=
 =?utf-8?B?NWZvR3Q5L2NSWUhiNnhDMmR4T1FhMkZIak9ZMHZSVFpZS3pyUHl5M1hSSmJo?=
 =?utf-8?B?R3Z2QU5lR1VwS2Z6T0lDYWFkN2o1VHRwOFlJK3BmaXU5N1QrY3BqclA1bHlt?=
 =?utf-8?B?QS9pVmw5MFUwbEVlYmtBU3BNb2R1ajc2cGYwbWxzenlQU2J5eXF3QkhoSFJZ?=
 =?utf-8?B?b0dCcUF1L3RNYXpYV1BOc2FabUg2NDRtdC9EWTlyNWF6dTdkUkdHU211cTU0?=
 =?utf-8?B?dnJXaXpiUjgycHBpVGphSGJaMFZvaXMrc3AvQ1RBZXlxU005NUhTZG9GejFo?=
 =?utf-8?B?QVdkSy9halZUOXN2dDNITlBpTE96bGFkNmlqN01zQkdhRnJXZlBJRmJlcERK?=
 =?utf-8?B?MmVpZEJIeG1SaHM2S3lJZzk2U2UxZCtqL0h5empGZU8zeWRYM0ZweVlRU2kz?=
 =?utf-8?B?Z1phc09GUjkrRDFoS2lMUHNRSUtBcC9CVVZxdmFUZzMzM2xQc3Nxc3pJWGI0?=
 =?utf-8?B?TVlDNTZkN0ExTk1HRXgzb2NSQ0RsTVNxbzg3Z1JvOGdKRVl3TVo0a1RCZWVm?=
 =?utf-8?B?Q3J6ZWIrWHgvTmsxRkJsa3lVcW54WnVOTWpXSnJSUnFCeDlyK1RvVzJMcDRT?=
 =?utf-8?B?U1h2Tmgwak5aYjhMd3piZTJVU1JFbHFYblJzTTdYOG05bS9adXZCanAvYzdq?=
 =?utf-8?B?NUs1eGJJb0FKcFppZjhxWDNFZ1NsYkFXd3JWSnIzV2poWTMvTFNHSDRGOEVF?=
 =?utf-8?B?K2V5SDM0RnVpaTNyL2ZrK2doSkxOc2o2ZVU4cEJjenRSbXJhRkVVbXBlazNN?=
 =?utf-8?B?dlp5Z0pSRzlPTGtuWnlqazF1M0dkV2tIZ01Ndk5OK3oyMWt5Y3ZVMy9NYyti?=
 =?utf-8?B?QkVMTURUK01RY2N2S1NySGFRcEJ0Nlg5WG5Fd1YvNE0rQTQxQTY3cGsxb2Jx?=
 =?utf-8?B?M2d2aUJVQzJWNml2T1ZaM2Nqa0hGOWVPZ3l3MEdZenBrQ3VGek5vQVducHEv?=
 =?utf-8?B?TmkyQ3UrUlNGa0VMQ3FIMENjV0xibkRuMWcrcHdUTnJnc0tzQ1hqNWJvbTMz?=
 =?utf-8?B?aFNTT0c1T1pWRkNMWFRMeUxQTjdydkI4dDU2TGFBVkxJcUZhTEs5ZVFOOEhH?=
 =?utf-8?B?Nkp5Ums5ckZQMjQ2YU5JdCtyaElxbTBkVFNlYmp5TEdUV3Y2OGpMa0c1OU5y?=
 =?utf-8?B?Z1N2cVJKbGJjWG0yT0o3MWlQOExsZjVTSmFQcW9MT0dEQ2JGdkdJVGsrOFAv?=
 =?utf-8?B?eUhJYnpzeGtmU1VuMlN6Vm0vOTlFdmNDZU83NGVaY3dTdkRlQ0JPMmloVUpV?=
 =?utf-8?B?RUJ5c2NpdUhmcGdqR2lubjF5Q3RBazVtMGJnV3VEa1ZPL2p6Y0FyWEZtQ0RX?=
 =?utf-8?B?TTU0amlsdG5mNlYzdUVHcmc3bDhUSVAyNFRwa3UwOUc0WjJPZEFaS2Y3U3Zx?=
 =?utf-8?B?U2c3REtBL0FRWWI5Zm9tVXBvTFpOcndrNnFCV0xnTzU0a0lQQ2lhRGtDV29F?=
 =?utf-8?Q?C0jY/aBu5rGPSvEAI+f6iEJdjSiNZORH?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.205;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 04:33:45.6817
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef1c4ac1-c992-4921-2a29-08dce1091248
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.205];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A7.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6651


On 29.09.2024 17:35, Daniel Almeida wrote:
> links may become stale,
> so please do not link to anything.

This sounds a little too general to me ;)

I mean we link a lot, using the 'Link' tag even in patches.

For example the mailing list archive has the 'permalink' button and 
Zulip has the 'Copy link to message' button I think can be used.


> Lastly, I can’t see a diff anywhere.

Yes, I was confused by that, too. But I wonder if just the numbering is 
wrong? I.e. if [PATCH 1/2] was intended to be the cover letter 0/1 and 
the [PATCH 2/2] was intended to be the actual patch 1/1? Just a hint :)

Best regards

Dirk

