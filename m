Return-Path: <linux-kernel+bounces-274629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDE9947AEC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5575281C47
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 12:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2D3156C67;
	Mon,  5 Aug 2024 12:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hFG5uhTE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yZmGKP39"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32A71553BD
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 12:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722860071; cv=fail; b=sdejU+Xhgz/wfgV0Qf4h540nbNiyQHIl+Y4aZqhsKUyx6PLaG1KZmyQe9v9Ekip8hjYvnlGDf+bLzB1qwEF6/ymxOsR90aAJ9Es120bUvibveYMPhOPE1QZR9JgLwkMI11BIekWI8CPp6ltDVVELS5P92K2ZTBCgBJlO4VVPQkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722860071; c=relaxed/simple;
	bh=Drh9VkXFJFeoQ8jBcI/aGf0CVv8QqhutQ6M/fpiXqgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O13kiMe+Og5HT9EPDE+xhPiNx8UxQmJFw2PoyQ+TEmLfk5lSZGwMSxXRwGF05lmL2Mzzhue98I3dLZOkhKYXwTjxbmzqhT9CIzeUNfik007sjSpzmntol+Jy0COvMzdLaqaM3aEtbmemNhKlkFllIlx2ZgKfEcZyQN95AbtAvqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hFG5uhTE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yZmGKP39; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4758fY7H026858;
	Mon, 5 Aug 2024 12:14:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=xPVfZMBmeBkMSApfG27V76GTAsKO8+FIQyoz1mo9i34=; b=
	hFG5uhTEmSuYUQj53nSsPXlbIcX2Gagk9RIZcqSLCq4mkh0wse0RoNOQdMIy8SUb
	JEXv7rJksmN6k0PEZwyZtegG2Q5K2FF5XVkVQk/JYNFnZiP/NrJvHJHeW5jfVOl5
	PDUzZwIvudnilsL+2r7TUUJK5cxnsV8SnKi7vLzt3hKnf1aWiRDl0mV01sEwHkem
	E61zBZJlTG0p0aS9TGHil2zBXo16lKqfLKs0Uzx1ojCmaTHiJhdEdDqmyk7BR8Gs
	GaHuDB17nD3PUE90jn/GwjyNfCplJn5gpkwWMHyuSBULtEVxPuQoCbNm/xMB5eqb
	wO50ij69ClikHGoxJv09Xw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sb51ag8k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Aug 2024 12:14:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 475BblAT019380;
	Mon, 5 Aug 2024 12:14:20 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40sb07636y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Aug 2024 12:14:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IDICeIVefwlHhxkp5mUn/Vzbp2Km8tGIcfHg78gcUhN03zgScE0NJowUFMQEstBXbTGO4HRA+GZKJRVXNvKh5M5v1PBT0pf3pOxYJfiUDClJ0V59BotioP8wABx/id/ajWkI0ac0bkXNgf1QMguaFzB8E9Dg58XaSF0OIn74C5sI9edmA083dOr5J8ELrFkByX3LlNARhvo9nN3r/KH1qRVd6MdpX8xSeppk8NdDFBlNXkSh42xkmRc8xMz5pvX/Mlproc5Ddgi+zOXii/b3ygTxYpaXLmRIRXAKqkDrP3R5C5SDZcBHOJJSwLHZPaI5vY4eTnAUauevsRi6C+CohA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPVfZMBmeBkMSApfG27V76GTAsKO8+FIQyoz1mo9i34=;
 b=uJR4efBEi3bbbfZPrp7n9SltOeNh6R4nnJma7S/FXtzA3K555RdyOp9PZ0EukqOgNsBQhX4iNTTg7pNioVASPxrHa9Mq3RqveTzOcZWl3G2n0OR68o2mQEORndtsOP0ZQcR6MFsXysw3KtEdB7cCg0/m/4JQJtpA1Il6t7v8nCv6sE05hnPAjZ8Mp7qxTRshe7ZuNwx1DhNHorIsqvyDJMb5x8YZtNGqe4+fjX7QpX2bJV4Mxd8dGWxdHPoEK8PSJCZAuQawwpSQa0QE+6Q732vX9Pj0AXXjIyppoluD9Me/mjb04fPgXQqTs6yIUd49f32qgyUgHdneDphStmy95A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPVfZMBmeBkMSApfG27V76GTAsKO8+FIQyoz1mo9i34=;
 b=yZmGKP39hzKcCbyfPE7/3xRaNATskUuNudM1KnxFhwp0Ub/YYqHdNzEn10QBZAYWwVg+A6jQYk+xCJvd7WGPRXjy8l8w7Db1qISUp6vJ5LeH6cwDQFZFkDCx0dNMTskXnOrRliKQRJQdkmMJHMjx87xGepdkmUKGb2WqnSr9Sfk=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by PH7PR10MB6334.namprd10.prod.outlook.com (2603:10b6:510:1b1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Mon, 5 Aug
 2024 12:14:18 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 12:14:18 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 01/10] tools: improve vma test Makefile
Date: Mon,  5 Aug 2024 13:13:48 +0100
Message-ID: <c0f6c9b152facbf130833bd998f6761dfb540364.1722849859.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
References: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0035.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::23) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|PH7PR10MB6334:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d26be53-55a8-4abd-c00a-08dcb5482163
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Kb6DzySyzwEWLVf5PAC4CoIfqTLhwmEnwGFhEoqthAzhYYBmsvIOOao9ZH9M?=
 =?us-ascii?Q?pgQoPYG66AKezfC1nPlM4DSk1TOmB18bWXy/JoFtKqZLL4gTT5MEupPMQPWt?=
 =?us-ascii?Q?ryzN98nxscGqTo29oUlHnU1ik/P2yt69kEwrteh6RLX0qOkP6LKVxi8gvkKM?=
 =?us-ascii?Q?+/tZ4yWA0PMGm7ezx3zEInWgDkt9zEgF/IH8xiIBYpUKhRsBdcibnv5VE7v0?=
 =?us-ascii?Q?ThRuLJxTJfF+KvAzs7mtSlW2/QMKoJZJACl8m6+2KmQYAsXiJn2bRcmB9hZT?=
 =?us-ascii?Q?6mvtqI7DvSzcjzsEPDUYEGMEeoUEWpsTdRkhntckigxtaXcsB6GuAnTbZ8X3?=
 =?us-ascii?Q?M4fC3C2rM17Iqec+0Pdrl0hKG2wDZp9uCOfVf4oES4PMJquwM2LDM+ooQCzR?=
 =?us-ascii?Q?T1Q6pRPV94ctFBSZVscVFO/bc9Oyh7PgnCK/CZlBUKz5S9j7A/ZIatWs6Ltw?=
 =?us-ascii?Q?po/NTUTQuH9OeFWQiRuqxs6O3VQICWIXBAa5VAWWVDV4Wc8hbSHpOwoHs/AN?=
 =?us-ascii?Q?EDNkVRASPeg0VmVxClvbp2LpTwKvcorUbKxIGxqseymFQeY2HctkZTLS5dXi?=
 =?us-ascii?Q?abCyNhoW4FQodanHad6k9Jx+h4QZimhLLOn9HC+m9XIBPCCzkReqBrnzktq9?=
 =?us-ascii?Q?u3tuTWGkgl90D6bN7183zWTVwg1hyx7O498tAoj/M8HeVupI2WEaB73XDhkM?=
 =?us-ascii?Q?z1j/d7eocOHmn2vrRKXYmxhwxk5e7VLf7XIQdTrvM7k1Tksv/sLOa+tnzp+K?=
 =?us-ascii?Q?2yQao4UQDD9m4MBd/h5RMtm7Qzduu8sTJIExosDhGvW/TuZG/9ZFm4Rc0Mpz?=
 =?us-ascii?Q?0lDqriVHzzHJO0ESkDJM921mEEzaiyx2WYQLreharuSVVvHiOxWOhV++aySw?=
 =?us-ascii?Q?8XkL9chYcDoNRhu2bFiFT3cgPVrx3R1UCMn508dg4ffiCPMVO4AXZqgJNbcm?=
 =?us-ascii?Q?SeH5PtmHMMmpGCvSA6tT5KGuXpzwDzJXDyy1sI0ELzZ9SvfEgJfbrvQz1oTF?=
 =?us-ascii?Q?iqFJHe4e1C9f7Po+1shoxot4v3QO3dFPGY/4414b2qJgn1rqYbiNy82ura86?=
 =?us-ascii?Q?xJo8uJaF9XUdG2dW2oLINIoGf61Ig/5IQbfsHv9CA5wzYKRsggQCm97GPCnK?=
 =?us-ascii?Q?rIznQwcvZBX1avqqp1GLzRSo3s2EkxDBOpItQzQJyWba9C2NCDPPu/a3RMOu?=
 =?us-ascii?Q?9ufGdDD18XuJz2qydCkKy9SFQoLN/4oSwlydFu5QkmCR1MxQ4U+A/KJlSwsi?=
 =?us-ascii?Q?0EixF1Sb1gYzB3yiMOUv0U7g5Oda0SxgY4nFamtCnAoXcDSMhawXVkYy1xn4?=
 =?us-ascii?Q?XjoFMDLMbsHiqtDnz89p7if8sc2ZR8VNi7y+Er/A2nBxAg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DotA/wRx8dNyiriAmdztSwex+hffdlBWJOFsDoUtfmnY4cT53t3GJDB9MDj3?=
 =?us-ascii?Q?Cbji7ZgnJPFVWmcZ7FXM8tMcRecXWu+WOlfV7r+btKRVGHyxAdbRm91dzwwd?=
 =?us-ascii?Q?DdpTQLRsQMfMex+1Fx3VfnYVcUdyOs99Z5LBsAoQQIdlMtx6IxoFXFIK8vqa?=
 =?us-ascii?Q?BeHy7VozJzXXERlDOk3ebbnrTUO7s3fMQTWVPTgy/fjD2FNTecD27WbacOlc?=
 =?us-ascii?Q?d2ROIEPvJVzXW5m+XVjyKYiR9N7mmnFerPW7KsL3SYE4f0ENRpktwxrXL7d2?=
 =?us-ascii?Q?YTAHpH0BVegUNQuMSDBuEtMG9xWUfURMjeL+QCoOzqkvpUCXQP30Rb/PHy5D?=
 =?us-ascii?Q?LMdnwUPGEWaACKC0Sp5jWWjvsdf5SVNDVzRbGlK5HgR267TahNW389yc4Ggv?=
 =?us-ascii?Q?fSRbK7kCRobBuG+ZJRhxCN8W+jQvTRH2Og4Oycn3fK7Fo5jIbkvJQeGWHjbU?=
 =?us-ascii?Q?RnV9Vi/8OfIScUZOj9uns/SpdCIpefqj9+0mBGwi+Kxgi6b6Ef2MQM3pKyub?=
 =?us-ascii?Q?aH/z5mT96s0bOOMhc4t5h7hsdkH0SQfGDUrD+9rqHmXygNg6T3+2tuMXmjrk?=
 =?us-ascii?Q?2EWHx9MWpd2yc1jEulVNPWs2irPWukgR7NlkvFwu9hOsHyLPRDimk0oc7gCn?=
 =?us-ascii?Q?XXbmbbyySXHxQpP5so7iH1zUmYF6FXGS5b/qWjSC13mRCo3wZ4Aw/Rxwbe6V?=
 =?us-ascii?Q?Ep/omEOqps01b+6tkw/QjYs1TwtBTz0+R/FW2Ntr0DHQBxCynvCuJ5DAIG3y?=
 =?us-ascii?Q?7BaUpqrSEQSaxOMFGC5Gbt9270nXH+CM2xqiM3ZZQ4hnHY13wWm7P3mKD2z4?=
 =?us-ascii?Q?AgXrPA2tI+l5GzXBdgQibWO0z7+hqeAzwiVYKlVpjzf2u0oRTGI6dyIEDF/h?=
 =?us-ascii?Q?GTgnqpLmvRMv5VMZ2Qgw4hzvJkan3oe5qHAYG7YjQf4nNOG6sl1OgAZ2Am6f?=
 =?us-ascii?Q?fRdxqDPC6TASvQk2w5aUuPb2AkIB3WGKUv/qpntI4IqzWbUfa2VeTTW8lc7K?=
 =?us-ascii?Q?F/W+jofBpwyNHWNYlhmYJ6rxGtyyTPQFGSxzpVlc+ndmiuOMpd+NkpKEWIvI?=
 =?us-ascii?Q?k1VYJiSd4wJIxR6VMnYwVaWWKJLhqlIa/CKNUpQouNEnZJsFdoxgWr7HBzy2?=
 =?us-ascii?Q?lLeCJmGE6kPBxOcXbdu9/LcbRj4JWjxUtU59GFX/o9G/461x78puUHs94VS8?=
 =?us-ascii?Q?duL+OYQxdM4aYUa5Vg5V0ntX4YePSqYggzx+9gboWwnu4v58Sv7U1Kfe577Z?=
 =?us-ascii?Q?0X+7HeQ4uKfrdzlhH2qcN6CWihpCnr2iWDA6KGTt5NAUNAy8q6LfnHtv3Izg?=
 =?us-ascii?Q?aCoUYgZhbYaJkUk3jyah5+kvMYt4l2z45PXmx93nHNR7Bd8OJ0DQiVMl8gum?=
 =?us-ascii?Q?b/4u4Wc29Y4ysk/MaIbFGaKXQCvN0ULAH8V6LJskGiNYKvpu/+iql4BaQ8O/?=
 =?us-ascii?Q?9CTEdIpI47M44mzDY3dGMtprLSSoBfAhDD8ouIvnru0PHoh+7I0wW0slZSWW?=
 =?us-ascii?Q?jPMvBCmkLAzrW1fTBmSAQLh40FkHuvoDOMVGxsGQOgfxXdeM9IInuMuBgZAU?=
 =?us-ascii?Q?8/+DKvYcGj4HXUj6J+Qwtulq6dWb9DPwbQf3AbS1GcljfQgO602Q4IqY+FjW?=
 =?us-ascii?Q?AqYFm7r8BTcY+UuND38+EWwvE5bEcemQSZymUFUpEJLo8E0Q2ZlXO5+W+pZU?=
 =?us-ascii?Q?S8jVmQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DySqunF0K1f9MGc6uMKju+/0CEdJn33oRb0qQuAI9SHbSvsO2eOllUE1JL70hrc05+zYYtlQX9bGJHxzXwtw4RlVPF/yXHihADLFK/9n55gSRTyEB8Ol/AtZvD+lEhuibX8qiOtb3EdzyjsZXkmVmRUONIy2pQHQiQ1xNT+smclQf832aWrNbGsIQ4pEpRbc6HkvLPjg3HfGp0oiwOkCmzR/kP/6m5f0z2cVtaIHw5Pm47SAlQ7gAtBX3gq1SA7vfQpoKBdfkuY6cJP7KkMl7xClaFiGoAXDn79xDmR2TVzYeMYjzLeblClWaSaHryA2jRZdadCdk/nvMvyxDkFqld04UIfYSKzIrXIR+MXbXSK/swf+dvBB1Lfp1O7liPUabjyjxf/nuLf229UrtByBOloLFk6rgTfG9Jb2DNdKqq7uHu96ZN7YN4rqQNCd2lYj1P9z8cdvThlpzfIJM5HAre7m431iomNJ1XUrAjftIDZsv+9VEZoo1UX/PSeFUCvfabfiJs856nELsc7c0LouncEJWKUW28kvdDC9A+WG0iOPUsDsgkADTEdqp5yJXN04G8SGFWFzws4ZMA/0AfP8amLZLm/s0JtnjaJN2Fit4Uw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d26be53-55a8-4abd-c00a-08dcb5482163
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 12:14:18.3118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jorO/eS+ufFJDJCcHGbT9HboOgkpbTt54UrlNbAeNBlotRsdgEA2Z8s3AtDXFW4CybXNASOetFHlPu2jvGUXbNFpC7lgh9sod4vxdoz9jOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6334
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-05_01,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408050088
X-Proofpoint-ORIG-GUID: hgh56i-89_yD09LipcpdsTQ4svZokiqZ
X-Proofpoint-GUID: hgh56i-89_yD09LipcpdsTQ4svZokiqZ

Have vma.o depend on its source dependencies explicitly, as previously
these were simply being ignored as existing object files were up to date.

This now correctly re-triggers the build if mm/ source is changed as well
as local source code.

Also set clean as a phony rule.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/vma/Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/vma/Makefile b/tools/testing/vma/Makefile
index bfc905d222cf..860fd2311dcc 100644
--- a/tools/testing/vma/Makefile
+++ b/tools/testing/vma/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-.PHONY: default
+.PHONY: default clean
 
 default: vma
 
@@ -9,7 +9,9 @@ include ../shared/shared.mk
 OFILES = $(SHARED_OFILES) vma.o maple-shim.o
 TARGETS = vma
 
-vma:	$(OFILES) vma_internal.h ../../../mm/vma.c ../../../mm/vma.h
+vma.o: vma.c vma_internal.h ../../../mm/vma.c ../../../mm/vma.h
+
+vma:	$(OFILES)
 	$(CC) $(CFLAGS) -o $@ $(OFILES) $(LDLIBS)
 
 clean:
-- 
2.45.2


