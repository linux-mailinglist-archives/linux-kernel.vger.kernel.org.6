Return-Path: <linux-kernel+bounces-199872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B308FA70B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 02:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5644B22814
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 00:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F295979CF;
	Tue,  4 Jun 2024 00:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="nMwAaraT";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="MekKov4b";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="hpaQxVzo"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF70182;
	Tue,  4 Jun 2024 00:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717461050; cv=fail; b=XE/ldQDXn7KXj4Ca92lqPGcgriPpQkqdd2dtwWKsNqV6EjRXVizcHiKtGEFu8cGSTq3CIFiKhRnoeh1IlxQ10BzMy/Nr2zDd7Wea4J5cQn9eF4MK/zdSuVDv+8Nqdlucf7c4NgSYFI2UetnzXJNPepqPZbAYAqc1jYsT29U2ZBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717461050; c=relaxed/simple;
	bh=3bRZTKsQh5h7nY34hSmORLnZM0pB4AEv91liLL4+ohY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tGYUNUltLX+O/QDMmzF5LRM2Z4v4JtIoWdZGNf041HjdEm0Td866iPIz2k8vU9F7YxQKEGovbwSfgqlETatUn8yXguLbHCpesRS2WmduM/6I4QwQFlzVP0VAEv/s/3l3z9BhXlBVKV9EKg0a7H7Yy8Znfrs58tcsW6qngfw/Oso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=nMwAaraT; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=MekKov4b; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=hpaQxVzo reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 453Nq0sJ016199;
	Mon, 3 Jun 2024 17:30:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=3bRZTKsQh5h7nY34hSmORLnZM0pB4AEv91liLL4+ohY=; b=
	nMwAaraTMyuzvz8T1yid8BPc8JSRusG8MrFnUoyWfw5LPDuell1rm+jdftS9RRJK
	ccOx1zYQlrkErEZRK8YKaGn7z3xKziS57QFjw0h0Pve3BdDECt549W0bqFy8xB2e
	DG6hppK8arWmNxpO2oJXCbUSKZi9O9CTQYalOlB3lP6gDjkN0BZ5KmgQnxEPuVIu
	blg8PCnzl8NECqXzoLPIY22tlaavdYrHyGAbiWnDHl2lUnzl4zuuDcxT2jxIr4KL
	l4DY413T4j96G1RubpP/mfT6W1cqU1nSmELcG+TExnVxaIcEpk6cnj+UFZmcXb+N
	KT+iLCC0lk8j322uUQF2DA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3yg2nj9aka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 17:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1717461041; bh=3bRZTKsQh5h7nY34hSmORLnZM0pB4AEv91liLL4+ohY=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=MekKov4bZHZEJd4kH7S+oSjMZWnp5ZO+yuAKCh9fBvF7TMS264gbyHLbmjrMgye8g
	 Fwhlca+gF1YOOUKJI0dUmRSia5Rb6GRu4fCZ9nPWt2z2si6SQMtGyZucK46AU4fe0v
	 45yQy/1N0i3GJokx0HyVTy9wcwhojg113FdAr10sOj6PLdUJAgnOAaqaU530746jK4
	 3H7H2EctLBNIgf4GOuTW4Q2PPIHavvhW9v7bE9iEmPi8blZ7j7K0MLb3VTeCb4hshb
	 QMy0T70u6+LVhxfqLYqYFk1QUQ10ZVbiSFG+dS3rctIGVIaNxcT4y7o3SBsVE00tBy
	 315QcgQfkIUtw==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 30FC140141;
	Tue,  4 Jun 2024 00:30:41 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id CFDB8A0081;
	Tue,  4 Jun 2024 00:30:40 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=hpaQxVzo;
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id A7C0B40218;
	Tue,  4 Jun 2024 00:30:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XAz5CxH6wNvN0GRtdZNU6bnvrv3U8rWyt3bHKLBzZscNgqQ7yoF7dc6QGP+Jcuyzdbolc/bw/1s1rFYU7/2KGf+5FmqDIOWHYXVYUyGiM6D1NgFAgIder72ij4KKNA9brPWX0dDm2ZlqFfr7QiJ28aaZ3/Y1xqbDuv6LHSktc0izWFFheS9xCpGTVlh4QAIiH4ygmhqPB1vE0qTHPvvCu651ifHIMVlN4kpoewgZ3QLI4EIj17eYTB1P/MwK0HVRV3+Jss8bbrhU95ttuzuk5NUBFT3wepiy7MWQVlEbhhAHrTJTUXzB+oJXEA++5VGn83W+PyZigdJPNmTPp3o/Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3bRZTKsQh5h7nY34hSmORLnZM0pB4AEv91liLL4+ohY=;
 b=Q7l/IfDi2b5t8nVI2W3gKZUwlnMl/Lt15CsoQj3skEa2SWC6WWwYCsKCu3vIXP6w01KzAyeo+tPbI4GX8ahPYI3wn12GRIjz+r6aLELV7fc4oq9RM+6VvYeke4EDW51FInmJCBjUJUfQq47i0YZX3JdZK1EuL64v5qLNUj7i3i+kw0uSdM/I9lFT/RUfnW6CmAk1dYGoGspo6XFagrokNLBv1vIClV2g1e2XETMYu66YNoyr9kvp/gSVmdszx2mamxkoOVuqGj1NCUpYd7fdD3sfvFzoKn076C5dtlvr1/r11WImV/4o3EEoGtkEiG/40E28PBPsGM5xzmszi1rwtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3bRZTKsQh5h7nY34hSmORLnZM0pB4AEv91liLL4+ohY=;
 b=hpaQxVzomz92k1u27eIS/4pqy9cIeuFmAiBqiJOBRb+/S756Ao6/e0p48UImEosiPN6/txvzB3bX1ce5ITY85aj67uUYkqInmdSk07lG49V1cs/5hZCId1YYqZxddTi/ESifiQpLJBYYYEtPwykjBZ/VI1pnNyV0M0yDxCLtghM=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CH3PR12MB7714.namprd12.prod.outlook.com (2603:10b6:610:14e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Tue, 4 Jun
 2024 00:30:32 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.7611.025; Tue, 4 Jun 2024
 00:30:32 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Jung Daehwan <dh10.jung@samsung.com>
CC: Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE  TREE BINDINGS" <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] dt-bindings: usb: xhci: Add 'write-64-hi-lo-quirk'
 quirk
Thread-Topic: [PATCH v2 3/5] dt-bindings: usb: xhci: Add
 'write-64-hi-lo-quirk' quirk
Thread-Index: AQHasyDkOGkz1EXDA0mTTYgonW1KybGw/i6AgARpb4CAADjrAIAAGHAAgAENgIA=
Date: Tue, 4 Jun 2024 00:30:32 +0000
Message-ID: <20240604003013.2jwskwiqivgumrsx@synopsys.com>
References: <1717135657-120818-1-git-send-email-dh10.jung@samsung.com>
 <CGME20240531060729epcas2p1df12dd3b14c5fa2fa0716f72010b3dbd@epcas2p1.samsung.com>
 <1717135657-120818-4-git-send-email-dh10.jung@samsung.com>
 <bcbff3b2-c5ae-4a95-aa36-f9b88a97e72c@kernel.org>
 <20240603033427.GB23593@ubuntu>
 <69c954ce-d7a2-420c-b3f6-72caee02d84f@kernel.org>
 <20240603082538.GD23593@ubuntu>
In-Reply-To: <20240603082538.GD23593@ubuntu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CH3PR12MB7714:EE_
x-ms-office365-filtering-correlation-id: 3d7c15f0-5575-460e-39bd-08dc842d8b7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|1800799015|7416005|366007|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?bGp4Tm1kODFTdXBtbVJTTXI1a25qNk9JQnlOdzUxWGZkK1UxYXhvVUw4L3R4?=
 =?utf-8?B?WjBYRjROWE4rNjBqdU9sOFMzRGZiMWFoNGE5aGtJY2NleDhoRktIMmg5WWcy?=
 =?utf-8?B?eUVTTzdjeERZWVhVVG1jOFoyOGRQZnR4Z3hFdEwwWlMyN0RlZ2ZLZHJSenFL?=
 =?utf-8?B?NWpsUUhwTlZXR09PamhoZDR1Ym1TL3RObndjTmtWWlY2cEtvMGZUZU1IWXFx?=
 =?utf-8?B?cnZhSDd3ZzlTNlhLS2pNQmxEVndtdzNTcmFZaFhROXpONXNaYnNPaW12OU0r?=
 =?utf-8?B?UElDUVVrVS84VWVyZEgreENKd0dlbnJDYlh5TFJXOU9YMVovaFgvZm5pbXRV?=
 =?utf-8?B?ZU1TWnRzNEpta01nakZtSXltSUx1dFdjbVhyVUdCMlVJUXNHNW5aSzBqR3Q3?=
 =?utf-8?B?elcrWEJYelVpUWVvZjdqZ3lrQWlzQU8xazhEMnVJQWwvSWpnL0kvUDNRbmMz?=
 =?utf-8?B?NDd0OURHWk1nMVdyUW5UTW53dW5KR3VZMDlYQzBINFpqMjVmREhsclcycnpL?=
 =?utf-8?B?aXlEMWlwMG1LOHlMK1VXb1V6bmFtcVRUVlVKdWJCaVJGY2krTXNLZTdEeTIy?=
 =?utf-8?B?TXlMUTF5U3VkYi9BMDk2L3FENVlhUnBRaUwrRDNWN1QyMTRYbXZKTUxWTWJa?=
 =?utf-8?B?SVgyUE8wRjc0c2xIUTVsdWk1b093YzFKSmpwci94cnJRMHQ5VDdUWUFXT3pP?=
 =?utf-8?B?VXVYcFBLMG1ORDdZY2VEeUlRMmIwRWxlcHlaL3FEK1krTFBwcFViclRCTWI4?=
 =?utf-8?B?SWZzbSsrcjFYRXhnVWpSTlpWajNFTkN5VTA1UFR6NnoyRnFNZjQvdXlQTG1y?=
 =?utf-8?B?QW1TaEFqdUozWWYzSUtxYU5meFQwczlnb1o0ZmpCMGNsWFBlR1Q3NjlxcmNh?=
 =?utf-8?B?UDZZKzBGVGlLblRVTUtSUmdmSHBMb0lMRVVkcUFBYmdRR0gvOHlGNDFPUnFi?=
 =?utf-8?B?d0lxK0ljcTV4V2pETUhxaXQ2cGkxYWcvR2NlQzFNYWI4VytHajBnbGdUNlRx?=
 =?utf-8?B?WFdDWWltdEFyaFIxY09WR3IzemIyK0ZWSHhNQk15b1VONFVvWXN5Y3NLdGs1?=
 =?utf-8?B?WGtEV1JDOThpb2g3eWpKWkNESzNObGI2TE1EY2hSVGs1aitoNVJMZXQrM1Q2?=
 =?utf-8?B?Qi9OUjRwVU5vTDExVEZpTnIwUzhzWGlEVGMwQTR4UHdpV0VBVVZxZVIwNld4?=
 =?utf-8?B?RE9YMXhvYmdVeEF0eUc5ODA1UW1WWVJZS1ozS0dhYUk3QVVDSGxQd2JNKzBM?=
 =?utf-8?B?elE3MWFiUHFrZTcvTlh6VVl5TGhDdkcyR1lXMUJ0dTY1MnJSdEk5bFB4R1Jj?=
 =?utf-8?B?ZnBUWVMvQytwWThndnZ5am5TeWlyUTRGSFZuaGhzb01yU2xTSmFEWUgwTGE1?=
 =?utf-8?B?b1k1VTBsdHhDRkM5bWlZM1pVY3F3M1h1ZFM5L1cyT0w1VGdLTDVacENCZ281?=
 =?utf-8?B?TGE5MXczV0crc0tnVUJ5eXYvSUlkSURScGFnZXBGRnZ5MTF0OXlrM09RNktO?=
 =?utf-8?B?bDl5N1V0enlCTGRHdW5IL2hLUy9PUnlvY0ZnTCt2QmJDMkhjN2JIb21BQzRK?=
 =?utf-8?B?c0QwNHcxVmhscCsyM2xWU3FUSmRWb0lrYWgzZXNlM3NNREZEaWhMTXdQRDJN?=
 =?utf-8?B?Vm9WakdUS04xMm12eHZJQ3BOTnlOS2ltNFgvSUZtNXZac0tzMWExRXhjTitE?=
 =?utf-8?B?VWZTL0krVDhUM2hpUDJRNjBmVlpxOE9zNHhrUXhMOGxmUCtDNjFUV3hURkVD?=
 =?utf-8?B?Rmh2NStXMGl4U2hxVHh5RE9NejEwKzZkT2ZqRXU4SXQzNktVVmhvTWtubEtz?=
 =?utf-8?B?K0Nhbi9zanlhVTk5K1dlZz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Z3JscVBrc2c2MzNURHdYaThQRDhsemRiU1ZUNGpOM0dXZTlnTHdiS3Y3WmJJ?=
 =?utf-8?B?NThmTzRjRTYrUkpteGhYUVE4b2RpdWg1TVZ3bW5zKzduQ2Qra0hNSFpvN2Np?=
 =?utf-8?B?cG1Oeno5OTh1NCtPc2J4ekh6NThqbGxqMnEvTmJGVUdrazdXZythbzd0R3ls?=
 =?utf-8?B?TXl1bWZZeFpGV2tIS1czT0dpamFtdjVpS0FtMXpIVEYyVGw5WHkwT2hWek9D?=
 =?utf-8?B?clNYVlVoNllOQjdBZDRzK05WaHdtRXJDU0lDdEFXYUlhY0hscTIxNFp6TDN3?=
 =?utf-8?B?R3hyc1BRLy8xeGZVQlcyOTRwUUJUNE5oL1dDS1p6QUdSQmpFSDkyNVBhR0JW?=
 =?utf-8?B?U3lsNVBON0NLUUpRKzlNUkhON1M3OThtdS9OenU2RkFSbE5qempVekJtdWJj?=
 =?utf-8?B?dGljTEIzQWZiL2VmbFlId0RYeUw4c29nOUZWQ1VpREJNU215M1ZwNkNTSHpu?=
 =?utf-8?B?R0Q0TkZUUXdVbm5KWlJtOUwxd3k3VStKNWRyUnRPOFpOcDJEc1JFT0wwaEVJ?=
 =?utf-8?B?UTRGSnoxaDVlaVJMTS9VNXFuekFxNVFQVFhNcWRwa2VmRlE0azNab3dBUk9q?=
 =?utf-8?B?cHJWaE1uL3kva3pnNHZjYUNXYjZRSm1YS1d4NW5TdTI2S2VuNUFHcHAvb0k3?=
 =?utf-8?B?YzBVek5GWHpBcldoSW5LaXAyc0ZDWnFtZXc1b282NmxFQlZBVERzNWlJSGJZ?=
 =?utf-8?B?NDJSWklvc3VUcmRMeTlzYUZ6NEdNVzZhSEhxNWVJOFFGMXJrOWQxSTBVVkJx?=
 =?utf-8?B?ekxKVWJwVDFaVnB6U2pheWt1TU9MVUR2eEovclhpaWhudDREZ3VES3RQc01z?=
 =?utf-8?B?akZpRzMvRlBZc1FzSURMSXpqa2JLYlYwWjZRZUwzTFQ3RW5Jb0tTam52Zlpp?=
 =?utf-8?B?RkJHbmVpUlJtL1VGL254aDhNQkNZdCtyNzNySytsTndPMGt3VFhIY0JWd1ow?=
 =?utf-8?B?NlVWcGFBNkpjbk5yTjExdzJGdW9OU2lrYmFXTHlFZ3VZbDhySnZpWUxrTkk4?=
 =?utf-8?B?aU90OGI4MjhmMEh1cHp1eXpYd2UyZHM1eEFnNjB3Y2RvRzhlWGRCUWRYZmFx?=
 =?utf-8?B?SGQzbW54YkhlVnhaY2FuR2g4TERwUVRreG5FNTdPLzYxbjRVdmt4RTI2NmxB?=
 =?utf-8?B?c1haZllpamlZcjd5ZzZaZVFBY2h6UUdhaUJYdFRBYzUvNGRqOVNBNzBCSlhh?=
 =?utf-8?B?ZUZRUDI1c2pFeTQwU2JZeU9rWjVWOXdvVThlRU5kRkNicW5ZeTRhUFFjeGEr?=
 =?utf-8?B?dzVPZHVhK3Y1QmE5ZWt3a2ZadTh5TW1FSmhNc2d1eWFOeEUwa3h6WmZjZnpP?=
 =?utf-8?B?ZVJBaWhUTEdOckRpSG85N0ZJY3BOeWJBMUREQWdoV0gzWkJFbkE5YjZuM3FC?=
 =?utf-8?B?cWphZGs2RGpuMTM0RFd3ajdUWThybGZqU2pXMmY3Tkx2a0JSUzdLM3UwVVhi?=
 =?utf-8?B?MFZFVEREYXRyQ3NmRXc5TmZTWTBwYjNwVnRyQWkxbnc5NnNFdHptb0puUSto?=
 =?utf-8?B?KytFcjFoWUhycmJSN0ZZRXNpVU1GbWs3REFTdHdLZkdsMHEzVUppekdYYnNV?=
 =?utf-8?B?d25OVWNKdW5KWVZYUjhsMDZGWHJmbEhhYld0TFJCUHVGdHV6dmRBMWExMWFq?=
 =?utf-8?B?ZHUzclo5TW5wTHV0RUJsM3pKOHpqQXcvTVF1ZGxGTmJ0dHUydy9oQ0h0T0M5?=
 =?utf-8?B?WmlyQVJzOGhOS2IzM2c2eVZ3TWE0T1dITzF6dEtPMGd5WHlUWFF2QTJLc0xC?=
 =?utf-8?B?NkNkOTh5TzhFRzhSTk9Xc2xxWG5ySjIwbGF0b2RhM0k2T3JYcTllZjJsV0l6?=
 =?utf-8?B?Um5kaWNZcC9mM0lEK1pFMU04VmRRalRBZFJ3RFVxNVNFZnVLeno1SVA0aHNY?=
 =?utf-8?B?d3hHT2RVMjZ6K29rUC9UMVY0SHpYcHRtbGRJQjhiM0pPRXA1R2s4R0oxQzVl?=
 =?utf-8?B?MytvTlhkbHg4MTVBTU9rL1RHbXhuaUVSNlloZ2pIQSttMDh6WDNVUS94UHBZ?=
 =?utf-8?B?RDB6elNBV01ac3ZvemdjbStzbXZnUU1MVnV3NW9tNlJjaFZPK0krUFRPay9j?=
 =?utf-8?B?QVFVSGVJc2xUYklFdm83Y2Y5eEF5Y1lDWVFVM2RidzhrT0RieXFFZzNzZUhP?=
 =?utf-8?Q?ke1K0g3OsiEHdE7G0C9UVrXIB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6AA15876471C2647872448A347E4FDDF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	wJcNe5QWGb5wh8ADyhfpJG9VtYUaypmF2IXmZLawbHz+ogACUXXX+byYSgV22TA5otcOmIOQm51F2Wk+jO11XWlRuNk0XniMgLBiiNhLhsp/0tK+mNpW6xHKCeaJDvCjLZIvr3pG+rBquXP9ic21fZoEnw8eVRuTBm6mPtXVSlOig83PSjSgiulN3776qAlrVZimeCCyzpnrgzksC1E8QcfjS69gtW6pm/2EEpnUTMcCcOwnUQsDurwlyIeFhzVOmKJNUMRnqp9SnFNOaj1y6Fa/8B+VFYZQHStQtwjeQQSqwsvsL3ltJr98lfwDe3uKJ+ZEhhw/JWv0OS+CDdA6Za/UmFMC1j6LnV3epdMErl/2ajuddeIp6BI4sSmTapfnuLlN8FKElznSg0S3GE+jt3ddtHhSNiEqhK5KHdSvCxfHZmf7sq7hGfKZ+bN9bv9gdTurlP4G3okCTB3c52R34tpdoYNpr01rpuQnpLdp+o7q+qbI/MYd/7fmvm/U0N6yk0eDIASVzcio6cSEFdLQ7AABXBQS3PMXXqeGFcGVeEg+3h17lGFQSEJo8CjVCmPTljgMW+XGtv+TENkcYCLSU0sPgBB30WrTuWwR07U8UoeSkL5I8dO8BvRuxNmd7ZHcnAVdNo4AibmD8HE+9xjUeg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d7c15f0-5575-460e-39bd-08dc842d8b7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 00:30:32.8472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q/fNN8J0JnnNsOv0iqTEB9eXk5rUOskpGTFYTUMIn8jB3mmVhbCIiGhkszzDObvMppGgmmka8Cq8B/2AYgOMFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7714
X-Proofpoint-GUID: uA1a5xXYJPBhX2BZnlTJQRTgiRk2cVEP
X-Proofpoint-ORIG-GUID: uA1a5xXYJPBhX2BZnlTJQRTgiRk2cVEP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_17,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 bulkscore=0 phishscore=0 adultscore=0 impostorscore=0 mlxlogscore=509
 suspectscore=0 clxscore=1011 spamscore=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2406040002

T24gTW9uLCBKdW4gMDMsIDIwMjQsIEp1bmcgRGFlaHdhbiB3cm90ZToNCj4gDQo+IFRoaXMgaXNz
dWUgaXMgbm90IHNwZWNpZmljIG9uIFNvQyBzaWRlIGJ1dCBkd2MzIGNvbnRyb2xsZXIuIEkgdGhp
bmsgaXQncw0KPiBiZXR0ZXIgdG8gYWRkIGl0IHRvIGR3YzMgZGlyZWN0bHkgYnV0IEkgY2FuJ3Qg
ZmluZCBkdHMgZm9yIGR3YzMuIER0cyBmb3INCj4gU29DLCB3aGljaCB1c2VzIGR3YzMgd291bGQg
YmUgbmVlZGVkIGluIHRoaXMgY2FzZSwgcmlnaHQ/DQo+IA0KDQpUaGlzIHF1aXJrIGFwcGxpZXMg
YWNyb3NzIGRpZmZlcmVudCBEV0NfdXNiM3ggdmVyc2lvbnMuIElNTywgeW91IGNhbg0KanVzdCBw
YXNzIHRoZSB4aGNpIHF1aXJrIGZsYWcgYWxvbmcgdGhlIGR3YzNfeGhjaV9wbGF0X3F1aXJrLT5x
dWlya3MNCndpdGhvdXQgbmVlZGluZyB0byBpbnRyb2R1Y2UgYSBuZXcgeGhjaSBEVFMgYmluZGlu
Zy4gSG93ZXZlciwgdG8gZG8NCnRoaXMsIHlvdSBzaG91bGQgZXh0cmFjdCB0aGUgeGhjaSBxdWly
ayBmbGFncyB0byBhIHNlcGFyYXRlIGhlYWRlciBzbw0KdGhhdCBkd2MzIGNhbiBpbmNsdWRlIGFu
ZCB1c2UgdGhlbS4NCg0KQlIsDQpUaGluaA==

