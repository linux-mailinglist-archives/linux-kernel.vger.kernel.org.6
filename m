Return-Path: <linux-kernel+bounces-391179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F2B9B8382
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 20:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC82EB2222F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 19:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9561CB512;
	Thu, 31 Oct 2024 19:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nh3F3BpY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wwXUoE3g"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A034A8C0B
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 19:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730403414; cv=fail; b=iQErqb6ltk8kbNSw899PS/M4vUkUDU7c9oj0KSwFzD4p/tHlqY0Rg5eAJonddOqCL4FXkQuP5bd6r+q5++sZOusyaKpnz4wgBhe/v5LoXLDE1cfgkPbYrrq3pJRONwRQesB6GmyltQsqSSU3GsSRqmsqRCU5WqZlbdWDv3/F8Hs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730403414; c=relaxed/simple;
	bh=zqBPkn0BPu4MkJRetNYB3BRBAUCwI7kx1Ih93+rNYc4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=g7csqRjwYHz+6CmJYR8Q8cIihv282+HkFc/y11o7pTbwwWO3oT0icEH6ecH+A1H+4puNMs6bNi1s+GnVv3l9+A2UuR7xtSD+NLHtsDaFkXRbpTMRGAUMiKdvYBBx3MOrMKTpRqGcbufCmK3dOq/dSJuhjH+JAniUbZQpRufmGM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nh3F3BpY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wwXUoE3g; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49VJBYeT016279;
	Thu, 31 Oct 2024 19:36:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=nNqC0MbqfEx+oQLV
	E6fCxxrXvKyhvBNCi/r1d36lGuk=; b=nh3F3BpYE86iuau6ppZ861bd/gMlCoD7
	VggtvWUMXHw4sb2vvOETw8ZhIP27pBXh5CnDMs6Q2NTyWfdziScj33Ubbu/gIebI
	f7002V/U039elHm1X7v4MsvjDg09e6Rw6GbonIU6O5IPPFdjgS0v8k1gAvP/ObxW
	FxVNYmBkJXfzbLHfA414NoD0/NsZTj14DcVEJvIzGvNn2VdHa/G0ABJrAI6RYUE7
	GJWx+JJsAMuogveumhD/osGUkYKso9iDJQixJSg7hlc55O0Sm3lgy4DA1uVA1Cp7
	rZJhOoEqc3sJzyWFNxheEgnH3eo8GPyB5ZmiSsAnrydyya8PDSRVKg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdxu355-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Oct 2024 19:36:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49VHp2Hp004745;
	Thu, 31 Oct 2024 19:36:40 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2049.outbound.protection.outlook.com [104.47.56.49])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42jb2xbrve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Oct 2024 19:36:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WMSKju8MibgiL9YPEA93DwbNHkfglRjHC2ra8TEgjjTQxI+1glbiI+ISLZ5VVnCeZrVQLD/zFbt9zV7yqW7ylITM3yB/R9dEqCj6LzJmmsccuxT+abOheaPjE0fysR0dcdOmAeDObRnfxu2XamFZWL9PqjwVhLcfkjpAfpnhiztHwuPodhHo9tUAN3t+Qes03UcV4uq64j+2bn5XNuacjuCLuxilYCiAEyUjzBtWd2pw37JE6WzH8QX0xoJeoDCjW54n47vtpJ1Hv5NQ0fErexLCmQpiNt38YrYUw/3+5m23wjOhgsL4VmWyVeFX9sSo9I9jsgH9vqDgv3qjo3kMFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNqC0MbqfEx+oQLVE6fCxxrXvKyhvBNCi/r1d36lGuk=;
 b=c9d1i6lTI/HAzwqybY4M3DqUCn08DfyD2CVd8t6qzFNNmcrN9zeClIyHMoD9EL3BK+i5ythHKDouYSISoFy4wuklqB9z6uvBtLLRVktekyBGU7Gexi4Tig6Bd6aOgkNQVCJGUVwF71l3qGpwjkoSrFMQPy41hZ88MMD8is545tgwup3AS5LOLtUi9+sbsv8um8F2s52T7OfQGNYmGWdG0dsbEKCLXELo0CmF55G2AjXNLXFRPTvUzYnBiNDsQo0jw3EF98GNYPc7pOOzKeg0VF7w5OOggs2LiHu0OuwnUSa2rMgeTbzRntosBK4vMxyevQVWUvhmA9xD1z/aUsUgCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNqC0MbqfEx+oQLVE6fCxxrXvKyhvBNCi/r1d36lGuk=;
 b=wwXUoE3g8cKn1bw8t1qt60yAu9gsxtw+ePJfwEHkNu2RH6GQfCiZrb8H6LrqCj9GAt1np5q2fufpQ7C+Zcro9Yc5F2ebagpW626XUrcKTQElrjKkz6nWsrlXgL5JGatASPqsApZHlV+tkhrvAG4ueefm6a0ivK/9erGI+StAG3k=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by MN2PR10MB4271.namprd10.prod.outlook.com (2603:10b6:208:199::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.24; Thu, 31 Oct
 2024 19:36:37 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8093.027; Thu, 31 Oct 2024
 19:36:37 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>
Subject: [PATCH v2] vma: Detect infinite loop in vma tree
Date: Thu, 31 Oct 2024 15:36:08 -0400
Message-ID: <20241031193608.1965366-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0044.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::19) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|MN2PR10MB4271:EE_
X-MS-Office365-Filtering-Correlation-Id: d20dd6e8-1890-4c2f-8951-08dcf9e355fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/KMqxWjQxa00UnFi0NBUuy4y0esIQAqd8ueyMq9CRQUewVpSwTqnwDx2ZVFw?=
 =?us-ascii?Q?8QgApB+KpVcPAzdccG+GKO/dYFAUpqKG6WhQ46Akh50Muzb2q5awMpxLSwWI?=
 =?us-ascii?Q?6u/+OEJm464WzDddV5rlatKg5GR0vs7WxI8CfI9vhXI9g3tX848OkgUW+A7N?=
 =?us-ascii?Q?Aeyv0h5b24dVKcIcJsuzE0vcWGeDcPkVnSmW791o3pezwY8wowCZ1Y/ss6yZ?=
 =?us-ascii?Q?oRTLOxsMs0FYNqHwdlk0B/RLhI3gbWMD8tQVCundHbgoq6arMwM3T2nOCNv+?=
 =?us-ascii?Q?164qr92oc8PW2pa8vQLqBFmq5wSfBABdX+SzuIf4ahGE7dibMuDB8pugGGIJ?=
 =?us-ascii?Q?WugogqnqnHGK6f6wvI/qSojrUgjH4joEIujQbklsxTqteyAYsyScMsLXPC5j?=
 =?us-ascii?Q?t7+0TC+1rJ456qN36uOkONb8DNdPtCo7S8zZC26eQhmrzAUtj1gyHe2taf3k?=
 =?us-ascii?Q?V+1nZvnvC/MXJh2N4zIRe3iILEyt8xQ+uZwpexeiy23xFpxUL51/5T0wawUD?=
 =?us-ascii?Q?93dRIGhHuMNZ1P6cTV3ZjXp7r4eGqRAaUBt4VSEZWsKAyxYX+JYs8d8ULf1O?=
 =?us-ascii?Q?PXHGjdScF2DUezOZBdY50EudSXtGdflJhr1bhOo78GxGsxsSJN6fWzY4fQAN?=
 =?us-ascii?Q?hscQ4++vxUfpVyHQWv/q7YgX7dIYZyMztHIbOUjtWOpQ0ZP5gQF+UesU1dWS?=
 =?us-ascii?Q?XaKBXUq+cljSelD0lyl1Q+pTHvkE6P/jvDwKiO1Wy+VR6UluGKFLvNJmKYlm?=
 =?us-ascii?Q?OexIotWeAwoV/C0JTRKT6bDHEFjkGOuOoARhZRiKtAwy8qsy/Nw6VNAEC5i5?=
 =?us-ascii?Q?2HouAgxEwKwN8qqhbk85RVvXg9sZ4yg7L5rrX1hkzfLrfo6Sk+5/0I3cFWfI?=
 =?us-ascii?Q?89zrcxygerhA0fldaOIxs1yWT+CGCoSM2LqcUy1a7rT1QIdIJHKRxfSPV9au?=
 =?us-ascii?Q?HFgxn88asJhK2j50zQPyWLSpG4rCBoM3EFaCh/P7MoQ2ssu0/vbIZaG4PENg?=
 =?us-ascii?Q?CkJVAzrs1JivLZDkoe2Hv9IVWiTLCoPbj19U4f0UonTyeSLMuHFeD2UpAu+X?=
 =?us-ascii?Q?44ataIfzjHoQCGKTGa/mmHknAbuzvvvmkmWeDacOcYvzkB/DHHH/9JDReBIV?=
 =?us-ascii?Q?duHZUIJ8+athzPShMc4IkaNzrtx+bdDpxOalOz3CdPD9DQ+svzJnhBEibr14?=
 =?us-ascii?Q?qr5kRcLuDik9tMPYDqeYiJCAL9rHuG/L16i1g45Zqt4fY4EryFDmXLiAQaTu?=
 =?us-ascii?Q?R19tnN4lRa0V+bVBr8cn+4IGJ9BgMyyXoddkwPrM4qffMx9UlU6DM2pja13M?=
 =?us-ascii?Q?MnYhtrQ9yBNFuvXl159Y7t3L?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?21HSL+BK/pj88Kf/yJdTZim0i7FttI/gBxQlRbNDj23cS6qYR9mCHCt0/hmf?=
 =?us-ascii?Q?CSBeIWmbkdbWj0wfW6Ryp4ZGQi1vFLLgKlm7CnfalQDW0LZVytK8CjP0rlzj?=
 =?us-ascii?Q?rkHP4OPMXhGULWWde4ZXZVDZ1VonLTbl4Ri8ZDWLQ8PaR8E2J3C/01QfKt/u?=
 =?us-ascii?Q?u6swWsC3HmxOFIh4eEHK60BjV7QF+FfrK/dF7T264bDaTfsnYkYro+9GIDqX?=
 =?us-ascii?Q?9ptQ5pYvIq9P7MfEMFW9nMqUXTdw9OOWz3ppK6t3IHUyR2iyLrFNLdRDYo9m?=
 =?us-ascii?Q?GNWfn/PJxSpfjrjRycxc4SyycD5UZQZ1eJWknQ+U/B6ndk/DGq9J1VjJT/yK?=
 =?us-ascii?Q?EU2xOpEuz7Ryu89gw6l7WF5YvWw4XWUHGNW3TaXnSAP3LC7aFxZ02zfPfO7Q?=
 =?us-ascii?Q?NwL7dtUXFpxhRJrohNa37BRa4MpAtW3OnhitYK+qTJ4hwpMeKaPJKPMBoK7Y?=
 =?us-ascii?Q?0qsAuamfmVBT0YVhbNRHSBxUSRAD41g89T9oz9IG3G4c4JAZ/b8DKzxE5lYY?=
 =?us-ascii?Q?6vsuub/D+6FD9O0dn35MYaWDCTM7Z8/83cWIO9FMHkRFyxgD5hzzy+GK1oQt?=
 =?us-ascii?Q?7E1sQL7ihGOQSWyvTbXwKHj1fNbff+yIwc9j6rfnYATjivZiGR8yUP402LVe?=
 =?us-ascii?Q?A7/tJdJUnb2qAhPze7rsnhbN8UgIzDeFLQcQj8wEd7EthTj/mLQI4ICsiFss?=
 =?us-ascii?Q?NaM8smQNycSUrvnpJsEQXckPoid/bg44MzlEJadTDTbNJR9QlFiYayVd6ATs?=
 =?us-ascii?Q?ELSSfi8TIornC6bRlvwLY35VoBu5N4I25mpPT/br0fIEMxrfcG7T4xNSeQ8n?=
 =?us-ascii?Q?pv3y2ckx2W+36Viw9rsJPYP856wZIhcYGW1k4n5E4QbQJJBE0bP9ftq+5d+H?=
 =?us-ascii?Q?IiQgx0Rd0zXMyvbKgcOfdWaUVnkWa7ALaWEFr7gKPDpLxJZQ+oppHTGY6OyH?=
 =?us-ascii?Q?98EnyL8NdqC18etCLoQsbQWTglWoG3WfiiiURmDJWLLu0y1NPNRRWVb1+xOy?=
 =?us-ascii?Q?agAfQc20/XxIv2wIjI1WZr8J2kyeqxPPqqRd2dOLTI0aka8+AabFWnsApcMG?=
 =?us-ascii?Q?imjOVrW7a584GhYhurEQTMGJhujk2Uj3igsiv90c9LD8J3Nuj7b/vTJL5AKM?=
 =?us-ascii?Q?DkaHrnvJvtsmDWKLE6URpzk4FbJHTAdBBF06Usw/uC2T2aMb/Sm+Nt4PxiT/?=
 =?us-ascii?Q?G2w5PZl0t/NI4D77eCDMvZYYT3zCf2QyY3vVgLARi598k+5fQ1fGzNGToj81?=
 =?us-ascii?Q?v4qVhx7eq7PxDlO0lDeBAR3lmlJBeMfOf4bhVnq6bQaMUx6gggT3khh/TfUv?=
 =?us-ascii?Q?slW+GHef9g3kwFY2Y33vJNOQ7+JEV4Gbz2SvqZ6UO+x0nQ+WYImzcl6G3Lyp?=
 =?us-ascii?Q?OTK7oKyqjNGos1Ak9ckjDEZNofFzKahFCOa2T79KWRvxNtTF8e14Fe2fullx?=
 =?us-ascii?Q?Hzbf2K31MTCBFevakRkzs/UlWVv9jRVwSjinW3p8dMCPgZQT9+BRvf0Yf4qc?=
 =?us-ascii?Q?KcmhJpOtU7zXGGmdP1X9AyKB9aB3Vz3SxBe14ceriHOsmPEI2rkxYcqO2r3w?=
 =?us-ascii?Q?s2U+PuZXYemdF8Z7v9hT8273XAtNAHUIFzD7RtXS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jN9ZLCR909Kk8ujYORdbMpgkjCzPMJI4qD7ke0idzUYSoiXRcWDwlEYwkroVLdgn4n0jlXamXr4Kb97k+WHEguFRh4CHhuO4oblTIROv61ClomnkHVOGdU/rxRITaXc66ERKaG5Gp4/dWiEAw2Y2XcNaDB86x/D0veKcxB8GckQmogTf4og7BIf+aBzoUMsodGRDaYua/2ILQuWW2TEYbKXN7weemjIqAXf53HQqTs58e86V2M8QYiKbbcQgVt8z9MIUVJRbMcqinfBqI0hULgVv1fMjGooTIzv7XVXjH0HSX3rhHJ/3yhNo0Mudq0wrNBtDW0efYT0ukW009ei0IJn8N4OO2e+64fMdtVXFXF6TW0G8h2ZfJ9WV1gjCszV8pt0GiB0ITw23Tj5CX91jDEnoO8pTK6ZNXPt2XVlYZak8EcqK2HseKSS6tWI/wENSNcKKON625AD/LwjwXQqMk7M8QBGh9zCl53FIBv8ZIWq/IqMXByZVJCKTHy3fkTHIyulB+uOPYhZBEvuw35iMEC95q3dhBbO3wSCm5cGtWHjNI/g9pJxox1U073ApUHK8klmQ5+hoWz/YqTpYpzQ/TzS7YGqI0JqGWViy1pHDq8s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d20dd6e8-1890-4c2f-8951-08dcf9e355fc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 19:36:37.7316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5kvakmwe69gboKksGQAQWmW90T6J+wR/TTngL3xgo2v3+P2wXlUqs1b2jFgs/l+pnUBLJ0ryjpbKItMK7qlFCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4271
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-31_10,2024-10-31_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=818 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410310148
X-Proofpoint-GUID: Ek16I4ON8IcULoYFWbXZkGn8mzefRBkV
X-Proofpoint-ORIG-GUID: Ek16I4ON8IcULoYFWbXZkGn8mzefRBkV

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

There have been no reported infinite loops in the tree, but checking the
detection of an infinite loop during validation is simple enough.  Add
the detection to the validate_mm() function so that error reports are
clear and don't just report stalls.

This does not protect against internal maple tree issues, but it does
detect too many vmas being returned from the tree.

The variance of +10 is to allow for the debugging output to be more useful for
nearly correct counts.  In the event of more than 10 over the map_count, the
count will be set to -1 for easier identification of a potential infinite loop.

Note that the mmap lock is held to ensure a consistent tree state during the
validation process.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Jann Horn <jannh@google.com>
---
 mm/vma.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/vma.c b/mm/vma.c
index 68138e8c153e..283e6bc4884f 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -615,7 +615,10 @@ void validate_mm(struct mm_struct *mm)
 			anon_vma_unlock_read(anon_vma);
 		}
 #endif
-		i++;
+		if (++i > mm->map_count + 10) {
+			i = -1;
+			break;
+		}
 	}
 	if (i != mm->map_count) {
 		pr_emerg("map_count %d vma iterator %d\n", mm->map_count, i);
-- 
2.43.0


