Return-Path: <linux-kernel+bounces-295743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DFD95A103
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 17:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F0AA28579B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C035754673;
	Wed, 21 Aug 2024 15:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q7u0VwNs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VL0PL5HR"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A2B13A3F2
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 15:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252987; cv=fail; b=CEoAbMWaOO9UPB34QcFEdeKIgq2JeTKDKoo1Kvz0bTsza3DAAnWIG7LFN9i+wD1FfoolVB5L8b9p/8M18F7FTX+AvklgU0K/oPQ+XW6q1J6Mc9/pCGg53H4k05CoRse/KhqOWYTdmNYiOIMxjPoNjHIGi0zADGRLJepLw1zWIZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252987; c=relaxed/simple;
	bh=/VnHL45r4IwQuuoG4Y0hHsvkBIiq6LDeBgRhMV1N6is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q1epBPTBiHpW+JBGOoWRVIbfy6+uCf+Dsj60hqa5S5LwLMyjOnydM+PTtvfot2oTWqTq7dWzm1TTzujNjDbcUZ+vp7x+DEQVrhXEn8hTekCsk3GG5wO9q2gks3FwjgHhEmAPMSLJHGQLLSVCmUL+5ZqJ2BQzfagiocYTxx1HhUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Q7u0VwNs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VL0PL5HR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47LDIaRI028666;
	Wed, 21 Aug 2024 15:09:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=4WtZtMJ6qL3hlHm
	AJksduiCSBtbYVl4ne6pvAx00VxM=; b=Q7u0VwNsC6p6AL5OHHaVmmsjmDhEpVV
	JkeRagvfSQAxIhl4QQCvVxLz9j1SxYq01s5OchMLlZvOzAy2ESHmq50DQw7nE5lo
	B9GXkWFmacfvMKWr7VaU8/xIfFCS/6m/H9OeKXHm6dzmM4fE3DXNEsShehgmy8da
	FUgBmtBZkSmgV7ehDxZndsbLQor1VSOfaj9wsIggpW2F/Gm723fIAzQpcGmaQEYO
	hbAZXtegfUY9Fau/fUIfsW8oA0JQ4eONXxjqhsB1JPXYCa05yLTMld0VpCJJlXnS
	4TP/KF+s6kYG3RdWruUtTuCvNnxHVI0I45Gi+QqaKjq1l/77Qvtwj8A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412mdsysrd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 15:09:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47LEs4p9018449;
	Wed, 21 Aug 2024 15:09:19 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 415jdhgquy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 15:09:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZBU+CHtg+3Gr6472Gskmzn4PJPgH3hwazcCBo69ZPLnFFn65s1sA4d7uTWSMyEK0PJ0QD6Qh9x62Py1TfH+04M5rS0nG/lDXaAZzihSTLni+Fpp9X83LaRbADF+x+oe/XVhuqxvo+JbREGdBdUdll6OtX5EFsJxmDjl7QUe9vU/SmRx20DwzH9KwP9lHjcWha4gs/PIbpwRSmfW2JaimzPGvXBJQCDVVt+Nea5AP6gJLXTZX2MYH0sRgWnKfBO7y/KlajnSWq2WNJBC5mwib7pWsJgpoeMeQzDFxJq9eRQvf52oSrEWM1xawRvsIkSnz2No33SzPGyygldx20FvpqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4WtZtMJ6qL3hlHmAJksduiCSBtbYVl4ne6pvAx00VxM=;
 b=xye0V2rNtVAstuzA7xqXnSjn32xgIhJ6LSt25QPUqeEphOE0T0/ctfh5IlUtZhGg/J7i8diLG1KPEhuWk2YcFE1XqhY35IXDOR30RBvm54KR6qHl3rcnvDYm30LLkl7rbJVxYxcJoPOlYfujlcU2nvFY1LGw0y0Gvg8yd4ykvZ1fvSgHzjkOb0uYKHdLd5XNV30U+WsuhQzzwBqTNCMG2muIM4HhWzxHsKU+w9nB6crIzNggywN3oaFdwO0qEPVgAoPCKdlqYcdQBvrKQ45DhIePcCRji8ELGMj5SEzZK2VV+tusu7mv4nClfGy9SeOLLy1/LDhjPWabvzMbVTVS/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4WtZtMJ6qL3hlHmAJksduiCSBtbYVl4ne6pvAx00VxM=;
 b=VL0PL5HRx/bGTSzzfC5ndzPJxLzJFhPOeVq7M3sfcVp7RYpdI2MiIN5s6M4i2lQju8P3BrWZvet4sxeIKfvfjmp2xtFyRPaetx21VIzd1SaCjLqsMRSbtEY9Joc8Mj1q1R/P5OTcjrR0dZfHm5AjfrRcrdnHdV41nD6swx2V1uk=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CO1PR10MB4643.namprd10.prod.outlook.com (2603:10b6:303:9c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Wed, 21 Aug
 2024 15:09:15 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 15:09:15 +0000
Date: Wed, 21 Aug 2024 11:09:05 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v6 14/20] mm/mmap: Avoid zeroing vma tree in mmap_region()
Message-ID: <aoevmpdetlmrbovizowf6wopdxjmbfhyeauacl2jjrjkmo5wje@xx2iusouwpfg>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, sidhartha.kumar@oracle.com, 
	Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>, 
	"Paul E . McKenney" <paulmck@kernel.org>
References: <20240820235730.2852400-1-Liam.Howlett@oracle.com>
 <20240820235730.2852400-15-Liam.Howlett@oracle.com>
 <22b6346d-b8a0-4d89-b886-1ac2c9ce6ba4@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22b6346d-b8a0-4d89-b886-1ac2c9ce6ba4@lucifer.local>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4P288CA0040.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::21) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CO1PR10MB4643:EE_
X-MS-Office365-Filtering-Correlation-Id: 074fe3b8-ef7b-413e-1cd1-08dcc1f33510
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zVqdM+/Lztq/NLWpCoqRmERz22NJBXzkeCd8IIRbbZnF/Igu3tKFCTC67hMu?=
 =?us-ascii?Q?WPvrYCxrjCwT3JKnLN62k6SJ3aLHDb8wglJ/lFhuB4SoNEhPfIjDjDKge5FY?=
 =?us-ascii?Q?5czbl5pBMegxuOu9GKFK1JPF4CPwVHL493mTSEjFBveI5r+JKDg2WASFRQ+8?=
 =?us-ascii?Q?noP8sRsBEuILkQW7tV1tDudvq7HBAbMrCRDkTPhCDCdClWu4Gf7yod1Rx+gr?=
 =?us-ascii?Q?vDAHZwZxmZhX3bgK+87mgsjtlnqc0qvwjkebCrwp1QZp4W7rQTiDw+3J4jRX?=
 =?us-ascii?Q?qknC4gOOHuj0G2NTa6GE9pUrUyxHWSN7XJ7CtfzYDjHB5kzHrtehPRJOmcV1?=
 =?us-ascii?Q?IyGEjHixx8HelcdTJshtgA54wK6ZAWoJeG1vddYMXcs0Wko1Q9t2719HfTNv?=
 =?us-ascii?Q?ypl/MRs2ec0T60XoELwgKrIsU+vtr9uav57OTWag3tuaJ2vxZfX2kSWeJMdv?=
 =?us-ascii?Q?4oc+CQhfkqlE4kTNzmUstMtGkRA2sWAfHLLdO+zeXM5hTAImNnP3hB/osOmz?=
 =?us-ascii?Q?K6/cCyFZF8xOjAdMNCPlfTiDor889B4MQfjjuCS8anwHU8nyN0YRP6KN0tyK?=
 =?us-ascii?Q?lBxAeM3OwsWCqvhF9/zLZ+rU3YEaJiTeIPeVGkz2SvjwQftbMqn0/tskB5li?=
 =?us-ascii?Q?LFrADxTZODp8qQPAJ45hiF/CcguI5K6RgxNV+Da4mvatiJiQ/RIaP3S67Igi?=
 =?us-ascii?Q?j4TivbhdNvU3OzO6oKnQl4YWbw3R3QhwglCCW4I+Qfb+fmwh/t6py+MTmvaa?=
 =?us-ascii?Q?ZiQbO96sTOP9z/A3p7QFYrUlFriQe4eyTgHSfdVbxP8cGF38JSSD9t84yFw5?=
 =?us-ascii?Q?Vs9MPhWnoCChYsXH2TYICNnDJLWmcNXmSS49wqFqUulUytm/2ON2uxOEKwAH?=
 =?us-ascii?Q?v4K0JOkbNe3XlTFuDNX9ktGmk5HYAOjwiSOcXa6TOjt3Ap2etgQA9cjqa4e8?=
 =?us-ascii?Q?AFKNgWb8DnFynUVA1oFeCnD1jhLKhvFzCNCMP5rzelSgFu23QKo6IGjasHbu?=
 =?us-ascii?Q?iVzLwE2ALyiMYOrcYhB8YEPt5hKlIxpYJPwM65Cj1D2Qz2YxlqjnajPPwT+h?=
 =?us-ascii?Q?Hr9k07xDIhBrqBRh88dRk2dXdyJLEcpihTjXaO0UrEzv2Q++Bs0o680EHJbk?=
 =?us-ascii?Q?7nBsbT8sG7A0yvhdGikLlDtTcF10nfwBinxcz9kV7RdZABJh1en3hGx2YmZn?=
 =?us-ascii?Q?rCB+LC7lYuK++2RgbfzKevvh1Z4CofWg/qjRx11HzGuEVyfBnDdfIIs5+R6V?=
 =?us-ascii?Q?Ja65iy5qsAHybkioqkGVR/IHMnsx7c0kC4PSbtlmWW59/1e/kYP0/yIiQEJO?=
 =?us-ascii?Q?DGtbgdmDopXlbgYA/XcZ5iIKPQC5ddKo09OzwN2RT3zTyw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?icjefGtFjFfg1/eE7rBebv5xyRl6fxtuMoRT1LB0Cy8pYsYTfDM79k6Kndfa?=
 =?us-ascii?Q?pMw5KvsXYi2Ka9p81SdNy7i98+tdnspTYGyNFDQmFIxw13wQf02mqJpVWMBk?=
 =?us-ascii?Q?O1iHRnqkWrWxxAyKrSAzyrfnSjImVIAapLdaqNf+JtKzLQBQCoVeavZWDc1l?=
 =?us-ascii?Q?n0m9oOLVezkgRyM9aetB/df+CFYugmdw/lO4fia2QFtKLB39/CyXbh/4iSKS?=
 =?us-ascii?Q?9g2dQbyaHGqrw8CsJloCl2IGgjzKhOTYJd0XFZbLHjg3tpJXihUs2EGjsN1G?=
 =?us-ascii?Q?Bgo1E8slFlCEDAJBteMCmFyMw1lqz1sb7aYhldzkzBIG7DJi8D5TrFcuIzHL?=
 =?us-ascii?Q?dHY+pgfNoAkarbsFQ5hPjNXy3C2Qczwt4g4DfT1o6eNFQQ8Bb7OKrhKM1Uo1?=
 =?us-ascii?Q?lCpWMwLv0XP96mhZfFHZujBs0fLLsRj4AldVw9uLkcySHM8a+E4CoI2E/b9e?=
 =?us-ascii?Q?ZSq4cIi3pjtWlVmHD2epMiyOSe6trOlf7sDlp469nYKOXOtngCwWDya2yA1n?=
 =?us-ascii?Q?lSF37zicAgw74YAlRJUGt8wxNVPjLuTgiS4hFnAYBVzo4hGA0d+bhlZL7Hgf?=
 =?us-ascii?Q?PmmC7LaQ+tqerF0905WfNdNf+mrv0n0/Yz79N9W8Ugj1a3sz6eUHlizLbOPT?=
 =?us-ascii?Q?ZLsaN3Hyq6EghEQmR7OARM9xW19RPehIcb8RAqFVv3v538rOWDmp1Cm62T/G?=
 =?us-ascii?Q?2XfKYJFIUzPS9e7Eh2MH4xmLO5RWovKvqLXMEakBKNoJpjN4dtySHt5JSFQG?=
 =?us-ascii?Q?ZFSBScqASHxMQxlBcqjngkVgDPFbug3HWn8W3fPxBgnlauilLblqo62K7phH?=
 =?us-ascii?Q?Q1E8dnkkRp7IxJK7ougXwyplocz4gncpbU+CGnXbLkwRdvA4Tv977Rp7ILhC?=
 =?us-ascii?Q?2m/FwLDvjSDcRKGfZDOEa1Io0fe8SVAKsSJ0nULdz9YzytdeRd6BebcWhkSx?=
 =?us-ascii?Q?3peLkD6Uytz/cLGLn2Vtu9i1kRzoYLu392h6Uv4xvOQH4vmqTBs+Pr2s7zls?=
 =?us-ascii?Q?kxoy52eohEmZAMAoIrV/lCrjFdn8uXEDLyoblI7w+bUm3Ck356ADJlqlPrl9?=
 =?us-ascii?Q?+c0SdZmPqJV+gczbnH+UmdSbR+w80I/Q5EQV/AJR6qB1Ps8ywcYHfGpNVROD?=
 =?us-ascii?Q?bQJG4V6Vkrqb9mS/rsjAUS/vOy+HTQ/TDHzUfTZuhDCePH3w1vCdj563RrpJ?=
 =?us-ascii?Q?eWBWGiERguHHf/b/Ucli7o8hK9RzwEC419kGC5wjmwkoST92ZfZmyPsqIkif?=
 =?us-ascii?Q?7bg5qoR6DBlBD6hPOk31dUiYAl62qhR73XkxokD79D0Lksx48Bvwfo1QPjLB?=
 =?us-ascii?Q?kD3lj+dHNatyieI6WjYxijx/h4ttBjGGBXsDsrgUvCYJZCekb24dFEcehSho?=
 =?us-ascii?Q?t+Gq7MZGC1ZeD5KDm8AZwldvG4W6kh/FXECU5W/ISlXQYYiCtMgDMKSZ7hen?=
 =?us-ascii?Q?GcwWKuFnRTEfwawduf9JQnsgLFezEM68zEopX4yslnvXav8kI+wlOb+Q+OVW?=
 =?us-ascii?Q?I+OKGqmzQeK/eR5TqxK2asFJiEIR/e6eB+/CJ1oSBf4U41UXjkLnsA7MG3tO?=
 =?us-ascii?Q?4UAjQMfEXx5J4Ex+ebLBqRKr5Ct9CW1jdChy2nNhidLdUyALF52w0R7SzNzT?=
 =?us-ascii?Q?lw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	E0w/0YXV41XASWiL/KdBxT8rZ2f0FXIcP0TRVAjYfl1JT72dUVlOHFVHdqzhnsmIbPqxuyEjBHCWBABUVVasNxzHXFClgNdF9L4F1vjhrNNOczvPXUBAVGTtVVjPuFIwh3aArq0yB8JPp9bexOZ0UiO/cydZ+g0dP/IIWL6gZJAUMOtb44MjVQ9zjP6stzmeoL9tcP/tWelNVXV1uu4yNpt8f8bEfop7BHvNK/7RXhtjfy2tp6DyzhDJYdj4KlaHkI2wRVOUBC7zzOy15QngWDu2uTo/gtyAwvI43sjBOVvsXrsv6Uvq8uFfLjZigLr7cw85DOWsakKmIJ3pKBlD76wCf0Go+qZxABfIq21cF/EAve/wuzvTmnt0hjDdaUQlB/+PHtZ/kCNoVjW4gr/fWZHI0zl3EIXWc/Qa/sYBuZV9ayMhaj+8y+87XtOU3ixwTMt0ODBZKls9Brl7ndDQZ08EjZVFYLCyW1hsY5glOpsMHfj2SC+C0qBFw25t1ESONWpbFpRG2XkZlsyJQgx24KAvPClS7NuIDRL4FrRfL154RcN/AHkHnpZ1F/REdd5/PttD70miO3W0tDbRtK+Qkt6NyP2b+F0Qbk+UE8AV6Ro=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 074fe3b8-ef7b-413e-1cd1-08dcc1f33510
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 15:09:14.6609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xGJOjVEJcMiV1w6KAiHNjn1D3+hhsVBCDQytOxJyXbE90Qjvpt6vFzbKTEkogkgqV/JUDhijQhr7tra4yEq5KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4643
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_11,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408210110
X-Proofpoint-ORIG-GUID: 6EWajmlELM0Un5irGaoQnzjLpnwMktZP
X-Proofpoint-GUID: 6EWajmlELM0Un5irGaoQnzjLpnwMktZP

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240821 07:02]:
> On Tue, Aug 20, 2024 at 07:57:23PM GMT, Liam R. Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >
> > Instead of zeroing the vma tree and then overwriting the area, let the
> > area be overwritten and then clean up the gathered vmas using
> > vms_complete_munmap_vmas().
> >
> > To ensure locking is downgraded correctly, the mm is set regardless of
> > MAP_FIXED or not (NULL vma).
> >
> > If a driver is mapping over an existing vma, then clear the ptes before
> > the call_mmap() invocation.  This is done using the vms_clean_up_area()
> > helper.  If there is a close vm_ops, that must also be called to ensure
> > any cleanup is done before mapping over the area.  This also means that
> > calling open has been added to the abort of an unmap operation, for now.
> 
> Might be worth explicitly expanding this to say that this isn't a permanent
> solution because of asymmetric vm_ops->open() / close().

Yes, I will expand it.

> 
> >
> > Temporarily keep track of the number of pages that will be removed and
> > reduce the charged amount.
> >
> > This also drops the validate_mm() call in the vma_expand() function.
> > It is necessary to drop the validate as it would fail since the mm
> > map_count would be incorrect during a vma expansion, prior to the
> > cleanup from vms_complete_munmap_vmas().
> >
> > Clean up the error handing of the vms_gather_munmap_vmas() by calling
> > the verification within the function.
> >
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> 
> Broadly looks good, some nits and questions below, but generally:
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> 
> > ---
> >  mm/mmap.c | 62 ++++++++++++++++++++++++++-----------------------------
> >  mm/vma.c  | 54 +++++++++++++++++++++++++++++++++++++-----------
> >  mm/vma.h  | 22 ++++++++++++++------
> >  3 files changed, 87 insertions(+), 51 deletions(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 71b2bad717b6..6550d9470d3a 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -1373,23 +1373,19 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  	unsigned long merge_start = addr, merge_end = end;
> >  	bool writable_file_mapping = false;
> >  	pgoff_t vm_pgoff;
> > -	int error;
> > +	int error = -ENOMEM;
> >  	VMA_ITERATOR(vmi, mm, addr);
> > +	unsigned long nr_pages, nr_accounted;
> >
> > -	/* Check against address space limit. */
> > -	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
> > -		unsigned long nr_pages;
> > +	nr_pages = count_vma_pages_range(mm, addr, end, &nr_accounted);
> >
> > -		/*
> > -		 * MAP_FIXED may remove pages of mappings that intersects with
> > -		 * requested mapping. Account for the pages it would unmap.
> > -		 */
> > -		nr_pages = count_vma_pages_range(mm, addr, end);
> > -
> > -		if (!may_expand_vm(mm, vm_flags,
> > -					(len >> PAGE_SHIFT) - nr_pages))
> > -			return -ENOMEM;
> > -	}
> > +	/*
> > +	 * Check against address space limit.
> > +	 * MAP_FIXED may remove pages of mappings that intersects with requested
> > +	 * mapping. Account for the pages it would unmap.
> > +	 */
> > +	if (!may_expand_vm(mm, vm_flags, (len >> PAGE_SHIFT) - nr_pages))
> > +		return -ENOMEM;
> >
> >  	/* Find the first overlapping VMA */
> >  	vma = vma_find(&vmi, end);
> > @@ -1400,14 +1396,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
> >  		/* Prepare to unmap any existing mapping in the area */
> >  		if (vms_gather_munmap_vmas(&vms, &mas_detach))
> > -			goto gather_failed;
> > -
> > -		/* Remove any existing mappings from the vma tree */
> > -		if (vma_iter_clear_gfp(&vmi, addr, end, GFP_KERNEL))
> > -			goto clear_tree_failed;
> > +			return -ENOMEM;
> >
> > -		/* Unmap any existing mapping in the area */
> > -		vms_complete_munmap_vmas(&vms, &mas_detach);
> >  		next = vms.next;
> >  		prev = vms.prev;
> >  		vma = NULL;
> > @@ -1423,8 +1413,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  	 */
> >  	if (accountable_mapping(file, vm_flags)) {
> >  		charged = len >> PAGE_SHIFT;
> > +		charged -= nr_accounted;
> >  		if (security_vm_enough_memory_mm(mm, charged))
> > -			return -ENOMEM;
> > +			goto abort_munmap;
> > +		vms.nr_accounted = 0;
> >  		vm_flags |= VM_ACCOUNT;
> >  	}
> >
> > @@ -1473,10 +1465,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  	 * not unmapped, but the maps are removed from the list.
> >  	 */
> >  	vma = vm_area_alloc(mm);
> > -	if (!vma) {
> > -		error = -ENOMEM;
> > +	if (!vma)
> >  		goto unacct_error;
> > -	}
> >
> >  	vma_iter_config(&vmi, addr, end);
> >  	vma_set_range(vma, addr, end, pgoff);
> > @@ -1485,6 +1475,11 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >
> >  	if (file) {
> >  		vma->vm_file = get_file(file);
> > +		/*
> > +		 * call_mmap() may map PTE, so ensure there are no existing PTEs
> > +		 * call the vm_ops close function if one exists.
> 
> Super-nit, but maybe add an 'and' here.

I'm re-spinning anyways - thanks.

> 
> > +		 */
> > +		vms_clean_up_area(&vms, &mas_detach, true);
> 
> I hate that we have to do this. These kind of hooks are the devil's works...
> 
> >  		error = call_mmap(file, vma);
> >  		if (error)
> >  			goto unmap_and_free_vma;
> > @@ -1575,6 +1570,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  expanded:
> >  	perf_event_mmap(vma);
> >
> > +	/* Unmap any existing mapping in the area */
> > +	vms_complete_munmap_vmas(&vms, &mas_detach);
> > +
> >  	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
> >  	if (vm_flags & VM_LOCKED) {
> >  		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
> > @@ -1603,7 +1601,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  	return addr;
> >
> >  close_and_free_vma:
> > -	if (file && vma->vm_ops && vma->vm_ops->close)
> > +	if (file && !vms.closed_vm_ops && vma->vm_ops && vma->vm_ops->close)
> >  		vma->vm_ops->close(vma);
> >
> >  	if (file || vma->vm_file) {
> > @@ -1622,14 +1620,12 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  unacct_error:
> >  	if (charged)
> >  		vm_unacct_memory(charged);
> > -	validate_mm(mm);
> > -	return error;
> >
> > -clear_tree_failed:
> > -	abort_munmap_vmas(&mas_detach);
> > -gather_failed:
> > +abort_munmap:
> > +	if (vms.nr_pages)
> > +		abort_munmap_vmas(&mas_detach, vms.closed_vm_ops);
> >  	validate_mm(mm);
> > -	return -ENOMEM;
> > +	return error;
> >  }
> >
> >  static int __vm_munmap(unsigned long start, size_t len, bool unlock)
> > @@ -1959,7 +1955,7 @@ void exit_mmap(struct mm_struct *mm)
> >  	do {
> >  		if (vma->vm_flags & VM_ACCOUNT)
> >  			nr_accounted += vma_pages(vma);
> > -		remove_vma(vma, true);
> > +		remove_vma(vma, /* unreachable = */ true, /* closed = */ false);
> >  		count++;
> >  		cond_resched();
> >  		vma = vma_next(&vmi);
> > diff --git a/mm/vma.c b/mm/vma.c
> > index 7104c2c080bb..5b33f7460ab7 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> > @@ -136,10 +136,10 @@ can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
> >  /*
> >   * Close a vm structure and free it.
> >   */
> > -void remove_vma(struct vm_area_struct *vma, bool unreachable)
> > +void remove_vma(struct vm_area_struct *vma, bool unreachable, bool closed)
> >  {
> >  	might_sleep();
> > -	if (vma->vm_ops && vma->vm_ops->close)
> > +	if (!closed && vma->vm_ops && vma->vm_ops->close)
> >  		vma->vm_ops->close(vma);
> >  	if (vma->vm_file)
> >  		fput(vma->vm_file);
> > @@ -521,7 +521,6 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
> >  	vma_iter_store(vmi, vma);
> >
> >  	vma_complete(&vp, vmi, vma->vm_mm);
> > -	validate_mm(vma->vm_mm);
> >  	return 0;
> >
> >  nomem:
> > @@ -645,11 +644,14 @@ void vma_complete(struct vma_prepare *vp,
> >  		uprobe_mmap(vp->insert);
> >  }
> >
> > -static void vms_complete_pte_clear(struct vma_munmap_struct *vms,
> > -		struct ma_state *mas_detach, bool mm_wr_locked)
> > +static inline void vms_clear_ptes(struct vma_munmap_struct *vms,
> > +		    struct ma_state *mas_detach, bool mm_wr_locked)
> >  {
> >  	struct mmu_gather tlb;
> >
> > +	if (!vms->clear_ptes) /* Nothing to do */
> > +		return;
> > +
> >  	/*
> >  	 * We can free page tables without write-locking mmap_lock because VMAs
> >  	 * were isolated before we downgraded mmap_lock.
> > @@ -658,11 +660,31 @@ static void vms_complete_pte_clear(struct vma_munmap_struct *vms,
> >  	lru_add_drain();
> >  	tlb_gather_mmu(&tlb, vms->mm);
> >  	update_hiwater_rss(vms->mm);
> > -	unmap_vmas(&tlb, mas_detach, vms->vma, vms->start, vms->end, vms->vma_count, mm_wr_locked);
> > +	unmap_vmas(&tlb, mas_detach, vms->vma, vms->start, vms->end,
> > +		   vms->vma_count, mm_wr_locked);
> > +
> >  	mas_set(mas_detach, 1);
> >  	/* start and end may be different if there is no prev or next vma. */
> > -	free_pgtables(&tlb, mas_detach, vms->vma, vms->unmap_start, vms->unmap_end, mm_wr_locked);
> > +	free_pgtables(&tlb, mas_detach, vms->vma, vms->unmap_start,
> > +		      vms->unmap_end, mm_wr_locked);
> >  	tlb_finish_mmu(&tlb);
> > +	vms->clear_ptes = false;
> > +}
> > +
> > +void vms_clean_up_area(struct vma_munmap_struct *vms,
> > +		struct ma_state *mas_detach, bool mm_wr_locked)
> 
> The only invocation of this function has mm_wr_locked set, is this
> parameter necessary?

I'll remove this, and replace the in-function pass-through with the
constant true.

> 
> > +{
> > +	struct vm_area_struct *vma;
> > +
> > +	if (!vms->nr_pages)
> > +		return;
> > +
> > +	vms_clear_ptes(vms, mas_detach, mm_wr_locked);
> > +	mas_set(mas_detach, 0);
> > +	mas_for_each(mas_detach, vma, ULONG_MAX)
> > +		if (vma->vm_ops && vma->vm_ops->close)
> > +			vma->vm_ops->close(vma);
> > +	vms->closed_vm_ops = true;
> >  }
> >
> >  /*
> > @@ -686,7 +708,10 @@ void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
> >  	if (vms->unlock)
> >  		mmap_write_downgrade(mm);
> >
> > -	vms_complete_pte_clear(vms, mas_detach, !vms->unlock);
> > +	if (!vms->nr_pages)
> > +		return;
> > +
> > +	vms_clear_ptes(vms, mas_detach, !vms->unlock);
> >  	/* Update high watermark before we lower total_vm */
> >  	update_hiwater_vm(mm);
> >  	/* Stat accounting */
> > @@ -697,7 +722,7 @@ void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
> >  	/* Remove and clean up vmas */
> >  	mas_set(mas_detach, 0);
> >  	mas_for_each(mas_detach, vma, ULONG_MAX)
> > -		remove_vma(vma, false);
> > +		remove_vma(vma, /* = */ false, vms->closed_vm_ops);
> >
> >  	vm_unacct_memory(vms->nr_accounted);
> >  	validate_mm(mm);
> > @@ -849,13 +874,14 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
> >  	while (vma_iter_addr(vms->vmi) > vms->start)
> >  		vma_iter_prev_range(vms->vmi);
> >
> > +	vms->clear_ptes = true;
> >  	return 0;
> >
> >  userfaultfd_error:
> >  munmap_gather_failed:
> >  end_split_failed:
> >  modify_vma_failed:
> > -	abort_munmap_vmas(mas_detach);
> > +	abort_munmap_vmas(mas_detach, /* closed = */ false);
> >  start_split_failed:
> >  map_count_exceeded:
> >  	return error;
> > @@ -900,7 +926,7 @@ int do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
> >  	return 0;
> >
> >  clear_tree_failed:
> > -	abort_munmap_vmas(&mas_detach);
> > +	abort_munmap_vmas(&mas_detach, /* closed = */ false);
> >  gather_failed:
> >  	validate_mm(mm);
> >  	return error;
> > @@ -1618,17 +1644,21 @@ bool vma_wants_writenotify(struct vm_area_struct *vma, pgprot_t vm_page_prot)
> >  }
> >
> >  unsigned long count_vma_pages_range(struct mm_struct *mm,
> > -				    unsigned long addr, unsigned long end)
> > +		unsigned long addr, unsigned long end,
> > +		unsigned long *nr_accounted)
> >  {
> >  	VMA_ITERATOR(vmi, mm, addr);
> >  	struct vm_area_struct *vma;
> >  	unsigned long nr_pages = 0;
> >
> > +	*nr_accounted = 0;
> >  	for_each_vma_range(vmi, vma, end) {
> >  		unsigned long vm_start = max(addr, vma->vm_start);
> >  		unsigned long vm_end = min(end, vma->vm_end);
> >
> >  		nr_pages += PHYS_PFN(vm_end - vm_start);
> > +		if (vma->vm_flags & VM_ACCOUNT)
> > +			*nr_accounted += PHYS_PFN(vm_end - vm_start);
> 
> Nitty, but maybe:
> 		...
>   		unsigned long pages = PHYS_PFN(vm_end - vm_start);
> 
>  		nr_pages += pages;
> 		if (vma->vm_flags & VM_ACCOUNT)
> 			*nr_accounted += pages;
> 

This is a temporary state as count_vma_pages_range() is removed shortly
after.

> >  	}
> >
> >  	return nr_pages;
> > diff --git a/mm/vma.h b/mm/vma.h
> > index 6028fdf79257..756dd42a6ec4 100644
> > --- a/mm/vma.h
> > +++ b/mm/vma.h
> > @@ -48,6 +48,8 @@ struct vma_munmap_struct {
> >  	unsigned long stack_vm;
> >  	unsigned long data_vm;
> >  	bool unlock;                    /* Unlock after the munmap */
> > +	bool clear_ptes;                /* If there are outstanding PTE to be cleared */
> > +	bool closed_vm_ops;		/* call_mmap() was encountered, so vmas may be closed */
> >  };
> >
> >  #ifdef CONFIG_DEBUG_VM_MAPLE_TREE
> > @@ -95,14 +97,13 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
> >  		unsigned long start, unsigned long end, struct list_head *uf,
> >  		bool unlock)
> >  {
> > +	vms->mm = current->mm;
> 
> I'm guessing there's no circumstances under which we'd be looking at a
> remote mm_struct?

Yes, we always unmap things from the mm that contain them.

> 
> This does sort of beg the question as to why we're bothering to store the
> field if we can't just grab it from current->mm? Perhaps because the cache
> line for the start of vms will be populated and current's containing ->mm
> may not?

If I don't do this here, then vms_clear_ptes(),
vms_gather_munmap_vmas(), and vms_complete_munmap_vmas() will need this.
It's not critical, but it means we're doing it twice instead of putting
it in the sturct that is used in those functions already..

Actually, I think I will do this so that I can reduce the cachelines of
the vma_munmap_struct by this reduction and rearranging.

I can use the vms->vma->vm_mm for vms_clear_ptes() and the gather case.

> 
> >  	vms->vmi = vmi;
> >  	vms->vma = vma;
> >  	if (vma) {
> > -		vms->mm = vma->vm_mm;
> >  		vms->start = start;
> >  		vms->end = end;
> >  	} else {
> > -		vms->mm = NULL;
> 
> I guess as well there's no drawback to having an otherwise empty vms have a
> populated mm?

It's actually needed because we may need to downgrade the mm lock, so
having it set makes vms_complete_munmap_vmas() cleaner.

But I'm removing it, so it doesn't really matter.

> 
> >  		vms->start = vms->end = 0;
> >  	}
> >  	vms->unlock = unlock;
> > @@ -112,6 +113,8 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
> >  	vms->exec_vm = vms->stack_vm = vms->data_vm = 0;
> >  	vms->unmap_start = FIRST_USER_ADDRESS;
> >  	vms->unmap_end = USER_PGTABLES_CEILING;
> > +	vms->clear_ptes = false;
> > +	vms->closed_vm_ops = false;
> >  }
> >
> >  int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
> > @@ -120,18 +123,24 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
> >  void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
> >  		struct ma_state *mas_detach);
> >
> > +void vms_clean_up_area(struct vma_munmap_struct *vms,
> > +		struct ma_state *mas_detach, bool mm_wr_locked);
> > +
> >  /*
> >   * abort_munmap_vmas - Undo any munmap work and free resources
> >   *
> >   * Reattach any detached vmas and free up the maple tree used to track the vmas.
> >   */
> > -static inline void abort_munmap_vmas(struct ma_state *mas_detach)
> > +static inline void abort_munmap_vmas(struct ma_state *mas_detach, bool closed)
> >  {
> >  	struct vm_area_struct *vma;
> >
> >  	mas_set(mas_detach, 0);
> > -	mas_for_each(mas_detach, vma, ULONG_MAX)
> > +	mas_for_each(mas_detach, vma, ULONG_MAX) {
> >  		vma_mark_detached(vma, false);
> > +		if (closed && vma->vm_ops && vma->vm_ops->open)
> > +			vma->vm_ops->open(vma);
> > +	}
> 
> Hang on, I thought we eliminated this approach? OK I see you change this in
> the next commmit.
> 
> Not necessarily a huge fan of having a commit in the tree that's broken for
> (hideous, asymmetric) drivers + such but I guess it's okay given we address
> it immediately and it helps document the thinking process + split up the
> code.

Yes, this is really to show where things would happen - and for this to
be an issue with bisection, one would have to test the failure paths and
hit a case where the failure would cause issues if the vma was closed
and re-opened.  I think this is sufficiently rare.

> 
> >
> >  	__mt_destroy(mas_detach->tree);
> >  }
> > @@ -145,7 +154,7 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
> >  		  unsigned long start, size_t len, struct list_head *uf,
> >  		  bool unlock);
> >
> > -void remove_vma(struct vm_area_struct *vma, bool unreachable);
> > +void remove_vma(struct vm_area_struct *vma, bool unreachable, bool closed);
> >
> >  void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
> >  		struct vm_area_struct *prev, struct vm_area_struct *next);
> > @@ -259,7 +268,8 @@ bool vma_wants_writenotify(struct vm_area_struct *vma, pgprot_t vm_page_prot);
> >  int mm_take_all_locks(struct mm_struct *mm);
> >  void mm_drop_all_locks(struct mm_struct *mm);
> >  unsigned long count_vma_pages_range(struct mm_struct *mm,
> > -				    unsigned long addr, unsigned long end);
> > +				    unsigned long addr, unsigned long end,
> > +				    unsigned long *nr_accounted);
> >
> >  static inline bool vma_wants_manual_pte_write_upgrade(struct vm_area_struct *vma)
> >  {
> > --
> > 2.43.0
> >

