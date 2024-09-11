Return-Path: <linux-kernel+bounces-325542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73917975B06
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 21:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97D3D1C22D94
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 19:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FF01BA291;
	Wed, 11 Sep 2024 19:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y5+sExZm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IRY8iCPR"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D8E1BA26A;
	Wed, 11 Sep 2024 19:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726084143; cv=fail; b=cA0/+ScadYL8B01S5z6yQXSSpEmolHoqZt/aXd/9o45iZnHCSpzFVkcVcfIqW5Mi+Tm7zpmcvb8aeotGSZGS/z09u6sm5zbpxNb3jsqD8Y7ndHrN3yJ7+65VMkkC0mtBuwNek4G5g11t0UT86H8e6jFrtjXr5NRjBcDkm/QPj6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726084143; c=relaxed/simple;
	bh=8w5TJgSelZIA1IeFmokYudvsoxaJisjK0mtzNOh9VbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g8A9wRQtM1mt4L5aiKuRWIHbIBUGSY+na6BaRppAYz2PSowh0szRAfGH8iyV+yXc4kXB67Ad0Vz7W3HWVUJuNvlYvXw13xp7M80BdJpAvwAyTb5moafherg18HnWNDoximAOQLkNCJd2tfaoxwKOaG+Z/a4X7L4z0hmI4Lr6Nf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y5+sExZm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IRY8iCPR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48BJBxQZ016752;
	Wed, 11 Sep 2024 19:48:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=LYdEDU1/cgFSUP2
	ON0qbF5BllkuGRvvXguy+P/l7H5k=; b=Y5+sExZm8lyOrp+YcKiBkAmn5QkwEyw
	F4wo04RN5WZixB2JN3ddLh5RV0MjNuod2wMg3CaZiNk8tFA90oPRlaEhhDIL7Kct
	zTBNMTI8V4lHdHRH2Lv7X7eh/R9GML5KDdpAnMIT4Ab67yjnAWgeJ+CA4C5qotu9
	+Bg2xqB6VfJ7V3OTsYvfcV4mmq4+tGN7fZ4Uxa9xh5wJF2aNrjY/42toqUxb8Qog
	EAsKJz9pM05Pec8x+PEzyTqI4yhh+uwEQIP6320eYrFa8AJdLXnByjOMwhV8d63u
	8de79IgUHNgfnFIlH1H4yFrOwIb5do0ZApGX3MjbQK17xVGDh/d76Fg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gde095t3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Sep 2024 19:48:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48BJAVQF040959;
	Wed, 11 Sep 2024 19:48:49 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9by5ce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Sep 2024 19:48:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BVEnxDBu4eRLNnWBDA7VOxDyQKqJxTDI52WomjNePwbEhu98bdC/zUs+gutEQBQ8Axl6CjrO1y134AjYOq4U7wHc03DlZStYeZvET9vCWZY8LR90mSxmxym0kO1V47sO+dogYPe5iu8ytDzVPKp7hGOdLIrS0K1wrPEGEDPk6zduVD3Rl2UmAjoSd6NhqSbzgwnoyF1Gdd4Qs4EQGCoDxuqleHC97uKcwhDlUXKZvpVpljH+OxCx7QrNkO+sHsrHxoy3ylUmOztWFvi0+8Y2a3mW8c2YOgZZ7GGQKvATPWb8Uqi+Mk65SY1katfLs/vkWXuXTIPI2Q5oRVSXuNZ7sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LYdEDU1/cgFSUP2ON0qbF5BllkuGRvvXguy+P/l7H5k=;
 b=rR2tESIM5QJ9b60/SMJBfIKkPRCttxMD4NQ8aAT/jgrsKDpBKq/J6AyYEzX8xPWnfUZHhy74+u98QV4BIB5q5w4nVdWY1OPwYSRQjj6pkZK1ybwyeOPCKTiOHw1lx8mL9k702uhO5IcAUgjOS1VLYS1Twf7hC2m0IxTCWMJE3ASzBwmIEwlcON+FFV32BZp0ypTUBH0Twig80P6Dt6buqONgPEP7cSCGkumGqEXiRW1PD0XZvKC1RoYolXr52nbp6nvCVofKkv/jcQq9RxhcRdhUsaDlOyaWed8mmsYixxtNR1q7MNxu9Ma5WVmR5JGCJX002foFMfJ/ZZxFWSIc0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LYdEDU1/cgFSUP2ON0qbF5BllkuGRvvXguy+P/l7H5k=;
 b=IRY8iCPR6ecsKhsOIZ/cP1OPLs0olbsvtria4o+K5dWtkiZeqQ1KjZ7lSWVbcoTuiJ0vuTvt4gfkWAkIB8ISk8aAMgK7FlvYLyJJglJkmTg2PKowf9suUGXAQEfzXEEloohDVdlxFWQHL/GL8sAQn7UbjtwR6aqVzgee1JzeuGg=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by IA1PR10MB5898.namprd10.prod.outlook.com (2603:10b6:208:3d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.12; Wed, 11 Sep
 2024 19:48:46 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7918.024; Wed, 11 Sep 2024
 19:48:45 +0000
Date: Wed, 11 Sep 2024 15:48:43 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Helge Deller <deller@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org, linux-parisc@vger.kernel.org
Subject: Re: [PATCH] [RFC] mm: mmap: Allow mmap(MAP_STACK) to map growable
 stack
Message-ID: <focr7orndhsr7vhownfdhrpctwztloz54bfbg2wnd4xmqtcymu@26pn5wteugl6>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Helge Deller <deller@kernel.org>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-parisc@vger.kernel.org
References: <ZuHtb43Ar21ZptNz@p100>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuHtb43Ar21ZptNz@p100>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0390.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::15) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|IA1PR10MB5898:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e25e3d6-e037-40a8-cbf9-08dcd29abf0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gsuKBLZBiG5xQHK+AHVKvkBPf/grvVNDfxIycDrzXULVAnMFFWNYNAtVimsz?=
 =?us-ascii?Q?X5x96LNIP1V2w2+Yn85t4YQxa4IqpTRyaZWwF/DqviW3yAawHB6Oc2kH1Q9O?=
 =?us-ascii?Q?j6mbqUz0jyKVYOPtk46iP/Qs3S/3KAkFU7wiqalDw/OJnGgPBc/PtSkpeaMx?=
 =?us-ascii?Q?YS62rV36WCVXtMhzzL8w8/x1CEU2/g2dnqO9SFsCbBRLj6/yZJEPiOZdRTUz?=
 =?us-ascii?Q?6o2vlMLUPdwVPnNi4bt4B7bL3/2qfImxucNn4llFb42OsyPw1PIQegvX1vQa?=
 =?us-ascii?Q?x4cf8NUrydlepv71nd6nrkISADoTdImVnzEf5aCic2hunH0ooCZwtmhuHHDp?=
 =?us-ascii?Q?ayneyqv+Ud16i/fv3lKCzkN+/fzAWrmQ6n5xZA7s3EamSzkEqYZ7CjM3RBhe?=
 =?us-ascii?Q?90OSFeACbGEO5YbpNIoFL2EyFocz56/Z7MN0UOlHb6D6Qy3AvDRk38De4KWn?=
 =?us-ascii?Q?NUHEutEzbRpEoe56Q5FnSDy3B1/p5W3wlCTocgqbjjHyz8yuJOEKtZ+SBVry?=
 =?us-ascii?Q?iv1WY/W2RBoKHiisAzY8lH6eeWycfLjszR2kC/jT/CCiVFZZYU6+GdnvXru4?=
 =?us-ascii?Q?eeS+bFUbRbvDckxqHf9tT4Y7kXTizd+6MpuM2pNyyjBU/QigKSK4nBmz/0nb?=
 =?us-ascii?Q?2WPn4Iu8hScyZ/JKhUY5JeRqMag2uncuJm+6HLtLqEs5q+wgeFv/8TZxnTNi?=
 =?us-ascii?Q?JPeE2V7VsO8e/b90N6RF10OihhG16AKlcHymHnKGUKnfUcIqc5ddIQmkDT5I?=
 =?us-ascii?Q?XgH0yhM57GEcigajQjrDp4Z4KyXohl/In5dwS+53pPvck3v2TK6I2uK0m9OG?=
 =?us-ascii?Q?d79UvmTU+oaIFSErtsHNASb+3Z4xOwrzbPI944qO5W/X2RkshdhvZt3e+XUK?=
 =?us-ascii?Q?5nqMdj+0x1B0LFcTq7S3doHDsuzk+iYULLKCRTFRvXuOODkzBoM5URyeMvgH?=
 =?us-ascii?Q?oMDpJHNfSFYOTSdCB9OiqPWQU1lc0L9fDC//7N9b3Ty6Nrhki6HPW+Mtn5wE?=
 =?us-ascii?Q?wQApTY3h8dEV7XKss3gXwW/SxZzn+RNfDNSjrhA36kq0tghKw9nBO9irTR00?=
 =?us-ascii?Q?veAQOVvCOq5mvTAMDUF7JWPzkkgaxN2T6U0gSWaPwnqwkSYooJC8P8dOq159?=
 =?us-ascii?Q?xmrWr7xexTcEtRW2GkToMn1ggGt7qDOgKsu2otPA0XJ2erMyY8wvlma7m446?=
 =?us-ascii?Q?wklwxaftsa8lv5LMYphy3EyVuxcufVpPe33/68tmVEfK5u3uvfkmYxB9fskD?=
 =?us-ascii?Q?HjnW+xQTsBiwAgspyr3WWivoa2HBRlEFmKWtdmbA50hhAghX9aTYkjhwqUAm?=
 =?us-ascii?Q?rnoeY5UvGMnGVgpw0RAQfNxTJfndb/BKVrhJzy2EqamXuw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qS/lsHBRE6rW8hlsWj1MSRBzJzVU3nHPh82wsbWhKddUAQVrVJMxELFI0QAw?=
 =?us-ascii?Q?37VyOUeLmjFWuqbd3KM9kHwpOVIOUlXpj35h+L9g9eKNUo067FPJBq0SML62?=
 =?us-ascii?Q?N2VylbjDGpaWZXtCtisvyV9lNW5+kJMYLqZfXhrhi8ILSatEo7p8S1NL6+CQ?=
 =?us-ascii?Q?wW6WinAqJU45q5LB+6NJAvaWBhelyNnpMJznfzG6tyaP6XDAQFlIvQNhit0a?=
 =?us-ascii?Q?61knGeMQ29R48PBvjPqGwjPUo7umRFmffEm7qMU0+HbQdTCuW+cZjuQYrWXS?=
 =?us-ascii?Q?h49a9PGb08NsJWmU01lQeXDJipvLxswIiWP43rPEvVCPfU/tFrO4WuwVLsGi?=
 =?us-ascii?Q?soWYwvhm7mqKoWa7bOATipM20YMFBXw3/3l79JUP2XVU1fxPBnldSRa0/V2v?=
 =?us-ascii?Q?xR234RbwVtrWg+Eat6ecmoMgQ7sRz6x2sMpj2wWs9Qx+uKFBs2mehXPM08/O?=
 =?us-ascii?Q?BJ9WT1pxS3+SeOKBqEyouOg093I+2/lQxNqcnUzDSeyakVjPRgzf7G2FnSDA?=
 =?us-ascii?Q?92gync0LxIHQEQBOIV7nfWV37R+0CFyjFWHskIMGRBh5t8k0SpKKsRoRnfYT?=
 =?us-ascii?Q?AWl/R8A642ROZrOpOJpcrWZDZKgYX4HI5jHkikFGmzmeJsBohp8E5mRBu//t?=
 =?us-ascii?Q?a1eQv6Q2t7kiPO0N4Ky8GimtZmOVBTsX2lYLZZHnw2ks+uLe+skleGWYOy8a?=
 =?us-ascii?Q?0eM0KseSvHj2ckbi5OCKt+e8FulajohLJPN/AnuDM/7lIBXHVAwmXuNnxG9/?=
 =?us-ascii?Q?LJhgQ30BnanwmKDDhv38Tfud4MCSmBXt/cDFERvLLGbLe1cL9B8jo8mO+ecJ?=
 =?us-ascii?Q?JVzMrNa7Jn+dwxmx5Z4ga4+OwCsdtXdJ6M6f9lNJ/1T8EggbREvAw6vro1fO?=
 =?us-ascii?Q?p3PidqKQqGEfhYdTl5YDZuXik0+HtrT+jdamp2OpLKl45Gx4zoFt8cm3lAKC?=
 =?us-ascii?Q?vkd51utjCn6ACTbdyRG562TdmalDEz8CD+ovQu974dioUk7cGCa+JdpcO8Fm?=
 =?us-ascii?Q?tShuMOb6cW878rmng8JdvwQGhYWZQKJZGrV0O1NbH1ZauVipvwMHqB5MYNtO?=
 =?us-ascii?Q?jsFH1bw/9GaTaGpPJOtDKv81FuHq6vC3qBU4EoTszx3tL1wjltNPFnqrhIzk?=
 =?us-ascii?Q?iBwMgn9eSngzueJ0uQQ2qLGqBJWSERSoNB4E4Z53uHUHCXt8uAngciDDumV8?=
 =?us-ascii?Q?aJAWJbKnDbOlfJ7ZrV6sdnwY/vkF/n4XHAeXVSAr9/FjilnhoDhEbznFsF05?=
 =?us-ascii?Q?0VkZgJW9rBTvw0fEsa1CZ03bNN8SV1iG5YHmFRTzVhGYt9WrnhzOEGp9Y9yE?=
 =?us-ascii?Q?Soy1AGgXZeKr4ON9xA9EhyyyKo4XUyHllSM7GDxRUZQe6O8jqbNFRbF4TPgp?=
 =?us-ascii?Q?VHhyCM5Yb0c0r0Ppv/1tv+nr8CJgX9rHnPXfzEIYo/kLnIeOf24ja6BBLDCr?=
 =?us-ascii?Q?I/2up0LBtW1/m75lnVFLvVtmzgyMMk+RNC1yeVwoRv2M+ROZBv51NP37r/pj?=
 =?us-ascii?Q?qxuanpXvQ6pXpfpLNSrymqtvUACG8KFTTSLEuDpj09twLDL6LSCmgc9VxIGg?=
 =?us-ascii?Q?ek9DBXuJtcwy0omxOwC76cZDBcClSk3aGwbxDPvX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gFzI4I3/s0tE6jzm9Xo9cdwLQCcfiqMAX0steZfOF8VihDAgEGyXhyjzxC9bLlE6dENYvyJuYguZdHhaZgKWea3SjTSYth4hD6zba5THQdyhv1HD9j3+grQc3vsS5dFM14MaZBBAh2ZL8K1XvMIo7Q+HBZ544HH3BGMqXfpJcJ2GRAx7jSJK6PyaKdsPcUiWlzv0STi+XbBx8vd6gPhbEB23HDxFB0Lp7V5BTYDJoDlqIShiOrONPQ7WC/8JYbRsM1UJhbIKxcs7jw6W47pTWdWWvzMgvA83z2CljRiF1OHGrrbdjlFbi4YVyNaR8cuixM4xXVefalcxoZugB9BMK22ies64Xn9yHVAjxGAa6znvVwSjqkLLRniWySk3e9Bp7jIOQ9IEJWiIXyJFSyJslaGXOBRXoSMRwXfCNOsT+kTRD7GDc0ceHQUCRHDJch1MfY8U6WDk5+6FhaudCsXpHw9KCEHln6UG/XAC+kFb0xd7Xa6Si3Vboa16ipvcGU0FMiCkKDaSYW79q0TwDyZTxiuhaqj6G4C5LY3jjGOU8vyR7nwIZDPkrAG3mGj+JnbH1UmfKP6BkqrSfj7OZAQoH6AnhV/aPj/5jFVWSOcjo9w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e25e3d6-e037-40a8-cbf9-08dcd29abf0b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 19:48:45.3326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XrPjEFbQhbXVH4yttSLfPrsqZHsR7W4rXdsaKZ7UlKvNrghXr5Zq30waHP0S8NhMvcF83nsbd3Fp82RmmRdcQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5898
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_12,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=760 mlxscore=0 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409110150
X-Proofpoint-ORIG-GUID: CTOeH4Zukdi4rGOqqxPtGu8fcybOx8ww
X-Proofpoint-GUID: CTOeH4Zukdi4rGOqqxPtGu8fcybOx8ww

* Helge Deller <deller@kernel.org> [240911 15:20]:
> This is a RFC to change the behaviour of mmap(MAP_STACK) to be
> sufficient to map memory for usage as stack on all architectures.
> Currently MAP_STACK is a no-op on Linux, and instead MAP_GROWSDOWN
> has to be used.
> To clarify, here is the relevant info from the mmap() man page:
> 
> MAP_GROWSDOWN
>    This flag is used for stacks. It indicates to the kernel virtual
>    memory system that the mapping should extend downward in memory.  The
>    return address is one page lower than the memory area that is
>    actually created in the process's virtual address space.  Touching an
>    address in the "guard" page below the mapping will cause the mapping
>    to grow by a page. This growth can be repeated until the mapping
>    grows to within a page of the high end of the next lower mapping,
>    at which point touching the "guard" page will result in a SIGSEGV
>    signal.
> 
> MAP_STACK (since Linux 2.6.27)
>    Allocate the mapping at an address suitable for a process or thread
>    stack.
> 
>    This flag is currently a no-op on Linux. However, by employing this
>    flag, applications can ensure that they transparently obtain support
>    if the flag is implemented in the future. Thus, it is used in the
>    glibc threading implementation to allow for the fact that
>    some architectures may (later) require special treatment for
>    stack allocations. A further reason to employ this flag is
>    portability: MAP_STACK exists (and has an effect) on some
>    other systems (e.g., some of the BSDs).
> 
> The reason to suggest this change is, that on the parisc architecture the
> stack grows upwards. As such, using solely the MAP_GROWSDOWN flag will not
> work. Note that there exists no MAP_GROWSUP flag.
> By changing the behaviour of MAP_STACK to mark the memory area with the
> VM_STACK bit (which is VM_GROWSUP or VM_GROWSDOWN depending on the
> architecture) the MAP_STACK flag does exactly what people would expect on
> all platforms.
> 
> This change should have no negative side-effect, as all code which
> used mmap(MAP_GROWSDOWN | MAP_STACK) still work as before.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> 
> diff --git a/include/linux/mman.h b/include/linux/mman.h
> index bcb201ab7a41..66bc72a0cb19 100644
> --- a/include/linux/mman.h
> +++ b/include/linux/mman.h
> @@ -156,6 +156,7 @@ calc_vm_flag_bits(unsigned long flags)
>  	return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN ) |
>  	       _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    ) |
>  	       _calc_vm_trans(flags, MAP_SYNC,	     VM_SYNC      ) |
> +	       _calc_vm_trans(flags, MAP_STACK,      VM_STACK     ) |

Right now MAP_STACK can be used to set VM_NOHUGEPAGE, but this will
change the user interface to create a vma that will grow.  I'm not
entirely sure this is okay?


That is mmap(MAP_STACK) would set VM_NOHUGEPAGE right now, with this
change you'd get VM_NOHUGEPAGE | VM_GROWS<something>

>  	       _calc_vm_trans(flags, MAP_STACK,	     VM_NOHUGEPAGE) |
>  	       arch_calc_vm_flag_bits(flags);
>  }
> 

