Return-Path: <linux-kernel+bounces-387466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35ADA9B519E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 19:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5601B1C227EB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 18:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784F41DE8A0;
	Tue, 29 Oct 2024 18:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ncXCmrn8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WlmeFrJF"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DF818130D
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 18:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730225572; cv=fail; b=YcvEw0Yv9JJZEHIGTJ9tMoFnjpPE9ZOrr980M8j0ZAx2cerq/FeyZIES+tbfq7fVY1mxqV0Du5J0CqCLC38xRP27j8/k2r+4ycNWW+6GwPmiDC5PvbV2NCfX7uiaDzgsCbD57wz2lIYTkhxXuDIRHXycabqEOuAe4kQx1xEcqOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730225572; c=relaxed/simple;
	bh=qU29Ww3vOKyQ7Iuuoi/kc1Sgue89dA3wHB+TI2YZLKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EBoHK7l8oRB2Neui2qXcB4IQWs97VgwUd4wNEY5crRBw94SzrTOGu0D4M34Ge/Te+CHfL8lSz+IwePyYtL0g6lyiOcImPndGfZh5E2AG7SbdGeiyEyxKZXFC2jRDgXAiNhUDdXBXdb3u7CPhFNGgwmQuXhdZ0243NFsZu/XYg54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ncXCmrn8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WlmeFrJF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TGfdn3003433;
	Tue, 29 Oct 2024 18:12:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=gD3/8yFb/Fj1edTJvrvVzYBFOVmebuxOTpOZBoSXr+c=; b=
	ncXCmrn8C/XAWKaT5GpUg8c4Aj5WFb3G6K1ms0Y8iqfm0Qru/HwBxz9OF2XRF85j
	aAYhniVK6CumoP6ZCT+e5B0+x47OPQ6iKyZBsLTu1Sl+pQFVzzchSPrYRTHvgyGU
	9SLpJB6f0Cj05qnd4OKyBjydbv6t7UjAlTDzw3dgwqqT7i5KY5BxjOfrPsEZI40m
	CRclVIj9TuDu4pVvKLy4oefflI7VMuotyExL/oNbbt27PmsTF/2A+okpeFmeHpKQ
	CtMTVyIgUR6ZO64YDzff7cNbJ9YqkOfjXq4u/IZ4N/qNFKDpZDKK1on3pq1JksjW
	czdh4nqrGThW4p33I2Bc2A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grc8x83j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 18:12:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49TH0i3e010118;
	Tue, 29 Oct 2024 18:12:20 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42hn8x8ww3-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 18:12:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M0I8h/buFrWBydFKRy4LuNnJpGdXY1nZJx9nCeYmn+hJJKZrwDzQ9Jyd0aUZga8oNT8snZh61aOPI/LE/52WLjMiE9MGIV/YgriLVaB47QMBZVC0iTLfu6GJDdNrsJXZ9bJGbmLzRpPGr73/Edcf/Z4nkXTM2BAzA0uvHImuc0eLg5W7ziEO6YHVv7rjgkZMu0wJIU1LKhN2gUHxIX01ctleCRyH/Nbb5I8i7yS1ZDLR8zJxo0303FsSONhbIlRu/2H4emBaSLGst3m28ZRitiPxrHH0pX57oyLDH9paduZWTtWrE/I7iJ7ULlE7cC5U+gvbLAJav98EhBBtK4YTiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gD3/8yFb/Fj1edTJvrvVzYBFOVmebuxOTpOZBoSXr+c=;
 b=UdBouwznFwC+ngpzbvRR3xtNKbBrTI1cmPw5/m3ZgqYMwlJAxzr6yk6zL7eGMt0sESevW7y/N3uDBt3IDg9kzvSY2dhmA/na5HC+gBQdZB1Bj+PnbA8QYs6HrVYCTOx8SzPZ19NrXgwADiao6sWOL5M/2pVkrboRnl4hbPrip+jGSZwITYIqs2iZKh9BjZsXLUwVqMm/7kc2jdkZKiY6JIaP2/icZX8rq69w+bPz8qIFUata90f73nQRFNFTxqHh3QaBclykujGVzRBwt+YDaz+nGuzd3PEP6QlOGjht8HZeS6qrw4CT6Nt9rX+g7YWgI1csMWo9K7vGIM4tP6pIWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gD3/8yFb/Fj1edTJvrvVzYBFOVmebuxOTpOZBoSXr+c=;
 b=WlmeFrJFcri1phHg9WLUMt4sYlc+pRmZXLXt4+EZDUhKTVzfXtCV7sOhBL2yk4AgrmBUt9xufTIamvoiQv/VEqmlkRZFrMReSCICLTGHAYhZsIgyGYxYmqkwlqXgvsUDvEe594SJ/pb8u2dSAz0nYNmm5oWYQiOsihhzSwNUw6A=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH7PR10MB6966.namprd10.prod.outlook.com (2603:10b6:510:277::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Tue, 29 Oct
 2024 18:12:15 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.027; Tue, 29 Oct 2024
 18:12:15 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH hotfix 6.12 v4 3/5] mm: refactor map_deny_write_exec()
Date: Tue, 29 Oct 2024 18:11:46 +0000
Message-ID: <6be8bb59cd7c68006ebb006eb9d8dc27104b1f70.1730224667.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730224667.git.lorenzo.stoakes@oracle.com>
References: <cover.1730224667.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0072.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::36) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH7PR10MB6966:EE_
X-MS-Office365-Filtering-Correlation-Id: 8edb01d7-b2ea-42f1-d4ee-08dcf845378e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ozz6nisSp2OI2Iyq5RrJInjUVdUcqD5Hg5zC1pYn7cpQ8qJ9nRZ85wtt9sB4?=
 =?us-ascii?Q?FEdq1rSKfqZ6Wom6Oj2aWZkxcCYLSczZtMQ2UICdKJbdJD90F7wFUu53wbHD?=
 =?us-ascii?Q?/DN7n/YXCEl97ajQr8QcSHCSq4kMBFKWIlux/6mfl+7jI0+MAsswSsezNh/r?=
 =?us-ascii?Q?L8uwdbzR69V2wToVMLErokpZrUMV8Xx7PFDtWzjRvRaZxauO2SWDuZkjLBBe?=
 =?us-ascii?Q?88aYA2+EI89eXjPs3Qj4y/ssDFeDyHZPC480GNEfDmLHoD5RWUMyWh31IjR1?=
 =?us-ascii?Q?Moqtryhet4gZQ9xcKpJHYtu7JjqU+HDunOQXA71syQ95eJRJse2aTfyA2TRq?=
 =?us-ascii?Q?xeljTzzrswvnDYV7CFcYPsBMtHKIuCxrfO5qEX05kY/PQ2RDwDnWurHxPOEE?=
 =?us-ascii?Q?66+xI9sVetvmNtkuA1ybK581zgULjkZk3V+/8DjrgQ1IXDcxAFPhfl4SL61f?=
 =?us-ascii?Q?P9U3a0dX2ABUR214VGvY1aUL0xo5lGr+xPNO+Pm9mPmU3JuientyBIC1ogjp?=
 =?us-ascii?Q?t5Y6Xc9Vf9q5zeRjRqneB2BymTeQYARRvUIJutO1X9vUAvJpDyx1zSJwjtDP?=
 =?us-ascii?Q?jy9bMIRe/DehBqSCT/yD0dCWGSnqw2vGFm5ax6CBBqSJ/lriB9Owt70kwqyy?=
 =?us-ascii?Q?USiuI8NeB2qV+V92v0+CMuwl/k1JrRR54TnZ/vWHxGyevpa5cBwXASl0QyYM?=
 =?us-ascii?Q?m21LfSTtwdY0PBUNYoCyVPZhjZeimHosA1cDqaPeTerwxvdHTWrWxlSINLio?=
 =?us-ascii?Q?pPuC6w4SP3Og/MSxIJHzNS0BdSakBPSEuuKiokc40uFjJJ/81zSzDnb8GCzw?=
 =?us-ascii?Q?Na4O0elHh/vHvFIqBBZofuYOU9sKMnlIyYpW5EUAruSrkjd6MA+G0Dp2QkY4?=
 =?us-ascii?Q?H4vnfgyd216jqBPyUGN2liN/BdviDamZ0HZSZUStHWJZxnoO0yiCcwALSVcD?=
 =?us-ascii?Q?lTVWs5BsFVTr1eLZDPj9cDBx74G24Yx5NPZbS0rDymkDimD1jZhtIX02+eta?=
 =?us-ascii?Q?jrhlBBhOKTSp0gSUJ1GRvxfivhVeiJ+BLbEqsWe8k54UJxtW4U81dTf8TbNh?=
 =?us-ascii?Q?OzFXd5Ko110ypqu6oxf2Dssx/UjR4GXx9zKFcSh3ltaYux+Qg1hHyh7GQO3R?=
 =?us-ascii?Q?QFZfgqLIAC5sitXDUAkWstV6m+orcke0G4cZPScJWEcdk0RvIyY1U2bSxRi1?=
 =?us-ascii?Q?WxZel3QCtQpiOo5iyWANfHulm0Ll7e2MUDWO03h1m9ypxb2/Hb3zbKP4f2+0?=
 =?us-ascii?Q?iCbXa3lNM++Jvi0T3KExOkQs8NSXUZiBNP0oqPYtOnGNu0elHxBh2s3tG4aA?=
 =?us-ascii?Q?C8pPx6etxmyUNzfKzV78L4Pt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sLc5jIUeuf/mv48876dOaYoqEvrUsLE85BrZC2Po1U0MJJNkv3fmI+l5FeR7?=
 =?us-ascii?Q?ifyKet81d6AYe+HcBxWUAc+ZnSaq4GqpfiMD9l8jjm6p2k2re5Zzd6n0cMWw?=
 =?us-ascii?Q?S/AH0mJvloC8SlWqSILdn5M8C9zYETutK7Su7sx0GXCUqv0kQuifloxpdwnR?=
 =?us-ascii?Q?HT5r3P7O/t/DiAPwDnxgsfkGCvtGmWPefAFVwkksmbTprIAwIp+PFFxWJEWc?=
 =?us-ascii?Q?S5pGqtXmAMoJ0k+f7MIrhh4xhimcEcfQcEkfI4BZ2frvhC0w2fkD1oeSn8mP?=
 =?us-ascii?Q?VEcCtw5GLJafq7QMzRrXDTRvLsHp1jhi5AkJQYSJdvZSEwEs8UyZiBq7hL/I?=
 =?us-ascii?Q?dqlbgBxWrKVJrBiRIsgW87BrHOZlo8zcpzKvoieF1Xz5WbgmSc78v8aOF0S+?=
 =?us-ascii?Q?oUOhbOqjvCFlWBZBmKVUUmaCyZonMc0iEaC2LVbQnHsbXuWqSOZfffh5NVCH?=
 =?us-ascii?Q?oF5jMU19Z6ln9bJjv3Acen04vvCQq/vImiv30SCPlwCANZKFoMyEVIHmMQu0?=
 =?us-ascii?Q?x4jEXTYLf/uIvfNmUYBKUL/VBPe6SCbw9DWHE9uR3gH23QlyBWvplEcd5akx?=
 =?us-ascii?Q?IFDgLcJ6HwRloFj1rZuis9Q+u3xWSQ/mN3qxjCLYzOVh9uKCcc4l7AbaDyjO?=
 =?us-ascii?Q?jrN1U+Y+ELFwMmmOKhFCYQopHAXo4YH93wo5cEY4CosuLgNuDdGIS9yeBV/M?=
 =?us-ascii?Q?edJemnqpF5sfdFecdHWKOWcz1iKmiqjozl7/bMm38Fqti0enIldDJc8VU+d1?=
 =?us-ascii?Q?P4J5VjtzJS4B1M841Fokbdx2CzFua6krCxago21F6erYpSYtp7O4g432JhPR?=
 =?us-ascii?Q?danxjsxMMPGvYwqaJ/UFxWldPXsgYzOqUry/0yd10rC0wog/1FTyWeLhKIN9?=
 =?us-ascii?Q?QjtI636TQYuZTjt7NDx9ugGfUW9Cm8i+CPjcLSAr8AN4aZ7UkD2CWYUcfTN2?=
 =?us-ascii?Q?hPOZdWfoNMsPkurqGaY/zfOrDuFcHR0emnAGEV/WESA6YkUBgliW+LGXi8JL?=
 =?us-ascii?Q?ntj2t8xwPprclUXV7HCmyqLl+65Opzt55mE3mcvy0GweKrssWpoi1zb76lz4?=
 =?us-ascii?Q?5Nfw+DQ8ty0UNWshVeyHiZkz9xC9NAmpNcOXlOjYSAnJXWCFn4PndPyo94QW?=
 =?us-ascii?Q?yoxbKNpM1NV2nsMRcKOP9Wr79ZYC2qGTFTlGSVJUxpfB3bLeoCkz3sGlXFRm?=
 =?us-ascii?Q?p37hzY+Ii44aDHdO1YRC3iHExhe4FdyAezfMUa96lAUu6olOxTTB6UwJRN/O?=
 =?us-ascii?Q?otwmfxKDtEYplOBzOnCu2HkenMgf2a5B9dY2jnZp6HojT0436189cb3hFSsv?=
 =?us-ascii?Q?gUevGLTo9ch8Xzg7ug6vBvil0Chs7PGE14P9CErSGSrmW9sjzMFABnMnkYJt?=
 =?us-ascii?Q?H2CWzlooYcZJMGgRld7P9Kgnu6mPb/iigtOPGZiX0JZ4DrL2hilwNzqVs8TY?=
 =?us-ascii?Q?HDLLkHJJwDJSjJGaqimYXaVPh5H158w1MI+IEEzDZcpfjJaSwvQKrMWXHXWg?=
 =?us-ascii?Q?eNTAYgFKD3KCnI4S4v8yYD45awwziNhiBOhr0MWxZ3FpKhUG/lfMbiWPOSsq?=
 =?us-ascii?Q?AG04U2vH1YvwxR6fqYt+vlB3VaRW9HoZBcuK0r38haTwDFuQzwUdhvkxpcUG?=
 =?us-ascii?Q?QA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vk49IzcWjbgHVXL9sXMeFlB1G5v2z2EW3tgnwEkob+TmIjzNKSKZ7XwH733jZ9IuBbncL1rJxIbzaDyETZuRIafeSfFyscCMnnE/7WCNvcBhfxiAlJNP5McIxARWlFFw913dDjI6NjCdXrxk2B6XZ/st5enaAu1JA6ZskuBnwAkmWxIuTMsmurZc/wCSQYiV3UhYthd7oCRMO8fYCQWPb1Zyc1yEPEiLbJnir98rxBiUMLc77HMoLYlDjbCA5MkWsyZeCOPIWsMZlH2LWQYLS7BaSxF4czQk6BQjonL114hlXZSxQsSk/hIdzFC0VEkmB+EZwlAfRqjAU2pGrY+E/BSJ0ukKTReIcaiErmUCQih+p4eZX2ffeYD0j5lQduc82+YA63GgaQtV56a0uvFilQyol1ReG7nMJbtG6zhN1C8pJ8DL/Q6Wd4wn7FD4+h4uHkIWqNiDkrD1/y470U0yFWrc5BO03PxPy+qlewApyBvBjnRePqi8k7/vW/lebj9dlbFesWgxdlbkoExDvz41DA6liMzK2mfuD2oswWqfGYXi/0NSympW5JsqAaixHDZI8BUh15ZsodzMse8UzmPhV65cc1Um38FI40hnu4ULzw4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8edb01d7-b2ea-42f1-d4ee-08dcf845378e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 18:12:15.1038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lTKoRECnVPFzNOJmnuBPYsiA56//lpY14uLHNsttg0K8IeCj07G2mqGXDOpsFq/wuPTtOOgRD39qa9fJxxRuItz2O+O4Z96L466N1j19e6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6966
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-29_13,2024-10-29_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410290136
X-Proofpoint-GUID: X6SHYljO0tOm8muJZfY4ssgyH0KkU9P8
X-Proofpoint-ORIG-GUID: X6SHYljO0tOm8muJZfY4ssgyH0KkU9P8

Refactor the map_deny_write_exec() to not unnecessarily require a VMA
parameter but rather to accept VMA flags parameters, which allows us to use
this function early in mmap_region() in a subsequent commit.

While we're here, we refactor the function to be more readable and add some
additional documentation.

Reported-by: Jann Horn <jannh@google.com>
Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
Cc: stable <stable@kernel.org>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Jann Horn <jannh@google.com>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mman.h | 21 ++++++++++++++++++---
 mm/mmap.c            |  2 +-
 mm/mprotect.c        |  2 +-
 mm/vma.h             |  2 +-
 4 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/include/linux/mman.h b/include/linux/mman.h
index bcb201ab7a41..8ddca62d6460 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -188,16 +188,31 @@ static inline bool arch_memory_deny_write_exec_supported(void)
  *
  *	d)	mmap(PROT_READ | PROT_EXEC)
  *		mmap(PROT_READ | PROT_EXEC | PROT_BTI)
+ *
+ * This is only applicable if the user has set the Memory-Deny-Write-Execute
+ * (MDWE) protection mask for the current process.
+ *
+ * @old specifies the VMA flags the VMA originally possessed, and @new the ones
+ * we propose to set.
+ *
+ * Return: false if proposed change is OK, true if not ok and should be denied.
  */
-static inline bool map_deny_write_exec(struct vm_area_struct *vma,  unsigned long vm_flags)
+static inline bool map_deny_write_exec(unsigned long old, unsigned long new)
 {
+	/* If MDWE is disabled, we have nothing to deny. */
 	if (!test_bit(MMF_HAS_MDWE, &current->mm->flags))
 		return false;

-	if ((vm_flags & VM_EXEC) && (vm_flags & VM_WRITE))
+	/* If the new VMA is not executable, we have nothing to deny. */
+	if (!(new & VM_EXEC))
+		return false;
+
+	/* Under MDWE we do not accept newly writably executable VMAs... */
+	if (new & VM_WRITE)
 		return true;

-	if (!(vma->vm_flags & VM_EXEC) && (vm_flags & VM_EXEC))
+	/* ...nor previously non-executable VMAs becoming executable. */
+	if (!(old & VM_EXEC))
 		return true;

 	return false;
diff --git a/mm/mmap.c b/mm/mmap.c
index ac0604f146f6..ab71d4c3464c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1505,7 +1505,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		vma_set_anonymous(vma);
 	}

-	if (map_deny_write_exec(vma, vma->vm_flags)) {
+	if (map_deny_write_exec(vma->vm_flags, vma->vm_flags)) {
 		error = -EACCES;
 		goto close_and_free_vma;
 	}
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 0c5d6d06107d..6f450af3252e 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -810,7 +810,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 			break;
 		}

-		if (map_deny_write_exec(vma, newflags)) {
+		if (map_deny_write_exec(vma->vm_flags, newflags)) {
 			error = -EACCES;
 			break;
 		}
diff --git a/mm/vma.h b/mm/vma.h
index 75558b5e9c8c..d58068c0ff2e 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -42,7 +42,7 @@ struct vma_munmap_struct {
 	int vma_count;                  /* Number of vmas that will be removed */
 	bool unlock;                    /* Unlock after the munmap */
 	bool clear_ptes;                /* If there are outstanding PTE to be cleared */
-	/* 1 byte hole */
+	/* 2 byte hole */
 	unsigned long nr_pages;         /* Number of pages being removed */
 	unsigned long locked_vm;        /* Number of locked pages */
 	unsigned long nr_accounted;     /* Number of VM_ACCOUNT pages */
--
2.47.0

