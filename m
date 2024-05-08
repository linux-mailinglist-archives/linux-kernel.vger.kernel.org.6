Return-Path: <linux-kernel+bounces-173919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FB98C0785
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 01:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CC9A2818B0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 23:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C004B57C80;
	Wed,  8 May 2024 23:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="FTVmOisf";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="BSF3IrN6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="hs3ZwFsX"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677193A8FF;
	Wed,  8 May 2024 23:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715209734; cv=fail; b=sMLV1fyMYG2CAwysm+BpA3A+ZytihrKv2xfPweWDLJaIntENf3QMrwtLfrFJmGqJSph9kNuBvDiQXkMd8VD01mibbDfcsotBey49g7J0/08gE8uijf6Mh6D2DcMlv7PrS5lONnlhKxLOVYW6OuZiE9Uldkhx2nZVHHbVsPs11dw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715209734; c=relaxed/simple;
	bh=8H9vp+TmZTqa26DS39ZIGNG0oOaTetMaNAFUwyGO+7o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FZQFtBlLq1D09tovVH/y7bKaRN8oAcv0S4WZw3KTKkCEbYkJ5zpcgo7aPK8+c0znDCrjnGAYNxkSLYg1EWfJCj/ZUcJtoYVeaHpWy2f0E6dJZaS88XGsNfvsginEwNRc5lgmS/FDQGlDuW+ABwjuldM51PswtaBu4F3uq74VDWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=FTVmOisf; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=BSF3IrN6; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=hs3ZwFsX reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 448KYv5A024274;
	Wed, 8 May 2024 16:08:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=8H9vp+TmZTqa26DS39ZIGNG0oOaTetMaNAFUwyGO+7o=; b=
	FTVmOisfVPuglzfb2DerjkhN2DSr6WtLiId9cAsIyfQnterpR3+I1jctS9LRG2sY
	+OmxxhZCg2VBMHaCObiQaCOLU7BxnOloMXEMgHU80t/72hUBWvnKAj5wjZeKwEiF
	IUYmUUBoAGzmrXe/rPFV6DxdBSTSqrM4Ycd7n+8xhhP9WnCHnAyxaelRXrSnr4yT
	4aVQguh8yAf0qsdAOC/YWnFPxM1Xply4eDmlHaTEwbhDn1sraRLRA/GVIC0+6W4g
	gvlyTSXOOTLag1zZjRtMAFki/4nsBLSBJfwgy+4IXR8mzAp8vVOUF2BXfEjhffOA
	aCcHK/XAvOJlntrEUuLiJg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3xysf3wxyd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 16:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1715209728; bh=8H9vp+TmZTqa26DS39ZIGNG0oOaTetMaNAFUwyGO+7o=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=BSF3IrN68UcuGtMkw67XoJVu4xXlRkpCdLCDM9taHL1TRmz6LuvRsuuC1lf+lALcL
	 2ekfLNNfm7SXMbOVXlKW1UL0gymR6M9481SeRo+B5veFMJXyQkRpTsnOVt9zxNLGsC
	 1b5exky3LNmA639KyhaYJvHTqw+G/Qz+Kog+r6uta/yRD3rGfsSXtKXBNcIbT8G+KX
	 6HhAOwyptM1fqnFNLP6vJu0roYoQ+907JDSw6mRjVofmWlK7WnpZZ4mF26EPxrkVao
	 kSExQ/S4p6bR/ENfK6kvJQeH3WlEDxcKlF44QuBVIS0NGUKCt0sr3GYkTKLIlf5FWv
	 FCWqK34BoGfQQ==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5450F40407;
	Wed,  8 May 2024 23:08:48 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 0D7DBA0062;
	Wed,  8 May 2024 23:08:47 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=hs3ZwFsX;
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 5FCF740127;
	Wed,  8 May 2024 23:08:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FT4iI++JDYheoc98fNSozBRUwe+/EosJZWL1utrtzNtVvwEp4Qmqr9dWyjxbBDlHwBZ1lzn4aC7PtXDKX3+SedZ32P5+wpt4FlkthGZl4dWtcgpuLh4lw0s5RxtX5dmLAMMSczR8EkMirN0uHxcyJ3SgPbr6nCxnWIOVmEvnsRWmT7MK3mxRhNq/CtrVLAVSaAmk5HwBn+wWjln3zmniQ59yedA4uohAJRIVnjJRryR24vWYaSWfs9FkKIgUlLc9Z1n9dwg5XU4wKh/NYArrK/r+GzL7Y6Wgkb3v3b8JaMw0X1SgbA2UujUlZKNTfOq0kORsIUMHLt6muQsTTYi4Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8H9vp+TmZTqa26DS39ZIGNG0oOaTetMaNAFUwyGO+7o=;
 b=S/tCChUZXyyZ5Jy5v4PH2pnzpsIlF3hN//s/1rFIDGpUPZVPlDm81Fm2Ng6feLV08C4GTzQ5NScZveXpUbcJ80/vrXuvj/6fRgf3bLTBc4PI2Z0+a1JuP771IhBXVbxuSXanDrALoD9ITzkH0eupmnGx7hQ1WJgeQ1hkzwyEvnNAtHjRouC2lcUaIwsw8mT/dahNHzPTbkRTKWkRj362LZryfaOCkZtfCRe977jInh3oyBKEKH5szHvSfbSU3KfV0nlZnrjKraYsdHlXFtiK3cJbD7mncHhGTSYXPZ0LAPySfC36P6jmqmgHGLjvAJ8t3tn/wtSNy0jpHKK/p1yDRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8H9vp+TmZTqa26DS39ZIGNG0oOaTetMaNAFUwyGO+7o=;
 b=hs3ZwFsXISb5y2JuChoTVreHp5MrzoOZbrJqWgYGqmWQ2kfo2i8/R3TjNdVC0x3N2yH8wr5phEBcVleCXEE0BjQlPWgR1uvxoIML2oDH/P4KkhrCiyRWAu/kusOUuxsbZZCVIl5u1G1xsYOaMArykxP3OBFLdyselXeLAGrzGEg=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by PH0PR12MB7984.namprd12.prod.outlook.com (2603:10b6:510:26f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Wed, 8 May
 2024 23:08:44 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7827:b41a:c9d6:8e1d]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7827:b41a:c9d6:8e1d%7]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 23:08:43 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] usb: dwc3: core: Fix unused variable warning in core
 driver
Thread-Topic: [PATCH v2] usb: dwc3: core: Fix unused variable warning in core
 driver
Thread-Index: AQHan4oAuvANmhigA0qoHVJuTz57XbGN+j6A
Date: Wed, 8 May 2024 23:08:43 +0000
Message-ID: <20240508230839.utioi5i2c5kozm4d@synopsys.com>
References: <20240506074939.1833835-1-quic_kriskura@quicinc.com>
In-Reply-To: <20240506074939.1833835-1-quic_kriskura@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|PH0PR12MB7984:EE_
x-ms-office365-filtering-correlation-id: 2fec31f9-91fe-464d-0f33-08dc6fb3cead
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?RXg0SmtDWUFXNzJNRTI3Uk9ZUStVNHZ3Rng3QlM1bHBWbVRLSjNTWEt0amlr?=
 =?utf-8?B?NzIrU0tuUVdabXUzUkxPa2dtZjJSQ2tqZTc5UEY2akJmZFMxb0ZzSEZmUmlL?=
 =?utf-8?B?R2szdHc0NnZvNjBjR0ZucGpIS3BrWGttSzdRbmdjcFNZdk1sRGVzekticUlV?=
 =?utf-8?B?a0xFdzZLOFpFNGt6R0hEeEphL0VkNlFUdlB4bU5tZUZBcmZHR2h4S3I1eEds?=
 =?utf-8?B?MWs2T1BwZFhuTHJPQU82NmM1TFZSdHpLMEJ5ZEtnRFMrZGZPeWN3MXExWnFV?=
 =?utf-8?B?cEJ6bzA3WGpLMk9Fc1JLREl2YktyV3BYeWN3ZVAvNUVWcDQ1cldVRUZZcnly?=
 =?utf-8?B?UDNNOUppT3lIbFVjSGxPOE5YdXpvb3cwZnFleEJwamQ5TFR0eGRpa21xcTN6?=
 =?utf-8?B?ZVpnbWRkSXV0UTk0VEpMc0lTNkNmUjdjYU1EVEFDQWpVVHc4N3NyRWEyUkpu?=
 =?utf-8?B?eUFtMGl1STl6RmRYSGVDMnBRdG9YdDQ2QThmNE9IQUlYRzYvYlV4YVFWMEJS?=
 =?utf-8?B?cFpJLzJOUGtYQXNSSU9vNlh4RWoxeDd2KzRMMTNoWGhpbkN1THllem4rVDh0?=
 =?utf-8?B?TnMvTGdINmlvRlNLY0tWN3daZHYwSWF1THJ1ZDJZRzVuY092eGtURDFBUFcz?=
 =?utf-8?B?dU9GV2JxNVBoaXFhNWxob01iZnBwQW1lQ2RsTzg4c0dWWWc2N254bnVjTnFC?=
 =?utf-8?B?U29sNzNqOEt1Uk05eE03cytGczE3bXRreVpOTWdFbTViOGRjOVVHbEVDMU13?=
 =?utf-8?B?Vkhoc2hVdmVlWDFSQWdtVzdIdzVkblYvYitoOCtHeERuUDBYdGt2YUhoejZ2?=
 =?utf-8?B?Y3duK0k5YWVzUW9MeDlQc0lqOUZqbDE5UW9OT3luYUNjblRIYVA0QU5oN2lu?=
 =?utf-8?B?Y0Y5QmhZd0RSbHhDazlnL0tUazMzKzlQT1pJYmt0RXZsUE9YMEtMMGNGSU5V?=
 =?utf-8?B?U2NxSlM1RnRIYUl1QU1ucmlZVkpER3IrNmJtdm9ydkh3dWtmNU4xa012eU94?=
 =?utf-8?B?K3JyU1k1NGlObDExeHVOV2hFcUF0Q0VjK2tpNFNBMVBnVlJjVzJubE9TSWY3?=
 =?utf-8?B?VGFZMGx0dzZwTnFWeSt3ZXVOUUEybm1jMjJBNDZVdXpCUmdDczNxSmNDMW1U?=
 =?utf-8?B?ZWZlQm5qUnc5U1c0Rmk4cGZCNE1lby9Nb2xkZUh2dFB1c1lmcU0xNDZnRk5M?=
 =?utf-8?B?TFQ4aUpvZEluRkZsYWF2YzJMWGMxVWNOb05HQ1J1RmVyS1dhN25DT0s3c2Zn?=
 =?utf-8?B?OEZEZUxpa2kwSFVQM3d1VjhBWjJBWHhERE9DSXBSWDN1UE9PU0ZMSHE1R0ky?=
 =?utf-8?B?eGd1Y01KM3FzVVhFTTV6UzRpRHlDV3dQdS9CWTdaUm9uNHhpVGdIeGFFdlBN?=
 =?utf-8?B?Vjl1aGtmb1IwL1VyTlF5SW9rbDJVTWQrQ0YwOG5ZN1ZDYTByeW1oYWFIREor?=
 =?utf-8?B?MlZWSUZ3cWZOT2FRVGRTeDd0MVg5c3ZqOEl1bi81UGVWTjRlMGJpckZ0QnlP?=
 =?utf-8?B?VEdJS2FqVzVHUEU0Q1ZuNlRrT3NZempoTGIrRW5KTUs3TWNLUFJ3OFhNTzlP?=
 =?utf-8?B?VGtpMXlXeFBFMW5CV1hQYkRDVm5ka1J6U0VkOUJ1b3JLNFFHRkZGdGlIVnFZ?=
 =?utf-8?B?M2UwTjkvenRTNXkxYUo3VHNISDhxc1A3Wk9VcnQ0QXh2TDJrQisvb3lQTHVy?=
 =?utf-8?B?bjlIV0IyT2xuUXh5Y1g3RGdqcDNjaXpsQVk4dHlLeUNSUGI3ajgvbTVBPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?cTU2UjVZYWw4ank5N05ySW5rRktRVTBIRmFITzBwNm14VEphZlBIK0NaQlJP?=
 =?utf-8?B?cmZTanUybGJQYnFVL1Mrd1JsTUFDYUJVeER4aTRaeUZaMFhsNFFHL3QvZDdR?=
 =?utf-8?B?WkxJZC9hMURXRmxnL2VqSVVPdm9ab1RKLzhQT250VDRPSGtDT1RRajNhekJJ?=
 =?utf-8?B?ZWlZWkhYRjRBZlZtdWlMVCtobGJtby90bVNSclp6YjBSYm5VM2VxZXVRSXhx?=
 =?utf-8?B?WHk1N2xXREpxeGNXYTA5WEFkRlJES0Z6MWFDN2l6SnFDdFdJQTR2d28xZk5s?=
 =?utf-8?B?S0crdHdIMGVybXc0YjV6VzJIUjFuNFN5S0luMmVLbXFSZ1RhVU96SzFDZSt2?=
 =?utf-8?B?RzJVaUhCbUppY1VETUNWRHNJRVVGNExHRjUwZmhtQysrS3ZtUUhjOHdkU0hl?=
 =?utf-8?B?QlZtK3BvQ01xQkNFejVMa2FQdlVPS05kQllOY3RERzBsWm51czBSVkEwYlV1?=
 =?utf-8?B?aVJXYU93bEpoSUxLci9ERFhpUDZuQ2l0ZFNVQnhBYXIzNGZwd1hCc3RJcm1w?=
 =?utf-8?B?MFRLZ2taalVHWVZ6ckJ5VjNFOVo5b01JNlV2Qmk3Uzl4clVGVGJlcDdrUWhk?=
 =?utf-8?B?bHQ1Mzlmbk1mcitvMjBVelJQMlR0b0hLRVdvWW5qMGNhd2R1TnVEVjRCbXE3?=
 =?utf-8?B?ODdWYkZSUDRHVXZYYmVOU2NTOVBVMWpSeTRwdFdJVnZ3bzBxbURqa1FoWlMy?=
 =?utf-8?B?dHNJaGJTZkhXNFJZb1pQZXVoMUhPdGxiejFBQTBLdXI0Yk1MSlA0d255Q1lO?=
 =?utf-8?B?dTM2ejVuQkQxcGhxRjI2YXoxUmp0U2MydkRvYjhrQWVpYjRSNldFb3NZL0pa?=
 =?utf-8?B?SHE1d2ZaTFRkTkhpRHBLUms5S1BEUXVFMjFreWFHbVI1ZTFXVkh2ekFFR1Uy?=
 =?utf-8?B?eDZVM1dKZVNyd2ZtRDhYbktGUkgzUEQzOVRETkZwYXd2NGtWRGFKV2VqNEhY?=
 =?utf-8?B?VWg2RkxkWGY0MG1pMEozUm4rMXRZSG1HSGRjc1V5WEVpWUVnNkNuTlNHZnE3?=
 =?utf-8?B?algrTUJjY1hGUFlUUWp1YmREa21Bbnp6VTV3aldWaklPeEIrbjhkaUNobUVr?=
 =?utf-8?B?WFR1cklmbUlQa1FLM0d5b0xpUnlidVZ2YUg3NGNuaWxYdG5oblBGMWE3V0Vh?=
 =?utf-8?B?TXRDcERjSjg1bEdJbStTMWVvbnUvbHNsajM2RzhLdUcwemJucWhqYjZxL2dU?=
 =?utf-8?B?cjNKeTlpSlJFQlhKT2JFb0piNEM2YmdGVlhrdmtpaTlxSUxRL2VRSTBoZU1G?=
 =?utf-8?B?b29KVjMwd0FzbWJNOHZ2T1RMK1FFK2h6M1hnYmNKWTh0Y0JScGhaenhRdDJY?=
 =?utf-8?B?MGs0OU1hV051R2RteVBHNnFSY0ZLbXpPYWkzZFNQNFgraElhQlpRY25adHIz?=
 =?utf-8?B?Q3U0TG1MWGFyNkd5TWl3OHJXQ1RyV3owZzBEazVPQ3QreUxzZk8ycHRSM3Q4?=
 =?utf-8?B?RTJuK0xid3FSMnhzUk4velBPcUpzalRLa1FyelRXcCt5blVJNmFPK2NNV0RS?=
 =?utf-8?B?dk9EMFVCeHFmYk9HSDFTbEpnSGlMNDZQa0cxL0xCellGVlJZZ2NPU25VWFV1?=
 =?utf-8?B?OXlReXJrK050eHVVZ2x1VVMrN1J4TElHdktkdTEyZUJLSU5tMEwwamVzUVNG?=
 =?utf-8?B?cTBmS2RFZ1M1SCtEU3FFUm5TQkpkTllEQzlFWHZOZVhxVCsxNjJRNkdEdW8z?=
 =?utf-8?B?b0prVkhieUlUZUZkVCtaamlxcnN5eitoYjJ6NXF0ZEJuL25CS0JxQitXNndh?=
 =?utf-8?B?eFdnQ3B2VXBzUmUzczlzVTZmc3FZajBTdkNEZDIxcmxESE9TODhSejFmNGx3?=
 =?utf-8?B?UTVsdzdkR2JGMUhueEhnUWtnTy8rWlhZZjJ3S0J4VnFTenRPbFl1VFZRMm14?=
 =?utf-8?B?aUdlbWJBZ3JuNmY4RkVTOFBhRmgvUWtOOWdQK0QzMGFNbVNRajJPWHBHQ2o0?=
 =?utf-8?B?NHRjTzBqVm1Sek82WUdsOENUWlhBUWduc1lUNEQxVmV0NVhjcWFnbzRiQlMx?=
 =?utf-8?B?L3BvT0xnV3AwZklvTlJlcHZPTkYvLzBmYkJoM2FWWWxiOHJJRTlmVVdPYklX?=
 =?utf-8?B?KzUxUVgreWdwTDdCRUFpcWV5d1F4NHVXTUdQNVlYWUtvaU9sNjYxdTBsdmtp?=
 =?utf-8?B?MlJsamRDcGRzeGZZamI0blMrcG9jYzJ1b21QN0N0d1Nsemh4NTVxT3R2aFh3?=
 =?utf-8?B?K2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C13CFE560F34704E9903A32BDB8366C7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Y1oem9eL+KPzVT5+F/vUvGhUwTc4RN9jpb1dcyZ53b320qnlFNp3VIlwJEpcxWcq7ew/wk0pHujcSM1Z2eFehadmiji6WkcrceDpv13yPHtadOou/xb3E7DV+YwA+T/dGytJrzXBvz3lVGHMe57Lc49jleJRVe7DuW4ExeYO2ZMuu2XBBfeiyvkOCC9PtAwFlXTucqpMxDinXWp9B1LAiKjBozBXrsBWhelwn2iD3eZbG6/OWT81vDJrYzFzb7wD1emGkLAShbJVL86GjDkKcUkN+R/ESkmL6dSfkVJeaWoYl5GWb2OFCR2V7UkScaiYVmTDCnszcT/xFUONXcWDXVaVhrxdMIup/XOLLCqVtd/5f2dSA2W7qXoHFIdjrWKVOwBiPOyyOFp5DjEJYqjaGMUbsK8vfkVDPoy4V4pdWKHaEPmXz7MVW4gX0xmEqHr+iFVuvMakfKL86l/ppHWhspPhfgGomnrll8oLCF0OUoJrcaBZROWHqZEbbYQZ0o7GIElaFqnsqW75KbPGlNFux5bJuiC7/3Wac8Wx1jQVO93hj4v7yejohHEV3HSWtI62VRXz9098nhvvZRjYKfmKkxIl5oMe5f/J5k5WGuoj4c+qQ1/3OrChp5DpVLzUajXq1rdF0QGOSlI6L/KqnuUHrg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fec31f9-91fe-464d-0f33-08dc6fb3cead
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2024 23:08:43.7005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N9/9957P/kupRwsv2Mo3C/d8xi6joQ3EESMGa9ws615VF65iIhQ0SUENEput4bJUV5ZtwyKgCOi0nwG4hrbF6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7984
X-Proofpoint-GUID: iPYjoR4edLHvE9fgTf0uh62kN0AQque2
X-Proofpoint-ORIG-GUID: iPYjoR4edLHvE9fgTf0uh62kN0AQque2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_09,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1011 malwarescore=0 mlxlogscore=663 lowpriorityscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 mlxscore=0 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405010000 definitions=main-2405080173

T24gTW9uLCBNYXkgMDYsIDIwMjQsIEtyaXNobmEgS3VyYXBhdGkgd3JvdGU6DQo+IFdoaWxlIGZp
eGluZyBhIG1lcmdlIGNvbmZsaWN0IGluIGxpbnV4LW5leHQsIGh3X21vZGUgdmFyaWFibGUNCj4g
d2FzIGxlZnQgdW51c2VkLiBSZW1vdmUgdGhlIHVudXNlZCB2YXJpYWJsZSBpbiBoc19waHlfc2V0
dXAgY2FsbC4NCj4gDQo+IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVs
LmNvbT4NCj4gQ2xvc2VzOiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvYWxsLzIwMjQwNTAzMDQzOS5BSDhOUjBNZy1sa3BAaW50ZWwuY29tL19fOyEh
QTRGMlI5R19wZyFhWE4xNHR2a3Z3bk5aOU44LUVEaS1TZWVmOWpnWkJLbGtaUllhc0lOUmdUT1Uy
aWpXYlR2Rkl4a1pJWE9UaEdRUUhtWGMwRmppSlBGSTFjZ2RDT3lBYWZBeEItNzBRJCANCj4gU2ln
bmVkLW9mZi1ieTogS3Jpc2huYSBLdXJhcGF0aSA8cXVpY19rcmlza3VyYUBxdWljaW5jLmNvbT4N
Cj4gLS0tDQo+IENoYW5nZXMgaW4gdjI6DQo+IEFkZGVkIHJlcG9ydGVkIGJ5IGFuZCBjbG9zZXMg
dGFncy4NCj4gDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyB8IDMgLS0tDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9k
d2MzL2NvcmUuYyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+IGluZGV4IDhiNmY3NzY5ZmNk
NS4uN2YxNzZiYTI1MzU0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0K
PiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiBAQCAtNjc2LDExICs2NzYsOCBAQCBz
dGF0aWMgaW50IGR3YzNfc3NfcGh5X3NldHVwKHN0cnVjdCBkd2MzICpkd2MsIGludCBpbmRleCkN
Cj4gIA0KPiAgc3RhdGljIGludCBkd2MzX2hzX3BoeV9zZXR1cChzdHJ1Y3QgZHdjMyAqZHdjLCBp
bnQgaW5kZXgpDQo+ICB7DQo+IC0JdW5zaWduZWQgaW50IGh3X21vZGU7DQo+ICAJdTMyIHJlZzsN
Cj4gIA0KPiAtCWh3X21vZGUgPSBEV0MzX0dIV1BBUkFNUzBfTU9ERShkd2MtPmh3cGFyYW1zLmh3
cGFyYW1zMCk7DQo+IC0NCj4gIAlyZWcgPSBkd2MzX3JlYWRsKGR3Yy0+cmVncywgRFdDM19HVVNC
MlBIWUNGRyhpbmRleCkpOw0KPiAgDQo+ICAJLyogU2VsZWN0IHRoZSBIUyBQSFkgaW50ZXJmYWNl
ICovDQo+IC0tIA0KPiAyLjM0LjENCj4gDQoNCkxvb2tzIGxpa2UgbXkgcmVzcG9uc2UgcmVwb3J0
aW5nIHRoZSBtZXJnZSBpc3N1ZSB0byBTdGVwaGVuIGZlbGwgdGhyb3VnaA0KdGhlIGNyYWNrcy4N
Cg0KVGhhbmtzIGZvciB0aGUgcGF0Y2guDQoNCkFja2VkLWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5o
Lk5ndXllbkBzeW5vcHN5cy5jb20+DQoNCkJSLA0KVGhpbmg=

