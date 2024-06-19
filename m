Return-Path: <linux-kernel+bounces-221694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9E190F74C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 21:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D88181F268EF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 19:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E2F158DDF;
	Wed, 19 Jun 2024 19:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vAQTT/Eh"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2072.outbound.protection.outlook.com [40.107.96.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA78E41A87
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 19:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718827190; cv=fail; b=ViPaVhjoQlxCa5qVYZabjosTK5AdDRNkkd1dbJmWCfm51aGbyaZxIsV474oE41RxSbmqyulc5KJ6pHzpmJ6oCNEuO6C0zAj+AtR7U9/Lfx69OmqalpnG0i83+v1ZAShDsbtYIizF3PKWsVxviNMWVNgWjcO6I6Bn24jolXQnM84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718827190; c=relaxed/simple;
	bh=VqfzkDX1ZFuYy3vHq00ZfqvOvw6UkYM/4pcWCpztIzY=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=q/SqgAxFMM8WbtHMceBJDrI9Q9Ma6c4tI8lYngatZ/BLqGUTaa3zg6RN5HiUQjyxBZd3lOphrLXpmt2jsrbQ/HAonfVYmm4QRAFuaZg1tr1Tdm0eX5ruRKc/0ENejuHlGSfxkb62YW6dWZfpg56p1MrfyXoekxbyPxJJrCxAgxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vAQTT/Eh; arc=fail smtp.client-ip=40.107.96.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WlFaGoYQqpmEMHeZFhItqeCujFZIQhDjvjVNiy2bmBQ+SVCquS335R8kSIh1gvOcMc2kWWvdLsdhQoAyToRZQuLdXV9//6lMxcNo/WnQ2f96VxMmYI0vy+EkJRxTBpKa53bEyMVxUIg+eKx9wdSKJmsqdl6h+GMpj1M3CexPK3h8BkEluirBeN2ZuovavthSdm7iv4alzvPKedi3SmkhKCx4uC6kn8Ew0tvBIG0AC6zYyvQoptQTPRN9CjfgHC9lGoLb6EjcCVZf6CzSQQPSoh49eIYfb+SFyA5JWFVMb8O0u8VTMhPQkP2vzdG4p87cqVsseZPJ4fOR//iMBDfucQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJsxV4UEZAOQmHsD298ScgispGoA6h1uhtvYxRZk+y4=;
 b=MT/1Sty8w+siddjoGlUiy/UJBUcVJN1jy3YByqLcwsram+Zo3DUnB0TPgmDCV/x2JGLzwDi6HA8ySKuYcCb5nJh9e0EtC41bZAPnleDky8AJRwOhWGssuJopmRDCZDvHFgddbV7VnPw563DWvvLXsuM+LrZxjoazuUGmw1WfwTHPdCGKGCyg4COWBe/b9m1agfwrzywB/OT0rNhwVLJJduJoCnP4JcHlVTNpKMcmF6Ykts7+42C7PLa6SeCbpCpXvqleeswQZRO1lIRHbPE7yDLqg0L8qyc4L3EGGcSol64//OmUSaJCzThaJdDhgR8WYjSw9TpIZLOZsDVCgUahJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJsxV4UEZAOQmHsD298ScgispGoA6h1uhtvYxRZk+y4=;
 b=vAQTT/EhOWrokIfiW3MXWlbaOy8knnmXv0lmLNrMOBByZUY78BYqNfqhgyAzFOV3DBW+Ly7xJ7WlVQaA9LmrLd/klPaG9jBQH3D/UmDNNxMw6eNGiefZLTjdqNntu2dVVGsNuEw5j0UeKsEWMi+Sr/inRYp5szr9lQSpT3DlY0c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by BL3PR12MB6403.namprd12.prod.outlook.com (2603:10b6:208:3b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 19:59:46 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52%6]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 19:59:46 +0000
Message-ID: <6904c198-9047-14bb-858e-38b531589379@amd.com>
Date: Wed, 19 Jun 2024 14:59:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
To: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v3 1/4] x86/sev: Avoid WARN()s in early boot code
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P220CA0028.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::33) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|BL3PR12MB6403:EE_
X-MS-Office365-Filtering-Correlation-Id: e2ab717d-d453-4122-58df-08dc909a5e27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|7416011|366013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?clZON3VTVUNtUTU5WUU2UlZjNFdmeDF6cWt0eDQrVElGVlFYZ0JYTkN1VHpD?=
 =?utf-8?B?bDk1RkEwUkQvY1FZeUVxMTd3L1J4WmtpUy9nOExvNkd1WERyY2U1U3cydmg0?=
 =?utf-8?B?eE56NUdrZGRlenZvRVRDVDAxcDhvUWVYY1VzekNBYml1bHQycFZ3UG55R09C?=
 =?utf-8?B?TUgvQmRXcUY3QnBpZW55eHJpNzFRblBlQktIZ3pzeXlRU09xZld5SWVpWkNw?=
 =?utf-8?B?MlZjMEJ0aklyL0xEK3RKUDhPUUNOR0JkNitZY2YzYmhrVXBRWFBGaWZ6RDNL?=
 =?utf-8?B?aFljcWUveUJpcVNzVkQwRmlDeGd0dU9YVDRFM1BHanljbmxLQUZoaVZRdDM3?=
 =?utf-8?B?WDJVeTUreVM3QnhUaDJwSlhWSThpNkl3amlVd3VrQkV4dTBldVNabzcxT280?=
 =?utf-8?B?aCtCZFI2dlV5ME9xa0RBWU52ZVFjRFhZTSs1UTk3aXpUOE9LdFBWdHJLYmFX?=
 =?utf-8?B?ejYrMUY0R2FhQ3ZHaDczUFZScEZ1ZE41VGxrUXA5R2Q0cytwQTg4MEVleC9l?=
 =?utf-8?B?ak5PajIrMk51blZHV3I4TUlzd0RUdW1Dd01Fdnd5RnNnRytLNXA2TnlQZHZK?=
 =?utf-8?B?UjAvVTNCQloyV2hXWUFRalpKN1ZHd0ViT0U1ZWUxUW1mSHlYSFNMb1phQU50?=
 =?utf-8?B?NjRuS2w2NGNmU1pEZU9nUk5STy9jSzcvZVFzamwyT3JJS2xlcTA1V2k1djRN?=
 =?utf-8?B?dEo1eFd5N2xxTnJLWElLNXlGbGp6VEViZXNwVVNGdkt4UHN6bzZWMTRGNXZk?=
 =?utf-8?B?TmhHdXJBckxoT1oxV1U5QWNuaHBxUVdveDBrTkk2REJ5MklyTUNRVnNUVzVn?=
 =?utf-8?B?bmZFTTU5V1NMZCtFV3NsYzhuODdVY1ZOYVlDRGpiZkxZMmg2R0F2T1RNTlQw?=
 =?utf-8?B?TUJjSm83bzJtZ1FaeXdHdHVuUklyMTN6TFJtYk5aMWdOZDQyUUI1aEtERmVO?=
 =?utf-8?B?L3lWcVBNSHh6enNXL3hMZUh0T2NOVTFXUC9MM3ptMm54QUxlSTYzakdRRGJG?=
 =?utf-8?B?WWg0ZG0wUFJYaEhMYWh3RFF4TjVEaDJpQWtvUmEwdFZld3RpMDgzT3ZZdmdL?=
 =?utf-8?B?dW1hQjVzV3g5aDdTNk5wVHMzWUZzL2V1Z3M2NEpiZm16dDd3NGJ5YmNDcVpC?=
 =?utf-8?B?V0dFTWlwSjl1Q29ITHpNRnM1NTlkQ0QxM3M2WEpBWlNCenc3ZjQ4R0xkUXl0?=
 =?utf-8?B?SVpPZ3N3dy9iNzJvWFBUc2pIMCthTU1WTHNPMGJ0eHdkd0doUXBlUnRWU1FY?=
 =?utf-8?B?Y3ZzdjMyRm4vbGFoODdIR2gyZ0RzRkxJN1ZCTFE4SUphSHAzaGhRaEV3ZlYx?=
 =?utf-8?B?VVNqdjJrbElxOXdkc001ZXRZK1pLbDZNeXdhVXk2NHVQNUg2VWszbURiTGkx?=
 =?utf-8?B?Ums1MVAwS0V3N1J0dVl0emNSZXB1b0hHcmN2YmxGTHZpZksvcENJRjZ0OHU2?=
 =?utf-8?B?ekE3L1ZFK2d4Y0dnM1VLcFFhTkdVY1RpdHNOTXZVeUtRVTZJWVhUNzY5Yk1v?=
 =?utf-8?B?MEpVVDVNNTYydFl6cUdVMjQ4aFlRL3hUcGgwS3pqaEROenljNmxZUzQrQ3RT?=
 =?utf-8?B?SUNXVDdiVno3RzhTekFmSVF4N0ZDTlVnbFZPdGttbk55b1MrV2NHRGI5Y05k?=
 =?utf-8?B?Q2I1Yk5ZNlZYSmloUEdqUjFoNzI0QUFHUTR2SkF0TnRBeHgvR1JEYzJGYk84?=
 =?utf-8?B?QXRsVVg4ZzlEaWhmQVVhWXJxaE5SN2xndmtvS3ZLV3JRTHNxUjhkZEF1TzZt?=
 =?utf-8?Q?6rdPx2BYmqrdbHLqUY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(7416011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUJyMjNFWnRtMWxhUndVN2dtQ01aRXZKVXdpSUxtN0hLQmhnOGY4Y0VUaC8y?=
 =?utf-8?B?ZnVpc3lVOUlMdHB1eDZUbXBYVGRYWStTd0RCNmlyNjhWZ1JJOTltTzJQUGJi?=
 =?utf-8?B?TmZKZUtOQlBrdUFld3ZjWVRIYlRZNENjNFA4WThjb1puT3NXNnRMckx5cDBF?=
 =?utf-8?B?b1IzUEdrZXRLOXYvcWg4NlVibmZMdWVIVGpyTjFNZ0NjeG40dlVVMG1ETjJt?=
 =?utf-8?B?RDFBTFNLVUtiWVRaUmN5Z0szMGROa0R3VFBlUUlHM3R5cy9pbWlOc0hNN0M2?=
 =?utf-8?B?RUFKNlJ6enFJZlRKanBhZ0tjYVVwRExMREVjRWJ0d0VRRUVDaHJ2Vks1T1Zq?=
 =?utf-8?B?c0xnVVMrWXkxMHpMbnJNVGZUeEtSYk4rcDdDOFJHaUxjYkVXK2VhTk4rbkhK?=
 =?utf-8?B?eFZ5TG8vdlRnVjN2SG01SWFuYmRSclVzbHVGZVczTGt3cXhwUEYvaTh3U0Ux?=
 =?utf-8?B?cWppU09pc2RCNW01Yis4OUpvM0xMU0ZZVGhYcHp0WFlLZDBZOUc1YUI3dkkx?=
 =?utf-8?B?V1hjTWE0ckNTVGZxUDRmc1AxWVAzRHBucUhGeStuTWFIVGpUU0gwWVczTGJF?=
 =?utf-8?B?bUliYXM5QjNKb21GbHlGcWJQeU9oQUdQSE4xTWUzQkJHNFYzTnQvbDI0bmJq?=
 =?utf-8?B?eGwwT3E1YkdXQ1BsTHE2VGQxMFNhem13bjVweDJ1L3dMUVFqVitkalo4cFdv?=
 =?utf-8?B?R1g0UWFaUFpUM2I1K1E0TkhybkpUdVNBUVp5dzUraXdrZFYvVDZlbmtRVFVU?=
 =?utf-8?B?UGN0czhtcDN4RENMQ3lLQlp5Z3g1UjNtK2RQSDVsaCsrQWpzVmg3bkY1MDhI?=
 =?utf-8?B?bSs3ZkNZK24xNFE3TE9PVmRHU0pzVzlvK2tlRnhWdHpKWmRSZndJSm0rd3NU?=
 =?utf-8?B?N3NNb3ptZWtCcXkyekdCamQ5eXdCcFlZRjBXc3BET3p4S1lsa0daMFpRUWZu?=
 =?utf-8?B?NXgvZ2ZDa0pBOGFpbG11OTk1c1BOR1dENXJsbTBaR0UvMGEvQUdQaTJrWEdD?=
 =?utf-8?B?WGI5MzdWcVAyV1lldm40bVVZSWhNOWk4U0Qrc0ZLQUYzZVphVWMxckc5bFpu?=
 =?utf-8?B?YzduejdHSTF0QmgvL21KUXJMUGxUUHN3ZFM1aE1yZGtwN2p0Nk1GNW5KUEN4?=
 =?utf-8?B?OXFlQmhPQVd1dEtUakRXcU9CK1U4ZmRlclJ4b3JJY3FRSXB3Y1pPUGhTb3Jv?=
 =?utf-8?B?ODB0RDVDQzdkNU45QkRzWkR1SHhCOEF3N2d1dnc5MnBoNkY3WTYyeElvQ0RM?=
 =?utf-8?B?bkpmUTMxaWhxemVOVEN0THdGb25WQXVqZVI3dVR2eWdJRE1HNDZISVdHOFgw?=
 =?utf-8?B?ZklyYnZHV1o2N3FRUUczbFArYit1MWRqMmdhUlJZZncrRGR2ZUZJajZ3V0Nu?=
 =?utf-8?B?YUMrYlhHTituYWFHNEhTUHZqMFhNZkpDTVN3OTJ4djZXcnVNbDdUMUJlbGVL?=
 =?utf-8?B?b1F4N2VNc2hYV0ZVdDRNbjVqUnAzUC9GNjRCN2pNWFRXbjI3cC9vUE9abm1n?=
 =?utf-8?B?VXBBckROKzlrQjdETStDcmhkVzgydmdhNDQ3VVE5WlorYTFqL2l3SVUweWg3?=
 =?utf-8?B?c2UyVVdxbCtzZnNkU2JLUzh5TXY0b3dhSGh2Rk90UlVpTFNUb0NCckpaZzRi?=
 =?utf-8?B?TmNvNGE1QjNaaGxpYjNSUkpyK1FQQmpqbkkxUm5RMy95czN0TVI3OVJlNEor?=
 =?utf-8?B?eGsvVzFyT0RKbzhQRDNxT3dBeDZIYThkT1NCeE5wbXE2Q3BiZkN0U3dlNERL?=
 =?utf-8?B?SEdhSVZYZ0FOaVFjUkpaQktsM003R3FCYm5rUEVFZXpydTZUL0dMaTJKNEZU?=
 =?utf-8?B?T2lUQVVZMlFoRUdvYkVvVlB6RnhncWkrVUlML2VieFRpZ0NXZ0dMcHhyTmRn?=
 =?utf-8?B?T2I3K09NVUFlTmQ1L3FLeG1CZ3pGbHVlZy94K2Z6NkdkbVgyNEhKQmMzT0VH?=
 =?utf-8?B?RFJKdWtwK1ZiSlNzUzB6L1d6eWxSS3ZMZlY4dE5rZFBPakFzQVBtL2IwMzEr?=
 =?utf-8?B?ZHg3bWJLNHRNSnZYa21UZG5vTm00elNIWk1MY3BZY3A2blIwQTlKTlgrZkJV?=
 =?utf-8?B?VVhEQVYzaCtEdHFBVGRPcTZTWVh0TENiNnRuSFhIK3I2WTJDRGRRNGJQZi96?=
 =?utf-8?Q?IrAl8p3Q/qdENUfjQ0ujxQPtq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2ab717d-d453-4122-58df-08dc909a5e27
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 19:59:46.1345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EuMTkB7x3KFBfSp+QWsjMlaFD1Oc0TLnFDP1taDneHxZz8DpiqiK5adrO2x7gPWKe19OfAX7+CXIMFPlKbue/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6403

On 6/5/24 05:16, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Using WARN() before the kernel is even mapped is unlikely to do anything
> useful: the string literals are passed using their kernel virtual
> addresses which are not even mapped yet. But even if they were, calling
> into the printk machinery from the early 1:1 mapped code is not going to
> get very far.
> 
> So drop the WARN()s entirely.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/kernel/sev.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index 3342ed58e168..33a669e85e5b 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -720,7 +720,7 @@ early_set_pages_state(unsigned long vaddr, unsigned long paddr,
>  		if (op == SNP_PAGE_STATE_SHARED) {
>  			/* Page validation must be rescinded before changing to shared */
>  			ret = pvalidate(vaddr, RMP_PG_SIZE_4K, false);
> -			if (WARN(ret, "Failed to validate address 0x%lx ret %d", paddr, ret))
> +			if (ret)
>  				goto e_term;

This area of the code around the pvalidate() calls has changed now. They
are now calls to pvalidate_4k_page() that will issue a WARN() through a
common function available to both the early code and the regular code.

If you want to rework this patch, you can use the added diff below to
remove the calls to the common function and just terminate directly. Or,
I can submit it as a separate patch.

Dropping the other WARN() calls around the GHCB MSR checks is good,
though.

Thanks,
Tom

diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 71de53194089..ced15210ea50 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -1243,7 +1243,7 @@ static void svsm_pval_terminate(struct svsm_pvalidate_call *pc, int ret, u64 svs
 	__pval_terminate(pfn, action, page_size, ret, svsm_ret);
 }
 
-static void svsm_pval_4k_page(unsigned long paddr, bool validate)
+static void __head svsm_pval_4k_page(unsigned long paddr, bool validate)
 {
 	struct svsm_pvalidate_call *pc;
 	struct svsm_call call = {};
@@ -1275,12 +1275,12 @@ static void svsm_pval_4k_page(unsigned long paddr, bool validate)
 
 	ret = svsm_perform_call_protocol(&call);
 	if (ret)
-		svsm_pval_terminate(pc, ret, call.rax_out);
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
 
 	native_local_irq_restore(flags);
 }
 
-static void pvalidate_4k_page(unsigned long vaddr, unsigned long paddr, bool validate)
+static void __head pvalidate_4k_page(unsigned long vaddr, unsigned long paddr, bool validate)
 {
 	int ret;
 
@@ -1293,7 +1293,7 @@ static void pvalidate_4k_page(unsigned long vaddr, unsigned long paddr, bool val
 	} else {
 		ret = pvalidate(vaddr, RMP_PG_SIZE_4K, validate);
 		if (ret)
-			__pval_terminate(PHYS_PFN(paddr), validate, RMP_PG_SIZE_4K, ret, 0);
+			sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
 	}
 }
 

>  		}
>  
> @@ -733,21 +733,16 @@ early_set_pages_state(unsigned long vaddr, unsigned long paddr,
>  
>  		val = sev_es_rd_ghcb_msr();
>  
> -		if (WARN(GHCB_RESP_CODE(val) != GHCB_MSR_PSC_RESP,
> -			 "Wrong PSC response code: 0x%x\n",
> -			 (unsigned int)GHCB_RESP_CODE(val)))
> +		if (GHCB_RESP_CODE(val) != GHCB_MSR_PSC_RESP)
>  			goto e_term;
>  
> -		if (WARN(GHCB_MSR_PSC_RESP_VAL(val),
> -			 "Failed to change page state to '%s' paddr 0x%lx error 0x%llx\n",
> -			 op == SNP_PAGE_STATE_PRIVATE ? "private" : "shared",
> -			 paddr, GHCB_MSR_PSC_RESP_VAL(val)))
> +		if (GHCB_MSR_PSC_RESP_VAL(val))
>  			goto e_term;
>  
>  		if (op == SNP_PAGE_STATE_PRIVATE) {
>  			/* Page validation must be performed after changing to private */
>  			ret = pvalidate(vaddr, RMP_PG_SIZE_4K, true);
> -			if (WARN(ret, "Failed to validate address 0x%lx ret %d", paddr, ret))
> +			if (ret)
>  				goto e_term;
>  		}
>  
> @@ -780,7 +775,7 @@ void __head early_snp_set_memory_private(unsigned long vaddr, unsigned long padd
>  	early_set_pages_state(vaddr, paddr, npages, SNP_PAGE_STATE_PRIVATE);
>  }
>  
> -void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
> +void __head early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
>  					unsigned long npages)
>  {
>  	/*

