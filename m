Return-Path: <linux-kernel+bounces-331187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4896597A970
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 01:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69F051C26ECE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 23:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7367415358F;
	Mon, 16 Sep 2024 23:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ScDF9cjR";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="kEsRrIKq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="HVhWSYZ1"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2F2200A3;
	Mon, 16 Sep 2024 23:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726527664; cv=fail; b=fXp1oLD90g1ZDlz4ojXDYvFh4EjUxvix2h6cXgnAbQjvSDwLZFTcEpv217ZzVCurrbl55bgglUqF7u8xWDK83ms7z8J44GOMB2tvlaXJd6W7QPTtJLfi45U0bMwFsZaXZXvUVwNEFLHQvhKocUF7l7MyKGv4XajL3FwQXhfaELM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726527664; c=relaxed/simple;
	bh=HN+YGGt54Ticx3YAqV0UInxeX2Nm+sl0RpCklXPA7x0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AevXhYZaubKBOEdFEKLQ4B7K9nTnlF9MiLHXRdQ75YeeW5QAzv3/fppttWxNDUlHOXEqPmSJEQy6krBwqYuVmJfltd6dJUn4JqfOTQoRsCMhus3q36/4ofZlKgFRk4OoH7fDtVOwNmZxWhsXv7TOjB6KB5DBeccnWByrBUr9i0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ScDF9cjR; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=kEsRrIKq; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=HVhWSYZ1 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48GKPiqm021131;
	Mon, 16 Sep 2024 16:00:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=HN+YGGt54Ticx3YAqV0UInxeX2Nm+sl0RpCklXPA7x0=; b=
	ScDF9cjRAoSk8xdDilhLcIgYPxdspOgT4YUeOhv5f/8LGeosNgNbOlcXSKVPnfnq
	4JPQQ4RnJiExOmoSSJZmtenm3QeFz+JpKve/Wg6od0sB9yAe+xaW2nje/+q/K5Zg
	YU5TP5LrYhIfPxFpYZj19xZopky2TE6zljxUTcagUVzD7jnT/ukolSDVGduYLKmS
	TGNQm3aYbYU1Xqi34pBg37IsSFsA1DE9GJtvAT691GM2Szm3PyVFOAqCVV+PnTwS
	0/ZMD/xkfeqAd8M0bqAZ9PXgDNM9CYOnZNQQ5nqA0XqV3zahJsFmB6y3MIF2SLsw
	Vn+bCCjFQL5BV72cSmFvpw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 41n9dv0qad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Sep 2024 16:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1726527639; bh=HN+YGGt54Ticx3YAqV0UInxeX2Nm+sl0RpCklXPA7x0=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=kEsRrIKqe9VAAJTaw/uXu53/10zxQnU9352+uuD9mCJ4eMbtZi83uACRaNYtW30ww
	 kTWaw6pXCTUD+uBmcwpoe9Pr2hTEsFLtiJdFxcwzsMLlnIRzwh5elYyJLKw9Add1jY
	 c2+3A/TET/bzyDzGiwEfVhNSIUOWVVN0FOOQgbqGqWbPKut9drn0CF9OVlHyh0F+21
	 tyb7sfQjycIwwIBMhWEL8ynjhe2swYeion7k6Mv0p8UxtPeTOyKTIf1rLihuC0/Vj5
	 P0btxFPUGbAKS7YbYFdPBRPPDNJwavu2vc/CMcVf0R1rHV3S11lSvneC5VYGpX4B3w
	 W6N9VxEM2sryw==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C666D40147;
	Mon, 16 Sep 2024 23:00:38 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 6E069A00B2;
	Mon, 16 Sep 2024 23:00:37 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=HVhWSYZ1;
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id B9CC54044C;
	Mon, 16 Sep 2024 23:00:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WEi6AF7PIGevwKmTJbvDk8esaHcLgL5i/Rid/jU8xSXPgnmoqsZnJocgWzz74VzWRyRCLononIsyUdAlsN3rpIhg718Vys+i+TguNcHT3ZWa12kZxiAD1MAlw6rj/xwkqqOydeNo44uKkVN/P11lFkPuAsSsIlFDvS6C2VV7e4hTfn4Z4BbEJyIxjTHSKil//wNUfYRsrKKtxsroOU9PCLZITPqHBqWLvjJ0jFvburD9NmnEQowUtQU9DHSav9HQvhLWICeeP5EPZyb+emUJi0WBhvA3cu6E2ywgmOOpKru5vBTSBpidh8dzr3UKkzmbWtFMq0Cu8yqc3fw4WkqiPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HN+YGGt54Ticx3YAqV0UInxeX2Nm+sl0RpCklXPA7x0=;
 b=bmHNHg5MUf2XjKJcxERzw8RSKLkX4lizqpjBK70PSOt+I2fWA2jmOsRiyxZXFI3Y62TnHXpDTPBczqjKFmR69m57SDck9iozSVC/OV+WHg8gUmYoZnmPLbqzyKPhko0GLlas4hfTiLKzMg9M0ZlhwEtuXaOIpvWhawft1QOZvoKw+Sbf94OonKRzLGSm6vdbJcv56N77Kl+z+kiOUx0m4g3nPUZQLNvDmdYkGysOT8b89hF87OVJ5BQZ34aSXYrN7S5kdS4fjAX/4lIIohN88I383aRpKyvbymVgq6pHL+YYvFUMCBHxQNBbT3GsiFzucul9ZtscJyjkMJSNzKXa7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HN+YGGt54Ticx3YAqV0UInxeX2Nm+sl0RpCklXPA7x0=;
 b=HVhWSYZ1laDGqQNuPCtimq2SCqdG9tFedsThziYj2welBOAU+VVasMcmCDA58zGXl/UiwQX8hZKTRbOcunNXRriuU7Izm/K5Loy7obviPTdx+jCX5O42NWL/6xlu19ImG1bgfhAa0OAWlZbiJXkitmV/bNkmmoaJsZYfozwf4i0=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by PH8PR12MB7301.namprd12.prod.outlook.com (2603:10b6:510:222::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.22; Mon, 16 Sep
 2024 23:00:30 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 23:00:30 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Selvarasu Ganesan <selvarasu.g@samsung.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jh0801.jung@samsung.com" <jh0801.jung@samsung.com>,
        "dh10.jung@samsung.com" <dh10.jung@samsung.com>,
        "naushad@samsung.com" <naushad@samsung.com>,
        "akash.m5@samsung.com" <akash.m5@samsung.com>,
        "rc93.raju@samsung.com" <rc93.raju@samsung.com>,
        "taehyun.cho@samsung.com" <taehyun.cho@samsung.com>,
        "hongpooh.kim@samsung.com" <hongpooh.kim@samsung.com>,
        "eomji.oh@samsung.com" <eomji.oh@samsung.com>,
        "shijie.cai@samsung.com" <shijie.cai@samsung.com>,
        stable <stable@kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: core: Stop processing of pending events if
 controller is halted
Thread-Topic: [PATCH v2] usb: dwc3: core: Stop processing of pending events if
 controller is halted
Thread-Index: AQHbCIpOIl8f+8LK4EmR75pMhvNsxrJbB2EA
Date: Mon, 16 Sep 2024 23:00:30 +0000
Message-ID: <20240916230032.ugw23x7gijamrf5x@synopsys.com>
References:
 <CGME20240916224630epcas5p42b355e2884c665e19d3c9c3a5afd428e@epcas5p4.samsung.com>
 <20240916224543.187-1-selvarasu.g@samsung.com>
In-Reply-To: <20240916224543.187-1-selvarasu.g@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|PH8PR12MB7301:EE_
x-ms-office365-filtering-correlation-id: 2ebe38f1-a1ad-4e01-ed90-08dcd6a35cd8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y2c3eHpZNEpJdjBLdXpaQTVvWm9MZ21UVmo2ZS9aTW5mV2gzYW5GektYSzVr?=
 =?utf-8?B?R1o2bXMrQjV6eXdlZVlwVTFtazdMYldFc25aTWh0aS9qNjJZaVJvVGJ4OGgv?=
 =?utf-8?B?RzkyVTVjMHo0ZEdxR2Rma3luM3ArRFVoMXFGUFlkbTlvRnhTT3lGU3ZKOTVV?=
 =?utf-8?B?WDN5Tno4V2VKSm13M0IvTXRPYUdaL1VYMldJc3J1TnZBOXRvM3oxZlZpQXlW?=
 =?utf-8?B?bTk2K29qYWtKbHFSUnFQOFhnK3dlWFZBdzUwTUNyeE9kd2RRY1JkTGFibS9p?=
 =?utf-8?B?a0I3Z0ZFblpzZ21jZUI4T0xFYllscnFmQzVxUTdkaExwR045V3FzaFpLY2c3?=
 =?utf-8?B?K1Fqdzc5VEhoUjJ3R29NMmV6Y0pjRERJaUR3RU5HbW4rVktJeUxtbmlGWU5J?=
 =?utf-8?B?dzZoY1J1N2FmS0UrOGJVdnp0ODhHclJFQjFEUk51SzBBTkFqK0pCdEozK1Nm?=
 =?utf-8?B?NzBrWmd5VmFUQXRDemhaVFVRU29kbnpyWmNmOHREczBxQlFiRHpxb25SNmdK?=
 =?utf-8?B?cG1uWmREbEE0cjB3em5QbktDNC85c0JGTEhNcXd6WCtwN0tqUVdDZTUwYm0w?=
 =?utf-8?B?NjlVanJ3NGJaSnVuYnNFeFdzZmRteHVaMlZvL3VEaTNMWnMwMEsrekdrejQy?=
 =?utf-8?B?bzBleStReCtQRGZCY3pFN1VrK1BzMVUwSGRBTWN4RTVya1FLY1pFdmpWT00r?=
 =?utf-8?B?NnJ3NGpTQ3FDbTJxUzBQRGc3aVU4VmZoWDl3Z21VWGlKYVNWUGRwdjkya29J?=
 =?utf-8?B?N2QyVEhJeHVDdTlFRHdWUXpDT1NWdFRIV0Z0V3ROTWhyT2R3VGM4dVVLQmJK?=
 =?utf-8?B?VHZFQkVpbmlqQ1l0QjQ0VGE3ak5idHRNR1dneEl4L0FJaE1LRXlxbFhwS0FC?=
 =?utf-8?B?Z25UcW93bHkzRjZZVEFzRTY2aENFekQ0czZPNzZOazdpQXFTZklnejVvTGxT?=
 =?utf-8?B?cmIxN1l1MkU0RUpRaGt0YjZIMVZWWUVORldqdFB1K1NMQ3M5RlhJKzg0K0ZD?=
 =?utf-8?B?N3pnR0hHbUJjcTljMko0UnVCeVJEQytrMWh1UU00TmlsVFh0QWorMGNZcHJE?=
 =?utf-8?B?ZGFzcFpZWjNNQWwwMXM1RGt0cC9CdU1OaTFRSGhjK0pFTGZCeFF3cW5hMk8r?=
 =?utf-8?B?YXZuYWhGd1dLTEl4MGRWTml4QkZyTTdyNU5OdHFGMk00L0twTEtjTStmMlNE?=
 =?utf-8?B?TlFhTWNGODdNYXVoaWVOckdFZGlhbzlQZGx5bHQrUjJRK0ozU05kTmFiSy9K?=
 =?utf-8?B?VTM1cGJhR291MHJTYnIxZlNPRWpvcVQwVTF0TFZES1p1VkhnR3lPMyswd0g4?=
 =?utf-8?B?UGZtKzE5Sm1UeTVhRUQzNE5jeU1JakxzcEZxM00vWm9DVFo4a1AxY0dxM3BP?=
 =?utf-8?B?QW5TWW5CQmZwbHJWOTJiUkdET3ZpUmJTanpyLzBSbGxJR1AyY3JUZ1E1Zm13?=
 =?utf-8?B?YytUQTdXUEgya3ZwakgzSmNYYmFFSGVPS24rYnhnMUJuRWN5RFB4TjNlbS9h?=
 =?utf-8?B?QWdmeFZoR2VYRE90MkUxUzh0NjJBcVdDaUx0ZTJFMFNtRVpCU1NHMXExbGta?=
 =?utf-8?B?ZkxRNFBVaXFFRlg3RDJwUDNvSDhqMTAyQnhMVVNVNERXVG5aVmpTRUlWOTFw?=
 =?utf-8?B?RDZSMEhRN1JJNlUxSFlTOTRwMHZLR0ZlbjBtKzBkRlhJc0xsSnJrcnZBY243?=
 =?utf-8?B?U21ZUXlVVVNWdks0bWdDQys2a21Hd2h6NTZNc2NoL3hQZEg1L09kbUQ4SmpW?=
 =?utf-8?B?NGYycWNkNkVnclZYbDRmcGpRemcwRGN6YjRCdVZuc2ZBZDFwWFFXdnhSdDJa?=
 =?utf-8?B?MmlMYXRJdjRpaVAreXRycExsNWNtQi9iZG5lZHhsYlJ3aXdYaWl0RG5NakxK?=
 =?utf-8?B?VUxxSy8xMjF4aTg4OWQzcVFKNGRsMENZNzNtcHZJRzFoZEE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d0R0VmdycE83MytaVkFyQ3BBQjF1WmFpMzFzM2RSb2cwWXVEa2htQitmMTMw?=
 =?utf-8?B?NnJXZDg3cDdCVm00Tm9UWUM5ZGs3TFFJUk96VFA2VDRkUlZ5cmFBVmpVaGdk?=
 =?utf-8?B?K1pUK3A4cmhwWUQwZ1NkLzM0VEd4UERod2ZEN3NHQnBYbVRDZngvZ1oxTUhp?=
 =?utf-8?B?clpPS09kRGNHZjlxckpoL0NOL0g2SkVTYWJoc0V0bnZ2a2RsSTU1bE5aRjBE?=
 =?utf-8?B?OXBkZ0pzaUhSdlRQa0JObDJ4TnN1RG53d0xiUUpjbGlXcEZHZ2JrUmJLVlFq?=
 =?utf-8?B?NDdPYStoVVNJREk2eFovc08zZWJLU21oa3NVOXhLNjhvK0ZpT3czdkxDcTdU?=
 =?utf-8?B?T20vREMwamVLWG9zRjlHK0pGTm1vcy9qNU1LYTRuZTUrRTJvdTAvbkZKRTJV?=
 =?utf-8?B?L3BrQXZkMjV4eWVVQ1RZQXV4VnpoNHdnbzdseWVlR3NVaEdNUWtwVDhiaW4z?=
 =?utf-8?B?dFlZWElvMTdISXJiRG9wQzFZTjdSN292UTM3S20wUkxSaUFRcU9FV0dWWVVG?=
 =?utf-8?B?SmNNWW51cnRLb0ptQ3RXSGNUbWpDRUNLcUd2azU3MTFmd01BOWFkUyt1aVVF?=
 =?utf-8?B?MmRKbzFQUmRTVzRFdUxsTUlCK1RqMytYc2gzbTN2d0RHODVJSHBueGttWUlB?=
 =?utf-8?B?dE1OZHNpVTN0bzlaVGNaRTdrMElneVZYNWdoQ1JwNnVudHgvNXcybW9EWUtj?=
 =?utf-8?B?OGRnVkNMcWNGVjlGWVNxeUR4UzREQWZUUmVXeFlqQmIxYmh6OWtaQW1jNjVi?=
 =?utf-8?B?YzltNjFGdmlnTHlNV3F0aXliQWllSVZQVHEwUnVhOExhYjlOMGlXRGUyU0lM?=
 =?utf-8?B?QjVqRGZmZ3BDZ1ovSmRlckxiUGpsWmxaR3pFQjZCMURpb2tHdUsrcXg5V2FH?=
 =?utf-8?B?N1RuUUUzdXBMMEU5VWV3bmxzL2JrWjh1cWd5YkM4R0RGT3pVSmphbHFlQXZW?=
 =?utf-8?B?VWloQllNa3N4UVNmRk5QTTdhL0NnaEZHU01yVGdDcGRRWm54Mk1vWVpCR0J6?=
 =?utf-8?B?WWJUcGY1YTRBQWQ1RlE5UlZRMzRHWjhGWXl0ZGxzZldWdDl2U2FmNW5XTGVE?=
 =?utf-8?B?VGlBZ0xtUjhYUFVrNFJ4ZnkvNnJxd09ZY2luZ0tJYzZRSlFLbjJaSDdDUE9P?=
 =?utf-8?B?dnJRNktoTkNHR3hqc2h4K3gySTR6WGpyQ0RHWjBVSUhhSWpNb0NpT1FEZ09C?=
 =?utf-8?B?NUpYSTFDSzNjRjVPakVaUHRTOGJaT0hpeG1PdlpmbHZIYVRlTmZqd1BKcW5y?=
 =?utf-8?B?VWJiMDNTNWpjRktEa2sxeXc2MXZDUnBES2VNTFN0TGpxRWYxdFg1dnRNb0Fh?=
 =?utf-8?B?d2svOFFXb3Z3VW52UktnOFUrendNV3pTMk5DTkFzVllhMGNpQmVMTmtkUXJh?=
 =?utf-8?B?NndhTU1KUUk3bkFLdnhPRGtzV1pncDY2Sld5elMrdDVCeERtL2poMW5TQmlF?=
 =?utf-8?B?eE9jcDdzUkdCVWpZc0FNTy91SjBJZ1hEdGlXVjhjWjNOVDAvUHB4MEtiQnZx?=
 =?utf-8?B?ZmdTamRzRTI4d25WZm1qcExKdXQxUXR4TXM3ZExqdTlYYmxnSkUrWmkxWHpF?=
 =?utf-8?B?Z0hsYVFNamVtcTFMampwUTM1bEptN2s2YlRVaFJuZXAzaisvTWQ2aUtsWFRl?=
 =?utf-8?B?SnFOajNIdC9jOHZlTldRSHlZNFNqT2l1Q2NHakpqNWZJZ3dwUEtWeXdDb1Fs?=
 =?utf-8?B?ZjA1b2pGaWhwZlo2OW4rL2Nmbi91WXBkUXNnMVRPdDVmYmJJTnBXaUNrUTZq?=
 =?utf-8?B?QStJc2JCOGJncFQ5c0Z0K2ppVnBUaTQyRGJBeEhSYTFuUCtqRitnUTFWYmsz?=
 =?utf-8?B?aURPNUVhWWh5R0lIYU9sazFzelp3b0YrTXRycTBZUFJaWDdCTDNOeDNOeURl?=
 =?utf-8?B?R24vOFltY0M4UjVPVVJ5ZkEveW5WQTUxTkFOL2xNZk9IVHVJYVAyTDlGTXlu?=
 =?utf-8?B?ZDdBS0R0WnlEMFlrR2p2bDVTOUlCZHpINTUxMlhKSnp6UXVDUHMxd0RrVnhr?=
 =?utf-8?B?OW8wQVgzcElyYjh4dGxOdkNkUVUyQU1UNG9FQTRhQ2tvREg5VXF4bmpuazFC?=
 =?utf-8?B?RVhUdEl1NTBtTXZOUWRaaTQ1MGZHeG1mdmtPWTVaQnF0aFlYUFpFOXRqb2Ro?=
 =?utf-8?Q?oK40SKZMfurjrX/Jkd/ZNxhTn?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E973ABD8BBC2F42B29176C43C9017FF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TE1oug9oqIrW36dR8cyC53heFp0kZc4k32nRU6LtwyLIPv2hQ8YeEpEZZRExlpc2alp6hyhUR8ptpW4MzgesGvxxVmz0HtgB9y6ze8IQ7bkcLHwZ8ztgKao6Gy8ZohSzSoYLAXQDIuTNM3h/jVWC6ShaS+5ijIu5zsXmNewXYJABSq/5/NAtYzPjV3Y8kLGKa1fOKVKk7s4IS24L30RYatDYk5xGIEMGWG5ww6/qxGYhwRPhSW3tcFh8GTIAxI1/ngFVzjwODtm2I389S6XJId0J6J259GdtuRRNRzq0zcAnGOweTZ4nrhnA246ydQx27y/TcHlr6mcAuGVN/vl8kskEwxEjEvX6bJnpOKI9IxRHNwuYUahMJk0qrj4gZc+mBDihRTqSmUqnMPr1q/ZwoEY8OPkU9shLdkja6DB71w/ycftKszY8giJLms/Bbw66B6u5BQUA/NWfYoTIkAASAoVPT+zrroBbvhlE3AxvlAN/64zk3+9ahIZK9DkjAiKts2KDWenfpcocTNCkhQPx2Oxa9jGlss932IA6PTCPmeVHaiT/dYzB81/IY4vCN/Ssrs/1ku/l7mjuajB1mzoin7Zj9TQYuIytEphjEnOAwwV+uHDSyAmUwU+T2cN+P39XMflV6U1SPRkqt8NlJpUVyQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ebe38f1-a1ad-4e01-ed90-08dcd6a35cd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2024 23:00:30.5213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r4ihHG/ROMrJYgKAJHyoa01sI4Ifa4SVmiknPp7QGZhZdddCr+/uHMkBU1ViE5IlVfZB2wnvjOAhwGwwb2Gitg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7301
X-Proofpoint-GUID: pEwcGLtECuGOrxAqrtzFpm4F-bl776gg
X-Authority-Analysis: v=2.4 cv=C+C7yhP+ c=1 sm=1 tr=0 ts=66e8b898 cx=c_pps a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=nEwiWwFL_bsA:10
 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=hD80L64hAAAA:8 a=jIQo8A4GAAAA:8 a=GgylOg7RiQb9Goj7vAoA:9 a=QEXdDO2ut3YA:10 a=Lf5xNeLK5dgiOs8hzIjU:22
X-Proofpoint-ORIG-GUID: pEwcGLtECuGOrxAqrtzFpm4F-bl776gg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 clxscore=1011 malwarescore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 phishscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409160156

T24gVHVlLCBTZXAgMTcsIDIwMjQsIFNlbHZhcmFzdSBHYW5lc2FuIHdyb3RlOg0KPiBUaGlzIGNv
bW1pdCBhZGRyZXNzZXMgYW4gaXNzdWUgd2hlcmUgZXZlbnRzIHdlcmUgYmVpbmcgcHJvY2Vzc2Vk
IHdoZW4NCj4gdGhlIGNvbnRyb2xsZXIgd2FzIGluIGEgaGFsdGVkIHN0YXRlLiBUbyBmaXggdGhp
cyBpc3N1ZSBieSBzdG9wDQo+IHByb2Nlc3NpbmcgdGhlIGV2ZW50cyBhcyB0aGUgZXZlbnQgY291
bnQgd2FzIGNvbnNpZGVyZWQgc3RhbGUgb3INCj4gaW52YWxpZCB3aGVuIHRoZSBjb250cm9sbGVy
IHdhcyBoYWx0ZWQuDQo+IA0KPiBGaXhlczogZmM4YmI5MWJjODNlICgidXNiOiBkd2MzOiBpbXBs
ZW1lbnQgcnVudGltZSBQTSIpDQo+IENjOiBzdGFibGUgPHN0YWJsZUBrZXJuZWwub3JnPg0KDQpD
aGVja3BhdGNoIGRvZXNuJ3QgbGlrZSB0aGF0IGZvcm1hdC4gRml4IHRoZSBDYyBzdGFibGUgdGFn
IHRvIGJlbG93Og0KDQpDYzogc3RhYmxlQGtlcm5lbC5vcmcNCg0KPiBTaWduZWQtb2ZmLWJ5OiBT
ZWx2YXJhc3UgR2FuZXNhbiA8c2VsdmFyYXN1LmdAc2Ftc3VuZy5jb20+DQo+IFN1Z2dlc3RlZC1i
eTogVGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KPiAtLS0NCj4gDQo+
IENoYW5nZXMgaW4gdjI6DQo+IC0gVXBkYXRlZCB0aGUgY29kZSBjaGFuZ2VzIHRoYXQgc3VnZ2Vz
dGVkIGJ5IHJldmlld2VyIChUaGluaCBOZ3V5ZW4pLg0KPiAtIExpbmsgdG8gdjE6IGh0dHBzOi8v
dXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjQwNzE5
MTEwMTAwLjMyOS0xLXNlbHZhcmFzdS5nQHNhbXN1bmcuY29tL19fOyEhQTRGMlI5R19wZyFiU2JC
aXlCVDBYMEM4b19RN1BfLUtScXBPU1p5aWdNaUZlM2hEY3U3OEtub3BzUkhRckxJdU9QVlUzVFpU
LWpxTkhBbjJ6LVU2YzZTVkVjbXIzZmFaTk1kM3ZVJCANCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9k
d2MzL2NvcmUuYyAgIHwgMjIgKysrKysrKysrKysrKysrKysrKy0tLQ0KPiAgZHJpdmVycy91c2Iv
ZHdjMy9jb3JlLmggICB8ICA0IC0tLS0NCj4gIGRyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgfCAx
MSAtLS0tLS0tLS0tLQ0KPiAgMyBmaWxlcyBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCAxOCBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyBi
L2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+IGluZGV4IDllYjA4NWYzNTljZS4uNjVhZTUyMDNi
ODllIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiArKysgYi9kcml2
ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiBAQCAtNTQ0LDYgKzU0NCw3IEBAIHN0YXRpYyBpbnQgZHdj
M19hbGxvY19ldmVudF9idWZmZXJzKHN0cnVjdCBkd2MzICpkd2MsIHVuc2lnbmVkIGludCBsZW5n
dGgpDQo+ICBpbnQgZHdjM19ldmVudF9idWZmZXJzX3NldHVwKHN0cnVjdCBkd2MzICpkd2MpDQo+
ICB7DQo+ICAJc3RydWN0IGR3YzNfZXZlbnRfYnVmZmVyCSpldnQ7DQo+ICsJdTMyCQkJCXJlZzsN
Cj4gIA0KPiAgCWlmICghZHdjLT5ldl9idWYpDQo+ICAJCXJldHVybiAwOw0KPiBAQCAtNTU2LDgg
KzU1NywxMCBAQCBpbnQgZHdjM19ldmVudF9idWZmZXJzX3NldHVwKHN0cnVjdCBkd2MzICpkd2Mp
DQo+ICAJCQl1cHBlcl8zMl9iaXRzKGV2dC0+ZG1hKSk7DQo+ICAJZHdjM193cml0ZWwoZHdjLT5y
ZWdzLCBEV0MzX0dFVk5UU0laKDApLA0KPiAgCQkJRFdDM19HRVZOVFNJWl9TSVpFKGV2dC0+bGVu
Z3RoKSk7DQo+IC0JZHdjM193cml0ZWwoZHdjLT5yZWdzLCBEV0MzX0dFVk5UQ09VTlQoMCksIDAp
Ow0KPiAgDQo+ICsJLyogQ2xlYXIgYW55IHN0YWxlIGV2ZW50ICovDQo+ICsJcmVnID0gZHdjM19y
ZWFkbChkd2MtPnJlZ3MsIERXQzNfR0VWTlRDT1VOVCgwKSk7DQo+ICsJZHdjM193cml0ZWwoZHdj
LT5yZWdzLCBEV0MzX0dFVk5UQ09VTlQoMCksIHJlZyk7DQo+ICAJcmV0dXJuIDA7DQo+ICB9DQo+
ICANCj4gQEAgLTU4NCw3ICs1ODcsMTAgQEAgdm9pZCBkd2MzX2V2ZW50X2J1ZmZlcnNfY2xlYW51
cChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgCWR3YzNfd3JpdGVsKGR3Yy0+cmVncywgRFdDM19HRVZO
VEFEUkhJKDApLCAwKTsNCj4gIAlkd2MzX3dyaXRlbChkd2MtPnJlZ3MsIERXQzNfR0VWTlRTSVoo
MCksIERXQzNfR0VWTlRTSVpfSU5UTUFTSw0KPiAgCQkJfCBEV0MzX0dFVk5UU0laX1NJWkUoMCkp
Ow0KPiAtCWR3YzNfd3JpdGVsKGR3Yy0+cmVncywgRFdDM19HRVZOVENPVU5UKDApLCAwKTsNCj4g
Kw0KPiArCS8qIENsZWFyIGFueSBzdGFsZSBldmVudCAqLw0KPiArCXJlZyA9IGR3YzNfcmVhZGwo
ZHdjLT5yZWdzLCBEV0MzX0dFVk5UQ09VTlQoMCkpOw0KPiArCWR3YzNfd3JpdGVsKGR3Yy0+cmVn
cywgRFdDM19HRVZOVENPVU5UKDApLCByZWcpOw0KPiAgfQ0KPiAgDQo+ICBzdGF0aWMgdm9pZCBk
d2MzX2NvcmVfbnVtX2VwcyhzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiBAQCAtMjQ5OSw3ICsyNTA1LDEx
IEBAIHN0YXRpYyBpbnQgZHdjM19ydW50aW1lX3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+
ICANCj4gIAlzd2l0Y2ggKGR3Yy0+Y3VycmVudF9kcl9yb2xlKSB7DQo+ICAJY2FzZSBEV0MzX0dD
VExfUFJUQ0FQX0RFVklDRToNCj4gLQkJZHdjM19nYWRnZXRfcHJvY2Vzc19wZW5kaW5nX2V2ZW50
cyhkd2MpOw0KPiArCQlpZiAoZHdjLT5wZW5kaW5nX2V2ZW50cykgew0KPiArCQkJcG1fcnVudGlt
ZV9wdXQoZHdjLT5kZXYpOw0KPiArCQkJZHdjLT5wZW5kaW5nX2V2ZW50cyA9IGZhbHNlOw0KPiAr
CQkJZW5hYmxlX2lycShkd2MtPmlycV9nYWRnZXQpOw0KPiArCQl9DQo+ICAJCWJyZWFrOw0KPiAg
CWNhc2UgRFdDM19HQ1RMX1BSVENBUF9IT1NUOg0KPiAgCWRlZmF1bHQ6DQo+IEBAIC0yNTg5LDYg
KzI1OTksMTIgQEAgc3RhdGljIHZvaWQgZHdjM19jb21wbGV0ZShzdHJ1Y3QgZGV2aWNlICpkZXYp
DQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IGRldl9wbV9vcHMgZHdjM19kZXZfcG1fb3BzID0gew0K
PiAgCVNFVF9TWVNURU1fU0xFRVBfUE1fT1BTKGR3YzNfc3VzcGVuZCwgZHdjM19yZXN1bWUpDQo+
ICAJLmNvbXBsZXRlID0gZHdjM19jb21wbGV0ZSwNCj4gKw0KPiArCS8qDQo+ICsJICogUnVudGlt
ZSBzdXNwZW5kIGhhbHRzIHRoZSBjb250cm9sbGVyIG9uIGRpc2Nvbm5lY3Rpb24uIEl0IHJlcGxp
ZXMgb24NCg0KRml4IHJlcGxpZXMgLT4gcmVsaWVzDQoNCj4gKwkgKiBwbGF0Zm9ybXMgd2l0aCBj
dXN0b20gY29ubmVjdGlvbiBub3RpZmljYXRpb24gdG8gc3RhcnQgdGhlIGNvbnRyb2xsZXINCj4g
KwkgKiBhZ2Fpbi4NCj4gKwkgKi8NCj4gIAlTRVRfUlVOVElNRV9QTV9PUFMoZHdjM19ydW50aW1l
X3N1c3BlbmQsIGR3YzNfcnVudGltZV9yZXN1bWUsDQo+ICAJCQlkd2MzX3J1bnRpbWVfaWRsZSkN
Cj4gIH07DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaCBiL2RyaXZlcnMv
dXNiL2R3YzMvY29yZS5oDQo+IGluZGV4IGM3MTI0MGU4ZjdjNy4uOWM1MDhlMGM1Y2RmIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiArKysgYi9kcml2ZXJzL3VzYi9k
d2MzL2NvcmUuaA0KPiBAQCAtMTY3NSw3ICsxNjc1LDYgQEAgc3RhdGljIGlubGluZSB2b2lkIGR3
YzNfb3RnX2hvc3RfaW5pdChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgI2lmICFJU19FTkFCTEVEKENP
TkZJR19VU0JfRFdDM19IT1NUKQ0KPiAgaW50IGR3YzNfZ2FkZ2V0X3N1c3BlbmQoc3RydWN0IGR3
YzMgKmR3Yyk7DQo+ICBpbnQgZHdjM19nYWRnZXRfcmVzdW1lKHN0cnVjdCBkd2MzICpkd2MpOw0K
PiAtdm9pZCBkd2MzX2dhZGdldF9wcm9jZXNzX3BlbmRpbmdfZXZlbnRzKHN0cnVjdCBkd2MzICpk
d2MpOw0KPiAgI2Vsc2UNCj4gIHN0YXRpYyBpbmxpbmUgaW50IGR3YzNfZ2FkZ2V0X3N1c3BlbmQo
c3RydWN0IGR3YzMgKmR3YykNCj4gIHsNCj4gQEAgLTE2ODcsOSArMTY4Niw2IEBAIHN0YXRpYyBp
bmxpbmUgaW50IGR3YzNfZ2FkZ2V0X3Jlc3VtZShzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgCXJldHVy
biAwOw0KPiAgfQ0KPiAgDQo+IC1zdGF0aWMgaW5saW5lIHZvaWQgZHdjM19nYWRnZXRfcHJvY2Vz
c19wZW5kaW5nX2V2ZW50cyhzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAtew0KPiAtfQ0KPiAgI2VuZGlm
IC8qICFJU19FTkFCTEVEKENPTkZJR19VU0JfRFdDM19IT1NUKSAqLw0KPiAgDQo+ICAjaWYgSVNf
RU5BQkxFRChDT05GSUdfVVNCX0RXQzNfVUxQSSkNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNi
L2R3YzMvZ2FkZ2V0LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+IGluZGV4IDI5MWJj
NTQ5OTM1Yi4uMTAxNzhlNWVkYTVhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dh
ZGdldC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gQEAgLTQ3MjgsMTQg
KzQ3MjgsMyBAQCBpbnQgZHdjM19nYWRnZXRfcmVzdW1lKHN0cnVjdCBkd2MzICpkd2MpDQo+ICAN
Cj4gIAlyZXR1cm4gZHdjM19nYWRnZXRfc29mdF9jb25uZWN0KGR3Yyk7DQo+ICB9DQo+IC0NCj4g
LXZvaWQgZHdjM19nYWRnZXRfcHJvY2Vzc19wZW5kaW5nX2V2ZW50cyhzdHJ1Y3QgZHdjMyAqZHdj
KQ0KPiAtew0KPiAtCWlmIChkd2MtPnBlbmRpbmdfZXZlbnRzKSB7DQo+IC0JCWR3YzNfaW50ZXJy
dXB0KGR3Yy0+aXJxX2dhZGdldCwgZHdjLT5ldl9idWYpOw0KPiAtCQlkd2MzX3RocmVhZF9pbnRl
cnJ1cHQoZHdjLT5pcnFfZ2FkZ2V0LCBkd2MtPmV2X2J1Zik7DQo+IC0JCXBtX3J1bnRpbWVfcHV0
KGR3Yy0+ZGV2KTsNCj4gLQkJZHdjLT5wZW5kaW5nX2V2ZW50cyA9IGZhbHNlOw0KPiAtCQllbmFi
bGVfaXJxKGR3Yy0+aXJxX2dhZGdldCk7DQo+IC0JfQ0KPiAtfQ0KPiAtLSANCj4gMi4xNy4xDQo+
IA0KDQpBZnRlciB0aGUgbWlub3IgZml4ZXMsIHlvdSBjYW4gaW5jbHVkZSB0aGlzOg0KDQpBY2tl
ZC1ieTogVGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KDQpUaGFua3Ms
DQpUaGluaA==

