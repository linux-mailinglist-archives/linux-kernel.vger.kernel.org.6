Return-Path: <linux-kernel+bounces-253760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6174932681
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 14:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E96651C22180
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 12:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB0A19A870;
	Tue, 16 Jul 2024 12:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XmGc+Z6W"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010019.outbound.protection.outlook.com [52.101.69.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F5619923E;
	Tue, 16 Jul 2024 12:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721132964; cv=fail; b=rC6qdYwLxX+CLEkTKh/Nwc5t3u8ALxdqjSfpuiJYoLD0Cmw/78H78tYTszsYEe6EVhn+ZZlsB3V9wCzpyNl+kKxPfJm5tewxRSGE19TPbyex7frZaoik2l5cwpYuoVnGOSbZ/AujYRrUt/YxskB/W0p2cmLNRG2LEF6ZHh/jwVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721132964; c=relaxed/simple;
	bh=fyWXIvmCTtWChu+o7xgnIPLKogHt35AnpXJ7jxXxXoM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YyVzYv8QZaET2CImf1yvY4RBaAgysOjF+33zJadje+TzeFXycljnxVIQ6fJUw8WG9m41H+46658uy3NXbsAecwLQcxMdXEynyOMESB7OgR1LJmCTGjAUU3Vj6bUH8n6xcm3lCHjbKVM1rAcz0lCODwSyxX7Gq2G+zTJaHj3qtxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=XmGc+Z6W; arc=fail smtp.client-ip=52.101.69.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SZoaQvHOu23+ljkicI6EVI9NkkHs28Jk8Sqh2VMH/xO4AJesMZWLgAjboPiUdso8+KaRnYQscP8/gm025X3snZPlw/2trZGcUuCfRCl1GOgkWf9lKPtzIex8Ir3Pi+zgQOZ4Jv8dZTJ0E2xxr4aN75xAUjInV7/aqCxU7e2LTXzn7lCx+voyA+APs94szcyM2tn0w2HyX8lQcMElCfdMXiMjVASYRF/A42o3euJb+W/NFXft7BHieiB6KibBmfJVUgLAXrBl4TFALIboFCSGBvNPSB6VrV3QfGnJ/WuH3Ev2qAO1cTRVhdzCIXvl6AnIw4XT48DounVvHPwEo3/D/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wB4HgZHVGNuGXGlqbz9q7B32C9A0YXFHxMVqIFDY9AE=;
 b=mGCe3ZYcCi0qn0YHVyQ7aUxLWDtmt5TbvTOvjAbNvyjWVljUsWUA7tKdpjz92If2LcQiT4yfpXglgzZBKSxkN/uCrsn/bqWWvGKx27gW1LnlbSS/sJVqCOMhM3yWEMGZSrduPeHSXQBpmSrbi7Jvd64Ru2VgiKKrZTNdIR0zSoTRrFWc2kRNq3nxKonS6q8WkjDtWQKZs2Ptxsw+LLrNTcN3z9O0X32xPreBXu3G9q7uSQUnUm3l9o/Q9A17tt8R5KdGOJCwL75UXFUEAmmL1HrDvzK5y137j8RzK6JjlHCZfabczuDzb+Bj/9Vr3WuptZwe+kL6kDFv9IePXAT8ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wB4HgZHVGNuGXGlqbz9q7B32C9A0YXFHxMVqIFDY9AE=;
 b=XmGc+Z6W03Y/9kukrNjrniDvqHUW9QIJJet7BD/+leI5t6hB3rMhaAdmXNy7D+hyp/b1wahGEXXNP84SQh+d2AVZHbvkB5HI9fM6EvKucrQf+HcPgHpfUHxh7J5+GOy0Xx+z7AI3ToTlGzqw1980tBqnCrxN16Hj5udvhB+UZVs=
Received: from AS8PR04MB8450.eurprd04.prod.outlook.com (2603:10a6:20b:346::5)
 by DU2PR04MB8855.eurprd04.prod.outlook.com (2603:10a6:10:2e2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 12:29:18 +0000
Received: from AS8PR04MB8450.eurprd04.prod.outlook.com
 ([fe80::c1b2:719:a52f:26cc]) by AS8PR04MB8450.eurprd04.prod.outlook.com
 ([fe80::c1b2:719:a52f:26cc%7]) with mapi id 15.20.7762.020; Tue, 16 Jul 2024
 12:29:18 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Luke Parkin <luke.parkin@arm.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "arm-scmi@vger.kernel.org"
	<arm-scmi@vger.kernel.org>
CC: "sudeep.holla@arm.com" <sudeep.holla@arm.com>, "cristian.marussi@arm.com"
	<cristian.marussi@arm.com>
Subject: RE: [PATCH v3 3/5] firmware: arm_scmi: Track basic SCMI statistics
Thread-Topic: [PATCH v3 3/5] firmware: arm_scmi: Track basic SCMI statistics
Thread-Index: AQHa1rw/D2gnpDnmJEOC66LF6+dybrH5Se9A
Date: Tue, 16 Jul 2024 12:29:18 +0000
Message-ID:
 <AS8PR04MB84500E870B3BBD1FD270609388A22@AS8PR04MB8450.eurprd04.prod.outlook.com>
References: <20240715133751.2877197-1-luke.parkin@arm.com>
 <20240715133751.2877197-4-luke.parkin@arm.com>
In-Reply-To: <20240715133751.2877197-4-luke.parkin@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8450:EE_|DU2PR04MB8855:EE_
x-ms-office365-filtering-correlation-id: 9dfd90bb-1768-4d33-621f-08dca592e984
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?1bCXgZAxlmKpfypFRAhLKTRc+pBhm6lI3BTqHZnvh98ZmposaqCmFiEQuEkH?=
 =?us-ascii?Q?Y7rVxHYDqtH+wu286qlmmOihT+5NTWTT944tRvB+G04gd+SkZNblkdwgk4qJ?=
 =?us-ascii?Q?xLh9sMIjOEq+aVtICvSjKlEXK3fknQjDKvCqI4IwjftlAquKSYJI3BNpEC4W?=
 =?us-ascii?Q?uJSdmtIlU9MVHidnYVEd/6wQgRGWl12a6lfndYz5INjJiVYqOr0qX/lRxgX/?=
 =?us-ascii?Q?wqpdYE0FFXB0Re2g3mN97zF4TbUmLTGx7MtqgV+G4fpff+5nuQ+FB9CAFt4r?=
 =?us-ascii?Q?2SZ52BFsm0cE+CSwM7Kksp7LNkOawgdbkMsU/3oukxW++lYmMxzm5V3qyvrx?=
 =?us-ascii?Q?5GkRYCUhUVjjcFlYZDqrCdeWUg8UNb0JKkX+pPfy9CwWzeARzGY8Uv5Wq77C?=
 =?us-ascii?Q?x0hnIFrn1R9IhNt9I+QZXuCOrdM/dfkJuGX3wJ+fkSO0EyVArDB21cHrQNwo?=
 =?us-ascii?Q?I80N31yo5q9whtHFDgMA+9HnlG2cYYtVr9eM4GIaR8JVhTc5rFhhtVpeTyWI?=
 =?us-ascii?Q?CoTq3l+JBxCX3YRZi35mEPmICfnK4kqqTCQNK4n40hlp83bkZUvmVlAG/RU/?=
 =?us-ascii?Q?8h45PlQkkUOxTAJVla+iPiSwcLyh7006B329Bin+osKYbKSCli4JXvz085Ps?=
 =?us-ascii?Q?EWggfw8TuhxCpe5HnXBf8Vf8AkzaEmqOGZ93XKn+VKxJFbmd2TyyEcilC+rG?=
 =?us-ascii?Q?lX1EeYXuCKwto3B76vK3vD2cpVXXglM44o3sWYvF6acv/odyHlfp7teHNvX0?=
 =?us-ascii?Q?or/IiUOnH7N0VSEvgdM8EWR/bcBqojjRDGfpZM9XsAHA4wJD0wSgJEaprh2c?=
 =?us-ascii?Q?ZBC6a3QHteS4rX+rFudRGl8srrG585AOEL+KYwk46/mUg27NAP4yOXjwr+vQ?=
 =?us-ascii?Q?fQPrU1CxNCIkbrEEgbL8TDuZ/UakqgIaxwrYBKjBvg7KFGglogRa1Wodm+Ii?=
 =?us-ascii?Q?zgLYPldVDKk5d/j41Nf+VHSmDNMGWhDER3NQ52tZQ7G4VwLwLoIBn132mk+y?=
 =?us-ascii?Q?0PpLf1k61jgMJmSGXv8RKkK4InkKaF7XytLroJ6qC8yVrVP1gsbhnprHPffL?=
 =?us-ascii?Q?HaRxB6urDnL1y7KC7Lmih9yfyhe9Xh+Hnh4/vh8L3v0+Ih615yKbfIdTiVpt?=
 =?us-ascii?Q?0on7CcKMDAUzAdGkzJJE/1wtJ4p1Wy+NkI8x56/A9V4UB02lS6R/gxydNmH3?=
 =?us-ascii?Q?ps4n3XoAuksWZxgQ9MsjJutsDIyQAFRMns4Srgzc2FZqOxpNdSZI6z9FnaUi?=
 =?us-ascii?Q?rEVn+lTBZVYb0ygXakJGHnbKTbik2Pl0dyHQC7kfQMlB2xr/JZZpvAJV7lEL?=
 =?us-ascii?Q?mrTz357lOULnXHvVPhamy8WmNFVATG/u5pkY/6GAXFdhm2GpaKDL/yoYLWku?=
 =?us-ascii?Q?Lj9FhwXFGaQfno0niSap51I725uTBtu6qnDiR0J0+1oCheWlqw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8450.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+QL/EtSelOiwf9XRdAeCQXmhVWpfgETcLBqLBDZ0fOcUjog/AUfmH4NALQ/C?=
 =?us-ascii?Q?VVli1Z/D2KR8wlVP80UqroKq73tSXFNKNwDSW58hZ5+ZyOpQkW9WVTPSlMQI?=
 =?us-ascii?Q?jAEXaG7BniZCiZ9PytTxuMgmalxTl53UXKxN/17GQsoMlW7NTDK1NIO9dFZl?=
 =?us-ascii?Q?1kBS56bICgBkpfGEqFXohv+YqnTgZeaChxqVPqP/h8JbWHD+WUgYVEndp2aE?=
 =?us-ascii?Q?5qVcQi1eWr2XZfchZTWictaKIUlV/ZoTGKaP6P3uDVHK0xlcHPbT/YvDgRpG?=
 =?us-ascii?Q?GxzXky00IuRccKU6XMtfg/lXwefzyLdgtQudkYMvypHA4WkapEefBIoMSl6x?=
 =?us-ascii?Q?JMzJXoWH+axe9RXXSriJje4i6jf7rdv9ubPkonsM1QxiZTQNZb2W1aKw3tEb?=
 =?us-ascii?Q?dKOtdn8t9mg64xYeMce72HcA/asbhSFAtVphNj7rU/uw/g3EEc1npgYm5rBT?=
 =?us-ascii?Q?RoLQLuihmXFOWwyS78ZSdoF7Jj+nakf6Hb/B5dW7vJVXLDTKK7NFr8LjUBhN?=
 =?us-ascii?Q?Ch4iVRG9e95ayXnYq+JvT7jRmaknDPl1JipHcFzqaZ5foFsRf1/CF0aHiKgG?=
 =?us-ascii?Q?sIIsHQWUPKlxOPtHRtWqqW+FpDWyVyBsz2QgorBAMLgIX9YG6o9s9PT4c7xS?=
 =?us-ascii?Q?OR1aJ21gATdRrkWR7j4AYASnXutvzfHn2K8JXmjKAmYk4zAO0auhGoKwbtwO?=
 =?us-ascii?Q?ASuClz0sbSsL4vdVEx6F55xltztEeV+baugiyLXK6euGPW7UyW+wblPp7YvH?=
 =?us-ascii?Q?Rp7cUgfcM6r7B3z+S8SS+M9sSO0MWPc89+ibmdhB5nqoV5vJkaEiG2eMMFqL?=
 =?us-ascii?Q?E6p5YUA16jmde4QPbNDg8BbzsIooP9pcc1oWFtX/64WvX9lnSzB7dpgXzc3n?=
 =?us-ascii?Q?k0lVRRBHyIJ5fc9FUUGJbgphtQUovz+OGW3d7W0SHOXs3S6UESyJZB6PDeWd?=
 =?us-ascii?Q?iMca3zma4rB1bdaGDV2Zlyl+soYLyyCENIOw7Vk+iCSCRdG3oer/HJPBjMmN?=
 =?us-ascii?Q?Rc+Zm1dn/ej3Eb+PfbPRSwHgmjM1ivp8+CPEIDBtrFrYGeBdVGfaUtN7TGNO?=
 =?us-ascii?Q?wkrCOmJrtpzIuaqFcZs8NSq40ij7JH7Rm5Z7FOh+wy6Ow0FAV7qevwZ0rRgY?=
 =?us-ascii?Q?5bPpa4OvVJXHFM0MM4EA/v83FKpRvDFjqCNdqGjx8122EOJGZj6/aL5jnvb3?=
 =?us-ascii?Q?xaG0I9zkVWsd4KhmoGPwurgQ4LuFdWCzIIqXUDadmGMRQBI0kb0Y1t3Xv0rX?=
 =?us-ascii?Q?zrqIsbhVSkPSS0nXHdsmDtQ+YINNyge3PM4hupUq1s6uD9IRlyAbzDk7ibqL?=
 =?us-ascii?Q?wKp/6wHfTm+zHCnqcQOV8olyG5ByafKvn4P/BbRpC17Usa0uGP6LvDw3w1ba?=
 =?us-ascii?Q?SN95IPnwJcnL8arFS7t+l2naI9svT4seM2wPEGefTdf3cO4WDsSkAij0mFPm?=
 =?us-ascii?Q?+PqOsJN6F4QksDmy0Fd6zYHYcqMQEAuXj0KbBOKSnJnX2qrFBhq17IPagM7O?=
 =?us-ascii?Q?peus5vCJtRoOu6fSZE4BXirkxlv1AkpvdvUmxuCAleuR7qEXTiQzw1VRsr/Y?=
 =?us-ascii?Q?o+Lu5u58sDz8vW4snFk=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8450.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dfd90bb-1768-4d33-621f-08dca592e984
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2024 12:29:18.1022
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KCk+QvZcC259qYnziacLO2vi0nhBgjsI9cBwdqVFDKhJUr0/6SCLeg4fqKk8qMRA7ht5LC1sGg2zW12ojuWNRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8855

> Subject: [PATCH v3 3/5] firmware: arm_scmi: Track basic SCMI
> statistics
>=20
> Add tracking of initial statistics
>=20
> Signed-off-by: Luke Parkin <luke.parkin@arm.com>

Just wonder that since ftrace is there, why need this?

Thanks,
Peng.

> ---
> V2->V3
> Add more statistics
> Use new log_stats method.
> V1->V2
> Drop unneccesary atomic_set's
> Use new 'scmi_log_stats' to simplify incrementing of atomics Move
> scmi_log_stats to locations which mean no extra conditionals
> 	are needed
> ---
>  drivers/firmware/arm_scmi/driver.c | 39
> ++++++++++++++++++++++++++----
>  1 file changed, 34 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/firmware/arm_scmi/driver.c
> b/drivers/firmware/arm_scmi/driver.c
> index 6edec6ec912d..b22f104cda36 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -126,6 +126,20 @@ struct scmi_debug_info {  };
>=20
>  enum debug_stat_counters {
> +	SENT_OK,
> +	SENT_FAIL,
> +	SENT_FAIL_POLLING_UNSUPPORTED,
> +	SENT_FAIL_CHANNEL_NOT_FOUND,
> +	RESPONSE_OK,
> +	NOTIF_OK,
> +	DLYD_RESPONSE_OK,
> +	XFERS_RESPONSE_TIMEOUT,
> +	XFERS_RESPONSE_POLLED_TIMEOUT,
> +	RESPONSE_POLLED_OK,
> +	ERR_MSG_UNEXPECTED,
> +	ERR_MSG_INVALID,
> +	ERR_MSG_NOMEM,
> +	ERR_PROTOCOL,
>  	LAST
>  };
>=20
> @@ -994,6 +1008,7 @@ scmi_xfer_command_acquire(struct
> scmi_chan_info *cinfo, u32 msg_hdr)
>  		spin_unlock_irqrestore(&minfo->xfer_lock, flags);
>=20
>  		scmi_bad_message_trace(cinfo, msg_hdr,
> MSG_UNEXPECTED);
> +		scmi_log_stats(info->dbg_stats,
> ERR_MSG_UNEXPECTED);
>=20
>  		return xfer;
>  	}
> @@ -1021,6 +1036,8 @@ scmi_xfer_command_acquire(struct
> scmi_chan_info *cinfo, u32 msg_hdr)
>  			msg_type, xfer_id, msg_hdr, xfer->state);
>=20
>  		scmi_bad_message_trace(cinfo, msg_hdr,
> MSG_INVALID);
> +		scmi_log_stats(info->dbg_stats, ERR_MSG_INVALID);
> +
>=20
>  		/* On error the refcount incremented above has to be
> dropped */
>  		__scmi_xfer_put(minfo, xfer);
> @@ -1060,6 +1077,7 @@ static void scmi_handle_notification(struct
> scmi_chan_info *cinfo,
>  			PTR_ERR(xfer));
>=20
>  		scmi_bad_message_trace(cinfo, msg_hdr,
> MSG_NOMEM);
> +		scmi_log_stats(info->dbg_stats, ERR_MSG_NOMEM);
>=20
>  		scmi_clear_channel(info, cinfo);
>  		return;
> @@ -1075,6 +1093,7 @@ static void scmi_handle_notification(struct
> scmi_chan_info *cinfo,
>  	trace_scmi_msg_dump(info->id, cinfo->id, xfer-
> >hdr.protocol_id,
>  			    xfer->hdr.id, "NOTI", xfer->hdr.seq,
>  			    xfer->hdr.status, xfer->rx.buf, xfer->rx.len);
> +	scmi_log_stats(info->dbg_stats, NOTIF_OK);
>=20
>  	scmi_notify(cinfo->handle, xfer->hdr.protocol_id,
>  		    xfer->hdr.id, xfer->rx.buf, xfer->rx.len, ts); @@ -
> 1134,8 +1153,10 @@ static void scmi_handle_response(struct
> scmi_chan_info *cinfo,
>  	if (xfer->hdr.type =3D=3D MSG_TYPE_DELAYED_RESP) {
>  		scmi_clear_channel(info, cinfo);
>  		complete(xfer->async_done);
> +		scmi_log_stats(info->dbg_stats, DLYD_RESPONSE_OK);
>  	} else {
>  		complete(&xfer->done);
> +		scmi_log_stats(info->dbg_stats, RESPONSE_OK);
>  	}
>=20
>  	if (IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT))
> { @@ -1219,6 +1240,7 @@ static int scmi_wait_for_reply(struct
> device *dev, const struct scmi_desc *desc,
>  			       struct scmi_xfer *xfer, unsigned int
> timeout_ms)  {
>  	int ret =3D 0;
> +	struct scmi_info *info =3D handle_to_scmi_info(cinfo->handle);
>=20
>  	if (xfer->hdr.poll_completion) {
>  		/*
> @@ -1239,13 +1261,12 @@ static int scmi_wait_for_reply(struct
> device *dev, const struct scmi_desc *desc,
>  					"timed out in
> resp(caller: %pS) - polling\n",
>  					(void *)_RET_IP_);
>  				ret =3D -ETIMEDOUT;
> +				scmi_log_stats(info->dbg_stats,
> XFERS_RESPONSE_POLLED_TIMEOUT);
>  			}
>  		}
>=20
>  		if (!ret) {
>  			unsigned long flags;
> -			struct scmi_info *info =3D
> -				handle_to_scmi_info(cinfo->handle);
>=20
>  			/*
>  			 * Do not fetch_response if an out-of-order
> delayed @@ -1265,6 +1286,7 @@ static int
> scmi_wait_for_reply(struct device *dev, const struct scmi_desc *desc,
>  					    "RESP" : "resp",
>  					    xfer->hdr.seq, xfer-
> >hdr.status,
>  					    xfer->rx.buf, xfer->rx.len);
> +			scmi_log_stats(info->dbg_stats,
> RESPONSE_POLLED_OK);
>=20
>  			if
> (IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT)) {
>  				scmi_raw_message_report(info->raw,
> xfer, @@ -1279,6 +1301,7 @@ static int scmi_wait_for_reply(struct
> device *dev, const struct scmi_desc *desc,
>  			dev_err(dev, "timed out in
> resp(caller: %pS)\n",
>  				(void *)_RET_IP_);
>  			ret =3D -ETIMEDOUT;
> +			scmi_log_stats(info->dbg_stats,
> XFERS_RESPONSE_TIMEOUT);
>  		}
>  	}
>=20
> @@ -1362,13 +1385,15 @@ static int do_xfer(const struct
> scmi_protocol_handle *ph,
>  	    !is_transport_polling_capable(info->desc)) {
>  		dev_warn_once(dev,
>  			      "Polling mode is not supported by
> transport.\n");
> +		scmi_log_stats(info->dbg_stats,
> SENT_FAIL_POLLING_UNSUPPORTED);
>  		return -EINVAL;
>  	}
>=20
>  	cinfo =3D idr_find(&info->tx_idr, pi->proto->id);
> -	if (unlikely(!cinfo))
> +	if (unlikely(!cinfo)) {
> +		scmi_log_stats(info->dbg_stats,
> SENT_FAIL_CHANNEL_NOT_FOUND);
>  		return -EINVAL;
> -
> +	}
>  	/* True ONLY if also supported by transport. */
>  	if (is_polling_enabled(cinfo, info->desc))
>  		xfer->hdr.poll_completion =3D true;
> @@ -1400,16 +1425,20 @@ static int do_xfer(const struct
> scmi_protocol_handle *ph,
>  	ret =3D info->desc->ops->send_message(cinfo, xfer);
>  	if (ret < 0) {
>  		dev_dbg(dev, "Failed to send message %d\n", ret);
> +		scmi_log_stats(info->dbg_stats, SENT_FAIL);
>  		return ret;
>  	}
>=20
>  	trace_scmi_msg_dump(info->id, cinfo->id, xfer-
> >hdr.protocol_id,
>  			    xfer->hdr.id, "CMND", xfer->hdr.seq,
>  			    xfer->hdr.status, xfer->tx.buf, xfer->tx.len);
> +	scmi_log_stats(info->dbg_stats, SENT_OK);
>=20
>  	ret =3D scmi_wait_for_message_response(cinfo, xfer);
> -	if (!ret && xfer->hdr.status)
> +	if (!ret && xfer->hdr.status) {
>  		ret =3D scmi_to_linux_errno(xfer->hdr.status);
> +		scmi_log_stats(info->dbg_stats, ERR_PROTOCOL);
> +	}
>=20
>  	if (info->desc->ops->mark_txdone)
>  		info->desc->ops->mark_txdone(cinfo, ret, xfer);
> --
> 2.34.1
>=20


