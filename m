Return-Path: <linux-kernel+bounces-326574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8A7976A44
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBEF0B215A9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 13:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3761E1ABEA7;
	Thu, 12 Sep 2024 13:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inmusicbrands.com header.i=@inmusicbrands.com header.b="UDzYKEr3"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2121.outbound.protection.outlook.com [40.107.93.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7EE1A706B;
	Thu, 12 Sep 2024 13:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726146989; cv=fail; b=qC3qWYqXdsBd+FyoXXablq/56h3dSdYLkssjalZbchedWRK1ItgZuKhgSWTGverVNzdFJgCLfxMyvxul/pwAoj3xMytmpyW4GftRirbhDmvISLv5bXUqck6ZwPu24rqX0L147gstg1bQMDDimsr6tMKBQTvqXNiFYSs9IKjgOyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726146989; c=relaxed/simple;
	bh=z6mjN2mDN8zGP660xdYAvPZplwr4oRn8zLD2s0LmYqE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HgJGYlsjo5scDKbOCNTagGXVyqKDgGIpGgjXsB5iyDOToP8kmuP4qu9Q/lUG4eyd7Rd825vs32n9SGr1PaRVKOOBGDqWoeF60lJ272KjinI2UtU1aL0/k0h6dh70Q2twzwQOXv9iU2p3X0+3mxODOaG9diV8dyd0leP3kEK3+W8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inmusicbrands.com; spf=pass smtp.mailfrom=inmusicbrands.com; dkim=pass (1024-bit key) header.d=inmusicbrands.com header.i=@inmusicbrands.com header.b=UDzYKEr3; arc=fail smtp.client-ip=40.107.93.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inmusicbrands.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inmusicbrands.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZyqqDHGe7vnhrECtYXlVhLHx8lTyXlqgEQ+CofejwQrkaYeClBRqf5rGlQLuVh/coiGk958RtM6Y4cm4ozfZUiYogfZg/799CyeierLtiLCmeLG87/0VNFwsynctQAq9tA7a6eEXH/7np/Q+7nKGGrjCZFNMbUOOKBp1BVNSNwT3WWCI6D8KhiReltYTpQ/eUuP1zvZka5pYcFV/8JDXRSvctxnzp4JikmbF7l60JQFhVE0sO8Q4QqWImm1w/7qrqrkNUGaUaRIaggWJtz3TKS9bAShyCDrjf7JsZ3vjmUXloy6OtNdv/MInNr7od6ghdIoApRLEJ4Ne5YDrrx4uig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Hk4jZJJxJZ+2o2Nq0GEWCQh9HqVfqJDeGQwEqRZzKU=;
 b=PIfKatflxeVIrRIQRpAOwI6wptaJBOgrCrpQ9W/8W/vOO4zv0CWaw0K/Z8SBy/xx/7ihzsuoeY/krbtFgrv4e9llPWFPtdYNd/mGmehrhUidzG1+DfVjEORYFIOLQvm2kFj3JRyWwjMbEDJfpqgztSjT2gLPeEFZTTPtvz0TR52S/I4AngYDpHX+sJiWtrV534D8YaDxqpNLtcWV3bIR4wYdibL8Ri4NZeQ5mO6lQFBFMU0dQmv5QMWNF0Fz7IJ0bw4e8pc7EDhQeiHPXGjXC/5eCu2XTBabKzFhjn0CBgRzDJccWhjs3kHzFGah5/1sXt89SdVTj4eu4FFTu7eSOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=inmusicbrands.com; dmarc=pass action=none
 header.from=inmusicbrands.com; dkim=pass header.d=inmusicbrands.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inmusicbrands.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Hk4jZJJxJZ+2o2Nq0GEWCQh9HqVfqJDeGQwEqRZzKU=;
 b=UDzYKEr3fRujGa7ykqdFRjiRVVEYCe3Mf8N5izTCNJh210F0cbuiABRI5/rsGCE9GPE/OoWBgtSN6v+6+uW0JNdgDeLQnjTfybRLPupHxTDsBSZCMY2a9Pw/rgAHJJXZKNE6zjukJb87CGpR1Q49ed99MKwLU3JadEIsUlbzDsk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=inmusicbrands.com;
Received: from MW4PR08MB8282.namprd08.prod.outlook.com (2603:10b6:303:1bd::18)
 by CH3PR08MB10267.namprd08.prod.outlook.com (2603:10b6:610:207::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Thu, 12 Sep
 2024 13:16:22 +0000
Received: from MW4PR08MB8282.namprd08.prod.outlook.com
 ([fe80::55b3:31f1:11c0:4401]) by MW4PR08MB8282.namprd08.prod.outlook.com
 ([fe80::55b3:31f1:11c0:4401%6]) with mapi id 15.20.7939.017; Thu, 12 Sep 2024
 13:16:22 +0000
From: John Keeping <jkeeping@inmusicbrands.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: John Keeping <jkeeping@inmusicbrands.com>,
	Roy Luo <royluo@google.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	yuan linyu <yuanlinyu@hihonor.com>,
	Sumit Garg <sumit.garg@linaro.org>,
	Krishna Kurapati <quic_kriskura@quicinc.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Chris Wulff <crwulff@gmail.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] usb: gadget: core: force synchronous registration
Date: Thu, 12 Sep 2024 14:16:07 +0100
Message-ID: <20240912131608.1645554-1-jkeeping@inmusicbrands.com>
X-Mailer: git-send-email 2.46.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0177.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::20) To MW4PR08MB8282.namprd08.prod.outlook.com
 (2603:10b6:303:1bd::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR08MB8282:EE_|CH3PR08MB10267:EE_
X-MS-Office365-Filtering-Correlation-Id: 07a3a527-e521-4992-339e-08dcd32d18d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TNs7hzgRzR04DUGGbWCO91d2uLdcb6iXy6fLm4Aoz50V1CXpH/0AnkpNJuPa?=
 =?us-ascii?Q?xpe0c2AjpHw+04A+5WZTPDsnBjj8/VnbBfr0bJQ4w9bS6vslvmJnI8NzmQMk?=
 =?us-ascii?Q?PFDv2eVKUK3TSqYucJJZ28gky9h+Bo1csyS9s73Cr92QpGKqhAZou0ueX4Hp?=
 =?us-ascii?Q?E1q2bldUl8C9ERMT5nYMdZEP989gcQRBK/nqSU0ighxTwgcSM/vagoT1uXFQ?=
 =?us-ascii?Q?zZ9k729vjuAcoKXrTDIidZNr3f3/oqovIq1SgRkmP675vnY0KBxnbxEEoV4C?=
 =?us-ascii?Q?DSCj5cT8Pw/yezywo1T1BPTrmb8AMsXkB7S5xVaaapSwMoly0LJyTZe1j1zU?=
 =?us-ascii?Q?TyUpeTkVL317yqe+IGOg8N15kx7znXLwR055bX3mEojg2lbSxevh7hINR5uM?=
 =?us-ascii?Q?VR+CzvpAMBVYH/snS/eCp2z+Nx9Sy2erLiyOp5Q8pCI636AwAJPo4wPR1jwX?=
 =?us-ascii?Q?HS5+38/QHjuyx5CLQccn1EMaSGlmrd38J3PwJCnxHFvgSg42SL0OcnF0xfNc?=
 =?us-ascii?Q?CnEN2EcvDpmqyTv4RjNIjmOtahOdZo6OkoAOTZUYIdlzc8qpU8+bMtBGylsq?=
 =?us-ascii?Q?ZfFYGpeDDPn+XOBCEVr0FO+B5oC9hXWhOVS1khCr49ie/100ZYITahKRJIMo?=
 =?us-ascii?Q?raeb03wViVM8j6apslLDQ4j5qKihIor6NRKPBqSeeY76nr2TRvA03CehyBRH?=
 =?us-ascii?Q?LfuBEnFFOJpebPoGmtLIB1OnsEMToEmoU8elhr1XWiMVStmYQUPSpxFFS61y?=
 =?us-ascii?Q?HPC1Bwe+7LPbWFIOoMzHFRIQ2JcZNxy/erTYMbYOaA3HgvxKvFajROfCkxi6?=
 =?us-ascii?Q?RVsHsHZ/xrurMyPkzxMOpW5b7hUzv1g0dcqwxznYwk4sOTczwGPk4hGv5zz3?=
 =?us-ascii?Q?k+oSbsFHWzqHSx5AUoCOpyCBAO4VyaeTvWXvvvxRF8eLCgg1evIvlrPfDuHd?=
 =?us-ascii?Q?GI4GjrwM5Ix9GqFYopJXMI05wiurKK/xHvoyK8l+H8PHQFeJgVNlXh6AbS4b?=
 =?us-ascii?Q?W3rywMC4Hg/SKat8QnkkHoct0f2Az1J0ikNXuvAJhQiN9d4F/hc40W3AsJM/?=
 =?us-ascii?Q?9O2ZvMDY4qlkBaB2BOFbsqhdToms0WKDOAHiJ0dzx7qHNEBKW5QgOzWEI1KJ?=
 =?us-ascii?Q?g9xCcguaDWUp7EFq5cwPIv160ogWas1ZKIFes57n9MCMEXMwuny4tKtEMmjX?=
 =?us-ascii?Q?tAvkchgaRHek0jbJatwawxGcNZe/i5+QlgOEp9IuKTGwjrtuvz1do12c6kOb?=
 =?us-ascii?Q?JglWiK8I7AAN67QpQ7IKmWw8YtwX3//PixN+mksN2kCtAvW8BQBlvHzy72so?=
 =?us-ascii?Q?L7lksu3XUpj99pMFwovsoD5vaSif3xrZZpiC/xGkpSjTT+tg09tT0N24CwKG?=
 =?us-ascii?Q?iWRE66Z8waJ1j6qDF/4NZ/RIGYw1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR08MB8282.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KdG18SORbDr9V5ZMui/9q+45KD3QdKG4ET52wi1qzn/cd+khAxZc1hWU530o?=
 =?us-ascii?Q?UO3YT0Rx0wBfL6SenqdWYtsgZp6Vg+uKAWihL+50UuK0j92HEJRVhqrh3LuC?=
 =?us-ascii?Q?/RjyEvyR0WR1qhOcu/OCF+l3edFwEY93fR0aHzgcSRj5AS8Wr5sWa5mHwIsq?=
 =?us-ascii?Q?fbod4k59668tR473IEDnvJ8EtyNO3HsnXKyi8EuZVL3F8s35m2xFCwcvu6rX?=
 =?us-ascii?Q?kk4YD130bz+vtGxQjvAu4dzyEQNp7l6GThdByk6yA5IFTU3J+5tZjMJh95wF?=
 =?us-ascii?Q?F789yix2FaQgGfpdgvX8LRRmumUQF+//3F15zlKE5TEYBFvZJ67ncUr0bVuJ?=
 =?us-ascii?Q?qmJWhrNOEUT6OH5cpPPvvLb860gx+RsrrCf34rIO0ULxQThqmB7+NFTLkpdA?=
 =?us-ascii?Q?PyTLpOyaGw2DKrf5YVcO3MUiR4m/Xu0+HUKsl4w4XU/idQ4E1wwmjqaVQQxw?=
 =?us-ascii?Q?mO74mltAwlK4cU0RgrIOyvhJFbvqvucPUFhmUq7JJWhpscQBXuKjg+V2CCGt?=
 =?us-ascii?Q?6v32/ZUiqqXwCb1e0YdsEA3Q3FR1bjOeazfwssIUEZ4CpVzJKRYClCKoaeWL?=
 =?us-ascii?Q?SpFz/5mV9AvGglw0v6GyEXYlbfgnipqmsZotgrH+Hlbq5RDCPtT1ifCdoiYD?=
 =?us-ascii?Q?TEP9lYoMyigM5BJrf3tnVv68ou5EkmUuU+EGA33Oyby/ti+U0JFBI4sjL24G?=
 =?us-ascii?Q?cmAGK0FgzYwKNzHo2hNzlqfPmIlZBkhQGvv9lpFdE3tvM3xiUYHgjSH9LcDQ?=
 =?us-ascii?Q?Pxlz547SJJGBTGZ18VM9gCFI7DGb5aAmVW4xFDC/aSBxhnhJ9LKjSor7qN+6?=
 =?us-ascii?Q?VLMW56UrhIewVlJoKJ3lTtwisCw8p1XPk0xxTsPxansSWMo3DK3iND1jH6/G?=
 =?us-ascii?Q?rYiu4BaXk0LSv3sInpIam3PGmJNK1sqXKoTgmhcb80xJHayCtXSG1d3p+1qA?=
 =?us-ascii?Q?8+n+a02b5UBHmpEpepTQu0pjozn4zfyQT2MRIMy8CV0FZ0tNC5NaSydsup9a?=
 =?us-ascii?Q?hXu0eWFteeE2EhpiAQRznPPjTWKM2hfK1iyyJmJgR96Qo6UrxbYehYDaYpZb?=
 =?us-ascii?Q?0A76oMQSVp7jP531Fo8R5v7SrwEZa/ZF4HzKk0FnQmy2/7zJ4NcGaPwXjyA3?=
 =?us-ascii?Q?FH8SyP6/XjcrtxpsPTbSE83dS02X5GYCB65NZvb12hUMJQMRNIqYg6L20s87?=
 =?us-ascii?Q?8+aF7HnFWUShAJBY70NQ3WJW6Nb5sGhl/MeW0ysIQLxWTV25ktv6HbQW+Dx0?=
 =?us-ascii?Q?TtZd1/9wWIGyxCiccOwdql6esI5KdXMl/WE+CxwiFTbI5R3yg03tdJyMDS4Z?=
 =?us-ascii?Q?r6FmCvMMkNZCg7TzBGb+KMPXU4rvWqd9uaMpGsSFp/BATPweFkmKnMem6i2+?=
 =?us-ascii?Q?zDmiH5cQFIczZPINeFI2ZhxGCgBbe2eakA5pGZUnHevVsaMSja1YjmBYLirU?=
 =?us-ascii?Q?LxAkE2n4CVNfmGzxzJkuIt1jpW125+camGOplhlfftc2s2lINaEPqLVs/OK7?=
 =?us-ascii?Q?qz4BbrOS0eYYak7l70Rfy9BW1D6toOgLlK3ZFJRCinDeY1lnNxf0LsOLZPAn?=
 =?us-ascii?Q?oBEJe0stGWkroV/xzYrTHTQ9W1gLxWzm3fNY0Jro9sL8NF8upMLlvygUOiel?=
 =?us-ascii?Q?Vg=3D=3D?=
X-OriginatorOrg: inmusicbrands.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07a3a527-e521-4992-339e-08dcd32d18d4
X-MS-Exchange-CrossTenant-AuthSource: MW4PR08MB8282.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 13:16:22.6529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 24507e43-fb7c-4b60-ab03-f78fafaf0a65
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aRo7G0MmRWdk/IrSGdQLUpgu4C7+IIaX0v6BR5GkNEjotyYh+/Fr7cLZpq4mh0BCuVVGlSNpVAWXjUxGugG54VRgwlpH++xjY97ZtSUF2wQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR08MB10267

Registering a gadget driver is expected to complete synchronously and
immediately after calling driver_register() this function checks that
the driver has bound so as to return an error.

Set PROBE_FORCE_SYNCHRONOUS to ensure this is the case even when
asynchronous probing is set as the default.

Signed-off-by: John Keeping <jkeeping@inmusicbrands.com>
---
 drivers/usb/gadget/udc/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index cf6478f97f4a3..a6f46364be65f 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -1696,6 +1696,7 @@ int usb_gadget_register_driver_owner(struct usb_gadget_driver *driver,
 	driver->driver.bus = &gadget_bus_type;
 	driver->driver.owner = owner;
 	driver->driver.mod_name = mod_name;
+	driver->driver.probe_type = PROBE_FORCE_SYNCHRONOUS;
 	ret = driver_register(&driver->driver);
 	if (ret) {
 		pr_warn("%s: driver registration failed: %d\n",
-- 
2.46.0


