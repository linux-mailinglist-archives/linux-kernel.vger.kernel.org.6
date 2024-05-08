Return-Path: <linux-kernel+bounces-173925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5A38C079A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 01:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4C2928385C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 23:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83494130A4B;
	Wed,  8 May 2024 23:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="N2zNO7dn";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="YrFPoxvT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="A014aB9T"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABC2393;
	Wed,  8 May 2024 23:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715210418; cv=fail; b=cfo6RVfubu+uE6+5i+gSdK3SbHVBvzn9SINKVinrVTLgAFiuJVQfY0xAU1z/YhWq2f3kAvjuOB1L8HQq7EYefcKo5WNfUj4PGk7klHUAxeg6zm0doWX2dH/4Wd2JsSzOZgsGVqKM7tWPwIo7mK+ZNdJuvFzVuJdk638xBAMfrFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715210418; c=relaxed/simple;
	bh=2qoolpe7k6ZCt/1SbOf7CPEntLUntctbnU6llqxUAkM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ifbJgpbbK+8jjIKjl3ewlluPAh1ONdHMFCrzYUaHL8HUcW25goOa/GUCYNIJHgV6TXmhpLqRuJyYWt3wDBpgbfdCj100Myh1td5PaCfMDYon8zs577qpF0k51WurV1qCQceCYNmruIf6sYKF6GxmMLaPx6qy4qCwKu7CCujMllk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=N2zNO7dn; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=YrFPoxvT; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=A014aB9T reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 448KYxtK025593;
	Wed, 8 May 2024 16:20:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=2qoolpe7k6ZCt/1SbOf7CPEntLUntctbnU6llqxUAkM=; b=
	N2zNO7dnLR2vJrG0yQriwvkojPRYPgI0D93KCf3BULTY+4othvo+Hg0ji//54j16
	HWYboqRymmdDXF1tm/01X2x9oCrVSXltbekqq0LK5f6EMeMjHPid2uXc96S8IKMM
	ZH1iXdLcervXg9AsDYh3HfvTI0ot31N1Aauve5sexKtNFo2O3Z8WX0CFW9RdA5gz
	OI4Han5Nz6skq3U6oMgPyaT7sgNROOQCFo4rTWoHbaSbygy9kAZtyRksGfaP3oi1
	/u//n5TPrA39APQ6VFz0b1GreyyHqu/kH7ehJqn+xcREAC/l5/UCKcvRKWlBbBzn
	KiKFxuFwHVo74ncY1UrTvQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3xysknwy1f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 16:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1715210408; bh=2qoolpe7k6ZCt/1SbOf7CPEntLUntctbnU6llqxUAkM=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=YrFPoxvTdwxf+cmgfx54c93/d1dvjFkvnsuHjljYTF57850q1ewSMz4Hot7oTc/qE
	 e7ADTLvqvCUKc7Lk4H5SIbwL3y/4oXPpgvoum01gzizqe2O/vDWR4brzQtKzf01NON
	 zasyYQVq7SLIWDsgdv438jqRYUeorOxR86GtpYr4dffACAWuJ4IA/KMd2AqKTeXCny
	 B6rPfy622YofZ18jnfYLpQWq57eVJ2WVgyZEBMBnvPZjLiBKugEha+m1kmwUjESpov
	 vL3Er/My7hTuSjdXne6VCbMYNsoCa0TFEkXrkdw5DSI8IyHQhWbN/qpMhHpMZkap8l
	 zTnr0f/+cB6uw==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E1930403A2;
	Wed,  8 May 2024 23:20:07 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 080DCA007B;
	Wed,  8 May 2024 23:20:07 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=A014aB9T;
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id A40D640353;
	Wed,  8 May 2024 23:20:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YjmZVH8sZT++tInB0r3u/T/OeAB2/oqoUSWxiW/h+63RhN3skan4ihOGYY6uDJ1otI58t927u0w5dvhbXg/pwdhEvVR5Z6KylRz0PWCoSpV3bPdmlrJjYeqnbOO/xaXYVfEItL9M5UoOu07brnt9LYGc0lEZSwxncoEyBnG2e796+BCKeZtOn1UJYZHr0miHsysjhhaOUq0jSCNzZ2fsfDVhvBWOHt3SS7PiuqrRSud2ntb8/kBH3HC9hZZJtGpMA5d7Z3YnRXn8wGLp3SAXV6ASGGp4dNNd8J7Iq30vRG++Lsz/DJkLM1PQ4antPvqI2GMcP23CBwFh8QGHvacHFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2qoolpe7k6ZCt/1SbOf7CPEntLUntctbnU6llqxUAkM=;
 b=Z22cIg9kmGYkJGltGq/C5afY9YzOCrFXKx84M6bsweGkIyXSVlB9dzpWRwoeu640tgBKYrQhk5KkzFf75epapnDScHbcqS6DE2NXR4LnOqWWitpNUyaj6Tlcuics6hoOGK2InkZO42orNn5GEr5kcyI43c4Tud3iOvjywdBguEmGU8RxxUG4WlJDxj6mEoEre1mvBo4jk7znQYhHuYCGd9meIIhz9bdlNXyMOplQ2hR09+kMa0go8CNFbbeKyEbATeL4X0UDlIklnOTEoY2vPQkM3pndLMWDe4VADm2v5NrUGQJAQ0j0I1a0ZfjnX5dAX3G7q47ka/Xr2EFweelwzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qoolpe7k6ZCt/1SbOf7CPEntLUntctbnU6llqxUAkM=;
 b=A014aB9TO3oYABSmyoFGuNnkg+TRxyxHmTLuV5ZPLY6Tu3V4lpi68uHDglF330Uo0akVIyvzBYa78DLrtNsp3zGyDnn8Pl7hOQJA6XbJ4m9FWVJsRqJvZ4EtEqpIYGTTGsM7/oAfiKIsyH2eP50bC/3Cs3eW4px5vQrpDkG/ur4=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DM4PR12MB6061.namprd12.prod.outlook.com (2603:10b6:8:b3::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.45; Wed, 8 May 2024 23:20:03 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7827:b41a:c9d6:8e1d]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7827:b41a:c9d6:8e1d%7]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 23:20:03 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Michael Grzeschik <mgr@pengutronix.de>
CC: Wesley Cheng <quic_wcheng@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "michael.riesch@wolfvision.net" <michael.riesch@wolfvision.net>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: gadget: create per ep interrupts
Thread-Topic: [PATCH] usb: dwc3: gadget: create per ep interrupts
Thread-Index: AQHaoAoVjxvJC9SNLUaNNv/Fh2AK5bGMIMUAgAG8qICAAB7xAA==
Date: Wed, 8 May 2024 23:20:03 +0000
Message-ID: <20240508231950.ifyawl6bfy6bzvk7@synopsys.com>
References: <20240507-dwc3_per_ep_irqthread-v1-1-f14dec6de19f@pengutronix.de>
 <518a046b-1056-287b-f505-149958ad9c9c@quicinc.com>
 <ZjvuoVpVTnEcHRIH@pengutronix.de>
In-Reply-To: <ZjvuoVpVTnEcHRIH@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DM4PR12MB6061:EE_
x-ms-office365-filtering-correlation-id: 0115321f-5789-4542-78b1-08dc6fb563c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?NUpLdm1aNTNQRnZYQmUvb1lZYjZKRnpjVXVNVUhucm55Mjh5dXFoMkYxV2tW?=
 =?utf-8?B?dVo2azZWZERuUnJ0YmR2anNPbWh4K1NOU2F6V1I0VUEyclc2VHl4R2o1UDdC?=
 =?utf-8?B?T3hiQmZyemRKTXRWWElFK1VPa3dOcDVsSCsrVnNuQ3R5VGdKSmtYZlJBRVVJ?=
 =?utf-8?B?NXNjYlJRZjBQN3htbnowL0FoUnhWcHdtam5xUzVDZTdSMzNsTGQ0UW91d05M?=
 =?utf-8?B?aEI5NERqTzhIb20rNEZBd3d0N2NLZEd2NjdUaEc4K0hMYkhReGo5ZGxOTDFu?=
 =?utf-8?B?UU1KQWNHS0w5c0NYVzBBZWpIR25JVTZBNUVLTjc1bVZiNWl2WWRxMDUzaVFX?=
 =?utf-8?B?UnZ6UDR2bDJIUHNTbXZLZlpnNlZ1T0EwQ3U4eXVsWUZvWEVXVVdDVVhuTktZ?=
 =?utf-8?B?WllQSXloWFZJMlVsQmZBWjRFRDE1WCt5S0VKanozdUNYbWdxaHRUQzNXWXFS?=
 =?utf-8?B?b3ZnU0NETlNSaXlQRE1ZSGJ4ZjZrcllnb1phYi9MRDVJYzlsc0hjUWs2Yncw?=
 =?utf-8?B?ODNrMjRxRVBuMnBBcmIwd0szckJnZDJnWjdNeVNHYmI3VktPVFhrYmNIUXJZ?=
 =?utf-8?B?TUFBb2VrbG9RaXM1akdzYTFIOXY2U3lDR0JaZmRHS2pRMyt1WFZRWmR1MFRE?=
 =?utf-8?B?TnAxQnRRa0EydmJRNUhIZVlmbFF0U05kMUFUbWsvS0VKNFVKVWZYTU9VR280?=
 =?utf-8?B?K0hVcnpkdzA4WUZYQlg3SHd3ZXdEV0tzK2o5KzJjYUw0d1Z0NU16dWtNMjJs?=
 =?utf-8?B?eGRRZ1dyZW5VTWdmR21tbnRTLzNMMG1OYzFKcTNlSEpNVXVEUFgrVjBsRGJE?=
 =?utf-8?B?ZERXaEFXcm1lREJGeUE3K1puUFhySVgvdkNQeU5JUlF5eTBtMVVDSU5FKzZi?=
 =?utf-8?B?SlFHM3dGcHh1bVpnUWJaMkc3SWY5eG1KTktCZ3VVdS8xdmFiRjV6R3VqOFNo?=
 =?utf-8?B?c1ZiUGdNbXhHVjZzNGQ2R2dzVHY0cTN4N3RjNW01TktJRlJLQUJQakdHREJB?=
 =?utf-8?B?T1N6eHF5TnZhOEVzeWlJVjk4NVdCcENCL3RkZEUvR3F6cmF0SEpiVzFkT1c5?=
 =?utf-8?B?bXp6RTdQTVA2dUhwT1V0QngyblJmS1RKYkFDbFVnQTBxZFpPNUJvR3JBNFc4?=
 =?utf-8?B?TFM5NE9qMFhWd1RCa2RsN0FIQnREVWQ2d3dQZUt3REpOVzZWL0RwR0IySjEv?=
 =?utf-8?B?Um52T2VudlRlUlZ4bDFFWW1uNFhWZXAwcElhSC9ZRzBhcVFFYWR5dGNxa1Ux?=
 =?utf-8?B?VHAvOHVWRnNmck1yZi9sMlRLK1VyTmluVStPdEozRVdvNGhUMkt3MlFSQmJz?=
 =?utf-8?B?VzZFVDY0c21FQndOSDdYTUhnRWl6eVBNLzBSOVN2bTFPRFc5RHBnUUpZaVBF?=
 =?utf-8?B?QlpPazBTUEpLbVZZT2hEOGRET09jQXJuem1LMk1BeXAwc3FuSm45YnJnQ3lQ?=
 =?utf-8?B?ZjdIWmVWOFNqb2kwcm5nL2JhWmszWEh4QU1GRm5WaERvclhkc1lyWEtHZExy?=
 =?utf-8?B?aGVPclMxQ3lCOE9Cc1NrajEwYlBQSzVpRHozREhqZHJuYkdXbkwvNVFyTFE1?=
 =?utf-8?B?cTJUbWltRWpXQ0ZmZ0toaE8yRFg3L014ZlFWUUxDWXhsZkU3V1llTFN2bFpp?=
 =?utf-8?B?bi9MZElLTkpCM0JvZnQ5SHgrMFFhaFE4c3hsbFhpUGdsQ3VUTlp5RVVBUzIz?=
 =?utf-8?B?cGhPa0F2ODhlVGpRM1NTdGMrZlY1bCt6T3JrbEwxa2xuTmhoakJSMnZGOEZV?=
 =?utf-8?B?K3RRTnk5b254TzVaOVVJUTdRNEdKYXc5ajdVaG16UjhlSUxhQ09aejEyWDB0?=
 =?utf-8?B?OFhCWFlSdHBhVU1yMG1SZz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?eTYxaXp2c0pwYW9PaTNUVXRONTdnMWs0cGpsVk5UN09OZXlBRmZrUksxYzI4?=
 =?utf-8?B?NnZXM3pXZnZHMFZQbm1ZUms5bVFTOUpFVGZ6ZSttNWN6RWdPRHQ1YnNvTjli?=
 =?utf-8?B?V1M2c2VRMWhFWHRZRmtqUkgveTNnbllRWDY3RTJMK3dPUkR3eXI5ekRUcWdT?=
 =?utf-8?B?SXFITHZzalRXd3BhaWZEdVlYWFJYNXNjQ1IvQ0V1cGlrblNjR3l0RmNHSHNV?=
 =?utf-8?B?Y3p2OUs0Yk9BQjV1UHNTWjFud2FURUUzQSsxaytOODNXVnBHQnZHSzBMeGJF?=
 =?utf-8?B?VnVEdERabThqN1NwWUNGTlNEUWJ2QktEZitsdlUyaW9kb0pJUTN3RE5mWENG?=
 =?utf-8?B?TGF1YU53Y0pOVmJ2QTJ5aVBNTW5MWjc2OXg3Y0grL0xaTW12cnBQQjVQVUd1?=
 =?utf-8?B?YzlwZzU3Ymd3QWpRczlER3VrRUROUHJRZnNEZ24yWm5vc1FkM0FDZkV5QTlU?=
 =?utf-8?B?VzlIUXp2YTVFNTFvalN1K1lFcXR0N0ZaTThCdjZiMC9SUDB5SFhSV0Q4YjB6?=
 =?utf-8?B?MU4wWUV1QkFsQUZvZlNDQXlseUUwcXdxWU42clpWanJ2U1FWQVVBcWRhOGtm?=
 =?utf-8?B?TXVnellTQjY2NWJSaDZnNGxzcjhMblA5UHZmSEdldDVqNGpPaGNoRys0ZFFp?=
 =?utf-8?B?a2ZMOHFINTB2bmpDS0o2MjF1aG9Rc3Vwa1dab1BOenFUOHFOdWdvQnYxcWRM?=
 =?utf-8?B?d0lhUHpMMDFmcHlyMkI4UEZpM2N4ZGR4dGFZb3JsdFRkUzhnRUNxMnE0UTc0?=
 =?utf-8?B?ZDJmSzZVditSclJqZWhPNFg1c292Zm5HQy9oWXc4WHVNRFY4OFdtWnozYURE?=
 =?utf-8?B?akt5UTZBdGR0MTFjbGlGVkllTnE5ckk5elJEWUQ1YWR4R25LR1RvOTJaSzBB?=
 =?utf-8?B?TW1jVmErTlJxMlZraVZNUjJTT0dCMHlHWHFYSzhQV2RGT3lvMWVhYVJXaUNT?=
 =?utf-8?B?SVdkcUhTdzhYTGRJRFlzWUpvVWFITzFkaVdKYUh4TTdLeUxzRXhwMmlQZktY?=
 =?utf-8?B?RUdJRE9jcVMyN1VlSTVPY2FxUkNYZURNUHJRbFdIR3ZOcWZuelVGQ2gyUytl?=
 =?utf-8?B?VVJaczQ2amRseU9aUS9kN2JLRGxFQWpjd1JMcmdlSGRudmViOTJHMWxyNWJv?=
 =?utf-8?B?RFpuaGFGOGtSamtBVzE1a0xtb2tkbWVPUHVFV2lDZjdWZ0V0S3lBSWpxNUJ6?=
 =?utf-8?B?b1crblA0SHB1YVlCMm5WT0U4eVpQaW8vMVpnQTNEN0hERHRuK2ZNM0I1MC91?=
 =?utf-8?B?WWxQMFdjZjc1SHh6bDdOVGlPbE5Id1VHTWVxbGVFYzBMYitWMThXMm0ranc5?=
 =?utf-8?B?Y3VPa1RYaVV0TmtSaFFxa21RNHRhemU5ekRhVVQrK1FyVU03YS91OXB2OEZ3?=
 =?utf-8?B?S2ZOTXZNV1A2dXBRSzM2bWZsaTlBUE5valV0U3FBMW4wV2xxVzY2MDRrY0x4?=
 =?utf-8?B?Ukh4UXFjNk8yU1BBMzlEcHN3c0U3eE0xZzVvdDREb3V3Wjd4Sjk2UEVjdFI1?=
 =?utf-8?B?VHhPYmJsTC9oaXZ1Ylg5NnNGS2VvZG8ySWJ6bklUbmZjM1J2TEVMNzMzb3FT?=
 =?utf-8?B?cDZhbCtiK0dmSXpJdUJ4bmZpalVmbmhRd3JIbEF6QUw1R201cEU0UnJOMUQ5?=
 =?utf-8?B?QzJKbThyaFQwN2FvTytld1R1UEhRbFg0OXJta3RUYXd3My8yczhjNjJNSnNG?=
 =?utf-8?B?dGk2TktmUXdXTkd6STV0UjJFNjZRbDZZMHJLYnJyK21EQU5zUFBNcVRFcW42?=
 =?utf-8?B?NUM3OGx5SU5vL0JMRmpQVkRMbm5qU01HMmQ4SCtYZjA5VmdSRWwzZExEWEtJ?=
 =?utf-8?B?a1JqTHJVYUJVTHIwZDRodytEQ3JKK1IwRjg3NW9MdVVMYXdsQlFhOFZNSENu?=
 =?utf-8?B?eWFOM1JOZE5vL3BrWkxPMFpBcU4yKzZOMllaUEV6ckFiYnV1c1YvdmplejR6?=
 =?utf-8?B?SVlGOEc1QTVXN3NrNE9oRGlmMTFFaG1hS2pja0NzWlZjRTJobEVkeGtSRVd4?=
 =?utf-8?B?UGZidFp5Q2twajBsMC9mNXpTckplL3NBODJ0ZXZTZ2k1U0ZpWVZtK2dPUUJr?=
 =?utf-8?B?SDJWQVY1L0czTmhsYjdCZ3B1NDN6c2VDdVA0RElDcWFVYmt4UzBiczdGU2E2?=
 =?utf-8?B?QUVOUDNnTXQ3bU1obER6WC94VllIdWkvcGRFQVlZNDRKSHRxMkxQRXBOR1V4?=
 =?utf-8?B?bnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C3CFBB61437864E93F73FABBCA7A031@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	HQrhaVoTqJy2kgsjbAaLvMkKpN0P7d2iwdRO1T8JrZw6yHaOmzwPgB3ntkrteVQlY4KbhBpoLSNN6MbN1fCNMn4q8WQHeGHc64FCSw5Y8ZokZTmVjEbuIbUj4cTC5YkXWXyz9ljKJMG/w4ayoLj28Trl1qhA/0Dr8Bls48ghW3g75IFOL4IyNMlkkX+avkNHtLIr6r3dhg2quJ3HGuecrJ761i0jnNUQ/odSs6MAJoMLjUHPUw4IXBkQlQydCB4OS4RnUFE/ssNMsmR4kC5/AfsUIvpz21Cj+hfCoN+UAorXkchHB6upDySTeEhZFXPfxHm7eB8O2s4tayvwxhY8/oK4Z7VSpJIGEss0DxT8U8OV3W/lNyDnk+9kxg7iwVmNaV41yivo7YqXnrCiKYyF9YlDbcINGkq/6NvB5V2WSAMX5yfB9sygLESFw1iahBQiGttTHmfrR4WCjS5oUpe1wRGS0dPu/bWhv9dQI1emb8k5Cxb3/yCQ0CDAQfm9TcggAp8C94wHvRWka67bk+jb0d/QwDT/ILGSNkLrxPb2AFmT0hjR3p064MYeP9URUSfD3fNfbm6fNWameP2mbnAMlLiagjzE/WJLhzJQIrZ6KYfqNgRsWZ8kTtnlP9V2JOPSnUBXhVz1z6IMEbzzYhoPog==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0115321f-5789-4542-78b1-08dc6fb563c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2024 23:20:03.3273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gzNoq/SXgNdewO+pQ5WTa+d+BvupeC7nQ5mpKYA5JSsTORBoF6MitK52xdJ1DVpkU/rhWXQriujgDrIA/vur2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6061
X-Proofpoint-ORIG-GUID: p6ZDH9GXde6HpPjTcgCBiyGOk2V3oT0_
X-Proofpoint-GUID: p6ZDH9GXde6HpPjTcgCBiyGOk2V3oT0_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_09,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1011
 mlxlogscore=650 spamscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2405010000
 definitions=main-2405080174

T24gV2VkLCBNYXkgMDgsIDIwMjQsIE1pY2hhZWwgR3J6ZXNjaGlrIHdyb3RlOg0KPiBPbiBUdWUs
IE1heSAwNywgMjAyNCBhdCAxMTo1NzozNkFNIC0wNzAwLCBXZXNsZXkgQ2hlbmcgd3JvdGU6DQo+
ID4gSGkgTWljaGFlbCwNCj4gPiANCj4gPiBPbiA1LzYvMjAyNCA0OjA2IFBNLCBNaWNoYWVsIEdy
emVzY2hpayB3cm90ZToNCj4gPiA+IFRoaXMgcGF0Y2ggaXMgc3BsaXR0aW5nIHVwIHRoZSBpbnRl
cnJ1cHQgZXZlbnQgaGFuZGxpbmcgZnJvbSBvbmUNCj4gPiA+IGludGVycnVwdCB0aHJlYWQgdG8g
c2VwYXJhdGUgcGVyIGVuZHBvaW50IGludGVycnVwdCB0aHJlYWRzLg0KPiA+ID4gDQo+ID4gDQo+
ID4gSSBhc3N1bWUgdGhhdCB0aGUgaW5jZW50aXZlIGZyb20gZG9pbmcgdGhpcyBpcyB0byBpbXBy
b3ZlIG92ZXJhbGwNCj4gPiB0aHJvdWdocHV0IG51bWJlcnMuICBXb3VsZCB5b3UgYmUgYWJsZSB0
byBzaGFyZSBzb21lIGRhdGEgb24gdGhlDQo+ID4gYmVuZWZpdHMgb2YgbW92aW5nIHRvIHBlciBF
UCBldmVudCBtYW5hZ2VtZW50Pw0KPiANCj4gVGhlIG1haW4gYmVuZWZpdCBpcyB0byBtYWtlIGl0
IHBvc3NpYmxlIHRvIHVzZSBoaWdoIGRlbWFuZGluZyB1c2INCj4gZW5kcG9pbnRzIHNpbXVsdGFu
ZW91c2x5LiBJbiBvdXIgc3BlY2lhbCBjYXNlIHdlIHNhdyB0aGF0IHN0cmVhbWluZw0KPiB2aWEg
dWFjIGFuZCBzdHJlYW1pbmcgdmlhIHV2YyB3YXMgcHJvZHVjaW5nIG5vaXNlIGluIHRoZSBhdWRp
bw0KPiBzdHJlYW0uIFRoaXMgd2FzIGR1ZSB0byB0aGUgZmFjdCwgdGhhdCB0aGUgaXNvYyBmZWVk
YmFjayBlbmRwb2ludA0KPiB0aGF0IHdvdWxkIGFkanVzdCB0aGUgc2FtcGxlcmF0ZSB3YXMgbm90
IGJlaW5nIGNhbGxlZCBmYXN0IGVub3VnaA0KPiB3aGVuIHRoZXJlIHdhcyBoZWF2eSBhIGxvdCBv
ZiB0cmFmZmljIGluIHRoZSB1dmMgZW5kcG9pbnQgY29udGV4dC4NCj4gDQo+IEJ5IG1vdmluZyB0
aGUgZW5kcG9pbnRzIGludG8gdGhlaXIgb3duIHRocmVhZCBoYW5kbGVycyB0aGUgc2hvcnQNCj4g
ZmVlZGJhY2sgcmVxdWVzdHMgYXJlIGF0IGxlYXN0IGFibGUgdG8gYmUgc2NoZWR1bGVkIGluIGJl
dHdlZW4gdGhlIGJ1cnN0cw0KPiBvZiB0aGUgdXZjIHBhY2thZ2VzLiBUaGUgbmV4dCBzdGVwIGlz
IHRvIGhhdmUgYWxsIHRocmVhZHMgcnVubmluZyBvbg0KPiBkaWZmZXJlbnQgY3B1IGNvcmVzLCB3
aXRob3V0IGludGVyZmVyaW5nIGVhY2ggb3RoZXIuIEhvd2V2ZXIsIGFzIHdlDQo+IHN0aWxsIGhh
dmUgbm90IG1hdHJpeCBpcnEgYWxsb2NhdG9yIGZvciBhcm0sIHRoZXJlIHN0aWxsIGlzIG5vIGRp
cmVjdA0KPiBiZW5lZml0IGZyb20gdGhhdCB5ZXQuDQo+IA0KPiANCj4gPiA+IFRvIGFjaGlldmUg
dGhpcyB3ZSBjcmVhdGUgYSBuZXcgZHdjMyBpbnRlcnJ1cHQgZG9tYWluIGluIHdoaWNoDQo+ID4g
PiB3ZSBtYXAgYWxsIGNsYWltZWQgaW50ZXJydXB0cyB0byBpbmRpdmlkdWFsIGludGVycnVwdCB0
aHJlYWRzLg0KPiA+ID4gDQo+ID4gPiBBbHRob3VnaCB0aGUgZ2FkZ2V0IGxheWVyIGlzIHByZXBh
cmluZyB0aGUgY2xhaW1lZCBwYXJhbWV0ZXINCj4gPiA+IG9mIGVhY2ggdXNiX2VwIHdoaWNoIGNv
dWxkIGJlIGNoZWNrZWQgaWYgdGhlIGVuZHBvaW50IGlzDQo+ID4gPiB0byB1c2VkIG9yIG5vdCwg
dGhlIGNsYWltZWQgdmFsdWUgd2FzIDAgZm9yIGVhY2ggZXAgaW4gZ2FkZ2V0X3N0YXJ0Lg0KPiA+
ID4gVGhpcyB3YXMgdGVzdGVkIHdoZW4gZGVzY3JpYmluZyBzb21lIGNvbXBvc2l0ZSBnYWRnZXQg
dXNpbmcgY29uZmlnZnMuDQo+ID4gPiANCj4gPiANCj4gPiB5ZWFoLi4uIHRoZSBjbGFpbWVkIGZs
YWcgaXMgY2xlYXJlZCBieSB0aGUgVVNCIGdhZGdldCwgaWUgVVNCIGNvbmZpZ2ZzDQo+ID4gKG5v
dCBzdXJlIGlmIHlvdSdyZSB1c2luZyB0aGlzKSB3aGVuZXZlciBpdCBhZGRzIGEgVVNCIGNvbmZp
Zy4gIFRoaXMgaXMNCj4gPiB0byBoYW5kbGUgbXVsdGkgY29uZmlnIHNpdHVhdGlvbnMsIHNvIHN1
YnNlcXVlbnQgVVNCIGNvbmZpZ3MgY2FuIGJlDQo+ID4gYXNzaWduZWQgKHJlc3VzZSkgZW5kcG9p
bnRzLCBzaW5jZSBvbmx5IG9uZSBjb25maWcgaXMgYWN0aXZlIGF0IGEgdGltZQ0KPiA+IGZvciBh
IFVTQiBkZXZpY2UuDQo+ID4gDQo+ID4gVGhpcyB3YXMgYSBzdHJ1Z2dsZSBmb3IgbWUgYXMgd2Vs
bCB3aGVuIGFkZGluZyB0aGUgVFhGSUZPIHJlc2l6aW5nDQo+ID4gbG9naWMuICBXZSB3b24ndCBh
Y3R1YWxseSBrbm93IHdoaWNoIEVQcyBhcmUgZ29pbmcgdG8gYmUgdXNlZCB1bnRpbCB0aGUNCj4g
PiBob3N0IGlzc3VlcyB0aGUgc2V0IGNvbmZpZ3VyYXRpb24gcGFja2V0IHRvIHNlbGVjdCBhIGNv
bmZpZywgYW5kIHRoZQ0KPiA+IHNldF9hbHQoKSBjYWxsYmFjayBpc3N1ZXMgdXNiX2VwX2VuYWJs
ZSgpLiAgU28gdGhlIGltcGxlbWVudGF0aW9uDQo+ID4gKFRYRklGTyByZXNpemluZykgaXMgY3Vy
cmVudGx5IGJhc2VkIG9uIHRoZSBtYXhpbXVtIHBvdGVudGlhbCBlbmRwb2ludHMNCj4gPiB1c2Vk
IGJ5IGFueSBVU0IgY29uZmlndXJhdGlvbi4NCj4gPiANCj4gPiBOb3Qgc3VyZSBpZiBoYXZpbmcg
MzEgKHBvdGVudGlhbGx5KSBkaWZmZXJlbnQgSVJRIGVudHJpZXMgd291bGQgYmUgb2ssDQo+ID4g
YnV0IG1heWJlIGl0IHdvdWxkIGJlIHNpbXBsZXIgdG8ganVzdCB0byByZXF1ZXN0IElSUSBmb3Ig
ZHdjLT5udW1fZXBzDQo+ID4gYWx3YXlzPw0KPiA+IA0KPiA+IEhhdmUgeW91IHRyaWVkIHRoaXMg
b24gYSBtdWx0aSBjb25maWcgZGV2aWNlPw0KPiANCj4gTm8sIEkgZGlkbid0LiBJIGRvdWJ0IHRo
YXQgdGhpcyB3aWxsIHdvcmsgYWZ0ZXIgeW91ciBleHBsYW5hdGlvbi4gU28NCj4gdGhhbmtzIGZv
ciB0aGUgaW5zaWRlcyENCj4gDQo+IEkgdHJpZWQgcHV0dGluZyB0aGUgcmVxdWVzdF90aHJlYWRl
ZF9pcnEgaW50byB0aGUgZXBfZW5hYmxlIGZ1bmN0aW9uDQo+IGJ1dCB0aGlzIGRvZXMgbm90IHdv
cmsgYXMgSSBzZWUgYSBsb3Qgb2Ygc2NoZWR1bGUgd2hpbGUgYXRvbWljDQo+IGVycm9ycy4gVGhp
cyBpcyBwb3NzaWJsZSBhcyBlcF9lbmFibGUgaXMgY2FsbGVkIGZyb20gYW4gc2V0IGFsdA0KPiBj
b21pbmcgZnJvbSBlcDAgaW50ZXJydXB0IHRocmVhZCBjb250ZXh0Lg0KPiANCj4gU28gdGhlcmUg
aXMgcHJvYmFibHkgbm93IG5vIG90aGVyIG9wdGlvbiBsZWZ0IHRvIGhhdmUgZXhhY3QgZW5kcG9p
bnQNCj4gaW50ZXJydXB0IHRocmVhZHMuIEkgd2lsbCByZXdvcmsgdGhpcyBiYWNrIHRvIHJlcXVl
c3QgYSBrdGhyZWFkIGZvciBlYWNoDQo+IGVuZHBvaW50IGV2ZW4gYXMgd2Ugd2lsbCBwcm9iYWJs
eSB3b3VsZCBub3QgYmUgdXNpbmcgdGhlbS4NCj4gDQoNCkRvIHlvdSBoYXZlIGFueSBkYXRhIG9u
IGxhdGVuY3kgaGVyZT8gSSBkb24ndCBzZWUgaG93IGludHJvZHVjaW5nIG1vcmUNCnNvZnQgaW50
ZXJydXB0cyB3b3VsZCBpbXByb3ZlIG9uIGxhdGVuY3ksIGlmIGFueXRoaW5nLCBpdCBzaG91bGQg
YmUNCndvcnNlPyBUaGlzIGlzIG1ha2luZyB0aGUgZHJpdmVyIHdheSBtb3JlIGNvbXBsaWNhdGVk
IGFuZCBwb3RlbnRpYWxseQ0KaW50cm9kdWNlIG1hbnkgYnVncy4gSSBtYXkgYmUgd3JvbmcgaGVy
ZSwgYnV0IEkgc3VzcGVjdCB0aGF0IGJ5DQptdWx0aXBseWluZyB0aGUgaW50ZXJydXB0IGhhbmRs
aW5ncywgeW91IF9tYXlfIHNlZSBpbXByb3ZlbWVudCBkdWUgdG8NCnRoZSBhIGhpZ2hlciBjaGFu
Y2UgYmVpbmcgc2VsZWN0ZWQgYnkgdGhlIHNjaGVkdWxlci4gSG93ZXZlciwgdGhlDQpvdmVyYWxs
IGxhdGVuY3kgd2lsbCBwcm9iYWJseSBiZSB3b3JzZS4gKGNvcnJlY3QgbWUgaWYgSSdtIHdyb25n
KS4gVGhpcw0Kd2lsbCBhZmZlY3Qgb3RoZXIgYXBwbGljYXRpb25zLiBMZXQncyBub3QgZG8gdGhp
cy4NCg0KQlIsDQpUaGluaA==

