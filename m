Return-Path: <linux-kernel+bounces-568936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 688EFA69C3F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 23:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E62528A3877
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F485221D96;
	Wed, 19 Mar 2025 22:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b="XFn6yHOu"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2139.outbound.protection.outlook.com [40.107.244.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3032C17A312;
	Wed, 19 Mar 2025 22:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742424335; cv=fail; b=FH81mAs2ChZTScswA5KnK9Ugy7HoShoxfgn1NsxMXUKNu2N1UidftUJjyTu5aCgfpLggAogsFh3qTkklu4Y/5GENkwLZ+cd1mhTP72ixmATiMOglzbj3Onnx+lHA9RjSwqK/VkJrNeSKEnRFBGcolUNa1InhlS5iV4vaIxDHx4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742424335; c=relaxed/simple;
	bh=+8d1cLugmeYtn0ZPgUAzGfF4cM8a78WaaBn9v9p1bDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Rf0Ak2+RZ9eWFMWRGZGnyhAJdcHic8ozGJsyVAj+hiLPad8YWbiPjQoQWROn06eSMzxlYNEaLTpjesBL7QYCjk+sDy/n8CELKrSQupG7bQeElxwpSfqSyrn53UQQ1aFdKzKQSLkJOJmNxte7eR71wNqtHvnqwdqpeOxGOYHVoDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com; spf=pass smtp.mailfrom=in-advantage.com; dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b=XFn6yHOu; arc=fail smtp.client-ip=40.107.244.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=in-advantage.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GA7PPX8kZBPU/CZN6j2Jgf2OVD5Kkg+BEa6HRZvp39Lhm4d1KMUSQ5IPgtDYvmpbAuc8AaQmc23C3WnayJLkyzjkROogjAdIrka3w2Xn9nbWU0NZVQhrhi9lKSQkKz4JCf/xm4dF0QTCkRAT7jAVnbYniRHLqDZ33JJzAHWyuI6j6C0TCEQtNaxhVLmgpWTLJOlr1MxUd707loFuSIvs5Oj6mjBpkp0qAPkle02uzLnzm2/9xw2C81f6SxaPgO6u8GViZ6MrCqJpH/OM4/hOXbvs5JIhV7p2plnt36JB/XM3NAid31zWnxIUia3acxiWXbHtA9g6QS5Sc0Ec0Fby9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t3mVRTByKpbLU13cM4R92qQE3X4CBHTMEBeh6a9F22I=;
 b=s6ggDKKWAzUzXZ032XxWohzMoiDOwVCefAVPMgCZg7bnytyV6ADHfEQavzlwiEYofVe6wMBz2/aRRk0zOa5IZJPr6hKQRoK7F/CADMxhNtJ+9UkW7Tb3N0IvIPVJ4DZlEbop2bAlKEu/RQ6JjVU6V5as8HaQLHu/2RlMsC4NtbM7nKqJF40QYNz0Tardtcnb5lsivWLQG7AClPLkX5R7pr63P4vdTxQib1dvEaAUaZ+jhIGt/Tm1Pvm5fm8NVP9I9dBbA+Cr9L9jvLPoVxkCVe9pfGSH6Wtonj0i2DVBQOw3XPegXIXB2Va5sKBR8RttVN+bEbqT9ES7ZwTeCcfYjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3mVRTByKpbLU13cM4R92qQE3X4CBHTMEBeh6a9F22I=;
 b=XFn6yHOuZRLvVLxSipIGXc286nLKo9DR9hKEVdVUrTMV8ubtgKMUs/jmjGyaRgO+t6anKQOJy+Zh1g74cDoEBRPsmliMwoiI5EAZGQahlBThBONnQiY/02BD9FA1+swi9GivYHMS9gMkLw2pB35SGkqybRNPCGgrab6aNavIIVA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from DS0PR10MB6974.namprd10.prod.outlook.com (2603:10b6:8:148::12)
 by DM4PR10MB6136.namprd10.prod.outlook.com (2603:10b6:8:b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 22:45:32 +0000
Received: from DS0PR10MB6974.namprd10.prod.outlook.com
 ([fe80::7603:d234:e4ab:3fea]) by DS0PR10MB6974.namprd10.prod.outlook.com
 ([fe80::7603:d234:e4ab:3fea%6]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 22:45:32 +0000
Date: Wed, 19 Mar 2025 17:45:29 -0500
From: Colin Foster <colin.foster@in-advantage.com>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Felix Blix Everberg <felix.blix@prevas.dk>
Subject: Re: [PATCH 5/8] mfd: ocelot: make ocelot_chip_init() static
Message-ID: <Z9tJCS4KCVK_EXOb@colin-ia-desktop>
References: <20250319123058.452202-1-ravi@prevas.dk>
 <20250319123058.452202-6-ravi@prevas.dk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319123058.452202-6-ravi@prevas.dk>
X-ClientProxiedBy: MN2PR17CA0021.namprd17.prod.outlook.com
 (2603:10b6:208:15e::34) To DS0PR10MB6974.namprd10.prod.outlook.com
 (2603:10b6:8:148::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6974:EE_|DM4PR10MB6136:EE_
X-MS-Office365-Filtering-Correlation-Id: f3e0ee6e-8e75-4690-cf80-08dd6737c189
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4vhShgXamtDtRXY8Wu3WtNOspb8vCmBCCxQgrzdgw/OCIzoigbK2wUBYSjfp?=
 =?us-ascii?Q?wotc07DR5Dcpxsm3CPZmqtTxt0dSlGNuw8hB8k6FVzEO7yIREvUZKCjIaWX2?=
 =?us-ascii?Q?qCe+3zZYSJ2DR8kCSMhZv8j1ZPPk9V0rul751rHFRXN3Ft5qnT0ziQuY527c?=
 =?us-ascii?Q?uhsjWzrCFfmjnssVG4UDwGRkbzC6fDBUxLRDPP/890O7dbi3rwvhiDtU2a2R?=
 =?us-ascii?Q?/NgNQ52qv4w9xdbWidSn4g6gLWw+BoddfsIuDLhQEWTbhyNbBpLqj0ZCRYkI?=
 =?us-ascii?Q?P3/UZ//dKPl+NehhDAayeijw1ozNJUXDreCmRTg5cBsY5mCrafb/GrZLlq0W?=
 =?us-ascii?Q?LSqPJNvzBnrQSE881K7GtaNGTx9oh6HHdD7VphHmZK8g7LeNnJkEMGXLmxTD?=
 =?us-ascii?Q?lxJX46NW/YT51jy8w1GEQRQAqWHgkEHvjuiMVOB35UYmOY4dNM7AlXTn3vez?=
 =?us-ascii?Q?97gpBIQj+loDIll19ZsZa6921EIl7CBcd1dzfJuUcKfG8gRg7wg0RtwPDW57?=
 =?us-ascii?Q?q3WUVXpQ6F6ZlucGJk3aPT4dm0dSiXZv9TA22DIZHCjgCyA8FGTPkTYLuiij?=
 =?us-ascii?Q?hRL9N6S3wZgs7YcDpJXam+EtNy124fWmB6GcQ0Gch748CGahfimw1XjxYZDs?=
 =?us-ascii?Q?Fmn+YBdFP8EfCc8lJvCkPpULn49YUI7q2zLrL5BknvLGi69eZb1FkybZBJoI?=
 =?us-ascii?Q?+POo0QgcvdDdDZ4WNLni//30OltmpwhwOzNJPLtE0iAxk+s5+8g1CO1zKSpz?=
 =?us-ascii?Q?gFfo5duLEHKlO0TgUbgA/4BebnokL90uMNkqiKLYGIoXzm64JnclIHjjJ6tT?=
 =?us-ascii?Q?+OWeZixhFOX24fEtabtMiXWYpCcZ4baekLe7O0JUuuvbFDXRpmkiQUV/vb0c?=
 =?us-ascii?Q?VCWyHB3RU1ZGikBTGTvSXFQ/Jm0eHXRcVW/jkMZqG5r4i87FQL1l96xk5P8c?=
 =?us-ascii?Q?qYgedq3ALOPXOjzIjbB9NeaQ/Vcghqz3sR5a1xpWA1BSiO3n5w0hArPcDIFu?=
 =?us-ascii?Q?EUglOLkfCPPryLwNMIusXD6/TT3DMV9XtMnSYjjut7Qa7AF/cnZ+EN/qy6dl?=
 =?us-ascii?Q?3QSZ/hqvmF5CdVIvelFYMaL7fk/OlyXg6LbIpN/nyTFBzmu6jzN2FHH+kbBp?=
 =?us-ascii?Q?7hxQqD7AQvCC1MurFbIATDSnArQ5252FVG99/1R8e5qsG9YvOgnm4CuZdkTk?=
 =?us-ascii?Q?7wpM6vSpQfWrawqX2kTCkMwZX5Uqr0T9POSD6dWMDxd3yv0QX2eYJveBF01r?=
 =?us-ascii?Q?miOf1S2sgAzP9tUZxkIIFhTnE3DSa0n5sRg3DyVlTxFahPbXNVkb7xPRW5A5?=
 =?us-ascii?Q?E3UjZA2ND6hrIeaV1US5Y7+ivNircGqF4ZFR5+Q99oG/eKgD9p3v4dNw3ZcT?=
 =?us-ascii?Q?osx70kfHbSL8po1Bl9JFPJQelp0C?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6974.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bKrWGOPxrxlLYG5KKLB+rbaoI3qgR4ZbtCy4NnyZ5/HP1u88YtwXZzTkK4f+?=
 =?us-ascii?Q?O10kOPEENKIBx1gJTYd6nVPYtKPVDuhXPOA8tT7zg2OphjcieGD/eoLTbIhd?=
 =?us-ascii?Q?v13eRAVhYrS5fKsiANIxl9hinnsIqVSjQsN6iCHKlUY4UEiilXaIGe/gBRv5?=
 =?us-ascii?Q?H1I5jXzs46B1JbIq55pWsVoglVEn5lryVhEd0EOZKjuYUsYDPOGm9Qg4NKFk?=
 =?us-ascii?Q?e9FpWWSC0BeKyzysjfmVuUSx4vzVVQfRaKFdyWbZ4lMt1XuEKbn1+Rl6i30s?=
 =?us-ascii?Q?YZOY3lsavi4uEyJsHOAOwE4H6fuRHYGUQcSHVsoRObNl9fLcYbKrhJzwqZkE?=
 =?us-ascii?Q?vzDR9HIhJdaGPXR2boRupD4D3+0MzymLp8+4XrWCge0cfJoV2ttmwK0S6znh?=
 =?us-ascii?Q?4ZTEZlFuXdt7JgCH/bxLsVj0c3naxk1SPGT9XKWZ62s1PlONseLitQwKdCDF?=
 =?us-ascii?Q?6+cQ8QUJbEW1NrNSC2geWab5jLQClii2Tmx8A2QlQo9EbmUC8uNcTCI/koAZ?=
 =?us-ascii?Q?SAVodMDjQwk40K8/PCjKC0RSen0SsfO6OqmEDGAELPuzqjjseYtbg6aZh9ri?=
 =?us-ascii?Q?jWnfK+MWhUM5ACkKF7cz1MHptd/FSxy1Owdlbo8paPokGkFALn5oDK2RSvxF?=
 =?us-ascii?Q?hCoSs3Ji29l4cSKj2pX7Rbpi+iDg+OwK+GGXG0/xTYt4Kx3qtL4/WfKaw4z6?=
 =?us-ascii?Q?LmxZKyw/UIxwXf7sD/K6qPw7M0Th44IltMoEfj4ZNVH8ZFjhk9335OgnhvM/?=
 =?us-ascii?Q?ssD7nIGUw3/uI3Bdnj9J+O5Cde3KmE18LG9OH968WtMftLGb+LWTw/3SBPzz?=
 =?us-ascii?Q?TFht3bnbA0HwNTDrYtIHOK/tIKKBW/pBKsPzv1Co63Z+eGqouj/+zS2jEX1n?=
 =?us-ascii?Q?e4NXn8OB68423bpdC7T5pPxIJeViwW2VEZVbfpR4Xt+f2a3OHS5k2LIWh1D2?=
 =?us-ascii?Q?JyycrcI/PJsxeYYpkg1b7VgENQidkyYMBT9j27nNNFxfkd68udCJDIRESc8i?=
 =?us-ascii?Q?R3etRjd8YBIkzuSgBBKLdYv14qJ12k9NRf0MzdJKppRk4oLW6ckBFC/+igJn?=
 =?us-ascii?Q?KXPerwCbc/2o7GW+f/MJuDsqQovpiZjwDEBAruTw+RkDJmzfXz/h2f5NJ/ug?=
 =?us-ascii?Q?DWlrnuBqhSV1E+e+exELokqc4P/NVDGFLsW13FVBV0mzIHmGGb4SmF3WJKj2?=
 =?us-ascii?Q?DiUXBylXU9aDMiXwXsNAo6UZ3SI7Hmx6xUXyxuYRCQ7zXHMdO+kQMjCVNcbj?=
 =?us-ascii?Q?eS4P8pZI9mihi5x55ihgonDoReT5CiFfhV0gQ6Kaqy2mwkBLeGo94qtu7U7n?=
 =?us-ascii?Q?5mS22TiEHP/NTQUP5k/XayYRcKnrQ9z9dKn7aaXcWXq3Hql2Ec7lVt25XXcK?=
 =?us-ascii?Q?dRv8reeheHHOKYU5wRRqvBY3iBIFUlZ4ja5rfAR5qaJlpXRT5+NFbAYI484v?=
 =?us-ascii?Q?+53qMKpVGKQ1wo7U4nRkimMeNvuUvyDgq19oUYrrVP50rQHe8hCLfFDNVrgZ?=
 =?us-ascii?Q?nBjdVKVfiv60jnzyeJL8h8vhTaMaKm5wLI9nXKftOkSFTxvw1AuKeEQjPI/h?=
 =?us-ascii?Q?TkF3hHrmEzUAxHX7eStnvyUEL8hGXC7qoRdsDSg0TFnURNOJrvqCmt+3s4Jq?=
 =?us-ascii?Q?ll4F2YcNCAIGv/z+b30DRGQ=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e0ee6e-8e75-4690-cf80-08dd6737c189
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6974.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 22:45:32.5754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IkNolaQQpRxmk59WJ5PQaBHNyMAWKMTEJTCJSh/GXtKJ5MGvKI4ZADQAfX7sreqB//8aZAppiDqJGaeX173Lujz971doGhS8FFoE7AN/fNY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6136

On Wed, Mar 19, 2025 at 01:30:55PM +0100, Rasmus Villemoes wrote:
> Now only called from within ocelot-core.c.
> 
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>

Reviewed-by: Colin Foster <colin.foster@in-advantage.com>

