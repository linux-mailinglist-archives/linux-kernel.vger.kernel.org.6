Return-Path: <linux-kernel+bounces-364995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E12B99DC08
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 04:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DA541F23314
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 02:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058B115ADAF;
	Tue, 15 Oct 2024 02:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JgCASOnk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CDXxQPkN"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE7913D291
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 02:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728957848; cv=fail; b=h3mRvw1ffJLkZi/U8uRbwyGe5Iqh/xulvugqtaHJzOAVGVZtmRoLiQz7MR3I3lcy+nUm9/dzyEpcIgDczUxMT8YYVoEA54r7JxIW9+7EtY60/+rO/uLkFMIPPfpfXXYhgaw1tlGYLJBADHq0sm+rN8b+XlFjx1YUzwq3koYs3MU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728957848; c=relaxed/simple;
	bh=yKFmsWK7pItBwOi4ewIuGYJPVwd5JCqEapx7jNrvwAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Gs1Blr2l7EFv5xZmEM6SaEpZHhVGtAFBmbZMNHf9wwX2tD+M2a2VrkiIYpiNReBx1QkX4IL/PrP3m4QDE83omb/0Ep6oEGaLhzmGJ3Ou8Phmm0UnTy9LQRX/jGjirL3L9nNd9wue+KV6NaIxHyvowdUxQML3wr1a5SwxOEnzEco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JgCASOnk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CDXxQPkN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49F1Bj5h018933;
	Tue, 15 Oct 2024 02:03:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=n0McvGH/dIitVNzMLQ
	pMaGWl80CykPAit3X6fMMbleU=; b=JgCASOnkI+L2QKhNBGF4TdGerBhsKq2J1B
	6Kaxyo7I5XHLWzjpmtVBf+K/dyCvS8CMc3RzbqN4EW1ZV+Nc3Z9bdho1ge8IgG3L
	lihw7QvHnBU7OmTI9TbYKkp3ZEsiibHQQSFV6vtDSk62RTFPHMRah7oXDkj4xJDx
	tdmifSJDliXdDumbsdiujAouROVEeNrGnhz1ODuxp88ljNnHkiLTT9oG89vvc+zp
	HLrULoDQ9XWYA12rUkXWS9+6gVwrwQLmtzRLhKWR+9ueItkNBjx03TFVJBM/Cuof
	xELmuF8jFiQI25ir+3Rd9hOm9tpPqnIDGa3fdaciIzpGH2kN1DAQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427g1afhhc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 02:03:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49F1dhRW026283;
	Tue, 15 Oct 2024 02:03:51 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj6tb09-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 02:03:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HJF+Yb5n06FwmT1n2K82iBtwn4P9Mv4b37yhaTxIhoZ2a4GB/ppy5WZ85uqZIwPadHjVxQ23BS7Uesb5Y5xKDzYceL3XONAOwRAQ6sQG4Jw9L3jACbY8ZNx/ZEEUXUKiPpeEi4HmR1o/mf6ZEaZPHQgIm+6dcwdaArxHCX5x2sa2O/+E2klNbJ81ZXMFc/DnObAi6e1VZ/yUjPXyMwX/TpXjAs9P/FuMwur0dkyjzlRQK6inw/LqsGEGqB/h0m/vppVycsDkQxFJ6gX71vU9qyUagWaYX/fRnwBd2LPjHue/br9pJYEyUdGvaefaXtvBrcVcba0fKebEPSC+uMEwNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0McvGH/dIitVNzMLQpMaGWl80CykPAit3X6fMMbleU=;
 b=WJWiMygCfH9itEMbNpwrPh59KBQGhBD7aiUmHgi0KXpIbMWnCaxemIglhReGinPExdTYJcx8/61wsq3K775s+MJTgmX70dL5unJ/HYPYS9KbKckV9I2sMTZ6sESMre84uBxOqZ3z3ER+GTXWsszaSB79sDC46ASeuWe3Xaq76HplBcLohsaygblO8odQGCw8pWJ/WbqQOEOJPpAkrxO/57nT3zfa4V7psNFUGLxwFRdkgoiT2ZECVIv/5D+zY7l9sNqaRt6RVFian9ukKrpsoqsn6rU+I0rBWRS5FBJKdjPQPDRW1TCEVv7Mw/qMA+QLPXaJdi3P1S6ZSrtk1cWeUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0McvGH/dIitVNzMLQpMaGWl80CykPAit3X6fMMbleU=;
 b=CDXxQPkNXZvDa6tylqvP/oRwKLsggPCAlqWHB9NN2fK8T6U7KInc8gJZIdUFojOwwafNeXWyeOsuAgmZUzktsUcWI4FqqE8QDGlGSAXBI5JECfQj4ylkgOyqWhYPfWvM888qdmRb1z20nJrOeW+ChiXOt5MQRFJtTPP01dOoOA0=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH2PR10MB4278.namprd10.prod.outlook.com (2603:10b6:610:7f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 02:03:48 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%6]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 02:03:48 +0000
Date: Mon, 14 Oct 2024 22:03:46 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, willy@infradead.org,
        richard.weiyang@gmail.com
Subject: Re: [PATCH 1/2] maple_tree: check for MA_STATE_BULK on setting
 wr_rebalance
Message-ID: <kpz4acqtffzx2vabwdzykhxdypfaght57frbv6kl4ropkgih7q@afml7mwgftj6>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org, willy@infradead.org, 
	richard.weiyang@gmail.com
References: <20241011214451.7286-1-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011214451.7286-1-sidhartha.kumar@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0170.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::10) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH2PR10MB4278:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e6ffaa5-a61d-4967-2e25-08dcecbd9b7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mQtWKCG7g0IZ2ccJynYayLSp7ZpMEdshgsr0F04RAQqFDTgkq82vgymmH5jf?=
 =?us-ascii?Q?iya5IJBnTksVGa0oHvyxA5fPo6NVF1AQSfyxhEQORkqSu7NX4mt/AaeqDxox?=
 =?us-ascii?Q?6NcLGT0cTWGwcy90qcqnXdjJksn8wROHbfHV4Bdltu6oRrIH8gayKcIorRBD?=
 =?us-ascii?Q?PFYhDhLhUWFZYKC2G1vu6vPxt14w7iq2LdvkNWHvj6EH3VUQdLSJoApC6GW9?=
 =?us-ascii?Q?QIA+o3AHz0vPGpQ0IAA+N4AELJSNEv2/nqPQ6zmxuRuu7fDjHDLUntSb5G5v?=
 =?us-ascii?Q?t11qcrUtpfiF77IxfEif++jQH487x5VjkFD3voPM9OoOxX0SXv3SuMXWRzcA?=
 =?us-ascii?Q?qnSvxw3JJJ5C+O0THLSJJ6puLoAfbJPKGF0iMVhP24E8TCbtEFeQA2eiJWvI?=
 =?us-ascii?Q?4TpnkueyTh5GT2e3l8gYI6f9MOwBMiN90t8KOXx36yGdmMSGJEhMDwnmzgzM?=
 =?us-ascii?Q?48dpFiF0gTJgPoFhIdkJxMUxmr4FGbH12c6WrSn+tJpW5r2y4ZQcqMBzP/Kz?=
 =?us-ascii?Q?bjF+jQCoF3ITAjzw9Gs3X6Re3649uyvKCHMvNatwvwSOl7z84HDDHWh5uBk2?=
 =?us-ascii?Q?zyNl4cLjhuwZoJ+p9jBlQF1PbgdrZxGErRE1oIF+5ks2qJrik8FW7HP5gltp?=
 =?us-ascii?Q?4LI3CoibCJYVCE0nNFobrPw4+i6kMeiowdJtHmVVoa77rGOPtjQHDa+UGd6o?=
 =?us-ascii?Q?Mqjg0s4kkjoUjZoKXDpaN4IZjJr3uiJeyNyDQCqFM2kcr7FLMU7+2GuvDDog?=
 =?us-ascii?Q?TrGSt4462zwVq7GjXsTVJTtb+ITWiJcuXKsbWubFKm72JMDa+93Own9STxNd?=
 =?us-ascii?Q?Zg09E+XJWvEzGo3GZ9VbeKaB1LOzkc2oRlJT0wmT9s/zl+DTnzF+DrV8A8hV?=
 =?us-ascii?Q?NrH2rExLF0lLQjW1KfnzBniYw83WrIJAfnmc1my7KpqfPj28z9x6KwVUuz30?=
 =?us-ascii?Q?I3beNGPf5eJQdi6hGw2tVO5t95nS8VJg/5Nv65OPygJiPKo4NGcxsD8A77n9?=
 =?us-ascii?Q?SY/Mg0ptEK5b1DDMTZ8KASKDCVCBpcVohe3qR2MhavHmq3yhRbAWA2mBOrfO?=
 =?us-ascii?Q?HdYL6ncp8qieoDryEgc18XjunnbqxJ7Z+NPd+wEArXWZ6rEtE/QNT/c9yq01?=
 =?us-ascii?Q?Ea6GGYMLWPiW8L3Wca84uvMG5UDNAe7el3NIcYc5dCc+tHtJJTnWck1wXZHB?=
 =?us-ascii?Q?49W5nJwdvpstTWm9T4gJFWvKz95d/dF+cWTbGk+LX5kvucvmLts4db52fVx+?=
 =?us-ascii?Q?tpN5vqOiRpwtQHCjb75ArqzSnrxr6LKZxeaDdGdWKA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0okguWmwU2tztkXPNfUK8zFyAPk2gu37uyOcHiS1pz6wR3MmNF76Y/aRzKQ8?=
 =?us-ascii?Q?5fV1K0wLUf36GvJq07Ao8h50jQxZE8mXqIIJousO8zGFC/Fd/lN7OJHGBMCQ?=
 =?us-ascii?Q?dp9+JvsNi9EhYyGUHitnNuLAB5zLeX2zW65Zy1HBWzKNW1x+I9LCrzvT9Irq?=
 =?us-ascii?Q?m69nOUkOCbysgXiagd+D0/FOESxJweOranTSPskYenSKTzVwggnIjOFo3Tg8?=
 =?us-ascii?Q?ft6o75/Y8/Arzme29VyHC5ofGsKd9ehJo31zcD0CVCIJgETRrX+D+6QyUyfi?=
 =?us-ascii?Q?FmFVkmy3U4UNjC8GK7TbQ7Qt1VdmzJzE4i49WpQQdpThlGD7R5N73/APdVU6?=
 =?us-ascii?Q?r3PGqNlQTupPF4BxJaMZsgvmEOETTka4RD9esaZ63ob0XwflNYrPd55+AyF8?=
 =?us-ascii?Q?9363Q5uzWt7TXU3HmKSVXBcg+w0jeOiCsKMtf6sCFobQBABQuD773XPjfz7t?=
 =?us-ascii?Q?466Eq+FBT88YQkFRZryPnh1fmJYKkMj5iqN9pHrSOU5LS7QPD9LOivwtjSjl?=
 =?us-ascii?Q?WimzD2ShvusVZWXOSY9yR8zwFI5z2vnndXrxBPQ1cYowDf1K1Vwew1Do5kgb?=
 =?us-ascii?Q?cY6jHP+PZQhpGQZ01mydPSnWB9XUgYPA/hOOGFjc6cpWHAqg9S99fAP8HqFj?=
 =?us-ascii?Q?sGhwtYo7DMp4Ch9IXErvKMWWJnZv0Y4ZekVnPZhXdQZeVetx95jetjG86iz1?=
 =?us-ascii?Q?DZ4tBjLeZ9rSVECosmTVBDu3Zr3huGfbgxH8z3IzyLKbxjPYDJby/Hb/4n9q?=
 =?us-ascii?Q?0PbRDmsJROEgNm6gpMBXqDO2fX0J8GnSfUfk3QRMVLcrKS2I2I30r1mgwW1k?=
 =?us-ascii?Q?Wu1wd9MzdinZpCWw0EBPRRUJGtQdH76uHl0GzZyQddjt3kc1CBa2HKBBLeio?=
 =?us-ascii?Q?ftXZHfu5E+kBz/SW5o5msBkep1hInaB8ylwMc01mm1qEA4/ZWsmgYmhZrq0m?=
 =?us-ascii?Q?ugLTeYd22WeJ1dSn8cVeDJRe1ckYvXOfMACfBNuvNmydNZHxW7I/ZZNX/pOZ?=
 =?us-ascii?Q?reymunHyRKFDWPo+5BqslxoX1pL6iAFvWnrOqzd42hXQxlfUvZynEXU9TTG4?=
 =?us-ascii?Q?GgJb7knds5NxUh9X3X8+JOpmMcJlWM0TyPLe7xfWy8IZFpmOHDh+rGT2vago?=
 =?us-ascii?Q?QFUceozO09dDKA1Rg4wYh8wPJ7YKBUYcqbzO8iT3/MnZNIipkd3M+JZ4WNdh?=
 =?us-ascii?Q?v+c416cQy7F8xXS8yjHB6TTYBSJrkVppqeIn/HoSv7lzFFAsUziBje+ZHHPI?=
 =?us-ascii?Q?pn1v2VLi4kawn30+pVLouccsshcHZFukA/Y3zFxXz2uIHG+zvWvEjqqPMkoO?=
 =?us-ascii?Q?QIR2JeGvY8xh0IUs0wD6dH0aJ2vFpnGjVQItY1tqjsxc15v9sj0Zyr4wTUci?=
 =?us-ascii?Q?jL1eEHTb7enWuwLjRtPHSxSDW6Y1gbjMuI0CyYLenYQ5+SKmjvzkJAi5YMod?=
 =?us-ascii?Q?JzRwBJ2c5tkiaFPNgkMIvYhGEgEAJpMAaG1k4ZF36LfdSkEExif5xyx9z9hf?=
 =?us-ascii?Q?q9E52aAuPv4vcW+7WnK6Jefc4fRDoCRJ7xVHHbDyrRH+PcBh44Zx1jgjWRQg?=
 =?us-ascii?Q?XLkFo1fu2V9onZhsFJLL8/I+wUGb74uRXdKmDCyn?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BJBksf7K4Eoa1hSrJqayku5+67FlU0QCKyepox7lxq0G2QZVlH3vzutktOuDvOUsptq/mdQpr4PpAW89zKU+qA5xVkXLwcZqcTlif7a8NaGTuHUhPd8noC/BrhnSigTXUTzzV68jQtvK78RTNg1qA7pWzrG8R3hY4dZ0PXWnpso6XFbWuh4Hg6BdEWUBx4/hgc/Lj18rn0UX6ZLSeoFW7aCbtqnvBkMTzFpIXA0WrrXV2DiQa09pJ+dYSZ+SX9n6xplp8O3XBI+Md47+RfRHo6cz5DU4V7qp36choLr7JNCTFRaKmBepK9AiCh568mmDPa2hAbys/PNErhakrU0HaCul2xSLJeg9l7c6BCD0zDmcgDRy2vET4pmbEaLLmx9C3ruzKcWiwgWlcVPEtPWg/XAeTCgiWcL2UIqY4ee/KpehpUtayLq5OERCNN3VGCKUaMNfRkQ/7DW3E9eOEwTVZBufA+r5Y56Z0Rp+WGF30P1wbWURMO5ldjtHpOJg4L6PHq+6QYl/VzpRtpSJIohrqYR6z3HQesI3+0sVRFyYhXFeM7B6F+2FIjdoUdammSDAgNBJxL3KAQjX+rb+Rw0wJ4NkkdE0YU4ZPC6UI1+HUfc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e6ffaa5-a61d-4967-2e25-08dcecbd9b7a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 02:03:48.2039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FjhmmV7xab7K0BDQDYXBAgEB2HvvztkWTMu/Rr11/lwq3lcrEPM3ISZ2SqLwOpdQ5nV3UE9eSuHxTW6KJkQyYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4278
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410150013
X-Proofpoint-GUID: 1X-Jz4MwHcgur9MrbFIPoNssa81ACWkq
X-Proofpoint-ORIG-GUID: 1X-Jz4MwHcgur9MrbFIPoNssa81ACWkq

* Sidhartha Kumar <sidhartha.kumar@oracle.com> [241011 17:44]:
> It is possible for a bulk operation (MA_STATE_BULK is set) to enter the
> new_end < mt_min_slots[type] case and set wr_rebalance as a store type.
> This is incorrect as bulk stores do not rebalance per write, but rather
> after the all of the writes are done through the mas_bulk_rebalance()
> path. Therefore, add a check to make sure MA_STATE_BULK is not set
> before we return wr_rebalance as the store type.
> 
> Also add a test to make sure wr_rebalance is never the store type when
> doing bulk operations via mas_expected_entries()
> 
> Fixes: 5d659bbb52a2 ("maple_tree: introduce mas_wr_store_type()")
> Suggested-by: Liam Howlett <liam.howlett@oracle.com>
> Signed-off-by: Sidhartha <sidhartha.kumar@oracle.com>

Reviewed-by: Liam Howlett <liam.howlett@oracle.com>

> ---
> 
> Hi Andrew, this commit is a hotfix for this rc however it has no userspace
> effects as there are no users of the bulk instertion mode.
> 
>  lib/maple_tree.c                 |  2 +-
>  tools/testing/radix-tree/maple.c | 26 ++++++++++++++++++++++++++
>  2 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 4b423330d83c..b3b1d4b8126b 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -4228,7 +4228,7 @@ static inline void mas_wr_store_type(struct ma_wr_state *wr_mas)
>  
>  	/* Potential spanning rebalance collapsing a node */
>  	if (new_end < mt_min_slots[wr_mas->type]) {
> -		if (!mte_is_root(mas->node)) {
> +		if (!mte_is_root(mas->node) && !(mas->mas_flags & MA_STATE_BULK)) {
>  			mas->store_type = wr_rebalance;
>  			return;
>  		}
> diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
> index 5fde09999be4..551ae6898c1d 100644
> --- a/tools/testing/radix-tree/maple.c
> +++ b/tools/testing/radix-tree/maple.c
> @@ -36317,6 +36317,28 @@ static inline int check_vma_modification(struct maple_tree *mt)
>  	return 0;
>  }
>  
> +/*
> + * test to check that bulk stores do not use wr_rebalance as the store
> + * type.
> + */
> +static inline void check_bulk_rebalance(struct maple_tree *mt)
> +{
> +	MA_STATE(mas, mt, ULONG_MAX, ULONG_MAX);
> +	int max = 10;
> +
> +	build_full_tree(mt, 0, 2);
> +
> +	/* erase every entry in the tree */
> +	do {
> +		/* set up bulk store mode */
> +		mas_expected_entries(&mas, max);
> +		mas_erase(&mas);
> +		MT_BUG_ON(mt, mas.store_type == wr_rebalance);
> +	} while (mas_prev(&mas, 0) != NULL);
> +
> +	mas_destroy(&mas);
> +}
> +
>  void farmer_tests(void)
>  {
>  	struct maple_node *node;
> @@ -36328,6 +36350,10 @@ void farmer_tests(void)
>  	check_vma_modification(&tree);
>  	mtree_destroy(&tree);
>  
> +	mt_init(&tree);
> +	check_bulk_rebalance(&tree);
> +	mtree_destroy(&tree);
> +
>  	tree.ma_root = xa_mk_value(0);
>  	mt_dump(&tree, mt_dump_dec);
>  
> -- 
> 2.43.0
> 

