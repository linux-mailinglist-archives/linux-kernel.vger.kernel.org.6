Return-Path: <linux-kernel+bounces-317784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D4F96E3C1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 22:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECC3AB211E8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 20:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0F31917DA;
	Thu,  5 Sep 2024 20:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="lBZC6pjg"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11020118.outbound.protection.outlook.com [52.101.51.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3381F158DC0
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 20:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.51.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725567148; cv=fail; b=Dku1VV7quX1jugXnuZzFk4tub2Yzrg/9dgazWg2AP9fbPwdl7Qp6MkJlzZaf2Hbm2t2mpwVi8BINlUbJWGrr7YFJ9uuQmcSCx1lKNIRLHr/wpK8gYeZ0Xs3X+G9T6eENhCU1ebIERQ7ZuwsbuusQtfVMR7vMIH1w9W7rBL99vP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725567148; c=relaxed/simple;
	bh=IazUX2VuiohaHdb7RGwPbfaUBibXxqFq9M0dAZa6a7s=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=sjnPi+gsXthfN9eNzEsHOXONa0GRvdZNWF/gN1Xsia8b3f+5rNwqnCyWKjT2JQ6J4FsFpWXOBUydpIMFzhC4iv7+n2L6rD3FEvkUcI7M/+Of17lUV9HaLQ3xT1ZIToelhu954Dxq6aTQP22K2jwo1fXtrMikIMTfYA04YwQwLh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=lBZC6pjg; arc=fail smtp.client-ip=52.101.51.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sKwCMW5XIefi2iifCG9B7U7ctcqiWl8It/nJ8mXllVEXYtDFmPItk5+b/kRULLaOHZuT1KhV66SeSF5tVHAVnR+1DzN1g15Tf98xSHoCdJ2oh3FWg4Z4upJ/NJrpL3eGGIWhtKiTsR0mD3Sggw+x8PEne2XjjPbjsbra3qa+1ZZDNgJ6M6+BABu8PIn98a4+JUfD0ubV7Txa8xvTAgkm5gBOtSZfkwVNXtuliyf6OT+LMtBCih4C1aYW7XLe1ScAai6Hj/cq0NNZ5kSIfQbAVVN8OYSxIuJcPT4LRokzPfytMIx83xDURIuhQswQUGPctprxtv8LVKC4BZpKTKchxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSNxJ8LUQwMH8rCbEfcld9gYeVGcUo3BUxEIXnQkFeg=;
 b=v9m1XWP4H9mu/UFfVDe78DGuCgMIcWP/6Qre/4F2N/e+Jrj4du598zAIH8HiK0aD2d4gu9N5IuJ/z67oxe5WJO4HPpAtIXsZWdTIg9s32AsoSvx3Rlq1fckq99Yk5Qka8vd3sCtIRM3a8Uoy9SacqLgR4vN1lwl2+FLceSJW4ExWBpe+xHFOVAguwmC+iR7hh7vi6xVVuvY5Mfv3XtUQ0fOd8eunfR47TnMBaHREmercifaBpfjKqSq674Rl2TrZN06tzKD1E/bo2NQdfu7AqHqbgTYKvef0Im+la7/CUy5fKrscCJeRtw4uFoeNVdr7XpnMmjNGtTbVGwLOxvU4aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSNxJ8LUQwMH8rCbEfcld9gYeVGcUo3BUxEIXnQkFeg=;
 b=lBZC6pjgXFvkxDe6EUebfH+o3L3JhZJE02Y/BL0vsNX4RS41gWm1Kl2SYKzNUR08iLvaLxffL/T84d6uLPpsgafEz3LUOz91t4/n2gOBi5jbXLO7FMtk9JDyyWcgny1xGBWUb95JPV3nDaz0EIyZFwRMvjcucazaSCnQpfDpf6c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ0PR01MB6237.prod.exchangelabs.com (2603:10b6:a03:2a2::23) by
 PH0PR01MB6280.prod.exchangelabs.com (2603:10b6:510:18::6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.28; Thu, 5 Sep 2024 20:12:20 +0000
Received: from SJ0PR01MB6237.prod.exchangelabs.com
 ([fe80::ba9b:75fd:46b8:c984]) by SJ0PR01MB6237.prod.exchangelabs.com
 ([fe80::ba9b:75fd:46b8:c984%3]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 20:12:20 +0000
Date: Thu, 5 Sep 2024 13:12:13 -0700 (PDT)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Robin Murphy <robin.murphy@arm.com>
cc: will@kernel.org, mark.rutland@arm.com, 
    linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] perf/arm-cmn: Improve format attr printing
In-Reply-To: <50459f2d48fc62310a566863dbf8a7c14361d363.1725474584.git.robin.murphy@arm.com>
Message-ID: <85762d20-f615-9a77-3f1a-ce664a2e4f22@os.amperecomputing.com>
References: <00634da33c21269a00844140afc7cc3a2ac1eb4d.1725474584.git.robin.murphy@arm.com> <50459f2d48fc62310a566863dbf8a7c14361d363.1725474584.git.robin.murphy@arm.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: CH2PR08CA0009.namprd08.prod.outlook.com
 (2603:10b6:610:5a::19) To SJ0PR01MB6237.prod.exchangelabs.com
 (2603:10b6:a03:2a2::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR01MB6237:EE_|PH0PR01MB6280:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ff3f7f4-3e81-46a0-68b1-08dccde70bc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2QyQaGL/jjqfiLqFvmja37Z/rmlk+8Gp9DYziD7JVr6Kh1wmSm7M59nBK1Rt?=
 =?us-ascii?Q?3oXhH5tf4hRZQecVPDrYUniGdVqjTmpUJyD7BSvpd4nuuuKRoGHsy0BR3zZh?=
 =?us-ascii?Q?ZuwOnF+EBrxNnpheaib3F3syTuad+3+8fqi6HIJSEI3WU7JId4IuOBqEG3QE?=
 =?us-ascii?Q?kus2Q9tSa9XKlT1wK7kyCmaxVOdDQ37pXHfAVLpLCLQ+vtxnURJdjMQSQGlx?=
 =?us-ascii?Q?j0Ch/ED25XUdnALyA3OdZcq5OmyYLNM+i2pY21+v6M5HBH5uBrIVXlnqix8R?=
 =?us-ascii?Q?aovenij/Suw+0Ho13ofmxyMzCfXT5TXdjRCSXoyPxqd6bLGuLKVpYYgjuTUQ?=
 =?us-ascii?Q?1Dlar9qn46PBqvS5WNJ3KxJAPQ5uFikO4QVclcxxif9BTz+gBUoc1nUJv0WU?=
 =?us-ascii?Q?Btz6usy3DLBz3ZK0a1Bgsw82ENtDqJj+D7Sw5vZtNEj/trDZenZAmd4Wci8O?=
 =?us-ascii?Q?sV0ZhpxHFPBQjf9hUA0ZcHgq/Q4uE4D3Z3Hz2vGXA7y6xxquB20oiUi7P8RX?=
 =?us-ascii?Q?uZc95TO+H8ZC/STIHQ8iyl3dGOdJnzDSrLSNd+T9sl2FnwZYTbsoRtZNyXHe?=
 =?us-ascii?Q?16Whqm9IOoBm7ZrnurQPpD0XJhCEFdwRalO5JArSdWnahTl4qo/1/73KGF6l?=
 =?us-ascii?Q?NjHClsvP+KCb9q1OfnZpisbo1qtWX5bhXpMG4oLkoIVApl0oUhNNyRAa/sFL?=
 =?us-ascii?Q?qhIpyJIv5v+f4uIPiNru2xG3l9ySB76oQyHYSUJVnUAfJT9u94p9abWFU71O?=
 =?us-ascii?Q?Nx3JMgKuFKiaE1S5MUchHfdM4lK7egGji8fhAknbci0GocSd1gFhM+d4+3vq?=
 =?us-ascii?Q?2343VmqAPR+CO2Kt7JeY5BNqC3NSuUWeHNezDlWdqxOjXTsk1GqlWdetUGQb?=
 =?us-ascii?Q?2xPXpUg6CUPX5BVi1WPwDia5QuYBvAmfyC/dptyF2eqi3mo4KL6r05X/AMVk?=
 =?us-ascii?Q?4Imb4RKybilhGDsBN39Kj/4ftS0eWXHZm+BDALH/fWJBhwt1PEC3snCc5Tup?=
 =?us-ascii?Q?f1aXM0baHGIQ1KNrV6HpfmpP1Z3IgvR881NN4T0iqdo/4rOYxUOolin8PKk2?=
 =?us-ascii?Q?T2Ab5L17cA0xGzcQ5ZIYkp0T86Ei7cGwLDh0D057sJ2t34ZC3GJ9WYIpXECE?=
 =?us-ascii?Q?PRTGMREQh4RFwyahcFXYTwDTFQsHQIsEM+tRo3j6iU1scDEUbrh1aINDN6Ey?=
 =?us-ascii?Q?uqMBFsG/wDw14rLQO5qBfIlmI5XjXveDrfrZ2bJWj9hHm1z16WxOVyW+DVic?=
 =?us-ascii?Q?3fy7f8s6MDqPeDInODxdCH5Z6G3/ZD0gpFl9ZHmCbNiB8CHDaF2gkM8n4W1S?=
 =?us-ascii?Q?teG8JOwkSnjE0xW69GWn0t1MoZgtmUztSdJpZQZU2KmNoVh+zzk/ycADQTLR?=
 =?us-ascii?Q?tcKbxXS7vp5l1qYfHesiC9GmQD/SSO6Ct6CpmNoadpQQw2RNYQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR01MB6237.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oheIKWsxeezDFLFtSJmiAn7OayCQpv76pTXZsL0FE+Ldy1WD3OEyYCkK1IFN?=
 =?us-ascii?Q?q+s/4wJEc+wD84Pg72rtns9KrpCzPxpqBZYJ4PjXv/anRVYZ8zn/KoZBass3?=
 =?us-ascii?Q?g67Ic1oq4UQA/tshPkosdB11RM593BxJs84vgM5pQtRmL6KeIwipKEYYq/7p?=
 =?us-ascii?Q?FPk2LB5gf3GbbVpPC6zqylR5hiWZcc2h1Mo+dJpHpyAZNdRYmlzwl9YpB55g?=
 =?us-ascii?Q?enI+fBtSziFV1an+5ZhV1cS5CDNrLHZYylwkkX+ul0DhmNYopVoXHbKio1de?=
 =?us-ascii?Q?H9vUw+bAmWsH9Dcm9envVa1cr6orqOCp/vf3fWIEzIPRiG66ImpysVdLgqXD?=
 =?us-ascii?Q?33yncB0UInlCjHuSy3qWBHiypzTLIB4OniD4mpOgmWbMPeznqDzGeKxADYx+?=
 =?us-ascii?Q?f4iysWrSTroz+YNgfMcYKp6BzRIbZhk3iVzrW47gC85AyTM68fA0pt0DGYfy?=
 =?us-ascii?Q?njFYd3Gm4M+P+3yGjIyVQ7uomjssEQRKRvY+Kk4LgNcWSSANZv49MLogFs8c?=
 =?us-ascii?Q?QWk1K7EJwxVc0XAL7+Yx0x4/ObmEU3JFmRvkfwvJVIYHgHI9JHu+tw4gD4Uc?=
 =?us-ascii?Q?McZwSbWONHhldo4kdovKhHBJtTM4U2oGeuIpUipgXINqJl+prfRjPmMAd97K?=
 =?us-ascii?Q?6UGx2pPgRInLF4fRcIMYiSDZrESoxz7bQVPYbz9NsyKnS2ENahK7lWb9qykT?=
 =?us-ascii?Q?nkzBcv0L2Am/ikbN3XJ8i1E2KYeycaBdznxorXOw9EcpmDL8OJ+/7mOLH7Xs?=
 =?us-ascii?Q?WvrbLrEB4mEbHyHBE3KvxU1g/nOBjpZx4zWt8J0iKsCGdQFaIrQH/bTBqFTN?=
 =?us-ascii?Q?zugGlA6typcdOzAicqR+mNjpIbfBK35hAkumsA0qUcDAJv2Y1wf6BKVADCRn?=
 =?us-ascii?Q?tQG/tAUi584M4H0c7EHq9zrZNZsX7mW2iWIjwIZCicqH+ecygGsGTUJNOJxt?=
 =?us-ascii?Q?iVI1u8uCUJcGH5AXWZefZe9RvaK1SNaW5S3GtwQtQOj409+NFhBgIR5wwjRL?=
 =?us-ascii?Q?/d6YTRjJNMtgNHQiBYxT0Znra06NPRdm3SaRXtzrFDqvhV1yK1q507xMKIQd?=
 =?us-ascii?Q?cX4s7aB8EFOU8URGrycCQVHyXOO4XHLtJQ8ovUf2v3DIZB/ox9nnRUwXL8gq?=
 =?us-ascii?Q?XyRDokAA9/Q7fwEDbcLK7tlMP2DRNoJN8Yp5t4kZ+XtzReCrOc+HU/LeVc91?=
 =?us-ascii?Q?sgU9E8thdQzY1QAK0Ee2hk/1i1RWJ6G1UaLEWEiUi6xShAVIGRe5L9aTMxIu?=
 =?us-ascii?Q?0bBKjxU0NOdmws2zF6crLYn+XTaQt2eKNV3ULZwY9QE+4FPgI7OGInENMhDq?=
 =?us-ascii?Q?vU8qAjCR4x439bXoSilGk1kBnjLTRAv9skbV2ROuWMUlaYz+xYMyqT92f5HE?=
 =?us-ascii?Q?hVzsQme1XPeE6SFTVjdH7VRUonBEjIHohee78qGKs+XOaXYrce87xsFQ98Zy?=
 =?us-ascii?Q?Fy2fXhpIBVD6igu7znMjdpXzZYghq4HnyotmQpYpwHQDiysBKtndh3clZPP9?=
 =?us-ascii?Q?off/rCNeX299jdm8Kdt8udSVBHhmAXbmNbSOqdZBvZZY3i3eTWfz6b5K1yVN?=
 =?us-ascii?Q?Mz+XTnHQSf7awBBn9VokjOgrVh9fd0WANLWVetCjXIcwg5L4ZVl3jmHigFw+?=
 =?us-ascii?Q?Mdntb7OSyfX4U4o5eGjuZTc=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ff3f7f4-3e81-46a0-68b1-08dccde70bc3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR01MB6237.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 20:12:20.1432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bpyp8s9iVDa4Tix6Rp4zVNUBFot67yfRf3iuUUJQf82gzR5XWKr11BtWxP9mQwvaKTOcUdlFnERIE9T6AzPWGuOGJ5rhNc3pRFk5PC2pv58encrbB2b7Lr/DKFT6Ozlv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6280


On Wed, 4 Sep 2024, Robin Murphy wrote:
> Take full advantage of our formats being stored in bitfield form, and
> make the printing even more robust and simple by letting printk do all
> the hard work of formatting bitlists.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

--Ilkka


> ---
> drivers/perf/arm-cmn.c | 8 ++------
> 1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index 62d4782da7e4..397a46410f7c 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -1280,15 +1280,11 @@ static ssize_t arm_cmn_format_show(struct device *dev,
> 				   struct device_attribute *attr, char *buf)
> {
> 	struct arm_cmn_format_attr *fmt = container_of(attr, typeof(*fmt), attr);
> -	int lo = __ffs(fmt->field), hi = __fls(fmt->field);
> -
> -	if (lo == hi)
> -		return sysfs_emit(buf, "config:%d\n", lo);
>
> 	if (!fmt->config)
> -		return sysfs_emit(buf, "config:%d-%d\n", lo, hi);
> +		return sysfs_emit(buf, "config:%*pbl\n", 64, &fmt->field);
>
> -	return sysfs_emit(buf, "config%d:%d-%d\n", fmt->config, lo, hi);
> +	return sysfs_emit(buf, "config%d:%*pbl\n", fmt->config, 64, &fmt->field);
> }
>
> #define _CMN_FORMAT_ATTR(_name, _cfg, _fld)				\
> -- 
> 2.39.2.101.g768bb238c484.dirty

