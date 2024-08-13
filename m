Return-Path: <linux-kernel+bounces-284553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 775B7950259
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0490F1F224C8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220BA18A6C0;
	Tue, 13 Aug 2024 10:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="sYn8LYd5"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2089.outbound.protection.outlook.com [40.107.20.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0C3208AD
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 10:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723544589; cv=fail; b=QUZetJMqWyfpS/PLYORirBLqHLjzD6FmO5U5UO6kTYqNJNhSl7eNGuwfRT+dCBvvq+L4xKtuIbg4KVf/LLO4mV5vkPoA2Xjt7JmbC/0CW9K2X/UJgJtId3Mu9ToKEAEYGDwAYP6PahUQbm+2ogSkMXJbRlM4KNJBix/9yC/1p5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723544589; c=relaxed/simple;
	bh=oKTmdHL8CFBSyaXkKttFDsGjVvTdN/bUS0yr1G2z7W0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CG8QeN5HA15AyXmtXzr7NL2nfrSXxrAQP7XQADWQ+ivZ8Y871ls+d9DnjEg18CnsIYR+18v2vnv2MndWRKideuErbkASogiaQsf7/A2lLc5WyhcThUcOQcubWOGGdrAVeadoA7RN7CSjRmETviBPp7ebSoyRvmzAbCB09s0G46U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=sYn8LYd5; arc=fail smtp.client-ip=40.107.20.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DD7gYIq4Mr8c5/Jdg6hBbZjNoSqyH/+S8/kQpG3aR3nak8WPqZzFQ+DzUrMbEaceRY6tegzy+GQpVkSOeBS5Eij0OW6TzG0IcHb/iENR9kU6h7mB5x910HNRMG3Do2xgdkhPtkMW2/LqkPlDXmvbiyfe8ngtIGOIhGtBIDm2NVRzXvaL0w/ebC+PFMhhETt+X7v0jGfXH/m4ybyjavqfMEdpiRNMUyhTWB7m0NHZlk4+FbG/VjNq5YbTMsI2pKN9rnG2TuFCgIdsjm6BZRh9eP2FVzzQgraZinf+JWiBAhLcVuu6YLzr42N56Kbg4nyR6MWiS4TK64ejjVxw7s9F7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKTmdHL8CFBSyaXkKttFDsGjVvTdN/bUS0yr1G2z7W0=;
 b=lebIHbqKMvD5oVidqxdJxrDKlNTZStJh88keQ+yFSpDPlHpotUkWgz95eQ3gW6JvYaTMMJ6u6q0LOCRc/ucOwJOOOME9Ptg1irlj2ZUjcj95CpXtluTe413y2P7G01SI5fZ5O/sz/bLruI+lBkJR2gzT/GMIw1UHXXGylw4NAYsa658lj5Cm9xj/2uXTICfdHJAjSi4G1eX4bUVaZOdBiFUv47Pd7BuNM3LEQ3CY0N8JgtyI7tuwl2EkTz9+SGeAhYuaXcqAHtgzgxKZPLgh8/7v0h9tnxkXz0JGV1PdhS7ndg/vNG7rYFFXyDnZtcZ1SwqIM/ztdRWS1ev+nlM7RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKTmdHL8CFBSyaXkKttFDsGjVvTdN/bUS0yr1G2z7W0=;
 b=sYn8LYd5O9OR/97UFOuEvORgBSq/H5WYNPaaz7+25hmvapY3fcnN9NAxSSWtMJqNbLkv5y6evcSm5rVn2YTyjuA49BCuN6lvSAxJNQsvAmRUv4l8RG6avyYNm0GkNVkEokHPe5fhu5hNBDeFPKASwum4wxn1ePmH6ZkytVPFouB6p0ZGqn4pmtmwA5IQQuHeKWj98FuXkCnRomG03+FZGY9+OZvzz/gEYsmJSlrZsDMY5XeqyzkuKx5Y8i0Qhtc4EbyQX/IbKyBkEkM4XXSqfCvgkjmpgqBHWcj/GqUZluqxecNd5IrRcqHxBKqLH7wb5zGzj3TOjvw2eCeBEbmG/Q==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by AS4PR10MB7965.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4fc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Tue, 13 Aug
 2024 10:23:03 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe%4]) with mapi id 15.20.7849.019; Tue, 13 Aug 2024
 10:23:03 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "tglx@linutronix.de" <tglx@linutronix.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "qyousef@layalina.io" <qyousef@layalina.io>, "frederic@kernel.org"
	<frederic@kernel.org>, "Kiszka, Jan" <jan.kiszka@siemens.com>,
	"bigeasy@linutronix.de" <bigeasy@linutronix.de>, "anna-maria@linutronix.de"
	<anna-maria@linutronix.de>
Subject: Re: [PATCH v3 1/1] hrtimer: use and report correct timerslack values
 for realtime tasks
Thread-Topic: [PATCH v3 1/1] hrtimer: use and report correct timerslack values
 for realtime tasks
Thread-Index: AQHa7VKoeqOyQ+bwzU6A5XhOtVjzHrIk8F6AgAAKigA=
Date: Tue, 13 Aug 2024 10:23:02 +0000
Message-ID: <76cd1f3e07c6c12a7dceac31cdf7a3ca8d1e8265.camel@siemens.com>
References: <20240813072953.209119-1-felix.moessbauer@siemens.com>
	 <20240813072953.209119-2-felix.moessbauer@siemens.com>
	 <87ed6src28.ffs@tglx>
In-Reply-To: <87ed6src28.ffs@tglx>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.46.4-2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|AS4PR10MB7965:EE_
x-ms-office365-filtering-correlation-id: be0850c0-6df5-45db-ebf9-08dcbb81e9f9
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y0pMYkswWGhoU01lSi94RmVrcFdna3dUandYRVRoOTMybDdWTHkrNUhDazRG?=
 =?utf-8?B?d1B0c1I5WXFQYWsvTjZJZlRFRFBsa3owWDRYK2t0NUVEVUNIVWoxVGVnUWhW?=
 =?utf-8?B?Mi9TOUdHLzMrTWcxcEtTM21ZeTVEbnFLcE91L1lyN2hYRW9EMXZFUFRVWGUr?=
 =?utf-8?B?NHJrWGQ3WWc5K2YxeVpPWmlnZGduVXZHN2tqV25NeTFyYUxQbXY2aEdCNVVN?=
 =?utf-8?B?OUVORzhzaG9WWFpHRXhRUlpjdU1XY2d4eUZPcWVvM2Q1Y21DZXpGU2RKNVkx?=
 =?utf-8?B?ZEFZSzlQMU5xRFF4aVRQZ0N0NDR4ZW5oNnFsTkN3VTR2b0QvUk5WTU5KWWFN?=
 =?utf-8?B?V01aQ3I0RHJiRm1sc1F0aEhkNWVIVW9TS0ZiMjZVUTZqMWdRSzAwYXdrOFVB?=
 =?utf-8?B?aGU1aVdjSkl1UlVRKzdERjdBdGRnQXR5YTBKcWQ1NFNwMm5ncmhhOUlNTVZ1?=
 =?utf-8?B?VEtqTXRZYW9rWEwrcE9LZzJZN1pCSXlNR1lpeTI2TldlYm94KzB1UWZhS2lP?=
 =?utf-8?B?NVI4Wk5YcEJZVVl4MUVvTXEvb0VXNHVIQndHU1RlQ2dqMWtnQW1RaEVZWjVt?=
 =?utf-8?B?MG5IOVRQellVSU52MVJOV0FDKytYa3dLMktrc2VQQjkzSzhLOUhsb1IwNFlB?=
 =?utf-8?B?c0JpcnhzTFhLaEZiWWlmZTBnVk12ZXNqcGdIQzlGNXZvd3pQY1c1REIyQW8x?=
 =?utf-8?B?RWVkNUxKZmJ6RkdvbEJRcEJBc1M3YlN0aG5wc0JVUXJ5ZEoyNnlzY2ZrZ2Yx?=
 =?utf-8?B?ejZ0VjJyRlNmSGZUSzRTZEQ2VFpOOHZZamN4dE9hVVd2VmJYMkI0WCs4QmVT?=
 =?utf-8?B?YzlkSW1vN2J4MVF0OXNiUS9iRlRpcVJkNWx5ZUh0b1B4VmMrWXBQbXhtdUFW?=
 =?utf-8?B?dVgraDlyNWU0RGxrUE9kdTFxY3locUZGZDRJMy9WUi9KVHlKcTg0aWhtL1NY?=
 =?utf-8?B?ZHhMcWUrYlU2YXU0bk5Vdnl1L0M4eUl4dUtaL1J4V1ZuZjdvR3NYb1BCcDdp?=
 =?utf-8?B?VjdpWW5iRVR0NzV5Q2lZOW9xR0J1cE1ETTc4UEF6QlJEQm9BeXNHNG9Bc1Rx?=
 =?utf-8?B?Qlg5bmtWTStITE9YaU5adXA5ZzZPRjN6cUhVNk1IWmJNQ0hEQi9LRG05Nzdv?=
 =?utf-8?B?MngrTXRlTnhYYnpIcTFXSU9JVnVDYnM3cER3cWMvR2xJNkN1YTNqSFIxbHdZ?=
 =?utf-8?B?NlBQdnl1czI4RkIzUzhvZ1htekdiT0dGcXpDUFBXNmlJRjNlZlVESnFrekdk?=
 =?utf-8?B?emVPWlRoZ202MXUza2sybGRSRlMySllQLzhSOVNkVFc2UWdzanRzZmFOVXZW?=
 =?utf-8?B?TVdsVXR5STV4eUx4SDhMb3VhcWdLcDdjaWl1TzRHci9VRU5vWVpsM0o4aSsy?=
 =?utf-8?B?MWVwalRqQWp3SXZMMFhKYk0yV1FkT3JJdjZaQzJzUHRIU0VGcUlVWHl1OUVW?=
 =?utf-8?B?THhHQ0VsRTVPUTFIRzFCZzlBQ1BtUEdKY0FqNzJwVmd5NUtRSXlyeVZ6TnBi?=
 =?utf-8?B?a2tnK0VHdWJyUDZTbnBFTnE1ZEdFTTgrQ0E0MExqa3prUmljUld4Q2pxaG5v?=
 =?utf-8?B?czBPZ0h1VXhNbWhjbktBWmJmeTRweUVvQkNUYzl3cVp5Ym8wc1Q0NjA2VitJ?=
 =?utf-8?B?VlI1UVZqclhVYVNzNmh5UWZkbkJ5Ri9IUmg4RlZwZVpBVC9vVnRGMXFVRjRM?=
 =?utf-8?B?eTlWZHlUTnQ0ZXltQyt3RDJQczNhL0FyNnk5dXBKbjZsM2c4RGlEZTg2RkVv?=
 =?utf-8?Q?zU5F2Ld8fG85GLWa4Gz8i/IsAt+lK7GoADIu0Ho?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dDgwMDRTTTBtdjh4TkEyd0d6aTVGaWlWdW04RExZZjB0dmJ0Z2FXMEx2d2xv?=
 =?utf-8?B?ekVtNWIwTHFRSW9MVVlycjNkdG9EUnV4Qmx1MTBoTWd2THV3ajEwWURpT2lV?=
 =?utf-8?B?ekx1YituM2FDRmhQVzRtV3BkWE1PYll2TzYrakVOUUdTS1ltOGt3R2pBc0Fw?=
 =?utf-8?B?Z0p3L1NYRGlRb0JlekNEYjRJK0hwcktMMXk4NUV5eloxRURGUkxSNGhCblIv?=
 =?utf-8?B?VkFvZ1dMbm1TT0MzRmZTRVRKVWtGaE05Z2plN0dHUEM1U21BUGJsb0FXMzBJ?=
 =?utf-8?B?WlVIem1mSkRtN2xrQTk1VGVBNjk5a2FmMFNYbDFGR1JURGp2djY5eGdOdnVw?=
 =?utf-8?B?QWVEbVk0OE9QczNNQ3pRMmZrbDU4VXdQanRMa3ZMUXp4Wi80eThxMnVKVHg5?=
 =?utf-8?B?UmcydEtMZi9MeHRLVVA4SWtZMmpOeStZU0JIaTJTR3diUTc5RElDTDNuRys0?=
 =?utf-8?B?VXllU3hHQmxCaytnN1lGTHplSU1MMjJrcjYwTlhrZUxQeUhDOTA5QXZvTGo3?=
 =?utf-8?B?YmlDckJadTRDQmRQM1UxNWRmdE1HUmU5VlJHVmhZNUluOFoxUDQ3dUphaXJU?=
 =?utf-8?B?bENWMm5oOUdVQjg3UG9kaXU1YnlRSTg4MVJ1ZXptQ0kyaXlLdnZvaXRuSWsx?=
 =?utf-8?B?N3NLcHhhTGw1ZDdMcGtnM1YxQU9HMW15aE9JelhLYmRZQmNLVHhOVWNJRDJI?=
 =?utf-8?B?cDJWTmtUd3VtRURYU2s4SDU4ZFpUVG8zRVdtdlZhb2NKMFFYVk5WQlVLSFE4?=
 =?utf-8?B?UEV4WGR2UVRNdXhZWmQxcGM2dFpZOHNQUGpZdFM0djNVU1llREp3elFOdWp4?=
 =?utf-8?B?Mk55TVMvSWJ4cmI5MGo0bTZjL0V5ZW5idVBwL05aYTNnRXNRYzZQOVNPb2pZ?=
 =?utf-8?B?ZjRTd1lHY1FJWkZWL0lvY0p1YUxpQW1PK2NjeHVieGVLMEI3eVRLa2dIME5U?=
 =?utf-8?B?N1orZGo5MU1vS3c1eGc0ZXgvZTNJaUd2cVJQMmdWTkdHSDIzdElibFAvR050?=
 =?utf-8?B?NlUzT3VxeXFjeXNKOVlPa3RocHZIcmZNRWxtZU9FakNmMU9sUVFNWDJmVzVS?=
 =?utf-8?B?WDVOOVBLb2xRQzF2N05VNW9jT09GbHdtQ3VlNDFVR1pMelVCdHNUb0lzR1ps?=
 =?utf-8?B?YVVUbHB4OHhyNTM2cGpVZDJ4c3RzYWlRcmd6SHdKUy92VjRyZWFYaUtPcWlo?=
 =?utf-8?B?QlNEODZKdWJhV3dWRTBXNXVRWmFsMXRSVU9ONUs1Qy9peG9FbGtEK1l3UFh5?=
 =?utf-8?B?bmhCNkNRYWZISzVsdnJ6Y2doY3JCcXZJZ0ZVclFKN1prTW1DRUpyZzQvVURL?=
 =?utf-8?B?VWJLYStjL0NhRDFKcGZXYStOVlVKanRIUkJBbHU0Mmo3MERJOTVObUNaVzNJ?=
 =?utf-8?B?WFE3aDE4cHl2VVBtMWxOd3VoemVhL2hnNzFUUnFrdnFDdUtUajNJWnNnVUZ5?=
 =?utf-8?B?dk8xVHc3UFBvTURrSXpjdkxSbEJ4TVBvOG1ISnNXWVVQK1pMMytQeUlaR1h0?=
 =?utf-8?B?THpXYWNpSVBYVmxoNmF0YW9BaURCL3NpdE5kMnJnblZvN1lnOGZ5d1BadWFG?=
 =?utf-8?B?SVhmcnAxMXlkMHZPcGFhd3gxcmlHSnVEMEhQMFArV2RjcE96UTNjOEZid1Nv?=
 =?utf-8?B?M0tMYXhIeUV4UGdrNk5hOXZPNDVNTVlqMjYvcHUyaGVLS1hRT2xZU0ZiMm9n?=
 =?utf-8?B?K1JKOVhaS0RVd2VGQ1oxRmtvbk4vYWJoYkJKd1k3Wmo2VWpWa1ZWUVVObFR4?=
 =?utf-8?B?eEdzempZbkVROEx2cC9LS0syMzBmNnRiRldWdm9WOUs2UHo1TmI1MUlTbG81?=
 =?utf-8?B?bUl0bExicnVMYUVTcjZFVW03eWJXWjBTcUdFc29ROUlDekpHbkJMK1ZTUnlN?=
 =?utf-8?B?WlB1QnBTN3FpZzZmL2FwSXlvRGZpT016MENsSXRpSi9ha3J3MDU4Q3JvVVFv?=
 =?utf-8?B?YWE1TnNJckxRT1VkSFBia2hzN0hmNXlSZW9KZ0VMeTFvN0ZQYTlMUDBESElo?=
 =?utf-8?B?aXozdmpJazByYnNUbVAyRmRXTE5zU2QyUjJLeEpVUm9aWjNiQWRXODlYTzZ1?=
 =?utf-8?B?ejd6WVF6ZitCV1N1a0xVMXQvVzh1cWxicXNpcG1Rc2d0Ly9aeUU0VVNSck1n?=
 =?utf-8?B?WmhEVFhaeGRnNVp2eGNZNnltNThiUnJlUGttT3lqcnAxV0VNWXFwdXVCYUVl?=
 =?utf-8?Q?cfOCqkfugYLhf1O14KsAMHs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <176D4B5109DF254491411319A7308500@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: be0850c0-6df5-45db-ebf9-08dcbb81e9f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2024 10:23:03.0043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AqlIGit4Qn4IsEmUz0G9vgMYBWaUmKykWuU2Wnthab4MID6I0TGQxshz50H+EkTx9oWMmPbZetukRYjr5UkhWWMGtepxkfJteFDCRtOfdR4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB7965

T24gVHVlLCAyMDI0LTA4LTEzIGF0IDExOjQ1ICswMjAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
Cj4gT24gVHVlLCBBdWcgMTMgMjAyNCBhdCAwOToyOSwgRmVsaXggTW9lc3NiYXVlciB3cm90ZToK
PiA+IEBAIC0yNTY5LDEwICsyNTY5LDExIEBAIHN0YXRpYyBzc2l6ZV90IHRpbWVyc2xhY2tfbnNf
d3JpdGUoc3RydWN0Cj4gPiBmaWxlICpmaWxlLCBjb25zdCBjaGFyIF9fdXNlciAqYnVmLAo+ID4g
wqDCoMKgwqDCoMKgwqDCoH0KPiA+IMKgCj4gPiDCoMKgwqDCoMKgwqDCoMKgdGFza19sb2NrKHAp
Owo+ID4gLcKgwqDCoMKgwqDCoMKgaWYgKHNsYWNrX25zID09IDApCj4gPiAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgcC0+dGltZXJfc2xhY2tfbnMgPSBwLT5kZWZhdWx0X3RpbWVyX3Ns
YWNrX25zOwo+ID4gLcKgwqDCoMKgwqDCoMKgZWxzZQo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHAtPnRpbWVyX3NsYWNrX25zID0gc2xhY2tfbnM7Cj4gPiArwqDCoMKgwqDCoMKg
wqBpZiAodGFza19pc19yZWFsdGltZShwKSkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBzbGFja19ucyA9IDA7Cj4gCj4gVGhpcyBzaG91bGQgcmVzcGVjdCB0aGUgdXNlciBzdXBw
bGllZCB2YWx1ZSwgaS5lLgoKT2ssIGJ1dCB0aGVuIHdlIG5lZWQgdG8gdXBkYXRlIHRoZSBtYW4g
cGFnZSBhcyB3ZWxsIChzZWUgYmVsb3cpLgoKPiAKPiDCoMKgwqAgaWYgKCF0YXNrX2lzX3JlYWx0
aW1lKHApICYmICFzbGFja19ucykKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNsYWNrX25zID0g
cC0+ZGVmYXVsdF90aW1lcl9zbGFja19uczsKPiAKPiA+ICvCoMKgwqDCoMKgwqDCoGVsc2UgaWYg
KHNsYWNrX25zID09IDApCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc2xhY2tf
bnMgPSBwLT5kZWZhdWx0X3RpbWVyX3NsYWNrX25zOwo+ID4gK8KgwqDCoMKgwqDCoMKgcC0+dGlt
ZXJfc2xhY2tfbnMgPSBzbGFja19uczsKPiA+IMKgwqDCoMKgwqDCoMKgwqB0YXNrX3VubG9jayhw
KTsKPiA+IMKgCj4gPiDCoG91dDoKPiA+IGRpZmYgLS1naXQgYS9mcy9zZWxlY3QuYyBiL2ZzL3Nl
bGVjdC5jCj4gPiBpbmRleCA5NTE1YzNmYTFhMDMuLjE1MzEyNGVkNTBmZCAxMDA2NDQKPiA+IC0t
LSBhL2ZzL3NlbGVjdC5jCj4gPiArKysgYi9mcy9zZWxlY3QuYwo+ID4gQEAgLTc3LDE5ICs3Nywx
MyBAQCB1NjQgc2VsZWN0X2VzdGltYXRlX2FjY3VyYWN5KHN0cnVjdCB0aW1lc3BlYzY0Cj4gPiAq
dHYpCj4gPiDCoHsKPiA+IMKgwqDCoMKgwqDCoMKgwqB1NjQgcmV0Owo+ID4gwqDCoMKgwqDCoMKg
wqDCoHN0cnVjdCB0aW1lc3BlYzY0IG5vdzsKPiA+IC0KPiA+IC3CoMKgwqDCoMKgwqDCoC8qCj4g
PiAtwqDCoMKgwqDCoMKgwqAgKiBSZWFsdGltZSB0YXNrcyBnZXQgYSBzbGFjayBvZiAwIGZvciBv
YnZpb3VzIHJlYXNvbnMuCj4gPiAtwqDCoMKgwqDCoMKgwqAgKi8KPiA+IC0KPiA+IC3CoMKgwqDC
oMKgwqDCoGlmIChydF90YXNrKGN1cnJlbnQpKQo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHJldHVybiAwOwo+ID4gK8KgwqDCoMKgwqDCoMKgdTY0IHNsYWNrID0gY3VycmVudC0+
dGltZXJfc2xhY2tfbnM7Cj4gPiDCoAo+ID4gwqDCoMKgwqDCoMKgwqDCoGt0aW1lX2dldF90czY0
KCZub3cpOwo+ID4gwqDCoMKgwqDCoMKgwqDCoG5vdyA9IHRpbWVzcGVjNjRfc3ViKCp0diwgbm93
KTsKPiA+IMKgwqDCoMKgwqDCoMKgwqByZXQgPSBfX2VzdGltYXRlX2FjY3VyYWN5KCZub3cpOwo+
ID4gLcKgwqDCoMKgwqDCoMKgaWYgKHJldCA8IGN1cnJlbnQtPnRpbWVyX3NsYWNrX25zKQo+ID4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBjdXJyZW50LT50aW1lcl9zbGFj
a19uczsKPiA+ICvCoMKgwqDCoMKgwqDCoGlmIChyZXQgPCBzbGFjayB8fCBzbGFjayA9PSAwKQo+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBzbGFjazsKPiAKPiBTZXJp
b3VzbHk/IERvIGFsbCB0aGUgY2FsY3VsYXRpb25zIGZpcnN0IGFuZCB0aGVuIGRpc2NhcmQgdGhl
bSB3aGVuCj4gc2xhY2sgaXMgMD8KCk9rLCBJJ2xsIHNob3J0IGNpcmN1aXQuCgo+IAo+ID4gZGlm
ZiAtLWdpdCBhL2tlcm5lbC9zY2hlZC9zeXNjYWxscy5jIGIva2VybmVsL3NjaGVkL3N5c2NhbGxz
LmMKPiA+IGluZGV4IGFlMWI0Mjc3NWVmOS4uMTk1ZDJmMjgzNGE5IDEwMDY0NAo+ID4gLS0tIGEv
a2VybmVsL3NjaGVkL3N5c2NhbGxzLmMKPiA+ICsrKyBiL2tlcm5lbC9zY2hlZC9zeXNjYWxscy5j
Cj4gPiBAQCAtNDA2LDYgKzQwNiwxNCBAQCBzdGF0aWMgdm9pZCBfX3NldHNjaGVkdWxlcl9wYXJh
bXMoc3RydWN0Cj4gPiB0YXNrX3N0cnVjdCAqcCwKPiA+IMKgwqDCoMKgwqDCoMKgwqBlbHNlIGlm
IChmYWlyX3BvbGljeShwb2xpY3kpKQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBwLT5zdGF0aWNfcHJpbyA9IE5JQ0VfVE9fUFJJTyhhdHRyLT5zY2hlZF9uaWNlKTsKPiA+IMKg
Cj4gPiArwqDCoMKgwqDCoMKgwqAvKiBydC1wb2xpY3kgdGFza3MgZG8gbm90IGhhdmUgYSB0aW1l
cnNsYWNrICovCj4gPiArwqDCoMKgwqDCoMKgwqBpZiAodGFza19pc19yZWFsdGltZShwKSkgewo+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHAtPnRpbWVyX3NsYWNrX25zID0gMDsK
PiA+ICvCoMKgwqDCoMKgwqDCoH0gZWxzZSBpZiAocC0+dGltZXJfc2xhY2tfbnMgPT0gMCkgewo+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC8qIHdoZW4gc3dpdGNoaW5nIGJhY2sg
dG8gbm9uLXJ0IHBvbGljeSwgcmVzdG9yZQo+ID4gdGltZXJzbGFjayAqLwo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHAtPnRpbWVyX3NsYWNrX25zID0gcC0+ZGVmYXVsdF90aW1l
cl9zbGFja19uczsKPiA+ICvCoMKgwqDCoMKgwqDCoH0KPiA+ICsKPiA+IMKgwqDCoMKgwqDCoMKg
wqAvKgo+ID4gwqDCoMKgwqDCoMKgwqDCoCAqIF9fc2NoZWRfc2V0c2NoZWR1bGVyKCkgZW5zdXJl
cyBhdHRyLT5zY2hlZF9wcmlvcml0eSA9PSAwCj4gPiB3aGVuCj4gPiDCoMKgwqDCoMKgwqDCoMKg
ICogIXJ0X3BvbGljeS4gQWx3YXlzIHNldHRpbmcgdGhpcyBlbnN1cmVzIHRoYXQgdGhpbmdzIGxp
a2UKPiA+IGRpZmYgLS1naXQgYS9rZXJuZWwvc3lzLmMgYi9rZXJuZWwvc3lzLmMKPiA+IGluZGV4
IDNhMmRmMWJkOWY2NC4uZTNjNGNmZmI1MjBjIDEwMDY0NAo+ID4gLS0tIGEva2VybmVsL3N5cy5j
Cj4gPiArKysgYi9rZXJuZWwvc3lzLmMKPiA+IEBAIC0yNTU3LDYgKzI1NTcsOCBAQCBTWVNDQUxM
X0RFRklORTUocHJjdGwsIGludCwgb3B0aW9uLCB1bnNpZ25lZAo+ID4gbG9uZywgYXJnMiwgdW5z
aWduZWQgbG9uZywgYXJnMywKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGVycm9yID0gY3VycmVudC0+dGltZXJfc2xhY2tfbnM7Cj4gPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJyZWFrOwo+ID4gwqDCoMKgwqDCoMKgwqDCoGNhc2Ug
UFJfU0VUX1RJTUVSU0xBQ0s6Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYg
KHRhc2tfaXNfcmVhbHRpbWUoY3VycmVudCkpCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJyZWFrOwo+IAo+IFdoeSBhcmUgeW91IGRlY2xhcmluZyB0
aGF0IGEgUlQgdGFzayBoYXMgdG8gaGF2ZSAwIHNsYWNrIGlmIHdlIGFyZQo+IGxpZnRpbmcgdGhl
IGhhcmQgY29kZWQgc2xhY2sgemVyb2luZyBpbiB0aGUgaHJ0aW1lciBmdW5jdGlvbnM/CgpUaGlz
IGlzIHdoYXQgdGhlIG1hbnBhZ2Ugc3RhdGVzIFsxXToKCisgVGltZXIgc2xhY2sgaXMgbm90IGFw
cGxpZWQgdG8gdGhyZWFkcyB0aGF0IGFyZSBzY2hlZHVsZWQgdW5kZXIgYQorIHJlYWwtdGltZSBz
Y2hlZHVsaW5nIHBvbGljeSAoc2VlIHNjaGVkX3NldHNjaGVkdWxlcigyKSkuCgpbMV0gaHR0cHM6
Ly9tYW43Lm9yZy9saW51eC9tYW4tcGFnZXMvbWFuMi9QUl9TRVRfVElNRVJTTEFDSy4yY29uc3Qu
aHRtbAoKQmVzdCByZWdhcmRzLApGZWxpeAoKPiAKPiBUaGFua3MsCj4gCj4gwqDCoMKgwqDCoMKg
wqAgdGdseAoKLS0gClNpZW1lbnMgQUcsIFRlY2hub2xvZ3kKTGludXggRXhwZXJ0IENlbnRlcgoK
Cg==

