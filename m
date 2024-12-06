Return-Path: <linux-kernel+bounces-435700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C581D9E7B33
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 22:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 345AC2817F7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 21:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE24A1EE014;
	Fri,  6 Dec 2024 21:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZQLyi6Lt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WKcXP/yg"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24BA22C6C3
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 21:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733522153; cv=fail; b=fB3dwvr0YLsccGoeGzXAb9/CUIUMGcPOJzgwahb4mvMaKYJRNdGdo0z0QTE3URdNiS3Mkf8f2mGVQTvwtO2VERsaAd+WvwZhxtHuxZrOiNTdKmpGTmnk4kWDHqj8g0I/NAQc044WOXcRAes6PV5jFIJOuojqn7BZicBQG2CTVMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733522153; c=relaxed/simple;
	bh=hOQOarzZItyB40yITqhBIietvvHeMxKafA6TM33abTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mAguD29tFdFis6Vxs5xcPcNi/n5VPRf93nLD0a0ROFOfCORWg2XEzWSej0D7BonCNYrON+XrvAawzE97fOrDPyNSeoRs6CicuNveAI9F+syLwusfnjhSoaU22ysE8jfkjafy3p3WM/rCtgjIwiMYREEs2FbE2LFZ4Im4XCq7SsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZQLyi6Lt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WKcXP/yg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6LX0Xk003208;
	Fri, 6 Dec 2024 21:55:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=TyTLnc7JqOIxKVBDyP
	m8rVO27Ju8rY9mW32eG4ctCnY=; b=ZQLyi6Lto1hvjfmOVFgcldwuL47ZLzK0Md
	bzMIORsQ4dGb1TV82cp3lU/sOSkTxEhVIlpb7xco+hTM5JAZPwdbDiJNCJS2Oi2O
	uekHtb/xngkmzvwYMQ3LhlYrrD6oCwil0f7P06xg/PeigxXe9IioCCA5K0j+sxDt
	2DnFVbhoQV5axs5EBv2M1ybCgRzZDpIvrGUnnKLy4w0eVM41qI0kgGm2AYxy3XSf
	yDlkXDyspFD6IkRWFDKxMlSv8w3OP8rjyEO7aBjGLrkZQFZvqzZpEITDpy6OXHCr
	fuJSfX29lDoy5p1lrn+wRRpK4T2cMIJfeaU2KXWBLi2pOKKkN1Bw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437s4ce91u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Dec 2024 21:55:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6Lexmt020400;
	Fri, 6 Dec 2024 21:55:42 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 437s5ctbuk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Dec 2024 21:55:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E3o2/WshatGsHy2GHc4kV1e1t+JOwYVbaEm4vTJrJkSLDWiEflApKDtwjYSU9LaEZQW4Cig9kJyW36fJZlW2DX2RaGFVp53XCWsv7WPbRhA++H72q5bTMKpltgpw2R4FzCBjMcxWITvfJwjrVnNXR0F/tVZ6vRJeolH2X/8ZwrKcEg7d3PUa09rhgE68Lwdn4LczH53AlSao90necXa7EuJ8kiLbd6SDcclge76DusP2ODcDmkY5rnPbTzSnzPnFGD6OBhoYbVF71Sh8Koz5PaZRuwfp4G38EOv4kJ1dVRA6ugPX5lIe9eDCVkpXsMNlsgWfaQN92D+aypHO+bcDJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TyTLnc7JqOIxKVBDyPm8rVO27Ju8rY9mW32eG4ctCnY=;
 b=LbDPiz7UaxzXRz46C59VUmULTXR783NI4RAT7A8DN9yt4DHepEkEShmwZSqgj/E0N1zmvs8pd1FQ+J26vGE3+WDI5+KiChGj07kJq0HP0EDonjJtKmb6J8lZsW1zeIgKkcg1q2YvSqeG0h5pPJ1Vw/6nRzTjoVGEChqOqjufXoBoJuFJ1TgUVAv9xn006rO/dNXWHveXXaqeXjTWhCzd2gsEM4/Bpo7Eadhputxhr+YLumV2vcQjFufgA6uzUE2Z2WfAsbpv6LchzkP7XxtZq4KGG9H1egykD8BWFMAPFB0yyxH4P+s78LQRYnvUToVdusDPFdeys9s2fm4v4LomqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyTLnc7JqOIxKVBDyPm8rVO27Ju8rY9mW32eG4ctCnY=;
 b=WKcXP/ygIMfvEqeCWyoDXcRfF3+rIA8Rfh18oOOXeSQk5efUZpU+d3XMOflsBYtDONt1ehg5KczHLefUpx55DOPAdddXbiVcEYjWgJh+C1r6AKKClbpZ8I0mIO1cDk+CFg0XdqtXkUF3HVib481G8U676wAjp6L2VSHbk42QQsU=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SN4PR10MB5560.namprd10.prod.outlook.com (2603:10b6:806:203::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Fri, 6 Dec
 2024 21:55:40 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 21:55:40 +0000
Date: Fri, 6 Dec 2024 21:55:37 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: correctly reference merged VMA
Message-ID: <38448954-e092-4ac6-bc63-0c06247d24de@lucifer.local>
References: <20241206215229.244413-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206215229.244413-1-lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO4P123CA0342.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::23) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SN4PR10MB5560:EE_
X-MS-Office365-Filtering-Correlation-Id: c257fc19-1379-4656-7162-08dd1640b946
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y8Swq9nxLY+ZuccSBYPjIQychIpVaAcHQwtRYvckS5bDWE9+jJyh7SDqJB7A?=
 =?us-ascii?Q?EPJgRB4WXuyHTQ1xD32p2RBCZlgzx0UAKfpcIiyTzmZaEihYqWaYNtl+Z6CF?=
 =?us-ascii?Q?mELdlSUabH7AfZSDBA9gV2RxfJY7bNN9JsypOqYeeeaijOxZh8tYPImi1m/a?=
 =?us-ascii?Q?D0ARcASQ1LZwEwXTfrXpRP+w08cY1xsNyb+/1/VM6g2Cctni36ZEdHjMcAjo?=
 =?us-ascii?Q?aq9V9Qu3IZFpZU+peIicRLDLuxGVi5tvjb0aA8M61Gn9fcLgs2t0WOyq9WC4?=
 =?us-ascii?Q?xypDoCJqC3InhAsdPi37aG6XsdMIJXu5e/pGMXBxamzZN8+P1Fm/dfISO5no?=
 =?us-ascii?Q?gzPwwZK9GE7UoqLuHxkUu079IO4SEVTSEFwz8+/7MbguCu4x96CzqDP87chv?=
 =?us-ascii?Q?9WkTSPj2dtXEMpXQm+D/xH1UCLsK5kklo08xn4y2Fo1KstxjkIILXLSJ3NxH?=
 =?us-ascii?Q?wKqqhcpo8XqfVUVYN1PrLlfykeq/ZVmES0HPeib4MjVgMwDUsGwI5uFS1PDm?=
 =?us-ascii?Q?4pQZmlPZCNKL2nvMM7OINJ8rQUEpYiWM/WMMDMGwRno1bd8Ohc5oCF56uy2g?=
 =?us-ascii?Q?ugT7wtvF4boG9IQORT2t00rC5DazdjQ2EnEy7+Q0fNjTJZhWTA9Pf+/Chn2D?=
 =?us-ascii?Q?3dx+a4Qp3k6+VXEHV5+yib0O4xd4BJFPEMpzy+aY6kW6yFLGUpv7kw2FFUe3?=
 =?us-ascii?Q?ix33roRK/fIxREDk5Ldq3k0x9kzeCG5ymlrwwDHGh362CKEgolR8D30OnmYG?=
 =?us-ascii?Q?hBi84mN5DdH0Aa5HngCTpHlBpPxTmveoKLH4kc3jiSDm9aEmNXappxZSIWtG?=
 =?us-ascii?Q?Sc+I/6JMRNpsjTIHiDIyVm+ELgTM5UuJEQM96xvVTNgvPuY46SyihGiNr0n1?=
 =?us-ascii?Q?qfYmCtEy1mGpsZx4BLnGWie4ALAjE2gIYZiLsd4Hv+wxfIBUfJxWYjTiF7JR?=
 =?us-ascii?Q?rjflV9sGQ1M3yCIC/ZSmuzt77GUwFVQqTjEce6Ps2MKXeki4/DDCoJpQVTRW?=
 =?us-ascii?Q?lVzh7IS67sjzNxL6VlJy2oe1i6iKh9wVyTpiNSnNQPpEF6rqn5pLDxzF1Vec?=
 =?us-ascii?Q?GZ4m3xLtmzUcwR/WTcBpDasuBlakAL4L1MLNabd4wCj0uzB8qpTupK422j00?=
 =?us-ascii?Q?IJOI1MXSWAV7FYrN+mE9CyKlBOlsMPIt2+CQAuns9EE1jUA45hUJrCXC2rg1?=
 =?us-ascii?Q?3U7DuUYtaRR9B8ZiPnAt6G6uyzXsqVp69cdrcMm5rTWlItsF7v2FAHjiH+Jv?=
 =?us-ascii?Q?G9NDsRA2vVXKOylAT3lSOOwcaC7H7XDjoD62VY+GLsjmA79vquNG4Lo5x8Lu?=
 =?us-ascii?Q?BC0cJ0Bi3UQvElM0g1ZzwawD+Lr/pN5myHS1UHjISolBAIgT4R0N8IfFZvSj?=
 =?us-ascii?Q?PokEwfk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?06RR2d5xxYfGCTGqodboX0rKOp/cDGUejwKb9Bnolf/pjp8zZ9LR39Ulml2G?=
 =?us-ascii?Q?9VXsyyKkknqTcxh8q+0VE01nwMnfZ2o/9/EkqifkqknS965yzbLfiiOqmX7n?=
 =?us-ascii?Q?HLqaAHx10KfYnS3mllsowFEQUNrnYuwQ1CBecitaNqW7KjtaZzdG/BFpC6wr?=
 =?us-ascii?Q?cKtCy8Bx9hZxl630sd20ZoSMxXhH8EoFC3gzTcH4o0L7Af10dknbg2UfMFbo?=
 =?us-ascii?Q?1DIYjozVYqvuDiwdm+CWPn5pC9bwomLYD7xZkAM1Cs3CfuRXA+Tk9MHjvwp3?=
 =?us-ascii?Q?GYSk8M4reZ4DkzxbWBdFDIGFtvSvGgJTGjhCYdwpVcc2c39qjLZyqPYuFsMk?=
 =?us-ascii?Q?MDkQXrkej+h4eFbD2CwBdQScXewhWeglUgB2CHFRapHu8bVa0pZWUfKx8rNz?=
 =?us-ascii?Q?i1Qrx8EMaK1SH3Th+3dTvjrriiW58j10VG6Cdk+XHuEhSW573uvqFM4rEfoN?=
 =?us-ascii?Q?D1KHDXp7HcX0LTad+z+TWqRWStx0IIo63LGye2tNQhXTR+5cHCH24c3qS1mX?=
 =?us-ascii?Q?oUMb6IqPxyAYINEWhTr8Ou09qfDaQtq3KAMcHqQCfpkkKVJy/XuHSpclpoV9?=
 =?us-ascii?Q?cFmDYZ59max/CZBH53PDWsbRCLw82MXQA6ixaVdycacNjDzHCFY539ClYSdL?=
 =?us-ascii?Q?10IvjLtIe8hG4MdbzWkEU/uXBo1qRViSq4hvTkoNRnvi+9jzYojFxYGUpRe0?=
 =?us-ascii?Q?uiaRk3DqfqFz0QewZBMPwrO1sWElbTRUdMiPtvJcYtrrd0H3sH6d0scoweGH?=
 =?us-ascii?Q?rlnIBJstUq3EwgJWfREZtSeYQT5JFo4z5/8crMkXifTvZu3OE+RW/7wLISi4?=
 =?us-ascii?Q?h4oEvtxoPybHGZN/WJw7MquaHQ62KFeeHUn1WkFDwa48WWglxzGrHf5Mun8X?=
 =?us-ascii?Q?TEQEL2wWwuHZyL+fuqBOE8RZJBWWxY51LENxCSb+HdeBlHREHtP+U3HcRQQp?=
 =?us-ascii?Q?UX11C9Qut1B45NVTMFQt2nxwdz9Eo4GFEa6OKiukCa6rLOIa664UrU84Owjx?=
 =?us-ascii?Q?GSQdeDis1bECO180yoI7J6Us1xycTKZkvqPzgJ7U5H1+cosCZxqRJ5gwgMVh?=
 =?us-ascii?Q?ak93T5/44vYW6T1MZC1cIX1sYQZL8m27Uo4tRvrf2BH/s7BboKuQ+ngFK6UA?=
 =?us-ascii?Q?CMLKpfk930VfVArY+XCDvVPBiB23NSH+ljWCxXE+Z3T/fZ1fC8e/jPjQjs9H?=
 =?us-ascii?Q?g0TGb4Jd42DYE5jLNwtqyL54J0OIPlsxinQtoRZWxGWMcyLQwWDcS8EzqJwv?=
 =?us-ascii?Q?I5kynTKTi95WH2QGds8qKA4VbdGgOIGGA/1t/UjdfRalH96621IS7ZrCM0k4?=
 =?us-ascii?Q?AimyHHb/qAvCKcjvT82XIH4Y6F1jKK4AL1dX7mMcKyPCd1dyKe8aEevEYK6s?=
 =?us-ascii?Q?v1LLu+pkC5XKgzG28vhjNJb91x04d5pIdm4P7MPlsNlRPIg0JFXjVybbR/k0?=
 =?us-ascii?Q?Ji1sVDREzQpowvs5jkvI/bRulRL+9arwHQJLlkGUZElD6zItjj6wF4DYnMJT?=
 =?us-ascii?Q?BJrnGuyXNJ5GmCW/FzCmz/nw/KuwHFGac+Bm9lvGd3mLWKjzJfjliWcuRMSS?=
 =?us-ascii?Q?a7MaESAUlAnpmDLfDRAbLTvx7XVgnIcMRb4VvrZA4Gmo7KEPW5+WC8b30Ykq?=
 =?us-ascii?Q?cg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JP6GkDTjCdE6xbgKSmi+SX5VYSIbP0YwNRdlhddLvdbQa81S5DkhdxENZdKpAho692e5YyOSvBlL9OMbkkokvy6WViIXHc6HPrCdT5rr6Ts1BFkxDLXSZ9anU2t7Tb0eHvpBlo1lClPY/7KGCPDEPoubJnpR2cgTtbInNEpMq5ftBHH8Ndp+HXvHA3WJMFutIaH3LjkHhblusrexWkL0qVriteYscCIHEkEJ06IcgqsLJ7A2yXXA/BTH2lJkpR4TECANVLZErd7+5cQ0urKrVSxB/J6rQX3J0Bp4KuUlf4laQFX1NHajjVJfV8xtwSfGOXUsvOKGUokJB3UTV23OaXBIgyNPDmNnO+e7RmAwRgeIsEh6P64nogS439KdrqlUMaGkydx0J3c+eiJC0Ji6E94AsWAEj2oPdALOPCKe693cxkRzl8RuTiRouaV5ToxCo1mX7AYxpPOScOifCjqAaEmbGWNS9J9gjHnwvMNHwB7mIqT4XAVi4Ju1ED25ySfKjPrtSO6iYxv7e46VAt9yXcC0b0a4R18LYXa9K8m0aYJteKRGSufdHF48o75a85VjEzkUdnuXACyvYL1UCQn8kpAuyu7vE17nEiaukpVXmdk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c257fc19-1379-4656-7162-08dd1640b946
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 21:55:39.9464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s5cviAhUOGF7cYFjwGH8frAqgxOSxQzwNzkvE0idTQAbqW0Wet6RrnFn5ISjqH+NIzXwXgWZy1pvRa2vpqN1PJxU9jEdcEdfODDFQvOfu2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5560
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-06_15,2024-12-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412060166
X-Proofpoint-ORIG-GUID: FLBhy7dsX9iodqXzu0KK-R_8n13-iGDw
X-Proofpoint-GUID: FLBhy7dsX9iodqXzu0KK-R_8n13-iGDw

Andrew - sorry, I forgot to put a subject-prefix in here - we need this as
a (fairly urgent) hotfix for 6.13 please.

Thanks!

On Fri, Dec 06, 2024 at 09:52:29PM +0000, Lorenzo Stoakes wrote:
> On second merge attempt on mmap() we incorrectly discard the possibly
> merged VMA, resulting in a possible use-after-free (and most certainly a
> reference to the wrong VMA) in this instance in the subsequent
> __mmap_complete() invocation.
>
> Correct this mistake by reassigning vma correctly if a merge succeeds in
> this case.
>
> Suggested-by: Jann Horn <jannh@google.com>
> Reported-by: syzbot+91cf8da9401355f946c3@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/67536a25.050a0220.a30f1.0149.GAE@google.com/
> Fixes: 5ac87a885aec ("mm: defer second attempt at merge on mmap()")
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  mm/vma.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/mm/vma.c b/mm/vma.c
> index 8a454a7bbc80..1ec349141f5e 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -2460,10 +2460,13 @@ unsigned long __mmap_region(struct file *file, unsigned long addr,
>
>  	/* If flags changed, we might be able to merge, so try again. */
>  	if (map.retry_merge) {
> +		struct vm_area_struct *merged;
>  		VMG_MMAP_STATE(vmg, &map, vma);
>
>  		vma_iter_config(map.vmi, map.addr, map.end);
> -		vma_merge_existing_range(&vmg);
> +		merged = vma_merge_existing_range(&vmg);
> +		if (merged)
> +			vma = merged;
>  	}
>
>  	__mmap_complete(&map, vma);
> --
> 2.47.1

