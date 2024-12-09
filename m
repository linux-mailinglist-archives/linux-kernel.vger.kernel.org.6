Return-Path: <linux-kernel+bounces-437159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4739E8FCA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E2B01882FFE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A4F2165F4;
	Mon,  9 Dec 2024 10:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NSGWGday";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hyA4hzJK"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C082163A1
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 10:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733739117; cv=fail; b=BZsL2pJv7dz6VybQTl3rb38Wv7/AniPxXs2stO/AHtnfE+ch3IL82t26GlxWhnI57ErWNosmlxHdjtREdttCdelIAQ50FgsH/U0g8tFYgpCAm1H08hFREs6L06uBnSk+I7GJsZTJ+FE6LW89WolUQoeHUg/uLsVAJexWgXA1w1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733739117; c=relaxed/simple;
	bh=I86mDn5Z4QtOcH80Zwoiu2WsFQtey3VsrqD+NGKb1TE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c+Iv17d5Ps9QS6pW06P+XYDKRDp3qfb228513LoRA+K90TnZxk1Yk7gYJOT0OPra8yw25yvBAlzmbBzfJJoI9Ja/iwjxPVHHfFNnmKri2CA9L2e4Tzpvco0qf7BKoimxAfUXpy+K8ld0AVADCaQhDQaQFw/+sQbm8E8tv9PYaJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NSGWGday; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hyA4hzJK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B98frk0019828;
	Mon, 9 Dec 2024 10:11:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=E3THQoch+NywudS7bE
	7oxT1gS48ElAP3akND7zMtOLg=; b=NSGWGdayxWB6y/SuzIzx8BG5ud+XrR9YIx
	ua8cS1ZCHgcnApxdWNcnW3PYhJ5ATy1eqZOdM/eFjgGxZLlGKUCb5bW7iaTqr8BX
	RP3fBgBtuD2m1qkFv4zZKWGAv8hMueyJOGSZ6n01sY3ZMebWGKrB7GkUiAJRBD7Z
	//2rT53QCtke3UwxhrJl7UorxB131QQYP8DnwqInJQ9SdXwOdoblGP6EoItp9Pme
	zRjvlod+uZxw/sPGZJb98F79ATIWSuWX42QQ+iVkaLmJcwwS0xePfIJAsSABrUW1
	bL+I4VroR0300h5IGbD6yK1Ams6C9DYenjqAwAec8ispZZrDBndg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cdystv9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 10:11:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B99jb6S008814;
	Mon, 9 Dec 2024 10:11:34 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2047.outbound.protection.outlook.com [104.47.58.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cct6u82n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 10:11:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e1a/A3BmfF9a/gwD58+Xs09+DjR4x+Nxp+GGSP9DwxeHcf1eExWK//qy5uWwy8r76GR/rxZv0QFRuSa+88JO9GQRU9OZNEkXkv9rLSqb2QG4jZyOXHzHgBLgH3LmSfuZtshHfsbYcLr4RIpyyLkuS+ADUuoiSOAL0oLWi4yE5kFcesIoYGbpghYD2cNtO+m/Pr2mH3bTcLLGku+YMp+Ozuyf5rAdnhikf3meJ7g5L5JOYwgr8HQlFSUR83iyfW7utwC93rYBefxy4vLwrnqkTxXMEJCyJLa/BEloVsoDMqlxkGaIW6PAQb6QVV5GktNFSbvwOoOoL3cLVRvyGBI0+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E3THQoch+NywudS7bE7oxT1gS48ElAP3akND7zMtOLg=;
 b=QItkZkSWvh+W1YmIjSGLqv1Ce+z2i0gmxtbug+PJSx1KTf3fEPtpL0zc+lZ0h4K2JewKaPNs92feK8AX0hOcfTp7+IYVozeIxW7FmyLwsOZ3y7MLQ1lvMGmcXCGWBjgr+u3lUiZq88wCmgsG6kYnfDYr4jpcnHtTliy00m9YQ5vbnL5lqXQ4qHFwjm3G7FpCSRsgcZoZBV9azRpZiSSLfA6ms/THhviN/Boo1H/fDIxNDWMin8U33e+JpfruwRiz6jh3VOJ+v0vM0JutCkqz2WfnFikSh4kF6+pS3vkkXjhjGeUQHO5XR/4MM/vvaGUUfgVqKLlKP5Z/qoJjWeM5dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3THQoch+NywudS7bE7oxT1gS48ElAP3akND7zMtOLg=;
 b=hyA4hzJKTOHO5JVD7UbU7KwSEFP5yK7lPCUYUqC/WAfydSIJVedzlLbcbfbaBS6ixwDWftckKXpzseJW+F2rkeis2we8z/B5rhboPWEfttcGpV1AHZWcRcZO4iLigIl1t3RcrSho1MjnIbZ4/RWy2tUwSp9vT649jNZlFe7CjpY=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by MN6PR10MB7544.namprd10.prod.outlook.com (2603:10b6:208:46c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Mon, 9 Dec
 2024 10:11:26 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 10:11:26 +0000
Date: Mon, 9 Dec 2024 10:11:22 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: kernel test robot <lkp@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Muchun Song <muchun.song@linux.dev>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Hugh Dickins <hughd@google.com>,
        linux-kernel@vger.kernel.org,
        Isaac Manjarres <isaacmanjarres@google.com>,
        Kalesh Singh <kaleshsingh@google.com>
Subject: Re: [PATCH] mm: perform all memfd seal checks in a single place
Message-ID: <df83fdac-3d3a-44bd-9af7-e4cc61686ce0@lucifer.local>
References: <20241206212846.210835-1-lorenzo.stoakes@oracle.com>
 <202412070908.wNlwD8Sk-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202412070908.wNlwD8Sk-lkp@intel.com>
X-ClientProxiedBy: LO4P123CA0204.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::11) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|MN6PR10MB7544:EE_
X-MS-Office365-Filtering-Correlation-Id: 3794b0df-9d91-40ad-1c7f-08dd1839d7bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eEj45lCRTmKBExcmjIsD20O3f0fKzHZKMIvS7yus3jP1qWHyJLCtl316Gw5Y?=
 =?us-ascii?Q?qr3A9ClHM9RNt1lwfumpZqW8pjEOJtNEotG2hCZicc2te92kmf/rXnspmS+A?=
 =?us-ascii?Q?Z5UvbI+ZBciAzpYGX4CmD8HOHz3lrt2ACOpZGP1d5CEuO/cA3e6SmcuL2NMM?=
 =?us-ascii?Q?//Spaegdlw8l/gaKn6Dn2sAv1CRImqMOyjyyiHErtz1CsijjYgaQUYobEEBO?=
 =?us-ascii?Q?/Asm7dGVY/LXL5x+BQ88PyGlh+sNmyS+XtzZQpWtKGuLfnvcZgoyXTlmZIR+?=
 =?us-ascii?Q?6OfPZDveVIbhxK9UlD8kNszf+pP6JAkEO+p/RNwrMnKoHNomO4yfLNU/9ABQ?=
 =?us-ascii?Q?F2WwEsFKTI8apNhaAXgG3EU9ySIxdJnk8Qc2/Exjc8qFsfZGOaEWRNfZiHvr?=
 =?us-ascii?Q?49EmQa9Kk2rO7uiM2+cAf47Zniisy9g+RcJy4tXJwTpcozMuIAVm5JstswDl?=
 =?us-ascii?Q?0pD2BlADMcrWDuxAgPwH5Fu9jkbdPsZt0eZ2lWn3dmpUo2WqJmfJ4Siv8SBG?=
 =?us-ascii?Q?mrvMBkAuEb9Q7irpXjlhaZhieHKeM6LuOO3FUzyDH9Vw7+EXOSLUU2k8jj0Z?=
 =?us-ascii?Q?cThcMBV6PNq1HqlRV96/8HmNNnZ4IuVRJyVS47Wt+m1+Q8eJyUwSf32ht9tV?=
 =?us-ascii?Q?rCSjLUGRwplTk3X7EiW3/MKJgHZHmt0gUMgMGOXEzbresrd09T68Vl+Es18H?=
 =?us-ascii?Q?wqZIN6cf0IfT6kEKZNz2AaAmF6tcFAudW+HkQRtjkN0rs7YZZ03dxGdGEUa0?=
 =?us-ascii?Q?UzBxm90XzQRI6pZc3/+vUE6mDhpQWvvZ+GXnCzhJZjp7VbSMDacEgvWsLk/d?=
 =?us-ascii?Q?LTjfYncHWkIOAgkjQRnXSXjlm1fqAoWZxpvIS8kJ/A4zAs+YdSSG/5lgX0P1?=
 =?us-ascii?Q?zB3h82dZDWWwPHk2C+2JyGGZcubioK2BNvxNjPn1NrSfUY/pEWV3eLcMCFMn?=
 =?us-ascii?Q?nXJUFU1x+siEA+EUUVFTfflrGUQUV4zl0ajeG7Tkn5LL5CdDSAj+Wj4ZN66R?=
 =?us-ascii?Q?EkpeEL3bd0hreWFT16TNIcc35mpcHsgeWbuP9Uen8X0MKtLF1737rieBG6I6?=
 =?us-ascii?Q?UNSfJ4MyTxed1cmJI6f2dlbTxoyQefm2Bo+qEyciNU+sX2D/HbUC/mrM8S8d?=
 =?us-ascii?Q?kJhinVrdNgYqf8crbuzAGGOFFjZgQ5SSxz3cbK49jVZKOlQzGy83XTSs7XhB?=
 =?us-ascii?Q?uAOkLwzDNlFsE/kxiMB7go0MAIgAxv7qYxVtrkwvvjWzGUVgAa4ZlJJDYLNe?=
 =?us-ascii?Q?Ug9mQcQid70uYBkod1mtuSWNv0y0lmXjnNdPlyYrXZ5R1lqnevUc42O1KsH/?=
 =?us-ascii?Q?ziA5KOa3jploCvOmg5fDeNZA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zTVCYMD10BnUxMgenNrYIme5cA4Q/kS1OC8elvrE1zxHlIVPZMUnhN79z8mP?=
 =?us-ascii?Q?VJ2gGW+yPYMBX/Oxy86AXr0ZSaKnl/q0JlndH3JMisNS2nF4DUp4tR99FxfP?=
 =?us-ascii?Q?Xk+SNMzybwLHBv7HwiZxtPT+qqbFTuytampRT01B0maYF4oWzmxWPz+FlZu9?=
 =?us-ascii?Q?6+Quz4pee1GG6F1urPfyMi7rHxgvabSjnEfDimljKUIrdmebnTro6IgQHsSw?=
 =?us-ascii?Q?WeeNG4f5vn88lJJ3DgGanmoxXz7eNuGKvCVvdMBJNN+DMj1JaozOpL21o9Lp?=
 =?us-ascii?Q?As7KUNXckFc/r6wWA948eMn1NiDJMVdwVmuwT+XB19qHYCtjiNE4wFL2y3DW?=
 =?us-ascii?Q?W3CbKOs4Uam3fG5HoVAOqaWtKPCA5DBCACDBzb1xfQYZApKbaMnPixczBI9E?=
 =?us-ascii?Q?U6D+Neqd2dw1yHscQZ+7ur+O0I1AL8vTgZftlS6ooATpNW8NuQGI6/iLrrYd?=
 =?us-ascii?Q?SQv3P2T2814rip+aUtnttNkEP9ZMXeDR0WFmVp9yeDls79Ur/GkhZ1yY6VT4?=
 =?us-ascii?Q?5EH9nuG1Yb9seO5h882TCglO2yeOYq6/EWScn7NCySwbG9TH/Nb28r/pkVAA?=
 =?us-ascii?Q?6xcP+5WxMI/yPdiw3Vo8cbesgFxOOKcUJ8n/5c9wcTJbHpSEEN5NLDvaKTtw?=
 =?us-ascii?Q?qJ0Ed7t1bm4HzoxILn1lcqt47uIpk3Il2D8RixDhuj3W+4FnzbY3Pu03/6Gl?=
 =?us-ascii?Q?iLRQ5uzfTANZ5wul/hZjM1hMXLc8Q8iEawTT4M2DJWgiXlOh5yBHDmJBBHqk?=
 =?us-ascii?Q?xr+eIrc15wcji/k/kHExT+h2RaWv79JxxZnLbGIFc02cRER50hzLJyO51bGH?=
 =?us-ascii?Q?MDVt7GrXf+1JUVB7MMrbyf8MraC0CmtzNb2nAXW4/YrZV/G/NuwsucQUsTy0?=
 =?us-ascii?Q?Zxrkg9LNY5qVjraZWPM2vazlJ/jFP+IVUUYZPbgpsoiDWpXv6Vm24gHXG6js?=
 =?us-ascii?Q?xkJqa0LV3501JDWD4wXQ25Ltl6T3IOd0ItAQrQQiOW22+JwItXu9qLQ5OJjq?=
 =?us-ascii?Q?XUj9if1U9kdKjQMIXidqSTxPJbRltccUl//eNl64iRYuTalyegdbw2GmMOB1?=
 =?us-ascii?Q?Ykv0E79UWiXda11N7D0ImDt+ts6wpBZMUHgVjzRcm08q1kRNpFwH5kSSx689?=
 =?us-ascii?Q?akWiuHblZ0AH34oIVHwmW6mmigb+NUcXXfNP689b3GFhCNZljjJ3z+SpkBZf?=
 =?us-ascii?Q?EBOvp5XsMrwrdabdjtLjiW9kaWVEJHPfvkOquVfkNaM7FVHEeU0Rt1j+szRL?=
 =?us-ascii?Q?kj/frs2mYH3iI4fwuJU1d8fGmvZ5mityT9F6lG4OJHG3/cpH4h7c26n3mUb0?=
 =?us-ascii?Q?7Zu6cUOvHY+JKT3cbYKaruQBWs2/u2MTrMtztH0ZJCi+u234w/FNbyp993oe?=
 =?us-ascii?Q?204Ib6jFvC7qKYvOTKjRsrIs7ppm9gaq4YYSFP2J4hVX5XkgpquEVZqn1TWI?=
 =?us-ascii?Q?Tji9ouG1gkTVe4AKc0rWeC2qaza+vrvc2NmTU2Ot12qUCC9U8rVrP8Us3S7M?=
 =?us-ascii?Q?dK5fWC7OtwQ2Q2CDW6fKTudANGwcXdrSHesB8Jo1KO85jbenPlow7kQy9JWJ?=
 =?us-ascii?Q?uLBqnr3QT2jLdyyUyBgwhAWYqBshZa+7h8foZ6As37/0nJ8HIqfHRc8/VSCt?=
 =?us-ascii?Q?Fg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	purBZ5QSjDOr6LMJqDTT0oe2CDyevCG1PyvKUjkDhrNwqf8T6lu9gGnZEGSICgekJgaDwNYv2Pyl1q7Ax+Ti1kbFrdUqLd6H19aKysK6Gvla4K7QK7t7taN8MMsGKTCv6pvwrD4lC45/wyUZOW9NQINldKbnLY4xx5cqYGHhTsTCdhPJAnne0SSw5swJJBpLSYAHVyXGdlOjcd0Ma0rnhVqsHQ5bj9FWHF0fOnfdVg1xZGaz4C1cug54HxUe++pXgVpKNEeLH/u1aSYoWtOcsNJMI41fqaX21IT3OnVIgVK/o4pvHim+42EsXyoA78SHNy8G5ih2/6+RfAj3j9NkziiA/iy67PQSU7x4He0MYcSf2Bl9BKZdP+RNEPhz8qi6Zczx6cisvJ2I2XHiGSSNHrN2TlBRKF3x3SPPshE2Qo73joF3w8QnlHbB7WW7aSkZXKMmZY8LvppJIEO3RroJtv5nI5aj5Xr9bg75mv7kpgfSWgsLiaJF+DZmyaBcDI+KXTg4CZAWIeOttOPBO1eJXs7lzKw+h1X4KG0Uw1Du2dzIpKcO5jOQ6SSG726xIXuVzcqIW2oReE6cNMX3fCwDaBqbkXkofr2VpdtFS+jLhpU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3794b0df-9d91-40ad-1c7f-08dd1839d7bb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 10:11:26.9005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: glIXLpipLWy2lWNKvoE2FJkTkqf/Hi5BqgNzZAZvaVFKLcQ3yNwKULPVPQnvoPhsjl/ou6E44nBL6TjbDvkP4kaxF0O6OgigL3ClSNyz/lg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7544
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-09_06,2024-12-09_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412090079
X-Proofpoint-ORIG-GUID: ZxDKKaA99X5HLuJasNU674V6lh6D6xo_
X-Proofpoint-GUID: ZxDKKaA99X5HLuJasNU674V6lh6D6xo_

On Mon, Dec 09, 2024 at 11:59:22AM +0800, kernel test robot wrote:
> Hi Lorenzo,
>
> kernel test robot noticed the following build errors:

Thanks for the report, I did a silly typo for which I'll send a fix-patch.

>
> [auto build test ERROR on akpm-mm/mm-everything]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Stoakes/mm-perform-all-memfd-seal-checks-in-a-single-place/20241207-053020
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20241206212846.210835-1-lorenzo.stoakes%40oracle.com
> patch subject: [PATCH] mm: perform all memfd seal checks in a single place
> config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20241207/202412070908.wNlwD8Sk-lkp@intel.com/config)
> compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241207/202412070908.wNlwD8Sk-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202412070908.wNlwD8Sk-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
> >> ld.lld: error: duplicate symbol: memfd_check_seals_mmap
>    >>> defined at gup.c
>    >>>            mm/gup.o:(memfd_check_seals_mmap) in archive vmlinux.a
>    >>> defined at mmap.c
>    >>>            mm/mmap.o:(.text+0x0) in archive vmlinux.a
> --
> >> ld.lld: error: duplicate symbol: memfd_check_seals_mmap
>    >>> defined at gup.c
>    >>>            mm/gup.o:(memfd_check_seals_mmap) in archive vmlinux.a
>    >>> defined at secretmem.c
>    >>>            mm/secretmem.o:(.text+0x0) in archive vmlinux.a
> --
> >> ld.lld: error: duplicate symbol: memfd_check_seals_mmap
>    >>> defined at gup.c
>    >>>            mm/gup.o:(memfd_check_seals_mmap) in archive vmlinux.a
>    >>> defined at fcntl.c
>    >>>            fs/fcntl.o:(.text+0x0) in archive vmlinux.a
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

