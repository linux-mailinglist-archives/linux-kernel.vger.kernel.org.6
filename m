Return-Path: <linux-kernel+bounces-255622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E7B9342F6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49FD11C21443
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 20:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B919218EA63;
	Wed, 17 Jul 2024 20:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YnCg+waC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0N3mKt37"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41EE18C178
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 20:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721246874; cv=fail; b=Ey1VSvnJt2jmxL4S5DEgolAchEUMlv70GM2cFBvdt/LiYnLh1qTjSRpzil7uq8F/2oiQKhYzOn7DydHmQIWjUmA+YSHGbXBCt2NJd46xwMr6R8n9mE/G0IZ4sllAI5vI1Td0Q7q6YcT6ufZ252G1khoYUSypCaMlLZeUNu5X+og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721246874; c=relaxed/simple;
	bh=o/vxcAtBQy4UY2vf/sacRBA+pJQ2L8jcqQcEGuxhZRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q/aANWFsIePRlOGnZQaFR8HwMAprmYXRFFUxQj3f9x5pQsiMgV1s577oDqREQUM1Bbs0k8uR0dV/2BEIRCpnC9sqej0nqRpLPpDTJ8ZO6SXI07epYIh6wBNY+WeNcivZYKAjxboqO7y80Znp+Qn+Gm3EF5LjPnYkYeYyc7Xu0RA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YnCg+waC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0N3mKt37; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HK4ww9001760;
	Wed, 17 Jul 2024 20:07:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=R72J2Rq+pSM7hD2A/i8y70d9fRxZSFkCgc//56gCKE0=; b=
	YnCg+waCSG6RuuK/GLj84Mntb5/ucduftPtXPkwlmsMp+LPXW9o4Qd+ZPoFaLVRW
	PYDfmD+sJL0dwpEzFoZWTAfSmtYQfmvobDaLSIXxFu2y/g2yJZJszb73kFk9MmSP
	XombzOSC4bzOz6chZ/r8psvwbZ9tT+BHNgGH76Hkng9pmtYV0NWihp840WZr5VJc
	n5QU7DYmkslW1Tvba7ShztRIGDfEW/WtKtBjoHRYEp+EAayjWUv7uBpJ7C8Hbt5q
	XlwiStWuLqASrEVq+u9Rjb7Tzf7k9cBppqAhWG5eqVwFoQpz7bVF4Ue+VbWgE91f
	0PppHHV5klbkIysRI0X/hA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40emp5r07e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 20:07:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46HIrJXq006940;
	Wed, 17 Jul 2024 20:07:32 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40dwey1fcb-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 20:07:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=afWhwIemtrElLX4i+QbK4Vl8ERhZCye+kLI/KNx6FJYXGIq3y5E+3OHpFmCXksZ5iujdv7ycFqLSjXs4N7GpK9cD6Mi0c64u/iyi8F55I+NxNwCpk8zldtkBJs13fQXWjQ3YRnwoRIQEO3OKX80r5efSwiGHgmVxyXFYKotNDS7fDP7UJBxxQO2xgP73/ZwAbnZyaCvw5EXmneRtnorFUMy2T4hHKp39O9nxWNZS/7oFIrMZZgMlsNhxqjPQcyMZQZPYsntqhCKH0W2SrsusKN2kxtvQxUOm93o7qhuVAj/fVGtvStntHUU1mJ7FBcmKx8Tk4+nxPPBXPeh+I2z3Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R72J2Rq+pSM7hD2A/i8y70d9fRxZSFkCgc//56gCKE0=;
 b=EDQhMJ3FMwPIi6FJ9DWaEl8L/ZzZvfQjHiS2wfaXG9ps/lrOrplbiDYcm4S0WlSIofEXzDBtWfSUKfDaPlCk/rXX2pSolquWPCOStVxP2udOtG9NCnfDJ3utfaTKB3bW7MZisCLs5PvE2CJt7y9CqwdK4NJQGYwATMJS8JK9YYJXD0ftMu1pIUhU4AiRggDzxEQOpG1O02WMSoSybncDrz8w9NN+sLtefs6sS6nuWFb2iBvrfa+JRSyXFNMbmkrIH+qHiNH3O1CLlaETyA75CdCiK3O6DoRd1uDbWks8n8r7rG4eSB+0F2oCqQhIKOtLEn1DMvUaqD5LlTSvHOqdhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R72J2Rq+pSM7hD2A/i8y70d9fRxZSFkCgc//56gCKE0=;
 b=0N3mKt37eX7BEO86r16/p8a1fYT5MykxS5W4SnGB88SIG8ejAqHX5XbLhukJ6bUHaMfejVyumhFwabi2wMWxtqR1vSKamnoh8bHgP/8UblK5PDjgRDf0yo0f1R2Cs+rxHQsNSC9s7hU6eiVWGaJM8Ek7Ltov67ez8+USnKacs9s=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by IA0PR10MB7303.namprd10.prod.outlook.com (2603:10b6:208:40d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 20:07:28 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 20:07:28 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        Jeff Xu <jeffxu@chromium.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: [PATCH v5 07/21] mm/mmap: Extract validate_mm() from vma_complete()
Date: Wed, 17 Jul 2024 16:06:55 -0400
Message-ID: <20240717200709.1552558-8-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240717200709.1552558-1-Liam.Howlett@oracle.com>
References: <20240717200709.1552558-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT2PR01CA0002.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::7) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|IA0PR10MB7303:EE_
X-MS-Office365-Filtering-Correlation-Id: 96490cb5-e445-4164-255e-08dca69c1552
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?3cuBf45e3BBp8JbBVJAh3WLSLtq+OjPRc/qlSsPhQwTcjkOg+Lnib4ul3r2j?=
 =?us-ascii?Q?CyRLK86B+chKUeaC2KfhCA1RyrQ1AVz228DCjf3QCxhDwmzJa3cJ2/Tw7JvQ?=
 =?us-ascii?Q?IHBUSQ4t2/iPUKpx74NfXq2sRakN9l0vCyLyIgXJOa1vn2n+nf3m8inH1Hh7?=
 =?us-ascii?Q?DwW0T9qHfnmLNrtgg4R82CHsn5OFa9n73+SROOlTQLQWtv/C8jTD1OmufSoI?=
 =?us-ascii?Q?pPPkZWnzfD9UbD+ikOli6QL51ASfZ73adr1lHYaLOLaLyBX+uSKu4LxHK0CD?=
 =?us-ascii?Q?b1KwXNh8TmWPz2EPCHI7avPZ0oRVayFjteYExX037w12eRsABKaC+CsMQdaY?=
 =?us-ascii?Q?JXh4bVd1TODO8mvvzd8r0Zws4TKt2opo2aH+LZV5lix8W3JZq0xk/VBS7F1R?=
 =?us-ascii?Q?cpcs6gMjSTjl7FGMP3AuIGhuwQ1HUjwLtS82iv+DNNzAvjaZ6flzdaPfegA2?=
 =?us-ascii?Q?J7pH6QN7Ij1r+dFa3Bi32oq+oyJ1CSeDUMZGktPfgXkUjhR/3m+0suGjBEEG?=
 =?us-ascii?Q?j+BQWGvz+rOZIUUJpYkpNCCwznZ0kF64qr98jcAMxO1OcitAkUbuRYhbE9Wn?=
 =?us-ascii?Q?+hjBcz9ovERWotYwpnTX0f6iWy9T9DzgS6LfRVgsCvW8PE2gtdMhD1acZMtH?=
 =?us-ascii?Q?0zGkY9HGkT0OUVIG5iidJy6Z3J1c7DJk+Xlr+GADqzVlnNk97riWdrVqJ7wt?=
 =?us-ascii?Q?g5G8U4ssof6L+3b+MGj1bwfTLHKYzZ4XmxfrZvQwa2S3QHfL3OQzNtgt4W3z?=
 =?us-ascii?Q?orMu7wZbtwkdxfVDfux+4SsZ4yHiPKwEVw5GRI018LGWGhqel2SqSS9j2AVB?=
 =?us-ascii?Q?1/w47pAXZ9nVFsZ0GACj8GqZGfJxA2DKA7uv5XcDMiapdz4JrdshH7Y4PCS2?=
 =?us-ascii?Q?Uk3q4/FjxOzm5GlLn8fgh7fvSxyEyritaYPLCFMTwcP2vsx5p9SYS98eHkfJ?=
 =?us-ascii?Q?BjS5H09+MfyRHzZ6BV0xuqqh5+o0fspIcnxNaF7dY24EGktONh5f+BNfdjnx?=
 =?us-ascii?Q?yl0QmElux8VkGF3vmigN5sJoEFFMiBOgr9Rl8mqGejNDu3/cjGG/4clG5hkS?=
 =?us-ascii?Q?J6sx7d54OeWZfVTuSuqto+wvzs8GCVvEqT1fjTcEGGZj5XCKTa8fnIl136bV?=
 =?us-ascii?Q?/Zj/xx22irdNuNzArhpxbIr2P0bzCFRXWuKqpxwrXFEbn2T16VfI5fkoRlkS?=
 =?us-ascii?Q?1IBHlSRBfhKrQLFyDDQytPYKFdHrSVS1PduQuKPaezhhmy3CFsbgzDLNrfiY?=
 =?us-ascii?Q?hd1j3Mt40sKtzydqs/5pKp2xNjlM5JkxapXPzXtKSzRP1EGX+L7aMHi3aqEF?=
 =?us-ascii?Q?4WRYkO+zU/tNtAkx2s15StDbvL4GkBYzbeNdIhL6W2hQNw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?WE15ZjdNkp4V7zVaf6V3gbWBbaOYjLr5PuQtouOOTRHk5lBbz+mXnyLOPyEW?=
 =?us-ascii?Q?7eyUmRjYGCX+ib4KQEzt9PmDrb9h3ozlqjujiFllUUpfkHHIq/3QRSGjQ30g?=
 =?us-ascii?Q?Qa9sA5ZnLGg8XeZaCjjgONXebiSUxNoHGxHsm0qBqpGSnJSCMPWeRfi0zz7J?=
 =?us-ascii?Q?0L4/o7Q/fNkdcS85KYyMu/ufLbmTJgZmO7roLy8SOFwF7qjRbs7QPWgwU0AB?=
 =?us-ascii?Q?4obDp8bMctNNBW1WSc4yB8jqBQiAeQ8Mb5pHHj9CzjbShHyPsWUoR50CAl2N?=
 =?us-ascii?Q?ujqoVRe6LuV85qH8EqVLFFHBr6b5XKr03plbopRHem423YxjxAL03n3L63uw?=
 =?us-ascii?Q?x9AdwJVRGp2PFWwUvcHVTT7ZrRtVRx9g3hGnWHJfRhUJjpxlV5xbwbJkZeEO?=
 =?us-ascii?Q?VRryOor9olvRwWMGjc4ojMxAUWV7SnxtFMzNGOWl7iyVkuXkhEv2k+7Am4CD?=
 =?us-ascii?Q?ISNl1gNnpMhKMAeW7dZpVnLlyPG2csHNdN1oFF1EwTi1n+abz0Mw7AY6QPD6?=
 =?us-ascii?Q?kT6Yc4zb7sWqtqyFTmzKHtAbyzWrfkFn1HQ2aCHuRbLzYX/LQTHmZr3aGJlm?=
 =?us-ascii?Q?9IjVAD9O4mjrdA2w8Rkn0Aa9Dhe0zRlzuBtzQUvURoe5KPpc31O50D8Cz5r7?=
 =?us-ascii?Q?EMtzLRe4X4arq+JqXRLxpXvl+mBUBB1EF4JP7nyTU3V7z7vyWqASlmTs1Dtr?=
 =?us-ascii?Q?WQdYacwJEUP1ttZIrdO0hJY5IZ+JS+oenpatRZUip/U7uXKUTL7yiYtFyGfI?=
 =?us-ascii?Q?HWdWYHO1RakNX7qSGJX6qFlGIb293hfRIl4ZhvvHDYgwiQt9r4/VX1d8Z1UH?=
 =?us-ascii?Q?al8fAfuTqIFoTfMacW4lFCvrfQjGpqe4LYD6CqgS+cyADcZxAGCmvRcLagrT?=
 =?us-ascii?Q?f9YdGp13/cE0ses4pAi2ZgFhicYf1vs5wXa74Xeaq6HTMhN31JgF4VMUFnrI?=
 =?us-ascii?Q?BoaB0xEx8cG/TOogZxDOd+nc2m+EKL3x1Aqbd8/4zcd4AruO1hic87kuPdws?=
 =?us-ascii?Q?neeSOl7j7vV9Tpad0TEKMfaPOPvHwqohzFSLiyffoepwQX0s/kl+DzLejXGL?=
 =?us-ascii?Q?aTQWm5K4qvWqShl1VknSUKan9mQrvaSFptniie51pWOBt+KkA59l3m8MkjDS?=
 =?us-ascii?Q?/tcthWywrkKK+0nC0u/JTv3slq8JLxnTi0y17hFHP+6b/CbG5bCRkPKZ9QKN?=
 =?us-ascii?Q?DDVjxbAzqmv9LcKInt1KRPEnKKhczDIkiFcPsVVYiM0esUoyS9MII7eF16k9?=
 =?us-ascii?Q?X/KmbdZaF6hKcBY9QKgGzxn7Yid2IBdclXFaMcyGkx5zS0KWZ97jRPa+hD9i?=
 =?us-ascii?Q?DmDsSLaBd+TyPoLpk0XH4YYZ/o/lvcHNc9xiP3MCV9QT7X2+kakguuaS4nI7?=
 =?us-ascii?Q?bDTJQIb7S+pzdPLB+N6Y9YnGcZaPv5kS5Ke18ctcICQW8QGYodM8d/09VIxZ?=
 =?us-ascii?Q?3bY6so35c0diwGPfraetdHoFV047o2+x5ky3TYTOQBfFMQYAmyxNl77txh+i?=
 =?us-ascii?Q?3/3LuEBsXhKJUwF4tGCcbGWyDUn+dIKAit/h7hbj2RaFqiSn+9rX6Y/sVFKI?=
 =?us-ascii?Q?/D/qW/ZPcudoxy/IF9MwY6MAm9kZrMB8Dz4gJG8z?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	5+ZyUoKFQJZkgOtWR1XftoJpF6+a7CZmH5uWV8nvYSCeiunwUdRPnH+7o/7Y+OGYY/pYCegwftUHP5YpjUkDUJCgJYutOLgukdhx53+mdbGeKRHhWL7zol9T3iP78hpx63Khe8uoXzwVI2aQPJ+Mmeoinyubsysex4qvYBBEt5Hx1Ztwhx9FR/zcbpfzVfUWJ1OzqiatITZy15o/SvuBFAIpuD6ec6IaJWtQTSlfmIGlkHmWIonFDyE03UXEMcGNotSQAnFgt0XiOATy+5u8Nsm1CXpwgYqW8LTYjD+BEmJld7Fua/Wv/UcMuFHjLX6e6VZt0UGUPGR8BClJYZfBbvhoYIpNxn4ayvtAtuWJlgWZjYqctUOCYuKp1MtUexCExWmKx8J2av/UgcLbJYw9BXpiBl4wNZ4uDeNy0bqssT3tRvUpLZhvhudh0rxBq8zzLHaBC4YlwR/vXmUKhdBc1Xxu+9U+H86H2MjligJYxTE9No/BwXBuD0Yh7yhFVZfqeTmQZlfC4L9xk+N0A2GsFU6xOeniy8BTp8bSTwmACvokW8u5b5XMq7SpBScc086hrJg+Cx7uvIaDh46FZlkVYMi10Owi+HuwqxuhFWKOGso=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96490cb5-e445-4164-255e-08dca69c1552
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 20:07:28.3994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fvfhnHAjnSjwMxY/pZriZ9KQrL7ZHHL4EX1fRArRb5lp6a7lH6tzjLmWtbJoQzLdjPYiPP4huU1D+y8/cs28jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7303
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_15,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407170152
X-Proofpoint-GUID: Cp1m-mtI6d2amT0j3kFnT_RNDrFgb7RV
X-Proofpoint-ORIG-GUID: Cp1m-mtI6d2amT0j3kFnT_RNDrFgb7RV

vma_complete() will need to be called during an unsafe time to call
validate_mm().  Extract the call in all places now so that only one
location can be modified in the next change.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 62ff7aa10004..1c9016fb6b5c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -646,7 +646,6 @@ static inline void vma_complete(struct vma_prepare *vp,
 	}
 	if (vp->insert && vp->file)
 		uprobe_mmap(vp->insert);
-	validate_mm(mm);
 }
 
 /*
@@ -734,6 +733,7 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	vma_iter_store(vmi, vma);
 
 	vma_complete(&vp, vmi, vma->vm_mm);
+	validate_mm(vma->vm_mm);
 	return 0;
 
 nomem:
@@ -775,6 +775,7 @@ int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	vma_iter_clear(vmi);
 	vma_set_range(vma, start, end, pgoff);
 	vma_complete(&vp, vmi, vma->vm_mm);
+	validate_mm(vma->vm_mm);
 	return 0;
 }
 
@@ -1103,6 +1104,7 @@ static struct vm_area_struct
 	}
 
 	vma_complete(&vp, vmi, mm);
+	validate_mm(mm);
 	khugepaged_enter_vma(res, vm_flags);
 	return res;
 
@@ -2481,6 +2483,7 @@ static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 
 	/* vma_complete stores the new vma */
 	vma_complete(&vp, vmi, vma->vm_mm);
+	validate_mm(vma->vm_mm);
 
 	/* Success. */
 	if (new_below)
@@ -3354,6 +3357,7 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		vma_iter_store(vmi, vma);
 
 		vma_complete(&vp, vmi, mm);
+		validate_mm(mm);
 		khugepaged_enter_vma(vma, flags);
 		goto out;
 	}
-- 
2.43.0


