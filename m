Return-Path: <linux-kernel+bounces-313330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5E096A409
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 18:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C03DB1C210F4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 16:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF93418A6AC;
	Tue,  3 Sep 2024 16:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BmXmhQ+h";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qvPaEmyD"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D5B1DFCB;
	Tue,  3 Sep 2024 16:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725380210; cv=fail; b=cUTst8pAKp6C6EpqsXsIZg2QQT+v0q1DMQDrq92UAoVfR0CG29f+tPGYUVaqVweb06ARR6fmcjwpFx49+C+hpTWUoUXybhCFj9YV5jc9Sln7jfiUeaewH0WL97NqUKWvSfHM2JwTeM3cWPKNyJCcAIMFoJX0ZKdcOPXJFDNXEtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725380210; c=relaxed/simple;
	bh=k6j15Y7CR6tBmV98xboe1vQidnKqu2c0KtNYM8XsOTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UC9InCnyDmyYrfC4GWllIRzWQ2tCHFDiXkjYaeKG0MWran7isHcsMOYHRF7QGz0i1CpbFD5aifuc4/I+8TY+dKHc+0qNBlj3qN4XwnMffRGlMAlCE+xpJZAvmeJbITGWOK500g9oQ+sDCe/42uSJPbKDNOD22MM2LpQpxXL2TMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BmXmhQ+h; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qvPaEmyD; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483F0Z5B009041;
	Tue, 3 Sep 2024 16:16:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=rRkamwXoZt3APC7
	rnGcy5tySlehZ9PXYfty9H7+iCjo=; b=BmXmhQ+hqL/CRVBmMDoSOZAh9I1CLBi
	yDq/YtkyRwq4Jkj3qCEfVu4VMUDuhG24s1TxukiXE95hKaohjuW0kLw1qljCvytb
	TnVSHkIHRlBVe4CtP9mU3mc2G4ntBeEUMaaTAAtFesWyP+DjgKv/X9HOee9DyhU7
	sVuR3gkVBLWnvU0Je+T+m9sutGn47WRszlWGcvzJL1vOcPaKXQnvc5BVpyGqx+A1
	QYWYxVDFfy/UTcTX3jc+oYX6fJG48+PWWUip9yG5/JHQnPX+R5H7xL5NutrYvL3B
	8ehepAgcnLjQk3KsDWvf5O9hHfR8Gs6bWP6MlEvFLFkdJxdrOagNbcA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41duw7scn9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Sep 2024 16:16:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 483G2QuM032650;
	Tue, 3 Sep 2024 16:16:37 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2045.outbound.protection.outlook.com [104.47.74.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41bsm94ahc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Sep 2024 16:16:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zFY2uHH6XHBLN6D9hXr++P9Sezk9h6YQXQY9GWEhIpkzJc2dCcnFdt6C0sxJrCvR5Har2YiyEJpqczNUrcdjmqazQryEd1TApYzHtqe4aZ6Si2amgryO9b+aKnqWL1+zM2OCEggOInDJRiLa40UzKMosYs9i1HNH2fKalzEgSNBICEvo580o71+XrhEdJXXx98t/effJdVjCJbyJHsaN6XsLQTYXoxlI9qKrmdIcVY8gMd+sqfQnVN2BTmoLtTgXTpwPK8/w0qNhN/84mCaW6K0A7hOnZLBOMNFKNjruCey0f0t/I7F4KKMVWqxrMjH8RRSPtlzGu38f0tHkoUc/4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rRkamwXoZt3APC7rnGcy5tySlehZ9PXYfty9H7+iCjo=;
 b=ng+DeR9VgOJzGNOW87+wNhOMqZvswmBbmAdbqpwj1dst2ZcWlXspsRok2Y/uBdHc2NWc2ZVQ1Sh2zAW0ohOWcquPIxurfy476lpRkTxx02n02Oa4HrhH4x9zhiX2ipgt0GCfDlK0Ba6mRvjXARaKIwNksQhLhuqLvKGnDUtksBtwHM6fiqQHjSQrMqaKr62+IUS+Uey/kWI3tfN6sWk3xAUcWRQXtTwsuS5ZwXrU13GnRgyjBpVst/RnDG8OhmVTEqOsto5BK+RHYps5DUmvBkVjzqa9On2lUf4cJ+XduHD5yvcJAsYKV9m5K1Wuhn3ToInHlfWPeuwMzLYGNmctOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rRkamwXoZt3APC7rnGcy5tySlehZ9PXYfty9H7+iCjo=;
 b=qvPaEmyDtevcgQ+FGQ0Oq/rQvqrt08vbcx98FIopmGchsD9Lg8iUAqvf50uM7vCAuw7OY3fWYSs1JhfsOXkB06YTZpwjkhgzslb3+FEVI8U5jVJd4Wvn7BW9LIPhS/BLWbSYAAYKfIcMb3SpyWc0bwffJY2ZHLqpJA+UlZ7Lz8o=
Received: from CYXPR10MB7924.namprd10.prod.outlook.com (2603:10b6:930:e6::10)
 by CH3PR10MB7677.namprd10.prod.outlook.com (2603:10b6:610:17a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.17; Tue, 3 Sep
 2024 16:16:32 +0000
Received: from CYXPR10MB7924.namprd10.prod.outlook.com
 ([fe80::794d:6966:dd4a:f6e5]) by CYXPR10MB7924.namprd10.prod.outlook.com
 ([fe80::794d:6966:dd4a:f6e5%4]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 16:16:30 +0000
Date: Tue, 3 Sep 2024 12:16:28 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: lib/maple_tree.c:330:20: error: unused function 'mte_set_full'
Message-ID: <fxpibejx4g6tt7ow2l2qmjbd6adquukkszolqgmjvq4oo2s22e@p6wlptkl74px>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Nathan Chancellor <nathan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	kernel test robot <lkp@intel.com>, llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Linux Memory Management List <linux-mm@kvack.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
References: <202408310728.S7EE59BN-lkp@intel.com>
 <20240830175015.3569d261b0d48d46eb6ec1cf@linux-foundation.org>
 <20240831012845.GA2993938@thelio-3990X>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240831012845.GA2993938@thelio-3990X>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT3PR01CA0112.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::30) To CYXPR10MB7924.namprd10.prod.outlook.com
 (2603:10b6:930:e6::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR10MB7924:EE_|CH3PR10MB7677:EE_
X-MS-Office365-Filtering-Correlation-Id: 0783e516-32e3-4c27-b605-08dccc33c557
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VfK6VnaXdjO0KOF0zBsRUhAmtEpXPQnYmPi/xYCq0eImhVJRIh/BZeu1Acdv?=
 =?us-ascii?Q?j5Kzw0iBWSICB/6yUo/14oUhecJ0xHi/zAzzvrhf9D5er8EJGxcPoSj2arnm?=
 =?us-ascii?Q?TpotSM6Uc4UQHr0ucuOL/qvXk9jb6clZk7EvXH9zQt+JeDi7H8sora7+6gDU?=
 =?us-ascii?Q?WehNsz9zvWtPm/ORkVotYPSkOkqr7/gyDbdw4uTarIhfyc4eT+YWj9xLBpAg?=
 =?us-ascii?Q?J0YgEJN6SY1sztIbdWkz9IvXZbMqTYjwfLaK3gmDmYOAlBlUSq/Gru45Wr6R?=
 =?us-ascii?Q?mzuJyzvLLacFsHXcby0iwjr5SxWxPaFJwrelJtAdN1hG+oMtzP74nlcyX0xe?=
 =?us-ascii?Q?l9srBgok6qlefaKxYizlVdZxcdUfHOQhIzn+Gu6KBdtBXrR8WSFvcvGh7ZQT?=
 =?us-ascii?Q?9mz6WG0A8IYCTMD1XvUeUa18t6FGLwrMyHcr9EmCDyiTbWJVJDd9JxVGgyrN?=
 =?us-ascii?Q?/9nQYhbTFhIzbW/1oIMZsRxP3hS9xo2xk7/STj5ljt96FTRa/w+e6ZV/mhJQ?=
 =?us-ascii?Q?9nf+wJIrQbXUrfUHSQ8rb3NdpjimblYsOMfeGSBgtyOa54u40UVm01lXqxwJ?=
 =?us-ascii?Q?ixxLiExwACF2rNp8IgrKUBPnFe1pyL+3KCF2nytyg0GFvzUldwqunkEA5Z3D?=
 =?us-ascii?Q?keepYFEk1pIm8guYByt1vc6/CmAW3Nam5/MhIllJwSvNrfm3I10R55InfMIH?=
 =?us-ascii?Q?m1ZCifJ1iLApgVAhVM9rM7KEAuCDiFp0akTlFj69/Q/LX8hUoTOjGF8b1Lt1?=
 =?us-ascii?Q?A5BhEGMcFnh42udiAmI090G4ZBxisRBENNU8IIjYQ6Fo0rg1CtFIfkox7YuY?=
 =?us-ascii?Q?x+G1fTQhyKuoNTB5nrV748HlsObCbbUVhJUraIzyXrInuhmNVf5Lpcz4RZMo?=
 =?us-ascii?Q?5M64UfHE0WpN2SSog7xvBKxw3XF01IzMcfl3YhckWIHpPzG0r4glTnD9svYp?=
 =?us-ascii?Q?Hz94tdSEU5n0wf8+0uCfs88wjj3B+bQCJw4KJKyduJo6nlAtJlJjFV9FZ1J0?=
 =?us-ascii?Q?FkC+rUiCqOAguy2gpywYU+k3GOZYOP+Yw4euDzb6bH+jnlM5kv/Y/QNkkq5b?=
 =?us-ascii?Q?i2GNqQSxm4AI9rtRbfaC3KZWOcXEiB8X+yRyNggad4byBIMn6LIWfMUGVJZD?=
 =?us-ascii?Q?TNIeoQd+9CZYJ1k9dE+8QE4KTmc2jFOYKpXIGaSh2iHDICym8AtG1Rss9RRh?=
 =?us-ascii?Q?dqv4MwGUbTj8ltUJOKP88J+yVXRyN+vIFmszR188t98JWWoSo5sHdiY6SHtD?=
 =?us-ascii?Q?Wom4TJATtEbWmrFq55MK87DA2qEDtIbmG73kLlWt7q90fL/sxZCUuQ4P0Aq5?=
 =?us-ascii?Q?s0Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR10MB7924.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6lIed84zG0kTnVJFItWdC14JGm3J65X2iJHP1hlffva9dON6rsAUgiXBnj0/?=
 =?us-ascii?Q?aMFK+caqBUdhvB8vrUTDq85S5uY8Ef0g05uAgM7nLPHWLK02VLuFWPKB+RTI?=
 =?us-ascii?Q?p2MbzFRfGMSWYPiLh7GteDSpby0QEy2OPuCsB2mInPfmLOdUmNNOg6HPsFbV?=
 =?us-ascii?Q?cbUiorDfDBD21POt4KhxU7pvY5ely6vQyeGmAVy/w31AMcbrr1HvK0uvMSER?=
 =?us-ascii?Q?BQWY2fagq0sKdaKmGjgHef/dJV9c1s0p56xgcZGKO1q9IteZvREZQdvTCdQ+?=
 =?us-ascii?Q?hZJNwrCTIPS21T4bwvwH+0ACyX2El6s2J0LPCO/0YyyjGvnBy5upnKcfBfE1?=
 =?us-ascii?Q?NwO38sCXK/SAbHcaeQI5wjEryobZgD/ay1Jzgb0tS/Ffrpl7hz8RFNkFBLZ6?=
 =?us-ascii?Q?yAUzMc/eVBSjzBIWpPEBI1RYgtAtl5AcblxSSa0EVnIWO9DAxZLmgjSGOmPH?=
 =?us-ascii?Q?WOl960vJC/ytdeJ77lta9RnZf2OQFSL1Jq395iwZJTLM1CLWyAY7nj/U3hEM?=
 =?us-ascii?Q?147O7htw/7U7xNobuYwZ0YYYUZJEComnDLZ1s+L3vJqlzIz/w9DgUxyQvi78?=
 =?us-ascii?Q?NpsTTOPnhsDcyT2LfpeyWeldPxHPuPwLLlWcR5wX9f3VlBdv7JMdIt8zX5D+?=
 =?us-ascii?Q?oggKfDBwffk3PNhgkplebUfSgBPHI24SxD/6tqI+sO1H8yERdcouP7MBaWvm?=
 =?us-ascii?Q?ysz2+PPHVi3FFVszpN98Jy4HoYrstoqAmJOO52Cz3IKtxTcOYMtJXPpLZIzI?=
 =?us-ascii?Q?sF+PF/XytHQaqcf2Am7VcJOTIbEQEnPq/9zx+3ZZD51o16RDsEpPg7TcMjA1?=
 =?us-ascii?Q?fuzu9MKi1UsEenDVJRi6QlrFJOleuJTLq/Ld1AUSIOh0+CvaFH8fzvhJnqJx?=
 =?us-ascii?Q?vBDt+rKhaNbNOToj0oURkUyL2DiLTE/l2mYuGFy8JKprLXXetDbOIm9dPBi/?=
 =?us-ascii?Q?DrB90Awp0a+7eWiD8w/ycKpPLta0g87gEDopnMiJ7vl/42jOJrfWPq3Mumbg?=
 =?us-ascii?Q?dIJfAtRetWfU5AAet5JjXO+zYC0oqIf15hzaS3wErl5yd9DDqgmA4WdzU2Qk?=
 =?us-ascii?Q?c1zOHCbTmWiKUJ5TlyA6L+H2id7B5mGkZ4x+huV5M95I6c9aeEhx7HKhdKRP?=
 =?us-ascii?Q?//W8ik0cLYPvRX2p+plYyLVMx1ofYn2FFDIma1SQEkt4AZE1eOiee7IjyZef?=
 =?us-ascii?Q?vfMfZrtHYzYzRr4pbmQKzXOFlqip66NFk6/sdupWjZNiP4SN0Lpes0dMjyo2?=
 =?us-ascii?Q?T60bjeEatBvnQwnAEj8b4kfCHSZFO5LyMqEQ24jLH6J42JKj+xQruu4x3qC7?=
 =?us-ascii?Q?yoqUbf33OcCWxN2U4ztGNYlT2yVhhOPnb/2Xo/adZkEoIhQeApLzwONAMsJf?=
 =?us-ascii?Q?j3hEye15CXoDo4yhEXtd/MfadXXZC2p3ZrYHP8At5JROmd6HpS86FqRrO4QB?=
 =?us-ascii?Q?JapWVym9VAQvXILCX8nCyHYF1ciAjManuqC7VZCbcVGxZEbKx/u+Qzfy1DDV?=
 =?us-ascii?Q?7/ZeJvesWZNffNhTrfu1rWclaOgCoTsDsndMZpBj60yJnpsNibEO3POqLSBj?=
 =?us-ascii?Q?3Eu2sdjIr7Qz3KaFEs9gdvmhLD7cGBcsJY9XxeJA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uRgFwaz/T5U8WEaxWHptbClF7axUWRktalQ0Y3Ox5jS2kmx0frPzFZwPkMyFnF5LyaWBrWlbO8LZ+/qYPEuK94YWlyYSj2sQXSgZb2eacvqiw51TmE8sMzy+jKClNIH7xqzurWYVqUo56ed5Nb0rtVm2VUnaQe2SGpsvjdRw4KRA4nOWyMGhzhGna8WUUDt4EeyiEgSNYAVHARzI/Js1GSWu378eJF0maUB2bAmY6MRGsMzWhoXNQOXyHb0wkY/Pey/jEdbut+wgMWnb5mcgDEj+aFcZSY+u1iArDNqvRgZkzw3VxdnU+7ER2YRQNFZovTy3O6dslYFUj671/S5krcFniaUZSUMbgcqFaAGl44XFRc5+XkbvJU7NpExFZ85SNCL1y+r9xFtlAvr0C5G8+J2yg+NUZDBcvxGdPiwHE+9ZeTXMv/CDtq5NpqN04iDAVbGafEi+UNyY7AIP/t4wSAVCM2/v7cY0clo/EkHtoOWu3JsUw6j6xneTtENkRfqewUJ+2iLMGSgF0p4WxV2D8keaWOiLXcJ09utMxXs39JtK0SFuvd7exYbyN9z2nnsgFNzL1Sn2ziI6fb8xo9SdMCe+IzAWucecrJSwcUd6ne4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0783e516-32e3-4c27-b605-08dccc33c557
X-MS-Exchange-CrossTenant-AuthSource: CYXPR10MB7924.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 16:16:30.7401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mDZhrE5UXMCEWJCz9AodaXc5fdS3Rfats8+YYEclPB51yg1RH1BGd6aNp+vS8j9NqFQbXTDS0JnJ28lo5w0T5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7677
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-03_04,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=861
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2409030131
X-Proofpoint-GUID: Rp1sI3u2HRBe9-bPDAK28nM11uDSvdWR
X-Proofpoint-ORIG-GUID: Rp1sI3u2HRBe9-bPDAK28nM11uDSvdWR

* Nathan Chancellor <nathan@kernel.org> [240830 21:28]:
> On Fri, Aug 30, 2024 at 05:50:15PM -0700, Andrew Morton wrote:
> > On Sat, 31 Aug 2024 07:42:38 +0800 kernel test robot <lkp@intel.com> wrote:
> > 
> > > All errors (new ones prefixed by >>):
> > > 
> > > >> lib/maple_tree.c:330:20: error: unused function 'mte_set_full' [-Werror,-Wunused-function]
> > >      330 | static inline void mte_set_full(const struct maple_enode *node)
> > >          |                    ^~~~~~~~~~~~
> > > >> lib/maple_tree.c:335:20: error: unused function 'mte_clear_full' [-Werror,-Wunused-function]
> > >      335 | static inline void mte_clear_full(const struct maple_enode *node)
> > >          |                    ^~~~~~~~~~~~~~
> > >    2 errors generated.
> > 
> > afaict these have never been used.  It's odd that this was just detected.
> 
> I don't think it has just now been detected, as these functions have
> been flagged before:
> 
> https://lore.kernel.org/20240503160821.GB3960118@thelio-3990X/
> 
> > Should we just zap them or is there some reason to retain?
> 
> From the above thread, Liam and Matthew seem to want to retain them.
> Perhaps just wrapping them in '#if 0' and a comment that says these will
> eventually see use would be a happy compromise between outright removal
> and doing nothing about this warning?

Besides these functions being static and inline (And thus compiled out),
they are stopping people from trying to use the bit in the address -
which we have had happen.

I am still working on the code to use these on my side, although I have
been held up with other work upstream.

> 
> > --- a/lib/maple_tree.c~a
> > +++ a/lib/maple_tree.c
> > @@ -348,21 +348,6 @@ static inline void *mte_safe_root(const
> >  	return (void *)((unsigned long)node & ~MAPLE_ROOT_NODE);
> >  }
> >  
> > -static inline void *mte_set_full(const struct maple_enode *node)
> > -{
> > -	return (void *)((unsigned long)node & ~MAPLE_ENODE_NULL);
> > -}
> > -
> > -static inline void *mte_clear_full(const struct maple_enode *node)
> > -{
> > -	return (void *)((unsigned long)node | MAPLE_ENODE_NULL);
> > -}
> > -
> > -static inline bool mte_has_null(const struct maple_enode *node)
> > -{
> > -	return (unsigned long)node & MAPLE_ENODE_NULL;
> > -}
> > -
> >  static __always_inline bool ma_is_root(struct maple_node *node)
> >  {
> >  	return ((unsigned long)node->parent & MA_ROOT_PARENT);
> > _
> > 
> > 
> > 

