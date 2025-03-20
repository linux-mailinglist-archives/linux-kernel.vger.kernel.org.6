Return-Path: <linux-kernel+bounces-569863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B297A6A87A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41092465214
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C466A223327;
	Thu, 20 Mar 2025 14:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="WGTpbjxB"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2068.outbound.protection.outlook.com [40.107.20.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46F72144C9;
	Thu, 20 Mar 2025 14:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742480765; cv=fail; b=huiW6yWDXScYSb/3HIQBDCM7YiCJDLlBPMZyD4XlyELfXVl+upYysy5GefxzSHBbU5gCx5z6y1Xe8mznX6XIxGKbB4HcwLC/SyM7V2lyGvDCVKBu1f8SnP78/MBIpS7MUT9e4VRaSRFKOrY5mluBmBvaJRrzdl26R4DpoGp1HdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742480765; c=relaxed/simple;
	bh=XyDQVvRLvZpASz8JslB/qtHOMtIK2I+7hb58jb07Dj0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=FbsjJSSt7LmEd0kbqar8ElsstmrOXInrNUmJcjkydVmUd6Ui4MIR4njpiETrw8kNcpBJq98R2xO1mu+R9x9pDbGs7Pt4qSkJEzeQiHFAyaxYrDjtD0fFSPzDKw/p+X+cHyPlhb3GZR0w8bVd2LWYxGgO8jDycPzaKLG4dAwHr+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=WGTpbjxB; arc=fail smtp.client-ip=40.107.20.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JCnPHqaG8H7AlsTgKoSoQpBKTCm1y8+kumlE55JXpph7ikhD2N7ADzSmTVldO9mGB3Qo2FnSCJcvIGTfqLoO1tlWslCHZO1UdrV79/VjkxJwU64OEWGjhMtiZTp1gibzSyYS6JE811237xwK3t/tutGTTFesdFJZ0R5rnmZvy8DmjoAa+be69VS42UFJlNtcjof4yZK1ZeoEad9cPm0yaXEYbcb4eHmJ6NrZCG6pFXjtsopICbotKcQkJD4KD7Lg2IPVMBbdCiftr4RipQi0C2a7MUG/4dNhtuhD0YWhFFivFwrRqExijy7e+timZRB1SWShArAUO6YJE8MyM+pY0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XzfUlR7QH3PMZWk8Wox1qnw9bmtHU/NnkyjAbK7rZBc=;
 b=HHjzlXrELxGJUhCoCmh3Tjmzgu/8RZArpOzqARG43v6PAslCt0VYghOtfibT/qHeQSUTNrc50L/+gptb0r+3bjzXyM+xw7GPUpE042OM8vg4/qNNfTmWhCuu/U47mKdhuplF2SXxyxGGk0TOQMMyk2o1jTTXXtsLp+tRwEGq1Gec3ZuIE7dGudm9kqe/cklU9NHMw4TxzZg1DeY2xvjpFAltIVKrB5oGtfb2+3hv3PTuzfGX1vRVcHuU5oX74PobhIZlC8th+ICSn4F+ErDVptQexQU86ZMa+qnRrBEPB4oojDkOLLJ4iUWnnYVwj5W7Xup/DqOQ2fqaIekWqwDO+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XzfUlR7QH3PMZWk8Wox1qnw9bmtHU/NnkyjAbK7rZBc=;
 b=WGTpbjxBIV599EM9CruGieIGBoGjkCrLhRfML152xMdI70yVVxBgkETCn0BDB3m5lYMd9rjV3suqlO0GNpSYN2bu7+uiLtqlsXKPJ6Z22MLSezchNmolu4VvQ8hvf6wNAUYd3O+cshgecxH/iGHNC/eAVdl/X4NiIRaktaZbfH4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41::17)
 by AS4PR10MB5599.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 14:25:55 +0000
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4]) by DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4%5]) with mapi id 15.20.8534.031; Thu, 20 Mar 2025
 14:25:54 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Colin Foster <colin.foster@in-advantage.com>,
  devicetree@vger.kernel.org,  Felix Blix Everberg <felix.blix@prevas.dk>,
  Lee Jones <lee@kernel.org>,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] dt-bindings: mfd: ocelot: mention MDIO management
 and add example
In-Reply-To: <174239067901.1581865.12024894776786719202.robh@kernel.org> (Rob
	Herring's message of "Wed, 19 Mar 2025 08:24:39 -0500")
References: <20250319123058.452202-1-ravi@prevas.dk>
	<20250319123058.452202-9-ravi@prevas.dk>
	<174239067901.1581865.12024894776786719202.robh@kernel.org>
Date: Thu, 20 Mar 2025 15:25:53 +0100
Message-ID: <87r02rsrri.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0051.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::35) To DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:41::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR10MB2475:EE_|AS4PR10MB5599:EE_
X-MS-Office365-Filtering-Correlation-Id: 91fc9efd-2f61-49be-d198-08dd67bb1fc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jZ/D9QkYUKzSn6Rrj3a4MKm7FYyLWVXvSTaE9gkXxkXMF6larYkTXxpnf8eR?=
 =?us-ascii?Q?/k6A0l7JZV+GI8N+RSKeXo5sAUZO9ST3ZJQdDn4l/NvIK4VV/AzL5ZJDKBVS?=
 =?us-ascii?Q?IRXVpds+gZP401LeoQ4HWWTD54czfUmM2S6LJQH2JOsaJoUlgOEF45Lq/HXd?=
 =?us-ascii?Q?jflwvlE+6BQeoyI29JvJ6OnjHeaGHeySCs5XG9hf1ZOuaq4/2MtSrRk41rgu?=
 =?us-ascii?Q?9+09zL1xW5kPWY3y5vPEKcvyk4ssq3nPydIuEcckFXvyv7Vat0KIGjLTavY2?=
 =?us-ascii?Q?SapbZ18gRIU3f5v5rGSGrc5kaVdktR/ZQXqkp5mqyYyuA7Mn+gmVcm0HsmX7?=
 =?us-ascii?Q?xQ18lnDCMhtE5uU1W+ioQjW0MueAhY12acC4AF3GIJso7GW0/Baqq4OTHMsR?=
 =?us-ascii?Q?Uwzu8FP9LQ9UguX622KUxqu/1i969Aj8o1l+X/hLoVMH2n+lZ7yMP3uFlHY0?=
 =?us-ascii?Q?jVIC2/GD8yetfi7Vr8HmLxnJWM5Z3hiv/rkrTD3DkPUFmxtNdjXxoA7UsOqx?=
 =?us-ascii?Q?NM7o+TFjKEPRXVli1zShC/if/XMdhAKIgPTlmXTb3JbGppMvaa6h8b/MQ9jB?=
 =?us-ascii?Q?jujjsEchiE+P0XCdneN/qpG5DFFsVqZ7XGOqzar7Dz0TTA8ciSosyUs/fZgs?=
 =?us-ascii?Q?0esqQr/8I8aqOlk+KsC81E7QporLFVVTmGy9nh57Gk0Tfz7K1bfJcZzWhKFR?=
 =?us-ascii?Q?h2Ee/O4/OgzuKPF4xig4D5A1Y1VnNKc3uaQyIw0mBKi+/WxdBbO95p+0hwmO?=
 =?us-ascii?Q?DttBqnURRFpjcILy8ci5HD1kG38EJNOuNYQZZaCaB9+DNuO7RmycdaoU1SgJ?=
 =?us-ascii?Q?ia/Y2TU2CnB7HtZVc3y0PlbcmP3QFVb75gH6QoGJs37lZ8qXTII7o2zZySks?=
 =?us-ascii?Q?vyWjg7Cpj8FptPy+WdGT2k5JwKyILGMdQsBo0GTklCnAZxbuWMGkJdLabMRr?=
 =?us-ascii?Q?HlAZ0ycOdovuC9bSAiGOHAuOKvnBBzK5ZSq06m2rqOfeAHSYXYydeY18Ck81?=
 =?us-ascii?Q?q9keT7HguaIQ0dM5qokPy+6+/Yj1BAmLiIlDEmkVFci6+nbRovlFdc2tWCGq?=
 =?us-ascii?Q?zLlrbPEWaC8TVEad48W3yg73nbHmPaUPO8kk3GIUA9aZ0ByTv/r8kQZv1dNy?=
 =?us-ascii?Q?C73JZRcUW/qXPXwS4PpXol3tk2sUiBUQRq2Fd6HtU8jlhBaxqzo9MHUb2SEy?=
 =?us-ascii?Q?1dsBeJP9s9o8t9ODhaWbR4bbBlGIRcUMkjJ76ikaTGQIAhE1WCaJDmghNQ76?=
 =?us-ascii?Q?/AF4jBNqstQjs5nG+GoYNiHWRFJ0UwsikCPF8CWk2JnkVCmKSDI9t5tOadjQ?=
 =?us-ascii?Q?1ZcYQ5SPr5rMMAoA1iEwrfK3bL4iVa2ioMrfXyX4orcs9ZJ+rImJD+bzYHCe?=
 =?us-ascii?Q?ha3mAHQnTUi7VS6Ez+pdGVjw4r2aOLf+iyO+FPRQz+bgVN8NYA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JCjYqW4WPp1FXiNM+quGUmtle5YO9BGCpDIlEivtZMZ6udW7dtrf9Q54Jpj2?=
 =?us-ascii?Q?aTnxlsEjGfKrxXGPulFR5SXkOqsXlh0RWHIpmsp71HL28Z8+Fq4wg6xHoSQe?=
 =?us-ascii?Q?HiFAhKsn3GcFsy/71uN2/QhAP1mSZ3lZCyLIfeO0csJ7O9s/gSD2/1eaI3Pa?=
 =?us-ascii?Q?//EAxXKLzCGYFaOlMxi/dTzFm+H9zL+jmAx31uEts/sIdvQoS0OV5fKdR0cx?=
 =?us-ascii?Q?E51+Qz1FY2V+QC+yaMuNMok3N8t2umN8SeA6x8XOK8Qp1W3PN2ZMFgXQ/iYp?=
 =?us-ascii?Q?UlhbQdeCPoodlnFhhHVqPPG7nGXSGdTqI6ZzlS+sq29hSyqjKHK7LRNwBhxm?=
 =?us-ascii?Q?NRlBiYWGyTnHBGrIOufFM0Oma/uqpr8L6bD/iimJO/269Zhir6yz8PZ6W/9B?=
 =?us-ascii?Q?a8BNCNwWBe/K4ID7xIrb2BzWs+tNlD6gbR6RW1rNYofzIbsdpnO9yR8OKpRe?=
 =?us-ascii?Q?rb0KiNdrnu3w5wpFxOiYimasgsACquUDALiVpzCgAsaUFVlFJ1tgtzgsaKD0?=
 =?us-ascii?Q?Qv7CoNV0WtrO3E7K3DQff7MzQhgzSrDDoNS6h6wIsk6er0xWwXhxeP3P027d?=
 =?us-ascii?Q?4zt1pxn/pACSFuw19JLd3EkJz3Q+32e+BejWNIiPUgTGJIh37RUf4Kqdj8g0?=
 =?us-ascii?Q?qwpnsPPptU9omD7SCB8tebjBrQgRA8+8Dv+Wv9S03kgHI9KONzaJE3rhooAK?=
 =?us-ascii?Q?T83/CijJmF3ElHNKLHwcVlmA4QHfQKLSLHrlvJxxhwu/ygg1MkLoI0zpED+L?=
 =?us-ascii?Q?ZGZTFSyEheXVhbM0+z6a2GuiQVgo+ALxntw44mRa0EfZIAi1S4DCyYlK5sJy?=
 =?us-ascii?Q?zgN3QcfU206yeO6JZSxlJ5SJyPES037Shf0e/AtKR+GmX5XfVU6AIz9WaLJL?=
 =?us-ascii?Q?4qyze+bcvysyVCDnVcbwtWTuG1yiXfM9P9XrPClyvHVrbJerQAfVjR8nWq7/?=
 =?us-ascii?Q?AXhrNuMnP/IsihZIOmk0OJNxsDpC0ck952lXc2aFxDlqvONxher9bPZAV1Vk?=
 =?us-ascii?Q?Fyp0KlHhtzyouRHuOOK0TfqgHnEwHWoXu8c8mxbifGiJHSNCcoVSHhiTDeHr?=
 =?us-ascii?Q?dIjnqtGcN1GoGs0oFmTSGRQN6vg84READmNOG7p6SdiHoNqr3H5lmc8w28Db?=
 =?us-ascii?Q?LLzhZNgfN4ORIx7UyM9kokYH5+LwgwPlhMbZTV5lK+Lhl3u6SRsM3SUgIthN?=
 =?us-ascii?Q?bqntk8MPgDRV1DAQlfWPm1pkm7ed347aIgPFYl2qT5Ciy24mZ9vuf7EJCLa1?=
 =?us-ascii?Q?5D9gkSINPlrJZQAPb5JNls6fjM/ZRRRCt00KYjXM6V8WLjZ+RgpBDbS6Ci5s?=
 =?us-ascii?Q?N6BXl2jShBKBXs5QZe7Q/+Hjueirx92D1oLCPX1r02a59iX7ipnxA4FzPE9G?=
 =?us-ascii?Q?U8BhMmPF+jOGU+SFrJL+2x9xtrAzLMQXHYAAhyKaXJcUOXEc2pVnGwsEvCno?=
 =?us-ascii?Q?FLarKTTQEE6XAKDI2dt6nWWHQNdLkPaLpaQLnmxlko7J53aPM/nBF9j0CMl7?=
 =?us-ascii?Q?xM5I5+nQA9C/cmecsG53QdKiW5T0uBpSxkDQ625b21REtxOj2GLhQv+fsJ5O?=
 =?us-ascii?Q?ruKRvKdKg3VptoysvLlpsarfW1JgsHuE45W+Zg6lWenojSZRI2JtcKchl+7h?=
 =?us-ascii?Q?7Q=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 91fc9efd-2f61-49be-d198-08dd67bb1fc6
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 14:25:54.8673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wkZ+cYviPM0Xwv0HS+NgZVDsmReP8EQFV5wWkWBpxileKtBRizo0XwMnoqDRyKQ+i9uE9U7eno6m81kosN2gkYMFRdBCGeH7xlyW9rsuavc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5599

On Wed, Mar 19 2025, "Rob Herring (Arm)" <robh@kernel.org> wrote:

> On Wed, 19 Mar 2025 13:30:58 +0100, Rasmus Villemoes wrote:
>> The ocelot switches can also be strapped so that they can be
>> controlled via an MDIO bus (on either address 0 or 31). Mention that
>> and add an example.
>> 
>> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
>> ---
>>  .../devicetree/bindings/mfd/mscc,ocelot.yaml  | 121 +++++++++++++++++-
>>  1 file changed, 119 insertions(+), 2 deletions(-)
>> 
>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/mfd/mscc,ocelot.example.dtb: soc@0: ethernet-switch@71010000:ethernet-ports:port@a: 'phy-mode' is a required property
> 	from schema $id:
> http://devicetree.org/schemas/mfd/mscc,ocelot.yaml#

So I thought phy-mode and phy-connection-type were interchangeable, but
apparently not wrt. dt bindings. I also see that I wasn't even
consistent (I used phy-mode for the user ports), so that one is easy to
fix.

> Documentation/devicetree/bindings/mfd/mscc,ocelot.example.dtb:
> soc@0: ethernet-switch@71010000:ethernet-ports:port@a: Unevaluated
> properties are not allowed ('phys' was unexpected)
> 	from schema $id:
> http://devicetree.org/schemas/mfd/mscc,ocelot.yaml#


Well, I do need to specify that phys property for the cpu-facing port,
so I'm gonna need some help to extend the schema to allow that. The
definition of what is allowed here isn't in the mscc,vsc7514-switch.yaml
file itself but is "inherited" through several levels of $ref, but I
don't think it would be appropriate to add to dsa-port.yaml as this is
somewhat special to this switch.

> Documentation/devicetree/bindings/mfd/mscc,ocelot.example.dtb:
> soc@0: 'serdes@710d0000' does not match any of the regexes:
> '^ethernet-switch@[0-9a-f]+$', '^gpio@[0-9a-f]+$', '^mdio@[0-9a-f]+$',
> '^pinctrl@[0-9a-f]+$', 'pinctrl-[0-9]+'

Hm. I have probably cheated somewhat, but I think there are a few things
that need fixing here.

First, I think the existing binding should allow for a "syscon" subnode,
which in turn can then contain that serdes subnode (see
arch/mips/boot/dts/mscc/ocelot.dtsi). But when I then put my serdes node
inside that new mscc,ocelot-hsio node, I think the MFD driver is going
to warn, because that expects a subnode with the mscc,vsc7514-serdes
compatible. So that should be updated to expect a mscc,ocelot-hsio
subnode, and the naming changed s/serdes/hsio/. I'll have to test this
first, to see if the various drivers still find the regmap(s) they need.

Rasmus

