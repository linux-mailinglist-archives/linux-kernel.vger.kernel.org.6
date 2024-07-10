Return-Path: <linux-kernel+bounces-248175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFC692D919
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 21:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D58AB245A1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF7519AA43;
	Wed, 10 Jul 2024 19:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EYKbQRth";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="j0xantRZ"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3AA199EBD
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 19:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720639442; cv=fail; b=GgrQbxffGHr1yxvpEIORkLgL83k58vNpNcHNLrZyAmTpye05SfkScK7U/kKafdeftjxlZsHKp86z8n4w9Us5Wi3yNFRi6WYuZxpzrymss81XVoGFePnUMdgBl+gVm0LqsFHuSBpfLgJXIJNdx3epXyFdQV8xQfGCJMOGlfCZKi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720639442; c=relaxed/simple;
	bh=ccNvsJjLiu5sdXDCgjbZojyXNc/oAZTUclMTtoy/sYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C6o8Mi0wYhX9uGQW/2adqzeUP4Qp8vH4jA0y+tDOBfKbfKxN4dIsKGKgsXj0EmT5XrGw/BEIcnXcgqFsdf8Uqx1yeN9XV4yJ5yBela7KZnp2wwhM7dw8kP3MUM6o1T2tV2lYUx4gTK2Z0+LJV5oalfF2T56l2LaDW58LMtTL60s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EYKbQRth; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=j0xantRZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46AFWakw012654;
	Wed, 10 Jul 2024 19:23:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=R4F8rao3MjayBNoKJIVe/EoeHe5UK5E2GYhCX8D9hFU=; b=
	EYKbQRthbj7NQZ6eoauLLT9CJ/L62ZLEYdT1i4Y4oLUOKmF2mMTp2lKuFV7W6zC+
	WyvDwH50Smg4hwWkQOk9DybtQCwgXedy7y1GY8pH0vmIFrABc1mBhre5fiGzeQmd
	bq66Nx+3heWhyz/XAz/J0IdnSymaZp20li//E0QSYpsGArligRsFaHwGp9J7csR+
	g5WQNp8C52aYmGf9eoLVceAeF1DdFiWFOsD30PKUKz1EN+uDX6QNvMJvKHA0Bv7M
	TV5foTjn63QP4S4+u4mMN8xr+MpMUKnpgeOz76gJ4pLRTQ/G6qf1oAYxryypVZVA
	OZDbFY9xeTcnxLCJGmNjVw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wkcg0c9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 19:23:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46AIlfXw010839;
	Wed, 10 Jul 2024 19:23:44 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 409vv4s3w9-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 19:23:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bfXuo6kL6+QoquwV4ZdshoB/of6oLtHSggFhL3whxQXQoyuiYC82Nm116SBYUyJZVxu9rxD6aDG4btii9fiRMxJC7UKC1Fxx4iN8KKKhsySWprEvRMMvCTRgdZEbkl6M8wzi2C/poK2z9ZZ5CdH+o1OxIFsG/pBFdBadk/QF/x2VBTCtklOYjFPVkkHEQ7/ZNvjb0T9DEoPLsu+PRb9dkeLNfwe7hOGJDzqcF23+KLMw6MCPnXiTSwViisUbIZXSOmBwe9HtIihwcERKMk2f1nlKpZa43ks7NIrOggiWVdUjpYaQyQsAF7X7AOpQw/1QJp3gY86WCUxxGgII5GFGmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4F8rao3MjayBNoKJIVe/EoeHe5UK5E2GYhCX8D9hFU=;
 b=WabtkdCmFD7Vdvl6+tsxNQnORSX6TCDHe1sojUFmYxHDfNi5A278LAKDs203skXhNN0WaQ7SJa69Y+xeRL39gIf/ADknlWuEe1jzls4rtP9ZDCvaALXfuvm9qOmS0LaD1jDyw7pacXMZV4vScIKW4cVgufyGvx64rpkbQtwEaCk+BOg64+Iw2MA23Oo2KFiRzQ136RBbodTX9B2xZlu8FNj1Z5wfBT4Okd1A9jcdDM8BZPhuPMTtIHkGnbni8KAKS2+U7HUm7tkLC4rU3qrPjma9D4qNf9+aTyEk+wtM5QT/6UDllZemVKBHgl/MwM1Y94TmMd0NZRbRoskKb/oKEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4F8rao3MjayBNoKJIVe/EoeHe5UK5E2GYhCX8D9hFU=;
 b=j0xantRZF7nRYg3afkJ2ksqeVYnHN4sVaCtgO1g0IULyTGcy6LzJfk3x2aGZyiumyDFberlTtthTnZKT36GPFyHOO8mQX9CbFKbc7DazNZNdEzvVL6KbFDq3qWd9z/BQrUBa3XVo0J8D0qd8sC+qPAYUxJ7iHPhw8FCiEwpXa5Q=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH7PR10MB6106.namprd10.prod.outlook.com (2603:10b6:510:1fa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 19:23:40 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 19:23:40 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v4 20/21] mm/mmap: Move may_expand_vm() check in mmap_region()
Date: Wed, 10 Jul 2024 15:22:49 -0400
Message-ID: <20240710192250.4114783-21-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240710192250.4114783-1-Liam.Howlett@oracle.com>
References: <20240710192250.4114783-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0129.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::17) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH7PR10MB6106:EE_
X-MS-Office365-Filtering-Correlation-Id: 92ed5a95-e31f-4c7d-90dd-08dca115ce07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?wUJQwqx9tt5cfmT+qnVeW7vpEzE7yLYJQ5I6/NIGBy0dhKLvLgkYMQC0IHTF?=
 =?us-ascii?Q?a6WG6BuEH6MwIqAQCz1I15WmoU04rr6P1fQNFugym+c1r24J1lX56cLjmV2T?=
 =?us-ascii?Q?eoZSQ5oFotyU7Z0sizADm3KnXc+c5VKwHuEkG+0B7hL1wWqFuXbLTnqdIghe?=
 =?us-ascii?Q?Tmlpsp1BbogJOroGqN4V86YBn1bdM3eaGvCgIkW1/cVVCQIBi7X7cjLsvTdQ?=
 =?us-ascii?Q?/rkj5aJyb0ASRkFa3ORAEfVdVIzmFLE3mZnIkQFlN58C4Y38ZqZpV4nP0N85?=
 =?us-ascii?Q?SLX+VtGKIh3gwjn2NcippWrR4ozaePzAIQseKHkiLZqEXv1TsJ6Ldbc7m/c4?=
 =?us-ascii?Q?QcjfntrlB3ll0Jf1maXMQphv97OfUSj6nqxg9JCP0Byf121Aj+z0buVTFCcJ?=
 =?us-ascii?Q?isdLEI5l/F4l/1S1edrbuk7gqqWkejgAvU7k6zAhDPLGiUeOwOnT3RFogMwf?=
 =?us-ascii?Q?rTw+PTVNwLsY3X6NVxFGedYBuxha/kYJEfpgCeWmGV2uJDK7VfXVlsk7h3en?=
 =?us-ascii?Q?F+zPPwuxhhliy1Ddog/3/i/W7gTZ8KTmWCwJ84Doln5IE1jkaJaqbUmc9GWW?=
 =?us-ascii?Q?oxGKlL0PfoWRbZY21Rn8jVNvdUJqz17d53r6NtU6lEiuQmO9xfsO9CECyZSH?=
 =?us-ascii?Q?2hgzMbdLAzRZpgtnKWUeZs4tL7Ts69I1E5+nzFutvo7YiOoTBSyyokHhg6m0?=
 =?us-ascii?Q?1BCULgmmIsrGAnLL7aSEKCLwqDpX9heub5Y6yccNawlF8PlxSw48xM0rU9fZ?=
 =?us-ascii?Q?9qOzz8J/RJHQDQiyOkP4rKfWVpNcwS0umbbKpNKg9lAW4mvo4jLlSjR7Ysx4?=
 =?us-ascii?Q?oNi8BQb7ITqvdy9IWeVNl4n3Pq579vNRf9r45KC4bYjj2YhsUjFih2bnDyIf?=
 =?us-ascii?Q?KBx4oQEolxofJs5YRV0bwLgpaXyj6r0qLIwmicncMWA5qpuavGGW851yi8PJ?=
 =?us-ascii?Q?vuxDtq8WeUvemBH/GfzvDUqF3s9I46RGdRWGNWWPTklhP7+rY8u4YDb6gJ71?=
 =?us-ascii?Q?4J1ivxo9OIGfEC0r5fbfnMtnz486BpOqR5h/lXDej8JyP6YUzfm5hS3wpHt9?=
 =?us-ascii?Q?TRi7GaKtm2/uVuxS/VF7IWLibQgcFXd2MTCidb84LRh7iK+XXTwVnKnH0GWP?=
 =?us-ascii?Q?eOOu83N3cjh9ZzNWjzX/32pvlx3LgNSgsjuOrT8HR4bO2YFd3OEPDeqjGM8k?=
 =?us-ascii?Q?FKYSW0wKila+nnbDpYbeX/4rbH+FWEncklbvE1jVE8ZUJcAQXR4gREyR78Ds?=
 =?us-ascii?Q?GipKlT8rRSXqeDH1H8Cq1EfT7p66n9R1IOvPAwqrfpcGU6CaUmaVYhSd6ktu?=
 =?us-ascii?Q?wWMfsfqnfEEiNTx2wC8/Jwpc0zOifGSjYYkfPubIBG4wfQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?9FGTzLTqorJSnDScjEfMjeCn9mJITulKc46XZ/GHtplnktZYMwBG+ZDC7www?=
 =?us-ascii?Q?ye7AtqiMhuw/YO/TRgOIY7Un7uG2OnPQQh20KldBTmv2zHxphoXXFyprF9kB?=
 =?us-ascii?Q?YjCQZ6u5NtpI4YxCg5mqPlPYLIuc+AFoLNxQmjHdhAyVm3UEN4+hHVkw9Pzo?=
 =?us-ascii?Q?+fUI0U4pybM8O26C7/RzMD8nJOWFOqgFX5pnhLKvfJTDuNM5LLCX8r/QB32l?=
 =?us-ascii?Q?DdHJb/DM0DFloUqvZx91q477vsg/jR/M2efIqclbuYDny0j4l8Wo3+E9REHx?=
 =?us-ascii?Q?n+bSEZkyQfZnGvxuU1f6y9Z37NIgwV9GmB1gWJHbMr8Ea/rvsOzGcUJj6Fgj?=
 =?us-ascii?Q?DSRyhE1W1qUV3IwxKVu+k5kUr+7z/YOxKioY6/dBtk94QeJ+nerncNrhmavC?=
 =?us-ascii?Q?IhmQz0gc0Fg/gyt/18bTJySQ9Ctn05NHl9IqGMCvAU55FXeQuJ17OlR7cpkY?=
 =?us-ascii?Q?LCmVN/J3da60kW319xAMSYFMIT4Ei4XZQZum2g50VJgCB3j4D3VVkBnpZ5px?=
 =?us-ascii?Q?idp0KCVCE7aEaxKRai1uonXlJlgchZuCix1OYrwt2bWYdJsrR/p69O0T06Xp?=
 =?us-ascii?Q?Wx0A+ZlyVl/gEca6tlQrekhu2bx2GTRTCQ8qGVwg+vHm+PJELH6fQ2Lmt93/?=
 =?us-ascii?Q?rAS4d5kMRGTD7Eg5uH9lCawTsu/KdN54TFcN3wHmdMZG4OckAEdtLj/ucQG5?=
 =?us-ascii?Q?OLaMTvmpYMLxuAzZbuIQBiPtoKgeN+wIU6CR+uSqcN5BYv2iPR3Sg8HItPDA?=
 =?us-ascii?Q?dBHNHdD9eujommpCxkmKOW3RxzQUQ+yAhiR4gDG3Vgne2Pb5NyFwbw4WGBK9?=
 =?us-ascii?Q?2KbeiMw6bpxdsyue6I8Xx8HFavKqQAM99Rx5NQzpc8g8y+G380NOqpQ6oOa6?=
 =?us-ascii?Q?iEhOTtRNdCfheKP5lh4rkRw46MFtjlQtaM7Mu7+DdUZojkVCjOLrBrxddiQK?=
 =?us-ascii?Q?gBgT0Q2E/wM3TYnMgi0huqLv9GCmF5SVXjs3T/tjIWs4bB7+YABEcyrxz3Oi?=
 =?us-ascii?Q?gB5jSubZoDFeSkmoBzKMjoAk+PRGDzLZB75FGsvTfkycSAmaoKMtfdOsCp2B?=
 =?us-ascii?Q?I8qboE7rQnYuMufgdGMPNw2y6rl3qz6V26hwBosVBe2TGx3p16T3W1GPzi9A?=
 =?us-ascii?Q?iBAMiVxugyWYmSTIY7XxcFfY9H7cvawCNKJ7vJfCOOMOOiDTEeU8uoYLNhMH?=
 =?us-ascii?Q?2uv4Y7Ng5yXQhV74qxTgIeimtzeO2YhroUX8+n5PegIWy3dkXKVWNIrTqft8?=
 =?us-ascii?Q?QuxUcC+hifx3kd7DD38e+7BfOPx+pAmFeLfO8GQDg4HbGaexwd/PMNcVNhVl?=
 =?us-ascii?Q?H47z2AV8hNRJlpZh6VK16NVyvWDgaytE8M25+T/3LFcpnvfuhAQFIdzCzUfu?=
 =?us-ascii?Q?dmTUDggbLKrzDMS73iD/jSUgHpvNWcBQITKygvud+YQnT/iZspLyAbZOgBR2?=
 =?us-ascii?Q?QY08yzfncMn+YePVvxr9unOHVJZSgG5/rHeCcOTbBEIf9GPz8mdCDsEQ278N?=
 =?us-ascii?Q?fn09ykc2ILjIkZExo+aXuQI9N8fCjxicZ1DIrKJLlYZI9ZABk069kye8qJm1?=
 =?us-ascii?Q?fr28ITQweVN4zf/aXiKqBx6NLneGJw3o73QBJ6jE3BA5oIAmj4RXbJqk2oVy?=
 =?us-ascii?Q?Eg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	5jfqwHu3kvgcAmLQUf7B4pvkmIg9GmeILMP0sH4Mgp2vwZt0fMrjJ+urX7XWmbqGM0SJGYfGg/MZgotUIu6fpKb0tOiqWfDhDk2hIM4WBsj27I0bYubk/dYnqH7hS4Bxx9+kfdM3akYaNawDQ8Tkh84YVgPqeslS2mz28bDjk9qlGHg8Fh4k+sKrSZuZ7stRin1S8n0xTZzWXBIBziSL/p7jEJXsUPjdXYcpurK/HfPKKgR1e05z5NOEbhcX6wX3nyIRUoByG8/PRVuvaOOvjnGTOd/nTJnxV7MpTvzHIbSCRBsrc88xJSzsQ6IRo4CYj7wvTK5kZdyt1s1hEYik7S4beN+PgFZeSYb7vXULrqbTLlEO1eqdLrkraJSK/FbYVMklgSQd2Cu801m/mdQBWoVUIF/03lWqVJaWH/XXqDvykjlyGZ+ClcteuJvKxCbeqgiEkaihD8QIA15xotQwyAZcaGpoX4Wa5aPfUwwtpw0GDfoqAHZwtndgKLLBx+opUUUU1JxLignQ9cBYeQQmbwL9k+JriMXVZIoC1RZOLymY3CnxNQ7GpuW5o2rUkZqyISTPM8oyCsz10Px0T3ikfEdc/fU/x1zjZX478bN1frA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92ed5a95-e31f-4c7d-90dd-08dca115ce07
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:23:40.3483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6RtyGHHf3Z7ebEQusU/LtQ5gjoqjdF5jgbMy9t9Xu0XhNTRsCCAPQnuOJAG5Hdg78h8BqV6sw1SX8UGJZvAEOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6106
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_14,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407100137
X-Proofpoint-ORIG-GUID: KNAbtqKf8cPVN4NL7WcjgUnl-MgSzX4E
X-Proofpoint-GUID: KNAbtqKf8cPVN4NL7WcjgUnl-MgSzX4E

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The MAP_FIXED page count is available after the vms_gather_munmap_vmas()
call, so use it instead of looping over the vmas twice.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 36 ++++--------------------------------
 1 file changed, 4 insertions(+), 32 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 18c269bf8703..7a440e7da55a 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -401,27 +401,6 @@ anon_vma_interval_tree_post_update_vma(struct vm_area_struct *vma)
 		anon_vma_interval_tree_insert(avc, &avc->anon_vma->rb_root);
 }
 
-static unsigned long count_vma_pages_range(struct mm_struct *mm,
-		unsigned long addr, unsigned long end,
-		unsigned long *nr_accounted)
-{
-	VMA_ITERATOR(vmi, mm, addr);
-	struct vm_area_struct *vma;
-	unsigned long nr_pages = 0;
-
-	*nr_accounted = 0;
-	for_each_vma_range(vmi, vma, end) {
-		unsigned long vm_start = max(addr, vma->vm_start);
-		unsigned long vm_end = min(end, vma->vm_end);
-
-		nr_pages += PHYS_PFN(vm_end - vm_start);
-		if (vma->vm_flags & VM_ACCOUNT)
-			*nr_accounted += PHYS_PFN(vm_end - vm_start);
-	}
-
-	return nr_pages;
-}
-
 static void __vma_link_file(struct vm_area_struct *vma,
 			    struct address_space *mapping)
 {
@@ -2949,17 +2928,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	pgoff_t vm_pgoff;
 	int error = -ENOMEM;
 	VMA_ITERATOR(vmi, mm, addr);
-	unsigned long nr_pages, nr_accounted;
-
-	nr_pages = count_vma_pages_range(mm, addr, end, &nr_accounted);
-
-	/*
-	 * Check against address space limit.
-	 * MAP_FIXED may remove pages of mappings that intersects with requested
-	 * mapping. Account for the pages it would unmap.
-	 */
-	if (!may_expand_vm(mm, vm_flags, pglen - nr_pages))
-		return -ENOMEM;
 
 
 	/* Find the first overlapping VMA */
@@ -2987,6 +2955,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 			vma_iter_next_range(&vmi);
 	}
 
+	/* Check against address space limit. */
+	if (!may_expand_vm(mm, vm_flags, pglen - vms.nr_pages))
+		goto abort_munmap;
+
 	/*
 	 * Private writable mapping: check memory availability
 	 */
-- 
2.43.0


