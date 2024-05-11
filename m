Return-Path: <linux-kernel+bounces-176352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7088C8C2E47
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 02:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBFDB1F2195E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 00:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98361CD2C;
	Sat, 11 May 2024 00:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="tX3mLNpY";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="eQwSOyPz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="vNNK70vx"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4E21CAB9;
	Sat, 11 May 2024 00:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715388739; cv=fail; b=pvCiqJkEmNRbPMMjOWicVYd7GMsD8jQMfVaZoPWQUE7ovoZuI2/AwdyZlG587DjwG1zO25R1QYso6sGWTT5ryLBj1s/T5/jdrrORuMOIwkrUcN7slG4jrN5A0MLDOtqKbEjqkjoyn3J2zUlBjCakILu+BDncixLz5IbQ+sLOLGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715388739; c=relaxed/simple;
	bh=B+NhNP2fmL9gmMj7jgBBgNVd/EPsV+kHGZ5t6dw39gY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q7v1DZ+NnIwa9u3N0GzdYf3aKKcyoj3oz5+nTEQnVBZ3ZzRZnDEVhPaoA7dMKSvQ1dnbSTrFYzQzekrQFxhf0nzeitmDyox4QJYRUkVavta5T/ZtOb7AzRBA0vTyxX4Hrg2SuyyBMsSNchcGlmVFD147bNcu5cRq+NpMm++wcHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=tX3mLNpY; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=eQwSOyPz; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=vNNK70vx reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44AKjE4x022140;
	Fri, 10 May 2024 17:52:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=B+NhNP2fmL9gmMj7jgBBgNVd/EPsV+kHGZ5t6dw39gY=; b=
	tX3mLNpYwAWQMWI7/pLAhoR2zDFk6znv2zcDnss4T0iwvDl+rX1bbCKJULc4pSYp
	QLPXsUGHY9sq0/wRU071v/aMbznhURIIU21GK5S8MHo/GcUcN3dj92xw4CM9Ho8t
	D+MCaOxFj1vwZFD+zDp1iSCytfVyKx5Eo+lgoFhr9JIeahvfvNw9qBKBrdlqf4QY
	TsRP9xNwS1Eu6rIlks9NadUShn/DWAyXm+bm40L5CD7If0X8osoDxKQV+0sVVss7
	qTfAJXRWRGzfhMMhoVmqzxr5tR8+7uoXmumvKb2tHDx8Rn4oTAeLVjpTfD7O3qEk
	qEQDT2cC4mtsNXM5bxbNTA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3y16xdmvck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 17:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1715388730; bh=B+NhNP2fmL9gmMj7jgBBgNVd/EPsV+kHGZ5t6dw39gY=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=eQwSOyPzRgXo77MrteO7IKN6qx2s40ESmh1+L7yGOw/u/A1+UB942pBiptHH1RbWL
	 MHUGopsHwBc5SkLes8DoD2rXYlWVTUH47jhPGruAawhS3qAS++JzIfPBuDafya8SOG
	 3aKI60rs30M+NzEKY0idQh4P+uiCzMx/Gnb4appn2raMHVliwyx+Z9npwQy1AA3gPy
	 UFqgnN4CJcx/PWgJxYQb/g+SpaO8QZcUnBOlE+W77SjeCtnK4yqkI+bQrMEGGxW6xf
	 Mbkik03MxWl40RJBxwkH59BDtv1KufqzOvcoiaG6ZOrhIwc8WsRZen7qOK1rXEUoD3
	 XhJDwU2Nl+g5w==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id AB5194034A;
	Sat, 11 May 2024 00:52:10 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id D97C1A007B;
	Sat, 11 May 2024 00:52:09 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=vNNK70vx;
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 980084048B;
	Sat, 11 May 2024 00:52:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0GQFdzuT965i3wOpmAbB6QjNOeq/fB2JPFCiTG/QL48vy8ixS3lFo+7w1+4g20foZ1K5FS+wde25HOIp/L5QDeNlzFlmRD3/9MiW7cIwAFVi8sOAZMlVh1gELPrzOOifirylkf34oCl0xzsc9r16AArBjYbsvbE7gFewXFn0nBJwmHY3j44MYfgCHzmGJEND2oQ+5EZFlihdnMOG/8EQsZeojeSS5nnsm+jygPXomPjNLS5ZHcs6iK5Jly7sX0ckxUT0wUpXzhFKsMKgXe7F0YmSHYVUUYjhwclFYQZuAugHaUBgjpaGm0y0XhhVC+O7XoYrx/tX0DxDRpvNaf6TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+NhNP2fmL9gmMj7jgBBgNVd/EPsV+kHGZ5t6dw39gY=;
 b=E5J7kkVHaup/HpSblD6mnrcB4SgfVOIFSgJOQvQ9TT33RcbHVKQwgcnAA3Xua11v5o54VuXkVhnlKQj76fUo8pBWSK2Kh86HoeSYsm5/Ctsnrl/aoOE6NOYH+WG3A/bBU0jODuWFoRuHYBF6c7KlXGMw6nfmP5XOu4oAIe2O1XgXzDNaLYc+SFFgJu5s5APVtRl1Z2/rweXNnhMNr2MJxcNTqMrgeIFr9wII5qaxf6cLHTGAYv5mrbC+QyYVo9z1wLNM1tey9GBi6NhlFy2Z1LrEGXLtwpIoMCoJOO1ZejYrBvt4M7DZaEl/ITcZoif6OModvR+BTgBMONzDi1uOoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+NhNP2fmL9gmMj7jgBBgNVd/EPsV+kHGZ5t6dw39gY=;
 b=vNNK70vx7pLQUEwuqY1VPcwfG2eDoAqGpCs0kYJfITT95ztTUoFCsFvaeBC0iXBzFQqENTr/BEUA+VNeIFN9EN4MjfbbaNutlCgM02OjQqjhd1bIYKl5v8e3wqz85HamZZEIIyi3VwZXGIqZD1Az+zgSio7Amxv11ErVlfuK6sw=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CH3PR12MB8509.namprd12.prod.outlook.com (2603:10b6:610:157::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48; Sat, 11 May
 2024 00:51:58 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7827:b41a:c9d6:8e1d]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7827:b41a:c9d6:8e1d%7]) with mapi id 15.20.7544.048; Sat, 11 May 2024
 00:51:57 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Michael Grzeschik <mgr@pengutronix.de>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: gadget: check drained isoc ep
Thread-Topic: [PATCH v2] usb: dwc3: gadget: check drained isoc ep
Thread-Index: 
 AQHahUf+Fjbt0R5rsESCdAPrKfiIcbFVmhGAgAADmgCAAaX5AIAeuKwAgADM1YCAESZwAIAGPZAAgAAOPwCAAzTaAA==
Date: Sat, 11 May 2024 00:51:57 +0000
Message-ID: <20240511005148.zqighnpv2zxboogf@synopsys.com>
References: 
 <20240307-dwc3-gadget-complete-irq-v2-1-8c5e9b35f7b9@pengutronix.de>
 <20240402230555.xgt5uilc42diyr4m@synopsys.com>
 <20240402231848.4hzzrxegjrcmdab2@synopsys.com>
 <20240404002906.wk6xbz2wp2tf2xwn@synopsys.com>
 <Zie5sN473m2rgNTK@pengutronix.de>
 <20240424015059.w7hsee4tt2ixkp5y@synopsys.com>
 <ZjbIeib2UMta7FbY@pengutronix.de>
 <20240508230252.wauttsgkp63fpife@synopsys.com>
 <ZjwQkIBUlhl-4ScO@pengutronix.de>
In-Reply-To: <ZjwQkIBUlhl-4ScO@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CH3PR12MB8509:EE_
x-ms-office365-filtering-correlation-id: 4d72fe35-4fbe-4f97-89b8-08dc71548f82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?Qy9qUE5JbEY1WWZKdzc5WFl4dFRWQmZtT3UrS2lLOGxuUXZjOTVUaTdmdlBK?=
 =?utf-8?B?N1p5Wkt1SzhZL1hkQTJ3OE5jS2hsYVVDTjhkVnJVQ3N2NmRMbmM3N2tQaWtD?=
 =?utf-8?B?QjdCUTZYVkpUQ1FxZ05ING9uU0FxblVpU1o3bkRzaTlZNkJZclZLeTR2SHFN?=
 =?utf-8?B?cElDV2F0djBxSVY4bStnME5ScTk0YU1yR3grYmdURGJ1N012aHI2dkUrU0Ir?=
 =?utf-8?B?dHlJdGVUUFdsWGNIUm00clRaTURKUG1jNFlZL3V5YTNMTkIvOGpGQ1VranNI?=
 =?utf-8?B?M1g4SWxzUUtDa1M4TjEyYUxmenkyTUNpZnhtdDJjZVVNSEhMbEpmVm1pM1FL?=
 =?utf-8?B?enNndDFJTnIwUEVnRzdDeU8yWEtOOXVOSU9Zb1pKTkFSL3RyRmIzRkZPUkht?=
 =?utf-8?B?M1JBc254QTlPUnN1WS9FdVNiRjJtZGlqbTVaUU1uVEhDWThMN1FKa0NVaXRF?=
 =?utf-8?B?R1FuaHBjOUF6dUhLRkNRTlRtdUs5UzAxdFJKTkxKanZWOFEzcjdKZjZzRTAz?=
 =?utf-8?B?VUNEWHNCUEhOUFY4eEFHVDJoSzRYV28rdllON1lrVlJRSHpNbWdqUzJnUkM3?=
 =?utf-8?B?VUxDeG5IWk1QTjBIb0drOTBucHhpMnlyOFdqb2x5d3RtV1ZkY1JwTUd5UXFE?=
 =?utf-8?B?N3hyeHFoVzA5SS9kRm5pWXhkcTdkdlc1bitXejZvb1p1Y0Z3R0gvRjBWT3FQ?=
 =?utf-8?B?cVJvM1BPUnBKTER3b1BkL0JSU2NlVVQ2VlJEVGd3RXhMRXBzWmdiSTV2T05h?=
 =?utf-8?B?OG5sWXFycVF4a0p4MVU1TVUrWWZLM0JIZG9JczNZUTJpamd5UnVHSkoyY0VN?=
 =?utf-8?B?OEkySGxUOW1pT0FWQTRXOS9GeFZUbFhLREFZQzU5WWU2Vmh2WEU2T0wwQkNK?=
 =?utf-8?B?dTZaT1ZpVDgwa2JFQzhMcGthZEQ5YnBndERlazd4ZHE4YVQ2T2oxVUUxY3h2?=
 =?utf-8?B?c05vYTBFZ0UrNUduQWtxR3NaeW92bGxkL3drQXQ5bGZ1a09hbUd1Nmp1SHQ5?=
 =?utf-8?B?R01UcHRQSHhPOHB4WEFHYjhjQ3VZdVk0NTdDTTY2a1h2aEFmalhyZ2ZVTlUz?=
 =?utf-8?B?VXI2MUVjNFBBV2lVWVBtSCswK281SnRNZ2dIVUpUWDdVd0wySmlXS1VQWDBJ?=
 =?utf-8?B?cjBMQnJMRHJlMWt5ZWtNajdHRGFUWklYdCswUVltd0taNmhTQ3YvTG5MMEpM?=
 =?utf-8?B?MnJtaURpblpCaGJCQ29kdWNvOC9oOVNLOWErMUpJZFlyeUNwSEowaVdhcm5s?=
 =?utf-8?B?Z3E5UXZIZkhHNXltb01JSEhacCtZUGxmYzc3SGt5cmRCbDFROWI2RVhRdFRY?=
 =?utf-8?B?NENYRitlZVpoSkNmMlVhNUpINnJlbzU5RU9oRlJUM2w3ZVE2QlVpSXdRK3ZZ?=
 =?utf-8?B?S2twTHZreEVOaVJBanpWUG1aYUhJM1UrS0J5MHB1eTNPWkx0NUdjdWRmMTJY?=
 =?utf-8?B?d1dJT0MrTFNPUjMvY1NLYjIyTjhFRDF3L1Y1TU1nTUV5WnZkdHRycjRQYTZa?=
 =?utf-8?B?eS91bFJ1c015ZnVSSnNsYTYxZzY5WjgwTUdsdzEyZUl3VFp1K0N2ZXphL0w4?=
 =?utf-8?B?TnJQRmhQZ0xWcVBhOE5WQ3BLcHlFbkFYOG5sSHFtZVNRdXZkNGs0cjlycXFU?=
 =?utf-8?B?TXMzVmVDQkpDZnljVjBQOHUwRW1uZDhPVXRRNTlEUnllRG1QdFVsTXVPRktY?=
 =?utf-8?B?NXE2blVNQnhYQmo1VlFsMXhpWXdSZllTeEY3Mzk0ek9oRk9IWnc5THF3PT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MkZtbnV1Zk1NQmtoT3dLcTFGSm0zUWFlVGVPYnBucDMyTE8xcmZpVVZjR3Rp?=
 =?utf-8?B?WDgzUnNDTHZZRVh3bUpDUDFtbFcvOHh4cjJWOS9ENjRJbjRZeXBoOVdGTWRN?=
 =?utf-8?B?bmpVQUxRMmhzTndZYlljZ2xwUjY1ZE9RNmtHWEJyVndLN1FEeWZCMmxHM1U4?=
 =?utf-8?B?azIxRjB4TENNcldFVDljenpWRmFXZ1F6a0cxb2x5dVo0OC9hbnVKUFNoTlQ4?=
 =?utf-8?B?V3UxMENQdEd1M3I2N1I5eVRxVWsyS1RHb2dvL3k5a095QzIwRkttNTBhZXRV?=
 =?utf-8?B?T0FNZWVGVVZJeTJZckU0aWNaUG5yUXc1aUpFWFI1cFJRYXlPemxONUlPc0Zi?=
 =?utf-8?B?dk1NQ2FmRS9JSnNGc09IdjJ6ZXVoV2lDVVNEdDhzOVFJc1V2bGVPMGJlT0Vp?=
 =?utf-8?B?SjdOaTN1dm51OExCUU5wcld5SGIxODVkWWNSRUg0a0h1WjZtNEdYeXRiejRs?=
 =?utf-8?B?bG9RWWVHTnJlNStTZmVpRkFmdTZRTjR0S29Kb3pFVFFFYTZIK3pmS0kwV25k?=
 =?utf-8?B?anRCRHUwbElRYStGVFFaajAxeFdsOGM1eThNNjBsNVEwZ1BROWNFZm50RnJY?=
 =?utf-8?B?RGN1WWlCTjdXaWIrR3gzOFlmMEhlQmZyc0NJMVpsMjZwOUtrMnBHTUMzZjNx?=
 =?utf-8?B?TTRDa1pmWVpuazFIdDFqWUJFeW92L2UzVHdyZnlCQzFxVk9pN09ucFVtNjFt?=
 =?utf-8?B?UWV4eWNZbmN0LzZackJMbjRPQ2RqMjN4NkkzZzBNSzNVb1g5aXhtd2k2aWRh?=
 =?utf-8?B?akFjNU1QcXVSTzJxcktqRVlHR2JPWXRINTJCUE00TDNYdFVreW1JZkRGbHRt?=
 =?utf-8?B?VUU1b082RXVQTGpJSWFlczhGZHl6d0Z6NHoxeDBXd1pQSVQzSDE1ZDJraklq?=
 =?utf-8?B?OUNLQWdvdStySUQwdGdKV1ozTjRMaGw3RFgzcUs5WTM1WEZUMWwrYWNXaHc4?=
 =?utf-8?B?VVRHVEhtRTZSTHBLbGRVZHJJZmhCV3BrbjdXUndSL290bWRCUk5yclJjN0sv?=
 =?utf-8?B?M3BFSWlqTTNRZk1hbE5xekJyb2NXMTRCTTE3V3huU2p4VHFqaElsNDZhcTMx?=
 =?utf-8?B?STQvVWl4YWNDL2hodUszUVFIK3N4TjhPTU4yN3JUck9DOG4vT3FjZGw2UGV1?=
 =?utf-8?B?UzltbDd0WVYyQUVKUzJSRVRWOXRLS1lINTRhWmFxYUdjcldGcUNpRzY3ODlD?=
 =?utf-8?B?Sit4bE4rMlM2bHF4WnRtS0tDWTY3VlloOTMzbW5aQjE1b3dkbi95QXlocHVX?=
 =?utf-8?B?L0Y4REwxSlE0b1g5OGdJOVJ4VnVpOVNRK0NyR3dneW8yajRDYmtRWUZyUUts?=
 =?utf-8?B?UEU0aHR3UnZFYzUwekdod2crOTRid3FvTHp2eUpDamRsRnNMYnRCenlYbTQy?=
 =?utf-8?B?N0lmaGNzb1VaYUxaUHkyWWZyMnBqOWZQUkVmcmNGbVpaSStSc2JMdTRURkVy?=
 =?utf-8?B?ZXBxYkl3dUQvSmZkMThwUk9SdzFuUDdWd3FmUmxuMTYvTGg3dXc2Z3ZBWXd6?=
 =?utf-8?B?bmU2bUxkL2FoblEzbkdiOGtzSnRyelcvcXJvVFNwOWVVYTVUZGdzRm0vc1ZE?=
 =?utf-8?B?MWJJTDlsS1pHR0JnTVN2MWxIcnRqa0lOZW5zNDVJcWRhZnBHdVBRNWhRay91?=
 =?utf-8?B?NlVxSjduYkRoRGZEakRCQklIRkhPemlGNnJrbjY1WWlycFoyOVBoNVNyRWtj?=
 =?utf-8?B?MTlIcVlIcVZNUUJuMGhUVUl2U0R1UmNSOVVJNUFCaldoZEllUXZ3WGY1VnlK?=
 =?utf-8?B?a1BILzlFY240eTIvS1JHRDRLRW4rTlJwTno0R0wwZlhJUjUzVjVlbitvQnNZ?=
 =?utf-8?B?U3lHYUsxMjBzN2t3OTdBd3hMaDNLK1BBdFpFcHUrQ1AwL2p2TFIyTGNzMTJq?=
 =?utf-8?B?dU4vTFVhTzk3cnRhdHZVelJmMW84WXllcmI0dC9DekJNai9DQnJIc1FWcERM?=
 =?utf-8?B?bkVVOWx4R3lVcWc0Rkh3aGdxR1I3VnBqRGZhaFAxR050M3NMc3I2U2pxUUdw?=
 =?utf-8?B?ZnRCUWhEaWFzcktnVVQyYURBUis2VjhSSmIvL3pIRktrSUtkeEJJVGRnazBo?=
 =?utf-8?B?NFhwR3dHOWwxWkcvL1phS0VuQnF0bjBuRWtLMkZ1TkIrZzRFQ1o4eE00N05U?=
 =?utf-8?Q?PZGUVqj8w2gsabhlHJEDe/+UY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F595653C1EA5F74790651E21F9C869F3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	YqvsXFqgaSu6X1EaiyyV5jTMplnL+cIFNxHLAzeLHj1LWyCSAv+UvZxuTQC/dMv0LgspYCQcrDfbkrbgNeZ8wJZ9VmP7mS08WNTmkvZRjfbS+gWHeAmzZZoZMGADbCd9+xIHfDot69eK72l8rEyFEygyH9yKDDMJQR9GQFz+lfsqjDRPnoRNLqGiguJ8A6KWMC7IvvhtYvb/InA6a6NRVBx/SlzOA7crzt1CPKB80iqPXC3BD7M7pJSN6h0rSqT9JS8rNEMxpNvHe002J1lNt+wzV2svF5lulnNTm0arsPTa+9asvuY/+g0WbuiKqvWw05hP0nIcfrFFnwrn5JwzAAr6v3Q5r+XuKx0E1MuanOfvf7ryDOxHneswmvkahbcyvkiSyhm/v9sgL9T6Qmv/JeauYEDv35UV8rCdhxFzusgjOvLojj5oSiA6BsxaFhS+1AjERcxzYy1Ln/9Cu+nJvttXpnMu76YFB3ls6UCscamqjC+P10WX6xsmOc2B+o3jgnirPwep5w6Bbtn9N2Kw7j++AMyAz1UiOMVBurKKwzQXCxG3k9ukGng7fhvvhp0/WK3+8TUkVPG4gd8fsbISYAp9MQ5IvPlCI1wgu5J7LEMQ2gAtweUBkZK0EBci3+9sYNtNClUC7CQXy8wdOcKufw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d72fe35-4fbe-4f97-89b8-08dc71548f82
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2024 00:51:57.8425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zbtHQhuttqfdz9nY3NpRLfP5N3rvJm0vEJ86LIJkHQgw8QgtDv+EbIvsvVnq8fiYX3d7i1wqsw/sFbrM8kdzlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8509
X-Proofpoint-ORIG-GUID: yrHfg6A-DjSo2KWikoGKRaj_dW9Xtl1Z
X-Proofpoint-GUID: yrHfg6A-DjSo2KWikoGKRaj_dW9Xtl1Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_18,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405010000 definitions=main-2405110005

T24gVGh1LCBNYXkgMDksIDIwMjQsIE1pY2hhZWwgR3J6ZXNjaGlrIHdyb3RlOg0KPiBPbiBXZWQs
IE1heSAwOCwgMjAyNCBhdCAxMTowMzowMFBNICswMDAwLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+
ID4gT24gU3VuLCBNYXkgMDUsIDIwMjQsIE1pY2hhZWwgR3J6ZXNjaGlrIHdyb3RlOg0KPiA+ID4g
T24gV2VkLCBBcHIgMjQsIDIwMjQgYXQgMDE6NTE6MDFBTSArMDAwMCwgVGhpbmggTmd1eWVuIHdy
b3RlOg0KPiA+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+IFJpZ2h0LiBVbmZvcnR1bmF0ZWx5LCBk
d2MzIGNhbiBvbmx5ICJndWVzcyIgd2hlbiBVVkMgZnVuY3Rpb24gc3RvcHMNCj4gPiA+ID4gcHVt
cGluZyBtb3JlIHJlcXVlc3Qgb3Igd2hldGhlciBpdCdzIGR1ZSB0byBzb21lIGxhcmdlIGxhdGVu
Y3kuIFRoZQ0KPiA+ID4gPiBsb2dpYyB0byB3b3JrYXJvdW5kIHRoaXMgdW5kZXJydW4gaXNzdWUg
d2lsbCBub3QgYmUgZm9vbHByb29mLiBQZXJoYXBzDQo+ID4gPiA+IHdlIGNhbiBpbXByb3ZlIHVw
b24gaXQsIGJ1dCB0aGUgc29sdXRpb24gaXMgYmV0dGVyIGltcGxlbWVudCBhdCB0aGUgVVZDDQo+
ID4gPiA+IGZ1bmN0aW9uIGRyaXZlci4NCj4gPiA+IA0KPiA+ID4gWWVzLCB0aGUgYmVzdCB3YXkg
dG8gc29sdmUgdGhpcyBpcyBpbiB0aGUgdXZjIGRyaXZlci4NCj4gPiA+IA0KPiA+ID4gPiBJIHRo
b3VnaHQgd2UgaGF2ZSB0aGUgbWVjaGFuaXNtIGluIFVWQyBmdW5jdGlvbiBub3cgdG8gZW5zdXJl
IHF1ZXVpbmcNCj4gPiA+ID4gZW5vdWdoIHplcm8tbGVuZ3RoIHJlcXVlc3RzIHRvIGFjY291bnQg
Zm9yIHVuZGVycnVuL2xhdGVuY3kgaXNzdWU/DQo+ID4gPiA+IFdoYXQncyB0aGUgaXNzdWUgbm93
Pw0KPiA+ID4gDQo+ID4gPiBUaGlzIGlzIGFjdHVhbGx5IG9ubHkgcGFydGlhbGx5IHRydWUuIEV2
ZW4gd2l0aCB0aGUgemVyby1sZW5ndGggcGFja2FnZXMNCj4gPiA+IGl0IGlzIHBvc3NpYmxlIHRo
YXQgd2UgcnVuIGludG8gdW5kZXJydW5zLiBUaGlzIGlzIHdoeSB3ZSBpbXBsZW1lbnRlZA0KPiA+
ID4gdGhpcyBwYXRjaC4gVGhpcyBoYXMgaGFwcGVuZWQgYmVjYXVzZSBhbm90aGVyIGludGVycnVw
dCB0aHJlYWQgd2l0aCB0aGUNCj4gPiA+IHNhbWUgcHJpbyBvbiB0aGUgc2FtZSBDUFUgYXMgdGhp
cyBpbnRlcnJ1cHQgdGhyZWFkIHdhcyBrZWVwaW5nIHRoZSBDUFUNCj4gPiANCj4gPiBEbyB5b3Ug
aGF2ZSB0aGUgZGF0YSBvbiB0aGUgd29yc3QgbGF0ZW5jeT8NCj4gDQo+IEl0IHdhcyBzb21ldGhp
bmcgYSBiaXQgbW9yZSB0aGVuIGFyb3VuZCAybXMgQUZBSVIuIFNpbmNlIHdpdGggb25lIGZyYW1l
DQo+IGVucXVldWVkIHdlIG9ubHkgdHJpZ2dlciB0aGUgaW50ZXJydXB0IGV2ZXJ5IDE2IHJlcXVl
c3RzICgxNioxMjV1cyA9IDJtcykNCj4gDQo+IFNvIHdpdGggYXQgbGVhc3QgMm1zIGxhdGVuY3kg
d2UgZGlkIGhpdCB0aGUgc3dlZXQgc3BvdCBpbiBzZXZlcmFsIGNhc2VzLg0KDQpGb3IgMm1zLCB3
ZSBzaG91bGQgYmUgYWJsZSB0byBoYW5kbGUgdGhpcyB3aXRoIHRoZSB6ZXJvLWxlbmd0aCByZXF1
ZXN0cy4NCg0KPiANCj4gPiBDYW4gdGhpcyBvdGhlciBpbnRlcnJ1cHQgdGhyZWFkIGxvd2VyIGl0
cyBwcmlvcml0eSByZWxhdGl2ZSB0byBVVkM/IEZvcg0KPiA+IGlzb2MgZW5kcG9pbnQsIGRhdGEg
aXMgdGltZSBjcml0aWNhbC4NCj4gDQo+IFRoZSBkZXRhaWxzIGFyZSBub3QgdGhhdCBpbXBvcnRh
bnQuIFN1cmUgdGhlIGlzIGEgYnVnLCB0aGF0IG5lZWRlZCB0byBiZQ0KPiBzb2x2ZWQuIEJ1dCBh
bGwgSSB3YW50ZWQgaXMgdG8gaW1wcm92ZSB0aGUgb3ZlcmFsIGR3YzMgZHJpdmVyLg0KPiANCj4g
PiBDdXJyZW50bHkgZHdjMyBjYW4gaGF2ZSB1cCB0byAyNTUgVFJCcyBwZXIgZW5kcG9pbnQsIHBv
dGVudGlhbGx5IDI1NQ0KPiA+IHplcm8tbGVuZ3RoIHJlcXVlc3RzLiBUaGF0J3MgMjU1IHVmcmFt
ZSwgb3Igcm91Z2hseSB+MzBtcy4gSXMgeW91ciB3b3JzdA0KPiA+IGxhdGVuY3kgbW9yZSB0aGFu
IDMwbXM/IGllLiBubyBoYW5kbGluZyBvZiB0cmFuc2ZlciBjb21wbGV0aW9uIGFuZA0KPiA+IGVw
X3F1ZXVlIGZvciB0aGUgd2hvbGUgMjU1IGludGVydmFscyBvciAzMG1zLiBJZiB0aGF0J3MgdGhl
IGNhc2UsIHdlDQo+ID4gaGF2ZSBwcm9ibGVtcyB0aGF0IGNhbm5vdCBqdXN0IGJlIHNvbHZlZCBp
biBkd2MzLg0KPiANCj4gWWVzLiBCdXQgYXMgbWVudGlvbmVkIGFib3ZlLCB0aGlzIHdhcyBub3Qg
dGhlIGNhc2UuIFNwZWFraW5nIG9mLCB0aGVyZQ0KPiBpcyBjdXJyZW50bHkgYSBidWcgaW4gdGhl
IHV2Y192aWRlbyBkcml2ZXIsIHRoYXQgaXMgbm90IHRha2luZyBpbnRvDQo+IGFjb3VudCB0aGF0
IGFjdHVhbGx5IGV2ZXJ5IHplcm8tbGVuZ3RoIHJlcXVlc3Qgc2hvdWxkIHdpdGhvdXQgZXhjZXB0
aW9uDQo+IG5lZWQgdG8gdHJpZ2dlciBhbiBpbnRlcnJ1cHQuDQoNCk5vdCBuZWNlc3NhcmlseSwg
eW91IGNhbiBzZW5kIG11bHRpcGxlIHNldCBvZiB6ZXJvLWxlbmd0aCByZXF1ZXN0cw0Kd2hlcmUs
IGZvciBleGFtcGxlLCBJT0Mgb24gdGhlIGxhc3QgcmVxdWVzdCBvZiB0aGUgc2V0Lg0KDQo+IEN1
cnJlbnRseSB3ZSBhbHNvIG9ubHkgc2NhdHRlciB0aGVtIG92ZXINCj4gdGhlIDE2bXMgcGVyaW9k
LCBsaWtlIHdpdGggdGhlIGFjdHVhbCBwYXlsb2FkLiBCdXQgc2luY2Ugd2UgZmVlZCB0aGUNCj4g
dmlkZW8gc3RyZWFtIHdpdGggdGhlIGludGVycnVwdHMsIHdlIGxvb3NlIDJtcyBvZiBwb3RlbnRp
YWwgZXBfcXVldWUNCj4gY2FsbHMgd2l0aCBhY3R1YWwgcGF5bG9hZCBpbiB0aGUgd29yc3QgY2Fz
ZS4NCj4gDQo+IE15IHBhdGNoIGlzIGFscmVhZHkgaW4gdGhlIHN0YWNrIGFuZCB3aWxsIGJlIHNl
bmQgdG9kYXkuDQo+IA0KPiA+ID4gYnVzeS4gQXMgdGhlIGR3YzMgaW50ZXJydXB0IHRocmVhZCBn
ZXQgdG8gaXRzIGNhbGwsIHRoZSB0aW1lIHdhcyBhbHJlYWR5DQo+ID4gPiBvdmVyIGFuZCB0aGUg
aHcgd2FzIGFscmVhZHkgZHJhaW5lZCwgYWx0aG91Z2ggdGhlIHN0YXJ0ZWQgbGlzdCB3YXMgbm90
DQo+ID4gPiB5ZXQgZW1wdHksIHdoaWNoIHdhcyBjYXVzaW5nIHRoZSBuZXh0IHF1ZXVlZCByZXF1
ZXN0cyB0byBiZSBxdWV1ZWQgdG8NCj4gPiA+IGxhdGUuICh6ZXJvIGxlbmd0aCBvciBub3QpDQo+
ID4gPiANCj4gPiA+IFllcywgdGhpcyBuZWVkZWQgdG8gYmUgc29sdmVkIG9uIHRoZSB1cHBlciBs
ZXZlbCBmaXJzdCwgYnkgbW92aW5nIHRoZQ0KPiA+ID4gbG9uZyBydW5uaW5nIHdvcmsgb2YgdGhl
IG90aGVyIGludGVycnVwdCB0aHJlYWQgdG8gYW5vdGhlciB0aHJlYWQgb3INCj4gPiA+IGV2ZW4g
aW50byB0aGUgdXNlcnNwYWNlLg0KPiA+IA0KPiA+IFJpZ2h0Lg0KPiA+IA0KPiA+ID4gDQo+ID4g
PiBIb3dldmVyIEkgdGhvdWdodCBpdCB3b3VsZCBiZSBncmVhdCBpZiB3ZSBjb3VsZCBzb21laG93
IGZpbmQgb3V0IGluDQo+ID4gPiB0aGUgZHdjMyBjb3JlIGFuZCBtYWtlIHRoZSBwdW1wIG1lY2hh
bmlzbSBtb3JlIHJvYnVzdCBhZ2FpbnN0IHN1Y2gNCj4gPiA+IGxhdGUgZW5xdWV1ZXMuDQo+ID4g
DQo+ID4gVGhlIGR3YzMgY29yZSBoYW5kbGluZyBvZiBldmVudHMgYW5kIGVwX3F1ZXVlIGlzIHJl
bGF0aXZlbHkgcXVpY2suIEknbQ0KPiA+IGFsbCBmb3IgYW55IG9wdGltaXphdGlvbiBpbiB0aGUg
ZHdjMyBjb3JlIGZvciBwZXJmb3JtYW5jZS4gSG93ZXZlciwgSQ0KPiA+IGRvbid0IHdhbnQgdG8g
anVzdCBjb250aW51ZSBsb29raW5nIGZvciB3b3JrYXJvdW5kIGluIHRoZSBkd2MzIGNvcmUNCj4g
PiB3aXRob3V0IGxvb2tpbmcgdG8gc29sdmUgdGhlIGlzc3VlIHdoZXJlIGl0IHNob3VsZCBiZS4g
SSBkb24ndCB3YW50IHRvDQo+ID4gc2FjcmlmaWNlIGNvbXBsZXhpdHkgYW5kL29yIHBlcmZvcm1h
bmNlIHRvIG90aGVyIGFwcGxpY2F0aW9ucyBmb3IganVzdA0KPiA+IFVWQy4NCj4gDQo+IEkgdG90
YWxseSB1bmRlcnN0YW5kIHRoaXMuIEFuZCBhcyB3ZSBhbHJlYWR5IGZvdW5kIG91dCBtb3JlIGFu
ZCBtb3JlDQo+IGFib3V0IHRoZSB1bmRlcmx5aW5nIGNvbXBsZXhpdHkgb2YgdGhlIGR3YzMgZHJp
dmVyIEkgc2VlIG1vcmUgYW5kIG1vcmUNCj4gY2xlYXJlciBob3cgd2UgaGF2ZSB0byBoYW5kbGUg
dGhlIGNvcm5lciBjYXNlcy4gSSBqdXN0IHN0YXJ0ZWQgdGhpcw0KPiBjb252ZXJzYXRpb24gd2l0
aCBBdmljaGFsIGFuZCB5b3UgaW4gdGhlIG90aGVyIHRocmVhZC4NCj4gDQo+IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2FsbC8xNzE5MmUwZi03ZjE4LTQ5YWUtOTZmYy03MTA1NGQ0NmY3NGFAZ29v
Z2xlLmNvbS8NCj4gDQo+IEkgdGhpbmsgdGhlcmUgaXMgc29tZSB3b3JrIHRvIGNvbWUuIEFzIHRv
IGJlIHN1cmUgdGhhdCBldmVyeWJvZHkgaXMgb24NCj4gdGhlIHNhbWUgcGFnZSBJIHdpbGwgcHJl
cGFyZSBhIHJvYWRtYXAgb24gaG93IHRvIHByb2NlZWQgYW5kIHdoYXQgdG8NCj4gZGlzY3Vzcy4g
VGhlcmUgYXJlIG1hbnkgY2FzZXMgaW50ZXJmZXJpbmcgd2l0aCBlYWNoIG90aGVyIHdoaWNoIG1h
a2UgdGhlDQo+IHNvbHV0aW9uIHByZXR0eSBjb21wbGV4Lg0KDQpUaGF0J3MgZ3JlYXQuIExldCdz
IGRvIHRoYXQgc28gd2UgY2FuIHJlc29sdmUgdGhpcyBpc3N1ZS4NCg0KPiANCj4gPiA+IFRoaXMg
YWxsIHN0YXJ0ZWQgd2l0aCB0aGF0IHNlcmllcy4NCj4gPiA+IA0KPiA+ID4gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvYWxsLzIwMjQwMzA3LWR3YzMtZ2FkZ2V0LWNvbXBsZXRlLWlycS12MS0wLTRm
ZTlhYzBiYTJiN0BwZW5ndXRyb25peC5kZS8NCj4gPiA+IA0KPiA+ID4gQW5kIHBhdGNoIDIgb2Yg
dGhpcyBzZXJpZXMgZGlkIHdvcmsgd2VsbCBzbyBmYXIuIFRoZSBuZXh0IG1vdmUgd2FzIHRoaXMN
Cj4gPiA+IHBhdGNoLg0KPiA+ID4gDQo+ID4gPiBTaW5jZSB0aGUgbGFzdCB3ZWVrIGRlYnVnZ2lu
ZyB3ZSBmb3VuZCBvdXQgdGhhdCBpdCBnb3Qgb3RoZXIgaXNzdWVzLg0KPiA+ID4gSXQgaXMgbm90
IGFsbHdheXMgc2F2ZSB0byByZWFkIHRoZSBIV08gYml0LCBmcm9tIHRoZSBkcml2ZXIuDQo+ID4g
PiANCj4gPiA+IFR1cm5zIG91dCB0aGF0IGFmdGVyIGFuIG5ldyBUUkIgd2FzIHByZXBhcmVkIHdp
dGggdGhlIEhXTyBiaXQgc2V0DQo+ID4gPiBpdCBpcyBub3Qgc2F2ZSB0byByZWFkIGltbWlkZWF0
bHkgYmFjayBmcm9tIHRoYXQgdmFsdWUgYXMgdGhlIGh3DQo+ID4gPiB3aWxsIGJlIGRvaW5nIHNv
bWUgb3BlcmF0aW9ucyBvbiB0aGF0IGV4YWN0bHkgbmV3IHByZXBhcmVkIFRSQi4NCj4gPiA+IA0K
PiA+ID4gV2UgcmFuIGludG8gdGhpcyBwcm9ibGVtIHdoZW4gYXBwbHlpbmcgdGhpcyBwYXRjaC4g
VGhlIHRyYiBidWZmZXIgbGlzdA0KPiA+ID4gd2FzIGFjdHVhbGx5IGZpbGxlZCBidXQgd2UgaGl0
IGEgZmFsc2UgcG9zaXRpdmUgd2hlcmUgdGhlIGxhdGVzdCBIV08gYml0DQo+ID4gPiB3YXMgMCAo
cHJvYmFibHkgZHVlIHRvIHRoZSBodyBhY3Rpb24gaW4gdGhlIGJhY2tncm91bmQpIGFuZCB0aGVy
ZWZvcg0KPiA+ID4gd2VudCBpbnRvIGVuZCB0cmFuc2Zlci4NCj4gPiA+IA0KPiA+IA0KPiA+IFRo
YW5rcyBmb3IgdGhlIHVwZGF0ZS4NCj4gDQoNClRoYW5rcywNClRoaW5o

