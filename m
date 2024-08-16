Return-Path: <linux-kernel+bounces-289594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 832CE9547EC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A76E21C23CB0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA8A194124;
	Fri, 16 Aug 2024 11:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="jWsFACDA"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2082.outbound.protection.outlook.com [40.107.117.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032D0817;
	Fri, 16 Aug 2024 11:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723807291; cv=fail; b=Q1bw13w/IbrJC4Jg8S5UprGDzSw2xL8gYl1mfqvrTC9tmx7gczZhBkYzCW8zBCHMbaOxCNI6thUfo0vo0NyIo3syP7UUBuvOna54nSdVWZA2Y9OxM2JwSwnEuB3SnrFMIOoZPsCOw0c+rOrhOQB0S+lHq8f6waihff6q/oWe+JU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723807291; c=relaxed/simple;
	bh=UF+EA2RZhVgZSgg9buAA7/TSmF28FqAp8yHNXI+1EOo=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MDG0P8xwndeleWjyWWnouofNcqVJuVz7T9U95c0p7wHLg6mKmQF9ne2cRn26Tv3LH5PZpjbssVLG7K8haotZ0yCXnMqAY46WlgtXYtR79k71PZp+4x4ADP1F+UwD2YZjboTOftpMSi886eRrcrrBKkIw9ETjFnSWjJAjeLtSAJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=jWsFACDA; arc=fail smtp.client-ip=40.107.117.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s5iyjdPRH/RTTmUoDJaFoueJkImFJcIrVc1sqnuSd01Ww0agZobmeYc96NzOWSaD2OZoxsnGf+NGYTuKjtSh8RKtWoGj4p+l4JerD0qBgfGW+tfbvGRQRrMM/NoNp7ZXRJzYmrTd2vwlKPuwCAd7bYH2VP6j5GVsigUafZAv46S+0e6gf9FB4u1LSOdRX29Du49QK1GPkeZgQ/1MATtUEisRohTsdcnl6FLSFF0GrY0hCecvHmFip0epaKw0AaQbTGofVV1msyX6GbRcoxiEjXX6QZ0/28v+tNVMGCEI+1P2JqoxD3hdskM/w0LmQQoo2r8SXAzghhRx8CaoHY507Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UF+EA2RZhVgZSgg9buAA7/TSmF28FqAp8yHNXI+1EOo=;
 b=UTVoXHNe/aw/o5+iIT/GGkiEgtpp9o/0G3BqEDOxfRmevvPvL+cDQZE9GWAb1eoRGuCZXc5eVOVNsru80XSbtRj4TwKzu4PfXvvaDvf/F5xfuVP7Sk/QhDbrcVYq1s98SoGcgQz7wkcCr4ERJY3iEWBWwfJKPePKB7QEfUknHrIjVFmIiEEGx3Hv3XpzZoGxJvCiMrwsEclS86aGQlXXUN1zNs05fz9fDHYkJXZSLkqUfaSGuftxfGfxOnR9l34psTviT4BFFm+dbhuBNglY/5EwCIdeIL1J/oZ0ybY/u05BcaTuz3QLOC7wMfP1Jquh0MSOi9prIITva381Pa6Jww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UF+EA2RZhVgZSgg9buAA7/TSmF28FqAp8yHNXI+1EOo=;
 b=jWsFACDAv5bRRfRNhop8d0m7QknHDRtE4fdVbh62kqzsT2h2qXrwLC3+k8/JGfLuqbfHK3P/W4zpHC39IUOJVyb8RE1jscA5AlXbbxoUS6rnPmKuEARvLCoelUM6VdKMzFGPp5an5bgifj/48wu9o0uJtbUlgDcaMPduR4zLDRVWLwroITRi2u6QF4AY2KXZyRTo3xf+IuGRCQjuydH2ObSetxzqKecHxvw3LZ+dUBK1PlAC+lJzKXs5GZINngPBKWNcjVOKWSvqAhH04br3uUgK5KlXG+9Xg2HKH78/j1lVcVy7eqw/qINGnnGH7ausXTjjffKnTA6+O53EnqRngQ==
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com (2603:1096:400:358::7)
 by PUZPR06MB5981.apcprd06.prod.outlook.com (2603:1096:301:115::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Fri, 16 Aug
 2024 11:21:24 +0000
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe]) by TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe%4]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 11:21:24 +0000
From: =?gb2312?B?uvrBrMfa?= <hulianqin@vivo.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"quic_prashk@quicinc.com" <quic_prashk@quicinc.com>,
	"quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: opensource.kernel <opensource.kernel@vivo.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: [PATCH v1] usb: gadget: u_serial: check Null pointer in EP callback
Thread-Topic: [PATCH v1] usb: gadget: u_serial: check Null pointer in EP
 callback
Thread-Index: AdrvzihtFNSOcxRwTAOIHI6tveAOMA==
Date: Fri, 16 Aug 2024 11:21:24 +0000
Message-ID:
 <TYUPR06MB62177737F0054278B489962BD2812@TYUPR06MB6217.apcprd06.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR06MB6217:EE_|PUZPR06MB5981:EE_
x-ms-office365-filtering-correlation-id: 91712cd2-9b0e-47c4-4cdb-08dcbde59016
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?alc4VUg1d0tIL3BzaFVmZ2JReHBObnBuQ2V3UlIyRzFpVjdzMVM2a0ZaWkIz?=
 =?gb2312?B?RTJWY010QVA4NWVQNHVGbW9PbGhrOE41TklSTzE0QTlIQXZXejVzLzA5TUJJ?=
 =?gb2312?B?QVMxeGRYbVR6S1hBWjM2QTNFUW4yMUdaVndYeEZjZzFuRXJkSzF3SmRtNmtn?=
 =?gb2312?B?SVlreWFxVTlDNjBEUmM5QTFwWi96andZZGFGRHJ1aEpWb0VPMnFoZC9tKzVW?=
 =?gb2312?B?anplbVpXaVpZYmZ5V2x2eE5acXppeTh1aEFDVndmSmhrdE9qYXhwK1VURjFJ?=
 =?gb2312?B?b2doTHJmK1c0ZU9aLzdWbXRlcUs1V0RYdmR2NkU1NWY5VDN2cjhLaFQzeS85?=
 =?gb2312?B?bWFlNUdvQkZlQ3dWbmNjZjMrZUNMd3JsblczWnp3aSsvdHJZWjQwUkRxeDcv?=
 =?gb2312?B?MmFITUJUOVBUdzVKejdma0ZvSTlMZUZvbUJOVlFHMURuc1hFaHEyQTMwWTRi?=
 =?gb2312?B?WDZQMW1CUlpqS1REQUtwVm80K2V4V2VJQ2xudE5paDRicjJmWTBWTDdha2hF?=
 =?gb2312?B?cGpsZ0hHSDhtWVBvdmdlTWRQQUZwem5ibUZINzNJRWVLV2l4M1MwSGJ0Zk1D?=
 =?gb2312?B?Rm00cnUrMlFuZDVxRmxCWk5ja3lUVFJWbWxNWFNaNThzNTh4UXlwUi9IdFp5?=
 =?gb2312?B?U1NwS2hISGFmaFJTZHpQL0g3Q2pFeFNFcmw3QzVQZHg5NTg3Tk5zdnp3YjRI?=
 =?gb2312?B?dHZOdXhrYTV3dWdyZzNLcUhlcVhJVHhQWDFQUy8vZ0J0RzJxVnhIcFYzSU1W?=
 =?gb2312?B?dUJVbEU3N0ZKQUNGOGZpOU9oUC84aktndTIxc21Kc1ZkN0tUOWNZRDQ2ZVNh?=
 =?gb2312?B?UDdUT1EzdWwycnBJRURnL3FQbktZd3FBRk9Hd20vbExoSytNY2dPd2w3ZlUw?=
 =?gb2312?B?dVQ0QVBxbVl2VkpYdERJem5EZ3Z3WlI4UGlEZHFoTXlPOXRFRXo3OTQyVEo4?=
 =?gb2312?B?ZVBLZ0VHRlU3SGtmcFJscjNHdzh0OWdVZWFmN2syVnVZblhmUXlpb2J6dy80?=
 =?gb2312?B?Z3ptcGlvNUhNWFFFVE9jbGZweTkxS1VjcExxNmxKWnZHRHM3NEhHSUJ4Y3dB?=
 =?gb2312?B?V0VqelRsMUF6MnFtT0xHb2ZreW12T0d2Sy9JMUxmekIrbkY4ejNCdExSNThx?=
 =?gb2312?B?ak1FRGRkZWJuaTY5UzFUZlpZQ1ZpQmNERW9VR1U4YWRYT0d5MVVSRWw2eVhO?=
 =?gb2312?B?NEtpNXJaTndRazg3cEQ3NWowQk52VFZhRHd3aVFQalNPc3E0S1QvYStGTWcr?=
 =?gb2312?B?R29rTUV5SDJQTVRMK1pzNE1WUzNzblppTzVkWmtaUnlQRGNteGNGL2hlbDZH?=
 =?gb2312?B?TUJJMzUwKzRVQ1FoK1RPTEROWVJ2ZExzOUpia0NialJyditTMXVvbEtCUmRx?=
 =?gb2312?B?SzRMTmRDUTExdjFlMXkwZTdWa3B5TGdHVkZ0ZlE3QjlaZ3UrOFU0d3dBclR4?=
 =?gb2312?B?azJVODlOUTRJTHN4bDRTNXI3K2M3V2ptaTVHUVNIc2tzby81V1R0bXp2Ny82?=
 =?gb2312?B?RTl3M2VvYkprVGg5ajFSeFNtQ0dKTWdQY21lU2trM2M1TDJ5d3FsRFB2YTRN?=
 =?gb2312?B?MDBPcmp3THQ1M3ZCNUFoS00wQU5reVVTZmRWYjFPZXUyc0hxT3I5U2g2dm5F?=
 =?gb2312?B?M2NLYnhRcmtyemhQZm1rY2k5Q1FiaVpCcnp6QlhQNTR0Yzd6VFRXS2E1WUhB?=
 =?gb2312?B?VEhGVmg4U0k5VW01TytZcHQyeE81bVFrK2dRSFpDZGJ1V0xTV1JSVWY5REY3?=
 =?gb2312?B?SUo3OGlSYVNXclByYVNSZTJuc2VVaC9xbWpnRXZBV3VzVWd3MjI1aXhiZmw3?=
 =?gb2312?B?MFp3UEx0cjJ0T0tPSCtjWE5qQ1ZVK04wakhpTXQ5NXdScjRLaWdlQkJFdHYv?=
 =?gb2312?B?Vk9Ya1dIMVhHZHJ4ZkRtR01aWjdmbmNLRlVXblBtak5MVGc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR06MB6217.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?MWx6elFENFVoZGlOT3JkUnVlZm0zMTJaT1RsWExIVVU0cGpsejhnclcyT1Vs?=
 =?gb2312?B?R25lekhsOGwyNU5jcU9RK25lSVlZc3lZckVQbTRLbW42akRYYndqU1JKNmRy?=
 =?gb2312?B?SFIxcytVUWx2YzRqNlh3RC9UQnl2NlRadEpWVVFuYm5zL29ISC9LcytmbmdP?=
 =?gb2312?B?S2tkeGRXNU1XYVU0MG5yb0hCNTEvL2Q2S3FsUlB5MnVpZHVpbFNGcVQ3QU9y?=
 =?gb2312?B?eGc2TktNdXpCWVBTVnpNemdRaVNEWTFBVTZYN0lUYTJHK2psZHRNZVgvcnMv?=
 =?gb2312?B?endyTmpVUkt4ZkJya1VuOW9zZmF6ZlloeUhtMWdtLzJldDRIcGxzOUpOVnh2?=
 =?gb2312?B?aUYzYjAyUVc4MkQ2cVRma0dGb0RiUTdIbWdyU2t3dEUydGtIeTQ5NDR5OHgw?=
 =?gb2312?B?UXRPNXZtK0x1MWZ5c0hoekR6Q2xaQk9ENFV3UTdXSEUzR1pwS1BrWGJxNkRG?=
 =?gb2312?B?UEVXdWE1WjNrbVNVMjFuQzV3cjlJRXA1MDRsU3RGZ2gvais3eDZCaFZUbGRI?=
 =?gb2312?B?d1BMZDFBcVFORzFyRHNwVlc0azU1bDc0YzNQSjNJWk9ERjlzbm9IdWwxaXB5?=
 =?gb2312?B?NGhuWXRhUDVLMmUycDh3VWNWbjhmVjdCT1dISWRSclN3WGhMUTE5a0N3OWh4?=
 =?gb2312?B?NDR2OE9PRWgwUWFCTkdDQUlqQlZwWjEwdGtWQWx0eGVkQTJIV2htZEZ2WlFK?=
 =?gb2312?B?OEZTdysxMENWMkJWZ2NDZ2orbmNPUGxCSnIwMS9LZzZqeUd3Z0x2TXZwcC9G?=
 =?gb2312?B?Ukk4cVdkaDdYenhMNDZUZXBmeS9JMVJNMUovUmYxNHg0Mm0rKzR5VnRldGhk?=
 =?gb2312?B?U1Q0bklCU1ZqaWFyNDlFeWUwWFczaW5WZDE0Qld4RkJ2TnRLMEVZR0lyRk8r?=
 =?gb2312?B?UXNCMWxGY1ZoMGVRUlkxV0lERlR5ME9odXRNaXpYTzFtWHk1eTNqQ0RYOGVy?=
 =?gb2312?B?bFozSDJiLzJFcWtDS1RoSlBqOGM3VGRwelRYcVE5WXJYaGJIcDY1bDRrT0k0?=
 =?gb2312?B?c1k0SUlpcHdhOVpyNjFZV2VvQnU1TzNYU1d4L3hRUjNrMEEyeUoxM3pzaitF?=
 =?gb2312?B?SHJGK0lvN1BXb3gzRWdNUUdZckJkYUFoZmlYZDBudXJ3ODVvLzJPSjNBSWw4?=
 =?gb2312?B?bkx1bDM0aENnMVlLYjRuKzlQcGZhb1lXMDdxZ2tCNW4yNHBHdUtmR3psazlQ?=
 =?gb2312?B?RFZpUGJaQ0NzWnNVMHNSZ21aUjBtU1o1eGlmT3RpQS9CZDlxM1krd3dueEpO?=
 =?gb2312?B?UkVWeGdoQlczaXc3eG1vU3VwKzduZEc4NzJCSFU5Vm5PbldTY3h2Z0s2WVZ4?=
 =?gb2312?B?ZXg2NzZFSWY0RWsvRHRHOGtUdEx3L09yMXJLMWFzWnF4T2c3S0RXZ2lFRzVr?=
 =?gb2312?B?cm9oZnhOcUNVeTBYWk1kV2VaT2s1MWxIYU90aFN1SmNGNkFnaVdRNER6ZjFp?=
 =?gb2312?B?Sk5ZY1FKRkhuSVBQc2lqZVB1WWROR21OSERSc2VmQ3RTUmZKajhBanJTL1lu?=
 =?gb2312?B?YlkrWUVWT2YxbWJoakdpZ3VhMDlOR3JRcTZjOVRSWmRXcUVyeFYxUWxNNTMx?=
 =?gb2312?B?emNUZjNKbmtacnpkUzRiTlpZa2owRGNVc3JXMWlNSW8zcEQ0aEtnSytlcURV?=
 =?gb2312?B?c2tZaVhlMWxxMVFhZmRsSG9NZSsrQTluMnhydWVxRFA4dEw0WkVsYjlOaUdO?=
 =?gb2312?B?T2Nzd21oVi9tNTlPMUdIVnRWbUdIVU53aThrRjVBWlRpazVLdm1ZYTdtZ1Qv?=
 =?gb2312?B?V05pb2V4bmJaTndvams1ZjExbkhOOVlLU1hQaWhiQmlqU24venUrblNCQWd5?=
 =?gb2312?B?dXZIMFRZemF0SWEzdkdDWE5OU3FoQmp1T0YxZ1p5T3NtZDdHVDdtcFNBODNt?=
 =?gb2312?B?VG5sN1RhNTNQY1FRSWliQUZBUHRMYnhMT2NwTkdSQU5IRzhlY0JaK2tSZ2dK?=
 =?gb2312?B?QzQ5dnBtL0FsdzMzYm9kaHoyUUNnOU4vM2N3T3pZVXFCVDJBZHFHZm96VXRM?=
 =?gb2312?B?SXJ6OXJyL3Mxc0NyNGtuR1kvR0tnT092T09kS2dmbEg0WS9DbERVbUlhY0V1?=
 =?gb2312?B?TUtDbGlYTnV1cno0dUZKTHdiT1JCNDFUcGEyWU04Mkx3MUV0bnR3Mml5Z0ZQ?=
 =?gb2312?Q?OHu4=3D?=
Content-Type: text/plain; charset="gb2312"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 91712cd2-9b0e-47c4-4cdb-08dcbde59016
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2024 11:21:24.2250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XQbJpkyTp38ryCbrbgJSco1aOlWhpBcdosnvCy30mMD9MMXYzsFexUOMG7fMf/AwES5x6ogerrzjS5S5uevbyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5981

RnJvbTogTGlhbnFpbiBIdSA8aHVsaWFucWluQHZpdm8uY29tPg0KDQpBZGRlZCBudWxsIHBvaW50
ZXIgY2hlY2sgdG8gYXZvaWQgc3lzdGVtIGNyYXNoLg0KDQpVbmFibGUgdG8gaGFuZGxlIGtlcm5l
bCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgYXQNCnZpcnR1YWwgYWRkcmVzcyAwMDAwMDAwMDAw
MDAwMWE4DQpwYyA6IGdzX3JlYWRfY29tcGxldGUrMHg1OC8weDI0MA0KbHIgOiB1c2JfZ2FkZ2V0
X2dpdmViYWNrX3JlcXVlc3QrMHg0MC8weDE2MA0Kc3AgOiBmZmZmZmZjMDBmMTUzOWMwDQp4Mjk6
IGZmZmZmZmMwMGYxNTM5YzAgeDI4OiBmZmZmZmY4MDAyYTMwMDAwIHgyNzogMDAwMDAwMDAwMDAw
MDAwMA0KeDI2OiBmZmZmZmY4MDAyYTMwMDAwIHgyNTogMDAwMDAwMDAwMDAwMDAwMCB4MjQ6IGZm
ZmZmZjgwMDJhMzAwMDANCngyMzogZmZmZmZmODAwMmZmOWE3MCB4MjI6IGZmZmZmZjg5OGU3YTdi
MDAgeDIxOiBmZmZmZmY4MDNjOWFmOWQ4DQp4MjA6IGZmZmZmZjg5OGU3YTdiMDAgeDE5OiAwMDAw
MDAwMDAwMDAwMWE4IHgxODogZmZmZmZmYzAwOTlmZDA5OA0KeDE3OiAwMDAwMDAwMDAwMDAxMDAw
IHgxNjogMDAwMDAwMDA4MDAwMDAwMCB4MTU6IDAwMDAwMDBhYzEyMDAwMDANCngxNDogMDAwMDAw
MDAwMDAwMDAwMyB4MTM6IDAwMDAwMDAwMDAwMGQ1ZTggeDEyOiAwMDAwMDAwMzU1YzMxNGFjDQp4
MTE6IDAwMDAwMDAwMDAwMDAwMTUgeDEwOiAwMDAwMDAwMDAwMDAwMDEyIHg5IDogMDAwMDAwMDAw
MDAwMDAwOA0KeDggOiAwMDAwMDAwMDAwMDAwMDAwIHg3IDogMDAwMDAwMDAwMDAwMDAwMCB4NiA6
IGZmZmZmZjg4N2NkMTIwMDANCng1IDogMDAwMDAwMDAwMDAwMDAwMiB4NCA6IGZmZmZmZmMwMGY5
YjA3ZjAgeDMgOiBmZmZmZmZjMDBmMTUzOGQwDQp4MiA6IDAwMDAwMDAwMDAwMDAwMDEgeDEgOiAw
MDAwMDAwMDAwMDAwMDAwIHgwIDogMDAwMDAwMDAwMDAwMDFhOA0KQ2FsbCB0cmFjZToNCmdzX3Jl
YWRfY29tcGxldGUrMHg1OC8weDI0MA0KdXNiX2dhZGdldF9naXZlYmFja19yZXF1ZXN0KzB4NDAv
MHgxNjANCmR3YzNfcmVtb3ZlX3JlcXVlc3RzKzB4MTcwLzB4NDg0DQpkd2MzX2VwMF9vdXRfc3Rh
cnQrMHhiMC8weDFkNA0KX19kd2MzX2dhZGdldF9zdGFydCsweDI1Yy8weDcyMA0Ka3JldHByb2Jl
X3RyYW1wb2xpbmUuY2ZpX2p0KzB4MC8weDgNCmtyZXRwcm9iZV90cmFtcG9saW5lLmNmaV9qdCsw
eDAvMHg4DQp1ZGNfYmluZF90b19kcml2ZXIrMHgxZDgvMHgzMDANCnVzYl9nYWRnZXRfcHJvYmVf
ZHJpdmVyKzB4YTgvMHgxZGMNCmdhZGdldF9kZXZfZGVzY19VRENfc3RvcmUrMHgxM2MvMHgxODgN
CmNvbmZpZ2ZzX3dyaXRlX2l0ZXIrMHgxNjAvMHgxZjQNCnZmc193cml0ZSsweDJkMC8weDQwYw0K
a3N5c193cml0ZSsweDdjLzB4ZjANCl9fYXJtNjRfc3lzX3dyaXRlKzB4MjAvMHgzMA0KaW52b2tl
X3N5c2NhbGwrMHg2MC8weDE1MA0KZWwwX3N2Y19jb21tb24rMHg4Yy8weGY4DQpkb19lbDBfc3Zj
KzB4MjgvMHhhMA0KZWwwX3N2YysweDI0LzB4ODQNCmVsMHRfNjRfc3luY19oYW5kbGVyKzB4ODgv
MHhlYw0KZWwwdF82NF9zeW5jKzB4MWI0LzB4MWI4DQpDb2RlOiBhYTFmMDNlMSBhYTEzMDNlMCA1
MjgwMDAyMiAyYTAxMDNlOCAoODhlODdlNjIpDQotLS1bIGVuZCB0cmFjZSA5Mzg4NDczMjdhNzM5
MTcyIF0tLS0NCktlcm5lbCBwYW5pYyAtIG5vdCBzeW5jaW5nOiBPb3BzOiBGYXRhbCBleGNlcHRp
b24NCg0KU2lnbmVkLW9mZi1ieTogTGlhbnFpbiBIdSA8aHVsaWFucWluQHZpdm8uY29tPg0KLS0t
DQp2MToNCiAgLSBPcHRpbWl6ZSBjb2RlIGNvbW1lbnRzLCBkZWxldGUgbG9nIHByaW50aW5nDQot
LS0NCiBkcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vdV9zZXJpYWwuYyB8IDE2ICsrKysrKysr
KysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0
IGEvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL3Vfc2VyaWFsLmMgYi9kcml2ZXJzL3VzYi9n
YWRnZXQvZnVuY3Rpb24vdV9zZXJpYWwuYw0KaW5kZXggYjM5NDEwNWU1NWQ2Li42NTYzN2Q1M2Jm
MDINCi0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91X3NlcmlhbC5jDQorKysgYi9k
cml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vdV9zZXJpYWwuYw0KQEAgLTQ1NCw2ICs0NTQsMTQg
QEAgc3RhdGljIHZvaWQgZ3NfcmVhZF9jb21wbGV0ZShzdHJ1Y3QgdXNiX2VwICplcCwgc3RydWN0
IHVzYl9yZXF1ZXN0ICpyZXEpDQogew0KIAlzdHJ1Y3QgZ3NfcG9ydAkqcG9ydCA9IGVwLT5kcml2
ZXJfZGF0YTsNCiANCisJLyogV2hlbiBwb3J0IGlzIE5VTEwsIHJldHVybiB0byBhdm9pZCBwYW5p
Yy4gKi8NCisJaWYgKCFwb3J0KQ0KKwkJcmV0dXJuOw0KKw0KIAkvKiBRdWV1ZSBhbGwgcmVjZWl2
ZWQgZGF0YSB1bnRpbCB0aGUgdHR5IGxheWVyIGlzIHJlYWR5IGZvciBpdC4gKi8NCiAJc3Bpbl9s
b2NrKCZwb3J0LT5wb3J0X2xvY2spOw0KIAlsaXN0X2FkZF90YWlsKCZyZXEtPmxpc3QsICZwb3J0
LT5yZWFkX3F1ZXVlKTsNCkBAIC00NjUsNiArNDczLDE0IEBAIHN0YXRpYyB2b2lkIGdzX3dyaXRl
X2NvbXBsZXRlKHN0cnVjdCB1c2JfZXAgKmVwLCBzdHJ1Y3QgdXNiX3JlcXVlc3QgKnJlcSkNCiB7
DQogCXN0cnVjdCBnc19wb3J0CSpwb3J0ID0gZXAtPmRyaXZlcl9kYXRhOw0KIA0KKyAgIC8qIFdo
ZW4gcG9ydCBpcyBOVUxMLCByZXR1cm4gdG8gYXZvaWQgcGFuaWMuICovDQorCWlmICghcG9ydCkN
CisJCXJldHVybjsNCisNCiAJc3Bpbl9sb2NrKCZwb3J0LT5wb3J0X2xvY2spOw0KIAlsaXN0X2Fk
ZCgmcmVxLT5saXN0LCAmcG9ydC0+d3JpdGVfcG9vbCk7DQogCXBvcnQtPndyaXRlX3N0YXJ0ZWQt
LTsNCi0tIA0KMi4zOS4wDQoNCg==

