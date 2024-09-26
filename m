Return-Path: <linux-kernel+bounces-341073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC60987B18
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 00:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A791B26285
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 22:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC2E18B473;
	Thu, 26 Sep 2024 22:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="sde/7vP+";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="gTs8NQ6g";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="NiNE/QRw"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4F018A6DF;
	Thu, 26 Sep 2024 22:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727389031; cv=fail; b=f4TFOXio945paBiCT7L74NEK2P4TOBQbF1OLuLmOLNaA6RcZZrC32sgIfi1G3ObVWhYT3jmzPJLGOP0kz9G9OyE2wQ7r5ECVbohDIwRQGgvCfjp3u8vqTbjUKxiG9GGj2ku9RW4c8VYrpv4Ndl+J4Eh/Kxl5Jhw0LNueMzBdwYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727389031; c=relaxed/simple;
	bh=0T8fgS7nQN8m192UXMqBvsOSz7hZzce7RRbOqQFUCZ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZnQCQlpLDksxqmw3ArGtyP7QVH+QPGe2F0ki6BQtPMTl+3fgKNiT8hRspV61ycNeT3b1E1GXh4QYM51Bqi299JUBB/+1VPiawa+1eL9SwANDHCKrEqyy/ZEBrT1QikpgeWH5RKZZrdYKsAn2HlAN3MyK0S408SKY2yi64Z++W9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=sde/7vP+; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=gTs8NQ6g; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=NiNE/QRw reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48QGeCe1018501;
	Thu, 26 Sep 2024 15:17:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=0T8fgS7nQN8m192UXMqBvsOSz7hZzce7RRbOqQFUCZ8=; b=
	sde/7vP+B5/HsgnX21lkAk2pG+oEsKYwhSJZ5LbdfcnPUPt+0M0l8calosvdNC/N
	tl89koBe2+tKSvjjOe1flOdN9a9JopOegCihl0V8O48f9BzUXbvxiiXwjDmq2fgU
	X2+IjT0SknkTKyofyc8p/kQKBiYAZq9aD01xB65k5+J/8feKSHFjlYMpTbhXDrJ9
	UatyNABVlcpTCe05nZBrUN2smcNpxoi+xaTxMNIl8CDCULV1h4DKVGLHViBetTep
	9XcJgv6jsqYCU58p1d0D+aS1zBN9kNU1yV+Dme8Neqb+S6pVCJu8zSXcf+dMbyal
	JRUXeXZZ+gYMM8fy16OHuQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 41sw30k721-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Sep 2024 15:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1727389019; bh=0T8fgS7nQN8m192UXMqBvsOSz7hZzce7RRbOqQFUCZ8=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=gTs8NQ6g+DsoJN9Uiimqsvm45k8wiTDXzzzUIWDmEMTuLGb75iI9HHSyALijxcfOn
	 l3Vau7W/4TGIR7pvGyHRRdKmFFrCN0WRWrMcJ/EvGhU2n4IZHDTq1cJ98Pc5TjLT6e
	 vWyY/ZW265+u9FU3KAMmYTw6wk3TKEM6M8UnattZ2XHbzqyP8K2GMtzsrfQdrXaFZn
	 ERDlSIAdhMzoeRQ6hOPYBxgrGRMhvdz7WAyqReYjNDiL5EMZpboPTUyd58TsFlvMv+
	 C79aDp5hqezXkHOZ1tI49esseACrQ3A47e2P2NEDvPCtFWatNGE1J4u7RNmDhg6TwY
	 P9NVF7dxt0NIQ==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A886D40291;
	Thu, 26 Sep 2024 22:16:59 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id BEE81A00B2;
	Thu, 26 Sep 2024 22:16:58 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=NiNE/QRw;
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2040.outbound.protection.outlook.com [104.47.70.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 60DEE40361;
	Thu, 26 Sep 2024 22:16:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=leESY97MJkAHBJm1X3RyzOkzEVthxTbAQsanVCRBAfJfVTQQBOa8g/5sSLQoUUeooNEbBD4RLhTXnSfWES/hLgz6iQ2eMb0JevvUIRhd1gJ5MqyptqxECa861SMYfWvft4HUTFoyRP4PdlIyDZjKez9xB22VksJQofw+ADbQFVY3tBwkWF018enJnzeR9yx/rSU571Xbmx/q1Gc3EjrgR8RD7eGcYgpUCQ8HEFGFJIBekxwlCwHyW4NxGwfzf4u9lchK+UwwBUaW9Oro9Vhre3/hgkw4lhgTfCi0hjqAIPSMsVNTvrKgQOLJlnH67zhNjgmpS1bb4A+tNsZja8bBHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0T8fgS7nQN8m192UXMqBvsOSz7hZzce7RRbOqQFUCZ8=;
 b=iLJqCGbFGuclIRVIz/ITftfz6GiWT0i2CqX+rcNDCtt71PS1To4vypPo5y1j0QfC3vRGV+EBVMqfClC3i50DfNoC7UfuMrwOdEpBVEEWs+GK7gJ89ze3PjlYnMjojgHH18ZPc+ZiaKdquBkIUGOnZFQo2zP7ECH/PK38H4EK4ZZag7c1d4FG7n5Y7/eZh70jMBTddhELY0ygUPXcgV+dVpOi9xWQ7rl173Za0sT3SRTEkCJrCX4UtMnmxMN6I2FHVn/n08i88AaXI2YZNDUkSCZ4ECkzlZKSFcYATBpdEKhqaCNdNbbxka2I9Bmqz6Trhkg9BobtygmYnVqTIDhnqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0T8fgS7nQN8m192UXMqBvsOSz7hZzce7RRbOqQFUCZ8=;
 b=NiNE/QRwnk+WEWUTqu+dUYNmP2AfYHY+YMWeCfQRK09SCZYivyDwzVEd7fRDZtfdxaMwRw4YtQLW9NaDajFLCPf5stBp1toSTGv+5Jz3+nUjKItNIJMhCbtksGdvOaCIjm31a6MRmSKDnQEr8CK8d1I6LhSeavE+O59psuPFBJk=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CH3PR12MB8902.namprd12.prod.outlook.com (2603:10b6:610:17d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.26; Thu, 26 Sep
 2024 22:16:46 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 22:16:45 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: AKASH KUMAR <quic_akakum@quicinc.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>, Jack Pham <quic_jackp@quicinc.com>,
        "kernel@quicinc.com" <kernel@quicinc.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Vijayavardhan Vennapusa <quic_vvreddy@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] usb: dwc3: gadget: Refine the logic for resizing Tx
 FIFOs
Thread-Topic: [PATCH v3] usb: dwc3: gadget: Refine the logic for resizing Tx
 FIFOs
Thread-Index: AQHbCOpfKf1IfVXlVkK9URoNfPyL2rJck1gAgAC5IoCADWUwgA==
Date: Thu, 26 Sep 2024 22:16:45 +0000
Message-ID: <20240926221635.63flfmtrryfr25cu@synopsys.com>
References: <20240917101355.15580-1-quic_akakum@quicinc.com>
 <20240917224026.qsewm3epwaubcgs6@synopsys.com>
 <e2ff397e-b6a2-4991-8431-73aac7356e2b@quicinc.com>
In-Reply-To: <e2ff397e-b6a2-4991-8431-73aac7356e2b@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CH3PR12MB8902:EE_
x-ms-office365-filtering-correlation-id: 1d670f1d-2094-4d85-bc32-08dcde78e895
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Tk1jWFlucjNjNzJpbXFnK01lVlQ0K2JpR0JkUThGZHE1WVdRcCt0eFdVNnJw?=
 =?utf-8?B?WkdOTHVMMkNnVThhclA0MlZqdEM3aVV3Uzk2ZHA4Q0JMbHdpRmJOVWZFcUtx?=
 =?utf-8?B?NU9ja0ttNzRFcFdQMWdmRlFkWVBNZ1pNNytMUGxMWTBXRmFBa1UrVzZHTDBx?=
 =?utf-8?B?ZUdBR2Q0dDFPSkNkbWpzcFlJNXJGYWJ6VUhVZFN1bTBvT2JZdWFGd1FQSStw?=
 =?utf-8?B?OXZvaFVyZlZVdFpVNWxHZzl4dUxTREhnVDN1K05JN2R3aGxybEJiT2NrYTFy?=
 =?utf-8?B?dHM1S0tYeVNEVWltVWV2d0VLREdLZTdWK0k2S1I3WlFGMHVhUkNoOEdqQXFH?=
 =?utf-8?B?WEVIMlJoRHVYSXBDQnY2NGtuY21wUDVjZzgrWXFwaStSdG1HYTZRWk5KQXRC?=
 =?utf-8?B?UC9zcGo4amhSNmF3ZkpmSWNiT2h6c3lBVnpQbjU0ZVp1RXp0TURPNnlKQ1By?=
 =?utf-8?B?dWVHZzAyMmJUQUpEZU4zZ0laaVJQRFJRYnBLM2lwOUxyNTNSc1FjNXVNZ3Nn?=
 =?utf-8?B?ZDAwbXlsd0ZSYnVBb0w1RldhQzBueTI0ZUNrbE1KOUlrMDgrWlpnWk15V1po?=
 =?utf-8?B?Q3JJcmJpcGFjUm02VkJJQmpwS2p0VEdJV0w5c1RlOWhaOUNPc0ZDMGhtNDBr?=
 =?utf-8?B?ZmpLLzhTb1NUaExXTUJMV25yUm96WjNIK3R6TjJ0ZU9nQUZDMm9XbGdsOFoy?=
 =?utf-8?B?eUlhTDF6R2lqUi9DeDNlZkhSOTRiN1BMdnJ4QW5vaGJ1VmQvMEhQYWlyWEor?=
 =?utf-8?B?aGZ6NmFWcVRVY2xJZ0pNQy9xSFg1a0IvNHZVMkJybDdFT0hoMERJRzY4TWNT?=
 =?utf-8?B?d3NYRWY4c0wzUWFZOHVrZndSVWx5NjUxRENMTXJpWEVhdEJCdytSSS9JSHFr?=
 =?utf-8?B?bUhCcHAxREwzaVU5a09VZDZweWdZNlpOZmRQNkpWRnRaalB4L0lTMElucENh?=
 =?utf-8?B?bHlWcUIyM1pFL0JHeTRRdDdRdGxDUnRnVXNSRmtKNlN4ajczQmRocGQ0RHRR?=
 =?utf-8?B?YlcyRWRmYjlLR3c1MDJVS3lOcXVBWDN6TW9MK1gyR2VlTzYvRVFUbFFqVUVi?=
 =?utf-8?B?VnhoVTBkNG5OeSsvT0tCRkFyVWFCVExVNHVXZWRrbE14MFcrNlBjNXRBdFYx?=
 =?utf-8?B?bStnVXgzNy9zQkNiVW9iNjlteGk5RmJMZnlzZXd0Z2kwNmVBQ2pTYXY0b05V?=
 =?utf-8?B?eHhnZzZjaUt4em8vU202QWNrYWo0SFg1K092L3V0U3NjWHRkOU5yNG5zWkt2?=
 =?utf-8?B?OHRnTThtcnZEVW1xYmU4S01YUTFuVDFQRU9qY2tnWlNnYjliTlBxSXRCN0sr?=
 =?utf-8?B?U1h3bEhnY0JscXVhZ2FFazNjN2ErNk42bWhZUzJFUXRXc0kwbHJ6eEdqcFFi?=
 =?utf-8?B?N01oR1R6aEsvVDc3cFVCYXF6elN2cnpnV3ViZlF3eG1UT0NKTFZBdkJZQkZu?=
 =?utf-8?B?eTQyYW9BV0FhTk1qME1vTWxTNUNWZTFkbXZsd0dFS01ITFhEMS9qcFZNbjE4?=
 =?utf-8?B?cFZKMzg3aFQvVVh0R2dmYU04ZU1oT1p6emJnZzk3YmFqeG9HZ1J6Uk10R0xz?=
 =?utf-8?B?MERHNjhZdmQ5NkJNVGxwVzZ4YWQ2NUYvSG1xUW9SSGk2OWMwQi9oM3JKaEVK?=
 =?utf-8?B?T2daWjFuQUNEL09WV00vakNLdzcvRUlOZjJEaVNzb01sWVgvRzVoRERXWDBy?=
 =?utf-8?B?NWM3MGRWWEhkR1ozNlpQRWxjT09ubkwzbDJVY09vdWdZN3cra1I2RjJRMURi?=
 =?utf-8?B?cWtOTEVpeHVsL29abXg5UVNSdkJLRjFkc3ZaanVTbGIvYU1sWFluWDNIS1Vt?=
 =?utf-8?B?TldiZUxGZmJFRkYwMHpnUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U2htREMybWhDay80Q0NzQVFxcThnSnIzcVF3Yk1aOVJXTHB0WnJiNTRnYnJO?=
 =?utf-8?B?bUhBaTV1SmFhV0JRZU1ya0NrY1A0VUh5dExZdU1HUEFyU21FOUkrSVNzVUR1?=
 =?utf-8?B?SVFnTGF4Sm83VVZ2UUJYTFgzRXVjMFV4ay9QZUk3MERJUVFjajMwRWpCUjVB?=
 =?utf-8?B?SnFsbWFNSjRRdGpOb0s2V3V1L1JBK1E3RWRNWUVPMzA0eVJ1Vk5WazlscnFS?=
 =?utf-8?B?Y1A4cFcwbE1aTTZIbWlMRVp4bmtkNHpxdkZXVjkxNUFZQ0UvZnFjU1NpTi9q?=
 =?utf-8?B?MktyMDBzV1BkeFlXM05JdFBDcDM5cjFMM09kTllsRWZweGpiRkxXV1V5Rjcz?=
 =?utf-8?B?S3hGQUkzYmY2MTZ2L2FadFA1RVRSSFQwYlhuRGZuWWIycTRiVUhmaW1jZWlG?=
 =?utf-8?B?NEpqQ3VtbExkdkk1aFhUbFNrUmVOdmRFZEdaRFZUZVdzNi80ZDN0YjhqUHFZ?=
 =?utf-8?B?Tm5XUEg2ZndIZnVJTlAvOHdFYlBqVHpOQzl4TUJMNXRxeEc5NVNkVFRzTlpj?=
 =?utf-8?B?OVc5Z29GRURSMEhma0JwY3JYNktVdjZIS29Gd2VBOHNzQXVvQUttMTVCWmpZ?=
 =?utf-8?B?elF1M3FIZDFXQTdpSlFud2NEMS9mM2JIMDA1NEhHS21wOEswbzhwQVhYQVQ5?=
 =?utf-8?B?eXVlSzdtYUlzZkxiWVFzUWo5UUFQcjFwanBoUjNUKzdqQlJCVjNEb1pyLzlk?=
 =?utf-8?B?aW9pQzZWcUFrd0ZKREdrZzdyUE5Oc2o2MC8vRTlZRVJ6VTlIcjFBM0VnZUli?=
 =?utf-8?B?RFUrQTdCYW5IenlNUG80cnhJUkxuejBLOVdzR1llQ2V6RWNvUFlLOVZMVVo2?=
 =?utf-8?B?SVMyaUZYd01yWjhFd2FpeXV5OG8zV0k0SFJWZ2JoTjBuUmdKcE12K1lkTGhE?=
 =?utf-8?B?bEd2SW95dzk4VXBmaWxHKytHSndBK3hrVHl5dERXRlU1TTVzSWNmbGZ3SjZX?=
 =?utf-8?B?Q0NuRjJnRmJYVTlLTGtuODVFMmFNaGZ6bVYvSmJFMGkwWmFTcDhJbEZiWjlw?=
 =?utf-8?B?NGNaTjE2cFduS1VHNUN2NXk0ZmNNVnllZUt5a3pCaFhYODAvcHlzK3E0cVRF?=
 =?utf-8?B?Y3N6SDhsL0wvVDBKY0dXN3N2aXlzQWN1b2VHT2MxL29QWXJtSEpOczdIZHk5?=
 =?utf-8?B?VUVJVTZSbHZQMDMvbVlMLzZkK3JRV1E3bVcxSWhaQVY3RWtDc04zRVRudEFk?=
 =?utf-8?B?NEd6eGZCK0FmaXBTejlEZ3VMb01PZUFnWEtPZmV3eTMvc0Mrc0RQNzBhMUM5?=
 =?utf-8?B?NnlrZWJXdG1TQXpDTDQzbUpySHhlV254TTkvNExpTmRGREd0VGkzQ3o0UGds?=
 =?utf-8?B?dDljdGpDaW42RlI5QUxxUDdDZmVnSGZkY0hmbjI1MDB6UitlT3YrYlhTTlov?=
 =?utf-8?B?TEdxVVN3U3BPM3k5Qk90NUxSYnlOZmUrN1hSck8yRm9mQk1hWER2YTFDeXUr?=
 =?utf-8?B?Vm1mckJyOTB6clZFaVczdXF1UFpUK3M5MC9RVFp0bDFqbmwyejZoSTVmMXZN?=
 =?utf-8?B?THJhUWdwRUZDWndJZmNnVVJCZGJ4OUVLZ08rWER1Nkg3K25WYmJqbnpJSVlx?=
 =?utf-8?B?QXYzNTFRVzF1ekJvT082RzUrcDd6T0llaTl0Nm1HT0pDTFZsV2E2dzVRWE1Y?=
 =?utf-8?B?bVNwd0pRNnQ2c0dBUnA5WDBVaG1QR0JRUUtZeVJLMEd0cm4rL0Z3aFRyUzh5?=
 =?utf-8?B?MHZtcDhyakFMSGdGS2NYQnBzaGd1eEdGZ1FuM3FYYTRuQ0ZOWEEwaTVNeVVC?=
 =?utf-8?B?VmhnVUo2WHpiRkh3MFpTOGhyVkErMHZ2WEI3TmJ2YUlQM2U1M1kyeEtWTmts?=
 =?utf-8?B?VVdNVE5aVGdpRUZJVmtLeWNQeEk5QjQwOVhLbE1Za1NNVVMxdTRFZ3JNbHdh?=
 =?utf-8?B?SkpjbldMQ0l4N0VGdndVM0pUUTQxeVI2T05NVjZsSFNHRjJ0SmpPOXovMEpq?=
 =?utf-8?B?RFJBNjRJT1RZaGhtL0twM2xmSVdpVElXcFdycGRtemZKbStmOVZYeXY4SnNG?=
 =?utf-8?B?YUttUnduRDk5Tlc3dkoyc2ZKV2N1Vlk5UGV5TjYxRlJkZ1U0UWVyQmRCOXlF?=
 =?utf-8?B?bTY2c1BhQkFVaXM1d3NkWGJ1MFNOcDNRVTB6UUdJNDNiWW9zMW9ZbDAzY25h?=
 =?utf-8?Q?Vxtz6+rZhzXHWY0zAxITjFMhZ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1589D0679B5A7748979ACAFF23279EA9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	u3TLHqjZ31ABOCBDmv29wp4DZmgxErn+zLZfyaKRtrQD/IYZm87lt/YmR3M6qEsfntsms4N1DvcD5nCa8pvvtJDrjENO5OYDf9lWQ0Nek+jUgaAzwyPwc+OiIu88hk3gqc0Yw5L87V159jSbIkuHhmSHBCapNWuqh7DSuhJDsKq5U7ckCROu8qX7f/410oc8drPbL/sWoEkC+YKPUKdJjzwkaAQyyl8Euw0e2wg7W3j01NuJYWIL9l3UD+Y/bLfNCzH5n+tYLtbDGiGWSGl8DWARd4AUFC7O+H3SuR5WPGd8RKiEjNekL1/065IkNXJZUilThSnOMuZGM5qPSsj8YZpsUChj+F6yyP0CKat+3QHMpxFne/yox6ikkTtlQQQgX/DM1LBKJ6GQlFUMrVUF0MMHgZqWB8sPVc6SGd8pGaArq7M+vAaQHcRnE1aS896QRSf8HQZVK55ZyLxE3LooMEwKXErz7bV+j4kIbEASdLgvp+f5cShEqzT8BgMt7roQENgY4Win208t1TvTBEhOAJgj9aP3Ys58ZelR8kY9tZLfjFIDHmlQuGceKkCYCBsKN80VyAMRvIQeGP6o463U9HMx0vyqaStNF84PvexioEMkQRKkjJXkGFpf30oYzR5D18WrWcU6+zqA+i3DXhYtPw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d670f1d-2094-4d85-bc32-08dcde78e895
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2024 22:16:45.9288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LmUtHM4/LkNSyXEiSHruz0BB7EW1ivjoa19OMbnyQcDSTQf19D4GwKe9tJHGrwM16HLDetTbz+5i+6csV2YKvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8902
X-Authority-Analysis: v=2.4 cv=Iu1Mc6/g c=1 sm=1 tr=0 ts=66f5dd5d cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=nEwiWwFL_bsA:10
 a=qPHU084jO2kA:10 a=COk6AnOGAAAA:8 a=45lTmBTIVTrEnNeiSFQA:9 a=QEXdDO2ut3YA:10 a=B6lABiJV8OHBjonkmFML:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 6tpncGqY8MVwGXz4TNgfVKqDJdHfa9Pq
X-Proofpoint-GUID: 6tpncGqY8MVwGXz4TNgfVKqDJdHfa9Pq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 malwarescore=0 clxscore=1015 suspectscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 adultscore=0 mlxscore=0
 mlxlogscore=999 impostorscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409260155

SGkgQWthc2gsDQoNClNvcnJ5IGZvciB0aGUgZGVsYXkgcmVzcG9uc2UuDQoNCk9uIFdlZCwgU2Vw
IDE4LCAyMDI0LCBBS0FTSCBLVU1BUiB3cm90ZToNCj4gSGkgVGhpbmgsDQo+IA0KPiBPbiA5LzE4
LzIwMjQgNDoxMCBBTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+IE9uIFR1ZSwgU2VwIDE3LCAy
MDI0LCBBa2FzaCBLdW1hciB3cm90ZToNCj4gPiA+IFRoZSBjdXJyZW50IGxvZ2ljIGlzIHJpZ2lk
LCBzZXR0aW5nIG51bV9maWZvcyB0byBmaXhlZCB2YWx1ZXM6DQo+ID4gPiANCj4gPiA+IDMgZm9y
IGFueSBtYXhidXJzdCBncmVhdGVyIHRoYW4gMS4NCj4gPiA+IHR4X2ZpZm9fcmVzaXplX21heF9u
dW0gZm9yIG1heGJ1cnN0IGdyZWF0ZXIgdGhhbiA2Lg0KPiA+ID4gQWRkaXRpb25hbGx5LCBpdCBk
aWQgbm90IGRpZmZlcmVudGlhdGUgbXVjaCBiZXR3ZWVuIGJ1bGsgYW5kDQo+ID4gPiBpc29jaHJv
bm91cyB0cmFuc2ZlcnMsIGFwcGx5aW5nIHNpbWlsYXIgbG9naWMgdG8gYm90aC4NCj4gPiA+IA0K
PiA+ID4gVGhlIG5ldyBsb2dpYyBpcyBtb3JlIGR5bmFtaWMgYW5kIHRhaWxvcmVkIHRvIHRoZSBz
cGVjaWZpYyBuZWVkcyBvZg0KPiA+ID4gYnVsayBhbmQgaXNvY2hyb25vdXMgdHJhbnNmZXJzOg0K
PiA+ID4gDQo+ID4gPiBCdWxrIFRyYW5zZmVyczogRW5zdXJlcyB0aGF0IG51bV9maWZvcyBpcyBv
cHRpbWl6ZWQgYnkgY29uc2lkZXJpbmcNCj4gPiA+IGJvdGggdGhlIG1heGJ1cnN0IHZhbHVlIGFu
ZCB0aGUgbWF4aW11bSBhbGxvd2VkIG51bWJlciBvZiBGSUZPcw0KPiA+ID4gYmFzZWQgb24gdGhl
IERUIHByb3BlcnR5IHR4X2ZpZm9fcmVzaXplX21heF9udW0gYW5kIHRoZSBtYXhpbXVtDQo+ID4g
PiBwYWNrZXQgbXVsdGlwbGllciBmb3IgSFMuDQo+ID4gPiANCj4gPiA+IElzb2Nocm9ub3VzIFRy
YW5zZmVyczogRW5zdXJlcyB0aGF0IG51bV9maWZvcyBpcyBzdWZmaWNpZW50IGJ5DQo+ID4gPiBj
b25zaWRlcmluZyB0aGUgbWF4aW11bSBwYWNrZXQgbXVsdGlwbGllciBmb3IgSFMgYW5kIG1heGJ1
cnN0IGZvciBTUywNCj4gPiA+IGFsb25nIHdpdGggYSBjb25zdHJhaW50IHdpdGggdGhlIERUIHBy
b3BlcnR5IHR4X2ZpZm9fcmVzaXplX21heF9udW0uDQo+ID4gPiANCj4gPiA+IFRoaXMgY2hhbmdl
IGFpbXMgdG8gb3B0aW1pemUgdGhlIGFsbG9jYXRpb24gb2YgVHggRklGT3MgZm9yIGJvdGggYnVs
aw0KPiA+ID4gYW5kIGlzb2Nocm9ub3VzIGVuZHBvaW50cywgcG90ZW50aWFsbHkgaW1wcm92aW5n
IGRhdGEgdHJhbnNmZXINCj4gPiA+IGVmZmljaWVuY3kgYW5kIG92ZXJhbGwgcGVyZm9ybWFuY2Uu
IEl0IGFsc28gZW5oYW5jZXMgc3VwcG9ydCBmb3IgYWxsDQo+ID4gPiB1c2UgY2FzZXMsIHdoaWNo
IGNhbiBiZSB0d2Vha2VkIHdpdGggRFQgcGFyYW1ldGVycyBhbmQgdGhlDQo+ID4gWW91IHNob3Vs
ZCBjbGFyaWZ5IHRoYXQgdGhpcyBpcyBvbmx5IHZlcmlmaWVkIG9uIHlvdXIgc3BlY2lmaWMgcGxh
dGZvcm0NCj4gPiBhbmQgc3BlY2lmaWMgYXBwbGljYXRpb24uIEl0IG1heSBub3QgYmUgYXBwbGlj
YWJsZSB0byBhbGwgY2FzZXMuDQo+ID4gSG93ZXZlciwgd2UgdHJ5IG91ciBiZXN0IHRvIG1ha2Ug
aXQgc28uIFBsZWFzZSByZXdvcmQgYXMgc3VjaC4gVGhlDQo+ID4gY29tbWl0IG1lc3NhZ2UgbWFr
ZXMgaXQgc2VlbXMgdGhhdCB0aGlzIHdpbGwgd29yayBmb3IgYWxsIGNhc2VzLg0KPiBTdXJlIHdp
bGwgcmVwaHJhc2UgaXQsIGJ1dCBpIGJlbGlldmUgc2luY2UgaXQgY2FuIGJlIGN1c3RvbWl6ZWQg
YmFzZWQgb24NCj4gbWF4cGFja2V0IGFuZA0KPiBtYXhidXJzdCAsIGFueW9uZSBjYW4gY2hvb3Nl
IGhpcyBkZXNpcmVkIGZpZm8gc2l6ZSBhbmQgc2luY2Ugd2Ugd2lsbCBiZSBnZXQNCg0KVGhlIGxv
Z2ljIGRlcGVuZHMgb24gd2hhdCB0aGUgZW5kcG9pbnQncyBzZXR0aW5nIHdpbGwgYmUuIFRoZSBl
bmRwb2ludA0Kc2V0dGluZyBpcyBub3Qgc29tZSBydW50aW1lIGZpZWxkIHRoYXQgdGhlIHVzZXIg
Y2FuIHNldC4gVGhlIHBvaW50IEkNCndhbnQgdG8gbWFrZSBpcyB0aGF0IHRoaXMgaXMgdmFsaWRh
dGVkIG9uIHlvdXIgcGxhdGZvcm0sIGJ1dCBpdCBtYXkgbm90DQp3b3JrIGZvciBhbGwgY2FzZXMu
IChlLmcuIHRoaXMgbWF5IHVzZSB1cCBtb3JlIGF2YWlsYWJsZSB0eGZpZm8gZm9yDQpvdGhlciBl
bmRwb2ludHMgb24gYSBtb3JlIGZpZm8gY29uc3RyYWludCBwbGF0Zm9ybSkNCg0KPiBtYXhwIGFz
IDEgKGZvciBhbnkgc3RyZWFtaW5nIHBhY2tldCA8IDIwNDgpwqAgYW5kIGFkZGl0aW9uYWwgKzEg
d2hpY2ggd2UgYXJlDQo+IGFwcGVuZGluZyB3aGljaA0KPiBtYWtlcyBtaW5pbXVtIDJrIGZpZm8g
c2l6ZSBmb3IgSFMgd2hpY2ggc2hvdWxkIGJlwqAgc3VmZmljaWVudCBmb3IgSFMNCj4gdHJhbnNm
ZXJzIGFuZCBpdCBjYW4gaW5jcmVhc2VkIHdpdGggbWF4cGFja2V0IHdoZW4gaW5jcmVhc2VkIHRv
IDJrIG9yIDNrLg0KPiBTaW1pbGFyIHdpdGjCoCBtYXhidXJzdCBmb3IgPj0gU1MuDQoNCj4gPiAN
Cj4gPiA+IGVuZHBvaW504oCZcyBtYXhidXJzdCBhbmQgbWF4cGFja2V0DQo+ID4gPiANCj4gPiA+
IFNpZ25lZC1vZmYtYnk6IEFrYXNoIEt1bWFyIDxxdWljX2FrYWt1bUBxdWljaW5jLmNvbT4NCj4g
PiA+IC0tLQ0KPiA+ID4gICBDaGFuZ2VzIGZvciB2MzoNCj4gPiA+ICAgUmVkZWZpbmUgbG9naWMg
Zm9yIHJlc2l6aW5nIHR4IGZpZm9zLGFkZGVkIGNoZWNrIGJhc2VkIG9uDQo+ID4gPiAgIG9wZXJh
dGluZyBzcGVlZCBhbmQgdXNlZCBtYXhwIGZvciBIUyBhbmQgbWF4YnVyc3QgZm9yIFNTDQo+ID4g
PiAgIGFuZCBkZWZpbmVkIG1heCBhbGxvY2F0aW9uIGJhc2VkIG9uIGR0IHByb3BlcnR5Lg0KPiA+
ID4gDQo+ID4gPiAgIENoYW5nZXMgZm9yIHYyOg0KPiA+ID4gICBSZWRlZmluZSBsb2dpYyBmb3Ig
cmVzaXppbmcgdHggZmlmb3MsIGhhbmRsZWQgZmlmbyBiYXNlZCBvbg0KPiA+ID4gICBtaW5pbXVt
IG9mIG1heHAgYW5kIG1heGJ1cnRzLg0KPiA+ID4gDQo+ID4gPiAgIENoYW5nZXMgZm9yIHYxOg0K
PiA+ID4gICBBZGRlZCBhZGRpdGlvbmFsIGNvbmRpdGlvbiB0byBhbGxvY2F0ZSB0eCBmaWZvIGZv
ciBocyBpc29jDQo+ID4gPiAgIGVwcywga2VlcGluZyB0aGUgb3RoZXIgcmVzaXplIGxvZ2ljIHNh
bWUuDQo+ID4gPiAtLS0NCj4gPiA+ICAgZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyB8IDE4ICsr
KysrKysrKysrLS0tLS0tLQ0KPiA+ID4gICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygr
KSwgNyBkZWxldGlvbnMoLSkNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNi
L2R3YzMvZ2FkZ2V0LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ID4gPiBpbmRleCA4
OWZjNjkwZmRmMzQuLjc1NTdiZDAwNTNhNyAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvdXNi
L2R3YzMvZ2FkZ2V0LmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4g
PiA+IEBAIC03NzgsMTUgKzc3OCwxOSBAQCBzdGF0aWMgaW50IGR3YzNfZ2FkZ2V0X3Jlc2l6ZV90
eF9maWZvcyhzdHJ1Y3QgZHdjM19lcCAqZGVwKQ0KPiA+ID4gICAJcmFtMV9kZXB0aCA9IERXQzNf
UkFNMV9ERVBUSChkd2MtPmh3cGFyYW1zLmh3cGFyYW1zNyk7DQo+ID4gPiAtCWlmICgoZGVwLT5l
bmRwb2ludC5tYXhidXJzdCA+IDEgJiYNCj4gPiA+IC0JICAgICB1c2JfZW5kcG9pbnRfeGZlcl9i
dWxrKGRlcC0+ZW5kcG9pbnQuZGVzYykpIHx8DQo+ID4gPiAtCSAgICB1c2JfZW5kcG9pbnRfeGZl
cl9pc29jKGRlcC0+ZW5kcG9pbnQuZGVzYykpDQo+ID4gPiAtCQludW1fZmlmb3MgPSAzOw0KPiA+
ID4gKwlpZiAoZHdjLT5nYWRnZXQtPnNwZWVkIDw9IFVTQl9TUEVFRF9ISUdIICYmDQo+ID4gPiAr
CSAgICAodXNiX2VuZHBvaW50X3hmZXJfYnVsayhkZXAtPmVuZHBvaW50LmRlc2MpIHx8DQo+ID4g
PiArCSAgICAgdXNiX2VuZHBvaW50X3hmZXJfaXNvYyhkZXAtPmVuZHBvaW50LmRlc2MpKSkNCj4g
PiA+ICsJCW51bV9maWZvcyA9IG1pbl90KHVuc2lnbmVkIGludCwNCj4gPiA+ICsJCQkJICB1c2Jf
ZW5kcG9pbnRfbWF4cF9tdWx0KGRlcC0+ZW5kcG9pbnQuZGVzYykgKyAxLA0KPiA+IFRoaXMgbG9n
aWMgbG9va3Mgd3JvbmcuIFRoaXMgaW1wbGllcyBtYXhwX211bHQgaXMgYXBwbGljYWJsZSB0byBi
dWxrIGFuZA0KPiA+IHRoYXQgaXQncyBhbHNvIGFwcGxpY2FibGUgdG8gc3BlZWQgYmVsb3cgaGln
aHNwZWVkLCB3aGljaCBpdCBpc24ndC4NCj4gVGhpcyBpcyB0byBtYWtlIGl0IGdlbmVyaWMgYXMg
MmsgZmlmbyBzaG91bGQgYmUgc3VmZmllY2llbnQgZm9yIGJ1bGsgZXBzIGluDQo+IEhTIGFzIGV4
cGxhaW5lZCBhYm92ZQ0KPiBhbmQgd2UgY2FuIGluY3JlYXNlIG1heHBhY2tldCBzaXplIHdoZW4g
cmVxdWlyZWQgd2hpY2ggd2lsbCBpbmNyZXNzZSBmaWZvDQo+IHNpemUgYXMgd2VsbC4NCg0KSSB0
aGluayB5b3UgbWlzc2VkIG15IHBvaW50IGhlcmUuIFRoZSBtYXhwX211bHQgc2hvdWxkIG9ubHkg
YmUgY2hlY2tlZA0KYWdhaW5zdCBpc29jIGFuZCBvbmx5IGZvciBoaWdoc3BlZWQuIFBsZWFzZSBz
cGxpdCBpdCBvdXQuIE1ha2UgaXQgY2xlYXINCnRoYXQgdGhlIGJ1bGsgdXNlcyAyayB0eGZpZm8g
Zm9yIGhpZ2hzcGVlZCBhbmQgYmVsb3cuDQoNCj4gPiANCj4gPiA+ICsJCQkJICBkd2MtPnR4X2Zp
Zm9fcmVzaXplX21heF9udW0pOw0KPiA+ID4gLQlpZiAoZGVwLT5lbmRwb2ludC5tYXhidXJzdCA+
IDYgJiYNCj4gPiA+ICsJaWYgKGR3Yy0+Z2FkZ2V0LT5zcGVlZCA+IFVTQl9TUEVFRF9ISUdIICYm
DQo+ID4gPiAgIAkgICAgKHVzYl9lbmRwb2ludF94ZmVyX2J1bGsoZGVwLT5lbmRwb2ludC5kZXNj
KSB8fA0KPiA+ID4gLQkgICAgIHVzYl9lbmRwb2ludF94ZmVyX2lzb2MoZGVwLT5lbmRwb2ludC5k
ZXNjKSkgJiYgRFdDM19JUF9JUyhEV0MzMSkpDQo+ID4gPiAtCQludW1fZmlmb3MgPSBkd2MtPnR4
X2ZpZm9fcmVzaXplX21heF9udW07DQo+ID4gPiArCSAgICAgdXNiX2VuZHBvaW50X3hmZXJfaXNv
YyhkZXAtPmVuZHBvaW50LmRlc2MpKSkNCj4gPiA+ICsJCW51bV9maWZvcyA9IG1pbl90KHVuc2ln
bmVkIGludCwNCj4gPiA+ICsJCQkJICBkZXAtPmVuZHBvaW50Lm1heGJ1cnN0LA0KPiA+IG1heGJ1
cnN0IGNhbiBiZSAwIHJpZ2h0Pw0KPiBBdCBjb21wb3NpdGUgbGF5ZXIgd2UgYXJlIGluY3JlbWVu
dGluZyBtYXhidXJzdCBieSAxIHNvIHdoaWxlIGFsbG9jYXRpbmcNCj4gZmlmbyBtYXhidXJzdCBj
YW4gYmUgYXMgbWluaW11bSBhcyAxLA0KPiB3aGljaCBpcyByZXF1aXJlZCBhbmQgY2FuIGJlIGNo
YW5nZWQgYW55dGltZSB3aXRoIGV4cG9zZWQgY29uZmlnZnMNCj4gYXR0cmlidXRlLg0KDQpPay4N
Cg0KPiA+IA0KPiA+ID4gKwkJCQkgIGR3Yy0+dHhfZmlmb19yZXNpemVfbWF4X251bSk7DQo+ID4g
PiAgIAkvKiBGSUZPIHNpemUgZm9yIGEgc2luZ2xlIGJ1ZmZlciAqLw0KPiA+ID4gICAJZmlmbyA9
IGR3YzNfZ2FkZ2V0X2NhbGNfdHhfZmlmb19zaXplKGR3YywgMSk7DQo+ID4gPiAtLSANCj4gPiA+
IDIuMTcuMQ0KDQpUaGFua3MsDQpUaGluaA==

