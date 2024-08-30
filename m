Return-Path: <linux-kernel+bounces-309305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3BB9668B8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 20:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BAF0B232C9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 18:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A981BB68E;
	Fri, 30 Aug 2024 18:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kqMYa2W5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="d6gbJQj3"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CE11BD4FC
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 18:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725041464; cv=fail; b=eDLxz44hYEiM+LNH9k1tLwzW9bjkWop8w088WZMW1NSWXDOTp2OFH4/xIhu3jR0dh5jGJWMTKddhXf3nQMAsEzlUz50HSAT25vPOn06XZFQXsnmaSsDyZ5wSzrZIwn2dU/RhUGMfY3Lm3F3AqxwdcE24WA7QRiWC7kDSu4DvNjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725041464; c=relaxed/simple;
	bh=vjjctfwfCJtPNNLJod9P8dBL5bFXfshxTevHLyZcMps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P5xmmuZV1PTU6n9CE4nKRRer5xO+2h1qUUaV9bvQ57Kurzpmbb024wdpnyavw7DaVbHKdLPpyfCaVOvSAJC1n4tzLbPdeyH8gGp4O5/lm0fuRD9lqqNVb7nfkWP74igkUIbb7GKfwEBEg2tPbYNSIAFYLU0t4yJ4L95HoUpD8zc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kqMYa2W5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=d6gbJQj3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47UI38SE025963;
	Fri, 30 Aug 2024 18:10:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=J8hckl4Wu0Ypk6qGDIVUaB6ue/jw9iZMFOoFOXoGFAY=; b=
	kqMYa2W5FWFkBfU+S2KmAKrZjJzJEjHx7knwDoxlK5gVov5TViN7AKMoo2/kyLa0
	cOzKz21iI3F6RMF4SeAmYZLGvb+BPnSK8Vle1IAzMunpO08eF5nYrJ9UzJLEJUjX
	xa/gtgwv90MH/V73P3ZJbCUuYc2YnZHmRHo5FrpJr5anKFIllodnP2FBfXQB3mVw
	Rr85r3ZMxsC5zb/S1vOwGU/8pCw9poaCJDR4yoEVYuGklZuG6yLCHdfsW+LMA8Bj
	WoNOHKfFwFD7KcMpFyQ1dRHDEMQ8LkqCvnN1ll9vrEZ/uccYuMBoe71ThG6/xqbY
	VQmkNJzt8oRuKD9vRti2vA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pugycbg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 18:10:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47UHG8rr032483;
	Fri, 30 Aug 2024 18:10:51 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 418a0ycd8y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 18:10:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IW1f5PBpME7U+MHqCUFdPCB1rJJpszvQK/NRjjm+HUrIwvYRgo+iICpE+ajwEYl4r8d15eEN1v3ytLN6iEgwpBPpC2+wyEqMf0SIKvBwxhu81VMWV6RphhLcKxDW51e01n331luJFFL149Judh1ymkNcOJsGd5ie6b/YHpHsMoLAAuRz6Y1Hy4pEbu0lBug+zYVRldHNmSPVoxM74nqwQKn/gr4jdEMiMaee5DhtGcHVpD1p2kUC8dYJmKN/QXX2cCTQ84CYcZMKuNz6iuuKh5ZSjXcwwibzq1N8PkeDgyU7kM5qEb3l8l4BGdHn9G1+oC5ZQFBh2Fp71UWU/dydJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8hckl4Wu0Ypk6qGDIVUaB6ue/jw9iZMFOoFOXoGFAY=;
 b=XDKy/9bzR3MiHn+KTLmNvP6nqrNCduyA3VAxG+SOaMJJqpHhLm8XDwg1ZxMI30W3UPwq9JmInI9NxsYm5sl0ViYIujaLXQ89ghX7yA2Klovg1P7Dargo379NTO93bqVw7Uil5lMt4z6asDiFgTix328PqqbXSYgiKIsobFzkkGm5EAKPmI5P5NT8jArZjDyH+mzF0Hv/F+YNXPrc45/H7zocYU43tw7fa20N0g2ddrW7iyRvXZN3M/L9d5JS6gLMzjTruy27vfp6TncjlxWxtkRlNnCsjxZMJRIuiBUOlDjO4e2EZl8iviFLElzs5oOXutAusf2JjnfFTFe3sOq9XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8hckl4Wu0Ypk6qGDIVUaB6ue/jw9iZMFOoFOXoGFAY=;
 b=d6gbJQj3YerLF8ueNuXVxjHns7i8He+0pOtCUZt+OgySjjdLtvl/J3MwppGBk1drs1ycfx2KZ/yjvnqU0xVRqdjJhzSwMLFzVd/5ncB/NwRgC2xgsOtY93XtbqooyFYYb18zTUym3NLux10XVzVJ9q0ckBLZ/SZLMm2LGp4uMqs=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DS0PR10MB7151.namprd10.prod.outlook.com (2603:10b6:8:dd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 18:10:48 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 18:10:48 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 07/10] mm: make vma_prepare() and friends static and internal to vma.c
Date: Fri, 30 Aug 2024 19:10:19 +0100
Message-ID: <7f7f1c34ce10405a6aab2714c505af3cf41b7851.1725040657.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1725040657.git.lorenzo.stoakes@oracle.com>
References: <cover.1725040657.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0176.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::19) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DS0PR10MB7151:EE_
X-MS-Office365-Filtering-Correlation-Id: a196d5e8-95f0-4744-67c7-08dcc91f1332
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R5JeSviPSa/FM3P6QZHdoEAnD4H1vLCpog0LPPpVREu9kQR001z9T0e1wHMf?=
 =?us-ascii?Q?1A7lARNSEFCIIMQ+mWMBw7rTWWo0HJXVEs8F8IVVlv8sAplZ5rBolZI+Gou5?=
 =?us-ascii?Q?VZEtT6gYzchJbG+dHDyTVK87X2yDzsuksHaosA1CdUGV6YS+A5DfKyW9c+KC?=
 =?us-ascii?Q?xe5OaA3wkgjM5nnwDSJPAOcmue6gOytd6pzFly2gI7klnHtoCt1Qd45Qy78O?=
 =?us-ascii?Q?I/F5d6Dw/N7n7NrxOqSRIS+5kilcyc7pyLXJQMO6n7JBtrganMhNsfYcO7hn?=
 =?us-ascii?Q?+1aiksA2xfPoKwtArCzntLvQG7xEfQyvNbhwTzjX1z7u9Y0JEGfEX2WduC1I?=
 =?us-ascii?Q?JFhlPjxtOF3+KMS4yYOur013JBKEH/p1W+tl6GTfNR4oqUeuLkJ51sEnDyoE?=
 =?us-ascii?Q?lI6NoYrcoKZCysXJ33Rf/iZc/JgvPFYpqIDZ7ISbUQP4xyutI6dnKX1dwKsT?=
 =?us-ascii?Q?Hou5ToiHHrziPD3MOYuxKIrJDIeof1hlj3SP1ibCRXy4Emm6cT91+vFncSER?=
 =?us-ascii?Q?Ky0rgB5WANTgeR+iQlDSMc/uvU9q1CwGqK3NwIojCyXWSao54gKGU3Grmi0a?=
 =?us-ascii?Q?G2JD/kL6uR8Hv8F4O8lBv/9oLTMJHW8DoDow7+4jocos9XxL7EeWMrL20D0z?=
 =?us-ascii?Q?NWQTqY+ZUi/c1m5jFiFqrsJhri8tmyb3xixpWvy1i1JPNsBmE0waTo5D9kof?=
 =?us-ascii?Q?alWKHRavr6dgLyeSnZ46eK5vUsyvhvHZdtIHFXVDej+AOBwTlwJ5rcPAwYig?=
 =?us-ascii?Q?LqfNkMeURlyCVyJ9Zeq2qPo99SWAEIx/RqEzjAIYOyqgLEMaCU5SO1H7+qGF?=
 =?us-ascii?Q?PM/si3d5M8v4YroG2Z3rImeL6F+twHwb6eI+Se+KmZEFtVjYfrYZI0hTI7Py?=
 =?us-ascii?Q?18Yiqzw/G+3xstdYkQMTMLb20yFiSgy16S644xXdMPh6i3Abe688ECtDGwrq?=
 =?us-ascii?Q?2rYeOt05c92TTJUQ90bnOW0uxXjbs8w3UCjUHxNWF/cSpO24MCqzn+ShU7Xc?=
 =?us-ascii?Q?7gTKJiP/EBlduStFe2ehLmht08g4Ki5RtmhSx7CGIEAOcrlnfdP+50xw44RF?=
 =?us-ascii?Q?vklQMWlw2JwbnfxDIHVejWGFOnZ26N6SIL6Stj/PRaEgCxMqre0RYrbDs9L2?=
 =?us-ascii?Q?c9a6FLljcppFtXMLAejhZNE+AYCaDHZFHOPDjfNQfT/IE4Ib7J+NnPuvy6Y4?=
 =?us-ascii?Q?ptV0OIWnk8nW9Tj8WpmfUI2fs7/F8yG/8DAaDowsX7n/kOuLmvXeTZeFxTP/?=
 =?us-ascii?Q?Ji1uvYjn0Q6T6bRU3T8UwmmjC91pghmH1s54jQxBSye3eiunkg5y6X5CXnu7?=
 =?us-ascii?Q?mOCfFK6LRR3vnij+IOqBzbFh6IFOM8kKjU/RsCZNSH1BIg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IdEPWPalt+NR/0o2zn6pkuc0hGT7x3eiU1dvZ465VJnNC71VufJoKbLGsL/K?=
 =?us-ascii?Q?F+d7iv1hR7lWc0aOsec2rzWnxgXlNx6GNPmwGX3RPTJbH0SRRjmugTT16KEM?=
 =?us-ascii?Q?LkNBZhDheHw53LX7N/KFekfxMOTiQaLUdbfekQqQo7A20AoFkx5PbF2+lDSB?=
 =?us-ascii?Q?CnrceOX48+fCRCuH8kCD7doVQKZMsKZiQ7+TQL6bXHobb7/lSfp+DQ9aEBWw?=
 =?us-ascii?Q?C5T9ONYwPU50zYhKPjdWCDXzUIkxXSdZbFEGc4MkLNETT5RcgILFwrmBUfOG?=
 =?us-ascii?Q?tWMZSFg6pImNuvYh6cirRfmAXK6y+6BhCswfYLvzk7UMi7IcNDZT4TATDpyF?=
 =?us-ascii?Q?U5OTX8yKzjwhjvQq2zlp3dT3fJKRvmFNyk4LtcG/PlPvGY+1ss85/mOlq2Gv?=
 =?us-ascii?Q?uM5WggleEni/GvViI8GkchYG8sg6PDd5jatwj4GpXDPll8NYEA8MsrQqhe/c?=
 =?us-ascii?Q?MIiBdFGxHLxt7coEAAqVTOIIsZItONC9HZnEI9TizR7UjpHkUVxrvVCCO76n?=
 =?us-ascii?Q?04rlZ8eb27zc7upZKa815vFlsMShf1fwcrwntXwjOthPdOJPPcOMqra7OBeW?=
 =?us-ascii?Q?aAeCS4bLIRw4fAeJ9n6cXCSGF92r8m9UWgte/zGDX8Fz0NCEamlWG1EorYSg?=
 =?us-ascii?Q?B2t8+N7yjdSguKhqXpe03IOhgjRkTuUyHGC7MwmFJydyN/HEGuH7lBj9aXII?=
 =?us-ascii?Q?o3arEwJVPV7RgcRy5EPTVBmZeYlQbFUkALP7D50Itzli9FV0oJYk/L56texB?=
 =?us-ascii?Q?z8teDbf2qOG7l82tZMuhoLl8KKFlVHJXnmrT7bAMCevTg55J27E58l44N+K2?=
 =?us-ascii?Q?KeQkE57/Qfeo8qMRF42YU77ufiiTy+swduLhfH+E8WP9wC6KeY+U7iUcjz09?=
 =?us-ascii?Q?8oiBByz+MHfFnED3TqRjZPrFayK/FpSt4ZNP35Sje2DfycJc+323cNSBvrD5?=
 =?us-ascii?Q?PSatqn1MwdtbD4kTWuLJzIJx+hm4RnwXXJnkrsi/rx3EObpEDVDnC91tXP6d?=
 =?us-ascii?Q?sZDCpx7f5WGnoyq6jIFNxDVv4qBXLeVD6F3fA2PuljmwbN3zcyvWmpLymY1o?=
 =?us-ascii?Q?feup3L1OP3mFp+Xt/X8k9rspHR8voyov8yq8W7l1ZzW/c5gTs+F3iVHRV6+2?=
 =?us-ascii?Q?aKoCc/xEVkq8LSXgATIIAXUt3xiSBEOnkpLgcI1T3v8pJbQeCW/q6Ry9msIg?=
 =?us-ascii?Q?03Vuhw732oSUT/wUJy9dMUFDpmddrDSElr3PDn90ixKPg+V2ui8OhsDjYdBX?=
 =?us-ascii?Q?ki6OTGx6UcYmI0ioyhW6YAzOxbyMPrhrojaiBKNaB7ee7ET87J7znWEXJJpL?=
 =?us-ascii?Q?jTKBe61AKhh1zp+MWDbqE6Y2sZ9uR3UjuMInn29mO4gBYOXASKtaneEkUugV?=
 =?us-ascii?Q?IPUq6YOSntUJOiRPtg8fmH//8zPDb2PCKV9ZsAGZWmLnrUJ67yiQHsI918ZO?=
 =?us-ascii?Q?synccZ0iBbF9S5aBUneBsk5j2RXwynXd5inbUPow3a21ePGFXrjvwHUmuorR?=
 =?us-ascii?Q?zRtG9f3eJEiDLwIcwefycNCp4VH4HPdkm1d484u3qIcA6hWBvDOOH15Oh6H/?=
 =?us-ascii?Q?bLg95I9aTGCwF8K15AOYWw9zP2hd42ZtX1WB9Xx/uP3Q4m/qZX1iXPCbgOw4?=
 =?us-ascii?Q?Fg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	e2LZHohcBLXnED4+dG/bcBn+xzRIVtC4jOUieyiVbhOodAiKpwMq35FwINUnciVwxzYXjNGcZfUSt2z1hekJGRaxMKU8kfzwQhHvb0pDVqKUdP/Ub1HGAllqeL6kX58n8g82ShB0+RnUzDhIW5aNS/BtVUxmPme+V2kNkSqzGRwjF5/ly1+TCFBMjKaYHw5b67rwecj5cx2qVzYuEevySLrICEIPPgscNRqZLUJC/4P9w8H+cqkh7AG0WdPZSUik7L7dKmdjKQHHu8PLGdPs0jSlUbWKkl9OSMJCP8ekBBs9Jn/ieoDwUqE46YhZDiCuiP97YCkuhBk5efyJwFTtpnfRAbaMpxNYcAASxkHmnywp0es31R8v25CBBTjUpUUVKexYa2fXePNqsCHWu6SmLNQnC/CAwgVmq5Zv972aDvgcLa+ZCudrghE5x9An2y4zftD9h9Qzac3elISLpxqX7/+pVpgDNZlaBDN2n9kXRH5cvX/iou2/UGYy5eKB+W0aQcKuVv7EY4TIDPJnOYEuCInQlgC/LVQlKhz5MAIV4JottFP+9LSa9MsGwoR0WZSx3V0hJm0jardPNyhPFc91AUBiR5ZQqdbHujerWi0bdHM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a196d5e8-95f0-4744-67c7-08dcc91f1332
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 18:10:48.5136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cIbwI+KLzjKJphflQFG5HIV9WOj71t7FlSxFucRnoUXY/dEtafsGV4q9n5nPGd/ugRLN10oGnzcbxYZfbtBpBvRC2yMyZaJ5oFMwse2DGuQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7151
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_10,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300138
X-Proofpoint-GUID: FEZGMSR93vnXwCD2cUhFKnEQRRu42Uw8
X-Proofpoint-ORIG-GUID: FEZGMSR93vnXwCD2cUhFKnEQRRu42Uw8

Now we have abstracted merge behaviour for new VMA ranges, we are able to
render vma_prepare(), init_vma_prep(), vma_complete(),
can_vma_merge_before() and can_vma_merge_after() static and internal to
vma.c.

These are internal implementation details of kernel VMA manipulation and
merging mechanisms and thus should not be exposed. This also renders the
functions userland testable.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/vma.c | 318 +++++++++++++++++++++++++++----------------------------
 mm/vma.h |  25 -----
 2 files changed, 158 insertions(+), 185 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 749c4881fd60..eb4f32705a41 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -104,8 +104,7 @@ static void init_multi_vma_prep(struct vma_prepare *vp,
  *
  * We assume the vma may be removed as part of the merge.
  */
-bool
-can_vma_merge_before(struct vma_merge_struct *vmg)
+static bool can_vma_merge_before(struct vma_merge_struct *vmg)
 {
 	pgoff_t pglen = PHYS_PFN(vmg->end - vmg->start);
 
@@ -127,7 +126,7 @@ can_vma_merge_before(struct vma_merge_struct *vmg)
  *
  * We assume that vma is not removed as part of the merge.
  */
-bool can_vma_merge_after(struct vma_merge_struct *vmg)
+static bool can_vma_merge_after(struct vma_merge_struct *vmg)
 {
 	if (is_mergeable_vma(vmg, /* merge_next = */ false) &&
 	    is_mergeable_anon_vma(vmg->anon_vma, vmg->prev->anon_vma, vmg->prev)) {
@@ -137,6 +136,162 @@ bool can_vma_merge_after(struct vma_merge_struct *vmg)
 	return false;
 }
 
+static void __vma_link_file(struct vm_area_struct *vma,
+			    struct address_space *mapping)
+{
+	if (vma_is_shared_maywrite(vma))
+		mapping_allow_writable(mapping);
+
+	flush_dcache_mmap_lock(mapping);
+	vma_interval_tree_insert(vma, &mapping->i_mmap);
+	flush_dcache_mmap_unlock(mapping);
+}
+
+/*
+ * Requires inode->i_mapping->i_mmap_rwsem
+ */
+static void __remove_shared_vm_struct(struct vm_area_struct *vma,
+				      struct address_space *mapping)
+{
+	if (vma_is_shared_maywrite(vma))
+		mapping_unmap_writable(mapping);
+
+	flush_dcache_mmap_lock(mapping);
+	vma_interval_tree_remove(vma, &mapping->i_mmap);
+	flush_dcache_mmap_unlock(mapping);
+}
+
+/*
+ * vma_prepare() - Helper function for handling locking VMAs prior to altering
+ * @vp: The initialized vma_prepare struct
+ */
+static void vma_prepare(struct vma_prepare *vp)
+{
+	if (vp->file) {
+		uprobe_munmap(vp->vma, vp->vma->vm_start, vp->vma->vm_end);
+
+		if (vp->adj_next)
+			uprobe_munmap(vp->adj_next, vp->adj_next->vm_start,
+				      vp->adj_next->vm_end);
+
+		i_mmap_lock_write(vp->mapping);
+		if (vp->insert && vp->insert->vm_file) {
+			/*
+			 * Put into interval tree now, so instantiated pages
+			 * are visible to arm/parisc __flush_dcache_page
+			 * throughout; but we cannot insert into address
+			 * space until vma start or end is updated.
+			 */
+			__vma_link_file(vp->insert,
+					vp->insert->vm_file->f_mapping);
+		}
+	}
+
+	if (vp->anon_vma) {
+		anon_vma_lock_write(vp->anon_vma);
+		anon_vma_interval_tree_pre_update_vma(vp->vma);
+		if (vp->adj_next)
+			anon_vma_interval_tree_pre_update_vma(vp->adj_next);
+	}
+
+	if (vp->file) {
+		flush_dcache_mmap_lock(vp->mapping);
+		vma_interval_tree_remove(vp->vma, &vp->mapping->i_mmap);
+		if (vp->adj_next)
+			vma_interval_tree_remove(vp->adj_next,
+						 &vp->mapping->i_mmap);
+	}
+
+}
+
+/*
+ * vma_complete- Helper function for handling the unlocking after altering VMAs,
+ * or for inserting a VMA.
+ *
+ * @vp: The vma_prepare struct
+ * @vmi: The vma iterator
+ * @mm: The mm_struct
+ */
+static void vma_complete(struct vma_prepare *vp, struct vma_iterator *vmi,
+			 struct mm_struct *mm)
+{
+	if (vp->file) {
+		if (vp->adj_next)
+			vma_interval_tree_insert(vp->adj_next,
+						 &vp->mapping->i_mmap);
+		vma_interval_tree_insert(vp->vma, &vp->mapping->i_mmap);
+		flush_dcache_mmap_unlock(vp->mapping);
+	}
+
+	if (vp->remove && vp->file) {
+		__remove_shared_vm_struct(vp->remove, vp->mapping);
+		if (vp->remove2)
+			__remove_shared_vm_struct(vp->remove2, vp->mapping);
+	} else if (vp->insert) {
+		/*
+		 * split_vma has split insert from vma, and needs
+		 * us to insert it before dropping the locks
+		 * (it may either follow vma or precede it).
+		 */
+		vma_iter_store(vmi, vp->insert);
+		mm->map_count++;
+	}
+
+	if (vp->anon_vma) {
+		anon_vma_interval_tree_post_update_vma(vp->vma);
+		if (vp->adj_next)
+			anon_vma_interval_tree_post_update_vma(vp->adj_next);
+		anon_vma_unlock_write(vp->anon_vma);
+	}
+
+	if (vp->file) {
+		i_mmap_unlock_write(vp->mapping);
+		uprobe_mmap(vp->vma);
+
+		if (vp->adj_next)
+			uprobe_mmap(vp->adj_next);
+	}
+
+	if (vp->remove) {
+again:
+		vma_mark_detached(vp->remove, true);
+		if (vp->file) {
+			uprobe_munmap(vp->remove, vp->remove->vm_start,
+				      vp->remove->vm_end);
+			fput(vp->file);
+		}
+		if (vp->remove->anon_vma)
+			anon_vma_merge(vp->vma, vp->remove);
+		mm->map_count--;
+		mpol_put(vma_policy(vp->remove));
+		if (!vp->remove2)
+			WARN_ON_ONCE(vp->vma->vm_end < vp->remove->vm_end);
+		vm_area_free(vp->remove);
+
+		/*
+		 * In mprotect's case 6 (see comments on vma_merge),
+		 * we are removing both mid and next vmas
+		 */
+		if (vp->remove2) {
+			vp->remove = vp->remove2;
+			vp->remove2 = NULL;
+			goto again;
+		}
+	}
+	if (vp->insert && vp->file)
+		uprobe_mmap(vp->insert);
+}
+
+/*
+ * init_vma_prep() - Initializer wrapper for vma_prepare struct
+ * @vp: The vma_prepare struct
+ * @vma: The vma that will be altered once locked
+ */
+static void init_vma_prep(struct vma_prepare *vp, struct vm_area_struct *vma)
+{
+	init_multi_vma_prep(vp, vma, NULL, NULL, NULL);
+}
+
 /*
  * Can the proposed VMA be merged with the left (previous) VMA taking into
  * account the start position of the proposed range.
@@ -315,31 +470,6 @@ static int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	return __split_vma(vmi, vma, addr, new_below);
 }
 
-/*
- * init_vma_prep() - Initializer wrapper for vma_prepare struct
- * @vp: The vma_prepare struct
- * @vma: The vma that will be altered once locked
- */
-void init_vma_prep(struct vma_prepare *vp,
-		   struct vm_area_struct *vma)
-{
-	init_multi_vma_prep(vp, vma, NULL, NULL, NULL);
-}
-
-/*
- * Requires inode->i_mapping->i_mmap_rwsem
- */
-static void __remove_shared_vm_struct(struct vm_area_struct *vma,
-				      struct address_space *mapping)
-{
-	if (vma_is_shared_maywrite(vma))
-		mapping_unmap_writable(mapping);
-
-	flush_dcache_mmap_lock(mapping);
-	vma_interval_tree_remove(vma, &mapping->i_mmap);
-	flush_dcache_mmap_unlock(mapping);
-}
-
 /*
  * vma has some anon_vma assigned, and is already inserted on that
  * anon_vma's interval trees.
@@ -372,60 +502,6 @@ anon_vma_interval_tree_post_update_vma(struct vm_area_struct *vma)
 		anon_vma_interval_tree_insert(avc, &avc->anon_vma->rb_root);
 }
 
-static void __vma_link_file(struct vm_area_struct *vma,
-			    struct address_space *mapping)
-{
-	if (vma_is_shared_maywrite(vma))
-		mapping_allow_writable(mapping);
-
-	flush_dcache_mmap_lock(mapping);
-	vma_interval_tree_insert(vma, &mapping->i_mmap);
-	flush_dcache_mmap_unlock(mapping);
-}
-
-/*
- * vma_prepare() - Helper function for handling locking VMAs prior to altering
- * @vp: The initialized vma_prepare struct
- */
-void vma_prepare(struct vma_prepare *vp)
-{
-	if (vp->file) {
-		uprobe_munmap(vp->vma, vp->vma->vm_start, vp->vma->vm_end);
-
-		if (vp->adj_next)
-			uprobe_munmap(vp->adj_next, vp->adj_next->vm_start,
-				      vp->adj_next->vm_end);
-
-		i_mmap_lock_write(vp->mapping);
-		if (vp->insert && vp->insert->vm_file) {
-			/*
-			 * Put into interval tree now, so instantiated pages
-			 * are visible to arm/parisc __flush_dcache_page
-			 * throughout; but we cannot insert into address
-			 * space until vma start or end is updated.
-			 */
-			__vma_link_file(vp->insert,
-					vp->insert->vm_file->f_mapping);
-		}
-	}
-
-	if (vp->anon_vma) {
-		anon_vma_lock_write(vp->anon_vma);
-		anon_vma_interval_tree_pre_update_vma(vp->vma);
-		if (vp->adj_next)
-			anon_vma_interval_tree_pre_update_vma(vp->adj_next);
-	}
-
-	if (vp->file) {
-		flush_dcache_mmap_lock(vp->mapping);
-		vma_interval_tree_remove(vp->vma, &vp->mapping->i_mmap);
-		if (vp->adj_next)
-			vma_interval_tree_remove(vp->adj_next,
-						 &vp->mapping->i_mmap);
-	}
-
-}
-
 /*
  * dup_anon_vma() - Helper function to duplicate anon_vma
  * @dst: The destination VMA
@@ -715,84 +791,6 @@ int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	return 0;
 }
 
-/*
- * vma_complete- Helper function for handling the unlocking after altering VMAs,
- * or for inserting a VMA.
- *
- * @vp: The vma_prepare struct
- * @vmi: The vma iterator
- * @mm: The mm_struct
- */
-void vma_complete(struct vma_prepare *vp,
-		  struct vma_iterator *vmi, struct mm_struct *mm)
-{
-	if (vp->file) {
-		if (vp->adj_next)
-			vma_interval_tree_insert(vp->adj_next,
-						 &vp->mapping->i_mmap);
-		vma_interval_tree_insert(vp->vma, &vp->mapping->i_mmap);
-		flush_dcache_mmap_unlock(vp->mapping);
-	}
-
-	if (vp->remove && vp->file) {
-		__remove_shared_vm_struct(vp->remove, vp->mapping);
-		if (vp->remove2)
-			__remove_shared_vm_struct(vp->remove2, vp->mapping);
-	} else if (vp->insert) {
-		/*
-		 * split_vma has split insert from vma, and needs
-		 * us to insert it before dropping the locks
-		 * (it may either follow vma or precede it).
-		 */
-		vma_iter_store(vmi, vp->insert);
-		mm->map_count++;
-	}
-
-	if (vp->anon_vma) {
-		anon_vma_interval_tree_post_update_vma(vp->vma);
-		if (vp->adj_next)
-			anon_vma_interval_tree_post_update_vma(vp->adj_next);
-		anon_vma_unlock_write(vp->anon_vma);
-	}
-
-	if (vp->file) {
-		i_mmap_unlock_write(vp->mapping);
-		uprobe_mmap(vp->vma);
-
-		if (vp->adj_next)
-			uprobe_mmap(vp->adj_next);
-	}
-
-	if (vp->remove) {
-again:
-		vma_mark_detached(vp->remove, true);
-		if (vp->file) {
-			uprobe_munmap(vp->remove, vp->remove->vm_start,
-				      vp->remove->vm_end);
-			fput(vp->file);
-		}
-		if (vp->remove->anon_vma)
-			anon_vma_merge(vp->vma, vp->remove);
-		mm->map_count--;
-		mpol_put(vma_policy(vp->remove));
-		if (!vp->remove2)
-			WARN_ON_ONCE(vp->vma->vm_end < vp->remove->vm_end);
-		vm_area_free(vp->remove);
-
-		/*
-		 * In mprotect's case 6 (see comments on vma_merge),
-		 * we are removing both mid and next vmas
-		 */
-		if (vp->remove2) {
-			vp->remove = vp->remove2;
-			vp->remove2 = NULL;
-			goto again;
-		}
-	}
-	if (vp->insert && vp->file)
-		uprobe_mmap(vp->insert);
-}
-
 static inline void vms_clear_ptes(struct vma_munmap_struct *vms,
 		    struct ma_state *mas_detach, bool mm_wr_locked)
 {
diff --git a/mm/vma.h b/mm/vma.h
index 497bb49a318e..370d3246f147 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -132,17 +132,6 @@ void anon_vma_interval_tree_pre_update_vma(struct vm_area_struct *vma);
 /* Required for expand_downwards(). */
 void anon_vma_interval_tree_post_update_vma(struct vm_area_struct *vma);
 
-/* Required for do_brk_flags(). */
-void vma_prepare(struct vma_prepare *vp);
-
-/* Required for do_brk_flags(). */
-void init_vma_prep(struct vma_prepare *vp,
-		   struct vm_area_struct *vma);
-
-/* Required for do_brk_flags(). */
-void vma_complete(struct vma_prepare *vp,
-		  struct vma_iterator *vmi, struct mm_struct *mm);
-
 int vma_expand(struct vma_merge_struct *vmg);
 int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	       unsigned long start, unsigned long end, pgoff_t pgoff);
@@ -277,20 +266,6 @@ void remove_vma(struct vm_area_struct *vma, bool unreachable, bool closed);
 void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
 		struct vm_area_struct *prev, struct vm_area_struct *next);
 
-/*
- * Can we merge the VMA described by vmg into the following VMA vmg->next?
- *
- * Required by mmap_region().
- */
-bool can_vma_merge_before(struct vma_merge_struct *vmg);
-
-/*
- * Can we merge the VMA described by vmg into the preceding VMA vmg->prev?
- *
- * Required by mmap_region() and do_brk_flags().
- */
-bool can_vma_merge_after(struct vma_merge_struct *vmg);
-
 /* We are about to modify the VMA's flags. */
 struct vm_area_struct *vma_modify_flags(struct vma_iterator *vmi,
 		struct vm_area_struct *prev, struct vm_area_struct *vma,
-- 
2.46.0


