Return-Path: <linux-kernel+bounces-408072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 350EC9C7A19
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 18:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6F551F23B65
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 17:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C57201113;
	Wed, 13 Nov 2024 17:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="C3BhUyLm"
Received: from alln-iport-5.cisco.com (alln-iport-5.cisco.com [173.37.142.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C4C1632E2
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 17:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=173.37.142.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731519733; cv=fail; b=K/amwPVxUsE20GVFBuaSiHKBOmqAWTYXTBijDEfeWsXVcOojy+FOEcekteZo9rxP0eL6g/NRzqQpLVYwpPBVAKaRJb/Kyy0KN7PykTIIlYYF1gOMYGTVlvbdZYiUcbRI2rmrPRI7iQXdXjQqFLyC8gbcSECT7hyN3UohETEbcqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731519733; c=relaxed/simple;
	bh=5LUUpVsFCB8KUIaFt/aVtO/u3FvuFCELWodRXWujxRA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kPjxrRsUCC1rrLrx6lqmJctIGrhu1MJ9JdYYc4Mi6nRKFrRU6Rsq/SzsmSm8XVHB1tGX1+8c1uxwhYjMGg3sdcPXgCo7TpVUJS4YU6Itl1KUDGWbhSCKmSOBasGt6kh8BhYh87vF5qU5LsY8LcPvsOrPVMAb06ySdboBYtkrRZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=C3BhUyLm; arc=fail smtp.client-ip=173.37.142.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=3988; q=dns/txt; s=iport;
  t=1731519730; x=1732729330;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5LUUpVsFCB8KUIaFt/aVtO/u3FvuFCELWodRXWujxRA=;
  b=C3BhUyLmKXzLjq3bki5G6Gp/qqqsKlBv++Cw63TaGltvXw2htfcz1GkR
   uiH5wc/TFcjE2UvzFJYABndqsnhA/qxDAJnn2dIPgObeQEicECChVhBQk
   fIkOd4xNQyqCgFWIRx7xpc66mu9EbbFCAWj04aTspWyfVhG8GPx91DsPt
   A=;
X-CSE-ConnectionGUID: r1yUiOgGTuScG0XoW7U9Rg==
X-CSE-MsgGUID: 8bQUqzMhSrOPPuMvJGhn7w==
X-IPAS-Result: =?us-ascii?q?A0AEAABy4zRnj5IQJK1aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUAlgRoGAQEBCwGBcVJ7gR5IhFWDTAOETl+GUYIhA4V6jFMciyyBfg8BA?=
 =?us-ascii?q?QENAkQEAQGFBwIWii0CJjQJDgECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQUBA?=
 =?us-ascii?q?QECAQcFFAEBAQEBATkFDjuGCIZbAQEBAxIREUUQAgEIGAICJgICAg4hFAEQA?=
 =?us-ascii?q?gQOBSKCX4JlAwGkaAGBQAKKK3qBMoEB4CAYgQIuAYhLAYFsg32EdycbgUlEh?=
 =?us-ascii?q?D8+hFqDRIJpBIJBaBI7gTyBNnYlgSaEJYNMiWwNjxIJSXscA1khEQFLCjUMO?=
 =?us-ascii?q?CtGISwDglKCOIFSglWBFIM8gV4FNwqDCYE0OgINAoJFcx+HaYELg2KDTYEZg?=
 =?us-ascii?q?XB0HUADeD01FBsGPZ9KRoJsRAiBU4EUfkMClgwBSa8oCoQaoiCDcY0BmUguh?=
 =?us-ascii?q?1uQbqNhhRgCBAIEBQIPAQEGgWc6gVtwFRohgmdSGQ+OLQ0JyUJ4OwIHCwEBA?=
 =?us-ascii?q?wmQSQEB?=
IronPort-PHdr: A9a23:tL6AVh1dIPnLTPAFsmDPmlBlVkEcU/3cNwoR7N8gk71RN/3l9JX5N
 0uZ7vJo3xfFXoTevupNkPGe87vhVmoJ/YubvTgcfYZNWR4IhYRenwEpDMOfT0yuBPXrdCc9W
 s9FUTdY
IronPort-Data: A9a23:HV2fla5LZRd6YHE1cb1DEQxRtDbHchMFZxGqfqrLsTDasY5as4F+v
 mtOXTjVaf6KMDD9L90lO4zi/UhTupCEx98wHgA/qSAzZn8b8sCt6fZ1gavT04J+CuWZESqLO
 u1HMoGowPgcFyGa/lH1dOC89RGQ7InQLpLkEunIJyttcgFtTSYlmHpLlvUw6mJSqYDR7zil5
 5Wr+aUzBHf/g2QoaztNsPrZwP9SlK2aVA0w7wRWic9j5Dcyp1FNZLoDKKe4KWfPQ4U8NoaSW
 +bZwbilyXjS9hErB8nNuu6TnpoiG+O60aCm0xK6aoD66vRwjnVaPpUTaJLwXXxqZwChxLid/
 jniWauYEm/FNoWU8AgUvoIx/ytWZcWq85efSZSzXFD6I0DuKxPRL/tS4E4eJ9QJx+dQDk5y6
 McTB2g9aS/curOMz+fuIgVsrpxLwMjDNYcbvDRkiDreF/tjGcGFSKTR7tge1zA17ixMNa+BP
 IxCN3w2MlKZP0Mn1lQ/UPrSmM+kj3/+fjlHoXqepLE85C7YywkZPL3Fa4qNKoPUGZwE9qqej
 jLMxlngEDQaD8a48QKY12yOqe/JwjyuDer+E5Xjq6Y12wfMroAJMzUSVF2msby6h1S4VtZ3N
 UMZ4GwtoLI0+UjtScPyNyBUu1aNuhoaHt4VGOog5UTVm+zf4h2SAS4PSTsphMEaWNEeX2U76
 16ukPzVGAdkn+WlTk3Cy+auombnUcQKFlMqaSgBRAoDxtDspoAvkx7CJuqP9obr0rUZ/hmun
 li3QDgCulkFsSIcO0yGEbH7b9CE+sihou0dv1m/soeZAuVRP9HNi2uAsgSz0Bq4BNzFJmRtR
 VBd8yRk0MgADIuWiAuGS/gXEbei6p6taWKH2AI+QMd+rG/2oBZPmLy8Bhkjei+F1e5ZKFfUj
 LP74FI5CGJ7ZSHzNPQmOepd9exxnfG7S7wJqcw4nvIVP8AuL1XYlM2fTUWRxGvq2FM9ir0yP
 IzTcMCnSx4n5VdPklKLqxMm+eZznEgWnDqLLbiilkjP+eTFPha9F+xaWGZim8hlt8toVi2Jq
 I4Hb6NnCnx3DIXDX8Ug2dVPdQ5adiNrWcmeRg4+XrfrHzeK0VoJUpf56bggYIdi2a9Sk4/1E
 ruVAye0FHKXaaX7FDi3
IronPort-HdrOrdr: A9a23:chp76asa1CH95MFIeXbfF2Gp7skCJIAji2hC6mlwRA09TyXGrb
 HMoB1L73/JYWgqOU3IwerwR5VoIUmxyXcH2/huAV7CZniqhILGFvAY0WKP+UyFJ8S6zJ8g6U
 4CSdkzNDSTNykBsS+S2mDReLhQoqjjzEnrv5ai854Hd3ANV0gU1XYANu/tKDwOeOApP+tfKL
 OsouB8i36Lf3MRYs6nBn8DcdTiirTw/q7OUFotPTJizBOBow+JxdfBfiRw2C1wbxp/hZMZtU
 TVmQ3w4auu99uhzAXH6mPV55NK3PP819pqHqW3+4YoAwSprjztSJVqWrWEsjxwivqo8kwWnN
 7FpAplF9hv6knWYnq+rXLWqkjdOXcVmj/fIG2j8DneSP/CNXcH4g169MZkmy7imgkdVRdHoe
 V2Niyixtxq5Fj77VXADpDzJmFXfwyP0DUfeSp5tQ0GbWPYA4Uh9LA37QdbFowNEzn9751iGO
 5yDNvE7PITal+CaWvF11MfiOBEc05DaCtueHJy8/C9wnxThjR03kEYzMsQkjMJ8488UYBN46
 DBPr5znL9DQ8cKZeYlbd1xC/efGyjIW1bBIWiSKVPoGOUOPG/MsYf+5PEw6PuxcJIFwZMukN
 DKUU9et2Q1Z0XyYPf+l6Fj41TIWiGwTD7twsZR69xwvaD9XqPiNWmZRFUng6Kb0oIi6w3gKo
 KO0b5tcorexDHVaPV0NiXFKutvFUU=
X-Talos-CUID: =?us-ascii?q?9a23=3AI2cYUmmzhqsp5ro3vZc+9KVmtHvXOWeE3UrRBEC?=
 =?us-ascii?q?XNXtSQ5LNeVivp541qcU7zg=3D=3D?=
X-Talos-MUID: 9a23:7UMFeAsrISCDSKBHBM2n1DtbCd56xqSVEmc1qYgjpeurNSovJGLI
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-l-core-09.cisco.com ([173.36.16.146])
  by alln-iport-5.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 13 Nov 2024 17:42:03 +0000
Received: from alln-opgw-1.cisco.com (alln-opgw-1.cisco.com [173.37.147.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by alln-l-core-09.cisco.com (Postfix) with ESMTPS id EA85818000230
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 17:42:02 +0000 (GMT)
X-CSE-ConnectionGUID: z/xVG9nmRCqkjoFor0d4vg==
X-CSE-MsgGUID: X/MZ/bJDSTKFLgk+oF4HoA==
Authentication-Results: alln-opgw-1.cisco.com; dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.12,151,1728950400"; 
   d="scan'208";a="40156241"
Received: from mail-bn8nam11lp2175.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.175])
  by alln-opgw-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 13 Nov 2024 17:42:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nVE5G0PUnU2NGka1vCEcHNO+BwnDvSo0wLrQzjgRSEmXRn5TOPH8G30S10TMAgpOVTFM0CcQvf6c5jmTl0tTK/C76dbe85aUDioyhVcpdtivhPdLdsTqG4njA9bE0aoFyzDpq6NZTeAwuGlzGaGV67azjPsg/c238lnvEILnjlb6tOas4FUJQuME21HMxkN93QEFo0svl4qeCqP+K4W23nCMOiDmaiQg90H6DkXT3cbpCwUxxcAlZskSqO2dq7MVI2t2dzc2bTdK7RYmboBUxQf5LtZcoyt6yoyrV/lCgSwpJNA2u+rzszX2VfPHKQJlnVENGrv62VFy3e0zdKElYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5LUUpVsFCB8KUIaFt/aVtO/u3FvuFCELWodRXWujxRA=;
 b=G2vgwepuadDFSMRW6SZeCIhU8L0ZH7eZjzgajxIUC/SXb3OdS7wCtLWkcRoWv5+CyWrGiy30bZ6xsaBEoswh3Rsv26p12E1673Umc+dU6exKssdaa5LVl80KYtXq0yDCidWCTHIaM3mMpvEm7OXNijnHcu8jqaeH/RSXzHHqO9QQJ6wKjyNjG+LdMbzatjjWxgxprAPjoknKL/YCRch9gy1XQ4o3BIzhKMM+bKybH2jryyvcTahwgnPLa8kvE7ocYgcOudVrEqttB2C1S2IJ9ryJscc2k204GYXHMHBX+Fp/C4XbxSed4ijrWkUgGD1l5p7Vb2qN6P6zuGWVwDvPqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from LV8PR11MB8770.namprd11.prod.outlook.com (2603:10b6:408:202::19)
 by SA1PR11MB6806.namprd11.prod.outlook.com (2603:10b6:806:24d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Wed, 13 Nov
 2024 17:41:59 +0000
Received: from LV8PR11MB8770.namprd11.prod.outlook.com
 ([fe80::3e74:9751:b164:4d46]) by LV8PR11MB8770.namprd11.prod.outlook.com
 ([fe80::3e74:9751:b164:4d46%6]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 17:41:59 +0000
From: "Daniel Walker (danielwa)" <danielwa@cisco.com>
To: Hans de Goede <hdegoede@redhat.com>
CC: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, =?utf-8?B?SWxwbyBK77+9cnZpbmVu?=
	<ilpo.jarvinen@linux.intel.com>, Klara Modin <klarasmodin@gmail.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Danil Rybakov
	<danilrybakov249@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "xe-linux-external(mailer list)"
	<xe-linux-external@cisco.com>
Subject: Re: platform/x86: p2sb: Allow p2sb_bar() calls during PCI device
 probe
Thread-Topic: platform/x86: p2sb: Allow p2sb_bar() calls during PCI device
 probe
Thread-Index: AQHbNeKxizzLej0qw02u6pHMIY1jfA==
Date: Wed, 13 Nov 2024 17:41:59 +0000
Message-ID: <ZzTk5kyPa5kUxA+f@goliath>
References: <ZzTI+biIUTvFT6NC@goliath>
 <cd1cedcc-c9b8-4f3c-ac83-4b0c0ba52a82@redhat.com>
 <82ab3d06-40e6-41dd-bb43-9179d4497313@redhat.com>
 <2c828592-dbdd-4cd4-b366-70797d63329d@redhat.com>
In-Reply-To: <2c828592-dbdd-4cd4-b366-70797d63329d@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR11MB8770:EE_|SA1PR11MB6806:EE_
x-ms-office365-filtering-correlation-id: 97ac7687-dc33-438c-3858-08dd040a79a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bnRPWGJURktWK3ZIMm1JTDF3ZnkweEhOcXAzN0p1cEQ1NHQzejVEeXVLK2pM?=
 =?utf-8?B?TlRoeHNhbXN3eEJVT1I3NE05SWhpL0laNk8xRHlpaHo0Q0tsa2hmR1ozUDIw?=
 =?utf-8?B?QllLWU5iQlNKWTRja3gyRHJYb0cySG03RUx0ZlEwZ3luRFRPekVpbk5TYm40?=
 =?utf-8?B?UW1aMXBGY2E1ZDJRWWRscm9kcHlHRnBFaStZT1hKVVFDb1dmTkEyS09keFpa?=
 =?utf-8?B?QUF2T1FEbm8zWkhzMllZWnErNWl1M3BiSW1lVnkzSXdSb0hyb092ZzlKYlZU?=
 =?utf-8?B?bUNNTk5pT3g0bHdjZitaSzRDM1RyL1BYVXJZZTNWS2VZMDEvd0RTYlNVL3Uw?=
 =?utf-8?B?QkFLSHFVV1FOS0xRdXpwakhlWkNZaG0yY0kweUJjUmdLVDdsdXhkaWNUaEx3?=
 =?utf-8?B?dFljTnpZWWgvWVF1Q0VWd09FNlZaRWZoc3RvL09malZUWDFlREdEcHY5VDRL?=
 =?utf-8?B?MHZ2QytkVUJPT0tzRTlETks0THBySERvWlFabzFKQ25LVWNOc2V2VkJQbmhw?=
 =?utf-8?B?d01XaFNhcTdCdS9xWVlqTlpCTFd3ZUhUWUU5UVh0TGFwNmJrRmtYTGNEY2lN?=
 =?utf-8?B?MGVKMUovL09hYXhwQUZhNUZVOWdJeFUxRXpxaWcyY1BMQ095SGM4dWNxdndr?=
 =?utf-8?B?MFQ5KzRBcVRycThqbzlxWjM2WkU4Vk5LK2NTbmpBejFuSE81eldGUVZESmVu?=
 =?utf-8?B?aVFmR01ENld3c2UyMm81Mml5bElSbDJ0ZTBuNm05Mkd0cDRjMTlKdW1oaXhh?=
 =?utf-8?B?NFVQdkF5aUZjRkViOU5KVlBTT2k0YklKd1lLVEhiTjEvVnlQU2RsNGd4VU1G?=
 =?utf-8?B?Y0tZMnB4aG1kVGl3UFRVMzJOQ25tbGVVQWtWNU5pN3BuMmxrczNjYVNGa1BB?=
 =?utf-8?B?SVRKdlBvb2hGT09sTTc2N2E2NzhvOVJTTVNFdWJNMGdNNXA5bWVlazNXTTVE?=
 =?utf-8?B?THZBMVM1UjZna0c1ODBCV21KU2JtRnA4eCt6U1puYWFUMzdEb0wwSElDbDZR?=
 =?utf-8?B?NEdWNm1ScEtvYTgxa1R6Qmd1TFIwdHpZRW9NN3UvSzBSVU1ZQnoxd2hvN1B0?=
 =?utf-8?B?NEVwR2x6MGNiam1UZWR3SXdKYW5lL1pTTzJ2UkZObmRTcU15S01nYlFHeXBs?=
 =?utf-8?B?RW8ySVVLaS9peW9adEpDeDcxYUNVT2x0K2o4ai8reGxCVCtNWktRM0ZJWGoz?=
 =?utf-8?B?Z3JMZnhHTmlKRmo4RG1mbEVRbm1TZmMrbnowajNIbVc2U3BTd1ZrS3NHR1RX?=
 =?utf-8?B?WTlKK2ZYWXFmZ1liSWtpdWlxSEdlVVMyR3ZSTGgySkM1aDl3MXdxUTBPbkVY?=
 =?utf-8?B?eldSejBVcHdNc2dDOW1sdjlpc0pZT3RwdzFGME9TQUErV2E4b095ZTljZzE5?=
 =?utf-8?B?bkNoUXpqMThNLzhqWnhJM1JLcVdlQjVtNEl5R3ozWkZMM3hPOXF2RmtWQXZk?=
 =?utf-8?B?emQrS3N1K1Uzdnp1RkNZV3BSMk82R292d0NJbnZKak9MSkIzb2xRdFNVVEJM?=
 =?utf-8?B?d3kyUGZMYkcxQ3AwcUJCQzYyUkF0YkZOVzM5T0FRaWZGNjFRTU43UW1sakRO?=
 =?utf-8?B?TnYwUFhyd1lBV1ZkTXN1Tlc4bHVGdGFYeHdheTVYcjZBcllITTNQRXZmZDA1?=
 =?utf-8?B?S2lUb0xhMnZHMmlmSmNRazhlaURIaUlaMlVwbDR6YWlrQ0RaNXV5RU40Sk9m?=
 =?utf-8?B?RmRCYnBsZU9nRXFvRVhGa1ZVMFdsZ3VGbzBUbUxKdTBzNFphTTk2OXNXTEhl?=
 =?utf-8?B?bGM5dkNBSVJqeGVjUERXZmZ4TE1GUUh6SE5HczFPSE5DT1ZOTzBacmUyeUJy?=
 =?utf-8?Q?o8bzKq2nYRHDuUgBN3jk9SvJo6kg3gl9H0ICc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8770.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QUdISUc2SHcwaVI4LzZtNWFRYkRhTkdHblhhcHhmamovZllaYUoydnFkT0VM?=
 =?utf-8?B?VHpQQlh5d2cvNmhtOVRBdEJseVFCUWJWenJhMTV2NHh3YmVyY0NVSkVZSk53?=
 =?utf-8?B?VDMyNmJ6MU4yay9TdGVhaVE1S0ZPdjBubGVxZEg1TTY4V3lrMTRNMVpxb084?=
 =?utf-8?B?dEYydmlBbjUrL2xJUVdvWExjZFNCMVU1eWl4elZScW1HaHFLdW9RakhSN1J6?=
 =?utf-8?B?Ni9OY0UxcG1MOTdndTZkUDNNY0JFV0gyZUhZRUZrTlFSRHArc25yT2RtZFgr?=
 =?utf-8?B?bHNDdkloeXVMbGpZK3JQRDVLN0lMbUhVeklnRUZIdHBKTDI1K1ZPSXRQbDR5?=
 =?utf-8?B?am9hN1RURkJkNDFNM3BwUFdYSnBsa1ltMVY0aFY1RUdDK3NuMDFNdTVMOFhD?=
 =?utf-8?B?SEFtM24rODR6cmhsT1NIYngxYmtzSXJwS1IrQzlXdnhjMTJ6QklyK3ZldWZ3?=
 =?utf-8?B?TlVUTFJZU1BuNy9kcDMrTnJjbWtJZHdsWHgvQU1KNlRVR200Wko1UWtKb2ty?=
 =?utf-8?B?aXVNdHpzM0JhSFRmM2Ewb3g2MnBKNjNGWS9oVWphN0pOUWhoTWdMaXU5K2xO?=
 =?utf-8?B?SndpOWZTVmJTMXFVcGYvQW1pVUk4eUtWdVVzYWhBWTV3ZXE2aTAxdCtrZzc1?=
 =?utf-8?B?MDU0TXNDbG1FM2J3SG1aVzdwbW5RZ25tUDczTE9tcVJHVEE5THlWbkJMbUVF?=
 =?utf-8?B?ZC93TS9ORmh0c1dFcndKOExoVlJBL1BxWkZIc2Q1eUh4YmE3NDNraysxZ1c2?=
 =?utf-8?B?VVcwdkg3NU15V3ZkTTFSN1FEQ1c3R0RmWnd4RkhhREhnNUo5M21KQzdMOHZD?=
 =?utf-8?B?WmN2Y1B2SE4zSThkRW4raEJVa0NYUUJhZjk0Um1JWWhSZlhXNkg0Y09DaS8r?=
 =?utf-8?B?c1dScHQ0bTFqaytUWkh3aDAwNDREaS8xYklOVHU0N2VTbEsvdll5T2MvY2J6?=
 =?utf-8?B?eXV2UTJ1dXVXTUJYeEZQbnJxSytkcytBWE9zZnlDcFF1MGpGTUREYW5YUEc1?=
 =?utf-8?B?dkwzM2FYcDVraDk1a1VnV0ZYYUtMVFZscEMwd1lOaitWeWJnTW85WktlaWtO?=
 =?utf-8?B?djZkZlo0djIwdE02VU1zRnNtS1hBNnNzeUdBYlBsbkhmMnN6azdDREJlcEp2?=
 =?utf-8?B?TDNSTHJEN0ZMVVZSU1RueENBTE9WbXp3VkhWRGtDYTNibXpMKzlpejBXL0Ir?=
 =?utf-8?B?Q3UxQlliVUxKU1RKbGJ6YkViMTQ1VG5QN0hnRGdFLzU1UDdlVnRDYmxITVJQ?=
 =?utf-8?B?UFRKeXFjZ1pNNXdnMTVXLzJ1eEhDczJMUWpPRkwwTE1XNzZwdW1YWk5rcWlL?=
 =?utf-8?B?bTdrQ0huRmFLVHVNc0Y0WFFNdU9GOEJITUtaV0hhV1l2bk1JUmZiQ05qRS9X?=
 =?utf-8?B?MDdMWXFpYnluMUlJQnVtalQvQS8vLzY1Yi9oU3dvaHAxMFAvaEJWMVpRTXcv?=
 =?utf-8?B?elhTVzNEaG9jSG1hOG0zVlUvdU54V3M4VjgwOTZpU1R4UnBJaVFpelAxbFNX?=
 =?utf-8?B?dTMzVDM3a0tFTjBpdmEvdkJlY2s0NVl5TnViQ2s5VmZLSmM5cDI2OFp5VTlz?=
 =?utf-8?B?WXFEUjdkRWhMSjRZa0x3bW92ODREdWR3bUF4eFA1OWlMMGlISHIzNSszRGdl?=
 =?utf-8?B?KzRCbFZnTFcwWEp0bFBFYWpJdWNKMm83eCtqNkc0cmhuaE1qUzExdWhEOGhq?=
 =?utf-8?B?aUVqL2k1TVg0WUQwUVlWc210MFUxOVcvOWtLWXFRbW9hU2R4QnF2U1dhYWFN?=
 =?utf-8?B?RGRCM2R0K0xKL2pvbVJvUDNFZmxXbUtKTUJxNDR3dElKOG1JQ0VjVloyZVVs?=
 =?utf-8?B?M2FCSHlGMFVuczFSRVFBdGM2bG1mWVF0anFNY3VYSlFwdkkxWktGK1VYWDFM?=
 =?utf-8?B?ZVkvTlZXL1pPQ0krdm44RUdUS0xqQmdDYWxEWlRBa3lxaTlkZERJRHNoNjlN?=
 =?utf-8?B?VzJ0dmtTbFV1bU9FdzBKb3g4ZEhHUzN4a2J4dHZ5Ly8xZ3p1YlU1VzNtbk5K?=
 =?utf-8?B?aThtMnl4ZjNmNldFYzl0ak1XdGMrY1NtdjhWNXlSeDM3Vk91ZmxzNVZxUDFQ?=
 =?utf-8?B?WERrMC9lbzhlcXMyYzhWY2szWVg4YmRRVmMzL3lDS1Q1MC84bTlZUkUybFZB?=
 =?utf-8?Q?5waGyCPzlOImDYF8ocvpQipJn?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B59D18E232882D4F84EB0435C9359869@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8770.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97ac7687-dc33-438c-3858-08dd040a79a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 17:41:59.1777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uTnun7tpEfywOkcHLTL738iAFRH9jUMzl4B6f7V5YwwZ0q2RfLG98rSo0Cm/eTxPLcKOXNEP80OuGdu8j+CPrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6806

T24gV2VkLCBOb3YgMTMsIDIwMjQgYXQgMDY6MDQ6NDRQTSArMDEwMCwgSGFucyBkZSBHb2VkZSB3
cm90ZToNCj4gSGksDQo+IA0KPiBPbiAxMy1Ob3YtMjQgNTozMyBQTSwgSGFucyBkZSBHb2VkZSB3
cm90ZToNCj4gPiBIaSwNCj4gPiANCj4gPiBPbiAxMy1Ob3YtMjQgNToyNCBQTSwgSGFucyBkZSBH
b2VkZSB3cm90ZToNCj4gPj4gSGksDQo+ID4+DQo+ID4+IE9uIDEzLU5vdi0yNCA0OjQyIFBNLCBE
YW5pZWwgV2Fsa2VyIChkYW5pZWx3YSkgd3JvdGU6DQo+ID4+Pg0KPiA+Pj4gSGksDQo+ID4+Pg0K
PiA+Pj4gSSBiaXNlY3RlZCBhbiBpc3N1ZSBvZiBhIG1pc3NpbmcgcGNpIGRldmljZSB0byBjb21t
aXQgMjg0MTYzMSB0aGUgY29tbWl0IHRpdGxlDQo+ID4+PiBpbiB0aGUgc3ViamVjdCBsaW5lIHdo
aWNoIHdhcyBpbmNsdWRlZCBpbiB2Ni4xIHN0YWJsZSBicmFuY2guDQo+ID4+Pg0KPiA+Pj4gVGhl
cmUgd2FzIGEgbGF0ZXIgZml4IGZvciBhIHNpbWlsYXIgbWlzc2luZyBwY2kgZGV2aWNlIGNvbW1p
dCAzNmM2NzZlMiB3aGljaA0KPiA+Pj4gYXBwZWFycyB0byBiZSBmb3IgR29sZG1vbnQvQXBvbGxv
IExha2UuIFRoZSBoYXJkd2FyZSBJJ20gdXNpbmcgaXMNCj4gPj4+IEdvbGRtb250L0RlbnZlcnRv
bi4gVGhpcyBmaXggZGlkIG5vdCBhcHBlYXIgdG8gY2hhbmdlIHRoZSBiZWhhdmlvciBJJ20gc2Vl
aW5nLg0KPiA+Pj4NCj4gPj4+IFRoZSBwY2kgZGV2aWNlIHdoaWNoIGlzIGRpc2FwcGVhcmluZyBp
cyBhIGN1c3RvbSBncGlvIGRldmljZS4NCj4gPj4+DQo+ID4+PiBJIHRlc3RlZCB2Ni4xMi1yYzUt
bmV4dCB0byBzZWUgaWYgYW55IG90aGVyIGNoYW5nZXMgaGFkIGZpeGVkIHRoZSBpc3N1ZSwgYnV0
IHRoZXJlIHdhcw0KPiA+Pj4gbm8gY2hhbmdlIGluIGJlaGF2aW9yIHNpbmNlIGNvbW1pdCAyODQx
NjMxIC4NCj4gPj4+DQo+ID4+PiBXaGVuIGJvb3RpbmcgdXAgdGhlIGRldmljZSBpcyBzaG93biBp
biB0aGUgcGNpIGJvb3QgbWVzc2FnZXMgYnV0IHRoZSBkZXZpY2UNCj4gPj4+IGRvZXNuJ3QgZW5k
IHVwIG1ha2luZyBpdCB0byBsc3BjaSBvbmNlIHlvdSBnZXQgdG8gYSBwcm9tcHQuDQo+ID4+DQo+
ID4+IFBsZWFzZSBnaXZlIHRoZSBhdHRhY2hlZCBwYXRjaCBhIHRyeSwgdGhpcyB3aWxsIGhvcGVm
dWxseSBmaXggdGhpbmdzLg0KPiA+Pg0KPiA+PiBPbmNlIEkgaGF2ZSBjb25maXJtYXRpb24gdGhh
dCB0aGlzIGZpeGVzIHRoaW5ncyBJJ2xsIHBvc3QgaXQgdG8gdGhlIGxpc3QuDQo+ID4+DQo+ID4+
IE5vdGUgdGhpcyB3aWxsIG5vdCBiYWNrcG9ydCB0byB0aGUgNi4xIHN0YWJsZSBicmFuY2ggY2xl
YW5seSBkdWUgdG8NCj4gPj4gY2hhbmdlcyBpbiB0aGUgeDg2X2NwdV9pZCBtYWNyb3MgaW4gbWFp
bmxpbmUuIEJhY2twb3J0aW5nIGl0IHNob3VsZA0KPiA+PiBiZSB0cml2aWFsLiBQbGVhc2Ugc2Vu
ZCBhIGJhY2twb3J0IHRvIHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcgeW91cnNlbGYNCj4gPj4gb25j
ZSB0aGlzIGhhcyBiZWVuIG1lcmdlZCB1cHN0cmVhbS4NCj4gPj4NCj4gPj4gSWYgeW91IGJhY2tw
b3J0IHRoaXMsIHBsZWFzZSBhbHNvIGJhY2twb3J0IDM2YzY3NmUyIGZpcnN0Lg0KPiA+IA0KPiA+
IE5ldmVyIG1pbmQsIHNlbGYgbmFjay4gVGhpcyBpcyBjb3JyZWN0IGZvciBHZW1pbmkgTGFrZSB3
aGljaA0KPiA+IGhhcyBpdHMgU1BJIGF0IGRldmljZS5mdW5jdGlvbiAxMy4yIGxpa2UgQXBvbGxv
IExha2UuDQo+ID4gDQo+ID4gQnV0IGxvb2tpbmcgYXQgdGhlIGRtZXNnIERlbnZlcnRvbiBhY3R1
YWxseSBoYXMgaXQgYXQgMWYuMQ0KPiA+IGFrYSAzMS4xIGxpa2UgbW9zdCBvdGhlciBJbnRlbCBT
b0NzLg0KPiA+IA0KPiA+IFdoaWNoIG1ha2UgbWUgd29uZGVyIHdoeSB0aGlzIGRvZXMgbm90IHdv
cmsgb24gRGVudmVydG9uLg0KPiA+IA0KPiA+IEl0IHByb2JhYmx5IGhhcyBzb21ldGhpbmcgdG8g
ZG8gd2l0aCB0aGVzZSAyIG1lc3NhZ2VzOg0KPiA+IA0KPiA+IHBjaSAwMDAwOjAwOjFmLjE6IEJB
UiAwIFttZW0gMHhmZDAwMDAwMC0weGZkZmZmZmZmIDY0Yml0XTogY2FuJ3QgY2xhaW07IG5vIGNv
bXBhdGlibGUgYnJpZGdlIHdpbmRvdw0KPiA+IHBjaSAwMDAwOjAwOjFmLjE6IEJBUiAwIFttZW0g
MHgyODAwMDAwMDAtMHgyODBmZmZmZmYgNjRiaXRdOiBhc3NpZ25lZA0KPiA+IA0KPiA+IEknbSBn
dWVzc2luZyB0aGF0IHRoaXMgcmUtYXNzaWdubWVudCBpcyBtZXNzaW5nIHVwDQo+ID4gdGhlIHAy
c2IgQkFSIGNhY2hpbmcsIGFmdGVyIHdoaWNoIHRoaW5ncyBnbyB3cm9uZy4NCj4gDQo+IEhtbSwg
YnV0IHRoYXQgc2hvdWxkIGJlIGZpeGVkIGJ5IDJjNjM3MGU2NjA3NiAoInBsYXRmb3JtL3g4Njog
cDJzYjogRG9uJ3QgaW5pdCB1bnRpbCB1bmFzc2lnbmVkIHJlc291cmNlcyBoYXZlIGJlZW4gYXNz
aWduZWQiKQ0KPiANCj4gYW5kIHlvdSBhcmUgc2VlaW5nIHRoaXMgd2l0aCA2LjEyLCB3aGljaCBo
YXMgdGhhdC4NCj4gDQo+IENhbiB5b3UgdHJ5IGFkZGluZyBhIHByX2luZm8oKSB0byB0aGUgdG9w
IG9mIHAyc2JfY2FjaGVfcmVzb3VyY2VzKCkNCj4gd2l0aCA2LjEyIGFuZCB0aGVuIGNvbGxlYyBh
IG5ldyBkbWVzZyA/DQo+IA0KPiBJZiB0aGF0IHByX2luZm8oKSBpcyBkb25lIGFmdGVyIHRoZToN
Cj4gDQo+IHBjaSAwMDAwOjAwOjFmLjE6IEJBUiAwIFttZW0gMHgyODAwMDAwMDAtMHgyODBmZmZm
ZmYgNjRiaXRdOiBhc3NpZ25lZA0KPiANCj4gbWVzc2FnZSB0aGVuIHRoYXQgZG9lcyBub3QgZXhw
bGFpbiB0aGluZ3MuDQo+IA0KDQpJIGhhdmVuJ3QgdGVzdGluZyBhZGRpbmcgYSBwcl9pbmZvKCkg
YnV0IHRoZSBtZXNzYWdlcyBzZWVtIHRvIGhhcHBlbiBpbiB0aGUgc2FtZQ0Kb3JkZXIgaW4gYm90
aCB3b3JraW5nIGFuZCBub24td29ya2luZyBjYXNlcy4NCg0KRG9lcyB0aGF0IG1hdHRlcj8NCg0K
RGFuaWVs

