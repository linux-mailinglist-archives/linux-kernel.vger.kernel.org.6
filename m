Return-Path: <linux-kernel+bounces-368704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 972049A13B0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 22:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF84B1C2229D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 20:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA53216A2F;
	Wed, 16 Oct 2024 20:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o3peUJ6b";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gUvav13Z"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E27D215F75
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 20:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729109890; cv=fail; b=L3cIgLprLAJwfnoR4cl9/n5ynPPLhi+6WCeSPH2QrX36bn4qL2RAeLdnNfqn/oPxQ8ihS9HjLC5f9za+y1AmQEV73VEDHy6UGnGJSiCxWgEY0dH0a44+UQ3APs8GwUryV5Vx1kExnjOrY1mSWmQ1OpHNwzL+4xsmNYJFOOi24yk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729109890; c=relaxed/simple;
	bh=3B3s966XBYPGtWS3euVwBRJoibA8zMx+du0G0uv8Nwc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=uVi+5VuVC407kP4lW8rfWEbS2LLOndG6lm5X1HrPkt5M2APvQQVCsRqlUjYHIeyqtYIEjok2k131BO0EAYHhH/GXDKQSO8clw2cKCJpewYh9zt+mcjGZSGG7ahgq5nH/V88vovk8rmK0OhGnOVyzMr+cttNGFKPgJFbSLzFIrpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=o3peUJ6b; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gUvav13Z; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GHtdX9024396;
	Wed, 16 Oct 2024 20:17:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=Hyd+Pze8yb5DThbu
	QeFMYgV/MV+Ys2I+7ZCMjqUFpRA=; b=o3peUJ6bNB9+Tr8yfv+K+yKc56gZ0DEz
	J+mSRSgfNK1yZnn4ls3HLjam4gWpJbphoBzYACfydAreW8qe9h78el046YEYxKis
	covcpLVAchVZQdpklfR7IsW1evFuKwSrse6DzGW+05P3Yw3AvziRsDXMP0+ZKnQS
	bglD1Xfw4aVdj8sUeJ1lN7PycGyfrTfjo4/0FvT+RkII3A4I12HZyEfdUlgGpZcf
	YOv6znwDVWEQP6X7Rjo7vjMR28n/mlzisv350rMi7wEDYN/Cfjvgae0PZ3Hj9l/P
	Ra5nUzGlPG60N9SlAvS5Kd50fEhJwIQM95P0z59RHTXmg62ZCPdqYA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h09m989-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 20:17:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49GIgMdX026420;
	Wed, 16 Oct 2024 20:17:42 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj9b8eg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 20:17:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SvC3UZigBoLx8f7wo+AtUIpJ2dx/SD3VCfSFHHENFSL+ZqzKLNta/kdK7ryY4PlPdOQ04ZyNTvPdiC80PBN6rBCjNE/c97T7FuNWyF71sJ1PHb+1C+jw66NI9Q99uvlXk5XkP5mF7sTWhvsp0XyQs7EOwjtJO6jvekpoC9d9tQus2C6x0XkmE+rSfmeTpyVQGDSLgvAZDZSRN+IHeBEZR4N9jq7nQgxFJv2VBqEDpw04S4PbKKMflymBNdojZrWtPl+m4QkD/zqDrM9tWk8iqyyuf1fSuWX1myc7GvlF+JxXOXdOfVeeiHvZZZYRXvfdMBi9PBO9eBHUFwd+KDB3qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hyd+Pze8yb5DThbuQeFMYgV/MV+Ys2I+7ZCMjqUFpRA=;
 b=yzyW1Ttz+Frx2g8Y5QjTCmwzeaEzrO/E4OyAn1mYVfwVWB3pkHknqE9XnwRRR6zpHFs9FWy/cxo8Km5bh0pP92cU+SHe40wxaQ+/GTU1whSFjtGefycEQ4cHiDlXxsKotX/dyXbBUlxe/jeuLhk8bL+2jHD//16vy6Ntr9XK5Yc2fJJsDuj9rhJAKVow/1H8RFmbnVZ5du1KvLtW2W1Hw/D/ftoiHuknfX5yQu2MdMclrzgrCAaJ7ueIg04rTaz1jtQsCIJL27d5gCkIFXfic6xNGlvc4djGfgLCoMcBq3SPFG2o3QgIosyMvrZtBkcgbMmJOUvfH6nWwzwPZ3bMmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hyd+Pze8yb5DThbuQeFMYgV/MV+Ys2I+7ZCMjqUFpRA=;
 b=gUvav13ZO/4SozBpTT2Yx6pZZs+vd9W5oekrnZLEx1XkjoKRlDvzxn6RHG/NzTXkRG/Hyd8DaPZO0MD/1bT45j8eMLMhaj9N7agjXR5xhyvYxcbeO6DnB0MQxzsn1TBwdSn7xsAxPYLffDqhgRa2JN6JEeKVHyrgfOh1EqnaUBA=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by IA0PR10MB7579.namprd10.prod.outlook.com (2603:10b6:208:493::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Wed, 16 Oct
 2024 20:17:38 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 20:17:38 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Jann Horn <jannh@google.com>, David Hildenbrand <david@redhat.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jeff Xu <jeffxu@chromium.org>, Pedro Falcato <pedro.falcato@gmail.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 0/2] mm/mremap: Remove extra vma tree walk
Date: Wed, 16 Oct 2024 16:17:16 -0400
Message-ID: <20241016201719.2449143-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0100.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::33) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|IA0PR10MB7579:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a3d07c8-304a-4f09-2ade-08dcee1f9441
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Mx6O5bDmY+81nzl+ptkvsG9+PHQnfanNqis2EHJpfEIn97BJyLJcnHvXHq5a?=
 =?us-ascii?Q?Yt0H4tKtv7yVNqgjXOSISBzjyf8lBJ+smR8ZTqMUMdVTGb1zXwkvifmG04cA?=
 =?us-ascii?Q?CVyBvlcK+AuVaR9+Hg37q9COs5Id0HB6EgOoTPPAk6IqoyhvzY0ptXkwhyC4?=
 =?us-ascii?Q?2iE7rC45U6vlh1auJKR0ePIs88WzzN+imjqEqI8HW2u14z2Pww1u545XJ2dl?=
 =?us-ascii?Q?6J9vfMydaqwQeK2X6r/5BTa8dpX0qyI979HyOxnWQYfs1mnmI3cWmhfirKH9?=
 =?us-ascii?Q?e8xGdL7QcUK7TVe1ldU6lTCMxAJJ93lL6SGPCPCkMXVwNtbSj7kPaoifO761?=
 =?us-ascii?Q?AFjHW3aDK73bwMAGhoTNt4ldp8oTeZl63tvcoYAsFf1wh0nIEzaEy3trA1df?=
 =?us-ascii?Q?FQn2kP/MYMiDPFO5WqZiatzRzUs9QNN150HBvRmUinWEq+VXGQRD0xO173kG?=
 =?us-ascii?Q?oBoPhWNzqKmPO3qvxxRt3uxxsixfvEYrhsJ5nwlPU6zT5MJxL4gnGFaen9l6?=
 =?us-ascii?Q?zryixzyujkqOs+6QmXFX6sIwu6LPngqn/MuFfBS44OP7r75czKnpD35iNmZa?=
 =?us-ascii?Q?PXM4Z4vP4dVQVPBbsSRsSedXhA5C59GktqpMdBchm0T7bQ9AYs2X3WpIcQ3c?=
 =?us-ascii?Q?wKtQMSn36sDk+2qoI2F7/0IXU1S2Wl9Urn0sjK1jJCjWHKGk8UjX3WBFqI1/?=
 =?us-ascii?Q?MZlsqbMo8Sn+bq1RHpA+PUI7cXKw1VAlzWDZPYyzg8975aQ1MZCNVx9SJ636?=
 =?us-ascii?Q?9mglgSmNgKKYlBirtjg3X+xMdnN7PkLUyvL3NqhAITksKCECyjOAkBsp+30R?=
 =?us-ascii?Q?CAzzizv4w3Ul94RCKO7NlazSKETZTGkCdXi1eBFYrJbshaeMSM+FYuKZTVNL?=
 =?us-ascii?Q?f2sAk04uG/PWV6947tY6ncxoettSL1U6/yFjqoc7JuroMUMXEGDvo4H+I/YK?=
 =?us-ascii?Q?8v7wt8aJUEpefdUx1tWf4qz7zu0wxpYMnAMoStqaUC7KMcEHDEHFGQgR8sC7?=
 =?us-ascii?Q?LNPIp28yEYVWrAWWj2JB5hhjni0S/MBY5uXh1VE0K6GRgb4FoETniICcfj02?=
 =?us-ascii?Q?2OXt1ysXwGqIpI7rFi9SP05jl/Rahv7P53wsX9axAK9NE1IlEGF8C2nWt/Uk?=
 =?us-ascii?Q?ppy/e57JwaiaH19yidGd6NzRgYCWOTLZU6OvjnxtrCg7SH1Cx0wvYFZEOVB0?=
 =?us-ascii?Q?F9tViTZMaoobNYZwhQTFumnaTP9qs9Zp+gbU6I6tUeosJYTc8BWN45FnB+7p?=
 =?us-ascii?Q?tgIYT9ljIc1d7k3anRWJPUIMQ6KUlkqx94DCGk601UXTyVskI6aiUwN6nDcY?=
 =?us-ascii?Q?9u4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l/y0G/j6FLccyB7YXfh+voBTExzlj7LW21wWyywwLMkSmMAddImvyNDj/NJJ?=
 =?us-ascii?Q?Ab4+FK/T8dYY3ECm/75yLyaCKnqlwkLDrUoGlGLm0VrTGlGSFEI4jVgcOEyJ?=
 =?us-ascii?Q?fh/Jjt5+7FYVr5Pu6ClaV4SkgbflOIoXkmaEb4V0+uvor7HX2Y3f/MYb3xwu?=
 =?us-ascii?Q?f9EV4s/8u8zFj7rr0ntLG/IEbaRn0mdxQng3DtaDhRBglY4t0wJVyDtsO1a0?=
 =?us-ascii?Q?d0KXRFC0lMeuAIvPBOoIYk2icgt6/JFT7XAbEbF5kz2Ixfy5MFjnU4Qxk9VD?=
 =?us-ascii?Q?rkgkBjKTQFX6+7vwuq8EpfrSoUNQGZ1De0+4scFHkt6ik6dGKISM4by/0GWT?=
 =?us-ascii?Q?KKLywaTLe4OR97JasguVDg7PlUl4STXVR4y1qUJv8rRZ0gx9RbZsPSsFrjTd?=
 =?us-ascii?Q?YB/9CwHhcNvM9ZwQqxdUHobzc+MdLsoh1j9BoDGy/AvYD7pI4S3cWH2JD+DG?=
 =?us-ascii?Q?8np9yHxMLIlWa1r4dNGfinVuVAtPOFXQZJRLCjq+/l1TrIIC31WBWRXmgTHu?=
 =?us-ascii?Q?L1jF/PMcQE/d8rSZBWpmnFr1cColVDLkRpT9eqQaWSylhlLrkUcOl/1JPDda?=
 =?us-ascii?Q?M+A71SfBSvQKckpAxqECdtbLhO2anmOtwK3r+WoFzZKNzVfrUOeW6XzUUXfF?=
 =?us-ascii?Q?aa7A/GLG5VQKvwoqUa34m2rkECY3XG/wyAeur7dWzKbNq8Wm+9/mLrbr7rGU?=
 =?us-ascii?Q?HT0cliTVONvM4I845dj2HobgUXl0inB85LBG+DlkfzQyTDNroGCJCsWbRgbY?=
 =?us-ascii?Q?1/Sda/dJb5n3A4GIcPtWwI/+6TRZHIb9iPzyKGI7YpvNYi22nDtrSv7E8Owx?=
 =?us-ascii?Q?Pq/HZ7TTLHwvmT80ag2zTZAS+5DgTMkRoqJSKpTSgBYe/wS/ZiPqkxCSCelP?=
 =?us-ascii?Q?QBhwWf/pGwj3ZSd4pdfP+v9oVNyqgcxmG76/duJiLwrBX+nZPj28zPU9yTxr?=
 =?us-ascii?Q?F5tLY+uffGDf1WIlsZX3qY7MZYkPiH8U5+RU81+9P3PzSkn3KpiVCK6gdV+g?=
 =?us-ascii?Q?1OQYD5Y/LhtdQW9R90XE4MX+J67nAAs2OXIgEecRRiRNnn8KWr8OjHR9pICo?=
 =?us-ascii?Q?IRtRT4B1v7OPds5thTIXFwA0O3I4wxKy/OiTP4B90YsCetyGWScTzfa/cVjE?=
 =?us-ascii?Q?wiYhsKoZ/TM6PWw/Bq4A3c1YKCIA4DxaZjbwZ8le3c0RPu/xMTgwHDtyf7zl?=
 =?us-ascii?Q?z8nec1+w4WYzGQk6CaWRgVx5Jc4wIKO2NP1dsu44x6BSePTt/50LSAOq/IbZ?=
 =?us-ascii?Q?slCFanKyQnXfsMzoY8tyP9rTrofRNWapSK/P1kttHu7x5g9oZXvtE+trwRsK?=
 =?us-ascii?Q?XkekeF198k5WNIfCNgj9vNDULKjdqRNic5BHYw1rBUWslN2WJxj+ql+qFPK1?=
 =?us-ascii?Q?i9UAwRUf7T5W+mp/tGOsBRRYewlKYaOfpPJAW44JoHL9I+X8Eav1KBPBxxZx?=
 =?us-ascii?Q?nqZbOV88xnfGa41xBKGOJ19yikU88Y9dQWNxD44p1IiI6mx9fw7Yk5whPboj?=
 =?us-ascii?Q?X1CW5JKXBvkP0Lhgy5QkcDWZkBCH0oZ3qibmia1OXXsw+aedxbrQ01DOwoj2?=
 =?us-ascii?Q?3wjx7o0W+E0w4djIShEWPNKwuXeo848BNhh5bsLODF7dzJoUsdCCafSP21nh?=
 =?us-ascii?Q?gQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PDwsu6wGV3Ufj9Zv9RymEMXUMTLZcXSYzJlyURSeH9M5NVNNX/fWxvJMzm0HYS7mHJ8UEqsfUa3keEnt8YbOu7xkZpfpqkOxsNyr+XRaovNU1QJExGBYf74Cj+PBjpS0gSfbOGaEIqRXfGWwf8KOkQxwKFDKM1smJRCpOQ709upg7QUsbcHmnBrC6hZojXRJ/gIA1bJjKTtI17uVyzQK/6M1GtuBsZZrLo6DXu8mKM8PcJvADgruLuvYIlVdQh9eRORFhenUGoqNbsVqzc9qfAG7lrNRqnlhWFwcZnx66BShXCBU/t8E3Kq5aqOPsRNwDTFxFHTFPp+zBBSIcpQ30Aw0QiDcmLRH0p5h29isf8C9WMVUndY6Xild/kq/3r8TWkqpyLKvuNOSDKH66bHZYewm9uG4xGaAi3ejVJtgVNo/RWhw8x210coiGXfqjgGiUHQoykmQVov7zmM9FFEg2F82tDJyCT/uJMw4AOX/S6kciuaubBHE2Ym6BpZK+AzDnqRpvo7YupGP3P1CywoTHWZwbaLZts9IHyYbef1XV2uGGJpbhUqTu83T6BoYODRHkeWTOJvxvdh1Luz2yq7wzJ/9gTRjBbXsvgU82nga+HY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a3d07c8-304a-4f09-2ade-08dcee1f9441
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 20:17:37.9775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qvSa1V0mKdvEuZ3wggllMFqXUXFWf/EsKoUk5JuwZypssx2KHPv2Mhfj2srgCDA/Lq38LSJLipg8gN3RrBuDrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7579
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-16_16,2024-10-16_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=578 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410160128
X-Proofpoint-GUID: wi_jXTnabrRvOmnZB2eFCwD2miX1nmLY
X-Proofpoint-ORIG-GUID: wi_jXTnabrRvOmnZB2eFCwD2miX1nmLY

An extra vma tree walk was discovered in some mremap call paths during
the discussion on mseal() changes.  This patch set removes the extra vma
tree walk and further cleans up mremap_to().

Liam R. Howlett (2):
  mm/mremap: Clean up vma_to_resize()
  mm/mremap: Remove goto from mremap_to()

 mm/mremap.c | 67 +++++++++++++++++++++++------------------------------
 1 file changed, 29 insertions(+), 38 deletions(-)

-- 
2.43.0


