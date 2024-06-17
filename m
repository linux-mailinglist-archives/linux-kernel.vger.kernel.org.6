Return-Path: <linux-kernel+bounces-218367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4158F90BD6B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 00:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B54A31F22188
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 22:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523D0225AE;
	Mon, 17 Jun 2024 22:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KR1fYO5B";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zyQcD1Mz"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A807615F41B;
	Mon, 17 Jun 2024 22:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718662530; cv=fail; b=N6ztzNkfxlIqQNW/zZqUuOjqKzILp5mH7VYYtofl0IVYbjZ3wAB1XQlrXhcVklS+6QcNvDPl6Wj3JwDUbgmG3tIOQoBcptlLDGKR41R7eyqCZzrvlTcLNlyT7Hi+XKkhalEX5FiKU+XSmyn7161TgXQ6kH9iXKRVKSqZvpNXS90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718662530; c=relaxed/simple;
	bh=suugAVSEi4l2pI+m2KWaJDxK+soG7q0dH30gglyHYS4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=IwmwitbX5EqLxexNREksrUoWHXoV+ppOb8xCszi6QqDPC6iylBao2R93BiiYI1CWXSQGVEFHNZuXxLPGRSBDaOlRs0DJySL8cB3UQvWDLPTPSK32qbSwhxWsMOQTJ2Z0/R67hVtWcUtV+Pb2KbzIUHAheHVp6KyWZLCXuKiRGnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KR1fYO5B; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zyQcD1Mz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HItQol027874;
	Mon, 17 Jun 2024 22:15:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:in-reply-to:references:date:message-id
	:content-type:mime-version; s=corp-2023-11-20; bh=Cfuqsr5VII/8Z6
	lEPdfOHDgvWe++XgHKABErUf6YD+U=; b=KR1fYO5BYao/jsYtn1EHubzRiWU3t6
	9DODhtWPweaYvGsKPm2UpvTLUWcJrQTKw0AiWYConuuO5Q2KtII0V1W2XmVtZrSB
	YBfL0gao424ZJoHJucEt8/5hRlurQURppz9kjTPxB5soavXkor9DIzWAU4YQPYqN
	oOt0dR3CUchpfXAA06vP4mPJXZG8SBmXIxb9IiokmV8Gur/PnLSDgjvHJImLbASx
	AeNnFx2LLuxkSywEF2dpVttkoegphrIe7v2N+6eK/NbcBBA3ETZPjEIqiyW6IVbD
	UX5zq3mhkf1zcEupPBRdsyPUVaXZjq46A/tPnFBKdj1dC0dN5pd+2/HQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ys30bkqy1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Jun 2024 22:15:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45HKq7oa029244;
	Mon, 17 Jun 2024 22:15:03 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1d76r6a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Jun 2024 22:15:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0y04gTEhc8nYXMDrYyaNlobolG9KRFlFxi+g5QpWRRB4e4CuJQIzXfclijTIVSkBbiW1FvMkw+1rcLRRTFFWyR/DUTUsoaYKNvMY7z6B3qXump5M10wUYMc/czPiuGQ6hc9+5y8zq63+Fyrxwde5oeQKeVuhyiJhyvhH2JacLzVlZtr8KBABcyQLft7Sj+ELjFByXAjjHmbfM9OI9m65z6XddLtvDk3naBbQm1kc2ayYurxftnHPAFmiGg0x7zG6Vr5lgvr9uXbi9Pmzm3BtNiwk2qGlh6+9+sIdM6jNvjX85vTZUgdrijiAdSiGqdl7v409a0GOJWaa91CN6USOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cfuqsr5VII/8Z6lEPdfOHDgvWe++XgHKABErUf6YD+U=;
 b=Kh862LK2Md1lgsdlDCSslEJmk8Q+wdJtqSw5I1Bh2JinPJ9dE+E9Zbed+/lUnuiki21gMb+WFTEdyXweVJXUWe12T2Or8+gZv2uleabTBzh45cAvhWSq1Pcj3hVhnPio9psCrAu+LkRoQdmFZpdmDGwq5nynt87Qu2XghgrEiT1DfZnSpbl9uUiGQKhvRk4/Br8WGIoZCJehbpmgbnnx8Fl/uYokvYI4eQLO/2q2bZle5jiKJ8vMYZv98CNsuuFRSe04Fxlolbh7XHDszybWmNDg4i3Zl45R5rcLSGD1btL1yL7Y3uLFpp5eib1DAf/M88g2RmU/39emTIcM48Nl/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cfuqsr5VII/8Z6lEPdfOHDgvWe++XgHKABErUf6YD+U=;
 b=zyQcD1Mzl2ttFO46AzvBCXRo4xUqYlVw3CWnmSlRp32cRNyFHqApp7EqrdAq2R+e+OzbH9qi1G5isw6DX4OryMkbds9CKQnmjP8Qi4InUPEpMtkk/ZXSmlSewLt9gdpWDS+IDHla8pOpUm4xTynYv4lw5rYUVM8qXpsXlYMWYS4=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by CO6PR10MB5540.namprd10.prod.outlook.com (2603:10b6:303:137::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Mon, 17 Jun
 2024 22:15:00 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%3]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 22:15:00 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>,
        "Vishal Moola
 (Oracle)" <vishal.moola@gmail.com>,
        Omar Sandoval <osandov@osandov.com>,
        David Hildenbrand <david@redhat.com>,
        "Matthew Wilcox (Oracle)"
 <willy@infradead.org>,
        Hao Ge <gehao@kylinos.cn>, linux-debuggers@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] mm: convert page type macros to enum
In-Reply-To: <20240617142951.08a9cdc791c8edeeca50509b@linux-foundation.org>
References: <20240607202954.1198180-1-stephen.s.brennan@oracle.com>
 <20240607212738.bf55318aebd7172fadaa11c5@linux-foundation.org>
 <87ikygo1yb.fsf@oracle.com> <87bk3z1f76.fsf@oracle.com>
 <20240617142951.08a9cdc791c8edeeca50509b@linux-foundation.org>
Date: Mon, 17 Jun 2024 15:14:58 -0700
Message-ID: <878qz31ajh.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0290.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::25) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|CO6PR10MB5540:EE_
X-MS-Office365-Filtering-Correlation-Id: e2e3b9f3-ff8f-4881-0f54-08dc8f1aedfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|7416011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?tAVWKZLw4Cvw6BvIbx+Kq3ZkdhhUNf4PMM37IhftV435nksderKI92NlvBq4?=
 =?us-ascii?Q?JFT8A9AjE6sJWDjXF/XcB96ktxKz7n+LIq7Tmi4vsuudYgbDruoalK9WZyht?=
 =?us-ascii?Q?ilAhHdPTzF1wh/CqjpSKN+CoBJwlzmI7nCrfvhdHFGPuLDfZ35lNfP6La428?=
 =?us-ascii?Q?enah1n/I+2S89YtBejcOX1daJMh4cKYcflAU2gu/4Lhmfa0zhcFWUr8s1g/J?=
 =?us-ascii?Q?iBlhLbpZhkVYj3If/jOJiGPhzya5NEN950rbmS5PUtAhDVc3tJPTRijE6Con?=
 =?us-ascii?Q?AakZghg+jbRO/Q790WYbM7pR/QgkZ7klddgXlSgnK67/w0JlSyTjSvh7rNmA?=
 =?us-ascii?Q?xv3ozoxb5gg9rxMqgjefbEnMunD0GKPSdYIdoKpYDYpc0kHnoGmjHgKZUQta?=
 =?us-ascii?Q?KnsklGERKqxPXZJXuxxEpsR2GYKG6LPltlXEZGY1fO/TYx+hI8N3yuhZIpHF?=
 =?us-ascii?Q?WKWEZhTPCJte6ypZ2Qc1pNAoZmae/yh7dG0tjA2MsEMpQ0Fkw4mWQ1g3OU3e?=
 =?us-ascii?Q?nJqaKfQ18NrkDfWhfGFQ3bq4ErL1Bk9qjoirOqRESGFJANt8XtJ0y8IgGO9y?=
 =?us-ascii?Q?qT1Y6+idKStyLsbimj2/6xNHAycSQRcsxq4nZ5TbTxmgEaB6TW+GFgdJGm7t?=
 =?us-ascii?Q?DxhSKfEphDhvQS1mLdXYS2yQFWRtIKC2pMcz4ztHIqhQNXVUJgNNi+82Pma1?=
 =?us-ascii?Q?gYEXBs7c0ECmcEqkB8bwjz9dnd1KEiGFy1hRz26xQJtRDYI+xTJFylK1Df9Y?=
 =?us-ascii?Q?0J/+OUxFJd3OQMdg1ATXM4AVNt9Jp8Ri8G/H9UTvogtMZI7fqopSdIsYp1mL?=
 =?us-ascii?Q?Wh3LeSSL2SZzwTkM6AglGW0YmcPzkGnaRs44I4bB+MTV6v+Y3UWSzPA3RkKU?=
 =?us-ascii?Q?sTWWHgD3sMps4AzvalnsuqbKdUOtwNkfOpW7mxvxMO7VEpD9q4TrJET7Lmgy?=
 =?us-ascii?Q?3utILUAnoWVe83WwMrWIKxIQPQ79I+5l94FJvMu0g2qTo07MMTCSGUxd34bX?=
 =?us-ascii?Q?jCi1nvy2UXmNYza5XQvLr5oeF/GOaaPA59tbYgiYVxd9d1gbbDLO0Aj0BjX+?=
 =?us-ascii?Q?jbfFM05VRUYY9yqVtilsmlR/eQMxi3z6RMPQ8HrQT5p3NXXAFHT0E5lDwFGD?=
 =?us-ascii?Q?a/Le7beUD6Wpk/48c6WQgGAQBn1MwWYU29X1EeW5+PIdzAIE2VK6PdAopYqs?=
 =?us-ascii?Q?UwxoHNSuoRHS+9i3vxKuoDeCQGQth+qhp55A9t30QIHQoplxQjip/ugEpGmm?=
 =?us-ascii?Q?OhMvWx2imoOf7kozonKV?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?/a7c6CLa5ejkMvYyLcXXtSWG0wTQQuKTwHbCeJMHY2aBmeQgStsxeshjoCoK?=
 =?us-ascii?Q?aEPFPSABADErivSFcbLjE7jIX2/phV5KywJ+23eymLQhLMkmpzaJEhib6Yxt?=
 =?us-ascii?Q?NZ+OPeSQ9ATT5nSrCK3pElhSi3y8+nvd7BbIHCNgZT0Vz3XICJNs03WeVriU?=
 =?us-ascii?Q?zh6MKeyy1LPoHDAdSTBwjsupjDdFEqFnrGsjWGH1mEJxPH/brsPn5+3Nx9v3?=
 =?us-ascii?Q?s6GaIgLA38BT2R4jN63IQF+fb2+/LBqDxu4++EBu6Z6i628KYkDpGTu0aKk4?=
 =?us-ascii?Q?TFI7yu4SkF6vA1JUUMaCqW3STgEoaTmwYZKhMZO9cm/J70ba/uHNCTG1OTyD?=
 =?us-ascii?Q?/VSiGYA6YJC88Y2uwc5zRNeG23CdHtFtnLqyHBNtMYzV/NlDh8ge4LgKi5oU?=
 =?us-ascii?Q?QtZ8bFsH/8qBqrR9VTrWv7zdtRzr3BqkvAhaRLUydtXY3v3G/i8lhnIwh8od?=
 =?us-ascii?Q?w961vxzKUe6EqsHKzJDrCgQLFZshZz7Fext+jSBtklqWKQwctvaXs+9nmgRg?=
 =?us-ascii?Q?PskW54JTpvGl/6FFx7eOhbwU4yBsP1H2KcfWvVipczGzVqYWOjYYYV/lbl+C?=
 =?us-ascii?Q?B9SeanlSaU7VeurX3laYjfzCPQ32o6FJMZGdxJhasBbQYrpGdIHTKxZmIwc8?=
 =?us-ascii?Q?DGXa2AdF4CxUZVnYvq+TMErAy4LmVob6+zJSeVolQamw9KIoGrVleQy9gkRn?=
 =?us-ascii?Q?PUqhBUdMCsa8TTL4P/RF0of0AaxCGVoB34R2isHz0qS63YhVPYcDqEgPyxxg?=
 =?us-ascii?Q?sS/ggOM1Ksce/cjQU5wSF0ekpIYUHt6CqDd36IwdTKIh7h20wIRxa72hQx8m?=
 =?us-ascii?Q?0mGnZcLCLdIUWX67nBSWHUERpbrSNRREyz/ykKIVn4TFF9sCoxZSN9MN7Rv/?=
 =?us-ascii?Q?SUFRbceCWKu6x5O2cnCCz0zjNwDQf7dim7De7s5aTlSXZt+ZXisCmTEfR8bz?=
 =?us-ascii?Q?24NOdB6A2yAlQcW//8xyZOlP3AMxGP2LzRaLtH/Werz9/IzpPQyK5hFKtENU?=
 =?us-ascii?Q?QTitxb7rd7Rg8XbjjsGeuoU+MCUKEPoC3p+h21teuo/zWrWfIr2ARGyBEvsI?=
 =?us-ascii?Q?hPjU65W+umNwlW8e/6LGefvjl0C/83VCsg/ROlGVl65SSa/9eYpoQvC9Pezs?=
 =?us-ascii?Q?gj8ZxQDcv/FWUB/Fyuz0WpxW2RQWIhmCCitznu95xK08/jcuyjorwDqgB3Dx?=
 =?us-ascii?Q?fpuDySfuBZdEbTCjaIeO5F8C+GLofTdFClEqYDBVn9FrZ8+WnFVV2MOnBmnX?=
 =?us-ascii?Q?hGSQ1ZzpWeIVGGe5hK7LpK2M7WmmWIX3L1wtC0nvQ7dfcLKmN76ivFys98Lo?=
 =?us-ascii?Q?SBmOUlyoVFm0AMpJrvRRuVLArWHdCainvh2A8LpHcSV7V3tvlPOXVz03IW8W?=
 =?us-ascii?Q?qaeANxnH/McEdNKGOGh2x0GZvmc1glFTQrj1oYBNgygrDlJdsgCXkuyM3Lc5?=
 =?us-ascii?Q?nAnieKFajfHpgvSY6kAsgWau14AzKL2FzimDxOvnFK7zkMKoUTnZftDNzHpL?=
 =?us-ascii?Q?AmYckFU6fsJKBECUXCFCh613ucRry2vaMaLmEWS4xDOGqWSfpubyXAxlMM8e?=
 =?us-ascii?Q?gjSkFs6LVsyh8l2qU/nTn55c3WhaKqhgJn3fyx6+qONnmZECOM3KIilxfifO?=
 =?us-ascii?Q?Yg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	XG/KKCYVjt78lCl7HEYkczfHS+O4KTxfBkQM7HNQEC9BzqRfTxzQcupUR0DfNSUhfw1UgisHFAZPcf9HHzwJS0h+1O73xlCqcb7JAQvyK9wc8Wk+Y8Ngt063aET5l6IA5Kn9cb/iQZHTG6LnUk2jIZODLUbB3+CmcsmHRcM67sjAeVUK0nLN+X0g7Hfao3/APFJJ8ElMBd/xrUfaPrWNXa9SYR8+N2NoKHVaSCdewmxNis2/l/ToqYVGlalo3n569IAMNBhUMTn3u9VRy/ahaotT3QiyApDkZAaHu/+9LJdu1+vmIVXadz4My4A9koyXLN7bBr+1qWPcVueJ+sma3DY5nnk80EVnnzjHfFBGk10EeduiqJMUxYsvpburyaVFs0x5Yfjj/p9Clk1u4QR8hKaulxhDcykJ7UyQk018mryhfEoGs/PTy6JM7LrdamRkPUwIJmI6ajvwx1/DK7LnSH22H212gQW8CxgjDdfsAwV+aeXH0XGFZ+5ZS9rvDl93X3CQJj5m9StSZmOL5FsGg+7l0nEhIv/AKkNr9y09ma+ml65uLdk+xBZzzYb4GvkNnxnZnLbK+0PLQQ1l4tDkZLjelqCMU+479Pgj2UaVvGs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e3b9f3-ff8f-4881-0f54-08dc8f1aedfe
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 22:15:00.5773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EdSw8PDx8B7qHjNclBkvK6M6+tUDRQiKv72eZe5lUiU9y6JfPDf2174WWIULwE6a3ZZRtt3gpsk4WbzAn8FunOcEdh/jkq0xp+d36tyx2CM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5540
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_14,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406170172
X-Proofpoint-GUID: mFfX9s2cE27xWaXS7jSWmoqvtcHPs-9z
X-Proofpoint-ORIG-GUID: mFfX9s2cE27xWaXS7jSWmoqvtcHPs-9z

Andrew Morton <akpm@linux-foundation.org> writes:
> On Mon, 17 Jun 2024 13:34:21 -0700 Stephen Brennan <stephen.s.brennan@oracle.com> wrote:
>
>> >>> Fixes: 46df8e73a4a3 ("mm: free up PG_slab")
>> >>
>> >> Should we backport this into 6.9.x?
>> >
>> > Hi Andrew,
>> >
>> > Looks like commit 46df8e73a4a3 ("mm: free up PG_slab") is introduced in
>> > the v6.10-rc's, and not backported to 6.9. So PG_slab is still part of
>> 
>> Hi Andrew,
>> 
>> I saw that you've merged this into mm-unstable, thank you!
>> 
>> Since 46df8e73a4a3 ("mm: free up PG_slab") is part of the current 6.10
>> RC, it would be great if this patch could be part of the 6.10 release so
>> we don't release a kernel missing the PG_slab info.
>> 
>> Can you confirm if mm-unstable will get merged in this release cycle? Or
>> else, would it be possible to include it in a branch that will?
>
> Turns out the patch as sent was based on David's "mm: allow reuse of
> the lower 16 bit of the page type with an actual type", which changed
> the page flags a lot,  I redid this patch thusly:
>
> --- a/include/linux/page-flags.h~mm-convert-page-type-macros-to-enum
> +++ a/include/linux/page-flags.h
> @@ -944,15 +944,22 @@ PAGEFLAG_FALSE(HasHWPoisoned, has_hwpois
>   * mistaken for a page type value.
>   */
>  
> -#define PAGE_TYPE_BASE	0xf0000000
> -/* Reserve		0x0000007f to catch underflows of _mapcount */
> -#define PAGE_MAPCOUNT_RESERVE	-128
> -#define PG_buddy	0x00000080
> -#define PG_offline	0x00000100
> -#define PG_table	0x00000200
> -#define PG_guard	0x00000400
> -#define PG_hugetlb	0x00000800
> -#define PG_slab		0x00001000
> +enum pagetype {
> +	/*
> +	 * Reserve 0xffff0000 - 0xfffffffe to catch _mapcount underflows and
> +	 * allow owners that set a type to reuse the lower 16 bit for their own
> +	 * purposes.
> +	 */

This comment is a bit out of place now, because it refers to David's
change which has not yet been applied. Maybe it should continue to read

"Reserve	0x0000007f to catch underflows of _mapcount"

until "mm: allow reuse of the lower 16 bit of the page type with an
actual type" changes it?

> +	PG_buddy	= 0x00000080,
> +	PG_offline	= 0x00000100,
> +	PG_table	= 0x00000200,
> +	PG_guard	= 0x00000400,
> +	PG_hugetlb	= 0x00000800,
> +	PG_slab		= 0x00001000,
> +
> +	PAGE_TYPE_BASE	= 0xf0000000,
> +	PAGE_MAPCOUNT_RESERVE	= -128,
> +};
>  
>  #define PageType(page, flag)						\
>  	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
> _
>
> (please check carefully)

The rest looks great, and otherwise equivalent to the v2 I sent which
was based on the master branch at the time:
https://lore.kernel.org/linux-mm/20240606182630.851750-1-stephen.s.brennan@oracle.com/

Reviewed-by: Stephen Brennan <stephen.s.brennan@oracle.com>

In case you'd like the tag.

> and David's later "mm: allow reuse of the lower 16 bit of the page type
> with an actual type" becomes 
>
>  include/linux/mm_types.h   |    5 +++++
>  include/linux/page-flags.h |   16 ++++++++--------
>  2 files changed, 13 insertions(+), 8 deletions(-)
>
> --- a/include/linux/mm_types.h~mm-allow-reuse-of-the-lower-16-bit-of-the-page-type-with-an-actual-type
> +++ a/include/linux/mm_types.h
> @@ -157,6 +157,11 @@ struct page {
>  		 *
>  		 * See page-flags.h for a list of page types which are currently
>  		 * stored here.
> +		 *
> +		 * Owners of typed folios may reuse the lower 16 bit of the
> +		 * head page page_type field after setting the page type,
> +		 * but must reset these 16 bit to -1 before clearing the
> +		 * page type.
>  		 */
>  		unsigned int page_type;
>  
> --- a/include/linux/page-flags.h~mm-allow-reuse-of-the-lower-16-bit-of-the-page-type-with-an-actual-type
> +++ a/include/linux/page-flags.h
> @@ -951,15 +951,15 @@ enum pagetype {
>  	 * allow owners that set a type to reuse the lower 16 bit for their own
>  	 * purposes.
>  	 */
> -	PG_buddy	= 0x00000080,
> -	PG_offline	= 0x00000100,
> -	PG_table	= 0x00000200,
> -	PG_guard	= 0x00000400,
> -	PG_hugetlb	= 0x00000800,
> -	PG_slab		= 0x00001000,
> +	PG_buddy	= 0x40000000,
> +	PG_offline	= 0x20000000,
> +	PG_table	= 0x10000000,
> +	PG_guard	= 0x08000000,
> +	PG_hugetlb	= 0x04008000,
> +	PG_slab		= 0x02000000,
>  
> -	PAGE_TYPE_BASE	= 0xf0000000,
> -	PAGE_MAPCOUNT_RESERVE	= -128,
> +	PAGE_TYPE_BASE	= 0x80000000,
> +	PAGE_MAPCOUNT_RESERVE	=  (~0x0000ffff),
>  };
>  
>  #define PageType(page, flag)						\
> _
>
> and that patch's fixup becomes
>
> --- a/include/linux/page-flags.h~mm-allow-reuse-of-the-lower-16-bit-of-the-page-type-with-an-actual-type-fix
> +++ a/include/linux/page-flags.h
> @@ -955,7 +955,7 @@ enum pagetype {
>  	PG_offline	= 0x20000000,
>  	PG_table	= 0x10000000,
>  	PG_guard	= 0x08000000,
> -	PG_hugetlb	= 0x04008000,
> +	PG_hugetlb	= 0x04000000,
>  	PG_slab		= 0x02000000,
>  
>  	PAGE_TYPE_BASE	= 0x80000000,
> _
>
> and "mm/zsmalloc: use a proper page type" becomes, in part,
>
> --- a/include/linux/page-flags.h~mm-zsmalloc-use-a-proper-page-type
> +++ a/include/linux/page-flags.h
> @@ -957,6 +957,7 @@ enum pagetype {
>  	PG_guard	= 0x08000000,
>  	PG_hugetlb	= 0x04000000,
>  	PG_slab		= 0x02000000,
> +	PG_zsmalloc	= 0x01000000,
>  
>  	PAGE_TYPE_BASE	= 0x80000000,
>  	PAGE_MAPCOUNT_RESERVE	=  (~0x0000ffff),
>
>
>
> and the end result is identical to yesterday's mm-everything so that's
> all good.
>
> However I wouldn't want to send the altered version of "mm: convert
> page type macros to enum" into 6.10-rcX because it gets so altered by
> David's mm-unstable changes for the next merge window.  The new version
> of the hotfixes patch won't have had any valid testing on its own.
>
> So I'll temporarily drop David's "mm: page_type, zsmalloc and
> page_mapcount_reset()" series from mm-unstable.  To permit the new "mm:
> convert page type macros to enum" to get some linux-next exposure. 
> David, please remind me to restore that series in a week or so?

Sorry for all the shuffling, and thank you very much for helping out on
this.

Thanks,
Stephen

