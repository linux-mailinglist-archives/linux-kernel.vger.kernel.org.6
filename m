Return-Path: <linux-kernel+bounces-322301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DE9972701
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 04:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55B8B2808EB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 02:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43E213CFAB;
	Tue, 10 Sep 2024 02:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="Arxc9MVa"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2129.outbound.protection.outlook.com [40.107.117.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CD41DFD1
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 02:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725934146; cv=fail; b=NMMxmmVL+si6fk2BF/Fiil+vH7z1aYEt0cOLTS8xbuEpoZnQO15f8obqcVq//BnVwxQ5DL5vdyPhsheLv23Hoe58lD7v5vVk156jcdebBcR/dhdphIW5ummVav+XGFj3hhRBN/dWiB1LLZOcnUZI3PbgLyKockzLgsi50e29jws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725934146; c=relaxed/simple;
	bh=OXU3Px31E6GR1VOJxKTMJzSVl+jQPSumaGM86oun7IA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tHoVloV6NsTpzeFSAauvP8XpeTpCukhAj5Ih9+eRabIMKQvDT4kC+BYE9voAbUR/sB0xCeBxm6BfstEMz+pbGZROq7aS0up66CxtmfnphLUTW5flS/QYPGt9Fjc74Z6T20lFShXm95GhAEaPwuDWpHfLQvEnqoUECwCYTu6PKVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=Arxc9MVa; arc=fail smtp.client-ip=40.107.117.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ptA3zcQOVAAqyhS46RpnZprDJALFL5+f3MhJ+Ub1GYYkU9G/D2oV4iFvJ7uX+T584W7aZw5K/8Cfglb2FA9UPwk+tFa7r5qh9xFtMOEhTaMR08BhiqGOWhiPJmL/VX+glVuVinHDQqKo1tNkhZOJMXxdLlDgnQsAbSPdUWA+DqRw7E1IRn1iE6MwuoHUnw90K1A4PnuQEIyCMXMRjUeQEQmLrESP7PozJiSha0JmtA2y+qRvWbPd0RtuyfiXHLfOamBkHitnu97B9G6M+0IP1xi8mBDALPOTyI1vZ7l+71VNTNUdTdL4OGa7wz0tdULhJe8Ce7V85DXkQ1FTwm3ujg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXU3Px31E6GR1VOJxKTMJzSVl+jQPSumaGM86oun7IA=;
 b=B/Q7dXPeotchY2AE3wLtSP0c2znWszZ0iUkrrP7dt+eZ5iZWjJyL81ku+/x/fzIM/Xpe19rzxWMHDmwUlFgoOVmMJXpHwWEx+5VlnpRSeHQK90goBJBlN8DprtNysC0R2A4fI0Xr2Eeh4v3vy97a1GZ6uG0uJtqzgT6Gw81C1ltwiqD91iaquUBhxFbf5MxPdjO3VXpYZRFZmRcOObP/fYXii872jGt/Mu4ekq6VlKACq7eAY/7upMpUEt9QO4jI5wr2f4DsXNusR9MGdAAM1Y/+btRPgIt1WeaGf3cW5EnguCXbcjy/JwbtgfCGMxE9o+PzyChzVZaQw36iy43FAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXU3Px31E6GR1VOJxKTMJzSVl+jQPSumaGM86oun7IA=;
 b=Arxc9MVax7dDL0NkV2U+B/FIWXtFT/yLQkFTLhRE+GKJdSWJ16UObNUQdVPDZ2z7F8BoZAKecNtFTPRr8HsnBJnWoaJU5Wqc5exnv0sYKbidzVTXb42ormRPVQHuIIr1fvYP4wnPCQMekRs5/TUKwqcESRP4xmW4LjMJjLotDloPRjfY4zOrb9vQrt4iCa1u11HHxcYOyb40KxvllxC2dum0iVi7F8rWmEnWkhY4sv0A9snUV+Wn32PP1x2WmRXv5l3PJHshdN4E3EDS1FnSvy8uvYTN0ow3jzqoqyG86I9VRxbaKgKDSH/Q7aZhJsr0E3Y7TCLLk8trjMRpNEFIaA==
Received: from TYZPR06MB3933.apcprd06.prod.outlook.com (2603:1096:400:29::9)
 by TYZPR06MB5123.apcprd06.prod.outlook.com (2603:1096:400:1c1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Tue, 10 Sep
 2024 02:08:54 +0000
Received: from TYZPR06MB3933.apcprd06.prod.outlook.com
 ([fe80::9b60:a415:f5ed:a367]) by TYZPR06MB3933.apcprd06.prod.outlook.com
 ([fe80::9b60:a415:f5ed:a367%7]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 02:08:54 +0000
From: shawn.shao <shawn.shao@jaguarmicro.com>
To: Jacob Keller <jacob.e.keller@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject:
 =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjJdIGxpYjogRXhwb3J0IHRoZSBwYXJzaW5nIGZ1?=
 =?utf-8?B?bmN0aW9ucyBhbmQgcmVsYXRlZCBkYXRhIHN0cnVjdHVyZXMgb2YgdGhlIFBM?=
 =?utf-8?Q?DM_library?=
Thread-Topic: [PATCH v2] lib: Export the parsing functions and related data
 structures of the PLDM library
Thread-Index: AQHbAohSmN9TQFweakyG1C2txKh+VbJP6uyAgABbU4A=
Date: Tue, 10 Sep 2024 02:08:54 +0000
Message-ID:
 <TYZPR06MB3933635596B06AB3E2D438AD9D9A2@TYZPR06MB3933.apcprd06.prod.outlook.com>
References: <20240909071721.1768-1-shawn.shao@jaguarmicro.com>
 <a97f1b6e-66a1-4d52-9cfc-ac424263dbf8@intel.com>
In-Reply-To: <a97f1b6e-66a1-4d52-9cfc-ac424263dbf8@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB3933:EE_|TYZPR06MB5123:EE_
x-ms-office365-filtering-correlation-id: 255f279f-ce1f-481c-a7f1-08dcd13d8570
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?STFKckV0emZnMURnSndOcWMvZDZ6NzMxeHBWYlpWLzhXVkFmWHM4VjdaVW5p?=
 =?utf-8?B?MHgzL3dCV25LZ2pUUndUVDhZdHh6OU9BOHNYZGtJbnRnSFk1N2JiUmwycXU4?=
 =?utf-8?B?bjZORTYzOWNFOFI0TSttZm82WDBRcXhkbWFFTU1CT0dLaVRWZ0R0OHZ0KzQx?=
 =?utf-8?B?bEJzSXlrV2ptNVlXRkNoUmJMdjRGQlJMRlNIWmdzbFg0MlBSMjFZVnFQNDNR?=
 =?utf-8?B?dS8wcENKU0FMNmxoNEhmWnJEc1NFRk5RU1JrUDQ1bW1OY1FHbWpWSWVDNVpm?=
 =?utf-8?B?RlN0TldjMGw5Vk1PMGVoT2piSzN0S1E2anQyK1BmS1BrOWhpN1hwTmUyL3Iw?=
 =?utf-8?B?T1ZsVWlTZ042ZFVLZHErQy93RTNJa1Y5UTQ1UkV1L2RjbmlZeEgzSjFZeGdI?=
 =?utf-8?B?K3FLMjR6SDdXbzA1dVdIc1lHcE1KbHozbXdYSGVXYVBoOVFmK2Jxckx5ZW1v?=
 =?utf-8?B?MjY0VGpqMkZmSFRVS1lSTDVJMjBkdnBvQUZyclRIV29iV1ZVdFVxU1huaUhQ?=
 =?utf-8?B?ZFZFeHZjTGdVQ3ZnbjdNU2w1TklxNUhJbmxXNXE5NUlIMTd1Kyt1cWMxMzJp?=
 =?utf-8?B?anNhWE8rcXU1Sk9KNzVlc2FvSlljb1FvRVlLMGIxQjJuSk16d2tkZ2E1SjBX?=
 =?utf-8?B?SHlGdG1lTFhoczRSNWQ5ZXRyUkZLRDI5dXdkOGg3M2p3NThzOFJWOUlHU2Ro?=
 =?utf-8?B?eXgyMVkzQVp5SzdCNGdESkpWYW5ZY0x4dElKTWJJUU1HL3QvektRSVJZTVNP?=
 =?utf-8?B?WngrQmh4VmNpSm5sOEw0cnFlNi9NaG9oTEwxajFRRERuOUZhOXErY3Z1dHJz?=
 =?utf-8?B?SVEwd2hiTGt1cDJ4VWFXWEZVdStSNEIvSVpGSVNHdDkzUVNVSW1qd1RGbEZY?=
 =?utf-8?B?akZGc1JlYUdHZlg3M1BMME1acmhERWNCZVo2WkgzN3pJMEZpemo3ZWNXY0NM?=
 =?utf-8?B?K3Ywb3NOOVEzdU1yNUF3bmZ6bzlZbldLZHkwVE9VWk5IVUpSYmlmM0g4eVRU?=
 =?utf-8?B?ZEhWaHhZS20zMVd1ZC9BTUZob2dPc1lyMll5aTZhcks2Ui9MalJNczNnV29L?=
 =?utf-8?B?N2pVU08weGMvWlZNQmhQc0NpL1llMHJCOWFScm1QY0xzc0dFSkVFQTdXenNa?=
 =?utf-8?B?dHhmQ0p3Z0NYWEtIRlJURmdDZjhBM3lXK1hrRGJMTUN4Q21CZEJCcmo1T29M?=
 =?utf-8?B?bFJtT3NBM2p0MmU0WjVvdUxGTVQrU2s0MkRaeTJVVDJmaEo1YU02aC8wNmNr?=
 =?utf-8?B?czVTdk0vNlRYQ3FUSzlzNGRYcVV0QkxhSlZlalkzNEpyM1FLejBmRFBad25W?=
 =?utf-8?B?SjFTU0U3TEJwZUFFRVVLNmpHN3UvYTM3dHhEU1pRUkd1U28zTXk4ZlpMOU93?=
 =?utf-8?B?eWxDd1AzSXNqT0hQa2RQV2pQSno1TzJSQkJpWHZWOGl6RlFVN2xHWXZKbENT?=
 =?utf-8?B?enBsS0Zma1FVdjdhemlIWHhBeGllQXhoSUtlaCsxN2l3YmdPQ3lKS2ZTUnZK?=
 =?utf-8?B?cEFWZmxmWVMrZGFaUWxrNmR1NjZZL0NNczJtdnFNOUtUYStpR21sRTZKbXV5?=
 =?utf-8?B?Z0Q5Mzd4OUF6dXFXUG1TYkhMOXFXYmk3ZllFeUdoYWhEcUpUTVpBQUdERXRp?=
 =?utf-8?B?ejF2WTUwTExyK2dmMWNKZW1Rak1iR1V4MnpiNTJ1aVVWK0EyWVhCdGZEa1cx?=
 =?utf-8?B?clE4UDVaMk1mOFNubGRDQW5UMzNZMHowNWU5VWJoRE9QTUpMb0pFeU1hYUdv?=
 =?utf-8?B?YWNENm5FL3BsVXR3OWJqVEprQXVNSW5xRkJwUE10ZlYwS1FkV3dWdkloeVNu?=
 =?utf-8?B?bHBkSWs4VXR1T3B4aGpuWXN0ZERQWVFIVFFRU05nbm51MndCUDhLRzBGK2FW?=
 =?utf-8?B?M0E4M2ZNdjlGU2daMjV5aDlTU1E4YzdmeEFZbzIzWkxtVmc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB3933.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MWJ3RHQ0L05JOVhxVVl1aHBQZjdvb29ER1g2MWRlV1RmQTh3VWRkeFdnMVNl?=
 =?utf-8?B?Yk5mTVpMNkJKMWVRRXJ6MTRpM3VQdVJjSHMxVE1ITHVkeEs5NVcreGZ3aGho?=
 =?utf-8?B?ZWk2ZHhaWm0ycVhtUDB0SnBPYWI5UTlldjAxRHZyTmVqQzZEbXkwdnNaemcz?=
 =?utf-8?B?ZU5wMEQ5bUIyNTd2bGhJa28rWUxmQlFPdW9MR3NHNEhCekFtTERNL0VMZEow?=
 =?utf-8?B?Yk5lN0tkeXlFSnEzQ2JnSUNONWFaWDFvQm15SURNVEdDTkRxRGYzU1JYWmZS?=
 =?utf-8?B?NGluUWVMZlEweElRVGZyUkxldldTTStCUllsSDZkZXBjMUQ5Qk5ZSjUreEht?=
 =?utf-8?B?a0loYmk0ZkMrVlBkZnZBRHROMG1NSDd5bXRTbU5EbVQ5Wis5SVZtSjlSWnlj?=
 =?utf-8?B?WFpxMis3bXd5anZ4aWQyQWl2NnByOW1CUDlJaU5GSCtaL2tnYm9lbjcxRDF1?=
 =?utf-8?B?Zk1uMkNSeTN4RitmcFRSOWhTWXVBSitpeDdwU1hMZXl6MmZqcFF6VnltbVRY?=
 =?utf-8?B?MVFoRzAwbEVEdkRBM2N6U0tRUjJVMHZiWHVWK0dZcDFBNFJ3clo2ZDQ1cHJv?=
 =?utf-8?B?TEhrQUdSMTdmanpYMkw0aGZWL1JkcVQvc2R4Rm5BWmJRTklPMUVQWWlGWjFJ?=
 =?utf-8?B?bmhueDg3QTV5bjR4cXRhN1NXa3Nrdy9sQTgyM05VTXRMZ3VzSHlhbERWYVZB?=
 =?utf-8?B?V05odWl4OHQvSlZ4SGlHYS9pbG1oMG9FcjlybUp2OUJwQ013ei9zQXI1TGQ0?=
 =?utf-8?B?clV3UUM5UnQrcnhGQ3VBdHpaaXpYTSszTDZBYWtUczJGOGM0UUduNGVrMUl3?=
 =?utf-8?B?N3UwWFEwNEpacTBwdE9TWnBCVytYR1ovbGtTT1RvUkJJeUtQakExUWtNQ3pV?=
 =?utf-8?B?dTBQaFh0VWt5OEVNWTlSejhoZlV4bEJOc3pVMExENmJwc0F6dVJDdjNkcWRL?=
 =?utf-8?B?eEt5eENSbVZKYWFSMkl2SnBEQnBzTGo1aUg1cWxSL3g0cTNodHdwaGI5VUpt?=
 =?utf-8?B?ZUhwTjF2T1BuZ21HeVZsa1NTaFFTa1EwbFFGN3RvSGlUQm5IRXN5aFdpZkJj?=
 =?utf-8?B?N0t1S1d2VUluRUI3YklkTHNUNWRDUjdRZHhaTzI2M3ZRUGxka3JkTkExbjlH?=
 =?utf-8?B?aGhWRTBEZlNaaWt2ZDZONUlXUzl0WnNYSlpPYTdoOFZ6c25vd3hSU2hGZ1gw?=
 =?utf-8?B?L016R21KOWF0VW1HSkdwUU8xRThpeFI3VjZZRHdaSWVhL2pzSjNwTmUvNXdY?=
 =?utf-8?B?VTBTS2l3THI3L09kMFJXZHU1dDVNRUVXeW1waE5uVm8zTkVLMDNDMGlIUUZP?=
 =?utf-8?B?c1hQa2RkcTZqMDZxeXZoenFpbW9uTnVGdENzVno5TDg3VGlwMGhFeUN1SnNw?=
 =?utf-8?B?SnI1ZEdXV0dzSGpEbEhUZlVUVGlBbkF2bityT0VkMm9pcm8xWGthU25mT2dn?=
 =?utf-8?B?NU9hdGVFSjZVYmpSVlpHSGszSE8xOTNIZytYRWFDTUlPOS8wb3lpeWdYMHBF?=
 =?utf-8?B?U1JlbWFJRTBnWnFXREpFZlZGS25US3JRcmZaQ1VkaVRiekdNd3lydHBPL2Qz?=
 =?utf-8?B?Q1M1ME02bkVqYnlBQmNPcnNtY1h4ZjFBNDVPS0l2LzV3a3RqZ1duR3FPR2Jr?=
 =?utf-8?B?ZkhSR2xuZkg5RG1yOEN4THV3Nzh5RnNmM1BDejA1d1R4cU96bWxlRFdJb0NL?=
 =?utf-8?B?cnJ5M0k1djYvMDZnZFJEd1diSDh4ZVgwY1pRUUVaSHE0N1V1VG9WbEhHZDJQ?=
 =?utf-8?B?aGczVkdpR3plRmVEcklBVE8xVDZrZndnS1FiZGQrWHJMT1ZjV2NtOEt1UUVa?=
 =?utf-8?B?ZWFZaGdEV044ZUpVcTVaWTZDREhNUnhCUEVjSmtrWElleHpJcGt4U0JyVEhP?=
 =?utf-8?B?MFBsYWkxQmptNkN0UnBQZzkvVnY0dXVIbFdTc2drZ2gwSDZRVitGZktQVHpB?=
 =?utf-8?B?Qjk1MEcwcmZlZ2tlME1JZDg3WlJXSmpmNkxKUGpMQkZpcy85UVROUU1lTjNL?=
 =?utf-8?B?SEluUHNBQTQ0ZVhJcGtKTWxXS1N5TGdacTNGMGdBUU5VcGlmKzcraHhSbU41?=
 =?utf-8?B?ZDlBMlN4WGM1MHZ0ZWh6VDZaSTdiNU8zYzNpVTVDUkp3d3BTYUFCNXRYZG84?=
 =?utf-8?B?NExCWFZ2SUd1SDdVNzd4SlI1cWt3UHhNQ3NVM3dNUjYvQWdYWm4xSFkza2c0?=
 =?utf-8?B?MGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB3933.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 255f279f-ce1f-481c-a7f1-08dcd13d8570
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2024 02:08:54.1163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9XNJ0p545hOwBVnFCpqlYURalGMogzYT3VghPKrsEp3BKQ6mkBFbxZd8I1z0W9ihb3tA1SnJPmMig4V4nhpApURpkPuNxrHk6OY8+bdZ//c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5123

PiA+IE9uIDkvOS8yMDI0IDEyOjE3IEFNLCBTaGF3bi5TaGFvIHdyb3RlOg0KPiA+IEZyb206IFNo
YXduIFNoYW8gPHNoYXduLnNoYW9AamFndWFybWljcm8uY29tPg0KPiA+DQo+ID4gdjEgLT4gdjI6
IFVwZGF0ZWQgdGhlIGNvbW1pdCBtZXNzYWdlLCBhZGRlZCBhIGRlc2NyaXB0aW9uDQo+ID4gICAg
ICAgb2YgdGhlIGNoYW5nZXMgcmVsYXRlZCB0byBgRGV2aWNlVXBkYXRlT3B0aW9uRmxhZ3NgLCBl
dGMuDQo+ID4NCj4gPiBUaGUgUExETSBsaWJyYXJ5IGlzIHVzZWQgdG8gaW1wbGVtZW50IGZpcm13
YXJlIHVwZ3JhZGVzLA0KPiA+IGJ1dCB0aGUgY3VycmVudCBsaWJyYXJ5IGZ1bmN0aW9ucyBvbmx5
IHN1cHBvcnQgdGhlDQo+ID4gYHBsZG1md19mbGFzaF9pbWFnZWAgZnVuY3Rpb24gdG8gY29tcGxl
dGUgYSBmaXhlZA0KPiA+IHByb2Nlc3Mgb2YgcGFyc2luZywgc2VuZGluZyBkYXRhIHRvIHRoZSBi
YWNrZW5kLA0KPiA+IGFuZCBmbGFzaGluZyAoYWxsb3dpbmcgdXNlcnMgdG8gaW1wbGVtZW50IGN1
c3RvbQ0KPiA+IGxvZ2ljIHVzaW5nIGBwbGRtZndfb3BzYCkuIEhvd2V2ZXIsIHRoaXMgcG9zZXMN
Cj4gPiBzaWduaWZpY2FudCBjaGFsbGVuZ2VzIGZvciBkZXZpY2UgdmVuZG9ycyB1c2luZw0KPiA+
IFBMRE0gZm9yIGZpcm13YXJlIHVwZ3JhZGVzLg0KPiA+IFRoZSBmb2xsb3dpbmcgc2NlbmFyaW9z
IGFyZSBub3Qgc3VwcG9ydGVkOg0KPiA+IDEuIE9ubHkgdXNpbmcgdGhlIFBMRE0gcGFyc2luZyBm
dW5jdGlvbnMsIGFzIHRoZQ0KPiA+ICAgIGN1cnJlbnQgbGlicmFyeSBkb2VzIG5vdCBzdXBwb3J0
IHRoaXMgb3BlcmF0aW9uLg0KPiA+IDIuIFRoZSBmaXJtd2FyZSB1cGdyYWRlIHByb2Nlc3MgZGlm
ZmVycyBmcm9tIHRoaXMNCj4gPiAgICBmaXhlZCBmbG93ICh0aGUgZmlybXdhcmUgdXBncmFkZSBw
cm9jZXNzIG1heQ0KPiA+ICAgIHZhcnkgYWNyb3NzIGRpZmZlcmVudCB2ZW5kb3JzKS4NCj4gPiAg
ICAgICB8LT4gcGxkbWZ3X2ZsYXNoX2ltYWdlDQo+ID4gICAgICAgICAgICAgICB8LT4gcGxkbV9w
YXJzZV9pbWFnZQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICB8LT4gcGxkbV9wYXJzZV9oZWFk
ZXINCj4gPiAgICAgICAgICAgICAgICAgICAgICAgfC0+IHBsZG1fcGFyc2VfcmVjb3Jkcw0KPiA+
ICAgICAgICAgICAgICAgICAgICAgICB8LT4gcGxkbV9wYXJzZV9jb21wb25lbnRzDQo+ID4gICAg
ICAgICAgICAgICAgICAgICAgIC0+IHBsZG1fdmVyaWZ5X2hlYWRlcl9jcmMNCj4gPiAgICAgICAg
ICAgICAgIHwtPiBwbGRtX2ZpbmRfbWF0Y2hpbmdfcmVjb3JkICh4eHhfbWF0Y2hfcmVjb3JkKQ0K
PiA+ICAgICAgICAgICAgICAgfC0+IHBsZG1fc2VuZF9wYWNrYWdlX2RhdGEgKHh4eF9zZW5kX3Bh
Y2thZ2VfZGF0YSkNCj4gPiAgICAgICAgICAgICAgIHwtPiBwbGRtX3NlbmRfY29tcG9uZW50X3Rh
Ymxlcw0KPiAoeHh4X3NlbmRfcGFja2FnZV9kYXRhKQ0KPiA+ICAgICAgICAgICAgICAgfC0+IHBs
ZG1fZmxhc2hfY29tcG9uZW50cyAoeHh4X2ZsYXNoX2NvbXBvbmVudCkNCj4gPiAgICAgICAgICAg
ICAgIHwtPiBwbGRtX2ZpbmFsaXplX3VwZGF0ZSAoeHh4X2ZpbmFsaXplX3VwZGF0ZSkNCj4gPiAz
LiBUaGUgY3VycmVudCBQTERNIGxpYnJhcnkgZG9lcyBub3Qgc3VwcG9ydCBwYXJzaW5nIHRoZQ0K
PiA+ICAgIERldmljZVVwZGF0ZU9wdGlvbkZsYWdzIHBhcmFtZXRlciwgd2hpY2ggaXMgZGVmaW5l
ZCBpbiB0aGUgUExETQ0KPiA+ICAgIHNwZWNpZmljYXRpb24gdG8gZmFjaWxpdGF0ZSB0aGUgdHJh
bnNmZXIgb2YgY29udHJvbCBpbmZvcm1hdGlvbg0KPiA+ICAgIGJldHdlZW4gdGhlIFVBIChVcGRh
dGUgQWdlbnQpIGFuZCB0aGUgZmlybXdhcmUuUGxlYXNlIHJlZmVyIHRvOg0KPiA+ICAgIGh0dHBz
Oi8vd3d3LmRtdGYub3JnL3NpdGVzL2RlZmF1bHQvZmlsZXMvc3RhbmRhcmRzL2RvY3VtZW50cw0K
PiA+ICAgIC9EU1AwMjY3XzEuMy4wLnBkZiBQMzcuDQo+ID4NCj4gDQo+IFRoYW5rcyEgSSdkIHBy
ZWZlciB0aGUgRGV2aWNlVXBkYXRlT3B0aW9uRmxhZ3MgdG8gYmUgc2VwYXJhdGUsIGJ1dCBJDQo+
IHRoaW5rIHRoZSBjaGFuZ2VzIGFyZSBnb29kLg0KPiANCj4gUmV2aWV3ZWQtYnk6IEphY29iIEtl
bGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPg0KDQpGaXJzdGx5LCB0aGFua3MgZm9yIHlv
dXIgcmVwbHkgYW5kIGd1aWRhbmNlIHNvIHF1aWNrbHkuDQoNCjEuIEkgd2lsbCBzZXBhcmF0ZSB0
aGUgZGV2aWNlX3VwZGF0ZV9mbGFncyBpbnRvIGFub3RoZXIgcGF0Y2ggZm9yIHN1Ym1pc3Npb24s
IGFzIHlvdSBzdWdnZXN0ZWQuDQoyLiBJIGhhdmUgYW5vdGhlciBxdWVzdGlvbiBJ4oCZZCBsaWtl
IHRvIGFzayB5b3UuIEZvciBzdXBwb3J0IG9mIGhpZ2hlciB2ZXJzaW9ucyBvZiB0aGUgUExETSBs
aWJyYXJ5LCB2ZXJzaW9uIDIuMC9WZXJzaW9uIDMuMCBzdXBwb3J0cyBDb21wb25lbnRPcGFxdWVE
YXRhL0NvbXBvbmVudE9wYXF1ZURhdGFMZW5ndGhgLCBhbmQgcmVxdWlyZXMgYWRqdXN0bWVudHMg
dG8gdGhlIGBfX3BsZG1md19jb21wb25lbnRfaW5mb2Agc3RydWN0dXJlLiBJIHdvdWxkIGxpa2Ug
dG8gY29udGludWUgc3VwcGxlbWVudGluZyB0aGlzIGFkanVzdG1lbnQoc3VibWl0IG90aGVyIHBh
dGNoZXMpLiBJ4oCZbSBub3Qgc3VyZSBpZiB5b3UgYWdyZWUgd2l0aCB0aGlzLCB0aGFuayB5b3Uu
DQoNClBsZWFzZSByZWZlciB0b++8mg0KaHR0cHM6Ly93d3cuZG10Zi5vcmcvc2l0ZXMvZGVmYXVs
dC9maWxlcy9zdGFuZGFyZHMvZG9jdW1lbnRzL0RTUDAyNjdfMS4yLjAucGRmIFA0Mg0KDQpUaGFu
ayB5b3UgdmVyeSBtdWNo77yBDQo=

