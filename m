Return-Path: <linux-kernel+bounces-378557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 361799AD240
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 19:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A7851C20EA7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01FB1CCB24;
	Wed, 23 Oct 2024 17:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jnbmyDH2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sRghvan/"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CDD13C670
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 17:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729703561; cv=fail; b=gjmmmsJDrW1/e7IouOFNCnIusklJUZzbGC+xGdceUgmCWL1NacNM+FYxFCpEs2wAGulDwTC2HuZKKoY39Xq3ZTPkYUXP+2OuWCYPGLHmEHtCm4wM+y5i+nQJJhKp7da8l/mzz6FP0EwzO83ePjiWKcZS+n75FtTJzTiBM5MpaHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729703561; c=relaxed/simple;
	bh=y0nbIlajoD6OTRdu3oqjpm3kGvotaAE6zxFhE7Mi2Oo=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Tw8KrldpiF7Mev3xMsfmVNrSkVaoGFEI4MC85jlNI26Z8/CdSYB4OWZeVdlIew5QLBu9UNQt5NQhB0hm3UxKiM4RfZbaxfcdi0jGS1/5HQjc9Ro6xzhRo7XJYvgXInCf9v7Vr1ucFpJaQTr32TzUqe9LchdhiqxJiyYtam9r2+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jnbmyDH2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sRghvan/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NFfdET012069;
	Wed, 23 Oct 2024 17:12:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=tsnENFu7FKuQ/i1v3m
	aYyVp2NNpUQ0u4bCe5V6iOYtY=; b=jnbmyDH2qiuZBq7EBMUGLXCxEsSQPv2kgs
	TT3EpMvo5z93yhSjnfkWcTlCa+QC09z+3CEneJHkhUjNxWV/KhuwPo10lX8tocxw
	JD2w52ldBGHPdPDwmMoq5afwJAxT2WJiiCpdhkwe3tS3xiSJjvYKrESG2TVdiFEU
	/ytLs7z9vyEyHqxfb9Q+41WzQDq60hqKXLPgNh6zaPvi4pmbrRI16O1W39wMFLQ4
	DmVPGOuNwJVJ1h3jHCM3Oj/bIMUEVEvCkgYGnWnejXFv+C/ggvPeHeXUW3U3T+l8
	GUg6eaC9PrV2GjMAlNzMJV5KuL3uOXhxGW2DWx9FWMwjSjMJ2nqQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c53urn4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 17:12:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49NFuqxT027434;
	Wed, 23 Oct 2024 17:12:25 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emh343af-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 17:12:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y3jC0w5gWhQ1oHRPcJ4tJPQhUJ6vk0POfhrQpH7mRBLAOya4wohBrzdqzyuDYsPmmJ71POd99OXKUNeOiNHCRjZaLqqNOLUeaywcIpNQ0r9tmsPkFTgY1nOVox7ddzo4/pM2fvnOhG0sK7LYRzxVVPC5Yd5zzblsPREzGPUGVoEoyWZIKHe9S1ieGI0rQvQS/W1UHdIt/QHcfzBmuYZmIykBdU/CJIHdHY8e+IM+6nrOvhqnlhsGouNOwK05eYBDe/tUo0i3myfQB2G7ZeR/b5d9iIfF17XCXkqu1ieZYNc2OV8MqfAblEQcco54eeEr0MuBMbmKTPYbeg8NZTaQuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tsnENFu7FKuQ/i1v3maYyVp2NNpUQ0u4bCe5V6iOYtY=;
 b=Y01KAtUSxePIytxhn3jIA4Lexz1Pv8VlQ5dLhNouXSDlodS/XPf7d5uvpHfEE4y3ea5GEeEeeU3rdtYpWnASHtO05PVDDxSqwX/347LHOT1fdUX627ZAutsLv3nhff4KsaiHsZoM7zDmUr4B9OCSDdV7VScog1cI0lek64YjF1o47J8I9FM0fIXF6+vzcgI8gjupUqlpU81yhwoRnw6M2i7WOBdWcvhSl1qf6RYvXlGzuYIXD7MCD2jXsmfe8NDik5dYrk+9I3yoOF/gfQy0T/lDXixKRdHb6Pl+9Pdz9oy+no5zYzH5Uv/FOsSaPk64Hu56wpyBX6vQdk3R1x+t5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tsnENFu7FKuQ/i1v3maYyVp2NNpUQ0u4bCe5V6iOYtY=;
 b=sRghvan/qer7zuxO3pJJfH0Iu4LQNqkH4UaIsW1AdPECHqhjZpMXb7TNr35cbL2qEeSKcsPRR/VOuDGg9BZIUZFY0vBumHOvrPRIEq+E0cBGhKWunVTAgteLsWIkb134GQtAkV9NDiPefvIITTe+NDmE3AuOdGGJ9RqDgsyxMDU=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by IA0PR10MB7327.namprd10.prod.outlook.com (2603:10b6:208:40e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 17:12:02 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Wed, 23 Oct 2024
 17:11:56 +0000
Date: Wed, 23 Oct 2024 18:11:51 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH hotfix 6.12 4/8] mm: resolve faulty mmap_region() error
 path behaviour
Message-ID: <2dd61449-a927-48c5-878d-cc0434dbafdc@lucifer.local>
References: <cover.1729628198.git.lorenzo.stoakes@oracle.com>
 <3bc3ef7520eed73472f7ffdce044f2e94f809b32.1729628198.git.lorenzo.stoakes@oracle.com>
 <e2bca69d-5266-462c-b770-707ce987473e@suse.cz>
 <73wl5i2vmh7fckairzw5j5so2fjg6p3vvxhixnpqh3zc64o7ys@yidsexyjkrs6>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73wl5i2vmh7fckairzw5j5so2fjg6p3vvxhixnpqh3zc64o7ys@yidsexyjkrs6>
X-ClientProxiedBy: LO4P123CA0676.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::14) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|IA0PR10MB7327:EE_
X-MS-Office365-Filtering-Correlation-Id: cdac9a5c-d3df-4813-b19c-08dcf385cc5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pw4Wzr/MqF8cV7TT4cJD3z9nQNcWXE/TzB1nMcE++aHxp9VawkrHp9FCXG7o?=
 =?us-ascii?Q?aFwgxkGLRKVaxLWCR1w+8K1gqDxQ6xOubkWVS3LKok+BQ3ifnb2ThPeyVT7W?=
 =?us-ascii?Q?W1+fQw4072u6hGdui6p+K9/7jD891jSEYUhWdwhw0KUT5MrIKbozBlGXZdQW?=
 =?us-ascii?Q?8qCwCcwEDzXNJIFu/1DpLd13jPt/59bK8gG6+YcgDgKYf09z5KVWsMI9ed+4?=
 =?us-ascii?Q?xZQPOZgDVzjKBeqG64rTXZLkv3IaIRUImyFNdsrRbzRaJjIVDfEqumHZ7xpa?=
 =?us-ascii?Q?4RVSAm85YARnTVe7TyIDUqn3lRWORSMc0QplfRCkZhemYKhlXnDTmGnt6Yw0?=
 =?us-ascii?Q?oe3NGZxY3v0qjjYX2e/r0Cr5Cz4rdxoAYJZwHjDGMs8tZ4f9Nr8hFm9qzpFX?=
 =?us-ascii?Q?pZF7QxLWocx4NJJSHVU89kkxfbduoWQy+lUZWqKMRnspnotQqEpY15rhmZEv?=
 =?us-ascii?Q?PiG/j38cQCr7pXz/JM1QLPZ7nXLeyfFh1B49u1R5mh+HW9HVIUmucEmsFCRr?=
 =?us-ascii?Q?TQp6nIhtY0bqAgwW0qj4+6wq/yUtKXsUR5av5DEROUWMbVNyb/RchEYX8cjr?=
 =?us-ascii?Q?aiBT6/bgF7/+0w10dK1Y1FntQKLtXGBb/BHraJFoR1JcZP0A0egoTpuOnlI6?=
 =?us-ascii?Q?KkuKDu07BAJ+QLPGKS9NQbURpwCQC2zrXsfOEpgf51JLWmBDavs3zVXmDIsL?=
 =?us-ascii?Q?6EHMigJyRfHQ/ffFdiG8N7uccU/AqkhVoJnpKQfYL8DbjXPXMtVcbC5tlTXY?=
 =?us-ascii?Q?U+6OSaHW0UwbZ6KkGjlWLxtVYPMta0vJ5m+wA+81bWrS5JNOao9iFXT+386Q?=
 =?us-ascii?Q?mwyL1/IKVbUPzLcygRUqWoaOT3iIvLk9+TxQBWOqsBtIOos9QuqNbjnK3O3a?=
 =?us-ascii?Q?XBSTQLz7jbar+Em+Q6f7ubFdWbWdPMyoQrM0qICoe4Il64Yk4iXAlYUQKYas?=
 =?us-ascii?Q?Gs+HI2JX9a29zaMDjjc6YBJ2IbsRx2RrkweNcUcQ8EFA1PfLYMqKp+Ohggep?=
 =?us-ascii?Q?el//o5Zsi6nSthDtqJnSitFOnL198yoPSkxZtZuYwGJl5WI5cW3rUxvIM3qt?=
 =?us-ascii?Q?S63ZiZXeMsHtavYygw6v379+AhaU2xyIeD9G+vGQKab4rlZoh4wXoJ/vbtDL?=
 =?us-ascii?Q?Gf7z1FVAqTqXxzMFGz74L0Tpf69159Bhari2boMMz9kOfz/Jy3RjnyoV6JpX?=
 =?us-ascii?Q?KptsZoeXsI9zgpHZzjggwpgxC8GGV5JFRNRnvXy7t++4QRK6m2uH5EMNNeyk?=
 =?us-ascii?Q?m7+3/kMdP+SE1e4c+WrLZnItS/+7qRW/gNjzVQiU78vtWKJAB6FP4cvUj2uk?=
 =?us-ascii?Q?UexPdfHmquHPZiuyTJYmpBvy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PtV/W40NnXkzkUrjbWktylOwwFeh26VoUgqZrrk6pUw+Q0/F4pMdZXuZx2Xp?=
 =?us-ascii?Q?Y4z44Wz5Hq65kekjWy9WEpkLvvVrKT0RWHu3FTH2TOo36l0CP4AzoQATVc5x?=
 =?us-ascii?Q?E1XfRgzjhjPS1288iy8fvXPQUwehDzbPu3CoPllMf+yxA0BSgXFD0dxycqZA?=
 =?us-ascii?Q?tz1gAjcPnBVKIVOsHN06s/2fnOIlynrFJejLJ7w0RMmhOhGm1SxmjeImrFFX?=
 =?us-ascii?Q?QykK0qTij8URMGvLW4JjW/RdLNnNM8gg+jC9u18lIThzoP1/n+uVg4RpBZJc?=
 =?us-ascii?Q?tYYtauYV17sieM0X5THCK7UQkyFCJqWTRm7beLq4MQmxTJthHudxzrIvX3S1?=
 =?us-ascii?Q?d6OjThihkW0wjGS60pvJP535SKWk0pxFn5dci5TQIZQmNyvRWUIwX7CHg9GQ?=
 =?us-ascii?Q?+wmoHDhi7ByOZulOh3q9CrN3P5W+6kLnVPwbHw7AZIc60aphD2eItUyqJlgR?=
 =?us-ascii?Q?FlQtOMjW/KgcnQLgoS6OaXFozRQfZullz+kxKaChrAg8KYq7uQ9tulMohqkE?=
 =?us-ascii?Q?fm36JVTnlb/lOa0fU5D3QvFCi/J55u1fx5Vfmjioj2OlEks55tCuOXsGxxKv?=
 =?us-ascii?Q?dM3rdqZWelrjEAhDlF20tDk4rLzF/4FCvhxKVOX3hvR45dj5c+dr4icdh3Ri?=
 =?us-ascii?Q?XdzZ9G8n+o7O/heF9Q5OlbtTx9bIomT/5Pug7YnL81iKCWEOXLI2K1IH0O2v?=
 =?us-ascii?Q?+DGw3TsxloEfKmTZCndE3hvxvKS9xPT+26OUBQHvZt8YQFmNYXQR5tpvP6Nx?=
 =?us-ascii?Q?3OM2K4bA3z80rXUH1qbuZNwn9WV0Bt0wm392Cr9HBJ66+Y/F4jpxXvw//Kht?=
 =?us-ascii?Q?s34wv4q3f+OFvinA3/LHrSUWOBg4vn0YGgONNak6TYkhhN2Cr5h4fhCMqSSc?=
 =?us-ascii?Q?GOd1M01awj5UgM2Jz3a1zZgvQFekqtgUbt/O5wV7/4QytZOkFc16en5gAXQK?=
 =?us-ascii?Q?xv+Dl8QNSYnmedJ189z4d0rlFPEPSiBhavBQv+Av+a2jepfI4HMvZ9A//7Gt?=
 =?us-ascii?Q?g3wJS39HJgo4CXVh/Jl2uUTSS7aMtT4bzv3+srQ6M37zaV2AvjB7FMSSQXiI?=
 =?us-ascii?Q?J1zgKO/6sQGa9GB13d5V9IHJfRVj4UxsGEe9Cm4+BtJUjIL1qEmxI7/VtAk1?=
 =?us-ascii?Q?5/1495odyINaF6gpfGtTdqiShkml0oeWzc8elKcx2p5fq+JE1uyuOQq80Ad3?=
 =?us-ascii?Q?HJ+HsPpl+e+18JzW+g2XFXttSi2kpKM9ChvcI+TSL4NK03irxCLnjhEuyK+/?=
 =?us-ascii?Q?A9Z9iFIXHV6ij8+JcZWvlWW+/LfA+Q0d9n4Or4eisQ3Ax7qHDMK78x6I1STv?=
 =?us-ascii?Q?C795TsReK9HXDYviOO/oIizXHzEuyyHKQ37m6WUM2DU8Pqd3A4ETqwSTTZyl?=
 =?us-ascii?Q?fxC+xlsWL2obNDxj04cEIAyPZkYec4u+QgB0IxDQ+SMUbGauQv/cyPXrWJs/?=
 =?us-ascii?Q?6PAMxyWZR24TPLsKpy35gjScjTB7dYs4BP3dFSoMy7zmPysptZumtAphoSPr?=
 =?us-ascii?Q?NZy+Cs2Fup+fCEn3r6HmvxyITJM5DXbN7ocYRY93ttz3otWVZlbJs2x4+EXR?=
 =?us-ascii?Q?9S39fBwT0eZ0b9Tg4i5J9Lpsbz9z0F7ytu8cMFd3aRHGeVjW2+l1FBKx5NB1?=
 =?us-ascii?Q?pUNUWwFsuXuG3ODXlWs6W34U/5cjpH2NsB/G9FfZqJilZr/6EDOoOWLeeu2A?=
 =?us-ascii?Q?82bebw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	T1KXKCv0ISALnuD3GJdDqHhFP5TyiKmJTq9NdO1he5cnWFvJwSesJZW/O0hQC35NVzlgzjuYocMscdBLuxMzswvp4NIk2VmfhB8m+J0vTpJFWBaBkzlDGL0ZVcIrLg08cMEI73koA17wtmflDOWSoxnNaSKdFbdot0DGOf65/RXa++1Rhk/KjvF9eUq33MMETOiyW1CArGK/O9Rwt3ehtlQBtDnrJL0OZxOiMf9o+x1+gHVuchOgge/yDf6mWoqjjzo3zCHxAtnv3Kyc8TojZLXkWuzHE7ycs8GQkD+L9JlN1aTnL5K2UnUtffmTf95tYK66Y5bPIFwGF0XrNMf7O1xNmkfFElrYscr2k74ZgJrc1NOWBm+gNBQ1DIKyT06u65+vTdr4rC2Anf449io+xK4cxUmNVcK3R2ZMp78wCxGOHnaJ6Kx8czbqqUMpz5l+6I69pOFArqxCd0uUC0RjzDWx+lsRHukLUf7Y2NjXlXEXALkF+PXYcavC7vwLrpsXQjvMonJRm8rFfO+0ZFyvkz/rXYlm4rO6DhYLd5x+WLhXi6aOMdrZGwjk9/ia2wGZIObU+pTra2ECntriqB26pQBl+mAjq+d/qsUH0cSm+YU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdac9a5c-d3df-4813-b19c-08dcf385cc5d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 17:11:56.8415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i/efLZHiTBQ7wSwLi42Zq1lp3EqAO+FEnlqK8h9i8oMgvCBaEUB8yo3ImaBKyd/1Qsyu9BPJDJ1KhRSGg9r3OA0E9lallID1Ex4RIIAm3oA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7327
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_15,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410230108
X-Proofpoint-GUID: Zi6CM0fWjVWUHEUEb81AVQp-nAIZI_lI
X-Proofpoint-ORIG-GUID: Zi6CM0fWjVWUHEUEb81AVQp-nAIZI_lI

On Wed, Oct 23, 2024 at 10:20:50AM -0400, Liam R. Howlett wrote:
> * Vlastimil Babka <vbabka@suse.cz> [241023 08:59]:
> > On 10/22/24 22:40, Lorenzo Stoakes wrote:
> > > The mmap_region() function is somewhat terrifying, with spaghetti-like
> > > control flow and numerous means by which issues can arise and incomplete
> > > state, memory leaks and other unpleasantness can occur.
> > >
> > > A large amount of the complexity arises from trying to handle errors late
> > > in the process of mapping a VMA, which forms the basis of recently observed
> > > issues with resource leaks and observable inconsistent state.
> > >
> > > Taking advantage of previous patches in this series we move a number of
> > > checks earlier in the code, simplifying things by moving the core of the
> > > logic into a static internal function __mmap_region().
> > >
> > > Doing this allows us to perform a number of checks up front before we do
> > > any real work, and allows us to unwind the writable unmap check
> > > unconditionally as required and to perform a CONFIG_DEBUG_VM_MAPLE_TREE
> > > validation unconditionally also.
> > >
> > > We move a number of things here:
> > >
> > > 1. We preallocate memory for the iterator before we call the file-backed
> > >    memory hook, allowing us to exit early and avoid having to perform
> > >    complicated and error-prone close/free logic. We carefully free
> > >    iterator state on both success and error paths.
> > >
> > > 2. The enclosing mmap_region() function handles the mapping_map_writable()
> > >    logic early. Previously the logic had the mapping_map_writable() at the
> > >    point of mapping a newly allocated file-backed VMA, and a matching
> > >    mapping_unmap_writable() on success and error paths.
> > >
> > >    We now do this unconditionally if this is a file-backed, shared writable
> > >    mapping. If a driver changes the flags to eliminate VM_MAYWRITE, however
> > >    doing so does not invalidate the seal check we just performed, and we in
> > >    any case always decrement the counter in the wrapper.
> > >
> > >    We perform a debug assert to ensure a driver does not attempt to do the
> > >    opposite.
> > >
> > > 3. We also move arch_validate_flags() up into the mmap_region()
> > >    function. This is only relevant on arm64 and sparc64, and the check is
> > >    only meaningful for SPARC with ADI enabled. We explicitly add a warning
> > >    for this arch if a driver invalidates this check, though the code ought
> > >    eventually to be fixed to eliminate the need for this.
> > >
> > > With all of these measures in place, we no longer need to explicitly close
> > > the VMA on error paths, as we place all checks which might fail prior to a
> > > call to any driver mmap hook.
> > >
> > > This eliminates an entire class of errors, makes the code easier to reason
> > > about and more robust.
> > >
> > > Reported-by: Jann Horn <jannh@google.com>
> > > Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
> > > Cc: stable <stable@kernel.org>
> > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> >
> > Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!

> >
> > some nits below
> >
> > > ---
> > >  mm/mmap.c | 120 ++++++++++++++++++++++++++++++------------------------
> > >  1 file changed, 66 insertions(+), 54 deletions(-)
> > >
> > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > index 66edf0ebba94..7d02b47a1895 100644
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -1361,20 +1361,18 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
> > >  	return do_vmi_munmap(&vmi, mm, start, len, uf, false);
> > >  }
> > >
> > > -unsigned long mmap_region(struct file *file, unsigned long addr,
> > > +static unsigned long __mmap_region(struct file *file, unsigned long addr,
> > >  		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
> > >  		struct list_head *uf)
> > >  {
> > >  	struct mm_struct *mm = current->mm;
> > >  	struct vm_area_struct *vma = NULL;
> > >  	pgoff_t pglen = PHYS_PFN(len);
> > > -	struct vm_area_struct *merge;
> > >  	unsigned long charged = 0;
> > >  	struct vma_munmap_struct vms;
> > >  	struct ma_state mas_detach;
> > >  	struct maple_tree mt_detach;
> > >  	unsigned long end = addr + len;
> > > -	bool writable_file_mapping = false;
> > >  	int error;
> > >  	VMA_ITERATOR(vmi, mm, addr);
> > >  	VMG_STATE(vmg, mm, &vmi, addr, end, vm_flags, pgoff);
> > > @@ -1448,28 +1446,26 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> > >  	vm_flags_init(vma, vm_flags);
> > >  	vma->vm_page_prot = vm_get_page_prot(vm_flags);
> > >
> > > +	if (vma_iter_prealloc(&vmi, vma)) {
> > > +		error = -ENOMEM;
> > > +		goto free_vma;
> > > +	}
> > > +
> > >  	if (file) {
> > >  		vma->vm_file = get_file(file);
> > >  		error = mmap_file(file, vma);
> > >  		if (error)
> > > -			goto unmap_and_free_vma;
> > > -
> > > -		if (vma_is_shared_maywrite(vma)) {
> > > -			error = mapping_map_writable(file->f_mapping);
> > > -			if (error)
> > > -				goto close_and_free_vma;
> > > -
> > > -			writable_file_mapping = true;
> > > -		}
> > > +			goto unmap_and_free_file_vma;
> > >
> > > +		/* Drivers cannot alter the address of the VMA. */
> > > +		WARN_ON_ONCE(addr != vma->vm_start);
> > >  		/*
> > > -		 * Expansion is handled above, merging is handled below.
> > > -		 * Drivers should not alter the address of the VMA.
> > > +		 * Drivers should not permit writability when previously it was
> > > +		 * disallowed.
> > >  		 */
> > > -		if (WARN_ON((addr != vma->vm_start))) {
> > > -			error = -EINVAL;
> > > -			goto close_and_free_vma;
> > > -		}
> > > +		VM_WARN_ON_ONCE(vm_flags != vma->vm_flags &&
> > > +				!(vm_flags & VM_MAYWRITE) &&
> > > +				(vma->vm_flags & VM_MAYWRITE));
> > >
> > >  		vma_iter_config(&vmi, addr, end);
> >
> > I wonder if this one could be removed, earlier above we did the same config
> > and neither parameters changed? But it was true before this patch as well,
> > and maybe it's further refactored away later in the series, just noting.
>
> Yes, this was here in case the vma changed address, so it's probably not
> necessary.

Hmm, but this was what we already did so I'd rather leave it in for now and
we can perhaps address it later?

>
> >
> > >  		/*
> > > @@ -1477,6 +1473,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> > >  		 * vma again as we may succeed this time.
> > >  		 */
> > >  		if (unlikely(vm_flags != vma->vm_flags && vmg.prev)) {
> > > +			struct vm_area_struct *merge;
> > > +
> > >  			vmg.flags = vma->vm_flags;
> > >  			/* If this fails, state is reset ready for a reattempt. */
> > >  			merge = vma_merge_new_range(&vmg);
> > > @@ -1491,10 +1489,11 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> > >  				 */
> > >  				fput(vma->vm_file);
> > >  				vm_area_free(vma);
> > > +				vma_iter_free(&vmi);
> >
> > If we merged successfully, I think this is not necessary? But doesn't hurt?
>
> Yes, it will use the allocations (and re-allocate more if necessary)
> then free the unused allocations once this call path reaches
> commit_merge() with the same vmi, which is nice.
>
> And yes, it is safe to do regardless.

I will remove if this isn't necessary actually, I did think it would be as
I thought maybe we'd preallocate _twice_ here otherwise? But nice that it
all gets cleaned up.

>
> To be honest, this whole block is so rare that I want to delete it
> anyways.

Yeah I mean I'm inclined to agree... but that last commit is somewhat
contentious it seems :)

>
> >
> > >  				vma = merge;
> > >  				/* Update vm_flags to pick up the change. */
> > >  				vm_flags = vma->vm_flags;
> > > -				goto unmap_writable;
> > > +				goto file_expanded;
> > >  			}
> > >  			vma_iter_config(&vmi, addr, end);
> > >  		}
> > > @@ -1503,26 +1502,15 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> > >  	} else if (vm_flags & VM_SHARED) {
> > >  		error = shmem_zero_setup(vma);
> > >  		if (error)
> > > -			goto free_vma;
> > > +			goto free_iter_vma;
> > >  	} else {
> > >  		vma_set_anonymous(vma);
> > >  	}
> > >
> > > -	if (map_deny_write_exec(vma->vm_flags, vma->vm_flags)) {
> > > -		error = -EACCES;
> > > -		goto close_and_free_vma;
> > > -	}
> > > -
> > > -	/* Allow architectures to sanity-check the vm_flags */
> > > -	if (!arch_validate_flags(vma->vm_flags)) {
> > > -		error = -EINVAL;
> > > -		goto close_and_free_vma;
> > > -	}
> > > -
> > > -	if (vma_iter_prealloc(&vmi, vma)) {
> > > -		error = -ENOMEM;
> > > -		goto close_and_free_vma;
> > > -	}
> > > +#ifdef CONFIG_SPARC64
> > > +	/* TODO: Fix SPARC ADI! */
> > > +	WARN_ON_ONCE(!arch_validate_flags(vm_flags));
> > > +#endif
> > >
> > >  	/* Lock the VMA since it is modified after insertion into VMA tree */
> > >  	vma_start_write(vma);
> > > @@ -1536,10 +1524,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> > >  	 */
> > >  	khugepaged_enter_vma(vma, vma->vm_flags);
> > >
> > > -	/* Once vma denies write, undo our temporary denial count */
> > > -unmap_writable:
> > > -	if (writable_file_mapping)
> > > -		mapping_unmap_writable(file->f_mapping);
> > > +file_expanded:
> > >  	file = vma->vm_file;
> > >  	ksm_add_vma(vma);
> > >  expanded:
> > > @@ -1572,23 +1557,17 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> > >
> > >  	vma_set_page_prot(vma);
> > >
> > > -	validate_mm(mm);
> > >  	return addr;
> > >
> > > -close_and_free_vma:
> > > -	vma_close(vma);
> > > -
> > > -	if (file || vma->vm_file) {
> > > -unmap_and_free_vma:
> > > -		fput(vma->vm_file);
> > > -		vma->vm_file = NULL;
> > > +unmap_and_free_file_vma:
> > > +	fput(vma->vm_file);
> > > +	vma->vm_file = NULL;
> > >
> > > -		vma_iter_set(&vmi, vma->vm_end);
> > > -		/* Undo any partial mapping done by a device driver. */
> > > -		unmap_region(&vmi.mas, vma, vmg.prev, vmg.next);
> > > -	}
> > > -	if (writable_file_mapping)
> > > -		mapping_unmap_writable(file->f_mapping);
> > > +	vma_iter_set(&vmi, vma->vm_end);
> > > +	/* Undo any partial mapping done by a device driver. */
> > > +	unmap_region(&vmi.mas, vma, vmg.prev, vmg.next);
> > > +free_iter_vma:
> > > +	vma_iter_free(&vmi);
> > >  free_vma:
> > >  	vm_area_free(vma);
> > >  unacct_error:
> > > @@ -1598,10 +1577,43 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> > >  abort_munmap:
> > >  	vms_abort_munmap_vmas(&vms, &mas_detach);
> > >  gather_failed:
> > > -	validate_mm(mm);
> > >  	return error;
> > >  }
> > >
> > > +unsigned long mmap_region(struct file *file, unsigned long addr,
> > > +			  unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
> > > +			  struct list_head *uf)
> > > +{
> > > +	unsigned long ret;
> > > +	bool writable_file_mapping = false;
> > > +
> > > +	/* Allow architectures to sanity-check the vm_flags. */
> > > +	if (!arch_validate_flags(vm_flags))
> > > +		return -EINVAL;
> > > +
> > > +	/* Check to see if MDWE is applicable. */
> > > +	if (map_deny_write_exec(vm_flags, vm_flags))
> > > +		return -EACCES;
> >
> > The two checks above used to be in the opposite order. Can we keep that just
> > to be sure we don't change user observable behavior unnecessarily?

Ack will do

> >
> > > +	/* Map writable and ensure this isn't a sealed memfd. */
> > > +	if (file && is_shared_maywrite(vm_flags)) {
> > > +		int error = mapping_map_writable(file->f_mapping);
> > > +
> > > +		if (error)
> > > +			return error;
> > > +		writable_file_mapping = true;
> > > +	}
> > > +
> > > +	ret = __mmap_region(file, addr, len, vm_flags, pgoff, uf);
> > > +
> > > +	/* Clear our write mapping regardless of error. */
> > > +	if (writable_file_mapping)
> > > +		mapping_unmap_writable(file->f_mapping);
> > > +
> > > +	validate_mm(current->mm);
> > > +	return ret;
> > > +}
> > > +
> > >  static int __vm_munmap(unsigned long start, size_t len, bool unlock)
> > >  {
> > >  	int ret;
> > > --
> > > 2.47.0
> >

