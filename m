Return-Path: <linux-kernel+bounces-241593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE32B927CFA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 20:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EB061F2410C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 18:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672F5130A5C;
	Thu,  4 Jul 2024 18:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g1DsgPam";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WdSGck6g"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00D96E614
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 18:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720117667; cv=fail; b=GoCFDsqJ9AxDrLNrsDDLnrfdGmhYJL9tG8SrVdq4QBcrzNEYQvcf3zznMCZ0/mQVDE+93pYhVrjByeMPYxN7MwHQhI5g9VK87ZH5cixun9h4zeGPyjeXKMZVHSnyGdYwwAQmlz3CEVGRTPsYqIA79o0MTq/+wsDD/PrQdLifkEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720117667; c=relaxed/simple;
	bh=MUdGcyuD1zj/hoz6fbwcxO8kS6iWTbAgAnBkUwwqZ2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FHLbmugkVJruWO7Uj7f7nAjBSLR7D3HsHE/dp1hQ1nOIpFfytKCX1B8ic9ygU/aZsEr9q0ofhKIx95OwJlpMCFDBTbFVhueYImcPOKWwLOrTFnSE8m/jIfOa6aJ5ik/pmR0cY26FncMhnDyYJjnAhfRKZlI60rXSBaeIIknOvvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g1DsgPam; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WdSGck6g; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 464EFGmF016760;
	Thu, 4 Jul 2024 18:27:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=zSu8hDWlGjMxPlRgldY+gYYh1jH3ES1rfBL14tJEjt0=; b=
	g1DsgPam6MzvUAN2N0Wh/TAJqZQullBmm0fHf3D7Ii0NZ5Af817CXf8rVrwUFjVk
	mtbyAlKzNTJg7CaXnBtArmJ7ItcL6iNgvBcwWIiZDPK2Zo6pivKJIGA27u+/9I/4
	Udajg9rEqqUbhH3Ht6ky/9s97BPbV3jbBnNSL7OfmsH2FS5K2s2pu0W0NzaxlFC1
	I/4pe+lE6dRA4fUvPSzya9R7vaIsrBG7mA/dRENHxmLiGciFom5Ks8dbQUy1ycPf
	VthEoCfSQCzHXWX9+UYD/nY8+mPaut+IcAMNmy5Qh8mwsH5sboBWAHv8OvjIZF/9
	jfNFKRXXRoS0n6wbERMxCg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402attjpgr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 18:27:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 464IOVNg023544;
	Thu, 4 Jul 2024 18:27:29 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2177.outbound.protection.outlook.com [104.47.73.177])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 404n11kmhu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 18:27:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oGnu7+/bVBzrdlsYcz1h5iPbfhidR2GjcfqnKd31QlLBLOwzjypjDP0v6Sb9PRTjeeANQE+y1U5hoRt0SkEhB03Ous1SAw2Sr7nZR8IdLr2mPtwJN9JV5ms+X2lPomiDy6JNiyCY/6hdswoYZ1lWw+t9EmXobqYUjgowa0r/Mfzd/R6zEYTXUtwXJWjJaTFYqmUKnHuFlLp9alUevYqXIQAM5vTI2OEsTJkUqRyqY/U1q+Mu9jlhhiFWZFoZ2Hz5WUyCkb7ZzbEgnMY4XJ28Gzc6gQnFOSkZinfEOqAUSW8rkekr2aCOdHlvlRK7rAvbeltXnqjWJFpnGF3fKTCgCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSu8hDWlGjMxPlRgldY+gYYh1jH3ES1rfBL14tJEjt0=;
 b=DIHyslZmdBcpZ+lSe4+YJxNZR2O8y/iJ4DcH/6H0TAaUSJIVC5tQPl3nGQBQ45a8ZWkVZL47He9edzlXJnggFekwimwYxlmoQjzUhkr3ywk70isytRahAE+eV4IhspMAgcbXlPQcUQfkyICcaTzQwg3djOW7diTHOzAa7imMo5Eenqtuey2/Bxt/Yv4iUvyNsljiP5Y7KfQ0a7Fpt9lrAa2pvOXyYXwqdDph1jT7Z6tTkV7IhYWDwG9max5JifOc/3Go76SkHgdOamuWXzCnHI7wOdjUyDDhs8j013XgPcJ4tKYSTYwIX7eM3TSnNLwNWvw/tOVT2r/bCfarVn/TPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSu8hDWlGjMxPlRgldY+gYYh1jH3ES1rfBL14tJEjt0=;
 b=WdSGck6gLOUpA1uCn+lhxWkcSbGoLin/Ta+TDOLKerHlHodKuqKcdax2jgiZDIuggEkG9ILQBHjo7Rd7vOZB2eGDM7bMxUf4aBo/kKwDBe6pw5HamZsP7xAkcSosQcL9l9vNx9tlQG1S3sgiYaIcdJ9j5pYICmqmHRwgMFf0K9A=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by BY5PR10MB4242.namprd10.prod.outlook.com (2603:10b6:a03:20d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Thu, 4 Jul
 2024 18:27:26 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%5]) with mapi id 15.20.7741.027; Thu, 4 Jul 2024
 18:27:26 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v3 02/16] mm/mmap: Introduce abort_munmap_vmas()
Date: Thu,  4 Jul 2024 14:27:04 -0400
Message-ID: <20240704182718.2653918-3-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0230.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::10) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|BY5PR10MB4242:EE_
X-MS-Office365-Filtering-Correlation-Id: d5341f8e-51f5-4782-0314-08dc9c56f4ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?X13V3pvLPrCLzYsRBqPrnZV2SsYa670J0BCTYWgVPizIIQ2SQLCZAnXm+V+N?=
 =?us-ascii?Q?sjPtrvESgkhHocxlcXvFHTtd2tdTSh+IzRtKF30Dj27DZCk4bE6kYdVbmBZl?=
 =?us-ascii?Q?Z1OWwvBfYm8oaanGWamQcyaFQLBX6t/cX5Zzgc7HB6WpnTLaJJJ1vm5lB2Yf?=
 =?us-ascii?Q?y3bgzIMI+IpQcz/izn4TN2Qd3CjqPHKj21JihXNVoxCBUF6vaZqJjZR31bHN?=
 =?us-ascii?Q?hUAI5fOv8LvZY5YqRs+xBHjvuQgP+iypyFOYgt+sa9/sEeavxQhfgW9f5hls?=
 =?us-ascii?Q?ZUsbcQt6r1DQ7izJsLUXGXEY2bhFRhRHfsx4Afj3OX3ziMh6HPGB3sPTgb6z?=
 =?us-ascii?Q?TeZKr3PRvURq2ibaZTzcAJJP6V89Bg2ECn6kFClOzxTFEFA+QRKbCTq4JMSG?=
 =?us-ascii?Q?J4dHbCCOVY22zPYyqitae1mLnbFDBu20YWmHgJonH06Qes+vul8avQHSpcLp?=
 =?us-ascii?Q?64KWXx1R+/fvzujRhZA8d/JOk/NA3mvYgjBTIdCBwVumS2V8o+YcyiHniByI?=
 =?us-ascii?Q?VEk89WDHjAJZsLDrIw9oltkpNP/2yiPJlUJD8o4Qo0BEmbGN0VIniNngDKmG?=
 =?us-ascii?Q?1q/Xwa2N2z3BPgxK3iwT475Xi3/IQjbUU5DxRWROVYTpLJX1VsoA5fYH0HC+?=
 =?us-ascii?Q?716a1peg0tZVVa/rGG/mjQuY64rhviKTPTDWHMQAC2yjTovnFJnD4f5bpqE1?=
 =?us-ascii?Q?KweEf0ipAl10SHHoYjLkhAyh3gMoL8vvDFG2lYtig4kOBkZ5kKZjrVDoso1O?=
 =?us-ascii?Q?0CEiBEUzn+oB4klMSNt405ZbfrRa7tWm6a0ZS3g9iqx5PlYF2kJMAa9hr/z/?=
 =?us-ascii?Q?IhriiQqfBKU3K/k9R999qVJds9Elyhyu9+Ee3pRceIDwB7UE4z27JsQjyCre?=
 =?us-ascii?Q?6GxX6JxSF8OZCJPwkWNgKc2rI+6mO1dvt4Y826cMbmm8Vyugh69sURfvJVRp?=
 =?us-ascii?Q?ITFr+rAg3jpHQzu/Ax/998AmZI5u5ETs5A6AiuUKPqst59Ac+hlmVOqaw/P9?=
 =?us-ascii?Q?TkEh8651c4DTburs0Ih9roLGa1ivxVOeN48dFbguAa2irE0wyRFa/4riaq3R?=
 =?us-ascii?Q?SyDrRBrejraUosRa9MOQUflpjia44dRtaM4Ic/PdwqCTM7HjdDlQrOTgxaEN?=
 =?us-ascii?Q?cvDGPgrD9rvfIIPaFnc3GW4mpKTbJtjMdvs1N9s/kPGPrZNM+6A8iFvZVVyT?=
 =?us-ascii?Q?zpbOKD8UF4Yms91T/cuOfmscYYApzI6tpWqdtkO9ySlONnVTQDwO2W0/eFki?=
 =?us-ascii?Q?Gu/PQfDcS7yDEgsFqlGc1qXF/L+3PDsyBC9HaZzITgSc1oF2TntOTVialSXJ?=
 =?us-ascii?Q?73b7iMV5DhUMZjSW/2SGYdxMqMZr/t0pqhkroLD4ymb3Zw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Q5obfn/sCcteA0szm8pGQ6Z27rJlbOZsfAhUyovFWygM7i8ByDSswyI/15Gj?=
 =?us-ascii?Q?u/+IANk+ykWF8Po8wbpi9vr5bA8my80a9pAHfTB1aQGT/M4DLvg7I6sBs14J?=
 =?us-ascii?Q?v94BH/cUSXbIE93MEvE2zqXqfIjSe5ByJOeNWCb05Qooclj+1wste9h4YslG?=
 =?us-ascii?Q?TbuMazjiUm5MrjywCsoS5f9VevtXIBbyym7X1x74wdsfSyKI1UsQ+XGkZ9Bw?=
 =?us-ascii?Q?3ZY2QGzEoh43JMZHZHo5qwwm27fnW/INY5eI8v4kM0mclkXv5urUtBw89Q7A?=
 =?us-ascii?Q?/klZtQP1x0w8EMvckmyK2RwP7vI4CWTh9ijhjN6+fknWjtT9faYaFrPqUgud?=
 =?us-ascii?Q?Hqwt8xV/VeXNaZc/+McHGOrjMsSRiqfgMVqo7Z5226FVLM57gWThtkcGSZET?=
 =?us-ascii?Q?mx4Z0+1PVqAfxtjnMTT5AR3vaFZse0NmCo/wLjwXKalLGiuHsQ7NSShx5Yd+?=
 =?us-ascii?Q?plCuS+rAuefbU5LKn+LNR+9Tna3YdsGPzGDMmjJHW/lXD6SKQmL3kuK+omft?=
 =?us-ascii?Q?ZqX5qLmn7ouDjGy3xqa0DUG4Mo9uN0kJgJk+n4dkza3wlFvy/ospctBnfUrx?=
 =?us-ascii?Q?TSUHnrgPKam1iUDKlUeYND8R83xFIzzG2oMIhe3lFhtLUB3b+yrpLuxbnkLK?=
 =?us-ascii?Q?8zLRM6kVGdDQ5gPsAtgS/vnoC6/yUa1gV/wZmNq0dT7oCQpmTQdNurVaDCd0?=
 =?us-ascii?Q?0olCzIVvWZ64KOY3Oow5JEEuZXTLOVj4rNG/AHKGDNnFdtFN9eVhkDOeqWPh?=
 =?us-ascii?Q?6t0KdrDAx1x27tL6U5HHKNCE6larLfnsBn0mtITr+UrW0s0mPuyVM8iRIxws?=
 =?us-ascii?Q?Im33FM+I+VqoAH19+N/Bp8UrJ8sqr87oUBX7QBjHLKVUk+mghuuDfqHboyTU?=
 =?us-ascii?Q?MYjUgLf/io6ngfc6j68rLp11UfyDMSsvkuUPMcpGk+TkX+xa5EL9ev3nqIGL?=
 =?us-ascii?Q?LBoia/VoIpALItu6aZFkDYfokExb0RoQPgaNvOLY3XtgD0GCvTks0uOWLUf4?=
 =?us-ascii?Q?jmbxhMTgoKBZAeHwBJb4rRJ9ZSANYcLAO5R2yNbAjWN0GxCT/OiJ2WmSiXGo?=
 =?us-ascii?Q?ILshSehvuzwGtPEQpzMGF30aoiSaIi8JBzdpwPg3c1Cr4n2fzJHmq+LPnBOa?=
 =?us-ascii?Q?EpzZSFsYSrFGpF7IvfdxoW2ZvVNrpRuJGmAdMjyTACYDdD+hJjJNiS2ue+Tc?=
 =?us-ascii?Q?XVJ2LKXcR0t6UplUGKWDj5tXRWBd0uOtqnY9TlzjbIJIT/pOVd5PxFnLJtCS?=
 =?us-ascii?Q?BTZ5dZFD5IqQAGWL0ilgBL8czPdtQKDzWf83/9Ipw3zGgqjes2CUUbbzdvuN?=
 =?us-ascii?Q?9/pwuN4xbvXNzeqPVI4PM7GorL4j60oc8HtgqoNDywwuRk0maqqaF3KdyS06?=
 =?us-ascii?Q?ya44YDUD4JysNSz/tm1HpqAvAd874kyyXcCs7SiNfr0fLSyGbXXcLOuN2fPG?=
 =?us-ascii?Q?o9tmzlZrVQGMVdWHvJJIDrwtCe00KtSt/dYTbUbpjT15fHpKlmM/hb35XN7N?=
 =?us-ascii?Q?dhHcf+BrqBV0wNPnvF19TwTJ5LLnERmE9A6tnykTo8B6tuMDoiObdYdSJjiU?=
 =?us-ascii?Q?YpUXfXCpRehiskoje1IVX8QPOjETASLSdDnWE7o9IhTB1y1luXg04k1DJbcz?=
 =?us-ascii?Q?yA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	uSQVZIGRobKx4X5Jl0uSriZPjbI0XPv013u0j3ZFcdGKRseZagaN71lWST5/bA0sLpHz71hwqqvaemiXriUdcHitDfVXesxSBrwZMiM2Sj3dPG1vpQ4MaaH6IOiqrLsiUGKh7wbpdcnThttvUVZkvvY6eSsw04oGoY/NouyhvKgGxYkrS3qGgIL//yiw8hVX5L4qBaf40Bba10zuv79GPpO6SC5X5A2Ck9xcaisCDh/2Sf+JuOov+aT5paAvm8qCZGucx3eBOmTc/FsvYzUTc68G+LwSWIT3onxxlnBim3n+iuZuXhbl/SVpq8qPcfhHN5oGQ9TOISxAGfhfq6XswhyTXLmnqcfVUbfMBbPFFnc7UteDCg+d8/ZfW9FDwMItsWN8n0cQ8GrFD6HbRE2FfrSch8O7vtKqOWc72OTWnMP1cKrUqUqluuz688Ck03zzoWMEHfNuLj/DjHKgV1PAsOLJVMjP/JpXL7MbfzGb7pC87opPJiLY3TH7XbvhBULWN4/kfVzXPH8e01sjkUeTV3bIaotfPv+dhnMmbo2Gq942HUKBxqaWz0NKdry9AjMf89lvR28y6wDZVMpsdi/RnykYaDl5RWmChlHDAXvd1Oc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5341f8e-51f5-4782-0314-08dc9c56f4ca
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 18:27:26.8558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z05dpTnnMJ+hajWPwozwqt/06k7Z4/bCKjExr0lyOM1cbD3ymVrTPukZCNAi2YbK3jhvbpfgZQswcCiw2XcI7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4242
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_14,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407040134
X-Proofpoint-GUID: jnZgk6_cF00Lr_d2tcDIcbLC4gG6xUxw
X-Proofpoint-ORIG-GUID: jnZgk6_cF00Lr_d2tcDIcbLC4gG6xUxw

Extract clean up of failed munmap() operations from
do_vmi_align_munmap().  This simplifies later patches in the series.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 28a46d9ddde0..d572e1ff8255 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2586,6 +2586,25 @@ struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
 			 vma->vm_userfaultfd_ctx, anon_vma_name(vma));
 }
 
+/*
+ * abort_munmap_vmas - Undo any munmap work and free resources
+ *
+ * Reattach detached vmas, free up maple tree used to track the vmas.
+ */
+static inline void abort_munmap_vmas(struct ma_state *mas_detach)
+{
+	struct vm_area_struct *vma;
+	int limit;
+
+	limit = mas_detach->index;
+	mas_set(mas_detach, 0);
+	/* Re-attach any detached VMAs */
+	mas_for_each(mas_detach, vma, limit)
+		vma_mark_detached(vma, false);
+
+	__mt_destroy(mas_detach->tree);
+}
+
 /*
  * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
  * @vmi: The vma iterator
@@ -2740,11 +2759,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 userfaultfd_error:
 munmap_gather_failed:
 end_split_failed:
-	mas_set(&mas_detach, 0);
-	mas_for_each(&mas_detach, next, end)
-		vma_mark_detached(next, false);
-
-	__mt_destroy(&mt_detach);
+	abort_munmap_vmas(&mas_detach);
 start_split_failed:
 map_count_exceeded:
 	validate_mm(mm);
-- 
2.43.0


