Return-Path: <linux-kernel+bounces-556180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44939A5C211
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 747CD16D599
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2EE84D2B;
	Tue, 11 Mar 2025 13:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="p8m5kc5B"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2070.outbound.protection.outlook.com [40.107.212.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC4870821;
	Tue, 11 Mar 2025 13:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741698725; cv=fail; b=qJzKHMDwYuKET+kMgPvASrfYrjGQ7xIH9iuK5g/VNWvoM30M1N0IwiK/ciT8n+Q0kjYmoEXJxU88t+qcRUC9Ij2XheE+XckbqTPuI1EpvoJm6EuGnPEwLC1ojX/9uwQfnraXT61GrwZ7FmNRR/1gIprXBJwmadkjykq4xFCeeeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741698725; c=relaxed/simple;
	bh=D4HsJIqWPNstPDMbZymBmr4wpvHAbEyzwCiQIq5Mu7A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xtb5JV6pMakeuMkUhYFwMbYxWUTR8G1062m9a0z3ui+lQhUHl9aSpub+e6TYvr+AC1ohlvF3TkURFH1oQvTetMMPT/j8JnYHNMsAiqr4ooNRACMJ/xM9Yu33Hjp2CJ7k87SE9KLIWs5DHDyAGRCX1AYTNDjtik75/i2Ux5+Z6uc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=p8m5kc5B; arc=fail smtp.client-ip=40.107.212.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJLda1S8KXTbJXTXWwVKzvDmFSbsc3SZOiQzcch/DTVj6VelxEA6op+JFOrXsSDNE5UqG2pCHxefDm6M+0wmV0AdFfujBcUXmX6I3RN6qZRixn8OFvHoilUM2cfElaaR6AcgnbvsalSe/GEmF5SEjaRKGbW8wa25h6NSHcgZNkqODh6HfPKVK09ucAFJbnpUzyDgsrccfjFQkjeLOB9bsKehJVkWHLz54kLMxmaxKVHocZQCyXNJ2D+OjqW57pD4Wchs/538Cue3/TBmg5Hk90CRgfEqokhJhsikzok8zubFYtWXZsj98woW9142lmR2n+u7nJT//CxeYCHREsE9BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4HsJIqWPNstPDMbZymBmr4wpvHAbEyzwCiQIq5Mu7A=;
 b=h8tAFPQfNAFpFQa9k1fxHB4+PpVggvaF4nyuxKHF37xXOY1WccS1tBjVwNbCt9SiLDAq5jQtyuXhQdXXEFYmXTSt6AhKGIjZu77hM4AmQdceUQ+WgYczFVxdWO1oVHYSPrOa1KI5voKJOS7F8XI9jHMaL6VUmo32sHuf7DPR1RDyVyRRHJWV6c/V1BGmrOLAuusi7IcvDKT3njUCE45C6bI7JvyulYJ7cAJHHafEXoHjCqAQLbT70Kbt5TndEIYyJ7Ofw8rhAt4GqqQhCeUgbk/RS2pwl3UJzN8KVEeYTozlK+vnZ0wkKsHKr010RqY4cN0ZjskK7+7W5eQWZkbUzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4HsJIqWPNstPDMbZymBmr4wpvHAbEyzwCiQIq5Mu7A=;
 b=p8m5kc5BC26OHrccWUtLKE5PaOvyF8ChJ+t0dJ8OrQy8AaM9itN+tcSnXuqL2e7tQZoxSCcfhhsZCMUjASnDK5JeC9ESLoE04UpyuXFoXdWG1nCKKD2yyZzdn/RwqyE9xIeHOe2/XLePyaJkpoEaZbIhAm7UFtXH7qVm+Kzw0A9L8JKb+YERh0oyRS6rcRbT+Ebp7gNK9Uum4aSI2AeAxqAuyz65wfxd495h1A8Op3cAmLN+vr2KONmqywvG+Yjqb6gC8i6kteiZ4CNbOxPCoB26vYCerJ2uZ1osaSDlyBXFGHai1uK6UVORVs/+W111oogaDmWnY78U29fKeaUk3g==
Received: from BN8PR03MB5073.namprd03.prod.outlook.com (2603:10b6:408:dc::21)
 by SA6PR03MB7639.namprd03.prod.outlook.com (2603:10b6:806:43b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 13:12:01 +0000
Received: from BN8PR03MB5073.namprd03.prod.outlook.com
 ([fe80::7483:7886:9e3d:f62a]) by BN8PR03MB5073.namprd03.prod.outlook.com
 ([fe80::7483:7886:9e3d:f62a%6]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 13:12:00 +0000
From: "Ng, Boon Khai" <boon.khai.ng@altera.com>
To: Johan Hovold <johan@kernel.org>, "Ng, Boon Khai" <boon.khai.ng@intel.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb
	<linux-usb@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
	"Ang, Tien Sung" <tien.sung.ang@altera.com>
Subject: RE: [PATCH v2] USB: serial: ftdi_sio: add support for Altera USB
 Blaster 3
Thread-Topic: [PATCH v2] USB: serial: ftdi_sio: add support for Altera USB
 Blaster 3
Thread-Index: AQHbj3fQWaRa3EaXUUiBYlZ8PQgKqrNtl7IAgAAruYCAACExgIAAChdg
Date: Tue, 11 Mar 2025 13:12:00 +0000
Message-ID:
 <BN8PR03MB5073F74486FBA6814D0F2FA0B4D12@BN8PR03MB5073.namprd03.prod.outlook.com>
References: <20250307154355.30772-1-boon.khai.ng@intel.com>
 <Z8_tDGssqs9DBaPU@hovoldconsulting.com>
 <DM8PR11MB5751B33EF33ED26FD8E63508C1D12@DM8PR11MB5751.namprd11.prod.outlook.com>
 <Z9AtkeGJqFTGMyTB@hovoldconsulting.com>
In-Reply-To: <Z9AtkeGJqFTGMyTB@hovoldconsulting.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR03MB5073:EE_|SA6PR03MB7639:EE_
x-ms-office365-filtering-correlation-id: 0a413e52-ffd6-4321-86cf-08dd609e4f51
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?GkZjUjV64zXngxjUyKmUPfpZAY6RbVAu5DF5yxSnKKF6IPNGGYwcFGgAHeFK?=
 =?us-ascii?Q?WldCE0FYA57JtS5VDo1CUYcioQ/jE5VeUEfxPS98Kb+VpDhOe59/nw7g+pDz?=
 =?us-ascii?Q?4HZ8wa6MzZGtdTLxW79Bji1WrsHzpI4OTnZLJfyifGbqUqgjARNPABJLUwNc?=
 =?us-ascii?Q?QTU509vg1H9gw28c7YTj39JWs3g8TtwEIMioeykIpsXNlbuXS39xu7EyOiP6?=
 =?us-ascii?Q?j8yiKd2jFo2weLhVN1eDNI7UxRDL+59CMqcLm04bU9wYf+9eDMvXZU+Z+DDY?=
 =?us-ascii?Q?L8DiGwnHnrgDuLP8XyqKJ2gUcRIN28pjIAhdPlKkZd7Isv3r9PioyqSFhanf?=
 =?us-ascii?Q?MjNo+iwos1ZjqD3F1cnolZddTAdoR/gun2iGMDHRvpNuJqovxEIRFfpszOuq?=
 =?us-ascii?Q?SYYRy3icIMl0sQUqz3fG6ukRPZUHfgxEf/ReNj3gZp1kldU3sc9QqwPK4KkQ?=
 =?us-ascii?Q?neHTE/UmpcdkmzdZAf7Vcpg1/A9/d+zj/sXguCEgcsZ44NRvIAcZYRN6xu5C?=
 =?us-ascii?Q?Suy9jYRdPIIzoOO7pNN1wmdT/ELG3nOKmKNT4eOBlm6khRYLrWQlKPISkmB6?=
 =?us-ascii?Q?JxPHypXB2sHgM2lZ46ueTLqhAmIrO5uRv+tC+Gcr9HDgNP2/Qax1FV2Xa+NF?=
 =?us-ascii?Q?2HEWaDy+H6L7NqHrJsMSS1eH3fqiKnKJIxOlkIvk1wITTkeyoTm1EuMF55V7?=
 =?us-ascii?Q?L9lu1ypNeGfd38yOteveW+w4tsoRhKIx4EwaG3P7U2MEUQIZTPT7UxOlQteu?=
 =?us-ascii?Q?l/Zdr/frgU0g2UGbjWcc+jolw1pf85n1PhjGN0T5y7FSyv7tdnk7h5aXM/eb?=
 =?us-ascii?Q?AJsDfZXM4KTfYifZwHnHN1x/Svbdrvdu/E3g7KKg6oxMnebqZCAPcJeYTYhh?=
 =?us-ascii?Q?X5GtO/bEMt2WQsbooFYGiq2gS5VKi1zhKNV1P86uYqDuiwHrYe96g+0US9HE?=
 =?us-ascii?Q?BkQORCfqnFMFFW6fLSry18TIhcgcX4NHjE1buCUGqLRalwXkopOJpns77gw3?=
 =?us-ascii?Q?AO6MBOa1l5P8+v8NbZhXR2Q24QSByzceLg77b7wi0Qs13f02P9kizsS/r+XH?=
 =?us-ascii?Q?xLypSBqjL9flLQaBhldcIV1RCPC9rKHtBwO4bvJfiq9kzyRHaxy6/eZt2BEA?=
 =?us-ascii?Q?tOKw7MOIVNlE5lTDsJF4Cl5G570fCvoFvyj74goCpHWVSrBajj3X4DEka/av?=
 =?us-ascii?Q?2LyfzIcWdhoPwMKe1F+uA9jGfZorpbGDQ3YwrzaMaudTOHl2jiYb1gwWzqJF?=
 =?us-ascii?Q?S0y99/OcDJNiO/z3wxAj3fszzghK9BCkzcuJ6YelRc6F+6n7HCaBDUufI8HA?=
 =?us-ascii?Q?GB2IzACAaZUA4zYBiVmkUAF0Yk5vP81WpCXOsfyl8zxE0yU/RYFr+DclA62Q?=
 =?us-ascii?Q?UO4/RO6wzdJQY2KL0OUWtRi1iC5kspVY1+sHqMh6M8gl2JgSVz/qI1IfwZ7D?=
 =?us-ascii?Q?nnji1vx7IFNesIZfNJ7q5P6DvxAwBoOb?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR03MB5073.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LxLet8HN7T+WyMVCVZWlOJQx9kk+NzjuR8/YSVlpAlFVxHBaDxLciV40/6jO?=
 =?us-ascii?Q?hitWIAFz1C+dFV3rpeYiz4o66TC7Rb9Zn5JGG0wvSZtYgaDmAH82MxfP5Lh4?=
 =?us-ascii?Q?REflJXHYktD4i5nQ0A3vw5m89K3PDGMr2CIQXTqObBPR99dfVyF+ZtfLeeAq?=
 =?us-ascii?Q?rzUGzYJ6sJqnSKbUtgYajbybAqQe6KiayjzNzRigZjNxhmYnfOjttYhMzTms?=
 =?us-ascii?Q?e8AuURXO+792MyCjthqthbiSkEwmTeIj59U84mXERFlKJpgR8aCuJSVKAGLl?=
 =?us-ascii?Q?jpUVdHrr6haBrlcCrrtyRmFyXauNQ8u5m9i4PXzwx0dJj+T2jNBlO5nJD+b8?=
 =?us-ascii?Q?JOU5AZ5WvIu4Al67JEdgExSrgkAIz6QWrnpxZ5MrqflpcCV6nnNLDBNRZYl9?=
 =?us-ascii?Q?207h6uWxxcVOxWPxDIwyZOdPzYHsR7VxzVYT14iUDGY8JxVH7TexLyRssKue?=
 =?us-ascii?Q?94fv32LLWwQ8F0Pl0U//YvrceDYQM1qKlsh16IXSkV2nQnBSXiVu8Lumbve0?=
 =?us-ascii?Q?t45RcbOGpBW5CEOqvJNGlafm8BUmw6PckRb66+7PMuVxa2hT/XIm/4r93RA5?=
 =?us-ascii?Q?74t9qO45CohPyAqCCBjnrvgeyL3bEVUldYgc91aL1LTINjVJ6GC3SdJoxv4d?=
 =?us-ascii?Q?enQADewg7/MN5TH+zXFlcaxbfNF4+ehWnc3OqHkPPvZjrFPJO15SJ3YmpX1O?=
 =?us-ascii?Q?apKD0RHeXmhTN79+kVoUcWV2RT70xUTft9lEVJ2S5DjQHpmUasvzbRiSen6R?=
 =?us-ascii?Q?dpyJspq0nDlR+f533wU2s3tFwRl4VEcaMMlkOJN3nDmckFg+zqbvmwnX9Qwv?=
 =?us-ascii?Q?F+OQNmcsX4dDsWV+ZBHgvsba/vwl2qw+VsKqWsLEr3s+VLg13K2fw/U7FoAv?=
 =?us-ascii?Q?7lKhtj3abX2d0KSlhd50cwpyKf2Ev7oKFS2ecGHi07rDe0YkdqhLR9YcWQOV?=
 =?us-ascii?Q?PokNSbc9ZVaXmFRq3ie3RaXbe6U2AG0WX9oxQpLFJoW3qAGijlpC4iCiZOQM?=
 =?us-ascii?Q?FerbSV6mzeNGEW7IPCsZa9MTBWR7+4GVV4M5xertp8gmdH79Pe48EYkS6hK8?=
 =?us-ascii?Q?LMrx/gr+H5ww/SRzdwCiluAuIz/thTZ/Zzhl+jSs2G/dOMogw1DjTGHh+Zmo?=
 =?us-ascii?Q?tA9gVpMN5usZzf+jpl8t/CrSDaWcCEQrzsxzspWyGrAdhCa96ip09XEbTkpv?=
 =?us-ascii?Q?YXCKkKJ+rWounNyl8rsgK81i9ejw+X36vitNMzBeupSHf5ob3XdnikhoZDEp?=
 =?us-ascii?Q?4tPlMOy8m+csfNLMG6UJeiCD6DiEKlJWFtVg8J4YkjSabtF9vnK0rzYQGDKR?=
 =?us-ascii?Q?o+7J6MUsu/zp8gtKQ3TqsKrSH5d7mjYhFymzECFSZbTjrlTooErIWU6Mb8OQ?=
 =?us-ascii?Q?TE3GVr4hrPoC+eK/r41A0h2kU2ZXlWw9EuWXNhOQOZndv8hX+RFO5g1jGNDW?=
 =?us-ascii?Q?/LaQ6BU4YE7cGLIM5npt0ZIuJ6hM38b06YKYe7TL22dbI/qcbjDMsCSM98xU?=
 =?us-ascii?Q?KZii4U7yPSIfax++CB5D7gbSesmt2+mDIHXc4rDv3ASLd75Ph/lkHMJft5+r?=
 =?us-ascii?Q?n1+y5mDc8Oh8y5wJA1EP0bwjCwQarH9kDsS+46nkLiao42MqG/ww1hoz1F21?=
 =?us-ascii?Q?A5YQmbEAtY4KvyR/8wpAOoVTm6S4ttSoXffPf3dMycPa?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR03MB5073.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a413e52-ffd6-4321-86cf-08dd609e4f51
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 13:12:00.7781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7+pSWa2qP8EhYzUIbJSlob1ZB+8KleIaU+Bq/RlQbf2x2NPkH3af8+VMk/gklsOzeKX5uCGy0DVvh3K7cpjqZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7639

> It may still be good to mention the cable in some way as it's not obvious=
 that
> there are both standalone (cable) and embedded variants.

Alright Johan, will keep the USB Blaster 3 cable in the commit message,
and mention about the changes in this commit not including the cable becaus=
e
it does not have UART.

Regards,
Boon Khai

