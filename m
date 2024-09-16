Return-Path: <linux-kernel+bounces-331119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCF097A8AE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 23:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8091C285113
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 21:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1B414B07E;
	Mon, 16 Sep 2024 21:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="k3VPjVmS";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="c/GMFExq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="sednzA5O"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1982D045;
	Mon, 16 Sep 2024 21:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726521553; cv=fail; b=COKN4R/hbUkJROEssa5PxeDhtgFQJvvE+sUmc13geOFkQu4MMf0d2uz1Jqto4tekn/6XZw8iLEIU+mkibKEH5p14daewyXKombGb5ble/2ngLA41PM5LYpHotAhZ3lhS2P7lV1l2mmaE7lRHPJVb2u6AbHPrVQ87YQseEsMr+lw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726521553; c=relaxed/simple;
	bh=oWj4u6rm7H316tOR6jPYmbKY7YdRbR/xRgTh68YNTWw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gp7nMAFZNX6pHNcqGFyfbeqHYQPIWAJHW/m0fVnKinZp1Rth7wh+VCGv0ccr9H4kF0aFVv6e6nRJ0mpEuk8YBns551VoH4izvbfZtXkpYfQg/1EfQnfcfXrFrkXy7acWaVtSqziofjP8cafo3pE/9ypgum2GF3KoFNvZ8zrM5oY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=k3VPjVmS; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=c/GMFExq; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=sednzA5O reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48GKON8n020660;
	Mon, 16 Sep 2024 14:19:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=oWj4u6rm7H316tOR6jPYmbKY7YdRbR/xRgTh68YNTWw=; b=
	k3VPjVmSZy3dzaQrbmPaPJy/Wu+MKWVeXdd2QztZT6+/xpkv0P3eE1x31aq4yHiq
	VxFLmjtbnhoHch5wiurJQAI9EtHMFB1FTUWGa9r0uFJXVD05PvFhYLRYhzpSEH0L
	VSnfiXTRV106TXb7cIFjfnVIPCqQvCwAEsxvo/MrZM4Lw6P1tgNXXzAc/JXCLedJ
	by9Ru9YUIu7UTvm9+PohI0b+0hdahtIggSB+3Efs4XxzvAvJgunam8Td3BWvdVGa
	lTREmiSrmJH4sTdeM1Z/exdBG1FIAfOd922N5XPh0q3ip4CqvDXemS0gCyMlOtIK
	ZhDpM9KL1JyWzzd40cmYiQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 41n9dv09th-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Sep 2024 14:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1726521545; bh=oWj4u6rm7H316tOR6jPYmbKY7YdRbR/xRgTh68YNTWw=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=c/GMFExqYJQM5e/tea0bC6WAdaHwCKuPoSc5JRqZU28mJzUB+bp6u4pt+t3754+NJ
	 8FyHW7YcFI9agH4s7Zy+pb2IRAHpJX5+34/aJdbt74FcY80cBSAvoZK8RLyRe5UxFo
	 SR2YnG2iGH0vPRtHcZYeAYmf6dfQd/EMSmc9nmWolFgCIDB1yEHdqVFVbWiRoXbW7k
	 27yMewCtBT1C+aYcJa9BcjNBdWMWp5+wC9OzWXeEeJSAwE4dRyL56bPEhr3HJPv5f2
	 f7OPK79/C0mjSWN3pb/8ANmZY3cw/ATwalAX+oE34CJkjaH3Q9Wc5QWGoBKKIRNjOC
	 vVnEoUJz3QX1A==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3DB4A40141;
	Mon, 16 Sep 2024 21:19:04 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 9FF1FA0070;
	Mon, 16 Sep 2024 21:19:04 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=sednzA5O;
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 15E81401B8;
	Mon, 16 Sep 2024 21:19:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tBOUwfczwdoXlgejWjoinukrQDr+AvxvPn2gNhB6kpQUhgJBjad0x2beCg6lLXbnnGT8tf188/khroUPt9ahhUjDP1jX9rwGgWdchERkHMYOFqRsELyPla7vroToTlGmLnKDvirK0xIjxHUhifBTCPC+JP3gS3b4fabhxTxyAMYuBrYY40SjKYueJSJwyf1Wkasnnoqr2Is4r5m/YyHbHXuo0fObOOBOSVvaVX/k0HfHNJyQsD17Fv9BvtQoVm5UrQhHpvuihOQZq134sZceKQeTUJ5bH+1yQA91iEN4zzaRFPn9vMKsDLAfjKbQot3PRXRbzOLXvSJx9xP1h/DTPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWj4u6rm7H316tOR6jPYmbKY7YdRbR/xRgTh68YNTWw=;
 b=anLG75pclhktaE4qZEsyOXWTtyzFwdxOp8eq4/iP+/KRuD7O+Yc9omA4IrFwS8OemQwQUtaQ4MRilur9R39qmEqWNGdstRigjhJuPnBKNWE48CS4GeEV/9XV95MRCmYcb1WlIpNwwjb+eQpYZH4jy0jbcjRubpqTAL1wcvkOpmS3opPzNx6mHF7glYTrNfHYWq9O8SSwziv7CScBWpKE2nzNg+1o9DjLRQNYwOcMu2ANhNkLsQTeZqJOHlVkvrl1+90NSwh5bcTEmuMG+8y9OTwTeIMRhjdwzc/WQmXJrx1BGsavcRXnpWaSjg4kw5+jXlF5jnBT2wfYq+syxXOUew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWj4u6rm7H316tOR6jPYmbKY7YdRbR/xRgTh68YNTWw=;
 b=sednzA5O9Bt/VFuUANeRWESEyZ247iFGr5+u4RJHYrAMH/hTtFOVg2nxonD52FBjwZB8BTemZ7xhbRGGjHZWLlnP7rVis/X34kh5h4nfS/Z8hHVbJ1xb6SRw01kZJcjaAKZLJo3wrPBZOgwKHN+lUExL++omF7EZRagNq7nxS2I=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SA1PR12MB5669.namprd12.prod.outlook.com (2603:10b6:806:237::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 21:19:01 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 21:19:01 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Selvarasu Ganesan <selvarasu.g@samsung.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
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
        "shijie.cai@samsung.com" <shijie.cai@samsung.com>
Subject: Re: [PATCH] usb: dwc3: Potential fix of possible dwc3 interrupt storm
Thread-Topic: [PATCH] usb: dwc3: Potential fix of possible dwc3 interrupt
 storm
Thread-Index:
 AQHa2cstTT8AcV9+kEe9fm+4hVNVnLIbEIwAgABflQCAAT06AIAAVgGAgAK0ooCAIEFKAIAA0sIAgAPWhwCAAnZSAIAA99mAgACQGICAANfzAIAAhJUAgAAfSwCAAAOTgIAAE4YAgAAIvoCAAS6LAIAAXkAAgAWQSACAALStAIAD8tcAgABWWACAAAJygIAEXpyAgACQDgA=
Date: Mon, 16 Sep 2024 21:19:01 +0000
Message-ID: <20240916211906.bgcterfckwnsg47x@synopsys.com>
References: <20240906005935.caugoe3mqqdqwqao@synopsys.com>
 <30ca8527-419b-4e44-a21b-18e494b39076@samsung.com>
 <20240907003946.qn6t3xw65qwl2cn7@synopsys.com>
 <dff83c7d-56b8-481f-af69-8d4262bd54e4@samsung.com>
 <CGME20240911002436epcas5p19be55e1144edd6f77184192c7f22a85e@epcas5p1.samsung.com>
 <20240911002408.gr4fv5vkst7ukxd5@synopsys.com>
 <dd7965fa-9266-46b9-9219-1ef726480a9b@samsung.com>
 <20240913175106.qbav2aigzwaj7pvd@synopsys.com>
 <20240913175951.ahtlhkc5cycu6vjs@synopsys.com>
 <1aa3c54a-7dcf-4cc4-9b05-96c67dda4fdb@samsung.com>
In-Reply-To: <1aa3c54a-7dcf-4cc4-9b05-96c67dda4fdb@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SA1PR12MB5669:EE_
x-ms-office365-filtering-correlation-id: b8c7a82a-45fa-4e67-38a8-08dcd6952f55
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dUlrMU1yeklXaW1wTjd3RlpWay9JSnFyOHJIc2RsWm56ZUIxaVpPbEd6Q1Bp?=
 =?utf-8?B?SDJhQ0w5bGEyTTZQZnAwVVI5WlNrYXhBT1dPdDRoMGNxUEppWVNZRTdrNGxi?=
 =?utf-8?B?WVNwcXJzYkdEd2lKYnNhZHB2TEpOMVo4Y2FOYXN5Nm9hWkVwNkNSQUM1SjE3?=
 =?utf-8?B?TWhINUR5c0IxWTNveGJqL2R0Sld3UGd1L1EzRnEvWUg0SjMxOXl1VGtzdHFr?=
 =?utf-8?B?LzdmTnZLMGNzV2N6aW1Bd3ZtM0lnSWM2RVhTVTlER29rWWhkQzUzMmJRUHBH?=
 =?utf-8?B?aFhCWUN2ckpnZWczeDYrVHBDL1FrY0VwbEk0T1dnZTVweDdGRHZLejRFbUFV?=
 =?utf-8?B?NllLZ1VNQWlDbDVBQjA2b2N3cUlxVUpkZUpFWVRFa29XSmR6NE5XdWFsc3cx?=
 =?utf-8?B?K25hQ1pMbFN4OXFIa3ZCZ3Bkc1VlY1VlSDNONWJJTHJNVFRzSFRDSUFEMWhQ?=
 =?utf-8?B?THFwZC9GbDhSN0ZjK0hmWEpWSFpsUkUwTTc3NGhaMTJZUUtOWXk1azJIU2xa?=
 =?utf-8?B?ZnRGMlR5SXpWZzJpRk94cUlZS21MRkhKWDN0OXYrYkplSW1sVlk1VzB1SDQ4?=
 =?utf-8?B?WEU3d2Z2UWpXaUJRWmVDTUUyZ1ZKdW9uc1NhaWxWNFpjZnpXK0NiZksyMFlH?=
 =?utf-8?B?YzZsWXZONXdJUHpSaHRWMTIrMVB0d2RUSWZJY1k0dzBBNXRXcnZucHBJREJw?=
 =?utf-8?B?MG1Tb0MxV3BDa2RkQlZ6Zmx6bDZjVktPM0Znb1lrVmR5T1VCZFovNVFyWC9X?=
 =?utf-8?B?RTZ0aFlVNW15aTJVUjF5UUdzbVB4b0tTenErTjRMQzBCRE1NbW56QVlJQkVB?=
 =?utf-8?B?ZktOU04yanZCU0E1UzhNN0x6N21EVEVoaFhtcWZWWDcreE11MVBSMVcwd3B6?=
 =?utf-8?B?NEFLQ0lRc3dOOG0yV2lsR3RiZThGU0VUU1laYUNGUEZmcHhvdFZydllnVDlj?=
 =?utf-8?B?RDBGMlBkajN6Z3BkdVVZT0JsV3gwQlhIOE16cDhVZ1g1UnZ0UU1ydU9hM3ht?=
 =?utf-8?B?S05TNG16VEkxQ1pEZERCekg4a2lMR0E0MDFGOXQ4RWZsMzNHLzhiNjZoWXBB?=
 =?utf-8?B?VkY3MXVGNnRWWG83S3BCWTlFWlU4Tnk4aUtWbUh1dk55cWZWN2ZjL1hRbWUw?=
 =?utf-8?B?Mk9HWDM0UVN4anM3NkdHRXdxL24yMGRCUnNsNzJQV3NmSkE5bVVqdjJMUzYz?=
 =?utf-8?B?azQxYUgvcUxMUG9aUGxRU2NTbGJTUTBlOXBydHZ4MDROK1ZEalIzcmgwZ2JU?=
 =?utf-8?B?bVdqNnBaQVBLMEdQNGVacGZPU1RHdEtXL1VsWmZ6d1E3TzJseGlDRFAzQWsw?=
 =?utf-8?B?Y1JqZE9GR0lXZEVSc1lpVkdIZ1RjSTlLWCszYTZDalJqajZRajdJcTBoVkUx?=
 =?utf-8?B?cTlLSm5WQmFwc09ub0t4UTVtclQ4Y2RoMVg4SDBUWDRqMDJSUnNiaGFVeTg5?=
 =?utf-8?B?UUV0SWhVb2pJMnZnN3lpQ0I1cjcwVFZyTnVpRjlNQ0xJTk9aWEsvMXpxcGJv?=
 =?utf-8?B?RFZoMlRxcGU3NjNFMHR4OFdOVjZKSlFHSVJOMHZZbnNCUlVZY01jUStmMnQx?=
 =?utf-8?B?Q0xnS2NnbGtFOE4vWGlyYmJyUlJOSlVhNnkrbjYyRE12cEk3cWwyT3dhZGVq?=
 =?utf-8?B?dXVBSGdEalBLSmE3V2NKdzV3WW9helNGd1ppZFZVZ0tzZHltN1BxTGNlV2d2?=
 =?utf-8?B?S2xrSk80QkdRMU9OT0F4MDZvUDNyVnV6R1BrOW1TU0ZpT3dHcnA1TU52VGFa?=
 =?utf-8?B?TXcwNFFFcEJVT1BrNVJTc3F6VGZRRFA5QmlYV3lldFNmM1Yrci9zVElHY1hm?=
 =?utf-8?B?TlMzZm5zN1BzZXFsdjZyZTRTYzZMeDhsa2ErZ1BrYUdqT0NLQXFieGp0b1VB?=
 =?utf-8?B?d1NkNU9HdFNFR1NLaks2eHQ5M3gwd1NQbXpFL3RDTTRsWVE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TU1SbkcrYkorVmE0dE1kVklraUhNMVcxQWpoY2Y2Y2ZWWGdzKzVGSmxvQXc1?=
 =?utf-8?B?MDZoU1AwZmpYUUpwdUs5MEVuUnBXNDhYNGZoRHdpSEpOOTlZWENneXFMVzZn?=
 =?utf-8?B?TzJSTVphemlyWXg0c1llcTJmTEFSc2hiY3V5RGxmdG5JVVhHbnVMb0tCalk4?=
 =?utf-8?B?UVp0ajFLN2xCZk0vNjk3Z0lEVEU5LzhTNm9vd1lSMVlUdEtqeGY4TGFhYitQ?=
 =?utf-8?B?eXVod3cyeXd2L0Q2dzVUZVdlYlIzMml4Qkh6ZkRnc1VrUDBYWTVNVnZUN2ts?=
 =?utf-8?B?bHNOeVkybW4yNkN5clJxODlBZGphekdDUkVOQlQxS3RoYnlhWUFFblB2eWRz?=
 =?utf-8?B?OWxOZ3F6VEdud2MzTU92bVF5YjJhRFp1cllZVUVkQ2pZSW44NzVlNVlXLzBN?=
 =?utf-8?B?WFFDUzlmdkU4c0ZDOTVUZEJnYURYYWRMMXZCc1ZPc2ZQRnRkWlBNbHdhOWxQ?=
 =?utf-8?B?QTdRMmE3RXBsOUU2MWxrNzRwNWRxWFBTSmtvVmh4TldWbUpoVVZWekduUVhD?=
 =?utf-8?B?eUUvRGZkNG5mL2RZSHU4QS9Rd3FJU2YxUUg1Nk5xOHMvWVhUUm5NeHhmYzY4?=
 =?utf-8?B?MTE1MGQwdWxmS245emI0alNlT081OGhuS3pQdWVub2dSY3VZU292QjkrdUZt?=
 =?utf-8?B?UG52Uy8wODBTMTg3clJaazlVWG9FN2M1QzJkdFJoK3UwNEtleTBudU1NNnVX?=
 =?utf-8?B?TDd3K2h2N2tpdmpBODlhaEZOb29Sdm03VHB5cHdOam9VUGRoenAzM0l6VVhX?=
 =?utf-8?B?VkRnQ3ZQV3pSRjZZNmIrUncybjRFempIZktRSWJXbFVmNzcyWWtZVHZJM1lh?=
 =?utf-8?B?TEorMEFrU2JZdFFqNVd0VnhORDdXZThxemhxSlhWMVczaGxmNGVyT1pyMnJ5?=
 =?utf-8?B?eEY3SW1uYzBMbWNIMXBQQkdtZW5rUCs5S0RZSWdueXZJNHh5ZW81V0RrR3Fh?=
 =?utf-8?B?K0djdnZJcXJDOWNzTm9malczT1ZYcU1ZMjFNSkNIanFERDZ1TnVJODFaYnhF?=
 =?utf-8?B?Zmw3cUtjVXB2QTlyS0tKRTRiYjhiUXNOb1hnSEFCNEVwcGJyNUZpZmVHUG1J?=
 =?utf-8?B?eEEyUGhCaTJRdFd4bDBLZUFzczFObGRxWWRZUlU5QkVJS3g5bWRXUzU4Z0Rt?=
 =?utf-8?B?WjQrK1JQUDF5bFU5SjR1aEcySXFWOVZPaHdBenNSSzZVYjVMTURDYVVIWEg2?=
 =?utf-8?B?bFRvSUJqNWFzMUl3N3hEUlNVbHlySHdDbkw5ZEdmVWIvYVdMRS8yWElVM3dy?=
 =?utf-8?B?VktaZWFVMUhvMjlSZ2w4dEw1S0ZuVVVoMC9GV1FHQWIrOVc0bDJhNVNiZ2tT?=
 =?utf-8?B?TjAwSCt2R2lLRnY1c0VQaWlZWXZESUtSSW5RWHdJd3ZZNEtEdGlxVVpZWmp0?=
 =?utf-8?B?bUlnaHozb0tlYi9tUjhNaGVBRW5mWXArV2s4TUJGdWNzM25TZlN2WFU4Mk9U?=
 =?utf-8?B?b0kyaVVYYWZlNWloL1NwZEJyN1hvUExUV2VWcFRzMk5TRkJUbmZ3WTBhY3ZH?=
 =?utf-8?B?enNlSWcyZ29kV2MwcG1nQ0hVYWp2K2o2dkJYSEhPRlFvb3lqbjV6WGxlVnd6?=
 =?utf-8?B?N0JDVE9EY3pDalFOVGVFRXM1a1hwN0Q3Q0JZaTZZRms2MjNEdTFkb3J5WUhG?=
 =?utf-8?B?OTJCdnJ2MS9hOUpoY20xUnRlclQ4cFZub0RFd3diOXZTS2pBUDB1a2ZUenFX?=
 =?utf-8?B?QytPa2lKZ0RweGJuZ0dOTzFnVTg1OTEzTEM1K2R0d2NpTTRZNjEvS055RHZq?=
 =?utf-8?B?TzJsNU9sZEw1U2dpWDZqWVE3UkVyK3o0ZWNNOXB0WUhGV1E4cXpCK3A4VVpr?=
 =?utf-8?B?QmJvVjRUMWFvK0FwVjd3aGFyM2pOeWVCanExUndRS092N1AyUXdNY1hoMjlR?=
 =?utf-8?B?VVNNaHlYOWtKSUp4V2QrODN1U0hWUU5wZ3RpTi9Oazkrd0JMNk5wUDRmelJE?=
 =?utf-8?B?OWF1Z0lxMEdJc04wc2hBNlFyZThtTmpObWk3U0pDSnJyUjNBQVVralR3VXVO?=
 =?utf-8?B?WEJYRGxuemhSK3cxZHBOM3RNNkt2M0FvWVl0VEg5dXQzeU02QUVkTXoycUxI?=
 =?utf-8?B?Z0wzMjN4YVI2NTJzU2QremZCY2tNb1pFNXVnQ2JjaHErQXhtcnBzSDBWcXJ5?=
 =?utf-8?Q?EK/mCIb2mdfhgPvojFyNVCkEy?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1907A93C54C9B943879F8222A6352AFC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xsCBKmCtTFfqccx2WuWvcmKwXb7oTwt+ULMUysnvUIE8hdKGNOAKvPuZKe/p4edsj1Jo6hGKTQqCAKL9g5I9xbDIVkHNzye0g+C2muKpdDKXWH3dNFTWUXF5Myia0ck9D1B87wEQJWu6rgSHAQ/MxUMJa9Z/k8n/L9WoTCVxDAxRbChqxpFp9kzo1eUrT9Q6VBZKmjYiIDkHfqbw44gaxQJlgjhnk3ASzbpiLARjNK/3nhJVzS3xWmK/vJDQwgU9IW9Qp5MDm5cPr1BZskcJu6jHXpRBjT48EP8ZQ8IHnPiNiEdt+wybONq7+SgTz2U8RI2+DwxSvBbyKT0pDpV3666RftA9Nq+8OUkd3mbmifWHKn6TLiekutryBWWlz18/tmTATgWu/m2wI5WIF3bkDEjIm3/8h80kc2fyEF6CK0uVfzwoWvrPMA5xIy8zMQY/CqeMMxefNgmziVqTjZqJRe/6eeb08z8yEbOy1KnOF/n9WS89f3Z3HGy6K8JMB2GD3pY1Mk9YfhItgsla8IGwNAtgHE0IjLBbB601qyDzvLJZbfFHSh/Ovkb3Wm1eYxAJoPVXmCjRJHOH77INdd94xNBfisPfeXUw1vB1Opola8qOJRvQdM5R5Ew2DNaTrzj8Ef5JAlp/ZjVBIoYiJ6Qt5g==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c7a82a-45fa-4e67-38a8-08dcd6952f55
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2024 21:19:01.1817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OuwQKkrKdGJ/1bZ+6dAn9y2BIXjxFsv65RtiBFTfKr490TfFRZLXYUoHkVLc583SdFIMzhL2DKMqKbnIcmqL9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5669
X-Proofpoint-GUID: g76BUIYcAevcoE0Jq609Gzs1zDWtdrmb
X-Authority-Analysis: v=2.4 cv=C+C7yhP+ c=1 sm=1 tr=0 ts=66e8a0ca cx=c_pps a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=nEwiWwFL_bsA:10
 a=qPHU084jO2kA:10 a=U5_tufkdo6jscqcevaoA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: g76BUIYcAevcoE0Jq609Gzs1zDWtdrmb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 clxscore=1011 malwarescore=0 adultscore=0 suspectscore=0
 mlxlogscore=830 priorityscore=1501 phishscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409160145

T24gTW9uLCBTZXAgMTYsIDIwMjQsIFNlbHZhcmFzdSBHYW5lc2FuIHdyb3RlOg0KPiANCj4gT24g
OS8xMy8yMDI0IDExOjMwIFBNLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4gQWxzbywgcGVyaGFw
cyB5b3UgbWF5IHdhbnQgdG8gcmV2aXNpdCBhbmQgcmV2aWV3IHRoZSBjaGFuZ2UgYmVsb3cgdG8g
c2VlDQo+ID4gaWYgdGhlIGdsdWUgZHJpdmVyIG1heSBiZSB0aGUgY3VscHJpdDoNCj4gPg0KPiA+
IDE0ZTQ5NzE4M2RmMiAoInVzYjogZHdjMzogY29yZTogUHJldmVudCBVU0IgY29yZSBpbnZhbGlk
IGV2ZW50IGJ1ZmZlciBhZGRyZXNzIGFjY2VzcyIpDQo+IA0KPiBIaSBUaGluaCwNCj4gDQo+IFdl
IHJlY29uZmlybWVkIHRoYXQgdGhpcyBpc3N1ZSBub3QgZHVlIHRvIG91ciBnbHVlIGRyaXZlci4N
Cj4gDQoNClRoYW5rcyBmb3IgY2hlY2tpbmcuDQoNCkJSLA0KVGhpbmg=

