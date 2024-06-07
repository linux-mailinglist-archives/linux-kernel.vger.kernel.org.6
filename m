Return-Path: <linux-kernel+bounces-206619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A88900C15
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 20:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F76E2856D1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 18:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2061459F4;
	Fri,  7 Jun 2024 18:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b0suqnGl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YJd83HVo"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6626D14EC51
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 18:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717786430; cv=fail; b=rZGfqdnPkBVGsqTzrrvqgY9WDropS0+F38cIpBfVNqEe0rVo/yuYxby1fS68WKNLc65ZqHEbZ2RY9QqEyl46JCi2Lk7M51RQEFwfm7CIAfp3dEmDRtnD1nYIKUT0BatWyvQpyAw0Db0CUFec+1BS2hwjxe2Jkl5eRNPHzFU5QCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717786430; c=relaxed/simple;
	bh=dh+BZ+NdEG+lHxUKjZNZMxLDJghdgJCSwI+g6CDvBpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JngH1oEjlQLaLHP+QAYl1Xiat57Wx6w6O4Vmlv2mzxhGqrvntfsOM3LkLMEcRRYKeT1vPlgR69Y/D8dTAQOVPrWU6RZJcgcCFneFF/88q0j/tAxAJuWarQWvln3DErSbSgHpcRL9CSzcnNjEP5cT5HnByampi1kr3HxpqEVYXPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b0suqnGl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YJd83HVo; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 457CuohI016403;
	Fri, 7 Jun 2024 18:53:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=Ptz/vKOmx/6gJSxm1UZRQYH6YHM5m8G21lDx876xCFc=;
 b=b0suqnGlyglM10cbwi5Uc7e1QIGMP1WBcgZK1c7ol2WWRdxMzzlAW2P93f/vJ2XInGr9
 CJJvJ+uUaB5ih7U25s5phGRIV2PX03siORFBYNYnWVvmMIBTUsb9Io414zYi4F4Dry/T
 ofmkfmmSfwHYNBWGW3iriirotMr/1ejw+FEtTGx6JjGJUv+Nh/UGyz+kNzqyZGswWlrS
 zk/WLiBvMH4yOeXBS3P/q/sZnyRN7DwS0hxjbzkYUy37/+2/AMH5WyRpvjTHqo2aYM49
 14mcEpytQdBDwvlqKaWcMeU/8qYbu9DsYubOVr8gdEx/bQ0kEe96ZF6uy/rs1kh/zi/Q vQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbqn69h2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 18:53:38 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 457ICR40023938;
	Fri, 7 Jun 2024 18:53:36 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrr2k7tv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 18:53:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nq1Bz+v1S3u8rH1twhIJWyKLJhu9RkXkUBzR9Z1NaXqX0YIS3uUDVH2eWikkxkZPZC0IAvRSc0dmgmp2A8ekRReCSRA5G8n0RiwNCV3efHb6JqoFjXLEVfn0UPAnHYklV2F0kqFjeJtanbFIbDk7iUEXbzm3Z0k1ThfqURxjP3QrzEiX/V5TrCPPLzm0bMUN6tRr90XWY0WqSv0OB9z47ZwWi3ssV5BH3KylsiKFtz2tnl/h+6G+Gpk3iWPbhwH/Qp7r3UlFrFEeMxHG25MDLc4fPaQHvNWfJbq22+cvO2U5UnPumJDR2InuCDg56QVhUSt5QYqykqdp6zP5UK7Xog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ptz/vKOmx/6gJSxm1UZRQYH6YHM5m8G21lDx876xCFc=;
 b=ixs08E8vMk9kWk2lNUeP61VfUQ6WFKV3ItsCQI8W9k9jyKB2/Ih4ErLWn67fF4xlB8uY/oHXqo19L97ajTRKAOr1SI6wAvG7ZjPg2qXlhVrSKj7qSTBjXb1ZsHoCrtkIPqG5dNPLbc+L6RtN0XclwEYiKGuXvt2eYl0rpDJUX+u63i1m2cwRFPG1h+OAy0qII6B2NsBZQLid25r0VZIcnMBX0HCb1gM+b+Qp8S9lVzDCeZGd2ZS8JhifiOhuKuRHZ8pKfEKj1ZIV080qE5jGYsscUIKT+AdxDuPP7EFt2gWPBEOo7ROaBZw15EkRls5qHZqu9Bp2RYfjH450JrvO3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ptz/vKOmx/6gJSxm1UZRQYH6YHM5m8G21lDx876xCFc=;
 b=YJd83HVoCDFIKYJFdm47ldRcLVD3c46lpYMKwt5zY6BGaDcU9zND/ci1SGwFHB1/QHR/LmfsVmkRPW/IdD5zKbPLaRH8Xa1Qthu4ej/y169B/PIAFePtt94vePifmvubqwLWIca25ugB8q2q8ag2lC2LVx9MLu8uB7EKwcXWM1o=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SJ0PR10MB5629.namprd10.prod.outlook.com (2603:10b6:a03:3e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.26; Fri, 7 Jun
 2024 18:53:12 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%7]) with mapi id 15.20.7633.034; Fri, 7 Jun 2024
 18:53:12 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 04/16] maple_tree: introduce mas_wr_store_type()
Date: Fri,  7 Jun 2024 11:52:45 -0700
Message-ID: <20240607185257.963768-5-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240607185257.963768-1-sidhartha.kumar@oracle.com>
References: <20240607185257.963768-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR18CA0004.namprd18.prod.outlook.com
 (2603:10b6:208:23c::9) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SJ0PR10MB5629:EE_
X-MS-Office365-Filtering-Correlation-Id: 031b9898-8ec2-4137-3449-08dc872314cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?c5byJYA1XM1xzWjyxgGiY2Oyl99JkOtbyNgB3i8WGy31Rse7HcXefJbHerbO?=
 =?us-ascii?Q?3JfHvD6G57gC/OZEAwXcQ9ioUyB7zX9o43qRlaw/0lTQM73BvkKyMNM7blLl?=
 =?us-ascii?Q?BVX0YxTeQD3KzW/zWevEJ+chbCTfnQAWp+FJd37fVdcKFr+jlISZqjH9XVgZ?=
 =?us-ascii?Q?H8QXLX10z4hqyMQFU8E+EAYIuQdBd66VSXZmQovZCfWFitD+2pC7GIYhgTin?=
 =?us-ascii?Q?nbv+q+drIGw3pUtp1++a0EgVf2pTWtG6bLz/ZtpyarCBrgyehzFpRn9DesoJ?=
 =?us-ascii?Q?xOJV9HEOP7oSJelLbMwji9UpwJ1ik5iDmLb/g53UAn/wcGkiRUlG5xX2ux9z?=
 =?us-ascii?Q?Qh0zpXvJI1LJOH64n+2BoebJkBYpZNYwAeXRlU971yLkp7nl/WGItVF6GBiv?=
 =?us-ascii?Q?LFvabtg9q7c6k8WCzm9AE+TDUvBaC7eUytPfemHD0+c/oqI3RuGby07hh7by?=
 =?us-ascii?Q?xcgkR1RmZnGFJNmEnqRq4cT7bIveAtTUeSm2N23jsrp7IiglL6uH9iN2JK2C?=
 =?us-ascii?Q?ZiOtn/zQhjyAkF7N+vw2+uIwrMq0niYV4Dbf3cfEPLv8d0/hE0tNiHmqE0aC?=
 =?us-ascii?Q?0fSmsp9X4N6zL1MsG3iizU0mYNNQA01rXPBcB1S4BlJwsSuw1CoMdX4fomcL?=
 =?us-ascii?Q?eNDhLTpyLQacKXuuytc8xL6dPa7AFBBd1ZXBAaSqIIqZjVXQsI/TFJzCOg0C?=
 =?us-ascii?Q?PW6Alf2fSiSDrsQpo2YkkgeLmjC6IljdF39ThhC/aZW1rFPm3iYRK7BRDUBf?=
 =?us-ascii?Q?PEFrZEZ5rqLh9G0XKNRXYBDBpthfuSImHfRjdrR12KhZQHyGXWZN1654MqeS?=
 =?us-ascii?Q?hF1gd2T/lpSeRJDDRGZLPQHHmvp9wINx5odKBPbX1qDV4OmsP6m+oeuDxyLg?=
 =?us-ascii?Q?URoi+CMGH9NLu9I/dQvur38grb3sO43S84wSspPrOFJC3PCOlYAgPJsh6+IK?=
 =?us-ascii?Q?zprDoV5ljCEgI6C1pkBFqXOAXwns5Ups2qXYoojZ5V1mJAPCoK+kqFJt4pC3?=
 =?us-ascii?Q?do/DHZVLxMQmdZBlDCMGXzf+YbS6qVlfbR1cYTnQXRmbuYjWshGFrnSEmTAr?=
 =?us-ascii?Q?n43FGGEfshSCPFTNYK6qxAvc6t2vpWgZql1jxb86gz7J66Yk5Z2S2TP44H9g?=
 =?us-ascii?Q?h49yhTBBTOqWtRzBHsmFSDxu3KhB/rwk4xOBGqC2a0om/uWPmqo7Dr+27Mpg?=
 =?us-ascii?Q?zvfhgkKLHUqpc5OplC/g3bKlHEuMgthKf+wCbPM/J6OpY8mmF3HAHtKmT42c?=
 =?us-ascii?Q?WXV0+XP3AbrC9pYDwU1lia+MjdUdf76Rny4SaO0+brcgnuvV6hLAuhu3W9+Z?=
 =?us-ascii?Q?yxvlk8j45Q1mVdCHw+iWcGX1?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?uLNAqlPF/tmK4tV8r9uSVtoaezrXoXF48+upPSGzZvPYNUAlGP6rTXCCf0w+?=
 =?us-ascii?Q?hPAi1cmh9M8xJeSXUDOeOXafFeukNQm1KA3TMOTVnUJBmLQU2xAxO59uAlcA?=
 =?us-ascii?Q?mYEoiHCTAjTGjic04yfmOhv6fJslzYv03rCjQQKK3Y1VAoW7sJVftcfUz0rG?=
 =?us-ascii?Q?KnUzM4bOGUWnD5IRGpNX8KheYM8/2GMKzaZitqP4RpB7Uj9jcdMjUSQO2LPY?=
 =?us-ascii?Q?JUb3M4UoXnkoGvrZOKmpoP4jR1toqG6Ter6Bw+ZIlRtDgGvruWkgONc28F23?=
 =?us-ascii?Q?oVfkJUrBkV6qWM+fSRBMtlggS5C82i4shO6z79goMg7h2M8h7gnE6aMMFP6D?=
 =?us-ascii?Q?RAmjv5aZA+jw0RkTSGVpRi2NCmqK0JN9rmouw7D9ihjF6ow4acQjDcZku6WR?=
 =?us-ascii?Q?f3ELT4DCmBTMriYSPOQlJwEExhBdffSxcJsjefFTWNc0HpDWYh7e3Cyb8XfW?=
 =?us-ascii?Q?e7C2xCtS/iooEu4bNBFY9qLqTvxd2ebHygGS47jg6WisY3kYxQOhaq57aUGX?=
 =?us-ascii?Q?zGTXYysJUzreXRii8hNWv1+iDFIIkiXXpPRp9qvzPjjIudaCiXKhLIInxje8?=
 =?us-ascii?Q?GlXzFiHBbMeTXvs9dciyM8g+qWbKcmJtRYlEEzCU2gR9JSdOsQ4nuYYD7G3L?=
 =?us-ascii?Q?LwmA9t8Ezb2x2+lzrg+HhEPnHU8Pb9F55cwfl51YQO/EiPG+BLhBWzaQTteI?=
 =?us-ascii?Q?FeAbHkC7ot34N5fL8HBXw6E4wZdzyK8gXOrmhMjxsS1qSbFlQCIXSPxvbEr9?=
 =?us-ascii?Q?OLwN8Q8pFDa5aXnFwoJ0lmHUeJKS/ACNpdrCvg7zGy6RVh7F5CgLLM5iYrWy?=
 =?us-ascii?Q?7HHdFlizOXofgOOqWfHRRjilQv2pUuVgz2fkdZkocHu64XfJCfCvaMKjLWQI?=
 =?us-ascii?Q?pChR2zBKFL0teXA4SH6dSpFesXHME/g/O3UQl3HL18CD/6PshKaQhSBPowhc?=
 =?us-ascii?Q?+w1mlAZ19IGIwNSMsy+iJklWn/WQEw3tHqgkoW3zh566kGVMdxU8iP8rPavF?=
 =?us-ascii?Q?1lLwVRu+guqupBUMmuC75psCpM3S6/Wn0oUK57apzfWGmNot/Y7sFU1sIJHc?=
 =?us-ascii?Q?GsF03J4O2FO6lE5U13S97jas5kt60FF7etyFnXWYLrzpuo+TAleWrRiBW3DB?=
 =?us-ascii?Q?uZDI3WMMggWtl7X8HSAi8WwJFM/QrRo2Ei920oPXKPwRV52Re6D2P0cK3ToC?=
 =?us-ascii?Q?pG4DvA3Ud8RxWeYKLhcj8RzSmoi0OXREalzYCRx/RFLfTNUo/4QKoX5wZs4+?=
 =?us-ascii?Q?P2dobM8dIxQEY6ilZK3i1zLab57Y3QQQ/eVxHYPRWI5Q6FiaIx77Rc8ODBcQ?=
 =?us-ascii?Q?5XesCxJTiKtdDiUVNDDDYYEV90ne1FEoWOctUuJK7+iWYNN7F48rTSfLR8Lx?=
 =?us-ascii?Q?o/Z26WXn2iZrYhr4MOwZFmjh5sTqiG136tzRzS8judhQZ57qeN1LbpLZXYGF?=
 =?us-ascii?Q?NcE7KBR3c457YdvjO7/K89bOJHiowm15atSengep2IvGtRykdwECxU7PuFxH?=
 =?us-ascii?Q?ZFC4z+PEbOK5suSk4wri+M60DzzsVq7EtjnejtWiEbNradce9FDwZargY/rf?=
 =?us-ascii?Q?JnKctHffApMh7bsGyfBJy18gTjCTorZY8/z/bkWnrMpoaJ6dkGADPfiKFIbE?=
 =?us-ascii?Q?S3DQTlWiuYd8ZoLZc2AaD0I=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	TfeUcfNkb2vfp64fm/m5q0hhHk0b9t7O0cXu10GTzXwKoIsrV01q8N9JygVCJmlCRJ5ZIdd6NNFfAm6jV1wQo233uETnJbYGrd7M8iN/KNUr9mwdchzGUQCwkWvGn+U4to3bFr5DKZ+cXu39cCYQTW5r09hZtrScou8g+OemmXWM0T/rZFr3ITY348oB/qP7uq6UtZ4ZdL9qNsg0F8kR6vhkDjIOvK/7Q5yUGgn977lcEDq3pvet853nu/ds1Vl62jQd7a/8IXoghITjMYW6ovNXzmxGQ9DOuRuACDer6RPu2lUL+4JyixRteE3Nt2hQThgnxDN9F8TOYjNKPBmYeQZFREdEWkVxNo5aU9ebTR05+MZFeFGfieMUj0Q5S9hGEc8DYF0gruvr1SDDykZHh8rcGONidYmbOQ6TiGqyj2SDmBQqo6q5ewyXgBOm7KuBEiZbr8vUMpGUS3xLJhVZl8bxBBObgDzv+W3r7DcYcZXOpq4nRXRAIEz8ZZLvW8Lc839ihhstpsVBP04gPYtpaWCmBvL26A9lunUOF28MADs05VxraZEE5kD0pCc5J1C83M0ehv9YI7aWgE2jjM0DofuwwPpy9wyQZQpLjvWx8sM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 031b9898-8ec2-4137-3449-08dc872314cd
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 18:53:12.4555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zGesItE/yalRH2rqcpawcTIUCFyxV13ZLgLhbj3HrFLkDCAZdwnivXpeKnrTVbwPlzMwKBd21RjHmzpMGilX99xEWY/EmDTQf7OATICfxug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5629
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_11,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406070138
X-Proofpoint-ORIG-GUID: MemFKTPc35gFEsrqAwtlGwUukAx_j2TH
X-Proofpoint-GUID: MemFKTPc35gFEsrqAwtlGwUukAx_j2TH

Introduce mas_wr_store_type() which will set the correct store type
based on a walk of the tree.

mas_prealloc_calc() is also introduced to abstract the calculation used
to determine the number of nodes needed for a store operation.

In this change a call to mas_reset() is removed in the error case of
mas_prealloc(). This is only needed in the MA_STATE_REBALANCE case of
mas_destroy(). We can move the call to mas_reset() directly to
mas_destroy().

Also, add a test case to validate the order that we check the store type
in is correct. This test models a vma expanding and then shrinking which
is part of the boot process.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c                 | 214 ++++++++++++++++++++++---------
 tools/testing/radix-tree/maple.c |  38 ++++++
 2 files changed, 192 insertions(+), 60 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 2558d15bb748..a7f585ed488c 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4278,6 +4278,151 @@ static inline void mas_wr_prealloc_setup(struct ma_wr_state *wr_mas)
 	wr_mas->content = mas_start(mas);
 }
 
+/**
+ * mas_prealloc_calc() - Calculate number of nodes needed for a
+ * given store oepration
+ * @mas: The maple state
+ * @entry: The entry to store into the tree
+ *
+ * Return: Number of nodes required for preallocation.
+ */
+static inline int mas_prealloc_calc(struct ma_state *mas, void *entry)
+{
+	int ret = mas_mt_height(mas) * 3 + 1;
+
+	switch (mas->store_type) {
+	case wr_invalid:
+		WARN_ON_ONCE(1);
+		break;
+	case wr_new_root:
+		ret = 1;
+		break;
+	case wr_store_root:
+		if (likely((mas->last != 0) || (mas->index != 0)))
+			ret = 1;
+		else if (((unsigned long) (entry) & 3) == 2)
+			ret = 1;
+		else
+			ret = 0;
+		break;
+	case wr_spanning_store:
+		ret =  mas_mt_height(mas) * 3 + 1;
+		break;
+	case wr_split_store:
+		ret =  mas_mt_height(mas) * 2 + 1;
+		break;
+	case wr_rebalance:
+		ret =  mas_mt_height(mas) * 2 - 1;
+		break;
+	case wr_node_store:
+	case wr_bnode:
+		ret = mt_in_rcu(mas->tree) ? 1 : 0;
+		break;
+	case wr_append:
+	case wr_exact_fit:
+	case wr_slot_store:
+		ret = 0;
+	}
+
+	return ret;
+}
+
+/*
+ * mas_wr_store_type() - Set the store type for a given
+ * store operation.
+ * @wr_mas: The maple write state
+ */
+static inline void mas_wr_store_type(struct ma_wr_state *wr_mas)
+{
+	struct ma_state *mas = wr_mas->mas;
+	unsigned char new_end;
+
+	if (unlikely(mas_is_none(mas) || mas_is_ptr(mas))) {
+		mas->store_type = wr_store_root;
+		return;
+	}
+
+	if (unlikely(!mas_wr_walk(wr_mas))) {
+		mas->store_type = wr_spanning_store;
+		return;
+	}
+
+	/* At this point, we are at the leaf node that needs to be altered. */
+	mas_wr_end_piv(wr_mas);
+	if (!wr_mas->entry)
+		mas_wr_extend_null(wr_mas);
+
+	new_end = mas_wr_new_end(wr_mas);
+	if ((wr_mas->r_min == mas->index) && (wr_mas->r_max == mas->last)) {
+		mas->store_type = wr_exact_fit;
+		return;
+	}
+
+	if (unlikely(!mas->index && mas->last == ULONG_MAX)) {
+		mas->store_type = wr_new_root;
+		return;
+	}
+
+	/* Potential spanning rebalance collapsing a node */
+	if (new_end < mt_min_slots[wr_mas->type]) {
+		if (!mte_is_root(mas->node)) {
+			mas->store_type = wr_rebalance;
+			return;
+		}
+		mas->store_type = wr_node_store;
+		return;
+	}
+
+	if (new_end >= mt_slots[wr_mas->type]) {
+		mas->store_type = wr_split_store;
+		return;
+	}
+
+	if (!mt_in_rcu(mas->tree) && (mas->offset == mas->end)) {
+		mas->store_type = wr_append;
+		return;
+	}
+
+	if ((new_end == mas->end) && (!mt_in_rcu(mas->tree) ||
+		(wr_mas->offset_end - mas->offset == 1))) {
+		mas->store_type = wr_slot_store;
+		return;
+	}
+
+	if (mte_is_root(mas->node) || !(new_end <= mt_min_slots[wr_mas->type]) ||
+		(mas->mas_flags & MA_STATE_BULK)) {
+		mas->store_type = wr_node_store;
+		return;
+	}
+
+	mas->store_type = wr_bnode;
+}
+
+/**
+ * mas_wr_preallocate() - Preallocate enough nodes for a store operation
+ * @wr_mas: The maple write state
+ * @entry: The entry that will be stored
+ * @gfp: The GFP_FLAGS to use for allocations.
+ *
+ */
+static inline void mas_wr_preallocate(struct ma_wr_state *wr_mas, void *entry, gfp_t gfp)
+{
+	struct ma_state *mas = wr_mas->mas;
+	int request;
+
+	mas_wr_prealloc_setup(wr_mas);
+	mas_wr_store_type(wr_mas);
+	request = mas_prealloc_calc(mas, entry);
+	if (!request)
+		return;
+
+	mas_node_count_gfp(mas, request, gfp);
+	if (likely(!mas_is_err(mas)))
+		return;
+
+	mas_set_alloc_req(mas, 0);
+}
+
 /**
  * mas_insert() - Internal call to insert a value
  * @mas: The maple state
@@ -5506,69 +5651,17 @@ EXPORT_SYMBOL_GPL(mas_store_prealloc);
 int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
 {
 	MA_WR_STATE(wr_mas, mas, entry);
-	unsigned char node_size;
-	int request = 1;
-	int ret;
-
-
-	if (unlikely(!mas->index && mas->last == ULONG_MAX))
-		goto ask_now;
-
-	mas_wr_prealloc_setup(&wr_mas);
-	/* Root expand */
-	if (unlikely(mas_is_none(mas) || mas_is_ptr(mas)))
-		goto ask_now;
-
-	if (unlikely(!mas_wr_walk(&wr_mas))) {
-		/* Spanning store, use worst case for now */
-		request = 1 + mas_mt_height(mas) * 3;
-		goto ask_now;
-	}
-
-	/* At this point, we are at the leaf node that needs to be altered. */
-	/* Exact fit, no nodes needed. */
-	if (wr_mas.r_min == mas->index && wr_mas.r_max == mas->last)
-		return 0;
-
-	mas_wr_end_piv(&wr_mas);
-	node_size = mas_wr_new_end(&wr_mas);
-
-	/* Slot store, does not require additional nodes */
-	if (node_size == mas->end) {
-		/* reuse node */
-		if (!mt_in_rcu(mas->tree))
-			return 0;
-		/* shifting boundary */
-		if (wr_mas.offset_end - mas->offset == 1)
-			return 0;
-	}
+	int ret = 0;
 
-	if (node_size >= mt_slots[wr_mas.type]) {
-		/* Split, worst case for now. */
-		request = 1 + mas_mt_height(mas) * 2;
-		goto ask_now;
+	mas_wr_preallocate(&wr_mas, entry, gfp);
+	if (mas_is_err(mas)) {
+		ret = xa_err(mas->node);
+		mas_destroy(mas);
+		mas_reset(mas);
+		return ret;
 	}
 
-	/* New root needs a single node */
-	if (unlikely(mte_is_root(mas->node)))
-		goto ask_now;
-
-	/* Potential spanning rebalance collapsing a node, use worst-case */
-	if (node_size  - 1 <= mt_min_slots[wr_mas.type])
-		request = mas_mt_height(mas) * 2 - 1;
-
-	/* node store, slot store needs one node */
-ask_now:
-	mas_node_count_gfp(mas, request, gfp);
 	mas->mas_flags |= MA_STATE_PREALLOC;
-	if (likely(!mas_is_err(mas)))
-		return 0;
-
-	mas_set_alloc_req(mas, 0);
-	ret = xa_err(mas->node);
-	mas_reset(mas);
-	mas_destroy(mas);
-	mas_reset(mas);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(mas_preallocate);
@@ -5594,7 +5687,8 @@ void mas_destroy(struct ma_state *mas)
 	 */
 	if (mas->mas_flags & MA_STATE_REBALANCE) {
 		unsigned char end;
-
+		if (mas_is_err(mas))
+			mas_reset(mas);
 		mas_start(mas);
 		mtree_range_walk(mas);
 		end = mas->end + 1;
diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index f1caf4bcf937..1c68ccc1b475 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -36223,6 +36223,40 @@ static noinline void __init check_mtree_dup(struct maple_tree *mt)
 
 extern void test_kmem_cache_bulk(void);
 
+
+ /* test to simulate expanding a vma from [0x7fffffffe000, 0x7ffffffff000)
+  * to [0x7ffde4ca1000, 0x7ffffffff000) and then shrinking the vma to
+  * [0x7ffde4ca1000, 0x7ffde4ca2000)
+  */
+static inline int check_vma_modification(struct maple_tree *mt)
+{
+	MA_STATE(mas, mt, 0, 0);
+
+	mtree_lock(mt);
+	/* vma with old start and old end */
+	__mas_set_range(&mas, 0x7fffffffe000, 0x7ffffffff000 - 1);
+	mas_preallocate(&mas, xa_mk_value(1), GFP_KERNEL);
+	mas_store_prealloc(&mas, xa_mk_value(1));
+
+	/* next write occurs partly in previous range [0, 0x7fffffffe000)*/
+	mas_prev_range(&mas, 0);
+	/* expand vma to {0x7ffde4ca1000, 0x7ffffffff000) */
+	__mas_set_range(&mas, 0x7ffde4ca1000, 0x7ffffffff000 - 1);
+	mas_preallocate(&mas, xa_mk_value(1), GFP_KERNEL);
+	mas_store_prealloc(&mas, xa_mk_value(1));
+
+	/* shrink vma to [0x7ffde4ca1000, 7ffde4ca2000) */
+	__mas_set_range(&mas, 0x7ffde4ca2000, 0x7ffffffff000 - 1);
+	mas_preallocate(&mas, NULL, GFP_KERNEL);
+	mas_store_prealloc(&mas, NULL);
+	mt_dump(mt, mt_dump_hex);
+
+	mas_destroy(&mas);
+	mtree_unlock(mt);
+	return 0;
+}
+
+
 void farmer_tests(void)
 {
 	struct maple_node *node;
@@ -36230,6 +36264,10 @@ void farmer_tests(void)
 
 	mt_dump(&tree, mt_dump_dec);
 
+	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE | MT_FLAGS_LOCK_EXTERN | MT_FLAGS_USE_RCU);
+	check_vma_modification(&tree);
+	mtree_destroy(&tree);
+
 	tree.ma_root = xa_mk_value(0);
 	mt_dump(&tree, mt_dump_dec);
 
-- 
2.45.2


