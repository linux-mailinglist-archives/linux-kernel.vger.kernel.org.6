Return-Path: <linux-kernel+bounces-396207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 312089BC958
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62D821C2271A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD861D1E75;
	Tue,  5 Nov 2024 09:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e4rQGSIz"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648F61AD9F9
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 09:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730799257; cv=fail; b=WUyjdOY11aW14pCRekLWGbO7JBNfhdOlohRSKwnqq8vWhOJrHfkUJOFA34APdqBtB4C9YxARjgXGOkafgP1qubo5ix0nJPD4aHdk0zgk+ELSvwc7A+PUwumwnInmwsV4h1Zw7KBHGf2jN2TO0E3q5M3DiGnL0y9vhTPOml7nJos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730799257; c=relaxed/simple;
	bh=qZ5L+1GSMXa58IWclmj0Jw9DstfAR3L/9oGMpsIHZ2Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pn7rGfxuNGzi7ScANKsVG4kgTMaOSeflXuEuLbuKqQzGZDXALB+5smt0+WRoCyxQRUFCP52R0ZJz2OdZAFT1rsXJjZnGnmb2/5WBNmafX7x1vq1GvQ9Vwn/ZeYsWY+zicGUUwcyvyrHIK5rRshNOzo4JulpCXebkIp/ulvQ8p8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e4rQGSIz; arc=fail smtp.client-ip=40.107.243.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oHH56u88H8icxAzeNPdP0POfsZcd4t8sEcXiOfb/kII3th347aHvz2nbSdTRiCqvusWi1nbBmfcutL+4zoNGgSjqS9xrEEPsRQl1TzHwE/xacHT8ScZ055wU5pm4WXcxPS+N+v6GEXH/TLjShPzvINEnl4ZnpyauQKutNVGTBglUFk1RBI83MvRY2IacSqrnkxrWT59HpYOtk9/lJBxab8jyyUomP00RZ+bSkM3Ey7gGz/h2wTUf5QLKVXfbxZS30jxLj4lPOWx6ave3qpZQC7pQD9GacO8wiOhWArlsRaOprhHe6TrBAtzWL4FUbGKxdiUJku//bub7pM6xQwc8Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgjQZhzsQ2UYlFf1mAlVgjd/+I/4CmifNX1reGBqFDY=;
 b=shNloas7issLREYcjPBmwei4YdtJItdnP0vcsfATJ2yya51DJ5Bh5u9qGqf7g2Ue9AB0rhguT8eCLggqOpxa6kGKo6yK2lvFK9FjArUjpavCr7fuUMVSB51p7YULjSX2B3aafflYd1DiaP0D5j54nJUq5LwtyQkduujoHTZ1sWMJ+xn7ulWSMLNnoDrtVmnWKykhbiOwXOpNVlvi3+JF33CbaohgfT/JJuHGYcd4NqzF6pSpAAK95v9ySLTkDdA/G1udhnEYVtLih68OQ/Y4zvWCPBfMjyCqED/PLKy0IykOkIoWOYIZLDQo9RUIMlmRecgzg3aZPzzJbg4dUi1m0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgjQZhzsQ2UYlFf1mAlVgjd/+I/4CmifNX1reGBqFDY=;
 b=e4rQGSIzu8wxEwpO7P80qBCEu0apiY5+tCuaJoLQrTx6jiKNH7S+w1fQjsjKQ39plUWAuTluczkZ5Nhxugh8Vmmu+uoDl2nzY3JdOo3L4iTCOhbW4ipvF4X/+hcOn2Mc8TEU62ehNcY4CpeRwqBz8Ry/catTFuxdSwXhMXdFMuY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by CH3PR12MB7522.namprd12.prod.outlook.com (2603:10b6:610:142::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Tue, 5 Nov
 2024 09:34:13 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::2efc:dc9f:3ba8:3291]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::2efc:dc9f:3ba8:3291%5]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 09:34:12 +0000
Message-ID: <5907e4cf-d71f-4c5e-8504-a0177819ebb0@amd.com>
Date: Tue, 5 Nov 2024 15:04:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf/x86/amd/uncore: Avoid a false positive warning
 about snprintf truncation in amd_uncore_umc_ctx_init
To: Jean Delvare <jdelvare@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>
References: <20241105095253.18f34b4d@endymion.delvare>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <20241105095253.18f34b4d@endymion.delvare>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PEPF000001B0.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::c) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|CH3PR12MB7522:EE_
X-MS-Office365-Filtering-Correlation-Id: 32c720f4-6434-44a0-93b6-08dcfd7d01f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ancvRytWcm1FOGZkZG1UL3NnSjF0dFVtKzQwOFNxRmlPcXJLQ1J6Y2pBem9h?=
 =?utf-8?B?Z1k0SlFKVmJBdzlSZWhlWFc2SE9mVGNNRWpZa2ZJZFlFazlaQTA3SU80ZTZn?=
 =?utf-8?B?UldFbmZEYWxiMmdsV3dSYzZnaXhsUjAwWURhN0JjQ2dmNEFyMU1DVEFuU0J4?=
 =?utf-8?B?aXhIZGFmT3FObnU4NUxVMlpyajZET2c4SGsxY3pxSDR6WStwNVNpbjVFbnFB?=
 =?utf-8?B?NjFHMXg3US92ZFNSTzJVcnovTk1qZUJKazhKSW4xZnNvb0g2NC9YaS9VZURj?=
 =?utf-8?B?d2psdTZ2Z1l0eitGa3VWNnczczNMVnlFcFo1OHdZSElRRUc1b2ZXTURlMFg3?=
 =?utf-8?B?OXpna1V1YXpkYzFPL0RXS0JQQWFlSVRnZkxCd0JoYWNzaE40eUNFSmhoaWdk?=
 =?utf-8?B?RXJISzJ5Vk1LdTUrTjZpY09oMXdja3ExU3U0dGppVmY3bzk1aDJqKzl3YTY5?=
 =?utf-8?B?bTJDa2I0MGZXNVgxT1k4K255OUdqbkNrZ25TNlBRVmlRbjBHa0h6dTJYYk5C?=
 =?utf-8?B?Z1dXZEUrYWxmZGs4TExRSUV0c0x0WWN1SnFOVXZwMm1aUnRoT01SeGFUUldP?=
 =?utf-8?B?TTRwU2RVU3F5SG5SSzI2Nnl4Y25WTVRWMWZySUcrcmF4L3lpcnBVZ0hNbDQx?=
 =?utf-8?B?L3Vqam9PM3o2SklTYVVZK29yenphV1IxMnV0OHFCdkw2ZHpwajlGNjh1ejE1?=
 =?utf-8?B?b29JeW9sZElJc2lzUTQxWEdQeXFZY0pQL1p3MVN5OUhIUTFWSTAvcUJQNk4v?=
 =?utf-8?B?SEVLeVRONGtjNGwzRjlmZitLalRqY3RRWWJ4NE9OZk9aN1V5d3ltQTA0ZW5p?=
 =?utf-8?B?andLQUNEdzI2MmxjWDdjUnpkbmZtVnBvUTh3WnRwbWs4bTgveXQ3aTYwQnBz?=
 =?utf-8?B?UjVzbm1ncEZyS0FibzN5M1NBUFJnZDk1ZW82eW9jRlJDM2dkd3B3aG1lSlFP?=
 =?utf-8?B?UFJMMW8ydFlzQ0l3dzhXSGJMS1BxdFE5dEFDNUtaRFliNTBHQUlYUEorczZI?=
 =?utf-8?B?Znp5Q3pEa0txK0ZCL0VoS0NxVXBzYkZnR0J6Z3ovMytacjBOdW1UVFBqTk5Y?=
 =?utf-8?B?UFd0b2pXN0l2WHd5VDNWQWRBU29UdEd5Z1BGVXZlVWE3eFNYcEV4R2Y1Q2JH?=
 =?utf-8?B?a3ErbHhwOHhpNnRqdFArRUhqWWFyb2grTnhxbG9iTkVmc0tSQ0xaeEozZmNh?=
 =?utf-8?B?RlZnUDlJdnVySGd6YnNyVTRIN29sd2hlRVZkWGptbkVNbzJzc1pjRXJHSG1N?=
 =?utf-8?B?TUdXeHVZb3ZYT2tHdGZqczRjYjQzalQ1dlFNWDc0bmlNUGd0N2phNjFoUW1p?=
 =?utf-8?B?aE9XR3JLajQvSmNtbGRVb2h5QTd1Qm5LTlg3aUJYVmRROThCYnBlSytsdnlp?=
 =?utf-8?B?ZlZDbVJyNy9BNkNrTzc4Z3pvV29OL2NJU01JODhVeFRYZlFYMXBhWS95VDNC?=
 =?utf-8?B?dE5sc1M1dVdZVzRudUZObTZlMDdRZG9tYXlYNENELzNFWnl4NFdqNlN4cS90?=
 =?utf-8?B?WjBucVM3ck10ZnhTKzJJYWY2Y3NkQU84dVRLclo1ZWQwalBhczM2TkZtU000?=
 =?utf-8?B?dFlkWnEvT2g1UzIvNGxGRVVmUEhEYmxEVEdTZFIySzBzbk1NOGs3a0s1Kzg5?=
 =?utf-8?B?OGJGVXljRk11bDRvTkJXQmNyZkRIUWFEcHp1Y214T0t3K2tDTlovUDRYWjMx?=
 =?utf-8?B?Szh3UWpZazI3RCsyUHhWZkdHL1RIRDE2UXk2NEZHUjFBL3o0QlRzTUd1MzdP?=
 =?utf-8?Q?LyebaD/Sz1FkILUM0CyA91087evgmaWxn6kPsob?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QlVsNGtFREY3OUR5UFVDY2JwR2FYK1ZJekc1SmZ2NnE5MW9KUHNwSTVHUTJD?=
 =?utf-8?B?NFZUUnhQQlZERUtTK0hERnFoeWdMMkpES2s5OHkxRkxUUVVCMVNhaU9yU0RO?=
 =?utf-8?B?WWJ1Ymw0TVFCMThVd3BzcW4xOEJWRHFRRU94VERiQ3BjMVQrWlRYYWtMck9w?=
 =?utf-8?B?UUJjdVA1NjdlQjlvS1NRK3NYaFZ3aVpETy81SnNYSmhFbzFWZk9DbExNeXZm?=
 =?utf-8?B?akxybW8vZGVXNmJPd1luc0JNRldFRkx2ZzlwOTJjRzNzU0RSNWlFeEtIeUd5?=
 =?utf-8?B?MExsMlg3a0I2SVlPTGQwUVhORFIvWHJBZzFIZFlIb2xXZCtZaGNIWURGU2xx?=
 =?utf-8?B?dlB1dXVuMEthK2U2dDFSaFNBMDBqV3I1ckwveFFOMVkwWGpCNTVqVHpXaVJZ?=
 =?utf-8?B?Zm91Qm9ZWGtzM2k3SHZlQXJJMFlrcS9memNkTzRtSjFzTkJDZVpLd3pLRksx?=
 =?utf-8?B?bEc0RGp0Y05wa3ZiczlBS0w5eFl6bUt4QzhWS0VvZmZQd0s5NURLUFZyUFN5?=
 =?utf-8?B?NmNNMlh6b09JVlRHQVFFdFVIeDNPWnRkT3puUnZ5LzBoMG03VEdzZUhzN3oy?=
 =?utf-8?B?YWZ3eG5JNHFBWjl4TjlPMUhjYjJIeWJ2RXZFai93M1R2TnZudGhIM2JVaytB?=
 =?utf-8?B?bnBiSWM2NnZQcWwvaW1lRU8zeERzaktoNEMwa2dyOTIzRUUyci93MEZuOWlE?=
 =?utf-8?B?eUJlODBzenpuTTV6WklObVQ0WVpobmNXWTcrRTVoakpVSU1qNjd2UVFJNzFa?=
 =?utf-8?B?WE55SUpUR3kxTHZQaGxtVzVMNDdqbTkzVUlxSklqU2RVUzdNWGlTcnJLc0Zp?=
 =?utf-8?B?My8xVDdhckp2TkVUWnV2ZVphVWdHNnNzY1FOQ0hnUFNsQk9EN2p1Y3hlc2o0?=
 =?utf-8?B?TktMQmZXaGlMbkkwMU1yY3l5bkZaU1BKZVk5VHNiTzZQU2dUdmQ4Zm1KZEVF?=
 =?utf-8?B?NGNpSnFvSHlZSUxEdituOXpiQlRWZWxQYTgvdmxHMVl3THJ1VTNnS2JoVFJ4?=
 =?utf-8?B?VExSdmZydEwrcEdWc3RNMThybENsRDJVL1A3akhwcDc0U3piakErUzhLM2py?=
 =?utf-8?B?Rnd0SSt5a1dvRlF5UUg4Q01EUzZPT0MxczNuWk1nOTlXYVk1NmtUdWdTUHNo?=
 =?utf-8?B?d0tIZFZDRCtJNmt2ak92MzZDdHY5VzFaVGY3K3B1bVpRTWl6NkJUUElaOTNN?=
 =?utf-8?B?UTFQdXpjUG1sbW9wM3RkTnpFaWJ3cGNib3RKSUNwdjVqdnRUaEhPTW42S2Np?=
 =?utf-8?B?NHRFR2tvTnJrL3IvWnhtWFJiVFdOajUrTE0vMFdvL3l6dkhnZkVBZHNGM0h6?=
 =?utf-8?B?RHlIT1pZcVZGVFI5SWsybmFWM0NCeWtZOS9sN3l1d3crYkRuTGQyTnNvdW1D?=
 =?utf-8?B?SldmQm9XeHEyekhkUXBYa2hrTmFNWTRjUUk1MnhLVHpHSy9WanpXRnlYYzFE?=
 =?utf-8?B?R1pJSTNmRG5WWjY2ekRuUmJCQ3Q2KzZ0K1pBY0UyS3ZkK0IzdjltYk9TRjdD?=
 =?utf-8?B?Nm5CQStPSG5GVVZTa29WS0dhVHVBZVpQN0Q2QklybVFwcGpEc0o0UDhqY2lS?=
 =?utf-8?B?blRBaU9XOFZGdEdna0tYa1VXMlNCditCRUc3R09uSkZFTVJQVWFTREkxVko3?=
 =?utf-8?B?NHFXQ3VPWnVIODI2MWlFczQwdmhGUVI2MG9GTTNhRE5OTmZqTTJOWnplQ3J6?=
 =?utf-8?B?bzVqb1ZkOTVTbGJ2TnhOc2l4N250ME5HcCtYSjhmaG53dnFXYU13Y3h3a0Vy?=
 =?utf-8?B?aGlUSkoyTnBNb2E4cm16T0Q5bkVMd1F2YVVXSUpweUxIRDRSTlNPN0pTS1pj?=
 =?utf-8?B?UVRYazdLTlJXZ09lQlVwSm44YjJLcFFpbktmTXl4b2huaWM0eVB1bjluL3Qx?=
 =?utf-8?B?MlR0d3ViZW53L0poNEVQdW9FYXdHeDF1bVZCQmRnNjB3RmFsSmFCYTFBNmlw?=
 =?utf-8?B?NlZuMzBtMGlWMUlGQTBFMjZ4RVN6ZjV0OHdSckExdkYzRUZJakNZTjA2eE5l?=
 =?utf-8?B?YmkyamN4ZVRjVnhwa3Z5Q3YxV0VSZlpZa0lTeTBxb25Bb0lZbjdJcnh3eTJO?=
 =?utf-8?B?WDhoM0N6ZzhXdzh2cGI1QThiV1NMMTZRNVkxWjNqQUxBOThPOG5tMWhRZTQz?=
 =?utf-8?Q?jCQUqdJ995YTi3gzYuzK8Ba/I?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32c720f4-6434-44a0-93b6-08dcfd7d01f0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 09:34:12.8742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v6xg2dA61f4hX9vo+I5AaCBQrhCiw84r8I5M7BWhVRNH+IcUW/E9Ts7c5/tus9gjXo17etODpav42l5ffqZiOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7522

On 11/5/2024 2:22 PM, Jean Delvare wrote:
> Fix the following warning:
>   CC [M]  arch/x86/events/amd/uncore.o
> arch/x86/events/amd/uncore.c: In function ‘amd_uncore_umc_ctx_init’:
> arch/x86/events/amd/uncore.c:951:52: warning: ‘%d’ directive output may be truncated writing between 1 and 10 bytes into a region of size 8 [-Wformat-truncation=]
>     snprintf(pmu->name, sizeof(pmu->name), "amd_umc_%d", index);
>                                                     ^~
> arch/x86/events/amd/uncore.c:951:43: note: directive argument in the range [0, 2147483647]
>     snprintf(pmu->name, sizeof(pmu->name), "amd_umc_%d", index);
>                                            ^~~~~~~~~~~~
> arch/x86/events/amd/uncore.c:951:4: note: ‘snprintf’ output between 10 and 19 bytes into a destination of size 16
>     snprintf(pmu->name, sizeof(pmu->name), "amd_umc_%d", index);
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> As far as I can see, there can't be more than UNCORE_GROUP_MAX (256)
> groups and each group can't have more than 255 PMU, so the number
> printed by this %d can't exceed 65279, that's only 5 digits and would
> fit into the buffer. So it's a false positive warning. But we can
> make the compiler happy by declaring index as a 16-bit number.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> ---
> Changes in v2:
>  * Use the proper printf conversion specifier, to be on the safe side.
> 
> An alternative fix would be to extend UNCORE_NAME_LEN to 20, the
> downside being an increased memory consumption. Depends whether we
> expect UNCORE_GROUP_MAX to ever be increased, or groups to ever
> support more than 255 PMU.
> 

Its very unlikely for UNCORE_GROUP_MAX to change and the current
solution looks good to me.

Reviewed-by: Sandipan Das <sandipan.das@amd.com>


