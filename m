Return-Path: <linux-kernel+bounces-368471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A86ED9A1021
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 18:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EE601C20ABF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9B620F5CD;
	Wed, 16 Oct 2024 16:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="dOAElgL+"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA81E187344
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 16:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729097683; cv=fail; b=KAcmhMiJZAgsF/CHLHMtpOkby+rp0oGKVDmFsnprU3GHa5MbVXJb46WpjijWhrbAQ9qQRFVDeNFGvnRPf4fSGv/aD/jqHuJ8poWyFL2ydhePFP2hHTjKVR+n5SRhcWXJatAxPGnh7X3BGBaYyj6ygpAD9dHJFToueTudcPNRN+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729097683; c=relaxed/simple;
	bh=zrwX9ctynNUEJ1QmviHFFX9alkrY59phWVOAD06HQUo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KoRE50CnOIDLMtfY+JsOlQcjcbnSDpxnEWt3v4ZIm4lOUFevP2lGdE5csfgpiJuERfHMd5bwBlLA74ByzdtYbps+BzqHXHxMVRBPefI2CP/PlGGVGsRt5qCtRv4MYg2/rGm7O5EmOE3TF1b+NNZH/b4b/8+HJzRCjsfO1cXlW+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=dOAElgL+; arc=fail smtp.client-ip=40.107.244.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BJCVukToVoCiIWj0TRWG37Mhdalyt7C0NxM29fYRd8vf87f0D6vJjQAcRSKWIXkAqVmslKaURY8Tm96F4H0zFiFZ+oIkR2wclF5qRh95JioqMy1Q8NmUdxuy9QIZZSoFHruwrvMzsZs+6YF38G5pVkFMooJFVliraJ9GsSAG1kmh7Yp+XNoqVICdD+IQ1rbR6/EEAgkP4bt2XLbOeg3e+2HMJ+npzygvu5YRQrKMBtNIdiK+q9imU9Tyv+QZxh4NYxYioPaaQ6GUh5l41CKxrm7z+qJBPoyphzPxJDj++XaH/4a7jWtXtTLyX5dHNu1L1apM6u3ukTt1a4g6unIiUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrwX9ctynNUEJ1QmviHFFX9alkrY59phWVOAD06HQUo=;
 b=IIIMAVP6I6z0jUkqt5MpLbbqdHBgBRI7JCZpkRDQOdhG28EcJaEYyo64Ms9LdWCOUTlNkLd16AXUPo+Zl29rMHyyuB/lS+1Qgrx17DcL0Z3u6xAQXmVWOA/wkz/zgWVkWFTL5GHKnAX0T2ruFE3K60j9N+4r2ClbUf4xvQQg3so9fqJyAz9EzdA0EnbNEdX0FubXn0fTartvXmVbv9Fvd2fZ3ufZGeGaqynIzlJG8k8xTPQ2v9pPUQ9KlAt0Ijs4zITr4gSECTRHaeTS0p1kW0No/c8C3rmLagouXb9y09jZBjrso8U5md88OqKL1VzXiZMttYhEGm+f4wpOdfL+cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrwX9ctynNUEJ1QmviHFFX9alkrY59phWVOAD06HQUo=;
 b=dOAElgL+yRFZMKt4ffvmdvSOFu1RZ8cCI4DTq2Jmzv9ntSB4p8ktfrv33mVWH05HmETo2wCsiiQM73ffqNSyFargB2lkrwGb6TgSH0Di24JSxBz6GRmIXhxfoPJtSIfCgDsn8IVCx1EP21NkZGLkR36wYGRoqxKULmxyoRsfjT+fyjJuk5GtgFqsZWUNdYzrUBstMeUxex5lyWArNuapSp5FVwcDt+7GnHKVsiPlDOulbHD8lIcAyJl97tXdijNiRN+At/jxX6jGA0xJ9UhuOFkGE5QF/fxC7e8ScuTI78w9jnroYXabd7Cd8+pbPsAVAYwwZw5YbR4Jqoac5WhQvw==
Received: from DM4PR11MB6335.namprd11.prod.outlook.com (2603:10b6:8:b7::10) by
 CH3PR11MB8659.namprd11.prod.outlook.com (2603:10b6:610:1cf::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.27; Wed, 16 Oct 2024 16:54:35 +0000
Received: from DM4PR11MB6335.namprd11.prod.outlook.com
 ([fe80::3adb:8c97:94da:80]) by DM4PR11MB6335.namprd11.prod.outlook.com
 ([fe80::3adb:8c97:94da:80%7]) with mapi id 15.20.8069.018; Wed, 16 Oct 2024
 16:54:35 +0000
From: <Jamie.Gibbons@microchip.com>
To: <conor@kernel.org>, <Conor.Dooley@microchip.com>
CC: <linux-riscv@lists.infradead.org>, <Daire.McNamara@microchip.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] firmware: microchip: auto-update: fix poll_complete()
 to not report spurious timeout errors
Thread-Topic: [PATCH v1] firmware: microchip: auto-update: fix poll_complete()
 to not report spurious timeout errors
Thread-Index: AQHbH+lqQxMIWDDfeUW4oUgWxL6xPbKJmQqA
Date: Wed, 16 Oct 2024 16:54:35 +0000
Message-ID: <31dbb061ad124b8db5f88248d68f20a5bcebced3.camel@microchip.com>
References: <20241016-slouching-excess-d7a62fc926a1@spud>
In-Reply-To: <20241016-slouching-excess-d7a62fc926a1@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6335:EE_|CH3PR11MB8659:EE_
x-ms-office365-filtering-correlation-id: 55765a24-dba9-463d-a3fe-08dcee03370f
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6335.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q28vRGR2UnFsVTQrTkFCUXUwL1NqRXIwRWxDYkQ3TW9UelhUaHRacWVmV0xD?=
 =?utf-8?B?RnYxdGp1OWl1YzFNTmNzd0o2NzYyT0d1OURsZEh4b01BVUYrTHZHdGVYRE95?=
 =?utf-8?B?VlY1dSs1eWd5TnNtWE8rdkZwWXhBRXdoL25HcU9BMExVSE5VbUErMnp6ODFt?=
 =?utf-8?B?WkkxS3NaWDlWTENZNk5sS0lmWFVYSm5JLzU4NGZRYkhMaHFxUUJBTURnUjBT?=
 =?utf-8?B?clJZODkzMzJ1cjZwcXAzZjZCSndzNjNLdnVNNnpiU1N3NnkvNHJXWmt0aW94?=
 =?utf-8?B?ZHBWTWllZ0xNclhSN3BNanNBemdtcjl2SE5CVGRxNExuZTY0VGVic0VtdVE1?=
 =?utf-8?B?Z2NFMml6cmsvMExxM2ViajkyZnRHd0R0ZUFXSjRBUzIyd1g3dUNCSURmNm5a?=
 =?utf-8?B?TldXTm9aY1UxaCtiK2kyL08yUXZsdmZqUEVTV25nVUdaczRxeWxZenFERUw1?=
 =?utf-8?B?c3dQSzNDVzluWTd4UGFVODlXUTNrbU1xR09COVNmdktyKzB6RC8zYW1lOGU5?=
 =?utf-8?B?TWJHYlpreWo5WEZiVkh3cmw1K1NqY0pVZjJhY0ZLSFBNYVpjTU11UEJlellG?=
 =?utf-8?B?Q1ZKL2NaVjNhamdIVFNCaUtwdmZKK09RMlpxMFcyd2trNmQ2U3BpK2w0K1NI?=
 =?utf-8?B?bVpHdWhueXl1VVZPdlBkQTRtblp1QWRWdlpsNnJvRTg4VDlwMTdQU3FJYVpY?=
 =?utf-8?B?a0xhU2xNQ2ZQQW9IRHBRdm9vaWo4Umw3RmZkclhEYzdoMWRVdXd3K2t0K210?=
 =?utf-8?B?cnRLWVJSd1VyOW56dnlUTnRNbVozNEhERWhOUURZeTBLZnFWK2hwdTk0bCsv?=
 =?utf-8?B?VEd6MTJHa2R4WDBvS0IxUHg1elZBVkJwQzB2aFg4L3hDczlLbS83bEZSeDNH?=
 =?utf-8?B?TTN1Qys0YytrM0VWdEJ6M2p3Y3k0cExsbXpWMFE3MFVWKzdhaW05NUNrdjFp?=
 =?utf-8?B?VERVZURXdkR1MnN1N0tWRnBjZG9jcEJvVHk5VFQvczJoTE5mUVhVUUpoUWdp?=
 =?utf-8?B?bnBFcy81d29NcDl0MTBoSmRCK29PWWVFRVl5bmluUHJvRXBhLzBzbjZNT2Mx?=
 =?utf-8?B?VWxJR3orZVpERi9lbFhaQ2hEckZZTTVkekozK0lHSk1ucGlHc1NEdWQybVZn?=
 =?utf-8?B?Mk9VL3FxZ1JLOXR0ZFJIZWJKZWhhTWk3QUZtR2hsMWRvc1Axbzg0THk3WE1j?=
 =?utf-8?B?V1UrTEpKSW9BVkthbU1McjV6c1R3L2E5YjREclU2MWdnYWY1MER6RG5ZRjFh?=
 =?utf-8?B?dFpYTzNNQzZON3U0c3hMRTNabGlMQWQxcjhjSzlBN3hTOFlBMlozZTVDNjBo?=
 =?utf-8?B?V2FmSHNUSzF5RXRlS1JLK2dlam1CL0d3OXFCS1V0VFVUS0UyQlN0Z1JidTI5?=
 =?utf-8?B?MkdnQnMzWTRFazN5WVNaRUltNmdWYzhicFR1SWt4TDhaU1ZyTDlBOWVHem1l?=
 =?utf-8?B?aUszbUVGSGNkeGZudjJYRlpqY2s1RjFPRWEzb3B3K0JKa3RZY2pLOUxPTUY4?=
 =?utf-8?B?VGhWTVErSCttVllUbEE5dkQ0MTlicnhwdFhHQWtoUExDREdRSzJtZlFMSU0z?=
 =?utf-8?B?WXlsb3RQYTUvdHFrOFJtT0VobktaMDVramV0MDdTWnprc3Y5R2pPZE1UTDVZ?=
 =?utf-8?B?WERGTFB1OUUyc2llaDZUV3k2R0JNaitPRFJFKzMzcmMrUXZtWitPazNJTFc4?=
 =?utf-8?B?NDdxK3BqeUsvc25rR2ZNSkhmRlBJRnNrNjlYNzZic05Va3dUcFhmdEVPVXlq?=
 =?utf-8?B?RkRkaU82V1RnLzg2WjVZdnJSWEV4MEcrVUo5bllWL1h3cWZ3R2pLSWtZYW1S?=
 =?utf-8?B?T0l3SytNNUpvRWI4a1ZQQT09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UEE2WmR4czFYTTg0aW1oNjFNbThsaGFFdlowOHRBdlpScG4zSXE1OGtaYVV5?=
 =?utf-8?B?RUZ3dkpHUTMydHZBa3FXV3NNZW01ZlNBeDE2SjBwLzhsUy9GTVU1aXVxZlFn?=
 =?utf-8?B?SzBNNUdtS3pWYUtOTXRvdVBWcGRRU0F5M0p0d1FoZVY5eGF1ZnlKVjF4RHhy?=
 =?utf-8?B?eUUxM1JUdHJ3YklnaXhGMDZVY2lHVXVmTFVFSFh4K3AxL21USTBURERCb3hM?=
 =?utf-8?B?cE8yaVlKN1JrREVoNmE0aUxMNGlsWmhRVlI3K09lL3RIRks2SXZXSmdyVmJk?=
 =?utf-8?B?amFXZ2JHVm1Hd1AvZ0MwZ3R5cTQrMVFGdjA0eUMzY3k4OGNFZVFpQkpjN3By?=
 =?utf-8?B?WlR2a2Y1aTNwaFNId2w0bEtBb1BIVW1VdjM2YVhZeEx4RmR4a2pQNk9mVisx?=
 =?utf-8?B?V3pmWlNLdFg0NWlybHlyNkZWU2V5dEpkSkVtODdUSEVYdis5SXk1WXhuMWpK?=
 =?utf-8?B?MStKZHE2RnZjbWJ3allUSzV4V0owcy80UmNFQXdkY1N0WER4c3MzcDhOby8r?=
 =?utf-8?B?Z0VDem9SbE1kZDBsS2hMbnplRlgzNWJzd05uNDRxV1hKSSt0a3RYV0hhWTBr?=
 =?utf-8?B?ZnM5RnpQekhUcXM1b2tWVllmOGw1dXJHU0J0VTQwSEdFY010QkJWdzJoMlNJ?=
 =?utf-8?B?TEpqME95MEsvYml1MkJHWTVkRE90TFd0MkU2YWRReVFid3RUeEFTTWlzT0VP?=
 =?utf-8?B?YUVGbzlDcGNrVm5nL1ozdTdXUDBjYVN4WG9maWdFRzhOYmJScm5uKzdVVk1q?=
 =?utf-8?B?YTd5Qkdnb1drWllGRmpTZGFBWFIrekdWN3ZkYTNUdWNRbGdRemVISTNXOU5p?=
 =?utf-8?B?KzFhY1R4NHo0VEpSdXpEN3c1K1pldEZTQnA5MU5nOHhhL2V0cDVLS08zQ0k0?=
 =?utf-8?B?RDRzZGlUS0lvbHl0ZDg5K1Vrd1ZsR1hmSzZrS1ZvYklkbUFWanpsaUt0a2J2?=
 =?utf-8?B?b2pMeDZkV1Jrc3puVE9NVEp3MlNKeDF3Y283a2FDaWhiQmVaV1ViWUxyQW8r?=
 =?utf-8?B?TGFHeWdMQk95TXcxWDhiTUxWVW5VN1liNVBxemp5K1Z5L3l1V2hyWHhLRy83?=
 =?utf-8?B?TlMwOTJXTXdzOU11dkdUaFQvRUw4TXNGaUJPK1R4c0VXMW9PUFduY2NHRlNE?=
 =?utf-8?B?ZW16cjRpNTJGaC81bFU2VU9lYmFKT3k3MEV4UlRuS3RsRW1MQW5vOUpPOXlp?=
 =?utf-8?B?OW4xVkR6QkhOR21pdGpwcmJCUE5oc0VWZXRLWjNHa0RxcEVDWmtzNVJzUVd5?=
 =?utf-8?B?eEVhQmJ4ZGRQZERwamVMZWlPN1JnZWZwZ3owOVl2d0ZlZVNRZzkrZ1NoYzRF?=
 =?utf-8?B?amlRUC9SQWhJZldFRzlxVEIyUFZicUJNUzZ6eDhhNVQvbHduQlRIRW1YazhC?=
 =?utf-8?B?Zzl1ODJXcGszRysxTkVGTWhsWWt5elo2V0ZFcmxsbjRvci8wNkZqSnR3b3Js?=
 =?utf-8?B?ODZqNzczOGRSUFc1d2ljNjFmV0VzQzNERGhIc1JzenBMQ0JHSmRGQlZQcUd0?=
 =?utf-8?B?cEVQTVhSeEt5RzFQanlqUGxzUHNrc3BlRmVkNVdMdzZTNWxpZXJzZUJQUlRL?=
 =?utf-8?B?bFlPelR4eHFXNjNpWW1JeEdoMExTc2lCTXY2NTBqUHA1QksvdURjbVNwMXRN?=
 =?utf-8?B?eXVhWnIwcks3cXRVWTczRHh1bFUrLytsTGpKOU9teVpYM3FtaG1HWHFrUU5z?=
 =?utf-8?B?c1BGeXFRRlVTYTJzV1UyVXY1MW1SeFN0QVRkbXY1R2hEc1lIaVB3Qm5iWmZM?=
 =?utf-8?B?WnViN2dQSzN1ZGNNc3MxanBiendJSlZzdzNCOWhKSGZCc0ZYWHU5OVFYbXRF?=
 =?utf-8?B?bThER3dsbWhSYURuVVhPZ0QrMUg5UjdSNDJPNDZncWczYnhxUk4zeGtmM2s5?=
 =?utf-8?B?U2pqS05GVXJ5ZGhDQzdrUGpYdkRtUndGaXVEYjNjNUIrVzZtaGJVOVlRZHlQ?=
 =?utf-8?B?YXp1UmNPa1RYbitDektyMExzSFlaMVJIcmFKREE3K1UwaGtSaGdDdGlOcXFU?=
 =?utf-8?B?UjM3ajQ2TS9ROEFNTnd2RzdFUWVrU2gzaE1ZcVN6MEhNQUJUeVB0K3d4Vlpw?=
 =?utf-8?B?M2xpcE5ob3NMajR0WFlZN1U3Y01sMktLdzVYeFN1YkZTSGF5ZlNGMTVNdi9v?=
 =?utf-8?B?eTc2ckgzQVhpYlc0UDQyMU94WGovWUJIdTNUQ1RXcm1OemF1TTI1eTV1VW4r?=
 =?utf-8?B?dmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C463D10CD8A81043B44EDEB872D8E903@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6335.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55765a24-dba9-463d-a3fe-08dcee03370f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2024 16:54:35.5738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jExMeTSVba5jbIRFQec5//lYIMisCFfqpJIo6z/63yt1XY68rh1NBUiujNzY8TF8clsi281lcN4sYXTwEe+OTMBl5+M33EezYhZ1nDQS0+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8659

T24gV2VkLCAyMDI0LTEwLTE2IGF0IDE3OjM1ICswMTAwLCBDb25vciBEb29sZXkgd3JvdGU6Cj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3UKPiBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUKPiAKPiBGcm9tOiBDb25vciBEb29s
ZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPgo+IAo+IGZ3X3VwbG9hZCdzIHBvbGxfY29t
cGxldGUoKSBpcyByZWFsbHkgaW50ZW5kZWQgZm9yIHVzZSB3aXRoCj4gYXN5bmNocm9ub3VzIHdy
aXRlKCkgaW1wbGVtZW50YXRpb25zIC0gb3IgYXQgbGVhc3QgdGhvc2Ugd2hlcmUgdGhlCj4gd3Jp
dGUoKSBsb29wIG1heSB0ZXJtaW5hdGUgd2l0aG91dCB0aGUga2VybmVsIHlldCBiZWluZyBhd2Fy
ZSBvZgo+IHdoZXRoZXIKPiBvciBub3QgdGhlIGZpcm13YXJlIHVwbG9hZCBoYXMgc3VjY2VlZGVk
LiBGb3IgYXV0by11cGRhdGUsIHdyaXRlKCkgaXMKPiBvbmx5IGV2ZXIgY2FsbGVkIG9uY2UgYW5k
IHdpbGwgb25seSByZXR1cm4gd2hlbiB1cGxvYWRpbmcgaGFzCj4gY29tcGxldGVkLAo+IGJlIHRo
YXQgYnkgcGFzc2luZyBvciBmYWlsaW5nLiBUaGUgY29yZSBmd191cGxvYWQgY29kZSBvbmx5IGNh
bGxzCj4gcG9sbF9jb21wbGV0ZSgpIGFmdGVyIHRoZSBmaW5hbCBjYWxsIHRvIHdyaXRlKCkgaGFz
IHJldHVybmVkLgo+IAo+IEhvd2V2ZXIsIHRoZSBwb2xsX2NvbXBsZXRlKCkgaW1wbGVtZW50YXRp
b24gaW4gdGhlIGF1dG8tdXBkYXRlIGRyaXZlcgo+IHdhcyB3cml0dGVuIHRvIGV4cGVjdCBwb2xs
X2NvbXBsZXRlKCkgdG8gYmUgY2FsbGVkIGZyb20gYW5vdGhlcgo+IGNvbnRleHQsCj4gYW5kIGl0
IHdhaXRzIGZvciBhIGNvbXBsZXRpb24gc2lnbmFsbGVkIGZyb20gd3JpdGUoKS4gU2luY2UKPiBw
b2xsX2NvbXBsZXRlKCkgaXMgYWN0dWFsbHkgY2FsbGVkIGZyb20gdGhlIHNhbWUgY29udGV4dCwg
YWZ0ZXIgdGhlCj4gd3JpdGUoKSBsb29wIGhhcyB0ZXJtaW5hdGVkLCB3YWl0X2Zvcl9jb21wbGV0
aW9uKCkgbmV2ZXIgc2VlcyB0aGUKPiBjb21wbGV0aW9uIGdldCBzaWduYWxsZWQgYW5kIGFsd2F5
cyB0aW1lcyBvdXQsIGNhdXNpbmcgcHJvZ3JhbW1pbmcgdG8KPiBhbHdheXMgcmVwb3J0IGEgZmFp
bGluZy4KPiAKPiBTaW5jZSB3cml0ZSgpIGlzIGZ1bGwgc3luY2hyb25vdXMsIGFuZCBpdHMgcmV0
dXJuIHZhbHVlIHdpbGwgaW5kaWNhdGUKPiB3aGV0aGVyIG9yIG5vdCBwcm9ncmFtbWluZyBwYXNz
ZWQgb3IgZmFpbGVkLCBwb2xsX2NvbXBsZXRlKCkgc2VydmVzCj4gbm8KPiBwdXJwb3NlIGFuZCBj
YW4gYmUgY3V0IGRvd24gdG8gc2ltcGx5IHJldHVybiBGV19VUExPQURfRVJSX05PTkUuCj4gCj4g
Rml4ZXM6IGVjNWIwZjExOTNhZDQgKCJmaXJtd2FyZTogbWljcm9jaGlwOiBhZGQgUG9sYXJGaXJl
IFNvQyBBdXRvCj4gVXBkYXRlIHN1cHBvcnQiKQo+IFJlcG9ydGVkLWJ5OiBKYW1pZSBHaWJib25z
IDxqYW1pZS5naWJib25zQG1pY3JvY2hpcC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogQ29ub3IgRG9v
bGV5IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbT4KVGVzdGVkLWJ5OiBKYW1pZSBHaWJib25z
IDxqYW1pZS5naWJib25zQG1pY3JvY2hpcC5jb20KPiAtLS0KPiBDQzogQ29ub3IgRG9vbGV5IDxj
b25vci5kb29sZXlAbWljcm9jaGlwLmNvbT4KPiBDQzogRGFpcmUgTWNOYW1hcmEgPGRhaXJlLm1j
bmFtYXJhQG1pY3JvY2hpcC5jb20+Cj4gQ0M6IGxpbnV4LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5v
cmcKPiBDQzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZwo+IC0tLQo+IMKgZHJpdmVycy9m
aXJtd2FyZS9taWNyb2NoaXAvbXBmcy1hdXRvLXVwZGF0ZS5jIHwgNDIgKysrKy0tLS0tLS0tLS0t
LS0KPiAtLQo+IMKgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMzUgZGVsZXRpb25z
KC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZmlybXdhcmUvbWljcm9jaGlwL21wZnMtYXV0
by11cGRhdGUuYwo+IGIvZHJpdmVycy9maXJtd2FyZS9taWNyb2NoaXAvbXBmcy1hdXRvLXVwZGF0
ZS5jCj4gaW5kZXggOWNhNWVlNThlZGJkZi4uMGY3ZWM4ODQ4MjAyMiAxMDA2NDQKPiAtLS0gYS9k
cml2ZXJzL2Zpcm13YXJlL21pY3JvY2hpcC9tcGZzLWF1dG8tdXBkYXRlLmMKPiArKysgYi9kcml2
ZXJzL2Zpcm13YXJlL21pY3JvY2hpcC9tcGZzLWF1dG8tdXBkYXRlLmMKPiBAQCAtNzYsMTQgKzc2
LDExIEBACj4gwqAjZGVmaW5lIEFVVE9fVVBEQVRFX0lORk9fU0laRcKgwqDCoMKgwqDCoMKgwqDC
oCBTWl8xTQo+IMKgI2RlZmluZSBBVVRPX1VQREFURV9CSVRTVFJFQU1fQkFTRcKgwqDCoMKgIChB
VVRPX1VQREFURV9ESVJFQ1RPUllfU0laRSArCj4gQVVUT19VUERBVEVfSU5GT19TSVpFKQo+IAo+
IC0jZGVmaW5lIEFVVE9fVVBEQVRFX1RJTUVPVVRfTVPCoMKgwqDCoMKgwqDCoMKgIDYwMDAwCj4g
LQo+IMKgc3RydWN0IG1wZnNfYXV0b191cGRhdGVfcHJpdiB7Cj4gwqDCoMKgwqDCoMKgwqAgc3Ry
dWN0IG1wZnNfc3lzX2NvbnRyb2xsZXIgKnN5c19jb250cm9sbGVyOwo+IMKgwqDCoMKgwqDCoMKg
IHN0cnVjdCBkZXZpY2UgKmRldjsKPiDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgbXRkX2luZm8gKmZs
YXNoOwo+IMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBmd191cGxvYWQgKmZ3X3VwbG9hZGVyOwo+IC3C
oMKgwqDCoMKgwqAgc3RydWN0IGNvbXBsZXRpb24gcHJvZ3JhbW1pbmdfY29tcGxldGU7Cj4gwqDC
oMKgwqDCoMKgwqAgc2l6ZV90IHNpemVfcGVyX2JpdHN0cmVhbTsKPiDCoMKgwqDCoMKgwqDCoCBi
b29sIGNhbmNlbF9yZXF1ZXN0Owo+IMKgfTsKPiBAQCAtMTU2LDE5ICsxNTMsNiBAQCBzdGF0aWMg
dm9pZCBtcGZzX2F1dG9fdXBkYXRlX2NhbmNlbChzdHJ1Y3QKPiBmd191cGxvYWQgKmZ3X3VwbG9h
ZGVyKQo+IAo+IMKgc3RhdGljIGVudW0gZndfdXBsb2FkX2VyciBtcGZzX2F1dG9fdXBkYXRlX3Bv
bGxfY29tcGxldGUoc3RydWN0Cj4gZndfdXBsb2FkICpmd191cGxvYWRlcikKPiDCoHsKPiAtwqDC
oMKgwqDCoMKgIHN0cnVjdCBtcGZzX2F1dG9fdXBkYXRlX3ByaXYgKnByaXYgPSBmd191cGxvYWRl
ci0+ZGRfaGFuZGxlOwo+IC3CoMKgwqDCoMKgwqAgaW50IHJldDsKPiAtCj4gLcKgwqDCoMKgwqDC
oCAvKgo+IC3CoMKgwqDCoMKgwqDCoCAqIFRoZXJlIGlzIG5vIG1lYW5pbmdmdWwgd2F5IHRvIGdl
dCB0aGUgc3RhdHVzIG9mIHRoZQo+IHByb2dyYW1taW5nIHdoaWxlCj4gLcKgwqDCoMKgwqDCoMKg
ICogaXQgaXMgaW4gcHJvZ3Jlc3MsIHNvIGF0dGVtcHRpbmcgYW55dGhpbmcgb3RoZXIgdGhhbgo+
IHdhaXRpbmcgZm9yIGl0Cj4gLcKgwqDCoMKgwqDCoMKgICogdG8gY29tcGxldGUgd291bGQgYmUg
bWlzcGxhY2VkLgo+IC3CoMKgwqDCoMKgwqDCoCAqLwo+IC3CoMKgwqDCoMKgwqAgcmV0ID0gd2Fp
dF9mb3JfY29tcGxldGlvbl90aW1lb3V0KCZwcml2LQo+ID5wcm9ncmFtbWluZ19jb21wbGV0ZSwK
PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAKPiBtc2Vjc190b19qaWZmaWVzKEFVVE9fVVBEQVRF
X1RJTUVPVVRfTVMpKTsKPiAtwqDCoMKgwqDCoMKgIGlmICghcmV0KQo+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHJldHVybiBGV19VUExPQURfRVJSX1RJTUVPVVQ7Cj4gLQo+IMKgwqDC
oMKgwqDCoMKgIHJldHVybiBGV19VUExPQURfRVJSX05PTkU7Cj4gwqB9Cj4gCj4gQEAgLTM0OSwz
MyArMzMzLDIzIEBAIHN0YXRpYyBlbnVtIGZ3X3VwbG9hZF9lcnIKPiBtcGZzX2F1dG9fdXBkYXRl
X3dyaXRlKHN0cnVjdCBmd191cGxvYWQgKmZ3X3VwbG9hZGVyLAo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1MzIgb2Zmc2V0LCB1MzIKPiBzaXplLCB1MzIgKndyaXR0
ZW4pCj4gwqB7Cj4gwqDCoMKgwqDCoMKgwqAgc3RydWN0IG1wZnNfYXV0b191cGRhdGVfcHJpdiAq
cHJpdiA9IGZ3X3VwbG9hZGVyLT5kZF9oYW5kbGU7Cj4gLcKgwqDCoMKgwqDCoCBlbnVtIGZ3X3Vw
bG9hZF9lcnIgZXJyID0gRldfVVBMT0FEX0VSUl9OT05FOwo+IMKgwqDCoMKgwqDCoMKgIGludCBy
ZXQ7Cj4gCj4gLcKgwqDCoMKgwqDCoCByZWluaXRfY29tcGxldGlvbigmcHJpdi0+cHJvZ3JhbW1p
bmdfY29tcGxldGUpOwo+IC0KPiDCoMKgwqDCoMKgwqDCoCByZXQgPSBtcGZzX2F1dG9fdXBkYXRl
X3dyaXRlX2JpdHN0cmVhbShmd191cGxvYWRlciwgZGF0YSwKPiBvZmZzZXQsIHNpemUsIHdyaXR0
ZW4pOwo+IC3CoMKgwqDCoMKgwqAgaWYgKHJldCkgewo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGVyciA9IEZXX1VQTE9BRF9FUlJfUldfRVJST1I7Cj4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgZ290byBvdXQ7Cj4gLcKgwqDCoMKgwqDCoCB9Cj4gK8KgwqDCoMKgwqDCoCBp
ZiAocmV0KQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBGV19VUExPQURf
RVJSX1JXX0VSUk9SOwo+IAo+IC3CoMKgwqDCoMKgwqAgaWYgKHByaXYtPmNhbmNlbF9yZXF1ZXN0
KSB7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZXJyID0gRldfVVBMT0FEX0VSUl9D
QU5DRUxFRDsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIG91dDsKPiAtwqDC
oMKgwqDCoMKgIH0KPiArwqDCoMKgwqDCoMKgIGlmIChwcml2LT5jYW5jZWxfcmVxdWVzdCkKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gRldfVVBMT0FEX0VSUl9DQU5DRUxF
RDsKPiAKPiDCoMKgwqDCoMKgwqDCoCBpZiAobXBmc19hdXRvX3VwZGF0ZV9pc19iaXRzdHJlYW1f
aW5mbyhkYXRhLCBzaXplKSkKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIG91
dDsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gRldfVVBMT0FEX0VSUl9O
T05FOwo+IAo+IMKgwqDCoMKgwqDCoMKgIHJldCA9IG1wZnNfYXV0b191cGRhdGVfdmVyaWZ5X2lt
YWdlKGZ3X3VwbG9hZGVyKTsKPiDCoMKgwqDCoMKgwqDCoCBpZiAocmV0KQo+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGVyciA9IEZXX1VQTE9BRF9FUlJfRldfSU5WQUxJRDsKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gRldfVVBMT0FEX0VSUl9GV19JTlZBTElE
Owo+IAo+IC1vdXQ6Cj4gLcKgwqDCoMKgwqDCoCBjb21wbGV0ZSgmcHJpdi0+cHJvZ3JhbW1pbmdf
Y29tcGxldGUpOwo+IC0KPiAtwqDCoMKgwqDCoMKgIHJldHVybiBlcnI7Cj4gK8KgwqDCoMKgwqDC
oCByZXR1cm4gRldfVVBMT0FEX0VSUl9OT05FOwo+IMKgfQo+IAo+IMKgc3RhdGljIGNvbnN0IHN0
cnVjdCBmd191cGxvYWRfb3BzIG1wZnNfYXV0b191cGRhdGVfb3BzID0gewo+IEBAIC00NjEsOCAr
NDM1LDYgQEAgc3RhdGljIGludCBtcGZzX2F1dG9fdXBkYXRlX3Byb2JlKHN0cnVjdAo+IHBsYXRm
b3JtX2RldmljZSAqcGRldikKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJu
IGRldl9lcnJfcHJvYmUoZGV2LCByZXQsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJUaGUgY3VycmVudCBi
aXRzdHJlYW0gZG9lcyBub3QKPiBzdXBwb3J0IGF1dG8tdXBkYXRlXG4iKTsKPiAKPiAtwqDCoMKg
wqDCoMKgIGluaXRfY29tcGxldGlvbigmcHJpdi0+cHJvZ3JhbW1pbmdfY29tcGxldGUpOwo+IC0K
PiDCoMKgwqDCoMKgwqDCoCBmd191cGxvYWRlciA9IGZpcm13YXJlX3VwbG9hZF9yZWdpc3RlcihU
SElTX01PRFVMRSwgZGV2LAo+ICJtcGZzLWF1dG8tdXBkYXRlIiwKPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAmbXBmc19hdXRvX3VwZGF0ZV9vcHMsCj4gcHJpdik7Cj4gwqDC
oMKgwqDCoMKgwqAgaWYgKElTX0VSUihmd191cGxvYWRlcikpCj4gLS0KPiAyLjQ1LjIKPiAKCg==

