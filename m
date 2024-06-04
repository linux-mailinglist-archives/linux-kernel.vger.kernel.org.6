Return-Path: <linux-kernel+bounces-199866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 255358FA6E4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 02:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 870DCB24D17
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 00:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FBA4C6B;
	Tue,  4 Jun 2024 00:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ttfsxUZM";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Q6BXWjZj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Y4qoY0oY"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F570BA39;
	Tue,  4 Jun 2024 00:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717460213; cv=fail; b=cWYpNrI7XG6DX1XJ5An5HPmqdm3atzZCui75gtVAnuRJ5WNzeFbhcy1s+DiuInNZoEh0tdnFlrnN7fLurQPKgnk1L4MOORPsT9Ufm76/RvloPkZsooZS+OKD70o0gh15gHCOIcP66nKCBja5RBrVmBrouHzd8ehcmb09EaDI9Ss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717460213; c=relaxed/simple;
	bh=uFmbNyuhGE7h82tC9XrYFiy4/Z7hLsxb1QIRk8mknEE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=El7G7TWoI6FDiejX0q7BSlTpNYZ198RTH1ASRP7WY2RNpEnjYDUAvlmohSioIy5MBoI473kwFjc5cahxSM8hshC0wvCaJE9HvKqlWuZReIaeQbZ6AexJecD3IjRLCXQ4e2kkYEef7KcAv/Ec7S7hRRvsL7gqt39SIrRdeQuIBXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ttfsxUZM; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Q6BXWjZj; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Y4qoY0oY reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 453Nq7EN021081;
	Mon, 3 Jun 2024 17:16:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=uFmbNyuhGE7h82tC9XrYFiy4/Z7hLsxb1QIRk8mknEE=; b=
	ttfsxUZMlT8GTDmwGRvA15weKZS6q8dFiaSfWuH3bLgkxhw5sumD20E9cTf/cau0
	yf+Bd6wbTXANJKyqfZkS1X6lU4ig2mFyyFF2/biIjyraPes9pXWNRcQM4TE3ao16
	LeHP3qKvAUyjdkrLV5rjobN2hjR8ojkJyH86RHpLu7HhIyVzhMOhDtYz58kMZ5R5
	Xj1GCgWwKm2rdF8eZ6fNVMKcOlXW7UTynQnoAON0pDueKQ5amOAK8brTnYaE0RPQ
	tjF/51uTIlfyKCY6UqoOw0ANJ/XWb4KsWDqgefRPXK6bWa5SJTBXvj4SWs2HKF5i
	YsziveyhSj4YBHYkTNSb4w==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3yg2js10ft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 17:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1717460200; bh=uFmbNyuhGE7h82tC9XrYFiy4/Z7hLsxb1QIRk8mknEE=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=Q6BXWjZjrmLt4RafCAdduKwaCWL6IDAHZJ4P9o4T2r+yJTafPnQx8f4OaNC7QIGQG
	 EkyvyOD4lsOKwdUcQ2My8ySHXEcFcLmRFICIbVsqofRNBi8FAKLSHa46pbl2Txti9G
	 sSkea4X+lPRIigytCRXfacKnUNckVTYQelzo3wdFDF95RQjZAaPSquOD5rbDZbdO6A
	 AK9nmdkX8qVeAp1fKLncaHNpF4vCDYTGKkeERAQJtDsiC3FWERTQ92heqtv8hbxG+m
	 5ouvjvnWGENFN/il8LSSi9D7DS28/32EA6fPFJVZvzU3uMMHNdLMsmx0GUtJeTPQk/
	 NKEfSec/gEnHA==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id CA8B54035C;
	Tue,  4 Jun 2024 00:16:39 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 563C1A0263;
	Tue,  4 Jun 2024 00:16:39 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=Y4qoY0oY;
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id E5A7040356;
	Tue,  4 Jun 2024 00:16:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hm8ljz9P4sLQ6w2qE5RXDNj5wbS9nhnZ05/EVsvwf1xGRvK+ZWE2jocHqTn1P3/qwNnCNNR75oiBO9WZ/ZS1zrDac9CvTRQl+b5D3uU1UhfuyaxrQzdArI6D9x+Hfh90Y68Y8dC51tGksRypMoKUKjyXkdULSKyjvh0tSdYG3j53b0zWRKUHA/rXZhZ6xPjc3uROev//h2DHAHRcXdRVkpOvf9ANIa6PgvmWVS52RlM/PmFlwd2vIg4P5dGA5EpHK4l+E8NcRlAaVu1i7JAwrGyU8jW3z8c8vnkDzE9FDQ1IV+IF6othyqXw543qrxEdwpdoSfZ4gNKcLgExuAyFvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFmbNyuhGE7h82tC9XrYFiy4/Z7hLsxb1QIRk8mknEE=;
 b=QJQHo7KJKPqKqB636h9Idg83VfYV/54Q5/viXwg/5KjFeKsvFxxyIA9ohrNZYmV7lBsnGvDWrmwty6WiHjD0CcGKY+Ml8dUs8Wp2baIh/mp27VU2+m0iTr7h3GPYBZt+WtDcyYGjmOwu8FkB/+Q8ChgSq0RPJGkXyZ/D4NsBTp9P+MkdthY/+7tcIHX7AOLEcPZLnW7e5xeQ/DOfr8VjUUERDkJPy+PI7N+lk0yzlZ1Ch2ctsMdkSR4xhmi3/lMpVKWQpyrU4IBjBTfRrsS5U9oRnteJKupkjSx7SICRUpYZtaGM6q7O06bn65ptSZ2wHHmiGqJsKCl3j0JG47MJPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFmbNyuhGE7h82tC9XrYFiy4/Z7hLsxb1QIRk8mknEE=;
 b=Y4qoY0oYhOFukspc3wDClmUumtTpKmIwOkVnHTjno5MvFD8S17Qe145rbSe5M9bRa2doqOa1JQtnsGiLIj11GIpxhmhaiPE9121LUsJ81XkdNqXjihguxnImkMUZr9x0kTUUFvzk6zQceicjXNWwTa35ZUPRT3Cz1sVvxSsNCJk=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SN7PR12MB7156.namprd12.prod.outlook.com (2603:10b6:806:2a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 4 Jun
 2024 00:16:33 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.7611.025; Tue, 4 Jun 2024
 00:16:33 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Daehwan Jung <dh10.jung@samsung.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        "open list:USB  SUBSYSTEM" <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND  FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] usb: dwc3: Support quirk for writing high-low
 order
Thread-Topic: [PATCH v2 2/5] usb: dwc3: Support quirk for writing high-low
 order
Thread-Index: AQHasyDXrvXr4ni7cUGRjaeAPeGjPLG2wpaA
Date: Tue, 4 Jun 2024 00:16:33 +0000
Message-ID: <20240604001619.nflngpnm6zu6nwnl@synopsys.com>
References: <1717135657-120818-1-git-send-email-dh10.jung@samsung.com>
 <CGME20240531060729epcas2p2d895a441b017f1797b1bc1e2558d9e1b@epcas2p2.samsung.com>
 <1717135657-120818-3-git-send-email-dh10.jung@samsung.com>
In-Reply-To: <1717135657-120818-3-git-send-email-dh10.jung@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SN7PR12MB7156:EE_
x-ms-office365-filtering-correlation-id: d2f712d7-72f5-482d-17ef-08dc842b973d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|366007|7416005|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?RllGY2hUK2RDbmdWZmRDZjdQSGZKM3NnZGY0SmJUck1NVy9YMWV3c2FReCtD?=
 =?utf-8?B?eG5VNmNJKzl0MUdxQm50Ykxia3Y5bW1SNmlHbXhud0lPOUpHQzg3OXRrQzVa?=
 =?utf-8?B?ZTU5VlkzcVRpay9TVlRwVU1rSzNMVnd6NzAzWWhQZ1FXNncreDR0TE81dmlp?=
 =?utf-8?B?VnAzcndjYmRLSDVzUVBSSllzWFpGWlgramNXdU53NFA5a3ZKTGg5WXlkanlG?=
 =?utf-8?B?cS9rOGdHUlpLNThpWFBQb3hJUS94ZkZDOTRkT1RlS3diRHdwdzF6QUxOcEc1?=
 =?utf-8?B?WGloTDFROWdvUDh5SmdpWHpuUFE5OU9ZRmsrY29Cd0NOTmxMaTZFMHJFc2JF?=
 =?utf-8?B?T3FEU3ZvTDZNWWkyTk82ekdhcFF1UkZGYzJyMENKUjd2QWpWemRHNTBWeCtt?=
 =?utf-8?B?eHI2RHRPT3AxU1ZiYnMvZzdKTVk1NFp0ZlRzU2IwclhMbmw5djI4S2REdXJn?=
 =?utf-8?B?VHZBVmpsdkFRTlJaa3FDVU4zZCtwTWV6cGlTNVpqTFppTGFiVFRjc09uK3pY?=
 =?utf-8?B?OFMxME9rQ1p6SXE2VWc5SjRDL3E3ckZXSTNTeEZycnMweXNiWU5Uajl2NHNl?=
 =?utf-8?B?aVNxamwzdW9IRGlOeHF0QW9KR2h0ZnBTUmlyeVpmV1BpRkg0RkV6ejVRZFJ3?=
 =?utf-8?B?emJxSkJxQWxJY25RMkZEcGxaZjB6ZFNlajhVSW5tdVNkSk1iY1Q5RWk1Y0J3?=
 =?utf-8?B?cmdSNExhSGtUMjRyV0RvZjVlaXArbE9lMmhKS2JseFNJcU1iVHFPM0ZreHFU?=
 =?utf-8?B?VzdZN2wzVjFKOWIxc0tBWWZWUlBtVTBKeFZiaVBBeVpHMUVrUlBuV2J0RUJt?=
 =?utf-8?B?SVEwUGovbnpoV2N2NUZCZ2VmemVHOG41ck5FcXlPTWM0WU10YzBITGkwaGx2?=
 =?utf-8?B?UDhVRFRpWXBCZG16TzNMWVdIZnhyT3FYUDFxcXp2SnZCTktna1lkOFpUMTRs?=
 =?utf-8?B?VXJDcXgwVlNxRitKY25wYUd5R01lWVNhZHRWbmw0bGUrUGFoUng4dGIvbnFU?=
 =?utf-8?B?MEt2VjkyZzVQanJmVDFGUUFjMmxaenErekZ4VldjdzlpTmJkUkcvVm5SN3ZY?=
 =?utf-8?B?bUp1cHB4a3NSTjlINmJhK29zMCtnTFV6ZE1uVDg5STB3YUxlQ0c3ODRhS3hD?=
 =?utf-8?B?dytkK2FtM2IxZlRiV3NlTnpVZ0FhVTVHakQxRTdjMUdKU1dnTGF1dExrL05n?=
 =?utf-8?B?R3hEWkJKZ1VrTTdOd0dLY2FWVDRyUmpFQUZRbVk3a1NIU2RNbzI4NVRBeHdF?=
 =?utf-8?B?WWxXL29TN2pUaWZYcndRVnRUNyt3MmptWThtLzl4bFRKbWZWSGR5TFFhWDAx?=
 =?utf-8?B?TVpId3lUVGVybnJWQjlzK21WZktRUUZOZGI5WkJ1TVU3a3JpNVRJanVhUXdr?=
 =?utf-8?B?QU90RGZua3FrWkZoK3pBT3UyYis1aU5PMThKVmU0YVJJeTRQVWt2Zi9VdWo3?=
 =?utf-8?B?dThVa0VXQjQ3aXhDQitQRnpubjN1d3NvRXZlVDdlUTNXVjVEOEFVY2lPVHV3?=
 =?utf-8?B?cWk2RmVwTEJpUFo0THJTakNZc0grSDQvY3ZQQlNFK25IcitkQit0cUZIZHZh?=
 =?utf-8?B?bVVWTDRzK3haK3VHbzNkZkRxdHR6azhlckRIVzE2MW5PakhETXNHUFlSdWU2?=
 =?utf-8?B?OW94Rk55NGJJMkd5TFphUGJodWxma0tiSVM3OHpnY1V0V0dDNDgxTHkrcXll?=
 =?utf-8?B?ZzM1ZmVzUjdCck1tVytTMldYZFY2R0Q4OStoZkZicG5QbGNLNHJvWE9veDhI?=
 =?utf-8?B?Qnpnd0Jrd1F5bHp3YTQxOEZKSnNuNE1PaUMxbUZxZkhoWlhxZjYxNTVVN1J1?=
 =?utf-8?B?TTFKT1VabHRHNG5FdG45dz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?eTlTbUpTUnlObmlBTFN6ZUdnSkI4UnZkNEtpd0Y3bUMrY2ZyemN2R3Z2V25u?=
 =?utf-8?B?dUhOblBWOVhLekNNYVoxWEFFeGM4TlJidkllc29UL1ZoblRveitpcXpmOFJQ?=
 =?utf-8?B?WkR1ZW9QOEVldDRTUVdHYUxGVmszNmZTc09lWnhwQ3JrQllmbWdJRDcwK0xO?=
 =?utf-8?B?dSsxN0NadFVKODgveXFLQ1NUQmhwT0xiY0prRWVjQitkeFpkQ3ZPeWYyMHJ4?=
 =?utf-8?B?MWp6Nlp0eU5IMGNYR3ZSNzhzVFcySGJabUtxcUZ5VjEyeStBd3BBc0tySGs2?=
 =?utf-8?B?MFNjRVZHVXF2dldQTzVlQW1lYXR0dGR6UHJWdUw2NlZudlR4azFlOGFmdmt6?=
 =?utf-8?B?K0FvUDZjUGc3VGcrL3FlL0hPYXc5bXdIZ1RjQkgvQy9oSityUGlURk1kYlhR?=
 =?utf-8?B?R1JWaHZLS1UvZTFvRkFUTWRvVjgwQ2ExOUhRckx0ckR6VVV0WGdtSEJ0aGtw?=
 =?utf-8?B?UTdzaUpkNVJOQUhDa0NCUjExL3B5QXFYOC9rNEUyeG1lYUxRR3c3V004VWtx?=
 =?utf-8?B?N1lzK2E2dWVIWTNkemx3TUE3akYrNFhzNjZrVWFueUxJYVRRS1p5NDk5Uzk0?=
 =?utf-8?B?RE5OUTZJenhlQU93dDBoTkVWNEhoaG1hMFp3eVFKcG1aT3NOam1FRSs3eHJ5?=
 =?utf-8?B?b0xsbER6OUpzWjcwVCtsbTZOLzBFL09WMzNCcG1JQVY5WlNqVWdGazRJVnBQ?=
 =?utf-8?B?em13dGwrWkZFeFpQQ3MyTkY3cWltVkxuRHZWY0pVNjNVd2NMc3ZJVHJnWHNr?=
 =?utf-8?B?SnhJdmlDK3RaME1qeDZEakNsUWJNeUFTWllCNDF4VTNqRG92Ym94d2lPQUlR?=
 =?utf-8?B?YU1zVEUyU1BpV080bytKNU5QenhjWnpicTdMWUhMbmdPS2YvSVpLQkFWZ3lk?=
 =?utf-8?B?K1dxMUVxc0RkWTZSZmxFUVNDbzVMMGtBQTlrWTBWeW1CMjY1S3VKclRyWTgz?=
 =?utf-8?B?YnZtWkZkakU1OHpOeGhzZCtleVZob25tRUNiVHNGREhDc0VSbzFlNXBFejFv?=
 =?utf-8?B?T0NoQ2tXNzdRbEMwMDhWYzBnd2JVRXpWQ2M3WjJYVVFnWjlCREZZR0h2LzJ4?=
 =?utf-8?B?MzFWS0FMeWVSV2phTktBM24xb2w0aW5Ec01wcDQvVlpGRUtDSW5xNnpZblNu?=
 =?utf-8?B?dTE0a2l6eE9WQUQ0Z0FrbDZac3hDMjN0ZW9iSmt0ckNFL09IaElRUFNYZ1Nz?=
 =?utf-8?B?eHZUOENMY0lmZ0Y0cmRhblNkRW9qb1N4ejJ2MFoyNWFsbXF3WjlPVTl3ZklQ?=
 =?utf-8?B?NzRlUmRsNkljN0IzRmZQa1M0M1FhQUljdjIvVTJCNk12cXhzWXNkL3NWQ000?=
 =?utf-8?B?NWZtTlNyZG1KTEh2Wk52VHNrK0FlaldaZjBWMkFkZDJSOUwzTitpYmc1dFVk?=
 =?utf-8?B?RWl6YTdDRk9oL0hiRWs4TFR4VTA2UVo3aGhNMFN1US9wSTdOTEtSemRmclZQ?=
 =?utf-8?B?VDhRRU9lLzRiTDg1WGpxV29iKzAxcU1ZMll4ZytiLzdSS25OczdrZ1Y1Q2tB?=
 =?utf-8?B?Z1ZaQ3dVQVlRMXZ2Vm9WL1VvRU9DSkV4TkdvNjdpWUNmSTRmTVFHdXE1RjdH?=
 =?utf-8?B?RzBoRmttdWtjRmJ1RnhKaC9jUURyRVZORkh2bGZ4ZVZLU29OV2ltSG4yMlZx?=
 =?utf-8?B?eHU2eHZnUWRISTdzNithRXdkdnVmL2MyOXcwckpUMzZGREd5U05VYng2SStH?=
 =?utf-8?B?dWxNbzVnRFZkWXRib0VVaXBuQlFPbGFLeVB1ZVdOMTNVVEpXOGFHcTFKZ2tE?=
 =?utf-8?B?OStCOGducHVZbW5NS3V3UUdYUWJOenByaGNjMlM2cUFid054aE1zZWh6djFs?=
 =?utf-8?B?T2pLaTU2aE9BZGNMTlRocHhNYlNuR2x3Yy9oaDZnQkF5UEhKcXdIektCUFhI?=
 =?utf-8?B?OGpmcFBWNElrUlNEOHhFQ3hhZjZaMjRJTE52c0lUaVgyS214NVQ1UU1XQW02?=
 =?utf-8?B?Vm1TQ29iaUhqVW5YNkN3Uy8xNDhXY1M0aFExSTNjMk5nSmsrdXg4bTNJSHhX?=
 =?utf-8?B?a0FFTGc5V29iR0J6Z0ZoZXl5WlhVVVQ1eEROU0VaS2xxd25mTUFsdHhhbUNv?=
 =?utf-8?B?VnZCMEhnVFpMUTIwR2N0a3VPcnlVVWdqZzEwaXZjSW42SUk4ZXV2S0RkTjdm?=
 =?utf-8?Q?ox1b25jnQsQ60ARvxTmgpAi4W?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <28F9AC98B6B60A4AB8DE2D46B4D8BAE7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	bQOC7Wfn5LPFkBnZSA8E1YDjk24o2LNf1NlHDfEYFpkSU88XXUGiquA6hG1+XPhgmiXIKtTP07it4NltvHiryfJJ7GfPxpD8MhJc31krC2wieOa2FzzU6gOPEGuQppfPjWa3eivZuo3XGXiLNRXS4BFWETckauH1pFrYWEzabPJJuqWMAy/3uoCTAlv4it3y3uUQCxjHWsZ5oerYcIksRjg3cv5chMoY7uXDdc8uk54TZBov7AzkULGAfkGxcMoGldNnV4kex/DOppOSONR8Nlq9XE0f/mw2fxjFCOI8+xIn+t2xMFruz1gWFG8QmIHNvBQs4j1GQeRcasanlUZmU/7mR6WpDWd68BtwZdRT1SqYx2gpmlnUnVGpuG7mIN6WaTBkPGDzSsdENBb4+5bzLhGjUstmm5TPNUTlu2JI+1py3KdrPNSXI9y7UFlzUV9sqDcb87pc+5AL/ewbmStK7fxqSB0kHnnlMrO54zyNMcy9Wqj+7g4IO08/22NrABbIVhNORnVqQMmG3eLYMY6oI0zDUr885QCXSBInhmrm0t16ATnkrpFV03eJRXazX97ZGDFMtDkezRJjmNEnlX02Tdl6OScYFlFjvpjXXtHhb8eHVlD+VdvB4bDV9p4969eXbad6AW39iAEtQ1L9V+Rz9Q==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2f712d7-72f5-482d-17ef-08dc842b973d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 00:16:33.5516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HifZ8pvDIIJZ4BEaT7sVBIMCatg4c9U8DoSTHj255KCiliqJRfHb2LsWrTxByyWsBXWD9DORj2mYaD5zJNnSLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7156
X-Proofpoint-GUID: KnpCpwOhxZmPLohy49EFIHtQTYUzlJIf
X-Proofpoint-ORIG-GUID: KnpCpwOhxZmPLohy49EFIHtQTYUzlJIf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_17,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=999 clxscore=1011 mlxscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406040000

T24gRnJpLCBNYXkgMzEsIDIwMjQsIERhZWh3YW4gSnVuZyB3cm90ZToNCj4gU2V0IHhoY2kgIndy
aXRlLTY0LWhpLWxvLXF1aXJrIiBwcm9wZXJ0eSB2aWENCj4gInNucHMseGhjaS13cml0ZS02NC1o
aS1sby1xdWlyayIgcHJvcGVydHkuDQoNClBsZWFzZSBkZXNjcmliZSB0aGUgY2hhbmdlIGFzIGlm
IHRoZSByZWFkZXIgaGFzIG5vIGNvbnRleHQgb2YgdGhlIG90aGVyDQpwYXRjaGVzIGluIHRoZSBz
ZXJpZXMuDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IERhZWh3YW4gSnVuZyA8ZGgxMC5qdW5nQHNh
bXN1bmcuY29tPg0KPiAtLS0NCg0KUGxlYXNlIHByb3ZpZGUgY2hhbmdlIG5vdGUgZm9yIHYyLg0K
DQo+ICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyB8IDMgKysrDQo+ICBkcml2ZXJzL3VzYi9kd2Mz
L2NvcmUuaCB8IDIgKysNCj4gIGRyaXZlcnMvdXNiL2R3YzMvaG9zdC5jIHwgNSArKysrLQ0KPiAg
MyBmaWxlcyBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyBiL2RyaXZlcnMvdXNiL2R3YzMvY29y
ZS5jDQo+IGluZGV4IDdlZTYxYTguLjg5OTg1ZmQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNi
L2R3YzMvY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+IEBAIC0xNzE2
LDYgKzE3MTYsOSBAQCBzdGF0aWMgdm9pZCBkd2MzX2dldF9wcm9wZXJ0aWVzKHN0cnVjdCBkd2Mz
ICpkd2MpDQo+ICAJZHdjLT5kaXNfc3BsaXRfcXVpcmsgPSBkZXZpY2VfcHJvcGVydHlfcmVhZF9i
b29sKGRldiwNCj4gIAkJCQkic25wcyxkaXMtc3BsaXQtcXVpcmsiKTsNCj4gIA0KPiArCWR3Yy0+
eGhjaV93cml0ZV82NF9oaV9sb19xdWlyayA9IGRldmljZV9wcm9wZXJ0eV9yZWFkX2Jvb2woZGV2
LA0KPiArCQkJCSJzbnBzLHhoY2ktd3JpdGUtNjQtaGktbG8tcXVpcmsiKTsNCj4gKw0KPiAgCWR3
Yy0+bHBtX255ZXRfdGhyZXNob2xkID0gbHBtX255ZXRfdGhyZXNob2xkOw0KPiAgCWR3Yy0+dHhf
ZGVfZW1waGFzaXMgPSB0eF9kZV9lbXBoYXNpczsNCj4gIA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy91c2IvZHdjMy9jb3JlLmggYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiBpbmRleCAzNzgx
YzczLi5hYjU5MTNjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiAr
KysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiBAQCAtMTE0Miw2ICsxMTQyLDcgQEAgc3Ry
dWN0IGR3YzNfc2NyYXRjaHBhZF9hcnJheSB7DQo+ICAgKgkzCS0gUmVzZXJ2ZWQNCj4gICAqIEBk
aXNfbWV0YXN0YWJpbGl0eV9xdWlyazogc2V0IHRvIGRpc2FibGUgbWV0YXN0YWJpbGl0eSBxdWly
ay4NCj4gICAqIEBkaXNfc3BsaXRfcXVpcms6IHNldCB0byBkaXNhYmxlIHNwbGl0IGJvdW5kYXJ5
Lg0KPiArICogQHhoY2lfd3JpdGVfNjRfaGlfbG9fcXVpcms6IHNldCBpZiB3ZSBlbmFibGUgcXVp
cmsgZm9yIHdyaXRpbmcgaW4gaGlnaC1sb3cgb3JkZXIuDQoNClRoZSBkZXNjcmlwdGlvbiBzaG91
bGQgYmUgbW9yZSBkZXRhaWwgaGVyZS4gQnV0IEkgZG9uJ3QgdGhpbmsgd2UgbmVlZA0KdGhpcy4g
SnVzdCBwYXNzIHRoZSBQUk9QRVJUWV9FTlRSWV9CT09MKCJ3cml0ZS02NC1oaS1sby1xdWlyayIp
IHRvIHhoY2kNCnBsYXRmb3JtIHVuY29uZGl0aW9uYWxseS4gVGhpcyBzaG91bGQgYXBwbHkgdG8g
YWxsIHJlbGVhc2VkIHZlcnNpb25zIChhdA0KdGhlIG1vbWVudCkgb2YgRFdDX3VzYjN4Lg0KDQo+
ICAgKiBAc3lzX3dha2V1cDogc2V0IGlmIHRoZSBkZXZpY2UgbWF5IGRvIHN5c3RlbSB3YWtldXAu
DQo+ICAgKiBAd2FrZXVwX2NvbmZpZ3VyZWQ6IHNldCBpZiB0aGUgZGV2aWNlIGlzIGNvbmZpZ3Vy
ZWQgZm9yIHJlbW90ZSB3YWtldXAuDQo+ICAgKiBAc3VzcGVuZGVkOiBzZXQgdG8gdHJhY2sgc3Vz
cGVuZCBldmVudCBkdWUgdG8gVTMvTDIuDQo+IEBAIC0xMzY5LDYgKzEzNzAsNyBAQCBzdHJ1Y3Qg
ZHdjMyB7DQo+ICAJdW5zaWduZWQJCWRpc19tZXRhc3RhYmlsaXR5X3F1aXJrOjE7DQo+ICANCj4g
IAl1bnNpZ25lZAkJZGlzX3NwbGl0X3F1aXJrOjE7DQo+ICsJdW5zaWduZWQJCXhoY2lfd3JpdGVf
NjRfaGlfbG9fcXVpcms6MTsNCj4gIAl1bnNpZ25lZAkJYXN5bmNfY2FsbGJhY2tzOjE7DQo+ICAJ
dW5zaWduZWQJCXN5c193YWtldXA6MTsNCj4gIAl1bnNpZ25lZAkJd2FrZXVwX2NvbmZpZ3VyZWQ6
MTsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvaG9zdC5jIGIvZHJpdmVycy91c2Iv
ZHdjMy9ob3N0LmMNCj4gaW5kZXggYTE3MWIyNy4uOGNjMGRlZiAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy91c2IvZHdjMy9ob3N0LmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9ob3N0LmMNCj4g
QEAgLTEyNiw3ICsxMjYsNyBAQCBzdGF0aWMgaW50IGR3YzNfaG9zdF9nZXRfaXJxKHN0cnVjdCBk
d2MzICpkd2MpDQo+ICANCj4gIGludCBkd2MzX2hvc3RfaW5pdChzdHJ1Y3QgZHdjMyAqZHdjKQ0K
PiAgew0KPiAtCXN0cnVjdCBwcm9wZXJ0eV9lbnRyeQlwcm9wc1s1XTsNCj4gKwlzdHJ1Y3QgcHJv
cGVydHlfZW50cnkJcHJvcHNbNl07DQo+ICAJc3RydWN0IHBsYXRmb3JtX2RldmljZQkqeGhjaTsN
Cj4gIAlpbnQJCQlyZXQsIGlycTsNCj4gIAlpbnQJCQlwcm9wX2lkeCA9IDA7DQo+IEBAIC0xNjIs
NiArMTYyLDkgQEAgaW50IGR3YzNfaG9zdF9pbml0KHN0cnVjdCBkd2MzICpkd2MpDQo+ICANCj4g
IAlwcm9wc1twcm9wX2lkeCsrXSA9IFBST1BFUlRZX0VOVFJZX0JPT0woInhoY2ktc2ctdHJiLWNh
Y2hlLXNpemUtcXVpcmsiKTsNCj4gIA0KPiArCWlmIChkd2MtPnhoY2lfd3JpdGVfNjRfaGlfbG9f
cXVpcmspDQo+ICsJCXByb3BzW3Byb3BfaWR4KytdID0gUFJPUEVSVFlfRU5UUllfQk9PTCgid3Jp
dGUtNjQtaGktbG8tcXVpcmsiKTsNCj4gKw0KPiAgCWlmIChkd2MtPnVzYjNfbHBtX2NhcGFibGUp
DQo+ICAJCXByb3BzW3Byb3BfaWR4KytdID0gUFJPUEVSVFlfRU5UUllfQk9PTCgidXNiMy1scG0t
Y2FwYWJsZSIpOw0KPiAgDQo+IC0tIA0KPiAyLjcuNA0KPiANCg0KVGhhbmtzLA0KVGhpbmg=

