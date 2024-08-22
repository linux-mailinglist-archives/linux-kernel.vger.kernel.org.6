Return-Path: <linux-kernel+bounces-296431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 281A995AAF7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 04:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CBD2B21E93
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 02:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B21018EB1;
	Thu, 22 Aug 2024 02:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="VjiuW2U2"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2073.outbound.protection.outlook.com [40.107.215.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A7D12B72;
	Thu, 22 Aug 2024 02:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724294061; cv=fail; b=YwQjms/MxyoLh4FmOVPreWgcLfUHkQfHLyxHnSB5ISVFme7rnC3z75lPwRemz2fltCyYqxxKDK4rPVjn6I/Y6mk/5fYDDAsIdUj/mEmFANLSDRN72ke+CSs65/D8wpxNaDST9/IcwaUEPDB3E1CLkftbxfFl1xJugtStvapOlIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724294061; c=relaxed/simple;
	bh=ix6XmUsMVsr5USt/UfxHmLcNsPUfXvAH8/BC6gxdleI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=n2Nf7lqgtFi2DKWE27gGqsXsrX7FzjbjeUMKC7VfEWzyXs+8FtD3U7dVow7MrRjBBgAWvmj768O9vdg+nHzBmp7TMCgNQY+BjB16p2BbZk0VY+XI2sdxQdqk5tyo/7wEa0SyHx1n4nL1nXEmXNP293ZRxr0AJuNjj2wmPfxVDnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=VjiuW2U2; arc=fail smtp.client-ip=40.107.215.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=huV3uXe79OP8L7YcMHrX6AbiPrdcYFkCE6j5Y4uRW1TN+SHQI4Ud7QP/339AjxJmX13H31df4Vsp5N4fpfaUVQ4XidnU29q0/irfL5dgn8/duSbbSoua9eq6h/QoMpq5O+wYhd7EvAt8cQJ1/ulluahzFOYW0nOB2U3GsQqs471rCnw5QuLMTkWUhfLeu938iov9+eGsmTfYjZSl8LW7GjwV8XRqlngfNV1S+VuaGibCjaX/0bMQ7UakFuxoxzoL7hUPG5m41Ebf32DFV19k2oo8JXYqKRB7Tzo1rgtDnYHfDt/EsF84TsE1kvtEfunlbuA4RVCSfAPbSZBZUo/V+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ix6XmUsMVsr5USt/UfxHmLcNsPUfXvAH8/BC6gxdleI=;
 b=K5zG3ZN8g8bTBNohtIQRR4vRfs8+cJOfee9sS6zcpV1AcLvFOwX/tCF8wicR6OanWP/E9hz819CVc9hvnzpEL5CiMy8oOhVgMhFBK5OfFgbV4UW44i3AiJ9G8263epqcFJMPyKRbqxfDQlLnCIWl2Yg5zWSdTgC5wynfBYIWKVnzsEndOLV82Qv4DHZQIGnzteoL+7KqWzFWfBCDNc4Pqx9l5pKEL2oTe7seaZc/HPJPn+Tvu+GUzf7jS2GQixb1FKJweT9iIIEvVcaHwe32U3CfMlV31uwoPtTDK+IlTo9UPIk1/IAOUGiR/lwIvNVRZOVK5onHC6ylNIWrNZW5Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ix6XmUsMVsr5USt/UfxHmLcNsPUfXvAH8/BC6gxdleI=;
 b=VjiuW2U2+AJ/kNdQPvv4U+pJlDg/r4AlLM2YYcmkbg6X5jNaIn/9qIFI0hjoM1OTyZRT/3Mjym0a50CUDOma8WpVHvt2FZl8gUT2zyILdKlvy8bMB7JTdeYatSn3d+DMO+HpfpdTved+34wurpomrSDWEOEnQdYW4k/YIgaqvQ/xzhl3mRR3zqXIzuTDWD7FDCkC9d+I6ELGLDo6W8kYjwF7/J7pfrhw0z/tXtUV+k8oFYlq9BETFgESiiYti53pP4HlufTkaMpbRYba3g61rga0qemHylCbaGYCS/06ye53tYz4dwsNl1PjMRre7AjtAjDZl7JlDP4GvisIgmPVEg==
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com (2603:1096:400:358::7)
 by SEZPR06MB5413.apcprd06.prod.outlook.com (2603:1096:101:64::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Thu, 22 Aug
 2024 02:34:12 +0000
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe]) by TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe%4]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 02:34:11 +0000
From: =?gb2312?B?uvrBrMfa?= <hulianqin@vivo.com>
To: Prashanth K <quic_prashk@quicinc.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>
CC: "quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	opensource.kernel <opensource.kernel@vivo.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, Michael Nazzareno Trimarchi
	<michael@amarulasolutions.com>
Subject: [PATCH v6] usb: gadget: u_serial: Add null pointer check in
 gs_read_complete & gs_write_complete
Thread-Topic: [PATCH v6] usb: gadget: u_serial: Add null pointer check in
 gs_read_complete & gs_write_complete
Thread-Index: Adr0Om++URnaGaVeQfyA+J7u99KqHg==
Date: Thu, 22 Aug 2024 02:34:11 +0000
Message-ID:
 <TYUPR06MB62171A7BF25AB6963CBA07FED28F2@TYUPR06MB6217.apcprd06.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR06MB6217:EE_|SEZPR06MB5413:EE_
x-ms-office365-filtering-correlation-id: 39f0f55b-f427-4f62-3771-08dcc252e834
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?cVYxSEY1enZjWTNIU0VKZ1hkTWdMTVplUWVNUi92LzZ5UUw5MzQzaE92dlkw?=
 =?gb2312?B?MWM4SnJhOFFQOFBKZkdmZWpzV3dkMDRnL0Q1T1A1aHFRM2tReUh0R3pTcHhM?=
 =?gb2312?B?R2pTVFNXSlN3Wmp0R2RiNSt2UXNPYlhjNHcrMVp0c1hDRGtjWENkc3NINXB2?=
 =?gb2312?B?Zm52QTJ0ZUdtNGJTU0s5V2kvQktTSGxOOTc4UFEzZjNMZkVjR3Q5Qmx1UENi?=
 =?gb2312?B?a0NtVVgzSjI0M0lnQ3BMOWdRQzFRSE5NeWVpaXh6U3JoYlljeUpzbDZEejMz?=
 =?gb2312?B?Z3l0NmNrVkRZanJmNHFVT0o4cHBFZm53OW9lbjcvNytXMHZwdU9TUUM5QW1s?=
 =?gb2312?B?cXNNalFVMW1rTkIvTlpZY1pBQWtoTzZkbjg3bXFvRlJlL3YybVJKRDZ1RlVx?=
 =?gb2312?B?K1FRc21qYmYvbkl4KzQvR1JFbWhjbnFSUzF3amhjU2lOdHJzcXAxMmxkM1lh?=
 =?gb2312?B?QlcwdmVpQ1VxUjhOVUdiNnZWOUk3ZGZvdzBQRGYwRUh4dlVTL01xZG93VmlJ?=
 =?gb2312?B?K1YwN250QmYxTm9RQUNnUU5vS1V3SXZEM1g3LzZaQTRNclJ3ZElzOUwzY2V6?=
 =?gb2312?B?TVNqWk13VHRURVg4VFVJZXkyb0hGRDE5ejgzMlhKR0ZGbDNkM2hCSVljaXhG?=
 =?gb2312?B?Q1ZkQjFUc1lQRnZCWU5WSUF3WnNZSXhCendHTm5oVnZIQUQvSmpZc3hDakxO?=
 =?gb2312?B?Ykt5N0ExbkhOMFNibEREN1dGN254UzVvZ3ozdDZsNTRBckhMZHdXMXZOMTgy?=
 =?gb2312?B?cW14Ti8wQjlwR3o0cG5lR3hRL3NnV3lWSnNmSnZCZllRMlRWVmlLdW1qUU94?=
 =?gb2312?B?ZUk4Uk5LY2doak9wcGN5MGM3ZUpEMnUySWp1L1NPQjQ0L25YN3E3dU9PNkFL?=
 =?gb2312?B?ZTUycVJpTnc2Nml3c3o3TnNZc1ZweVU2aXNwTVRsQmNEZkVOMUt0emlYanFF?=
 =?gb2312?B?VndXTCtSRVEvWjdYSzFoQ0hVS1luNGZzYXRYTlZNcGxrV3lJMllaVWtndE5H?=
 =?gb2312?B?UzIyckx5UWw0UUFzNDVlRDlZK0hzcytmZkl1R0dsOWgvUmhvdnczeU1MamZO?=
 =?gb2312?B?NEtwZ2FBUEtzSHZ4MFhtNW9HelpRdDRPYU5vemFOcWZjRnZBZkNFS1Npb2sr?=
 =?gb2312?B?VmRKbURJNUE0L1JIR2NrNC95SnBGbW5VVDVnRXo3RUdVcHdxa2VKb2huMThr?=
 =?gb2312?B?Rmc3a0F6Nlc2c1E1bXZYbG43enZydGM2czRIMWdGK0lxMzZuMUJhWHdyaFpu?=
 =?gb2312?B?RlNJbFVLVEppVER4QWdnUzh6VmJ4TER1OXNyVnFTbFZhYTVoM3NwN0lXSXdi?=
 =?gb2312?B?d1VWZjhJWm5zb2ZCU3grbWw2M2tuLzE1a1NYZWNIZ05ONnlCckZ3TVR4NmZC?=
 =?gb2312?B?M3NkQnljRDY5dUdxYXpsdEZIWnUyc3FMUlAxelRGZlNDUDMrR0hwQkt6aXpS?=
 =?gb2312?B?OGkzNDE2MHJZbVdSS2puNnoxSFMwaVo5TGl5ZS9vSytPM1MzcjV5d0dNY1hY?=
 =?gb2312?B?VmtiUWczYTFER2Nqa3liRTVtWitKVkY3eFZwRUg5NnFVTklhUlhBSXJKVTVL?=
 =?gb2312?B?WVFuTFdZREdzbkdMQk4xUEhlbEY5NkR2d2tRZTUvVHVEbXhwUlZ0UVl4VnR4?=
 =?gb2312?B?YzFtako1K3FnL2RGQTZkTnI1dVN3T3ROWWEyY3Bmb2JPM3d6bkpUbVpYakZY?=
 =?gb2312?B?L0JGd3BqOXlKMnJ0aWZRNWVnWjllYmtnZEllWFZwQ3hudjVId3phTnZaZmln?=
 =?gb2312?B?N3lqVDlmRml2NUdWSk9PdzVKTnpac0R4bUxHemFsTkJyNzRPUmxHWVpkY2lI?=
 =?gb2312?B?bTM1dGVyMVBxcTZvSmxNQ0lhVlUrYTBWUTViVEs2REVwdHE2WWY1dy9FNUdx?=
 =?gb2312?B?NHBLRFlOZHBlRkVGcFpJeXBad01ZcG1USHREdnVIaExJQVE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR06MB6217.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?c001aFB4d1JVOERXRThGcWc4NXFTY2ZCemcxTmRuREg5VHkvRWlwemRqUFhu?=
 =?gb2312?B?bHVVaVN1OW5qZE1GbnJQOGt6Y0swSmtGZzV3VHFVREltUGg5MG5MVDhGYWZE?=
 =?gb2312?B?ekhKTFF1dE9aaG9BZ3lzU2krZ3RVWTF5UElmWDc4ZDZ3V2Y4YmIxV2hXY1J6?=
 =?gb2312?B?c1VXVzBET3ViNUo2bE5pL1hvNE9uRVgyWE9taS92bm1VR0VkamU2OHlBblBz?=
 =?gb2312?B?V3NtUFo5STk3dHlGVEZNYThaZENvdEdod2RJL29LSGZQNUxPYlFxOVF0SFlR?=
 =?gb2312?B?WWdWTllJNlZCTE9MSU5YNDlYRHFtWnErMEZjeVg5bkhpcjVDcUcxVlFCUEZo?=
 =?gb2312?B?UW1FUlloQnBIVjhVYVlOR1pCTTh5aTBHUHQ0SFdYdFU4SXY5bml0enJXdHJY?=
 =?gb2312?B?a0pPRFg0MlpPVnN0OWozQWtlbFU2WFYwdENLVklDVUt6eDhPVkpOeXZEYkNv?=
 =?gb2312?B?cytwdjhrWWszQmY2TkFMRTV3bFpYMDNoWXgva2t0YXlXczFIVFFQZitqYWF4?=
 =?gb2312?B?Y3hZbnVtVlBuUWZiblNwZ3dWakZBQzdxNGg5Uk14OWpJWTFzZGxiU3BEU3d6?=
 =?gb2312?B?VElEY0FSN1dWL3ErWWtrRWNyT1hqa0pxOTJDVnpmNEh6cnVBcWVITjFpRzFY?=
 =?gb2312?B?aWZCWUNlTUxjQmdJNlFNQVpKcWVPL0F1K3RnVi96OGw3M2hRcmxCL0daTTdh?=
 =?gb2312?B?em43Kzh1ZGdka2VkTzRNb0VOTS8wMDJaZWZTQnluZUIvbFcvR0dMVzlFclVx?=
 =?gb2312?B?a0xlcHVvVGc1T1RJTm8yb3V4d3lWWGdDWE51MzRSamtRemRnSWRtZUI5eDBp?=
 =?gb2312?B?WHM0bUJic3BmVi95Y0pTSmZiZmoyMmNUTld2UWIxdEM0eUtERk81bTZPRTdS?=
 =?gb2312?B?ei9TTml5dmZtbEJxNlJqUHFIYzY2SnFJL21RaUlPaUdmdHgvcUJGeDhNSG5Z?=
 =?gb2312?B?ZzFYZlNZdW53dWMrTzkveGY3czVWK3ZLNU1pbjgrb2tXQ0lCRHorZ0NWRmgz?=
 =?gb2312?B?TXcvcFl4VlpnQ1UzbTdtTFJseTRoTGVtalYrTGoxdStIOURtMnVjWVhhSHlr?=
 =?gb2312?B?VHZRTzB4VWFmbHZweFU0OUZEaWhLVHNMWTlxU04rT3dkdmpyWElUdTJsb0R5?=
 =?gb2312?B?b245emUraUpBeGJmMVFiaWxCRVJZRkloaVlGbWtPRTc3b0JiS3NOL3lIT2d0?=
 =?gb2312?B?blN6K1ZybmhJbTkvdUxId1ZZWDZHOTJiVERjQkM4WnhxR1VuVk0yR3pXY2Vz?=
 =?gb2312?B?bGs3S1F5azFKbU85dEdRUkVPeERYRlJnWTZZQ1pQYW9GRFg5R1ZLZXdOUHEv?=
 =?gb2312?B?cDZ2NXdNYUhWRlh3MStPTkRTdUlQV3Jlb3dhaFhVM2F0WjExcmVHWUM0SzRO?=
 =?gb2312?B?aFZKaEdRakVnT2xiN1I5MmJSM0FzdmNhWFhDc0tRbEZCYUlnY3ZCalR5L0hM?=
 =?gb2312?B?a09kejBJN1oxODJHRXFTaTJWTnFXeDZEelB3bTk5Y0NtanFqMCtQUWNTcnRm?=
 =?gb2312?B?Zno0UU9kdjVQcXY1bzJnYmgrUFBuTTMyTEVYMFBCcG5MWkhVRUd3aTFrZUpR?=
 =?gb2312?B?MFBUeXdDVzZlSGJ5NFBIMXN6dUtIZWt1S0ZhQkJRMU1IY2hhWExxUUpoWHBz?=
 =?gb2312?B?OHZ0QTJYNWV4dDE0T3AwWU9NSzVhWHJ5UU5CeVRkTDA4MHQ3Z2ljTFZiTnhi?=
 =?gb2312?B?Qk50UVJUZEp5dkliSkJJZzlXRHdFUVlRZHFTNGIxMHR2TDV5UEw0SlRBQkZN?=
 =?gb2312?B?azFZdWx6blo2OUdEek1lZzF2aDhOWUpnWktJeE9vZ0ZYR3p4V3B2TGxYZHUx?=
 =?gb2312?B?NjN4T0tmaXg2aytUTXhNK2E5VjdkaVAxUFVMTzhVQjRLeE1yWWIvaDVSODRM?=
 =?gb2312?B?U3k0RHlERmlGUDZ5K25kWVFvU3MvTHFEelUrVndHUU5qTGxCVkRGczRIYUlU?=
 =?gb2312?B?VUdjQVBMQjg0MUgyWjdLazU3Y1hqdDBFaVdnSUF1QVE0ZVBxazB1K2tTd2d0?=
 =?gb2312?B?ejNOOTFsQTN2cFlGTEp2QzNOckNZS1I4MmJpMk1TaVgwSmlCUENHVUJ5ZFFW?=
 =?gb2312?B?UHg1NU5vdExuYXdNMzhoRG43MDVDVUw5eG5OVjFPVG1ZeGlDaFU0WkI1N2xY?=
 =?gb2312?Q?mJz8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f0f55b-f427-4f62-3771-08dcc252e834
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2024 02:34:11.8024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2OQvbrl3CEzo+KTIMw5SnlyN9xBzruxS6xVd43pi5Oqz2ZgDzDLmJjdl3gb9PMhGvlgDlc+okv49cvPZqgUwIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5413

RnJvbTogTGlhbnFpbiBIdSA8aHVsaWFucWluQHZpdm8uY29tPg0KDQpDb25zaWRlcmluZyB0aGF0
IGluIHNvbWUgZXh0cmVtZSBjYXNlcywgd2hlbiB0aGUgdW5iaW5kIG9wZXJhdGlvbg0KaXMgYmVp
bmcgZXhlY3V0ZWQsIGdzZXJpYWxfZGlzY29ubmVjdCBoYXMgYWxyZWFkeSBjbGVhcmVkIGdzZXIt
PmlvcG9ydCwNCmFuZCB0aGUgY29udHJvbGxlciBoYXMgbm90IHN0b3BwZWQgJiBwdWxsdXAgMCwg
c3lzLnVzYi5jb25maWcgaXMgcmVzZXQNCmFuZCB0aGUgYmluZCBvcGVyYXRpb24gd2lsbCBiZSBy
ZS1leGVjdXRlZCwgY2FsbGluZyBnc19yZWFkX2NvbXBsZXRlLA0Kd2hpY2ggd2lsbCByZXN1bHQg
aW4gYWNjZXNzaW5nIGdzZXItPmlwb3J0LCByZXN1bHRpbmcgaW4gYSBudWxsIHBvaW50ZXINCmRl
cmVmZXJlbmNlLCBhZGQgYSBudWxsIHBvaW50ZXIgY2hlY2sgdG8gcHJldmVudCB0aGlzIHNpdHVh
dGlvbi4NCg0KQWRkZWQgYSBzdGF0aWMgc3BpbmxvY2sgdG8gcHJldmVudCBnc2VyLT5pb3BvcnQg
ZnJvbSBiZWNvbWluZw0KbnVsbCBhZnRlciB0aGUgbmV3bHkgYWRkZWQgY2hlY2suDQoNClVuYWJs
ZSB0byBoYW5kbGUga2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSBhdA0KdmlydHVhbCBh
ZGRyZXNzIDAwMDAwMDAwMDAwMDAxYTgNCnBjIDogZ3NfcmVhZF9jb21wbGV0ZSsweDU4LzB4MjQw
DQpsciA6IHVzYl9nYWRnZXRfZ2l2ZWJhY2tfcmVxdWVzdCsweDQwLzB4MTYwDQpzcCA6IGZmZmZm
ZmMwMGYxNTM5YzANCngyOTogZmZmZmZmYzAwZjE1MzljMCB4Mjg6IGZmZmZmZjgwMDJhMzAwMDAg
eDI3OiAwMDAwMDAwMDAwMDAwMDAwDQp4MjY6IGZmZmZmZjgwMDJhMzAwMDAgeDI1OiAwMDAwMDAw
MDAwMDAwMDAwIHgyNDogZmZmZmZmODAwMmEzMDAwMA0KeDIzOiBmZmZmZmY4MDAyZmY5YTcwIHgy
MjogZmZmZmZmODk4ZTdhN2IwMCB4MjE6IGZmZmZmZjgwM2M5YWY5ZDgNCngyMDogZmZmZmZmODk4
ZTdhN2IwMCB4MTk6IDAwMDAwMDAwMDAwMDAxYTggeDE4OiBmZmZmZmZjMDA5OWZkMDk4DQp4MTc6
IDAwMDAwMDAwMDAwMDEwMDAgeDE2OiAwMDAwMDAwMDgwMDAwMDAwIHgxNTogMDAwMDAwMGFjMTIw
MDAwMA0KeDE0OiAwMDAwMDAwMDAwMDAwMDAzIHgxMzogMDAwMDAwMDAwMDAwZDVlOCB4MTI6IDAw
MDAwMDAzNTVjMzE0YWMNCngxMTogMDAwMDAwMDAwMDAwMDAxNSB4MTA6IDAwMDAwMDAwMDAwMDAw
MTIgeDkgOiAwMDAwMDAwMDAwMDAwMDA4DQp4OCA6IDAwMDAwMDAwMDAwMDAwMDAgeDcgOiAwMDAw
MDAwMDAwMDAwMDAwIHg2IDogZmZmZmZmODg3Y2QxMjAwMA0KeDUgOiAwMDAwMDAwMDAwMDAwMDAy
IHg0IDogZmZmZmZmYzAwZjliMDdmMCB4MyA6IGZmZmZmZmMwMGYxNTM4ZDANCngyIDogMDAwMDAw
MDAwMDAwMDAwMSB4MSA6IDAwMDAwMDAwMDAwMDAwMDAgeDAgOiAwMDAwMDAwMDAwMDAwMWE4DQpD
YWxsIHRyYWNlOg0KZ3NfcmVhZF9jb21wbGV0ZSsweDU4LzB4MjQwDQp1c2JfZ2FkZ2V0X2dpdmVi
YWNrX3JlcXVlc3QrMHg0MC8weDE2MA0KZHdjM19yZW1vdmVfcmVxdWVzdHMrMHgxNzAvMHg0ODQN
CmR3YzNfZXAwX291dF9zdGFydCsweGIwLzB4MWQ0DQpfX2R3YzNfZ2FkZ2V0X3N0YXJ0KzB4MjVj
LzB4NzIwDQprcmV0cHJvYmVfdHJhbXBvbGluZS5jZmlfanQrMHgwLzB4OA0Ka3JldHByb2JlX3Ry
YW1wb2xpbmUuY2ZpX2p0KzB4MC8weDgNCnVkY19iaW5kX3RvX2RyaXZlcisweDFkOC8weDMwMA0K
dXNiX2dhZGdldF9wcm9iZV9kcml2ZXIrMHhhOC8weDFkYw0KZ2FkZ2V0X2Rldl9kZXNjX1VEQ19z
dG9yZSsweDEzYy8weDE4OA0KY29uZmlnZnNfd3JpdGVfaXRlcisweDE2MC8weDFmNA0KdmZzX3dy
aXRlKzB4MmQwLzB4NDBjDQprc3lzX3dyaXRlKzB4N2MvMHhmMA0KX19hcm02NF9zeXNfd3JpdGUr
MHgyMC8weDMwDQppbnZva2Vfc3lzY2FsbCsweDYwLzB4MTUwDQplbDBfc3ZjX2NvbW1vbisweDhj
LzB4ZjgNCmRvX2VsMF9zdmMrMHgyOC8weGEwDQplbDBfc3ZjKzB4MjQvMHg4NA0KZWwwdF82NF9z
eW5jX2hhbmRsZXIrMHg4OC8weGVjDQplbDB0XzY0X3N5bmMrMHgxYjQvMHgxYjgNCkNvZGU6IGFh
MWYwM2UxIGFhMTMwM2UwIDUyODAwMDIyIDJhMDEwM2U4ICg4OGU4N2U2MikNCi0tLVsgZW5kIHRy
YWNlIDkzODg0NzMyN2E3MzkxNzIgXS0tLQ0KS2VybmVsIHBhbmljIC0gbm90IHN5bmNpbmc6IE9v
cHM6IEZhdGFsIGV4Y2VwdGlvbg0KDQpGaXhlczogYzFkY2E1NjJiZThhICgidXNiIGdhZGdldDog
c3BsaXQgb3V0IHNlcmlhbCBjb3JlIikNCkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQpTaWdu
ZWQtb2ZmLWJ5OiBMaWFucWluIEh1IDxodWxpYW5xaW5Adml2by5jb20+DQotLS0NCnY2Og0KICAt
IFVwZGF0ZSB0aGUgY29tbWl0IHRleHQNCiAgLSBBZGQgdGhlIEZpeGVzIHRhZw0KICAtIENDIHN0
YWJsZSBrZXJuZWwNCiAgLSBBZGQgc2VyaWFsX3BvcnRfbG9jayBwcm90ZWN0aW9uIHdoZW4gY2hl
Y2tpbmcgcG9ydCBwb2ludGVyDQogIC0gT3B0aW1pemUgY29kZSBjb21tZW50cw0KICAtIERlbGV0
ZSBsb2cgcHJpbnRpbmcNCi0tLQ0KIGRyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91X3Nlcmlh
bC5jIHwgMzMgKysrKysrKysrKysrKysrKysrKysrKy0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMjgg
aW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNi
L2dhZGdldC9mdW5jdGlvbi91X3NlcmlhbC5jIGIvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9u
L3Vfc2VyaWFsLmMNCmluZGV4IGIzOTQxMDVlNTVkNi4uZTQzZDgwNjVmN2VjIDEwMDY0NA0KLS0t
IGEvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL3Vfc2VyaWFsLmMNCisrKyBiL2RyaXZlcnMv
dXNiL2dhZGdldC9mdW5jdGlvbi91X3NlcmlhbC5jDQpAQCAtNDUyLDIwICs0NTIsNDMgQEAgc3Rh
dGljIHZvaWQgZ3NfcnhfcHVzaChzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspDQogDQogc3RhdGlj
IHZvaWQgZ3NfcmVhZF9jb21wbGV0ZShzdHJ1Y3QgdXNiX2VwICplcCwgc3RydWN0IHVzYl9yZXF1
ZXN0ICpyZXEpDQogew0KLQlzdHJ1Y3QgZ3NfcG9ydAkqcG9ydCA9IGVwLT5kcml2ZXJfZGF0YTsN
CisJc3RydWN0IGdzX3BvcnQJKnBvcnQ7DQorCXVuc2lnbmVkIGxvbmcgIGZsYWdzOw0KKw0KKwlz
cGluX2xvY2tfaXJxc2F2ZSgmc2VyaWFsX3BvcnRfbG9jaywgZmxhZ3MpOw0KKwlwb3J0ID0gZXAt
PmRyaXZlcl9kYXRhOw0KKw0KKwkvKiBXaGVuIHBvcnQgaXMgTlVMTCwgcmV0dXJuIHRvIGF2b2lk
IHBhbmljLiAqLw0KKwlpZiAoIXBvcnQpIHsNCisJCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJnNl
cmlhbF9wb3J0X2xvY2ssIGZsYWdzKTsNCisJCXJldHVybjsNCisJfQ0KIA0KLQkvKiBRdWV1ZSBh
bGwgcmVjZWl2ZWQgZGF0YSB1bnRpbCB0aGUgdHR5IGxheWVyIGlzIHJlYWR5IGZvciBpdC4gKi8N
CiAJc3Bpbl9sb2NrKCZwb3J0LT5wb3J0X2xvY2spOw0KKwlzcGluX3VubG9jaygmc2VyaWFsX3Bv
cnRfbG9jayk7DQorDQorCS8qIFF1ZXVlIGFsbCByZWNlaXZlZCBkYXRhIHVudGlsIHRoZSB0dHkg
bGF5ZXIgaXMgcmVhZHkgZm9yIGl0LiAqLw0KIAlsaXN0X2FkZF90YWlsKCZyZXEtPmxpc3QsICZw
b3J0LT5yZWFkX3F1ZXVlKTsNCiAJc2NoZWR1bGVfZGVsYXllZF93b3JrKCZwb3J0LT5wdXNoLCAw
KTsNCi0Jc3Bpbl91bmxvY2soJnBvcnQtPnBvcnRfbG9jayk7DQorCXNwaW5fdW5sb2NrX2lycXJl
c3RvcmUoJnBvcnQtPnBvcnRfbG9jaywgZmxhZ3MpOw0KIH0NCiANCiBzdGF0aWMgdm9pZCBnc193
cml0ZV9jb21wbGV0ZShzdHJ1Y3QgdXNiX2VwICplcCwgc3RydWN0IHVzYl9yZXF1ZXN0ICpyZXEp
DQogew0KLQlzdHJ1Y3QgZ3NfcG9ydAkqcG9ydCA9IGVwLT5kcml2ZXJfZGF0YTsNCisJc3RydWN0
IGdzX3BvcnQJKnBvcnQ7DQorCXVuc2lnbmVkIGxvbmcgIGZsYWdzOw0KKw0KKwlzcGluX2xvY2tf
aXJxc2F2ZSgmc2VyaWFsX3BvcnRfbG9jaywgZmxhZ3MpOw0KKwlwb3J0ID0gZXAtPmRyaXZlcl9k
YXRhOw0KKw0KKwkvKiBXaGVuIHBvcnQgaXMgTlVMTCwgcmV0dXJuIHRvIGF2b2lkIHBhbmljLiAq
Lw0KKwlpZiAoIXBvcnQpIHsNCisJCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJnNlcmlhbF9wb3J0
X2xvY2ssIGZsYWdzKTsNCisJCXJldHVybjsNCisJfQ0KIA0KIAlzcGluX2xvY2soJnBvcnQtPnBv
cnRfbG9jayk7DQorCXNwaW5fdW5sb2NrKCZzZXJpYWxfcG9ydF9sb2NrKTsNCiAJbGlzdF9hZGQo
JnJlcS0+bGlzdCwgJnBvcnQtPndyaXRlX3Bvb2wpOw0KIAlwb3J0LT53cml0ZV9zdGFydGVkLS07
DQogDQpAQCAtNDg2LDcgKzUwOSw3IEBAIHN0YXRpYyB2b2lkIGdzX3dyaXRlX2NvbXBsZXRlKHN0
cnVjdCB1c2JfZXAgKmVwLCBzdHJ1Y3QgdXNiX3JlcXVlc3QgKnJlcSkNCiAJCWJyZWFrOw0KIAl9
DQogDQotCXNwaW5fdW5sb2NrKCZwb3J0LT5wb3J0X2xvY2spOw0KKwlzcGluX3VubG9ja19pcnFy
ZXN0b3JlKCZwb3J0LT5wb3J0X2xvY2ssIGZsYWdzKTsNCiB9DQogDQogc3RhdGljIHZvaWQgZ3Nf
ZnJlZV9yZXF1ZXN0cyhzdHJ1Y3QgdXNiX2VwICplcCwgc3RydWN0IGxpc3RfaGVhZCAqaGVhZCwN
Ci0tIA0KMi4zOS4wDQoNCg==

