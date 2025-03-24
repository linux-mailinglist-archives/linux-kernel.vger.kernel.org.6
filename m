Return-Path: <linux-kernel+bounces-574085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E56A6E074
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 18:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB03F7A0FC3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01914263F44;
	Mon, 24 Mar 2025 17:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tMk2bdMB"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5ACD2641E4
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 17:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742835733; cv=fail; b=eVuvVq7g16bZZkI/8X76ytZgBLV/qXK2XcZ2vMP+P4FkX8KunQaKSfEGquMDivcjw0Xw3x/s1JsW1JALFbo1Oq3Bw0oFDjyTeKQ3QbkwwM6h0GmnjR4mqKXznCHOGbIPPY5bbX50272ij5y2LIV7c1oi3JGSLRwyha+8Sn6GItg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742835733; c=relaxed/simple;
	bh=KMoqIj3aLP7f1rtm7u8aEeFnNmm9TH45I6vW77WOqCs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=t8aVNi5kwo8+CU+bWE8Wif8JTf8eF9WuEq6OEsRaSOTOdaBNsgqf0rkaDgzenIA7KThLjYTXbLcGc8tDHeZX2P5Wz39Gn5tmBlnwhaDhYPpm6cyEqPS3NjLY5GMfVRV5EPZ/qqxu9oVGd1LoJW/+DX5eecJdi7rIc+qnt2NKfQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tMk2bdMB; arc=fail smtp.client-ip=40.107.237.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bnxWjwayLuAWeBAre5EDio/bzapOcgSVPRMzvUX/WgEyz7IQbilqaCSfbr2+X0s1zQ1M2dvfzNISdgC2ILKZ4tjQkvy441AHtr1I1IiwQ/p2ESom5+RrJKGCPB1mIVXlNlGb72QhcPyCfKcoSAEfqeO/q2XIs495lNt7d3iatR2bI+LsP1K/N6jMHHUnRzTQ/8G0sG36kVPR8/FqW7ZLYRqa2Z5waBBy908a60QMuv7ytXZRqQ4wbCre4hA29tRfjD99ywgBIVR81p4Ad+6RfTuJ9WosAwhI8SlpqwDoW89zPiOypAPEaGG9n6GvzRBNHK6GrOUi52oUlLBypaT/cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4cY89Mtgy4BpQJI6FoXNixTE0x8Qct/NebrNy3uZE7c=;
 b=RuhpkMsysTlh/EJa7/jOyAw+nIN0B7NS1f6Fi5XG2EcYnZjji+7ZB5c3CbSYvgfbmh/MSGkAQEI63g8dpzlsUzm0ayaDiDIBtr4mn/bJw2VsYNZsrfMf7BxeWl6t8ARnyN20DJih5KA6gVrpJ/5b/GgO3d/aWVKHrTfl6NEv7Vyh0vMWI1N3bdueyEIA3Mve00njx0SJ+F4kEDjbM60XLJPGexidikuOu8MCdckbhmMyGBFUKcGXWCzuTnGCOhCfSHZ7R8lob9xcq/E369rcE5Om4oAxCDGVvCOk03QYoo3B3x0bwNCZrN7btWFN5qodmWpVivZurWz35GHjfGzj3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4cY89Mtgy4BpQJI6FoXNixTE0x8Qct/NebrNy3uZE7c=;
 b=tMk2bdMBK0NDNaO6MyRKCtBqdYVHL/nwhh9O12T6jmhrfpo50JQYxLhTqc3yC545o/MAhB9aM7SJTFs581/ViLh1vq7QWWUfQZFoi/8BTZxKbHgZyoOvf4bwpB7JOfrci8LuYQNCUWk/ei6j0DbRpbAz9XclY1F2ytoPKfwvR6Ikzdltu4kM+n58S4lxOdA99fn1LgsPB6BElYrnSC3p5Wz45eAA/0BuB1GDewW/iB+sUUkySMS/mRIMHOcar1aibvdOJ00O8k3T3W3VCkNvLAumOp+Ap3UaSD2anweF1Hq8fZTJShsnIvoe35KMx1Ra4+OCcBAgm3+GVkN0ARdzZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SN7PR12MB6912.namprd12.prod.outlook.com (2603:10b6:806:26d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 17:02:08 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%4]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 17:02:06 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH 0/3] rcu_seq_done_exact() improvements
Date: Mon, 24 Mar 2025 13:01:52 -0400
Message-ID: <20250324170156.469763-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR12CA0007.namprd12.prod.outlook.com
 (2603:10b6:208:a8::20) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SN7PR12MB6912:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d920e57-b7b7-44bd-d7fa-08dd6af59b65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+XNMkDrMSYmH5fhi37rfMLVchH5OYFwBtH3VDIshDOcyBXIjMq4iQG7H7h7h?=
 =?us-ascii?Q?dIWvH0sqcHXZcBNxEVzvIlCtBxHLZfy7OI+RROn+1aIQ9HhUlaDmQeVlIFVF?=
 =?us-ascii?Q?pRXfKR+GgT2rZzZby1UHug70Z7IGC4AT5vyLNGfstMytNivlKzHA05MqZQu5?=
 =?us-ascii?Q?GnoCCL7n+sXLoZWDZjk5BGp+6Gm21FIiXC/INp5oFRHd/Pi6/JMSvk5I0+6w?=
 =?us-ascii?Q?Vx0Vi1DBKqbzFFTcJasizzTsZO030LUdBeEl43lVmzYqyr9pixRtwj0+Pzid?=
 =?us-ascii?Q?Oddn8G3zoe34tdILmqUkGauKrVIBbjUMSR47NxDZzmHS7lP7067Oo1g8KT4d?=
 =?us-ascii?Q?84bILi4P0fzJC9/hBZMJjsuyUK5w0neKCNzl1pf+lp4bGBqAGBxlYXxIGiOG?=
 =?us-ascii?Q?R49piJVv6EA6hvmYcIUJ6N9ltcmZt/e4yvogu8fj6Pvs+lv4kEyInYw38+sc?=
 =?us-ascii?Q?hOkQrjumh9kc8Eyesb33dU+uY8utfWsoO5UGjEwMfA3Sko6ihFSYW56tgOMt?=
 =?us-ascii?Q?DVuM/GQeqloQcILlgtR4+4wudbJipWW4TnjL4VPXoZ2mA4YFq/WsUnkSXzph?=
 =?us-ascii?Q?9+YjyG1fvKNnjZSgDcfDknie8LNu2crN2eNw/I4KLkPR2VJHl7Kl1Sl64JRu?=
 =?us-ascii?Q?DMWtKs9ZGCYNyCJx2v6lnfZk1bDpZH8wzXGbV2fLj4P4XjKjBLXbYEf8PQql?=
 =?us-ascii?Q?7qJx8ZllZBOwk1y9PE+cKlbSV2M9fCDbes0Jv3t4TLDotsM1qUnXf176Mmfv?=
 =?us-ascii?Q?0utUk1HaRILsMKlAcQXVWvV0IynpqfXQgxut26sdE14JD3gi8It8VEPnjpnn?=
 =?us-ascii?Q?XEpBxCZ5wqg/l/bGiMp8O9g1rZffzZ8gH4hbx3teWUd6iruIHuFr5e0ghFYd?=
 =?us-ascii?Q?sYRDpaN15yU3rCMMqDJAQCMt3RMFJFrQgOaMkDqzrBCUDrbyU+MWfuIWCvVy?=
 =?us-ascii?Q?NiQNog/QVxK1uKH+SmCeY2N0iN7REVOcmRfNn1yzqV7mAxuUK/f4Zxl0xK/D?=
 =?us-ascii?Q?eF9Fvp9Mbo2TKs8Gt+v+kJ4iMCIbj4hTpS+oibKS+9jasyq9hg/0J74srwxq?=
 =?us-ascii?Q?hlPATyC3UfVHEuQfBN8YSYKr52Huiv41wPgepSMUl05M9HFjUPy0lRL9Tsxk?=
 =?us-ascii?Q?bSt08h28Z6gDHiA3OGVXzn5W81vsL6QRVSUZSIhxKW5NYjOI2L/6DBeinEnE?=
 =?us-ascii?Q?UON4Bm6Hq+s4PbKoJUSiV/Y2/zQz7Uj/paJEuFeBad9vvJ19vp4/24LuV6Gq?=
 =?us-ascii?Q?tilRSmo1nImI2xFmK2oWkrJKf6slJMtdDxVwaxgWVyFH7t0EzVuwOTLlTYJI?=
 =?us-ascii?Q?AAiScvsbDMpbbLKiXXQxQzKcMxMs/hOvvPEcQN4rubfgqoeEhYa7yVtFa9y3?=
 =?us-ascii?Q?LMC3/00+k7x4bix61Jbv5edXdL/z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GKM4L5yaeG+FqsRVm4BmoBtjkQRqomvnvJetvsohoLNuyC7P6AKXlqa4lRDd?=
 =?us-ascii?Q?5lNmL0vpO1kmMuew/PbAQ+LVS1sZd2tIA+zpOLd6sqpoO10fWHrz/HtBgn5d?=
 =?us-ascii?Q?xv3VFgQI6vL2br3XIZhAcJ0kjY4o/OKgvCPc7zraZPsI8r3069+ZmUP/xHsV?=
 =?us-ascii?Q?TykLZMtPlE+Sul60A/DjrNv6oi6S11US2LY9qWfGA0TTLB6ssubu4/L0wrO4?=
 =?us-ascii?Q?VLlSa/sCtELYgwI0OgyP7Fmhu2P9r+VzfSmjJ0IRqRSePl60hyyGwkt/W9WZ?=
 =?us-ascii?Q?tits7S/Ya6C/6o5+tg4BVLVD/ED/83ccM8Ju0Z1NWka0z82kjWBn9fVTQ0mn?=
 =?us-ascii?Q?ngmSMdY+esW1zVs/fvTHblLAWCLrqpKtzvx/IZGd9dc/cwE0Sk8LcMlhPqL9?=
 =?us-ascii?Q?3Mkb1F2Q2g6E/Skcvt9/Nvp8Y6n7Gam7TvxR0EcLvfKLisi+jVDReCHmrN37?=
 =?us-ascii?Q?LboiqQKgSlpaCaWIM7reBzZHula81lFir0+Bfj+dd3FkjqADV/tyas6T1542?=
 =?us-ascii?Q?49oJvc7pQUBWOR2YkhvsAOULujmz8snnKCNJ7+xAOy820tc+eOQ5cdgCD95w?=
 =?us-ascii?Q?0g7Fc2hzyyW50W7VmIl+ccJbU1a53z2E4g749HbvkkPrFUvBQdQxEug7iZNf?=
 =?us-ascii?Q?HBWft4WU9F5JWJc8FPzQjPixVSGyYblsgTrVCJJc8hTnQW3nXxVli/IjMRWb?=
 =?us-ascii?Q?BQVeASqnq07aeIYPAsTcRq2jGu/4I1jsfRbdoN3g7p7+QfNEYXl0B7Iy01yy?=
 =?us-ascii?Q?dSmbRS7NWnuxF1b0UyTolqIx3iR6WBQGJee0uMouOduURrLKZrkgMJh/vm96?=
 =?us-ascii?Q?NshoYX5RIbTnOQBEvHMuHNqXAn4uYItOHhhdr5YO+UUq9q8iSKe5tWRJljQO?=
 =?us-ascii?Q?Lk1IxWe9ctq8n7UipAjxbpAKJSMz6g8pPuqNYoHYrWC4qkRKlIxXKfBtOgPt?=
 =?us-ascii?Q?IS8U2n1hT1D+J8vHntrlnTTa7735Yy6qqCJLqKDctuMYzmcZ5UOC31qDISOk?=
 =?us-ascii?Q?3aomLKcdTt5OavpIZyKtWgl1TyWjUynw5rWIwhjDKNRGXH9q/A77RULfjXyr?=
 =?us-ascii?Q?caE9qpryYIqEom0KryWk+0FSpFwD7M0UvaPi3bCskeC07bxErSV3VuaQEXD5?=
 =?us-ascii?Q?JQHOk7K24Rui2zRNrB6z6HBwA8vtx7jAWnmRQ+PSWf1YS9Ua1aWqA8QNCYdO?=
 =?us-ascii?Q?wOE2nWhZGS/QFj4tT7O0teDaA8db7QfXZruAlx6psxXHhqUW3Ue5cg2yy3p0?=
 =?us-ascii?Q?PvKbTKc3d+LJHterTldXyioOq5RKuAU8Y3TqMi5Om2HazQ+FRDr9IhZ4OzzT?=
 =?us-ascii?Q?1BpGrD4B88NEtXfJDZRGtMKvapb35/GJmZ7cLMPm2daw90AeZKBoQwNMQsA0?=
 =?us-ascii?Q?buW9ABnapiUDiQde7iYv+ZywNmYu3KszYIOj4l6fGQqiFxIl1dYAAYU6mU17?=
 =?us-ascii?Q?3vgjQ8ZGp8GzQu/+De2leTjqA0Cw7NEw4I4wl7D9nhpiTM4b4mYdQQ84ncPV?=
 =?us-ascii?Q?DDzZIluhnNxnzuwA/eEfLXD5d8XUDRkx6jmJC4b+bBC1wUI3/ISEPQG+bS6R?=
 =?us-ascii?Q?rHHSvBjFiFBj0JIvKaAPA3kZdKRAxlUHn7PvkWBF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d920e57-b7b7-44bd-d7fa-08dd6af59b65
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 17:02:06.5002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nDQ40ffs2HLWXVPmfLuIAx9kCJAEB2Xab3q22LAIPb5c9MktHIRr+KFY1y5Pk4/So+fPUeJx5znwfivW9NWmNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6912

These are small improvements to rcu_seq_done_exact() improving its readability
and adding error checking. Passes rcutorture testing. Will send the rcutorture
wrap around testing separately.

Frederic Weisbecker (1):
  rcu: Comment on the extraneous delta test on rcu_seq_done_exact()

Joel Fernandes (2):
  rcu: Replace magic number with meaningful constant in
    rcu_seq_done_exact()
  rcu: Add warning to ensure rcu_seq_done_exact() is working

 kernel/rcu/rcu.h  | 14 +++++++++++++-
 kernel/rcu/tree.c |  5 +++++
 2 files changed, 18 insertions(+), 1 deletion(-)

-- 
2.43.0


