Return-Path: <linux-kernel+bounces-195184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AD88D489B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 11:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6880B1C215D4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 09:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791FB6F31D;
	Thu, 30 May 2024 09:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Kj5/RHO5"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2053.outbound.protection.outlook.com [40.107.6.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9942D42A91
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 09:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717061648; cv=fail; b=O3LXxpQ/pTidSrcHTkATn+iXUC4MS3HX4kl+mGqR2/ZHmugl+Mi8qv/D55Qs9MyG61aPW/B8fpsbyahzvKYwp/OpHBoQdLjKpMlDmSlFebO8R2n8ahj5MtPrBaXpR3aqyoSUFRCFBvtNiKFihRmupyMwUEZIx/OhY6fcl9/N6Xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717061648; c=relaxed/simple;
	bh=ZpGx614ez8zLl9f5QG/Wj6/3XPZgr+QfLdsxKqMi61I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A/mrIMjS6kEcwSylpZRkAz365V++Je5Z/lTmHT0wx3z5j03Mdd8AEtxA1avaqJBhcvp1C/jhBBOiWJXZlFcfansKEGVcH/PKa8VLFKlNIah4PJxGsx3DaKAkKcImPd9oc6Skh4g8LfkSDz33Yt+uI1yE0t9dEicKJaNCcHCNQpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Kj5/RHO5; arc=fail smtp.client-ip=40.107.6.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ClkklBH7RGMrAQSvQ05kS5AdyJY7BPnz5sn71UxMNCDZgMKqRfA54GtJhMwRzlmt+hqQ6Qobyshoex93JP0Fqkbe2U1Q51wMt21aObYwuGXx4W7kPmPSMa8mAWXsTpYKB7qLGTZ5QCvOMlJs/dIFISPTxWgpKLmJ+lds79d14vSHWWE7P3Pkf5fT8MWVivR7DkBJsEV8fl/d11KdhgWb0gH5/M61CcsbBqM49H1CnKlKdZ3Vy/O9PdCJynfOCfRzjY27hdodQSz0SQeTD0Ya8nzxepbEE9G1pjtAunySTZPjba4q0Ignp4Q0MFFrb3BZ/ePGDobg80IC4ckN8Sip4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZVZCWBuBptZrgIohmjk3AsarE0S+NGZr1UDcUbHOuuA=;
 b=SpFYerc5L+MAN6EExGXszEjrLoZ2wHpOSIzKZO0R2x7yq61ZI5ET6sfhctPD1K2l9ouh4RRHlDxPhtlrtJcMLjBTts3g3AzuKkmA8sWfb1zulXY3ORJ1TtMPYw/UUXqIN0Iup/xRjTyBQU8u3cQYlwvuz8BtRUtkjeFG9ecnIo+FvHUERqWyH3RB+3ZElHwHmwX4xmE80U0a44lUOgjSiX9lENFfB7WG9siSMu/ErvrONF0my7Xuzl6IC3gIEe013+d+IkqjslP//I8fIdE1uko0ocxWzg5kKS0IGk3RqMdv0IMs7cBMpTQNMxVwQOCPQwWYzzLwfPih6S0wD2ea3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVZCWBuBptZrgIohmjk3AsarE0S+NGZr1UDcUbHOuuA=;
 b=Kj5/RHO5Y+Q3TjdmkCLgmNBLo4cp0OjEryeLySeX0ml1A2Z7nvhgtpYHn/z1kveyljf18JthkmaSKVaUjxIFzmfQQiLCOaQP83pEm0dpnxdQkLcjtEWj+iAkvI3FeU4C56rfvXFEfchtWApiQZeY3qX9aSFy1UX3b7VY73y0L8Y=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU4PR04MB10887.eurprd04.prod.outlook.com (2603:10a6:10:592::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Thu, 30 May
 2024 09:34:03 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::557f:6fcf:a5a7:981c]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::557f:6fcf:a5a7:981c%7]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 09:34:03 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, "sudeep.holla@arm.com"
	<sudeep.holla@arm.com>, "cristian.marussi@arm.com" <cristian.marussi@arm.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2] firmware: arm_scmi: power_control: support suspend
 command
Thread-Topic: [PATCH V2] firmware: arm_scmi: power_control: support suspend
 command
Thread-Index: AQHamT+2kPkNNu1tdEe0xkM7CL1Pt7GvtVBg
Date: Thu, 30 May 2024 09:34:03 +0000
Message-ID:
 <DU0PR04MB9417CE9DE7AE18A7FB2D381A88F32@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240428075105.2187837-1-peng.fan@oss.nxp.com>
In-Reply-To: <20240428075105.2187837-1-peng.fan@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DU4PR04MB10887:EE_
x-ms-office365-filtering-correlation-id: d900155c-4d00-4792-b08a-08dc808ba4f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?xCRa71HPILk51FxLtLqRFsQ9wrIRG6i4Nu2NsqAd4qDz2HU808bJ+et6e82E?=
 =?us-ascii?Q?WkQ4mP5Ux8ne+R6gWOZuoWyaBMvKVxGE2nDM5jYNOFGN/S1cifwcpzKA29+Z?=
 =?us-ascii?Q?IYGjAC8XfMlbycwbLo0bYJU0riP2rvxv63F9OdUakf/Z/CINeK9hoMqifQBB?=
 =?us-ascii?Q?ZTHABJOVQB1kCrDrkaOS3Lqu3AnpuRjv2XkNTa2boZZlIk9zxauTaEqeo4yx?=
 =?us-ascii?Q?rEhHLDpSQV685g61SgCWcHQtLZQjBom+O5FjnBgZDQSDgPI/d/aUUYb69PxA?=
 =?us-ascii?Q?ZJS5d6lhCnPi6yICL0Uy7Tyf25QfvirXo5nMynE6FRIUehEotSqJzg2e93Qu?=
 =?us-ascii?Q?scDA3DAO2koVPH/sKqIjWFUMSN1xD9aWRzaaWhm5XS7thyatwGgSkLqUH6Hv?=
 =?us-ascii?Q?rjLJ/sIQFvQn9OIItWFoJc0zb48UXsQP0nMr8MWqWbNaA6MQuV+6u2RsLmWG?=
 =?us-ascii?Q?B7sxyJyvAB+Dg/QrZere6L0w/fFI7vzCBDcRsJkpJuYxCJXr33nQBwMXt88W?=
 =?us-ascii?Q?SUVWn0nriPb/GexraRas+UoXAN4G6RqzaNew7gLWTy+X+JHI9H1FKwpOa0c9?=
 =?us-ascii?Q?DrxPe1uh2GBf9pjC4d7kyokgr6BUGguA02ruQORIJwU0fsZ8KvwI2LQTY0VM?=
 =?us-ascii?Q?Mb8LnaXLqTv8h1lxYTAdvKr6m3ZIcsbvpdTgMEzvmuUgGs7ZMpdvZZTDWwe+?=
 =?us-ascii?Q?yX94YqlOyETCu5FtXGMgHIcp5GvHXcWay/amyg/+Dx0DmnrxxqCwhU3T/3u2?=
 =?us-ascii?Q?NucgO8h4Qlc41T86Ben8J/vlNO5q1VCZ3h+UWhDwD1aNo6Q4LcGLGANHzmlU?=
 =?us-ascii?Q?QYSY019faqnBUAz0wGeqohlDGopt7fQX+JZqT2YGPX3GIt5YBIzc9iTdokSH?=
 =?us-ascii?Q?KeEoK9IXSfWPcmTvhRbIISOj3Y2Y+jDXPKcznGo/AoV2spMUeC+SQELppd/h?=
 =?us-ascii?Q?D1a+H6KYSPe2Elc63S1UoPDqz9NBd9rYFL610/7KGZw6obIRfYjKFM+ZPKuM?=
 =?us-ascii?Q?/H9YVUeiKcgqzEfHxMDIKjqLvYIrvavhA59X2RxSXqJrK6zjr/Tmql29wa1b?=
 =?us-ascii?Q?YytR50b3x8qOtHEU0xNzMYdZVk8fFDzRPL/wF9rZa2xb7aFMpb7WMGCCSddS?=
 =?us-ascii?Q?b5r7yw3fWI20GeRy08IpImGmPfHoyVa9IAtas4FI5BEG6Y3B/IR5ROUxXDc+?=
 =?us-ascii?Q?Bl88HXaemP3Y81X3VvEsrRkQa31l5LQN5pGE8BCptHRjbiWutr2JaSap589i?=
 =?us-ascii?Q?XIeI+ls1fWrmC/LVmnYKVkR7Rcm5ksBkoKFJMfFip+Qz8F4V/3xR2f6BEmrq?=
 =?us-ascii?Q?Zo0+MOtzS66F8jy1QIQAtUwqm0lZ2ZGwCxekTZ7kAUCmzA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ZHcny79EtzLsUtHi/dREw8ZmEtTjZo4+MpLxWJOyQCkTurKKaY9i2rsNbOBP?=
 =?us-ascii?Q?a10/aH1JoDF2Q7Q1lLGz2+S8RccIGrEenvuGoQGxwHPdJOp0FYypXowqKmUQ?=
 =?us-ascii?Q?5JViXGkEbzICFizwMlBgNdABaEXpYZAN/SrwfKXMKd7cCYvfZbXTwkQT3jBe?=
 =?us-ascii?Q?2b+Cavmwy9KJR1Jk78kpS5XNNWHwpKhQK2iKF4dibtNolkl6OrLyVYnaNUc2?=
 =?us-ascii?Q?rNHhgGAyZmPlEk5ouwHT7H7PLs9x7z5ROiimqCNDc0NoIljqSdKh4LHciHEC?=
 =?us-ascii?Q?+er3T4y6gdWOfOdgW7cG8RcYM/7w8iq1B8wJ9jg6vMQzmPZNYXhF9ZxtJHrb?=
 =?us-ascii?Q?putA5NriClPhHYLic6ire8ttEuNB8H81o+qbx+V9p3uubbsfJNtL91m97lKj?=
 =?us-ascii?Q?LjJXCSoHW/SIsbKCNQNDpDDPTqvusNOu0KXGq2pn7t8t429NjP22Rag9gMMq?=
 =?us-ascii?Q?BhTWCzU9yM9XNeaIfZKF2qerjsOD8TgCZdXVIrjnAtdAg5me6oSjwC6TYgZR?=
 =?us-ascii?Q?oC6TZ4NTiBWH+PvFjojasUVK1woH9pr6I3qO4mmYMtAAdffekIRorDmWbdQu?=
 =?us-ascii?Q?JeJ0rj2qEHVS3SAAW0F5gqlG+x2jbIj4mbEZfO44x7aNKa0ppjDymEaIDufV?=
 =?us-ascii?Q?Cp8H33EFotAm7hvtfQ3761E4xCeib0mFRSo5mJmxuGzA35wffeHqVeJoyb97?=
 =?us-ascii?Q?Q1lUiWzF103JuPM2/juMKWUEBxB5cK2H8CduZjujSxqZDb6tKbRFCsI99VzO?=
 =?us-ascii?Q?opyEiW9Jghfof+JZ4WkMxzJfkTZkfG2BvB+drM18V0VjQCyFC5LEzHYlpbjs?=
 =?us-ascii?Q?zH4yPpU5Hh1ETT7OBphjxBRlRhgkf18e/0ICvpn50PsCJptp8ML5Gnn8nj4S?=
 =?us-ascii?Q?fVkEsHwoNZp9hQzaIb++wcuops0vK+o2NWVKcC5cO+EiUuKNPXDBEyTCJWJf?=
 =?us-ascii?Q?bPKENJqneJVVBweV/WLWmJUDBWksKKmetF7RVXVM7GIuyPFF/LcEj9INtdXX?=
 =?us-ascii?Q?w9QSIOEq6q3EPQ42RAxsFnSjloynyS+ryzyrhY9isvNs5QKq0MzFU+DAuVfm?=
 =?us-ascii?Q?vHFVFtqAdwSgdi5K6SKSGsSxSJ0AERFOh9/U4uXpRcbSq/5F+Q82QF+8KrmJ?=
 =?us-ascii?Q?9LHvMSaqlS6kE9hxs9c4JG2h5QGI6JKUUEFjcLcMx32Apzskm8h/654/0zxD?=
 =?us-ascii?Q?PPGaP+nud0XwiKg/jXjkjMN6KUkU7DWS74ydfbDy7SW+elbVJ7+ZtPHLXe97?=
 =?us-ascii?Q?A8H/n0ve0HitiIVTfkaf2vkaAmSc/gZ63Vt5PtiCUQtYtxQ4opLR1s3AFlnJ?=
 =?us-ascii?Q?jNenELSwXsvjxC72OcP+dZDe+l/Lr4LK8wupNJa2F2tqjJ3fx7XVEs+Pgixf?=
 =?us-ascii?Q?RMKphjtDNqB/rn45xYT8ty8JspfzYM07sZVGKWfM+G8PbLBvqrh3JHd5zQ1j?=
 =?us-ascii?Q?cRXLb8h+MTnYq7ryY/lZCAulmrgxSuvXzJBCysivjHY/B4kbyYqB4CGR3JLu?=
 =?us-ascii?Q?FBOKsGmzuVZu5p5lirWcnSyDf/DdmOpWIK6HvnAMNXo4l55lYyYvnMNfiiAs?=
 =?us-ascii?Q?XBsvUge+TKNiKmDi4Fg=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d900155c-4d00-4792-b08a-08dc808ba4f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2024 09:34:03.5671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j5KnexiflE/AZdsowitQkOOp1mwVtYyQsbZvUBOTEpHwIViPeCaOvdUxA0Ks7UmUhK6jA55Y2SipiwBTgkJyZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10887

Hi Sudeep,

> Subject: [PATCH V2] firmware: arm_scmi: power_control: support suspend
> command

Is this patch good for you to pick up?

Thanks,
Peng.

>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Support System suspend notification. Using a work struct to call pm_suspe=
nd.
> There is no way to pass suspend level to pm_suspend, so use MEM as of now=
.
>=20
> - The choice of S2R(MEM) by default. The userspace can configure whatever
>   default behaviour expected as S2R, if issuing suspend from userspace.
>=20
> - The userspace needs to keep the wakeup source enabled, otherwise the
>   system may never resume back.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>=20
> V2:
>  Update commit log
>  Add comment for suspend_work
>=20
>  .../firmware/arm_scmi/scmi_power_control.c    | 21 ++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/firmware/arm_scmi/scmi_power_control.c
> b/drivers/firmware/arm_scmi/scmi_power_control.c
> index 6eb7d2a4b6b1..21f467a92942 100644
> --- a/drivers/firmware/arm_scmi/scmi_power_control.c
> +++ b/drivers/firmware/arm_scmi/scmi_power_control.c
> @@ -50,6 +50,7 @@
>  #include <linux/reboot.h>
>  #include <linux/scmi_protocol.h>
>  #include <linux/slab.h>
> +#include <linux/suspend.h>
>  #include <linux/time64.h>
>  #include <linux/timer.h>
>  #include <linux/types.h>
> @@ -78,6 +79,7 @@ enum scmi_syspower_state {
>   * @reboot_nb: A notifier_block optionally used to track reboot progress
>   * @forceful_work: A worker used to trigger a forceful transition once a
>   *		   graceful has timed out.
> + * @suspend_work: A worker used to trigger system suspend
>   */
>  struct scmi_syspower_conf {
>  	struct device *dev;
> @@ -90,6 +92,7 @@ struct scmi_syspower_conf {
>  	struct notifier_block reboot_nb;
>=20
>  	struct delayed_work forceful_work;
> +	struct work_struct suspend_work;
>  };
>=20
>  #define userspace_nb_to_sconf(x)	\
> @@ -249,6 +252,9 @@ static void scmi_request_graceful_transition(struct
> scmi_syspower_conf *sc,
>  	case SCMI_SYSTEM_WARMRESET:
>  		orderly_reboot();
>  		break;
> +	case SCMI_SYSTEM_SUSPEND:
> +		schedule_work(&sc->suspend_work);
> +		break;
>  	default:
>  		break;
>  	}
> @@ -277,7 +283,8 @@ static int scmi_userspace_notifier(struct
> notifier_block *nb,
>  	struct scmi_system_power_state_notifier_report *er =3D data;
>  	struct scmi_syspower_conf *sc =3D userspace_nb_to_sconf(nb);
>=20
> -	if (er->system_state >=3D SCMI_SYSTEM_POWERUP) {
> +	if (er->system_state >=3D SCMI_SYSTEM_MAX ||
> +	    er->system_state =3D=3D SCMI_SYSTEM_POWERUP) {
>  		dev_err(sc->dev, "Ignoring unsupported system_state:
> 0x%X\n",
>  			er->system_state);
>  		return NOTIFY_DONE;
> @@ -315,6 +322,16 @@ static int scmi_userspace_notifier(struct
> notifier_block *nb,
>  	return NOTIFY_OK;
>  }
>=20
> +static void scmi_suspend_work_func(struct work_struct *work) {
> +	struct scmi_syspower_conf *sc =3D
> +		container_of(work, struct scmi_syspower_conf,
> suspend_work);
> +
> +	pm_suspend(PM_SUSPEND_MEM);
> +
> +	sc->state =3D SCMI_SYSPOWER_IDLE;
> +}
> +
>  static int scmi_syspower_probe(struct scmi_device *sdev)  {
>  	int ret;
> @@ -338,6 +355,8 @@ static int scmi_syspower_probe(struct scmi_device
> *sdev)
>  	sc->userspace_nb.notifier_call =3D &scmi_userspace_notifier;
>  	sc->dev =3D &sdev->dev;
>=20
> +	INIT_WORK(&sc->suspend_work, scmi_suspend_work_func);
> +
>  	return handle->notify_ops->devm_event_notifier_register(sdev,
>=20
> SCMI_PROTOCOL_SYSTEM,
>=20
> SCMI_EVENT_SYSTEM_POWER_STATE_NOTIFIER,
> --
> 2.37.1


