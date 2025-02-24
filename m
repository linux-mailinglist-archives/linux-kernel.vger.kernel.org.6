Return-Path: <linux-kernel+bounces-529325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE966A42323
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3C283A39B6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221D414D28C;
	Mon, 24 Feb 2025 14:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lJME+Y+0"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2055.outbound.protection.outlook.com [40.107.100.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1B61386B4
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 14:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740407226; cv=fail; b=oYxT7OFPP87Sb3ZT+NwOAC5FtBp4ICflg35bcKERLo4knfdZ6jOF+tM6E/xhrnrrELzJWArK8iwu/y/XnC7kN/QK0u2AK0BDapKyzD9lx8sWzbaL8v/Q6j6byiHaFs7Ah7Sh/DcB/twSxbeVgKygOI2T9PnNcrCIDnqG7IXtzg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740407226; c=relaxed/simple;
	bh=fvv67bQIddawrR8B9tzUqOFgUzJHYYL/IDjapV6Cgg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gmtZQfKpdXIRLdXT89hOzisP+4atDKxjcgJPRLarCfeQSHDaGbFAzNe/Ddp8Du75oSQL6EXAD1ST4yigtkQk3BwkEPN1bVWxGmQyKsYccWQ3XvgnuhPtXMsqVs4oEOOeuDrm2mZIjuuJFS3ZgydY/eNbtuFAMzs+9NAEqE8fYl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lJME+Y+0; arc=fail smtp.client-ip=40.107.100.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qwUTKQDYC6PiVM85rMg9dV7wi0m4HJU8mKgdVk4x+XHP2a/vLMUWTHyFZgFsvaOO/EoLEKNT6SP/y9ILYkJ0QdeWqUNT8o+wxeHqNCCKB7LimmIUnOVZ3ie391eeCM+odn/HcFzP1R+QvwBlLtw8lQgbPZbwMxXCvn3VnxifG6z4kKYmz+MNiIDanD1wgtwzLHQDjTJQCIbQHbf6i+LSoMdoTkeNVi3GcIUDCF6gVFGj2sEvlGdCWX3dbdVGLxs+H0Odj83Un2uaS45rlvjsB+LX1GrZSxD2PYhc32wb3B9zrrwCuVSSR42nv8mPQjgSoii44sxn7Jywn6D/gjRnKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16sPl6JvNgz0N5NcWtkrFdfjbqAiXR13vkFUU5aTkm8=;
 b=dliTGbwlK9geR3Iq7xiQ0bQVsqO5TGhH4lwFb+uTeLpQKNb+kIiwS13xOvCkVRlKCTQiVqeeZPiIN6yLLyEUt+1iuHJwD+8vJl9avgQlfqkV7D7t5z6ADYEH/zFPrjtDyhLN8vNVPLxTgewiTVggtgjODbZle+HB1XqZ0mvuD63f/b0gTR2FNR7/7UygsDB2eYTZ9dX6VWt1AbhKfViFPuqrmD/zFHb4oFZ4qAlxNKQUUduOMTEQSHh+f0F8r4QRJScU8IfkJ06D2G8Oadb5K9/H4N6IYtx5zzz/Fycq1TR+WhhbepzlDhbSmfYykoUVsZypAiVVSLp3PQjfxDKQ8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16sPl6JvNgz0N5NcWtkrFdfjbqAiXR13vkFUU5aTkm8=;
 b=lJME+Y+0SMdBlM7PN5uAtYWaciAbyH7mgCbu5KhdgUo3WmusJo0Sf1+AUqqJuB2f3nIE+VIVHlk3n2H1/l3W/ZRJjGDJXQHOL1OhDACAFeu8KU9+Q7BcVrFBtEmKLne7iHKDrF9EwdvH+ISQnKwGJNWmP28UdoDvtSvG5G6Gh2cTL8rw+4M2aMCLiYZgCmFQHh8ARrF56xmRWKECMWs1MReYb1pIiAoN2jtOn9hVQMVxSMm6f3ONFynKPy59TgJX4jb3gk6ofrvUZW4kjHLeZvVaRVz7jTCNvFwyIZMbPxgmyfSQA2T8RCE8HtgtEYkYDw3BmmSa2r9vRIgmuiwwJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA1PR12MB7638.namprd12.prod.outlook.com (2603:10b6:208:426::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.19; Mon, 24 Feb 2025 14:26:57 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 14:26:57 +0000
From: Zi Yan <ziy@nvidia.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Frank van der Linden <fvdl@google.com>, Arnd Bergmann <arnd@arndb.de>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 1/2] mm, cma: fix 32-bit warning
Date: Mon, 24 Feb 2025 09:26:54 -0500
X-Mailer: MailMate (2.0r6222)
Message-ID: <D58A4854-0F69-48BA-8B84-E29F2AB423A5@nvidia.com>
In-Reply-To: <20250224141120.1240534-1-arnd@kernel.org>
References: <20250224141120.1240534-1-arnd@kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN0PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:208:52f::12) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA1PR12MB7638:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fecc345-01fd-4f2e-eed4-08dd54df4b4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+7xizASMSqWet+QKN36HThzwZ1Z/5wqcYiJYLRkVx9gTNwgf5M0pZNmXJcea?=
 =?us-ascii?Q?DSvqXI+F433S9lyMQ/bvomW+k+zYvjoyTH+01W0EFpNzTSXnCvC/mkDRDmIO?=
 =?us-ascii?Q?brU1ZwC2AH6gggNYotoM5YZ7SL15ElbE6+P2P+jqzLZEAn4quKD18h316AT6?=
 =?us-ascii?Q?OSmXAn9Qu3nUqFCJ1efx9CJ9aywSol3rxFV3rZK1qX5Jwr36wC2MWoc2B0hA?=
 =?us-ascii?Q?1CKz1u1nbN9xw23rqHxwu2Q9FPjoNOoRfPj4+u3vR6eVmmMTlp1YBgyV3TL2?=
 =?us-ascii?Q?QERUmdf911Ysrl7nwletFmFlchAt8thcp+gYVYkeRiEetMyYAL+30BSiJNsQ?=
 =?us-ascii?Q?Rtbwg+N7iQ8/xt7Y0LEwzWlMuecdVi3jFxNRhBe0/DkSAPrOMVB9gJAQ2QJc?=
 =?us-ascii?Q?ZqpLCEO/hPjgz3+wtzdvl+PV3PywqRpiRzvAqgFQowgXavK6JLxEdwwThAFX?=
 =?us-ascii?Q?hjkAgsalYxbMfcdBXE1/ydN8yYWMsVeKINNj3yvs5FT1fY+fV7+zBAldh964?=
 =?us-ascii?Q?zn6eXGvx8WeW/qFJpRb38v4K47GLZFJU9OJPx91pwWo6N7FBjtxIwdFlWT36?=
 =?us-ascii?Q?We1p5N8C1EoE7KNCZU9SArWasii7xvRH/5+lXEgKRlR7HPfgnQZ262vQGIt+?=
 =?us-ascii?Q?VWEpcFcVKrWP7rupV2elTUdWOG9ep7ffifLQMgWaEFubbGjIFrl+xAYGFEin?=
 =?us-ascii?Q?RP55qdIKkli4J1ftxuip4Ybm9viLYNpvaG73bc1hUGQnXgRckWYFI0dD2Rly?=
 =?us-ascii?Q?+F4mZ0nMVuQnFdB/4hdxcKhkW+iq6jbQKX0N2TKbg5h4SvZkDwfYtqCUfh4q?=
 =?us-ascii?Q?Vxu0FFT2ArvY2GsYr2YW96KpxmhwXamjiC+DfGQxHl4XAlMSKwyDWP0C5AX5?=
 =?us-ascii?Q?vcgw2oNorj0Nw6ZWtmdqv33S48fsJ/exOyl44b96xYU8cgH2k6bzgJUyBwZH?=
 =?us-ascii?Q?zxFUfk7HSfgqxgKFy74g77oTcUAP9ShGAFEXRXJMGMn5jJSv+rsIXxOM5vJY?=
 =?us-ascii?Q?X+CauVdcF0eIOnT0mgv85M+Y+Kr1OVztUPOXPrnP6aZ99i48CYZlEprN0Tn/?=
 =?us-ascii?Q?2JWTMqtykuWama6/d265uThx4RA4i8wHe0l3TYVpOgxLVuzq8DgjJf176Z+L?=
 =?us-ascii?Q?pITGsK1si/6k0rBDx5VpRjxszagcra1q6NBdbh6rPDxwhhbHPfCph87ycCoz?=
 =?us-ascii?Q?+e0XNmGgdoIPm26apq8denK7+r23fSL5wiR4AlUwupJMGn7nA1KdUqj/VVwZ?=
 =?us-ascii?Q?tQG5Qf1BTKaBnKa87vxGnEKX/oUYWsDotsKhWqq9/T27nQ4YQA6yiFKPSAxA?=
 =?us-ascii?Q?RjMsmkTc+38P2W29ZAnUcfyRNL/81cYOS13djFY0IdrugG/qZv/w1u/XL0Qe?=
 =?us-ascii?Q?s7tCPeHQkCNq/vA68ydCd+tGTgxF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?av3lr0V3sN05FAe5T9uSagCDSeo9B98G4Oi2feyIqyZ9mIwQXHIeMoUvm26H?=
 =?us-ascii?Q?gefcmqmITkPc9Co+eD+FcqB9D1y5TB3UDsoXkqpaU6imI6qROSyupbAtu+NF?=
 =?us-ascii?Q?hCqifynr4VHwhfygQinm+5lMLMXD3N89UAsTMMLJITc96j99zpkIW1hsnvma?=
 =?us-ascii?Q?AcE6dA6O9qiLSgIhVQn+2t459xzYzCw3UBDnc8tlEhF024ATuc4S/aS8yp2I?=
 =?us-ascii?Q?r55Cym68Ob/1rM7PMM1iX5T1ov+lExjAcNV4Oh3p1uNyCYunjXg3Nl2u0HkH?=
 =?us-ascii?Q?qmkpuSFKr+KpSx3dU6o4KlmGQfEkZ/SVtw7Jk/pF8cxzEZqXn5eEN7wiY+e+?=
 =?us-ascii?Q?2zcqHjtme0UrgLxppi3JWbRawv8/J1t/TCpCin9BDznGBbPCsWHb85ey4zYl?=
 =?us-ascii?Q?f+cl6nGdddHkTy8ZfuKRZYFafrnrNsOZbstHRd5ITxwRguP/YjbfiF0hFmcL?=
 =?us-ascii?Q?RvnL4Q90/2P2kHsJbNYjHcTzORCyhgMwMa2ftYP6NR2OWdzWk9oT1a4VWgPM?=
 =?us-ascii?Q?N3EzTMwv6ckh1mkG02M4v2OyiJbbj8OXu4jHlfgI3930WwmznyXZ8vN1TQRt?=
 =?us-ascii?Q?DkEWJRKI1mlt970rZOWojL6+gJYiMAkJiY5cDq1rH/uBRw6aR7P8IH/4T/v4?=
 =?us-ascii?Q?6NQ3OvNSLGfXUA8kkiGk/hblNrR9cawqQwiBJapb3GtzYW3eINiRsJW0Nx1x?=
 =?us-ascii?Q?SHmBSYwbq0FZxTsQL9PI+IqPlSDeu96wQ+2AtRb9Jb3ZU8Ua19cfu3S5fA1h?=
 =?us-ascii?Q?GM2b0q9dKydV1Xu7KB4iiPUeqwGy131HUn5qnDZt3usU3Q8i3YUsP3a3ickq?=
 =?us-ascii?Q?PKo/o7aLbc4473zQKrtE3BRUsqap35Eg/cLKWXGXyS4gHWpq/crnnCCcEzcF?=
 =?us-ascii?Q?eRJobEKbIHjWKKgqP4Rn40YAJ6B+nyif1DMncFFAhvay33YYg7AtQm3zh1nd?=
 =?us-ascii?Q?56Y4rvCNdtuH/CMoy3bCkbiwj3dXX6BOY5S7E+vhJQQnMqZTf8vQlghj1Fdo?=
 =?us-ascii?Q?GqOc8UgcqLCWWAK7odK2HNLDhxP/S0yC26coPF/hQfqaQICM3N+s5xTz+icw?=
 =?us-ascii?Q?9EOxKcCHQ3Qfr19D+HNpywjangNTDrJ+Ly5HAfHraeeNJh8SjMpnjxzh4hFL?=
 =?us-ascii?Q?TqQfSFxucxG7IVgEUi6UYuLe8Oq2i0Cl6xb54nNBS4f7LAn/essASeOHuNMG?=
 =?us-ascii?Q?2mpMHyfS/Moc5ueEXb1tdQvRVNhB7SHWJBGFBEhw4puJdPgW0R6EFYxjbxVK?=
 =?us-ascii?Q?o+UK3JHzT62EHNVemtxENBTqP98O/V/rhg4Ca6zwC+Avy8sxlJle9SeCF2YZ?=
 =?us-ascii?Q?XSzZbkJhPeciF7GBOEZfpBz7sPzbJZolPF9Llii6R7qc3q2iXqqZMHAhD1S1?=
 =?us-ascii?Q?BVrC2FROhdFT4gkTnz6GC0CLteWYDxAVmQ0K9XyiEllChiFECYxQqcPEriBZ?=
 =?us-ascii?Q?BX4ZEO/lOq7vNokEHv4IEpWYXzhdITm/ezGiS2LqiFSVaqgE66nAy2UFQFdE?=
 =?us-ascii?Q?YRUStfRdERw5XqJomGJTm2fS6OJ4hp3ixm6t8Gua6Kcg9VXZgRZUbUlTaHx6?=
 =?us-ascii?Q?fwjNo0XTi/BUEr0iqO1hpS9Z3N8t3Z+vWnqxEQMk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fecc345-01fd-4f2e-eed4-08dd54df4b4c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 14:26:57.5894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C7J8pnDEHbq7JwxX1EcwHBjeL2LmLPexN1+y4Fdq8zbM5FYG6+csX86SmY2zzN1A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7638

On 24 Feb 2025, at 9:07, Arnd Bergmann wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> clang warns about certain always-true conditions, like this one on 32-b=
it
> builds:
>
> mm/cma.c:420:13: error: result of comparison of constant 4294967296 wit=
h expression of type 'phys_addr_t' (aka 'unsigned int') is always true [-=
Werror,-Wtautological-constant-out-of-range-compare]
>   420 |                 if (start < SZ_4G)
>       |                     ~~~~~ ^ ~~~~~
>
> Replace this one with an equivalent expression that does not cause a wa=
rning.
>
> Fixes: 4765deffa0f7 ("mm, cma: support multiple contiguous ranges, if r=
equested")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  mm/cma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

