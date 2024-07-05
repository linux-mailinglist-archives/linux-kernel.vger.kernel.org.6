Return-Path: <linux-kernel+bounces-242823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5ED2928D99
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 20:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E7FF1C21595
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 18:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB68616D4F8;
	Fri,  5 Jul 2024 18:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HAY+QCqj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="opiqXOEZ"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E98A81E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 18:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720204892; cv=fail; b=bO5krz0wsLqeG4zl2MoHPV2gORbpvrlg0NwlXeSE/Zwie8YpIqZj13eO3Z19ZCmEIFtTxq111510jcm7YraOrW1gQBy8ZIFQo0LTNIGCh/WXTr7kiuuZ194ia9tVDkwOgWpuK1uyekrEIOds+wQajGaBCV2qrROVM/24xN/iuCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720204892; c=relaxed/simple;
	bh=RHfk6kRdWqI05bDPEn/z3O62acPNi2QQH+RHRv2XnD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=icQGp7PhEXmM/4mwwqPgHtPK2DMr30Do2kzpOnJE2I/QKPqzMNIz9peuGkofHQPyjODMHPAgAGqy/r/ZEYoBshOjjyJ/KgtmpDZMPSO0dk2Kd3cSzUIpuiZSccw2QFMR3eIknQ9pPzHQpY7iVYnJV46dewxyYERpE5ifOO1gNRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HAY+QCqj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=opiqXOEZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 465GMWxK024650;
	Fri, 5 Jul 2024 18:41:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=5ZifPHBwefzQf0P
	+Dh0voaoPKQBAuO6kZDaG4pSQHjI=; b=HAY+QCqjxMTbdk+5bEN54dx4yYCf1vM
	6QXK3U6LtKUAAVPYdY9NEp97NzjHuviF9z5q3clKrvcXJ6Zak4K/YPwfFJ/x+nri
	9gUOvVyNgfXluWZ7adg+p792l6cTkfBqi24gYlH4pWCuvmfEexOkBUue68YHx7Tz
	89ApVrT8Qfaz2rnuCAF+bliO7uqH8SgcXgbe1Dx/z4f5C5vf2ipscxTtQvuJMVps
	g+p4rf6wBJUQiaoqsERWHeb7lQcPmrHyaJeM9Y+Coy/skI4ywLX46N75Vj/GGEHN
	4DVuJ2JdEBlsgFmD8/byck5qmDWYD30ggE/F4FbiNXxsKKUF4MzyDOA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402a59c5gy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 18:41:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 465HODY9023523;
	Fri, 5 Jul 2024 18:41:12 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 404n12ks8y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 18:41:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KqRgWEUe+AUU9pUITsw98/l39f/vv3cH46mvw3wj2FqtXy7UW9eADTtlLK31B+gBPMzRTws86KFnti5egRC6HCgmEjmKNSUl6NOShWJaCYlLhhFpVqqL8J0IOY9nypaA5gbj+8Jw3GGAY9pn4wl2i2H0cv13+t6Qlci75f9rTjC0wZbO3JfajBvj/3rtllAqx9kyYcStk4NkMJVOUhW0okH7oYwrtAMdfqIBVWxpljcqNWCxdRCVm6QlMU9RT4lbzSJJq06f8qpRr/uFk6IGzR9LET8kXY+nTAFQpS9H6OadH2fa2WZvikZlrjRfk0sXn/oQGxX6H4aMHdLfvpqOfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZifPHBwefzQf0P+Dh0voaoPKQBAuO6kZDaG4pSQHjI=;
 b=n4u6pmbU/xmofzNIzMUO09rgvVbeGj3zFon1aZmcb7tRaHwAQNkdjJ3+crozsjAiy1kW9W+yFn+PtwU4QENLqUgowVOsq7Tl8k+9/Jw3ClkF4ZurTQVUyk63NH1ytDLPgpeJBz8iqZXcOdfYROhaUfJHCdGHQQqeR1lBHnrp8w7+1mxuylKB1tUALxEyDYYdLAVcwUT90jEsd+xGiFy9Rm9Cog5f4pIV1SHiB7VYh0jvLi3lB1Hx0wzL/tpmi7fl3WHDtI5Lb4qriSR8xcNUlbOrVDbVpk2wzE7FVbRUSSHWnvSVO/6EQT/jHCnX7hEXgGXZyFSvU4lROfuO2HB07Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZifPHBwefzQf0P+Dh0voaoPKQBAuO6kZDaG4pSQHjI=;
 b=opiqXOEZ8YAw7P8H+NcwLRZZ+QyIOXIC6ygV0VR+zvBa5zw7WOQP+Jey6pdzIIpyHEt9jQsUvczrImRV39of7vomzqCAqJ/3TsF+BEyxpFyFEAoSmH5K2uAEOHCOs+1IsAI4gPGijmkJn8mu0QNLe2jIJih+fBAPUFYMgBluklk=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH2PR10MB4149.namprd10.prod.outlook.com (2603:10b6:610:a7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Fri, 5 Jul
 2024 18:41:10 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%5]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 18:41:10 +0000
Date: Fri, 5 Jul 2024 14:41:08 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        sidhartha.kumar@oracle.com, "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 04/16] mm/mmap: Extract the gathering of vmas from
 do_vmi_align_munmap()
Message-ID: <alpxbez767c2yxn5gvy7nzj7n5nhmtgy4rrppnq23qrnzrokvz@ag3v6pbl7inj>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com, 
	"Paul E . McKenney" <paulmck@kernel.org>, Bert Karwatzki <spasswolf@web.de>, 
	Jiri Olsa <olsajiri@gmail.com>, linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
 <20240704182718.2653918-5-Liam.Howlett@oracle.com>
 <bf24fc3c-a092-4c37-8f2f-ae32cbafe036@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf24fc3c-a092-4c37-8f2f-ae32cbafe036@lucifer.local>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4P288CA0035.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::17) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH2PR10MB4149:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f94b461-f939-4246-04a1-08dc9d220a1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?qHHHNRxj388l2+JC0RAV+7kGPwqvBc4Wyh2UlMTzlvAQw/902GV9fH/O5Pe9?=
 =?us-ascii?Q?uwKpXLqc0zD8T7MnzeqR0WYlPOUgtY9575mNmCIBeiDuW6iU6gIbNUvTlhn4?=
 =?us-ascii?Q?zHCWhVIPNDYFkEhV4N4da/oeWXKW/IhsQbZz5GrLF47zh+ObQDpegCzj6enz?=
 =?us-ascii?Q?uKQzaRgdSyCLGFJ+yya8/emT7lEfiQrC66RUH9ghKoOpJZrVi/vAUz1wyxkO?=
 =?us-ascii?Q?wMIb4KmCfNfzmLoMETMg0Cpc8baE/OnuWgAi6gXPWztn/3umq3fI0dbrvB3M?=
 =?us-ascii?Q?b6I+FPUNLNLCYY/b5JTsanRvoH3SJOmoH6u9voOLZ5fxy3vm1zNMhwjvb0zV?=
 =?us-ascii?Q?MSrYptBNRnEOYxTRMBTph6n45a7ZNA3gNqZ0X6u4Ar3raMd2B1NzsxPl5wdf?=
 =?us-ascii?Q?Ih15FIM0hLLxXiKFAEj1fRJ/xw9wtIp3ypJxkv/nFoZqFcs5wJLJteBJUBJn?=
 =?us-ascii?Q?KmrIgRY5UpDFP5FDF6vOL4Wuv5wNEy7Z9/i51KphMjArsSqP1B8iSdy8EAe7?=
 =?us-ascii?Q?Hz0iJ2YILrN/hkIOowu6B9aMtKtkznPNmJP4wo6O4VWemp19xMq9JeK/KCGH?=
 =?us-ascii?Q?wc/N2/N8jUY6wfg1fbbSww98QIyxVbtX/XoFNpwaYj8OzS7WL43k/qDqpD82?=
 =?us-ascii?Q?DNGfTJfXyBPQ+sifuWaqhfpdt+o4BnsAB9+q/LTyj8jDAayFGLuY6fGye8Mu?=
 =?us-ascii?Q?rlBhiq7Vgn4y0J3d2sAiBkNBoKqta1X2k3LPnn/s4PV9Zs3oq4Opkjh5ozPL?=
 =?us-ascii?Q?tUrC5L1nk1M45/uOOr893xafMqmzXDgvYaHKGadImylVHe4/mvulpH50lAdV?=
 =?us-ascii?Q?NSVstDSFrl3OA3jlPcCAulQkqpLq66XQ+jdmJiBANS7ljuoub8nab5Z1IwV+?=
 =?us-ascii?Q?Pt4T9ghok+jIsP0YAf2XFg2xpM7vbWkXnIfNJrRrF+pSSItY8sQNKp/Z31cX?=
 =?us-ascii?Q?F5aeaoufxRMKJA9ZveCyLwz3J/oe2a5poUnuxWyYQN6NGuLAJDiF3S/UjcCj?=
 =?us-ascii?Q?r5iohLTwbKVEqYJ7HIbU2R8Uc8n/gAkx2J/1DUumiu4Xb9uhPtzA7ONP2l/M?=
 =?us-ascii?Q?yI8094dsTsChQuYFs7J/2FphFUYEtEZ+sAt55ckdLGL4okOvcGQW3XETz2SO?=
 =?us-ascii?Q?Cf5K5l0WNEhBs0ma8WWoTJpnMDf7iHUI2lR3IR0iBRXX8MXjyXiXpqR3+oKn?=
 =?us-ascii?Q?b7rFjtPNUUy9txHHD9ZzGS+ZeKolphxStQUZkzZDI+ni5ZC281znzg/FwVcF?=
 =?us-ascii?Q?tgjvK3FdPW0mse6oT12bFIc0Qru49Pfc3jooYJz+b6ZcezrdhAb4p59rJlz+?=
 =?us-ascii?Q?Mt7w/qIXJw1icqZmCVvZObDkKFOoolSx40C1haXHrjt4kw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?j0+cF3aHtrSGxjVFXEm/CWawxO51bCIAi9edTTVazrT0/cPJecTkKcMHgGec?=
 =?us-ascii?Q?70c2/TOJWcNIcA3XSYbPw0YE8nngIhNuz70iHe9UtgQY2+IpIM5ZTwqNiU/j?=
 =?us-ascii?Q?ueJSk1dOPyOtgkMP8jtw7/i4cFjnU32bWluHfJy7l4RIChuyB4hWFqIuRCuD?=
 =?us-ascii?Q?w8LpzvOuoYS6PeyAFe1BhuCYHMZ05YJmUehvUgiSKvUOGHvMM0z08ralBw14?=
 =?us-ascii?Q?yQXResYFPdMybGw5CBOmfDUDjpWbcCqXFQTaFQ5Hp/xyWYgCuRrOKTnRM/Vp?=
 =?us-ascii?Q?i5y2qqUc+XQDc/AxFSvASjYFnfUuINpyPiKy9g5THzDhGANMAOENvPKjocMT?=
 =?us-ascii?Q?5pTWxNKrlpWbAtpgNR/6KTW+MAXL5kWX0AH15Uzr3416RmAqLSxIke82lB/g?=
 =?us-ascii?Q?w96hpyZWKMqK1HEctIymJqLlRUK2LV4VNNaDTwIGX/RBXFDRC0/txgZXsCgt?=
 =?us-ascii?Q?LlQR/c/2KrPrzsRPDmGskCP+mFbfQn++RRuftThxMFgTY/K6WKy+i8GAmGF3?=
 =?us-ascii?Q?PWcuRUAEJqYfJ3/hFuRoPCbTmntqB0JQOKk8wownvYxhLmcmM6zn7sVqZq0T?=
 =?us-ascii?Q?mQfGFMoE2fGeGEwDxdg4ZNlp4xpARW8Hc2lbd8pic6HbDED3kp0bBqRfLJy8?=
 =?us-ascii?Q?vtWp6q92AiNGnEx6tFP52MWt7qHPAPBjcgw+WJdyQ2bS9cJQ5FH5irDnlF0r?=
 =?us-ascii?Q?Ddnqt5I/l1KYe+x/n+7WdWgsc6ogBonxYMNUG+AjlB9sx5tVOFezKWeGb7jc?=
 =?us-ascii?Q?pBUegPGj1M51DWKmufdjh7Ehj5GEnu1tsWc+vI+Qe6D4q2Ld5zExhRr6VmWh?=
 =?us-ascii?Q?Fe7rw/0jb/jmqaTug1vKooH0j5PoYU+gt1j6Uzmv1uWWoI84/HdxkRNPODpt?=
 =?us-ascii?Q?/PCMCxldBxpocMLDeTUoxk0Vj69DKtDkwyFGIFO/FZ6HwpLyX2NSvfq+zVu5?=
 =?us-ascii?Q?O1eF8Y3x3C7WmxRiFkPhkRs5dshD9naGe6otbnmQtgxns3WridJf9j4Y5AhR?=
 =?us-ascii?Q?mx1w2faPEBZevmTIrxjmHzpb5Kujrd2KHPQALA5ZU20/k1dBxbkup/RaRl6f?=
 =?us-ascii?Q?2NWlOKh5eM9ukBVPSuSwV4rkMAMQrCpQuzhs1Q2C4BC4LZpqojjO78g4FCDi?=
 =?us-ascii?Q?trX84RwLDuMiad6NV8TL7HOvmLUhTw1NdVfq0fE8fTO0a9zJWJW3Qvis6HG8?=
 =?us-ascii?Q?6+reRCEW3Vl83H02gku33O6OBMryPXUJaHNo0n38F9n0+3ebiSRmGS+2nkNv?=
 =?us-ascii?Q?W3XyL8S8BuSGkX/zQQokjAi3A52YsYVV2wQckTkWFQYyw2I660eOkfOg7xAo?=
 =?us-ascii?Q?6rZzsBL2py6VWspoU9pwafayUoEpks6IIVIeedjTyc1qAYpXNWw4xPgo733s?=
 =?us-ascii?Q?iE6Y5A1WXK1w/Ef3oDbQQ4OW91EJ34DpEU+JySfjONe7xNufGJIqhdcX+Xdk?=
 =?us-ascii?Q?B4e8NFGa+piq2ukbTy6R3McWfmZAyb78Y/iHc4AJkNa74qz7FxqmPeSplnId?=
 =?us-ascii?Q?BX7tpvPch4pQObHMU40Vapcca6GMaWayt0VJ35vKS2ij1yABas1XkQrUIys2?=
 =?us-ascii?Q?mCHZr0IXVVrjhKQ+n96W6oDclVAMth6zpILYOjaj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	bBj3Kt+nPjbDrirI+eT+Kyt1Lo6UyGS9WIyPgHuXDvGa9QuMSHjgV4ECFWeSj6JjMrFKRfYzWWkUPd/xvWGZdcoKwXC5QPEITHJu8umsMaKyOU5+yiHVWZE3D4/Qb63N0gQb9zz5eE0vSBFew2ezlp/t1NKlV3NdI/CPkA9Ky16hKWvEVajesozxVGCjM/Zg7Q86TT6LO7l2TaquV2eAphbcpzOrQLwM+4FO3vIckrSH6NZEeG6IpPjLyL8ejENxHikMFZo5c8j6w92uWBJb/hNSy5K3VhZtMrkVaSutHVX3u+pOv9HGCxT6/9pbCOphxL61bn61z2b46fHd1QQVWlDa73hDDzMXpytcDlonpFUTJ6eS0+NHg7f+PAWgx0DVnJCxv2HASM3kcttGLqd6REd+B3shafYQVHsQ+gxmnFLVqpBGVpVbL5YryiXAqWAVIKgIwHYpukBfLa/12Fz56n47d3qhMgdfA2lwTRI7ClE48sVMmDIaz2A8/6EuiYgHxkerXrYlfnZMvJcc+v0a1lbjCrnQVTpsVQpdZkVDGCZmNtUaFHLgp1+mt/RI9JLJmrXccJaXYFAux9Y99wo/MhJoUqufwSeNJbE7jYYZDdE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f94b461-f939-4246-04a1-08dc9d220a1e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 18:41:10.4696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JBD/WtbkVhC+b6wT074H5ADkRDaWkl3O4iD+zEHl6nd5ZiSGdYT/LUWoqoTTTTARNTXlzp5fAUGojGZY0GoKQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4149
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_13,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407050135
X-Proofpoint-GUID: i157K7Fo_r2sUP4ySyIIj8J7pfKEDrnj
X-Proofpoint-ORIG-GUID: i157K7Fo_r2sUP4ySyIIj8J7pfKEDrnj

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240705 14:01]:
> On Thu, Jul 04, 2024 at 02:27:06PM GMT, Liam R. Howlett wrote:
> > Create vmi_gather_munmap_vmas() to handle the gathering of vmas into a
> > detached maple tree for removal later.  Part of the gathering is the
> > splitting of vmas that span the boundary.
> >
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > ---
> >  mm/mmap.c | 82 +++++++++++++++++++++++++++++++++++++++----------------
> >  1 file changed, 58 insertions(+), 24 deletions(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 411798f46932..8dc8ffbf9d8d 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -2656,32 +2656,29 @@ vmi_complete_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
> >  }
> >
> >  /*
> > - * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
> > + * vmi_gather_munmap_vmas() - Put all VMAs within a range into a maple tree
> > + * for removal at a later date.  Handles splitting first and last if necessary
> > + * and marking the vmas as isolated.
> > + *
> >   * @vmi: The vma iterator
> >   * @vma: The starting vm_area_struct
> >   * @mm: The mm_struct
> >   * @start: The aligned start address to munmap.
> >   * @end: The aligned end address to munmap.
> >   * @uf: The userfaultfd list_head
> > - * @unlock: Set to true to drop the mmap_lock.  unlocking only happens on
> > - * success.
> > + * @mas_detach: The maple state tracking the detached tree
> 
> Missing the locked_vm parameter.

Thanks.  This will be dropped later but I'll add it and drop it later.

> 
> >   *
> > - * Return: 0 on success and drops the lock if so directed, error and leaves the
> > - * lock held otherwise.
> > + * Return: 0 on success
> >   */
> >  static int
> > -do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
> > +vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
> >  		    struct mm_struct *mm, unsigned long start,
> > -		    unsigned long end, struct list_head *uf, bool unlock)
> > +		    unsigned long end, struct list_head *uf,
> > +		    struct ma_state *mas_detach, unsigned long *locked_vm)

...

> 
> Other than trivial comment error, LGTM:
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Thanks!

