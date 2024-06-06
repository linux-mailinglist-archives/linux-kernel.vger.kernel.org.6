Return-Path: <linux-kernel+bounces-203710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D143B8FDF56
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFF361C23EAD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 07:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0931713B2BC;
	Thu,  6 Jun 2024 07:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="bWaIadDT";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="TxVB+X0R";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="GCyGUTw4"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDC613AD0E;
	Thu,  6 Jun 2024 07:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717657956; cv=fail; b=UaXccSHA72NfHTknyjRYc0O70h6r1L8ZfN1LZ704kJPBNKBk0Mp5in8ymfSMxpJnHvXdJ8s6mm+Tr3AWvMO2/R8sVIjH7iLjJEp7Q5AdgmOuFk72+0vZnJBbmxuXx8+oHH4Mf7WrLWt8Gvh7BThZbhVD83gmq0wqxoeMXwLytcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717657956; c=relaxed/simple;
	bh=//zDyZGLTXAVVkWAlbq7LKo0YN7I1lyOmgk0f0BHKSU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qEk9gIMhIlpVMrKuRCAesjsuVoojhsPU81/ecSuAPBn/Hx+pEvaADVZ+i2NKcUU9iC9aOrSch1BFQhbf9Tc5bFmMBCL0Z88PXSPjJQKVXw25sLM5DRFyu4MscS8sIR97jWIm8+tL2qu2V9j5+qqQNcJ3aTsX9ZzzDdWy21+7V0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=bWaIadDT; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=TxVB+X0R; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=GCyGUTw4 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4561ko9L032322;
	Thu, 6 Jun 2024 00:12:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=//zDyZGLTXAVVkWAlbq7LKo0YN7I1lyOmgk0f0BHKSU=; b=
	bWaIadDTfwLr1rPw0CqNPMQP+Zm6I5r4LWtXGsORiCta5pdemXqeuIo+AlPc78hb
	svGim4OffE06szXmtCm9b8ZMjtuy9IhtWzRHw5yflmWcuDwP6ZrRYNzwyQ9jU9nG
	WcPvnSVx3IEMvwYkVOeXx3BQ84Bu/mxj1W+Msws5wvRebhkpEF5S9uvp4Hxi0FWO
	8PmHLxL/HIzRF8s5vKcrwNLx/gnh8EjM1aqYYv5rKG+225tPEMp5oTd/RNu+3ZeS
	18ZVt6x7XL2wAkuJWUJjJvsrb5dc9BexARwv0lctBpfkRVkuIcn5sUmVCX8GINOe
	xJ7WMgMfMqAZaGP7rLCCUA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3yg2jscx4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Jun 2024 00:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1717657934; bh=//zDyZGLTXAVVkWAlbq7LKo0YN7I1lyOmgk0f0BHKSU=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=TxVB+X0RCwfsaV9SuD/0JzjhPzXooTgMT3vWL7DOaC+U3twisy3MOTv3hLes+XsIr
	 Ztg2D1CQu/Dg/4sMn4lK6rWRQxisycCrcDcptE1nfAElbDz/twx7RBrPGie2YCMJbM
	 sVHzoAbXHen+48TA1SJw/Xh9iJVw8TgPzF0LjcxY0eWLB8up6D4uWdvDgQsxwrnm+7
	 6XVYSu9TpWHqweYykz3yd6wNSjtvibVF4wJp5NsGVqOOCLfWLAMKbjGdmwbyfvDLl1
	 y3cfgkf7SqM66iItJ3oiKUlSvl8JuM5sUBn5KKFYEXivru/0XsRD6hRJStBF3Ct0VS
	 6mwZEq1ANsm8w==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6070E40141;
	Thu,  6 Jun 2024 07:12:13 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id A7004A00B4;
	Thu,  6 Jun 2024 07:12:12 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=GCyGUTw4;
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 596AC4013F;
	Thu,  6 Jun 2024 07:12:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkSljtnAouByFaCjygrtXuxxqdLz5lcNQ9HHrUyHU/sOl6O0lhkwmRXbDuJwimeH+BiOcSnMufzayDjuYsTlf13cAIa+cOeS6aC/Up1qCOh0NYLqdF6BhqCVitvmWyFJY9NVJwtZLg1XqUpJsKTtgL7flrTSoKCm29MJAyDdeyg9gQ4YB433whPz+Ypn7veZrD2ooZzTzcYF3YWGOq6EzMH4ppF5zDJjzmY/nOXlpkUOWVRJzBRXgv8vj/ABlKwM8XGGQDiWnSIIfzNvRxcZrvCqZLxBAXmHiKIo0mDoEogiSKQZSJha0B72FAFyRotRxU1k/6vIQFfzYYIbkLFaqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=//zDyZGLTXAVVkWAlbq7LKo0YN7I1lyOmgk0f0BHKSU=;
 b=kuk5+f8rcxswQgbNZodxA2/CzYO1DJOGjVPIQ/gvoPsyimm6mg102hMA5CmRSjaBdycSs1I/XhtAZ4atxZUZUKUSBVzSAOakmzX64eZ3NO4FclAqDQd5NIK9YndOitJjTJlbyONeL2Y74cOuu0LzoH2/JFG6slJ8ZIBAW+T6Qh2hQ//DuZVJtEVwUCfEgmoSq03Yuj4Cl4yl/aHjbXMysXqYgazp2VxZaVVQgZcZqAOWY0rn+l7aaCnvnHJ40xfJD0iYHuiY1L1UKfoOa8ymvDKhwnkRz5JqRqAPtQULVPC7VpIERN9sdyBZJ4jcNaiS3hbTTohjGLlGT8Jqs0O5oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//zDyZGLTXAVVkWAlbq7LKo0YN7I1lyOmgk0f0BHKSU=;
 b=GCyGUTw4drrEZmb+HqqtWS/bi7ce+Ad9OnH8yghkeBAKlzZr6fzIUQsIOqEmfZnuiaGcvZ3EVlJGvoYPhtlt/d5pPoO/9XQOMCACiN+lss+KAaE65gLgWbht5Wx+Vo+F6oDMjoz5ZxjO0Gq1HYzUKRRfSvwtnUhIPvBg1UEd3iI=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by PH7PR12MB7841.namprd12.prod.outlook.com (2603:10b6:510:273::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 6 Jun
 2024 07:12:08 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%4]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 07:12:08 +0000
X-SNPS-Relay: synopsys.com
From: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To: Peng Hongchi <hongchi.peng@siengine.com>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc2: gadget: Don't write invalid mapped sg entries
 into dma_desc with iommu enabled
Thread-Topic: [PATCH] usb: dwc2: gadget: Don't write invalid mapped sg entries
 into dma_desc with iommu enabled
Thread-Index: AQHarPh7vdTgcai09E6eiMHswsBaHrG6Z7wA
Date: Thu, 6 Jun 2024 07:12:08 +0000
Message-ID: <2ee9afe4-4efd-6f07-7e61-37fec8dc50d5@synopsys.com>
References: <20240523100315.7226-1-hongchi.peng@siengine.com>
In-Reply-To: <20240523100315.7226-1-hongchi.peng@siengine.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|PH7PR12MB7841:EE_
x-ms-office365-filtering-correlation-id: 4e1c545c-626c-4489-41c8-08dc85f7fa7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?ZDlCazZMTHIrQ1JZRU1Fb2JoY3FxdFRaMlpKZ0tzWHg4TmZYaU9xNmRxR0JL?=
 =?utf-8?B?SnYwNVVQdWl4ZTVoVktWVWkvSGdhQjdkNGFCNENwUmNJT0dGWVBCUitnUWps?=
 =?utf-8?B?dVhZUGl1dmMzV3VJS3FyR3NUaHVFenJnOGI1ZlNCV3N2ODNnTEx3LzNucWdx?=
 =?utf-8?B?Q2IrYWR4a3c3a2RoMmRqYVFMRWFJTVVlc1hWYTVlRWF2VzBPTXNVakhQMVRi?=
 =?utf-8?B?Yk5sWnM3aVpEVnRuaUtBUEFIVCtybll1QXVUYVNpc0ZMRnpHUkdVYU5jOXp1?=
 =?utf-8?B?TTdxN2w4bEgyUmJNVThLeERVQ3VpaDdieDlkVWJYWkw3WGJqa1ZXKzlDUnpZ?=
 =?utf-8?B?aFNXaVd5RERuUFU0RkN5dDZYdmIyak9rZ3lSY2FnVVZZOEtBZS9sVHNCQ0N5?=
 =?utf-8?B?a0I1NVhobG1MWUxzR0hLTkdYSm9XeDlDenViMnhONC8vSWJvT1dvamdjUEhj?=
 =?utf-8?B?cFNMbEcvdDQvL0Zjd1lRMjNDL1FSa2ZXWDU2R3l6dHUwNGdpaFBCS2RLTkZC?=
 =?utf-8?B?dEFGQzBINjdCU0hldENSbWV0NnZMOHFXQzBmUk0yUWhEbERWM04rVHJ0aEJS?=
 =?utf-8?B?SEtEQlF0SWYvZ1h5a2tBWi8wV3ZPR29EVjIwalM2a1FuUXR4ZnhKNUE4YU1W?=
 =?utf-8?B?NWxhcXVKRU5yRWFjY3hsSzJzbFYwWEhLdHNBT3ZIeDVmaEx6VCtOVmpNQTRL?=
 =?utf-8?B?enNhTkZ0TS9aOFpEUGNCS3NFU2pCb0FCU3MrQ3Z3YWViRHozdy85VGtod1Nv?=
 =?utf-8?B?dmZQQno3emFRL1VBakordFRqODZlTi83RGoxZDRSN3VKS1VRVDBnL0lqNml6?=
 =?utf-8?B?dDFMVlRpemZld1p1akxHNVpBTEVnY3d5NkVWK3p2YmVQaTRDK05nR3c4RDYz?=
 =?utf-8?B?djBud2VOeXoyam1QcVEyZ1QrZUJsT00vRmkzdjRhUzBTNmFVaXpMSmZtdkpi?=
 =?utf-8?B?OFBqOGFraXZIN0tGWmVnTndjOEttL3NSdGs3Zjd6cysydFZkRHpjNHpUcit1?=
 =?utf-8?B?WlRod1BSOGVEc0IyWXMvbTlnT05nTmtUU0JncVRicTZiTVI0ak9TQWZ6c1Rp?=
 =?utf-8?B?b2UzdnpmN1MwODZQYnNmdUJXWDlDa3ZLTllsVjhIZmZmdzZZTHJKcm9MREJp?=
 =?utf-8?B?cThmbVRGb3NKYS9NbW5US0F5V2d4ajQxV3V4dEU2ZWpkcEtST1dHRzc4UmxW?=
 =?utf-8?B?V2M2MFZ5M1VKakF3UWwvSklqc1ZYcGdnamZ1amg2ZGxPN2c5d1AxRDNhZFdJ?=
 =?utf-8?B?bGhqemRGb2dYUlZBVDZxNmF1YWpKaVBFTHdHdGpvOGFMMlBRL2ZLT2dIdjNj?=
 =?utf-8?B?anJ4K283N0dsajJPMlVZbFlUSzhJSG12WlhYbkZQMlJibSsyV1JoalNLdWlm?=
 =?utf-8?B?L1dKUUtwd1dXbng2a3h1RUZDcGU2a1ZOKzdKL1czQlBvSkZGZFFQV0xlaFRH?=
 =?utf-8?B?R0dZdldybzkzVmpna0t4WnZ4c3Rkb2lWWlJlR3hOemgwMVU2Sk8vUTk3ZUJT?=
 =?utf-8?B?RktYK3JpSTlvVlFEaWt4VjNGRUhRTGpCc3lwcStxUi8yZ2U1Y1BhVU9zYnor?=
 =?utf-8?B?Q3VvZXplNGZEVzdma0xpVDV5S0orb3FZSE1vdlZLZ0d3cUE5OEE0WHhIT3c0?=
 =?utf-8?B?SnFIOWlSYzJ6b2hrZ2ZXUWZNY3VLVjRQc1Z0Tk1ZL3gyNnlYNTZUSGljTkZK?=
 =?utf-8?B?cXBXU1dmOE9oK0pwb2J3TTBPVTRZdzNFSmlXb1VlS3N2QUZkUHdJcDBXejA3?=
 =?utf-8?B?SC9FdU8vY0xPTFd5M0JXdzBwYUNQamg3azNtY0NtMGxGbkpVdGMvUE55TzJz?=
 =?utf-8?Q?pXEIjPwWSrNO7cZCgpeQe8XvWQ7jMNrsWqnz8=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB8796.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?QityUk1HOXl6Tmg5cHIrdWVuencvUnFaQklad1J5dEJxaTNCQm8yRDNCbndC?=
 =?utf-8?B?SFI4N3RpaXYzSzdJSUIwNWJOTGlKa0k3SnJianNDRjh3RWJDNCt3UzhIOUMy?=
 =?utf-8?B?NlI4TS9mOHd5ZzVTOE4xL0V0NndCUnpFQ2RWZGNpZlBTTU9uZTg3UFRSamp1?=
 =?utf-8?B?SGtTeTZQNlFxQW9rLzFVbE9iYzBRazZUN2pNR0h5cXordEk4aDhMZG1MQko1?=
 =?utf-8?B?UVZUcXVUR0g1czdIaUhYUkYzQVA2TStZMm85eHFoRnBDRU54VWowanVEY01C?=
 =?utf-8?B?Q25rTnZUbjJEanVTc0NzRStHSWJJdERLa3dJQzk2WnlOazZWTUZlcGF3U0ZU?=
 =?utf-8?B?dWRwd1VrdWpEWTlrZSttNDdlbTNBakxZWW9UYVRueE9iMTBwWEVpV2RGZ2hB?=
 =?utf-8?B?TmJtcksxWjR4cTYvYm5SNXBtOUpqSVV2RU1lWXlRMWVFc2VtOXZuUmRPQjNG?=
 =?utf-8?B?L1ZycStPZEpHV01UUkoxN2JjREg0V0dSbHZHUytzMXE1UnNPRWpnemVQRlI5?=
 =?utf-8?B?Q1NMZTZFOUtaWjRQcFZJTlhQQlU4dVMzMlJHb201MGxvZmxqcmlZR25CS3NE?=
 =?utf-8?B?Q29UQXd1dnBwWlVHcE5JUEhGc29zbHY4aXJmYWVZeHpRU2djdSthNnU1emlw?=
 =?utf-8?B?M3NWQnlZTUlSVGFtSkJVM2g1T0JSNWhHMGhqWVRwMjgrU2gxZ2FuMkdoM2F5?=
 =?utf-8?B?VWNVRGdTajA0eTB2SzlTNEtib3hJUDlaZnlzd3JsZ2ZEd3JmTzI0bnlHM1dC?=
 =?utf-8?B?QWI2SXNlNnozL1o4b2IzaVJoR3NzdUlWdU9kZXNQQU1wVklROStSdXZ5MUMw?=
 =?utf-8?B?UGpYM1RUWlVZTHk2L0VBalJKZGNvVVhhK0pRY2h0YzNQaktlemd2cTR3ZlFR?=
 =?utf-8?B?TjhEdVBjVDJabU1BZ3FqQkllbC9kSjlGaklPcWNHNU1kU0VTQW1sOGtmYkw3?=
 =?utf-8?B?SzIyOWFmakYzYlY2R2NLKzl1VGprT01yS3B0M2VVRE15aittcGRhNllBSWlt?=
 =?utf-8?B?M1NlNmYzR1ZOWTJmMXppNm4yb1h5TkROa2dsYWtMMlVYWFh2b3BLb2o0a3RP?=
 =?utf-8?B?U1JtWnJpemV4WGhGOXo2SGtzRHYyTHBIZ1Y3MEdkNjcyNUQrMk1RQ05CYkR0?=
 =?utf-8?B?Z3FacEgvVkM3OUpGZU5FalVEc0R3Z0hhbDZZRGlWamZyVElIZGRGeG5QblNk?=
 =?utf-8?B?QnFkSmJXSDdlOVFrRzBOQTYrL2FFQ3hmcW9ZRzgvbWNxNHBkaDhjMmdUUmhN?=
 =?utf-8?B?Sll2UW1tOTJwck1xUG4xbVFHbmtoNEhRODBLQjZZNkZPM0liV1dUNmpnaVNk?=
 =?utf-8?B?Y2ZQMnF6S3QzbUVXZGZXRHljTjZtSnllcGtIK1JaWk9QWWJiS0d4MTh5QzUx?=
 =?utf-8?B?S2o2M2c2TzQyRkZHSmpUUjdPSk5RQUlaQkFQcDJSN01FYm1RQUg4T1lLY3pa?=
 =?utf-8?B?ZlVHMEZFVk1YaGtwRzVWY2NQMFZielczMUczc3lBTG16NmY1S0ViSmlsOUtN?=
 =?utf-8?B?NDBaUzdldTFrOWxPTDVuZ2RDMHN4NFVnZStySmRFaHdQMGJ3ZmFJMjY2MmFG?=
 =?utf-8?B?bXZTKzNHTVkveFlSUVpuTkNyU3JmaEQxakp3dm5KTi9RNVJZY3dmcDA1ZzMv?=
 =?utf-8?B?WVJSd1diVlF6UlhhcEYzcGNCeE1ua3dFc0RJWEpWQklTRlE5U3hycTFtaDlL?=
 =?utf-8?B?VVlJcVkxNldQM0VuV0EzRjUvVTR4alJ2R2Erd0dMMmVKTU1kaXY5SXFOR0ZZ?=
 =?utf-8?B?RTdqdHlRY0dlMVluQWV6a0pIVzBaZGd1OWYwc2g0Zy8waHk3OElyaG9ldkVs?=
 =?utf-8?B?SFFkYzNBTjkwMkU3dWxYY3Z2MTNqVmVGRGZsSEVCNWpyVlNWRGYvNzdPQ3Qw?=
 =?utf-8?B?QXVQS2YrMzZIdTFKZnVjb1ZSZkhucjY4Ujg4RE80ekttbk0vd1ErdzRLek9w?=
 =?utf-8?B?dC8raERzSGJwb1FDbGNTK29JSXB1YUlMNGJFV0U4dFR4L3dzNUhKQ3NpcjJn?=
 =?utf-8?B?SkpveWJ0S3p2d0hDenRkNUluY0ozcllnaFB1MitpRFZ2SzZ1Sy9kTUt1VFBI?=
 =?utf-8?B?RzIzZ1FWSGgvT2ZxVnlGOFRCbzQzekg3a0o1WmF2U2hYSmNYcW8vNmZFakdO?=
 =?utf-8?Q?dDC8ml7w9PCRGdyy64GcxNmJj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C21FCBCF36711A4FA2733418AA02CCF6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	zeKIQMJoa173S/zMzNyUZBI1F14HlOn1ZrZhEiK8K++Vj38rWktl5ul/sbhTVaQS+cwQanvqhjBmHhaC/CiTRn5ryIgoX2d4Dxp+CgRiljApWOBma7u5i2rsij/9ISfIzIGEFt7vF1zEXDYupzG8NtjQVQFpL9MWxTq50GM0feOckqJH47aZFcQbeu2B0SU9b8QUoClB2zQU10aWQMGVeLl2LNaEtA3Y880qKNFBkhROUr2cdZ13WgfLPagNQQgSrXzB3j0LNJrm1020C+kEDOXnTM2b8AJ8LrpVSdkFQSEkWK6kGkLwzVdH3gicppiFvcBAK18VBnyGXnMQZDdnrjrHq0STlQJ44ne9gQet27VJ49fr1L4VDD8Dw7c9AadrUXoBd6nakBCEnHZ3eWOygduNVFzJ84p8URP95Puh74wguuZd5cjbU65xlqkOvBkLrKdkQpxjVcyPDJQw8SoL0KJnwIzpYPLaPGc1/AN3EpcKEqHFW9N7qzrC90bQJsJuNKx8QloJhpl1a/9XMr4p5Yh+lbOVQkyVpWrtZ67HEj25UxGJtSm6HgXq0bMq3Uf3sUrwJ6/9lgHjx1JjAA7cuAwIiX70/KXIXdIjCwSfWNLpkoIfmDnY33efDMXNJWtiuM6zvVHR8b7vpCL0GjYA1A==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e1c545c-626c-4489-41c8-08dc85f7fa7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2024 07:12:08.5029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vv6b5BWzZkIuqK9h21iprzNsqf7GS/94zv8TgSo3CTGfTF3DrfDKOf3nS3dm3Z+pdZEe+k7yp8jWcLt7wmEL2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7841
X-Proofpoint-GUID: nqyAbg9BBIfXV0bljDe6_PP4yxtg_EZS
X-Proofpoint-ORIG-GUID: nqyAbg9BBIfXV0bljDe6_PP4yxtg_EZS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_01,2024-06-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=852 clxscore=1011 mlxscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406060050

DQoNCk9uIDUvMjMvMjQgMTQ6MDMsIFBlbmcgSG9uZ2NoaSB3cm90ZToNCj4gV2hlbiB1c2luZyBk
bWFfbWFwX3NnKCkgdG8gbWFwIHRoZSBzY2F0dGVybGlzdCB3aXRoIGlvbW11IGVuYWJsZWQsDQo+
IHRoZSBlbnRyaWVzIGluIHRoZSBzY2F0dGVybGlzdCBjYW4gYmUgbWVyZ2VyZCBpbnRvIGxlc3Mg
YnV0IGxvbmdlcg0KPiBlbnRyaWVzIGluIHRoZSBmdW5jdGlvbiBfX2ZpbmFsaXNlX3NnKCkuIFNv
IHRoYXQgdGhlIG51bWJlciBvZg0KPiB2YWxpZCBtYXBwZWQgZW50cmllcyBpcyBhY3R1YWxseSBz
bWFsbGVyIHRoYW4gdXJlcS0+bnVtX3JlcXMsYW5kDQo+IHRoZXJlIGFyZSBzdGlsbCBzb21lIGlu
dmFsaWQgZW50cmllcyBpbiB0aGUgc2NhdHRlcmxpc3Qgd2l0aA0KPiBkbWFfYWRkcj0weGZmZmZm
ZmZmIGFuZCBsZW49MC4gV3JpdGluZyB0aGVzZSBpbnZhbGlkIHNnIGVudHJpZXMNCj4gaW50byB0
aGUgZG1hX2Rlc2MgY2FuIGNhdXNlIGEgZGF0YSB0cmFuc21pc3Npb24gZXJyb3IuDQo+IA0KPiBU
aGUgZnVuY3Rpb24gZG1hX21hcF9zZygpIHJldHVybnMgdGhlIG51bWJlciBvZiB2YWxpZCBtYXAg
ZW50cmllcw0KPiBhbmQgdGhlIHJldHVybiB2YWx1ZSBpcyBhc3NpZ25lZCB0byB1c2JfcmVxdWVz
dDo6bnVtX21hcHBlZF9zZ3MgaW4NCj4gZnVuY3Rpb24gdXNiX2dhZGdldF9tYXBfcmVxdWVzdF9i
eV9kZXYoKS4gU28gdGhhdCBqdXN0IHdyaXRlIHZhbGlkDQo+IG1hcHBlZCBlbnRyaWVzIGludG8g
ZG1hX2Rlc2MgYWNjb3JkaW5nIHRvIHRoZSB1c2JfcmVxdWVzdDo6bnVtX21hcHBlZF9zZ3MsDQo+
IGFuZCBzZXQgdGhlIElPQyBiaXQgaWYgaXQncyB0aGUgbGFzdCB2YWxpZCBtYXBwZWQgZW50cnku
DQo+IA0KPiBUaGlzIHBhdGNoIHBvc2VzIG5vIHJpc2sgdG8gbm8taW9tbXUgc2l0dWF0aW9uLCBj
YXVzZQ0KPiB1cmVxLT5udW1fbWFwcGVkX3NncyBlcXVhbHMgdXJlcS0+bnVtX3NncyB3aGlsZSB1
c2luZyBkbWFfZGlyZWN0X21hcF9zZygpDQo+IHRvIG1hcCB0aGUgc2NhdHRlcmxpc3Qgd2hpdGgg
aW9tbXUgZGlzYWJsZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQZW5nIEhvbmdjaGkgPGhvbmdj
aGkucGVuZ0BzaWVuZ2luZS5jb20+DQoNCkFja2VkLWJ5OiBNaW5hcyBIYXJ1dHl1bnlhbiA8aG1p
bmFzQHN5bm9wc3lzLmNvbT4NCg0KPiAtLS0NCj4gICBkcml2ZXJzL3VzYi9kd2MyL2dhZGdldC5j
IHwgNCArKy0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MyL2dhZGdldC5jIGIvZHJp
dmVycy91c2IvZHdjMi9nYWRnZXQuYw0KPiBpbmRleCA3NGFjNzlhYmQ4ZjMuLmU3YmY5Y2M2MzVi
ZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMi9nYWRnZXQuYw0KPiArKysgYi9kcml2
ZXJzL3VzYi9kd2MyL2dhZGdldC5jDQo+IEBAIC04ODUsMTAgKzg4NSwxMCBAQCBzdGF0aWMgdm9p
ZCBkd2MyX2dhZGdldF9jb25maWdfbm9uaXNvY194ZmVyX2RkbWEoc3RydWN0IGR3YzJfaHNvdGdf
ZXAgKmhzX2VwLA0KPiAgIAl9DQo+ICAgDQo+ICAgCS8qIERNQSBzZyBidWZmZXIgKi8NCj4gLQlm
b3JfZWFjaF9zZyh1cmVxLT5zZywgc2csIHVyZXEtPm51bV9zZ3MsIGkpIHsNCj4gKwlmb3JfZWFj
aF9zZyh1cmVxLT5zZywgc2csIHVyZXEtPm51bV9tYXBwZWRfc2dzLCBpKSB7DQo+ICAgCQlkd2My
X2dhZGdldF9maWxsX25vbmlzb2NfeGZlcl9kZG1hX29uZShoc19lcCwgJmRlc2MsDQo+ICAgCQkJ
c2dfZG1hX2FkZHJlc3Moc2cpICsgc2ctPm9mZnNldCwgc2dfZG1hX2xlbihzZyksDQo+IC0JCQlz
Z19pc19sYXN0KHNnKSk7DQo+ICsJCQkoaSA9PSAodXJlcS0+bnVtX21hcHBlZF9zZ3MgLSAxKSkp
Ow0KPiAgIAkJZGVzY19jb3VudCArPSBoc19lcC0+ZGVzY19jb3VudDsNCj4gICAJfQ0KPiAgIA==

