Return-Path: <linux-kernel+bounces-521602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 219D3A3BFD2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D7A93B51C2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7CD1E3787;
	Wed, 19 Feb 2025 13:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="H4Tfm4y+"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2050.outbound.protection.outlook.com [40.107.20.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCC91DFE36;
	Wed, 19 Feb 2025 13:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739971503; cv=fail; b=fpZzWB2Gp2IEsESPD7dCxmROAZwDAK22t/TTtSXSuxgrl9tDwZmT4bTkWS2JzxogO5ycR4yr3EFdqHYMvpJPlY1fNrIfsig4YixzYkrdUfpS5p2j6eAxqi34JVtlFKQIJju4kPkIpL7Dwq8DzJ0I29XoTF6Oz+UnRYW+xtULU34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739971503; c=relaxed/simple;
	bh=7mgR0h3UHtUlg4rc+lsgU5soSeVNmb0DbBK1yjStrhY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=nbT+cLxsgaqyye8+QOVRIIkVf/JcvPCGzyvnxzTYm6vIFDJZinzxT9ayT+HtOKrD0JdL9j2jaBOqQHrjoQLw3r2NaAaN0+ESpLC0BK8DV6Ti75suzTF/z+l3uIafPemtllj56uLTVkHH6d3d+77S3YDTcJWpZwlerwH66UytVH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=H4Tfm4y+; arc=fail smtp.client-ip=40.107.20.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z4x+pz+10aQqbPJB+qaF+Iv4U/3gmMNiT32SeGtDOxhXDEaNmxl85k/vcpCG3M2Pth8OjuHQ/n0ZY2ppqAT3KAPstsoOd0YJUdtgLZJjxZWy4z77d+8aig6VZGcKNBN74bqelw+QlQ87QfADi5yf5Nt0jAWBGM6RpHlje1E157vEplCBrNgZPQPHlaMVcingL9t6unq/8V5EDOvD4Q2AlFBqvVCagTW2L/JCXoggj4NHb/rsX0+OPquwIOiWq16PhwaNMZh5XqzmMcMsIl0NpuuJYR8lcwI3MooYM2HoZl1TkyU9wx5lh15zImBOG3WbHUbBZEOoJrruFCb4FJaoNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SgoIhb7v2nUvVGSyYkSzqTYVeqIkDV616VOQwAYGtNo=;
 b=MkGIXCG4Imi2saglYP85L/RTFGWX1jzUzY4OT8X7WvBi2odUdcRrZDZIkevQ7qx5JJfGd5J10cPImni/PQ3nRmYzjybqNEQRq6nIG/AZglazsjXyH7XcH/Gl/l1vaAFLiONcrLBGoMc+dSDJ3GWZMqQevLLWRnHcS8j5SoDkQ5QFSh/A3/9igUzpWchrJQ9zcWD1keC30GyXdr0P8+m9f+QMB9xNW0huFK/AU10DtIaMM4gmX44e/cN46Ge8qPLl24GAbmHIfzHPPnknKo8jurEfIpBbTsz0kt2g4KY5jXv7cw/Jir17wxtJNypN8toQoFj7D4ECS4i8B9DkdjpPNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SgoIhb7v2nUvVGSyYkSzqTYVeqIkDV616VOQwAYGtNo=;
 b=H4Tfm4y+4B/UKjAYHe+PhT19+lpDaLVMrQqGh3DYFw/0GuooU2EQu+na63eWDT/0ik8AHXSf6e5M6i82FRYzNL1nwTK6JcqDItwYvR4ENTZQFQTJTG8mfLjbmA3Li1ztIgvXlOu4puNqonKNiXXqWOA33+WIKfs+5tD5kT0CMVi05A7xYR0/2XYVBGBxXZOEWCfP4fiprdh1D2IEr9ZEEeds6MU/26w7YimAhtz0jfcRCvh2AQ611pvEUNHGD7lSj6Lk3F59ynAfWQPr4+tkJ6BZ+GsKkwoJw9O8kOSMAl21k6w0nJ9v5FBsluZDzUz/XvdmEKSeLCOLiPEWZUmWng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU7PR04MB11163.eurprd04.prod.outlook.com (2603:10a6:10:5b3::14)
 by PA1PR04MB10841.eurprd04.prod.outlook.com (2603:10a6:102:487::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Wed, 19 Feb
 2025 13:24:57 +0000
Received: from DU7PR04MB11163.eurprd04.prod.outlook.com
 ([fe80::3a74:80e4:4144:62db]) by DU7PR04MB11163.eurprd04.prod.outlook.com
 ([fe80::3a74:80e4:4144:62db%2]) with mapi id 15.20.8398.021; Wed, 19 Feb 2025
 13:24:57 +0000
From: florin.leotescu@oss.nxp.com
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Shych <michaelsh@nvidia.com>,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: viorel.suman@nxp.com,
	carlos.song@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	Florin Leotescu <florin.leotescu@nxp.com>
Subject: [PATCH v2 0/3] emc2305 driver updates
Date: Wed, 19 Feb 2025 15:32:18 +0200
Message-Id: <20250219133221.2641041-1-florin.leotescu@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0159.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::26) To DU7PR04MB11163.eurprd04.prod.outlook.com
 (2603:10a6:10:5b3::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU7PR04MB11163:EE_|PA1PR04MB10841:EE_
X-MS-Office365-Filtering-Correlation-Id: 787fee03-33cc-4f42-a1e2-08dd50e8cdce
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?zTjDZmhpiKflf9/4HgyLh3ncPB62YBX4EdTBDHq2FXLINpkiDy35wahUC8?=
 =?iso-8859-1?Q?Hzgh6nSs4rewichbpBOP55le98Fhw89YAhKBAyciBWe/ENeJGgQ1HVcxiK?=
 =?iso-8859-1?Q?lO+qgMvxccfzLT/NGGYvp6oryh8neLXQFiSV2BhEcbWNvBPIfzoNd2CBYV?=
 =?iso-8859-1?Q?EwS/+4rShJ2tOzjz6oEThCdaydqAw5I2CL80uuC2m97TRJ9P/2yGJR5Qfi?=
 =?iso-8859-1?Q?5oOLqoXQ97kvk/nwePkbw642699tfr8s4VcDRsonwMMlo8HK0D2XVyi5FO?=
 =?iso-8859-1?Q?YVXWi99pfB+bDHwVtCuY5KCuc5vxH4VXI0miWxWGzZATmcwjcL6sbrN0Nc?=
 =?iso-8859-1?Q?3/P9jiTv6yVipoRzRipa7mn0kalNj7UIyVWQgbZFGYIhTRckmKh7x/OV0L?=
 =?iso-8859-1?Q?8IoSDcCkPOJPWKhwa/lcmanmPmq3EkAD2xHSpEtUNyB/F3/Esu4cJMGdzt?=
 =?iso-8859-1?Q?I1IhHSBeeEFzJR1mFKlJtt9GcoLKzFPVwFmc3F4SDKI8b3dYlclaoioddZ?=
 =?iso-8859-1?Q?A+f7QjDqsCeEwTvR4wT2QxVcJ0n3dFw0iieXMXoW6dwKOkJ71VXBDThWeL?=
 =?iso-8859-1?Q?lDgKDCutTILEFVjf2pvU3Q4ti++uJ5/2g8zMwSZtbDBpq9s7gzHlUrC5OJ?=
 =?iso-8859-1?Q?FnGuLBK52rCGS1h8mg1Z/C1d8VwESA0KbBKZY0ue3CYKxLrYM8ZuUd/Is/?=
 =?iso-8859-1?Q?9ua7JYsC0Aeskn2i7Xao4dx9G3nb01wWB/jHXH4dP7/rFaZ2V4v61CNQOn?=
 =?iso-8859-1?Q?/Xu2Rkb+3kT0MT/rqIoy/H6glj0y+SgSNVhQaFD+2289zRGt5SSMi2+WnI?=
 =?iso-8859-1?Q?DoVTmOPazX0hNKUW/MLcIXmxGzglBKIkNKwARa5Fzy+QsYadFCuq7WT51q?=
 =?iso-8859-1?Q?GugcltZdAEdFtS1q8oUJLTTRvpMh98c5YqvmY8ODw+FxTv+Mk/43Te4233?=
 =?iso-8859-1?Q?blXv0dbmOfaE6GPYnwG0ywO7jENM5JgzciJ8nW2VawmM9plhOw1zJabS8r?=
 =?iso-8859-1?Q?4lZ+R2ihy905T61B9UKMAQJyJ21UgW673wOGO6SX5CamBJlWatrfLYweis?=
 =?iso-8859-1?Q?/+uHE2eUbIaz5EujdSKbzadqROVuKCfFmwVzlFAvRt5g4D1OXKi9QlsS0T?=
 =?iso-8859-1?Q?yE5A8byFWqdTSMEDPyrqAwwH2lMdIDC6YcHieGHYxgNbwsJKiYBpqINBgL?=
 =?iso-8859-1?Q?x54+y9PPz7iYDMxwjvUp6hvmm9z1OK3ZLveYx76LxsEXAv2rxdPxXauczx?=
 =?iso-8859-1?Q?lOTz9ztEKFEvCjmkUMPSfTAHLm4RQkCK6Mv+8mF2dqrlt/L4xHI2U9lrCk?=
 =?iso-8859-1?Q?WP+gCtMVU4BFqOyg8dTOZoMtKQ5797hqZRpvMN/VB40cZrD20PLC7TX6Wx?=
 =?iso-8859-1?Q?UVkoyovYmgWglzNo7CT5tOZuvDlY+i0/KJ/86SUShRxCf3iUKCVQqhZKua?=
 =?iso-8859-1?Q?VQZ/3J4ST/zOJHOB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU7PR04MB11163.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?z3XUH0ifkPdQRT1Y/nxO/aOCHJo5JJ0A+9ScAHmCTJxIs1PX6m6YDCu9ZE?=
 =?iso-8859-1?Q?MiYicN0kq40U4DqbN3hFRLF5jppGmQ6c7o4IY+1f+QbT9Bmlnvg1ADcZYb?=
 =?iso-8859-1?Q?j+bX6OXe2jdmaWDWpDwDUNAUCHrSODLg81Kd4P4GCNgujjidkmO6jbcWtH?=
 =?iso-8859-1?Q?haK28uHbk8JndViVE9TB4y8lHqEnhE8Gqb9NljqEsbvVH4rG/RhWKk51Yq?=
 =?iso-8859-1?Q?+HVUCmMHckZAbPRLmNhizhBIDGLbaXDnaG9mPUUkIah4sDExzoxrYMg4Zx?=
 =?iso-8859-1?Q?q9MS2Vw+GBZOv8y0a5+UAyrYA1HL+BjC5DJSs0m4UIet1KpKcsBsGQ/Ki6?=
 =?iso-8859-1?Q?efrn1jgOk4K8UB9aFB5/DGgG7pLyMBmM/dyOwJcrOCAU4hIYqnUWJo4W1X?=
 =?iso-8859-1?Q?UoLx5y16XBHNDOfLKn8B8xI5wkkfn51igbv5W3y2k6MtRQh5NiCYhIjyQQ?=
 =?iso-8859-1?Q?aILdrRSL4rcmRLFjdsYqg80abuvioaPXF7U8tzoaKMQK92RL7Nec1MPkpW?=
 =?iso-8859-1?Q?J55H50mu/88C5nQ6SzjcRaeQFuYkiAAhFO4S5l5WRt5bBisGEn2YPP9LDj?=
 =?iso-8859-1?Q?Mgj3DtZQLsftO0Mkew4aTti30nPs7ZMNZvleemb2v6Z0AMXHgPPDRWf/hB?=
 =?iso-8859-1?Q?mYisI7YGvTZHqAeY0K11oRy6bnhzb3OvCkfhsguI/PI8HlxxeasJMGESQy?=
 =?iso-8859-1?Q?09/btULQrRl34SOPS0wu2vH5eDCmy//uap1viSWbRyR5mneV5kpG978qZ3?=
 =?iso-8859-1?Q?cikZvtvUECOQb3eN9I2SSrYpPog4OabzEy+3QY/Zr5v7Bg8ZeZGgSiVFDv?=
 =?iso-8859-1?Q?1Az1ac9nKO7GwoDMffaYaycSOWLufip6yxrrxqBavBa/FWkopXcagSzr3A?=
 =?iso-8859-1?Q?5vqGeD8hfkjM/Et7I9LxCo2nIxQWaUOCaEhF+Cix2b3u9RImyE7TZz+XdG?=
 =?iso-8859-1?Q?/vSpDNW9mUYQjt5CSixA0HPdCF8R3FIdnwzLL35mdC6vHkkyYEUHI0AGWx?=
 =?iso-8859-1?Q?Db3X0kt2100BMJDRtqxqDxYY3DogDXTl3np36uDH7IgjxSWjNlt4pl2JAO?=
 =?iso-8859-1?Q?RaI8nsbM5w0xNx3FnXed/JVCODPMRDPJEs6Xz6l78XbgkEdYgpJ2vYSSAb?=
 =?iso-8859-1?Q?4hB6Ox0A79bSpJ9F5lteCubUohaD3iboJtld13KEDJ+pNbP9CHFO4x9fzo?=
 =?iso-8859-1?Q?/f6XRzadXHiWjUVvLaeHZLRqU3JlIWsB5z9WhaS8xXZicvRh8yfkapHpHm?=
 =?iso-8859-1?Q?VMSBqwGwLdZ4fl0VU8APNHzEJEVjn7+5W9SSXbiQrJTSFoF3JESyvUWXkp?=
 =?iso-8859-1?Q?oQ1jwdf4gagpuASYksGdMR4hd1rHNns5qXk/ea2YVguSPDQz0SBZatYhDs?=
 =?iso-8859-1?Q?uAeyKAW6jzqcPmvskGqG0Zz8fo++4dfkXsGTEmbm0ClqG01nUvng5NrkRS?=
 =?iso-8859-1?Q?1r+6Q2z9t1Hq3z0wu3uJ/8ydkIc5B3cNhwLXRhnEZ1V8mwS7PLOHne7llG?=
 =?iso-8859-1?Q?XaacecMNHo2Gyeds4y/wDnYiQzUoZrRPCq/dsq59JksiwJb5g3ZDDpPX3W?=
 =?iso-8859-1?Q?ERy5Fyb6LyilLa6/OSzG/EgpDl2owglIKVn65CSEHxPOakVRtnbvmBfprg?=
 =?iso-8859-1?Q?dAK4yGOH8zE1P/K9aH4U5Hazqu132OmVsf?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 787fee03-33cc-4f42-a1e2-08dd50e8cdce
X-MS-Exchange-CrossTenant-AuthSource: DU7PR04MB11163.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 13:24:57.4855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LvB+Csie4fYGwlScDbji/1UuZ4pu3AiqS2jvy/zlLEQ7Qb3KSaOOfNdNB5gMDcs+zMBX9173FPloHjlehq9vLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10841

From: Florin Leotescu <florin.leotescu@nxp.com>

This patch series enhance the emc2305 driver by introducing
device tree support for configuring PWM output config (open drain /
push pull) and PWM polarity config (default/inverted).
Also updates the thermal management, to be configured based on 
device tree definition.

Changes since v1:
- Add dt-binding documentation, as recommended by Guenter Roeck.
- Remove emc2305_unset_tz due to 
  devm_thermal_of_cooling_device_register use.

Florin Leotescu (3):
  hwmon: emc2305: Update cooling device registration to include device
    node
  hwmon: emc2305: Add device tree support for polarity and pwm output
  dt-bindings: hwmon: emc2305: Add YAML binding documentation for
    emc2305 driver

 .../devicetree/bindings/hwmon/emc2305.yaml    | 95 +++++++++++++++++++
 drivers/hwmon/emc2305.c                       | 55 ++++++-----
 2 files changed, 125 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/emc2305.yaml

-- 
2.34.1


