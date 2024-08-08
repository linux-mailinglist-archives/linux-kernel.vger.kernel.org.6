Return-Path: <linux-kernel+bounces-279376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1922294BC87
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 13:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 189DA1C21AE5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 11:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AAB18C324;
	Thu,  8 Aug 2024 11:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="mqFL2Eyz"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC84145FE0;
	Thu,  8 Aug 2024 11:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723117942; cv=fail; b=V6bqppu1RjN8r+VP30iuZFZUy+h+vINSuquAwMhxhUo0RtnUdNloKtaFVLR/ygtVepL4rFXEw0QH24gPVwKD4jzbBAqmgz2ZlEBxA59hDIoXHKJpdFQ235HKC5aWDSiWHCao0u2mLBmpUn6jLtCwgLVv3rvDlxdP3eUaK/JpPL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723117942; c=relaxed/simple;
	bh=TCVQN2xvY502dQUSLUdw18cxnKlTvIANMKjAE7j+z1c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ql3fNeeeDMef625A6sSeUYwjwnrmsOTMZKGi0YWKrw8PcGt7SFNArAHdqcQLkCmv6n3KEQktrH9J7vGq4ldvdhWnO3qp/cPnbMjUNYzhvel+VdH+Tvkw0rZ9gPCIdvCcsL86qMWvyOcP/mXJMsxNK8+88xKqHdMhMMOiBSJIhnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=mqFL2Eyz; arc=fail smtp.client-ip=40.107.237.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AWeNSF4TfLtyJZmrk/bAJYuF9B0i38DnifBSmDdT1xYivcq9sLRzjShMufgFUatkOLXec4yrhkppqKD1oOQ0n05EfLuzykzqMqLjpXjedqOVNtIQXSHxWnbq/Q44VN+fo7fehcosM3csSRcXHmx1m/tU5+jSCOgvdUL9jn4WqAYFF3VR3OBHkGGjHACeJAxp0UYF6pQwbwu2YMNhCOqz5SWFRcmteUbGxWgkqFJ0NXFEop+j8twjaiAmxMwB66HUCGSYuJUMS/Mjuy3feA0Ju/1GvcZ8/zqfKjWeYH9Ym6tV6v5r9vc3iancFXxLA2uWQNNvtquuy6Bo2O/tha9D5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TCVQN2xvY502dQUSLUdw18cxnKlTvIANMKjAE7j+z1c=;
 b=inm6k0+LkEQzCU+jCWrTrZZJmA+lQi6lygx7iUTIFnVMtV/iBKSvWYR/65PMq4AE/qtq56SXi0hqk+aHECBa8i4DltJ1SuM46bZ+JpZO5TbURdCQaTrGlhRPfGqkSawHQJ/JFP2nj9N89zkDbAo42g4UUV++qlRlNq418hSDaRQBnVe7pRisbtd1yg3B9UYYtrn0sjvIbXF1q09ludU4xXWtDVVvwtc2IY1t2WwGyk+AeY5udAeIkkfVXEJhSFZlE5jZnuSeWN6RDa/yO5gxIU6TSwtxKivlI8eXv3LfifQpqFoZu0llLkqqQRJuN4sFS9jMLHl0XmmhnZKumMeM2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCVQN2xvY502dQUSLUdw18cxnKlTvIANMKjAE7j+z1c=;
 b=mqFL2Eyz93AGcjVY8O6M2Qhd0tpWWYN4v0pkslMUg5oSWVFTbbq3XBcHLPYzp1JbSAp1denRcWtjc804/jCqatLjIJ63Qd/dNO+GhDIJBUrwLu/BwEUzvMolbcEFCVCgLeRVa8c9Vm8LKcasbpjJBlgDQModm2vf9BdukLIC2qTpWw1PPTuimXTI9xtUgZFce0u+AebMqKMMidhNMm9+jK+Z7aK/0h1F6EPIBumbS6dv/l3fjR5/Ud/J8+JAFEUKAEgHQJY67C+o0mFEa+p4uq/m3uxgPDjTsk7G6IR6XOW0Z4/bQXfUQJQfkA8xd2tAgkQ2gqNIDhPZCSN3H4ebYQ==
Received: from BN9PR11MB5289.namprd11.prod.outlook.com (2603:10b6:408:136::10)
 by DS0PR11MB7192.namprd11.prod.outlook.com (2603:10b6:8:13a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29; Thu, 8 Aug
 2024 11:52:16 +0000
Received: from BN9PR11MB5289.namprd11.prod.outlook.com
 ([fe80::93b4:c87a:32b4:c395]) by BN9PR11MB5289.namprd11.prod.outlook.com
 ([fe80::93b4:c87a:32b4:c395%3]) with mapi id 15.20.7828.029; Thu, 8 Aug 2024
 11:52:16 +0000
From: <Andrei.Simion@microchip.com>
To: <linux-arm-kernel@lists.infradead.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/6] regulator: mcp16502: Add supplier for regulators
Thread-Topic: [PATCH 1/6] regulator: mcp16502: Add supplier for regulators
Thread-Index: AQHa5LhEn97L1tgXxECJyG0oBvR81bIT7XGAgAAYs4CAADuWgIAJB6iA
Date: Thu, 8 Aug 2024 11:52:16 +0000
Message-ID: <fa6c3079-517c-4874-96ae-35da7674b536@microchip.com>
References: <20240802084433.20958-1-andrei.simion@microchip.com>
 <20240802084433.20958-2-andrei.simion@microchip.com>
 <98f91a56-946c-4a40-b908-45f4c6c6d66e@sirena.org.uk>
 <f318439f-b520-4b86-99a7-eb9a2e47525f@microchip.com>
 <e0db4f2b-ce4f-4560-b586-1d8dbb75c7ff@sirena.org.uk>
In-Reply-To: <e0db4f2b-ce4f-4560-b586-1d8dbb75c7ff@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5289:EE_|DS0PR11MB7192:EE_
x-ms-office365-filtering-correlation-id: 5d7d956a-88a6-4f6a-eaa5-08dcb7a08cbb
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5289.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VjcxY3J2bEZWRTZUNHpkamx3RXZ6QzFQaTdkK3QrL3kxSks5bjZxUE1IcVFY?=
 =?utf-8?B?dlVSV29tRkhCWWs4T09FQXI4bk5iSWZDM2V3MXpWeWw4NURQSVk1TDE4WDFm?=
 =?utf-8?B?VG5EVHhrWS9hZ1FtRnlyTXpGcHhIOVFKZ1l0bEt3N3hkVHdxM3dZMHFYZkdC?=
 =?utf-8?B?ckRXQmhidTNMbFZ5TmpnK1FuaE5RSlpKN1pERnZPQXV3dTdkZEx3alFFbU9D?=
 =?utf-8?B?cW8rSXV0Ym9vbnJQMFpud3lCbnZEeGRuYUpES3NCa2pCbFljTGpRMVlxUktJ?=
 =?utf-8?B?VnA4bEgydDlrMlgrcHp6VWd1cnZQd012a2pGL3NKM3ZBb0dOZzcyaW9iVVJX?=
 =?utf-8?B?WmN1T01yemxZNEs4OGJnNHJUUDhscklGVitvYUtPOHhQcVJlbGNZY21oZkRw?=
 =?utf-8?B?ckZYZ1RQcmZLZWpwVzBmcVY3Wko5Njl6NWRXMy9PNGNYWDJZNG40aTdxd3FE?=
 =?utf-8?B?dXg0Z01HU2VScWo0U29zbW1RQTRNV3NoWG8rN0JyWis2cHUvM3AxQTJjUFZo?=
 =?utf-8?B?QTVGSjlDN2hGdjhkY093ZXhVQm9xa0Q0bktRemMwajBHbWE0MWMvTGZlOGZP?=
 =?utf-8?B?VlZ0QkZldG42RmVQQ3ZnSGNBL1BwN2tkWmR4elZJMVM0Rk1ZNXFwRE5aZjNL?=
 =?utf-8?B?blRoTWJrVzJpNXlUOHAvd3oxMUpjNVNaNEtZTXFPajY4T0ptanVZeHg3UHdO?=
 =?utf-8?B?YTc0aTQ2Q1VGc2NzbDNWOWVOVXkybjZZWXc4dHJmd2J3bEFFTmFEYkprdzVZ?=
 =?utf-8?B?eWJFbk5iRE5aQU80RGNNZGNYR0g1MVlvVk9lb2tFWmxweDJnTEdTK0J3WURN?=
 =?utf-8?B?M2dHUklHbWpFK0hwU0JSQUtEMEY4QzBkNmkwMncrTGRaektEQXMxZlQ1YnZi?=
 =?utf-8?B?M0lJbG1VOTRzUWtxTjNKRzcwempCRzlMZHhnRS9vMDJ2Zi93NmI5dTZGazRy?=
 =?utf-8?B?MU9UemphQUJXODN4cExCODZRSjBzUE1uaFVkdFFBZi9kMDdxVEcyN0MxRlhj?=
 =?utf-8?B?YWsvd2VPQkJlYlEyclhDa1JkK3lhRDZzcHhwTkw0UmNYU2pmcmtObUF0Q0hq?=
 =?utf-8?B?RTZMRWpGdEJPdUFCcit0TkRlWGwvbnVZSlBlVjdYaXRUWkNqTjhLUGRwSE12?=
 =?utf-8?B?aSt4Nkx5UjRkL2QrNkE3YzhETzBiQkp3QnV6THhrSmZEV2VZNTFEdnBaM0Fa?=
 =?utf-8?B?VDVZRUJNeldlWXV2cUhhMEx5b1VmelNrK280Vi9lNTltdjBweHBFTjIvZHBD?=
 =?utf-8?B?cnFCU0NwT2I0NmluaGpUMG9rUDRpZW51RjZma1Roa2ZITk9UcXp2cEE0aXVa?=
 =?utf-8?B?MnlVUTZ1VGNrS1pIQ3pOcyt1RytZbExpcEFJekxIWS9SdVMvVDB3UjNDd1hm?=
 =?utf-8?B?WnBVNFgyYzlya0ZTSkhSMmo3OEVOazVGMTI5ZXZLbDVXWVRzYWo5T0xER1hK?=
 =?utf-8?B?TFlGYiswQ29VdlExTHF5WFNibUVrWGhBbnBLUXVHRlExK1BnRWpwWkVrd3gw?=
 =?utf-8?B?NXlTdU5OZEIzN1lKOW5mNXpzNEg3emhUVmFtQXJMbU1nQTFDRTJ3TE95TEl1?=
 =?utf-8?B?TFhlVWNCUUJyeHBVRmZYeVk4dks3WXVOL0lBZ1loRlZ1T05NZGFxMi84emM0?=
 =?utf-8?B?bFNpYlgzZGl1dTNhUm0zWmZoNGZsNTREazA2WXZ2MGE2MVZJMkVqaWZRK1Nq?=
 =?utf-8?B?WWk5NXc3TGpFajJLTVlhMnFUQytZMUErSmg3M2lZYjdvY2w3Q3Z5Tk03MTFm?=
 =?utf-8?B?c1FCcjhrdjhXenF6MXI5b2UxVnUxSWJWQXR2UTBlOGJRSkFsZ3NQY0xFcm9K?=
 =?utf-8?B?OE1SOEwvVUNEUTVlS0hsNmdVcFJncGZ1bUtra2ZQL2d1NDVuTzcvc0p2T3lu?=
 =?utf-8?B?dzBkc1NGU2Vka3lJYndTUFhjVDgwbDFnNVFGa2E0c0dlVUE9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d1BDZ2dDRTBDZG0wOFdQVjc3dUxvaG1YbXQ5Z0F6Y3FSMWEraUllL1J4aWFz?=
 =?utf-8?B?L0VKMmNIMHVldDJjeVIrc3lYQ3RqMXYxYWNvZmVOVHJIY05JQTB2cTlFS3E2?=
 =?utf-8?B?aXlPMkMvOExYQUNVa3dtSEF2azlwZ05ZRlFLbU1lTnFpaDJ3bmRXd29LZStk?=
 =?utf-8?B?WFdUVkdFNDlMTGxhaUR2MDh3dnA2dWo3OFpSbVg3d3VJbEd1dWlLZzdYY29y?=
 =?utf-8?B?M21oQ3NBdWw0KzVmZFRHeDJCVTl4RWcyVDF0RzBneDhZalVVVU1TM1VSS1do?=
 =?utf-8?B?bXNrcVZuVFVjYWVBWUFkU1h2ejVwMVdpeFlnWmgyejNYWjRNaVpWNDE3bWZw?=
 =?utf-8?B?em43ZndBWkxLdFg1S3B4NUJyZDVmZ2k1SG0xME5MM2hwV0l4RnV2SU1Md2dI?=
 =?utf-8?B?dFBxb0dXUHd3em5TTUVLT1FveFlzKzY3ZGxRdXJveTMzSUlCekJaNEliYml6?=
 =?utf-8?B?NkRYL29sc213Y1o0eUlmM2t1UGR1b2hkaW9Va2hYVFdHa3cwSG5Yelk4M0x4?=
 =?utf-8?B?dUhrWXNIS01xT2ZoNFBMa3NMYXFsKzB4U2tqTWI5SU1ybmdZSHZHSmUrWGVR?=
 =?utf-8?B?Sll2aUNjRFJ0b1NWNW9EMDJEWjg3bUlydnFPdWNCM1FNeWFYbUZnRnBXd2JX?=
 =?utf-8?B?QnFFVWhDWk9nWitlc1JBMEovZVdFcGs0Yk9rQU9ablAyY1dsd0RSVkVnSXgr?=
 =?utf-8?B?WUd3STVyaU9aK1F4VXd0NGZ4aUJLQUhWV2FaT2o5dWVROHpoTXRUYndtczMr?=
 =?utf-8?B?Y1YveHhjend6UEFCSW9jRTlaSHNVbjFqNGJZTHp1MjRrOWVDazVieVBFUzBn?=
 =?utf-8?B?eHhJZ095WEpHS0U1MXR4TG1nZ3Fzd01Oai82SXJRNVUxbm9Xb3FsSlRRcHk4?=
 =?utf-8?B?S0N3d2Z1YkpCdzZ6NFZ1UnREQlFPdHlWN1BmNGdsOFJteDFjRFVGSmlJdlQ3?=
 =?utf-8?B?YTN6Rmh1bnpMSndqYS8wZVg4TWN3VnpORXdTZGJ1d3NPUTJuUDJrdVMzbGtB?=
 =?utf-8?B?YVdYZUloaFdJUkt0WEUwSk9RZkRQUTRwZ2ZhMUlQbkFkekNuL3MxTXI5amlV?=
 =?utf-8?B?VWRjSGxQb0dlV1c5NzdiOU95V2xQaXgxR1kxVDArd3AybE5SOS9xRUVGbEI2?=
 =?utf-8?B?aCtBQk1WZTRXQ2ZOYTBtVWx2dFFZMC9lZW1ObjFSNGJuMXlmVHU0WERXQmhk?=
 =?utf-8?B?UjcxR3NZNzh3NkdhR1BBWkxROERzcmh5UzdZaDZnQUNYTHQ5QlVYcUJMU3BH?=
 =?utf-8?B?TitaL2Y0dHlURlJNbmFsR3RVZC9nL2pGbTB1enZhWU4yVXR1VDU4cW42RTVw?=
 =?utf-8?B?bW5ZL0FDK1c2a3NqbGR5N3pyOW1KMkV1ZlJkR2tpMlg5bnlZaXAweENNWEZO?=
 =?utf-8?B?Tmk4eXBMZ2NHd1Rhb0dRZVFNTjZoREsyYlVPRkR3VzN2SytkcDRqN09wWDhp?=
 =?utf-8?B?WC9ZS2ZhblVDRlRUSG8weCt5M2Y1cmROclJjRjdKaVBHWkRzR1RoYnVhYURa?=
 =?utf-8?B?cEhyQ2VVMjcvRGdKY0tsdVpSaStYMFk5UCtMWEc5MzlCanJLVUlESnpVUUFB?=
 =?utf-8?B?SnRXRUExckRjNGxzcVNlSzZQR1duK2pBK2h3VHpuRDBaSVNpQ0JaSHpxZWh6?=
 =?utf-8?B?NFg3OHhKWVY5WWp5bjcrYllTMFQ3Y3VSSWZmbUYvQVh3REZwNkdtV3BWZG53?=
 =?utf-8?B?Sk9ONkRFL2ZTL2dETWUvZ1JocHdXMmo3ZVpaVVNud29PUzdQK1I2S0ZuUE45?=
 =?utf-8?B?QlJJb2FMYmk5QjA1WlhGSElKbkxXMWpXT2l2ZXcwMXhra2lwT3NqRWFjSHZq?=
 =?utf-8?B?Z2NCQ2s1Rm41VFllMVVqZFN6OWVFTVlMckkvaWRYUmhmOW85WFQ4Wi9KbHlT?=
 =?utf-8?B?Um0zYXFnZ1ZtVzJFV1l5TmpnQnpla0xhVzA4SnVoL0FmV3hiYTJRVUhRWGg4?=
 =?utf-8?B?NHlVRy9jYUhLcHd0RFFUdlZGQWJvYXp0UUNoVGRrNnlUNnV1Q2pXa0h2WmRv?=
 =?utf-8?B?MGQrc0MreXpBaXRkYjE0dFZpUzNwamJXMXRQdVYxY1Y3ZFFTN0VwUWE5S01x?=
 =?utf-8?B?OXIrMUJOS0ZWc2c5dTZhcjNLclpDQld3WlFEeXJXelhCTS9MUGhyQUswanpX?=
 =?utf-8?B?M1ZVdmVSSFlPRTE5SzNjRENnMlVFMXVrLzVORzJIUUdMVlYrZ21mcmR6Z1kz?=
 =?utf-8?B?Wnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A8431890C2671A4E9AAB948AFCEBD036@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5289.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d7d956a-88a6-4f6a-eaa5-08dcb7a08cbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2024 11:52:16.3427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dFBI8qgzc3yRTVjXhRyM/Pu1quL7r0kedba/Bv+B9naOiJemPOTeKhldpMAIh8QXPvRTULjRZgIuPlMtdHL6EP7NM0kH0JF7o+kUFgqpsu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7192

T24gMDIuMDguMjAyNCAyMDo1OCwgTWFyayBCcm93biB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQoNClNvcnJ5IGZvciB0aGlzIG5vaXNlIC4gTXkgZS1tYWlscyBk
b2VzIG5vdCBhcnJpdmUgb24gbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QuDQpJdCBpcyBh
IHByb2JsZW0gd2l0aCByRE5TLCBQVFIgSSBndWVzcy4NCg0KUFM6IEkgYXBvbG9naXplIGZvciB0
aGUgc3BhbQ0KDQpCUiwgDQpBbmRyZWkgU2ltaW9uDQoNCg0K

