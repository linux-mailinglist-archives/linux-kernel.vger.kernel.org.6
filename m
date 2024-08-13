Return-Path: <linux-kernel+bounces-285641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9479510C6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 01:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DBD81F2438F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 23:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D181AD3F5;
	Tue, 13 Aug 2024 23:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="lQnip65+";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="OCYfJjys";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="siphkWLJ"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0FF383BF;
	Tue, 13 Aug 2024 23:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723593455; cv=fail; b=FpuB4OMlSVfTg9ir/JDPKJ/KSk5pHxM6JUm82n/kZ3avsMoBbCtXDaJouNeR75SO7Bmd0vM8vmfKjtpx0K8AYcK/s57oEmIA6bjekBrGwXHvKd+hhIrIlTyAk/4U4+5csuAGGwZK+vNSp+xEXQOK3ja34/+Ib1TvrXRZhsBNI5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723593455; c=relaxed/simple;
	bh=0p2bJTXVeHjrZRk9tHwzobw+gGo54N+nnlH6SZTd2J8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IJMOAC7tKgsLXjuiz17G88GUDN8ldzmDzP/V/qaJLKihTFawd8CZMEy9u9Mqj9xEBNCUr9ycIsKkTUWS/qDnJGuWJ/92r2bObCw5LVwNNltmY0nUCIpqKLoauQ8HTiZvlLT8y49pi8L56EMLk48ut/vRDRFzonLvLFMPOCmQcD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=lQnip65+; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=OCYfJjys; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=siphkWLJ reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47DNbN7q006599;
	Tue, 13 Aug 2024 16:57:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=0p2bJTXVeHjrZRk9tHwzobw+gGo54N+nnlH6SZTd2J8=; b=
	lQnip65+Lq00NCd6ViQwYDa1kP2Cqy0/vVeAAOSOdKIlCZtvX8LHqJp2/kl1i0DE
	O299fvPb7+tg7/SoZjnid0ImJ7HdLqpJpv95vwPH5f2MCnLJrjBQrh28RIBKqGrZ
	yujiT4YP7u0jUWXZ2ZHyFccrT0J+t27Ji1mNFSLuxp6kZeKciEgoD1fbCtEGLUMw
	9GVvQEBDDe5zZRdWjDcmvqu+Wm/SDBdLfDIsfYvwZ1UCPRlwlGvFuKMA04HVQR2s
	telMsW/yKHhb3LCCLIy9YNhx3TtVouTykvpwmbhNkZJAS+EZT5owSO2/EbNvG9U1
	eSUvXJKJaiMopYa/8kQeJQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 40x74sqq36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 16:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1723593426; bh=0p2bJTXVeHjrZRk9tHwzobw+gGo54N+nnlH6SZTd2J8=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=OCYfJjysL1x5zNBtzzMNkdzUgsyeSheK1rfuILOq4RTRtVpyfkCoy/h3NtV2IkGQJ
	 h9VeW0vojjfpqZptq9NCCMlQa9ONZG/RbI3962mNxsx//sDLzinPwhF3A1j2HpUqrG
	 ulzCZXe/WUewh7+Cc2TmVoDEtGAma991EkC63SstmRMulH8EtQDWV0usdKCmHxsqRV
	 bpeROO4CA+rThYXysqvbazO8+NEtNm+QiMrZQY/8JbUI51iOOCEujdoSOMz7hPuhhT
	 l6PDinxJ1Xmh13xXhumJKj2wN6rPJ+v8ohXQkamFe6vSAJ3vyWxXv9iE0jqNtcK42S
	 6ws3c5Tos0aPA==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3D4A340358;
	Tue, 13 Aug 2024 23:57:04 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 7C3FFA0081;
	Tue, 13 Aug 2024 23:57:03 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=siphkWLJ;
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 209CF403EC;
	Tue, 13 Aug 2024 23:57:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=djhY/lM6OvqiJBGej1B6INvxTdouNurz5JIGLCHdWGh16uEBCFC+z9f0qfN7oNnVvk2W8Al0v52FrDdluSXj7PwSLZ3lr2ss1TmcBdjs0/eCW1pHOBLd8Ws9OMDlSMMHBUyTXBYUxyLhI56J9oqRaGVFiOFDLbKHkaiwTFtFlyhVmEQ8E82hKv+6Xq/8j3e+bnLx1K8DyvjFhLi3gC600KnWKgf5SoeF+Pt5WsGs3Wnapu7k3sqobbjVqPanAV76Is4DV6MYTUb9RIIjedntRHKtFbLDQMgW5ttDl9z39a2pcSg8HQL50tsHtyRTyCSiwG4irKGPkqXgcosrl8NR2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0p2bJTXVeHjrZRk9tHwzobw+gGo54N+nnlH6SZTd2J8=;
 b=DNZY9xfgpZIlVjev1Y3RZ6YFRl3wNc1GsZwdmWZNHx0H/djKV4rXRI0tTOYkjir5F4Y/MUy90DjRa+XnDLAKzU9hYmEjKlYZRvqNpJ3RNbYsVsAo6Xe3hsKZhiCSklDgJxCfdueQpkg9MOruub5vGV7YitYAKoFG/beXvhoLh7rHmpdmo0TcvIP/sX4xBkfzDtmMDq18oImWG+updPtJP7H7aSwHNpAJb3UvGP99irUp7JYqcGt9WGhoPz7cQGUlkTvDBin6GgHWeAUiBvAkToGlLRd8GhivwbXK1sla5snsqjnlPLUmO2gKmopMziCS17of2vG7GllrG9AFSxZ4fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0p2bJTXVeHjrZRk9tHwzobw+gGo54N+nnlH6SZTd2J8=;
 b=siphkWLJIN6sW5io/Hvx+zDrVUWlyybqUJ0UO0OPf/VizpUwTkkT/i1PQ39i3FLMSeMZAChwAk9gPlbn30qJ2t8OU5cNO8E9wesE8topbiUqiu+MzASmVMp2WXvsJYQQ5JTNq3kreAif7j8gCwQv7KS5TnSTZJ8KrKKNo8TLtrI=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by MW4PR12MB6875.namprd12.prod.outlook.com (2603:10b6:303:209::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 23:56:56 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.7849.021; Tue, 13 Aug 2024
 23:56:48 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Frank Li <Frank.li@nxp.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "jun.li@nxp.com" <jun.li@nxp.com>, Peter Chen <peter.chen@nxp.com>
Subject: Re: [PATCH 3/4] usb: dwc3: core: add a core init flag for device mode
 resume
Thread-Topic: [PATCH 3/4] usb: dwc3: core: add a core init flag for device
 mode resume
Thread-Index: AQHa1HHqM5Cvp3uK6EGalLdh+Cd9ErIbJTeAgAQjWQCAAHOBAIAF3riAgAB1NgA=
Date: Tue, 13 Aug 2024 23:56:48 +0000
Message-ID: <20240813235642.zaxom3jbuomfwghf@synopsys.com>
References: <20240712-dwc-mp-v1-0-295e5c4e3ec9@nxp.com>
 <20240712-dwc-mp-v1-3-295e5c4e3ec9@nxp.com>
 <20240807011347.ucxlxmcikizreioj@synopsys.com>
 <ZrZC8AFtmR3Zn1c9@lizhi-Precision-Tower-5810>
 <20240809231844.okzwndlds3zh75rh@synopsys.com>
 <ZruQZ/Y/aqIcO0tq@lizhi-Precision-Tower-5810>
In-Reply-To: <ZruQZ/Y/aqIcO0tq@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|MW4PR12MB6875:EE_
x-ms-office365-filtering-correlation-id: db16353d-7277-4d12-886b-08dcbbf3981b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cThLd3JDbGptam9vUjlVaTVWY2Z6ZXpRY2pDdlZ6ZzhsSVBXS2FlUVR0bldD?=
 =?utf-8?B?MDFzU0RNZUpwQmZ6bThBUXFlM2J2eitLaDJmSWtQVzhjU1dTT1ZFNmVacko5?=
 =?utf-8?B?N1lGS3FMMkFVOGwvcFRMSzdGZUxPVUpRNytuRkQzNnlIVVhPUUh3MmQ3MXo4?=
 =?utf-8?B?TFFkbTlnL1ZNUGg4UXFFWUtHSUtJbENaNTc3VjNiSzBGVVVOb3UrV0UwbVBp?=
 =?utf-8?B?b2EzWkN0UzNIQzVFbWJkQlU2OUhnNm90QmVhcXRReDFjdzRFcU11b2pmNHpx?=
 =?utf-8?B?YWVqcWVoMER5ZnVwWWZaMWVwWkIyVkR0dWJ5MVVaZVgxSFlyUGhNbDJLbnY1?=
 =?utf-8?B?d3JHb3YvTU9ZZEQ5aUlrUFVsU0RWL1pwMEQ5b0ZEK1R6bUpZSTRCUUNnN3FQ?=
 =?utf-8?B?eCt1TmZEUkpBTTBPQUxSVGhyRHdzL2tlWmh5aGplejI3dDdQeDNaMWMxNlNO?=
 =?utf-8?B?NFd3Z2dwWkJjTEhWeUFWL2F6TGRkTmRKMDIxQVFQUHVpVm5RWUZXZFJaQ3M5?=
 =?utf-8?B?M05Oc1JwalZqaUJlL0dwcHdKUm1Gd0R5UU9YTGhLOTM3WDE0dng0ZmR2WWFC?=
 =?utf-8?B?dWFoL05vVzl4TUJLS3gyTy9zcmJNQ1dWL3pIU3ZmK0VNZWxmUVVrc2o3anoz?=
 =?utf-8?B?NGU4R1E4bWxiMmZESG81dlc1UklhQVdBNzBPZUkzbDNqcklQdVdFK0RBeDdC?=
 =?utf-8?B?ZGczaEhLNnlhVmhLU1lVMVBXZmd0Vm84QTFrby9MSjQvb01Qc25ERG9HbHh2?=
 =?utf-8?B?dnV0eFpxd2dpcXB6TGlhc0hKTGtFRFRhcjFyRTFsZ0RVR3NRL3V5ZEF0VGVO?=
 =?utf-8?B?bVoxUC9Pc1N6dWxKeDdhUFk5WFNLenBzeWNoNzk0dTJqS1Y3cnlWV2dEU004?=
 =?utf-8?B?Mk9NYXE0N09XZmRDRzFKSVl1VTVzYStEUEM2b24xN05rcGdUV1VuTW5DUEhT?=
 =?utf-8?B?VXNrMHN4U2ZOYzRIMzZNSjhnQWJQaTB3Unh3L2RHemNDV3BORjBrQlJPSE9F?=
 =?utf-8?B?MTQ0dWtxQ0FmZnZEaEd5dlBHSWRGdnFodmZXa0dCZ1dIbzVNKzltL3VwRFNX?=
 =?utf-8?B?dFhNbmw5L2NNcis5cUFuM0Z3WUVOY09XbVN2VFJ3RzR3VUhFVmFmVU9BaEU1?=
 =?utf-8?B?S2JlUVFLZkVLUWRYd01zR1lhTURaRnRJMUNVYS96dWxXRUxHZ3YwVUtXdjE5?=
 =?utf-8?B?RkUrcEpTSzZkb2wyeHN4N0FlK1VwZ3dLcC9HYXJDM25pSWRxYnFURFVaNlF5?=
 =?utf-8?B?MC81VFFpQkF4enNzQm9pM1d2MElsOU51anNsWEQ2b2xtbEhIM1lKVFAxRmZT?=
 =?utf-8?B?N3o3MEZYNGxjWEYzbGFSdnRERlBjdlh4T1dLZndmVHJPVGV4UVYwR093M0hF?=
 =?utf-8?B?TVFUbFp1RWd2Zjk0TzdLOExKRGg3WWdJUmZDbU5RN3MvbXRuNGZuTmM5aGxW?=
 =?utf-8?B?andFb1hGWGxhZ0pPQ0lMN3o2VjF5UEYyeE9yQXYyUzRvcmZ2WTd3bXdNWFI3?=
 =?utf-8?B?N25Cb2FDb3lWYWRva0puY0N3NmRlOUx1QWIrcXBVYzhMVlE1YUQ5NDhsOGxi?=
 =?utf-8?B?eVVkd05seDlXSXJSbE5ha05Nak9xWCt3dXZOc1VIZngvc2h2WkxNYlBIUndG?=
 =?utf-8?B?NWdnUkZmTVZzYnV3K0RvQmJBQkdHRUpQNW15MEwvQUNMYkV6TkFEQ3E5QXlC?=
 =?utf-8?B?MVE4eStBVWJsVTN0UTFGNUFjNXlNSVNwWUgraHM5VkRlV2pkK3owK2h2ZXdP?=
 =?utf-8?B?YjlCdERhTWM5WS9kOXNlWENZMGF6ZURGTldjcFU5a0RMV0U4QlpQSmN0TFNo?=
 =?utf-8?B?c21jbEp5VjFmdFdxNmJOcFlCWHEvM2QyYnh5ZmtteGkzaHBCNUxMd0h3MUJU?=
 =?utf-8?B?cjU0L0hreG1nSUp5WlcxR0FaNFI4RkppNEJMYVZ5T21VWlE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RGJWcGFBNUFWa25hbCs4M3ZXQXF2Z0lwbXRxRmR4SUs4bXVsR1ZGeWhMeng4?=
 =?utf-8?B?WFpmLzFYUmdNWEFWeXRqamdHQ05UV1l5VTZha2dDaXRwMjVTeDF6cys5UFNs?=
 =?utf-8?B?M0dMVTg4UGlIbjJmeit4WkIvQnJLTjUzVEh6emZyaVJUTXB5WHN3UEFJUGhN?=
 =?utf-8?B?QlIra1AvdHhmYllSdVh4cUlWc21ncG1jRGhwWmNSR2xsTGlmNVQ5bjlLMFI0?=
 =?utf-8?B?cmVoYzc3VTRWcFRQN1R4NHZYQnV6L0I3NjBnN0VwUXdqZGF5c2FibkFHU0xP?=
 =?utf-8?B?eXBHVmpMMzlGelNLSW82NkNUMnFYaWE2Z0d5UThlYTJGVW9Ma0Rzb3UyTFd5?=
 =?utf-8?B?WENsWUwzRmxMVlRvNEorc1ZaQkhNM2VtUmNIbHlLSzhuVWNQbVRLemQ2STVL?=
 =?utf-8?B?eEQ1Y2l6OWxXZmdHcHMzUmFpOGRGQXdQajNSTTJ5dW5VSFNIM1ZwREZmSW52?=
 =?utf-8?B?TzZOWkdFSjgvVTBXUHBqU01DbXFROHY2QmRQTVRLckZwRjBKSWZrMFZWUGJh?=
 =?utf-8?B?elFVcDdJL2p5QXRxUE1qV2lPVDVCTUNONTlmeHBTNnRyaEIwUnBhOVFMbWFn?=
 =?utf-8?B?aWVab3IwbmpYZ1dheDltMVNmc09nelB3UnFzOWRvdDN4NXVFZXZPelJMQUJk?=
 =?utf-8?B?cDh6aFZZVEFPcTJBelUzeEw2Wm91dWkzOTdRVUV2OXI0Umo1cVhoT2hNWXFG?=
 =?utf-8?B?ZnpCVFJMVjN5TW9yWFYxMTVrN3B5bmNmSk16NC9jTm5xd2JCZkFsTWlTM3pr?=
 =?utf-8?B?c2xXWk5sUGZtTzBxcDZ2Ykx3UnVNdVVtOXRlR2VhdDJjTUh2WWRZNDNwcnNi?=
 =?utf-8?B?cGFVWWczU2VPbnEzY1NRR0JKbDV2emNPdlA5bnNwMmtnNFB6K2Y1WFZNU1NT?=
 =?utf-8?B?V0k5MG5kL1BSaDU2RnJ1TFloaW1uWXFCOWJObHNBZ0hVS1MrSE8vRHNmMmIv?=
 =?utf-8?B?VzBwQ25KRy9HeHdoTm9nVWxOaFlQcVp1cVh2WlJRN2g5MzY5Zkl0M3pHMTIw?=
 =?utf-8?B?U2ttQndmaE9VZ2lXb1M2bVB2L0ZNQjcxUENBQ3JuVmxOYWFlYkEzRUtYS1JM?=
 =?utf-8?B?RVp2d2J2SU1GRkFUa0ZWd2VaK2dvOVhkWGhHWjFYOFBxM1lkQjM3UFhoREEx?=
 =?utf-8?B?TzZsSStiNGRiOFQxVmZTZ2liNFEyZnhLMmVqT3BKeFp1MU90Qlc4SmxIUGQ1?=
 =?utf-8?B?TjRJUEF3RVdTSkUyMUlIRGh1d2JQazdCVVkxdHluWkhIc3RPNE5XamlvbnhT?=
 =?utf-8?B?NEZobXJuSkI5d2dBQ1BPbG5aZy9BOUZXNWxXNzBMTTN0czIzUmpKUFlzRTl5?=
 =?utf-8?B?cVF3Uk1wbzZqdk14QWVwQTRva3ovNDlhNDhBeFdFSkVsa1BMbGNQUWNKTzZL?=
 =?utf-8?B?NUlJcHFna0JpTGVqeDlMdEI4aFZWRHB6MkFrREpjQWRjMmNTSXA0REJvTVVq?=
 =?utf-8?B?ZmlHalh5WldPbkFJbHZxQnpEOGJadmQxNXNUTm1jc1cwVG9wN1NjUTlPS3pW?=
 =?utf-8?B?ZHFnZjdCZm96azdrbmhPQnJxSHU5TnpJUUdORHdyYmVCQnJXYlZXY3l3cjk5?=
 =?utf-8?B?ekRXZ2ljR0p3SVVTS29YNkorWWxXbjYxSXB5d05QRW5FSHRMeTNsRVdOZTJI?=
 =?utf-8?B?Nnc2RFJMM0t3Y1U3OWMySDlUZWtHUE5Jdy9GZ285aVg2MGlnc1Avd3dtUTlU?=
 =?utf-8?B?OVRJZVZTNC9zUXZDY2hDdHQvZDR1ajlwZmxSRFZiQVlIaE80ZEtJM00vMmlM?=
 =?utf-8?B?bEJGZXRtYnJqcGRUR0pHeGJxb2Q3V1dNSVFaREQvWmlnbHM1SUU1ZjNiUnly?=
 =?utf-8?B?TXp3THQySWVmZTZxb2J6OGxyalZaSkV4Njc1YkVxbTQyNmd1MXZDMmhkZDBD?=
 =?utf-8?B?UFJWNXBjbUJyWktvNDd2L0tDb2wrWm5BYy9PUTF2TlhoZktwekN4Z3dBYkpF?=
 =?utf-8?B?ZUkvU0pyL0drN0FBTXFuOGwrMTloSDR1T0NpdnFPc3pHWVpTczBQeGEyeDJ2?=
 =?utf-8?B?cEhZM2N5WVRBbGNEek41bU0xZDR5RHUyU2J2T0x4bDBJQ2ZqYnRRYUVUQ3Vl?=
 =?utf-8?B?ZmZaTzR2cWVqVVBCTDRycTg0UlN1ZzlBT2FYVHlOTWJ2NHFIYU9kUWx5V1Rl?=
 =?utf-8?Q?ldaK+nuYwX7rkofvJ1JT1mUuB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE797EB9BE210042B8AB777186A40E04@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Xa1u928f3i8bE4b3ACEuwYmZyZOa6ih/u2fyER7Y4tzQnl/BOCPFAf7LvrlfcpjkmfWYUBoqxBwdbVSBs2RAa1ELuW451k4Dp8z81UXtef3PcrzFSNpLlC+IgLs/sk2DFSsZ+c361KPfW9hTandIQeQKT5Oogv2HLMqRczVcYQ8kvwyzYwDECBRQHzarJ2ImtbDftwyvzmfRZV80wA4Q6ZvTRy1EzhlcuMUjiGUKq0CTnfE2q9m/098AU3kdDgkZbdQbhHx5Qmh7WfSGvdzwnJWG8xpMVlBPFP50FZVNBDPL29duGwxU4gDBp07CGevfyE6vGvtByCOi7hvZG32kdxj3DEH/92iugRBH+DDoJudD+0XO/E54EpbO+tFSZlORE1cz159vZD1ozYe4QrI6HICVxjevmO/154Fe4fRxoMz9+ZZO6OXUmv/V9QfJN91Npv1eydvBtFdu81wwjoCPB+gKl6wiyNean737erTo/67Z7Mjk/3E9W8+noOCMEuYSqoTRK7KSG7sqeJ+4gnQrNrwGeTdX2I1Fi0b6EkIU4FU+vaL6OmpOjwiR8opaluJfjUkmFtiglirKMbSub7dQhuLFO12yeDVaMN2jH6ypsydo19DasUaes00WEbVNF1TRanVGVrn1xqIffnymoY9VFA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db16353d-7277-4d12-886b-08dcbbf3981b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2024 23:56:48.2982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w8mWa/PK0CHJ6adDnMQYAwf1xYw6sGfGQ2ei+8xuRw2iGRTRUONgzMhztWNfr7p4XtRJxX6cKxn6Qxs3bPx4hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6875
X-Proofpoint-ORIG-GUID: gkQp4HneZGbYaOQJIpWAs6BE37K2VGVh
X-Proofpoint-GUID: gkQp4HneZGbYaOQJIpWAs6BE37K2VGVh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_13,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 mlxlogscore=999 malwarescore=0 clxscore=1015
 bulkscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0
 suspectscore=0 impostorscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408130173

T24gVHVlLCBBdWcgMTMsIDIwMjQsIEZyYW5rIExpIHdyb3RlOg0KPiBPbiBGcmksIEF1ZyAwOSwg
MjAyNCBhdCAxMToxODo1M1BNICswMDAwLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4gT24gRnJp
LCBBdWcgMDksIDIwMjQsIEZyYW5rIExpIHdyb3RlOg0KPiA+ID4gT24gV2VkLCBBdWcgMDcsIDIw
MjQgYXQgMDE6MTM6NTJBTSArMDAwMCwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+ID4gPiBPbiBG
cmksIEp1bCAxMiwgMjAyNCwgRnJhbmsgTGkgd3JvdGU6DQo+ID4gPiA+ID4gRnJvbTogTGkgSnVu
IDxqdW4ubGlAbnhwLmNvbT4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFRoZSBydW50aW1lIHJlc3Vt
ZSB3aWxsIGhhcHBlbiBiZWZvcmUgc3lzdGVtIHJlc3VtZSBpZiBzeXN0ZW0gd2FrZXVwIGJ5DQo+
ID4gPiA+ID4gZGV2aWNlIG1vZGUgd2FrZXVwIGV2ZW50KGUuZywgVkJVUykuIEFkZCBhIGZsYWcg
dG8gYXZvaWQgaW5pdCB0d2ljZS4NCj4gPiA+ID4NCj4gPiA+ID4gV2hhdCdzIHRoZSBjb25zZXF1
ZW5jZSBvZiBnb2luZyB0aHJvdWdoIHRoZSByZXN1bWluZyBzZXF1ZW5jZSB0d2ljZT8NCj4gPiA+
ID4gV2lsbCB0aGlzIGNhdXNlIGFueSBmdW5jdGlvbmFsIGlzc3VlPw0KPiA+ID4NCj4gPiA+IHN0
YXRpYyBpbnQgZHdjM19jb3JlX2luaXRfZm9yX3Jlc3VtZShzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiA+
ID4gew0KPiA+ID4NCj4gPiA+IAkuLi4NCj4gPiA+ICAgICAgICAgcmV0ID0gZHdjM19jbGtfZW5h
YmxlKGR3Yyk7DQo+ID4gPiAgICAgICAgIGlmIChyZXQpDQo+ID4gPiAgICAgICAgICAgICAgICAg
Z290byBhc3NlcnRfcmVzZXQ7DQo+ID4gPg0KPiA+ID4gCS4uLg0KPiA+ID4gfQ0KPiA+ID4NCj4g
PiA+IGNsayB3aWxsIGJlIGVuYWJsZWQgdHdpY2UsIHRoZSByZWZlcmVuY2UgY291bnQgaW4gY2xr
IHdpbGwgYmUgd3JvbmcgYmVjYXVzZQ0KPiA+ID4gY2xrX2Rpc2FibGUoKSBvbmx5IG9uY2UgYXQg
c3VzcGVuZC4NCj4gPg0KPiA+IFBsZWFzZSBjYXB0dXJlIHRoZXNlIGluZm8gaW4gdGhlIGNvbW1p
dCBtZXNzYWdlLg0KPiA+DQo+ID4gPg0KPiA+ID4gU28gY2xrIHdpbGwgYmUgYWx3YXlzIE9OIGF0
IG5leHQgc3VzcGVuZC4NCj4gPiA+DQo+ID4gPiBGcmFuayBMaQ0KPiA+ID4NCj4gPg0KPiA+IGR3
YzNfY2xrX2VuYWJsZSgpIGhhcHBlbnMgaW4gcHJvYmUoKSBhbmQgZHdjM19jb3JlX2luaXRfZm9y
X3Jlc3VtZSgpLA0KPiA+IGJ1dCB5b3UncmUgY2hlY2tpbmcgZHdjLT5jb3JlX2luaXRlZCBpbiBk
d2MzX2NvcmVfaW5pdCgpLiBXaHk/DQo+IA0KPiBJIGhhdmUgbm90IGNoZWNrIGR3Yy0+Y29yZV9p
bml0ZWQgaW4gZHdjM19jb3JlX2luaXQoKS4gSnVzdCBzZXQgaW5pdCB2YWx1ZQ0KPiBkd2MtPmNv
cmVfaW5pdGVkID0gdHJ1ZQ0KPiANCj4gRG8geW91IG1lYW5zIGR3YzNfY29yZV9pbml0KCkgYXMg
ZHdjM19yZXN1bWVfY29tbW9uKCk/DQo+IA0KDQpZb3Ugc2V0IHRoZSBkd2MtPmNvcmVfaW5pdGVk
IGluIGR3YzNfY29yZV9pbml0KCkuIEhvd2V2ZXIsIHlvdSB1c2UgdGhpcw0KZmxhZyB0byBhbHNv
IGNoZWNrIGlmIGR3YzNfY2xrX2VuYWJsZSgpIGlzIGRvbmUuIGR3YzNfY2xrX2VuYWJsZSgpIGlz
DQpub3QgZG9uZSBpbiBkd2MzX2NvcmVfaW5pdCgpLg0KDQo+ID4NCj4gPiBJZiB0aGUgaXNzdWUg
aXMgb25seSByZWxhdGVkIHRvIGNsa19lbmFibGUoKSwgcGVyaGFwcyBqdXN0IGNoZWNrIHRoYXQ/
DQo+IA0KPiBUaGlzIHNob3VsZCBiZSBtYWpvciBvbmUuIEFueSBwYWlyZWQgb3BlcmF0b3IgYmV0
d2VlbiBzdXNwZW5kL3Jlc3VtZSBzaG91bGQNCj4gaGF2ZSBpc3N1ZS4NCj4gDQoNCkkgZG9uJ3Qg
a25vdyB3aGF0IGVsc2UgY291bGQgYmUgYSBwcm9ibGVtIGluIGR3YzNfY29yZV9pbml0KCkuIEFz
IGZhciBhcw0KSSBrbm93LCBpdCdzIG9ubHkgZHdjM19jbGtfZW5hYmxlKCkuDQoNCkkgcXVlc3Rp
b25lZCBiZWNhdXNlIG9mIHRoZSBtaXNtYXRjaCB1c2Ugb2YgdGhlIGNoZWNrLCB3aGVyZSB0aGUg
aXNzdWUNCnlvdSBtZW50aW9uZWQgaXMgb3V0c2lkZSBvZiBkd2MzX2NvcmVfaW5pdCgpLiBQZXJo
YXBzIHRoZSBmbGFnIHNob3VsZA0Kbm90IGJlIHNldCB0aGVyZS4gSWYgdGhhdCdzIHRoZSBjYXNl
LCByZW5hbWUgdGhlIGZsYWcgdG8gbWF0Y2ggdGhlIGNoZWNrDQpjb25kaXRpb24gKGlmIG5lY2Vz
c2FyeSkuDQoNCj4gDQo+ID4NCj4gPiAobWlub3Igbml0OiByZW5hbWUgY29yZV9pbml0ZWQgdG8g
Y29yZV9pbml0aWFsaXplZCBpZiB5b3UgcGxhbiB0byBkbw0KPiA+IHRoYXQpDQo+ID4NCj4gPiBU
aGFua3MsDQo+ID4gVGhpbmgNCj4gPg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gUmV2aWV3ZWQtYnk6
IFBldGVyIENoZW4gPHBldGVyLmNoZW5AbnhwLmNvbT4NCj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5
OiBMaSBKdW4gPGp1bi5saUBueHAuY29tPg0KPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEZyYW5r
IExpIDxGcmFuay5MaUBueHAuY29tPg0KPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ICBkcml2ZXJz
L3VzYi9kd2MzL2NvcmUuYyB8IDEzICsrKysrKysrKysrKysNCj4gPiA+ID4gPiAgZHJpdmVycy91
c2IvZHdjMy9jb3JlLmggfCAgMSArDQo+ID4gPiA+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMTQgaW5z
ZXJ0aW9ucygrKQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNi
L2R3YzMvY29yZS5jIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gPiA+ID4gPiBpbmRleCA3
MzRkZTJhOGJkMjEyLi5kNjA5MTdmYWQ4YzUyIDEwMDY0NA0KPiA+ID4gPiA+IC0tLSBhL2RyaXZl
cnMvdXNiL2R3YzMvY29yZS5jDQo+ID4gPiA+ID4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3Jl
LmMNCj4gPiA+ID4gPiBAQCAtOTUwLDYgKzk1MCw4IEBAIHN0YXRpYyB2b2lkIGR3YzNfY29yZV9l
eGl0KHN0cnVjdCBkd2MzICpkd2MpDQo+ID4gPiA+ID4gIAlkd2MzX3BoeV9leGl0KGR3Yyk7DQo+
ID4gPiA+ID4gIAlkd2MzX2Nsa19kaXNhYmxlKGR3Yyk7DQo+ID4gPiA+ID4gIAlyZXNldF9jb250
cm9sX2Fzc2VydChkd2MtPnJlc2V0KTsNCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gKwlkd2MtPmNv
cmVfaW5pdGVkID0gZmFsc2U7DQo+ID4gPiA+ID4gIH0NCj4gPiA+ID4gPg0KPiA+ID4gPiA+ICBz
dGF0aWMgYm9vbCBkd2MzX2NvcmVfaXNfdmFsaWQoc3RydWN0IGR3YzMgKmR3YykNCj4gPiA+ID4g
PiBAQCAtMTQ0Niw2ICsxNDQ4LDggQEAgc3RhdGljIGludCBkd2MzX2NvcmVfaW5pdChzdHJ1Y3Qg
ZHdjMyAqZHdjKQ0KPiA+ID4gPiA+ICAJCWR3YzNfd3JpdGVsKGR3Yy0+cmVncywgRFdDM19MTFVD
VEwsIHJlZyk7DQo+ID4gPiA+ID4gIAl9DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiArCWR3Yy0+Y29y
ZV9pbml0ZWQgPSB0cnVlOw0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiAgCXJldHVybiAwOw0KPiA+
ID4gPiA+DQo+ID4gPiA+ID4gIGVycl9wb3dlcl9vZmZfcGh5Og0KPiA+ID4gPiA+IEBAIC0yMzc1
LDYgKzIzNzksMTUgQEAgc3RhdGljIGludCBkd2MzX3Jlc3VtZV9jb21tb24oc3RydWN0IGR3YzMg
KmR3YywgcG1fbWVzc2FnZV90IG1zZykNCj4gPiA+ID4gPg0KPiA+ID4gPiA+ICAJc3dpdGNoIChk
d2MtPmN1cnJlbnRfZHJfcm9sZSkgew0KPiA+ID4gPiA+ICAJY2FzZSBEV0MzX0dDVExfUFJUQ0FQ
X0RFVklDRToNCj4gPiA+ID4gPiArCQkvKg0KPiA+ID4gPiA+ICsJCSAqIHN5c3RlbSByZXN1bWUg
bWF5IGNvbWUgYWZ0ZXIgcnVudGltZSByZXN1bWUNCj4gPiA+ID4gPiArCQkgKiBlLmcuIHJwbSBz
dXNwZW5kIC0+IHBtIHN1c3BlbmQgLT4gd2FrZXVwDQo+ID4gPiA+ID4gKwkJICogLT4gcnBtIHJl
c3VtZSAtPiBzeXN0ZW0gcmVzdW1lLCBzbyBpZiBhbHJlYWR5DQo+ID4gPiA+ID4gKwkJICogIHJ1
bnRpbWUgcmVzdW1lZCwgc3lzdGVtIHJlc3VtZSBzaG91bGQgc2tpcCBpdC4NCj4gPiA+ID4gPiAr
CQkgKi8NCj4gPiA+ID4gPiArCQlpZiAoZHdjLT5jb3JlX2luaXRlZCkNCj4gPiA+ID4gPiArCQkJ
YnJlYWs7DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICAJCXJldCA9IGR3YzNfY29yZV9pbml0X2Zv
cl9yZXN1bWUoZHdjKTsNCj4gPiA+ID4gPiAgCQlpZiAocmV0KQ0KPiA+ID4gPiA+ICAJCQlyZXR1
cm4gcmV0Ow0KPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaCBi
L2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+ID4gPiA+ID4gaW5kZXggMWU1NjFmZDhiODZlMi4u
OGE0YmZkOWEyNWIxOSAxMDA2NDQNCj4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2Nv
cmUuaA0KPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+ID4gPiA+ID4g
QEAgLTExOTUsNiArMTE5NSw3IEBAIHN0cnVjdCBkd2MzIHsNCj4gPiA+ID4gPiAgCXN0cnVjdCBj
bGsJCSp1dG1pX2NsazsNCj4gPiA+ID4gPiAgCXN0cnVjdCBjbGsJCSpwaXBlX2NsazsNCj4gPiA+
ID4gPg0KPiA+ID4gPiA+ICsJYm9vbAkJCWNvcmVfaW5pdGVkOw0KDQpEb2N1bWVudCBuZXcgbWVt
YmVyIG9mIHRoZSBzdHJ1Y3QuDQoNCj4gPiA+ID4gPiAgCXN0cnVjdCByZXNldF9jb250cm9sCSpy
ZXNldDsNCj4gPiA+ID4gPg0KPiA+ID4gPiA+ICAJc3RydWN0IHVzYl9waHkJCSp1c2IyX3BoeTsN
Cj4gPiA+ID4gPg0KPiA+ID4gPiA+IC0tDQo+ID4gPiA+ID4gMi4zNC4xDQo+ID4gPiA+ID4NCg0K
VGhhbmtzLA0KVGhpbmg=

