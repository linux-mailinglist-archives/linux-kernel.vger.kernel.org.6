Return-Path: <linux-kernel+bounces-405888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FD99C588F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35B5C1F2348C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 13:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9AB13B584;
	Tue, 12 Nov 2024 13:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="gOtbYAdq"
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021105.outbound.protection.outlook.com [52.101.129.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4392A433D9;
	Tue, 12 Nov 2024 13:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731416696; cv=fail; b=c/BilvcwihG36sf9s5GfrLVEG9TGEKD7COidajHJeDILwK++uHV1MF05VxVt90QSK+ubsyyR6mPEcMvgSvWM5F7zfpLYnMlBjHdo234gjEUGLbUprFr0+ckdaxmbH0RJiDIifp3NQ81f84ppNC6tzxR27YW6+RTVNZaIellVtZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731416696; c=relaxed/simple;
	bh=wxkaJp57uDuwtDv8nOUSq8pS/WMg1ifKFs+vqf8yazI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=afQcxQz7mBq3pS3FEdnk/quHyKITx+4jfPhEQjOlu5E1isS1EwBH1RuamtwWdmbrXYjB6DChCUgHZFqLSrXH44rPKlQ8QotvY5k1mBez1/6FLFdz+HXNyOU0908TFc3L+M/h8KLeZZiUjiVg5k4fSmHScOSF9RJk0/ifWRrMcl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=gOtbYAdq; arc=fail smtp.client-ip=52.101.129.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=geHSo71opXMmtWl2rQTjVn0ppKc5qPlAfWQN24RKlS7ZvurdWeunkmS1jKusMSKtmKPH1B+0iSDWaUDECe8bBh7hAzyUUvT2b8pm9EukQkjUhJsN2H+mfqph3q1h6PoEeGrhE4FyPQezGLTy3q1j6osU5IMguNydjNRA7WoaI+PX0udCihtgdxaT8EGdK9QzjeMHgBP2by9cux6rQl2kKMTqJPH4uk/X5IVbV4FqF1Jre0cNBoJd+QKbAAD93/G8In6kEWvvOkAFjQO95PXlyfUl6drfOOIFkuDGwwwSYMo7ddT0SaJRAc4a56eoDwHSrSnj+UCdIR+SOmUwxJymKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKtnalvDMxt+G/A3o+mCHtM8XSr9QgToBzSjsJ+8e98=;
 b=rrdAdUEVuz9zGKi6q8br1qgvrnOTiIUSp0IfXl+2sXtid3PMgysPYVbFYwFOfMiaI+FhIt3AbnosgTkPJGZ0LqXXfpXXyreSqDCyLSCKOpSyp/atb51EE5H30goop9ZIDsjaFmLxyeCoKkHW8H2s/0yFVcPsx3HHtjU6mSQVyefeOudBBxuPnoArGvwCPWBll+s9Be6Nt4UcT5P3YHrWu/8PKEajoxJpfICT2rDsyE6wrJ6F9ldigdetygYArIPB1T46/m6iNsKJsGbi90EcAXif/CzJ+wusNcVHUZrKJKuhSplXRGyyjFPF5VtooOhjU3ryLspyfzviOMa9pgIIOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKtnalvDMxt+G/A3o+mCHtM8XSr9QgToBzSjsJ+8e98=;
 b=gOtbYAdqXx18DgJ0nb7pITQM7YZfasussiF0tA/OQ3oXWsw+wk4sLcXoVbgOUvpJo1pV8r7EnY3JIeaHSAkvttaBLfJWMOvcLcMnZlC+DmVHmNKmd+GXs9igQyKGyMcnvWmdX8Gc3Ql6oBNrVicQYpyY++3wlh71lvftLRqpNAdsi/S4j4nBzTmvsoe4oq5aPV+x+0hqu5q7LHrdA9iCTwJTxlkFTmwcVLXUMmClfwlANZsU7BUfCZZouqb4XAy+w2i6FXoewuTQlDEvsg3c0AqMczUIqus4NIbHcgRtBhzOg0bfi3y3qEgIo9iqFg3Rsc4jDI90KNXD0tF+CXwXYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
 by JH0PR03MB8113.apcprd03.prod.outlook.com (2603:1096:990:3c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 13:04:47 +0000
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::9d11:d1f6:1097:22ca]) by KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::9d11:d1f6:1097:22ca%7]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 13:04:47 +0000
Message-ID: <8a006cf8-2f65-43bf-a990-712fba01f0fb@amlogic.com>
Date: Tue, 12 Nov 2024 21:04:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clk: meson: Fix the determine rate error in
 clk_regmap_divider_ro_ops
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jian Hu <jian.hu@amlogic.com>, Dmitry Rokosov <ddrokosov@sberdevices.ru>,
 Yu Tu <yu.tu@amlogic.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241112-fix_childclk_of_roclk_has_been_tampered_with-v2-1-64f8009cdf2a@amlogic.com>
From: Chuan Liu <chuan.liu@amlogic.com>
In-Reply-To: <20241112-fix_childclk_of_roclk_has_been_tampered_with-v2-1-64f8009cdf2a@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:196::6) To KL1PR03MB5778.apcprd03.prod.outlook.com
 (2603:1096:820:6d::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB5778:EE_|JH0PR03MB8113:EE_
X-MS-Office365-Filtering-Correlation-Id: 9595150e-534a-4e25-99d8-08dd031a95c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eTdzakpWMkJYQWt0VjRGa052RTJSdjQwQUFram1hVm9qeVp5ciszampzcUE5?=
 =?utf-8?B?bzVpM0JaSGRZZlEzUisrNnh4Q0MrWWo4NHA3a1MvTnk0QSs2VW0vbERVS1NI?=
 =?utf-8?B?MUZueXNhWHdIWUYwRzlQbXF6WG11dmkzY0xaQklWZDVkamlxc2NWRFEzWnlz?=
 =?utf-8?B?RzR5Tkd2UUNUelhHNDJmUG0xYTJvalhZN3h4L05kRWM1bzlnZ3BpVjBPSllY?=
 =?utf-8?B?S3JLRjA1ZVhONUxGek5oeFlIellMQ3prVkU5MUtzdG5xUWZFb2U5RzAzeURr?=
 =?utf-8?B?bmhMMlZjeGtHQ2R5LytKVUwyZWY4YlpUS3hBdHVqaStOM2RqdkNOL09CVmJr?=
 =?utf-8?B?YitIb2lMTFBMNmlsemYyc1NwU0hGMFBNTGNXakVxb3Ewa05ZSExaYWV3TkRS?=
 =?utf-8?B?NkprcjVTaXM2ZXhBKzF3aTFNL01CZFFYeUp3RFluWEM0cjM1Q1RLYmVvdUtH?=
 =?utf-8?B?NHhGNFc1a0xHYmEwT1pmWFp1T1IycHI2bmdra1V1S1BZcElVTnFXd0IzSk9I?=
 =?utf-8?B?VlE2VzhzbUtQYitXTC9ESmRST2tEdVVqWnI2OFA5QVdWdUlrMHBuajFKanlZ?=
 =?utf-8?B?Q3U1Nm1CM3M5N1F3eVpBdDdGc3ZyaDhDclF1Y2lKQ0FWN0FyNlhpTHY0a0pY?=
 =?utf-8?B?a2N2VDk5TE5oMDg3eDdDTGZndVdVVFB0RUtXbkNRUktnRWJZMlJqeUlsV3M3?=
 =?utf-8?B?c0dWVUFLRWNycE5oSWpCM0FqNWFOY2RGM0VPZmZ3bnkyYmNLRWdNN3hoY1hG?=
 =?utf-8?B?NXFlUTVyNnZqcElQNGYxemgvcFFZWGFSWmh6T3BxaW1GcnpzSzQyY0M5UU0x?=
 =?utf-8?B?VGRwYXZWMFQycm84a1NmVHhCSlFSUWdTUER5MTFQRC9DVFhJYlpPNFBzWEJH?=
 =?utf-8?B?Uk9pbUUzVWR4aFFhajNHMURPNGFWWUV3WnBSdmdjK0xlcktkVXlSN2N1UENm?=
 =?utf-8?B?Nzc1NXZsQ1lUbDM5aG1mMDNoZ0Q3YW1lNFBsTGY3TlRTOWowOGN4YVYwR2RK?=
 =?utf-8?B?L1MxSmljdU9xbExBY0ttSzJhSUpyeWFxT0lBdDRYUTRnYUV0Q1Q0WU1zY2Iz?=
 =?utf-8?B?SDBMR291L2I1cEVYdVp0SmxxUUFYdTd6QVBWbnJYSzROUGhnTjlFM1Z3c2tB?=
 =?utf-8?B?OFZLcXE3U2g1eUM4Y0ZZUEgzblBjWWc3VHdod1E1WG80Y20vNC9taVZFc2Q4?=
 =?utf-8?B?eC9JSzJNTlJkU3Z1K0gwMUZWa0NGN0s1bU9hbFRxcnBScDVyNnFkdjNsbU02?=
 =?utf-8?B?ZkE0QXUxdWY3Ymx6Wks0TElJaFpJQVRyeExGM3NWbWMzeDBmNS90MENEU0VF?=
 =?utf-8?B?NXRGVU84M2VrcEtpSUs2ek9FYVZaQlYzQytLaWZRZnpYQmd5VkxSMzFVdlFN?=
 =?utf-8?B?SUFZNnRoejdYLzRVTlVlNVBiTjRFaXd1bi9nV0FKU0xRdWpRK1JiR1NlV1Yw?=
 =?utf-8?B?em91bjQvWnBNSzVwYnRmQ2NRQWVITlA2SmNkSnZoVTd4TURWVG1NeEdhcjgy?=
 =?utf-8?B?MzZINVIrak8xODkzalpmOHVHVWNqS2tIc3hFQkFqdjlod2Z6VW9IbXZHdWcr?=
 =?utf-8?B?UVVaS1Q0cEhiNFhkWXJ6cjkyNDZQZkY0Q0o5OGZMU3JZV3EyRWlUczJoWERw?=
 =?utf-8?B?UkdoejJKVnNsaVdqN2M3dWNRdGIrUVp4Y3BEZmVPbkQrWnl6LzNTS0FwZjVl?=
 =?utf-8?B?YTFlMzdPN0pWQ21XV3FBODlaQU00NTd3OVZIWXFVajZZUUFyUzJMUFg1b2dw?=
 =?utf-8?Q?RdNzgt7Umc8yoHkvZF1QSKKoRbAO3H4S1dBbJp2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5778.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDJ4dnJDdjRETklyaS92NnY5MXAreGJYNnp2Y0w3Q0xEcUVXRmNvdDlaa1Ew?=
 =?utf-8?B?QTh0c0NWRDF2LzhvQU9FNU95M0JDc2UzVzE3SVRlak5GRHZhWklnZllRQTZr?=
 =?utf-8?B?MjJmakJac0ppRk5YZ2V6L0VLa0FPaTZQYjd2TjZXcVFzWG5mQnJjQUZadS8x?=
 =?utf-8?B?dldIOEFHTXZhVWtyMXlCamhQczVBN1RqcDVKNVNzM1JhUkxSaU9Mc1dpZ2l6?=
 =?utf-8?B?ZG8vazkyNU1YSy9tMDRCZE5IbkhRSWZCZzdoV0loS00xQnNMNnZYVWxrY3ly?=
 =?utf-8?B?NDY4UEoyd2U1T0ZXRGwrcmlINVRSODFmOWNJMnNIcE1VK2pzS2xtdWNpemN0?=
 =?utf-8?B?aDBxdm9qY21zR1czTlRsMXFhdUdJL09mbHNrOUs3YjZPakpzUzF0b0pnRW91?=
 =?utf-8?B?RG9laHhRcnljVTBsaGhEOCtnVStqNjNIbE9EQjdObVRaZS9DMnVSSlFPUFNK?=
 =?utf-8?B?NThCaGhzTkpYMWpvY0lzNWVBV1k4TGsrbXBxYlNsRTVOcGpjc2ZiWXgzRmI1?=
 =?utf-8?B?V3EvT1U3RkpnWk14RnJVOFYrc1ZoVmtaRDF4cHN2Z0htYXRTb0J2UWducEti?=
 =?utf-8?B?S1lmd2hmTTIvamh5ckkrZVhDVkNsOVBpaE5VUGlXRXdVR1JEb1I3UHRkcmhP?=
 =?utf-8?B?Ui9wZ21ScStVQ0hjT0NqYmNLTHpXYVh4YXNoU1g4emkzNGhHY3JRd0RNNGVS?=
 =?utf-8?B?WFIvT0xsYUxkT0FReDlLNlV0V3RUNXpyVlRvNE52cHJSYXJZNnY4dlRjV3Uv?=
 =?utf-8?B?cVF0bGthYlhaMDJtQkM5aDFwTzVkQ2NpajRhN2p0T2xsNkIxTHhxcGw5SW9h?=
 =?utf-8?B?YU9aQWVic2I4RndlVk9BVDVSYjV1ZUtVZTAvYm8xelE5dnZlMDRnZEtvY1ZO?=
 =?utf-8?B?NC9MTFNDS3NYc0s2MC9ZdEFPZHpLSkR6ZGp6QmNMaVBVRWlNdnc4YXd1SUZY?=
 =?utf-8?B?MTd6NzIzTENDenhSWm5sNjRwMExZMi8wdklhTzFVM2ZUVGhEWkVobVpPSDZW?=
 =?utf-8?B?Rm1WdWtXM2Yvc2lDUEwvNEpGOUlldVVHemtMK0ZsbjYyZGR2cFk2WVlsQXB1?=
 =?utf-8?B?eHR2RXdwVFNlaTYxYXA1cVE3R0U1RXkrM0JqamVDUEFZaUN3cjZNY084QVZK?=
 =?utf-8?B?REYrZEdjV1Q1eUhaT094b21ZazVFVU16Y3ErbDExaThpRGprM3pCcEp5bFlG?=
 =?utf-8?B?NFNrQ2UwUFRRbkNwK01JS0RuL1JNZjRJN05wYjdyV1NCblRRa0l2WVhTN0JY?=
 =?utf-8?B?SDFpbTNWczhyYWhLUWllWTZQd1V5Y2hSeEFTaDJIa21wYTZZTHRZT1pQS3Nq?=
 =?utf-8?B?UE1lZ0oveko2dlA3SzhKSEpNWDlpZHlDS3FuZW5kMkMwT2xCSldaaS8rZ2p1?=
 =?utf-8?B?VGVJNktNUE9qVWM5MHVEQ0VxWGJodjZlS0JYV2I5MjNxUGwzb3JGa0JqSzhj?=
 =?utf-8?B?TVNEak5BZFBBV1dvbWJCL3J6a1J0QU5JcXZSaGVWdEo4RGNQcHREZnByWVgx?=
 =?utf-8?B?OHEzaC8zTk5uRU42a3BCVTUycDc4d1RzSHRTZjNZVkJYT3FuejUvQVoyc1VY?=
 =?utf-8?B?ZVpFN2ZScmVXQi9qemU4RDM3U3Rob3F4N0xOVXZ1NmNmVHhHZVB6S0J2Ulgw?=
 =?utf-8?B?VVlGTUROamI1ZUpnbmNuaG9xbXA2dmUwTlFjZTlrNDRHd2JXU2JZR00rNlBz?=
 =?utf-8?B?cC96ckFxOXZiVmdXRExyWFVibUpOY3hkbkpWTVBJN0UrYnZyMTA1SzFHM05k?=
 =?utf-8?B?NjFTMW43aXM5VElOSmpIZHJ6Rmg1bkViRmtqeTBuejF4ZlNGZFI4UmpCd05a?=
 =?utf-8?B?WVRWcWMwZzhvb2RBM3F6THRNVkh0dktmNUM3ZUd4RnpzbG5aM3YvdEowdEhD?=
 =?utf-8?B?M2VPVDgreDhkYjhISTIwTlNsL3NKK0xERDROU0pjSzhJMlBYTGlFdUZkTG1I?=
 =?utf-8?B?Wk1hM2E0RVJqOE9PQUIrSG0rNHQ0UEtkeVEzbmFwbGR1VVE1aWs5VGJOQTZY?=
 =?utf-8?B?ODNIWjJ4V0srM1dEM0JHYThsTFBRQzVPajh1TDkyaldtbGZDem9mVERBU3BJ?=
 =?utf-8?B?dkZ1NEdRTmJQSXdIcVRONGFGclY2QnpqcG1MRTZCTXpMZUh6dFprRktzWjNZ?=
 =?utf-8?Q?KuhgnebAEqgrKM0GYDSuJF0Gl?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9595150e-534a-4e25-99d8-08dd031a95c2
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5778.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 13:04:47.4315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4hyTb9E56ndaHYPGYuMNnbD8AlJbFy0f0EeU8d38hVOGgWRH86BD2XEeQ1s4w7YQ40pJcZXNHAtyQmbGXy+BBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8113


On 11/12/2024 8:57 PM, Chuan Liu via B4 Relay wrote:
> [Some people who received this message don't often get email from devnull+chuan.liu.amlogic.com@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> [ EXTERNAL EMAIL ]
>
> From: Chuan Liu <chuan.liu@amlogic.com>
>
> The rate determined by calling clk_regmap_divider_ro_ops with
> clk_regmap_div_determine_rate is not RO, which will result in the
> unexpected modification of the frequency of its children when setting
> the rate of a clock that references clk_regmap_divider_ro_ops.
>
> Fiexs: ea11dda9e091 ("clk: meson: add regmap clocks")

typo of "Fiexs", corrected in the next version.

> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
> ---
> Background: During the execution of clk_set_rate(), the function
> clk_core_round_rate_nolock() is called to calculate the matching rate
> and save it to 'core->new_rate'. At the same time, it recalculates and
> updates its 'child->newrate'. Finally, clk_change_rate() is called to
> set all 'new_rates'.
> ---
> Changes in v2:
> - Remove the CLK_DIVIDER_READ_ONLY judgment logic in
> clk_regmap_div_determine_rate().
> - Add clk_regmap_div_ro_determine_rate().
> - Link to v1: https://lore.kernel.org/r/20241111-fix_childclk_of_roclk_has_been_tampered_with-v1-1-f8c1b6ffdcb0@amlogic.com
> ---
>   drivers/clk/meson/clk-regmap.c | 36 ++++++++++++++++++++----------------
>   1 file changed, 20 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/clk/meson/clk-regmap.c b/drivers/clk/meson/clk-regmap.c
> index 07f7e441b916..edf65ca92c7a 100644
> --- a/drivers/clk/meson/clk-regmap.c
> +++ b/drivers/clk/meson/clk-regmap.c
> @@ -80,21 +80,6 @@ static int clk_regmap_div_determine_rate(struct clk_hw *hw,
>   {
>          struct clk_regmap *clk = to_clk_regmap(hw);
>          struct clk_regmap_div_data *div = clk_get_regmap_div_data(clk);
> -       unsigned int val;
> -       int ret;
> -
> -       /* if read only, just return current value */
> -       if (div->flags & CLK_DIVIDER_READ_ONLY) {
> -               ret = regmap_read(clk->map, div->offset, &val);
> -               if (ret)
> -                       return ret;
> -
> -               val >>= div->shift;
> -               val &= clk_div_mask(div->width);
> -
> -               return divider_ro_determine_rate(hw, req, div->table,
> -                                                div->width, div->flags, val);
> -       }
>
>          return divider_determine_rate(hw, req, div->table, div->width,
>                                        div->flags);
> @@ -127,9 +112,28 @@ const struct clk_ops clk_regmap_divider_ops = {
>   };
>   EXPORT_SYMBOL_NS_GPL(clk_regmap_divider_ops, CLK_MESON);
>
> +static int clk_regmap_div_ro_determine_rate(struct clk_hw *hw,
> +                                           struct clk_rate_request *req)
> +{
> +       struct clk_regmap *clk = to_clk_regmap(hw);
> +       struct clk_regmap_div_data *div = clk_get_regmap_div_data(clk);
> +       unsigned int val;
> +       int ret;
> +
> +       ret = regmap_read(clk->map, div->offset, &val);
> +       if (ret)
> +               return ret;
> +
> +       val >>= div->shift;
> +       val &= clk_div_mask(div->width);
> +
> +       return divider_ro_determine_rate(hw, req, div->table, div->width,
> +                                        div->flags, val);
> +}
> +
>   const struct clk_ops clk_regmap_divider_ro_ops = {
>          .recalc_rate = clk_regmap_div_recalc_rate,
> -       .determine_rate = clk_regmap_div_determine_rate,
> +       .determine_rate = clk_regmap_div_ro_determine_rate,
>   };
>   EXPORT_SYMBOL_NS_GPL(clk_regmap_divider_ro_ops, CLK_MESON);
>
>
> ---
> base-commit: 664988eb47dd2d6ae1d9e4188ec91832562f8f26
> change-id: 20241111-fix_childclk_of_roclk_has_been_tampered_with-61dbcc623746
>
> Best regards,
> --
> Chuan Liu <chuan.liu@amlogic.com>
>
>

