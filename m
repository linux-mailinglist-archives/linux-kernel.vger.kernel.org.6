Return-Path: <linux-kernel+bounces-295577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0D2959E83
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 863C9282303
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591B9199FA9;
	Wed, 21 Aug 2024 13:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iX0w4xlj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ke7PZKAq"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAF918C915
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 13:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724246342; cv=fail; b=GiLTRSQa5bnftZInhBEFJCipncEBq1breVxMnLS6ZXgpAc29qP5aYIm2/qYFlxDNDUwqC+J8I8sKHUlqDO6DAew8x6Ldp4XoHLh7PZ6pzKQpL6pq+Ntij12iAOYa3n1fxTf/Si0WES1PjeuP+sbtw69jjdKR/NAcnANaGtsmCNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724246342; c=relaxed/simple;
	bh=ToEVn32njvcjTAoowKiWP6pzOtlC7cIXZAlGAeXthJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AlBKl+cQOSwJePB+DkB6sWvsYm3cTsZ9CX6Nv/6JGCwKPslccn31JyX4pbBPwhWBM2MQtrSiw7zYUvLwwmRmdYoTzHNnKnvmD1giTLxQdL078WVKtZZ5+q4gSmGeqv0v7oE6yKD+/PhOTKxuXbyyhXFtbi50PN2qgSnz45Rcx78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iX0w4xlj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ke7PZKAq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47LDIY75007018;
	Wed, 21 Aug 2024 13:18:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=K4VKMn9TKb1TLt5
	kHUf22op3OCVvDTtSI9tACNtjC5U=; b=iX0w4xljHJYuPYzla5h3ge5U/dGSeal
	zWq7VLEZxZ4b8L/vDvdKxXRnfqTcsLAzG7Qzbxy7lpsV6pNRpJ/APkTIfJy/fFx4
	mDBgw/tz00x25qCZlYXnzOqsiROXJeFOEwodkwCFrhJt7CZvdRwZ3kyZEmfLO9Rn
	5fVZbg4ml3ml7QxfhGlh7aALklJvjwJjTF+HSHv0OX9mB1IOycystVJ9I6906thE
	HU14AoomPYscj9xjH8CjG+uVlPzOzPn/rfftn3bu6AlWlMHPaVZW2hUjWEBcqaIO
	V0zUUYhKMX/lKMni2FiS3qT/EQrtiDpGuThyMOXxlbniZbqSDDsfLWA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m4uyg2h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 13:18:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47LCgl1e016261;
	Wed, 21 Aug 2024 13:18:44 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 415gg11b4g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 13:18:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UBbOvF1oGoLqSlJWkd4BmB03buRv7Q9nB8rHze93zas8Dct4+qtpou//woTJfxLTXlzKYtx384ewNSTYxBQBPQ9AbXDfFQswZiCQKgBxaaY0+2pxGwcoiJpKgYZE998FJQ5q7VysjIsyfUkRITMeFegInVfhUGn9XjwcRv/z+XBbCzIkrbUhugLtABQP+YW9WRPSgYvWWd9VjW1reQ49ZQ9ap/zwx1JiqIfzyLIs/sb324po65p8vgfMVIfr0bMdmdQ57D9xaGDzHcIc9sG9ewXvM2i7OPONR43BOd6sbaBXWPqEpYMSeZgX9PpXw5M8GqD5+47zEhcehfxuWxTnfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K4VKMn9TKb1TLt5kHUf22op3OCVvDTtSI9tACNtjC5U=;
 b=TrOHQJwESU65iKYyA03Fm720AG2AhJLjlOnl9D2gxheS1e6NOU16pB3/pqr7cneLBORRIwt92+sucn9GFr+uzcd+KTvyYBpHgOp6kAnMzDbYXxbgOAbUS0wdrhKMw9J6KPRlCZDAg2TFToMgKytKGwRrwQdMZWs1jr8yl1TBmCH4Du+jh092THB7zpcN0NdUXuQfIFB0xnjUwViZdYKa1LKFwh1sKYtZ3Hk1HwmBg968MWI+L5AjLFfDPfi1yDswEa0iWXm25DleIdIQ8ydI9QD/v5ELchPy0EMCtYhVX/IfClQFeUgquf/JI8KO/Y8xL/j5eCKkigv9Erd/XzjgXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4VKMn9TKb1TLt5kHUf22op3OCVvDTtSI9tACNtjC5U=;
 b=Ke7PZKAqqh4g6amu11ukK/VX8MAf2TMrUzDrtHH5PFWmeLKNnijOK9gZ/I3+Zgt16w4Ejq29OusAJUYntU1knSexVgoU1aGmghF9897g96TkuwpWGxn21gUOPOx8fX8309iiB/9pWLydiNZXlF7xITuW5NpHZHC/anDfBgdKs8g=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SJ0PR10MB4782.namprd10.prod.outlook.com (2603:10b6:a03:2dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.10; Wed, 21 Aug
 2024 13:18:40 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 13:18:40 +0000
Date: Wed, 21 Aug 2024 09:18:38 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v6 10/20] mm/vma: Support vma == NULL in init_vma_munmap()
Message-ID: <kehvclm33n56d2bxugbpmwgqrtxsdzkfjnlzlknqnveqpl3ndm@6l2o5rjseb5b>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, sidhartha.kumar@oracle.com, 
	Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>, 
	"Paul E . McKenney" <paulmck@kernel.org>
References: <20240820235730.2852400-1-Liam.Howlett@oracle.com>
 <20240820235730.2852400-11-Liam.Howlett@oracle.com>
 <26331945-9801-4af4-8e10-86992df0e3e3@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26331945-9801-4af4-8e10-86992df0e3e3@lucifer.local>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4P288CA0095.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::29) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SJ0PR10MB4782:EE_
X-MS-Office365-Filtering-Correlation-Id: e5cf199c-2cdc-4b52-9496-08dcc1e3c615
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KovoNf2+E24uy4jFQdPd3o/dPmmqosQS1YM5y/YNINUKxcUnGeGZHe7Zr0Iz?=
 =?us-ascii?Q?nD8KTzX1shPKx+LX8DBpktoZ5JIf1PWWzKfA0iqmoGZCZiVd68zstbJ3Vr65?=
 =?us-ascii?Q?qQmz/4683kCqcLzGZmswGDpAeH7z44kPVHoFs5pCDkl/TWrZ1thCRD/v620G?=
 =?us-ascii?Q?nWkH92EnNUZKqZW9kH7QbkWfDZrvLm/AZplaX24VJaoDVqXy8A4L46kw9pms?=
 =?us-ascii?Q?0KN8S3abnmxO56W6531tVRlHJy8Krzd5rywu3DIekUEJq7cOJlUDQLx9iLQY?=
 =?us-ascii?Q?aUgpsm8NgT5kT852e/TeUIjMpVp9d3KOmHpbtvTStjRFAgFePtG9j38gg0pA?=
 =?us-ascii?Q?ARrk00XBmmD4f8K3cDCswVyk62uMObU2JtPxvMWF8o9JcQZrHX9ugtPFaTXy?=
 =?us-ascii?Q?Y33S5NNcPybHJt3Qs3uHCw1Lkw3dX0ekb1VpnQp1EoFq4BdlaETg1MX5tC42?=
 =?us-ascii?Q?4jVN2Y6klHQii6LXEWX/NyxS69sb5Nrku7xqzJVBmsWuODwjthIz3VRjtzFV?=
 =?us-ascii?Q?dqLoMvxsNmTbpeGHOFXQFMU19/egfjkgJdpPgAnL7k98l5nehEJaDLLJ0/fr?=
 =?us-ascii?Q?5KsauRnABh4efYITRR7gUBzC4IEHFxYFvQgUkBEq1aTIcybUA+TZFU26xzR7?=
 =?us-ascii?Q?9tYD5O8ZXSEvYp/HNpbfsPZ64B4drdEVMi10UwftoIrhBnIsZivKQynSKrie?=
 =?us-ascii?Q?XpPxZOEOlPx32gUIP2rjg9tyaXVH1ctNvuCdD+D+hq9HUNrhDTS7sLM7QqaR?=
 =?us-ascii?Q?maEX5YVGIm9Ch2k93oALjDhV4GL6UG6Lhb31r383smrjE5yIIG/yC8jbrFH0?=
 =?us-ascii?Q?91Vl+T3bI/lG6Dpqz40BaEclh7vByvgZOZiK9SR2YnYwdfomNC4t8jgeJE0r?=
 =?us-ascii?Q?FAR3SZgY1ODmmae/IAfpgxp1qppi4s29v7C7t2BPfiyCR/sRWe9bGT6HxmaQ?=
 =?us-ascii?Q?YF51WdSAlPPsqjCltvTHDXkzoRQRaq/m8eNhiU/bxmk4EKIWqByAZRuksc89?=
 =?us-ascii?Q?s/H8efCNOIOYOcjJEunztDGKCvYOsssP8AYS9/iGXrIM1P8AHR5eg7LKPvOO?=
 =?us-ascii?Q?y0B7oDuvaBhQN6yhwFQeznywtOqp05wo++q5dOw2OV/V/6FkhC6giKCERZyj?=
 =?us-ascii?Q?yjUFqE690IEfBsZ1CnwfLUH9kn2y1zS8C8ZiOl2l5Lik3+zM1CVkrD8GGsQ1?=
 =?us-ascii?Q?UypyzQ56uJRl9OkjOyMRMTYAjQTrECBzxiBquyF28cI9tmT4yFXAbQt0xuTw?=
 =?us-ascii?Q?wZROkZDOyqp3vTNV9e2tKhaN4WSi+qlfaAPZEtT434ny2rBAwfAOiePZP5jF?=
 =?us-ascii?Q?nMi5WUXA5ozBOJwiaDzNmCjr5r1XKgHIGR6I6U12bMoWYQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1zwfX9y7+3umfh4dFP3mFH8+zw65pYZA0fCfdLLlNKvGIIpyRS+ZNUQpQ8at?=
 =?us-ascii?Q?eUOlmpJF6SNTBJEOOese+Ch8+wcfynTpBAGWoq3NZvGTYU7TRiZsQNRmUFFa?=
 =?us-ascii?Q?0srxFaORzB1Wt7MrQkkxcvB0VXwUf8vakl0y5o1vQVj158ErGi0O165ntr2M?=
 =?us-ascii?Q?R8HwKE7Ey/yiYFSUv8QMlDWOfcWzzqTQgwa8KtpRPYpZzuJ8/0vi2Eq5OHzM?=
 =?us-ascii?Q?U3ypL4WnF7oyIl6AMY/Cz3iRLDadHLZhhgLcRZmLkW+ABFL9sH4ZCO4Nbjfn?=
 =?us-ascii?Q?3qRGRW086I2wk2E04GU0X7OJtmHJ87TIfoIh2qi6t7UT3zteXpO5oiiNnHk8?=
 =?us-ascii?Q?CTL0PFAcfAiEiXsKJicfQvm/BtabjYXiLaiX70RSJVMRicdLQHNHzU+5vRT8?=
 =?us-ascii?Q?lsnVQGR29eO8LXTJWE8fDqlBKmXEzQXoxHpcqA/nDr0ZQMLFB4ovYwfGseSF?=
 =?us-ascii?Q?QNeuVeJEPXTs077EERl9zdp0guiJ4Y8KhG5nJYBwPFfd8FAHXqSIstYerDl1?=
 =?us-ascii?Q?gGT7VqzdlK/VOyQs1HOsbrYvx+HlZxHmWj7hL3tGPDAa6w6iAR758OviHScw?=
 =?us-ascii?Q?moacVzaR+Ro2FZykEqX60OADG1G5YxeqXObXd2FiE143kZu3cBqUtbfpwHJp?=
 =?us-ascii?Q?2fU5S2gI/vAYGBw1fKA7Ds+HyrMHN+D/79W+BtrXdlBVSpPfkWxp4UB6/u9X?=
 =?us-ascii?Q?l5RlRibtUF5Z41Q9D8e7VsJO4kD/oRtLPfMCcoQwNLOh4GFZqPn/8Z32lATh?=
 =?us-ascii?Q?UemTYPyaqPnJdWZ7E23NWvDXXmO8naaGhMs7lz7UQUdja8UMVsW6AqZ9Qiei?=
 =?us-ascii?Q?tT4kg8lofpQowKxGtSLch+rOduTyFTAslzgOMIFFQKTrScknzLrS2m+i5zXx?=
 =?us-ascii?Q?iiMXNHWPFWk+d89+kdKv1vP+j13XQ0BgEz92k2Vk3AOCleRF0GClVxpEq2P5?=
 =?us-ascii?Q?v1mkTbG79FVP/wQcGyCrtmAQlczkxwduYAS5N4YAuVSwrYXbtmiwGxhLIso6?=
 =?us-ascii?Q?zVL5g0CiMOhl30Qvu+LWDBScV1Te12+LiSqUH3kWjs+UmpLEX2kZFr4tEBdj?=
 =?us-ascii?Q?pn/iVuMNiBLyScZ3sF3a3zAXQTONNJJvFNmwLHvd2Zx1oC23Yk9NRy8CzmcY?=
 =?us-ascii?Q?Hpe3oUVoui76Q8KCsbx9FRC5nRz+ZNF0wNK2C6Vcpr/289z3fX1KPnO2A+5b?=
 =?us-ascii?Q?iP+dDvmFuG9I3AhzUXU2rlGeUwY57KZUmwQUg6hhhCBb1zrHX0WYpc5nSYds?=
 =?us-ascii?Q?TLVak4dg4jo9Q4/RFcWo+SxGsmWpkONyVKi6LHHmYfqNkW55L6ru/CbHa5ca?=
 =?us-ascii?Q?0QfN9V7wly2W3QalE3D6o1UGypFXCQmxL87gm3O+C5YhYBYT4szI0rUTK4Ld?=
 =?us-ascii?Q?c3JkxGswzt7t4mqrkr+kiUYbZKjIveGl2dyeAvWS13kaYCiR73GzcXg6RbIJ?=
 =?us-ascii?Q?0AZdDUGcyhvXiWE9GTImJppRcMJjImuMPdHTCfhxbIFLE8l9a1fYFztg6CXG?=
 =?us-ascii?Q?8OOpIr5ClU/g3eo4en3XsLwktHS3fCheX+Nq28ewJrubY79EsreFx2lDkjw8?=
 =?us-ascii?Q?HS89vliBgSbirpLGACS7K42/xiuiJpmHE6QHM2nzCkyk7ONf0OxIc386wy+s?=
 =?us-ascii?Q?Nw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+3FTjIFZ1eKoqPS8WE9yBYnTsBMpzphE3pCtTSAbD66v7N01ULwIHxQiaIutPC9ELYkAX6RWD+UzcKceMHufOGca7aF1LslfHMhsJDQIm2hlcllYtj+tng/tJ46B9IZDOowFRQmErG+2Y1LEBmfdZW3PtUhrjinGejkYdx9ouJNVnI3KX1h6qtfwf0lq/6z8pA4h8zmRM4XRSBH+F2xUef098usTiWnsVTql7+ELx1P1LrootdIcQQzaC8vjSS8SlQFoH4yuNpMTPpMkNwh+uHHqsQYx9MTlsHj3vgFoEQ1BUZonjfdd2Q783okw2o1RYAPIgpvLTFc/9hrSaY6EYjLPGU7E7UFyGH552cDuNTl2VQMzKbNnOb2QJoyTbLt9E+Vx7pH033sn+Va4ykb6w/x9BS0MsaH9qYxiArIO8ukPn+6/rkdeP5pX51xFcfaM077/fjDIYk6KtEwEWIELLRGQdUEUHfhrIDLKPFDp9HmhkzSjffkpNdMggvHWaKxw+BOZuasl/uujEpUd2N9sudKe/qVXk9NRb6jwPXAPqsXJ5ajkvcL5KSHyrJ8sZadEPLEOTDl3C9hqwOZ8rF/E7O9/L4gK79yVdNaP8RHxiDE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5cf199c-2cdc-4b52-9496-08dcc1e3c615
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 13:18:40.6324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fYoWWhX4co6zpSHW/yMd0tGI0ypn8spD1xgRAcYuPKn5lJmxRfs5T1jpJzOQJGuc28D6Ao58Kay/ZdU+qnLKgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4782
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_10,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408210096
X-Proofpoint-ORIG-GUID: h0LL0bVHGSNLubqTaETTuoXxo38Xq4N4
X-Proofpoint-GUID: h0LL0bVHGSNLubqTaETTuoXxo38Xq4N4

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240821 06:07]:
> On Tue, Aug 20, 2024 at 07:57:19PM GMT, Liam R. Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >
> > Adding support for a NULL vma means the init_vma_munmap() can be
> > initialized for a less error-prone process when calling
> > vms_complete_munmap_vmas() later on.
> >
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> 
> Thought I already R-b'd this :) Anyway,
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

I probably lost it in my porting of patches somehow.  Thanks

> 
> > ---
> >  mm/mmap.c |  2 +-
> >  mm/vma.h  | 11 ++++++++---
> >  2 files changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index e7e6bf09b558..2b7445a002dc 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -1393,11 +1393,11 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >
> >  	/* Find the first overlapping VMA */
> >  	vma = vma_find(&vmi, end);
> > +	init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock = */ false);
> >  	if (vma) {
> >  		mt_init_flags(&mt_detach, vmi.mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
> >  		mt_on_stack(mt_detach);
> >  		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
> > -		init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock = */ false);
> >  		/* Prepare to unmap any existing mapping in the area */
> >  		if (vms_gather_munmap_vmas(&vms, &mas_detach))
> >  			return -ENOMEM;
> > diff --git a/mm/vma.h b/mm/vma.h
> > index e78b24d1cf83..0e214bbf443e 100644
> > --- a/mm/vma.h
> > +++ b/mm/vma.h
> > @@ -95,9 +95,14 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
> >  {
> >  	vms->vmi = vmi;
> >  	vms->vma = vma;
> > -	vms->mm = vma->vm_mm;
> > -	vms->start = start;
> > -	vms->end = end;
> > +	if (vma) {
> > +		vms->mm = vma->vm_mm;
> > +		vms->start = start;
> > +		vms->end = end;
> > +	} else {
> > +		vms->mm = NULL;
> > +		vms->start = vms->end = 0;
> > +	}
> >  	vms->unlock = unlock;
> >  	vms->uf = uf;
> >  	vms->vma_count = 0;
> > --
> > 2.43.0
> >

