Return-Path: <linux-kernel+bounces-208856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D080F9029E9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 22:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C25901C23DC2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E4D481B4;
	Mon, 10 Jun 2024 20:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ChdAy9tA";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="IW1CTm74";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="PGZtZjR9"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C114318C36;
	Mon, 10 Jun 2024 20:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718050985; cv=fail; b=C3HCZniANUwgFWF4ODNw5/E2xJLrp9i5W3Nwi1nCf3b5QVCR0dtOSmhSr36d8HAqscDFKjUOZLg/A8h2TI+oJ+Af5PeNqjAkZXsvxDu5irEQw1hqZDjTLlHSVNQ8uBpwN2sUOOlgGjLQg1WVfFHJSYmQRCTFTwHDnF+3jX0qU3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718050985; c=relaxed/simple;
	bh=zeb9ZgXYEqSr1waZ0bVowvTppM6H7w5cck7JdOE+JcI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mkj2srizqsouy4LVgLyUybNDojRCg/gxKSX/HuHxIbp97oYt6vkBWQapX/+DjDbAgBZ+xX93XYteXNv4yh2X1+fQlk3Jnr68+6poJB3RXnQgO8cHtQ1oDdd4OcXlx+sodEqnr01afsNVyj5bPPz5gPbnGOzRawaTt+Rfo1YGK2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ChdAy9tA; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=IW1CTm74; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=PGZtZjR9 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45AJGWKw014440;
	Mon, 10 Jun 2024 13:22:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=zeb9ZgXYEqSr1waZ0bVowvTppM6H7w5cck7JdOE+JcI=; b=
	ChdAy9tAOkdXY8fYzfYzOOiVKrzcBX//WIQAniroz8gk88tGftfRihcNBtnavXD+
	VXwOGzmVjYC0Zn9MtigZoO+6+Bo5Q3Wae0xwn3sB5kJ8/NASTWtnmLS7wADz/lh9
	mXjBtohXscwDETBgIcYSB9FeqnR0tcMfHiWOjKO1OFgUNrekK+ugj1BBHs7XL287
	Ys/lOg9dFrStEQ4r6sWDumb2BfJpXUI5pyBiq0JB9iOWXNfd3uNcmouAhag1uYg0
	rkBy4ablc8nBtgnFknQE73Bu5/mErs4eoataq7Y9HsQc8jwJunBEloiz0pRsAg3A
	xLIGEA4KkoKq6oKqpqd48w==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3yp3mhhekv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 13:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1718050949; bh=zeb9ZgXYEqSr1waZ0bVowvTppM6H7w5cck7JdOE+JcI=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=IW1CTm74xxqV5rtoYxvdiFgpTATPlEVOldx4aXr4p8g1ZL6HxHq8XkZqAx3e9XQVN
	 xlZSUXYBnnqmumGAduQa5dbUJmDfVAsAWVYU6Kovi6AcTUm1PXWPlI59ZBOPxcsXRk
	 hkQXRXERvQMpyaGg8Lbq6K/+dImCmaCAzDxywG7ZOXzQb8LUb4l6+tbLLbNQId2mOZ
	 Fb2YU1M5KUWMTSlh+St5PsHzrzXAD3mbCCOFZgEdz2FCLKkcPT5bF41/3AqkrmgeWW
	 PcYO+jt72MafRqhIOW2B2sy8Ohgaa0Ed6sICoWpRRXIhcRhYSMyxFIpLs5Em66PsDi
	 Kwov6fFqwlVSg==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 902C240348;
	Mon, 10 Jun 2024 20:22:27 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 2EF38A0081;
	Mon, 10 Jun 2024 20:22:27 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=PGZtZjR9;
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2044.outbound.protection.outlook.com [104.47.51.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 1DC794048B;
	Mon, 10 Jun 2024 20:22:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkiwlsP+URvADCA6EEwPkybOj2se3bV5QZsue2mwjG7STf5pP+vtQSlekXgFCGgVtqgtMM1EyE8hAzMxEFyvhHGgBdOvVZVjnWXdTiDcXDCBvZhPe2eLDN3W1k698l3iJkRe7bW8zmBGHfARCNEPo0+rSxZhf6+MzbxEoTFckKXLW1f3ZK28/UEjbIWCEBilMGghRiZyackHCSEqDcpSNHV7n3ZmRG5poVxw6icD4BLzbyTFMPXJeXpoL2PyB14DeJLGZSI0nmHNrrxxh16u6UE/UYXJ7xdPESgKb7Q6qexH/zfk9I/D3z3gy93Xn/HxxrXEMzf0RA5VhuWfWRngSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zeb9ZgXYEqSr1waZ0bVowvTppM6H7w5cck7JdOE+JcI=;
 b=SXN7xzXe9cOhyiLaTuBc9Og4+X23P2bSAjqMScaFT8WwjwkEaTn5Gu0z2UcDdR0DhXXZUMZq3r/7Fz8T65gqt/FCP7EJqSjXCN9027sMLu55K8R9UK5Dz52ilQNi33lFtzLGLR3wPgT0qWbZII24WjF1JS6pySnmomHL7JlR9GS2AvWb2QQ1QS7uRaRr7p85xJ4sbS2uCqYss1QzOaA5iydWtI41h6Z3tpyNI2qo8HYRi3/3YQZffIkOZfPqa6A9VuNeacI6ONubiXmOTK2RikBVDDrsGMy2RH1Ai/85aLdDI9xNAckGbVh4RvB/ZPUN/2YenSUjzVbraDY+AVkBXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zeb9ZgXYEqSr1waZ0bVowvTppM6H7w5cck7JdOE+JcI=;
 b=PGZtZjR9mTd8O6BsHo5BUsYbyNu8u2cF5w+ztkuumKGof7Ni153xwhGMnrFmFKwTjyjY8k1icT6A18GTZ/B4t+J0+dhlqVhWKf373v9pRLpuGWVnFhWNmdJz6U40PJWqnWdAreIQx3HFoMURippkpbUx5f9ckzKw3ijOB80/7ZM=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SA1PR12MB8093.namprd12.prod.outlook.com (2603:10b6:806:335::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 20:22:22 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 20:22:21 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: Re: [PATCH v3] usb: dwc3: enable CCI support for AMD-xilinx DWC3
 controller
Thread-Topic: [PATCH v3] usb: dwc3: enable CCI support for AMD-xilinx DWC3
 controller
Thread-Index: AQHat99ljSVm/UWMYUGSocV5MsZNRLG9AEAAgARopgCAAA7/AA==
Date: Mon, 10 Jun 2024 20:22:21 +0000
Message-ID: <20240610202148.yamu4acezsijvpk7@synopsys.com>
References: <1717657279-2631757-1-git-send-email-radhey.shyam.pandey@amd.com>
 <20240608000832.globqeu3ca775vcv@synopsys.com>
 <MN0PR12MB595361CD17D25FF4554768EDB7C62@MN0PR12MB5953.namprd12.prod.outlook.com>
In-Reply-To: 
 <MN0PR12MB595361CD17D25FF4554768EDB7C62@MN0PR12MB5953.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SA1PR12MB8093:EE_
x-ms-office365-filtering-correlation-id: fb3e99fc-3b9b-47bd-1c53-08dc898b0851
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?d3dsN2V2Q2xUcHdUSTZYb21LZUpRQTlYNTI3ZjBMSVlvaTIrdnQxMFNxVkdR?=
 =?utf-8?B?Y04yV1RDbGZUem5OSlpHMi80a0FLNDZyaXRzRnFTanpPTXRWeHd5aUQzYjVI?=
 =?utf-8?B?V25OYkJYYTZkR1B4amozakVYYzZhNThoSjFyUVhXV0JiZFJORGJOVUVhSXJl?=
 =?utf-8?B?L0F1cmZ4ZWp0cWtiZWp2N1FiL0Jidy9WZGo0M3cyL0xwUnh0eStZb0kwK1Ni?=
 =?utf-8?B?b21EUlVGVks2MUN4T29rTDA2cVRGNk9naDJqbURjcWZUYnkrOFJISFF2K0Nm?=
 =?utf-8?B?Y25hbFllaURBZjRMYWV3UWV5S2o5ZVBydVVsUXU5aWcydTYrd3VsVk13Y2RU?=
 =?utf-8?B?VE9OSXlFSWdDRy9LYXUvdmRsZkpNTEFjTnRTZXhRZ0IxSnBTRk5UR3lUaTU4?=
 =?utf-8?B?TjhobFFNdzI5ZXcrU0pwMzFkZkRiVU0vR1BsanQxdStsbHlLcmpvZ1dmdk9t?=
 =?utf-8?B?dmxLa3pNWG9adDlUbGllc2lSSTRCcW5VaEVLVDFnK2JraWxYOW9QWU1xSDVK?=
 =?utf-8?B?eENCZzhNSTRpMGNxUWJCclBuMHNLMTFPazZKa0RsZVRNUGwxZFNkd1N2NDJx?=
 =?utf-8?B?ZlpkVHpEN1ZGTFc1YjA3bkNGNDhDRGI5d1hSR1c5bEZPQzBhZDRHTGJ1TlZs?=
 =?utf-8?B?ck5nNmNydVZmeXBGcDI1Z3BrZDBHR25VS2EwLytiU2dmSG5aN1JpeXlJbXl0?=
 =?utf-8?B?a2lYRHltUXd4cFFubzBXT3RKekd4OWIrRlNBZ1ZEdXRORUF2bXpVMjVueml3?=
 =?utf-8?B?a21ETlNuVUZqQnUxS1FLUjZ1cDIzWHRCS0NvYTZTNld2SHNlTDJhaWtaSGdW?=
 =?utf-8?B?MjAvVUtGUGRvNUkxRE9PVHZ4MndRWXViL0dJUisvWllRb09GMDNDRlhPa3h0?=
 =?utf-8?B?bVRNZjRnTGV4VVhORS9YWEY5T0djY1F3QXd1cmVRL3lySWs4NUxWSHVZRndn?=
 =?utf-8?B?Mi9aZ0Q0STlSMEpiVlBFcWVxdUh2Wnc4NFViN0xCdXVUeUdKMXlxZFYvcEpq?=
 =?utf-8?B?bTc4QlpoUGd3NklEbU9UU3N4V005d2Zma0RSY2s2aFN5L3QrYWRvOFNvSmxE?=
 =?utf-8?B?RmYzTDFydlFwOXhRdU1ISXE1RXIydks1anVJNTRrZFU2ek9FWGlGbVR3eERY?=
 =?utf-8?B?UDFjdnFWTGxHN1AvRUwyTlRuc2tOL085ZjZtd1F1c1pmeUs2MG9qeC9xMzZ4?=
 =?utf-8?B?cU90dEZLajN1ZEtCNXdqWGREODF2RkdXSTNzbFRqcEhSSldQSXhHaVVzWHFy?=
 =?utf-8?B?bWhKTHVBWEduTzVuNlVYQmFhaGozRmgrMER3NTcrK1czUW1ZeEZQRGphUjZ3?=
 =?utf-8?B?ZzM2UVh3ZkxRYWlrSmJrQVZsOStlOGwwTkczbTZ6aEE3bkl0cWY0Zlh5WDQ2?=
 =?utf-8?B?c1Z6d1ZTQS8ycjhIdUJnMTFMQjFsdTdreVhDUFFHVktiRkYxbkJFUU5lMkJY?=
 =?utf-8?B?TmFUQ1NJUUZqeE45TGRLNVpkLy84YUd4NmgzaVhmNkZGa1dqMHFXcWg5NGJS?=
 =?utf-8?B?NEMvUG5PNkNVaEwwa2IrWWVPdGNOTDhiUTBrbTlWUDNsekxOaEt0bC9peHRo?=
 =?utf-8?B?ZHdHUVJoRVdMeHBmSjBBRWxieThKMm9OSWp1Wnl3K1lNcnZja29ZQWJ6NzFK?=
 =?utf-8?B?WGxET25zVnVaT0Z3V1NONUtzYTBqb1BZN1JSeTd4MHBITGh0YU1vZ1JZeVpM?=
 =?utf-8?B?VGxCYWpQWmowMUlTWXlCNHJyTkdjK2QrVWI3VGpPbUttVXJUdFdNMlRZSitJ?=
 =?utf-8?Q?R2FDd7tqUv3Q63Cx1+GLMSStAX45XFA5bZCx4HO?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?N2k1M0J1cjh5N3c0WFFVZFkrTkFIREJsek1BeHVKZVVnRkJ3azVTMEhUMEFU?=
 =?utf-8?B?T2VEakxQY2N6eVBtYlJDeUlTc0pMbm13M0h1Vy9SRDF3SWUvL21zREtoYWdz?=
 =?utf-8?B?OG9NV2t6S3dNc0VlZDk4Qnkvb2ZqY09ub2NoUHhBVHo3K1N2SHN2c1hUUWNO?=
 =?utf-8?B?dVVaclRUZmNJaTB6M0Z0VXk2a2ppQ2tvYnhXR21WWDROdjQyVXBPbU44VXd4?=
 =?utf-8?B?a21SUWowOXc4em0rcUVhQ09IdEk4TW5MTjFIZUxYeDU4dGUvSVRXMGhVRTgz?=
 =?utf-8?B?eGNVbjNCVEFIT2pjSUJ3cmZZRUh6bitVeU1GUk1aSURra0l4WDNwZUJaRURS?=
 =?utf-8?B?cVAySjVtVmpkTVNFYzY2bFBlTldWZkN1K3IxUEZ6SVREcC9Md0RDSC85d3o4?=
 =?utf-8?B?eVoySG5MOHRWVUMwWlY0NkZPaGVGMXJHUjBrRDFzRzEyRElQbjhxTG9VbTh0?=
 =?utf-8?B?MGo5ZGZmYVNaQlNuY1hjREdGelFyc2xZeGlrOFJoYkM2ZXpGV0lNdFhMMkpw?=
 =?utf-8?B?VHhyV0FzbHRZTjlXUVdlT0FkYlRpYmRLdmVOeElYQ2FBVVF4c1JaOERjdmJC?=
 =?utf-8?B?alRoeW9rMWcxc2M3QXFvZzI2amNZSDRoYzBla1hBbmV1MmpRRHNWVkt2VXU4?=
 =?utf-8?B?eXptcUE4cEZzMFp5RE40L2w0VFYzQjdvMzd6bk5ja0NGbytVbHlrcEFkclE3?=
 =?utf-8?B?Nld6c0t5T2liRGRyOWJYVGVpYU10NnEweXBLR1JRcjJMSERUNjJzcFhNRHFV?=
 =?utf-8?B?bHZ4UW5aQ3NrQUg0WktxbDkvajEzOWhFU3l2YVltTTNKWFJoZVFoWlhvdmhS?=
 =?utf-8?B?NEJrY1pSeEhlTWdEUmE5MWd0ZlU1TFVPRHFLd3RNZnJIQmNwdWM0d1B4NFVB?=
 =?utf-8?B?d085cXZVZ0VjNlp6OVA4VkdVNlV4YlQ3ejZWaU5Va0xjcW1oVDFPOHZZMmlS?=
 =?utf-8?B?NEtERXlyaXFkR0RUWmF0bUFHdmRDL2ZOcy9Malc3Ylp2Rnp4V1dycW45bHlw?=
 =?utf-8?B?c0xWYllDa3pJdnRScG5ITU96S2kyMFVnRmU2b0VXLzZOYVRnSnpxZ1JVVDZo?=
 =?utf-8?B?YjJuMlN4YWJHeWZ0Z0NrS3FjMWFHaEIwY0dtNTUrYWJwaVBNdjRlNTJjUi9o?=
 =?utf-8?B?Q1RldDNhZkxqYzBpbFUrZXV3RjZSdGhBajZ1VHB2NTlPV1NwSDBJQWN6Yk5X?=
 =?utf-8?B?ZjEyUXhxaW1hS0pMYWRlTWRsdi9JT0xHWVRZR0NESXhNNldSRnVjVUhMQ0ln?=
 =?utf-8?B?WDJLeGFieDllYm4vS2lWZ0tRb1hRSEY0Wm5oeFBVZkpQem10VmhyMTZIU010?=
 =?utf-8?B?V0NYOXdCTGhuN0JEcExVZXRKU1B5R2Vrbkp6ZWtPOE9FQVI1dlQ0UVB1a1kv?=
 =?utf-8?B?Qk93QVNDZTdtNHRXWXFKNTVNTTcvQ0R4ZTQ3dlpMaHNtZS9wMWVSQ2sxNWpE?=
 =?utf-8?B?V2xHUklaYWxqSys3ZTdVZGc0dGl6RE43aWlidWhWVUU1dHhWMDVMR2RxeUpn?=
 =?utf-8?B?T2dERzBhc2xEQ2NZem5zL3lNMjF4dk1obFAySGRrUE9rVFkrLzlXTFZUcG1o?=
 =?utf-8?B?RDZFMHBMQ3l4Q2JEK0xDbTdxSkZRS0NhdXc5aTYxdU41bXYxbHJvZm5HbW45?=
 =?utf-8?B?Rndad1hvdkJGSUx2OEd0emljakprSVJKcXRjNWh3OVc3R3ZDckZaY21rZ1gv?=
 =?utf-8?B?S1Y4VGxZRlV4QmJNSmM2bzRpTGl5UDZ1T0JJZ0FqTVFONUVJM0FGWXB5UU9u?=
 =?utf-8?B?Qm56Yk0zTWZKK1c3RFJrN1d3WmhxcjlvYnlnNzB1T1RTenhFNC8rWUNYMWxE?=
 =?utf-8?B?R3hjYUZ1c1JwN1ZzclpSaGlXcHhkTmlFazJPRUtkZTRheFlvT0NDY0hWZWRp?=
 =?utf-8?B?VEtrYmNaR1VLam8vKzNGVzhPd0xxRVRNTEphR1gzSDFHNjlSbnJUSGVBZlg0?=
 =?utf-8?B?eXI3cWpDUlJHMHE2ZGxlMUphWjJVeTQrZ2ZiMTFjak4zQ0lJUk8yMTE1TmJP?=
 =?utf-8?B?VUlaaEFIbnFpKzU3L1l6R1Fob2lhQ3cvazd3MVZubUNqMFpSbUtLMkgyWkg3?=
 =?utf-8?B?S1lzZTFyN0RjZERvNyt5d01HNXFUVTY3dkxaNGFQeXFWcGVMa3hmTVNST1RX?=
 =?utf-8?Q?xqFGzuXYza7lmmffoIQ8lOYpj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <34F8489D236A1D4EBB20ADC237B9021D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	GrcLQ+Pqi64ERHGdJdiGscMVqRjVGwbyluvX0fmHc35D5yd9ltcqMPlmosG0gctMUuJFtxOQCOMG2GsERfY9CdocaDXYHA1cOpELCzlgFRlaMOT7dgl0nFXs1w1269pFdrSR3Jb+VjFM75Kd+4MsBTMYJQ2QW3l7fHS/KDrY1nErxnj4pmG+OfVoooUFEpW4DBnXcdQLFgfFmHwQSsax1vF56muaktSgDEFsQ6AtHw9g1uUBtDCOk9pFA2dJY6vUVVrOG6wsZ48GN7Bt6hJXiXWOjxQvSmMPQNEIZ0wiOFbB/cqNag1gD1YPZCqMI5dJxblDElpA7wCntgtdxT2XLm9UtudqgSMNHQl7Sl2c1JJKtJBzXvZi7qkTbfiiD0CSAxVhop4oKv5lefy4oXq1efZvWE3wRk7Me99gtPqaOeC71dbrSr3zhYoSeWp3ySGGviBRiBs5rtq3DKLJyXHR0M49UOm7XSgNyZxth1vf1Gy9izAGo8NHoCg5Z7pxYm/8034nLqg2zk5qVGvFYtalEC+k6iVc06yjhlyVQH3I46k7kL1VWFNVJcc2UjP9cGIO7b1YIZbUyHgzt2EOVOpTOmlVLYGfhR3QRqqel4R/KNhYqLKaAMQC0HSh/ID8/M/f94Ax1rC+nYLA19IjeNDssQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb3e99fc-3b9b-47bd-1c53-08dc898b0851
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2024 20:22:21.1853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZDIxoLXKSQUYzRz/Dhuv0ps3ImVNx8xcay+M05RQY9PLXvdLKBfo1A9sqBwKQbb/V6ktJSvXzF713WCyOEzAvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8093
X-Proofpoint-ORIG-GUID: z5KZZBIdNG2xgQ7UKBF3LmNJHQzJusOl
X-Proofpoint-GUID: z5KZZBIdNG2xgQ7UKBF3LmNJHQzJusOl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_06,2024-06-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 adultscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 phishscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2406100153

T24gTW9uLCBKdW4gMTAsIDIwMjQsIFBhbmRleSwgUmFkaGV5IFNoeWFtIHdyb3RlOg0KPiA+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogVGhpbmggTmd1eWVuIDxUaGluaC5O
Z3V5ZW5Ac3lub3BzeXMuY29tPg0KPiA+IFNlbnQ6IFNhdHVyZGF5LCBKdW5lIDgsIDIwMjQgNToz
OSBBTQ0KPiA+IFRvOiBQYW5kZXksIFJhZGhleSBTaHlhbSA8cmFkaGV5LnNoeWFtLnBhbmRleUBh
bWQuY29tPg0KPiA+IENjOiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20+
Ow0KPiA+IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOyBTaW1laywgTWljaGFsIDxtaWNoYWwu
c2ltZWtAYW1kLmNvbT47DQo+ID4gcm9iaCtkdEBrZXJuZWwub3JnOyBrcnp5c3p0b2Yua296bG93
c2tpQGxpbmFyby5vcmc7IGxpbnV4LQ0KPiA+IHVzYkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS0NCj4gPiBrZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsgZ2l0IChBTUQtWGlsaW54KSA8Z2l0QGFtZC5jb20+DQo+ID4gU3ViamVjdDogUmU6
IFtQQVRDSCB2M10gdXNiOiBkd2MzOiBlbmFibGUgQ0NJIHN1cHBvcnQgZm9yIEFNRC14aWxpbngg
RFdDMw0KPiA+IGNvbnRyb2xsZXINCj4gPiANCj4gPiBIaSwNCj4gPiANCj4gPiBPbiBUaHUsIEp1
biAwNiwgMjAyNCwgUmFkaGV5IFNoeWFtIFBhbmRleSB3cm90ZToNCj4gPiA+IFRoZSBHU0JVU0NG
RzAgcmVnaXN0ZXIgYml0cyBbMzE6MTZdIGFyZSB1c2VkIHRvIGNvbmZpZ3VyZSB0aGUgY2FjaGUg
dHlwZQ0KPiA+ID4gc2V0dGluZ3Mgb2YgdGhlIGRlc2NyaXB0b3IgYW5kIGRhdGEgd3JpdGUvcmVh
ZCB0cmFuc2ZlcnMgKENhY2hlYWJsZSwNCj4gPiA+IEJ1ZmZlcmFibGUvUG9zdGVkKS4gV2hlbiBD
Q0kgaXMgZW5hYmxlZCBpbiB0aGUgZGVzaWduLCBEV0MzIGNvcmUNCj4gPiBHU0JVU0NGRzANCj4g
PiA+IGNhY2hlIGJpdHMgbXVzdCBiZSB1cGRhdGVkIHRvIHN1cHBvcnQgQ0NJIGVuYWJsZWQgdHJh
bnNmZXJzIGluIFVTQi4NCj4gPiA+DQo+ID4gPiBUbyBwcm9ncmFtIEdTQlVTQ0ZHMCBjYWNoZSBi
aXRzIGNyZWF0ZSBhIHNvZnR3YXJlIG5vZGUgcHJvcGVydHkNCj4gPiA+IGluIEFNRC14aWxpbngg
ZHdjMyBnbHVlIGRyaXZlciBhbmQgcGFzcyBpdCB0byBkd2MzIGNvcmUuIFRoZSBjb3JlDQo+ID4g
PiB0aGVuIHJlYWRzIHRoaXMgcHJvcGVydHkgdmFsdWUgYW5kIGNvbmZpZ3VyZXMgaXQgaW4gZHdj
M19jb3JlX2luaXQoKQ0KPiA+ID4gc2VxdWVuY2UuDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1i
eTogUmFkaGV5IFNoeWFtIFBhbmRleSA8cmFkaGV5LnNoeWFtLnBhbmRleUBhbWQuY29tPg0KPiA+
ID4gLS0tDQo+ID4gPiBDaGFuZ2VzIGZvciB2MzoNCj4gPiA+IEluIHYyIHJldmlldyBhcyBzdWdn
ZXN0ZWQgYnkgVGhpbmggTmd1eWVuLCBzd2l0Y2ggdG8gc3dub2RlDQo+ID4gaW1wbGVtZW50YXRp
b24NCj4gPiA+IGZvciBwYXNzaW5nIEdTQlVTQ0ZHMCBjYWNoZSBiaXRzIGZyb20gQU1ELXhpbGlu
eCBkd2MzIGdsdWUgZHJpdmVyIHRvDQo+ID4gPiBjb3JlIGRyaXZlci4NCj4gPiA+DQo+ID4gPiBD
aGFuZ2VzIGZvciB2MjoNCj4gPiA+IE1ha2UgR1NCVVNDRkcwIGNvbmZpZ3VyYXRpb24gc3BlY2lm
aWMgdG8gQU1ELXhpbGlueCBwbGF0Zm9ybS4NCj4gPiA+IFRha2VuIHJlZmVyZW5jZSBmcm9tIGV4
aXN0aW5nIGNvbW1pdCBlYzVlYjQzODEzYTQgKCJ1c2I6IGR3YzM6IGNvcmU6DQo+ID4gPiBhZGQg
c3VwcG9ydCBmb3IgcmVhbHRlayBTb0NzIGN1c3RvbSdzIGdsb2JhbCByZWdpc3RlciBzdGFydCBh
ZGRyZXNzIikNCj4gPiA+DQo+ID4gPiB2MSBsaW5rOg0KPiA+ID4NCj4gPiBodHRwczovL3VybGRl
ZmVuc2UuY29tL3YzL19faHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjMxMDEzMDUzNDQ4
LjExDQo+ID4gMDU2LTEtcGl5dXNoLm1laHRhQGFtZC5jb21fXzshIUE0RjJSOUdfcGchY09vV3ht
YWN4UGVZVkN4RGZnMy0NCj4gPiB4bFFMaEttOE1JRWd3V3g0NWNMUWpnd1JXQTRlNFF5WV9rR1ZW
SG8ybV9kY1JicEJRRUZwQjlKc1lQNg0KPiA+IG56YXNLMkFJQXN5ZWZqUSQNCj4gPiA+IC0tLQ0K
PiA+ID4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5jICAgICAgICB8IDI0ICsrKysrKysrKysrKysr
KysrKysrKysrKw0KPiA+ID4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5oICAgICAgICB8ICA4ICsr
KysrKysrDQo+ID4gPiAgZHJpdmVycy91c2IvZHdjMy9kd2MzLXhpbGlueC5jIHwgMTggKysrKysr
KysrKysrKysrKystDQo+ID4gPiAgMyBmaWxlcyBjaGFuZ2VkLCA0OSBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMv
Y29yZS5jIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gPiA+IGluZGV4IDdlZTYxYTg5NTIw
Yi4uMTU5ZDIxYjI1NjI5IDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3Jl
LmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ID4gPiBAQCAtMjMsNiAr
MjMsNyBAQA0KPiA+ID4gICNpbmNsdWRlIDxsaW51eC9kZWxheS5oPg0KPiA+ID4gICNpbmNsdWRl
IDxsaW51eC9kbWEtbWFwcGluZy5oPg0KPiA+ID4gICNpbmNsdWRlIDxsaW51eC9vZi5oPg0KPiA+
ID4gKyNpbmNsdWRlIDxsaW51eC9vZl9hZGRyZXNzLmg+DQo+ID4gPiAgI2luY2x1ZGUgPGxpbnV4
L29mX2dyYXBoLmg+DQo+ID4gPiAgI2luY2x1ZGUgPGxpbnV4L2FjcGkuaD4NCj4gPiA+ICAjaW5j
bHVkZSA8bGludXgvcGluY3RybC9jb25zdW1lci5oPg0KPiA+ID4gQEAgLTU5OSw2ICs2MDAsMTkg
QEAgc3RhdGljIHZvaWQgZHdjM19jYWNoZV9od3BhcmFtcyhzdHJ1Y3QgZHdjMw0KPiA+ICpkd2Mp
DQo+ID4gPiAgCQlwYXJtcy0+aHdwYXJhbXM5ID0gZHdjM19yZWFkbChkd2MtPnJlZ3MsDQo+ID4g
RFdDM19HSFdQQVJBTVM5KTsNCj4gPiA+ICB9DQo+ID4gPg0KPiA+ID4gK3N0YXRpYyB2b2lkIGR3
YzNfY29uZmlnX3NvY19idXMoc3RydWN0IGR3YzMgKmR3YykNCj4gPiA+ICt7DQo+ID4gPiArCWlm
IChvZl9kbWFfaXNfY29oZXJlbnQoZHdjLT5kZXYtPm9mX25vZGUpKSB7DQo+ID4gDQo+ID4gVGhp
cyBjYW4gYmUgYXBwbGljYWJsZSBvdXRzaWRlIG9mIG9mX25vZGUsIGRvIHdlIG5lZWQgdGhpcyBp
ZiBjYXNlPw0KPiANCj4gVGhpcyBvZl9kbWFfaXNfY29oZXJlbnQgZGV0ZWN0IHByZXNlbmNlIG9m
IGRtYS1jb2hlcmVudCBwcm9wZXJ0eSANCj4gaW4gZHdjMyBub2RlIGFuZCB0aGVuIGlmIHByb3Bl
cnkgaXMgcHJlc2VudCB3ZSBwcm9ncmFtIA0KPiBHU0JVU0NGRzBfUkVRSU5GTy4NCj4gDQo+IEFs
dGVybmF0aXZlbHkgZ2x1ZSBkcml2ZXIgY2FuIGFsc28gcmVhZC9kZXRlY3QgRFdDMyBub2RlIGRt
YS1jb2hlcmVudCANCj4gcHJvcGVydHkgYW5kIHRoZW4gb3ZlcnJpZGUgIHNucHMsYWNhY2hlLWRh
dGEtcmQtd3ItaW5mbyB2YWx1ZSBvbmx5IA0KPiBpZiBkbWEtY29oZXJlbnQgcHJvcGVydHkgaXMg
cHJlc2VudC4gDQoNClRoZSB1c2VyL2Rlc2lnbmVyIG9mIHRoZSBwbGF0Zm9ybSBzaG91bGQgZGVj
aWRlIHdoZXRoZXIgdGhpcyBwcm9wZXJ0eSBpcw0KYXBwbGljYWJsZSB0byB0aGUgcGxhdGZvcm0u
IEluIHRoaXMgY2FzZSwgdGhpcyBsb2dpYyBzaG91bGQgYmUgYXBwbGllZA0KZnJvbSB5b3VyIGds
dWUgZHJpdmVyLiBJZiB0aGUgdXNlciBzZXRzIHRoaXMgcHJvcGVydHksIGFwcGx5IHRoZSB2YWx1
ZQ0KdG8gdGhlIEdTQlVTQ0ZHMCByZWdhcmRsZXNzIG9mIGRtYS1jb2hlcmVudC4NCg0KPiANCj4g
T3IgZG8geW91IG1lYW4gd2Ugc2hvdWxkIHN1cHBvcnQgcHJlc2VuY2Ugb2YgZG1hLWNvaGVyZW50
DQo+IHByb3BlcnR5IGluIGVpdGhlciBwYXJlbnQgbm9kZSAoInhsbngsenlucW1wLWR3YzMiKSBv
ciBjaGlsZA0KPiBub2RlKHNucHMsZHdjMyk/DQoNClNlZSBhYm92ZS4NCg0KPiANCj4gPiANCj4g
PiA+ICsJCXUzMiByZWc7DQo+ID4gPiArDQo+ID4gPiArCQlyZWcgPSBkd2MzX3JlYWRsKGR3Yy0+
cmVncywgRFdDM19HU0JVU0NGRzApOw0KPiA+ID4gKwkJcmVnICY9DQo+ID4gfkRXQzNfR1NCVVND
RkcwX0RBVF9ERVNfUkRfV1JfUkVRSU5GT19NQVNLOw0KPiA+ID4gKwkJcmVnIHw9IChkd2MtPmFj
YWNoZV9kYXRhX3JkX3dyX2luZm8gPDwNCj4gPiANCj4gPiBXaGF0IGlmIHRoZSB1c2VyIGRvZXNu
J3Qgc3BlY2lmeSB0aGlzIHByb3BlcnR5PyBXZSBzaG91bGQgbm90DQo+ID4gYXV0b21hdGljYWxs
eSB3cml0ZSAwIGJ5IGRlZmF1bHQuDQo+IA0KPiBVU0IzIDMuMzBhIGNvcmUgY29uZmlndXJlZCBm
b3IgMi4wIEkgc2VlIHJlc2V0IHZhbHVlIGZvciANCj4gR1NCVVNDRkcwIFszMToxNl0gYml0cyBh
cmUgMC4gIFdpbGwgY3Jvc3MtY2hlY2sgaXQgZm9yIG90aGVyDQo+IHZlcnNpb25zLg0KDQpPdGhl
ciBwbGF0Zm9ybSBtYXkgaGF2ZSBhIGRlZmF1bHQgc2V0dGluZyBmcm9tIGNvcmVDb25zdWx0YW50
IHRoYXQncyBub3QNCjAuIExldCdzIG5vdCB3cml0ZSAwIGJ5IGRlZmF1bHQuDQoNCj4gDQo+ID4g
DQo+ID4gPiArDQo+ID4gCURXQzNfR1NCVVNDRkcwX0RBVF9ERVNfUkRfV1JfUkVRSU5GT19TSElG
VCk7DQo+ID4gPiArCQlkd2MzX3dyaXRlbChkd2MtPnJlZ3MsIERXQzNfR1NCVVNDRkcwLCByZWcp
Ow0KPiA+ID4gKwl9DQo+ID4gPiArfQ0KPiA+ID4gKw0KPiA+ID4gIHN0YXRpYyBpbnQgZHdjM19j
b3JlX3VscGlfaW5pdChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiA+ID4gIHsNCj4gPiA+ICAJaW50IGlu
dGY7DQo+ID4gPiBAQCAtMTMyMCw2ICsxMzM0LDggQEAgc3RhdGljIGludCBkd2MzX2NvcmVfaW5p
dChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiA+ID4NCj4gPiA+ICAJZHdjM19zZXRfaW5jcl9idXJzdF90
eXBlKGR3Yyk7DQo+ID4gPg0KPiA+ID4gKwlkd2MzX2NvbmZpZ19zb2NfYnVzKGR3Yyk7DQo+ID4g
PiArDQo+ID4gPiAgCXJldCA9IGR3YzNfcGh5X3Bvd2VyX29uKGR3Yyk7DQo+ID4gPiAgCWlmIChy
ZXQpDQo+ID4gPiAgCQlnb3RvIGVycl9leGl0X3BoeTsNCj4gPiA+IEBAIC0xNTc0LDYgKzE1OTAs
NyBAQCBzdGF0aWMgdm9pZCBkd2MzX2dldF9wcm9wZXJ0aWVzKHN0cnVjdCBkd2MzDQo+ID4gKmR3
YykNCj4gPiA+ICAJdTgJCQl0eF9tYXhfYnVyc3RfcHJkID0gMDsNCj4gPiA+ICAJdTgJCQl0eF9m
aWZvX3Jlc2l6ZV9tYXhfbnVtOw0KPiA+ID4gIAljb25zdCBjaGFyCQkqdXNiX3BzeV9uYW1lOw0K
PiA+ID4gKwlzdHJ1Y3QgZGV2aWNlCQkqdG1wZGV2Ow0KPiA+ID4gIAlpbnQJCQlyZXQ7DQo+ID4g
Pg0KPiA+ID4gIAkvKiBkZWZhdWx0IHRvIGhpZ2hlc3QgcG9zc2libGUgdGhyZXNob2xkICovDQo+
ID4gPiBAQCAtMTcxNiw2ICsxNzMzLDEzIEBAIHN0YXRpYyB2b2lkIGR3YzNfZ2V0X3Byb3BlcnRp
ZXMoc3RydWN0IGR3YzMNCj4gPiAqZHdjKQ0KPiA+ID4gIAlkd2MtPmRpc19zcGxpdF9xdWlyayA9
IGRldmljZV9wcm9wZXJ0eV9yZWFkX2Jvb2woZGV2LA0KPiA+ID4gIAkJCQkic25wcyxkaXMtc3Bs
aXQtcXVpcmsiKTsNCj4gPiA+DQo+ID4gPiArCS8qIEl0ZXJhdGUgb3ZlciBhbGwgcGFyZW50IG5v
ZGVzIGZvciBmaW5kaW5nIHN3bm9kZSBwcm9wZXJ0aWVzICovDQo+ID4gPiArCWZvciAodG1wZGV2
ID0gZHdjLT5kZXY7IHRtcGRldjsgdG1wZGV2ID0gdG1wZGV2LT5wYXJlbnQpIHsNCj4gPiA+ICsJ
CWRldmljZV9wcm9wZXJ0eV9yZWFkX3UxNih0bXBkZXYsDQo+ID4gPiArCQkJCQkgInNucHMsYWNh
Y2hlLWRhdGEtcmQtd3ItaW5mbyIsDQo+ID4gPiArCQkJCQkgICZkd2MtPmFjYWNoZV9kYXRhX3Jk
X3dyX2luZm8pOw0KPiA+ID4gKwl9DQo+ID4gPiArDQo+ID4gDQo+ID4gUGxlYXNlIHNwbGl0IHRo
aXMgdG8gYSBzZXBhcmF0ZSBmdW5jdGlvbiBhbmQgbmFtZSBpdCBhcw0KPiA+IGR3YzNfZ2V0X3Nv
ZnR3YXJlX3Byb3BlcnRpZXMoKS4gRm9yIG5vdywganVzdCB0aGUgbmV3IHByb3BlcnR5IHlvdQ0K
PiA+IGNyZWF0ZSBpcyBmaW5lLiBXZSBjYW4gaW50cm9kdWNlIG5ldyBwYXRjaGVzIHRvIG1vdmUg
YWxsIHRoZSBzb2Z0d2FyZQ0KPiA+IGRlZmluZWQgcHJvcGVydGllcyAoaWUuIG5vbiBBQkkvRFMp
IHRoZXJlIHN1Y2ggYXMgc3lzZGV2X2lzX3BhcmVudC4NCj4gDQo+IFN1cmUgLCB3aWxsIHNwbGl0
IGl0IHRvIHNlcGFyYXRlIHBhdGNoLg0KPiA+IA0KPiA+ID4gIAlkd2MtPmxwbV9ueWV0X3RocmVz
aG9sZCA9IGxwbV9ueWV0X3RocmVzaG9sZDsNCj4gPiA+ICAJZHdjLT50eF9kZV9lbXBoYXNpcyA9
IHR4X2RlX2VtcGhhc2lzOw0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9k
d2MzL2NvcmUuaCBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+ID4gPiBpbmRleCAzNzgxYzcz
NmMxYTEuLjU3YjNjYjczOTM1MyAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMv
Y29yZS5oDQo+ID4gPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiA+ID4gQEAgLTE5
NCw2ICsxOTQsMTAgQEANCj4gPiA+ICAjZGVmaW5lIERXQzNfR1NCVVNDRkcwX0lOQ1JCUlNURU5B
CSgxIDw8IDApIC8qIHVuZGVmaW5lZCBsZW5ndGgNCj4gPiBlbmFibGUgKi8NCj4gPiA+ICAjZGVm
aW5lIERXQzNfR1NCVVNDRkcwX0lOQ1JCUlNUX01BU0sJMHhmZg0KPiA+ID4NCj4gPiA+ICsvKiBH
bG9iYWwgU29DIEJ1cyBDb25maWd1cmF0aW9uIFJlZ2lzdGVyOiBBSEItcHJvdC9BWEktY2FjaGUv
T0NQLQ0KPiA+IFJlcUluZm8gKi8NCj4gPiA+ICsjZGVmaW5lIERXQzNfR1NCVVNDRkcwX0RBVF9E
RVNfUkRfV1JfUkVRSU5GT19NQVNLDQo+ID4gCUdFTk1BU0soMzEsIDE2KQ0KPiA+IA0KPiA+IENh
biB3ZSByZW5hbWUgdGhpcyB0byBEV0MzX0dTQlVTQ0ZHMF9SRVFJTkZPX01BU0sNCj4gDQo+IFll
cywgd2lsbCBkbyBpdCBpbiBuZXh0IHZlcnNpb24uDQo+IA0KPiA+IA0KPiA+ID4gKyNkZWZpbmUg
RFdDM19HU0JVU0NGRzBfREFUX0RFU19SRF9XUl9SRVFJTkZPX1NISUZUCTE2DQo+ID4gDQo+ID4g
V2UgZG9uJ3QgbmVlZCBhIHNoaWZ0IHZhbHVlLiBFaXRoZXIgZGVmaW5lIERXQzNfR1NCVVNDRkcw
X1JFUUlORk8obikgb3INCj4gPiB1c2UgRklFTERfUFJFUCBhbmQgdGhlIG1hc2suDQo+IA0KPiBZ
ZXMsIHdpbGwgZml4IGl0IGluIG5leHQgdmVyc2lvbi4NCj4gPiANCj4gPiA+ICsNCj4gPiA+ICAv
KiBHbG9iYWwgRGVidWcgTFNQIE1VWCBTZWxlY3QgKi8NCj4gPiA+ICAjZGVmaW5lIERXQzNfR0RC
R0xTUE1VWF9FTkRCQwkJQklUKDE1KQkvKiBIb3N0IG9ubHkNCj4gPiAqLw0KPiA+ID4gICNkZWZp
bmUgRFdDM19HREJHTFNQTVVYX0hPU1RTRUxFQ1QobikJKChuKSAmIDB4M2ZmZikNCj4gPiA+IEBA
IC0xMTUzLDYgKzExNTcsOSBAQCBzdHJ1Y3QgZHdjM19zY3JhdGNocGFkX2FycmF5IHsNCj4gPiA+
ICAgKiBAbnVtX2VwX3Jlc2l6ZWQ6IGNhcnJpZXMgdGhlIGN1cnJlbnQgbnVtYmVyIGVuZHBvaW50
cyB3aGljaCBoYXZlDQo+ID4gaGFkIGl0cyB0eA0KPiA+ID4gICAqCQkgICAgZmlmbyByZXNpemVk
Lg0KPiA+ID4gICAqIEBkZWJ1Z19yb290OiByb290IGRlYnVnZnMgZGlyZWN0b3J5IGZvciB0aGlz
IGRldmljZSB0byBwdXQgaXRzIGZpbGVzIGluLg0KPiA+ID4gKyAqIEBhY2FjaGVfZGF0YV9yZF93
cl9pbmZvOiBzdG9yZSBHU0JVU0NGRzAuREFUUkRSRVFJTkZPLA0KPiA+IERFU1JEUkVRSU5GTywN
Cj4gPiA+ICsgKiAgICAgICAgICAgICAgICAgICAgICAgICAgREFUV1JSRVFJTkZPLCBhbmQgREVT
V1JSRVFJTkZPIHZhbHVlIHBhc3NlZCBmcm9tDQo+ID4gPiArICogICAgICAgICAgICAgICAgICAg
ICAgICAgIGdsdWUgZHJpdmVyLg0KPiA+ID4gICAqLw0KPiA+ID4gIHN0cnVjdCBkd2MzIHsNCj4g
PiA+ICAJc3RydWN0IHdvcmtfc3RydWN0CWRyZF93b3JrOw0KPiA+ID4gQEAgLTEzODAsNiArMTM4
Nyw3IEBAIHN0cnVjdCBkd2MzIHsNCj4gPiA+ICAJaW50CQkJbGFzdF9maWZvX2RlcHRoOw0KPiA+
ID4gIAlpbnQJCQludW1fZXBfcmVzaXplZDsNCj4gPiA+ICAJc3RydWN0IGRlbnRyeQkJKmRlYnVn
X3Jvb3Q7DQo+ID4gPiArCXUxNgkJCWFjYWNoZV9kYXRhX3JkX3dyX2luZm87DQo+ID4gDQo+ID4g
SWYgd2UgZG8gbmVlZCB0byBrZWVwIHRoaXMgZmllbGQgYXJvdW5kLCBwbGVhc2UgZGVmaW5lIHRo
ZSBkZWZhdWx0DQo+ID4gZm9yIHVuc3BlY2lmaWVkIHZhbHVlLiBBbHNvIHJlbmFtZSB0aGlzIHRv
IGdzYnVzY2ZnMF9yZXFpbmZvLg0KPiANCj4gU3VyZS4gd2lsbCBkZWZpbmUgZGVmYXVsdCAobGlr
ZWx5IDAgKSBhbmQgcmVuYW1lIGl0IHRvIGdzYnVzY2ZnMF9yZXFpbmZvIA0KPiBpbiBuZXh0IHZl
cnNpb24uDQoNClRoZSBkZWZhdWx0IHNob3VsZCBzaG91bGQgbm90IGJlIGEgdmFsaWQgdmFsdWUg
dGhhdCBjYW4gYmUgc2V0LiBQZXJoYXBzDQp1c2UgdHlwZSB1MzIgYW5kIGRlZmluZSAweGZmZmZm
ZmZmIGFzIHVuc3BlY2lmaWVkPw0KDQpUaGFua3MsDQpUaGluaA==

