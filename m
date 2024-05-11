Return-Path: <linux-kernel+bounces-176355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 949118C2E54
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 03:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B0DF282FB8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 01:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF53F505;
	Sat, 11 May 2024 01:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="nzRGJMzq";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="gJL2vfSH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="rqVJi1t+"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489E7847A;
	Sat, 11 May 2024 01:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715389679; cv=fail; b=iL/684EEYA/wL3YNtA+QkgumZRJFuuEt5vgkToOsQg0LRTnB0EKeAQUQlsuiMjLQEjnRtXuvqaK1EepTJ5xCd0DyDZdUGr/QJ1JGHYcAkaBxEGgWKJ1lj2GApLEHjHPQQ55FvUoEq+xA/x/uCxwDTc1lG8SrHsHllQVTjQDDJ70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715389679; c=relaxed/simple;
	bh=OZWj3ADnIdXBRsE+LMBldyolo80flSs8RCngT8Rhx+0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Pp/QDcdUUE+2jIwIxZEBKed/boQX2NqbaG5SkUQqOWgbcWsJZX+VmftaG8iApW6SgllIPuwGV7GeXteXKI9IYmpxTDxOxFa2KUuvFfQ5QwYKkt4vpuVtTV+j4d2mYlmGoDQdUrsPRFVBJGekgcpOQ7uNeBxJoUIuwLCyLd0f2Sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=nzRGJMzq; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=gJL2vfSH; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=rqVJi1t+ reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44AKjDKj022129;
	Fri, 10 May 2024 18:07:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=OZWj3ADnIdXBRsE+LMBldyolo80flSs8RCngT8Rhx+0=; b=
	nzRGJMzqCeb13N7XhaZVLXrkWqh3MZnZiBSLEyZDrkv1mhxBy+7xqS3/z/W/iS8h
	niEgjPoO+9s7F+6kEOruiSLXARPXZIsZiym4BzDzVxHNAtUu+BCLcxoruT3+5BWT
	DnxlA82wWFlQPpRRZJNZgcf+Lo86TgOxucyBQT0nsRqQPUPgd5Tp7SPiAKcM1SyZ
	Hh/Jz72b6dL1++nH1fz0RBUmxKybFh/fk3FESIuMpdOoZrDwqk186dS+crpHCyr6
	+uRx0rZ8fyFSt5Ne2Wb52Rgsz1Bbz6L9eCj4eQdYEX/UXWBaWyJrAZnPS297oSwp
	XDRaA1/NLBbAHlqbYM5jiA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3y16xdmwbs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 18:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1715389671; bh=OZWj3ADnIdXBRsE+LMBldyolo80flSs8RCngT8Rhx+0=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=gJL2vfSHQaPiyW7m/hnVQKS81Ruh0eBWaqNa1jVDHJlNNZyEfaPlrXzSGbzLDIjJ8
	 8rxlR2nLxNnY+25OmDUu8GNelgbVoXlfPZZlR4dxA4U5YE76ZGYZmxwHCSdmuWe+/g
	 RowsVeN4EaQotVqaWYgNilu9AaD3p31ykUazr6KqyVtsL0qgxtVEhHsOGpuX2++K9V
	 HqxbUrd4koNH8YZK4BdkOd9cayPeOUqMfEAGQLPSwzHJfXFtH6ANcr09p/EWnddN4p
	 woJOUGUZRiRkCDs6d94Y10OVIcCNDLmD8xVYyP1VhYiTrQYh2/7+lbB53+viAJGCOM
	 yptV0VGQwm10A==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 975D54035E;
	Sat, 11 May 2024 01:07:51 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id DF811A0091;
	Sat, 11 May 2024 01:07:50 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=rqVJi1t+;
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 3D40D40127;
	Sat, 11 May 2024 01:07:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LLhn2/gjnOEZ7yEaJTxBwQcCoibg60ptfTIPVzkLcTr9KPnjP7gyhQ258q1OSLxc/Wf0epJmRKnC0NkVvO5Z0PErQkz3RbKpGQWUMYhzG8tseAOerksjkYUK1QmxuSYzJ+EzaHIcjBDp5ZX36OMlwXR4gb1ZzALB4LVSu47p/PgSBe+6ueti96KAzhBaUNHfAylHXgQtTx5aSMLrKIqKymwAE8hCDqNC2Y3SHa1aSn7j9qO0L9tzaqU8QJaf9BeWiqcv6pBKPzTupir5qYACLFfckBWDgxm+CHIIBg19wHdc+DTOoHbpMHoCBwJXhNAF9jSqaSy0aQVCmu8z84pQ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZWj3ADnIdXBRsE+LMBldyolo80flSs8RCngT8Rhx+0=;
 b=h9wO0LKyoomtOOSc0d+rUgBhRcQIpQ9fUougS/1tXcgplQblyOwj4wAYXmpKRSeNVyDfcLjUX1feiG64unwQLFguooQ/unIik6lttSRLoxhf6oer0w27XxT6co6RJutCxW+hTtNOj35FIzQXTM2GosGQ3lq7kiXpTjpq+SBYcl9oc7B1sdwQVW8gZ4sAtM71mJk8fQprMjfrae/goBKl3BPMwYeQOn6aNZIUW5FJjD9xxPltA9T8bIcIdwDhINg3v1en/oHqJoZDrwJgCFUcEclTl7janB8GEks/WVPs0OwZ0TpwjPwe0DJNvK32r0DzDgCeZyEQI3qRKkftI0UD1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZWj3ADnIdXBRsE+LMBldyolo80flSs8RCngT8Rhx+0=;
 b=rqVJi1t+eTSuXH776Lwt0v0b/O6J8GD9bTqTR1Ur0MvYyhhFlUbDKDsKbd8jZhfaJdhseRNKKpIRr/wk6Pl9Fu0BohWamxSHKnqrrPrcukHlBFGx0KBNgWLrEaI9s5OSq6ruDViA7gxSq6yg3E1rG4qUAHaIUuWcxCWl+7PhY4s=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.54; Sat, 11 May
 2024 01:07:42 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7827:b41a:c9d6:8e1d]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7827:b41a:c9d6:8e1d%7]) with mapi id 15.20.7544.048; Sat, 11 May 2024
 01:07:41 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] usb: dwc3: core: Fix unused variable warning in core
 driver
Thread-Topic: [PATCH v2] usb: dwc3: core: Fix unused variable warning in core
 driver
Thread-Index: AQHan4oAuvANmhigA0qoHVJuTz57XbGN+j6AgAI/cQCAAKcmgIAAX0oA
Date: Sat, 11 May 2024 01:07:41 +0000
Message-ID: <20240511010732.4o5dkela2geoyfma@synopsys.com>
References: <20240506074939.1833835-1-quic_kriskura@quicinc.com>
 <20240508230839.utioi5i2c5kozm4d@synopsys.com>
 <2024051050-pantomime-sudden-a382@gregkh>
 <0f056ece-6d38-428e-bf18-edb053c90ca7@quicinc.com>
In-Reply-To: <0f056ece-6d38-428e-bf18-edb053c90ca7@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DS0PR12MB6486:EE_
x-ms-office365-filtering-correlation-id: b0307d3a-0cdb-4c0d-b96b-08dc7156c1ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?Y2hGWndCcnlTMGM2ejdpZjFidjZuekwzV2FUWTJOVmpFa3N5TzZqaFpFUWVW?=
 =?utf-8?B?NS9Pbnh5TWFHSDVjV2RWczlyTnBzSVJzbFRRbi9hZU0xTmRTMkMyMVVSZVA3?=
 =?utf-8?B?UFJJaGVBTzdLeGJkY1ZDMXpSYURlc1BMZ1ZSc2FwQ1RyWW9obFE0aVh5RUJ2?=
 =?utf-8?B?amVEeFhSR1ArNG5kald1eXBuZ2ZCK1pydythR2NrZ1FPMGIxM0EyQTJkWk1Q?=
 =?utf-8?B?ZFRIK1pFWWxwbWFrVUkxQzdyVUl0akEvNitTRUZkOFIrWEJ5NkJ5azh4WS9R?=
 =?utf-8?B?UVkwQzkrOVh1ajF5eDEyQ1NjMzRLQ01STWgrS08xWVJ3VUlUcjVveGRXTU1W?=
 =?utf-8?B?WUdGcnZSL3h6RWI2MjlJU2Zpc3M2YWQ1KzBBVjVKMHlweWptUXRZRkV4TXhs?=
 =?utf-8?B?cWVzQ0IzZkdhWGRZWmRrMmM0emwxT0JVcUtyOU9Bc3dsSHhnOWpnNkVmS3pz?=
 =?utf-8?B?VWtKNFBzUlY2ZTdiaG9qRnRTM3J6ZUUzVmR6VEFTYUtUVnE2aVZweGxHWlJH?=
 =?utf-8?B?VE1jSVM3S1VvS3dFanJ2SkxSbXZQYWpyNUhCUjlGTm5mQldVbWMzTHpXa2Rj?=
 =?utf-8?B?UkVxcjl6a1h3V0VhWHFJV2JNQ0xoNkpOWGJoMXNaQUZVRkUwaEZaakd3QzEw?=
 =?utf-8?B?bTBaRDBWRWRNZ0NyTFA5SCsvQkRZMDJHTlFlSklIRDJGSzlMcFlYQk1aTEFJ?=
 =?utf-8?B?REs1RWo1T291dnNNa0RLWjk3MEZQNjYzRnQ3K0NNMkZIMC8wWHV1VjJnU0wv?=
 =?utf-8?B?QVlzT05ac1FaempFUy9WaGRGcTkyUUR4L2NRYzFGNXArdGlpYngweDdVNytv?=
 =?utf-8?B?TXZJcDUxOTdqaWR3WkFZWkVuMXVxMjFpV2JQbGlwZXJkQkNqeGc3NzAxelcx?=
 =?utf-8?B?RGd0MitHcE5ZcXV2U20xRXpiOTROU045SnFRZkl5aVFvWE0rOFRqUEhqRFdJ?=
 =?utf-8?B?QU9KbjhBSDNIMHlPQ2xOOStFMEdIWUtDZ3d0RGZwQ1JpZ3AwRkthejVObWpJ?=
 =?utf-8?B?M1FhY0tIeHZxM2xpRTFPNlFidnY5M3ErcjRrMTFQSERRT0xjZjF1VGwrRm0y?=
 =?utf-8?B?MzFUZmxGbmZBWHd5RXpvSlNEa29wRVhuUEF0c2JzdzRtWHN4ZG94YTVDaTM1?=
 =?utf-8?B?aVcrNWdDVTNhOVpkdm9jZzlBejFxTUFmUWRsdWMwZXZhVTlmYWpGQ0szWVNF?=
 =?utf-8?B?ZVNOb3l1OUVqTmw3Sis3NWs1REtqUy92RzZhYXI5SFE4eWZBSnU1UWZUWFhZ?=
 =?utf-8?B?Tk5MbkFwbS9HZUVwVmx1RE9GSXdvREYxZis3bjhrSEZMQVZnaU1UeWJhYnRN?=
 =?utf-8?B?bWFVcE0wcE1FRTU5Q3RFdXgyODl1cmRvUzdRSWtOaXZObHk1WW9MeWMrS0dV?=
 =?utf-8?B?cktCc3JzTGhHa2I1SFRZSG9yaFlxS3AzTndUVDhPdE5SSUZlcmdVOE94QzV2?=
 =?utf-8?B?QWpBM3RKRGVZUXhuSStoeXlvektGTlIwVFlmRjIvdXErU1grTWhxdE00Q1Ry?=
 =?utf-8?B?QlNMUm1hNkVEWE9UZmVpc1RxellhZ1RFVHc0WHpNU1RhTWZvVlRqamNISWkr?=
 =?utf-8?B?Qko4djVWQXoxWUhQd1VaMjlYUmtEOGNwaWlKaWpESjFmb2VHMEUvSWluTnE2?=
 =?utf-8?B?NkNpL0ZJSTRuOHRyd0x0WFh3UkNSVlZFTlFRZ2x3eWRaRnVVdGpjMUxHSW5X?=
 =?utf-8?B?Wjd2ZkZRa0NJWEI2V21CSTBvSFE4TWwrbjIrVmFuQmMySTZUN054S2NnPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UTJqWU9ZRE5mY0E3YUVSbFZmSmppYXYvNHFzWVJ5UEIwejByRUVCa3JCdUZr?=
 =?utf-8?B?d2hJd0Z6KzNmWkJ1UTVoWWlab2EyUXdzb215YTNJbkFRd1lLM1EwNDB2Vjky?=
 =?utf-8?B?cGN6WVpyTzREZ3VIcnlGaTZuUjd3bFJZT0gwNG1JQVNQOFBSOHNYaG5iR1o0?=
 =?utf-8?B?SW1VZWY3UEE1emUzelZycm15MlAwZjBKVUFXN0NUK2pzcENjcFVhKzQxZG0y?=
 =?utf-8?B?Tit0bXZvNytqYUZVV2syQThZa3lYNjJyZG5GUTgzRk95SVJmV1haMmR3UXow?=
 =?utf-8?B?RWY1cnVieTJ4TFpnTkREOGFxMVFQNG5PNzVtY2gwQ1JOOXVMSkxkMzRoVmdv?=
 =?utf-8?B?MHNMV3JKZlhjUDB1Z1I5OFJGbDZQUkFjN3F4T3JDeHJNV1RHcHByYXJwNXVD?=
 =?utf-8?B?eVJzQTg1ZDBRcWNKYTRFbTl2aTZvZm5JNlFIekVGanZwT1dXcXlmNDc2U0s0?=
 =?utf-8?B?SUhqbjNVWXFNT3JLN2s1M0R3ajIycy9ZSjJzejJKamdTWmZoY0hJL0FwaExu?=
 =?utf-8?B?VEYraHNkWkxyMzB2RERpTEE0T2loTFJlU0l2em8yZFRReEVvRnNRSU1ya1Vw?=
 =?utf-8?B?NjI0ZnNKQktaenp1Um81Mzd1aENTdDhlVFlOZVgyRDdjTHlaK0NhTDM4eTdk?=
 =?utf-8?B?UzA5MHBZNVJicUtyS3A5UDVYMU84MngxMlhOMW9qNm5OaGtSNlp6em5DdUlI?=
 =?utf-8?B?UjJmNlNiRWFhSW4rTnN4eE91RU16ekxsVFd1S2hzai96d21iZTN3Qk1TMDVD?=
 =?utf-8?B?dmpFeVJxK2lRVWZ6bnViTzl0UWU5NGx3VnJoSFhkTXlwMTFudzZWTjdJZWVQ?=
 =?utf-8?B?RDNLR0ZQR0RVaDhTZWhySDFHeS85YXZDdW84T0JlUFE0ZERRWFhVNkM3YjRF?=
 =?utf-8?B?TUtmUi9HM0VrcXp5QURmZ1NPWDIzSUtuWmkyTllIVVhFRm1oWUZjZmtHVnVr?=
 =?utf-8?B?UnRlb0hMN1I5dGhSeHRCNlRCZTlsNEFJZUxLWk1WUkkzTDMrNTZWa2ZaeUlQ?=
 =?utf-8?B?bEREUkRHSTkvcmZLeWhRMVhlTFBKQVZJN3F3aWJkZEtxdTNsZURrUWhDU2pK?=
 =?utf-8?B?SjB0YldCbVpzbkp6S3RJNEkxQ2l5NmV0UEU3OUxLdHV2ZlN2b0ZxM0llRmx1?=
 =?utf-8?B?Z3craDZkN1hJZnJVOElFemx5cnBwK1haWWpTNE1HUEQwQWIvOW44UGJVZm9v?=
 =?utf-8?B?N0Z6RmRkMmRqRkVFeUptZkxCRFVFam1EaWpsRGlWWU9MVHFhTjNhYXU1Und6?=
 =?utf-8?B?aS9sNGVUYWxyQnJVMXJEZlpuWkxkQ2g0VUFpTTdlM3NxSkdOcHlCQVRhbUEw?=
 =?utf-8?B?RVhudWduamVhUVpUWVE3eEQzR1F2VGtRQzllazB5QWpmVUtNNGRjY0NKZTlq?=
 =?utf-8?B?cUpOb1QzQzdZd08rN093OW9nR1BWakNKZi9sSU0vaHNRai9hVFU3OFpKeTRM?=
 =?utf-8?B?cFFQQmVWWGdyOEhHWXNQbGZsaXRJS2o0SUJpSGJsY3AwU0I4NEVtMXpxbFR0?=
 =?utf-8?B?ZURZenh6MXBYaFlzZU9QeFF5MkNYSGRJdUxBbElVZGdVak81U1l4VWRaOE43?=
 =?utf-8?B?aDAvRVh6RXNvRnUrbENqdExjTzQwZkJ5czdQTExHODY1VTNGL1VHVm52MjRr?=
 =?utf-8?B?UGVtc3RtQUZ0Z21aY0RPUmNLY2UvbFlVMmo4UGNJTStUUnBzUklJNXR3Q2dr?=
 =?utf-8?B?dDNSM2drejMxTElRQkIvWDUvNVMrWW0ySFpNM1UxVEtUd0wxd2kxMjhyU25v?=
 =?utf-8?B?Rk9nMEhtYjZWOHhaQjZDRVY0Qm4zbzBERzZWK3IxYWx3Z2NEYWk3REFCdlBD?=
 =?utf-8?B?akp6bjVmNThUUjJkaUhmQkU4bFREWUZib1lyVzBJeE9GOFhLdWFSS2tBSHFj?=
 =?utf-8?B?Y012YkJyTElRdTNWWm9VaG5GRUNBNEJHOE5IcDROdjM3OFNSbGxFZFhkMVFE?=
 =?utf-8?B?UTdIQ25xblA5MGk4WFhGRXVPY0QvWnpGZUlGb0dVNWJ4c3J4Y2Zua1pOOFNU?=
 =?utf-8?B?c1RtR2RMUlNidG1lR0NETTM2U0Vzb3NOZnZjNndiZFhHdVcyanFQcDhCV1pj?=
 =?utf-8?B?K05iRGIzNGRRaS9LY2RDNnlnSWhFNjZrUE05N1lKK2k2WFdEcWJHeTc5cHVO?=
 =?utf-8?Q?mfyHbk9V7yGFqBP9bv7+JY5tK?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C149945D7F00374BAF9AADBF3710FF93@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	08kz/o8mGiQEdoM+YV0cHtid62ONeIziCmpcyaBHSFAg7uY0oHa72M5WzMBKNBvw7qitG42qDYKrRdAgvkzPoLGIFVGuNVwIAgmoa5CoybiDrF+1oSobcG3rTUADMhgaVTk2rSi0sUTujAvueYwLxKNI9vuv/TNuu9zUII8l34YJxcRfD1gaGdn0BE5WW/Twx2gMo/9nTPj0R2sNZo2FVWcyledd6ONaYasxOy6uqXs0d8ddmoX3HopsPEJ6ywKVNYXhtnuLx2vTUf8wVcmtSuR3gOc+lTiZ+YwKpBfowSGfOxV8WCu6y10aqZjJ95D+Q1szy1nUcxDv9SJBrnZczYYIo5bdSVKxDh2KcmelJdhOoTW9Cq6uRTrv64txrxWGQJYb3jhFV0Mshd3Z24nEv14uUhr7fdabxER+xs9NWD7bhAeWEYo7mWh7UpVaHkPYAsBNSJblsrH/7eoh0XC802xuKXtwHUeB9FyQRrswsc6N7rme7nFtLefMa8Q+t1zJTe8OACjfrkn77WUFZ6Y9+TKM0OeANzKpLFeABF6JkmaDlp10ZI2DZzPQ1EKy4XLY4i8kcV2CJqnm9oNGL1dXo0qJApoK4em2xKBYNSPrPPvBrXLP7wOGcO22dwkNnm7K557dgbuR+JQVGxtAVta+Pw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0307d3a-0cdb-4c0d-b96b-08dc7156c1ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2024 01:07:41.0683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ixtnqZ3sWAAB6M+tAHjMdnJ7VeW846fcwQFZpKmJHELqmCx5c3DqIxpMkkN7DWf2OnJtLmE4zPvfSd//K1vjtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6486
X-Proofpoint-ORIG-GUID: BljZil_nwwY9p7QJO0UaX-S5_vmxH4GK
X-Proofpoint-GUID: BljZil_nwwY9p7QJO0UaX-S5_vmxH4GK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_18,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 mlxscore=0
 adultscore=0 mlxlogscore=802 spamscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405010000 definitions=main-2405110007

T24gU2F0LCBNYXkgMTEsIDIwMjQsIEtyaXNobmEgS3VyYXBhdGkgUFNTTlYgd3JvdGU6DQo+IA0K
PiANCj4gT24gNS8xMC8yMDI0IDI6NTggUE0sIEdyZWcgS3JvYWgtSGFydG1hbiB3cm90ZToNCj4g
PiBPbiBXZWQsIE1heSAwOCwgMjAyNCBhdCAxMTowODo0M1BNICswMDAwLCBUaGluaCBOZ3V5ZW4g
d3JvdGU6DQo+ID4gPiBPbiBNb24sIE1heSAwNiwgMjAyNCwgS3Jpc2huYSBLdXJhcGF0aSB3cm90
ZToNCj4gPiA+ID4gV2hpbGUgZml4aW5nIGEgbWVyZ2UgY29uZmxpY3QgaW4gbGludXgtbmV4dCwg
aHdfbW9kZSB2YXJpYWJsZQ0KPiA+ID4gPiB3YXMgbGVmdCB1bnVzZWQuIFJlbW92ZSB0aGUgdW51
c2VkIHZhcmlhYmxlIGluIGhzX3BoeV9zZXR1cCBjYWxsLg0KPiA+ID4gPiANCj4gPiA+ID4gUmVw
b3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPg0KPiA+ID4gPiBDbG9z
ZXM6IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2xvcmUua2VybmVsLm9yZy9h
bGwvMjAyNDA1MDMwNDM5LkFIOE5SME1nLWxrcEBpbnRlbC5jb20vX187ISFBNEYyUjlHX3BnIWFY
TjE0dHZrdnduTlo5TjgtRURpLVNlZWY5amdaQktsa1pSWWFzSU5SZ1RPVTJpaldiVHZGSXhrWklY
T1RoR1FRSG1YYzBGamlKUEZJMWNnZENPeUFhZkF4Qi03MFEkDQo+ID4gPiA+IFNpZ25lZC1vZmYt
Ynk6IEtyaXNobmEgS3VyYXBhdGkgPHF1aWNfa3Jpc2t1cmFAcXVpY2luYy5jb20+DQo+ID4gPiA+
IC0tLQ0KPiA+ID4gPiBDaGFuZ2VzIGluIHYyOg0KPiA+ID4gPiBBZGRlZCByZXBvcnRlZCBieSBh
bmQgY2xvc2VzIHRhZ3MuDQo+ID4gPiA+IA0KPiA+ID4gPiAgIGRyaXZlcnMvdXNiL2R3YzMvY29y
ZS5jIHwgMyAtLS0NCj4gPiA+ID4gICAxIGZpbGUgY2hhbmdlZCwgMyBkZWxldGlvbnMoLSkNCj4g
PiA+ID4gDQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyBiL2Ry
aXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ID4gPiA+IGluZGV4IDhiNmY3NzY5ZmNkNS4uN2YxNzZi
YTI1MzU0IDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiA+
ID4gPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiA+ID4gPiBAQCAtNjc2LDExICs2
NzYsOCBAQCBzdGF0aWMgaW50IGR3YzNfc3NfcGh5X3NldHVwKHN0cnVjdCBkd2MzICpkd2MsIGlu
dCBpbmRleCkNCj4gPiA+ID4gICBzdGF0aWMgaW50IGR3YzNfaHNfcGh5X3NldHVwKHN0cnVjdCBk
d2MzICpkd2MsIGludCBpbmRleCkNCj4gPiA+ID4gICB7DQo+ID4gPiA+IC0JdW5zaWduZWQgaW50
IGh3X21vZGU7DQo+ID4gPiA+ICAgCXUzMiByZWc7DQo+ID4gPiA+IC0JaHdfbW9kZSA9IERXQzNf
R0hXUEFSQU1TMF9NT0RFKGR3Yy0+aHdwYXJhbXMuaHdwYXJhbXMwKTsNCj4gPiA+ID4gLQ0KPiA+
ID4gPiAgIAlyZWcgPSBkd2MzX3JlYWRsKGR3Yy0+cmVncywgRFdDM19HVVNCMlBIWUNGRyhpbmRl
eCkpOw0KPiA+ID4gPiAgIAkvKiBTZWxlY3QgdGhlIEhTIFBIWSBpbnRlcmZhY2UgKi8NCj4gPiA+
ID4gLS0gDQo+ID4gPiA+IDIuMzQuMQ0KPiA+ID4gPiANCj4gPiA+IA0KPiA+ID4gTG9va3MgbGlr
ZSBteSByZXNwb25zZSByZXBvcnRpbmcgdGhlIG1lcmdlIGlzc3VlIHRvIFN0ZXBoZW4gZmVsbCB0
aHJvdWdoDQo+ID4gPiB0aGUgY3JhY2tzLg0KPiA+ID4gDQo+ID4gPiBUaGFua3MgZm9yIHRoZSBw
YXRjaC4NCj4gPiA+IA0KPiA+ID4gQWNrZWQtYnk6IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVu
QHN5bm9wc3lzLmNvbT4NCj4gPiANCj4gPiBJIHRoaW5rIEkgYWxyZWFkeSBmaXhlZCB0aGlzIHVw
IHdoZW4gSSBkaWQgdGhlIG1lcmdlIGEgZmV3IGhvdXJzIGFnbywgaWYNCj4gPiBub3QsIHBsZWFz
ZSBsZXQgbWUga25vdy4NCj4gPiANCj4gDQo+IEhpIEdyZWcsDQo+IA0KPiAgSSBqdXN0IGNoZWNr
ZWQgdXNiLW5leHQgYW5kIGxpbnV4LW5leHQuIFRoZSB1bnVzZWQgdmFyaWFibGUgaXMgc3RpbGwg
dGhlcmUuDQo+IENhbiB5b3UgcGljayB0aGlzIGNoYW5nZSB1cC4NCj4gDQoNCkp1c3Qgd2FudCB0
byBub3RlIHRoYXQgdGhpcyBuZXcgbWVyZ2UgY29uZmxpY3QgaXMgZGlmZmVyZW50IHRoYW4gdGhl
DQpwcmV2aW91cyB0aGF0IHRoZSBuZXcgZml4IGRvZXNuJ3QgaXRlcmF0ZSB0aHJvdWdoIEdVU0Iz
UElQRUNUTFtuXSBhbmQNCkdVU0IyUEhZQ0ZHW25dIGJhc2Ugb24gdGhlIG51bWJlciBvZiBwb3J0
cyBpbiBkd2MzX2VuYWJsZV9zdXNwaHkoKS4NCg0KSSBkb24ndCB0aGluayB0aGlzIHdpbGwgYWZm
ZWN0IG11bHRpLXBvcnQgY29uZmlndXJhdGlvbnMuIEJ1dCBmb3INCmNvbnNpc3RlbmN5LCB3ZSBj
YW4gaXRlcmF0ZSBhbmQgYXBwbHkgdGhlIGNoYW5nZSBmb3IgYWxsIHBvcnRzLg0KSSBjYW4gc3Vi
bWl0IGEgcGF0Y2ggbGF0ZXIuDQoNClRoYW5rcywNClRoaW5o

