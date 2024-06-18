Return-Path: <linux-kernel+bounces-220274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B1090DEC3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 23:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16A14B21B51
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 21:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B281891CE;
	Tue, 18 Jun 2024 21:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="v/5d//d6";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="YME3G5Hj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="nuKPX3xq"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E5F186287;
	Tue, 18 Jun 2024 21:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718747657; cv=fail; b=GFb8ea0ZrbEILZBuDmXPRgUU1EGSHDkg7KlLnbbIqLVcHAZrurC9lS2E6hHVXrMUgwAfPRDypw3IeeHjVPAFSBXB1kqK0DFq9zgGonuMz3gCv60uDoTEOOjgMzXtw9jPRL/mTIdr7h438nxXkDBp7nz/Zi2SX1hxfE1Z0Ze0Nfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718747657; c=relaxed/simple;
	bh=Urb0p70Ark8Nb4f4O8BOmzM674rn8V0n/2DDNMUgJFs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DumEIwcqfK3SuR7ceO0pUJHNe6rfPAF7imub8wEgclCteXyzyv0kO7iRu2OeClq9yOb1t0w5W/jjpsGED23A62oq0Exv2B8vX9/3kQNJtBeWvqgejA9nEJYc9xm5lVZaHBBucyzpWYaUbCr/DckhG7Bn7ekbnBeXKI96a6TQVd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=v/5d//d6; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=YME3G5Hj; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=nuKPX3xq reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ILgPvp020284;
	Tue, 18 Jun 2024 14:54:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=Urb0p70Ark8Nb4f4O8BOmzM674rn8V0n/2DDNMUgJFs=; b=
	v/5d//d6qayLk5L3H1O95d4N0xbi3yjbgOuQegyRxyaKssQwjJXZD5UAgFmsaWdC
	/yXuFpS0TIhFBrV0gohCVmG+aAAmbkufb0Jbiuh936nfIqxY4HPP3dm9b3cnU0/r
	q1B0yyrmPjffDgPxDXMJ6DhDOk3uSJ37zM1NCe53VisnsC66KO2Zt78gdmLK/iNp
	4+lV2qg4bdhqxkdifNMcIGLldV6WxQ6JtTzeEWw3HbBSvAC/xDSPuP6Oyqryk1Rs
	1WaHMlevBhoez3sZWp5uvMZJGFF7KLdac/ggRIs0wRHCew0/YG4zzo4628JKFKKE
	bm2i+dTcE8s6u6xc7VlVnA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3yujcur0wh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 14:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1718747648; bh=Urb0p70Ark8Nb4f4O8BOmzM674rn8V0n/2DDNMUgJFs=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=YME3G5Hj860X+OAHm6C9MEneKkhWBunXCSJsilk3UEjWSi36ylu62/LShx1v4UWkI
	 qyFDLlHrK7zW1W6tyZFp1H0teRV1kfnx0WPYtG/hA1VEIdoG3JnPNilmDsoj1iUBll
	 CjZNAcjLXmj3mWsYH7sJ3w0iiBNW4lxwIzvs9low9DFH6HKXfkhITi87erCX4mccfi
	 ULXvjx4s/3GOGmXFVpVkOjcqZqrUia0KnYCbJtWkfLltSz/HgUOrj1Y3md+W2yNdTt
	 aVUKDVfy9fxDIYm6hhwlR8kjBF1i9y7sPIgkW1SzaWwOFsnEQ06zTo0nFwnHgiXnIF
	 yW99iALZoQXrA==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5D2DA40235;
	Tue, 18 Jun 2024 21:54:08 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id DB4EDA007A;
	Tue, 18 Jun 2024 21:54:07 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=nuKPX3xq;
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2043.outbound.protection.outlook.com [104.47.51.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 3722840132;
	Tue, 18 Jun 2024 21:54:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S7Lm3qIc/1rK6h42EwMyueo2oUrMMOlIxlP9QRA0WwAOMrZfuuBFA0kxHFXGxjJxQTZ342Yr5MZC9DsYo8J4G5Szb7nCsVbL/SDu64bicKPCsfhMOSngB+7jLKICUzlJsrjRHSPNE68ElpylIBynXv9VOpdhdRSwQWt/2bf1UozOh721SvOrAfFlSTsL6WWxnNLOhC69T0B9yo9Iqo8ddo2S/po0Th1YR2c6t2Fy09aIUP/GbkExBS2uWAlhMWIMEcwlIYTdMeJlLpCFsApycgp/6Kfd1qN1PDNy95PVPUgtBlink8Zih/ro2mCw85FBtPdFo6XlA5Ces6J0uOkm1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Urb0p70Ark8Nb4f4O8BOmzM674rn8V0n/2DDNMUgJFs=;
 b=C5T2Zrjya2xEUtZ/xNoDQEdHfopmIB2Y9gFmVcxR0jTB1b7klDHEM6DQ0OmFSwO0u2BFum4SmeOzLySkuk//MS8z7ISzlmBY+h8AVtF1ohTIH/WzAyY6TYPB/eaiClnxb+QsbI13+adyWl1ksU64y6ATRXpyxR5Vs7/+zYcHYeyNomdIhtfhMbUDD5luNpG7Xy7E2cHTvY0k8qF+HPS2EyR/wjjrOJ1AVvJwc1/sQ69Au+RUaj9a8qPFx3QRbdD2EJExnoOQOIwl/S3Eclgi6MO5VgwrlrRRxmkUaZ+UGxQvvqbMaCmkNbCvlTYyFAhEEz85Y2APvXllupsn9oOl1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Urb0p70Ark8Nb4f4O8BOmzM674rn8V0n/2DDNMUgJFs=;
 b=nuKPX3xqy+QXkOBuCuWfDrlhAbucbZPoejCoCLxED2uoq5fzaZGr5tEh0g/B6Br6VvN847sykRtZ5pOVvmd+/ukHLVuNWo0WubrFhU0rXZfa28AaX0NeX/NnSocSilCVIWcNb4vylSqK8+m0CGP1f7OsyWfaLOEkNb3iPr6VcAE=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DM4PR12MB5819.namprd12.prod.outlook.com (2603:10b6:8:63::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 21:54:04 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 21:54:03 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Meng Li <Meng.Li@windriver.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "quic_uaggarwa@quicinc.com" <quic_uaggarwa@quicinc.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xu.yang_2@nxp.com" <xu.yang_2@nxp.com>
Subject: Re: [v2 PATCH] usb: dwc3: core: remove lock of otg mode during gadget
 suspend/resume to avoid deadlock
Thread-Topic: [v2 PATCH] usb: dwc3: core: remove lock of otg mode during
 gadget suspend/resume to avoid deadlock
Thread-Index: AQHawS5mXgmtPyyguEiEAyP9uNoV27HOEasA
Date: Tue, 18 Jun 2024 21:54:03 +0000
Message-ID: <20240618215356.hw6ar6guxbhlf5y7@synopsys.com>
References: <20240618031918.2585799-1-Meng.Li@windriver.com>
In-Reply-To: <20240618031918.2585799-1-Meng.Li@windriver.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DM4PR12MB5819:EE_
x-ms-office365-filtering-correlation-id: 6c824628-f64d-444a-4d31-08dc8fe12b51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?MHdqQkR2L2dMRlB0UzhpVm55Qy9QVWlxbStmcWdScm9QdlYzMWhaSGpkR0pD?=
 =?utf-8?B?NC93eUVHVXVLUHlRWndxOEFVS011UEFTRWY0dWtxa3RxdlVab2JtR1V5TkhF?=
 =?utf-8?B?MDNLNTA5d2tmM0pweElsSjg4VDdGQ0lreENMbnZPZVBLOVh5MG55S05hbmF1?=
 =?utf-8?B?RW9OZ2RVNElsTXZPK09wWFA4ajJNTTJkZnNBdWJ0b0hyOExTK3Rlb1pFeUw0?=
 =?utf-8?B?VTJQZ2hIbmtJVXJCemg2QmpHc2FnOTgrZmR5MlR5TjNPOWJKMjdEZWtOcXFT?=
 =?utf-8?B?VXc3WU83bHRtRlkrdTM5bE1TM2lQRmFHdFpmeElCaFhLcmQzazlpQkpDeXNT?=
 =?utf-8?B?UW9ZSjdPWEZBMUF5MGRIdzk3NHNGWFhRWHVGRXl5dmd3RFEzeGZtbVNhNDRM?=
 =?utf-8?B?WmhtTkMwUnd2RHUzTkhxUnJna0YvaFVNazg4QndkR3RmdU1uWVpPVUxNUGwz?=
 =?utf-8?B?UUMvNjQ3SmtNQXk2NTB6YWM4Q2JlaVBTYzQ2M2xtWGZsQkZBZFhxZzVzczhr?=
 =?utf-8?B?aGJ0OXlDSmgzZVRDRXZ1UEJiNjdFUnhLYXhyWGdIRC9lS3l0WUdUd1R2RDl0?=
 =?utf-8?B?MEdlcVB1K1dJMnVGaldyVE00RXZsemtuL0FNYmlIejNRWWZrdC82RXlicCt0?=
 =?utf-8?B?MkoveUVqcHRzRGRlSk5LNUtrYm5zUjRxbEFOVlBBWVpXQjBoMXJoZ3ZmZXhU?=
 =?utf-8?B?OEZLY3B0Y2VvaVBFSVZCRGJ6YnRROHBWdGZFSGxYVUtQcFJJb2NBbk5jQmtr?=
 =?utf-8?B?eVU1QTBSeXhjVWJXelFGaThqMk8rTXZoOWpCOFhtcHhrUk01RDE0bE1ZRVg5?=
 =?utf-8?B?WUFuMitrK2EvaG5UWk9iaGJORThiaVNCM0IyRlg1V0NCL1M4Qk9SNE8zSllL?=
 =?utf-8?B?THFwL0hwVE5pVUVTOEVEZGVZQ01uMEs1dnloZVFBUHIyb2Z2bUFnRWxmdUlr?=
 =?utf-8?B?cTFQYVhzQ3kyNVNFT2V5UGpnVmpGWWhVL25obWFMR2lEZ1VRY0swZTVXYzlO?=
 =?utf-8?B?d0c5M2drNG82RWE0QXByb1NaTzB3SytrYnp1SXU5VUNHWHpnc1hBL0QwbXZG?=
 =?utf-8?B?R0Y2Vkh3SHN5TDg5eXJyMWk2YjErK3JyWWR6Tm0wUnRvUy9ERjlLbC9TWEVF?=
 =?utf-8?B?ZmU5L2R4ZXUrME5QSUZ3UjRCdjkzNHVEeXZRRmN5cm9EUkpXZm9zaVp5STVo?=
 =?utf-8?B?NWdSQ0J3R0lseHNYRmZ2Z09xUExubVpxZ3l1dUJwbm1CNkkzeGJIaXoyYlFo?=
 =?utf-8?B?TTVuTnR6QTZ0WS9PdHo0K2sxdTRNTEdGLzYxZUFCNEpOQlF1MXcydG5kOTRT?=
 =?utf-8?B?VEI4S05uSEJMV0ZscFNLOFZETjFaTmVsMTdiN1hGRzQvdkQ1N3BlZDZrQ1FD?=
 =?utf-8?B?K1hYN3hGMzZOdFk1TEJvZm9SSU9FaXRHWUp4ek9veUdsNmhFbzVCbVlheHJa?=
 =?utf-8?B?bHNYRS95d3ZIbDFYMlovWE83VWxNQ2F0eVVLbWN2VWlCYlRRSXlGVGtvOW1i?=
 =?utf-8?B?cnZEZ2FKNlFHUFlkUk9HOGdmbXlRaTRQQW12OVk4ckRUQzcyNlZ4WW9GMW8w?=
 =?utf-8?B?RUtsK00xRTdCRCs2SHcvMFJzSGpPS2NsSUJRM29EdGdSZEJZcGlNZVZ2Ykg1?=
 =?utf-8?B?V1c0TDRud2czQkh6MXpYYVU5aEdwK0ErS0lvMWxvYlNmODF1bThwRjNjUE84?=
 =?utf-8?B?SUdyNEZ4SDJYZk5uMEtxY2ZwczlvZEhvcFhMY0QrcmhER09WZjVQOEY5VGVz?=
 =?utf-8?B?WmRubWVlUXVFSmNZYUIrMlhXak1SUnhLTVhaTEVEbXZyTmlZWnJGVUpqaVF6?=
 =?utf-8?Q?mNJ2oAoNsSe0nGPs++QVS87MGhU+V3m5u8a6I=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?emtGZHBGejNXVGdXY1U0TEZETXhOY3hLaVNTVVo4czIvaWlxVVg3LzRDa1FT?=
 =?utf-8?B?R0doU2M1VDZBOE1JWlgxS1RMd2gyUVpWci85SVVxekg0RFBXTHJaU0lHcnhN?=
 =?utf-8?B?QzZiN2ZUcXlGbXZyMlRBY0xGWkNMYTU5ekFCU3B2ZU9jVjNjeXBZb3R2VnFB?=
 =?utf-8?B?VmNpRGR3UEZYV29VUTJRODFqd2I3R3pjTEIzZUNIWjNXRkl3Rmo0bGd1VHFP?=
 =?utf-8?B?QXMzeTF0d3pLanZkSEFzemZ4QjBoUm9CbXY3TkVXbk5kLzNqN3dyS0I5RW9G?=
 =?utf-8?B?RlVTL0VRRHNDZG10ekh1bGZKRzNNOHV2ZEhqREZ4WG9HQ2ZrQ1BlTjhaYS9N?=
 =?utf-8?B?VnF1TWNoSHFZVkVUL2pORVQ4ZVNQZGtYRVBBSWRJNmthR1V3Q0RKUDZhTU8z?=
 =?utf-8?B?RWNLdEZwM0pyeXY5R2xNb2dqUEJPbE8rR0FFUFJpaGxPeWcrUVJscTY3VUky?=
 =?utf-8?B?N2owU2tLNVM3bGhjejBIZ0xmQmY3Y3FvUW9yV0tUbDlNdDZ1c2Zpbm85UVp3?=
 =?utf-8?B?Y1NjcE4yQnJMeCtSc2VEc1lwVktQQXNvMmxBcWpIOERhdXcvTjVqMy8zbEFU?=
 =?utf-8?B?TGhLT2tOZXZSOTFjaDBRMmZoeXRXc3FCejh3UEVPelFKSThFVVBkVjQ2aWtG?=
 =?utf-8?B?ekF0N3dmYlpqa1NieVJwTTAxN3RBRzNLUFNPRFh5NDlOZ2FjVGFtaE1ld01y?=
 =?utf-8?B?VTB0Ykh4TEdQRW5nNTdqR1M2eHlQOU5VYnRRWkh1U2F6Ymk0Wko4RzdYbzJM?=
 =?utf-8?B?Y3ZuaCt2NTMraW5PZVBEeG95WGxkeTJ6VjhwWERNeldZTkI0RFdPSHBsYlVj?=
 =?utf-8?B?c2Z3VFMwM0I0b1RQOEwwYnVwcFZsVXUwcDh3LzcxeFZFRDdkY2p4aHhyTGdM?=
 =?utf-8?B?UFZhNVNVQWNxT0NDeXIvVnRFdUgrVXI3UDJwbVM1RmszN21MSDlPRElPaHdG?=
 =?utf-8?B?OHI2NmhLeWVPdjRNQzNOUjNwdWF5bk9EWlNtb0VWNTFhRWVzK0dEWWx3K21F?=
 =?utf-8?B?ZGl2b21HeW0rTU5MTDd5am10RlRna1RXajJYVnhuRXlGOStlRXVpVXlCRWdX?=
 =?utf-8?B?elJIRDl2c2kva05TV2xGZDFYQVVacndMWnY5cXA3S2FrS09YcDlVOGZZU25P?=
 =?utf-8?B?c1pKaEtBWjAvNEhHWkg1QjNBNC8yUzZsYU1xazNqV2Z4aFNBOVhVNTR3eThw?=
 =?utf-8?B?QXJDS2R0bGN5dTk5eGR0T010ZzVWd1R2czBBd01OVlR2KzdhNGVtbnh3RDBP?=
 =?utf-8?B?eWpHK2RGTDFHcXJmM2l1UmxJUzNlZENNMEtrTERjZ2ZPdTR2VS9IM01OQzNQ?=
 =?utf-8?B?NXgzd0pFZFRmMDNZVWNpZE5sMzU3WEcyRHY1UHEzcnduaXZNNHRxK08wNWNq?=
 =?utf-8?B?S3JWRVBmR1hlVFJFS3RXb3BJNUMyQ21BZ0tOdzZYNExZR0twYWM1endyNVVs?=
 =?utf-8?B?dnp1Q1ZqMUxBeDZXbmFBTk9DQ0NLOHRFM1owNDgySGMzZkcySWx5cHVXMmZM?=
 =?utf-8?B?UERhRW1xcXBSNGxWb3FCVHVQU2tSZFlTdVFjUmZsR2pOc0R4Mjg3YXRVaTBC?=
 =?utf-8?B?STJZdGY3bmdPWU9lSnVnL1VoTTdZL0R3ZlFmczB1Kyt4czNoeFpLUEIwQnUr?=
 =?utf-8?B?L3pYU0VGS29RWVh2bVJWSVZSeUlKT3o2YUUxY0NTS1VrV3loOUlCK2J5RGNo?=
 =?utf-8?B?MSsyUGliM0I0Q25McUFNVDFNWWJabUNRQ2lPRnNIcWJZSlNYNUR4VjkzVmpI?=
 =?utf-8?B?eVdvOWlkc3llZFltS05DN3VJK0VvK2J1SDcxUUNLYmJGL3hGU0xCR2VIVGdV?=
 =?utf-8?B?TVFoalpwanFpTWZGTEdnMjc2Ynh4N0UrSVc5UEhhUVhoSWJXWjM1UVRRNHpq?=
 =?utf-8?B?L0dqdW9vMkFZWGtVUEtCUEYrTjRSNG1RNEpMTHNoRnNzMUg3c28ydjYyeEJk?=
 =?utf-8?B?K0xwWXJFYURDZVFtM2hid2hzbEtqVjJTT0pUdEw2Qnk4MUtlTHpYNEZ2NzJh?=
 =?utf-8?B?dDkwTkFaWWV3cEowam5sb0NGK2UzVWN4a0k0ZWt1WmU5UUhlYkxoSGptUnIw?=
 =?utf-8?B?OEJrbWlJbmcweFZHTnpKbHpsc1p3em9YdEJrWWlvelZUMWVLTldoS2JLK05S?=
 =?utf-8?Q?NGhx5U3JpMejgjoLCQsiH++pl?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6595F3B03A305244A8E9C0F1631A0ACD@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	GvwZF2bCnsQ6OHp7mYBukvJxlBwcO1as+/wsCW57WXqgwqm9Kjg81Q7QLQ7PRCf+WVNhohAtOYgJEn6q/FJKp5kQZsbH7IJZI8SEb/RKMu6OUNkCLZ4foZz8ENCLtqMkxPFs7aNwHKB8St/bomtds4/MlPw4Q+UsF5jflvDEq8508cAqmAUejOuZ12o7nVSJZZe+6zI8raDhjZkwnSU01TvL5W7+r6rRaUAckTcCtvCmqb2i9YmHcYg9Mq6udbm4p6TQrtkemeQx9FB8gFDm1mKRs76wzRLNIyj4kNS1L1T5hmiyTQK6dKqJfskHhvCWbZOAFV4KR3uSVQhypHIIdeoZxh2Z6sC7djDpog9CbA+zeZUdkmNIxGrNEOb0R2rDLm5ZvzKZV6Wdg/uhlHlXRW7KzvNUeM0uqCJXLMYl/6R8kaAOolPSFiKItXgvD7cPKMAVKxlpLbBHVN71OarcT3EmXM0GadhEA5bUH4+WlZvBDj8xfzD3/7HiaO7yfaBCP7meCPDY+SkW6QNMB06eTT6EgQ7atjjoj173M6JXlNGNE3Y0mL0hgkcyPnuoPUxry4YWGjLcSP33OOdZv5HJTrrGfHpIbIOV7n/Fz4W6iQtdulIgOD10O/g3GcUOmZoXF5jNT7ptiXDd0CM+6hoDKw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c824628-f64d-444a-4d31-08dc8fe12b51
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 21:54:03.6444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C5vQhwfPHN1bqWjFiqcnG8770IVtW6on408Rk3HvBCNdMhleXXhVvhZgizPL/sTXNPDBnDwdeEvesXjDs0VfmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5819
X-Proofpoint-GUID: GFNjT2gNlLwXbhUsR1-bBXDBv94nkC1q
X-Proofpoint-ORIG-GUID: GFNjT2gNlLwXbhUsR1-bBXDBv94nkC1q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_04,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2406180161

T24gVHVlLCBKdW4gMTgsIDIwMjQsIE1lbmcgTGkgd3JvdGU6DQo+IFdoZW4gY29uZmlnIENPTkZJ
R19VU0JfRFdDM19EVUFMX1JPTEUgaXMgc2VsZWN0ZWQsIGFuZCB0cmlnZ2VyIHN5c3RlbQ0KPiB0
byBlbnRlciBzdXNwZW5kIHN0YXR1cyB3aXRoIGJlbG93IGNvbW1hbmQ6DQo+IGVjaG8gbWVtID4g
L3N5cy9wb3dlci9zdGF0ZQ0KPiBUaGVyZSB3aWxsIGJlIGEgZGVhZGxvY2sgaXNzdWUgb2NjdXJy
aW5nLiBEZXRhaWxlZCBpbnZva2luZyBwYXRoIGFzDQo+IGJlbG93Og0KPiBkd2MzX3N1c3BlbmRf
Y29tbW9uKCkNCj4gICAgIHNwaW5fbG9ja19pcnFzYXZlKCZkd2MtPmxvY2ssIGZsYWdzKTsgICAg
ICAgICAgICAgIDwtLSAxc3QNCj4gICAgIGR3YzNfZ2FkZ2V0X3N1c3BlbmQoZHdjKTsNCj4gICAg
ICAgICBkd2MzX2dhZGdldF9zb2Z0X2Rpc2Nvbm5lY3QoZHdjKTsNCj4gICAgICAgICAgICAgc3Bp
bl9sb2NrX2lycXNhdmUoJmR3Yy0+bG9jaywgZmxhZ3MpOyAgICAgIDwtLSAybmQNCj4gVGhpcyBp
c3N1ZSBpcyBleHBvc2VkIGJ5IGNvbW1pdCBjN2ViZDgxNDllZTUgKCJ1c2I6IGR3YzM6IGdhZGdl
dDogRml4DQo+IE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSBpbiBkd2MzX2dhZGdldF9zdXNwZW5k
IikgdGhhdCByZW1vdmVzIHRoZSBjb2RlDQo+IG9mIGNoZWNraW5nIHdoZXRoZXIgZHdjLT5nYWRn
ZXRfZHJpdmVyIGlzIE5VTEwgb3Igbm90LiBJdCBjYXVzZXMgdGhlDQo+IGZvbGxvd2luZyBjb2Rl
IGlzIGV4ZWN1dGVkIGFuZCBkZWFkbG9jayBvY2N1cnMgd2hlbiB0cnlpbmcgdG8gZ2V0IHRoZQ0K
PiBzcGlubG9jay4gSW4gZmFjdCwgdGhlIHJvb3QgY2F1c2UgaXMgdGhlIGNvbW1pdCA1MjY1Mzk3
Zjk0NDIoInVzYjogZHdjMzoNCj4gUmVtb3ZlIERXQzMgbG9ja2luZyBkdXJpbmcgZ2FkZ2V0IHN1
c3BlbmQvcmVzdW1lIikgdGhhdCBmb3Jnb3QgdG8gcmVtb3ZlDQo+IHRoZSBsb2NrIG9mIG90ZyBt
b2RlLiBTbywgcmVtb3ZlIHRoZSByZWR1bmRhbnQgbG9jayBvZiBvdGcgbW9kZSBkdXJpbmcNCj4g
Z2FkZ2V0IHN1c3BlbmQvcmVzdW1lLg0KPiANCj4gRml4ZXM6IDUyNjUzOTdmOTQ0MiAoInVzYjog
ZHdjMzogUmVtb3ZlIERXQzMgbG9ja2luZyBkdXJpbmcgZ2FkZ2V0IHN1c3BlbmQvcmVzdW1lIikN
Cj4gQ2M6IFh1IFlhbmcgPHh1LnlhbmdfMkBueHAuY29tPg0KPiBDYzogc3RhYmxlQHZnZXIua2Vy
bmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBNZW5nIExpIDxNZW5nLkxpQHdpbmRyaXZlci5jb20+
DQo+IA0KPiAtLS0NCj4gdjEtPnYyOg0KPiAgLSBpbXByb3ZlIGNvbW1pdCBsb2csIGNvcnJlY3Qg
dGhlIEZpeGVzIGNvbW1pdCBpZC4NCj4gDQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9jb3Jl
LmMgfCA2IC0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDYgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgYi9kcml2ZXJzL3VzYi9kd2MzL2Nv
cmUuYw0KPiBpbmRleCA3ZWU2MWE4OTUyMGIuLjlkNDdjM2FhNTc3NyAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMN
Cj4gQEAgLTIyNTAsNyArMjI1MCw2IEBAIHN0YXRpYyBpbnQgZHdjM19jb3JlX2luaXRfZm9yX3Jl
c3VtZShzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgDQo+ICBzdGF0aWMgaW50IGR3YzNfc3VzcGVuZF9j
b21tb24oc3RydWN0IGR3YzMgKmR3YywgcG1fbWVzc2FnZV90IG1zZykNCj4gIHsNCj4gLQl1bnNp
Z25lZCBsb25nCWZsYWdzOw0KPiAgCXUzMiByZWc7DQo+ICAJaW50IGk7DQo+ICANCj4gQEAgLTIy
OTMsOSArMjI5Miw3IEBAIHN0YXRpYyBpbnQgZHdjM19zdXNwZW5kX2NvbW1vbihzdHJ1Y3QgZHdj
MyAqZHdjLCBwbV9tZXNzYWdlX3QgbXNnKQ0KPiAgCQkJYnJlYWs7DQo+ICANCj4gIAkJaWYgKGR3
Yy0+Y3VycmVudF9vdGdfcm9sZSA9PSBEV0MzX09UR19ST0xFX0RFVklDRSkgew0KPiAtCQkJc3Bp
bl9sb2NrX2lycXNhdmUoJmR3Yy0+bG9jaywgZmxhZ3MpOw0KPiAgCQkJZHdjM19nYWRnZXRfc3Vz
cGVuZChkd2MpOw0KPiAtCQkJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmZHdjLT5sb2NrLCBmbGFn
cyk7DQo+ICAJCQlzeW5jaHJvbml6ZV9pcnEoZHdjLT5pcnFfZ2FkZ2V0KTsNCj4gIAkJfQ0KPiAg
DQo+IEBAIC0yMzEyLDcgKzIzMDksNiBAQCBzdGF0aWMgaW50IGR3YzNfc3VzcGVuZF9jb21tb24o
c3RydWN0IGR3YzMgKmR3YywgcG1fbWVzc2FnZV90IG1zZykNCj4gIA0KPiAgc3RhdGljIGludCBk
d2MzX3Jlc3VtZV9jb21tb24oc3RydWN0IGR3YzMgKmR3YywgcG1fbWVzc2FnZV90IG1zZykNCj4g
IHsNCj4gLQl1bnNpZ25lZCBsb25nCWZsYWdzOw0KPiAgCWludAkJcmV0Ow0KPiAgCXUzMgkJcmVn
Ow0KPiAgCWludAkJaTsNCj4gQEAgLTIzNjYsOSArMjM2Miw3IEBAIHN0YXRpYyBpbnQgZHdjM19y
ZXN1bWVfY29tbW9uKHN0cnVjdCBkd2MzICpkd2MsIHBtX21lc3NhZ2VfdCBtc2cpDQo+ICAJCWlm
IChkd2MtPmN1cnJlbnRfb3RnX3JvbGUgPT0gRFdDM19PVEdfUk9MRV9IT1NUKSB7DQo+ICAJCQlk
d2MzX290Z19ob3N0X2luaXQoZHdjKTsNCj4gIAkJfSBlbHNlIGlmIChkd2MtPmN1cnJlbnRfb3Rn
X3JvbGUgPT0gRFdDM19PVEdfUk9MRV9ERVZJQ0UpIHsNCj4gLQkJCXNwaW5fbG9ja19pcnFzYXZl
KCZkd2MtPmxvY2ssIGZsYWdzKTsNCj4gIAkJCWR3YzNfZ2FkZ2V0X3Jlc3VtZShkd2MpOw0KPiAt
CQkJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmZHdjLT5sb2NrLCBmbGFncyk7DQo+ICAJCX0NCj4g
IA0KPiAgCQlicmVhazsNCj4gLS0gDQo+IDIuMzQuMQ0KPiANCg0KRGlkIHlvdSB1c2UgImdpdCBm
b3JtYXQtcGF0Y2ggLXYiPyBUaGUgJHN1YmplY3QgdmVyc2lvbiBwcmVmaXggb3JkZXIgaXMNCmRp
ZmZlcmVudC4gSW4gYW55IGNhc2UsDQoNCkFja2VkLWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5n
dXllbkBzeW5vcHN5cy5jb20+DQoNClRoYW5rcywNClRoaW5o

