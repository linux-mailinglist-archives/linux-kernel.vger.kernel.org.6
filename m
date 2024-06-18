Return-Path: <linux-kernel+bounces-220181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F40190DDCD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 22:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12B85281C96
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 20:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47CA17836E;
	Tue, 18 Jun 2024 20:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Bnm8q0X0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="S0mM+uHb"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F209C16DC19
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 20:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718743758; cv=fail; b=eLQ+77rvd2Em1X/jIejs6tcPi/enECkk1fxHSegz+xZ3ma1AzTIbZhFBDEOP2WXsvmCfa1Kwp7nFtd9VNCZjN1gDszJoWR7Hg3i/xuFQOQ1zO4cjf3XCepUQuOvw8E1I6GCC3iS94TpuaVOEO7vug4R7Ku8XXY8wICUG9bBf+HM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718743758; c=relaxed/simple;
	bh=A+pU61BlDqvz2/Ec6NB6jWtaMEnI7bLiEX+o0ldN54o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oykno3Tz7EVEKRdDwoin62mJNN0l4P7DhhKQDUJdVte3Lldyy3FiZlpLrLxahkBM90ntKFUAUyRBj7dXpdrsYF/rwK7+pat2A4FQZxBPf7q8SrR2hlQxmPQW03KCYUzVC+OlU510JZ92iOYSFCUVIiABohXB/D3Ih13hl/6LT/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Bnm8q0X0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=S0mM+uHb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IIUt5A027379;
	Tue, 18 Jun 2024 20:48:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=iie5vgvEzYdWwZ4muw/pY8/hfxW9ERQYh1d9Fr7j7Lw=; b=
	Bnm8q0X0eONPqIDL7Ga4yyFJR3iN1X+0AHDZVZryw6Xuo7KOFGyzR4r8GeZ3BT5g
	VUd/LCjfiPLPLuH4dBiIJ3wbXje6TpsVeIws3ZzOSdQRTIdl/8mJHPRBUEyxHIbK
	ok6TwgrpOskChAGMe24h0kxfnBwEgjpTSwf1cu2gS5G/GZVESEQQXtG1oHA1IEJt
	Pr9rMiFGOyouka4t98fFY+YmMjAdc/sdXyIZyUgr6AajBuuoLbXpT7paO/8bV8p0
	RWy+kuEJwPX0eunLVo3XD3aNsfkQm1i3NKfKOVxGmTZJd3Y8mDar4QuDXbQ5ivOo
	xisnm3t26PWi0UZ4jcFKdg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ys30bnvmx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 20:48:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45IK8ThN015724;
	Tue, 18 Jun 2024 20:48:32 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1deqw7y-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 20:48:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bTmogLNOD/ABtih+AIYe5yJeroXdWRLxMjINW55oprsjsBWuVmz3LriLL7y2nB2264xFNVWEuKRMbRpTfQvVFy1JG7OoDe4FNbB7VSLVivl6ykSmlcrUqHFvmXUzkN6s0I4Q7+FlTg80fIUG6WuemgYq1KiavMhonO5lE5gTMcT2Yvaek05ZAgLOqhzqXGYIF+BxoJbozjNFbZgMuQpsRXeOIH/bDvjYvcrp2eOUvUcPw+Gnh3XOJFII2VGXTv+euJ67sKHYtfNQguB5etAe4kHorNOyyffKohWDPWeMZEziGE2JjsunWs1czTSsxQtQiIOa9yBRBdgLtuEVAIqhWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iie5vgvEzYdWwZ4muw/pY8/hfxW9ERQYh1d9Fr7j7Lw=;
 b=XKvFb5rEMR6wM+4AT7mpI1hewvSojT4WHVBkdfhSGvjlFj8xmV24WwBAXNn5rL9bNWIzzie0eLujGTJCZ81A+d5lLnhTKnx07t9WSedFZnln36/NfVzrMek7Hsag9E6n/fLAU+jg6EG2CMq2SIu/ifXrHfm4548S05MvPbQGXOAixs2GszZ+Ruow9/E7V92QB2LTMllzuJWvYjLtY2fS2zH4RrkZp9cppmoJfnWtUA+EksY7Sla0x2k2nRY93g/+7WvqsAfx+PN5mqCn++IutalPaJDiENEcHSTSWrfc1It4NBuRXykaVaZTzm6eZORJxbNwcay3UeVrCo1qT0HQwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iie5vgvEzYdWwZ4muw/pY8/hfxW9ERQYh1d9Fr7j7Lw=;
 b=S0mM+uHb6tL1HvPSWHApkNcF6OE33vVKcIC5gO5no16g/EmMN5nyIr9jZN1N5fzta5uGMkisRnEamVViAyOU/AmrbnjAhqzYFQKx6zHapKB2IO8U16BnrhHGHfYsk/GKj5QheUAW67IcUxkb/OXcUWMeh/OEPQ1ME2PqKHF9hmM=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CY8PR10MB6465.namprd10.prod.outlook.com (2603:10b6:930:63::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 20:48:15 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%7]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 20:48:15 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v3 08/16] maple_tree: print store type in mas_dump()
Date: Tue, 18 Jun 2024 13:47:42 -0700
Message-ID: <20240618204750.79512-9-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618204750.79512-1-sidhartha.kumar@oracle.com>
References: <20240618204750.79512-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0097.namprd05.prod.outlook.com
 (2603:10b6:a03:334::12) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CY8PR10MB6465:EE_
X-MS-Office365-Filtering-Correlation-Id: cdcc4a82-056b-4e30-0b51-08dc8fd7fa1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?08yZg3pefp0GVkFy6u1NEZ/oQuS8AY9kWOSMQiG6WZmvAAzNSayzgaCvlmqB?=
 =?us-ascii?Q?RY8HM4A3LX0VzrTCYmMTFT8HW7M0rVfoV8pk4HRZbYT/BXeDsNme3qHkK+Iq?=
 =?us-ascii?Q?zJXsEMTJmBRdR1cU03R5Hc3qVRjCcCi2W8Z+/RKpAytyYJLJTePK8KIyo/SK?=
 =?us-ascii?Q?7+6m8YQoWhhZQKWTVBeghFTnrKcwLZMrbL9ml3RUfm/kj0voFVUft+eLJPy1?=
 =?us-ascii?Q?dF7iSUCLg+mTKHCSU7cAAQe+k/QVLj3Xw9PmsHcWymDqv72wVLBSW0pTCOJY?=
 =?us-ascii?Q?DrnJ9mMmdalugYTQOhFiW63kFX9ecLZu5HVGyObP39rZ2O2ooyUPKynEhjyU?=
 =?us-ascii?Q?650tkhhE9yg4x7SR+XMaiTWLmbF5AXJdVdTOvb1RfZQHb/6V0zeYyQaqamgv?=
 =?us-ascii?Q?GSbbPQfijJEAXDkDqcachwF6wb+jpgm8ZLfTOn7Mm8pEYhSUW3sQ9TEEi0uZ?=
 =?us-ascii?Q?zOpwRBcy63xBdWplDz0aSHXAfzcxep0HluKLzeWWsrk8mXyOBGj5GEPNFufK?=
 =?us-ascii?Q?oqD5N2l+8Fs1q3+Cls++n19Avbt6JTjkj+7ONDKcUR81EPppPyoX93YGzNRV?=
 =?us-ascii?Q?tV66mL9zpnhUqqFeDrtd1yc72QBgOHrFT8dBYFYQj4bk/8KCCs00rdPqCvXK?=
 =?us-ascii?Q?EEJvXqa6B4K0iMpAXDAXbX1/XaBnwBD7PhEX6yEgxwe07UNHP/cNJ5aO9kfd?=
 =?us-ascii?Q?ODN9zhVBMM7bAcOlri/ZNuBOGINwcfm2c3qkL1TVFltBOQ6CMZeqhNf9X2Gw?=
 =?us-ascii?Q?LuahYTIeQ7EjKs2X0CGyiQlTfwFCh6oXeQ4X6aYT3HvGS+pa1lZYcHLvVRZf?=
 =?us-ascii?Q?nFw1RSmCXhRQ+x3nY0MnQmv9t+i1gP2WCxBnySHxTP5yUllbwtXBBN5GAXOe?=
 =?us-ascii?Q?W+9cy1JJ+2kgDQJvLTwfH5LfQGLjOqYwUFuqen31DW79aBxcfRDfCIn5Y2+Q?=
 =?us-ascii?Q?xzoAKuPnMFa4RyObjRUw7TT9aJ4uKus21aOMlwsZ1e3yRFPfWYLWMVWnMBWQ?=
 =?us-ascii?Q?B2fieC8lMq11ZZTCoTVgwpDCYpuvCsWYG/g7liTwh2hJXUin5u1GZkUEHOMe?=
 =?us-ascii?Q?DDGKWHS7k7WWAeniJo+EqfFfd1d3W3Mx4FNRSTAZX6X/f9NMgLUvyBRMkoT6?=
 =?us-ascii?Q?DlVaxL0ccwaPMd3JwUKL+4ig9/LiWiUGfeOn2LPoe/nTwcFVv1SDufAwLdQu?=
 =?us-ascii?Q?2JjTg8aqehMHUyJ5JQC1mlhbik1Hq2V7VfxDb7ItDBX3A2Nvex32vU3NX9wO?=
 =?us-ascii?Q?H13bukKCmA4p3EbvlemE8H6ClbnfKKN4JCyW7piv7EP7m5H2lx3S32e8fxI3?=
 =?us-ascii?Q?MsE=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?aR/6INO93TB8v9JfTQm4OkN+H2e0XKS8CE10Z3ZDLagyZbkfBf2I6otrXhq1?=
 =?us-ascii?Q?vOp+c0zWas/z/JEcoys3mKqkoWOg3m0LpNaD7fzPAUmkzJFw8nzBkDoKl1HI?=
 =?us-ascii?Q?Cx6DnewKUJcFgQpTshjCtnlIkodn8l7RJTeGUpK8l9aSig6BCeHKJFOdLj0V?=
 =?us-ascii?Q?6Nvl4MD6h+WHQHkPmI9PNu82VMsBl/ZXLNR8WyNJzBrISyDocIgRoyGPpb1F?=
 =?us-ascii?Q?e9TzvMOD7toGsdEF5beHZrdwXhroGYB2xkZLj+ow1e/5qtywFA+P56sqjRWx?=
 =?us-ascii?Q?vB9AHociMdqL51zx5xeq4zgZh8ApQNkO0R/7awbDxfz2bcq3r+vHQiJwFbSS?=
 =?us-ascii?Q?8MIRde+czoPhzCtfrh/9FXbK3vPtUI/VuHk5FpQw4iNVCWyCKxUjOsokDyDM?=
 =?us-ascii?Q?5PaevqWtFQTFWalIVRju6j/U89QquRnP8CWSlc7o2tWWLqv1enBgtBZYMbOZ?=
 =?us-ascii?Q?kSp6QJQ70/8UDIUNCW6mqHkiWfoshAeRwJBmo0cWsgKJqpFHfsntfkn0scog?=
 =?us-ascii?Q?0072alQAcAR8yTkw9TFKNWz3udhdiFK01zDzMHvrgSm88635ct9zfOR+EZEq?=
 =?us-ascii?Q?vX1sVB8pqV61Y6dr1yZMYpS/suZ5jT6E5DhFGyk3MbZdlR9j0Hyi/zl35064?=
 =?us-ascii?Q?3BPMj/pgFolt10RovXyFXqQTpgAD2QAWKQwGHyXSuaqigJTFrzW2iDacsTYE?=
 =?us-ascii?Q?2UcDBnNMxgD4mpqysL85wAlqzbdrZcHQez76tE9FQT0dXeQo6BFtxn8B42EJ?=
 =?us-ascii?Q?K68QYwOzhWKHK3xy41Uw5tDWlHYQqo4AEByW4INC1zAxU1607M43cSmuL1N9?=
 =?us-ascii?Q?OXLlfhyB2ytALpBSVYt0rHcMOGF8sG1/hiH7KCIdDwLNM89BtF6aqTogAOZk?=
 =?us-ascii?Q?8rODDgc1Zu3kAJm3FGsccKMayvzd/7x9GyH/p+0TYz7D/nzd1rq8wuuOe0il?=
 =?us-ascii?Q?UR3v5buwQBjfN+t+9KX+Bx19MjlypRcencYp43M+YdTympmr/DyQ76VGYMzY?=
 =?us-ascii?Q?+mtOyoo4B2ixu0JFM+s4gCHZIMYVVptU/CjA5i4HQyk0Qxf7MqMTP97bMut3?=
 =?us-ascii?Q?duY5tFDmPfoLS7fi3+hAL7sOL9NapVUOzrzr5WlEV2TrwDObsbKLv5cuvWR2?=
 =?us-ascii?Q?4HV54ZcYBA/tjlcze5+VoiqPQ4hSgHDG5I+Wr5EFVifZD4865C36CuYmSmHQ?=
 =?us-ascii?Q?cLUicwHnrozuzsVWqQ5VFxYx4lR6rJEpDI7IdLwATFdAIV7bw/kfmqj1KZMy?=
 =?us-ascii?Q?YpFAVcgXPJRY1GUXvWzgHhTQLgo3HKpfhCQ6J4OD409VYeoJJER1JpboN8Ci?=
 =?us-ascii?Q?iGQeWOT1ci+T0FKXYKnD/7p4xJJ/x2LCmmh29cdl3L+MxeFITlLsrWV+kU5c?=
 =?us-ascii?Q?khwojol5d0PKdHcwL6OXItZzzGk+4DfxtSgHUMcDQNUpdDZDZ0v2lTvfhJdt?=
 =?us-ascii?Q?L/KkxA57J2G7PYIwVqgRviRDF7QqzWCo9MHhIyjY0RGRYsTZsnCnlgZVBG3q?=
 =?us-ascii?Q?6zAyQaWoSowj0+6GhNzxfuoEs7T4mRIzz1IddpxP2Ck4BzJSWSZVOpU/1xe4?=
 =?us-ascii?Q?mIKZHh0DCnVcxwX1fMzF6bwLWvq3/zuNCRw2QBF+YJLQd8bprhDgdYojXxbb?=
 =?us-ascii?Q?5GFAuYJsw019C6QHsBi7bfs=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Lh3vRB4ecF8zOapyID/2CJS15gIp/3rd4+NZtltW821QthhGF5oLyK6Y+/Up8VeMsTbftNlONtwRomEoGMGMONq9ISZZTLjByrj0Pn5o8L13bH5dafD+oEh25OP49qhzloM5nwNiKWboNglCnGb6NMsd6s5eIg+1OwSgcbbtI51mL6BhtVZY2xcNBWO8KVV3OTuceYn7BAGxhR6Z4HdoUzVT2vrQfOjZHOWhzbqP6RVFW7W/4u0VvgUofAc204ek8awXasVwrDznysbBhCuDFfvdm+W3IjTbTeiJeyglAAQLP5ZgS0LyluaLmqhkweZyAJySeRGVWN2Gal0nVAYTjj1KsIxtGUf2DVDbUQg5cIbxhSHvA6WmtyoyVPVxamVSvlcTFPy7CDj1RN8mF2m2x6bl05p08JGO9QF7sxCvCoVrybzgq+vbKfZohnPLpaHlZZfEubF1LVitBrXF8hijAY/U94IgAzXwVUNhMeJtG7fYQYYSf4gpqqONnU+A67/Vkh/fQB/5hZsfIsvd6hkVsyciuwhIiSwobB7dQzNfovI8U+avX3o6+PBWpHUMdw7Js79dzPuOa9qpcZFu792BOIomPC+xh/WENBuniBVOEXw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdcc4a82-056b-4e30-0b51-08dc8fd7fa1d
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 20:48:15.8316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GwYFlWF2nlYAq+fTSr0vF4DmJEMKspt3yP/j/XZ/pdHriM4B22Xewbbmj7Ef/ZMXVjcCFs533OjKqKxvJLeBlorvdUq+YIXIZFkYz+9H4oQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6465
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_04,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406180153
X-Proofpoint-GUID: M0XDY0VtsjQX9fq_AnzrqbCkbY5RAa47
X-Proofpoint-ORIG-GUID: M0XDY0VtsjQX9fq_AnzrqbCkbY5RAa47

Knowing the store type of the maple state could be helpful for debugging.
Have mas_dump() print mas->store_type.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index ffff36e8b140..f40732229c9a 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -7728,6 +7728,43 @@ void mas_dump(const struct ma_state *mas)
 		break;
 	}
 
+	pr_err("Store Type: ");
+	switch (mas->store_type) {
+	case wr_invalid:
+		pr_err("invalid store type\n");
+		break;
+	case wr_new_root:
+		pr_err("new_root\n");
+		break;
+	case wr_store_root:
+		pr_err("store_root\n");
+		break;
+	case wr_exact_fit:
+		pr_err("exact_fit\n");
+		break;
+	case wr_split_store:
+		pr_err("split_store\n");
+		break;
+	case wr_slot_store:
+		pr_err("slot_store\n");
+		break;
+	case wr_append:
+		pr_err("append\n");
+		break;
+	case wr_node_store:
+		pr_err("node_store\n");
+		break;
+	case wr_spanning_store:
+		pr_err("spanning_store\n");
+		break;
+	case wr_rebalance:
+		pr_err("rebalance\n");
+		break;
+	case wr_bnode:
+		pr_err("write_bnode\n");
+		break;
+	}
+
 	pr_err("[%u/%u] index=%lx last=%lx\n", mas->offset, mas->end,
 	       mas->index, mas->last);
 	pr_err("     min=%lx max=%lx alloc=%p, depth=%u, flags=%x\n",
-- 
2.45.2


