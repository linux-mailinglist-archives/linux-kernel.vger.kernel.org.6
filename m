Return-Path: <linux-kernel+bounces-308020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EB1965624
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 06:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B442028515D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 04:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AC014D422;
	Fri, 30 Aug 2024 04:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oIVLn1Qt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hKYivDEE"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A641667CD
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 04:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724990521; cv=fail; b=aaaslBJoPqmZLcGuQanqCs31CeGdo0lxjk585EzbhDyGSyu05C+NPPfAAZv3lfpurC3+nhubMD8WdMkJ0smOnJmudo65SUvAasGAcF5wkTiN7vfOWVCvpUYwsxWxZ2PnBCqvcQh0zSgy1sdt+inQ5z/KjLJRz+Z+FmNsijrMYtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724990521; c=relaxed/simple;
	bh=5I7YJOuFf02Mbz3htWgZsOANqsKUiEeGVt4vtwKZzEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rdxCWA4agOnldXbpYkxMWCif3WJksFMd45fm7J+HOdn+IE2/0nezHwPml5maahfQwofcHCjh+afCn0Iqn/voPksN9Pu90BQNM+qFTD1kWKklpwttcMoU1ktLUEBPgbzCyVy/jZOXSfVFOycUTgwn5empOkeAgd+NYByOzAsCOwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oIVLn1Qt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hKYivDEE; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47U3MisH024297;
	Fri, 30 Aug 2024 04:01:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=QPEwLzEB0vrYF3G7jIZC0g0ABlZtn3Z7lT23QgU8XIg=; b=
	oIVLn1QtYiqpTfBN9QkQCULLw6LoaMfyVl/NiPKdYy5Tam+wTuUWRqrpXvejojs1
	b3mTEH/51FWcN7edjcBvwX63rv+ZcSnshpa0cWiHBA+BTnYHy0HR+yCYuVOj39JU
	tVYT7jrc/D10+rUBigkPpb5lS51CRhv/OtUhtqcWmnIz/DbGdkOnNaxIGX6QSaia
	IXKX6GHLOZkBlQSDR1Umb+e+zd7Vxs6Fqv+YgnBjZO5NvyMww0AvY75Gf3Qtk1Lk
	YpRtXRhyjdfelVLleSA7hpHFmo1QbvRdXBoPsnA5YR2ABFTDM2L1sTvAZe6ZLoau
	eEhIDUsOXtsJMXo8gr213A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41b3myr58m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 04:01:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47U23Wd3020188;
	Fri, 30 Aug 2024 04:01:43 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 418j8ra3cr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 04:01:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y5USXT9gwngBKjkv0pwdNA5LVW2fhu8/z3yXafo414KnLurda5t0Vq7dH2ncn258TfSSqe3QRcvprxuT7gMzTP5ZKULiheZn+LrIjd2RoOJq8eTU9pgqvv7FGgGIE810JLYYUgYKJ455nC7/Q0rB86gX3b9wiK/+flITQAtBasiDyVMkKZumvXWMHrjT6nlczzVJdRfVqDJIJ8ts+LOMeTwMiDNHDZB06tEiEKRLl7hI1z9drMrEp5Ict4JYRTTvynQiC/dQC5tCpHPgv+gl9u2yHnwkXih46sX72aL660lUVr6goE6jDKqhlDI3sl2LBCUU5/4lJDRbwH0aMs8/xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPEwLzEB0vrYF3G7jIZC0g0ABlZtn3Z7lT23QgU8XIg=;
 b=xrjqbp8m2DdJE9eES/UX+7LOfJNr4setcy+6KakuAeIXVtJngK7JxOH0ImEcrwer9ljH8tPNMCd3FJrwbcakHKeC+NfBuqVMaY+3eBdVGfEC8lyI9KoqpHKxkbh5+lxEdiRslZHzyG2iKEtIcb7Qed475cLw/GwSYgreOWjRQHbuq4sXYrR0FdqET7vKne3CxhrJIRz1NG3yTXZDfevtRczrVbjTUeY5ol+30AEXQ/0M/eE0oCg82nrielnmh42gd4+pcZWyT9CK7+/KgIDopvacE26X25nj8ab57CS/5zOFBlvRixxZTiyFikOWkz8ZUNwghzSMSdx0C2Fuv5a3Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPEwLzEB0vrYF3G7jIZC0g0ABlZtn3Z7lT23QgU8XIg=;
 b=hKYivDEEwLko5+7bZMtk66vCWIlVy+5XAl3sHNENy/sjZ+0hQbA7AlY+7z24m2y2nRSDrYHqYqcD+eNIaK5wpa+d5y3hmSvL4VC1REWkv7nA2SqRg3uxG6PIGKP0x6Ipv4jF8Ti7xGFjlJXsmBDpGwEMWpzszg62l5/o4AUvzpY=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CYXPR10MB7949.namprd10.prod.outlook.com (2603:10b6:930:e3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 04:01:41 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 04:01:41 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Jeff Xu <jeffxu@chromium.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v8 15/21] mm: Change failure of MAP_FIXED to restoring the gap on failure
Date: Fri, 30 Aug 2024 00:00:55 -0400
Message-ID: <20240830040101.822209-16-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240830040101.822209-1-Liam.Howlett@oracle.com>
References: <20240830040101.822209-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0131.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::7) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CYXPR10MB7949:EE_
X-MS-Office365-Filtering-Correlation-Id: 9be7a624-6951-4625-c0c4-08dcc8a87439
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BlgNi9KzZlcfM22/qdU5AjWVTIqsES8rJFUokx6Lh3FPRcpU9VZ/QZCjFEh9?=
 =?us-ascii?Q?9f8GsFutHHzhNRZMD0tj7MX1zxtiyV/Z9myJ0OBjg7/fEUkH1iNop2Y/VqBF?=
 =?us-ascii?Q?NsXDE0OZcNAur/8dc5XwAXbBCJM5Y3I3s0VCTrbwCZmj2Scvxundq+8Ibp/C?=
 =?us-ascii?Q?uWT+iKZCJuOpxx30CARFnFG6OAWJyasyJT6Bdbd5H3pi4c3rsLiibreeVjYQ?=
 =?us-ascii?Q?kjUIpenQwP63GbJuc0X+5pyoSpdRLJfKkAdgjWS/gYAILvTpYu8v0gm33Qwm?=
 =?us-ascii?Q?ojqzHYFCV/cR7WpoNpQ/MEm6aziQjBxVJKeLjzesMKecGUJImM2z1cbuje5X?=
 =?us-ascii?Q?RSP7afO0J2peNfSudlufHE6Fz1jAw2N4IFHjj8fZ6XSIxwHS6zkP8DeGxMr/?=
 =?us-ascii?Q?tPQT1fanLOK0RykcBKWZctC1n7//y0NU51kj7wUjP72OyENxuYGyqmCpe1BZ?=
 =?us-ascii?Q?9qzg3boWD82mPsxsS6L5GkgM1BpuSTaqjHjwAo66lTCj7xYvUaiaNxgmB275?=
 =?us-ascii?Q?+w1jKiL/gg9ozn6HQ1tU2LA4PEeHp7iwY3OxaCFhj+3L3/yMsCZ1M/sbVMT1?=
 =?us-ascii?Q?3NIolUYbV3HdtMHbaL3Pn73HZnkCmvah4Jj5ILluREJ17LEIlGXTjx5tqG8E?=
 =?us-ascii?Q?1KEG21wvE6DWe6nuz2hGd/Zo/kNfGyUvJkgmHiH9ehb2Ywofv4w8wAWMAQ2c?=
 =?us-ascii?Q?aPetjKlXHR/998updPrHwkXTOMYPmshYMkH4c/n4mhd0c40+M+zutD36S8nM?=
 =?us-ascii?Q?IsHzcYyY6Od1rjU8mCBfXeMHzZX//XdxHyoxBua2mSz+U8aRWb/VJQHWXmnr?=
 =?us-ascii?Q?rrZPOuDSxRwgwOtxTmckAq62HZmyQYr/9nLrF5x1shID3bJ4bRDNeRc1247A?=
 =?us-ascii?Q?KLJV2rHiiU6evafh/m5zJCsGGTXPbKFBqpICRGB04QXGUuTLx2qMMjt0I3so?=
 =?us-ascii?Q?no3X05Krvq21q1bofLR3E/uBjDNpL/kJo+ulM/htWdM7jRJeUqfVbBRo+rT0?=
 =?us-ascii?Q?uXmQeynVW9hlmioNdozGDk6bxae7oeceD/eiNJp75Nb1M9WCKVpcP5fs81lZ?=
 =?us-ascii?Q?jZjPTNUrPXzxnU1bTkSQdGP87t5Jali8xa3OORH5ZYcBXNw66rRNLlJBnObL?=
 =?us-ascii?Q?rldx5qp3GCXI+FNQNkS+PP2EUz8g1cGGZM3/C0nPmRAJONTcB3SIh/pUKaQP?=
 =?us-ascii?Q?duSCb6qR0OorHCiZp+HRto7Z+9eX2kwHxYJM2fVI4/kkFms9q/ceIRyuINRU?=
 =?us-ascii?Q?yCLZj3Tihi3VW4/Sk17sMQt5b/7Y/KE17PlJRQURiU5/yqNLN+hHCueG+zEn?=
 =?us-ascii?Q?SFL/JE3JAAGhSuJu80rV0BBah/Lw6cFMD7OYDWas7Tw6uA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dBPoZ/xrFP1QpT8FaUC9wUgjALRTUgWfufcIY2r2oDnjXUMuFqkCW8JBWJ0Y?=
 =?us-ascii?Q?DtF4MCEo6lW5jSuQf5M3fRvVhk/ZdYnGqrnmgzFqmEoy9uV2VHV6sDtdMo77?=
 =?us-ascii?Q?hyqezwau02+5E9n6T62OBkcOfxvJ1pVl71fIkOcMgt8szE2+6oGL8i67qO1u?=
 =?us-ascii?Q?uv5oZ21eyNfIuKRAwtJMrsQMUcPXKLulZKcfVwdx1hn88gOrf2lTJOR8hBfQ?=
 =?us-ascii?Q?JfDDigSEyKcuZch99mQzWyCFbQYHigCjvktLQBcwSE6eOAmJ4ogHy1M4nBaw?=
 =?us-ascii?Q?oBBg2U2Qhh6GUGvcW6VRMz+434l/8rc2EAG9xnDPmRboOx+3l1N7f5iorjlt?=
 =?us-ascii?Q?dZIkMzy8iUbMjuhbkVkKJk+eSdanbgS81L6ov7HhXui7nkmeAL8M9YpLTdsw?=
 =?us-ascii?Q?YmleYXsNyljntDl0d+rmAKxtOPU3zYb6uHNSMLnSK0sgachf3TPUi/LrTy4b?=
 =?us-ascii?Q?um07MMiv7/PBSSqRZfTOWiQtdSIv4i2yIG+qO6rN6GMPJ95YSRVPlzNElidV?=
 =?us-ascii?Q?TF1g7udPF3t6FijW51w5Io06nk68OkJqdRztZd2ba2VfCyxpn9l62VOYvqkU?=
 =?us-ascii?Q?4F0NPu/lKl+h2/1kU+I7Sbzj1VZN/qX0chPczTYGgnz8wGBPaHl5vbKQ45Qc?=
 =?us-ascii?Q?wHz5jvUtzXgJ5a5jR2kpKU4TbO62/V4TIfwYRu986oaU/bLjLQ4arYh3vIUS?=
 =?us-ascii?Q?ygh+/z2erQ3HxeNNIpkThA85BYwDfRKBUztR+f3DEAeEuo4EnUZa21ckRl8B?=
 =?us-ascii?Q?p8l9ohWbCIuMa2/Puf0pCgNuD1P0AT/LBOOud8vKYJEK2zdFwR6HuAx1t4Rv?=
 =?us-ascii?Q?kbkkeEf7yQnDcio2OmWIzSTfXz4DOB98lRjdHp3QZFLS1kC2qnJvASNT9quZ?=
 =?us-ascii?Q?Pi+xvyfvwqP3LmtDzgY2YiwhUbdVAZSswoKceYEccsYZ4QZUr8EFxTOyZopv?=
 =?us-ascii?Q?FSWj0Yp6coxWrq1kPXiswakBv/wP+bWO1Ryhr+4DTpSf9rMFKy+NqoxydLtv?=
 =?us-ascii?Q?PJ7GixiLGHRW99cUO7lQFmMc0qM7TB8JqL9qmWNLlHZezQFl+99vxBdHVh7j?=
 =?us-ascii?Q?C+IxXx4ydH0e67fG6vjavFJvvxOA9SwGeuqt7aNLYI05lBCx8c8LDLjOjVmy?=
 =?us-ascii?Q?BIyDDOugtf9mPKnLMLYL9IDplWdf14TEMaVNkJB5CitmQpGpUuD6EmZ2+JUM?=
 =?us-ascii?Q?bU5nAs66SA2vc6YTkbekL00udgHigEHXq6PfodvrCQoFxzGL0QnwIrPW2C4R?=
 =?us-ascii?Q?oJ157aIRETR0hvOwC07FAwNxYXXxvzUNWth5somskKW9iYezyud0RsF11YMz?=
 =?us-ascii?Q?6nFzFCvPVmGdmKHzhm8sbzc53rKRmV15kD5Wv9OswNM0+k1s6g+9BWI/cuBR?=
 =?us-ascii?Q?yhGKPbNG/65O0ymLzJSYEtkhGCfWvHIUMPWhD7/vjLn+Jzxm+awkoKtwXwO3?=
 =?us-ascii?Q?B+9R/CSEfZdgf6tXy5EfPP1ZCgaatqVoIceJ0DUxe6xHKaL5/gPs/SDCuJoj?=
 =?us-ascii?Q?XDYf2LvMamntb/xA83l28YYwAPdQtnZswc93REHmAHiF/a6DOY54gM2SJGh6?=
 =?us-ascii?Q?POwt5s0jQ0QXs8tQ+3g3Cui6annAEfGYsFV9KTZX7f3EmonbEShwTEyho6Gf?=
 =?us-ascii?Q?WA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RDkc3CbdVh+wlNSGqZANCw4pEcUxwHPGjBCiPAFjgd7dx1CzIHbB/61wu9qa4qL+8e1W1o4C+afzYt2cHxcCi53VWwlfACyeu1kFYmZfueWsYdcKJZ1+Ek4xMFjab55PR0W/AizjnWB78/CT20aoE+G8YSkQbstw2xdfVprnf03AvNCFv3gNUnZOe6QvXPYLuDWj8UUmJaEVdpb0dDIx+/NOhnJZszO/Sxk0SDuMcELx/FXlA39vNz/8yRq0XpnYQX1GXnxtTCiWqgNZBjeZx+BdhWq6napyekXS7EdllzKyiPtMADwejhJVKUWwaPSHIXjJlR4sqWSF2kCwLtq/iKV/7FfoBHKEqu46agy/Fm28pDEErHgRGPoL0PkbmQ6bTfdU/DGLC9g6bPNi0EDn1G+fqDWgP26u/ZFOR4AjdkSh23ajtrNKE6ZzKip9/h3HWX8o56gMoWEA7Lf/od6q6V+fb4DQV+rY9t7NXJ0Ne7rYPGT0lm9NCpdQHxvSYO7qG18KXA7quQm8yu13yN8bwHSdm5zFSyKEf3fhW7P9ojrDIo2e4qB3zJTZZzRN3ZBEl49YuPUqT84OiGwcEKITsG7G3kwiMmTvTThhXTeXuAQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be7a624-6951-4625-c0c4-08dcc8a87439
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 04:01:41.0802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tNRQp0Obemw0EyLJlP7yF5jNTf+wkh5vFd6wQzuLDS5I3xJk70LlptuTHk6TuG19owUyp4v5lgpD2jq13086XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7949
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_02,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408300028
X-Proofpoint-GUID: Pg36GqwKrh4Su6Vegp2Qn8TUrdhJyRF8
X-Proofpoint-ORIG-GUID: Pg36GqwKrh4Su6Vegp2Qn8TUrdhJyRF8

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Prior to call_mmap(), the vmas that will be replaced need to clear the
way for what may happen in the call_mmap().  This clean up work includes
clearing the ptes and calling the close() vm_ops.  Some users do more
setup than can be restored by calling the vm_ops open() function.  It is
safer to store the gap in the vma tree in these cases.

That is to say that the failure scenario that existed before the
MAP_FIXED gap exposure is restored as it is safer than trying to undo a
partial mapping.

Since abort_munmap_vmas() is only reattaching vmas with this change, the
function is renamed to reattach_vmas().

There is also a secondary failure that may occur if there is not enough
memory to store the gap.  In this case, the vmas are reattached and
resources freed.  If the system cannot complete the call_mmap() and
fails to allocate with GFP_KERNEL, then the system will print a warning
about the failure.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c |  3 +--
 mm/vma.c  |  4 +--
 mm/vma.h  | 80 ++++++++++++++++++++++++++++++++++++++++---------------
 3 files changed, 61 insertions(+), 26 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 405e0432c78e..e1e5c78b6c3c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1623,8 +1623,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		vm_unacct_memory(charged);
 
 abort_munmap:
-	if (vms.nr_pages)
-		abort_munmap_vmas(&mas_detach, vms.closed_vm_ops);
+	vms_abort_munmap_vmas(&vms, &mas_detach);
 gather_failed:
 	validate_mm(mm);
 	return error;
diff --git a/mm/vma.c b/mm/vma.c
index 648c58da8ad4..d2d71d659d1e 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -878,7 +878,7 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 munmap_gather_failed:
 end_split_failed:
 modify_vma_failed:
-	abort_munmap_vmas(mas_detach, /* closed = */ false);
+	reattach_vmas(mas_detach);
 start_split_failed:
 map_count_exceeded:
 	return error;
@@ -923,7 +923,7 @@ int do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	return 0;
 
 clear_tree_failed:
-	abort_munmap_vmas(&mas_detach, /* closed = */ false);
+	reattach_vmas(&mas_detach);
 gather_failed:
 	validate_mm(mm);
 	return error;
diff --git a/mm/vma.h b/mm/vma.h
index 64b44f5a0a11..b2306d13d456 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -82,6 +82,22 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	       unsigned long start, unsigned long end, pgoff_t pgoff);
 
+static inline int vma_iter_store_gfp(struct vma_iterator *vmi,
+			struct vm_area_struct *vma, gfp_t gfp)
+
+{
+	if (vmi->mas.status != ma_start &&
+	    ((vmi->mas.index > vma->vm_start) || (vmi->mas.last < vma->vm_start)))
+		vma_iter_invalidate(vmi);
+
+	__mas_set_range(&vmi->mas, vma->vm_start, vma->vm_end - 1);
+	mas_store_gfp(&vmi->mas, vma, gfp);
+	if (unlikely(mas_is_err(&vmi->mas)))
+		return -ENOMEM;
+
+	return 0;
+}
+
 #ifdef CONFIG_MMU
 /*
  * init_vma_munmap() - Initializer wrapper for vma_munmap_struct
@@ -129,24 +145,60 @@ void vms_clean_up_area(struct vma_munmap_struct *vms,
 		struct ma_state *mas_detach, bool mm_wr_locked);
 
 /*
- * abort_munmap_vmas - Undo any munmap work and free resources
+ * reattach_vmas() - Undo any munmap work and free resources
+ * @mas_detach: The maple state with the detached maple tree
  *
  * Reattach any detached vmas and free up the maple tree used to track the vmas.
  */
-static inline void abort_munmap_vmas(struct ma_state *mas_detach, bool closed)
+static inline void reattach_vmas(struct ma_state *mas_detach)
 {
 	struct vm_area_struct *vma;
 
 	mas_set(mas_detach, 0);
-	mas_for_each(mas_detach, vma, ULONG_MAX) {
+	mas_for_each(mas_detach, vma, ULONG_MAX)
 		vma_mark_detached(vma, false);
-		if (closed && vma->vm_ops && vma->vm_ops->open)
-			vma->vm_ops->open(vma);
-	}
 
 	__mt_destroy(mas_detach->tree);
 }
 
+/*
+ * vms_abort_munmap_vmas() - Undo as much as possible from an aborted munmap()
+ * operation.
+ * @vms: The vma unmap structure
+ * @mas_detach: The maple state with the detached maple tree
+ *
+ * Reattach any detached vmas, free up the maple tree used to track the vmas.
+ * If that's not possible because the ptes are cleared (and vm_ops->closed() may
+ * have been called), then a NULL is written over the vmas and the vmas are
+ * removed (munmap() completed).
+ */
+static inline void vms_abort_munmap_vmas(struct vma_munmap_struct *vms,
+		struct ma_state *mas_detach)
+{
+	struct ma_state *mas = &vms->vmi->mas;
+	if (!vms->nr_pages)
+		return;
+
+	if (vms->clear_ptes)
+		return reattach_vmas(mas_detach);
+
+	/*
+	 * Aborting cannot just call the vm_ops open() because they are often
+	 * not symmetrical and state data has been lost.  Resort to the old
+	 * failure method of leaving a gap where the MAP_FIXED mapping failed.
+	 */
+	mas_set_range(mas, vms->start, vms->end);
+	if (unlikely(mas_store_gfp(mas, NULL, GFP_KERNEL))) {
+		pr_warn_once("%s: (%d) Unable to abort munmap() operation\n",
+			     current->comm, current->pid);
+		/* Leaving vmas detached and in-tree may hamper recovery */
+		reattach_vmas(mas_detach);
+	} else {
+		/* Clean up the insertion of the unfortunate gap */
+		vms_complete_munmap_vmas(vms, mas_detach);
+	}
+}
+
 int
 do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		    struct mm_struct *mm, unsigned long start,
@@ -299,22 +351,6 @@ static inline struct vm_area_struct *vma_prev_limit(struct vma_iterator *vmi,
 	return mas_prev(&vmi->mas, min);
 }
 
-static inline int vma_iter_store_gfp(struct vma_iterator *vmi,
-			struct vm_area_struct *vma, gfp_t gfp)
-{
-	if (vmi->mas.status != ma_start &&
-	    ((vmi->mas.index > vma->vm_start) || (vmi->mas.last < vma->vm_start)))
-		vma_iter_invalidate(vmi);
-
-	__mas_set_range(&vmi->mas, vma->vm_start, vma->vm_end - 1);
-	mas_store_gfp(&vmi->mas, vma, gfp);
-	if (unlikely(mas_is_err(&vmi->mas)))
-		return -ENOMEM;
-
-	return 0;
-}
-
-
 /*
  * These three helpers classifies VMAs for virtual memory accounting.
  */
-- 
2.43.0


