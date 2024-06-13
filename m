Return-Path: <linux-kernel+bounces-213481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF679075E3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDB30B232CB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C411148FFC;
	Thu, 13 Jun 2024 15:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lKNRpJ5j";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ook5TO/Y"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2B953E31
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 15:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718290877; cv=fail; b=lUpN3Zw8DRnd+DU+DgYka/E5wSz0Ih9gJ7mduoWiTBjPAiVqzjLjjJmIlWHH5Xm7OwELdDfQTeUeThPoa/fHB/ima3LBu1s2e5MJkSDaAdmEMiIVDlKHVpfgyNadeFWo4zkJrK0EZUe7vcQ2JPGp/vP1+vNxwyB4R7l9U+S6Tqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718290877; c=relaxed/simple;
	bh=+9d3zt2ujNzf8ZKSUKQWIQEnJVl+c6xsz+WZlEaIVHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SdAKW1wRshiZEsVLQO0R4kcoFpLJhrCpAyuFKPWBL0Y+FKQ3LpfTodkkmsAw3DZuzZkMJVhRab/bVmGj3mRpJCLPcCPVOQAh4E3rOpz3bRIrMwmo2Tv7BsFngfvKZ2icPyqK03fiUc4VOp3ARCTzuUWKVe4Q6Y6VlZnB06Pq11U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lKNRpJ5j; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ook5TO/Y; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45DEtOs4014982;
	Thu, 13 Jun 2024 15:01:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=0H7O8pKxwyTYBdO
	35Hs3uKZ3IbSZDJQ0UUwTZFGL7bM=; b=lKNRpJ5jNS4CL1b3CRB6gMmzuNr9oNZ
	OxSQZndMEN79kRhlTeJfr++ZT6u8ewwOKEIZe+xNuQCbDsMtwcOIxyQynjBHNRgv
	vGglWwc2V9S7LygKQOyTwpPEKsfcIlqbKlZIe6eoafaCSJ0Scz8ktm8NwbJrHz2n
	p1I5ActiPvsItobCPqtLnDGUmdl65sWnwXow40R1mCUyCZwYq6XuDWrke3zemDQ4
	aEoyC4a7FvTakTy/xzIy+pVtDLn+lmlOACeclIAvSVxVRRY0RGaTvH21HRdmZ7l/
	STDk15ogugHS5JD3gnS/XHzopsH153woN3Yt6KcpZmMLMY3pXGHnqlw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh1ghvr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 15:01:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45DEWueU019894;
	Thu, 13 Jun 2024 15:01:02 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2044.outbound.protection.outlook.com [104.47.70.44])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ync919h67-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 15:01:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AfOJ5DoXAAkrjm6oQvihSAJRYF9PtH+1YRJpRH4nMPvA+nndu/2R1E3ZCsvzW7qUXmaX81rQfEU4oCVIcwQWkXp+qz6Fdy/rLqyyHC+F11XSaIJ6DsWkxk5kvw8nlpb9ag+ceZ2ITMsRi3Fa5fLlWGblz+NNU8kpuyT9rZVGHZ951NohUOQIUTNIYNaamKEPryNFYL9fmBp8/my4sf+2Y6FhPWMtzv7FAq3VrBciaRex9X4ebawFLtZYm4+QIJUUNlNdBFOppHjKdF6+nKerSdSWilyr7YcBaq2Q8dJSrIcrugCrR3yWTkzbRqcjLyohkc21oomEKw6yD0qAtiZBbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0H7O8pKxwyTYBdO35Hs3uKZ3IbSZDJQ0UUwTZFGL7bM=;
 b=mps8i3B3N2agXHoLHIqYDdG+93eAZja96IaIHEKI801kW3753J9TRjzDlriMMpYdkkWxmi7mrynH2KOei6ScigKDCZK9wj2cA0hUQxpo4FO07sq8fyDX0X2VaafCWeIRs/hGxtv/zfo9WSZ18PnVwVwYwWBVUIBLyKWd504jEKPeXaXZtn8f7WKB1JV2fAobQ9h3BhTjyHcqzsDB7c/BjdeFMc30WxK3KZEOIdFJiwgQJjGb/00SgCqhhyUjaKROvJrsp3qcJY1ZIO9ZJNbCLi8rfRBN5/XCIP3EfGXIRim6aaMdY2byiSxJIF5Qt2Lz/rZ89V/UegX1SqjtJ5JxBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0H7O8pKxwyTYBdO35Hs3uKZ3IbSZDJQ0UUwTZFGL7bM=;
 b=Ook5TO/Yrwpqkvx8Vs8zuSnrKgy+l71FnVgMGTVN21GiWwtECVHkhqRTIj3HQsZywmewWOhv6Y8Hqfu+uNRbV32dM6GGkVTTTD8mFUuaBnqF6jCv8R2ecL2sCzQgn4YWpoviclBIuRyXlhNaPyLdv4QcYCmdUKklNVG6ZmnOt7Q=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH2PR10MB4279.namprd10.prod.outlook.com (2603:10b6:610:a8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21; Thu, 13 Jun
 2024 15:00:59 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7633.037; Thu, 13 Jun 2024
 15:00:59 +0000
Date: Thu, 13 Jun 2024 11:00:57 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, willy@infradead.org
Subject: Re: [PATCH v2 13/16] maple_tree: have mas_store() allocate nodes if
 needed
Message-ID: <jcp3owxbphfqmddfb45lmmbwrc6vc35onyqmcobhptsie7yot7@liqrbyliqjpr>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org, willy@infradead.org
References: <20240607185257.963768-1-sidhartha.kumar@oracle.com>
 <20240607185257.963768-14-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607185257.963768-14-sidhartha.kumar@oracle.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4PR01CA0428.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::20) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH2PR10MB4279:EE_
X-MS-Office365-Filtering-Correlation-Id: 08a8f53c-6009-4ba0-5752-08dc8bb9a299
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|376009|27256012;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?fJctEj3PIPbH0uGpxQDbVjvcoXgC+Kyd7qsVgp/C1o9yjT2qQ2/TXHiZOEGX?=
 =?us-ascii?Q?Zm/vhfTduDY7MJGJN3b8qn66MpBxBBHsuIsCqznXIjHow1U/NqXh0UX5O6MA?=
 =?us-ascii?Q?TnYNyo5PDPfFG/6cgwlhc3UqjqiILKtE3tVAQCcfier9zK1VAy78hXgpSk9E?=
 =?us-ascii?Q?xi6GDVBnVLE9qXV3bQLzbiLBhtIAZsZWJ6T70Otca6BbI2SMbEMYOqDKJnjX?=
 =?us-ascii?Q?OMv2cYvhcforhlexfPmkszyE8vobYQci1j37pYcLIO3qFFF3U06q3sZye6Ut?=
 =?us-ascii?Q?odmLjrRcwXmMHLfPbIMRT4Q7jcdR39UtGzN/mhbeaqcgNtBoqaYV8Nl2nWFq?=
 =?us-ascii?Q?1bQUxUv6ysjlorPrXraQHaJj3mrVjd2/zInoH7W6o16YuyQ8z3i+lJmmK3A+?=
 =?us-ascii?Q?4vcT56v1ZoQCM9ej4LH4G21giiHXF1/u1rvts8yzVUfI7yXChjd0aeVjA5kL?=
 =?us-ascii?Q?K1xAQaNBV+xfHGW2JJAVnE43o0t1s6jPYCEX+w/WrAG6DNYESmYKXp6mKkmJ?=
 =?us-ascii?Q?S8du6s/eGcxQGDRJefaqj6XnscWpCFxkQMutTwYLRH70nWpjL54HM+a3xqkc?=
 =?us-ascii?Q?ZJ3yOxChaXG0lzvMsnd3D9M/NHIVmtdO59+3CVozLxZd3xvinaSMf4/18TZ6?=
 =?us-ascii?Q?y2NDgIUM9nHq/SKpA3TCFSS8/IxNdcULQmr/s8hTyQgAibMOJxjrL1nW3GPh?=
 =?us-ascii?Q?aDej13ck3bJ4+2F7QGcQb/j/1+8G3DlSVDpsEYb0hXtMdbbb/iukqIWZHnve?=
 =?us-ascii?Q?hhVUHinaxvSndRQAXFBMa4PNcMYg+FvZuUQN2lntW+CaXYvQLM1S5fozaReB?=
 =?us-ascii?Q?eL8SVC1YZKWHQZaGf0CG9hTzweHs+sNqjz88Uz2ym6ReaM83HbCk/Qtycg0f?=
 =?us-ascii?Q?6sEHgI8xiGoabNXIjIZuClU9rq014JN+hgxxM0d4/vucyCc2mwXWEVoCe96J?=
 =?us-ascii?Q?vvixByMKqJMKi3IGv8gvBKreI4KOJf4ie+l6yWb5hZ5eRfNBWBwaJe3vvuLZ?=
 =?us-ascii?Q?cvpHSKdDh1mDrvFHRhcGcvhEhUpF79W6AxMVbyk+8ixmVjOCNe0rok83xDYJ?=
 =?us-ascii?Q?HrN28pYD79F2UKIu0VeQu9/nSI9O76mGfPgKUds3KylefYDVTfveLidrhISd?=
 =?us-ascii?Q?EY/TzMpOl3vzuhWmevXRUP6m9GZ6wrCWVENL5h65gYg1CLAqPZKqwre28WdR?=
 =?us-ascii?Q?wRt5jjJJeJFGl8gFS0Q0ErLr1L+qXaDstEaijtfitYpVfdM55WpPMcraTZlf?=
 =?us-ascii?Q?krFJq5sSHqW7t7B4BoOfygktOzyVG3I0CvTACng2wx4lQs9b+zX0BGyZv5cp?=
 =?us-ascii?Q?hIOs/wGqjTfuE1MoW+vusC1wGheQaCS1G8UkDUkh0yFoGw/M2vqpKwc0NBOh?=
 =?us-ascii?Q?ue0gOTo=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(376009)(27256012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?r6wtuxC7YFrbxk4IHeRR8drKvRf4ZOzGb+XWQsPY93eiHtX9jsJItpBti34t?=
 =?us-ascii?Q?Y6LkmrsLy4m+EJKoAUfzEb89EI6bWFpBiOzRZA/K6YGyRb7cs2OvG680+Kra?=
 =?us-ascii?Q?N+CaBuwpJmWhipg8Kk7LfVonsJ4MFaantgOfSD/co+zNOblGs2/uyNdSn7c+?=
 =?us-ascii?Q?o4oLsxEcOIgeS5XmmRA+4rzJ54WEElzJDQjHOdPZ1XnaRmHy+lPPPFJYcCpT?=
 =?us-ascii?Q?df7fl/kAu9oBBAARRjYZCnN7s4XFVO8VzxzEa5oCuoE4pmTjrkzkRzIg9wSF?=
 =?us-ascii?Q?8xwL2ibJPK2g0U2Q8Vj93EXmaOK+EFiwjyJIFIz5NyzGvWhpTlvwLT6k1zXK?=
 =?us-ascii?Q?un7MjRUkqsewgfa65mGv3nDKPwpTga68wHhZUw1FrbTzgJ4c5fHW4k8J0ifp?=
 =?us-ascii?Q?fXez9C/N41DjsAp5mM84bqoAEQYvqx1ErKtMUZgPyYi0jk2qPxtSgbgASFT2?=
 =?us-ascii?Q?6jpyluQnVPWGlSXzx0FsC8EaTqfWACZDih3SJ385qEXW9e9x4sEVDe9CiBtd?=
 =?us-ascii?Q?0IuuzFXF+BuaB7JE2midzPkC8SmyQwW3mgrYABzbPRjn57HHrWGCJw9tfOVW?=
 =?us-ascii?Q?lY5B+Oq3WZIVd6LjtZG67QBoGObNRxhU98gAAxbVVziI8/VVBnI5fvvP4uyE?=
 =?us-ascii?Q?Lb++6FhHs8LmG4Md7C8Q1wBQtzJvWPRy6AGmAdWVrsDaT/QEXrKts3avDyx2?=
 =?us-ascii?Q?3BdYhwV7xPIeNsufWRWN38b7KjtarU+auFV/D+9+HNJnWEhAfntjrrmfVYod?=
 =?us-ascii?Q?AaCJfOdIFZ5Eo7nkYhAJHzV3bjlcISYt7mDVH0YjnyaMSga0Th5SLLpWwLs1?=
 =?us-ascii?Q?A98TwPQ+WW0NTybQ7Ve9beRRk7oFF8/93XPtZy2QEXE3on/BqCDch6CvUiQW?=
 =?us-ascii?Q?mmVone5eQjmJUL7En6GH4iZpxVzJfCVeV1+RLJbPOxDbDWEzUZXvzrYP9amP?=
 =?us-ascii?Q?t+P42fHL7WE2JkwaSt5yKmds7gZ+JKpPrcpI9ObgdHjvR+/jOuFxHFi4yMrQ?=
 =?us-ascii?Q?jf2RmLNF4uDl8HeQi4YCD8Z/sE5BVhrGy1jaceFs5M/x0uX9T8ontkfIyU0v?=
 =?us-ascii?Q?UjfYYWaBcWFCbumEndddYFJiPmONx9A82LBhSAGe23eFoReF9ry0BlzC2yoj?=
 =?us-ascii?Q?t8TQKG5xK0xQV7Vj/1UQDaPEN38nrKlib71bADvLXWivT0+rkMfWldek+SpA?=
 =?us-ascii?Q?6oB2x4Ohhr7mz8s4XclrphiJuTniId8QLMCmoaCKu7dKHwav0qlRx8JbJff1?=
 =?us-ascii?Q?7vUiKuFT1OK9FK/fUyCAw43qtzawzQlFm4YdiSNdbhU3/b36nV3k9bVEFO46?=
 =?us-ascii?Q?Tlnr4BMklWKzcRjtwJm9uNF5Bgs5Uwl8VjY567K59cQNX1uRxr96jV9jTPCL?=
 =?us-ascii?Q?Bi2MfAP4dB6qfFK1Go8+sWYhJL7RLLbKXBG7AutzPyeTR85Tdoky6zQNgr7j?=
 =?us-ascii?Q?kpwhfr/3Z/hEPZiaMTeK+x71+JCbahTZkTVOE1A33PBIKQ032/n/wkPCynOj?=
 =?us-ascii?Q?uEEo+AFQer4KebwWKxJTIC9elYRjqVqa+u30bYBMhj6ZmUjtUTlpLMTF4aVB?=
 =?us-ascii?Q?ayK+VmXLBdYLCvSxjppmr7neu0kkKm9saWbS5C6nM+iy4NPQLBLcJrRrc0ZK?=
 =?us-ascii?Q?AA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	bjNrKDkqMzcBRTCFnWZ761PSjhRB3jiLmvkIOAFJOPtkanjVdfzXmkb+hfevKeZtwj5Ef1ZgIbRDPB5amzAGrsR2+eS90pOcZIjSn3rg3cIpezLLQYRXV30PdOKH+lf4Vxf2QeTUG5cTiJ0Hj+XNTnbHNwmuNciuLPoIJdr30UlBd23+QSD6CQZugclaSd1CxNKIG1QaFnpR8oDvxVKWKxdyZgYmNx2LCdgkwn6y4WB5gw0jRYarUrkLQkeXiShpjL0wf/viH8URpGEG0M+t7C+vWRLhqIvW2bFHHAr4u8YVVU+NR+tdvZPzR2Eiaqe+R8Q4qk8RG6gScQnRcdhYffgUQa/3tTOjykPTKxYf18pIFq6TiIoAqj2p8na3oaczxThh/kchMsPz6bxIYLg1oyLz9dj1GuuYTdnNO0L0yRCzcpd8NY8ZmGspBffvbbagv4MashIsMM3xgTbIe8dzdEUT8IsBj99pxZk7WKAem17dkX6jXgxGHlza4XisPW/BDR2Yv9EVEJJJjlMQNZoE9IcnwFAfVI3/PLr8JnV0VkrAaZetRzC70t8lOHLclKx05eulMWlyIf9yRl62GPGONNSMA6D1dOiy9Mo5I4xFRaA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08a8f53c-6009-4ba0-5752-08dc8bb9a299
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 15:00:59.4470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jr1Rbe00yyddEFtFQyJeQkVfTw+HXrU3xdoX7mBmUvQQD+0H1qpXRL9Yo3W5cX51GCqc+Uuqtlq+TYe18sfElA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4279
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_08,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406130110
X-Proofpoint-ORIG-GUID: Ss19oydTWoL-Z46wsJ03jTTVpAOo1Qfj
X-Proofpoint-GUID: Ss19oydTWoL-Z46wsJ03jTTVpAOo1Qfj

* Sidhartha Kumar <sidhartha.kumar@oracle.com> [240607 14:53]:
> Not all users of mas_store() enter with nodes already preallocated.
> Check for the MA_STATE_PREALLOC flag to decide whether to preallocate nodes
> within mas_store() rather than relying on future write helper functions
> to perform the allocations. This allows the write helper functions to be
> simplified as they do not have to do checks to make sure there are
> enough allocated nodes to perform the write.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  lib/maple_tree.c | 32 ++++++++++++++++++++++++++++----
>  1 file changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 8b17768db5f2..92f133ea5f00 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -5528,6 +5528,20 @@ static inline void mte_destroy_walk(struct maple_enode *enode,
>  		mt_destroy_walk(enode, mt, true);
>  	}
>  }
> +
> +static inline void mas_wr_store_prealloc(struct ma_wr_state *wr_mas, void *entry)
> +{
> +	struct ma_state *mas = wr_mas->mas;
> +	int request;
> +
> +	mas_wr_prealloc_setup(wr_mas);
> +	mas_wr_store_type(wr_mas);
> +	request = mas_prealloc_calc(mas, entry);
> +	if (!request)
> +		return;
> +
> +	mas_node_count(mas, request);
> +}
>  /* Interface */
>  
>  /**
> @@ -5536,8 +5550,6 @@ static inline void mte_destroy_walk(struct maple_enode *enode,
>   * @entry: The entry to store.
>   *
>   * The @mas->index and @mas->last is used to set the range for the @entry.
> - * Note: The @mas should have pre-allocated entries to ensure there is memory to
> - * store the entry.  Please see mas_expected_entries()/mas_destroy() for more details.
>   *
>   * Return: the first entry between mas->index and mas->last or %NULL.
>   */
> @@ -5563,9 +5575,21 @@ void *mas_store(struct ma_state *mas, void *entry)
>  	 * want to examine what happens if a single store operation was to
>  	 * overwrite multiple entries within a self-balancing B-Tree.
>  	 */
> -	mas_wr_prealloc_setup(&wr_mas);
> -	mas_wr_store_type(&wr_mas);
> +	if (mas->mas_flags & MA_STATE_PREALLOC) {
> +		mas_wr_prealloc_setup(&wr_mas);
> +		mas_wr_store_type(&wr_mas);
> +		mas_wr_store_entry(&wr_mas);
> +		MAS_WR_BUG_ON(&wr_mas, mas_is_err(mas));
> +		return wr_mas.content;
> +	}
> +
> +	mas_wr_store_prealloc(&wr_mas, entry);

Since this is the only place mas_wr_store_prealloc() is called and the
first two things it does is the same as the if() statement above, then
both calls can be moved outside of the if() statement.  That also means
the helper function is somewhat small, which makes it seem like it's
probably not worth having?  Maybe I missed something though?

> +	WARN_ON_ONCE(mas->store_type == wr_invalid);
> +	if (mas_is_err(mas))
> +		return NULL;
> +
>  	mas_wr_store_entry(&wr_mas);
> +	mas_destroy(mas);
>  	return wr_mas.content;
>  }
>  EXPORT_SYMBOL_GPL(mas_store);
> -- 
> 2.45.2
> 

