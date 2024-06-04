Return-Path: <linux-kernel+bounces-201528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3708FBF93
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 01:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7F5A1F233D2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 23:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE7B14D2BB;
	Tue,  4 Jun 2024 23:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Si+HOdkp";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="OFogdKxD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="dFub6M2A"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2296414C5AE;
	Tue,  4 Jun 2024 23:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717542405; cv=fail; b=lYdSQruPkm3HxkcfxaHyHVXr4ZPWmwkkZ/OggqssWp3P8m0gRw79nL4Zj9SQe9riLH7tsQyQLYIBN80bBHfrLvrgiKIJNTqP+W2ylYnysv9UMZ/WUPK8WLu57oKtiBdXY8GOMMUz7ZgUVXW5O6xkpm8NdPSVzLt4qN+jvv+8RHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717542405; c=relaxed/simple;
	bh=CaGev8VmAzmftdhdaZvb3z0+OJdCg8kc94vD+dVaXUE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TFQyiktPew0dOUXFnNzJ+eClaZrnmNGbZt37u7XhsNecGRKbRvuhurdejI5Y3K65P4mK6YJAMyaDJtzRP466/ve24OMISEFCqMr17/SbFXzTyna7XaHbtqemEnOZ322H88BeAJ+6LJ4JvDuYK2ScQxG3T2dSwnhKmFodNlpNYIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Si+HOdkp; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=OFogdKxD; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=dFub6M2A reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 454LbU2P014133;
	Tue, 4 Jun 2024 16:06:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=CaGev8VmAzmftdhdaZvb3z0+OJdCg8kc94vD+dVaXUE=; b=
	Si+HOdkpaNXUFqaQNpXM3KiQDlHYOVOZzhF2a5ZwFBGCNM2WNm+fivMZyMNzFTMR
	PmNXFc5cbSpD7FCGBur/pgIoLa8XHBlBtF9/YSDrkk5V4V3MaxbDoOQmnuZ3kvjw
	Mc6NMp0IF2Zj+HEOBDpWXZlJ4i4n8vluG9uACThCSLq27sUI9NEOCbPmoSwRwLmN
	VLkFMsGNyCqM8tOla+TMFgb/zXa7/qUreAEflS4ZiTa4RRuCpDRWpZayoqDc1NTE
	2c+8nT6cr/Kzc/3X5NvtfEruZrizu6pRA2LwLv9amoqJtSR4pU0wo5Xobbr2GQtC
	TG7qhuH5AEBnP0NYdNMgoA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3yg2njebb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 16:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1717542397; bh=CaGev8VmAzmftdhdaZvb3z0+OJdCg8kc94vD+dVaXUE=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=OFogdKxDuwuS7bFFTDBr4sub+3wHFWxW+nMuOcOaTUm21V8DUCuIKEWtsYfMxpz1M
	 0ogR4pFh10EvcC0idZtQ5WjAPI5vExzoWIFMgjFx6m5go8JbtQY1znAsLWLMAdgILb
	 mdGMBy696xuQXLjJl8OYVb0jlevAy4X7+oaFJQuWUMqrbtnImWK8+tyFhE0ixUBnFC
	 q6EshMs8EsxkJ2FjtpFUBdUqWOcXImo1DCsj9OY1lU2GWZD2AcTsL7OvO7FL6vXm1U
	 Blmb82xGmNL0i1HUcG5o0xvhzif8+ngFEIMjBSEA7t8lGxLKbLIPJuMrtHPGiijM9i
	 nqUlwcbbWSXSQ==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 598C74044C;
	Tue,  4 Jun 2024 23:06:36 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id B3883A00AC;
	Tue,  4 Jun 2024 23:06:35 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=dFub6M2A;
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 089EA40360;
	Tue,  4 Jun 2024 23:06:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJZ+XVwrCKu5uHkNvzE8OCQsrs3JC29LqBNpA3V9+bhAhk4mgm+b1rVuvnBu8s8nIpoyU+FLlai9jMj/4AKbokJPrCqDxJUy7XrSUmUmuV3XdSxmQgHpNSWBtlj0Z0cAOP4UDjcLNgDa9mZ+xJuosuVjF/Xckk1ggu/ue+z9N1wn655DuBqFmsgReJYG419upE09Qe61My4J8VIIbf1BDaXltv/NpugeRYN4CYHo8p/Q8t8wWDhSDVGT5j2noD18DPCYghZ6EbBK5sKAR6aHsbi5yXoj16fzZVHYCvC/OUm51KHcAXI+qP1uEO4nTUurH+EgyMf3bNW+a2mpU3kiwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CaGev8VmAzmftdhdaZvb3z0+OJdCg8kc94vD+dVaXUE=;
 b=jVcxW3LgTYwlEvOEehCudjwNrUYhFc0RTtDE744mwhDyvHklVSH4MwO9qMIaY10y66R3vMyQA3GkZtVerMq1W3Bl9XALu0G7IDPi7zh+34H8xET+CIal9S8bIeInNXRcsriSjLO15hd3Uz9/zCMXLjjcu/Sa6dMA7FzuNYn5y4Gpdwr/cadqj9KUEiWZgy3FBRoIOqas2ZMcVI+0VT5kRuHMsw8HkstixiTrdhBi+I1bbAI6OYumh575fiPU30omX8uvQ9O6AYInHQ2Ov/Bw5nUEdF2TOMUuifLZzxmsw4aiX7QqAlZOF3o361AUGg+7fDlw4cOILmWSJxsrmpAZFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CaGev8VmAzmftdhdaZvb3z0+OJdCg8kc94vD+dVaXUE=;
 b=dFub6M2ATSZyvWSQ4ePa6B7Nw6RS64dBgz6egLnuEWH9UC0yTGm1Sf1JrmkZX6aErkT8Maw7Gc6Tz+LdzLvFtY2bjeA0bzsTxq5/dEOa/tW5NFivYaJWnFaNPwrWHqepU+jZJ0I93OkKrpfb8dLTfoSlusx6XCz2vyxAyBYudJU=
Received: from DS7PR12MB5984.namprd12.prod.outlook.com (2603:10b6:8:7f::18) by
 CH3PR12MB8484.namprd12.prod.outlook.com (2603:10b6:610:158::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.22; Tue, 4 Jun 2024 23:06:30 +0000
Received: from DS7PR12MB5984.namprd12.prod.outlook.com
 ([fe80::e2e0:bc6d:711f:eeb]) by DS7PR12MB5984.namprd12.prod.outlook.com
 ([fe80::e2e0:bc6d:711f:eeb%5]) with mapi id 15.20.7611.030; Tue, 4 Jun 2024
 23:06:30 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Mike Looijmans <mike.looijmans@topic.nl>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: gadget: Inform system of suspended state
Thread-Topic: [PATCH] usb: dwc3: gadget: Inform system of suspended state
Thread-Index: AQHatbfXThCMnoxt4kuSB1VpY3Td2rG2ym4AgABJugCAASgMAA==
Date: Tue, 4 Jun 2024 23:06:30 +0000
Message-ID: <20240604230624.dk3pssivd7g3qb7p@synopsys.com>
References: 
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.c5f44c79-75b2-43c1-a791-806fe8b693cd@emailsignatures365.codetwo.com>
 <20240603131304.233403-1-mike.looijmans@topic.nl>
 <20240604010256.4dxamwvcjxug6xfb@synopsys.com>
 <0fceefc4-2b3c-41a4-a6ac-d0b6dbacc1f7@topic.nl>
In-Reply-To: <0fceefc4-2b3c-41a4-a6ac-d0b6dbacc1f7@topic.nl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB5984:EE_|CH3PR12MB8484:EE_
x-ms-office365-filtering-correlation-id: 516441a5-3fcc-48f8-942c-08dc84eaf859
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?K3NPTTNpZnBpNFZYcWJBaXQxUFVRbi9wV01ieVNZQUd4NEtoanVlWUd3QzBl?=
 =?utf-8?B?enhFSm9hUVlZbnFEb2YwOWRqdlNDTEVkQnNjNFFlN3BiclYycG9Pd0IvRS9F?=
 =?utf-8?B?clIyTHhLYzNjUFpBVEtWZDlaNTVJWUpTZ1lMY25mTFczREhPQkpWbllaaTFU?=
 =?utf-8?B?MGxSQVNKMXBITEtIeFlOZmlPSmVocG1wUjJEeTVuQS9oQXhnUU9zSUVzazAw?=
 =?utf-8?B?V2gxUmNmQXp1eDJMbEsvVlZCdGZXdTk2ZXE5eFZZRHJ1dG53cFlaM3lvUjlQ?=
 =?utf-8?B?ZTVSRGJnaC9YMG5qZ0RWMkI0d1ZUMjI4MHFiWC9FajBxMks0MnQ3TzM5TExW?=
 =?utf-8?B?RkhmaHlsajg4cWYwbGVkYUdQOW5PSWUwOVJYRnoxeG9RMElSZmVPeTNSajY3?=
 =?utf-8?B?VkRRUWtqTnpCOXJoRm1DSzA1WFRIelpCVkZ2Z0svR09sN21mRlhuNlFpNWFt?=
 =?utf-8?B?L3BhajRHcUdYREh4V2ZRamVmYlk5aVFJcDhIdjd5alZGaXdrN3pXK1VHSkdP?=
 =?utf-8?B?cHlsUnpjeFFMWHRSWjJsN1dlMnhpNVA1V2dzRUZsck0xOURsVVpIODcvWTE2?=
 =?utf-8?B?bCtaVVBLdDY4OHpLUzM5bHJZTjVNQ2YwczZJOXJMUlh3dGRUblhjOGQvMnJD?=
 =?utf-8?B?amw3UFlWNnZaVGVHK3l3a1FWL3Y0b2FBNklGME0xKzFKdmxBQnZrMWMrR0RU?=
 =?utf-8?B?UXo0Qms1dGVWUFRqQlB5UDRJV0ZwTlBmRFBuZUE4K3FIakRTdXpyTjQvZkhE?=
 =?utf-8?B?SHlvdk5NUzAzeXZXS0NZaEg2b1ZaZmc3Sk8zRXpKN29QNG1MREZpVDNydXZ0?=
 =?utf-8?B?N1VHSGkyMHFHYS9LU1g2Y09ZNlQ0SzNsc3dzRWdwci96dGN1Y1FLdWdBSWFT?=
 =?utf-8?B?ekJrQnBRbFQvNWQ4dHhqckZmeWZ0WHVxSG05MThHZjhxTEJYdWJySmpwVW43?=
 =?utf-8?B?amZPdkhVL2tyZVg3QTBXUWJaOVdIZE9URVpyR3pPREpENWZ4VU5tZzRuK2o5?=
 =?utf-8?B?OHFPUmxucGlMR0lFYmtBT01FbEJxbDlZcjdBSG1KNzA1cEQwTUhIdy9iUTBq?=
 =?utf-8?B?M3AxQ1hJYkxSaVRXZ3dmelZhV21TT1p3ZG56UFFVRGg3OVVxdm45MkdQV0dH?=
 =?utf-8?B?K1QzbkdwYUE4R2grZWw3anZCMjJtaTdTaXdMdjdDaHRLcUlVaEhRODY1MHY4?=
 =?utf-8?B?SGhocHVWaUpsOStNL1VOTEE0Y2NmT0lMTjFlK2Q0Qm9KWVhBNVdZa1liS0ZF?=
 =?utf-8?B?cjRiUU1CQzhBMGFjeTdLZFRxVEQ1SVNzRTF1SldpZlFUdDFDUkoyMTZkQ0g4?=
 =?utf-8?B?eGF3Wlp6SGpRKytkOGI3QXFpWWIvMEZiOUkyUU9KOFpmelFhdCt4WVBiWXAv?=
 =?utf-8?B?TmMwbytvTktkc0pNN0c0cy92U3pLbjJ1Rm1ab2lwRmM3VUhhZTFCUFdMcmRU?=
 =?utf-8?B?bStpYzJwSUgzcWpnUGdOeWpwb1B3NUtUcHFNUnk0WHFsVGNCdTFmV1dtaVRN?=
 =?utf-8?B?bXYwQnE1OVB3SFM2TTJTd2dUZTMvcnUvMmJjV3FTNVBaSmNNQTIzUmhhYUo3?=
 =?utf-8?B?ZVYrOC9mTEJBMkNuZ2Z2Y1FJMzhYUGF1bnZDY214eFdZdHgxTlFHK0ZzSUpY?=
 =?utf-8?B?cWdiREsxSDZtdEdFMHFWZFkyZXRYbGxkUStzS3JESUg0WXJSSjZ3M0FxMVZD?=
 =?utf-8?B?S2RnUWZDSkxMTitOQ2pRU0VuSUR4L2ZvdUVzakxHM0tVbllNNUVaajd3PT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5984.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Y3RCa3llcTZxdE1sTmlnVUxlR3IvaFUrWS9YVU9lZndvRnM2dklsMERSbVdy?=
 =?utf-8?B?Y1ZHZ1U5TUdlSjA4VGZSRUdrUWZ6RGtDc1ppNjlYLzJLTXliZEZRZXdLY3Q5?=
 =?utf-8?B?bU5uUEFBZFFFTExLenRlK0hmK0w0bHRCOGpLU3NEWnR0ajNkMkZVbmJCd2o0?=
 =?utf-8?B?blFXQTl4L0xIQXNhUENRdlV1YlI0bm1ibTkvN1Jja1pFaFhSWWJoYXNJbzkw?=
 =?utf-8?B?a2xTczgzT1FaRitXaG8vcXBhRyszTExTR3RhS3BhKzYxcStaSXVWUmt1TVRF?=
 =?utf-8?B?aVR1djBaVDFsdTgxNXRnNGQrYTdkZ2hRbjBVT3hUVFV3MWdjNmNrNW83d2ZK?=
 =?utf-8?B?NWFMZGNIMElZYnp5VXVNaHNEMHpYUWk4RUt4ZjRNTHZZNXpRS0V3d0M4ekFm?=
 =?utf-8?B?VndyaFRNdEV6YTliRFo0V2dsVVAzUGNEdEZBbVMxUVpreWZJOW01WERoZTlT?=
 =?utf-8?B?ODVhYTBqTXZjOW9oSVhiWEtjck5RVTU2TTl6SnZSNGRDTXhCZVRLMjRqeFFU?=
 =?utf-8?B?cWlPY1J3TmxpS1h0Sk4vemdudDRzSGR3c3U2TjVIRlpGeE93UjhTT0xZazFD?=
 =?utf-8?B?NlgxMjZSZm1xV2R6M3ZOUCttb3BZYnpWWTdBMnVlRi9nYTB3ckl4WGEvWkdt?=
 =?utf-8?B?SVRVbFdJRTRCc0tHUFJaZTdTWHNoRnN0TEhIblZxT092M3FzMXQ1UUFaZmg2?=
 =?utf-8?B?eTBFbXpmUlQ3LzkwODJXZVEwZlBuQzlKQzBQUzZsUUlZbkM5akttdStHRjA0?=
 =?utf-8?B?K1lIOURFeDdjVXBRN21tOWhIZmZZVVdXTjNPcVdqK1lESzNGRVYwM1BuUWgy?=
 =?utf-8?B?OEp5YzNSOThZR0pCek9IdCtsemZzSzNydERXWVFGNklFaUZWRDBqM2xXZ1Ir?=
 =?utf-8?B?N0JQZzJMaTQzZ3FuWDV2QzVBSVA2L3hoSjVZM1dPM041ZGVDdTBwdUQvckdr?=
 =?utf-8?B?N1QxanNlN1RMZXNuTm1EdEdsQmdIZmxiVC9qdFdmYTRvNS9ocStob2E2VVBE?=
 =?utf-8?B?Y0VQNTlpYXBTajZ1b25JWjNKREZHUm4vNlN3aExmMis3YVIvTUw2WTdSb2Nu?=
 =?utf-8?B?aGdqeUgvV1pLVnlyVzdWc2lSb0VNRkxvSWVIektCZjlIKytIdit2MjJYUWFt?=
 =?utf-8?B?T1R0RVpVUnZ6ZWUwb2VmSGcvU2FreGJjclpoWDRhdlppb00rTzkrN3dCNGFC?=
 =?utf-8?B?bkdvNE5JYWNRUkFwbk9hTzVPTFVRRWMwU2lFd1BERHVyWG1SMGxTL2hONmR1?=
 =?utf-8?B?NXV1S1ZWUWtiQ1ZKajFweWx3cWVjOTY3RzljeXY3TlFLQmpURmQ2RnRuTEVB?=
 =?utf-8?B?SFlwaFRwc09rT0RMTDd6T1JwVE9lZTZvbVlERGJiY3hxNVhhVW5ORnEzYU4z?=
 =?utf-8?B?MkkrWjhEZVlsZVhBTjAwSWdHREZXdWdCVFBsQ3huWDc4S216MzhrRzZwaWhs?=
 =?utf-8?B?YnFidmtFQUhraFFYRE5Icm8rM3hVa21rL2YrU3poNE9LVm93NWlWT1hSU0NR?=
 =?utf-8?B?bzRBTDR2cC9URlA5bWg4U2dzMHpRRWk4Z0Nia3JOUG5GbFRjZ2xOQys3b1RB?=
 =?utf-8?B?WnBqN0t4U1RpKzVMbm5Yb0kxRjVkWUF1TlNENFhxc2FLQ2JFTmFPZkE0VkhK?=
 =?utf-8?B?SjBhVUJ0UVJuK1hMMXNiR3dZcUhvdW0wUVVvK050eXpjd0xaNXVNQU1CT25p?=
 =?utf-8?B?RXJSUklxSTRpVkZkc0pQWnZKSjdWcUlUYlJkYmt0L0FVNGFtUW1jQ2ZHbml2?=
 =?utf-8?B?a0I3NUJPU2RvMDhDZGIxZndmMmZaS2d0K3dMSkxicno0azgvWklxVFJXdDRD?=
 =?utf-8?B?QnZ3VEp0WFU3bS93eVN0ZG9JdTNrOGVuR2NsWkxHV1U2VjYvT0cwRUFHTjU3?=
 =?utf-8?B?SnVMamxnc25abWo5SC9OdEFySytab1VDZFJkbWtETkJ0Q2d0RDZFNEEzMGho?=
 =?utf-8?B?dWdTbzdMYWZ2cmFIM3R0YVpkUWZDZEF5TXhGTlJuQTRqZ2hicjdmaFo0dE1T?=
 =?utf-8?B?V1hsc05LOTNUU0xFOE9lVkFFVCtxTXBlOTdSNDR6cFZZVk4zd0VhYW0xMXZJ?=
 =?utf-8?B?emUzdlNUNkFtTnZ0TUg5alhNZ2Z2S1BwMHhoZVZhbU5sbWJrTDZ0SHA0ZlRJ?=
 =?utf-8?Q?XTWY43fDp29qvmW/Qu8xAWot8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <53FAA9AC67A4E34EA5CA04DABF9DA32A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	zaV7Cg7qcgPLodTFjh3y0pnpHeXHrNXqoCNHPScGJpfxdBm9YFpNtL6C7lAisNORNUItnalVi5T9mKhAvLtj6CiYF0estPfD03wsUKVvzXW0fE3WXXiqgeGeabDP7QEM7Y8mY3rI31TD5/Z1v9LLLqjaJp0DWHCDNjkqVui0fegWoeuXzDE9RLWeLu8TgHWxWg7oryy0kK3QXBV7eWD32odkG8LRS5/EXa/ZDvEBlBtVjriEqugtetG4yAAB6RzLJP/1cCJNNC4eYJz2eh7JrEojhYZyzmxfo5VldkKTN/V9d/3SJeNemqeSKu6dnAD3YcH5bKErrA3t32wJcpG5Niw+/Fqm9YybaTXm+cxDeHzVQgIJgLw//h2UV1lLnfCo8y9ydbrxvsWH+guzWbjGY6+0PIzACSa297N7M75oOXyJBeTuAVeiT7ikIX9Yh3Mi7uGA0et3PLqin9LM6nD+fIPrRUFXVxa97SOnkYpHDAyyj1BRZesMOsAl5YFOordvnwP6pbwwAEOAdM7Jf8Keqa3aq0uA8gx+YKi+NtcQbfY8L0sLVMY7eV0JaqorBe9+ytGZ3YPh/Ze/2+Lzsal+sjtFT9BsWHJ56PAkeogMwnw8FVhQJqyB7Ke+zdPLi2/WDmaH2J3G0oLkNjGcxaLbqw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5984.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 516441a5-3fcc-48f8-942c-08dc84eaf859
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 23:06:30.3147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: owxojVnCAi9FuimetcBEwaoc7/2RZPevLquOdwISWIgh+Nx3uSJnhn9Ea+GuLUomIsU+SMpqzBE02MKBmsE1qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8484
X-Proofpoint-GUID: Zo7UvT9TcklG4r9LcWcuaWIGiairSA2c
X-Proofpoint-ORIG-GUID: Zo7UvT9TcklG4r9LcWcuaWIGiairSA2c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_11,2024-06-04_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 bulkscore=0 phishscore=0 adultscore=0 impostorscore=0 mlxlogscore=999
 suspectscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2406040187

SGksDQoNCk9uIFR1ZSwgSnVuIDA0LCAyMDI0LCBNaWtlIExvb2lqbWFucyB3cm90ZToNCj4gT24g
MDQtMDYtMjAyNCAwMzowMywgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+IEhpLA0KPiA+IA0KPiA+
IE9uIE1vbiwgSnVuIDAzLCAyMDI0LCBNaWtlIExvb2lqbWFucyB3cm90ZToNCj4gPiA+IFdoZW4g
ZGlzY29ubmVjdGluZyB0aGUgVVNCIGNhYmxlIG9uIGFuIExTMTAyOCBkZXZpY2UsIG5vdGhpbmcg
aGFwcGVucw0KPiA+ID4gaW4gdXNlcnNwYWNlLCB3aGljaCBrZWVwcyB0aGlua2luZyBldmVyeXRo
aW5nIGlzIHN0aWxsIHVwIGFuZCBydW5uaW5nLg0KPiA+ID4gVHVybnMgb3V0IHRoYXQgdGhlIERX
QzMgY29udHJvbGxlciBvbmx5IHNlbmRzIERXQzNfREVWSUNFX0VWRU5UX1NVU1BFTkQNCj4gPiA+
IGluIHRoYXQgY2FzZSwgYW5kIG5vdCBhIERXQzNfREVWSUNFX0VWRU5UX0RJU0NPTk5FQ1QgYXMg
b25lIHdvdWxkDQo+ID4gPiBleHBlY3QuIEFzIGEgcmVzdWx0LCBzeXNmcyBhdHRyaWJ1dGUgInN0
YXRlIiByZW1haW5zICJjb25maWd1cmVkIg0KPiA+ID4gdW50aWwgc29tZXRoaW5nIHJlc2V0cyBp
dC4NCj4gPiA+IA0KPiA+ID4gRm9yd2FyZCB0aGUgInN1c3BlbmRlZCIgc3RhdGUgdG8gc3lzZnMs
IHNvIHRoYXQgdGhlICJzdGF0ZSIgYXQgbGVhc3QNCj4gPiA+IGNoYW5nZXMgaW50byAic3VzcGVu
ZGVkIiB3aGVuIG9uZSByZW1vdmVzIHRoZSBjYWJsZSwgYW5kIGhlbmNlIGFsc28NCj4gPiA+IG1h
dGNoZXMgdGhlIGdhZGdldCdzIHN0YXRlIHdoZW4gcmVhbGx5IHN1c3BlbmRlZC4NCj4gPiBPbiBk
aXNjb25uZWN0aW9uLCBkaWQgeW91IHNlZSBkaXNjb25uZWN0IGludGVycnVwdD8gSWYgc28sIGl0
IHNob3VsZA0KPiA+IHRyYW5zaXRpb24gdG8gVVNCX1NUQVRFX05PQVRUQUNIRUQuIFRoaXMgY2hh
bmdlIGRvZXNuJ3Qgc2VlbSB0byBkaXJlY3RseQ0KPiA+IGFkZHJlc3MgeW91ciBpc3N1ZS4gQ2Fu
IHlvdSBwcm92aWRlIHRoZSBkcml2ZXIgdHJhY2Vwb2ludHM/DQo+IA0KPiBUaGUgZGV2aWNlIGRv
ZXNuJ3QgaXNzdWUgYSBkaXNjb25uZWN0IGV2ZW50LCBJIGRpZG4ndCBoYXZlIHRyYWNpbmcgZW5h
YmxlZA0KPiBpbiB0aGUga2VybmVsIGJ1dCBhZGRlZCBzb21lIGRldl9pbmZvKCkgY2FsbHMgdG8g
ZGV0ZXJtaW5lIHdoYXQgd2FzIGdvaW5nDQo+IG9uLiBBZGRlZCB0aGlzIHRvIGR3YzNfcHJvY2Vz
c19ldmVudF9lbnRyeSgpOg0KPiANCj4gZGV2X2luZm8oZHdjLT5kZXYsICJldmVudDogMHgleCB0
eXBlPTB4JXgiLCBldmVudC0+cmF3LCBldmVudC0+dHlwZS50eXBlKTsNCj4gDQo+IFdoZW4gZGlz
Y29ubmVjdGluZyB0aGUgY2FibGUgZnJvbSB0aGUgaG9zdCwgSSBzZWUgdGhpczoNCj4gDQo+IFvC
oMKgIDUwLjg0MTQxMV0gZHdjMyAzMTEwMDAwLnVzYjogZXZlbnQ6IDB4NjA4NCB0eXBlPTB4NDIN
Cj4gW8KgwqAgNTAuODQxNDU3XSBkd2MzIDMxMTAwMDAudXNiOiBldmVudDogMHg0MDg2IHR5cGU9
MHg0Mw0KPiBbwqDCoCA1MC44NDE0OTRdIGR3YzMgMzExMDAwMC51c2I6IGV2ZW50OiAweDYwODQg
dHlwZT0weDQyDQo+IFvCoMKgIDUwLjg0MTUzNF0gZHdjMyAzMTEwMDAwLnVzYjogZXZlbnQ6IDB4
NDA4NiB0eXBlPTB4NDMNCj4gW8KgwqAgNTAuODQxNTcxXSBkd2MzIDMxMTAwMDAudXNiOiBldmVu
dDogMHg0MDg2IHR5cGU9MHg0Mw0KPiBbwqDCoCA1Mi42NTA5OTBdIGR3YzMgMzExMDAwMC51c2I6
IGV2ZW50OiAweDMwNjAxIHR5cGU9MHgwDQo+IA0KPiBUaGUgIjB4NDA4NiIgYW5kICIweDYwODQi
IG1lc3NhZ2VzIGFyZSBlbmRwb2ludCBldmVudHMgdGhhdCBvY2N1ciBhbGwgdGhlDQo+IHRpbWUg
d2hpbGUgY29ubmVjdGVkLiBUaGUgbGFzdCBldmVudCBpcyB0aGUgInN1c3BlbmQiIG9uZS4gQWZ0
ZXIgdGhhdCwgdG90YWwNCj4gc2lsZW5jZS4NCj4gDQo+IElmIHlvdSBuZWVkIHRyYWNlcywgcGxl
YXNlIHBvaW50IG1lIHRvIGEgZGVzY3JpcHRpb24gb24gaG93IHRvIG9idGFpbiB0aGVtLg0KPiAN
Cj4gDQoNCkxldCBtZSBrbm93IGlmIHlvdSBydW4gaW50byBpc3N1ZXMgZm9sbG93aW5nIHRoaXMg
aW5zdHJ1Y3Rpb25zIHRvDQpjYXB0dXJlIHRoZSB0cmFjZXBvaW50czoNCmh0dHBzOi8vZG9jcy5r
ZXJuZWwub3JnL2RyaXZlci1hcGkvdXNiL2R3YzMuaHRtbCNyZXF1aXJlZC1pbmZvcm1hdGlvbg0K
DQpGcm9tIHRoZSBwYXRjaCB5b3UgcHJvdmlkZWQsIHlvdSBvbmx5IGFwcGx5IHRoZSBjaGFuZ2Ug
Zm9yIHRoZSB1c2INCnN1c3BlbmQuIEJ1dCBkaWQgeW91ciBkZXZpY2UgZ28gdGhyb3VnaCBzeXN0
ZW0gc3VzcGVuZD8gSWYgdGhhdCdzIHRoZQ0KY2FzZSwgdGhlbiB0aGUgZHdjMyBkcml2ZXIgd2ls
bCBjYXVzZSBhIHNvZnQtZGlzY29ubmVjdC4gQ3VycmVudGx5IHRoYXQNCndpbGwgbm90IHByb21w
dCBhIHN0YXRlIGNoYW5nZS4gV2UgbmVlZCB0aGUgdHJhY2Vwb2ludCB0byBrbm93IG1vcmUNCmRl
dGFpbC4NCg0KVW50aWwgd2UgaGF2ZSB0aGUgdHJhY2Vwb2ludHMsIHlvdSBjYW4gZXhwZXJpbWVu
dCB3aXRoIHRoaXMgdGVzdCBwYXRjaC4NCklmIG15IHN1c3BpY3Rpb24gaXMgY29ycmVjdCwgdGhl
biB0aGlzIG1heSByZXNvbHZlIHlvdXIgaXNzdWU6DQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3Vz
Yi9kd2MzL2dhZGdldC5jIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KaW5kZXggODlmYzY5
MGZkZjM0Li4yOWRiYjg4OWEwZTIgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdl
dC5jDQorKysgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQpAQCAtMjY4Miw2ICsyNjgyLDgg
QEAgc3RhdGljIGludCBkd2MzX2dhZGdldF9zb2Z0X2Rpc2Nvbm5lY3Qoc3RydWN0IGR3YzMgKmR3
YykNCiAgICAgICAgICovDQogICAgICAgIHJldCA9IGR3YzNfZ2FkZ2V0X3J1bl9zdG9wKGR3Yywg
ZmFsc2UpOw0KIA0KKyAgICAgICB1c2JfZ2FkZ2V0X3NldF9zdGF0ZShkd2MtPmdhZGdldCwgVVNC
X1NUQVRFX05PVEFUVEFDSEVEKTsNCisNCiAgICAgICAgLyoNCiAgICAgICAgICogU3RvcCB0aGUg
Z2FkZ2V0IGFmdGVyIGNvbnRyb2xsZXIgaXMgaGFsdGVkLCBzbyB0aGF0IGlmIG5lZWRlZCwgdGhl
DQogICAgICAgICAqIGV2ZW50cyB0byB1cGRhdGUgRVAwIHN0YXRlIGNhbiBzdGlsbCBvY2N1ciB3
aGlsZSB0aGUgcnVuL3N0b3ANCg0KDQotLQ0KDQpUaGFua3MsDQpUaGluaA==

