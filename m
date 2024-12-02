Return-Path: <linux-kernel+bounces-426932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6819DFA43
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 06:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3861281A3B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 05:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD901F8EE4;
	Mon,  2 Dec 2024 05:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SUJKICdb"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2073.outbound.protection.outlook.com [40.107.104.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA170800;
	Mon,  2 Dec 2024 05:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733118344; cv=fail; b=EWlXRCs475YVNqUHOs6DfyyTET9poSJOetjsZFowUaaQNBNlMLwtWITtKUMRYgnfAIozIHWD31e1fNOrxjfkxsKoypwQ3gIXFH42d6fggdMNH2HcSRaAi5wZiOt4Re6BWQGDp41jGbO0O4ofSwXB+PsD6Y//9XLpRqMk9lZ0XSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733118344; c=relaxed/simple;
	bh=JWGoFsIAmlUisyaG3u3a3Xm0wYGM+o4C5fiavmz1nqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JIY+plZ4ewEXUYR1odk+Yff0LxjR8aL0Y3n4Q2ucCozU46zJ3io0X8b7GmPrymCJJkJssRclGHZKn79vHwYUHOxxcJCfgPh044TYPUG6IeJla2OF5N6I1WOcYTZDoEm0hd77+QqoMLkgaqpT/Ko0a9dx6zbSmxvW1GdWQkQi7JE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SUJKICdb; arc=fail smtp.client-ip=40.107.104.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bCD13nvcrYMNbf1qz2HPG5aHvmYwwl4D5Bz9I3SMTwsoGZZWvbeVdPCGGnv3w+qMJoThE5svhtrrCR+q0UxhdqIX1GL3lCJKnLfXZohJH5WYSTm7SxPd6hYc655Whg99W1Wd3OUwiDI86nLN8kWhCy/JZd1jiY4oL2P/WV0SAtpMrf8r5Ca5dHLbeq8h3YgqUT5436vQbJZbIwqHR6whB79xZYaC75qY1QoGdSzEv/qCDONGTVitqwepVFLUuYCIccF/yjkjdDTmvNFV77MVVAhpSu+IpIOeZpuSK0SFvawGSQxitfuBk+0Q7f5lw/Qc5o+PcKh7w8MUgTTMtEasww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zouekyy5uu3+KcekXxKYCtJro2fyc4CqxQiWGuOXgIc=;
 b=nUohIy81tWE8vET9HOrUgbeuXsyngnh+SumIH17RwPUilrt6Qk+0KxGwyFBcKtMsJDMT+CamT9L+i3PGAMWkTtx1m9nBvZRAp5Be2NdyIZ7H4jzNWSt6MwflJ0frFnwEp+u+zok2M0jLBi1A/OxYfXKH12HqXX5zXeNI88rluvney8BnaBQcjPPDxAV5CPxpg2khpOfOgADHK3WqcQkA8xNE75VywCbgrLoIASxBRD/2cmzgeH6TijAGPg+bFp4Sb0juGOJGDCNsHk2sYBz/Yr37fRyrKMLBaSiSgypuOA3T0XLB5jJx84jGE5kLWK+K05kPtDi7/cFMIn4wqxHlIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zouekyy5uu3+KcekXxKYCtJro2fyc4CqxQiWGuOXgIc=;
 b=SUJKICdbNxKdgSbVJgppjfEAttEz1D7xv+wL6LR601NBzbY5xajw5vRIegJUFLTJh5kkPb7OQEkkyA+UvwlRi1E+/aIGBKpZ3ieFNBOq1yhdPjxv7y9Ui3PysIYcLt7aWmhWKaj0dSKQB1cRp7dftSS+7/L//l6GxL6NSC4vPE5FrNDoza8/Gr6ZowteNjiG8ZhuNdxOEZFDfuNMK4zJZg2oSCvzy5ObO2Kt7G3LA402X4rG3hn+A8BsdRuXNzcMnFLM/wMidaY8xUXT68qyU6vc1RVUiUwpGdkTgbK4MASh18PsdIn17Bl8qSKOGh8V3hq3W6sDvq2lhq9JtYGFwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DU0PR04MB9420.eurprd04.prod.outlook.com (2603:10a6:10:35b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Mon, 2 Dec
 2024 05:45:37 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%6]) with mapi id 15.20.8207.014; Mon, 2 Dec 2024
 05:45:37 +0000
Date: Mon, 2 Dec 2024 13:43:14 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: Miao Zhu <Miao.Zhu@synopsys.com>
Cc: "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"andre.draszik@linaro.org" <andre.draszik@linaro.org>,
	"rdbabiera@google.com" <rdbabiera@google.com>,
	"m.felsch@pengutronix.de" <m.felsch@pengutronix.de>,
	"u.kleine-koenig@baylibre.com" <u.kleine-koenig@baylibre.com>,
	"dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
	"emanuele.ghidoli@toradex.com" <emanuele.ghidoli@toradex.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Jianheng Zhang <Jianheng.Zhang@synopsys.com>
Subject: Re: [PATCH] usb: typec: tcpm: tcpci: Make the driver be compatible
 with the TCPCI spec [Rev 2.0 Ver 1.0, October 2017]
Message-ID: <20241202054314.k6dt7uhnv2kavea4@hippo>
References: <LV2PR12MB5799D45D0D1376CEBB244A48BD352@LV2PR12MB5799.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LV2PR12MB5799D45D0D1376CEBB244A48BD352@LV2PR12MB5799.namprd12.prod.outlook.com>
X-ClientProxiedBy: SG2PR02CA0094.apcprd02.prod.outlook.com
 (2603:1096:4:90::34) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|DU0PR04MB9420:EE_
X-MS-Office365-Filtering-Correlation-Id: 2912250e-7fc7-45dc-ea77-08dd12948bc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+uaqjmZnP52ESpsTFIkm2TImsYHMpuChtPsS+O7TwWJqHswbPuxU7b3d69co?=
 =?us-ascii?Q?MCsIl6D8tMo4Jq2Jo+ygPzMuDYtQyUSVvfKbnBCz3X5EFvLdLN1trMi/Aedt?=
 =?us-ascii?Q?DlcHqbeBFa8SidCXEA1bl1R4bYYf6GWIesULGtQKwLUCjHdbk33GLREQzuBx?=
 =?us-ascii?Q?WsVCNQv4EeTNHwsRJp4yAhk/Re4B6a7zAUYROzpEXFtDb/oDVmRBplKD353v?=
 =?us-ascii?Q?qRH5T5rRVLDvHqrvbkKUT0uphL4Gdmh+5obgw6PgYieOfwqMcppVOcTLgQ7i?=
 =?us-ascii?Q?VSDD4hBWCCVINuBpBjexANczXBlnfwpx39PzakGcWrTOYomzABm8VeBheEYH?=
 =?us-ascii?Q?HC/DLCE44XirRdoWvmZfJUMz1JPEz8O03VIQMykIsoL7i661Isdp/TOJ/0s1?=
 =?us-ascii?Q?wO8xtpf+ILNgELY2cwrC7FCNBy7ZMExiCzocYX/CclqQNvDAhjN1ZqUvPrcc?=
 =?us-ascii?Q?A833S6jRucvuJNJ8jfNFVZiDZRcwFBBZCPC2xcquzHKKbie4r0BaseJ4c4Gt?=
 =?us-ascii?Q?ZZ4NMaYk9ie3e+41SK8rZgTBo1xn+gE1Wi5IJjuMC01/WSj5kT+/QDiB+hcQ?=
 =?us-ascii?Q?W6jBfnCG/hVFYLoAv0Q/B3qPl3KrqwIU7gRhacyIsxccWk45k2bO7ywF6X3e?=
 =?us-ascii?Q?oDjOz2Z2aWJca6iIbHDoez2MU67cTERrFpLBzAnuDegH6OU5M2F+whpBsDce?=
 =?us-ascii?Q?9eqy7ApWIll0rpiLZHFVcpjUdkmrcnED05TFJABgnbEvzlyuA2TYHrBwqVXD?=
 =?us-ascii?Q?A71KmTG8BBcemkYBdseq2vtJmw7lbQ2fZnoFdTXKledFeVA5v6Gq0FWOnM+1?=
 =?us-ascii?Q?q8U6tjzdOmuhsmT//AatJKV0dvypqsx9cNqUmke1cXgLK4NSgN3QlG++10x5?=
 =?us-ascii?Q?LbMVCEdoN/zoM1aHjzjCLyObSNbRhdxVRA6cqrSkcr5vmf7yI40A8/hM3ESI?=
 =?us-ascii?Q?Aig+pO9jB/yqKq/Wc24hVEayonSZbV3Qw6jzLck9+HRt6isOOLIgjxTyySWk?=
 =?us-ascii?Q?UX0UybcZnhwm2qo5HxL7nj8IyoKXSrLuP8cC7XUgwtN15Yp8vxilBf7n2e8s?=
 =?us-ascii?Q?3NroOblZbdgAeWrYVsGUQwelbcOHWjpe5ppyH/sC8w+pg9UjaYHxOn11+Nww?=
 =?us-ascii?Q?QFjXIOYXi0yTbDmYLJUEQCrFAGlYrUkBzIGsq0huoAiun7GfXwAWxRI5GHbp?=
 =?us-ascii?Q?yV4X2BSgXdilvnJtUvyA1WvEe06U+zdqdl+wotSRfDFmFcalPI3I40Txdb8w?=
 =?us-ascii?Q?ql1O+8Cx+lQpAGpSat8yX6GkUenGuIDoRMAx8paEa9/HEpPBMnkidqbdpQun?=
 =?us-ascii?Q?2fhiqmElZigNIpS7cIp5vHGwxiuC7XoAZ12/yy1I+h2CHGHOexa7Jbm7A/XJ?=
 =?us-ascii?Q?LqPt0h5vpl2n3EpqGPevZ3NPs8Q45W25hfRoImJssmWDnu2XsA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TZ0H9lacGR9oRj5+L3vZqHIrSnr4U784loVYzIP3KhemDRfCTbujapiP/dnm?=
 =?us-ascii?Q?LVpa8i6vTFgvAEFSRbM28wA8rczzurt7tHAjoGPmKMWSB4puyTX1yx/CRujR?=
 =?us-ascii?Q?pLsZ/31S3L9h56y/0ceD+OJ8ixGy68OuSo6fgU9ol1r3izW80EQMXP2qn3F/?=
 =?us-ascii?Q?tHSKYD3jadX20lGiIa2RyINqWL+FmuZM7sbOkK4LuFLHyr6miMaeicDe4WEM?=
 =?us-ascii?Q?CeLeFtwPQHNNsHluoP5qeeil0TBspTlnvQb/1sgoc7UwGJGLU/SB7MW5Os2V?=
 =?us-ascii?Q?/+MFIaHUwNvC/72/Pe59IkHMy8qcrPpkhtZZn/oAI19cek6XF4kYD5bewOGh?=
 =?us-ascii?Q?1CXbaXgszW3xw+nD5uJCM1IWasZDopCj2+YEM+tiTQSMoOmuOOB+5hneP1Xh?=
 =?us-ascii?Q?5LveDOzCitNjFocpcyxXLEm/3gVVKnUC+a4rk0YI6VqQnmj8dQZ8+Lopkswt?=
 =?us-ascii?Q?6HY/gwxrWfSH1xnMFccLysNgSYBOjmWYtAiPT3uIc1E6YsiZe74g8NdjJPoE?=
 =?us-ascii?Q?zu0FmQXLatwXu47HqI01NYch+kspt3apB0yBqNNcSvv3RYCfr2++pjBNVH7x?=
 =?us-ascii?Q?X3afXBUiFuXPwkan5fF+945rgfvNLLENzAh268tp6jYRqrE5/wCWepcQ67Ea?=
 =?us-ascii?Q?su6YT78v5Of7uxunJsgTFCp7GoWHHyjeeoe7IgHCLZ/lTEXpmFDcMDyAUR55?=
 =?us-ascii?Q?T7kyFuoxG6vSFwfN7s+B3E6f6H3wAvE2PwV7jot4RbOmN80hSR9twYXYCrWe?=
 =?us-ascii?Q?ededqdCNcjTLR3gOz4uyCngRZbTDEklqZjD2bDgYlL9L+hiXXUTyB/xaizaE?=
 =?us-ascii?Q?AEMJV8wDKVDwzCMM6/xbaheCrE5j3fu3teZ+KnYOXEFbhtn8sWBh/fzVZCjO?=
 =?us-ascii?Q?BjRdEcoEpOkuhhLdu/9flPAg4uSNPvp6U/hcJ8CY7Lcpy+ftV76Sbuu7xc+0?=
 =?us-ascii?Q?QWKwuH8dEqgCBITJlVhDTTzVzjUBRYwuXR9iRmNgZzkog12NjN0WryDrlsp1?=
 =?us-ascii?Q?mu5m6u5zvF03IiXD5Ojb0WBRQ3FKJDQGSySTFGAgZwmZnlsyc2zTSCy5qELB?=
 =?us-ascii?Q?XL9gFobIkGhs/Xn2W4RrSZzEOGhs6M02XO8EYlQDoa99e3/rwkBpCA9ltZ/G?=
 =?us-ascii?Q?qoq0309AMKmnHRq2AVsQ/PQCEC+Y5RbWsOXVFc3JaYZZLmkM5fOrk/sshWBd?=
 =?us-ascii?Q?c5WZxi7qsqoOY75jBF0JxD0cbwWsk6zHEirlZ2B7wUzYPfQCM7PY63UVqugj?=
 =?us-ascii?Q?DgH+6b35EPnhHSf7TWWv+H6MWslhD504OLS0mI62I6cV5QxXHTTC/CmOv7eF?=
 =?us-ascii?Q?VnfXWCapnUIwW1iS9lGP2KBEthStKmhX2ntyiYv7d1NC2VVkWUj6m7LMKENb?=
 =?us-ascii?Q?AaJU54OWZpyxN86L1QBC6P1eD1X7eDnI91onNsA/WKVDTzakuW0q+TC5IY1n?=
 =?us-ascii?Q?lGsGgJb2194aL1D5DGQS0qxcp+r/jxqaMQKnXoNhA+QcqLfW4zlr5yJ4OA+W?=
 =?us-ascii?Q?PftOTN4xrXHPo8gywcK76PAFrJfM09acZ5qnYLX+xZ6HVTg03ltRuNOJSE/+?=
 =?us-ascii?Q?fyfy245H3uSVkw7/Riu1hJES+2o+8GUYx4EqQSwr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2912250e-7fc7-45dc-ea77-08dd12948bc6
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 05:45:37.4884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FobeMlxu4aIMHKvKFyUBEIhg6l/akBRJpNejHqdjF0H7hoi+nIZyTm0KFXf8PZxigtvW9dMk2BBbcZeTvgnslg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9420

Hi,

On Mon, Dec 02, 2024 at 03:06:45AM +0000, Miao Zhu wrote:
> The tcpci driver doesn't fully follow the TCPCI spec even if
> it mentions this spec in its comments.
> - Add two flags into tcpci_data:
> 	RX_BUF_BYTE_x_hidden
> 	conn_present_capable
> - Following flags in tcpci_data are read from device tree in tcpci_probe.
> 	TX_BUF_BYTE_x_hidden
> 	RX_BUF_BYTE_x_hidden
> 	auto_discharge_disconnect
> 	vbus_vsafe0v
> The change makes the driver be compatible with the TCPCI spec and
> therefore won't impact existing HW.
> 
> Signed-off-by: Miao Zhu <Miao.Zhu@synopsys.com>
> ---
>  drivers/usb/typec/tcpm/tcpci.c | 115 +++++++++++++++++++++++++++------
>  include/linux/usb/tcpci.h      |  11 ++++
>  2 files changed, 106 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
> index ed32583829be..e4a885fa38b5 100644
> --- a/drivers/usb/typec/tcpm/tcpci.c
> +++ b/drivers/usb/typec/tcpm/tcpci.c
> @@ -453,19 +453,26 @@ static int tcpci_set_roles(struct tcpc_dev *tcpc, bool attached,
>  			   enum typec_role role, enum typec_data_role data)
>  {
>  	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
> -	unsigned int reg;
> +	unsigned int reg = 0;
>  	int ret;
>  
> -	reg = FIELD_PREP(TCPC_MSG_HDR_INFO_REV, PD_REV20);
> -	if (role == TYPEC_SOURCE)
> -		reg |= TCPC_MSG_HDR_INFO_PWR_ROLE;
> -	if (data == TYPEC_HOST)
> -		reg |= TCPC_MSG_HDR_INFO_DATA_ROLE;
> +	if (attached) {
> +		reg = FIELD_PREP(TCPC_MSG_HDR_INFO_REV, PD_REV20);
> +		if (role == TYPEC_SOURCE)
> +			reg |= TCPC_MSG_HDR_INFO_PWR_ROLE;
> +		if (data == TYPEC_HOST)
> +			reg |= TCPC_MSG_HDR_INFO_DATA_ROLE;
> +	}
>  	ret = regmap_write(tcpci->regmap, TCPC_MSG_HDR_INFO, reg);
>  	if (ret < 0)
>  		return ret;
>  
> -	return 0;
> +	if (tcpci->data->conn_present_capable)
> +		return regmap_update_bits(tcpci->regmap, TCPC_CONFIG_STD_OUTPUT,
> +					TCPC_CONFIG_STD_OUTPUT_CON_PRES,
> +					attached ? TCPC_CONFIG_STD_OUTPUT_CON_PRES : 0);
> +	else
> +		return 0;
>  }
>  
>  static int tcpci_set_pd_rx(struct tcpc_dev *tcpc, bool enable)
> @@ -741,33 +748,86 @@ irqreturn_t tcpci_irq(struct tcpci *tcpci)
>  		struct pd_message msg;
>  		unsigned int cnt, payload_cnt;
>  		u16 header;
> +		unsigned int frame_type;
> +		enum tcpm_transmit_type rx_type;
>  
>  		regmap_read(tcpci->regmap, TCPC_RX_BYTE_CNT, &cnt);
>  		/*
>  		 * 'cnt' corresponds to READABLE_BYTE_COUNT in section 4.4.14
>  		 * of the TCPCI spec [Rev 2.0 Ver 1.0 October 2017] and is
>  		 * defined in table 4-36 as one greater than the number of
> -		 * bytes received. And that number includes the header. So:
> +		 * bytes received. And that number includes the header.
> +		 * In Section 4.4.14 of the TCPCI spec [Rev 2.0 Ver 1.0 October, 2017],
> +		 * the RECEIVE_BUFFER comprises of three sets of registers:
> +		 * READABLE_BYTE_COUNT, RX_BUF_FRAME_TYPE and RX_BUF_BYTE_x.
> +		 * These registers can only be accessed by reading at a common
> +		 * register address 0x30h.
>  		 */
> -		if (cnt > 3)
> -			payload_cnt = cnt - (1 + sizeof(msg.header));
> -		else
> -			payload_cnt = 0;
> +		if (tcpci->data->TX_BUF_BYTE_x_hidden) {

use RX_BUF_BYTE_x_hidden for RX?

> +			u8 buf[TCPC_RECEIVE_BUFFER_MAX_LEN] = {0,};
> +			u8 pos = 0;
> +
> +			/* Read the count and frame type in RECEIVE_BUFFER */
> +			regmap_raw_read(tcpci->regmap, TCPC_RX_BYTE_CNT, buf, 2);
> +			/* READABLE_BYTE_COUNT */
> +			cnt = buf[0];
> +			/* RX_BUF_FRAME_TYPE */
> +			frame_type = buf[1];
> +
> +			/* Read the content of the USB PD message in RECEIVE_BUFFER */
> +			regmap_raw_read(tcpci->regmap, TCPC_RX_BYTE_CNT, buf, cnt + 1);
> +
> +			pos += 2;
> +			memcpy(&msg.header, &buf[pos], sizeof(msg.header));
> +
> +			if (cnt > 3) {
> +				pos += sizeof(msg.header);
> +				payload_cnt = cnt - (1 + sizeof(msg.header));
> +				if (WARN_ON(payload_cnt > sizeof(msg.payload)))
> +					payload_cnt = sizeof(msg.payload);
> +				memcpy(&msg.payload, &buf[pos], payload_cnt);
> +			}
> +		} else {
> +			regmap_read(tcpci->regmap, TCPC_RX_BYTE_CNT, &cnt);
> +			/*
> +			 * 'cnt' corresponds to READABLE_BYTE_COUNT in section 4.4.14
> +			 * of the TCPCI spec [Rev 2.0 Ver 1.0 October 2017] and is
> +			 * defined in table 4-36 as one greater than the number of
> +			 * bytes received. And that number includes the header. So:
> +			 */
> +			if (cnt > 3)
> +				payload_cnt = cnt - (1 + sizeof(msg.header));
> +			else
> +				payload_cnt = 0;
>  
> -		tcpci_read16(tcpci, TCPC_RX_HDR, &header);
> -		msg.header = cpu_to_le16(header);
> +			regmap_read(tcpci->regmap, TCPC_RX_BUF_FRAME_TYPE, &frame_type);
>  
> -		if (WARN_ON(payload_cnt > sizeof(msg.payload)))
> -			payload_cnt = sizeof(msg.payload);
> +			tcpci_read16(tcpci, TCPC_RX_HDR, &header);
> +			msg.header = cpu_to_le16(header);
>  
> -		if (payload_cnt > 0)
> -			regmap_raw_read(tcpci->regmap, TCPC_RX_DATA,
> -					&msg.payload, payload_cnt);
> +			if (WARN_ON(payload_cnt > sizeof(msg.payload)))
> +				payload_cnt = sizeof(msg.payload);
> +
> +			if (payload_cnt > 0)
> +				regmap_raw_read(tcpci->regmap, TCPC_RX_DATA,
> +							&msg.payload, payload_cnt);
> +		}
>  
>  		/* Read complete, clear RX status alert bit */
>  		tcpci_write16(tcpci, TCPC_ALERT, TCPC_ALERT_RX_STATUS);
>  
> -		tcpm_pd_receive(tcpci->port, &msg, TCPC_TX_SOP);
> +		switch (frame_type) {
> +		case TCPC_RX_BUF_FRAME_TYPE_SOP1:
> +			rx_type = TCPC_TX_SOP_PRIME;
> +			break;
> +		case TCPC_RX_BUF_FRAME_TYPE_SOP:
> +			rx_type = TCPC_TX_SOP;
> +			break;
> +		default:
> +			rx_type = TCPC_TX_SOP;
> +			break;
> +		}
> +		tcpm_pd_receive(tcpci->port, &msg, rx_type);
>  	}
>  
>  	if (tcpci->data->vbus_vsafe0v && (status & TCPC_ALERT_EXTENDED_STATUS)) {
> @@ -916,6 +976,21 @@ static int tcpci_probe(struct i2c_client *client)
>  	if (err < 0)
>  		return err;
>  
> +	chip->data.TX_BUF_BYTE_x_hidden =
> +		device_property_read_bool(&client->dev, "TX_BUF_BYTE_x_hidden");
> +	chip->data.RX_BUF_BYTE_x_hidden =
> +		device_property_read_bool(&client->dev, "RX_BUF_BYTE_x_hidden");
> +	chip->data.auto_discharge_disconnect =
> +		device_property_read_bool(&client->dev, "auto_discharge_disconnect");
> +	chip->data.vbus_vsafe0v = device_property_read_bool(&client->dev, "vbus_vsafe0v");

Please also document these properties in dt-bindings.

> +
> +	err = tcpci_check_std_output_cap(chip->data.regmap,
> +					 TCPC_STD_OUTPUT_CAP_CONN_PRESENT);
> +	if (err < 0)
> +		return err;
> +
> +	chip->data.conn_present_capable = err;
> +
>  	err = tcpci_check_std_output_cap(chip->data.regmap,
>  					 TCPC_STD_OUTPUT_CAP_ORIENTATION);
>  	if (err < 0)
> diff --git a/include/linux/usb/tcpci.h b/include/linux/usb/tcpci.h
> index f7f5cfbdef12..0760187ea4b5 100644
> --- a/include/linux/usb/tcpci.h
> +++ b/include/linux/usb/tcpci.h
> @@ -50,6 +50,7 @@
>  #define TCPC_CONFIG_STD_OUTPUT_ORIENTATION_MASK		BIT(0)
>  #define TCPC_CONFIG_STD_OUTPUT_ORIENTATION_NORMAL	0
>  #define TCPC_CONFIG_STD_OUTPUT_ORIENTATION_FLIPPED	1
> +#define TCPC_CONFIG_STD_OUTPUT_CON_PRES		BIT(1)
>  
>  #define TCPC_TCPC_CTRL			0x19
>  #define TCPC_TCPC_CTRL_ORIENTATION	BIT(0)
> @@ -126,6 +127,7 @@
>  #define TCPC_STD_INPUT_CAP		0x28
>  #define TCPC_STD_OUTPUT_CAP		0x29
>  #define TCPC_STD_OUTPUT_CAP_ORIENTATION	BIT(0)
> +#define TCPC_STD_OUTPUT_CAP_CONN_PRESENT	BIT(1)
>  
>  #define TCPC_MSG_HDR_INFO		0x2e
>  #define TCPC_MSG_HDR_INFO_DATA_ROLE	BIT(3)
> @@ -167,6 +169,7 @@
>  
>  /* I2C_WRITE_BYTE_COUNT + 1 when TX_BUF_BYTE_x is only accessible I2C_WRITE_BYTE_COUNT */
>  #define TCPC_TRANSMIT_BUFFER_MAX_LEN		31
> +#define TCPC_RECEIVE_BUFFER_MAX_LEN		32
>  
>  #define tcpc_presenting_rd(reg, cc) \
>  	(!(TCPC_ROLE_CTRL_DRP & (reg)) && \
> @@ -177,6 +180,9 @@ struct tcpci;
>  /*
>   * @TX_BUF_BYTE_x_hidden:
>   *		optional; Set when TX_BUF_BYTE_x can only be accessed through I2C_WRITE_BYTE_COUNT.
> + * @RX_BUF_BYTE_x_hidden:
> + *		Optional; Set when READABLE_BYTE_COUNT, RX_BUF_FRAME_TYPE and RX_BUF_BYTE_x
> + *		can only be accessed through READABLE_BYTE_COUNT.
>   * @frs_sourcing_vbus:
>   *		Optional; Callback to perform chip specific operations when FRS
>   *		is sourcing vbus.
> @@ -204,6 +210,9 @@ struct tcpci;
>   *		swap following Discover Identity on SOP' occurs.
>   *		Return true when the TCPM is allowed to request a Vconn swap
>   *		after Discovery Identity on SOP.
> + * @conn_present_capable:
> + *		Optional; Enable setting the connection present
> + *		CONFIG_STANDARD_OUTPUT (0x18) bit1.
>   * @set_orientation:
>   *		Optional; Enable setting the connector orientation
>   *		CONFIG_STANDARD_OUTPUT (0x18) bit0.
> @@ -211,9 +220,11 @@ struct tcpci;
>  struct tcpci_data {
>  	struct regmap *regmap;
>  	unsigned char TX_BUF_BYTE_x_hidden:1;
> +	unsigned char RX_BUF_BYTE_x_hidden:1;
>  	unsigned char auto_discharge_disconnect:1;
>  	unsigned char vbus_vsafe0v:1;
>  	unsigned char cable_comm_capable:1;
> +	unsigned char conn_present_capable:1;
>  	unsigned char set_orientation:1;
>  
>  	int (*init)(struct tcpci *tcpci, struct tcpci_data *data);
> -- 
> 2.27.0
> 

