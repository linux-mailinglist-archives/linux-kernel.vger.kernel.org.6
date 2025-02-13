Return-Path: <linux-kernel+bounces-512128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A859A3347C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 02:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 798773A7ED0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 01:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630618635C;
	Thu, 13 Feb 2025 01:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="DSAlHCus";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="idTXBESK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="emj0lGA9"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BCD4A29;
	Thu, 13 Feb 2025 01:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739409404; cv=fail; b=iOYqwRzhaLAMoMGHPOX44PsvmfJUtjmEvpDhFqm4AvkYuCRQgLFfthDpU0RkkuGezOwV/WJLfoMuByVI8w/0e3TzpYwtqfDdZjaZhMiK29h061tpydarlFv/lkhNDdsuOE7vXKOS9H6HLH+r0VkdkZebh1GWn+wPKUJWOBngUFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739409404; c=relaxed/simple;
	bh=94xK+wBulIuG1nHvBcwf8cxb0zQqnXsWg6LX0iy1mNw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TUTIIa8dqQRl4DZdQewf66W2RhOEesFMAsFclsb+NNJG9gKkRfZNVDnyQvATHUGH43FuhOkpQuTtAlxzObF5gp5UMy6xeQH/q6yMvaepgsJims7WIDLi5TZykJX6MQ5HBbv6FyJvy4n5hQaDm2z/MJ3jIF7cDwuPemz387gr/yU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=DSAlHCus; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=idTXBESK; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=emj0lGA9 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CLgsDC016940;
	Wed, 12 Feb 2025 17:16:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=94xK+wBulIuG1nHvBcwf8cxb0zQqnXsWg6LX0iy1mNw=; b=
	DSAlHCusrQjWtxNuI0xY8NN5XrLxnr7SwsnvYsDgyN9BmcdCW0bqCwVMo8mSR6iS
	4TfT/Q62YFjxzO3rTf+s2B9UAy4+tbvojZTsAJR2sBxi3d9btP/WXniHQp7ubgJp
	+x2XbIq99C3TiQhdTf6XhrllA0MYcEWo5tN4D67KgtZY4VXBgiKHsEv4I1YulTS6
	fp+GvmBWhZWieWjUsHg1LNI/P47L6fxZbmnr/gdXPZ7gsJwtVD1RXGHaA1RvFagO
	4MhWJP+wgCbKTGmh9ippLRnSmFuolADkPYhOopRGQdrjNH+LC5GSdhkuENccjaaw
	A9nje4W+RKHekQoLEbMewQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 44rq99nbnc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 17:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1739409382; bh=94xK+wBulIuG1nHvBcwf8cxb0zQqnXsWg6LX0iy1mNw=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=idTXBESKucwtXRpaicmiutN+TEY53ZTlv1hkefuzgeEHmdNXbB6A9fXLUOQvVhc5d
	 KdZbaOPuOFukM4IV3hsXIaxwRmQ+R+Rtp8Anf25rslz/C46b47C4Grk1GN9JLPZBfE
	 pgOdtHVso9hEuZk0P5lG/wVS8B/ZcF75TcvejrK5G5dd7C6zXxXAyOWwpPJ+3eKXWn
	 B+PqdW/E1MFtC9+h5NBySjl9kbjp1znzkfpFYvTv3dI58pnXT1aV0O57GHcTRsEt29
	 N/j0p+5Ig6GqY7gUz4A9GUsHcx9sSktDSj7n1TBB0tP7vmqbh7XH/PEKRZyRkXTJ8R
	 eyi2a8Tenb0uQ==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 4BC0E40175;
	Thu, 13 Feb 2025 01:16:21 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id BC7C1A005C;
	Thu, 13 Feb 2025 01:16:20 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=emj0lGA9;
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id D83B3401E3;
	Thu, 13 Feb 2025 01:16:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T6zcfDUFRtabRC5DB+OZVmTNjRbeN/TvFvSZNm5BYn7RTuEEd5CSbcXLHL+grbf3k4zfbSknE9VB/08Ikt7MoVZci4vamOSFzfDWcMhugQcV3OgwAZRUaIZYJ+PDaodxHn44BNr8guoyTgtu3yQoEYvZhC4MbVo7Dki8mB7gNJFB6S64Xe9W8zOu3nOp9PoJOmTkA7fZzxw5kvE7Hys3Hes1OVyoZ1Ex0Lj/9QqGaSjeirNS8lzxxXy3c8qsW7Sl8Oqz3tEX0hQAT0PMR978+Ef+d871dLvKu3XHNUK2hY1j5WilY/eKy7RYHAZmCbyuxCAXNxQnmjffpoxvTO4kVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94xK+wBulIuG1nHvBcwf8cxb0zQqnXsWg6LX0iy1mNw=;
 b=ke8Td96/AiK2MvCLeKd61bgt7l60WZwLUq/gAYn2lUMhP7Z8emKEXNlc7mArz0tflNz7XaNhsnqf+1VDFf4Wrb9FMC1f6QX9X7OxJVjjyvEbcBRE8iriw8T4i+gNLayJBEeJL8zuuWyKPUHr5oYqyGD12LpaAJIXFcABKm8fBI0JW0nqmu3tOxj0INVW5XbcKQOcl4hREw1z5WZBT2Dp9rS+R00xzM3wQY4PRowIjcXnR+YLCoQvfbgJJWZK/mlRzYnM2/AG+on6Uz9Uz9tObW7ximtwunvC4u2mhGYPb2pE/ulrY6Rhy87UW31TGpRzjuYPyddGZIct0hph35cV0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94xK+wBulIuG1nHvBcwf8cxb0zQqnXsWg6LX0iy1mNw=;
 b=emj0lGA9NQELtHXfQtMKlvRqkI+h7YuUaF+BHAlQZPZFt1m3tlKz1B5ZGOdefqEXypT3uagvTHg9HBuFZqNCWN9FNsKOsrB1vYEDW+6UFSZwkIlwTNtFCJtCFMUG0MQV13Ms2WAV05Xng9TTdaMN7tLixTfw/SlzgrNalZM5JBg=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CH3PR12MB8402.namprd12.prod.outlook.com (2603:10b6:610:132::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Thu, 13 Feb
 2025 01:16:16 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 01:16:15 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ferry Toth <fntoth@gmail.com>
Subject: Re: [PATCH v2 2/3] usb: dwc3: gadget: Add support for
 snps,reserved-endpoints property
Thread-Topic: [PATCH v2 2/3] usb: dwc3: gadget: Add support for
 snps,reserved-endpoints property
Thread-Index: AQHbdnAAit2sY24YUU+11LLZH+RUWrNC6NyAgACeGQCAAPXlAA==
Date: Thu, 13 Feb 2025 01:16:15 +0000
Message-ID: <20250213011610.ov3q2rq6bfzdzqlk@synopsys.com>
References: <20250203191524.3730346-1-andriy.shevchenko@linux.intel.com>
 <20250203191524.3730346-3-andriy.shevchenko@linux.intel.com>
 <20250212011013.xumqgguhluxdslpz@synopsys.com>
 <Z6x5lB4hGpz-9IzS@smile.fi.intel.com>
In-Reply-To: <Z6x5lB4hGpz-9IzS@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CH3PR12MB8402:EE_
x-ms-office365-filtering-correlation-id: f3445b0f-f23b-4f93-843d-08dd4bcc0310
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bG1lUlphU3dQZDBBUkNYK3FSU0JyOXFmWWo5SytuZW9KVThnU3NrVDQ5VVRv?=
 =?utf-8?B?aUtSbmYwUk9QZUZLbTBUQXpmTXNwVWxqSHkzL1o5YjFwZUZWNzJnVUpEYWd4?=
 =?utf-8?B?eEk2SnJhbUZRNGtTU0RlaDZFZUU5M3g4TjBkNnMxaWg2dG1kNzFOUS91SGZa?=
 =?utf-8?B?UWoreUpaOHFPZ2dDYmNoazNVQ3RZUWdFMDhNdnJ5NzNta1MxLyt1cWhvaVZs?=
 =?utf-8?B?TzNhaWdzdEZBb1dxcENkekhrZnVSdW5uaXhKTThUOC9XejJ2WmNMdm9HSjdU?=
 =?utf-8?B?dzJMNVNyd2NjaTV5dS9YM202MEJ0Z2RsRURSTTREOGd4bHNNQTZ1MmhNMDMw?=
 =?utf-8?B?aGhIQnZRNERJQ1dEVFMvbWtuSjNDQWU0TkRmWUpEUTdCUG9weVk0RTZOZWtr?=
 =?utf-8?B?WG8yc1I3K21vT0hpblAwMUM2N3hKcVdFdDNCeW9MdW02Y2xuY1N4ckRRZDA3?=
 =?utf-8?B?UU9TR1A1cnVNcjV4MzJZbXBYN0tIRkl5aDdYNTNmZ2tCbGVOQ0lGYmRVUi9H?=
 =?utf-8?B?Q0F1dzI0OURBOW1mUUJwRlFKUEJUYXRVQ0g1K1JoWWtvcGVnOEh1WS9rM3Ro?=
 =?utf-8?B?OEhYc1lpUXcxR2MrNWpsWFpaWjRteEprNUFPVTFXbnJ2UURKbnJRdEFyRGM1?=
 =?utf-8?B?bWhSSEM1UWR0bkF1UTZIalJvRUtLOEJRYy9mcURSbnlWZXpjWk14dE1sTWNC?=
 =?utf-8?B?Mi9JQS9oMmxBNG92WENzbXp5U3VHd0FuSmZmbko1Znl6WFhUQjE1UTZPYUdZ?=
 =?utf-8?B?anRTVlBPb1UrVVFUZ2I0M3dCSjdaRmpxSWY5aXdkNXJjQVA1eDBXbHEyYnNU?=
 =?utf-8?B?S1RkOXZkcWRPcWg2Z1RKNldZRXpwZEdjU2NSYmpyVldmeEplOEx1WjJ1aDJk?=
 =?utf-8?B?SlhLV05wVHhVM1dVVXpNOExtejdDeHpVczBZNkM0cjc1MW5SdkJaNWd4dFM2?=
 =?utf-8?B?cnVQdXRvQjFSaXZud3FDSkhpc3pyZk55c3ZGbTJBZjRBU0pJTVZMU2ZHSnBS?=
 =?utf-8?B?aUxBbEpEOXJwSDJNVE8wcnFLLzZyeFRqVXd6NXF3c2ZtMkdVQnlDLzRudlli?=
 =?utf-8?B?elFYZFpPem85c1U3Yy9UM2hHcUlXTHdQaHRyQVY0ODNodkVtUmxETXpEWVhN?=
 =?utf-8?B?VzVhT3F5dE9qbzQxVEo2MXd5ckNMSlJCUzlhVUlEVXo5ell0SElzVFlKelFk?=
 =?utf-8?B?MFhUelA0WGVSNFlLeE1LdnI0bGtqNWl3OGQzY3ZXdkhWUDVCZDFvM0VTSUJB?=
 =?utf-8?B?U0x2VUUwQTZ3SkxsTkEyY045MG93b0RzVUhqZHlDRk1Wd1huVXRXWjBUTlV3?=
 =?utf-8?B?UHl6RTR2bHBwVDhYYnNjaU80blZ3V0FWd1NqbHRJeEpQMlVkZG5adnRqSTJN?=
 =?utf-8?B?M242YUh1OTZUeGplME5SRGFHZ1Z6SVJIelFjRUx4eE9OUC9nM09LK0VtaTM2?=
 =?utf-8?B?WnlqMVEzanhSb1Y5NEE3OERnd3pqaWM1Z2owV1VYbURadHp1NytWbmM4RFlk?=
 =?utf-8?B?Nnd4R0dCZ0pVYXVMNi84bjZDajErb1R6Vm5ZVWo3SHZoRmRRUUtZOHdSdUJJ?=
 =?utf-8?B?Y2pTU2c4L3ZUK2lqNy81aGQrcG5WZVd4MU1EZzlkeWhBNGZJV0RPN2w1RnU3?=
 =?utf-8?B?THBwTEF3NS8ydUdta1VrVU0rTkcvRlhTb2Y0c3lFTzYzK3FPQ2JJM2xkRU85?=
 =?utf-8?B?d3dVUHRKeDRFbUJjOVNndkJKNEdKNHllOFBCSVZqd0p3YS9yWkNaUjJ6UmdE?=
 =?utf-8?B?TlhQb2l1QmdWY1VIazJPYjJXKzNwaHRnQWhXZTlRb1NSVW9BWjhQZFhYS2dq?=
 =?utf-8?B?TkZIWkxrd0VPMXBEVy80RmZTYVlWMGJIM3hySm80dGRWQ3BlaFIwZURLM04r?=
 =?utf-8?B?N2JIczNXQ1g0ajkxN09UQ09oZEVybFMrT1FNNmpCTU1kY2pRRXM0NXJnemlt?=
 =?utf-8?Q?MpxYWYtW1t/MlZnP6lNzwskcI/Zbz0AY?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TTd0ZVIwQzJRclNRdGlKbVBCYWkzTFZnYWI3MDVuc2R2VWlieGo0YTdJMDVr?=
 =?utf-8?B?RTVzakx6c3NFc3hVdFR6a250K1FIVFB2ckdteG1tT2g4YWkvOVhqanVySUZz?=
 =?utf-8?B?TzcweUlXNVF0d3JSWmg3NytCTXBBcHNIK3pEeStUTFJyRC9PM1B2bDBYRDIv?=
 =?utf-8?B?c1NPZmhLT3pKNHJjVGE4R3UxdU9PREJCUFNxQk9iNXpWVVcyQk9EZ3BlRzFR?=
 =?utf-8?B?WXRhS0x5eGJzS1N6Rlg3NGJnSWtwUlE1OXRIdVY2ejNxY0dtY1RRVUFUelE3?=
 =?utf-8?B?c3V2UEIzdVp4YitDSXZsVEdLVGY3SnFENVdVMk1lUUVSVlJwT1BqSmFWSXpU?=
 =?utf-8?B?N3pKbmJUTWJBQ2o3a3F1a0pkUXQ0RzQ2dklsS3d4ZlhiNnVKNW9lS0lPWkxF?=
 =?utf-8?B?VXUxcnpsVXNrQmJYdHFSNUdFbVZ6RFE3YXpNUG82YllWcitPNnZ2ZkErUnY4?=
 =?utf-8?B?RWZGMFhnUzhXZVJCWEdyOG5mbTRRYkJRMXZ5aEp2KzY4UzhPV2RBdFJtZzNH?=
 =?utf-8?B?UU81bnNKZHlCWlZPNVF3N21xeEhaa3M5QW1idm4veWYxaXYrSGloOW94MnpM?=
 =?utf-8?B?SFZqNTM2MmVWaUYxdVpLTkswWHlpT3FxVFY4SEpzdG5NZHV6emltVFpXRFlG?=
 =?utf-8?B?RGV0Q0tmWGdrYS95b2pOcUI0RXFIUXh5ZmJ4RmY2NytHYnZTbEZjbGRES2Zi?=
 =?utf-8?B?d0xvSGV5SUlDTm9kME9adFdCUFM5ZVlPdXUxcEpNVUNpM28zS0pBWlRnbGl2?=
 =?utf-8?B?SFhoeDFsSEN1LzRMOThjTCtLUGlHc2l6eHFiZ2g1eGt4YjRvSm5BNkpWdEZj?=
 =?utf-8?B?SGg3MHdBZjRuRy9wZXdzSlNsU2MrdGsvZ2Q0Uk45YWJyWXB1dVdDdTJxdVV3?=
 =?utf-8?B?YXM1K2pmeTZZK0w0b0QwUnlWYzZ4eGliM29Xekp4Ym50L3QycGhKUHpyeHVz?=
 =?utf-8?B?Qk5MZWE2LzlvSVNJMW1VSVZvWldJVXl2MXNmdWR3Zlg1QnpNZDVsaU5MeStG?=
 =?utf-8?B?T2lKYkNTM0VUUWMwUDJNSHVQd1o2cm9hbnRkcC9YSVlvQXU4Mi9PY3dheU5G?=
 =?utf-8?B?cDlSa1cwZUhPbVJsdnpHSkltZjRGTGFIai9rREE2UXlYNTZHRlJvZHB4ME5n?=
 =?utf-8?B?ZFB3aSthZkd1Y2NHZ1NucHNGVnhmZXFhYnExTEdCWTg2YXAvV0pza3VubzVF?=
 =?utf-8?B?dlozYW5iNXdTRVkzVWl2b3M5V3BNQnJEWldQN1E3a25ETTN3Tmt2YU1FTEZy?=
 =?utf-8?B?RGtXNUxYRE1uV0tKNlM5ZUxaSERMenZ1Z2FxR1V0WGRUd0FMVXB6cjBuWXAx?=
 =?utf-8?B?cEhXVnpaMzl5UEdBRVc5QnpXcXZDMkhFY3hyc0tJZmVtNzFlOEtKV0VBVmY1?=
 =?utf-8?B?OWZIYXFUcE12M0s3Q2JQVnNKNUw4d1V1UWphNHRUT09oTHFSOFVKcldZdmVs?=
 =?utf-8?B?MnprNWQxWXRIN2preDQzWU9hZ1pVbmZjblYwSFpkWEZOT2hrQzhaT3F0UEcv?=
 =?utf-8?B?d09ndkt5d0FYbDErQUZ2czFMNUhtWis0cjV0cTF2ZFcrakpZV2lITnl5Z0Nw?=
 =?utf-8?B?UzkzbHo1Y3N1Zi9nZkNrNFo1ZDNxcWxSNTZvWVVZa2svNDhFSDNaVGdFdDhv?=
 =?utf-8?B?S012L3BMSE9qRFJBUlVvVmJNWFZUUXpraG1yUXJUa1ZjS1YzZGFQZnkwZjZI?=
 =?utf-8?B?MFIwcUhaeUpYQmNwN0xQb0JwREwzMHZQT1llSFc4RmVvSXQ0aVY5WWh2THp4?=
 =?utf-8?B?Z1dGb1R4L2hha2x3OG9FL2VDOG1WZHFXWUgrUDJKZ2x0MVRKOG5QZGc4Zjdm?=
 =?utf-8?B?dVVRNnpZanBZU2dRN1hWTm5ZbWo3ZDNZUzlBMFBiWXlCYU5TY2FGczFyNm0v?=
 =?utf-8?B?eFBWQ2FzZ2tUSExSaGR3WGRMYWx4STNDSGJhczdUeS9SeGcvYlM5czVBMlp2?=
 =?utf-8?B?bStEQVdUck1OMXlUdG9hWFBMcWNIZEh6RkdLR2RGbVoyaWRTNkN6QStsK0lV?=
 =?utf-8?B?ZUQ0MjhBcVB2UnJhVVlOR3NVVzVHNnBpTWxUcXZ0b2R3SUpzdXlnUElMdXIw?=
 =?utf-8?B?MUN1U3dxdllveVpuVWdVem1NZmZGQkgybys5aU1BMXJWNkh1MjNSQlVoTE9p?=
 =?utf-8?Q?quQERm4rqunh1MhIoBT3VRNOo?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B7FDFECD32690488F39C1C22757CE94@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dBWJPumE3GFZ3oZ053z+0eNDqIEXHeOOlk4/Ubh8aSSUtLNPrtBLFZJ+lRrbaZoi3M4opfYLW2oeFRBIywMoDcHAJCEq977YN3Z9QNRQReaLmItQ+r1vwWsudb0gq288MeOzVlqotjqg6sHevakSBnAd+pT3zI90rDNCB1ZV/fRytrP/YXMqC22eMXIN6Ns2YSoEy6u0S7qxcBgZ4BASIXY0CP2DkkBjGKLEuXeF2bER4NtNlpC8kpqQClklt8K6C/9v7yUZNKWh5GvslZuNudc2MRKiG4U4BPIm17Z6zk1C4QQrLH+kHwkVtoMSkHZ+NluL8Ag33eX0JshGXeUyf3+/BE5gBkPcoyYlApWYOHE9UrgWNR3U+lxfMZ/3bqotHyAGNCltdF4Hu5Yq1iRZUBw3AHQCL5PhBZKfKSzBgr6nDzx41lb9XC1KFmK5/hkneN8U52lWHtOcfczkhiIYg7xnAGPzFJqxagc5LoGZB9J8bKTM+jSU2feIUjfT5NHW4cHnUWViV7v02FJhADTYqbxG04AC+OgMTisfeiaNSifb+TU/qm9x/y1dI6cp3afRWh+CK6UZ1L6URJAn585yBV5ySlfoN48wC4r+OBMXHvVi75cfGTsYvEVwFLwi+Mr9RPEkyRQ6OVjxwgN3EI5WDw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3445b0f-f23b-4f93-843d-08dd4bcc0310
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2025 01:16:15.3242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l5lZ0UY2XSx+JVk69kdYNHkWkO3ygaqzZ+RRg6nXY57PlGkNeCNQSxhf5NlMhLJe/dJVyuMFt9MpJjRmh3iHEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8402
X-Proofpoint-GUID: yua9BS9AKJhrrczA4-4O_Osxzg_wHeDN
X-Authority-Analysis: v=2.4 cv=Z9wWHGRA c=1 sm=1 tr=0 ts=67ad47e7 cx=c_pps a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=T2h4t0Lz3GQA:10 a=nEwiWwFL_bsA:10 a=qPHU084jO2kA:10 a=87lew0rZXskLRvqORW8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: yua9BS9AKJhrrczA4-4O_Osxzg_wHeDN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_08,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxscore=0 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 mlxlogscore=786
 clxscore=1015 lowpriorityscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502130007

T24gV2VkLCBGZWIgMTIsIDIwMjUsIEFuZHkgU2hldmNoZW5rbyB3cm90ZToNCj4gT24gV2VkLCBG
ZWIgMTIsIDIwMjUgYXQgMDE6MTA6MTdBTSArMDAwMCwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+
IE9uIE1vbiwgRmViIDAzLCAyMDI1LCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+ID4gPiBUaGUg
c25wcyxyZXNlcnZlZC1lbmRwb2ludHMgcHJvcGVydHkgbGlzdHMgdGhlIHJlc2VydmVkIGVuZHBv
aW50cw0KPiA+ID4gdGhhdCBzaG91bGRuJ3QgYmUgdXNlZCBmb3Igbm9ybWFsIHRyYW5zZmVycy4g
QWRkIHN1cHBvcnQgZm9yIHRoYXQNCj4gPiA+IHRvIHRoZSBkcml2ZXIuDQo+IA0KPiA+ID4gV2hp
bGUgYXQgaXQsIG1ha2Ugc3VyZSB3ZSBkb24ndCBjcmFzaCBieSBhIHN1ZGRlbiBhY2Nlc3MgdG8g
dGhvc2UNCj4gPiA+IGVuZHBvaW50cyBpbiB0aGUgZ2FkZ2V0IGRyaXZlci4NCj4gDQo+IF5eXiAo
MSkNCj4gDQo+IC4uLg0KPiANCj4gPiA+ICAJLyogUmVzZXQgcmVzb3VyY2UgYWxsb2NhdGlvbiBm
bGFncyAqLw0KPiA+ID4gLQlmb3IgKGkgPSByZXNvdXJjZV9pbmRleDsgaSA8IGR3Yy0+bnVtX2Vw
cyAmJiBkd2MtPmVwc1tpXTsgaSsrKQ0KPiA+ID4gLQkJZHdjLT5lcHNbaV0tPmZsYWdzICY9IH5E
V0MzX0VQX1JFU09VUkNFX0FMTE9DQVRFRDsNCj4gPiA+ICsJZm9yIChpID0gcmVzb3VyY2VfaW5k
ZXg7IGkgPCBkd2MtPm51bV9lcHM7IGkrKykgew0KPiA+ID4gKwkJZGVwID0gZHdjLT5lcHNbaV07
DQo+ID4gPiArCQlpZiAoIWRlcCkNCj4gPiA+ICsJCQljb250aW51ZTsNCj4gPiA+ICsNCj4gPiA+
ICsJCWRlcC0+ZmxhZ3MgJj0gfkRXQzNfRVBfUkVTT1VSQ0VfQUxMT0NBVEVEOw0KPiA+ID4gKwl9
DQo+ID4gDQo+ID4gUGxlYXNlIGtlZXAgY29kZSByZWZhY3RvcmluZyBhcyBhIHNlcGFyYXRlIHBh
dGNoLg0KPiANCj4gSXQncyBpbmR1Y2VkIGJ5IHRoZSBjaGFuZ2UgeW91IGFza2VkIGZvciwgaXQn
cyBub3QgYSBzaW1wbGUgcmVmYWN0b3JpbmcuDQo+IA0KPiBPciBkbyB5b3Ugd2FudCBtZSB0byBo
YXZlIHRoZSBwYXRjaCB0byBjaGVjayBlcHMgYWdhaW5zdCBOVUxMIHRvIGJlIHNlcGFyYXRlZA0K
PiBmcm9tIHRoaXMgb25lIChzZWUgKDEpIGFib3ZlKT8NCg0KDQpUaGUgY29uZGl0aW9uICJpIDwg
ZHdjLT5udW0gJiYgZHdjLT5lcHNbaV0iIGFscmVhZHkgZG9lcyB0aGUgTlVMTCBjaGVjay4NClRo
ZSBjaGFuZ2UgaGVyZSBvbmx5IG1vdmUgdGhpbmdzIGFyb3VuZC4NCg0KPiANCj4gPiA+ICANCj4g
PiA+ICAJcmV0dXJuIDA7DQo+IA0KPiAuLi4NCj4gDQo+ID4gPiArc3RhdGljIGludCBkd2MzX2dh
ZGdldF9wYXJzZV9yZXNlcnZlZF9lbmRwb2ludHMoc3RydWN0IGR3YzMgKmR3YywgY29uc3QgY2hh
ciAqcHJvcG5hbWUsDQo+ID4gPiArCQkJCQkJdTggKmVwcywgdTggbnVtKQ0KPiA+ID4gK3sNCj4g
PiA+ICsJdTggY291bnQ7DQo+ID4gPiArCWludCByZXQ7DQo+ID4gPiArDQo+ID4gPiArCWlmICgh
ZGV2aWNlX3Byb3BlcnR5X3ByZXNlbnQoZHdjLT5kZXYsIHByb3BuYW1lKSkNCj4gPiA+ICsJCXJl
dHVybiAwOw0KPiA+ID4gKw0KPiA+ID4gKwlyZXQgPSBkZXZpY2VfcHJvcGVydHlfY291bnRfdTgo
ZHdjLT5kZXYsIHByb3BuYW1lKTsNCj4gPiA+ICsJaWYgKHJldCA8IDApDQo+ID4gPiArCQlyZXR1
cm4gcmV0Ow0KPiA+ID4gKwljb3VudCA9IHJldDsNCj4gPiA+ICsNCj4gPiA+ICsJcmV0ID0gZGV2
aWNlX3Byb3BlcnR5X3JlYWRfdThfYXJyYXkoZHdjLT5kZXYsIHByb3BuYW1lLCBlcHMsIG1pbihu
dW0sIGNvdW50KSk7DQo+ID4gDQo+ID4gV2h5IGRvIG1pbihudW0sIGNvdW50KT8gQ2FuIHdlIGp1
c3QgcHV0IHRoZSBzaXplIG9mIHRoZSBlcHMgYXJyYXkgYXMNCj4gPiBzcGVjaWZpZWQgYnkgdGhl
IGZ1bmN0aW9uIGRvYy4NCj4gDQo+IE5vLCB3ZSBjYW4ndCBhc2sgbW9yZSB0aGFuIHRoZXJlIGlz
LiBUaGUgY2FsbCB3aWxsIGZhaWwgaW4gc3VjaCBhIGNhc2UuDQo+IEluIGNhc2UgeW91IHdvbmRl
ciwgdGhlIHNpbWlsYXIgT0YgY2FsbCBhbHNvIGJlaGF2ZXMgaW4gdGhlIHNhbWUgd2F5Lg0KDQpZ
ZWFoLCBJIHJlYWxpemVkIHRoYXQgcmlnaHQgYWZ0ZXIgSSB3cm90ZSB0aGUgY29tbWVudCBhbmQg
cmVzcG9uZGVkDQphZnRlci4NCg0KQlIsDQpUaGluaA==

