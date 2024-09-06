Return-Path: <linux-kernel+bounces-318161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48ED996E94A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 07:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AAE0B23654
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 05:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E33C8248C;
	Fri,  6 Sep 2024 05:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="QKbyjb59"
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020111.outbound.protection.outlook.com [52.101.56.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9214B7E0E4
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 05:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725600685; cv=fail; b=nPZv5nPnWOcXo6SgPcAO3nZsQ2Uf5dbfxOWsf8V9odMWStwdva6QAWEMjEHEyliloQ5zC1ke6+EZQzVyLxsh8aRC1WfHJWJlLXxz1Cl5zEL2/4UJXOhS5gQH7RWatME/fFjMJUq2m7C3Wgl65kQOcTjxPW28GqdEfOORXUcZUx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725600685; c=relaxed/simple;
	bh=+hVwtyDAL1LTqp8B078ltZJ8c8iuAaEq3UrZ3/P8mUg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=LisV5YVTHHx97OqwiMqyJEs5wVnCVxjsoWasDWaX5xC3GgTsSjeafISADNTDoXlJpEBbU034sV0C8W6zXzXjgqA3gbIk0iHzx1tE6wJk2b5zTdDtc3k/xoe9GP4ciyiaygRPCqfVLJR3h+0MfzH4UHwozuPkD5xuHGr//JA78EI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=QKbyjb59; arc=fail smtp.client-ip=52.101.56.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b28NeIWGVYIEH9a3u0bKdcK61EfaFmzGc3pM+OpMLhjpn9LHa7fVvs8TZ7F85Su6DJevKSCPzkgqNQqi7zAUfgEyMrNSzBCRspKanMWRyDxEtSMz668nb2TKDwwJDZ0K/zMW7BPUVbX2dO1U812vADk1HsGpPovdLkjbdAKdRMKySV4EjYs/uo7ImH4fIX7yfb/5pkguVh+RibnTwodRBtNOjSWCg+iImnAU4PdOce95hN6gaOeNKzNEcb8BZKE4847mhUy+qM10XeK8EoVviTXMh6wh7rWd1YJ+n8OskUtmqJFSXaFAMtCHp5H2Wzw6KHpBJ3FFXwkeA6eoieXnTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jcmqJpK/Jn8KuI6IZF5ALGXhbmavehTsg/hKcegUe1U=;
 b=brfMwGEdcYzlYeNI+BUTHWdR1FDOfAaANid7PPs9gNXkcKps4+275CqbpuwZ487W4TxgVppc7qZ7VYA8I3Gyoz9KkxWLT8JRSVawazBPcjzbYrY/hJlAq1sR+3fSMr+8fqfAPaBrCk80XLQ2dnYuLwkUC7d/Uf95sx13bPqEEUC3XKVyPw+eweko8i2pJOCjajBQYoRW7+8Aqfk0SYMykq0eKo4RBesPhb3LE5i6E6Hxy+zdfX9Y2zl/iRMFfxOPtUQAdWuJzdgGFaLDIlxYSDcNOvDaoaIWNM207SLX2XuqBci+xlMToa6PS/iD/Gxftouij1bHOUE1eXq4K569mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jcmqJpK/Jn8KuI6IZF5ALGXhbmavehTsg/hKcegUe1U=;
 b=QKbyjb59GJfKaFjk7Q5WtlGwMLXODnB0xb2ztlo26k3nBzMIXI8OPP5iHHrxsSVUkPvhb1u8NCYO83FImgFJvnMROPtH1G55hf/qABtHw21lHrVj/p7p6BHGKvMc0yY2qeAt3Nw5PNScdwtIKUShkJ6qLDn4YWsGYt0Nxsrfhy4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 SA1PR01MB8111.prod.exchangelabs.com (2603:10b6:806:33b::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.27; Fri, 6 Sep 2024 05:31:19 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050%5]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 05:31:18 +0000
From: Huang Shijie <shijie@os.amperecomputing.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com
Cc: patches@amperecomputing.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	linux-kernel@vger.kernel.org,
	Huang Shijie <shijie@os.amperecomputing.com>,
	Christoph Lameter <cl@linux.com>
Subject: [PATCH] sched/debug: fix the debug output
Date: Fri,  6 Sep 2024 13:30:19 +0800
Message-Id: <20240906053019.7874-1-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0101.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::11) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|SA1PR01MB8111:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d6ee907-e1ae-4a19-82e2-08dcce352218
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CkPGWxPLJa67WV8nDE2sjFcO5sA5tZvGnpD3XeFS9rT6k3KTt5iIaQMngMd/?=
 =?us-ascii?Q?zQ8VP+WbHMN+KXtmTK7Y2q7Lm9sLl+BHsjXSof17PuIea+lpIoprrIN7b+Gx?=
 =?us-ascii?Q?BKdn3SnRejxYJeWk4eARCIym0a1wO6cJ8PIZwwndAxq/a7XMSv9ME1oyr/mr?=
 =?us-ascii?Q?d8rp4F8lZCewDz6A9r+aUAiOJPzaK+1ghIMe/Yn6QPAZFKZDu1adPty3cH3h?=
 =?us-ascii?Q?MVfaomPoiWtJM6B/q+MJDOZmpv4QUk0ZGerOsmzXBPEjIikIABZQWX40Bk0O?=
 =?us-ascii?Q?RCIE96thFUvOg7xelimavFtpOh4m420KKshOJIQc1wG+35yQjzAzmBR2DllL?=
 =?us-ascii?Q?WZepkfKv7OSOYFGT7bxsdh8J8BOLaxAycQy31Sl8lqqoQFTKacU73/wGEgsh?=
 =?us-ascii?Q?7QhvIkE5WJqlhFNxNd5vWQ3v/8/933/3Cp0kk7wJ1KUUJV743WSxJxlHs+Lm?=
 =?us-ascii?Q?QywgtevCnJ/67SX7z/126OT72QQb5OGNhgHg5xIRBhW6MLpucpUavSnUfMzH?=
 =?us-ascii?Q?uoGwb35Dy5g9ZSALPdZQzq2KK4oCTBkV5mbXVV13MtYl25R7cppt+re7Ms+Q?=
 =?us-ascii?Q?gjUwqzsGVp0gvndySrNg1Gr7WekgpFjIHP1Czd+iQ0Y2vhy6b2w95pt5Vwkx?=
 =?us-ascii?Q?6Iya9vUYjuoZUlqpxweD0lU02GY1drqa6f73qyIBPpOZJpsJP+6LoZ4jCQCP?=
 =?us-ascii?Q?T4Ut7AjNErnOWmPIMFWmAwuf9XdVPbxyubUAzCsHWIZBNKqZJMf9J+MHjbQR?=
 =?us-ascii?Q?qJRIuOigbh/Llly7PwmVM+0IElBhAPCAAIqykvZ5Ghxl//dNGiDmQc3K37OF?=
 =?us-ascii?Q?9oBTwjqVKA3I9ZDX2V/hzGFkgQRtF9/Eftu15+yasaMLoKQLXRNDt7O9/kDv?=
 =?us-ascii?Q?swntkoXOYdxq0/CUI9W/en5t93HDZghBNzoMEIP/GTM2wGxJO1f7bxcXPBsm?=
 =?us-ascii?Q?FOF04IbqdsobxuyUrTjLK2aixCoQ5LUl3ks1N0OpjjgtNjaJwxXqL+17rUum?=
 =?us-ascii?Q?yt0TyFCe9LDj62GzK6+pVyNQdI0I8mK+AtPqZOtV6QJwoz0++vJZ2mlvxzH+?=
 =?us-ascii?Q?0DlCk49Sj9Mc1xNEUAc5O6GWsBIVf2ggCimDHao0cGFSmDSNzHmzVEvs6O3i?=
 =?us-ascii?Q?ohGs6rCM6aSinrWx/rreoDgo2ao/2JWVp/XTciGQrz6Kjh4pZ2sr40/+1SOH?=
 =?us-ascii?Q?OQznYmBPiNcMJnFEJ0LaUhumrzImbTDCKNx3bJJwPhmnFVNqhN5QdaPiySB7?=
 =?us-ascii?Q?j1rEbBXc5vc8POcI7uFgQBFj8/pVIN/WFF/XIH6VXC1o2QYHZ9zKpG22ytaM?=
 =?us-ascii?Q?lUkIKXgwhNIkroT0QzbkO8bzWyANH3FxEzGX6GFrmHzgbXg42D6gOAsoxqZx?=
 =?us-ascii?Q?AKLVZ9aMAu22ajryGncLeyPQKwY4b6pFwCjf7clzpFGBZMwXlQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cpZNBmuxkMI12ls9lxf6fzX7k5BSDwZNCxoy+LDM/GRrElCVx80ml/oP4iqA?=
 =?us-ascii?Q?o/gcLhq8sP79T31auHnL4eZuJ7bLBVBno/13n8W5fUeXkiOEXG3v7gxcjKqw?=
 =?us-ascii?Q?E3EXtR5ppLMc2DnhJo2y7AKQ7pIVpwxW2qYeeCyiVSv+iyIqxIjwFbZi4vAG?=
 =?us-ascii?Q?DEAhHJbt4Ba4TvXnRz7pM4B6cCPKb4X2H0A13++wsugQNps9+GO8uhJTCekr?=
 =?us-ascii?Q?tp5uv5g+V8O9y64LRJ3trt5YhBUHnjOhU7h+XaMx562SsqITcdF/fC5p4T+v?=
 =?us-ascii?Q?imufx12TF6d+Piv18P5W0s8Su6ol0RevMDTB2PbvkPBl5PYz6dRyRHi3i4PL?=
 =?us-ascii?Q?Ns64FdA4ssvGUTOWh3jHNHmJFD8pM09rV462QNPsCoOA40Val8NHYLornNda?=
 =?us-ascii?Q?wNXPSrABIVNzoaTQlpyvpnfyCQZq0tXjIXBroTAMqvcN27b5/jPBkbxov6sr?=
 =?us-ascii?Q?NKfZGT+33MVNlUpQCevgYm53aj645QUE94shfKPiuwqqz04vusyX1hAXiUVb?=
 =?us-ascii?Q?4cwQdYukWHK3gYi5mpqVxp6ml4oAAvBAtxH11VvCJxV2jW9GDD+IhlWul/2w?=
 =?us-ascii?Q?vJjVJet9fI7id5K2CcMqq/zJxOgrPjoN3qJJlUOkxIpn59lkek9leM42HRtO?=
 =?us-ascii?Q?9i3JPBMZ68kM+1IxAoPw5BMUOAYM93t1NbtJrpEdHstWwLbpKjUkiaRZWXYw?=
 =?us-ascii?Q?S6nLYy5iQ345SoVQ3I5X7/A2gav5bZrGO2Ct1vCOVyKrOB+R7l9UO5Tjlow+?=
 =?us-ascii?Q?T6xbCnrys4K9hE811/s8k92y7nzCs22JfIzFaufczbNTqbUkf9t8692iBv/8?=
 =?us-ascii?Q?dUInmhxua2g2Y8XWl+pOMIFabJtyFBdF91dyHVGkQb1ciPRf5bq+bT6B7tEt?=
 =?us-ascii?Q?jowxtn0FxQkp4CZi9Gvpya0prBYhrqgqi29/MxZeCxx3OweSW2nPnJ4ifQpr?=
 =?us-ascii?Q?FAfaX80DSyGTz9gZhC27iaiVGfJi6I4OULMSV80W555eCIk4eQ4aXeyw3dkI?=
 =?us-ascii?Q?0KuCfGhpBSIpALYmYwTzlp8pbzhSmTR5BgIteN9ZoxYp+QLsxCIXNvgZi8FO?=
 =?us-ascii?Q?jSlsAROqR5bS/OtHkS5UjNDXN0yFMjlMOljhAcMpLa2k6+eXS5ryLbu7mmft?=
 =?us-ascii?Q?L3Gjk68bye7s/OKSjelvY9734+SCwtImY3VBqNSxoiuZnlT9VqQzi9lANJ8u?=
 =?us-ascii?Q?A35NHgvERJpfw7Oe9gNt02ZL/O6U+xWDeG6ebxMwX9OecRBwFPeTJm9XzGtk?=
 =?us-ascii?Q?zo6ZM1w9m2c2FYq9x7NwQ7AmgSg+4YuugNyQghwnLhzta0T6VoOXKGOH2Nvu?=
 =?us-ascii?Q?upl5NK2EKUURAjBgLsqVad9z9cPDLM2g0eUQIshKoa5orukWQconVC7FD48A?=
 =?us-ascii?Q?vAO4ZwMwqHHJl3fBc/Wy8tJhD477l3s3HRWBZNhLiK0fI1PLm+XNQZEF7MUf?=
 =?us-ascii?Q?uN4Ye/8w2k3M9q08dEfC/i1BSR0wai6q2GAn6lQlXyHmhO/ZTgzRIACyCXr7?=
 =?us-ascii?Q?kphSdRqKFKvfMHz9Eaoh6Ln4RckhySzKecSH+zzkphJNKwep7aIzSwsd2/L/?=
 =?us-ascii?Q?YCaw83M57oYhsTk9feC5t739Uf2pZojuGAYkGymSGBpns9Cg5e5FQWXOUVNe?=
 =?us-ascii?Q?WJ/6zD811keNkD3nTF8H6WM=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d6ee907-e1ae-4a19-82e2-08dcce352218
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 05:31:18.3599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AjYAgtxmLiexu1LSTGNv4XmFtRFfC6CQN8NkKFNAemToao3fH0LKc7R7Ia01ykgAK0wPbgoyMFrdmG9CMunc2xdZuNmhZyBw992Oii9uT8Qn//dlRDpQVoT4JXm4ZTPK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB8111

The current debug output is like this:
 .....................................................
runnable tasks:
 S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep
-------------------------------------------------------------------------------------------------------------
 Ikworker/R-rcu_g     4         0.129049 E         0.620179           0.750000         0.002920         2   100         0.000000         0.002920         0.000000         0.000000 0 0 /
 Ikworker/R-sync_     5         0.125328 E         0.624147           0.750000         0.001840         2   100         0.000000         0.001840         0.000000         0.000000 0 0 /
 Ikworker/R-slub_     6         0.120835 E         0.628680           0.750000         0.001800         2   100         0.000000         0.001800         0.000000         0.000000 0 0 /
 Ikworker/R-netns     7         0.114294 E         0.634701           0.750000         0.002400         2   100         0.000000         0.002400         0.000000         0.000000 0 0 /
 I    kworker/0:1     9       508.781746 E       511.754666           3.000000       151.575240       224   120         0.000000       151.575240         0.000000         0.000000 0 0 /
 .....................................................
The debug output is in a mess.

This patch remove the duplicated "sum_exec_runtime" output, and make it tidy:
 .....................................................
runnable tasks:
 S            task   PID       vruntime   eligible    deadline             slice          sum-exec      switches  prio         wait-time        sum-sleep       sum-block  node   group-id  group-path
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 I     kworker/0:3  1698       295.001459   E         297.977619           3.000000        38.862920         9     120         0.000000         0.000000         0.000000   0      0        /
 I     kworker/0:4  1702       278.026303   E         281.026303           3.000000         9.918760         3     120         0.000000         0.000000         0.000000   0      0        /
 S  NetworkManager  2646         0.377936   E           2.598104           3.000000        98.535880       314     120         0.000000         0.000000         0.000000   0      0        /system.slice/NetworkManager.service
 S       virtqemud  2689         0.541016   E           2.440104           3.000000        50.967960        80     120         0.000000         0.000000         0.000000   0      0        /system.slice/virtqemud.service
 S   gsd-smartcard  3058        73.604144   E          76.475904           3.000000        74.033320        88     120         0.000000         0.000000         0.000000   0      0        /user.slice/user-42.slice/session-c1.scope
 .....................................................

Reviewed-by: Christoph Lameter (Ampere) <cl@linux.com>
Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
---
 kernel/sched/debug.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 8ae255a257a2..f4035c7a0fa1 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -739,7 +739,7 @@ print_task(struct seq_file *m, struct rq *rq, struct task_struct *p)
 	else
 		SEQ_printf(m, " %c", task_state_to_char(p));
 
-	SEQ_printf(m, "%15s %5d %9Ld.%06ld %c %9Ld.%06ld %c %9Ld.%06ld %9Ld.%06ld %9Ld %5d ",
+	SEQ_printf(m, " %15s %5d %9Ld.%06ld   %c   %9Ld.%06ld %c %9Ld.%06ld %9Ld.%06ld %9Ld   %5d ",
 		p->comm, task_pid_nr(p),
 		SPLIT_NS(p->se.vruntime),
 		entity_eligible(cfs_rq_of(&p->se), &p->se) ? 'E' : 'N',
@@ -750,17 +750,16 @@ print_task(struct seq_file *m, struct rq *rq, struct task_struct *p)
 		(long long)(p->nvcsw + p->nivcsw),
 		p->prio);
 
-	SEQ_printf(m, "%9lld.%06ld %9lld.%06ld %9lld.%06ld %9lld.%06ld",
+	SEQ_printf(m, "%9lld.%06ld %9lld.%06ld %9lld.%06ld",
 		SPLIT_NS(schedstat_val_or_zero(p->stats.wait_sum)),
-		SPLIT_NS(p->se.sum_exec_runtime),
 		SPLIT_NS(schedstat_val_or_zero(p->stats.sum_sleep_runtime)),
 		SPLIT_NS(schedstat_val_or_zero(p->stats.sum_block_runtime)));
 
 #ifdef CONFIG_NUMA_BALANCING
-	SEQ_printf(m, " %d %d", task_node(p), task_numa_group_id(p));
+	SEQ_printf(m, "   %d      %d", task_node(p), task_numa_group_id(p));
 #endif
 #ifdef CONFIG_CGROUP_SCHED
-	SEQ_printf_task_group_path(m, task_group(p), " %s")
+	SEQ_printf_task_group_path(m, task_group(p), "        %s")
 #endif
 
 	SEQ_printf(m, "\n");
@@ -772,10 +771,26 @@ static void print_rq(struct seq_file *m, struct rq *rq, int rq_cpu)
 
 	SEQ_printf(m, "\n");
 	SEQ_printf(m, "runnable tasks:\n");
-	SEQ_printf(m, " S            task   PID         tree-key  switches  prio"
-		   "     wait-time             sum-exec        sum-sleep\n");
+	SEQ_printf(m, " S            task   PID       vruntime   eligible    "
+		   "deadline             slice          sum-exec      switches  "
+		   "prio         wait-time        sum-sleep       sum-block"
+#ifdef CONFIG_NUMA_BALANCING
+		   "  node   group-id"
+#endif
+#ifdef CONFIG_CGROUP_SCHED
+		   "  group-path"
+#endif
+		   "\n");
 	SEQ_printf(m, "-------------------------------------------------------"
-		   "------------------------------------------------------\n");
+		   "------------------------------------------------------"
+		   "------------------------------------------------------"
+#ifdef CONFIG_NUMA_BALANCING
+		   "--------------"
+#endif
+#ifdef CONFIG_CGROUP_SCHED
+		   "--------------"
+#endif
+		   "\n");
 
 	rcu_read_lock();
 	for_each_process_thread(g, p) {
-- 
2.40.1


