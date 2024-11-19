Return-Path: <linux-kernel+bounces-414885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 198B49D2ED8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 20:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4C68B27247
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 19:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488651D1514;
	Tue, 19 Nov 2024 19:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="W5vKKx33"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2080.outbound.protection.outlook.com [40.107.105.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5CE1422C7
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 19:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732044625; cv=fail; b=stLwJJdZGiuUEZfyIRQ6TwTA17Z7QVbABMGHcaZhh53X94A7udqE8PWvPIyOrnbqrEFPiHNh3ufNqaebPulkindR9mWy+BXAbTvfsBqzYny7a1/RnFxAeESUcWJDe/yupVEoTDXdXSwkEoPnXqOp0JYcWNSfv1ElPhiNW1NB59M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732044625; c=relaxed/simple;
	bh=Q71L/GWAV+vWpIjRsXp5bFIXJCs8M18+1mjzPgS3yU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H0UEqHuOOd64C3lIwsmnhyQYQpzBVwNsYa8aUO1r7OtJLwoEXbrrCq/5Zl4/9En/apgu63Yax4453NXheoz/PL865mhYznyb0gl8XUzyd20o9eNnRI6sJUQ6sAgdTgUHZ16R0SU8WEM8vh9MPoZ5svwfhteSfO3OoCfCOLeQndE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=W5vKKx33; arc=fail smtp.client-ip=40.107.105.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jwTHg0MbBSHAjNbhOHFjxRDlFAtkRnyOifHQGtER1rzCcHlgl/oGYK/w52NXduoBc5dpDbZBxpyKaEuEfiFs9+rMCilwKHmCHqqRu2isSQrDBZHZX1hF8PlRak3RhUI2df195+UyYsdMXc4FX8TfPjiMwf9N4ERnNyn60xxDWf4g+t9tPixoSZnZU6u1oTPL2g65fHag1rcbnOF0XmGRahQda4zR1oaei7hkULMEicaK9Kn4og1L+XGRmMomviFxnkGc+JtVWX+dzr9oThXbNNG5l+ZJ+Rgf33NJ2VOAOS9NSF3+3HWLIoz+yyZhu9Xmn1Hrd+ldt0GufvdAUlMwhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UvMSMLp4EVpBix5+ycQU/FIbcbr5UgZV9sPzuRTeaE=;
 b=xQ/aD8R54ZRu2BsMDGo9FyNbZOxSBZx1VOOjnyVTyr8FDbLiBe3LhfM1naGysnGFEnUZfhJqbZG7rXMYV84WvMV5rkYXn/GdAI8JoZ1yh8jww0J3qcpGAZRzr5wcygYPok6W9s4gAn1eD/uqYwI53xqHb3cf/F+EyeQ7xClbngGuczKBvZ9dkVFvZW6YFImCsdVt7jQUndrfiPMRVMbkC8BG7mXckoCFID9moweEk+PdBNZ0Zm8YtaLYJZXhapfN3uBs/sWE/b11/R/IsDTVZnpKYsY+b3Qr/+FKuAEPFeBwhHos+SSohAx5QmK1IxvZiFTewsEJiOvNndU9KUUAHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UvMSMLp4EVpBix5+ycQU/FIbcbr5UgZV9sPzuRTeaE=;
 b=W5vKKx33Bw6ATHC4xmkZJ7+5RFXmq4rOCOWH6R2O1O3I0z0ygdu96XfAC947vz8U8v4WlrkXKQSGMSVJQTxtxqBAEPKw/hS2iGZ7m2lEswNj3rCtFsyGYDUqLFWyq68g3jHb2XoGAw7WUMDC1852pxCwfFlziVWEFIngZptiMNJyrarjMyFqPjRUi63qgN+XkEr0E0hxxH4JjL1YYe7bNyjpCmI8jzAvTw+LS10HooPlFCDqKIygheMzDQGi0oGHuQ1I6DujurQuDx4BQWU03ycI85dbDyPRLLPB08D1Q3tQ3u/iU5PWEVw7ccLdPsVM983w/x89lx95zUgJyD96Gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB8PR04MB6778.eurprd04.prod.outlook.com (2603:10a6:10:111::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 19:30:19 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8158.021; Tue, 19 Nov 2024
 19:30:18 +0000
Date: Tue, 19 Nov 2024 14:30:10 -0500
From: Frank Li <Frank.li@nxp.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Mark Brown <broonie@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: regmap I3C support
Message-ID: <ZzznQknCF7VVHyDK@lizhi-Precision-Tower-5810>
References: <ZzSxKctLlLZexdF5@finisterre.sirena.org.uk>
 <feda265f-f7ba-4017-a08d-b35916aafe96@roeck-us.net>
 <ZzS6ph8KulEITt5C@finisterre.sirena.org.uk>
 <88f34137-b215-4bee-b117-3ff00402ba6c@roeck-us.net>
 <ZzXfmonkRB-KaBhi@finisterre.sirena.org.uk>
 <85584c2e-2c45-4ec4-89a0-111fa5ad1080@roeck-us.net>
 <ZzYyu4ptPtYT6vJC@finisterre.sirena.org.uk>
 <f904ed54-da90-4746-8230-0ae5dd0ca276@roeck-us.net>
 <49526254-546e-41e8-afb1-14aadeaa391b@sirena.org.uk>
 <dd02b307-f8e9-4b5d-9a4d-d429c0dff051@roeck-us.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd02b307-f8e9-4b5d-9a4d-d429c0dff051@roeck-us.net>
X-ClientProxiedBy: BY5PR17CA0072.namprd17.prod.outlook.com
 (2603:10b6:a03:167::49) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB8PR04MB6778:EE_
X-MS-Office365-Filtering-Correlation-Id: 694fa384-e2a0-43f6-8e1a-08dd08d09a12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YSUjRAeg5zmfi/v46FXovsPnkhLd/Qk6dvSjnmOq5mwkEGBrPdocTHRbDOrE?=
 =?us-ascii?Q?/7YQTXbgzGEi1Lrn+Wn+QFZNlIEk7hq0O9ZdhiuccgRYK4sdRZezWBVhPolM?=
 =?us-ascii?Q?3EAuZFvgEY6GCEtPPpoYT1x7wP87MuUFOqkWQJDRA/BRdHr+4BAHjWQZrE39?=
 =?us-ascii?Q?KQYZLNtoGDEtyeShsIkpEeVfBHQpfsZBvjDUG/de6yaqFkLXbKJNQwhbgUBd?=
 =?us-ascii?Q?Na1ccQuQ2XmOO2Lg8gD6Ax9Gh85xbGOxeY55IefG9GPVwqOd0mfhS4CekBbI?=
 =?us-ascii?Q?amU4MNYx24GQklQEB3ozWeSuhFp8ObCNAfvOGv97b0oak1aODI0bSqijPZcp?=
 =?us-ascii?Q?mnJmFNS8ubSdDdD2/Cthj5xoyXQ0JXBN2UfXBkuUNcgZU7t2rLW6KdYToJtk?=
 =?us-ascii?Q?2pNw7wgx2ivCUFatmsmlIJdmO90/seaqM9kzUX7EstaUaRxfTH0kzdnAszqN?=
 =?us-ascii?Q?Q+3xI6J9iEb0lARhiJCaUF+eJgjmljy50WRs65VAYMfsAyqSAyhwmlA7YzNE?=
 =?us-ascii?Q?Y0ZYde1aLIQpeKncBEdHZdntgJDlzpplzBx79ExupdlNb8Rh1WK79kNWFMU3?=
 =?us-ascii?Q?zUz6r9eCfkd1W74MMGsqW03oeA+S6WKDzN2oNEt7lHK+kugtj6+Gtw4UuttO?=
 =?us-ascii?Q?VzRotyc5oz78doyb0ebdj6jWIhLiVxaEzIFdS5RMbeUJBhr2gWb0HfsXmX93?=
 =?us-ascii?Q?RZrhgKv+cE12r11hN5FF40n4yzlzvvSTsTULjs/mWFmwznIJSr3fbQo5lFGZ?=
 =?us-ascii?Q?VP2GYiihVFnAOPEeiQ8HCVaJaE6fo7i/QZOCQteFh/ixj9FKS6Gh6+PjnU86?=
 =?us-ascii?Q?FPxR9R6Cmm62x8llBvBvxX6OOUyMozfgIysB37PLQh5OAQ11x5F4GPZJzJxW?=
 =?us-ascii?Q?QVsi6Aca28iLwiU0oKxlMmX09PuY0MvfB+G4GFHp7cofx4OD9L77kdjVQpTR?=
 =?us-ascii?Q?moEypKTTlclPdl0vVzPGRTidxH4usFKPWhPWM77t4dLTE4zaUAlmNAz5/MPL?=
 =?us-ascii?Q?U71DF53/74qaMxheoxHAFgthmbVuHL4TH86GozgWWVZFxWPynei8kmzs/6zr?=
 =?us-ascii?Q?UoJlHzU6usuPFEQhl5A9J3GRQKSIplKR5KBH8XzifmpEQ8gKr+M2dU1gQTcs?=
 =?us-ascii?Q?ZpRnlbD8TodBpYJ7PgG5UajITF1ma9qDX00mUptpzJCFj56ereGQkBgcmAKS?=
 =?us-ascii?Q?crllhgUbmSqr+oF1tCJQ1FEIrhDYNyhQLseqYoNkek9LSla6HEa92NZSNhrj?=
 =?us-ascii?Q?Gg0t2TBN3rNCOT51yaEKc7dBhauQv7q79n6v72Qqh/quEl+YsSBZkOcEJ2k3?=
 =?us-ascii?Q?Ls/lePXD2w7Guo/E8KAseXha3myVwq2byNMvqlnrMHoriuwzlrqmafPlGuGx?=
 =?us-ascii?Q?jpLZRig159xrXtm5AYQYA7mAyBZG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UkHjN/3ltcViDgXQXFmBMZ5Vz/9wr+wCP2VAFvz61siSpveAk/m3fqOmn9yK?=
 =?us-ascii?Q?dr3KqeJRHCIqHV5fWzBWDN9qIr02xZ8ml+78UbxHw2tTayjsP2hGZ6578yz9?=
 =?us-ascii?Q?Sq/oMnHWTCoA6/jp/zJg9eZDdwqT7E3Zcn9n4yKjcD8EfiPzNVh0V6foIL3n?=
 =?us-ascii?Q?SDNOxi5GzoF+qUuMhcnfnwSTk66Sjt4DzqysS0aJPGRiXvVr8ncfOE30tc9Y?=
 =?us-ascii?Q?VdYiZ4q4cSXh8KIvyYep8Tu6IqHbY1bslReXoUCD4SPhLDFvJ/LqNidiSyDX?=
 =?us-ascii?Q?tlHFZwsTKDoHRjtLzymmEKJz9IKp40MxHChbde1KOzcyc992LU2rnNpJj3f5?=
 =?us-ascii?Q?5XVtlcKJQQgkYiGfqdadzYhI5dfVbsEEv1TIhBQt61ba7dpQ00CkaaaL0tv4?=
 =?us-ascii?Q?Hikj5tAFUDwi4wv7XtzFJEuZr6bf3PndlvHZjBPBNztVm+3lLBXyVBEVfFgU?=
 =?us-ascii?Q?VIvwl1/CdhikRqTqJ6o+lbI4XDUZ10a6A5TggF7SHlT5VuIYQ3mzZSiFeGyN?=
 =?us-ascii?Q?pe/Ukd7lCwAhCEVvai4hJgGgC5GqLM4oHNnO7FLQgT4kfuO47/Mh7YLiClvj?=
 =?us-ascii?Q?ln0cauRnwgPF8D3YnHQ6njB757F6hcoIANwUXjB3GL7HhQ4JnX8XAOwBileb?=
 =?us-ascii?Q?df/PNdHhYP0jxIFXh2AIm1/6+5iDM7VoX95pcOnP+VZ0hJFVj2PVDIdgV5QI?=
 =?us-ascii?Q?iu5bgcM2jU4Ja/1iNlubWNLXEJCFzoxf3pcfLOeLR4FvT4lKCOH7IZCL9zeZ?=
 =?us-ascii?Q?lc8LXlO6ZHaENpHSr+N9ziyun9DqS/SmIWZ3qwUNo+HlVZee+GbTUtX0d22V?=
 =?us-ascii?Q?PSVrDzdiOWCp+XzIZWpUkqyLqUIBUmeqW2my68/DjIRCijQ16tjOz6QAaWfu?=
 =?us-ascii?Q?6ay6LdSL47VnAkBo3UrkXzkRUsiZgR1iGFDZoEURcGyp15/mAsSrj/KiPnnJ?=
 =?us-ascii?Q?qanJYNMG2emaSL69lYGaFwcheOTam2Mck8rT/dY8kqIurZgneaMKGhIz0Y6C?=
 =?us-ascii?Q?cdSZ0mpm/t6io0IX+2g4JK8Ch5zJXxxLnok8duqRQ52QPLTQR0DswNSZE/hu?=
 =?us-ascii?Q?eqAvgCSMN7tgh0U334dXRBKkZNmHl+xRFfDpyCJXWE7sglkl+/PSj5Qvum2n?=
 =?us-ascii?Q?Exgf0+R40mZujpRWjK1u+tXjJ/2ziWsrzSN4ce1PfsAwMhSeNh5bNQrQ1zH1?=
 =?us-ascii?Q?P2ucyfUKE85DjrktGoi4EYakXxSoDgRUgWzU8XnX5cZf8tn0O80IRs1FIY1X?=
 =?us-ascii?Q?30G1ieUWVeHcqBMmaMD3ztIcLeNXwOLMWHg+EGXhWQBE8Xb/hIernb3DUy4M?=
 =?us-ascii?Q?+dVt7e4ztpWIa0ZFL/VeR61mhQ43qRJI3w71BVW/QtBhZvn0PvaImaXZolep?=
 =?us-ascii?Q?UAmhrJa96nv+o9HqPDHvdRWlpLcSTw73ZJhhm4CmxsT1kz0PX90a8+dwd2vG?=
 =?us-ascii?Q?TcfsVNAzS01qnG+mVOXkuYz7TD/eT24+02PIUnf9Mc/15kvQw3XhMjCIAceV?=
 =?us-ascii?Q?Z4zi+fK/g+GpWjlAEqKjsN20fMbS2ro8/hDa+MonEPU1gR4PlKGzmUQNaiTI?=
 =?us-ascii?Q?pTZLFwK0tX6IC//mrruwEDp1/qmmjdIgLcmQsu4w?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 694fa384-e2a0-43f6-8e1a-08dd08d09a12
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 19:30:18.8946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hquNQg1Tvy9RrjsDezfyNLOPUPVVRt8ruNTJxYvNmbh5Z3W/5PEPVm13jcbpGAnPCPNbftYyDL1/7Rd3LzPtGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6778

On Tue, Nov 19, 2024 at 10:41:05AM -0800, Guenter Roeck wrote:
> On 11/19/24 09:46, Mark Brown wrote:
> > On Fri, Nov 15, 2024 at 08:35:04PM -0800, Guenter Roeck wrote:
> > > On 11/14/24 09:26, Mark Brown wrote:
> >
> > > > Right, so the fact that I3C depends on I2C deals with a lot of the
> > > > problems that plague the I2C/SPI combination.  Ugh.  I guess the helper
> > > > should be OK and there's not much doing for I2C/SPI.
> >
> > > It looks like we can use
> >
> > >         if (IS_ENABLED(CONFIG_REGMAP_I3C)) {
> > >                 regmap = devm_regmap_init_i3c(i3cdev, &tmp108_regmap_config);
> > >                 if (IS_ERR(regmap))
> > >                         return dev_err_probe(dev, PTR_ERR(regmap),
> > >                                              "Failed to register i3c regmap\n");
> > > 		...
> > > 	}
> >
> > > even if a stub function is not available as long as there is an external
> > > declaration.
> >
> > > I don't really like it, but it turns out that this kind of code is already used
> > > elsewhere in the kernel. It looks like dead code elimination can now assumed
> > > to be available when building kernel code. We live and learn.
> >
> > Ah, that solves that problem then I guess?
>
>
> Yes. It actually goes a step further - the IS_ENABLED(CONFIG_REGMAP_I3C)) in the
> probe function isn't needed either because the entire i3c probe function is
> optimized away if CONFIG_I3C=n.
>
> I'll send a patch dropping the #ifdef in the tmp108 driver after the commit
> window closes.

Already tried this at v3
https://lore.kernel.org/imx/7bdd2db8-41c8-43d8-ae73-84a221d2d004@roeck-us.net/

but I am not sure if it is good on rely on the compiler. Maybe some option
like some debug option or -O0 cause problem.

Frank

>
> Thanks,
> Guenter
>

