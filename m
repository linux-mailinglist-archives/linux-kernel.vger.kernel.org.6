Return-Path: <linux-kernel+bounces-568743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78925A69A04
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 21:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7813E480128
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF594214A71;
	Wed, 19 Mar 2025 20:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b="r5V8loLt"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2122.outbound.protection.outlook.com [40.107.236.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9471E25ED;
	Wed, 19 Mar 2025 20:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742415083; cv=fail; b=YD2uyQk2cRU+3TmbjGspWh389WaT6/fpS+jDcWyoW8i4Kxr9uHhTVtz3OW4Jz/uf/DZjE6Ke2jT2gTPey6uo71FcgtPU2yUNAo7h4YqtnY2mJgAp5kSfyYJxJqXBACFCe0kv0fvnxsY0Mt7o4JGqazVKz6gS/bthwVJGvEEYmNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742415083; c=relaxed/simple;
	bh=wsmiD4LEiwQTx8rn+NEAllA5LV5JSPie8LqL9Oy4ZHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V2NnGLtfwUgF3EOy0lmxKt/2bIYOmxZ0Yc5KEf6okoFH1PfdLfMlJo84kfaNtd1ekji3baqdETdt2rKmL7Fxr2dERUR8LLYM6IVVYmuA7gdyskVsHvexyufaLNVOGRrJqKaESU1TWxXJWNeW2+yvUE5Vtc0pzvcnJzKe16uUtBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com; spf=pass smtp.mailfrom=in-advantage.com; dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b=r5V8loLt; arc=fail smtp.client-ip=40.107.236.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=in-advantage.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qahV3HN94t2SAqx4NLzYlhwb/g7XCkCbzNqHsKc3k2E+P6BRz7Ci8reZ8bAU//38ds9vkTN+1T7vx3tFwxv9Ejkh/OxseZMKMghlxV/OkulbNI+Tc2YKRQJWtXUps4My/18T+CXDeKZShxrlw5Hz7dAwiMQSWoGuNK2kH2Hx0GxMiwnLfwd8RMWbRxgF60wQ+oyAHk0f6PoA/fFH9ctXeCQQV0Vdyho2OsT6QjMeZ+pB/loSev1kAlQEe1gByxUPDVEU0ewR8CUJrQ49h4hPmfWnI62FeVentiu8PY/9Qyp+AFC/ktDve5zQPnfWIRgRxwaYuqEG3gmcLfz6fwtiGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGwj33wO4WrQH3+7Q8qHfouM4bIGCH6AiIODaF1r3Mc=;
 b=y3DJsS2B3CSMS8Wjv2Jnz5o1ZPTeAgU316bOLpwX1oea52O39+lmmlp1pVmjz5g8mW3IlDSnM0q+9r81tFiJfadVy+vWWeJVeJ9xmD0IJ5sNrJPiJiZ3WeTIW4IVE4/oEwdRWqR92sIjZ0f0ndLm4YmRlfznyJk801rOsor0UYHIgqHpOQ5BvKPXYY/dE1g2RBfDErAPbKSoR0lU5GZsDI1qRFXrdFDM0ZS7kGuC9kElmdlLfT+dc4je1kzI0nlrOjHseEr696pzlbCHQRdrLnbHKTt+SwxyU8aq66gogryhH/lsaMhzJooBF0B5uvMLBbFUJrhiBYlnyvLJerY2iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGwj33wO4WrQH3+7Q8qHfouM4bIGCH6AiIODaF1r3Mc=;
 b=r5V8loLtknST41nh1J3xXDQx8bWw82yxy78vAJ+YhyyRUUE1eXaZToEqjkPe3IkzSQkgQrreZRM5xuLyuyKypaCmiN1/fhmNmwlt2SVIWHCgGZHjew0fLFL7A/oG7Zb+MN8o3Tg2JvVveJ1WMh3pWlkrhwdfXiaKLwjMB1xm6iw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from DS0PR10MB6974.namprd10.prod.outlook.com (2603:10b6:8:148::12)
 by CH2PR10MB4183.namprd10.prod.outlook.com (2603:10b6:610:7e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 20:11:17 +0000
Received: from DS0PR10MB6974.namprd10.prod.outlook.com
 ([fe80::7603:d234:e4ab:3fea]) by DS0PR10MB6974.namprd10.prod.outlook.com
 ([fe80::7603:d234:e4ab:3fea%6]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 20:11:17 +0000
Date: Wed, 19 Mar 2025 15:11:13 -0500
From: Colin Foster <colin.foster@in-advantage.com>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Felix Blix Everberg <felix.blix@prevas.dk>
Subject: Re: [PATCH 2/8] mfd: ocelot: move SPI specific macros to ocelot-spi.c
Message-ID: <Z9sk4ShcN3awPy0f@colin-ia-desktop>
References: <20250319123058.452202-1-ravi@prevas.dk>
 <20250319123058.452202-3-ravi@prevas.dk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319123058.452202-3-ravi@prevas.dk>
X-ClientProxiedBy: CH2PR02CA0005.namprd02.prod.outlook.com
 (2603:10b6:610:4e::15) To DS0PR10MB6974.namprd10.prod.outlook.com
 (2603:10b6:8:148::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6974:EE_|CH2PR10MB4183:EE_
X-MS-Office365-Filtering-Correlation-Id: c5662bfb-f18b-4b67-ca89-08dd67223525
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1S5D5i504CCLmwtOMgZ4Y/Pj2f805HvUOT8zaIaarUpbC2mGqWvsmU5li20Q?=
 =?us-ascii?Q?NM2Jd6sLXqtCxUgl21nW/PL2JI7egfCmWOFBNmQPcijLjhTrOm/aAcTgNukq?=
 =?us-ascii?Q?zM6ihQsoza60zJXYWWAXm0T2HZuqfSrEyFKh8mPk0RV9LGChq2Rs0zDmmu6u?=
 =?us-ascii?Q?sSm+iWJaxMaPWxXBAP3RuYSt8bIyXAR/+KD7KGA0SyDnknueQkEbGOgqo7MR?=
 =?us-ascii?Q?9I3CjRSUg5m53CXh6MXFlz+Ie0TvqCi5cmtvbRMvnd4Ea5C/usHMHO5jVm8A?=
 =?us-ascii?Q?ar+1gXDcNjb6aGSUEWg+TRez0EHt/glI9H4uUNR+VV3k7IlyEzsx1FvyG1iB?=
 =?us-ascii?Q?6n7xQ4OTCukwpzkCmxbytzH5UMOTBfUB85CeQHl1mSbkVk6pXOLDN1YRbTGK?=
 =?us-ascii?Q?uZlrrM2TS7+Wh893cBjCVJq+QXKYjmBKLyBxBDSKrC6RRNswkylBdPOBi5BK?=
 =?us-ascii?Q?hFDelKCyWgZpicrke1+34nJpRHUOYMO0u6buGltiqGY9gi04HFcgbDBEXZOL?=
 =?us-ascii?Q?Y+886lMaavZBX9HEGcDPHI5rqnfftNthYdnF8FbSeBSVnuk+bWLG5j3onoCJ?=
 =?us-ascii?Q?c/fLNgT6MSoDzISRF5EOrVJiJRzTL7WxU7m1FRTCQKKyc067+eZv42cWAJXp?=
 =?us-ascii?Q?Tfz/S9+ShhY9CPNjdWKHUz/mndQBrEvKaLISnLnU1Ki9oDYLsctV43UQAvKj?=
 =?us-ascii?Q?++6cybYLTcyKmZPEcmtOaOVDVXsN8ela2BJ986aS/bTR1AST8RPe5AGsK9SL?=
 =?us-ascii?Q?0w9/2gbxJ1b26r9vwkkv9ziZOEVp+neN/VX7XtvQQOAmjSnVbg3i0ViA7t6K?=
 =?us-ascii?Q?tmJGHeUqTyBg1XiFukkdgNNcx1/vQbpnXW9rLwmDMsw76fQlYlhJIHCxHIqF?=
 =?us-ascii?Q?NrXvd4MXK0/PR/ZksfM6fgd+BEzrFDE9zuADwl4DtbE4cLKTi/HuAN9q+lsr?=
 =?us-ascii?Q?JOZ9ZlfnIUF/bK0pVpisOMU7nbqU48MXV+3cxlCtWhJ3hQLPsQ0pBobBWBgw?=
 =?us-ascii?Q?gE04eUpReacbsy50u6qR+xLkbO4g6kb4hvnbpXKd6bPEYajrigXRbMeWy3sV?=
 =?us-ascii?Q?tYbK0ahVqBdkPonNt7OMqg1vJJta5hgb50I8Ic949hb3q2mYDhbs/mapTTjN?=
 =?us-ascii?Q?ekJcN3jqodXL2CuWFGvbPezK+iKeZ+5vnwLwdZcq4R/Stv1TdQ2PARQVKUBX?=
 =?us-ascii?Q?lCXiYAPyJOVb8Rl2UYG7m50gVOwY0vgDfJFWQfHek1J4ye8QDXL38qm/2Vk3?=
 =?us-ascii?Q?XFfHdqMk7NgxMZC84hMC3k0DluskusBA+Udlq5Af3o6B+GSTzNORsotPpGiG?=
 =?us-ascii?Q?WtQ5nizWOyXfvvetvhDC2GFmZk+M8FK1zYW4aEBtA9KuXJdfPmXEOEOnAQzw?=
 =?us-ascii?Q?MGlLHotK6aGSezztxTrXmN0ScnUt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6974.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OFkHXvypoHglp5LJn8kHDmI9ZrTpje9clnXEJacFm/9G3mQNBek3CCmuqBXa?=
 =?us-ascii?Q?MfsVpU9XlV5/A3VpYfvzbUOvjiPSTzIUGTJsNds4kRglaTmWmmFJH+4FH2Wz?=
 =?us-ascii?Q?w6+7jnQ3urX0RK+FlkdtYwoZJWICu4k+OEGZSaK+JHB8vdljKEv6rpnXwU4l?=
 =?us-ascii?Q?gF2WNtktGOv7tkI0b2MtOdetdF4EfslEhUAQBjWfJKlFmmrHGYUTWZxkBvMO?=
 =?us-ascii?Q?jfyZnyRYq9ogR4vhlCXAHG9ayqvt651fn6pMyBFAz8ADGPWXxBxO6TgcgNtZ?=
 =?us-ascii?Q?A3KWxx4ywei0cHR8pAdmporRp0qpPtMFSx1BBS/EqmkncCWtRtnUzGWkl24L?=
 =?us-ascii?Q?lZRI6xbd5uQzpNTtb8MUXk1s2pdB8jaOjywemB8i4jLYb3mYOJqijxETJSlq?=
 =?us-ascii?Q?yXPayfS7DIV668sjtSJYgSqPjtuuy277Wids7r9Agbe4xK3v8qUK9iW4H4UI?=
 =?us-ascii?Q?mqAnyb5QRtT9CibM5B63FptHVv3cRY7TQvw4wXjkS9q6PUltpuENaoRuRVEy?=
 =?us-ascii?Q?uwBavTmhVm+GXw72HYSMJfNi4JgMVPm25RC+WZbzHq9IeOjm5xTdYc+jV1Lf?=
 =?us-ascii?Q?IVIkSajt9m/FsBzeGK6O/TdI5NZ9QBQy3JIqyCnuvujXs5A1L6+F/Zt50Nj1?=
 =?us-ascii?Q?WkiP8+eSznIa+ayrKxyRn7w3px1O8+1TbEau6lRWc4M2Ny7vB8cKAH2GqLs0?=
 =?us-ascii?Q?0ei6WaB9FeFHxL3yr5RT26elVhZj9Qve/BzxGzquBd9Y0V+Iwma6uqCY3cvh?=
 =?us-ascii?Q?f8kXQTc1UFQK9qVMjxXWJMwoau90ZdETdwygqv/LXBrY4ylFWX541xKQ/Xbd?=
 =?us-ascii?Q?yd1ntKgqokNY8emP8iemqW47fiRiNBQ8MTNaqCaU0Sw14W9BBtQu8RFfuKgP?=
 =?us-ascii?Q?ohytpeLT3n3NyhSnIGM9E59hzKC8uEJLg6wnMq2CE2QVTCEZTeAfUjz4ttdf?=
 =?us-ascii?Q?18qN1NO9fh4kTwKwlky13+B54Sxr6Yxh2JbHS3ez79R++pqj53l7OHax8sZe?=
 =?us-ascii?Q?B4//pdjI/Sn/f9r87R2dletpjEDDptvQlKF+KG1pj2aMmJSJKYa1iM1lzh+j?=
 =?us-ascii?Q?mEBz+Ib7yp13FnhMQlvWXNGXAq89GSUeMvtKisuNduuEPT7+Ss9zpYHQf6H3?=
 =?us-ascii?Q?ck74LO9XONjylElhe26FQd/kanzCIN/xFqzDUfdHxwCOkGYHYTwiBBTYr/AC?=
 =?us-ascii?Q?oUFRDr1z3BOWlKNds266Pm2/unwxJKbSPH2be/PbMLSSyLDoOhyMy8lNd940?=
 =?us-ascii?Q?OmqDURbfZIjaatfIAibuVRJp60T4Yh5Zl8isyBk3W7bdexMGcY6QAyorkc83?=
 =?us-ascii?Q?TxaIrm/s1EDG0DhSX/PSS7sxdCi3rDuuPnWMro2IyJbSHzTyPbY24OmNhmfP?=
 =?us-ascii?Q?wnc/4MHG4pYVxxIUSSYnaQOPYmGPtGNspWoFEPfkYb3EUaheRRo+Ird6tYQz?=
 =?us-ascii?Q?vSs+T3l0t3yNMKo36mzpGObIS05jEOQFxhHB69fN5eF4yWdAtbSrfQRK3HJk?=
 =?us-ascii?Q?0H9DgosVQttQDl/bWorTcrS5PXmRzrJ+5dSGgWwVkXtbuHe6+UHfVdG/m2uA?=
 =?us-ascii?Q?2nSjFiS1Ho7vuRwue9AzcO5aFX9nkkTBFIfMJjPWfxHnZwLKjp7+5Ixq6qmq?=
 =?us-ascii?Q?cwhch8jZ/NH7DYcq2aHmuFc=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5662bfb-f18b-4b67-ca89-08dd67223525
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6974.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 20:11:17.6224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +bJD2TLTUbjOpp2gjU47/Ydcqv02AmzoBIqpuB7V/dJWkDTxVdYtCvWYGXtbOs/G3TqMKzZsltHinseXJ2o359XCqLFx7vw4Ga6fQkMb1RE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4183

On Wed, Mar 19, 2025 at 01:30:52PM +0100, Rasmus Villemoes wrote:
> [You don't often get email from ravi@prevas.dk. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> These are only used in and relevant to the SPI backend.
> 
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>

Reviewed-by: Colin Foster <colin.foster@in-advantage.com>


