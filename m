Return-Path: <linux-kernel+bounces-525249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9F1A3ECFB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 07:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6C437AA9C6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 06:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D39778F20;
	Fri, 21 Feb 2025 06:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="A/3iG/jA"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013058.outbound.protection.outlook.com [40.107.162.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9E11FC7EC
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 06:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740120314; cv=fail; b=RmyV3ts1Glu0prwd9jqGmPy6LzuLJXMtQavexYxwgQYRDEcATo0TdYF6V3rMcM3oJfppXhc/VIc/ppJyrW4v8i454HPyUJjylhyQrl102Pnw4nCbRe7o9ESyT9BbXoOwLJZZK7b7hhCDBg6bk3iCMw/hc9qVv/LAEltX8/tzLlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740120314; c=relaxed/simple;
	bh=MDxnw1+BVAHc00Y0HDxqLDNsNqABuFY5r/TNBqcfe2g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lEhD03CK1yzoaAKlZO4qbGjUm4KmkXAM0ESoViKncsRwLFhKDVDw0hUInOkmSL08ZVPhE5GNG0hR/bn0pK4gFHZsKuFd2BId3V3uKuOkbuxztkV3AfwQ3Xx3jW3nB4iYsT8r/GG+oFKyL338O92q3GjPy/hS+ZEOSD9wlDoFCqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=A/3iG/jA; arc=fail smtp.client-ip=40.107.162.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X5kmHXJXEMqbPw9nDerImelfvfnkh3PXOjdKRpEvU7vj9YYeJdXEmCjZ7Pk45RYU80+ZEKGcJIC02+70LeAAIUx8LOFGUGu3J23aIe92rR4OkbEoLKnJpl+5xgXq8nBsiglbJ2Uus7uc2MUp/Gg71OSgcga4py55/ElPswu4cycfyzihMuH19UdcpR4wPvfQJ4+BrOfL1hjD7hVslW8wCnBH/sOH8Kk8cudSeO8+RgqDfpZL0MFd9icXYg987iAQSmXREnZOHk/5G1wkzhnr0UzubkQiZsRMU9o9+nR8dZiKiojl9reyITpEXfiw0wBcoTQZT0Hu/6b+tojDzLxR0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1jR4DtqK9Vcv7TY9qaU+jDZDBcbW6ij8Jw+qRiq8wyo=;
 b=dE8cpCQSQfLSx4/38UxouA+4m4sNELD5ocyWqsnSQNoUvqJZp20m7dz3KdWC9JxoGNBRqaEkFVAUPcUwF8V/CRoBvtCc3BH3x0IeYnRm/xmpV/iPMAWHMJS/iB89Lyu/2uKoho7R9I9iXhvzMaY1Lnzto4Bypbk7knhX443aMSM7xcwpvfyb5LorazA6WWqrkuyd7XL0jJEdhJjBelmgKj7sTBr0e1Q8JxqAknbEHDlBYVSw811wMaUe95mL2zihlAZXxV50IDAI6COOIqJ5CEYn29A7JhRwy4ng9lXW9ldhyevGUtbfJflUwEJpCoS48AtJ72adTOvsbJimKfcjcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jR4DtqK9Vcv7TY9qaU+jDZDBcbW6ij8Jw+qRiq8wyo=;
 b=A/3iG/jAkHQnoiAeMC4wmxg5Y60QuRQeFDoTgGIwbb4vcRfYz4R3sxm1Vs4RQOwpZ+b8Hze5M0Sse7P7Hohzu0WK/4vN9V3XjXqcYyioB4zpMSQEDaFJBW0iocfwNkFnUyTW24b2oIlLDqwxygW0jbGIZyQp6VdXrfm21ha5dNJpJ0lqzOlXF1fZA3WRSpQGp0/Z/KPsuHF0C8b/QkX3sZg385oV1spmJSJvzVNx0GUp3q+fkmIuJ/Nx24DUKZnteEJGlqH6sy6iBKP80t70CDNCr1sixb+pUKoRL2o250LBcpWGitf7D8Dl0B9p/q6WdDXICZXvob3vj7oL4/NHKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB8304.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1e2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.13; Fri, 21 Feb
 2025 06:45:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 06:45:09 +0000
Message-ID: <8e16609a-7e19-4d4a-951f-58c8bd012086@siemens.com>
Date: Fri, 21 Feb 2025 07:45:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: scripts_gdb: Python Exception <class 'gdb.error'>: There is no
 member named nsections.
To: Antonio Quartulli <antonio@mandelbit.com>,
 Kieran Bingham <kbingham@kernel.org>
Cc: open list <linux-kernel@vger.kernel.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
References: <85894bbd-05ef-4e40-acf9-98a079c9e2ee@mandelbit.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <85894bbd-05ef-4e40-acf9-98a079c9e2ee@mandelbit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0129.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB8304:EE_
X-MS-Office365-Filtering-Correlation-Id: 128b863e-a268-49c9-e3e4-08dd5243489d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UHI4YjRiMHFETlE1UXBscDU5c0xMT3RaMVFzNCtseHAxQVdaU0N5aTlDR2pN?=
 =?utf-8?B?QlJ5M291WHorck0vSVVaYUcwcSsweUZMMVZ4YnZ3OGdzZWZVYnB0aHp3R3B6?=
 =?utf-8?B?TDdSdEV4dUVuZHBJTXAxcDNMZzdIUHp1ZVJmamhnRkVDUktKaUl5MTh0Y0Nz?=
 =?utf-8?B?bysyL2FtY1RSL3dTaGZaOWpIYUovK2lVTHFuS3p0V0Y0bmRiQ2k0MkNuU09k?=
 =?utf-8?B?VTUxSkJrVm9BeWZ4VWVERk8vc1JrWkJLNFZqckF3a1A0dWFlY3FHamlYUVNM?=
 =?utf-8?B?YmhyWklCeGtzSGV6NjA3dTYyNERJM2g2WHc2VUdHM044ZmFpc3BwUVZ5MkRC?=
 =?utf-8?B?eEpzU3NVczYwWExYekpnb1dhUHZwaUxIK3U4eWZ4YWsvalErVml0QitFeUNy?=
 =?utf-8?B?RjhTb3Fxa2NiTGUzMTJzSFgwUXRUZVBwYUhtNWZBM0FmWnVvQzFZYi81VFdN?=
 =?utf-8?B?OVBlay9wSHkyKzBMeXdxZW52WHFNMUhUSTRXT3ErUjdqWUxScmdsK2YzY2Uw?=
 =?utf-8?B?ajVzVnBoT1lMNzR5TjRtMy82di9vL1RzOUloSTFwV0E1dzltcUVjWldad2NI?=
 =?utf-8?B?UDl0cFYvQmZDQ3BpbFE4MzgyWE5La2J2QTVmWVZTNVZXYmNpak1ocFp6SURY?=
 =?utf-8?B?SVlJQkpDOWYrd09ZaTc5dDlKUUtFUVo4TkVRZXBaSERrZUhDSERaeDVoc3Fv?=
 =?utf-8?B?NDlBZUgwU2tJODA0aVcxMEpybWcwUGYyU3dJcEJMdm8xamw1WUlBSXZtaHo5?=
 =?utf-8?B?RUdTeUlPT2JoaHRHcWxXTWZEbHVsdWE5dHNMUWU0Sit5T2dBZ20zbW40STU4?=
 =?utf-8?B?bXI4WU85eG1uNUxlUjk1QlRjYkFZbitEY1JyeGN0OUU1WWNySC9lZWl3d1dm?=
 =?utf-8?B?b1RmWTZSTzIvTzNiS0RGRGdBdjd6dkM1MENnY3lLZFJLTS9iamVRb1d2SHFV?=
 =?utf-8?B?U0U0NkhHQUh5TXpaMVY1amVYUzJMdGhvbS9venphaUFKaW56ekczZ2NZUGhF?=
 =?utf-8?B?aFdvR3JyQ0dXOFRLSzc1SnJYME9yajV6V2NpTG1wQ1pjS2VBZlR4N20xSVdj?=
 =?utf-8?B?YUI3T0FHOEVmSFVUOTVGQjZrYi9KYy8yakcwME9mWlIwc0d2ZlYyajcrd1NC?=
 =?utf-8?B?UWpqTVRpSDZaTHV4NjZyZlBqL2NHZjBaTTFKUmhKRTRiMFErRTF6a1NDSEp1?=
 =?utf-8?B?OHo2UFJJVk1yUjZCRGJPVDJFZU00cDVNWnY2REZrZ3Z4dnBib3hZWmMxVVVL?=
 =?utf-8?B?TVN2N3JEeDkrZlVvT3NvZ0doWXhqS0czUTdSMFpkbFdNeG9pL3kwcHFuMzVa?=
 =?utf-8?B?YTFXVVZUNjdXMk9rYjlhaHRRRnU0Q3M2cllMQXlQdVV4M1h1YS9YRDNKV3Nn?=
 =?utf-8?B?N3ZMOWVJb3JtdXN1Q1ZwRGdsaXJOZG9janNYVXkxSEFMWXlnTS9BVW85ZHBi?=
 =?utf-8?B?NGxlRXBXSlk2Y2FabUYwUjBWUzllNmNaYjFYOTZwSU1EQjBwZitxVEhMQmxy?=
 =?utf-8?B?VFRkN3BhR3dXMXgxRTJhUEhBRXFLc3hWNVNxMnc1TUpHMVhDWDg0anNXcUl3?=
 =?utf-8?B?RW5zMHJPbzB6ZXlSd0t6QU1lKy9uNVVHbVhCcy9uWkZhYXh4MmRVdTl0UnMz?=
 =?utf-8?B?U2FVVi9DWHYrd1I0b1ptVWNJYWh2ZEJ5NGh3UllJREE2SGpuN3ZjV0h4Vi9B?=
 =?utf-8?B?UWltVGRsYkdSd2RGOVJsQTZSbkFKbWp2dUMyS2hHaGZaZnpIL2FuQk1aQ0s2?=
 =?utf-8?B?N3M4bURobmFqV09Jc3lUMUpaR3Z2RzQ0Y3VNdnpRSjdaUTc1dnVUZUFBTmtr?=
 =?utf-8?B?VThUbFlWRGQwS1JDcXEyZ0QwOE1PSVJJc28vNkFRU3BzZy9wQktmUHJNeUtS?=
 =?utf-8?Q?HG+1D6QCRaj6m?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eEtsNnd5amlJbE1KMk9ZblFBK1k0QjlkVlBZYkExYTVXQVJiNndLUm5IeElx?=
 =?utf-8?B?TisxY3NHNXl2REtOc0J1MWo4MUEvdXBDcjRKZHNDNVVpWnVwYUhucUJSN21i?=
 =?utf-8?B?MVZEOFpocW53SHF6WVNvdEZyZ1BDUHZOZnFtajIrSmh4KzNIVDJGdlRiekd1?=
 =?utf-8?B?bXo5U2dLMnRPMU9uVERiTEkzSHNIL0tGb3pVVXRaY1V1Qmd5UkVRRUZiRXY2?=
 =?utf-8?B?R2tZS04rVmxSMVNIWkZEN2EyYXFrc3RsNlBuOERvZmNkaVZ3eWs2dWdjWmFE?=
 =?utf-8?B?VjFGbTNVeXlpUnJLWVFRSFhRbmNMTzFjVTU1K0kyTHRNVEwrQTFvaXVqaWZX?=
 =?utf-8?B?VWoySjc3UXlyVjE0SlBkeFhVUkNLM3ByeURvd3B1VStXc3FBc1RZQmpmdzVM?=
 =?utf-8?B?VW1ua2F5Q2s5YlFQSHhiZ3p5SUF1cldFMUxCK1MxVUN6Ui91VSsxVFZzV2pS?=
 =?utf-8?B?VzV1Z3EwbGdRczRHbWRFWTNHOTUwVlE3czBCOGpyTEFnekRoZ21tOEE1VlJm?=
 =?utf-8?B?dm96Tk0zMjQ0d1NMdytKWGhMZ3BSM3RqU1RqMGNPVE9ZdmhnS2xZclpxelk4?=
 =?utf-8?B?N0U2MVhvdlh0R3lLZUUxTEg5VVZtc2QxUGNvVDV1TmkzNUhEaE4rUTVpUDVj?=
 =?utf-8?B?dGtqNDJnYmxxb1RPUFBMcXd4S3l1K1k2VlBQSHovTGJWYzV4dlp2YnNJdU5q?=
 =?utf-8?B?czVkOExnWDJyRFFRZjFFa2YwcnhxSU5QdjBxZmtFY2JxRzRraHF2TjdiZ3NJ?=
 =?utf-8?B?Q3ppUENWcWJTOHhyV2xEN2g1Z0RDQkovdDdkeFR4bkVldUwzTmFKdi9EWnk0?=
 =?utf-8?B?MWZDN0VJdTdPWENpUjl2Tmx6WjA0S0hrd1c5Q1lPb0hsMXAvKzNaaEpEUmRj?=
 =?utf-8?B?QTZVLzl5SGlzQzZGQUZNWjRHQVdDWFlPOWhOTVNOSUlZaWhOeE9wQWJUWDY0?=
 =?utf-8?B?T3pLRlg3UmZiMU1kNEl4NDRoR1ZUT3FoLzM5UytKMUdDdU5FQ29FcUx4Qkhq?=
 =?utf-8?B?ZThZQlNuNm5BRndNU2JlcWhOZmI5b1N2NGtqQ2piKzFZM1JQc0ZIc000STFZ?=
 =?utf-8?B?NVR6bUJMS2ZsMUg1WUYvZzFIWUhVRDBCS1kxUElTRHF1ZHQ4K0V5b0dSSE4z?=
 =?utf-8?B?UlhrcVJyUm1SaHdmMWZLdUVocmFMdXd1a2RNSnoyUk5MNmFjMURTai9kMTBz?=
 =?utf-8?B?UVVEUXNSbDZYaFBqMXNkZ1BBQmxxS3R6TC9wZk9UT0ZrVlRwdmZZd1Ztcjhm?=
 =?utf-8?B?VmJPckp4K3g3K3lTVWxpQ1FsVkExVFN3dldkSm05ZW15bVFab05IcXBCdFIy?=
 =?utf-8?B?MG81YUVGNDhNL0ZLc3QrV3lTV0Z0QkE5UGtRWk1BZ1JLSjA4aVpSWDVUWG5U?=
 =?utf-8?B?djBVREJDRmVONDMySk80M3pDSGNnckhEZDF2Nm1DZzN6U2E1cE5QRmowTE52?=
 =?utf-8?B?YzZqRldSdFZWbDNvbmdOeXN4VjhqY0JNV05Xa29qdjJETGVjOTZJVnlFQWJ4?=
 =?utf-8?B?UGNJcjQ2TkZieHRad2o4eFloS0JndWU1cFRwWThZeGozcmZOaUdlZVZad1lm?=
 =?utf-8?B?RW5zL3gzTXYzS2x0V2FxRVI0QVNEeUxaL2pvUU01NXZIdkQ4RTdKTEV2NWw3?=
 =?utf-8?B?MWhzZm5hNEhuVnlHc3pxNUM3VXhhNi9vazVieTJZUS9OeWZFN2VaRGRycmpQ?=
 =?utf-8?B?NE94R2VvS1kyaGdkaE83eFpJN3YxY2ZsSnZqTjFaRXBKWmJoRHBsM2syMjdv?=
 =?utf-8?B?dTluSDJPVERXc2lhbXUzVUY5WGlvbXpSMnNPWnhveC9GbDkvRU9nM0NoSTlk?=
 =?utf-8?B?bUp2TUttY2xMeFRHRytmUkFPSUZFZERGUFNhcUdYb1VaMlZxM1ZwZTBPVmd1?=
 =?utf-8?B?R2VhK2J6K1U4OERNeDBxK3FMeXo3ek9VVkhWbE5tWmNMbXlxTmNDNEdOaVNm?=
 =?utf-8?B?WTBHbTVVSkp4RUJZekpVZmN5SUdwRGlUbVdpYlBYZ3hWbzB1TXh3TXp6eW45?=
 =?utf-8?B?MDExeXpjYzhlNjJmM0ZiMUVubnpnWmQvcEZDZUN6anZnVVBlcUMvVWk2ZEZY?=
 =?utf-8?B?TDFoUEYzUmhka1ViWnhmZnNNM2RVeGRQK0J2ejJHN0IrUGEvaFc3aVllY3JD?=
 =?utf-8?Q?Cfe2REY+U+7vIMgud4BA7qAvn?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 128b863e-a268-49c9-e3e4-08dd5243489d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 06:45:09.2394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xyjVtvLr04O3i0QMyKR7fK40kIZCTKLcEXOP9PX8c2gcYeYkEW61FUKUbRLa2dej2scPV5T6l2khAIP42At3NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8304

On 20.02.25 16:21, Antonio Quartulli wrote:
> Hi,
> 
> I have been working on the new ovpn linux kernel module since a while
> and your gdb kernel debugging helper scripts have been of great help.
> 
> However, recently I have started hitting an issue I could not explain.
> When my qemu instance loads the ovpn.ko module, I get the following
> output in gdb:
> 
> scanning for modules in /home/ordex/exp/openvpn_dev/linux-ovpn-dco
> loading @0xffffffffa0000000: /home/ordex/exp/openvpn_dev/linux-ovpn-dco/
> drivers/net/ovpn/ovpn.ko
> Python Exception <class 'gdb.error'>: There is no member named nsections.
> 
> and the load of the symbols fails.
> 
> Does it ring any bell?
> Any help debugging further?
> 
> I am running the latest net-next.
> 

Thanks for reporting. That's because of [1] in upcoming 6.14. Someone
needs to update scripts/gdb/linux/symbols.py accordingly.

Jan

[1]
https://lore.kernel.org/r/linux-hardening/20241216-sysfs-const-bin_attr-module-v1-1-f81e49e54ce4@weissschuh.net/

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

