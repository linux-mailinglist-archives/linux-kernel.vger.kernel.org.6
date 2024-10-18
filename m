Return-Path: <linux-kernel+bounces-372557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F709A4A49
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 01:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB5C9283827
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 23:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8265F191F68;
	Fri, 18 Oct 2024 23:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="brA58EhT";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="cGUIfY3m";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="wKyXhebh"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C486D20E33E;
	Fri, 18 Oct 2024 23:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729295452; cv=fail; b=hDTVuwNSvdIlmgk+8hQ+kNQMcFmVlU0896rc4/TRTAnqeZ7kKb2Z0Nr3DHnlbVpTb5KdOHDFOjjbgmch28NWBuw4ys/eaO6sCfaYFtNbBxZWxhaDUHYswWzBg1lj1PTq3phWLVcJ1vYo7lP4QaYCnGj399R7oHWipxjcJwn8230=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729295452; c=relaxed/simple;
	bh=+fd0RZQLrWn9d0Xzt1eYa2av3PAD4TMfcAeHBZL8NRc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kmBgEf0UJJwNVZGsE0AIZ7MXLyjz8Cp49K2JQhMeFyUgIwAK7T3uwQU5yIi+4H9aQYFHnXtNlClj/Dcohk1PPX/fpLKVvxclUV5uXo3EHtH8uBlbg/Lf2r7D/awGAONOHoBIei6KvQ7IrPsYPb6vqlZCxZ0P+2pg7mhz2UTkwAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=brA58EhT; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=cGUIfY3m; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=wKyXhebh reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49ILR4oX023266;
	Fri, 18 Oct 2024 16:50:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=+fd0RZQLrWn9d0Xzt1eYa2av3PAD4TMfcAeHBZL8NRc=; b=
	brA58EhTjAJJPI5G24gG/oYqS1NTjyhu7TL2shf2AmLlP/38nCY0hDUrxlRogDm9
	0YM7eBYXtUxSzSveZXnoZzZ9mGOy6DCle0P9HIozgO4DSdAzkybzGW0goVtmKEeG
	vOKQSdF0iZnrWdUiIHGK629A94knCFJH38v0qRZspsgplLkuyuesX0UK7GA2/pDX
	s7LibLddVyoY48JuTN6zfJZgLsDSGQKB4EpnBz50cR+/+AgjEZAmn7R4SF3ab6AC
	dtWeJN476G2VojtWfREzDZUBiB7WQLizqC9SusrlOea0Ks444OzZGlhWuO5v9++1
	5hdmcePcUGLkGDxaYSo3Vg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 42b6xnr1jm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 16:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1729295432; bh=+fd0RZQLrWn9d0Xzt1eYa2av3PAD4TMfcAeHBZL8NRc=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=cGUIfY3m3Eq2PR6iYyKDvUzBNNMXxEitiNT392zDb0o+bXfZHX9JyeIez396myVoh
	 CF7kK+GZv16CO8fDBU2LjmyOuH1mFpHXvigy8lrD7RvdTj+aTBi6BqwTeu6vmD3UfQ
	 nFKD/j22ETi8dpR2VYXgdi/wYKeAt1rOhdqi/VYspioZt3bNUuEH/TikBmbaEAPiGe
	 kXQ0eSB8HgMkixVwvnKWy3eaCe3VTijI7j4YeLFk8NlkSaN0e52f9UblAaHsNOZa9I
	 jg1a2NyyBQQuS47zK1ByHzUOj8WkUf75Ptv9o6hpOn3TvFgd7IriMcrdX+7XzLxviT
	 /wY/BBlrXAWtQ==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 2A4CA40136;
	Fri, 18 Oct 2024 23:50:32 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id C4233A00CD;
	Fri, 18 Oct 2024 23:50:30 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=wKyXhebh;
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 685FF40346;
	Fri, 18 Oct 2024 23:50:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QqsvbjOlrkLWpKKMPPvLdkKwuUm5BS3foHGQLjVxIHHX/vlF9Fvh5GtWd9JGsm20edpeKT+QLRe8PHw1eUL5KIvB9HEbTovPsSkNXMAVGRD9MNpMkyNxioxWPg+bM8E8VV88VvQHizKUgQV09crluVDTA8l0C7hQMhEr8vOmYXdq9UcyVwixwYcdI/8t47waxLpFbJna/zbo3RJEU6ed/Y2j2QYKtcWtr0npFg2sFyUkoLhEZ4YiOw+XnTsACtBPbUtel7zQjblAPUOq8KD3yFbpc5FsSAfxtZeyPMX9pFiWzzsRlzUJaP/RqVEeKMGfq5R8am43HrjTYcwb4a2S4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+fd0RZQLrWn9d0Xzt1eYa2av3PAD4TMfcAeHBZL8NRc=;
 b=pGh/ZSp/hrSGGXOFQvo8OELHX6dCaEJs5Qc3vIsqq1gpl8dPu/xaaMO6PijFfPNYGDzPAiJ4jLw6vqHwlm6zdKN64PlqSq+0/1W67rVUlWbwM00r/1oFIeXqb4Ei1lFmp1vYPTmu86fTaQxGhSFBts9QRZ7prAEYQTBv/Iw+DsvBDdjMlvzfLbhbXdg73lt5We1dEK+AkVkL9IWsxgM5wbcPFqtziE+gsJvnR4sQ+XQQ31ljeoletBw7vIrl7AYCmRoY4In+rpkdrYjdGBBoNrt1IelqGrrLEUO+azZiK7x7UajccI1q65Ne7VnfLrJEtdrnEyWKa2LbpaK6oE/Xlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fd0RZQLrWn9d0Xzt1eYa2av3PAD4TMfcAeHBZL8NRc=;
 b=wKyXhebhNEfv94dIoseyb3+Ehl4SGPUCnx/NHj7KHl4vq5p/6qdq27W72DF13NmU/J7JbUggwCXpR45ViXkY9xvQ6j1RAqNHdXtAJLvbtrY3W132hq2KGmGgXGOPHNhFB53P17LOnsB8EPAprK4JzTTH/hrXLHwRwCoPdLNH6oI=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.24; Fri, 18 Oct
 2024 23:50:24 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 23:50:24 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Akash Kumar <quic_akakum@quicinc.com>
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
Subject: Re: [PATCH v7] usb: dwc3: gadget: Refine the logic for resizing Tx
 FIFOs
Thread-Topic: [PATCH v7] usb: dwc3: gadget: Refine the logic for resizing Tx
 FIFOs
Thread-Index: AQHbIGAWhwKuuG0K8UO0/yW8vmu3qrKNMDEA
Date: Fri, 18 Oct 2024 23:50:24 +0000
Message-ID: <20241018235012.ylaxxyj5zd5j2nbk@synopsys.com>
References: <20241017064423.7056-1-quic_akakum@quicinc.com>
In-Reply-To: <20241017064423.7056-1-quic_akakum@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DS0PR12MB8245:EE_
x-ms-office365-filtering-correlation-id: 9148c734-564b-4f02-06c2-08dcefcfa288
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aHdFeWNxWjE1RHp6RS9hYnVrVlFPd0N2cDhsc0F4RUpReEFqelkrVUlsWjFY?=
 =?utf-8?B?ZnB1M1Q3RTZJRm5ERnN4ektYeVJ5Wit6Q0EvRCt3ekZIdkRWbnJEbWQ2bzA3?=
 =?utf-8?B?Yldha3FBcy9GekVtQU9oVDFvZGhJcThhdk9jTGdyTmpiQkQ1NGxxK0l0YlNU?=
 =?utf-8?B?SUNCTFhYTk5Odnp1YTgwZ1RES3FNVkdiS3ZxWElYQ0tGSHorcVNRYm5qOTBC?=
 =?utf-8?B?dXpIUXpQTVVEUE1MeTN3ZHcyYXJ3TzR1a3RkRFI0VGFUdjloMEkxditWbGVG?=
 =?utf-8?B?bCtSdnNYbnJ5K3VqS1N6MjVjUkYyWGMwVml6dHcwa1cyUXhnUXVUaFkvMzY2?=
 =?utf-8?B?WXZQdDRUdGhCZy9BcWM1UzdPN2VGL3hmdUxwVGo0K09JTEhGYWk4OGVhT3Rr?=
 =?utf-8?B?NUNBU3dWRTNRbXFER1VCWk4vT01KLzFjK1NrZnBBNnBxQlpHL1AxdDlJT29y?=
 =?utf-8?B?dlpRYldJQkd2aHhrcFp0V2ZaNG9McmdJeVVNZm1VZ3RmMkI1YzZ1QSsvcllC?=
 =?utf-8?B?dFVydU5aZzlQMTZsVmd6YnhWd2RpV1haTVdqTlVyRWtHV0xJa1pSVnB1TTZs?=
 =?utf-8?B?bGx6QXBBcmhnNE1nZXJsUnVXbG9sRDNDN0c2S21qTDRwNSt2eUpaQjNzYUJ5?=
 =?utf-8?B?K3JmcjBDaHFQZWx1UHlKZjVqTW96RmwxN3JDM2o0dTBreUhnSXU4T3pNSFA5?=
 =?utf-8?B?RzBJOHc2b2pRY1AxNThEVFdQRFJva2VycG5UVkFUL0c2UGZGYVFPUDdmcWVR?=
 =?utf-8?B?UWlUZ1NoNWVSRzJHdlZtS293QThJT1I1ai9lVWdpK0RGRkNFbHBKMVVYb3c4?=
 =?utf-8?B?UGppSHNuMlU4L3lPZHU1Tjh6NGVuL3kvckN2Q0VLVmdaa2YydlFzZVBYclhB?=
 =?utf-8?B?UlMrMkJLUkZMZ3BVSmthSkJQTkVIMUdwTU5RN3RCZ2V4Mm5nWWpBQi8vSTht?=
 =?utf-8?B?dWNtbUFYVkQyWjY2c0hiK0NYcERCaG9ITWFYZ2NyZ1Z4R1ZhVjVSb0pRa3Vl?=
 =?utf-8?B?dUtBZ3R5K3h2U09VY3puOGhGV0Z3WjhXZHozZTcrYTZKRG1rVlBHQndNSmNu?=
 =?utf-8?B?TWVmOFNTVndrcVhFYzlmNExQK2lNVXNLRkhlZzF6b2hCVU5tRnQxM01pRG02?=
 =?utf-8?B?cloxU3JEM3lEMEJURW5OUklVT2xMVUI2NHBRTDY4VDNtNTM3Qm1iL1oxM3l2?=
 =?utf-8?B?YittQWJqYXc2WGhFeXVUUzJlWGxlbHk5OXdrTzk5RkR1Z2dMQlYzdnFOSkJ2?=
 =?utf-8?B?VFFpM3cxUzFDSytrbzJML3UySFJ5Q0w2bVNLYUZubGNEUzVBRHdZbFdHL0dk?=
 =?utf-8?B?NmljWHdSQ3hNUG9BdGJ0eGFYTzZEdEs3L3ZrNW0yd3pjTHJuMk1HZ0tqVkZL?=
 =?utf-8?B?QlhPV3pqUElGNmZLakFVZFBLTXpDbHdsMGtHVlJCQUlOeE5aT1NDZG4xbjJM?=
 =?utf-8?B?KzcrY0dGekZ2cVpjSkQyNno5V2tqcVRad0RBekpnTTBLVkxKQno4bjl5WkN4?=
 =?utf-8?B?MFY3T0Z1VmlxdDd4NDUyRi9HK1NoZDZQRVppRjF6S3BqaUZJTmluYlFmcW1h?=
 =?utf-8?B?MW9kRTdqQjNoTG90SXpucUtRZGoxOHBkOG9kTDBMbElOcGI2VmoyZTA1Y1g2?=
 =?utf-8?B?QzBucEM0aEcwSDhHRkYxVWtSV2tRdjhKeEFOTjNTMUtkUmZvcFRoV2RVMGRQ?=
 =?utf-8?B?bUhIcTN3bjJ6Rk5KTWMwY0JoNWlSNVNjYmR4VitRZDQ3TGVzYVdsOWEwcWJC?=
 =?utf-8?B?VE1vNXhWc2RleVFTMlkyZzJaQXZ5dEplSWNlUUlBM0FyMnNJN1ZFL2h1anor?=
 =?utf-8?Q?gI/qcf522FPoqLOk9kxCA9wcgoRgJRoL7UnTs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RmlyN1J0TnlsSlQ4Qlowb3J3Q1ZpNkxBajhhNlRtM3JhWUU3WEtPREN6LzJI?=
 =?utf-8?B?YnNpNjN5Tlh5RWhqTUFSSWV4Rm1zU2Q5MTFuRHlZVVhvYms5bXo5R0p1WDJC?=
 =?utf-8?B?SHJ2WUhncTg4bkpBcFVHM1JsbStlV241NW9vZTlnaEI2aWw2MlNWcVhXTzBt?=
 =?utf-8?B?cGdYcWl5b0ZQZWkyYnZ2R1Z0ZXlZcnoxS3pqYTZqU3dvUWxoWnpUM1JLaXpO?=
 =?utf-8?B?QTkwZ1VvM3Q2bUdHd3R6c3F3cjRZeXVmWEVPN1grb3BVTmFwK2ZWNXRaOXY1?=
 =?utf-8?B?dWsycmZCSFB1Rit0UGdaWmo4bitpdWh4RWFhUVlwWWFTdnViYVlpYmwrOXo1?=
 =?utf-8?B?SGhvaTV6VldJNW5xNkRPK3VVRENhWjNnaXVYR0JlbnJWZHZjM3lORWk0eUl5?=
 =?utf-8?B?azNEakIwblR2NTNkN25KSFQyZWFINjJzRmJnUHdaMDN2bU5XQ1dQWjVzNXd5?=
 =?utf-8?B?dllXekZsNlFNUFl5VU03MThYenlnaWpxeTFiZHBqZExxUmFhUG5BOGJ2SFcz?=
 =?utf-8?B?Z3dQVjVSSW9RNnNqY1p4TDdsMWNGNmVzVjh4ZFV5Q1gveG51WjRqZ2VBcWJ3?=
 =?utf-8?B?S0l5MVJqa0YrZHlRajhEd1oxZVJqSHFKZXpCSFBIZDJTRGFEWnFHVkMyR1JH?=
 =?utf-8?B?aittcDdpRTlha2xxTk1rVVpNWTdGLy9Fd0wzSkQ2MzdXODFsTTZlUHJBT0pm?=
 =?utf-8?B?MWx2WVBjT0F3ZVpicHhWWW95WElIcXZ5aXFHVmozaUs4bjJWdkYwVzhQTVhk?=
 =?utf-8?B?eGhLbWx6U1lZMXRLUGlQU3llRHJ6U1MzVEZoYlhhc0t6RUU4TCtiNzUrSEhR?=
 =?utf-8?B?ejh4RlRmM3lMWVFPVEpNWDJxREdnNzRWejVLaGt2dXJFYU1kK09sMU9WdW55?=
 =?utf-8?B?WS80cTkyZmVnbXJiZnE3OXlvZlhGQjdnK0FHblFDTFlKWENIbWtwNDJibENi?=
 =?utf-8?B?YjhLZzJRZlBVNkJDa0dYUkdvaElwNEt2THFmMjZ5MWlLb0N2TFRIS21OSmU1?=
 =?utf-8?B?elB3REhZcGhMV0IwYVZRRklWaDlTbFF1VXZzVEk3eVBZd0RLdGtNZFNna2Rv?=
 =?utf-8?B?KzJEcjlBTjJuTkJ0MCsyNis0QWM5YUF0dVhtNGVFdktGMi80SG1ERVhrTGFO?=
 =?utf-8?B?VlVZLzJNTksxOS9JNFJwTDVSYWp2K0lHWkhVK0ZjdWVJYmdib1k4RXhBUWg3?=
 =?utf-8?B?TnUxeFpITTUrc050cmZWeUg3VTZ2cVppSVVxSXVOUG5tRkNvaEpaR2hsenYr?=
 =?utf-8?B?V3V2bHE4b0VWUVdtU3BWZHVFNFhDUUlpaGJxQWorZWt2TmlDWHpQdnpiakRz?=
 =?utf-8?B?TEdycmdFSWNMK09YZmpSc0JsMExCQU9Xd0EvWndsTzA0a0tzWnBpVEJIMEpo?=
 =?utf-8?B?alJZVXJZbit3SmEwSGJrdFoweURnNCtpTUg3OFdRNFdGc1VkQVlRdDJSbTBi?=
 =?utf-8?B?T04vUlNQTG1QNnowUkM2RzNTeXZUL0U2RGhYMm5SQ2xYV1ZBOEtYbnFoOTlu?=
 =?utf-8?B?QjVMbDh5NEZxNkdmdmtlbWJCN0FrYjlFbXNuRUtaT1hjbFQrWW13KzQ1RXhy?=
 =?utf-8?B?SnhjYTN4aDhCazJtenRlQ0JQNzhvZjZPTjlkTmM4QitpVVdsTkFySzhwbURS?=
 =?utf-8?B?R09ncFdlZU5zYWVkOXZlWk5EN3lzWHI5d2l5b3ZDWEdaaVF3M2tabnZBSFl4?=
 =?utf-8?B?U1MrZXBFN0tSZHNGSTZaemdrRnR1WmNkU0VKOE5JQXpIRGdDSjM1cTJvbVVN?=
 =?utf-8?B?YVdpUGJ2Qm5KNUU2cXJaTFRkSXhqblM4S250SGZXNU96OUc5aDlTcmlPK0FU?=
 =?utf-8?B?dXlOdWxWSlZHaEtVUDFWS0hMNGhib2hDdmpYTFhqNDhBdU1tSlRva3R5THEz?=
 =?utf-8?B?ZTBDdXdlVTVaWXZSNktSc2Z1U3p3dFNyRzYxTzVZYkdNalVLb2tpSXhuL2Q1?=
 =?utf-8?B?NnpiZWs3NGZJSlI5L3pTSVRDdU5YVkJxSkZCby9GWDcxWGphZVE2WmZDbWF1?=
 =?utf-8?B?dWNBVjV4MmlRRW1pMkZUWGJ5dFpIKzQ2Y0J0cEliWUtqR2JtalZ6NS9CNUFV?=
 =?utf-8?B?aWhOaWVHV2lwSVUxUERTQXpsN1hDRWpGQXF6WjI0QWZKS0lwQmZjUlJHWkNt?=
 =?utf-8?Q?fpdEatpmGgUSXqOXBMpg32lAg?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF4A8FD4F15F1D45803CF1288D3D374A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	k1xN7DznF4xSbfxZ+uCch+rGO2I4O5yTmVyaKvbLUJiGWQVAlSZwjnnM1D90b8UwEtSnpQ4VcsWk0RjWxR1anS+DDNLiHOlbuUnNi9LQSSAtjWBNpFXSPY4lx1EGrZJo3D90Mypgz6PjZcFVUduXrwEabff+MEDILN3l52/RH5M+THNvdTu0nCaP/qazCyyCjGae68QbB3xvCopIxBnWWWZSaoQnGSpAhjjoiFMJPDL0c39MhpSxcT78GLc52QZMMe1lFMGust5wlin5NBS65AzpcfnfpqQo6rMIa6eGEchuhbN5V9DO0MgUZ+1WesKqXau/mrdneLoDleVxbKFT1RfnU9HR6/Kspb74K44OV4HSARFmrajxGmfQzKG8qRLprVhVlMcrf9jlDIEx5FyffOg5pzLSIXYMR6c/voOQqHgQR6/XWqGufPlkknv1T/XnkfP3JeOcqv3qGQ++S/JxGswQPpcKsUBPhhZIDoOJI/qYrbrbGn4E0vnPOCEEkwzhWm4/BDab7Bz4mpxDcBakkAwSeVOlwEg3gE3iHMGCKKONT/4Tw84QNKtTeL/BdGzcAnmQ8khFC8TEMzl25qsZbqqjG2X3Z68GbQVC81/FgGI/OhJGnafkHGIwpwb5xmICb0No4ghfw5cB218k3uhpPA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9148c734-564b-4f02-06c2-08dcefcfa288
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2024 23:50:24.3515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZXSMHlRaXvuR5kslTaSqys9v5h5b0jF7j2PXBz961HsqK+5DaV+fumHcKRWKVA/UnE6Lwfy2vijQKEVxxJuoIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8245
X-Proofpoint-ORIG-GUID: zQAxHG7HvzvKusgQdB8l09HHxfhSeVfp
X-Authority-Analysis: v=2.4 cv=MrUA6Hae c=1 sm=1 tr=0 ts=6712f449 cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=nEwiWwFL_bsA:10
 a=qPHU084jO2kA:10 a=COk6AnOGAAAA:8 a=jIQo8A4GAAAA:8 a=Fw8nr6mc_DSmYoaB-Y0A:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22 a=Lf5xNeLK5dgiOs8hzIjU:22
X-Proofpoint-GUID: zQAxHG7HvzvKusgQdB8l09HHxfhSeVfp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410180153

T24gVGh1LCBPY3QgMTcsIDIwMjQsIEFrYXNoIEt1bWFyIHdyb3RlOg0KPiBUaGUgY3VycmVudCBs
b2dpYyBpcyByaWdpZCwgc2V0dGluZyBudW1fZmlmb3MgdG8gZml4ZWQgdmFsdWVzLg0KPiAzIGZv
ciBhbnkgbWF4YnVyc3QgZ3JlYXRlciB0aGFuIDEuDQo+IHR4X2ZpZm9fcmVzaXplX21heF9udW0g
Zm9yIG1heGJ1cnN0IGdyZWF0ZXIgdGhhbiA2Lg0KPiBBZGRpdGlvbmFsbHksIGl0IGRpZCBub3Qg
ZGlmZmVyZW50aWF0ZSBtdWNoIGJldHdlZW4gYnVsayBhbmQNCj4gaXNvY2hyb25vdXMgdHJhbnNm
ZXJzLCBhcHBseWluZyBzaW1pbGFyIGxvZ2ljIHRvIGJvdGguDQo+IA0KPiBUaGUgdXBkYXRlZCBs
b2dpYyBpcyBtb3JlIGZsZXhpYmxlIGFuZCBzcGVjaWZpY2FsbHkgZGVzaWduZWQgdG8gbWVldA0K
PiB0aGUgdW5pcXVlIHJlcXVpcmVtZW50cyBvZiBib3RoIGJ1bGsgYW5kIGlzb2Nocm9ub3VzIHRy
YW5zZmVycy4gV2UNCj4gaGF2ZSBtYWRlIGV2ZXJ5IGVmZm9ydCB0byBzYXRpc2Z5IGFsbCBuZWVk
cyBhbmQgcmVxdWlyZW1lbnRzLCB2ZXJpZmllZA0KPiBvbiBvdXIgc3BlY2lmaWMgcGxhdGZvcm0g
YW5kIGFwcGxpY2F0aW9uLg0KPiANCj4gQnVsayBUcmFuc2ZlcnM6IEVuc3VyZXMgdGhhdCBudW1f
Zmlmb3MgaXMgb3B0aW1pemVkIGJ5IGNvbnNpZGVyaW5nIGJvdGgNCj4gdGhlIG1heGJ1cnN0IGFu
ZCBEVCBwcm9wZXJ0eSAidHgtZmlmby1tYXgtbnVtIiBmb3Igc3VwZXIgc3BlZWQgYW5kDQo+IGFi
b3ZlLiBGb3IgaGlnaC1zcGVlZCBhbmQgYmVsb3cgYnVsayBlbmRwb2ludHMsIGEgMksgVHhGSUZP
IGFsbG9jYXRpb24NCj4gaXMgdXNlZCB0byBtZWV0IGVmZmljaWVudCBkYXRhIHRyYW5zZmVyIG5l
ZWRzLCBjb25zaWRlcmluZw0KPiBGSUZPLWNvbnN0cmFpbmVkIHBsYXRmb3Jtcy4NCj4gDQo+IElz
b2Nocm9ub3VzIFRyYW5zZmVyczogRW5zdXJlcyB0aGF0IG51bV9maWZvcyBpcyBzdWZmaWNpZW50
IGJ5DQo+IGNvbnNpZGVyaW5nIHRoZSBtYXhpbXVtIHBhY2tldCBtdWx0aXBsaWVyIGZvciBIUyBh
bmQgYmVsb3cgYW5kIG1heGJ1cnN0DQo+IGZvciBTdXBlci1zcGVlZCBhbmQgYWJvdmUgZXBzLCBh
bG9uZyB3aXRoIGEgY29uc3RyYWludCB3aXRoIHRoZSBEVA0KPiBwcm9wZXJ0eSAidHgtZmlmby1t
YXgtbnVtIi4NCj4gDQo+IFRoaXMgY2hhbmdlIGFpbXMgdG8gb3B0aW1pemUgdGhlIGFsbG9jYXRp
b24gb2YgVHggRklGT3MgZm9yIGJvdGggYnVsaw0KPiBhbmQgaXNvY2hyb25vdXMgZW5kcG9pbnRz
LCBwb3RlbnRpYWxseSBpbXByb3ZpbmcgZGF0YSB0cmFuc2ZlciBlZmZpY2llbmN5DQo+IGFuZCBv
dmVyYWxsIHBlcmZvcm1hbmNlLiBJdCBhbHNvIGVuaGFuY2VzIHN1cHBvcnQgZm9yIGFsbCB1c2Ug
Y2FzZXMsDQo+IHdoaWNoIGNhbiBiZSB0d2Vha2VkIHdpdGggRFQgcGFyYW1ldGVycyBhbmQgdGhl
IGVuZHBvaW504oCZcyBtYXhidXJzdCBhbmQNCj4gbWF4cGFja2V0LiBUaGlzIHN0cnVjdHVyZWQg
YXBwcm9hY2ggZW5zdXJlcyB0aGF0IHRoZSBhcHByb3ByaWF0ZSBudW1iZXINCj4gb2YgRklGT3Mg
aXMgYWxsb2NhdGVkIGJhc2VkIG9uIHRoZSBlbmRwb2ludCB0eXBlIGFuZCBVU0Igc3BlZWQuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBBa2FzaCBLdW1hciA8cXVpY19ha2FrdW1AcXVpY2luYy5jb20+
DQo+IC0tLQ0KPiBDaGFuZ2VzIGZvciB2NzoNCj4gZml4ZWQgaW5kZW50YXRpb25zIGZvciBpZiBj
aGVja3MuDQo+IA0KPiBDaGFuZ2VzIGZvciB2NjoNCj4gVGhlIGNvZGUgaGFzIGJlZW4gcmVmYWN0
b3JlZCB0byByZXBsYWNlIG11bHRpcGxlIGlmIGNoZWNrcyB3aXRoIGENCj4gc3dpdGNoLWNhc2Ug
c3RydWN0dXJlIGJhc2VkIG9uIHRoZSBVU0Igc3BlZWQuIFRoaXMgY2hhbmdlIGltcHJvdmVzDQo+
IHJlYWRhYmlsaXR5IGFuZCBtYWludGFpbmFiaWxpdHkgYnkgY2xlYXJseSBkZWZpbmluZyBiZWhh
dmlvciBmb3INCj4gZGlmZmVyZW50IFVTQiBzcGVlZHMuIFRoaXMgc3RydWN0dXJlZCBhcHByb2Fj
aCBlbnN1cmVzIHRoYXQgdGhlDQo+IGFwcHJvcHJpYXRlIG51bWJlciBvZiBGSUZPcyBpcyBhbGxv
Y2F0ZWQgYmFzZWQgb24gdGhlIGVuZHBvaW50DQo+IHR5cGUgYW5kIFVTQiBzcGVlZC4NCj4gDQo+
IENoYW5nZXMgZm9yIHY1Og0KPiBVcGRhdGUgQ2FsY3VsYXRpb24gZm9yIEhTIGFuZCBiZWxvdyBi
dWxrIGFuZCBpc29jIGVwcyBiYXNlZCBvbg0KPiBzdWdnZXN0aW9uIGFuZCBmaXhlZCBhdCAyayBm
b3IgYnVsayBlcHMgY29uc2lkZXJpbmcgZmlmbyBjb25zdHJhaW5lZA0KPiBwbGF0Zm9ybXMuDQo+
IA0KPiBDaGFuZ2VzIGZvciB2NDoNCj4gVXBkYXRlZCBjb21taXQgbWVzc2FnZSBhcyBwZXIgcmV2
aWV3IGNvbW1lbnRzIHRvIGNsYXJpZnkgdGhhdCBpdCBoYXMNCj4gYmVlbiB0ZXN0ZWQgb24gc3Bl
Y2lmaWMgcGxhdGZvcm1zIG9ubHkgYW5kIHRyaWVkIGJlc3QgdG8gbWF0Y2ggYWxsDQo+IGV4cGVj
dGF0aW9ucy4NCj4gDQo+IENoYW5nZXMgZm9yIHYzOg0KPiBSZWRlZmluZSBsb2dpYyBmb3IgcmVz
aXppbmcgdHggZmlmb3MsYWRkZWQgY2hlY2sgYmFzZWQgb24gIG9wZXJhdGluZw0KPiBzcGVlZCBh
bmQgdXNlZCBtYXhwIGZvciBIUyBhbmQgbWF4YnVyc3QgZm9yIFNTICBhbmQgZGVmaW5lZCBtYXgg
YWxsb2NhdGlvbg0KPiBiYXNlZCBvbiBkdCBwcm9wZXJ0eS4NCj4gDQo+IENoYW5nZXMgZm9yIHYy
Og0KPiBSZWRlZmluZSBsb2dpYyBmb3IgcmVzaXppbmcgdHggZmlmb3MsIGhhbmRsZWQgZmlmbyBi
YXNlZCBvbiAgbWluaW11bSBvZg0KPiBtYXhwIGFuZCBtYXhidXJ0cy4NCj4gDQo+IENoYW5nZXMg
Zm9yIHYxOg0KPiBBZGRlZCBhZGRpdGlvbmFsIGNvbmRpdGlvbiB0byBhbGxvY2F0ZSB0eCBmaWZv
IGZvciBocyBpc29jICBlcHMsIGtlZXBpbmcNCj4gdGhlIG90aGVyIHJlc2l6ZSBsb2dpYyBzYW1l
DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyB8IDMzICsrKysrKysrKysrKysr
KysrKysrKysrKy0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKyks
IDkgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9nYWRn
ZXQuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gaW5kZXggMTAxNzhlNWVkYTVhLi5h
ZjNkNWIyZjdiNjcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4g
KysrIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiBAQCAtNzcxLDE1ICs3NzEsMzAgQEAg
c3RhdGljIGludCBkd2MzX2dhZGdldF9yZXNpemVfdHhfZmlmb3Moc3RydWN0IGR3YzNfZXAgKmRl
cCkNCj4gIA0KPiAgCXJhbTFfZGVwdGggPSBEV0MzX1JBTTFfREVQVEgoZHdjLT5od3BhcmFtcy5o
d3BhcmFtczcpOw0KPiAgDQo+IC0JaWYgKChkZXAtPmVuZHBvaW50Lm1heGJ1cnN0ID4gMSAmJg0K
PiAtCSAgICAgdXNiX2VuZHBvaW50X3hmZXJfYnVsayhkZXAtPmVuZHBvaW50LmRlc2MpKSB8fA0K
PiAtCSAgICB1c2JfZW5kcG9pbnRfeGZlcl9pc29jKGRlcC0+ZW5kcG9pbnQuZGVzYykpDQo+IC0J
CW51bV9maWZvcyA9IDM7DQo+IC0NCj4gLQlpZiAoZGVwLT5lbmRwb2ludC5tYXhidXJzdCA+IDYg
JiYNCj4gLQkgICAgKHVzYl9lbmRwb2ludF94ZmVyX2J1bGsoZGVwLT5lbmRwb2ludC5kZXNjKSB8
fA0KPiAtCSAgICAgdXNiX2VuZHBvaW50X3hmZXJfaXNvYyhkZXAtPmVuZHBvaW50LmRlc2MpKSAm
JiBEV0MzX0lQX0lTKERXQzMxKSkNCj4gLQkJbnVtX2ZpZm9zID0gZHdjLT50eF9maWZvX3Jlc2l6
ZV9tYXhfbnVtOw0KPiArCXN3aXRjaCAoZHdjLT5nYWRnZXQtPnNwZWVkKSB7DQo+ICsJY2FzZSBV
U0JfU1BFRURfU1VQRVJfUExVUzoNCj4gKwljYXNlIFVTQl9TUEVFRF9TVVBFUjoNCj4gKwkJaWYg
KHVzYl9lbmRwb2ludF94ZmVyX2J1bGsoZGVwLT5lbmRwb2ludC5kZXNjKSB8fA0KPiArCQkgICAg
dXNiX2VuZHBvaW50X3hmZXJfaXNvYyhkZXAtPmVuZHBvaW50LmRlc2MpKQ0KPiArCQkJbnVtX2Zp
Zm9zID0gbWluX3QodW5zaWduZWQgaW50LA0KPiArCQkJCQkgIGRlcC0+ZW5kcG9pbnQubWF4YnVy
c3QsDQo+ICsJCQkJCSAgZHdjLT50eF9maWZvX3Jlc2l6ZV9tYXhfbnVtKTsNCj4gKwkJYnJlYWs7
DQo+ICsJY2FzZSBVU0JfU1BFRURfSElHSDoNCj4gKwkJaWYgKHVzYl9lbmRwb2ludF94ZmVyX2lz
b2MoZGVwLT5lbmRwb2ludC5kZXNjKSkgew0KPiArCQkJbnVtX2ZpZm9zID0gbWluX3QodW5zaWdu
ZWQgaW50LA0KPiArCQkJCQkgIHVzYl9lbmRwb2ludF9tYXhwX211bHQoZGVwLT5lbmRwb2ludC5k
ZXNjKSArIDEsDQo+ICsJCQkJCSAgZHdjLT50eF9maWZvX3Jlc2l6ZV9tYXhfbnVtKTsNCj4gKwkJ
CWJyZWFrOw0KPiArCQl9DQo+ICsJCWZhbGx0aHJvdWdoOw0KPiArCWNhc2UgVVNCX1NQRUVEX0ZV
TEw6DQo+ICsJCWlmICh1c2JfZW5kcG9pbnRfeGZlcl9idWxrKGRlcC0+ZW5kcG9pbnQuZGVzYykp
DQo+ICsJCQludW1fZmlmb3MgPSAyOw0KPiArCQlicmVhazsNCj4gKwlkZWZhdWx0Og0KPiArCQli
cmVhazsNCj4gKwl9DQo+ICANCj4gIAkvKiBGSUZPIHNpemUgZm9yIGEgc2luZ2xlIGJ1ZmZlciAq
Lw0KPiAgCWZpZm8gPSBkd2MzX2dhZGdldF9jYWxjX3R4X2ZpZm9fc2l6ZShkd2MsIDEpOw0KPiAt
LSANCj4gMi4xNy4xDQoNCkFja2VkLWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5v
cHN5cy5jb20+DQoNClRoYW5rcywNClRoaW5o

