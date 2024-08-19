Return-Path: <linux-kernel+bounces-292422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8A9956F3D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 014E1285546
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 15:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F17473501;
	Mon, 19 Aug 2024 15:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5kunNnul"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59239139578;
	Mon, 19 Aug 2024 15:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724082577; cv=fail; b=meqnw9t1noPiPGojysN5RXtFvGow6u8iNURpOAWh67AGNg7ZAWWxSGIau73gbKSExB/Jg8YcyLI0547hIhv4CUIpjt3zCPPcl/Vrj+sMt+fhkB+d2yQOqu2tts9AkZsUNU4QUOaJR/MsOowsT0NL6vi52ndnBmcpE0lMsQsuXBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724082577; c=relaxed/simple;
	bh=42vzyE1U6mrexYdj0fvpCgufCOZau2Uk1TyyikMi40g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PKAYI/57/82CU1SETCCEgm1JiQHqcfXZo6pcPH3F7z89Ymt8HqHpdcm6h788Py9xJreOauCyxK1mdI8jTTZHLE3IKQT+qYvZfoofLelNouzftkR30n+l/8F2GKrNp863NrZua1vjqr3K/IKJnj0FwCiyb54LWGrgEekDPXqIfSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5kunNnul; arc=fail smtp.client-ip=40.107.236.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=naULkZcUHKKQtF8oADwcuxEQfzDKGlAPMmZHhyT2pX+w9TY6i654E7O+IoG/oiYT283IyxfT3GhTDroXDyCwfuiu9PgznS29AyMfx0QBqhC1dExY/Gu8VIDmg9lT/KDzmJkyqpiyAG80bKDFlmnf/B7xaFY2KCPIw6hPhx2cP6wrVFKuU2UDVbhL+plI7I6a/dg1jjJX6H3SWB+uaezKWNjUcGQULZXTyPwlksycslosTgxzjoSdf9kNGtqiwvTk6W0Pr7Ox9+b1KUhOFJ6PYLu+JsRAHXCXZnblW5xs+iAZv3srs+RBD0pqx+0t5i00mhsdzKwboPQOxe99+8uZqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ra6gczeSi4dk9IineIYuA1qCoy8moKwiqnmkUkreSRw=;
 b=dZEpMi3ZLKOCr1An/QGWNBcP/jJiMLCEY9cOAYpxxhxNdla7zSlWq97qK3MOUGx0UwE+JugDX4KSrbxgtS6JoceHtRyx9Zx5o+6gQgN7sRmo83v8fuwS/+QwEm8YEuPfZoTY9vT8z+Vl3uox6FAgrjIDRXz6Zy1mT3crvmnJ1kSYO0s/4YzRepeehakW5GPZ5NZeZVfbAXc6gPhPFNEWpdEHtzrnMRLjg93pH2m5nNGE4KeMpDhruIaW65/pnFqBTRzcceq+o2kpYFZpQUBIVwdCIutPORTexLQ5+qVPrvQeuTtMKZuPQ3w9e9suNVbswNnlpvs1s+LWcYSPmaH4Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ra6gczeSi4dk9IineIYuA1qCoy8moKwiqnmkUkreSRw=;
 b=5kunNnuloX9nnVFyM5hm+qp+VnnrPk6zOL6kvwxE8FkatuFz+N8KhwPniOTU4yZ3X+pozm92eC3Ocx7Q1Mos6TO9jZaGKQM1U7+j0TWJ+NbD9A/8jdSdJhzBk6Y4l6V8ULjRvFH9uPmfADxygcue8CEtvOsvaxLdigtHwKu55Gk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH3PR12MB8484.namprd12.prod.outlook.com (2603:10b6:610:158::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 15:49:27 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%6]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 15:49:27 +0000
Message-ID: <e82ae909-5c40-4c8c-887a-a1e0d0cfe448@amd.com>
Date: Mon, 19 Aug 2024 10:49:22 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v6 09/22] x86/resctrl: Introduce MBM counters bitmap
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
References: <cover.1722981659.git.babu.moger@amd.com>
 <2bdc7920f9dfc24994fe280649cf26dc566a7a90.1722981659.git.babu.moger@amd.com>
 <8e6143e7-008b-4c9b-90d4-b2a8a56bb158@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <8e6143e7-008b-4c9b-90d4-b2a8a56bb158@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0153.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::8) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CH3PR12MB8484:EE_
X-MS-Office365-Filtering-Correlation-Id: 5adb9b61-fd0d-46b9-f659-08dcc06681ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZDlyVGR1ZnYwK0ZVYVgwWCttS0J0OWdnVWV1Y0I2V2FkeWFiWU50c1k0R25w?=
 =?utf-8?B?azcwVzFGblYzN3Y5MmRwM0dUUHhFV3VmVHdOUmk2bVVRbWRDK2U5UE1xeHR5?=
 =?utf-8?B?K1MwR25kdFBxMmZ3R0tsanhFdnU2bkFFOE1MbUo5aEpiZGdzQ01pb28zZ0c4?=
 =?utf-8?B?K2hWaVlXWTNKM2lkczhPK094dlpiZE5EdXdiVEJ5K1VQSVkreEVPNjA2TUNO?=
 =?utf-8?B?MGd3Vm9VREh2MEVETUpKS0lzSWNOQXNncUtsdkVmYmdoL1NXckRhRGlXckJ0?=
 =?utf-8?B?WnZ1c1RnM0ZGZlRRZzJJK3NzSFVtYnJ1YUhOTGZOTjFzRDZIdzM2dU9ZN1Ji?=
 =?utf-8?B?Z2NzbEVZTmR0TTdIaXhYTEtrUTRLNUs2dXYzVXlMZ1pRcitPSE16c3JGRXVG?=
 =?utf-8?B?YVZONlIxSUpVM2FrbVJuVW9acXFUcEU5bzhHYitpdGV1OWk3SU9CL3VWK1N4?=
 =?utf-8?B?cWVjKzRWekljb0tRK2Q5NTZZTmRFa1FWU04rbnlFUnQ4b2pSL2xtRzFwSEVW?=
 =?utf-8?B?QVUwVVZuMzdJQnpOZW0vbjNVUXlaQzBWZmRiZmZGNjZrZDRRaFJhWjFhODFj?=
 =?utf-8?B?Z3V4cGNhQ0VoTXQ4SkFoMEFnSm94SktZM0hsMmlzTTQ3clY5RWtCOXpCdWlt?=
 =?utf-8?B?WldWdzREQVh1eHJrRGZETklmR0M4NllKMVFWa2ZSaGRoVzUyNkU5ZnRFbXU5?=
 =?utf-8?B?T3JTdm9FZTBrcFNXeTdOWFMra2hsRjJoTS80M25CY2dabDJLeVE2czdHbThH?=
 =?utf-8?B?ZUNJT21zQnNPWEdBcUlhTUpjMjhiVFB3NUVMWHZqOW16Ylc5Smd6SmgyR3Fl?=
 =?utf-8?B?TXF1cTJ6OUpPUE1IV2E1SkFlaGVMc0dDdEFPVU9Wb2UwOElHdktLZE5iSytS?=
 =?utf-8?B?bVVSeXlIemNaVDg5L0hMc3pSUk9LSWx3KzFWR1hIRlZCM01oUG5LOTVxNWIx?=
 =?utf-8?B?U0lXZE5QQ2g0RStMeHVSQVBGMjU0Z1EvQnJjY2NEaThKd3NZbE1ib0RjQVRB?=
 =?utf-8?B?RllOVGEySGIwaUw3WGY3REhaRjl0VWNid3pCaDFjZnlZM0dnaUVRN0FGb3JG?=
 =?utf-8?B?UHBVRlVRQzNXQ1V4MmIrL3VBK01SbTJRaGhNWGtWZ1dUVnYzc3JzWTZPZ0VM?=
 =?utf-8?B?YnJ4Y0xBRjhhbVRyRFVGV21tREIwbEZLL0c3Q0lnOWV1c0x5bzJ5WlRrb3pa?=
 =?utf-8?B?c1RocG5XOTZuVWU2NU9NTnk2b2Q5S3JxQlJSUWxMZXdad0Q0V1V6WXhNRElQ?=
 =?utf-8?B?WnZQTjdBY1BqSEphbDRidE5VSnhqNHVYQmpiK3VKc2JBWnFUNjk2cWRhWm9H?=
 =?utf-8?B?Ry9adEw4TlRoeU5XQnZ4Ty9JU2VxZVY0UVFiMFF4NXI2UllTeG93SzlSYTk5?=
 =?utf-8?B?OFJlb0FQN3FkZmNldXRWRWIrYmd2UWxiNHUxV253WVJkaHRvQUJGekFXbndO?=
 =?utf-8?B?TjhlTGN4MnllUG1uQVpzRWFnQVNzekZIa2llcTVQeTIrRzE3anVwK0szMUh2?=
 =?utf-8?B?Qi9PZjNwdUFCZFlRUlZSV3hjVHgxYmtoTEp2SytqQ3lITHRDTUpsYWs4OXpO?=
 =?utf-8?B?aFJDZjl1YU1ibDR5aUJtbDhqRnZ4Z05GRXBmazZYY3J2Q1k3dDdmKzhxZDVy?=
 =?utf-8?B?ekhFVkpiaFR3QXR5WGxGVHFERk9jVDZEdE05UlRMK2owV2Z4T0l1VGhuTjhW?=
 =?utf-8?B?eVlmSS8zSHN2dUxCQmo5alcxbkRjQU45azhvWjlCS1VVN3NXMDJsd2NTOVN2?=
 =?utf-8?B?TjR5VVlWd1NOTHgyQ1FQZzJQSTJoVGFCaGVBT252anhKOWY0RnExVFR0Sk03?=
 =?utf-8?B?YzgxMHhid210eDQrRFBzQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Yk9FVzIrQitwS0RjMXhiRks5bUQyZlRsVkQ5VFFQaWNkSktxQlVKL2hTaFdM?=
 =?utf-8?B?V2h5SHlNajFSMzhFeGczamVVL01wWnorN0pyWjBRNTRNS2FWSkdIVk90QnFr?=
 =?utf-8?B?ZnFIWnR1d0JVQWR5T21wTFhwcDh5NWk5L0JJTCtlMjQvQTE1WW5oOFQ5cVpM?=
 =?utf-8?B?ZmN6dzd4TG05cU9UWk5neGhHYkFkMnRyQWcvOWVadWl6SDZSTEwrams1MHJr?=
 =?utf-8?B?d2Z2KytCMHZzOHdSN2lRZkUxMG5jMTNwMFlaa0JhdDAyK3YveXB4V1h6dHNj?=
 =?utf-8?B?NTRjWk1XTStmV2xjeEdJVmhtMzg5dWt4MENtdXloMzNMK2pVdUVycys5RlZw?=
 =?utf-8?B?ZGQwMzVUVVl5QjBXWlhZRUFuQzU1cEowYnNrbFlhZmlONkVoSW5mZzVvaHdL?=
 =?utf-8?B?VUc3RXdaNDhUUVpKd1A2REVvTFBUMzZWSlAwRmNYY3o4aVVCZjRJNm9Tak1t?=
 =?utf-8?B?d2JZVDcvMTE4U2thNGhoaVZUUlVNWEdKMHN1NHRUeVZVQVdkbWdLb2E3aG9Z?=
 =?utf-8?B?aEE4ZXVLUDJiK1czMFJRYTJlRzRqYzdqVGxqcE12cC9pcSt2K1dyOTU0WVpa?=
 =?utf-8?B?YUV6MWM1Uk02OFpBNERUamR2b3U1dW8zUmZQRkJMcENVM2RUS0o4SnNNN2Yv?=
 =?utf-8?B?b200bEoxZVE2ZUMvR0xKeXEvNW41TitiaVQ1ekdDNy9Ga0E2NHl6RHpZNE13?=
 =?utf-8?B?Q0NtSWVOOUFRcUdjZnNmbFlwcTB5bHFFU1d4RnI5OFRXUldZNmJDaU0vVXZN?=
 =?utf-8?B?RUtqZ2F2YmF5TE5qdUJTMU1ia3RMRDRnL3NXU3AvL09lY2V3bHVyL3BRMEYr?=
 =?utf-8?B?aTh1R1lQVDBRTnVBT0kwVFZJeng2SlFOdUxSRWNVbkFWdE1ROHNoNEhLRDlH?=
 =?utf-8?B?WWdQTVk3YUhrYVJ0L3pzN3oyRHBvN2FPT3lFZ0xpYXBPQ2I1bnpLeWthcnI4?=
 =?utf-8?B?UUFJSkVjWld3RUNNbFluRTN1ZnlhUzg0V3d4Qnl0bFFwZ09VbG9zRnN4c2dG?=
 =?utf-8?B?VGVLSjRpZUgzd2xrK2NpZ3FtbXM4SWs0WEplU0QzN1VvMVUvcVYrUXRZd1dp?=
 =?utf-8?B?N24zdHJzblQwYUhkcVdldHZ6ejBINmc3VzV3NUZ0Q1NlckdjdENmVlpwb2ZH?=
 =?utf-8?B?Vkg1ZVk0OGtzVjduU0xRYkM1R2ZFQ1ZxbmxRelZPVXFaZVBpa3J0Vi9LUzJn?=
 =?utf-8?B?bG9ubCt1NjJZY04rczBna3NlTGwxejNuN1VzZEh2YTV5YWdFbi9DQlc4bzV6?=
 =?utf-8?B?VlIzZm1RSlBuNld0aHd1aStZTUZvVUJRRkZLckJXdjkwcGR0VFdSUnk0Q3l4?=
 =?utf-8?B?TnpsQjd5Q3l4b3U2YkZ4ZDZqN2o0RC9FMDZicmxqaEFkOWpudVVhMUtLdEZW?=
 =?utf-8?B?UC9EeUxHclVMa3pZUnkwWUFTM0xOVGYrWTNJTGRUVkMvZHA3YUNESkMyc05z?=
 =?utf-8?B?NXJnREtWMitmTHJVcGxJSThmQkFla3hGK3RlTjZYOHhLbXI3MGhlTVg3NFNG?=
 =?utf-8?B?NG9EQmYveUh3V1grNnJlOSttc0ZzWVg5anBDS1VaNTZ1NmlScGtZSDY4dW5x?=
 =?utf-8?B?RzQ2NklneThXRDJCSWVoRFRCRGl0Q0tCM1hhYjZOdThhUFdCYkYzTnlVTi9h?=
 =?utf-8?B?TUd3L1hoTSs4blBseHJFOGZsMDc3ZTVtU29jQkFZbHB3SnRZM2NWUDROTkRD?=
 =?utf-8?B?NWw3cWxETlhzbWRqR3BIY3Jrek9IMEZDbWFBSTVHWC9kWi9qMi9RblV4STFk?=
 =?utf-8?B?Y3lJajNrRGNpWDBtQzZjeENlQzV3VUVDWTd0eXVLLzFlc0REc3FHRjBobjVt?=
 =?utf-8?B?NTVYVjE3cDBxU1IzSlZ3aGVBQUJpbnRYMG1IT1YvMVJjRzRKMHZ6WHRPSkJl?=
 =?utf-8?B?eHNMemVvMkNKYzA0WFlhVXZMeHRBeHdDYmJkc2s1enF0OHNEUWMxaWcyQzVL?=
 =?utf-8?B?UVV4NnhMRjh1QU16Qm10Sk90bkU2Y3RWczRrbUQ0b3ZPZk5lbEROaCsyZDlZ?=
 =?utf-8?B?UnJQekZKRlRnazJqU2p4TzNVU2J5czEweHdGV3ptVmpWaFNMbkZQZDRubmdZ?=
 =?utf-8?B?MXRjL3M5NCtDUWptNmRDaXVON00yc0doN2o3VFhNdzVZZVV5RWY2aVBsSlhp?=
 =?utf-8?Q?+6+A=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5adb9b61-fd0d-46b9-f659-08dcc06681ab
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 15:49:27.6017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KdvzebjxBYU619J9D6PzKSN59s6GMEQGtu0jVPR5FuFST/agQu1Nrj0cvp6+rFIo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8484

Hi Reinette,

On 8/16/24 16:35, Reinette Chatre wrote:
> Hi Babu,
> 
> On 8/6/24 3:00 PM, Babu Moger wrote:
>> Hardware provides a set of counters when mbm_cntr_assignable feature is
>> supported. These counters are used for assigning the events in resctrl
>> group when the feature is enabled.
> 
> "in resctrl group" -> "in a resctrl group"?
> 

Sure.

>>
>> Introduce mbm_cntrs_free_map bitmap to track available and free counters
> 
> What is the difference between an available and a free counter?

It is the same. Will correct the text here.

> 
>> and set of routines to allocate and free the counters.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> 
>> ---
>>   arch/x86/kernel/cpu/resctrl/internal.h |  2 ++
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 33 ++++++++++++++++++++++++++
>>   2 files changed, 35 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
>> b/arch/x86/kernel/cpu/resctrl/internal.h
>> index 154983a67646..6263362496a3 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -662,6 +662,8 @@ void __check_limbo(struct rdt_mon_domain *d, bool
>> force_free);
>>   void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
>>   void __init resctrl_file_fflags_init(const char *config,
>>                        unsigned long fflags);
>> +int mbm_cntr_alloc(struct rdt_resource *r);
>> +void mbm_cntr_free(u32 cntr_id);
>>   void rdt_staged_configs_clear(void);
>>   bool closid_allocated(unsigned int closid);
>>   int resctrl_find_cleanest_closid(void);
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index ab4fab3b7cf1..c818965e36c9 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -185,6 +185,37 @@ bool closid_allocated(unsigned int closid)
>>       return !test_bit(closid, &closid_free_map);
>>   }
>>   +/*
>> + * Counter bitmap for tracking the available counters.
>> + * ABMC feature provides set of hardware counters for enabling events.
> 
> "ABMC feature" -> "mbm_cntr_assign mode"

Sure.

> 
>> + * Each event takes one hardware counter. Kernel needs to keep track
> 
> "Each event takes one hardware counter" -> "Each RMID and event pair takes
> one hardware counter" ?

Sure.

> 
> 
>> + * of number of available counters.
> 
> "of number of available counters" -> "of the number of available counters"?

Sure.
> 
>> + */
>> +static DECLARE_BITMAP(mbm_cntrs_free_map, 64);
>> +
>> +static void mbm_cntrs_init(struct rdt_resource *r)
>> +{
>> +    bitmap_fill(mbm_cntrs_free_map, r->mon.num_mbm_cntrs);
> 
> Apart from what James mentioned about the different sizes, please also
> add checking that the resource actually supports monitoring and
> assignable counters before proceeding with the bitmap ops.

Sure.
> 
>> +}
>> +
>> +int mbm_cntr_alloc(struct rdt_resource *r)
>> +{
>> +    int cntr_id;
>> +
>> +    cntr_id = find_first_bit(mbm_cntrs_free_map, r->mon.num_mbm_cntrs);
>> +    if (cntr_id >= r->mon.num_mbm_cntrs)
>> +        return -ENOSPC;
>> +
>> +    __clear_bit(cntr_id, mbm_cntrs_free_map);
>> +
>> +    return cntr_id;
>> +}
>> +
>> +void mbm_cntr_free(u32 cntr_id)
>> +{
>> +    __set_bit(cntr_id, mbm_cntrs_free_map);
>> +}
>> +
>>   /**
>>    * rdtgroup_mode_by_closid - Return mode of resource group with closid
>>    * @closid: closid if the resource group
>> @@ -2748,6 +2779,8 @@ static int rdt_get_tree(struct fs_context *fc)
>>         closid_init();
>>   +    mbm_cntrs_init(&rdt_resources_all[RDT_RESOURCE_L3].r_resctrl);
>> +
>>       if (resctrl_arch_mon_capable())
>>           flags |= RFTYPE_MON;
>>   
> 
> This is also an example of what James mentioned elsewhere where there is an
> assumption that this feature applies to the L3 resource. This has a
> consequence
> that some code is global (like mbm_cntrs_free_map), assuming the L3
> resource, while
> other code takes the resource as parameter (eg. mbm_cntr_alloc()). This
> results
> in inconsistent interface where, for example, allocating a counter needs

Yes. Will address it.

> resource
> as parameter but freeing a counter does not. James already proposed different
> treatment of the bitmap and L3 resource parameters, I expect with such
> guidance
> the interfaces will become more intuitive.
> 

How about making "mbm_cntrs_free_map" as part  of struct resctrl_mon?
It will be pointer and allocated dynamically based on number of counters.
All the related information (num_mbm_cntrs and mbm_cntr_assignable) is
already part of this data structure.
-- 
Thanks
Babu Moger

