Return-Path: <linux-kernel+bounces-412412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BEF9D08C6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 06:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19E00B220B0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 05:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F87A13E03A;
	Mon, 18 Nov 2024 05:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TdaimFtj"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2087.outbound.protection.outlook.com [40.107.105.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC3B145B27;
	Mon, 18 Nov 2024 05:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731907202; cv=fail; b=YOojgx2doOTk3ImdVJ1MPGhgni7buihNulIOBVa8gs6Pf+jdxANgzL4RO7UVwvAGhCddEo4srVPMaDBY371P1+aBBV/n6POvIeSVBmWRO4VSNV9hPsV2jjBKsfrUxUhe0NwF83Ih5Ma1FKbmY8AAUOMFLgZDzYWRDnki1d9x0VA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731907202; c=relaxed/simple;
	bh=47BID3/EAwQ/hfEYX9zqfvK3CJLJbjTNLqJ6BTNNTmE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lNtC55MTec9i7I8hIKaA54gBY3ufUrQeiTyykec9RljqC9m7L4BhlSbTuRQx0+ePWJ20MpY11tUP7S9R8utAo/6OIZakj+KeyvWi0xfp9Sx8zPNfbZPDREihbmEgua/iBQrBANMb/WWePf8KCzqzibERlv1i5uL3hGE/ql2vKKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TdaimFtj; arc=fail smtp.client-ip=40.107.105.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uI92kW1F5LZ2fmctnhqn1YXQ0uGH6pGlSILBmqlNtnyGGCP8qFZfyjYPpR/s2uOlgHZkl9pqaLeF+u+ognnJVkpkbDWnL2EhmFxvBUNPoXsMbh93t6b15pTqaDMENyCpwqu4G70XlG2ZLl833jiXVmsFUqNmdhoPjhbcnwpQFKIbbcdA8MxXSJptBCLUt5e9gtyXkyG4JlQVGDsZgjPinzHrxQvb+iwEVW9/PJvZtCjhPwZwMZKg932J2J42juqbpsHG9wnPXCcz14DLup9LQsCOXxzGwtHbgbp+G5MNnndRxN0mQZQlKXvlWTUmXXSTKZz+pnALNvIHPF7xdxK2lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLxLopONr+bmQwpXzOgzgGmVd0/gY8kF1qAL7keGdT8=;
 b=udMf5HUqfoPGOSt07o1Lf/zowjOZ6JTv85/SvT7cuV84yr+fnRu8PCJ89DQl3c57FdzqERnZQLJMvZvg2tlK8SHAQhGm+ocDDyFkVQZTvAaqX/QuNbtdQPSqQ3D60+FKMvsJGvd77d/mjON2RObhRJE3phn17fFBY3/q/fgFbpmame+RO/zJEstQIMbha+7TkeZ2ITjAuTXoAtm+t/WySMdpOk8iz3SYqEG9jWdvNhX3wAR3aKto//6DBzr3pLp09DJ0iUufeigEbWEJbZw8I+Ui8+1ONZIx9FOWd6IdG2O8PEjxgCu2x2usJbtYZ21C5n1VZHUsWRT35WvPo9ttZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLxLopONr+bmQwpXzOgzgGmVd0/gY8kF1qAL7keGdT8=;
 b=TdaimFtjL6VWhKeuvuEY7t5yasIJAxJJ7YaZ+zy8fpEVe4Sv8ZNQKCDiUnMQQX149QGUTsE9NNz2woUoZkLZCPKRtQEeN5LtLNwrU9mSFDgFjqax2EgyqAfSoUrSkClL+NrR0spg1+48H7kOPSBfmEg+tyi5jKMzdeZa5Q55DaNWzSdZX2dlJMoR1ziEr0wmS3UOB0xhazXU7foF2gvoTxWPwu4xud1XQz5Jo2WFE5otnSQBH864heUD2KGbllTaymkdRDwHig15vzWdBZn7PxY/g74J9UakfPuK0nAY94L9wH9P3trMaTG/rInag/vZBveUFz2/hQ4fgc90i19E6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7058.eurprd04.prod.outlook.com (2603:10a6:208:195::24)
 by AM9PR04MB7508.eurprd04.prod.outlook.com (2603:10a6:20b:283::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 05:19:57 +0000
Received: from AM0PR04MB7058.eurprd04.prod.outlook.com
 ([fe80::d7ed:56bd:30e4:4ed5]) by AM0PR04MB7058.eurprd04.prod.outlook.com
 ([fe80::d7ed:56bd:30e4:4ed5%3]) with mapi id 15.20.8158.023; Mon, 18 Nov 2024
 05:19:57 +0000
From: Pengfei Li <pengfei.li_1@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	catalin.marinas@arm.com,
	will@kernel.org,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: francesco.dolcini@toradex.com,
	joao.goncalves@toradex.com,
	marex@denx.de,
	hvilleneuve@dimonoff.com,
	peng.fan@nxp.com,
	hiago.franco@toradex.com,
	frieder.schrempf@kontron.de,
	alexander.stein@ew.tq-group.com,
	mwalle@kernel.org,
	m.othacehe@gmail.com,
	Max.Merchel@ew.tq-group.com,
	tharvey@gateworks.com,
	quic_bjorande@quicinc.com,
	geert+renesas@glider.be,
	dmitry.baryshkov@linaro.org,
	konradybcio@kernel.org,
	neil.armstrong@linaro.org,
	arnd@arndb.de,
	nfraprado@collabora.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	ping.bai@nxp.com,
	ye.li@nxp.com,
	aisheng.dong@nxp.com,
	frank.li@nxp.com
Subject: [PATCH v2 4/4] arm64: defconfig: enable i.MX91 pinctrl
Date: Mon, 18 Nov 2024 13:15:41 +0800
Message-Id: <20241118051541.2621360-5-pengfei.li_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241118051541.2621360-1-pengfei.li_1@nxp.com>
References: <20241118051541.2621360-1-pengfei.li_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::7) To AM0PR04MB7058.eurprd04.prod.outlook.com
 (2603:10a6:208:195::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB7058:EE_|AM9PR04MB7508:EE_
X-MS-Office365-Filtering-Correlation-Id: cb0d50cc-1724-4922-8aec-08dd0790a48d
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?PVgOHraS2NDMeKX2mDABIXI8so/ajzxibwvYlvz9IP4l7A9WVjnuoz3KXM2r?=
 =?us-ascii?Q?w1qFR33Ibrl41YZE2E53LX4io23V9SiQZn8fjqe1ZMplIug96POHyW1Mqbnk?=
 =?us-ascii?Q?FB1DbcHnQQo3zZ6Oe9k/hKa874Y0hc26XG6iY2/QsftJ9F6CFpdpJTvtayV7?=
 =?us-ascii?Q?ECJM5npQgHuXRGOM+MohJIc02pGIeY/1Tz324vUWjPXs1c9yWC2smBKDRJg2?=
 =?us-ascii?Q?dozyM43KswYFL9xXpW9y50ERAbe6PZ/j9Y5DO0u+KqOT+ETNksFmKAoxPSH4?=
 =?us-ascii?Q?haXa+uO+tmjfKmDn8hTmySZdM3gPsVSDq+Mx2yLO6ljM2/Ide/20C5WM79mA?=
 =?us-ascii?Q?DZsMqwFiajB9YhwJbM3Ayftu9C+vH5AD0H5YYqNfEaud+vvHnnKx5+yQdOkW?=
 =?us-ascii?Q?cyRTGfHxgk5MBHq5m7svAUzgdckdbuomZiCelal/uzdN2F0QpqvEf96yw8rp?=
 =?us-ascii?Q?i8hLAB59EjOkQmzCNJKe5OVI9QrfE5ttNh1k1HK7+EN7RKmRADLEzpcmooMj?=
 =?us-ascii?Q?5ImWbIhWQqDmHZoy7AGok+0QRgzhN4+8jmmLFBHDuM/zS030zzeH2IcWCsoa?=
 =?us-ascii?Q?mjvLBZGd6TlyHvjSGpkhFxU/g/yJBKNF1NJye1uoxMpC0ztw+q17jlJHuArS?=
 =?us-ascii?Q?q6Ew5wuDeqpnJUA2osztd/KUjP899xvDsJonaCmmQblmfmlSeCVAwJhEEfgI?=
 =?us-ascii?Q?cE5QNaMXmHyt+Vg7/sTEoi77Nj3b8tz8E32elobcosiKsOBG43G1jGx1v7CI?=
 =?us-ascii?Q?LR5OD6PnsD/IFaPotgbzAhinfRH4qzpDSmG3shBVPoVX3KwXGYd6tkEx661G?=
 =?us-ascii?Q?WCxiXYTPdec/RlGqWCH1H5OnbxNpb2nYJFTSqg2SWIRSsoNgXo+RGDXj2MWi?=
 =?us-ascii?Q?Gdz7R6HePuQt+BII3k6sIc0Kt2XUyTai3mgjhfIwqUtdUxCBKqV62ElVDOBU?=
 =?us-ascii?Q?fNSWpStElzziimWIDoJdcjWrTFXuGDzaAIuwyLujO3emU1wjiGumF+yZwp+e?=
 =?us-ascii?Q?UvV9UZpk61XTrK/rJTZUbF3Wt5AgkfvMdAaP/8oPpvSUkrZb6ylc+DVRm+C6?=
 =?us-ascii?Q?jLNI1NTY52CbxYcc3BZ5CC2s2DAwO8SAFMfSjphJVWpGOQF+io8kAg5+ad9g?=
 =?us-ascii?Q?+QlKa4+7G7FX2TJwD+WnXdPfKY26wQmUw1h8LOdBCgzLsAhUjakKp4/fU+wU?=
 =?us-ascii?Q?gp/cshkcFd/6mfsqkUmL1WO077PJhssSUM6fDERsQ0VaMfRd0h+XlmiyzaOu?=
 =?us-ascii?Q?qMkUpG00lj+m1z56DidVmpSePy5muKp6LXuI36K6qWeoHcWmlapdyTw6i0Z9?=
 =?us-ascii?Q?omJTNCEulIqt3t+5fboZW4AKCFWI/4BTJw2rJWmijwG43Ey2ED0FgbcFOXnd?=
 =?us-ascii?Q?ZrlzBv8=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7058.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?mXAXfi6kMix/kJrNApmMs4qFH8gNE6TIaHdxgO79xhTQ/2f73Kj9J6IHPsNr?=
 =?us-ascii?Q?ozeY37PiqvlYj1Q/zzdqlehnsBmqYHHogYitv23zbnU9dNghnBqBnA5Ns26g?=
 =?us-ascii?Q?OND1oa9v74RbbRq8NV3nK2rXRjC4oGb5q2IPrNswZbOKF2BTuUd1OSdV4/Wj?=
 =?us-ascii?Q?IbTGmU1egQsps0LJVwek4tdj2pRr5VDpeDQKhn/h20nC0vdDvx7fEVASda6h?=
 =?us-ascii?Q?igNBcNchohCFQxIeSwMuO1LNIVAapT/phwUmVPyhuprtDPFgQYMLIRfFngob?=
 =?us-ascii?Q?XcePCSy8ja+wrPpvIYuwEOnX6PvAOjCh4Y3RWDeBpHcUyAtBVa31nWntbPvj?=
 =?us-ascii?Q?RMuPeqtznnSW8Eh126XeKWM2EP2xfG/fIKrmwXhXnHKQtu5JogmNZAOEvpEb?=
 =?us-ascii?Q?gfvyu7rfw/MIS4lOXhxP80HowSDG+YLylpCku/z4kAxh7psH850aKr2ouoeG?=
 =?us-ascii?Q?DKHhWVvFpakzn3YZsLfomrvjngnCD6XEHInKq0hkx043MaIeGNaijbtK9wsJ?=
 =?us-ascii?Q?mLvQe3IwUzVXXjoJDDTKwEvJ4VF1Fp3Q/WhnEmf9thQoGnFC/CCsSGVI8uqt?=
 =?us-ascii?Q?iNLajZLOLhhA+jiYwuSuNQ/lGhZD9Xab1+weQ1900k5VHMheSJZzGeDe/Xe9?=
 =?us-ascii?Q?+x5873wbGIPl67grsWfRDT5yjM/jkw0GVusz4ul8dJ+o0bIuFEteKTWY/4LC?=
 =?us-ascii?Q?XrxsqsF57BSxBT36q1hJGh5JwGALN2zRDPm9Z77aEce4vFk7l3Gd1aSXiAYJ?=
 =?us-ascii?Q?sl51iEu0v5Z4IdckJ6aK90vGgpSF/hs+2rtGQ8g2i1xMXaj8O9KSKAwOHNf7?=
 =?us-ascii?Q?7TG/bjphkBGKUNpGrLDaRpONPdJaDxq/M3VAO7r19Ht80HhhN2AgQVfBMB8l?=
 =?us-ascii?Q?n8vyDBR7HZWG2UDi4wAcih1ZWHg84YDAuU33cnXaLSRt6WvOLurn4OFuWIfl?=
 =?us-ascii?Q?Cxd5gXoFuQqYKMWxnpDANIWqBemoy+ZjgwI8ZM+fgy/HYTpQG+9rDApm6pqb?=
 =?us-ascii?Q?bIOapjR0gllgflUkzCSq2UI5RM3So/Mmw1pYNxzG/lhuan5OluPPkVQ2x5sX?=
 =?us-ascii?Q?CSzZEMILcXOG4xh1/1TRxQHJva3CGNzp9DqoolDpd42gHK8G78CGEtG9X4tc?=
 =?us-ascii?Q?4jumgtMtHAXQo3e1im+s+tuQV7P3pmuNU7aEFAqEaZtzei1iYlmQ47kMthpX?=
 =?us-ascii?Q?8ecfabZyNfwaQu8C3MGFfHT34BkV4NJ+pEcZfBqRLD1/KhQX06prb7+k8SKy?=
 =?us-ascii?Q?zS80VeuuXRtx1y/a2IQ29dMwF/RhuzYBciYuMyjBxEOA1ZXOjBhiDm23CGLy?=
 =?us-ascii?Q?izznQ5iAolyrqAyh0pH/XRfzL0qWjSDabCVP0Pg6AgkJWcll4F2eIAu57nH9?=
 =?us-ascii?Q?eFZmn01ZkMQG/rvnn3Y45ESi1oMFM9p1foZW4njQxErHk5C5dutfSYuWaEDP?=
 =?us-ascii?Q?LNbeH3stkYtkMviJeZ/N6CcB5VHZ2RVmVZh47yuwSmS71nAAfNjFG5/faFQd?=
 =?us-ascii?Q?6xPx+jOEqkr6r/HXQuGwUj9bygIf9kRXztkmTI0CwFqFL8uB3QSfSnaNfRwP?=
 =?us-ascii?Q?FiE6N2HTNjQHCTtNEim3vNbxfMueq8Jzusvz9mp4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb0d50cc-1724-4922-8aec-08dd0790a48d
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7058.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 05:19:57.7311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /sdooHqKt9r6zO5uaw3McJrwImJwKXITuQIXlyLGMC5XHz8qM6OU9SB+2y1oq2YyOE7Mh3qhsVawAI8t7GaO6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7508

Enable i.MX91 pinctrl driver for booting the system

Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c62831e61586..82dd0875052d 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -592,6 +592,7 @@ CONFIG_PINCTRL_IMX8QM=y
 CONFIG_PINCTRL_IMX8QXP=y
 CONFIG_PINCTRL_IMX8DXL=y
 CONFIG_PINCTRL_IMX8ULP=y
+CONFIG_PINCTRL_IMX91=y
 CONFIG_PINCTRL_IMX93=y
 CONFIG_PINCTRL_MSM=y
 CONFIG_PINCTRL_IPQ5018=y
-- 
2.34.1


