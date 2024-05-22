Return-Path: <linux-kernel+bounces-186611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2EF8CC644
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 20:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81382B212C0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 18:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD1B145B39;
	Wed, 22 May 2024 18:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="wBHGrYl0";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="eLhDqd06";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="dlidXFkb"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90205762FF;
	Wed, 22 May 2024 18:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716402261; cv=fail; b=V3tBH20S2OX6r/L0yxLZlQ7TcifjYp0J9mlIbM4zp/XQJrFE4smDxdqonXb+/qtnvuPmt5S9HelAx03xeeAKaljeODHlLyDg+RPFCuVExTQAhKYyaKZXVA9wuW1GfJLYE6xf9BzEOPAbi8iL9H9vYRDk+wlmnRK7R49Gm4+mHIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716402261; c=relaxed/simple;
	bh=Z++4WoDma6sxiti9EkRLyxwlDvMkYyJjyGGkoJZjO/I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Dy13YZ5kifdkvOOuPNJZMPUol+EecDIZqfbE/BNRT+ENHma8fiPfkZwuET+DllG+XvTI1Z5Idtg4IAzPHmMMRfUkVD9/eWejcMBqL3O6raOFK4u7cbXODXR3DNdC/CxHhlGBV1yKUB15DlSlkRt/kRZCAP4eAjenDcuD38skhnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=wBHGrYl0; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=eLhDqd06; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=dlidXFkb reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44MGg0db021814;
	Wed, 22 May 2024 11:24:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=Z++4WoDma6sxiti9EkRLyxwlDvMkYyJjyGGkoJZjO/I=; b=
	wBHGrYl02E9tdq8nNWLDFUavZ916KLJEUDGmXyRGIzZ2CWCuA30PW1qrceJgfmU3
	sOMS43/hJtD25OPCmh06wlsUuVsiRT/i6FJgVJgc2ahhbIidlqh7MHwshPkXwphD
	4DX+imvD9HqXWmvKC8AUAfMxw9lTZw4oR6OMoXkV8KDHPwNDbdWl/SCrDRm1CcB5
	9MkC/GSDVFTnzm53GrzANJma+fRO/mDww011bqdtgXLyJDiNONOdmNAYzD0ZaO5T
	4RAfaKxXQOTTWa4FzEcHLcxYE9izNOYdNw4u3n1xnWvjzc4BCj/kzIvo4AiJEsBl
	8jXQ2yrwmp+vz7Fxa6UJVw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3y6u8sk1wr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 May 2024 11:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1716402247; bh=Z++4WoDma6sxiti9EkRLyxwlDvMkYyJjyGGkoJZjO/I=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=eLhDqd06ySz3q6oHfEgfZxoiP/+umvVuXyNHyffMsOHeCjpepovFBGHwa3Qrq9ejV
	 VTwg66HZJEn4eyEiLxd61LWB89KRV8tQ91+q6C77AdfzlHH0E6TSuaEdl6SMURi3IC
	 tPTNRFwkc20ckGGE/8ogo6bph+Pi+WVCbgTd79rFuRxhclVfwJWCsc9gbRGr2n7ObM
	 OqesawDjZQb92A+VcQo7QdsBSAyb32PQNV4L9ytjqwsDVwN9HZNTurjXCf6+3YvF7m
	 yfoIu8WuUeMCCOlOgSUACfuNGAFR4TwMTxycBzmfZZgz30I4PJjOrISQAfkZuHSRcc
	 8t1+QZWkcqzWA==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C71F940585;
	Wed, 22 May 2024 18:24:06 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 599CAA007B;
	Wed, 22 May 2024 18:24:06 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=dlidXFkb;
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 0209940565;
	Wed, 22 May 2024 18:24:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYWWHNS9GgcYfAvrL+i4S+ouF1Iv8MFllTxob/bW1mTiYNt5Yy7os/fCirHEBRE+zII+UK5yvmdMfHdkim3ZNkfZOvcAXzw/ecyHpZsprxpJ7ny17HacpSaBpfGkZ70N6uVWPgWHb6mquwr8X0Z48QRSzUOldfSkJ5+jFww1A9snPFRbdquDz4cXqRnAprBLp+dyZimZyFfV3e0+qhWcJt4P3JLSped7zBtZnzcQOhzNJMjYUvw1iYZmWYFHIre24U/5KHjWQpRASy3E31J85XdzrST6dMHiLGBP7nNh9swCQA29dtjznkpydkmiHA8PxzxcKNYCyea+qNo720mCVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z++4WoDma6sxiti9EkRLyxwlDvMkYyJjyGGkoJZjO/I=;
 b=Vs+5/wSSaEyNPfz6+OJ4w1z55jtoULIq0cVX1UTxj8O2LFu0e+ox5BQvmUk/20xA8PPqtc3XjPCgdushg6AAyLgIf3fFGhh0put7kjqcy6ekHVmgTi9ISDoUb7AFNtMkcF6+iA3d3W4/zqeCL7UtGRIGn7OQkx9xtOEmg2UYWM300lUd7Ju+qcYk7e1yxEWKljg4eeJJQCEphMriwvci0Eont6VSaT0fJ0zp2rQPrndPk/XDW3YvZdp2NRoJD4ZaicAJdzpr4UFepZRYAyB9j/eZ5y65cC9VblH2JXKSbf9qu3lM+guKJekaG6jA0yIudkj9NDwEQaBdktfF58RQWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z++4WoDma6sxiti9EkRLyxwlDvMkYyJjyGGkoJZjO/I=;
 b=dlidXFkbkBYME6ZEvSH/mL4DOna+eGPtuSunBvx8IN7QfaYfVZmebmutLSJBOALsiZA9bnUXJZGlbrRyz9dVObVUpfMnPVmuwp8XK5tYunX3LiTCisfK0LsoDJ+Kyaa21KPtGwfKRWP1j8m7Ao6TQ77/BYi2R4/SV3hvIbD4Gaw=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SJ1PR12MB6123.namprd12.prod.outlook.com (2603:10b6:a03:45a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Wed, 22 May
 2024 18:24:00 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.7611.016; Wed, 22 May 2024
 18:23:58 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Michael Grzeschik <mgr@pengutronix.de>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Avichal Rakesh <arakesh@google.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jayant Chowdhary <jchowdhary@google.com>,
        "etalvala@google.com" <etalvala@google.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] usb: gadget: uvc: allocate requests based on frame
 interval length and buffersize
Thread-Topic: [PATCH 0/3] usb: gadget: uvc: allocate requests based on frame
 interval length and buffersize
Thread-Index: 
 AQHaisR7p/ka60fKF0m666TF1RlbgLFzcN6AgAGh4ICAAOvGgIAAlmuAgAAznACAHZQygIAGhRmAgAfA2gCAABofAIAA3HGAgAAo1QCAAAX1gIAADM0A
Date: Wed, 22 May 2024 18:23:58 +0000
Message-ID: <20240522182348.4jyitatwtdqeo2gf@synopsys.com>
References: <ZifEvUi9-E8M4dp8@pengutronix.de>
 <17192e0f-7f18-49ae-96fc-71054d46f74a@google.com>
 <20240424022806.uo73nwpeg63vexiv@synopsys.com>
 <ZkE-O0yJ33T9hWa0@pengutronix.de>
 <20240517014359.p2s44ypl4bix4odm@synopsys.com>
 <Zk03Ys1rA0I5yiZy@pengutronix.de>
 <20240522014132.xlf7azgq2urfff2d@synopsys.com>
 <3f404a27-50e8-42c5-a497-b46751154613@rowland.harvard.edu>
 <20240522171640.iuol4672rnklc35g@synopsys.com>
 <Zk4td_0RR0cMJKro@pengutronix.de>
In-Reply-To: <Zk4td_0RR0cMJKro@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SJ1PR12MB6123:EE_
x-ms-office365-filtering-correlation-id: a7f94c2c-d030-4e29-0617-08dc7a8c58b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|376005|7416005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?bFp3MGxFaFIzaWxHanhkMTdoYWYyRm12VWlxRC81bGFUMWNPb1pQTXFrVzFC?=
 =?utf-8?B?TUs1NkJoWGZXWmp0OFVRREFuSFVXQ2ZEVkY5SWFETFJJMWc4cEEzQXVWTmNt?=
 =?utf-8?B?Mkt6OVlsNW1kYjRKeVFsSGNPWm9qMFE1aldFWk51WDV1VkFhbjFmMzhYaEpj?=
 =?utf-8?B?T3pwc21RREdqdTEvZVk2L1R5SlBoZDdxYVJkeUFCbDhCQXBhZGVTb3l1a3VY?=
 =?utf-8?B?S1NmS0VkMERlT241ODYvR3ozdVZkN3h3N0ZkcjlzRTF0MUkrMytycHJEWGRj?=
 =?utf-8?B?VVJuaE5MNHlXZUJnM2xzQTdVVVlTb0ltRTFjMk5DbFIxMTd4NjdTM1hSak81?=
 =?utf-8?B?RjAzeHdiVzUwcGFENUl0MmFJdVNCSTJUQ1IzS014Qm5DK1A5TXNCRFBiWjlv?=
 =?utf-8?B?T2h4YWpLd2tuV2tseFIzNlVnM3laR1phSHIxQUxGM2p1QmdvUmVKcWhiTVBx?=
 =?utf-8?B?SjJYY2U1cVpPL09Ta2M4UHFhV25CWlIxU3ZHTjlKVlN2QUVMQmNySmJ6S0tP?=
 =?utf-8?B?aEQxTUZCMzVIRkhBQUo3UjE5MnhSY1Q4di9lcHJQYm01bzJ1VFNLNDAwVTlD?=
 =?utf-8?B?UDdZRUEzSzl0bEFkcGlLbmNwTFAxWVIySHI5UVRyajBDQ3MxYnk0UFhSS0tL?=
 =?utf-8?B?c29GdGhpMlk0dzZVTkNpQy9zRitjdGNpLy9IYW5wUTZsdlZGdjFkQ2swa1FN?=
 =?utf-8?B?ZWRSZm9DVFIwTzFYUkVUM0lnejBLNitST2RvSFRkKy85cFlNM2hXcFF6ZElj?=
 =?utf-8?B?cHpTZlBvcGlYSTFtS2g3allUSXhDTEJtYXYxbVFVaWI5RENIMEZBcExxMlJP?=
 =?utf-8?B?L3lNMnBDMjNKeHFkYW9ydlhqcy85UlNENUJJem9TdExQOVRjSVk2TmZwbjhM?=
 =?utf-8?B?VGowSDlLQ090VnM1QnA5UXpKRHhobTRaN2JaZnpaYWxpNGRuNEZ5YVYvSVNq?=
 =?utf-8?B?RmlBbTFVKzI2NG9ZV0dscEhxcngyeFgzSW5qUWNtVERxMkVUQ3VQNWwvcUhh?=
 =?utf-8?B?TE5tVTdHZkhEdHFYaURvbzBFSkw1VmVJd2dRNTl3aEM2NzZldnk4VW1aMDhR?=
 =?utf-8?B?QkYyaHJGZklhOGJUVExwdzVFRUFJY0Rub0k4dUY1Mmh6enFuNW5jelJFWVAv?=
 =?utf-8?B?VlNoMElBbmZ5OTZSYUVaeGU0bXBIZ1hpeURtaU9FMzhFRitkRmd4OVMzdDRt?=
 =?utf-8?B?SHNTcCtjZzdUd0lrWGxOS25Edm9XNFMyd3RPblJRR2RFQ0pteGNYdUQzNzIw?=
 =?utf-8?B?Q3I4QUlEeUtESGJ3MFk2VDlTenVyVHorRDNuR2g2OWJNY2xJc1M3NGtRZGlM?=
 =?utf-8?B?Q2E5SkRRZnlrZzJNSHNYNHNKbHdybUxsK3h1VkxNWjNuYlJraittK3hJcjZ2?=
 =?utf-8?B?a0N2S1VERjdqSVhaeEFFcU1KT2lEZ3Jhek1VZUNFeEd0L0JYT2xkU0RiMENl?=
 =?utf-8?B?d3ZsUDdOOFhKazNYd3NWR1lkeDhWMEtWU3hMRVYyajdSMEIwUXRmZW1WSUcw?=
 =?utf-8?B?R0FObW5rU1BCU1ZYY3VyaFBPb2RkQlJ1am9rdVovNE83M2dNTGtteW1VcFor?=
 =?utf-8?B?bVFaZlJadFhPKzdSWVhyWCtqdnhaNmxlSUZXSXc4NDdDeXVNbEZ6Q0NySDEr?=
 =?utf-8?B?M3duSFJqQ3haSE5xNHNkWUUzR2ZxUVZydEVMQWhzYnZ5MmNvNmZoOE9TOUda?=
 =?utf-8?B?ZzN6UU9wcitBMVRWMStRSkpFSnNYdVcxVXc4Y0dSV2VwRGFTVDBwZStnPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ekhoejNhVUlIR05Xb3JKMnVUWXVlRXR6clc2aE5PcVFYUnBGVDc4Z3BRRDJ0?=
 =?utf-8?B?cjM0b3dSQW1yelA5WG8zM0tMOCtQb0tYcVRId1dMOHpCWVFVWWxQb0xjS2xZ?=
 =?utf-8?B?bVhob283bnNXQjUyL1VxZWw5KzVZeXlsa2Z5ZUlqd3FERGt1TW1ORUVWWFJJ?=
 =?utf-8?B?SGxwU2hiOU5GRlNaVjNTT3ArN2MvRVNNMVZWSnJlM2NJLzZkeGFqanB3Q29p?=
 =?utf-8?B?TjV1b3dJQnZ6TzR2cmk1YWFUQ2RxaXJJS05XUFNrdk9VTDhRZ3g5bm50YjRn?=
 =?utf-8?B?QzdLOWl0SDJWbE91WURBNkxvdkYwNlpTYk9QdDNNS05Ebm5qNDB5R25VU1Vz?=
 =?utf-8?B?YU0rU3RlTnF1QjdXRjBFMDE4U1hYWGJEaktja0RsS0ZOU2xUcWlNdHkrTzBF?=
 =?utf-8?B?aEVldmM3QitSejBvcTBtbDBvKzNFMk9DKzFIR0VzcVpqai9UcWZKNmVhbEw2?=
 =?utf-8?B?Qnd0UHQrZ29vUk4xYklaSitXRE1ucEIrS2VsSTJLU2F1eHcyNVFCUFpmb1lB?=
 =?utf-8?B?eEhod0VySUIyRlBUcmRjOUFHRnBhRjN2QzVkMXN2ZVBQOTl3eUFIcmhOUU9u?=
 =?utf-8?B?MSs5RE5Uam5CN1NCV0JTR1pJbjF1aE9GL1VmU055dndUSWx3a1oxQmJySDg4?=
 =?utf-8?B?WXlpME1RMjNHY1YyKzA0dmRMVENSZFN5YXQ0Q0h1aVM3MUZxaGpEaUloRjcx?=
 =?utf-8?B?NTNyVmhCcDd5VXJBR2M0Y0EwMXBjQkl2bWJkVllvT1NMMHdHMGVBVlBKUFVh?=
 =?utf-8?B?aStTTklrVk9JeFNaVmx3ZDM4b25vMmVuTG10eThsdFA3R0Y4dys4UHBMOU5L?=
 =?utf-8?B?T2lMcU50L2VsRGg2d2U5Qmh6MUVvQmpDdmplS0dETWs3cFRrV1VGcmlaWUNM?=
 =?utf-8?B?ZlRXTkYrclgvOW1kMkVwYThGWjVGdTJCTFcraFZuQXVDUzFFTXlYYzFNWitN?=
 =?utf-8?B?Wnc4UDR5WkFVVUhpZ1dQNWdDSDJWMkpLS28xRVl4QjNIdCtSWk9xV0pDRkVP?=
 =?utf-8?B?M1NCY3JvWEVISDU2RWcvZmlTaXNOd2NjazRXYThGWGRrRmdyMk1vQzBZSmdU?=
 =?utf-8?B?WEF3U2cxM1U0MlNBbWtXb2I3L20xV005Z1Bla3hLUXFRTWNvYTlLdzN4MUww?=
 =?utf-8?B?bVBwMHlXTUFpbUhnWklJNmdiTEx3M01RWEFnclJLOWdNSjdLbDAvbjh4Q3pu?=
 =?utf-8?B?cXRaSndpY3kwa0Mvb1g5N1pNK0VLWWtnNllVUXg0aHFuQmhOT0NjR0pxTFVV?=
 =?utf-8?B?aE5LblpYT0crTThFU1FyTWJQd2NwNHBoN0xBczlCTDEvdTFDQVBjcjNSSm9D?=
 =?utf-8?B?OGo0L0FPMUdSRndaeXlVSDFRcEtWTkdpOGtIVndjODZnQTI0OFNKVnZRS1Fr?=
 =?utf-8?B?RGRJSzc1cVBmejRDNmlMUFJROFo1VGNURkt4bUUvcTMxRFcvalBVc3dzMVJm?=
 =?utf-8?B?ZEZoM08rQWpqNG5iNkhjMHNFbTVnbytyenlJam1DeFdaZVpXUkZXSkVCYmdS?=
 =?utf-8?B?TEtxelFaMU9sZ2hwL0plM3ViaU82RncxNVBob2ZvRHN6UE9aYmJycnNJVHVa?=
 =?utf-8?B?SEg2THZDTDhHSmJZVzdNVEVHVlRJc2dMeUdSUFBtRVMzQVVRMjdZNmtxdGtH?=
 =?utf-8?B?cmtuKzJZc0dmdUE3UHUrN2svWjNQVlJ4QW5vWFkzSTduMnNsV0NGaVFSYVJw?=
 =?utf-8?B?dEJqcExvYzFlclZDc2hhQ2hkTG1Zc0RmdGFxYkw5cUN5WHl5eDNlelQrRkVy?=
 =?utf-8?B?MEdxdWRsR25DMkx6MnI2a1F0WG1UZWtmS0NXQlBkc0gyZWY2U0NsL2FMRVht?=
 =?utf-8?B?NzNGTDlQaW5QVU53bG5Pb2xHWnRZV2VYQTVSajdlTnZHdmxvdWpFYmxtcUNw?=
 =?utf-8?B?TnNYWkpxRlBPazZUOGZWSUppZU9wUElXSTQ3MXlSd2drL3loRUdYWlU4djJH?=
 =?utf-8?B?V1ZVWVJNSnh4WWhpWXJJLzJKVTBrSEJrNElueFVFblloUGVwSW52MDFlaVJo?=
 =?utf-8?B?WW1qbFhpYjlHTlhwalc2K25qRFJJdWlGb1ZiVWk5MXExdTVTY3VjdnoxV0xm?=
 =?utf-8?B?cWpJQkJsVkg5VmlTSXJzODdDQ0FoazVJTEdvazNHeDNiU28xL0pCUlBlV0lI?=
 =?utf-8?B?RVNwZ3JuSGN2d3poOUJ2Tmg2VHQydjFnUzA1NnBIK0pKUmpNdUVFVHNCc1Zv?=
 =?utf-8?B?OUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <258D5063236AC448B438B53A29CD8264@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	a5vZDs45bJZp055Q2iT9ZFpjAGe+C6HV1CdIMpY/A/KmITbHfW6DmU3ZExpjjuwZqq7MyiYKBsW0+NtpI+jruWxeCmwkalXNxsRlTgbh8Pdf3U6fTgsTTkWMcinXFYRlMrVg+1CWppulNSNkF/8yabpjMufj0XPl2vs2MJ51vPU5cyf3+GzTb/R17iHLmrObSvsJU/yjAPq+LIhdA7kch2p9SRd12aYehDFOVJFJ/0NtTstIUU1Ac4Kn+ZcgpdYgmYEIz4WBF53ii3GHvEcTxxNRNr5P+wYRuCgWVCQYPIzshiUGcWyiKpdHXjgFAJjAZHAKlKt8/3PHZehPY6Yo8LmOEFNiqrCmDW7c74gfcwyfY92ebETEnzPuxzgAjVX4ypkWJMN24te0nkVjv42BdnbPCPWyi6uOZlFI6XMtVRr9ezY20HLkR3lNJt4rChqii1fdv+Yp6hmwlD1vhGALzu6s4T62/cLtf4Ft3GF8QQxI2tByctb8hlk3+RAG9C4pHxjDb604xMMM8M5/R9IQwN/13Z7edy474FR+4ce/hYxzClGlaNlD1fJgeXagr4G2LuApCaMvIM5CV7BRq+hgVv+0gHe4ncO8gArZu4tcPn+oC30HK2C1TNX0xj0Sf+apcGxVgd3HpUJC8quYv980Ug==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7f94c2c-d030-4e29-0617-08dc7a8c58b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 18:23:58.1564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VPPo4ZC1j9PYbc2d6hr8EHTWJQs4lLdBLTuSb2rwmXfroGw3PNbK5XkJ1+c/Kwq8i6EGlDFPli5ubYvHpPQ+Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6123
X-Proofpoint-ORIG-GUID: xBbBfnKgV-T9dkc3_NpAjQYmGQfooACU
X-Proofpoint-GUID: xBbBfnKgV-T9dkc3_NpAjQYmGQfooACU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-22_10,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 spamscore=0 clxscore=1015 bulkscore=0 phishscore=0 mlxlogscore=915
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 adultscore=0 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2405010000
 definitions=main-2405220127

T24gV2VkLCBNYXkgMjIsIDIwMjQsIE1pY2hhZWwgR3J6ZXNjaGlrIHdyb3RlOg0KPiBPbiBXZWQs
IE1heSAyMiwgMjAyNCBhdCAwNToxNzowMlBNICswMDAwLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+
ID4gT24gV2VkLCBNYXkgMjIsIDIwMjQsIEFsYW4gU3Rlcm4gd3JvdGU6DQo+ID4gPiBPbiBXZWQs
IE1heSAyMiwgMjAyNCBhdCAwMTo0MTo0MkFNICswMDAwLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+
ID4gPiA+IE9uIFdlZCwgTWF5IDIyLCAyMDI0LCBNaWNoYWVsIEdyemVzY2hpayB3cm90ZToNCj4g
PiA+ID4gPiBPbiBGcmksIE1heSAxNywgMjAyNCBhdCAwMTo0NDowNUFNICswMDAwLCBUaGluaCBO
Z3V5ZW4gd3JvdGU6DQo+ID4gPiA+ID4gPiBGb3IgaXNvYyBlbmRwb2ludCBJTiwgeWVzLiBJZiB0
aGUgaG9zdCByZXF1ZXN0cyBmb3IgaXNvYyBkYXRhIElOIHdoaWxlDQo+ID4gPiA+ID4gPiBubyBU
UkIgaXMgcHJlcGFyZWQsIHRoZW4gdGhlIGNvbnRyb2xsZXIgd2lsbCBhdXRvbWF0aWNhbGx5IHNl
bmQgMC1sZW5ndGgNCj4gPiA+ID4gPiA+IHBhY2tldCByZXNwb25kLg0KPiA+ID4gPiA+DQo+ID4g
PiA+ID4gUGVyZmVjdCEgVGhpcyB3aWxsIGhlbHAgYSBsb3QgYW5kIHdpbGwgbWFrZSBhY3RpdmUg
cXVldWVpbmcgb2Ygb3duDQo+ID4gPiA+ID4gemVyby1sZW5ndGggcmVxdWVzdHMgcnVuIHVubmVj
ZXNzYXJ5Lg0KPiA+ID4gPg0KPiA+ID4gPiBZZXMsIGlmIHdlIHJlbHkgb24gdGhlIGN1cnJlbnQg
c3RhcnQvc3RvcCBpc29jIHRyYW5zZmVyIHNjaGVtZSBmb3IgVVZDLA0KPiA+ID4gPiB0aGVuIHRo
aXMgd2lsbCB3b3JrLg0KPiA+ID4gDQo+ID4gPiBZb3Ugc2hvdWxkbid0IHJlbHkgb24gdGhpcyBi
ZWhhdmlvci4gIE90aGVyIGRldmljZSBjb250cm9sbGVycyBtaWdodCBub3QNCj4gPiA+IGJlaGF2
ZSB0aGlzIHdheTsgdGhleSBtaWdodCBzZW5kIG5vIHBhY2tldCBhdCBhbGwgdG8gdGhlIGhvc3Qg
KGNhdXNpbmcgYQ0KPiA+ID4gVVNCIHByb3RvY29sIGVycm9yKSBpbnN0ZWFkIG9mIHNlbmRpbmcg
YSB6ZXJvLWxlbmd0aCBwYWNrZXQuDQo+ID4gDQo+ID4gSSBhZ3JlZS4gVGhlIGR3YzMgZHJpdmVy
IGhhcyB0aGlzIHdvcmthcm91bmQgdG8gc29tZXdoYXQgd29yayB3aXRoIHRoZQ0KPiA+IFVWQy4g
VGhpcyBiZWhhdmlvciBpcyBub3Qgc29tZXRoaW5nIHRoZSBjb250cm9sbGVyIGV4cGVjdGVkLCBh
bmQgdGhpcw0KPiA+IHdvcmthcm91bmQgc2hvdWxkIG5vdCBiZSBhIGNvbW1vbiBiZWhhdmlvciBm
b3IgZGlmZmVyZW50IGZ1bmN0aW9uDQo+ID4gZHJpdmVyL3Byb3RvY29sLiBTaW5jZSB0aGlzIGJl
aGF2aW9yIHdhcyBhZGRlZCBhIGxvbmcgdGltZSBhZ28sIGl0IHdpbGwNCj4gPiByZW1haW4gdGhl
IGRlZmF1bHQgYmVoYXZpb3IgaW4gZHdjMyB0byBhdm9pZCByZWdyZXNzaW9uIHdpdGggVVZDIChh
dA0KPiA+IGxlYXN0IHVudGlsIHRoZSBVVkMgaXMgY2hhbmdlZCkuIEhvd2V2ZXIsIGl0IHdvdWxk
IGJlIG5pY2UgZm9yIFVWQyB0bw0KPiA+IG5vdCByZWx5IG9uIHRoaXMuDQo+IA0KPiBXaXRoICJ0
aGlzIiB5b3UgbWVhbiBleGFjdGx5IHRoZSBmb2xsb3dpbmcgY29tbWl0LCByaWdodD8NCj4gDQo+
IChmNWU0NmFhNCB1c2I6IGR3YzM6IGdhZGdldDogd2hlbiB0aGUgc3RhcnRlZCBsaXN0IGlzIGVt
cHR5IHN0b3AgdGhlIGFjdGl2ZSB4ZmVyKQ0KDQpJIGJlbGlldmUgdGhhdCB3YXMgdGhlIGNhc2Uu
IEhvd2V2ZXIsIHRoZXJlIHdlcmUgY2hhbmdlcyBwcmlvciB0byB0aGF0DQp0aGF0IHJlc3RhcnRz
IHRoZSBpc29jIG9uIG1pc3NlZCBpc29jLCB3aGljaCBzaG91bGRuJ3QgYmUgdGhlIGRlZmF1bHQN
CmJlaGF2aW9yLg0KDQo+IA0KPiBXaGVuIHdlIHN0YXJ0IHF1ZXN0aW9uaW5nIHRoaXMsIHRoZW4g
bGV0cyBkaWcgZGVlcGVyIGhlcmUuDQo+IA0KPiBXaXRoIHRoZSBmYXN0IGRhdGFyYXRlIG9mIGF0
IGxlYXN0IHVzYiBzdXBlcnNwZWVkIHNob3VsZG4ndCB0aGV5IG5vdCBhbGwNCj4gY29tcGxldGVs
eSB3b3JrIGFzeW5jaHJvbm91cyB3aXRoIHRoZWlyIGluIGZsaWdodCB0cmJzPw0KDQpJJ20gbm90
IHN1cmUgd2hhdCB5b3UgbWVhbiBieSBhc3luY2hyb25vdXMgaGVyZS4NCg0KPiANCj4gSW4gbXkg
dW5kZXJzdGFuZGluZyB0aGlzIHZhbGlkYXRlcyB0aGF0LCB3aXRoIGF0IGxlYXN0IHN1cGVyc3Bl
ZWQgd2UgYXJlDQo+IHVubGlrZWx5IHRvIHJlYWN0IGZhc3QgZW5vdWdoIHRvIG1haW50YWluIGEg
c3RlYWR5IGlzb2MgZGF0YWZsb3csIHNpbmNlDQo+IHRoZSBkcml2ZXIgYWJvdmUgaGFzIHRvIHJl
YWN0IHRvIGVycm9ycyBpbiB0aGUgcHJvY2Vzc2luZyBjb250ZXh0Lg0KDQpUaGUgcG9pbnQgaXMg
dGhhdCB3ZSBkb24ndCBzdG9wIHRoZSBpc29jIHRyYW5zZmVycyB1bmxlc3MgdGhlcmUncyBhDQpj
aGFuZ2UgdG8gdGhlIGludGVyZmFjZS4gVGhlIGR3YzMgZHJpdmVyIHNob3VsZCBub3QgbmVlZCB0
byBkbyBhbnl0aGluZw0KZWxzZSBleGNlcHQgcmVwb3J0aW5nIHRoZSBtaXNzZWQgcmVxdWVzdCB0
byB0aGUgZnVuY3Rpb24gZHJpdmVyLiBUaGUNCmFwcGxpY2F0aW9uL2Z1bmN0aW9uIGRyaXZlciBz
aG91bGQga2VlcCB1cCB3aXRoIHRoZSBjb250aW5vdXMgZGF0YSBiYXNlDQpvbiB0aGUgZXN0YWJs
aXNoZWQgcGVyaW9kaWMgc2VydmljZSBpbnRlcnZhbC4gVGhpcyBpcyBub3QgYnVsayB0cmFuc2Zl
ci4NCg0KPiANCj4gVGhpcyBydW5zIHRoZSBhYm92ZSBwYXRjaCAoZjVlNDZhYTQpIGEgZ2FkZ2V0
IGluZGVwZW5kZW50IHNvbHV0aW9uDQo+IHdoaWNoIGhhcyBub3RoaW5nIHRvIGRvIHdpdGggdXZj
IGluIHBhcnRpY3VsYXIgSU1ITy4NCg0KSWYgdGhhdCdzIG5vdCB0aGUgY2FzZSwgSSBzdGFuZCBj
b3JyZWN0ZWQgc2luY2UgSSB0aG91Z2h0IHlvdSBzZW50DQp0aGF0IHBhdGNoIGluIHBhcnRpY3Vs
YXIgZm9yIFVWQy4gUmVnYXJkbGVzcywgbXkgb3RoZXIgcG9pbnRzIHN0aWxsDQpzdGFuZC4NCg0K
PiANCj4gSG93IGRvIG90aGVyIGNvbnRyb2xsZXJzIGFuZCB0aGVpciBkcml2ZXJzIHdvcms/DQoN
CklmIHdlIHN0b3AgYW5kIHN0YXJ0IHRoZSB0cmFuc2ZlciBiZWNhdXNlIHRoZSBmdW5jdGlvbiBk
cml2ZXIgY2FuJ3Qga2VlcA0KdXAsIHRoZW4gdGhlIGRhdGEgd2lsbCBnbyBvdXQgaW4gdGhlIHdy
b25nIGludGVydmFsLiBUaGUgVVZDIGhvc3Qgc2VlbXMNCnRvIHdvcmsgYmFzZSBvbiB0aGUgdmlk
ZW8gZnJhbWUgcmF0aGVyIHRoYW4gYXQgdGhlIFVTQiBtaWNyb2ZyYW1lDQppbnRlcnZhbCB0aGF0
IGl0IHVzZXMuIEl0IG1heSBub3QgYmUgdGhlIGNhc2UgZm9yIG90aGVyIHByb3RvY29scy4gSWYN
Cmlzb2MgZW5kcG9pbnQgaXMgdXNlZCwgdGhlbiB3ZSBleHBlY3QgdGltZWxpbmVzcyBtYXR0ZXIu
DQoNCkJSLA0KVGhpbmgNCg0KPiANCj4gPiBTaWRlIG5vdGUsIHdoZW4gdGhlIGR3YzMgZHJpdmVy
IHJlc2NoZWR1bGVzL3N0YXJ0cyBpc29jIHRyYW5zZmVyIGFnYWluLA0KPiA+IHRoZSBmaXJzdCB0
cmFuc2ZlciB3aWxsIGJlIHNjaGVkdWxlZCBnbyBvdXQgYXQgc29tZSBmdXR1cmUgaW50ZXJ2YWwg
YW5kDQo+ID4gbm90IHRoZSBuZXh0IGltbWVkaWF0ZSBtaWNyb2ZyYW1lLiBGb3IgVVZDLCBpdCBw
cm9iYWJseSB3b24ndCBiZSBhDQo+ID4gcHJvYmxlbSBzaW5jZSBpdCBkb2Vzbid0IHNlZW0gdG8g
bmVlZCBkYXRhIGdvaW5nIG91dCBldmVyeSBpbnRlcnZhbC4NCj4gDQo+IEl0IHNob3VsZCBub3Qg
bWFrZSBhIGRpZmZlcmVuY2UuIFtUTV0NCj4gDQo+ID4gPiANCj4gPiA+IE9uIHRoZSBvdGhlciBo
YW5kLCBpdCBtYXkgbm90IG1ha2UgYW55IGRpZmZlcmVuY2UuICBUaGUgaG9zdCdzIFVWQw0KPiA+
ID4gZHJpdmVyIG1vc3QgbGlrZWx5IHdvbid0IGNhcmUgYWJvdXQgdGhlIGRpZmZlcmVuY2UgYmV0
d2VlbiBubyBwYWNrZXQgYW5kDQo+ID4gPiBhIDAtbGVuZ3RoIHBhY2tldC4gIDotKQ0KPiA+ID4g
DQo+ID4gPiBBbGFuIFN0ZXJuDQo+IA0KPiAtLSANCj4gUGVuZ3V0cm9uaXggZS5LLiAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwNCj4gU3Rl
dWVyd2FsZGVyIFN0ci4gMjEgICAgICAgICAgICAgICAgICAgICAgIHwgaHR0cDovL3d3dy5wZW5n
dXRyb25peC5kZS8gIHwNCj4gMzExMzcgSGlsZGVzaGVpbSwgR2VybWFueSAgICAgICAgICAgICAg
ICAgIHwgUGhvbmU6ICs0OS01MTIxLTIwNjkxNy0wICAgIHwNCj4gQW10c2dlcmljaHQgSGlsZGVz
aGVpbSwgSFJBIDI2ODYgICAgICAgICAgIHwgRmF4OiAgICs0OS01MTIxLTIwNjkxNy01NTU1IHwN
Cg0K

