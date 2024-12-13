Return-Path: <linux-kernel+bounces-445394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DBB9F1588
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 20:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B79D16845B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 19:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364DF1E8835;
	Fri, 13 Dec 2024 19:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oPRtz2Uf"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2044.outbound.protection.outlook.com [40.107.20.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA0142A92;
	Fri, 13 Dec 2024 19:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734117079; cv=fail; b=cT7CCnH7fg9j5iUT2mql3Zq5XHFUjsgJ8Ikn0NqmUuGqD0qJunVAZRpUrQV5n+fjFiLt8M/A851dOksUm6COWk/V+Prnw7qJe0pwOjQQULPI57bAeOCtdJTfMgWLTS22NarZk9PhqNXYYTKJqTlgJEeGeB2wmO4Po+NcYXxFIO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734117079; c=relaxed/simple;
	bh=ygD5bgr10keKjODKpZUvBSzlK8nLy+veS/gS46654vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jJxo2owSN2TZG3iVeCYOTDXsGLebsl/KAvJPksgk0BR8597dH2arkBtiwoxrXToIAJAVi1R4JZ6g2VVbipwmytApb2PxjjWw5hncABYHpnso5Y7z4Y0YvEKGtmxt4ixZXdBGTS2zqnE0DU8NcZkUjpbtqUb4hnHqbbOgUOIF4v4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oPRtz2Uf; arc=fail smtp.client-ip=40.107.20.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vGmS2eEpjnb6ntFWOmz5WKV5vHbc9SiAMxgzwy9c5Pn5ju0nnhC/V3mjph++4wW/4t2qHMiKQclVIclPCTt7qQHB84s5gnIrsZcLTMQi85y2kKl2s4dlWjGgYKRMmAX2mFjU5One4Rxu2WlnUBhrnKyo1QArMQ9bJdzFwTvzsAyXwdkWfc0QA0xpMfw2vFufwrDYjud2HtjO7UXrPqTWxxcWfwY11Xq1IUgJ7fXj8maeI5kMxfXHK2n4ncvBk+74TL2iPeS9wp/sXFNgu+3wFbY6+mAU2bIBbRnbrAx0UQ8E2fslQj0qLr2EzpHLudNDICMQs5yKHQka4AcQclqcRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7YbUHjF27f+tHf+5lgTZ3cEDxJ7iJK6A6QYBtrl6QU=;
 b=UcLYefDebCRWtGEcz4RUcn2atfIJrZNufJKI7bkWmfbjMXE+my8+kRn7PDLj6gR9pbc/baXeXZmx1Uynts3cn4cT1pW9IywbtQ0vHOAMkA7QFHGLsdgyl84DT6lSMtHegbHayAwlJfD4dPpvGWvgkUlY59UuSq9gHmE/B1ZLO8wqPVtpeIwynMhrId15p1wE8H4lZM3ONdllSy+qRJ1XzbcdwP2U8km2aR3g3wUqtFSJXAGmRp3HtvCde0FR0OHcH6rW8Bfdhpya4qmZlR/N7y6/wJ9MtEaWMO9+Kdl0kgqtNC7isOb2xHjmydbbKhXq2UwWfofMpHkBlQNss/Z+WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7YbUHjF27f+tHf+5lgTZ3cEDxJ7iJK6A6QYBtrl6QU=;
 b=oPRtz2UfnnY+CAvr40vhpojqnB+AdELot5fBNxSU+7LwYbo0IX6sKzimIc1d3R0Uq/uVgSUF4dj2GgxCjA2NLPma5fscLJ1kb6i7CWvym/QGL27krNObyZ5Awk/b8R6v2iuFFX8bMUXrmG3U9YLCkk87d/ix3khlnl7E09gTYVpqzT7ME+5Qw3rcvmZpFcepNg6z9d9xbAwhvL0PM3fTgoKRrZklHq3rpU2Y4w+Zwrmv9+VzcRnPyheAMq38qc+UXzhkNpR4kC+Q4eziPPp8sVpNuN3D2y7t65+UL7xx5xBCz2Tf1Lekwlg2kDtB17XK5R4JfKieeH/G1ytt/e8Z0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8881.eurprd04.prod.outlook.com (2603:10a6:20b:42c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Fri, 13 Dec
 2024 19:11:14 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8251.008; Fri, 13 Dec 2024
 19:11:14 +0000
Date: Fri, 13 Dec 2024 14:11:05 -0500
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 2/2] nvmem: imx-ocotp-ele: Support accessing controller
 for i.MX9
Message-ID: <Z1yGycDxf329m3bC@lizhi-Precision-Tower-5810>
References: <20241212-imx-ocotp-v1-0-198bb0af86a0@nxp.com>
 <20241212-imx-ocotp-v1-2-198bb0af86a0@nxp.com>
 <cf153dd6-f82c-47d9-9ab4-f247437d607e@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf153dd6-f82c-47d9-9ab4-f247437d607e@kernel.org>
X-ClientProxiedBy: SJ0PR03CA0143.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8881:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f25f7fb-332f-459a-6a7c-08dd1ba9ea03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EsEI9Uh/KIwehbgMPaC1TM8MWKqQ8/ueh2qDqsor0uPo8RGyyxgdiBpXxhce?=
 =?us-ascii?Q?6LGyZwIcp02nHYERlTgRJiltsHI2WmpNi1zBfnk96Pi365m+3rV9eZfduN1o?=
 =?us-ascii?Q?FpSIcjtbUCsnQjKAezXl7VFsIxE46oeO9/ckPoQ8FpnjmdYO3KDrDHdpTyiH?=
 =?us-ascii?Q?P1ndYxDxAdsNwN4fW3gO5RBX5BFgCLD9ZO9SmPktlDvU15saQ/AfvzpzPyFh?=
 =?us-ascii?Q?da7CUYnRhz+p+jDut81GqGYD+8jnsGex+REjYxbKk7AS/ZluRTVq7os9CHcM?=
 =?us-ascii?Q?ZCkqteCTRbBwUPZdtZ3oe4s1K/MilrVnbqwYVI2YjtM8vw+vXVtcVQIg/kEs?=
 =?us-ascii?Q?nvc5iJUHrZCxzX1KOPVokDGQEpBiFsKcgcH2DE9zWtlUTFotzPo511879eMQ?=
 =?us-ascii?Q?VyQThO9cMBQPKOuFso2L7JhqRr1lury7A+xIA39IN+tFnKEwDPGNPvRLKqyX?=
 =?us-ascii?Q?XzQ8NLJu3EpsOg9taErSpsTiWPgD81S6bGDOeQgyIlhTlEnzXbdp5N90APSl?=
 =?us-ascii?Q?17rlnz8uxzY6XAz/UkdPjOjNdwNPJ5hkAM8x4yOaoYdEGeOaDScdSxQZ0hRP?=
 =?us-ascii?Q?RQ07ikRpkAFHew2377Ylv4w+gFIANwjUnpZeDFzWrfYE83GOEHLKl6GF60lU?=
 =?us-ascii?Q?3Mkn76Dn5GPPerEPndUc5VmtE+5oN9p28tHQrPYc64Luu1Pvj/GyjPVf40cq?=
 =?us-ascii?Q?DyRntL9qd2t1R2KtKgk9iWmv5UH3ITJJOg1v8WJC0KsVceMqw9nPbprVWU98?=
 =?us-ascii?Q?7kiZpx3B6aFsvheT/+IY6DDfyzSrr/bjs2G11P0ensrLdQDAlGeKsUoumN8M?=
 =?us-ascii?Q?S5i0qvXftlOmw7JPaUymbn1nlq1RdqNcwLslsxaWMqhLV8AbudrMUOUk1HYo?=
 =?us-ascii?Q?dtm8EJqhky8ANlHBg/t1Px4im1YqJ4P3omP4gslffr4k1YlVCm+RLVT4skbS?=
 =?us-ascii?Q?IBwoyJaKY6gtIKbm6qprosM8D09qhJ0rMjlA9X2bKC67Z8OZSwpF0D7X25Q8?=
 =?us-ascii?Q?LNptxg8cbrA9QoHo8AQFSP2OllwoS/V1kaR1R6mJrj4A/e0UQo0c5zTZ/gwC?=
 =?us-ascii?Q?J8t+FMEjPqxmmNcb3UhAGA053teq/hxM6wnm2Bj7oZOvXZDp7cT+cNeHL+eb?=
 =?us-ascii?Q?9X287IkO3SQbJ0TuChCSX/dFpDZrIeGL/A00bDdzUO3LTcXkj09DWs40/Rdx?=
 =?us-ascii?Q?sf/YjpBTG8CJlBwZOAGleqRif3pYiJDgE/mQClz0uD9sTqMeLaLT4pIVB/2x?=
 =?us-ascii?Q?f01Gj2ItgFX0BBlTfFUUacmYhW2hPLdmBAfgppSFmmfQ6Z4Z53kEEfJxJidM?=
 =?us-ascii?Q?Cf5FCXvB1Xx36YbnJwx6HydHUcijCgdVSNLdckpFSf+BYiZNFnkKsTQecXNc?=
 =?us-ascii?Q?vz0442F52aB13VW1Ffuq88Upeai+S445NEuUjTRqNYqBYLTOLdgaMlTYmvQB?=
 =?us-ascii?Q?ifJ3tHg5YHefhj0Tk3y4acDMnVWRZ9pm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QLOnmd0WvVkEKA6ST51lQBEmAyY/t3aqAwdHW0c1XSYfUB9CSQ3gVdqe/6tq?=
 =?us-ascii?Q?GFkn/PckZsIRa75utq0Jrg7WKldskqcmSYh6rza3Sumt77S9WxEps1GHadrS?=
 =?us-ascii?Q?23jsibSDC+3iFgLEUrkwmpYztJMv8oNvPrC4gyaAN494SPdN/0gdmz9EqCpg?=
 =?us-ascii?Q?IRo/LCKEqgiWfRaoM0fsVuy8/aHepnQKiQs6eqa4NJKh+rSo8B3y8XxZOQnH?=
 =?us-ascii?Q?4guc/mHTWOb6eYzay+p5ZNAmSZ16twuL/qmg80rYD76t6LxqKmW00Hvkg9T4?=
 =?us-ascii?Q?0iJWkXLKjgljVy9gOBy87G8vGKIi2Uq/EC9kndI4tsvNcGyxrVgEZeOqkMjb?=
 =?us-ascii?Q?FMj0zkxv2piZukRFXM7EFiAZNzGdKJs+M6N27xSIskqpgde3NrqwFEjAx80/?=
 =?us-ascii?Q?86a13Lke4G/NSN6bsJqkjpMTjjhwSOOOHN09gYf7ko5+6A8m8IPpPuKoapRM?=
 =?us-ascii?Q?wl/Yyi5XPlVwY5gq2sVYTtRXi8/aFKFWYy6M88aQcidzpWyYXURtBRjvEz1I?=
 =?us-ascii?Q?taRaZyYCjfUDTWQHi04ZIE4dF0ZVg2zWqPYx81fEi8QzzytZ+qNNu2a52EDH?=
 =?us-ascii?Q?sytljHF+R8mvcPDBseiFwwZ2FvInwg0ueJN+eEIQb3R+njuYWBa1vmkSIRHJ?=
 =?us-ascii?Q?ScUyYe9vDfOummKNZOwi/moXk620P/30j8lXY6i/nyMiIYxTxw9geHx/BlBM?=
 =?us-ascii?Q?mrmPjKpu6Z3ZIK61aJ6GV9nRSALP0k63mY+Ol5c9W+T9k0rPK/nADg+6j8Vu?=
 =?us-ascii?Q?tGeF9VK07vrPZ56N0WGw3wNt0O1MF8cQAFpM+gJvQsYExU+qD+n1OlPVA8US?=
 =?us-ascii?Q?WnsbM+smDc0n41875/eUU0GKzStUxRS5dy2u9XVrjxX7oErnBgoC1xUy+YFO?=
 =?us-ascii?Q?aJ4vG/0xFYuNA/zTz1yINGEvASTuZ885wuFhKok+ASd/s9VbYH1TbErikZBO?=
 =?us-ascii?Q?n+U6LoNLCJesMSXR9pG8cnNtCVkIho+UOG9na1HQId37/slKN9LyW9KuR40m?=
 =?us-ascii?Q?ZymCoGSn9fGrZR3Es22dJdflWpJs4Q14JktOijtEESxp5YGEwHEk5FTYmotI?=
 =?us-ascii?Q?1L9RRxyw9VNqnVX7ttq9FCxlJ5pzV5L7pqEdnGgfSeA+8nV8LMbjqUahpfZL?=
 =?us-ascii?Q?c6uBKodRCQlWyW7LWeevgdiw8KHhX7gR3ZTz4tj2v4v3YYFh38ykS6LTLyS2?=
 =?us-ascii?Q?whxmXidBdyz+OQ8jP8FCrd6aKbE6znyUcnBCoSNEH2Dgd6krZ6ZDJTA6c2Sv?=
 =?us-ascii?Q?5uOTyZNBSubYgGjHFmkspBHHznWAxMOy9+hi+NPONeHu9QdY4wR6KEiOgLfx?=
 =?us-ascii?Q?6oSI8SL6xLto5fWtCSg0R/mlgWk0O6XXciE/raeQxEkhSii9Q+BeviC18ygf?=
 =?us-ascii?Q?PUyVBEnw2YrxDFH9aewsKvjIA9TNitgdMZlSSSqaHINW/5TMV3b8bhrhszZd?=
 =?us-ascii?Q?eEgz4DVoZkc642Qf8z8pFX0SjJOUZzRCKmyJ9DS65+EX/vSpQMSD2X7Jw3YD?=
 =?us-ascii?Q?vX2G/umB7ClavE7ptTZR/Dw0lZ9HYmkkSwArhlLX8LLHoXEeveTA1m7ZIXq+?=
 =?us-ascii?Q?i1WtBIAJ5nDebTMpkKq8/oY6byUx4Oin+2wufKpC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f25f7fb-332f-459a-6a7c-08dd1ba9ea03
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 19:11:14.7329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ga/dHTKpkn9rs32eQW7BzeocQNWOLuu3bZh99te6sL3Emy2gj+yLzS2qqETKW0NRxnuKrakMah2ttYc0Dt8Zhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8881

On Fri, Dec 13, 2024 at 08:52:49AM +0100, Krzysztof Kozlowski wrote:
> On 12/12/2024 09:24, Peng Fan (OSS) wrote:
> > +
> > +			if (imx_ele_ocotp_check_access(pdev, id)) {
> > +				of_detach_node(child);
> > +				dev_err(dev, "%s: Not granted, device driver will not be probed\n",
> > +					child->full_name);
> > +			}
> > +		}
> > +
> > +		imx_ele_ocotp_grant_access(pdev, child);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int imx_ele_ocotp_access_control(struct platform_device *pdev)
> > +{
> > +	struct imx_ocotp_priv *priv = platform_get_drvdata(pdev);
> > +	struct device_node *soc __free(device_node) = of_find_node_by_path("/soc");
>
> No, you just created undocumented ABI on the name.
>
> Drop/replace or express the ABI (which is impossible, so basically: drop).

How about iterate whole tree by use bfs method? So no undocumented ABI.

Frank

>
>
> Best regards,
> Krzysztof

