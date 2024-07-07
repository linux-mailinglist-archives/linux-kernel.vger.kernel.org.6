Return-Path: <linux-kernel+bounces-243473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B426F9296B9
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 07:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36DF91F21E5E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 05:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259DFAD27;
	Sun,  7 Jul 2024 05:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="szmImAS2"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2075.outbound.protection.outlook.com [40.92.42.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E974405;
	Sun,  7 Jul 2024 05:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720331192; cv=fail; b=UHtbcq7lZSNNl5q8QNQOYhsHO6hwmiyHktNh5nBzXFgkhDOlFwczVdOnzb9m9dSYqDWwD2ks/OjiR9oqQKLSVNIbj82cMijzBSYRyNW+aW6whDlQBroXoxFJT4SUG2/qhh/BmHQ6p9P7ukZ2z2GMft4aMnkY0ENKCMtFYVhLdMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720331192; c=relaxed/simple;
	bh=Mfz0VlzibNjGq+cShKAFMD+gBTL/+rb8Z7LtbdRhnO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=a/u9amMoQG9LO46cSGP90CdUcq0b/1jTsVBH3ZtvCkdwZZGNJxQpSKTYixa8ykQuWBxTE7gh+ZsDNcaz9y5B6qB5vHLg698W1IyXIupVMTntj/6DUw5FsZknaQ52c5N33v4jz4pUeG1GuLvpTWqsh58MRWzAUWREVv/W0l3HL90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=szmImAS2; arc=fail smtp.client-ip=40.92.42.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XA0cIOsww++TNpxJ4C/nBT2rLUtCZaNas67AIfOx+7vvSltZJmm20Ey+G0K16HxhPRRsRP6qNP5qrRmYra06eWJ17g7riBwMFyczVpM6o7LPU8y2ZiG6MUfeKFlofnYqDVsPjh9uycXRf+nQn5mObhEVb0jLjkhhxIdQv9B6zPoXUpsju82tuW8o+8qBrYzLrGf7o/AN9kmqkzCi0AMTTUtHgw6lOoim4i7q6MWQuwtIhlD8RWMpFsoqJNQH4tY61WZOzbnL6O7aM+ebKLf6Def2JqtmMQwseBVkt+cJWyzV8td1gA/KPk7EeC7iN0jt95dQ5o27vYH3IrIinUHWvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2UtE8jtel5/QsKVNiVKA87I6c0hJEKpQBDNFQ+rKSmE=;
 b=POVqvuA8mYxIN6z6zL8NLdCLL9N9DNdjTZoF2Vw3d/2giyM0M1NYdQTJx4b0eMMtozElZXtt4IyiFtCSY2CAUpF0OFHhEG1emP0iP5vQt3MwNm3hPEjRTBXeTA+BvHuvWMfGUd37eWEzSgBOUsGeX7Sf8Uj5TwJKm+HkfWFl7p/lxSrFHRXG1UJVzDDTJ6I4IkBVwb+ojWU5Srrd2J87N0Nowmk4KeUCGGo0meESHSEb1eynuuQ/htd3FfrmH4KxiAg+7EhQfqNnTsi+2zOFNFqOWIhXPHc9h+8PtWwid6uzxODPmyyA5n3Qsux2TOUS1mNiJFBIDayMFMA6DyDVxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2UtE8jtel5/QsKVNiVKA87I6c0hJEKpQBDNFQ+rKSmE=;
 b=szmImAS21cXsM63ROp/q2uEsOwAmxifPithzqRkQZkOnZOmcIKPcD6wM/kDdFQs711MEpkuzEq3hAgrJpZMQ1LHH8nSahCcIlRhYcPpLAMMi64WW0gCf3xKLNyO/es7Ilnc8ot7cIc9hHx8hpUhDyEriCwM6osiv3wpZ5g4C8KpDZa/mPL1SsfkM5UpzQCvBD6VuE8Z1L0HADwczMs6QE4rAPToHdP9aWuxfzhWiHquBFQQStSwy/tBnxjLwW41a2juhJcfk9TPxYJQxsjDdDR7W8RdGBG31nLti1VT20SL/gzEwgyoG7F1+8iUSV80RcXA2zYbDO9Fi0sMch0R6Jw==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH7PR20MB5033.namprd20.prod.outlook.com (2603:10b6:510:1f3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Sun, 7 Jul
 2024 05:46:27 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%6]) with mapi id 15.20.7741.033; Sun, 7 Jul 2024
 05:46:27 +0000
Date: Sun, 7 Jul 2024 13:45:48 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Guenter Roeck <linux@roeck-us.net>, 
	Inochi Amaoto <inochiama@outlook.com>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Jonathan Corbet <corbet@lwn.net>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: hwmon: Add Sophgo SG2042 external
 hardware monitor support
Message-ID:
 <IA1PR20MB4953D5EB014C84CEFA88E2F6BBD92@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953967EA6AF3A6EFAE6AB10BBDD2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953F58B631D836F3863115ABBDD2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <5a2e23f4-d54a-45ae-a09d-e557b110e017@roeck-us.net>
 <IA1PR20MB49539E946C2D5D025932ABEEBBD82@IA1PR20MB4953.namprd20.prod.outlook.com>
 <a0337b42-4cce-42f4-91f6-eca65c62ed47@roeck-us.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0337b42-4cce-42f4-91f6-eca65c62ed47@roeck-us.net>
X-TMN: [hQAHzaf7oXU9SwesILM49qt9pONLxAdd1mHB55QBFSY=]
X-ClientProxiedBy: SI2PR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:4:197::14) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <24oizfnefiv2ddwtkjsjphkbswpagdtvmf432gvhgzj5eqh5nh@ffcw364voaci>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH7PR20MB5033:EE_
X-MS-Office365-Filtering-Correlation-Id: 24ab824b-0e19-43ec-a430-08dc9e482496
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|461199028|19110799003|56899033|4302099013|440099028|3412199025|1602099012|1710799026;
X-Microsoft-Antispam-Message-Info:
	X5x0C/4uondLkgtVYnpklCyqQAkZooK8rFg1u2CLfWl70VYzhqV3y2yGU1yGFmol2X234p7E0RlYxdzkhWxnM9A1AUgpky40NyU9hYsgP3XcB3y9/+6p3kpP7pIKYm66f4saBKN1h4JjVMzQEGRcos1zoKZKWRBdfEeV/kZZVoDDGf7TYvVDnAyuo4QvC6draeUCI8qayI2LAZThgSIYJv8OjsSLuQ3vmJY2NZx+g25Amvjz6l82SpK36NSx05C65kKtg8+fhucvc0Dco0F8SdUPUO5fzK0x0Xe9QS/Dl4zxxrjDS3F7KbXEoED/1/nyYZKfSVisLFOnQ4XQXKa3qfyz7+o255zjonIAIU/DZK4cwuCs9VYjJ0vXZScAmBvaXd/tc97vodiR3LlbjVV0HtRnX/Y697tR017mMqCfpbkbCKDE3JaiieGKNJF+e0d5P4+o4uX7OoIRVlH+MTKvDkaRH9v9D7m5lVMh3go1pw48X39wWdYvbSrXH5UTgfiXPVJghUOsbQay1dBYoRfUBUKiN08L5KAk2KkvKJgkXinYSmZoEA+WVTJ6Sn632Kr1kxbv8af3IdbIWpp4MPAvgrxs79WW9In/VJaUTFxcX17s4lbGTQQp0vZDMgwn2+7+wYfmEtqdjDHOl5aW9/ygN7Ih4aWmzTq25LLJVl2B68Bbdf9XOYrqic3YcV7dUgBeS25baWOXiH5CQ8cm4cnD/9yB34HeeoXcGIK3ymN6HVEVUQaBtJ8jqqRhDT+9SRH7UGb7srhpKykWWX5ubqWAoBz0EUShByPrpIAGFsO6QZQ=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hQnzKS7SKKNL7IjcIKXlcybsvqNcJMPSf8h4pCbz94dfmXrMDylHQhR8IKeX?=
 =?us-ascii?Q?p0OypHfcIfWSM934RO+J4oZ3rA7fEIAYwdOTH8lyfsOzBak4uyWzO18/jgfo?=
 =?us-ascii?Q?rZ9vshpQxUXJt7Lstsv1i+V54MjTaeULJ/ZvjRrn8XaXj7Wtkqzgp3Hf0HkR?=
 =?us-ascii?Q?AbM4UfAtwZ4BdkA7vQCoz30vQVQNLX6ia2qiPzgoHdXuhvgVOyKRDIhOaiP9?=
 =?us-ascii?Q?3iSbRNICy2oxsGK3Uv52df2c3ur7bmRKa615qHdZcCsKYd9MZEhHtVB8/zQl?=
 =?us-ascii?Q?Orc2TBGE9yrQ47/RZY8n34HTqlzZiOE3ZZiTKH4XInUruOOnvDogqDArC1X+?=
 =?us-ascii?Q?P/tFmIGUlcC4fO+TOwHCyPOtcZJCAlwPylFRFsOF5fCkb6xNQMSRHFdUooP7?=
 =?us-ascii?Q?e7qBwMKWGo6I2+zzx6MI90ATQfNm1CZ/vuT7BnG5xBuDEDv+M+I7WszVmk22?=
 =?us-ascii?Q?F0aXFhuCCvvj1/CMqFbzjeviSOB2Pydev3gQ4bQbRXkVmUZSZFTTNZcrfqus?=
 =?us-ascii?Q?Sfx6ErTwcqLOA1sfdsqA0aZGesfw/BvqLSPcXLi4dBymlxCuTnqhHVFa6pmL?=
 =?us-ascii?Q?MvlXAuGShi6NaasPJIUcrj+OOZA/Soo3Wbo7adnOJ7eQ8BmiCMz81Ng7JRNr?=
 =?us-ascii?Q?DQbB+AZUnKLJpx/K2r3ZL8+xhZevB1sMt4KGHr9db75qywRmxCDWe1lFs5nR?=
 =?us-ascii?Q?GV0UtI7NFCZUWuIB9zjgX6JziwhadYMbsLoMFJENOlbhhIx9cYwy89S/OBkx?=
 =?us-ascii?Q?qb1KVTyWfjZ5CHbEdmkwYWkSwCntwrHy2Hy8sm4QSadkRSGPfy9e1vgJIJOV?=
 =?us-ascii?Q?/QLAs0slRyP3+Pnt9nLn3DsUNcyjBmmtieNjW2Utsn2Gne7Fi/Ufh+fqgn8D?=
 =?us-ascii?Q?MrgLiP05v2WrnwVT9afbK9ZV547x3VcYDeZDVDmhgvZbTXDK723OspYDYZDc?=
 =?us-ascii?Q?vpwI6yRrPkdLcxQSnYHvRkCOicfkOeRWQ3fMh9XwQL61Om9A0LihkxA2xFIz?=
 =?us-ascii?Q?d49xgQus6oLKsGnbgkB43vUlKNPnSgOtkiowTIszbOv8UAjvlKP8t8I6YmoQ?=
 =?us-ascii?Q?z8OOp5RAiDcD0WgSG445pfA1BDUpCB1as0A04SAhmp2ZVozmom8audAH6yP3?=
 =?us-ascii?Q?oQlK7nspVBiERnKqAy3QcjgoEyTeHAi2yVI3myFfXl1iSlXvHHPUP7zFhk6Q?=
 =?us-ascii?Q?TsE5pw/juLxs4cRgxqJX48Dvhhp6TsapCkPujLbY3rl/8M+LPeZP4Esv9Rqs?=
 =?us-ascii?Q?Bi5h0fKeMyjkMPgqrknN?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24ab824b-0e19-43ec-a430-08dc9e482496
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2024 05:46:27.5405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR20MB5033

On Sat, Jul 06, 2024 at 06:35:35PM GMT, Guenter Roeck wrote:
> On 7/6/24 16:34, Inochi Amaoto wrote:
> > On Sat, Jul 06, 2024 at 09:48:58AM GMT, Guenter Roeck wrote:
> > > On Wed, Jul 03, 2024 at 10:30:43AM +0800, Inochi Amaoto wrote:
> > > > Due to the design, Sophgo SG2042 use an external MCU to provide
> > > > hardware information, thermal information and reset control.
> > > > 
> > > > Add bindings for this monitor device.
> > > > 
> > > > Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> > > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > > > ---
> > > >   .../hwmon/sophgo,sg2042-hwmon-mcu.yaml        | 43 +++++++++++++++++++
> > > >   1 file changed, 43 insertions(+)
> > > >   create mode 100644 Documentation/devicetree/bindings/hwmon/sophgo,sg2042-hwmon-mcu.yaml
> > > > 
> > > > --
> > > > 2.45.2
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/hwmon/sophgo,sg2042-hwmon-mcu.yaml b/Documentation/devicetree/bindings/hwmon/sophgo,sg2042-hwmon-mcu.yaml
> > > > new file mode 100644
> > > > index 000000000000..f0667ac41d75
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/hwmon/sophgo,sg2042-hwmon-mcu.yaml
> > > > @@ -0,0 +1,43 @@
> > > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/hwmon/sophgo,sg2042-hwmon-mcu.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Sophgo SG2042 onboard MCU support
> > > > +
> > > > +maintainers:
> > > > +  - Inochi Amaoto <inochiama@outlook.com>
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    const: sophgo,sg2042-hwmon-mcu
> > > 
> > > According to the other patch, this actually covers four
> > > distinct models/devices.
> > > 
> > > static const struct sg2042_mcu_board_data[] = {
> > > > +	{
> > > > +		.id = 0x80,
> > > > +		.name = "SG2042 evb x8",
> > > > +	},
> > > > +	{
> > > > +		.id = 0x81,
> > > > +		.name = "SG2042R evb",
> > > > +	},
> > > > +	{
> > > > +		.id = 0x83,
> > > > +		.name = "SG2042 evb x4",
> > > > +	},
> > > > +	{
> > > > +		.id = 0x90,
> > > > +		.name = "Milk-V Pioneer",
> > > > +	},
> > > > +};
> > > > +
> > > 
> > > Is it really appropriate to use a single compatible property for all of those ?
> > > 
> > > Guenter
> > 
> > These board can only be detected at running time (even this should on
> > a specific board). On real world, it can only sees a MCU onboard.
> > I don't think it is a good idea to add some bindings to cover these
> > model. It seems better to remove this array and let userspace to parse
> > these ids.
> > 
> 
> Isn't that what devicetree is for ? It should either not be necessary
> to distinguish the models because they all behave the same and all of them
> are happy with the same compatible property, or there is some difference
> which should be reflected in devicetree. In other words, either they
> are all compatible with sophgo,sg2042-hwmon-mcu, and sg2042_mcu_board_data
> as well as sg2042_mcu_check_board() are unnecessary, or they are not
> compatible and there should be separate compatible property names.
> struct of_device_data does have a .data pointer for a reason, after all.
> 
> In yet other words, it seems odd to have a devicetree file for Milk-V Pioneer
> and then to check in the hwmon driver if this is _really_ a Milk-V Pioneer
> and bail out if it isn't. And I _really_ don't want to deal with continuous
> driver patches whenever one of the systems using one of those MCUs starts
> shipping a new firmware version or is deployed on a new board variant.
> 
> Thanks,
> Guenter
> 

When I firstly added this compatible, I want to match all boards with this
SoC. This is why I add compatiable like "sg2042-xxx". In driver, I tested
the id of the MCU to ensure it is sg2042 (although the id can used to detect
board). And this is why I said that I was not sure it is better to add board
specific compatible.

I know you concern about continuous patches about new board or new firmware
version. I was told the MCU use almost the same register layout to provide
necessary information about its SoC. So is it better to remove the id check
and let the dts write to decide?

Regards,
Inochi

