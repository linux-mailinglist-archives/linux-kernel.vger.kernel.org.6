Return-Path: <linux-kernel+bounces-171622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C06C8BE692
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E52E42880A0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740A215FD1A;
	Tue,  7 May 2024 14:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KQNBlO/j"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2069.outbound.protection.outlook.com [40.107.95.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9E7747F
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 14:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715093503; cv=fail; b=UbcSfWIezMn4a9FN2+dHWFigKxJI/l28Uiaqly94chZU3VKanUhCsKNLTDsvkp+y5RPdxTET7IYYs1xAoLnaFQZFCzqHiqYqBLTUzQ5xENHhSJ68lmKfUvWD6V29DTAEdFPyWiVsZ0QWYcE13ONhQ8OgPzqqKZq+lfEuCFhYM5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715093503; c=relaxed/simple;
	bh=/lJ++jDSqjbnSnPlWEuomKg7MAwf0881f1AFT2ox23Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GwfzHG/L/D1JZjRmBM65duPQvQSr746ZJlXZo9KIqTxqbL6NXEBJjCqVdjJX/TZDCTOPcyxhemef0tYh18nA5mv/3sx1+GrfUPYBMy8F0cGJIeGdpSCTrenMEOMaPa0NiU01soLmDCy+/L3pQZbPB8Pw7l0v2yIp7+wisoUePv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KQNBlO/j; arc=fail smtp.client-ip=40.107.95.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KDeAxLt0Js4wZpAxTJ1JPEyKJK+ui3S8uy7sgX+h1cRGDZ2NfXqmKbyYZ6b5A6nfGAD+Un2mEBRigmX9zxzKTy8QG1xX7QQTky1jfditd/dnENkcT/ep3vbVSHVGJ989/vlc3j5MQzIzW2r7Dwb7dD4UMC5HDkbQzRCu/3ezrTu2JhCBFn+sP1YiHUMom4FNrogFQ2pgCAdw5DPNz/uV+4ceE5eMVSSNPrxy34CmTMTCrr7PFlz2SRbwumBztSMNaK6Kvs76eljQADH5hsSQnd1XR7dpanpEZ9DTRL+4Ys6HSQKNEmyjW7ZdXkEJXBtw3mxBxF6CfIG2Uw2j0gug5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bpoVVaLb92Gq0Ty76CGYZT2kJ6mt3Vo20j25WcIy/bE=;
 b=iaQ+1fMqNw5ayB1VOOzrDijfQOhMEhKBjCAT8AW3A9zha5QL8JdN34VS0S3u1E8s6r5Cu56Um5s2RIaZqaEth+GCugJVip8d2HbkU1W+uc/y5s/cV3I7dKVJAcO189MTif9XuHNbviX5hTnVShmE+0piZpsLusRvBNyCVzMj9QFeAcPm2AefQ68vBjeBxBEhWULLi904WYXGICbazv/CBUh7WTPUnSmQfEoJQPs8C8COSn72DjRyYivreHxC4JVD0ikHlxzpn+FBFbEfmWtKgyQTVZfjmnN3Sw3b9ORIXHHa9MXPLKHkkV6u5s6/mYqluNPkeeWz9W7E8M52eg/jRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpoVVaLb92Gq0Ty76CGYZT2kJ6mt3Vo20j25WcIy/bE=;
 b=KQNBlO/j+tL81LxzJFJw6TwZno67Z6fyrzosEzW1X98T0/842A2XwEhVPBXUpd0ULYtU+UdLaaF+jpGsEU1H0MHYD/UFcagPSGqbMsgZf0RhoRMPwpLJ2aUMCORp51jDGJ1EKUZhKQh93XAyhcrFHX8/uYaKx3MQ6bHmtOBnQ3KWEuUsXvFce4nqRby9//IuzaSKMjavU+cfgjydLta55cSjB5m/QTPgTR74Q6XdtYTYzZfzd47ISFowdb6o3zvO3v9+aPPjvqyEjEXVtXjFIQ1FzcJTwxrbpi6xpu/+nYgHXiAPxG3dTpAFDiMvCFv37OivxECyW7HtwUcz6sdOaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 IA1PR12MB6234.namprd12.prod.outlook.com (2603:10b6:208:3e6::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.41; Tue, 7 May 2024 14:51:36 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%3]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 14:51:35 +0000
From: Zi Yan <ziy@nvidia.com>
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, sj@kernel.org,
 maskray@google.com, ryan.roberts@arm.com, david@redhat.com,
 21cnbao@gmail.com, mhocko@suse.com, fengwei.yin@intel.com,
 zokeefe@google.com, shy828301@gmail.com, xiehuan09@gmail.com,
 libang.li@antgroup.com, wangkefeng.wang@huawei.com, songmuchun@bytedance.com,
 peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] mm/rmap: remove duplicated exit code in pagewalk
 loop
Date: Tue, 07 May 2024 10:51:29 -0400
X-Mailer: MailMate (1.14r6030)
Message-ID: <0B21BF2F-26D1-44EA-B5C5-D0D490BB90CC@nvidia.com>
In-Reply-To: <20240501042700.83974-2-ioworker0@gmail.com>
References: <20240501042700.83974-1-ioworker0@gmail.com>
 <20240501042700.83974-2-ioworker0@gmail.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_A0A1FB65-AD45-4F9A-8447-4042CC159308_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR13CA0034.namprd13.prod.outlook.com
 (2603:10b6:208:160::47) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|IA1PR12MB6234:EE_
X-MS-Office365-Filtering-Correlation-Id: 9af197db-c97b-4dba-0e25-08dc6ea5313c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kxwE6332qwz+YT1Q/yM7W3HY/cbNeG+JLHm26RoK7UO5i+UCGiYuZ2ojFGLo?=
 =?us-ascii?Q?IZPGOR6yM4w4/2R10bY28Y+a8R+ld05Y4UwLVMp5EAVy0BZ1Gw8KSMBFHiiU?=
 =?us-ascii?Q?T3kea2I0mXhmGlZb5Pf+AxcW53AJ7qdl9diDUMrNqoyM2uRqoJ9ilf6uMTuJ?=
 =?us-ascii?Q?z4Cv94isK0wdO4HYZ7HnuaMcuxV4wUlwfp6y5rmEEB4sKikDahXuTLvYXpJp?=
 =?us-ascii?Q?W8ksG0iX5/Edzuv53MTvoSkyTXqVAMFCM+YGWfAj4DGmse65mI4H9j4FFNhs?=
 =?us-ascii?Q?FU7+xTgOTf8sxt8iLexrRxUbxspFGQ6/mKLRbECDSzjbHQw64MIyULYi2Lxa?=
 =?us-ascii?Q?Bs5oOuM9oZpIYmphVGfdpr9tMGG+Dupr9qsBsYqaqKCf6pKxChy228PIdwhi?=
 =?us-ascii?Q?7CurQX4rKGdiXEvaS5xQqRwu5vfwYjpf+ucV0ScKhnWPnK/EMn1m6waqqGgk?=
 =?us-ascii?Q?1sKAxkxWSjU0tYSRJUjmQZ38I7JD4/zlaufYIvtlQAz6r4w5J2y8IemfQIzE?=
 =?us-ascii?Q?Bco8v57sRxzZoVXdUywS+b5BvaB0FquzhCY41IH3A6wtUGjxWNzQRzuwAlh2?=
 =?us-ascii?Q?zMBJRG56c+IPhvtMHWYi3Fq4DgZT0iMqjAF7tgrp8UROO5ltFOBNrqOzQc3p?=
 =?us-ascii?Q?5sr9YQ1oOJwPAWAqKpLlUn9lpVtvT2o7ckH9nOjl3UKkG2o24c98wUn4ChD2?=
 =?us-ascii?Q?ksX7BT7GXpbpDxiinAu82/j/xXd4aPJQfrXRZOWR6eqVH+QuNVnzaepHjR05?=
 =?us-ascii?Q?MA5fnPVsBY0j1ncKeN7GwcyQfX+NN0xJmZT5kdM+LLYdCjV1QO8hgt9Cy1LC?=
 =?us-ascii?Q?C04ZpCBM6GuPSH3g0/s9Itx80jyKWOhobyRs/aPq7qPNqrmkYJzs8O9i50nT?=
 =?us-ascii?Q?4tjRvVKbfoMv0s31qdic1hJCwyZvkgMhWXiq3UM1QyN1mMBF+FJhstyezGYo?=
 =?us-ascii?Q?iWDEkVf7WSqWbvr1bSnkxPrdEmHY5koNq6UUkLkq9xkrirOCBEZTfSJdqCI3?=
 =?us-ascii?Q?Y0RPkKwfkgLJVNcxN0eqr16TTx/n6dRAPF37+w9BOXD4uKdHiQk28xfJ/Tlv?=
 =?us-ascii?Q?uOV+hJZQbHDGMQ06uRbwyIm1bk44wWPAMI0/iA9i1zHdFz5te9uK/0dBAAv6?=
 =?us-ascii?Q?7uVcA9Cz019MvHA9ivYYUH50Sd6Cd78BCrRaF3Cd5XDmrZrVGXQ2xgONGZUK?=
 =?us-ascii?Q?6b58MivaM6PDxj4TqngQImabBH6zlg6TeyE7cQfQzlp4vq8Uwhd408ZRqt3P?=
 =?us-ascii?Q?qsr1wnLm+/UINWIflKv5VRGDdUtwweQkIqTM9cEfXw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Sjy/0jXCmP2JjBgD86W8lj5QpkdJ7gq0OjfTVu600DRmjTqezG6haZKxgAFn?=
 =?us-ascii?Q?ppSWn15PyKFJL/1jovSgkhimgb6/sRwNWPH4+x/94XqHab7Cy0vOrZlXwRsa?=
 =?us-ascii?Q?7UpA87aGsvux8p382Kp/2lQgTxZuIBL6df/p/6/QNpGCnrTgfiaNZUAW38IJ?=
 =?us-ascii?Q?YwqStdqLQwuNDESlwa7PI1od6H4HVAdcX9nqiR8cJHXkbkDfk7T6FpMEGwQO?=
 =?us-ascii?Q?hy1LVYFSbTb30ihBwELA3aiV3DfSzW1OXVA9W/lry9TLGK3yFwElZdK+qQGi?=
 =?us-ascii?Q?SfX/shIXs/mjbXjyjb5rOL7NoooY+QI2Zn+wVBXM5BJswIKO/49rStlrFn2x?=
 =?us-ascii?Q?OIo/rogJ1ZM1acq+eEExOIbeguoftQqxkAeNabsvoqZQb0WdAyL3Cz35JwKI?=
 =?us-ascii?Q?vqIEulxv2UsgjOyhpxyM1q6o6eo8rZvS7xVbX4S/fJ3MeeUDxI1nPaf9YvHt?=
 =?us-ascii?Q?30D7W+fMITpnFrQz2Lnn4PoOsL0+6SyVvd6GgxVdDRZtuT8S5hdRsDxdauDz?=
 =?us-ascii?Q?d2OzX/2TEw8dOdQOcQqBFprpu95B679FLkB7T2XdlUkARVjEvVf325DzXQRY?=
 =?us-ascii?Q?gfaqm/LtN14EGyb+dRz6J+6a20XpXVbO00KHujeygkjNhGW7SigQgQ9lb4kZ?=
 =?us-ascii?Q?xclumUp8jwnGxpNYWkdtnGf5IcFK3sQwm8KGSuWFcEqfQZQ/fI7mHKA09b0A?=
 =?us-ascii?Q?RTBP9wWjQ1iVWBLYNvKJxhIRfzqN7OwRGpe2ay/ezYj73xPHldZzA5ZYPzO6?=
 =?us-ascii?Q?NCQ//6MunppQ4T+Jt/TDoYKqBgbBIUjYf8jh87goWUmFwEE7V1kYoNy7YsJq?=
 =?us-ascii?Q?WjFFQ7MpXYDMbESQ60THfJbaJaJnCTONv5tELbqp4HZdNNCbTL1jW4fXR2jh?=
 =?us-ascii?Q?h+u5dwv0kaq/aR86HWUZg0uKmWjM6eQiXh1kPQOxSq0spaJzQcMWGWVAokHb?=
 =?us-ascii?Q?fy5FUdDMs8ww49gaSm3aQi3U3D6TXmexReg9H3p9hh1W/A73qUkN9hBHCPm2?=
 =?us-ascii?Q?BWq7qaEEAc6scCksTNAWvxGgDEbIcncGyNKcWGedNBM3gLfGcqZHMKxLW6aM?=
 =?us-ascii?Q?9/FVBrTXMrB41dQ6xDfEt0vPQKMJ3KOyIZx+x2t8sZ3IfpsLm7lIGPBVt2Lz?=
 =?us-ascii?Q?VUlXBRv4VfUBJsv/XTB6ZulMKmlp3D5XyD7BBcaOuCyf9oy9pLy7SoPvYmaS?=
 =?us-ascii?Q?HmcSLce8kfjuHgjAEXWAF/x2b/D90qVtCJ8qvFo4XbK3zZyitVscp07Kspxg?=
 =?us-ascii?Q?bfZWiJmj+fOqSFPaa9vWj/Ejipo3G2lp2P5czDwhZaQmNO+1VtURLJ8V5v6J?=
 =?us-ascii?Q?As7KKX/sUARjMrupfLwESEeIO2x+uwvzubircOauo98IPSRYrjXI5hVD7bwF?=
 =?us-ascii?Q?/nD8CjqjpX1VCwQtJAFatYxWKlaml2oh3plh0ce7gMhqT0x6oHDw0dzs8w/G?=
 =?us-ascii?Q?jnmQ0507EDGlG6htxPWUqrRZkqHQmpUnIUTO2B1xuDK1GgN4fyiyWddjiGme?=
 =?us-ascii?Q?BuZV8dquh4F56Kp3xyympk27j7iOiXFnniOZuOorZ9M3kAV4Z3SizD+va/wl?=
 =?us-ascii?Q?Bz8wqfDETt8TXebDqGk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9af197db-c97b-4dba-0e25-08dc6ea5313c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 14:51:35.5767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xawy53zp7pFhzC9csRIgUIKxa7k7oF1XFthEsh9WNC3xhwqzVTPgYGIWDABHEHPh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6234

--=_MailMate_A0A1FB65-AD45-4F9A-8447-4042CC159308_=
Content-Type: text/plain

On 1 May 2024, at 0:26, Lance Yang wrote:

> Introduce the labels walk_done and walk_done_err as exit points to
> eliminate duplicated exit code in the pagewalk loop.
>
> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> ---
>  mm/rmap.c | 40 +++++++++++++++-------------------------
>  1 file changed, 15 insertions(+), 25 deletions(-)

LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>
--
Best Regards,
Yan, Zi

--=_MailMate_A0A1FB65-AD45-4F9A-8447-4042CC159308_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmY6P/EPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUFWsP/Rl2zj6PQrWU4/if54JimRNR1CHucw5jn+DH
958/a6qQzXc7j8VQ4izwgLrAItbX2NlKAW6YQT5T52JfWQM34wXk4a/S4O8mszu/
D77Dc6q/BIEAM7HM/o1WnsXNB8KFnSds7JWGDp2+pHHnKClh9G7hQIbCDga1EImQ
rhM0VOJaPsL8Uj4pBYG/nXuS8e2sKC/tiLMnCjHlpFLjJ7mcw1TiKjPiNqtpcZXt
c4bqueAr+ukYvOxjZm9fVPFjKJtfrjkJj6ar2RHDWd4rWmq1ZseYi//uPGGFdPUC
JPfduBbn10PWlsUJbMCYFzkXJp+LUuEvKf+ylRXfRBzi7FlVi4Jf/M++6YxvJyRD
57bcj6U2IBuIieFkyz9TqhdRU9WqY5PVQjUpMRDYTjhcXfP3V5OjA+gDbK5Pv5GP
WWpt7m6qKY0PglyxqZTaYHtgKXHr8qvu792SquRvk6vSG3UIyZCpgbf73kxfOzIk
VzEY/mmwtaQKtuSPoywuxaOCaWFrXaUBOX7N482ye3fwWBkdbORD1w4FSsl5/14o
j5xZGqFTSYjbNRlgEuqSfa9hsXpVOXn7k+1G5Fq1YhOeukevTT0pHhB26JUr698p
g+3lSW099pTw16i80nzxVlezM/GfibQ9bz0EQevwGQ9RZI7oFphug3AD2PTAakdH
x9ddMm0v
=8D0h
-----END PGP SIGNATURE-----

--=_MailMate_A0A1FB65-AD45-4F9A-8447-4042CC159308_=--

