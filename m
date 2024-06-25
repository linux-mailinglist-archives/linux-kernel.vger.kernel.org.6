Return-Path: <linux-kernel+bounces-229573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBB49170FE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 21:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA8E728A676
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6F817DE24;
	Tue, 25 Jun 2024 19:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UBxLI7bU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="j3bwJdP0"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E46117D8BC
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 19:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719342746; cv=fail; b=bmQ7d4aOIo9ood9g5nJ7HWz+JMaxqYLqa9WYq7Aq5tM521OyQmjNvrOu9v501ZjovA2Gm2J+5O/dhM2Ni+UqCWzRxiuSEQeBJcByADhpCsGdxz2ovAqYPhf3i3gKqyXfhJslA0MpsYF+TSR5GEy7WN+f9l/k4uPyc4OVKBnQz7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719342746; c=relaxed/simple;
	bh=V4UvehlRwyVNFgxa/229XxVg9A19bIPLeQ/Fygw8sas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tMqGJTCPBfjcdj8DRKQx1KJVZXc/TqdnTEMOfYYZW3nLRJn8CLQSWl+KC5VUOunHy9JS1hjzpHKssDEdtOdtq3YzBGbl4fkYdTnuM8s8XQEAfemhFo18LsjhIsoGeXqbIKN7zKwjAMM80wId3ZTTf9ddxTtdMWhMtt2r1VVSktI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UBxLI7bU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=j3bwJdP0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PIfTnH012802;
	Tue, 25 Jun 2024 19:12:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=piltnTByFrtmgy9GlOmuLW0JbDdTYktoJ0ISndNfSNw=; b=
	UBxLI7bUcEAsyFW+Jq9cNnNP3aYY8IwswQYwtJQWKwkJPpzXMow/Vyryx1w82vse
	4ujW4T4nOxUYBAgH7/svRtmGm7j95y4iIVfrytMP2paj0PPzGYpC3BcPjnVKjnwR
	8HyrjaS+u4HJoc9dQ+3272vqY6Nk85cthRbmyUnHSu2/zhPj2MRTLMA5Xuf6XK6E
	j/F6pCfxuuxLObVRm/An1Muapy8JgsZ2gwjS0PfslQQC733DpGgu3FcY2cdpze+0
	siynMztvwb0Zv4QAQtqKrfB5PJiPJkD74YfgXM+7yor7p94U2GrTHimvDh+8ksf1
	WPf+U1VY0Atd4prv3qsjWg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywpnc9ub4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 19:12:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45PHonQi022616;
	Tue, 25 Jun 2024 19:12:09 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yxys4xa89-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 19:12:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KBviEvCxPsvuXHyws+sQvPeLWcv9udH8BcQihPhQ8wanYkMjoy6UjV8pnSvc0okpcYdpgsdBosPwdOljCx7YZD6Pm3AzBn0HbdXWFEFZc4sVdys6U0KyLEonESOkSpovJSr1EZhsvjm5AVTNJve1kNhziMm5nfal0h+dAhA+NqSK8q909iGLX0BhsDRag48Bnc7J9Yeo7V+grlTLn48UK+P1HfrKKQ9QTkntQ4vBuS0BsuEPlVJawmWb3hCx/CczZcwfVMrAwG2qXTk4F2MFtplAzrVWEEbzhPhzVISl+P1jRccH8GztN2Rj/q8y7lXZPm7xp/eBhAbeEXXMkcXzfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=piltnTByFrtmgy9GlOmuLW0JbDdTYktoJ0ISndNfSNw=;
 b=QxXzlQ/gI4uOlCMfkpjmKhCjID1756JXKlx/YEvtqBNb/tFG/RFyYB/tnSLMu0/2ePqGv9pjQ4V3jMaQ4ipF5YBItipL3Qz3rQFJvWCCzMAhcJ/IE1uLJ0ejf505gzMIgQNmd6GXN5kS6DqCBw4axfH1q9nnMce3UPryZNd3yULXZn/jTS64BvSRe+OJLXx+xdfLfGrHprNOvsIxqSTp0IPp7PFE6QF9H8I7AjapNUPzK33jfVp3Tw+c+AGMlUKl6/GrQKrjoc5JJncDebung0GnWhvxdOk7MQcwlOgm1+wjOPQDUA+QOUSaQ3GLDYVQidJr5pT7zS2lCtNNLg/T+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=piltnTByFrtmgy9GlOmuLW0JbDdTYktoJ0ISndNfSNw=;
 b=j3bwJdP0Mj5Soy0vUqIljN3Ubf3WM3QPJuUa7XoqadTCNv/B2n8ccI7Gz2dnwS8+ilGOOF3Dmr4GqPZckeziLKsA6AeB+6ptfJfsxKKHrma12gzpuwhmhWZUoqBdmKmjToMjZzz6AVaV7rq7OnYR0vACDuNj7WDd2I7ZOGb4kP8=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CO1PR10MB4707.namprd10.prod.outlook.com (2603:10b6:303:92::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 19:12:07 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%4]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 19:12:07 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 07/15] mm/mmap: Extract validate_mm() from vma_complete()
Date: Tue, 25 Jun 2024 15:11:37 -0400
Message-ID: <20240625191145.3382793-8-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240625191145.3382793-1-Liam.Howlett@oracle.com>
References: <20240625191145.3382793-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0074.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::7) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CO1PR10MB4707:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f2ee483-99f2-4bfa-815c-08dc954ab47d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|7416012|1800799022;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?bVnz0EOH576OqxSRSvRehCQGeXhbLoV1DZrXdSNXeSbhMUdJTf4hWQuvA4Nx?=
 =?us-ascii?Q?SxgzuOsdU2OscNFJ06QtVFf3sqK/F9Q+3yiC2e3Z/gZKDOcjC49Fk4B5VB77?=
 =?us-ascii?Q?Y45BeSZjpGaMGBWOpF8/4xONQf71wv8qKAFzxXzDVT1Awq/71Zb5VQXvKnTr?=
 =?us-ascii?Q?3DIoyuoGxXAF5REGT0tpg8YcAwTyRpZkVZy+bHwejFcemvb4iZ54bbUZ3WUI?=
 =?us-ascii?Q?IgvrBTkQD9FxMTSNp73c+yyxdhjMMxFc4/uTGly9RGDDIfx0U+MjTjZ7WTpS?=
 =?us-ascii?Q?PAf/fBV6akn8sQUyJ3kfsjoFEwONpjyaiob/RSYkHciM1XlAne1oJwhioIws?=
 =?us-ascii?Q?G3sPraLrxG5ZhuA2K1gOu/yKssal54bnQCcQEnBEMnOTMRx3m4ZsKjTSyw5X?=
 =?us-ascii?Q?50jorQMMWvn7NiXFOYcwh7vMTPf6eDQpyDBNCj0VgDSvFWSyuirJ59mVGA1n?=
 =?us-ascii?Q?OLnUTklTTWy9qgNd51Lq5opVMH3xwgQU0T6SSkTSp2pxEg21/wJfJPKAdtYP?=
 =?us-ascii?Q?sSVS8EGU9QEc/OxPQ9rSnBAJE7WdQHgmLkWbKKih65921bG0SqkUoEXL92sw?=
 =?us-ascii?Q?iSGYPn3GtBa3ZmFCCGf+iwH97aX8sRNVrVK/3iGICJkWQph/i6j9dWu3IJ5t?=
 =?us-ascii?Q?R6+5Sev4umiU1t7YZq65/AlEO9Gs3hWXh+tJjnc7GJCacBRgJVgjkKHXQqa4?=
 =?us-ascii?Q?/1+9OuIHrKVuj6iKD7xtX/RgC+vO0vhjgQyRPZoksS+ZS7RewS3qD7Thf5Mv?=
 =?us-ascii?Q?qWLIlKQiq7TTLxABT/bAfWpd3bTLYST24v0W3+cqqULmrEL+Q5DzHlG4YXhY?=
 =?us-ascii?Q?BiA27pVuLI9U/QbZyppknJl0PATKQig6L/u6ilDq37MlyRBs8Rxc0aGKaNWr?=
 =?us-ascii?Q?byY9ZOWSEQBWWFGI7+8cIj/iQkC45ldOS5o2HfSv2WlH0J/Pw4fgoM6d1Vzd?=
 =?us-ascii?Q?i5W/niFyPz97Fx1sLj6Q958NWaFEIJLJ5ah9stgMbYlEvTZUyeV3c6eDziaS?=
 =?us-ascii?Q?BImb77Quq0jhjK6A7Z4wpg59RZmyWz+mW9uZGcu8ns0xhNFj9raRGvRJ0t5H?=
 =?us-ascii?Q?0KJcskWwrWB9UxTNSQ5njV4VZCG88XeO9y2Pi+QdGk7VPj0K49Nzi2EczUYS?=
 =?us-ascii?Q?Ne7iDoor76glBwFjndXYzChqvZJcOsKcJJsMylgppwknM4tMTBIR5nt8U4wE?=
 =?us-ascii?Q?l09qGy8hIkkfxGkC1VjEXXnEeFZscnHFBcr4GeCiPFq+2ntWTSUUxv56ty1F?=
 =?us-ascii?Q?bCkI3jQ+Z90a4GdWyD4QGrfS4xVLJ7f7cMqzUxOD95dNuMEFKHXXJpnjE5wW?=
 =?us-ascii?Q?8/uGTAB/g3aQMNweZFSaeRhY?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(7416012)(1800799022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?xAko54osaQgQYp0inu0tSjJcqHNp+gyXWGLV8e2CLWxUw9ROF/j819zGDKZr?=
 =?us-ascii?Q?iXoB4WZqX4bRD6UxFBZvIgCcXuDhXmm940o25Nb0/Vv2FOi6JqThtQ7xLFQR?=
 =?us-ascii?Q?VdgeFVe1SyBowidIYZUyPJ9MGYFr5QEXr1j3e/tiQdLFkNYTeSf0UCCMK7Gr?=
 =?us-ascii?Q?lXn3L4f+Qq8CFqc26C+/9Luy1ZJdxsoLccBLTy2FZ/heW1GhlEa3hshZHrA3?=
 =?us-ascii?Q?Vh/o9L0FIE0A2vV1StCkKwC6ape/dPplnE+ALh9tIWrDkduEaZ5OovKCEazR?=
 =?us-ascii?Q?TvvGJysQqwI3VmGDDSl9jAXUmXRe+Ifqzj7wpz3yrzztFnxtoVkQFqQNJBo9?=
 =?us-ascii?Q?r7dqEsiMMhXhIC8Ix4AJDFW4F9qQpYn4QV7FAYerOMLTOqfaUPNFLWDXEcBh?=
 =?us-ascii?Q?BRAk4tJ6VpT8eMSBqmbhjhXCPwq5R+aLj8qkHO6KWQbDEkqDvNcHPbtyXNvi?=
 =?us-ascii?Q?qibot2/hsM9DECvZdlgHqGZ8+UwqenRSABuf0JlgslCdxSPCro96HyOWLqns?=
 =?us-ascii?Q?hkKRKg34oWqE+kvpEiyRYLAyHMh9gKIS+ZpeOIRIqXSJiFdNigEHJarFOcjQ?=
 =?us-ascii?Q?kkxOBGlOAxesI/OmplLGA/pg+xHo+kYV+bDStClvH1sFRrcwv9pnHCDUly1H?=
 =?us-ascii?Q?ahxTVm/8NL/wbs1cJUShy+XQ6dsmEiQhzLTmrF9kpEeY3xhumzuBbly9bF3R?=
 =?us-ascii?Q?JCuXoehhzdkxATtJSw4Pui+sPGFWD+EHwDy+2RVf5i4SQ3e2xnpIVuDaiR5e?=
 =?us-ascii?Q?tYLTrhi5D13CtAjVGGQ/D7X3imL5pMxu18JKIYRInfIoU2B2+cQqkcA8pwmF?=
 =?us-ascii?Q?KXa9rDYGyGxyF+GNYR+C09BLR8bpDolRPeEkMUmTIHHWxIa4Cdysr5VBonLe?=
 =?us-ascii?Q?+pf5rJCgNu2gV5X7Sc4ezBK/OYZCMVkZTcs9eiK4Wh8jC8ic3BKLTzD/JM3Q?=
 =?us-ascii?Q?p29Bd4M51Re3vhz/06V8eXVH2pL/KYSLqkRiFmSmifoQeuFcqXq6lBKsVaIc?=
 =?us-ascii?Q?d139iSDKep7b/1nvvnBPb6J4uh8kydYJj7Nk/shvANevkaLgpTaoZvvqmv3x?=
 =?us-ascii?Q?1D3KcThrRrv4deoeEYoBFMHfyY0XDvAYkhWhaRJeo/5kWAhmWpy1zgTyJ3F+?=
 =?us-ascii?Q?9fqnHyBeLFSWXrlVz/KQziTUYIORR0pxNwwYgreIEwiQyepEnvwCSDOn1XP7?=
 =?us-ascii?Q?3eyfkqO5sSbJQIC7wkdVrxZaHefvrh+iYKQEK59jY9R24Qe+uG8NCSzrsbFM?=
 =?us-ascii?Q?s4cSugFfMT5hnoMycK7/l2UwIikyab/okQF1PdAn7V9PWrHCTOt40soqkbJr?=
 =?us-ascii?Q?qaiXwblGWGtLszcruHBLQL28VwT26QO4WWo2SiJcnFJDMsq5M4zap+NFAvdl?=
 =?us-ascii?Q?TV4ZdTWPA3TzFiKXC60292tVPDo8fOnMv5t1jWbMy7LGhGIV4AuqK4yvyU2s?=
 =?us-ascii?Q?GCAwkMGRXF6lScPvicQceEtsOddIJbdmN+Nv6up9p35o1Ac/J8jv13fLtIAK?=
 =?us-ascii?Q?zbCSX7j7xzknjIseMHZI5Xb1W/cvcXIgLwDmftWJmVFeiVifs8PCM6rY5Qdf?=
 =?us-ascii?Q?YeT69hfa3kfUbY7/p2D/Kzq/7N1TXr4th0kji1fruXj5HdLQbm3Lo4UwWl4P?=
 =?us-ascii?Q?vQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	nYpsYqD6gtYk3TjOUt84VBFny66zHF1jdSdxQss+hFYLoRop4CtGk9X5GzsCtKnWv0I1eVM7SChN2kXJmsWjMLxhncqaRmMS34lizBx7w5AopL++zMbSbASrY1v1Nahkg7+YyAchmW0jcODRFiL4eQu3DT65ZkWnxQEg7qaKgV7Nx2s8ydE1cVzPL6nv5Yw7i4NEwIK2cFMKRLvpNLcLfqlc56FzzWenU5+Tq/ERABoyRbhVDAvyUNqcbfz9mYZ/2BAjHRUvuN9Jv0C/vgV6CKiWjRhAoIpH2nU/U+jHQyS8EYaljPwQ1L35ubt40mlxyx0tNd9G9PHQGLlvmTNekTdIoo67pgz2RUxarz76dwa1azEI9vMsHCkfFB5h8AZ+EXNztw0+c6tKsO3VOTZN/6TYd+DYjRRJMv92zO7bkEtv9BDsYxx/nGC6MScfeC/8wjXkcQnFTsqV8sUljXGWLSrBNOSs/gnhaw1wwvMMjh4RJyfs73VXClOoFTXd4Z6R9s2ZzD9E7dxCboXPU59V72/ckeJA5EBm+AOQrQKH+WVZexaOwbc6Y3ppBgxv58uMC167KfvEWSHa8dyiSYeuTLiXIvRWlCKdiR2RDWA/548=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f2ee483-99f2-4bfa-815c-08dc954ab47d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 19:12:06.8934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HG6HzSEihWllR3si/dgUK8ZNiml+01U4kF5nCJtWOaCbJ4oHncRwVwwx7bvbPeiRWeix7FNmfadPUtLPm3zQXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4707
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_14,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406250141
X-Proofpoint-GUID: gvt01nU0efeSsIA4YmeX9foVf-PRWNiF
X-Proofpoint-ORIG-GUID: gvt01nU0efeSsIA4YmeX9foVf-PRWNiF

vma_complete() will need to be called during an unsafe time to call
validate_mm().  Extract the call in all places now so that only one
location can be modified in the next change.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 2a1a49f98fa3..8d9be791997a 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -646,7 +646,6 @@ static inline void vma_complete(struct vma_prepare *vp,
 	}
 	if (vp->insert && vp->file)
 		uprobe_mmap(vp->insert);
-	validate_mm(mm);
 }
 
 /*
@@ -734,6 +733,7 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	vma_iter_store(vmi, vma);
 
 	vma_complete(&vp, vmi, vma->vm_mm);
+	validate_mm(vma->vm_mm);
 	return 0;
 
 nomem:
@@ -775,6 +775,7 @@ int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	vma_iter_clear(vmi);
 	vma_set_range(vma, start, end, pgoff);
 	vma_complete(&vp, vmi, vma->vm_mm);
+	validate_mm(vma->vm_mm);
 	return 0;
 }
 
@@ -1103,6 +1104,7 @@ static struct vm_area_struct
 	}
 
 	vma_complete(&vp, vmi, mm);
+	validate_mm(mm);
 	khugepaged_enter_vma(res, vm_flags);
 	return res;
 
@@ -2481,6 +2483,7 @@ static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 
 	/* vma_complete stores the new vma */
 	vma_complete(&vp, vmi, vma->vm_mm);
+	validate_mm(vma->vm_mm);
 
 	/* Success. */
 	if (new_below)
@@ -3353,6 +3356,7 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		vma_iter_store(vmi, vma);
 
 		vma_complete(&vp, vmi, mm);
+		validate_mm(mm);
 		khugepaged_enter_vma(vma, flags);
 		goto out;
 	}
-- 
2.43.0


