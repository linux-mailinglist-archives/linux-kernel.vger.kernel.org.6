Return-Path: <linux-kernel+bounces-447974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C116C9F3970
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 20:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09E991885621
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E81207A08;
	Mon, 16 Dec 2024 19:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bmb9G6Ra";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="obYmXAOf"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142F42F5B
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 19:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734375707; cv=fail; b=UUJseTMZgUJNy7BPuPwu6ABF8nuovs/toLplXwvS/1cCAcOmUyInPKp+j3iy7/JvPGX8xXtSnzQJ7PtH2xRGVXB5k33re9b9Kk+2s/mguNXd9P6kWVO3RNKdD6RsTRMUzCIeiHJ13mFHduOU/TRO4cfOYpFHyAxv7qF/rpG7q8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734375707; c=relaxed/simple;
	bh=ZylF2Y1Bs/ZTA2jPi5c2epbFRW5TRveUldy3m8OaLq4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lhM0UikrkDmWnTu6aAZBneM7LW7r9IR57aikMuW2btooqcFm1dFlVVphHyWx6giOoiFnoLnvW6K45KEB66LG3CQBvJyZ5GbKTTQpistbuUowF3HdgcEj8qSf6yVuKiXq3YY2oQ9TKkTa5rVM00yUFVS5FgbmHzglZbyI4Qyh8Vw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bmb9G6Ra; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=obYmXAOf; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGItxgN011923;
	Mon, 16 Dec 2024 19:01:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=g2gjVSyDySSpctOU
	jjEoZ5myghfSwM85qHS3gqH4/zM=; b=bmb9G6Ra+BdwcSuteJ5C2y6jvyW1Egwq
	9Grl8KzIt64zlPDP4X34H35xr0uHBK96PrjVmCxaMLKi+w4nOQpHUMBxOMvAFtjv
	E69x8OPHJXCbymDbth4XbX1MuKC5tjJ7UoQlQVerdT/UCMRezVu3Foge/71tycL0
	c8pPwe+K5rDAIPkVqLrjMkpxvKRTJdI7Ux58mgKd0BLSN88qGbwTEpIrBO6qu/Xm
	nVxj92LY0VXlUbJlTrEULKmlDOYa0VxUBuR58vS1Wf0nmhAGE2uinF2MiFeU9Tay
	V7JSRKQH/nOGexpF9tOYwvyAk+V9MAWM7QRguADGew60sStpz/LW9g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43jaj59xdx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 19:01:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGHa7eQ011061;
	Mon, 16 Dec 2024 19:01:28 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43h0f7d0jg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 19:01:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SV6fh9WZIHAGrcIDKfYnu7ZKTbADbdYuOLlxAw44XXhDKUaHxjjBcfWoW8uCzw3I5zOWuxsrbKj7XQfkcwgFtW0RRqCU/lr+q63nFs21Ue/3/IsWW8YWNyrcxqOlP2FwaW6f/Zac1d043V236gI0X9gfDTkLToA+nFsjWpV90pe/fYYNoaMThYraJR78e2hBE4Ge6eryhgJriqtuAw7glL3j8l5TNPI0hQ3qdvUTlroH/gSbNR+GYW+73yjK11/mkkNuVsKrgwlLRxYfHSVfZmF7fie20oLfIDSaIbw3DyJUAa/xxfZISLtOoNsr/nrpZPFThbiVNbJgjt/BFvcoyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2gjVSyDySSpctOUjjEoZ5myghfSwM85qHS3gqH4/zM=;
 b=fY4joiVnRtDRVJGNQrnTkgo3+qumGdBA6IPy/IwzjPJ/t69P46sAYjjhTc5un1gCnc55r7pgWH7axzLBneABbLqXVzDU4azDodbHTpw2hTljaS+vZaulnXk7ntkI3Mz23NnDy7ni3d0cwumCMAJvNF53eS3gcZu/aUXpYmg3Mm+SFlOq8DsE7gERbLc0kx4XDBT13nYz13yA3VkM8Jrsjxe7lJ9wohCRK8hU2EqgsyOuS0WeZac0BMmfEsPpqKTmyGn0dvh756aOasgHkj9GDxg75DUEzyakSAg3Xr4oTcONTcv0pvQa28b/InjGZkdTApYpxlRW3mHuKHNaNHDRRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2gjVSyDySSpctOUjjEoZ5myghfSwM85qHS3gqH4/zM=;
 b=obYmXAOfXolnvaLL1Yz5pCbCPa7vUHVl0APiS/yEf2+IKxzrt9IoF4UaAwfmesOAa8NIgk0DJR+mGNr4KZB8Oqhd8CD/UEotOGfwdRlj4xQrIM35Fuxyec9qGMocgirQiWaDtQCBsWbDbo3Irqz/QEiceVT0MM0QEyrJ+fRqtSI=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by IA0PR10MB7602.namprd10.prod.outlook.com (2603:10b6:208:488::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 19:01:26 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 19:01:26 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yang Erkun <yangerkun@huaweicloud.com>,
        chuck.lever@oracle.com, brauner@kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 0/2] Fix mas_alloc_cyclic retry
Date: Mon, 16 Dec 2024 14:01:11 -0500
Message-ID: <20241216190113.1226145-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0038.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::16) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|IA0PR10MB7602:EE_
X-MS-Office365-Filtering-Correlation-Id: 56ac178b-aa97-4cd4-a574-08dd1e040a58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nPs9ZJhbJ4DpKoQDm31jbrQZ9AlXsP4Lqz9h7kR3s+rme2NaVKD0ZysZQKbo?=
 =?us-ascii?Q?tnuBIVa3YYpXWD3EVAvh50ciQvWRaOVS0EvMabtLygu3/D6HGDMEaXFVRguN?=
 =?us-ascii?Q?wdLCfWnUXQKnFRuSg5XMob0v4mTJxTwllzC7NLVrGHOoxytmSK4KMEIe5j5u?=
 =?us-ascii?Q?eSYw/HzKy2TFdd1FL3uLPMqAGc5p8oT2VWJ2Pxy3e0H8x+ZqX+IG2EsgBIRr?=
 =?us-ascii?Q?fyBqgxuc+yp61MW/JOsO0epl/MADtPWCZiFJ2LfD8Ofe1VlvqSmSk6K71Mmn?=
 =?us-ascii?Q?30m2/lCKbd87ZldGQP3NEZPAowXzp31iHnMzq3hP4W9RfU1xHZzZzX1A4dhl?=
 =?us-ascii?Q?qBpwIz8YFPKR08wHL1LcwquWgdZC3X5ZjfTbvipIcsejNgfK0gOGXGEtfxGi?=
 =?us-ascii?Q?Uru79hPuOpdwQq0PhC0J/5jtYQUPIDHy7l7dv+vYf1JBnC0oR4Jsg4e9XPAB?=
 =?us-ascii?Q?lzyVFwlTMQHJcKa0kZd6Uv9XHkiN059gWlO/oIkZVfG+o15pPkEQGYrgttbe?=
 =?us-ascii?Q?AevIOhonMjGU86fD2ng3U3MuwnhHMq6T1GioRfJxGrINMRvSXCbNZeCU2N5P?=
 =?us-ascii?Q?GdbVlab8of9yn56icIlyPCu89M+K7kra8xplSUv721nnezjOrXFLzfSpSHFb?=
 =?us-ascii?Q?YJfm/T3z0CWZdysFT02hrL5Tqr1ULwPkzumK0wuYp8lFLq5aUUrVpY+n8Aca?=
 =?us-ascii?Q?Gjr8a01oJCBi+Y4owFbPIBAAFHe5+PD1Wji3UWF5d/rRcuojBCpz6DsjugGo?=
 =?us-ascii?Q?emmhk09Pm+qRQMfd0T0NCKktnm7l11T1z/CVKg7HLcr0hXUlhm1qiyJfH0xJ?=
 =?us-ascii?Q?88KSVLCWlfOBes9+JIYsQxi+huXJ5WNC6fzj63YkWcCVc83u5ce2i6/hthS6?=
 =?us-ascii?Q?3nfTI/zZb691ZNhCftJVRsxEx51NdQBnz0OVgLVxyq8lo0o/3ffCIbKVZpNl?=
 =?us-ascii?Q?v9gDdzqL1iyPkai9sfJtLddXN+A70DK1bqYgZKN8t9wRT1WK/n+I6eAGPw97?=
 =?us-ascii?Q?o4pZ0uqq/wzD6BNZS45gmgfKPS0xEEomj3Jz/+j40Kr86DesbgTNB+k5QadV?=
 =?us-ascii?Q?heF1U1pm5HBpoIoBOoGlUOjxHmRBFvm+Rab+1XRb5F+QZJBK4O9SIqUIVqvh?=
 =?us-ascii?Q?kD9uWYTk5bWoloWBIDU9ILYlEHJWqR7pfs3YzGtq5xcLmJai6VHAgEMdXYhl?=
 =?us-ascii?Q?W29o056QykZ9ZiTfozo6OmkmC8ltGNruwOwtNG0WUMbjLhFYJCiBgENlJdTk?=
 =?us-ascii?Q?/eKv6jc44Op1IP+Ya/Up6QgaEqJ7NUK2MinBXldzpxEXbE1dH4qhgDyOaoGc?=
 =?us-ascii?Q?pAJY2Oogc3pakfy2B+PTKIpeIQNCHl3CLKd464YTa1g3Zw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kYfvLNp29GC/UGDutKdxgdpme5lOr2/f/CeHCFnvwgwn5bqSqKXUhWzJpWAF?=
 =?us-ascii?Q?xIIPOs8CFaVJiHR2IOrq8/jF5JoLWMQhQD/HiaW6RhZbu4i4n8FRO0TRui1k?=
 =?us-ascii?Q?eYvzLMInIjZY5clA5zApIfqIAnJEnW5Wui08s7iF6GF94V3csgZ25D8EfJSu?=
 =?us-ascii?Q?hNXHNsdGvXiisnhdS3xVIEmC7T3e/0uuvw9z4g+ifsXURvqzG2ssyfmBKVsq?=
 =?us-ascii?Q?rKN9RTLur9c9EI555dYNLY8e+H52uh8H4hWN7gSNWTeZj0s2fG0mwNXvO7dj?=
 =?us-ascii?Q?UMazze1jCRUQShlQHytk+xX0/tbQAWjs0pBCUnxN5LV7812cDaBOFMVSh0qq?=
 =?us-ascii?Q?bmt/vCMpjB4u0QZvau2qcioz9QQtuXzcVdGceYZ33gQ85F+7wsP+NiNTYmHn?=
 =?us-ascii?Q?Lqf+twmV9zgNONE8ijhq5i/YxvnZl9/CUKchceRTFKBoQyIRzEcjaOOrhLWJ?=
 =?us-ascii?Q?JPaoVEbHz9BRILwjZQ+SNGo/SyKjro7Om2abkGkqkcl/lKFN93WYIo4/gyKH?=
 =?us-ascii?Q?yIyFpeYuYGoNqhOLbGNuY+rxh/22vR/IzGCfFLzmH81VzHEg+NZqdDWSAg+R?=
 =?us-ascii?Q?7HnRjTHWIS0oTWFOGb0UH+wS2+A1ncv5Lemacd+TMc0f5hsblxJIQibekejO?=
 =?us-ascii?Q?LZ5+JJbwq+qB0BadD5TNaQheTtDFWVllAd6NA7fG+I4CLda81oS4yfBo2nk8?=
 =?us-ascii?Q?KlHs1oqFFJDvghXmVGv41a2H8jNVEeTs5R2Eg+JNraRh+jfilu1OzbcskGNt?=
 =?us-ascii?Q?rWSelAbelPVWgDKhgdSjVbEvrFGUQItua1OsTfH4vVtUDFoeChepO3aIjCp3?=
 =?us-ascii?Q?LxtEslPVZ8eBOLeeh62NzwPDL/66VOkbCRjB9wdYidtA7Y86PAPVe3PYD0+R?=
 =?us-ascii?Q?QMhLxsuG0rHvV2UBHUnBmeuSrGis7ehaejwVbXr7HHZDL8E/uV0ncNetNyHg?=
 =?us-ascii?Q?G0ZbGs/Ld29atRzVrV4GQk7+rQMsX14Uoi1yFs1W4koh+dLxSU+Q2bH5Vfmw?=
 =?us-ascii?Q?QNh0Lern0h3e++j5iUrecVrDVDf3dSU0TPbzQMPCmgl4o0oY7yoabPo3s2Uz?=
 =?us-ascii?Q?qGxJlVF7GkRq1mqkf+lSCLB6THdhKLLqBAoknxDRmtyK8VUn4P/HIpk7dRjm?=
 =?us-ascii?Q?QFCIJV4vMbNq2V8u1Upy/d9OL6Kiwcj+UjbYXzkbm3xVVO0OKSjIzxh1Ea0h?=
 =?us-ascii?Q?PJ3beLO82HieqWSn+gSWWXF1NLUKWozAD6cP1XwggZcXl7qSuoc3cb7hjgNe?=
 =?us-ascii?Q?TSGJ5aCjuEdd88DcEVZzYWgIhXgsAnR6ghTI7FAgyk9npjJftYFPWGLCKUzw?=
 =?us-ascii?Q?A0bOmCqCl8kABQXRY2GH86oREygbwUBDxCbGMMJEFZNV5NbhZT8j3JYtE0Lq?=
 =?us-ascii?Q?oJsH8e5ja/s+c4CmzeaMhx96HyDPy9DhkZqGA5mtnOua9jA526GXiXBKjgbr?=
 =?us-ascii?Q?tFWZQWEfC61Hl7yQqLvq1jAxDpyNEUTsteWhdleUHP3qB47b5UModrq9bHSs?=
 =?us-ascii?Q?SGOGmUynoyYmjf938U65RD/i4vaUp/UyHNWpMKBu+AqIfgvO6BUkG1oia3ca?=
 =?us-ascii?Q?mwhw4IgMWvK4oe1oB2dXFdTwdW/a9obBgiboolx2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	A9umt2g1KlSpTFsVE0npwdftLWRqV6nl+8VZROdzgm8iPte0jEEram/N1PyTIEFCnF0nbkNjAo46u97IyazBagG5vBb/dq55rdFM+eecas4U3xitDXcFkE7Kg78dnQ0oZXS8eo6W8n53l305NfpeS6brp8xI4kNW6o8SJrOqw7NPO4Qj/Jl2c0GlZPDPvF4lL4Frga0rR1OveMDMfcK1sBHfmVpr5c/48e3ahvcH7k+gQ3uXogFKeoTMLRV+t4P/SCRB9ntWcKLa652NVWA3rHcGC+nYj3xtrAG+A4revIOzkQdJTZrLQwtDO2bQofCTMbh7Qd0G5E9TBOQ1EI3OT2nERUXfMxt3r5MQqo5H5724oZziSYqlcynt9ky+uICu6cUsCout6+ROA7bpmovV+ThUAU6NJz4RjBCSkiVf9EVtDvk3jhNzslm/ki/gbv3AgedrgYF++gtnP7aI6DnhxgKEPlQ7cnpTlp/x/FNdIsDxhY6L4zuXIkIBhDY8Q4viBlRPLsmadTuKLBqAiM4JbCVXicdpuoSblO55krM0KINaZreKziTnio4KPwdE7l4Q5zqDJ+Q4t+HQEP69W/nJGiiA8hkMx9oU+jgrAspVNkw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ac178b-aa97-4cd4-a574-08dd1e040a58
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 19:01:25.9915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ACi4Jq1c/aRkq4FuXUH46jsL2lN5JcFeR2pxtupeKhV+OC8Mh+BHOGghOWyIhKO3Dj8fr5T7ctwcTrmk9rXUJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7602
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_08,2024-12-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412160158
X-Proofpoint-GUID: 2fwZjqpmgJAVNzTxlESccB6AoMNUf_Tj
X-Proofpoint-ORIG-GUID: 2fwZjqpmgJAVNzTxlESccB6AoMNUf_Tj

This is a follow-up patch and test for Yang Erkun.  lore seems to have
eaten the original email [1], so I'll add akpm's link as well [2].

Patch 1 applies on top of Yang Erkun's fix, so feel free to squash it
in.

Patch 2 adds a test to the maple tree infrastructure that will catch the
issue if it comes back.

[1] https://lore.kernel.org/all/20241214093005.72284-1-yangerkun@huaweicloud.com/T/#u
[2] https://lore.kernel.org/all/20241216060600.287B4C4CED0@smtp.kernel.org/

Liam R. Howlett (2):
  maple_tree: Fix mas_alloc_cyclic() second search
  test_maple_tree: Test exhausted upper limit of mtree_alloc_cyclic()

 lib/maple_tree.c      |  3 +--
 lib/test_maple_tree.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 2 deletions(-)

-- 
2.43.0


