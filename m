Return-Path: <linux-kernel+bounces-170585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E74EA8BD966
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 04:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C59AD1C21795
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 02:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90F84C8A;
	Tue,  7 May 2024 02:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E6N2iGA3"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1061C4C6B
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 02:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715048989; cv=fail; b=iJtlw6n783/w1BfJWniQnLJiWoDDbOX9SBiZc6jfiJLjIczlwS8rcxlTN4Zq/zx/a3tgCz5wEA3IiqWPy59UzeQI+Lhsf1F+9+/s4slgD8GJnjYMfGx0JnU6RFwQ1C7olE2zxoxVGuRpUiye9G/z8Ua8PC7rFZwRDnX6F3sm4Ic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715048989; c=relaxed/simple;
	bh=QG8K0urlTegMXIJmUHrfaN+9oodsTzMxmIsQn4IykSc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=uzTdXybzpUjofSdg/aLJ/YvJHhmbMDJ02euwkvVTvlstQPvzVmhW59l81JzJvMnSujOst1QLp8QjL/5cSGRfvJ/npju76PYxD11r75j4FYO2ncDQRCbViB09A1V0smeLiOat9gASYVPluJ5hkcIMYMaulEcID0LOx+qdYaw7afI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E6N2iGA3; arc=fail smtp.client-ip=40.107.220.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rlom7QOVfNNOKHiLbweKNVttKlpYgdyfAl/eSG7cSh33nqa3wSF23CvEsO3HxihHYv4kVZ6CpXLcjQKQgbOTeDKw0lJyhTuD9ohEV5GtRGODOmhQ70mioOym6YK1FJtbINlRCk1IcjS9/EKlsnJptI2AzqDL/DKTDf0GlUaUaIA+eHzo4cmHHOWglrLvNhu0TKuZOiyGce1/0e+gzOj82t9g9VDT8LLY1nV3r4s8SznewkFTmJ4tvN4yv4VtN7LCzu4of67YB/7r3MPupNNM9OTzPtzyjrDwnGGfC3xLCQtBm8WHG9SptI6F1qUS5zMmPjGABduWUCb/X6yBTs6d5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGGj2aazpVHVj2n5fnqoj1QVO9AwzTD7xPqUsAEEeQU=;
 b=ksaozMKwNagjMwG/tdhLBcgjryPZ15I6ozGaV9Cq6qn8ZesOJss1ve+tRt/E4DO43CJDXM3j0736w6dl6Bvkti5DzgA3h6j4NmfkQ59qJSijMmMmGYGh6o1Nqhhh8sENyplDN38oxvOLzLxQW4Gfb6i8s8Nyb1oVfUN1/S1lbR+vw70/Bw6S9vjrA1fKO8gjVITreQOWSV8F9tBN7sthcRPWRV0dENgkANlLkCND9YDs++y9CRhKZ4HoY0rDHfTjo5MlnuQd7JqA1lqFfhXulgbT8xanWiNy6g35futn68VhEbmEA/S0nrtAz5HNgfG/KWYbBbowv1uEGW/cr4WpPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGGj2aazpVHVj2n5fnqoj1QVO9AwzTD7xPqUsAEEeQU=;
 b=E6N2iGA3WjAgHwj4fHaMHDIbehP7oMFuJxdYs1Jj+qF7laofw2tyw8l/ockQ+m06Rkpo5zi8X6xL4w6BbIdti8J7LJeOQZdlQcDlbWCStKmFf/dwOGZ6AkcqOa78EzAmFyPI1WAYxt4R+fA9lwENxKM5QkkpX7qCKD8A9gaXa/qpK6Ox4gh2rSo/hSegmAeM+sWFxcKria7o15ulN984fxbQckeYDaUJN9m8h9OxbK6YdZRjb0ouHPNtGqcYjMSP/AGxbA/PFIPou8PaG/5Nuia9JLQEycWDz6zFXZ8xKeTOM6W5lsuf/O4ShCju7ysDTwDALifStXE8Geip3DTsYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13)
 by SN7PR12MB7022.namprd12.prod.outlook.com (2603:10b6:806:261::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 02:29:44 +0000
Received: from DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::5b0:8154:dfef:2cac]) by DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::5b0:8154:dfef:2cac%3]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 02:29:44 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-mm@kvack.org,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH] x86/fault: speed up uffd-unit-test by 10x: rate-limit "MCE: Killing" logs
Date: Mon,  6 May 2024 19:29:39 -0700
Message-ID: <20240507022939.236896-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::37) To DM6PR12MB4140.namprd12.prod.outlook.com
 (2603:10b6:5:221::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4140:EE_|SN7PR12MB7022:EE_
X-MS-Office365-Filtering-Correlation-Id: 61b320d6-d61b-4a41-12a0-08dc6e3d8e82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JPn2N5eYHKioKaCOlWQPjZ5PrlN4W96RdUbs2piHBVpl6k1yFjAyX0jqAEMQ?=
 =?us-ascii?Q?YsJPADMWKdMJ2zZo58xGUtqC/JxvMBRecxNbuBabpaFTGY0+f3My1Lix4cIF?=
 =?us-ascii?Q?u/SIHxmnxGwM+kV5mLHKZ88m3sDRoVq2lwNu5+5XhMHmIIwglWBNY2de1dD/?=
 =?us-ascii?Q?Bf3eFT8yAjZgMBeqJ0duYkGrGrp5HTGoN7sdoQ54VgVEfMC/JYcI7afCkArG?=
 =?us-ascii?Q?NQDFSa3B6eoDY42SLWfa/ZraPPzjUj6byc/lShtA1TCEBdt+w60jZudAxLuk?=
 =?us-ascii?Q?erjWt2sY8JrdLqeGye8d6UkrntsBzut1yKU39a4Eqmhl1IyRrwsCOVP5P0gM?=
 =?us-ascii?Q?gRYK1bfwoVSyzLq2jf18j3G80DYqe0y9sa/Q0wRbkPIoGVe4dGqSwzGcqVAN?=
 =?us-ascii?Q?b0beeY/uI8biNfBgIKn07nM1JTfgiC+Ork3nOwIRRZLD/WZvpDbMT2Fp5UM1?=
 =?us-ascii?Q?w/w80QEN5aJSrvz/CNpdGBkAddw5//RtGWS894T1+6KIRqIg/wI8w5tU36Ik?=
 =?us-ascii?Q?Iv5NEgartP54Gb+kRcxVovzF4dVXQyg9KkStSIeUkTGKMOcKvEXxOmpAx95t?=
 =?us-ascii?Q?l95vaauwe4VOl27s/EgNoYw0ZxeBGKUyOkfMQ+GiUeZtrw5BD7egBX1BveAX?=
 =?us-ascii?Q?4z/Gzbu4mq2BqWtLpRTrGzf2FTb0Wp5dFihMGQJ7LOPTWUnCBZg9upU7uT89?=
 =?us-ascii?Q?qYYFmRc9Gkw5Be+J9xAoTWla8HgX8AO86ZG+GXn4lVesb831hbEwhd5n1m7x?=
 =?us-ascii?Q?Dz9giIj8Pi1lurDzvPt6/f/rPyLsULxbzY9VMQOkrWInieJ6KF1/jsJ75gAL?=
 =?us-ascii?Q?M0LIKf7o9M9ebQO/5e8z8hyokSABbMYFuBB8zintK8VidGpM/oHR7w5qkk+5?=
 =?us-ascii?Q?vy4LNNBSgyu4iZMfrp/sgxZImfIbUiH221lBAUFwRnv/h27beGxbGFQgEt3z?=
 =?us-ascii?Q?QLt7Uci7D7vMnUalmJzgqWMjSiYDi9FbJOt20QzshRPfq9hkCjVZwVS8+JV2?=
 =?us-ascii?Q?ZmQDyntjwAryFrCT66OU28IEtHQsHXUyTbKHTB/8VHbgt6m/+EPlQ67hLVAt?=
 =?us-ascii?Q?e/IlpUZWSmjxCBcjqjNjSylqJ1AYPbfm2RmuovyioCxSV55iyrmaOhZrERyI?=
 =?us-ascii?Q?1clbKoOIEG8ImSAWp9O3NrRpGABrd15aVz1plFvVgO3hG/2r/58eXix2Mdgq?=
 =?us-ascii?Q?ZLJbm9WjbPhUi3lE8GLfuDPFar0DSCsKAvkZDTSicQWRbmNNZYkBOJ/PkVbW?=
 =?us-ascii?Q?yl9wS5vvKp9japs5wOw+tVQq5CvCibMPCNhU9F2kTg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4140.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o9ezY0XY/DIKEVAhBcNeVkVM27juuJAz3OnvziRLAnyC4w6BCcS7+Uwgx9pm?=
 =?us-ascii?Q?gE8Ix0Y5INzBtY3JRnrKrAdteKZbtS9qehIZ2mlj2Wi8ZY28Wtv6eTpl6jCO?=
 =?us-ascii?Q?fmnWqRb0gkXCQma3wqu961Aync+NX1chXjpKk0uYdi7z9Be6D8fBL8cXIgbQ?=
 =?us-ascii?Q?maTpphhx0VPe/4GggLnrVJ39uoWWm+y7dIywTeaPnAtT6mmBFi3RBNu1g9xU?=
 =?us-ascii?Q?vxHhIo1/hubxsuUQdQ5NbOt5jeH/NKByA+pg7TOV/Bqz5MyVUdey1VnRwZw4?=
 =?us-ascii?Q?9CAaCjRBMK0YGV9tJQCdHfwO4MY8N0ldl2E56oKniZNA4oh/DbdfWfV9UT++?=
 =?us-ascii?Q?HsNlRPmzwQ8v8dA3WXQ4zGFwNalrjcJTKC5uJnVbaG9TUTJWne5yK3Cc/RaW?=
 =?us-ascii?Q?I0UcSxcrCYu7J+p4mzXPwx47OUcVdROyEPmBzIYzpXBkSEWoSh72D6GSqt2C?=
 =?us-ascii?Q?RQg9HHwH1CVerFMcGaBOuc2823cbm7Xkb7B3JH/+M5vwCu1mRkGe8N8Lrrd9?=
 =?us-ascii?Q?1b4diYiQhI2270ESjC0rvGyWcOWgEpnoUhtR3UkYW0IjV8D9rotfAPKCknVr?=
 =?us-ascii?Q?8iOEtSBaz1N4yaHt0UXkj9hRlFLqrPeVAJDfmQRAY3N95Y/1QAWmTbfkmZoD?=
 =?us-ascii?Q?EcfxUpMb4Mub79B8VxkmwMStOBnykgLxt5pWup4z51FP2fr1mgVTRQ8k+byv?=
 =?us-ascii?Q?4EL2miu/oYf3DDkaMDi7C5hQnuTR6EFlpNS3t14LHZTIDGQsJA3szkuDnm+f?=
 =?us-ascii?Q?FtKE1cMqAd6TtBrGTKdwbaf4f/YXt+Ok3vU0oLTD9C7hLr3XBdwXn2SpdzRw?=
 =?us-ascii?Q?bksosZxTI/EzeyERlKu/qAS7wkOgTwKOIX1wK14b57ixvVdCqqRykgXD+sU2?=
 =?us-ascii?Q?bVyUS7w3BkEXphjbUD07sChBVN9Z4WMeKiCzBFg1QaITVsbKmoimDIsalKIo?=
 =?us-ascii?Q?BcOVyMrfhQi6dPAwePsPVgwYqXcZxR8UUv+YfctCqA9PjyxsSlgeiV/s/ETC?=
 =?us-ascii?Q?a84Jf+ihw0rxsoxX7W5WlyM0gNXTMq9d8kxuRLHdSgVGATvUTQqxSgpfEFS4?=
 =?us-ascii?Q?GVfF6fpTe+xcn2oxfPb3Sr7c4xb0QyZflpBxuInBie+leaaVqhRxtcVcVhkJ?=
 =?us-ascii?Q?D1oTsHksfbOXHO+/5fLXoRTxtGt44BQsOingOBOmLw2jf9sDjlYfhhcEopJa?=
 =?us-ascii?Q?cviqPo8jaIPui0N8K+ZmQD5hOb1W2FnJaOZ1wOBad3Q36Bq7ts3QyLoVanjN?=
 =?us-ascii?Q?KSEFFXjbuupSEWb25Z6QcCLwTdw2V06y84DClJHO16GSEBzcbBhX0bHu9f2H?=
 =?us-ascii?Q?o6UoJoocNh/B82jdwbqfGUUX2KHUkJo9+bW3uH+fmLtW4iOFE/wKT1AN2tme?=
 =?us-ascii?Q?THnk24H8JJzAvVOOg6zrLZo/HNU1Yj6h45vRDXdYhz50FfYZG0R5Pcqaq6Pq?=
 =?us-ascii?Q?TUV4TCKPmajVp0tPjXJf/+BbmEWuP23SwtvnEtQW4nlTN6Zoww144k3hkJJx?=
 =?us-ascii?Q?68vYxWypuA+WQStRCl2Y3lr0fwIPOBzkc6R22TeCMBLUvTZJlD8EoNE90eqv?=
 =?us-ascii?Q?L8RrsgmCrH+P2HXw1QMiYE79iPi5UAuEK3YTNB+8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61b320d6-d61b-4a41-12a0-08dc6e3d8e82
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4140.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 02:29:44.3862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oTtwXzF8bFHelC7iE+CYM243Kw7JRNkl6SV4OPpaJ+Mwz3zrXw59u/zbqxyCMXcTMSn9sNb5rua8/bUuJ/Naxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7022

If a system experiences a lot of memory failures, then any associated
printk() output really needs to be rate-limited. I noticed this while
running selftests/mm/uffd-unit-tests, which logs 12,305 lines of output,
adding (on my system) an extra 97 seconds of runtime due to printk time.

The test normally only takes about 10 seconds, and the enclosing set of
mm selftests normally takes 305 seconds, so the additional 97 seconds
really hurts.

Generating lots of memory poisoning events seems like a valid use case,
by which I mean that this is not just a testing artifact. And that's why
the fix applies to the code that directly generates the output, rather
than the selftest that triggers it.

With this patch, all but 10 lines are suppressed, thus speeding up that
particular selftest by 90% (runtime drops from 107 seconds, to 10.6
seconds).

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 arch/x86/mm/fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index bba4e020dd64..e4f3c7721f45 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -928,7 +928,7 @@ do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
 		struct task_struct *tsk = current;
 		unsigned lsb = 0;
 
-		pr_err(
+		pr_err_ratelimited(
 	"MCE: Killing %s:%d due to hardware memory corruption fault at %lx\n",
 			tsk->comm, tsk->pid, address);
 		if (fault & VM_FAULT_HWPOISON_LARGE)

base-commit: dccb07f2914cdab2ac3a5b6c98406f765acab803
prerequisite-patch-id: b901ece2a5b78503e2fb5480f20e304d36a0ea27
-- 
2.45.0


