Return-Path: <linux-kernel+bounces-182759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3428C8F5B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 04:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF0B62829F4
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 02:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8086FB0;
	Sat, 18 May 2024 02:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hMnN1GXo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YnxwNy9Q"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCA74C8B
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 02:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715999045; cv=fail; b=R0FNA3EKs0Bwz26+3puf83xrSkFPaFIKzQBNdNSvSTOuqDX4lgopHijksdSMOgPCxsQxXDE0I8ado3PuZidGiw9mmQ91J7Kn/L4YjNsJj5Jx35Nsiv3nr2+i8It8L7TPFY0CtZOODCWMUjKLbBlVvgww418qspYOzhPIsOEKjjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715999045; c=relaxed/simple;
	bh=NR7bwCChMOvTBYOBtOPa4phCEZS9PPlDrUTiGOlDUX4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=Wnay7D7wYrKQnAniN1UKIrhAQRs3qb1Cl7vc776/PMUldqxF3Q0YcrejweN90OCxLZic6MQUgf9z+d94gjhQo+qR2ALDLnUeOFEy4mCSmOrakc+3ZlK13eq2JJwkjt0QxasrtpExby9HJc/eiuq3aQyHDwhdWtU/haOqGq+nRWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hMnN1GXo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YnxwNy9Q; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44I1Zb3t002785;
	Sat, 18 May 2024 02:23:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=9ydZl/H4gtEp9zIGrTPv+mvKdjkf/OEkdIFPwIvf8Go=;
 b=hMnN1GXoG+YqNIEXEeIV6sVJGaTO4nGs5S/xhOI15QnyxwoGiQGEUbvIBkEWUD7qXTxY
 jrdlS+RppULcl40yE/hPca1ycqlSNwXlyEj81pxJJRfCVmAW7HVq/1vuJSVJijse/4yh
 kAhFNfA8uBuEYzv2m8jaoyq03aiDQFPbYj+t+/UI2zrJRPGLRHMpQu4++vAF71qIWvvd
 Qm7bIqzn0yI8yb4JrnRLADzxGq/BcKVQ/daIe/GZO1PgWfaKBRNiho+yeChhbotE5Ws2
 t8djcN/j2Qu6308HN0m3NDbgoIOmhFEQUhZ9A30CAQEc0A8WkFTIxmTtXJM3kN6AioyR 7g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3tx8rnuk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 18 May 2024 02:23:42 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44I1XSX5019525;
	Sat, 18 May 2024 02:23:40 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y6js48sar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 18 May 2024 02:23:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NUNYRo0eEMn4NFa9JwPXqyONUm1N0uZue09O8aBhWJiEREY8iuCuAGoflEkTVOqGqGYryK2SKO3qWk89b6PNNlsTV+lVPm8OZI4miJsOGfq/qf1E829Xd6nKAEGiN8o85ygr4F6GjGsRQkypVVi5LeUHS9h3QmRqewvRBG2CRYYex4ppogf9NyYptu/7SceLb1luseCBthMUVRWCExWHVm6++g+PWIm5wKIsx3oqbioLoPdQWtS8fNvpGxh9cbwlvE49GfDdhtdCw0Myt2SkVvfkpgYNRadKaW0OWnKbj8oKiBmkYEKZzhWLi/nlYps0xJeNbrBWdw9DzjPNFZrzVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ydZl/H4gtEp9zIGrTPv+mvKdjkf/OEkdIFPwIvf8Go=;
 b=kvl/iaFDNRA7C29uJsWphVM0zstVvt1Rw4MDZfOPUU/nVyNUeVuNdiWZS3+/clVBYb+9kaIJojpZjceJLDjnB5BR08G9460CBLl5qV6snG9sfagOPnMLRnf3wfRcYhrZu5S/xdFPRy4WsIl6dGhG0rJm5qDYHAZn+XgBvsJcl5lMjHnYgGPQgqKzhvvCBxDYoqpqobtJ6QUImEz1+gR9ULmzi0zVnAp1xrEXbb8DacXIY/OIKc+cnLL9lt7s/KG3e0OIKpuI4PKELv+WGwsUKEOX1fYlXK7i8Lre/tnzg1dOLaV7Ko+3qYmi3VpfBcoDAE9JPsIs4Ds3Vfv/YCX7LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ydZl/H4gtEp9zIGrTPv+mvKdjkf/OEkdIFPwIvf8Go=;
 b=YnxwNy9QCS1apvvQkO7SSNTkwNTD0ZCzWRpodw344uNoqC+zETAFyQgBUyLj0LQH4Xue3SMU+7hMrSyTa9BnpbtmNPKJ67q2xDOxhamkIZU4BuJbaF4+M8hxNumN3Ew+/deqWhXazY5TEF6w2dhnM3dYAoOqpARL67dkJ8SffkE=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by DS7PR10MB4864.namprd10.prod.outlook.com (2603:10b6:5:3a2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Sat, 18 May
 2024 02:23:35 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%3]) with mapi id 15.20.7587.028; Sat, 18 May 2024
 02:23:34 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu
 <mhiramat@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Jonathan Haslam <jonathan.haslam@gmail.com>,
        Kui-Feng Lee
 <thinker.li@gmail.com>, Ye Bin <yebin10@huawei.com>,
        Steven Rostedt
 <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] probes updates for v6.10
In-Reply-To: <CAHk-=wgQ_MNipb2fOSDmXJ9tYko8OhzA0fPueR-kh6eYT_MbDg@mail.gmail.com>
References: <20240516095216.ac9a0fd13357450cc5f2e491@kernel.org>
 <CAHk-=wgQ_MNipb2fOSDmXJ9tYko8OhzA0fPueR-kh6eYT_MbDg@mail.gmail.com>
Date: Fri, 17 May 2024 19:23:33 -0700
Message-ID: <878r07q2my.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0178.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::33) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|DS7PR10MB4864:EE_
X-MS-Office365-Filtering-Correlation-Id: 67fbb638-f7f6-4847-4c07-08dc76e184b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?oD+aG7k7YJ249C9iFjgY57ZMevP9eZ1zgqw45i41fc351tvVDWx39mH7KyMf?=
 =?us-ascii?Q?CrGXmoiW7G3Nw16lP6iibkjdLEGlCEIY7FCAhdEWVpdi3m9irmVhgsdc7aSq?=
 =?us-ascii?Q?+qnWfjYdWfweonLIOHBW1Yfea1LyEVMU1M+fm+C9JWwmqvWgOlzmYEendT7U?=
 =?us-ascii?Q?XAdhTjhGmya0x5iFl83KNPMyP8rQ2wH1ckHTgeVD9JsDU6QPvt1+UU6d6+lv?=
 =?us-ascii?Q?nqPz0ZHxiUYPU6Lsj/cnKJtR58PmP+H3/kVF9GbHf6QZIB5a8/8ri+uJpXWc?=
 =?us-ascii?Q?LQVD/IMRHPF+S92QwZJNXEu3hflDQP3d1LXmbXaThXaP3sXVrC+2Wljb79o+?=
 =?us-ascii?Q?SwZiCjRD+aIgrFNV0jtsqQlVXqkQiZjlP2pPHv4qdYRy5URyNzueRwPk2Ds1?=
 =?us-ascii?Q?y68XbTVb4nkzphkrqO51HYuObz8+11G750fDyY9o8wlci2nAya15beuaL97U?=
 =?us-ascii?Q?yCFVJYy+DaT9ePr8/xXoUlOF8jsO1ptx05QKtaUYJNChXvjufUvs4C6ytAff?=
 =?us-ascii?Q?lR9hHvG7FK6Nyc5Lc3QjmFeCvreb7d9diCCWrtK4H2okWkmFcmCVTPpYYeih?=
 =?us-ascii?Q?tUNCLvBcIyO5lGCutVA4Pk6mox08xNDts5YPtr4fCo0fg99HIHVK7U9qJmDK?=
 =?us-ascii?Q?wOTbebg5+KcdBAYaBnqx+HnsSS/PQg+gHDSVLJWnySKAUKxdTqzgO2caboia?=
 =?us-ascii?Q?hXT8ELwOF3W7STkexiCHC+7NvC39/sz4+jMBvOHGZm22QdJtWZwCmpdV1XzV?=
 =?us-ascii?Q?3neI2h6gKRLS+v7eCmRr0ITt1cCJ9CaG3wABzembqt4OaLnhQIlCGlvxvBsk?=
 =?us-ascii?Q?v0bCxYZP+3livvcta4nonDKOh8UEiqG6d5x/ZQkdhehFr+bVMjWLCDcIRgNi?=
 =?us-ascii?Q?v0Onwkdlboe0FK5ZlHBT8oeB6wOXxnrD0Jv84o4TtnoY1c4ThkTZ4dNxc64O?=
 =?us-ascii?Q?NulwO7ZhG0/pdEEvxLk0yTWj60JfQHWvMueHeV/2Wu17frJHtQHJSqwd3j7q?=
 =?us-ascii?Q?6jm4bMKW55pn2HWrJ75pSIWRpydbnP97vBYjoC2MvonBdpCJYlQIlZ4p7KlP?=
 =?us-ascii?Q?d6Qm315pr5LM52Y1dQU7pbr/6A3jqVhMiaGqkMqMprFqFmUZ5PTEsZHdD3er?=
 =?us-ascii?Q?1z3H/CHS7h2GND6SjnFWHgGhNZ1O1zJnYm7I7j2hc6g4krMXsVuGKiz2gjLc?=
 =?us-ascii?Q?11HOoKVjhTR00FX3a/c5P6EliOkjwWuE1nNttt/G3q/aKohB6cPOUPLHsps?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?t2U8IKDKhxQtpThXjeAs9fsXg7CIP8Oe3vZkws/D5WVS1FwGju/MPc3wcBqS?=
 =?us-ascii?Q?XmwfwNCTle6xu46m+uv3EKXwuiQzFUcHwziYoOVhAm5h6Z19rQAuZWR9S44Y?=
 =?us-ascii?Q?yONakdAYrLaOBzim5ZfFO6cxPZxxcpPTwaGiWIjzOerIWdak3Ge7elF0RFne?=
 =?us-ascii?Q?rwZ6R9jrxiAM5tPpt3/Oeiw8s6qXX/QCbOQGW3ugIpxRHpDHieINrnp/Ne5M?=
 =?us-ascii?Q?lUIWyRIwWULJlhO9/taW7LAfEK4U6oms16RpLKH2yQfUSrHHAgeH2+DTH5Ny?=
 =?us-ascii?Q?JAejPNuw/d3AsF8X4Ihxmw3cwbPOeAEq/mUYxid/zAmaWe7taWBN2U+2c9wz?=
 =?us-ascii?Q?OaFURmoJtqgL0KX1SXaQ9Nl8j9SC6rsyeNBEVq0cC2CYO3le7dpBtuJ3r4UE?=
 =?us-ascii?Q?I5S+r3AFjopHK1ogR5RkoLSjWhuvFTPQoupNTDTy7w9ipckmu7t1843Y8sNH?=
 =?us-ascii?Q?mDWGPiLY3IxT8YmmOoSd5XFxcBtTZ8sPC2E3kxxONZ+DNBlNP4kRRIwbYs6E?=
 =?us-ascii?Q?U/5Ah4hBXJfTdVxu+zFeDk0nyCYGXQgp9HX7MmkCQo5ZyMCIU5O1k0lH/WJ1?=
 =?us-ascii?Q?wjDH9gYV7ZSWOnv6ApbWilsRug+MCdMyml37tMBFxHOJ0VTzv8KplBD+Qtwq?=
 =?us-ascii?Q?1H6OvDc3kQNeuijfhvl+Ku1dvTAd2VLVPWzQjo0z9Cig2NSt4vFaeD0s9K6n?=
 =?us-ascii?Q?15tNQeDyK+qq0BtnKdiB6Sq5WvUNL6mS0nX1hpdyqO6TR8Kkn3enZKrDK1tb?=
 =?us-ascii?Q?L1UqLih1FMwny+FFyzHn3DVT5kAddlhlo2H/HshN60Vh8wTf7sWawg3haLf4?=
 =?us-ascii?Q?v5Mq62Wf65HAXjOGChZ3pllWSuBARWU5UA5JMEQw9n2w6JZa1FNV3v85gz30?=
 =?us-ascii?Q?1MgrMiNovSj7cf+fm+KNMFuuPn1dNEC8axN3u80zqga+otLcAvlXAExbawzj?=
 =?us-ascii?Q?JSQEEVLHH1s/wEwnCcOB/Lp8UvXVj3MaEhgF3Jzqhg6yFTn4lv8ywSbscAib?=
 =?us-ascii?Q?6zfWyKSg0MTtn3RYALAX2c+PDiRI2Zz2mnMY2PZBLb/PSaZflQcF6mkv76L+?=
 =?us-ascii?Q?8JICBVw3KB3HhQEbr2sfJMFxNxsJ82bXjBcTSa2AE548G5cHfDFiWUgnJ+iK?=
 =?us-ascii?Q?hPO7bq+Bnq6140PuVwfej5oCHQ29P4uOEPouzcv39s8BmLl8y0ufeA86dBqQ?=
 =?us-ascii?Q?0RoGNUx9NSwsFS4CEUZhGvTNjcq2MxnuJvEwxqQ/AM5jOd2mQrhOs9ZIOc3B?=
 =?us-ascii?Q?T6WXuVNYLRRixLC/d7otqpnbZZWefY0oEI9PCR6tUkKCPC+Mrc97ZLEFgfM7?=
 =?us-ascii?Q?n9mY3sAkd67WIK0ZDPCUJolJw1+5HfMQmdFAgbKZ63KLit9pbKLq9+88t/L8?=
 =?us-ascii?Q?WBCXsAbvGXVF1/+hQuSWQDX0C/nv7ukNIeIMucCWGH+gyv8nKZd3MV0LMGlh?=
 =?us-ascii?Q?61D/49eBgiQIj4nS6XefzHfTYVJOZyl2yo5nJ2hfCXcXUSCKBkg8BSprzdHQ?=
 =?us-ascii?Q?JyHiF/xAJCJy0VB1cM5wZEfrMtQx4IT+sGzaoTuJhXjsbb7B2WmWM1TBt3aP?=
 =?us-ascii?Q?qiShhen9Lz5TfMXO+q710TgaPWOrDM5Gp3GHAryzz15zJ6ZClh6VmEaRw+Fi?=
 =?us-ascii?Q?7hFvXpyZ/7wrD1Q9jHOiTT11S/n2lfRPuYNzNBUcIJQSELAPTgbUOvBccB5Z?=
 =?us-ascii?Q?KErqAw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	h4SyrnC9ON20DnDM1Zb3fKF4oh3Pp8KcNowzT9BCJrrnbtOOMDfeyshcJ2/QjkckfRMe7ePoRfqW6eRzBngES2H9iwXX1BnNqxylRGIuHtTOmYuYUVnGzxW1c8Hq/k0ISuBeXX2B4/TMyGCuIDjlz+spL3CXxGw1CR8EEBRX+ncYU9+6EceglQyVgGcdCnB+emTrppXra0rDSr9bHrHKmHsuijtqJhFbFMj5Rqtv6T1bXACXgzI/oLZ+dVa++WQud6rEs5w9ex688aH4PJwpCCSYIKQKftuLznjns70govDXFRVR6SMiF68zvH7dL6l8KqYsDl1p5VeXS52u5xLHowj5LlDorz7yMNaQEjSKtUGt6r6Bh8gau8krbpmx0oSZ3aTOLVDcXLc0YOhIR3h7qIw1YsqRet3p+ghpBwqG8hLQYmBrVttiH29/sr2MoJPVpnX755gV9DrWWy9d3DATVBMhr9eIWdH1lIoUuN9DYpYfGc/iMG4TaQ+eaI7YieHGZInwc9Cm3JQ7lZBnWjAYyK7RZsGsdK+3P0I3p/OPsUkAN0XU19aHcmtH/8XUIbMzJIzjBBK6adSJmRtnIa4GlVe/f2CDMSDra1ERpnfN+mA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67fbb638-f7f6-4847-4c07-08dc76e184b8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2024 02:23:34.7506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GFB5vtcAfRJLh8f+eMNlQYK8MFCiJwQJXwDP894Mv2S3unEu1YPDB5gKRXnkMurJnnPd+PFsVgEM54HCJ4gGuBW6t0uz08wOAcIxzo8n8Ho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4864
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-17_13,2024-05-17_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405180019
X-Proofpoint-GUID: i6VcewvSrws1_CAjZMnYo-UYV-QabQOV
X-Proofpoint-ORIG-GUID: i6VcewvSrws1_CAjZMnYo-UYV-QabQOV

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, 15 May 2024 at 17:52, Masami Hiramatsu <mhiramat@kernel.org> wrote:
>>
>> Probes updates for v6.10:
>
> Grr,
>
> This doesn't even build right.
>
> Yes, it builds cleanly in an allmoconfig build, which is what I did
> before I pushed out.
>
> But after pushing out, I notice that it doesn't build in more limited
> configurations and with clang, because:
>
>> Stephen Brennan (1):
>>       kprobe/ftrace: bail out if ftrace was killed
>
> This is no longer valid C code, and hasn't been for a long long while:
>
>     void kprobe_ftrace_kill()
>     {
>         kprobe_ftrace_disabled = true;
>     }
>
> we require proper prototypes, not some ancient per-ANSI K&R syntax.
>
> It turns out that gcc apparently still accepts these things, but it
> really shouldn't. But with a clang build, you get a big error:
>
>     kernel/kprobes.c:1140:24: error: a function declaration without a
> prototype is deprecated in all versions of C
> [-Werror,-Wstrict-prototypes]
>
> and the reason it didn't get noticed in -next is that this commit had
> apparently not *been* in linux-next.
>
> Dammit, that's now how any of this is supposed to work.
>
> Why was this untested crap sent to me?

Hi Linus,

Yes, this was may fault for missing "(void)", that's basic and shouldn't
have gone out. I was too focused on getting a prototype for each
possible configuration that I couldn't see the forest for the trees!

My GCC builds were not W=1, which I will do next time. I would have seen
this with a W=1 build. I can't speak for why it wasn't in -next, but it
did get caught yesterday and I sent a fix:

https://lore.kernel.org/oe-kbuild-all/202405170340.eyEMhYvc-lkp@intel.com/

My apologies.

-Stephen

