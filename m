Return-Path: <linux-kernel+bounces-359049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2BE9986CB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60BF11F24E8E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AFC1C9DED;
	Thu, 10 Oct 2024 12:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="G1J+MxYf"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012031.outbound.protection.outlook.com [52.101.66.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E104E1C5782;
	Thu, 10 Oct 2024 12:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728564956; cv=fail; b=UJPadBfbU2H2UG/KY0owKRKZq+qMmcKc6adJUBKAnDd8c6+5uVw3r2Dyt2MzIz6wd5glF+7bvKvYbGJ/gi/IefjrJ/zKhRvXM0fdf1Hdd5ZOO6vkfyoO+jaNVJQ07UrBnZTIl2u2TChmteWRv1ewb5WaXlJzduNo38PfegmIOvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728564956; c=relaxed/simple;
	bh=tQbg3V1tFBL6/BYdhxQGg5SrmJd5T+imYXWPfJ6TbKU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Zji70Uy78AUH6JCf+Jyau/sCBQCUc2hV+Gi+oqJwA1umWfq4dUFO1n5HnPbVP6B1lgztpMPOzg684pKZYmjpJNeUTocZVCcX9zuxoyn3lioWTs2m6eaOUZNExhBObgAh6kqymnNjACauAFslZfJr5eTiJoJ6GonROVw7e1pjb6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=G1J+MxYf; arc=fail smtp.client-ip=52.101.66.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+g3yfOOtavCM2GsyJgYRZ/j7QALYY+cSQ761vJ2+5qOxmIBrZGgmQhVot88ZVx1TfWbEjvVChDlV+VYbzCkiWRiauDY+MH011m5UFB8qEPf/6WgSWlCiMLFhVjkVa+u9tbgZ92lZAAdwpApvpzi0XCUylKWrFELLQAaZjnKASL+dKKBioNj6rZ/q8cgOZDpjm6zKvOVbZYmIJYPiG67q4B0FHq/yQbysuPnWb9xeYiZUOKAMjtNIz+WLuNak+fQjhMEsO51UueQbQ9Bu78cm8AIBfNjnEMjm+F+Ma7PeH76usM34dFQkw1oAcW9ObxOZc0rc2xeU/g7gobh6yE8VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EdYsk/roxXr7vGRVNYH6Il2SFMXzeXTpneQEym/sKg4=;
 b=n5Dz2O5/9UXRLQATMl7De3J97RFAZh5G3PrQKmAnDmyMWk8E0kHSEKmCqZUVvHaxwHGt/2FRYgvCakrtGXhPMhKHweVoJSepPX3s4mxoGgR3jamwqWqLZY6aBqMXFOH+mtmWcLLCuiszTIGNjO+ChxwDwUfuUhz+HIzyZ7pLbt6ZkXaMIADbQ4A6CmQgoipLETG+lnqQXzMBz+CFnInUnKc/D6Gu3E8oUDyfyTQQpnm3PYR9gcD8NskCTnXDevS5C1biXoYx38CtPB4PXxLl1qW7J7hd3XnLnaIHAQrJZamEd1FRknk/I+bn6BOvGg5NDh6IGGDbvGiMxM33SnqPuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EdYsk/roxXr7vGRVNYH6Il2SFMXzeXTpneQEym/sKg4=;
 b=G1J+MxYfmsfil4F3M+T4swx3JnVqFwLIeHzgoulZPXCAEta+kz72+rqFTjx7Bl8ZcIKQv2rq7OQau9U1QX1soTWJq+V+qArjDNte+VVbl5/FuFcX9Hu38LkJim3vvXNlOj3anuuZ+eMJmeJEe6Mjw9QU2IQElCmerALjqnQIgh//E5nD12/ZAdhjQw8V6fA4J5F7jJf90CrxjQplAOSQ+9CF9AiJvEZ0D53JhMk+Z6UevTEcVsYgJMXe7ych+W+JLDlnpfic0djDy1Dhb+lNtOhj9+1bivF24XwD8ieFeb5tin1E2UUhfIN1m4IsbG2zS16ggW1Tubhd9sxKFjoC9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by DU2PR04MB8776.eurprd04.prod.outlook.com (2603:10a6:10:2e3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Thu, 10 Oct
 2024 12:55:45 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84%6]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 12:55:45 +0000
From: Pengfei Li <pengfei.li_1@nxp.com>
To: krzk+dt@kernel.org,
	robh@kernel.org,
	abelvesa@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	ping.bai@nxp.com,
	ye.li@nxp.com,
	peng.fan@nxp.com,
	aisheng.dong@nxp.com,
	frank.li@nxp.com
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] Add iMX91 clock driver support
Date: Thu, 10 Oct 2024 21:57:33 -0700
Message-Id: <20241011045736.308338-1-pengfei.li_1@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::6) To DB8PR04MB7065.eurprd04.prod.outlook.com
 (2603:10a6:10:127::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7065:EE_|DU2PR04MB8776:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d1011a4-80e1-4802-fe00-08dce92adad8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|366016|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XZyTMNDuYichJIugcbm9pREAmo2oV0oGIU16KCehD8k8+JD0XrPLrA0qIK8h?=
 =?us-ascii?Q?TYVGpNAHCiiTabCZDJW0u6nzgN8WPtY7nZ8tDrpzn2SmvP2YczSBwOVt+CGA?=
 =?us-ascii?Q?0rQXPZbvnWOMGtdeYQQmFBtScYbZ8/nfwsMgiFgAQLxa6a4ZMN7gu6B6USQH?=
 =?us-ascii?Q?WypmMqm/vtj3NtTUhGvwpkOBMorjgnPw5HEU3NEQClTsOvGlUJr1HEx+3/wq?=
 =?us-ascii?Q?dXSEpkjW8LfKaeN4ieYmvyyAsPSc1uRGLcaSq7mr8XcFhhGvmtci0G8tmvp1?=
 =?us-ascii?Q?UCZBDRIpa2LN3BBhpog0EExZuQETDM9Ng+PBIEKY2yrsggAK4wnjNva5tPQA?=
 =?us-ascii?Q?mDv28vns+MtVANUkQlyKAeUfz8zsIN2+YrY44nLg43hDgqkQEOLwGT8UbfF5?=
 =?us-ascii?Q?6ExESlN+0E0SMJYW8JfaRqRfL6rG2EKr7SDSQeokHRj/50eALxJCEXBhKglO?=
 =?us-ascii?Q?uFFGlqgqLUOv02BPsvy6m603k9Jg0Npedelqq1XLrxiBQJWfeS9iAhZBLNDa?=
 =?us-ascii?Q?2j4hV4coUdln8NklY1FXFZPSd3bZQxSlKVTqJHdydSxsNNNGPonxxa+RcLzZ?=
 =?us-ascii?Q?K3nFuCd998AAAJ6349XNdo1JWWyPvxyyfgTRmta7i/wQfYy4LQ+VWETKFpd9?=
 =?us-ascii?Q?FyQ3ROKjQqdoIEWZDVQL6bXhBprmDgrTzpcZGlzqhXgwB/PLIslSQFyyInYX?=
 =?us-ascii?Q?nhn+vqPyJRwkO9lbzTsKlqWPTC+KF+tDCqmdv/YLbB3HVGekjIwAoRmeoyy+?=
 =?us-ascii?Q?92i2U6TOWpMOlVUuMpS2vj17c2xgTL7i6epjy0NUJ6U3qc9c6lWEfgUhOj0q?=
 =?us-ascii?Q?fQxGpDaHaIJJFxEulI7Ye91inc7QvbIuD03+gbhQsuUdfNFBMBOHCydeEFm1?=
 =?us-ascii?Q?yl+bAw0LHUBIBYVUfegnQHPUBq8hWhanOWltTOhFn/jz7gT4tyynEXSXpynR?=
 =?us-ascii?Q?DjJdhppACrgEuLwrDpvF0psxjMLhmmDB+9n8Azx9Iy7Or9Vt8a0DTYxgGwC8?=
 =?us-ascii?Q?PakUAZkShzQiz/qHQfhQN+z1nz2+90xZNV4zStnemHMS2m0NgJTUfhU/Fjow?=
 =?us-ascii?Q?Jj5fyAl7Z4HO1hu1xjBckaS3KazF1YsyTb2Heg8VqZ9jpuH5ba7MVWUOwhkZ?=
 =?us-ascii?Q?l4FUFueOt+WlUml7HD9vUcgzbda9pf+hEBI41t1aldMwk8pN1QOoXf9ijcjC?=
 =?us-ascii?Q?wqiR7XvTdJ7ltt7yduG8njn6qUjFNlbIp7FlCpU+guiq1y1FwWwfx25Td8E2?=
 =?us-ascii?Q?H8UntWp3itYpfBpn7895BmIQ7gdOy7AaANEAqP73ru5UBYqoYic/H9mF64hA?=
 =?us-ascii?Q?QzFUtRYq0UfcD2IFfGC6fZGfUSd78NShgNW1/zOSlvwzkpoBMVKLTeZoqkSf?=
 =?us-ascii?Q?ICN9g68=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(366016)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2yzHB5smVn7v380xprJ+QuG1sI5YK+DBqs2rJX8VGcOUAzDa/InfONt6ZaTF?=
 =?us-ascii?Q?6njijmMmVVId+ilrtKIcuYZ4SgRp+ekW/ecvIaEpovmror7mk0asyE0bEWyq?=
 =?us-ascii?Q?FYSduk7v3UpkX6b92w/L1sZmg//wsuBYjAcYfo7w8ajkYAqs9CuIigjS71ex?=
 =?us-ascii?Q?3CXKeQOT/OX24dDpfdkAY6O82vds9zNGvB9aXQD5AkTJeYO0UopSHvWG0Xtq?=
 =?us-ascii?Q?c3VsoAS/vJkTrP59uo6gXRg4ow5WzEA0ge5lS0d1ZSDzz1qZHGrGmGpa5A+v?=
 =?us-ascii?Q?bdRC5uS2mIMoXrHBE35duIBDacwmGAAW3Yti2QYq3/LL/BC+W4NfrWd7BSiO?=
 =?us-ascii?Q?TlOVygp6VzGYLWsgRdDYak5wsxJ2UYNR2Ngheq+0zhCdlywLicTyEl48m/38?=
 =?us-ascii?Q?bGzNR1xr3/Kqt2O+okuClJJKzDTgz5B2KGxp7m9BKClxjcRWoAXiQ6mPu4TN?=
 =?us-ascii?Q?3kO+AT3HYXGwB1FhcXy6gOrSyf+1VFkVs56ZKu9Ms9cd5WLYI872c3OaViUd?=
 =?us-ascii?Q?q84cgpkXvKHtO91JhWSNnwPCS7AL/3BVAvo4+JbAQFyAjfCPX6jJxdfCSCoi?=
 =?us-ascii?Q?kvwg1WL6B48CXhYpxS9Ta2iOH2KX0JNEEdvxdvNIDJ7yaTHt8PRVzSdKELgR?=
 =?us-ascii?Q?TIRCk/6dd4ky+nZ+xgfjDhS2LnJi4jEgS1cgDYf0O1ZZyyiTJoc1sUlyXc7j?=
 =?us-ascii?Q?WrDvVadt3JrF2b92UplhRH5j/lQ13KG39DZBki3utZeW972NP+Jn9qP4qVcN?=
 =?us-ascii?Q?wRPsqg2R9lNCIbSEm9nEWd46K04Yt4Y4rSzerMNSzbII10pIH1/owCB0wWAG?=
 =?us-ascii?Q?QHku7akGbvOgCIxAgfSY3nNfkeQr1g04V/2rlQn8RDrVR8Zmo7bVw/jRUGU/?=
 =?us-ascii?Q?pGE1ri+BTIpIBOcHEAhPxL5AmBhDTVRgvv0X5md2/eizVe4hhmIWrTGt0+Q7?=
 =?us-ascii?Q?V+VdsZcIep3xlSxI/PruUJAHDW3RWVaWqLj0NmIAOGCfmX3yJYewNXuiXkbk?=
 =?us-ascii?Q?dD9J4zJcOJeIUmsPSnjNTGam1fuzyjJdlfx1STyyPMdC+XW8u+pBCsv5gMnO?=
 =?us-ascii?Q?vHJe6Jou9ZdNrfxPyE9fTT086mRKT97ntftPqojJ7CW4uirpDrS9svOfj6de?=
 =?us-ascii?Q?dbSzkWgW2kx9eK3VribYVNzQqzGkNpGSk7MTpFmyiW6hBqpgEb/u+BAxpu+I?=
 =?us-ascii?Q?o4kPpQaUS2A7+xHHB+qZSTWRrlrPY0pQ0RiyXmnctpOOlYMhGHbY3MnwH3v5?=
 =?us-ascii?Q?ARoZp5AWbpm+xgFsnkFn1kUTWmLUAxXQr+uVqcRUSO+VsbgliD7lFLW/2+ZJ?=
 =?us-ascii?Q?/qH09ewB6wA9WmWhoLyOH2Q3bT4EECyG1vHYeG2p6py10QRsZn8sW5CZfiCs?=
 =?us-ascii?Q?jbn7UjupWTqtxxqXMwwZUZUvVdbsDFyin/nvu/qWiNmYjZFNckERraN7OSUN?=
 =?us-ascii?Q?kDEFf7mLCtEcwNys5BUlpI+T6a89Dq5s734ZNb7bmzzoa6Ei1TmghFBI7q15?=
 =?us-ascii?Q?51w9BVhfwvA2Ir86ssEA+PgOO7Yw46CqlP+ZMUf/uq2qBTi5d75pFt0aciGf?=
 =?us-ascii?Q?1WhFSWp6jf9Ci6qNFwFeBrVbdxn/6PFf/UzT/YdV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d1011a4-80e1-4802-fe00-08dce92adad8
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 12:55:45.2665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xSUE8ypNp4H6tiWG2gAdDwPrtdfP4sY2nKbZx/vV6juhG6A0L168rguqxjcaf4X01aAbkyRSPMNtTegufn6/4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8776

This patch set is to add some new clocks to binding header and driver.

'IMX93_CLK_END' macro was previously defined in imx93-clock.h to
indicate the number of clocks, but it is not part of the ABI, which
contradicts this define when adding new clocks, so it should be
moved to clk driver.

---
Change for v3:
- Add some new clocks to the bindings header.
- Move _CLK_END macro to the clock driver.
- Add iMX91 clock driver
- link to v2: https://lore.kernel.org/all/a07828a4-8040-42cb-8c62-8939cac4d9de@kernel.org/

Pengfei Li (3):
  dt-bindings: clock: Add i.MX91 clock support
  dt-bindings: clock: Add i.MX91 clock definition
  clk: imx: add i.MX91 clk

 .../bindings/clock/imx93-clock.yaml           |  1 +
 drivers/clk/imx/clk-imx93.c                   | 63 ++++++++++++-------
 include/dt-bindings/clock/imx93-clock.h       |  6 +-
 3 files changed, 46 insertions(+), 24 deletions(-)

-- 
2.34.1


