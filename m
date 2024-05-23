Return-Path: <linux-kernel+bounces-186863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE058CCA23
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 02:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B417E1F21D77
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 00:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987EF15CE;
	Thu, 23 May 2024 00:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="bAD3IWCZ"
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com [216.71.158.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8336080C
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 00:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716424869; cv=fail; b=PL8bSvgb7XRIvYmxSEr2PNXq0T3CplMaBYGHSfu9iwPuqk5132d+AviiiBREwyWobfmcoP9xZ40j1fl2Ler+N0Om0bm2A452dKhvR6iUZ8ZT/r6/BllBnc4A4XtOER3Ued8G0e+bCAceA/YtHRQ0/Ov80PNCjEG6JqmiKqNkeGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716424869; c=relaxed/simple;
	bh=rUOATAXWNIXDzCWxE/0jQ2+oNYmOkJQzJjwLLVYhCdw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GoO7dpD9piYUOGaWtjp5uc4YJAHEJ3amYLKjkPrVZCZHK3zSWapDIS/mRKEMeXA3NrKqvTJeF71ex0NIUaCHQdTrrDH9ZrNCZOa+PT0Ba44PxUI4foyzGRJWzrrq7sN2DIpK+Ml5s+A/nRaAubX/Hy2TCVvCHd+tjlzNOqFyfbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=bAD3IWCZ; arc=fail smtp.client-ip=216.71.158.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1716424867; x=1747960867;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rUOATAXWNIXDzCWxE/0jQ2+oNYmOkJQzJjwLLVYhCdw=;
  b=bAD3IWCZHPahoklq7K4i+W6R5x4ETOCpzQkGEYQ7cPanw5FLRfa+fFH2
   hB8EDQtnlmmiuGjp+aDlzfX/2yOLdN+hB+h3k0dD+U16CmLwIarqXGx0T
   RIrXdUK/rpasv4JYJEM7a0HtzVRghTCZ4tMN+Bxqg8YzqsCss6w8FmQxG
   jcX8tcUkRKUxM+afP92SBjniIflEfWfMGeUG7BS3Rrh6hIEiIreTjM9Lk
   podIbZ/C3zmDa9ivfVX9nBwqutrHVibdeY+gJwMuVZUANJWKwLiQuGp3T
   mgb2ItmgONY2nxOdmg29R0T9vH9XrohfYkneKkCFNdZLnM61lA5O9+QyK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="120092701"
X-IronPort-AV: E=Sophos;i="6.08,181,1712588400"; 
   d="scan'208";a="120092701"
Received: from mail-japanwestazlp17010003.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.93.130.3])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 09:39:48 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fn7Mm9S9ZwJEtv7BB7wVnqkFxjyRgmn62ACfdNXxbwez4Cxkh+SHDBLRyVM9ovRgXOidWfTvX0N8NsquQM4jSK11XeUbDrfTRzjLuC307hSc5IeZw3M2s9MAuj01hBnMzTW6ayu14VQCz/Hc2TdQDGUstxgVgVtoUsjC/XkRyMuQ0iKI/oko2hslshxicT0x/mvfbUXtZgVh+eyGuCYqJyw1MkoQDp6swxT4ZcyffhsoQzrQ5Rk377gmFECI82LTaKRFwbz+O64tqzWZwzVhcIrYeisxkp5l7z3ElTg9kY6sjZifa4ZyUXr8XDYZPFAgALjmtKIFqS5nZOE1JzK/sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUOATAXWNIXDzCWxE/0jQ2+oNYmOkJQzJjwLLVYhCdw=;
 b=BldTpUMEBA3cBS5VACAyWiaAKds8hRdVb7qwhwidxzD1p2Xa4mr5n0PxLSYVXTKAp4FBgdVQRfpsTIvbp3VXnmzpounH/BR8F9t8mdiTohl7X+l/6I/qSVTI4p+19uTKXSdBrpzVIS5EwQRVe3yPZPtTQ/HmmAdt39jfyY2VUF6p1pLbqo2aGIBBhvTnaqdILJez2N1x60a8s74O2TxrBH2T6/nj0KZCojiBe/8inQxGY4W113L0lx9k1We2g84s7Y1NaXvyFFXw5Ptn33A9E+kmtIhSI5FeT8qmJubDPKbsxP2mtxgAtcbvCYT1u6Wm7OQ2k9sqPrV10VP7sSFcpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by OS7PR01MB11486.jpnprd01.prod.outlook.com (2603:1096:604:249::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 23 May
 2024 00:39:44 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::14dc:625a:548e:aa7e]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::14dc:625a:548e:aa7e%7]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 00:39:44 +0000
From: "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To: 'Dave Martin' <Dave.Martin@arm.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: James Morse <james.morse@arm.com>, Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, "shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, "carl@os.amperecomputing.com"
	<carl@os.amperecomputing.com>, "lcherian@marvell.com" <lcherian@marvell.com>,
	"bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>, Peter Newman
	<peternewman@google.com>, "dfustini@baylibre.com" <dfustini@baylibre.com>,
	"amitsinght@marvell.com" <amitsinght@marvell.com>, David Hildenbrand
	<david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>
Subject: RE: [PATCH v2 00/35] x86/resctrl: Move the resctrl filesystem code to
 /fs/resctrl
Thread-Topic: [PATCH v2 00/35] x86/resctrl: Move the resctrl filesystem code
 to /fs/resctrl
Thread-Index: AQHal+s9xm+M3FTNeUafHiym1U0ZubGkIheg
Date: Thu, 23 May 2024 00:39:44 +0000
Message-ID:
 <TYAPR01MB6330BA857DE02BF5655774778BF42@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20240426150537.8094-1-Dave.Martin@arm.com>
In-Reply-To: <20240426150537.8094-1-Dave.Martin@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=d3da6287-6708-47b0-8cc7-a3ffae973f79;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2024-05-23T00:34:25Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 43b1f9d63baa42fc8a1d2f4616ecea6d
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6330:EE_|OS7PR01MB11486:EE_
x-ms-office365-filtering-correlation-id: 8e91b888-ea86-4c70-6b09-08dc7ac0d754
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|366007|1800799015|7416005|376005|38070700009|1580799018;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?Rm0xbG5pTFA2RHhxcmJxQXBrYWcyamR2K3dzN3hQV2Y2ZEhXN3hxRitE?=
 =?iso-2022-jp?B?SlNNUE9IMUdVSFdrMTk5TGNHT2JxUnpoZHNHK3FWeFBpT3FjVExQNC9t?=
 =?iso-2022-jp?B?RllZRlpESmNYS0h6b0h4TElWcFNpODRjeXVseFZLNkpkVy9TWnNkamZV?=
 =?iso-2022-jp?B?Q3NBbktZQXhBbk5nMG5XKzgxZlYrVlFIVWRNTGtrSTJYQkIrWWRWeG9N?=
 =?iso-2022-jp?B?dUZTVisxMHNSTEVSQWUrTzVUcWdVOHgwNnRiK3hUejYzNm1Ic0R0djJo?=
 =?iso-2022-jp?B?cUozT2kzdWJXMGI0Y1VqaUw3WmkyNGd1STlMZ1phL3BkS2Z4SU9IcnB5?=
 =?iso-2022-jp?B?V2luZEg1MEtMMzVicFc3TUlyUEpLZFR4YmlUMi9YZWJsMzFKbTEyRmE4?=
 =?iso-2022-jp?B?b055NnFxQk54T0E4MUorbGFJMmd5cXlXTjg3VW0xcVdEblRGd3I2Y2E5?=
 =?iso-2022-jp?B?NTVTMk9kY0MrN205MzZKUytrRXVOUUZsUHdzMlZOc0srajF1L1NVMVhm?=
 =?iso-2022-jp?B?eHRQbXpGQmpkOWZsN0NXUzJhaVdDblVabVh3aUx3dWtlNTEzeGNnRW8z?=
 =?iso-2022-jp?B?ditQWW5jeW80UHFCMWhwUG1QSTFVRThONjQ3QmU1UysrNkdad2hPZ05l?=
 =?iso-2022-jp?B?M2dsR01KVk4rTjJrc21aUER2QkZ6YUJlSEptMUJFU2pJbEQyY2x4TzQz?=
 =?iso-2022-jp?B?STMzUitrQlg3MUt2NEpteitLY1lQWW1BWkcxc2NUd05xWFR6ZjYydFhN?=
 =?iso-2022-jp?B?cW5GZEIxOWdyTk9USWhPRGpXbUpLbEtYNTIzb29pdGJyTUVXeTc5blRW?=
 =?iso-2022-jp?B?d0hjWmtuMForVTdEWmNxVkZDNXhKUU5BL3d4d3FlK2ZacWhpa0N4WFdh?=
 =?iso-2022-jp?B?NXRFL1pIcmx4VUc1UThjdlExSTVNUTFFTmY5amFQbllpeVJCZ0dEcnpQ?=
 =?iso-2022-jp?B?VUMzVlg1OGJ6TnJDQnVHNGY5WXdoeTRkVnpieFd3ZVBzKy92bFFObi9H?=
 =?iso-2022-jp?B?c24wSE5LdVUrZ1BXSWd0OVozYlpTb2xMbWtqaUhuTkpwaStqQ1RpNFBR?=
 =?iso-2022-jp?B?MkVtdWxReTIzVzlsVXBqRlhuZUhBYzdXcmpuK2VnemRTZWk0QkdNc0l5?=
 =?iso-2022-jp?B?UzBodGMvQm80dE14NXduSWtuVEl1STVhaktLRFhtUzFJbHVJS2xhQ1FC?=
 =?iso-2022-jp?B?WVlIOHBDOGlNd05YOEFNckhNTWh2NFVVOVd4ekVKRWJ3VjBIM0QyZnRE?=
 =?iso-2022-jp?B?QWZsQi9rcUcwR1Jxa3ZCUEZYOTRlcDJnTlBDSGNCVmh6eEYwc0F1Tkxu?=
 =?iso-2022-jp?B?dHdWekFrdWtYbW0yQkNEU0M3cHpIQ29CSVJub3BOL1VleUNQNFpLdXR4?=
 =?iso-2022-jp?B?eUs5MTd1dnlVK1haZUR6YTg2ZjhPQ2JBcEc4R01LYVJiVUZqM0xSQ3Fp?=
 =?iso-2022-jp?B?WG5GaGx5T0pCZ2U2cjVaQTNuNU40V2Q0VEtuU3M2MjFNQlEwNVNjbWRu?=
 =?iso-2022-jp?B?TXhoWEp6c0xvSlY3TFdQdXJnYWkwejdWSnlnRmphMU9renFZRVA3KzRp?=
 =?iso-2022-jp?B?Y1NtMGFJRFM5bWV2cithV2YydzRYTWN6cHNyU2llL3cwRWlCQi9yUXE4?=
 =?iso-2022-jp?B?aEExbFFsRmd3RCtkL2R0V21pa29RaXEwQzVtQ3Z5aTRNMVBKY3h5aVkw?=
 =?iso-2022-jp?B?WS93SzVyQUdmaXZzOEF6RHF2Sms2SzJ6dFc3aHM0Q29qMWRyRXh2SklK?=
 =?iso-2022-jp?B?Y011SFY3Y3psZ0lYQnBkRzNwWTNDRFlFcUhZU1Roem0vT2dZQ0d3eHNI?=
 =?iso-2022-jp?B?M0dSZDlwN2xHTHd1dnNFeXRuS011UE5CQldobnZrSkxHc1duYWNvMFZL?=
 =?iso-2022-jp?B?MWJiakE0ZkJQczFSZ2JKODBqWi9aMmtiQ1hWMHlDaFNaRVNocksySVMv?=
 =?iso-2022-jp?B?NjM5Kzg4eUdDS1MzSE9KRHZuVE1EUitSVGI3U2N6bFl5RTZkNiswSFdU?=
 =?iso-2022-jp?B?QT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(38070700009)(1580799018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?MlFybHpPNm5zK3ltMmZZUzczRFJRb09PT3k3dUZPdTlkWTZUbjFiNm1L?=
 =?iso-2022-jp?B?VmR3RU41T0RicjA5KzQ2K2hoRnpseGpHK2w4SUZkWG1EWmpKMEpYZSts?=
 =?iso-2022-jp?B?MFJPazR3enI1VE8yTjNJQnNUaFQzN0lvUnluVkp4dCtFSENQQVphL3lz?=
 =?iso-2022-jp?B?RjBTR002OGVsaklGajFpMDhmUTRZRjgxMjVmT1VUS0JEUDNUTU93a3dX?=
 =?iso-2022-jp?B?U1ZZdmg5ZEVBbmdUMklEcmd1VVJFL0JlOE5JM2dhS2lDQ1FiZllrWFZn?=
 =?iso-2022-jp?B?WEZac1IwUndUTUdyenorcXdtZHBBbVRRV0JKaUZFQUE3aXBRSUZ6bXFV?=
 =?iso-2022-jp?B?Tjl0RGt6TW9MU0VyRHg2RFQyOW4ydmN4bEU1eGNiWDhKaktsb3FQblpi?=
 =?iso-2022-jp?B?bWZmNXRQSjJxYXJLM3JCVWM5YkRKeHFKaHZ2MFR2T0dwc0NaRHdMTWpi?=
 =?iso-2022-jp?B?UjYwSXBPSTFIeW9zeHluVnUrNTVwdFRiY2tUTFd5OWdMZnFJSVZsc0Fx?=
 =?iso-2022-jp?B?bGUxYkZIQmU5KzFIMmF1ZGlWcjBTVDlKTVlxNnhIeUFNMUdreE8rNWo2?=
 =?iso-2022-jp?B?enJ1Si9YTVBya3JPd2dUUit2bVJNbGhuMGl5ZGMzUEJINWQwbmVDallX?=
 =?iso-2022-jp?B?UUNnSVdhRGpsREVlaXZPRUtkeGNEZjZHU0F1cDdmSEtGUHVJZ1NtNXRG?=
 =?iso-2022-jp?B?a1lUT01ub3JHRDZLU3lUZzRqejZmZWtOL1Vid1ByTTg1ayt0QnB3dE92?=
 =?iso-2022-jp?B?NFRwVW85K2tJeVlIQzVpOWxya0VoVTdUVUJJOVdZUWFwSktYNTZHaVV4?=
 =?iso-2022-jp?B?R1dpK1ZITWVLZXNJejI4NFp4Zk5mNi85KzhqRlZEK0E0c0syREhsL1lw?=
 =?iso-2022-jp?B?dTk2LzVaNUVEN0pvd1VBQWFJMUtuZDZESXoyVmptbjA1T2ozNjBoeUJO?=
 =?iso-2022-jp?B?QUJtNno2ZFZ6ZzhEeFl5UVVtUm1BVkNiVVJ6ajVyZWw0VHRYeDRaUFZD?=
 =?iso-2022-jp?B?dmFGdUsvOTdQOWc4blN2WHJ6RytHK1dEZk12bFkzellDMWtvcXIvRmVB?=
 =?iso-2022-jp?B?OEQwQzBHdXdxcktKNlUvQ0VUTU9Jb3JvOVNKZkVyaU1WZ3ErU1ZwZTh3?=
 =?iso-2022-jp?B?SlVIdHd2OFR5SkhhVzdFdTRCR2p5eEVBazFrZzdCSWJmT1RxTmcvd0ZV?=
 =?iso-2022-jp?B?UDZnTTc3akhiRTY3RHRDWGQ5Ujl5NzlyNzFzdGYzdlc3UUJMVm1zN3NU?=
 =?iso-2022-jp?B?d1BpT0krY0JBU2pYcG9xd0NTQkNhNFJHaDg1OWhuQ3loV2k4anRWRUk2?=
 =?iso-2022-jp?B?MTFzT0x0NmRsYmJSSzJrQi9DYkNKRlE3T0VTQ2NBQjg4NmhvTjM4REo1?=
 =?iso-2022-jp?B?dG1yTmxLcEhZTFRmUVBmWlc2TlU2cFZFeVZCcktrT0ZLN1FKZWxaMHh6?=
 =?iso-2022-jp?B?a0pvUnNNS2N2MHNGWDA0amlNYUJiSWREUWpyWlhHSUVrdHkvaFZGRUNG?=
 =?iso-2022-jp?B?VlZPdG9XRGlUUVVhZUpQRC8xalZxa0dsd3A1alZJYk9CR0hCcElFQkV5?=
 =?iso-2022-jp?B?cmI4MlEzdWh1S0hiMHZwZUkrT1NLdW9mNXRZV0N1MjA1V29SQVJzQTZW?=
 =?iso-2022-jp?B?VUN3UVh5OVc5eFp0YWdTU2NxamVlbTJ4enNNeGZBRGxOSitKQmVGdlFD?=
 =?iso-2022-jp?B?allTb2crWndNVytxN2dGdDJpYjAyUmpJdDFVZnRpNnBPd2ZyK281MzZv?=
 =?iso-2022-jp?B?WFB1ZWFsMXVQT2tTT1ZNbnEvdVlTVHlaZ0tVcUJ5bDRWMHVQcXNxVVph?=
 =?iso-2022-jp?B?aWxwanJyamdBUzROUDNxdDhkRFBmTjAzV3BQcGZtY0VLc3gxNFFIdVRk?=
 =?iso-2022-jp?B?SG9rOG05VG9tN0ZIK3dEVCtwcE10NVFTMmpNUzBUTVYxM0ZmOVdyQkVV?=
 =?iso-2022-jp?B?UDQ4OWhIQmc0Mlp6cktobDJrSDVkNGVvVHoyRUVnNlZOVUNucXZVL3hG?=
 =?iso-2022-jp?B?akY0RmFRd2pSb25lTXRNNWlsWUd3c1NZUzBHUkZzOEJOVEJVZlBMTzJo?=
 =?iso-2022-jp?B?cEJnQ21POVFNb2ljUDZpSDVIS1BTL1VEOWZtMk9jaGpoRkQvaHpVdnNZ?=
 =?iso-2022-jp?B?Ni9LZGFpd0NpVHdwVC9MRVlram5BYWd6SkdaVGdFc3ExN2FDSS9NVXpm?=
 =?iso-2022-jp?B?b1J6OU4wMlVGT1FHei9QWkhJQVpZYWxQU1hsK2JBb04vd3E5cllFamJU?=
 =?iso-2022-jp?B?MHBzaFBqU0tPMGhrdUY3dnNxYVhGcFlEN0VubzZoVVpaQVhRY2ZQNmE3?=
 =?iso-2022-jp?B?WWdoeW1sdFI2MmJaWktOWU02VmY0aUdPMHc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lexZ+58bw/5mJVS+Xp/zpBSK+c/RODcLzYyLWhOCOD5ppPriQzvIO4CLcY94oFDi0a+n029sOgJothDEkoH2rbKKCYRec2tD3BHeOYZuAmAC+kWtuH2dGmb9AWm3HIKs4TeWDYOtZmxvEKO7IRIeHqh3NPdQj9tTiSERWWhsQCC6HHfYyDbOBWtC3QZ4s+UN2G6JgyoEe44uGyFz2Zk6eBuHKbv2oeUWGd8VqGiqnX0liEKhwZqLYOXcK62KEYK5dl6pt4E6I/luRr06OG3Ziq4xuj5NvCoHcmSiIg2TYGFC6/3a6OOcD/Edwo78C3DhKi99vIHa+vm8ZosnZqotvTusASXvedIG35drR5ub5M2qMsrJxmE3jsiiWYCGb6/Tqx0NF2eBIL3GCBKR+CDQSRw7WuCIi+rfpj44Sit+jiz2f0v5P2gXHCXXXtd4qJLQkrSF2QRjEp0Sey/JPN9yg4fZx1cddeliXouo5vqkK8V+jIV86Xzbjuy7LcPy575CUS1pOxN+N9cp5X62hCyeyMrIsHeYkppLImAfpL5mRmYadaKEDDp8uqiOnJVR7UThA1VxSyrjVHIxQveNShz6zPusPUkY+1fvvgXRvdg1gbeZsRdfopdj19VMngsTSucj
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e91b888-ea86-4c70-6b09-08dc7ac0d754
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 00:39:44.4429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4hQUyWGnfe0Qpn9UqHVAeLMClRyc0s7PIbg6VtUrkKqoBLVy93tcT4RtGwBWBDoaXyNl2pUeYyRZAndRlr0VbtgfBgNnNWltdZbC/7F6yEI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11486

Hello Dave,James

I ran resctrl selftest on Intel(R) Xeon(R) Gold 6254 CPU,
there is no problem.

Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>

Best regards,
Shaopeng TAN



