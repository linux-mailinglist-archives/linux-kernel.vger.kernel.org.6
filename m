Return-Path: <linux-kernel+bounces-429005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1EC9E1620
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B0E02850F5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 08:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F75813D890;
	Tue,  3 Dec 2024 08:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="eKoE7/zE"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AFF7E591;
	Tue,  3 Dec 2024 08:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733215629; cv=fail; b=AfFlFyTOinRN+JH1il3gWV9uN3HflK6gdbpR0DpG5jBq2EIRAC0WHbMYpZuDHojapm0Fx/6AW5jv37+iZE4Xo1l0AIgkC2d9tivoXiQa2n2rh5ZaLhfh7TRO2ylriCJEeY2ajlu6cgNqZH7LswI1w4XOm5tRPR84ZYfrLnnvWcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733215629; c=relaxed/simple;
	bh=LXBYmfZ47tpPhN7/CS83AqurqxHeXZu3r8etEGpnl6M=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YQlDJbhDCfqdmaGKFvgpNCjwQDb4CP2HDHsgoIYTUIP2heK6M6mpzatKaaGDJTcIpHyJjuhnF6wUhh0EuPnmXXRAHdBUI29NULFrFfeb4Fszc7043Qd/OR5BHvteLBYX/8gIiG4Ezh8X5xLk4G/vZZ4K6r1e2HSCDD3rQDndT88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=eKoE7/zE; arc=fail smtp.client-ip=40.107.93.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fV9GqeUDcTL6Lnr/x3xpgDmqsAYtff3INtZvZ5HPsXqxi1MB+hGoZbbq3HsOb2gs74CWqFywMmsK3zdeDnTOUy8/14EXlWhksnUjqOfbLyyHtvol3kIqTn8bDfErwX8tBBnUY/gCLhAv3hUBRsXA8m9IUPra+ZSSCHWvFeHfBRFh4kJjM94A3JWbaN1Phm67/O2FGXcndTvVrBgumh2lGaIaRGdz7FG5zkJBavyiTbn5qmiekLljrKjfMmkT3OsJd+wNjqzeW0ZfqMViBF2jM5hs7WUS5v+hO3d2GM6scQc0Z+51yJWqUPNxUr5CgzjveCdQ92S2odQCE8SLI+j6iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXBYmfZ47tpPhN7/CS83AqurqxHeXZu3r8etEGpnl6M=;
 b=FYo0YJP3U1Fjjir72TQOggVq/eRHXLi6BQSetPsfhJvUIKHFaRd8ZRzOgZJZIAKlSak8zLuzDc8pVwz01LDYXVbQ0pzzWCeOJgfZJp9TZ6McvhYNIPp4Ivx83fLeLHBkHnaly2FFPtcQ5fZ5cGJDadJhYRlsaTCSUXD4uVQaIoJeteB7IJ5RSCO7S/igh2G5T2psysGdzvmDZA+f4mkEeO/uH9NJGkSh1XJmMIDS6twEY5d+k3vVB0wBePLNrXN/Ub1YLcVnyBaffYIhv5iSixkkG4m4RdGs2PAS7mieh8PYF9EfqL+XiNW4eqpzTXz9xFuuEv0oPAiGmotsAydoQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXBYmfZ47tpPhN7/CS83AqurqxHeXZu3r8etEGpnl6M=;
 b=eKoE7/zEoz6TlPOE2zWkiEdWgiQO2yF3gb7hekrT6Ctb7bF8s0I71x0fEL7bEkEc46KRNJ7PDLQ+/HlbU8qFHALS7fsxpx3r1xLjKzNl/ZFeXIeKfGxCM4HI/b2n0gKVdAS67cYV5o7u4QE/aknph0X9Ke+c0C09s30MwaZB4UlhNktHCdEXu+TcpfEMiv9AgmTYyUlMx2Ux9Vpt4Tn93Tk20grWqz3kluIn2nLERB8/IlGNYvcC4V6wL//2u9WQEefmdWhKF0kc+KBxc1w4jxWuGb36dEgNTVTvj+gYrrVO/BqBASLCqyyUVqPHbcmJO4ctGB7lNI01VbskZPBaTg==
Received: from PH8PR11MB6804.namprd11.prod.outlook.com (2603:10b6:510:1bc::6)
 by CH3PR11MB8466.namprd11.prod.outlook.com (2603:10b6:610:1ae::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 08:47:03 +0000
Received: from PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::6f39:a4f:9001:ea75]) by PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::6f39:a4f:9001:ea75%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 08:47:03 +0000
From: <Mihai.Sain@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <Nicolas.Ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] ARM: dts: microchip: sam9x75_curiosity: Add power
 monitor support
Thread-Topic: [PATCH 2/2] ARM: dts: microchip: sam9x75_curiosity: Add power
 monitor support
Thread-Index: AQHbPLVlL5R94FkZFUuD/5fCO/yderLSqvuAgAAERgCAAZSKgIAAAaWQ
Date: Tue, 3 Dec 2024 08:47:02 +0000
Message-ID:
 <PH8PR11MB68044686611DE17930DFD77082362@PH8PR11MB6804.namprd11.prod.outlook.com>
References: <20241122080523.3941-1-mihai.sain@microchip.com>
 <20241122080523.3941-3-mihai.sain@microchip.com>
 <2d8dd1c8-fd4b-4dc1-ba62-312ac86335a6@tuxon.dev>
 <PH8PR11MB68043702680864433060E9B482352@PH8PR11MB6804.namprd11.prod.outlook.com>
 <b1e053da-04dd-4b66-86c4-60e1d6b5a5a2@tuxon.dev>
In-Reply-To: <b1e053da-04dd-4b66-86c4-60e1d6b5a5a2@tuxon.dev>
Accept-Language: en-GB, en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6804:EE_|CH3PR11MB8466:EE_
x-ms-office365-filtering-correlation-id: 9868873c-aece-4dbe-36a4-08dd13770efd
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6804.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NFROQVdCb0NOKytnbHF1Qm1uMEJuTXBhT2J0YlN6c1ZlTWUvQWQ2b0ZmaGpR?=
 =?utf-8?B?b05aTER4NHBDSjJoWDRiaHYyN2VPSkNQR3BLL1NpeHdSVnlJaEtDQXowQTh3?=
 =?utf-8?B?ZzdpV2RCSDdrUmQ4dHRCMFgvQ1R2cXBwSzd4M2hObk5wbUJzclBvRFJGdUI4?=
 =?utf-8?B?b3ZER0JVYVFaRnR3THFXY3pDKzUzS044Ym1uOExUR3JZa0ZsaVRZYXdFNU1V?=
 =?utf-8?B?bWQ4NmxMdTJZLzlnVHVhMkpLbHFScEczNEdCTlMzY2orV0NLbXovRjZGekpT?=
 =?utf-8?B?SU10Zm5Da3ZkaUgxU0s5MlpCaWNBYkd3MzNLSjVUK2YzcXlyZ2NFZVFwb29O?=
 =?utf-8?B?c0ZUencvTmV5dEhoR2hRMHRBd1VvTE1KSm1PU3VndE1HSU5Ed2tlNnROQnhR?=
 =?utf-8?B?RHFPTFhqOU1aaEx1dkd1ZDcza2FpY0ljVXZERlpDS0NnSTI3K1Rpb0VGa2NF?=
 =?utf-8?B?bFlNUkNvY0diYWNCWFVROVZUYkQyMXBHS3p1MjdvSm5FdWpZRVRzbEFjTTBX?=
 =?utf-8?B?NWloQ0NuZTJmS1NJQ2hHQVVkSlNacERqN2t3M01xRkZpQmdWRzdxS29GczRU?=
 =?utf-8?B?aEMxazhWTFJPMHU4Q2tNSk15OENSMzQvTDFGdm5IeWcwcVpZcFlScHNoaWwv?=
 =?utf-8?B?RTZxZmpvTHlMRlN3WHdsT3J4dVV3am1ZN3VEanZhTGpIY2lzcXZNZmh6VEl4?=
 =?utf-8?B?dTlUT3pIS0o5dkVnZkYzMDlBdURLREkvMldGckRUWUg0cUY4am8vZUllQU1T?=
 =?utf-8?B?UFNMWUZVd3R3TUlYWXU3UFY4eFQvOVZ1dFVxZ3VPKzFBcnI4eVU5VXhwTitr?=
 =?utf-8?B?elNkdnZEemwrNGtDWm51aFo1ZUdhbzl6UUV6S095aVp5VHNuWVBLV0NwdXdX?=
 =?utf-8?B?WlpKYmI5V3JpR0NpdzdhVUZtd1pFN2pVS0gzaDRSTG0raUJUZnEzQVRIeEJ2?=
 =?utf-8?B?NlFyZGtNcGw4Y3VoSDRQQU11WGhJVUxhbWQ3MHMrN1hlK04wUFhsODYzaDV5?=
 =?utf-8?B?YjRnNDQvU3pvNEc1a01kcnJSZGZ1elpvTDFIbldUNjJMaFB4cjYwK0ZCMmlT?=
 =?utf-8?B?dHFwMVpRUDdCaEV5UjY2YklGSTBBTmFrTW03cUsyZlUyR29zeGttdlM5cnNq?=
 =?utf-8?B?Y0FzWjV4ZUM2ckM5QlNGb2lGbHYrU3g3R0FGT1hZdWg4QnRSeXo1am9HSFF1?=
 =?utf-8?B?d1kwY3lPa3N5dGdsMDAzWU03ZG5HWDlnYTJBM1FCNFhpYWNHSm9iSWFmc1lZ?=
 =?utf-8?B?ajZBTVZybUhzS2tVTUQ4d1VjTGtwZUVkSTNIbG9CVUdlZVljL01LcTRQQUJC?=
 =?utf-8?B?KzhNWUc0VThhWnd0VVZxWGdTTUVwcktUUUlGdnIrWW9YdFVObTBLeFdWRmI1?=
 =?utf-8?B?b0RvcjFIcm1VSks4ZzVoZWw4WVlnM3huRHhKdHo2WVQzd29QTnp5a3Azam5L?=
 =?utf-8?B?aVdZcTFrYlN0dDVzaEVHRWROM2J3QTNGZHFEVFFVRWZzTEc5ME5QMmszOVUx?=
 =?utf-8?B?MFZoY3RNR1E0S3hxT0ZFUSs3N1RQWXRNSGFkdldKb09nYjF2eGtkYlpzcHl3?=
 =?utf-8?B?SlJvcFU1SEkwbGxNL2pmRzRhWGw4M2lKclI2a1pSVTBxMXVNNVV1VzNZckQy?=
 =?utf-8?B?cDhzTnY1OS9jTFFXMWFKYUhvd0UxWTdhY25ZakNvbytWcXUzUERrNG0yNXNj?=
 =?utf-8?B?YVQwbktQTFl3U1lvbWdHTlNyWlBjdDRleHJxMGMrV2YweWhkMVpqa2s1NVBM?=
 =?utf-8?B?dHordFZCbURnSU0zWjlFTFQzcUNEZlhPQm9vMUd2OWVuRXdxUWxwL0h1S29J?=
 =?utf-8?B?czBtZklSS05ENjZjUDZIZUUzQVlCMzA2Sys3R3VFTWhudUFDbHVudGtiNG5H?=
 =?utf-8?B?cE5NWW1OK1dUYnVDa1RRQkFOa0ROMzl5NGl0VTRZbVc0U2c9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OHNQTWdGNTB1cDc3TVpuL1RRQ3RBaGg0cHZkNElOMkVzTWhBdEVxNFBEY3Zh?=
 =?utf-8?B?TjNoZ3lTMHNUaFhFYXdYM1RBUHVkZkd2ejJEcEZSeUt0amRVMjNuYS9VVnhq?=
 =?utf-8?B?cklPbTBOOW1zOFRlU2srZVRSeHZCRDBRd2dQK3NvRkRZQW45c25wRkl0VGk1?=
 =?utf-8?B?Z0F2ZkpUam1YS2VLWUxnK3VxUW9XUkpEU3M0VEgzWHN4M3hCWVdLL0VVZTVu?=
 =?utf-8?B?TnpQb08xakt0akdvVWV6WG1rbGZta2lqbGxQU3RUamdocnpLd1lGK3RyeW5u?=
 =?utf-8?B?NmNMZGtqNXRvV1I0S1FUUDY4L3pUQXNhZHNWYnF1Y3Rld3ovcDRqT2FOSVlu?=
 =?utf-8?B?TVBMT1FQOG1JOXB4SGQ5NWRMekU0Zmo0UDFacXI3cVJtc2NQRTNlUTJieWth?=
 =?utf-8?B?cm5leVZTa3Iranl4dkh6VitsK1lieGNnN1ZkRE1vZjNzb3MzMjJHaG8wQVFM?=
 =?utf-8?B?M3lESnY3Zi8wMERjK1ZHMzRNekdSdldPNVhyMlhoMFIvQTdiMTBNNi8zMVVC?=
 =?utf-8?B?eGpJdGFuUUczbkVVM0lwRmczY3NUaHVPbWtERnVSdmRsUkdWL3JudVRzc3Iz?=
 =?utf-8?B?WUloQVNZaXRaVHFaWitzdkFwc2VsUXZsdnhJWmFlbGE5anJBVm8rdFFPNG5s?=
 =?utf-8?B?ZW8zQjNVQWY0NTZtdGthS0JlMW1XeCt2Q2RxdlA2eVlYUC9GZXJVQWtWYWI5?=
 =?utf-8?B?TkkwNXI2MmMyQlc3c1AwbGYzWmF0WFFQRFBKQ2lHL3VwbG03aTBhTEd4R1Ny?=
 =?utf-8?B?RjVneU5QblRXS08rbkIxc3ZnWHVKaGxsQSthZmxFQ1VIK2hWU29kMkYrUXE5?=
 =?utf-8?B?NkNSSUNDc21oUmNpUjF1MEFGQWVPVHllWmpxcUNWQnpCZU1PbGNWQkcxTSt0?=
 =?utf-8?B?OFFmOFpLUzQvbHAyL09WalprVkYrTmpnNDIxM0w4bHcyWDRveG1iYTN5OVNt?=
 =?utf-8?B?V05TQTQrY2pGL2FvVHl5Z0VWYmZaeWR0elE5U2k3ZjhoQXF0c0dwbStMYTFa?=
 =?utf-8?B?a2VNd0RTNXlMV0NRQXpUY0lLTi9EdTNOSG44MTA5eHFBd2o2Rkp4WjMwTjk1?=
 =?utf-8?B?aTZhcHl3MzZsL2U5S3Q1cHNabUtZcjlKeDVXaHYxd2FvL211WUJFT0grd2R3?=
 =?utf-8?B?aHRlREY1cER0TlFFdm5uUHBDcS81a3B0OWlLKzg2eXA1VlhqSGhqMjA5ZGY5?=
 =?utf-8?B?NEpHMWRCdE5JQXNZRHlBZm1Zak9WZnU1WXh0MzBuL1Q2dnVrVTZNK1dRb0du?=
 =?utf-8?B?YndZU3VZZTkzNXdtQ21WV2RiYXlHa0RGdVNidmFBVXMyL0JzSnE2S1hNb2d3?=
 =?utf-8?B?Y08rSHBVeC9NdmhJSDlLK1FTVmlvNEdjTVVhSVBWRzY5NkNwYXBHYXYweW5O?=
 =?utf-8?B?Z3ZTMk5YcldwTlJYaVRRWjErc1g2WTNGU0oyQjViZk8rKytOV0o1KzRCRTBt?=
 =?utf-8?B?QjU3L1lFWUQ4NitVRStnQk5jZUt5L1VTZE5RVXdmTTVsK3d2ckJ4anpDQTE5?=
 =?utf-8?B?ZTQwT3VLVFZiMGEvQ05GRDAyczd4TnkwOEQ5SC9zU0JXZlBycWMzWkg0NjdP?=
 =?utf-8?B?WGV5NUtKRmw1UEhuZkY1K3NiWkNWRG9TMFZDdGJPY1pMRW03eFdJS2Y0ck1H?=
 =?utf-8?B?aE5SYXZNSnB4YkwxTUkzeVFkMkxUMzU1YWc1RDlBdVNLQS9nR1BhWFpzUlBh?=
 =?utf-8?B?WDVqQVB0OExYVWR0V2prNkdiMFhKTlpkaCtjcUE1QnVxaEtRQ0lsbENmZUg5?=
 =?utf-8?B?T25vc2VjWGJUQjlvc2FFOEp2bFdpMS9nQS9vbVRyY2tFaUlJYVhaMG9JL1R6?=
 =?utf-8?B?Wks1Tmw0K3hEZVlMNldjY2lVWHZlY1d4NEJtVGhQdGkrZlVJeXQ0dy82RFQy?=
 =?utf-8?B?b1hkKzV5ckpZK2xHK014OWpza3hCRDkwRUY2YzEzWlpTbnV4KzlxTmIyVGRQ?=
 =?utf-8?B?eDNMNGdRYjNVTThwSHdaTjlHTmFpV251K1d0c0FLRGJKdk0rWlhLNE5IL0NN?=
 =?utf-8?B?dDhPM0EySUYyNzJMZms5WlUzejVmRWdaR1lrTHVDcmtleTNNbTNsaml4SnYy?=
 =?utf-8?B?MHVBR2dUcTZUU1k2dnZrcUNRRzMxRGlrR2R5M0hxb1lFOWRaekhsa0lkSUxy?=
 =?utf-8?Q?6IrX5pqWDdvFnjGT3PeIrwgFc?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6804.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9868873c-aece-4dbe-36a4-08dd13770efd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2024 08:47:02.9409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zqMHgDW2ug3V9hiQEdrCM2oPle80yFuyHoOdufeOlP++Pqis6IbljfOL+lI7C2lLVzTZa68R3mwsqhpPhnlwZZuGtwNFlTEgH5TQEI1PqJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8466

PiBIaSwgTWloYWksDQo+IA0KPiBPbiAwMi4xMi4yMDI0IDEwOjMyLCBNaWhhaS5TYWluQG1pY3Jv
Y2hpcC5jb20gd3JvdGU6DQo+ID4gSGkgQ2xhdWRpdSwNCj4gPg0KPiA+Pj4gKyAgICAgICAgICAg
ICBjaGFubmVsQDIgew0KPiA+Pj4gKyAgICAgICAgICAgICAgICAgICAgIHJlZyA9IDwweDI+Ow0K
PiA+Pj4gKyAgICAgICAgICAgICAgICAgICAgIHNodW50LXJlc2lzdG9yLW1pY3JvLW9obXMgPSA8
MTAwMDA+Ow0KPiA+Pj4gKyAgICAgICAgICAgICAgICAgICAgIGxhYmVsID0gIlZERE9VVDQiOw0K
PiA+Pg0KPiA+PiBPbiB0aGUgc2NoZW1hdGljcyBhdCBbMV0gdGhpcyBzZWVtcyB0byBiZSBuYW1l
ZCBEQ0RDNC4gSXMgdGhlcmUgYSBtaXN0YWtlIG9uDQo+ID4+IFsxXSBvciB0aGlzIHBhdGNoIG5l
ZWRzIGFkanVzdG1lbnRzPyBJZiBzbywgSSBjYW4gZG8gaXQgd2hpbGUgYXBwbHlpbmcuDQo+ID4N
Cj4gPiBJIGp1c3Qgd2FudGVkIHRvIHVzZSBhIG1vcmUgZnJpZW5kbHkgbmFtZSBmb3IgYnVjazQs
IHNpbmNlIHRoaXMgcmVndWxhdG9yIGlzDQo+IG5vdCB1c2VkLg0KPiANCj4gRm9yIGNvbnNpc3Rl
bmN5IHdpdGggdGhlIHJlc3Qgb2YgdGhlIGNoYW5uZWwgbmFtZXMgYW5kIHRoZSBmYWN0IHRoYXQg
d2UNCj4gZGVzY3JpYmUgdGhlIEhXIHRob3VnaCBkZXZpY2UgdHJlZSwgSSB3b3VsZCBrZWVwIHRo
ZSBzY2hlbWF0aWNzIG5hbWluZw0KPiAoIkRDREM0IiBpbiB0aGlzIGNhc2UpLiBObyBuZWVkIHRv
IHJlLXNlbmQsIEkgY2FuIGFkanVzdCB3aGlsZSBhcHBseWluZy4NCj4gSnVzdCBsZXQgbWUga25v
dyBpZiBhbGwgZ29vZCB3aXRoIHlvdSwgdG9vLg0KDQpZZXMuDQpJIGFncmVlIHdlIHNob3VsZCB1
c2UgdGhlIHNjaGVtYXRpY3MgbmFtaW5nIGZvciBidWNrNC4NCg0KPiANCj4gVGhhbmsgeW91LA0K
PiBDbGF1ZGl1DQo+IA0KPiA+DQo+ID4+DQo+ID4+IFRoYW5rIHlvdSwNCj4gPj4gQ2xhdWRpdQ0K
PiA+Pg0KPiA+PiBbMV0NCj4gPj4NCj4gaHR0cHM6Ly93dzEubWljcm9jaGlwLmNvbS9kb3dubG9h
ZHMvYWVtRG9jdW1lbnRzL2RvY3VtZW50cy9NUFUzMi9Qcm9kdWN0RG9jdW1lbg0KPiA+PiB0cy9V
c2VyR3VpZGVzL1NBTTlYNzUtQ3VyaW9zaXR5LVVzZXItR3VpZGUtRFM2MDAwMTg1OS5wZGYNCj4g
Pj4NCj4gPg0KPiA+IFJlZ2FyZHMsDQo+ID4gTWloYWkNCg0KUmVnYXJkcywNCk1paGFpDQo=

