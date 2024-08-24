Return-Path: <linux-kernel+bounces-299811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E475895DA48
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 03:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A572028516E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 01:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91CD4A05;
	Sat, 24 Aug 2024 01:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="LAbtBPPI"
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022133.outbound.protection.outlook.com [52.101.43.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A0EA47
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 01:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724461244; cv=fail; b=QwHqojgMjEJGIKd0HEWKqfdPSraF3Y7aPrCQzUvALw5VeMGotvTYZP/e9kzTJaD+8XDkGGxOq3rO+Fkc5c0GFBonWdUS1j//Wanxdi/L2HS5IeEa7JJ6ymiL1EPaoEI0Qc1Njn9syVyn4bSFUAUeFuW/5QX6DowMHrlOQx1SXXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724461244; c=relaxed/simple;
	bh=HsfHcG1aXgCdCIf/1jQJ7NelvpWhkpobdx6gFQ5twP4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=Mu3a1n9aK8Da4sZe8EhBzshov5qNUdpVGjPhX1f4LnShLEIHYNRvITBfJBpAarn2cdeBmluQQUgn/3P87v3keAOZukDOEN8sJTHg7sZLv8754o38IYHXJii4+iFmZRssTuweAY5vOCV4v4J/ceLM2PS89zIIOLuDcqjL6gOpd2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=LAbtBPPI; arc=fail smtp.client-ip=52.101.43.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sc7PcSIv2N+sA2QoPLWNLzpOV+KfaVy5BDwPR1ze7PfqefhiF7pcIChbQTfKHa/YrQ62afQnBJoLjXuR01NPQwSpnPj1NH7V6iAk82zRGHbKT83Nwst3fjt1hL2dwPOOUI3TD2LQLPYgwkA5b8owlSicejSYXy4My/mkZqcdo+rVs4E+HHbd4n27KH4xXftxSW9KlXZxoiZZ+063R+LwFdqjexFuXjdEHYnZg6xjRzQNyo30sTQDBhHuh80if0gIEr+y0f7Z5mEdlZCUIwii97M32kTFx31XnVXAytPMx70VzrSWE9T9342qZSSier6oHJVYdTftIP2u+R4Wghve/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VjQuK/Pb5fB4dplLErMQHUYzrQSdnOkmXcBwowJl8HE=;
 b=bn/PbtYXIaChCjA0whSRo99zCqi/ZQZAms6C0iMj8F7IvNwbQc7PSoKTDegAPGppNasmJYBqEKW2MrEWxrfbEgifsM2C679BqL/AdB5QWdOzrdgj9lZimgQAcl4isZPfTA3hkFrHgnXxLreLhiGaX8AOq1DeMR5ngoDw6cNGKH4QGDNi3zfHWZQ7Em+Etg5BggYh+Qbzq5G5Z25J95BSYfRwd3EFmbv7wI41Ky6gPEVJR8DMwZF3ektwfs/rl7FCqr+To1BVCAymAxwUnvg4Yh5aupGfZ7t0Em5khI8bax8KZdfZHwehFzmXLHmJk5sd1V7jbED3jiqQpCmdS/EDVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VjQuK/Pb5fB4dplLErMQHUYzrQSdnOkmXcBwowJl8HE=;
 b=LAbtBPPI3n9fIMRKkc5wnPfbCXdDBaqX2YyNXKe6Rs1Gay1M8oB5CiGjObNDwjMP/SKGRffkYKBk5TwsyqxX25Cr2ckIzEcIcAeatKr2fIOv0cBwwIb6xW9h7B2+Qa8wPSYtPh27s1/pUyCNghNABO67RVJHx06AHCfQZ+KAv+w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6228.prod.exchangelabs.com (2603:10b6:303:76::7) by
 BN0PR01MB6877.prod.exchangelabs.com (2603:10b6:408:161::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.19; Sat, 24 Aug 2024 01:00:38 +0000
Received: from MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba]) by MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba%5]) with mapi id 15.20.7897.014; Sat, 24 Aug 2024
 01:00:38 +0000
Date: Fri, 23 Aug 2024 18:00:33 -0700 (PDT)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Robin Murphy <robin.murphy@arm.com>
cc: will@kernel.org, mark.rutland@arm.com, 
    linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
    ilkka@os.amperecomputing.com
Subject: Re: [PATCH 1/8] perf/arm-cmn: Refactor node ID handling. Again.
In-Reply-To: <998064aa2bdb0e39f91b4f1fea2f428689978ea9.1723229941.git.robin.murphy@arm.com>
Message-ID: <ab1b89c7-7bf-78d2-50ca-3411e511ec33@os.amperecomputing.com>
References: <cover.1723229941.git.robin.murphy@arm.com> <998064aa2bdb0e39f91b4f1fea2f428689978ea9.1723229941.git.robin.murphy@arm.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: YT4PR01CA0158.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::7) To MW4PR01MB6228.prod.exchangelabs.com
 (2603:10b6:303:76::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6228:EE_|BN0PR01MB6877:EE_
X-MS-Office365-Filtering-Correlation-Id: 52c11629-0a9f-4709-e331-08dcc3d82adc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MNxgIANKnAOP6W3zCExnVKhCzPmFCH6+fR2EZ0eTKDd+jgvfPtBX4YQ8/jf6?=
 =?us-ascii?Q?gD7YmFrEH6WoemW1U/GeBRBw0ytnV4UYqzEMoiAx//IsAsVvylNGUg9vDVcu?=
 =?us-ascii?Q?k5h4GrFlcT3wgOxxbe90YG6EDGI6kWiaq1RTYhmTPJcEoEcUFqEecHUbqOGB?=
 =?us-ascii?Q?NhrpjTuutD849vwjIM3rO/5g6EnX5zFE3cHxS5/t3Ec2hbwd2Fipvxx6ugO9?=
 =?us-ascii?Q?i3j8Y1/iDA7MdZRMqJvUDYUaqu8FpRO5w7jgPv/QMPV+dWV7KHkpHDd9tLTo?=
 =?us-ascii?Q?mx/Lt1dkQRwANs4KQ4O4bevN7P6lsLl6EbpXX3lkDqhMWH3qfEfFo8RoRjbf?=
 =?us-ascii?Q?aq0Ls8sjgvxl0bWRRSlP5uLOFfPqblf6wMjUtcjvRELmSZrouoWPaP7fArMP?=
 =?us-ascii?Q?x7Afu1NaA02zMuiVQI+FjdKFrvaruJvNWXoM6RY7YgsMEcMaWJFuCyNk7Lqx?=
 =?us-ascii?Q?Teuss88RQ5YvpQlWMqHI82VTtw8RcjdYJkjIti2qAZZOkSl1t6hGFAbl99hr?=
 =?us-ascii?Q?Zt+29GJ347Prk+csJdA00DixykHaD4S4UqHVr35zaq50FxJOrw8PkWmAJvaq?=
 =?us-ascii?Q?3MXlPnthVqPlaSCF3HDlpShjQZbtJFgZlTf+u0LIWhO8Sb1zjXcAmGd+O0oG?=
 =?us-ascii?Q?qsmni/Cq3OkoEd/SFOWIRNDNZ4ATMlpMeLHvqeXoZNGmE2QrmCqr7yXpSKls?=
 =?us-ascii?Q?wU+TagUYC7wvWw61I6F/7JjUY7ZBHkIUHtd3qFIEn0JhK48GrKAt+0kR3u8T?=
 =?us-ascii?Q?dIBnkMET0zd6ZYbFpuDERYqSgMznpcSSNexzEV+/biy43Jea9s6Y3+zyvRc2?=
 =?us-ascii?Q?8gzCUE2eXsiBfQt57L3kA7T7BIqhSCrpT+koy73onV0MFcPLdWQAJGfU6ytr?=
 =?us-ascii?Q?kqQhREoFD1DadS1w74WkDexe6WH6bnrwMGcb8imD4QYotZi+1+Py6gpf8V7b?=
 =?us-ascii?Q?cXpAki64MAIETU36n3IqYVFjbNDXOu8HMWulujrky4qPPHP10YBiwbP2VU4A?=
 =?us-ascii?Q?OTY0m6k1sJRVP+t41xDveTISi7NW1D/vSgP1/hJYR939FMFQI8CYFrRPY4vy?=
 =?us-ascii?Q?PDte64Z1mRjgSqsMlDuHkdhqYfOm0QEYmwOIn64XlBR+E25Y1GBL6dUUyDZh?=
 =?us-ascii?Q?yQMuqShnIkcjp3FGFIEkil6kteq9ZlMF+NGsCzpWfy96oN/TDLijmcoQ5A2W?=
 =?us-ascii?Q?soRIpPplgEoLezE5/KbGNPKsEhoVAvltvzO9F7eqHgSBUrMSQTkzCnp5Fwz7?=
 =?us-ascii?Q?7GJEf5L8CSkm0UbB19zcucsCmcEYioSQ2hdJfi260uMthzTcJXmQT/y4jPtb?=
 =?us-ascii?Q?0rZ7O6zGftWBaQm3r0GnsjizKIsRlPIKbMCAzPf9O2h1dQtgAZA7FO/vMY7P?=
 =?us-ascii?Q?zyk4lAtTWO0rE4OevV/0CsoJZ5y3do9DMrNm73jMPuGyfmSe6g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6228.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0dzWNDBdYbipSXdQQYrBcL4iZi8R2EGytfvZgUolTuNwbOdUh504dmWoAk6h?=
 =?us-ascii?Q?DIDmZxlhUy+UV5rNM3UD2MTxeJfyPO+g5UczYixMe5j3qUcQu1uD+Jpyk1Ip?=
 =?us-ascii?Q?V1HQglCIY5lZXUO1KVEcIbaIiIOlP0gUmaXbyLkQTxt7R5IrawJtO0RHlq9K?=
 =?us-ascii?Q?TX8Ofu/zite4Vk3QlaX5iAJl+CufgJ2HFNrfp5oQwr3YfPIVDdAJm0WLIUT8?=
 =?us-ascii?Q?eVls0pq8KA/j3M39RcR6WWyG9IcengGdU1+8Lpk3/WkCjw2/S0LVxOSk+Vt7?=
 =?us-ascii?Q?/Mj6/e+Sw22/VOa3TkJ2zoqY31Blp1mtOiexUZ6ipOoVjS5w1iyFgdfykAVA?=
 =?us-ascii?Q?GrG/sg7E/wkpSQ6qHDt0v/C0KRpY6eSM3TQd2EqE1vCoFUP/DT0ippsqdRc9?=
 =?us-ascii?Q?QHdW8xQk55vIKNoYtozkRobqftB6L9SmRF/OF3VuLvC2XyGhK+SE8efJ/ov7?=
 =?us-ascii?Q?GvDVZS6sAOF9pVogQJrI3slDRI59W1KGWt0ZU5CVc5YXRDEw3cooBv3SQ5DR?=
 =?us-ascii?Q?NrjySndLrC2mebTo9hDGA3viBQtA1NYkqTb/CC/JrC08qsTzgVUqubmfF2Q9?=
 =?us-ascii?Q?3Rx2zk7XjwfvbbC27FKz8Jdxu3zhI302wC2bqG0pvzc15l74/kOYhiaAgrT0?=
 =?us-ascii?Q?+WPtjsBaVUfmSKZql31DyFeTtQbncmzQlGxS9Juy1/9EzvTO9UGSSaM8/Tjd?=
 =?us-ascii?Q?JXqjS8jXPyc1+hYK0sBtxZuHiYs5uGp4Po3BNEAebPHCbHSJNiYKPOi7I6PM?=
 =?us-ascii?Q?7GGnum+tbkOCS6QXkEh72Wy6q3DQX8Jb+s4Jy/q4aAR1bEv/PKSXi7AFUl78?=
 =?us-ascii?Q?Gb0SzgIJWiznRDGOHlPRW973eVupRKxfddJd9qWEwz0HUh3cFchkf12xIHA5?=
 =?us-ascii?Q?sI/I1KU4ZbHVz+taXR2gYX0s+q/KhL31TLZ3Qv3tT9MItJhYUYXN/PZluMHr?=
 =?us-ascii?Q?bjtdfkZRYSUuwCr4JMW6sriDgynUZGjgxezRiT3ilRkfWr6Mqj1A23ZDufpx?=
 =?us-ascii?Q?Iq71J8Cs+rm65advhMwNY2+eI6nZE9h3ZvpiIwqLsBRbVd7E+IXuMxExX8IO?=
 =?us-ascii?Q?ug9RDYfydyVm5P3EMa74u+qnd/imRB7WfGFykHytMaZ+XAXQbygHeG/izltN?=
 =?us-ascii?Q?ijp4L8SskeelEz7oZPvc0IjDZbbUhh6CfgCezQ9jadwaJRAkxLHgYjjr99DO?=
 =?us-ascii?Q?jM7rLdvsuXBqh8jh45b6MwFoOJrFaPCAY8t1G62MtiwlWmpOwLbbbo2r1Uap?=
 =?us-ascii?Q?0f0YReHeZPsAue+znf+T74f/Njrbue5oy6BQHWFG4knqOjYa97W2meyULaR6?=
 =?us-ascii?Q?vWLQcCCyvs1z1O9+3HX+46DxRcXL0cbqLYrwGvKwCiHxgIfCrUbfQzLaM1v0?=
 =?us-ascii?Q?ta/R6xzylQBcEU6EdKjcKeUYs+3lLp/rBPoG0+TXIBngABiiuP4qQvu1qnFs?=
 =?us-ascii?Q?R4jLmS33PcvAF/89HJmE/SUzvRhK/Bn8P8ZzHNBzeVtoK1Hr+V9XPtAEshl6?=
 =?us-ascii?Q?+QLWnigg9rcE/pflm5rFTdI+SbCT5tawFfs+uLFoBnVSyvnwS/mYPi0Jx1H5?=
 =?us-ascii?Q?KAJtTNmAB7Pi988tEEYSKFnvTh2mPl8U8BANG+cHXCEae4kMrxoPxLtEpZFN?=
 =?us-ascii?Q?yp/+uI58RqJ/ykUh3+NQ4Ww=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c11629-0a9f-4709-e331-08dcc3d82adc
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6228.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2024 01:00:38.1921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FPM20CxxZCdbIVWKl0NQvTU/V3ALE7+7XSL/S4+qbQ6ZgNQ2WqOcvDsAbggKE60YNM3+AAxxRSNIY2G5yadDy1m6gqzK4e2WTEp4sh2iRi0IK5kzThaT9D9qvvPQkYm8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR01MB6877



On Fri, 9 Aug 2024, Robin Murphy wrote:
> It transpires that despite the explicit example to the contrary in the
> CMN-700 TRM, the "extra device ports" config is in fact a per-XP thing
> rather than a global one. To that end, rework node IDs yet again to
> carry around the additional data necessary to decode them properly. At
> this point the notion of fully decomposing an ID becomes more
> impractical than it's worth, so unabstracting the XY mesh coordinates
> (where 2/3 users were just debug anyway) ends up leaving things a bit
> simpler overall.
>
> Fixes: 60d1504070c2 ("perf/arm-cmn: Support new IP features")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> drivers/perf/arm-cmn.c | 94 ++++++++++++++++++------------------------
> 1 file changed, 40 insertions(+), 54 deletions(-)
>
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index c932d9d355cf..fd2122a37f22 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c

> @@ -357,49 +352,33 @@ struct arm_cmn {
> static int arm_cmn_hp_state;
>
> struct arm_cmn_nodeid {
> -	u8 x;
> -	u8 y;
> 	u8 port;
> 	u8 dev;
> };
>
> static int arm_cmn_xyidbits(const struct arm_cmn *cmn)
> {
> -	return fls((cmn->mesh_x - 1) | (cmn->mesh_y - 1) | 2);
> +	return fls((cmn->mesh_x - 1) | (cmn->mesh_y - 1));
> }
>
> -static struct arm_cmn_nodeid arm_cmn_nid(const struct arm_cmn *cmn, u16 id)
> +static struct arm_cmn_nodeid arm_cmn_nid(const struct arm_cmn_node *dn)
> {
> 	struct arm_cmn_nodeid nid;
>
> -	if (cmn->num_xps == 1) {
> -		nid.x = 0;
> -		nid.y = 0;
> -		nid.port = CMN_NODEID_1x1_PID(id);
> -		nid.dev = CMN_NODEID_DEVID(id);
> -	} else {
> -		int bits = arm_cmn_xyidbits(cmn);
> -
> -		nid.x = CMN_NODEID_X(id, bits);
> -		nid.y = CMN_NODEID_Y(id, bits);
> -		if (cmn->ports_used & 0xc) {
> -			nid.port = CMN_NODEID_EXT_PID(id);
> -			nid.dev = CMN_NODEID_EXT_DEVID(id);
> -		} else {
> -			nid.port = CMN_NODEID_PID(id);
> -			nid.dev = CMN_NODEID_DEVID(id);
> -		}
> -	}
> +	nid.dev = dn->id & ((1U << dn->deviceid_bits) - 1);
> +	nid.port = (dn->id >> dn->deviceid_bits) & ((1U << dn->portid_bits) - 1);
> 	return nid;
> }
>
> static struct arm_cmn_node *arm_cmn_node_to_xp(const struct arm_cmn *cmn,
> 					       const struct arm_cmn_node *dn)
> {
> -	struct arm_cmn_nodeid nid = arm_cmn_nid(cmn, dn->id);
> -	int xp_idx = cmn->mesh_x * nid.y + nid.x;
> +	int id = dn->id >> (dn->portid_bits + dn->deviceid_bits);
> +	int bits = arm_cmn_xyidbits(cmn);
> +	int x = id > bits;
                   ^^^

Instead of comparison, shouldn't that be bit shift?

Cheers, Ilkka

> +	int y = id & ((1U << bits) - 1);
>
> -	return cmn->xps + xp_idx;
> +	return cmn->xps + cmn->mesh_x * y + x;
> }
> static struct arm_cmn_node *arm_cmn_node(const struct arm_cmn *cmn,
> 					 enum cmn_node_type type)
>

