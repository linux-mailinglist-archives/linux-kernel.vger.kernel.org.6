Return-Path: <linux-kernel+bounces-414997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A4C9D305B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 23:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9C07283CB3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 22:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753B21D0786;
	Tue, 19 Nov 2024 22:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="K5EyyXQz";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="O0cL/JNg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="LTxiamRe"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A27A1482F3;
	Tue, 19 Nov 2024 22:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732054775; cv=fail; b=ZR8eeoL0ZNGRjKbwIBv2S4cOI9rHcjZTyNl1l/feste9oFB7+zT5Hy7CaAk5cCg0hNQoD1AFBsWcqlVrlbVNiQDzrB+K7XMyItJIIQKJLJTLbVEX5D25cVpcXd8t1MMjbGshj2WtdvstA9bQeiZFI8mOAHHQ3ZjzotX6WAYO6Ig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732054775; c=relaxed/simple;
	bh=xf+Iwetke45ElQn5aIJcPAmhJMkfw8Pd6Kvf0gDKz1g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TgqS95EDvNRAvkDflJqKOPFb7XeKpNbhekcRLe5UcuDosRNOBZ0cybsjIaqsCZrd0jf57qnmJobtoUFkblBxzcxMfpejc5Pap7CjY0xbxKpgMEb+hCP+gl0cUyd0xci+9kWk/aXQGMZhewnCnTK1PENGt4wqOGM5ubsAthsFDVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=K5EyyXQz; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=O0cL/JNg; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=LTxiamRe reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJFF8Gr006425;
	Tue, 19 Nov 2024 14:19:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=xf+Iwetke45ElQn5aIJcPAmhJMkfw8Pd6Kvf0gDKz1g=; b=
	K5EyyXQztnwaD8wEMvou5j8ObAjbELgflfDQ9NeUzgJDbBofGfhENpX77xINkZ+H
	ntrc6Q+t9WwHtTveLWMmhm7ef6pbyo4d44lctnPo3kLdZqWzty3J6x+HZhW/K9LX
	/dVrz+blDWv+d4DLDK0R22yj/mo7JBze6coaAXYeJ7o5sFAU2wBHLWZmWt/S1rGH
	IUag0g60fegD8ts61eKhzyDV/JO8DvAyRwrLW2+s7Odw1o74Bc7LHr9e5ANx4Mqh
	ZhT/cSXj0+8U/wxZo1cHvV0AisuT9E8YS2TUZJjea/fCRpZpNada0LTUiQx+agJ4
	uKQk3dJiwyrFb11UJDVh0g==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 42xu9sfa54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 14:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1732054764; bh=xf+Iwetke45ElQn5aIJcPAmhJMkfw8Pd6Kvf0gDKz1g=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=O0cL/JNg3JQYT0lDxgfCUNAlnswOVnoY7VLQlzAbYYFaGmoL2WsdeiNDOecirqOHm
	 Yb4GHLo2a2kH/p09Xmdc2RUPPiqJMxtQuyavgm79X3uuKDKYwNvTN8QEisn/Xxsret
	 +qZRVEim2lKxAF8W6BdT6nhgZqaV1qj4U0DBnHY1uhYmX8GAueOieS95IpiNrrD8HO
	 LtX2jJuh5tULdBzD9umZcW+1Q4rpuWhDYGZDJC5MZnjkAroILcRnhq60I/R5Bnk4hm
	 S7y/VxSlDg9sISxMyssQo1/7KlL6OgxcUrmBf/nLtlkePSd82lIXz9r5HzO1xSwpR2
	 DVetp7760TLwg==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 908CD401F2;
	Tue, 19 Nov 2024 22:19:23 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 5F297A008D;
	Tue, 19 Nov 2024 22:19:23 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=LTxiamRe;
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id BA7344059E;
	Tue, 19 Nov 2024 22:19:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LxY03rWfD9dW9oCSrc4MQJ50qdXwPWcz75ZLV2t3aqZ/FNVG04/F6UrxdKIttAZVzh6iS3EkL/jIQuqBvZgrZEsklqtNBeff97LWaImV4CnQs7Yhs3JVqtPh/akK+6COrqUWL+FqZqy0VG6xGtWrr/gh+M9pVGHnjuGgU16DgF1WGNaku8w4HZwRKYdrk2X26nHSreB3cltnNOhX9O8FU44OQ4UX3iWRi5dRQ3CigSdbg6u4VgwWGp4XY223mJdwNotICj3fHMBfRWloFH2eEeQ0Cpyxremwt1eI0AvtKQ40XIkLrc/+KKrla87Waim87sQY5w2zVMBmePi0bSh3tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xf+Iwetke45ElQn5aIJcPAmhJMkfw8Pd6Kvf0gDKz1g=;
 b=Oyof+GsAsjiUelVaMAmFgWz5ODsMxlDYhuz8KYWu0zkLtht+3Y2+A3/u9+Vj6rD61jJECg6UxI0QUwon1cGXNc4qAigiXv1bnmSdtq2Z1zs5S4QkcPm1kIShEzGSsI6JPjzT331a3O71iz29vNbOU3t8QXI0cmLoEcah1qAEUJmjAwCz5v5FAvlOILHCqOM/24D3e7ScMFdmD4Gkjdk7pzZNK82sWuodzFmha+eBZLHS2GkN6ji0zeAUJmgHRaxESRtCFsTdc5uyGpvhjEWYCySLKR2RcL3T3g6fj8qnOxINm4HcIYBXWwqXJasi7yRuv2YlgpxixywsLFMAfw3DAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xf+Iwetke45ElQn5aIJcPAmhJMkfw8Pd6Kvf0gDKz1g=;
 b=LTxiamRe9gihmagFnemq6MiG2lfOrxUuoXLHAHKgZzKbGr3zw4MI5JWl+PfCLq2Xltbv4DCEDKmOC/S0C/2xz5fLe9m2rKCyVCMLGwjLGDM3Vc/xDWFfNLxI4pR9x2SQy9BbcNmaoma72UInIMYJVVlBGbfSmUyt26jeA+BBEyU=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by PH8PR12MB6745.namprd12.prod.outlook.com (2603:10b6:510:1c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14; Tue, 19 Nov
 2024 22:19:10 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.8182.013; Tue, 19 Nov 2024
 22:19:09 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rbm@suse.com" <rbm@suse.com>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel-mentees@lists.linuxfoundation.org" <linux-kernel-mentees@lists.linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] usb: dwc3: remove unused sg struct member
Thread-Topic: [PATCH v3] usb: dwc3: remove unused sg struct member
Thread-Index: AQHbOsl+EpZaJ04hNke3TF3/puTD/bK/LIaA
Date: Tue, 19 Nov 2024 22:19:09 +0000
Message-ID: <20241119221907.tyt4luboduaymukl@synopsys.com>
References: <20241119212452.269255-1-luis.hernandez093@gmail.com>
In-Reply-To: <20241119212452.269255-1-luis.hernandez093@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|PH8PR12MB6745:EE_
x-ms-office365-filtering-correlation-id: 0a2eaeaa-560b-4b49-c57c-08dd08e83085
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?d0IwZ0lYZUVROStDNDU1WEl0T1g3VUJBbGM5aUZZV2h1V2hZUnJJTXJheitt?=
 =?utf-8?B?TEV1dEVma2lhVXozdjVyY0tYdGcwZlVZbngyc1doWlU3dyt3Nis2enJyRWFR?=
 =?utf-8?B?dW1lUVRjUzJrc2E0OXc5c3hhTVFmUDJHd0lUeFZOZC9ibTA1OWp0NGdEc2tY?=
 =?utf-8?B?VlFNMktjT20xS1h5QlpwT2N6b1hNK0V2N3RwbDFtMlA5NERPaWhnb2N1TE1R?=
 =?utf-8?B?NmZabHB4WGFzeDlMMEFkWURRR3NiWmJPRXJnMTVjWTNnUXlESjJjVkxBT25C?=
 =?utf-8?B?NUZUc3h3dlM4V2FUOG11QVJDZHFIVzBlekdBMnExenhYVjhqM29tTVdLUkpX?=
 =?utf-8?B?d0o5MzdnTmhydzR5b0MvSHRmQS9BeHR1Q0FaQlNtWmE0c1RwMXJpY25IZnFE?=
 =?utf-8?B?TUVwK0VDdnhGdXVCbnd5a08rdVNIRkE1Um9UWEJBSHZKZUMxOFB2ZmoxZ0hw?=
 =?utf-8?B?c1JQUFRrb1JaTGMxaUNnSjU4TmFSWEt2QWxEWWhEZHZkYTM4ZTZTMkxBY2ln?=
 =?utf-8?B?NnVaWHEyc0xNV0QzWWtUaE5qNE93R2tjcUdESGFUT2xrbVZ3UDFha2dhcEFi?=
 =?utf-8?B?TVU2eTdBcnhxTHprUDIvSzRZdFdBclZYSm9IVkV4dFZDVjl6eCtDZzlwTzls?=
 =?utf-8?B?R01heCtFb3JiRldYTmFZQllvTkZmMUhFbnE4anBKczZjNVR4T01QWE4vZTVo?=
 =?utf-8?B?VTZ0VXZlc0EzZWFLb2VKQjdrMmVpMlpxdWEvcTRuc0lGNXhHSjNQUzdqcnRi?=
 =?utf-8?B?SDY4ZWxjTHNMYVdmQ1gvb251TVBJcHczaTRGbmZvK01QZUhuTTZSb2dzakJF?=
 =?utf-8?B?dnB2WmpmVzlHNlY1Tk1meGNhWURFRVhEeEtMbm5CY1lBVnNBOFpjeXRhcGhJ?=
 =?utf-8?B?TTNYeUpuTjZSbVU4ZVMvTnR1VnZHbldROE9yN0c0aFI0cllqUWlPcFZRTkwy?=
 =?utf-8?B?QmFPR1B5ejJzQUNLQVBEdXhERC9sZXhDYUtWcTFDdGRHb00rNzM4ci9QV0s0?=
 =?utf-8?B?OVJFNldzVGcwQlpIejdveFJaTHFtVWJWZVRUNXM4QThxQ3RkaWF1MGNTdTI4?=
 =?utf-8?B?UjBJRnQzQlRHMHJzMHJoemw1WGg4SWtjZmFGSzlLTWhuRFhXWWlyaHo5NzVl?=
 =?utf-8?B?aWpXSi96Yng5OU16VzZBNXM5bmM0SGoyOFpMUXNvaytiOG82VXM4TGF5bDBs?=
 =?utf-8?B?N3Z5L0lUNjluTjdmTnFUU1hDZ2RnZEMrbFR6d29pRDRzbDFxOGdQcjB3T0I5?=
 =?utf-8?B?TkxaMm52U2pGT3ovMEsxZnJHRjdKRG83ZjBrRnkvRUFXUEQzcjVxSFVHLzNO?=
 =?utf-8?B?NDR2disxN2NSOTlqb0V1TjRoS1RpVTRkVzMrVHUyY1EyTmk4b2FtK0RJZ08x?=
 =?utf-8?B?QmdrUTBLSkNnQS9SMmJlVXdvSnhsdVdYSmdFTXFRNmlsTWVRZnlUS1NRWElR?=
 =?utf-8?B?cTRzSFRrdnQzanFib1Q3eTJiUjdvQXJQWWJleVc5amtJS1kwbjFzdVBXUm1U?=
 =?utf-8?B?QnNzczhIS1FrazkvM0RqUU5ZeUpqZnluOWdJd2c5RWRZTk1ETjRFaHRSenBy?=
 =?utf-8?B?dWNvV1E1dzFuNlFaaWtEaXpMSWltQmx3RkpvaFRnemZlSGZ5V0VzdzJibFJp?=
 =?utf-8?B?L1QzLzNTbkJkYXdwb0JrUWJ5ZUhERVp4L3pDU0Y1YXlEWjNvSmpxaG5TNi9s?=
 =?utf-8?B?cERPQk10aElQR0FWbEpEQ1lCZHlJdHNiZmpKNmozQzZsTE1qeHZ5cUxqMi82?=
 =?utf-8?B?WEF6eDVwdmUxek1ZdFVkQUUwRXBQdms4RkJzV1lVaE5kTkt5N21mWFA4WjV4?=
 =?utf-8?B?eDFicnZ6VzhSWnc3dXdSNVMrUFUxVHhTd2N4MTlrc1N0MEU0MnNXdEFXZ0lz?=
 =?utf-8?Q?myUnrFuZHo7hb?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y3I2V21BRUJZaFJXU2hMdjdhelFlVnZiNTI5NW8vdkJhQU0zaFdNWGU1Zm1v?=
 =?utf-8?B?SUNpQkkvZCtrY1prVG5JYzZsZUd6WnBkcjRpVDA5RXp5bmQvYkVXYlhWVUtN?=
 =?utf-8?B?czJ1WG5VZEF1dFJGTFJaZVlud0ROamR3UlJhSWZ0ZmV5cVVzRStTcENlUVhs?=
 =?utf-8?B?eGZROExkaHBSVmdSVUxDSStOQ3VYa1R5NXdSdnJuSjBrTDJnTjg3c1h1WDNz?=
 =?utf-8?B?MUwvRDhYclpRbm9vMlh0SXBKMHBUL2JvazhqOWRiU09DNDhlUUdCMmdzYVNI?=
 =?utf-8?B?Yy84TmhGcUwwQ2NUeTYvL2FNTEJIaVNKZnNwSWhDb081R0o5VkRmL3pydUx1?=
 =?utf-8?B?QlhqRVVCMUtNMExmaytzSWgvdFhkNDVNdjhhZUE2WjVzYStNamNSbTZjb0dW?=
 =?utf-8?B?ZlRiUUt6bCtvS1ZpNUlqRjdhb3htTkxXSGZ3RFJkdjVrRjNsNWpuL3dGYzhY?=
 =?utf-8?B?cUMzZ3ZVUjBFTy9ORE1PYllIMVdTTWdJa0syb3RqSE94Uk1Zd3FUdHhQYUJr?=
 =?utf-8?B?OUNFNTJ0dzNPR2dsektqbk45dklMRFloSFZhdkMyYitFSmxEQzkrOVdLZ0tX?=
 =?utf-8?B?MVZ6QS9uVVVUTjAxMUhpMll4MEVUSThMaTR2d25uRWNDdy9WL0w3ditLR0lG?=
 =?utf-8?B?YTdhQTFQeFdmalRPNGdhN0JHWStuRmZQaXkwMjRNenJ6b1pLYWNMbGx5aDl3?=
 =?utf-8?B?OVdrSXA2NmNiMXExeG1lRmpkSlhBS3k5OHpIL0NNQ1lrTGtKVEdBV3pJd2FD?=
 =?utf-8?B?QzdhN3BON01uTEIzMFpWbVFIT1FOYytwYkRFdjdITktLN2ROYzM4V3FwTWsy?=
 =?utf-8?B?N2Q1cWpRZi9vSXdEN1RxaWJpaXJ1QW9Vbis0Ly9CYzFqT0pGV1R5MUQ5T2lB?=
 =?utf-8?B?VWNkV2U5K3RXY3JFdmRNcFFsUDN2MWlBeHJsd1pKblFsQmxIRmRzRjdsSzRj?=
 =?utf-8?B?T3NNM2FBMk8xOHU3dXpxSTltaUdjVk55L2I5QVFTZVhMdjBFVUdsMkx6ZjAv?=
 =?utf-8?B?WENtRE1naThXK3ZPMW0xbWVRMGYyR3d1MWZvYmVFZXJMaDJTQTljak5FOTNw?=
 =?utf-8?B?bUo0dUlmV2d3QkdlWWlkKzFmM3Q4VGRYSVpJM2xvdmV5dmt2bEo0bkUvVC9K?=
 =?utf-8?B?MVlrWEpPS3lCV1N5cnozTi9ZQkNZN0VYblc2Q05uTTJ2NjhJOWQ3SzNCOVNw?=
 =?utf-8?B?S2ZDL3BPeTV1NTJHVEFiQkFBTXlxNk9zZjRpbS9HWWdna2Rsd3RLODU5T243?=
 =?utf-8?B?Y1ZQVjNLS0ZVMFBUZ2ZjWFpiUHd1NytoT2diS1RGcE1id285blBMZGhjaWtO?=
 =?utf-8?B?cmFBT3NCSGZhc1FPWmtIVkJEMkNsRXpxZW1NcVQ1S1F6SDVWcGdFd3ozQlE2?=
 =?utf-8?B?d3BZUzFrL21iMnczQVZob3V1ZitPWngyR1lMYzRJUmpwOUEvL0ZlQkVBSFk4?=
 =?utf-8?B?bERyWGI2SGtDck1JaVdvWTRVajEyTEgwdkxLWGNla0JHRFJOZGZHUTRaaXEv?=
 =?utf-8?B?bm1DeGFzWHNKOHdrbkpIY3h5Zkg1ZW5yTDVkc3lveEZVTTRTSEtGKzZZU0Na?=
 =?utf-8?B?TjViNDBUMFhLbi9jbGdndndoVzRvUERMb3VoUWZNcllMUHByaldPMHJCVkZP?=
 =?utf-8?B?ZVFEenRWNmpOeG44MlpuakVWQUtWMDAzTzRzSTlWN2xPQkw5R0xNUGI5TS9F?=
 =?utf-8?B?cVhpOG90RUJCMkwyVWxlVHFldGpXUU5LRldscHlCOU51R01zRHNtbGlRTEp6?=
 =?utf-8?B?SFZKdjBtVXU3czgzcWJQL2VGdVRLM0Y2YWozOVFmNVdiWmhOYzZFTGJpTkhY?=
 =?utf-8?B?NlQveTdiUWgrL05WQkxxWDhyVUtOYnoxeHdadE1sdlZnRVc0TGMzb2d6TGFp?=
 =?utf-8?B?S0draUo2WkUxWkwyeUc4MEJRSk5PSXI4VGErbjdqZExKWDhjaVpUR3E0VGJ5?=
 =?utf-8?B?cWRUbVVuZ21tODgyUGExRUR0WXJ5SkIwRURmejVLeWtQdzc4QUt2Z1Y5V1lS?=
 =?utf-8?B?dUV0dHF5L3I5TTZIMVRTUWM2dmVaZGdXUlYwZXNRNzdzWUJIbG5ZZ3p2SEZu?=
 =?utf-8?B?cEQ5WTJNa1pFa1R2NER3MWxJSTBEaXhnTWFjTzZDMUdCN1VzNGRRYWtuYWRx?=
 =?utf-8?Q?qzCU/46ZhIEidJXgi7eI0fvrH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3B8911E9757BD548B0F786A533CDED34@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	v+S+OZ6VYFn5BIxU9sHRhCkgwx5RIWX1z2d4wsunlQWej/rSFQEjwwFMJcjU/Bc0IM7H4WAPF1DOJG4JGkGu5fHqFZIvINIhOhnsWIoT2yRCjsbtQxHQ3kfY1d4H5mXtPKRtwUSiBt0ZBISdtJMg6x+lFOx2VwwfVlCyjiMfZjjH4n3GG0dgEqzo+na+6aC75CNM/gt5ZoLWl8lyOU57wsikgG7bcUT3P/ygaVtqCqXhsU8m9oqMkYMUshBTNEzKtPFzHT4Tuajo6yZ7bMxPvSzIeIlnuzoCObmzxJ3+yQum1Cn+1KwP12frVNiGoBZUaMyQa9tgFvO+irGUGsbTwa7hfz9/PliC/dIiTKgj7/wHEeq1n9Cxd5IXxxH6c0KTG1GdvSpUrQBezYW7RFtdDUtnz+pRuZD50muPHdmmmfvJnnr7aOLgyMkaVS8GIOzyXsBG0m3VaGYRo3JeHbyrXsSeNagi/CR/EM91E1pREK8LjR38KdTxpL5XVfzKmCQgdwicLNv307L9DJrKQ2ypvrJ5eCGe3Mkz8vzz/VemhLj77zZB3Ix3Axnyhkkfksgw61Mwz0Z2lnfOONZJb45D8vrRm5BkE8G8m1TpxZgj+hHmWnFmY0pfLVPAod3qQVZHr+8DslAAiFvKh0+SN9eJCQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a2eaeaa-560b-4b49-c57c-08dd08e83085
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 22:19:09.5885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OWTwd2NBJHzUMxDTKQzR0PqlD4z4ZKrpc0tmu1MIgdqyCelSzP7ltzU7eig+RJQ2isk7v/DmO5djqRyesjVUow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6745
X-Proofpoint-GUID: epgkOF7Y9v7UtQI5LRTaR7JGfZiD-V9-
X-Proofpoint-ORIG-GUID: epgkOF7Y9v7UtQI5LRTaR7JGfZiD-V9-
X-Authority-Analysis: v=2.4 cv=UvkxNPwB c=1 sm=1 tr=0 ts=673d0eec cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VlfZXiiP6vEA:10 a=nEwiWwFL_bsA:10 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=rOUgymgbAAAA:8 a=jIQo8A4GAAAA:8 a=pGLkceISAAAA:8 a=iox4zFpeAAAA:8 a=bqBgBGnUnpavYY4Ne3MA:9 a=QEXdDO2ut3YA:10 a=MP9ZtiD8KjrkvI0BhSjB:22 a=Lf5xNeLK5dgiOs8hzIjU:22
 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 priorityscore=1501 clxscore=1011 mlxlogscore=979 suspectscore=0 mlxscore=0
 spamscore=0 malwarescore=0 impostorscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411190162

T24gVHVlLCBOb3YgMTksIDIwMjQsIEx1aXMgRmVsaXBlIEhlcm5hbmRleiB3cm90ZToNCj4gVGhl
IHNnIG1lbWJlciBvZiB0aGUgZHdjM19yZXF1ZXN0IHN0cnVjdCBpcyBubyBsb25nZXIgdXNlZCBh
bmQgc2hvdWxkIGJlDQo+IHJlbW92ZWQuIFRoaXMgcGF0Y2ggZHJvcHMgdGhlIHVudXNlZCBtZW1i
ZXIsIGNsZWFuaW5nIHVwIHRoZSBzdHJ1Y3QuDQo+IA0KPiBQcmV2aW91c2x5LCB0aGlzIHBhdGNo
IGFkZHJlc3NlZCBhIGRvY3VtZW50YXRpb24gd2FybmluZyBjYXVzZWQgYnkgdGhlDQoNClJlbW92
ZSB0aGlzIHBhcmFncmFwaC4gVGhpcyBjb250ZXh0IG9ubHkgbWFrZXMgc2Vuc2UgaW4gdGhpcyB0
aHJlYWQNCndoZXJlIHRoZSBwcmV2aW91cyBwYXRjaCB2ZXJzaW9uIGlzIHZpc2libGUuDQoNCj4g
bWlzc2luZyBkZXNjcmlwdGlvbiBmb3IgdGhlIHNnIG1lbWJlci4gSG93ZXZlciwgdXBvbiByZXZp
ZXcsDQo+IGl0IHdhcyBkZXRlcm1pbmVkIHRoYXQgdGhlIG1lbWJlciBpdHNlbGYgaXMgZGVwcmVj
YXRlZCBhbmQgY2FuIGJlIHJlbW92ZWQNCj4gZW50aXJlbHkuDQo+IA0KPiBUaGlzIGNoYW5nZSBp
bXByb3ZlcyBjb2RlIGNsYXJpdHkgYW5kIGF2b2lkcyBtYWludGFpbmluZyB1bm5lY2Vzc2FyeSBt
ZW1iZXJzDQo+IGluIHRoZSBzdHJ1Y3R1cmUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBMdWlzIEZl
bGlwZSBIZXJuYW5kZXogPGx1aXMuaGVybmFuZGV6MDkzQGdtYWlsLmNvbT4NCj4gUmVwb3J0ZWQt
Ynk6IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT4NCg0KSSdtIG5vdCB0
aGUgb25lIHdobyBzaG91bGQgYmUgYXR0cmlidXRlZCB0byBieSB0aGUgUmVwb3J0ZWQtYnkgdGFn
Lg0KDQpJIHRoaW5rIEdyZWcgd2FzIGFsbHVkaW5nIHRvIHRoaXMgcmVwb3J0IGJ5IFN0ZXBoZW4g
Um90aHdlbGw6DQpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNDExMTgxOTQwMDYuNzdj
N2IxMjZAY2FuYi5hdXVnLm9yZy5hdS8NCg0KSXQgd2Fzbid0IENjIHRvIHRoZSBsaW51eC11c2Ig
bGlzdCwgc28gSSdtIG5vdCBzdXJlIGlmIHlvdSd2ZSBzZWVuIGl0Lg0KSWYgeW91ciBjaGFuZ2Ug
d2FzIGJhc2Ugb24gdGhlIHJlcG9ydCBhYm92ZSwgdGhlbiB5b3UgY2FuIHVwZGF0ZSB0aGUNClJl
cG9ydGVkLWJ5IHRhZyBhY2NvcmRpbmdseS4NCg0KDQo+IFJldmlld2VkLWJ5OiBSaWNhcmRvIE1h
cmxpZXJlIDxyYm1Ac3VzZS5jb20+DQo+IC0tLQ0KPiB2MjogcmVtb3ZlIHVudXNlZCBzZyBzdHJ1
Y3QgbWVtYmVyIGFzIHBlciByZXZpZXdbMV0NCj4gdjM6IA0KPiAgIC0gQWRkIHJlcG9ydGVkLWJ5
IHRhZyBhcyBwZXIgcmV2aWV3IFsyXQ0KPiAgIC0gQ2Fycnkgb3ZlciByZXZpZXdlZC1ieSB0YWcg
ZnJvbSB2MiBbM10NCj4gICAtIFVwZGF0ZSBjb21taXQgc3ViamVjdCB0byByZWZsZWN0IG1haW50
YWluZXJzDQo+ICAgLSBVcGRhdGUgY29tbWl0IG1lc3NhZ2UgdG8gcmVmbGVjdCBhY3R1YWwgY2hh
bmdlIGdhdGhlcmVkIGZyb20gDQo+ICAgICBUaGluaCBOZ3V5ZW4ncyBmZWVkYmFjaw0KPiANCj4g
WzFdIGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2xvcmUua2VybmVsLm9yZy9h
bGwvMjAyNDExMTkwMjA4MDcuY243dWd4bmhia3F3cnIyYkBzeW5vcHN5cy5jb20vX187ISFBNEYy
UjlHX3BnIWNiRW5EbVdOOV9WekhVQW90QjhoTUNFbTlqbkswRjFTd3R2REgtVHM0dWljV2xQVWlm
NTlGUGtaV3pDelJCY0ZIMDViaGRhbndYaEFQcnlkYWRjOUl0T0pXVHBUU3JzJCANCj4gWzJdIGh0
dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAy
NDExMTkyMi1wYW50eWhvc2UtcGFub3JhbWEtNmYxNkBncmVna2gvX187ISFBNEYyUjlHX3BnIWNi
RW5EbVdOOV9WekhVQW90QjhoTUNFbTlqbkswRjFTd3R2REgtVHM0dWljV2xQVWlmNTlGUGtaV3pD
elJCY0ZIMDViaGRhbndYaEFQcnlkYWRjOUl0T0pHQnU4a3NVJCANCj4gWzNdIGh0dHBzOi8vdXJs
ZGVmZW5zZS5jb20vdjMvX19odHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvNWw2NXNkc2tkemJl
aHhhbWZmNWF4NHB0aXFoYXhoN2V3aTR1bXRwcDZ5bmVuNDVuajZAbmVidXhqZzRjNHJ4L19fOyEh
QTRGMlI5R19wZyFjYkVuRG1XTjlfVnpIVUFvdEI4aE1DRW05am5LMEYxU3d0dkRILVRzNHVpY1ds
UFVpZjU5RlBrWld6Q3pSQmNGSDA1YmhkYW53WGhBUHJ5ZGFkYzlJdE9KNW5rd0QtSSQgDQo+IC0t
LQ0KPiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmggfCAxIC0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAx
IGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgg
Yi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiBpbmRleCBlZTczNzg5MzI2YmMuLjNiZTA2OWM0
NTIwZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gKysrIGIvZHJp
dmVycy91c2IvZHdjMy9jb3JlLmgNCj4gQEAgLTk1Niw3ICs5NTYsNiBAQCBzdHJ1Y3QgZHdjM19y
ZXF1ZXN0IHsNCj4gIAlzdHJ1Y3QgdXNiX3JlcXVlc3QJcmVxdWVzdDsNCj4gIAlzdHJ1Y3QgbGlz
dF9oZWFkCWxpc3Q7DQo+ICAJc3RydWN0IGR3YzNfZXAJCSpkZXA7DQo+IC0Jc3RydWN0IHNjYXR0
ZXJsaXN0CSpzZzsNCj4gIAlzdHJ1Y3Qgc2NhdHRlcmxpc3QJKnN0YXJ0X3NnOw0KPiAgDQo+ICAJ
dW5zaWduZWQgaW50CQludW1fcGVuZGluZ19zZ3M7DQo+IC0tIA0KPiAyLjQ3LjANCj4gDQoNClRo
ZSByZXN0IGxvb2tzIGdvb2QuDQoNClRoYW5rcywNClRoaW5o

