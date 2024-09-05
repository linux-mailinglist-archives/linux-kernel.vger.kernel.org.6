Return-Path: <linux-kernel+bounces-317872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDF096E4EB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 23:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 591D51C2089F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 21:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063FD27702;
	Thu,  5 Sep 2024 21:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="DqijWDvM";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="fuOr00JS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="llLLL0G3"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC86919306D;
	Thu,  5 Sep 2024 21:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725571120; cv=fail; b=kb2/dzJY+7bexQwTbMiXyZ6M9SjOn0/87LPl5uNxzjeOkXqAf3CUs2NtH8BzSC8U5W5B9vL09GKj3dph8rvlhfu9fS65pObrX+Ab2Ssdqa8YC+3M4rBo2dCmXpgObDqimcCxfoMvKPqxjeq2ypQuIqyctyKxBLIESGdJVKZurLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725571120; c=relaxed/simple;
	bh=4xYfW8XzSbVr/rY5snsoEjwXj4+wxOXOIxc6GMht6eM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m1DJ++eAW37T9IrScd8xtMQAAljQ8qrrzT71dDuMGI5lVdv6OwaEz5jG0HOjmvsc5CACqvyy34csotnMBcKVRz2BZ2duPtGOyDk6aJ1gAVpD1mRzNd7NndXjxxA+fKril0IYCVgiHj/zD7jxrkBa2jJ+1Lw0podnlaGNyZpVXw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=DqijWDvM; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=fuOr00JS; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=llLLL0G3 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 485KqDXP030040;
	Thu, 5 Sep 2024 14:18:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=4xYfW8XzSbVr/rY5snsoEjwXj4+wxOXOIxc6GMht6eM=; b=
	DqijWDvMVNfbKrzwWqGgHOwsiTXtwf+qC8rEDykEhu41DaufSlHeu8Nug51xzsBa
	QtPAmSLHzpQ79HxRmvMtakkgP9ynm4sOqztljt/VBUwS+j8v5gldkiFPpGydFF1M
	V4HuvVZ1K24IIvIHFZ/5W2egwx5KX2hp9OHf8JUkIF7x/YdR221s/Uy+kuQi+g+H
	tCYWrSTtNKjJDJjIH7dDkX1AjFpxtjftBCrLk3WCrHc7JlO0DCaWyrSGaoB8O6D3
	0SILkS1X7Eyxxqrvu6t9ZTVC/ko3xSwOqc21BwHc6tXa/RNXUUBMMJyE6we7xcO+
	tQb9cL8fVukPlwB1VoaWRQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 41fhxt8qyb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Sep 2024 14:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1725571108; bh=4xYfW8XzSbVr/rY5snsoEjwXj4+wxOXOIxc6GMht6eM=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=fuOr00JSghnJQ97sdGMy3vRt0ChQ7w6CjZuWo+mDkjftc47T7wNpgril55lUEuaqR
	 hvg6x3qt67/HOP6sUwbWMgyUR7eTtZ74KC0BZ8zWjrg3P4O44M6OSfWbmH3h7Fxef6
	 nly+dix+Pekd/Nnvtg72abxRL+gZCLAZwByX7W5hTkPsYvZcUnvBooh8y3anyNrnX5
	 XGQ8+ZD0j+FIvCEPFUpTBfTjuFbIwZHjKzfMxh6T+cxtxGFRbD6WdCw0pjJgz4SUq5
	 w9HOFQcXYnXKWbSHEWmHWxVT3NVQGDmi14RTpdhlNzlsE2miCcymHJj9QBugb9Nt8U
	 gFapu7ZKT/WHA==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id DF7FB404CF;
	Thu,  5 Sep 2024 21:18:27 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 4BEB7A0265;
	Thu,  5 Sep 2024 21:18:27 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=llLLL0G3;
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 79A3C4052B;
	Thu,  5 Sep 2024 21:18:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KbVYfWQo7In/CQlwDduDsoCroEDs6mtJNL3grbvcYIGqTXiSnm38B8clLK9hQi8LBXPa11T6J442WAi/VYTRzbPetIYpNdQzssGYJ1F5minV1K8EzxGm02xYn1tPsK19tbkIS7+SlkZ34DgFiYbVGJDy0T0fQSb9RKyih4ZnzCMZPQCYYzdyMt+tKLr6hqVXr77jzciUVPPuCElMGyxVHhvHg+pbY/kxfsuYX3idpBna+VEWl10KFherQl3JBLztOajvu3mzZsLbhBI8BL+FzhsqfYp98IBx+r48UXeHl7/VD+//ntYKGzSW2FVFNSWNxmSvSmIU+REyGo3VDlfHYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xYfW8XzSbVr/rY5snsoEjwXj4+wxOXOIxc6GMht6eM=;
 b=qHIvPc6+t/j1yVnjEeA6gF8mCMBrZKj2opRBBO8xRMJCUdMfZUPdlcjrXm4ZB82AwjNgTCy1j0NfduVi7wwjdFDIqdqVSkuYL0eaTAQ2T0kOMibbdf6sTzT9fvWuax35IhUM2tjEccQlAc4M3ZAJhc1HrR1v41sC3ponG2YoX33Zo9vzMHujFuFv7pPmWTWJQgU9jgMcL9ceCDvxg3IWm8N5uyX00gBAsSWsfp5rbBf33XgMe2/+d40KTCpEEBsLpdcfjtGmMlXpVkAFYa+ZX9p3SAlCFUxWtvM++KJKUj3jwljzlfOyPGXM6E2QgTddBhFPC0owPXcltZ/usqHbaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xYfW8XzSbVr/rY5snsoEjwXj4+wxOXOIxc6GMht6eM=;
 b=llLLL0G3tYOxTzCfxaiUe/ZJAW25WfijMfmHhoX68ePDVcMqE+37WrpZdT84haBWJjG/Nf1aQTBl1HD29ohK2JGDnzfaVp8oLWpDcln+G7Xf8PyuaPJcPCBO0SU8mBG7rQ7CHKsJ5r+gYJ8QIZkX5KskvKN9lDczjXfZUDUl0P4=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DS0PR12MB8528.namprd12.prod.outlook.com (2603:10b6:8:160::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 21:18:23 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 21:18:22 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: AKASH KUMAR <quic_akakum@quicinc.com>
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
Subject: Re: [PATCH v2] usb: dwc3: gadget: Refine the logic for resizing Tx
 FIFOs
Thread-Topic: [PATCH v2] usb: dwc3: gadget: Refine the logic for resizing Tx
 FIFOs
Thread-Index: AQHa/gVcU2dx3NbwU028Vf9GncOMbbJGoECAgADT3ACAAL0/AIAArWiAgADXcoA=
Date: Thu, 5 Sep 2024 21:18:22 +0000
Message-ID: <20240905211817.jzbjlfrysql37cqu@synopsys.com>
References: <20240903132917.603-1-quic_akakum@quicinc.com>
 <20240903221055.s4gu6actfbrkonmr@synopsys.com>
 <b016abbb-7214-4892-b1d2-1bf3ba1b7560@quicinc.com>
 <20240904220632.35b4nvhmngt6akl6@synopsys.com>
 <b2ffd1ec-2168-4e58-8aee-b43f1231d4ac@quicinc.com>
In-Reply-To: <b2ffd1ec-2168-4e58-8aee-b43f1231d4ac@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DS0PR12MB8528:EE_
x-ms-office365-filtering-correlation-id: 941177f9-c8fd-4bde-28c3-08dccdf045de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?L2VMZnNxNVpJMDFpWTVVbDdKaXllSVNXRDlOVll1SDBYd29WN3ppSXBKeWxy?=
 =?utf-8?B?VDFYSGttdGp4dlM5Y1RWUDRLS3NvdE9GSGN2NUpWVFo4VGZhRFFnQS93aFpn?=
 =?utf-8?B?V3hvSE1ZeVJMT3pSVGNzcmJkNXFNZ01pL1ZmRzZlbEprb2ZIMDd6UGsrUThU?=
 =?utf-8?B?MW1jZTMwTG9iQUhCMlNQckdXNGUzRjhWdlJ5SnJjeWt1L3JnNlpyVGJBTWZU?=
 =?utf-8?B?RnRSd0xnVHcyUlQxVkQ0NmRhTVl4VmtBTWFOaWpkT2U4dnNONnp2Zk5PRm85?=
 =?utf-8?B?aWY3ajFwNWhPZ0V3WHhuV1RNQkxMa1NWdGV3R05DTUU1Sit5eDlqbjlJNHhL?=
 =?utf-8?B?WUJxazRsSjBKMytWK1M4amV5WVhSY1R1Wk9nejh1cmkzMG9IRTBwV1dkTkMx?=
 =?utf-8?B?VU0zMVMvTnJGdmxnbDl1cW9nZnFKZndvWTVxRVZlei9iTndjS1NMZnBOUDhp?=
 =?utf-8?B?VmZ4ZFErSnJkbDAvRmpoemc0RXFZTzd5MUdoZTBIbk1oOEFBaHBBcUxsN0I1?=
 =?utf-8?B?MEdBZUZTaXRCMWJNV0k5MWZCQTFuM2VMTGhLWW5mNk1kT0R2TXkwdVZjTEZP?=
 =?utf-8?B?LzdDWHc1VTNuQzA3TEQ0azlNaExtU0dzbGV2b3NDL1ZIaUtLVFZxYVZVSXB4?=
 =?utf-8?B?cVBuNXhpZ0NjLzRnbExCOEZjSHRwaHJBWGp4UXg3Z0s3M0lYYWJxanU4OENr?=
 =?utf-8?B?d2YyUDIxTDg3R013RHFqVHNDTmlVT0xDL01QWXhQVHRJWkIwOXhrdmFzV1RB?=
 =?utf-8?B?bVJLaFdIQWdnbjlkUmltRkFRenFhM0ZlSCsyUlp6c1h6M3ZkdS9Yd3BSSVlH?=
 =?utf-8?B?eU5yOERBaDFoU0RxdzI0TkVLYllZRnV3TnpQUUYrellLaW5kd0lCc1Q4Znlw?=
 =?utf-8?B?bDVod0IrOE1tY2dsRjJYTnRSSjBBMi9tMFZrRkhNUXBVKzI4b2N6RFNTNU11?=
 =?utf-8?B?dWRTZnlaU0w0eFF1NGU5dlZEQXkwVHVmcWw5RFZ4c2Fwc3c1OXNaQlo1ZXVu?=
 =?utf-8?B?cmowaHh5Rk11eW1hOEJOYjk3T2tIZHorTGwveUhKUytxQkQ1bUtrZnV6cUlT?=
 =?utf-8?B?YmdyWUlua1FsVHRZNHcrbFZxTDRFaTYzQzVjZTIrdXlqcDUwaFZ0SmF4R09C?=
 =?utf-8?B?aUZnTlUwQndKT294eWM1bHJLUWhBNktjOG5ORW43Qis5OVgyd3FvL1hvZFVK?=
 =?utf-8?B?T1NCTXhsRldVYkdZSUpJR0lDbU5xYllwbVVGU0J5d3cwMms4azZLRVVCQm5D?=
 =?utf-8?B?RnFVSzdKenBZdWU3eGhMVFhuZWdUTXFZRWcycXd1TE52NE11OTc4cGlpYnlh?=
 =?utf-8?B?NU1YUTZjYUtPZjJXS2l2WG9DWi84VHpKQTByMDZPdUdlUmhhTjNiZzBOUVk1?=
 =?utf-8?B?WG9BMWMxbVUxY3V3VGw0dS94c1Y2YkFJeXhxdWhJWWtmQWpOb1dzaG9IQVhH?=
 =?utf-8?B?OFEyM2UzOUJJTzJKQzErUUE3OTRLWGw0RmdEMmsraWNQMjJiSlB3aS96K05i?=
 =?utf-8?B?R2QzK3JGUlhFek93TUZFQUt5cVA1TlBBMHgwRThCd3VKRFJxSE1vVHZkSmJ5?=
 =?utf-8?B?dFpENGpVYXV4MVlDT21aRlFQcFFqUlRFOXErd0dGUlp2bFNqSmxqMEhEZGdD?=
 =?utf-8?B?UFREY0dpSWxaUzZ2dURaZXhOamRzZkhPcElyKzQ5M3BZdy83RzY5clhPZ0lE?=
 =?utf-8?B?Vm42OTBlQklsWldHWmJ0dWZOclA0R29nNDNkZExoSjlLOHFLKzRONFN3VmIy?=
 =?utf-8?B?d3M1bGMwNzFEWnkrSzZkaGlJQmxlZjBjRFZ2RHdhYmJUVjdGOEJUWG40anFX?=
 =?utf-8?B?YkszOW4zNDh4aUlKREx2WEkwQUlraEkrNUtaMmxyWU1DWHZ4YklBZExodGsv?=
 =?utf-8?B?clFyVnMwRHhBTkNibWs1RGxXaVVONU11dktIME5PYThWbWc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aEZydDczWFp6UzZRVFJkb2I0UWxJcWtBWVl5U1d3TWNJVzQ4TS8rZW1wV2ln?=
 =?utf-8?B?TVh6bGJseXZsa0NPSjAxVzl4T0NOOXJMcGZFakVNeHU2dHpKb1lJUUhOeDBX?=
 =?utf-8?B?djcwZkl4VFA3N2kxRWdydk5BeWVDbjBzRnVhY2tCek82Kyt2aEFXZG05c2Va?=
 =?utf-8?B?Vk9MY29KZGFOVEo4YVVFTGhsRWpQSlZTc0NQVjJSU0pwK1hJbmFwWUVRTUZi?=
 =?utf-8?B?RyszMWhVNVNVUjNET3Y4VzIyVDh6cXhMVm1tYkNvckpKb013cVgxU3k5NWJi?=
 =?utf-8?B?ZE5TeFpkd0FPS2tuUTkwQnBWMXZwZ1cxRWl1QWZxaFF0eGh1cjBLNnJWZlpX?=
 =?utf-8?B?SlgySXYvdWJGK2JNdER4TlBnOTI3TTJIc1J2NmRxWVQ5TGxSdmNlTVorcDRJ?=
 =?utf-8?B?c0NRazVPUWVQbHN6cE1qYi9IeTAxU3p1QlpHUmg3NGorZkM4dE0yUHRqNlFI?=
 =?utf-8?B?U3Bhb2s2UDhzQXY2TUk4a1pTdUtBb2ltczJsWng2NDJjeTZqNGxTM0Q2c3Y0?=
 =?utf-8?B?N3l3a1lFRE54cVg3QStxS3hUYldXU3ZNNVRjN3JaUEdnU0JRSXJFNUVjaitO?=
 =?utf-8?B?ZWthcmVSZzYwNk55ZkhmcWFqRDVqd1pWY2Excm94Q0Rrc2dpWVRUaEt6QkVP?=
 =?utf-8?B?QzdtZDVIRXU2WG43MEVkSjF6SmtqbGp0YXZ2RWQ5WTRLYWdiSzF2WU0xV09L?=
 =?utf-8?B?MGMySFU5OE1pNklhM1UveHZzS2d2MFJCUjdVcXlqa3EvcDZjQkVZMkdlMjBN?=
 =?utf-8?B?K2F6eTI4aE1abWZYK3lXSy9DcUovMVloQnVBSjBkNnY0ZDNrN3g0QkhkL3Vu?=
 =?utf-8?B?eG9YQllhR081SGNoRnN6M0lLem9jRlhyOThsdGJvQW93WXB1YnYwUmhpWFNG?=
 =?utf-8?B?WWwrazVRTklXYUowdFFxV0VBZHhONWZUSE4waGFNTzdaZHhxUGFUUXpaeEdV?=
 =?utf-8?B?NStiUDNVODdFakpXbjJUSk5PRCtLOGlFVEUyemVTTk9aSXZjYm5mNkkzMHVw?=
 =?utf-8?B?eERGTHVzdG40cUFYY1JQVlZXcnlvekNnMDdONW9JVkZmMCthVUxSdUY2YSs1?=
 =?utf-8?B?ckpFajBlWmJTejlySTFFVDhkTC9ianZwTEtqRGpITW1TdUtoaEdzUnh0V2lK?=
 =?utf-8?B?bVQxbDlCM0xMYTJodER1ZTVwTUtMb3ByWEFrMFRPYng5WEpKcjRyaE5MT1Zj?=
 =?utf-8?B?SHJpRWRXYXAwaEM4dmxWemtvRHpGRDJod1RpMW5IQm5FYkZ5SVNaQmczekli?=
 =?utf-8?B?YldOQUxrcjJPN0FMTGFISWtMd0EzZDYrcFRtMVA4Vm1oUndBanZsZjI1S1Q3?=
 =?utf-8?B?YURzaUt5d1JYS2JyMmswU2t3SnIwSE9ob3J0VEJNV0MyKzBJLy9JTEZZK1VE?=
 =?utf-8?B?amIreTVxTWNSS0trVE1EN1FRK2Q2eG5kL2xwNWVCMzZMMnlQZy92TTNWTUNB?=
 =?utf-8?B?OE56SHRvTFQvelFLcEhxWllRYlI5eXZqdEZDQ0hsTC9nV25Tc29MaythT3Z6?=
 =?utf-8?B?cFZ3L2hzbnFkeFZDeHlVOTRVdVJsbWJlTWswTVVkeXFEdzhpaW5pWkNXKy9Z?=
 =?utf-8?B?ZCtXUHpXMU1KZFM1czZ1NmlkbG1kTjlRWldVUXVQMXppU0crOENHSm9vOXZo?=
 =?utf-8?B?ck5LZmIwdkpJejZXMXF6ZzRPZTFrKzRsTjRvRXZ1VXU1TzVtSTN0NXZhdEVW?=
 =?utf-8?B?cUNTMkVnRVUrOGdXdTlWcTVJMmZaUE5jay9pcnZzNFlOZmVEWk9sZ2d0R0h4?=
 =?utf-8?B?T2FFeDBicUd6QWo4YVIwT3QyLzN1TnlCbEg3SXVSWUYvWERVNURzQ2JCbnJ5?=
 =?utf-8?B?Ukt4TDEwbFR1eVprQkhvZnhRNGIyYUx4K0tQWnl6NUVJdGFxNHpJRHc0WFJu?=
 =?utf-8?B?Tmc4RE8zNWVKOEg0QzZlUnV6THdqVUI2U0pXM2dySUQ0SXcyUEFoM2IxY1Bt?=
 =?utf-8?B?OFJGN3ZMN2lJWk5QWk1kMVR0cDFlcmF3c0RuQjRVeDNPamRiZXpNZEhmNTFx?=
 =?utf-8?B?OUw2T2p5N0IyMW5Kak5jam5wLy82MDBveFNyTkZjcGI5Ny80RGZIcTh2UEwv?=
 =?utf-8?B?djh2YTNmcWtYUzMwS2x2Mm1lZ0VSMW5hWmFNQ0RtRCtOVldnMWJYaXlXNjZs?=
 =?utf-8?Q?BoJ7TdammD9h53yJsu9jJw1ws?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <07861D0458E75F45A3E78387B661CEAC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oewoIb3lZ+xOX+rOsqq7Es/belRXyzcKxmw9FbjakzUcyiKovliRi4HkMrdt6e36Kj2cxZBSOFcDPgpoRqtEJtJOdzg+TUDHa2lQ4y8oNgGpzhYNSeXteB8kn5fb+fGpX/ArKji2jCxbH2MF6VgYhxVHVNjk2nKc86YajoEbJ6VtzAb2xh69/bABIlohUQfGeNrMONX3kr3v7oLkAV7B8NWYQVrClRAQ/hJtJbjffyHg1lXgP0r5v69Nmzzv6lHEkgP+flBwmUhD9dFhcGAgpGAU+3wzzCqejLWWbEUkRnxfd+Wv5+OTsGul2BR4fHE212sMybaocGDOZBvDLVk8vh5HZT9GROjPzqq7Bt/BDLye13wzHQkAaOyq+70ZNK9fzNLHB5iBIFnMnlA4PT4DhI95BwgP2LA066SE7wUH8jo1RvImhUhrwOnqkm3sQxd6z3AFygSlJVEyWM0kydoFPlSkjtkgBSdZ6sWpBmjnXPjRRMiolWrplQHrJjneaiOK3/rbA0nPbF/N08OZkr/0rXJFfO/3q+izM5uEdHNRsBL2xSQMX0bIjmFDnuDCpE1ItVpDboEM8ESzBjL3+Gi0zidAdxUmx8PMZ3XwfDatxcrTP/rlhcllaLZB6Ny9FIjc/P+8TmCZcNBceppw6rYImw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 941177f9-c8fd-4bde-28c3-08dccdf045de
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2024 21:18:22.7678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J0sO8JP1nolXVT5XklI4Rk2U81F2UUQvCwUJGrNL/wJIS0hiCOnWu/0sAw7llnqnA2cbX5E2UVR7a0PJrUnRpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8528
X-Authority-Analysis: v=2.4 cv=H/mJwPYi c=1 sm=1 tr=0 ts=66da2025 cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=nEwiWwFL_bsA:10
 a=qPHU084jO2kA:10 a=COk6AnOGAAAA:8 a=ngAr0YGKF9kr1eKDODcA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: vUuaL6nwJ8tFk6FXoJB92icmvUCTB5Vb
X-Proofpoint-GUID: vUuaL6nwJ8tFk6FXoJB92icmvUCTB5Vb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_16,2024-09-05_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0 phishscore=0
 impostorscore=0 clxscore=1015 mlxlogscore=999 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409050158

T24gVGh1LCBTZXAgMDUsIDIwMjQsIEFLQVNIIEtVTUFSIHdyb3RlOg0KPiBIaSBUaGluaCwNCj4g
DQo+IE9uIDkvNS8yMDI0IDM6MzYgQU0sIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiBPbiBXZWQs
IFNlcCAwNCwgMjAyNCwgQUtBU0ggS1VNQVIgd3JvdGU6DQo+ID4gPiBIaSBUaGluaCwNCj4gPiA+
IA0KPiA+ID4gT24gOS80LzIwMjQgMzo0MSBBTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+ID4g
PiBPbiBUdWUsIFNlcCAwMywgMjAyNCwgQWthc2ggS3VtYXIgd3JvdGU6DQo+ID4gPiA+ID4gVGhl
IGN1cnJlbnQgbG9naWMgaXMgcmlnaWQsIHNldHRpbmcgbnVtX2ZpZm9zIHRvIGZpeGVkIHZhbHVl
czoNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiAzIGZvciBhbnkgbWF4YnVyc3QgZ3JlYXRlciB0aGFu
IDEuDQo+ID4gPiA+ID4gdHhfZmlmb19yZXNpemVfbWF4X251bSBmb3IgbWF4YnVyc3QgZ3JlYXRl
ciB0aGFuIDYuDQo+ID4gPiA+ID4gQWRkaXRpb25hbGx5LCBpdCBkaWQgbm90IGRpZmZlcmVudGlh
dGUgbXVjaCBiZXR3ZWVuIGJ1bGsgYW5kDQo+ID4gPiA+ID4gaXNvY2hyb25vdXMgdHJhbnNmZXJz
LCBhcHBseWluZyBzaW1pbGFyIGxvZ2ljIHRvIGJvdGguDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4g
VGhlIG5ldyBsb2dpYyBpcyBtb3JlIGR5bmFtaWMgYW5kIHRhaWxvcmVkIHRvIHRoZSBzcGVjaWZp
YyBuZWVkcyBvZg0KPiA+ID4gPiA+IGJ1bGsgYW5kIGlzb2Nocm9ub3VzIHRyYW5zZmVyczoNCj4g
PiA+ID4gPiANCj4gPiA+ID4gPiBCdWxrIFRyYW5zZmVyczogRW5zdXJlcyB0aGF0IG51bV9maWZv
cyBpcyBvcHRpbWl6ZWQgYnkgY29uc2lkZXJpbmcNCj4gPiA+ID4gPiBib3RoIHRoZSBtYXhidXJz
dCB2YWx1ZSBhbmQgdGhlIG1heGltdW0gYWxsb3dlZCBudW1iZXIgb2YgRklGT3MuDQo+ID4gPiA+
ID4gDQo+ID4gPiA+ID4gSXNvY2hyb25vdXMgVHJhbnNmZXJzOiBFbnN1cmVzIHRoYXQgbnVtX2Zp
Zm9zIGlzIHN1ZmZpY2llbnQgYnkNCj4gPiA+ID4gPiBjb25zaWRlcmluZyB0aGUgbWF4YnVyc3Qg
dmFsdWUgYW5kIHRoZSBtYXhpbXVtIHBhY2tldCBtdWx0aXBsaWVyLg0KPiA+ID4gPiA+IA0KPiA+
ID4gPiA+IFRoaXMgY2hhbmdlIGFpbXMgdG8gb3B0aW1pemUgdGhlIGFsbG9jYXRpb24gb2YgVHgg
RklGT3MgZm9yIGJvdGggYnVsaw0KPiA+ID4gPiA+IGFuZCBpc29jaHJvbm91cyBlbmRwb2ludHMs
IHBvdGVudGlhbGx5IGltcHJvdmluZyBkYXRhIHRyYW5zZmVyDQo+ID4gPiA+ID4gZWZmaWNpZW5j
eSBhbmQgb3ZlcmFsbCBwZXJmb3JtYW5jZS4NCj4gPiA+ID4gPiBJdCBhbHNvIGVuaGFuY2VzIHN1
cHBvcnQgZm9yIGFsbCB1c2UgY2FzZXMsIHdoaWNoIGNhbiBiZSB0d2Vha2VkDQo+ID4gPiA+ID4g
d2l0aCBEVCBwYXJhbWV0ZXJzIGFuZCB0aGUgZW5kcG9pbnTigJlzIG1heGJ1cnN0IGFuZCBtYXhw
YWNrZXQuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogQWthc2ggS3VtYXIg
PHF1aWNfYWtha3VtQHF1aWNpbmMuY29tPg0KPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+IENoYW5n
ZXMgZm9yIHYyOg0KPiA+ID4gPiA+IFJlZGVmaW5lIGxvZ2ljIGZvciByZXNpemluZyB0eCBmaWZv
cy4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBDaGFuZ2VzIGZvciB2MToNCj4gPiA+ID4gPiBBZGRl
ZCBhZGRpdGlvbmFsIGNvbmRpdGlvbiB0byBhbGxvY2F0ZSB0eCBmaWZvIGZvciBocyBpc29jIGVw
cywNCj4gPiA+ID4gPiBrZWVwaW5nIHRoZSBvdGhlciByZXNpemUgbG9naWMgc2FtZS4NCj4gPiA+
ID4gPiAtLS0NCj4gPiA+ID4gPiAgICBkcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIHwgMTUgKysr
KysrLS0tLS0tLS0tDQo+ID4gPiA+ID4gICAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygr
KSwgOSBkZWxldGlvbnMoLSkNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy91c2IvZHdjMy9nYWRnZXQuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gPiA+
ID4gPiBpbmRleCA4OWZjNjkwZmRmMzQuLjQ5ODA5YTkzMTEwNCAxMDA2NDQNCj4gPiA+ID4gPiAt
LS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ID4gPiA+ID4gKysrIGIvZHJpdmVycy91
c2IvZHdjMy9nYWRnZXQuYw0KPiA+ID4gPiA+IEBAIC03NzgsMTUgKzc3OCwxMiBAQCBzdGF0aWMg
aW50IGR3YzNfZ2FkZ2V0X3Jlc2l6ZV90eF9maWZvcyhzdHJ1Y3QgZHdjM19lcCAqZGVwKQ0KPiA+
ID4gPiA+ICAgIAlyYW0xX2RlcHRoID0gRFdDM19SQU0xX0RFUFRIKGR3Yy0+aHdwYXJhbXMuaHdw
YXJhbXM3KTsNCj4gPiA+ID4gPiAtCWlmICgoZGVwLT5lbmRwb2ludC5tYXhidXJzdCA+IDEgJiYN
Cj4gPiA+ID4gPiAtCSAgICAgdXNiX2VuZHBvaW50X3hmZXJfYnVsayhkZXAtPmVuZHBvaW50LmRl
c2MpKSB8fA0KPiA+ID4gPiA+IC0JICAgIHVzYl9lbmRwb2ludF94ZmVyX2lzb2MoZGVwLT5lbmRw
b2ludC5kZXNjKSkNCj4gPiA+ID4gPiAtCQludW1fZmlmb3MgPSAzOw0KPiA+ID4gPiA+IC0NCj4g
PiA+ID4gPiAtCWlmIChkZXAtPmVuZHBvaW50Lm1heGJ1cnN0ID4gNiAmJg0KPiA+ID4gPiA+IC0J
ICAgICh1c2JfZW5kcG9pbnRfeGZlcl9idWxrKGRlcC0+ZW5kcG9pbnQuZGVzYykgfHwNCj4gPiA+
ID4gPiAtCSAgICAgdXNiX2VuZHBvaW50X3hmZXJfaXNvYyhkZXAtPmVuZHBvaW50LmRlc2MpKSAm
JiBEV0MzX0lQX0lTKERXQzMxKSkNCj4gPiA+ID4gPiAtCQludW1fZmlmb3MgPSBkd2MtPnR4X2Zp
Zm9fcmVzaXplX21heF9udW07DQo+ID4gPiA+ID4gKwlpZiAodXNiX2VuZHBvaW50X3hmZXJfYnVs
ayhkZXAtPmVuZHBvaW50LmRlc2MpKQ0KPiA+ID4gPiA+ICsJCW51bV9maWZvcyA9IG1pbl90KHVu
c2lnbmVkIGludCwgZGVwLT5lbmRwb2ludC5tYXhidXJzdCArIDEsDQo+ID4gPiA+ID4gKwkJCQkg
IGR3Yy0+dHhfZmlmb19yZXNpemVfbWF4X251bSk7DQo+ID4gPiA+ID4gKwlpZiAodXNiX2VuZHBv
aW50X3hmZXJfaXNvYyhkZXAtPmVuZHBvaW50LmRlc2MpKQ0KPiA+ID4gPiA+ICsJCW51bV9maWZv
cyA9IG1heF90KHVuc2lnbmVkIGludCwgZGVwLT5lbmRwb2ludC5tYXhidXJzdCwNCj4gPiA+ID4g
PiArCQkJCSAgdXNiX2VuZHBvaW50X21heHBfbXVsdChkZXAtPmVuZHBvaW50LmRlc2MpKTsNCj4g
PiA+ID4gTm8uIERvbid0IG1peCB1c2JfZW5kcG9pbnRfbWF4cF9tdWx0IHdpdGggbWF4YnVyc3Qg
bGlrZSB0aGlzLiBDaGVjayBiYXNlDQo+ID4gPiA+IG9uIG9wZXJhdGluZyBzcGVlZC4gQWxzbywg
bm93IHlvdSdyZSBpZ25vcmluZyB0eF9maWZvX3Jlc2l6ZV9tYXhfbnVtIGZvcg0KPiA+ID4gPiBp
c29jLg0KPiA+ID4gU3VyZSB3aWxsIGFkZCBzZXBhcmF0ZSBjaGVjayBiYXNlZCBvbiBzcGVlZC4N
Cj4gPiA+IA0KPiA+ID4gV2UgaGF2ZSB0byBzdXBwb3J0IHRocmVlIHZlcnNpb25zIG9mIENBTSBz
dXBwb3J0IHRocm91Z2ggc2FtZSBkdCBhbmQgaW1hZ2UNCj4gPiA+IFNTL1NTKyBjYXBhYmxlIGNh
bSB3aGljaCBuZWVkcyAxMGsgZmlmbw0KPiA+ID4gSFMgY2FtcyB3aGljaCBuZWVkcyAzSw0KPiA+
ID4gbXVsdGkgVVZDIGNhbXMgd2hpY2ggbmVlZHMgMWsgYW5kIDJrIGZpZm8NCj4gPiA+IA0KPiA+
ID4gUHV0dGluZyBhbnkgZGVwZW5kZW5jeSB3aXRoIHR4X2ZpZm9fcmVzaXplX21heF9udW0sIHdl
IGNhbid0IGFjaGlldmUgMWsgYW5kDQo+ID4gPiAxMEssDQo+ID4gVGhhdCBkb2Vzbid0IG1ha2Ug
c2Vuc2UuIFRoZSB0eF9maWZvX3Jlc2l6ZV9tYXhfbnVtIGlzIGEgY29uZmlndXJhYmxlDQo+ID4g
Y29uc3RyYWludCB0aHJvdWdoIGRldmljZXRyZWUgcHJvcGVydHkuIEhvdyBjYW4gaXQgbm90IHdv
cms/DQo+IGkgaGF2ZSB0ZXN0ZWQgYW5kIGkgZG9uJ3QgaGF2ZSBhbnkgcHJvYmxlbSBpbiBhZGRp
bmcgY29uc3RyYWludCB3aXRoIEhTIGJ1dA0KPiBmb3IgU1MNCj4gaSBuZWVkIHRvIHNldCBmaWZv
IHNpemUgb2YgMUsgZm9yIDEgY2FtIGFuZCAxMGsgZm9yIG90aGVyLg0KPiBpZiBpIGFkZCBhbnkg
Ym91bmRhcnkgd2l0aCB0eF9maWZvX3Jlc2l6ZV9tYXhfbnVtIChlaXRoZXIgbWF4IG9yIG1pbiAp
IG9uZQ0KPiBvZiB0eCBmaWZvIHNpemUNCj4gZWl0aGVyIDFrIG9yIDEwSyBpIHdvbid0IGJlIGFi
bGUgdG8gc2V0LiBTbyBpIHJlcXVlc3QgeW91IGFsbG93IHRvIGZvciA+PVNTDQo+ICwgdG8gZGVj
aWRlIGZpZm8NCj4gc2l6ZSBiYXNlZCBvbiBtYXhidXJzdCBvbmx5LiBpIHdpbGwgYmUgcHVzaW5n
IHBhdGNoc2V0MyB3aXRoIHRoYXQuIHBsZWFzZQ0KPiBhcHByb3ZlIGNvbnNpZGVyYXRpb24gdGhp
cy4NCg0KSSBzdGlsbCBkb24ndCB1bmRlcnN0YW5kLiBEaWQgeW91IHRyeSB0byBpbmNyZWFzZSB0
aGUNCnR4X2ZpZm9fcmVzaXplX21heF9udW0gdmlhIGRldmljZXRyZWUgcHJvcGVydHk/DQoNCkkg
ZG9uJ3Qgd2FudCBpbmNvbnNpc3RlbnQgYmVoYXZpb3Igd2hlcmUgdHhfZmlmb19yZXNpemVfbWF4
X251bSBhcHBsaWVzDQp0byBzb21lIGJ1dCBub3Qgb3RoZXJzLg0KDQpCUiwNClRoaW5o

