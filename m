Return-Path: <linux-kernel+bounces-206817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0087900E26
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 00:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2ED37B22634
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 22:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1A9149C77;
	Fri,  7 Jun 2024 22:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="E7kseSgR";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="NVeL0bvx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Lcvr4iu0"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBC7155312;
	Fri,  7 Jun 2024 22:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717799852; cv=fail; b=EGLHK78LA2LBE+w02d6gVL76qusAZ77nOj61s2YwOzporpqoBrqQa5pFAZfhjakZtUn9c9MBh4QOZ8mTgmtfbXao3n50OYavzK+vs4hROF3u4Z1iGYiKa03gZqhliHF1Jfcl1SPW0xRxOkGG62hisJr8TNF0Fhf7YKwORpGPl70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717799852; c=relaxed/simple;
	bh=alz6eumNFJxtxnz1I1jPRz8z3vi5wXo78QQM5CW17MQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g4hpI190eqFbcotU/OtOZCg0DAOkzcg4SxbUFWEDiShaYIM01WtshcsYqhOHBTuEXHCrpMW/fKDVfBeaygsl54S1gm2AbYZ6c9KUKjakVGNbgriQKO1b1nTqgXfpn8ERPXQJNpo+FhI0Ax0IecjSHWxVoiA8XDUad8orCPNtRiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=E7kseSgR; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=NVeL0bvx; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Lcvr4iu0 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 457Lb48p014449;
	Fri, 7 Jun 2024 15:37:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=alz6eumNFJxtxnz1I1jPRz8z3vi5wXo78QQM5CW17MQ=; b=
	E7kseSgRpp/+MymU3URzbeKpmGPdC5G89hfUA86sp2vtar8kh4a0YBlahEGqeUwE
	PzrFRf20qaUXbkEqavGnQuMCFTqKJyomc6sGeyNdYWmvw8mGyyHvzPAsgQecXh8o
	5JCNGL90djFh15oyzzX+oeN/3l3ywhs9G9sJgHpBaXzQRlin5TD+gL1uxqTceTB3
	F21uJz3uduRCw4zU3ARIjwXjMOO9MobI55fpWpxkJSF1RhGovfggw0qPBfDb+7l1
	ey4zSyBOM2FNKLzk17mS38TvKgDuzIb8l5Xw452Xdi9WZJnBVfH1xTueB0KKmAb+
	cb01fQp37iWgz6wF6a7c+g==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3yg2jsne79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 15:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1717799826; bh=alz6eumNFJxtxnz1I1jPRz8z3vi5wXo78QQM5CW17MQ=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=NVeL0bvxih+acyDmlw0m4Zculn57DIGOcMlS4NHx6annoifGbk/Z5H9/efA9Xlc75
	 lPhdPa7qZdThrtXrlb4dynefU6YG+Axras4OHpGr3YGblYopqQ3R1mFPNlrT/ZYBza
	 uWu2EqxG521eiJPHjFTvDGDyxPRYfTMcHUVMNZbfYQN8EeJyoL3brwp9zILnDGg+9u
	 EXMrQxdq00sRNzZ8RN9JGmnwtc4t07Fo83HyeA9LTJ+Vwh6XdbsUSRUKgitmLZy9yz
	 Mqr/vumIQsdpz4g7F07q+nrd9WTuX3T+vvJXhTuZ1BCyMj0KPv+NJ6ZvJerR9p74rW
	 uKTcXe1f9Jldg==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5E3EA4035C;
	Fri,  7 Jun 2024 22:37:05 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id B89EDA009A;
	Fri,  7 Jun 2024 22:37:04 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=Lcvr4iu0;
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 15DAD40353;
	Fri,  7 Jun 2024 22:37:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dmjDh9sdL8cqdAqiISh8T6eNw6iwcVrm4mWUfpQxi1+OEi+RErEsnvrw3K4jtBc7zq1pJ5sqXAoK//VZ2y1/ZzGC9UVGBubmOsPo9MdCac2UMXni/STlCpOjxEbDtnCdJsBxDM/hNPqgY8PwORh92LFRD92s13tnpfNXsZOy2Z1nLUQ1CdJl7cmkz/mwQ3UvpzAdKygmFGBowTzAeMARcMqxUKhZIRIGIguedDj73kMZ/dpP8Qxvz1CCbOF+GLEDzRFrKcDG/oo3+LiS7ZFxsnJJ7VN0fJqK3FS09Ze59qII4zJb2/zhIWVRjRl47I0fvp29RHsPJ65ToBxkt/H0wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=alz6eumNFJxtxnz1I1jPRz8z3vi5wXo78QQM5CW17MQ=;
 b=gdxCc62lvabxFRDB73x3XpChxgB64l/JiRunp6fqNxlu0K2PKygb4bmLunUDZEfTE1/5HBz2zofz1m5pOiH7rYlHaV4H7+VV5J+3QrPxmSQN76wENqsMYlEYtrHpERfVqxGzCnpEhb+5gsW8zgn9GXe0uceP0SGPhIA/VX8m9Qu9DzG67nfjx9j9wwU2FQAC+YpXJpvzNFk1cQFiPWgcFWVDLSHlxl63Z7wUSYAKgrxFfPoFbr9P+8hTy62wBLzj4tWddDErbvUxUee7odc9WWZsdChCKRDqbrdxDyfUvrqPxxgJrvo1BpK191rlObNKzlgsaK/mJXRu+naoVM8lEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=alz6eumNFJxtxnz1I1jPRz8z3vi5wXo78QQM5CW17MQ=;
 b=Lcvr4iu0TcJUwvthWLXl9jk5dv9mykdd4me9MAyfUX8ofjEsuS+bSytCUkGIy8/902eJah48UTAjXE9zsyvQ1LFPDU4bLfWqIYVobc07orC+5EDMLPu49ffQbLUQyPG+xUE6bZR0yL4MY02fYblmCZDxCV8CNNENofcU5ncsNMI=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SA3PR12MB9132.namprd12.prod.outlook.com (2603:10b6:806:394::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 22:36:59 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.7633.021; Fri, 7 Jun 2024
 22:36:59 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: joswang <joswang1221@gmail.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        joswang <joswang@lenovo.com>
Subject: Re: [PATCH v2, 3/3] usb: dwc3: core: Workaround for CSR read timeout
Thread-Topic: [PATCH v2, 3/3] usb: dwc3: core: Workaround for CSR read timeout
Thread-Index: AQHatbZOP6V8cE1jeEGogZmaKJg11rG2uuOAgADiIoCAAlmJAIACZhIAgACOWgA=
Date: Fri, 7 Jun 2024 22:36:59 +0000
Message-ID: <20240607223656.q64isjf2gm3arhkh@synopsys.com>
References: <20240601092646.52139-1-joswang1221@gmail.com>
 <20240603130219.25825-1-joswang1221@gmail.com>
 <20240604000715.3rlmzxriof6wwksm@synopsys.com>
 <CAMtoTm3XnPr8DY9qPW0X0+aayu_7CWrC1od8qKqU3S2wRjMi1Q@mail.gmail.com>
 <20240606012936.jdokepv73qrdorbp@synopsys.com>
 <CAMtoTm3tSNKdv+LOCeQFtFpGq=6yNqTm8Jq=koFfAxT4UamOQg@mail.gmail.com>
In-Reply-To: 
 <CAMtoTm3tSNKdv+LOCeQFtFpGq=6yNqTm8Jq=koFfAxT4UamOQg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SA3PR12MB9132:EE_
x-ms-office365-filtering-correlation-id: c63a2467-22b9-49e1-1918-08dc874257ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|7416005|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?R0hJd1RuejJpYmsyZmR3OFBjTjh1dnBXRWYwZUpiOFBXWUx6Z1l3SXg1bHZj?=
 =?utf-8?B?d0hVRmFNMFFrSEN5eHNMdnlXTlk2dEtMQTRqeWNLNENhNXE5b2ltbWZQUGFn?=
 =?utf-8?B?djUzL3g2R3dOcFZTNUx5SWZrZlBFT3JTTzJzQnYvV0oxaXd4TU85TzZoZHp3?=
 =?utf-8?B?QndSUVQ5bHhjZWJ1YUhXSFlrTWVxc1gxN0tZd3hSMFdBVHUxT1FFOElkQzJZ?=
 =?utf-8?B?bnJwV0tLeVVoYUQ4TGdLY2FQYno1bUFReU9BWXQzU0JBUzVUS3lXSUc5cW16?=
 =?utf-8?B?cWlCZVkzRWt4UGlraEd0ajJHTUVMVTdURWkwSWg5R3lhWDJSZVdvaWxOZkJB?=
 =?utf-8?B?V2ROZ3pqUTZtSzh4eVpldVdUaTMwN1pBNEhsVmVYSzNaQVFaUzdtNWV2YThG?=
 =?utf-8?B?bTlxSEJBMSsxdmYxbTdUbnl6RWRRdndFT1ByU0JMclljUnRXTjhvVFZJRlQ0?=
 =?utf-8?B?SS81bWY1TG5TdWt5OU9LdXdGSmo2dGdYL0JuZWtSVEZLOVhOVkUwUFhCQzNi?=
 =?utf-8?B?R2RwYzVXYTZ2dHlvcy9tUW9oVzZsS0ZkQ2tERFczRm5Zd3M1RkxzRnZXQW1M?=
 =?utf-8?B?ellqaythVk1jdEU3a1dVTjZTNFU4R2kzWGhzWUZrdjdVMDdhbjUrTktkTzBh?=
 =?utf-8?B?YnJQL1JIQW9FWk8wdDdiRngvRWkrWEtUdnBYdVlrUmRDSjdkNUVMMXVXa3c3?=
 =?utf-8?B?ZC8zNU9DblB2ZWxyOUVlZFB3VFlBUnA1ZDNqYUczQklVa0FLTTJOdjlKdC9H?=
 =?utf-8?B?OG5NK2JZR1RuaW9zazd4VWdjLy8yb0Fwa2FjWTc3RnZRbnQ0NnYwclZybDEx?=
 =?utf-8?B?R2xoUVJsSjREcVJUMXZQdUNoU0VVQXlZY25ZYzFQVDllbEREM0czZVBES1do?=
 =?utf-8?B?NTJ5WmJhenMzMUc3Zmk4TWM4RnMzWkI4Mzd0TEtoa0hSSnI3ZWVoWE80a3U3?=
 =?utf-8?B?OVhUVDRzdlVTOEFKUGtPcDU0anphMkNPTWQyZjFhUDFHS0ZBU1VuUlVyVWdj?=
 =?utf-8?B?S3g0VHh1dnUzUWRqWldLR2hyRU9JcXlDQWRWUWZOTlJvL3JteUIwTEFYcGpk?=
 =?utf-8?B?a3pjY09PRGJIWXJsUS9KdStzbUsrckREVnNvcGFBVENMckkxM0IzQTVuZElh?=
 =?utf-8?B?VjlibDI0QkJTYlFWcTViMHB4c1pmVkRyRkwrcXZPNVUrTFhhZW96eVFUWGFu?=
 =?utf-8?B?b0kvSDJIQUh5aWtISkFtd0djSk9sYis1bzZRczdjcDJ0RTlWUjR1c0hNVW5n?=
 =?utf-8?B?YkQxWXFiUnQxemdJVjFRWGpyaG5va1FQZ0JQbVpPTkJKS2ZDRHJuRG5sWEJi?=
 =?utf-8?B?UERNKy9ZQzhOK1dNdFhicDlpb3RJUStzTDM1S0NnS2hiSXg3dUVSVW1yRElR?=
 =?utf-8?B?NFNoV29CdnluV1VhQjNnb0M0Skw4NzFzQUFJNjFtMndpcU02cmIrSVlpK1M0?=
 =?utf-8?B?cWtYZWVSMm5EVGJ2SmpsUjJ2eEpreVFJNGNoTFppSER0ekRIZnJYN0xVOHg4?=
 =?utf-8?B?dWk3VnZWZnI1ZGZIM3BSRjhwL3VudGMxWUIyait4VGV0NXJMYkpZbk1hL2Zp?=
 =?utf-8?B?bEhmcm1LRFhVRmFMUWZabUxydHhhanRidFZhUmdOVFFyVVlCNkE0MXpOcVBC?=
 =?utf-8?B?RE9BLzZCL1NOckE3YjJkV0tkZ2sxeUVZdFpaWjBaMlB3V3FhWVg0TTZVcE1o?=
 =?utf-8?B?RG5tUllkdTJSclJwcm5IdWYxQTY5c3pSU0FYTTZHSWN6ZGdPYWhnKzFNUncv?=
 =?utf-8?B?WW9lLzFNbUNKVmNCWVlHWXd3YitWVnRJaDV6WkVSNUxQVXQzQ3BkK0pGblNz?=
 =?utf-8?Q?cSlG7FZhBebHW6Y+aqrqT8UvhncoiyxT6uAMk=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Y2NEWkFTU08raFE4SEZEaGZXUUF4Zm9sREo4OFhNdytOK25Ja1RhK1I4Wm91?=
 =?utf-8?B?V1FaOU9ic1l0dXo3aWprK3NUcmRCSmwza3NHYXpxWkd5R0ZyUkRQZTVVcEh4?=
 =?utf-8?B?NW9KY04vQlowSjcwSmcrNm9ueDhibld6UGJVRXFtbDNJVFlSYVc5MjRSTmZJ?=
 =?utf-8?B?cC9jSVpEWW5UbmJua085dzE4cWRQbEdLb25yelFveGpDSTkzZDQ0SitiRXRR?=
 =?utf-8?B?bjk1MUMxOUN5QWFJdnA3RFRCcGQ1Wmg4aEJKU2J0Q1RFb0h3dm1ESldhTHJE?=
 =?utf-8?B?VEgrTmdUUVd0dCtjbnJpWXdlSkZYMGNYdURjeTE2SnNzbWducE0vUmFHOEZn?=
 =?utf-8?B?dlJwV2wwWG1hRGFDWXRqVkxZdk5rdzlJU3pLUnVPUDRSeFc3UUJ1S2FGNGV3?=
 =?utf-8?B?QkVXWHZFK1NuUWlFeFo5bUpPWUtvbHRqaktGWjArTXBybUx2Z000eDFCM3lC?=
 =?utf-8?B?UjFLOHU1YVZvM1F3NjgxajlYQ1NYR2Z1V2RBem55RXpDZHp2bFMzT0hPODBN?=
 =?utf-8?B?NXFkQ3RmV3dCTURGOGxUdmF5VnJITGh1dFlJK0o0a2ozdlNIUmZBU2lZMjJQ?=
 =?utf-8?B?UlpXWUpJMkZxSmJwS1cycmhMU1U5amF1K3hMclhqcFZiYWdlQTdUZEdqTFZU?=
 =?utf-8?B?TW5jTjVSVzdlUFBIOWczeDlDMnFKSGhwUkJoWnMzS1d3YWRVanpJakNJOHZW?=
 =?utf-8?B?MDIrTmI5WG5rVmZIMmJWRHZnZFF3bkRTbEhSMnJRVmNLbXNoQ00weU01VFU1?=
 =?utf-8?B?Q0ZjeW1TYkJLb0lvL3dCbi82OGl0SzJtaEU0ZStUaldTR2VlZFlBVUFOSTMx?=
 =?utf-8?B?NHlsZWJlS2RBUTZ5SkRHMnJHZ2hyRWpUb3U4Sk41Rld2SisvUlZEbkNjcmcr?=
 =?utf-8?B?SStSR2RQcmF6MUFjQ0NBSHdscDZ6ZTQxLytpc2c2Vko5QlpGWjR1WkxwQnNy?=
 =?utf-8?B?ck55VGFjQ1RLQVVjOUhkcmdQcnpjbjNmMTg3eTRXeDZNUUhjYW0zMW1ER2tB?=
 =?utf-8?B?K3Q5UTJDbnZUVlREUnBtNXhtRnAybUFrTStKZVlKdFlnRFkvWG42ZXRpL1RP?=
 =?utf-8?B?eUhHRXlhN2xYSis1SERaT1ZIMlZrZVRaRnhqWVNPZGt0ZmNZSXNrOWwrN0Rm?=
 =?utf-8?B?YkxjRzZvYnZ0SGh6SzVqMzlWYTZTL3QxQUpjUlRQZ011OFJJY2xBSkNqKzVL?=
 =?utf-8?B?TEFDbUlWZnE2SUFoNVA3R0FTZHREZXA0KzZqb29FUTcwSkVNUm5EcnRmR1pC?=
 =?utf-8?B?eXBEVVVnS1dJaG5CWisxQmREL2JWYTJOVkZaeUVkWVNwZFJHZDFsQlo5RnFm?=
 =?utf-8?B?TUllbERETHU5L0N3UmVsWGZNWC9sUnZhbFp1VHhmaG1DSkM5OEs3UjVGU01v?=
 =?utf-8?B?NUkxcEdKWVAyMG50V0lhMDJKQk8zSkk5U1NPUHYxUXRwTXIyYW5PSTVtdlM2?=
 =?utf-8?B?WGFEQ0U0UGNEckVxcWsxNU1GM1VpdWhjdkVDeGlIRVh1VGkxZ2hQZWZRUWdE?=
 =?utf-8?B?d2lSRndrWkRUMisyN0E4L1JDV3NFTEdTd2hlRk1ZQVR1ZUVRZGN4OFZvU0d2?=
 =?utf-8?B?bno5b1FxNzBPR1JpOXBlckFqbU5CWk5IWFF5VFFpS0tQWHZiaUlScjR1bUds?=
 =?utf-8?B?d2twcEJhSCtjOXUvVEd2RXh3Zy8xdUhLMGI3VWp2YTFXUXUwUHlnZS9nM2Ry?=
 =?utf-8?B?UnYwcEg3M2xtb0ZDejdvZmtNdkJ6aTV4UFpidnNBcitYR2JRdzFiK0xtT1U1?=
 =?utf-8?B?TlNFc3NIdjBvTUFMV0lxcnhMZUNQc1ZMUm1ZMGRhM1RmRTFhNzJrL0ZKMzJk?=
 =?utf-8?B?ZUkrbHB3MWVjRVJ5TXRXOXVOcjMyNjRIcFd4dFFESlh2OGNrbzdLWHA1djFs?=
 =?utf-8?B?eS9IZjR3TnQrQm84amRORHlhTEFSL2ZGTUhTWlFmQWpXcFkrelFBeklGRnpW?=
 =?utf-8?B?NVZSM1BYaTUyQmhYRTZxcGYyelBpSHNBaEtMYlNXTXJrNk41UWYzTjB2bEM2?=
 =?utf-8?B?eXZCZHZyV01UTWdxMk1OalFWSnZ0L2FPa2crZjFxcG1xMmdmNldIc1NZcnhI?=
 =?utf-8?B?R0ZHTlNwVitOUUpraW8zd0VXcE1SVDhXN0YyT2ZKZUwzRHR2bUVvdDhjNEoz?=
 =?utf-8?B?OExEM1Nra25BR25yRjA5czI4d2N3OXR5Q0tRV3d3MEpHeVdiczF4VDNRT3lD?=
 =?utf-8?B?amc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3582C10DCEB07445885289D275A20D78@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	RS6ksVeEnvuJmQ3zE+iOybkKgLNQWiZ7WxHHLiIutCg5fRQTL0BIu9IH7G3SQraOgeeyyZ2y4vyjl8rjinSUZxnCby9Z3KeZr/Bwa44fw5EX6txkgS9C6eyTpwC6+irOu6wACbHiZvwlWZggSC9wXfkxzqnK2MagZ3gOaPEysR16lozt+cCjMkumrlOn9DRhraZnjSHnNqOS/PUUwCwulp+VIct41HTUaoe6OTAtvu5adpy/OpLUdGYEEYake3p8FbuZ6kMsd8vhhkZ1wMZVB531TXofvOrXXakd5A1J361bbarKlHc8azeRtmNMEaGrPg6A2TEoUv0JSmyRikM5re3wCYEd/RL00cHceNPYCdJ7CdTTCZH9GqOmlv2flFZ7mHYUwQfwPDUxbFWnIbpeEj4zDUBP60G9J4C07/oD50+NVlnJ8/HEA5jeA0IJqXP0EqQh0lPitb0ertrLEZvaIp88VZDTBCELcbgMgeDUOk5ZIF1pYQIGI4cvt+35TOFlB7TXFvhGFA79kO8qH1q31CIdOwZE3i+VYhh+putdvj4AyNrXNme/UezT5PW5+olekube92zpwmjusfuVUhslFyfLlw0TQ2Uz3bRMAaUmXJGeA23rwyFdKKPh26FW7SiVcWyxcUtTSaHyqq5L4tsTsw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c63a2467-22b9-49e1-1918-08dc874257ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2024 22:36:59.1943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XxpI2Ef+Mrgjy6ILLEyuKCFZ++5WVhy2D3CUplntO1XMPMPd4IILXLIMD9bJES5z4dDUmNMJkkSonnUkCZwUmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9132
X-Proofpoint-GUID: s4CkRnvk9zVw3nvUAonf0RynI9eIjwxw
X-Proofpoint-ORIG-GUID: s4CkRnvk9zVw3nvUAonf0RynI9eIjwxw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_14,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=999 clxscore=1015 mlxscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406070168

T24gRnJpLCBKdW4gMDcsIDIwMjQsIGpvc3dhbmcgd3JvdGU6DQo+IE9uIFRodSwgSnVuIDYsIDIw
MjQgYXQgOToyOeKAr0FNIFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT4g
d3JvdGU6DQo+ID4NCj4gPiBPbiBUdWUsIEp1biAwNCwgMjAyNCwgam9zd2FuZyB3cm90ZToNCj4g
PiA+IE9uIFR1ZSwgSnVuIDQsIDIwMjQgYXQgODowN+KAr0FNIFRoaW5oIE5ndXllbiA8VGhpbmgu
Tmd1eWVuQHN5bm9wc3lzLmNvbT4gd3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+IE9uIE1vbiwgSnVu
IDAzLCAyMDI0LCBqb3N3YW5nIHdyb3RlOg0KPiA+ID4gPiA+IEZyb206IGpvc3dhbmcgPGpvc3dh
bmdAbGVub3ZvLmNvbT4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IERXQzMxIHZlcnNpb24gMi4wMGEg
aGF2ZSBhbiBpc3N1ZSB0aGF0IHdvdWxkIGNhdXNlDQo+ID4gPiA+ID4gYSBDU1IgcmVhZCB0aW1l
b3V0IFdoZW4gQ1NSIHJlYWQgY29pbmNpZGVzIHdpdGggUkFNDQo+ID4gPiA+ID4gQ2xvY2sgR2F0
aW5nIEVudHJ5Lg0KPiA+ID4gPg0KPiA+ID4gPiBEbyB5b3UgaGF2ZSB0aGUgU1RBUiBpc3N1ZSBu
dW1iZXI/DQo+ID4gPiA+DQo+ID4gPiBUaGFua3MgZm9yIHJldmlld2luZyB0aGUgY29kZS4NCj4g
PiA+IFRoZSBTVEFSIG51bWJlciBwcm92aWRlZCBieSBTeW5vcHN5cyBpcyA0ODQ2MTMyLg0KPiA+
ID4gUGxlYXNlIGhlbHAgcmV2aWV3IGZ1cnRoZXIuDQo+ID4NCj4gPiBJJ3ZlIGNvbmZpcm1lZCBp
bnRlcm5hbGx5LiBBcyB5b3UgaGF2ZSBub3RlZCwgdGhpcyBhcHBsaWVzIHRvIERXQ191c2IzMQ0K
PiA+IHYyLjAwYSBmb3IgaG9zdCBtb2RlIG9ubHkgYW5kIERSRCBtb2RlIG9wZXJhdGluZyBhcyBo
b3N0Lg0KPiA+DQo+ID4gPg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gVGhpcyB3b3JrYXJvdW5kIHNv
bHV0aW9uIGRpc2FibGUgQ2xvY2sgR2F0aW5nLCBzYWNyaWZpY2luZw0KPiA+ID4gPiA+IHBvd2Vy
IGNvbnN1bXB0aW9uIGZvciBub3JtYWwgb3BlcmF0aW9uLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4g
U2lnbmVkLW9mZi1ieTogam9zd2FuZyA8am9zd2FuZ0BsZW5vdm8uY29tPg0KPiA+ID4gPiA+IC0t
LQ0KPiA+ID4gPiA+ICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyB8IDIzICsrKysrKysrKysrKysr
KysrKysrKysrDQo+ID4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspDQo+
ID4gPiA+ID4NCj4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMg
Yi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiA+ID4gPiA+IGluZGV4IDNhOGZiYzJkNmI5OS4u
MWRmODVjNTA1YzllIDEwMDY0NA0KPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29y
ZS5jDQo+ID4gPiA+ID4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gPiA+ID4gPiBA
QCAtOTc4LDExICs5NzgsMjIgQEAgc3RhdGljIHZvaWQgZHdjM19jb3JlX3NldHVwX2dsb2JhbF9j
b250cm9sKHN0cnVjdCBkd2MzICpkd2MpDQo+ID4gPiA+ID4gICAgICAgICAgICAgICAgKg0KPiA+
ID4gPiA+ICAgICAgICAgICAgICAgICogU1RBUiM5MDAwNTg4Mzc1OiBDbG9jayBHYXRpbmcsIFNP
RiBJc3N1ZXMgd2hlbiByZWZfY2xrLUJhc2VkDQo+ID4gPiA+ID4gICAgICAgICAgICAgICAgKiBT
T0YvSVRQIE1vZGUgVXNlZA0KPiA+DQo+ID4gU2luY2UgdGhlcmUncyBhbm90aGVyIFNUQVIsIGxl
dCdzIHNwbGl0IHRoZSBpZi1lbHNlIGNhc2Ugc2VwYXJhdGVseSBhbmQNCj4gPiBwcm92aWRlIHRo
ZSBjb21tZW50cyBzZXBhcmF0ZWx5Lg0KPiA+DQo+IE9LDQo+ID4gPiA+ID4gKyAgICAgICAgICAg
ICAgKg0KPiA+ID4gPiA+ICsgICAgICAgICAgICAgICogV09SS0FST1VORDogRFdDMzEgdmVyc2lv
biAyLjAwYSBoYXZlIGFuIGlzc3VlIHRoYXQgd291bGQNCj4gPg0KPiA+IENhbiB3ZSB1c2UgdGhl
IGZ1bGwgbmFtZSBEV0NfdXNiMzEgaW5zdGVhZCBvZiBEV0MzMS4NCj4gPg0KPiBTdWJzZXF1ZW50
IFYzIHZlcnNpb25zIHVzZSBEV0NfdXNiMzENCj4gPiA+ID4gPiArICAgICAgICAgICAgICAqIGNh
dXNlIGEgQ1NSIHJlYWQgdGltZW91dCBXaGVuIENTUiByZWFkIGNvaW5jaWRlcyB3aXRoIFJBTQ0K
PiA+ID4gPiA+ICsgICAgICAgICAgICAgICogQ2xvY2sgR2F0aW5nIEVudHJ5Lg0KPiA+ID4gPiA+
ICsgICAgICAgICAgICAgICoNCj4gPiA+ID4gPiArICAgICAgICAgICAgICAqIFRoaXMgd29ya2Fy
b3VuZCBzb2x1dGlvbiBkaXNhYmxlIENsb2NrIEdhdGluZywgc2FjcmlmaWNpbmcNCj4gPiA+ID4g
PiArICAgICAgICAgICAgICAqIHBvd2VyIGNvbnN1bXB0aW9uIGZvciBub3JtYWwgb3BlcmF0aW9u
Lg0KPiA+ID4gPiA+ICAgICAgICAgICAgICAgICovDQo+ID4gPiA+ID4gICAgICAgICAgICAgICBp
ZiAoKGR3Yy0+ZHJfbW9kZSA9PSBVU0JfRFJfTU9ERV9IT1NUIHx8DQo+ID4gPiA+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgZHdjLT5kcl9tb2RlID09IFVTQl9EUl9NT0RFX09URykg
JiYNCj4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBEV0MzX1ZFUl9JU19X
SVRISU4oRFdDMywgMjEwQSwgMjUwQSkpDQo+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAg
IHJlZyB8PSBEV0MzX0dDVExfRFNCTENMS0dUTkcgfCBEV0MzX0dDVExfU09GSVRQU1lOQzsNCj4g
PiA+ID4gPiArICAgICAgICAgICAgIGVsc2UgaWYgKChkd2MtPmRyX21vZGUgPT0gVVNCX0RSX01P
REVfSE9TVCB8fA0KPiA+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGR3Yy0+
ZHJfbW9kZSA9PSBVU0JfRFJfTU9ERV9PVEcpICYmDQo+ID4NCj4gPiBUaGVyZSdzIG5vIE9URyBt
b2RlIGZvciBEV0NfdXNiMzEuIExldCdzIGVuYWJsZSB0aGlzIHdvcmthcm91bmQgaWYgdGhlDQo+
ID4gSFcgbW9kZSBpcyBub3QgRFdDX0dIV1BBUkFNUzBfTU9ERV9HQURHRVQuDQo+ID4NCj4gPiA+
ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBEV0MzX1ZFUl9JUyhEV0MzMSwgMjAw
QSkpDQo+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgIHJlZyB8PSBEV0MzX0dDVExfRFNC
TENMS0dUTkc7DQo+ID4gPiA+ID4gICAgICAgICAgICAgICBlbHNlDQo+ID4gPiA+ID4gICAgICAg
ICAgICAgICAgICAgICAgIHJlZyAmPSB+RFdDM19HQ1RMX0RTQkxDTEtHVE5HOw0KPiA+ID4gPiA+
ICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gPiA+ID4gQEAgLTk5Miw2ICsxMDAzLDE4IEBAIHN0
YXRpYyB2b2lkIGR3YzNfY29yZV9zZXR1cF9nbG9iYWxfY29udHJvbChzdHJ1Y3QgZHdjMyAqZHdj
KQ0KPiA+ID4gPiA+ICAgICAgICAgICAgICAgICogd2lsbCB3b3JrLiBEZXZpY2UtbW9kZSBoaWJl
cm5hdGlvbiBpcyBub3QgeWV0IGltcGxlbWVudGVkLg0KPiA+ID4gPiA+ICAgICAgICAgICAgICAg
ICovDQo+ID4gPiA+ID4gICAgICAgICAgICAgICByZWcgfD0gRFdDM19HQ1RMX0dCTEhJQkVSTkFU
SU9ORU47DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICsgICAgICAgICAgICAgLyoNCj4gPiA+ID4g
PiArICAgICAgICAgICAgICAqIFdPUktBUk9VTkQ6IERXQzMxIHZlcnNpb24gMi4wMGEgaGF2ZSBh
biBpc3N1ZSB0aGF0IHdvdWxkDQo+ID4gPiA+ID4gKyAgICAgICAgICAgICAgKiBjYXVzZSBhIENT
UiByZWFkIHRpbWVvdXQgV2hlbiBDU1IgcmVhZCBjb2luY2lkZXMgd2l0aCBSQU0NCj4gPiA+ID4g
PiArICAgICAgICAgICAgICAqIENsb2NrIEdhdGluZyBFbnRyeS4NCj4gPiA+ID4gPiArICAgICAg
ICAgICAgICAqDQo+ID4gPiA+ID4gKyAgICAgICAgICAgICAgKiBUaGlzIHdvcmthcm91bmQgc29s
dXRpb24gZGlzYWJsZSBDbG9jayBHYXRpbmcsIHNhY3JpZmljaW5nDQo+ID4gPiA+ID4gKyAgICAg
ICAgICAgICAgKiBwb3dlciBjb25zdW1wdGlvbiBmb3Igbm9ybWFsIG9wZXJhdGlvbi4NCj4gPiA+
ID4gPiArICAgICAgICAgICAgICAqLw0KPiA+ID4gPiA+ICsgICAgICAgICAgICAgaWYgKChkd2Mt
PmRyX21vZGUgPT0gVVNCX0RSX01PREVfSE9TVCB8fA0KPiA+ID4gPiA+ICsgICAgICAgICAgICAg
ICAgICBkd2MtPmRyX21vZGUgPT0gVVNCX0RSX01PREVfT1RHKSAmJiBEV0MzX1ZFUl9JUyhEV0Mz
MSwgMjAwQSkpDQo+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgIHJlZyB8PSBEV0MzX0dD
VExfRFNCTENMS0dUTkc7DQo+ID4gPiA+ID4gICAgICAgICAgICAgICBicmVhazsNCj4gPiA+ID4g
PiAgICAgICBkZWZhdWx0Og0KPiA+ID4gPiA+ICAgICAgICAgICAgICAgLyogbm90aGluZyAqLw0K
PiA+ID4gPiA+IC0tDQo+ID4gPiA+ID4gMi4xNy4xDQo+ID4gPiA+ID4NCj4gPiA+ID4NCj4gPg0K
PiA+IFdlIGhhdmUgdGhlIHNhbWUgY2hlY2tzIGFuZCBjb21tZW50cyBoZXJlLiBDYW4gd2UgcmVm
YWN0b3I/DQo+ID4gUGVyaGFwcyBzb21ldGhpbmcgdGhpcz8NCj4gPg0KPiA+IHBvd2VyX29wdCA9
IERXQzNfR0hXUEFSQU1TMV9FTl9QV1JPUFQoZHdjLT5od3BhcmFtcy5od3BhcmFtczEpOw0KPiA+
IHN3aXRjaCAocG93ZXJfb3B0KSB7DQo+ID4gICAgIC4uLg0KPiA+IH0NCj4gPg0KPiA+IC8qDQo+
ID4gICogPGNvbW1lbnQ+DQo+ID4gICovDQo+ID4gaWYgKHBvd2VyX29wdCAhPSBEV0MzX0dIV1BB
UkFNUzFfRU5fUFdST1BUX05PKSB7DQo+ID4gfQ0KPiA+DQo+ID4NCj4gPiBUaGFua3MsDQo+ID4g
VGhpbmgNCj4gDQo+IFRoYW5rIHlvdSBmb3IgeW91ciB2YWx1YWJsZSBzdWdnZXN0aW9ucy5JIGNh
biByZWZhY3RvciBhY2NvcmRpbmcgdG8NCj4geW91ciBzdWdnZXN0aW9uLg0KPiBEbyBJIG5lZWQg
dG8gc3VibWl0IGEgVjMgdmVyc2lvbiBwYXRjaCBzZXBhcmF0ZWx5LCBvciBzaG91bGQgSSBzdWJt
aXQNCj4gYSBWMyB2ZXJzaW9uIHBhdGNoIHRvZ2V0aGVyIHdpdGggb3RoZXIgY2FzZXM/DQoNCkkg
aGF2ZW4ndCByZXZpZXdlZCB0aGUgb3RoZXIgY2FzZSBpbiBkZXRhaWwgeWV0LiBJJ2xsIGdldCBi
YWNrIG9uIHRoYXQuDQoNCkl0IG1heSBiZSBiZXR0ZXIgaWYgeW91IGNhbiBzdWJtaXQgdGhpcyBz
ZXBhcmF0ZWRseSBzbyB0aGF0IHRoZSBvdGhlcg0KY2FzZSB3b24ndCBob2xkIHRoaXMgYmFjayAo
YW5kIGl0IG1heWJlIGVhc2llciBmb3IgdHJhY2tpbmcgdG9vKS4NCg0KVGhhbmtzLA0KVGhpbmg=

