Return-Path: <linux-kernel+bounces-269249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BDD942FC1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E2CBB24611
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5491F1B1401;
	Wed, 31 Jul 2024 13:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="TsGyTaTH"
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011014.outbound.protection.outlook.com [52.101.129.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24811AD9C3;
	Wed, 31 Jul 2024 13:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722431442; cv=fail; b=dc5C9RHoqpdIV97hSOvuEdD/BvRmEm5Gu5grcaapcT2KEW0Y63QD5nvbEQL1IFfNtNcbLyYz6BI1LB5ovMgJhVkMA8076+8Z9wTm6n83fhJFqV/uVbnffoAATmbgV6F9oqs00HjmTmGDnRkDurp6NJ90pZk2yLQmN0oAoPSrinM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722431442; c=relaxed/simple;
	bh=3pEBR5YbiCTCH2u21TMF9s72X+GAsPJmWoiHcbgxnkc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AXWoe5kpKPXeuh1FkH6dhYz05e7vFe9H/hvhXUIQV6InAtTp5AQxk+b5ovs8t3QgFrskMxjCEQbfkQvO+WDBdMYbOuFi+ayZY+cM18jU3w86SGeBZvaOhDhjHu/jOtye/Gqa1nvpUuoqsvO05pjmtNYFL8fz1g8vwnL2FkWRu98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=TsGyTaTH; arc=fail smtp.client-ip=52.101.129.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZIUDvT34BymWQ/Wjg7oJ4F3WT1FykFgMMUTYW4yskWttFIAREOABK/Rb/aUviNZ3HpfYTPQdHnU/QfNc0wZB6Vuk+Nm5Pfzja7QaDjPOCxGIgF8VWIMg97hxkIp7rj4r1m38bdxpUC+xusS/D/S6C6C9au5FdhfHQ7uxBTiwTixje/4yEcFh+aPkFshBaFXtIdpB3P16Yz4z+a1UrzIc6voRQ3luBTBYYlIzkUdlHdIZXqiteuNUcHjyYTbkqbfHv1sr6wx1WKlDk1NosWOLBwp0bc3xJniopXn4dE7HIXnsHeeSUouu+mBX6iRtLZ7dAS916P/XGOq68lTOEg1iFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3pEBR5YbiCTCH2u21TMF9s72X+GAsPJmWoiHcbgxnkc=;
 b=WkTC0vo5z1zAQWvv6thPm3rG5r37wK12x/tZNhbC5nyqrT/I4DgaoQb2gmQhBUa74zDqevCtuJb586cZ5WUI2HEhh9uyoNmjOYv+9t7dKTk1X/bLqheTf4TibleiibX/sqBFmFaXXlPVnMdbMZKcoO+VkGQOrNgnKAqaci6G3p5QtXaUc7puKVNayWPj8q9Dn6GjLPxYQf07I0QWJEUw6Xr/WiQqtMuvxb8bR7FPBzrCWCkEWTpuL++qD9bfE8XHpKLbOXfsRh02PPBll+ideDxiNavTxxGBQiBVl1HyGrZhy3c3E8gr//Iixx/icnTyQeX1BPvtK60fqOzpeDLpEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pEBR5YbiCTCH2u21TMF9s72X+GAsPJmWoiHcbgxnkc=;
 b=TsGyTaTHdxoKg468hcLtxNi/HMAaZv6g6O5pEZGU8Yy7OXUPWHVs+j9FHk+ni7dG80kPb4LdMvfvRw/aUiqCC6kr8Drbl7BLQdZE8FHfrB4197EumuypUKkXGz3TfyhpxYstWIQ2DuLp6iHu5uAZiGc1UIZrOwomB0Fm00cGiK9rY7PwJ0FZagI+rXLx9OcDXBidurUHV66bHyGk5ADSOkYG5KJ3kYG7ls3ytR++GkIWTJABDv/FEHR0ylsBwGIRAMaQ7XlFmCb7/3OM9vrCVSW9lev3WKbL+f00g93PJ9SXP9dLj6PpcWN1/Qw0pa7rjKYiPj0YsU0Ytq6NWtuXzg==
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com (2603:1096:400:358::7)
 by TY0PR06MB5706.apcprd06.prod.outlook.com (2603:1096:400:272::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Wed, 31 Jul
 2024 13:10:36 +0000
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe]) by TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe%4]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 13:10:36 +0000
From: =?gb2312?B?uvrBrMfa?= <hulianqin@vivo.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"dan.scally@ideasonboard.com" <dan.scally@ideasonboard.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, opensource.kernel
	<opensource.kernel@vivo.com>
Subject:
 =?gb2312?B?tPC4tDogW1BBVENIIHYyXSB1c2I6IGdhZGdldDogdXZjOiBGaXhlcyB0aGUg?=
 =?gb2312?B?YWJub3JtYWwgZW51bWVyYXRpb24gcHJvYmxlbSBvZiBtb2JpbGUgcGhvbmUg?=
 =?gb2312?Q?as_UVC_camera.?=
Thread-Topic: [PATCH v2] usb: gadget: uvc: Fixes the abnormal enumeration
 problem of mobile phone as UVC camera.
Thread-Index: AQHa40jh6qpqVz84x0eDoslRI8aWWLIQz0PA
Date: Wed, 31 Jul 2024 13:10:36 +0000
Message-ID:
 <TYUPR06MB62176AEF282BCEF750F094DBD2B12@TYUPR06MB6217.apcprd06.prod.outlook.com>
References:
 <TYUPR06MB62175899DECC7A9B0DA0DF01D2B12@TYUPR06MB6217.apcprd06.prod.outlook.com>
 <20240731122351.GU8146@pendragon.ideasonboard.com>
 <TYUPR06MB6217EF08BA3F758EB20C833DD2B12@TYUPR06MB6217.apcprd06.prod.outlook.com>
 <20240731125444.GX8146@pendragon.ideasonboard.com>
In-Reply-To: <20240731125444.GX8146@pendragon.ideasonboard.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR06MB6217:EE_|TY0PR06MB5706:EE_
x-ms-office365-filtering-correlation-id: 47953ea3-de85-4fbe-a980-08dcb1622aca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?TDhFZ053d1NRWWxTQm1zZW85c2JHQndHbnZiN05ua0RwcEE2M09ZR1VNL25B?=
 =?gb2312?B?ekVqL1lkSms4cU5wSDJXOXVCN2xjN3ZYNVl4SzVsd2MrOHlNbENaTHpRQzFK?=
 =?gb2312?B?R1FQYXFQTnFBRTRuUXlkbkVzVUE4K0dEdmRvaTc1T2VjMWJSRE1kU0NFRnZw?=
 =?gb2312?B?YWo5UG80UnIxM3ZTYkFBNnFWOTNiblppblZja3d3UG5wSG1HMi90YllCWU4w?=
 =?gb2312?B?RCt3VGhHWWVqc2RhMzF4RTNPZVR4WEd1M2dwYmgxdFNOcVlTZHR4RERBL1dV?=
 =?gb2312?B?RHR1QTFiSlhZdUJhK0gzR296cEI4L2hwOEMwQVdocXlGM1VTaTFZTDg2NCtU?=
 =?gb2312?B?UnVLcUxkajFGMVcydU9GVUpOeHBFdVN2ejg4cDhQWHNibHhKeXlaWE56ZTBT?=
 =?gb2312?B?UEJCZzBYVldxM09YV1hqQVFTd05MQk5hUkR1Nm5HUDE3c0h5R0xqU2ZVajlQ?=
 =?gb2312?B?ZUV6VEppV0tpdmJCNkVBdThFRHZqYzJjcFRadkxuWnIydXgwYno4em5mUnNW?=
 =?gb2312?B?QnVFdGtYdnNNdHY4NTBuUlJZQ0hTUzhadnJNMy82N3VJWDc1R282d09SU1ND?=
 =?gb2312?B?MVJEU1hrVzc0aTI1am5nQlVXTFlIZGNOK1RtUzBQbGpoQS9XQkRyb1RkTDJj?=
 =?gb2312?B?eE0wbUVzdm9XY1NKcXRlbEVPL2hpQ2NNWWRvQjRWTXQxaVFubTB4MDExR1JB?=
 =?gb2312?B?OW1MUlFORnNMK0t4RkdJbnZxTEQwMVBINjFsQUZKd3BrZTUrSnphK0ZDUjFN?=
 =?gb2312?B?cUFXRzV5cWhSeUVKOUNqZU5MaUN0Q1ZjQ1RzbWZYWVpreGZVemEyUnQ1ajZv?=
 =?gb2312?B?YTZZZ3VYbFFOSVNQNkNjZFhtZjRObDhFZit2RVZjSHpqTGFKZ1huNzJKenk3?=
 =?gb2312?B?MjJGMVNZdytZUEpDUVh4d3ZqQXR2ZVlwd1hsSVhLQ1pmVmpJL1BvQjVuaTdV?=
 =?gb2312?B?aVpMYnlraDFTcTBXK08xWlNwMEYyNXlodDc5VXhzQ2piVU5BNjM3a3RjOGU5?=
 =?gb2312?B?WUZLMktNdzh6U2I3SVgxbmJLb3BkN0YycDVqdFRIemlBOGxaU3VmdWRuL2dU?=
 =?gb2312?B?MkhHMWJVcXVCbnNaZm01MXdsSkU4T25oblNGUlVCcWsxUlNDU0tuTlFQZzVp?=
 =?gb2312?B?Z0VpNlVTUFdYbklxRHpLNXJEYU1nUXllLzROeVBNNTdBd2JBV21KaGxHNG02?=
 =?gb2312?B?eXlkbUs5UmNaMnowNWtLMmUwUktKcTl1U1V2dk1mUWc3aVFaUTZ5Z3pNMFZD?=
 =?gb2312?B?Q3RwOVNpQjcwZnpYUzd2a3BPaitzamJHNFNPZC9reTRUU0pXaFQxZ3l1eUdh?=
 =?gb2312?B?K3RodjA4eVdKaVBJRTZ5blRQOEx5MXNURGdta3paN0pKbURTeXp0VFNldzNN?=
 =?gb2312?B?QWdkWTZFK0R2c0o5SjBtaWdaaVVFWk93QUpEdGsxeE5IcjhQWTQyOU8weVBv?=
 =?gb2312?B?Q24zd2U2QVBDUzRNTWY1UHJzdmVKU1FWcWJFamUyNCttNS9ITTNsTi9Lb3lB?=
 =?gb2312?B?QmRLSU41QTl4cEVESTJTdVE1cHpnVXRoTzhwUnkwR0llMGZtc3FHOGJtMHRZ?=
 =?gb2312?B?VjFkV21mRHF1ZzczWm12a0FZYVlFQVUzMU9zK0cyWHZGVGUvaFhDbGp5OC83?=
 =?gb2312?B?eG16dWozWEVqWkxzMjdyc1dtU0g2WE1ldGlkRHBsQTVRZEFlNVplWGdDc2I0?=
 =?gb2312?B?SVNTN2xWaW1kRVlaUy9xWnNZbGI3cUo0cDhJYzhETzlwOHluUytpZFhOQVha?=
 =?gb2312?B?S2hVTEpjUnAvWjFPakRudUN4T3VPeXBZZHZGdjN1c1MxWUVIRUtnUXdqMTZo?=
 =?gb2312?Q?0ReG7sxKWJL5znCC08YQqlmgMb9aSWmJcXCXs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR06MB6217.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?a0NzN0hiSXI1NVdHVUJRNkJ6Zk9yU0FmRHpVRW4vZVlteGpkQUVtZi9UK1oz?=
 =?gb2312?B?Tm5EVDZ3RTUrMDZmaWMwbkhRdHhtVlhLU0V4RVhjeXVmNUtZSnk3SkJKOU8w?=
 =?gb2312?B?L0NMVlNDSHpSRjVQZkQvMmJoTWFoRzdCeEp4QXBNdkZwZFJiZ2I5NmE1ZDcv?=
 =?gb2312?B?bi9PNGtRZ0JBamtxRmtUcWMzeUp6aWZ0UnZZZWhYVXNPK2lKMmdCaGNZWHpx?=
 =?gb2312?B?bmVmK2s4WUtiNlFxTDNuVCt1T01QdytpY2NaNnlpbm1aaXl2UTdvSnEva1d4?=
 =?gb2312?B?MHpKVGZMeEplYUtmZHplUDR3eXIyNG51UWpzekJsREVrcHM4REszUFZzMUc4?=
 =?gb2312?B?YWxIb3hyT21tWTArTmdCclBzVDJLYlRvdElTNlZ5aVdiQ3FpdVl3QzZqTWQ2?=
 =?gb2312?B?M0hUNHB4bjVmL3BYa1JCTDh2djdlRlY0VURMdU5WeVRyT05QQWwwbkxaRmp2?=
 =?gb2312?B?eGgyRU5GYm5PTHl2b3UyaldoZjFQaldZSzQrWDUwclR3dUE4NEJXUDZtRjFV?=
 =?gb2312?B?Qi9Pc0VIdFNtQ0tKa2Q4MUhlQ2hnbnZ4K1EzbVRwR1RzSnRialFSZjhBdmNr?=
 =?gb2312?B?ODJkL1pEL3ZhUE1KcjluaElDUk1TcHVMTXRrWHYrUklUeGRmbjdxS1RGR2NV?=
 =?gb2312?B?djd6Z3pVaU1rR2Y4a2JiOFo5d3JSS3pPeFNBMEFBT0E3ZVU0WWVNbGF5WG5D?=
 =?gb2312?B?SmJUWmVSTmVtMThZbHQ1YmlRb2pRYTZrU0EvNW1zZElZbTVYeDZKOUtsVVhw?=
 =?gb2312?B?MEVHRzdIcklFaFhMdWtLR2Vpd2E1bWV0REZ2b2JRcHo4ZDJNRVJZaUhOWXVW?=
 =?gb2312?B?Y0I5eThjaG1ET0drbmgxTXRUTnlRcmdQZmFHdjRMSTROSlNrWS9YR3dQcVZa?=
 =?gb2312?B?TXNEZkJKQUo4WnFBMkd2dEptZWdxZlgrTlpUOGszV0FvVThTcEpyZU9jNlhq?=
 =?gb2312?B?UjB6VkFJd1l6OE80TmtPOWxIV2J0eThJK1ZWSUxKd3NpcEQvdkcxeHI1emlZ?=
 =?gb2312?B?dTd3R1JMYnY0aDdCeGZha2lmczRXSjk4QXcvdExuTzI4b2Q5WXl1R05FL25Z?=
 =?gb2312?B?OEVhZmpPb1A0V3VOVTY3eVZERE1pcE9GdlZ6VEkyditENUovYk1mY2lGbEhU?=
 =?gb2312?B?YkdsZDJMYkVQUUtaMEhCTFBiZ05RbEZqZnR2c3RONDlIUDBmSUxHNVFsYjYz?=
 =?gb2312?B?UVpWdjFOSHdOUHM5UXk2Sy9mbVgzVXZ2ZDZ5QStNM3NDTkNDYU5XaVZQNVlE?=
 =?gb2312?B?TUFvY2psSGVwQkVpcnpVeVNQeFNPbS9JRjdzK2J3anBjR3RzbjM0eUlBc3B0?=
 =?gb2312?B?NUNwWGdiMTJ4YWdmQU9zQ3orVTFwNzN2QVdsRTMyS28vMDgwaEF0T2JMampi?=
 =?gb2312?B?M1ZuTXJYQWhQb1BJS0FvT2ZvRUlSbUFadS9TN2c0Ui9yd29yby9xMHBQK0Jr?=
 =?gb2312?B?ZnAyQ0ZGMmI5bmNJVjBDSFhaSDdVaW5nME1JYi9EVE4zWkk4Si9LcDhLRzNk?=
 =?gb2312?B?ek1kU1RYVlF5OVRLNFJ4Nmd3WlNGRmxDKzJGbWJRcy9QeXh5ZWlOM2d5UHd3?=
 =?gb2312?B?ZE4rSmE4NnlZUVBWRXhIeklnYlJ3WmNXNEkzU1cyT2hmd2RpcGNsZ01uNTdV?=
 =?gb2312?B?bU9RU09HaHM1YWl4WU9oK2llSlhiUWl0M0tObGdIZDN0UG1zOGdNeUIyWndX?=
 =?gb2312?B?NVk1Nk9SR0RXcm52ellRTWtOQ0h4ZHRwaGV6VEJ0dFgxQnR0bGJyaS9Xa1M4?=
 =?gb2312?B?Y3VvajJ4RlB6Wkt3TE84ZTB5WXNpaU1GcGpiSklPNWRJRzJZNTNTR3NOY3NZ?=
 =?gb2312?B?STNJL2oyMU45WTdRb3EwOUZKODY1YVlFUTBtRlU2ZUcyU2JTNVRvUTVjS2Fr?=
 =?gb2312?B?enFTTWxYVEFPOCtKblliRnA0VVIzQmFjclE2cjB5VG5hVlVQMUhRdXhxVjRG?=
 =?gb2312?B?ZW95cVhxUFdsQ2dOOXVBaHdDdW1Wbi9ZZWVQVjB6a2pHcWVUTlFqZVg3cWFC?=
 =?gb2312?B?T1JEYUhsKzdRNkg0RXg0WThGakRoQU5vT2crVlYzVlZyRzVXeDVYYUk0R1Uv?=
 =?gb2312?B?Ly9Ec2JaMEJkSHF6aHUxWCtKM3BtR2hVL2dhNTgvcUNVcVQvSzZXOEJyUmIz?=
 =?gb2312?Q?uZTY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 47953ea3-de85-4fbe-a980-08dcb1622aca
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2024 13:10:36.2547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9aEcCiNMm8mmSJ60q2VAU1KtAsmExgDv7BIpyvjMdFRJmi3Qg28XAHX/rFg7yOMvXbN1tSqK9JJ0EteLoM1k/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5706

SGVsbG8gbGludXggY29tbXVuaXR5IGV4cGVydDoNCg0KVGhhbmsgeW91IHZlcnkgbXVjaCBmb3Ig
dGhlIExpbnV4IGNvbW11bml0eSBleHBlcnRzIGFuc3dlcmluZyBteSBxdWVzdGlvbnMuDQoNClRo
YW5rcw0KDQotLS0tLdPKvP7Urbz+LS0tLS0NCreivP7IyzogTGF1cmVudCBQaW5jaGFydCA8bGF1
cmVudC5waW5jaGFydEBpZGVhc29uYm9hcmQuY29tPg0Kt6LLzcqxvOQ6IDIwMjTE6jfUwjMxyNUg
MjA6NTUNCsrVvP7IyzoguvrBrMfaIDxodWxpYW5xaW5Adml2by5jb20+DQqzrcvNOiBncmVna2hA
bGludXhmb3VuZGF0aW9uLm9yZzsgZGFuLnNjYWxseUBpZGVhc29uYm9hcmQuY29tOyBsaW51eC11
c2JAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBha3BtQGxp
bnV4LWZvdW5kYXRpb24ub3JnOyBvcGVuc291cmNlLmtlcm5lbCA8b3BlbnNvdXJjZS5rZXJuZWxA
dml2by5jb20+DQrW98ziOiBSZTogW1BBVENIIHYyXSB1c2I6IGdhZGdldDogdXZjOiBGaXhlcyB0
aGUgYWJub3JtYWwgZW51bWVyYXRpb24gcHJvYmxlbSBvZiBtb2JpbGUgcGhvbmUgYXMgVVZDIGNh
bWVyYS4NCg0KSGVsbG8guvosDQoNCldoZW4gcmVwbHlpbmcsIHBsZWFzZSBkb24ndCBkcm9wIHRo
ZSBDQyBsaXN0IHVubGVzcyB5b3UgbmVlZCB0byBkaXNjdXNzIGNvbmZpZGVudGlhbCB0b3BpY3Mu
IFlvdXIgcXVlc3Rpb24sIGFuZCB0aGUgYW5zd2VycyB5b3Ugd2lsbCBnZXQsIGNhbiBoZWxwIG90
aGVyIHBlb3BsZSBmYWNpbmcgdGhlIHNhbWUgcHJvYmxlbSwgc28gaXQncyBpbXBvcnRhbnQgdG8g
a2VlcCB0aGVtIG9uIHB1YmxpYyBtYWlsaW5nIGxpc3RzLg0KDQpPbiBXZWQsIEp1bCAzMSwgMjAy
NCBhdCAxMjo0NjoyN1BNICswMDAwLCC6+sGsx9ogd3JvdGU6DQo+IEhlbGxvIGxpbnV4IGNvbW11
bml0eSBleHBlcnQ6DQo+DQo+IFdoaWNoIGtlcm5lbCBpbnRlcmZhY2UgZG9lcyB0aGUgdXNlciBz
cGFjZSBwcm9ncmFtIGNhbGwgdG8gbW9kaWZ5IGJpbmRfZGVhY3RpdmF0ZWQgdG8gZmFsc2U/DQo+
IEkgdHJhY2VkIHRoZSBrZXJuZWwgY29kZSBhbmQgaGF2ZSBub3QgZm91bmQgd2hlcmUgdG8gbW9k
aWZ5IHRoaXMgdmFsdWUuDQoNCkluIHRoaXMgdmVyeSBzcGVjaWZpYyBjYXNlLCB0aGUgZnVuY3Rp
b24gaXMgYWN0aXZhdGVkIGJ5IGEgY2FsbCB0bw0KdXNiX2Z1bmN0aW9uX2FjdGl2YXRlKCkgaW4g
dXZjX2Z1bmN0aW9uX2Nvbm5lY3QoKSwgaXRzZWxmIGNhbGxlZCBmcm9tDQp1dmNfdjRsMl9zdWJz
Y3JpYmVfZXZlbnQoKSBpbiByZXNwb25zZSB0byB0aGUgYXBwbGljYXRpb24gY2FsbGluZyB0aGUg
VklESU9DX1NVQlNDUklCRV9FVkVOVCBpb2N0bCBvbiB0aGUgdmlkZW8gZGV2aWNlIHRvIHN1YnNj
cmliZSB0byB0aGUgVVZDX0VWRU5UX1NFVFVQIGV2ZW50Lg0KDQpZb3UgY2FuIGZpbmQgYSBzYW1w
bGUgdXNlcnNwYWNlIGFwcGxpY2F0aW9uIG1lYW50IHRvIHdvcmsgd2l0aCB0aGlzIGRyaXZlciBh
dCBodHRwczovL2dpdGxhYi5mcmVlZGVza3RvcC5vcmcvY2FtZXJhL3V2Yy1nYWRnZXQuIE5vdGUg
dGhhdCBJIGhhdmVuJ3QgdXNlZCBpdCBwZXJzb25hbGx5IGZvciBhIGZldyB5ZWFycywgc28gSSBt
YXkgbm90IGJlIGFibGUgdG8gZWFzaWx5IHByb3ZpZGUgZGV0YWlsZWQgdGVjaG5pY2FsIHN1cHBv
cnQuDQoNCj4gLS0tLS3Tyrz+1K28/i0tLS0tDQo+ILeivP7IyzogTGF1cmVudCBQaW5jaGFydCA8
bGF1cmVudC5waW5jaGFydEBpZGVhc29uYm9hcmQuY29tPg0KPiC3osvNyrG85DogMjAyNMTqN9TC
MzHI1SAyMDoyNA0KPiDK1bz+yMs6ILr6wazH2iA8aHVsaWFucWluQHZpdm8uY29tPg0KPiCzrcvN
OiBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsgZGFuLnNjYWxseUBpZGVhc29uYm9hcmQuY29t
Ow0KPiBsaW51eC11c2JAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOw0KPiBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnOyBvcGVuc291cmNlLmtlcm5lbA0KPiA8
b3BlbnNvdXJjZS5rZXJuZWxAdml2by5jb20+DQo+INb3zOI6IFJlOiC08Li0OiBbUEFUQ0ggdjJd
IHVzYjogZ2FkZ2V0OiB1dmM6IEZpeGVzIHRoZSBhYm5vcm1hbCBlbnVtZXJhdGlvbiBwcm9ibGVt
IG9mIG1vYmlsZSBwaG9uZSBhcyBVVkMgY2FtZXJhLg0KPg0KPiBPbiBXZWQsIEp1bCAzMSwgMjAy
NCBhdCAxMTo0OToxMUFNICswMDAwLCC6+sGsx9ogd3JvdGU6DQo+ID4gV2hlbiB0aGUgcGhvbmUg
aXMgY29ubmVjdGVkIHRvIHRoZSBjb21wdXRlciB0byB1c2UgdGhlIHdlYmNhbQ0KPiA+IGZ1bmN0
aW9uLCB0aGUgcGhvbmUgbmVlZHMgdG8gYmUgZW51bWVyYXRlZCBhcyBhIHV2YyBjYW1lcmEgZnVu
Y3Rpb24uDQo+ID4NCj4gPiBCZWNhdXNlIHV2Yy0+ZnVuYy5iaW5kX2RlYWN0aXZhdGVkIGlzIGNv
bmZpZ3VyZWQgYXMgdHJ1ZSBpbiB0aGUNCj4gPiBmX3V2YyBkcml2ZXIgdXZjX2FsbG9jIGZ1bmN0
aW9uLCB0aGUgdXNiX2dhZGdldF9kZWFjdGl2YXRlIGZ1bmN0aW9uDQo+ID4gaXMgY2FsbGVkIGR1
cmluZyB0aGUgZXhlY3V0aW9uIG9mIHRoZSBjb25maWdmc19jb21wb3NpdGVfYmluZA0KPiA+IGZ1
bmN0aW9uIHRvIHNldCBnYWRnZXQtPmRlYWN0aXZhdGVkIHRvIHRydWUsIHdoaWNoIGluIHR1cm4g
Y2F1c2VzDQo+ID4gdGhlIHVzYl9nYWRnZXRfY29ubmVjdF9sb2NrZWQgZnVuY3Rpb24gdG8gZmFp
bCB0byBjYWxsIHRoZQ0KPiA+IGNvcnJlc3BvbmRpbmcgY29udHJvbGxlciBwdWxsdXAgb3BlcmF0
aW9uIChzdWNoIGFzOg0KPiA+IGR3YzNfZ2FkZ2V0X3B1bGx1cCwgbXR1M19nYWRnZXRfcHVsbHVw
KSwgYW5kIHRoZSBVU0IgY2Fubm90IGJlDQo+ID4gZW51bWVyYXRlZCBub3JtYWxseSB1bmRlciB0
aGUgdXZjIGZ1bmN0aW9uIGNvbWJpbmF0aW9uLg0KPiA+DQo+ID4gQWZ0ZXIgYXBwbHlpbmcgdGhp
cyBwYXRjaCwgd2UgbWVhc3VyZWQgdGhhdCB1bmRlciB0aGUgdXZjIGZ1bmN0aW9uLA0KPiA+IHRo
ZSBkd2MzIGNvbnRyb2xsZXIgYW5kIHRoZSBtdHUzIGNvbnRyb2xsZXIgY2FuIGJlIGVudW1lcmF0
ZWQNCj4gPiBub3JtYWxseSwgYW5kIHRoZSB3ZWJjYW0gZnVuY3Rpb24gaXMgbm9ybWFsLg0KPiA+
DQo+ID4gRml4ZXMgdGhpcyBieSByZW1vdmluZyB0aGUgc2V0dGluZyBvZiB1dmMtPmZ1bmMuYmlu
ZF9kZWFjdGl2YXRlZCB0byB0cnVlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTGlhbnFpbiBI
dSA8aHVsaWFucWluQHZpdm8uY29tPg0KPiA+IC0tLQ0KPiA+IHYyOg0KPiA+ICAgLSBBZGQgIkZp
eGVzOiIgdGFnIG9uIHRoZSBjb21taXQNCj4gPiAgIC0gTW9kaWZ5IGRlc2NyaXB0aW9uIGluZm9y
bWF0aW9uLg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl91dmMu
YyB8IDEgLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX3V2Yy5jDQo+ID4gYi9kcml2
ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl91dmMuYw0KPiA+IGluZGV4IDQwMTg3YjcxMTJlNy4u
NmQ2M2JlYTE0MjExIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlv
bi9mX3V2Yy5jDQo+ID4gKysrIGIvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2ZfdXZjLmMN
Cj4gPiBAQCAtMTEwNyw3ICsxMTA3LDYgQEAgc3RhdGljIHN0cnVjdCB1c2JfZnVuY3Rpb24gKnV2
Y19hbGxvYyhzdHJ1Y3QgdXNiX2Z1bmN0aW9uX2luc3RhbmNlICpmaSkNCj4gPiAgICAgdXZjLT5m
dW5jLmRpc2FibGUgPSB1dmNfZnVuY3Rpb25fZGlzYWJsZTsNCj4gPiAgICAgdXZjLT5mdW5jLnNl
dHVwID0gdXZjX2Z1bmN0aW9uX3NldHVwOw0KPiA+ICAgICB1dmMtPmZ1bmMuZnJlZV9mdW5jID0g
dXZjX2ZyZWU7DQo+ID4gLSAgIHV2Yy0+ZnVuYy5iaW5kX2RlYWN0aXZhdGVkID0gdHJ1ZTsNCj4N
Cj4gVGhpcyBpcyBkb25lIG9uIHB1cnBvc2UuIFRoZSBVVkMgZnVuY3Rpb24gcmVxdWlyZXMgYSB1
c2Vyc3BhY2UgY29udHJvbA0KPiBhcHBsaWNhdGlvbiwgc28gdGhlIGZ1bmN0aW9uIGlzIGRlYWN0
aXZhdGVkIGJ5IGRlZmF1bHQgYXQgYmluZCB0aW1lLA0KPiBhbmQgZ2V0cyBhY3RpdmF0ZWQgd2hl
biB0aGUgYXBwbGljYXRpb24gaXMgcmVhZHkuDQo+DQo+IFRoaXMgcGF0Y2ggaXNuJ3QgcmlnaHQu
DQo+DQo+ID4gICAgIHJldHVybiAmdXZjLT5mdW5jOw0KPiA+DQo+ID4gLS0tLS3Tyrz+1K28/i0t
LS0tDQo+ID4gt6K8/sjLOiBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZyA8Z3JlZ2toQGxpbnV4
Zm91bmRhdGlvbi5vcmc+DQo+ID4gt6LLzcqxvOQ6IDIwMjTE6jfUwjMxyNUgMTk6MTMNCj4gPiDK
1bz+yMs6ILr6wazH2iA8aHVsaWFucWluQHZpdm8uY29tPg0KPiA+ILOty806IGFrcG1AbGludXgt
Zm91bmRhdGlvbi5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gb3BlbnNv
dXJjZS5rZXJuZWwgPG9wZW5zb3VyY2Uua2VybmVsQHZpdm8uY29tPg0KPiA+INb3zOI6IFJlOiBb
UEFUQ0ggdjFdIHVzYjogZ2FkZ2V0OiB1dmM6IEZpeGVkIHRoZSBhYm5vcm1hbCBlbnVtZXJhdGlv
biBwcm9ibGVtIG9mIG1vYmlsZSBwaG9uZSBhcyBVVkMgY2FtZXJhLg0KPiA+DQo+ID4gT24gV2Vk
LCBKdWwgMzEsIDIwMjQgYXQgMDg6NDU6MzFBTSArMDAwMCwguvrBrMfaIHdyb3RlOg0KPiA+ID4g
V2hlbiB0aGUgcGhvbmUgaXMgY29ubmVjdGVkIHRvIHRoZSBjb21wdXRlciB0byB1c2UgdGhlIHdl
YmNhbQ0KPiA+ID4gZnVuY3Rpb24sIHRoZSBwaG9uZSBuZWVkcyB0byBiZSBlbnVtZXJhdGVkIGFz
IGEgdXZjIGNhbWVyYSBmdW5jdGlvbi4NCj4gPg0KPiA+IDxzbmlwPg0KPiA+DQo+ID4gTm90ZSwg
d2h5IGFyZW4ndCB5b3UgdXNpbmcgc2NyaXB0cy9nZXRfbWFpbnRhaW5lci5wbCB0byBmaW5kIHRo
ZQ0KPiA+IHByb3BlciBtYWlsaW5nIGxpc3QgYW5kIGRldmVsb3BlcnMgZm9yIHRoaXMgY2hhbmdl
PyAgUGxlYXNlIGRvIHNvLg0KPiA+DQo+ID4gdGhhbmtzLA0KPiA+DQo+ID4gZ3JlZyBrLWgNCg0K
LS0NClJlZ2FyZHMsDQoNCkxhdXJlbnQgUGluY2hhcnQNCg==

