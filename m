Return-Path: <linux-kernel+bounces-319905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B3E970397
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 20:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79C471C214F0
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 18:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7DE165EE4;
	Sat,  7 Sep 2024 18:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N6RMgNbt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="w+5CgymB"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA211EED8
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 18:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725733897; cv=fail; b=KN50t14jRbRuEbIqJ9vwq6jUK4qf3F8RzccpWBS8qk0EIevh5rDBkh6sk25TcDRv6SLClZvR8IytnYjC+jVjFTpNGR0Y1Om/iLQ8wcyM8s/xgLcG5aliuk6z+cJJ4Uvq+fLuOO6kQc1TBdZHPvPy7mvKgBBSyEe72wLccBF7uD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725733897; c=relaxed/simple;
	bh=yOSnOqBqvhMB9D89K1lwr4haa23ZeAoyX4s4pXJms/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tKMCrkRyUNrulvneeiYCGrbAOGkpLSyCb9QJZWJ0T5Vl2p8rcXqdrDMPjwxN9H1RUAPYJo9Ra6hZcNgpe/rVC3xOLTvi3KRALdFUej4iRCO+2l1xfgFW8a84HAkpiPewzg4nDWMRnNkYA2Z5Q5+sodM0zxQb8eikd26XBqYY8lM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=N6RMgNbt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=w+5CgymB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 487Ee1lg016166;
	Sat, 7 Sep 2024 18:31:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=FiXxrbwJh5Iy4Ht
	yjCazRfWjZ9wHqH3kyUjy3IblN+8=; b=N6RMgNbt+9tsw5OvNSfG9dcRkFQ0k7T
	It2V1y0jO1o7+0fanEmSgwIllDt0BPQ86pnNThi3VuL2+6ULqZP3LLO9IoeEarYl
	OXxCBMvSlh9CR9Dg00IPFNSIxJlA1jycy3MMZN0ucwBiqEd1oKOj8KZkyrRtCLCc
	scvmnM3LUnd5p+6KVK+ZDe2H48UZCeosDkznOr7Yca6xpBI0hS0nXcS/0Lyh5pTx
	UtdC11TupYpMXfkPXs1ueopLlXwDR3FOQufGIeGCMGHQYqYCMcgd6ciy5YmaxZLY
	xzAkton+FDmr4PSYXXkwqxVgvkGZEX1oNPPZW3WW5MdhfeovKeZ5JYg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gde00jrs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 07 Sep 2024 18:31:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 487IMGKn019817;
	Sat, 7 Sep 2024 18:31:22 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9cdds5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 07 Sep 2024 18:31:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZH6ULP97Nx4YG3wyzIoLfWFbYObwkhlxaDl4VOHRYd+7+L8FZzJ1fJ6P0B7saY1WKMqLx94TPdV+LNBYs22f/K+wdPL4Mk5yBkNnK+q1M1iVVNHAzwbsHwqob9zU2GUBGXIX9rTeEGM66zPc+0X2ptgWqjYZi3MHqY1rzCunRDFQWqOMQniKr5eai2UtmJKIsG5jUmW3jUZg5oerz1wVzwlK93QFM/4t4DRWYeCa8+jPSNF6imvZ02IuvoqRLcHN+o6wxlm3yhuN9INWjjSAeqClIf9ytb8RbnAx5l05i5XX6u2sLsSlW9ADAYMK6tUQ3A8Uc14jZgDD6xJEOMUiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FiXxrbwJh5Iy4HtyjCazRfWjZ9wHqH3kyUjy3IblN+8=;
 b=kygJjjzHRcdGCxaHULEFCD5n9H5jMK595/pw4TaE8adJEciiZILTZteQZV6ZHZFA/V0fvfnS/WUN1nMH5c7Cpu1VI+KIDuXPzOEmojapqyymRL3NJ6g1jHkzcUSu+i8pJB+sYeSPG8baClrNC7cRxUVb7Ay6fFz8iXOc5wHIqix7/C+2GQof8ykWMW8s9pG6TyyNR/FYKT1haKE0T6NW33zo2HxQmtiCQ6BoqK4vqklnidfMvE58v2HmZBvB0yyQpOFwZjDSq9GvL24p0Hc9ijaW6SEvZRR99vFmSCp4S1QDtZCWkNO1+gPQRQh2h9qLUD8f5YieQwu1EP826913uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FiXxrbwJh5Iy4HtyjCazRfWjZ9wHqH3kyUjy3IblN+8=;
 b=w+5CgymByCO6VSD/oasJFobMVKky9o7Zrx8inZnnRIVe1RDk5PtgVRX8J6n1L/ei9VnVua4ZlW++dej9al5pI8ra+xqSYIXtwffkAuvFIE2Ah+Lctuv8YtAIC8Xh5zig+L+IpYMS1qEjFuhbxy4w4MftVCu3i1xtdaouuhnOzFY=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SA1PR10MB7664.namprd10.prod.outlook.com (2603:10b6:806:38e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.10; Sat, 7 Sep
 2024 18:31:20 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.7939.016; Sat, 7 Sep 2024
 18:31:19 +0000
Date: Sat, 7 Sep 2024 19:31:14 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] maple_tree: Mark three functions as __maybe_unused
Message-ID: <f9b2b03b-24b9-49be-825f-7eb1aea59bee@lucifer.local>
References: <20240907021506.4018676-1-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240907021506.4018676-1-Liam.Howlett@oracle.com>
X-ClientProxiedBy: LO4P265CA0093.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::18) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SA1PR10MB7664:EE_
X-MS-Office365-Filtering-Correlation-Id: af35a4e2-8481-4ca1-c82f-08dccf6b441e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dLHZBD65cpMHEkaKTulNpyX1dZxrcbMJ0i7GMTwPSavWTUwP5tssCUk8qQ9i?=
 =?us-ascii?Q?ZC4xyI9KczwaQj6dil6+EZALmKjqrr3BS47ct6yXKJwO7D0slr26APkmfL3+?=
 =?us-ascii?Q?gkPdcaBWwXVG26JvNjtNPXyE4/CLY6t3Akm+32QzKBTBOvENFuqiB5nnSLIY?=
 =?us-ascii?Q?28VD4mFKP8+KQ0RyUSgyRMui3lhrmpiIba/0tMHAcnZpFB5qOcEpMRpou99R?=
 =?us-ascii?Q?AN2mpDSKE/mh937Q7+XbFebPIojP3SZgQF5mSb+Rw9SWVuwPfC6gCp+8uJ3F?=
 =?us-ascii?Q?MFOTl1W3ySYtTomJ/Rf0dsodFoMipe7QpUGEHJzTQaN/O3lnIZmnEdIjBoAq?=
 =?us-ascii?Q?O8f5jE4OtEv9BysQMcQcDOoaFDC4aq6gTcRWLZgaGgkQrb9KX6muipEm/7sg?=
 =?us-ascii?Q?R+g5CUaEoJxYhWG+H9y3rWDxzGljWXCGAnZmGE+l+ncQAj1CjBrvWNsFyg3Q?=
 =?us-ascii?Q?TFILsGuP9gMeeA3WtXSqbJlgHzBE9jk+DsdP/Ce9HvpGGU1jmyVYkNYXAmmu?=
 =?us-ascii?Q?OaJswDFQEMKFWryJc6ipiECe6Ub5rOeSNkBSCytmCQDgn6oqtvxYYfafI8Xe?=
 =?us-ascii?Q?2VoXKMg2BsQV0bdsq5FXvX+B2bmSUlmG8jT8jeZ/71Agg38ZDTen5Mb3S1Xg?=
 =?us-ascii?Q?gWRg9h0zmkAmoqUTQLt4vJCY9Io6BrDi/Mmas80MWlDF3lkV1POnZSrdC1e4?=
 =?us-ascii?Q?3RZeEPeOEg2fRFdihwSMFJmTPZkgARSAAd+xbj6aLRKSrrS4Rx6buVwakGvL?=
 =?us-ascii?Q?SuRfYTSuL17+lNYB6Zv/OpEYOO1+HuyIUa51Y/mWb7m/yjjEdBE4xiymrMsV?=
 =?us-ascii?Q?qLikS/n4ZWUeH2njpOHsb3UkbgNjx3zGjvKPLkNIjcVmPY7LUd/ZmOxHzUZh?=
 =?us-ascii?Q?lqgDvZ6DNITa/3zmxzmrYR7F8FzMURWHXxf3xZJmIgAfRUfX0YmD7Qo+kl+a?=
 =?us-ascii?Q?kgAibVTJymDVQ9pT3QUbLoxQE4mHacWDgyeVGsIuQZU4kNePSjfu1zUPuAUg?=
 =?us-ascii?Q?5eIZblFrxugLo0VIXd/GIEelEAoclm0CxFa1x4xO9X+CEBYD2h7GQt77NIu9?=
 =?us-ascii?Q?eutaRIA8j4/i64mbK0Wj8f3m8eChguhzdvwjliE3ydPhC8Z0Fl34xeiMVR1q?=
 =?us-ascii?Q?E7aLoSFtUm9UhmT0Vkl5xcjMlNU3O7DJDsVLQrmldMA9URNojfJVzDO6KpVo?=
 =?us-ascii?Q?9wJdk5H5M/Lj9hyUcL7dG/ml2160U8m0y/BHfI6Ay+bEX6acMveZ5+JiX5JJ?=
 =?us-ascii?Q?sBRytNpZpcLzrPm17uxweu6WQZ3lRP7MTlSgewJp5ysB93hdNiOBQcxNvMtO?=
 =?us-ascii?Q?2hU7hHk5mYLpR8GeOgVH7lfBvvQimEf0yqZuQOqhUUw9zEkx+wPgEcUpiAg/?=
 =?us-ascii?Q?JfP/Bk8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1/yVCm/h+mZLL15j5GK3toL+p0P4JFxT920HDGbcAAGADkTHY3pr5pUsyU5g?=
 =?us-ascii?Q?rbFWtN9kdfRywY4ZjS2Mdl84rMqwoN3cjLpySJPmN5YKMZrWoKMVm0wmiz3x?=
 =?us-ascii?Q?G3D+sbh+QqHFlVFjZ0MOjKkUuDskS6mVTvFT14Jhm07acwR5eL6DHUfyllwu?=
 =?us-ascii?Q?nFw84uVwTTV47hR87bMnGaGdJiCfNVpmErjTWvkj92o+XtXAlnXqnsmxti7A?=
 =?us-ascii?Q?nQDRIpp3o7RKNf8tcI8odtUvNhX2xyTj547zfVGaYGIJhgL31Gvv8UYraVoz?=
 =?us-ascii?Q?qBNsJTXWapRbfxMeU8sZl7Bjjw5zW5uzvFHXEPps7p/2/8cgtuLU5QLvZMeB?=
 =?us-ascii?Q?4PuMAUJJh/xEFXHljPACUUL41Dmi2KOCUMcRqTx2PWBy8KWmMoUyB3+E7bCx?=
 =?us-ascii?Q?vvRm9G/ehRqSeXmWyxqxDmUjwJagdrdstYyplKU9SUrnSAdsH/YAaq3tVquz?=
 =?us-ascii?Q?MfDhcqBNiJxdMqcmq+meWgZperZ7MpYt2lm/V7KnupY6b0EVM9GTh9Kkpond?=
 =?us-ascii?Q?7ku2dnJdZ2O4FXpoy85MRLpllwWfNp8uKqFSrbqmNmwopJSOyrXxOnnoxXJz?=
 =?us-ascii?Q?Q87KbVTaFnuvjtAobcWlTP9YPupTVWPcIU39u1NfJNhxUnyC7mUy+6GH9i9c?=
 =?us-ascii?Q?+gnpp3TnI2cxhE0BL/s4jA0StD+D+LXrzRFkgG5HFYGgMM3yVpSmKw5Aa+i6?=
 =?us-ascii?Q?NIQYtSTq3v7RYHjtXc3jpm8tfa9YnsBYvEmWo/W6T/Q14FX6yzZxC9IR9piA?=
 =?us-ascii?Q?5Xx1rTCTyOzLObTxioxWJ5ULpDjwg877BZK5XvPLPg5jGSxAhTDjhKGw7Oza?=
 =?us-ascii?Q?Y2v8PekBcWnkPA6YTifZNYD4UEj0RFAseffMq6CxlvLQJBVMqFwyNPh0K7Qr?=
 =?us-ascii?Q?882CAhj3EcjafB9M1pv4T0io+ZatwtRIeJM3vQ2Cr8G5E2EUCJ/DWA048fSY?=
 =?us-ascii?Q?daAydwDl3MTr/dRo8t5Cc33afcvrtT4lPu1sT/r6VKUCmjvFwdLcc5Tr5TjB?=
 =?us-ascii?Q?7d5kdg5w2nC3ja318p6FZv7drld2qU6+M/ny3CTUw3QXq5m8xDzi/sq0+LVq?=
 =?us-ascii?Q?JPk6uGlU+gscn4/Wa/FkDFVOAi/G+UYkwoCI4AidfPgq2PgbgRMV8kBviEAw?=
 =?us-ascii?Q?yLL/ENTzrccLJkJwMxPBpP8PcBE7kYYjRuWZGv6QfQY1EqlacjGG/29+UYbt?=
 =?us-ascii?Q?OFOOVqtQPPvJSR/Tj+oetxpVRPTFSg97C+UPH8j8VQNP03yPiOSITSyrPzxk?=
 =?us-ascii?Q?rUWoCcnHpU1ndqiUcp7f/UvW8KO/ygY1ybEyxx+IhL7Tn2/AeTh3axfp/WOL?=
 =?us-ascii?Q?RDjYk7kKFw3zoMMQLHc8Xbu9XZImjLT+ztLfu3YMs0hvmgGvWKCcZXepViy3?=
 =?us-ascii?Q?xGyzREtLkuedrM/+ourob4AlcsxqviDPokAG0d+vv6UCslL2RmSVX2hD4Bcu?=
 =?us-ascii?Q?bv5oW8LFDDwBFVr585GY4QijPa7nmE/Xp90KuTAYZoJ55GFIZazn+dhombWp?=
 =?us-ascii?Q?gsf4w0ETyCKJXKBFl2WtngIEGimf+iHHuEZ901FZyaAwrOd4AeKZVAUf6mJB?=
 =?us-ascii?Q?nIEmpi3Odn/3ImdrZpbxWtmTU6MHvcqv4baQO8qZmkFS1lVLutpQMEKZD7/O?=
 =?us-ascii?Q?kQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xLJ3bytvaKwCVUw0ROUbgJjUsFngiMKR+GlwO9Uc7ixf2GkeDn2LTiSmuthwAbh8xGhKrXmmqdZs3tLvrIBMHztrKH4ob14b/rX2snoTCn/T2uDhUUHisSnpYb0iOv7XgkLXCvAC+xte+Zi2Fi2V474oJ/j/hApzIqReObOwkupeuRgEXEPAi7fZqHmAe+PtAWCP67ksFNR9PVyO14MbEKWOtBODwvCviANb0IjCU9RtprnAaqgrSwm+bajPqIkMot5Xy529rnn1GoTWl/AEP33MVzPsI+qPsTAMxSYMsJnl6zPcNrRKgmJ0ZtgOgYlgk1FvwDksrTWDsKuLiHsdO3HQ8V35llhoBfoWXJl1F96ApLCgxMf8qk+tjui+v6eNz1g6zX8G7kbiD0SUN9AChYZXIpFAt4OCFUYYKqt8Ooo7nCu+YzT5rFk+eETx4BeiE53WYY5RRPUDCjcJT2UGqIyjD5BPUf/8DE4Uj7G0M/jNcggpPiV0ErcXTWoraeC4w4OXRpvIOXBRfMeGOMbjTs/53bfYeaFjdDnRJjz2IN3h9lvHGBNkpqxtXZqErPJ/8Mh/Y7fNi2km970qHeNa+SKiVPE80i6knU09g50vyBk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af35a4e2-8481-4ca1-c82f-08dccf6b441e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2024 18:31:19.2746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d4IqPqOmL4X1xh51axsWDba2QJvrvYNWv3+UDM/QQT2hoTzMvRs3I4sLfqEa2lvSL6Jh7fsz0YTNvDlnvJjyHUahwuInJwiKjZWhPPx7LCE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7664
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-07_10,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 bulkscore=0 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409070152
X-Proofpoint-ORIG-GUID: w9FUS_AkPigdhqi6hx1WegyQpswV3gZW
X-Proofpoint-GUID: w9FUS_AkPigdhqi6hx1WegyQpswV3gZW

On Fri, Sep 06, 2024 at 10:15:06PM GMT, Liam R. Howlett wrote:
> People keep trying to remove three functions that are going to be used
> in a feature that is being developed.  Dropping the functions entirely
> may end up with people trying to use the bit for other uses, as people
> have tried in the past.
>
> Adding __maybe_unused stops compilers complaining about the unused
> functions so they can be silently optimised out of the compiled code and
> people won't try to claim the bit for another use.
>
> Link: https://lore.kernel.org/all/20230726080916.17454-2-zhangpeng.00@bytedance.com/
> Link: https://lore.kernel.org/all/202408310728.S7EE59BN-lkp@intel.com/
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  lib/maple_tree.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 4f34e50c92b5..20990ecba2dd 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -348,17 +348,17 @@ static inline void *mte_safe_root(const struct maple_enode *node)
>  	return (void *)((unsigned long)node & ~MAPLE_ROOT_NODE);
>  }
>
> -static inline void *mte_set_full(const struct maple_enode *node)
> +static inline void __maybe_unused *mte_set_full(const struct maple_enode *node)
>  {
>  	return (void *)((unsigned long)node & ~MAPLE_ENODE_NULL);
>  }
>
> -static inline void *mte_clear_full(const struct maple_enode *node)
> +static inline void __maybe_unused *mte_clear_full(const struct maple_enode *node)
>  {
>  	return (void *)((unsigned long)node | MAPLE_ENODE_NULL);
>  }
>
> -static inline bool mte_has_null(const struct maple_enode *node)
> +static inline bool __maybe_unused mte_has_null(const struct maple_enode *node)
>  {
>  	return (unsigned long)node & MAPLE_ENODE_NULL;
>  }
> --
> 2.43.0
>

