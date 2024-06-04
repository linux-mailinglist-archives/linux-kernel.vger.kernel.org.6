Return-Path: <linux-kernel+bounces-199889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9078FA74A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 03:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A8232887E5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 01:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441848F5D;
	Tue,  4 Jun 2024 01:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="VSyjcfDr";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="B70YKrtk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="lqV/NFVE"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2D079F9;
	Tue,  4 Jun 2024 01:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717463007; cv=fail; b=Cfb+22z+ULbZbDdduEfu/XRxTzwg+Y+ay7xnzLnDI96d1ekx4yQNJy0ScUWlfgPtJWLrCC6L+ZgMjdPImNH+84iCfkkgB7dzIl0mI47xCdSksCd6IPoxa/zzYkNgOeEpP3Tyuj3mxvpuLRDQYqlefETV9nV+XXGu+CZXCwQITSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717463007; c=relaxed/simple;
	bh=DxGu4aeMgFpVGm2M6krYeXm36j1o1paSXedFDQCfaOQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=awANcyqobSsHAQ9wj3HLMonJjgiTUWIDpBn7u8tgxnjGoaih6fcF6+viCGHewb3PpRlKcgbKH3yFNBsjW3jmyzJpSJYRwyXsrV/fN1cscE+7VhYd+j3jAwcbks84mPZgXM6jIl2vQYkdFHmmW7HK+q1dtj/SgXOHzUfCPTYgr38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=VSyjcfDr; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=B70YKrtk; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=lqV/NFVE reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 453Npier019992;
	Mon, 3 Jun 2024 18:03:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=DxGu4aeMgFpVGm2M6krYeXm36j1o1paSXedFDQCfaOQ=; b=
	VSyjcfDr2iBRStv2jGIaEv/6OCtQRBD374vmlYxEJsCe5JEuJV0i0SFbfB+49yUW
	zAbgOLlg3RkBc+G8W+CvwZZtNLnKoi6PuPM/sG3EllYhQhCHqg7JMHSxseWKRenG
	R27HYq1NPFduJRe0Gne9d9ZxrNyFnDBas03Np4/TpalYfSxxEnN0Sp/w5pt6ETpY
	I3qHMiEGMEr3dHnsU+ZxOykpLQV+XkyqlRevyKqDtFETPOSMITHDVi8ZoM996pU9
	1qlE39eAg6BfP7PJthNIweXf8vJU5tkHMQT+zypZVqGU/19RrlIyf8cFjX27Jllj
	dU2sReDirL018L6B3LFm7g==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3yg2js1460-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 18:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1717463000; bh=DxGu4aeMgFpVGm2M6krYeXm36j1o1paSXedFDQCfaOQ=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=B70YKrtk/vaOg2t+rsBdJG4vu+08LRYhMOpcFs5QTtIKhQrLsQL/rdyCMMkA33sDi
	 bvfZ18hCNlEKwRXNuolUuSlaZia0jrw5G4Cx7Pjp7WRrg7nAxcSIf4IInbCeondVlg
	 Fk/uIWTvF5o3Xit4ptt+mxeYEi+llJLjfKap/F505h72IbWDzb9Brdu3kBLjBfSZ28
	 1T/QRQKXuamw2nJr37BoC6xcODSeX5pfDMUNVZbHjt06CAO9m4LXZKO6iLWws3saQS
	 t8a4ctaYqOvAd8oj8AK4JZwg6VOyooPq/Qufw1mdMile/oP4gB11Hh0AnXSIUBgO0k
	 BXswdMTy+K7Vw==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id BE88840147;
	Tue,  4 Jun 2024 01:03:19 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 21AD7A0263;
	Tue,  4 Jun 2024 01:03:19 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=lqV/NFVE;
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 3760F404D6;
	Tue,  4 Jun 2024 01:03:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YuRpzyoQ+5w7sUKSElesKMJkMa6kc3wwEAq7TVJVFFFLteZX1AhkP+2NYEmmZgU2G3mYi6JFfBOSz8mquv5l6x8OiDRQDlf+s/1SVvTkUOYS3+hcxG7w50/lVCAQLYBXxHCLMEGOWtNfSxMlElQpoy2ozClZN/ChNx2VFkQCUq9U2j344Xt0w/2MSdRSRpD7aCB7eIxLInxGWQstOqFiBHKcP0X3cjtZqOfTAYmq37FoqfY2nx8aJJvTyLsE0BnyCtbdMzHg9zlg1sefzelimYCRKyJpph7PESgTTsbeNNfWZgmKxMlAKZ343Z5z9PkRuQrumbcZCJXPzUwiDffhbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DxGu4aeMgFpVGm2M6krYeXm36j1o1paSXedFDQCfaOQ=;
 b=Os37+Zoe4iwVUn5LkacioG0U0t0TCmgwYkh16WcJrW3SgHVX08O6TW30C/ynsTwj4Hyu7lq42F7LtyjiqAsp8C9bn6TQtg13klBNMZRn8txJ4b2F0i8RdURR3w5YwwBrt5lLv19DLZGYOIyXmtzxp7ZpzG2evAtv+nchvdlzyRUnEj98KwyIOG3M8U+alCokST1ZVSctE+dFCBp4a3E6+4qNUZ+7g46tATeLVta04uMt+vNE5yh62DfVTA9KSW9gMmOJfSHsS4h9GFoGPE3xHYHQ83iiJJevTDKhObYt8MwmnNO2zuG1JbzoAPGStv+BemRQSZlAJP8Zp7b6NQ2KUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxGu4aeMgFpVGm2M6krYeXm36j1o1paSXedFDQCfaOQ=;
 b=lqV/NFVE38TudjoiTzg3xteD4vKIVUeMqENxLaMCPSLQ7nE7G1PjQGO9HI/8CIyP/FFg7eJJVL+Z/uIFxdRjoUnn7O8co/x82cB9Cau4mNkSNuYzfh1Qc2ITZIhu7AKq9xduaAiLg3t7ZhIf0kWmpUmOOeRyzM5FCkrMO3AHH6c=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SN7PR12MB7108.namprd12.prod.outlook.com (2603:10b6:806:2a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.38; Tue, 4 Jun
 2024 01:03:14 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.7611.025; Tue, 4 Jun 2024
 01:03:13 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Mike Looijmans <mike.looijmans@topic.nl>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: gadget: Inform system of suspended state
Thread-Topic: [PATCH] usb: dwc3: gadget: Inform system of suspended state
Thread-Index: AQHatbfXThCMnoxt4kuSB1VpY3Td2rG2ym4A
Date: Tue, 4 Jun 2024 01:03:13 +0000
Message-ID: <20240604010256.4dxamwvcjxug6xfb@synopsys.com>
References: 
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.c5f44c79-75b2-43c1-a791-806fe8b693cd@emailsignatures365.codetwo.com>
 <20240603131304.233403-1-mike.looijmans@topic.nl>
In-Reply-To: <20240603131304.233403-1-mike.looijmans@topic.nl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SN7PR12MB7108:EE_
x-ms-office365-filtering-correlation-id: c226c611-aa40-4aa9-c6b9-08dc84321c68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?TTZ3aFVzMlp2VVdnSFgybnQ5VFFMMEVhQ0dIRnd4UThaVGlSRS9yenlTRStD?=
 =?utf-8?B?TnFYRG5nbk9rRjVMY0l3NitMNE9RdERtOGNpQXZLcEVYUC9JUUFpT3k0UzRI?=
 =?utf-8?B?bWt2RStHaGZsSVkvUk9rSHdrUUxma3pBcW1pWmZ6Qkh6YnlHRFowK1RERG9D?=
 =?utf-8?B?cGE0QmJvVlRxay90U3RhZ2VUc0N0VWFJbk9MYnJrSHRCVXVGWU9XbVc5bGNV?=
 =?utf-8?B?aXlTb0I3RU1uSXNkNTUvbDdkSDdjN0c5aEpSeUFNaEpxMG94LzQ2S1g4M0hm?=
 =?utf-8?B?OGlBTndncTl3MWxYcUhKV3E3MGk5M3lZbXVQUTcyTWRxclIyMk9XWWNSSXlS?=
 =?utf-8?B?WG4rZ1dIVFVZYlI2YTJUTDc5cVhBQlhodzdiQytDc0JFZ09jdmVKTEhZVUNV?=
 =?utf-8?B?WWVOOTQ5YW14L2Rmb0hXQ2pNUzlRdXN4LzA2NmpWZTI5QXA5QSt0RXlkU3No?=
 =?utf-8?B?QUthY3k2MWFvRUpRbGRHeGpSNUtod2o5OFdVcG1WaDc4bzFTY3FrOGF5Y21h?=
 =?utf-8?B?Y3Q0Y3ByZFJwMWRNdXpacXVuTU9BOThCM2tGdTFmL3p6TDkwck5WSGRpbGRH?=
 =?utf-8?B?QU1iYUdVZHpsdGdBR1hndnQyK0k0LzNCYm0remlqZGV5WTQ4UEhOVXdGeEI3?=
 =?utf-8?B?M2Jhc0pQK0NtcXF1R2U1dTFKUTZTeWFVVkY5TURncUY1bFRpenRJKzEyWHFn?=
 =?utf-8?B?L3JaM3p2VGswdk9kU0hvVXJEZ243VjI0WUkrRFZ0dkhJR1d5K0NQYkZ4d0ly?=
 =?utf-8?B?bEZYYVNEcVJvcWtvU0lhTUJ0ZC82dTFOZHhiblFHRUhHcjh1YTZoemROcmdn?=
 =?utf-8?B?bllibC9GMG9lWXRRSkVuaXR5Sm55eXN2ME9YYTM0VUZrYzBIR2ltQThvdkNo?=
 =?utf-8?B?VTZEMGZyRHpybVZKQzd0UDVRWFExejZrVmNPL0xJNlpNSUdNL05ONWdLTTF1?=
 =?utf-8?B?dWhucFpMQWxoaG4xZlhsTGZHeXFyWU5UQm50ZCtyVjN1Y1lRTVNsdVBya2ZW?=
 =?utf-8?B?Y0paMHhJOWVGWWdWejk1RTArcWNMMGZUWGxDb0tFVzZ2M1hZRXN5d2V2eVVG?=
 =?utf-8?B?UmxwdFB6K29oaGpoK3ZROHZIdHVWdElPOHVxUnRuZGpqYXQreWlBbnl4TjQ1?=
 =?utf-8?B?eDkvdHc5WW53S1N1REVpVzhWdG5BMVY4NW9rOHByS3hjZUVJUlVMaEFjTzhQ?=
 =?utf-8?B?bmFXd25Fa0dmUkE3ZUs1OW5EdXVlR3BjUmpMMHZJQ29TZzdQSWcvUlRndG9T?=
 =?utf-8?B?SDdzSDZIYjM4dmZBN05hVGQrVEpQZjJuckxiRWtQdk85c1BwMk8wdGRnb1hi?=
 =?utf-8?B?NkFodjUrYWpQU1lhWmE1T1NjcXZOWVl3Y3M2WlJGK1BGQWFEUXpoN3hkRXJI?=
 =?utf-8?B?VWxxb0lqVlJpYjRGUTJtbkI4SG9TSHFQY2YyOGw5dHpiZEN1cHF0Wnl3RHpy?=
 =?utf-8?B?TEw3cGIvTDlhU2xWSTBnOGFZZEtDWGlSeXhUaTI1ZnRVN3hSdlNRT01oVTNC?=
 =?utf-8?B?UVQ1cHZCSU9XZHdmdHczc25LY0ZGcDF2U0J4MklZNVdTZDBKeXo3TjJDOVJ4?=
 =?utf-8?B?R29yb0VpLzF3UEI0amdwblcvSTdYc1FSY001MC9hbllxMEIyQ3VSWHFEUGFx?=
 =?utf-8?B?K3VDbktQWjM1ZzZLMzJHWVlTb25sRlFPSk9PaE1VRHRTeEpObCtVSmtuWTk5?=
 =?utf-8?B?a3FlWkNxL3o4WW56OHdmQWZCM3VrcGh2TCtudzFRWG4zZ2tZdDJYbElBPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ODA4NFdWb2UxMFNOcCtNM01GZ01mdzJ4b0xrWEJ5UlE1TCtCWnhaZTUyYWwx?=
 =?utf-8?B?azU1V2ZDTzRZZmp0SFpNMzNVSGcxYjE0bVRXUFBFSnB1SEJSL1BUOHRxY1Ns?=
 =?utf-8?B?aFEzR05NVitRb3ozbTg4V1ZETkpOSzN6Sm40N203UEtqNkZpdmJxam8vMmN3?=
 =?utf-8?B?T1BudTgxVnZGSkorUGk1UzhZZDYyMTdGSk41TE9UM2IvSFEwMHpYQWh3VmpU?=
 =?utf-8?B?VXN1ZThtQkpIMTF6b1hJMTQ1R1lpRnVoME92ZXkzZmdMUWU4aTZaM3VjaWp0?=
 =?utf-8?B?Y3dLdU1ROHQ4eExXYzg4aHl3WWF6UGZNYVJFdXJJWE1BdDc5aFZBcGJPMlh1?=
 =?utf-8?B?ODIrejB1aDJlLzJocFg1TkdJUFhQWkp5dXJkSU50RnZQWGtnZTNCZ0RKSUdR?=
 =?utf-8?B?K1J6WEdVc2xrYU1pMXFYbHR1b2VBOUVLNE8rRndMc2NkRnpIbGp2dzh6Zm14?=
 =?utf-8?B?TlhheTFEMWZBeGRtSjN0TlFTUlpCRWpEbzJ1UlZ1TlRRcCtaam82YnFxZXB2?=
 =?utf-8?B?WjFqTEk1QUxIT3ZXL1d6T2RLQ2o4cGJlWkhNWWNrcGlvUCs3ajh0UlJHcTJV?=
 =?utf-8?B?VHdnSkU4d2ZFdFNnV2JyNHVJanliaXJXTENvbnpRL0RWb1I5RFJpRkZhYVNP?=
 =?utf-8?B?Ym9iYjAzaDByaDBxRFRydGFJTFd5d0d3MTBiZzc4UXFTN0Z1VmFhTW0yMUly?=
 =?utf-8?B?dytodkJDM2h2dEtVc2dNRlVSUWNuYVQ3Ylc2VlgwWk90MUFuRFpqVThkd3Js?=
 =?utf-8?B?d2tVNENhZGorL3ZudXNRckJlMTBQTnBKZk9vR2xwQk9EQ0dJMG1LRXJRSDE0?=
 =?utf-8?B?NUNaMmx4MWdGNFdYTkJLVW5SRitlNU5KTTZhbHAveEt4cWFXRmd1QyszS0JK?=
 =?utf-8?B?ZEUvTk1EOS9QWWc2MEc1QmpUeEF6YnRYLzZFUG1WNVhpdWZ5Yk5mdFdleGx1?=
 =?utf-8?B?R1BEZ2xQclMxeXdvQkFJcHVsdGN3R0hKcDB0dW1xeHNvWUNRSzdYWVg4cG9V?=
 =?utf-8?B?WTBteGtJV21RQUJMM0MzdWhuMWo4WXVDOVo2VElXNUlzQUNMTHVmZzRMbHBa?=
 =?utf-8?B?TlVzendMVDB2eDFLaGZYcWVBeGZrTlFuWjZtNndIaHlnREoxM00rc3M4SURJ?=
 =?utf-8?B?UkhwSWNQMWNxbTRFcTVFQ3lQNWJhUW9ueS8xb3I3TVFvdXd5Q25aTkpCK3hL?=
 =?utf-8?B?Mm8rQXRDTlRzUFBUdXBUZVhLbjN2U3VRb1Y5cE8ydHNvWW82eHRWK1FQNW4v?=
 =?utf-8?B?bGJmQVByWFBITkVDLytqWkg3UktJT1NIMjR0USt6T0RJc3FZa2dhTDFBaC9X?=
 =?utf-8?B?U2RzcDZhY2IzNTJNUGhlYkFEWEZEcjhET0lsWDU1ck1IV2pQMklWWmpJbm56?=
 =?utf-8?B?OUhOUHJtVjFmV2JycmRuZTNqNHZNcURoSjdiS2R3QTByYkF2VTZMQjdNZGNn?=
 =?utf-8?B?SnlUbEFRcCtaTUphdnBtMmdRcW42bjZQdU5IZ1c5bGYyaHJuL3pZajZwR1k1?=
 =?utf-8?B?NVBxZjUwc01LcEJnb3pqTVMzMzgrZlR6di9MSzZyenZ0KzFSWmFpeGdEdFBG?=
 =?utf-8?B?ZWsyT2orRkRKU0VsSlgxd1VtVkRSWm12VUZVN2U4clY0RllZTU1LNXFEVHVa?=
 =?utf-8?B?ZjFDOEpMbUtWOENxUkZMb0tobUdzUEtyUFZqZVg1TTg2N1lNOG9md1lkQjhB?=
 =?utf-8?B?OVhweTl3MWtaRHJsWmJoOE92ajF3b2RVZ3N3U3BxcEF1UDRBb0Y1M3R6Z04v?=
 =?utf-8?B?d2cwVXFwUzdYK1ZXaE9FQTV5TzY5eGZlNzk4MVRMMlQ5ZlFTcStjZUhTMmNU?=
 =?utf-8?B?RkRUM1NucXhZYktQNE90R3BMOVBqS1JyUWUwSlBCUFdOcm1UNjBMcHNxckdE?=
 =?utf-8?B?a3EyVllJNkxQd2tSeTZwbVQ2cHhabWtvMXFDUWE1UHU1TUtXb2FtbEhFbFJY?=
 =?utf-8?B?WTA0bjJlTkpUc2pqWXozcTVWQlc3Nk56T25uekVJbXVVVHZ6dVZxRHVuVWNG?=
 =?utf-8?B?TGJwbjgrOVQwUm0rRVgvSnE4SGRobG5UZnJhaUxBN0c2Q0lQWWxYRTRQTFhu?=
 =?utf-8?B?SXlMRGhVWXpFcFlHaVNoNmNDblFEMGhaaHE3Ri8wdEFYUlFxanN4UndQTGV5?=
 =?utf-8?Q?zctjQkLqNN2RY1W+AnNGHm45C?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <31FD27C141A54345B22ABD4EE8F6ECA9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	/qtNpf4a95r3kKeG9B93HVNlr6+4LsCBZGj68ZlgOMBpHOX+UFpRTJhkO7yk3auFcW6E43xIRg6U7bWXzu0Q13cw4Yp7s8HPXPzDwBhPTQz5KgZRjyllJruX1iPFm0PkB59kaB6+jPsZ4jdhR909OrvP8gEgVkZDosTzn6q6EcTuJ3+qk9jjQpl4s2JGDEuBjS+2rWdegClT7XC+TjsxZBSoNllK1w+YUIqJ3sGpGRLd2r9DDNvbftRzmWfzkhWBDcX2NmyZ/bt5ROZGO3UO/KSHCCZYWv5rrumQuXBWqV9CwVwNJhKpQqaKlyfKHf1BTkYw79xyAG/5jvI/su/wt2pguyrp4mgCY+8c69uLZapjivA+R9lIdh90eXgRpQpulRKCOc1eGI/g9fXug/p6NjZrLhNQCcScM7+7JtHp+GnA62RIDRZx6V2bs+ZJR5XzDERE8ziDMbkaYgGy5lU7i6LHn5t3vEAkrLqmOXNtiOMjiHSLzWtRJc9UJWsUEB1KpXQZYBtQqPXIWxdZN/DVD888PrtipenYyQol+qBJKEcMm2aGg+p0S54DeaMgoabBDOtwLj5hn7lwoC18AlxrYJhAGQYC0I0ytIV9cQjymG8d0eJhYebqgUb5MoI+1X6iSTfX6dlFr90iV4P/ot0rQA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c226c611-aa40-4aa9-c6b9-08dc84321c68
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 01:03:13.9531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rcY9MH6zF9e/bf4bJ/16jy7sh1GDSy52nb+6zHoEa3jpxHhr16JICEUxmmOud+hjWWecwcy+ujBOZfmeX8UHcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7108
X-Proofpoint-GUID: xCjUnXWNbjXu7K8ov8g1nY7yNO2T-G_K
X-Proofpoint-ORIG-GUID: xCjUnXWNbjXu7K8ov8g1nY7yNO2T-G_K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_17,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=840 clxscore=1011 mlxscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406040007

SGksDQoNCk9uIE1vbiwgSnVuIDAzLCAyMDI0LCBNaWtlIExvb2lqbWFucyB3cm90ZToNCj4gV2hl
biBkaXNjb25uZWN0aW5nIHRoZSBVU0IgY2FibGUgb24gYW4gTFMxMDI4IGRldmljZSwgbm90aGlu
ZyBoYXBwZW5zDQo+IGluIHVzZXJzcGFjZSwgd2hpY2gga2VlcHMgdGhpbmtpbmcgZXZlcnl0aGlu
ZyBpcyBzdGlsbCB1cCBhbmQgcnVubmluZy4NCj4gVHVybnMgb3V0IHRoYXQgdGhlIERXQzMgY29u
dHJvbGxlciBvbmx5IHNlbmRzIERXQzNfREVWSUNFX0VWRU5UX1NVU1BFTkQNCj4gaW4gdGhhdCBj
YXNlLCBhbmQgbm90IGEgRFdDM19ERVZJQ0VfRVZFTlRfRElTQ09OTkVDVCBhcyBvbmUgd291bGQN
Cj4gZXhwZWN0LiBBcyBhIHJlc3VsdCwgc3lzZnMgYXR0cmlidXRlICJzdGF0ZSIgcmVtYWlucyAi
Y29uZmlndXJlZCINCj4gdW50aWwgc29tZXRoaW5nIHJlc2V0cyBpdC4NCj4gDQo+IEZvcndhcmQg
dGhlICJzdXNwZW5kZWQiIHN0YXRlIHRvIHN5c2ZzLCBzbyB0aGF0IHRoZSAic3RhdGUiIGF0IGxl
YXN0DQo+IGNoYW5nZXMgaW50byAic3VzcGVuZGVkIiB3aGVuIG9uZSByZW1vdmVzIHRoZSBjYWJs
ZSwgYW5kIGhlbmNlIGFsc28NCj4gbWF0Y2hlcyB0aGUgZ2FkZ2V0J3Mgc3RhdGUgd2hlbiByZWFs
bHkgc3VzcGVuZGVkLg0KDQpPbiBkaXNjb25uZWN0aW9uLCBkaWQgeW91IHNlZSBkaXNjb25uZWN0
IGludGVycnVwdD8gSWYgc28sIGl0IHNob3VsZA0KdHJhbnNpdGlvbiB0byBVU0JfU1RBVEVfTk9B
VFRBQ0hFRC4gVGhpcyBjaGFuZ2UgZG9lc24ndCBzZWVtIHRvIGRpcmVjdGx5DQphZGRyZXNzIHlv
dXIgaXNzdWUuIENhbiB5b3UgcHJvdmlkZSB0aGUgZHJpdmVyIHRyYWNlcG9pbnRzPw0KDQpUaGFu
a3MsDQpUaGluaA0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNaWtlIExvb2lqbWFucyA8bWlrZS5s
b29pam1hbnNAdG9waWMubmw+DQo+IC0tLQ0KPiANCj4gIGRyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0
LmMgfCAxICsNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdl
dC5jDQo+IGluZGV4IDRkZjI2NjFmNjY3NS4uOTllOGVhOWRiNjAwIDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0
LmMNCj4gQEAgLTQzNDMsNiArNDM0Myw3IEBAIHN0YXRpYyB2b2lkIGR3YzNfZ2FkZ2V0X3N1c3Bl
bmRfaW50ZXJydXB0KHN0cnVjdCBkd2MzICpkd2MsDQo+ICAJaWYgKCFkd2MtPnN1c3BlbmRlZCAm
JiBuZXh0ID09IERXQzNfTElOS19TVEFURV9VMykgew0KPiAgCQlkd2MtPnN1c3BlbmRlZCA9IHRy
dWU7DQo+ICAJCWR3YzNfc3VzcGVuZF9nYWRnZXQoZHdjKTsNCj4gKwkJdXNiX2dhZGdldF9zZXRf
c3RhdGUoZHdjLT5nYWRnZXQsIFVTQl9TVEFURV9TVVNQRU5ERUQpOw0KPiAgCX0NCj4gIA0KPiAg
CWR3Yy0+bGlua19zdGF0ZSA9IG5leHQ7DQo+IC0tIA0KPiAyLjM0LjENCj4gDQo+IA0KPiBNZXQg
dnJpZW5kZWxpamtlIGdyb2V0IC8ga2luZCByZWdhcmRzLA0KPiANCj4gTWlrZSBMb29pam1hbnMN
Cj4gU3lzdGVtIEV4cGVydA0KPiANCj4gDQo+IFRPUElDIEVtYmVkZGVkIFByb2R1Y3RzIEIuVi4N
Cj4gTWF0ZXJpYWFsd2VnIDQsIDU2ODEgUkogQmVzdA0KPiBUaGUgTmV0aGVybGFuZHMNCj4gDQo+
IFQ6ICszMSAoMCkgNDk5IDMzIDY5IDY5DQo+IEU6IG1pa2UubG9vaWptYW5zQHRvcGljLm5sDQo+
IFc6IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwOi8vd3d3LnRvcGljLm5sX187ISFB
NEYyUjlHX3BnIWRYdjViTjZfRkpSVkI3cFFvZ2s2WnhQT2I5N3IybTRDSjlSMnJ2eGVsZmpiZk5o
SmpROWlsUnBxUkJnTzk4M0p4b2Y5SHM4ZjhyWTZuWDFoeUl2RDZaTkl3bkttYjljJCANCj4gDQo+
IFBsZWFzZSBjb25zaWRlciB0aGUgZW52aXJvbm1lbnQgYmVmb3JlIHByaW50aW5nIHRoaXMgZS1t
YWls

