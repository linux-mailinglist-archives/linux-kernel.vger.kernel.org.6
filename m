Return-Path: <linux-kernel+bounces-387243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A637A9B4E6C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6733F286316
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48E3196C7C;
	Tue, 29 Oct 2024 15:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GU34KO7U";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qKkpHglB"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4D4192D84
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 15:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730216851; cv=fail; b=jjboNiUqPrvtQLnN2rHPbWBUos6zixCfttT4thRHGuU9nx8uUYi6jBi/gAAKq7yls7o6Uyshzi0k5Vmv+m4URwAooJUzbFEjjskexSIwk/pnpwHNajYCZDFv3qwD+Ti4YiHHR5AYJRTd1G2qq/WT7Hoiwjm6l+HmEEgT6YJiPog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730216851; c=relaxed/simple;
	bh=hFvYS+XeUm5o6htDjWpBSND5CXHjL7lqwA50+tLo3/I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Rdn69i/VuYikrfcxiJc4GwGB7a6rBVWvbdBNM4qB8+I2XBab8/J7d+v/e6zoql8k8ZuWYcLReFgiFSEjSUgtwBsoHXzfGBJTlGgEF6i6YHhifKaVRrNM7Ruu92ckQUB18exMrdCWClsZQyVQcG4w6yiioUirpDVJglIMD7U0sfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GU34KO7U; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qKkpHglB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TEtaET015715;
	Tue, 29 Oct 2024 15:47:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=atBt8I0Bs9s1GXX41z6iMzu1MvR/fubCQSoJV6k6bK4=; b=
	GU34KO7U0JL3NUUnHrvywTxOYu1SPiQcMnNt/s131sOgS6PFwXPA9qeJBqAv7mzx
	flpKdBmfZlXHufQJfsAoxjMUnYU2znyv3y3I6TizlcCcK3NagaEoBhX9+3RAy7F0
	fDcSvjR51zLrCqXnhKG5RXepWXgnlPguzqmxUCg+hzu7CoonX/v9rEeXzvMONeGw
	bRe+QzZqZ8RiqEepF3OGEt6cCCB1dbVwZ5hJREdB9ZAAuGd4u3+8cL6SHwkLQYtX
	otzcWE+DECBQTlpbgMfWiuZqJGpfHWhwrM/pF7PCm0zj1WxIV+2vFU7anCCGcvr0
	VtCbDd2xddtsgRxu+O7Irw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grc1wtkp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 15:47:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49TEeY90008423;
	Tue, 29 Oct 2024 15:47:08 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hne9u512-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 15:47:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aZ1V5wrgCwEjS3q6YVszJ+YBA/LedJAt3BK4123bS4mQdcz61pyYkTmYCrWSNFtnF4X4B2hCN5+p50JsuTJ7l0FSLT1mtjFJsXOdYGXZi61DHkpPB1dtYPNZNknNcaBMNOiKyzlFycdB/15ztWY5g+UL0/Xj1wgY0H+Rk7RJB8WsszC1cnhIeKc3zBkQQDXPoDbbQiZ036UMMuT/KWX4kBfHSuBKZ6xl8p3dHqZoDJifZG3CPdeYr2cWr16mEWnIPbK4S4X6mOdxUuYsFULvugoJIqT2GBd5rPLEiXDUBHsTaWefWnESHKpNmhInzTSESxgp9G8ZULemaF7eiuBQmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=atBt8I0Bs9s1GXX41z6iMzu1MvR/fubCQSoJV6k6bK4=;
 b=lA/YhNdm7Fov1cwKYv4B3aJXQkpJFID213yNFJoSP+YyEza6zxRQE+KIAQYfdvl4mPB+f6jAip0XoMMKwLnVIieX+hfBqQ4rV3a/HHtljd5avblKS04rhu5SMtXiieK1wac78CpcfoXQ5G/SH/rgc9tXS+bKv9ZYJre7CXIzxItYh/N9+PMcGGmIdYlWrlif/Tl0W914aczcZ2DW7FVHooe4TXKyiORgyCcpUqGhM4OBA1Ela2YuCutsVrgzpUvZdkJk2pC6nOB/TG3R/eKa7pA7kASaAC63JlEGjF5dTL/Gbd9YOjxG/i2y3nqMR5jd+8OjW47op+elq5Y3a0i1Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=atBt8I0Bs9s1GXX41z6iMzu1MvR/fubCQSoJV6k6bK4=;
 b=qKkpHglBdlW2HAu/oCBjVaTCd8f+Lt2W7CQvkAmPGHne5vEoZNhIWp+TNdBwLTurRieUx4Iil8A1tIA0gcD7lS0Ti1ke3M5kcTqXPzh+kom7FCR/5VjNzjeaQVki5T9ADnT8iTYMxgaCGDwNCF4Bjmn3EpgtrtBff8QnAPkoY2w=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by PH7PR10MB7782.namprd10.prod.outlook.com (2603:10b6:510:2fd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Tue, 29 Oct
 2024 15:47:00 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%4]) with mapi id 15.20.8093.027; Tue, 29 Oct 2024
 15:47:00 +0000
Message-ID: <2eb5fa18-bcf4-40d8-bf0e-8cc92b30de04@oracle.com>
Date: Tue, 29 Oct 2024 11:46:58 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 16/17] maple_tree: remove unneeded mas_wr_walk() in
 mas_store_prealloc()
To: Wei Yang <richard.weiyang@gmail.com>
Cc: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, surenb@google.com
References: <20240814161944.55347-1-sidhartha.kumar@oracle.com>
 <20240814161944.55347-17-sidhartha.kumar@oracle.com>
 <20241024012038.zf3dpqsflnyi4wce@master>
 <b4ad4b6a-f0b5-4ed1-a49a-d4e9ed0e4831@oracle.com>
 <20241025235850.5o6l3k2u2so6hxrs@master>
Content-Language: en-US
From: Sid Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <20241025235850.5o6l3k2u2so6hxrs@master>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR01CA0062.prod.exchangelabs.com (2603:10b6:208:23f::31)
 To CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|PH7PR10MB7782:EE_
X-MS-Office365-Filtering-Correlation-Id: ad49e817-d056-4a2d-b67e-08dcf830ed07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QUd2NVF2SDA4eXNFWm9FTnFpZVZmVlVKZVdWc08zUXdrcmlpQ0d3RDJMWnAw?=
 =?utf-8?B?YXZEKzJBM21XdFQ0c3ZVVmNZVkpDZlZxZWxUZkRqcTJqODBvWHB3RkpDQ2RQ?=
 =?utf-8?B?bFJDbEhMODk2YnNUd25uck4yanc3WTRQUEhuRjNWSXV2b1czSVdEY1VZcVZF?=
 =?utf-8?B?TC9QeVpYUDdMQTJReFRmaDdxMTJVeUxTK3Mxa0tzUnhVNWRKeGp1NlZwRHhT?=
 =?utf-8?B?UzdJNGxqaTdoSUtnb003WG5FemN3MnYxNm1EZm5KNHZVbFFEY3NYd2tsRXBk?=
 =?utf-8?B?S2cxN3dhMm1aQWk3ZjJXUWljT1ArbThyVGFVWXB5TmlPNmpWZ1NQVllLTmxj?=
 =?utf-8?B?L0ovc3FOSEhkYTlPYUhHYzFmWjNIYUk3RTJMbWV6S0pXc2lsa3laczZpSzVM?=
 =?utf-8?B?Sm8zcDZXalArY29nQlhKUWlIQkhyVlFkNEFNSFpDYkg2Zk95ZjlneWY4Q1dp?=
 =?utf-8?B?cTcrWi8xZkR6YitjVTRIcGo4OFdraFZiZmxJVzNDVHlNTzRrN2NFMlRUN1A5?=
 =?utf-8?B?Z1Zzdkt1RStBWWJEaHhMN3RCK0pJKyt1R09EWk51akdxcWVXcTUzMUcvVjNJ?=
 =?utf-8?B?OFFKWHB6bUh4UUZBMDloSzUxNjc2SytUbVVhUHVLb25jd0RSWXhLV2ZuMkFa?=
 =?utf-8?B?VzZIWTkvby92WHBmNTdBc1NkTnQ3Tngyb29rUFg5UjZ0Y1JwM3dwNUo5cWt5?=
 =?utf-8?B?dFpSTEtPU0tJMXB5cjM0ZkZJS1hXcG1OS0RTQXhmUHE3U0w2Y29IRzc2YUht?=
 =?utf-8?B?WG5ZM1p1ZlFJN01vK2R5akFRdTFsSnI0ekxpZDc5NXBnNlA3YXJlMkNrbFZL?=
 =?utf-8?B?YWZuSDRxT3JtdExIdVVmOWZYTVRhN2V1ZUxqM2l0R29TbGdOR201bmpJSjY5?=
 =?utf-8?B?OExRUXFzZ29oMjNsME5oUGo3NC9xdExPSVRvck9MODd6R0Q1WFYzWkphS1gz?=
 =?utf-8?B?NU41czJOemlzUWIvZVJMOEFhNjZqbjdZeE01N3BjT2x1SUp3dmlBZmdHakJ3?=
 =?utf-8?B?elhSMzJjWkNHeVEwK2wzMFptanFROGJFZFl6YmYrV3RVTEJxV01TOVdGQUdG?=
 =?utf-8?B?b2x3WThiNmpvRWFBdlBBdGFyRjVWbnZrOVlRMnVpOC9Wa1hLOFRRMXU0Zk1r?=
 =?utf-8?B?T1RMMmdXQ2pCS0lIWGdWMFVrQkZSRCtUTlppaFVNeFppZkdpVStRdnAxOEJw?=
 =?utf-8?B?UnVEZElRTW8reDI1THFOR2NLRU5sT0srTS8yb2cyWG1CV1M1cGp0SUd6eThP?=
 =?utf-8?B?TzRQMi8wZFROY2RxWE9Gb01TNUg1eXJ0cDF4Y1lYRjJ1U21hUVNOa2ZObHZn?=
 =?utf-8?B?Z1Z0elRBLzd6MzNqRmtzVWc3cGkrOHJ0dFl2eHAya3pYa3VYUmZpcWc3UzdE?=
 =?utf-8?B?YnVEK295MUZnWmJnSU93Wjc4OEFvdzZOcEpUQ1dBWlpVeFlOdGRHdVI2N3dZ?=
 =?utf-8?B?SG1TSEZ3SEJjdkJidEwrSUxWVGhqcEdrWk01L2UrY0QzUlpUbVVBUGhadVNC?=
 =?utf-8?B?SEV1bXM1S1FENmZicEdwM2pqb2Zxb0EyMmJ6V29DeWE2ajRWcFJhSVFrd3dM?=
 =?utf-8?B?RzQ5SFNMM1lic2RFRXNhLzAwTnBkWFErVDJzaEFjR1hUYnl1SFNXckMzYjVm?=
 =?utf-8?B?M29zTVRZcXp4MWZmYmJhbHc0Uzdkc0RIRHV1a21mR0I2NmJrblVaMGY0MkFp?=
 =?utf-8?B?bHN5dDlodnkrYk5IN3JvNzVUR24zL3liOFcxV0xYbzdSZkZmdlpmaWxoRVBS?=
 =?utf-8?Q?3uO4NfVVxXPiKJ1gIpTwibJI7XtX5Z8AtQ1ae7W?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXpHUWJHU2ROejFhR3FMSm5salNRcjFrTWtJRjZTd090LzdFR3hCWVlsUjY5?=
 =?utf-8?B?UGRFVGNmQWRhL0JaZ1VtZ3BreHdneDYyc2lGRTA5S2syTUt5MlVyVEVHUVBq?=
 =?utf-8?B?bUorNmVjK2RPVVQreWJFWTl1bHpJbVpjMy9idlhBcjRuT0FSSEFWWkg4UWdO?=
 =?utf-8?B?L2IyNVQvdmZIeFVyQWF0azI5V1JmeVVWek9rTmFLc1huL1RtQVRLVk5KZGo5?=
 =?utf-8?B?YmQ5dmVVaEg5eGF1alIzWENsUU9kczhUS2dSTlJ4TGZleDZ2T04rOUpuaS8v?=
 =?utf-8?B?L25ia0FnT2lsYWRjNi8yV0JwbXE1SVRBS0ljZlhocU5uSGRLUjNheTM1aGMv?=
 =?utf-8?B?QkUzazFqUWR3QU52ckxORXc0NW9Sa0FSZWNxU285a3R1RzU3OHA4K05kdW1t?=
 =?utf-8?B?OEZicTErZ0lFU3NZaWozWXBZNnlqN3IrVkppTUtkbmgyV0ZOeGIvbFZTK3RR?=
 =?utf-8?B?MjFxN3AxR2cwUzBFSDRObTNISE15U01Rc1BuUlhYd2dnUDFoVWlObWlsaEQz?=
 =?utf-8?B?RElXNENWb0ZpYXc5YnlGd3I4cFdyRGpRT1JKa3Znci9FY1dBT2NaL2xKSnIv?=
 =?utf-8?B?OE1zRDZNKzJvNlZGSHZXbE9jdkRwUVZjSkcxaFJNWXVDL0pxVmxodTBCZUFs?=
 =?utf-8?B?UVRJWFVEQ2g1Qm94dDhiRHRUQ2xUdDN0eUh2aUVKT1VUY244amh5UUtmMHV4?=
 =?utf-8?B?U2xtb3hkdUxoUmV0bzJpOVdBTjZZa3V3cmF5aDRHMWZTQ2g4S0RIN2hiNTA1?=
 =?utf-8?B?MDllb3ZPUThmYXZRdXlGcGZpb0FpUWdwT1lUTFZBS1VxZE5oL1h2RmlVWTI3?=
 =?utf-8?B?OTBxU2w2RTVxUktrRzZaMDFTQ1ZkSWgwd2FieG9oQzRYbG1rcFZxNTlrTTlZ?=
 =?utf-8?B?WWIyRW1xdW91b0NKVnVCcDRhbWJmNzBJTkxXSDQzQzJManlKeXhBcDFzRm9Z?=
 =?utf-8?B?b1RaWlB2Qk9vTTltaVgrRG9qUHQwUHFrRmhkd291cEF5VTJXQ04zV0Jjakpl?=
 =?utf-8?B?d25iVExZNmNQd1ZGbENTQ3h0TG1xN2UybFZFb3pNRXluU0o4WDB3bkpJTzU5?=
 =?utf-8?B?eHhNNDk2NVJlczYreUFmS2F4RkltVkFwc0Y2ZjBaS0hvbThCQmI4aGt6UkVS?=
 =?utf-8?B?ZFhBeDQ4TFp3akhnNldVVEJsc0NJQmd2L2h3Y0dpY3JkZk1WMlJOMzNwaHRw?=
 =?utf-8?B?cW4wY2hEa1BTb3VLZGNuMms0YjhCcVNtV3AvLy8wMkhsaHFQaEFvTW1GZ3Vi?=
 =?utf-8?B?MDhXRnhnT2tJaGE3eW5DSWY2aERwa1NtTjY2dkRjdUJBYSt0NVNRSG56M3du?=
 =?utf-8?B?OG5sYS9EcFFRdWwvZ2VBZXRsTHY2VURveHVjdjVUdDBBcjc0UzhSTnYyWC8y?=
 =?utf-8?B?cC9BSFNsTTk5NTR4U01Bdy9jQjVaYmx5N2ZEZ1duQmJKYit0ZkhzNW1aK09l?=
 =?utf-8?B?MTI3SUlWaVU1QzlBeHc5RWRld0tuRWJlc0Y2UCtUc2hzM05iWkpxRVFiZ0hp?=
 =?utf-8?B?cVZBdm5vdjNCcWErdnZDVTJBbXFwTS9VYUw1NTc3bW9jUnZPaEFKK1ArOTZE?=
 =?utf-8?B?b0w5NWJLczlEZkRaSmkySTdmMk5tZ0tVcGVMd0liVzd1RXR2VmdvTUNjTFpu?=
 =?utf-8?B?T2JYU0Fnblcxb1lJdjMySWRaMUFJeGh0QkNsWUI4M0pnVnlsZHZycFFLNzV6?=
 =?utf-8?B?VUZONy9FTWlGeEJmSkE0Ti8rZURlTnNVZjh4Z0lxckJLakhKSVVZL2YvRzhl?=
 =?utf-8?B?VHA3TXZyN0M4MWpUK2hneVltNFQ0Z0FWaDFzaXlDN3Uxb1Q1QW13QjIxRWtn?=
 =?utf-8?B?ODVUWXlwUVJGL3c4YUN5VERsQmtLbFJ5cG9Jd1pBdjhGZEloV0l0aUw1WE1R?=
 =?utf-8?B?d28yRldBb0VLaE1oaGp3NWVoMmtrZEhwanJlT3NPeGwxdVZMU1VaNVVGUTFp?=
 =?utf-8?B?Nm5KeFgwUjdlZC9oY2JIdnNGUmlkWis0N3lwamg1Yk1ETnFicWZ6aUFyZUtT?=
 =?utf-8?B?bTE0SkJrNjI2QUpPYnZKYmlobk16VjNrQVhRdFE3dHE3TlovZkxtQStFbVAw?=
 =?utf-8?B?ckNXRitQTFJJODRObE9TVTZJQkxORGR6UWo2LzE3UTlRRFo5cy9malZYbXcw?=
 =?utf-8?B?YlVQNnVnL2hXWmFRTVlIS3U0emNJbHlkbjd0YnRueGRJWnhiaFRGai9JU0hG?=
 =?utf-8?B?aWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/b/owMLuo9DpCZIdnLfSEkQQRkssaoKpyOVc2c9i0X8qceiD/fZTjVHeMDjiisbWIMAVFNEG9tE69qJkoTJAp8A7d40+6mBgVYU5MG36PxaoxZNesJJww17mPC1DQbejznaO7ZmoUvAyGRslFiuM4RfpXnUFePZ5NUWaM4zgizu/sjSi5PUsmM6yhl8qG0XS539oUEK50JzMzqy6dgjZxPPiXwMa2duCEZxSzpC/ODSqf4vIVvd3Chk0YD6GjGNJIL/sHP+Uo7E4pm3UgAI2LLkSHaMRny1xx0QVyxcT/SmVpsTilL+Mjo9i9Y5REwMdW0h+q3XzTF4LfeV0RzofACW3gN+8tO9x/NGPWURgTo98n9plnwhfJsusd+L0XFkrcySk44CXmJ1v10k0UjlxCooOg9NEBwCn9MjAVFIMvSHOrLh5tXKdV5d3me0zHH/tTK3+4q24WP8StHSFQGl9v4w3hLEQzYWwAKSjbDshC5ojLBC5so3UnCrXezLo2kGs/1VsOUdhy+opTpAxMJ0jKxQzjlGwT0QXkgWunpvfgZxyos0jU62oQpBlEyGo0YfB5iLzcTU3y7WfliSVKA6AP7qQ3jwCHTVHe3lyxueotbI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad49e817-d056-4a2d-b67e-08dcf830ed07
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 15:47:00.0345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9zyn//0ZnihPgzY+vYKGn5sguxd9utlTAJA4qQeUf62qlmroyoGlQIAwI3XcJkY7inEaD1FfXec5k779tNCudibuPSisa3eWsXPrZDS5KJQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7782
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-29_10,2024-10-29_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410290120
X-Proofpoint-GUID: IM5hfXjrmxx8HSfGQjWU63F60sKnF1sr
X-Proofpoint-ORIG-GUID: IM5hfXjrmxx8HSfGQjWU63F60sKnF1sr


On 10/25/24 7:58 PM, Wei Yang wrote:
> On Fri, Oct 25, 2024 at 03:54:04PM -0400, Sid Kumar wrote:
>> On 10/23/24 9:20 PM, Wei Yang wrote:
>>> On Wed, Aug 14, 2024 at 12:19:43PM -0400, Sidhartha Kumar wrote:
>>>> Users of mas_store_prealloc() enter this function with nodes already
>>>> preallocated. This means the store type must be already set. We can then
>>>> remove the call to mas_wr_store_type() and initialize the write state to
>>>> continue the partial walk that was done when determining the store type.
>>>>
>>> May I ask what is the partial walk here means?
>>>
>>> It is the mas_wr_walk() in mas_wr_store_type() which is stopped because of it
>>> is spanning write?
>> Yes, this is what I meant by the partial walk that's already been started.
>> It's the walk done by mas_wr_store_type().
>>
>>> I may lost some background, so the assumption here is mas_wr_store_type() has
>>> already been invoked and the store type has been decided, right?
>> Ya users of mas_store_prealloc() should have already called mas_preallocate()
>> which does:
>>
>>      mas->store_type = mas_wr_store_type(&wr_mas);
>>      request = mas_prealloc_calc(&wr_mas, entry);
>>
>> to set the store type and allocate the nodes.
>>
>>
>>>> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>>>> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
>>>> ---
>>>> lib/maple_tree.c | 18 +++++++++++++-----
>>>> 1 file changed, 13 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>>>> index 8c1a1a483395..73ce63d9c3a0 100644
>>>> --- a/lib/maple_tree.c
>>>> +++ b/lib/maple_tree.c
>>>> @@ -3979,9 +3979,6 @@ static inline void mas_wr_end_piv(struct ma_wr_state *wr_mas)
>>>> 		wr_mas->end_piv = wr_mas->pivots[wr_mas->offset_end];
>>>> 	else
>>>> 		wr_mas->end_piv = wr_mas->mas->max;
>>>> -
>>>> -	if (!wr_mas->entry)
>>>> -		mas_wr_extend_null(wr_mas);
>>>> }
>>>>
>>>> static inline unsigned char mas_wr_new_end(struct ma_wr_state *wr_mas)
>>>> @@ -5532,8 +5529,19 @@ void mas_store_prealloc(struct ma_state *mas, void *entry)
>>>> {
>>>> 	MA_WR_STATE(wr_mas, mas, entry);
>>>>
>>>> -	mas_wr_prealloc_setup(&wr_mas);
>>>> -	mas_wr_store_type(&wr_mas);
>>>> +	if (mas->store_type == wr_store_root) {
>>>> +		mas_wr_prealloc_setup(&wr_mas);
>>>> +		goto store;
>>>> +	}
>>>> +
>>>> +	mas_wr_walk_descend(&wr_mas);
>>> This one does not descend the tree, just locate the offset in a node and
>>> adjust min/max. So not look like to continue the partial walk to me.
>>>
>>>> +	if (mas->store_type != wr_spanning_store) {
>>>> +		/* set wr_mas->content to current slot */
>>>> +		wr_mas.content = mas_slot_locked(mas, wr_mas.slots, mas->offset);
>>>> +		mas_wr_end_piv(&wr_mas);
>>> If not a spanning write, the previous walk should reach a leaf node, right?
>> Ya that's true.
>>
>>> I am not sure why we don't need to check extend null here. Because we have
>>> already done it?
>>
>> Ya we extend null in mas_wr_store_type() which has already been called at
>> this point.
>>
>>
>>      /* At this point, we are at the leaf node that needs to be altered. */
>>      mas_wr_end_piv(wr_mas);
>>      if (!wr_mas->entry)
>>          mas_wr_extend_null(wr_mas);
>>
>> Thanks,
> Hmm... if we have already done this, why we need to do mas_wr_end_piv() again?

The maple write state here is local to this function:

void mas_store_prealloc(struct ma_state *mas, void *entry)
{
     MA_WR_STATE(wr_mas, mas, entry);

so we don't retain the wr_end information from the previous call to 
mas_preallocate() and have to repeat it here. The write state is not 
currently exposed so have to call mas_wr_end_piv() again.

Thanks,

Sid


>
>> Sid
>>
>>>> +	}
>>>> +
>>>> +store:
>>>> 	trace_ma_write(__func__, mas, 0, entry);
>>>> 	mas_wr_store_entry(&wr_mas);
>>>> 	MAS_WR_BUG_ON(&wr_mas, mas_is_err(mas));
>>>> -- 
>>>> 2.46.0
>>>>

