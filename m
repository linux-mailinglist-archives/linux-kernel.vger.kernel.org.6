Return-Path: <linux-kernel+bounces-548667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF86A547D3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97D113ACD41
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4635420102E;
	Thu,  6 Mar 2025 10:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="qCIjB8S+"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8621FF7DA;
	Thu,  6 Mar 2025 10:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257232; cv=fail; b=C++3Lhyz59paqIH5yTeIzhJRcZ3FwMALqREuIcUsAQLCtY2TsiiHuhy9ROacRxGQNSm2ZVJ9u9fA4/0VZy+2qNgoADma0dVNKFRA7JgNQdQhWV9i2+MfTNQV+m3x6TqildJbF+WrbxEiXIBKuK/wbqmUWiItOklB0qBDOnx2y20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257232; c=relaxed/simple;
	bh=dsFXmHYlHuB2ycdd+I9Fe76f1TCN9F6PEyH18NKsfAE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KPdLyh4wExWoBdMHTNodbO/0KL/UxettTDs6WZGMnVRowUd4fgFBHWfvp7fQONnDS/9Zrmo4Y556dViSTZYuvub1w8iY/XB2Gv+7uMBDAASnyN3kWjQN+OgDTAwgM3cxaJg4Bst44J3AexKaENdWuuPIo1yDZvaek/7MnSi/RSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=qCIjB8S+; arc=fail smtp.client-ip=40.107.236.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rDSKjfBISwAG5HiWy40EPoYz6zucwESPLViuUpp4/p5qGJ5YohR96D3nAVs4RnzNrm7DVtW7YFapq9yw2NPaVgKt1fbOeehBm/SJqMzcZJhYnrPMBaMD3kczHTMyr77Bwi9r1ooMNUIb6ANHvl5YxZ7efgkOp4v4rAtgnzLjLO/SQr+UsAJrcQFT6RFvM17tvL4dl60YKSNbmOdpXvKCvjW+RYniC9zUHCJRmwUicfywwzd3DnLeUSqBzVzDcs4wHfuWt1kUXHt8c4YcO9vL2KN+knRG3eXk0i83Ina+TVPC2TKJfdDMv7RqtxM0QVPF2muzCbbTofpTpbHQF7NyWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dsFXmHYlHuB2ycdd+I9Fe76f1TCN9F6PEyH18NKsfAE=;
 b=EGT0ky2LOwIExV/YXi4IiDKrGVya6vAPKu+AVGBhkZhfM0I0Ga3EKQn931madoqmJZU//yrOzfKDlEE21Mck+aO/ejaTt0oNUOrnq+5HpdOUIJDN6k3ZYgyfuRb3SLuF+VCabJp9koBHv9rvDpJqa6fPegPCAhYLP3ugG5ACkudQjRygqPxJX5rrCTvWUWmWZ9oJ4oWDvycVElIGWY2muWTTrdCVTFcWFXu0YGD/H1Z68GU0E3fO5UHf2UROZdKqNtFlGIdNC2D34HR/ZKWR02n59N/l3j0PBAwfGRcX/hI1zaJw/WQS1+R30rXIp5dhYw+wMwfHVBFL5VU/BsotTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsFXmHYlHuB2ycdd+I9Fe76f1TCN9F6PEyH18NKsfAE=;
 b=qCIjB8S+MJfeJMLi7LLYYJigYysoviTKN7h9qQqFV5XMoW5XT4dJJWToQimoMLRSs8K9whhtAUbzB7qHkyRsNNt7FEemV0w2MhaYOkrNIuNSHtrO8cmhYjngusyOSU9CEGqn45yNUmGHkDiL4dt3eJJvvHNWOG4mtSFtZKYmQNcpbHiztDwV27pIprorrGiDl786bKZkC4HDQ/4cUk8FAwp+6/Yoi/B4UnTv2j33kcSJJdvVMvBc6e0FkIqNPxEVGWjyASkbx2/KU+n4LnSESmjZ2KMgJGjuLA3T3Hqj0zWIDeqffsCmYzrPoZbzutS2IWppwvVBJiEKjghbx2ThfQ==
Received: from PH8PR11MB6609.namprd11.prod.outlook.com (2603:10b6:510:1cc::16)
 by SA1PR11MB8840.namprd11.prod.outlook.com (2603:10b6:806:469::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 10:33:43 +0000
Received: from PH8PR11MB6609.namprd11.prod.outlook.com
 ([fe80::ebc1:5d63:a07c:60d]) by PH8PR11MB6609.namprd11.prod.outlook.com
 ([fe80::ebc1:5d63:a07c:60d%3]) with mapi id 15.20.8511.015; Thu, 6 Mar 2025
 10:33:43 +0000
From: <Manikandan.M@microchip.com>
To: <mwalle@kernel.org>, <miquel.raynal@bootlin.com>
CC: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <tudor.ambarus@linaro.org>,
	<pratyush@kernel.org>, <richard@nod.at>, <vigneshr@ti.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
	<Varshini.Rajendran@microchip.com>
Subject: Re: [PATCH 1/2] mtd: spi-nor: sst: register SFDP region into NVMEM
 framework to read MAC Address
Thread-Topic: [PATCH 1/2] mtd: spi-nor: sst: register SFDP region into NVMEM
 framework to read MAC Address
Thread-Index: AQHbjbXbTNB5hzSu106BrFJRNUN76LNkVYiigAFUQYCAABEVgIAAMCwA
Date: Thu, 6 Mar 2025 10:33:42 +0000
Message-ID: <5a4cd44d-5833-4f75-b54f-75dca10d966e@microchip.com>
References: <20250305100134.1171124-1-manikandan.m@microchip.com>
 <87ikonydym.fsf@bootlin.com>
 <84b1def7-fba7-4f29-a49b-d117efe26d26@microchip.com>
 <D890I4EPARNO.O0VS9VZUL6IR@kernel.org>
In-Reply-To: <D890I4EPARNO.O0VS9VZUL6IR@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6609:EE_|SA1PR11MB8840:EE_
x-ms-office365-filtering-correlation-id: 2a695d5b-0939-4378-127a-08dd5c9a5e1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MmN4ZUswM1QvdTJtZkZOVm4wQ3lyNm1jTGRyVjhSMGluVGxtZ1hNUGgrUHgy?=
 =?utf-8?B?cXUrSkJaRlZXOXpDeWRUZEdmZmtaaUx5VFhGQUloRU9wYVIyajMzM01oUXBp?=
 =?utf-8?B?S2dFT05GclZGUTlvZkRQSmVOQ1lyRXZqZ1lNdHRXQzI0M3ZRLzNjZ1VDVUph?=
 =?utf-8?B?UWFzVXo1V3BUbEFyUnRsV05hTFBQU1gzWG1JUEpVUGdvRmdyN3p1UHZpN08v?=
 =?utf-8?B?Z0t4MTR4ZnczU1h4a09iYlhIZUJQZEU4a2lFcE55TUlDV2xRZEtrc3BET0NQ?=
 =?utf-8?B?ZnhPZjQ3MEtTRU9ycVVpUW4wRnEyTkxuanVmVzBKWE9wUUVCYkRBaFZOSEJI?=
 =?utf-8?B?Q0JnY0djWnRVdEdLcFo3SVkvcDNZM3VzRXdGRzdFRHpFL0llWTF6bENRckNG?=
 =?utf-8?B?RUtyMGFTQ0UxYXNxYjJVNmk1a0ZNZktHeDV3S2hubnFINEVlTTk2VkV5NGtC?=
 =?utf-8?B?dkRsMXZGMmxDbjd1RWx3WHFXM09jUDVocTJrcGVwTkJpOHF3TFBxVTFtRWxX?=
 =?utf-8?B?TW8ybG5lQ3FSdytDODk3a0xZU2I2UVNXMzB0UG1uYmZlbU5yNkg5OHZvbUlR?=
 =?utf-8?B?STlPUmViaW5UTEhxbE9PeUYwaHBtaG94aFRod3NUM210L3BvWDAydTRvRjJp?=
 =?utf-8?B?dWM5alFManYydDhxVUVlSk83UDBCVzF1S2hNdXBOSHZJM3hHVmV6cldBSnlJ?=
 =?utf-8?B?VlZ1ek9RN0JCeG9xMjN1ZGthVHcvcENYKzRDdTNKVnFNZ056MyswaW1ycTEy?=
 =?utf-8?B?QWZPdCtDZU5OdVZXWVJhZ2xYVUkwUHNhYi9iNmJ6MmN1ckMxNTYwUGRoVlRq?=
 =?utf-8?B?ODViS2pacnhKYzZMMFZxWGpLVE1ocHhXQTlUN0lwenQ3eDZhNnZxYmJLMXNF?=
 =?utf-8?B?YVpGYWhmVGpKNFUvaUpOdWl5M1gxcFZVdUU0RUcrTlM1OG5kNW5VRmhDOTMx?=
 =?utf-8?B?ZGV6M0dNQmFpUElDT3p0NEMycktmNVkxd0phOVFuL1lOQWcvQ1dZOVZ5bVgy?=
 =?utf-8?B?djNLdS9vbzg0eWZMKzZzTFB2VTlvdzk2VFd2TVlCNXVrZDRqR1Z0QVhVcnp3?=
 =?utf-8?B?eTNIeUxENHVZSFNWb29mWGlqblluWUE2aEN6aFZ6VFJuQUVLM1FacGt2RHY3?=
 =?utf-8?B?c0xjOFZmS3VRbzhDaUZVR2xYbXdteHNUTTFEWkxrdkpFRUZoVjhjSGJ4N3NH?=
 =?utf-8?B?YWNqWTBtVWZqemQ0SFAva1NKZVRyYkhNdFA0dDNNTlA0cjN2K3VHaXl3Wlh0?=
 =?utf-8?B?RG5aNEs1YUZ5LzlQdzE5Z29SdnFFNC9ZUHA4UE5zUGVkZFd5d1J5U2t3Z2x2?=
 =?utf-8?B?VDdOc0FORVlpUmlyZjNvWGZnRHEyZ0NQb3lVUDVleHVuQnAyd3RGRWtxdjlj?=
 =?utf-8?B?U0M3Q2ErZ3pWVkM2U2c2MUxwSXdvMjhCQTgraTg4Y2tMZytnc2w4cnA5NGhj?=
 =?utf-8?B?WnpacmtiblVNR1VaWERWVUs1Rlc0NmlXMDFJTXhGZzZNbHZxMnVPTWtvQ1hE?=
 =?utf-8?B?VnpZK0haTGY5NXN2TENZdjJvSExFY09ETzlsKzhBdTlia1Nmc2syNzJMYVBQ?=
 =?utf-8?B?Q3FONDVlVDRiMjZ2MkFiUWdseCtDcXhkeGppbi9IWEYxYjB6U21jcHBSd0dE?=
 =?utf-8?B?ZDdZV3IyT0FoUHdXVGE3SERtaFIrM3JyNm8zMkFVTzJpeFd0WGhNWnk1TWdi?=
 =?utf-8?B?WGhtdlZIcFVVU1JlSVZxT1k4M0lGTmpTb3ozS0F5ZlJWUUt0YWZmL09WYVlI?=
 =?utf-8?B?T0VnT2pCenhSZGlDN2N6Q0ZuVmtSSHM4YTV4djVySDhQTVppN1JvNGpBNDl0?=
 =?utf-8?B?L2R6a3Y5M283MHlwRWpQZHc3RU11SXJpYVhTUlUrZlNXS25kZnpHZTAwbVM4?=
 =?utf-8?B?dUFMQ3BValpjREExZUJnbE50ZDk0SlZsRUlMbTNwVXZLQ29xQ1dBQ3NMRUx0?=
 =?utf-8?Q?rB/I2ao6MwMvD4DqCeEHUSQX4Rsar1Is?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6609.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NXZhL2VIYUF4WGdDVlhVWWhlNXdEMkxzNXhvdXFDdjU4QlUyeWFZR055NHda?=
 =?utf-8?B?V1R0alBoSGdsSjExOTZJTW0yOTNJR0xtNVJKLy80TEQzaWluRnVuS2ZnZDM1?=
 =?utf-8?B?WkM1TWh0V0luNmZ0UUVKVjJhS0VVSlk2Qkowb0ZHMmZDd0JvdytVU3NQbWJO?=
 =?utf-8?B?YjJvcXRUdmJseWYvQ1RQQlRpL2ZhZFM2L2pFOGxPb09JZ1UwVzd4akNBbzhZ?=
 =?utf-8?B?RUV1V0g1RDdVY2JFQXMzNGVGbnd5VDdtV3ExQzltbk4wdlFxZmN5RkI2b2JH?=
 =?utf-8?B?b2xXRnZ4WHR1OGpoS0xHdTRoUXkybmZIUlVaMWlWY2NTY1N0WE96WDIyNlU0?=
 =?utf-8?B?T1dXb3I1VVBLbm1NSjdYTmplY3JtendQQlJiSVpIOWl6NVZTY2xKSlhtRE5k?=
 =?utf-8?B?emdCRUVBWjliT3hMcFFNZWNmUlozditwaGhCSG15Q1Q1WTZ0RnJqODlBcDlh?=
 =?utf-8?B?V1FKbTYydmFDNnkwV0xtdkhubDlDb3hvYUowSjVYaE5xQVgzYkhGb3Fndmls?=
 =?utf-8?B?TjNDblZBbFZrWlhLdUppY0JtbTNXcHdzOHNBemV0L09LSzdLZlNFdkhwTzN0?=
 =?utf-8?B?U1BHYVR1K2ExL2k1UlVNb25QTTIzeitWZDE5YVpNNXozZlQybFA3bkhBU0RB?=
 =?utf-8?B?OElsdHZRSngwenpsYjQ1R2U1UEgvUi9zU0E2dUNsTEw5YWhEdGw2QkFFRW9U?=
 =?utf-8?B?ZDZHQ1IyYVhuMFJHQTBSbmZrUUNqUzhiWWtreWRuVWVvbjM1NEF1N2dHT0Vm?=
 =?utf-8?B?WncvdDQ2REw0ZE1lTmRuT2ovOXVUSmxSU1JFY1pZN0M3Uk1PeDQ3QmVrai9y?=
 =?utf-8?B?Q0Q3eFZvblNjWmUyRmdmUG5FUi9vU2JrdHh6NC9qcmh6cW9JV0RDY1FHQ3R0?=
 =?utf-8?B?a09yV3MrK0o3anVsUU5wNkp5Mmhnd3Iwei9BTkVrRFRhY283d0lQYlRDaDFQ?=
 =?utf-8?B?MG1uY3ZwTGUxZ1gvN1N0U2pyUlhvUGl4eXMwbHRkdHhOQTBSQUt6S240MlhW?=
 =?utf-8?B?OVN0ZStMMnpMN21QdHJuY2h3ZGxkWFJITllVaXJTNldkcTE5YUlRRjJtRnBk?=
 =?utf-8?B?YUpRdE9rVmlaQS9FVTE2cm83N2lkSFFTNjFNVDdRaGxJYnM5MkJhekYzcGxP?=
 =?utf-8?B?a0k1ZEhQQ2g2SFl2YnBWaW5KRTRIU0Q4ZjAxV29KYnM0TUM3MmUvc2dVWVVR?=
 =?utf-8?B?NStmQUViUlROUXoyeE94b0x3anpKVGFpcEdGM0F1Z01IWkcvcFl1UVFocENR?=
 =?utf-8?B?b2FrVlNZU0ZGSnZBWHNsM0JFcE9SR2k5VmxOeGU5Z1pTRUxTdHpyYm9ScHVh?=
 =?utf-8?B?aFJzUE15cUpXelNNU1kvTUdtRC82TDdzLzh5b2hJQWhWWTY1UGxGbWR3RFFq?=
 =?utf-8?B?djJEbEhrLy91UDZQQ2syUHl0NzRoTXJuMThZUmpBTkRkUUI1ZWxOMDQraU5i?=
 =?utf-8?B?emFaUmlpWmxtSC9hbFFDWFhNYjhvU2xRZks1VjBWZmYrRVZBamlPY0N5dnc0?=
 =?utf-8?B?c3kyNXFWMGtSRFovdDNQcmhadkJUTWg2Y2hEcU9Eb3I0OThQanhXSjhNdVRK?=
 =?utf-8?B?U3hxc3krR3cvQjdYU3JrV3owSUs4WFNyUkFuQWpweDY0VzFiQ2s2SDAzZTBR?=
 =?utf-8?B?bkdSM0p4ZzZpRmF0RGE0R3hQSEIrTkR4MGR3YjU1TFVhcW8xc2NFOENXSTk3?=
 =?utf-8?B?NDB6RWhycEJuUUhwQWJxSDlFMHc1OXJ1cVUrV09qZFZDc3IwTnE5OXFMUHh3?=
 =?utf-8?B?aEZsUi9hTXVBTU8zZlpvZXdBZm16N0xEM21qNExKZEhsUXB2WU1lQ2F1am5a?=
 =?utf-8?B?dlduQTB0RER0QjhBWXFRRWs1cmovU1ZBcjhkdXRORnNRYzJVMTVvN2IyMUxN?=
 =?utf-8?B?U0hNZXBMc1JrekJDQkRVNWtNVlZLNmNJNnJ6M1VZc0Y2Sy9xbUJsUFFnclhD?=
 =?utf-8?B?TmxSUnRaYitzSGFZK3hMUmlQcWpITklYWXRSWkNpSi8wS1lvTGt3MnJZNmFF?=
 =?utf-8?B?WnQrSXluR3kvTEx2djBYOHBKVHdvazN6dHBYeHVBZi93NytKeFovRHhGZWJ4?=
 =?utf-8?B?TEQ1Tkk1UmdRb3NlRkZKVCtWWFJFdEc3WDFadHlmSk94VDhJTis0ZXh5M0Jh?=
 =?utf-8?Q?jeMQmeIukvQHKdHJoj5lg7mKs?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9DC1F2E49CD46B40A9CB0425A1C7E6C1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6609.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a695d5b-0939-4378-127a-08dd5c9a5e1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 10:33:42.9741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hJu1q+4Sk18we5Lyja3KAOTn+REEoXX776oCbutMpsKCLzz+XZx/avvAm05Y1KI6OWarp36uZma3xNBSil8yUsDW9DkmViBxivqzc6R1PdI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8840

T24gMDYvMDMvMjUgMToxMSBwbSwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBIaSwNCj4gDQo+Pj4+IEZyb206IFZhcnNoaW5p
IFJhamVuZHJhbiA8dmFyc2hpbmkucmFqZW5kcmFuQG1pY3JvY2hpcC5jb20+DQo+Pj4+DQo+Pj4+
IEVVSSBpZGVudGlmaWVyIGFuZCB0aGUgTUFDIEFkZHJlc3Mgb2YgdGhlIEV0aGVybmV0IEludGVy
ZmFjZSBpcyBzdG9yZWQNCj4+Pj4gYWZ0ZXIgdGhlIFNGRFAgdGFibGUgb2YgY29udGVudHMgc3Rh
cnRpbmcgYXQgYWRkcmVzcyAweDI2MCBpbiB0aGUNCj4+Pj4gUVNQSSBtZW1vcnkuDQo+Pj4+IFJl
Z2lzdGVyIHRoZSBlbnRpcmUgU0ZEUCByZWdpb24gcmVhZCBieSB0aGUgc3BpLW5vciAobm9yLT5z
ZmRwKSBpbnRvIHRoZQ0KPj4+PiBOVk1FTSBmcmFtZXdvcmsgYW5kIHJlYWQgdGhlIE1BQyBBZGRy
ZXNzIHdoZW4gcmVxdWVzdGVkIHVzaW5nIHRoZSBudm1lbQ0KPj4+PiBwcm9wZXJ0aWVzIGluIHRo
ZSBEVCBieSB0aGUgbmV0IGRyaXZlcnMuDQo+Pj4+DQo+Pj4+IEluIGtlcm5lbCB0aGUgRXRoZXJu
ZXQgTUFDIGFkZHJlc3MgcmVsaWVkIG9uIFUtQm9vdCBlbnYgdmFyaWFibGVzIG9yDQo+Pj4+IGdl
bmVyYXRlZCBhIHJhbmRvbSBhZGRyZXNzLCB3aGljaCBwb3NlZCBjaGFsbGVuZ2VzIGZvciBib2Fy
ZHMgd2l0aG91dA0KPj4+PiBvbi1ib2FyZCBFRVBST01zIG9yIHdpdGggbXVsdGlwbGUgRXRoZXJu
ZXQgcG9ydHMuDQo+Pj4+IFRoaXMgY2hhbmdlIGVuc3VyZXMgY29uc2lzdGVudCBhbmQgcmVsaWFi
bGUgTUFDIGFkZHJlc3MgcmV0cmlldmFsIGZyb20gUVNQSSwNCj4+Pj4gYmVuZWZpdGluZyBib2Fy
ZHMgbGlrZSB0aGUgc2FtYTVkMjkgY3VyaW9zaXR5IGFuZCBzYW05eDc1IGN1cmlvc2l0eS4NCj4+
Pg0KPj4+IERvIHlvdSBtZWFuIHNwaS1ub3IgaGF2ZSBhIHByb2dyYW1tYWJsZSBhcmVhIGluIHRo
ZWlyIFNGRFAgdGFibGU/IElzbid0DQo+Pj4gdGhpcyBzdXBwb3NlZCB0byBiZSBhIHJlYWQtb25s
eSBhcmVhIHdyaXR0ZW4gb25jZSBpbiBmYWN0b3J5Pw0KPj4+DQo+PiBUaGUgU1NUMjZWRjA2NEJF
VUkgc2VyaWFsIHF1YWQgZmxhc2ggbWVtb3J5IGlzIHByb2dyYW1tZWQgYXQgdGhlIGZhY3RvcnkN
Cj4+IHdpdGggYSBnbG9iYWxseSB1bmlxdWUgYWRkcmVzcyBzdG9yZWQgaW4gdGhlIFNGRFAgdmVu
ZG9yDQo+PiBwYXJhbWV0ZXIgdGFibGUgYW5kIGl0IGlzIHBlcm1hbmVudGx5IHdyaXRlLXByb3Rl
Y3RlZC4NCj4gDQo+IFdoeSBkaWRuJ3QgeW91IG1lbnRpb24gdGhhdCB0aGlzIGlzIGEgdmVuZG9y
IHRhYmxlIGluIHRoZSBjb21taXQNCj4gbWVzc2FnZT8NCj4gDQo+IEFueXdheSwgcGxlYXNlIHdy
aXRlIHByb3BlciBzdXBwb3J0IGluIHRoZSBjb3JlIGZvciBwYXJzaW5nIHZlbmRvcg0KPiB0YWJs
ZXMgYW5kIGV4cG9zaW5nIHRoZW0gYXMgYSBudm1lbSBkZXZpY2UgaWYgbmVlZGVkIChhbmQgYXNr
ZWQgdG8NCj4gZG8gc28gYnkgdGhlIGRyaXZlciBvZiBjb3Vyc2UpLg0KPiANCg0KVGhhbmsgeW91
IGZvciB5b3VyIGZlZWRiYWNrLCBhbmQgbXkgYXBvbG9naWVzIGZvciBub3QgbWVudGlvbmluZyB0
aGF0IGluIA0KdGhlIGNvbW1pdCBtZXNzYWdlLiBJIHdpbGwgZW5zdXJlIHRoYXQgdmVuZG9yIHRh
YmxlIHBhcnNpbmcgaXMgc3VwcG9ydGVkIA0KaW4gdGhlIGNvcmUgZHJpdmVyIGdvaW5nIGZvcndh
cmQgdG8gYWNjZXNzIHRoZSBNQUMgaW5mb3JtYXRpb24uDQoNClRvIGFkZHJlc3MgdGhlIENhZGVu
Y2UgTUFDIGRyaXZlcidzIHJlbGlhbmNlIG9uIFUtQm9vdCBlbnZpcm9ubWVudCANCnZhcmlhYmxl
cywgTlZNRU0gZGV2aWNlcywgb3IgcmFuZG9tIGFkZHJlc3MgZ2VuZXJhdGlvbiBpZiBmaXJzdCAy
IGZhaWxzIA0KLCBJIGJlbGlldmUgZXhwb3NpbmcgdGhlIE1BQyBhZGRyZXNzIHZpYSBOVk1FTSBp
biB0aGUgRGV2aWNlIFRyZWUgaXMgdGhlIA0Kb25seSB2aWFibGUgc29sdXRpb24uIFNpbmNlIFNG
RFAgZGF0YSBjYW5ub3QgYmUgZmV0Y2hlZCBhZnRlciB0aGUgcHJvYmUgDQp0aW1lLCB0aGlzIGFw
cHJvYWNoIGVuc3VyZXMgcmVsaWFibGUgTUFDIGFkZHJlc3MgcmV0cmlldmFsLg0KDQo+IC1taWNo
YWVsDQoNCi0tIA0KVGhhbmtzIGFuZCBSZWdhcmRzLA0KTWFuaWthbmRhbiBNLg0KDQo=

