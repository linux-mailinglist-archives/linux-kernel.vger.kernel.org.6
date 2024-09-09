Return-Path: <linux-kernel+bounces-321141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59003971521
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 118C52838AA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71881B3F08;
	Mon,  9 Sep 2024 10:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="npMtz02e";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YgDVJipH"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A59176FDF;
	Mon,  9 Sep 2024 10:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725877043; cv=fail; b=dMtQFTJ5SnygbH/RXwcRAY+1+QiB/FNRmVoR+uFPxJURGURh8PNXMJ9Kej4+dcf3/XZJoAcqoXLKnMdBBFMg4aA2ahfDh9WmEdgsLXGHpMPgT7+TFoiJYTemUHLoRucReAmwUQoWMOg+iN4NMH2QgoaH2P6YErCclJdquR90dow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725877043; c=relaxed/simple;
	bh=fS76QFtlpGWTPeLMARDoS0UQkz8FL9Q2nm/Xa9OodZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ga2J03agcU7wGPdC35KFVw66WTWVHlhP0aW29755PozI70M3RDVwNW2jvpkXGUYzsAefj0uszGLTQPC9bkdEpOA8XbUqMDli3pe4saJOMxWs3DS6tdZkLv9uRc39hLFy8+jmrKzIdIZxHoksDbajeCXSdPIsUjd9nd9RifRngxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=npMtz02e; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YgDVJipH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4891tWFl006313;
	Mon, 9 Sep 2024 10:16:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=+8KF7jG1g6u/o8c
	7aSADsIRJjQ2+reYRKDKaznRqWCI=; b=npMtz02ej7JQf+51aCFSZF7Watl6MWg
	QpFN8RQFNj4PRym692BA11vYqdbpSw76TbJHsZOJkixz/XYXfd31NoowgroOfQft
	Yr/eEyCAHseeKxpbryxTQEj7fs3Dl7xjLekGdp4VL2fK6ePGPTeLZycJbk5w/vXK
	L7RQApqoPQ9EQSLYzMrgB+ZC4qHEqwUgVzcebByv9IraIqp4UxDRw6yhDo+TZ466
	9jC1qtqAzVtEvneBgDdwufTMsFLr8+OU0bj90SyAeNqU7qh+m470OcWu9V1NFCfm
	GLq5FJV82Oc8hmjTvcp7hHtLs7dKZJUfN543vN6W2gcINXyNBYIZ4Cg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gde02hrx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Sep 2024 10:16:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4899bwkF033545;
	Mon, 9 Sep 2024 10:16:56 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9719jq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Sep 2024 10:16:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WDoyi7Oq3q4EGdRyRf7JddI4eNz0FXmsY/0dY1cNuhXOl17MqT4zTGEXPMewJFaQxtgJqUOkm7QywK4phzk1lK/+CdubY/H9XAhCWVwfPkGbCEUkTlaonnyMkR7Deb/7lMgFhqEW16m0WbYn5KKzIbImpM7hYoJCfyjisWa0zmWvcJGye0NT5/n0T38d5T7k6A5bpJbImiSx/Wyx4oCrbr783qglMJlxABXE8O+nGTDP+uZLxJ8rxI/AX1EeESDX+CLCVXlIETYKfR//MDxrK8kwoqAcBK/6akgzK6Fe/kvCtFwV5Uwy1uIvzvBFYQyBvvD9jXNXxsjYymmLqnvP0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8KF7jG1g6u/o8c7aSADsIRJjQ2+reYRKDKaznRqWCI=;
 b=mK+PPtsfchXwnv1TVDttYBkt4Bw/Tw/vIuR67d92qZ7R446ENIu3rx5jRGk+ARvgmQ1mxaxkfPdVVIsoRkoRNT7UYZzb8HIv35ceUnboJlHfJaqNAw/WzMV+f5/q0lMOINhKqq0YSLAPo/7yqIOrrqBm0v3IIyW6czBxWnNPtyUTvImuu0ozdcQO9ANbGUc7OWWp4k09kpO9CA8JEUsb7NqyLvc2MLsGfhrlLNbObOhtah2AVoNzrjKb9EbDYGxxAWa5S4lMUrb0rsS+HY0/bxkSkILgs3SXrieV72XeJqUEvlTQOBc4Wt379k6Yxz5xhfTkVtZHn/oew+UehFdWCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8KF7jG1g6u/o8c7aSADsIRJjQ2+reYRKDKaznRqWCI=;
 b=YgDVJipHsg6eQoSg1WLWC4byoEIuA0a5Ukn98feiFCu2uZNXItkZnqCwunuGXcqEtR8opD/0fYWjF1VLFVxDB9ddEFqADCnQ7qJcjYgQlaQ7U0bYEMUyG8ZHTsMXv5WY0wE3xLOl4UdGuuuC3bMltgpN2KlrF5sRkG6X9jEY3Oc=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CYYPR10MB7627.namprd10.prod.outlook.com (2603:10b6:930:be::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.18; Mon, 9 Sep
 2024 10:16:54 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.7939.016; Mon, 9 Sep 2024
 10:16:54 +0000
Date: Mon, 9 Sep 2024 11:16:49 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v1 1/1] maple_tree: Drop unused functions to fix the build
Message-ID: <77c9f504-956f-4b49-b626-8c75184e0e72@lucifer.local>
References: <20240906150533.568994-1-andriy.shevchenko@linux.intel.com>
 <krsjmi43ziyojqicc4pxzwfwbffqrnk5npbuoq6l2cnq5eovkd@afofyteb5wo3>
 <ZtsjJoGKRxszp-m6@smile.fi.intel.com>
 <3murs2k4mouy5gkzyav4ttrqanhsc7v4hpghmuutkokvah2o2v@pkddt5ziu33o>
 <Zt7Cssu9SQury1bU@smile.fi.intel.com>
 <Zt7GJpK4ZzFZeW4S@smile.fi.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zt7GJpK4ZzFZeW4S@smile.fi.intel.com>
X-ClientProxiedBy: LO4P123CA0684.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::17) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CYYPR10MB7627:EE_
X-MS-Office365-Filtering-Correlation-Id: be24ffe9-51fb-423a-3354-08dcd0b8872a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mkvhajzrVf3o5W752kiAFlzGgeC3TUZYrRA0V0tz/MDWEZM/Yp0l9a3950WX?=
 =?us-ascii?Q?Y5r42bsaPHvVPlwsYbUuQNZyqe7BM6H0vW6fOTDKuddddb0jQhrEpBUVvmxl?=
 =?us-ascii?Q?XIEJJNDDUMIhzcf6kkrrBCg2X02yiD6VJIxmcbVsypF4/cH9KtnQ1JKF9G7Q?=
 =?us-ascii?Q?TqeX6auq9k5aOY0BCPZloTBhADyg/fg91G9zJIJQruM6NMKPAzve4wWloLir?=
 =?us-ascii?Q?z+lLL3+px4im10lmnE8McUFj0nj7sVpJ6bKDmlu19KXKJ/YeeHWH8odawmI7?=
 =?us-ascii?Q?pIOvhIwVDHPd1bnXd5G8D5JXNnPzdOd8XbpDFX+3xw/K8keY+qGuN71fPyq0?=
 =?us-ascii?Q?T7KQuPpM9X9uLavCeJpOzVfjRI8jC1F0f2a5sr3Jm6ZH8gAZjFi+Ubq07rV2?=
 =?us-ascii?Q?90/pQy+qt/WF0AD+/sUZQLpBw4kHKF3X1A5x4DLpsjbY/HcZ7X2PRDY0Ul1H?=
 =?us-ascii?Q?Ldk2J9vzGCGg2wlN01gESu0HYxC/9K/0HKdMf3NoUZ0JJan+FPZYUha9IzA8?=
 =?us-ascii?Q?LVrDjbZ8ePZwY9uUUu7fuS/ktBJm41LSf1nL6UEOw8TzBwUNvPzWRijvcEcI?=
 =?us-ascii?Q?DpG0XkwmkKWZIt/TuyI+in/XfvLYIqlAl14Rpq+xG+YZ9UQokiZV8dJwW0Vu?=
 =?us-ascii?Q?nt9b7twfknB0FcLpxo0GmCoRxFAYYUEWnLr3TATnxKt7T2WPjrHKhsIJ9Xg3?=
 =?us-ascii?Q?sQK4XxOG0xLChMWy9kxxqGFZ9qo5mqPX6Wi6FF/9B3Pl/Y0VtID4eyiMxLUQ?=
 =?us-ascii?Q?QaNA1sUXy7HtpOfl9SdxCvaNh6Z6mygiFN7tyNIuzJgJCuS8B7djhznL8Itc?=
 =?us-ascii?Q?l1kvbYzvFyCHVS11sfTQMysmYzxMV8nCCXGnJGCf5K1b7z0oqV60/lJms8HL?=
 =?us-ascii?Q?uw82QVR9OTzlrGI1gMENjk18quxWQAqqh8D/Xa/emPXTtyJjoiY0NbESTrem?=
 =?us-ascii?Q?gZ77uNPAeS9halAV5ZHeGJhKs9qUIB+lceZnSN0edWcT0ZmGQfCIW3LXLRhL?=
 =?us-ascii?Q?PvaZd2uqoULmivBMYKzGF6rc89D2DqbUfcylWrYrdwXY869h4t/Mz8+y+m4a?=
 =?us-ascii?Q?82eBf6jiN38kEMJ6dy0gZ4u1hjKSphgoj3dwM5DjBThXYrD+2iJ5k0s73bTE?=
 =?us-ascii?Q?gAQkyETJeGOn37NGg4iG5scp487IMnr2m1Y6gjJijqN5JerahmjavzDmk2YV?=
 =?us-ascii?Q?C0btLdEqL93IbAhxwG2kWmXu7aEkWUCHYMPQI2VSe4L0adxEUWjwKLEfnCuF?=
 =?us-ascii?Q?c2cI34KpjTtGy4Z7o/aQE+I27w+XwQIslCrYlbBUYR2z4h0qEgqI+m33eKEm?=
 =?us-ascii?Q?sYc3NVD3NrNwiKpj8Xb/uiwFy5yQqAkkzjTkVjy89pFPeFvZXV4M1q7267yr?=
 =?us-ascii?Q?i3/jdhE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CISto2/soFvdS2Ych7jo1oNRti9BLio9iVnU+ycdkECtMeI8q6wJ4HZjGlFK?=
 =?us-ascii?Q?pa8jzdNzwj43HLZRMcaNMTmi2zSvmJfJAh/4H7B3WgPCXjd+S9Uc1a0e46Lv?=
 =?us-ascii?Q?nZ4HSzdkvFyelOYrVn54Bnfszj+AkHsKSPPefkL/eXZ3rBoDLED5Sv8yUryG?=
 =?us-ascii?Q?XxrKcLsGs/S2PgvkqXc6JrrdBNwDC4F6FNIfDOYoXIa7NxD43vNZPtqad3uV?=
 =?us-ascii?Q?lGxr+dNb0e8ty0G/mdVlWFZQqlts7ez7i7bUThCcC4duFkg672fHOgBlsmqs?=
 =?us-ascii?Q?Fv9YMuyNjiDQ3QHEhQTB6OnfqXqceJQ+blebT+HExc7CZby9L8JuIMIKN4y9?=
 =?us-ascii?Q?0y7/t+rq1E+YTi1ZCfj1YdyGsrzDzztEABptxtm1SByuQ4izOeYcwfE4cRcX?=
 =?us-ascii?Q?sWmy1cnUIcQe6tZBP0acMbb4+gHDeLec1S+BVgV9Z+hIMMI+mqUW5xSNuiFC?=
 =?us-ascii?Q?EinhLS2FSsWPY7Aak/49ZefkRgAy7oIImlKPPFzUNFIlQaB2Ni/mXQIipX4h?=
 =?us-ascii?Q?IBKyWGKZvOG5cJjQnD85XyRQzWd/r6+PsC3/5uKsYIl2FFY1Som/Qwi7KKpM?=
 =?us-ascii?Q?EFrhkZoSMaAlvI0kZBxMxCyTXruelV9dUS5Z0xA2NWGoS2hD/I3XGSZZJPV6?=
 =?us-ascii?Q?Z8pQvXDwj26664+qMVG1OEN14h7HQAVw0XgdqyPJhnh+ZPmI3zK7bev6ZMla?=
 =?us-ascii?Q?ZgfbhHi8e/T7Rm72QtM8Xb/pjQ4qUKbYtO005oe9k3Y5VzLz3kkcFW7MgUQ+?=
 =?us-ascii?Q?O9uiZi7qejOOTxODGbYcx2lbDJZnHfaWZ//MpUYbJeHivD35Ecz9rc2azFPx?=
 =?us-ascii?Q?TV00hiPrhHKFMJDWnbBh82u1pd49Rc6scCsdchPcP5m6VyLjjPtdnOJbmeKl?=
 =?us-ascii?Q?VMUTLDcIlTecUxELvd7yxPALAim8NNCAOFraYq6T1BG3/Indrgzk01HsDGdo?=
 =?us-ascii?Q?L0dEVN9VNDrmP9Q7b1jFPk127MzjVqWNPPHkz72U70gY5DGR2FaQQ8ypbDs0?=
 =?us-ascii?Q?8oXZmDjGculgHsw1+0DGqJWuwCrh4cpjTmiCaSJ9mivyCxYni912ZdH+WVQN?=
 =?us-ascii?Q?5L/+pWo6wCF3tQKn2FZ4SQyC/0P6iWBOQu7bxnyisB+8xRO3HY959ag/te7b?=
 =?us-ascii?Q?0fjPIEZwD4WCS4VSKSPs4cSynuZX2B++7Hc2vlNemWBeVJMzUQf0IO7ynBdk?=
 =?us-ascii?Q?J83HCnoiB9zJiIUP9W0+S3sXp5kvlnpVrzBFjjmKthiPlgHabS7+63/+IpQx?=
 =?us-ascii?Q?CA+Qj4jKo4qfEgdL29UkMKnGhGEj2LfVNQwl5n9QBKQlmqYWubySlL8D6oQt?=
 =?us-ascii?Q?lbCmOc2LtuMmA0FCG1tGEntidCb9K6d9RCiikFYvfOHETEOd+XTI5/qrqCSy?=
 =?us-ascii?Q?TKAMskY1WA7kLxMZdUcdu6K2iKEaoRxTxlgOcI5wMMH4I3HkeaH8nrToVw3O?=
 =?us-ascii?Q?UBbEOzKic7+B5FRv6byY9TUShaCfjnWDAzDFnOzXm9O+kktE1L+O+ndFFTkL?=
 =?us-ascii?Q?iNPJ7xHfJqHHDN+1GHl2YyNi+jeomEQKC82xWv7bUd9+Wz1drKzjGciaufC/?=
 =?us-ascii?Q?/EA21kXypMxcVU58UapJm1j7i1BmbG9gXyhsTG2SKIQuc3ZbT9M0DK7Ttboo?=
 =?us-ascii?Q?ag=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uMk8zhVjYkcQ67d5tlTrJ4ZCXI2y6y9WQcxkPfIq5rdYLzMGbp85xcq1HQw1TIJlz/It5FdEq/szZq61dDtzwdaqIQlOxwIx+luMEPH84PBq1NuGcT+UC6mx7Sme3gJcAYHRxjOWN4OzdVjbpE11oesbRlaNqAis6XNtU1hp+l6+F55bFFc9CZPtaghpCKVmg1FqJMF8thasrFMydx9TI/IhezO/xi9ZEeQ7RV7ZLzEgERYiTivqPInuDC0V8fCAFmfJJQjbV74ZG8Bi66Oz68pFUpyMVeyY31NcVa+DEzSAF7F50cssdoZl4lvZbq1tl98pcZUs77lAy/3NVIXs9oAN3x0sfJS7UHV+6l2KyqCx6/rz37Wo89kEL+kV0pu0qSFgRP1nJF9UG2RYKzCFN12tOk9Hwz5bRCrge9CL3OHIzIEWDfrkzNH6ODhZlWO+x/82p7wcDrJNTs/baQvUEXslqMC44pFuzMFqJdhf6bWbeZGicLpt5e8E4JCw28U0NaQfXm7sG8+tigL5JHgk66XZVj4lU3o7e9DM6Kz+1gnnXlvmxBKprc7yogB9Dbazygu8bJeuG+89LngHu+4vSLIkn5332lxjgdJeFTZQYCs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be24ffe9-51fb-423a-3354-08dcd0b8872a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 10:16:54.0953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bSQ8jhG5lL6oC7n7m+/OJZQtYu+FP01AQZF826eiwkEkzwUlYxCrgu6Da54dCurTm9nbAETP5ZqtRJpaNU4k+SWhctA4uNvihubToBXzU+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7627
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-09_03,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409090081
X-Proofpoint-ORIG-GUID: J3xx--H80oe3ZlmS5-wL2ffDDHiLIOBe
X-Proofpoint-GUID: J3xx--H80oe3ZlmS5-wL2ffDDHiLIOBe

On Mon, Sep 09, 2024 at 12:55:50PM GMT, Andy Shevchenko wrote:
> On Mon, Sep 09, 2024 at 12:41:06PM +0300, Andy Shevchenko wrote:
> > On Fri, Sep 06, 2024 at 04:05:47PM -0400, Liam R. Howlett wrote:
> > > * Andy Shevchenko <andriy.shevchenko@linux.intel.com> [240906 11:43]:
> > > > On Fri, Sep 06, 2024 at 11:26:26AM -0400, Liam R. Howlett wrote:
> > > > > This exists to stop people from using the bits while the feature is in
> > > > > active development.  We had the same patch a few days (weeks?) ago.
> > > >
> > > > This breaks build. Can you propose better solution, please?
> > >
> > > Can you please provide the config file and clang version that fails on
> > > this error?
> >
> > I believe any of them where this module is marked to compile
> > (and since it's listed as lib-y, means _any_ configuration will fail).
> > For your convenience it's x86_64_defconfig in the source tree.
> >
> > Have you had a chance to read the referred commit?
>
> Btw, if you really, really need those stubs the workarond can be moving them to
> a header file (IIUC what's this all about).
>

This issue is resolved by
https://lore.kernel.org/all/20240907021506.4018676-1-Liam.Howlett@oracle.com/

> --
> With Best Regards,
> Andy Shevchenko
>
>

