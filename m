Return-Path: <linux-kernel+bounces-418196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DF79D5E7C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 12:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4841B1F22ACF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 11:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B521DE8B6;
	Fri, 22 Nov 2024 11:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZCdETU8f";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="b7Gm1D1x"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26491D7982;
	Fri, 22 Nov 2024 11:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732276671; cv=fail; b=DyFkev22Mos1vht7Of3/coQ72W2jNNkGWvjdhwuGX84K51kXjvGzS7qp7B/3qj0NsIxheEmdbhPAglR2OF8Ntd93GbJN7ZxwnXmCTg2nhPnFAZGvcSDbWnz2PStKVvhA1yd+51SEJmJbK1TTHt4UQtVP7KLxLAfUSxU1XEoXr2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732276671; c=relaxed/simple;
	bh=tEIkIcSXlWt9aLmSoJij41Iqg2BxMyGJd+B/5qk4XIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P1wlZV/ODXLX61A7dxSdViDLBxn8VbuhtYTrZqQQq8ohvcZari0IswpHwzmU+tycFOmXbp1r/i/6NLprGzcVMmmbs2bd5YJD+9l1XXQofjWKfXqiAVKDCObVuP+RzyTlxKPzZpAboiLy5ljJj597hn46O+b63McqzrDKiKk1I/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZCdETU8f; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=b7Gm1D1x; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AM1ti3O019505;
	Fri, 22 Nov 2024 11:57:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=tEIkIcSXlWt9aLmSoJ
	ij41Iqg2BxMyGJd+B/5qk4XIA=; b=ZCdETU8fmucls24gJnLKhZ7/iKivDl/Pi+
	qasbeiApdSfNqKIaN0YvUCYpQT/iNq2h5QwRc3tl0fK+JkQfJI571tf+WIbFyChj
	ojBaTMS3G2twhLtzW/IyUOd5eVwqKM4i2ES2CYKrLLSqod9OkRsry3FS08KzTV3E
	2B0GWvgXZbTtAnVN7Iv8fJX23YiR4pGWGzR+QLethWwQYPAjdB74mBlkl4KO1I3x
	VtaeN9r7jNz4iZEdXK/QMs6dAk1K0ZkRaEVR/9vLbczGoZBSBEvTQBH7Ae57LkPy
	sMvCy5PxkDR/NpnrAfMRke++GFYyVajptg9P66A4TIkSIfszPs9A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xjaabseu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Nov 2024 11:57:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMAlYpa009110;
	Fri, 22 Nov 2024 11:57:12 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhud8x17-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Nov 2024 11:57:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gXNqFPUA98bG3frnt0JfKgsVwrSRBJoHC/KzeeKcnl7KktVXxELxgK7y4+k5WQ36G04stE5icj2KCTq4Nn0XPr+Z2h5kkcvWciutPs3T5XBhN3TOSBIj/18sbVEt+KYjHb9omtt0Clqmcb5VqcundzMhjVO1PgRgmhFYFLfDv75cdEtdsg2nNU4GVjqDVL4JPuNJCZ47uw8OY7gx2XTl32zUAJe6yyl0SfYIX7g5UX0VV1R+Ye0FtLPzyXV2Uxp1W1FU86uQv5ZrclDacJI+J4TqthpAxq4NjJec4DIHeg35+6VJUmcgBfic3RQCT8m6NfZ6EoHsmbIb9wnNDanB8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tEIkIcSXlWt9aLmSoJij41Iqg2BxMyGJd+B/5qk4XIA=;
 b=AO18Lna2gXBZcdhCyD7DjIr4RY/L5dHPmhX+YhoVz9wjzT8SAuBpEEI+5hdgZwy8KyeMW7rtO2l5sDgudUDJq28oalBm4H5xQhUlPrNzJ9jKda4DDOMjqVjjmm6L2Y0NlrSp2VsykN/6sCk5JSKsTXVoSSNnygNJivTIKWg6WYaaNpvZdsnn2rz/yxgUT4dNvNek/t6zzW40y7saebXcdgiCLipFXUXswgwJ25uSe2n3Jqka9sxnwFxYdjQJRkhjlNKOUetwdBIypjY8vlL91n5ghIxn9MFpSj5i+x5U7fmh1F2dG9HjKjt3aLUMwOijI8IpB2IoZWzYmI/Oc2Y0lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEIkIcSXlWt9aLmSoJij41Iqg2BxMyGJd+B/5qk4XIA=;
 b=b7Gm1D1xaa7xvxTUhyEW7oe66TgOgaw7pE2XAPNnFp++zPByxnsNQnOxBIjCGCRYver1ED+6Vclz+hMpUt8LwbTVh9fe1+dIL6H2AgE5gxcYffEUtiu4jzNtituG1/GAJGRPBMdxOWUms01WtKdIK5Y279wJELnCNgczrNaXZas=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CH0PR10MB4937.namprd10.prod.outlook.com (2603:10b6:610:c5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Fri, 22 Nov
 2024 11:57:09 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8158.023; Fri, 22 Nov 2024
 11:57:09 +0000
Date: Fri, 22 Nov 2024 11:56:48 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
        Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        liam.howlett@oracle.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com,
        mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com,
        oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org,
        brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com,
        hughd@google.com, minchan@google.com, jannh@google.com,
        souravpanda@google.com, pasha.tatashin@soleen.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v4 0/5] move per-vma lock into vm_area_struct
Message-ID: <e71408ff-b088-48e6-8b18-bb846a60cc1e@lucifer.local>
References: <20241120000826.335387-1-surenb@google.com>
 <hdvig2tptf3hi6nmszafarzqb6j56abfbebppqmruvpihlf435@46b57hyw2pfc>
 <Zz6UTvERgg9ubRu4@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zz6UTvERgg9ubRu4@casper.infradead.org>
X-ClientProxiedBy: LO4P265CA0130.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::19) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CH0PR10MB4937:EE_
X-MS-Office365-Filtering-Correlation-Id: 9638dfe4-58e7-4a74-016f-08dd0aeccaa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0XySbeJb27j20Z63+cBMY2D9QULRkm9KOi6ToBU7engN14rbgWyjmyfEYSxA?=
 =?us-ascii?Q?w5oZIwBpZX+NZs9WhmuXZlj7ECEFp/cpulPWBRK/9HVtTBHc7SrY1rUPIXyL?=
 =?us-ascii?Q?IdOhi/kq9MlMQ9Ip2qqYfDdeldXDgJA1YvdEsqw8/ETfg+HG2KX+Yvbom/Lm?=
 =?us-ascii?Q?G5TMz/QVcg29z+9hoHK+VsoqBor1I0atqCRD5IR81cKFjHAd7VgRRrRPpKoZ?=
 =?us-ascii?Q?LwxUpbFFSlSRcY1HhJ1bfAywcXZBxaRAResIuQ+m/78Oz4NPs4d13VmoyiZn?=
 =?us-ascii?Q?BzTxDGxFuHqklC6DVpjcqYALV/bQqeSLxwWF6f9j8FqmPNy4S7vGdWFMB8o/?=
 =?us-ascii?Q?24Vj+3OnoStwalNViXRZ7oHMoPuSSaKup4LZO3/73WCEYZzKtlXZM+jxjyiC?=
 =?us-ascii?Q?VarwBGJfCS7Y/zwT5iBnjQETqh1LF1bGvDAstgq3IK8G0eMNtYyka0C91mJG?=
 =?us-ascii?Q?SPSyPwqWIXxtNqr2qxz9Eugq5Zg4DQ57fFPlgK54Nrpc16u2l6CY0sR4sP0t?=
 =?us-ascii?Q?/k8IfomPoGe1Nm4+7ZZfry/wZCe5kzQXEVzjTgreKNeCVY0BUOBpLHhdVMYh?=
 =?us-ascii?Q?Aq/0li7qeUea2xbfZuBUG/lydTcwPMkyUySGSIBLdxhAJLdmC2AUWi5RZsMs?=
 =?us-ascii?Q?vZHaLYOa4XGgyFFAss64iVZT4AzhvcTkFeE3prWQGuAnFJjShy90jnoUuiu9?=
 =?us-ascii?Q?wwEc29B1/3JxhdSH++6SmxUufTEzPe0iXMnO1tJ1+X4xrKUJIyMs5aEoIqyl?=
 =?us-ascii?Q?xcdhfvR1zed+gwlFKRmf6zkzCu+KOffXZQXgleTLqUMeDODt/u/Ezj6BeP9g?=
 =?us-ascii?Q?d0lYN69GFYXxw11hdwLabrI7NHnushqJEYPerW3fHFtz7HtTMnhqTTLvP6x1?=
 =?us-ascii?Q?k2OQO1uLwygfMxKGIs1LMmddGUy7BgyeZ/w4QRX56DwxoBTicBJrDEtFKWu7?=
 =?us-ascii?Q?ztTB8+M3aD91AKvdXClRwjz2z2fLp4FH9qenT5ZCDTG3hGPhbcJmGkMispQn?=
 =?us-ascii?Q?NvUzmZqRAI4kL/sC+buD5sEjPgiv7SNsVypFXQqx5EU1USbUc0yP20S7tZ6C?=
 =?us-ascii?Q?Ee7V1MdRbovtIGrQC6Dy9ZdQojV7DBHS9eOWdMkQ7CwKe1rVgH110/1+mHs9?=
 =?us-ascii?Q?+ufUNvu8qPlWerpL5Oovh+286cqVolrJNQdwPpAFmtqi3BbuyVUZ4sCuO5uN?=
 =?us-ascii?Q?FL2Luv6U86MmKQoAGlsCUidRdLpkj2p5ZPymB2TNg+2wkcEyegz/UmgbYFuW?=
 =?us-ascii?Q?1zMi+5bNTIPDwBTciIUq9vmqiv6Ki5QiZnCrcxw+B6cBtyo0I5U0IpDo+Vpi?=
 =?us-ascii?Q?mnNXy8nDFWLoyFLsJNRxugfH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zKVRzgsN0KDlruThoqmivldR2vzkoxZlC/uouhmGGjlIRQp7YdDzkZ37rQj+?=
 =?us-ascii?Q?nuSroxSWZFywIaXWhVb28I5Ivn4pW04Tx3/QxxADd+jPhi4szabG+b9m2zdS?=
 =?us-ascii?Q?BRmUFOHEV1ut2Y3ouTR1KUGYSeYtwFAGYcp7euQ2VnDd8XvyTaJJRHYEMXTx?=
 =?us-ascii?Q?ZuP5G5LRwToz0G18IGKEaBzl674ZxTt8KAxJc1dbZbSfCQrN8PtdJyfKEcpv?=
 =?us-ascii?Q?Ez9JPuVcKlabh5E+UrASshmKYEfsZo9t1PeKAf+YNXDg9P2Oqi1PZy/yAF2h?=
 =?us-ascii?Q?NEXAdnfJGVkXhiwY0u05Tkjvat41+eaPpIAgPYUL/iBIspwMA7C2TaACwOZV?=
 =?us-ascii?Q?Yxk/W9GjndqCez44csvr5YjYTDScj3EUXO4qpzWYJHbqbNb/jmsi0Q/b5pP1?=
 =?us-ascii?Q?FsXGhYMXzdoZ6LwhGYztIR0PQobEkcqq+t/zn+S03j61HhOHEejPLDm3nfm+?=
 =?us-ascii?Q?8sP6F4Ol0FaPjMC9jT31a+iCnJJQJc7XFVmD2Ds/EXnjfC+gprNAOAeuw47Y?=
 =?us-ascii?Q?b5N9W840I6UXkrn25hquwp4rNag2XXftKcsxPOuKBXP0WpANkfQ4756aNtpb?=
 =?us-ascii?Q?lIhyd6Fgp3lTsnYilWqvMwOaSBe59AoIEvFK4+HxWWhmZ7Aa5NpiJMbzKzFx?=
 =?us-ascii?Q?JfqUCKO8Pv62sGvC9Z+txNs+67kRyx9C5XI+aNCcqdE2rpq0adrbDZH0PLmU?=
 =?us-ascii?Q?HzbnQf3W/MfuENO80egaHsApGTovjTqK0q3lFS2f5ZBlY0KIVl/B0OXXrGSk?=
 =?us-ascii?Q?BEO5k8eRU3yC4UiC3WLFDJwJ/xiK3DJ04E3eXDYmsgGKXfkTbt+8uYWKM54e?=
 =?us-ascii?Q?PDPaCBA4GPgp8RgI2TRoW0gJdAvCDD8worxGIF5PpPuoJHBFmqWgHIXGC/lg?=
 =?us-ascii?Q?uC8kSMoo/NPV9ZkcMQYfY/YI9/0Boc4bxeiOZpo5MHdymKmcwSq9OUrwOU1y?=
 =?us-ascii?Q?szpZW2/p6DoVPg5Bs7oUAAhwrKFnhbaal5iiBAcwtIujrK8SXCG5MC1XF+rM?=
 =?us-ascii?Q?JKDnjk3YFiXpHOEXsLituiBZdkL6XrzYhQk1OeAbrIozIFbVTxi44eErYfsU?=
 =?us-ascii?Q?9EkcHVyv2pRuf41l251MkTeMvHdxLXa6Zw9BAKAFx1KM813vzgoXsyA0kISK?=
 =?us-ascii?Q?UgNZB7gga+nJ/P6cZ21uBvkVPvj0nyP5vrhme03cjQmlOpAzhfnazgJYRJEe?=
 =?us-ascii?Q?KuDI0qERDwzVFF5fSB+frkyjdaamAzfnKFmqvYrYSAY27QB+apQWol9Rpixx?=
 =?us-ascii?Q?1qZXIHLXpcIhvYU0shpJ287viFSL3h9byj06Ed7J3tkwQXWx7XGT5Zf6tlZI?=
 =?us-ascii?Q?1bHTwhFgT/0SZxZ5HEVAiAZj72r/4W5DN3nfIp9zH9zw7ycZtVn9LjAvwrN4?=
 =?us-ascii?Q?wsKjCKv2GzCZ0rAFfXmDB9x3g4nVGAFmQb6cyDC0EkNN+mT4fIDjMeyK4uG8?=
 =?us-ascii?Q?xaqnNSQngqoeWnhEKyaKb2J9EA0XB3yAqe/dOdMyTktjAc0f0FTCr2zZHAVh?=
 =?us-ascii?Q?QaLsb0YmavUyEtsRrEEqnQtDhB2/qcDHnr9AscNKw4MfbteOI2SsKDMS41vo?=
 =?us-ascii?Q?XyEhrqOtxn/bOKQDWwwV/xlQGIZyaaPkNmaWhPtM/HPmnFFkThgB4HCpd2At?=
 =?us-ascii?Q?EQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UPArg+ZWF79yf1Xy9JoVepGkMlj345iXG72EMJWvAIaCF/CZtrOmkIaOCLFt4ClqWiGtNCN52WleWGRIzbAZ/HPGp5KTvyC+fAK7Od5DNyXLMYKycAia9uhMy+piyiF50pqmhSyTQHvZWJuYq97dae+fJi1TPRalfWtWx8yAsMLICuQpbGc5vaYIctibE7b7xEmo1K/6NlY9apcUH9EEkOP1wmmOi9XbMDmIf9o9WB860tW0IxUVX+y0HM7zYHbtiWehl0JU2EQEZVBCqTQ+pAuf2xk/Ew8gMcW7sPViqtB1r+NXN1EZLBRQL0LvNiHt1rUw2rxGQsexgxOPvyW1xcTF8k9PB2AlgMuKfaGyAM6BAcpqRuMRu55FFrnQ/vd2NnUyh6Lnp2cRzsKZgEqWLojSu1ABhC1oJyxkoKRxlPKyLrj4RhIuHHyuhSmSvKDNkDUoa1rIrlLQybdmXYYaD121u6uPoYBjnbpy+fVEhelCBYVsxK8ELQe8t5H1Rg3Gn5X4QUVVED6KTtiWimf6EmBYQ4XSHuJFucYLOel+Onqx2L2j+5MiSdKx0gORtUaPptKhl7oeZSYwt2up9E6VIYWTWcZQ5jlrV4A7bjZBpGw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9638dfe4-58e7-4a74-016f-08dd0aeccaa4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 11:57:09.0117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 42SuUiHGtCP4msj8R4sW30Xk6qf1VFLtEFnifQUogD2DW/rdy4Y6r6qWYVN2dehSfktuSo2s2313stXXWa4rwaQDLpTOHV4hLJcsY4i4Eus=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4937
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-22_04,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=991 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411220101
X-Proofpoint-ORIG-GUID: KN7FB43zQXr1iO7vHdqS2wfHdov4gJzF
X-Proofpoint-GUID: KN7FB43zQXr1iO7vHdqS2wfHdov4gJzF

On Thu, Nov 21, 2024 at 02:00:46AM +0000, Matthew Wilcox wrote:
> On Wed, Nov 20, 2024 at 02:10:44PM -0800, Shakeel Butt wrote:
> > If 'struct vm_area_struct' is prone to performance issues due to
> > cacheline misalignments then we should do something about the
> > __randomize_layout tag for it. I imagine we can identify the fields
> > which might be performance critical to be on same cacheline or different
> > cacheline due to false sharing then we can divide the fields into
> > different cacheline groups and fields can be __randomize_layout within
> > the group. WDYT?
>
> Pretty sure the people who think security is more important than
> performance are the only ones who randomize structs.

I agree that I don't think we need concern ourselves with users of this
setting for precisely this reason.

I wouldn't want supporting this to cause difficulty for users who do not
enable this when those who do aren't really concerned about the perf issues
as Matthew says.

