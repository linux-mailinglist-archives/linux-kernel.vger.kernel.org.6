Return-Path: <linux-kernel+bounces-201184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2068FBAB9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 19:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 717691C24136
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840BD14A09D;
	Tue,  4 Jun 2024 17:42:29 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6503614A4DB
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 17:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717522948; cv=fail; b=NoehTyXLTpU/PNaF//4D+Wze1enWjN7cHOVxmxUnwGXlTjtjKllIvvtOup2soWhkj7pVTd0WgqVT6F5z7pCDLc6hpZ4eJc+8Q4Hmq8ll+a27BxP2e0Mpby8kWVKwcetzkbrdHr6oBHdwH7AQvduJbHdyZF11ET1qSRUHRBGUwpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717522948; c=relaxed/simple;
	bh=9tbJuIxM7aE8aP7x+iB8HTWUHuhJd8ou61xjmjnj03g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FttII8CcwhyBCUwQfDrkJ1kcjpG9h/5mX0ZxwlSSfh/34SoFb/UIm4AYEVGfvhYE4rP/7hOjW/YEGpHfwK0Wt2ihd4qe6dSOEOUxxz1IXwT+cGfTRMa1r3A3gghfj6cVhLb6/fturhuja2Dhe9Fw+wSwZYYpk5nr21q+IuuKtfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 454BmnYg004596;
	Tue, 4 Jun 2024 17:42:06 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DsxrYTRYvoigB/XkLSP2+ypvpJsb1vcDv+m8BGSQSO4g=3D;_b?=
 =?UTF-8?Q?=3DK9iVMb7/8bsugmfZETKm0cbXrbUuvJp9IaJYFs6qrddoucnDb1PtrhJ9Kwb5?=
 =?UTF-8?Q?83j6o67r_OIgakkIqNr6etshfVRorFV1Mv2YOAleZPYfRW3vENA4vTTwCLndXyF?=
 =?UTF-8?Q?OZ+Gn57ANyqKt1_I6uhsuaiUwhhLG7+eVgZMEFro5Z8K+fJ6kj8XzBaMk+T8g5K?=
 =?UTF-8?Q?18BpKZN3IC0oBfYaTt0J_YlLXlGXSyk3NEgtm4bEd/itYGHA3coyMjLixKYA1+B?=
 =?UTF-8?Q?7YXYjga6+t9I/zAx3R4H8ZOClS_GObyCRAc//IMQ2Y7rwCJB7ENISba0d6CMIA/?=
 =?UTF-8?Q?KsU0zj7rF2LOYc4rtkgirQLisYYCWdPS_Cw=3D=3D_?=
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfv05dm6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 17:42:05 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 454HZSFH020575;
	Tue, 4 Jun 2024 17:42:04 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2040.outbound.protection.outlook.com [104.47.55.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrj2bm4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 17:42:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TIntDJ9AefBFwnVgkwPCeyeF85kBcEGH9s5nsgtKEKf/EJ8oyXe4znbVcq+113iePsEsnxQtKAtqEwJb+KivTDC8EIPimb46svE3v9cgY7L0EEek9avuuXayEAusOgyB5XLEBoIqeh4aQrapZD0lEnFYLmiVz6YaoifJrIrPk4Sug1IpTMmXT6LZKeRFXd3oiNaXKNSkmXhjjjSuBRFCJTnrFQaxK9/i1KO9jXdLysbIfBk1N7dsDkL0NMZAHXk2357nMr3L+r7TaH2DS8Gsq3SENkoIfBF9KJ91adfRGUC0A/S3q3FBMr1Z1Z9EkeXRz6uJ173sUql5athJC8q19Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxrYTRYvoigB/XkLSP2+ypvpJsb1vcDv+m8BGSQSO4g=;
 b=XOAvCgeBw1Xvzv4S8Ed9PGHllPJ6OQB0BGJh7WmutkjsAwcVaE3gl/bkfjagKdyXfhat+5O2jlJEAhomh6g1IxVCPOnDOhFyJFZaKSlIU+LtBfd6Crf6FuMg878HNmctLZNR5eAVxdFo8zRDuk/E1F5arhFDdB923X/ebfx1hixZPwuOIg1gieSbu7xlCaEE3HpaEGL4YvQ7CTfDjPOYq5jJQH58kXfM2kEbaUqNv4I4y1Yj4BQNAQJL65bTHiNd9afsmQy0qy4sjX9gFy9dKdMUZ2FPtCEksdmqnh7oGTTGhH6lXT4fWT0V49sAbrts7Q0uW5yeR8qr1SInnKfhCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxrYTRYvoigB/XkLSP2+ypvpJsb1vcDv+m8BGSQSO4g=;
 b=IO0Y+gKxTgSPwS2pbDvR0b5IXXKxHkAvdypkUy4iddaVkFvYqK5+uyv/JwNQy6VhRChf3Nqr2xJiC21JsvBVHQe6nQg5cdZjqiIFoHxJ78IsidI615QTaFO6IrHzR5AA3ozOmsQNu/KQKqCWKI3ZTtQoLdzwDTVcRNt5SegQRMw=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by DS0PR10MB7269.namprd10.prod.outlook.com (2603:10b6:8:f3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Tue, 4 Jun
 2024 17:42:02 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 17:42:02 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        zhangpeng.00@bytedance.com, willy@infradead.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 04/18] maple_tree: introduce mas_wr_store_type()
Date: Tue,  4 Jun 2024 10:41:31 -0700
Message-ID: <20240604174145.563900-5-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604174145.563900-1-sidhartha.kumar@oracle.com>
References: <20240604174145.563900-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0027.prod.exchangelabs.com (2603:10b6:a02:80::40)
 To CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|DS0PR10MB7269:EE_
X-MS-Office365-Filtering-Correlation-Id: fc28ba54-eeee-4838-f824-08dc84bda424
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?8rfWhw7tUH17U+tDmOxdT6Iz10FK+vgATom1Yk8KNgmdhRxydxN4XBly/0ox?=
 =?us-ascii?Q?CCH4bx8UjzYTZI1YzNOksEMGrbZulDO7lHTdhh2/2piXqBNw7j+NQUIBGR/K?=
 =?us-ascii?Q?MucSj8WP12DobV12maS5iF2Td7X1s2wTi8dSf8Hh/qMIXOV8wPhCCMsic4Aj?=
 =?us-ascii?Q?gluwKZorgMEfBjdyHsUViruUwleCaWwPjX2Ur+i/7qJqC2iG2y50MPupTyXm?=
 =?us-ascii?Q?Plo+0GsVMw9fL+XuN2/n/GEpC7mvSwCpHOsfmeLdPj2V+0NrNQMCkUHRxmXv?=
 =?us-ascii?Q?15c8bGaKsByU4JTCbbJXOshoKwLRk6CIuQI2WQxG+bS+KFQrZwF8zhp0YB2/?=
 =?us-ascii?Q?7cS80TQbYVMkE+oNqdDAKNnlyvABKl3NrH2R0CjxLs12s+GT9Zui2xvXmePW?=
 =?us-ascii?Q?cCmwCjqSJHQD3ydPPBUdEuqx9Wrutu2jehgYYlSQGGm5Q7Ekm7P/FSNBEQF3?=
 =?us-ascii?Q?IjVXAvGR/zQyZvL2LN+2/E4QgAUHNNkcTEOsuXyPKLy1DRt6i5aLYM2Yg5Cr?=
 =?us-ascii?Q?lbecpozif8Alv+CL3BKjFOrhAqkvgQowe0bZQLxV/2zZBaEsbEQYUhhJuGLM?=
 =?us-ascii?Q?eqgWRFuUN2F+v17dNQ+4nYWdMGnACVIKxHvyPZa8hjDJrPDFwn5BACOczmK9?=
 =?us-ascii?Q?AmxFEq5DVG70TNqvlYJa1WhP5JE/wWyxHSpkiwSLwWJhyTcpg2vmJVVqhc/w?=
 =?us-ascii?Q?MsjwTWTm8a+OWEmlRlisqvwNoUQAzCzhwh3Wywxjgv6CJRQbRBPVcVyQay9y?=
 =?us-ascii?Q?OCm4cS/1I5jPNwtWB2idTl7swmaJDCX6f5Ag5QtAVrT3X0qCbacgSi0dOKwx?=
 =?us-ascii?Q?Mk5AR+Fd+/lool03x+l5Fwq0tTksbNdci4tQQc/eXxjzjiZFLTvfekuDzHzl?=
 =?us-ascii?Q?s1JoLqSL6f766ISCnNDCPIUUflIMcQJ5sJ+XUPdrtDrfBeQsJ6Q106xdyyfc?=
 =?us-ascii?Q?1hfRBr+cdLuK7Crgh5/qgiC7MSVg71F37URHqo1flaTD37C9KAV+/3f5c4by?=
 =?us-ascii?Q?IqK7/q/d7CdYRy2q6kTfhMujHD/3LpTeAXnjXWQCTvVHGfdPmBTDQCzIW9P8?=
 =?us-ascii?Q?WKrpopniZDV/IbKqABoM5TigP76xyUudjTkQrx8wc2y0qqiVOGt0EGmJkTRr?=
 =?us-ascii?Q?4GSAoA44LCeob1bCZn845mW4fQVIPHGoYdE/1DIr5Qk6GnSlRzzBIAj5s6Ym?=
 =?us-ascii?Q?4JqxBqWLgUmYrTVoG3sGRr48YrUqVAe0Kvuu6d+4aDBglGd7WWbcTd7FAsSe?=
 =?us-ascii?Q?jCNOhbtmCNcRVq3JVScO1j1Zs0mn6paQsCdkNF1BjEiavrtInnAxcYuazoEX?=
 =?us-ascii?Q?Srra7aVRB9sS+5O0F78n9LiB?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?whU6QgvMljXOxjbgFfOqml0HuJoJYuYJEIRS7kh/K0lIm8lz58JLu6A0eUwt?=
 =?us-ascii?Q?nfFSH1COsDBfhKvsnIJPCQTYTljKZxwdCYTajV12FjCK8CKkUAL9Yrtx0ISh?=
 =?us-ascii?Q?dbui9UKE6sU3jdFnGqAaZpswLsbxcfOQqkxUD5MIaFmYuAIFT923/nq7V5UN?=
 =?us-ascii?Q?4wZhOUCltXDzh0UveWgIjhTUBbgLakq9uJFDCigD71JrIecS1KHpOSQuuMQv?=
 =?us-ascii?Q?c9VZTiEXxL27jW1jkzq58boyiHR+Ee4U1r0b7oqAfOucU9flIIt3kbhjPQ+u?=
 =?us-ascii?Q?ppXobh4n9uy+sGqxtCiJVoSRd0GirOmKtF5yysssV4VqOaDH1tX/VgG3emTO?=
 =?us-ascii?Q?hDxK7ED9N1UbUrHEGaY6bJgg5gRG6I+xH1jhXlknqleZvKQGXdDQHah1c17+?=
 =?us-ascii?Q?+rg+f9LCup42HrCCbyJW5cDoua3qn+C+K5BOZMQ73kF5kJ8M6LJteRHgVeLk?=
 =?us-ascii?Q?g0iu1Cb7wEa9gl3de8cbkSEM/POWsAEFObkMYxLhqPYdGMIwSuksO3OkkM5S?=
 =?us-ascii?Q?HHV4JDYBDCTNG+rIA+rwju0ve7B4wqLXfuZcuN9iUR7NJ33sCeKr7JJnCdSt?=
 =?us-ascii?Q?i5cD42YyZPkrNu2SVDx5TiojLFwKlxdMaMjYfEwiz4RBjMrySYKwIfgcn3X3?=
 =?us-ascii?Q?by1MNTFWs7BaMRnhir9OA+W4ypXP5U3pCJapTpQEZ2kXgI2hgbVLzKPPMHhn?=
 =?us-ascii?Q?qz0OAiBys/c3f5lIORs4L0EMjUS7repYhY6hcRdpM4Mpov8th9WCXSCAVFF5?=
 =?us-ascii?Q?ajVADiLERNTRWO84L/Mqi3zb8zRoLcGBoS7aQKJ40DZ+dj2/zIxXLpz6U0K0?=
 =?us-ascii?Q?XB2kB6x6EbTynDfmjQA9PNGHlLsSGpvL8Ov83K3kiBrb/eTwNWRTLxMphNgu?=
 =?us-ascii?Q?g8DB7c/fPTXlA6i3eo1KQDKZbF6oihc9MXhxZPQudqljrkUd0f2C62YhHUG4?=
 =?us-ascii?Q?ueL+e/wow4eDZBX0HOoM9ApkJEiDB8bBUXJ3EWLcg4/faBtqw94HiyQJeFSw?=
 =?us-ascii?Q?7VN/pVE7ae7jccalcuOgVlY3qNjiS/zeEIW/MRo96biegPDNyrkuYSSqMG0U?=
 =?us-ascii?Q?qa8bx4tNiYDRAmjW1PIH537wJEh+MJAjnfwR2STIOi0eFJzodwlne8/443Df?=
 =?us-ascii?Q?moPuGc7RU1VKQMz+iASxMjRwaiJxGUtHQxRkM0YptvTU84qBLU0/ikqa4JFy?=
 =?us-ascii?Q?emNakByAwkVEfyWYT96jsnCFBta3FcNaST5fPLacSxn7oQ3RHh84vbQxXRxY?=
 =?us-ascii?Q?2sUb6ZdzxipyTNraJbqKe4v+EulQ0rSWmCLutjECyTuP+23epCOwy9oHGvB7?=
 =?us-ascii?Q?pUh/oOWtubydmBFoZiHu+oqOwGilAEngeG/siT8plaeUSyrHqnnHOy2iiNNU?=
 =?us-ascii?Q?x0KxYjksVVuY2WNtjJpgZt/X84rFlULYjUluKFnLzWdB8RWDVOpRxqE5YfFg?=
 =?us-ascii?Q?Wtym/fhkzjpo3KytxEI5+HFQFknAudGTTLb07iPja+OPq/Co1q3HSzXeiyfM?=
 =?us-ascii?Q?3hqlw677qaqtHTB2jaTSh+BwLtVKINR/pb/IL4HOyj8edVFwD5La6SckFTJn?=
 =?us-ascii?Q?nlmuBQ+L2d0DNfi8JlbxdY3cbT9InPGLtAgC/fNW1GptMqX1shiUZ6vC6v1/?=
 =?us-ascii?Q?7nruF9WkHBxgN1g2A8fEEnw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	PKmCBa6bXhPzIPNaYpJjYkhN1I+eGNpEFbECtU26nZ2VG9FX4HyYtRKsKKaEvBxvwuWuQB01qc7xqyvXDZwPfa7f91YfhhF9kO7ivKxi6ZUqdjb1xZmkAShn73jmHdWwJ4Fog4nedl3mgydgZlGH+TUuGjo6GdK1xiX+QCSHeH4POMGC4tEa5KQqYievM7moV4IsFii2HNQNamGNhD0+t0rIdWoSUJcpOu3RqsSFkHhQo837ab0WGX8HQLP2R++vCsf9WaGR3EHv180HSykPLGpCO/lOQlgB37OnVMJC2/KvwnU2krcgv0jecAKGj+qs96YCl1v69g2WLYGGJm9voNACgKsNx2wIMksjV8JI9J4rTR3I9sozTYlHQxTaIJ+EUMNOiWOx5CcdOGjFAra1YdAP4EIWBlLW3D49uFp5/5RqNztOXvkNIybxAOZ+BJiyhULmBCezx8H9L4rmsB5Z8Q4fxnxBNc1IEq9czB2EDJMXKJaws8LD1F4k93ofqV2t97yk3zcLDAa33p894bT2wYMirrcfoIlKb+xtiMNvTu5BbhWfaf7IhDQPiMSv3z86uucw9lvEvOsqgrYV7Mc4+55lE3G6294Us0HrIFZEspA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc28ba54-eeee-4838-f824-08dc84bda424
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 17:42:01.9247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AnFpy5mhFD1h2bdkdlSEsFVGh+g9qCQSrklkNjo5PAOUUZ8VvaqXIhcEbVP6/vZQJxshVOEUtBUL/cxkHXCJBdAHRZtBFF2fjOEhhFptZ18=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7269
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406040142
X-Proofpoint-GUID: Jgkfsp6eopO60sV-NnsTncDGs413UkCW
X-Proofpoint-ORIG-GUID: Jgkfsp6eopO60sV-NnsTncDGs413UkCW

Introduce mas_wr_store_type() which will set the correct store type
based on a walk of the tree.

mas_prealloc_calc() is also introduced to abstract the calculation used
to determine the number of nodes needed for a store operation.

Also, add a test case to validate the ordering for store type checks is
correct. This test models a vma expanding and then shrinking which is part
of the boot process.

mas_wr_preallocate() is introduced as a wrapper function to set the store
type and preallcoate enough nodes.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c                 | 210 ++++++++++++++++++++++---------
 tools/testing/radix-tree/maple.c |  35 ++++++
 2 files changed, 186 insertions(+), 59 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 2558d15bb748..b37fa8690558 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4278,6 +4278,150 @@ static inline void mas_wr_prealloc_setup(struct ma_wr_state *wr_mas)
 	wr_mas->content = mas_start(mas);
 }
 
+/**
+ * mas_prealloc_calc() - Calculate number of nodes needed for a
+ * given store oepration
+ * @mas: The maple state.
+ *
+ * Return: Number of nodes required for preallocation.
+ */
+static inline int mas_prealloc_calc(struct ma_state *mas, void *entry)
+{
+	int ret = mas_mt_height(mas) * 3 + 1;
+
+	switch (mas->store_type) {
+	case wr_invalid:
+		WARN_ON_ONCE(1);
+		break;
+	case wr_new_root:
+		ret = 1;
+		break;
+	case wr_store_root:
+		if (likely((mas->last != 0) || (mas->index != 0)))
+			ret = 1;
+		else if (((unsigned long) (entry) & 3) == 2)
+			ret = 1;
+		else
+			ret = 0;
+		break;
+	case wr_spanning_store:
+		ret =  mas_mt_height(mas) * 3 + 1;
+		break;
+	case wr_split_store:
+		ret =  mas_mt_height(mas) * 2 + 1;
+		break;
+	case wr_rebalance:
+		ret =  mas_mt_height(mas) * 2 - 1;
+		break;
+	case wr_node_store:
+	case wr_bnode:
+		ret = mt_in_rcu(mas->tree) ? 1 : 0;
+		break;
+	case wr_append:
+	case wr_exact_fit:
+	case wr_slot_store:
+		ret = 0;
+	}
+
+	return ret;
+}
+
+/*
+ * mas_wr_store_type() - Set the store type for a given
+ * store operation.
+ * @wr_mas: The maple write state
+ */
+static inline void mas_wr_store_type(struct ma_wr_state *wr_mas)
+{
+	struct ma_state *mas = wr_mas->mas;
+	unsigned char new_end;
+
+	if (unlikely(mas_is_none(mas) || mas_is_ptr(mas))) {
+		mas->store_type = wr_store_root;
+		return;
+	}
+
+	if (unlikely(!mas_wr_walk(wr_mas))) {
+		mas->store_type = wr_spanning_store;
+		return;
+	}
+
+	/* At this point, we are at the leaf node that needs to be altered. */
+	mas_wr_end_piv(wr_mas);
+	if (!wr_mas->entry)
+		mas_wr_extend_null(wr_mas);
+
+	new_end = mas_wr_new_end(wr_mas);
+	if ((wr_mas->r_min == mas->index) && (wr_mas->r_max == mas->last)) {
+		mas->store_type = wr_exact_fit;
+		return;
+	}
+
+	if (unlikely(!mas->index && mas->last == ULONG_MAX)) {
+		mas->store_type = wr_new_root;
+		return;
+	}
+
+	/* Potential spanning rebalance collapsing a node */
+	if (new_end < mt_min_slots[wr_mas->type]) {
+		if (!mte_is_root(mas->node)) {
+			mas->store_type = wr_rebalance;
+			return;
+		}
+		mas->store_type = wr_node_store;
+		return;
+	}
+
+	if (new_end >= mt_slots[wr_mas->type]) {
+		mas->store_type = wr_split_store;
+		return;
+	}
+
+	if (!mt_in_rcu(mas->tree) && (mas->offset == mas->end)) {
+		mas->store_type = wr_append;
+		return;
+	}
+
+	if ((new_end == mas->end) && (!mt_in_rcu(mas->tree) ||
+		(wr_mas->offset_end - mas->offset == 1))) {
+		mas->store_type = wr_slot_store;
+		return;
+	}
+
+	if (mte_is_root(mas->node) || !(new_end <= mt_min_slots[wr_mas->type]) ||
+		(mas->mas_flags & MA_STATE_BULK)) {
+		mas->store_type = wr_node_store;
+		return;
+	}
+
+	mas->store_type = wr_bnode;
+}
+
+/**
+ * mas_wr_preallocate() - Preallocate enough nodes for a store operation
+ * @wr_mas: The maple write state
+ * @entry: The entry that will be stored
+ * @gfp: The GFP_FLAGS to use for allocations.
+ *
+ */
+static inline void mas_wr_preallocate(struct ma_wr_state *wr_mas, void *entry, gfp_t gfp)
+{
+	struct ma_state *mas = wr_mas->mas;
+	int request;
+
+	mas_wr_prealloc_setup(wr_mas);
+	mas_wr_store_type(wr_mas);
+	request = mas_prealloc_calc(mas, entry);
+	if (!request)
+		return;
+
+	mas_node_count_gfp(mas, request, gfp);
+	if (likely(!mas_is_err(mas)))
+		return;
+
+	mas_set_alloc_req(mas, 0);
+}
+
 /**
  * mas_insert() - Internal call to insert a value
  * @mas: The maple state
@@ -5506,69 +5650,17 @@ EXPORT_SYMBOL_GPL(mas_store_prealloc);
 int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
 {
 	MA_WR_STATE(wr_mas, mas, entry);
-	unsigned char node_size;
-	int request = 1;
-	int ret;
-
-
-	if (unlikely(!mas->index && mas->last == ULONG_MAX))
-		goto ask_now;
-
-	mas_wr_prealloc_setup(&wr_mas);
-	/* Root expand */
-	if (unlikely(mas_is_none(mas) || mas_is_ptr(mas)))
-		goto ask_now;
-
-	if (unlikely(!mas_wr_walk(&wr_mas))) {
-		/* Spanning store, use worst case for now */
-		request = 1 + mas_mt_height(mas) * 3;
-		goto ask_now;
-	}
-
-	/* At this point, we are at the leaf node that needs to be altered. */
-	/* Exact fit, no nodes needed. */
-	if (wr_mas.r_min == mas->index && wr_mas.r_max == mas->last)
-		return 0;
-
-	mas_wr_end_piv(&wr_mas);
-	node_size = mas_wr_new_end(&wr_mas);
-
-	/* Slot store, does not require additional nodes */
-	if (node_size == mas->end) {
-		/* reuse node */
-		if (!mt_in_rcu(mas->tree))
-			return 0;
-		/* shifting boundary */
-		if (wr_mas.offset_end - mas->offset == 1)
-			return 0;
-	}
+	int ret = 0;
 
-	if (node_size >= mt_slots[wr_mas.type]) {
-		/* Split, worst case for now. */
-		request = 1 + mas_mt_height(mas) * 2;
-		goto ask_now;
+	mas_wr_preallocate(&wr_mas, entry, gfp);
+	if (mas_is_err(mas)) {
+		ret = xa_err(mas->node);
+		mas_destroy(mas);
+		mas_reset(mas);
+		return ret;
 	}
 
-	/* New root needs a single node */
-	if (unlikely(mte_is_root(mas->node)))
-		goto ask_now;
-
-	/* Potential spanning rebalance collapsing a node, use worst-case */
-	if (node_size  - 1 <= mt_min_slots[wr_mas.type])
-		request = mas_mt_height(mas) * 2 - 1;
-
-	/* node store, slot store needs one node */
-ask_now:
-	mas_node_count_gfp(mas, request, gfp);
 	mas->mas_flags |= MA_STATE_PREALLOC;
-	if (likely(!mas_is_err(mas)))
-		return 0;
-
-	mas_set_alloc_req(mas, 0);
-	ret = xa_err(mas->node);
-	mas_reset(mas);
-	mas_destroy(mas);
-	mas_reset(mas);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(mas_preallocate);
diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index f1caf4bcf937..c57979de1576 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -36223,6 +36223,37 @@ static noinline void __init check_mtree_dup(struct maple_tree *mt)
 
 extern void test_kmem_cache_bulk(void);
 
+
+ /* test to simulate expanding a vma from [0x7fffffffe000, 0x7ffffffff000)
+  * to [0x7ffde4ca1000, 0x7ffffffff000) and then shrinking the vma to
+  * [0x7ffde4ca1000, 0x7ffde4ca2000)
+  */
+static inline int check_vma_modification(struct maple_tree *mt)
+{
+	MA_STATE(mas, mt, 0, 0);
+
+	/* vma with old start and old end */
+	__mas_set_range(&mas, 0x7fffffffe000, 0x7ffffffff000 - 1);
+	mas_preallocate(&mas, xa_mk_value(1), GFP_KERNEL);
+	mas_store_prealloc(&mas, xa_mk_value(1));
+
+	/* next write occurs partly in previous range [0, 0x7fffffffe000)*/
+	mas_prev_range(&mas, 0);
+	/* expand vma to {0x7ffde4ca1000, 0x7ffffffff000) */
+	__mas_set_range(&mas, 0x7ffde4ca1000, 0x7ffffffff000 - 1);
+	mas_preallocate(&mas, xa_mk_value(1), GFP_KERNEL);
+	mas_store_prealloc(&mas, xa_mk_value(1));
+
+	/* shrink vma to [0x7ffde4ca1000, 7ffde4ca2000) */
+	__mas_set_range(&mas, 0x7ffde4ca2000, 0x7ffffffff000 - 1);
+	mas_preallocate(&mas, NULL, GFP_KERNEL);
+	mas_store_prealloc(&mas, NULL);
+	mt_dump(mt, mt_dump_hex);
+
+	return 0;
+}
+
+
 void farmer_tests(void)
 {
 	struct maple_node *node;
@@ -36230,6 +36261,10 @@ void farmer_tests(void)
 
 	mt_dump(&tree, mt_dump_dec);
 
+	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE | MT_FLAGS_LOCK_EXTERN | MT_FLAGS_USE_RCU);
+	check_vma_modification(&tree);
+	mtree_destroy(&tree);
+
 	tree.ma_root = xa_mk_value(0);
 	mt_dump(&tree, mt_dump_dec);
 
-- 
2.45.1


