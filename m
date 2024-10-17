Return-Path: <linux-kernel+bounces-369020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 458739A17E6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 03:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 017A6281528
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 01:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD091C2339;
	Thu, 17 Oct 2024 01:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="CSbYxalr";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="GU0EJHFX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="rOtrpj+I"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8338373501;
	Thu, 17 Oct 2024 01:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729128102; cv=fail; b=RseaT+px3ZGkLthTFZO5vadOsgkheiyRPa4WM3KhknoMYXHwn0OBO1R9Ydld3xUF4phsgZOLpWBDxRRCVxj5bxyGdyhyvbs/JDirSnvJ5Y4eWjYP1PWI/9U3CJhPvPSo3zC92nf71POFrDv5tuv4ovLeDYykKQdIWD3Fh6lwO9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729128102; c=relaxed/simple;
	bh=ZAV9S8fp1i/39giiZKPEHkct9UTdO+SY/mIIotfKAeE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=muMv1hFA9kluKa4gNp3A4d4hrmGYlfTu8aATycLcgGaqA3Rif0j9uN0Kz5J1OGRdGF8Rk5kWc8l8mwWyAcZUbCpUi0rJZ6X55rdfbkTXQjpvaIrIJvjDO6iW4/S8aDPNhZlB5ggf9kRpt6Ob6I9FzbPmc9Od9hrunxsUmYfcN0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=CSbYxalr; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=GU0EJHFX; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=rOtrpj+I reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GJQL2O015688;
	Wed, 16 Oct 2024 18:21:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=ZAV9S8fp1i/39giiZKPEHkct9UTdO+SY/mIIotfKAeE=; b=
	CSbYxalrFhZNwUORWN6UcBL73W5CMgK8NkP0SA8Yj8Ip9LJ5Wki8rBOhLu+AHJHn
	3cZ//QoEW6oOGGbCdtXRf7yTGhfPe1NnZaQCMPLcdCXwgW+CZoE2uuILdRG3Fh98
	idFKZwZQ8WMui3HygoUoKvEy1EGvzOA7DLZrcFkj/YruomBgveYzA2e5IHf3n1vc
	f/endRZOLC23juLkFGhfhWXL1g7ZMOcDTDhu+LtOflRkNSi//jMhtkyPnh7NA3UK
	Ai8Uv/OMHSImFTZiKFxbAmX8jDNM/uHtLHc+jD2x/XzK+pnZs1Uvc05TjgH6P69j
	Y4oCoDWBCaeaPMIjWdSwUQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 42a8hy5ay1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 18:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1729128078; bh=ZAV9S8fp1i/39giiZKPEHkct9UTdO+SY/mIIotfKAeE=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=GU0EJHFX2VygWXgZC0kFGbPc5aCXxb206N5hxIdHwekbWuur6Vndulk88NX3PNvJ1
	 DWnZcbGRLHPzrg8lV6rfERIyw/GphbQJOloRot0YymdiIekseIifXOgD6vPgnvm2/+
	 n/9g0YMw+YhgHY1vhTnr86a2VIrQc2lGJcHx/c0cHwfTL5dZsxDPQQiDXrUnQ894z9
	 Kvg3ES130cNKzhZ9xwR2cwDxpr6y1ezPHUbWUSF3y8Yac5reZIc6zb1XYCpifsPsbz
	 dhH8VoHMujdBKw0AsgZiwrVm2PWL9bvPvdjvVsF29x4iXHnQVBspjeE96ti2cUHQ8N
	 FW8+oH/DKgB3g==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C49E740353;
	Thu, 17 Oct 2024 01:21:17 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 67281A0099;
	Thu, 17 Oct 2024 01:21:17 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=rOtrpj+I;
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 4C07A4011F;
	Thu, 17 Oct 2024 01:21:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hELGK96CshJBmW8tQYlodgfnu5EGLVIdT32YEa7DNzIv33k/CIQ0+E3qhqPPGIkmyblajNd51Dk+U1B3FtGFEQAKY2PgdYp1KVW4y7IdrmEC1iEDuG4nreewuTkO1unYKyCCdwMkatVCSDja9CwMyMcvHph+aYD0oWJCiOhpaECRX+rVDbNEQnzbpdA7ukonA3+/XSlRuXC9JFGyd7/AWzXa5tP5q5Ane8TKmCTh3Z/6KqQ2Z4f4WlovqZudZTwChqZ74NTsiXEamrrXRloMNiBibH2GMrFmBFpabTA6dLSNrgL4WTYV521gfVBUKDvjwpOyBJZqPLdxnqhVvEriGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZAV9S8fp1i/39giiZKPEHkct9UTdO+SY/mIIotfKAeE=;
 b=bpxfsfoYllYHLhZ3RPbWOLXA5pTqo4PZaqFRuG7/LsTYIf6KlcGJnBiNJPs6M95EexWtPHPWmjI+xo27dRlgbP5pfC/IMdWVXv2fHGla/JQa5I+SX+SnTnYGcMHxi8J3PfGW6FmJ8s0cC2qS484CWmV5VJWNchJ+vdoX3J9G/EzBdSHzazqlj9Bc83OW66rRFnBgXM8b+uf+mtkKpmQpVaoU03q/ADKnOLkD0TXqDhIjA3cZI3axklW0mMrbzwFMyayp3HmPmT1i5zYNr5t2hF6gUzR1bvxaHAzSGk/E0W8a32dk944KzjmUCGQ1Jjw+DlOEZIMSN/79h8mQYU+mqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZAV9S8fp1i/39giiZKPEHkct9UTdO+SY/mIIotfKAeE=;
 b=rOtrpj+IcxkyW57OFvU6ZCvZ81bUekyYzXyKfFmltQ1gwCQD5JkWjKnjyZT3cO7vAqtsqwYPo5SDE+48DN6sLw4wI/fT4Rmfd5ZNFbpCgzLD947XsxuR6u+9RpC8gR8Ek6WcqvkMiauTyF8qDwTgCv6m1n/N2B872xhfa08fOTU=
Received: from DS7PR12MB5984.namprd12.prod.outlook.com (2603:10b6:8:7f::18) by
 SN7PR12MB7178.namprd12.prod.outlook.com (2603:10b6:806:2a6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Thu, 17 Oct
 2024 01:21:10 +0000
Received: from DS7PR12MB5984.namprd12.prod.outlook.com
 ([fe80::e2e0:bc6d:711f:eeb]) by DS7PR12MB5984.namprd12.prod.outlook.com
 ([fe80::e2e0:bc6d:711f:eeb%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 01:21:10 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Akash Kumar <quic_akakum@quicinc.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jing Leng <jleng@ambarella.com>, Felipe Balbi <balbi@kernel.org>,
        Jack Pham <quic_jackp@quicinc.com>,
        "kernel@quicinc.com" <kernel@quicinc.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Vijayavardhan Vennapusa <quic_vvreddy@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6] usb: dwc3: gadget: Refine the logic for resizing Tx
 FIFOs
Thread-Topic: [PATCH v6] usb: dwc3: gadget: Refine the logic for resizing Tx
 FIFOs
Thread-Index: AQHbH71LyQooZFLKk0yLUIx5/AmBV7KKJjAA
Date: Thu, 17 Oct 2024 01:21:10 +0000
Message-ID: <20241017012104.cfk2drajdc52tp47@synopsys.com>
References: <20241016111904.11375-1-quic_akakum@quicinc.com>
In-Reply-To: <20241016111904.11375-1-quic_akakum@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB5984:EE_|SN7PR12MB7178:EE_
x-ms-office365-filtering-correlation-id: 0cfdb017-3bf5-4a69-22bb-08dcee49fba9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?d3ZCeG5hdXpYODBvdTM0dVk4NGYxVk9ObWo4aWVhS2IxYWR4NWdXd3E4RUJp?=
 =?utf-8?B?KytiYmdpcVRYVlJZenVWY3NrNzVvZDNTUDlSSkRURDA2a0cwR1lrQ3RsekUr?=
 =?utf-8?B?ZWY0S2NqWDlTM3BFZ3dxcjIwQVZKME1YVkZpSW5mK29CTEwra2ZpcWxaZ0E5?=
 =?utf-8?B?dDhqdDIydkMwMGtER3VhcTZIQXNDaTBrK0JwZ0tKc3RMb2NPamNXY1dVbDlG?=
 =?utf-8?B?Z2liK2QxbkljTjFMQUhjQzZNQTBRNEZHSDg4THA1b3g0YVhYd3kwRFJJTG90?=
 =?utf-8?B?ajFXVTB4enJoVG1JdFVxTlVyVUswTkc0SjlHdlZrdkV4RUVtUVUwLzVsSER6?=
 =?utf-8?B?Zng0ZDlXU1NjQyt5WTc5NGI4Q0VnVGVqZkpLUFhIL3NzVzM1YmNCbnVSZ3BS?=
 =?utf-8?B?SUk2bURrcFN5M1ZCaUluMXVjUzhTY2I0QXdiVk9yNEEzcnZpQ01peXF4K0hj?=
 =?utf-8?B?N2pEMHh3ZituQm1KMkpMRGt3ZkptemJZaDMwcDIzc2Z6SXUwQkdONVZtUS9n?=
 =?utf-8?B?WWZyV2M4YjZtcEFVeDE2Y2hqRXhGbFhEK3BLMGhDQzlqUkxuZjdBL0d6TUc2?=
 =?utf-8?B?c2Vuc2svaVlHOVJxazh0Nkh2VXE1OHMxU3FHYkhjYTBzaWMvWUxUTkNCVzkx?=
 =?utf-8?B?QU52Tko3bGdxSUo1S1p1aUc5UHMwQS9xSjJWQTBaR0ZtOUw2Tmx6NDBkbnVr?=
 =?utf-8?B?cHJrNnNHWmJpdzdSSWxpYWxKbnQ2Z2ZZZDc1a2RxaTZrZkl6eGo0WEhiejFM?=
 =?utf-8?B?ZzFkRXgrazdIaEtJM2xiZlpZdzBkQ08zUk1MZ3FkMUVMaFlJUVlXSUNDdyt4?=
 =?utf-8?B?azFXNExzMVdSSTVCMFdxTEQ0WEFJNnhPRTlnRU1CSy9sc3ZJSExqdmEvZ3NF?=
 =?utf-8?B?cW0vV2hlZnE1cy9rb3VyeHY1eDdvZityV0cxRjk5TG5mZ2lLNXlQVVhmSVdM?=
 =?utf-8?B?Sy8xOTV1MmsrL3F1SEl2TlYyTEV5OXdhazNnNDE1alVlMnUwQVBsU1E2a0dX?=
 =?utf-8?B?RDc1em9ibkJVREVzMXZMRUxnTGpLM0M5eXg4ZlNuL3d1N2RadVNIczFrcURH?=
 =?utf-8?B?RFBSQWxTMEJnTFVrMFkxYW4rWVo0RDR6V1ovMlE4RkRGSW1JZ0xYeUxhck9T?=
 =?utf-8?B?VGRtRklsc2J4ZzYrNXVQZ2Jtb3U5UDVvVU9uZmxDdGJlRHMwdTM2MzBvNm55?=
 =?utf-8?B?amIvTmVISnhpRThIZmUzbVdUdzlsWDlQL0hJRkIyQWEvNmlLbXpFTUZhRUFK?=
 =?utf-8?B?djBEZkR2MmpKTi9yUWlRN0FtbFZ5dUczMTdIQVBzOFcvRHJPczRLMkMvTzdD?=
 =?utf-8?B?eVJ5N2xTcFRkMWRPaXFXNGFMYWJKVzVOYlNBakZjZmVzcWlGVFpKL2VIeStV?=
 =?utf-8?B?eUhsRmdmeGdzNU43c1VnOU5rYnFReUc1anh5U0l5bzdHenBMdWJhZjFWWkxm?=
 =?utf-8?B?TjF6eWJ4VXZsZmlidjVSb2xEcE5kOWxFb2J0TnA5Q3ltVlRHTFltTmplalpK?=
 =?utf-8?B?YUlJTmRoK0ZVY3Y4N2RydVZtbVBnQTZlcUdpcDEzbjFWZ1RxVXhtWWRuZ3l6?=
 =?utf-8?B?M3RwSGZ0dVJJaCtabElodzFFNnFPeDlVdFpZbVJFaGNjWHVvMXRVSkNablRW?=
 =?utf-8?B?M0ptY0h3R0xHYVprazRXeXlOVk1PVWRxdkF2MGpHRGN6eXAwZVhFRWZUdDhq?=
 =?utf-8?B?NFNzQ01nR1kzeS84elp6U1Z3T2VWUHVOeEtvUmxvaFNwajV0Rk1IbUg4Z3RS?=
 =?utf-8?B?eWVBKzgzWm8yM09vRC8wSzJCOGJUQnIxWjZ0ZmNMLzhBeTg3NXA4ZWp4OXVt?=
 =?utf-8?Q?Uq7S1F/PNyKj2rp53ZCEwtf/8m5z2afYjWsHw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5984.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UHV2S2lIb01NUWFwNTRiVzdPa09VSS81RGRpdGNmK01ncExDbVkwTEo1ajZi?=
 =?utf-8?B?N3p2eGoxNjNxWng2QmNmWFplaThPL3NQZkFseFI0dUQwOWRTMHVCMkc5YkdN?=
 =?utf-8?B?anF1Vy80UXNSTGEzUHlBU0JlOHloQVdhZWNwSU8yaENrdFpBUTZ5SUlNcTZN?=
 =?utf-8?B?dkJyZ2JaakE2M09EQmRyM1dCV1dwOTBSWkZUT1psb2hVSG1NdWlUVEt2aHcy?=
 =?utf-8?B?a25qNzhjL3g4dWJ6aWNjMEo5bzBLQ25zOERoaGliczkwcnpXZkpGMmFPRE80?=
 =?utf-8?B?NmcwZVErY3AwdWFsUmhkL2Q3QUg0RTRJRWhPaVBwRlQxeHRmTFRuWXRwbzZi?=
 =?utf-8?B?QjdqcHNFRkhlNDJyWUtENlNmTk5lZmFKdUxzc0dYelpFWElxb3RVeWtoRklP?=
 =?utf-8?B?VmRVU09LU0RsejZzdGtIQlJ1UUR3bGhjNktUeW5wSTMxUGdOazFwV1FPQ2JS?=
 =?utf-8?B?MGFOWjd5NlhEMXZTKzMwNzJ0d1lNU1BEUW1OUitWWnZzUHRYL3pTV1A4UmI1?=
 =?utf-8?B?RTFXYk8xcVFibllHSWhNZ3IxWXdLRmluUCtzSkNRZFZzNVAyazQ2ZmNvUkRq?=
 =?utf-8?B?TnMwUnF4MWthcDhWVGxYbkdrbjNlQmI0QWdPb2JHdEUyR1kreGpCT2dPYlRP?=
 =?utf-8?B?Z3pTdTA3blYyMmZSQzgyRHY4MUhKNVpKRFIvaWJndmY1Q1JJVkQrdmRpQ2R4?=
 =?utf-8?B?dmx5VEVCU2ZzR2NWT0lTRDN6TWZ5YktXNzFNMzNENWJMNHhuVUdIZHN4L2o3?=
 =?utf-8?B?UWVnQ2txYTRDV3owNVp2djlqeFp4MHNJSGhjRGJPMlE0Zm5wZFlORnhjSEdE?=
 =?utf-8?B?L0ZzMzNwU1N1RHR3bU1JL25Ucm9ub2s0L0NvZzd3V0syTkJiWHUvMDlmWnIr?=
 =?utf-8?B?Si9yM1Fua01LczRxVUx0RWNjbkVHd05mK2ZJSGwxbE1PSGVYUWhoVXdhcnJp?=
 =?utf-8?B?b0ppdlFiSHpWRTVsaDNKZUtidE1GU3RvRUNJTjQ0UnZiR0pWUGlQK1VacVFt?=
 =?utf-8?B?cm1zODd5MFQrdnNwVUpwQjNtQ0tUVHNMVzBrL2kxcGRqcElFZWFtQmdaQkJi?=
 =?utf-8?B?VGkzV25NbGpPUkFCUXZnRmhsZ3FTQXJ3alRXcFFlaCtOQ0tGVVA0aVZsdXIz?=
 =?utf-8?B?a3NOdktvdXhYYmlGSkJEMnpFMFcvSlBtakowRWpjRWhMRFozWm9SMWdGQTFh?=
 =?utf-8?B?Qm8zS2QvVFBTdk5oTWFyNU1tZk1KYVIza0NVcmxMdTNYY2QvdWZTSG9ZSCsy?=
 =?utf-8?B?QmlHaEVhRjFvS2VzSC9XQ084bXNacFp6UGVXK29GUDNjSHZ5bThwQlBtbUpl?=
 =?utf-8?B?azBWdWpueS9jRVVlbzJSeDk4Vm5UMWZVaTVNTGQxTThKbzRxb3JHT0wraTNG?=
 =?utf-8?B?eGpuWWJQcERyR0pGKzhxM25CNEs0RjdLaEUvMGVwWmFHWS8xNkVjUWJBbGNx?=
 =?utf-8?B?WkpKUXYxaTV1dWdiL04vTTlKd1h4KzU2QUFrNXdqSzFpN2pTVVdzOS96TFNm?=
 =?utf-8?B?a20xcGRGZVRCVkNGMGtUWUs3S1B1cWFPSHFjRkh0VWRCTUtkay9wZm1Dd3Jt?=
 =?utf-8?B?Mkg4ZnIzZFlkK1NwZFhta0hFbmlwSjZRNFo1OGVXc3pzdnhoU3FrT3ZXa1k5?=
 =?utf-8?B?a2t6QnlHeS9qN0JuQkFKaFl5UzBYeC9yZ01xeno2Tm5CTTQxSmRUZ1pGR1RX?=
 =?utf-8?B?aXJ3RXpUeUtTZ1pCcVh2UklrRmxtTmgzTjRaRHB2UHVaUHh4L3ZvR2RRRlpW?=
 =?utf-8?B?Ly9OS0d5cnBLSlBuM2JFaVZvZE81UUtnNU1zdWw0YmxLeXkvTU9DVmVSVHlZ?=
 =?utf-8?B?eXA4T0JYQWFlbmFkMk9NZXlpenRzbVJYSDMvQjBzUnQ4Y2k2UGZmUHh1K3pC?=
 =?utf-8?B?ZUJPSG9CelBHaUVJempZYmtqNlRkSzgvaTJIRGFFeUhSY1U2MHR3TXFmVmxR?=
 =?utf-8?B?aFoySFJaWGxYR1czemo0UzRTQWZJWUJQVjdlTmhndFVrak8vcVZDUnc5Wm1O?=
 =?utf-8?B?Z0JKa1JiMVdHdXM4Vk9HZDZGRW9KMWhWVCtUcGR2MDg3NGpBbFZVelJGK2Qy?=
 =?utf-8?B?QXJBSGhPdGZ0RXBNQ2JIM3NKN3VMdE82QnduaytETUNjQ2R5M1FMZWRTd2NF?=
 =?utf-8?Q?aWKnVk+WQZbRNqaZucw6eHerx?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <23A63D2A743DDB448344D07F51BF2F36@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4tbPmgqyZxwlhBp9VlG14VqBqBZZRiRgd/s3Phrtrqb0EuwwiPaComZTSs66jps4Fy0zQP9yuzEzb1yb4GS11/etGdelKZdq4SbT2q0IgeglKMf7k2/qH8rXEtRJZUzjsmuQ2Cr1frw4LGgz3ChK/V7X3BRxRh7HPE0H9+A37F6DFkwpOLL7XGN2H5rFVMir5/bDypTN0UGoWwVdQXsCTCbxatgMM/DOzVrou6llulx2o4FEWUb6UtSY+2liv5HASJctgiIDz88Q2bBqmgc8cISYp4QU6ZZIeWN8ObI9RF8C0WSoPQLsAp4a4CKeldKk9rZHcHhIuH+LACeJOJ/VdGIQGXyUfvU0Ex5XF3ZS+MaE1/34njDkapBS+j46ZuoGow/MGtG7KN6qt8m2PO8WQFMOt7CenbssaN1jUuU+o+yxygsOLOCnEx3KLAvDKpiWOwX13/rWV9HX1muflOJDvVp5Cgt/wtx2OetUGAb1mlKxMmtKCwCRb2GqpXJ2Sbh4f/7QZVLURdSp/Pgg3Beots68ruH+jLR1WJ0lgCTnlEJfMQxq0ILCdzo249czpvYFiTNfu1uC6fWC9LNbrLfNHeWXxlW7PvHFSfZiNlj1hXO3HTYMj5IsgptkuWbE/8cGKj1zGV2/wa+Mdu0JRFRVQg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5984.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cfdb017-3bf5-4a69-22bb-08dcee49fba9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2024 01:21:10.1338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VXA5JlrE5uBPmUtQU3M1dVaJHb4cyJzNF/enuPqW4p1yehWD7rgndQzxAOc6KCVEZ/LNokkc072dwNPFzcWCjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7178
X-Proofpoint-ORIG-GUID: -G6k9if35mKyY3TWffxhEV_Ai1HhoNHl
X-Proofpoint-GUID: -G6k9if35mKyY3TWffxhEV_Ai1HhoNHl
X-Authority-Analysis: v=2.4 cv=KKwID0Fo c=1 sm=1 tr=0 ts=6710668f cx=c_pps a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=nEwiWwFL_bsA:10
 a=qPHU084jO2kA:10 a=COk6AnOGAAAA:8 a=Fw8nr6mc_DSmYoaB-Y0A:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 suspectscore=0 impostorscore=0
 adultscore=0 phishscore=0 clxscore=1011 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410170008

T24gV2VkLCBPY3QgMTYsIDIwMjQsIEFrYXNoIEt1bWFyIHdyb3RlOg0KPiBUaGUgY3VycmVudCBs
b2dpYyBpcyByaWdpZCwgc2V0dGluZyBudW1fZmlmb3MgdG8gZml4ZWQgdmFsdWVzLg0KPiAzIGZv
ciBhbnkgbWF4YnVyc3QgZ3JlYXRlciB0aGFuIDEuDQo+IHR4X2ZpZm9fcmVzaXplX21heF9udW0g
Zm9yIG1heGJ1cnN0IGdyZWF0ZXIgdGhhbiA2Lg0KPiBBZGRpdGlvbmFsbHksIGl0IGRpZCBub3Qg
ZGlmZmVyZW50aWF0ZSBtdWNoIGJldHdlZW4gYnVsayBhbmQNCj4gaXNvY2hyb25vdXMgdHJhbnNm
ZXJzLCBhcHBseWluZyBzaW1pbGFyIGxvZ2ljIHRvIGJvdGguDQo+IA0KPiBUaGUgdXBkYXRlZCBs
b2dpYyBpcyBtb3JlIGZsZXhpYmxlIGFuZCBzcGVjaWZpY2FsbHkgZGVzaWduZWQgdG8gbWVldA0K
PiB0aGUgdW5pcXVlIHJlcXVpcmVtZW50cyBvZiBib3RoIGJ1bGsgYW5kIGlzb2Nocm9ub3VzIHRy
YW5zZmVycy4gV2UNCj4gaGF2ZSBtYWRlIGV2ZXJ5IGVmZm9ydCB0byBzYXRpc2Z5IGFsbCBuZWVk
cyBhbmQgcmVxdWlyZW1lbnRzLCB2ZXJpZmllZA0KPiBvbiBvdXIgc3BlY2lmaWMgcGxhdGZvcm0g
YW5kIGFwcGxpY2F0aW9uLg0KPiANCj4gQnVsayBUcmFuc2ZlcnM6IEVuc3VyZXMgdGhhdCBudW1f
Zmlmb3MgaXMgb3B0aW1pemVkIGJ5IGNvbnNpZGVyaW5nIGJvdGgNCj4gdGhlIG1heGJ1cnN0IGFu
ZCBEVCBwcm9wZXJ0eSAidHgtZmlmby1tYXgtbnVtIiBmb3Igc3VwZXIgc3BlZWQgYW5kDQo+IGFi
b3ZlLiBGb3IgaGlnaC1zcGVlZCBhbmQgYmVsb3cgYnVsayBlbmRwb2ludHMsIGEgMksgVHhGSUZP
IGFsbG9jYXRpb24NCj4gaXMgdXNlZCB0byBtZWV0IGVmZmljaWVudCBkYXRhIHRyYW5zZmVyIG5l
ZWRzLCBjb25zaWRlcmluZw0KPiBGSUZPLWNvbnN0cmFpbmVkIHBsYXRmb3Jtcy4NCj4gDQo+IElz
b2Nocm9ub3VzIFRyYW5zZmVyczogRW5zdXJlcyB0aGF0IG51bV9maWZvcyBpcyBzdWZmaWNpZW50
IGJ5DQo+IGNvbnNpZGVyaW5nIHRoZSBtYXhpbXVtIHBhY2tldCBtdWx0aXBsaWVyIGZvciBIUyBh
bmQgYmVsb3cgYW5kIG1heGJ1cnN0DQo+IGZvciBTdXBlci1zcGVlZCBhbmQgYWJvdmUgZXBzLCBh
bG9uZyB3aXRoIGEgY29uc3RyYWludCB3aXRoIHRoZSBEVA0KPiBwcm9wZXJ0eSAidHgtZmlmby1t
YXgtbnVtIi4NCj4gDQo+IFRoaXMgY2hhbmdlIGFpbXMgdG8gb3B0aW1pemUgdGhlIGFsbG9jYXRp
b24gb2YgVHggRklGT3MgZm9yIGJvdGggYnVsaw0KPiBhbmQgaXNvY2hyb25vdXMgZW5kcG9pbnRz
LCBwb3RlbnRpYWxseSBpbXByb3ZpbmcgZGF0YSB0cmFuc2ZlciBlZmZpY2llbmN5DQo+IGFuZCBv
dmVyYWxsIHBlcmZvcm1hbmNlLiBJdCBhbHNvIGVuaGFuY2VzIHN1cHBvcnQgZm9yIGFsbCB1c2Ug
Y2FzZXMsDQo+IHdoaWNoIGNhbiBiZSB0d2Vha2VkIHdpdGggRFQgcGFyYW1ldGVycyBhbmQgdGhl
IGVuZHBvaW504oCZcyBtYXhidXJzdCBhbmQNCj4gbWF4cGFja2V0LiBUaGlzIHN0cnVjdHVyZWQg
YXBwcm9hY2ggZW5zdXJlcyB0aGF0IHRoZSBhcHByb3ByaWF0ZSBudW1iZXINCj4gb2YgRklGT3Mg
aXMgYWxsb2NhdGVkIGJhc2VkIG9uIHRoZSBlbmRwb2ludCB0eXBlIGFuZCBVU0Igc3BlZWQuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBBa2FzaCBLdW1hciA8cXVpY19ha2FrdW1AcXVpY2luYy5jb20+
DQo+IC0tLQ0KPiBDaGFuZ2VzIGZvciB2NjoNCj4gVGhlIGNvZGUgaGFzIGJlZW4gcmVmYWN0b3Jl
ZCB0byByZXBsYWNlIG11bHRpcGxlIGlmIGNoZWNrcyB3aXRoIGENCj4gc3dpdGNoLWNhc2Ugc3Ry
dWN0dXJlIGJhc2VkIG9uIHRoZSBVU0Igc3BlZWQuIFRoaXMgY2hhbmdlIGltcHJvdmVzDQo+IHJl
YWRhYmlsaXR5IGFuZCBtYWludGFpbmFiaWxpdHkgYnkgY2xlYXJseSBkZWZpbmluZyBiZWhhdmlv
ciBmb3INCj4gZGlmZmVyZW50IFVTQiBzcGVlZHMuIFRoaXMgc3RydWN0dXJlZCBhcHByb2FjaCBl
bnN1cmVzIHRoYXQgdGhlDQo+IGFwcHJvcHJpYXRlIG51bWJlciBvZiBGSUZPcyBpcyBhbGxvY2F0
ZWQgYmFzZWQgb24gdGhlIGVuZHBvaW50IHR5cGUNCj4gYW5kIFVTQiBzcGVlZC4NCj4gDQo+IENo
YW5nZXMgZm9yIHY1Og0KPiBVcGRhdGUgQ2FsY3VsYXRpb24gZm9yIEhTIGFuZCBiZWxvdyBidWxr
IGFuZCBpc29jIGVwcyBiYXNlZCBvbg0KPiBzdWdnZXN0aW9uIGFuZCBmaXhlZCBhdCAyayBmb3Ig
YnVsayBlcHMgY29uc2lkZXJpbmcgZmlmbyBjb25zdHJhaW5lZA0KPiBwbGF0Zm9ybXMuDQo+IA0K
PiBDaGFuZ2VzIGZvciB2NDoNCj4gVXBkYXRlZCBjb21taXQgbWVzc2FnZSBhcyBwZXIgcmV2aWV3
IGNvbW1lbnRzIHRvIGNsYXJpZnkgdGhhdCBpdCBoYXMNCj4gYmVlbiB0ZXN0ZWQgb24gc3BlY2lm
aWMgcGxhdGZvcm1zIG9ubHkgYW5kIHRyaWVkIGJlc3QgdG8gbWF0Y2ggYWxsDQo+IGV4cGVjdGF0
aW9ucy4NCj4gDQo+IENoYW5nZXMgZm9yIHYzOg0KPiBSZWRlZmluZSBsb2dpYyBmb3IgcmVzaXpp
bmcgdHggZmlmb3MsYWRkZWQgY2hlY2sgYmFzZWQgb24gIG9wZXJhdGluZw0KPiBzcGVlZCBhbmQg
dXNlZCBtYXhwIGZvciBIUyBhbmQgbWF4YnVyc3QgZm9yIFNTICBhbmQgZGVmaW5lZCBtYXgNCj4g
YWxsb2NhdGlvbiBiYXNlZCBvbiBkdCBwcm9wZXJ0eS4NCj4gDQo+IENoYW5nZXMgZm9yIHYyOg0K
PiBSZWRlZmluZSBsb2dpYyBmb3IgcmVzaXppbmcgdHggZmlmb3MsIGhhbmRsZWQgZmlmbyBiYXNl
ZCBvbiAgbWluaW11bQ0KPiBvZiBtYXhwIGFuZCBtYXhidXJ0cy4NCj4gDQo+IENoYW5nZXMgZm9y
IHYxOg0KPiBBZGRlZCBhZGRpdGlvbmFsIGNvbmRpdGlvbiB0byBhbGxvY2F0ZSB0eCBmaWZvIGZv
ciBocyBpc29jICBlcHMsDQo+IGtlZXBpbmcgdGhlIG90aGVyIHJlc2l6ZSBsb2dpYyBzYW1lDQo+
IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyB8IDMxICsrKysrKysrKysrKysrKysr
KysrKysrLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspLCA4IGRl
bGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMg
Yi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+IGluZGV4IDEwMTc4ZTVlZGE1YS4uZGM2MmQw
NjI2ZTUzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ICsrKyBi
L2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gQEAgLTc3MSwxNSArNzcxLDMwIEBAIHN0YXRp
YyBpbnQgZHdjM19nYWRnZXRfcmVzaXplX3R4X2ZpZm9zKHN0cnVjdCBkd2MzX2VwICpkZXApDQo+
ICANCj4gIAlyYW0xX2RlcHRoID0gRFdDM19SQU0xX0RFUFRIKGR3Yy0+aHdwYXJhbXMuaHdwYXJh
bXM3KTsNCj4gIA0KPiAtCWlmICgoZGVwLT5lbmRwb2ludC5tYXhidXJzdCA+IDEgJiYNCj4gLQkg
ICAgIHVzYl9lbmRwb2ludF94ZmVyX2J1bGsoZGVwLT5lbmRwb2ludC5kZXNjKSkgfHwNCj4gKwlz
d2l0Y2ggKGR3Yy0+Z2FkZ2V0LT5zcGVlZCkgew0KPiArCWNhc2UgVVNCX1NQRUVEX1NVUEVSX1BM
VVM6DQo+ICsJY2FzZSBVU0JfU1BFRURfU1VQRVI6DQoNCkNhbiB5b3UgZml4IHRoZSBpbmRlbnRh
dGlvbnM/DQoNClNob3VsZCBiZSBzb21ldGhpbmcgbGlrZSB0aGlzOg0KDQoJc3dpdGNoIChzcGVl
ZCkgew0KCWNhc2UgU1NQOg0KCWNhc2UgU1M6DQoJCWlmICguLi4pDQoJCQl4eHg7DQoJCWJyZWFr
Ow0KCWNhc2UgSFM6DQoJCWlmICguLi4pDQoJCQkuLi47DQoJZGVmYXVsdDoNCgkJYnJlYWs7DQoJ
fQ0KDQpUaGFua3MsDQpUaGluaA0KDQo+ICsJaWYgKHVzYl9lbmRwb2ludF94ZmVyX2J1bGsoZGVw
LT5lbmRwb2ludC5kZXNjKSB8fA0KPiAgCSAgICB1c2JfZW5kcG9pbnRfeGZlcl9pc29jKGRlcC0+
ZW5kcG9pbnQuZGVzYykpDQo+IC0JCW51bV9maWZvcyA9IDM7DQo+IC0NCj4gLQlpZiAoZGVwLT5l
bmRwb2ludC5tYXhidXJzdCA+IDYgJiYNCj4gLQkgICAgKHVzYl9lbmRwb2ludF94ZmVyX2J1bGso
ZGVwLT5lbmRwb2ludC5kZXNjKSB8fA0KPiAtCSAgICAgdXNiX2VuZHBvaW50X3hmZXJfaXNvYyhk
ZXAtPmVuZHBvaW50LmRlc2MpKSAmJiBEV0MzX0lQX0lTKERXQzMxKSkNCj4gLQkJbnVtX2ZpZm9z
ID0gZHdjLT50eF9maWZvX3Jlc2l6ZV9tYXhfbnVtOw0KPiArCQludW1fZmlmb3MgPSBtaW5fdCh1
bnNpZ25lZCBpbnQsDQo+ICsJCQkJICBkZXAtPmVuZHBvaW50Lm1heGJ1cnN0LA0KPiArCQkJCSAg
ZHdjLT50eF9maWZvX3Jlc2l6ZV9tYXhfbnVtKTsNCj4gKwkJYnJlYWs7DQo+ICsJY2FzZSBVU0Jf
U1BFRURfSElHSDoNCj4gKwlpZiAodXNiX2VuZHBvaW50X3hmZXJfaXNvYyhkZXAtPmVuZHBvaW50
LmRlc2MpKSB7DQo+ICsJCW51bV9maWZvcyA9IG1pbl90KHVuc2lnbmVkIGludCwNCj4gKwkJCQkg
IHVzYl9lbmRwb2ludF9tYXhwX211bHQoZGVwLT5lbmRwb2ludC5kZXNjKSArIDEsDQo+ICsJCQkJ
ICBkd2MtPnR4X2ZpZm9fcmVzaXplX21heF9udW0pOw0KPiArCQlicmVhazsNCj4gKwl9DQo+ICsJ
CWZhbGx0aHJvdWdoOw0KPiArCWNhc2UgVVNCX1NQRUVEX0ZVTEw6DQo+ICsJaWYgKHVzYl9lbmRw
b2ludF94ZmVyX2J1bGsoZGVwLT5lbmRwb2ludC5kZXNjKSkNCj4gKwkJbnVtX2ZpZm9zID0gMjsN
Cj4gKwkJYnJlYWs7DQo+ICsJZGVmYXVsdDoNCj4gKwkJYnJlYWs7DQo+ICsJfQ0KPiAgDQo+ICAJ
LyogRklGTyBzaXplIGZvciBhIHNpbmdsZSBidWZmZXIgKi8NCj4gIAlmaWZvID0gZHdjM19nYWRn
ZXRfY2FsY190eF9maWZvX3NpemUoZHdjLCAxKTsNCj4gLS0gDQo+IDIuMTcuMQ0KPiA=

