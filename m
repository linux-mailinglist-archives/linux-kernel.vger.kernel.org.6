Return-Path: <linux-kernel+bounces-303660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAEB96132F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 17:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D7F81F23D9D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40ACC1C6F48;
	Tue, 27 Aug 2024 15:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lenze.com header.i=@lenze.com header.b="kjnxWOl8"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2102.outbound.protection.outlook.com [40.107.22.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DBF1F93E
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 15:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724773551; cv=fail; b=PNv3mcx2KqmCbklFYXc0VX/SAHlddAukyn21teXqyBm8+1hi/MsqLyK2AjFeoaYc/BAO4Vy4Ubl5JeZ1A4In7uRslXtgxyURja1xTKhCCER1hgjVEUQiIGcMdyEgEJrBBCzRFQVO+P38O3jbDMAnDg1jjlss04gVfkZnlBq1ZYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724773551; c=relaxed/simple;
	bh=ryaxqwtAshygKo+vG2O1TbktAI22I7cMXaxvvrbexKo=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AhYBaa4PENgGLMrHYcxdNlIiTp3iGvcb/B6CgTckyygDNYmaKJSpApLbJ1smQ7mjt+Paxlmp/ZRGlPB6wbav0q83vOHRqoudmngwL91+TFNKD9zrOzoXZKYDzd+BFP/1J6Eq8b/+GnTcMD5+XEws1hJKfaf9dl/VRcqDhYx8S+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lenze.com; spf=pass smtp.mailfrom=lenze.com; dkim=pass (2048-bit key) header.d=lenze.com header.i=@lenze.com header.b=kjnxWOl8; arc=fail smtp.client-ip=40.107.22.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lenze.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lenze.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hVZmb1UWIc6C0JC8P1XigtIOWiqqoID60EVOHpLPwQdQU5J8p6l5qxPH/e/e/3YhfhAmezCaoQqTAjGs41+FvxG0cB5VQJGAcbkHmBfZ6ilJL9EsHRs2NH3sMExh/CpiHJGd9Afm2lmtiGlQ4a6wb5Z3x033WlWy1i4Q7wTgEPltWzHLCvHQIYEtrRPjbvfNd1FhPpa1OFqYHyop7SLRu/D0+wZGZeG//m1RVdp8xu+1IccI/F8yKrhCfsI0xu6gzWHrv5BMpAX/kJt6oXej27B633Sk35p+tQvwjbCLKldRXKFcopwZ3z9Ps02wm3Yo/ap6vIaHqCmGF/lcRmv0jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ryaxqwtAshygKo+vG2O1TbktAI22I7cMXaxvvrbexKo=;
 b=mvKy4XGJTmh3xOzqqTv/UiG5ku9dBSM39m9cfWw/+Fz8TuH1qMdQmqGO1nUZl0vj7iEcvqJp1g6XagRGdC/MyqacSHPrAL7ht2tPVMFJB5rMF6GCWo83USUx0Xqa6KgLuCCJn2yy8P4BMfzfJ4pAXF78uCz8SGMCPUIx8ebuTz9kw5FYIwrY8T7YmiXX+dvxphbyD1pS3B7v2biLzlEut2MBetQiU6TXwq5NEqugAV8fq100cPL2IkS/IDm3rtSkVpzUDqp0c4HthjM3flF7jEAB27Hpx4GdT+DsTSP+H9v1t9kIzGIpwxsDmvFUvruA/RFTWVJa/H1ah3T95alBRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenze.com; dmarc=pass action=none header.from=lenze.com;
 dkim=pass header.d=lenze.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenze.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryaxqwtAshygKo+vG2O1TbktAI22I7cMXaxvvrbexKo=;
 b=kjnxWOl8NvMZtv8xUwiSCUaOAmqh81dSCC8cAgfhznefFcW4mqKfbebW0sx48Bnkyfmrl5Qe0bQEUFzn55D6nPHJuo1sGTfF2uryy5D6piJAVvrMVr9KVT/XeuQ3JPKT4F7TNgoFS9/0SA/AAqwn48nfQwRNJwibdSlSQqbc+nMo24RYhPj3YbO2OQKxG0ojGUqYqQ8ZsDPypUBiL8rgwkWAziE/vTjIaPAHeC2mq3x1Ui9DFp3MpeMqjRABTK+s93GsDqZpNQ6+eeF9tjPXEwPd492l3/tYy1viE8+C/9XpnRA/LQxVEQ9IcbViDw0PbtFWZ9RsxQSyeLaw6ODipA==
Received: from DB8P194MB0806.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:162::23)
 by PR3P194MB0906.EURP194.PROD.OUTLOOK.COM (2603:10a6:102:4a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 15:45:42 +0000
Received: from DB8P194MB0806.EURP194.PROD.OUTLOOK.COM
 ([fe80::5491:d30f:43f:4123]) by DB8P194MB0806.EURP194.PROD.OUTLOOK.COM
 ([fe80::5491:d30f:43f:4123%5]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 15:45:42 +0000
From: "Brandt, Oliver - Lenze" <oliver.brandt@lenze.com>
To: "bigeasy@linutronix.de" <bigeasy@linutronix.de>
CC: "tglx@linutronix.de" <tglx@linutronix.de>, "peterz@infradead.org"
	<peterz@infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] irq_work: Avoid unnecessary "IRQ work" interrupts
Thread-Topic: [PATCH] irq_work: Avoid unnecessary "IRQ work" interrupts
Thread-Index: AQHa+JgsDXr6phuOQ0i6GwOBiXtqZg==
Date: Tue, 27 Aug 2024 15:45:42 +0000
Message-ID: <25833c44051f02ea2fd95309652628e2b1607a1e.camel@lenze.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lenze.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8P194MB0806:EE_|PR3P194MB0906:EE_
x-ms-office365-filtering-correlation-id: 67908b16-d433-4466-f6ae-08dcc6af4eb4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WG41WmlOd2JPM294VSs0L203MGJEZGgxWlNJNUNPd1A4TWpyZnVDVE8xSzk5?=
 =?utf-8?B?OW12aUhjWkZCamtvZUUxN2JPQW84eUtMRWhMTDlIa2JGejZTbDR3OTFmWElJ?=
 =?utf-8?B?M1lHQ2N6TGZHTmZaUERwVno5WXNBTFE0VFBKdi9sWGNrMG9iVmJXMS9TdC8v?=
 =?utf-8?B?WDNqR1VVT2dzM0FQRFZOcnRwMHpZZGlIVEZ4eDhOcm01REFvOWxaQk5wb0pJ?=
 =?utf-8?B?S3Q0Zk1xU2FCekgwZWwvV2JyZUtONXhTZ1dpS1BicXZ5Z1E4TUtwcUt0djI1?=
 =?utf-8?B?ZFZUaDc0cWFDVXR6MVA4ZThVNTZlWmtiUDg0YmdCWFZGZEhiZ0llOEhkVlVS?=
 =?utf-8?B?bmsxUE5xbEdxbkV5NzcxWkpTbFZWOGFLMkFpQmZtUVdKNCtaUEw0cXZaZ0w5?=
 =?utf-8?B?bFdmdndtTjlHSjMvUnl4RXJ0Q0R6eVBLWWRPa2xnT2pFbXRjcjhGUmQzZTRK?=
 =?utf-8?B?YWN3NDREYXI0eEJHTVQyVDhlWjVIenRWSXg2aEE0eWpQMThlemZub1A0U2pG?=
 =?utf-8?B?a1JUL2cramlxb2Y0NE9RWE1wdnduemlHckY3aUc2QnlqWWVoQ05YaDFzTkt4?=
 =?utf-8?B?UzJES3grelZDM3lUSEREWmZwQURmb043Yi9NeXVwVWp3bjRSa3EzbVlsdUh2?=
 =?utf-8?B?YTFKNU15Wll0aWZ3U1NaWi95ZFd3M0RhdEt1WWpsRFh3MGxOdnZ1dlVEbkV5?=
 =?utf-8?B?TkhRQWdqY3RuTk1xTFp4d0lCeERDalJnc3RzdzA5c0Z3a1h5YXIzOVZYVTM1?=
 =?utf-8?B?MHYyK1RpN1lNczF0aUZWUkVFZ0Y5ME9Ec2FZV0dub1BWSnU4WTYyRWtTMnI5?=
 =?utf-8?B?VFpZRndMWDg4ZkpOb3A4dnVuRk1qbERpK2VuR3o5ZkpzSHFKR3lPNm95NlFP?=
 =?utf-8?B?ZmUvbU9Lc3liODNzVmVGK1pKK3JpcmpSRkpyT29jMmVYQ3FOa1dhMEZDZkY4?=
 =?utf-8?B?aHdIekkvRFJjUHIrTUVrd0huRXZvQ1pPSVYrcmxud1VRQk9ST3Z1WkVuTHI5?=
 =?utf-8?B?dWFDMU5HR3kyWjZVYUNmUEVLMjFraERUMmgvbE1hMnVoSDc4ejJsZGdsTXU0?=
 =?utf-8?B?ZFdyc3dkRkdZbUZXSTNMZkVCOXVOdks0b0dnS1dvSHBWbzYyaXdGQ1R3YUli?=
 =?utf-8?B?aThwLzhGaHhIcHA3M2duK1VFZ1pEMlloU3pyK3pwUFdTT2M0dWFQZUhrL0ty?=
 =?utf-8?B?cHFoQVM5T2h6YWJpY05IQWhCd2dhcTdnSEhSS3dORHBqZWlEOEdiN2JTV1A5?=
 =?utf-8?B?Qnc4M3BYYlRwRm1XMGliSHdVM3VCR3BmS0pyVFIwd2FlcFZkNXdJejlQaHdP?=
 =?utf-8?B?eWwxZExIcUM5L1ZEVzZua21yb1VtWVlHcmo1TXorODg1NXB5b0RuL05iSEZQ?=
 =?utf-8?B?L3ZYSEtEMkZwYnRKUjU2ZGVFbzZ6TGtnQ1lHbFZhRzZVVHlEeElWNVp5OWZu?=
 =?utf-8?B?OFYwWmsyckg1c3F2T1RLK1MrVmM0dE01Nm1CQTN4VXhPMy81VUVKMk94dnFJ?=
 =?utf-8?B?SlZzRFErNFQ2cHZhS0JiUEZOcE9HU0dkQWRsM2lGSSsyanh6RTB1NVkrSlJM?=
 =?utf-8?B?dFRRUHNYMmw0RExKbDE5ZSsxQkdBUCt6bUhIclhJaUQzMWEvaG9nMFRWT2l1?=
 =?utf-8?B?VTJSRW9vUWY5TGt1VW5hQ1E1RURvM0UvU21Kem5IWnVQVGR6M3AweGVMVUNt?=
 =?utf-8?B?ZlR1RnhLTjdaQUYyNThwS0dqRHhvQUU5QjlPcUZQUjJkeUc2dzBldzVuaUQ4?=
 =?utf-8?B?ZFlWUWl2aXRIcTFRTnJYenRubkpGSE05Ym82YTUyeWdzbGEvMkhHOXNhOTdv?=
 =?utf-8?B?VXR1cFhTRkdib2xualY3Ly85N0ZQTjhGVm9YNWZSMWFhclptL3MycWk4Y05N?=
 =?utf-8?B?eWdPS3pMNHQ3RVZWZllaR3hEK1VzZlpkUGhVSGh3ditXVHc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8P194MB0806.EURP194.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UUlOS3l6c0oxaWpUUjNxU1Z5VEhCODl3enZqRjRQbGxDOVcrZnhaMHI4Qk5D?=
 =?utf-8?B?aTNxb21Gbk9IbnJOc3ExaXVxRXVVajlyTStrV3hRN2VsWkQzQjZxM240ekpp?=
 =?utf-8?B?NWVHMWRXM0RiZUhrK1g0Sy9qT0VjZlZtM3Y3c0wrMURXcXcxQXVXVGpXeXlz?=
 =?utf-8?B?QWJMWnc5ZDUyM0xkazRYeWx2SXV3ZnhtOU5MNEhZTHoyaGlYN0FkeVJtdXow?=
 =?utf-8?B?bDFnWTVDZ1pRNEVCOUxMeFhmbzBmL1RlRklwaElWWmh3WGtkNGV3RGsveGZi?=
 =?utf-8?B?dHp5RElzdkxDSmVSWS8wQ1psSHFab21kLzBScWVHZzFmbzZjWEoydzlhTnpk?=
 =?utf-8?B?UTdIWlJJL3lBUHJWaWM0TzB3YU5oQ09PYlpmVFBwRnFKRDNodnMweHA5ZjQx?=
 =?utf-8?B?REJuWnZoeEVraTEyUXMybVoxZU91Wjg1RTU2b1U3SFVraGowaGNPUi9ybm95?=
 =?utf-8?B?KzRPSUsxd1hZeENwaXVmNFhyVmdXVGxlekhac2RUY3YwVmxGZ0t1ZE5QRVJ0?=
 =?utf-8?B?S1VNbXZldVRYRVBTWUQ2OVJmT1JSSTVYTlE0NTczOGVjcTFibFAxWS9EQm8r?=
 =?utf-8?B?MG9SV3dzVTJvR0Z1bm5zdjJYN3djWDBuRFNEcnd4TVFrZkpUTkNnRXlkRytk?=
 =?utf-8?B?ZCtxVHlJUWpDa3FNQlpsMFpFSG90TUJ5Y2pZSWJobHZuMWQ0aE12YXZ5NXl2?=
 =?utf-8?B?dDQ5OGhXTmN3M0xFSHJQVzY0Q0VsTzhPTTRzWFpnK3ZkQTFrK1ZoYTdxTFJZ?=
 =?utf-8?B?VkcwOGgrNjY4V0k5bGRQSGlHK2svR01MRHZ1TUIxZ3pWakY0UFJTQVp4YTNq?=
 =?utf-8?B?cmJ0R21FMmdNc1JaZmdrc3dOazhNNm9QUWVxT2JJdll3Ym9ScERSSWFjRVF3?=
 =?utf-8?B?ajVQQU9MeXZpS0xzU0MrQ1VIaE1taVVITkljYjRpbkZsU0JmRUdpU3ZYSStH?=
 =?utf-8?B?TWR5Y1gwNkEyU2orYzlFYjJ0eExRNWJTVHRwMUdzU1lOZmNxOGtlK1NNejcv?=
 =?utf-8?B?L0IvUDZVSFFveVFrWVNPNWIvQnhLSXpaM0VRam43Qm1wZElVU1owa2NpT2Jl?=
 =?utf-8?B?aDJZUkxtckkvNWk5OFlPL1BoY1MwZnQ3ZkZheFF4RDF6cnpJczVYQjZRRE1L?=
 =?utf-8?B?bkJaZVFYVFFtalN0clllalZibFJBMGdwalFvSy82TjdML0NWQ1A4S25TYktk?=
 =?utf-8?B?d1JaR2FGZXd4RzhIK0djbnNCNkF3NStUand4dzFVMU4yQjJ4b0REeFBpR0d6?=
 =?utf-8?B?TWxYUFRpVHAvcU5Da2hYZll4TUxUMFF0WGdKaDZuL2pPT3hqOTNocEtvYTE5?=
 =?utf-8?B?T0h4RlNIZ2x5ZGtEbXR1RjdaUS84QXhWYkJleXJvSFhvazlsQjRyeFBmdzUz?=
 =?utf-8?B?OCs4TkE0aTVKMWpaajVlQlVRdmc2TmpkMlZCT0thOThSZ21BWXQxNlhHU2dm?=
 =?utf-8?B?MzBGcUhBYXVqYURiWEVmOFZSTkROQ0JsUlgvcHo4STVOOThNbXVGVVNFRnVp?=
 =?utf-8?B?WGRoc3NFRVRIZE43WHR1alhFaWNacUtadms1TkpLRVI0aHFjSHQwaDJ5QmxZ?=
 =?utf-8?B?TmJWR2VSUnNKbWpvdGxHTWt4RG1oeXFlSlowZC9KUUwxYkJYWWtESTMxbURV?=
 =?utf-8?B?RERvVGFOcysvUzhpZW5iZklkVlB5MUhBd252akRDSlZtckRVL2tqOE40YzVX?=
 =?utf-8?B?S25oQ3ZWRFRmcFI4Z1hiWDF5Z2x2RUptenNlTlFYRXdUcmZDcHNBaVI0VlZN?=
 =?utf-8?B?NnI3N0pBUEJKMjYzekVvbVRJd093c3QxSHBwZ3ZPNlRrVFFDL3hGemYvd1Ay?=
 =?utf-8?B?eVhNNkJaOGhHb1hnYUJlMC9PalprdEltNkNmcjRvd2o2MUYwY3BiSzdTYXVM?=
 =?utf-8?B?T2F2N0lSUXZ3L1NqWkFkVmxvTGF0b0lPT2JjN0YyM01WZnBybjFadWYzODVZ?=
 =?utf-8?B?MkNTNGl1bU81M3ZEQjJJQjZXbVVwUjdQUE5ycnowc3VQQ2FHYXAycmFnOU1C?=
 =?utf-8?B?VXhGazFVeVA1MnNIaXJYd0d1NU9ZaXF2Q01jNkFsWXN1Y1E3REY0d1VCZHlY?=
 =?utf-8?B?ZGw1YjFQMFlCdm53d2VieFByb3ZCbC92eVRqUVFNZzR1c0I4S0xNWGlGR3ly?=
 =?utf-8?Q?jahUlfJc/ncdlGk/1QP/q2yDM?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A8D8CED472A27489E3EBD2DC96827FE@EURP194.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: lenze.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8P194MB0806.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 67908b16-d433-4466-f6ae-08dcc6af4eb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2024 15:45:42.1678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 37cf0ce8-ac09-4e7d-9ff2-f1da44914b3e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2ay6Pc7W93hLwEpA0A5cZKnixNw1wP9bDZ+3tGu2z3hxHKT0WaP5uEORmfgszrxhsoJ9HPZKpaWCOxtmGpFKoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P194MB0906

SXQgd2FzIG5vdGljZWQgdGhhdCBuZXdlciBrZXJuZWxzICg+PSA2LjEpIHJhaXNlcyBhIGxvdCBv
ZiAiSVJRIHdvcmsiDQppbnRlcnJ1cHRzIHdoZXJlIG9sZGVyIG9uZXMgKDw9IDUuMTApIGhhdmVu
J3QgdXNlZCB0aGlzIGF0IGFsbCBvbiBvdXINCnN5c3RlbS4NCg0KUm9vdCBjYXVzZSBzZWVtcyB0
byBiZSBjb21taXQgYjRjNmY4NmVjMmY2ICgnaXJxX3dvcms6IEhhbmRsZSBzb21lDQppcnFfd29y
ayBpbiBhIHBlci1DUFUgdGhyZWFkIG9uIFBSRUVNUFRfUlQnKS4gVGhpcyBjb21taXQgdHJpZXMg
dG8gYXZvaWQNCmNhbGxpbmcgaXJxX3dvcmsgY2FsbGJhY2tzIGZyb20gaGFyZGlycSBjb250ZXh0
IGFzIG11Y2ggYXMgcG9zc2libGUuDQpUaGVyZWZvcmUgaW50ZXJydXB0cyBtYXJrZWQgYXMgSVJR
X1dPUktfTEFaWSBhbmQgKG9uIFBSRUVNVF9SVCkgaW50ZXJydXB0cw0Kbm90IG1hcmtlZCBhcyBJ
UlFfV09SS19IQVJEX0lSUSBzaG91bGQgYmUgaGFuZGxlZCBmcm9tIGFuIHBlci1DUFUgdGhyZWFk
Lg0KDQpSdW5uaW5nIHRoZSByZW1haW5pbmcgaW50ZXJydXB0cyBmcm9tIGhhcmRpcnEgY29udGV4
dCBpcyB0cmlnZ2VyZWQgdXNpbmcNCmlycV93b3JrX3JhaXNlKCkuIEJ1dCBvbiBQUkVFTVBUX1JU
IGlycV93b3JrX3JhaXNlKCkgd2lsbCBiZSBjYWxsZWQgZm9yDQphbGwgaW50ZXJydXB0cyBub3Qg
bWFya2VkIGFzIElSUV9XT1JLX0xBWlkgd2hpY2ggcmVzdWx0cyBpbiB1bm5lY2Vzc2FyeQ0KIklS
USB3b3JrIiBpbnRlcnJ1cHRzLg0KDQpGaXhlczogYjRjNmY4NmVjMmY2ICgnaXJxX3dvcms6IEhh
bmRsZSBzb21lIGlycV93b3JrIGluIGEgcGVyLUNQVSB0aHJlYWQgb24gUFJFRU1QVF9SVCcpDQpT
aWduZWQtb2ZmLWJ5OiBPbGl2ZXIgQnJhbmR0IDxvbGl2ZXIuYnJhbmR0QGxlbnplLmNvbT4NCi0t
LQ0KIGtlcm5lbC9pcnFfd29yay5jIHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEva2VybmVsL2lycV93b3JrLmMgYi9r
ZXJuZWwvaXJxX3dvcmsuYw0KaW5kZXggMmY0ZmIzMzZkZGExLi5kZjA4YjdkZGU3ZDUgMTAwNjQ0
DQotLS0gYS9rZXJuZWwvaXJxX3dvcmsuYw0KKysrIGIva2VybmVsL2lycV93b3JrLmMNCkBAIC0x
MDgsNyArMTA4LDcgQEAgc3RhdGljIHZvaWQgX19pcnFfd29ya19xdWV1ZV9sb2NhbChzdHJ1Y3Qg
aXJxX3dvcmsgKndvcmspDQogICAgICAgICAgICAgICAgcmV0dXJuOw0KIA0KICAgICAgICAvKiBJ
ZiB0aGUgd29yayBpcyAibGF6eSIsIGhhbmRsZSBpdCBmcm9tIG5leHQgdGljayBpZiBhbnkgKi8N
Ci0gICAgICAgaWYgKCFsYXp5X3dvcmsgfHwgdGlja19ub2h6X3RpY2tfc3RvcHBlZCgpKQ0KKyAg
ICAgICBpZiAoIShsYXp5X3dvcmsgfHwgcnRfbGF6eV93b3JrKSB8fCB0aWNrX25vaHpfdGlja19z
dG9wcGVkKCkpDQogICAgICAgICAgICAgICAgaXJxX3dvcmtfcmFpc2Uod29yayk7DQogfQ0KIA0K
LS0gDQoyLjQ2LjANCg==

