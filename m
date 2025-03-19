Return-Path: <linux-kernel+bounces-568899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA26EA69BCB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 23:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0308422E78
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D8721B18C;
	Wed, 19 Mar 2025 22:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b="TXplb73+"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2119.outbound.protection.outlook.com [40.107.244.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CD82147E3;
	Wed, 19 Mar 2025 22:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742422097; cv=fail; b=MzdARlVQjoZmyUu/IMw0kwBtFnGkYwtOsH2Pam0O3aWj38meMclmRIEP4A/Mc3wZC3WwqCqiaDP8kFrTOge63PQsm381dqBEjQhcsvNQooUr7GPVAYlLI5ArdU5lBSgEbLPf2DQP0Y1wiu19QunqamQYdcD7PfRpmAOeDxaulyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742422097; c=relaxed/simple;
	bh=3Wio1H6h7ruh7LxgAQb52b3GDgECyV0FybfyM0EO2Y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ghQCxY5hrpXr5GjggBZj98feDULqK9CSB+mURW9bpbqbNZ8kzpwDlkRvVAacsvjAdqHkpRHwIkinb2wus3e8UAeWJLIVyWWHP4mZXIWEzDm3i6x2Ryof7tpceM5XvML40Vm/KRwLmlRy58v0rBhANpMBz+Q2GSgMhHH0FsDBtRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com; spf=pass smtp.mailfrom=in-advantage.com; dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b=TXplb73+; arc=fail smtp.client-ip=40.107.244.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=in-advantage.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hrvkedPVav42F+w9R57oQozKfAdsgPBnVxo6m/RyLjvGqabaypCHm1ikMIT+qzZYgiIcdaBd4DicDsIpfgN4fYqnI7AMBaEXnSGuY5I7gzTnsWcnicYdPmrKecFsjTpfNTCvuMqNcGAIkmq2gGv7f7bICFImt/0Ylc7DmQ3zLt7pbT5zF3Zi9KMU4qPVH7hRT4a+y7zHm6w7qPA4pMf82ehSFx2OHUphrV6I1RqI+VjkYSSaLE0hUU/kNJp7UBcF0zWxlRY8u9OLFyLnUQSy5Su/NDZnPZbRNwWYfVzARrvWj6ZbHt/Vd7YAVqLZuO1IAOi9BYyDNylQSircz9/xvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Efcwhf6A8vb8ZvHofhHotGW+vo9OHRU+qOdRe7F6Ag=;
 b=x0xQweX3Cq1kM9M14/tc1iO1D+CnovBXr5XPMIiK8/dDrjiboGv43fo/ameVXp7FDcXGZh7pKdE/b8DuXgex9zn6SeQ3cVKeTJ9H+53Xp5Ddt4DhD5I5Hhc8mdDRkJ43Fxnc5R3FC3iJN/RL2BSFOgkdirINEUA2OZnB+rbw4VallnD8f6Fezs7NIn8hr4Gb0SiQdkAjyF7My5NAr5gWsURB3lv3uBGVIMVxM8OJIP7MW3iLmwQ15DGT0RM5jLfTYYgNsuFl2x9Tj7W8l9OgPdLmUZb8FU9jvL9cNqzq43axx7VnZT6zldHXTqgOU0Vv6kV0WoZTtKGgT4i8BPLk6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Efcwhf6A8vb8ZvHofhHotGW+vo9OHRU+qOdRe7F6Ag=;
 b=TXplb73+z6RDUFitCeT5gdSeEhsRSpPFFDEq3YXQWmFQujixv0FjKxiJg8pzMYfzz/LTQkrFwtG0PooxETZxyUIMTWkM2nDBfWJ9kcoA+rnnRRZMI/0a/6zybVGiZ5JKLLQNKezzeXkM2q5mrdnq5BCFAATVx6WaQDQPxN8dG1k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from DS0PR10MB6974.namprd10.prod.outlook.com (2603:10b6:8:148::12)
 by PH8PR10MB6599.namprd10.prod.outlook.com (2603:10b6:510:224::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 22:08:11 +0000
Received: from DS0PR10MB6974.namprd10.prod.outlook.com
 ([fe80::7603:d234:e4ab:3fea]) by DS0PR10MB6974.namprd10.prod.outlook.com
 ([fe80::7603:d234:e4ab:3fea%6]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 22:08:11 +0000
Date: Wed, 19 Mar 2025 17:08:08 -0500
From: Colin Foster <colin.foster@in-advantage.com>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Felix Blix Everberg <felix.blix@prevas.dk>
Subject: Re: [PATCH 3/8] mfd: ocelot: rework SPI (re-)initialization after
 chip reset
Message-ID: <Z9tASE2-adiEUT-3@colin-ia-desktop>
References: <20250319123058.452202-1-ravi@prevas.dk>
 <20250319123058.452202-4-ravi@prevas.dk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319123058.452202-4-ravi@prevas.dk>
X-ClientProxiedBy: CH0PR04CA0091.namprd04.prod.outlook.com
 (2603:10b6:610:75::6) To DS0PR10MB6974.namprd10.prod.outlook.com
 (2603:10b6:8:148::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6974:EE_|PH8PR10MB6599:EE_
X-MS-Office365-Filtering-Correlation-Id: 749c284d-4b79-4478-faea-08dd673289c6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?57z2MMxgTe4sEupk9fDucBaQ4YhqmeoDcI5FiIRMvxXBp3oCO6Zwhsi1yLHU?=
 =?us-ascii?Q?VDa0CmjiNMzwoDAg+vY7YpWtlMcj9qkyuCaF2SlOngfvcJ6UuiM0v4vWzdFH?=
 =?us-ascii?Q?X4l3OwmeIy1R99hbd51mo2j0+LQgOZLjTo2MGRFfNA5NrQCpY+U14amGyUxd?=
 =?us-ascii?Q?1e/NS0YJ40FUFFy/TJE58XeH/HiNAqaRxzNhAtr4Hzmulv0EShy3btk8B5iq?=
 =?us-ascii?Q?3wUUzxTOte1gXBG0NV7igCh1jy9ddaPgrGhXt+q9rp5Yo754nQX0Dg9oc8Tf?=
 =?us-ascii?Q?2Dh3fQL0PrExXlN+frTSC+e/tD0mIHBB7LBJd3vFbx3PCJZQMTnPo+RwQDPv?=
 =?us-ascii?Q?oa1L4H1HZWxJBRBRTcoCye+PQTHSNjWKNvj9qQmyoih31qT10DpnivZOoJbB?=
 =?us-ascii?Q?ZtFaXIkk9piRzxIAuTaiuHFbRqGnjLOI2qQ8tr0idSvDTMBnvDeFfc6Sk/Uq?=
 =?us-ascii?Q?k+Lm1MtA4bU5X2tDzVYo0oH6bEdcEwZGgMdIteUP8o6C66yMJATuRHdOz3s9?=
 =?us-ascii?Q?ITvPLycUdaZzqNrLwJpHjjUUCuDg5jNr/mGHkT9SnzUn0puvgwtsKCeBLOf2?=
 =?us-ascii?Q?l3vLxwbZBOejbDFIasWrGny5JXV7Hvk7gz+RnVCYa6i3OWfy0o5zsSnsOCI5?=
 =?us-ascii?Q?DvAoVBFmf4IBWEflFM0s+Io6T3BrbvhQT53HqI36LNdfxDyidGwMxvQeUGbJ?=
 =?us-ascii?Q?QhAtLyjSD14vdm8XFxUa+5mgY7QgWzNJZSOA6ok5snVmCCufEbOno3/kTOZE?=
 =?us-ascii?Q?p+ZgZHCYyPY8ciUYxjz+obrfyfsxst0jDbqF6LKZrmF03893JErMzMjjawqE?=
 =?us-ascii?Q?9mf67WcbpGKbWLEabiFzh/CasqCBhnO7+gpKCxZMiaStxSaBLsqZk0GYE/nz?=
 =?us-ascii?Q?SVVweNo2VhdAOifpzs0BlgDYa0KwZoMTcwk39MLo2TTtEzCLN5YDdGSVcovu?=
 =?us-ascii?Q?FcGpdnWJC8T6zJJKRdNmWBSjBavnpa/Js7kpmbJoe1B2oKlTSZ8wJw07yPkf?=
 =?us-ascii?Q?D5+84k82mX7FKz9aL2qrZ/KaNM7ANtGRLQpulkHZPD6rWIYEsBuumAaFLYdq?=
 =?us-ascii?Q?rmRdCk9unl1oh13kmZKrUzSf8VYRXk3uvC+bBUghQsh3FibJlI71iYeNvpzM?=
 =?us-ascii?Q?RiD5+DdvW8d+4BeGUnaeh4DoBiGHgE5DlXw0vvqP4p7x8rz9IJBcMPUp5qjs?=
 =?us-ascii?Q?OoU9PGqh6wzKCNfiycI1BPCqIIfRUQ/3nEPFYvqoVmo8vrMwfjmFK88PxfmT?=
 =?us-ascii?Q?Iig94eWqiv24Hsu6WAAbIrqMo9iBcsyo6TxcmvqFm/7Ymr+//cjgK/XgrNoK?=
 =?us-ascii?Q?JkAQeuj8/pd7UEuCucfs7jA3SHb4OIzq0o4xxqMfjScMwepRGxXTt8rBDGnH?=
 =?us-ascii?Q?sJvZUoW67qjcpPtOlcLgYeAU0UPt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6974.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EDtOwhib/Zp2BI+b804gMXAv2TNdW2rdoTLUfyizgX5sL/VkLkIRQwpbcowH?=
 =?us-ascii?Q?uA++zi1sPOaRj5dP7iA2fAhsn5bYn94R2zIDuuP+Mvem0kqvqOTrDgiLWk6y?=
 =?us-ascii?Q?OCFA4aKFSZF32FqmTVUyty/IpHb9BVDA3rRRinkPhC4D9qCoRE+OYhDZAswp?=
 =?us-ascii?Q?DyWxl3W0kWpsSEgyOlUK/zeM9OSqCkn1A59Ojjvqp3c0Uqg9EFAwNlcWlVZM?=
 =?us-ascii?Q?/JaQ68HbLAiLW54JFo7gjYNGS0hMyWLp4BjOSEnkHMPUcL0kZxd5YD+EWjCP?=
 =?us-ascii?Q?/ahUNynztQ6CJFzaefmd+hoGNl3SoEgjgbz8Cb0I1vjUixC64unHYlq7/eZX?=
 =?us-ascii?Q?qK6+S61EJL6m0A70vuBb4B3GGuf7ZO9VWk89oOf+msKp3E6shf0dN5XjVsfW?=
 =?us-ascii?Q?FogfEmulMFf2sdN5wirW2PMTBTf8P2RY8vXy7F2B9IQ3xCMSgmey+04kkcGl?=
 =?us-ascii?Q?ITGBjl5VTqZGoR0jcJACxfRje5yKlSycrmhwQlZIa9gKdPryMJ/+FQPa1xU4?=
 =?us-ascii?Q?myV19R4ZMuxxyZ/nDrYdHN6TFPQO3gSpjkoZguGILR/zovW0Ei4ZoL1REWAE?=
 =?us-ascii?Q?eKyYLyKH5RbcDAMDd7HXvUkjy49CphnDEwOVTKvtudPRd/YglT/T6KQ4phi9?=
 =?us-ascii?Q?5Paxhih1xfjyWn0F7EJZQTBb+hWkys2Z6/Ro2MIvf950MEc/bwshffX+RFqJ?=
 =?us-ascii?Q?sN9/8asMfsRtT56C6RScvNzFYOM4nNuu2zsZbl0dkFyRCbCa9E02+0LoA0Yt?=
 =?us-ascii?Q?bSnNUf0tDV8Ig+0WRidWO0ZgCqVgQ/ju8nNGyb2F/ftRV3VShLuptmOrC0us?=
 =?us-ascii?Q?1qn1cgLxIebEBLi9FY1W82j+f8u00qQJB0ZFXN75Wsvt10p8Szsk7C2GdHiy?=
 =?us-ascii?Q?JkF6ZMNiWo4S2Z6auNSyWOpu4CYbiXJX2VMS7Ttdx24AOjlT1NUPgHu1X9N8?=
 =?us-ascii?Q?5HVO1kff0E3DoHfP3cEfPjGl8UbSqjWqtAD0b8HMg9FESryp9/6Aaky7nnWN?=
 =?us-ascii?Q?84itv9E2GYvsnUiSIf2fM67aEqCVYke12Tv9KXUCPFHxGNwgAqqnAF3ktL1U?=
 =?us-ascii?Q?asLDmlhOGVw2c7aD2xHxCkfzR5PAf9PEuM2PYiCOWn3SqHpWfDOE63fcDoGB?=
 =?us-ascii?Q?Yze+wcnVA5qdsd2T3cLftE2bBjGMiTWCj4jhook/CcqxiNcB6m6dU0wXxCm+?=
 =?us-ascii?Q?WQyzjdwlAxYQ2bQ3c73K6MZYmetNFfNZFTC9e+bnUJN4eq9nb+pavuD3i739?=
 =?us-ascii?Q?9OXSaOQL5pzp4HnWTqum+VzvtKw0ER9lPs5vRZkreNADvMoJWM7ASd2zM1sD?=
 =?us-ascii?Q?DR83wKfTdEufrdXKW3oCm4rqf4reFv5UZ5hQxYhTS/Ws+ktZLXM2JAmGY3BZ?=
 =?us-ascii?Q?bWsBk1MwWDfw+uChUc/8XOPa4icHBKDXVukeBH6EPA9QNZVLxmO3VgPS8CKQ?=
 =?us-ascii?Q?ZBS+40srlt2zbdiP0xu0oS0XPZJvZdTt9ACiUyiwyaR9Nil590pCF5TStn1Z?=
 =?us-ascii?Q?X6rSMeMfDW2oG9J90YR24Laz6qyOZLOr6dWR3pEZOR4kcWgSHfFyCiuTsBsb?=
 =?us-ascii?Q?LwKf6vK+RmyBhJ3aCW8R7cssm9mtAPbWfqbsFsLj2QzH7KmldpiOA1cOrG72?=
 =?us-ascii?Q?2j1NN37//yibTC5QjiyBo9g=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 749c284d-4b79-4478-faea-08dd673289c6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6974.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 22:08:11.5681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rcr73yDp34KGxLUKvm3QxIIyBIrUiS+EKsQG0oIL0H4YL1zuQnoGiUy8qkaUwUWnUiMr22uarVRd//qjTOeCUVYUZbiUrAVVzS6qjj9xH7c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6599

Hi Rasmus,

On Wed, Mar 19, 2025 at 01:30:53PM +0100, Rasmus Villemoes wrote:
> As the comments in ocelot-spi.c explain, after a chip reset, the
> CFGSTAT register must be written again setting the appropriate number
> of padding bytes; otherwise reads are not reliable.
> 
> However, the way the code is currently structured violates that: After
> the BIT_SOFT_CHIP_RST is written, ocelot_chip_reset() immediately
> enters a readx_poll_timeout().

I ran this new version and everything worked - and I've not seen an
issue in previous versions. I'm looking for guidance as to whether this
should include a Fixes tag and be backported.

Great find, by the way! Is there any information you would like from my
setup? I'm happy to add a reviewed tag, and my "tested" would be that I
ran it.

Colin Foster

