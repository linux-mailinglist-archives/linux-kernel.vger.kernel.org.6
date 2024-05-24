Return-Path: <linux-kernel+bounces-188660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 102A68CE507
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 14:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34A19B21687
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 12:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8085186253;
	Fri, 24 May 2024 12:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="q+RIaJj5"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2061.outbound.protection.outlook.com [40.107.6.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9FD84FAC;
	Fri, 24 May 2024 12:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716552224; cv=fail; b=D/yZh1nRoadboCICe/EM2o9eViI3mQdzuP9+/XAPPhXbdcpM5h4vJtIis5LnrtaiLArLfDsgC/03Xaz62dZ3dy5SI9cWoarulrh4Xcwi4xY63LwX8OrTfnowhjhKgwby3VfumyWKmtmEBif1UVcctzTG1Pe5tRnwO5RY+9+zI44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716552224; c=relaxed/simple;
	bh=yH/p0BAgZh5invOSazTapV9/6pfSUaBZjqsQNq7a3g0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QOWHUtNv7cUIErLIMfncGAIQtO/lbY2lpv2EI16GZ5BgBknACvYKHh8Ff8U0HZQZsRgWOTCwY0wkzcvvuW/lyIIwx4nnR1AYkiNChkNLbqRnnFtvkVDK4jl9Ds0cQjz1oEk9fmoflpbFV5Ge/7BWRgV+0LOV2nx7wSddcfZDBa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=q+RIaJj5; arc=fail smtp.client-ip=40.107.6.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TkT/Hb9sihMyym+wVKsRYWsJThs28parrwH8cHTNtqHjLV+qLn6FJDMwc1ikk0vx5OKu88sogE5gha8EDENnxfMzguDP2zo2UHdiMLBzAPfhAAjNkpTftKEDH2X8SBT7Hmq+w7UunB0ODANo0I2FChS3gY4XSPpRDGmUh2PtxLIU0kMGfcrxaYJ1Z9IxPRPBEsR2CtzbGcnRZCVOL44XRuukBkzHOkA0RKMKGkbBrE0xV3KrjE7mKFHhWNyjl3r4k7vDK3mFd+Ri3ZIixR/d899YmqvCpCi1QUjednRf6K7xQ1VkKZifqg7iyLouwm+nuax+s32spShwZhwBQWVuNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q83jT+ZoKl7/QJN1bhdYmnXLlfSxzTO/7vsvYip7kG0=;
 b=Cv6fjzPSnJP++P1YLhe0atcEgvZF3FcaBdahpc7nRIkhbfQCUAYN/FhTeIVgc/UVIINI3S+H+Ut+kizaN7mcyA4w+8hHVEvrvjvXrngncuys82wYVCoAB4ultoN8ONML+AN3NPst8ZRwA0L8TmE6prENkJSRL9dxcC/8HeNeIdF0m4mFNmhWJzeefAwkDThU+JUk7CbBTVWmcRti+LO6fHk49KhToE1TpZFs0X2fp4bGdJMbxPTxHKVdBjaVvI24Uvbb0njmrKyxiRTpbkiV3ciQ727B5hhIUGoCgayTMXsHH8wTngQ9ip+Z1edsmlGet/H2qsttfibduM0QAQpjqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q83jT+ZoKl7/QJN1bhdYmnXLlfSxzTO/7vsvYip7kG0=;
 b=q+RIaJj52+L6yRAOrWgLFtQTKYaQtDSrgc3ytETzcWFjFzvIBKXkqlL4hOKt/oRBgCol4LBe4Hi4ZaWL0rJB2b/ua9QPKkN8PEArcAU4oM3A7UHvgQ5BW8O4VQZQGvRWYdSCsB0kkA8ROpnSrg/Z1sj9rKRUsl9ewdT76jN0gSM=
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by AS5PR04MB9876.eurprd04.prod.outlook.com (2603:10a6:20b:678::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 12:03:36 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%4]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 12:03:35 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
CC: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Pengutronix Kernel
 Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v2 5/5] firmware: imx: adds miscdev
Thread-Topic: [EXT] Re: [PATCH v2 5/5] firmware: imx: adds miscdev
Thread-Index: AQHarP9e6ZcFPGAJSk+wtTuaFLEKr7GmDUYAgAAXzHA=
Date: Fri, 24 May 2024 12:03:35 +0000
Message-ID:
 <AM9PR04MB8604C000F464CF1F5788901995F52@AM9PR04MB8604.eurprd04.prod.outlook.com>
References: <20240523-imx-se-if-v2-0-5a6fd189a539@nxp.com>
 <20240523-imx-se-if-v2-5-5a6fd189a539@nxp.com>
 <ZlBOeAnkrn4ki7Wv@pengutronix.de>
In-Reply-To: <ZlBOeAnkrn4ki7Wv@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8604:EE_|AS5PR04MB9876:EE_
x-ms-office365-filtering-correlation-id: 33e07dd7-e6a3-4432-4d74-08dc7be98a51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|1800799015|7416005|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?7TRYRDvk83q5NKW4O3EHCf+1XjBkcmqhTimeH7AoaHnHK/XxRFdD6/v9z8L4?=
 =?us-ascii?Q?vY4HRyNROVDouc7tulLSSYn9kZCGJzxnG3FtwtL9d+R8EHbZqp9SXmitdd0R?=
 =?us-ascii?Q?5O+BnzIiB7fMjWIdb7id+Vh+Dx7PQRLEi+oXzOgZb84H+TxDHiKV6MQqxuc+?=
 =?us-ascii?Q?kDNIqGS3+hGs5NEWEMpViHdooFWiA+OtxKrc3NJ3GURSuB+QeVmOycFww0xP?=
 =?us-ascii?Q?IXgZG/oMp8UhYJ90VNNH350QuYPEbNKMQYTvVi4dqVHS69WuwpP1AD+866N7?=
 =?us-ascii?Q?j30K8MhEsBMXQ7a0wQd9+259/NbJUCxLvE57oARBQ1nLtV2G33oKfi14Y/mn?=
 =?us-ascii?Q?BGt/YOU/BUrT+9bOj7Bjl6Q0ShuMZws2XAy+BY+dzF/VgRLQ0erxadgtl/Q1?=
 =?us-ascii?Q?kt95Q1ITvZ1oAltN8tZV5yYwlGecUN1iEExwt43T3c+3OFgaZ4pJrsQ3Ph+0?=
 =?us-ascii?Q?jbd70sPuaZ1WIkmYPc05WxAESsA7Y6yqkaET9pw4vTQejrgKdTdMIXwU/naE?=
 =?us-ascii?Q?2yIgsk1CnrxKuzEYfiC41XkkCgQEL35FruQLlSEf8hGLmM3DNRDu6XfgayIY?=
 =?us-ascii?Q?i8bJ1v3vKlCq5/ZKzrfggXqGta2w8FsXYpGlPoekU7poMPXDlyxQwnFPQuLr?=
 =?us-ascii?Q?Mzi097pd3QFUHYo/Ex1TTq13dEcc4YxZYDKL8fNLnR7U1nxDGitVkr8zh9cd?=
 =?us-ascii?Q?9/DuM+qyYOy3I9jDnRE35cmlA4JF9SYax1n94G/Ml8SgSZRY0TzO08FpXVpx?=
 =?us-ascii?Q?DEcwqv+P1/lHhoaTQ60Ot7PWS1WoZJrmqdWdJwoqvajtxMdiNDJTscZU9H2b?=
 =?us-ascii?Q?4LblKCekfkE+hohXe5+w2kDFrKqTv4e/XMck4ti1D39KPltXZ4a/QelHcg2m?=
 =?us-ascii?Q?qW3fKMiigr6z4eg3l3ZDA1/ZV+GOOMJbn5MEaz77laesZLA11VTsfAMntJBu?=
 =?us-ascii?Q?4XyOW7fNNm21V6kumlu1DNHgTU0FonSDrt7Vz+/gaqtzO4FPVztZ+GLiqdbm?=
 =?us-ascii?Q?wp+QlgTTYFFXgtlf9GIVaTa6narL6WAmJQqps9aGSyJsMTUAW9kkNrZNnAun?=
 =?us-ascii?Q?yf/I8Jk4SvUONVYib8OXS9zFUlFuH95V0qcSF6MO8S+cyrBON0BdrJ7wlG0x?=
 =?us-ascii?Q?niHks4KYlL9O0FbxZOB+6qC54liAXWyKI8+gljumV3ZMFzxUcFB5Ps0nAxjM?=
 =?us-ascii?Q?ZqJmnyFBrbbXTVSNlhUuIarrVEDAesoGYwpnyXvh/lpeeK9O+Ui9j1WODXQh?=
 =?us-ascii?Q?Y3WEPCt1ddaajSU+yULd1V2Kj6WD4J4/DEqCvkA/Yg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?FPj8wz1od0ixa/lL6EpbKjZ9wzCIW12YjATz8/CfrNlim7INGU4Fq1NlIHj2?=
 =?us-ascii?Q?7Hrm5BhLZFhAyss5Eoky1iG75DY/GVxO/gXaIb6Altdr7POebsTpx4j8LidT?=
 =?us-ascii?Q?Dw4GIGYCTS8Mb0i46bTlLgv+8wx+cGtp/GMGo7LwcQurrk/akCE9SNTGqQ1Z?=
 =?us-ascii?Q?orU+PtkITd9XlNUMZwhuq3O/C5OfPQZZpLV0VRkIDHWO7YnfcNUxzL1i6lrQ?=
 =?us-ascii?Q?lc94NlmAOBsbp8NwCk9OWYLJuvV1KZypHymaDN9+RAQknXr2yMHQgLfe/C1N?=
 =?us-ascii?Q?2zBEP/1f2TxOtWoMoS3trn5gBBNEVMNAOAScw52tMdFiqh2tkkCHQa4cFFhV?=
 =?us-ascii?Q?Av3eYRK3JY/ZzmJ+VPFSuq0hN09i9T7depn0t44ELqC1kB0A/+UGPZC/A0Wg?=
 =?us-ascii?Q?wqfZuDlKguq6m23viPSlyt4zhWPrTKTicpxOOM7VMx9eFXo2FNRYDiF4oe/p?=
 =?us-ascii?Q?KvGOW5fZZvchWbIEMnf8Gg8fxkbHVRPIrNOrZz1MJHZnM7m51G60JnPqiekP?=
 =?us-ascii?Q?mxh1G+zboak+7d2E8flzooWUSsaAJDa2CPNecp7P0l4g7MMTS6yZ5cQicXIH?=
 =?us-ascii?Q?e6ch69cTtlAIGfYn4yVi0zATjqxnEiYXMhcX7bAC7n1XYxNLyFgOvmNlCxjF?=
 =?us-ascii?Q?m9sXlaTi5Yxe3753t/ebbgFW2vHqZCgggzhoWYoxtZdo1YT2RRIn1Uem+Pg9?=
 =?us-ascii?Q?Hb5FT1MoRIKUaV+/+Dw61AdNyAxbVBxInDEi93S4p9L1Fi/uxRyqSuEeYCnj?=
 =?us-ascii?Q?0WWOq06dun9DUNyuQgdb/rCUiXzqi0SYnC6VXzIabb8f0NRNwk1T3JNFUmik?=
 =?us-ascii?Q?1OFykNDhalWgJELAWqW5cqSHaHvuo7Fm8ErKq66LLjx6ET8hNw6HrAEJfFnb?=
 =?us-ascii?Q?VGtuZA4D9hH0ampMZSoCFtWGn98NZsQL5VFEdk/vuSGa9DQFgB92tRFBB6PD?=
 =?us-ascii?Q?17NB0uHcd88RjP1viKKzzPtvh8f17VXmnhef7UOLwCoVe/psXoktFUrhhMMV?=
 =?us-ascii?Q?7CvSkw292Q/1Qv8QLGQKd83Ob6l9bu3PQexi6ynaLwswDLMaxXLI0lXm4H/X?=
 =?us-ascii?Q?nHiQkvgo4cfm9sAQT+iWlvLpp0OrwWDKFzZx0CY8PDavywTY+Y+UMmmCf4wO?=
 =?us-ascii?Q?l7nFSu6wxR7QDFrJU0XTd0lp+TBUFA2Qt89W1PkWePDo7wOVC71Lb7L/7Ni+?=
 =?us-ascii?Q?LYVXXYyUvFr5vGNh4yT4zsHc5YBCXEI4DM6ZZhD9MMgtfiRnDFheVWu8DERn?=
 =?us-ascii?Q?NI8/12nXxDH0qrljaNwvRrK7xAcQ+sd5duUhEGzg6DlNwS2GxJ0FiCKAne7c?=
 =?us-ascii?Q?BbvsPYuwWyXAbCk0tWibytAptBS6gOBD5Xlv4Y5JYjDV6jc3JV3q4aOqn4i4?=
 =?us-ascii?Q?T6XqB8R7o+pJwpzOEOGY42KFB5FWepWIl8pWwh+I8l2sGlm+p4D1XWdEFcDK?=
 =?us-ascii?Q?qJzbc/YUVCRD1hh0H9O42IzdusaxM+eD7vsvcuXINJIOlhJZtbG5suUwQBDB?=
 =?us-ascii?Q?TT210zE4RWbm4kUXaYgrHwBokQZvmLqsz6ZytgiSLJxlnqDow0NzFxbVNOXR?=
 =?us-ascii?Q?QRw07Lk81PU2HGV3Ah55yKnJ5zfx37T3lRBAo3/Z?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e07dd7-e6a3-4432-4d74-08dc7be98a51
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 12:03:35.7588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: awFEjEfxdCE0GU41xFLos6DTJZxrgiYd0M5EfoPjoMjUDgIPS2SQJciqV9NHMbhl5Q3Hx8x0TUvsYajZtlhqCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9876



> -----Original Message-----
> From: Sascha Hauer <s.hauer@pengutronix.de>
> Sent: Friday, May 24, 2024 1:53 PM
> To: Pankaj Gupta <pankaj.gupta@nxp.com>
> Cc: Jonathan Corbet <corbet@lwn.net>; Rob Herring <robh+dt@kernel.org>;
> Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
> <conor+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>; Pengutronix
> Kernel Team <kernel@pengutronix.de>; Fabio Estevam
> <festevam@gmail.com>; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski
> <krzk+dt@kernel.org>; linux-doc@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org; imx@lists.linux.dev;
> linux-arm-kernel@lists.infradead.org
> Subject: [EXT] Re: [PATCH v2 5/5] firmware: imx: adds miscdev
>
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>
>
> On Thu, May 23, 2024 at 04:19:36PM +0530, Pankaj Gupta wrote:
> > +int imx_ele_miscdev_msg_send(struct se_if_device_ctx *dev_ctx,
> > +                          void *tx_msg, int tx_msg_sz) {
> > +     struct se_if_priv *priv =3D dev_ctx->priv;
> > +     struct se_msg_hdr *header;
> > +     int err;
> > +
> > +     header =3D (struct se_msg_hdr *) tx_msg;
> > +
> > +     /*
> > +      * Check that the size passed as argument matches the size
> > +      * carried in the message.
> > +      */
> > +     err =3D header->size << 2;
> > +
> > +     if (err !=3D tx_msg_sz) {
> > +             err =3D -EINVAL;
> > +             dev_err(priv->dev,
> > +                     "%s: User buffer too small\n",
> > +                             dev_ctx->miscdev.name);
> > +             goto exit;
> > +     }
> > +     /* Check the message is valid according to tags */
> > +     if (header->tag =3D=3D priv->cmd_tag) {
> > +             mutex_lock(&priv->se_if_cmd_lock);
>
> Grabbing a mutex in a character devices write fop and releasing it in the=
 read
> fop is really calling for undesired race conditions.

Condition is:
- Only one command is allowed to be in flight, at a time per interface.
   -- Second command is not allowed, when one command is in flight.
- Duration of the flight is till the time the response is not received from=
 the FW.

Command lock is grabbed and then released in process context only.

>
> If sending a command and receiving the response shall be an atomic operat=
ion
> then you should really consider turning this into an ioctl and just not
> implement read/write on the character device. With this you'll be able to=
 get
> rid of several oddities in this drivers locking.
>

It is not an atomic operation. It can be pre-empted.
But it cannot be pre-empted to send another command on the same interface.

As only one command is allowed to be executed at one point in time, through=
 an interface.


> > +             priv->waiting_rsp_dev =3D dev_ctx;
> > +     } else if (header->tag =3D=3D priv->rsp_tag) {
> > +             /* Check the device context can send the command */
> > +             if (dev_ctx !=3D priv->cmd_receiver_dev) {
> > +                     dev_err(priv->dev,
> > +                             "%s: Channel not configured to send resp =
to FW.",
> > +                             dev_ctx->miscdev.name);
> > +                     err =3D -EPERM;
> > +                     goto exit;
> > +             }
> > +     } else {
> > +             dev_err(priv->dev,
> > +                     "%s: The message does not have a valid TAG\n",
> > +                             dev_ctx->miscdev.name);
> > +             err =3D -EINVAL;
> > +             goto exit;
> > +     }
> > +     err =3D imx_ele_msg_send(priv, tx_msg);
> > +     if (err < 0) {
> > +             if (header->tag =3D=3D priv->cmd_tag) {
> > +                     priv->waiting_rsp_dev =3D NULL;
> > +                     mutex_unlock(&dev_ctx->priv->se_if_cmd_lock);
> > +             }
> > +     } else
> > +             err =3D header->size << 2;
> > +exit:
> > +     return err;
> > +}
> > +
>
> [...]
>
> > +static ssize_t se_if_fops_write(struct file *fp, const char __user *bu=
f,
> > +                             size_t size, loff_t *ppos) {
> > +     struct se_api_msg *tx_msg __free(kfree);

Accepted. Will correct in V3.
Initialize tx_msg with NULL.

> > +     struct se_if_device_ctx *dev_ctx;
> > +     struct se_if_priv *priv;
> > +     int err;
> > +
> > +     dev_ctx =3D container_of(fp->private_data,
> > +                            struct se_if_device_ctx,
> > +                            miscdev);
> > +     priv =3D dev_ctx->priv;
> > +     dev_dbg(priv->dev,
> > +             "%s: write from buf (%p)%zu, ppos=3D%lld\n",
> > +                     dev_ctx->miscdev.name,
> > +                     buf, size, ((ppos) ? *ppos : 0));
> > +
> > +     if (down_interruptible(&dev_ctx->fops_lock))
> > +             return -EBUSY;
> > +
> > +     if (dev_ctx->status !=3D SE_IF_CTX_OPENED) {
> > +             err =3D -EINVAL;
> > +             goto exit;
> > +     }
> > +
> > +     if (size < SE_MU_HDR_SZ) {
> > +             dev_err(priv->dev,
> > +                     "%s: User buffer too small(%zu < %d)\n",
> > +                             dev_ctx->miscdev.name,
> > +                             size, SE_MU_HDR_SZ);
> > +             err =3D -ENOSPC;
> > +             goto exit;
> > +     }
> > +     tx_msg =3D memdup_user(buf, size);
> > +     if (!tx_msg) {
> > +             err =3D -ENOMEM;
> > +             goto exit;
> > +     }
>
> memdup_user() returns an error pointer, not NULL. Also you are using tx_m=
sg
> uninitialized.
>
Accepted. Will correct in V3.

> > +
> > +     print_hex_dump_debug("from user ", DUMP_PREFIX_OFFSET, 4, 4,
> > +                          tx_msg, size, false);
> > +
> > +     err =3D imx_ele_miscdev_msg_send(dev_ctx, tx_msg, size);
> > +
> > +exit:
> > +     up(&dev_ctx->fops_lock);
> > +     return err;
> > +}
> > +
> > +/*
> > + * Read a message from the MU.
> > + * Blocking until a message is available.
> > + */
> > +static ssize_t se_if_fops_read(struct file *fp, char __user *buf,
> > +                            size_t size, loff_t *ppos) {
> > +     struct se_if_device_ctx *dev_ctx;
> > +     struct se_buf_desc *b_desc;
> > +     struct se_if_priv *priv;
> > +     u32 size_to_copy;
> > +     int err;
> > +
> > +     dev_ctx =3D container_of(fp->private_data,
> > +                            struct se_if_device_ctx,
> > +                            miscdev);
> > +     priv =3D dev_ctx->priv;
> > +     dev_dbg(priv->dev,
> > +             "%s: read to buf %p(%zu), ppos=3D%lld\n",
> > +                     dev_ctx->miscdev.name,
> > +                     buf, size, ((ppos) ? *ppos : 0));
> > +
> > +     if (down_interruptible(&dev_ctx->fops_lock))
> > +             return -EBUSY;
> > +
> > +     if (dev_ctx->status !=3D SE_IF_CTX_OPENED) {
> > +             err =3D -EINVAL;
> > +             goto exit;
> > +     }
> > +
> > +     err =3D imx_ele_miscdev_msg_rcv(dev_ctx);
> > +     if (err)
> > +             goto exit;
> > +
> > +     /* Buffer containing the message from FW, is
> > +      * allocated in callback function.
> > +      * Check if buffer allocation failed.
> > +      */
> > +     if (!dev_ctx->temp_resp) {
> > +             err =3D -ENOMEM;
> > +             goto exit;
> > +     }
> > +
> > +     dev_dbg(priv->dev,
> > +                     "%s: %s %s\n",
> > +                     dev_ctx->miscdev.name,
> > +                     __func__,
> > +                     "message received, start transmit to user");
> > +
> > +     /*
> > +      * Check that the size passed as argument is larger than
> > +      * the one carried in the message.
> > +      */
> > +     size_to_copy =3D dev_ctx->temp_resp_size << 2;
> > +     if (size_to_copy > size) {
> > +             dev_dbg(priv->dev,
> > +                     "%s: User buffer too small (%zu < %d)\n",
> > +                             dev_ctx->miscdev.name,
> > +                             size, size_to_copy);
> > +             size_to_copy =3D size;
> > +     }
> > +
> > +     /*
> > +      * We may need to copy the output data to user before
> > +      * delivering the completion message.
> > +      */
> > +     while (!list_empty(&dev_ctx->pending_out)) {
> > +             b_desc =3D list_first_entry_or_null(&dev_ctx->pending_out=
,
> > +                                               struct se_buf_desc,
> > +                                               link);
> > +             if (!b_desc)
> > +                     continue;
>
> b_desc will never be NULL because otherwise you wouldn't be in the loop
> anymore. The usual way to iterate over a list is to use list_for_each_ent=
ry() or
> list_for_each_entry_safe() in case you delete entries in the loop body.
>

Will remove the NULL check.
        if (!b_desc)
               continue;


> > +
> > +             if (b_desc->usr_buf_ptr && b_desc->shared_buf_ptr) {
> > +
> > +                     dev_dbg(priv->dev,
> > +                             "%s: Copy output data to user\n",
> > +                             dev_ctx->miscdev.name);
> > +                     if (copy_to_user(b_desc->usr_buf_ptr,
> > +                                      b_desc->shared_buf_ptr,
> > +                                      b_desc->size)) {
> > +                             dev_err(priv->dev,
> > +                                     "%s: Failure copying output data =
to user.",
> > +                                     dev_ctx->miscdev.name);
> > +                             err =3D -EFAULT;
> > +                             goto exit;
> > +                     }
> > +             }
> > +
> > +             if (b_desc->shared_buf_ptr)
> > +                     memset(b_desc->shared_buf_ptr, 0, b_desc->size);
> > +
> > +             __list_del_entry(&b_desc->link);
>
> list_del()


>
> > +             kfree(b_desc);
> > +     }
> > +
> > +     /* Copy data from the buffer */
> > +     print_hex_dump_debug("to user ", DUMP_PREFIX_OFFSET, 4, 4,
> > +                          dev_ctx->temp_resp, size_to_copy, false);
> > +     if (copy_to_user(buf, dev_ctx->temp_resp, size_to_copy)) {
> > +             dev_err(priv->dev,
> > +                     "%s: Failed to copy to user\n",
> > +                             dev_ctx->miscdev.name);
> > +             err =3D -EFAULT;
> > +             goto exit;
> > +     }
> > +
> > +     err =3D size_to_copy;
> > +     kfree(dev_ctx->temp_resp);
> > +
> > +     /* free memory allocated on the shared buffers. */
> > +     dev_ctx->secure_mem.pos =3D 0;
> > +     dev_ctx->non_secure_mem.pos =3D 0;
> > +
> > +     dev_ctx->pending_hdr =3D 0;
> > +
> > +exit:
> > +     /*
> > +      * Clean the used Shared Memory space,
> > +      * whether its Input Data copied from user buffers, or
> > +      * Data received from FW.
> > +      */
> > +     while (!list_empty(&dev_ctx->pending_in) ||
> > +            !list_empty(&dev_ctx->pending_out)) {
> > +             if (!list_empty(&dev_ctx->pending_in))
> > +                     b_desc =3D list_first_entry_or_null(&dev_ctx->pen=
ding_in,
> > +                                                       struct se_buf_d=
esc,
> > +                                                       link);
> > +             else
> > +                     b_desc =3D list_first_entry_or_null(&dev_ctx->pen=
ding_out,
> > +                                                       struct se_buf_d=
esc,
> > +                                                       link);
> > +
> > +             if (!b_desc)
> > +                     continue;
> > +
> > +             if (b_desc->shared_buf_ptr)
> > +                     memset(b_desc->shared_buf_ptr, 0, b_desc->size);
> > +
> > +             __list_del_entry(&b_desc->link);
> > +             kfree(b_desc);
> > +     }
> > +
> > +     up(&dev_ctx->fops_lock);
> > +     return err;
> > +}
> > +
> > +static int se_ioctl_get_mu_info(struct se_if_device_ctx *dev_ctx,
> > +                             u64 arg) {
> > +     struct se_if_priv *priv =3D dev_get_drvdata(dev_ctx->dev);
> > +     struct imx_se_node_info *if_node_info;
> > +     struct se_ioctl_get_if_info info;
> > +     int err =3D 0;
> > +
> > +     if_node_info =3D (struct imx_se_node_info *)priv->info;
>
> priv->info is of type const void *. You are casting away the the 'const'
> here. Either it is const, then it should stay const, or not, in which cas=
e it
> shouldn't be declared const. Also why isn't priv->info of type struct
> imx_se_node_info * in the first place?

This struct definition is local to the file se_ctrl.c.
Declaration of imx_se_node_info, is fixed by adding const in the whole file=
.

>
> > +
> > +     info.se_if_id =3D if_node_info->se_if_id;
> > +     info.interrupt_idx =3D 0;
> > +     info.tz =3D 0;
> > +     info.did =3D if_node_info->se_if_did;
> > +     info.cmd_tag =3D if_node_info->cmd_tag;
> > +     info.rsp_tag =3D if_node_info->rsp_tag;
> > +     info.success_tag =3D if_node_info->success_tag;
> > +     info.base_api_ver =3D if_node_info->base_api_ver;
> > +     info.fw_api_ver =3D if_node_info->fw_api_ver;
> > +
> > +     dev_dbg(priv->dev,
> > +             "%s: info [se_if_id: %d, irq_idx: %d, tz: 0x%x, did: 0x%x=
]\n",
> > +                     dev_ctx->miscdev.name,
> > +                     info.se_if_id, info.interrupt_idx, info.tz,
> > + info.did);
> > +
> > +     if (copy_to_user((u8 *)arg, &info, sizeof(info))) {
> > +             dev_err(dev_ctx->priv->dev,
> > +                     "%s: Failed to copy mu info to user\n",
> > +                             dev_ctx->miscdev.name);
>
> Just drop these error messages for failed copy_to_user(). They don't give=
 any
> valuable information and just bloat the code.
Accepted. Will correct in v3.

>
> > +             err =3D -EFAULT;
> > +             goto exit;
> > +     }
> > +
> > +exit:
> > +     return err;
> > +}
> > +
> > +/*
> > + * Copy a buffer of data to/from the user and return the address to
> > +use in
> > + * messages
> > + */
> > +static int se_ioctl_setup_iobuf_handler(struct se_if_device_ctx *dev_c=
tx,
> > +                                         u64 arg) {
> > +     struct se_shared_mem *shared_mem =3D NULL;
> > +     struct se_ioctl_setup_iobuf io =3D {0};
> > +     struct se_buf_desc *b_desc =3D NULL;
> > +     int err =3D 0;
> > +     u32 pos;
> > +
> > +     if (copy_from_user(&io, (u8 *)arg, sizeof(io))) {
> > +             dev_err(dev_ctx->priv->dev,
> > +                     "%s: Failed copy iobuf config from user\n",
> > +                             dev_ctx->miscdev.name);
> > +             err =3D -EFAULT;
> > +             goto exit;
> > +     }
> > +
> > +     dev_dbg(dev_ctx->priv->dev,
> > +                     "%s: io [buf: %p(%d) flag: %x]\n",
> > +                     dev_ctx->miscdev.name,
> > +                     io.user_buf, io.length, io.flags);
> > +
> > +     if (io.length =3D=3D 0 || !io.user_buf) {
> > +             /*
> > +              * Accept NULL pointers since some buffers are optional
> > +              * in FW commands. In this case we should return 0 as
> > +              * pointer to be embedded into the message.
> > +              * Skip all data copy part of code below.
> > +              */
> > +             io.ele_addr =3D 0;
> > +             goto copy;
> > +     }
> > +
> > +     /* Select the shared memory to be used for this buffer. */
> > +     if (io.flags & SE_MU_IO_FLAGS_USE_SEC_MEM) {
>
> If you don't support this flag (yet), just don't include it in your submi=
ssion.

Accepted. Will remove it in V3.
>
> > +             /* App requires to use secure memory for this buffer.*/
> > +             dev_err(dev_ctx->priv->dev,
> > +                     "%s: Failed allocate SEC MEM memory\n",
> > +                             dev_ctx->miscdev.name);
> > +             err =3D -EFAULT;
> > +             goto exit;
> > +     } else {
> > +             /* No specific requirement for this buffer. */
> > +             shared_mem =3D &dev_ctx->non_secure_mem;
> > +     }
> > +
> > +     /* Check there is enough space in the shared memory. */
> > +     if (shared_mem->size < shared_mem->pos
> > +                     || io.length >=3D shared_mem->size - shared_mem->=
pos) {
> > +             dev_err(dev_ctx->priv->dev,
> > +                     "%s: Not enough space in shared memory\n",
> > +                             dev_ctx->miscdev.name);
> > +             err =3D -ENOMEM;
> > +             goto exit;
> > +     }
> > +
> > +     /* Allocate space in shared memory. 8 bytes aligned. */
> > +     pos =3D shared_mem->pos;
> > +     shared_mem->pos +=3D round_up(io.length, 8u);
>
> You are checking if there's enough space in the shared memory without tak=
ing
> this round_up into account.

Yes. It is initializing the local variable 'pos', with last store value of =
shared_mem->pos.

>
> > +     io.ele_addr =3D (u64)shared_mem->dma_addr + pos;
> > +
> > +     if ((io.flags & SE_MU_IO_FLAGS_USE_SEC_MEM) &&
> > +         !(io.flags & SE_MU_IO_FLAGS_USE_SHORT_ADDR)) {
> > +             /*Add base address to get full address.*/
> > +             dev_err(dev_ctx->priv->dev,
> > +                     "%s: Failed allocate SEC MEM memory\n",
> > +                             dev_ctx->miscdev.name);
> > +             err =3D -EFAULT;
> > +             goto exit;
> > +     }
> > +
> > +     memset(shared_mem->ptr + pos, 0, io.length);
> > +     if ((io.flags & SE_IO_BUF_FLAGS_IS_INPUT) ||
> > +         (io.flags & SE_IO_BUF_FLAGS_IS_IN_OUT)) {
> > +             /*
> > +              * buffer is input:
> > +              * copy data from user space to this allocated buffer.
> > +              */
> > +             if (copy_from_user(shared_mem->ptr + pos, io.user_buf,
> > +                                io.length)) {
> > +                     dev_err(dev_ctx->priv->dev,
> > +                             "%s: Failed copy data to shared memory\n"=
,
> > +                             dev_ctx->miscdev.name);
> > +                     err =3D -EFAULT;
> > +                     goto exit;
> > +             }
> > +     }
> > +
> > +     b_desc =3D kzalloc(sizeof(*b_desc), GFP_KERNEL);
> > +     if (!b_desc) {
> > +             err =3D -ENOMEM;
> > +             goto exit;
> > +     }
> > +
> > +copy:
> > +     /* Provide the EdgeLock Enclave address to user space only if suc=
cess.*/
> > +     if (copy_to_user((u8 *)arg, &io, sizeof(io))) {
> > +             dev_err(dev_ctx->priv->dev,
> > +                     "%s: Failed to copy iobuff setup to user\n",
> > +                             dev_ctx->miscdev.name);
> > +             kfree(b_desc);
> > +             err =3D -EFAULT;
> > +             goto exit;
> > +     }
> > +
> > +     if (b_desc) {
> > +             b_desc->shared_buf_ptr =3D shared_mem->ptr + pos;
> > +             b_desc->usr_buf_ptr =3D io.user_buf;
> > +             b_desc->size =3D io.length;
> > +
> > +             if (io.flags & SE_IO_BUF_FLAGS_IS_INPUT) {
> > +                     /*
> > +                      * buffer is input:
> > +                      * add an entry in the "pending input buffers" li=
st so
> > +                      * that copied data can be cleaned from shared me=
mory
> > +                      * later.
> > +                      */
> > +                     list_add_tail(&b_desc->link, &dev_ctx->pending_in=
);
> > +             } else {
> > +                     /*
> > +                      * buffer is output:
> > +                      * add an entry in the "pending out buffers" list=
 so data
> > +                      * can be copied to user space when receiving Sec=
ure-Enclave
> > +                      * response.
> > +                      */
> > +                     list_add_tail(&b_desc->link, &dev_ctx->pending_ou=
t);
> > +             }
> > +     }
> > +
> > +exit:
> > +     return err;
> > +}
> > +
> > +/* IOCTL to provide SoC information */ static int
> > +se_ioctl_get_se_soc_info_handler(struct se_if_device_ctx *dev_ctx,
> > +                                          u64 arg) {
> > +     struct imx_se_node_info_list *info_list;
> > +     struct se_ioctl_get_soc_info soc_info;
> > +     int err =3D -EINVAL;
> > +
> > +     info_list =3D (struct imx_se_node_info_list *)
> > +                     device_get_match_data(dev_ctx->priv->dev);
>
> device_get_match_data() returns a const void *. It is generally not neces=
sary
> to explicitly cast void * to another pointer type. By explicitly casting =
it you just
> cast away the 'const' without noticing.


Accepted. Will correct it v3.

>
> > +     if (!info_list)
> > +             goto exit;
> > +
> > +     soc_info.soc_id =3D info_list->soc_id;
> > +     soc_info.soc_rev =3D dev_ctx->priv->soc_rev;
> > +
> > +     err =3D (int)copy_to_user((u8 *)arg, (u8 *)(&soc_info),
> > + sizeof(soc_info));
>
> First argument of copy_to_user() is a void *, then why do you cast it to
> something entirely unrelated (u8)? Second argument is a void * as well, s=
o no
> need to explicitly cast.

Accepted, will correct in v3.

>
> > +     if (err) {
> > +             dev_err(dev_ctx->priv->dev,
> > +                     "%s: Failed to copy soc info to user\n",
> > +                     dev_ctx->miscdev.name);
> > +             err =3D -EFAULT;
> > +             goto exit;
>
> This goto is unnecessary.
Accepted will corrected in v3.

>
> > +     }
> > +
> > +exit:
> > +     return err;
> > +}
> > +
> > +/* Open a character device. */
> > +static int se_if_fops_open(struct inode *nd, struct file *fp) {
> > +     struct se_if_device_ctx *dev_ctx =3D container_of(fp->private_dat=
a,
> > +                                                     struct se_if_devi=
ce_ctx,
> > +                                                     miscdev);
> > +     int err =3D 0;
> > +
> > +     /* Avoid race if opened at the same time */
> > +     if (down_trylock(&dev_ctx->fops_lock))
> > +             return -EBUSY;
> > +
> > +     /* Authorize only 1 instance. */
> > +     if (dev_ctx->status !=3D SE_IF_CTX_FREE) {
> > +             err =3D -EBUSY;
> > +             goto exit;
> > +     }
> > +
> > +     /*
> > +      * Allocate some memory for data exchanges with S40x.
> > +      * This will be used for data not requiring secure memory.
> > +      */
> > +     dev_ctx->non_secure_mem.ptr =3D dmam_alloc_coherent(dev_ctx->dev,
> > +                                     MAX_DATA_SIZE_PER_USER,
> > +                                     &dev_ctx->non_secure_mem.dma_addr=
,
> > +                                     GFP_KERNEL);
>
> As Marc already mentioned: There is no point in using the managed version=
 on
> dma_alloc_coherent() here.

Since it associated with device context and will remain associated till the=
 device ctx is closed.
It was left to be part of managed version.
Accepted. Will correct it.
Will check other instances too.

>
> > +     if (!dev_ctx->non_secure_mem.ptr) {
> > +             err =3D -ENOMEM;
> > +             goto exit;
> > +     }
> > +
> > +     dev_ctx->non_secure_mem.size =3D MAX_DATA_SIZE_PER_USER;
> > +     dev_ctx->non_secure_mem.pos =3D 0;
> > +     dev_ctx->status =3D SE_IF_CTX_OPENED;
> > +
> > +     dev_ctx->pending_hdr =3D 0;
> > +
> > +     goto exit;
> > +
> > +     dmam_free_coherent(dev_ctx->priv->dev, MAX_DATA_SIZE_PER_USER,
> > +                        dev_ctx->non_secure_mem.ptr,
> > +                        dev_ctx->non_secure_mem.dma_addr);
>
> This code is unreachable.

Accepted. Will correct in v3.

>
> > +
> > +exit:
> > +     up(&dev_ctx->fops_lock);
> > +     return err;
> > +}
> > +
> > +/* Close a character device. */
> > +static int se_if_fops_close(struct inode *nd, struct file *fp) {
> > +     struct se_if_device_ctx *dev_ctx =3D container_of(fp->private_dat=
a,
> > +                                                     struct se_if_devi=
ce_ctx,
> > +                                                     miscdev);
> > +     struct se_if_priv *priv =3D dev_ctx->priv;
> > +     struct se_buf_desc *b_desc;
> > +
> > +     /* Avoid race if closed at the same time */
> > +     if (down_trylock(&dev_ctx->fops_lock))
> > +             return -EBUSY;
> > +
> > +     /* The device context has not been opened */
> > +     if (dev_ctx->status !=3D SE_IF_CTX_OPENED)
> > +             goto exit;
> > +
> > +     /* check if this device was registered as command receiver. */
> > +     if (priv->cmd_receiver_dev =3D=3D dev_ctx)
> > +             priv->cmd_receiver_dev =3D NULL;
> > +
> > +     /* check if this device was registered as waiting response. */
> > +     if (priv->waiting_rsp_dev =3D=3D dev_ctx) {
> > +             priv->waiting_rsp_dev =3D NULL;
> > +             mutex_unlock(&priv->se_if_cmd_lock);
> > +     }
> > +
> > +     /* Unmap secure memory shared buffer. */
> > +     if (dev_ctx->secure_mem.ptr)
> > +             devm_iounmap(dev_ctx->dev, dev_ctx->secure_mem.ptr);
>
> secure_mem is unused in this patch set. Drop this and re-add it later whe=
n
> you want to add support for this.
Accepted, will correct in v3.

>
> > +
> > +     dev_ctx->secure_mem.ptr =3D NULL;
> > +     dev_ctx->secure_mem.dma_addr =3D 0;
> > +     dev_ctx->secure_mem.size =3D 0;
> > +     dev_ctx->secure_mem.pos =3D 0;
> > +
> > +     /* Free non-secure shared buffer. */
> > +     dmam_free_coherent(dev_ctx->priv->dev, MAX_DATA_SIZE_PER_USER,
> > +                        dev_ctx->non_secure_mem.ptr,
> > +                        dev_ctx->non_secure_mem.dma_addr);
> > +
> > +     dev_ctx->non_secure_mem.ptr =3D NULL;
> > +     dev_ctx->non_secure_mem.dma_addr =3D 0;
> > +     dev_ctx->non_secure_mem.size =3D 0;
> > +     dev_ctx->non_secure_mem.pos =3D 0;
> > +
> > +     while (!list_empty(&dev_ctx->pending_in) ||
> > +            !list_empty(&dev_ctx->pending_out)) {
> > +             if (!list_empty(&dev_ctx->pending_in))
> > +                     b_desc =3D list_first_entry_or_null(&dev_ctx->pen=
ding_in,
> > +                                                       struct se_buf_d=
esc,
> > +                                                       link);
> > +             else
> > +                     b_desc =3D list_first_entry_or_null(&dev_ctx->pen=
ding_out,
> > +                                                       struct se_buf_d=
esc,
> > +                                                       link);
> > +
> > +             if (!b_desc)
> > +                     continue;
> > +
> > +             if (b_desc->shared_buf_ptr)
> > +                     memset(b_desc->shared_buf_ptr, 0, b_desc->size);
> > +
> > +             __list_del_entry(&b_desc->link);
> > +             kfree(b_desc);
> > +     }
> > +
> > +     dev_ctx->status =3D SE_IF_CTX_FREE;
> > +
> > +exit:
> > +     up(&dev_ctx->fops_lock);
> > +     return 0;
> > +}
> > +
> > +/* IOCTL entry point of a character device */ static long
> > +se_ioctl(struct file *fp, unsigned int cmd, unsigned long arg) {
> > +     struct se_if_device_ctx *dev_ctx =3D container_of(fp->private_dat=
a,
> > +                                                     struct se_if_devi=
ce_ctx,
> > +                                                     miscdev);
> > +     struct se_if_priv *se_if_priv =3D dev_ctx->priv;
> > +     int err =3D -EINVAL;
> > +
> > +     /* Prevent race during change of device context */
> > +     if (down_interruptible(&dev_ctx->fops_lock))
> > +             return -EBUSY;
> > +
> > +     switch (cmd) {
> > +     case SE_IOCTL_ENABLE_CMD_RCV:
> > +             if (!se_if_priv->cmd_receiver_dev) {
> > +                     se_if_priv->cmd_receiver_dev =3D dev_ctx;
> > +                     err =3D 0;
> > +             }
> > +             break;
> > +     case SE_IOCTL_GET_MU_INFO:
> > +             err =3D se_ioctl_get_mu_info(dev_ctx, arg);
> > +             break;
> > +     case SE_IOCTL_SETUP_IOBUF:
> > +             err =3D se_ioctl_setup_iobuf_handler(dev_ctx, arg);
> > +             break;
> > +     case SE_IOCTL_GET_SOC_INFO:
> > +             err =3D se_ioctl_get_se_soc_info_handler(dev_ctx, arg);
> > +             break;
> > +
> > +     default:
> > +             err =3D -EINVAL;
> > +             dev_dbg(se_if_priv->dev,
> > +                     "%s: IOCTL %.8x not supported\n",
> > +                             dev_ctx->miscdev.name,
> > +                             cmd);
> > +     }
> > +
> > +     up(&dev_ctx->fops_lock);
> > +     return (long)err;
> > +}
> > +
> > +/* Char driver setup */
> > +static const struct file_operations se_if_fops =3D {
> > +     .open           =3D se_if_fops_open,
> > +     .owner          =3D THIS_MODULE,
> > +     .release        =3D se_if_fops_close,
> > +     .unlocked_ioctl =3D se_ioctl,
> > +     .read           =3D se_if_fops_read,
> > +     .write          =3D se_if_fops_write,
> > +};
> > +
> > +/* interface for managed res to unregister a character device */
> > +static void if_misc_deregister(void *miscdevice) {
> > +     misc_deregister(miscdevice);
> > +}
> > +
> >  /* interface for managed res to free a mailbox channel */  static
> > void if_mbox_free_channel(void *mbox_chan)  { @@ -270,6 +855,7 @@
> > static int se_probe_if_cleanup(struct platform_device *pdev)
> >       struct device *dev =3D &pdev->dev;
> >       struct se_if_priv *priv;
> >       int ret =3D 0;
> > +     int i;
> >
> >       priv =3D dev_get_drvdata(dev);
> >       if (!priv) {
> > @@ -294,6 +880,17 @@ static int se_probe_if_cleanup(struct
> platform_device *pdev)
> >               priv->imem.buf =3D NULL;
> >       }
> >
> > +     if (priv->ctxs) {
> > +             for (i =3D 0; i < priv->max_dev_ctx; i++) {
> > +                     if (priv->ctxs[i]) {
> > +                             devm_remove_action(dev,
> > +                                                if_misc_deregister,
> > +                                                &priv->ctxs[i]->miscde=
v);
> > +                             misc_deregister(&priv->ctxs[i]->miscdev);
> > +                     }
> > +             }
> > +     }
> > +
> >       if (priv->flags & RESERVED_DMA_POOL) {
> >               of_reserved_mem_device_release(dev);
> >               priv->flags &=3D (~RESERVED_DMA_POOL); @@ -302,6 +899,84
> > @@ static int se_probe_if_cleanup(struct platform_device *pdev)
> >       return ret;
> >  }
> >
> > +static int init_device_context(struct device *dev) {
> > +     const struct imx_se_node_info *info;
> > +     struct se_if_device_ctx *dev_ctx;
> > +     struct se_if_priv *priv;
> > +     u8 *devname;
> > +     int ret =3D 0;
> > +     int i;
> > +
> > +     priv =3D dev_get_drvdata(dev);
> > +
> > +     if (!priv) {
> > +             ret =3D -EINVAL;
> > +             dev_err(dev, "Invalid SE-MU Priv data");
> > +             return ret;
> > +     }
>
> You won't hit this as you already have called dev_set_drvdata(). Just dro=
p this
> check. Also you should pass a struct se_if_priv * directly to this functi=
on
> instead of taking the detour of passing a struct device *.

Ok. Accepted.

>
> > +     info =3D priv->info;
> > +
> > +     priv->ctxs =3D devm_kzalloc(dev, sizeof(dev_ctx) * priv->max_dev_=
ctx,
> > +                               GFP_KERNEL);
> > +
> > +     if (!priv->ctxs) {
> > +             ret =3D -ENOMEM;
> > +             return ret;
> > +     }
> > +
> > +     /* Create users */
> > +     for (i =3D 0; i < priv->max_dev_ctx; i++) {
> > +             dev_ctx =3D devm_kzalloc(dev, sizeof(*dev_ctx), GFP_KERNE=
L);
> > +             if (!dev_ctx) {
> > +                     ret =3D -ENOMEM;
> > +                     return ret;
> > +             }
> > +
> > +             dev_ctx->dev =3D dev;
> > +             dev_ctx->status =3D SE_IF_CTX_FREE;
> > +             dev_ctx->priv =3D priv;
> > +
> > +             priv->ctxs[i] =3D dev_ctx;
> > +
> > +             /* Default value invalid for an header. */
> > +             init_waitqueue_head(&dev_ctx->wq);
> > +
> > +             INIT_LIST_HEAD(&dev_ctx->pending_out);
> > +             INIT_LIST_HEAD(&dev_ctx->pending_in);
> > +             sema_init(&dev_ctx->fops_lock, 1);
> > +
> > +             devname =3D devm_kasprintf(dev, GFP_KERNEL, "%s_ch%d",
> > +                                      info->se_name, i);
> > +             if (!devname) {
> > +                     ret =3D -ENOMEM;
> > +                     return ret;
> > +             }
> > +
> > +             dev_ctx->miscdev.name =3D devname;
> > +             dev_ctx->miscdev.minor =3D MISC_DYNAMIC_MINOR;
> > +             dev_ctx->miscdev.fops =3D &se_if_fops;
> > +             dev_ctx->miscdev.parent =3D dev;
> > +             ret =3D misc_register(&dev_ctx->miscdev);
> > +             if (ret) {
> > +                     dev_err(dev, "failed to register misc device %d\n=
",
> > +                             ret);
> > +                     return ret;
> > +             }
> > +
> > +             ret =3D devm_add_action(dev, if_misc_deregister,
> > +                                   &dev_ctx->miscdev);
> > +             if (ret) {
> > +                     dev_err(dev,
> > +                             "failed[%d] to add action to the misc-dev=
\n",
> > +                             ret);
> > +                     return ret;
> > +             }
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> >  static void se_load_firmware(const struct firmware *fw, void
> > *context)  {
> >       struct se_if_priv *priv =3D (struct se_if_priv *) context; @@
> > -461,6 +1136,16 @@ static int se_if_probe(struct platform_device *pdev)
> >               }
> >       }
> >
> > +     if (info->max_dev_ctx) {
> > +             ret =3D init_device_context(dev);
> > +             if (ret) {
> > +                     dev_err(dev,
> > +                             "Failed[0x%x] to create device contexts.\=
n",
> > +                             ret);
> > +                     goto exit;
> > +             }
> > +     }
> > +
> >       dev_info(dev, "i.MX secure-enclave: %s interface to firmware,
> configured.\n",
> >                info->se_name);
> >       return devm_of_platform_populate(dev); @@ -502,6 +1187,10 @@
> > static int se_resume(struct device *dev)
> >       struct se_if_priv *priv =3D dev_get_drvdata(dev);
> >       const struct imx_se_node_info *info
> >                                       =3D priv->info;
> > +     int i;
> > +
> > +     for (i =3D 0; i < priv->max_dev_ctx; i++)
> > +             wake_up_interruptible(&priv->ctxs[i]->wq);
> >
> >       if (info && info->imem_mgmt)
> >               se_restore_imem_state(dev);
>
> Sascha
>
> --
> Pengutronix e.K.                           |                             =
|
> Steuerwalder Str. 21                       |
> http://www.pe/
> ngutronix.de%2F&data=3D05%7C02%7Cpankaj.gupta%40nxp.com%7C5351b96c
> b80a4eefa99d08dc7bcac8b3%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0
> %7C0%7C638521358079376269%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiM
> C4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7
> C%7C%7C&sdata=3DrI4tOYhDyFr7rHCBqFUJ%2FNBzVGf2mha4d20F2QM%2BN6
> Y%3D&reserved=3D0  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|

