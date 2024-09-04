Return-Path: <linux-kernel+bounces-316023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF9996CA13
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 00:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D48C11C250B1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 22:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364DA17BEB1;
	Wed,  4 Sep 2024 22:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="fcUeOkd+";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="X4YVyxVB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="F41it+C4"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24C682863;
	Wed,  4 Sep 2024 22:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725487626; cv=fail; b=izP+k2YBTqtXjEMnLOhalei1OGCPcpGgm++W+5BSgHEwjQdww4aU3vNVRjEmLGJ80PAOH0hWYQRXfQ9b/R1MVvnJuRe/oX1eI2KdoqL3zsy04F9F8u0VyEJMQhjNfuMbknLBfx4gFWhdF6TmP+LK4g4nI5PCAaiJv8K6M5du0o8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725487626; c=relaxed/simple;
	bh=pmVuose08sGeCCs7yFvyMEU/tJdaWvS5b4mmhz2OPqQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gKYIHZeeSWJlMkloNUIaBMCaUgA12wFav2upJmPXtCHRUmoLmDFgpGpMPt8os5MNdumwQ3zJgJo4Q3dfPCWBOkOXnbzFxXBtfkctXEiM73O/85BP/Js9Vmb/wDndKF2Fbbi0I7Q8LZpgK7sBWh9dNSmuRaNtdtr9NOht4elLU2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=fcUeOkd+; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=X4YVyxVB; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=F41it+C4 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484JmvEG013130;
	Wed, 4 Sep 2024 15:06:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=pmVuose08sGeCCs7yFvyMEU/tJdaWvS5b4mmhz2OPqQ=; b=
	fcUeOkd+NMqutRi5eZZQJsCIznAalRyCw537QdJXOhI0c4F5Nk+MKuScv0mksCZW
	nYtsZm4JepWUiRMnVCuV9Yoi4NLW7ietC3iESdSpK9bpDivfzB54nlkl+D6Ykt6H
	beaoPxWC5gIYrRqPa5sFcldJTxv5d5GJo0FNCJnGrdL4gDvUVvO3VgW1/q4mPTvj
	mxcJK0XO0np4cGAEIF38e/oRDc5itwOFbWTjUnWm4gg8yr6ESzaDZ1h++7lbl8tx
	YwuPUiuMII/DgAGi8oiOpMD1S+ZJe4Qcxu0hOo8tFmz/2Tcx+6qPCfWIDNNsMrI4
	8Y4BJNPNTBYEUNtM2Lh1BA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 41c23x2txp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 15:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1725487607; bh=pmVuose08sGeCCs7yFvyMEU/tJdaWvS5b4mmhz2OPqQ=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=X4YVyxVBElXPmnjg9oI9J+0TRZ0YLFHACiuxwPAMv/0CCr9W+as3rnpebh5jBRyx4
	 DooniUq00NlKUapiUZX4/FjtYWP1S7rs9neL82Co2YTabfOPq+j0S+O9JTYU0l8cwr
	 vpBcKS1uRY4G3NizCRfwcgrz7ld1p0Fxkmm24c5swDrxr376ncMBCvodgIO4G6/ylG
	 6ScFXWFNj3mtIVMx6GTBDwY/wg5KtqykcztzqSpBLEnifR7qG712I4EXFG4cYglHRA
	 z0iYaTp42ibtoAL1UP21dhntQSNPE/tOx/64DXxre0POJpoM08mPwCa/uxYZo4AcpL
	 vUKMyj9rR8I9Q==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7E6E740361;
	Wed,  4 Sep 2024 22:06:46 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id EF25CA0079;
	Wed,  4 Sep 2024 22:06:45 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=F41it+C4;
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 77C6440562;
	Wed,  4 Sep 2024 22:06:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mCpCagpsYYzzyNaR4zmRBegrx75IEwpxIQ5eoj4WC5VGx+244KraI/OGn7YPL9vny3wht7kSnDQhHrgcpOieQoOek6fM6LaP5vQKgcTLZpKiXH4FO7yB1BzDkpGApaRRJXhBX/KZfnaqeU3va6EuzJUYtsxpYjpR4cj9IrdARn8A54fcyv6zxquduZVbmqJxIbQzTvFqAgeVGmw2FJeljKde2+tH21e40Sl8ytzRXO1vaN4LVPYFUXAWmJrhy4r8wQiUf2LteoB3ZwFoe+fEW4rtJSR3e4bEaCpKFPlGIRrKNTj/n+a6Icn5mk5G0DtP3dJk4naew4A2+W+vJp1Gpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmVuose08sGeCCs7yFvyMEU/tJdaWvS5b4mmhz2OPqQ=;
 b=s/KWJndZMKGdJxec4vN4d08p15DeuSas6taSpxdAAxNT76k0AswgGNkOhXxIEXhN9/BAKbgbng6WE6MeteoQnqa9Tkzw24K9kZQSIGKS009At+m2Mj1tSo3oL+4g0ImZCTYsPtVKXEzANxqT/juf1w9sc+/7f5ACSncjaZ5tTjAkbwWbEZvD/n1cPEmSDVtZHd0NcC6sQaV1hbi4lYr//x+awuYEJy9jozNdKPfYOEUhudF73z6NxrCXJ2ke7yKZAid/EQGEaRZJtWxDLA7hFcoiVquec4jahYMCxbuJmq8p+wSdXOngv8LTG8rrakojpD0AUI4Zdy9WJu3yh1eaMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmVuose08sGeCCs7yFvyMEU/tJdaWvS5b4mmhz2OPqQ=;
 b=F41it+C4pzPHlsI5UpgUmEQrNTs19ZmVcMX1DPIdVfueqyPZpdqKC1Bm8OE1SVO97NFq1vbYrZVHbX3OOyyd41zbDRpRDSUZEV2aDPYfeK4ajYDpnxLtXFp9XqetKZMFpvlfbHob52c2SGzGtw5MAON9tHuHh530ybygVW5NJz8=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by BY5PR12MB4049.namprd12.prod.outlook.com (2603:10b6:a03:201::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.22; Wed, 4 Sep
 2024 22:06:40 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 22:06:40 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: AKASH KUMAR <quic_akakum@quicinc.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jing Leng <jleng@ambarella.com>, Felipe Balbi <balbi@kernel.org>,
        Jack Pham <quic_jackp@quicinc.com>,
        "kernel@quicinc.com" <kernel@quicinc.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Vijayavardhan Vennapusa <quic_vvreddy@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: gadget: Refine the logic for resizing Tx
 FIFOs
Thread-Topic: [PATCH v2] usb: dwc3: gadget: Refine the logic for resizing Tx
 FIFOs
Thread-Index: AQHa/gVcU2dx3NbwU028Vf9GncOMbbJGoECAgADT3ACAAL0/AA==
Date: Wed, 4 Sep 2024 22:06:40 +0000
Message-ID: <20240904220632.35b4nvhmngt6akl6@synopsys.com>
References: <20240903132917.603-1-quic_akakum@quicinc.com>
 <20240903221055.s4gu6actfbrkonmr@synopsys.com>
 <b016abbb-7214-4892-b1d2-1bf3ba1b7560@quicinc.com>
In-Reply-To: <b016abbb-7214-4892-b1d2-1bf3ba1b7560@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|BY5PR12MB4049:EE_
x-ms-office365-filtering-correlation-id: d9a513bc-b02b-4e5c-e2e8-08dccd2dda87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VXh1bTZuc3JuWnVwVmVWVjZQbFg5ZGR4UXYydndBUlUrQURGNU50cE1wcFVx?=
 =?utf-8?B?Tm1zenZ4OGpSck15WjlWQnEwSWxrZW8xTG82dm85eUhCY0ttSU5VcllIVGxy?=
 =?utf-8?B?TWI3cW00Qi9kWEpTZTROVHU4WGoyMlExQUpDazdzSWMvM0RWNGVNeUhSNUVj?=
 =?utf-8?B?WU4vWEdEV0t4Njc1VVViOWRQTUhNSzVWakdwU1VBY3ZVVHoyblVsU1BlbVA2?=
 =?utf-8?B?RXYrMG5ielRreWlIRXBaNDZwN0R6YUt5M3hzN1hzNFVrTzU1Y00vOVBBTmVB?=
 =?utf-8?B?dGVPbjlXOVN1L2RPNzFnV2o2OG8zenNad2wwV0pvQ2lTalc0R01WanRSN2Ux?=
 =?utf-8?B?RitUTzcrOHhXdVJ5N0dRUUFnOEpCL2s1VURISFFUbVJRTW50R09EalRlc0FZ?=
 =?utf-8?B?ZjFBK2RMd1FTWXNDbXRaTmRrZlA2NktnMFUxOWFNeXdzSjg2S3JSSFB0QXg1?=
 =?utf-8?B?MW9McjNMNEp3SHZUdjMzNGNrL05EZWZmRk5EZzM5WWVDQnNXT0NtY3d4OTVh?=
 =?utf-8?B?c1FZUWM2VHFIM0xKRXJieStSTHNLMDRHRGM3MVlJc3RzTUVLMDNiZENkaTZm?=
 =?utf-8?B?Wjk0djAyT1d3YWZQOEtiUEFOSUZGQTYzZk5zdVlxc2d2MHdyeno2RlBjZGVn?=
 =?utf-8?B?WTNXWndrc2VyS21JSU1DakN2OFVRVWpoK1lpd2dycTMzVWNvQWx1eFBFNnNl?=
 =?utf-8?B?dm1BZWliYkhvUUJmaU9VeE1ucTBlSS9sak0vaERSK2F3aytnekVib0Rselo5?=
 =?utf-8?B?bXNRRGRiNEMzTmJ2NURjWmNwSWhodkNWbFJZTVJCVDRrZ2t1VThqdVB1Q2Qy?=
 =?utf-8?B?Rkl5andrWWFsZmxRT29uS2piRWFvaDZlNGlET2tIMTliYmFYZnlEVHlWcUdp?=
 =?utf-8?B?b0V0RmhhVExrd2lXdEJJeW1EMiswd2czSHk3NVAvVC9FQzQ4am1sZ2JnUm0r?=
 =?utf-8?B?SEE2RHdSRlZUcStDT2tON1Y1aU0vZWRWSWlHaUNYNUZZdEZWeWRoNWpBTnZo?=
 =?utf-8?B?TlcrOTZleHc0UWRFQTVTSko3VGVmQk55bktGZUxiWk13d0s5cDhobFJncVp6?=
 =?utf-8?B?cWpIclByS1dHV21mZ2d5bkpuNzRjUFdNTy9qbDNzSXhRUVlDZUFHN3dkQ0hq?=
 =?utf-8?B?WlUxUTh5c0o1Z29HMXdqTGU3K1VPV2Jsa1hWWEg1TmFBdWs5dFg1bHdQL3Vk?=
 =?utf-8?B?Tmx2SjdsQ3JNTWN3ZlJHL3FpRkFta3hDSFhJY01PdndCWEdSa08zT1RYdlhJ?=
 =?utf-8?B?Wi85ZzF5dEtscFVpSy9UZzFwVXl0KzBFSTc2WDFncVdWc3puZ0hIZkNZSmx0?=
 =?utf-8?B?YzdLa1NnbVhHVGlxWlBNSnhlT1Y2UFJwMURHMHgzTXNtMVZKRzZuV1NYOFR0?=
 =?utf-8?B?SDczV2hoK1g4Z09Eem9DZmkvU21WczNkZE5qK3Nka3N5dVRZWDFqUG10RFZo?=
 =?utf-8?B?Ry9aSjY5UkhYV0w0TzRsRFpVaGY2aUZFMElaZFBMYWVwajk3QnN0K0RlTVBX?=
 =?utf-8?B?bmViemtwUlE0S0xCTkkyaWp4Q0VFTUoyNlJFeXF5KzR4UGtEZ0cxSmxab25u?=
 =?utf-8?B?cjFCNEZVVkM5STdYV094eHZYMFpHWm1tdDRnS2hmSDJ6Y2s1d1RIanBscHlX?=
 =?utf-8?B?SkgwUzhYbVpwODNmQk9YbU5JU1F6bmVVNmFjeVpPUDhJd3lmUTlTcHJQYnpr?=
 =?utf-8?B?UjFTLy9jbyt3bC9abVQ3MW9qNGIrZVk0cWhQNERBeUpUcHpEcGlwQmxwRmFm?=
 =?utf-8?B?RzVabmd4eGdMS3psdVBKZlNCaE1nSDcxSDJBd2JRWEppTlQyRlNWSExFeGMw?=
 =?utf-8?B?MllRRVBKWTNyRGh5bDhCZkY5YWU1NDl2QW13VlJaNDNYZ0dPN2Q0OVVxcGVx?=
 =?utf-8?B?RXZzOG5KZG10QnNLVkc4blBiUGdBMktyV2MrTnBMTW1JM2c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZjV2bFVGRldycmI2eHk5NnJEb0p4Vy9sZTYyVGJVZE42c1dwRWRFemx0YlVm?=
 =?utf-8?B?bHFnbCt6RmRmNTluaTl5ODhsTUd1VlQ0MGZwRlE0eSt4YVJUZzh5Z0FLdysw?=
 =?utf-8?B?ODlpcTdndlZpak5HQ1BVbysvNktRemR3ck01aHpwY2VZOUdROXYvcjdsRG5Y?=
 =?utf-8?B?RnNxTjZsaERyck8xekNNYmJkNWoveWtMRmVDTDJJcHdhV1lSNzRuOC96MGk4?=
 =?utf-8?B?VERyTnlZZm9RRVhLeTFwY0tRK0JTL2VhM05pSXVkNXR1N2YreHN6M29uam0z?=
 =?utf-8?B?RmxDQU5HK1FHUU1pSCtxWThINzVZUUkzcHBkRk9zTEI2ci9iNUFlaGFnSGpX?=
 =?utf-8?B?dS9ZdXVrRHpISG9saThiUjlTd01LMm1XNnJGQWY0R3lCckdXcEZSQVVONzVk?=
 =?utf-8?B?TU9Qa2Q2clB5aXRYS05YREd3VHF4S1c1M0tEQ1VkSTRMSGNEQmtzTFNUQVJt?=
 =?utf-8?B?ZXZVQ01BSEdHRnZPTUxhOG83c0I2ZjRySU1TRFZndDZXckdhRTJZZC8wSSt3?=
 =?utf-8?B?KzNOMFZ3cTBHSXFLd2pNNzA0S1NtMTZBK0dReHdhSEw0ajFSUStVVjUwYWRS?=
 =?utf-8?B?cGJ3MHJwanZPQkVRdVZ3TDFLZVV2emJUbFQ2WWdsYlA0REFWZ1VRRk9DU05r?=
 =?utf-8?B?eElXa2FSUU10VVVaak40dGR4bGVLYkxvY1Z0UW45ZG96VGQra0VHZldqd0ti?=
 =?utf-8?B?WkxDeVdWUXBaUEU2dHRveGhQRVk3SEJQZ25MODJaczkzd2NEOStkS3o3czhh?=
 =?utf-8?B?NEcwa2wzd2Nra1VlNGhaMEVrWjk4MEQ0bXNwM2xQK0Z2VU9PS1VWSndNckV3?=
 =?utf-8?B?eXF2MVdmZzlSSDlWUVFBUktwWDVsVDNMRGF3LzNiUFdyNkx3NVYxNVhrS1Vq?=
 =?utf-8?B?VHNVSUdZSXlyY29QR21XbzQwSkNKanBCT0lid2lDbUtWb2lDb1o5bnVrNHhZ?=
 =?utf-8?B?MlV6ZGRQdG9RcDVSdC9hVE5Sblp6dWlDSGlWbG54T2VKbzRvZi84Z01tV1BK?=
 =?utf-8?B?dlRGVVVuTUNpZ0VKN3pad1huMXFDY3pyaE5OTnJpaGNjMWdyWEFsZFUyRGJY?=
 =?utf-8?B?SWh5UXdWRURqcEh2aDhTTXRaYWtjT21TTm5xV0JobEVWOEpRTDNzMWRSeHhr?=
 =?utf-8?B?azdSZFdJbC82ZmVEcnFoeXMxZHNQZ1MzYWJOK3N1MXBRdTlPdWVkZ3lpSDhz?=
 =?utf-8?B?cGlZc0ZGblZrdGRxcG9xYjBjQXpZVkZQYzF6NUZvMWNkUGFaYVd3blBWdS9T?=
 =?utf-8?B?bEdFWWxmSnptR0NZM3E2VFhmaFFJYWtLUTJqKzVQVEYxd05Mck02Ujh1Y2o1?=
 =?utf-8?B?YnhwdU5RTXV0Sk45SGFKazh3enlicHZLdVVObEdzTUF3c0xJWTZnMnBtWFlp?=
 =?utf-8?B?TmV3dWw4b0x5Syt2ZWpuMXNoaHdoQWF2WDNYOUp2V0lRSXMvMC85K3ZBT2FF?=
 =?utf-8?B?NDFzOEdRSEhhbkFSNXY3Nkx4OEk3RVBVRWxGblpaaGg1S1hLL0hTWi9heXFL?=
 =?utf-8?B?TWg0cFQzQVM4UmV5L1RnTTZweERyU3lDK1IvL1Npd21tc0RvaXJMeVc5Kzha?=
 =?utf-8?B?OXZZK1IwMlE2ZE40WmlNa3FxeVZzTzYrb0hmd3JFTjQyczR3SU9PYlhFU01s?=
 =?utf-8?B?bWcwWEQzUmZUY2VjMnZTSWh0RUlOZ1V2ZkRWUFhZeVhYVVF0TmNUMnp6K09y?=
 =?utf-8?B?aWVSek56K3hhV2c2cnA4S3VRR1BzQUt1WUR5dGlpU1BBbzUwZHpaenNaQ0o2?=
 =?utf-8?B?VFFxWXVxZk5Vcm1aL25INUIxY1kvRW1sTU4xWlFBdWlzTGlySVJZNEh3UWdE?=
 =?utf-8?B?dWcrKzdhbS9ZMVNRdFVUeDFTQURCUC9zNzNUY3dkWDV4SUo1NkhqVXZpT1Aw?=
 =?utf-8?B?RTU3R1p2QmIzWVNkZ25ZUmx3WnlEbzhFSjhZWWZuYkFibDZnNTdPSG85UUhr?=
 =?utf-8?B?NnhCb1VQUE9Hekl0MExiZHhUalp2dW55TVdHRWt4UjVrbnUrN3ZVVWVkTkNN?=
 =?utf-8?B?UkZGM1lEaXJzWktvd3dMOThaZlFicDUydWNDM3IvWERtaVREcU1xalJHa0hL?=
 =?utf-8?B?NEJmajhaTkJrZmpDSkFsVUtNRmkra01BVlgzRmtwajVKTER3anhjRmRCcWJw?=
 =?utf-8?Q?E8pfHMUqgYCPxqYU3fxi7zufo?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <871ECEE3BC827A4D89E3936F7BDC116B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pjZhq7ns+xwut5pnSuegIGEgGjsAFxUQrvGJjKTLxVtCAcsSWtFF40aMGqhEChX/uUj/tojvNQjB1GG3aH4iKCN3RHFF2mXuqD6iJKWXZF6QScJ89REFPpWGv13BclUrVUS6mrbXfFwQYs3cT7lSwf7Jxkc9QQvq9DeOcMx3qrZL2omX5kAxwV75BN2eCoT6qD7BfTaAPdFy5w3ZFAP0MvgK3XUX1qkPbDxV16UW4ZPHLYA/fsHZGMNCH/aJKerFtM2a5RSxdEuEQryWp2rQWgdLDki7oVnF6EsyMvUq8txMU2u8F2fwaU4Kq3f4myCd9FY4ArN9q67g+zujZCibtfA/sXYH/y83eObY6i7nC4UJML2CCViQzpoYEAOv1xedxT4i33wy4UTQrWQOSKzZU+LqKUJdjhOszDPTHhNSR1gUpNXEkVP2bCEFyxweTF9ongYr/cSSD8iRwI7JSn6BFIPQNIxVf0Ap936XHM2VlZifX4klw5BTlZZBeR/x8AZe3swPSX4iiYFybmKUF6vJFcA04BmeaXdXVREHLxKiLB5mnTJKCX6gJiYqxSaIoYikgfwSQ8QUGNipqCLighCGMpu4VXE2Srl0AkZjBLAXbhqJcRnpKQITIaLbLVxbZgj0PGMu8gTkhG94oTgRWw0z7w==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9a513bc-b02b-4e5c-e2e8-08dccd2dda87
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 22:06:40.1400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0SQwwiOpN8rvYuZivdKDOx1wnlHP6vPxknyTeQG+6Nk58/UQeznA8W5/mbvZ9/lAJvE5tPdiQp8E7cWmCrS3Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4049
X-Authority-Analysis: v=2.4 cv=Z9G+H2RA c=1 sm=1 tr=0 ts=66d8d9f8 cx=c_pps a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=nEwiWwFL_bsA:10
 a=qPHU084jO2kA:10 a=COk6AnOGAAAA:8 a=uzYXbue85SnZlLJhpXQA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: DDkb4gNhYH-9tF3_tuQmy8Vqr7w0HWpn
X-Proofpoint-ORIG-GUID: DDkb4gNhYH-9tF3_tuQmy8Vqr7w0HWpn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_20,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 malwarescore=0 mlxscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2409040167

T24gV2VkLCBTZXAgMDQsIDIwMjQsIEFLQVNIIEtVTUFSIHdyb3RlOg0KPiBIaSBUaGluaCwNCj4g
DQo+IE9uIDkvNC8yMDI0IDM6NDEgQU0sIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiBPbiBUdWUs
IFNlcCAwMywgMjAyNCwgQWthc2ggS3VtYXIgd3JvdGU6DQo+ID4gPiBUaGUgY3VycmVudCBsb2dp
YyBpcyByaWdpZCwgc2V0dGluZyBudW1fZmlmb3MgdG8gZml4ZWQgdmFsdWVzOg0KPiA+ID4gDQo+
ID4gPiAzIGZvciBhbnkgbWF4YnVyc3QgZ3JlYXRlciB0aGFuIDEuDQo+ID4gPiB0eF9maWZvX3Jl
c2l6ZV9tYXhfbnVtIGZvciBtYXhidXJzdCBncmVhdGVyIHRoYW4gNi4NCj4gPiA+IEFkZGl0aW9u
YWxseSwgaXQgZGlkIG5vdCBkaWZmZXJlbnRpYXRlIG11Y2ggYmV0d2VlbiBidWxrIGFuZA0KPiA+
ID4gaXNvY2hyb25vdXMgdHJhbnNmZXJzLCBhcHBseWluZyBzaW1pbGFyIGxvZ2ljIHRvIGJvdGgu
DQo+ID4gPiANCj4gPiA+IFRoZSBuZXcgbG9naWMgaXMgbW9yZSBkeW5hbWljIGFuZCB0YWlsb3Jl
ZCB0byB0aGUgc3BlY2lmaWMgbmVlZHMgb2YNCj4gPiA+IGJ1bGsgYW5kIGlzb2Nocm9ub3VzIHRy
YW5zZmVyczoNCj4gPiA+IA0KPiA+ID4gQnVsayBUcmFuc2ZlcnM6IEVuc3VyZXMgdGhhdCBudW1f
Zmlmb3MgaXMgb3B0aW1pemVkIGJ5IGNvbnNpZGVyaW5nDQo+ID4gPiBib3RoIHRoZSBtYXhidXJz
dCB2YWx1ZSBhbmQgdGhlIG1heGltdW0gYWxsb3dlZCBudW1iZXIgb2YgRklGT3MuDQo+ID4gPiAN
Cj4gPiA+IElzb2Nocm9ub3VzIFRyYW5zZmVyczogRW5zdXJlcyB0aGF0IG51bV9maWZvcyBpcyBz
dWZmaWNpZW50IGJ5DQo+ID4gPiBjb25zaWRlcmluZyB0aGUgbWF4YnVyc3QgdmFsdWUgYW5kIHRo
ZSBtYXhpbXVtIHBhY2tldCBtdWx0aXBsaWVyLg0KPiA+ID4gDQo+ID4gPiBUaGlzIGNoYW5nZSBh
aW1zIHRvIG9wdGltaXplIHRoZSBhbGxvY2F0aW9uIG9mIFR4IEZJRk9zIGZvciBib3RoIGJ1bGsN
Cj4gPiA+IGFuZCBpc29jaHJvbm91cyBlbmRwb2ludHMsIHBvdGVudGlhbGx5IGltcHJvdmluZyBk
YXRhIHRyYW5zZmVyDQo+ID4gPiBlZmZpY2llbmN5IGFuZCBvdmVyYWxsIHBlcmZvcm1hbmNlLg0K
PiA+ID4gSXQgYWxzbyBlbmhhbmNlcyBzdXBwb3J0IGZvciBhbGwgdXNlIGNhc2VzLCB3aGljaCBj
YW4gYmUgdHdlYWtlZA0KPiA+ID4gd2l0aCBEVCBwYXJhbWV0ZXJzIGFuZCB0aGUgZW5kcG9pbnTi
gJlzIG1heGJ1cnN0IGFuZCBtYXhwYWNrZXQuDQo+ID4gPiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6
IEFrYXNoIEt1bWFyIDxxdWljX2FrYWt1bUBxdWljaW5jLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4g
Q2hhbmdlcyBmb3IgdjI6DQo+ID4gPiBSZWRlZmluZSBsb2dpYyBmb3IgcmVzaXppbmcgdHggZmlm
b3MuDQo+ID4gPiANCj4gPiA+IENoYW5nZXMgZm9yIHYxOg0KPiA+ID4gQWRkZWQgYWRkaXRpb25h
bCBjb25kaXRpb24gdG8gYWxsb2NhdGUgdHggZmlmbyBmb3IgaHMgaXNvYyBlcHMsDQo+ID4gPiBr
ZWVwaW5nIHRoZSBvdGhlciByZXNpemUgbG9naWMgc2FtZS4NCj4gPiA+IC0tLQ0KPiA+ID4gICBk
cml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIHwgMTUgKysrKysrLS0tLS0tLS0tDQo+ID4gPiAgIDEg
ZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQo+ID4gPiANCj4g
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIGIvZHJpdmVycy91c2Iv
ZHdjMy9nYWRnZXQuYw0KPiA+ID4gaW5kZXggODlmYzY5MGZkZjM0Li40OTgwOWE5MzExMDQgMTAw
NjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ID4gPiArKysgYi9k
cml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ID4gPiBAQCAtNzc4LDE1ICs3NzgsMTIgQEAgc3Rh
dGljIGludCBkd2MzX2dhZGdldF9yZXNpemVfdHhfZmlmb3Moc3RydWN0IGR3YzNfZXAgKmRlcCkN
Cj4gPiA+ICAgCXJhbTFfZGVwdGggPSBEV0MzX1JBTTFfREVQVEgoZHdjLT5od3BhcmFtcy5od3Bh
cmFtczcpOw0KPiA+ID4gLQlpZiAoKGRlcC0+ZW5kcG9pbnQubWF4YnVyc3QgPiAxICYmDQo+ID4g
PiAtCSAgICAgdXNiX2VuZHBvaW50X3hmZXJfYnVsayhkZXAtPmVuZHBvaW50LmRlc2MpKSB8fA0K
PiA+ID4gLQkgICAgdXNiX2VuZHBvaW50X3hmZXJfaXNvYyhkZXAtPmVuZHBvaW50LmRlc2MpKQ0K
PiA+ID4gLQkJbnVtX2ZpZm9zID0gMzsNCj4gPiA+IC0NCj4gPiA+IC0JaWYgKGRlcC0+ZW5kcG9p
bnQubWF4YnVyc3QgPiA2ICYmDQo+ID4gPiAtCSAgICAodXNiX2VuZHBvaW50X3hmZXJfYnVsayhk
ZXAtPmVuZHBvaW50LmRlc2MpIHx8DQo+ID4gPiAtCSAgICAgdXNiX2VuZHBvaW50X3hmZXJfaXNv
YyhkZXAtPmVuZHBvaW50LmRlc2MpKSAmJiBEV0MzX0lQX0lTKERXQzMxKSkNCj4gPiA+IC0JCW51
bV9maWZvcyA9IGR3Yy0+dHhfZmlmb19yZXNpemVfbWF4X251bTsNCj4gPiA+ICsJaWYgKHVzYl9l
bmRwb2ludF94ZmVyX2J1bGsoZGVwLT5lbmRwb2ludC5kZXNjKSkNCj4gPiA+ICsJCW51bV9maWZv
cyA9IG1pbl90KHVuc2lnbmVkIGludCwgZGVwLT5lbmRwb2ludC5tYXhidXJzdCArIDEsDQo+ID4g
PiArCQkJCSAgZHdjLT50eF9maWZvX3Jlc2l6ZV9tYXhfbnVtKTsNCj4gPiA+ICsJaWYgKHVzYl9l
bmRwb2ludF94ZmVyX2lzb2MoZGVwLT5lbmRwb2ludC5kZXNjKSkNCj4gPiA+ICsJCW51bV9maWZv
cyA9IG1heF90KHVuc2lnbmVkIGludCwgZGVwLT5lbmRwb2ludC5tYXhidXJzdCwNCj4gPiA+ICsJ
CQkJICB1c2JfZW5kcG9pbnRfbWF4cF9tdWx0KGRlcC0+ZW5kcG9pbnQuZGVzYykpOw0KPiA+IE5v
LiBEb24ndCBtaXggdXNiX2VuZHBvaW50X21heHBfbXVsdCB3aXRoIG1heGJ1cnN0IGxpa2UgdGhp
cy4gQ2hlY2sgYmFzZQ0KPiA+IG9uIG9wZXJhdGluZyBzcGVlZC4gQWxzbywgbm93IHlvdSdyZSBp
Z25vcmluZyB0eF9maWZvX3Jlc2l6ZV9tYXhfbnVtIGZvcg0KPiA+IGlzb2MuDQo+IFN1cmUgd2ls
bCBhZGQgc2VwYXJhdGUgY2hlY2sgYmFzZWQgb24gc3BlZWQuDQo+IA0KPiBXZSBoYXZlIHRvIHN1
cHBvcnQgdGhyZWUgdmVyc2lvbnMgb2YgQ0FNIHN1cHBvcnQgdGhyb3VnaCBzYW1lIGR0IGFuZCBp
bWFnZQ0KPiBTUy9TUysgY2FwYWJsZSBjYW0gd2hpY2ggbmVlZHMgMTBrIGZpZm8NCj4gSFMgY2Ft
cyB3aGljaCBuZWVkcyAzSw0KPiBtdWx0aSBVVkMgY2FtcyB3aGljaCBuZWVkcyAxayBhbmQgMmsg
Zmlmbw0KPiANCj4gUHV0dGluZyBhbnkgZGVwZW5kZW5jeSB3aXRoIHR4X2ZpZm9fcmVzaXplX21h
eF9udW0sIHdlIGNhbid0IGFjaGlldmUgMWsgYW5kDQo+IDEwSywNCg0KVGhhdCBkb2Vzbid0IG1h
a2Ugc2Vuc2UuIFRoZSB0eF9maWZvX3Jlc2l6ZV9tYXhfbnVtIGlzIGEgY29uZmlndXJhYmxlDQpj
b25zdHJhaW50IHRocm91Z2ggZGV2aWNldHJlZSBwcm9wZXJ0eS4gSG93IGNhbiBpdCBub3Qgd29y
az8NCg0KPiBpdCBoYXMgdG8gYmUgZGVjaWRlZCBieSBtYXhidXJzdHMgaXRzZWxmIHdoaWNoIHVz
ZXIgY2FuIGNvbmZpZ3VyZS4NCj4gQWxsIHV2YyBnYWRnZXQgYXBwbGljYXRpb25zIHN1cHBvcnRz
IGNvbmZpZ3VyYWJsZSBtYXhidXJzdCB3aGljaCB0aGV5IHVzZQ0KPiB3aGlsZSBvcGVuaW5nLA0K
PiBzbyBpdCBzaG91bGQgYmUgYmV0dGVyIGZvciBpc29jIGVwcyB0byBkZWNpZGUgZmlmbyBiYXNl
ZCBvbiBtYXhidXJzdHMuDQo+IA0KDQpXZSBzaG91bGQgbm90IGp1c3QgbG9vayBhdCBtYXhidXJz
dC4gSXQncyBvbmx5IGFwcGxpY2FibGUgdG8gdXNiMw0Kc3BlZWRzLiBIb3cgdGhlIGZ1bmN0aW9u
IGRyaXZlciBjb25maWd1cmVzIG1heHBfbXVsdCogdnMgbWF4YnVyc3RzIGlzDQppbmRlcGVuZGVu
dC4gU28gbGV0J3Mga2VlcCB0aGUgY2hlY2sgc2VwYXJhdGUgYmFzZSBvbiBzcGVlZCBmb3IgaXNv
Yy4NCg0KVGhhbmtzLA0KVGhpbmgNCg0KWypdIExldCdzIHJlZmVyIHRoZSBtb3V0aGZ1bCAiYWRk
aXRpb25hbCB0cmFuc2FjdGlvbiBvcHBvcnR1bml0aWVzIiBhcw0KbWF4cF9tdWx0Lg==

