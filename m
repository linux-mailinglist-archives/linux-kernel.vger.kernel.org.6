Return-Path: <linux-kernel+bounces-422866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9591A9D9F23
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 23:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1D7AB22B8D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 22:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D998B1DFDBB;
	Tue, 26 Nov 2024 22:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="EvBUbMcE";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="f5n7mJUG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="SavDNedN"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A3E1DA632;
	Tue, 26 Nov 2024 22:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732659352; cv=fail; b=l2DW0zn94NEdvpphuKt1EM+9E3uN7WZQTihVDxycZv/1BqpFVVSlxaVTLm/LZayceYeCbTAIbez+9XdxVaw5sO3fzYh05L19qtLnmtIE6vrxC4hjE/ydn8a6uE4bAXYKl4ZJAevTfCk7zb2dcCvdHLI9jbMTQSXboxXi5yMp2oA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732659352; c=relaxed/simple;
	bh=gTa8jXK9+sNnLKy63ulRdokKfjGUzq77BFpXZlAm4KY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sFVoLy57fK5Y9+G8+rOJdgrfhKgYYjpKZQiliFGmkm+q1hKhuv9ErZD0jUYhzdoDtH0nz4+UpN9FpHNykKyGzWUfumxWxTni/D+2tFi1TXJYKW1/Azdp04Of3a8Zdlq48B82naeC60OlRUXzs+GtpW7whnrOfvQJXpR9GcqXXvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=EvBUbMcE; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=f5n7mJUG; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=SavDNedN reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQL6uhv005844;
	Tue, 26 Nov 2024 14:15:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=gTa8jXK9+sNnLKy63ulRdokKfjGUzq77BFpXZlAm4KY=; b=
	EvBUbMcEVDzAnpErqQ7hbUk4O3c3p0uckGiEIPeVPtcsDhVHMr8NAe2+FdZn6o6i
	JD87dUIsAHT5pz2RxfygFV40VsLX3ktk8b9zfCCbE9iYSMK9R7fW78xZug3D6FV1
	8cGFnyfz8An8ALWWBWj8WraxcbKwtJv6RRYxf2nCWOL957XjuT6SC3/JRzowNhto
	q/1Hq029ezzLgIFIybLf3GKsAswjXEilr5qArdQ8xtsocjhTRue9Rq7qrina4f8A
	m+EpipJlrDlbrqVRRfKVvrv062lucBTZMVV6i4llRPJIhbq9UM5fr7/5uquAHh9P
	tNcocXv9AC6zrcHf0wihUQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4342b16sqn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 14:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1732659343; bh=gTa8jXK9+sNnLKy63ulRdokKfjGUzq77BFpXZlAm4KY=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=f5n7mJUGANLQnOZbWQE6WOOU0sUjUI+PcrGuy832kXHlHfAIqc/uvMCZe6s7lAUyb
	 ptrioR+dQfGdbmvcrWYIGK/VNS6casfyXA6YtQouGN48OwmP4qIXEf4pM7vKClIO+y
	 n0dqCw85LgHVLwDkiUsvTunTGIiKdcb1HiBffBXJVCeLWaQbCvqvIDkrPrMyy/CYQ7
	 wpWvs+bwqoPy7RENfPrIAg1GaBV7/5ZG6G3I93lgStd2jtYf+4meCl8adLJo4+Gn5h
	 tEQyWDH3m64InVO6p0ekFQzRLpKnUMVpFEU7xWU/SOWFtFVMz2fnPeKMwX8IYL6l73
	 MnRqwC4UqeiuA==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 333A340175;
	Tue, 26 Nov 2024 22:15:43 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 8C93FA006A;
	Tue, 26 Nov 2024 22:15:42 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=SavDNedN;
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id D9B7E40453;
	Tue, 26 Nov 2024 22:15:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TB3sv2blgyqZRHPqOJdZfQ1Vlb/noG9S3/CXf9H/DpxsAk29FcYj0/r4VdB8+oX6WVioIWDqnQ8zaLjeqUJORRQm4ue9CKSZrWHQqp0fbSWQkXpWTbUSRReXFQO51+OodNUiBt+5yO7R0UC7/i3zElv2Ltn2lIrFFX0kjsHOB8puD8vjcohaycOFzrBOqu8B/KpidXA/bHYue9UbIhxzwhMZdHIDH98XyCs64FeF52wxam9yKJZpCN7G9K+4N1uU2I7ajWZdLC4/+0I6DRTt5aEflWdn3JjkJNaop9Mkky9ms6WA8Lhz6iiWw1sBoVDH/h8soWD72xSrGzuiE50ZUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gTa8jXK9+sNnLKy63ulRdokKfjGUzq77BFpXZlAm4KY=;
 b=pLgbA/FpNNVaNCsOTL+JaxtkKzn30WxVCN7a+kNyplOIydu9nXICRbxMi6HsC14Ov/35MyyJO5lTT9/Ll7UiwrNHUdyx9u34SeYmtmxyDntOXWuiNG06l1HP1fI82+w1l87ytMIQDWsRCeekcxmSXihjfwqoeDDwBTR2uQ9nrPAaIaHkr5/yQiVfUoOEvlVAnWgwPgzjC31F0cUctfc7aS0nZkHUpbS3oxexb498osgblRVjOp0MiMJKpzGe26tM+kwqajIdBKZv26EsBbcLnxtjkIwhRYrhfZjMHkjVJJcOPAEqwpL1k6QD2lDyCUgZCO20gRIsJeAjQkN6cvbj6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTa8jXK9+sNnLKy63ulRdokKfjGUzq77BFpXZlAm4KY=;
 b=SavDNedN1jjrpOL8DgNbXIw8mcgjGlzj6NEgdqpm6OmVwK7fv2girTqqGxkMSCsz8kv6Wn70LhI3kePX+yw2EFHI4fhdYKkFvbXdlNtf1dksnvhs9BLuc4SHD+N9oEEfKCQoriwvyWthwpSw5dRzmvN/Vhz8UhW9HSSfRQqFe1k=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by MW5PR12MB5600.namprd12.prod.outlook.com (2603:10b6:303:195::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19; Tue, 26 Nov
 2024 22:15:37 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 22:15:37 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Roger Quadros <rogerq@kernel.org>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Siddharth Vadapalli <s-vadapalli@ti.com>, "srk@ti.com" <srk@ti.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: dwc3-am62: Re-initialize controller if lost
 power in PM suspend
Thread-Topic: [PATCH] usb: dwc3: dwc3-am62: Re-initialize controller if lost
 power in PM suspend
Thread-Index: AQHbPOaCI7R13zfU+USZwOYHfSs+F7LIVIOAgAAKgQCAAcieAA==
Date: Tue, 26 Nov 2024 22:15:37 +0000
Message-ID: <20241126221536.n4ecwbndpelx3bmv@synopsys.com>
References: <20241122-am62-dwc3-io-ddr-v1-1-cc4956449420@kernel.org>
 <20241125182343.bfnecsub2oxohrns@synopsys.com>
 <523727cd-7950-45b1-a0d3-3f978e789015@kernel.org>
In-Reply-To: <523727cd-7950-45b1-a0d3-3f978e789015@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|MW5PR12MB5600:EE_
x-ms-office365-filtering-correlation-id: 1c854084-6094-4066-a763-08dd0e67db36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WTFoby9lMWhLcnViOFozSkVMZ2wxRG9RMDNKbXV3Y0VKM1BaM1JiZVVlc3NN?=
 =?utf-8?B?MGtqMXhCckpEVTNXQ2M2SVNSaWVYenVYK0IrcXJrMU5wYldpbDJWV1R1Vmc5?=
 =?utf-8?B?QlJjK1NremNScVlVb2VBaTZrRUFLYitNTUJLa2FCaWN0K3FkN3Zsejdzc25n?=
 =?utf-8?B?Uy9MeERPVGxBVjJNblNMd2tCOWRUUHBpSzBRTkZMYWNlSjlCWmtUeVlBWnZ5?=
 =?utf-8?B?RzE3N3MrQytQRWlvMFJ1WFVUdVZFa1ovc2REUkhLNlhVVlNkZlRGYkprRGJO?=
 =?utf-8?B?bW5idkRqdHBLN0N2TFFySkFJT0JPb0cwWlpUalowd3dOVmEyaDl0S3JBUU1D?=
 =?utf-8?B?K1QyWXRNbEJIUUJaV25qT0N4MTVxZVlqS21VdzZhNXVMbnl0Uy9ON0Z3RVdD?=
 =?utf-8?B?cXFMRUptTTh1M1NzRGl6N0ZjcGUxODl0YkdXMVNMWnJlNTJxWW1aTmpiMHpi?=
 =?utf-8?B?ckNEYXVuWVlvNDA2QmNyV2M1MVVwOVVzbTlqVkdSdHZlaWR1eFU5U3dMOXBn?=
 =?utf-8?B?alR6WWM4RWc4NXhmUnlBdmErNlZxVmJFaThrN2pmY0VxOVh5RkFURitLaWx5?=
 =?utf-8?B?QTd4VWRtYU5ERERvU0N6YVgxakNBTFFvSXBBOHl4ZXJ2REx6Z1VUUFJLSGtG?=
 =?utf-8?B?bHorbnNGY3JWS1d3eDlWT2VsWEVQUnJvOTdhZ1Jwa0VlamMvUXlBN3NJWEgv?=
 =?utf-8?B?d0RvV0ZCOWNZRUhDd0dBM1QyZ0k0QVEyR3NlR1hob3pOS2ZGa1V3SjFHdTNO?=
 =?utf-8?B?dXdLUUVrOGpPN2ZBL1ZXenhIWGlyZVk2RXdLanprMUFuQnZSY2ZHQlR3MExq?=
 =?utf-8?B?Y2F1WXZCNjJSRStVdWsyM0NheWJlWjVucnRHZ0NBTHg2L0hseWw3YnRsUi81?=
 =?utf-8?B?RDFrQ1lFa0IyaXNyK2loa1ZFTlB0MmJjZHZzWEdPWUVEUksrUVZEdko4UFpt?=
 =?utf-8?B?TXlFeE9HbE9JUTA0azdaY3pkWFl0ajBLQUt2dkc1cENXVnA3bG02L0FDUkNv?=
 =?utf-8?B?M3ZiVHdFUkNnYVFERDE5MWpQUEszYXV5T1JDOVZ5QjJ2VHdQRVU1dzh6cWFH?=
 =?utf-8?B?dXlBZkoyMXB2SWhrOXA4NGRORldZT0s2NHV4WjlpaFM3VGdZRG84eFgwNVFp?=
 =?utf-8?B?TENBU0I0enV4bk41UmVLRDNIR0ZMTm1LSEkzcXZRRjJvR0cwbzZZeGIvN3VY?=
 =?utf-8?B?cU1ia0VWekZKTERxaWtNUjJHV3RDQ3pvV3dSSEsrekV5eklHRGxCRi9LSUxD?=
 =?utf-8?B?U0JING1oWnEvSEFjeUExTXM5L0l6Y0p5bVJUUHg3ZlAvMCt3bUhLSDFOQTV1?=
 =?utf-8?B?bnZkYkM2Z1gvZXlFaXlyZ2dTL3pMUW9hRUFuZjh6aWQyQ0ppeFRjOElJbEk0?=
 =?utf-8?B?VVpOZ28zcGRzVk5GNUIwNFZUMERmS0tLNjMvZ2sxb09KZXBnczI0WlBmMVda?=
 =?utf-8?B?bGV3NEtCbkw0ZHdQS2RVdks5S2o5S0hJelh6R3BXTDNNdjFDN3VGM3Y5SEJL?=
 =?utf-8?B?Z2VCOFRKb2R3c29IUTJPc3piMTA1eUEwbVh4Z0hsSy9BbDE4YkxlR3F5Q01t?=
 =?utf-8?B?ZWJtb1RlWGlPNDN5SzJRWGdZZFIycHJ4T1ZwWnRZQ05oUGt2NVhxckVyd3l0?=
 =?utf-8?B?R3VxL1FVRG5rV01EZGwzdWlvM1BOcWg1ZU5nTjB3STA2Q201dVBtdXZzSGtn?=
 =?utf-8?B?dWFCSlovY1NnUU1vVlYvaVVHRlkwOU5ucFptblJaZi9OVGRPNFBxYmkvWXJj?=
 =?utf-8?B?NG5RTHZjTWRrc09Mb2lodk5HU2RXVDE3NEl1OWpkSmlENEljalk1WjBldTNv?=
 =?utf-8?B?TFVoYlJCT1lzZ3hNQjcvZTM5a29MTTNXRlJHbVBRbmJzVHJ6b0kvNFRnc2RW?=
 =?utf-8?B?QzFhY0pUdG9yR1hNMk5PTklVQlJLYXVJNEFTb3EzRDRWSkE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TkRRRlkzdEhxVno2NDhKMHdQdVJwTGZFd3VXQXRiUDBOanpqRm40akRycytT?=
 =?utf-8?B?N1YvcGVIRmpUYTIxcWJnN21QNkdMRVpCUHUvMGE0czMyRFNTMzRBY09UQ2VQ?=
 =?utf-8?B?RGluNUQwOVFQWEdyQzArbHBwR1RDUVkzUDNtM3E2M0l0bEhXMTdnV21MTFZV?=
 =?utf-8?B?SDJwbDh2VHdyaFB1Wlhnc1c1NVNtckpGYk1wYS9QV0EyMi9BeHNhTGRXK2ov?=
 =?utf-8?B?Yk96ekRMYWU0VTEwcFZQZTcxTHFaK1c3elM0d3R6MXNIZzFhQ0hDS2pqcVpP?=
 =?utf-8?B?VjlreXlVQVJpc2NncUNYaHd1Z0ZvcGFTOXFUU0NNcFB6SnhPdXZ3WWpwd3k2?=
 =?utf-8?B?S1JlTmZJVCtDQStUZWhCcDZWVWF6ZHYzS1o3dWlWalZ2eGdsNVI2Z1IwQmVE?=
 =?utf-8?B?dWN2Ukc5cVZVN2lxcXRJTkZJTkd4TzF0QWtvQkJEZXh2Qncwb1VRYWMxVndz?=
 =?utf-8?B?UDFUbmUzdVU5SWZOcWhWeWs5Uzlxd1o2RUZIOTdLMjQreDNpOSttejFLK0xK?=
 =?utf-8?B?WTQybXZOY05zbTY2YzJYVUdRUThjbUd0K3IrbWhuZ1drTjRtR01zR1hja0oz?=
 =?utf-8?B?WGVCclF1aG1MZk5aaTZwUms4dDgwNzZ0QUo1eTUxem5La25aZEJBa21KdzNu?=
 =?utf-8?B?ckpUWkFkc1RrN0VhOFc5QTIvMEt6ZFV5dk9KVVA2bXZKbWhYVVVtSVoxR1R1?=
 =?utf-8?B?bVVaazVuQTNKK1ZiOVNKbWZsWStGbHdFSEF5ZmxoRzB1djNZNUViVStEVGlM?=
 =?utf-8?B?Y2x1ZkdlMlhIZHMvdkFyZDRhRWhlZGNwUGtONFNibXhzbEtXOUVadmVwMWZ1?=
 =?utf-8?B?cHVVQUIwVUtOU2VUTGpIa1pZOWczNXhkSG1zaVR4d2NJeVlOdGxMSTFGTURT?=
 =?utf-8?B?WVlMR2xYaVE3Y1h2bkJmV05JdkJzNXBGNTlURUJodGVtUDlnSktxRnRmUEpT?=
 =?utf-8?B?ZzhOeFE3bGZoUFBobUxmVVd6REFRR3pVSExwTVN6S2lPd2lIbjBiNGJMVkpx?=
 =?utf-8?B?YVduaTdyOE5zb04zakpqZTFLcEFmRmJsYURMcVlxRGpqR2cvTk1hcGFPclp4?=
 =?utf-8?B?WDN6aGxlV21YZW5ZQk1PY2c1ZW5saEhaZEZlay9BS3R3ZnB5OHg3dEpYR25t?=
 =?utf-8?B?L1BwVG1pbTJVSWk3QXJvVXJWU0FsZ3ZWbFBxRERiSThxQ203UWhaWHBMRE5m?=
 =?utf-8?B?bWlxS1V0bGtmUlhzNzRqTHI1RHpoVDBMeDBWTmpEeTZybzAvYjVhVFNoc2Ra?=
 =?utf-8?B?Znp4K2FIZmI3enZtZnJhZlVFTExKV0hybTRXdGxKRzhaS2wzWUpMRWNWdXZq?=
 =?utf-8?B?MDU1MjhnYVE1MW1FMXMwS1ZWeW9TRUhTSTBlSnZtLzQ4Tm5mZFJ3TFR2TjUy?=
 =?utf-8?B?VVJaSTFnaWxsZlkwWWo0S3dVM0hSYjU1ZGhIalBibXdENzVGc2dMZmV6Rk9s?=
 =?utf-8?B?WVl1enlOS09rZjZTZXNYdHFCMzZKYm9nWUtFYjgrUStvOHEyUE5jejZjSFdp?=
 =?utf-8?B?SEFBVjdJNjNEMFhlZStia0Uydm0ySXZHd1lPeEhlWDFpdVN1WVZrUTBJcDFN?=
 =?utf-8?B?V0d6N3NtVy9TVGh3UzRsV3JjM0ZmUmhTUUJPYWZ4T1hKZ2VKTjBTYUhNTFpj?=
 =?utf-8?B?SjkxclFXZktKcHFoT2tOWTBqWHN5TDJJS0swdGFaQU1zcEZROXl5TzBBcWM2?=
 =?utf-8?B?N1ZWRHJYQW5NVE9RbDh0OFhsN2RaMloydzVqb2ZoMnF5NCtENWtYVHRNRXN0?=
 =?utf-8?B?cXE4TUt4V2dLL3o0Q3p0YTJ4VkVuNjRDeFhnNDlUa0tBS3AzdHBnV1Z3TXoy?=
 =?utf-8?B?eWh5c1E4YllZZ2tiY0FyN0tHL29pMnE1S2tJT0ZuYlRnd1A1amxEM2Ivc1Y1?=
 =?utf-8?B?YnRSSmtISmtxbUV5YzIxVDlzbjJNa2ZyNkNYN3RNbkkwcDMxRUtQdURXNzBF?=
 =?utf-8?B?Si9lN1oxNFBMeUVWRCtLTU5hL3ZValhISWxkWlZieXBybjM1WmF3VVY3WFJG?=
 =?utf-8?B?VjAwVm1KRjhYaks5RUZ2RVltL2dEYjlHMHZyU0pha3pTRTNHenpyTXRFdjJ5?=
 =?utf-8?B?ZlZRN2NEOUZMajZ0UXZZbFlxbFJwRFdMZjhiWFdCZk84ZVNKZEdRZ040NWJO?=
 =?utf-8?Q?vRJkiESbJ1+WQURKf1Glfzcz0?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D7A676F19C16A4FBFA40CD2B942AB0D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lFNZOqmaO4AKvgnrvF92RcukfxwcGrrpwFcBRy9vYfOKunU2ZdEhu2kEAPQ37K76AYIWE+iShInQC+zJWr43vGRdF9LlYi6avArJLFXpTO3rNrWpfNKcpEfUZZn8i5rNMxh+EyAiubYUpr/RUNgkMRX73+mBYq14JJ3pQnM3H9eP+LH5abzVzoA41v+TVRNqo3pJCadeN+thGc/ntpRWQoS/54ABIPgCKGnL5/87U69kfOqGfpPS+utUjsqfCoYKVq7lLGLGYNwMg2ZBJeVHgmgfO7bQExFMnQcUNZD4YoGhLmJeKvtaRkfxNNtiqPEAYG5GQxGsQ68D4F4BCQBBUy+UgjTffzzUZA1/ACBuhyMd+v6LgEulHvTF+HXkxXeqvAgFbI9byeXUtP3i/CD6S0IQsOMUJlVfJSHO55ULcMmVoDf8t4uUo7I0UmH+h1esP3Fca6zIuW4t3q5NBuc5rMlAK7vH10Sk/VPd+7TmjV6FbB+m/9lAUwh66qnKvrV8VZsRA+TZ9WryhipDOe58sWOYRRFhA1YL5oKaul8VCCMvZLG3PGTo1faDFNd8EjRm6coHXttKv9ZYGurP0Q+cE1DtaVWmQjCqTsX3tC8K4rkhO1mgQz2jeu4lxGlZFhQtGOIgn00OXVJ5SF9+FYCVDg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c854084-6094-4066-a763-08dd0e67db36
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2024 22:15:37.8429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: If88w47xihrNdpcw/aDPJ7YoEypszs221IWz90kJnqzDIaBFt9ZihQUSMoLk/vf+C3LZP09jff2A4Pw2MzFloA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5600
X-Proofpoint-ORIG-GUID: RIIXL8WzYIdSoDnxmWIzMDEJibPznku-
X-Proofpoint-GUID: RIIXL8WzYIdSoDnxmWIzMDEJibPznku-
X-Authority-Analysis: v=2.4 cv=I4Y3R8gg c=1 sm=1 tr=0 ts=6746488f cx=c_pps a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VlfZXiiP6vEA:10 a=nEwiWwFL_bsA:10 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=NTbbomkTsEpDHpg5HO8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxlogscore=939 priorityscore=1501 adultscore=0 malwarescore=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 mlxscore=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411260177

T24gTW9uLCBOb3YgMjUsIDIwMjQsIFJvZ2VyIFF1YWRyb3Mgd3JvdGU6DQo+IA0KPiANCj4gT24g
MjUvMTEvMjAyNCAyMDoyMywgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+IE9uIEZyaSwgTm92IDIy
LCAyMDI0LCBSb2dlciBRdWFkcm9zIHdyb3RlOg0KPiA+PiBJZiBjb250cm9sbGVyIGxvb3NlcyBw
b3dlciBkdXJpbmcgUE0gc3VzcGVuZCB0aGVuIHJlLWluaXRpYWxpemUNCj4gPj4gaXQuIFdlIHVz
ZSB0aGUgREVCVUdfQ0ZHIHJlZ2lzdGVyIHRvIHRyYWNrIGlmIGNvbnRyb2xsZXIgbG9zdCBwb3dl
cg0KPiA+PiBvciB3YXMgcmVzZXQgaW4gUE0gc3VzcGVuZC4NCj4gPj4NCj4gPj4gTW92ZSBhbGwg
aW5pdGlhbGl6YXRpb24gY29kZSBpbnRvIGR3YzNfdGlfaW5pdCgpIHNvIGl0IGNhbiBiZSByZS11
c2VkLg0KPiA+Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBSb2dlciBRdWFkcm9zIDxyb2dlcnFAa2Vy
bmVsLm9yZz4NCj4gPj4gLS0tDQo+ID4+ICBkcml2ZXJzL3VzYi9kd2MzL2R3YzMtYW02Mi5jIHwg
ODIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0NCj4gPj4gIDEg
ZmlsZSBjaGFuZ2VkLCA1NSBpbnNlcnRpb25zKCspLCAyNyBkZWxldGlvbnMoLSkNCj4gPj4NCj4g
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1hbTYyLmMgYi9kcml2ZXJzL3Vz
Yi9kd2MzL2R3YzMtYW02Mi5jDQo+ID4+IGluZGV4IGZhZDE1MWU3OGZkNi4uMjE5MjIyMmZhZjRm
IDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2R3YzMtYW02Mi5jDQo+ID4+ICsr
KyBiL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1hbTYyLmMNCj4gPj4gQEAgLTEwOCw2ICsxMDgsOSBA
QA0KPiA+PiAgDQo+ID4+ICAjZGVmaW5lIERXQzNfQU02Ml9BVVRPU1VTUEVORF9ERUxBWQkxMDAN
Cj4gPj4gIA0KPiA+PiArI2RlZmluZSBVU0JTU19ERUJVR19DRkdfT0ZGCQkweDcNCj4gPj4gKyNk
ZWZpbmUgVVNCU1NfREVCVUdfQ0ZHX0RJU0FCTEVECTB4Nw0KPiA+IA0KPiA+IERvIHdlIG5lZWQg
MiBkaWZmZXJlbnQgbWFjcm9zIHdpdGggdGhlIHNhbWUgdmFsdWUgb2YgdGhlIHNhbWUgcmVnaXN0
ZXINCj4gPiBmb3IgdGhpcz8NCj4gDQo+IE9vcHMuIFRoaXMgaXMgYSBtaXN0YWtlLiBUaGUgc2Vj
b25kIG9uZSBzaG91bGQgYmUgMC4NCj4gDQoNCk9rLiBQbGVhc2Ugc2VuZCBhIGZpeC4NCg0KVGhh
bmtzLA0KVGhpbmg=

