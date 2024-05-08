Return-Path: <linux-kernel+bounces-173950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AFC8C0822
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 01:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 268A21C212F4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 23:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B28133993;
	Wed,  8 May 2024 23:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="bXQITlap";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="X1iwDSTL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="klqZZWCG"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036ED28387;
	Wed,  8 May 2024 23:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715212409; cv=fail; b=udxSA9P/p6J+0N4Z2h4fjXCsvkKiEZVsISGYKjbONp5xnm8VEQagFI/x2AQUM1del3NhWWruKLEMj1oH8uKQI6grgM1QVN+4vbhZRZA9yqHi219ywagahfRmmBGmIXoik5dbwyxswDu+p8dmX7RMX7eFYQGFyUEoAfyd0+ThzW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715212409; c=relaxed/simple;
	bh=Ldyog+IbdTsV9IB/bEMj3Ys4LNKDUtHDTTozUcCexg4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Kv3Px540shgsFavcK+JcffQ1LnhLpESKNN59+mrkZK2bzGcFEe+5d9/Ks15Ff8Zscr2ZAj0ASfJNykNGUYe3DgbMGjd1fzvmjbU4ESj+AHumBHkX9INEVhW4Yenf6YZpCvPVEZL29oKe1hItVV3LMYOqg3YTsnyn1VJjrnpui4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=bXQITlap; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=X1iwDSTL; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=klqZZWCG reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 448KYxeX025587;
	Wed, 8 May 2024 16:03:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=Ldyog+IbdTsV9IB/bEMj3Ys4LNKDUtHDTTozUcCexg4=; b=
	bXQITlapIDq2YWQON43zuGGwkjJVwvESJKlLEkJrx0JYq1ympVGIJtpsb757Abel
	U/ONnKqKoIwhvTKIuRwM8hIADIKJKbSsGrGhBk4pUtde6g12Fu8ucOoP+SdSFPh2
	yWU8pAdm8Rei3yAzdHLbAKoHn/76uRozJeL97WncorvORaoFZQW91CJyqSUrQit/
	X4hBBALzPD7rYgFYjQPQjeoSllDfWxLrq6tTMU4xU2eFazlBq/qQ0+IcZjZP4/Qb
	CPf5BjJZZ7WW8MFFXxqijd98rpa2Si3NsLkbkEVB2H0bDyG4fj7izsRxskRR6/J8
	Wt93i3bEPCs3STORdguETw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3xysknwvtm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 16:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1715209388; bh=Ldyog+IbdTsV9IB/bEMj3Ys4LNKDUtHDTTozUcCexg4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=X1iwDSTLtjeh/CALLP7VKFlZqLiI/csaPya75h3bT/zxliEdTb4MJy6hOJWUrygJo
	 V2KbiK1hA1Zb9vbzO7d+rCOGxByWS6eAJVlu/AR9DI48FINrs/m0OUJZllxsrk6E9+
	 AlZ68angB+gHCoXTGV8pv+epb1rkp5PJM9uqRwkpb0sJK9PTamlbhII8+ypOf1tTzs
	 /s+K2lBhXwvFq3/kdYGxGhdDgpCSawF/rlecBmcoY9PQxXVv5DVz8wptApl6AtPKAc
	 OmExFqWSM20r0MLZWi7tBCubDqvL9ZwMnU0IAqLXOkDfILFJ7E8OmLxGccnrMDpS2P
	 BhxXMcuq7DiFA==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 843C740408;
	Wed,  8 May 2024 23:03:08 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 6C6FAA0063;
	Wed,  8 May 2024 23:03:08 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=klqZZWCG;
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 5A2CF40364;
	Wed,  8 May 2024 23:03:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GzDuqAVUOETxLG4WRU7KFIyrCC1z2iDwXMLBsCNNaGDEiXvAXN8jUUN/hRecYOsaDToNff+XEPG40gZNAWgJuVKFDeqZu9H1P7YdZcsu1ONgvUQ0MvXXGed+qHC87mVmplRlXYkWCiDttWmXhRD1r0ViUnZx+BNN5R+oaVLzxKvRtlwGngs5R/6Qt+qCIvXCfixmUhInXGu1UnCTLEpfRJV9FJ8v47DL4pp2azRg9tDMl+7gkk+luc8/h3dLD/w2RzG4emxNjjrMlP60W57SQhfPmqhrVCMQemoUYRTr5fAahZVe09HCZLdyk1KEObtTqcHDe5MsKHoD6Ql9iqmugg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ldyog+IbdTsV9IB/bEMj3Ys4LNKDUtHDTTozUcCexg4=;
 b=KHB0wzdWCJqTSrW2+LoTJ1PKEf7sYQ/9LKojdHyaxl2w2aRtbRP8uGhfR0QuiFVHj5JbIqqOiG1AoqcnpU4hpux1WZmBB9k8ul02rjXwNgW3LMlGjYm9tHJkOr/k+4haUyXfm4XSLQdCcbfNoPrDviyw3LaJasWTzBGXRAWt8WjKLM/x3dzLIisA+L6qXCF52t1mUsyGt4Q4hTgWuAtsRU61GRrUaSbW8q0oJdp+efniil3jWhIn3jSKDeQ7v+zX4Xr4Uzw1NV+vK5JOelvTLXBy8/FpP4FdsEoJ5t/qru0r9GD0EXgoYb+EnQ7Wqzh4ld27dbwaLl2BMaWFDWv5xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ldyog+IbdTsV9IB/bEMj3Ys4LNKDUtHDTTozUcCexg4=;
 b=klqZZWCGENXqR5VFK40JFgAlG04tH/7mc8COq0TKaW/CWYfKCK3HyPx1vB7EuzswNMR7fSTfPKq/uYBF2ytc5VhsfoCw31Bo+wEQlR8g/SxuzlW+uOFjBMml0WeFomjgKQ+PPalADhslJGC4sq5mEgTMcjHgeVCiZP5/Le5jdDU=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CY5PR12MB6083.namprd12.prod.outlook.com (2603:10b6:930:29::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Wed, 8 May
 2024 23:03:00 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7827:b41a:c9d6:8e1d]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7827:b41a:c9d6:8e1d%7]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 23:03:00 +0000
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
 AQHahUf+Fjbt0R5rsESCdAPrKfiIcbFVmhGAgAADmgCAAaX5AIAeuKwAgADM1YCAESZwAIAGPZAA
Date: Wed, 8 May 2024 23:03:00 +0000
Message-ID: <20240508230252.wauttsgkp63fpife@synopsys.com>
References: 
 <20240307-dwc3-gadget-complete-irq-v2-1-8c5e9b35f7b9@pengutronix.de>
 <20240402230555.xgt5uilc42diyr4m@synopsys.com>
 <20240402231848.4hzzrxegjrcmdab2@synopsys.com>
 <20240404002906.wk6xbz2wp2tf2xwn@synopsys.com>
 <Zie5sN473m2rgNTK@pengutronix.de>
 <20240424015059.w7hsee4tt2ixkp5y@synopsys.com>
 <ZjbIeib2UMta7FbY@pengutronix.de>
In-Reply-To: <ZjbIeib2UMta7FbY@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CY5PR12MB6083:EE_
x-ms-office365-filtering-correlation-id: 8950ba11-d473-48e4-6713-08dc6fb3023a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?Y1VLak5ZSUNzY0tZYk5XTlNMZlljVkVlSVd5OE9pTjB6UllCMFFJVGJya1RB?=
 =?utf-8?B?UFZWZGlxeTRObUwwWXVJaEViRENXcDVwaW42aUwrcmEvMzhUVDlMZlJxOTNs?=
 =?utf-8?B?MUJ3NFJIZ0FPY0V2bjdRL2RJSDVvVzNUeHczNXUvbnJJdiswN2lScWtMaXQr?=
 =?utf-8?B?cVZUT25oWVBHa0Q4dWVZdmVPdkJLU3VKVW9qcGl2ZzlFWUQvVWFEWHJ2VkFu?=
 =?utf-8?B?VVZ2U0ZmTGpnVVQrQ1hwQkNiclZFNmJUSnFNWUk0Rm1BcTdhMUhIZFEwdkRr?=
 =?utf-8?B?b1dIN2xNQ0pxaFJVMWVpRHArTTVJalI0OExQSXo5S2czMm81MU5hUXRTM005?=
 =?utf-8?B?TWVKcTUrZ3hxRFRreVJCa0dhZ2R0bXlJaDBpcWY5TWcyVENWRU1GTzFIUHdK?=
 =?utf-8?B?cWxIYlVDd2hSM2JMNjMrYUdLWDNxREErcDFwWlFaa0NINmdMQjVxWHRXZGFF?=
 =?utf-8?B?N2QzMmVPKzVTQjVuMUlzVjVCTjRMU3BXd1FFR3QxbkRvYWdiUHlHZEl3aDZw?=
 =?utf-8?B?TGtlOGJQbFd0TXdVdWloZUlCRXlXSkVGMnltVXVpRWNKeEdvbjErRW1UWGcx?=
 =?utf-8?B?clZLeUhIYU9mMzBpOEwrOU5NOWlGNldXejFYbTNEOHF1YWdwZXRMaFllRGVl?=
 =?utf-8?B?ZWgrTUJXODJ4UkpMRFU4Y1BKL2RyNVNwOHpPQTdkbEo1N0RvOUlHamo1TjNt?=
 =?utf-8?B?c21GUHR0YW5OZVI1K1UrdElMN1htR0NsSHQxdmhEMDcreTlPNG9qSVpNTFlP?=
 =?utf-8?B?cER3b0M5RWdCUi9pcnJSd1UyMVJtK1lOTjg5UC9mdmdZMmp3RG9xYVFmVlQ2?=
 =?utf-8?B?T0JzTWhpa3NqN3lYa0RvNmhtVzMzZmd3QU5zOFJ0ZzZMNC9NbnVwdHBmOE9N?=
 =?utf-8?B?YXhvejFuM2pXOHd3QkJka3RMK1FIQWgzZmNqMEdTcWMrNjZYdG9FejkvaDBl?=
 =?utf-8?B?QmpwY0o0Q1kxZFZVakpHNHZnT091WGd6UTlHbU5oK3RTTm1ZMmFCcEtNa0d4?=
 =?utf-8?B?VTJVaGJLNXNhcUtLNTk1a1E2UXY4VXp6YThyUDlZN01kMDJoSlVyQTl5QldP?=
 =?utf-8?B?cjJ4NzVHbFJGN0pCNExlK3V2QWY3N2NaTjVMSnVPYTBIbkV3R05TeFVXRGkv?=
 =?utf-8?B?RHlWMk1laDgvVlJJT3dFWjJKK0NFQTU3Z0F3ZVJtOUp0bnBBZVl6WGFpZFY0?=
 =?utf-8?B?Q29ZdUU1c1NsdjFQeUZwN0daM3JQZ2pZT2NsWVFzSkdEMG1Ua3NmczRkWnVI?=
 =?utf-8?B?bXF5WFlTUERVbkMwYVAzZW53VGVwMjZLcDhvb0xHUU5QUVZ1dkVUZ24rZHpx?=
 =?utf-8?B?ZUthNkNmYjFVZFd4TEZnYWRsbFdnZGdHOUFTbWdlK2oyZW9LUzg5S0FPODRo?=
 =?utf-8?B?dDhhNGpWOHhjeDM1Vlo4elZGblVvbm5ZelZUOXNaQ1RJR00rNlk5NElFU1ZV?=
 =?utf-8?B?YzUrdWVzM2pYTzkvcG4zcmlmWDB3Q3RmZnloOHNIMEloQzh0aDU5UVBEaGJ5?=
 =?utf-8?B?T21la3J2TUQwQ05EMjRia0ZReHgvQzloSFZheVRva3paWjJXL3VCcDNYSEhv?=
 =?utf-8?B?Z3E0R0QyR3psZ0NiaGdjSlFEQlRqM1hBWXE1ZXdRcitVcEg2SU9KWC8xeXZV?=
 =?utf-8?B?YU1BSSs3RGJ1QW1oNllOK2oxUFg4c3lFMXAvN0tIT081U3B5ejFDMXI3eVI1?=
 =?utf-8?B?T0o4d2orNjd3UGZyM3JycnVxUVp6emJoY2FGSVhNTFMvUTMwN2lFZWpRPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?QmVlQlVINnpRemxRK3doK0lFVXhMcTJWcXpocjlHeFdkSlRFYW9QcUdXbklE?=
 =?utf-8?B?ODlBenR6ZW8vV204YURma3NkVE9ZdkNMd1VUTjZCT014MmpqVFpiN2kwZHA2?=
 =?utf-8?B?WXdYWkZNcUs2dmMxVGVvUGpCcHFvb3hvUmlQcGxuQkx2Z3N6VlNMdmdpUXVQ?=
 =?utf-8?B?NXVOdmlpb0V2NENlSy9tZGl6bVhJVTVJb0F2b3hDNWV2NVRYNzdFSDZOcStx?=
 =?utf-8?B?NVlVbTY0blpkcW5WVDBHY3RzU0FuSjZrVkIzWldPM2hCbHFNNGQ2ZVR3N2Nh?=
 =?utf-8?B?bTkyQU5meDZwUFNpVDJsK2JyUG5UWWJQR0gyMlA0NzRNcHh3SXNjU0pucEhk?=
 =?utf-8?B?bmh3T21OVENFeUpvbGx6bnA4YWJ6eUwxNGVsdTlod0NhN2Z0MVR4bi9mNE81?=
 =?utf-8?B?NmlkLzBUQ2wxR2lQZEhEYmhkUlZYZjJHcSszeWowVjNOS0YvcXlwZFVqejZC?=
 =?utf-8?B?eTdOZCs3TCtDUzg0cnhwaHo4K2dsUUxBWGxWSXp0T1RLZkUxa2I1d09xRTkz?=
 =?utf-8?B?K2o2ekQ4WUh4bVg3SXNHeitOVWpTTEs4Ti9DT2VZMGlJcFc5MVNlNS9XS09k?=
 =?utf-8?B?SDcwbERQR1krU3lDNkVnR1FOd0U1YkNOaURPRTIxcXpmQUFyZUxpV0hPcVY0?=
 =?utf-8?B?TU9TSmoxa0FXKzdKcjhpaytDN2VZWFNpUWdHYTRaaTJvbE1sLzErK3hJSFQ0?=
 =?utf-8?B?enVxMC85bG1aS3hxUG5GMkdjMXYyVnczU2diVi9ic0JLRC8vV1hTaUFKVG1v?=
 =?utf-8?B?bWFJUnUzcVVYTzI2dGwxOWRjcGwyZVUvOVRLdHNVeGx6SGRSa1IwelUxTlB4?=
 =?utf-8?B?U1Ixa1JlSk9lWWZhSzJZeVhaVUpaaW1sd1FqNDJrTmNpUmVTc2gzbmVZUTd0?=
 =?utf-8?B?ZkdBS2xoTEEwcWo2WjZXTTI0SFAwVVJ6bUlCK0xWQUh0cXdCSG5XMDZKMzBZ?=
 =?utf-8?B?cHQzVzZVOWNVQTczbmN0dUJaZHhNMFRvM1N3OVRROE11bmdsa2xJZ2VOaVho?=
 =?utf-8?B?OUNNUDB6ZlFyTlhOeFBKLzZUKytVMms2TWc2VzhScnlHMURWMHg0aUpsU0VE?=
 =?utf-8?B?Wk9CaXRqWFZoaTZ1dTcxNU52WlRpZno3SERac2tqRTR4SDkxbkU2RlhZdFhr?=
 =?utf-8?B?WUdOUzdGWGxrYVNKYTFoS0ZnNkVuRmM2ZUJQcCt2RVUxZjNJNzJ3SFZuZGdM?=
 =?utf-8?B?Yk5Yc0ZYSjBtV0swb1o2T3o1ZFZzSFY3ak9MQ2JQS2R1M0lObmJ3M0dveEZk?=
 =?utf-8?B?RWs4S01abHZuY2psc1k5MmR4Smp2aXNzMXBiUjlDcFFFSEVTUWNhVStoTzNo?=
 =?utf-8?B?Q3FFUU9FRElOdWdZcWcrSFErUHlZcG9zckRSSFg3MmtTYXRiaXgzb2J5eVpy?=
 =?utf-8?B?ODJtVUtQYmZNTUVXUFZsd2xlc2RWSTUycDRNUlBPbmVOQ1R2cXZVNEtFL1h5?=
 =?utf-8?B?YnVIYWFIemM3ZXFVVGV6NWNtV1BkRm1sWFhHQ2dWcG82NVQ5MGsva1U5WGlr?=
 =?utf-8?B?NndueFhSSTQyVVo3REhaRWJxVDRMU3ZsSGVMV1QrbkFpQzgvbUozRDRta2p5?=
 =?utf-8?B?LzJNVE90WnE1UUZCS2NpSlM3SDRUU2d4V2tUSGgwTkZLUkV6K213WW1tcTJm?=
 =?utf-8?B?eUdwTU8vS3h6cFhNa2F1V3RWVmtGQzhManZVMU05UXl2cGVYejBaaVBIa2Iv?=
 =?utf-8?B?dU5aT1ZUN3ZzV0ovREQwcDFqbzFhcHJTMzdrelFvdmJLbUFvQ09BbS84VWRN?=
 =?utf-8?B?anNsK1BNUmJYL0IvTy85a1FTQTd3ZWQvWDV5cGpBVGlFZW9hRjQzc0IyVzdj?=
 =?utf-8?B?L1NETFAya1p2VUpUNDl2NXR6c0xFcHZ1bDc3UWFoc3pzZTZaclJaUTRublY0?=
 =?utf-8?B?TkIyRkZ1VURobzZWSlBBc0NJYnprVlIwV0o3YW1UcjJubWxLREMrNU0vVlJw?=
 =?utf-8?B?M0RuUGUvZTdYSis4SVJOcXAvSXplVUhWcTFORk1BL2h6Slc0TmRUVnJ5MXFL?=
 =?utf-8?B?MVdSR0c3ekJwb0pOa2Q5ZC9JR1QwcDBtOHpLVFNSaEZhVDd6bW5wQ1dYOWcy?=
 =?utf-8?B?SUIrUWpnTmtLNTFWbGFqUEtOSEx2YTN3NGltMFhsa1JST0RjdDZ4TUVDVHND?=
 =?utf-8?B?bkM2ajJYeTNWeFFjcFNmcDcrdEQzZW5ER2FvOXl5cGJlU25OUms5NzlZSkNr?=
 =?utf-8?B?OGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EDD0AB22322F9646BEE37A48A850E77C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	cm8Y1noScAkGeAqjn5sGiBiwm220Dx87dml3zMPlnJBgpxXM44b9izaLEGXNEEvHhwFTOXC2wFyu+TQQI/F77KpDOu1YQIZmXIYDj0r8HfmJpXqDUlvdw5WnUiRB77uAWigWLjcvTket1Y+jaMFnocNlHPMFzjqHOtyuxxcnrD8OY01DZaEQLmk5IJexNCl8BePQcydKDFZ3TFlWPGMQd6s661b4ou6B1Shrf8SWbAnq/wvh2/r40lrkOUh5CU6lYo9TyyaBMyJPwgVaBv4Copix04adMxat3hn0vCjFRN99Xv3FeQFih223B/FtrrAk1ZaqpaDv4QRA1yKtvn6URhISRqlRYRpKYSbhTVmNu0xFmOKC7F1JyhHT7DsOJ1zRl4tlYt0WOvNnsM1uNZjY3Gqb4K0Lbvg4bRDcXEHfeGlomOCHFXrD85lDP0s5k94L9A9cekXUzdFhnz05vF383WxhjpVZf13fRI6YmudV3JbdBx+OQKeXH7Qy3IVIcN2wAuT4VCg3O6RB+ZJhu+5vGNvNIbRpaxXqUI7dmk45IL2faKIlXihGuXYDn8ruOg59Iy84TEteZ9uHk4dUQRY2F9WNfG94sFn768xiylgohSGgfN7sH1UFTbZ469Q4c4DgIiqcHhnTKbJO1wF0FCAu1w==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8950ba11-d473-48e4-6713-08dc6fb3023a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2024 23:03:00.6617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jjqzWKfeIGvnVl4yNYu0QjmKfHIEgi3QuO/eBU9CpGH9QsFtB3SVNuY7mLXfzl6iUwUVaJfrcV3DsHgH5KoqFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6083
X-Proofpoint-ORIG-GUID: sa6kzZG6BUEgmObIBlcmP8KnEN0k8jCx
X-Proofpoint-GUID: sa6kzZG6BUEgmObIBlcmP8KnEN0k8jCx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_09,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 mlxlogscore=835 spamscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2405010000
 definitions=main-2405080172

SGkgTWljaGFlbCwNCg0KT24gU3VuLCBNYXkgMDUsIDIwMjQsIE1pY2hhZWwgR3J6ZXNjaGlrIHdy
b3RlOg0KPiBPbiBXZWQsIEFwciAyNCwgMjAyNCBhdCAwMTo1MTowMUFNICswMDAwLCBUaGluaCBO
Z3V5ZW4gd3JvdGU6DQo+ID4gPiANCj4gPiANCj4gPiBSaWdodC4gVW5mb3J0dW5hdGVseSwgZHdj
MyBjYW4gb25seSAiZ3Vlc3MiIHdoZW4gVVZDIGZ1bmN0aW9uIHN0b3BzDQo+ID4gcHVtcGluZyBt
b3JlIHJlcXVlc3Qgb3Igd2hldGhlciBpdCdzIGR1ZSB0byBzb21lIGxhcmdlIGxhdGVuY3kuIFRo
ZQ0KPiA+IGxvZ2ljIHRvIHdvcmthcm91bmQgdGhpcyB1bmRlcnJ1biBpc3N1ZSB3aWxsIG5vdCBi
ZSBmb29scHJvb2YuIFBlcmhhcHMNCj4gPiB3ZSBjYW4gaW1wcm92ZSB1cG9uIGl0LCBidXQgdGhl
IHNvbHV0aW9uIGlzIGJldHRlciBpbXBsZW1lbnQgYXQgdGhlIFVWQw0KPiA+IGZ1bmN0aW9uIGRy
aXZlci4NCj4gDQo+IFllcywgdGhlIGJlc3Qgd2F5IHRvIHNvbHZlIHRoaXMgaXMgaW4gdGhlIHV2
YyBkcml2ZXIuDQo+IA0KPiA+IEkgdGhvdWdodCB3ZSBoYXZlIHRoZSBtZWNoYW5pc20gaW4gVVZD
IGZ1bmN0aW9uIG5vdyB0byBlbnN1cmUgcXVldWluZw0KPiA+IGVub3VnaCB6ZXJvLWxlbmd0aCBy
ZXF1ZXN0cyB0byBhY2NvdW50IGZvciB1bmRlcnJ1bi9sYXRlbmN5IGlzc3VlPw0KPiA+IFdoYXQn
cyB0aGUgaXNzdWUgbm93Pw0KPiANCj4gVGhpcyBpcyBhY3R1YWxseSBvbmx5IHBhcnRpYWxseSB0
cnVlLiBFdmVuIHdpdGggdGhlIHplcm8tbGVuZ3RoIHBhY2thZ2VzDQo+IGl0IGlzIHBvc3NpYmxl
IHRoYXQgd2UgcnVuIGludG8gdW5kZXJydW5zLiBUaGlzIGlzIHdoeSB3ZSBpbXBsZW1lbnRlZA0K
PiB0aGlzIHBhdGNoLiBUaGlzIGhhcyBoYXBwZW5lZCBiZWNhdXNlIGFub3RoZXIgaW50ZXJydXB0
IHRocmVhZCB3aXRoIHRoZQ0KPiBzYW1lIHByaW8gb24gdGhlIHNhbWUgQ1BVIGFzIHRoaXMgaW50
ZXJydXB0IHRocmVhZCB3YXMga2VlcGluZyB0aGUgQ1BVDQoNCkRvIHlvdSBoYXZlIHRoZSBkYXRh
IG9uIHRoZSB3b3JzdCBsYXRlbmN5Pw0KDQpDYW4gdGhpcyBvdGhlciBpbnRlcnJ1cHQgdGhyZWFk
IGxvd2VyIGl0cyBwcmlvcml0eSByZWxhdGl2ZSB0byBVVkM/IEZvcg0KaXNvYyBlbmRwb2ludCwg
ZGF0YSBpcyB0aW1lIGNyaXRpY2FsLg0KDQpDdXJyZW50bHkgZHdjMyBjYW4gaGF2ZSB1cCB0byAy
NTUgVFJCcyBwZXIgZW5kcG9pbnQsIHBvdGVudGlhbGx5IDI1NQ0KemVyby1sZW5ndGggcmVxdWVz
dHMuIFRoYXQncyAyNTUgdWZyYW1lLCBvciByb3VnaGx5IH4zMG1zLiBJcyB5b3VyIHdvcnN0DQps
YXRlbmN5IG1vcmUgdGhhbiAzMG1zPyBpZS4gbm8gaGFuZGxpbmcgb2YgdHJhbnNmZXIgY29tcGxl
dGlvbiBhbmQNCmVwX3F1ZXVlIGZvciB0aGUgd2hvbGUgMjU1IGludGVydmFscyBvciAzMG1zLiBJ
ZiB0aGF0J3MgdGhlIGNhc2UsIHdlDQpoYXZlIHByb2JsZW1zIHRoYXQgY2Fubm90IGp1c3QgYmUg
c29sdmVkIGluIGR3YzMuDQoNCj4gYnVzeS4gQXMgdGhlIGR3YzMgaW50ZXJydXB0IHRocmVhZCBn
ZXQgdG8gaXRzIGNhbGwsIHRoZSB0aW1lIHdhcyBhbHJlYWR5DQo+IG92ZXIgYW5kIHRoZSBodyB3
YXMgYWxyZWFkeSBkcmFpbmVkLCBhbHRob3VnaCB0aGUgc3RhcnRlZCBsaXN0IHdhcyBub3QNCj4g
eWV0IGVtcHR5LCB3aGljaCB3YXMgY2F1c2luZyB0aGUgbmV4dCBxdWV1ZWQgcmVxdWVzdHMgdG8g
YmUgcXVldWVkIHRvDQo+IGxhdGUuICh6ZXJvIGxlbmd0aCBvciBub3QpDQo+IA0KPiBZZXMsIHRo
aXMgbmVlZGVkIHRvIGJlIHNvbHZlZCBvbiB0aGUgdXBwZXIgbGV2ZWwgZmlyc3QsIGJ5IG1vdmlu
ZyB0aGUNCj4gbG9uZyBydW5uaW5nIHdvcmsgb2YgdGhlIG90aGVyIGludGVycnVwdCB0aHJlYWQg
dG8gYW5vdGhlciB0aHJlYWQgb3INCj4gZXZlbiBpbnRvIHRoZSB1c2Vyc3BhY2UuDQoNClJpZ2h0
Lg0KDQo+IA0KPiBIb3dldmVyIEkgdGhvdWdodCBpdCB3b3VsZCBiZSBncmVhdCBpZiB3ZSBjb3Vs
ZCBzb21laG93IGZpbmQgb3V0IGluDQo+IHRoZSBkd2MzIGNvcmUgYW5kIG1ha2UgdGhlIHB1bXAg
bWVjaGFuaXNtIG1vcmUgcm9idXN0IGFnYWluc3Qgc3VjaA0KPiBsYXRlIGVucXVldWVzLg0KDQpU
aGUgZHdjMyBjb3JlIGhhbmRsaW5nIG9mIGV2ZW50cyBhbmQgZXBfcXVldWUgaXMgcmVsYXRpdmVs
eSBxdWljay4gSSdtDQphbGwgZm9yIGFueSBvcHRpbWl6YXRpb24gaW4gdGhlIGR3YzMgY29yZSBm
b3IgcGVyZm9ybWFuY2UuIEhvd2V2ZXIsIEkNCmRvbid0IHdhbnQgdG8ganVzdCBjb250aW51ZSBs
b29raW5nIGZvciB3b3JrYXJvdW5kIGluIHRoZSBkd2MzIGNvcmUNCndpdGhvdXQgbG9va2luZyB0
byBzb2x2ZSB0aGUgaXNzdWUgd2hlcmUgaXQgc2hvdWxkIGJlLiBJIGRvbid0IHdhbnQgdG8NCnNh
Y3JpZmljZSBjb21wbGV4aXR5IGFuZC9vciBwZXJmb3JtYW5jZSB0byBvdGhlciBhcHBsaWNhdGlv
bnMgZm9yIGp1c3QNClVWQy4NCg0KPiANCj4gVGhpcyBhbGwgc3RhcnRlZCB3aXRoIHRoYXQgc2Vy
aWVzLg0KPiANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjQwMzA3LWR3YzMtZ2Fk
Z2V0LWNvbXBsZXRlLWlycS12MS0wLTRmZTlhYzBiYTJiN0BwZW5ndXRyb25peC5kZS8NCj4gDQo+
IEFuZCBwYXRjaCAyIG9mIHRoaXMgc2VyaWVzIGRpZCB3b3JrIHdlbGwgc28gZmFyLiBUaGUgbmV4
dCBtb3ZlIHdhcyB0aGlzDQo+IHBhdGNoLg0KPiANCj4gU2luY2UgdGhlIGxhc3Qgd2VlayBkZWJ1
Z2dpbmcgd2UgZm91bmQgb3V0IHRoYXQgaXQgZ290IG90aGVyIGlzc3Vlcy4NCj4gSXQgaXMgbm90
IGFsbHdheXMgc2F2ZSB0byByZWFkIHRoZSBIV08gYml0LCBmcm9tIHRoZSBkcml2ZXIuDQo+IA0K
PiBUdXJucyBvdXQgdGhhdCBhZnRlciBhbiBuZXcgVFJCIHdhcyBwcmVwYXJlZCB3aXRoIHRoZSBI
V08gYml0IHNldA0KPiBpdCBpcyBub3Qgc2F2ZSB0byByZWFkIGltbWlkZWF0bHkgYmFjayBmcm9t
IHRoYXQgdmFsdWUgYXMgdGhlIGh3DQo+IHdpbGwgYmUgZG9pbmcgc29tZSBvcGVyYXRpb25zIG9u
IHRoYXQgZXhhY3RseSBuZXcgcHJlcGFyZWQgVFJCLg0KPiANCj4gV2UgcmFuIGludG8gdGhpcyBw
cm9ibGVtIHdoZW4gYXBwbHlpbmcgdGhpcyBwYXRjaC4gVGhlIHRyYiBidWZmZXIgbGlzdA0KPiB3
YXMgYWN0dWFsbHkgZmlsbGVkIGJ1dCB3ZSBoaXQgYSBmYWxzZSBwb3NpdGl2ZSB3aGVyZSB0aGUg
bGF0ZXN0IEhXTyBiaXQNCj4gd2FzIDAgKHByb2JhYmx5IGR1ZSB0byB0aGUgaHcgYWN0aW9uIGlu
IHRoZSBiYWNrZ3JvdW5kKSBhbmQgdGhlcmVmb3INCj4gd2VudCBpbnRvIGVuZCB0cmFuc2Zlci4N
Cj4gDQoNClRoYW5rcyBmb3IgdGhlIHVwZGF0ZS4NCg0KQlIsDQpUaGluaA==

