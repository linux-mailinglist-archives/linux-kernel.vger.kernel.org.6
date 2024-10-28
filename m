Return-Path: <linux-kernel+bounces-385858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC619B3CA7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 22:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0A4728342B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 21:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE701EE008;
	Mon, 28 Oct 2024 21:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HAKBBP9J";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GV96HfFF"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4448B1E25F7
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 21:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730150923; cv=fail; b=cfFxXN2uIblD6/o17xltZ8K6LqjAN0jPe+gnkn1G0hDTKh3q6y/X0ogiCPUxopFNz7dq6zFJMlW07VTsK5CFaEd5ku75SwGNq7CpcleHwQMle8MuPNXqfFe+a8CQl0GRi8PPmhL1e3kBNyJDU21kwS0zR/EK+Pela81H8rt5tIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730150923; c=relaxed/simple;
	bh=h0X6s6xffbvpBo0SAYvLBtR+DLcwNrwCtLGUYUnaEXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=on8BywjW6L8xz1x7yGonpXuVYePRJaTVmEZ/0IHmzyB5URIZo0V/cqaZy8CFVVgp3uuNfhR8Kqs9JY7rlyMX5qBc0gLUyReLYEZhFk5VRZNJLaqZAkdcxSVgeP0+9PJ1RR5I2XsyTyo0bltNTUFWTI4OR8TGhCpapgO1ML2Ejio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HAKBBP9J; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GV96HfFF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49SKtb1Y031947;
	Mon, 28 Oct 2024 21:28:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=f/SIYhufACABXuN202
	P6QTnajwjlgK4L0bX3mB+7hRs=; b=HAKBBP9JHusIP/jb30hfZgFNLyXXaUZAMj
	9yNDRRL5upba4HO9DFKYs6kbQJLRoH5hX93lcVice9DcSfDsa4IlTdErW4tmeNTB
	p15+D8+PFC/xU+dLc9xQBz2tHyPEUwqRWZmWCm+rmytcnWCAn+eK23BOqDhkPtnW
	Y1k4JqVH6OlbkU31AsvJWmGo5Ge7uAnbSKj4bU0V8LczwVdMAsJKK0yGqEafxJH9
	tMl1riaOvuXujJDSwHOBHEb8KZ8ZjVCAm3fBVHtIyOAky80wURLgFGhB1FtESlVz
	YZY+KQDl95AoGXeUNfy4hO6NgyQM10XFBlUJD5Zu92J8g6Sek6Gw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grc8v1bd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 21:28:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49SJvUWQ004866;
	Mon, 28 Oct 2024 21:28:22 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42jb2t7v4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 21:28:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DSsCaW6xyWhMzGK6j/asJAcwHx6ULPnBebzh45fliTZIzUOKhlQkp7j7PGWXhGmiViuyItU+mB+tHSXqJ/6h4miTzR7kGJdCy2rbELc4gVCudBcxoBY6RmPaRuprRbldI3BUBTNTNppk39oJv0ZROObQlpu5VvMT2VlbZHUtbEgwv2SB0ZuaAyB6HktsIpYRg4QVy+ELdVW9pj1479Qedu30VfjIFnBDFDD1zbzSZs1F+wsY2tWgpJAMauz+5gskTzAfACH+cc/+ZmYdHjvRcdPbXh+vTkOkEldcu+JiXIgg4jmHdi7QzAcgqFkjYXKltVm+1Jc9lbufBG27sJeWoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/SIYhufACABXuN202P6QTnajwjlgK4L0bX3mB+7hRs=;
 b=duEWSdrcYQmOUz+G+V+B8rsASDsEIFrcCRs4uZl146+y7qORfWHPfDfbCtsuySuCN9oxi/assiJk0EKJ4wPSO6kl1bWwbs8SZlEtxcNEv7jmO+JZzNgs8zBiuOmgzS/bcS4qKzFJ/Q+P+uVlMm3Fteq/PknL1fRBrucgYFNs7KUnNtU2Jd51vBgRb9Zlo5m2ffm77vyWy/5wlNVQRg8g+soruzdBlReamOjsa4D/oXZm7lTO+OadVwkGEd9UknwJYwM2L4nBZ6AoreiDHyZwjKtUaW3Fr3Rr9kVUK4T+ZDCimeS0Dnd4Jz44dKcVmmfX0OuLJFBLh0jbi5zpIRg8qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/SIYhufACABXuN202P6QTnajwjlgK4L0bX3mB+7hRs=;
 b=GV96HfFF8HrYefRKqvAtkx85khV5aa7mnt28UnWOkzkiRUFtHaiP1JqPi7r8+wTYp1kNW07dzj5H70wolJE8QnEbyIGoOH4yR18ukUuhLBZUJAPBAs7QGgg5kN74t7zuwb+ZsZYSbidudCOHcg9GIBqUiyOETOHFW0DVo6ux3Mo=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Mon, 28 Oct
 2024 21:28:19 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 21:28:19 +0000
Date: Mon, 28 Oct 2024 21:28:14 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Peter Xu <peterx@redhat.com>, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Aishwarya TCV <Aishwarya.TCV@arm.com>
Subject: Re: [PATCH hotfix 6.12 v2 4/8] mm: resolve faulty mmap_region()
 error path behaviour
Message-ID: <14cb2815-a5a4-4336-887a-01b305e6289f@lucifer.local>
References: <61461dcc-e455-450d-9c01-5465003fc31c@sirena.org.uk>
 <c24a174d-c8f3-4267-87ae-cf77fa587e82@lucifer.local>
 <CAHk-=whD9MrPwPMBgVG16T_u+my8xYtZg2tUGz932HeodVX7Bg@mail.gmail.com>
 <438f50c5-8b8c-444f-ae85-10e5151f3f24@lucifer.local>
 <57mgmdx7wgfwci3yo3ggkmcnm3ujamgkwcccm77ypvmer5tegn@opiq3ceh2uvy>
 <ykzmur56ms7fm4midi6tbncjvcvf7ue4lp7e4orblrmwnefw3e@oa3enlpdrcrr>
 <bea02efe-a695-49e0-b15c-2270a82cadbf@lucifer.local>
 <CAHk-=whpXVBNvd0NJpw9=FGcuTuThwtfcKeM3Ug=Uk6kpChCPA@mail.gmail.com>
 <a1ffccb8-3f53-4486-a250-282ddc7054dd@lucifer.local>
 <91d9f81c-b971-4764-8f21-4011023628c0@sirena.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91d9f81c-b971-4764-8f21-4011023628c0@sirena.org.uk>
X-ClientProxiedBy: LO4P123CA0089.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::22) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH8PR10MB6597:EE_
X-MS-Office365-Filtering-Correlation-Id: 48d318b4-eaac-453c-d368-08dcf7977123
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?POXlVIjyZA7El4gka9AyJ+Aa69huGMnbJEjLghb5VNQho6ySFcEHt41uXQzL?=
 =?us-ascii?Q?al6RO+HQqXEGTLNolo5HF1ma4r8Qow2K0BP/tYiKeQl/JTm5V5E6aFk1s0Ts?=
 =?us-ascii?Q?Ex1po9WMI3flqiywZ0ole5+TZLUX9xpxvCYblnBbhMSqSqvTNuVzVW8syaJ6?=
 =?us-ascii?Q?sEUwJr5GaDYUNG4nVXgtk3tOn0AQxdHv3AE6F8EUlMnqj9PlZI/xFuyeAi0S?=
 =?us-ascii?Q?3EkfiIDR4Di8iXS1G1IEuTbDmFD1rhC5jjwrF6kUhmfRhfSsqM8F+r8fM7QL?=
 =?us-ascii?Q?vay6/KfjSu74+c8RKR4Qxia3SkmNOy13NDzCZUsFD+xixhbiVojoTL2hgubF?=
 =?us-ascii?Q?UDMIyEcgYyJeZtUOSHCgg/rVzWM5s/jn3L9Qh4fdSvFViHTnPhrllpK185cC?=
 =?us-ascii?Q?plHOGc2kyxJJGepo87UW3utt6agdpI+6idw2YibMbzdpKlUWm1Kd6V0dYNXL?=
 =?us-ascii?Q?zUjoFdif1Xzg6HY2XcNfLDHRZcGBH2aXuyB9xug7C+R5/C84RrsiTa09tbID?=
 =?us-ascii?Q?Ml9LiaqPfS6LbL/4l16w4+F60I1o58X2ogxWbBpifSJBIARaaWsqRu2K1WY5?=
 =?us-ascii?Q?ByeUshZ4Fd2nHGJvuiSAH6WcV6RVJudWoJTj/4vPMmOrV4HO+NOz/mMJ7GpT?=
 =?us-ascii?Q?mnm5q4kgounvh+wZDEJAmNZ03C0SXFFbA4eolcy6Moy4UFKS8XrpnPBI5H8u?=
 =?us-ascii?Q?xBxL2GNVGrxv1aYHjchGKMITRs5MaROTOtXz11qWdv2z+MpwhtZkC0NP5e1I?=
 =?us-ascii?Q?njOBjhkUBEC4LsxGyfcsZHV21zxW0E/Y42kKtuKb1I1N1xTM2+s/zKk460/I?=
 =?us-ascii?Q?atKXUBe288tkbx4wthXbM9D0ptyLJqttWEZH5MUkfb3HjIebxswxf02tDdZa?=
 =?us-ascii?Q?scq+VCEpc+3RnQngPjmr4K0ERY1g7Kj8pIlO9zfcYIGWmnJNJdqJy5DXzPxG?=
 =?us-ascii?Q?b/VGK5v3mnr3nZ58ib2GS6eNo1Y5Bdg7eGeNpQOlkXPHvUrtiKnVNbVAFZOi?=
 =?us-ascii?Q?0nGqzC3rK3XFtTn0J7tok06ho3zMWmTZf+qENRXxnVKWhkeVZN6DpIdwuu/r?=
 =?us-ascii?Q?rMnQDVFjBUw79+psaFEOJpVNkEtSqQIXX+N4gughTa0vsbhAjzs/PTvudoFJ?=
 =?us-ascii?Q?L79sn3wvw1oRq4IzwfHt4izWNQEoTiSh0d9r1F2BgWj73oLncAa9kEwCC8zd?=
 =?us-ascii?Q?DlznUxAaBd9RP/0LfEFkkSuFdobIVSvR3X9yzS91tinTr38LFxNsJj/Fua2r?=
 =?us-ascii?Q?YMStlMwqyG2eyLASTCcqdE18ld0YneV4DMsrNK7EwRe65ZTyrkbW+oLzQrj1?=
 =?us-ascii?Q?JJ3JzJQBSfs1q0c2VlCE+4w1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jdyCMO0IJ5udt4YIVGL95IcMWjcJg2O1WgBJbMfVgmPPlovTda+3K71+xJO/?=
 =?us-ascii?Q?Ndtinl0ThHCfKQot+W/12J8IF+bnmFLx4iwxK3+6LlKCamfpguWE2YYxmq9U?=
 =?us-ascii?Q?SAJZpXd0xqRKW013fDdcXONqNefz3wjS4FIS6CT2CTKwWn/Bo7ZSBmH8/X/u?=
 =?us-ascii?Q?EPMMSEFELNsX0YfGuCS2xE8HC44jKQ3HXQy5zQpl02wPh44JiJohogutoAp1?=
 =?us-ascii?Q?3sWA1nkLlFpgDXDRvWH7SAValK8R1Vx7tEwRWLwQRqDPuAFrFW4Q5NUnPYvr?=
 =?us-ascii?Q?bHd7PKo+66gycRQLdOQvrJiuY5SdThww47jSKKvA06euXq96BGS6eRFjnbMf?=
 =?us-ascii?Q?x6bQwnYr/hcTXSHfQWljXJ3aS2ypzokXmBOWbyPuEKWvr7vppI5Op6kQ+dCM?=
 =?us-ascii?Q?tPascATcvNEr8E3Ygcpcrkl1fBFRXJYflVi9blpieulOvxFekgqPyi0F786l?=
 =?us-ascii?Q?GoAqm2Ubyc+Wd/SWnPtWJnQ2PxIcR8otO6I8DluiX4lKf1CqvP05wJWup+Sv?=
 =?us-ascii?Q?DnWzZNfki5IhZDgTLOXPTdZ/jXrSjn3PCEqe3zzAAV/twIbvsAuxaLZwyo3I?=
 =?us-ascii?Q?RZUUGcK4FvLeeTWStt6DqED9+C3VeVsa+NnzoKVW+BqArBdWXtqCjanDA9K9?=
 =?us-ascii?Q?YCM8j4EOZ1gqUX+xW2uuI7biojelhgxznPyM6DSl3g7rgQFONgMNoo0HtCWh?=
 =?us-ascii?Q?cu2to9KWHYAjq+tBcNUa8SLyfMuIMJtgsk4H6lWO47zm/BJkfPOYjXiMMvUc?=
 =?us-ascii?Q?kULq4/mQbKbBuy/NhV2ygw/CClNkYNMnM61nKqb0yOULfNU9XuJl+MDqveiQ?=
 =?us-ascii?Q?CnbLD08NWXckbDg+dkLZe2yY0D8OdVtWJqvXhGIiAcFBGMtGUMIxMzvOHbXU?=
 =?us-ascii?Q?gwBo7b9iCvtIXUWt9Vwuvry+KBnSJmZgiI4BsXlOIOA6tnCq0ItWzx6jlXeY?=
 =?us-ascii?Q?SJSxOWL0QRAq/NKq4EHLQyyKB+FYU8pCAfm+AfQycbryPnNqWg3BzdQkN5ep?=
 =?us-ascii?Q?g1f+WCxdOMM7oRZFtppZ+Xv2igk49RnWecb98SSm99/zGgVok6WdvbFRrJ+d?=
 =?us-ascii?Q?+1DBMYozqWd7GV/RYraZIFRYzYTesNekJCynDl3FGKuTygRbc08x8hK5pSxv?=
 =?us-ascii?Q?0jc0AiRKCWcclJ/zn/fe2CL4RDJPxqwSVZ/+3AJsCIEV/xtU27lDmBwUow7j?=
 =?us-ascii?Q?iiNb6zmfqrMvXo9D5kPU03eZfIaOfzseXHqkB1AW2O1R3MPGSPyiz6fnkYN/?=
 =?us-ascii?Q?93Ga+ujAncGq7sg8fzC2fzMWNKslKFxdMEhvquEHyf7pZk1PAtnlRXg3be7w?=
 =?us-ascii?Q?dBz/3cx+NmqZWl+O7DDRVuf4c0AXM8VU7oFjzDBF5teipoe7xKizXZjtJIS0?=
 =?us-ascii?Q?QN/xooSNRj8GpDPO+9IYhR2yGayozx9cIgufN/DJF4kN7Bgok23x7vvGT2R3?=
 =?us-ascii?Q?Dc+bO32NiEJYqu74SJBFbPhfwITaNRpqKoWVrI8Cp9nfwzjq2rXZfF/DUpdZ?=
 =?us-ascii?Q?MK7ann5g52Y1giiEuNjJ2Bp83zJjgAdqiPBXrgN3EnuMlvB+TKLgebwcep4+?=
 =?us-ascii?Q?CEH/kwcp42LtaBvKhoPay9NL3y/XTHCcTa2QsDDdUpZcWC2FmU2hXvpiDCnH?=
 =?us-ascii?Q?aQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zQ/bDy6dDQUkdXmkA+wqmuE5T/956kar6Wo8wPCrxx/F66KGYrruFj7slIyeitemgg5nkrHlPX05mr4uy1GRbMUNWjLxTvNR/U58K6hOPSSeEcxmSc9Ho6XxpdQ9GUBgr8FsN3SA/o26Jiidg4uTii3hZc3M+b8RPEMGDLYH+u3w5J5iEuUk8QV5srFGyS6UbtqXqusGM7EdpXXOLEn1PWd3PxQ5pirvN6B2hg6w90dT8YlKt8nJc0Wd24toQgpTG7jwJi/aqoSvW5ujHKfDB7WXpS9u5q/6+47qxNDHxBSs8+w3a96hzbLC00+3+WfCMkvjyTnkPmJTjcagy+9DwkEQwAauMiQ5w7UPZPAtYzPyEMglU3zJM8o6Yq8ge7vjANtIqwTM8SiFPc71ysjW9YhN7IQlQfKSMuxHuE4QywzEcEChIIhyFZL0j3tpnDIKS7/kIt6AbZuL1k88Yatdg+8EbsjuAWH/saKuSuZ3AFzEL+ArtLhidYp6JORF2nQ1tvGNvsbXxD4cxVMdaZ6OCxhODO+viQjrX1TwoN0Ho45h0SvoFPOplN3FBQg4yWt3SLdcdHSPwCiH0XOnU91RRDnbkX3wL3pQ6Ov+IsIv18A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48d318b4-eaac-453c-d368-08dcf7977123
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 21:28:19.1020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1y9omqYpUbBSBySqiZgkhtOhO5BQQDMBnNxfknkqm+XetAW6cQakk2HYyRn3FNNBrNdny04TFBWR4x+XOvq/z3TIzfYHDyhbYTK+P2U5Krg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6597
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-28_10,2024-10-28_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410280167
X-Proofpoint-GUID: N-3Z7Iydx8ROMUqQgT0pWNLW0K0UVHrl
X-Proofpoint-ORIG-GUID: N-3Z7Iydx8ROMUqQgT0pWNLW0K0UVHrl

On Mon, Oct 28, 2024 at 09:05:33PM +0000, Mark Brown wrote:
> On Mon, Oct 28, 2024 at 08:43:08PM +0000, Lorenzo Stoakes wrote:
>
> > +/*
> > + * We check VMA flag validity early in the mmap() process, however this can
> > + * cause issues for arm64 when using MTE, which requires that it be used with
> > + * shmem and in this instance and only then is VM_MTE_ALLOWED set permitting
> > + * this operation.
> > + *
> > + * To avoid having to tear down a partially complete mapping we do this ahead of
> > + * time.
> > + */
> > +static vm_flags_t arch_adjust_flags(struct file *file, vm_flags_t vm_flags)
> > +{
> > +	if (!IS_ENABLED(CONFIG_ARM64))
> > +		return vm_flags;
> > +
> > +	if (shmem_file(file))
> > +		return vm_flags | VM_MTE_ALLOWED;
> > +}
>
> This doesn't build:
>
> mm/mmap.c:1595:1: error: non-void function does not return a value in all control paths [-Werror,-Wreturn-type]
>  1595 | }
>       | ^

Doh that'll teach me for rushing this...

>
> with that corrected:
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index d1ab4301c671..cea051c5fef3 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1587,11 +1587,10 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
>   */
>  static vm_flags_t arch_adjust_flags(struct file *file, vm_flags_t vm_flags)
>  {
> -	if (!IS_ENABLED(CONFIG_ARM64))
> -		return vm_flags;
> +	if (IS_ENABLED(CONFIG_ARM64) && shmem_file(file))
> +		vm_flags |= VM_MTE_ALLOWED;
>
> -	if (shmem_file(file))
> -		return vm_flags | VM_MTE_ALLOWED;
> +	return vm_flags;
>  }
>
>  unsigned long mmap_region(struct file *file, unsigned long addr,
>
> the relevant tests all pass for me.
>
> Tested-by: Mark Brown <broonie@kernel.org>

Thanks!

>
> I'd have expected arch_adjust_flags() to be something overridden by the
> arch headers (probably like arch_calc_vm_prot_bits() and friends), but
> if this is juat a short lived fix it's probably not worth the trouble.

Yeah this is just a sample solution that I had put together when Linus
suggested a sensible alternative which I'll code up...

Good to confirm this is definitely the issue thanks for testing!

