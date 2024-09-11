Return-Path: <linux-kernel+bounces-324093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 442249747CE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 03:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BFADB23035
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 01:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1575620B0F;
	Wed, 11 Sep 2024 01:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="ZuWcLi8w"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2120.outbound.protection.outlook.com [40.107.255.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E42CDF5C
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 01:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726018383; cv=fail; b=dgo1UQLlOjm8sDF/Et6SxyNN897dpoMoh1B3+3xbyJylvxs2nK+lujWcLK1kGeZmFAv81rStRfgE3DgXiGDZAK5uhWsJtHK+XzL4y/KTIlInpuUGW9VExq3O9pm4ZGPoX2siHeQmIQyexaNDeo0zPELaDKgF/8sUeo1WCi4JrF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726018383; c=relaxed/simple;
	bh=7svpW9VSYH3RFAbqd0uodywKtMAfhLrTx1QcJAmRL5Y=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PWXhehSXXtqL2LcEudVBAqaL3tPvCzCTFzqkWST4i5uX/cGVb5gGwZfBH2p5/4THmbpnKjX0kMJLT90DnBolUmyh49r1R+u+7Kuqmujpz7wxWOpFcqvIkOhjiict2Yh4PxFNen8B2vv+v5mR5DNW7L0AZXoAeyhpnU4vc57QBJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=ZuWcLi8w; arc=fail smtp.client-ip=40.107.255.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yo9B/87uGV7UQd1h9A6Sy5RPqSXdL34jGPn2Y4G32uSBZrUXwkpGDGTfammYcxn7137f4e6LTJ9S1G/L1Of2eCIaDjCg8TBVjYFcfZj534Qv7kUmNvs8zmp3buHf4kK/4rMHVcgAItsq0F0Bqxe5Vq87ulcG8Nhch/LCFBUPRTtDrpiPLpoZkLbFA9B1PG62oxoTaIBrl1lSFRHvz5o2H134DnaNSU5VBlH17kyS8n6liD0SBrCLpjIVsNqblqVFQWzfRpe+6PtjRA1Dc0WQGd6ZwBImb2VL528eQQDsBQUUpgl8pNKoNgIvMPefpNoNa2QRFw1yBcoNxiw9XxMBIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7svpW9VSYH3RFAbqd0uodywKtMAfhLrTx1QcJAmRL5Y=;
 b=PC5V2aEKRPA76tdpMNUiOYIQqyltWLYfZHCvOug7TbyzytU0DVcANwGXtImPoIQlE8urPz7T3hxHgpSEc7asSju7DJC7IDZOcqtWT5GAQUQZZdf7eqpvWtc7PNrfl4Os9qcsHzyYZI2o5MjfNNBdR0SVYq1yNbB6P2L7iKYCuPJhfXtflyr6ivw7+CUpc4YJbniV5Dm1CxCqxtmbHPLB8QFbbcUJ2J86rpejWdM33UWtbjigViCNYsiGW7vIeIlAyxEFocT4y/GpwpZLptt/nJ/d6ml44nOsyeZxm3QEAwHSRh8r9OB5i5tz70jkt/Kkyr7gOO7salpXZ9NL6EEJvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7svpW9VSYH3RFAbqd0uodywKtMAfhLrTx1QcJAmRL5Y=;
 b=ZuWcLi8wge9wvHRcxRAJXtoqACyFUNH4IWhiAGJ8L7j8K8xxWuDMwbrM5pma95NlACx1EQJ2R7zMDZ9Ku+aD/xZZHxQeyV2ZSCC6mx6eZmZPKH5MHRK+eQJQxmLd/0F8E79G0UeSB6ICle7wK9gqQmFBYq+GsPpu+yaZv6niGdnUBs9C8DXrE9NScbQtQ2wTQvRIn+pGUobrQAlASW6qK/anNmb/THLMoTdPO6ZZodwSN8rt6ZoakJ0A8Q3fupyIwzcUSc+0e0BThKd4MsJWM8P20wJQT2E8WRckNTvL9L6VYOrTX4BvcMLBOBmaPIJT6eb5GziHJcW7Fktz+BgosA==
Received: from TYZPR06MB3933.apcprd06.prod.outlook.com (2603:1096:400:29::9)
 by SG2PR06MB5191.apcprd06.prod.outlook.com (2603:1096:4:1d3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Wed, 11 Sep
 2024 01:32:55 +0000
Received: from TYZPR06MB3933.apcprd06.prod.outlook.com
 ([fe80::9b60:a415:f5ed:a367]) by TYZPR06MB3933.apcprd06.prod.outlook.com
 ([fe80::9b60:a415:f5ed:a367%7]) with mapi id 15.20.7939.022; Wed, 11 Sep 2024
 01:32:55 +0000
From: shawn.shao <shawn.shao@jaguarmicro.com>
To: Jacob Keller <jacob.e.keller@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] lib: Export the parsing functions and related data
 structures of the PLDM library
Thread-Topic: [PATCH v3] lib: Export the parsing functions and related data
 structures of the PLDM library
Thread-Index: AdsD6j18TrXWE9+oSpmi4zCxKqV3qA==
Date: Wed, 11 Sep 2024 01:32:55 +0000
Message-ID:
 <TYZPR06MB393378C4807373C77856F3FE9D9B2@TYZPR06MB3933.apcprd06.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB3933:EE_|SG2PR06MB5191:EE_
x-ms-office365-filtering-correlation-id: 1c6264cd-b364-4147-9dd3-08dcd201a90d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cmk0YU92OU9uNU1IWi9DWmMzcTRDczk5Y0RTdjFSR0JsN2hyV0YrN3lKWVhr?=
 =?utf-8?B?aFZsYTVjamRNdkwyV2xHZU1sS2N0MnpmZ0owZWMvWWx5dE1maVBVMFlSWG1p?=
 =?utf-8?B?YWpoOUN1bHE4K0YzVG1CeFRuNmNCRnZwTi8rTmZYckV1cU5UcHpFQi9BL05L?=
 =?utf-8?B?b2RzTytGV3NhU2M0dlM5RUZkMTZ6VnBlRXA2amlzUjVSampXV3BIcDdyaGcw?=
 =?utf-8?B?bFJuVkNLZ3ZIdjlLVDF0SUJLUlZCVzdRcTNjVWNrYkRIZXlnL3MrWjdoSStT?=
 =?utf-8?B?Z2dmZzZ6VnZaanp1aDZsdHo1c0MvWjJacm1kR2pXTkJ0eVdCMHZ4NW1OcXhJ?=
 =?utf-8?B?L1pmVXkxaFNUUytGNlVvZk8zY1c3eG9DbmsvTTVmc1c5djhBaHJlU0grbmxF?=
 =?utf-8?B?azdyamNMOFlxczNpSzhLQ1RhL0tod1p4eVg5emNxVFQzdzZNblkrQnQvOXJG?=
 =?utf-8?B?SFdQK0Q1dDhWNnBOL05yVkRZTVNJYTJ6N08yMGZFajRncjhtZHpRTmdSakVE?=
 =?utf-8?B?V2p6MjRMOG1EUnpyVkFoaEg0dEE3YUpVZE40NmN1bWU1d1dYdUYwRjFDeThF?=
 =?utf-8?B?RzVJZVc2OVQ5eGljRGtybXhLUWNOZUZsNFcxRURKaEdlL1NjOFZIdWlWSnRO?=
 =?utf-8?B?bUtVV3dUSzRsbXEybEw0N0gwTU13bWJIaStjTGpUcXZkMUpRRTV2elNUZW1i?=
 =?utf-8?B?Z3pIUGR5c1h1SHZkQTVFVDJtUDFydEgvT3N1M0FiMHJVeDlubkQ4VG5qVHlF?=
 =?utf-8?B?OVJ5UXdocTVoNlBQRERrUTNMUjFEM2R6NmkxaE1xMmlvamFUYlgxVXZWV3F2?=
 =?utf-8?B?M1UrelJ4azMrSDBmbDI1dE12OUh6aEJOSWZmVDM4eXpENHRkYnRuL3dENDFE?=
 =?utf-8?B?WG1sanJkMytiZFVkY2s5ck9XRnhUa1N0dzlxNHVPa0dFL3FJMDZjNjV6QTlv?=
 =?utf-8?B?blFwNzg0TWdEWkZWTW1NN3ZZQWdCV0JNODYrOVFjVHNIMmlRYUMvNmhXdVpS?=
 =?utf-8?B?dS9TN2hPc2tmVHVqUE85WHZwNjF1bmQwb3JLaDVxM1hwdURVKzNHQ1hzcENk?=
 =?utf-8?B?TlZDano4djNwY2RMZFhJVmtvUlBLY2JrbmNEZkNHUVlVNHV5VVVReTBNYU14?=
 =?utf-8?B?ZnB6KzB5Ykk4dVBjdkZZWE9UdkliNmo4clhLay9yaG9IQWxhekI1TlZkSFY1?=
 =?utf-8?B?cVJkV2xidGxrT0piUVI3ei9seVVmUVdyTSt4R3pyeXNXc1hDbk9Bb0tnSTBu?=
 =?utf-8?B?bEN4VGhjZmJ6MitCeWo5d1pmTFZwT2czVGhjTXk3NVBmZ3ZKaGI2TkVUSHFS?=
 =?utf-8?B?WXdXalFZUDFtdlVwWlc1bXNwMER5UysySitKd0YrVHVhM0JRZVliamxRb2Iy?=
 =?utf-8?B?dGRobWdPbHc1NGsrcEZ1T25IU2JjOWx4RERLTVE3YVY0elprVzNmeld4T0g2?=
 =?utf-8?B?TnpwY2hxSXFLVGpSdGpHciswNlpxd1YwVUY4a095U1pzRHFoQ284eFJWYWVk?=
 =?utf-8?B?WWFpS3E3VlloLyswVEx4bmg3WGNjWmxqUEhoTEUwY2dhUmdudTNXaGo0SDZC?=
 =?utf-8?B?WGx1ZHFkL0pGQ3U5aG5rK3UrYURsdER5WHZqRjJsay84dnhNcUU0STkwVDJC?=
 =?utf-8?B?L2tlRFIybXVCSGw3TFpsL2lzd0ltd0VsRlFWT3lvZFZURDN0ZDVVbkRocmFQ?=
 =?utf-8?B?OUQ3am9PV0QzNUY3K3JXVHBwV3dXOERuM1J5Z2pXbEsvZHBEWVN4eCtHVTFU?=
 =?utf-8?B?T0ZOOUxWV3ZoRm1BTlB2UW5jTTBsM3NML1oxdXEyRUNHTGFCY2NrWTNrNWdq?=
 =?utf-8?B?UlN5K1dCWXhkd1RhMGpNUXBzck0yMUh4TDMxTlpVZktIakZ5RGtiNjdGcjZ5?=
 =?utf-8?B?N21udnpuQjJKMWxYOGlPa1hDYVhHTE9CdEVMOGFGY01UOVE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB3933.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?STZBV05HWXY4dGdqcDdocjdNdWJMaTVlMG5vcUxOam80WTYzRFMvbWRTNDZM?=
 =?utf-8?B?czJwRXQ0Mm9zVVpYL2k0S3BZM0RlVnZhOUtadnR6S25rOG40UDRyVFNWZnd0?=
 =?utf-8?B?SVArMkNKeEdUUW10R3RKWFBaSzFTZStaVXdlN3JaY1FvM3N2NEMvdEhkaWl3?=
 =?utf-8?B?NWVGaTE5ZUhFZHFLSnNjZ0tvb0J0ZStVTlZ0elVyWXpiWEQ0d05LcWlxdnNL?=
 =?utf-8?B?K0grZnMrak5NS3U1Vm5ub0ZhVUdJb0ZyeVpaQXVxSTZjNVRGNEhZMytscVdY?=
 =?utf-8?B?SWhOYWhTNnMvZi9JK1FJTEhMSURGZnJ5MVF1dFFVNkJkeTdaa2Z0alNsbWxK?=
 =?utf-8?B?NzNTbGZ6Y0dOcWcySTRHbWtCTkJCTEROZyswUFhHU0hDNXJRb2JDd3pHTHNS?=
 =?utf-8?B?d09laHdrUGhhN1Z3L1dHRGRqd3JEYmE4a0s5cTg5dmM3RGphV0JaUTdNMHFq?=
 =?utf-8?B?UG5IS3RCZzFOUkYwZ1RGTHZyYitqcTBzNndRbEVoTFlJY0U1Qld3U1BnNFRW?=
 =?utf-8?B?a2wvOEw4ZXNsVUVtTytqd3c4cmFNSHJzVnFEWVJVNE5lb0RKK2ViQjNtYndD?=
 =?utf-8?B?a2pXSy9IaTBFOEcwSDF5V2hwaUMrd0hMVFdhY0tibWlZOU5MMUUyTWM3Sk1l?=
 =?utf-8?B?ZHhKcUJadE1uYXRSTitLQzNYQUtnblVCajQ4dzNyKzEya3VGYXJ5SlgwOVg5?=
 =?utf-8?B?V2V0Z3RJQjJBWG5DT0ZIWXJmKzlpUU0waXpudGo4ejE0ZTY3TUdNbzlvWkh4?=
 =?utf-8?B?R2NEQXdKZnNvZWpHSEpLSHZnRFkvY2NrUTRtQ1B0MmVqQTJTWFVpSW9RdzdK?=
 =?utf-8?B?RDYyU2dLLzJ3aWlhQWhmZHUra2pJZllwQkZlWkJFVnFuYTh1VjgrcERkdVpT?=
 =?utf-8?B?cml6ekxTOUNDclo3b3VGS3JnUlN2L3VFVnJKMW95Q1B6STR3YWhDTEZOaFYy?=
 =?utf-8?B?cElKVEx4Ti9SRWdxbWdRUVpxT0FQMENMc1h5Y1dnSHpjSFdaNXhGbnl0bHhC?=
 =?utf-8?B?bWJIMzR1WWRqQ2htbkFBRkF3VjVqTFd4U1lWeDA4aTVIWUNyUHF2OGlnTGI3?=
 =?utf-8?B?NGJ2VnliZE13RUYrUS82YXdnb0s0RnRHZGxGRUJDMTBxZ2FHUVpBSjRFZjRu?=
 =?utf-8?B?V0o1MFpTUTh2a3QvcHVRN3IrODBlN0NKTm1XU3BQZHIxWExQblFQMGF4TXBB?=
 =?utf-8?B?OStLdHJiMlhRbUViMnIxQ0psQkthb3JmbUVEVWlYSk1GSGhLc29PM1hpSXFa?=
 =?utf-8?B?L0t5ci9QSjc5b1hUNkt1RFltc0kwRlNjSldzR0N4ampMNFlPd1ROMXFYd1ZQ?=
 =?utf-8?B?My9LQzlVNFB3UktIRTNpcmdZVXJVckFBYnRiK3gyNnVRM0xZM0hRbVhKQklU?=
 =?utf-8?B?SVFWZjZNeG9DSXl5Q0FXOGJkd0RmREVrV1RkRzNsL0ZsbG5vUURURVZhSUlP?=
 =?utf-8?B?eVhtYlNGSDY1cFdKVFkwK2RXby8rNnVHTjMzUXQ5V1lHa3pHR0hVU0hZcW9r?=
 =?utf-8?B?L0xhYnR3ZGFFUmRNZ1RiYTRxWExKZ2lXYWJlWGJva1VUcW9lTldSS2dMU0J0?=
 =?utf-8?B?TjFmVklNZEo3SzgxTEs2dHd0ekJJS1pHcVlWQkIvZXFUaGRvdDNodXY4d3d5?=
 =?utf-8?B?YTBUelNBTjFmcmRtdFVMN2x6aTdOSWo0Vjl5M1B6djlvSWhOYXM1TnJSQXFw?=
 =?utf-8?B?dkpPd29TUzVSTjViMVVOd20rSHRSTWh5My9ROWtaMzJmdnRaMGthaXFMd0Va?=
 =?utf-8?B?VVNNSTQzM3FiSkViZksyQ1RiUlhqekVCK3pHaFVoNTNpcXhLc1JaeWZieWEw?=
 =?utf-8?B?NXBFVnB4YTcvcVBkM21XR2gzMW5sbkhlekx4WTRxYWJZclpVMlAyZTNFc0Q3?=
 =?utf-8?B?NWU1cWxHSnBtQnlMUHNpUWRsWFJsV0daaEFOTEJEQlExRmFtdkFJa1FHK2hR?=
 =?utf-8?B?WmRhOTNHMGozODFtWWh4RUFmMHYwaUx4R2x5UkVSNFQ1Z1Q1WnlTWjdHSkx2?=
 =?utf-8?B?VkZnMkloTWhJenRRZ01mbnNIT0c1WFM2TVpiUWRNb3FGekhxcFlNWnlRUkxx?=
 =?utf-8?B?ZzRWekdmcC9zU09zU0V2U1NsOE9WT2llUWVqaUh0WUR1OTVBcFVNeFhsWmcv?=
 =?utf-8?Q?yFA0iWDvHy8Wfqby+tUuCj7NH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB3933.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c6264cd-b364-4147-9dd3-08dcd201a90d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2024 01:32:55.2601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qY01nPpmi91Fpu6XBCPB8EFLjNObFQpDkb5kVvJpWr0tCXq7br2KAodrEjgrbnEEeqmDMSVJ25N8CBsvKyxnzb7PTTOiGdUvSzcAr7xSmzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5191

PiA+T24gOS85LzIwMjQgNzo0NyBQTSwgU2hhd24uU2hhbyB3cm90ZToNCj4gPiBGcm9tOiBTaGF3
biBTaGFvIDxzaGF3bi5zaGFvQGphZ3Vhcm1pY3JvLmNvbT4NCj4gPg0KPiA+IHYxIC0+IHYyOiBV
cGRhdGVkIHRoZSBjb21taXQgbWVzc2FnZSwgYWRkZWQgYSBkZXNjcmlwdGlvbg0KPiA+ICAgICAg
IG9mIHRoZSBjaGFuZ2VzIHJlbGF0ZWQgdG8gYERldmljZVVwZGF0ZU9wdGlvbkZsYWdzYCwgZXRj
Lg0KPiA+IHYyIC0+IHYzOiBzZXBhcmF0ZSB0aGUgZGV2aWNlX3VwZGF0ZV9mbGFncyBpbnRvIGFu
b3RoZXIgcGF0Y2gNCj4gPg0KPiANCj4gTWlub3Igbml0LCBub3Qgd29ydGggYSByZS1yb2xsIG9u
IGl0cyBvd24sIGJ1dCB0aGUgbmV3IHRpdGxlIGRvZXMgbm90DQo+IG1lbnRpb24gcGxkbWZ3Lg0K
DQpEdWUgdG8gdGhlIHVzZSBvZiBhIGxpbmUgYnJlYWsgaW4gdGhlIGVtYWlsIHN1YmplY3QsIHRo
ZSB0aXRsZSB3YXMgdHJ1bmNhdGVkLiANClRoaXMgd2FzIG15IG92ZXJzaWdodCwgYW5kIEkgaGF2
ZSBub3cgY29ycmVjdGVkIGl0LiBUaGFuayB5b3UhDQpQbGVhc2UgZmluZCB0aGUgY29ycmVjdGVk
IHBhdGNoIGF0IHRoZSBmb2xsb3dpbmcgbGluazoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2Fs
bC8yMDI0MDkxMTAxMjQ0NC4xOTc5LTEtc2hhd24uc2hhb0BqYWd1YXJtaWNyby5jb20vDQoNCj4g
PiBUaGUgUExETSBsaWJyYXJ5IGlzIHVzZWQgdG8gaW1wbGVtZW50IGZpcm13YXJlIHVwZ3JhZGVz
LA0KPiA+IGJ1dCB0aGUgY3VycmVudCBsaWJyYXJ5IGZ1bmN0aW9ucyBvbmx5IHN1cHBvcnQgdGhl
DQo+ID4gYHBsZG1md19mbGFzaF9pbWFnZWAgZnVuY3Rpb24gdG8gY29tcGxldGUgYSBmaXhlZA0K
PiA+IHByb2Nlc3Mgb2YgcGFyc2luZywgc2VuZGluZyBkYXRhIHRvIHRoZSBiYWNrZW5kLA0KPiA+
IGFuZCBmbGFzaGluZyAoYWxsb3dpbmcgdXNlcnMgdG8gaW1wbGVtZW50IGN1c3RvbQ0KPiA+IGxv
Z2ljIHVzaW5nIGBwbGRtZndfb3BzYCkuIEhvd2V2ZXIsIHRoaXMgcG9zZXMNCj4gPiBzaWduaWZp
Y2FudCBjaGFsbGVuZ2VzIGZvciBkZXZpY2UgdmVuZG9ycyB1c2luZw0KPiA+IFBMRE0gZm9yIGZp
cm13YXJlIHVwZ3JhZGVzLg0KPiA+IFRoZSBmb2xsb3dpbmcgc2NlbmFyaW9zIGFyZSBub3Qgc3Vw
cG9ydGVkOg0KPiA+IDEuIE9ubHkgdXNpbmcgdGhlIFBMRE0gcGFyc2luZyBmdW5jdGlvbnMsIGFz
IHRoZQ0KPiA+ICAgIGN1cnJlbnQgbGlicmFyeSBkb2VzIG5vdCBzdXBwb3J0IHRoaXMgb3BlcmF0
aW9uLg0KPiA+IDIuIFRoZSBmaXJtd2FyZSB1cGdyYWRlIHByb2Nlc3MgZGlmZmVycyBmcm9tIHRo
aXMNCj4gPiAgICBmaXhlZCBmbG93ICh0aGUgZmlybXdhcmUgdXBncmFkZSBwcm9jZXNzIG1heQ0K
PiA+ICAgIHZhcnkgYWNyb3NzIGRpZmZlcmVudCB2ZW5kb3JzKS4NCj4gPiAgICAgICB8LT4gcGxk
bWZ3X2ZsYXNoX2ltYWdlDQo+ID4gICAgICAgICAgICAgICB8LT4gcGxkbV9wYXJzZV9pbWFnZQ0K
PiA+ICAgICAgICAgICAgICAgICAgICAgICB8LT4gcGxkbV9wYXJzZV9oZWFkZXINCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgfC0+IHBsZG1fcGFyc2VfcmVjb3Jkcw0KPiA+ICAgICAgICAgICAg
ICAgICAgICAgICB8LT4gcGxkbV9wYXJzZV9jb21wb25lbnRzDQo+ID4gICAgICAgICAgICAgICAg
ICAgICAgIC0+IHBsZG1fdmVyaWZ5X2hlYWRlcl9jcmMNCj4gPiAgICAgICAgICAgICAgIHwtPiBw
bGRtX2ZpbmRfbWF0Y2hpbmdfcmVjb3JkICh4eHhfbWF0Y2hfcmVjb3JkKQ0KPiA+ICAgICAgICAg
ICAgICAgfC0+IHBsZG1fc2VuZF9wYWNrYWdlX2RhdGEgKHh4eF9zZW5kX3BhY2thZ2VfZGF0YSkN
Cj4gPiAgICAgICAgICAgICAgIHwtPiBwbGRtX3NlbmRfY29tcG9uZW50X3RhYmxlcw0KPiAoeHh4
X3NlbmRfcGFja2FnZV9kYXRhKQ0KPiA+ICAgICAgICAgICAgICAgfC0+IHBsZG1fZmxhc2hfY29t
cG9uZW50cyAoeHh4X2ZsYXNoX2NvbXBvbmVudCkNCj4gPiAgICAgICAgICAgICAgIHwtPiBwbGRt
X2ZpbmFsaXplX3VwZGF0ZSAoeHh4X2ZpbmFsaXplX3VwZGF0ZSkNCj4gPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IFNoYXduIFNoYW8gPHNoYXduLnNoYW9AamFndWFybWljcm8uY29tPg0KPiA+IC0tLQ0K
PiANCj4gDQo+IFJldmlld2VkLWJ5OiBKYWNvYiBLZWxsZXIgPGphY29iLmUua2VsbGVyQGludGVs
LmNvbT4NCg0KDQpUaGFua3MhDQo=

