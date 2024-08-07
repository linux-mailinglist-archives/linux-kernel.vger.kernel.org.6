Return-Path: <linux-kernel+bounces-277134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC542949D19
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 02:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DCF3B248BA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 00:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B3622301;
	Wed,  7 Aug 2024 00:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="VkmKw2xN";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="GUOZC6Gt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="kkZQ7UTC"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC60C383;
	Wed,  7 Aug 2024 00:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722991295; cv=fail; b=Tcz2MnSe27IuzrUdk8ORAvrldx2VGv5LT6B9AoSuoY0ALI9O2FIlOevxsSUEbHieW0+rWIAU8QU1RVxs6KzZ80TeiorQ+eYGqlQBWRMTNEdx0yRtF8weaiCikmbafxFnPaIRtnOlyazQqMN+EZxDjXml9RYPsqjGIrxs6B7I7Ic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722991295; c=relaxed/simple;
	bh=3sl9LPbt0d4RMbCTJ2kwGhYhUb9ltbHN8TjHnGIBPoE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ihgc+CiKUjkjp2IkAP5OC/ivG4GywPrV/EpGHAUaYe5cl4BPNKN6yq6fMFQu/ohXubkzbmZXG6tyyR7pgzpYA5i1iRVnmk8aHt8BlSLNVjdtNk9Tue1J91gpWyfe3au0Yteo4GdCrSL+HMT9zQA6dmaVJfIBUONBnz3XFAaIZyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=VkmKw2xN; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=GUOZC6Gt; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=kkZQ7UTC reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 476MJfuF005205;
	Tue, 6 Aug 2024 17:41:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=3sl9LPbt0d4RMbCTJ2kwGhYhUb9ltbHN8TjHnGIBPoE=; b=
	VkmKw2xNnHvgax5F1vYvPrHYJ4pZ1yjA8Lj3CYgNAIC01Y7HSJSOXAG7EfJ8p9LQ
	Fql10KjQVo9qVySj0YCVAz/xslfBKQhQ4xxBociqPFUbklztjEbJW1+pr27UILEP
	Y/n4PGReHVHR7DjhtUydzuh0+8gzdOqMyQrXmHYPstuzInh4EcBX/2MK85POufi+
	4suCRKqtQa9K7YmAPzHpAlWORVofCugNlwFCyjvEC77kuzVyCCtv/B57CSk7a3Fa
	fQS+Zok4luHGGV1fdvqbJQbslJgzA6UMLzyTtlWyZ2TqL0cqG49sQu8CpmI60+CM
	snwu7U7E0Ve/HU9DjgO1nQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 40uuj5rk8v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Aug 2024 17:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1722991279; bh=3sl9LPbt0d4RMbCTJ2kwGhYhUb9ltbHN8TjHnGIBPoE=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=GUOZC6GteoTldBrPUW01xhjeceeCJza/sDxQFlJ73+y7i6iTpVny++iU/EXuJNxVU
	 Mw5K+S7AWAvTIOjXbglq+9mQPtfavokyIQsStOdfTq98ly3/7h2IWjJwmZZaV8KLxb
	 Jr6NErOdARQkTZ2hpDEggEHsraB9x9b4Y+r7Wlwd/00HetpMTg0iI9Q9HTHHzF+6SQ
	 lHssIZjfScSXV28IPlC/wAcCm7OFf+EG253oJHD7OfqBth9BaBVuweCvQ4xixJdXRn
	 dkYtwDoINeE+XOoL7r9aaZVbHxmrV1FZTs63wzldyEcWQLGzLJ4dyxIMe7703Y733Q
	 B7aZH4k1N8+ug==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5CDD04035A;
	Wed,  7 Aug 2024 00:41:17 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id E2274A00B8;
	Wed,  7 Aug 2024 00:41:14 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=kkZQ7UTC;
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 804BF40582;
	Wed,  7 Aug 2024 00:41:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NJM0jx9Y87xQWIzw9BzbOuO/bELddXBndeaZyfmxTNX/jVd7qwCnpexoej2bDVm9iJS6Js3rU3uJ8HMU1uEgYwVcZAsQR/KjsyfdwCjWEfsk/ATsGyGaI7QFHIUJmY243Xcpy5kntJeiX4Kwzl2JbjXjnHWd2/gNdmijsOr3GL6Z4lqzXIec72ujh+gbbt+ZlqceFt4YP9f+zNdxghVfyKPZilRtERV7wX7OeG0qZmHwvWV2arKYnttJIur7NdXvnBLR4Fg6+Rg6fs6dB5U7NSTnwsEdsPOR3Pp1NJ0ADAQJhIqw+8IR7E0vaHb6bH6JLToA+9d6quDlJ45DEqX+SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3sl9LPbt0d4RMbCTJ2kwGhYhUb9ltbHN8TjHnGIBPoE=;
 b=dnsqkIMEofAzsWmdhMMLZBKGdmN+0q2C47qfv4dvinRlUZmxlycFdLGOukpWnaGCaZEHeznQIh4GtNvqKFIpr+PBEa0eBkxnnuoBD8jlhXnSa3j2I51coRlBSmWHIYpGLYuPpVAGGlGvfQs9b1rrZr4ZXU1ntdOlbgMKyUQR74FiXBzKvX/4zzZmcM10OWz4Dc6V6htVF5r7DHQw9zRX2OCWItgWmaKU43EI9t2FpRLQQfJArDISGLBHi0yM7T/QVKZSiBswmSgAwXRM33SSEfux/HrBfwB1NOCTLztno4Y7QI9jRb2M/Yy20uHfeaRzS1dv+vW7k9hKy6SWOekBBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3sl9LPbt0d4RMbCTJ2kwGhYhUb9ltbHN8TjHnGIBPoE=;
 b=kkZQ7UTCnaXfqgilp7UQC37M2qV7wVtr1Pt5+VKS9qoiv1MNXb8tzEBqPQ8fIiw8knyZjuXKr6B+jtt15VTSUqGzhbNSWi4VQG7H/no0wNj5lI5C39ewmTe/r0QpypYENJhokWE7zN0+8SQbI7EC2p4U1O7i7F5UjH0Yzb4InBo=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CH2PR12MB4054.namprd12.prod.outlook.com (2603:10b6:610:a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Wed, 7 Aug
 2024 00:41:10 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 00:41:10 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Frank Li <Frank.li@nxp.com>
CC: Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [PATCH 3/3] arm64: dts: layerscape: move dwc3 usb under glue
 layer node
Thread-Topic: [PATCH 3/3] arm64: dts: layerscape: move dwc3 usb under glue
 layer node
Thread-Index: AQHa0x1X0xYBDtl+cEaIElERi6I4bLHyDzAAgB16b4CAC5UegA==
Date: Wed, 7 Aug 2024 00:41:09 +0000
Message-ID: <20240807004105.pea4z7oobw7n3qy6@synopsys.com>
References: <20240710-ls-dwc-v1-0-62f8cbed31d7@nxp.com>
 <20240710-ls-dwc-v1-3-62f8cbed31d7@nxp.com>
 <20240711213846.GA3049961-robh@kernel.org>
 <ZqkLT/2myU7S4uYu@lizhi-Precision-Tower-5810>
In-Reply-To: <ZqkLT/2myU7S4uYu@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CH2PR12MB4054:EE_
x-ms-office365-filtering-correlation-id: 780f6d53-e026-49af-c0e6-08dcb679a1b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WldnV0ZvR212QzVIMVVsRkRXNGgzTnlRdXNtLzNHYnVhZWVsVzIyS1h1ZzBq?=
 =?utf-8?B?VG1tNGF1MXVUbjI3OFAweDByWTRpaXRkeGFKU01hVVd1WEJWVklSS3BsdUxy?=
 =?utf-8?B?VmwwN3BWM0ZNMHI5WGgxN1FGL2NCWFcxdzFJdlVzY2VYem1zaUpRSE5xVk9N?=
 =?utf-8?B?SjVKWGlNUUVzUTRQeDJmQXlHT3VNcXRKREQveS9wUkVVKzlSODZnMUx2K2gr?=
 =?utf-8?B?Y0dwVWZtN2pESHlyMll4cGdTeWhMV2xmN1djQ2pZM3I0S3dKSjh3OVFGUTBZ?=
 =?utf-8?B?V3N6bU4xby9HU2lHVWpSa2NBZjhxbXVQckhiRWtxWTN6TTdMS0ZUbjFBOFRV?=
 =?utf-8?B?WHIrYk1iOU83L2NwQVg4TE9UZjhXSytCT3d6QWJ6SW8rMXhPajFZSlk5V29B?=
 =?utf-8?B?Tjh2QjI5Sm90ME0wWkJGaHR6MENlU1ZMekRicEtDczFtdnhMZkF3ODRpWGlz?=
 =?utf-8?B?NTh6U1pEMUh6TWVtSkVUQ2t4K1k1b3JmWjBBWmdWbUR2dDFmdWg0VDJUWGhr?=
 =?utf-8?B?czdCZmR1VlFwL094R2xFdGsyNnBVOFg0ajN6Sm9USjEvVTcrZEtnM0UyTzNS?=
 =?utf-8?B?NE5MTGRSTklsOGlybVYrV0tSODdJKzJFQlpaV3FKMTZod0FEM0ppMjZmOGlX?=
 =?utf-8?B?Mjh3L0M4SGdVYzk3SmxQU0RiOWRZSzR2SUZWTisyUnFzYzREMW1TWVZVMUF4?=
 =?utf-8?B?cUEyWEtBbHkzMDFKMWJFQ2puN3R0ZEhlbXNhQW1TM0tGY0FmNG5rSFpFNml5?=
 =?utf-8?B?dFRjSlFGcVNDdmIzY0tMUlI1Y2F3aUUxditVMTA1MWxFemVrbXliMWtpZGRw?=
 =?utf-8?B?UEpuNUxjM015anEzN2x0NTdYcHpVM0h1dlJQZDVhWVZYWXBwTE1WMVNVcytO?=
 =?utf-8?B?RThZOHo4Tm52NktyNkxRZ0RRY3pOcVIxWVJLRUFFR0gxaXJzNXZoaDcvaElF?=
 =?utf-8?B?aWFhSUVCaXNhWWRpRU84KzVNcmtvY0RsUXBQUUtOYXRLUzhjaVVzU05Lb1dY?=
 =?utf-8?B?M1lxTUd3U3psREZLeG5mdC9kbHMxaFZnamVDdTNuL09UWHFTZGFWTGFPQ1l6?=
 =?utf-8?B?YzFJUXpFdjhZOU9sa1VhQ2hWakJMVHE3QkgvazZ4cE16OFd2S2kwaUdYVFJm?=
 =?utf-8?B?cGlVNHQxOHBWdzN5czNlaWVNSTY3R2djUWVibk0rUy9OQVV5a2hyVmFGVE1z?=
 =?utf-8?B?U0NPVmZzZ2ZEVkUvWitWVWZxRi9GTU5pZTZ3ZW9ZRVc4dlQ0bVNrVnFWaGdq?=
 =?utf-8?B?OXpCMHhRc0Q5ekU4bk5NSjFnUit2a0E3ZWVZT3VoV0lHQVFxeVFZOS8veWxJ?=
 =?utf-8?B?QkhOVDBhNW1Rcm5laExiNWViaEo5U0lzTVBueGovUSs1dkpNK0VwZlhsOE1y?=
 =?utf-8?B?clo5OUNka0Ntdy9XQTF4ZTdUaFVlVUxNYlQwaXl6WERlM1kvWkw0NlNJOGEy?=
 =?utf-8?B?RDR4Ky9BVkxqQUZ3TXBNTTVDb3lJZ213YnZQak4rTjJZRGNrd2lmSjJaczB2?=
 =?utf-8?B?TWVIWWNlSTNPNzhMeEs1bU00SDA0RzdxdFRGY0h4Z2NBcVh2S2tWKzEyNWgr?=
 =?utf-8?B?c05ZdEZTN1pKUm1SV28veXVDdUNRZTJaYndhQTRhYTdOdzFSbTJTaDNzYVo5?=
 =?utf-8?B?VWdKM0JmcFJIdU9Cd3JERmxLNEZWenVXS0o2dytsektDT3BxVTZoSGxmZ1c1?=
 =?utf-8?B?eGJDWmVvd3Y3dk42U1hjaUJ6dm1vSzVKaUM0cGhVaitDTDZTa205S09BRUQy?=
 =?utf-8?B?MDlKM1hJVkFKcE5oSENRRW5ONkdOS0hqM0I5RW9zbXMxcVZDZHNJSmY2dzVI?=
 =?utf-8?B?SFJMQm1CbWNQcjlBUlE0Zkw0aDlnd1Nhb3BtMXVTV0hVWENWY1c0eGlPd2NH?=
 =?utf-8?B?MmlQc2pjUTROMXN5YjRtcHhlM1Q4aVpRcThpWXBiWFFrZ1E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NmlDbVFEWEdSTWthY1lLMFlJMDhqZzlJZkNjaWs0Z1NlSWJNRVFTZXFHRTMv?=
 =?utf-8?B?QUZDL0RTLzdvLzIxT0Jrd3ZCZWF6T0ZVTlNrUkFoTmltQTdIQm90MUpkNExr?=
 =?utf-8?B?aThvMmZ6Y2ZwZjgxWWVBd1hGVE9mdE5RdWFsTkN0c2RmcXB4R3F6SnhLRUdm?=
 =?utf-8?B?Q3YzTE50WDlScVk0YkNQV3VzTVU5VUNNYzVqZFFQWTgvaHVXejEydFVQd09v?=
 =?utf-8?B?bEFMZ01vMW92Ry9nK1BEWHZYcllIUUJQOWxHYjU4OVJIY29PdmRXVi9KNFor?=
 =?utf-8?B?RGNrNHhYVGhlOFVKbkN0TE1IcnVaK05pVW16MTFEYjhmYS9xT2xmbmhXcDZv?=
 =?utf-8?B?R2ZzTEc5L1RZVDk5Rm9uUFMxWjUzQWUyYTFlVGg4WlA0bzNSazA4ZTVPa0xh?=
 =?utf-8?B?YkU0KzFjRy9vNTg5RG5DdkxFTHlBL0d1WHVMTTNBVFlSdFVGWEI1UGk1WHZG?=
 =?utf-8?B?bFZqVVZmeStPRmtkWFFFNkYxSUJqZUdWTU1hMjlTVGVJMEViOSsxTXFleFk5?=
 =?utf-8?B?OXMzVHZzc1QyaktMTzdLK1U3aUhsaHI2b04wMU5sc1NDY0dKbWpWaFJ6V2Jj?=
 =?utf-8?B?amY5SkhreWRaTlJRQjJndDF4S1I3eUppUUM0bWpxSXAxdlFkSjdyOVUwdHZN?=
 =?utf-8?B?bXFuVEJHSHhUTXpkZEViUVVZbUN5RjJlSllkdC95VEU4a1dQRlUzSmxYeFpx?=
 =?utf-8?B?UjJoVTB5QjZiUW56eWkyOU9QUzArVDFOU2xMOTFQMEUxUEl0WFF0N3FBa0VC?=
 =?utf-8?B?KzR5TmVlREhKWHVkb0ZxdStKR01MVUI2OXJZa1ZWd043U2RyZ0t3UGZzOVNI?=
 =?utf-8?B?MWQ2Q0dnN2VUb2pPajlwT0MwM2t2SDFzanFmK09DNFRMOENoSElqa09PdnIr?=
 =?utf-8?B?Snc2dE1vaTFXWHdwVU9lQ29BdkQvcndiV3pDa2dzL2tYTjdZTllSSkJid2JH?=
 =?utf-8?B?NUo3a0crQ0ZVcTdzYXRLNktuTG1VUEM1Unk3ZDlNL3ptc2RQbUpuTmRYRnBh?=
 =?utf-8?B?aHBFaEl6NEJUQUJaT0ROSzhBZ2kvUS94OW1CVS9ieDkzbWtWRUxxMVNSNWhH?=
 =?utf-8?B?eElJbUdSVk1xc0F4dlA0VzByY3UrOGw3NzcvRnd1UDNzWTFPaENIYzVlWlNV?=
 =?utf-8?B?SDA5ZGlYVzhVNkU2dU01S1JCZHhEbjhCSVZQRmJNaWlLQmo2MWYxVnF3Mk1O?=
 =?utf-8?B?NUozb2M5b3FXdnc3bXg2ZDU3K25OZjVCbHVBbFZGbXpBQVhabWlyQ3ZRTCtW?=
 =?utf-8?B?MkJQTSs4S1dxVmhTZ2NMTEJzWnl1d1ZzMml5NHVtYjg5K0pLTVdoT2FCd1R0?=
 =?utf-8?B?YWtBZDdoM1ZvczhkcUF6dWEvenR1bStYK1Y2K1ozSFN5M1AzamdoSEdDS3F4?=
 =?utf-8?B?cERWWVAzK0tqeitJc0NBcXRzZUVzQVF3NjhQZncxck81ajc3UnZESDUwRWJv?=
 =?utf-8?B?YWtXVU80QTVmalVKbFkvZ0R1dG1sOTJkQk50UkZzOGRGS2JYVkpheXBqTU1y?=
 =?utf-8?B?S0cyT0gwdXBHUVhOSUZYUGNGK3RoTDdxSXZRcmx1bk9UZ3hSLzVLSERXL1BZ?=
 =?utf-8?B?UURibEloVy9FZDNwSEREOGIzcjBYek8zenBqUk5iZWJBSVNOWHBZZ0V2YzY1?=
 =?utf-8?B?b29jeUtYQXRoU0s1S21QMk5UWHVIcngzZXVMSm4wV21NSkozOWtsQ1NsTjU5?=
 =?utf-8?B?amVSZ3JUcWFBSHI1Y0YyYWY2dUUwa3dXK3J5eFRBRVFpRnhiamZoczB1Ukhh?=
 =?utf-8?B?bzJ2VUZ0ZERzbkNtdWVjbXNqcGI4MXlVTGV4cDZtTVhGZDIxNE51WmJxdTMx?=
 =?utf-8?B?L2IxekRrckhJUlZSbDZva0FBVnJBd1BrK3VMeGZRWmF5d2gwbWFudUdqMmlC?=
 =?utf-8?B?Vyt4OStmbytINVRjRWtwaVpCRm1JNlJVa09XcEtvL2ZOM1VWbHlrWElnVkMw?=
 =?utf-8?B?QjlnbHZ2UGJYcFBQZWJ6L3ppV3NUUzFYK0dRYnREY1UxTCtDaUNoVWNYOTdI?=
 =?utf-8?B?K3pHRitUdk90N28wS2tOaGFhSFk1UGxMRVIySldwbisxdENHUFNBOTNTOERy?=
 =?utf-8?B?MUJ1MHJaRlowUnh4SG1ZOWZFM2lrd1RlemYrUnRmdzJHYVB3eHcrQ0I5Q1Ez?=
 =?utf-8?Q?O5bEY0FMpPen72DVBQZPfN0O+?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3B157F891DB6B48B3C63CEEF81CA34C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TG1wiXxCofANFrORfZXQZkolAek5GvXFm9dM68yyP7CpgoeNjdtbBxiQIqOAoxdrz3fkGGtFAn6wAx2tgySwalwF85CYI1C29exg0Uw86VOs7bB9iQJM8JkGYLDv6uOcZU5t7nby3Kgr1aEzN2i0/mgDhrUK/RBZNlym6+tS0vzkY6aRuzk5ONKQbeZdC6JJcoo5Cr7sExlGOyEuAy/Vk0qJqdEctFirm6ubNCjAoaMEKAm75T/q8+M24N3rcXx5axTbsMTvHukev7WRreQd5nijRZxRcWf0SwCvN+nduf+ZNOnIaaHF4mDu/wv8vlz2KO5XhPux3PxkmSqgRrU9acC95G6QRWATO1ZN9v+cDtL5Njn7o496trtfpXwhDgL9jmobp3kROqXUvdvYgDxCfoRzkZJMBbouWiZBTfGfarO305p67x5wnhhAoZu8swwfznqXwAzovEcV+JAGeBIKcHJwv4QgyMohRGhJZ6p/CEbyM/QqTCCa4H67V5p9dyBFtqY2qgUYaXjeMrbjorV3qlJVdmoCajVvsapVkKKMogBYN7WR6M9p3KMfDLX+Ghcv5tcqGDnDWTXA3B0l7r0jH0acu2OQaZEoD0KB+V2rQavETBGo3u6KzF54NqcH8YyqNchK+1WltQRt+s1Jjkuhjg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 780f6d53-e026-49af-c0e6-08dcb679a1b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2024 00:41:09.9420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n6/ubJIj+arvJJqsgaLcCVb4xOTJjEW9ZgEfwmTNDgeQZ4yqXHQHVB9dfil6vk6NiR6pfhZHwZOMzQl1aj6+8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4054
X-Proofpoint-ORIG-GUID: T_ECcE5rl8BpdqAeFTLeb8D7x6Bi635N
X-Proofpoint-GUID: T_ECcE5rl8BpdqAeFTLeb8D7x6Bi635N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_19,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxscore=0 phishscore=0 mlxlogscore=850 clxscore=1011 lowpriorityscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 adultscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408070002

SGkgRnJhbmssDQoNCk9uIFR1ZSwgSnVsIDMwLCAyMDI0LCBGcmFuayBMaSB3cm90ZToNCj4gT24g
VGh1LCBKdWwgMTEsIDIwMjQgYXQgMDM6Mzg6NDZQTSAtMDYwMCwgUm9iIEhlcnJpbmcgd3JvdGU6
DQo+ID4gT24gV2VkLCBKdWwgMTAsIDIwMjQgYXQgMDc6MDI6MjRQTSAtMDQwMCwgRnJhbmsgTGkg
d3JvdGU6DQo+ID4gPiBOZXcgdXNiIGdsdWUgbGF5ZXIgZHJpdmVyIHN1cHBvcnQgZW5hYmxlIGRt
YS1jb2hlcmVudC4gU28gcHV0IGR3YzMgdXNiIG5vZGUNCj4gPiA+IHVuZGVyIGdsdWUgbGF5ZXIg
bm9kZSBhbmQgZW5hYmxlIGRtYS1jb2hlcmVudC4NCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1i
eTogRnJhbmsgTGkgPEZyYW5rLkxpQG54cC5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICBhcmNoL2Fy
bTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4YS5kdHNpIHwgNDMgKysrKysrKysrKysr
KysrKy0tLS0tLS0tLS0NCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwg
MTcgZGVsZXRpb25zKC0pDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jv
b3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4YS5kdHNpIGIvYXJjaC9hcm02NC9ib290L2R0cy9m
cmVlc2NhbGUvZnNsLWxzMTAyOGEuZHRzaQ0KPiA+ID4gaW5kZXggNzBiODczMTAyOWM0ZS4uMjRi
OTM3MDMyNDgwZiAxMDA2NDQNCj4gPiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNj
YWxlL2ZzbC1sczEwMjhhLmR0c2kNCj4gPiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJl
ZXNjYWxlL2ZzbC1sczEwMjhhLmR0c2kNCj4gPiA+IEBAIC02MTUsMjQgKzYxNSwzMyBAQCBncGlv
MzogZ3Bpb0AyMzIwMDAwIHsNCj4gPiA+ICAJCQlsaXR0bGUtZW5kaWFuOw0KPiA+ID4gIAkJfTsN
Cj4gPiA+ICANCj4gPiA+IC0JCXVzYjA6IHVzYkAzMTAwMDAwIHsNCj4gPiA+IC0JCQljb21wYXRp
YmxlID0gImZzbCxsczEwMjhhLWR3YzMiLCAic25wcyxkd2MzIjsNCj4gPiA+IC0JCQlyZWcgPSA8
MHgwIDB4MzEwMDAwMCAweDAgMHgxMDAwMD47DQo+ID4gPiAtCQkJaW50ZXJydXB0cyA9IDxHSUNf
U1BJIDgwIElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiA+ID4gLQkJCXNucHMsZGlzX3J4ZGV0X2lu
cDNfcXVpcms7DQo+ID4gPiAtCQkJc25wcyxxdWlyay1mcmFtZS1sZW5ndGgtYWRqdXN0bWVudCA9
IDwweDIwPjsNCj4gPiA+IC0JCQlzbnBzLGluY3ItYnVyc3QtdHlwZS1hZGp1c3RtZW50ID0gPDE+
LCA8ND4sIDw4PiwgPDE2PjsNCj4gPiA+IC0JCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiA+ID4g
LQkJfTsNCj4gPiA+ICsJCXVzYiB7DQo+ID4gPiArCQkJY29tcGF0aWJsZSA9ICJmc2wsbHMxMDI4
YS1kd2MzIjsNCj4gPiA+ICsJCQkjYWRkcmVzcy1jZWxscyA9IDwyPjsNCj4gPiA+ICsJCQkjc2l6
ZS1jZWxscyA9IDwyPjsNCj4gPiA+ICsJCQlyYW5nZXM7DQo+ID4gDQo+ID4gTm8sIHRoZSBleGlz
dGluZyB3YXkgaXMgcHJlZmVycmVkIHVubGVzcyB5b3UgaGF2ZSBhY3R1YWwgZ2x1ZS93cmFwcGVy
IA0KPiA+IHJlZ2lzdGVycy4gUGx1cyB0aGlzIGJyZWFrcyBjb21wYXRpYmlsaXR5Lg0KPiANCj4g
QWN0dWFsbHksIGl0IGhhcyBnbHVlIGxheWVyLCBzdWNoIGFzIHdha2V1cCBjb250cm9sbGVyLiBS
ZW1vdGUgd2FrZXVwIGhhdmUNCj4gbm90IGltcGxlbWVudCBhdCBsYXllcnNjYXBlIHBsYXRmb3Jt
IHlldC4gQnV0IHRoaXMgcmVnaXN0ZXIgZGlzdHJpYnV0ZSB0bw0KPiBkaWZmZXJlbmNlIHBsYWNl
IHdpdGggb3RoZXIgbW9kdWxlIG1pc2MgY29udHJvbGxlciByZWdpc3RlcnMuIEl0IGlzDQo+IGRp
ZmZlcmVuY2UgZm9yIGRpZmZlcmVuY2UgY2hpcHMuIEkgY2FuIHRoaW5rIGRlZXAgaG93IHRvIGhh
bmRsZSB0aGlzLiANCj4gDQo+IGJ1dCBhbnl3YXlzLCBpdCB3aWxsIGJyZWFrIGNvbXBhdGliaWxp
dHkuIEkgaGF2ZSBub3QgZmluZCBnb29kIHdheSB0bw0KPiBrZWVwIGNvbXBhdGliaWxpdHkgYW5k
IGFkZCBnbHVlIGxheWVyLCBzdWNoIGFzIHdha2V1cCBzdXBwb3J0Lg0KPiANCj4gRnJhbmsNCj4g
DQoNCldpbGwgdGhpcyBpbXBhY3QgaG93IHRoZSByZXN0IG9mIHRoZSBzZXJpZXMgbG9vaz8gSWYg
c28sIEknbGwgd2FpdCB1bnRpbA0KeW91IHJlc29sdmUgdGhpcyBpc3N1ZSBhbmQgcmV2aWV3IHRo
ZSByZXN0Lg0KDQpCUiwNClRoaW5o

