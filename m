Return-Path: <linux-kernel+bounces-201723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CFB8FC236
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 05:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55B48B21812
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 03:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6E412DDA2;
	Wed,  5 Jun 2024 03:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="e4bZc3JV"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2E62941B;
	Wed,  5 Jun 2024 03:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717558480; cv=fail; b=UGBPqDJz6YUa5zgaduMOrROHRZxmx0Yp8i+HbNZ1Cbnu0Po76RFt/K/Y37AtjgZ0YvKyYKOYUO6D2F3708YoH47FAJxa6CTMFcPVxPRXdPsoO1XJHQz7MBLu5Zrioicgf8DOpU2vgp3lXZEtzBf2FiE+SKhnVeU+zKtU1sBMap0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717558480; c=relaxed/simple;
	bh=R2SmfQd/LYPLa0+Kr8O8//dTc6ohiXydsvKjpAJpNk0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IVJyoyGMZEzfgobWehHSyrOGAiepp/8/HaJrxg6DK0UNJJI3EP1m2laIRgX6CDhmiQAPyV4UiH8RAlCz3QrUC5tyOd0pLLHqXbsTZ0fmdvW8n98bLTpv+yQH+mRYdm6CoGHzMIsslTol6nViUEI8KVhpjcKmYyydO+6Ld0ficNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=e4bZc3JV; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 454LBQ2n003926;
	Tue, 4 Jun 2024 20:34:16 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3yj167bqpb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 20:34:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dA/RLrgw0e+I4Sy74zqHcfxBnpxggiwieoQ15YauuVbiTJlO6QJr8y4VHj0ewFk9ehRfegHYFIwk+VP6mn61rBo5p1OWD/mzpALinOu1kZRxWcXsGlsszhcEkHhJzmw5K1RLlIn0w4OeKfXxbpFkPCMdX4BtcrqLpv8TOtALhBf9ECuu9ZAoyRAnKUscZanGAyxOg3+KD2rGM4iKyF9iGX0FEPG+daw87afA44GDX8wdZEytnj+aXPk5Fk09dQAK0T2ZO8QFwttsGSmuoLzJ3QdONWHs/liYZxOpa/jdTTphYGeHH6Weq/Bl3SNQM5QLPEt5rHMzqmU/PH5KVHgisw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pz4vwSbcLTzS1yCx8c8E4T0ub0Jf+VuJzfJlWiTt0qo=;
 b=ATH1az0NkEUqkbpBWsmNozpc5JRwQGE2PW5bmGiuoOPZOY03DXnekFGiEkQEGMOgMeiWBQ5puGkuGb+rXSs3/BvVVodKoKkZXaftvkSlsC99pkO+Y+Ta4Er5JSwZOKnsC8x3KblKmORTrvOpfiaILLlT92Rz2X2d4RnVcceh0jS8uQmAvaqT7yyWJY7QLTDXdg/MK4o0osK+Ar2dBpcUI7tSb8eB3AsneqW7QGyzD9vMaAs/dBc2aSDk3FoBBRDJiCPz5WBb/v7nPK3AL8Qfoi0EqAvr0JsT8+6T2wnz3rSyWT5ApXqYRrh/oyvBUz8z3VU4oXFWgMBniTyCq6MwSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pz4vwSbcLTzS1yCx8c8E4T0ub0Jf+VuJzfJlWiTt0qo=;
 b=e4bZc3JV1wANpzGhuofh88KntICmsblCWthEyHsWtEXLm2hEpSpEDphGIuynR88dv21BugGQaMuPSigLKhk63RqeNtbyKRKjgb0e0BhsWNULL6EewCpA4tYmL67mIEx15+F4FDECeVDnNf62StlYwLDej9grPsubAafLdOhwbFs=
Received: from MW4PR18MB5084.namprd18.prod.outlook.com (2603:10b6:303:1a7::8)
 by PH0PR18MB4574.namprd18.prod.outlook.com (2603:10b6:510:ac::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.29; Wed, 5 Jun
 2024 03:34:11 +0000
Received: from MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::1fe2:3c84:eebf:a905]) by MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::1fe2:3c84:eebf:a905%5]) with mapi id 15.20.7633.018; Wed, 5 Jun 2024
 03:34:11 +0000
Message-ID: <865cf85d-84df-454f-9cbd-83c91d3df85c@marvell.com>
Date: Wed, 5 Jun 2024 09:04:01 +0530
User-Agent: Mozilla Thunderbird
Subject: [PATCH v6 3/3] arm64: dts: freescale: add i.MX95 19x19 EVK minimal
 board dts
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Peng Fan <peng.fan@nxp.com>
References: <20240605-imx95-dts-v3-v6-0-2ce275ed0e80@nxp.com>
 <20240605-imx95-dts-v3-v6-3-2ce275ed0e80@nxp.com>
Content-Language: en-US
From: Amit Singh Tomar <amitsinght@marvell.com>
In-Reply-To: <20240605-imx95-dts-v3-v6-3-2ce275ed0e80@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0131.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::16) To MW4PR18MB5084.namprd18.prod.outlook.com
 (2603:10b6:303:1a7::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR18MB5084:EE_|PH0PR18MB4574:EE_
X-MS-Office365-Filtering-Correlation-Id: 3502c646-aeca-4d4b-dd96-08dc85105d0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MlNiVFcweXJCSUx0VGF2dUpNVUR2YUwvUG1RNVF5RHNxbXZXL1JaMjhFeUJs?=
 =?utf-8?B?K29FSlhqZElRNVpES1czbjhMRjg4Wkg5dlR2dVBrQm1qbFE2UisxdEhKNFNU?=
 =?utf-8?B?cFc1eVNDdlV1UjFkQVhWSXFBRkQ0RWhUS01ZZzY4TkswWnBDdnNWYVAvRzlp?=
 =?utf-8?B?Ynl2cXhBV1JKQXcwckVTN2RNOXhXVGQyRnVLOGdIOFhScVFVRjIxcGRieW1i?=
 =?utf-8?B?alptbUxOaE9pazhVUmJPd2hveGFVQjhzcktaS0dRb3VQZkMzYy9JTWVwMGMw?=
 =?utf-8?B?a08zMmZHUy9rMzNKNFpCeGdVV0xnd3h3ZGp4cDlvRHdrWkdZVUtMbFh5Qkln?=
 =?utf-8?B?SFV5eG45MGttZXN4aEp6RS9XTVA5c3JKYmtCTEdtdDdkSlpJbE5uT3EwK1ZM?=
 =?utf-8?B?N1ZCaE52dHQ4SEorWFN1ZGVVVko2dFJSUm9ka1h5K2VrbTBIcXk2ZGJ2K1JI?=
 =?utf-8?B?d0pRQnZaRHJpcTBYMWV6dG9JKzZ1UWNlL2VtdXFGK2hBdml5eVNtcTRqSTVp?=
 =?utf-8?B?Q0RUV2I3cEJoa0FweVY5MEZBck9hc1FING0yWWMrSFc0M1hEUU5sckNKY0dw?=
 =?utf-8?B?c2xCOHoxVVFaUEdKV2RHOU5kbkJnYUNpQTRJTTR0ZzRrckFMNzMraEM4T2FX?=
 =?utf-8?B?S21YSmtyQkQzN1VpQWF1KzV2NlhqNWthZVo2N3IvOGttMkM0S1hhRURvMlpo?=
 =?utf-8?B?T1JnMlNzMDdFa0t5SURIb0crWS96dkhWazdPMFo3a2I2Zll4Z0sxb2Y4N2lE?=
 =?utf-8?B?Sm00cjdmVWNZYVZHUmNyTHZGOURjODJlNzBVN2Q5ZXF3Z3RPYVh4bkR3VEZE?=
 =?utf-8?B?SHBWekl6Q21WZWVqYlBBbk9RMzFma0RDUUpmZFdYbVl6VmpqOWlKNS95aFk5?=
 =?utf-8?B?YTFXUVN1bzlpOUY4Wm9tL2wxdWdjbjBSVEpiVUNKUkN1aklxczdNZ0w5bTFG?=
 =?utf-8?B?OFBFY0xWcStFRS9HOHlyRU1MSC9yVS96blp4VW5kMW5mbndVSTNEZ3J0Ty9O?=
 =?utf-8?B?SXEvQ0lkUmNRSXpLczUyakNCTCtOWTA5bGh1R2FaemdNMXFGeEZrQklkOGpl?=
 =?utf-8?B?NDJwY3VQZDJNWnJMOG0vaXJZZGl3R2pnSWxQK3psTXZwQVhJYzlnNDA4YXhy?=
 =?utf-8?B?RWM0bEtwSm9YQkZuNHlNVDhETUFTZThtVWpZSjRnZGFxdU1RRlZuYkRhSnBF?=
 =?utf-8?B?aFlQMWtqVTZxTDVHZ3ZsR0pUek9QVXdheE5rZWV3VUY5NEFuYTZpcjZoMnNP?=
 =?utf-8?B?Wm1USkhFcHpQN01UeTZrcDVacWk4VjZWOVc2QmlaT2FMalpCdXNFMG1HcEVr?=
 =?utf-8?B?TCtvV0w4MU5Ja1N3ekIxeEdpa3ZyZEI1NXVLNHVrWjVCaHFDMGl5N05tVW5F?=
 =?utf-8?B?eEJ0OEtLT3JxY2l0VC9CNTdpamhReG5oU0lBOXNDK2VGK1I5Q3RBbmpCMVRn?=
 =?utf-8?B?Ymc4enh3UGd1MlU0TkxnTmk3cEtaeVRVRmxmU2NFSEd4a2FldjlnSUxuWHNS?=
 =?utf-8?B?d2J6aHZiTWpwT2xTbW15VVVmTWxPaVZLRENid0dvQkNxNnJTakhWcnloQlRJ?=
 =?utf-8?B?UUdkRXhZVUtzNDdwczB5dnZrRVFPU1llcDU2R2lXN3E1bitwTWN4UzJPZ1hP?=
 =?utf-8?B?N2Q3TUUzUEVvZS9GZFk3eHR5Y2dWbVNYRENlSS93WXk3MEgxcnhMVk81Tks1?=
 =?utf-8?B?cHNQbEM3NGFqb3NkakZMb095eE1hYmZqSXpXZTNySy9ZbWtMUVhIRkxNMGF5?=
 =?utf-8?Q?ZrlC5UJiGgQvY43zoST4rkmej/AAYQsbK9K0c5A?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5084.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QVJoNE9rcDdndEl0b3dFNHdNMTFWTzNabDQ0Tlk5cFlBWnBWdURIbVZxdHFW?=
 =?utf-8?B?UmF1L2xVQTl0a1Z1UkM2U1VIcTVweU1FOUlSL0RuZHpONWNOVnprVXgyS0ky?=
 =?utf-8?B?SitRS3ZRelJHNmpIU0tWRXMwaWN2cVkwVVJzci9uK0U5VmlIQnJENVdGayth?=
 =?utf-8?B?TWhQY3RHSzBXZW9uV0lrdFpXTHBsQmlSZnpleTVHK3JYT1g5QlJQaDlDeGdh?=
 =?utf-8?B?YmJuaFUzeVBLbHVoOUpleDhjSi92UU12NHo3S3M1dnh0ZUdrcXBreFRjdFVa?=
 =?utf-8?B?b2dqcTBXVXFSalVpaVFRY3JxNWZaRGZzVW94ZnhOeXpJV1FLS2lXOER6L2s1?=
 =?utf-8?B?dTk2dzFQdFVVZ1dIL3JrdVVCWXdodTlubVF2YmtKUzk2cFFTYUtSSWNKQ0dN?=
 =?utf-8?B?SE5qK0xxSWN3d2JUbGh4RG90SkdHR05hNTF3RSt2d2VXMnRlMkN6ZlpwaHFh?=
 =?utf-8?B?SGlCSmdpUWV5YW93aGRDdnUwdTJGZklVNHZTbHVPUkdNMnFRSldkQjFDS1hN?=
 =?utf-8?B?YldkUzVyT1Rwc29xRDBRaS85VC9ZbE1qWVhNWlA2ZHlhOU53YjhCbDJaeEh3?=
 =?utf-8?B?dWZDc0RGQU1KZU5mZ2RwdENaZzd5cmx1dml6ZHFtYkdHYTd6QTBFeFkwTkRM?=
 =?utf-8?B?ODJQTFdEOS9LbUNpVmhNekhGRnFaczQ0ZisrR2NCUFl6eW8wdVIrMDZVNlA4?=
 =?utf-8?B?TXVwUGJhMnhadDhQcUhhci9OVU1kakJvSk1XeDNLMXNiNXR0dXRkZFZTVGJY?=
 =?utf-8?B?bFVrMHpRSzB3Y3Y0aU5QZzJsbGlGN2xFVkNtcy9uRDYwOVllamFteWxDWWpY?=
 =?utf-8?B?c3VIcGcrV05sbFhmdXVnck5FMWFKK0oyODhmcWVwTGNNMEE5bUFHVnRicklp?=
 =?utf-8?B?QTF5QkM5b2M4VE1HNCt2bitScENadU1pNHFHYVFOMEw5RWd3cGZFVVZBYS9v?=
 =?utf-8?B?N1htaHNtbkdxYmE1Ly9iRU5SRVI0OFlMT1ZjV3hhYjUzTmFXZTBZRTdJOTF0?=
 =?utf-8?B?ei9ZaGk2WC8xa2pLelRDTzVvMWVoUWdVS0pPc1pYYW9oQUtqY3g3VWRsdUgy?=
 =?utf-8?B?dnhEVEF1MHMxbmc2aXd5VUN4VDdjVllnL2R4TjJOY2RsTHdEZWdic29vbllB?=
 =?utf-8?B?aDhmVWQySmV4TDBidi9ZQ0ZIVUpzT1FvN2JORkprY3VnbU9QQmVobXplNlhI?=
 =?utf-8?B?REZxWUtVY1VyNXptTUJPbmgyT1JpZHF1Z2FDRFlZbDlPSFFKQWJkMllSMEdt?=
 =?utf-8?B?Q3c4NktVOWZsNE5FcTFNUFhyRkw0ZGIxbDR3RUZLQlQvb0VReHBnNWVmSGNW?=
 =?utf-8?B?dzFIUUhtUFNNTXpDQUI3WGlWZVZwRXZTb2dKWlcva3FFblJUY0Z6Y0tWNnlX?=
 =?utf-8?B?RmRBenRTZG1FMURRWjBXaG51WWhFdXoza3UxeGRIQ1JBOTNYSTNGMzhmYlV5?=
 =?utf-8?B?eXBwZ2lZRlo1NHN0TWxhUm5kSlhoMjFkc0JLWms0VGdEdEllTzh4UUtaK3JT?=
 =?utf-8?B?WUF0UGNuVGhwNE9iM3RYVGp6RkV6WGpQVmZCQWw0SHFNOEFCMk9SN3k3cDRy?=
 =?utf-8?B?Y0Vla2JJWnNMcDcvMXZQVVMwM2o5d0VBN2VZaUJnd1J3MmJESXdHZ1dGVWtJ?=
 =?utf-8?B?MmhVNURja0hVOWtUbFUwNUN2TlAyZzZ4UE9tanBQLzJsYnZvRzJxcGttczlr?=
 =?utf-8?B?amFwWWJRQ0ltSU1DZ2U5VDBuNVBWcWNjaEYyVUIzak9zWTcwUEpPdE0rK3dx?=
 =?utf-8?B?N3FxMk9HZ3B5aUt0VDNTd1ZJbWY5ekk2MVpkTy8wRjRVT2RDd2g4Q2RyUjBK?=
 =?utf-8?B?TkFCWUl1RDBGYzdzMVZjbE1vQ1BvYmRuSlJDSmJXWGEzS29uMEhLdzlmeHdP?=
 =?utf-8?B?ejlFZ2UwdWNiMDBiVVlWVmdWbHVwVTBFaTJwa3RzZXJzOW1waHhXbUQ3dE5H?=
 =?utf-8?B?c0crYUpUMTFILzlBbEYxTm9vUk4zSy9KNmcvc295bWRicWhDWE8rYURLMHlQ?=
 =?utf-8?B?c3dXakVTdmVWWkMvTVZ6UHdhdWJDWlNETjViR2xGdlY5TFVXWnZZcmhuU25O?=
 =?utf-8?B?NGRobGVsampEME9QM2tLNkFpc0lSOGRKY2FxSFZscDd2WENPMDBoUzY3NVNo?=
 =?utf-8?Q?ek4+KZUAzOaQDAoXjNtCu1DRb?=
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3502c646-aeca-4d4b-dd96-08dc85105d0d
X-MS-Exchange-CrossTenant-AuthSource: MW4PR18MB5084.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 03:34:10.9920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qNdEpMoEzcMsuBRuYvSblx9e8TxL/245ipIvY7adGUc7V732g/dInACoEI1BOwOZLvfLZVFarfS4laiQyMNphg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4574
X-Proofpoint-ORIG-GUID: 3ef9eT11OcWNKUJ35rpzi9wT-Ns-B2nX
X-Proofpoint-GUID: 3ef9eT11OcWNKUJ35rpzi9wT-Ns-B2nX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_11,2024-06-04_02,2024-05-17_01


> From: Peng Fan <peng.fan@nxp.com>
> 
> Add a minimal dts for i.MX95 19x19 EVK board:
>   - lpuart1 as console
>   - sdhc1/2 as storage
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>   arch/arm64/boot/dts/freescale/Makefile            |   1 +
>   arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts | 200 ++++++++++++++++++++++
>   2 files changed, 201 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 1b1e4db02071..c3fef4e4d8dd 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -239,6 +239,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-segin.dtb
>   dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxca.dtb
>   dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxla.dtb
>   dtb-$(CONFIG_ARCH_MXC) += imx93-var-som-symphony.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx95-19x19-evk.dtb
>   
>   imx8mm-venice-gw72xx-0x-imx219-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-imx219.dtbo
>   imx8mm-venice-gw72xx-0x-rpidsi-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-rpidsi.dtbo
> diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> new file mode 100644
> index 000000000000..2c2f3cfbe11a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> @@ -0,0 +1,200 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +/dts-v1/;
> +
> +#include "imx95.dtsi"
> +
> +/ {
> +	model = "NXP i.MX95 19X19 board";
> +	compatible = "fsl,imx95-19x19-evk", "fsl,imx95";
> +
> +	aliases {
> +		mmc0 = &usdhc1;
> +		mmc1 = &usdhc2;
> +		serial0 = &lpuart1;
> +	};
> +
> +	chosen {
> +		stdout-path = &lpuart1;
> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x0 0x80000000 0 0x80000000>;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		linux_cma: linux,cma {
> +			compatible = "shared-dma-pool";
> +			alloc-ranges = <0 0x80000000 0 0x7F000000>;
nitpick: Please use the lower case (0x7f...) for length parameter.
> +			size = <0 0x3c000000>;
> +			linux,cma-default;
> +			reusable;
> +		};
> +	};
> +
> +	reg_usdhc2_vmmc: regulator-usdhc2 {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
> +		regulator-name = "VDD_SD2_3V3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio3 7 GPIO_ACTIVE_HIGH>;
> +		off-on-delay-us = <12000>;
> +		enable-active-high;
> +	};
> +};
> +
> +&lpuart1 {
> +	/* console */
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	status = "okay";
> +};
> +
> +&mu7 {
> +	status = "okay";
> +};
> +
> +&usdhc1 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
> +	pinctrl-0 = <&pinctrl_usdhc1>;
> +	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
> +	pinctrl-3 = <&pinctrl_usdhc1>;
> +	bus-width = <8>;
> +	non-removable;
> +	no-sdio;
> +	no-sd;
> +	status = "okay";
> +};
> +
> +&usdhc2 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
> +	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
> +	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
> +	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
> +	pinctrl-3 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
> +	cd-gpios = <&gpio3 0 GPIO_ACTIVE_LOW>;
> +	vmmc-supply = <&reg_usdhc2_vmmc>;
> +	bus-width = <4>;
> +	status = "okay";
> +};
> +
> +&wdog3 {
> +	fsl,ext-reset-output;
> +	status = "okay";
> +};
> +
> +&scmi_iomuxc {
> +	pinctrl_uart1: uart1grp {
> +		fsl,pins = <
> +			IMX95_PAD_UART1_RXD__AONMIX_TOP_LPUART1_RX      0x31e
> +			IMX95_PAD_UART1_TXD__AONMIX_TOP_LPUART1_TX      0x31e
> +		>;
> +	};
> +
> +	pinctrl_usdhc1: usdhc1grp {
> +		fsl,pins = <
> +			IMX95_PAD_SD1_CLK__USDHC1_CLK			0x158e
> +			IMX95_PAD_SD1_CMD__USDHC1_CMD			0x138e
> +			IMX95_PAD_SD1_DATA0__USDHC1_DATA0		0x138e
> +			IMX95_PAD_SD1_DATA1__USDHC1_DATA1		0x138e
> +			IMX95_PAD_SD1_DATA2__USDHC1_DATA2		0x138e
> +			IMX95_PAD_SD1_DATA3__USDHC1_DATA3		0x138e
> +			IMX95_PAD_SD1_DATA4__USDHC1_DATA4		0x138e
> +			IMX95_PAD_SD1_DATA5__USDHC1_DATA5		0x138e
> +			IMX95_PAD_SD1_DATA6__USDHC1_DATA6		0x138e
> +			IMX95_PAD_SD1_DATA7__USDHC1_DATA7		0x138e
> +			IMX95_PAD_SD1_STROBE__USDHC1_STROBE		0x158e
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
> +		fsl,pins = <
> +			IMX95_PAD_SD1_CLK__USDHC1_CLK			0x158e
> +			IMX95_PAD_SD1_CMD__USDHC1_CMD			0x138e
> +			IMX95_PAD_SD1_DATA0__USDHC1_DATA0		0x138e
> +			IMX95_PAD_SD1_DATA1__USDHC1_DATA1		0x138e
> +			IMX95_PAD_SD1_DATA2__USDHC1_DATA2		0x138e
> +			IMX95_PAD_SD1_DATA3__USDHC1_DATA3		0x138e
> +			IMX95_PAD_SD1_DATA4__USDHC1_DATA4		0x138e
> +			IMX95_PAD_SD1_DATA5__USDHC1_DATA5		0x138e
> +			IMX95_PAD_SD1_DATA6__USDHC1_DATA6		0x138e
> +			IMX95_PAD_SD1_DATA7__USDHC1_DATA7		0x138e
> +			IMX95_PAD_SD1_STROBE__USDHC1_STROBE		0x158e
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
> +		fsl,pins = <
> +			IMX95_PAD_SD1_CLK__USDHC1_CLK			0x15fe
> +			IMX95_PAD_SD1_CMD__USDHC1_CMD			0x13fe
> +			IMX95_PAD_SD1_DATA0__USDHC1_DATA0		0x13fe
> +			IMX95_PAD_SD1_DATA1__USDHC1_DATA1		0x13fe
> +			IMX95_PAD_SD1_DATA2__USDHC1_DATA2		0x13fe
> +			IMX95_PAD_SD1_DATA3__USDHC1_DATA3		0x13fe
> +			IMX95_PAD_SD1_DATA4__USDHC1_DATA4		0x13fe
> +			IMX95_PAD_SD1_DATA5__USDHC1_DATA5		0x13fe
> +			IMX95_PAD_SD1_DATA6__USDHC1_DATA6		0x13fe
> +			IMX95_PAD_SD1_DATA7__USDHC1_DATA7		0x13fe
> +			IMX95_PAD_SD1_STROBE__USDHC1_STROBE		0x15fe
> +		>;
> +	};
> +
> +	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
> +		fsl,pins = <
> +			IMX95_PAD_SD2_RESET_B__GPIO3_IO_BIT7		0x31e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
> +		fsl,pins = <
> +			IMX95_PAD_SD2_CD_B__GPIO3_IO_BIT0		0x31e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2: usdhc2grp {
> +		fsl,pins = <
> +			IMX95_PAD_SD2_CLK__USDHC2_CLK			0x158e
> +			IMX95_PAD_SD2_CMD__USDHC2_CMD			0x138e
> +			IMX95_PAD_SD2_DATA0__USDHC2_DATA0		0x138e
> +			IMX95_PAD_SD2_DATA1__USDHC2_DATA1		0x138e
> +			IMX95_PAD_SD2_DATA2__USDHC2_DATA2		0x138e
> +			IMX95_PAD_SD2_DATA3__USDHC2_DATA3		0x138e
> +			IMX95_PAD_SD2_VSELECT__USDHC2_VSELECT		0x51e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
> +		fsl,pins = <
> +			IMX95_PAD_SD2_CLK__USDHC2_CLK			0x158e
> +			IMX95_PAD_SD2_CMD__USDHC2_CMD			0x138e
> +			IMX95_PAD_SD2_DATA0__USDHC2_DATA0		0x138e
> +			IMX95_PAD_SD2_DATA1__USDHC2_DATA1		0x138e
> +			IMX95_PAD_SD2_DATA2__USDHC2_DATA2		0x138e
> +			IMX95_PAD_SD2_DATA3__USDHC2_DATA3		0x138e
> +			IMX95_PAD_SD2_VSELECT__USDHC2_VSELECT		0x51e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
> +		fsl,pins = <
> +			IMX95_PAD_SD2_CLK__USDHC2_CLK			0x15fe
> +			IMX95_PAD_SD2_CMD__USDHC2_CMD			0x13fe
> +			IMX95_PAD_SD2_DATA0__USDHC2_DATA0		0x13fe
> +			IMX95_PAD_SD2_DATA1__USDHC2_DATA1		0x13fe
> +			IMX95_PAD_SD2_DATA2__USDHC2_DATA2		0x13fe
> +			IMX95_PAD_SD2_DATA3__USDHC2_DATA3		0x13fe
> +			IMX95_PAD_SD2_VSELECT__USDHC2_VSELECT		0x51e
> +		>;
> +	};
> +};
> 


