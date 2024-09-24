Return-Path: <linux-kernel+bounces-337206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED259846E2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 15:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50D1B1C22897
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 13:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A414F1A76CE;
	Tue, 24 Sep 2024 13:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W9jEOrWR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bNh87+7s"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDD81E505
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 13:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727185175; cv=fail; b=QpgclA74NKCIYbcgfiXgd8SrK65Jh5EB8D1ZUVbz1+ueiiIgNgm4Qh0UjirPkwhhlPCdoBsQwWwXmq2F7Thl4acd1FHNBpfvovsPVxKK1rO9UbDqbDO7pxqRUkViW4FqWs1H3Gj1Jq644ISUAWJa34R7BOHRCXOV7bxbeFNd3jM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727185175; c=relaxed/simple;
	bh=ZckaSk5t9LDEjkCtvV7oBsg+wKMR5WXqQDjrFBmUj/s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kf08cZuNglk2AxHVJ+0tvGKWmdu0TBcjpAUIKONQePqFr/l8pmK1eFgd6ccg44wi4kum8rX1sJhbNPHx2XaYmUItawFVLG7xAUAGYCEXRaXSk3tZVingjTREzWWuomN1f3eVLEmYPPrmMXFSqdNPN8qtrzAs/lr3Rn+WneVIEpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W9jEOrWR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bNh87+7s; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48OC9HeC026479;
	Tue, 24 Sep 2024 13:39:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=xzas9ca4BUNAQj6LmVZaMmWmtZDSZlgxcTVzlpvEFdU=; b=
	W9jEOrWRnsndAEZZUM7W+q4IW1j5ZUK6GIhQAYuUtonDYEJQN5tiaRmSdO4968tG
	lIErE/Bu3OgMwRibFQljuVd7T3w3Q3rKakVeZLKPRvBp7DPo+tab/K3aC8ip6+D5
	FnunINwSaOj36q+R39QfN7ZLf3632xBA2E2yTsE06YGGfKznUaqtnozlsiRdx6mm
	cmNjYxT1/Nk2Jq3JQr6I5u5rHDqisYzHmF8bkZVTaFWK4PCXl2ZvN3y3211halIr
	/SSW6WLxbiqGwMYIbVq3ZyeucwTbYTxRVq5DOXpzmFwUDEl26yX13nVDBAP4nFjI
	dBs7sPQFbFxaf1oiiOanYQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sppu7euv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 13:39:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48OC3HCR024275;
	Tue, 24 Sep 2024 13:39:06 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41smk987a2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 13:39:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V9j7aQUGk1QXzPYR5fnmUje7WbG+KgQ3Qp0U436BGPnbW9TOv8yyjc1/BG2pFDqFW4UbxqgekzqE8B6SZcOqSsu0XzwDvGa5mpYLN2KkG4+oGVIJG6Tb1uHLgyc4pRydk9YR7mn3sMh81clSE2FOYbeI2hPT7ZPb4x5HPEECqpYkgQ9SSL/+/lcr+IDSxmjFzhE90TkFikkkG0vHQ5f1Xb2CVJDaI4cxTvN03dFi+qLiRyLTRk6HD21XvFo7bqZWQcnqUkdAjmswW7rXKzyjPHXgobsO5DIZvbLVFO6QtEzKEut3fx2eppbHgS7RNrwLZp7kZVzMx/SEEfSWNhgCwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzas9ca4BUNAQj6LmVZaMmWmtZDSZlgxcTVzlpvEFdU=;
 b=JmehfTu+Z+lhauD21HAsskgBEQ8JXc0n63ciiLllTmI5zAoUYwuFdzeg4N5BDnvN4S2mAmP8BWC5kSe/RuerjbttYU3EBcM2bPlsLRR+OHDo/Zit8nu1sd1AFYJc2+yYJFFjTU6TtRg1PHhBsxmRbItVXZ/mJmo19PQbE7835xiCg+RUJ7HU0ZPdY2A45IeTLybX/CrlsiNiyRg2jYwAu3bj8zX+0KmTtN8x+3lAxAiB+/1Qzh0pxjh4fImctxDv3HCs+ttksDMOkKk1MA1zCMEnOfUreORNcSETD+aQESjTutQYUFkGzHiYWg1i3sQIgr+0YMetEttgEh/6HTzqjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzas9ca4BUNAQj6LmVZaMmWmtZDSZlgxcTVzlpvEFdU=;
 b=bNh87+7slfnMmmzxTR7sDVsViGOtZ1sm237CitvcZMpiJVsMHg3ASeXk/JN0OYSH3ZRgAY7NX0shA8T17C1fcoJuNSZRlFgMbrUbESMNXka7wDITNAoxAKELtBfOYjN3GxsnMOxuzKkBe5ISSUGTPXCxqymSsSJl2049/ThUqyE=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by PH0PR10MB4629.namprd10.prod.outlook.com (2603:10b6:510:31::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.13; Tue, 24 Sep
 2024 13:39:04 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::187b:b241:398b:50eb]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::187b:b241:398b:50eb%5]) with mapi id 15.20.8005.010; Tue, 24 Sep 2024
 13:39:03 +0000
Message-ID: <0fefb36c-7f4a-44cd-a9a2-57a07c2392ae@oracle.com>
Date: Tue, 24 Sep 2024 08:39:01 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] jfs: fix array-index-out-of-bounds
To: Ghanshyam Agrawal <ghanshyam1898@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: ghandatmanas@gmail.com, jlayton@kernel.org, eadavis@qq.com,
        brauner@kernel.org, jfs-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        syzbot+808f3f84407f08a93022@syzkaller.appspotmail.com
References: <20240922110000.128650-1-ghanshyam1898@gmail.com>
 <c9f80af9-4cf0-4b6e-8c61-4b7a6f287cd9@wanadoo.fr>
 <CAG-BmocfstJNC-JDgtx93EJmg5kMANu4tVRbjqYtZ1CE+AEnEg@mail.gmail.com>
 <470de7f0-3f2d-444b-a949-9db6040cf371@wanadoo.fr>
 <CAG-BmocmdoLv5AR0p69J6JMOwrrQAn32ProJWzH=x5AyeZCfeA@mail.gmail.com>
From: Dave Kleikamp <dave.kleikamp@oracle.com>
Content-Language: en-US
In-Reply-To: <CAG-BmocmdoLv5AR0p69J6JMOwrrQAn32ProJWzH=x5AyeZCfeA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::31) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|PH0PR10MB4629:EE_
X-MS-Office365-Filtering-Correlation-Id: b8d614c9-6cb1-4aa2-fe41-08dcdc9e4147
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T1hybVZiZUVHb1R0RytRVXpRa2gvN0ZWbU5jWkI3azlyUjgwQm5rZXpiN3hx?=
 =?utf-8?B?UjBoWW8vV1RQZ3c3YmV0SElLYnY2T1VVdlZUTy9yRTZGT05LUHVuNmxVWEdH?=
 =?utf-8?B?NGdZUzNJVGN5MVZCMTRQZDFIb0tZSGRoeFcrWjhMdkN3YlNUWHRSMUJ2dFN5?=
 =?utf-8?B?NFRYT2tvOTlNYm51QjZnd3UvMXV4Z1VWeE5DVmE0cHhlWHB0NTF4dlN6R2Zm?=
 =?utf-8?B?UFJXaDl1S3Nxd1hpZTJqMTVRd2sveWNjVFJ1bGJUbFpiV3dCaWFDd1M0U1Vi?=
 =?utf-8?B?VXlVeWVDbFdpOXBoWXlHQUdNT09HVFNaY0tkd245aXN1WVF4SUM4Szg2T0JI?=
 =?utf-8?B?K04weUtlOWx5elhXNUFOL0ZBRGE3TVRLdmkvNm82V2RuVHhidE00amhBTmJK?=
 =?utf-8?B?QUxCZ2xBeUZmblFhT2VQbjNBTG9rMHFjeDhGTmE5d0p1UmYxUEJSTUVXUmNZ?=
 =?utf-8?B?ZUJTL0txRnE2RExrSDc2Y2lHQ1pVZTUwdFhGdmpUblBZVGpmSnh2bHZLR0xy?=
 =?utf-8?B?NE9zTnFoUk0vWEU1NmdRME5MTGhTdEUvQW1ISWRHc2JvcU1qcDhWZm9mSHBx?=
 =?utf-8?B?SDQ0R0JhMnY1Y09ERlZoTEJ3V0ppUEtJTjFCUlZVaUNHVGl6Qko3S2tpV1p5?=
 =?utf-8?B?K1IxaTVSQmN5b0JnZVpmVkIyb3J4c0pwb2hTdEFQRTBnRGYzdU9melpzOXk3?=
 =?utf-8?B?UHFxeW4yUDA0RUZUT0FCNlhCUlJld2JQQUZHM0ZmNEx6dzJ2eXdPeVNLa3JQ?=
 =?utf-8?B?eEo2N0FBZ3ZzMml2MWc0T0w4aWZyYnRQdTJMVmxXQ2JnVjE1K1JDQ3BscVpP?=
 =?utf-8?B?WnNzU0JwRlpUWmNxVTBaVmtFOTh3QWNyaklCbDJNMzc1enB3ZDNNZlBuTENY?=
 =?utf-8?B?WVJFc2xiN3YyYmF4YWRIUnlSSTJmOGZZMVBjOGhqTTcwWUs0TXpKMUFzL0JN?=
 =?utf-8?B?SHhXcVVIbitnU0hJcUZRMVZHUHFxbHptNitadXZ1eGw5SW5FSjRkMGt2bjFL?=
 =?utf-8?B?NXN4ZVZycFQyVStmMk1CWDYrVXE0YUpDTzFMd2ZFVHFKSjZnMnNmcFJYY2dq?=
 =?utf-8?B?UnVNaWFoRnVUaUFLMmZzbldWSW5teGdDcmJwdU0rNWNuSzZGbytZU3N1VXFj?=
 =?utf-8?B?aCtLVFVUemZUeDBUUk9LZE9jSlQ2ZFA1emp3M2ZVUUxEaGJuRTRFR2xpV20w?=
 =?utf-8?B?ditLR3R0dE9vYnpNcUJ3dWZhZFR2a3JhbnUxMytva3Via3UxTEl1SGRyOUJh?=
 =?utf-8?B?VERnelUzTlhTNENUdDEyUWV2ZHArWVlKRHkwTDRDY0xBbGg0NUZrSmRHVisx?=
 =?utf-8?B?UTNiNityeFVyYnUzNVZPZm91dnRGZGlGVUVoTU50b3UwalR4am9WNWNoeG1t?=
 =?utf-8?B?TzhaSnovNnJIOWFVc3NNYnJ5eEJwVlg0QXVEZmFCdzVoMVEwbVRuN3ZTLzhQ?=
 =?utf-8?B?T1Z5TUwvQkxzK2crWmF0T3NyY3d4SnFwcDhLenVSKzJzcTM4em5nTDlJVnRT?=
 =?utf-8?B?SkNWQXV3RGpldHk2ZEtqbHIyc0xKa2Z3RThKZVNNSm1BczU3a3VxcmZ3Y3h5?=
 =?utf-8?B?c0I0MldmUmJhWEx6Z0RFLzFtQTNXb2ZWS1FtRnZhK21CVnVUL2xrWlpZUzha?=
 =?utf-8?B?Z1llTWF3Zk10Ny9sanZiazVpVGx3RGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTgvcVdCMTRWWTB1K0tTcmxWOGZRbXlIRDRSWk94SlhpSVhvcys5cjBiZnk5?=
 =?utf-8?B?ckZMZXBDb2o5V2NKM2RUUU9IZGZiME5NZzQ4WTBYQlhZQW5mOEdCd3BZdnY2?=
 =?utf-8?B?ZlV3T1RNeURmaHlpUHo0SHRKWkJzVjdoL3JpZ2hmNDl3bUdUN2ZlbkMwZS9R?=
 =?utf-8?B?SEh6OFJMVjVQaVVqVlNIYVU0b1FtRWxpN1RUYW1GbGtERW9hcm00ZVhWQ2ti?=
 =?utf-8?B?eUNoOUFLbmdGc1J3ZkFjTGhCaStuSUlaelZrTThOOVVFZnBoYjhMUnhVQWtS?=
 =?utf-8?B?dlAwZ2oxNGgvVE5jUmlUeWl6WUl1MjNnbk1DSExUYzkzWFpNZkxrZTRKMUJw?=
 =?utf-8?B?cytFcFFIZmM5RGp3a2t4S000YzE3SU0yd2tZSi8rSVZqcG50VE8yTXp3Q3Z0?=
 =?utf-8?B?dVZEeVZtVmpwSEwvK05EWHhpNXQ4M2M4TjhzYWUrdk1iYW0xZFRFZmxSQmlJ?=
 =?utf-8?B?dVg3cEF3cWtkY2V2QjFQbDRNTk5pNkU0eDJERCtKSEhMY3RQT1dJMHhoMERi?=
 =?utf-8?B?K2lxdXdZaDcxRHEvOEtQWHBjWHNNNDZhT0F1OTZhZEQ1VUlwVlZoSm9RZ1Jz?=
 =?utf-8?B?S2ROVlpwaTl5NEpycEtDY2dveHBCdWJ3Y2hsaTVLL00wciswbkx2TEhHZGhv?=
 =?utf-8?B?QnM4NXhzV2Q4NFVHR3M3aEFtY25sWlM1YUpzUHB2U2JReFZWcjdMa1htVVlL?=
 =?utf-8?B?OUNhT3VEcVFyaE9RZUpXWU8xamwxQ1g1QWpEV1JzS1lQM2NsRUZBbk0rMUE1?=
 =?utf-8?B?bmNOYlhDeXBNdno3OUp4cHd0Mmgya3hMaEczb2FhdVQ0bCsxc285QWRub2xl?=
 =?utf-8?B?K3RiSWxNN1J3a1A1TFRhOGdVSkpQd2t1SzNCcDZVaWExbFJnVzYrOFpZWEhF?=
 =?utf-8?B?cldIdTJmSkVMMVJPRVhIQitUdDh3SkpHUDQweUgvOHMrMG83TjRJSEdHamdm?=
 =?utf-8?B?NnJ4SkQrdlVyNFI3VHFOREg1bFJzK1dqSnQ0N1pCRlIrRGFHckpySVc2TXBW?=
 =?utf-8?B?WjB5TzA0MXVkVFVSZTZOL0JqSTFyZElTWkdTOTZpWTU0Y2s2M1R3WWVYTVlM?=
 =?utf-8?B?ajViYkFyMUIyZTVWSUt1d2ptaU1sU0lhMVpoKzRKRDM3WUgxbjdtYysrWnZo?=
 =?utf-8?B?UnVkRTA5WlZSNXhOTXgwSFZXNEdIZE9zeFU0SHVMakRreDRmejcxMjRqOVV0?=
 =?utf-8?B?VElUTlQzUzBhbjRXRVc3Q0ZmeEhvejFxSGUxUWsyaGxFeUtHMXVwTDJHaHhD?=
 =?utf-8?B?bmR1RFJ6TDFGbnRQZTFHQTIwQW92a3JQUXVEeXdPb1M3NFlhelJpUHNDeGJk?=
 =?utf-8?B?ekhHMEQvazl2SGpZSE4yOU9KV0tlY3F2SDI5blo1K01iUE1ad0UzY1pHNVg5?=
 =?utf-8?B?RUJUK1NIMER3QWJQRWc2dzV5YSs2OEpQVkl5dXhRbUxMNk02TDFKVVl2QzdJ?=
 =?utf-8?B?Wk01a0xnUFVzckFtWmUrVFlKZmo3Nm5rUHQxOUF4SHl0SkJ0b0ZLa0VleXpm?=
 =?utf-8?B?aGZYYnlGLzAyMVlPWm1pd3Nza3o2S1JnRDFUTERnalpRS3lMWE1hVFkvT0Fl?=
 =?utf-8?B?OUl6YXRiVVZqWHcyZk1IYzhicVFvQlZGQ1cwVnpRNG1IM2xqM0hIN0VXSGNM?=
 =?utf-8?B?WjZ4STdXYWZxVTlyQkRPOEtKbE9Qa2VXcGVHcUdaWGlvZjN2ZVIyQ2RNN0Fk?=
 =?utf-8?B?NGdmS0s2OWdkY1pmU0l1SHozZDRVb1F5eEhqYUZMcWUyNko4T3l1ZHR5a3pC?=
 =?utf-8?B?N0dWVkt4bnhTSFB2dGQ2b2M0VTRTR3FMclBVOU5FT3V2djdvTGp2MjNteXdN?=
 =?utf-8?B?WW5qd1FrZ3FjTXpOR1VXUHNxQTl4Rm90RTNjT0tyR0ZrU0pSY1g5WVFxc3RE?=
 =?utf-8?B?ZFNWTFZvdHhxM0JRS1R3c0pLcExXR0E1L1JVOHhjSnMzUzFncUtiNk1hZjlV?=
 =?utf-8?B?dWFEbTNWeEJucTJvZzJseEVndkRXeVdYNnhnV3NJSjdkSmZOdmtUdTdZakF0?=
 =?utf-8?B?WUhydDhOMXFNeFZtei9mNERDdk1Ib0pPcCtXUVprZVlZUkZBMkFJOWZiZTdN?=
 =?utf-8?B?dGppMWVqdGc0Zk9qRkx0RGw4VG1ObnNUc0NEREp6U1NhU0dIRTZTVHR2UUtB?=
 =?utf-8?Q?ky91J06yDUfXm5RdBBuEXGIa3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/oTnRAu60RewMUhN4rV5zBAAcew3WxByuU1IkwwFk2hhR7Y9488dzt4D+u2nqlKOQ5hNOiQtMWGdKqZnjgAHWFVorXJuNKNmMO8Vh4JW6sfndHR0kUli08cOrQIyFOTLf4DF05n/zIf/7+SqhQL2jKzB61Dl8hZTczXebHxLQ2oAquTJ/Jk30WJDTqNGzhPWBc1XKr1396xrJNhqIiYFOexi38iQO0BL4mok26lZTB/79JUlziIFPFiQyD0VTWqTjm2qsxJQ1ooyfLK/oDkYWH1NOne0IfOMKfh8DO5tI5XT0ZLzxviaZ/sVvqSqjWqxOIWSQKiRdjxXX4Cldmas7Vz5QKRTnFfzk1c3dCyeLQ+1GVPul7hj2mCYEF1rIy5gjAwnFukFOeO+Kl0PmYoeMUQXqwQxmDtrrvvbYQDwJmN6QGkA7QAVUqv2Lh8CCX+BRjZQ0FbiER9+0JndrZc0S07HD8W2r0SfPzy7NbYqgxRG8p/VpLkKRpVWkW1wH/IVSf6Itmaj1CLqSY3Ju4nT+vkN7Fg81W3FS14bpeupJL7O5mJxxgbDatiixzzOeeJVOpplMag+db3YC2/W4/5tPeZcT2e3Hom/BemJxeG3+IE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8d614c9-6cb1-4aa2-fe41-08dcdc9e4147
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 13:39:03.9183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 63mPJa8LaI10sUGnnsbLm5nbJYEigHeA1Z/B0OLQfwP8LncZzrsRCpZtT7uIrXfqLtilPs2T4qxQUjBSI10dQtdy5sdWtwMUqpvkljTnheI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4629
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-24_02,2024-09-24_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409240097
X-Proofpoint-GUID: PZsusGJ-haOgDKox_u4bQLya6aCg255x
X-Proofpoint-ORIG-GUID: PZsusGJ-haOgDKox_u4bQLya6aCg255x

On 9/23/24 11:52PM, Ghanshyam Agrawal wrote:
> On Tue, Sep 24, 2024 at 2:15 AM Christophe JAILLET
> <christophe.jaillet@wanadoo.fr> wrote:
>>
>> Le 23/09/2024 à 05:35, Ghanshyam Agrawal a écrit :
>>> On Sun, Sep 22, 2024 at 8:35 PM Christophe JAILLET
>>> <christophe.jaillet@wanadoo.fr> wrote:
>>>>
>>>> Le 22/09/2024 à 13:00, Ghanshyam Agrawal a écrit :
>>>>> In some cases, dn_numag may be greater than MAXAG which may
>>>>> result in an array-index-out-of-bounds in dbNextAG. Added
>>>>> a check to return an error code before we crash.
>>>>>
>>>>> Reported-by: syzbot+808f3f84407f08a93022@syzkaller.appspotmail.com
>>>>> Closes: https://syzkaller.appspot.com/bug?extid=808f3f84407f08a93022
>>>>> Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
>>>>> ---
>>>>>     fs/jfs/jfs_imap.c | 3 +++
>>>>>     1 file changed, 3 insertions(+)
>>>>>
>>>>> diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
>>>>> index 2ec35889ad24..5088da13e8f1 100644
>>>>> --- a/fs/jfs/jfs_imap.c
>>>>> +++ b/fs/jfs/jfs_imap.c
>>>>> @@ -1360,6 +1360,9 @@ int diAlloc(struct inode *pip, bool dir, struct inode *ip)
>>>>>         if (agno < 0 || agno > dn_numag)
>>>>>                 return -EIO;
>>>>>
>>>>> +     if (unlikely(dn_numag > MAXAG))
>>>>
>>>> Hi,
>>>>
>>>> looking at other places with checks with MAXAG, I wonder if it should be >=?
>>>>
>>>> CJ
>>>>
>>>>> +             return -EIO;
>>>>> +
>>>>>         if (atomic_read(&JFS_SBI(pip->i_sb)->bmap->db_active[agno])) {
>>>>>                 /*
>>>>>                  * There is an open file actively growing.  We want to
>>>>
>>>
>>> Hello Christophe,
>>>
>>> Thanks for reviewing my code. I believe the greater than symbol I have
>>> set is correct in this case.
>>
>> I think it's not.
>>
>> If you have "if (unlikely(dn_numag > MAXAG))", then
>>
>>          - dn_numag can be = MAXAG
>>          - [2] - so, agno can be = MAXAG as well
>>          - [3] - and, accessing memory past the end of the array will happen,
>> because db_active is atomic_t db_active[MAXAG];
>>          - BUG
>>
>> Or I miss something obvious?
>>
>>> Can you please check it thoroughly and letme know wny it should be >= ?
>>
>> Well, usually things don't work that way.
>>
>> YOU propose to fix something, which is nice. So YOU should explain why
>> it is correct.
>>
>> If I'm correct, the way to see that your fix is incomplete is just in
>> the 3 or 4 lines just above and below your change.
>>
>> You've been told what could be wrong, you could have checked yourself.
>> Or explained the reasoning that makes you think it is correct.
>>
>>
>>
>> Sorry if my answer looks rude, it is not my intend. I just read your
>> answer as "can you do my home work for me", which is certainly not you
>> intend either.
>>
>> So, no hard felling, but a bit disappointed by the lack of curiosity.
>>
>> CJ
>>
>>>
>>> Thanks & Regards,
>>> Ghanshyam Agrawal
>>>
>>
>>
>> [1]: https://elixir.bootlin.com/linux/v6.11/source/fs/jfs/jfs_imap.c#L1363
>>
>> [2]: https://elixir.bootlin.com/linux/v6.11/source/fs/jfs/jfs_imap.c#L1363
>>
>> [3]: https://elixir.bootlin.com/linux/v6.11/source/fs/jfs/jfs_imap.c#L1366
>>
> 
> Hello Christophe,
> 
> Thanks for your detailed answer and comments. I had done my research
> and couldn't find the reason to change the operator and then requested
> for your clarification. I should have been able to do that. I will work on that.
> 
> Thank you for taking time to explain me your thoughts. You are right.
> The operator should indeed be >=.
> 
> I also just found out that someone recently fixed this bug and their patch
> has gotten accepted. I wonder how I could have found that out before
> working on my patch. Since they neither sent the patch to syzkaller for
> testing nor did they include the fixes tag with a syzkaller link, I couldn't
> find it out. Maybe they found this bug from some other channel and
> not syzkaller. I will find a way to address this as well.

Just catching up on this thread.

Thank you for taking the time and effort to fix this and thanks 
Christophe for catching the >= thing.

The prior patch that fixed this was posted to the jfs-discussion group, 
which is pretty low-volume. It could be somewhere you can check if you 
are looking at other problems in jfs in the future. Sorry you had to 
duplicate that work.

Thanks again,
Shaggy

> 
> Thanks again for taking time to review my patch and discuss it
> with me.
> 
> Best Regards,
> Ghanshyam Agrawal


