Return-Path: <linux-kernel+bounces-308008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE56965618
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 06:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D7F9B222E0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 04:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31E7145FE5;
	Fri, 30 Aug 2024 04:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S/h4filP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="y8uxUca9"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C8D14EC75
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 04:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724990497; cv=fail; b=YvawzCY1Ov2s3AR+YRB2IUXgnzI37UZo2BsS4IEZDms+2FZzbDi89vJctJKraqrCh0yvDNcpqrGEjrr1MWcecOf5kgPqTmczMTBvy9DSKPbQ/Xx74WiOnqs00f0oCYbVy/jAgC8bYaQUvPixBXHBReMSMtIf7ZBnR2ikBuhc8kQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724990497; c=relaxed/simple;
	bh=usQ7NSFbfvA+zY0a8CjQiqRsWWuqljWiwoNeYEiqLyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fg0ncZZqOn7zwt3INEALJPqXpxRFkVu2V1QcxoajGBev/vWpgXCE5aLXdfHJAWgkiC5bHyS/IhL+r831E2uleat3hqaofxJ5HCsFz2Dc0XSU2HFHAP1O2OLzdMoHH9lxcpmfT0CaeZ2aPkqYmrcXjyAzdYwA0Eh1brZn8kJ2Yqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S/h4filP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=y8uxUca9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47U2fVGc001103;
	Fri, 30 Aug 2024 04:01:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=4QFME2tTREHjLVCMxQPlLoeuuJf1PRO7hekWo2btQRA=; b=
	S/h4filP/JPtHj4IDEBSnYXQfBJ+HzatKgpAJ8lsaAoKc61dezT2oyF0b2lzf9wM
	lSDfpi1Ocly3hKIfsFoEMOWlnzW4fZHScfq92Kbg48ryxqzAVPZ5KHbmY+1TBl/k
	SBM2rPABgZyUF3j6krkvG1ZQl3Q7mx8NPnLIrtfdKXjj92DTBHfoWO7HPYmmD0Av
	mKGIGSqhh+klV42Q4RO10T52Y9NfyxnxkLuFXGOMGg468RsLlUtDIBZzJQEbhpyX
	EEDxRB6LRJoYUoV/zv7/JBVoLg9Zu1Zd30InsLNpq39Uv/k7J/UeyQiGGar69fLr
	c/9BK8hSKYTOG0IIlCR6Wg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41b25qg888-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 04:01:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47U3j9da034714;
	Fri, 30 Aug 2024 04:01:18 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4189swukkp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 04:01:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U5hyAmlBoVlmTVrIGb1n0TcZiXP5aY6D8Sqhx/529d6UUHO8rs4aq/Z60TLE21gI/8wV2ELEQ9XnZH/ns3gcPxTIv4v6X2bfcuAK2xKR8QLv2elhyQjqiN+gBsibUNArnxXgSWrI1SAtcWOHsv3DRqrDXbrpUSf5OYc4P8IyC/+Ljvm9Ycs7JfjUWAmXlPFhRoou4LU24xKJz0efCZtGLr4XP4Sj890sLG5APKkOqa+5+N5z8fPqIVSvteyodlVMKU5b00mGTbr29CRCQenT6KCMn+3+ESLFzcEzZcocpjc23U7XMFY2BPSrM0NSfjw70BEY1UTExZHeZM4Nfxk02w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4QFME2tTREHjLVCMxQPlLoeuuJf1PRO7hekWo2btQRA=;
 b=THeDQHs8CwcCIi0GJvZ0rvQqIrOOTNq33KGJNvrUW68QQ3BK+EQdADCageuc/WNqg6XiaC0G11cv+OO8YWkJ3YHdC4DCx4I8axgtlCmlbp1L34X1rmt81Gs68jOLlm5tdEC3fmLgQVe0RP5Casr7/GWSn8kgnC5pWZYQv2mIpQIPYT+yP8bcm1GFlu2XhXJiZ6wUWYM88p7GhqLpbwX0YHoeO2O2Lwyf/K1oWcEhL72Tk5F1wDozr5taoGOfXI9gVhRZZR5lE9AAkjiuommKv+h06nuwUpmLwdxVkAcrv4NBGGoMnrFxjZCQMupTckUFl4GB2Ky09Zli5/e6jzVH6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4QFME2tTREHjLVCMxQPlLoeuuJf1PRO7hekWo2btQRA=;
 b=y8uxUca9zr+Us3L+CCO8b4zMuqVyRlS1JmFkXWX2UT6bGMuUBBVKy/GvSLGvGNuVimFENmBgSBFZ4aQDSWs6G8aaDzi5puSyyNSyNjGpLi+BXLuk/pYzGOsss941tXy+MiiVnNnAoTo2qmiz4cUS3ctvHZFtR9rcfT1zkIfIiQA=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CYXPR10MB7949.namprd10.prod.outlook.com (2603:10b6:930:e3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 04:01:15 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 04:01:15 +0000
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
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v8 04/21] mm/vma: Extract the gathering of vmas from do_vmi_align_munmap()
Date: Fri, 30 Aug 2024 00:00:44 -0400
Message-ID: <20240830040101.822209-5-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240830040101.822209-1-Liam.Howlett@oracle.com>
References: <20240830040101.822209-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0098.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::15) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CYXPR10MB7949:EE_
X-MS-Office365-Filtering-Correlation-Id: f207ef78-dd44-4761-ca3f-08dcc8a864b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J2iRrcermSVJo423j6bZpJNHQm0LBp1D9kxVerUaW0/P5reA4M0er//+3gIf?=
 =?us-ascii?Q?TnJmPFm9eWw6haZfKGZXsU2VvK1TIgN13lysTQySlwtwOV4QD/pTSOUDoQ2K?=
 =?us-ascii?Q?RkynQTY52FoRHCxtesZRNtOSeO9dD41d7qaMWoyRc7SzEmehXf2Vk8lMYto+?=
 =?us-ascii?Q?XYWCfhBmYv4FVPGub6ehKlB7bHsOCBOrg5thN7EvSBuD9Xcqg4KAx9xpyWKl?=
 =?us-ascii?Q?DtMkIvSOfeIYHZJEKybLNFa6dYTGILUUpojTY8J58ZZeUb6aODdbOeyeYs4u?=
 =?us-ascii?Q?aj/9F5n5/30w/5JLoExUs49CpmaP2acfDHL+c1ZcWJZaHFeWMhHGyoqcxNAt?=
 =?us-ascii?Q?mTQxD7iH4BQqRHSigBficbbNRuAgjVpitN8wdxfLzM5KraKAp84F2KJc6RyZ?=
 =?us-ascii?Q?pXQn5kwiNrUL3kcaULnvC8WB6SDiyNKrh3fI6A+lsnxzfXorYQ8V11HGY5O8?=
 =?us-ascii?Q?UP68xNU1GlkrIddXpIUlKd7skqmANwckmlOaRl3xIOo9LnpZ6oq4m+osQlp6?=
 =?us-ascii?Q?6jCC3VAtijmUqss/P7Iknq9NkAPyw5c1d0tzJSSncyJox+gpvCybnJ7uDGNN?=
 =?us-ascii?Q?/Ehy00tql23m0PNUNTsjl4O1nleIBjvvyvbPX8Y1n6GTKZ6mHRXJ+KvMIsA1?=
 =?us-ascii?Q?TrLr366VY1TFNYAwHI5e5C56IHIC4Mp+AbwzD/cxgyr0eNXEStOIpguthUUf?=
 =?us-ascii?Q?MqPcyejq0Sh95KSFFHOTEmB+if2r+FGVG0A2+xnFhp8xgo0mwa9wTqds+5fT?=
 =?us-ascii?Q?UoN79kv81IhlcQMinfU+QjoJppdAFD+y26vcZ8jVMaJRmohhC6j2eatLWlNn?=
 =?us-ascii?Q?rg3Pbkwzd6Vm1/Op0co/6SGslALOGpcEHD+ktyTEydkTRCJw0kypnJrnTrvY?=
 =?us-ascii?Q?pbIDrJ8dKL8gTnoms9s4iwA4AJ3cOI+fj6X1i1JHXQJnw3z/dHgHbIVqxixC?=
 =?us-ascii?Q?5UEvK4ARbOEijvC+0ckaNPYuKcOKq20WmDZDKmauHv+CGB1kPOiLZ8ToYAnr?=
 =?us-ascii?Q?SjEaC6hblB7zx39YEHZ8eUAzPRMKc+G1dGnu8s+BBfgrJXrSiRqKfazOXaMn?=
 =?us-ascii?Q?KzqMJMxYq0KrIlu+SOE8uiFA6qfb1K3Nosp2woaVo/6GVVARsBURzQI7L+Yp?=
 =?us-ascii?Q?ALD39OcqCo3W76vRaD1aakJRGV1+vLdifn2NYPj8aW/+gY86NxCCrnpjVAwr?=
 =?us-ascii?Q?QExHBU0z+wCez+GwAL2RKLD6a0Vif/Ve/JK1pyn+Fvrg7CgbHbEqhjTGvJ+f?=
 =?us-ascii?Q?vNbiOtneETL8uNaxkVsqxjtO3bGGvLdBC+MiyGRLX2oksOZGOhoGuEVaHj1W?=
 =?us-ascii?Q?DJn5DHgDcU2tfodst6TBf3uUDHYR5diqnKzH52A5khjS/Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vzFAxiuXGPiPp8JfL3HvUzJM2JWWdVsjCcehpICa39MFVP0U+YdOoM6e+Yss?=
 =?us-ascii?Q?5+eIDHLghKZqxKqS9VTWZKj6sfX1ZpP947mzu9/nLdcijKPh1hqaxcGcFbZx?=
 =?us-ascii?Q?GmKkhn/yA9gYgUk+TnjO3D8XmDe5Xr0iH8fM0QE9/rvYeLF7txIB+1q7bNKZ?=
 =?us-ascii?Q?UUNHVIPbQbPr0gOjBHDqUI6Ve5PwxKhOORq/vNE5n/Rqwj5LdTYedFdO9Rwg?=
 =?us-ascii?Q?AWxEcmOPG/VS/ZL3qi1fI0iOA9bN5+NLJW4Uun1dMKBqJ1HkXwZ4vioZxvmL?=
 =?us-ascii?Q?aAGn0PUfctFX5EizYNr1yxIY+1NsCSioGkazCe6lH7Cs2fOAO6HltEtcUj2I?=
 =?us-ascii?Q?h2MUiPksQF73U5+7HS+5VV73csVsv82A7yDhYPHq3uNGf9ZOKz8X0TOUitzK?=
 =?us-ascii?Q?/MQfYt3iFEcBbVrkMIpuqsLIKBhAPuxXHDueRPBq8oiqF4U8BqQROZtDTal3?=
 =?us-ascii?Q?wdPl2boyuhYPWwHAjWtvb5ENtTkfRBeyWeX0z9S2+6cGHZG9BOVBzuBJTiw6?=
 =?us-ascii?Q?p1E3fEPqgh12eIFxf22INbRV/7pJE08oznYEi4Ta+F9hQL/bANXmLzeFRrQE?=
 =?us-ascii?Q?25hoChwfNzvpMH+XnTWkTwcyEQpRTcq0c6UQSEkJ3FL71bMIIhFxGvEXMYAw?=
 =?us-ascii?Q?KuJOUTtcWbVWHOxOsztCaDKqCeFuhJ6lwdvsu+8JkxafJ8jUd1SZG7wvHtGO?=
 =?us-ascii?Q?UZ/lAoRTe7DOujUWIB/9r9lEBDFDric0GFNBxHo0m91p9WkxQALz9ixLh4ve?=
 =?us-ascii?Q?p1sEnrC1e7gkfr2QdACVsXYpYWR6WeUCGsz1MD9SmjbDT8E62bedIJ/uLXPK?=
 =?us-ascii?Q?idWDvawBG7bttWzLHgpMCw4/K5Vz/3srepQ7txLf8EZSeV6zBVsdrTRXlmJH?=
 =?us-ascii?Q?ADQekklqszkkePbnR8AmsPTbSYGMdwBDl2X7wrlWDVg8Xxm7xSnq4gzXXp6w?=
 =?us-ascii?Q?A9DdET2/SVNk5Yb/OVYiSNs+rl/FghSD+Gu/Rb75FFLwRDEjaxFT/dfDB11u?=
 =?us-ascii?Q?y8M/67MBJL1Sa481ejR/Zz9QY8jtAV6LJiQpu4er2ADqAm6E5LawgM8nqz1j?=
 =?us-ascii?Q?a+iYiMsd+2yTRHJxmAZWN5Cj9pLO2ENqIhn0kYC9sKe8L/1JxXTds9YAT97i?=
 =?us-ascii?Q?r+vYudNZBNTKHI9oZtB9mFv8UhSIl2RmkxXbJf9k1/sKBKcZ5DJlw989J09Q?=
 =?us-ascii?Q?h9WCntOYRZSxTkELdjYNn9vmYNeDtZi9CWW68EhTbPoTwa2l+y/jFU8jPpzM?=
 =?us-ascii?Q?WQ+x7eO9XLcUjCXJtq5x8dv/YQTw7oWanQ3LZR/e2UNJ9YevRYdJRK73hxJ+?=
 =?us-ascii?Q?sJe9ouzMYTpGMFFH3zL1DAvPt6bXQomxNfs1rNbC/89dyvsKHkLUR43CwFXi?=
 =?us-ascii?Q?0d9wjESyLgUeOUlP3vGuM1aqsSCuv58uUwGtej6009af3y32PqqUEqnSPA/E?=
 =?us-ascii?Q?6qOKnrZ1bRjkXBjpMiDCCl0hvQ7VrUIsQ6BUKLLBN3kMcu2TJbcKn1QZo2Kj?=
 =?us-ascii?Q?JkOEUJKUgK6vh86uF3+5FaWtnAbB6iy2cHe1QMIvFTfiVZhN/hZG5uJ+0hof?=
 =?us-ascii?Q?nmDOvtOcU8pSLqeTdhe1nlWET7PM2MJHd7E9WVyj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fXkMXPzkZKOP+9foxrY0TqzvcJibYe642g+9MQamNsSEVfZeP9Pb9q9iZCu5XvZxHaNVcRW7mgUuaSLZ3wnkhhChibKY3z0af9BQD2huPVKQJLOdFoZTD1y7PSiOOtNbXlDPr1RLELasFw9VAAaHH6Y/iUOkSKXGSC84gMsRArR1YMj2ACa6G2QHsFR9L70N7WP2yjJ+ArG9gsKjYCs3evfFme/SpPRmLRQkYMHAWhfJ/ekRTMfCkgvlfwYWAxozwZ9a/DIMQ3GzuVps1oE4EyJRtQi30DGnANADLWI5FzQ+q8f8wCVlEnGgo3YDgfjps8NB19AE1jSyoLsUviEffq6XzXOFi+SHIcK/A+o5UwDG2EeK3a/fn8MwqPYArdCn+PEkqq2yimN1ddDSe7q8y5/XRXIoethTEvy0E4nHQo9NOyTGNI4oK4Lk1NdyCmTS5NK7lCRQdUFWLuwKu9MD9GT41LjVs0UyTV2CPBB/vdUzCeP251E70+tfCU0/vdiaHwCMZSZ8yKjHbENlUmfbMGnhohxyw4GqJkmTiEioRb5ZaJ9sDwaKFh4S9LdjA7FfuI9yvIsNrTR1U6zGvdumFlpknWPO0SGtCj6UMbXW0TY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f207ef78-dd44-4761-ca3f-08dcc8a864b4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 04:01:15.0302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z4qMCwGCKah7mLdp5PqYo/F45zNZjcA/3vz/4ap3wTI95rO3SqmD4jSnEPUkQEDKSS4D0auLrWC+Dtvc3Jn1UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7949
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_02,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300028
X-Proofpoint-GUID: l_bESagBN0mp42CK2JuMkFIdv2_bzF_4
X-Proofpoint-ORIG-GUID: l_bESagBN0mp42CK2JuMkFIdv2_bzF_4

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Create vmi_gather_munmap_vmas() to handle the gathering of vmas into a
detached maple tree for removal later.  Part of the gathering is the
splitting of vmas that span the boundary.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/vma.c | 95 ++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 62 insertions(+), 33 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 3a2098464b8f..f691c1db5b12 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -737,32 +737,30 @@ vmi_complete_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
 }
 
 /*
- * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
+ * vmi_gather_munmap_vmas() - Put all VMAs within a range into a maple tree
+ * for removal at a later date.  Handles splitting first and last if necessary
+ * and marking the vmas as isolated.
+ *
  * @vmi: The vma iterator
  * @vma: The starting vm_area_struct
  * @mm: The mm_struct
  * @start: The aligned start address to munmap.
  * @end: The aligned end address to munmap.
  * @uf: The userfaultfd list_head
- * @unlock: Set to true to drop the mmap_lock.  unlocking only happens on
- * success.
+ * @mas_detach: The maple state tracking the detached tree
+ * @locked_vm: a pointer to store the VM_LOCKED pages count.
  *
- * Return: 0 on success and drops the lock if so directed, error and leaves the
- * lock held otherwise.
+ * Return: 0 on success, -EPERM on mseal vmas, -ENOMEM otherwise
  */
-int
-do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
+static int
+vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		    struct mm_struct *mm, unsigned long start,
-		    unsigned long end, struct list_head *uf, bool unlock)
+		    unsigned long end, struct list_head *uf,
+		    struct ma_state *mas_detach, unsigned long *locked_vm)
 {
 	struct vm_area_struct *next = NULL;
-	struct maple_tree mt_detach;
 	int count = 0;
 	int error = -ENOMEM;
-	unsigned long locked_vm = 0;
-	MA_STATE(mas_detach, &mt_detach, 0, 0);
-	mt_init_flags(&mt_detach, vmi->mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
-	mt_on_stack(mt_detach);
 
 	/*
 	 * If we need to split any vma, do it now to save pain later.
@@ -789,8 +787,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 			goto start_split_failed;
 		}
 
-		error = __split_vma(vmi, vma, start, 1);
-		if (error)
+		if (__split_vma(vmi, vma, start, 1))
 			goto start_split_failed;
 	}
 
@@ -807,20 +804,18 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 
 		/* Does it split the end? */
 		if (next->vm_end > end) {
-			error = __split_vma(vmi, next, end, 0);
-			if (error)
+			if (__split_vma(vmi, next, end, 0))
 				goto end_split_failed;
 		}
 		vma_start_write(next);
-		mas_set(&mas_detach, count);
-		error = mas_store_gfp(&mas_detach, next, GFP_KERNEL);
-		if (error)
+		mas_set(mas_detach, count++);
+		if (mas_store_gfp(mas_detach, next, GFP_KERNEL))
 			goto munmap_gather_failed;
+
 		vma_mark_detached(next, true);
 		if (next->vm_flags & VM_LOCKED)
-			locked_vm += vma_pages(next);
+			*locked_vm += vma_pages(next);
 
-		count++;
 		if (unlikely(uf)) {
 			/*
 			 * If userfaultfd_unmap_prep returns an error the vmas
@@ -831,9 +826,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 			 * split, despite we could. This is unlikely enough
 			 * failure that it's not worth optimizing it for.
 			 */
-			error = userfaultfd_unmap_prep(next, start, end, uf);
-
-			if (error)
+			if (userfaultfd_unmap_prep(next, start, end, uf))
 				goto userfaultfd_error;
 		}
 #ifdef CONFIG_DEBUG_VM_MAPLE_TREE
@@ -845,7 +838,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
 	/* Make sure no VMAs are about to be lost. */
 	{
-		MA_STATE(test, &mt_detach, 0, 0);
+		MA_STATE(test, mas_detach->tree, 0, 0);
 		struct vm_area_struct *vma_mas, *vma_test;
 		int test_count = 0;
 
@@ -865,6 +858,48 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	while (vma_iter_addr(vmi) > start)
 		vma_iter_prev_range(vmi);
 
+	return 0;
+
+userfaultfd_error:
+munmap_gather_failed:
+end_split_failed:
+modify_vma_failed:
+	abort_munmap_vmas(mas_detach);
+start_split_failed:
+map_count_exceeded:
+	return error;
+}
+
+/*
+ * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
+ * @vmi: The vma iterator
+ * @vma: The starting vm_area_struct
+ * @mm: The mm_struct
+ * @start: The aligned start address to munmap.
+ * @end: The aligned end address to munmap.
+ * @uf: The userfaultfd list_head
+ * @unlock: Set to true to drop the mmap_lock.  unlocking only happens on
+ * success.
+ *
+ * Return: 0 on success and drops the lock if so directed, error and leaves the
+ * lock held otherwise.
+ */
+int do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
+		struct mm_struct *mm, unsigned long start, unsigned long end,
+		struct list_head *uf, bool unlock)
+{
+	struct maple_tree mt_detach;
+	MA_STATE(mas_detach, &mt_detach, 0, 0);
+	mt_init_flags(&mt_detach, vmi->mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
+	mt_on_stack(mt_detach);
+	int error;
+	unsigned long locked_vm = 0;
+
+	error = vmi_gather_munmap_vmas(vmi, vma, mm, start, end, uf,
+				       &mas_detach, &locked_vm);
+	if (error)
+		goto gather_failed;
+
 	error = vma_iter_clear_gfp(vmi, start, end, GFP_KERNEL);
 	if (error)
 		goto clear_tree_failed;
@@ -872,17 +907,11 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	/* Point of no return */
 	vmi_complete_munmap_vmas(vmi, vma, mm, start, end, unlock, &mas_detach,
 				 locked_vm);
-
 	return 0;
 
-modify_vma_failed:
 clear_tree_failed:
-userfaultfd_error:
-munmap_gather_failed:
-end_split_failed:
 	abort_munmap_vmas(&mas_detach);
-start_split_failed:
-map_count_exceeded:
+gather_failed:
 	validate_mm(mm);
 	return error;
 }
-- 
2.43.0


