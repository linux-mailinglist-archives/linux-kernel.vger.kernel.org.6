Return-Path: <linux-kernel+bounces-536192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A16A47C97
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7C33188DBAE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01923227EBE;
	Thu, 27 Feb 2025 11:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YkzI4fBp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HG4IX+yc"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081C66FB0
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 11:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740657132; cv=fail; b=RY0qhXF1TM0Cd8iiJqx3VtaeTKm1Twlu66nxBA5MGc3c2Gv8KGaaeXC1he5EvTNg4UAg2wRjcJQih/V/nSKiTwosoTKTwRLIaI8EibtBH3IKvWr4LbHZhzA4ML7Q//saY5aGDclnlHORggSjxlhHdzP0JCC4vkbnJTdCNBzW9kE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740657132; c=relaxed/simple;
	bh=/4MWwxsZe8YjwpdLU+W+WsBAvYIRWgIxdV2fG7A4vh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qDKF7Iw/4iZCvJFxFWRy51vkZc47YieWwuQpAHrHeQGBQzE6HL0rfxvzuQ67DOiAgsZ6ear1AMkrdc6FA34d5LFuncOjWE2ctqVqVZFexVsYSRSqQsSay6TJQUCCfkonh9WTK5TzVSTWC70c9u6wBM8FaZvyXv9zuShoobAcwMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YkzI4fBp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HG4IX+yc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RBQarr003622;
	Thu, 27 Feb 2025 11:51:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=mGSr0OPzinGmHYo2l7
	lUkEZvzkYEVL4xwEic4SH+bLc=; b=YkzI4fBprSrjw7cZD12xMGDASWmW+j/ptq
	1EuIhq5q9fsxR9hBCNSJBEalpLXCUkOXZ1Zdaa3OGgtHFQbDEv6EJMIkBYrJAJ+9
	Efj84NXtumdtSsh5qyEeCf2xgpAjMKZpdMj/9bHmzT3rQJ3qHnIN77jjSuA9BFYU
	dLAvDzgL+HbVlrUL6+yLUOuoRyuL3SYhRvXd2vuYcgy6nY3Ibp9qr4tVvKpcrjJA
	ocKc5KZRSFozBzUvh7UL8K61m0lj9GhXZhDeco3uDVC7ux5IDCwdjrZFlfoTI/q1
	8zu+stGOrFPxFlEOwBrPThfdSll+zcsjy370jDdGhHQVHswpicxg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psf3734-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 11:51:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51RAwSpJ024295;
	Thu, 27 Feb 2025 11:51:31 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51c2wu7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 11:51:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mTc8AJMGU/GOFwVdW7kM3ggtIlDU8cooWRrmpk5ISxixltw5Q4Wn5KvOza3jrn0QODN4FsQfOy3017OyJDgdMIEQ/eZ4kgSjabs88j8EFFvb8h6rQV4fuMDfl2cqQja3KSyAjyK1T4+UUGjoSXDibpq59pGxF+JgWX2sm4Bep1NDB5hkt18tLnk0gp5SzBHvTrj1pb2Kvn3h7PJMFij2rYFxAnZ9nyIzVaZuzNoyaym9KSSAthiNRtyOP/S7GPFD3tvRncGwV0+bxVHKFO70GdDPog/DC/anOjI9B7TLGCVzpHsPB9kb0NIFvcx5rfm+pjpHY52TUaZ1N9DOR5/5Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGSr0OPzinGmHYo2l7lUkEZvzkYEVL4xwEic4SH+bLc=;
 b=u00Ytprtdm01PHWiT9xyld8rV38UEuSj/vMpQ6nQ5lDFmxaCXgyjvhEcLqpdXXnTUhGAcSEZtzxSjk5hcYtVWmqgTODrjWxC5GJyLDM9Fm6SU0PZvkU2ANxjCOyb9cWZuKKZSNUs1v6GSZAEGa+ui3OUrWOcUba6NgufVLnTjCAnANCtYes7rZtWXMG/SCrWdpD9rMyrCP/VILxUy+xjQKDkTtd+aNgjplM6Ug5Aka4ycK9AVvFHjAGNmP6n//58yMw1FUhJQIGG+9ip9va1vcww5Dq5U8Cw+/TNCDyRFdLrG9evc0oL7LBVK28ISqjshMee/DIGDw/7L/zIxDa8Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGSr0OPzinGmHYo2l7lUkEZvzkYEVL4xwEic4SH+bLc=;
 b=HG4IX+yct3yqq6eE3OED7fXUuhCvaAaJzuMLNUDO7Ak+EjlRq/8WzYDyiCKVGYRrugS/2uSoh5VG8QYJIJ2yG43X8B/2NBtaYGjTkuvF45qdgxrU47Wq3Tub4/Tm/OVaU1TTb+/uPc8ohMV3Xg/FjJ+yk0GyfLeG1uQ+vXfetCE=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH0PR10MB5067.namprd10.prod.outlook.com (2603:10b6:610:da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Thu, 27 Feb
 2025 11:51:26 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%6]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 11:51:26 +0000
Date: Thu, 27 Feb 2025 20:51:19 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Hyesoo Yu <hyesoo.yu@samsung.com>
Cc: janghyuck.kim@samsung.com, vbabka@suse.cz,
        Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] mm: slub: Print the broken data before restoring
 slub.
Message-ID: <Z8BRt9a6PqDqBVsx@harry>
References: <20250226081206.680495-1-hyesoo.yu@samsung.com>
 <CGME20250226081357epcas2p2f4c462b215b75291a9aeeec23aa1eaca@epcas2p2.samsung.com>
 <20250226081206.680495-2-hyesoo.yu@samsung.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226081206.680495-2-hyesoo.yu@samsung.com>
X-ClientProxiedBy: SEWP216CA0057.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2ba::18) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH0PR10MB5067:EE_
X-MS-Office365-Filtering-Correlation-Id: bef3550d-b11b-405d-820c-08dd5725108f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cTy+igGCBXvoyfUxHYERuy15UymsdZlpoFHpsXh1sNvh8m2SN4e1rvDcI47t?=
 =?us-ascii?Q?jumjCUXGwBikqr2dGXF1wHxD3iet1IW6xYp/bQYqvYtHL2ehfFadnLBwiXuV?=
 =?us-ascii?Q?x83FcvvsppnY5LbTIKJkdZ4A4tOUEsv7/BlC0Q4aVsPH3mvPsp+upvLMUszm?=
 =?us-ascii?Q?nD8zjvptzrB7EszBD8h82HaFGZhX8Ctvt4IlJKEZ+4VcgQtIbKcHpGKLnw0v?=
 =?us-ascii?Q?/+t72GPbAAedi0r2sytK58BoWqjpB5g33xdlARKs+FM8N/AMINVPJAH/V3S+?=
 =?us-ascii?Q?16weaZJxFeTTbmxh4xOBhnbfMfcicA+F0BF4Hj1QoWshpnXMfRcp+izMvhIb?=
 =?us-ascii?Q?LiI0C+4KpO+js1iJ72rV1aGR3GHvtkndaHiz/Nppe6QNuWiOOI+YC0l+D6dl?=
 =?us-ascii?Q?Ikfcw4w3EHRvFrWRfnwq5d1p8krZNSAXw5wvwrBsoDLKaZb3D7duH9ZsoByF?=
 =?us-ascii?Q?BH9T9hHgIkurNm9DRG2eU0fMM++DekcKxSi/kwKIA5X+RU/JdIiwbrRTONDP?=
 =?us-ascii?Q?0oIfvGbGVplvIqla3VMRppomtZLeVFYag9j5//zpFdfKXSstObr56hTVI1ET?=
 =?us-ascii?Q?6S4tkC7fhE2vKTc8Jp/27WKP9PZI4bUt5A3LJeOg8ahfhi10nHZKPmdUf0c+?=
 =?us-ascii?Q?tCDMQGNTb1HI7Ry420zVGMF4yCvtX8GeCz1v38ZWb4crJyjnVDHfvMwHWeuh?=
 =?us-ascii?Q?OXIjtZCiSESCUnmCgVOs8rX4/6QM816L+pvuZwEnOPyBZXrPhBJ4aO3epG30?=
 =?us-ascii?Q?VpH4rU5Ye5cgrkU92Wcxry/oVGrQscJDikVoTdhhdgnuC1/cXQpwFGyWdKH6?=
 =?us-ascii?Q?nk9ELX6veiZ62iuKyK1mAmjImidP0lHHiypmv0eRQZHWEQCO+I9+3t9s4cJB?=
 =?us-ascii?Q?CZwmFbdbENTYhf+P99uQwTpTezbABJNtm787ivtiNn+n3zyj7CWmbBkb2h+w?=
 =?us-ascii?Q?NLRlUTwq/Qw7X/v0YiK0Q2d4hjekeOpJcUWIgYMECs8yRPe8BIVxqygbsUzB?=
 =?us-ascii?Q?5aMd0mwIx9+082J3tyk1IYl4kzmBWUL3uPXcBjwtI7TqDGUfFTI1hcQsjG8i?=
 =?us-ascii?Q?IngcxiNYV2IKyu39SLVPKKMUVUZWB3KP9UiKNDzWUvx+nzhXnjYHQrqJlMRb?=
 =?us-ascii?Q?7yV2L1PUjEj2ohs5996pNL6HDtltAQ6bAaRbPHwJ9jTKpJp9QDv63UzKyltu?=
 =?us-ascii?Q?A41JBoYgvcV7+Z6ntUIxrsnnkUMcgWf5Te/54jakH2Q+NOlZ3OT4162jaxSo?=
 =?us-ascii?Q?hjPwS1i6UZTI4rx3AI90BQfPJ4p2uV0rcfylUqXb9VoKpF9i4xYpw+87Ejzm?=
 =?us-ascii?Q?F1pTBAafK57yvh3inseoQJqEZjN3sfHsejkX87JFqq5aRg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2GmzxHcbtUrJlCjQnzIL+pnT05RYyhp9uLuE9gVpT6kE+QYDCrS/i468cHXf?=
 =?us-ascii?Q?1KmiRnsho/iuwC8xc03Wty/xOyaYX0X/TzBqsyjMQKC+QnLEF4kzbFf00PeP?=
 =?us-ascii?Q?KY/L/RYX8lHcmIWBtRDu5SDprTsPe10v5tU5eTuxR4eFvrdw5ko68lFcWZaH?=
 =?us-ascii?Q?apeJHKB1iRbXR7OtzODl81AluUPkCFl6H9v+kVd6MTD+HNUtfmQiwqCjMNdV?=
 =?us-ascii?Q?9qCKnkmR+7ES9gKQ3OEYl3FpR2S2uxMGBw/Y4NwG6LHE9qjHghOkaOpkMyrA?=
 =?us-ascii?Q?wKj9dkn3RMTYElg2mk622Y/zloEc84EVR+H3YqLGLBvrFEcjBfwbtD4sq8RH?=
 =?us-ascii?Q?zuzFrtj/gWxQasYJo0aEWM6kSeMBJXPEXOTPYKgRB8iP+2ZUaPEhJaW6Eeu9?=
 =?us-ascii?Q?0/ml/no43avi99yE7HIJZ9fzxHdKnrOnxycqULsalEmFngt6HJyUyeiZyOyc?=
 =?us-ascii?Q?Hb/xt/qLlfTndvhTeyoXx5W5yoT74DYlJpENKle4H2AVZeVh9bRhCvAKyBe5?=
 =?us-ascii?Q?l9wMdxfS+G/DW24YTKekcqoQbsAG0K8TDZe6umuYwQtzyiXnDHUaVRIpOQji?=
 =?us-ascii?Q?KP3leJP3jVbQOXUtsdiWLs4nzdnV2hLmq1rbaBvg5KTQayG7w+b6nOdQbY2h?=
 =?us-ascii?Q?5WD3YYzFVLWruXddlWI3LFtUS0EY4npPFwkbvcnrlWSt5BOzahWcDS4fnvYi?=
 =?us-ascii?Q?Hu5rgSgaC72JuEXl2N/P/latPtu0oDWZk/j12d9TnynDba4QF/TYUxRRMBh7?=
 =?us-ascii?Q?RC6v6YcHSxdzgL/UWM5bbrvlTal/oqFtLrlZMrXTiscxz3pQPuH97C2nGtOx?=
 =?us-ascii?Q?hmTDzAOeoqp+LTYQX4g8aZWMRZxs7Fu6e/PYtvAxnDSfGIN3jyyM0+94kP0e?=
 =?us-ascii?Q?t8EcCbLq3emFlsaT7iSZeBQYM17v6lMJog/AJyFbnzb01Ts+Nh2NE0u1KsBJ?=
 =?us-ascii?Q?p8s1Uwb1anqOx7Buebu29JvV7NTPHNfDQ5EIHbBkh6otknrtCYvRrrMLrKXt?=
 =?us-ascii?Q?eH067y1RZsJ4Zi3QCM6did+pPZeEfecyzkIgoBWPygy7rRgyeqTBv2PSwGk5?=
 =?us-ascii?Q?WK2Lt0va6F4OIEiTTuPFwacRpTRoMaOfQmt9UwJUvmZMjtFWlb63ergYJDsQ?=
 =?us-ascii?Q?7yci4LdwYpbOu/c0qj/XEZYiq3ZUS3XxFmVw/tlMXidIksMbvgIIL4pfg9du?=
 =?us-ascii?Q?SOnub2hxXbUWFIeFCD9jkra2RGKjGfmufD0Svb70C5A0wyuCWPrm4QdeOj6p?=
 =?us-ascii?Q?JAFhCeld1e5XQX8CD382S39cTeMHQz1NzJzgnj9lQEF3AZSgAXkg0qg49NzH?=
 =?us-ascii?Q?sZJFvbc1VTX5jigp0JFdk3CjMgFI3CEsXXsaUqagf47041gNwbDl/dm/ajHS?=
 =?us-ascii?Q?DB19zVsoHD+GdwJodPrZ3HXlf2HQ/MuCBFQ+QJtWeKVhh6A+5pJ3wAJWq8DV?=
 =?us-ascii?Q?5nFNkkHUsZ5hmTcWaoW8PcrmGtL6SaR83f/O3sTOCsGb1YX7bxG0h8p1Jn9z?=
 =?us-ascii?Q?AoZU1eO2aHo+gq8zaKOg2/xw+BuQiw9dKube4WwDDuhv+ETp9Bd/vhaVoGOG?=
 =?us-ascii?Q?YgBpsXzDpBGk46ljFTpL7+SX5x6yn9fBhWNLC2cD?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XjfxSEkMLiSMUgpAE4o07ji4+dwiubfzjYMfV08ahVH1lHg1ltVTQVinWHSjmzmdIAQIuznFIs/hU5i39Er0cNYhSuq/fBvGbESw70sMe2Gn1BBlImp7tL72pfhK9REpreYCi3tPbC8zHhKuriTzHMrUJOF6XSm7+y4MYH0wtIN7v99LGPzu1mh7BThFA5/pylEjKAmK1PNpYj/K8gIqI/SiRHPukbCtu5SGtR0cSIuiHhOOggAPiM1DcMmjgCPeSpZgM9P7WIcr02Lv6O1pGHU/TTzpgc9v9nrIe86zh5GIS62XqiU3LwzOBg+W+DKXZD9q+Oju08dF6qiYxv1vzk+nGTGviQk4B4FVZHc01cgj1MP4VwW5WAwLSmI8Rh7xq/O8UtU1n9KKsS9dbFJnY0YRLhxShjsCEKmREMqMZKie6TQiUz+Vb8CZdkxQkau7fBnhkTeIkJfy7k6NzY9pEfuizZBetZBKfLoMSlG45RhrzQOU6gSLu67qsvPsd9QOgcaQ7kC1UH5/zd0MgohTiXbFJvyHmpJt2HIfnVjjZh9aQP3ifuK7nH0n0xY9cFFi9bl9EE4AAIDNJHGDMsVclKZhDXpCVsG4NAtdnzs+Z9Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bef3550d-b11b-405d-820c-08dd5725108f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 11:51:26.3788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lYfVqB0OPuh8Qn3aJL9H8gchE/M+ujQvMIZEgouvrx7gkiMQN0V2wLQdWMciny7/OfhhFEz+R/1fPE1xFD0qOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5067
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_05,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502270089
X-Proofpoint-ORIG-GUID: C4AE6u5MnbS98wdZRgm2baJFwJ3fcYmo
X-Proofpoint-GUID: C4AE6u5MnbS98wdZRgm2baJFwJ3fcYmo

On Wed, Feb 26, 2025 at 05:12:00PM +0900, Hyesoo Yu wrote:
> Previously, the restore occured after printing the object in slub.
> After commit 47d911b02cbe ("slab: make check_object() more consistent"),
> the bytes are printed after the restore. This information about the bytes
> before the restore is highly valuable for debugging purpose.
> For instance, in a event of cache issue, it displays byte patterns
> by breaking them down into 64-bytes units. Without this information,
> we can only speculate on how it was broken. Hence the corrupted regions
> should be printed prior to the restoration process. However if an object
> breaks in multiple places, the same log may be output multiple times.
> Therefore the slub log is reported only once to prevent redundant printing,
> by sending a parameter indicating whether an error has occurred previously.
> 
> Changes in v4:
> - Change the print format to include specific error names.
> 
> Changes in v3:
> - Change the parameter type of check_bytes_and_report.
> 
> Changes in v2:
> - Instead of using print_section every time on check_bytes_and_report,
> just print it once for the entire slub object before the restore.

IMHO it is not a good practice to include patch version changes
in the changelog, because the changelog should make sense on its own.

> Signed-off-by: Hyesoo Yu <hyesoo.yu@samsung.com>
> ---

I think that's why people usually place patch version log just below '---' line. 
(More details can be found in the "Submitting patches" documentation
 https://docs.kernel.org/process/submitting-patches.html#commentary)

Anyway, the code itself looks good to me (with a nit below).
Please feel free to add:

Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

>  mm/slub.c | 32 ++++++++++++++------------------
>  1 file changed, 14 insertions(+), 18 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index b3969d63cc04..8c13cd43c0fd 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1192,8 +1192,8 @@ static void restore_bytes(struct kmem_cache *s, char *message, u8 data,
>  
>  static pad_check_attributes int
>  check_bytes_and_report(struct kmem_cache *s, struct slab *slab,
> -		       u8 *object, char *what,
> -		       u8 *start, unsigned int value, unsigned int bytes)
> +		       u8 *object, char *what, u8 *start, unsigned int value,
> +		       unsigned int bytes, bool slab_obj_print)
>  {
>  	u8 *fault;
>  	u8 *end;
> @@ -1212,10 +1212,11 @@ check_bytes_and_report(struct kmem_cache *s, struct slab *slab,
>  	if (slab_add_kunit_errors())
>  		goto skip_bug_print;
>  
> -	slab_bug(s, "%s overwritten", what);
> -	pr_err("0x%p-0x%p @offset=%tu. First byte 0x%x instead of 0x%x\n",
> -					fault, end - 1, fault - addr,
> -					fault[0], value);
> +	pr_err("[%s overwritten] 0x%p-0x%p @offset=%tu. First byte 0x%x instead of 0x%x\n",
> +	       what, fault, end - 1, fault - addr, fault[0], value);
> +
> +	if (slab_obj_print)
> +		object_err(s, slab, object, "Object corrupt");
>  
>  skip_bug_print:
>  	restore_bytes(s, what, value, fault, end);
> @@ -1279,7 +1280,7 @@ static int check_pad_bytes(struct kmem_cache *s, struct slab *slab, u8 *p)
>  		return 1;
>  
>  	return check_bytes_and_report(s, slab, p, "Object padding",
> -			p + off, POISON_INUSE, size_from_object(s) - off);
> +			p + off, POISON_INUSE, size_from_object(s) - off, true);
>  }
>  
>  /* Check the pad bytes at the end of a slab page */
> @@ -1329,11 +1330,11 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
>  
>  	if (s->flags & SLAB_RED_ZONE) {
>  		if (!check_bytes_and_report(s, slab, object, "Left Redzone",
> -			object - s->red_left_pad, val, s->red_left_pad))
> +			object - s->red_left_pad, val, s->red_left_pad, ret))
>  			ret = 0;
>  
>  		if (!check_bytes_and_report(s, slab, object, "Right Redzone",
> -			endobject, val, s->inuse - s->object_size))
> +			endobject, val, s->inuse - s->object_size, ret))
>  			ret = 0;
>  
>  		if (slub_debug_orig_size(s) && val == SLUB_RED_ACTIVE) {
> @@ -1342,7 +1343,7 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
>  			if (s->object_size > orig_size  &&
>  				!check_bytes_and_report(s, slab, object,
>  					"kmalloc Redzone", p + orig_size,
> -					val, s->object_size - orig_size)) {
> +					val, s->object_size - orig_size, ret)) {
>  				ret = 0;
>  			}
>  		}
> @@ -1350,7 +1351,7 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
>  		if ((s->flags & SLAB_POISON) && s->object_size < s->inuse) {
>  			if (!check_bytes_and_report(s, slab, p, "Alignment padding",
>  				endobject, POISON_INUSE,
> -				s->inuse - s->object_size))
> +				s->inuse - s->object_size, ret))
>  				ret = 0;
>  		}
>  	}
> @@ -1366,11 +1367,11 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
>  			if (kasan_meta_size < s->object_size - 1 &&
>  			    !check_bytes_and_report(s, slab, p, "Poison",
>  					p + kasan_meta_size, POISON_FREE,
> -					s->object_size - kasan_meta_size - 1))
> +					s->object_size - kasan_meta_size - 1, ret))
>  				ret = 0;
>  			if (kasan_meta_size < s->object_size &&
>  			    !check_bytes_and_report(s, slab, p, "End Poison",
> -					p + s->object_size - 1, POISON_END, 1))
> +					p + s->object_size - 1, POISON_END, 1, ret))
>  				ret = 0;
>  		}
>  		/*
> @@ -1396,11 +1397,6 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
>  		ret = 0;
>  	}
>  
> -	if (!ret && !slab_in_kunit_test()) {

nit: check_object() was the only user of slab_in_kunit_test().
Can we remove it altogether?

-- 
Cheers,
Harry

> -		print_trailer(s, slab, object);
> -		add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
> -	}
> -
>  	return ret;
>  }
>  
> -- 
> 2.28.0
> 

