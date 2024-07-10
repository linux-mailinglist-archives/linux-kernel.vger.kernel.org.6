Return-Path: <linux-kernel+bounces-246908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EB292C8CA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 05:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A964CB2197D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 03:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D2017C61;
	Wed, 10 Jul 2024 03:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="rAra8Aej"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2065.outbound.protection.outlook.com [40.107.117.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9EC10E6
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 03:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720580437; cv=fail; b=gyJnx7tq+f0YedCLWOpNYVA+jjXU1D6cP68Eo8u65gNdc/0f2X7kgoiAkJzazeKVFS5YQmdDgzNcWdyLb/HoHV71CGx5RV+d4/dEF12TrPfDhBB8SfT3Sp61tTwzQn8coZs5eRlhxXCmi6Zh6kxcZS/eXx4kVPcDWAUqZHqhGqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720580437; c=relaxed/simple;
	bh=bvYcvDNI3gj+yL3GlEmVZsdPRyr9FmA48ONl28i0NCw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kxydlwfITznQsU5UbuBJx38YMQF1Gijb2WYgUZTNaYHWOwk/L+dGSelBnElzU6hLKHwDXGkMaScq8F/ASG73B5FtVaroA9J305XuwJ9bR10+mkD/9LJV6u6DauJCgK8fX0ksS0pgAHhoe/Y+weRrQolDhqEq0s2h/nmWHRn9gSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=rAra8Aej; arc=fail smtp.client-ip=40.107.117.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G3uPssDhVUBCV9VWJ9IRJl2mRq58KTN69VfNDWJdIeODrtK6ykUwwgqZgMLgt/5IQlNSD0HYj7uEKXh9RYn9Wn5sQIKj9t8l9StrDoCFQa2yhyQwE1vDE+0DstKAOM9vMRQ4T7SGHVcR7j3OfdtWrDuppaDUbeUT5zlmrfIeYXyHUnL3RiIjMNYWnTUCG9VV1QWc7epeekZGh7syOeCA32QTE99+B5Yax0HC0kg9HRjk/GV9GGCdjheY/w20xC+oEDSPVGiXHHH9HCMaiHdFNNi7N/KjFD2JzDwEU8RTMApv4n2fDxNIRvBAhv/eUXNsuGdxTFgwZo1N2tozCdpYCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bWWNqK8pXgK0eAdo6WhK+EsnHwPSAI7WARq3E3sMOrM=;
 b=LTFr3UnWgtgiDmZOypcSrYfVtMzy5V0Jbq0lizYp5CjiKclv1L/OptGpxy9GM0MJ0QCY6NYkse9wIUFn98xBg0sSztbwRxMJzgi+LTh312I6eOafH+7hlMhY3VFGwajQyThnAN5c8mLAsMODgOJG6tknpM/QKUXUMPT8tjdgjudAOYF5uod4WbDzZAJyyXtbrUXGdwXLlNCl+WZwgJn1arEeGiFeYfNu5Nq41/ukJE0uXZvs+4MvAHirnWcVPGVDd8cPjJ5gHXPK7Re31zZJUf35e2WuK/2aitzrQOZqAFO7GxqnAR5dGYj5P5UNQ/fSsBkyJ+R/lQvUvh65NseZqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWWNqK8pXgK0eAdo6WhK+EsnHwPSAI7WARq3E3sMOrM=;
 b=rAra8Aej+aYilesNlSdxGMRe8LRqxJWdmWLVWOBgl71IecfkUR+rGp2P5WFpkMesAshAx9WPCyGlIkCfahcwgdtxZ9BlhZalGvg8xEld2ow4iQ3mTXQ3/RjUbpE93IW38wY7BHoJmZ3RxqDzpG6VOM6Yn1frtmFnzJ1zELB5W3EZMBOXlvZ6AxRZjP8Lyeh3KQrjLsIcJkztUnwZC0NeAEMsLUIx3tkVQUb1moXheQknQJkRlXx6984jKCirSL5zKXTEJVlv3VC2tX1z+sBkx1AA8hB6cscqbH7LUwlmCwUi71Ahy4SnS9LbP/kqheEv3X+NGRt0yuk1adPa8Clm7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by SEYPR06MB5468.apcprd06.prod.outlook.com (2603:1096:101:b5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19; Wed, 10 Jul
 2024 03:00:30 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 03:00:30 +0000
From: Zhiguo Jiang <justinjiang@vivo.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Barry Song <baohua@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: opensource.kernel@vivo.com,
	Zhiguo Jiang <justinjiang@vivo.com>
Subject: [PATCH v9] mm: shrink skip folio mapped by an exiting process
Date: Wed, 10 Jul 2024 11:00:21 +0800
Message-ID: <20240710030021.1657-1-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:196::22) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|SEYPR06MB5468:EE_
X-MS-Office365-Filtering-Correlation-Id: f25301ea-2612-4dca-adfc-08dca08c755e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0shDE7Jk7nxtoFAngfR07UQx/m8ky7hy/HCdL8oWvMjQ4IaKNI+kX8+j15WU?=
 =?us-ascii?Q?MYygcdngUiXPc7Fk3m5yXdQlIH07//0f0dWg879S9CeJEDd1l7oh8PbwggaP?=
 =?us-ascii?Q?/Yz+4e0EemSd5ujvCH6J3y5fj7Iy4ch2WZTyItbOp43v/BnGF3eIa9GkprwG?=
 =?us-ascii?Q?gphKszdSSiCb+xV6jCBzucsSR8cpbeBKSLJnRe4TPRxGDZP66bqcOU7Dl7lg?=
 =?us-ascii?Q?0qp6gZQ/AshF4/gO/RT8uV21tRD/YcYwd73nyZ8JElrWIVjI+NAXzkm6/W82?=
 =?us-ascii?Q?vqwOmgvoiB0ybwXNXMPuQ5LwOLfo7EjYKnw5jE3S7cGtFUIAs0lWhLrSo46p?=
 =?us-ascii?Q?YlIPUmDDrjPpEvP20wYD5p5NqQgcg+pcd89PlPVLV7sBhkgaXUPfePzkRHwz?=
 =?us-ascii?Q?CTQmJ1DppjD4zTYrX+tfzeab5xkaIcK7zGfY1ER5LSARFHgAnoWkigNdxybq?=
 =?us-ascii?Q?ZioveQ7Osr/oUT2Eti+HI6VWgZpt9jFgpw75/BUPTNRBw0wHEgtbfuHqEeKx?=
 =?us-ascii?Q?RgvweFyL2pL7DGEd5cCnn61XY5KY1DR8oLqXok3PsOTcIn3CNfjtCswfEHSn?=
 =?us-ascii?Q?IBlEjyslNh5E0F7Ga/21bAdG1Z/A+aztzTXUxjHeZCJaD7bWNjTGK61DZQvr?=
 =?us-ascii?Q?ZFFEkr3YTUiuCd0tGpcQze1IApe5q89q8Y563CqZpy6iWnVnN+OkEN9yiYAV?=
 =?us-ascii?Q?P6CXfbBLJCi3RzvwOo2dqkhr/k/KqjJeiR64IBQIl90ozPOQ1XvfzADK2y/f?=
 =?us-ascii?Q?Ee/dPXpnmRlbmv4blv4HwjnnvIZnJBinBUo5eE7OfMFIJ9rkkcmYtLeBvptq?=
 =?us-ascii?Q?CIjW+wUq89GDZOQytVX9/WUVR/3AmfnSMeSiCFRszZ4cdFndGuUU+IFfrAig?=
 =?us-ascii?Q?R2/UuLbVia7MWA3IBjVC4822Kw318bdtkSrlSitzKqtDFFBycBmsAMN/JH3C?=
 =?us-ascii?Q?A5kDnOiiIgoXpIW7KOTcLrkOjoVaG6poGf9wwhST6yPWz7vYfgpUiYf3/J73?=
 =?us-ascii?Q?R0s4GWBvBVFgpVAb+8uXKL6u8IVQxV/1He33CU8H1AM0vPN8X0W0JWkzE6cf?=
 =?us-ascii?Q?IuhM9/mKNovqWl4jz4SrBCcNTb9pnw+T3IjXTv8hPhglj3Docg1fUFtEQNDT?=
 =?us-ascii?Q?5WBxR7V/HCJxiu4eRDnXLnjH+EMabwFeOitHH6cds30Oj4fiTpfHbVnMh6gD?=
 =?us-ascii?Q?p2GO3fGmtKLYs7zZTwZdAGwl3Iwv+8QgFrAsdeqDPL/pkPNko3Ry4ovKaKCF?=
 =?us-ascii?Q?eSajmA7FURQ7ENjgCjlh24x5ADiZ6vwtkd6P0PPgiUN55EwojTxq/YooYd7i?=
 =?us-ascii?Q?eHFxvxr0t6dLKAzo07KjfEPqYpbX3tx1/Oy4bZPeaPWMg364nubHMDh5o3y9?=
 =?us-ascii?Q?BQFX2Jg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4VYqNqikwgnEouOqWyjYtGr7cLvDpVObLVbhR9jCmgNcdOVFb4qJyegKhjCu?=
 =?us-ascii?Q?cZXFv0pjkNv26kNsfqdBxC7ii6I8OyV34OF6SGiN4lYGQ/9Hv8+aXdgYOnRK?=
 =?us-ascii?Q?69HWWd74ArMSfQan4dq3/mB8F9NEi8K2FHJajYa5GXYVdxxlGFN+01BpcVJo?=
 =?us-ascii?Q?bLp0G035UVpI2wF5ZHadaZbDfH/LSl5V/Y7Mlr3zEdkRv8nqHiOkfMhXkMb+?=
 =?us-ascii?Q?kwpspMjPqmYqVzNjdj98zjT132VU66VuI+/6x9skxnRsyWwX99s/oLbqyz0Q?=
 =?us-ascii?Q?u5KN+zvW3PmRua2dAjZ06fzLssUVukIpQfzzDMGd4uF9hFSo2NxSoYPSvEkm?=
 =?us-ascii?Q?n4glkNJkdgbqdW+VIf08VVvzGptyO9wo1LLg01GdGd/qRCWLwyv6q3IB8hOC?=
 =?us-ascii?Q?XA1DjOicCZpjhfdR/iaaL2h+d0K47VXa52dh7tdQs6pe3jmA+oHBipBC5r61?=
 =?us-ascii?Q?p/OShfXShzyftG+VNT0H8Fe3liLHDO2i533Ip+QKkWUo9GIailfujU2LguNh?=
 =?us-ascii?Q?WQWbTt+eQUFdvtN0+37jG4wz4fTiwtI1HWzV40xKhWt95dWN2MblzP7mYylz?=
 =?us-ascii?Q?G/ZWm+JpyhynrhPE+8d9ibf9HE1oLX4iFghx8pFSEoHV7wXQKXO5O7Bna6+y?=
 =?us-ascii?Q?7VM1oa1HOWb4BJZtzpjgZFbkvVAMIFlzGSpyxYwTFDwPNc05jGBsVRsLT86K?=
 =?us-ascii?Q?2jLdBo1H4mIy3t7TaF91XJee6pBZnxpu/rQKS6owo2e5nhbY1DmTY/VVeIIA?=
 =?us-ascii?Q?k4P1q4vpg/ro+fr9SJFv/ukqWDXZ7b859JEHw+Gj85PRQhSXIGmtOJHmGL/A?=
 =?us-ascii?Q?l0VXdiRLfFw5zRnAF+Fq+aJ/f1xh9W6XQp1XCBnRdZmCg7sZFIPZNDOP2Bqn?=
 =?us-ascii?Q?uuTzOS1lRiqchGXQNOxgNy4/WLLzwYjS1qu0YA1QbMLdAhoPtnXPh7cpWPSp?=
 =?us-ascii?Q?xBcoexgaUxcLXzv9CI13atJe/BXKf/o0illUps5k7H4FkYrRXNUtLLkD5PLH?=
 =?us-ascii?Q?hFqwGDFSb9DW3c9DyQQBezC4eoSTEp2ft3dSnAqvy/k+GniOAS1rOO9B7zIG?=
 =?us-ascii?Q?883x6NRi+1WE4r17WKMjG6RtOoSBRhx2lo+DP3u9OzmenM3bRx/23Kjr+IIx?=
 =?us-ascii?Q?rNmywB5Bpg9fKpMimH72LlhPhW6yNtSONe0fbBk/3zumEmyhiAbeGdmbuQ4S?=
 =?us-ascii?Q?L9ezwIusx/4rwP2LD9k5PPcKHIgXOv/ztxd7y0WNvoZfrM+4vkq31wO26B9L?=
 =?us-ascii?Q?RvRB4zOcBYsfvpa0swuZsJ/XPRFmxmunNPGB7QK+JvM3Z1gHnwNPKxmxvpP9?=
 =?us-ascii?Q?fJUZmDvwdKdtzldgE1iX1M3MrUsuZeJfWwPjLgFTpiRQeu+sScrimV3cyuyS?=
 =?us-ascii?Q?FKnECy+rq/MUG5HcWO8KS9DIAElsjwBdbsvb01xb8XvHADF43jz0kkP7QngG?=
 =?us-ascii?Q?x1j0rG9oxMZesURLiISWNtnV3JV3fyyAqgF5ByeFz/hj3ZqivLxRveuFi6kI?=
 =?us-ascii?Q?vb7ZgHtmUOTsA5qK8e7bU3jvdZTMIPeNI8f+QpqzBwed/rqI6b1Dx1+DBLfy?=
 =?us-ascii?Q?a9mM9S1MZiazYHJEZU3C5xhH2vcrTTgkpfUJi0Vk?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f25301ea-2612-4dca-adfc-08dca08c755e
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 03:00:30.6019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ZLj8DxPRhCzk2l0jzgvheOW0eevWhYO0gLlMWx+hEqPwChz4GpO1IET9BNf5b3HZVdxCWxRu65Ke+VpDVpj1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5468

The releasing process of the non-shared anonymous folio mapped solely by
an exiting process may go through two flows: 1) the anonymous folio is
firstly is swaped-out into swapspace and transformed into a swp_entry
in shrink_folio_list; 2) then the swp_entry is released in the process
exiting flow. This will result in the high cpu load of releasing a
non-shared anonymous folio mapped solely by an exiting process.

When the low system memory and the exiting process exist at the same
time, it will be likely to happen, because the non-shared anonymous
folio mapped solely by an exiting process may be reclaimed by
shrink_folio_list.

This patch is that shrink skips the non-shared anonymous folio solely
mapped by an exting process and this folio is only released directly in
the process exiting flow, which will save swap-out time and alleviate
the load of the process exiting. 

Acked-by: Barry Song <baohua@kernel.org>
Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
---

Change log:
v8->v9:
1.Update Reviewed-by tag information.
v7->v8:
1.Add tags of Reviewed-by and Acked-by.
2.Add #include <linux/oom.h> to solve compilation issue.
v6->v7:
1.Modify tab indentation to space indentation of the continuation
lines of the condition.
v5->v6:
1.Move folio_likely_mapped_shared() under the PTL.
2.Add check_stable_address_space() to replace MMF_OOM_SKIP.
3.Remove folio_test_anon(folio).
v4->v5:
1.Further modify to skip non-shared anonymous folio only.
2.Update comments for pra->referenced = -1.
v3->v4:
1.Modify to skip only the non-shared anonymous folio mapped solely
by an exiting process.
v2->v3:
Nothing.
v1->v2:
1.The VM_EXITING added in v1 patch is removed, because it will fail
to compile in 32-bit system.

Comments from participants and my responses:
[v8->v9]:
1.Barry Song <baohua@kernel.org>
No, this is a disaster. Please ask someone for help before you send it.
Neither Willy nor David has ever posted any Reviewed-by tags.
Please do get someone to help you. Stop posting like this!
-->
Update Reviewed-by tag information in v9.

[v7->v8]:
1.Barry Song <baohua@kernel.org>
You should have collected tags such as reviewed-by, acked-by you got in
v6 while sending v7.
-->
Added in patch v8.

You didn't even pass the compilation stage because you're missing
'linux/oom.h'. It's quite disappointing because I believe in your idea,
but you didn't even build it before sending.
-->
Sorry, I overlooked the compilation of folio_likely_mapped_shared() added
in patch v5. Compiled and Updated have been compeleted in patch v8.

[v6->v7]:
1.Matthew Wilcox <willy@infradead.org>
You told me you'd fix the indentation.  You cannot indent both the
continuation lines of the condition and the body of the if by one tab
each!
-->
Modify tab indentation to space indentation of the continuation
lines of the condition.

[v5->v6]:
1.David Hildenbrand <david@redhat.com>
I'm currently working on moving all folio_likely_mapped_shared() under
the PTL, where we are then sure that the folio is actually mapped by
this process (e.g., no concurrent unmapping poisslbe). Can we do the
same here directly? 
-->
You are right. we might use page_vma_mapped_walk_done() to bail out.
(Barry Song)

2.Barry Song <baohua@kernel.org>
By the way, I am not convinced that using test_bit(MMF_OOM_SKIP,
&vma->vm_mm->flags) is correct (I think it is wrong). And exit_mmap()
automatically has MMF_OOM_SKIP. What is the purpose of this check?
Is there a better way to determine if a process is an OOM target?
What about check_stable_address_space() ?
-->
Sorry, I overlook the situation with if (is_global_init(p)),
MMF_OOM_SKIP is indeed not suitable. It seems feasible for
check_stable_address_space() replacing MMF_OOM_SKIP.
check_stable_address_space() can indicate oom kill, and
!atomic_read(&vma->vm_mm->mm_users) can indicate the normal
process exiting. 

I also think we actually can remove "folio_test_anon(folio)".
-->
Yes, update in patch v6.

[v4->v5]:
1.Barry Song <baohua@kernel.org>
I don't think this is correct. folio_likely_mapped_shared() is almost
"correct" but not always.
Please explain why you set  pra->referenced =  -1. Please address all
comments before you send a new version.
-->
Update in patch v5.

2.Matthew Wilcox <willy@infradead.org>
How is the file folio similar?  File folios are never written to swap,
and they'll be written back from the page cache whenever the filesystem
decides it's a good time to do so.
-->
What do you mean is that the file folio will not have any relevant
identifier left in memory after it is reclamed in the shrink flow,
and it will not be released again during an exiting process? If that's
the case, I think we only need the anon folio is skipped here. 

[v3->v4]:
1.Barry Song <baohua@kernel.org>
This is clearly version 3, as you previously sent version 2, correct?
-->
Yes.

Could you please describe the specific impact on users, including user
experience and power consumption? How serious is this problem?
-->
At present, I do not have a suitable method to accurately measure the
optimization benefit datas of this modifications, but I believe it
theoretically has some benefits.
Launching large memory app (for example, starting the camera) in multiple
backend scenes may result in the high cpu load of the exiting processes. 

Applications?
-->
Yes, when system is low memory, it more likely to occur.

I'm not completely convinced this patch is correct, but it appears to be
heading in the right direction. Therefore, I expect to see new versions
rather than it being dead.
You changed the file mode to 755, which is incorrect.
-->
Solved.

Why use -1? Is this meant to simulate lock contention to keep the folio
without activating it? Please do have some comments to explain why.
I'm not convinced this change is appropriate for shared folios. It seems
more suitable for exclusive folios used solely by the exiting process.
-->
The skiped folios are FOLIOREF_KEEP and added into inactive lru, beacase
the folios will be freed soon in the exiting process flow.
Yes, the shared folios can not be simply skipped. I have made relevant
modifications in patch v4 and please help to further review.
https://lore.kernel.org/linux-mm/20240708031517.856-1-justinjiang@vivo.com/

2.David Hildenbrand <david@redhat.com>
but what if it is shared among multiple processes and only one of them
is exiting?
-->
Modify to skip only the non-shared anonymous folio mapped solely
by an exiting process in next version v4.

[v2->v3:]
Nothing.

[v1->v2]:
1.Matthew Wilcox <willy@infradead.org>
What testing have you done of this patch?  How often does it happen?
Are there particular workloads that benefit from this?  (I'm not sure
what "mutil backed-applications" are?)
And I do mean specifically of this patch, because to my eyes it
shouldn't even compile. Except on 32-bit where it'll say "warning:
integer constant out of range".
-->
Yes, I have tested. When the low system memory and the exiting process
exist at the same time, it will happen. This modification can alleviate
the load of the exiting process. 
"mutil backed-applications" means that there are a large number of
the backend applications in the system.
The VM_EXITING added in v1 patch is removed, because it will fail
to compile in 32-bit system.

 mm/rmap.c   | 15 +++++++++++++++
 mm/vmscan.c |  7 ++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)
 mode change 100644 => 100755 mm/rmap.c

diff --git a/mm/rmap.c b/mm/rmap.c
index 26806b49a86f..5b92c3dadcc2 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -75,6 +75,7 @@
 #include <linux/memremap.h>
 #include <linux/userfaultfd_k.h>
 #include <linux/mm_inline.h>
+#include <linux/oom.h>
 
 #include <asm/tlbflush.h>
 
@@ -870,6 +871,20 @@ static bool folio_referenced_one(struct folio *folio,
 			continue;
 		}
 
+		/*
+		 * Skip the non-shared swapbacked folio mapped solely by
+		 * the exiting or OOM-reaped process. This avoids redundant
+		 * swap-out followed by an immediate unmap.
+		 */
+		if ((!atomic_read(&vma->vm_mm->mm_users) ||
+		    check_stable_address_space(vma->vm_mm)) &&
+		    folio_test_swapbacked(folio) &&
+		    !folio_likely_mapped_shared(folio)) {
+			pra->referenced = -1;
+			page_vma_mapped_walk_done(&pvmw);
+			return false;
+		}
+
 		if (pvmw.pte) {
 			if (lru_gen_enabled() &&
 			    pte_young(ptep_get(pvmw.pte))) {
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 80f9a486cf27..1d5f78a3dbeb 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -863,7 +863,12 @@ static enum folio_references folio_check_references(struct folio *folio,
 	if (vm_flags & VM_LOCKED)
 		return FOLIOREF_ACTIVATE;
 
-	/* rmap lock contention: rotate */
+	/*
+	 * There are two cases to consider.
+	 * 1) Rmap lock contention: rotate.
+	 * 2) Skip the non-shared swapbacked folio mapped solely by
+	 *    the exiting or OOM-reaped process.
+	 */
 	if (referenced_ptes == -1)
 		return FOLIOREF_KEEP;
 
-- 
2.39.0


