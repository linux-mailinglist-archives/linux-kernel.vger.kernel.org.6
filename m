Return-Path: <linux-kernel+bounces-294710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0DB959180
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 02:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80C1E1C2219E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 00:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA281D175D;
	Tue, 20 Aug 2024 23:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZfOvuFj7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="u8eB7jhT"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BBF1C9DE8
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 23:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724198318; cv=fail; b=poCE+B1eLHW9zap0FEMVWAcJOSHAZSg7np+eLk4pYvCcyrU2HwXzgxFnSMeqyQGkO00DMLoHdQ4XB4wBsbRmytZf+qo7Trn5f+Hbpdj3XtypeFJWVARpAF9ApcYlQC5wQYAcERCviNHInmr/3yE2Ps1TvCFeXGMX3+urkHkUwqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724198318; c=relaxed/simple;
	bh=/UhV76oRzT90/7dx53Qpud+rXKJQgoTQFzl13w8FHuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F+GLi8qIg1zAOzt06rMh48JZjbxXBgbhOhjw6jTrek1HQO0dGsxYQvv34CQ96R5CRCm26lDt5WfQSvDx4Eqg44crCEtAUJ+P3NLVHy0m7v+YxCQsgvYeC3CQfEpnhzizbx4d48cd5j681AfESI5prhLSxTEHhY4EqglNWYl/aS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZfOvuFj7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=u8eB7jhT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47KMBcPu020559;
	Tue, 20 Aug 2024 23:58:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=EWVcmdCv6OHRg79PF5x6IE9evbHP3bBXy2AOJMFbKk4=; b=
	ZfOvuFj7HCqOPafvn7Jzy82ldOfAyAEkajQq3kualkObP7E9F1dlFmCX4387hEOC
	Pv9J8cJqg2xr1nCHIG8dA6TENsSbIapjKsSOGeKRlQcaVt34xlMSdrl+JRijQbG6
	LIEPo8i1ED/5OTuFzWbAXPaV5fP/WcZ4UF4/Rx061SI1RLZI+wsxthCvMaQbF7Lp
	yL57JBm2SQkz+pK/Rbaz3mPOcvvOk9Vq5GzBk72c/zPvTlwwpsBmBRMERSlOFAMQ
	mvVQveXlHsjXiclcYF/JWaONm4k+9Hk2jaO7IwOLtNt6KRoCfvba+SRKTcW7LJdS
	uFAmudKcHin0STBXCTDw4g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m6ged2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 23:58:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47KNY1IP023382;
	Tue, 20 Aug 2024 23:58:22 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4154x78g2k-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 23:58:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dZRMpb0YAYbfZ4cte/6Vm6erZVIAaDLgsWPOVnOtchx+vdMJVkK4uys7suAj79IyP1NP0bvukYr8jVBrORwtsfiyw+1HrCZtdQt+8pX2kMaN0qIqJcFkbBwm9SR7JY2FLQLobE5b5FqC+NtDvJ7WmySNC0nkmZCPa4kpmeF03Vue8TlnhPW2nWfJ/C+4lvKWeuBMaO+vUtAAB9zfn+1YxsvcsUa/hxDoBuA4BZiUx3J2Fyo8tk9SdkTPmU4vuv3/w3ocagDB9BGaUHfcfDyX5C67JPVsiIToxLczRdal+NkKseW2nFwke/VkR6lvhhmFgTx8kAU5hOOwkb3BOcH5sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWVcmdCv6OHRg79PF5x6IE9evbHP3bBXy2AOJMFbKk4=;
 b=E0gnUvgHi5uN0x0lK6QMgKxuhsPTWg2XYd+9qrz/zjG8yC93OHCuxiC9gvParyqSQlnSZH4oJk42ENIpuY1vM55lnu33iNbaF+Bz6EZcOI88Hv+vZxdd6cdPJo5fxKKCqoDdg/emfK2IpzX5yZG6ArFP6qqi3oANOYGAUO5LI7IGAJrbRl1/K14cZwm+4ayEnvbuL+WqtyCDV6xsjKMguwsW8SxofdVE3BDS6OVYMWKoa6pGwHUC14gRmVbpKrnFqG2EY4PP4sEZjFDrR12Fwj8i0QKk1+3h0A5hT8AGU6YRk81cgphf1tFdiIKdaJrdzUzUOJlhaO/+sbO3NN5PAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWVcmdCv6OHRg79PF5x6IE9evbHP3bBXy2AOJMFbKk4=;
 b=u8eB7jhTVMV9IWBXU8owQjwY/zPUIEwmpZc7Ky5WP2YfSbIFhmCeRemy/7+dL86bdOkV4+ONzHqJ2Upx3yt0PvtLuMrnbxVmzbQbT5+I2hHiphB0spN2+Rh64GRQJm2b+WKa0H6WFGYJI7DCYBAyR3LgMHRN+UqJimUHVvm4emM=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH0PR10MB7099.namprd10.prod.outlook.com (2603:10b6:510:26d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Tue, 20 Aug
 2024 23:58:20 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7897.010; Tue, 20 Aug 2024
 23:58:20 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v6 18/20] ipc/shm, mm: Drop do_vma_munmap()
Date: Tue, 20 Aug 2024 19:57:27 -0400
Message-ID: <20240820235730.2852400-19-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240820235730.2852400-1-Liam.Howlett@oracle.com>
References: <20240820235730.2852400-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0112.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::21) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH0PR10MB7099:EE_
X-MS-Office365-Filtering-Correlation-Id: fa6d7fe5-eae1-4e3c-db54-08dcc173f7bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6LVwbIafcDc0iNlZ21x8fKfjDJRBzf/zeZRerIw49tZ7LMEiLdN+gRYimnzM?=
 =?us-ascii?Q?d6pxPL55CzTYqMJgQOOwDcmvpurJNNE2qQsZJ+B4jmqP8CCVvHe5tuV2JBxX?=
 =?us-ascii?Q?4wAs4dungNG5UfEygtdRWzbragJh09wLnSCD+UNBwo0Y8hzWWQ2IYJAeA0RN?=
 =?us-ascii?Q?Mg4w53JEnGV5ydk0t3+KsthMutiiLfW4JDy21FRCO9XvayJMiX/xGn5KUkoJ?=
 =?us-ascii?Q?yIdrPuPcdkSl1WG8UPNgld0LeCQ9Ty184nSPVDkKciZWkBh1L4Rh9sGX7BA7?=
 =?us-ascii?Q?hekD+7EyUvomFa9WNFaGo0JrUQJO3N6Nr0H12MQ7gfh2d0FysN3ckcwwd5RZ?=
 =?us-ascii?Q?EVvSrEkufjPOJaQigSerhzTkXHSWh8xSZDdp2iN6EGNh5nHdTtc0uxpLTKaU?=
 =?us-ascii?Q?JmEf9pduMRRhDSDBJ+mHJQWUI/kd/o/blH6Bey9UC0Om20dfhXz9faO4Es+D?=
 =?us-ascii?Q?/YDN8SPRyIRAFtAvWE2VX+y7NoKyGe8r+RC7vJNBwByFCsqhoAUnz+gyBVVq?=
 =?us-ascii?Q?v93Vt8dNtlVLseQcTH5lMJFU2UUKW36X0Mdt6/zL6+VV92zCOY9+cJLKqBBq?=
 =?us-ascii?Q?SQtQ1ELIqeZyYsecAoqZW/BRWLtzh1HQqNhU5yea/U0fGUY0rhcBbEfUm6wR?=
 =?us-ascii?Q?j9zWo83He8CPhgpviNrBB4TvaOKxJPS+WYxM9hJ8FyncJdv5qfHYJ0rmh/B8?=
 =?us-ascii?Q?fFnvTV0iDmPxjQWU46JeVaVONOAik2joE3DwKn4KidEgxstFECtFNYG9Yjq0?=
 =?us-ascii?Q?3AOXvtyUfSUsITX3QB0a6vTNI7/2/4XrjumWxS9Fj6ayOI89y1S9tU7MGjYc?=
 =?us-ascii?Q?a4+wePrngg0nqoyHDhbxX3VPnjCkM3z+iEmuluYtbWJwP9Ed2grx1TnN+mmd?=
 =?us-ascii?Q?AmZx7CYszoeS0Wv+JsuBU9PIrlTPIEXb1nbkRkrecy+TKRCLFFwO7RSvO0YM?=
 =?us-ascii?Q?nOScQQBFtNQdwA0fEp8FavGttLxFh1OvmfYwSnZMD6hFxz1Jyx4mSHLQXpvW?=
 =?us-ascii?Q?J1ONXaFEdyVY4zOQhBNSem0gIFsbYwX7jsTIFjsLIf3vB7duvkKgUs+4Q0lX?=
 =?us-ascii?Q?gSSVTJa2LoupxffNuLYxrpFRN/VD8ULQLZLrztB5WOQme1a7MUTOMZrQvLOL?=
 =?us-ascii?Q?QSE36fOMkF7XopRrxgVu0nZSN5pa26QfsBhuxv9k2U5/84Gy644mn+h9m3aR?=
 =?us-ascii?Q?xyCz3R5TvlH7NMw6vUonZbvIo8Qvgtk4GH38F8yoPUnKws1O2Kb0QGRN2fVy?=
 =?us-ascii?Q?TgnOpYZBxpcSah+7tezR3rzCC3roORmObk9HNKfIvcBjINu5u72m2ajdDfsU?=
 =?us-ascii?Q?V2L7T2Fil1rgGigvKtCDySoPJ3Z6mZIgzSKEqG9ZZzdHHQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LsDsvW6MO+E+enUC1RlBwf/1+4AXmblDSvnDJab0lb74H4qUdwsYoBVf26C3?=
 =?us-ascii?Q?fcvMT3WGxVFGa7ecZlpVrt2SzH8qVLH1mPnP3ePX/WviZbv4A6u7tqC1QgSJ?=
 =?us-ascii?Q?1FLW2+5hlFRnQmW1iBNMKI8fmgWi3S+Y1Op6MwH1PvZPcc2EouK4lw3k5g3T?=
 =?us-ascii?Q?IEfGmIYYPOV+BSe9jwdS6z3tDTTCKSx8JltItU53DbP7cGprBy/falbDmEGP?=
 =?us-ascii?Q?dDOFssiO2/AaLrZEXQBimAR++wOCXwLvoFcak3s+KU2b0CVrU5kvAYqk6x0z?=
 =?us-ascii?Q?H3I8e4WjBA+jlJhfhzJ8skjzCJVSSJT2r0KFWaPo7/0DhGzStTAMb3hKvn/Z?=
 =?us-ascii?Q?S6l53QMwhSRfE/u/2dc4clKXCwQNs4pEdlytnUsbwljEyJ+zH/VPRH3BXhxI?=
 =?us-ascii?Q?gkai/0gt6PySsTJv4X9xHFianA5gDA3tPLc/9yYnFU1cC9MxA/7EjdpMaRXV?=
 =?us-ascii?Q?8Wli+97lyTt5iw6o9G2QzuubqFJ0sLIoRFPvBVVIvSdZW/Zf+CpXToWKCuCP?=
 =?us-ascii?Q?H+OpxjhsqfIKv2ohpIGg2vop9bXrlMf+qZg6yZxqw6IcombXLuGsE5OL25GQ?=
 =?us-ascii?Q?Slz6MNPyylnx1Z1vJP7TYX2AR7EAZgE0vHyexDe+03oODT7rvHZRe/K74MhU?=
 =?us-ascii?Q?qe+qLpRdhMZvSRrfyqQNyDm7Oa8/LqCr1244BpPZNjEsrraVJ3RIwzWGcbCN?=
 =?us-ascii?Q?rKEOVko8vg4RaZC5ypMmjuWL3rTNwuvQOrUBGj5gTTMNVgGkAO7+ZTKpOAgD?=
 =?us-ascii?Q?HLyOV3LxKmPj/C98mudyHel8HyPx8DZBSXHd5IlQBT0+SBGjbaCegUJV4nkI?=
 =?us-ascii?Q?GhIPTNZQmfIsHSvAEQTiqMFMO/MZfNqjVPszVFQIyRSPJtT4tzR06wU2ParC?=
 =?us-ascii?Q?JLJuRXfNa8Xf7NqSVOtuYxukWM3HXF1z/8Bwvwtoeh+vQgzs/B8m5w1dIUse?=
 =?us-ascii?Q?XAAQj7moG7ycPvWJrE8JH/r63gZdpy9PCPnSvxoV97hgwHvtdkGepuwv44Ui?=
 =?us-ascii?Q?SYHNy2ERsFBz+tq2BKMPD7W+wDbtJwZX0oDExtz+waK3Mp4PrqHCqJBTVJS2?=
 =?us-ascii?Q?sTgxwOqLgpdoBNqQZd5WIPIQ/6MC0zZUJAmHIMHlOf14N4K8ZV+rl63uCtHJ?=
 =?us-ascii?Q?X3xn49mR23Fq9oSInTYvK4wEYF9F/yfDGnSuXCEhn393Uv8CJqMfQvxALUyl?=
 =?us-ascii?Q?aRuxmTTdqqYgA6VRL+ej36Dx1bv0y/hjn7Pjr9HCOEgMIU+GRQg7ScPZyxff?=
 =?us-ascii?Q?J9dR0H9KXv6HW2N8dMVIjoQNEg/hm7ZSQRH0qiWkDhfz+V+3WWC7XMwfBRvg?=
 =?us-ascii?Q?xCktLqCkGumP7Ht8JZ60clzGY1ljNDXo7uRRHL7YSEPwJUqMXPxgqPA76YxX?=
 =?us-ascii?Q?+CprAfsx8LJjUUAsobJC7J56kLm6f7kolG5YNMX4vx1vjR9jOLFM8qvvAi3O?=
 =?us-ascii?Q?O7bCrcw77U90bsaU9wn97Zsk/VxcHy2AvYNRf2rPZdi30uCJHYtKzqIjBNOP?=
 =?us-ascii?Q?g3w1BM9lsREVCOobw3dKrr67/wzuOvmt9j5gKkU/WDJ116n1gUpfdMtZ5SGb?=
 =?us-ascii?Q?UOLLhVjVHNO/rUZ5gaAB/KsTe566E6aRocoZZ/O5ZTPnQZjVOlYnlzQ91GS5?=
 =?us-ascii?Q?YQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mizp6SsR3eTLqBxG+LcDLHb5OzfUhjxHh7nNUz0dsY7pbhn1aeUPwqwVcvQ8QNN86/RT4yFluvGX7lw+XbYbgzXYOO2e3FTQyvQoQFleUCj3vtD26H6RIVUpsqmljxQAgUvKyAr6XAitAkWZBSzzfqiss94cxks3PoTs2AAnlZC0ZPUiqrqPS3uPLqnDldKV8VSGPAxjPcsUC4FdaMYpe85/1NvCLJvqbzfNx5bQC6nI35wx+aMZE3Fe4SUaiL1BJ4huI/6gGRP6oBfQngH37PKcvsOZFKHqJeNZF2sXVAPvxlO1j4KjB5wjOLzJ0vYXvN5Wdzop0erxa+IkCgO0BeFids1BiGPi4vHedWpdyTWnaSqTPPMkdc1LHSJ8f/5NPdJLh/R3SBKtmD4OQshB7NwnV+IZGcHVfWovTKZKewQqY90wuW0D5RezkAkRugIRh9+GwrP7csNav3J1zPcNoAVdzhyA2Ma6awzEUAJm63ExViKRqhunvf7OHaiAh0GI8gpDFnvQhrvrfE40a6DNt0Uv4XJ6UvMrDpqnQ5EFUjY4uvTC50Z3gwdVx0tXI4IYALtFdvia+bL1jSI98JggbjEuSWSfEtPv0EQtHHg9hcU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa6d7fe5-eae1-4e3c-db54-08dcc173f7bf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 23:58:20.2922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bc4rtpKYqnS+aP+epn94VL04fIP0685pa011VtzUQ1j5TZ6ZgiJwm1QlMt4cDp02HRTN2S8lbmrmQJQXzJJRmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7099
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-20_18,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408200176
X-Proofpoint-ORIG-GUID: tkW86oKwPfYLhRT9IJ18ca3GRDi3ymhj
X-Proofpoint-GUID: tkW86oKwPfYLhRT9IJ18ca3GRDi3ymhj

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The do_vma_munmap() wrapper existed for callers that didn't have a vma
iterator and needed to check the vma mseal status prior to calling the
underlying munmap().  All callers now use a vma iterator and since the
mseal check has been moved to do_vmi_align_munmap() and the vmas are
aligned, this function can just be called instead.

do_vmi_align_munmap() can no longer be static as ipc/shm is using it and
it is exported via the mm.h header.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 include/linux/mm.h |  6 +++---
 ipc/shm.c          |  8 ++++----
 mm/mmap.c          | 29 ++++-------------------------
 3 files changed, 11 insertions(+), 32 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index b1eed30fdc06..c5a83d9d1110 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3292,14 +3292,14 @@ extern unsigned long do_mmap(struct file *file, unsigned long addr,
 extern int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 			 unsigned long start, size_t len, struct list_head *uf,
 			 bool unlock);
+extern int do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
+		    struct mm_struct *mm, unsigned long start,
+		    unsigned long end, struct list_head *uf, bool unlock);
 extern int do_munmap(struct mm_struct *, unsigned long, size_t,
 		     struct list_head *uf);
 extern int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int behavior);
 
 #ifdef CONFIG_MMU
-extern int do_vma_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
-			 unsigned long start, unsigned long end,
-			 struct list_head *uf, bool unlock);
 extern int __mm_populate(unsigned long addr, unsigned long len,
 			 int ignore_errors);
 static inline void mm_populate(unsigned long addr, unsigned long len)
diff --git a/ipc/shm.c b/ipc/shm.c
index 3e3071252dac..99564c870084 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -1778,8 +1778,8 @@ long ksys_shmdt(char __user *shmaddr)
 			 */
 			file = vma->vm_file;
 			size = i_size_read(file_inode(vma->vm_file));
-			do_vma_munmap(&vmi, vma, vma->vm_start, vma->vm_end,
-				      NULL, false);
+			do_vmi_align_munmap(&vmi, vma, mm, vma->vm_start,
+					    vma->vm_end, NULL, false);
 			/*
 			 * We discovered the size of the shm segment, so
 			 * break out of here and fall through to the next
@@ -1803,8 +1803,8 @@ long ksys_shmdt(char __user *shmaddr)
 		if ((vma->vm_ops == &shm_vm_ops) &&
 		    ((vma->vm_start - addr)/PAGE_SIZE == vma->vm_pgoff) &&
 		    (vma->vm_file == file)) {
-			do_vma_munmap(&vmi, vma, vma->vm_start, vma->vm_end,
-				      NULL, false);
+			do_vmi_align_munmap(&vmi, vma, mm, vma->vm_start,
+					    vma->vm_end, NULL, false);
 		}
 
 		vma = vma_next(&vmi);
diff --git a/mm/mmap.c b/mm/mmap.c
index 2a4f1df96f94..49d9e95f42f5 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -169,11 +169,12 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 			goto out; /* mapping intersects with an existing non-brk vma. */
 		/*
 		 * mm->brk must be protected by write mmap_lock.
-		 * do_vma_munmap() will drop the lock on success,  so update it
-		 * before calling do_vma_munmap().
+		 * do_vmi_align_munmap() will drop the lock on success,  so
+		 * update it before calling do_vma_munmap().
 		 */
 		mm->brk = brk;
-		if (do_vma_munmap(&vmi, brkvma, newbrk, oldbrk, &uf, true))
+		if (do_vmi_align_munmap(&vmi, brkvma, mm, newbrk, oldbrk, &uf,
+					/* unlock = */ true))
 			goto out;
 
 		goto success_unlocked;
@@ -1742,28 +1743,6 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 	return ret;
 }
 
-/*
- * do_vma_munmap() - Unmap a full or partial vma.
- * @vmi: The vma iterator pointing at the vma
- * @vma: The first vma to be munmapped
- * @start: the start of the address to unmap
- * @end: The end of the address to unmap
- * @uf: The userfaultfd list_head
- * @unlock: Drop the lock on success
- *
- * unmaps a VMA mapping when the vma iterator is already in position.
- * Does not handle alignment.
- *
- * Return: 0 on success drops the lock of so directed, error on failure and will
- * still hold the lock.
- */
-int do_vma_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
-		unsigned long start, unsigned long end, struct list_head *uf,
-		bool unlock)
-{
-	return do_vmi_align_munmap(vmi, vma, vma->vm_mm, start, end, uf, unlock);
-}
-
 /*
  * do_brk_flags() - Increase the brk vma if the flags match.
  * @vmi: The vma iterator
-- 
2.43.0


