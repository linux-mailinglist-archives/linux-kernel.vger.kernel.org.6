Return-Path: <linux-kernel+bounces-312773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD235969B0F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 13:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FEDEB2252A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D4B1A0BDF;
	Tue,  3 Sep 2024 11:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C8yyeYez";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EqptIaDZ"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8611D1B12CB
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 11:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725361247; cv=fail; b=q3Wd6m1RwkkSI2eciCzPooit9FiUmtspokSAPdiyCAoGcntGhXZ2RwDoscnG1CaRyIIsgFyOEsiRUDm/AZsvdR1wBUoAOmv+AkoQhFqVqSqjRMlgjxKnZkmMFZh/JxWWxCkcRUzbvITfg6MkvqUk7Ag2KaYwBQlRXcRygRh6dHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725361247; c=relaxed/simple;
	bh=3IcPZapIWhQymnYyQoHVQ4Gl13yXXQBdREfqzZwQk6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OEc3oawlbvP03ZD5bzoeiKQcXktD13sgsrtUAOxRYXUTQfOhwbLdUkvyBWTKB1gXGqxUywzYQAqKfkvannQ9BbSUG/8pFNedFDhhb9FWAbXb1bNvUprR+frQdNe9XSmtRFZbH36azjIPGvYHJOla2odjC5np8iohBFysxie86R0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C8yyeYez; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EqptIaDZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4837fhol019498;
	Tue, 3 Sep 2024 11:00:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=yn27RQ+CrYb8j4Y
	gH7UABQdO+bxpGKBlRV8MyEyqpm0=; b=C8yyeYezy+fjMitpDRjmKdBaoRAPLB8
	QiSfDGLsMccKz+tw/k+SxZUBxclZ7RO0TxEce+Hose+fdell/b4DeImah0vzq5O+
	seYtXYnEAowyhADJhZ5SHW837JKF+2yAyzxAVdxPhst5774YZvnf6QRDL5mQP2ZQ
	kvnubcEVo/gYogOpW9xcJUryrxZFsEQ9tIIBl4riuW1z0/B9TsYer1s/37bmeZ4c
	lg/ghUu/qrzmmHvAzAD8E60iizf271wbkyvnk74qFz2csR0mK5tElsEx3mkKfr+n
	IMEjIClKV0WJs8d2Na/GH0HPmaa3mDMZcrm4RUkYrpFSZTjLhe6/rVw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41dvsa8jdr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Sep 2024 11:00:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4839f8hm032684;
	Tue, 3 Sep 2024 11:00:11 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41bsm8q4sb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Sep 2024 11:00:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dW0+afGJUTRC/yuHzf0LmWXLCsa8xoq9Jbh2oxZawtqvKsC4jFTm58HYh3NfibJa/KNXMR1CcV7dH1+l6HuF/DgL5G2/cqlL8lvn7ygSkVhKB9tDZLzXzsFWtjxB1diuXwtx8+WBNCu6cz3bXfPVsF2iaWcjTkObIzOCD3IEM1L6HTUfRaZHcxVB9iUxvPXateO2/bLFaxWdXEZL+w58YBMn+OTFQBzomZw5k6mAGAHa10FvwyoyqA+jcHqbkyKkCvb+LKWdumhYQOckJvrID+4brAC8Kr9g9ip+sJSI8dxJb8bXnC4FTNBvOIfHq3fodwvWMdVo7VRmJXMV1VLfSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yn27RQ+CrYb8j4YgH7UABQdO+bxpGKBlRV8MyEyqpm0=;
 b=IVhPT9rKksxSb/y7bWHQD1yuaSc/J7Vzc2vz42LklWs01ErEpZ9g8sEggLSpuTXw7jvc34KIKRFTqEWnWgIxd4CtmrQ7UCLGu8UNBDrROpc3iS659uPgU34Td6nBh6yPqxpytCLv0ay0LB7hGEykwg08T7pGmX3Jh8HZZ5aIrAQKsf5/rQ8G7s8nuf0CP+levK6JfyRnQ3Vu0RJfToU86kCpbs9cKRqejO0R4HM/nuU3OafXDbOdTqXs09YcVc5l4YH6YW4bqS6XuQd/02cqJCToDa+m3lAE14URHuKSCaybfeWQj3tLfQqS3Za07Xt3m7kSHOGSxy2n/Clyy0HjdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yn27RQ+CrYb8j4YgH7UABQdO+bxpGKBlRV8MyEyqpm0=;
 b=EqptIaDZq5/oL+hmxgpOLKAeMUdY//dHtAJEZAMHjnyNaekLcAXxB402iPB/jstbKMloY4wuYwg1m7/ypOX/zMQanemps5vlN9GcGiJfn+3jOKcYVAI0ieofvzCvQHtFepy0vaJQBLNBKRc1cdr0ef7BTEiyz0oZ6WUe8knuvEI=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by PH0PR10MB5682.namprd10.prod.outlook.com (2603:10b6:510:147::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Tue, 3 Sep
 2024 11:00:08 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 11:00:08 +0000
Date: Tue, 3 Sep 2024 12:00:04 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Pengfei Xu <pengfei.xu@intel.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Jeff Xu <jeffxu@chromium.org>, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH v8 15/21] mm: Change failure of MAP_FIXED to restoring
 the gap on failure
Message-ID: <a753f480-8dc6-42f7-bc6b-32f37d47d829@lucifer.local>
References: <20240830040101.822209-1-Liam.Howlett@oracle.com>
 <20240830040101.822209-16-Liam.Howlett@oracle.com>
 <ZtZ9euGTU9T0PWDA@xpf.sh.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtZ9euGTU9T0PWDA@xpf.sh.intel.com>
X-ClientProxiedBy: LO4P123CA0264.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::17) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|PH0PR10MB5682:EE_
X-MS-Office365-Filtering-Correlation-Id: 92a11f6a-b6ca-4cc8-1ef6-08dccc0792e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YAQSN1Y3BNCM5JHJyAtg2faHGGiKGAPL67yYwUZO9z4UPbaE76OJTGsf+At0?=
 =?us-ascii?Q?/briTmvsdS0IEHI1rHU4iHJZ53hzkRFA771ZwHNZQBSD0fw2ySVCywIFh9k+?=
 =?us-ascii?Q?kuIL0Wj/i8ML6rQ9ziSGRutWcFEcTKQOBd6kN0ewpkNyegZg50yc5fmGF9Vm?=
 =?us-ascii?Q?+6mk7gRByw13BRl2xWcGpGlWp9/ybwseWcgDlLY5FVW6uYWfP4oa4fOAXUFA?=
 =?us-ascii?Q?f3jAfRmn29qFlf+8NXRvGu88ylUDkX5cy3unOfFEwsliyY1KO8LEfhc8xJCT?=
 =?us-ascii?Q?F4kAobk/ruTWWB2JjeOSbbk80GIrV81phTklUjGhOFqk+KOUqEhToleRZkw/?=
 =?us-ascii?Q?NFNcbFsgTR6y6t7tBPNI0J4pLFAAeGU9Qj9t9zTk0w6YfdViKetOM3VXGjpW?=
 =?us-ascii?Q?DgJTHQ25DYYkVZSJ0igWivrErsslT/BE+a8bnjId9Tb/ANPSxDrvZ5yV5OPe?=
 =?us-ascii?Q?obwuvgps3x021xh40zaNpLOYFaPOm7dlo3PshXJQNY2/Ax7tmAcij8CJljUi?=
 =?us-ascii?Q?c84IBCZo/ioHviS8wIM3AitUcZ0Apj71FT/HxarcKlR2cbF2TIFwxpSj09tJ?=
 =?us-ascii?Q?yU6FMvTLY1hPd5/uzwvwerRjo9tboiSwvkwrPBmMxt+dOO+P9G0M3mAEcSSh?=
 =?us-ascii?Q?VQrL3151ChMFy20sTFRejdQjJlvXvmbdjJbER6BPJ4esHxVDDf02vpQmSuqV?=
 =?us-ascii?Q?IrJK1LkSoZ5rmIsBgvEN4VX0oc1/+JdyInCZ2SQ1IXwgvl0H2UVJAMu7jzIg?=
 =?us-ascii?Q?103d15X3M6M9QhuqBImPaQYvRgGk3oXvHAUyPT7nOnoljr1R02Fp5ikBhYW2?=
 =?us-ascii?Q?mOrh3LlhgV4Tew32u2nyv+ouIFOLufoxZH60nCBnU50b27QVR9F3QgMbMn1U?=
 =?us-ascii?Q?mXxu8b/QwGGG/AN16uuvuNRrZZ4QJ2cOk/veH8mlhKs2g+96G6rXeqfi/1Rs?=
 =?us-ascii?Q?6Zw4nwrBac+VLYgSlDXA6QFmExT945SYHcwpcM/qxpojggenrKAtH1pdmiBm?=
 =?us-ascii?Q?ei+6s5vIQ0CigdC8hTd15DywWx89l1/KF8KYlrW2Qr3ce+AUT1VISqm3d0up?=
 =?us-ascii?Q?eWLqfCPG22ti5Ub+DQpYkWM85zegf1FZXSzn+8Upen2bO2/gj4fp2K1woO9n?=
 =?us-ascii?Q?RdW2/8Vt0PtNpW2sIUqnRUXSGzhnb1LSjEBi5gJ6zWTzQC2j8oY0BjUiPreT?=
 =?us-ascii?Q?+geinxdta55YjrIbNFpUkGbDWFk0g5ZbORgJzuaRDWqKIniRQogHMct2aEf4?=
 =?us-ascii?Q?30FvXUuKRctxP52ySehqVske2yZBrPoAvARKc8RfJ9Jc+AN2HKJM4Q7zOv/V?=
 =?us-ascii?Q?too=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LVqrOXLsY5UUCy1+3KF79kQE7WNK8106RVvgvwQGSff+5cArpbw4g3KwJt8G?=
 =?us-ascii?Q?6J3ups2y5nThyiLhQ65umOgbqAoMQh/vjESw9vYjfv7qvG7BRzYR1RlJQXAC?=
 =?us-ascii?Q?bu4AD5ln2XciT3lk+xB1GICF1+beTLbUytcC9OlTvo9W728aNPB5jMqwCRvf?=
 =?us-ascii?Q?nM4U102TgX+jPoxES89SHbAOecsCyZO/SnY6n6KOoDDWzXDuYc1jRTv+ri92?=
 =?us-ascii?Q?Ef/bvEE+dJfXxoruq4ruikE7NWJWdBe8WQsolcwwpdoVEIWQKikOrr2Gxgcd?=
 =?us-ascii?Q?RTfdbXC55yqlLI5SoP1F2dYKHjjqYW7smb4YlIQqszd0qy1DkBFw7z2U9w7v?=
 =?us-ascii?Q?O4lq40BnOaS1AsGi1BJp77czhL9V1sGPS37IrTEaKwzk/KU2sACgNkrSwWqB?=
 =?us-ascii?Q?E/Gg+JfvOG5SLMuvu4C3gCLHnY2EtIz7ElJys8PdtxeeQdnSa83QLK41m2a2?=
 =?us-ascii?Q?gGPc6NDeKKEOQeDaSuSu00dKLXvuhSOdHt9Hc/X2pNqN8pSw82hjdoCHbKUr?=
 =?us-ascii?Q?jIMGm8A2LFwhZMe00vm687w9ZS3YXwFv/s5ZQ9863HZ95tCSEwfLrtDK2ODL?=
 =?us-ascii?Q?BRTQKvaxQU4tXNTFGLqSiYSv2vfBXhzCGEaMu/UydXg6p1+JAYPyT6LBXPq8?=
 =?us-ascii?Q?BLlz9Bt2VrpkRh2/XWgkdR7taYm0t89Ek2TS1JEIWcbJIouTFKGc5k3NMRgo?=
 =?us-ascii?Q?r4ZAID0YMPz+9XCvjcmUExiVt36zgn9PMNwyNgRSgjz4+Kz4SPCHym4VvWvL?=
 =?us-ascii?Q?k2tBLnwhDbmIral5tVvTd/La6L6TBIpch/ZECEPmyIWEtefIXTbpxTV+Rd28?=
 =?us-ascii?Q?+o1/k4X4NiUjB0o94xw33lFBShKJZEG04lhSvGU63zlJp/S/N3YhxBe5zq6Y?=
 =?us-ascii?Q?GaVaCQmmHlKytIgWvq3ojRqzVSPGxwgMlqQ5LIder4XOeV5PW5uNZn1+af7Z?=
 =?us-ascii?Q?p6/MGRH7cbLUAA5rh0/9+JHIj23DJvQGU7NILRjuVhKN3BpEJmIR00WTnv/p?=
 =?us-ascii?Q?1mZyFVLQNlyzVXyO+iSmNiubwQJVNuYeUhArbTSsvy8xMDBx4TvPBGhodpgL?=
 =?us-ascii?Q?zbnNWrrSgvJuHp7kPIgcBhVTB9bMLVMlL+pr8NZB4bVZR8uVxqnCTiR8gojb?=
 =?us-ascii?Q?zF5NZhZZwHCeAjlr+CZLg4I1tx+BTUUPqAeDhG75xXaOYU6EKa5eOLhBCsRg?=
 =?us-ascii?Q?tMYHdp/aISYZqytqGBxQ7G/jNtCm1m5m4goHNIbMdSBPfO201ES56Lbs/Kmc?=
 =?us-ascii?Q?dtxWvy0A65qdpfHlQkGLfJlhVhqzPFLR9lvuYGlMuBAOJ+vJkZww6n1nTk1z?=
 =?us-ascii?Q?t9AIqOPbHZGypbDAB7B2yUroOV6TDTO/NmhOvYoyt/RRoevySSopDY5F7ows?=
 =?us-ascii?Q?2n/IZSSnUp+kzCy0PSA1ZqpEFLncwGZcqF05oLnj7yFYXC1lHdsV9SqN58pU?=
 =?us-ascii?Q?QAFW99QewTw+HzrzS39z1E843gc0thGQnsuJaC3X3LOgcVjW+o96EjvcLR6Z?=
 =?us-ascii?Q?eyYnVFOWiV7N6OY8oUrqmW4R05gjJiMoCBJG4d9GglD1DslaYxEDaJkq9bAC?=
 =?us-ascii?Q?FKpZ8arFhmdqCf8IOdoim74pahmlFm3Kx2Mz9oJS2Jq4MedtTjIUv1hZB1TQ?=
 =?us-ascii?Q?7w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jrFth3gBlf7h+9V+GYruWuvkVYKxvwmJh9ZBB8acFgVpUrzYwV3ynVFRH+fxKZHnN1frjUFNF/qHQj0j1wNYAHcnAhrDTCFDM/k5iGY+V9S5SfP+9pfRUXVRRD2EgU8aWNvbUG7+KomcxxQL/mOEpA34ygiy6lOS607ZnY/K/jaKcrMLroz1k9vQdxnwV6HAupVS+XiJCDYrBzX3zItJ5el6MR8weYWnUPJk9aphjF8SaHd+ru68hPchc/TJ7swXQaW5Ha3rYU1Th5QbkMMOXm+eBDtiWJ0jazr4WDwxAnQLhtofY/oj1m1pwDwtD3YraN/GqpnSoaBKLF2xYympjdgD+nXsoL8zZmEznFFl4obBK5+xZzWS3+a74w/g4MNxZqOkIGLaTM+HLPI+LhyQEKd+u+rnjEe9JhfGeT+tdLvu7W/0fvnJJdYgggITejDnzqi1fCESVmwd119n35XrzuzmBlw45WW898lEVk9VjU55OK53fPq+dy4IWxQkWBwjSndj2Z+2vH53f23tqc/beXZI7P/9R7cOMt/vBFJ6ns3mYL7pwU5AfySOfHtC+Z7VzyX9KCqY3PzDhrPiuAy0zwf3IL1SotGLYHq65HvdMLM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92a11f6a-b6ca-4cc8-1ef6-08dccc0792e8
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 11:00:08.4174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pCTadbMz0C+KhXVOEjJA4y9o6i/j1TuN23W0YA8PnVMa/rRgcG8TLNJaRvixjU3E8KfMyB1hWd/LV0RoujEIU5Kj+aizvL4u66DZF/ZjoDQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5682
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-02_06,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2409030088
X-Proofpoint-ORIG-GUID: ip_GOM_EkLN5fLYZ4dgAkNHFJjTch7bl
X-Proofpoint-GUID: ip_GOM_EkLN5fLYZ4dgAkNHFJjTch7bl

On Tue, Sep 03, 2024 at 11:07:38AM GMT, Pengfei Xu wrote:
> Hi Liam R. Howlett,
>
> Greetings!
>
> There is WARNING in __split_vma in next-20240902 in syzkaller fuzzing test.
> Bisected and found first bad commit:
> "
> 3483c95414f9 mm: change failure of MAP_FIXED to restoring the gap on failure
> "
> It's same as below patch.
> After reverted the above commit on top of next-20240902, this issue was gone.
>
> All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/240903_092137___split_vma
> Syzkaller repro code: https://github.com/xupengfe/syzkaller_logs/blob/main/240903_092137___split_vma/repro.c
> Syzkaller repro syscall steps: https://github.com/xupengfe/syzkaller_logs/blob/main/240903_092137___split_vma/repro.prog
> Syzkaller report: https://github.com/xupengfe/syzkaller_logs/blob/main/240903_092137___split_vma/repro.report
> Kconfig(make olddefconfig): https://github.com/xupengfe/syzkaller_logs/blob/main/240903_092137___split_vma/kconfig_origin
> Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/240903_092137___split_vma/bisect_info.log
> bzImage: https://github.com/xupengfe/syzkaller_logs/raw/main/240903_092137___split_vma/bzImage_ecc768a84f0b8e631986f9ade3118fa37852fef0.tar.gz
> Issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/240903_092137___split_vma/ecc768a84f0b8e631986f9ade3118fa37852fef0_dmesg.log
>
> And "KASAN: slab-use-after-free Read in acct_collect" also pointed to the
> same commit, all detailed info:
> https://github.com/xupengfe/syzkaller_logs/tree/main/240903_090000_acct_collect
>
> "

Thanks for the report! Looking into it.

> [   19.953726] cgroup: Unknown subsys name 'net'
> [   20.045121] cgroup: Unknown subsys name 'rlimit'
> [   20.138332] ------------[ cut here ]------------
> [   20.138634] WARNING: CPU: 1 PID: 732 at include/linux/maple_tree.h:733 __split_vma+0x4d7/0x1020
> [   20.139075] Modules linked in:
> [   20.139245] CPU: 1 UID: 0 PID: 732 Comm: repro Not tainted 6.11.0-rc6-next-20240902-ecc768a84f0b #1
> [   20.139779] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [   20.140337] RIP: 0010:__split_vma+0x4d7/0x1020
> [   20.140572] Code: 89 ee 48 8b 40 10 48 89 c7 48 89 85 00 ff ff ff e8 8e 61 a7 ff 48 8b 85 00 ff ff ff 4c 39 e8 0f 83 ea fd ff ff e8 b9 5e a7 ff <0f> 0b e9 de fd ff ff 48 8b 85 30 ff ff ff 48 83 c0 10 48 89 85 18
> [   20.141476] RSP: 0018:ffff8880217379a0 EFLAGS: 00010293
> [   20.141749] RAX: 0000000000000000 RBX: ffff8880132351e0 RCX: ffffffff81bf6117
> [   20.142106] RDX: ffff888012c30000 RSI: ffffffff81bf6187 RDI: 0000000000000006
> [   20.142457] RBP: ffff888021737aa0 R08: 0000000000000001 R09: ffffed100263d3cd
> [   20.142814] R10: 0000000020ff9000 R11: 0000000000000001 R12: ffff888021737e40
> [   20.143173] R13: 0000000020ff9000 R14: 0000000020ffc000 R15: ffff888013235d20
> [   20.143529] FS:  00007eff937f9740(0000) GS:ffff88806c500000(0000) knlGS:0000000000000000
> [   20.144308] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   20.144600] CR2: 0000000020000040 CR3: 000000001f464003 CR4: 0000000000770ef0
> [   20.144958] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   20.145313] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
> [   20.145665] PKRU: 55555554
> [   20.145809] Call Trace:
> [   20.145940]  <TASK>
> [   20.146056]  ? show_regs+0x6d/0x80
> [   20.146247]  ? __warn+0xf3/0x380
> [   20.146431]  ? report_bug+0x25e/0x4b0
> [   20.146650]  ? __split_vma+0x4d7/0x1020

Have repro'd locally. This is, unsurprisingly, on this line (even if trace above
doesn't decode to it unfortunately):

	vma_iter_config(vmi, new->vm_start, new->vm_end);

The VMA in question spans 0x20ff9000, 0x21000000 so is 7 pages in size.

At the point of invoking vma_iter_config(), the vma iterator points at
0x20ff9001, but we try to position it to 0x20ff9000.

It seems the issue is that in do_vmi_munmap(), after vma_find() is called, we
find a VMA at 0x20ff9000, but the VMI is positioned to 0x20ff9001...!

Perhaps maple tree corruption in a previous call somehow?


I can interestingly only repro this if I clear the qemu image each time, I'm
guessing this is somehow tied to the instantiation of the cgroup setup or such?

Am continuing the investigation.


> [   20.146864]  ? report_bug+0x2cb/0x4b0
> [   20.147070]  ? __split_vma+0x4d7/0x1020
> [   20.147281]  ? __split_vma+0x4d8/0x1020
> [   20.147492]  ? handle_bug+0xf1/0x190
> [   20.147756]  ? exc_invalid_op+0x3c/0x80
> [   20.147971]  ? asm_exc_invalid_op+0x1f/0x30
> [   20.148208]  ? __split_vma+0x467/0x1020
> [   20.148417]  ? __split_vma+0x4d7/0x1020
> [   20.148628]  ? __split_vma+0x4d7/0x1020
> [   20.148845]  ? __pfx___split_vma+0x10/0x10
> [   20.149068]  ? __kasan_check_read+0x15/0x20
> [   20.149300]  ? mark_lock.part.0+0xf3/0x17b0
> [   20.149535]  ? __kasan_check_read+0x15/0x20
> [   20.149769]  vms_gather_munmap_vmas+0x178/0xf70
> [   20.150024]  do_vmi_align_munmap+0x26e/0x640
> [   20.150257]  ? __pfx___lock_acquire+0x10/0x10
> [   20.150500]  ? __pfx_do_vmi_align_munmap+0x10/0x10
> [   20.150758]  ? __this_cpu_preempt_check+0x21/0x30
> [   20.151018]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
> [   20.151308]  ? mtree_range_walk+0x728/0xb70
> [   20.151602]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
> [   20.151891]  ? mas_walk+0x6a7/0x8b0
> [   20.152096]  do_vmi_munmap+0x202/0x400
> [   20.152307]  __vm_munmap+0x182/0x380
> [   20.152509]  ? __pfx___vm_munmap+0x10/0x10
> [   20.152729]  ? seqcount_lockdep_reader_access.constprop.0+0xb4/0xd0
> [   20.153061]  ? lockdep_hardirqs_on+0x89/0x110
> [   20.153299]  ? trace_hardirqs_on+0x51/0x60
> [   20.153533]  ? __audit_syscall_entry+0x39c/0x500
> [   20.153790]  __x64_sys_munmap+0x62/0x90
> [   20.154001]  x64_sys_call+0x198f/0x2140
> [   20.154212]  do_syscall_64+0x6d/0x140
> [   20.154414]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   20.154683] RIP: 0033:0x7eff9343ee5d
> [   20.154885] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 93 af 1b 00 f7 d8 64 89 01 48
> [   20.155872] RSP: 002b:00007ffe28711628 EFLAGS: 00000206 ORIG_RAX: 000000000000000b
> [   20.156267] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007eff9343ee5d
> [   20.156635] RDX: ffffffffffffff80 RSI: 0000000000001000 RDI: 0000000020ffc000
> [   20.157002] RBP: 00007ffe28711640 R08: 0000000000000000 R09: 00007ffe28711640
> [   20.157369] R10: 0000000000000003 R11: 0000000000000206 R12: 00007ffe287117d8
> [   20.157737] R13: 00000000004027cc R14: 0000000000404e08 R15: 00007eff93844000
> [   20.158122]  </TASK>
> [   20.158245] irq event stamp: 2019
> [   20.158426] hardirqs last  enabled at (2027): [<ffffffff814629e4>] console_unlock+0x224/0x240
> [   20.158869] hardirqs last disabled at (2034): [<ffffffff814629c9>] console_unlock+0x209/0x240
> [   20.159306] softirqs last  enabled at (1954): [<ffffffff81289969>] __irq_exit_rcu+0xa9/0x120
> [   20.159797] softirqs last disabled at (2051): [<ffffffff81289969>] __irq_exit_rcu+0xa9/0x120
> [   20.160233] ---[ end trace 0000000000000000 ]---
> "
>
> I hope it's helpful.
>
> Thanks!
>
> ---
>
> If you don't need the following environment to reproduce the problem or if you
> already have one reproduced environment, please ignore the following information.
>
> How to reproduce:
> git clone https://gitlab.com/xupengfe/repro_vm_env.git
> cd repro_vm_env
> tar -xvf repro_vm_env.tar.gz
> cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
>   // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
>   // You could change the bzImage_xxx as you want
>   // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
> You could use below command to log in, there is no password for root.
> ssh -p 10023 root@localhost
>
> After login vm(virtual machine) successfully, you could transfer reproduced
> binary to the vm by below way, and reproduce the problem in vm:
> gcc -pthread -o repro repro.c
> scp -P 10023 repro root@localhost:/root/
>
> Get the bzImage for target kernel:
> Please use target kconfig and copy it to kernel_src/.config
> make olddefconfig
> make -jx bzImage           //x should equal or less than cpu num your pc has
>
> Fill the bzImage file into above start3.sh to load the target kernel in vm.
>
> Tips:
> If you already have qemu-system-x86_64, please ignore below info.
> If you want to install qemu v7.1.0 version:
> git clone https://github.com/qemu/qemu.git
> cd qemu
> git checkout -f v7.1.0
> mkdir build
> cd build
> yum install -y ninja-build.x86_64
> yum -y install libslirp-devel.x86_64
> ../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
> make
> make install
>
> Best Regards,
> Thanks!
>
>
> On 2024-08-30 at 00:00:55 -0400, Liam R. Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >
> > Prior to call_mmap(), the vmas that will be replaced need to clear the
> > way for what may happen in the call_mmap().  This clean up work includes
> > clearing the ptes and calling the close() vm_ops.  Some users do more
> > setup than can be restored by calling the vm_ops open() function.  It is
> > safer to store the gap in the vma tree in these cases.
> >
> > That is to say that the failure scenario that existed before the
> > MAP_FIXED gap exposure is restored as it is safer than trying to undo a
> > partial mapping.
> >
> > Since abort_munmap_vmas() is only reattaching vmas with this change, the
> > function is renamed to reattach_vmas().
> >
> > There is also a secondary failure that may occur if there is not enough
> > memory to store the gap.  In this case, the vmas are reattached and
> > resources freed.  If the system cannot complete the call_mmap() and
> > fails to allocate with GFP_KERNEL, then the system will print a warning
> > about the failure.
> >
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >  mm/mmap.c |  3 +--
> >  mm/vma.c  |  4 +--
> >  mm/vma.h  | 80 ++++++++++++++++++++++++++++++++++++++++---------------
> >  3 files changed, 61 insertions(+), 26 deletions(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 405e0432c78e..e1e5c78b6c3c 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -1623,8 +1623,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  		vm_unacct_memory(charged);
> >
> >  abort_munmap:
> > -	if (vms.nr_pages)
> > -		abort_munmap_vmas(&mas_detach, vms.closed_vm_ops);
> > +	vms_abort_munmap_vmas(&vms, &mas_detach);
> >  gather_failed:
> >  	validate_mm(mm);
> >  	return error;
> > diff --git a/mm/vma.c b/mm/vma.c
> > index 648c58da8ad4..d2d71d659d1e 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> > @@ -878,7 +878,7 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
> >  munmap_gather_failed:
> >  end_split_failed:
> >  modify_vma_failed:
> > -	abort_munmap_vmas(mas_detach, /* closed = */ false);
> > +	reattach_vmas(mas_detach);
> >  start_split_failed:
> >  map_count_exceeded:
> >  	return error;
> > @@ -923,7 +923,7 @@ int do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
> >  	return 0;
> >
> >  clear_tree_failed:
> > -	abort_munmap_vmas(&mas_detach, /* closed = */ false);
> > +	reattach_vmas(&mas_detach);
> >  gather_failed:
> >  	validate_mm(mm);
> >  	return error;
> > diff --git a/mm/vma.h b/mm/vma.h
> > index 64b44f5a0a11..b2306d13d456 100644
> > --- a/mm/vma.h
> > +++ b/mm/vma.h
> > @@ -82,6 +82,22 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
> >  int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
> >  	       unsigned long start, unsigned long end, pgoff_t pgoff);
> >
> > +static inline int vma_iter_store_gfp(struct vma_iterator *vmi,
> > +			struct vm_area_struct *vma, gfp_t gfp)
> > +
> > +{
> > +	if (vmi->mas.status != ma_start &&
> > +	    ((vmi->mas.index > vma->vm_start) || (vmi->mas.last < vma->vm_start)))
> > +		vma_iter_invalidate(vmi);
> > +
> > +	__mas_set_range(&vmi->mas, vma->vm_start, vma->vm_end - 1);
> > +	mas_store_gfp(&vmi->mas, vma, gfp);
> > +	if (unlikely(mas_is_err(&vmi->mas)))
> > +		return -ENOMEM;
> > +
> > +	return 0;
> > +}
> > +
> >  #ifdef CONFIG_MMU
> >  /*
> >   * init_vma_munmap() - Initializer wrapper for vma_munmap_struct
> > @@ -129,24 +145,60 @@ void vms_clean_up_area(struct vma_munmap_struct *vms,
> >  		struct ma_state *mas_detach, bool mm_wr_locked);
> >
> >  /*
> > - * abort_munmap_vmas - Undo any munmap work and free resources
> > + * reattach_vmas() - Undo any munmap work and free resources
> > + * @mas_detach: The maple state with the detached maple tree
> >   *
> >   * Reattach any detached vmas and free up the maple tree used to track the vmas.
> >   */
> > -static inline void abort_munmap_vmas(struct ma_state *mas_detach, bool closed)
> > +static inline void reattach_vmas(struct ma_state *mas_detach)
> >  {
> >  	struct vm_area_struct *vma;
> >
> >  	mas_set(mas_detach, 0);
> > -	mas_for_each(mas_detach, vma, ULONG_MAX) {
> > +	mas_for_each(mas_detach, vma, ULONG_MAX)
> >  		vma_mark_detached(vma, false);
> > -		if (closed && vma->vm_ops && vma->vm_ops->open)
> > -			vma->vm_ops->open(vma);
> > -	}
> >
> >  	__mt_destroy(mas_detach->tree);
> >  }
> >
> > +/*
> > + * vms_abort_munmap_vmas() - Undo as much as possible from an aborted munmap()
> > + * operation.
> > + * @vms: The vma unmap structure
> > + * @mas_detach: The maple state with the detached maple tree
> > + *
> > + * Reattach any detached vmas, free up the maple tree used to track the vmas.
> > + * If that's not possible because the ptes are cleared (and vm_ops->closed() may
> > + * have been called), then a NULL is written over the vmas and the vmas are
> > + * removed (munmap() completed).
> > + */
> > +static inline void vms_abort_munmap_vmas(struct vma_munmap_struct *vms,
> > +		struct ma_state *mas_detach)
> > +{
> > +	struct ma_state *mas = &vms->vmi->mas;
> > +	if (!vms->nr_pages)
> > +		return;
> > +
> > +	if (vms->clear_ptes)
> > +		return reattach_vmas(mas_detach);
> > +
> > +	/*
> > +	 * Aborting cannot just call the vm_ops open() because they are often
> > +	 * not symmetrical and state data has been lost.  Resort to the old
> > +	 * failure method of leaving a gap where the MAP_FIXED mapping failed.
> > +	 */
> > +	mas_set_range(mas, vms->start, vms->end);
> > +	if (unlikely(mas_store_gfp(mas, NULL, GFP_KERNEL))) {
> > +		pr_warn_once("%s: (%d) Unable to abort munmap() operation\n",
> > +			     current->comm, current->pid);
> > +		/* Leaving vmas detached and in-tree may hamper recovery */
> > +		reattach_vmas(mas_detach);
> > +	} else {
> > +		/* Clean up the insertion of the unfortunate gap */
> > +		vms_complete_munmap_vmas(vms, mas_detach);
> > +	}
> > +}
> > +
> >  int
> >  do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
> >  		    struct mm_struct *mm, unsigned long start,
> > @@ -299,22 +351,6 @@ static inline struct vm_area_struct *vma_prev_limit(struct vma_iterator *vmi,
> >  	return mas_prev(&vmi->mas, min);
> >  }
> >
> > -static inline int vma_iter_store_gfp(struct vma_iterator *vmi,
> > -			struct vm_area_struct *vma, gfp_t gfp)
> > -{
> > -	if (vmi->mas.status != ma_start &&
> > -	    ((vmi->mas.index > vma->vm_start) || (vmi->mas.last < vma->vm_start)))
> > -		vma_iter_invalidate(vmi);
> > -
> > -	__mas_set_range(&vmi->mas, vma->vm_start, vma->vm_end - 1);
> > -	mas_store_gfp(&vmi->mas, vma, gfp);
> > -	if (unlikely(mas_is_err(&vmi->mas)))
> > -		return -ENOMEM;
> > -
> > -	return 0;
> > -}
> > -
> > -
> >  /*
> >   * These three helpers classifies VMAs for virtual memory accounting.
> >   */
> > --
> > 2.43.0
> >

