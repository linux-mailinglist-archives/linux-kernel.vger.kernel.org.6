Return-Path: <linux-kernel+bounces-565969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D343A671A1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 616C97A313B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9389520C010;
	Tue, 18 Mar 2025 10:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TJyUX6JB"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013069.outbound.protection.outlook.com [52.101.67.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2247A20B7E7
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 10:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742294436; cv=fail; b=u08wE77l62HGEt7kwyA6EQy2LHqEGwOCPnbjYBQ+REnQJIwVZypJWE62jaxqTvVQPnLJccTUBHPw7+DLx/y0n8KYV6gSLsqtTNFlOgpZS3vcPFROrAosVMKdf4V2U09LQ2/mBeJ/S9OJ45jSxbdu0MWnjIyxIhsBwSsOgpLTcts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742294436; c=relaxed/simple;
	bh=0TEvFMWxhAkOgpbUV5twA17EDYoa+eOPX5d108Vfyws=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Cv83JIxDEHyh5Yja8nrACNKgQ5s8aSYjmBfERpvlIme+oVO/vAIGLb17VDiX9sJMFzho9EHb3OlKzo/bqhdoNioudsgB3YvkYX2wjs3jiaQxy3wqgCWPqk91JGN5Lgh+/B6eOKO9rrGJz2zppNs1wBih9jA0RILk2XMrpe5Ru3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TJyUX6JB; arc=fail smtp.client-ip=52.101.67.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dw9enDDzflHYsKkVj1OxTBbowlRPSxc79cmO3vuqwIZ+7Gh55E84oWcmLj+m9ryfot346tHHHItd68PmTjmJxvr8UvTIx5mEPqLo4qw/YyLJ0/GPs2jE+HELcGsAJhBmXG6yRCVtVQKFs9Zp50AnsXIqX7RAXsgRPIlqVknY//FWvm8BNCP3YIsaTMMpesd/DunfAAphShvvkqCH4N/jiJwiUFukN0c9YiqKMBStrDMqnyzyJnYm53qOKlmdJkAi7hFhdzABgiLmDbMlLHaPMbrNBa97DdimgGsPrTHKrOqjtjWPaZAtUjn3uJRwlJcScZfnWVH4hUUxVljyyT8Lfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0TEvFMWxhAkOgpbUV5twA17EDYoa+eOPX5d108Vfyws=;
 b=hZhRE0iDKTMmy5AayTuP+lYy7oa8MKBWZPZuwZG5V2XfEYTFbZnE1v7F3e3vYR2apLiC/Y/J68CozN13jo80fhlOBo7S1SwePsglktUFAkyy1TVNWLHWUvGfEraJlAC0KkVOAze01gOfFbIkiiS5PtGYkZop2Phbrkdp9hg3VXq7v8cDs0ptrYj15Q35gvCp7fDDVEV3cQEicbYorWrFKAJ1sMIM4iI50VWwaW6m1S3T2YjaQM5sEc+GQ7edLte9VzHCCWuIIAQVZY0lhhJWu7QwdNiDJCHp2JaSTg9cLzdChoHlYPqF+8Tq7WwlBpNeEi3vF+/8DAi/YjH/IAPQPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0TEvFMWxhAkOgpbUV5twA17EDYoa+eOPX5d108Vfyws=;
 b=TJyUX6JB9ynyj59eAn2bg+VP9GoaTo57d0iXhNKavRg3dMVmKyu+Xrhdwp8McAuLbr5eX14Scvr8mUwDWbljKcW8T1LZkQjanRSfuygVZ+rudwE3j4230UWH/40A9Hxv1Mob1mwHYCgiQwOmxA1JsJpNxkrma70Gubwe/ajhuS6ETpaYJQJHtbmQd1ojlL6sfXyxIGUIJC2QaGf5HfNioN22GIDDLEcpWEN+O8LygqZRjcOv1VMZFTbOgM7Jh4hwFNHHan5R+rQ1P5f5r3GjnwZVCQs8teplB3jymmscz9ZUSIlgnwoRPSmwmJeXzpdy5ANPOhat8UK85eLSOu5EOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8868.eurprd04.prod.outlook.com (2603:10a6:20b:42f::6)
 by AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 10:40:28 +0000
Received: from AS8PR04MB8868.eurprd04.prod.outlook.com
 ([fe80::b317:9c26:147f:c06e]) by AS8PR04MB8868.eurprd04.prod.outlook.com
 ([fe80::b317:9c26:147f:c06e%5]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 10:40:28 +0000
Date: Tue, 18 Mar 2025 12:40:25 +0200
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stuart Yoder <stuyoder@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org
Subject: Maintenance path for the fsl-mc bus
Message-ID: <2xzljdzktgpsyag5jhfwbxc2sroaacljecsq36hlxefu6jnz6g@zlorxu7niqnq>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: AM0PR02CA0198.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::35) To AS8PR04MB8868.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8868:EE_|AS8PR04MB8897:EE_
X-MS-Office365-Filtering-Correlation-Id: 7de6d0a7-bd47-49bf-2613-08dd66094cc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FSBgpth7V+BC9sasJcafj9NCwCH/zZYObzHhwj2YoEuRp7G3jg5mcs4hZXqp?=
 =?us-ascii?Q?jbxt7vCfukBmgo9lLobcEInQbYZsoWkveZzoivDmPNVZGg9sCXdiJtM0WO91?=
 =?us-ascii?Q?6pVdK16xX9RVmJ/df8wrdoPK+WbWys0uC1LVJJ9M81uLn93r7s2VYt90XjgK?=
 =?us-ascii?Q?WNt9EeOqVeb/jfyGW4KJjJOo14fWbeUxZkzD6fTGLHfyFEpxlKdsbG8ENfF/?=
 =?us-ascii?Q?dpwZHce+ygiKH/7kq2aUaF+I7+F+dRit2zAJW59PWYarTpCOHR0718raznh9?=
 =?us-ascii?Q?5XJ+JMP9pLLm26XEVL9qVbPYlDpkbp831ny9/j3n6bD0B2PLzjT2aWMAPp+S?=
 =?us-ascii?Q?Jr9dbqEk40gvwyFjrtQxXuEfQ430nQLp2wypgJgJDGSEEt4H+GvJuBFjDVFq?=
 =?us-ascii?Q?Cvr1lg5Jk+I5Cl+gNtIxMNz/x6DZa+MQvYzh1EJSg5cVnlXRgJTuGX6VJJnr?=
 =?us-ascii?Q?kBmNSxCU2lLNBqgnAIzVIQQno7xxCTW28IcHwASrShesfdQVHgV4wWoELSS+?=
 =?us-ascii?Q?v1e1nRR7d1stfPCbkXSrn2FZWQDkE0JlCuPEKX4YvAOwCKaBa/7UZ8DCRUIK?=
 =?us-ascii?Q?MpV552LCGpBP9RHu1dy7vfU8Kido2N08/Jri4OXGn+PLUV3/eAsVOGZpKs/5?=
 =?us-ascii?Q?Wszm/k0mZLkQJVaOd4UDcdd3A5dbyYbIjAtmCE7vJ1fezT1no/sQIZA5okhl?=
 =?us-ascii?Q?coY6tNTRn9T/EWrIECIaeDdh4FR2BwBgLaG184Kn7f4VdujNiXRztvjl1YIO?=
 =?us-ascii?Q?z3p7GX2lEQmM22x/a05J/jTi2LnLOb+7+RcBrJIoqlKTr6X1lGXKpvQ0VkrB?=
 =?us-ascii?Q?xfLlWE7xHZW2wRVB8Qx/WDtJisXdM8gge66ZIE5PqePv8AWhohHPjDVlfghb?=
 =?us-ascii?Q?3UHT+MTL7fq+BkxdmPyEcD1AbaHhBHVfkzvum3e662etNCclq4si1SgAD430?=
 =?us-ascii?Q?lhshMX5ToXXjBT67wt+X4uQ8ILOZCCpZMY0SDQVUIBQcIbDvntWsTSK0TjcW?=
 =?us-ascii?Q?9AlyHJYKfq1Aj99KdCGg/Fv1ML8DT1sA65tA8G0j5nkPA0iRv7JDcot7Tq44?=
 =?us-ascii?Q?lnwLELYoVjPtJN/mn9YbcZjMwpI4RACQ5p4/9BaFmh81ARV2lc7OlUY/whxe?=
 =?us-ascii?Q?gXCentQ7j8QP2aD2QxjFX8C2XR+IBgI1TyMppBp4VU9dbiDJs7ui3STmwDRW?=
 =?us-ascii?Q?YDEkfHRwU3g87ccgqISBlj0QMR3iAFRTm8OhHO1FecGNaIX2biw3IpiyIUjm?=
 =?us-ascii?Q?H55r+i+sWaD83l4MaF+OnXDRn+ixySPUN15xFDLzFod0KMK4ILuxco0b8jeT?=
 =?us-ascii?Q?9a4K62MP2E6TyAimZvhp9j0qnJzk3PzD+qqA1SnDXB99qVCpvDhke2ipPrue?=
 =?us-ascii?Q?4lzmBS4W3DaLrBsbUa8SgxFyhlGV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8868.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1LP8fujRTlSUtXzj9K86x0nznmx0H7fz87SbD66HhFX/e8WZwacOv28X0U5u?=
 =?us-ascii?Q?ZvRJa/hKsnblGo/cAKhZZp3uwbpk4o7pjdhH+hT0xbQQk747wQW2/H1yfeoR?=
 =?us-ascii?Q?xHVmccaud6pI2/xdWL40mE9qdwOqRa0SfPwCzjH9rPL6399EoWK/fcqsCsKj?=
 =?us-ascii?Q?mLI2Fw/SwUw5aEGqY75IXdEthCrl5qu7BdGPY20OP+rb6pUB/10/njOlRN6y?=
 =?us-ascii?Q?NE5UNqoVWeyZYlNjltI3oKCxF64IbowT0C0G/Dau+6Ne6BZPSsdrvFTH2SwR?=
 =?us-ascii?Q?aIa/VC9b0D+Z2K/K4U40D++HICbcdDyC47Oq/avSnMMlesd+L689hLICV7vV?=
 =?us-ascii?Q?lJc/5Jo3ue+sCj5moYCacfApxUbnDb3dR8kSKB8FvO6GIR3MEt3doyfED51N?=
 =?us-ascii?Q?zsJe/0o2EFe90TqaC9qipT6uhgkX4UDZcTN8Nn8vsPOVjifGCpKuBEj2bE1H?=
 =?us-ascii?Q?xZw4vXe5N67iOBn6YRDfNMI2413U+1ZqtoJiS9bgNtaMhntn9IhOaePkFtH9?=
 =?us-ascii?Q?8GcNVzoR8aM1WrYKKEJntj2Nhfrhvvq8RKtfh2p31LEY9d1QoD3082XiJFwA?=
 =?us-ascii?Q?H8TXjneygPB7Ax86/5CIXLiQkiJmUWDtNiKHYhgn+jMckq2kD1jOgQFr2DO4?=
 =?us-ascii?Q?ZKI4+xD6YgVWOHYgD/N2PsM6OidiAifFGJRgr7uZiO1HkqdTSp63ZztnvNVO?=
 =?us-ascii?Q?+7+R2YnWMlW0tkfTRcJ3M8SN8AOkg3C27b4YxJMqQ3ugUqAvMDSkWQsqY7zx?=
 =?us-ascii?Q?Qo8e1THKSxx3+PYWbGBqa41dnr4gLRHlg2ofTaX++6tSoxjRJDqNMCZekSU0?=
 =?us-ascii?Q?L39WkZsLU0EVOoaPluPsacmVOFsJYksrLjv6YI43qn4JD9BeMjFrOH5Q+MIn?=
 =?us-ascii?Q?rQ5uKGbxeD6I5xEHigjbg2K+BH3h79DTjyzvLsaDexNZby4b8AsYH3TPmwBV?=
 =?us-ascii?Q?TakQR6VyiQQGDjuRfFvpACxmd+VEDRr2r61DWTT8Ww7vE3lGJtiRkBCUP4HI?=
 =?us-ascii?Q?wOzden/YxfVLTgT83uGP4UBKnQFA5uJISJche/mh77SqHlsgfGUsXDpR408P?=
 =?us-ascii?Q?HG+rhjAt8fMXn5WsNn+Rrda9JHlaTnLU7iXyaZ2vZShgqjIcxDMJn6sOLr9G?=
 =?us-ascii?Q?gNHfNR83aBeA9HUNeA7Ei6klVUaAmhHTLZwO6sdNrMNzTLTPUBt1g71jSgMM?=
 =?us-ascii?Q?kSpZaKOUd2c5Xlq4NVkC2P9VePvYTxc3sL/SbOot+EDRjEBHdTezxB6/7mmM?=
 =?us-ascii?Q?Ap375C10SJR8y5LSA3CeewfJG5lofWatMeu5u78IMxtwgHibPRKuV5qDoc5n?=
 =?us-ascii?Q?ziSph+jRgfQ6Qkp/0MtugvXjRW+9TdM6QiMv9TrpnE265zk2QjosCkXitBop?=
 =?us-ascii?Q?oLIWmSSvx0of3c9XmfcvP6H62zPYFPJrJpg/pObhrwBR1UVTDow0X+aWoDl3?=
 =?us-ascii?Q?JOokP9xT5YVYR+pnepb1r/0Q7q2mBId7rPHOke7jhne4bGTG1h2D/RakRyTe?=
 =?us-ascii?Q?yt+6FBRyF5bY3tOobS5pl7TbVQP7ywqapXEARTQ8goOvQyeDHtdP9vv+vddd?=
 =?us-ascii?Q?oafHNMg+THtJPeYiLl5lG7n7lFE2YX5GzL4DCgCV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7de6d0a7-bd47-49bf-2613-08dd66094cc2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8868.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 10:40:28.6875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8jRHh3BTG1QqjhO5bhBMweWad6mF5i/rIwmEm3r/mHwPQ6Ax+AXCvHMKPTNtX2m8FpqFD603GlbZpWeMM6HpoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8897

Hi,

As highlighted by the discussion in the following thread, the
maintenance path for the fsl-mc bus is not clear.

https://lore.kernel.org/linux-arm-kernel/Z9Lj9_yM1EK5pKee@gallifrey

The fsl-mc bus driver was first added to drivers/staging and because of
that, Greg was to one to pick up patches through his tree. Once it was
moved to drivers/bus/fsl-mc, patches on this driver were picked either
by Greg or by the Freescale SOC maintainer at that time - Li Yang.

Conceptually speaking, the fsl-mc bus driver is contributing to the same
infrastructure level as the SoC drivers maintained now by Christophe.

Christophe, would you be open to pick up patches for this bus driver
through your tree?

As a side note, I know that the MAINTAINERS entry for this driver is not
up to date - Laurentiu's email bounces. I will send a patch updating it
after it's clear to whom I should send it.

Thanks,
Ioana

