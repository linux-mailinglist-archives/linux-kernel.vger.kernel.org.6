Return-Path: <linux-kernel+bounces-199887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D07828FA743
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 02:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25ED7B2192F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 00:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750718C1D;
	Tue,  4 Jun 2024 00:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="n0Kpn/Kd";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="YK3TzaZ1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="jrJUF6Di"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264A8811;
	Tue,  4 Jun 2024 00:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717462590; cv=fail; b=pi1Cu8b6dtiba3H8TsPlYjQuGDuMJIcI1Mk0jgAv5KUL6DQleSGYb1XZE4cIHA33uIzcUJsxeCdshrD66olzcCpU7QRzhwGQ4vURwgbaJbf+4dOjwRmr20nIlX3btJ+wu+Xze4s3EJ6e897NNWBl5ZGb99sgEmdnqYSH5L/IO6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717462590; c=relaxed/simple;
	bh=v4Fkz/YycHHuf1uXfelOmcW22OndA2F4me99igzS9RI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qhSI5Ddq3RWXOejaJ3qpLr1kFwmZX8Ak+Lrt3vW3/FjhsK6URnngwSEtjbmnpdEdSzQsIgt60JzimfpknS19XxXHndhtYi97WgJCWsfzJgMTaVyPRfv2mwmztSUqQ5DOYGRyL4t1nvyr5GI4pK9ydbspJhaevQiWtHHRBMkkQAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=n0Kpn/Kd; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=YK3TzaZ1; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=jrJUF6Di reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 453Nq33X027247;
	Mon, 3 Jun 2024 17:07:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=v4Fkz/YycHHuf1uXfelOmcW22OndA2F4me99igzS9RI=; b=
	n0Kpn/KdzPmACfbAMgoUbrS1t++CQMgEZTFxwRiLE2UKN1wRVxaxFMzXuDeEz/FW
	JMi88OvfLsvugTRckCXR17pjVy4Qz9tiMUJgT82SDak2UmJQaFs2CgH7oGshW7+C
	56PgOSqxgia5i7O2bPR/gBpvvJ64NcORg8MY8Go4ukSbsUqq76NkvF/vqfLMX+Dn
	3zcGtVyn0TRfDwWq0lQS/lFfNc0erZ5LEnIaAB2t43o5GxiQAdddYZYDLEn67N+7
	BvyFGrPaPMueWni4uJjLNzYgTvfCoTje/9uPzhIZhuedxZccFJFivDVRocL3M4fg
	4Me/2WEG0xQBWKU8YCKmMA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3yg2w315k2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 17:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1717459655; bh=v4Fkz/YycHHuf1uXfelOmcW22OndA2F4me99igzS9RI=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=YK3TzaZ13dhFmP7Qoa+zJiKwMnih/MO8d6dxr55R8HvZfKqYxMY3cYJ5/ydtyit8j
	 VttTt15FvHiWx3l5oEmH4VkdX2/fnKx9VmFRz3LHY3APvg6ojbeK65GWuIIfK9YQMm
	 GvjjqlLNAxV30zY4gmWxJs7nO6eK4pvnLSOf9SxzoY2lVVciiiX48Cf6sF/0PLhS8T
	 vZ63LuGurflql9+/t0vaRMsy4HY2GzZZFPL9V7TfqW8yBose4GeI19ZD6bOam730MI
	 O6HGM5xz+y2KUsIa7L7lTCItZmFtqp0QMIavR7+l1WrHAUs0KnDT6cqV0Y6sHWErO8
	 IUkLYxc7Rjfqg==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id BC980403A2;
	Tue,  4 Jun 2024 00:07:35 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 6DBF8A0263;
	Tue,  4 Jun 2024 00:07:35 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=jrJUF6Di;
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id C6B5B40361;
	Tue,  4 Jun 2024 00:07:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIeZ5Xe3Q70unDgxIlYPXHKeC75yVQ/52uRw0E4DHAty1g3iH9VGcW9VJG9M64U6rEcEKeBNsB7g36ZKjFyljQCWljOtNBPodp8awKuPptUil+GXZvseR+JkYT1Gnn09gq2By5uIeZRB4Yt8iiH7lADiZjeq1UXsqcKtP/knOBgzVxYySphomYYRIDUSXLEpRuOEzStbIVWVmQtdOiFoykxF27KXVOWRZCg0mIeo7ZTV/lnwAmQCL9XcaXqLEQd6Nq2PsUstEb9Q5bvoR6AnFgfH+8p2d0jQDMBF2droxJohITeywUMqvxE4yIIkt7sJzkAhJ2xy1MgXmbO0DzUrMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4Fkz/YycHHuf1uXfelOmcW22OndA2F4me99igzS9RI=;
 b=cPJnNOMhp7rijcHRzRZ8lFswDo/+fWhPqeGNwIE93wi4XeyIMe7ke6HqVoG1itqtDpIokhuuh3EOasqLk3h2M8BVvCig9aH7ObvWxvvnsz2M5E/w3CdnA834nxDLizkNHBawYdSLS0IbR7b55ZbEQMmS6n0zag2r12mglp2EEKQM+imDhj1psoH69oZLerEkk2K78dD8czhTfdDY3hSYW73pjICccDuGx7PEJNA90cWz9Zo1q31HA88Dpu/Urq8YcHbFswjE9G5uzeb7nZmNV96QCGlv21UsgTiVahLN7luvQcG7qFhmHXDlkrGhr9HzUg74ghyrAU08pI5ljYEFiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4Fkz/YycHHuf1uXfelOmcW22OndA2F4me99igzS9RI=;
 b=jrJUF6Di2Qa+B+P6jImV2RP6uO/A1Glqi/EG88VDttOP/JCedCnwY+sDgNRBk+0RqHTwusgGGWmJ7nlHtzUWQFC6x0MOvOSbP4kqkHYHNGgB4rDxX7sAVcmHYIMB716BC1NFZSYwRnA4S4Q0fgsADVh5xJiRxhvLa8HIBYY+2BU=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SA0PR12MB4431.namprd12.prod.outlook.com (2603:10b6:806:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Tue, 4 Jun
 2024 00:07:31 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.7611.025; Tue, 4 Jun 2024
 00:07:29 +0000
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
Thread-Index: AQHatbZOP6V8cE1jeEGogZmaKJg11rG2uuOA
Date: Tue, 4 Jun 2024 00:07:29 +0000
Message-ID: <20240604000715.3rlmzxriof6wwksm@synopsys.com>
References: <20240601092646.52139-1-joswang1221@gmail.com>
 <20240603130219.25825-1-joswang1221@gmail.com>
In-Reply-To: <20240603130219.25825-1-joswang1221@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SA0PR12MB4431:EE_
x-ms-office365-filtering-correlation-id: dd35e64b-b833-4f52-5561-08dc842a52dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|376005|7416005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?MkNsS2JiOW1pR0lRYmpsVWlQN1M1TUJWVVZSdG01RlNmMHVVLzRFcUNza21E?=
 =?utf-8?B?QWVMbGR3bXRxMTJlNHpsU1BKN1dBblMrZ3hnRUgzMUxqVDFyaXB6RENGc2NY?=
 =?utf-8?B?N0E0bVFMVUVDYkFkTExLQzJHaE9YbkpCVHhqTllBZk1PZElZd0tCZzZCUEly?=
 =?utf-8?B?WUxENU9UbWVUazBnSGJNRlF1QTBiREFsK2pNbXRXMmNrZFVqaXUvNUQ3MUNT?=
 =?utf-8?B?UytIejQ3WXNrTlFHZVgzY0NML3h3Sk9SUVpIYXZPSXpKeXNXZG5zdnpXNmxM?=
 =?utf-8?B?ODFIOU1jVG5YTXNiT292bWM5RWtKUGQ2ZU5IRnBwaFI1TXJ4N3hURWFXRDBh?=
 =?utf-8?B?V2YwVisySTBaQ3VmR3JGZEtnZzlCbUhibCtkVDRTTC9hL2dFV1RHUUNMZyt3?=
 =?utf-8?B?dmJLbGlzTDVlUWZjTWJvWFlTcE1ZWHF5YlB4Y3VMSkxHRHUwT2w4cWVvZTNN?=
 =?utf-8?B?dWVmMVd4d3UzUURETXlrTHlGS2VsWEJiSlJGc280K3hwc3VJTmh2WlNGcXlz?=
 =?utf-8?B?cFBXUCtma0tLSzgxTU9XMm5iaXNYSkV2Z1NJSENGMkd1NWhFR1lHcGZUVFJ5?=
 =?utf-8?B?UXB4SGs5MzVLakMreE1XbHMvQ3pOWVN4VTh0Z2d1UHVhWjZHK1JKYmlTTkNp?=
 =?utf-8?B?c1ErOE5jOGlwMDM0RmpReFlxTlFRd3NHTkV0VjAySW5NNENJK29iMThZWlJB?=
 =?utf-8?B?OXIxVVkzK1NiTzFXamlPd0FIUFg5TTRmM1JTbWhoeGxMU3dLMUdNb1FSNHpu?=
 =?utf-8?B?VVJ2T2VTMW8xb3ROUGxKa1F5anBJcnRrSE1IaFFsNVdCTlNlNlpGcUY2S1pL?=
 =?utf-8?B?bEU0SjgwY05mNjdIdHJ2SjJoMCt5dFlOcXhlM0QrUFhBa2dXem4vNkhSZEdG?=
 =?utf-8?B?Q1VWSzBaY3JzR29ZWEwzSTNYZVZRMWpvWTd6R0JNdmFBTUlXaTc3NXZXV2gv?=
 =?utf-8?B?YzQ5ai9veWh5dmNrYkNNTWtreHlYd0tsZzFYNSs1RlllMmhnZ3ZmZzFvQzV6?=
 =?utf-8?B?LzdwWDl1WTNPSmFMQXRVdEp3QllQeFdhSUltSXRIY1Rwa1pscW1sU0o0TEhy?=
 =?utf-8?B?bTllWUEzbG1jVEt5cjdmVFh2YVVqVmdESGtBZU9wT3lsL1VwVFVVWWdydXcv?=
 =?utf-8?B?eXFMWE1pVWN2Uld6dG41eW9XVTIycEdWMXNZdXRPalI1UmZyYUt5WEtkdm8x?=
 =?utf-8?B?Z1U0eHFNZjBmQjFJMXp2OXZyUDB3eEhZckc4cmU5dktSQmZFWlhjTzh0YlZx?=
 =?utf-8?B?SC9sVE5hU2tjY3BHRWh0SEFWYmIwYVpmN01icFV2bUp5bzFGK0xRd2pYUFhr?=
 =?utf-8?B?WjBOdkNZQzI5UXZmWUp6U2w5VmY2amJ3bFN5U2JXWkJVNCtXdmY3QXpCYjJv?=
 =?utf-8?B?cnJncmovdWRoVGRzdUhBdlh5QzZ5M3pCV0trekVzQjY1S2wrcnYvalJoOGkr?=
 =?utf-8?B?WThHRzRuK2xGcmEySmVlZlV6bVJ0cHBNdWc0OVIwQVhaMm01TkV5d0diSFVl?=
 =?utf-8?B?ci9kMTJQMUpQb2pRU2pweFZ3aUVSYWkvR2xXT2ZUS1RPWjd5SHdpZTQ4OGdD?=
 =?utf-8?B?REgxNG5GZ3dOelJkVGVaWkIxWHU0bDQ3Z0pJdSttSHJqVmRLVkVhZ0I1OEtL?=
 =?utf-8?B?ckQrSmpKREFVN29vVHZqbDBudU5UQkc1cHRKOFJpcmZYL01CUFpWS25ENUFw?=
 =?utf-8?B?amgvUTVEN3ozNWxxUXB0Mk5qNkh2QU5zRmh0RzF5NlYvRUd5S0Z5Kzh2anFu?=
 =?utf-8?B?eUdha1cwb0RPcjRsZWVRV09GOXVuWFlBUTEwaE83YzlIV2VjUENSaVY2Sm4z?=
 =?utf-8?B?M3QyUWd5SkJTcXFoZmY1Zz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?T0pQWXJnTmxjM1EvZjRGM2thU0VlS0ZuSEM1dUI5S09nMkh0clFtS3NhTEtW?=
 =?utf-8?B?SUtPWFVzZGRKZk1la1RGM3JGZ002bG5oQ3lMNTlUVy92YmFKajR4N2RXRVZk?=
 =?utf-8?B?OG5tb2taSU40OW91bEh2amF4SVlDOXA3SzZhM0xuYUppUjA2a1psVnlHcHJO?=
 =?utf-8?B?WS8vU0dBbVlJZ3o3czhJaWxhZFI2TmMzL3B3YVB2Qk9GSUN0SVYxekJyVSt1?=
 =?utf-8?B?bFh4VVNZdDQzTDJuTWZYZWduc1l1T0N3WDNVYVFFVDdMTWZuaFVxNExzeFlC?=
 =?utf-8?B?b0hObVlJbk9wSEFjQ0xnbHcvNFJNSHNpeVVwMC8zMDVDVUlLZDhPeEJvODhr?=
 =?utf-8?B?MEw2UVFYQkRRYXkvbTQ4VjFyeHNZUVU0TFhxL2dOMVpPUDBhaVhHL255MWFD?=
 =?utf-8?B?YzRScWVRamdpaHNrRStIa0I0Q1pyaSt3YTUwWUNSL0lWQ1NzWWhEdFk2L28v?=
 =?utf-8?B?QnpJS3I4eXZrTDNMT291RVcvSk1BOEF4WXlGOTY2RXBXd3FwU0VGaHZ3Zm9Y?=
 =?utf-8?B?Umt2UjcrbE10UUFHZEhEbCt2bGdDMzlka3ROVkx6UTlieFU3dEZtNTlpbTJD?=
 =?utf-8?B?ZzZjdG5MVGRxa1diTjh4amRCUmZBMnNKSlNqZGo4b0NVRVJyK040cXFrSFZG?=
 =?utf-8?B?RE84dW5ta1pZMXdNZGZRZEJNMll1YnZKOFFwTHdNbmZidmFWbVc2YVhTNTYr?=
 =?utf-8?B?MDZvOE5mM1hHTkk4WTQvQ0xzWmh2ckEvSG5pZklYQVBlaDBPS3dKMy9EQWJr?=
 =?utf-8?B?clpOcVRaUWtVL2hiWnYyeUE2M2JwTy9JdjR1R3o2b3Rjei80UjBibDBmVWRG?=
 =?utf-8?B?b01LakliekZzUExnMEtMWDVBdE1FM2QzUFdnVXdOOTlwYjlMbU1VeENsdkFF?=
 =?utf-8?B?bEJRbXdVa1piTE9MOHNML09vUDJKaGJtT3RkKzlIb0xNT1dTSk02QlRpeDdh?=
 =?utf-8?B?M1FVd05FYVZRV3VYYm05WUhEWU1Sc2VEalphUThpakVFeWNyUUt4RVhMZnNp?=
 =?utf-8?B?eVVLbWRPZzF1T1JNUzFtMXcvZUtUcGpjUk0yaUp5K0xma3lWeE4rU2c4SWlZ?=
 =?utf-8?B?ZmtWVk91WGF3Um5rQ2R5SGJxcWNsT0Q5UEM2d3dEMmRrY3N3TVNVSVowcU1T?=
 =?utf-8?B?RUIycnZuUW9TMWZEU2tnUG9XQ1hhRkt5VGQ0c1FFb2IwNUxFUTkwSmRDelNu?=
 =?utf-8?B?MVhWMUNZQlF2dEFjWEI0cEppZ1UxUTR2eEJNTDZWN1U5SnBSSUVqVXFNWitW?=
 =?utf-8?B?RVpDbmg2L01xNndtT0I4SWgrWWo2b0M3YTZXRC9CN3JsZ0pDZXA0RTVQT2lF?=
 =?utf-8?B?bW5rWmcxUk9XWnh6NUFneEtUMkl5SXk4MFhpMXJWY3AwSDNoQ25aNXBzTVlX?=
 =?utf-8?B?emhxQTBSeHRnVU80cWxIUFB1eFdCTkRiTkRXZmkySis4RmsvVFJGNUdCRDV0?=
 =?utf-8?B?d0NINE1IUTFzMnIwdUJRR1FuRkdVckJiUXd4em5rTDJBYXpCWHkwajI2UHNK?=
 =?utf-8?B?anFtL2dwL25sNncrUC9XTS9kbytNR1hnOG1aTFBkeGprSnhZTWdHUS9ETVhV?=
 =?utf-8?B?NlZINEZoMmZxQjZ5SlFTWGcwTGRyTWNtbUJJQ0MyR245ak5NbjR3eldJOVY2?=
 =?utf-8?B?Qm9md00yVm5wRWJHZCtMR1NRcnBaZVVlbW03YmF5aWZGc2RaZ3E1eU1SZUNy?=
 =?utf-8?B?UUdsMG1EcTQ4Y1ZKTGVtazJzbUplN1BuZ0VtdDJGUU55bVlYQmVLYU82VW1T?=
 =?utf-8?B?d1FRNm53WTkrZmpmY3lFY2tvQ1l4Z0orY2I2RlRuZTRVOURENHdIN25tUHcw?=
 =?utf-8?B?WERGTlV4bUs2ZCt3aHVLcXBzaGNzRWdBcnR1YXNtazUwWTF1ZCtmdDYvSExB?=
 =?utf-8?B?Q3hRVCtobVFkMUpQbm01Q0RwY3FpUXgzdlBxNkZaZGlMYVFRUXUwajZaT2Y2?=
 =?utf-8?B?eWpLUGJyRzRJeTlWRUdOMklxd3VoWmtCQ3hYVWRNMHdSWTRlTDV2K2NndlB3?=
 =?utf-8?B?c3gzVWlYcUk2a0s2UlQzTS9XTEFhUWxoWllHakJDdVM4QXMybFBkMytiRVpD?=
 =?utf-8?B?V3E5cVNFZFVUU09xemVFUlNmNTh0QWNnSHkrdjJwUkRpZHd2ckwyenNydmVT?=
 =?utf-8?Q?39VDd9r80tcpsgME7uEAcucDb?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F942410DD48354DBE6B7E8FC80D3B97@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	SOTyLCAj9DEzu6fBEw6KjhXVYtZXF2Es13jvAIwqz+4qn4zjnrEa3t15e8BgpZwdK0inQsJIGWT2s8NpkBI5fo9/Slearv6oNf/CZ54+GDCjxUpAmcm/aq86OG4uL7fWtUicJqY/bKpM3xs7u1W2Btvaj1o9pGOay0qE28XScpxmiCo5b6Kuwdhx33BWI0bQnKgTqGm4aOap/HA6cik91FXm1w3KAzPaBn16zJdYQTTwo4aV0IAWjvzs27KCnrj9+yipuVGvE1djXnaVC9Wmj36W8hXmRNe4ldNdDEhAwHW+7IeJ7Utd6YWB1UQ/afiPu3sKBl+4fpqjQHMnGwCIbwHxPbwCmY8FSs5rhoneePmkbKlXCw4JxrRqpOUXJkrpTkJtr9yzMC027IjDq1bs+xI7mHlY+wpdkw9CJE36ZPBovo5E12FPf8+4VeMZFNz6QtB0GhRqaJJGO3JwyMOW+6lbU62vYVON0rellSSuOrSr2cOf8ua0mq7JSGIpiCzA7aJ2QUZavMg930JVNpCbhRpxlXaQlIDKIdVvoSpyseKNmbBPW07yhEZsUCvzSv6YJakcYN7G6wcKH1QUw3qk3/7AcRPoXUzQDHzzFGkzhpvRl7SK2smhA3FJU6vPJzcwtIevvaUq/4qw3bOfdv7eww==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd35e64b-b833-4f52-5561-08dc842a52dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 00:07:29.3422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cn22OXaekPigmoSnuUCyPhKdW8gpzvIztkPi+WRRM5R+JzR/mmuaKPeVuynivWVbhV5OdyhMuqgopaeoNRmD+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4431
X-Proofpoint-GUID: VH897u4CngLuD5MJdLJrpoUTxwkzfgMb
X-Proofpoint-ORIG-GUID: VH897u4CngLuD5MJdLJrpoUTxwkzfgMb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_17,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 phishscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2406030195

T24gTW9uLCBKdW4gMDMsIDIwMjQsIGpvc3dhbmcgd3JvdGU6DQo+IEZyb206IGpvc3dhbmcgPGpv
c3dhbmdAbGVub3ZvLmNvbT4NCj4gDQo+IERXQzMxIHZlcnNpb24gMi4wMGEgaGF2ZSBhbiBpc3N1
ZSB0aGF0IHdvdWxkIGNhdXNlDQo+IGEgQ1NSIHJlYWQgdGltZW91dCBXaGVuIENTUiByZWFkIGNv
aW5jaWRlcyB3aXRoIFJBTQ0KPiBDbG9jayBHYXRpbmcgRW50cnkuDQoNCkRvIHlvdSBoYXZlIHRo
ZSBTVEFSIGlzc3VlIG51bWJlcj8NCg0KPiANCj4gVGhpcyB3b3JrYXJvdW5kIHNvbHV0aW9uIGRp
c2FibGUgQ2xvY2sgR2F0aW5nLCBzYWNyaWZpY2luZw0KPiBwb3dlciBjb25zdW1wdGlvbiBmb3Ig
bm9ybWFsIG9wZXJhdGlvbi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IGpvc3dhbmcgPGpvc3dhbmdA
bGVub3ZvLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyB8IDIzICsrKysr
KysrKysrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jIGIvZHJpdmVycy91c2Iv
ZHdjMy9jb3JlLmMNCj4gaW5kZXggM2E4ZmJjMmQ2Yjk5Li4xZGY4NWM1MDVjOWUgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMv
Y29yZS5jDQo+IEBAIC05NzgsMTEgKzk3OCwyMiBAQCBzdGF0aWMgdm9pZCBkd2MzX2NvcmVfc2V0
dXBfZ2xvYmFsX2NvbnRyb2woc3RydWN0IGR3YzMgKmR3YykNCj4gIAkJICoNCj4gIAkJICogU1RB
UiM5MDAwNTg4Mzc1OiBDbG9jayBHYXRpbmcsIFNPRiBJc3N1ZXMgd2hlbiByZWZfY2xrLUJhc2Vk
DQo+ICAJCSAqIFNPRi9JVFAgTW9kZSBVc2VkDQo+ICsJCSAqDQo+ICsJCSAqIFdPUktBUk9VTkQ6
IERXQzMxIHZlcnNpb24gMi4wMGEgaGF2ZSBhbiBpc3N1ZSB0aGF0IHdvdWxkDQo+ICsJCSAqIGNh
dXNlIGEgQ1NSIHJlYWQgdGltZW91dCBXaGVuIENTUiByZWFkIGNvaW5jaWRlcyB3aXRoIFJBTQ0K
PiArCQkgKiBDbG9jayBHYXRpbmcgRW50cnkuDQo+ICsJCSAqDQo+ICsJCSAqIFRoaXMgd29ya2Fy
b3VuZCBzb2x1dGlvbiBkaXNhYmxlIENsb2NrIEdhdGluZywgc2FjcmlmaWNpbmcNCj4gKwkJICog
cG93ZXIgY29uc3VtcHRpb24gZm9yIG5vcm1hbCBvcGVyYXRpb24uDQo+ICAJCSAqLw0KPiAgCQlp
ZiAoKGR3Yy0+ZHJfbW9kZSA9PSBVU0JfRFJfTU9ERV9IT1NUIHx8DQo+ICAJCQkJZHdjLT5kcl9t
b2RlID09IFVTQl9EUl9NT0RFX09URykgJiYNCj4gIAkJCQlEV0MzX1ZFUl9JU19XSVRISU4oRFdD
MywgMjEwQSwgMjUwQSkpDQo+ICAJCQlyZWcgfD0gRFdDM19HQ1RMX0RTQkxDTEtHVE5HIHwgRFdD
M19HQ1RMX1NPRklUUFNZTkM7DQo+ICsJCWVsc2UgaWYgKChkd2MtPmRyX21vZGUgPT0gVVNCX0RS
X01PREVfSE9TVCB8fA0KPiArCQkJCWR3Yy0+ZHJfbW9kZSA9PSBVU0JfRFJfTU9ERV9PVEcpICYm
DQo+ICsJCQkJRFdDM19WRVJfSVMoRFdDMzEsIDIwMEEpKQ0KPiArCQkJcmVnIHw9IERXQzNfR0NU
TF9EU0JMQ0xLR1RORzsNCj4gIAkJZWxzZQ0KPiAgCQkJcmVnICY9IH5EV0MzX0dDVExfRFNCTENM
S0dUTkc7DQo+ICAJCWJyZWFrOw0KPiBAQCAtOTkyLDYgKzEwMDMsMTggQEAgc3RhdGljIHZvaWQg
ZHdjM19jb3JlX3NldHVwX2dsb2JhbF9jb250cm9sKHN0cnVjdCBkd2MzICpkd2MpDQo+ICAJCSAq
IHdpbGwgd29yay4gRGV2aWNlLW1vZGUgaGliZXJuYXRpb24gaXMgbm90IHlldCBpbXBsZW1lbnRl
ZC4NCj4gIAkJICovDQo+ICAJCXJlZyB8PSBEV0MzX0dDVExfR0JMSElCRVJOQVRJT05FTjsNCj4g
Kw0KPiArCQkvKg0KPiArCQkgKiBXT1JLQVJPVU5EOiBEV0MzMSB2ZXJzaW9uIDIuMDBhIGhhdmUg
YW4gaXNzdWUgdGhhdCB3b3VsZA0KPiArCQkgKiBjYXVzZSBhIENTUiByZWFkIHRpbWVvdXQgV2hl
biBDU1IgcmVhZCBjb2luY2lkZXMgd2l0aCBSQU0NCj4gKwkJICogQ2xvY2sgR2F0aW5nIEVudHJ5
Lg0KPiArCQkgKg0KPiArCQkgKiBUaGlzIHdvcmthcm91bmQgc29sdXRpb24gZGlzYWJsZSBDbG9j
ayBHYXRpbmcsIHNhY3JpZmljaW5nDQo+ICsJCSAqIHBvd2VyIGNvbnN1bXB0aW9uIGZvciBub3Jt
YWwgb3BlcmF0aW9uLg0KPiArCQkgKi8NCj4gKwkJaWYgKChkd2MtPmRyX21vZGUgPT0gVVNCX0RS
X01PREVfSE9TVCB8fA0KPiArCQkgICAgIGR3Yy0+ZHJfbW9kZSA9PSBVU0JfRFJfTU9ERV9PVEcp
ICYmIERXQzNfVkVSX0lTKERXQzMxLCAyMDBBKSkNCj4gKwkJCXJlZyB8PSBEV0MzX0dDVExfRFNC
TENMS0dUTkc7DQo+ICAJCWJyZWFrOw0KPiAgCWRlZmF1bHQ6DQo+ICAJCS8qIG5vdGhpbmcgKi8N
Cj4gLS0gDQo+IDIuMTcuMQ0KPiANCg0KVGhpcyBkb2Vzbid0IHNlZW0gbGlrZSBpdCBzaG91bGQg
YmUgYXBwbGllZCBnbG9iYWxseS4gUGxlYXNlIHByb3ZpZGUgdGhlDQpTVEFSIG51bWJlciBpZiB5
b3UgY2FuIHNvIEkgY2FuIHJldmlldyBmdXJ0aGVyLiBJZiBwb3NzaWJsZSBJJ2QgcHJlZmVyDQp0
byBvbmx5IHRhcmdldCB5b3VyIHBsYXRmb3JtLg0KDQpUaGFua3MsDQpUaGluaA==

