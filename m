Return-Path: <linux-kernel+bounces-181676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2228C7F87
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 03:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B12151C22062
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 01:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C2C1C27;
	Fri, 17 May 2024 01:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="fG4O5RBX";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="HORxsZD2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="BoMKdU3K"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92A74C69;
	Fri, 17 May 2024 01:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715909402; cv=fail; b=Wv+aSoD/hQMDPbBKNa1xjcNjxintrqObNleRK1k2p6msH0Q16TV9jQxpQV+YFdJBD2BwBa+sYwqNw0wVc767Ux3gl5XsDSk/O5NS16rIGaJbX+i8F2vqT2xvjGbgU5emG+i2FysznsHjydXrcg7GLwq4Lw4txNg/HeON7BsoOGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715909402; c=relaxed/simple;
	bh=YIY9dS8k5AlZ6qhgv7RdzNYtPA7a9D75sg8E3iLhTtg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jB5ZEl6Ig3zprPhv2sLXT5+jsOMTRAupXX0vhTBhGeCnX+6lED1no3iJm0tKM1zdKUhhILdwUpXT71ZZ4BJ6nifmTWrT6ViF3VjHjmUEktEgI7hn5gGWaOfgit9qljOEa2C+8uq64rcj3ctxqmR2uJoELXNoAGnxFroiUom9CP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=fG4O5RBX; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=HORxsZD2; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=BoMKdU3K reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44GNRsZe002881;
	Thu, 16 May 2024 18:29:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=YIY9dS8k5AlZ6qhgv7RdzNYtPA7a9D75sg8E3iLhTtg=; b=
	fG4O5RBXzdtJ3ORb747d7CuY7+wEQOcSw4Eje/2WS11FopVUK8QulB+cY9XIqtGq
	ZLu9JnPN568qTH5aEVPjOdfAwUWp5fkVsl20hw5G6Gj0cCJ49h+VhiIR015WNRPz
	mFTwE8qI1LG2J7JwchfhBxlc9W9KdO1u0TxzL+ubRESNvWkMO1gHqYZeG3BpzlXv
	Xq+Jy/UtdqIZKD+tS9SgmtsOXQPdI7BmZgtLdr7SYxMgnqTDr2o4SGAdLFd4D74x
	6bmI4SXBXBKG5lGl7arVI91H0A32u6c6rnqSBivsf+YOgsA/z4kED8iA7rsGNJ+x
	a0kv3ImlBUc8orXcs8FZgw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3y27kt6ube-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 May 2024 18:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1715909386; bh=YIY9dS8k5AlZ6qhgv7RdzNYtPA7a9D75sg8E3iLhTtg=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=HORxsZD2EPhxhHIi0YgxlfAmjK7nBiO2dP6ZCXsKYA/xOS4roM2FdYCjAQv4+Kjlx
	 h1WEtn28ESdi0+oBcN98E2gsh7H3e8AkQx98+xFu7smQgirU5riQQ273Itcif0ox9I
	 ykfWgrLxsEOcjUpqtT8lkLh9CfFWyTX/ltiAwriuOvpujbRseeTm9fv1O9OKnpC71M
	 tSq8OkwTbBF1X5QUj48L6FBpMoF5vhQ/N7YsA8NRWGJoWPR42jMSeM9UJkW4W5K9Ad
	 2hkyzQtBr4NaUpT7rEBsyli3i+wz8tQyYoVam+Hp2B/L+nnhtSNwyCiRkU38WIjj+y
	 trC3qtbe7vE2w==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A80E04041D;
	Fri, 17 May 2024 01:29:46 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 3DB40A009D;
	Fri, 17 May 2024 01:29:46 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=BoMKdU3K;
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id C3F104028D;
	Fri, 17 May 2024 01:29:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ER/i+GfjIA6E5IKmJ9ODAI4Vfj9myItog0wyf/jazQMxz2TGUyN4OhV9SGS2yCM7dsXaDTLOxE3lPDXJ0d8Ec/+jdAUZIEGLhDetrpyeUGyWStd4j3OCAPymTayPDSewZP1PNnOFu+gZg7QjKWx4jGe4jX2aBEnf7xoOnq6nhO2650QQzg6cKgDZTq9Z2MJAq/PeUZau+vJU7UNYuglAmq8KhuWJlOmK68C4YEmlxjSa3xlZMGqAnIKmCAq4jLd7KrmZCZjczwRv9Azo3Ik6JCZqZS5WhrDJxjjgfnl5ECszYzDdh6zcQTI3b/a2KiuzOXUsWzb56U7hyJy0MNvIvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YIY9dS8k5AlZ6qhgv7RdzNYtPA7a9D75sg8E3iLhTtg=;
 b=P2UtWj8tljVXOi84DqG9UzjXvpuk19/rEwcFfFb6uYElNGeQ3BBNKvUl8ssf9tZ07miNoCHvBWdZ27jAcZDAqhSIX1TP7Y0FoAb+9Wbyyw0pZqk5ARKQN8D6Dw0x/U5nDXa5vq/1LSO3xzV1M3dSH5MGlSMnAvQOmBztLJjpIYH3tt3XzTmvI3wNbt1D9eH0lBnDSymLnqgTefcfIIRLCr9/cFielLaWi4h0MZ2Vgb3vhp7leLo5cp6tPmgotOYm4DYw9NifyGsE8NNaJ/e6Y3b/axdAopQmof7tKj46mQYQYC6TsNHMifXF/ueu2zZbvBAhCwqFIdXX1nPTkXM9sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YIY9dS8k5AlZ6qhgv7RdzNYtPA7a9D75sg8E3iLhTtg=;
 b=BoMKdU3KObdCOVfVuiko+ziRjhLH+eD+jmzUDTrZKc9Bb8k+VdcaycAr+m6M+Nd8s3ipqXtfMJr/7VkqtDkNjfuCEGkwsQK6F/7vd37R8PpSwkef/5Se/ip6z65pIKf6kG7QtWNxwvkXZJBb5SZlmncSgoIObzAXb78UNrDxi1M=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by MW6PR12MB8866.namprd12.prod.outlook.com (2603:10b6:303:24c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.29; Fri, 17 May
 2024 01:29:42 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7827:b41a:c9d6:8e1d]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7827:b41a:c9d6:8e1d%7]) with mapi id 15.20.7587.025; Fri, 17 May 2024
 01:29:42 +0000
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
 AQHahUf+Fjbt0R5rsESCdAPrKfiIcbFVmhGAgAADmgCAAaX5AIAeuKwAgADM1YCAESZwAIAGPZAAgAAOPwCAAzTaAIAC7SKAgAaLagA=
Date: Fri, 17 May 2024 01:29:42 +0000
Message-ID: <20240517012936.pau2gfcpmnmomodp@synopsys.com>
References: <20240402230555.xgt5uilc42diyr4m@synopsys.com>
 <20240402231848.4hzzrxegjrcmdab2@synopsys.com>
 <20240404002906.wk6xbz2wp2tf2xwn@synopsys.com>
 <Zie5sN473m2rgNTK@pengutronix.de>
 <20240424015059.w7hsee4tt2ixkp5y@synopsys.com>
 <ZjbIeib2UMta7FbY@pengutronix.de>
 <20240508230252.wauttsgkp63fpife@synopsys.com>
 <ZjwQkIBUlhl-4ScO@pengutronix.de>
 <20240511005148.zqighnpv2zxboogf@synopsys.com>
 <ZkE1j2DH1TfUGoGi@pengutronix.de>
In-Reply-To: <ZkE1j2DH1TfUGoGi@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|MW6PR12MB8866:EE_
x-ms-office365-filtering-correlation-id: 8704b0ee-94c5-4077-8cf3-08dc7610d40a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?enBiTmZBdjJmYldpV2FoWHE3c1ZrM25Xb0N6Yk9OWDN2MGFYMmhGZ1o5MTkv?=
 =?utf-8?B?blpCL2QyV1UrMWYyWXhIS2lnMjhKcGIwdVQ5SXZ1dCtWMWpPQnlGN0sxS2JJ?=
 =?utf-8?B?WjRDSXNrQ0JlMTVOOSs0eW9IeERvTVN2cEVHcWppaU1Pc2kzdXFoc1pGTmNN?=
 =?utf-8?B?OVhEeGQvZlY3UWY4U09CNFRBc2RKKzB5YUZieDZ4Wis4emN5U0F1a1VRS3JO?=
 =?utf-8?B?Vmd5eGpQdDkxekdzMDkvZElmZUEwTHI1MVdVVnBRaGlncU5yNjBhTEZSc1RV?=
 =?utf-8?B?bnFFRDB3bTBDaGlZTHpUOXMxOXdodUpUV1VUcXp0enF3WW94RGx3dkROQnF2?=
 =?utf-8?B?Qk5QZ0xTZWZnVjdReDNWdUpkUEltTVFuTW5tKzNBb1UyeGFLQnJvZ3d1N3E2?=
 =?utf-8?B?RHJXUkRtVW5XZ0dBVHVTV0Fncy9qWVVLcjNKeUFmVjU3ZzZOSkViVUpSbkdZ?=
 =?utf-8?B?WEFrR3BZckMyOE5HVGc5Q3k2Wmo4ZG9JVDVuTGRmQlVLZVJGVUVCTnhOb0Ux?=
 =?utf-8?B?NDRSRlB5S2RNV1BjTWhSZU04RE1iM0VkY1ozVEFnZUxDMU9GSWFwTm83SEEv?=
 =?utf-8?B?T044SVJueVJHc2hOcGIwRld5a29rSFliNlkvSW1NSm53ZjRBbXA4eVM5M1lh?=
 =?utf-8?B?MFp3MUZaYW9qYUJJcHN0L0FLKzNYdzlnNFh0N29DVk9UZUVlcElNRnhpVnI1?=
 =?utf-8?B?eVJ3NDFYNkV2TEsxVFY5ZUgvSVArMzNXYmtnL0xSUGhwMFlMY08zVzBZNnhh?=
 =?utf-8?B?TWlLUyszZEhITFFPU0F2bnRJbnBSOWt1MVZMWnZyaWdpYTFVU1RZc3RaU1o3?=
 =?utf-8?B?VWVDbzN5MWV3N2ZFT3g0UkFTZk92SnZNLzh3RmdMZHFla1UxclBBcmY4VTQ0?=
 =?utf-8?B?K29zUjRzaDkrZC9odTVhKzVUd1c0UjlrSzQ4R2wvQmdLNE4zbW4rRG5nNFpO?=
 =?utf-8?B?ZW9xRWw1cW5KTEZzMysvclpMb1NveTY2WjRkWCtyR1N6VHdQcjZaeXhaVGRR?=
 =?utf-8?B?dFoxMW1MZ1lYaEhiRjQzSnlCOGdldzNEelA0dXQzNkVWajk1VlJTWXFyVlZu?=
 =?utf-8?B?RE13UDBpL2RxTERxdDJjZkZGdmxUSER0ZjlCQ29udDM3MWUyS0VCMVk0UjRZ?=
 =?utf-8?B?RVhUNU9kQnZBTXA3bkJKMDd1L1F5REZ0NmhiWEM0ZVd0NlVwYVlEM0RXTVRr?=
 =?utf-8?B?cXAwd3ZQMGxPM1ZmcXl1NVg0cE0rTWNhOE55cEFIVFY0QjA3Y0dEOE8xcXNO?=
 =?utf-8?B?emI3azc2Y00zVzMzSk9hRXI0a3phdkJqMEIxMFpHYjVGOGh2YVFuaTVlQUI1?=
 =?utf-8?B?bzRHSVlZdERnN1Y2bm1DcWljSUVSbWM2OHdNWnVMczhsTU5DUFlVdkV5ME1u?=
 =?utf-8?B?VmNiaXVldXBQd2RKbFNPQ0FVd0tXSTFpU3ZDNmw3bUNqVXNmUlNnMjBQVThu?=
 =?utf-8?B?V0JXRHovSUYvcnczMnhJam13a3VUU3dabUEycy9YaER2eXRvYXZ1Ynp5ZGUw?=
 =?utf-8?B?QXJCaUgxbzIzaDFlemttK0RhR1d0a0xIYnBZSlluSFQvTVNwc2djZlVjeklx?=
 =?utf-8?B?YUNEblI2bzFpQzBNeVZoeGdmc1B0OHBQSS82VFhGdmJwRnF5NVpxQVBBNHBr?=
 =?utf-8?B?SEVuTG54ODRIQklOYldSWklXdy8rVVJTWld5VzExSTNCSkgyVjdxZVR5MlM5?=
 =?utf-8?B?OEhyYXhUYkJSUGdDVlg0bnBYV2xNZUVkaG9UcU85OXBkMUNvck9xRUtnPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ekpGZWgycGhydm1iczMzRXh1YVJ4d3ljN2R6c2hwYm4wZitlRmRmaGNXKzlw?=
 =?utf-8?B?ZVdEdFpITE02MjhUTlpXanhzM3djQnA2R3dtR0taa21HV25raEt4VFBwTXd5?=
 =?utf-8?B?YlZ3WVFtdk9KYWYyazBON1lHdm50WEc4M01kaU40S1h0aXI5V0lPQ0lpcUIr?=
 =?utf-8?B?Z3FaU2xiZjc2Sy9nZjJXRUkxWXpTNDdWRmxKaEhtY3VRNGlMQTRhMEQyenQz?=
 =?utf-8?B?YlZ1RVhMNEJTL2hSNDlScUR2S3pYK05aRzNZemNiOW9FNDRHRW9xVit0blZy?=
 =?utf-8?B?TnJhb010L2hBRCtYUlNqZVQyK0NlQ2x1SGgrcE5GYmJGWU9DOTZWTVIwTW5z?=
 =?utf-8?B?bXkrck0wQ2lYVVIwRS9wSC9acU83WEV5RG5tZVJzZndaMHcxODVVN2E2RmVn?=
 =?utf-8?B?MkZHandqZG5tOGVuY1BIeVd4RloxdTVGalkzODA2dDM0VCtsMG5sSllBYXBE?=
 =?utf-8?B?blVnWlkvRWJ5SXA3aVdwRVRuS213UE9EZ3Y1aEo4WTNxSkl4cEdvdlFPTHB1?=
 =?utf-8?B?R0xOZWoweDdhVC80VVNrbE5tMXRsa3ljQWlHa3l6aGd4THRoREtZU2lWUnNP?=
 =?utf-8?B?VkhMRGQ4RkZRRkwvbVh1YVY5b3BBMjhEVHN5dFkzMXJMRDhISUJEaFU2QndY?=
 =?utf-8?B?RU1IMUhHdGJXSFpjZXg5T0E0ekRHc2N6Yks2Y0l2aUR1cmhOMlVQZWJrYkhY?=
 =?utf-8?B?NXc2SVJvajZIcFpjODloVUFrZHNldXpsTHBhTUFaTjd6Um9vYkFKbFlCbUhV?=
 =?utf-8?B?emsyeEY4dHFMUjlJNE1kR2pna2VmbEVZOG9sK2RNM0lEUFg1b1hiSGxYTHkz?=
 =?utf-8?B?UjhZSlpqQXRTOWhFQkJUL0lvMXlCejdwai9FQk5XWXZFakI4V1JSZmNhd1pD?=
 =?utf-8?B?UTVJNmRqNlByMVJSdTJBNG1yYUdjMzl6dnhsNmhWamh2U3NoU2Jjb3gwcUVv?=
 =?utf-8?B?L0RpL1V5Y0hZcTR6dnlxbXVaZllTR01JZno4ODNPZHorelo2bXNwdXhja2Fo?=
 =?utf-8?B?dkJnb093U2lJdm5pV1RGaUpTblYvb3Q2cEQzMFBsME5GalFZdGxrbFYrOWxn?=
 =?utf-8?B?UUs0ZkxkeFA3SmgvUDZOSlZPcDNubE1CSWZRckp5RFkwODR5VTVQUW92WnRx?=
 =?utf-8?B?MzhvRkJsNnAyTGVnZUtVM2tzYVEzTy9CS3M2V1JTY3VscFgyS2lyS2RFcU1i?=
 =?utf-8?B?WFRnc1lCVW5sU0F0SUdyeW56UEc4TTNCZkw3MnN4QThnM0RKUmoxVHFRTGtO?=
 =?utf-8?B?VmpBSnNoRU83WG5Ta3l2enljZDVwMGtIMnZVTWN0MS9XMUxreHowUmlvNk5D?=
 =?utf-8?B?STBvYTJlTzNzUUQ5ZzJnUExjU1JEZHEvS0ppVDI4aGVBdzNodE5OeXpac2lE?=
 =?utf-8?B?NnVPM2hoMDBDWHo5NDJNbFRtWWdyYW1kb1EwZ1FXK0ViZVRpVXNrSitDWlMy?=
 =?utf-8?B?bU1iV2tick1pTjBjVEtnY29zVDEvUmVrQis5ZzdpcUZGYkhWRTc3SXdRY241?=
 =?utf-8?B?MEZsU3VxUmorekIrQ3paSEs5ZnhBc0luNHBBL1ZleVEyY0V4ZlVEOEZXYUxZ?=
 =?utf-8?B?RnA3Q3d4bTlXYjRWaElEakU4NUQ4Yjc5c0k5eE5DaFRPeWNEOE0yUXZrTW1w?=
 =?utf-8?B?bWtGeTBRTHh2di9QR1hvY0J1cnA3cW1RQW80bGlIdm9nSUFJNG1GWUE2bmdM?=
 =?utf-8?B?MU5SbjBDZDRWV04rMEtsRUM4d2c4K3hTSVVwRWd5c3Q0ajlBUnFEdWU0eDVp?=
 =?utf-8?B?SFJZNzRZOTZ6RzZWWjFKNmJhL0hud1JnVzc4eVYvQzRtMXp5Mnk0bVQyMzlm?=
 =?utf-8?B?YnR6bW5FdmVTNnpvaCtRR3gwNi80eTJuK01hbjZCMlRmMUhLVy80YS9jdHN0?=
 =?utf-8?B?MFdjQjBoNzJMeDdsYy9NejdMaE8yRmdSaEMxMHErUjNlRklvTS92eXJTbGJT?=
 =?utf-8?B?VXhGQTFxdWFpL3Nwb0ZzSk4wR08xTmxwMk80QWFzYnFSajZzOXB0MmpBWDc5?=
 =?utf-8?B?OTlFK2FScTRvak5RaUQ2NnNuYk9jTUhkM0JyZ0tuTlAwOVluYU4zU0RwcnlN?=
 =?utf-8?B?SW9Vc0VZWTVXdXc4YjhXRjBFQXRuN0h3UUx3MU9tdll4UHcyNm9qa3RtRVZG?=
 =?utf-8?Q?xUwtKDOpZMWP9KUrCZm50WvYB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <32B897E82079BE42A3760A3F08195D9B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	wlepnaHDxniZPNve+EkdAcPj2SYoNsBWP4hBYhThcaiEgApjJmNu0L6BwIdpUO3g0Bwg7GDI2pbL1tYCaf41ev3NkssY04LbLdrIf7TNVxTRT7kYW9cd6wf+MMgbvXN3ehhrEeA2JN3CSgb8Aioo84cexb+nnNb9Br7MXlaoCzITBy/zPBJr+olfpisnOooox9qf51UlnKJUm/AJZ6JKSwU4fHWzky1u/2Jq+iHN1qp8KMo4Ief+t19xaZD0ppNqsDyV4rgGvevNSVrxTjnsca8OEXQ+r1GWTtd8cY4/hEjkY8c0IWWEzvkqwin9zRHbcRoBCB/xgQ8lt7MfyX1010bYemLsnk8cWTam7KyCm79zKn4SOjs9ohIjEfsMJDoxs5HcBKhLaeJ4kjU/06zBG8bp0Q8u1TKOuKGghMp0cfw/BWj1hcVPpKZuqzZN/f9pRYAk51xY0jXblzQZNfJhQesbSfhYeduVuh0li8z9Ut1lnMLLEsuaY9mDRL1eeQefWylJO6MpGRdmEOf3SEqZ0N+fUdsEGkw40SS7tujh13xcVi6v/7Z36NhtQO1VX/9C9bIb++lWkzPx+RgPYlPoWxJ8chY+vUYrQKTDUqIfInyne5B10O4by/Shf1SUmp/jcCCABhKNe5lC/4sAJPdmWA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8704b0ee-94c5-4077-8cf3-08dc7610d40a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2024 01:29:42.8373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2JWZn8y0nY0OghQSTz9uYRclypRpWkg2ekcJZyTlwO1EGU/XfnjIwMOLJ1hm3T8/t/qXwEBP0FHLxXZXL+VjMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8866
X-Proofpoint-GUID: 9ONxY4ERJlLqgjo9VLa-3ul2BMur4TYD
X-Proofpoint-ORIG-GUID: 9ONxY4ERJlLqgjo9VLa-3ul2BMur4TYD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_07,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 bulkscore=0 adultscore=0 spamscore=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 phishscore=0 suspectscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2405010000
 definitions=main-2405170010

T24gU3VuLCBNYXkgMTIsIDIwMjQsIE1pY2hhZWwgR3J6ZXNjaGlrIHdyb3RlOg0KPiBPbiBTYXQs
IE1heSAxMSwgMjAyNCBhdCAxMjo1MTo1N0FNICswMDAwLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+
ID4gT24gVGh1LCBNYXkgMDksIDIwMjQsIE1pY2hhZWwgR3J6ZXNjaGlrIHdyb3RlOg0KPiA+ID4g
T24gV2VkLCBNYXkgMDgsIDIwMjQgYXQgMTE6MDM6MDBQTSArMDAwMCwgVGhpbmggTmd1eWVuIHdy
b3RlOg0KPiA+ID4gPiBPbiBTdW4sIE1heSAwNSwgMjAyNCwgTWljaGFlbCBHcnplc2NoaWsgd3Jv
dGU6DQo+ID4gPiA+ID4gT24gV2VkLCBBcHIgMjQsIDIwMjQgYXQgMDE6NTE6MDFBTSArMDAwMCwg
VGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4g
PiA+IFJpZ2h0LiBVbmZvcnR1bmF0ZWx5LCBkd2MzIGNhbiBvbmx5ICJndWVzcyIgd2hlbiBVVkMg
ZnVuY3Rpb24gc3RvcHMNCj4gPiA+ID4gPiA+IHB1bXBpbmcgbW9yZSByZXF1ZXN0IG9yIHdoZXRo
ZXIgaXQncyBkdWUgdG8gc29tZSBsYXJnZSBsYXRlbmN5LiBUaGUNCj4gPiA+ID4gPiA+IGxvZ2lj
IHRvIHdvcmthcm91bmQgdGhpcyB1bmRlcnJ1biBpc3N1ZSB3aWxsIG5vdCBiZSBmb29scHJvb2Yu
IFBlcmhhcHMNCj4gPiA+ID4gPiA+IHdlIGNhbiBpbXByb3ZlIHVwb24gaXQsIGJ1dCB0aGUgc29s
dXRpb24gaXMgYmV0dGVyIGltcGxlbWVudCBhdCB0aGUgVVZDDQo+ID4gPiA+ID4gPiBmdW5jdGlv
biBkcml2ZXIuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBZZXMsIHRoZSBiZXN0IHdheSB0byBzb2x2
ZSB0aGlzIGlzIGluIHRoZSB1dmMgZHJpdmVyLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBJIHRo
b3VnaHQgd2UgaGF2ZSB0aGUgbWVjaGFuaXNtIGluIFVWQyBmdW5jdGlvbiBub3cgdG8gZW5zdXJl
IHF1ZXVpbmcNCj4gPiA+ID4gPiA+IGVub3VnaCB6ZXJvLWxlbmd0aCByZXF1ZXN0cyB0byBhY2Nv
dW50IGZvciB1bmRlcnJ1bi9sYXRlbmN5IGlzc3VlPw0KPiA+ID4gPiA+ID4gV2hhdCdzIHRoZSBp
c3N1ZSBub3c/DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBUaGlzIGlzIGFjdHVhbGx5IG9ubHkgcGFy
dGlhbGx5IHRydWUuIEV2ZW4gd2l0aCB0aGUgemVyby1sZW5ndGggcGFja2FnZXMNCj4gPiA+ID4g
PiBpdCBpcyBwb3NzaWJsZSB0aGF0IHdlIHJ1biBpbnRvIHVuZGVycnVucy4gVGhpcyBpcyB3aHkg
d2UgaW1wbGVtZW50ZWQNCj4gPiA+ID4gPiB0aGlzIHBhdGNoLiBUaGlzIGhhcyBoYXBwZW5lZCBi
ZWNhdXNlIGFub3RoZXIgaW50ZXJydXB0IHRocmVhZCB3aXRoIHRoZQ0KPiA+ID4gPiA+IHNhbWUg
cHJpbyBvbiB0aGUgc2FtZSBDUFUgYXMgdGhpcyBpbnRlcnJ1cHQgdGhyZWFkIHdhcyBrZWVwaW5n
IHRoZSBDUFUNCj4gPiA+ID4NCj4gPiA+ID4gRG8geW91IGhhdmUgdGhlIGRhdGEgb24gdGhlIHdv
cnN0IGxhdGVuY3k/DQo+ID4gPiANCj4gPiA+IEl0IHdhcyBzb21ldGhpbmcgYSBiaXQgbW9yZSB0
aGVuIGFyb3VuZCAybXMgQUZBSVIuIFNpbmNlIHdpdGggb25lIGZyYW1lDQo+ID4gPiBlbnF1ZXVl
ZCB3ZSBvbmx5IHRyaWdnZXIgdGhlIGludGVycnVwdCBldmVyeSAxNiByZXF1ZXN0cyAoMTYqMTI1
dXMgPSAybXMpDQo+ID4gPiANCj4gPiA+IFNvIHdpdGggYXQgbGVhc3QgMm1zIGxhdGVuY3kgd2Ug
ZGlkIGhpdCB0aGUgc3dlZXQgc3BvdCBpbiBzZXZlcmFsIGNhc2VzLg0KPiA+IA0KPiA+IEZvciAy
bXMsIHdlIHNob3VsZCBiZSBhYmxlIHRvIGhhbmRsZSB0aGlzIHdpdGggdGhlIHplcm8tbGVuZ3Ro
IHJlcXVlc3RzLg0KPiANCj4gV2hlbiB0aGUgaW50ZXJydXB0IHRocmVhZCBpcyB0aGUgb25lIHRo
YXQgaXMgZW5xdWV1aW5nIGFsc28gdGhlDQo+IHplcm8tcmVxdWVzdHMgKGxpa2UgdGhlIHV2Y192
aWRlbyBnYWRnZXQpIGlzIGRvaW5nIG5vdywgd2Ugd29uJ3QgYmUgYWJsZQ0KPiB0byBkbyB0aGF0
Lg0KDQpIb3cgbG9uZyBkb2VzIGVucXVldWluZyB0YWtlPyBEb2VzIGl0IHRha2UgbG9uZ2VyIHRo
YW4gdGhlIG51bWJlciBvZg0KaW50ZXJ2YWxzIHRoYXQgaXQgZW5xdWV1ZXM/DQoNCj4gDQo+ID4g
PiANCj4gPiA+ID4gQ2FuIHRoaXMgb3RoZXIgaW50ZXJydXB0IHRocmVhZCBsb3dlciBpdHMgcHJp
b3JpdHkgcmVsYXRpdmUgdG8gVVZDPyBGb3INCj4gPiA+ID4gaXNvYyBlbmRwb2ludCwgZGF0YSBp
cyB0aW1lIGNyaXRpY2FsLg0KPiA+ID4gDQo+ID4gPiBUaGUgZGV0YWlscyBhcmUgbm90IHRoYXQg
aW1wb3J0YW50LiBTdXJlIHRoZSBpcyBhIGJ1ZywgdGhhdCBuZWVkZWQgdG8gYmUNCj4gPiA+IHNv
bHZlZC4gQnV0IGFsbCBJIHdhbnRlZCBpcyB0byBpbXByb3ZlIHRoZSBvdmVyYWwgZHdjMyBkcml2
ZXIuDQo+ID4gPiANCj4gPiA+ID4gQ3VycmVudGx5IGR3YzMgY2FuIGhhdmUgdXAgdG8gMjU1IFRS
QnMgcGVyIGVuZHBvaW50LCBwb3RlbnRpYWxseSAyNTUNCj4gPiA+ID4gemVyby1sZW5ndGggcmVx
dWVzdHMuIFRoYXQncyAyNTUgdWZyYW1lLCBvciByb3VnaGx5IH4zMG1zLiBJcyB5b3VyIHdvcnN0
DQo+ID4gPiA+IGxhdGVuY3kgbW9yZSB0aGFuIDMwbXM/IGllLiBubyBoYW5kbGluZyBvZiB0cmFu
c2ZlciBjb21wbGV0aW9uIGFuZA0KPiA+ID4gPiBlcF9xdWV1ZSBmb3IgdGhlIHdob2xlIDI1NSBp
bnRlcnZhbHMgb3IgMzBtcy4gSWYgdGhhdCdzIHRoZSBjYXNlLCB3ZQ0KPiA+ID4gPiBoYXZlIHBy
b2JsZW1zIHRoYXQgY2Fubm90IGp1c3QgYmUgc29sdmVkIGluIGR3YzMuDQo+ID4gPiANCj4gPiA+
IFllcy4gQnV0IGFzIG1lbnRpb25lZCBhYm92ZSwgdGhpcyB3YXMgbm90IHRoZSBjYXNlLiBTcGVh
a2luZyBvZiwgdGhlcmUNCj4gPiA+IGlzIGN1cnJlbnRseSBhIGJ1ZyBpbiB0aGUgdXZjX3ZpZGVv
IGRyaXZlciwgdGhhdCBpcyBub3QgdGFraW5nIGludG8NCj4gPiA+IGFjb3VudCB0aGF0IGFjdHVh
bGx5IGV2ZXJ5IHplcm8tbGVuZ3RoIHJlcXVlc3Qgc2hvdWxkIHdpdGhvdXQgZXhjZXB0aW9uDQo+
ID4gPiBuZWVkIHRvIHRyaWdnZXIgYW4gaW50ZXJydXB0Lg0KPiA+IA0KPiA+IE5vdCBuZWNlc3Nh
cmlseSwgeW91IGNhbiBzZW5kIG11bHRpcGxlIHNldCBvZiB6ZXJvLWxlbmd0aCByZXF1ZXN0cw0K
PiA+IHdoZXJlLCBmb3IgZXhhbXBsZSwgSU9DIG9uIHRoZSBsYXN0IHJlcXVlc3Qgb2YgdGhlIHNl
dC4NCj4gDQo+IFJpZ2h0LiBCdXQgZm9yIHRoaXMgd2UgaGF2ZSB0byBrbm93IGlmIHRoZSBsYXN0
IHJlcXVlc3QgdGhhdCB3aWxsIGJlDQo+IGVucXVldWVkIHdpbGwgYmUgZm9sbG93ZWQgYnkgYW4g
YWN0dWFsIGRhdGEgcmVxdWVzdC4gQXMgdGhlIHV2Y192aWRlbw0KPiBnYWRnZXQgaXMgaW1wbGVt
ZW50ZWQgbm93LCB3ZSBjYW4gbm90IGRvIHRoaXMuDQo+IA0KPiBJdCBpcyBvbmx5IGNoZWNraW5n
IGlmIHRoZSBwcmVwYXJlZCBsaXN0IGlzIGVtcHR5IGFuZCB0aGVuIGl0IGlzDQo+IGVucXVldWVp
bmcgemVybyBvciBkYXRhIHJlcXVlc3RzIGZyb20gdGhlIGNvbXBsZXRlIGhhbmRsZXIgZGVwZW5k
aW5nDQo+IGZyb20gdGhlIG91dGNvbWUuIEl0IGRvZXMgbm90IGtub3cgaWYgb24gdGhlIG5leHQg
ZW5xdWV1ZSB0aGUgcHJlcGFyZWQNCj4gbGlzdCB3aWxsIGhhdmUgc29tZSByZXF1ZXN0cyByZWFk
eS4NCg0KQ2FuIHdlIGNoZWNrIGlmIHRoZSBwcmVwYXJlIGxpc3Qgc2hvdWxkIGFsd2F5cyBoYXZl
IFggYW1vdW50IG9mIHJlcXVlc3RzDQppbnN0ZWFkIG9mIGVtcHR5PyBJZiBub3QsIGZpbGwgdGhh
dCB1cCB0byB0aGUgWCBhbW91bnQgd2l0aCB6ZXJvLWxlbmd0aA0KcmVxdWVzdHMuDQoNCkJSLA0K
VGhpbmgNCg0KPiANCj4gPiA+IEN1cnJlbnRseSB3ZSBhbHNvIG9ubHkgc2NhdHRlciB0aGVtIG92
ZXINCj4gPiA+IHRoZSAxNm1zIHBlcmlvZCwgbGlrZSB3aXRoIHRoZSBhY3R1YWwgcGF5bG9hZC4g
QnV0IHNpbmNlIHdlIGZlZWQgdGhlDQo+ID4gPiB2aWRlbyBzdHJlYW0gd2l0aCB0aGUgaW50ZXJy
dXB0cywgd2UgbG9vc2UgMm1zIG9mIHBvdGVudGlhbCBlcF9xdWV1ZQ0KPiA+ID4gY2FsbHMgd2l0
aCBhY3R1YWwgcGF5bG9hZCBpbiB0aGUgd29yc3QgY2FzZS4NCj4gPiA+IA0KPiA+ID4gTXkgcGF0
Y2ggaXMgYWxyZWFkeSBpbiB0aGUgc3RhY2sgYW5kIHdpbGwgYmUgc2VuZCB0b2RheS4NCj4gPiA+
IA0KPiA+ID4gPiA+IGJ1c3kuIEFzIHRoZSBkd2MzIGludGVycnVwdCB0aHJlYWQgZ2V0IHRvIGl0
cyBjYWxsLCB0aGUgdGltZSB3YXMgYWxyZWFkeQ0KPiA+ID4gPiA+IG92ZXIgYW5kIHRoZSBodyB3
YXMgYWxyZWFkeSBkcmFpbmVkLCBhbHRob3VnaCB0aGUgc3RhcnRlZCBsaXN0IHdhcyBub3QNCj4g
PiA+ID4gPiB5ZXQgZW1wdHksIHdoaWNoIHdhcyBjYXVzaW5nIHRoZSBuZXh0IHF1ZXVlZCByZXF1
ZXN0cyB0byBiZSBxdWV1ZWQgdG8NCj4gPiA+ID4gPiBsYXRlLiAoemVybyBsZW5ndGggb3Igbm90
KQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gWWVzLCB0aGlzIG5lZWRlZCB0byBiZSBzb2x2ZWQgb24g
dGhlIHVwcGVyIGxldmVsIGZpcnN0LCBieSBtb3ZpbmcgdGhlDQo+ID4gPiA+ID4gbG9uZyBydW5u
aW5nIHdvcmsgb2YgdGhlIG90aGVyIGludGVycnVwdCB0aHJlYWQgdG8gYW5vdGhlciB0aHJlYWQg
b3INCj4gPiA+ID4gPiBldmVuIGludG8gdGhlIHVzZXJzcGFjZS4NCj4gPiA+ID4NCj4gPiA+ID4g
UmlnaHQuDQo+ID4gPiA+DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBIb3dldmVyIEkgdGhvdWdodCBp
dCB3b3VsZCBiZSBncmVhdCBpZiB3ZSBjb3VsZCBzb21laG93IGZpbmQgb3V0IGluDQo+ID4gPiA+
ID4gdGhlIGR3YzMgY29yZSBhbmQgbWFrZSB0aGUgcHVtcCBtZWNoYW5pc20gbW9yZSByb2J1c3Qg
YWdhaW5zdCBzdWNoDQo+ID4gPiA+ID4gbGF0ZSBlbnF1ZXVlcy4NCj4gPiA+ID4NCj4gPiA+ID4g
VGhlIGR3YzMgY29yZSBoYW5kbGluZyBvZiBldmVudHMgYW5kIGVwX3F1ZXVlIGlzIHJlbGF0aXZl
bHkgcXVpY2suIEknbQ0KPiA+ID4gPiBhbGwgZm9yIGFueSBvcHRpbWl6YXRpb24gaW4gdGhlIGR3
YzMgY29yZSBmb3IgcGVyZm9ybWFuY2UuIEhvd2V2ZXIsIEkNCj4gPiA+ID4gZG9uJ3Qgd2FudCB0
byBqdXN0IGNvbnRpbnVlIGxvb2tpbmcgZm9yIHdvcmthcm91bmQgaW4gdGhlIGR3YzMgY29yZQ0K
PiA+ID4gPiB3aXRob3V0IGxvb2tpbmcgdG8gc29sdmUgdGhlIGlzc3VlIHdoZXJlIGl0IHNob3Vs
ZCBiZS4gSSBkb24ndCB3YW50IHRvDQo+ID4gPiA+IHNhY3JpZmljZSBjb21wbGV4aXR5IGFuZC9v
ciBwZXJmb3JtYW5jZSB0byBvdGhlciBhcHBsaWNhdGlvbnMgZm9yIGp1c3QNCj4gPiA+ID4gVVZD
Lg0KPiA+ID4gDQo+ID4gPiBJIHRvdGFsbHkgdW5kZXJzdGFuZCB0aGlzLiBBbmQgYXMgd2UgYWxy
ZWFkeSBmb3VuZCBvdXQgbW9yZSBhbmQgbW9yZQ0KPiA+ID4gYWJvdXQgdGhlIHVuZGVybHlpbmcg
Y29tcGxleGl0eSBvZiB0aGUgZHdjMyBkcml2ZXIgSSBzZWUgbW9yZSBhbmQgbW9yZQ0KPiA+ID4g
Y2xlYXJlciBob3cgd2UgaGF2ZSB0byBoYW5kbGUgdGhlIGNvcm5lciBjYXNlcy4gSSBqdXN0IHN0
YXJ0ZWQgdGhpcw0KPiA+ID4gY29udmVyc2F0aW9uIHdpdGggQXZpY2hhbCBhbmQgeW91IGluIHRo
ZSBvdGhlciB0aHJlYWQuDQo+ID4gPiANCj4gPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2Fs
bC8xNzE5MmUwZi03ZjE4LTQ5YWUtOTZmYy03MTA1NGQ0NmY3NGFAZ29vZ2xlLmNvbS8NCj4gPiA+
IA0KPiA+ID4gSSB0aGluayB0aGVyZSBpcyBzb21lIHdvcmsgdG8gY29tZS4gQXMgdG8gYmUgc3Vy
ZSB0aGF0IGV2ZXJ5Ym9keSBpcyBvbg0KPiA+ID4gdGhlIHNhbWUgcGFnZSBJIHdpbGwgcHJlcGFy
ZSBhIHJvYWRtYXAgb24gaG93IHRvIHByb2NlZWQgYW5kIHdoYXQgdG8NCj4gPiA+IGRpc2N1c3Mu
IFRoZXJlIGFyZSBtYW55IGNhc2VzIGludGVyZmVyaW5nIHdpdGggZWFjaCBvdGhlciB3aGljaCBt
YWtlIHRoZQ0KPiA+ID4gc29sdXRpb24gcHJldHR5IGNvbXBsZXguDQo+ID4gDQo+ID4gVGhhdCdz
IGdyZWF0LiBMZXQncyBkbyB0aGF0IHNvIHdlIGNhbiByZXNvbHZlIHRoaXMgaXNzdWUuDQo+IA0K
PiBHb29kDQo+IA0KPiA+ID4gPiA+IFRoaXMgYWxsIHN0YXJ0ZWQgd2l0aCB0aGF0IHNlcmllcy4N
Cj4gPiA+ID4gPg0KPiA+ID4gPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI0MDMw
Ny1kd2MzLWdhZGdldC1jb21wbGV0ZS1pcnEtdjEtMC00ZmU5YWMwYmEyYjdAcGVuZ3V0cm9uaXgu
ZGUvDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBBbmQgcGF0Y2ggMiBvZiB0aGlzIHNlcmllcyBkaWQg
d29yayB3ZWxsIHNvIGZhci4gVGhlIG5leHQgbW92ZSB3YXMgdGhpcw0KPiA+ID4gPiA+IHBhdGNo
Lg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gU2luY2UgdGhlIGxhc3Qgd2VlayBkZWJ1Z2dpbmcgd2Ug
Zm91bmQgb3V0IHRoYXQgaXQgZ290IG90aGVyIGlzc3Vlcy4NCj4gPiA+ID4gPiBJdCBpcyBub3Qg
YWxsd2F5cyBzYXZlIHRvIHJlYWQgdGhlIEhXTyBiaXQsIGZyb20gdGhlIGRyaXZlci4NCj4gPiA+
ID4gPg0KPiA+ID4gPiA+IFR1cm5zIG91dCB0aGF0IGFmdGVyIGFuIG5ldyBUUkIgd2FzIHByZXBh
cmVkIHdpdGggdGhlIEhXTyBiaXQgc2V0DQo+ID4gPiA+ID4gaXQgaXMgbm90IHNhdmUgdG8gcmVh
ZCBpbW1pZGVhdGx5IGJhY2sgZnJvbSB0aGF0IHZhbHVlIGFzIHRoZSBodw0KPiA+ID4gPiA+IHdp
bGwgYmUgZG9pbmcgc29tZSBvcGVyYXRpb25zIG9uIHRoYXQgZXhhY3RseSBuZXcgcHJlcGFyZWQg
VFJCLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gV2UgcmFuIGludG8gdGhpcyBwcm9ibGVtIHdoZW4g
YXBwbHlpbmcgdGhpcyBwYXRjaC4gVGhlIHRyYiBidWZmZXIgbGlzdA0KPiA+ID4gPiA+IHdhcyBh
Y3R1YWxseSBmaWxsZWQgYnV0IHdlIGhpdCBhIGZhbHNlIHBvc2l0aXZlIHdoZXJlIHRoZSBsYXRl
c3QgSFdPIGJpdA0KPiA+ID4gPiA+IHdhcyAwIChwcm9iYWJseSBkdWUgdG8gdGhlIGh3IGFjdGlv
biBpbiB0aGUgYmFja2dyb3VuZCkgYW5kIHRoZXJlZm9yDQo+ID4gPiA+ID4gd2VudCBpbnRvIGVu
ZCB0cmFuc2Zlci4NCj4gPiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiBUaGFua3MgZm9yIHRoZSB1
cGRhdGUuDQo+ID4gPiANCj4gPiANCj4gDQo+IC0tIA0KPiBQZW5ndXRyb25peCBlLksuICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfA0KPiBT
dGV1ZXJ3YWxkZXIgU3RyLiAyMSAgICAgICAgICAgICAgICAgICAgICAgfCBodHRwOi8vd3d3LnBl
bmd1dHJvbml4LmRlLyAgfA0KPiAzMTEzNyBIaWxkZXNoZWltLCBHZXJtYW55ICAgICAgICAgICAg
ICAgICAgfCBQaG9uZTogKzQ5LTUxMjEtMjA2OTE3LTAgICAgfA0KPiBBbXRzZ2VyaWNodCBIaWxk
ZXNoZWltLCBIUkEgMjY4NiAgICAgICAgICAgfCBGYXg6ICAgKzQ5LTUxMjEtMjA2OTE3LTU1NTUg
fA0KDQo=

