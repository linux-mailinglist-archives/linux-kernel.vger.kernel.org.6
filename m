Return-Path: <linux-kernel+bounces-555980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8840FA5BF02
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23D97188893F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0D0241682;
	Tue, 11 Mar 2025 11:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Izhc1lc5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FmbLC9Vx"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2621B254861
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 11:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741692604; cv=fail; b=DR36WmqnHrxJZM8JHQWsyLHpBRooOZqYMpYoR7/MHk8dL0Kt10g5j3u3DUu7akor+0+BS2V8YqcfouTqrYqq0q0aIwGwry4z96dwPJEkyj1A98lCJJqoH++MpNH7wCYvGIVtNzuB/SDVfL5KVPTyNTo3z0VeAN4M8o/3WGChhuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741692604; c=relaxed/simple;
	bh=EDMTAHyAnnMmYplQ/3jdi2vs2y2Pl1Jd4AyuM6kC/RA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e1mdjHZLHCVV2o3GYEJ9aSnypdXZ7HPKa0UBBjIEaT0H5DE9RLdLyGKG0xJIHoYmeldeOGS5Qc8i815K5AmChwk4ONdTso67W2FmsqNYgfokuRipcO2nEc53ViwBX9VzElawmBaQ36btuz6gM5cenkzFinhaCvslOWLPXdSMW5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Izhc1lc5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FmbLC9Vx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52B1fqlc013378;
	Tue, 11 Mar 2025 11:29:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=vkY2e2tICmhBu70Pd5
	loGVqWwzXdYNSZXvQVCdfBawc=; b=Izhc1lc5puriLO5/OcZhtlRvcEpYUiGNmI
	VQ/ya5r8v6I7a9tVoqbZeh7auOWdFUJGoFNCS2LbQhcFR2w8zz0/e4FRa1qW+FGR
	97ntzkCOPYgzGnP7OcEWXaL5uMzqnmcYTHD24h7yunxaXf9BTZSXnVqgdcAW/ZCU
	PIqnvT/rYy8HtCVr5HiWKYYNqJLHpn1SoPPOeu5ywpjuG2T5IEi4OSA2tl6d3/hf
	Dnt5vZObZPwnl3p+SCY4Jw5z52FoqeZ4EyRGxc6srBVxfKwmn8BII9gbD5FRwcWs
	QvTeBamWkqF2OTYZyDgCal+MgqxbcqgzvQO8emDtanKH/vYJ2YxQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458dgt4j2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 11:29:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52B9FJNM030561;
	Tue, 11 Mar 2025 11:29:25 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 458gcn89a8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 11:29:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QPNn4Dglu9oZ0K7HjN1REy471SNwqx8ubqT5/BcQQxPPDrTRZtDmXy8w3a1DShYTzRXuFpm+FDLXifk6zi83nt/8Z79Rp+beBDlsvkmYLm2Y0318LmQFEH1SgdrJXvwevVHZk4YSrMLcECkv8I7DdTaVFaVzQuyVYKGH5W5XM4P/O3Yk6vBaIHbjQC/YnTVxQUszHNntYeIgUMfmP1VyjrajO5u3pyr3kurHTA6+ooSAdakqjG7VC83cTU9OCBzDdRcfNaYm64ObQwbjmAwgEcsQ8hbUPUxu8K8JD7ItzAHAS+DaDxUGQ19N64c/2GSc11WJodTjrIy2m/sskHqxLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkY2e2tICmhBu70Pd5loGVqWwzXdYNSZXvQVCdfBawc=;
 b=LPQcbso3StLMwIM+dagXtXuUm16oYtbnUKZAo5Rw2605Db/NLrMHdAEZ2PE6Fha8EWheFIVSbQNk9+DA0B4BwEXoF/bttselKqxq+aXqtGuxc0MHALuaJKzeUnaEc1Yr7N2BKOfZKJHofoB+acYWi+C1+FLwXTpi1bvVBq2pQW1QwqYGIbm5g/7lMUZDlsj8d037SzrzNT882hMOTE2wDMNpmy8TzA19pYj0km/lNhm3PDkNRjWc0LAyL9970Io2I1d7S/5sWeAGIkCELq5LAaO5jmamn7/HWwD9h41ogboKK3JYCUsWRxkxBsUNuOZzK1tLq89PH5vq4MWWVSAvUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkY2e2tICmhBu70Pd5loGVqWwzXdYNSZXvQVCdfBawc=;
 b=FmbLC9VxNKR8AbvYyc6Yd9mIfUg2THGcFZ6o9jMMveGFF0Xvgbv72jGbeWJVU6KOsqxubN6u8sHTVAQPqcdLeMCtWTHi46aM4xV8b6VipgezD9OmeiMgnLP1ly+0qSQ2aftga8H9sDPlGU098BxVVn1r7/2uGH2pWvTF9UkzrDc=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by IA1PR10MB6097.namprd10.prod.outlook.com (2603:10b6:208:3ae::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.22; Tue, 11 Mar
 2025 11:29:21 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Tue, 11 Mar 2025
 11:29:21 +0000
Date: Tue, 11 Mar 2025 11:29:19 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <howlett@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/9] mm/madvise: split out populate behavior check logic
Message-ID: <e327026f-22bd-45fd-b3e5-fbf7246c3ec4@lucifer.local>
References: <20250310172318.653630-1-sj@kernel.org>
 <20250310172318.653630-3-sj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310172318.653630-3-sj@kernel.org>
X-ClientProxiedBy: LO4P123CA0264.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::17) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|IA1PR10MB6097:EE_
X-MS-Office365-Filtering-Correlation-Id: 38d70256-0dc7-4268-039c-08dd608ff82a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tQkkRX96E9MD0eSPg3wmXLSZ88zNCDYx5emBSKtvlRjy8vK3qmZxSzKRWo0C?=
 =?us-ascii?Q?d6iOmGvn7/EGFh7FUQ0qdjBrOwBcNnQMZuURWSu0xSwzzL/8wmPKqAjWOb0w?=
 =?us-ascii?Q?xSd1RXLtoKPravXm8qYU8V6UMj8IWH66z0DQ6fH9PmO69nS5m/9a/3tFK+Ox?=
 =?us-ascii?Q?tsuxc14PzbJIPdPaOY+IMl3F0qe2kqrGl0//DiIdpNkqcXia6q5GVP3H2Hyg?=
 =?us-ascii?Q?3jsToN6gCmg0A00tAiyDStXYRZhnZiRO77a2/V6HhEnciugQKW5HQjGa0XYr?=
 =?us-ascii?Q?9q5Kcs5hUBjmvh2rx4gE1l8oXlVEhKp9FxCzz/w4FPW7VOKcJFPN+v/yV7HJ?=
 =?us-ascii?Q?gm9yzVPd/73kPj3sw97ihZH7CaekkQ7d4pcfxXML+jIVwkYrdPHpurvSR9Vj?=
 =?us-ascii?Q?JwGEnAsccbpI81ybKA5WGYp2cNOYwOtxG1m1SnKTzAaOWbG8A3oZZovJB6El?=
 =?us-ascii?Q?k2XuJyS5Dvb/pudWlA3dHrIw3rJwPMYgO2MzeLueJfjB2nQRhTrW3/i/a2GI?=
 =?us-ascii?Q?M1MfGaMwqV4sFjgejdKluBZ2KKLQsnG8EwFb8jlhrCjXc8tbTYy3U8P8oBaM?=
 =?us-ascii?Q?QVOk0trEiEyZgYOMMoyRiXZaEj3nTzJqEPidUtaDD9dQENqmPtqbWxECnqGd?=
 =?us-ascii?Q?r1Sy4T1hn4XBdEZ9lJ2yose06/QTIGcj+IBQYIBp0s3mDtloYDHYy/lmRKeN?=
 =?us-ascii?Q?n6YQYCB7X+5jwePwxSo/OUdbQB398N5PXwpWNjgRCV5g6nkKD8MMgYndDU9c?=
 =?us-ascii?Q?bhdQM9B8I6ru4sg9vTE4pK79vEOc+a9Lr7zsUf6cCQaxNo7wYKrbAwek/Wjr?=
 =?us-ascii?Q?IiNnyhjiQlH3xs+7shECiTFf2qaLsUYUsycuX1k6dqlG3q6YbVrebcZXgz6V?=
 =?us-ascii?Q?dZBRltaD13kGsj2VmUOfvTjf3PvlTk6Zu/Bg6jeWmn6ZSd94jM2FlU6VRCYi?=
 =?us-ascii?Q?KN6bAqVNrGCJC3IZ8DoXVSOmukgw+mdMAlYbZHDcanrTHgUlzjhWEAXFxtMc?=
 =?us-ascii?Q?ycWF4Uo0BP3gJNm1+pjRAnfFHUdkW+KM9TF3TMwiNKRHEO7OCuB9RlnCF79P?=
 =?us-ascii?Q?gyfkZHokNhIvAhpzvq2eAONVq6VlCAl7FYAf2/rnkjD836ZDJV4uVKJLCPKl?=
 =?us-ascii?Q?2doFAbGczvqggmKZ5ZJU6dF62neiqA6o5KVwroXf4OqOTicKNYgq9txdi+cg?=
 =?us-ascii?Q?7eDMOrgRMfSilRw4RXU/tUwh2+kPFp54w+mRzOWa2//HIXGxrgF1tWCNUO/Y?=
 =?us-ascii?Q?wfyivlyK9wQqDlodk8AZ9Ipkx0svZsnTnS8DOC2bt/a4OTU9GkCOKooDPV45?=
 =?us-ascii?Q?6k1LDN9Fs+qrC1wGvDt4KfrT0u1W8RHgsKiiJyZvFsIinMIKAFULLbd3YCkZ?=
 =?us-ascii?Q?OLuMrwa4U5f9eYi5WICiSVltGo3u?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hIkwO3IMIdvAov51/4IHXnf9oF7oFiTicYS/ajeWy1CLrapHHA54Gv86Biak?=
 =?us-ascii?Q?40UkNplbk25aL82O66h57ZZxfWrWQhmXR0k6nDZnjCMUfhoLcAYroyraC63o?=
 =?us-ascii?Q?sAecBSxXDd2cS2T3t95CyNd0od4yNb2orjLh4qeprT3qVSyMm4+Dm7Rm6tuZ?=
 =?us-ascii?Q?iNnTufbvbfMT3PNUgoPzxRx93zHNPZgQ6zchmIVELCMdIJH4SPX2M4w8sTHr?=
 =?us-ascii?Q?wyAxp0q0u8dFi3mT2a6+qPseRYddngySCANcPMCu0m3YQj96YmGbTnIszftY?=
 =?us-ascii?Q?brg+sAZiL2NOkCgphon3iyQSP+6vNKlIY2k8TE0fvXnaAFjLzrMW1vebamg/?=
 =?us-ascii?Q?p3tj578cEzFjzfZglLXZP27ts+FGkf3vtMN6z/SR6qPgDJVcj8nUQd4yPfAZ?=
 =?us-ascii?Q?FWRjTOkPmDCRasPtuTcbI2yZ0vqXw35vxseSAjyOwn8+JjrobdnviDIaTWsv?=
 =?us-ascii?Q?tkBf8p7HYFTxPTX+lTHJoDNRPFvoGNcnduL7Um0vAdvvTH+Q6BYFryimYNre?=
 =?us-ascii?Q?6CydDSEH77CU3jpCi/zxF9UzSNuaJgp8Oj5XWlEpFs+CWJSJARBq9MOHFerC?=
 =?us-ascii?Q?Pk0/TvTLhcVU2ttYrGrw3smJimU64YRV/hTzxfctejFU1+//etjmp1m4yNXt?=
 =?us-ascii?Q?EMUeeiOiNcxAKFJt4AbSwLC4Cvjxf1hTl1N2kccwoyC782AznFW+N0hKzReM?=
 =?us-ascii?Q?9T5RYu+KPFGH5FnP/IX6T9Ig5za9rNtag9ZAJvGSR2ezuI7vbrv2+07Hdzn7?=
 =?us-ascii?Q?C3cEPYUElSBgoT/uuyC1uE+Kj04UpXxtgMy7h9rMLqWtc7oqQzkP8dqME28F?=
 =?us-ascii?Q?XvEYSFKKi2S0YICjUA+Q46NpWtS9RFrGhD9Jms4EzkNDhbglJlJ9ppVKQblo?=
 =?us-ascii?Q?a4uNmjGdbuZktM6CjSYmzgm26CtRWrqgtH4KUMCRkuv+t5yslOjT3mZzmqpY?=
 =?us-ascii?Q?Y+8x8oR3Hyx/JZyRNDQcwk4Kcq/0Anzs02ft52CXUjWZ15Djcts4MCN17lxa?=
 =?us-ascii?Q?OG9AXWy4rV2KupNj3FvRE6UNFwHAhqOlhlbLOvg2BAxG43AkAcVK27rzCQDr?=
 =?us-ascii?Q?1nTC4PN5U50EjsJr1jLCb6wy3PL/eYym9Tv3ZYMmJbFQ8isllETKLQ7RCLko?=
 =?us-ascii?Q?dh3vwzY0jU6WbW23ODPm+4BY3QH72wehykumF4lUcIQ0H+w6uXLhuPLFxk6k?=
 =?us-ascii?Q?LGimwEJxzEpMpixkrX4h+zwqjrymQAyxT54hIvgFxsd6VcjoGgwWsgfURAy8?=
 =?us-ascii?Q?e2FxY2np1C3chsQwl81mBbWll+beXa9eTeXGUrrxc/3eptmMi/8ZsrtiSps5?=
 =?us-ascii?Q?GgmWALfICbNLpm+CIlc/YiEBPDRsscTXnOIOS1L/OIMAjzU5775IALlvZ5Qf?=
 =?us-ascii?Q?q0MceHKWjswEMAL8/WmGS4PuP+5DUdCBbFtUQfebs3rAVn/JupVT9FVegTeJ?=
 =?us-ascii?Q?5oRT4VRAyCMa7gR9TCCLsUFq4b9An26hFwqi8q/5Eg6fRU/e2YDvxpZiPM0P?=
 =?us-ascii?Q?yWZtWXYVhH1lwJKeQfQxn9GzJH0tuTH4MP4wnEVEMZl51LtCbEsMuCG6DuDm?=
 =?us-ascii?Q?rV60+nofWGXlOwgj/cEf9aDw0VRJdJSNlMSGObdSXZI7ukacwvFTsBBBLOID?=
 =?us-ascii?Q?Og=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+sWij1XLP1Gb9egNx7bMkNctNjFYuv/oPtHyUwm6S8gVJeIAxHQ345bdbx4j2sNoyU9LmvdYsLmpt6aJlra01my0QmdSuxFAOahJ6bXcFee+8b0UvK5LwOJXtrTfcip9EP6Aw/qeMMmhRsyFb2ogqXOnpenNdcC8EVoiLC0M1UB9TTEtyBBWP4HLodS9Yl3pPuXcOOsRZubJv7xzNzfD4B+D5CosetBjsZpY9aKi47SQzOHuQKBl5oj3Bk5bXvXG3oxunOviWaagUlKWjVkcgeaTyYw57MN4yKml1AELGcnuWuMkCV1D3eF8XZkvFVuyV7+a1XOF8UzsXOmOw6rl1Vo1IXb/aLnBQDkHkzwDdAaO8xqAxU7GItx07NDS+aCSFVUa0lKy9y0CI2YyftW81sC1LjC0ZonP//DchhgqSrKrXSG0M1s+VG2kjUqLaZOpv23G01jiNiKdvLGvWZPAIybowenkLki6gNqDHx30ctyCscRamM9jpr61wfOM79Dx4QhX9bnrznMceAc5qZGHSy8aaKyjlK4IvX5QzpkgeJVhlwJJv9xc1Ptam3Zo12T+qVxY07sSGzfhbtryTl52Ehn0jberZIVO+FfOFJZ9NHU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38d70256-0dc7-4268-039c-08dd608ff82a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 11:29:21.7957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HsXyVz9rY+jtPNskiPDKX4651Gm965jr6Wq25Vx2DPne4DiVlASC0piJbbCz7xiHBLZVS5DtOXuO5oJv44GjRAPsojZ9uxc1rdjxGEFVMZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6097
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_01,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503110075
X-Proofpoint-GUID: cqXesEU3ASptGmnZFKi-BCHJmULHYeLS
X-Proofpoint-ORIG-GUID: cqXesEU3ASptGmnZFKi-BCHJmULHYeLS

On Mon, Mar 10, 2025 at 10:23:11AM -0700, SeongJae Park wrote:
> madvise_do_behavior() has a long open-coded 'behavior' check for
> MADV_POPULATE_{READ,WRITE}.  It adds multiple layers[1] and make the
> code arguably take longer time to read.  Like is_memory_failure(), split
> out the check to a separate function.  This is not technically removing
> the additional layer but discourage further extending the switch-case.
> Also it makes madvise_do_behavior() code shorter and therefore easier to
> read.
>
> [1] https://lore.kernel.org/bd6d0bf1-c79e-46bd-a810-9791efb9ad73@lucifer.local
>
> Signed-off-by: SeongJae Park <sj@kernel.org>

LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  mm/madvise.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/mm/madvise.c b/mm/madvise.c
> index c3ab1f283b18..611db868ae38 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1640,6 +1640,17 @@ static bool is_valid_madvise(unsigned long start, size_t len_in, int behavior)
>  	return true;
>  }
>
> +static bool is_madvise_populate(int behavior)
> +{
> +	switch (behavior) {
> +	case MADV_POPULATE_READ:
> +	case MADV_POPULATE_WRITE:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
>  static int madvise_do_behavior(struct mm_struct *mm,
>  		unsigned long start, size_t len_in, size_t len, int behavior)
>  {
> @@ -1653,16 +1664,11 @@ static int madvise_do_behavior(struct mm_struct *mm,
>  	end = start + len;
>
>  	blk_start_plug(&plug);
> -	switch (behavior) {
> -	case MADV_POPULATE_READ:
> -	case MADV_POPULATE_WRITE:
> +	if (is_madvise_populate(behavior))
>  		error = madvise_populate(mm, start, end, behavior);
> -		break;
> -	default:
> +	else
>  		error = madvise_walk_vmas(mm, start, end, behavior,
>  					  madvise_vma_behavior);
> -		break;
> -	}
>  	blk_finish_plug(&plug);
>  	return error;
>  }
> --
> 2.39.5

