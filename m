Return-Path: <linux-kernel+bounces-319565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 873D996FEB5
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 02:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4B131C228D7
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 00:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEFC79C4;
	Sat,  7 Sep 2024 00:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="MHj7XKyU";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="beX/0Uas";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="kRhkvNNb"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B69647;
	Sat,  7 Sep 2024 00:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725669680; cv=fail; b=THks+EbtzU5j3gZXTajz98xWyYoVmcYQk1y2TtKgaT1wVj2GNzG87kdif2dzMT8Pwefs28lh8DZ0N1AlwY3el85thQ2471T5GuUZDKGDnKgjGtlqYN5u1MGNROkfXt+3Eg4FKc9koC4lWOD6vca1IVCVeLlEmvavDZbffLarJ/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725669680; c=relaxed/simple;
	bh=6lZ/tegZyaiSNIPfNjL98IcLZIDlsBTMYfhPUxM0Va0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=llbk6BplscNFafFeAaoQw3wkzkoCDaqVfewfbs7BkSTe/urnXX/oGieTm3sZwtilvYfy1Jx/4vtHRwjVwMeNbBUc9uaifIRh9NhdqrxNbuU6rV4AttqA9te1fifek9QBXfS74GoC9dLr2OdCj7k7QIqLDQuCvrfN5y/yGOG9g2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=MHj7XKyU; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=beX/0Uas; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=kRhkvNNb reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4870M9ZG014542;
	Fri, 6 Sep 2024 17:40:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=6lZ/tegZyaiSNIPfNjL98IcLZIDlsBTMYfhPUxM0Va0=; b=
	MHj7XKyU5GHlw7alydThmneaGeShxBTUKEfQ0W4/93em8AuRibJ6jx2EpNBGHbOT
	E0okuffku/rP0bRr8ZK3KB9Skvo0s9+4YsKRQl1XYkHvJvjCj79DXSJcRER6lsIu
	NVVVX5jqlC10Lchkq3K20f2l/No13s85pkigvJGp7ygYSyAcEypXbk2quYhg0oQl
	XxEHEZv41eciesgSSe/cRk28me92HdjjjJ4ItqoFKr2WMPWUjS2wNoKCizx59r1Q
	PEfZG72iigdSjSS2ObMZLBNJ6g5WqCgmd0mFn7Afm5yJ+JFfpBzbhmxEPN1cWNBg
	iGhgkLWSlLIVcXrfSIklzQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 41fhxpek90-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Sep 2024 17:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1725669650; bh=6lZ/tegZyaiSNIPfNjL98IcLZIDlsBTMYfhPUxM0Va0=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=beX/0UasTJMOFCkTb1TYCr9N2GhfW76JXontRyYp2ZqMEPDvnmZTCpJ3eo3Sl+dss
	 AV1fbpmMlBYirzZIpQPn0FiztEYUnMQO/uvoAmCa/8kXAFscw243i4orpwnLf4FMIU
	 YDCCLgPVHtaCznIhYhHxGamhAzYeXYG1CiJD8kDWGGiseEHiCB/CFKlQvwubznJ/0R
	 +3v1pynqcEO5ecMF2y/Ha6+xV7tYni0JND8vZJAgnkk5lQv5H3xF+LfJ8Z6HHNryQ3
	 3WtwBBb4Mna7nGYlOFUbHBdCpxVXWQ8PQjN4RjANlh57AMekj+9+R+vdYO4lgb1FoO
	 2rvmrSnH0JjRQ==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 9D79840130;
	Sat,  7 Sep 2024 00:40:48 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id D8F24A00B4;
	Sat,  7 Sep 2024 00:40:47 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=kRhkvNNb;
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 846A54044C;
	Sat,  7 Sep 2024 00:40:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I8KCvvP39kGZdrIN9PYpWh4MVZguXPwtoMXDdS3eqybACpI3KeGEW1Ka61kP94ycCEWz6hNfNDGk3qnX16n9j9h1rWkUtyE4ORo1gEeniED79Up0r570nUl/jsb0efrwzuk0PBotBB15KW1fhMg7/1ydIvJN9V6I2vLBToG+zzkALHVulqQS1oiYkXRcfvEiZ03ULu1oGt20OLfBTjv8o24rIe4HTtlfrwZezhYNe4NJLC0X4j03ugFlOxUwjVvVWwdcGOE8H678Xd8r82XBCRIEbalNVkvj17P9i8VqPPuAFzvOyHxyDHENMZ+Lzj4AKA8TeecgV482eGGS983Z5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6lZ/tegZyaiSNIPfNjL98IcLZIDlsBTMYfhPUxM0Va0=;
 b=YoIwJqp7EjGG234XwJo1iX3uq8Ve5nzrevzrk+KSwwPwyVbzNz6AMLDecZHRBnCzLrE+TC1yF22/SK9wUGBz94v9+mvjIGQ9TlzaSeJZcCGufqzTNBkOhMGuX3MzuA8rudvhFZpKVHOC57WPty2QWER1X3lTB9/I3RgYO2ohNDoSJy/PnaTYHwi2myN5yDiXa4OTU0SY5ecDGRm5aAtiPH1mLfaGVozgHEWSySWGrKTeKFdXipoZnZyULNxZYkTrNf+5UsXHva/UdXz17N6LLn1/b/1HK6gyUePYiccN43txu/qa91dDQfD+Gd2JgsY6taYsoLNtoSxgo7E8f2g6Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lZ/tegZyaiSNIPfNjL98IcLZIDlsBTMYfhPUxM0Va0=;
 b=kRhkvNNbsnKwf8WoA5EU3jXRtjO6T9Aa0+0zYtPcFG9PQezURInqSifNE30FBliyeTW4jclo/4kDNi+CQFNUq71QVmIKi1Q7FI/BPWh3H22HiuxlPa8ymylWryfgMvqzbRg8TiW2VHrzrS2BpFGfRQxrCY3Cvll63Sgbo94EuJQ=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by IA1PR12MB8539.namprd12.prod.outlook.com (2603:10b6:208:446::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Sat, 7 Sep
 2024 00:40:41 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.7939.017; Sat, 7 Sep 2024
 00:40:41 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Frank Li <Frank.Li@nxp.com>
CC: Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "jun.li@nxp.com" <jun.li@nxp.com>
Subject: Re: [PATCH v5 2/3] usb: dwc3: imx8mp: add 2 software managed quirk
 properties for host mode
Thread-Topic: [PATCH v5 2/3] usb: dwc3: imx8mp: add 2 software managed quirk
 properties for host mode
Thread-Index: AQHbAHoswdspijhiKEW9ewx1xXkGxbJLfCkA
Date: Sat, 7 Sep 2024 00:40:41 +0000
Message-ID: <20240907004038.x7idxp52p36dkksw@synopsys.com>
References: <20240906-dwc-mp-v5-0-ea8ec6774e7b@nxp.com>
 <20240906-dwc-mp-v5-2-ea8ec6774e7b@nxp.com>
In-Reply-To: <20240906-dwc-mp-v5-2-ea8ec6774e7b@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|IA1PR12MB8539:EE_
x-ms-office365-filtering-correlation-id: 1d75af11-b47e-4af1-a7b8-08dcced5b368
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WHltYWdvVnFHOHVXeE1aTjBPTWFnbTFjUUlUNzFmdDVONUlXSGlxbVZpRElK?=
 =?utf-8?B?aGg4dThvZ3BlT3Q2ZHpVWHB3M2JaNTFLRnZmZzRNVzdkZjRGYnVwWnNvQXhS?=
 =?utf-8?B?VlJQSmVMWTFSOUpWNFI2d1VLN3hGVERCdGlYWnZBaDF5elZSTG1KYlhFcDk4?=
 =?utf-8?B?SnpXanNURUpNZ05jSVRZcWJBQUh3dXNWQ2hhMEo4c0FQWlprU0JnSFN2djdS?=
 =?utf-8?B?UHNpYTV2bFdJeWlRR0FWaS9SSG1aOE8zYXhrOXpOTXFPMDhyNDF4V3FSKzdI?=
 =?utf-8?B?WDRIK3VVR21mNnkwZjdlQWRxdk10VlVzT2I4WjEvL1ZoWXlURGV0UjR3d0R4?=
 =?utf-8?B?VnJnQUxsZFVTd3dLdTlaUC9BRXE3N05KRGRWUlIydU95bG1VcUlqd3BldkxT?=
 =?utf-8?B?RVpUdXMxVVkzcktZZ0d0emRNdzVSbzJtSFhLNG15NFZGYWdUMzVuVHE2eFZh?=
 =?utf-8?B?OHc2QTJZTVdIb2M1c0JCOVdPL3ErRFZNRXQ2RFh4YmJlZUExVHF6Yys3UTNR?=
 =?utf-8?B?UmN6empUcTNwSm9lMXlUbi9jT3JsTkNlOCtsaUlnWXFVRFppZWlydVdmTlAx?=
 =?utf-8?B?TlNkMndBN2VhUllpUkRCS0xNWGl3ZFhsZ044YlQrTVJsZno2ckl5K2pvMGZz?=
 =?utf-8?B?aDRhelRXZ3lHNmg4M01IajIxdWd2cXRwdGpBREsxZDBKSjFpbnlwZkdYcHJW?=
 =?utf-8?B?K2tiL2FHT1B3NGJFczJaZHdYVkpvZUZ1eWRnWitlaVhPem8zaGRwemluMUUw?=
 =?utf-8?B?TDEzcFpzNWxPNEMrVWZoUU9xUVlUODRaSkU4MERuTmJ6Rm1FNzZoOWc5bmJa?=
 =?utf-8?B?ajlESXdobHRxUlRqQWdlOHkvUC9pQkRQNk9aamFvMlBWRVRucHFZR2gwZjZt?=
 =?utf-8?B?cVB4c0VXQ0o0bkluTG93T1VrUzhMTy93eHZqcnpLR2kzRWpQcVBDQkZDd1Z5?=
 =?utf-8?B?aEU4NkFmQm9KQVNNVVc1aXM0VkRPMjdzVVFEa3R1SEhDSktKcmNKRG5QR3Nz?=
 =?utf-8?B?SG9OUThtRDBHcXBuanpOb0JSWVhzb3ltV2g2dU1xYlppKzdwMVJlc1Rqd21k?=
 =?utf-8?B?VnJTTFVSTnVBMW1WMDdOV1FhbDQxZ2JXWXZENnh4ZlUzd1R1bjYrR1o4ZHdo?=
 =?utf-8?B?dU5naTFGTkE0UEJUdkgzZzZYcW5zR0JHRVBqMHJqLzQwbmhRQnZBQXMzTnFj?=
 =?utf-8?B?cFRQVnpRU0pkSUtZSnZVT3JrNk9HbU1VUmgzN296ZnFzQTNaMDV5V3pFV0VP?=
 =?utf-8?B?MlMxVVh0aGJGVmFsdllycGxENmt1ZVlQZ1BWL2QvQnBQSitqem04UWVPSTN4?=
 =?utf-8?B?RVJQcUtBMlkrMEtqbnBLTGdjUTR0TGRPeml1T0lvRGlncWRjNGtXWmd3NE5z?=
 =?utf-8?B?bDIxWkxJMWd5MVFtZTZWT1J3aVdVL2EwMUpRczh0ZGNHbzdmM1AybW1aamJM?=
 =?utf-8?B?RlJjTitMQnhaNkczbEZxdlB5cHFaNWxUUmtaNnY0cDN4UmdlYjgvajk3UUZ0?=
 =?utf-8?B?RllBUGU0VEwyanNvaG9QaVFzZjVObEcxeGVOSnE1OHRkZmxrbU5oVEo3a0E3?=
 =?utf-8?B?SEZOeUJ4aGUvZHl4SW5jMEFFZGtlWkhHL3dGcjRGbStWTVlPbGZsV0JjYUhr?=
 =?utf-8?B?dHpsaDQvYzhrV09EM3pCSjdMZXA2OFlTemJab21WYWJITm5hbWJMVU1hMnM5?=
 =?utf-8?B?enhHNmZTcGlrSE91NXJlQkNVSU4ySVpDUWh6ODRUQUNNTlpQNlJlQkc3WXZS?=
 =?utf-8?B?d1Nac3hqTUd5SUMxUm5XY1FZRTFncVp5S0FoZDdVRVdSQkdJaXE2QmhjcnVF?=
 =?utf-8?B?LzRRR05iY0tFL3FUREJvc1JoSG5MbzF1TEhRWnJMMFFUMmRySEJFa0FuRWsz?=
 =?utf-8?B?LzMwbVBhSVdxRzErOFdZdWFqeHdXMHhBMUp5RnF3TisxeUE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q0xwQTBuZ296SUdQcFI4L1JQc2sxS2tTdmpKa2ozcW1FZ2xoMkdxM2FGVXRY?=
 =?utf-8?B?cmZIM0JSTDhkVVliTUMyQ1l0V2RzTHJTMUxkOGtNY0FGdWxvQ2V3clR0d0Yv?=
 =?utf-8?B?b20wb3YxblFCNjJIYkhodW5ZSFJTbFJOWjlzK3BhVlFsZEVsMElwc1JlUWkv?=
 =?utf-8?B?TTdDTWNUVWcwb01HejV6eURQeHUrZVU0RWIrYjJLSTdWcmw2QlUxaCthSmZz?=
 =?utf-8?B?UHJmSmNzcHRES1A3QTNaSlJpeFZwd2ZwZ3ZpOEd2K2ZOYlhsZXlXelc1QlN0?=
 =?utf-8?B?UE9EVkVHMHNqbGxUVGQ1Q1Q4b0RNZzM3ZkFSYTc0cElqaldDOENSSUhUWEdW?=
 =?utf-8?B?ZVpvSjNlNjF1Sko1THpIdlRCR3owaTN5NWd6c1lGclRUVmM4NUdaaDFaUnV2?=
 =?utf-8?B?K0JZM2laVy9zQTVpMVdlRTVwS1JRU2laK21oUHM3NFFIMGVGcDZwekZIaXUx?=
 =?utf-8?B?aE0vM3dxNjJFSHgyQ3BUMEVyRXhJYVNHR1QzdlFCMHRoQVhXRVkxb2FBME5m?=
 =?utf-8?B?RmxzZ2tJWWU5YXNYbWVJcjl0SDltdS9ySkVYS0pJT3MrZzJnZGpKSFIyanhO?=
 =?utf-8?B?OW5sTUVUWFBnRnhNTFp2b21EWnB4R1Z1dm5mY0NQcC9jLzVMb0Zjb3dtL2I2?=
 =?utf-8?B?cGQvMS95Qm9ESEhkTEpDcGNKZ2R0aTZjcTAxN3dlR0ViRW8wMWJFMzJxYjJu?=
 =?utf-8?B?eFFMWjFtMFcvNUZ1NVRQK0N6SWg5WVFJV1BTN1hpTC9kMUJPdGdYN0xURFY1?=
 =?utf-8?B?VlorTXR3dUZ2UW1oRkphMTIzZnhrbktJYWRuUjU0ODRkNW0yTk96OUp1d0VP?=
 =?utf-8?B?SzllR0JJalNucTlnU1JramJvYnM0d2ZYR2NwVlhXRzdQYkRwTnpGSG51TGhP?=
 =?utf-8?B?cE1xdkc0UFhIYlQ3dkRCMkxtQ0xNdk8zTWVFeDBsa3o4RU1Wb1lObWJ4L3di?=
 =?utf-8?B?QVpGenI1eGNSZHhZL0x3QmlsQXVtcDdKMUdubVRjMXYyNjRvaHkxeFJYZzBJ?=
 =?utf-8?B?TWVlRVYvTmJNOXFPZUorbTF3aFhKL2RVWFhlZEZwempEanZNZVBPeGVQYVhw?=
 =?utf-8?B?cmNXY00yM3dLaXhNZmN4eUZWL21Dc29PNjdJb0kyOElVaStrb1NLMWhqWVVQ?=
 =?utf-8?B?TzdQVmlveU1XdE5aemR0b1llM0JxcERsVllMWjM3aHU2QVhQbDZRV1hDZ3Bn?=
 =?utf-8?B?QVlJKzV5OFZaeWtKZ0NNWUZGaTVlSXR3UVRiWTIyeGRYOWo2OGhjYXFFWS85?=
 =?utf-8?B?cWl3RktJVnVFSGx5UFNIRnR6OHVyTDlZdWRMKzlZNThJUDFhRHFvcDdoWE5H?=
 =?utf-8?B?WGIrNXJsQjJLNk9rRWt5TmFwaXZNaWd3dkdBNGVzbVJtVGZDV25VbHV6WTM3?=
 =?utf-8?B?eU9PVXlSSkN3R0s0YzQ0R1ZvR283NnJJUVdjZC9GdUJyOVJPaERFZU5wM3Zs?=
 =?utf-8?B?VUcvSThEV3B3MTlHZUZ3Wmp2d0RvNXJpMHhOYzVBOGNqMjEvOWZDai83bVl2?=
 =?utf-8?B?ZjJOSjNORG5pdTlwOWtzaHNpbTVvWkNacUphd0ZMbmlORk5sRHdQTFhNNVpj?=
 =?utf-8?B?Z0kwSCtIN3NObTJvUmZMbjhwMnFBRktEMmNiOWluN2pjMFZiZnRpSWlEbDBF?=
 =?utf-8?B?NjRQY1VJR0VPVlF4ZFZ4eXZ0SzVLbmdXQUMvWlFKcS84Rk8xOTJTUnZUQVda?=
 =?utf-8?B?V1FpS3EzeGZaYllaWGpIQXdZWE50VGZSSk5NWWdLdVBwZlZ3ekJHWDBaSWlS?=
 =?utf-8?B?T1FhOXV6NkVZOTBWcGdDTzJGdmtnSnR4QlZ4cDJ6QmIrWnR4SC8vWncvaVBC?=
 =?utf-8?B?NVNVVkozdXBJQTkyWnlPRG5EYm1pUXlLaEhSMXIvSUs2eGlVbXRLV2VxZXlU?=
 =?utf-8?B?OWJ4aXBBWmlCVmo1RExxL25zdHBmMTNoRWZUellFT1ArWnlFMWdreHVpZjRZ?=
 =?utf-8?B?T1p0UDVLWUwvVExvUGJWR3BwZXhyZ0d2K2I2Rk9UOW02cVlKYmZSYlV3WFQ0?=
 =?utf-8?B?dEFjZFh4V2U1RkpLMEVGOGtXRzI5dkI2OGxIbkJQNHlKU201MXdUaUdRNEV3?=
 =?utf-8?B?T2Z3alJDWFRLTGoxSVpRZkJtNGxidVNKaU52OGtqWnk2ZWFONnVKTlh4M3Av?=
 =?utf-8?Q?V9UZyXvstxy6hiCaRoNUsDoC6?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F9457C528754984EB403E5866E13B7B4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8nFh4kkM4GgaicHUdPUumJUsKVmMeFSsTG/1gem5w+/wVuwSx/Zr0TJW3gPYlEkfv+Fwy03InVBe9veSOPOgMjTULy9b3RmNY+xvuITLaQf3srbBO6hvI9ZHziDuktvDBeoGAZMaejev9U68iPlxjFrzXWa5RyMCALgSQb8IM6NgQ2kxmrJvFX2ide+sgw5K7pJIne06g9gWLn4kFNM/0m6JyEI24rOSpmama2XMBVTxvmnQ7F/FHbtAdEFPdo6sZWwRX03oQYA/YX4L85MWeOGw4SFM5EkEcYALYhCySY69wN6ii4FxO1svcl6Ry1ZwWkXTrVsthIDk1PyzZZhb5EBABUv80f/mQFr6aq8oYHEeFoqRVHg+0QUKPk4ahQwvFq+t7jwlsB5L3MUbj2ECqXNFkcjzBQCmCSlcsXPMsIZnKuDtHVMXrKjKVOlZkWXw4Nqq2XASMOwDg/8yqDDXaSf3pDvD0O7k5GyzTBm0ONDfn+KOuBx89n/nX6RioxONbHLAampKc2x05/AxJuPlv99eJNKBWeclin2t0gy5/K/Z9tFsi9xrZUV5F+9wTn9at3/P8GnRddC9P+VkjciMiIabF5AXgupzDTLp7M8VXo9I+4vve261xBWpFAuSebaJ+wKOjpzdiESHvgIOMzKwMQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d75af11-b47e-4af1-a7b8-08dcced5b368
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2024 00:40:41.2537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fTrhqEBYRyLM9QrqvAdINEVdtjX8DUoHq5wgukapbuhClqcTK7GmGmF5qH+8SKUtcz/Hv5MKEw4b9PJE11YeaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8539
X-Proofpoint-ORIG-GUID: kinwnPaukRbJUlpf06m1OglRquG0sfeA
X-Authority-Analysis: v=2.4 cv=d7ynygjE c=1 sm=1 tr=0 ts=66dba113 cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=nEwiWwFL_bsA:10
 a=qPHU084jO2kA:10 a=8AirrxEcAAAA:8 a=jIQo8A4GAAAA:8 a=XTD3bincG1hyuCiBkw0A:9 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22 a=Lf5xNeLK5dgiOs8hzIjU:22
X-Proofpoint-GUID: kinwnPaukRbJUlpf06m1OglRquG0sfeA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 mlxscore=0 impostorscore=0 phishscore=0 clxscore=1015
 suspectscore=0 spamscore=0 adultscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409070002

T24gRnJpLCBTZXAgMDYsIDIwMjQsIEZyYW5rIExpIHdyb3RlOg0KPiBBZGQgMiBzb2Z0d2FyZSBt
YW5hZ2UgcXVpcmsgcHJvcGVydGllcyAoeGhjaS1taXNzaW5nLWNhcy1xdWlyayBhbmQNCj4geGhj
aS1za2lwLXBoeS1pbml0LXF1aXJrKSBmb3IgeGhjaSBob3N0Lg0KPiANCj4gZHdjMyBkcml2ZXIg
aGF2ZSBQSFkgbWFuYWdlbWVudCB0byBjb3ZlciBib3RoIGRldmljZSBhbmQgaG9zdCBtb2RlLCBz
byBhZGQNCj4geGhjaS1za2lwLXBoeS1pbml0LXF1aXJrIHRvIHNraXAgUEhZIG1hbmFnZW1lbnQg
ZnJvbSBIQ0QgY29yZS4NCj4gDQo+IENvbGQgQXR0YWNoIFN0YXR1cyAoQ0FTKSBiaXQgY2FuJ3Qg
YmUgc2V0IGF0IGkuTVg4TVAgYWZ0ZXIgcmVzdW1lIGZyb20NCj4gc3VzcGVuZCBzdGF0ZS4gU28g
c2V0IHhoY2ktbWlzc2luZy1jYXMtcXVpcmsuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBGcmFuayBM
aSA8RnJhbmsuTGlAbnhwLmNvbT4NCj4gLS0tDQo+IENoYW5nZSBmcm9tIHY0IHRvIHY1DQo+IC0g
Zml4IHRoZSB3cm9uZyB3aGVuIHJlYmFzZQ0KPiAtIGRyb3AgVGhpbmggYWNrDQo+IA0KPiBDaGFu
Z2UgZnJvbSB2MyB0byB2NA0KPiAtIHJlYmFzZSB1c2ItbmV4dA0KPiANCj4gQ2hhbmdlIGZyb20g
djIgdG8gdjMNCj4gLSByZXdvcmsgY29tbWl0IG1lc3NhZ2UgdG8gZGVzY3JpcHQgd2h5IG5lZWQg
c2V0IHF1aXJrLg0KPiANCj4gQ2hhbmdlIGZyb20gdjEgdG8gdjINCj4gLSB1c2UgezB9DQo+IC0t
LQ0KPiAgZHJpdmVycy91c2IvZHdjMy9kd2MzLWlteDhtcC5jIHwgMTggKysrKysrKysrKysrKysr
KysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1pbXg4bXAuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZHdj
My1pbXg4bXAuYw0KPiBpbmRleCA4Yjg4NjQ5YjU2OWZlLi5jZmI1OWY2YmY1ZGRlIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2R3YzMtaW14OG1wLmMNCj4gKysrIGIvZHJpdmVycy91
c2IvZHdjMy9kd2MzLWlteDhtcC5jDQo+IEBAIC0xNDUsNiArMTQ1LDE3IEBAIHN0YXRpYyBpcnFy
ZXR1cm5fdCBkd2MzX2lteDhtcF9pbnRlcnJ1cHQoaW50IGlycSwgdm9pZCAqX2R3YzNfaW14KQ0K
PiAgCXJldHVybiBJUlFfSEFORExFRDsNCj4gIH0NCj4gIA0KPiArc3RhdGljIGludCBkd2MzX2lt
eDhtcF9zZXRfc29mdHdhcmVfbm9kZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICt7DQo+ICsJc3Ry
dWN0IHByb3BlcnR5X2VudHJ5IHByb3BzWzNdID0geyAwIH07DQo+ICsJaW50IHByb3BfaWR4ID0g
MDsNCj4gKw0KPiArCXByb3BzW3Byb3BfaWR4KytdID0gUFJPUEVSVFlfRU5UUllfQk9PTCgieGhj
aS1taXNzaW5nLWNhcy1xdWlyayIpOw0KPiArCXByb3BzW3Byb3BfaWR4KytdID0gUFJPUEVSVFlf
RU5UUllfQk9PTCgieGhjaS1za2lwLXBoeS1pbml0LXF1aXJrIik7DQo+ICsNCj4gKwlyZXR1cm4g
ZGV2aWNlX2NyZWF0ZV9tYW5hZ2VkX3NvZnR3YXJlX25vZGUoZGV2LCBwcm9wcywgTlVMTCk7DQo+
ICt9DQo+ICsNCj4gIHN0YXRpYyBpbnQgZHdjM19pbXg4bXBfcHJvYmUoc3RydWN0IHBsYXRmb3Jt
X2RldmljZSAqcGRldikNCj4gIHsNCj4gIAlzdHJ1Y3QgZGV2aWNlCQkqZGV2ID0gJnBkZXYtPmRl
djsNCj4gQEAgLTIwNyw2ICsyMTgsMTMgQEAgc3RhdGljIGludCBkd2MzX2lteDhtcF9wcm9iZShz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCWlmIChlcnIgPCAwKQ0KPiAgCQlnb3Rv
IGRpc2FibGVfcnBtOw0KPiAgDQo+ICsJZXJyID0gZHdjM19pbXg4bXBfc2V0X3NvZnR3YXJlX25v
ZGUoZGV2KTsNCj4gKwlpZiAoZXJyKSB7DQo+ICsJCWVyciA9IC1FTk9ERVY7DQo+ICsJCWRldl9l
cnIoZGV2LCAiZmFpbGVkIHRvIGNyZWF0ZSBzb2Z0d2FyZSBub2RlXG4iKTsNCj4gKwkJZ290byBk
aXNhYmxlX3JwbTsNCj4gKwl9DQo+ICsNCj4gIAllcnIgPSBvZl9wbGF0Zm9ybV9wb3B1bGF0ZShu
b2RlLCBOVUxMLCBOVUxMLCBkZXYpOw0KPiAgCWlmIChlcnIpIHsNCj4gIAkJZGV2X2VycigmcGRl
di0+ZGV2LCAiZmFpbGVkIHRvIGNyZWF0ZSBkd2MzIGNvcmVcbiIpOw0KPiANCj4gLS0gDQo+IDIu
MzQuMQ0KPiANCg0KQWNrZWQtYnk6IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5bm9wc3lz
LmNvbT4NCg0KVGhhbmtzLA0KVGhpbmg=

