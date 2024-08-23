Return-Path: <linux-kernel+bounces-299595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2577595D759
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 22:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A69C1C2037D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 20:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61AF91946A0;
	Fri, 23 Aug 2024 20:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HV2ihxX+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lXllRYz4"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17BD1940B7
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 20:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724443658; cv=fail; b=kiiI9KUhQqVECVykrTuvCdW2hCr1nZbmKY7W/ZCuOkLnAmg4qJy2ZDW+wiTb2BjdsiXkkC1HFGcEb79P5QemRm8o3TBE9POC7A4c7crQNvZFZemZA2OTTVPgP4alAvM9jxwDMGhvYzc3JfhM23Zl9upbgsDepY9iR9T04jBZv4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724443658; c=relaxed/simple;
	bh=76yPAv+AbyvPZo9Ueo2w0/PkjV3UG82xC0zKR1K9EmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AzzWFpAJNGFj54eRMwukPg/Kkj0e15BxMFcG9UJMapFrA/M82ecywBUn3W6Zd6z6Bx1AVRSPm+Um/x+PWGoKimUUXL4fpmFVm30xMsoWZIJfQ2Vy9IEXADFCiLjOUYUbLvGPG3mk385yZk9fPAKIwkv8gdUOMkpP5f6acjPnYTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HV2ihxX+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lXllRYz4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47NH0VeS010832;
	Fri, 23 Aug 2024 20:07:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=vwvcGfY8z/E7d1LQNSWVyNbTzzeBCeH2vvP6/vUeckw=; b=
	HV2ihxX+uP90/5eHWEEQT/6B1lyeMZWyOC7rBW90k1r1YyGSdRsmlthN74kZSmuA
	Si05mw9vAeaL5jo9cD8lN5kyq9FF8wZfIdKleiUAPIy8Rl7ZPQgjv1Fhwks1zKz2
	SOBWOaeiNYQLV030+IRyW0p0njeW6sn6XaMprdINBGiBP88qPM5BAJidY8Z6ZiHg
	yDBe0s6S0KN8uLzao+ffYzxuIuRPrflHxcGDVAn0KoyFG7g+eKfIiXmrluY+40K5
	x+xcxcp1GrbYEKHSzGAFGgmTji+VdkKOw4CQd2mhUrjH1RxV1t9OOWtPlw/S6qni
	chD2IHMEuXCnrNUgRRxC3w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m4v56xy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 20:07:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47NJdFFc007123;
	Fri, 23 Aug 2024 20:07:25 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4170s610wk-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 20:07:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kudwNLhPTYnzIFub58tLNLqPO1YUtLisZCpdBwkyuqmLJ/hHlhW01IcIm5BzztrAv006yjvrDtj8vzSSJ/l/SkdnnAA4ij4a1xUJyosFdYAz/7aAVZYn1q943WSWXruXjHVY5xQIMi/4f6oh7JJwXyw4Dyo0FY/J3qDcX53Lj3jXBKfKUx5atan8Bcde2nsx9HuhlHM3MsJ6ljWs2zesdQHS71e4Adg0TyCOIq0YM8Dka0UI76J/B3LB40AdCfIUghXobfXctjdNEcZqGnGg8WRrbmmx828nkcvtjjPWQTmpT9U2S9AvhhMY5ntRQvnRapMEnCqByLUUlocjdJh/xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwvcGfY8z/E7d1LQNSWVyNbTzzeBCeH2vvP6/vUeckw=;
 b=M/ayX6QXiJXfpLgTG/jD2XZQBhnMJJWvUkwvHZ0LR8DBddzAU9ejMmJOGJ1FQPWhT0d/B7Js/TZ6mo2GgCWhXbgrDhOui0mVxiWcVSCarwXbKETOgrIRPjLxXXhQPUs6emKHV7MsQzMPrfmlypqSorg0a1o2zlriR+eOoRiZKTZ/xbXFdLmzKTcotit9ZnryWy3fV+k/BMIXLM8AHTl/2TBbiiUkrTDz8AN5y+xiki7mfrPDd6a3QVZVn1sKZnYpV+siekxXAUVl4vS8SHx5XckAa1CFSrVRjDAbuPrqNe0xzw4mPL6r7rmZfjHUTu6J2SeNdWKe5W5AUJ7PRO7qxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwvcGfY8z/E7d1LQNSWVyNbTzzeBCeH2vvP6/vUeckw=;
 b=lXllRYz4aW4blOGmmwR+8dSs0olmgdHk/jvvMSITwvd7Hidu5Q63VWloZMzna084EQmOmrXU0nOMjZz4+sBeY01P57bvAKsTKkVGf7w3l5MxK22bNQBGKtGYOhVC2cLpB/+2RctVX3TrjywctYWM6+wUciE8wtAjvV+1r/SjcxI=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by BL3PR10MB6187.namprd10.prod.outlook.com (2603:10b6:208:3be::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.17; Fri, 23 Aug
 2024 20:07:11 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 20:07:11 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v2 01/10] tools: improve vma test Makefile
Date: Fri, 23 Aug 2024 21:06:56 +0100
Message-ID: <31cdc7695e11b6588574431666d806e5d4e3a909.1724441678.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724441678.git.lorenzo.stoakes@oracle.com>
References: <cover.1724441678.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0189.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::14) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|BL3PR10MB6187:EE_
X-MS-Office365-Filtering-Correlation-Id: 22e7f207-62af-48c3-3a73-08dcc3af2c6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dr2oPIw5StTNo89m1RiSqBDPedK1zWNu23vbNRCu12Gga0iA1l5vhPBpzx/v?=
 =?us-ascii?Q?02tw8Fh84KFudtUP9NQBY8hvXeW1T/5QnFo2FgZ/E/g0hYi7hyrpSOkInk01?=
 =?us-ascii?Q?g+BJl1z+b4Hia0uZItnaLu0q+aRXJFsvRUpCXXeU3ZD99jfeD5SxYYQ8VNmA?=
 =?us-ascii?Q?/lxmsXDVLqq/800ABf/poUFnvWREWOXWWOdobWa5lmHH+icyVOGM0grXDhG/?=
 =?us-ascii?Q?jRy/cuWX1J9fiiFwooTnkRrsFvea0NHolbUphz3sgP2KfgZM6NnNlYDvmk42?=
 =?us-ascii?Q?6MYJxE/aHwSL3EkHmHEvBZwf1iU94QSUA5eKdeirmSswR44pkj8azTBLe8xg?=
 =?us-ascii?Q?6oRP+Amwwg4102sonByHTff5yYQ5NtNI5ICK4DOdcTlxRIdSNMQG93slFXf+?=
 =?us-ascii?Q?6glIyp1wcWS1bEaaMAxjtVEH0rJ7ihWxWBhMEtLZ0KDYb1Ke2EpZY7u+IZn9?=
 =?us-ascii?Q?gkQFsNFRCJiu0Yo7eMjBQZjrkptkVO2AJL2TuE67wvAx8i4IY85OnKiChD84?=
 =?us-ascii?Q?jQlD89zPcWocUUEentgaOaPbs9kFyrkBEPKcijAxNO0WekF7xxEYsogrqQG6?=
 =?us-ascii?Q?aZuACTMAmBffCj11K+dpaMNh0VN4mWoWQwnU65IMccqk2Lx8v33VI9Q8mM0u?=
 =?us-ascii?Q?PssS0lxkURiz+Hg3Gta8bD2ayRvt2unUIh5n9tXAS9vZGsDXa3r7VJyYyDDh?=
 =?us-ascii?Q?C5Ik2f65i7c+AF9YmvBT8YKHFtTwnKNpcAl2bIMCqnG2cl+qHtqRGS94XTqw?=
 =?us-ascii?Q?7QC+qnBOnDUn8LlmxR7+vGn+gVtYHVtC7zrfqSvagErOtRzdIYF91/y1zdY8?=
 =?us-ascii?Q?RgbQw+9qABQIfj9C9Ywwk43JHpunU/5HlwuuiG0MZ+B2alxiPgyJ8KHKHaZZ?=
 =?us-ascii?Q?F3sbXpJOvVmj0jM1aDM1++a9sd2N5CU1SXP4KDZveBSYUWv1wybaOSfcG3zJ?=
 =?us-ascii?Q?l/ZNrQu5dPe3KT26kNBpH0mQodi0LHZrTmMDeE7cqVBFFi7UreCVHK9vJrUS?=
 =?us-ascii?Q?ZxD7pWBixjOiJ9olvAD4lmu+UqzSfDMbmPQw8XSqIqafr293UlbR9YxVcGdV?=
 =?us-ascii?Q?JumpxzpXhtsmOPrSEUZIplU7o12WFbHo2p1dX0G/nJiwuq6R9+t0u3svDLXF?=
 =?us-ascii?Q?7kqKCQflL1JV2c1jRXG6t7BWq8R3lKeld3+rD+fG5cjkpvOyv8KT2aMc2zmw?=
 =?us-ascii?Q?OotDwl12os2HHWQoR+Zqx5KxLFhbCq94KwnRMvMFVjoOguiogTKJYGgXOocy?=
 =?us-ascii?Q?TN5uSEmP5Oh5siCzC8DepX78uUkBzmz5GK5gsCGJWPdcZlv8vcqCilsIEzce?=
 =?us-ascii?Q?KCIvwhKEZ5qUK/UlB45Z9qtIK8/V1dlPCSiEWKc+iLF4pw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ov7WEF3H57y5zWFTMI5WtKFEqhte23fRmt4kJamDGQPaoQrTu0u/I6/zWjqk?=
 =?us-ascii?Q?FzEPS8w6JAusdOEsMSE5xrNWbiGKknjPQvbxpGo1n+/9GUbuq3TpclpbEzT2?=
 =?us-ascii?Q?3A+5rwbvtYqha14LI/2SnLXZrOMF3n0FBASG8d0Dzjm1RaNrrrpScPQV7VOr?=
 =?us-ascii?Q?d6HHTII6QGNef1hh7HQZZZp3J7Lb62JXtQl4YOenWInyDcccN4aChl9hCT9i?=
 =?us-ascii?Q?akMZ1SfwY+kkdHMf2SEUhaKjh7lrCNB3fIlWksmLYJUFA3LpXK4umwa+Tp9w?=
 =?us-ascii?Q?1DEzNz/AmYr/yUU5p6xWF5/6pkHayjgft5XH3E2KLdpzCef0lAVnMLy6/Acn?=
 =?us-ascii?Q?DnplVUOHtIf/WkNUun52InUQciv8vnUvPf1Hmav0xQoIrnHhIZ3TaxsMiBv+?=
 =?us-ascii?Q?8+zMzlMJW6ebl3FxDKxST4ap3S0WsKDMyzW0AfM6+tLZKt/fhcgKIPY4btbG?=
 =?us-ascii?Q?L/7UtwE05hB0aVAdKPA634emwaroKM1aSmxo5Ijh6oaIiPD41KkCoZjDZi2W?=
 =?us-ascii?Q?eWbKppru6DuykZwPfdLqNDgwJJZ45CM5/TXPXHV2SKa1rn9izKwEEokcZnwy?=
 =?us-ascii?Q?xB5pr832+SqWG5pOxcqWzezr8g38YVQVMA7Y9tN+xqR+cMzk94zFUYWLGTyT?=
 =?us-ascii?Q?FIWacKm+JBxIto1e+hdZ9T+U1cWG5suNb+uk658+VQI1Ays0zXFIlhW0vMN/?=
 =?us-ascii?Q?Q8opC+OmE1vrFQx2fYPB04e3o1ctA+YVgn248IjJcXr6Ze2kOEaAMh46RC4r?=
 =?us-ascii?Q?8BRnmUuaxeBrTyDy7lbSTyd28FxXErn3VoQLrfhSivwAcyc9CZrTokgk2CIr?=
 =?us-ascii?Q?EIpsEPqLxTDtZbV18MqDjlVoDU4Rdi+QfDU5VEP81LnXbPdmKs0jlu0lFmpQ?=
 =?us-ascii?Q?aOQZ6vXzyFpBLoRa5JRn/5oG4RrzrQ3MeEwyZff5DIuw1pC8IQHhNoMrK0v4?=
 =?us-ascii?Q?QyCdXYGgHqxO0VpQINGmYIsXcCY6JpEfs3UtCQnAl2YnieJhGBVGULM76rE5?=
 =?us-ascii?Q?e/IjcD9+9hK3zvj+YdEfi8fen+MCxpMfY195pxRIDoxlJwkkWde1QzhCHHJ5?=
 =?us-ascii?Q?aWWcQXKwg0mQSvt1lTj3UNHFaUv6uOXvJ5GCSfKyXSuaqUeAbFWH7zIUJcWF?=
 =?us-ascii?Q?1/2u8IHxR1vACaFZFh0dK4SzyqRe+f6zVjLD1Nd+W/ty+ft6agGZuv401CrG?=
 =?us-ascii?Q?FUy6qWWyGI42XpxhlDnoln5GMO7NK5ZX2L8ZG69zrG6Rf03Ik3bA8uS2bdGm?=
 =?us-ascii?Q?6Fvx2JihbqfIqz0rZUH4IEhp2iOXHxl+otmsn4z9PAP3b0VDiyJ9vKPueEjy?=
 =?us-ascii?Q?PbbSpb44nTAFyxkbJq5of6UNjLVvp77hPdqAe9vFkU/WYnoooSe/mWfKZfb2?=
 =?us-ascii?Q?jrDvnywAqe/m/QUd2LfqYfFy6SBFFPwjNKte8hPM28lXHXzJVca0Y3BwUhsI?=
 =?us-ascii?Q?hJCC4TW0jueW+JXKX0mLAoJ/48qw1I4CuROCUBeS6v9wv/mWy13f9JboFDly?=
 =?us-ascii?Q?y7A5bqtwIC9CejPP2iVR2p3aKYI6pdwrd7krGUvHApX6SjW/+0OIMrhz7LA5?=
 =?us-ascii?Q?7fpcPj/QrM2Gc+6OfAMgtqiXlnuHgR6lduRyFXD8thQnWgGH2VFFrmeT734Y?=
 =?us-ascii?Q?3A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HakRyIuGGrqpmlD3gkJxkKI2pfCFrwWI9DlmZeHJBpyQjptQ0aT3pgXweLBzHIys3hC1fAwHCLtadp0IafdvWmJj/XJOBjGkpnyGUIyplG7dm7KlFsY/6BDtEXe5EJFT2A33qRydrNYnVNKpRCnirGLlvYADLjF4BaUKs3QllgWu/13mvPCXXhPjJChHOAacpR3TDF35ka7n/2I5+pxiI8hIKNTHXwuvcSQs1RAfLu3EOQbxx2gGGtQejKobO/a1OKxmZWaOM0WVCVoXDlgiDl/ZkDQbo8qMe6/c4oMxw8JpAJUc44M71dwH4MJ8W9CFK+Ol3zoL+Lt1kea9kINIYAWSISvtSFtWwKi8a6ao63wXqrnVJR1E/4CNTDRT4rLUcUJh/BHR6lz/v7+1dJaoITuHfhxDbQGAZwx+13FuHoqNMZgWj+E0lgLvQ5eTTJarS7GRgC+8qDlAXF/j60kQqcDpwfy/fN+rIm4rK6kfl83BWQTLdfRpuQugWtJOS6PbVszH+qsfe4GXpNbb0skQckdf8WMNnqQHXm1okLgx0b6geRQd/Ffy8XaDMhKCsGtn594nhp92PHQspqwWkDBEXcNCeB2x93gLxaHbpsoCy+s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22e7f207-62af-48c3-3a73-08dcc3af2c6d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 20:07:11.2681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eZAymfB9n7CNO1Tl5oiaDbfySn8/5SiqSIBj2Er8bATVQTdE/yhyeaqmRv4RlS38xuIBckZ5swo3Ail4a5tsgmy5pM6OAKPnOtCQqpDnYvA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6187
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_16,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408230148
X-Proofpoint-ORIG-GUID: 4ouXl2o-asrgy8B4YFmzmwTo9ihdcyqL
X-Proofpoint-GUID: 4ouXl2o-asrgy8B4YFmzmwTo9ihdcyqL

Have vma.o depend on its source dependencies explicitly, as previously
these were simply being ignored as existing object files were up to date.

This now correctly re-triggers the build if mm/ source is changed as well
as local source code.

Also set clean as a phony rule.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/vma/Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/vma/Makefile b/tools/testing/vma/Makefile
index bfc905d222cf..860fd2311dcc 100644
--- a/tools/testing/vma/Makefile
+++ b/tools/testing/vma/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-.PHONY: default
+.PHONY: default clean
 
 default: vma
 
@@ -9,7 +9,9 @@ include ../shared/shared.mk
 OFILES = $(SHARED_OFILES) vma.o maple-shim.o
 TARGETS = vma
 
-vma:	$(OFILES) vma_internal.h ../../../mm/vma.c ../../../mm/vma.h
+vma.o: vma.c vma_internal.h ../../../mm/vma.c ../../../mm/vma.h
+
+vma:	$(OFILES)
 	$(CC) $(CFLAGS) -o $@ $(OFILES) $(LDLIBS)
 
 clean:
-- 
2.46.0


