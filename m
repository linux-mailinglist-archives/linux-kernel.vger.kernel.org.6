Return-Path: <linux-kernel+bounces-307822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE929965347
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 01:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71E341F238AF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 23:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC29D1BAECF;
	Thu, 29 Aug 2024 23:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="WGGXRG13";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="P9g5M02t";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="t916FlYU"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368D618B46D;
	Thu, 29 Aug 2024 23:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724972947; cv=fail; b=XHN+CcZxZ6ZgCLTopPeRY5LJ/fbTNjm67ttmnAEdKRePY/MWtF3PEP5LQU7qPsmzkJQ0D+3gg1dlPHo/Q9FUzNGNha+cp5XvfuyvK0TQezhb0fJaoYxG4VAM1OP50qcfPT9hWT61nv0FfSS/IJUHjdyZSNHVevl3ZkP7jvbEusw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724972947; c=relaxed/simple;
	bh=oy1p8YoP/kJWHZWOAMYmyQkJqzZbUSclxCadeHjEn2k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VmCZvcrkPuBRVrwG1LVvv2AdC9N0cz7b247IKD/scOd8nWb0gMekBbIb/R5H0KUO0bVWARRaoDdYvm64It47iBNZgSvPW0vIAnq2KD2ebiPpjpa35h5YhEyfKOHH3IeMt/4ksYVRIU6mmc+ow9ECG/xZLGE/YYnZs+PIDvsXjkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=WGGXRG13; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=P9g5M02t; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=t916FlYU reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47TIu0F2003080;
	Thu, 29 Aug 2024 16:08:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=oy1p8YoP/kJWHZWOAMYmyQkJqzZbUSclxCadeHjEn2k=; b=
	WGGXRG13pAB/oeQWEOE230mTi3yeGmzDG6dYjXzF20bCaB2RatR6fnlz8loU/i3B
	CCIs8mA1LGePEex9N5G02QFiWGDWHm8amSBJmItI+MCW7ylnnHVhLC3IgD0znDRe
	6w1pwLrHZXlUAa1fy2qJ0iGdh5DpT0W7hpfcqFQIAX16vynZzeFpEupQO2WXgiuO
	f7sp2aiw30dIczMgLCfuBuMbwrOeK1ELrdstQZpZmT/AapCCifihk55f3DHUyOca
	Z2Si5XFwWdnUYw/YM2MJs4Fd13IXdmDq45i+M0zNCPB2G5f7ncTXwZDPjdgyteXf
	NSVMDHHpyAf3jK1YOvsZKw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 419py14y4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Aug 2024 16:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1724972922; bh=oy1p8YoP/kJWHZWOAMYmyQkJqzZbUSclxCadeHjEn2k=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=P9g5M02t1IZKITm7IkZSmtW9tgbG7PJWsy6Kg/okaf06Rd/00B6GDSJkH/4MNY6Uh
	 vZrSD9RYu27xKn2lYABvzm4QBzxABEhIyTaDy3+tqo0A1w1IZVudOivsvOJBm0rZLy
	 WgeyTPhuJ1N2+cEkCWOF3wNN9byGLgiOntr7d1Sh5JuJmfPjhkhMsEVlvm6xUMpHAd
	 Cjt20owM39efmVKEUmDJy2HJuB4LMOXQX8OyyxwcZSnAkbJNacrdBEnRUlxg3dHBRm
	 IJyuUjpGMPr+5k6JTEgKghuHEdZp5xikNBrQsJGZPpfvQNr/3Bamr5uKi9RJz7TIxG
	 evstifFQHKJ7g==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B418040346;
	Thu, 29 Aug 2024 23:08:41 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 740E1A013D;
	Thu, 29 Aug 2024 23:08:39 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=t916FlYU;
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 5DC7E40362;
	Thu, 29 Aug 2024 23:08:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tl2ZWxDR/9jufFOq31GGwOXDdkGBppeLEQJKt/bwCqIkSpzwyoo6XCh+RNZZpB73e3MkVTHIgXhw22Eo/xJSezu17SN4WrZNpyfPeeYZxPx2My2+RKXdiEh0oK7iwaj+lHqk9GjU5b4DjOcKq0R8UqxXRfglyINNICSLiy/sdWMMaxn8T79i7SL54y67OEzkUTm9VO00ifP4McbZUbgpWOAOwNgjMMgSMa2ldyyFCTh5cXqK4T6jW67xF3PW5O49SvANwbwqpeX7v1svsE08B2slv7XLTlTXXlenmnXRKy+skQx0uxp7ptYTyC1ZFRR5Cw4MDtExYiJXAH44DNLdaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oy1p8YoP/kJWHZWOAMYmyQkJqzZbUSclxCadeHjEn2k=;
 b=fVrsZuXr9aR1c5iAyeLINOL2M8QzDxQO8seNSMZ0nrN2LvBFGVY7msCnKxG6z/QDo54VzMdos4H2pZRqtltIovQPJdOjG7EJO1FzaTa2I0vBn4MGGPhKhZZxrvqqZM1z3ZVQ16v4AgPfjNMZhi515CSyQN6XiT6GX+RaNIghUAcKj+IfpGZS7EoIohdUoWHfmtI69hd/NfvDeMDdktwdfNmgzfeamdxOpcZOoJiSITR6uGnABg7t3ZVWMygAqkw9rzE3dDcC5wxbgExQZpkc+9mne1fEzk2Yaab2KbvHdornMlEdOYOUDPxztPl6wg08MlAAP0IuRMRLl0mI2ZljQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oy1p8YoP/kJWHZWOAMYmyQkJqzZbUSclxCadeHjEn2k=;
 b=t916FlYUTE02X9IF15CPmqkNGNth/7FZCVMGcF9B0HzToOioLl+YjMnT2KqG6pvFh4qrdfkCCU46IpWHtvVlz9KfOnagKGEYnJTINfgSpWNah9S5EbgkM/X2feZ232vqDy+ZMcLSicisYsfvO1MaDzHbf9H5MAhetolQwPpi+AY=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SN7PR12MB6888.namprd12.prod.outlook.com (2603:10b6:806:260::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 23:08:34 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 23:08:34 +0000
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
Subject: Re: [PATCH] usb: dwc3: gadget: Fix TX FIFO size for HS ISOC endpoints
Thread-Topic: [PATCH] usb: dwc3: gadget: Fix TX FIFO size for HS ISOC
 endpoints
Thread-Index: AQHa+EULTkB2OCYKX0iBD1wqItnyWbI7vZQAgABSeACAAUhBAIAAg6wAgAEEMIA=
Date: Thu, 29 Aug 2024 23:08:34 +0000
Message-ID: <20240829230825.7tzgz44f3it2fdmk@synopsys.com>
References: <20240827054956.28241-1-quic_akakum@quicinc.com>
 <20240827231552.7yokoe7jqdm3wduu@synopsys.com>
 <93955b6d-0ce1-42cb-ad18-a82e2e8cfca9@quicinc.com>
 <20240828234554.lw4hzeajneee7n55@synopsys.com>
 <aebb87ab-d57e-4cb3-8cdb-835678f31154@quicinc.com>
In-Reply-To: <aebb87ab-d57e-4cb3-8cdb-835678f31154@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SN7PR12MB6888:EE_
x-ms-office365-filtering-correlation-id: b64f0e9f-45b1-4049-fdf2-08dcc87f81d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?c1BBaUtyRWRtUURLUnVvb3BtTWF4dkQvMU1qcFA3VmVBODJZUkxqUE8xMjR2?=
 =?utf-8?B?YnVacFJyN0h5TnZKRlMyOVZGZDY4VG9DVWlpc1NkNlN6S3BhenpZZGhBWWNO?=
 =?utf-8?B?NUZ1cnJheGdHYTFpcDJEZmVOVWxWcCtuTzBtMHh1MjBnTGw2YlBGTEZxU3lw?=
 =?utf-8?B?TytHcU9uMWpqbkhpUWlwWDAxQjlwRkk1ZFVHa0FTeFNlTEtwYXNJN2Uza0V2?=
 =?utf-8?B?VG5YdW5aRWsyZWtWS0FLQjNxWUowREIrcy9kNU9YMVVkL3k0ZXphdGNLY3J6?=
 =?utf-8?B?RXdtS2pkM0k3UysxY2JQS09IcWFsRXFlUm9xSDFnbHRXZGs2R1daaHh6dFQx?=
 =?utf-8?B?RkxackYyQTRocmZKUXNqeEdYYTN4WnAyK29GTTczZHBoencwazRyVllVSGRo?=
 =?utf-8?B?Ti9rUE9tZSsrZnFqZUhsUDJQczVJZVhZT2FpOWdDT3k5K2pVK3h0Z3hHVXdT?=
 =?utf-8?B?NXBEZjJJL3U0V1hQTVpxdEFpaDdpVU4xbldVT3ljVElrRHYzRW1ZcTFaZkEw?=
 =?utf-8?B?RzNSeTBPUFBOalg0Tnd1RldiZXpsZS80Z1BRd3hCKzhoV3Qvd3ZkeCtLbzVZ?=
 =?utf-8?B?UStMRnRpY1dNNkwzMGNhL0xZNGFiWWoyaDl1YkdkZ1J0S0pEZldCalN5YThC?=
 =?utf-8?B?OVRWcE41RkRUMXc1WWplK0l5V3VXQUo4akwwUUZIUlVra0JKTWlGemt4NUhr?=
 =?utf-8?B?T2l1aEJvNkxuUDhEK0R2MTl1c1NsU1JLMlY5Y1cyN0xpRm50QmZ0NktCRGlO?=
 =?utf-8?B?bHFPalZPK1p1ZjRXdStQUmhtdDdtRjZOU1U4S0N2RXBlVDFRN0dxYUhpUU1a?=
 =?utf-8?B?WGJsZ3BXOVN5VC9UMHcxclZ0NGY1KzduOXoxekN3YjlSZmUwQWdkc3E3K2xX?=
 =?utf-8?B?alA0c3dmQk9UQ3U4K2p1V0Z2eDd6SzE0U3RJcmlUbVp0cmUvSjB2eW1IZ0NT?=
 =?utf-8?B?VGZDYXg0WlR3NVpmdzZuT2pyYjNTZ1J1Uml2bXo1cDJGa0tqQnY2MWg3UzVV?=
 =?utf-8?B?WVp1MVFna3hjb05nS0ZBdzQ1TG9FVHF0cDVKNi9SSFlYSEczdGU1ditRdGFn?=
 =?utf-8?B?eEdYN2NwUE43QUdTRjNKTk03TTdhbStweWJCUHpURTNKck9UVzJUbzJ2WEs4?=
 =?utf-8?B?SXV0T2RXMElOd2VJR1VGMGpFMFY0NnRxcC9pdzgxbkJwRzZ4SUl0VnRSK1hh?=
 =?utf-8?B?TUNrV0hCQzQvNEgrcjdRWFBKQVpraDZQWWdzZ2dtVENiN2E4VTRuTlJEY2Jq?=
 =?utf-8?B?aFhwU0tWZm05bEl0TmMyRlNqUHBlamlJakkrZEF1eWJUVEdIRkhLZTVKRWRE?=
 =?utf-8?B?N0tCalJCdGgyS0Voa2hDVC9OZkNhWEF6SGJqN0dMZTkwb1B2TU8zaFVieXd1?=
 =?utf-8?B?Wks1MGU4bmxsNDdTVEpyZGZ4UnVSaDgzamlPUUVXQkVGK1dIMU55Rk1tdEgy?=
 =?utf-8?B?WkxuaTJzTWV0eDN5VkwxT0lQRFdkVXBQeDl2SllyMlUvQlIvYmFoQjU1UGN6?=
 =?utf-8?B?aTM2SjRrMUh2RGx5b2M1RVEwNUVxcWZLY2NiODBoV3QxeEFCL1JqYkU5U1Fh?=
 =?utf-8?B?WXpmY251ZU1zcUFHUUZLYUtQelBxbHVySHc5UUFLUWNzdHppYTFrV3IrOFk5?=
 =?utf-8?B?MHQyZGxOVEFaNndsZnVFUFFZRE1RdUVTWGt0MnlYcW9hR3hDQmxIdTNZWTVt?=
 =?utf-8?B?TDNXcE4vSlJ3VVlDcnEweXozeW9hdmlPVDdwRWdzUHd6UThsU3RBNHZ2N3dt?=
 =?utf-8?B?V1lBMzlzWVovQ0VXUUFLUGF3U2l2bVZsUWtnckwzdStVcEZ1VHBBR3RnRVlC?=
 =?utf-8?B?Z1YvR2ZJSWRpN0U5UmxoeVVmaitRMVVscnBTeGZkWEloaW9kNm56djcyQm1s?=
 =?utf-8?B?ejI3Y3h4MmkzOUo2bmlObjZKbG5zNmdnUkhiM2RPcDgrSWc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NGVlb2pRRXNvbVhFUzhCNXpNSDdPSUQ1bVh4dmwxS2NUeXVMc2xlQk9ZM3Qw?=
 =?utf-8?B?Tm8zejU5MmpmRmF0b2p1Tmh0VytRODJMM0tQQ0lpWFM5TzUwOVJJUFNFbFRs?=
 =?utf-8?B?OFAyNzNEWEhLeG15K2FybG9rT1BrZ3hEUkxRb1IxbFpHZjJLOGZZS3RkT2dH?=
 =?utf-8?B?dFVwOGlQUEFvdVZUOHliR2xWTGlIMXFkb2lKcVc0T0lQdW9pSGxyQjRqeG5r?=
 =?utf-8?B?NGZEQzFHYlFqZzZpNHIwQzVXRzVvbXNsVGRHWkV1R0xXcXhaRGYrYlJnUnk2?=
 =?utf-8?B?MDVuNVhBSHBLQkJVTHZ6Qm52aUFmV2pyMnBJekVrQ3M0ZFI5Tk42citvNnVT?=
 =?utf-8?B?bE95bVJWSFZ4bDV0S0VleGFrUjUzcm5HTElsMXFLSjY1anArMlI3bzV5dXJu?=
 =?utf-8?B?RG5zS2pJOFlzMTFIbkZIVlAwa3liZWtnUWgyQWZWOUR2alJIN0JLUllQTFQ5?=
 =?utf-8?B?UVpWNzAyZEpqalZ1TlhnMzh4b3RTc1UySHh6K05qK3ByQlUrZmM0Y0hvVDJ3?=
 =?utf-8?B?VklveFFUTFNsclhiTkV6VjJKS1NFM0N3Nkt5QWhZdW4vM0JoVktCcHJTeHZQ?=
 =?utf-8?B?eUhmL3JnRmpzdENzUWY2SjN6SVFGMytvZ0I1a1lVenRBUi9yOTRHT0s2UWpn?=
 =?utf-8?B?WVVIVTdnYXAzS0FmU2RrTk1hQ0pHL0RES0hqUEZrTVR3UlFKd2lnVEpRWkZs?=
 =?utf-8?B?Wi9PL0F1REdrOUVHdlhBRC80OUZLMTBCM3hGOVF1ZUhtNEh1Z1FNbWg4b1VW?=
 =?utf-8?B?c2JlL0ZQaHArd0RqMFdMOUE5QU41RVIrM0xqQ2V0Mi8yeEZCcnhOSzlvZXg3?=
 =?utf-8?B?cm1HMHY0NXhBVkVVcjNnRkVEMVVVUDh4bEhjR09DYTBDWTFuS3hVd094MzQ0?=
 =?utf-8?B?QVhhY1hnK21tM1JBRUJDLytlUW1PMFMyK1k4RG1GUERxVzFGZnJkTDFKQ05J?=
 =?utf-8?B?TzdZRFdsSEZNZEJVTS9KTkI0RUFDWjBsNHVyQ1VyaWIyL2w5cit1ZUFtaGNz?=
 =?utf-8?B?cVFqREdja05qS0UyeElnT0VaZ241aGRqSDhVUW5UaHVSak0zMFM0ZmJrd3F4?=
 =?utf-8?B?Y2x2QTZyN2pRQlFqZ1NaVWZrSEZuSXNPMlhJam9hTlpwQWIrVmpYVVVRZ1hs?=
 =?utf-8?B?VDlIVzR3L1NjanB1ayt3dUU4V3YvQnVlSWl5cDY3Zkp1RGdqc1FPZEZ5WG9m?=
 =?utf-8?B?UTYzaUc3VWtaQXJuS1UrdHRvb2hXbmVNUGpvaUJteVQ0alNRY2Q4UFpmL0lp?=
 =?utf-8?B?QnV3eHY4N0RnRU81SGpNRnVtYXRWb0ZMZlVzK0ZWcSt6b041ZFkyNWRYWWlV?=
 =?utf-8?B?RTRtZkdaTUlML3pwa3c1VmkxdjFCNzRxcUdNdkdGQXhydE1uTXBtYXBLWDFC?=
 =?utf-8?B?OHRaZXZMNkVMTHZxWlRyaGZZcWRpMG50OEhwcTByaDJCYVVKaWFsUm11cExz?=
 =?utf-8?B?U0JBRG9VeUkyU2szTnJkWnlOTnk5TUJqL0ZrUmhEZkdpL0VjcDVuNGVlSXhr?=
 =?utf-8?B?VnZaRXh1T05uakxoM0x0WVhJRjgvYlZMek5WZG13SlFraTdlUCtIVWJPcWg5?=
 =?utf-8?B?THhRWXFCOFVHcDc2Y3c1RE0yVSsyRExPTWY3dkNWcXcxQWcwbHVDZGdheGNu?=
 =?utf-8?B?V2VxMThIVnN0dE12cUp1QmdSalgxdzRkN1ZvNGkrZ0J3dHc2K0NDeFpWR3gw?=
 =?utf-8?B?K0REQ1JOQ05mNG8yVHMwQWQrWjFiS0RpYWdaanFYdWIyVS8yeVIrR0RHT2Vp?=
 =?utf-8?B?MXl5NGNlMjA4QWc0ckNqV2d2czlpUHBkUU1XZEYxbVp1ZkpiYUxmaVhweE1u?=
 =?utf-8?B?WE0vYkZOQ1B5U3VQM0hreTF1QmxISXU0WXVMZHB6NUlsTG55bC9jczcrMnFD?=
 =?utf-8?B?L0ZlRlB3UTlHdDVjUVVtYm5GWkpVMWRuU3NML2p1OWZHZUVzQ3BiZ1dFLzZt?=
 =?utf-8?B?NWxUVFRpMGJmZXVvU1lQSW5WRzAvcTRGUzhmcG95cHd1MzcwWHpGeXFHZTgx?=
 =?utf-8?B?NVNLcnY0cEdXZGNKZ1JKMXJlWWppZk4xVUxYbGNYRkJ5b3daaUFJR01JRTEz?=
 =?utf-8?B?YVp6Zk9YemRJOFNQNEFDSkd1QlZnWkx1RnNNZ1BSQ2ZBeXkrMER3Q3M1ZEdu?=
 =?utf-8?Q?VnzRf/LNMj+vqWJAT69+pwfqP?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <446EE052977D6A408409CAA7C13D197C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	E7bqD41OADjWEM/9BM8OHQQXx71KRcLP3LguO/muguV/MLDoPg3EoV52n6o4CJnaIhnlqTYcATHzjTcIcpj6Ai9lWO82rjKj++AR3DNbdlOYz7wLC5khHQGzpbjsJePEkJayjFWah7C78u9DuzTiXy3M14Z4m1jbtPFhzC4y/lQUW+QKpkrXW0TZPljb/XRV2zVAWd2QYdadnHU+D3clpZdsY1eiSDnzxU9mtiu9Jl3TWbEh2Srkq4ZTV6NWUfId9+57aApSWMfj4vQ4ovEnRCAhl11cAmt7DrL6bVlpFxNjgnv6fx0UtxUyq/ntuUouyO0CioK9lhBFhrL17F0q5ak7wd4PcIq+Wip/y2zy/NA/ZjIk2SJM0JczGaw9m8Jtn0dlypxHYRDPMvIcvbeOaXUMP4jPS8DJpE6pJaV6h0oCxBdiskDTaHVc1/YMEH5B21lH60+42lzyV1t87KD78mSvnD/H95RYMhyutWDNhF50xOFoSVLpZN2Na39j25q9wxopxUjVkjoIwYje3ukhlxNvgUyLr2q3/FnPuDVYzyxt1LRZSUy5B8w0stFi1VwncpymIJ/JtKPZ7wefnTg0O5Xdqwo60CLGcLQu8hrWFu1W0H9ECI8hsSuhwzxGRtMZ6gMnLr8tmLykAmSMBX7bIw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b64f0e9f-45b1-4049-fdf2-08dcc87f81d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2024 23:08:34.4433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OzfkKt/8Eq2Rq8nVItoe0JYrmD/NSuzVPnzpmKVCJA7b0y40tobjA0efCVu+a3Ohsz1BP+aisIK5BUpVrUziMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6888
X-Authority-Analysis: v=2.4 cv=PpXBbBM3 c=1 sm=1 tr=0 ts=66d0ff7b cx=c_pps a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yoJbH4e0A30A:10 a=nEwiWwFL_bsA:10
 a=qPHU084jO2kA:10 a=COk6AnOGAAAA:8 a=m3HrZUer2jY-Wr1gG60A:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 7AgGfsaut_-a0aCCQmmzeE6jWcb1BVOo
X-Proofpoint-GUID: 7AgGfsaut_-a0aCCQmmzeE6jWcb1BVOo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_06,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 adultscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408290164

T24gVGh1LCBBdWcgMjksIDIwMjQsIEFLQVNIIEtVTUFSIHdyb3RlOg0KPiBIaSBUaGluaCwNCj4g
DQo+IE9uIDgvMjkvMjAyNCA1OjE1IEFNLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4gT24gV2Vk
LCBBdWcgMjgsIDIwMjQsIEFLQVNIIEtVTUFSIHdyb3RlOg0KPiA+ID4gSGkgVGhpbmgsDQo+ID4g
PiANCj4gPiA+IE9uIDgvMjgvMjAyNCA0OjQ1IEFNLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4g
PiA+IE9uIFR1ZSwgQXVnIDI3LCAyMDI0LCBBa2FzaCBLdW1hciB3cm90ZToNCj4gPiA+ID4gPiBV
c2UgMksgVFggRklGTyBzaXplIGZvciBsb3ctcmVzb2x1dGlvbiBVVkMgY2FtZXJhcyB0byBzdXBw
b3J0IHRoZQ0KPiA+ID4gPiA+IG1heGltdW0gcG9zc2libGUgVVZDIGluc3RhbmNlcy4gUmVzdHJp
Y3QgMksgVFggRklGTyBzaXplIGJhc2VkIG9uDQo+ID4gPiA+ID4gdGhlIG1pbmltdW0gbWF4YnVy
c3QgcmVxdWlyZWQgdG8gcnVuIGxvdy1yZXNvbHV0aW9uIFVWQyBjYW1lcmFzLg0KPiA+ID4gPiA+
IA0KPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEFrYXNoIEt1bWFyIDxxdWljX2FrYWt1bUBxdWlj
aW5jLmNvbT4NCj4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiAgICBkcml2ZXJzL3VzYi9kd2MzL2dh
ZGdldC5jIHwgNCArKysrDQo+ID4gPiA+ID4gICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9u
cygrKQ0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2Mz
L2dhZGdldC5jIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiA+ID4gPiA+IGluZGV4IDg5
ZmM2OTBmZGYzNC4uZjM0MmNjZGE2NzA1IDEwMDY0NA0KPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMv
dXNiL2R3YzMvZ2FkZ2V0LmMNCj4gPiA+ID4gPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdl
dC5jDQo+ID4gPiA+ID4gQEAgLTc4OCw2ICs3ODgsMTAgQEAgc3RhdGljIGludCBkd2MzX2dhZGdl
dF9yZXNpemVfdHhfZmlmb3Moc3RydWN0IGR3YzNfZXAgKmRlcCkNCj4gPiA+ID4gPiAgICAJICAg
ICB1c2JfZW5kcG9pbnRfeGZlcl9pc29jKGRlcC0+ZW5kcG9pbnQuZGVzYykpICYmIERXQzNfSVBf
SVMoRFdDMzEpKQ0KPiA+ID4gPiA+ICAgIAkJbnVtX2ZpZm9zID0gZHdjLT50eF9maWZvX3Jlc2l6
ZV9tYXhfbnVtOw0KPiA+ID4gPiA+ICsJaWYgKGRlcC0+ZW5kcG9pbnQubWF4YnVyc3QgPD0gMSAm
Jg0KPiA+ID4gPiA+ICsJICAgIHVzYl9lbmRwb2ludF94ZmVyX2lzb2MoZGVwLT5lbmRwb2ludC5k
ZXNjKSkNCj4gPiA+ID4gPiArCQludW1fZmlmb3MgPSAyOw0KPiA+ID4gPiA+ICsNCj4gPiA+ID4g
PiAgICAJLyogRklGTyBzaXplIGZvciBhIHNpbmdsZSBidWZmZXIgKi8NCj4gPiA+ID4gPiAgICAJ
ZmlmbyA9IGR3YzNfZ2FkZ2V0X2NhbGNfdHhfZmlmb19zaXplKGR3YywgMSk7DQo+ID4gPiA+ID4g
LS0gDQo+ID4gPiA+ID4gMi4xNy4xDQo+ID4gPiA+ID4gDQo+ID4gPiA+IFRoZXNlIHNldHRpbmdz
IGFyZSBzdGFydGluZyB0byBnZXQgdG9vIHNwZWNpZmljIGZvciBlYWNoIGFwcGxpY2F0aW9uLg0K
PiA+ID4gPiBDYW4gd2UgZmluZCBhIGJldHRlciBjYWxjdWxhdGlvbj8NCj4gPiA+ID4gDQo+ID4g
PiA+IFBlcmhhcHMgc29tZXRoaW5nIGxpa2UgdGhpcz8gKGNvZGUgbm90IHRlc3RlZCkNCj4gPiA+
ID4gDQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIGIvZHJp
dmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiA+ID4gPiBpbmRleCA5YTE4OTczZWJjMDUuLmQ1NGIw
OGY5MmFlYSAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0K
PiA+ID4gPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ID4gPiA+IEBAIC05MDgs
MTUgKzkwOCwxMCBAQCBzdGF0aWMgaW50IGR3YzNfZ2FkZ2V0X3Jlc2l6ZV90eF9maWZvcyhzdHJ1
Y3QgZHdjM19lcCAqZGVwKQ0KPiA+ID4gPiAgICAJcmFtMV9kZXB0aCA9IERXQzNfUkFNMV9ERVBU
SChkd2MtPmh3cGFyYW1zLmh3cGFyYW1zNyk7DQo+ID4gPiA+IC0JaWYgKChkZXAtPmVuZHBvaW50
Lm1heGJ1cnN0ID4gMSAmJg0KPiA+ID4gPiAtCSAgICAgdXNiX2VuZHBvaW50X3hmZXJfYnVsayhk
ZXAtPmVuZHBvaW50LmRlc2MpKSB8fA0KPiA+ID4gPiArCWlmICh1c2JfZW5kcG9pbnRfeGZlcl9i
dWxrKGRlcC0+ZW5kcG9pbnQuZGVzYykgfHwNCj4gPiA+ID4gICAgCSAgICB1c2JfZW5kcG9pbnRf
eGZlcl9pc29jKGRlcC0+ZW5kcG9pbnQuZGVzYykpDQo+ID4gPiA+IC0JCW51bV9maWZvcyA9IDM7
DQo+ID4gPiA+IC0NCj4gPiA+ID4gLQlpZiAoZGVwLT5lbmRwb2ludC5tYXhidXJzdCA+IDYgJiYN
Cj4gPiA+ID4gLQkgICAgKHVzYl9lbmRwb2ludF94ZmVyX2J1bGsoZGVwLT5lbmRwb2ludC5kZXNj
KSB8fA0KPiA+ID4gPiAtCSAgICAgdXNiX2VuZHBvaW50X3hmZXJfaXNvYyhkZXAtPmVuZHBvaW50
LmRlc2MpKSAmJiBEV0MzX0lQX0lTKERXQzMxKSkNCj4gPiA+ID4gLQkJbnVtX2ZpZm9zID0gZHdj
LT50eF9maWZvX3Jlc2l6ZV9tYXhfbnVtOw0KPiA+ID4gPiArCQludW1fZmlmb3MgPSBtaW5fdCh1
bnNpZ25lZCBpbnQsIGRlcC0+ZW5kcG9pbnQubWF4YnVyc3QgKyAxLA0KPiA+ID4gPiArCQkJCSAg
ZHdjLT50eF9maWZvX3Jlc2l6ZV9tYXhfbnVtKTsNCj4gPiA+ID4gICAgCS8qIEZJRk8gc2l6ZSBm
b3IgYSBzaW5nbGUgYnVmZmVyICovDQo+ID4gPiA+ICAgIAlmaWZvID0gZHdjM19nYWRnZXRfY2Fs
Y190eF9maWZvX3NpemUoZHdjLCAxKTsNCj4gPiA+ID4gDQo+ID4gPiBzaG91bGQgYmUgZmluZSBm
b3IgbWUsIGFzIGVhcmxpZXIgdGhlcmUgd2FzIG5vIGNhc2UgaGFuZGxpbmcgZm9yIG1heGJ1cnN0
IDw9DQo+ID4gPiAxLCBieSBhbGxvY2F0aW5nIGZpZm8gYmFzZWQgb24gbWF4YnVyc3QgaXRzZWxm
DQo+ID4gPiANCj4gPiA+IHNob3VsZCBiZSBhIGdvb2Qgc29sdXRpb24gYW5kIHdpbGwgd29yayBm
b3IgYWxsIGFzIHRoZXkgY3VzdG9taXplIGJhc2VkIG9uDQo+ID4gPiBtYXhidXJzdCB0aHJvdWdo
IGluaXQgc2NyaXB0cywgbGV0IG1lIHRlc3QgYW5kIHVwZGF0ZS4NCj4gPiA+IA0KPiA+IEFzIEkg
bm90ZWQgaW4gdGhlIGZvbGxvdyB1cCByZXNwb25zZSwgeW91IG5lZWQgdG8gYWxzbyBhY2NvdW50
IGZvcg0KPiA+IGFkZGl0aW9uYWwgdHJhbnNhY3Rpb24gb3Bwb3J0dW5pdGllcyBmb3IgaXNvYyBp
ZiBvcGVyYXRpbmcgaW4gaGlnaHNwZWVkLg0KPiA+IChpZS4gdXNlIHVzYl9lbmRwb2ludF9tYXhw
X211bHQoKSkuDQo+IHllYWggaSB0aGluayB0aGF0IHdlIGNhbiBjb250cm9sIHdpdGggbWF4cGFj
a2V0IHNpemUgZm9yIGhpZ2ggc3BlZWQgY2FtcyBhbmQNCj4gd2UgY2FuDQo+IHdvcmsgd2l0aCBt
YXhidXJzdCByZXF1ZXN0ZWQgb25seSB0byBhbGxvY2F0ZSBmaWZvIGFzIGJvdGggYXJlIGNvbmZp
Z3VyYWJsZQ0KPiBlbnRpdHkgYW5kIG9uZQ0KPiBzaG91bGQgYmUgZnJlZSB0byBhZGp1c3QgZmlm
byBhcyBwZXIgaGlzIGVudmlyb25tZW50IGFuZCBub3QgYWRkIGFueQ0KPiBhZGRpdGlvbmFsIGxp
bWl0YXRpb24uDQo+IExldCBtZSBrbm93IGlmIHdlIGFsaWduZWQgYW5kIGdvIGFoZWFkIHdpdGgg
YWJvdmUgc3VnZ2VzdGlvbiBvbmx5Lg0KPiANCg0KSSdtIG5vdCBxdWl0ZSBjbGVhciBoZXJlLiBQ
ZXJoYXBzIHlvdSBjYW4gcHJvdmlkZSB0aGUgY2hhbmdlIHNvIHdlIGNhbg0KcmV2aWV3Lg0KDQpC
UiwNClRoaW5o

