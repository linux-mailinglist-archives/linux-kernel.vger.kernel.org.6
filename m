Return-Path: <linux-kernel+bounces-370345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDAF9A2B52
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F69F2847B6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382061DF26E;
	Thu, 17 Oct 2024 17:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="khTYB8We";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vqcTSyZZ"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381251DAC9D
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 17:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729187237; cv=fail; b=Vw0lEEi94Df0J1WaDdsr9UOcGDqDTkeE7EWtXFfaR995FGKry7Vl5rT/o0PhbmFLwZRYtNNhX202A5eS9n41U7KUy4K2AwjZHJOlvviLfwuox7i+Gv0kpFE366s7VIIwPEBgjjsfu8sCpEj2nMrixnyDzuz33InTGbGiARi3HBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729187237; c=relaxed/simple;
	bh=NggBljPniNe/hiWVEVZscF6nXY//9QT3iGUZCPBdEj8=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Rtd2S51lzzgL0w7N6xy8m3+Ht46bJtzzEuCgxWO+L3iGu1nyczCyBUyXAlZPh0UHjPwrZBctsPpZ3ELCnZL34gf4g0vu5vL0szxsdmZR0FOUBhSi+hTPGsLdFnGfcOktazeDeTPcZDcTAVi+PTVJJLJIO71WewEarRIPvPwxqO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=khTYB8We; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vqcTSyZZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFBe2F000323;
	Thu, 17 Oct 2024 17:47:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=gkC00H1BZ6RLX8Qu12
	o2OJ8Gl5uMk+t+jQOcxp/sWyM=; b=khTYB8WeAlNWUReguiXF3jkQT8UoMDanIq
	2Am7lLvy0xJLv+E3fRsITCAnpMgj6LExvmTFbuQb7uciwjX1ZRO7AfmVobOKzpiC
	dwFsydwBwxLrYGER5eRA6ixF9YUIlwrXkOSxaxfnPvqbvKQpiSXLnR+y3a5m21Fn
	/vCt8U0LXU6NJPZvCMC6m8VVSScNcmvvv8Nq1K60ZBwOcoNiEN1kEP1jAoh+xGRB
	10aTeURfQRFdS8rlzO1z3F/9Cha2rXCMUNQwYIHb39GKwMzwZycj2qMHB2wPeCyO
	VHvv/JflIIBmjynq026eTehx8TzEACcP9PZqz6sqlbbTfbzvUgkg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h09pg11-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 17:47:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49HGZw6U010960;
	Thu, 17 Oct 2024 17:46:59 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjgwjdx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 17:46:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WKaqRf5dynB9WeZRe2OHCg163+1XyideYi2/2NtMGjAS7UWZnd94Bs3eBD7bmv0dDL4X63NRtK/2WUifhb4Iw+GDkb5GbOpCltpCjsRtKQmoAxTZVAE7y0BQC0X6v9DAWoHgNRaAKWxoJOQFGDqYVKDEy/k5Z+G/JbC1RGdi3e5AdoOAMmkBOZJdX5UnwlTbHtFmY6ZoXkTDWeYE1QdY83DxyYfNEgYFgGuWatuBoXnjZX+x/uk1Dl19QUiTZ4XsouJqlxZGaCDkI2b9J8rxD3PgUniS2ax510I6XMn7SCH/j8YCWROkVHZwbYGet454bQLAUBEei3eSnkEdaidYPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gkC00H1BZ6RLX8Qu12o2OJ8Gl5uMk+t+jQOcxp/sWyM=;
 b=QHwd6ho/JwCbtSc53+QYYgI9ru3kFSH0siv0hurwCPlJClJupvvhDFlXsShD60BDd/snHW74Lfx1sJP2nSZw9TNCrmDl3v5mna6fwUxtKQbeLgtGvVfUqtPHU9ScDiMwe12wJDzmzoEtFqXUKHhalfKTv+5ILsq3kphfQoAEyV6m7hawB0rVf0O5CQiBmGiflb72kc5M1+skjFaHpCqc62Ad9jPPVl3ZnhyJwXIoOMAQfdyn2CLDPivhXcWRwcIZ7MIVNrEXJWzVuXQU+3hfydIsUOXt2fLpEn8vMRdg7QBmeI3ZVzJ4edHhKuRFmIiJBq1BvSUH4sUFuEuedptoUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkC00H1BZ6RLX8Qu12o2OJ8Gl5uMk+t+jQOcxp/sWyM=;
 b=vqcTSyZZtpLok4TO+wCCE6liz2SQoPAmZ4CEG96qHAmuC8ZnitMXNtFn6AjJDjpZ7Lo27JMAwyr1RQk9lCJdeIH642xN2JCCzSagFKWHias6a0L3MVB0PZ9Cq+Mlphot8zVp80ackXp4DYvaC1UlAG1VGjoFTVBWfYEhC6TBgqQ=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by BY5PR10MB4305.namprd10.prod.outlook.com (2603:10b6:a03:20e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21; Thu, 17 Oct
 2024 17:46:56 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 17:46:56 +0000
Date: Thu, 17 Oct 2024 18:46:53 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Oliver Sang <oliver.sang@intel.com>
Subject: Re: [PATCH hotfix 6.12 1/2] mm/vma: add expand-only VMA merge mode
 and optimise do_brk_flags()
Message-ID: <de29fb6a-625e-4950-98ca-490535e07843@lucifer.local>
References: <cover.1729174352.git.lorenzo.stoakes@oracle.com>
 <4e65d4395e5841c5acf8470dbcb714016364fd39.1729174352.git.lorenzo.stoakes@oracle.com>
 <srdmj5c2yb2qshyp2nkujk3tbcilkoaryzevchkv4rzeps63kh@rw3kkagts3o4>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <srdmj5c2yb2qshyp2nkujk3tbcilkoaryzevchkv4rzeps63kh@rw3kkagts3o4>
X-ClientProxiedBy: LO4P123CA0567.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::20) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|BY5PR10MB4305:EE_
X-MS-Office365-Filtering-Correlation-Id: eb448b4d-3d0b-49e4-d00f-08dceed3b160
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B+iN0ZOjXeSCdPhzsa9i2oNGDJdRpfu4jImdckvY8XGcxdC79KKZVZLcMA8D?=
 =?us-ascii?Q?rHPCKRQ1QbNp0jn7dhVwHq14lXp7u482NDvj1yuCSw4U8tqRWp0eAJK/+vJT?=
 =?us-ascii?Q?uqAMXj1l+KyckxaUl/OcWA+DiIsMUKoQrOl5BBFGbm1sclF6LikIiLj+eFB4?=
 =?us-ascii?Q?O6GwbDlpcQXlgGcMyBnBdq4r882j2WSiEXlfWcgd7fgz57ZINcYixtp8pFy2?=
 =?us-ascii?Q?ZGSXvwpJtzvWR1rkh7sQRNo+UE4H2H0G180QDSKPXNRERAtGLBmdIXkN1wMv?=
 =?us-ascii?Q?xXHtLaIc4OTKf5bOL9dW8eBAel5m8OeG2VgplESWZ2yYYgxSGSCU5Y/F48eV?=
 =?us-ascii?Q?qlYXqvLMY+sAMREPMk/GKFCxi9suecxRSJBYS5Hs7N4dWO/zJY2yjF2qLU2H?=
 =?us-ascii?Q?NezN6hl1FXZMYln3cD49Asu3nyDvvXuCRqoUkaBrN7ymowmEcARcscN4nenJ?=
 =?us-ascii?Q?Pln9J9cwezRFToMdB4AF60NEGFWRGSsSrF0kswmlGTo3I/QBinrvYSfTdErc?=
 =?us-ascii?Q?cQhqN7/J+/DmIgerAxgkiDGvGWTiAMfYg6iy40Yv4AbJz02izl8jJMcVBgmD?=
 =?us-ascii?Q?1ICR9hm8WTn2x4d6mhXoMNDJ/YiArp31DDdemHRH77IBaRtlelBMViCpAGr1?=
 =?us-ascii?Q?CfvSh6mbu6nloYiJ+oWhOa4cP7FKYt+6xMpFm6feMuGu4QrQQSA38q89S0bp?=
 =?us-ascii?Q?XQwdsdqHC6mIxQs9DRd8+xElcrPm5AtnSi0pZuA35Oqr1nbdMAJNrveJZa7e?=
 =?us-ascii?Q?GdpLYJQZtEDb3VSMVKUwlZchl6zI7He9C7tcOKGE+G0Jzt8Jr9oiq746mkOp?=
 =?us-ascii?Q?mvKILJaO6fdhGId27NPgWm6rrApmGptNGWwQvY1O1DJ4wokSb2jQlRoa2S+n?=
 =?us-ascii?Q?qKtBtZe+zo4i+i6vprXyFwuZfwIdHz0OjUi2nZLyJFImi2VAA3jTot4P9Rl8?=
 =?us-ascii?Q?MTc0n3qQqjlcrpIsy0MlxZ0nE8pgelCmJoHP13+dT1OKzwGDyi6RDrXPHC/t?=
 =?us-ascii?Q?G1+RDXNywuqTDGmfNXQSj8IY8s0F1PQ6D7spP+H/0ub9wH3ykbKWkhof04cA?=
 =?us-ascii?Q?GxJ/G8hLJb5xVrFEJ0RBT/fYa9fNvHFUWhbcRLdk66GVFWYvkm0/i13gTJvl?=
 =?us-ascii?Q?GHHwsWayk0snTnWV4v8rFhA/JPXgl7cP43erAP1uB2QGtxm1S1wVID1eS4Qi?=
 =?us-ascii?Q?NxASE4XhtPbvriuZH6yXpyWE5oepbYajzqpWKoN7jC7X7H5JpBzdvDmsxH8r?=
 =?us-ascii?Q?Rr429lfKm+jtcpCp/9Rhu6rlVgEEPBiE5byXCRXmecBE6qKaCz57CCwhA4Lc?=
 =?us-ascii?Q?Wjm35TyFFYpMLADpkCnFUjtH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xnviM8riU30HLDpbaye317wvs6p+x2apw/PnC+J+mIHCKLec7VVu9mrzotjn?=
 =?us-ascii?Q?NEb6VLmSqKEbqKT6+Pawhk9Hu0lwxwUn5flPbhsOl+EDLnGjIEpRZ+IJr57A?=
 =?us-ascii?Q?KioHBtsTmI223K9gu7Z1F+crgyQXd+4+XMmbf69LBDQEnQVwgaIZcbeiiLwB?=
 =?us-ascii?Q?gZsD/ZiMncM4MPjEOt71OwVNiU0fp4Pjbln0nAvhQso7JXQLlCWqxRRVmzHd?=
 =?us-ascii?Q?hx+S+7PCgDydZ6SRg2L2DNB0ouz+2otOdcloDNo/AQ02jfsBXgwIGej7O6mi?=
 =?us-ascii?Q?zYKfT6z6gS5PwKPzn+idRiWvLODzgWXZMmLIMI3LKEpuyrfR8jFt50Rl8DeQ?=
 =?us-ascii?Q?5Y+0HsJxNS72FJvPSLslbaZv34y1yjsoDUs+lLXfNefbIA/v3U34jq24HPje?=
 =?us-ascii?Q?B//gxjL2Mk8VrzrD8ztxS7rfeRuJLyG8apZ+85918uBDmzK7lrTs3cheXaS0?=
 =?us-ascii?Q?3lIMTxtiKuA5QTD0YanuSuDd+vEofKMu9rJs5db3BnVSJqxyFs9dqiDuvbCY?=
 =?us-ascii?Q?v2l4vsVPPZ+hyb/Dj7qKQAvu/Qk0Hb2kiBlMXRuPVqISsUskL0TZk1pcTqHz?=
 =?us-ascii?Q?w6I3nJIisZnTu7YGSDinv0rBdeU3nojhUMQ/XdEcue9BQckwyzxtQKTClHal?=
 =?us-ascii?Q?0LgaXRAaYKfHmPJxi7MrU2Vg4DPFyrHZ9jUZ5HrKQEVgMLUyXkqnOr1HOC4v?=
 =?us-ascii?Q?bAJ8Mm1g5qbAqONp5TwHDkZi0+mMiGLjDEvOkKGe5dFRG9tUIZNW9r+N6tsA?=
 =?us-ascii?Q?sv8PpKqyCRlUxSjsi114XM9UbsMN6kITHfnE689P80ZTljdUq9rVOwU5bU6v?=
 =?us-ascii?Q?ZlaUePtAFQvsvXUdgjEX5jGH8IOHc7i+7/Zf3Q6BBts7z8eZKRxf7tU871oM?=
 =?us-ascii?Q?qDxyv35o4F9BZUpeErr/U6H87fTQhV4zgoG+sawc7ynMJY5cIEQlsFtUT481?=
 =?us-ascii?Q?WfIKSPgNmcVfSsGDxSQeOmEuiDP3uy27Q3ig1IkDa4yzneF7SXWCdpmapWD1?=
 =?us-ascii?Q?/K8rItEGIXb5FXRmpPb0tpZSe7LnkKGvMMhFAgVrqCqiBC0yLA2/Wele5KB1?=
 =?us-ascii?Q?A2IGClKH/qsgCYqvmcRTiFHP/FrTeY2YjWmScA4VOSnE6WdgHQ/WUKDZ0GgE?=
 =?us-ascii?Q?JsjZJo5F26pA6DW/OGfBbtWFB0F08kSOjo0QzyIakG5TQALAP2IQwnXnhX+R?=
 =?us-ascii?Q?wkW1nafukYRGDfWmijCkjUskjAa0ea2YcASUH4I2vwqHgZhCbuMjTVrVYQYA?=
 =?us-ascii?Q?G/6/Aa6ETjwvpJf8QtBP2cAzHm/iFxZdg6jcw0sTtuqPGTVw/F3FYRzVDasL?=
 =?us-ascii?Q?R302SAd96yhcKw4UI9/HjymVtqCE5o53ngynrueFngf7mn8/hKYl1zKRTyAu?=
 =?us-ascii?Q?NlJsPOp+q8x4s3Fu67Fuh/5l1kjKsVh0DKATiEjHO+BaHegl+bcZKo6rm03x?=
 =?us-ascii?Q?UU9j3I3CSTTyBpwObaiGn0JULDgtVP9Bht5+yrrfSYcqrZ8WcfdWf9DyfKS9?=
 =?us-ascii?Q?vv8YyqaYxSF6DrjvK9LoL3NsNtm/bghqDRWW3OxN/YTc+l6zrGAwKsiyWSyv?=
 =?us-ascii?Q?qG+hOKR1PedzUdcG3EIEtjJbsHBlc6xd2tAA6ZRKDixKAWPsrZHNdJHvkWo8?=
 =?us-ascii?Q?Ug=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	k+d1AF86SaKLL/33dsH3WuFpnJozs0IXteZOHctt0CR1cLqpp96ZVseh5JbJx7IqW9L4VALYW0gdvebY0O4ADix6cQc0oeRQpyHlDpE5v+Khq6Kmdi2IoYFLxGWzo8JIMWwcA0ozBYMPPPC4IxZsqEbyTL7KRDiSVqezBqJC9v7MBP6eIvkCA5ZxFOeEtdop9o7Zvq6eUZg2WYTtC3/rNNmyZNHZx6WSL9adNcWAwfuoJd8oC2HCNyAgIdocawoGDGEAVAQXTfgx/41dweGdVH8oDVKYzrdzsPQi2WZPoPGpdJ1j5eAeRaBO6Svuw88oiHtcX6ZIq0M7f3sZ77VRsYpFqtsQPW3vkDILY9xE5m3oV8qXG5+KgXNcb8lG05Xunl7WR4daKjsvGABU4344v7ub8RYNxnoxxmZXEH8eh2VckRG8XdrMphqrJlMezFLIWa+9iE1/9ibpUH87JMaDDFOvN0Wqbmja+EJWSBv/pf2UOKLUr+PtVWGG3+6bnNX5zTyLkGhCsQsG184aOjFuk1G8LtGpwXz0E49MD8mQAqtyj6alyEpuMotw8EM4IB5as/6FZI8qV+c6R780Lt5l9Tmsm/Um3Efkg/585cD6mwI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb448b4d-3d0b-49e4-d00f-08dceed3b160
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 17:46:56.3704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xuJCn8drmmq/mlpjKF11Qp5k8V+X+zNSUoZHOBAD2RdZOcuQjGgJv1LzrAgeYh3vLh6sTkf29ol4pha9P8F6Dr4fYr2hmVOu1HrRyIr7Tgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4305
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_20,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410170121
X-Proofpoint-GUID: yBmtd6qRyC3ucW_IVmWaFDfBlcLszkh8
X-Proofpoint-ORIG-GUID: yBmtd6qRyC3ucW_IVmWaFDfBlcLszkh8

On Thu, Oct 17, 2024 at 01:41:15PM -0400, Liam R. Howlett wrote:
> * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [241017 10:31]:
> > We know in advance that do_brk_flags() wants only to perform a VMA
> > expansion (if the prior VMA is compatible), and that we assume no mergeable
> > VMA follows it.
> >
> > These are the semantics of this function prior to the recent rewrite of the
> > VMA merging logic, however we are now doing more work than necessary -
> > positioning the VMA iterator at the prior VMA and performing tasks that are
> > not required.
> >
> > Add a new field to the vmg struct to permit merge flags and add a new merge
> > flag VMG_FLAG_JUST_EXPAND which implies this behaviour, and have
> > do_brk_flags() use this.
>
> Funny, I was thinking we could do this for relocate_vma_down() as well,
> bu that's expanding in the wrong direction so we'd have to add
> VMG_FLAG_JUST_EXPAND_DOWN, or the like.  I'm not sure it's worth doing
> since the expand down happens a lot less often.

Yeah I think we have to carefully profile these and go case-by-case. My
initial series to fix this made things worse :P as usual in perf developer
instinct (in this case mine) is often miles off.

>
> >
> > This fixes a reported performance regression in a brk() benchmarking suite.
> >
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/linux-mm/202409301043.629bea78-oliver.sang@intel.com
> > Fixes: cacded5e42b9 ("mm: avoid using vma_merge() for new VMAs")
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
>
> > ---
> >  mm/mmap.c |  3 ++-
> >  mm/vma.c  | 23 +++++++++++++++--------
> >  mm/vma.h  | 14 ++++++++++++++
> >  3 files changed, 31 insertions(+), 9 deletions(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index dd4b35a25aeb..4a13d9f138f6 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -1744,7 +1744,8 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
> >  		VMG_STATE(vmg, mm, vmi, addr, addr + len, flags, PHYS_PFN(addr));
> >
> >  		vmg.prev = vma;
> > -		vma_iter_next_range(vmi);
> > +		/* vmi is positioned at prev, which this mode expects. */
> > +		vmg.merge_flags = VMG_FLAG_JUST_EXPAND;
> >
> >  		if (vma_merge_new_range(&vmg))
> >  			goto out;
> > diff --git a/mm/vma.c b/mm/vma.c
> > index 4737afcb064c..b21ffec33f8e 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> > @@ -917,6 +917,7 @@ struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
> >  	pgoff_t pgoff = vmg->pgoff;
> >  	pgoff_t pglen = PHYS_PFN(end - start);
> >  	bool can_merge_left, can_merge_right;
> > +	bool just_expand = vmg->merge_flags & VMG_FLAG_JUST_EXPAND;
> >
> >  	mmap_assert_write_locked(vmg->mm);
>
> Could we detect the wrong location by ensuring that the vma iterator is
> positioned at prev?
>
> 	VM_WARN_ON(just_expand && prev && prev->vm_end != vma_iter_end(vmg->vmi);
>
> or, since vma_iter_addr is used above already..
>
> 	VM_WARN_ON(just_expand && prev && prev->start != vma_iter_addr(vmg->vmi);
>
>
> Does it make sense to just expand without a prev?  Should that be
> checked separately?
>
> Anyways, I think it's safer to keep these checks out of the regression
> fix, but maybe better to add them later?

Yeah I do think it'd be worth adding some specific ones. But yeah perhaps
let's add those later!

>
>
> >  	VM_WARN_ON(vmg->vma);
> > @@ -930,7 +931,7 @@ struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
> >  		return NULL;
> >
> >  	can_merge_left = can_vma_merge_left(vmg);
> > -	can_merge_right = can_vma_merge_right(vmg, can_merge_left);
> > +	can_merge_right = !just_expand && can_vma_merge_right(vmg, can_merge_left);
> >
> >  	/* If we can merge with the next VMA, adjust vmg accordingly. */
> >  	if (can_merge_right) {
> > @@ -953,7 +954,11 @@ struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
> >  		if (can_merge_right && !can_merge_remove_vma(next))
> >  			vmg->end = end;
> >
> > -		vma_prev(vmg->vmi); /* Equivalent to going to the previous range */
> > +		/* In expand-only case we are already positioned at prev. */
> > +		if (!just_expand) {
> > +			/* Equivalent to going to the previous range. */
> > +			vma_prev(vmg->vmi);
> > +		}
> >  	}
> >
> >  	/*
> > @@ -967,12 +972,14 @@ struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
> >  	}
> >
> >  	/* If expansion failed, reset state. Allows us to retry merge later. */
> > -	vmg->vma = NULL;
> > -	vmg->start = start;
> > -	vmg->end = end;
> > -	vmg->pgoff = pgoff;
> > -	if (vmg->vma == prev)
> > -		vma_iter_set(vmg->vmi, start);
> > +	if (!just_expand) {
> > +		vmg->vma = NULL;
> > +		vmg->start = start;
> > +		vmg->end = end;
> > +		vmg->pgoff = pgoff;
> > +		if (vmg->vma == prev)
> > +			vma_iter_set(vmg->vmi, start);
> > +	}
> >
> >  	return NULL;
> >  }
> > diff --git a/mm/vma.h b/mm/vma.h
> > index 819f994cf727..8c6ecc0dfbf6 100644
> > --- a/mm/vma.h
> > +++ b/mm/vma.h
> > @@ -59,6 +59,17 @@ enum vma_merge_state {
> >  	VMA_MERGE_SUCCESS,
> >  };
> >
> > +enum vma_merge_flags {
> > +	VMG_FLAG_DEFAULT = 0,
> > +	/*
> > +	 * If we can expand, simply do so. We know there is nothing to merge to
> > +	 * the right. Does not reset state upon failure to merge. The VMA
> > +	 * iterator is assumed to be positioned at the previous VMA, rather than
> > +	 * at the gap.
> > +	 */
> > +	VMG_FLAG_JUST_EXPAND = 1 << 0,
> > +};
> > +
> >  /* Represents a VMA merge operation. */
> >  struct vma_merge_struct {
> >  	struct mm_struct *mm;
> > @@ -75,6 +86,7 @@ struct vma_merge_struct {
> >  	struct mempolicy *policy;
> >  	struct vm_userfaultfd_ctx uffd_ctx;
> >  	struct anon_vma_name *anon_name;
> > +	enum vma_merge_flags merge_flags;
> >  	enum vma_merge_state state;
> >  };
> >
> > @@ -99,6 +111,7 @@ static inline pgoff_t vma_pgoff_offset(struct vm_area_struct *vma,
> >  		.flags = flags_,					\
> >  		.pgoff = pgoff_,					\
> >  		.state = VMA_MERGE_START,				\
> > +		.merge_flags = VMG_FLAG_DEFAULT,			\
> >  	}
> >
> >  #define VMG_VMA_STATE(name, vmi_, prev_, vma_, start_, end_)	\
> > @@ -118,6 +131,7 @@ static inline pgoff_t vma_pgoff_offset(struct vm_area_struct *vma,
> >  		.uffd_ctx = vma_->vm_userfaultfd_ctx,		\
> >  		.anon_name = anon_vma_name(vma_),		\
> >  		.state = VMA_MERGE_START,			\
> > +		.merge_flags = VMG_FLAG_DEFAULT,		\
> >  	}
> >
> >  #ifdef CONFIG_DEBUG_VM_MAPLE_TREE
> > --
> > 2.46.2

