Return-Path: <linux-kernel+bounces-381604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB699B0175
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 13:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF0C41F21D92
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 11:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F30201016;
	Fri, 25 Oct 2024 11:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JtX3TZuy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lmlqQbur"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1749A1FDF8B;
	Fri, 25 Oct 2024 11:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729856289; cv=fail; b=Bw4L4pbvHz37KprCpQ5EJU1hbpseu3FbVgVvmoli94T87+TQ14SUv9LBR8/K2Q3oK+7PpK98ewv5ZHWrUQwYmSyXSoyliCZH2JiPTLaIBliDl7+rPiR21lIyW++C+rqesqqijk0LzWkRAkPgGbC/qOcBPxrHp4a4UQKNuE3AKeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729856289; c=relaxed/simple;
	bh=bN4pL0pRsG4Rn1EdJ0kYx9lvPXg1uMItSEAx2B/7n5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Df+ntojmVWU+SLwjIAFwH5mna/c9mIyZ1LaZ6qHl3f2Ld93lOxUmWBSs0zb0bqLfLhq3ikEd0YjvR1tu92JJ46mMLgOMVdwgOsT5+8gH6z5kO5WIPvdhdELnj63nNykYvqkuyp4Nfy0cS6IpTQjHKcpNEU7oIK8gyfs+h14n5cI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JtX3TZuy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lmlqQbur; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49P8BXEk020932;
	Fri, 25 Oct 2024 11:37:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=VPrDKiWzD8lDGIgF8I
	JUz+qfVgFaa203VLubmUglcb0=; b=JtX3TZuyvYvii6I9FvY9MpQejk13BQnLUd
	SzS0vO7tRLxvZo1e6E01ui3aWqKNqmNM6JcgF/HG0+ujNeSIjFFQp4stlweO8NM4
	E2WAtbnZRoAkDsFVDHZe9oDTuVrCf6C/Hv0WwIwDjaAwLM6//yY3liGfeRPMWCQN
	jO9ls89+efqAr4mzYA0Rh9mHvU32w1DgA7e6a21lBZ3c9OG7PpU1MGOnof59plt9
	cZjtBnmNK4FeF5rjGIbii1TxJ8Tu8Kg8Ly4BJAYRQd/9EofdCWvA4YVQBl1ht9Es
	mrDW6rGfeVxy+ww3wo1QGSvKd1zbcer8TuPRVDPvJV7Wf4j7JZAg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c545cvep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 11:37:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49P9TQVZ027343;
	Fri, 25 Oct 2024 11:37:49 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emh5mkf7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 11:37:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EOxcy0mZOInKMSgaQBY+uTSGCN7wwoukXrX3XjYGfflduN43Ph1Jf0qfbKRjFOfegS6xRpxli4WtGKMSogkefo4XXr7OyEGLr2TkpemuMx9cxKjOEfuHn8xeSXXfzCJ6LqJdg61QXHd7bEUTBEYKEm253oT5KJh5JWc36pWs87PiAlvWQ224fMtU0ovYwQwwyDYGdKRzcFhVaJQhlzZkMqJvEuDcAl49VHknydJmsIRYUWa1w+L5g2nOQTMxiJzgbiwVDS0sUSqZxECKJpzBUynOZh5UXUzA2IgU76UsD2DKVEhz9+XRheiBmNpMvKv8n2fLOzGN6UbneZr8kyPL/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VPrDKiWzD8lDGIgF8IJUz+qfVgFaa203VLubmUglcb0=;
 b=kl/G6meI1MiydRtjAt9yIG2Z1Qc1MEAC5EursdHWT9O1C48lcpftTeCeMd8pvXsw60ZpuRt/ZHRDLr0nWTmriuneEx/pftbQyY91sxCyuEdTZG7zzvaZ21CP4ui3TyJWd8xkVB6LPI3XKhjo7bo0CszpKws4+8R7hqUSAf9VE534Sfs1QgYidre1x8rlW5zQAv8/XaYuxUgSgHq8hw/0znD0+zi64tCG+QAP2bRTzJ9lI18w1iXEQe1Le8DQP3tmIpUhABd/H1GlfbVklr7A1CoEIMKMwZQ6EbucvejqD4F1p13nvf0ZdFaXQxW4owFRVh/UcJn5/18xKYYasn/4vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPrDKiWzD8lDGIgF8IJUz+qfVgFaa203VLubmUglcb0=;
 b=lmlqQburvcdVGyUav8AlnrZfnlr9fyDzFH+fL709bKPnw/a4dxoH5KXpF9pWjxJ1FzeQbliraAKJaG+VFgnAHoFiXzF90LG3RCj+wvtivvFBq8213uDkQysuSsU6kKbKrzd3iym0vo6FHehoSN07v+ezQNw6bV+a+Uk9DEEpAW4=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by IA0PR10MB6868.namprd10.prod.outlook.com (2603:10b6:208:432::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 11:37:40 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 11:37:40 +0000
Date: Fri, 25 Oct 2024 12:37:36 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: syzbot <syzbot+0ca979b86eaec7337a89@syzkaller.appspotmail.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, jannh@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        vbabka@suse.cz, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in
 vms_complete_munmap_vmas
Message-ID: <832afb0c-98b7-4d29-8436-1ff6a65133b8@lucifer.local>
References: <671b7fb2.050a0220.2e773.0000.GAE@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <671b7fb2.050a0220.2e773.0000.GAE@google.com>
X-ClientProxiedBy: LO3P265CA0033.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::16) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|IA0PR10MB6868:EE_
X-MS-Office365-Filtering-Correlation-Id: 01d8f98e-be2c-4fab-2376-08dcf4e96ecd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QJjUbbB/brViXzjl9oVfYSAZUOKYlyA2+fkbWDdWOmNiU2MA0RuI8Wv2iMkx?=
 =?us-ascii?Q?s0WFGOqBKljDY8EcU7IPgM9MDTrMUlW0Vjrqolcb88r+6zscmeIPdDS5bRMA?=
 =?us-ascii?Q?SCuSBaJfZKH5FOnK7T6mQM8bbAz2qL6CcX7CXrkayl22O8kZrC5BW1qAiIjW?=
 =?us-ascii?Q?UQJnyzj/csala0yrZKukhnwhSGLH1kJ+CBghGlbCeZ6dUgO6xHtVoCp6ZuT1?=
 =?us-ascii?Q?tyRQqIBysBZocGL1FRQS+UqEbitgFfn8hagv2pcdJW6ocOeEelHEufjZZRE1?=
 =?us-ascii?Q?MbHfR+eKNjXUVObRT+iruIONna7eVJ/BaR3t0u0DQQBGU/uAPanstyWbw+cW?=
 =?us-ascii?Q?+l0jy3QavNigqOcPJb24IvYsO7x3ca/YmXzxZfd4i7gn0i4RWJkFvr6oPx+3?=
 =?us-ascii?Q?CqNwETvxBMe/zJ9D9jE2Khs6a0zMlqDvQz9e83MGZ3dVnooJV+2o/SKakGIn?=
 =?us-ascii?Q?fHeYN74CVdHYRCaf15Jh1p+xFz8vJ/Or6rvhfzkUiZuLsbpho//9FioJ8m/9?=
 =?us-ascii?Q?CMjxEBZ5kA1WKTtTxLIUDH9Bkgqk92/C8n37XYsEVQeDpTkoVoIDUrPNNd3H?=
 =?us-ascii?Q?yK6dPkmdwtM7ty/5xqtGobrCNZZcGicZFIJOe8eFmg0kZrn67it/vQjxrBz7?=
 =?us-ascii?Q?7mENA35hb3jfEzKeHi43JNZcLjE/KkZsPqyl3Cc956QnFnjz5bz/VLfnSF3v?=
 =?us-ascii?Q?YGfW1cEExIS8ohSkEgLWMXJUk36t5YZ4P3xDIhjC9aB4VnzmeZ+MdoZZ6WS9?=
 =?us-ascii?Q?9IUGRIec5mLYtULCG+xsaKUH0dtRwrGVtvv5l155I06v5/XGYChGuXCnCoKI?=
 =?us-ascii?Q?vuzqtBas5Ouv98SxbG144+S7niXgquVizUOIgRasS8lpQSfnsKY5/EbCTX6z?=
 =?us-ascii?Q?NlKCHs25ggQvfFwJ9oWjukr0iSfBCSHJxQQeqK2b8z2GGg+ijILQGOH6Slxr?=
 =?us-ascii?Q?Kw7VqhL/A2HGOqVwTMYe9OaSxsbwLlwGI0VT7VPvAZwQVyudpVtk3qTgyR1G?=
 =?us-ascii?Q?D/iiG3OUSLmG596j12EdiM27uqGljfY+SOChD3u1aKGGWEQcbmA/vqF4Eigc?=
 =?us-ascii?Q?D8FLVe5jHQvqNDztwYwYuVKgsC7owfCsfm+q3XwmUIsS4APNB1HRKPtRdBR4?=
 =?us-ascii?Q?2Dpzb9Uvp2gLsWMADNMACIfsSCOp/RLequa+6MbBoqeHnOKtS/59t9Yiv6c1?=
 =?us-ascii?Q?3mEfCZTJ2sdEnwMajl8bV34LZTbWbNPTsFFZiLF0d6gpKToOaShGOgwdftqO?=
 =?us-ascii?Q?5P5xt5VZjF/ZM5j1yUH9gx6sBBedVgO44DTgUtA2MA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ELGCpmA/E0SUMkpLMQnUju1bm2vjxBVFG9wmadGyPgP1kxSD1dz3U+Bn/eor?=
 =?us-ascii?Q?pN49E2stRCFmHLMizJCC14ikc/ghY0fbRRcjNVRY5mq3JPt+BZqTqN3K2p4X?=
 =?us-ascii?Q?Wa7mGxCYMn+qiVPxwdo8VigU6nGfmBljFjaMFSQ3mEZXegPfD8vHV39xVbOz?=
 =?us-ascii?Q?mKmKJ8VpHdlpJTrVwUytMaxCel1DyA7aPEoCXCIFi0l36JuTVzcV+gSfuIVw?=
 =?us-ascii?Q?XUEXq2d+xA2sKbmPudosE3EibAqyuOpFoLQ3qTFI8G7SZohB/1PyzkKR2vh7?=
 =?us-ascii?Q?AWAtFj92EPkH2cp369fKmT0xpmyIROs7C7SvtAax/a2bJ9oBdqrN1U+sIaXf?=
 =?us-ascii?Q?wCvbzyIrIeIdF/ytP5ZBKkn5ALTi6auTnJLzGw+HDMxAsQpFxhU8b0AeDCVb?=
 =?us-ascii?Q?aK2Coo4aV2YFCzeG/S7hYPbNtpKQy8nWpwwswmmuOGm8Pet4KLOo1ZuQHn7U?=
 =?us-ascii?Q?yC3yfXOxogWyEFTQSTYgljb24VyRhr7GlxtOIZJVE0vwQFCQ5DjNebgTxWPG?=
 =?us-ascii?Q?l4m+1mRmV+Yh9GKNUjp9xZL3J6G09/LBlIdLjATo3fB+EIYrcRJvRg6zJN12?=
 =?us-ascii?Q?44XiKjz08z8yv5SO216lKBceId0SP7m1olwSFuiRL6aI0w4/4ZRgu+i/K46X?=
 =?us-ascii?Q?rD2uK2tQneItVlTDAU/Rvc2isJTCccAvWWA5mqhAmxxKJtOUHklFokkWQ3yd?=
 =?us-ascii?Q?hQ1MLy5QMvKlRutTuF+CrTanqFM896+YMuZ05b6tzBf7bRhZR8XBFpFn69cP?=
 =?us-ascii?Q?wkzrqTnE6RB3VcjhXvVOqWPOtOhM5bkSfM5qsyDZ92M6bs0m2svBzC+ERctk?=
 =?us-ascii?Q?HD9OoKkEI4yWkZCpFbYC24VvPyB3oki71Gvnn8b+uvXVf/mkuTqn8m8ev+qB?=
 =?us-ascii?Q?PAopADdCLfXXYMPPHaRrQI7Or6FvEP8PZ09TuijJjpl+3mNISVYZlwJmJNTf?=
 =?us-ascii?Q?oP3N+Ma0zr9ZBCiewjSkX45nri6LMvw/eGh8skMjoBgZ8jv2PcAHXVW2aqAW?=
 =?us-ascii?Q?FNMhfzM/ijmxWZk6h733SU4ba2yrKXOYaS8NAkXeUntZDjwxYQnp3TSjnrWP?=
 =?us-ascii?Q?nIYdEbWxDZ+ENexWYLFiMVKV7+UfduCGQrj/eaOqopbYHpTy2O+WFLWTr0TY?=
 =?us-ascii?Q?RoVhfs5aOXFVtCDlQZus1IS5WDhDM+EdRkc7CKtiNIhjYpauEC1106XzOLY+?=
 =?us-ascii?Q?wpNjapTR1+dODrhBfOztc0ODsO+pN/IDHSyGEi5PSSvx5hxbECtcNEWg49vi?=
 =?us-ascii?Q?VtNPpUzz7kmqF7t4LykXHl6wn6thtptPfPbCaByyLVQPcSIp429HnRBoCPXQ?=
 =?us-ascii?Q?hPtOhacjMlxBhVLMuGhjYIhj4iCFZX4CciZte+WIJmikziU2bOVXYu74AnR1?=
 =?us-ascii?Q?ej216zWUopd+WSHNbjQhlWPlyzFZ4+/8xeQH8BGLiyFalvpXeLyJeKgAvcP3?=
 =?us-ascii?Q?/i+okyV1xuM9XuGjcJ4HAs/F5oOPhcoQlfZIDnC9aI/RELCmaSMaCrgXaaLy?=
 =?us-ascii?Q?K+NnbA4AVU6Chx99lkoWjIHRY0Tx86a84PKof5QQ+GJg8ECv0nMKfwtKrOdq?=
 =?us-ascii?Q?cKs5FOmjsJ6jU576oJt0uPkGFA+aQkczkpKJGrYeM+Pf0oI0pw74o40xOQbT?=
 =?us-ascii?Q?ugvBZAaUfAi1JA/ZTN7pr1DK1hLKQWtunQPKPp5fHGWIh1Hiqr86SYd5uTxY?=
 =?us-ascii?Q?0wV7Lg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8ubFDZFeYuVVsUq+jtWyMc9yndm0kxrK7+oxklgpxzHhXBvS4KWF0TPGA2qPVvRCwHpBf388IhtuZ4fak71VLDCbCJO4Q+yl9thL7IwsRIuX+vHCwzWqb0mkkDqc505+a5/GO+FkTjVA5b+MzZojJzsVKLVK8OIID1Nmc2kU/wtJfs9AT2eAFWotNASZEtWvymrXs/aQN0TO7gYQb3szRXHBRT44/42x0kj1KHkBniutIN3Xyf4wy/zFcPUJCvvaAMYi6V3fmkbQvHZdH7JsrEcVd7iuUPMzvY0sKIa4y7lXpsYXaTFpfUPDAQOOXOnZTMe5HSaW1SHN6URXvyOuMufPgb6gbNPQNYwPQIo+MNDQpIKmN81oO5PqROUxFMKQaSwYNiMsohEzN2SClYkSs03CEmH+ax2EN3UuWLAy/MMn8zDUsDN3G0zt5+qVlpz1wK3nDcjy0P+Sf3QlHZ7Iya6aGmvYrEyAmXYYCX/Kgtr1tNc18ibZDc9AhvqVVsBpF7JRzw2AFafoL5Mj/E5PBkGHYcA88putqBlv6h3eEXFxhXBL7A9JZfgNfgzRa4wsRPg0pVZrm1xddTaSe73jTrUpc4sSl/w5hgPjjJk0/0I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d8f98e-be2c-4fab-2376-08dcf4e96ecd
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 11:37:40.6758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 50IN3O7n8OVdSksfrbpuxgYxHdmu+YCBu2kALuzfRV3CW0+nKHClfKgQ9Di/QZ99Eb5cuUejjxiUXtvW6Ogr5opsHWCwVmIIVnHSk+EvWS4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6868
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_10,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410250088
X-Proofpoint-ORIG-GUID: JudJpwiQyuzZ_7jXYYVMQ6JkCqIwtS7Y
X-Proofpoint-GUID: JudJpwiQyuzZ_7jXYYVMQ6JkCqIwtS7Y

On Fri, Oct 25, 2024 at 04:23:30AM -0700, syzbot wrote:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    c6d9e43954bf Merge 6.12-rc4 into usb-next
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> console output: https://syzkaller.appspot.com/x/log.txt?x=139f225f980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4a2bb21f91d75c65
> dashboard link: https://syzkaller.appspot.com/bug?extid=0ca979b86eaec7337a89
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=179f225f980000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/3bf4a453ec2f/disk-c6d9e439.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/e4a2db2a5d95/vmlinux-c6d9e439.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/8eb8e481b288/bzImage-c6d9e439.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+0ca979b86eaec7337a89@syzkaller.appspotmail.com
>

Isn't this just the same thing as [0]?

Again I think we're just happening to hit a stall in the unmap logic rather than
this being an mm thing.

We retried that one a few times and it didn't hit any mm code after the
first time.

Greg mentioned there was some weirdness with the dummy usb hcd controller
in [1].

Do we agree this is a dupe of [0] (if so we can tell the bot so) or does
this need a deeper look?

I mean I also note it looks like CONFIG_DEBUG_VM_MAPLE_TREE is set and
we're stalling in a validation and in a traversal of the tree (maybe it's
huge?) - this mode is very very expensive to run (it repeatedly validates
the tree) and sometimes might lead to unexpected stalls or has done in the
past.

If the USB issue is somehow slowing things down maybe these two things
conspire to lead to this...

Anyway my feeling on this is there isn't an actual issue here, what do
people think?

[0]:https://lore.kernel.org/linux-mm/bacc4301-be1a-4f3f-9da3-1543cbf9874c@lucifer.local/
[1]:https://lore.kernel.org/linux-mm/2024101602-skintight-crawfish-ebab@gregkh/

> rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: {
>  1-...D
>  } 2686 jiffies s: 2593 root: 0x2/.
> rcu: blocking rcu_node structures (internal RCU debug):
> Sending NMI from CPU 0 to CPUs 1:
>  poll_schedule_timeout.constprop.0+0xba/0x190 fs/select.c:241
> NMI backtrace for cpu 1
> CPU: 1 UID: 0 PID: 19905 Comm: modprobe Not tainted 6.12.0-rc4-syzkaller-00052-gc6d9e43954bf #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> RIP: 0010:io_serial_out+0x8f/0xb0 drivers/tty/serial/8250/8250_port.c:413
> Code: 48 8d 7d 40 44 89 e1 48 b8 00 00 00 00 00 fc ff df 48 89 fa d3 e3 48 c1 ea 03 80 3c 02 00 75 1c 66 03 5d 40 44 89 e8 89 da ee <5b> 5d 41 5c 41 5d c3 cc cc cc cc e8 31 f0 0d ff eb a0 e8 ba f0 0d
> RSP: 0018:ffffc900001b7f58 EFLAGS: 00000002
> RAX: 0000000000000034 RBX: 00000000000003f8 RCX: 0000000000000000
> RDX: 00000000000003f8 RSI: ffffffff82a08975 RDI: ffffffff93637660
> RBP: ffffffff93637620 R08: 0000000000000001 R09: 000000000000001f
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000034 R14: ffffffff82a08910 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff8881f5900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000200012b8 CR3: 000000011b4b4000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <NMI>
>  </NMI>
>  <IRQ>
>  serial_out drivers/tty/serial/8250/8250.h:142 [inline]
>  serial8250_console_fifo_write drivers/tty/serial/8250/8250_port.c:3322 [inline]
>  serial8250_console_write+0xf9e/0x17c0 drivers/tty/serial/8250/8250_port.c:3393
>  console_emit_next_record kernel/printk/printk.c:3092 [inline]
>  console_flush_all+0x800/0xc60 kernel/printk/printk.c:3180
>  __console_flush_and_unlock kernel/printk/printk.c:3239 [inline]
>  console_unlock+0xd9/0x210 kernel/printk/printk.c:3279
>  vprintk_emit+0x424/0x6f0 kernel/printk/printk.c:2407
>  vprintk+0x7f/0xa0 kernel/printk/printk_safe.c:68
>  _printk+0xc8/0x100 kernel/printk/printk.c:2432
>  printk_stack_address arch/x86/kernel/dumpstack.c:72 [inline]
>  show_trace_log_lvl+0x21f/0x3d0 arch/x86/kernel/dumpstack.c:285
>  sched_show_task kernel/sched/core.c:7604 [inline]
>  sched_show_task+0x3f0/0x5f0 kernel/sched/core.c:7579
>  show_state_filter+0xee/0x320 kernel/sched/core.c:7649
>  k_spec drivers/tty/vt/keyboard.c:667 [inline]
>  k_spec+0xed/0x150 drivers/tty/vt/keyboard.c:656
>  kbd_keycode drivers/tty/vt/keyboard.c:1522 [inline]
>  kbd_event+0xcbd/0x17a0 drivers/tty/vt/keyboard.c:1541
>  input_handler_events_default+0x116/0x1b0 drivers/input/input.c:2549
>  input_pass_values+0x777/0x8e0 drivers/input/input.c:126
>  input_event_dispose drivers/input/input.c:352 [inline]
>  input_handle_event+0xb30/0x14d0 drivers/input/input.c:369
>  input_event drivers/input/input.c:398 [inline]
>  input_event+0x83/0xa0 drivers/input/input.c:390
>  hidinput_hid_event+0xa12/0x2410 drivers/hid/hid-input.c:1719
>  hid_process_event+0x4b7/0x5e0 drivers/hid/hid-core.c:1540
>  hid_input_array_field+0x535/0x710 drivers/hid/hid-core.c:1652
>  hid_process_report drivers/hid/hid-core.c:1694 [inline]
>  hid_report_raw_event+0xa02/0x11c0 drivers/hid/hid-core.c:2040
>  __hid_input_report.constprop.0+0x341/0x440 drivers/hid/hid-core.c:2110
>  hid_irq_in+0x35e/0x870 drivers/hid/usbhid/hid-core.c:285
>  __usb_hcd_giveback_urb+0x389/0x6e0 drivers/usb/core/hcd.c:1650
>  usb_hcd_giveback_urb+0x396/0x450 drivers/usb/core/hcd.c:1734
>  dummy_timer+0x17f0/0x3930 drivers/usb/gadget/udc/dummy_hcd.c:1993
>  __run_hrtimer kernel/time/hrtimer.c:1691 [inline]
>  __hrtimer_run_queues+0x20a/0xae0 kernel/time/hrtimer.c:1755
>  hrtimer_run_softirq+0x17d/0x350 kernel/time/hrtimer.c:1772
>  handle_softirqs+0x206/0x8d0 kernel/softirq.c:554
>  __do_softirq kernel/softirq.c:588 [inline]
>  invoke_softirq kernel/softirq.c:428 [inline]
>  __irq_exit_rcu kernel/softirq.c:637 [inline]
>  irq_exit_rcu+0xac/0x110 kernel/softirq.c:649
>  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
>  sysvec_apic_timer_interrupt+0x90/0xb0 arch/x86/kernel/apic/apic.c:1049
>  </IRQ>
>  <TASK>
>  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
> RIP: 0010:ma_dead_node lib/maple_tree.c:561 [inline]
> RIP: 0010:mas_prev_node+0x197/0x10b0 lib/maple_tree.c:4476
> Code: 0f 84 58 ff ff ff bb 01 00 00 00 e8 23 0b 74 fa 89 d8 48 83 c4 38 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc e8 09 0b 74 fa <48> b8 00 00 00 00 00 fc ff df 48 89 ea 48 c1 ea 03 80 3c 02 00 0f
> RSP: 0018:ffffc900037e7628 EFLAGS: 00000293
> RAX: 0000000000000000 RBX: ffffc900037e7760 RCX: ffffffff86e1e691
> RDX: ffff88811adc57c0 RSI: ffffffff86e1e7b7 RDI: 0000000000000007
> RBP: ffff88811dd9e200 R08: 0000000000000007 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: ffffc900037e7778 R15: ffff88811dd9e400
>  mas_dfs_postorder lib/maple_tree.c:7089 [inline]
>  mt_validate+0x2203/0x41b0 lib/maple_tree.c:7607
>  validate_mm+0xae/0x4d0 mm/vma.c:534
>  vms_complete_munmap_vmas+0x62c/0x9a0 mm/vma.c:1159
>  mmap_region+0x4ce/0x2910 mm/mmap.c:1543
>  do_mmap+0xc00/0xfc0 mm/mmap.c:496
>  vm_mmap_pgoff+0x1ba/0x350 mm/util.c:588
>  ksys_mmap_pgoff+0x32c/0x5c0 mm/mmap.c:542
>  __do_sys_mmap arch/x86/kernel/sys_x86_64.c:86 [inline]
>  __se_sys_mmap arch/x86/kernel/sys_x86_64.c:79 [inline]
>  __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:79
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f551d6a0b74
> Code: 63 08 44 89 e8 5b 41 5c 41 5d c3 41 89 ca 41 f7 c1 ff 0f 00 00 74 0c c7 05 f5 46 01 00 16 00 00 00 eb 17 b8 09 00 00 00 0f 05 <48> 3d 00 f0 ff ff 76 0c f7 d8 89 05 dc 46 01 00 48 83 c8 ff c3 0f
> RSP: 002b:00007fffe534c9e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
> RAX: ffffffffffffffda RBX: 00007fffe534ca60 RCX: 00007f551d6a0b74
> RDX: 0000000000000001 RSI: 0000000000053000 RDI: 00007f551d554000
> RBP: 00007fffe534d180 R08: 0000000000000000 R09: 000000000014b000
> R10: 0000000000000812 R11: 0000000000000246 R12: 00007f551d67d5c0
> R13: 00007fffe534d208 R14: 000000000014ab8e R15: 0000000000000000
>  </TASK>
>  do_poll fs/select.c:964 [inline]
>  do_sys_poll+0xad5/0xde0 fs/select.c:1015
>  __do_sys_ppoll fs/select.c:1121 [inline]
>  __se_sys_ppoll fs/select.c:1101 [inline]
>  __x64_sys_ppoll+0x25a/0x2d0 fs/select.c:1101
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f0b86606ad5
> RSP: 002b:00007ffc505a9cb0 EFLAGS: 00000246 ORIG_RAX: 000000000000010f
> RAX: ffffffffffffffda RBX: 0000560d8c2afee0 RCX: 00007f0b86606ad5
> RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000560d8c2b8fe0
> RBP: 00007ffc505aa000 R08: 0000000000000008 R09: 0000560d5ee1d3d0
> R10: 00007ffc505aa000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000560d5ee1d610 R14: 0000000000000003 R15: 0000000000000000
>  </TASK>
> task:dhcpcd          state:S stack:26928 pid:2589  tgid:2589  ppid:2586   flags:0x00000002
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5328 [inline]
>  __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
>  __schedule_loop kernel/sched/core.c:6767 [inline]
>  schedule+0xe7/0x350 kernel/sched/core.c:6782
>  schedule_hrtimeout_range_clock+0x369/0x3b0 kernel/time/hrtimer.c:2272
>  poll_schedule_timeout.constprop.0+0xba/0x190 fs/select.c:241
>  do_poll fs/select.c:964 [inline]
>  do_sys_poll+0xad5/0xde0 fs/select.c:1015
>  __do_sys_ppoll fs/select.c:1121 [inline]
>  __se_sys_ppoll fs/select.c:1101 [inline]
>  __x64_sys_ppoll+0x25a/0x2d0 fs/select.c:1101
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f0b86606ad5
> RSP: 002b:00007ffc505a9cb0 EFLAGS: 00000246 ORIG_RAX: 000000000000010f
> RAX: ffffffffffffffda RBX: 0000560d8c2afee0 RCX: 00007f0b86606ad5
> RDX: 0000000000000000 RSI: 0000000000000005 RDI: 0000560d8c2b8fe0
> RBP: 00007ffc505aa000 R08: 0000000000000008 R09: 0000560d5ee1d3d0
> R10: 00007ffc505aa000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000560d5ee1d610 R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
> task:sshd            state:S stack:27504 pid:2605  tgid:2605  ppid:1      flags:0x00000002
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5328 [inline]
>  __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
>  __schedule_loop kernel/sched/core.c:6767 [inline]
>  schedule+0xe7/0x350 kernel/sched/core.c:6782
>  schedule_hrtimeout_range_clock+0x369/0x3b0 kernel/time/hrtimer.c:2272
>  poll_schedule_timeout.constprop.0+0xba/0x190 fs/select.c:241
>  do_poll fs/select.c:964 [inline]
>  do_sys_poll+0xad5/0xde0 fs/select.c:1015
>  __do_sys_ppoll fs/select.c:1121 [inline]
>  __se_sys_ppoll fs/select.c:1101 [inline]
>  __x64_sys_ppoll+0x25a/0x2d0 fs/select.c:1101
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f05620eaad5
> RSP: 002b:00007ffde59a6300 EFLAGS: 00000246 ORIG_RAX: 000000000000010f
> RAX: ffffffffffffffda RBX: 0000562e1fb6ea80 RCX: 00007f05620eaad5
> RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000562e1fb74900
> RBP: 0000000000000064 R08: 0000000000000008 R09: 0000000000000000
> R10: 00007ffde59a64b8 R11: 0000000000000246 R12: 0000562e1fb74900
> R13: 00007ffde59a64b8 R14: 0000000000000002 R15: 0000562e1fb748ec
>  </TASK>
> task:getty           state:S stack:25424 pid:2607  tgid:2607  ppid:1      flags:0x00000002
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5328 [inline]
>  __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
>  __schedule_loop kernel/sched/core.c:6767 [inline]
>  schedule+0xe7/0x350 kernel/sched/core.c:6782
>  schedule_timeout+0x258/0x2a0 kernel/time/timer.c:2591
>  wait_woken+0x175/0x1c0 kernel/sched/wait.c:423
>  n_tty_read+0x10fb/0x1480 drivers/tty/n_tty.c:2277
>  iterate_tty_read drivers/tty/tty_io.c:856 [inline]
>  tty_read+0x30e/0x5b0 drivers/tty/tty_io.c:931
>  new_sync_read fs/read_write.c:488 [inline]
>  vfs_read+0x86e/0xbd0 fs/read_write.c:569
>  ksys_read+0x12f/0x260 fs/read_write.c:712
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f6c70d89b6a
> RSP: 002b:00007ffc9581ce88 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> RAX: ffffffffffffffda RBX: 00005583c32fe2c0 RCX: 00007f6c70d89b6a
> RDX: 0000000000000001 RSI: 00007ffc9581cea0 RDI: 0000000000000000
> RBP: 00005583c32fe320 R08: 0000000000000000 R09: 9daa30ea851d932b
> R10: 0000000000000010 R11: 0000000000000246 R12: 00005583c32fe35c
> R13: 00007ffc9581cea0 R14: 0000000000000000 R15: 00005583c32fe35c
>  </TASK>
> task:dhcpcd          state:S stack:26368 pid:2609  tgid:2609  ppid:2587   flags:0x00000002
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5328 [inline]
>  __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
>  __schedule_loop kernel/sched/core.c:6767 [inline]
>  schedule+0xe7/0x350 kernel/sched/core.c:6782
>  schedule_hrtimeout_range_clock+0x369/0x3b0 kernel/time/hrtimer.c:2272
>  poll_schedule_timeout.constprop.0+0xba/0x190 fs/select.c:241
>  do_poll fs/select.c:964 [inline]
>  do_sys_poll+0xad5/0xde0 fs/select.c:1015
>  __do_sys_ppoll fs/select.c:1121 [inline]
>  __se_sys_ppoll fs/select.c:1101 [inline]
>  __x64_sys_ppoll+0x25a/0x2d0 fs/select.c:1101
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f0b86606ad5
> RSP: 002b:00007ffc505a9cb0 EFLAGS: 00000246 ORIG_RAX: 000000000000010f
> RAX: ffffffffffffffda RBX: 0000560d8c2afee0 RCX: 00007f0b86606ad5
> RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000560d8c2bad50
> RBP: 00007ffc505aa000 R08: 0000000000000008 R09: 0000000000000000
> R10: 00007ffc505aa000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000560d5ee1d610 R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
> task:sshd            state:S stack:25424 pid:2648  tgid:2648  ppid:2605   flags:0x00000002
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5328 [inline]
>  __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
>  __schedule_loop kernel/sched/core.c:6767 [inline]
>  schedule+0xe7/0x350 kernel/sched/core.c:6782
>  schedule_hrtimeout_range_clock+0x272/0x3b0 kernel/time/hrtimer.c:2281
>  poll_schedule_timeout.constprop.0+0xba/0x190 fs/select.c:241
>  do_poll fs/select.c:964 [inline]
>  do_sys_poll+0xad5/0xde0 fs/select.c:1015
>  __do_sys_ppoll fs/select.c:1121 [inline]
>  __se_sys_ppoll fs/select.c:1101 [inline]
>  __x64_sys_ppoll+0x25a/0x2d0 fs/select.c:1101
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fa545e84ad5
> RSP: 002b:00007fff2db4b070 EFLAGS: 00000246 ORIG_RAX: 000000000000010f
> RAX: ffffffffffffffda RBX: 00000000000668a0 RCX: 00007fa545e84ad5
> RDX: 00007fff2db4b090 RSI: 0000000000000004 RDI: 000055bf5a7a8b00
> RBP: 000055bf5a7a75c0 R08: 0000000000000008 R09: 0000000000000000
> R10: 00007fff2db4b178 R11: 0000000000000246 R12: 000055bf2267aaa4
> R13: 0000000000000001 R14: 000055bf2267b3e8 R15: 00007fff2db4b0f8
>  </TASK>
> task:syz-execprog    state:S stack:25424 pid:2650  tgid:2650  ppid:2648   flags:0x00000000
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5328 [inline]
>  __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
>  __schedule_loop kernel/sched/core.c:6767 [inline]
>  schedule+0xe7/0x350 kernel/sched/core.c:6782
>  do_wait+0x1dd/0x570 kernel/exit.c:1697
>  kernel_waitid+0x116/0x180 kernel/exit.c:1775
>  __do_sys_waitid+0x212/0x250 kernel/exit.c:1788
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x40708e
> RSP: 002b:000000c000079d60 EFLAGS: 00000212 ORIG_RAX: 00000000000000f7
> RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 000000000040708e
> RDX: 000000c000079e48 RSI: 0000000000000a5f RDI: 0000000000000001
> RBP: 000000c000079da0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000001000004 R11: 0000000000000212 R12: 000000c000079e90
> R13: 0000000000000000 R14: 000000c001fe1180 R15: 0000000000000001
>  </TASK>
> task:syz-execprog    state:S stack:27856 pid:2651  tgid:2650  ppid:2648   flags:0x00000000
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5328 [inline]
>  __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
>  __schedule_loop kernel/sched/core.c:6767 [inline]
>  schedule+0xe7/0x350 kernel/sched/core.c:6782
>  futex_wait_queue+0xfc/0x1f0 kernel/futex/waitwake.c:370
>  __futex_wait+0x291/0x3c0 kernel/futex/waitwake.c:669
>  futex_wait+0xe9/0x380 kernel/futex/waitwake.c:697
>  do_futex+0x22b/0x350 kernel/futex/syscalls.c:102
>  __do_sys_futex kernel/futex/syscalls.c:179 [inline]
>  __se_sys_futex kernel/futex/syscalls.c:160 [inline]
>  __x64_sys_futex+0x1e1/0x4c0 kernel/futex/syscalls.c:160
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x476343
> RSP: 002b:000000c000061e80 EFLAGS: 00000202 ORIG_RAX: 00000000000000ca
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000476343
> RDX: 0000000000000000 RSI: 0000000000000080 RDI: 0000000004038860
> RBP: 000000c000061ec8 R08: 0000000000000000 R09: 0000000000000000
> R10: 000000c000061eb8 R11: 0000000000000202 R12: 000000c000061eb8
> R13: 000000c00007e008 R14: 000000c000006540 R15: 0fffffffffffffff
>  </TASK>
> task:syz-execprog    state:S stack:27360 pid:2652  tgid:2650  ppid:2648   flags:0x00000000
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5328 [inline]
>  __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
>  __schedule_loop kernel/sched/core.c:6767 [inline]
>  schedule+0xe7/0x350 kernel/sched/core.c:6782
>  futex_wait_queue+0xfc/0x1f0 kernel/futex/waitwake.c:370
>  __futex_wait+0x291/0x3c0 kernel/futex/waitwake.c:669
>  futex_wait+0xe9/0x380 kernel/futex/waitwake.c:697
>  do_futex+0x22b/0x350 kernel/futex/syscalls.c:102
>  __do_sys_futex kernel/futex/syscalls.c:179 [inline]
>  __se_sys_futex kernel/futex/syscalls.c:160 [inline]
>  __x64_sys_futex+0x1e1/0x4c0 kernel/futex/syscalls.c:160
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x476343
> RSP: 002b:000000c00007b6e0 EFLAGS: 00000286 ORIG_RAX: 00000000000000ca
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000476343
> RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00000000040abfa0
> RBP: 000000c00007b728 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000286 R12: 00000000004725e0
> R13: 000000c001921808 R14: 000000c001fe1a40 R15: 00003fffffffffff
>  </TASK>
> task:syz-execprog    state:S stack:26816 pid:2653  tgid:2650  ppid:2648   flags:0x00000000
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5328 [inline]
>  __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
>  __schedule_loop kernel/sched/core.c:6767 [inline]
>  schedule+0xe7/0x350 kernel/sched/core.c:6782
>  futex_wait_queue+0xfc/0x1f0 kernel/futex/waitwake.c:370
>  __futex_wait+0x291/0x3c0 kernel/futex/waitwake.c:669
>  futex_wait+0xe9/0x380 kernel/futex/waitwake.c:697
>  do_futex+0x22b/0x350 kernel/futex/syscalls.c:102
>  __do_sys_futex kernel/futex/syscalls.c:179 [inline]
>  __se_sys_futex kernel/futex/syscalls.c:160 [inline]
>  __x64_sys_futex+0x1e1/0x4c0 kernel/futex/syscalls.c:160
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x476343
> RSP: 002b:000000c000093cf8 EFLAGS: 00000286 ORIG_RAX: 00000000000000ca
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000476343
> RDX: 0000000000000000 RSI: 0000000000000080 RDI: 000000c00007f148
> RBP: 000000c000093d40 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000286 R12: 000000c000066008
> R13: 0000000000000001 R14: 000000c000006c40 R15: 0000000000000001
>  </TASK>
> task:syz-execprog    state:S stack:26048 pid:2654  tgid:2650  ppid:2648   flags:0x00000000
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5328 [inline]
>  __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
>  __schedule_loop kernel/sched/core.c:6767 [inline]
>  schedule+0xe7/0x350 kernel/sched/core.c:6782
>  futex_wait_queue+0xfc/0x1f0 kernel/futex/waitwake.c:370
>  __futex_wait+0x291/0x3c0 kernel/futex/waitwake.c:669
>  futex_wait+0xe9/0x380 kernel/futex/waitwake.c:697
>  do_futex+0x22b/0x350 kernel/futex/syscalls.c:102
>  __do_sys_futex kernel/futex/syscalls.c:179 [inline]
>  __se_sys_futex kernel/futex/syscalls.c:160 [inline]
>  __x64_sys_futex+0x1e1/0x4c0 kernel/futex/syscalls.c:160
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x476343
> RSP: 002b:000000c0015dfe48 EFLAGS: 00000286 ORIG_RAX: 00000000000000ca
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000476343
> RDX: 0000000000000000 RSI: 0000000000000080 RDI: 000000c00057d948
> RBP: 000000c0015dfe90 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000286 R12: 0000000000448320
> R13: 000000c00007af94 R14: 000000c00189ea80 R15: 0000000000000007
>  </TASK>
> task:syz-execprog    state:S stack:30176 pid:2656  tgid:2650  ppid:2648   flags:0x00000000
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5328 [inline]
>  __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
>  __schedule_loop kernel/sched/core.c:6767 [inline]
>  schedule+0xe7/0x350 kernel/sched/core.c:6782
>  futex_wait_queue+0xfc/0x1f0 kernel/futex/waitwake.c:370
>  __futex_wait+0x291/0x3c0 kernel/futex/waitwake.c:669
>  futex_wait+0xe9/0x380 kernel/futex/waitwake.c:697
>  do_futex+0x22b/0x350 kernel/futex/syscalls.c:102
>  __do_sys_futex kernel/futex/syscalls.c:179 [inline]
>  __se_sys_futex kernel/futex/syscalls.c:160 [inline]
>  __x64_sys_futex+0x1e1/0x4c0 kernel/futex/syscalls.c:160
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x476343
> RSP: 002b:000000c0015e3ef0 EFLAGS: 00000286 ORIG_RAX: 00000000000000ca
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000476343
> RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00000000040abe18
> RBP: 000000c0015e3f38 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000286 R12: 00000000004725e0
> R13: 000000c00007f808 R14: 000000c001fe1880 R15: 0001ffffffffffff
>  </TASK>
> task:syz-execprog    state:S stack:26848 pid:2657  tgid:2650  ppid:2648   flags:0x00000000
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5328 [inline]
>  __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
>  __schedule_loop kernel/sched/core.c:6767 [inline]
>  schedule+0xe7/0x350 kernel/sched/core.c:6782
>  futex_wait_queue+0xfc/0x1f0 kernel/futex/waitwake.c:370
>  __futex_wait+0x291/0x3c0 kernel/futex/waitwake.c:669
>  futex_wait+0xe9/0x380 kernel/futex/waitwake.c:697
>  do_futex+0x22b/0x350 kernel/futex/syscalls.c:102
>  __do_sys_futex kernel/futex/syscalls.c:179 [inline]
>  __se_sys_futex kernel/futex/syscalls.c:160 [inline]
>  __x64_sys_futex+0x1e1/0x4c0 kernel/futex/syscalls.c:160
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x476343
> RSP: 002b:000000c0021e7cf8 EFLAGS: 00000286 ORIG_RAX: 00000000000000ca
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000476343
> RDX: 0000000000000000 RSI: 0000000000000080 RDI: 000000c001921948
> RBP: 000000c0021e7d40 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000286 R12: 0000000000000024
> R13: 0000000000000001 R14: 000000c001fe1dc0 R15: 0000000000000001
>  </TASK>
> task:syz-execprog    state:S stack:27440 pid:2658  tgid:2650  ppid:2648   flags:0x00000000
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5328 [inline]
>  __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
>  __schedule_loop kernel/sched/core.c:6767 [inline]
>  schedule+0xe7/0x350 kernel/sched/core.c:6782
>  futex_wait_queue+0xfc/0x1f0 kernel/futex/waitwake.c:370
>  __futex_wait+0x291/0x3c0 kernel/futex/waitwake.c:669
>  futex_wait+0xe9/0x380 kernel/futex/waitwake.c:697
>  do_futex+0x22b/0x350 kernel/futex/syscalls.c:102
>  __do_sys_futex kernel/futex/syscalls.c:179 [inline]
>  __se_sys_futex kernel/futex/syscalls.c:160 [inline]
>  __x64_sys_futex+0x1e1/0x4c0 kernel/futex/syscalls.c:160
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x476343
> RSP: 002b:000000c0021e3cf8 EFLAGS: 00000286 ORIG_RAX: 00000000000000ca
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000476343
> RDX: 0000000000000000 RSI: 0000000000000080 RDI: 000000c0028e6148
> RBP: 000000c0021e3d40 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000286 R12: 000000000000002f
> R13: 0000000000000001 R14: 000000c0028bd500 R15: 0000000000000001
>  </TASK>
> task:syz-execprog    state:S stack:27520 pid:14574 tgid:2650  ppid:2648   flags:0x00000000
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5328 [inline]
>  __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
>  __schedule_loop kernel/sched/core.c:6767 [inline]
>  schedule+0xe7/0x350 kernel/sched/core.c:6782
>  schedule_hrtimeout_range_clock+0x272/0x3b0 kernel/time/hrtimer.c:2281
>  ep_poll fs/eventpoll.c:2062 [inline]
>  do_epoll_wait+0x139b/0x1a90 fs/eventpoll.c:2459
>  do_compat_epoll_pwait.part.0+0x26/0x1d0 fs/eventpoll.c:2493
>  do_epoll_pwait fs/eventpoll.c:2500 [inline]
>  __do_sys_epoll_pwait fs/eventpoll.c:2506 [inline]
>  __se_sys_epoll_pwait fs/eventpoll.c:2500 [inline]
>  __x64_sys_epoll_pwait+0x20c/0x330 fs/eventpoll.c:2500
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x40708e
> RSP: 002b:000000c0014ad6d0 EFLAGS: 00000246 ORIG_RAX: 0000000000000119
> RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 000000000040708e
> RDX: 0000000000000080 RSI: 000000c0014ad774 RDI: 0000000000000004
> RBP: 000000c0014ad718 R08: 0000000000000000 R09: 0000000000000000
> R10: 00000000000003e7 R11: 0000000000000246 R12: 000000c0014ad7a8
> R13: 0000000000000001 R14: 000000c001dc6700 R15: 0000000000000001
>  </TASK>
> task:syz-executor    state:S stack:23472 pid:2655  tgid:2655  ppid:2654   flags:0x00000002
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5328 [inline]
>  __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
>  __schedule_loop kernel/sched/core.c:6767 [inline]
>  schedule+0xe7/0x350 kernel/sched/core.c:6782
>  schedule_hrtimeout_range_clock+0x272/0x3b0 kernel/time/hrtimer.c:2281
>  poll_schedule_timeout.constprop.0+0xba/0x190 fs/select.c:241
>  do_select+0x12ec/0x17b0 fs/select.c:604
>  core_sys_select+0x459/0xb80 fs/select.c:678
>  do_pselect.constprop.0+0x1a0/0x1f0 fs/select.c:760
>  __do_sys_pselect6 fs/select.c:803 [inline]
>  __se_sys_pselect6 fs/select.c:794 [inline]
>  __x64_sys_pselect6+0x183/0x240 fs/select.c:794
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f9c9998ddbc
> RSP: 002b:00007ffeade2b3a0 EFLAGS: 00000202 ORIG_RAX: 000000000000010e
> RAX: ffffffffffffffda RBX: 00007ffeade2b4d0 RCX: 00007f9c9998ddbc
> RDX: 0000000000000000 RSI: 00007ffeade2b4d0 RDI: 0000000000000025
> RBP: 00007ffeade2b900 R08: 00007ffeade2b3d0 R09: 00007ffeade2b3e0
> R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffeade2b750
> R13: 0000000000000000 R14: 585858582e7a7973 R15: 00007ffeade2b560
>  </TASK>
> task:kworker/u8:8    state:I stack:24304 pid:3821  tgid:3821  ppid:2      flags:0x00004000
> Workqueue:  0x0 (events_unbound)
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5328 [inline]
>  __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
>  __schedule_loop kernel/sched/core.c:6767 [inline]
>  schedule+0xe7/0x350 kernel/sched/core.c:6782
>  worker_thread+0x2de/0xf00 kernel/workqueue.c:3406
>  kthread+0x2c1/0x3a0 kernel/kthread.c:389
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
> task:kworker/0:3     state:I stack:28976 pid:5497  tgid:5497  ppid:2      flags:0x00004000
> Workqueue:  0x0 (events)
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5328 [inline]
>  __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
>  __schedule_loop kernel/sched/core.c:6767 [inline]
>  schedule+0xe7/0x350 kernel/sched/core.c:6782
>  worker_thread+0x2de/0xf00 kernel/workqueue.c:3406
>  kthread+0x2c1/0x3a0 kernel/kthread.c:389
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
> task:kworker/1:3     state:I stack:21728 pid:5499  tgid:5499  ppid:2      flags:0x00004000
> Workqueue:  0x0 (events)
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5328 [inline]
>  __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
>  __schedule_loop kernel/sched/core.c:6767 [inline]
>  schedule+0xe7/0x350 kernel/sched/core.c:6782
>  worker_thread+0x2de/0xf00 kernel/workqueue.c:3406
>  kthread+0x2c1/0x3a0 kernel/kthread.c:389
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
> task:kworker/1:4     state:I stack:22544 pid:5505  tgid:5505  ppid:2      flags:0x00004000
> Workqueue:  0x0 (events)
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5328 [inline]
>  __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
>  __schedule_loop kernel/sched/core.c:6767 [inline]
>  schedule+0xe7/0x350 kernel/sched/core.c:6782
>  worker_thread+0x2de/0xf00 kernel/workqueue.c:3406
>  kthread+0x2c1/0x3a0 kernel/kthread.c:389
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
> task:kworker/1:5     state:I stack:27232 pid:5508  tgid:5508  ppid:2      flags:0x00004000
> Workqueue:  0x0 (events)
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5328 [inline]
>  __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
>  __schedule_loop kernel/sched/core.c:6767 [inline]
>  schedule+0xe7/0x350 kernel/sched/core.c:6782
>  worker_thread+0x2de/0xf00 kernel/workqueue.c:3406
>  kthread+0x2c1/0x3a0 kernel/kthread.c:389
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
> task:kworker/0:4     state:D stack:23184 pid:10098 tgid:10098 ppid:2      flags:0x00004000
> Workqueue: usb_hub_wq hub_event
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5328 [inline]
>  __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
>  __schedule_loop kernel/sched/core.c:6767 [inline]
>  schedule+0xe7/0x350 kernel/sched/core.c:6782
>  schedule_timeout+0x258/0x2a0 kernel/time/timer.c:2591
>  ___down_common+0x2d7/0x460 kernel/locking/semaphore.c:225
>  __down_common kernel/locking/semaphore.c:246 [inline]
>  __down+0x20/0x30 kernel/locking/semaphore.c:254
>  down+0x74/0xa0 kernel/locking/semaphore.c:63
>  hid_device_remove+0x29/0x260 drivers/hid/hid-core.c:2749
>  device_remove+0xc8/0x170 drivers/base/dd.c:567
>  __device_release_driver drivers/base/dd.c:1273 [inline]
>  device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1296
>  bus_remove_device+0x22f/0x420 drivers/base/bus.c:576
>  device_del+0x396/0x9f0 drivers/base/core.c:3864
>  hid_remove_device drivers/hid/hid-core.c:2939 [inline]
>  hid_destroy_device+0xe5/0x150 drivers/hid/hid-core.c:2959
>  usbhid_disconnect+0xa0/0xe0 drivers/hid/usbhid/hid-core.c:1458
>  usb_unbind_interface+0x1e8/0x970 drivers/usb/core/driver.c:461
>  device_remove drivers/base/dd.c:569 [inline]
>  device_remove+0x122/0x170 drivers/base/dd.c:561
>  __device_release_driver drivers/base/dd.c:1273 [inline]
>  device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1296
>  bus_remove_device+0x22f/0x420 drivers/base/bus.c:576
>  device_del+0x396/0x9f0 drivers/base/core.c:3864
>  usb_disable_device+0x36c/0x7f0 drivers/usb/core/message.c:1418
>  usb_disconnect+0x2e1/0x920 drivers/usb/core/hub.c:2304
>  hub_port_connect drivers/usb/core/hub.c:5361 [inline]
>  hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
>  port_event drivers/usb/core/hub.c:5821 [inline]
>  hub_event+0x1bed/0x4f40 drivers/usb/core/hub.c:5903
>  process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
>  process_scheduled_works kernel/workqueue.c:3310 [inline]
>  worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
>  kthread+0x2c1/0x3a0 kernel/kthread.c:389
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
> task:syz-executor    state:D stack:23840 pid:18831 tgid:18831 ppid:1      flags:0x00004006
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5328 [inline]
>  __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
>  __schedule_loop kernel/sched/core.c:6767 [inline]
>  schedule+0xe7/0x350 kernel/sched/core.c:6782
>  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6839
>  __mutex_lock_common kernel/locking/mutex.c:684 [inline]
>  __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
>  exp_funnel_lock+0x1a4/0x3b0 kernel/rcu/tree_exp.h:329
>  synchronize_rcu_expedited+0x290/0x450 kernel/rcu/tree_exp.h:976
>  namespace_unlock+0x1b5/0x490 fs/namespace.c:1703
>  drop_collected_mounts fs/namespace.c:2225 [inline]
>  put_mnt_ns fs/namespace.c:5553 [inline]
>  put_mnt_ns+0xf4/0x130 fs/namespace.c:5549
>  free_nsproxy+0x47/0x470 kernel/nsproxy.c:193
>  put_nsproxy include/linux/nsproxy.h:118 [inline]
>  switch_task_namespaces+0xeb/0x100 kernel/nsproxy.c:251
>  do_exit+0xad8/0x2ce0 kernel/exit.c:938
>  do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
>  get_signal+0x25fb/0x2770 kernel/signal.c:2917
>  arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:337
>  exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
>  exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>  syscall_exit_to_user_mode+0x147/0x260 kernel/entry/common.c:218
>  do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f054e954213
> RSP: 002b:00007ffd383c1948 EFLAGS: 00000202 ORIG_RAX: 000000000000003d
> RAX: fffffffffffffe00 RBX: 0000000000000004 RCX: 00007f054e954213
> RDX: 0000000040000000 RSI: 00007ffd383c197c RDI: 00000000ffffffff
> RBP: 00007ffd383c197c R08: 000000000000f84a R09: 00007f054f64f080
> R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
> R13: 0000000000000000 R14: 00000000000676e9 R15: 00007ffd383c19d0
>  </TASK>
> task:syz-executor    state:S stack:26144 pid:19691 tgid:19691 ppid:2655   flags:0x00000000
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5328 [inline]
>  __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
>  __schedule_loop kernel/sched/core.c:6767 [inline]
>  schedule+0xe7/0x350 kernel/sched/core.c:6782
>  do_wait+0x1dd/0x570 kernel/exit.c:1697
>  kernel_wait4+0x16c/0x280 kernel/exit.c:1851
>  __do_sys_wait4+0x15f/0x170 kernel/exit.c:1879
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f8158d54213
> RSP: 002b:00007ffd5db7dc78 EFLAGS: 00000202 ORIG_RAX: 000000000000003d
> RAX: ffffffffffffffda RBX: 0000000000004cec RCX: 00007f8158d54213
> RDX: 0000000040000000 RSI: 00007ffd5db7dc8c RDI: 00000000ffffffff
> RBP: 00007ffd5db7dc8c R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffd5db7dd10
> R13: 00007ffd5db7dd18 R14: 0000000000000009 R15: 0000000000000000
>  </TASK>
> task:syz-executor    state:D stack:23520 pid:19692 tgid:19692 ppid:19691  flags:0x00000000
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5328 [inline]
>  __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
>  __schedule_loop kernel/sched/core.c:6767 [inline]
>  schedule+0xe7/0x350 kernel/sched/core.c:6782
>  io_schedule+0xbf/0x130 kernel/sched/core.c:7574
>  bit_wait_io+0x15/0xe0 kernel/sched/wait_bit.c:209
>  __wait_on_bit+0x62/0x180 kernel/sched/wait_bit.c:49
>  out_of_line_wait_on_bit+0xda/0x110 kernel/sched/wait_bit.c:64
>  wait_on_bit_io include/linux/wait_bit.h:101 [inline]
>  do_get_write_access+0x933/0x1270 fs/jbd2/transaction.c:1096
>  jbd2_journal_get_write_access+0x1d6/0x280 fs/jbd2/transaction.c:1245
>  __ext4_journal_get_write_access+0x6a/0x390 fs/ext4/ext4_jbd2.c:239
>  __ext4_new_inode+0xda1/0x4ec0 fs/ext4/ialloc.c:1088
>  ext4_mkdir+0x283/0xb70 fs/ext4/namei.c:3017
>  vfs_mkdir+0x57d/0x860 fs/namei.c:4257
>  do_mkdirat+0x1b1/0x390 fs/namei.c:4280
>  __do_sys_mkdirat fs/namei.c:4295 [inline]
>  __se_sys_mkdirat fs/namei.c:4293 [inline]
>  __x64_sys_mkdirat+0x83/0xb0 fs/namei.c:4293
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f8158d5c897
> RSP: 002b:00007ffd5db7dc78 EFLAGS: 00000202 ORIG_RAX: 0000000000000102
> RAX: ffffffffffffffda RBX: 00007f8158dd0685 RCX: 00007f8158d5c897
> RDX: 00000000000001ff RSI: 00007f8158dd0685 RDI: 00000000ffffff9c
> RBP: 00007ffd5db7dd10 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffd5db7dd10
> R13: 00007ffd5db7dd18 R14: 0000000000000009 R15: 0000000000000000
>  </TASK>
> task:syz-executor    state:S stack:26144 pid:19695 tgid:19695 ppid:2655   flags:0x00000000
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5328 [inline]
>  __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
>  __schedule_loop kernel/sched/core.c:6767 [inline]
>  schedule+0xe7/0x350 kernel/sched/core.c:6782
>  do_wait+0x1dd/0x570 kernel/exit.c:1697
>  kernel_wait4+0x16c/0x280 kernel/exit.c:1851
>  __do_sys_wait4+0x15f/0x170 kernel/exit.c:1879
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f4a822c4213
> RSP: 002b:00007fff9e1542b8 EFLAGS: 00000202 ORIG_RAX: 000000000000003d
> RAX: ffffffffffffffda RBX: 0000000000004cf5 RCX: 00007f4a822c4213
> RDX: 0000000040000000 RSI: 00007fff9e1542cc RDI: 00000000ffffffff
> RBP: 00007fff9e1542cc R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000202 R12: 00007fff9e154350
> R13: 00007fff9e154358 R14: 0000000000000009 R15: 0000000000000000
>  </TASK>
> task:syz-executor    state:D stack:26784 pid:19701 tgid:19701 ppid:19695  flags:0x00000000
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5328 [inline]
>  __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
>  __schedule_loop kernel/sched/core.c:6767 [inline]
>  schedule+0xe7/0x350 kernel/sched/core.c:6782
>  schedule_timeout+0x258/0x2a0 kernel/time/timer.c:2591
>  do_wait_for_common kernel/sched/completion.c:95 [inline]
>  __wait_for_common+0x3e1/0x600 kernel/sched/completion.c:116
>  wait_for_common kernel/sched/completion.c:127 [inline]
>  wait_for_completion_state+0x1c/0x40 kernel/sched/completion.c:264
>  call_usermodehelper_exec+0x3c4/0x4d0 kernel/umh.c:442
>  call_modprobe kernel/module/kmod.c:103 [inline]
>  __request_module+0x3f6/0x6c0 kernel/module/kmod.c:173
>  __rtnl_newlink+0x64c/0x1920 net/core/rtnetlink.c:3748
>  rtnl_newlink+0x67/0xa0 net/core/rtnetlink.c:3772
>  rtnetlink_rcv_msg+0x3c7/0xea0 net/core/rtnetlink.c:6675
>  netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2551
>  netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
>  netlink_unicast+0x53c/0x7f0 net/netlink/af_netlink.c:1357
>  netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1901
>  sock_sendmsg_nosec net/socket.c:729 [inline]
>  __sock_sendmsg net/socket.c:744 [inline]
>  __sys_sendto+0x479/0x4d0 net/socket.c:2214
>  __do_sys_sendto net/socket.c:2226 [inline]
>  __se_sys_sendto net/socket.c:2222 [inline]
>  __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2222
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f4a822cfe33
> RSP: 002b:00007fff9e1539c8 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
> RAX: ffffffffffffffda RBX: 00007f4a82fb4620 RCX: 00007f4a822cfe33
> RDX: 0000000000000068 RSI: 00007f4a82fb4670 RDI: 0000000000000003
> RBP: 0000000000000001 R08: 00007fff9e1539e4 R09: 000000000000000c
> R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000003
> R13: 0000000000000000 R14: 00007f4a82fb4670 R15: 0000000000000000
>  </TASK>
> task:syz-executor    state:S stack:26144 pid:19703 tgid:19703 ppid:2655   flags:0x00000000
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5328 [inline]
>  __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
>  __schedule_loop kernel/sched/core.c:6767 [inline]
>  schedule+0xe7/0x350 kernel/sched/core.c:6782
>  do_wait+0x1dd/0x570 kernel/exit.c:1697
>  kernel_wait4+0x16c/0x280 kernel/exit.c:1851
>  __do_sys_wait4+0x15f/0x170 kernel/exit.c:1879
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fde24274213
> RSP: 002b:00007ffe2cb21668 EFLAGS: 00000202 ORIG_RAX: 000000000000003d
> RAX: ffffffffffffffda RBX: 0000000000004cfa RCX: 00007fde24274213
> RDX: 0000000040000000 RSI: 00007ffe2cb2167c RDI: 00000000ffffffff
> RBP: 00007ffe2cb2167c R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffe2cb21700
> R13: 00007ffe2cb21708 R14: 0000000000000009 R15: 0000000000000000
>  </TASK>
> task:syz-executor    state:S stack:26144 pid:19705 tgid:19705 ppid:2655   flags:0x00000000
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5328 [inline]
>  __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
>  __schedule_loop kernel/sched/core.c:6767 [inline]
>  schedule+0xe7/0x350 kernel/sched/core.c:6782
>  do_wait+0x1dd/0x570 kernel/exit.c:1697
>  kernel_wait4+0x16c/0x280 kernel/exit.c:1851
>  __do_sys_wait4+0x15f/0x170 kernel/exit.c:1879
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f0d48944213
> RSP: 002b:00007ffe7efd71e8 EFLAGS: 00000202 ORIG_RAX: 000000000000003d
> RAX: ffffffffffffffda RBX: 0000000000004cfd RCX: 00007f0d48944213
> RDX: 0000000040000000 RSI: 00007ffe7efd71fc RDI: 00000000ffffffff
> RBP: 00007ffe7efd71fc R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffe7efd7280
> R13: 00007ffe7efd7288 R14: 0000000000000009 R15: 0000000000000000
>  </TASK>
> task:syz-executor    state:D stack:22832 pid:19706 tgid:19706 ppid:19703  flags:0x00000000
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5328 [inline]
>  __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
>  __schedule_loop kernel/sched/core.c:6767 [inline]
>  schedule+0xe7/0x350 kernel/sched/core.c:6782
>  io_schedule+0xbf/0x130 kernel/sched/core.c:7574
>  bit_wait_io+0x15/0xe0 kernel/sched/wait_bit.c:209
>  __wait_on_bit+0x62/0x180 kernel/sched/wait_bit.c:49
>  out_of_line_wait_on_bit+0xda/0x110 kernel/sched/wait_bit.c:64
>  wait_on_bit_io include/linux/wait_bit.h:101 [inline]
>  do_get_write_access+0x933/0x1270 fs/jbd2/transaction.c:1096
>  jbd2_journal_get_write_access+0x1d6/0x280 fs/jbd2/transaction.c:1245
>  __ext4_journal_get_write_access+0x6a/0x390 fs/ext4/ext4_jbd2.c:239
>  __ext4_new_inode+0xda1/0x4ec0 fs/ext4/ialloc.c:1088
>  ext4_mkdir+0x283/0xb70 fs/ext4/namei.c:3017
>  vfs_mkdir+0x57d/0x860 fs/namei.c:4257
>  do_mkdirat+0x1b1/0x390 fs/namei.c:4280
>  __do_sys_mkdirat fs/namei.c:4295 [inline]
>  __se_sys_mkdirat fs/namei.c:4293 [inline]
>  __x64_sys_mkdirat+0x83/0xb0 fs/namei.c:4293
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fde2427c897
> RSP: 002b:00007ffe2cb21668 EFLAGS: 00000206 ORIG_RAX: 0000000000000102
> RAX: ffffffffffffffda RBX: 00007fde242f0685 RCX: 00007fde2427c897
> RDX: 00000000000001ff RSI: 00007fde242f0685 RDI: 00000000ffffff9c
> RBP: 00007ffe2cb21700 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000206 R12: 00007ffe2cb21700
> R13: 00007ffe2cb21708 R14: 0000000000000009 R15: 0000000000000000
>  </TASK>
> task:syz-executor    state:D stack:24784 pid:19709 tgid:19709 ppid:19705  flags:0x00000000
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5328 [inline]
>  __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
>  __schedule_loop kernel/sched/core.c:6767 [inline]
>  schedule+0xe7/0x350 kernel/sched/core.c:6782
>  io_schedule+0xbf/0x130 kernel/sched/core.c:7574
>  bit_wait_io+0x15/0xe0 kernel/sched/wait_bit.c:209
>  __wait_on_bit+0x62/0x180 kernel/sched/wait_bit.c:49
>  out_of_line_wait_on_bit+0xda/0x110 kernel/sched/wait_bit.c:64
>  wait_on_bit_io include/linux/wait_bit.h:101 [inline]
>  do_get_write_access+0x933/0x1270 fs/jbd2/transaction.c:1096
>  jbd2_journal_get_write_access+0x1d6/0x280 fs/jbd2/transaction.c:1245
>  __ext4_journal_get_write_access+0x6a/0x390 fs/ext4/ext4_jbd2.c:239
>  __ext4_new_inode+0xda1/0x4ec0 fs/ext4/ialloc.c:1088
>  ext4_mkdir+0x283/0xb70 fs/ext4/namei.c:3017
>  vfs_mkdir+0x57d/0x860 fs/namei.c:4257
>  do_mkdirat+0x1b1/0x390 fs/namei.c:4280
>  __do_sys_mkdirat fs/namei.c:4295 [inline]
>  __se_sys_mkdirat fs/namei.c:4293 [inline]
>  __x64_sys_mkdirat+0x83/0xb0 fs/namei.c:4293
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f0d4894c897
> RSP: 002b:00007ffe7efd71e8 EFLAGS: 00000202 ORIG_RAX: 0000000000000102
> RAX: ffffffffffffffda RBX: 00007f0d489c0685 RCX: 00007f0d4894c897
> RDX: 00000000000001ff RSI: 00007f0d489c0685 RDI: 00000000ffffff9c
> RBP: 00007ffe7efd7280 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffe7efd7280
> R13: 00007ffe7efd7288 R14: 0000000000000009 R15: 0000000000000000
>  </TASK>
> task:syz.3.53        state:D stack:27856 pid:19844 tgid:19844 ppid:18831  flags:0x00004006
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5328 [inline]
>  __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
>  __schedule_loop kernel/sched/core.c:6767 [inline]
>  schedule+0xe7/0x350 kernel/sched/core.c:6782
>  synchronize_rcu_expedited+0x392/0x450 kernel/rcu/tree_exp.h:991
>  module_remove_driver+0x2e/0x260 drivers/base/module.c:106
>  bus_remove_driver+0x143/0x2c0 drivers/base/bus.c:745
>  driver_unregister+0x76/0xb0 drivers/base/driver.c:274
>  usb_gadget_unregister_driver+0x49/0x70 drivers/usb/gadget/udc/core.c:1732
>  raw_release+0x1ae/0x2b0 drivers/usb/gadget/legacy/raw_gadget.c:462
>  __fput+0x3f6/0xb60 fs/file_table.c:431
>  task_work_run+0x14e/0x250 kernel/task_work.c:239
>  exit_task_work include/linux/task_work.h:43 [inline]
>  do_exit+0xadd/0x2ce0 kernel/exit.c:939
>  do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
>  get_signal+0x25fb/0x2770 kernel/signal.c:2917
>  arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:337
>  exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
>  exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>  syscall_exit_to_user_mode+0x147/0x260 kernel/entry/common.c:218
>  do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f054e95dff9
> RSP: 002b:00007ffd383c1718 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
> RAX: fffffffffffffdfc RBX: 00007ffd383c1840 RCX: 00007f054e95dff9
> RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f054eb15f8c
> RBP: 00007f054eb15f8c R08: 00007f054f64f080 R09: 00007ffd383c1a0f
> R10: 00007ffd383c1820 R11: 0000000000000246 R12: 0000000000067cb1
> R13: 00007ffd383c1820 R14: 000000000000015e R15: 0000000000067b53
>  </TASK>
> task:modprobe        state:R  running task     stack:25424 pid:19905 tgid:19905 ppid:50     flags:0x0000400a
> Call Trace:
>  <IRQ>
>  sched_show_task kernel/sched/core.c:7604 [inline]
>  sched_show_task+0x3f0/0x5f0 kernel/sched/core.c:7579
>  show_state_filter+0xee/0x320 kernel/sched/core.c:7649
>  k_spec drivers/tty/vt/keyboard.c:667 [inline]
>  k_spec+0xed/0x150 drivers/tty/vt/keyboard.c:656
>  kbd_keycode drivers/tty/vt/keyboard.c:1522 [inline]
>  kbd_event+0xcbd/0x17a0 drivers/tty/vt/keyboard.c:1541
>  input_handler_events_default+0x116/0x1b0 drivers/input/input.c:2549
>  input_pass_values+0x777/0x8e0 drivers/input/input.c:126
>  input_event_dispose drivers/input/input.c:352 [inline]
>  input_handle_event+0xb30/0x14d0 drivers/input/input.c:369
>  input_event drivers/input/input.c:398 [inline]
>  input_event+0x83/0xa0 drivers/input/input.c:390
>  hidinput_hid_event+0xa12/0x2410 drivers/hid/hid-input.c:1719
>  hid_process_event+0x4b7/0x5e0 drivers/hid/hid-core.c:1540
>  hid_input_array_field+0x535/0x710 drivers/hid/hid-core.c:1652
>  hid_process_report drivers/hid/hid-core.c:1694 [inline]
>  hid_report_raw_event+0xa02/0x11c0 drivers/hid/hid-core.c:2040
>  __hid_input_report.constprop.0+0x341/0x440 drivers/hid/hid-core.c:2110
>  hid_irq_in+0x35e/0x870 drivers/hid/usbhid/hid-core.c:285
>  __usb_hcd_giveback_urb+0x389/0x6e0 drivers/usb/core/hcd.c:1650
>  usb_hcd_giveback_urb+0x396/0x450 drivers/usb/core/hcd.c:1734
>  dummy_timer+0x17f0/0x3930 drivers/usb/gadget/udc/dummy_hcd.c:1993
>  __run_hrtimer kernel/time/hrtimer.c:1691 [inline]
>  __hrtimer_run_queues+0x20a/0xae0 kernel/time/hrtimer.c:1755
>  hrtimer_run_softirq+0x17d/0x350 kernel/time/hrtimer.c:1772
>  handle_softirqs+0x206/0x8d0 kernel/softirq.c:554
>  __do_softirq kernel/softirq.c:588 [inline]
>  invoke_softirq kernel/softirq.c:428 [inline]
>  __irq_exit_rcu kernel/softirq.c:637 [inline]
>  irq_exit_rcu+0xac/0x110 kernel/softirq.c:649
>  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
>  sysvec_apic_timer_interrupt+0x90/0xb0 arch/x86/kernel/apic/apic.c:1049
>  </IRQ>
>  <TASK>
>  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
> RIP: 0010:ma_dead_node lib/maple_tree.c:561 [inline]
> RIP: 0010:mas_prev_node+0x197/0x10b0 lib/maple_tree.c:4476
> Code: 0f 84 58 ff ff ff bb 01 00 00 00 e8 23 0b 74 fa 89 d8 48 83 c4 38 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc e8 09 0b 74 fa <48> b8 00 00 00 00 00 fc ff df 48 89 ea 48 c1 ea 03 80 3c 02 00 0f
> RSP: 0018:ffffc900037e7628 EFLAGS: 00000293
> RAX: 0000000000000000 RBX: ffffc900037e7760 RCX: ffffffff86e1e691
> RDX: ffff88811adc57c0 RSI: ffffffff86e1e7b7 RDI: 0000000000000007
> RBP: ffff88811dd9e200 R08: 0000000000000007 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: ffffc900037e7778 R15: ffff88811dd9e400
>  mas_dfs_postorder lib/maple_tree.c:7089 [inline]
>  mt_validate+0x2203/0x41b0 lib/maple_tree.c:7607
>  validate_mm+0xae/0x4d0 mm/vma.c:534
>  vms_complete_munmap_vmas+0x62c/0x9a0 mm/vma.c:1159
>  mmap_region+0x4ce/0x2910 mm/mmap.c:1543
>  do_mmap+0xc00/0xfc0 mm/mmap.c:496
>  vm_mmap_pgoff+0x1ba/0x350 mm/util.c:588
>  ksys_mmap_pgoff+0x32c/0x5c0 mm/mmap.c:542
>  __do_sys_mmap arch/x86/kernel/sys_x86_64.c:86 [inline]
>  __se_sys_mmap arch/x86/kernel/sys_x86_64.c:79 [inline]
>  __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:79
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f551d6a0b74
> Code: 63 08 44 89 e8 5b 41 5c 41 5d c3 41 89 ca 41 f7 c1 ff 0f 00 00 74 0c c7 05 f5 46 01 00 16 00 00 00 eb 17 b8 09 00 00 00 0f 05 <48> 3d 00 f0 ff ff 76 0c f7 d8 89 05 dc 46 01 00 48 83 c8 ff c3 0f
> RSP: 002b:00007fffe534c9e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
> RAX: ffffffffffffffda RBX: 00007fffe534ca60 RCX: 00007f551d6a0b74
> RDX: 0000000000000001 RSI: 0000000000053000 RDI: 00007f551d554000
> RBP: 00007fffe534d180 R08: 0000000000000000 R09: 000000000014b000
> R10: 0000000000000812 R11: 0000000000000246 R12: 00007f551d67d5c0
> R13: 00007fffe534d208 R14: 000000000014ab8e R15: 0000000000000000
>  </TASK>
> task:syz-executor    state:D stack:26144 pid:20285 tgid:20285 ppid:2655   flags:0x00000000
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5328 [inline]
>  __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
>  __schedule_loop kernel/sched/core.c:6767 [inline]
>  schedule+0xe7/0x350 kernel/sched/core.c:6782
>  io_schedule+0xbf/0x130 kernel/sched/core.c:7574
>  bit_wait_io+0x15/0xe0 kernel/sched/wait_bit.c:209
>  __wait_on_bit+0x62/0x180 kernel/sched/wait_bit.c:49
>  out_of_line_wait_on_bit+0xda/0x110 kernel/sched/wait_bit.c:64
>  wait_on_bit_io include/linux/wait_bit.h:101 [inline]
>  do_get_write_access+0x933/0x1270 fs/jbd2/transaction.c:1096
>  jbd2_journal_get_write_access+0x1d6/0x280 fs/jbd2/transaction.c:1245
>  __ext4_journal_get_write_access+0x6a/0x390 fs/ext4/ext4_jbd2.c:239
>  ext4_reserve_inode_write+0x13b/0x270 fs/ext4/inode.c:5773
>  __ext4_mark_inode_dirty+0x1a6/0x890 fs/ext4/inode.c:5947
>  ext4_dirty_inode+0xd9/0x130 fs/ext4/inode.c:5984
>  __mark_inode_dirty+0x1f6/0xe60 fs/fs-writeback.c:2493
>  mark_inode_dirty include/linux/fs.h:2474 [inline]
>  ext4_setattr+0x33e/0x26e0 fs/ext4/inode.c:5508
>  notify_change+0x6a6/0x1230 fs/attr.c:503
>  chmod_common+0x1f6/0x450 fs/open.c:653
>  do_fchmodat fs/open.c:701 [inline]
>  __do_sys_chmod fs/open.c:725 [inline]
>  __se_sys_chmod fs/open.c:723 [inline]
>  __x64_sys_chmod+0x108/0x1c0 fs/open.c:723
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f97877ec837
> RSP: 002b:00007ffc4f4c0eb8 EFLAGS: 00000202 ORIG_RAX: 000000000000005a
> RAX: ffffffffffffffda RBX: 00007ffc4f4c0f20 RCX: 00007f97877ec837
> RDX: 0000000000000000 RSI: 00000000000001ff RDI: 00007ffc4f4c0f20
> RBP: 0000000000000002 R08: 0000000000000004 R09: 0000000000000001
> R10: 0000000000000001 R11: 0000000000000202 R12: 00007ffc4f4c0f20
> R13: 00007ffc4f4c0f28 R14: 0000000000000009 R15: 0000000000000000
>  </TASK>
>
> Showing all locks held in the system:
> 2 locks held by kworker/u8:4/50:
>  #0: ffff888100089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
>  #1: ffffc90000527d80 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
> 2 locks held by getty/2607:
>  #0: ffff88810ff760a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
>  #1: ffffc900000432f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfba/0x1480 drivers/tty/n_tty.c:2211
> 6 locks held by kworker/0:4/10098:
>  #0: ffff888105ef6d48 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
>  #1: ffffc9000209fd80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
>  #2: ffff888109b12190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
>  #2: ffff888109b12190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1be/0x4f40 drivers/usb/core/hub.c:5849
>  #3: ffff88811366e190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
>  #3: ffff88811366e190 (&dev->mutex){....}-{3:3}, at: usb_disconnect+0x10a/0x920 drivers/usb/core/hub.c:2295
>  #4: ffff8881052c8160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
>  #4: ffff8881052c8160 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1095 [inline]
>  #4: ffff8881052c8160 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xa4/0x610 drivers/base/dd.c:1293
>  #5: ffff88812f6f9a20 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
>  #5: ffff88812f6f9a20 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1095 [inline]
>  #5: ffff88812f6f9a20 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xa4/0x610 drivers/base/dd.c:1293
> 1 lock held by syz-executor/18831:
>  #0: ffffffff88ec6a38 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock+0x1a4/0x3b0 kernel/rcu/tree_exp.h:329
> 3 locks held by syz-executor/19692:
>  #0: ffff8881144343f8 (sb_writers#5){.+.+}-{0:0}, at: filename_create+0x10d/0x530 fs/namei.c:4019
>  #1: ffff888118dd03f8 (&type->i_mutex_dir_key#3/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:850 [inline]
>  #1: ffff888118dd03f8 (&type->i_mutex_dir_key#3/1){+.+.}-{3:3}, at: filename_create+0x1c2/0x530 fs/namei.c:4026
>  #2: ffff888114480958 (jbd2_handle){++++}-{0:0}, at: start_this_handle+0xf6c/0x1430 fs/jbd2/transaction.c:448
> 3 locks held by syz-executor/19706:
>  #0: ffff8881144343f8 (sb_writers#5){.+.+}-{0:0}, at: filename_create+0x10d/0x530 fs/namei.c:4019
>  #1: ffff888118dd1798 (&type->i_mutex_dir_key#3/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:850 [inline]
>  #1: ffff888118dd1798 (&type->i_mutex_dir_key#3/1){+.+.}-{3:3}, at: filename_create+0x1c2/0x530 fs/namei.c:4026
>  #2: ffff888114480958 (jbd2_handle){++++}-{0:0}, at: start_this_handle+0xf6c/0x1430 fs/jbd2/transaction.c:448
> 3 locks held by syz-executor/19709:
>  #0: ffff8881144343f8 (sb_writers#5){.+.+}-{0:0}, at: filename_create+0x10d/0x530 fs/namei.c:4019
>  #1: ffff888118dd2168 (&type->i_mutex_dir_key#3/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:850 [inline]
>  #1: ffff888118dd2168 (&type->i_mutex_dir_key#3/1){+.+.}-{3:3}, at: filename_create+0x1c2/0x530 fs/namei.c:4026
>  #2: ffff888114480958 (jbd2_handle){++++}-{0:0}, at: start_this_handle+0xf6c/0x1430 fs/jbd2/transaction.c:448
> 1 lock held by syz.3.53/19844:
>  #0: ffffffff88ec6a38 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock+0x282/0x3b0 kernel/rcu/tree_exp.h:297
> 5 locks held by modprobe/19905:
>  #0: ffff88812f699d58 (&mm->mmap_lock){++++}-{3:3}, at: mmap_write_lock_killable include/linux/mmap_lock.h:122 [inline]
>  #0: ffff88812f699d58 (&mm->mmap_lock){++++}-{3:3}, at: vm_mmap_pgoff+0x160/0x350 mm/util.c:586
>  #1: ffff8881056b9230 (&dev->event_lock){..-.}-{2:2}, at: input_event drivers/input/input.c:397 [inline]
>  #1: ffff8881056b9230 (&dev->event_lock){..-.}-{2:2}, at: input_event+0x70/0xa0 drivers/input/input.c:390
>  #2: ffffffff88ebb140 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
>  #2: ffffffff88ebb140 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
>  #2: ffffffff88ebb140 (rcu_read_lock){....}-{1:2}, at: input_pass_values+0x8b/0x8e0 drivers/input/input.c:118
>  #3: ffffffff89387a58 (kbd_event_lock){..-.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
>  #3: ffffffff89387a58 (kbd_event_lock){..-.}-{2:2}, at: kbd_event+0x8a/0x17a0 drivers/tty/vt/keyboard.c:1535
>  #4: ffffffff88ebb140 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
>  #4: ffffffff88ebb140 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
>  #4: ffffffff88ebb140 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x7f/0x390 kernel/locking/lockdep.c:6720
> 3 locks held by syz-executor/20285:
>  #0: ffff8881144343f8 (sb_writers#5){.+.+}-{0:0}, at: chmod_common+0x106/0x450 fs/open.c:643
>  #1: ffff888118dd2b38 (&type->i_mutex_dir_key#3){++++}-{3:3}, at: inode_lock include/linux/fs.h:815 [inline]
>  #1: ffff888118dd2b38 (&type->i_mutex_dir_key#3){++++}-{3:3}, at: chmod_common+0x171/0x450 fs/open.c:647
>  #2: ffff888114480958 (jbd2_handle){++++}-{0:0}, at: start_this_handle+0xf6c/0x1430 fs/jbd2/transaction.c:448
>
> =============================================
>
> keytouch 0003:0926:3333.0013: can't resubmit intr, dummy_hcd.3-1/input0, status -19
> keytouch 0003:0926:3333.0013: usb_submit_urb(ctrl) failed: -19
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

