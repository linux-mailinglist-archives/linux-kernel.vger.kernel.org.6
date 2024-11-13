Return-Path: <linux-kernel+bounces-407821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1EE9C74BD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ACBC282964
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2537082B;
	Wed, 13 Nov 2024 14:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xaI1GKn7"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FF5208A7
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 14:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731509362; cv=fail; b=AhGv2sDQVFLavOHfT9nR0MsuLwJrL/mGaMqoU//Ap/O84CGOUU62TadJOFanex9y6wLNp2XWiBJ3ebmRQwrWUR5EY3oa2MKpqm4f3Z2T7F/mNda8Vxtgjb065AkitPbSSHRlMHdSfWPjOK6/nGk0pbOrb+D9SLOI0e8xD5WI5xM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731509362; c=relaxed/simple;
	bh=/gbFpHdZwY8kGJ/JyBh9L4SHh6+reddGc6V33jNMA2Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A+0y8yo/Wl4u/Hsal5ZASe3DsnrgpW1DmmjxfXK6pRcCfnIKIawTSHIOibXDMT9jngrwQtIT3jw/2Ped5gZmAXq1Lc0yu7CfE809v1MQPcTlo2QR8y3pamnBDgv4TDVLcLIxKSTaR0MksG3t12Dl3RRWSWlCnPQFa+aQHggCK6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xaI1GKn7; arc=fail smtp.client-ip=40.107.244.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jclMfNRSDip6QkKbHT1znoYMlNq8PRFcNe/nwpTFQ85h4j9yuSXoSfe/KTE7LibK/VOKclBdhL8iBkn08PuOK9qL0Vq6rBXcDQuWZXTsn/9t/Ak5S0dSk6lpRBcubjX8Wujjdmc+1RJgal7vMMiMHZi+1w1ySB1I2DESqZlAzCT0eCHicoWP04jXzc2iC5098iQUJ3bwcvoIE/y9XmI1t2TSZ0vi1JEfPiSa9oCcTcDRq21TsfCY/IiNvI7VqxMS5kh6AxXUGM4jRpnPjkyKrtOJyWlXvXArg3p518JdEHOhau43vW8Np8SZL3iwG/5R2EocfdwovEuf37pn/kgJCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gbFpHdZwY8kGJ/JyBh9L4SHh6+reddGc6V33jNMA2Y=;
 b=reuMHv/qfdmqppn0bW0UDEmiCjkJk2jkIFx8IRxBuG3m9VJWgOT1t5PIRboH51X76+P/VtpbaZkPz9J+m+Srmnw4FT4NMDPPtlCq74pMbm/48ac+Z6p+0zb9LqIBW+jQGYYDWTsWh24B3dvPwUHlciQ5eDKrUKs2D7EdGKbDQwTsWKJjzvn4nDsE85vM2MLDjIvwEkfKdRacRU81DiPdY8/pt1MlSPn1+tlWexkGF3WIrnZ/UG9UQxazOZ1eopEbC5FgAWG53xMCAG5J52CypdKTTOA7P1+stB6wLa9DBJPiVnc8qIvHc+AMxXxY5bCC8qFLpz0mXg95Q/Pj/uOuUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gbFpHdZwY8kGJ/JyBh9L4SHh6+reddGc6V33jNMA2Y=;
 b=xaI1GKn7NtIG0GEVn1U6rs8WbXxJGLRB3xcBUmEGusgvM+PBBYGmgN7pRtw3xo9na7puAJUWBu2Ed5Pn5LDHOJegROKXDkYQGJo3IZTU5CJu4hTmMFFhk7d9bB9J/rcmCea/EzcPe+p02cq4sQVMboDSD1UidzZNApX/ALeCR2E=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by CY5PR12MB6646.namprd12.prod.outlook.com (2603:10b6:930:41::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 14:49:16 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%6]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 14:49:16 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: "Manwaring, Derek" <derekmn@amazon.com>, "jackmanb@google.com"
	<jackmanb@google.com>
CC: "bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"pawan.kumar.gupta@linux.intel.com" <pawan.kumar.gupta@linux.intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>, "mlipp@amazon.at"
	<mlipp@amazon.at>, "canellac@amazon.at" <canellac@amazon.at>
Subject: RE: [PATCH v2 19/35] Documentation/x86: Document the new attack
 vector controls
Thread-Topic: [PATCH v2 19/35] Documentation/x86: Document the new attack
 vector controls
Thread-Index: AQHbMDg1JLBBlMsMQUStBRLaO7h7dbKqT+jQgApQQICAALKckA==
Date: Wed, 13 Nov 2024 14:49:16 +0000
Message-ID:
 <LV3PR12MB92653467FCBB04AB236DBB5B945A2@LV3PR12MB9265.namprd12.prod.outlook.com>
References:
 <LV3PR12MB92658EA6CCF18F90DAAA168394532@LV3PR12MB9265.namprd12.prod.outlook.com>
 <f3ddabdc-39fa-45fa-97fd-d8508c2229c9@amazon.com>
In-Reply-To: <f3ddabdc-39fa-45fa-97fd-d8508c2229c9@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=7ec1c342-61f0-4049-ba67-18a7f9140290;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-13T14:37:44Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|CY5PR12MB6646:EE_
x-ms-office365-filtering-correlation-id: 0cdadacb-5b46-439d-de01-08dd03f258c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YjZJVXVlSWNtTG1KSGxWUU0xL1hVSjFkVWhRcitZUTNwYmFDUEdqRUZ0aFpK?=
 =?utf-8?B?Zm1pVW8yYmU4SllBSTdLZ1pJb0l0UW11UXNFdHpRRHJnZTBaTlBUMmtrcDg3?=
 =?utf-8?B?SlVVd3ZkUmMrVFAyM01yNjlTejJGOU5uWWlmbnd5bHBsU2xXOGZQaUEyck1J?=
 =?utf-8?B?NGdvc3ZlVjhMb3dvYngwR2VnNUVqdVF0VWdNaHhIVjVTb1NjS3NiL0JXL0pG?=
 =?utf-8?B?UW5jVWlTT2dwNnZCQ1NOUWhrQ013d2xJQ1lRSlhmalZZc1doblFzSG04Vm9Y?=
 =?utf-8?B?V3JaeVJJZ00wak5tRysyMVBmaUphU0FsUWpSZ0JVb2RhYm5NMis2NFNkTWtS?=
 =?utf-8?B?ZWtZclNsT1hXcUd3RzNhTERoNHU1Nmo2ZXNmUjZ5cWF0ajhaQzRiRXErNm01?=
 =?utf-8?B?MytJeGNram02bi81TTFZMnBrd1VhMEsySk95ODVZcWJjQmZBSm1pRWM2NkdZ?=
 =?utf-8?B?dEZUblBvTEN3OG5XMzNFZC95MGdWbTN0V0NMcDgwM3ByZ1V5TmEyWlFqS3JP?=
 =?utf-8?B?UzRzMFNoWTAvUk4rNWRncWpsWG9mZkdKeXZXT3ZOVjB6a1dtQVVXU3JQWlFl?=
 =?utf-8?B?UVBTSVlvTmRMVGZwMFF6V3FmbGxLa09WZ1VubWVpMUs0eDBIRG5qTUdldDl5?=
 =?utf-8?B?d21seFFRVkw2SEM0bWc2TGlQNWU5UExkaytEY1c4QWxZdll4Z1VPTU05akhn?=
 =?utf-8?B?RFFOM04xL3I1dk1hb3Izb3VRNytLUmlHbWRxUEFGSW9OTW5PL3FiZ25PQ0Fo?=
 =?utf-8?B?cEVzY2g0TEpPYzN2cTY0K3hycDh5blRlTldYbHptLytYQVpPLytzY1RBOExo?=
 =?utf-8?B?UWpDTHRPZXNwTnRrRS9zMTZGV2xGUnd3NlRkMjhBTVVYVUlZSkV2cVlTcGlv?=
 =?utf-8?B?RDdKano4eTFBU01iSlFncXYwV1p0NEpPNCtVWnN5cC9MTDBHdzdmZ2ZBQXc0?=
 =?utf-8?B?c1RXVlhsR1p4WGFqUWphK3Nmbm9BUFhCT1pQSWQwNSt5cm1aakMyN09ZVlZv?=
 =?utf-8?B?ZEVGMi83WDFKREhUTVRpRE5odHRXMFBSZmluaXB1TlJoaVY3OU1pSy9GV1FJ?=
 =?utf-8?B?VCsyQ1h0TFJjdFVvdk8yUmdDaHEzaFJUZUgzR0p1QWloK2QwZ2RrZW5hSUc0?=
 =?utf-8?B?Y1VnYnNpNjJ0Z3A1MytqZWRPajhVQUpTU0JMUHhCSEtZeWllRmpHZEV1bWQ4?=
 =?utf-8?B?WWt1R3VxdkR5dGl0VlVkV2F1cjc5dm9xRDhvTFk0MkRhdUF6Q2htSEl5MFZS?=
 =?utf-8?B?eFhmZmRQYzNzM2dOYUlMbmlHUWZiS3pTeGIzdlB2SmQyQ2xYdFBnTHhxdjlQ?=
 =?utf-8?B?ZndLSlhobkt4azBtY3llOWZDditYcm5nWmdZS3hkTUYvZE9HR3dFMVpXVXZG?=
 =?utf-8?B?V00yS1lzcmorWUdWdVgybk1ONkR4SHRRNzdpSnVpNGtaYWdzYW5YRWg1emxF?=
 =?utf-8?B?K01KaWVwYjRDbzg0Sjg0cHFibzFjRjkrY0gyOGFmcENQcUc5aGJVTFVseVpS?=
 =?utf-8?B?Y0hwUzZBMVhYVm9jK0NPaDYvS2hmcEt3MXNvWmV1RnpSeEI3R3ZvTWt0RUNv?=
 =?utf-8?B?WUhreksvSmlhSmFlY3g1aytiQ2JZNFpmT1A0aTFOcG5MZUNaZk9ySlBNN2pH?=
 =?utf-8?B?ZFRha25ocEVNUWMzZ1djOTgrc1l4ZkxHU05VVkRGUWNqVTAxa3FjbkVmeS9j?=
 =?utf-8?B?YVhOQWpkMERiZUVIUTZaNTh0cERrZ2lSWE90TVVHMy8vUUk1UEdpUU90bkdX?=
 =?utf-8?B?S0JxVTRCS1VUY0c3bitzclZybUh0cldtUnNQUzdsbFVYbmhlTTZaZmdnY0Fi?=
 =?utf-8?Q?KQ5Cp+q7JKu2PTGAQ8vXhPobnjGdD0bYbp0Cc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MGZyc1BMVmM0UkJuSXpNaGhwVThIRVNta0U2ZE1hamtQcXl6cEViRjVnNkpR?=
 =?utf-8?B?ckQwcFQ5blR3OVJOMy9EYUlULzJGOEZ6VWk5a2dBdU9mcU9aejlWZDlOYkt2?=
 =?utf-8?B?NlZiQmtpUW94VDZISVoxUUpaZnRQWmszQkVlYWltV2ZMV0VZZXZEZHNiSHVO?=
 =?utf-8?B?elZycndRMThzSng5aG83Ym0wTkV0Y2R1TkVMaUF0ZnBIVXRPbTFtcllpSjlY?=
 =?utf-8?B?K2ZUSEllQzJPWCtQaXVjVHo4MHBQTWM0SUxrbzBoeFlTc2lvUEdnVU1LNFBU?=
 =?utf-8?B?VnRraU1aTEN3eFU0aktYZm5tVjEvTGtkV2xmN2twKzh3ZmRWd1QrZHFEc25Q?=
 =?utf-8?B?akNPYXI0WURpaVZ5OXcrSmsvamtycUZzaFh3SGlLRkgwUkJXVElLQXNIM3FQ?=
 =?utf-8?B?d3dmTStpdm44RGJ6elFQOEJCVmxZc0VSWGk4YU15QzNJSXBkblB4OUJZdE53?=
 =?utf-8?B?ZFV4TmNvQStmTU9tU1NpZVpTeFhrT2s5cm93S0ZXaHp2ejV1OEt2UzBQSHBn?=
 =?utf-8?B?VUlVQk82NGxLcFlMZ0JDemVqbTZKSk5LM3ZUNzhlS1BHenhzRGkxTFRNQ1Zw?=
 =?utf-8?B?Y1JaRmFNb0NRWTYzb0VOT3hFKzM2K1pRdmRldjI4ZUQ0WVl0eW4wRWp2NWpN?=
 =?utf-8?B?Ly9nMUJzUWZSUFJ1aEVNL1Z2cHoyS2NtTnpWRWhud3NXT3QzVVl0Q204Q0pJ?=
 =?utf-8?B?bG5JYWUrYzRLc2J1bWRZSEpuK1MzSXlhM2trUHdhaVZFbUZWY2RJOUJ5b2NJ?=
 =?utf-8?B?MVlyN3JWOXlqdXFUNzhTeFp5TTF4UzVrdUJRVTNTRkN3OFlmeGVJSXNlZW55?=
 =?utf-8?B?L21INnNCN3c0cDV5bHlmT1hnMTZ3WGVNdFljOVJRanI3YkRwZGJJWFpHMjh2?=
 =?utf-8?B?RGdVSzNESE9pZFd3MEhxOExraDhXbkt5RHFyM2pmcG52VmtmZVNjVnpCdENF?=
 =?utf-8?B?RklqbEZKNGZ4V2VnNlk3NUp4U1ZyeE5iazVUNlYrOUUvbnNUWlc3a1BXb3g3?=
 =?utf-8?B?UG16ZFkyREhQdHhPYklUb25QemZCOVVUYlVQV0szbGY1UlF3aU1XVTBNdW1k?=
 =?utf-8?B?Tk1nWUNRMHlVRHh5Yk1VUUMvaFIvam9GZ2NCWHA5SDdEZHdYY0lwck95VWF1?=
 =?utf-8?B?ekcwajFEOWlDamg1ZTVTZDQ0STROa0QyM3FGK1BzeUVGdk10RitaQTZiRG90?=
 =?utf-8?B?ZE1KQTVsR0pwR2p6SDNZaXkweXU3aXdaMFBmZ0RwSG5CcTZvNkY5eEg1enE5?=
 =?utf-8?B?b0pVU2xsSlpCQU93TVY2ZzROSFdJNnJVQVc4UlNyenBXSTRrZTZMbUozSHpw?=
 =?utf-8?B?YkZrSTROVnpVdElQSXYvRTJRdDFYWHdVemhQeDBiZDQ5emR6TmxtU2hMQ21O?=
 =?utf-8?B?bHNjUExzYkJnbXdQcnlIL0FodHFxQVNBYlJYSEpjSVUrNCtOK2FNdlZQeG5D?=
 =?utf-8?B?d0h2L0IvVHZMOENyV2hhOWwvWTNPUWZFVEhuaTVKTnZzbmdIRTR6L3doK0VC?=
 =?utf-8?B?OVZoanQ1SkhWYTk2SzE2STdERWZmVTdQWFI4dGxIenFrbVQwS254dUgwRCtu?=
 =?utf-8?B?N09SdnF5Z2czRE51c1hBNlY5bW1mM2cyU0UyZjBpTjhnMXVFWC9ybGtmV2JG?=
 =?utf-8?B?SEJMb0J4a0s0TENMR0RHdytSaStJYk9MTlczczNIM2QxN2taT294NmRFM1Uv?=
 =?utf-8?B?WVMyY2VMVWlpNGtacTVlaldCTlJnUkpDRHA2VTlLM2FFVitCQ1JqSGdlblJO?=
 =?utf-8?B?WTJBaGp1aE5Rd0ZuVEtDQmp1c0FpMGY0MFlVWGpNVVlYNm4wWERPdXJvVTZn?=
 =?utf-8?B?c21hQ3hqemFqZVpvTXZPQ2orbXhyeE5QNmZRaklIMllTM1UrZkRJdnZaRGE5?=
 =?utf-8?B?ZlpEMjRsOUV1c1ZUYjJVUDk2UUR4dkl4VlJGc25obURsbDA4MlArc3NrQTFH?=
 =?utf-8?B?N0xPWlFkaUk1bDhDeFkvQ2ZGYTJKT2VqT29kZSs3V3A4aDBoUFFIem52SHpK?=
 =?utf-8?B?L2tKZlRoNDcyUG5SRUdaYUdGQUcwblQ3QlVjQkhqZWpxOGZpdDZlOHlkTE5m?=
 =?utf-8?B?WHcvUHBCbTNja29uOHFZYVMyQTA5Y2dDMENRbjVobHQ1TVY4ZnIrNlVDRUNt?=
 =?utf-8?Q?IWCI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9265.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cdadacb-5b46-439d-de01-08dd03f258c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 14:49:16.2284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Swj+8SPUj1Mg0q3MPKNBsAaWh5itzJ/Ch+wV/7+kvYFh+nXv1piNT3VZORMM3WzD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6646

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYW53YXJpbmcsIERlcmVr
IDxkZXJla21uQGFtYXpvbi5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDEyLCAyMDI0
IDk6NTggUE0NCj4gVG86IEthcGxhbiwgRGF2aWQgPERhdmlkLkthcGxhbkBhbWQuY29tPjsgamFj
a21hbmJAZ29vZ2xlLmNvbQ0KPiBDYzogYnBAYWxpZW44LmRlOyBkYXZlLmhhbnNlbkBsaW51eC5p
bnRlbC5jb207IGhwYUB6eXRvci5jb207DQo+IGpwb2ltYm9lQGtlcm5lbC5vcmc7IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7IG1pbmdvQHJlZGhhdC5jb207DQo+IHBhd2FuLmt1bWFyLmd1
cHRhQGxpbnV4LmludGVsLmNvbTsgcGV0ZXJ6QGluZnJhZGVhZC5vcmc7IHRnbHhAbGludXRyb25p
eC5kZTsNCj4geDg2QGtlcm5lbC5vcmc7IG1saXBwQGFtYXpvbi5hdDsgY2FuZWxsYWNAYW1hem9u
LmF0DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggdjIgMTkvMzVdIERvY3VtZW50YXRpb24veDg2OiBE
b2N1bWVudCB0aGUgbmV3IGF0dGFjaw0KPiB2ZWN0b3IgY29udHJvbHMNCj4NCj4gQ2F1dGlvbjog
VGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQgZnJvbSBhbiBFeHRlcm5hbCBTb3VyY2UuIFVzZSBwcm9w
ZXIgY2F1dGlvbg0KPiB3aGVuIG9wZW5pbmcgYXR0YWNobWVudHMsIGNsaWNraW5nIGxpbmtzLCBv
ciByZXNwb25kaW5nLg0KPg0KPg0KPiArQnJlbmRhbg0KPg0KPiBPbiAyMDI0LTExLTA2IGF0IDE0
OjQ5KzAwMDAsIERhdmlkIEthcGxhbiB3cm90ZToNCj4gPiBPbiAyMDI0LTExLTA2IGF0IDEwOjM5
KzAwMDAsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gPiA+IE9uZSBvZiB0aGUgYXJndW1lbnRz
IGFnYWluc3QgdGhvc2UgZ2V0dGluZyBtZXJnZWQgaXMsIHRob3NlIGFyZSBub3QNCj4gPiA+IGdv
aW5nIHRvIGJlDQo+ID4gPiAqdmVjdG9yKiBjb250cm9scyBhbnltb3JlIGJ1dCBzb21ldGhpbmcg
ZWxzZToNCj4gPiA+DQo+ID4gPiBtaXRpZ2F0ZV91c2VyIC0gdGhhdCB3aWxsIG1pdGlnYXRlIGV2
ZXJ5dGhpbmcgdGhhdCBoYXMgdG8gZG8gd2l0aA0KPiA+ID4gZXhlY3V0aW5nIHVzZXIgcHJvY2Vz
c2VzDQo+ID4gPg0KPiA+ID4gbWl0aWdhdGVfZ3Vlc3QgLSBzYW1lIGJ1dCB3aGVuIHJ1bm5pbmcg
Z3Vlc3RzDQo+ID4gPg0KPiA+ID4gVGhlIHRoaXJkIG9uZSB3aWxsIGJlIHRoZSBTTVQgb2ZmOiBt
aXRpZ2F0ZV9jcm9zc190aHJlYWQuDQo+ID4NCj4gPiBSaWdodCwgc28gdGhlIHdheSBJIHRoaW5r
IG9mIHRoaXMgaXMgdGhhdCB0aGVyZSBpcyBhIGNvZ25pdGl2ZSBwcm9jZXNzDQo+ID4gdGhhdCBh
ZG1pbmlzdHJhdG9ycyBtdXN0IGdvIHRocm91Z2g6DQo+ID4NCj4gPiAxLiBEZXRlcm1pbmUgaG93
IHRoZSBzeXN0ZW0gd2lsbCBiZSB1c2VkIChlLmcuLCBhbSBJIHJ1bm5pbmcgdW50cnVzdGVkDQo+
ID4gICAgVk1zPykNCj4gPiAyLiBEZXRlcm1pbmUgdGhlIGF0dGFjayB2ZWN0b3JzIHJlbGV2YW50
IGZvciB0aGF0IGNvbmZpZ3VyYXRpb24gKGUuZy4sDQo+ID5JDQo+ID4gICAgbmVlZCBndWVzdC0+
aG9zdCBhbmQgZ3Vlc3QtPmd1ZXN0IHByb3RlY3Rpb24pICAzLiBEZXRlcm1pbmUgd2hpY2gNCj4g
Pm1pdGlnYXRpb25zIGFyZSByZXF1aXJlZCB0byBlbmFibGUgdGhlIGRlc2lyZWQgbGV2ZWwNCj4g
PiAgICBvZiBzZWN1cml0eSAoZS5nLiwgZW5hYmxlIHZ1bG5lcmFiaWxpdHkgWCBtaXRpZ2F0aW9u
IGJ1dCBub3QgWSkNCj4gPg0KPiA+IFRvZGF5LCB0aGUgYWRtaW5pc3RyYXRvciBtdXN0IGRvIGFs
bCAzIG9mIHRoZXNlLCB3aGljaCByZXF1aXJlcw0KPiA+IGluLWRlcHRoIGtub3dsZWRnZSBvZiBh
bGwgdGhlc2UgYnVncywgYW5kIGlzbid0IGZvcndhcmQgY29tcGF0aWJsZS4NCj4gPiBUaGUgcHJv
cG9zZWQgcGF0Y2ggc2VyaWVzIGhhcyB0aGUga2VybmVsIHRha2UgY2FyZSBvZiBzdGVwIDMsIGJ1
dA0KPiA+IHN0aWxsIHJlcXVpcmVzIHRoZSBhZG1pbmlzdHJhdG9yIHRvIGRvIHN0ZXBzIDEgYW5k
IDIuICBUaGUgcHJvdmlkZWQNCj4gPiBkb2N1bWVudGF0aW9uIGhlbHBzIHdpdGggc3RlcCAyLCBi
dXQgdWx0aW1hdGVseSB0aGUgYWRtaW4gbXVzdCBkZWNpZGUNCj4gPiB3aGljaCBhdHRhY2sgdmVj
dG9ycyB0aGV5IHdhbnQgdG8gdHVybiBvbi9vZmYuICBCdXQgdGhlIGF0dGFjayB2ZWN0b3JzDQo+
ID4gYXJlIGFsc28gZm9yd2FyZCBjb21wYXRpYmxlIGluIGNhc2UgbmV3IGJ1Z3Mgc2hvdyB1cCBp
biB0aGUgZnV0dXJlLg0KPiA+DQo+ID4gV2hhdCB5b3UndmUgcHJvcG9zZWQgaXMgdXAtbGV2ZWxp
bmcgdGhpbmdzIGEgYml0IGZ1cnRoZXIgYW5kIHRyeWluZyB0bw0KPiA+IGhhdmUgdGhlIGtlcm5l
bCBkbyBib3RoIHN0ZXBzIDIgYW5kIDMgaW4gdGhlIGFib3ZlIGZsb3cuICBUaGF0IGlzLCB0aGUN
Cj4gPiBhZG1pbiBkZWNpZGVzIGZvciBleGFtcGxlIHRoZXkgaGF2ZSB1bnRydXN0ZWQgdXNlcnNw
YWNlLCBhbmQgdGhlDQo+ID4ga2VybmVsIHRoZW4gZGV0ZXJtaW5lcyB0aGV5IG5lZWQgdXNlci0+
a2VybmVsIGFuZCB1c2VyLT51c2VyDQo+ID4gcHJvdGVjdGlvbiwgYW5kIHRoZW4gd2hpY2ggYnVn
IGZpeGVzIHRvIGVuYWJsZS4NCj4gPg0KPiA+IEknbSBub3QgbmVjZXNzYXJpbHkgb3Bwb3NlZCB0
byB0aGF0LCBhbmQgd2VsY29tZSBmZWVkYmFjayBvbiB0aGlzLg0KPiA+IEJ1dCBhcyB5b3Ugc2Fp
ZCwgdGhhdCBpcyBub3QgYW4gYXR0YWNrLXZlY3RvciBjb250cm9sIGFueW1vcmUsIGl0IGlzDQo+
ID4gbW9yZSBvZiBhbiBlbmQtdXNlIGNvbnRyb2wuICBJdCBpcyBwb3NzaWJsZSB0byBkbyBib3Ro
Li4ud2UgY291bGQgYWxzbw0KPiA+IGNyZWF0ZSBlbmQtdXNlIG9wdGlvbnMgbGlrZSB0aGUgb25l
cyB5b3UgbWVudGlvbiwgYW5kIGp1c3QgbWFwIHRob3NlDQo+ID4gaW4gYSBwcmV0dHkgdHJpdmlh
bCB3YXkgdG8gdGhlIGF0dGFjayB2ZWN0b3IgY29udHJvbHMuDQo+DQo+IEkgdGhpbmsgdGhlIGZ1
cnRoZXIgc2ltcGxpZmljYXRpb24gbWFrZXMgc2Vuc2UgKG1lcmdlIHRvIG1pdGlnYXRlX3VzZXIg
b3INCj4gbWl0aWdhdGVfZ3Vlc3QpLiBJIHdvdWxkIHNheSBkZWZpbml0ZWx5IGRvbid0IGRvIGJv
dGggKGVuZGluZyB1cCB3aXRoIGVuZC11c2UsIHZlY3Rvcg0KPiBjb250cm9scywgKmFuZCogZXhp
c3RpbmcgcGFyYW1ldGVycykuIEJvdGgganVzdCBzZWVtcyBsaWtlIG1vcmUgY29uZnVzaW9uIHJh
dGhlcg0KPiB0aGFuIHNpbXBsaWZpY2F0aW9uIG92ZXJhbGwuDQo+DQo+IEZvciBtZSB0aGUgbWFq
b3IgZGlzc29uYW5jZSBpbiBhbGwgb2YgdGhpcyByZW1haW5zIGNyb3NzX3RocmVhZC4gQmFzZWQg
b24gZWl0aGVyDQo+IGFwcHJvYWNoIChlbmQtdXNlIG9yIHZlY3RvciksIFNNVCBzaG91bGQgYmUg
ZGlzYWJsZWQgdW5sZXNzIHRoZSBhZG1pbiBleHBsaWNpdGx5DQo+IGFza3MgdG8ga2VlcCBpdCAo
cHJlc3VtYWJseSBiZWNhdXNlIHRoZXkgYXJlIHJ1bm5pbmcgd2l0aCBjb3JlIHNjaGVkdWxpbmcN
Cj4gY29ycmVjdGx5IGNvbmZpZ3VyZWQpLg0KDQpDcm9zc190aHJlYWQgaXMgY2VydGFpbmx5IGEg
dW5pcXVlIG9uZS4gIFRoZSBwaGlsb3NvcGh5IExpbnV4IGFwcGVhcnMgdG8gaGF2ZSB0YWtlbiBp
biBnZW5lcmFsIGlzIHRvIGFsd2F5cyBtaXRpZ2F0ZSB0aGVzZSBraW5kcyBvZiBidWdzIGJ5IGRl
ZmF1bHQsIHVubGVzcyBkb2luZyBzbyByZXF1aXJlcyBkaXNhYmxpbmcgU01ULiAgT3RoZXJzIGhl
cmUgbWF5IGtub3cgdGhlIGhpc3RvcnkgYmV0dGVyLCBidXQgSSBwcmVzdW1lIHRoYXQgZGVjaXNp
b24gd2FzIG1hZGUgYmVjYXVzZSBvZiB0aGUgcGVyZm9ybWFuY2UgaW1wYWN0IG9mIGRpc2FibGlu
ZyBTTVQsIGFuZCB0aGUgZmFjdCB0aGF0IGl0IHdvdWxkIGJlIGhpZ2hseSBkaXNydXB0aXZlIHRv
IHVwZGF0ZSB5b3VyIGtlcm5lbCBhbmQgZmluZCBoYWxmIHlvdXIgY29yZXMgaGF2ZSBkaXNhcHBl
YXJlZC4gIFN0aWxsLCBpdCBjcmVhdGVzIGFuIGluY29tcGxldGUgc2VjdXJpdHkgc3RvcnkuDQoN
CkJ1dCB5b3UgZG8gcmFpc2UgYW4gaW1wb3J0YW50IHBvaW50IHdoaWNoIGlzIHRoYXQgdGhlIHJl
bGV2YW5jZSBvZiBjcm9zcy10aHJlYWQgcHJvdGVjdGlvbiBpcyBhbHNvIGRlcGVuZGVudCBvbiB0
aGUgc2NoZWR1bGluZyBwb2xpY3kgc2luY2UgdGhlc2UgYXR0YWNrcyByZXF1aXJlIHRoZSB2aWN0
aW0gYW5kIGF0dGFja2VyIHRvIGJlIHJ1bm5pbmcgb24gc2libGluZyB0aHJlYWRzLiAgSWYgc2No
ZWR1bGluZyBwb2xpY3kgcHJvaGliaXRzIHRoYXQsIHRoZW4gZGlzYWJsaW5nIFNNVCBpcyBub3Qg
cmVxdWlyZWQuICBCdXQgdGhlIGtlcm5lbCBkb2Vzbid0IGtub3cgaWYgdGhhdCB3aWxsIGJlIGFk
aGVyZWQgdG8uICBIZW5jZSB3aHkgSSB0aGluayBjcm9zcy10aHJlYWQgaGFzIHRvIGJlIGhhbmRs
ZWQgc2VwYXJhdGVseS4gIEl0IHdvdWxkIGhhdmUgYXJndWFibHkgbWFkZSBzZW5zZSB0byBkaXNh
YmxlIFNNVCB1bmxlc3MgdGhlIGFkbWluIGFza3MgdG8ga2VlcCBpdCwgYnV0IHRoYXQgc2hpcCBJ
IHRoaW5rIGhhcyBzYWlsZWQgYW5kIHRoaXMgZG9lc24ndCBzZWVtIGxpa2Ugc29tZXRoaW5nIHdl
IGNhbiBjaGFuZ2Ugbm93Lg0KDQo+DQo+IFdoYXQgaWYgbWl0aWdhdGVfdXNlcl91c2VyIGRlZmF1
bHRlZCB0byAnZGVmYXVsdHMnIGluc3RlYWQgb2YgJ29uJz8gSSdtIHRoaW5raW5nDQo+ICdkZWZh
dWx0cycgbWVhbmluZyAiZG8gdGhlIHRoaW5ncyB0aGUga2VybmVsIG5vcm1hbGx5IGRpZCBiZWZv
cmUgdGhpbmtpbmcgaW4gdGhlc2UNCj4gYXR0YWNrLXZlY3RvciB0ZXJtcy4iIFRoYXQgd2F5IHdl
IGNvdWxkIGRpZmZlcmVudGlhdGUgYmV0d2VlbiAiYWRtaW4gZGlkbid0IHNwZWNpZnkNCj4gYW55
dGhpbmciIGFuZCAiYWRtaW4gc2FpZCB0aGV5IGNhcmVkIGFib3V0IG1pdGlnYXRpbmcgdGhpcyB2
ZWN0b3IgKG9yIGNhc2UpLiIgVGhhdA0KPiBzaG91bGQgbWFrZSBpdCByZWFzb25hYmxlIHRvIGRp
c2FibGUgU01UIHdoZW4gbWl0aWdhdGVfdXNlcl91c2VyPW9uIGlzIHN1cHBsaWVkLA0KPiB5ZWFo
Pw0KPg0KDQpIbW0uICBJIGRvbid0IHJlYWxseSBsaWtlIHRoZSBuYW1lICdkZWZhdWx0cycsIGFs
dGhvdWdoIEkgY291bGQgZW52aXNpb24gc29tZXRoaW5nIGxpa2UgJ3BhcnRpYWwnIG1lYW5pbmcg
ZG8gd2hhdCB3ZSBkbyB0b2RheSwgd2hpbGUgJ29uJyBtZWFucyBkaXNhYmxlIFNNVC4gIEJ1dCBJ
IGRvIHdvcnJ5IHRoYXQgaWYgdGhlcmUgYXJlIHRvbyBtYW55IG9wdGlvbnMgdGhhdCBzZWNyZXRs
eSBkaXNhYmxlIFNNVCB1bmRlciB0aGUgaG9vZCwgaXQgd2lsbCBiZSBjb25mdXNpbmcgZm9yIHVz
ZXJzLiAgUGx1cyB5b3UgaGF2ZSB0aGUgZm9yd2FyZCBjb21wYXRpYmlsaXR5IHdvcnJ5Li4udGhl
IGF0dGFjayB2ZWN0b3JzIGFyZSBkZXNpZ25lZCB0byBiZSBzdGFibGUgZXZlbiBhcyBuZXcgYnVn
cyBhcHBlYXIuICBJIGNvdWxkIGltYWdpbmUgdXNlcnMgdG9kYXkgY2hvb3NpbmcgdG8gZW5hYmxl
IG1pdGlnYXRlX3VzZXJfdXNlciBidXQgaWYgYSBuZXcgYnVnIHNob3dzIHVwIGluIHRoZSBmdXR1
cmUgdGhhdCByZXF1aXJlcyBkaXNhYmxpbmcgU01ULCBhbGwgb2YgdGhlIHN1ZGRlbiB0aGV5IGxv
c2UgaGFsZiB0aGUgY29yZXMgb3Zlcm5pZ2h0IGFnYWluLg0KDQpLZWVwaW5nIHRoZSBTTVQgZGlz
YWJsZW1lbnQgdW5pcXVlIHRvIHRoZSBtaXRpZ2F0ZV9jcm9zc190aHJlYWQgY29udHJvbCBJIHRo
aW5rIG1ha2VzIGl0IG1vcmUgb2J2aW91cyB0byB1c2VycyB3aGV0aGVyIHRoZXJlIGlzIGEgY2hh
bmNlIFNNVCBjb3VsZCBnZXQgdHVybmVkIG9mZi4NCg0KVGhhbmtzDQotLURhdmlkIEthcGxhbg0K

