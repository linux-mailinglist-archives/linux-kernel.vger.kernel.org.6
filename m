Return-Path: <linux-kernel+bounces-174749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A12CD8C1468
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 19:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CFBCB2162D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 17:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F320674BE2;
	Thu,  9 May 2024 17:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="h7PLLkTq";
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="ZcYCbreb"
Received: from rcdn-iport-2.cisco.com (rcdn-iport-2.cisco.com [173.37.86.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4DB1A2C35
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 17:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=173.37.86.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715277541; cv=fail; b=uut/Qvm0SwKSQva5e57Qg4GewFSsNvTCozKM7KBIKMk4dI4LLRd8CsZwPP8nPqj8zBtSR8P3fjEh+7iHq3EACuq0GmP16aC7DamlIgLGN535ekNsOVooGBh2E3RZkPopweEmI8nVJqCflclahqtIFK7Iy1KrJO2JxV9xyQDmFLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715277541; c=relaxed/simple;
	bh=PelQL6QFCDaZVI387D3q3QXZg9sAMqSFqD2YKfYpY3U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CJ+SLNjcJkmCoZ5IykNnXAgW0V6374r/E3B7qwzXfnRfn+mioJ+Yn0IJN7a3l5PaYJ9wGJ3nFAdQkOxfSYU5So9YWW9DR7ienFV2a/sxrj6OHUi92A4PiaTIw6UStWImxnrqB9bxH2hGZFrX0URwNvPDFON+El2VvSN9ueTQ1As=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=h7PLLkTq; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=ZcYCbreb; arc=fail smtp.client-ip=173.37.86.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2147; q=dns/txt; s=iport;
  t=1715277539; x=1716487139;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=q3t+ryskyPF3EuJrCn8/mqHxLTdQ9OPpyDcMWTpJIIs=;
  b=h7PLLkTq1gk64l9USiICvWvXOBIXRePbHtcXlke4MQLIw2LzLJbWSutr
   dz3lIIlWXGm8mH6ZXqgZhAUC4OaUXpzVt0okjGOFi6jtx3YIyi99Ryk8y
   ugdnr8zj58XZvXTyx2T/OacQuwaF92rc8J5b5XOjezfBYNpzbnU5l3Qr/
   w=;
X-CSE-ConnectionGUID: o/idnX1QTg+bf3tbo1E5Jw==
X-CSE-MsgGUID: aUhn9fIIQiynNxal3tlcxg==
X-IPAS-Result: =?us-ascii?q?A0A8AQAsDj1mmJhdJa1aHgEBCxIMQCWBHwuBclJ6gQoSS?=
 =?us-ascii?q?IghA4UtiG0Di2GSKYElA1YPAQEBDQEBRAQBAYUGAog3AiY0CQ4BAgICAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBAQEBBgEBBQEBAQIBBwUUAQEBAQEBAQEeGQUOECeFdA2GWgIBA?=
 =?us-ascii?q?xIuAQE3AQ8CAQgVMSARJQIEDgUIGoJegjEDMQMBpV0BgUACiih4gTSBAYIMA?=
 =?us-ascii?q?QEGBAXbGw2CTgmBSIgQHgGKPCcbgUlEgVeCNxQdPoIfQgKBYAKEE4IvjSZMg?=
 =?us-ascii?q?VqCaZcuVH0cA1khAhEBVRMXCz4JFgIWAxsUBDAPCQsmAyoGNgISDAYGBlkgF?=
 =?us-ascii?q?gkEIwMIBANEAyBxEQMEGgQLB3WBfIE1BBNHgTiJfQyDMSmBTimBDoMQS2yEC?=
 =?us-ascii?q?oF3DmGDWYVSHUADC209NRQbBQQfAYEYBaU0QxwGORs/Jwo+CggwNpMRE5B9o?=
 =?us-ascii?q?GVwCoQTmziGKheqNJhikXWWaAIEAgQFAg8BAQaBZTqBW3AVgyJSGQ+OIRmDY?=
 =?us-ascii?q?ctKeDsCBwsBAQMJimgBAQ?=
IronPort-PHdr: A9a23:GRvttRDxWskmSqKjNlzpUyQVphdPi9zP1kY9454jjfdJaqu8usmkN
 03E7vIrh1jMDs3X6PNB3vLfqLuoGXcB7pCIrG0YfdRSWgUEh8Qbk01oAMOMBUDhav+/Ryc7B
 89FElRi+iLzKlBbTf73fEaauXiu9XgXExT7OxByI7H/E4rJktyf3OGp8JqVaAJN13KxZLpoJ
 0CupB7K/okO1JFvKKs61lPFo2AdfeNQyCIgKQeYng334YG7+5sLzg==
IronPort-Data: A9a23:qRIFgK3YDQ378uDWIfbD5dBxkn2cJEfYwER7XKvMYLTBsI5bp2EBy
 2MXUGjTPf7eNjOkftl/aIS/o0xQvJXRx9NmHQM63Hw8FHgiRegpqji6wuYcGwvIc6UvmWo+t
 512huHodZ1yFjmE4E71btANlFEkvYmQXL3wFeXYDS54QA5gWU8JhAlq8wIDqtYAbeORXUXV6
 bsen+WFYAX5g2MsYzpOg06+gEoHUMra6WtwUmMWPZinjHeG/1EJAZQWI72GLneQauG4ycbjG
 o4vZJnglo/o109F5uGNy94XQWVWKlLmBjViv1INM0SUbreukQRpukozHKJ0hU66EFxllfgpo
 DlGncTYpQvEosQglcxFOyS0HR2SMoVBv77LJ0jmiPCcjEfIKGfmxKxDUWMpaNhwFuZfWQmi9
 NQCIzwLKxuEne/zmfSwS/JngYIoK8yD0IE34y47i2qGS6d9B8meGc0m5vcAtNs0rspHGe3Df
 +ISaCFka1LLZBgn1lI/UstkzL/51yakG9FegFuopaxm7Uny9Q1g1p79Od6OZtiBVcoAyy50o
 UqdojymWUtFXDCF8hKB83SxlqrMkDn9VYY6CrK17LhpjUeVy2hVDwcZPWZXutGjgUK4HtlYM
 UFRo2wlrLM58wqgSdyVswCETGCsuVkdV9xgStQG50KHxPHI6QHAKzUmUWsUADA5j/MeSTsv3
 16PutrmAz1zrbGYIU5xEJ/K9lte3gBLdAc/iT84cOcT3zX0TGgOYv/nVN1vFuu+icf4XGi2y
 DGRpy94jLIW5SLq60lZ1Q6a695PjsGVJuLQ2ukxdjn6hu+eTNX5D7FEEXCBsZ59wH+xFzFtR
 kQslcmE9/wpBpqQjiGLS+hlNOj2vqvcYWaE3w43RMZJG9GRF5iLI9g4DNZWeRcBDyr4UWCBj
 LL74FoOtMEJYBNGk4cuP9zhYyjV8UQQPY+4Dq+PNIUmjmlZfw6c9yYmfl+Lw23oiwAtl6p5U
 ap3gu7yZUv2/Z9PlWLsL89EiOdD7nlnmQv7G8uhpzz5iuX2WZJgYepfWLd4RrpnvPrsTcS82
 4s3CvZmPD0FAL2vP3mPrtJNRb3IRFBiba3LRwVsXrfrCiJtGXoqDLnaxrZJRmCvt/09ejvgl
 p1lZnJl9Q==
IronPort-HdrOrdr: A9a23:oUNPbK6US5ietlV5jAPXwbSCI+orL9Y04lQ7vn2ZFiYlEfBwxv
 rPoB1E737JYW4qKQAdcLC7VJVpQRvnhOdICPoqTMeftW7dySqVxeBZnMXfKljbak/DH4FmpN
 pdmsRFebrN5B1B/LjHCWqDYpYdKbu8gdyVbI7lph8HI3AOGsVdBkVCe3mm+yZNNXF77O8CZe
 ChD7181kGdkBosH6KGL0hAddLu4/fMk5XrawMHARkI1Cmi5AnD1JfKVzKj8lM7ST1g/ZcOmF
 Kpr+X+3MqemsD+7iWZ+37Y7pxQltek4MBEHtawhs8cLSipohq0Zax6Mofy/gwdkaWK0hIHgd
 PMqxAvM4BY8HXKZFy4phPrxk3JzCsu0Xn/0lWV6EGT5PARBQhKT/apt7gpNCcx2HBQ5e2UF5
 g7h15xgqAnSi8oWh6NvOQgGSsazHZc6kBS4tL7x0YvI7f2LoUh7rD2OChuYcs99OWQ0vF7LA
 FjYfuskcp+YBeUaWvUsXJox8HpVnMvHg2eSkxHocCN1SNK9UoJgnfw6fZv1UvozqhNAaVs9q
 DBKOBlhbtORsgZYeZ0A/oAW9K+DijITQjXOGyfLFz7HOVfUki95KLf8fEw/qWnaZYIxJw9lN
 DIV05Zr3c7fwbrBdeV1JNG/xjRSCG2XCjryMtZ+59l04eMCIbDIGmGUhQjgsGgq/IQDonSXO
 uyIotfB7v5IW7nCe9yrkXDsllpWDAjueEuy6AGsgi107b2w6XRx5vmTMo=
X-Talos-CUID: 9a23:o3m5UGE1t2npr3KYqmJgs08YHPB8S0HSj33eeFOyDj9EFZ+KHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3Al/zEdQ60MF7Ik+vi4nxoI8Cdxoxh3qSoWU4ssKw?=
 =?us-ascii?q?Hqs+iJSV0YCuZhyS4F9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-core-1.cisco.com ([173.37.93.152])
  by rcdn-iport-2.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 17:57:51 +0000
Received: from alln-opgw-5.cisco.com (alln-opgw-5.cisco.com [173.37.147.253])
	by rcdn-core-1.cisco.com (8.15.2/8.15.2) with ESMTPS id 449Hvpm9021216
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-kernel@vger.kernel.org>; Thu, 9 May 2024 17:57:51 GMT
X-CSE-ConnectionGUID: I9GvQYMySV6r+spJ2F0ptw==
X-CSE-MsgGUID: ADGnV2YgS12HKowfFJTLcA==
Authentication-Results: alln-opgw-5.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=balsup@cisco.com; dmarc=pass (p=reject dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.08,148,1712620800"; 
   d="scan'208";a="8812159"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by alln-opgw-5.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 17:57:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMIKv8UQ6u/aEDRUhgVIZhYNSqtPRW/3CyDm13H1l3ZLoqP0pOat6rr7bgHKAnv42SOIl822zjiAbzsQ4DlooS+Al/K16iqZS5vqB4DnbVy/kbtmWtp5TeP3QAWMeeN31e6MqrRxg8tn8+bekPQOzuZ4lqvu5M0Y+iZmUc1Ks8BWgajhCwk85In112Fg5asrjR1pGfjx5qvGkXjRmZ5ir4P3cMV5MU7wnBAIuvG50PC3x9pshOmIfsYQL6XsbzserTy6VSFby7AaRAnFxexIp0KNxaquNQd2CToi8NB8kFMks9O6ybOKFMWBUks8XAxtf6ShiwQ+1Y5cYICCh2U2oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q3t+ryskyPF3EuJrCn8/mqHxLTdQ9OPpyDcMWTpJIIs=;
 b=PkTc51UcRBnKc1a8XES5kcusFkcFhQmSJdemsW0Vo+LATu8uce0cTHX7TMWarzdasDalWkbQ/p80QjucLlQdB5/6VmWskJqDzJnbIa1NOUeTf799NuJD0r+Iwyqke/7mdY0SldCmEuIx1edlTe4F8VlZbNv1SroD0xyvRIK9yJkIIfblQtMq/Av6EPN3lBV1YiujpdQ7twOOLUCflwxVChA+oeRCjZ3BVgoBcK2pTt8nXTJvGKIB/3R+eZ2KOjp7WoXKaBknfjbUkG+lSX5/EcQ4O7KEzeLxb8yQxKxjdebIsZEAUJbIWie57+ItsJfzK5XtcRN6UTOZbp35+fsfPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3t+ryskyPF3EuJrCn8/mqHxLTdQ9OPpyDcMWTpJIIs=;
 b=ZcYCbreb6WM230dNVtUkAv7XOd+NwomuuLMKq/ibOSE8skacK7WVBde4s8qfA8NNUQ7+GCExUEQfxa9KB4A/KvcJI/z0RT2DaEhgZVTTy4zg6gCdKGQfL0xqaaPTuWQgcxIIMMBoIjxPlDE4s6iDPXSAKmyl11NbSVoNrvfkv7Q=
Received: from SJ0PR11MB6624.namprd11.prod.outlook.com (2603:10b6:a03:47a::6)
 by SJ0PR11MB4992.namprd11.prod.outlook.com (2603:10b6:a03:2d4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Thu, 9 May
 2024 17:57:44 +0000
Received: from SJ0PR11MB6624.namprd11.prod.outlook.com
 ([fe80::f40c:b9ed:f7cd:5076]) by SJ0PR11MB6624.namprd11.prod.outlook.com
 ([fe80::f40c:b9ed:f7cd:5076%6]) with mapi id 15.20.7544.046; Thu, 9 May 2024
 17:57:44 +0000
From: "Billie Alsup (balsup)" <balsup@cisco.com>
To: Muni Sekhar <munisekharrms@gmail.com>
CC: kernelnewbies <kernelnewbies@kernelnewbies.org>,
        LKML
	<linux-kernel@vger.kernel.org>
Subject: Re: Seeking Assistance with Spin Lock Usage and Resolving Hard LOCKUP
 Error
Thread-Topic: Seeking Assistance with Spin Lock Usage and Resolving Hard
 LOCKUP Error
Thread-Index: AQHaoiVG0oAXLW6sfEGq1UjTh9JUCbGPJhuAgAAFYz0=
Date: Thu, 9 May 2024 17:57:44 +0000
Message-ID:
 <SJ0PR11MB662433ACA8369FDCADC085A2D9E62@SJ0PR11MB6624.namprd11.prod.outlook.com>
References:
 <SN7PR11MB660461A6E5F3FB4546B5BDB9D9E62@SN7PR11MB6604.namprd11.prod.outlook.com>
 <CAHhAz+hvb+8sT3BYS_pT3Lmi5X4PjYWRJR=hvmX1e4Ays512FA@mail.gmail.com>
In-Reply-To:
 <CAHhAz+hvb+8sT3BYS_pT3Lmi5X4PjYWRJR=hvmX1e4Ays512FA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6624:EE_|SJ0PR11MB4992:EE_
x-ms-office365-filtering-correlation-id: c285104b-1400-4c1d-0739-08dc7051874d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?XJL1RB8mqzsymfNn1ExmAylOJY0Y6hqrVg3BETaNSVxkF7FMeQg+ksc+CW?=
 =?iso-8859-1?Q?D9GXzJZ8gijhyjfOPeDIJRKciMtEsCA0/kDqIhCBe+8v14EnWykaYxrESl?=
 =?iso-8859-1?Q?dnZSs2F1ZCDSDbe6Un9vQkzgS2qy6uihdu9B13jk9O2MgEHx/Wk640D1NR?=
 =?iso-8859-1?Q?r4XTxCqTG6FNjStfl0n37O3aEJTNpon4Ds2Vj3U4J5fh0fPprHRmGaTIik?=
 =?iso-8859-1?Q?UdNDDvldbg59cN4VPzexQw0O0IZBE1b2rthQ25DPDPPOMVPVToSIh7Jia8?=
 =?iso-8859-1?Q?MvOx5ePJ30+5WfkjnqcEs22p1HIM1Nhf9wdNW9QZfWgM1Efqp11jq2Muhy?=
 =?iso-8859-1?Q?jMC0Bdr0y4nrtftgsvNsaClBOSWnF3izHmtkw1lHihlb4pGDIQJFerGoXm?=
 =?iso-8859-1?Q?iDuvCOPlIZpOLg/kNQIjNU+C/bswO31C2DPOUJtqi4/YKllYt6URiHGsEA?=
 =?iso-8859-1?Q?1RMeRXCK432/neAzBrJRd07yPmtDixmP/YAkGDodBp1YfMlL5dLHxlZ7Lm?=
 =?iso-8859-1?Q?IP1obHrgvcQmH16UfsXoUpPxC6+5U3JLWVzd1GlF2e8jSjmReiT1nkyA3D?=
 =?iso-8859-1?Q?XJdP4Iy83VQxIdAbw2c464Z38qjXQ4kp28Uni3w1tdausyO/UBm+X8EGlw?=
 =?iso-8859-1?Q?T78snQOyQKzkwTEU3HuiS7/ROJgQaF39ZNS+0qXDR8L0PSB0RZC/0uy7xc?=
 =?iso-8859-1?Q?z5feN4gXGtz6ncrY6B2F8S336j1XoPIFvrcHWiL7upqgxqRb3JMzFjfBWK?=
 =?iso-8859-1?Q?pln4MMiOm4K/1ZTJcGHBeY6GF2y8Jo1IuNjlGRZfu9+nSU6g7JkMPTyQ5d?=
 =?iso-8859-1?Q?rsA2k/G0LtFX6R6gLn/Zk84QuDrGMQn+7tJH8MS0K5c2tJWfjzbUix6Hbg?=
 =?iso-8859-1?Q?E5qMAhjaKqF0BTyHnLM4NkwtyiscdI4ZWYC+EZVT/ThIcPd6hhzw7s2I7t?=
 =?iso-8859-1?Q?W9MojAHOsxgdr+9h4zJiv2o0HWaqB1TgpB45Qbh6pSkHfSZSjpq4s7ZJCl?=
 =?iso-8859-1?Q?zuinCLQLO8LKBdsNhDMe/QkFlVxeTIRWawjqApn+r38qMizXPhS4CSHlQo?=
 =?iso-8859-1?Q?U38KHTdtf3XfeL0pTGvs/O50uQJDxpp/LNP7cTEjwwGYt+5RE7gwk3qzX5?=
 =?iso-8859-1?Q?cKOH6xWBMGlNvEodzGgrbdr3wy1Y17oBsreP5g2DKh5e5gHCbp3FobOdRA?=
 =?iso-8859-1?Q?9F2JJR6PqaY4b2kneMoH/+/Sr4Yk52+ijdRSfhWHjIh0eQ2KFK8Rv0850s?=
 =?iso-8859-1?Q?NBqKy2UrHY/KTdmF2BpSMuSMJIE90Cm9dq41eeaTIbi8r07MpzLBfqQdnz?=
 =?iso-8859-1?Q?YD/jWRe4N8BSX6HinOwJdnz+R5Yieow+JjpuHYukcxfMfuDiZVtKU6vMKo?=
 =?iso-8859-1?Q?JrE1s/onZsf2rKpcr10QlkMrd7O6bWhw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6624.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?8Hq0spBisjxTSM4hoJuqXxhCXobRSbUk/stOFFl3rj752EpMd8aOCRDKEw?=
 =?iso-8859-1?Q?2k8k00qpUedKTyey9af9XAeuSO9o9pMnVgas4lnUdl87WoUSlw5fKQKtrZ?=
 =?iso-8859-1?Q?+SpHh/oaKrH9cza+asjO1/fGD2pUF9PJ3nfJGinyEQEZEaIZYDI3CrE7bi?=
 =?iso-8859-1?Q?elqbvBVCqJ/vdPp1Wvivayr7WL/m+Bblg0BEbnLjGgnF8O848dur7ldae6?=
 =?iso-8859-1?Q?weOoDJJ3SgbvqT2onbAF+l5shB6wvE8HXO2q9E3/uu4TSeJeUJ6Zlp35kS?=
 =?iso-8859-1?Q?l4meL8WuhpRRZl2wx1i3NHNOZ2iYnkQ85EyiF5O3ZHnQvd6KLt9i3Ka/ZI?=
 =?iso-8859-1?Q?JXXioU87lSquLDCuz7X7g/KELMfBfF+D5TXWVL7z/90YajC1CsMBtZnSUc?=
 =?iso-8859-1?Q?fWb80DsBaT9cAhMpRzlv3cpcMkIN6+A9+VjDwhpYMuLyDQ4D5iPud3tIDf?=
 =?iso-8859-1?Q?LzOgpssN5xhLAkWyuvOumtv8XJ7ny0I6Ba+F5OEYNUOV9upvA1VIhkz5fL?=
 =?iso-8859-1?Q?6COQ4lDyFHYJU+WxzBC7RQDIqurIg/+rhFV7pYF59HA47INwXuKGC9jmSI?=
 =?iso-8859-1?Q?C2fymEkco2jx5FPA/5RLw+9D4zDw5No6QiTYY3belqeZL6veLrBySdZnOh?=
 =?iso-8859-1?Q?k2PnbSqd8uhXCah9FQOF7uj5tvO+tHr7BJsR+ePdaBXYmECfwQs00hZSl/?=
 =?iso-8859-1?Q?RPVVz6jg3EUUEQPcEtgOYQYvIODOlwpOrevWBkHVtsTVxV9fXFkt871D9D?=
 =?iso-8859-1?Q?Gp7Ub7TVdthv8M7ocNrj2lFlKSu1NZqLNoSX2zPdytBzUGJYuIKOXOhX2i?=
 =?iso-8859-1?Q?fRZGGegapxcbMxxxPvyHbRYM7J6dVxZ2yLtV8q/hjwzgNaFu25ro9Od4+Q?=
 =?iso-8859-1?Q?FO8wju/WPn/O4fF8RPMebG3gpC+NINAwoWw2LciHlcA4LawytV7iseDpfX?=
 =?iso-8859-1?Q?yqxZwP7nS7CnDY76rTlCkP83gvd7tu7y2vBlPSKPXRUPbOPvX1v/P0UUUM?=
 =?iso-8859-1?Q?k52xW+FfuzdGX9kSs56Cg2rvYjjLXM1X390euA8uUcmEQ3IjmBAQqUu0Ow?=
 =?iso-8859-1?Q?0vG6LlTzPNYBABQEpIssGFixK4WGz6EYP7j26NsKUu/TByooN8vaQ6fuDU?=
 =?iso-8859-1?Q?PVG1c+jdrrt7nlHU954WDly+GUjcS0qlCN6VbnZLpeeVfl0lxhv/2kkN6o?=
 =?iso-8859-1?Q?R28Rc0Pn2NVvA4lrKxVYjYYnQPPt5SLo8EuihvBswI1huJdu7yzqmTQIqp?=
 =?iso-8859-1?Q?LfyKyn1LEcXhbgCuXnRBIEwEVm4RXXnjXo0vxWxV7SnWu85kDEV98sZHDT?=
 =?iso-8859-1?Q?mlDfHEmlfViWfpppFXA5uh+6jrtQexgmi/pwGwGoWK9kABLeT/wK25fKzs?=
 =?iso-8859-1?Q?3Zf11SQEO/EuC/7ZFtloiCw6lyDD7muPWDR7DfLjG6FfJZCkdxZ6ouog1o?=
 =?iso-8859-1?Q?rtP9AKxiR0rqBt8aSjGxnPi/2CVO4jL1f2ajfr4vMLiFndEeZkm63/juh1?=
 =?iso-8859-1?Q?qc45MGvRj2cGorrbjNhanR5FaVLMGDl2N6C0yfIHRy4wnHME49FabJtT0v?=
 =?iso-8859-1?Q?ivT4agATQReLHLiBKaJqN6VPOBZBQGdYs5g/T82H4Xytd4BUr+MxzBIj2G?=
 =?iso-8859-1?Q?T3LtjC05mkiTikaNvZSmsJL2IwKpf5UnEAnf5uN65gJ5SQDrmX3lv0vWrK?=
 =?iso-8859-1?Q?eTl9fQfhpT3p8juukEw=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6624.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c285104b-1400-4c1d-0739-08dc7051874d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2024 17:57:44.4042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: maY6ROUeqwNee1no38Zg7/gcOD6jFf+5XRErELY/2qIp0FoAFQTgUd++TYjGHmvj/r7/QMPyJsi0Kb6rV+9rkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4992
X-Outbound-SMTP-Client: 173.37.147.253, alln-opgw-5.cisco.com
X-Outbound-Node: rcdn-core-1.cisco.com

>From:=A0Muni Sekhar <munisekharrms@gmail.com>=0A=
>In the scenario where an interrupt occurs while we are servicing the=0A=
>interrupt, and in the scenario where it doesn't occur while we are=0A=
>servicing the interrupt, when should we use the=0A=
>spin_lock_irqsave/spin_unlock_irqrestore APIs?=0A=
=0A=
In my experience, the interrupts are masked by the infrastructure before in=
voking the=0A=
interrupt service routine. =A0So unless you explicitly re-enable them, ther=
e shouldn't be=0A=
a nested interrupt for the same interrupt number.=0A=
=0A=
It is the code run at process context that must be protected using the irqs=
ave/irqrestore=0A=
versions. =A0You want to not only enter the critical section, but also prev=
ent=0A=
the interrupt from occurring (on the same cpu at least). =A0If you enter th=
e critical section in=0A=
process context, but then take an interrupt and attempt to again enter the=
=0A=
critical section, then your interrupt routine will deadlock. the interrupt =
routine will never=A0=0A=
be able to acquire the lock, and the process context code that was interrup=
ted will never be=0A=
able to complete to release the lock. =A0So the process context code requir=
es the=0A=
irqsave/irqrestore variant to not only take the lock, but also prevent a co=
mpeting interrupt=0A=
routine from being triggered while you hold the lock.=0A=
=0A=
Bottom line is that if a critical section can be entered via both process c=
ontext=0A=
and interrupt context, then the process context invocation should use the i=
rqsave/irqrestore=0A=
variants to disable the interrupt before taking the lock.  If it is common =
code shared between=0A=
process context and interrupt context, then there is no harm in calling the=
 irqsave/irqrestore=0A=
version from both contexts.=0A=
=0A=
Otherwise, the standard spin_lock/spin_unlock variants (without irqsave/irq=
restore) would be=0A=
used for a critical section shared by multiple threads (different cpus), or=
 when your code has=0A=
already (separately) handled disabling interrupts as needed before invoking=
 spin_lock.=0A=
=0A=
=0A=

