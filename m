Return-Path: <linux-kernel+bounces-280736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 382BC94CE5A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 12:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EC231C211DE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 10:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C2F190684;
	Fri,  9 Aug 2024 10:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BY9bb7Oi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qKUCFg+0"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DFC28E7
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 10:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723198295; cv=fail; b=SbXvNP5tqo+5zTFUF1TBhCxSkwFRn5aJ7sWa5bTJQyMkjqOOt8haj+tkYyg1+jIPVjK7iuQj0zY0rYzPYyRA/4bLTIyx1+wuk2Yk2AluofRyjLvY0nZ83DaCUICFxYtffnEiBPe+E+DtC2lG7ngju2Rj6RSg6lpf6SZI/DypeU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723198295; c=relaxed/simple;
	bh=CTHEfkr0A/lg7WpOWtgVOnKS0KfD4ouE2hAFspngQHI=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sFj2K9mJZzts8SN08GAmTwITvCCMBbXXcbPi+VZ0SndnJl8tq9UYBvRbNNW0ZoLOQAmPT9bfWN1U+vtioIasBz/rWmPb+1MPl1Bx5NFEeE9XdFJsM7owjfa73bTSUlv1m5tSb1NhOarnmlSuxi89g5bCqzL97mXgd/g9Jt4TKCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BY9bb7Oi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qKUCFg+0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4798fUfW014717;
	Fri, 9 Aug 2024 10:11:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=pj1gr9a0KrMaUZY
	w63X9IxZ+5Mm2R/4DSzRezi0UgJ8=; b=BY9bb7OiNx76bPZBJVigGfzmGtJAyLq
	fcUry9pLCm7425Iqd/QIWCPn/B9HGtswYdDyQfzSk80j1zU2LhvrcgLSiDsf9n0S
	M/anyJ32nO9UwQkBHv3IK0lYwt8R7Ngh7avrL7IxGJ0PUhAlyTpUa436Smy1Uxfq
	iRwUjAI0xeX0W3euV03yfNNiT1OqrqtTjidou8sY++TGt4ibCoBS2gSMwGaSA0hq
	v2opKgPvl41GnAdtCEVQNoPxzh5awKKit3iKIw1Y+gewPFhnINiQICfo/zr/W1CJ
	gAzAEPKCj4gxhgAo89y2w2O8W9p5Sg9rSoUM0DUuO6zkuUNvveMG6sg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sd3uupr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Aug 2024 10:11:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4797icIA021832;
	Fri, 9 Aug 2024 10:11:21 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40sb0jqrp1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Aug 2024 10:11:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S0WXMrCUqlUh0PUDq1cCj8zzZ/iGcveejTI4svjfTV6aHIqge7Wl7D+SyWFsHe0d8d58HyJfNbjehotXQagsxEqwZc+jH0EZGltLMkH3eyb2HstEm2lEJ1aDvhdDygvr/9DYsnG3aOjOTi0HbKSqUphkiokALnrTqxxHUjcotPm4C+T4uiQUWw4pQ29C4UUwsbcIF6CZrM/xzi9q4VMuSmBbjVlo1SC8++qgP/9V26fzz5FvExYT11YtK0I7SA+iFMeVA11CojlWdmodohGQv8aR9uG7zDareO8G2oF2/hhm/SnTV9X4bDoFTLnojZ1A+Sz5dyFrAKb56hgd/H86fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pj1gr9a0KrMaUZYw63X9IxZ+5Mm2R/4DSzRezi0UgJ8=;
 b=VCncAYBWwINxoJgcaVKc8Rvaem79M+mlwkAwt3I7Fbe5r6gW4gkFNmvc/chnmbvb/lFUJAXrqeWOiLg5RkgmkLMS7zUkcDCJNOV4V2S9VQJOSHkAtxh6cJSVTlqeubzAqgWYCYxMahkp8C40VKzUZ7T6p7ujZRlzrv1RL4/9BDUwp1GwoIAU+nebALi+6tejjxRXkF5Zs2X5wadatk0IRt/EkCZDWXXhWu/mLcaPavzk7KX5/EOq6B0aFNQ0EIAkVawaWFLW41H1g5zzP80fhL3Bxjg7m6zm1b461CvqvoGNNEluIRbmPQH9k581oOrKv1KSpT5B67NLiG4kMQqvaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pj1gr9a0KrMaUZYw63X9IxZ+5Mm2R/4DSzRezi0UgJ8=;
 b=qKUCFg+0ewyWoo0TyJTL3GEvllIFNuykGfqW1hlZTi4dFn1ezrpYUHm/fmHtKa9Tq3QEjb/yoRL5sjk0f3BLbUVi2QfFNAjpWODksXeqFthOj74C4VYnduut5ShYAN4+eHRZy53VhXSSXeraz7BQw3CH/zhtrGVSPCAY9W80fuI=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by LV3PR10MB8129.namprd10.prod.outlook.com (2603:10b6:408:285::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.9; Fri, 9 Aug
 2024 10:11:16 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 10:11:16 +0000
Date: Fri, 9 Aug 2024 11:11:11 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 02/10] mm: introduce vma_merge_struct and abstract merge
 parameters
Message-ID: <3cb96602-a8d9-4d3d-be8e-8124dd96b5ad@lucifer.local>
References: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
 <f2d7cc5de8aecc50d353980f62a74a0a6fcec198.1722849859.git.lorenzo.stoakes@oracle.com>
 <jsb525zhs3d5n42n75k6p4ou3d3on6lwdwp2rwhijgi6k65w5o@dlw2hya6zjkm>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jsb525zhs3d5n42n75k6p4ou3d3on6lwdwp2rwhijgi6k65w5o@dlw2hya6zjkm>
X-ClientProxiedBy: LO4P265CA0184.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::10) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|LV3PR10MB8129:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bcbeedc-061a-4593-5baa-08dcb85b9aef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XitNHfC9bapGLOOqwrcqDvVP+W0zC+ydsNX5hkXSBECWRFyFrv6k8d7jxTAD?=
 =?us-ascii?Q?cZCIeNFlNVR3gwIdYBZwRh9QFTlsU83yP4/9VDF6qZ9dntnjBpGVhKhZ4hYv?=
 =?us-ascii?Q?4dm6e1y4dwe/4r1SphzCDbIjle60uWjrWBSuhDrRr58a24L2hY2+O2a1HbkK?=
 =?us-ascii?Q?80oM0vQcS6UUEhFzPKPihjX8HTromL+EDLVReBH3wXyXIUMC6BYBj5fcgLvB?=
 =?us-ascii?Q?SsauhcUq00KFkEUNpizDTy6y/l94nrAFwos76oE1Yy1BmGHt0as97yqYW7Yq?=
 =?us-ascii?Q?7BOwGoYxbKBZNj9HL9GRoC4LTL+4F7q69bJ/TWlPs6hCMKNq3HZTXWaiERGD?=
 =?us-ascii?Q?rwtSOSYfIT9xqatMOCZyHRhvcXlo1ASFF0DQ54YGHa2lCnUimvphD2r9MkSP?=
 =?us-ascii?Q?tOq0nnxU1sQO35eyhuhWz1wav5VxeFSsQJiZx1LQzgFw+2TSvkk0A1Y1CtzY?=
 =?us-ascii?Q?WLs/lmFB2VN7V/NANNUUAVqA8DWef6vfxMKivghZb+uqVaSCYUjhlle1qY3e?=
 =?us-ascii?Q?2nhkFDpCbhROU9Z+KPSnEzPRwiZnV1GOVcxnMoeyvasMFhJ+NesWk7hqIJGC?=
 =?us-ascii?Q?QSOKpSbapZnWe2clXotzcePzpxJVNL/0SSuPih7GmLQsLwqe4qgiHxqsnf/p?=
 =?us-ascii?Q?7eMnR4XOC4Brc4uFi5IDmyigdzQSPymv6OSTANACFC7HOEHifui+eP1ml9es?=
 =?us-ascii?Q?kqY1ryAs4W045KaKNtNOENKR0oKY1mRfhE6UcxAhNOxe92q7EVGx7h8ThDPM?=
 =?us-ascii?Q?8U84cWbDSL4jvm60srBXirgvx906KMow5Dpm+x+TMhprWtwreuiEqvF3QEkd?=
 =?us-ascii?Q?KE9gVkQ4yf+z9scpih2DBrsOKPNHNppms+D3UB7fOFtLLD2pzNjfxV1+UrQ4?=
 =?us-ascii?Q?ARWLZqpjKqn6zVplL7/qS6Lay8PpuACCbb1jPUKrtcbqBpEb+Xv9xFpvyJjh?=
 =?us-ascii?Q?eLYg89g2vq++02eWK1Q/4owf8EODNAi60MlWPVaikIFJCzJFvPeJsN6Akws1?=
 =?us-ascii?Q?db1dVmCjo/ygOqsAyl7m8s1bq9NbyN7bZD2ZCS2M8nYu42o5dzkd2qygJ2pM?=
 =?us-ascii?Q?XM7KzqjXJATtfpoZmpSmWklAIc3whEDGBfdDGzWrvojdDHdkshceS/nmSRce?=
 =?us-ascii?Q?9sTXs0RJRWkBqZbSFvFXal3zpmxpf6SdvTRMfPXhG3FUSJRmvbLgAT5qUc22?=
 =?us-ascii?Q?QgQJLzIzVYIM6R62Nr+WgicICX7PFmA8yqVETzrTSGgFa1EuOrvEiwSf4QJU?=
 =?us-ascii?Q?FEbPHWa/rHSQxb7nSCthvmQp3+33PusEFE+dKmuvBqb/BFL58jDciaA7Hhzi?=
 =?us-ascii?Q?LqMlywDpWbLC5aFGbQkqPlLkhzJ+rlsnZjubIQzdfZbjsg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vkBUdK7UKXL5MS7J+24brlVoFSaZ3Y+c0JaU3I8g+iHit+zFp4ns8MnhCtUL?=
 =?us-ascii?Q?aCG5Z/rywHKIL8TzLjZ2uSIiHIl3GSwVntBU9oQc1EaLvzw8iBRXxe6ShmcN?=
 =?us-ascii?Q?rWWqqmccUDc/bwOeMWpoUWTE3S6zMWSirVec4lnrFcS1Z1Q1tdsxU0sbqH8f?=
 =?us-ascii?Q?g2CKMfhy84+nd1Qbr7coy6igBcuB3HUSScestAXbrkvoINz49nbDrErPCRdo?=
 =?us-ascii?Q?7l6a6jjaZFWD89scLmUbGWHQquK5ck95YG3pG5cXT9tNZLZHFOukzVzLBs+t?=
 =?us-ascii?Q?ov+ud6H2yPoGJ7UDR8+gsKTVY9INSgbiI2jcol87JomHSXxleH26/Yh+RNLh?=
 =?us-ascii?Q?T2LZifphtmrPBbDFAFuE3bKbp3sQLArBtIPXkZtrKu9ZnygMCsVQjk6U2vs6?=
 =?us-ascii?Q?u/gpRWS6onKYTX7mFDbdXEjl1o0Ej8PBnoC4p8lGc4NrMIKt+WFCR/imL53E?=
 =?us-ascii?Q?WwhUMwHXbXNYBUmhbmvFLbG4cxcHBfyQKWqelHC1uxR6vSbIx+ckEtV2mSYV?=
 =?us-ascii?Q?zMgx58YzHljm2Qw27CFJU6Fp7dygwi/RhFqoZyi+Q4dkkAf7mfir5F1t6fRq?=
 =?us-ascii?Q?wgkoebYq0B2bcbDzwFUGCRMFwkkjY+ZjY88D3p1nv37prAnB+PWaAa4sNDF2?=
 =?us-ascii?Q?IW8bGcXIeOmyE2GUSQxHG6y1ZT9n6hrbTPJQw9WiY5FOZ5VadvzbTCoF/hbw?=
 =?us-ascii?Q?DhHasp/jIsHa/asnsn8MeeIHw43jCm2yH6bQkluDBLNo2bKSiX3SQgL0isL/?=
 =?us-ascii?Q?mLLbumwFXxQNEOTl5DXWwsNr0KWemsCs1VY4hIf/23F+bxTOPAqzSsaFziIe?=
 =?us-ascii?Q?GxFGZAiFcOxT27zEPFIeVswyZKLGme2IRdVXWQSxy/wr8IG9Ia9VVApnciuZ?=
 =?us-ascii?Q?F/Kw+u3e/s2sABsus0gvSAzkakq0m84/1jwXon+Frun9OILBAonX8qJcZNOc?=
 =?us-ascii?Q?ykzBqo0vCoDsz3i6dyfy+/4Pn4Kf5q9ma9eQzkhedguuJvzY1qoSuXsTvNvI?=
 =?us-ascii?Q?F0q+nd48t3qMOwTRHhTaEj+lncwGCs1dYnbNSKd/ULNlzRftuXxTNSHpmDIy?=
 =?us-ascii?Q?DRE+0Gg+5TqrpzGphTZZbX9UZdcIxjoLbuaHNo81Jpi5SRP1FbZzPbfoamUW?=
 =?us-ascii?Q?2EvoJ3/uUiv0hHv7rgxrDmHvlbi3O8ocPkAu+78ZfFSRadlVGplKyw+i7yFL?=
 =?us-ascii?Q?OG7fNFgUBjNwuukhQkl9Kba75m380bNzFuEAsWnE2UoNuGRiMkcE4PkwvJX+?=
 =?us-ascii?Q?COft7ymMB163rkjqinRw/rc9ZxSpT4mqHlSzsnf3znCQYNGjmUhmMv2+6jnm?=
 =?us-ascii?Q?Gx0q7cZ6EIchjd/+O7lMUuCVO+y3Kv/uJbKkF6Rdy9L7xb88Wau64V/LTAE5?=
 =?us-ascii?Q?3TyhcCOGTwiX6juwf+4HX5e6OsgdoS+8ulPEvINjLyvHE6f06n3FvoGcnRSE?=
 =?us-ascii?Q?owlIqQkYwA+X/HI4mDLwSFdEdIQMdeHSosJk3fqBxzM5SP211F9nejxVUu38?=
 =?us-ascii?Q?KeqHLYpdYDTGcm10B3lk2AmyXrgPvy5cny9NrwJ/MYfLiT2ZEnGIG2+Wr0sC?=
 =?us-ascii?Q?XbQXnTj7WSQuGCE1D0OWTPdsUk/ox4pJyVGA87w8KjzORAWfQoHXQtcESwyI?=
 =?us-ascii?Q?w2KhTlwg1fBLj70/Co8NVXQxHmobC6+8erIJ5y+bKPk3KcmlWjHqOCQR7Xdx?=
 =?us-ascii?Q?Na5D+A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iIe/HXSfVhPbkQpSXyXw2TMQLY32X5hOTvZ4DzAfHtMqetdd61gYHDHmNixzEfZgLLmZacWBo0V2ppGPzCYoNjSEk5+LspG+rPUvdB3gK6444XF2J/OkZ7Z3ChdyilzIL04vik9mO1nrMh68sVQipYv6/Mcw0t2TQr/ZTrIEGvcvM95vu+mmg+866DUVktHp1VpxMmL699LAo3zURm1+kMZEMKuxXBxsKNnRfNEOM2zid1Can1JhOUf+PFSv9351w1ULhjOZAEUUve0CRc9DORPvqzJZ88NSHyjhStUrYgX79UfI2av3ym6vQ8TFZmvTg44SLWtV87X5jvB8JhypKsnKIRzH2SlAiO1jfW7E6Xw4gLg5+F7VVC2n5XwC4VxE/F29J6xk3z7qKz7m4p2jUJG3NbPIq1/hYA825DnPlhelvxvXnTqHdsdbH1OFe2P0x42CEYtcffddNP5lv9lu05WtnHrFFqktPmxnib9zbFaDzRup0HTgXLIYqgLHHRUcU/JA5fmhGJ4Y9NNjRRz4BG5ESVnB8UWKCTUYG9mqyA3VVFPVtGQpIr4FlTGzcwBLT+muRkwHKyy9jtKZ/Ma/zyYRGq+L+QDKqvNzSfdPrY4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bcbeedc-061a-4593-5baa-08dcb85b9aef
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 10:11:16.3256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PSUrOkzQT7lTt/W2lr/vGbYpytAbRSNg/XuFCDY59Dc0xxuewt7f2u2QMDqcfUZEXWiNInhjrnjxOPf+VXwozbme7xZsw/TuWug8lZZUhJ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8129
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-09_06,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408090074
X-Proofpoint-ORIG-GUID: -xIZuh5iUqeq3YhRrAlRJ5_yiYHddSTt
X-Proofpoint-GUID: -xIZuh5iUqeq3YhRrAlRJ5_yiYHddSTt

On Thu, Aug 08, 2024 at 04:07:15PM GMT, Liam R. Howlett wrote:
> * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240805 08:14]:
> > Rather than passing around huge numbers of parameters to numerous helper
> > functions, abstract them into a single struct that we thread through the
> > operation.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >  mm/mmap.c |  76 ++++++++------
> >  mm/vma.c  | 297 ++++++++++++++++++++++++++++++++++++++----------------
> >  mm/vma.h  |  92 ++++++++---------
> >  3 files changed, 294 insertions(+), 171 deletions(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 4a9c2329b09a..f931000c561f 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -1369,9 +1369,16 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  	unsigned long end = addr + len;
> >  	unsigned long merge_start = addr, merge_end = end;
> >  	bool writable_file_mapping = false;
> > -	pgoff_t vm_pgoff;
> >  	int error;
> >  	VMA_ITERATOR(vmi, mm, addr);
> > +	struct vma_merge_struct vmg = {
> > +		.vmi = &vmi,
> > +		.start = addr,
> > +		.end = end,
> > +		.flags = vm_flags,
> > +		.pgoff = pgoff,
> > +		.file = file,
> > +	};
> >
> >  	/* Check against address space limit. */
> >  	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
> > @@ -1405,8 +1412,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  		vm_flags |= VM_ACCOUNT;
> >  	}
> >
> > -	next = vma_next(&vmi);
> > -	prev = vma_prev(&vmi);
> > +	next = vmg.next = vma_next(&vmi);
> > +	prev = vmg.prev = vma_prev(&vmi);
> >  	if (vm_flags & VM_SPECIAL) {
> >  		if (prev)
> >  			vma_iter_next_range(&vmi);
> > @@ -1416,29 +1423,30 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  	/* Attempt to expand an old mapping */
> >  	/* Check next */
> >  	if (next && next->vm_start == end && !vma_policy(next) &&
> > -	    can_vma_merge_before(next, vm_flags, NULL, file, pgoff+pglen,
> > -				 NULL_VM_UFFD_CTX, NULL)) {
> > +	    can_vma_merge_before(&vmg)) {
> >  		merge_end = next->vm_end;
> >  		vma = next;
> > -		vm_pgoff = next->vm_pgoff - pglen;
> > +		vmg.pgoff = next->vm_pgoff - pglen;
> > +	}
> > +
> > +	if (vma) {
> > +		vmg.anon_vma = vma->anon_vma;
> > +		vmg.uffd_ctx = vma->vm_userfaultfd_ctx;
> >  	}
> >
> >  	/* Check prev */
> >  	if (prev && prev->vm_end == addr && !vma_policy(prev) &&
> > -	    (vma ? can_vma_merge_after(prev, vm_flags, vma->anon_vma, file,
> > -				       pgoff, vma->vm_userfaultfd_ctx, NULL) :
> > -		   can_vma_merge_after(prev, vm_flags, NULL, file, pgoff,
> > -				       NULL_VM_UFFD_CTX, NULL))) {
> > +	    can_vma_merge_after(&vmg)) {
> >  		merge_start = prev->vm_start;
> >  		vma = prev;
> > -		vm_pgoff = prev->vm_pgoff;
> > +		vmg.pgoff = prev->vm_pgoff;
> >  	} else if (prev) {
> >  		vma_iter_next_range(&vmi);
> >  	}
> >
> >  	/* Actually expand, if possible */
> >  	if (vma &&
> > -	    !vma_expand(&vmi, vma, merge_start, merge_end, vm_pgoff, next)) {
> > +	    !vma_expand(&vmi, vma, merge_start, merge_end, vmg.pgoff, next)) {
> >  		khugepaged_enter_vma(vma, vm_flags);
> >  		goto expanded;
> >  	}
> > @@ -1790,25 +1798,31 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
> >  	 * Expand the existing vma if possible; Note that singular lists do not
> >  	 * occur after forking, so the expand will only happen on new VMAs.
> >  	 */
> > -	if (vma && vma->vm_end == addr && !vma_policy(vma) &&
> > -	    can_vma_merge_after(vma, flags, NULL, NULL,
> > -				addr >> PAGE_SHIFT, NULL_VM_UFFD_CTX, NULL)) {
> > -		vma_iter_config(vmi, vma->vm_start, addr + len);
> > -		if (vma_iter_prealloc(vmi, vma))
> > -			goto unacct_fail;
> > -
> > -		vma_start_write(vma);
> > -
> > -		init_vma_prep(&vp, vma);
> > -		vma_prepare(&vp);
> > -		vma_adjust_trans_huge(vma, vma->vm_start, addr + len, 0);
> > -		vma->vm_end = addr + len;
> > -		vm_flags_set(vma, VM_SOFTDIRTY);
> > -		vma_iter_store(vmi, vma);
> > -
> > -		vma_complete(&vp, vmi, mm);
> > -		khugepaged_enter_vma(vma, flags);
> > -		goto out;
> > +	if (vma && vma->vm_end == addr && !vma_policy(vma)) {
> > +		struct vma_merge_struct vmg = {
> > +			.prev = vma,
> > +			.flags = flags,
> > +			.pgoff = addr >> PAGE_SHIFT,
> > +		};
>
> I see that this struct here makes sense later.
>
> > +
> > +		if (can_vma_merge_after(&vmg)) {
> > +			vma_iter_config(vmi, vma->vm_start, addr + len);
> > +			if (vma_iter_prealloc(vmi, vma))
> > +				goto unacct_fail;
> > +
> > +			vma_start_write(vma);
> > +
> > +			init_vma_prep(&vp, vma);
> > +			vma_prepare(&vp);
> > +			vma_adjust_trans_huge(vma, vma->vm_start, addr + len, 0);
> > +			vma->vm_end = addr + len;
> > +			vm_flags_set(vma, VM_SOFTDIRTY);
> > +			vma_iter_store(vmi, vma);
> > +
> > +			vma_complete(&vp, vmi, mm);
> > +			khugepaged_enter_vma(vma, flags);
> > +			goto out;
> > +		}
> >  	}
> >
> >  	if (vma)
> > diff --git a/mm/vma.c b/mm/vma.c
> > index bf0546fe6eab..20c4ce7712c0 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> > @@ -7,16 +7,18 @@
> >  #include "vma_internal.h"
> >  #include "vma.h"
> >
> > -/*
> > - * If the vma has a ->close operation then the driver probably needs to release
> > - * per-vma resources, so we don't attempt to merge those if the caller indicates
> > - * the current vma may be removed as part of the merge.
> > - */
> > -static inline bool is_mergeable_vma(struct vm_area_struct *vma,
> > -		struct file *file, unsigned long vm_flags,
> > -		struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
> > -		struct anon_vma_name *anon_name, bool may_remove_vma)
> > +static inline bool is_mergeable_vma(struct vma_merge_struct *vmg, bool merge_next)
> >  {
> > +	struct vm_area_struct *vma = merge_next ? vmg->next : vmg->prev;
> > +	/*
> > +	 * If the vma has a ->close operation then the driver probably needs to
> > +	 * release per-vma resources, so we don't attempt to merge those if the
> > +	 * caller indicates the current vma may be removed as part of the merge,
> > +	 * which is the case if we are attempting to merge the next VMA into
> > +	 * this one.
> > +	 */
> > +	bool may_remove_vma = merge_next;
> > +
> >  	/*
> >  	 * VM_SOFTDIRTY should not prevent from VMA merging, if we
> >  	 * match the flags but dirty bit -- the caller should mark
> > @@ -25,15 +27,15 @@ static inline bool is_mergeable_vma(struct vm_area_struct *vma,
> >  	 * the kernel to generate new VMAs when old one could be
> >  	 * extended instead.
> >  	 */
> > -	if ((vma->vm_flags ^ vm_flags) & ~VM_SOFTDIRTY)
> > +	if ((vma->vm_flags ^ vmg->flags) & ~VM_SOFTDIRTY)
> >  		return false;
> > -	if (vma->vm_file != file)
> > +	if (vma->vm_file != vmg->file)
> >  		return false;
> >  	if (may_remove_vma && vma->vm_ops && vma->vm_ops->close)
> >  		return false;
> > -	if (!is_mergeable_vm_userfaultfd_ctx(vma, vm_userfaultfd_ctx))
> > +	if (!is_mergeable_vm_userfaultfd_ctx(vma, vmg->uffd_ctx))
> >  		return false;
> > -	if (!anon_vma_name_eq(anon_vma_name(vma), anon_name))
> > +	if (!anon_vma_name_eq(anon_vma_name(vma), vmg->anon_name))
> >  		return false;
> >  	return true;
> >  }
> > @@ -94,16 +96,16 @@ static void init_multi_vma_prep(struct vma_prepare *vp,
> >   * We assume the vma may be removed as part of the merge.
> >   */
> >  bool
> > -can_vma_merge_before(struct vm_area_struct *vma, unsigned long vm_flags,
> > -		struct anon_vma *anon_vma, struct file *file,
> > -		pgoff_t vm_pgoff, struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
> > -		struct anon_vma_name *anon_name)
> > +can_vma_merge_before(struct vma_merge_struct *vmg)
> >  {
> > -	if (is_mergeable_vma(vma, file, vm_flags, vm_userfaultfd_ctx, anon_name, true) &&
> > -	    is_mergeable_anon_vma(anon_vma, vma->anon_vma, vma)) {
> > -		if (vma->vm_pgoff == vm_pgoff)
> > +	pgoff_t pglen = PHYS_PFN(vmg->end - vmg->start);
> > +
> > +	if (is_mergeable_vma(vmg, true) &&
> > +	    is_mergeable_anon_vma(vmg->anon_vma, vmg->next->anon_vma, vmg->next)) {
> > +		if (vmg->next->vm_pgoff == vmg->pgoff + pglen)
> >  			return true;
> >  	}
> > +
> >  	return false;
> >  }
> >
> > @@ -116,18 +118,11 @@ can_vma_merge_before(struct vm_area_struct *vma, unsigned long vm_flags,
> >   *
> >   * We assume that vma is not removed as part of the merge.
> >   */
> > -bool
> > -can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
> > -		struct anon_vma *anon_vma, struct file *file,
> > -		pgoff_t vm_pgoff, struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
> > -		struct anon_vma_name *anon_name)
> > +bool can_vma_merge_after(struct vma_merge_struct *vmg)
> >  {
> > -	if (is_mergeable_vma(vma, file, vm_flags, vm_userfaultfd_ctx, anon_name, false) &&
> > -	    is_mergeable_anon_vma(anon_vma, vma->anon_vma, vma)) {
> > -		pgoff_t vm_pglen;
> > -
> > -		vm_pglen = vma_pages(vma);
> > -		if (vma->vm_pgoff + vm_pglen == vm_pgoff)
> > +	if (is_mergeable_vma(vmg, false) &&
> > +	    is_mergeable_anon_vma(vmg->anon_vma, vmg->prev->anon_vma, vmg->prev)) {
> > +		if (vmg->prev->vm_pgoff + vma_pages(vmg->prev) == vmg->pgoff)
> >  			return true;
> >  	}
> >  	return false;
> > @@ -180,7 +175,7 @@ void unmap_region(struct mm_struct *mm, struct ma_state *mas,
> >   * VMA Iterator will point to the end VMA.
> >   */
> >  static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
> > -		       unsigned long addr, int new_below)
> > +		       unsigned long addr, bool new_below)
> >  {
> >  	struct vma_prepare vp;
> >  	struct vm_area_struct *new;
> > @@ -261,13 +256,14 @@ static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
> >   * Split a vma into two pieces at address 'addr', a new vma is allocated
> >   * either for the first part or the tail.
> >   */
> > -static int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
> > -		     unsigned long addr, int new_below)
> > +static int split_vma(struct vma_merge_struct *vmg, bool new_below)
> >  {
> > -	if (vma->vm_mm->map_count >= sysctl_max_map_count)
> > +	if (vmg->vma->vm_mm->map_count >= sysctl_max_map_count)
> >  		return -ENOMEM;
> >
> > -	return __split_vma(vmi, vma, addr, new_below);
> > +	return __split_vma(vmg->vmi, vmg->vma,
> > +			   new_below ? vmg->start : vmg->end,
> > +			   new_below);
>
> Why did this get worse?
> Maybe split the __split_vma changes out of this patch?  I mean, split is
> used for more than just merging, it's used for unmapping as well.
> Changing argument types in __split_vma() seems unrelated to the main
> focus of this patch.
>

Yeah on second thoughts, this isn't an improvement, I'll revert this part
of the change.

This was mostly me trying to thread it through as much as possible, but in
the split_vma() case (note I don't touch __split_vma()) it doesn't make as
much sense.

> >  }
> >
> >  /*
> > @@ -712,7 +708,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
> >  		if (end < vma->vm_end && mm->map_count >= sysctl_max_map_count)
> >  			goto map_count_exceeded;
> >
> > -		error = __split_vma(vmi, vma, start, 1);
> > +		error = __split_vma(vmi, vma, start, true);
> >  		if (error)
> >  			goto start_split_failed;
> >  	}
> > @@ -725,7 +721,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
> >  	do {
> >  		/* Does it split the end? */
> >  		if (next->vm_end > end) {
> > -			error = __split_vma(vmi, next, end, 0);
> > +			error = __split_vma(vmi, next, end, false);
> >  			if (error)
> >  				goto end_split_failed;
> >  		}
> > @@ -934,16 +930,10 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
> >   * **** is not represented - it will be merged and the vma containing the
> >   *      area is returned, or the function will return NULL
> >   */
> > -static struct vm_area_struct
> > -*vma_merge(struct vma_iterator *vmi, struct vm_area_struct *prev,
> > -	   struct vm_area_struct *src, unsigned long addr, unsigned long end,
> > -	   unsigned long vm_flags, pgoff_t pgoff, struct mempolicy *policy,
> > -	   struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
> > -	   struct anon_vma_name *anon_name)
> > +static struct vm_area_struct *vma_merge(struct vma_merge_struct *vmg)
> >  {
> > -	struct mm_struct *mm = src->vm_mm;
> > -	struct anon_vma *anon_vma = src->anon_vma;
> > -	struct file *file = src->vm_file;
> > +	struct mm_struct *mm = container_of(vmg->vmi->mas.tree, struct mm_struct, mm_mt);
>
> No.  current->mm is way better, or put it in that vmg thing.

Ack will use current->mm. This is at least temporary as I drop vma_merge()
altogether later.

>
> > +	struct vm_area_struct *prev = vmg->prev;
> >  	struct vm_area_struct *curr, *next, *res;
> >  	struct vm_area_struct *vma, *adjust, *remove, *remove2;
> >  	struct vm_area_struct *anon_dup = NULL;
> > @@ -953,16 +943,18 @@ static struct vm_area_struct
> >  	bool merge_prev = false;
> >  	bool merge_next = false;
> >  	bool vma_expanded = false;
> > +	unsigned long addr = vmg->start;
> > +	unsigned long end = vmg->end;
> >  	unsigned long vma_start = addr;
> >  	unsigned long vma_end = end;
> > -	pgoff_t pglen = (end - addr) >> PAGE_SHIFT;
> > +	pgoff_t pglen = PHYS_PFN(end - addr);
> >  	long adj_start = 0;
> >
> >  	/*
> >  	 * We later require that vma->vm_flags == vm_flags,
> >  	 * so this tests vma->vm_flags & VM_SPECIAL, too.
> >  	 */
> > -	if (vm_flags & VM_SPECIAL)
> > +	if (vmg->flags & VM_SPECIAL)
> >  		return NULL;
> >
> >  	/* Does the input range span an existing VMA? (cases 5 - 8) */
> > @@ -970,27 +962,26 @@ static struct vm_area_struct
> >
> >  	if (!curr ||			/* cases 1 - 4 */
> >  	    end == curr->vm_end)	/* cases 6 - 8, adjacent VMA */
> > -		next = vma_lookup(mm, end);
> > +		next = vmg->next = vma_lookup(mm, end);
> >  	else
> > -		next = NULL;		/* case 5 */
> > +		next = vmg->next = NULL;	/* case 5 */
> >
> >  	if (prev) {
> >  		vma_start = prev->vm_start;
> >  		vma_pgoff = prev->vm_pgoff;
> >
> >  		/* Can we merge the predecessor? */
> > -		if (addr == prev->vm_end && mpol_equal(vma_policy(prev), policy)
> > -		    && can_vma_merge_after(prev, vm_flags, anon_vma, file,
> > -					   pgoff, vm_userfaultfd_ctx, anon_name)) {
> > +		if (addr == prev->vm_end && mpol_equal(vma_policy(prev), vmg->policy)
> > +		    && can_vma_merge_after(vmg)) {
> > +
> >  			merge_prev = true;
> > -			vma_prev(vmi);
> > +			vma_prev(vmg->vmi);
> >  		}
> >  	}
> >
> >  	/* Can we merge the successor? */
> > -	if (next && mpol_equal(policy, vma_policy(next)) &&
> > -	    can_vma_merge_before(next, vm_flags, anon_vma, file, pgoff+pglen,
> > -				 vm_userfaultfd_ctx, anon_name)) {
> > +	if (next && mpol_equal(vmg->policy, vma_policy(next)) &&
> > +	    can_vma_merge_before(vmg)) {
> >  		merge_next = true;
> >  	}
> >
> > @@ -1041,7 +1032,7 @@ static struct vm_area_struct
> >  				remove = curr;
> >  			} else {			/* case 5 */
> >  				adjust = curr;
> > -				adj_start = (end - curr->vm_start);
> > +				adj_start = end - curr->vm_start;
> >  			}
> >  			if (!err)
> >  				err = dup_anon_vma(prev, curr, &anon_dup);
> > @@ -1081,13 +1072,13 @@ static struct vm_area_struct
> >  		vma_expanded = true;
> >
> >  	if (vma_expanded) {
> > -		vma_iter_config(vmi, vma_start, vma_end);
> > +		vma_iter_config(vmg->vmi, vma_start, vma_end);
> >  	} else {
> > -		vma_iter_config(vmi, adjust->vm_start + adj_start,
> > +		vma_iter_config(vmg->vmi, adjust->vm_start + adj_start,
> >  				adjust->vm_end);
> >  	}
> >
> > -	if (vma_iter_prealloc(vmi, vma))
> > +	if (vma_iter_prealloc(vmg->vmi, vma))
> >  		goto prealloc_fail;
> >
> >  	init_multi_vma_prep(&vp, vma, adjust, remove, remove2);
> > @@ -1099,19 +1090,19 @@ static struct vm_area_struct
> >  	vma_set_range(vma, vma_start, vma_end, vma_pgoff);
> >
> >  	if (vma_expanded)
> > -		vma_iter_store(vmi, vma);
> > +		vma_iter_store(vmg->vmi, vma);
> >
> >  	if (adj_start) {
> >  		adjust->vm_start += adj_start;
> >  		adjust->vm_pgoff += adj_start >> PAGE_SHIFT;
> >  		if (adj_start < 0) {
> >  			WARN_ON(vma_expanded);
> > -			vma_iter_store(vmi, next);
> > +			vma_iter_store(vmg->vmi, next);
> >  		}
> >  	}
> >
> > -	vma_complete(&vp, vmi, mm);
> > -	khugepaged_enter_vma(res, vm_flags);
> > +	vma_complete(&vp, vmg->vmi, mm);
> > +	khugepaged_enter_vma(res, vmg->flags);
> >  	return res;
> >
> >  prealloc_fail:
> > @@ -1119,8 +1110,8 @@ static struct vm_area_struct
> >  		unlink_anon_vmas(anon_dup);
> >
> >  anon_vma_fail:
> > -	vma_iter_set(vmi, addr);
> > -	vma_iter_load(vmi);
> > +	vma_iter_set(vmg->vmi, addr);
> > +	vma_iter_load(vmg->vmi);
> >  	return NULL;
> >  }
> >
> > @@ -1137,38 +1128,141 @@ static struct vm_area_struct
> >   * The function returns either the merged VMA, the original VMA if a split was
> >   * required instead, or an error if the split failed.
> >   */
> > -struct vm_area_struct *vma_modify(struct vma_iterator *vmi,
> > -				  struct vm_area_struct *prev,
> > -				  struct vm_area_struct *vma,
> > -				  unsigned long start, unsigned long end,
> > -				  unsigned long vm_flags,
> > -				  struct mempolicy *policy,
> > -				  struct vm_userfaultfd_ctx uffd_ctx,
> > -				  struct anon_vma_name *anon_name)
> > +static struct vm_area_struct *vma_modify(struct vma_merge_struct *vmg)
> >  {
> > -	pgoff_t pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
> > +	struct vm_area_struct *vma = vmg->vma;
> >  	struct vm_area_struct *merged;
> >
> > -	merged = vma_merge(vmi, prev, vma, start, end, vm_flags,
> > -			   pgoff, policy, uffd_ctx, anon_name);
> > +	/* First, try to merge. */
> > +	merged = vma_merge(vmg);
> >  	if (merged)
> >  		return merged;
> >
> > -	if (vma->vm_start < start) {
> > -		int err = split_vma(vmi, vma, start, 1);
> > +	/* Split any preceding portion of the VMA. */
> > +	if (vma->vm_start < vmg->start) {
> > +		int err = split_vma(vmg, true);
> >
> >  		if (err)
> >  			return ERR_PTR(err);
> >  	}
> >
> > -	if (vma->vm_end > end) {
> > -		int err = split_vma(vmi, vma, end, 0);
> > +	/* Split any trailing portion of the VMA. */
> > +	if (vma->vm_end > vmg->end) {
> > +		int err = split_vma(vmg, false);
> >
> >  		if (err)
> >  			return ERR_PTR(err);
> >  	}
> >
> > -	return vma;
> > +	return vmg->vma;
> > +}
> > +
> > +/* Assumes addr >= vma->vm_start. */
> > +static pgoff_t vma_pgoff_offset(struct vm_area_struct *vma, unsigned long addr)
> > +{
> > +	return vma->vm_pgoff + PHYS_PFN(addr - vma->vm_start);
> > +}
> > +
>
> Could we do something like the MA_STATE() in the maple_tree.h for the
> below?

Yeah Vlasta suggested the same thing, the main sticking point is that
parameters vary slightly, but I think we can probably rely on the compiler
to handle something like:

struct vma_merge_struct vmg = VMG_STATE(vmi, prev, vma);

vmg.flags = new_flags;

>
> > +struct vm_area_struct *vma_modify_flags(struct vma_iterator *vmi,
> > +					struct vm_area_struct *prev,
> > +					struct vm_area_struct *vma,
> > +					unsigned long start, unsigned long end,
> > +					unsigned long new_flags)
> > +{
> > +	struct vma_merge_struct vmg = {
> > +		.vmi = vmi,
> > +		.prev = prev,
> > +		.vma = vma,
> > +		.start = start,
> > +		.end = end,
> > +		.flags = new_flags,
> > +		.pgoff = vma_pgoff_offset(vma, start),
> > +		.file = vma->vm_file,
> > +		.anon_vma = vma->anon_vma,
> > +		.policy = vma_policy(vma),
> > +		.uffd_ctx = vma->vm_userfaultfd_ctx,
> > +		.anon_name = anon_vma_name(vma),
> > +	};
> > +
> > +	return vma_modify(&vmg);
> > +}
> > +
> > +struct vm_area_struct
> > +*vma_modify_flags_name(struct vma_iterator *vmi,
> > +		       struct vm_area_struct *prev,
> > +		       struct vm_area_struct *vma,
> > +		       unsigned long start,
> > +		       unsigned long end,
> > +		       unsigned long new_flags,
> > +		       struct anon_vma_name *new_name)
> > +{
> > +	struct vma_merge_struct vmg = {
> > +		.vmi = vmi,
> > +		.prev = prev,
> > +		.vma = vma,
> > +		.start = start,
> > +		.end = end,
> > +		.flags = new_flags,
> > +		.pgoff = vma_pgoff_offset(vma, start),
> > +		.file = vma->vm_file,
> > +		.anon_vma = vma->anon_vma,
> > +		.policy = vma_policy(vma),
> > +		.uffd_ctx = vma->vm_userfaultfd_ctx,
> > +		.anon_name = new_name,
> > +	};
> > +
> > +	return vma_modify(&vmg);
> > +}
> > +
> > +struct vm_area_struct
> > +*vma_modify_policy(struct vma_iterator *vmi,
> > +		   struct vm_area_struct *prev,
> > +		   struct vm_area_struct *vma,
> > +		   unsigned long start, unsigned long end,
> > +		   struct mempolicy *new_pol)
> > +{
> > +	struct vma_merge_struct vmg = {
> > +		.vmi = vmi,
> > +		.prev = prev,
> > +		.vma = vma,
> > +		.start = start,
> > +		.end = end,
> > +		.flags = vma->vm_flags,
> > +		.pgoff = vma_pgoff_offset(vma, start),
> > +		.file = vma->vm_file,
> > +		.anon_vma = vma->anon_vma,
> > +		.policy = new_pol,
> > +		.uffd_ctx = vma->vm_userfaultfd_ctx,
> > +		.anon_name = anon_vma_name(vma),
> > +	};
> > +
> > +	return vma_modify(&vmg);
> > +}
> > +
> > +struct vm_area_struct
> > +*vma_modify_flags_uffd(struct vma_iterator *vmi,
> > +		       struct vm_area_struct *prev,
> > +		       struct vm_area_struct *vma,
> > +		       unsigned long start, unsigned long end,
> > +		       unsigned long new_flags,
> > +		       struct vm_userfaultfd_ctx new_ctx)
> > +{
> > +	struct vma_merge_struct vmg = {
> > +		.vmi = vmi,
> > +		.prev = prev,
> > +		.vma = vma,
> > +		.start = start,
> > +		.end = end,
> > +		.flags = new_flags,
> > +		.file = vma->vm_file,
> > +		.anon_vma = vma->anon_vma,
> > +		.pgoff = vma_pgoff_offset(vma, start),
> > +		.policy = vma_policy(vma),
> > +		.uffd_ctx = new_ctx,
> > +		.anon_name = anon_vma_name(vma),
> > +	};
> > +
> > +	return vma_modify(&vmg);
> >  }
> >
> >  /*
> > @@ -1180,8 +1274,22 @@ struct vm_area_struct
> >  		   struct vm_area_struct *vma, unsigned long start,
> >  		   unsigned long end, pgoff_t pgoff)
> >  {
> > -	return vma_merge(vmi, prev, vma, start, end, vma->vm_flags, pgoff,
> > -			 vma_policy(vma), vma->vm_userfaultfd_ctx, anon_vma_name(vma));
> > +	struct vma_merge_struct vmg = {
> > +		.vmi = vmi,
> > +		.prev = prev,
> > +		.vma = vma,
> > +		.start = start,
> > +		.end = end,
> > +		.flags = vma->vm_flags,
> > +		.file = vma->vm_file,
> > +		.anon_vma = vma->anon_vma,
> > +		.pgoff = pgoff,
> > +		.policy = vma_policy(vma),
> > +		.uffd_ctx = vma->vm_userfaultfd_ctx,
> > +		.anon_name = anon_vma_name(vma),
> > +	};
> > +
> > +	return vma_merge(&vmg);
> >  }
> >
> >  /*
> > @@ -1193,11 +1301,22 @@ struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
> >  					unsigned long delta)
> >  {
> >  	pgoff_t pgoff = vma->vm_pgoff + vma_pages(vma);
> > +	struct vma_merge_struct vmg = {
> > +		.vmi = vmi,
> > +		.prev = vma,
> > +		.vma = vma,
> > +		.start = vma->vm_end,
> > +		.end = vma->vm_end + delta,
> > +		.flags = vma->vm_flags,
> > +		.file = vma->vm_file,
> > +		.pgoff = pgoff,
> > +		.policy = vma_policy(vma),
> > +		.uffd_ctx = vma->vm_userfaultfd_ctx,
> > +		.anon_name = anon_vma_name(vma),
> > +	};
> >
> >  	/* vma is specified as prev, so case 1 or 2 will apply. */
> > -	return vma_merge(vmi, vma, vma, vma->vm_end, vma->vm_end + delta,
> > -			 vma->vm_flags, pgoff, vma_policy(vma),
> > -			 vma->vm_userfaultfd_ctx, anon_vma_name(vma));
> > +	return vma_merge(&vmg);
> >  }
> >
> >  void unlink_file_vma_batch_init(struct unlink_vma_file_batch *vb)
> > diff --git a/mm/vma.h b/mm/vma.h
> > index 6efdf1768a0a..c31684cc1da6 100644
> > --- a/mm/vma.h
> > +++ b/mm/vma.h
> > @@ -26,6 +26,23 @@ struct unlink_vma_file_batch {
> >  	struct vm_area_struct *vmas[8];
> >  };
> >
> > +/* Represents a VMA merge operation. */
> > +struct vma_merge_struct {
> > +	struct vma_iterator *vmi;
> > +	struct vm_area_struct *prev;
> > +	struct vm_area_struct *next; /* Modified by vma_merge(). */
> > +	struct vm_area_struct *vma; /* Either a new VMA or the one being modified. */
> > +	unsigned long start;
> > +	unsigned long end;
> > +	unsigned long flags;
> > +	pgoff_t pgoff;
> > +	struct file *file;
> > +	struct anon_vma *anon_vma;
> > +	struct mempolicy *policy;
> > +	struct vm_userfaultfd_ctx uffd_ctx;
> > +	struct anon_vma_name *anon_name;
> > +};
> > +
> >  #ifdef CONFIG_DEBUG_VM_MAPLE_TREE
> >  void validate_mm(struct mm_struct *mm);
> >  #else
> > @@ -72,80 +89,53 @@ void unmap_region(struct mm_struct *mm, struct ma_state *mas,
> >  		struct vm_area_struct *next, unsigned long start,
> >  		unsigned long end, unsigned long tree_end, bool mm_wr_locked);
> >
> > -/* Required by mmap_region(). */
> > -bool
> > -can_vma_merge_before(struct vm_area_struct *vma, unsigned long vm_flags,
> > -		struct anon_vma *anon_vma, struct file *file,
> > -		pgoff_t vm_pgoff, struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
> > -		struct anon_vma_name *anon_name);
> > -
> > -/* Required by mmap_region() and do_brk_flags(). */
> > -bool
> > -can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
> > -		struct anon_vma *anon_vma, struct file *file,
> > -		pgoff_t vm_pgoff, struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
> > -		struct anon_vma_name *anon_name);
> > -
> > -struct vm_area_struct *vma_modify(struct vma_iterator *vmi,
> > -				  struct vm_area_struct *prev,
> > -				  struct vm_area_struct *vma,
> > -				  unsigned long start, unsigned long end,
> > -				  unsigned long vm_flags,
> > -				  struct mempolicy *policy,
> > -				  struct vm_userfaultfd_ctx uffd_ctx,
> > -				  struct anon_vma_name *anon_name);
> > +/*
> > + * Can we merge the VMA described by vmg into the following VMA vmg->next?
> > + *
> > + * Required by mmap_region().
> > + */
> > +bool can_vma_merge_before(struct vma_merge_struct *vmg);
> > +
> > +/*
> > + * Can we merge the VMA described by vmg into the preceding VMA vmg->prev?
> > + *
> > + * Required by mmap_region() and do_brk_flags().
> > + */
> > +bool can_vma_merge_after(struct vma_merge_struct *vmg);
> >
> >  /* We are about to modify the VMA's flags. */
> > -static inline struct vm_area_struct
> > -*vma_modify_flags(struct vma_iterator *vmi,
> > -		  struct vm_area_struct *prev,
> > -		  struct vm_area_struct *vma,
> > -		  unsigned long start, unsigned long end,
> > -		  unsigned long new_flags)
> > -{
> > -	return vma_modify(vmi, prev, vma, start, end, new_flags,
> > -			  vma_policy(vma), vma->vm_userfaultfd_ctx,
> > -			  anon_vma_name(vma));
> > -}
> > +struct vm_area_struct *vma_modify_flags(struct vma_iterator *vmi,
> > +					struct vm_area_struct *prev,
> > +					struct vm_area_struct *vma,
> > +					unsigned long start, unsigned long end,
> > +					unsigned long new_flags);
>
> Functions with insane number of arguments can be written like this:
>
> struct vm_area_struct *vma_modify_flags(struct vma_iterator *vmi,
> 		struct vm_area_struct *prev, struct vm_area_struct,
> 		*vma, unsigned long start, unsigned long end,
> 		unsigned long new_flags);
>
> The advantage is that more of the insane arguments are on the same line,
> and if the name changes it will limit the impact.

Ack will adjust

>
> >
> >  /* We are about to modify the VMA's flags and/or anon_name. */
> > -static inline struct vm_area_struct
> > +struct vm_area_struct
> >  *vma_modify_flags_name(struct vma_iterator *vmi,
> >  		       struct vm_area_struct *prev,
> >  		       struct vm_area_struct *vma,
> >  		       unsigned long start,
> >  		       unsigned long end,
> >  		       unsigned long new_flags,
> > -		       struct anon_vma_name *new_name)
> > -{
> > -	return vma_modify(vmi, prev, vma, start, end, new_flags,
> > -			  vma_policy(vma), vma->vm_userfaultfd_ctx, new_name);
> > -}
> > +		       struct anon_vma_name *new_name);
> >
> >  /* We are about to modify the VMA's memory policy. */
> > -static inline struct vm_area_struct
> > +struct vm_area_struct
> >  *vma_modify_policy(struct vma_iterator *vmi,
> >  		   struct vm_area_struct *prev,
> >  		   struct vm_area_struct *vma,
> >  		   unsigned long start, unsigned long end,
> > -		   struct mempolicy *new_pol)
> > -{
> > -	return vma_modify(vmi, prev, vma, start, end, vma->vm_flags,
> > -			  new_pol, vma->vm_userfaultfd_ctx, anon_vma_name(vma));
> > -}
> > +		   struct mempolicy *new_pol);
> >
> >  /* We are about to modify the VMA's flags and/or uffd context. */
> > -static inline struct vm_area_struct
> > +struct vm_area_struct
> >  *vma_modify_flags_uffd(struct vma_iterator *vmi,
> >  		       struct vm_area_struct *prev,
> >  		       struct vm_area_struct *vma,
> >  		       unsigned long start, unsigned long end,
> >  		       unsigned long new_flags,
> > -		       struct vm_userfaultfd_ctx new_ctx)
> > -{
> > -	return vma_modify(vmi, prev, vma, start, end, new_flags,
> > -			  vma_policy(vma), new_ctx, anon_vma_name(vma));
> > -}
> > +		       struct vm_userfaultfd_ctx new_ctx);
> >
> >  struct vm_area_struct
> >  *vma_merge_new_vma(struct vma_iterator *vmi, struct vm_area_struct *prev,
> > --
> > 2.45.2
> >

