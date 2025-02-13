Return-Path: <linux-kernel+bounces-512139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08332A334AF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 02:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64F8A188A2E2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 01:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6F513AD11;
	Thu, 13 Feb 2025 01:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="MrSe6NdK";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="gioBMXds";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="tFkwTAI9"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDA87082F;
	Thu, 13 Feb 2025 01:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739410100; cv=fail; b=T+OSSD0Rk5JEcP4Wf//+KhFUu+FImfsm+vEy/khIWMwUmYaNgCR9AX1119NmwJsjHPFiJ/vIjmvBOa1OEw6HKTCb/Y9z9rVqkCEgZM6YLJbRSMfSDK+hWzWMRaJ42fz9K9kCoFRVdr2fihanKH9yArUM6h9yu+XfHRd1X3rU/xk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739410100; c=relaxed/simple;
	bh=WS6JI5bhaRU3TI3yWPaPyWI5yz9HELexeVk4BJIwhqg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a4BQIvCUeyHuxnFAcFuA2mLO5ewuq1aaaI/YucOCWGOBrX3ru+E3w48/QlZtJ4j/JCm1sblUX7OSpzzfsQfVr9Ma4PS7WmqahA2C0YQYg0jYODZfXMN1ozYeN6BJDBnnMPAbIzKAUymdGuqf+1pJTJEXyMTWRoqbCSnDg4lLyV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=MrSe6NdK; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=gioBMXds; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=tFkwTAI9 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CLo2Qu026228;
	Wed, 12 Feb 2025 17:28:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=WS6JI5bhaRU3TI3yWPaPyWI5yz9HELexeVk4BJIwhqg=; b=
	MrSe6NdKzddRoq2hPWaFr/5XF/tOvCbTfTbr6Xs89s0fRL3JNN3EXqWh4qWYjhke
	JiTwg0sT/hekTlPjgF7I3FYO0cWHkPUvItUJdaJ7a7LZQn3p6bbwK6S/tNSa+fxs
	TZse+eyQE+geM7yea1ig3S1B433GD83CKKMwhkFnKjwuY2sviFEmN6g/4y4w8P4a
	CRmE8Av5VgokC9G4Bwg9TGQF+uT++yGjGNNKZVLqnj8fFJIMuSc7RdjWMrh6R+6Z
	EuPb4Yr1Qxk9onQeh1zj0vs7jxu5Njp/0+UPWxiWEKBCB5fYP39BLQfQvGEIcKa+
	V6thZSKAqiJ2ufERnnU6OQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 44qhduh3bg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 17:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1739410095; bh=WS6JI5bhaRU3TI3yWPaPyWI5yz9HELexeVk4BJIwhqg=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=gioBMXdsQmkggajS6OULX76V3QliToMBSieW8yJzvIEyHzhr7R9NEuZm5mJHvPipr
	 NFnxgX6PyFnHAnTZKysWQ9tjCOs3o9QhJ2MXIsJU2IflCRtxGW0304mpIx2nxVn0RC
	 v4eNoCm25qvCGuYM4qrbcl+dDa5aBlpZ7kPjDE7J8KjfON4v1GLF26kQ0kiUd0PxMb
	 ag2kROdojIk9IAzg0/RpCRMmHMGa6GMzziur8tI4gIqozuZBp57Z6Q7H6Pi0IvZRH5
	 UhZrnx90bbKaqlK1BWitS8zj7n7i30MvrBOvqBKKwrqiIAlILvJbEJ3Kd2p6aYONYX
	 gMEe3jJ1thZNA==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 71DD140567;
	Thu, 13 Feb 2025 01:28:15 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id C4B44A00AC;
	Thu, 13 Feb 2025 01:28:14 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=tFkwTAI9;
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 0E80D4048E;
	Thu, 13 Feb 2025 01:28:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RY0NHEaIG+kXtYz37Mu+fDg8WRytYrLSgVRzFfUNCL4EUTcrrusVZclYVhQbbJomGUkcPPnjNzHxhGktjAXbRlm6T41TBFu3F/Rqn54p7aKNVgZPWban5G5ozvPF+fAoK1Cu5F2BtFn3JxWE0KWPNdSwwE7Nd8IMJ/+9zes83IyQHCuYCwIFOZHUXNnHgUYfbChecUZ0KbpuTazmZDNpMHYcwLQyZKL30FLakNDLIox9d8ZwiXlFZ1QYO+RNeRXsn+8iUNNFHfaKz9nR+txm2452orQxf1ZFpun/kUFZ+j3DaCcJs65zMvpGXXQw8b8dk0iWtJJQQWmxjugEXJfmTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WS6JI5bhaRU3TI3yWPaPyWI5yz9HELexeVk4BJIwhqg=;
 b=pehGo6H49s9xhggWJEj1wU/XHGbt8UHva36DNl13Kcbf8jbjQdnHVbS/UkcrGv794d8PzV947g+8Zl8EyDsNLQKqgCEFh5L1CGh4+xUDxnPSqf9uXjxSRbekYG4ajgbDD4rd1zB34Zw0jBp5vNgrr/j/80Dj3VnJld9uAIYP01ZHP6YobRFLrqRVv2ZkoFvKFtnpQBQtinrR/mJhRuhUC8Is6onJjwbkttd+rVYuDS4nBRcc11ktqjEiaubXbUqwNnfVVUY6jgfrx6+kacLfVuhE1mwR2vsOyzJ9x4sQ7j/Sn5UDD+rOhrNJVVvIq+iIn0uQWrh6y9ud6TaPH0eBlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WS6JI5bhaRU3TI3yWPaPyWI5yz9HELexeVk4BJIwhqg=;
 b=tFkwTAI9I9vPkup4NrWDnRx8GkkBrcazMc9HKyQIdnRrD5TFeaCtm4oL8BMcElD7W4jcpvUQi2jm83avgXFgtLTD2fTx7Ot9ak3AqcNqzX/LnfbpR2vPcheqsf7+VfMRiv5EjJf8AnkCVqXq24WLcG1bGNZUJj351jws/tSmhoI=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SN7PR12MB8770.namprd12.prod.outlook.com (2603:10b6:806:34b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 01:28:10 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 01:28:10 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] USB: dwc3: Use syscon_regmap_lookup_by_phandle_args
Thread-Topic: [PATCH v2] USB: dwc3: Use syscon_regmap_lookup_by_phandle_args
Thread-Index: AQHbfYzVvxDsCVRoa0mfIvNyJjmM4rNEcfYA
Date: Thu, 13 Feb 2025 01:28:10 +0000
Message-ID: <20250213012806.6gtbrnyyaesyfefa@synopsys.com>
References: <20250212202913.23443-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250212202913.23443-1-krzysztof.kozlowski@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SN7PR12MB8770:EE_
x-ms-office365-filtering-correlation-id: 9d8b7b79-5b5c-4c2f-024f-08dd4bcdad6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SjZ2V1VJZEJQSjJNaUwwNTRvLyt6OCtUSUZWTmhNWkl3NHl5UllqcVc5cW8y?=
 =?utf-8?B?UkhreUhrSis5bTd4RmNjTTJRTEFtR3dDTGFmQlU5N0ViTVE1VDcrMm5GTFdr?=
 =?utf-8?B?TnF0bTF4WURyby8xc2lvNXlYc0pZaXloVjIrYndrNUVDdElHVlcrZGxaUzg1?=
 =?utf-8?B?YU9GUzNEckVUSDY2Y2tobE9XWUt5Vm9mRUdIOG9YeERhME1IVFNuKzFPak81?=
 =?utf-8?B?V3FnNXNoTUNkNml4T1FCN3NvU3dkTzl1MWZPdUNyS1AxTDlrVmlQSDl0SFhF?=
 =?utf-8?B?UDZDaVAxTkRFbWpmUmdFMXpITFNIVEtrOWt3ZjgxbXpITnpXSzN1MmpKZy9i?=
 =?utf-8?B?Wk5WL3VFNVpKUVJLUEJNN1A5dmlORFJjYkZndkErRUVjaWxxRDduTFMzRDZ3?=
 =?utf-8?B?aWlaZDFBUERUdjJPbUVkM3hkRjMwZ2JTMkNrdndkZHZTNWdzdHF0bVFGd0hk?=
 =?utf-8?B?TnhxKzdnSXZySEJsRDVxNGhQOS9Dd09UekFUQlQ0MjJKNS9ucTVtYkNmeCtu?=
 =?utf-8?B?emEvZVIzb0xaRENlTjdDTSt2Z29nL1BoYytUR0hHa0hYQmpzUDZqcGFES0Fj?=
 =?utf-8?B?aDhCSG53eUkxb3ZVUXdJdCtwTHA0UWozbGNhaFJrQkljRWlBQTR3K3pMalRk?=
 =?utf-8?B?N2tob2VTcmxpODR5MG4zRk1VeHgyZjR6WGF6ZkFFTFk2elVldVNGOXMrZDZ3?=
 =?utf-8?B?QVJMUDNmRCtVVzZwVjN5SUJuT0RkOVF3VzdHRTBiVURBL1N3T2tIRldTTHlO?=
 =?utf-8?B?cU12RC9oMFk3WTZrKzV1N3JyT1g5S1F5ZUM0QXVTUWN4QVpQL29FOXo1akc2?=
 =?utf-8?B?ZXRORW1LUXBQZFlHSVVTVkhpNHJpSVZCUWdNVnA4SEc4VEQvYWpreWZIVVJu?=
 =?utf-8?B?VnZRK2o2dGVFR3BZN2hxVDZ1TEIrdTkrS2JmWXF4UnVKblh4eThwRDlsSzl4?=
 =?utf-8?B?bHhMOSs1dnFXYk9Uekl1R0x1NytjdFROUis1WFNXR29CRThJMVNBRk5hNHBr?=
 =?utf-8?B?Q1RHN201UUZMMWVPVEE5cU9uZnpOTEtES1p5OStDQnFOQldGQmFHY1NBekl1?=
 =?utf-8?B?WHBPZFc4R0U2ejJlRlFYRDZuUEZtRU1IQisxU1lOd2NPdmQ0alNSb1Z0dC9H?=
 =?utf-8?B?dmZRNDV3WVhQTzVDTzdWUXo4NFEzSnJZeHFjNWYzUWlnaCtPS3Z1OXpJczhC?=
 =?utf-8?B?c0dBVWQwekNGNVY5S3NEYVhhRzJqbWxrd0x2UGZtZEl3bFF0TWRQOVorNFk2?=
 =?utf-8?B?SktCRTk2bzNkemREb3BnY0prQ0FDK3lUMnNvV1VMajVHU0VHeCs0U3hFMjQ0?=
 =?utf-8?B?TkdYNmdPaHY1Wjh3dG9qYmpnS0VUWlpseXUxOHRocncwM1VVNmpRQndEblh3?=
 =?utf-8?B?cTNYRUk3UW1kT0N6YStuKzJhUFdwMmlCdFQ3U0tWNWsxMXMySVlqbnVZYytp?=
 =?utf-8?B?TVVUZU9Ic0tHcEQyaGk1VHkySVRGSmI0QVFOVTJvVlFCempNckFCdkFtVHpP?=
 =?utf-8?B?VDFEdTdZTXE4US9EYjZnWFNaS3ZjUUp6cE8vekw2MDYvQnhBckNSN1lIcnk5?=
 =?utf-8?B?SFd5N3FXZjBvMWdVUEQvY2t3TW5JdkFldUFZVmJxcmZSTGNoMlAvQllWY2R3?=
 =?utf-8?B?aGVONkpkd3NsOHhtL2lYMkluTEFFVHh1VGpBQmFTMkpPaE5RbGp0eitLWXpO?=
 =?utf-8?B?Ukt3SFc1bHpyZWw0d2NxYktNb0hjV2ZHSkpSUlEwN2hKdkw0VUVGUzZYU0M0?=
 =?utf-8?B?dnhRNGhrTkE2UGdud0IzQmQ0UVlNZU40aXBLWHNpb1ljR0VmQktlclVqZkVY?=
 =?utf-8?B?T0lvY2tXNVd6NVg0dUlMUHJwWk1mOUgzelZzT3l2Q0l6QTN1U0UvZVo5c0cv?=
 =?utf-8?B?dUxTVE1qNlg2cnc3Wmcvb2FqSklyTWpwV2EwRkw5OXZ6RlQvT3hwMW9qNXQ3?=
 =?utf-8?Q?RxDhRqf2SMBnlqmIgeh2kZb7AfzMnMSt?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dFY5dmIxSTVLOXBNVFpIM2xKa2JGZUowbU9xT1h5YWJTSzlPNCtKTTBvMUFN?=
 =?utf-8?B?eTRWYzZlSEZjOEZHb3FxZTZ5a1gwRW8vdHZna0s3Y1B2Syt0azlyTjM0RXNT?=
 =?utf-8?B?R2F2TUtOY3BsMGpRcktZMS9QeVJQOFZYOG4wTmdFc0dEcFdIOHg5NGIrVTdG?=
 =?utf-8?B?c1FwU21mWGNrQkY0LzVwbC9xVHlvVjN2bVBTa1J6SS94d1NrN1ZVVTNBaDh5?=
 =?utf-8?B?SDJhcUpDTFU0OGV1RGdrUUk5c2NzUTEyOHloNUxvd1NEcDUxejF5WVpZNnh4?=
 =?utf-8?B?U2ZDM2JGdkpaaitNSzFkNTZYbFROaTI0Tnhwa1FhcWo2NTR5M0NPRFgzL3o3?=
 =?utf-8?B?NzJhYUVxSG83RTI5ZW13dVM4bHhORVcwWHk1UEMveU13NVQzKzVKVVJFVk5E?=
 =?utf-8?B?S21ZV3ljdkd4ajVOS3VxQW0xejZUWWFLM0J3bDhQQnRLZ2RKclNTZ0d1RDJO?=
 =?utf-8?B?c01Ja0FhUFY1YlFjUUNMZjFrL1RaVHVUZnNXc3dmRTc1NzY2UzNoM1R1WXJ2?=
 =?utf-8?B?SThEUHB0MC8wZlJ3WUwvbUQ5K3VLYVR2RzBzVzJKeUpoeHh5QjY1UGNpV1Jx?=
 =?utf-8?B?ZkxiK2s1d0wwb2JYSGlVSzZ1YXlrcllaNjRBL1lTMktIRFpsd3ArZ0dPTkRI?=
 =?utf-8?B?b04xUEhTSlVUajFMQWdScDRNcm42VGxITjNwRzJkVzE3Z2VJT21uajZ4K0gv?=
 =?utf-8?B?R1hxZUJyTHN6UVhzeEkxeEhCN0tIVm9PVEhTaERqN2NkYjJiKzd2QkNBazhM?=
 =?utf-8?B?N2IxSjBjbDNZdFJHZzhlVUx4ZHcrSFlWSU5samZ4QzRGNjRGd1VqcXFjN3Y2?=
 =?utf-8?B?S0hlZ25ETG1meHJVM2FCRU1CeW1WS3g3bVE5YTlFS2VhVmpPaEVQa3FkMGJt?=
 =?utf-8?B?Q1JkTFlXd2x1VXRzejNTb3RQNEV2T05xUnFhRU8xbFVwWXkzU2RTWHpNSW1X?=
 =?utf-8?B?VkgzU2k4bkxMY1U5R0ZvTlNPTEpQYUxYbVA5Y3RwNXhOWENySXFqeW5pY0Ja?=
 =?utf-8?B?WnJzSGd5Z3BkS1FhaEFVNUVHa3ZJNlBtL2pDM3Y0QmxNUjBxZi9PZ0R0b0RG?=
 =?utf-8?B?VlJPNUcxMWliU29iRmdBdERDWm0xUDNSWHl0dFJqa3BPWDJNUFFGZUQxTlIr?=
 =?utf-8?B?SlZ5c1BGVzJZUzZIRzBRZXkxUXhWam9qSHFYdU1DMzgybHNhK1phSGNzV3pz?=
 =?utf-8?B?MTZwSUdwdjVWMXFnUVk4Z3FTSlVZL0RKVk40aGp4Sk54YWpUbTd6VG1Mb0Yr?=
 =?utf-8?B?cVJaTkFWbGk5cFkyVXVGanNjZmY2cDd4a3p0UERob0dwejg3Ync3Q3BhQVg3?=
 =?utf-8?B?ZzlFVGVraHQwOWNFUlB6ai9zMlFWYWdERHNwYXJJS0o4SU1uT1NSRHhkS3hY?=
 =?utf-8?B?bko3MDNzUDlTVEVnK2RIOXMrM3FMZGVFVzIvSEFncXlERVlWdnpWTlVBN21v?=
 =?utf-8?B?OUtvOHl4SHB3NXBxN0FJU0x2L0hUdGF3VXNTQkFSRlZYankrbVZva3UrSG1s?=
 =?utf-8?B?Y2R2anZvR3VjWEhDZXc0SkYyQ3U4enhZNXJPMEdRTUVJMWZmR2ZCaSt6MzV3?=
 =?utf-8?B?dTZuMURzeklxNmRkcE40aGtONGdKYVluK1ZGUkUwVDFsa2t5WStFZnpsZ2ZO?=
 =?utf-8?B?THdRcjdFWHN6cHNFVnlzYXJVVU11NEpPMlRhKzRCT0dxL0pYVkh0NFNFWXJZ?=
 =?utf-8?B?NG40SXJzUTRVUklHT0JhSkRudVdzRmVEQjhUaVhPZExDVW80SU4yM0FiZ2hp?=
 =?utf-8?B?VXhTdkpSSkx5LzlkTWZBSzh5WS9Dai9oc2ZZbzJGU1ZVbE0rMWtXdkdYZnBX?=
 =?utf-8?B?TkxkQnhRQ1QxMFFkbytUQm5TQk11ekthOVJuc0QrWWVEZTQwV3FaSkVKOTdz?=
 =?utf-8?B?SytsY1VWMnVJUVVodEtNUmFPV2dwZkExZXRZTENwUkhZQUxReGFRNTdOSUxT?=
 =?utf-8?B?c2ZWYjd6VTVNYjhZR2gvRjl4M3l3aWErbkxoKzV5WHBBU2kxOGFFcUJJYUV2?=
 =?utf-8?B?NDhVMVpSeitTOUo2Z2NGQ3V0VGlaNWpRdFFvbDVsOGQzQzVJQmRGcUlzMkdB?=
 =?utf-8?B?cThzc2lQajhuK1BWd3BaQmprWkcyemx6L2R1ZXFFaW9zRnFIaHE3UE9QSmt4?=
 =?utf-8?Q?VWm1+CWlYfkapcVs2P6/lo2Eq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <13EDC1ED936E7446BD3B9475761D5E44@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	G3f0UG9i+qEjkUrVL9zTfENOkajHqd32xRcbqTLHHftAqxtHL/w/rtVdepejdKliES5ROxrCm3T7mhzWDvH72oNZ8zwTgvEvUGiRkhTZ+BUAF9ZZg3+cs17F1obszP7PPL6WSuSNvPxy5Rrzl6PgB8VvMTIwnHrI1njI2mujomD67rwhj47R9ab5ZjfKhYFBtcv2ylsaUAlC9vN8ALHkHLtz2iBUMDURXMHbEUd6hrTYPsJrlA4Xw9RZBcEmtkcP2WCpKmflCb7Q2wjDPeIPdAEi9nOlGZHshHj8e3GxHwdVTe51sCjkWLV85pwE8vfTRGIYUu+6Zy2qOV8pb8hbOadgqsKsOXTUuU8vwQn2MSGyB12lOdtqyiDr6RdJ/1TINKOJek4myZuHs7TNfKfYoKdkxb0vlPt7s3Tat4Uoe0uvq7kJ0swLs7Tfj5GSBk9v3mdxKLHrifX35UWD0wkhfwTkNMv+XLZM/m3S0igMtuJqS+bDz28WgAmFDlHsX6vRtAXD5g3S+BpV3iGXYxP1wFLoWcveDKlJq6uVdmEyX7IYyacMqWVGK1REKGUyjnJYL7l3m3r9G9w/Ac7MmTe+YIbCz5AlfGfpo5bE6mFQonkF5CcnSJfr6AOvMq+IapafFsze/LKI/Y6Hw4kX087/kA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d8b7b79-5b5c-4c2f-024f-08dd4bcdad6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2025 01:28:10.6511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w8BXxUAJGMijGivhbuf584End8z0SuFXk0qhbysBCCSb/ZjlXreSDRKOUPxYydw184c6RihJJCPpWAXEEpwcaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8770
X-Authority-Analysis: v=2.4 cv=NJ0v+16g c=1 sm=1 tr=0 ts=67ad4ab0 cx=c_pps a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=T2h4t0Lz3GQA:10 a=nEwiWwFL_bsA:10 a=qPHU084jO2kA:10 a=KKAkSRfTAAAA:8 a=jIQo8A4GAAAA:8 a=bjLXpdZFXQ_S1UZQI7oA:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=Lf5xNeLK5dgiOs8hzIjU:22
X-Proofpoint-GUID: auAcxM4Lmx_3AxsZgG7WSvGo0sZig-42
X-Proofpoint-ORIG-GUID: auAcxM4Lmx_3AxsZgG7WSvGo0sZig-42
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_08,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 impostorscore=0 mlxscore=0
 clxscore=1015 mlxlogscore=844 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502130008

T24gV2VkLCBGZWIgMTIsIDIwMjUsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+IFVzZSBz
eXNjb25fcmVnbWFwX2xvb2t1cF9ieV9waGFuZGxlX2FyZ3MoKSB3aGljaCBpcyBhIHdyYXBwZXIg
b3Zlcg0KPiBzeXNjb25fcmVnbWFwX2xvb2t1cF9ieV9waGFuZGxlKCkgY29tYmluZWQgd2l0aCBn
ZXR0aW5nIHRoZSBzeXNjb24NCj4gYXJndW1lbnQuICBFeGNlcHQgc2ltcGxlciBjb2RlIHRoaXMg
YW5ub3RhdGVzIHdpdGhpbiBvbmUgbGluZSB0aGF0IGdpdmVuDQo+IHBoYW5kbGUgaGFzIGFyZ3Vt
ZW50cywgc28gZ3JlcHBpbmcgZm9yIGNvZGUgd291bGQgYmUgZWFzaWVyLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8u
b3JnPg0KPiANCj4gLS0tDQo+IA0KPiBDaGFuZ2VzIGluIHYyOg0KPiAxLiBSZWJhc2UgKGRyb3Ag
b2Zfbm9kZV9wdXQpDQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9kd2MzLWFtNjIuYyB8IDEy
ICsrLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMTAgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9kd2MzLWFtNjIu
YyBiL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1hbTYyLmMNCj4gaW5kZXggYzE1ODM2NGJjMDNlLi45
ZGI4ZjNjYTQ5M2QgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1hbTYyLmMN
Cj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9kd2MzLWFtNjIuYw0KPiBAQCAtMTUzLDExICsxNTMs
MTEgQEAgc3RhdGljIGludCBwaHlfc3lzY29uX3BsbF9yZWZjbGsoc3RydWN0IGR3YzNfYW02MiAq
YW02MikNCj4gIHsNCj4gIAlzdHJ1Y3QgZGV2aWNlICpkZXYgPSBhbTYyLT5kZXY7DQo+ICAJc3Ry
dWN0IGRldmljZV9ub2RlICpub2RlID0gZGV2LT5vZl9ub2RlOw0KPiAtCXN0cnVjdCBvZl9waGFu
ZGxlX2FyZ3MgYXJnczsNCj4gIAlzdHJ1Y3QgcmVnbWFwICpzeXNjb247DQo+ICAJaW50IHJldDsN
Cj4gIA0KPiAtCXN5c2NvbiA9IHN5c2Nvbl9yZWdtYXBfbG9va3VwX2J5X3BoYW5kbGUobm9kZSwg
InRpLHN5c2Nvbi1waHktcGxsLXJlZmNsayIpOw0KPiArCXN5c2NvbiA9IHN5c2Nvbl9yZWdtYXBf
bG9va3VwX2J5X3BoYW5kbGVfYXJncyhub2RlLCAidGksc3lzY29uLXBoeS1wbGwtcmVmY2xrIiwN
Cj4gKwkJCQkJCSAgICAgIDEsICZhbTYyLT5vZmZzZXQpOw0KPiAgCWlmIChJU19FUlIoc3lzY29u
KSkgew0KPiAgCQlkZXZfZXJyKGRldiwgInVuYWJsZSB0byBnZXQgdGksc3lzY29uLXBoeS1wbGwt
cmVmY2xrIHJlZ21hcFxuIik7DQo+ICAJCXJldHVybiBQVFJfRVJSKHN5c2Nvbik7DQo+IEBAIC0x
NjUsMTQgKzE2NSw2IEBAIHN0YXRpYyBpbnQgcGh5X3N5c2Nvbl9wbGxfcmVmY2xrKHN0cnVjdCBk
d2MzX2FtNjIgKmFtNjIpDQo+ICANCj4gIAlhbTYyLT5zeXNjb24gPSBzeXNjb247DQo+ICANCj4g
LQlyZXQgPSBvZl9wYXJzZV9waGFuZGxlX3dpdGhfZml4ZWRfYXJncyhub2RlLCAidGksc3lzY29u
LXBoeS1wbGwtcmVmY2xrIiwgMSwNCj4gLQkJCQkJICAgICAgIDAsICZhcmdzKTsNCj4gLQlpZiAo
cmV0KQ0KPiAtCQlyZXR1cm4gcmV0Ow0KPiAtDQo+IC0Jb2Zfbm9kZV9wdXQoYXJncy5ucCk7DQo+
IC0JYW02Mi0+b2Zmc2V0ID0gYXJncy5hcmdzWzBdOw0KPiAtDQo+ICAJLyogQ29yZSB2b2x0YWdl
LiBQSFlfQ09SRV9WT0xUQUdFIGJpdCBSZWNvbW1lbmRlZCB0byBiZSAwIGFsd2F5cyAqLw0KPiAg
CXJldCA9IHJlZ21hcF91cGRhdGVfYml0cyhhbTYyLT5zeXNjb24sIGFtNjItPm9mZnNldCwgUEhZ
X0NPUkVfVk9MVEFHRV9NQVNLLCAwKTsNCj4gIAlpZiAocmV0KSB7DQo+IC0tIA0KPiAyLjQzLjAN
Cj4gDQoNCkFja2VkLWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20+
DQoNClRoYW5rcywNClRoaW5o

