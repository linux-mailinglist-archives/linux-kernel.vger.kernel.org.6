Return-Path: <linux-kernel+bounces-245753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4662C92B8B9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 13:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F104B28583A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 11:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA5F154BE8;
	Tue,  9 Jul 2024 11:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I/WP0sNd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rslMIErA"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1821A15884A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 11:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720525477; cv=fail; b=fXysN9zOQvblbiUwEix+4bk2ydIpDZKNgnUs37eDwx4FDlkJdAuQUunpoA94Ma3aY3T5QqOgNpi5kfCJ+ofpu+PW67nFwvF4NdgT0YycudQ6pIxyd009iGYnksL1pziL7z4P+YF77+vXxmhDHrrCU8SNyzKBB/OuZqj/lD1+rZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720525477; c=relaxed/simple;
	bh=JBs0fUDVG+0tMxDYrNgLFa925F32Lj5Ijf/fdWeMEsI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dF7Ed/nRRzyuMke1BTRAxU7U5H1VaTckPwkX4n3E9GcjLxgEHZFxcpio2pEOmycnFy6Y3D6xIN4jAvu1cV9Skod8tWFOgjDOyP1zsEBm61T5UqgOfCqKOatDvrHQYUSlRReCWQeR366bvr0LQGuW8bQd7xbvCV+rICyE9Vx+Rl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I/WP0sNd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rslMIErA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4697tYrG024847;
	Tue, 9 Jul 2024 11:44:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:mime-version; s=corp-2023-11-20; bh=hbXMzBbQZNXPds
	x5VaQz0U3sdcLKqj7COL6BWG8NHsg=; b=I/WP0sNdeXExtuT7zqOIfIiUvpu4Va
	U4vm8nN8pusLPgwzNHi6AvVSojHsc42VR7UElkLzC90w4+OZsXXUN5SvcK+Z69tg
	3jc/c+l0zjuclCvZXpjodKX0wNC3xNO6dSZJZCcuW2Wrf8VAI5r2pU4530Z/lb0j
	dpkm4zynQGHl1Hdu1+DWSZyUQwy40zK2Oy3r8emXgntOONi/PBSBjydI6tM4xAQi
	KgyWOj/GBvyhIXSmT4PeFCs2tS7KV/P2Dsk8GIkSI9+LPyQnrZJPzq1ZOiwH+yoe
	lQUFGAyvkuc7OvTPUFqdHTt+pYhymQlWurz3ZVLZPWmMo1XWUeHXNu7w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wky4rgd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 11:44:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 469AUFMJ005617;
	Tue, 9 Jul 2024 11:44:24 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2176.outbound.protection.outlook.com [104.47.73.176])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 407tx2jwer-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 11:44:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ke0tnD/4Tky2czEjoKCq1vhfa6LKb+zR2kRYmLHcb5GwjO0+rt7SLf0X6DP1GKCHf8CC6pA/njjK71E8tM3vJF5sj9ui8qLekGASlgWy49oMGwT6FXaH9dpUCl7gBq19m2yk85vpSr5dC9iVGgtsIPlTLfRCojbSIAmyKzM5RH2pY/ipFPrVffeMl9iMmsDNYKSkB1d2NYcPh1x7gadtw8luMVnafdCNF345MwLl7l8l50QhvgUb4Or/fWIx7Cv7khMaeYrlDGA7O8F02dtM3mcs9rTtCciCiUGrrIFzu6Hb7rAnobWRGCLTFoey0IISfsUNfjv4sWGB9eVk9ZcTDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hbXMzBbQZNXPdsx5VaQz0U3sdcLKqj7COL6BWG8NHsg=;
 b=e8PvdjEuXCb/Ctg6PQSTjVr7Y/28yL/dFfDN5H122gS49YvszYEMAeuRSvzkaBVxPlvMbXJMTv3HGrI2ILmkuFqzxbPa3k7uX7+89JAnLh3vZ1ugyGaJHiiEEUOzXQ9NaYCPJxAzsPHErr2eOiw6vZa21P56s7ZsVVE4TYkhgJ8TWLGI4lHZlnlOpNogLdhlQ1csLefNSKVyAlornhwpApCPOcGDkCY0ST6yDSYrT6gC3/2muh/l5Yn23aBaPGLduVuP3O11xQilWstH/35TIH2phofY3Z+CT0z9Sk0CLmDdUKLeqOKUq2PYbxsJYksfzZ5S8jXPMotGB83C+lvj1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbXMzBbQZNXPdsx5VaQz0U3sdcLKqj7COL6BWG8NHsg=;
 b=rslMIErAr6B2rDH3vesCgiTOYgtfyrSMd+u0vUTsD1rSis4FNRqa2J4plwRuAaWS78+ziH+cYlARDUdhomHZ4tZoLe4oOFOsjsif/cSVbFJRI6uvC/iwzL9HcuYw1utsi1kHjciULFUb8I+MFq327PAiySTTQK7RhBVZYR/K7mU=
Received: from PH0PR10MB5563.namprd10.prod.outlook.com (2603:10b6:510:f2::13)
 by DM3PR10MB7969.namprd10.prod.outlook.com (2603:10b6:0:45::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Tue, 9 Jul
 2024 11:44:21 +0000
Received: from PH0PR10MB5563.namprd10.prod.outlook.com
 ([fe80::1917:9c45:4a41:240]) by PH0PR10MB5563.namprd10.prod.outlook.com
 ([fe80::1917:9c45:4a41:240%4]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 11:44:21 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "cve@kernel.org" <cve@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [External] : Re: CVE-2023-52628: netfilter: nftables: exthdr: fix
 4-byte stack OOB write
Thread-Topic: [External] : Re: CVE-2023-52628: netfilter: nftables: exthdr:
 fix 4-byte stack OOB write
Thread-Index: AQHa0bLc1MvUTJZJO0ydj7HfzDsXUrHt2+OAgAAB/QCAAE72gIAAGmWA
Date: Tue, 9 Jul 2024 11:44:21 +0000
Message-ID: <a059d0a56078b369a78cccbe60e5d538c61d76d8.camel@oracle.com>
References: <2024032850-CVE-2023-52628-14fb@gregkh>
	 <b8b8f6113ac1e7f1fa07659c32d34b033f775a84.camel@oracle.com>
	 <2024070926-removing-chewer-2426@gregkh>
	 <18f16d08f3946fbee0917f759a855cb070aadf44.camel@oracle.com>
	 <2024070948-helpful-departure-a468@gregkh>
In-Reply-To: <2024070948-helpful-departure-a468@gregkh>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5563:EE_|DM3PR10MB7969:EE_
x-ms-office365-filtering-correlation-id: cf46f3dd-ab26-49c4-f649-08dca00c792e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?dlg5MkFVTXpaVG1rNFVobkxyWm9FaktUZUJCQWRCWDdmcFE2YU5vc0tld09v?=
 =?utf-8?B?VXFFYVgxUnkybDZMSHp2TEV4L1RoVGNhaGFqcldQUm4wMm9adzRqMWVGQmEz?=
 =?utf-8?B?VEJsSytPekQreUdHaFJTZnpBYkJxbUtoNlNLMHY3Tk1GUUFaNmZjR29lb3hk?=
 =?utf-8?B?NE5mQXdTV3lhWHphUGhSZ203ajdBcGpVZWRhYzZPRHFtYW85NnBQTFcvYm1k?=
 =?utf-8?B?bTNzeUpyQnUwbjFZZ0RVM2YzOUlFUDJFOUVaSnFDTlpSMUZPblk5SVArWnlq?=
 =?utf-8?B?N1VVMVNXbnk1UFJKMy9qVVQ3Y2V0aFJ4SThZQlg4L0N1ZUhNeWdHT1JkSjBj?=
 =?utf-8?B?cGdpK1ZlWXB2bHNaVHdpNE9HdnRLN1FCK3FMY3VqMjdWNWM4TDNsVGZXc2ZX?=
 =?utf-8?B?cStyYW05SlBsWlRyNm5vYThrSzZydTVNYkNsYUltVkUrL1R3bjhTLzFDZVBV?=
 =?utf-8?B?OFNzV0ZJVkpGSy96NHFnamt2eUE2RHp3N1dxaVJXMURaNHFDOHl4ckRBZU5N?=
 =?utf-8?B?SS82c1dRQ1dGMVF0T2VZblQzbzRHamRPTEY5ZnJqZVdSODhBY3FwakUwRC9R?=
 =?utf-8?B?dG8vN0lZZWJVMkgxalVpcElPYzlDNWQ4andqUnJIMjU1dUZaaEFTTVJKbE1i?=
 =?utf-8?B?eWNONGlIdHZLQTYvSEFxNnJucmpnUXVZSnNPbjd2MlpWVzlJZHo1L05uZDVZ?=
 =?utf-8?B?QjB6UElXSkZKYnFodEtKMmY2bXlqTTJVYjlpSUtYOENuN0U4UE1GRWxJdldS?=
 =?utf-8?B?bElwZ0NIS3BwSjBkU2wzSXRMbklGaWd6eXBGdjFWaWpJTjBuUHMxWkk0MWN1?=
 =?utf-8?B?bkZDQU9YYi8yakc0TXdGbEJOWDlWa05GMTE3c0lsdXpEN3BaYSs0SzdMNlJj?=
 =?utf-8?B?L3VoTm9XV0JkR29zeXlTajl4V24zWkc4b0ZpdnFrcjZtallKdmoyaXEyMnJq?=
 =?utf-8?B?dXJidnpOV2RWajVvdDdiVHZHVUp3Y3JwTmR1WktUa2svZ0JoTmlCWDFpL1B6?=
 =?utf-8?B?ZUdEN1BWN1dEeTFLWkpaWW1XY2Z4WjNTU0ZJNWxpQ1BIOFluNWtMdGNhSTJl?=
 =?utf-8?B?MGlGSXROQUpDeDFUTWNDTEI2d3BXL0FDSituaXNlcGhrWTkrdHc3MEluTGFR?=
 =?utf-8?B?VWgxR016emRYV2hvT3haLzNqQUJna3Jpc1NmSDYrOEdQYkdhMFFzRThsc3Qx?=
 =?utf-8?B?WnB4WUlnYW9VM0dCbWxjaUw5TzFINmxTMlZmeEphNkRwYzkvMU10c2lVam1t?=
 =?utf-8?B?UmM5R3N0LzhqRmVYQkIvRy9mMGw5V3J5NVhQRG5uYlp5V2gvWGdkOG5zVGp1?=
 =?utf-8?B?amE0Z2FaYUVwK0Q2cFBqekJYVWJ4c2lpV1p0ZHVOdVI4ZWhaRHhpUGZQUDBS?=
 =?utf-8?B?VkdRMDcrQ1UxN3JTZmFmbU9BUjlNc1BneEdKUGFRc1FaaWt1U1R6SklSeTFk?=
 =?utf-8?B?dDNRMlF4Z0FtbWdDaXQwU1AvVDQxRWFwa3YzWmFYeHdIVXVTTURSeG0yd294?=
 =?utf-8?B?NFprVEFySEg2V3hJV2NoaUpxcHhDQkVLN2hER3k1bUFwRzUwTzhMaE1KT2o3?=
 =?utf-8?B?Q0d1RVA1RTZVdE9PdFl3UUx2K041MFFrbStJSlAzSVN5SWgyMkgyaEQyZHpm?=
 =?utf-8?B?Yy94bUpWa28xYW5nelpxWm81L1lVYkhLNkZBWXpBZGFKa1dkQldTbDR5bTRM?=
 =?utf-8?B?UU5UdUt3REVUemx0enRDMXpjb1dDZDJheENqU0FMdTMzUGVQdGx6QVdxZmJB?=
 =?utf-8?B?azZOeUpCN2luWVJicEQ0dDFua0RNWDA4VUI5L25CMmJNZ1Bja0J5S05sZnJC?=
 =?utf-8?B?WmlQZnpuSXRVMTBReEZicjIxckNaQmxYcGVMMlQ1aGhYL2k4NHdBdyswc0JL?=
 =?utf-8?B?S0NZci9oU0pHSWd2TEg0S2k0M21pUW5GM3dqeWhlMGVMWXc9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5563.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?YTJEdGJ6Z2dmN2dMbUVVQmNzVHdCYVpWTXV2K1Vxc3JJWWR2RkJrTnZWYits?=
 =?utf-8?B?Q2ZrdHdXekxNOFFERG9HdThNSnJMZUVKd0daMnd3RTc3ZkU1TDNjaDhNbnlY?=
 =?utf-8?B?L3FoZUpMRVBqY3JXYXpBdWtKeEZrQWhOeE50SVdNaldJVU9DcGV5NS85UU51?=
 =?utf-8?B?U0hwY2lYZmJocFhvVEpxaEpVRyt1MTlXR3ViR2docTJvMlEwcVVCcFBXaE9V?=
 =?utf-8?B?cTdBODZCOHI3cFBTTnU1ZktvR1gyWm01VlZ0TVVmUC81U0Q1VkttRDVMMmZN?=
 =?utf-8?B?WjdtanFlc0JhOUlRb0o4b05NQitjN3N5QmJPc2U0T2RLN3hMUkkxaGIxQTlG?=
 =?utf-8?B?Y0diR00zSVBGd3M4U3gzY0ZwdE1BWFgxYjBWNHhMOVRObmc0L1hidWRjUUdF?=
 =?utf-8?B?dWViNFZjK2tZS0p6aklaZHRidGhxZG9ESFZ0NDl3aFVhNDFFZTM5TzA2Vmlx?=
 =?utf-8?B?YmtWMTBlRTJjd0IvRk5wdktycFZvQ1FKckhiUXV4Nm5leEEzL3RwM2MzNmh4?=
 =?utf-8?B?NVdxaVFtdnI2M2t6K21pTWRwNmIyUml3dTZVd0E1TndRSmE3UlpZejEzMnBq?=
 =?utf-8?B?bFowbDJlREVVZ2g5ZEcvamYydTZ1N1FhRXVTWGN3ZFJjREg3NGlBck1kYTQz?=
 =?utf-8?B?N0Q0SUhTUmsxMnhIak16cGpncjJROFdvSFZvYjRMTkJUalhzK1U2eWlhcHRs?=
 =?utf-8?B?MXg3amVyYW1hT3NZMFlJbUZDaG1PcldYbmt0dlRXN1ZTaXlMVVF5Mk1EZ1Z1?=
 =?utf-8?B?OXVja2ptZ09pdzcrTnR4bGVycDhJS3dobXJ0Y2c2eithOHJvYUxnMTZOZlY1?=
 =?utf-8?B?dHJ6OUZkQTNLOVpOYzBlNnpPSmN5ZER3aDVsTFM2L2ZZSWJOMng5SFlnVjky?=
 =?utf-8?B?SWRXV3pRcC9oWFpLRFNZNGMvZjJldkVaR3RjeURlUDk3M2drM1BpaUpWK0ta?=
 =?utf-8?B?cSs2NVFSWUFWL2pPdFpmVVY4blJjV0psU1crdkozN3VCYzJZQ2tBNzhtNDJ5?=
 =?utf-8?B?Zzg5Rm8vWmpyRXd5L1hpSTdkN1FvYWdKUVlxb3pVaUhmNWZuajVOSVg3d1dj?=
 =?utf-8?B?ZXM3UUhaaUZHYVVRWDFMaXp5Vll6azdTeFMyMkFDTmFaUnlwNzh3MDFVQ0hB?=
 =?utf-8?B?SVpRT01IVzVsMFdwNitvTHUvWmRiNm1qVFRjMFpBV2gvQ1kwMk1GTXVtUmZK?=
 =?utf-8?B?YjU3UWlOZGJRQndRdVM0MHlSZTlrd2dZcnRyUGhQajdhVE92K2tHUVNQOEdv?=
 =?utf-8?B?a092R0luYUZ6R1h1cktManRlTHQvR0g1OTVralp2OVlLdWNqMUZQZUxnQ1pI?=
 =?utf-8?B?bjJ0SWp1R1p4d0ZoMWdRbng3Y2VzN1VnQkI0cTFIYkZYZGZTVjVqWDZwdjRB?=
 =?utf-8?B?RWZVcm4wM2YremhiNHRLT3M2dGdYM2xlNTZuTTlMTm41NXltLzI1bThrNkp5?=
 =?utf-8?B?RTg5dzBWT21XSUVwbUZuRERvUUltUXhENkpleGFZdkF2NGN6OTlXRGZKY2Yw?=
 =?utf-8?B?eTQ5d0U3SVU5clFsUFVuSVJLeloyU2R3NDJEZ0g2b0F4ejVZUkVsZ0JzYzFU?=
 =?utf-8?B?ZVlJZE9NWWRERW13dlhiNm9MVzZzczBRY2U4WDlQc1BOUmE4Z1h5M0NGSDRw?=
 =?utf-8?B?dm4yZ2IyUXdia0pNMUxKazMvakFwckI5NGNNdnNRK09MdDBnYUZhN1JWTGpQ?=
 =?utf-8?B?TjZSSHdIWTR1SHVqbVV3anJONWxOeTJnb21jcEh6Nm8wSlcyN0ZubFRNcnJm?=
 =?utf-8?B?VzNnMjE1ckI2WFN5Qk9QNkJEM2pzRjFiS0J6VmVMdm12TDEveFB3OHRJMFVL?=
 =?utf-8?B?UUNBZmlJa0l0emNrVklva0p3Uk54QTFqaUQ5Z21QZnpQaERqVDJtMWdEMGgr?=
 =?utf-8?B?RElhbjNtNHZoRzhjck9MdFN3MzVLeEtvcC95SmFuMUJtOFFhVmkvODNRTVFY?=
 =?utf-8?B?eVd0S05HdURMVDlUSGNzQ3I2eFkyaUJQQzI5SWg0VjV0L0tPOFVPSlBaRmdx?=
 =?utf-8?B?T05QcDMvZlRDTzU0TTFhVlJiakI2UlVRQmcwOS9UY05KSVNuazZ4TExjNVYz?=
 =?utf-8?B?Mkd1VGNaeTJxcU9TL3hDNnNXcnNIa2w5Uy9VYWJKMFBvQktSbnZCb0IxdzlD?=
 =?utf-8?B?bmV1WXArZm9NMHFhcUxyeUR1SlBHWkVqbUFUbnlVdXVvZEtIelg1V25LZWds?=
 =?utf-8?Q?8vYAFrt7QGBE+qVGqXG3TXAcGcHrF4ud3gf3M8KVjSlE?=
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-fJrP5nzz+/xEOvKgddKy"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Cpl0BloBq6zBD0+ITQSymDvLLACYisqPdnZcFUf7oBSytd9MyQrRKvS7loYrx4MzReKSMLoV27LXXiwiIrl+pkJVRFYwrf+WRNE8bK+I0Emxf497+zlrf3Uu6hmCHWEui8Wbdb1sNvIyZezylyZu+uSQCxsCj7gCNIchRNrGAif86b2Hj0pHXzwt3y4qw4TVcxuiERtvoIOafciJ1u4Tixh+wMs/Rg9K2AJFFAq2LOlwVdCT36y8VwGGcOvBlif4WE/jOqhp2pdmLc7c4fOYOquwlN6WdqnCtwOJ1Uf2KEC2DN1xLNbpvmrsRrJqPtfOKufaQVdQiUHlZRAzml2tGVsI5SDf/2wGAL/o9K8cNqKg9FpVc6HaGpHwrkAz5klaff8er2TZYZaaDYpTzNMU6jajQF7y/rjZMNedK+BKndj/DeZIOWH7KAbQdJmXGqcigRW5mBGlOi2djF2TzHTsQ22oe6KOAZuMkBICKvdADX+YJj4sC64I+GtzuCJfm2SfvZRhWWkVECHt0Q3KZKRt+97dE8/dxe+/1ipdsM8UQ54ndtxpbiLvBb5Ggw+v3HE9jfOTQSKiT+Ef4RoigtjWjyEh2n6oTWgiZ15WCOCCh2c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5563.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf46f3dd-ab26-49c4-f649-08dca00c792e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 11:44:21.2404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P5hCihrYR98NFm+aTIUAzj22kRVNymG/tL+wt6Tp5An+QXv+B+DxBxk0Iky0eIRsifRqu9Vn4FIr1V5tbuw+KY9ZGfWC132h28coCZoSgK8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7969
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_02,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407090079
X-Proofpoint-ORIG-GUID: ZTDkpqMEgHOgslxlvhIHKhgg1J-G-Whp
X-Proofpoint-GUID: ZTDkpqMEgHOgslxlvhIHKhgg1J-G-Whp

--=-fJrP5nzz+/xEOvKgddKy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 09 2024 at 15:39:43 +0530, gregkh@linuxfoundation.org wrote:
> Looks like Red Hat created it and then rejected it, you will have to
> talk about this with them.  But then later ZDI asked me to assign a CVE
> for it, and I did assuming that they knew what they were talking about.
> I shouldn't have assumed that :(
>=20
> I don't know what to do here, sorry.  If you don't think this is an
> issue, great, I'll be glad to reject it but we should say at least why
> we don't think so here in this thread, right?

Thank you for the clarification!

I thought the "Linux kernel security team" is referring to an upstream
group, so I asked about it because it seemed off.

Anyways, best to have this up instead of not.

Thanks,
Siddh

--=-fJrP5nzz+/xEOvKgddKy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ4+7hHLv3y1dvdaRBwq/MEwk8ioFAmaNIogACgkQBwq/MEwk
8irQbRAAqePqxJ5nME2l5Tcb+aLiV7xWB2FhVdhUbbZuu3FAGOnIaeQYSPyYcDIb
a15PzNlFzvZqWLghttNkufM7fLihBr6CjEsemywlgWiriKgIZi6F5rdV04F0+ep6
tEljF9m6SnPJ4BH5FbRqvaDYsf1E6/T7rj7/MccWIu+a6WSE/x2qYPFzTwkPPdmf
NQG6m51LAs49fw8CHk1VMpulVwCfbTEbFVrSIB+4FbUIMCDnOvQxgeWmbHLaM0z/
Fb3v2EhKJTet5doWg5hXEcdmOKVbQdWl5AaokTrxOxp36TsF+ORpaOmB+KeT9ivH
nL7leX9NxA+G+zU6yL3ZD+gZZoDco/pynZ2elGb/qc1Y/aGWf9gkR1ufgsUIYlsg
NlX0R9iDX+Dv34O95EjI5Vq8Uh/hyIu30Xfmf9wArmTjYJrUvWIThae51TtuEnFO
A69TKawcwob58XIWCNV2YgEFKb3OdRxLM3PjzJd0BWGhRnHJ0J5+jvzr7B3QHI5w
KpYSytnmlBI2wk0B9hDs2yOVjzCvP4jffOOrvnJ8CP2e2HoW+fW1WTnx3ejAB7f7
MQbT0EB9yUOYGkCHTifU2tptLFjkuotbK0cuTPik0J893mZwZILJwUmwmVb6lzuf
iXoCB1oeK7y+DYS0ZqYIM/UW4F0BDsDBr4a9hInU4NUVu3N3Zlk=
=ERsP
-----END PGP SIGNATURE-----

--=-fJrP5nzz+/xEOvKgddKy--

