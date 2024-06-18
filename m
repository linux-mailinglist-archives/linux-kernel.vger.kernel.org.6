Return-Path: <linux-kernel+bounces-220296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8967590DF33
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 00:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 785921C22740
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 22:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12391849C0;
	Tue, 18 Jun 2024 22:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="SGryfNRd";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ZTgNsKL3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="IR6jGX50"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2553A4AEF0;
	Tue, 18 Jun 2024 22:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718750551; cv=fail; b=a7dOWgYttS5uRvH+KiqJz5XfVExrAVEo+2qqPne/oeBHEV/dQ4xNNSRXE+g+62p7RbnLXFjySugvIjAsbx867UlSXTrL29ccl+kSwxFB2gMMq02qHZJ5bfaGfymZzFUBu8lrFqyxO1xuy2qXrlc8UHg83dV1pHflSMXVTRE4ZDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718750551; c=relaxed/simple;
	bh=UzHpc0LYEt9us9oX4vWZU/4glgvfeanl46jBwESu+DY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lo1F6Nmud1rJe5PvQvvwsvsNbro0Umg88+pJYUkDnzobm8ixOvb4XN8+T1LB7xeWzxO6s3JPovN8RQoxNN0jktTZ98MhwjKaMg1VTQLK6FYmdEgLaIDE5srzwH3aTfFfNsfXvyV5az/YgvEGmkIMK78nG0upWpSZ7U33+tiJggg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=SGryfNRd; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ZTgNsKL3; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=IR6jGX50 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ILbxvp007066;
	Tue, 18 Jun 2024 15:42:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=UzHpc0LYEt9us9oX4vWZU/4glgvfeanl46jBwESu+DY=; b=
	SGryfNRdOJOKe2CpgrNqQXrBi9itMUB54eNkZBO9unF436/WP3Wa2KINZxDov03k
	cOc9pQQzuD86kmwXaylD1kKrztz5Za6PHCHM7JLeOfL6EZmC18IvP7Huy9cEPQGz
	Gx42SMVX1pP7X4ZTnMpbcEIZTmku58MW8iFNr1sAfkHiHnAe2nKnt63i7HHjewKY
	GqZY36fk0aeaepcaRjKZVsxoOe1GpM0WniX/B+neEKeA5LimefNNwwH6v0GhJAQR
	qMZ7jEPR+yyIkqlLUaa7EqOVNUpoZtlGd/lyhGeIvm7py4Z6ICq13PLrqHZERz+V
	SW2iJaR+k68ZHifOIf52FA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3yujaq050w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 15:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1718750540; bh=UzHpc0LYEt9us9oX4vWZU/4glgvfeanl46jBwESu+DY=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=ZTgNsKL3T2lPLJdqgirJA19B8hjzui82LlUjGEzB3Q4Kms6flYIVdXTtnOoFOligk
	 MCV9wr9ILDySdjEXBxxl8PsiQGBOLGqPcZ2e9hD4IenqGt3BKQWfMLAEpSoi+WlH/+
	 Ghp3qJq52GPcJ/exH5tFnZXE1zbk6x1vXsRCLOf9OKr1uKyeBjNTRcDRYDjaV4LTBT
	 ENVxf2PZfsroisakdqMP3W4VhOFZKe1PC0Qfled2xwGSBHagyhVe6smFlBLUOKpUDA
	 V4yPYowWzsa/v6pSQtldF8Ts6Z+LFRcvzRY5wuiFVo3iUCH5afFz89hmXVg8P30SXx
	 HDeWlcs3cIKIw==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 1B38F401C6;
	Tue, 18 Jun 2024 22:42:20 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id DF0BFA0060;
	Tue, 18 Jun 2024 22:42:19 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=IR6jGX50;
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 1786F40127;
	Tue, 18 Jun 2024 22:42:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jtaEaoyXLVvBzVREDN7h5BKNaORsGjMeYJwhHfPCQiyKRLeBg7OhxD8sQhoj7Y6a2m+LuMo0AXGwN7Xyr9ktKVNehx2cQt/9CtPx7uIBUsJw7fK9Xpbu0HGcy368jHmxrWF2RSgIlyfdTWDHtRL8d+moEVmjPDt7r+/9p7vjzuW4JzxZDEZTewyJsQL90HtoSO9NuzmLlgSahzo6PGV+GbXOxCO5xYos3JqHqkxkiNydn9HJgA8Y23mL65dEUP5jwJ5iz1g2nlxxGSw+5M4mFA7nBiTT/aNXied8h84XqtPFdVxmKqflLZHlsxI4W6xeCy8YiP3ze6j1oZzmE9M+9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UzHpc0LYEt9us9oX4vWZU/4glgvfeanl46jBwESu+DY=;
 b=EXUttrDDo/ri5VWnmhCNsxXdjI1mcNWW1PUmtNXDPl8JEV7N8iQg+dq04/9EdqIoLgTeTxbUQLUWQSZ71n7o5ju4pjRvzaadX2IQ6A61AlBbj4Qxfbfr9t90AaVtrOrf1VvMKUvOjK8sNoIFe8nXoGixGyHTIOoImK4lDvcRUwvNcp33V+ORH/NBQowqhaM+CIIAw/taZpDg8qtaCTwY0YWoYo98zpIX6H/0LuRC4RGpFVkCCvURtFCQ4ORv4Rv+kQ0sgfXAqOcbOCKUqRJ8MH9A7og7r+Pz8buioG5Wxzr+fbLlmgc4YdvAjIodMd93RPVxxhBL9PT/GDyAZAJLOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzHpc0LYEt9us9oX4vWZU/4glgvfeanl46jBwESu+DY=;
 b=IR6jGX50dBVTxmXnWN5oS37Ig1y8FikiN74odgeFxaOiyuGVGT8WTYnmr+7/M3/hEhSXBfnp/jcbe59QXGUdrpcYAgZ3wRe+Iu64CQA0pKv/7d+t1lS3v0z68BPio+bKJd4tdHOoNBRC5K440F0gGiOanROWSmar/9K3sYng59U=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by BL1PR12MB5946.namprd12.prod.outlook.com (2603:10b6:208:399::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 22:42:16 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 22:42:16 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Meng Li <Meng.Li@windriver.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "quic_uaggarwa@quicinc.com" <quic_uaggarwa@quicinc.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xu.yang_2@nxp.com" <xu.yang_2@nxp.com>
Subject: Re: [v2 PATCH] usb: dwc3: core: remove lock of otg mode during gadget
 suspend/resume to avoid deadlock
Thread-Topic: [v2 PATCH] usb: dwc3: core: remove lock of otg mode during
 gadget suspend/resume to avoid deadlock
Thread-Index: AQHawS5mXgmtPyyguEiEAyP9uNoV27HOEasAgAAHPoCAAAY9gA==
Date: Tue, 18 Jun 2024 22:42:16 +0000
Message-ID: <20240618224211.peey3dhfa2qvhpef@synopsys.com>
References: <20240618031918.2585799-1-Meng.Li@windriver.com>
 <20240618215356.hw6ar6guxbhlf5y7@synopsys.com>
 <CAOf5uwm82WzuqOHfBHLkursywfA8JNYp8RPPh+8K9DamVtyD=w@mail.gmail.com>
In-Reply-To: 
 <CAOf5uwm82WzuqOHfBHLkursywfA8JNYp8RPPh+8K9DamVtyD=w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|BL1PR12MB5946:EE_
x-ms-office365-filtering-correlation-id: ad24d9f3-2dfb-4cf1-1a10-08dc8fe7e758
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|1800799021|376011|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?TC9xVWhVdGRDNTNtUGkxMElVU2twakdxbEhkSnlMeFhBODlsb0tjMVYwb1Vu?=
 =?utf-8?B?T1dhMWtVQWlMV3FEMk12V2tNZXFpWHYyT3psSURzZ3d6OUlyeEkrd0lzNjNs?=
 =?utf-8?B?OTJZdGw0Vmo2ZDRsSEU3YmhNcG10aXFORFd1RG1FWWZ2b0NKVnpwdWd1Z1Nl?=
 =?utf-8?B?eDI0ZzJmbS84dWFDQlo1Y3R1cU82MUFjVm80M01iSjVOWklNZkpFQkNTelZE?=
 =?utf-8?B?cVNQLzRzLytqcm5BdjY0bDBDZmpjeDU2a0xvMVhVR1BhbnVWTS9ydGF3Y3dC?=
 =?utf-8?B?N1lGckhsOUF5N2Y3ZW9KdkgvTXNFZ0dkaFRNN0kvQnVlMVFTa3dhSTJqdG1E?=
 =?utf-8?B?eWg1WEhDTkhUYXRkWDIvdnI3VlJlaEVHSmsydnNOVWR6WERKUkJqVHRGd2lJ?=
 =?utf-8?B?V3Q3UDBJc1htM0x6eHBSa2l2dnJlUkNGVEN0VmxaaUpZejEvK01QOXdRbC90?=
 =?utf-8?B?eXVoTmFBNk9qTkFTbHBkVlBWMWs1OHJzQU1HUGtlTGsyaDhOczZsdzRKY1Jk?=
 =?utf-8?B?eTMvRW10ZnllMUtSZ1ZzajRCOHRXZmZzL2VJNXFtclB3Sm5MUUcxcVhBMFdG?=
 =?utf-8?B?V3pRbnZOMHVSNmxaaS9SbWI2aWZ3MU9VdXBUZmlIa1JuRVk4MUQxMjVNL3d1?=
 =?utf-8?B?Z1Z4QkcrV1Z0dU9EVlg2K0U2ZmdCNEtUSlJqdUQvdlZDTnZKdEl2OU9oTXhK?=
 =?utf-8?B?VkJ6R0R1c2ZFWXBmN25ZTEZQQ1lWL2M1WDBTNUorVE1KNXAzMUtYLzExbExi?=
 =?utf-8?B?VXU1RmVXcjBDUWpQazdaczlaK1JxNFZvalhlc3JRa1ZicElvVGh3bmlacGp6?=
 =?utf-8?B?NkIyRUhHVC9iNDE2eU5xZlA3akhVODBTOGpzRWNiZmwxYWZnUkxwVnAyanJU?=
 =?utf-8?B?Um1aM3ZsMWdDNTg5UkN1TEJKVXZ0ZG5aeU1HSVUzcDEwc0pzY3V1eTdHWXpn?=
 =?utf-8?B?QWUxdTFEdUpQWVM2dGFZV0JPTWNnalh0dmpxSFN6SEx4UlpGaEUwRnFUL1BK?=
 =?utf-8?B?d0NvUTJFWFJRdmRSbEQzN25UWkl3WG5SSUJtTGs2dkdoSVE0MXdlWXR0QlJC?=
 =?utf-8?B?c0Vidjg3YU1VNXdScWp2OFVJUWNXd1VGTjF0TTJrYUROeG1NcnRRN3UrWUE1?=
 =?utf-8?B?ekV5UGVyc1dnaFJvNk9mTWh3a3VLREl4bVFhRnJkUVJGMlA1SUVaemNELzdl?=
 =?utf-8?B?Vk95Y3JscnB3bXdMN0w1WXNLd1k2KzhGWThJNHNsNVlkdWtCY0ZVSVJibjYr?=
 =?utf-8?B?UmN6RXpYN2gwWGdhY3VxNlYwKy9NdndkbnRaNnhwb3ZBcUJwYWQrNDVOSmpU?=
 =?utf-8?B?ZjFpMEZxME5Ecm1vN1hHMUh2ei9ITHlxdm11TS9jRXc1Yy85RWtvUndxekVV?=
 =?utf-8?B?Vm1rQkRsb0dKMlRUaU1ha0VNcnJSZEVVM2JRLytVU3Q0YjNsYjlVVk1NZW5w?=
 =?utf-8?B?SnBxdzg4ZlFMUld0NXd2QTFqK3lrR1NiWk9qN2VYRXhIMnZtOWJmZC9EbHpa?=
 =?utf-8?B?OTY5YkpzaU8rS1hrMWJ6eHlrbk84RlYxejR3RDRKbGlITS9SRDdjWWc5ZmlI?=
 =?utf-8?B?V2x5VU1SRHEramdyRXdzV3hXZms4RGEyb0xjcHlQT2JteXZ3ckNFUU5mc0Jm?=
 =?utf-8?B?em1XemxjbUc2K2s3REZza1h4ZHkvdVVuL09DVHp1NGpTNkVmRTdEK1ZoQmEw?=
 =?utf-8?B?dEQ4cTBQTDRZUmlBbGNENjFCRzVRRFFlZTRoQzlsc0hYQmFUcDlkUTREcS9B?=
 =?utf-8?B?SU5taGQ0RGFDV0JWcWVMcU5GSlpDVlNEMXJiRXNoNHM5ZGlScXlPUGkxNWk0?=
 =?utf-8?Q?gbH7DjLQ0UipQEMD1uBVEZrqEDUBXEtNa6aWY=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(376011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?U2x6UW84UU5JN2J3STVUUjFYaTJNYkNqWDZnVHdJVUhvQmtjbTgzYkZwSTRY?=
 =?utf-8?B?TlhhSDFHL1FGZzNualRaa0g2amkrNlloZmtMQ0EzNXZzdk9LVFBNUll5UWpk?=
 =?utf-8?B?Mm5YMUQ0cVk3bGIzdDBoWXVpVDk3aEkrbnozalRLZk9YL3JBZmIrL2IydWp1?=
 =?utf-8?B?azl1Z3RyOGRnUTRscW4vVmRlcFZlZDlkby8zcC91NDQ2NGNYQUJjaXY0Z1N4?=
 =?utf-8?B?Yk5mcE9PK1ZNbEZqdVhEN21OSVZ6YVZrVGl2TEpVMnA2dTR1WDN5dTI2dnhu?=
 =?utf-8?B?RWFVSnE5d1RsVjFwZGhjNU1XL292QUMva3RUU1JTWmw0bllpSWNmWGJ1VDhU?=
 =?utf-8?B?NmdQei8yUUl6blNZeW0rUWNkcitXU2pQT05RNCtiRFl4UjQvcGhHblE0UHdS?=
 =?utf-8?B?bW9Qa1ZrLzRBVWZnazNRVjcvb0s3ZVhZUy81aWlGWm1OS25lTVdFOWhVZElU?=
 =?utf-8?B?dDFxVlZFbGpnS2dYNENlZ0Evb1FTVVRvQ2YxWmk5R0JjRmhjUTFtazhmZDFG?=
 =?utf-8?B?MTFVMjk5WG0rRlp4dWdVWGFtTUhXSVVHbUc3Q0xPVHM1SHAvbjc4aDhOU2Vo?=
 =?utf-8?B?UEJjQ2o2L2FtOXV2di9DRThsZ0RuWVVESGduUVRZeTVlWE5kZVJOeG5aRVVh?=
 =?utf-8?B?bmJacjZ0L3FrK0VpQ2hxM29vQmREaXJQTXpoeEMrL1Y3bHVOWWVzZmYrcjFl?=
 =?utf-8?B?RjNmZXhyMmlJZDd3RHhDMjRpaGg3b2wxblQ4amxuei9WY0s1VXlYd1JJRzky?=
 =?utf-8?B?YmVIWEI1enFPcFdBLzBMcGZYYlluT1pMMTkyN2FobmQxc3Y5S1JWVHpLQXpS?=
 =?utf-8?B?K1J2UGJvNEg1NjN0R3k1LzZJaWw2YzNnSURxT3JaUWNVRTVQaGsrTllmSUE0?=
 =?utf-8?B?SkQyWTdteS8vUGhUMTNpbEhZMEpHeUxMNHlURGpCQlUyMFZMdEhYT2xwbjhY?=
 =?utf-8?B?R05NclQ2OGRFVkR3WFNqSUhKV2Z1RjRJSm1WMXdFSXB2TnNvdWp0Vk9yTW5y?=
 =?utf-8?B?eDJkYndCS1pkdWIwVGxxR0pnL1pFV1BPOXlGSVlzcHArTE1GT1BhT1pHTGJa?=
 =?utf-8?B?Z29MQlJ3b2JUREE2a2IrRTFUM21nRExwWWlkU0lBVWFTTTU0N3RFamxmY1Qy?=
 =?utf-8?B?aWExT1NWcDA2U21vY0FwamRleGQxYXFaY3llWm1abkpjNklQZ1FnSEtaR3FT?=
 =?utf-8?B?RXQ5UGc1Z3M4ZzhzNnp3MDBla21nQ0c0NlRxUEpmdmNrcFZsQmpJL0FGNGZO?=
 =?utf-8?B?c0JXOVVpVVkwdTZNclVSWk9LUjhyTUF2dUl3RFBoM1BYMXo2d2pPU3d5ZVlO?=
 =?utf-8?B?UXJXTHlSUG1Sb252bld1SkJYbVR1OHFyMmpiMVBab2lJcWdSWFdQMDZ0aEhH?=
 =?utf-8?B?Q3ozQUxMN1QzRWZydVVlQVUxMXRENGhacEZCc2d1ZTV4c2UzWDllQTZqVCto?=
 =?utf-8?B?T25JTEdiSWd1cUF6Q2VuVzY0RTVTUGIrbWhvVXRPQndqWkc1cnl0VS9qUTNW?=
 =?utf-8?B?SFpFQjl4NHo4R1FWT3ZjNmh4UWV5WS9wQzZsbGFoMldVTktySENmNXU5YlB1?=
 =?utf-8?B?YWc4MVcwZmdONGVxRnJ6Znp5TWEvbkRLS1lsQXFGVm5lRkdSU29SNHdVNXdu?=
 =?utf-8?B?bnQ4NXd4M1ZEdkdvRUppMzNBMnZLT0lDQnVTTTJ5RzJDa0dXNGpKVXNrU1Q3?=
 =?utf-8?B?OTh4ME5FSk1NWTZDMkc2MlBKTStQR2hqUTltUVVDYUdsMzQrTEJpSUZQY2dQ?=
 =?utf-8?B?YkVVeW9FNGltQ1RDaTM3eUY3ZTdlV29tOEVxazdub0Z3LzhGajU5MjN3bTBo?=
 =?utf-8?B?UGVVMDM1TWJ4UEtDYWJZSk5SbE51cnhxaC95QngwZlZzRlJzVmE3cE1UWGFU?=
 =?utf-8?B?YTlMc1VhcHkxSWZrOVFBdU10VlloTEpUejFqcmFQdFJQanl0eG1wc0g3Wk9K?=
 =?utf-8?B?NGszMVRDb2pqaEk2VUVoMjZVaEd1bXhDMlZsUklPbG9DS25uUXBMMkFmYkxh?=
 =?utf-8?B?ZUl3UXppTk1xRzBHNHUxbkMva2xjZTRzU1UxVFphZDVyM05LV2Q3dnBjUThr?=
 =?utf-8?B?NmViSUtjdGNPZTVSWTZwajJvbW4za2NGc3VRZ3lhWUVQV0c0M09qWUM3aHlB?=
 =?utf-8?Q?nZHnV6d4aLpR2lPew46xpkL35?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD5AABAB3E01D6449F9EFA14F8AD2548@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	0nM7pT9JfPnuKNYXjrBruyvlnd67pmWqZz8eBx8/SPe8NHQfQMprxD6hjcClbrj9Doh+0sjwCyhSvt2GBBtbI+xp7rxHgzgp65sYutZwsv8Ecav1rOQjOJqk3RGod7nlG1K0o1hK1iYhYBMa1KaXKiFv7GyTBL3KV+17KXbYWvOKsgqyCtREQfZE5aSfFea2nDUcgE4y0jAACMlylXRDS+kb0oViaa6E6CnZ767ufHJsUKihZkckR3KzQ+TmWz/8AiaD2qAp34Tkpke2OLMO0N6JLHiP12Oems6qceFYw2Li63NJVUpQf7xEr06zjYkDKf6WObBLRB84FyTMrlYLnOGUOJbbtscoEaMs2VCtfadZxjdBJkiaKLcOrYybITAJmcVfczzz3e4hJ+/s8QxJtuATM72FKXUHBCx+f97w/OUYMi35NCzNgt24+ZEIjPZ7vHxFIJYHI0LAfWG6+qwtVzStrRup3kOMUn1u7eiCQ1imROO/KC08o+yq+KwIKx0+1lB0mN9VfmeXVJj1HGJWRoy+BXvJspI1BHm1OTFZYisn6GRynvRwmPYnMvtLty5KxcXndemeh773W65tzS6Tq+n0dWt76H2YXrladiW4fcUMYmeTVyvfBHdu6oHqalayZi4tcWw5Op7Mcgrjd45BvA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad24d9f3-2dfb-4cf1-1a10-08dc8fe7e758
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 22:42:16.0772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pz7O//3mVU9yeSuSLZUN8y4/C+yL/r/cPs01XPxkK0Nj8Jvnjsm5BUo5YsGot9pXlkW2KI8nk5RH3Uun5IN+wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5946
X-Proofpoint-ORIG-GUID: CBpRrVjau48bCvpxrhX1glxJxmbpY2I4
X-Proofpoint-GUID: CBpRrVjau48bCvpxrhX1glxJxmbpY2I4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_05,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 clxscore=1011
 impostorscore=0 spamscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406180167

SGksDQoNCk9uIFdlZCwgSnVuIDE5LCAyMDI0LCBNaWNoYWVsIE5henphcmVubyBUcmltYXJjaGkg
d3JvdGU6DQo+IEhpDQo+IA0KPiBPbiBUdWUsIEp1biAxOCwgMjAyNCBhdCAxMTo1NeKAr1BNIFRo
aW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBP
biBUdWUsIEp1biAxOCwgMjAyNCwgTWVuZyBMaSB3cm90ZToNCj4gPiA+IFdoZW4gY29uZmlnIENP
TkZJR19VU0JfRFdDM19EVUFMX1JPTEUgaXMgc2VsZWN0ZWQsIGFuZCB0cmlnZ2VyIHN5c3RlbQ0K
PiA+ID4gdG8gZW50ZXIgc3VzcGVuZCBzdGF0dXMgd2l0aCBiZWxvdyBjb21tYW5kOg0KPiA+ID4g
ZWNobyBtZW0gPiAvc3lzL3Bvd2VyL3N0YXRlDQo+ID4gPiBUaGVyZSB3aWxsIGJlIGEgZGVhZGxv
Y2sgaXNzdWUgb2NjdXJyaW5nLiBEZXRhaWxlZCBpbnZva2luZyBwYXRoIGFzDQo+ID4gPiBiZWxv
dzoNCj4gPiA+IGR3YzNfc3VzcGVuZF9jb21tb24oKQ0KPiA+ID4gICAgIHNwaW5fbG9ja19pcnFz
YXZlKCZkd2MtPmxvY2ssIGZsYWdzKTsgICAgICAgICAgICAgIDwtLSAxc3QNCj4gPiA+ICAgICBk
d2MzX2dhZGdldF9zdXNwZW5kKGR3Yyk7DQo+ID4gPiAgICAgICAgIGR3YzNfZ2FkZ2V0X3NvZnRf
ZGlzY29ubmVjdChkd2MpOw0KPiA+ID4gICAgICAgICAgICAgc3Bpbl9sb2NrX2lycXNhdmUoJmR3
Yy0+bG9jaywgZmxhZ3MpOyAgICAgIDwtLSAybmQNCj4gDQo+IA0KPiBJbiByZXN1bWUgcGF0aCB0
aGUgc3BpbmxvY2sgd2FzIHRha2VuIHRvbyBhbmQgSSBzZWUgdGhhdCB0aGVyZSBpcyBhIGNhbGwN
Cj4gZHdjM19nYWRnZXRfc29mdF9jb25uZWN0IHRoYXQgY2FsbCB0aGUgZHdjM19jb3JlX3NvZnRf
cmVzZXQgdGhhdCBjYW4gcG9sbA0KPiB1c2luZyBtc2xlZXAgZm9yIHRpbWUuICBJIGRvbid0IGtu
b3cgaWYgdGhpcyBpcyBhIHZhbGlkIGZpeCBidXQgc2VlbXMNCj4gZG9lcyBub3QgZml4DQo+IG9u
bHkgY29tbWl0IGM3ZWJkODE0OWVlNQ0KPiANCg0KTWVuZyBkaWQgdGFrZSB0aGUgcmVzdW1lIHBh
dGggaW50byBhY2NvdW50LiBDYW4geW91IGNsYXJpZnkgd2hhdCB5b3UNCm1lYW50IHdpdGggImRv
ZXMgbm90IGZpeCBvbmx5IGNvbW1pdCBjN2ViZDgxNDllZTUiPw0KDQpUaGFua3MsDQpUaGluaA0K
DQo+IA0KPiA+ID4gVGhpcyBpc3N1ZSBpcyBleHBvc2VkIGJ5IGNvbW1pdCBjN2ViZDgxNDllZTUg
KCJ1c2I6IGR3YzM6IGdhZGdldDogRml4DQo+ID4gPiBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2Ug
aW4gZHdjM19nYWRnZXRfc3VzcGVuZCIpIHRoYXQgcmVtb3ZlcyB0aGUgY29kZQ0KPiA+ID4gb2Yg
Y2hlY2tpbmcgd2hldGhlciBkd2MtPmdhZGdldF9kcml2ZXIgaXMgTlVMTCBvciBub3QuIEl0IGNh
dXNlcyB0aGUNCj4gPiA+IGZvbGxvd2luZyBjb2RlIGlzIGV4ZWN1dGVkIGFuZCBkZWFkbG9jayBv
Y2N1cnMgd2hlbiB0cnlpbmcgdG8gZ2V0IHRoZQ0KPiA+ID4gc3BpbmxvY2suIEluIGZhY3QsIHRo
ZSByb290IGNhdXNlIGlzIHRoZSBjb21taXQgNTI2NTM5N2Y5NDQyKCJ1c2I6IGR3YzM6DQo+ID4g
PiBSZW1vdmUgRFdDMyBsb2NraW5nIGR1cmluZyBnYWRnZXQgc3VzcGVuZC9yZXN1bWUiKSB0aGF0
IGZvcmdvdCB0byByZW1vdmUNCj4gPiA+IHRoZSBsb2NrIG9mIG90ZyBtb2RlLiBTbywgcmVtb3Zl
IHRoZSByZWR1bmRhbnQgbG9jayBvZiBvdGcgbW9kZSBkdXJpbmcNCj4gPiA+IGdhZGdldCBzdXNw
ZW5kL3Jlc3VtZS4NCj4gPiA+DQo+ID4gPiBGaXhlczogNTI2NTM5N2Y5NDQyICgidXNiOiBkd2Mz
OiBSZW1vdmUgRFdDMyBsb2NraW5nIGR1cmluZyBnYWRnZXQgc3VzcGVuZC9yZXN1bWUiKQ0KPiA+
ID4gQ2M6IFh1IFlhbmcgPHh1LnlhbmdfMkBueHAuY29tPg0KPiA+ID4gQ2M6IHN0YWJsZUB2Z2Vy
Lmtlcm5lbC5vcmcNCj4gPiA+IFNpZ25lZC1vZmYtYnk6IE1lbmcgTGkgPE1lbmcuTGlAd2luZHJp
dmVyLmNvbT4NCj4gPiA+DQo+ID4gPiAtLS0NCj4gPiA+IHYxLT52MjoNCj4gPiA+ICAtIGltcHJv
dmUgY29tbWl0IGxvZywgY29ycmVjdCB0aGUgRml4ZXMgY29tbWl0IGlkLg0KPiA+ID4NCj4gPiA+
IC0tLQ0KPiA+ID4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5jIHwgNiAtLS0tLS0NCj4gPiA+ICAx
IGZpbGUgY2hhbmdlZCwgNiBkZWxldGlvbnMoLSkNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiA+ID4g
aW5kZXggN2VlNjFhODk1MjBiLi45ZDQ3YzNhYTU3NzcgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2
ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiA+ID4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMN
Cj4gPiA+IEBAIC0yMjUwLDcgKzIyNTAsNiBAQCBzdGF0aWMgaW50IGR3YzNfY29yZV9pbml0X2Zv
cl9yZXN1bWUoc3RydWN0IGR3YzMgKmR3YykNCj4gPiA+DQo+ID4gPiAgc3RhdGljIGludCBkd2Mz
X3N1c3BlbmRfY29tbW9uKHN0cnVjdCBkd2MzICpkd2MsIHBtX21lc3NhZ2VfdCBtc2cpDQo+ID4g
PiAgew0KPiA+ID4gLSAgICAgdW5zaWduZWQgbG9uZyAgIGZsYWdzOw0KPiA+ID4gICAgICAgdTMy
IHJlZzsNCj4gPiA+ICAgICAgIGludCBpOw0KPiA+ID4NCj4gPiA+IEBAIC0yMjkzLDkgKzIyOTIs
NyBAQCBzdGF0aWMgaW50IGR3YzNfc3VzcGVuZF9jb21tb24oc3RydWN0IGR3YzMgKmR3YywgcG1f
bWVzc2FnZV90IG1zZykNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4gPiA+
DQo+ID4gPiAgICAgICAgICAgICAgIGlmIChkd2MtPmN1cnJlbnRfb3RnX3JvbGUgPT0gRFdDM19P
VEdfUk9MRV9ERVZJQ0UpIHsNCj4gPiA+IC0gICAgICAgICAgICAgICAgICAgICBzcGluX2xvY2tf
aXJxc2F2ZSgmZHdjLT5sb2NrLCBmbGFncyk7DQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAg
ZHdjM19nYWRnZXRfc3VzcGVuZChkd2MpOw0KPiA+ID4gLSAgICAgICAgICAgICAgICAgICAgIHNw
aW5fdW5sb2NrX2lycXJlc3RvcmUoJmR3Yy0+bG9jaywgZmxhZ3MpOw0KPiA+ID4gICAgICAgICAg
ICAgICAgICAgICAgIHN5bmNocm9uaXplX2lycShkd2MtPmlycV9nYWRnZXQpOw0KPiA+ID4gICAg
ICAgICAgICAgICB9DQo+ID4gPg0KPiA+ID4gQEAgLTIzMTIsNyArMjMwOSw2IEBAIHN0YXRpYyBp
bnQgZHdjM19zdXNwZW5kX2NvbW1vbihzdHJ1Y3QgZHdjMyAqZHdjLCBwbV9tZXNzYWdlX3QgbXNn
KQ0KPiA+ID4NCj4gPiA+ICBzdGF0aWMgaW50IGR3YzNfcmVzdW1lX2NvbW1vbihzdHJ1Y3QgZHdj
MyAqZHdjLCBwbV9tZXNzYWdlX3QgbXNnKQ0KPiA+ID4gIHsNCj4gPiA+IC0gICAgIHVuc2lnbmVk
IGxvbmcgICBmbGFnczsNCj4gPiA+ICAgICAgIGludCAgICAgICAgICAgICByZXQ7DQo+ID4gPiAg
ICAgICB1MzIgICAgICAgICAgICAgcmVnOw0KPiA+ID4gICAgICAgaW50ICAgICAgICAgICAgIGk7
DQo+ID4gPiBAQCAtMjM2Niw5ICsyMzYyLDcgQEAgc3RhdGljIGludCBkd2MzX3Jlc3VtZV9jb21t
b24oc3RydWN0IGR3YzMgKmR3YywgcG1fbWVzc2FnZV90IG1zZykNCj4gPiA+ICAgICAgICAgICAg
ICAgaWYgKGR3Yy0+Y3VycmVudF9vdGdfcm9sZSA9PSBEV0MzX09UR19ST0xFX0hPU1QpIHsNCj4g
PiA+ICAgICAgICAgICAgICAgICAgICAgICBkd2MzX290Z19ob3N0X2luaXQoZHdjKTsNCj4gPiA+
ICAgICAgICAgICAgICAgfSBlbHNlIGlmIChkd2MtPmN1cnJlbnRfb3RnX3JvbGUgPT0gRFdDM19P
VEdfUk9MRV9ERVZJQ0UpIHsNCj4gPiA+IC0gICAgICAgICAgICAgICAgICAgICBzcGluX2xvY2tf
aXJxc2F2ZSgmZHdjLT5sb2NrLCBmbGFncyk7DQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAg
ZHdjM19nYWRnZXRfcmVzdW1lKGR3Yyk7DQo+ID4gPiAtICAgICAgICAgICAgICAgICAgICAgc3Bp
bl91bmxvY2tfaXJxcmVzdG9yZSgmZHdjLT5sb2NrLCBmbGFncyk7DQo+ID4gPiAgICAgICAgICAg
ICAgIH0NCj4gPiA+DQo+ID4gPiAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+ID4gLS0NCj4gPiA+
IDIuMzQuMQ0KPiA+ID4NCj4gPg0KPiA+IERpZCB5b3UgdXNlICJnaXQgZm9ybWF0LXBhdGNoIC12
Ij8gVGhlICRzdWJqZWN0IHZlcnNpb24gcHJlZml4IG9yZGVyIGlzDQo+ID4gZGlmZmVyZW50LiBJ
biBhbnkgY2FzZSwNCj4gPg0KPiA+IEFja2VkLWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXll
bkBzeW5vcHN5cy5jb20+DQo+ID4NCj4gPiBUaGFua3MsDQo+ID4gVGhpbmg=

