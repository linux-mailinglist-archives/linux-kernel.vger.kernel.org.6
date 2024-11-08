Return-Path: <linux-kernel+bounces-401523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E4F9C1BBB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 11:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C197B26387
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6326A1E47BE;
	Fri,  8 Nov 2024 10:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b="c6YwmpLl"
Received: from mx07-0063e101.pphosted.com (mx07-0063e101.pphosted.com [205.220.184.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251363FB9C;
	Fri,  8 Nov 2024 10:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731063511; cv=fail; b=gjl25WKJVzjN89gEk+B4haUP18A3Yz6q8Fa/lcF1OO4t627LS8Khh6mXlHTvnSWKNBYW2OLSenC3563r5XAqRsQd0saedmNqwrNcN0fziYhzGZZWFJ/2M7eoB6H6f23IJQ1XGiEC5+ZU5PfSXDjwemOcG90imENHD0xOlNNhaQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731063511; c=relaxed/simple;
	bh=zAbAIDs3asJk3kFHkF4GAY50e3FQQp2U5xs0VucWSDo=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BDwlB6QrTVGFU0cYnyrhzP9Gf/ggkpHPXzQcLRjZJlrMA0Sig3xeY/hNhd0bIW/d4eHuhLQVQPIpyMd8chaUPC1pqLOXAQJv+b1Jb6G+OJ1rshovP7YLXrj9JOxxiWVYlMJi6Pi+tpVfohKETZr/aMKOng9chBjSNJRMIf4piA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com; spf=pass smtp.mailfrom=blaize.com; dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b=c6YwmpLl; arc=fail smtp.client-ip=205.220.184.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blaize.com
Received: from pps.filterd (m0247495.ppops.net [127.0.0.1])
	by mx08-0063e101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A8AGexA021628;
	Fri, 8 Nov 2024 10:32:01 GMT
Received: from ma0pr01cu009.outbound.protection.outlook.com (mail-southindiaazlp17010006.outbound.protection.outlook.com [40.93.131.6])
	by mx08-0063e101.pphosted.com (PPS) with ESMTPS id 42s6f5r8jr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Nov 2024 10:32:00 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sbTUHAJ3w/4s2J3Rx0MxT9sNFs86I+wiARuhb+IIskbJvHel6/hfzauiEW42R+PYUMVL5mO7muRYt7CNNbgoGoBbLKmTCkCEXaoi6ZD3+Dv03tEvvFL39AkGfoz2ZuWGvQMEB7GPCWRD5eFxwOL/jokRlrX//CQ0+ExQOPnuKnWw7dTWef5ojluqEEdo/3q09sOMmslEMIMD1u764vTbyPTswvxnl5x6UdsU6yh24/qGNji2dXp4UkvgY4WgRUSyUe+gEaND/J6eLxdV+/6uWoUP1DXFoKGv9J93lA159NU6QYYoCvDHlZVMILhWm+C+IRQi7lRfjpI1jXDmHT4AZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=naSleiwVGuwAs2/Xt05HcRb2vVRT+1pU0Rbqxhaz4TU=;
 b=saXTnprlcH0bY6c2JVhiA0Ca0ja6NbuYuGxDRSNw/lFEsUwZvJxxVOrnpNelEVm3CCQ5xIq+9D8jxFcntdC1HSO17YlnWrzhSKkAuwEKvX4J1d40BMCIbWUNT6/TEYi8/wFPnthWjabB7P5GqRhS3h3lsCAJlmyOHme1NlOXfLa3gVBdwnKYJjTg1zeBnKLqDG/KXSqQ7xAh8l7bP5LETntArMglgE28FeCT+nHHChZSmAWyGqcV8PAnG3kMbkP57DPNcMgi7bqqaNyRq/Cn/1tK9h/fmCUJr2nhXg+7PHtpDmIC8jFP3x7Wz5T0nQDE6peKlStRncIDN5ttJsiuiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=blaize.com; dmarc=pass action=none header.from=blaize.com;
 dkim=pass header.d=blaize.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=BLAIZE.COM;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=naSleiwVGuwAs2/Xt05HcRb2vVRT+1pU0Rbqxhaz4TU=;
 b=c6YwmpLloqkJFt/U7Pgd+EORxJcmCVIcPSm9J1i8gsl8R9Sb1hZfevYsrNd9kred6lsfrVR/z1w/mQUHSRjVokAPcYkbB3c/hpvBJyTWVWqorxJrYnE/vlVsaE7FFO3A6N2x9O6r6MIGW54G5qOK2Z0JTqNvYCHmYHxLYF50yqc=
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:12a::5)
 by PN0PR01MB7813.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:b5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Fri, 8 Nov
 2024 10:31:54 +0000
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655]) by MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655%4]) with mapi id 15.20.8137.019; Fri, 8 Nov 2024
 10:31:54 +0000
From: Niko Pasaloukos <nikolaos.pasaloukos@blaize.com>
To: James Cowgill <james.cowgill@blaize.com>,
        Matt Redfearn
	<matthew.redfearn@blaize.com>,
        Neil Jones <neil.jones@blaize.com>,
        Niko
 Pasaloukos <nikolaos.pasaloukos@blaize.com>,
        "robh@kernel.org"
	<robh@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org"
	<conor+dt@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
        "olof@lixom.net" <olof@lixom.net>,
        "hverkuil-cisco@xs4all.nl"
	<hverkuil-cisco@xs4all.nl>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "hvilleneuve@dimonoff.com" <hvilleneuve@dimonoff.com>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>,
        "rafal@milecki.pl"
	<rafal@milecki.pl>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "konrad.dybcio@linaro.org" <konrad.dybcio@linaro.org>,
        "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>,
        "nm@ti.com" <nm@ti.com>,
        "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>,
        "johan+linaro@kernel.org" <johan+linaro@kernel.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v4 0/6] Add support for Blaize BLZP1600 SoC
Thread-Topic: [PATCH v4 0/6] Add support for Blaize BLZP1600 SoC
Thread-Index: AQHbMclu/zS7joxR20aEP3OXsBYHyg==
Date: Fri, 8 Nov 2024 10:31:54 +0000
Message-ID: <20241108103120.9955-1-nikolaos.pasaloukos@blaize.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0PR01MB10184:EE_|PN0PR01MB7813:EE_
x-ms-office365-filtering-correlation-id: 51b22f84-dcf8-4fd5-d2c0-08dcffe09094
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?jNnHpkFdV/tyO3CwQMURTNfY0XYmEcjvJ27EvLrrqV4Gx6zMXlABXvlwrI?=
 =?iso-8859-1?Q?Xo/EjqBTQD8QLI3VCg6r2onUHfwQH9I1nHe94hH6P/w1bwh+CB4HDhBEcU?=
 =?iso-8859-1?Q?bHneB7JBdVsHX+ev47xXHYyKpexPROqUzTIoU0uPyXQCZwiL5KYuUXsUaO?=
 =?iso-8859-1?Q?2kGCfoMCcsqbsI5db5NiuDV3OmUFN/gV8CjgaXvJc5Gr4NbIL/VXxba4vw?=
 =?iso-8859-1?Q?nrzN7NFevoTsVxlzmfb8oDiD4TjFJBC0joDzNMuTiNM5emmNcrMDHZnYSg?=
 =?iso-8859-1?Q?R1t7Ba8++Mi5S4Ky8N/Dlzg3d8bfzNMIkln5f+d7fNjqof1DISv57aJW2a?=
 =?iso-8859-1?Q?YEYKkqAegjMXP30toQLhSod5rOfhNhV/Mb9FGohMu6S2gU8UGvuMCFI4GB?=
 =?iso-8859-1?Q?KV+DbZVLLxRL/B2UJJNrmvPj8Y6QX7A8E4QTpGBZKZTbvJHLG8aualAgCm?=
 =?iso-8859-1?Q?EIQcCbxgVC4EoAookPrGiDG4//pHWP38JPEHlH4cOdpIwB1JZJDuIcsyPG?=
 =?iso-8859-1?Q?33zyOdjDokNPKNtNSBp6MzZnJqOeQmDCLywuy7QtCQeVSTmLLw5pxxCXRA?=
 =?iso-8859-1?Q?JiQPryFmr8f6uD+gZgbvhQhFu2n2MRVCghvgRZxdTz+/G3oBfjSsYOkQis?=
 =?iso-8859-1?Q?J91B+/JDrz89tRz6Axp6OwC5X8Hcq7AXtrR4WmFM5XoxViFpVTEq3SKzQL?=
 =?iso-8859-1?Q?LkrBcVCJTccbVTCA5k2SqFjpPW+hp7RnMmB6OgziqjnVuA2iWtOOGqjd7E?=
 =?iso-8859-1?Q?he2vOsoWhreqYTjUAAuTn/J/q2qXNGNu2oAkba1l/9Xb/oPlXM8fkj6m5O?=
 =?iso-8859-1?Q?djsnRiNtvkwTL2y++ix6TWpUArra2Of4Fwy125GnWIm+J3ju/1YTP1w9+u?=
 =?iso-8859-1?Q?cqGSAZchUcnejieGlU4SLLDlkMQTN1LiLQ7yRVOuBUR/Tzi13YDCFyL0l2?=
 =?iso-8859-1?Q?1L2vg6TlTMdQmeYbcMJQmqtU30fFR7i8E9Jzu7W799Hy/as2RPiKdNMc6j?=
 =?iso-8859-1?Q?I69UlR0pWMJG/BaISU+QWUOcKY76HEGBR50WXtGHiNNdv0NU+cHWjwn7Yu?=
 =?iso-8859-1?Q?U/KKhtmY06M047D66H63yN3p+k9n5fOJST8WR9BXSnrg2LQga0T6421vyM?=
 =?iso-8859-1?Q?dE9Q2sGo9v5sutpdTL232Xphwg/Fev6NEEZmZho9n4/Jyy+2rAYfiQffgC?=
 =?iso-8859-1?Q?Wk1K+jpSoOdlKMz4u4I11bStIjjpGcKmGxGGfwYzyjEHd/Dwf3GuI7OGhd?=
 =?iso-8859-1?Q?VPsSUW5FNegpfK/CQAt5ByY5H7RHiJoL7mDTEBXM3ogUNqWbbYycPHgk5B?=
 =?iso-8859-1?Q?D8AxM950X5tIcNs91yeidcW+GPPTmKTja9iWOQFKjbHA2RywJ7BlDonFmD?=
 =?iso-8859-1?Q?yMVvsohK3W1YoRWPeI+P3LjhQqWkDNH21xADMR2Mser3ZKlScjRJNPKEYO?=
 =?iso-8859-1?Q?ryxB/oswCkGuQbj0?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Ith2ACpw0BUCtLv42Y5H30JOPe/RNpjA4GzunksBiHmUX4QLF6UbtZ5O3h?=
 =?iso-8859-1?Q?1XlSqZ/xcIBXdjU8RpeK3bbmFnRF4jnxzXdBMzUnkS+gXLqKr9id7nQ3/2?=
 =?iso-8859-1?Q?5fkKu23aMCJv1rooaIF7YVuhwKMSWcXdGiEYm0IhgRPeXL8DIx8M4a5bv2?=
 =?iso-8859-1?Q?PCYVhZQ7x+6rnflWah0RmtvbIBgSfNRNRsU6k6O07Mlw7qtYUUtSJCqZ2y?=
 =?iso-8859-1?Q?nzCUYgUq3bmmUZMN1cbHnIkWAP2I89OCjCLcxqkbtPpHeGgx2Zzzr+bCD0?=
 =?iso-8859-1?Q?YNWjr/2mjNOi/ypBEhiZ/NnnosVP8RnxE24Pg1HTrNPH1cUy6Hz67S0w/E?=
 =?iso-8859-1?Q?ACjk9PkmyXZTWOfnUCfbz4BjxUbJ72qADzjCBxgzJsmLUEu5rOVaLwvaxG?=
 =?iso-8859-1?Q?BUI8l870jBl4uQ/R3PLGCtOrg4TsugZwXXIgJsU3PxX8SBn5z5eYQeLsW8?=
 =?iso-8859-1?Q?crdse4L3LbLbOavGOS6cTxkjg/JoD10Il4FUALlwzN7nvWCidFhYtf+yDB?=
 =?iso-8859-1?Q?fXUfLnzxXJHEJ8MYR0DAY8TPJnAPN1MOc7w20stShxRV2qrP+nJ9FN4iBw?=
 =?iso-8859-1?Q?g47kezg0jaqs9PF+xzYEUJ26T8xdKRm5ECgmV0tSfgZLWYc5pqxfMhQydV?=
 =?iso-8859-1?Q?UQp8QtJODNIFJOSdMbQQOI/CdCLnrf0rYb1FaoTOaMDMxqncGdzOPvhY/P?=
 =?iso-8859-1?Q?2gjT3ecfxCCF1r9Ux2gyKbeqtCKxqgw3L8lbiL0hgmipDdRUgSqP8fqf24?=
 =?iso-8859-1?Q?bi7hXn48zwQyO+U9tvvLJcKUNRcwTRKkpH1r4l57pfd82kj/Lv8eKfi16L?=
 =?iso-8859-1?Q?4h3ij39lI1cl5qXWCoxgnIS+XbCsOrO0V/yPrYMDdqNzq1pBAgDFaEb36P?=
 =?iso-8859-1?Q?xoLb/YKIyrLFf07bkH+Yy2jF+em1iWOZkkHX2PkZdE814cbrMMtrR5JoF/?=
 =?iso-8859-1?Q?E2vMQJ8qmdiryysPvjNXvJrqTu6gdf/0emWZ48Pqv/ezg8pgo20xTQ5v82?=
 =?iso-8859-1?Q?MP/c7K5qy9+N+bb3+MTsTcW1AX7rO9uNUF84qnI832e4Y/b/3WZBc5I5Yl?=
 =?iso-8859-1?Q?8LEivL/15fSrv42dEaO6cCsdMJP9xS4+9ucvsAju+MNcIoGphnY8R+QuZD?=
 =?iso-8859-1?Q?g4Ji7NsqfUGUcQktgK5YIG93ynJtmwC41eyrokYGnhp27zo+8iPb8z8m05?=
 =?iso-8859-1?Q?s2eMPYiaOu3MhOI1SWsUwx9hjTrWYv0pCwVEoOBGEUHo+LUvzLow5W8O+R?=
 =?iso-8859-1?Q?lVlfEyrN8t29TRM1Lvj0ROIAJM+XrotcwLgD4cceN46OePXKc34jXOL92f?=
 =?iso-8859-1?Q?0I1dGaOvTTisAPCm6/Wm+5hOyyHJYvTABF2sDymBfC3n/9vkWnbntM5kaD?=
 =?iso-8859-1?Q?LXOuNk5BLWMfQKKQpo7iZkilauuKY28Y1owyVCadSoFmiKhJ4HNJkX+gc8?=
 =?iso-8859-1?Q?UKh11UWxZ9AoX0WW/xi3ND+BAdoopVU5KPOUQpI7mJZLr+l4/nhDqa8KUV?=
 =?iso-8859-1?Q?HQ/TOrpAIN0m4h9tchLOaXRUpz4G2R7ISrI0ntytP6t7fqHyDsB46/zj7V?=
 =?iso-8859-1?Q?qoXRhMbpUsFW/OPq9YCOeJLsH+0Jm4yMzAy7UPsYakafgZHRl/1oEzc7Dw?=
 =?iso-8859-1?Q?GeAb/kvY0G4mzJPipaZuXgnandmfSUUaoYp9pnoHBbF4hg4GikBnGB2A?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: blaize.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 51b22f84-dcf8-4fd5-d2c0-08dcffe09094
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2024 10:31:54.2861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1c3c89-8615-4064-88a7-bb1a8537c779
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CVTAfBoMlcrNeafrFLP3qX5mbWhFRRKl+hvq1by9Kuw9WZ9O+XYpWlU8XJRqX/0Z2sYECkEPNVxS+zlzHvVMVgV0AB+tPrkCIZAlJyDrtnc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB7813
X-Proofpoint-GUID: JloH6t00S8ynczfmCz2yds9Uf1ilr4Mv
X-Authority-Analysis: v=2.4 cv=BqvPwpX5 c=1 sm=1 tr=0 ts=672de8a0 cx=c_pps a=TXs1g+7sIME2BPo3OSn30g==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=VlfZXiiP6vEA:10 a=4MthsM0t3ikA:10
 a=-5LYVjoNHPMA:10 a=aOSuYOpuNU4xSexUnpEA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: JloH6t00S8ynczfmCz2yds9Uf1ilr4Mv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-08_08,2024-11-07_01,2024-09-30_01
X-Proofpoint-Spam-Reason: orgsafe

Adds basic support for the Blaize BLZP1600 SoC.
This SoC contains two cores of Cortex-A53 CPUs, one Blaize
Graph Streaming Processor (GSP) and several other IPs.

V4 changes:
 * Add maintainer for blaize in arm64 dts
 * Fix Blaize schema & dts code style
 * Add range and reserved-memory as suggested

V3 changes:
 * Removed unnecessary dt-bindings
 * Update SoBs

V2 changes:
 * Update SoBs
 * `make dtbs_check` has no warnings
 * Fix dts names and removed dead code
 * DTS is separated from anything else

Nikolaos Pasaloukos (6):
  dt-bindings: Add Blaize vendor prefix
  dt-bindings: arm: blaize: Add Blaize BLZP1600 SoC
  arm64: Add Blaize BLZP1600 SoC family
  arm64: Add initial support for Blaize BLZP1600 CB2
  arm64: defconfig: Enable ARCH_BLAIZE_BLZP1600
  MAINTAINER: Add entry for Blaize SoC

 .../devicetree/bindings/arm/blaize.yaml       |  36 +++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   9 +
 arch/arm64/Kconfig.platforms                  |   5 +
 arch/arm64/boot/dts/Makefile                  |   1 +
 arch/arm64/boot/dts/blaize/Makefile           |   2 +
 .../boot/dts/blaize/blaize-blzp1600-cb2.dts   |  84 +++++++
 .../boot/dts/blaize/blaize-blzp1600-som.dtsi  |  23 ++
 .../boot/dts/blaize/blaize-blzp1600.dtsi      | 205 ++++++++++++++++++
 arch/arm64/configs/defconfig                  |   1 +
 10 files changed, 368 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/blaize.yaml
 create mode 100644 arch/arm64/boot/dts/blaize/Makefile
 create mode 100644 arch/arm64/boot/dts/blaize/blaize-blzp1600-cb2.dts
 create mode 100644 arch/arm64/boot/dts/blaize/blaize-blzp1600-som.dtsi
 create mode 100644 arch/arm64/boot/dts/blaize/blaize-blzp1600.dtsi

--=20
2.43.0


