Return-Path: <linux-kernel+bounces-192320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D49CE8D1B81
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3EE71C21B74
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716B516D9BD;
	Tue, 28 May 2024 12:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="afXj/rzm"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B571F1EB3F
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 12:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716900022; cv=fail; b=oJM0dd+Adsv/lz1b6Wyu2+f3xHYiQm8+d0xZg3HxgpP23NaPQHONwMszUOFTBIob8YFsGPV0RlUtUigMF5L0CnrEDYZftRYwcP1i3JLHmiBpyrujXgim4HiCV/yNqbBvjnf8oVO9g04nh6OQ3uWQeEx0YhJZ3+UXhpA7+Ij7dyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716900022; c=relaxed/simple;
	bh=XG/5mh0vrWP5JocJ9eXlHp7OYCA63g1SSbOWc/FzV0M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=luLHbQ7vY5R9rc+d6AqmU7bc+ZblBw/qHbiWO1pWKeELvkcNQSuHJpyJhywQ+wLToXcu/WHzYH9Oyu+d71cS6X5KzbJ5rLnVdTfCFXmT36RZSSswqHsiWND7XDx3++Mm1bwcnY8U6GlMo970WCAHjcrnTRGYncdI8+ttD2DMnSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=afXj/rzm; arc=fail smtp.client-ip=40.107.223.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QUYG7+YWw9dfRL2i5JDHs/ObjrU/1q/lTAoCMLSdchoyWBARF2BZen6MPBFGERqQKUSGgnKesUIoj/hKuILbxZ9y8lTgkaxmrVu815P5wFMJ3VJsLU54C8kuiw3PRKpGcFLpPQvJpfjmgbsIuv6afTK+NSrvpPPHR2LZrt+N7vKyUZrT5T38c3DZetYt7nqQk6wJphoP/qejSHldOhRqcmQeXE3k1eJA52x0Ix8/SzJVE81BRhkKvboPbbO8e59D0IpHAIC2iU5aa8GusNXiLzZwZWtRmrwQhTv7A2GmNVZrrHvEgRCI0JJZV3k6YCAe9wwaDvEq3EBQ38Y1LgD5ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2jQpNfX1SrUVJzJfxjbFzWhHCjtrdV0lSYqgud9qHcg=;
 b=TBq+kYgvYZUXZhoDTD4yjTcnsesNTSCIT+xM6sSdrepdwpS5uBzhfFC3bAOHETBt33DIO9BLWHfrqO/qVIBRZhhcNPEzHDp19ly1PavcAAVhLv7944AkO8oyGpzvtbr3HWuuUG7BRsZq+MOpz4RnVLov+0pWFAJ/unP5zpX36KyT6l3NWqLexf3yGiLh3VvKkPiP1Yo7MKH5CoaHx2K46Qa6FMwVJjhat9Vnle84a2Gco4Ln7d+0MepKIxIgR15eK2MANtEX0tH+B/5ZTn5Da5g1qXEsDoIWBJ7b9vJ8Rw8n6rNrhWja79yc7FcmzmbE+wP5IkIncF5O7NcUNaWYBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jQpNfX1SrUVJzJfxjbFzWhHCjtrdV0lSYqgud9qHcg=;
 b=afXj/rzmR+TaK/5LD/iM0C8Ou/JZCD/MGma3zb46J5i4tG8KWk/UhPvHyU1ZX2VbWWtLqQEm4fTx8IzQ54iKxL8/R1RS6QF6lY+IyrVUlmL9KyPxhDKfaAIxZUdGcbB4AVZhGcnvsDhmQuHJKOD1Q2aKgMyqhi1vIoOBDNt7dsI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CY5PR12MB6035.namprd12.prod.outlook.com (2603:10b6:930:2d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.30; Tue, 28 May 2024 12:40:16 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7633.017; Tue, 28 May 2024
 12:40:16 +0000
Message-ID: <70b0c2dc-0ec7-4b04-9742-e54b6e56e6bb@amd.com>
Date: Tue, 28 May 2024 18:10:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: select CONFIG_CRC16
To: Arnd Bergmann <arnd@kernel.org>, Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240528115050.2831206-1-arnd@kernel.org>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240528115050.2831206-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0214.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::9) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CY5PR12MB6035:EE_
X-MS-Office365-Filtering-Correlation-Id: 32cbecf1-4edc-4933-a662-08dc7f13538f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eHA5N0kzRzMxZ3BvSW5XY3BGOVl2V21abThTL0hKdEM4TVZBN2dHNTFEbmJM?=
 =?utf-8?B?TEVKejNVMThtaUo2RlpKRDgrakJtRHdVYTBtc1pVSkRJY0NPblJvazhtdDZj?=
 =?utf-8?B?QWZ0bldCWkdRemVZekttRE91OEtpSU5sVmxSNG1HaExoUXk5akJKZlo2SVBB?=
 =?utf-8?B?by9ROUdJWXNZbUlUbXgvTThLeEFKOE5BbktMNVZsa0Q1a0dycWRBVmN6NGJZ?=
 =?utf-8?B?RnZkNTgxOE82TXNJZ2JjWkVFd1pCeUd3SzIxUHViYVR5WXR5NzNTMkk2SHJz?=
 =?utf-8?B?aklOMjhybXJ5RWdEZzlHejFJQ3ltc000Z1BMWU1YcVA4VVZzOFpyNG41aEFS?=
 =?utf-8?B?VXR4UFhFOUc4Qmg0bWxHSlFVZnFiRUFZclNaTkF1MDBJSUhkbFd4ME5kSVBm?=
 =?utf-8?B?VVd3UmI3U21NVE9BaC81VWtSYkw5RTlnWlVTL043OExBQU8yWHNQRGhPN3Y0?=
 =?utf-8?B?TTAxUzZKR1Flc3BmaFdhTFJaek01ZHVFSk1FMUx5R3RIc1gxZjVtaGJhaHJq?=
 =?utf-8?B?M1Q4L1J4WGVNQk9QV3Z4aGFHNkNZUGQ3ZWxHQ0Q4RGVFbHY1cGxRTGtXRDJL?=
 =?utf-8?B?ZU83emRRRHpFQjRKWVVQVURob0lwemY2SGorRTBqVk04NWpXK091OTc0OFdT?=
 =?utf-8?B?MDhRdXJrNFBYVmxtV2VKK0QrMzYyVjJWUW5LVHcxUkgwRExNb1lvRlBmZksx?=
 =?utf-8?B?c0VadlZKNXdUalVpdUkrU2gvN0pLdkp3bExnMi9ETXJnNWo4NmU4dVRDeHBL?=
 =?utf-8?B?ampUR1djajJvRy9wc1p1Sk5ML2xsbnk5MzVoZzJjVWowLyswZFRPWU9vcFgx?=
 =?utf-8?B?bDdYd1NTTU1QM3dVdURCUVBxdlVtZ2hqQWxsSjBQV09rbnJVQ09Fc0VsYXpw?=
 =?utf-8?B?QnlVSEpoVzFjblZpaDlRUWhIS0xwM0hielhiRGVMcHo4UFlESjZkdlhFUzhF?=
 =?utf-8?B?TE5HUjNzcndJRlpxbkpSRUdjdFpZMWN3TTk3TDZ3amRIbmNnSnN4bzBHQzFB?=
 =?utf-8?B?d09KclFCeUNVV1lEK3hzNkJVczlDQjl5aDlaTE5wTGZkK3NRUy9lMzE0dGVn?=
 =?utf-8?B?RlM1RHdZK0ZTamY4V0cxSk5UUU5ObUQ3L2t6eXEvV0pGbEd2S1llcTA2eXMv?=
 =?utf-8?B?TkFhSktsMGcyUyt4VWlEd280UW1Ib0VmUUpDNGFYMHRFeFcrdnNad2pqbFRn?=
 =?utf-8?B?MDlJbHAycDZKZ204KzBrVFZORmtPRjY0ektTNXd2Z1RGMGEvZ2lyaWtiM3Fh?=
 =?utf-8?B?RTZpVGk5alYraGViM25sbVR0S2dnNFdvUUxTdExPUkc4SW1oWnlDcXpoVmwy?=
 =?utf-8?B?K1laOVJlWjFhQVRBMUhRVmR4S053Mkw3SElEbEtZQm83cVF6ZjRUdmdPbGd1?=
 =?utf-8?B?NnNoL2lTWTZDQVRNQXNlcTlOYWY5cW1qT2NrZlBZRDBldHNsb0Z5OVpsKzhP?=
 =?utf-8?B?WUhPaWgzdHpMU2RQTzQ0ZnM3b0tyQzlKUEQxSmY5dmcwaXpLUkVoT1c4N05Y?=
 =?utf-8?B?bUR2bXhuQ0JURDVqRHBOZHFMOFY1eHg1Sk1zKzRmZjVYK2tRcFNQVXIzOU0v?=
 =?utf-8?B?MkdhTFA2VlpXM2tPelpWV3JNaFZzeHZwOEFIcFR3NXlpRk9LOTY0ZW5wTFM5?=
 =?utf-8?Q?a+0bE9DKzoWUkh6J3DAesCjzDpkWqr4+pqqoJra905zo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7804.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QStYWVluVThNNW9GejNaaTd0cmFhT3lOMFBBUEhnTmo2S0pBU055b25qcTJx?=
 =?utf-8?B?K09sd2hUTkkxSk5OWmtieERsYU45YUs1SFI1eW0xaTZoRm8rQ1ZjZURoRUcr?=
 =?utf-8?B?RFExeStVT3A1cEt5OG1QdW54by9uRmdRQmZhZzZNS1hJZmpOeDd6cW10NUhQ?=
 =?utf-8?B?VVFaWE8yNFpRSXZzc2ZGd3BPWWhobEl1MjhFWG9mMzlISDhGOEdZLzZlSXhx?=
 =?utf-8?B?ZXNRbElvVG5pWU9aV1dXb0d2aGhGTFcvZGtqMDl0NkN0OCtPaUduZURqSFlX?=
 =?utf-8?B?MWN1YlhzL0NxTTBXYURBbW93Y2dhaDlmRk95WjJNKzZQVTI4UEdGd2JaZ0c2?=
 =?utf-8?B?Yll6RmRJV0czMno2OCs4anB6aWplTzNmM0ZERm1qVStHYy9LdS92VTJ4allw?=
 =?utf-8?B?cUR5c3FCbkpBL0RxN0ZyWlF1M1RzT1owQTlqSXFsSk8vd3lVblkrb3hvdjV2?=
 =?utf-8?B?OG5zU2JmaUdkUmovTzhjUWlrbU56MzVIWEI2YmN1eEhLU0FTVDRuditoUml0?=
 =?utf-8?B?eEhTY0I5YlEwdDBNQU1xUlVLRHVFUXpYQWxuWW1JQ002dFgwUm9HU05CSDdF?=
 =?utf-8?B?Zkd3QUtOc2NscWJ1VG5PbWFBYnBJMi9VSk1uY2xZZGVPVndqYm16UFZ4a0Ji?=
 =?utf-8?B?TmNWV1BQNTgrUHpyOFJhVDNWbjlWRlhaYjJxeTJ0WEdRc0ZoLytMNlNEQ2p0?=
 =?utf-8?B?SVoraTNLNU1yN09uSlVVYjFJandya1BPblFNUnp4cHNGNjdLY1FCMHdvOVdW?=
 =?utf-8?B?bXlnSmc0TWRqL2ErWm0rdlMyNnFwOXYzMldJbFFWdmtUb05ZS0RhcmQ1RVNX?=
 =?utf-8?B?c01hdVN0VEJiSEpEUHdUVFVLREVwK09UOWxubjVPTVNGZExjb3FSSlBKMjQr?=
 =?utf-8?B?dTZpaTFqUVlndDBEMFpMemFlYWN3cUc1QmxLSm94VmVuNWNYMmpiOEM3bGZF?=
 =?utf-8?B?YTZkNFJEMHJDM01qdW9JTlZSWnMwK0dUbmp4TE1lSGtJMUYwM09yYWVKb3JL?=
 =?utf-8?B?a3FGTVZtSmZMKzVSY2dQN2orOGV0ZlBlTnBId0tMZ3dKUzJGZ0c1Q1REWFJv?=
 =?utf-8?B?NTU3UlhSQ2lGNmlpWHpTT09WcjdReUxpUVdYZEZTZy9CSlR5dEc5dzdZQVZM?=
 =?utf-8?B?QmNkbko2OWlKZDVJd2k2bGJhbXJDTU0zelY2ZnkzcEhnT1M0RzQrMWRuNDdw?=
 =?utf-8?B?UVpXRGwxYzF3TVRhNnVFSDNMYzU0TXBtamw0QlFoTHUvcWREbjZDdTdGd01x?=
 =?utf-8?B?NUovcjNTbU9IYWhIVDhsWGZMalB4bzk0ak1hVER3UGhTRStHZFdDaUxIaTlq?=
 =?utf-8?B?b3AwNXc1TnBiTWhIdDhlazRjZHk1b2owZ1ZYdDNYVG1iMHRhUmtLL0tSdk9z?=
 =?utf-8?B?UEkrT0htcjJnZElpWU9rYlFCVjZUbkxkL3pKRm9xUzJ1QWV6ekVsL0o4aWtG?=
 =?utf-8?B?SXRGUHhGbm5DTEtjWmtWTEhmOWJMVG51QzFNRHBxK0NFQU1xUG9iY05Ycmxq?=
 =?utf-8?B?WlNKQWdkaEZacE56MTBWUkhxVWdzMWV0NlcxNTl6Ty9QdnZQTytQSGRpRE1o?=
 =?utf-8?B?ajhWODA1SWJwTmRjOExhV0tLbjFGUDU0cUYxY2dxSGMvekswWWVzOEtya3Vl?=
 =?utf-8?B?U2ZCSmhmWUdLVUQzcHdwOHM1cWFHOEZQOFVpVFhSU1NsTzFGKzA2aHdxcUwx?=
 =?utf-8?B?RjNtMnU0SnNMMW95QUVxMkN3OXNIdGIvSFBiWE0wWmZNV0poMDU3MGovRW5y?=
 =?utf-8?B?YVZycm5wMUFvbXBHMExiWVFDYjlsNmE4MHNXOFQ4citWSGhPUkxaYWZTdmtN?=
 =?utf-8?B?WlZidmRDN2FQdVNzMURHMnZJdnlHWFd2djB6Tmdmei9SMDZxN3FTeXIzNHlX?=
 =?utf-8?B?a2tsMG41YW9OYWcrOEllTEVnT1pLak5pRy9oS2M2MkdOMGhBamVhMndBMnY0?=
 =?utf-8?B?MGsreDc0WTVNbDdiakdCNTJtQXJMWE9RNU5JdFFLc24rR3pTSERjOXg0WFRI?=
 =?utf-8?B?Z2ZSeXVLL1dPTVRqMHE3cUlOcTlTZVJCSDRVWklHcE5YNVdLbmZBL0gvMERs?=
 =?utf-8?B?WG1NamkzNVFRd1R3UUhodTVZejB3b2QzR2ViVFdXampTVG5NZmNoNjN1UmZo?=
 =?utf-8?Q?kGDOC6ijASLF6eXu3mSkuLE63?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32cbecf1-4edc-4933-a662-08dc7f13538f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 12:40:16.6808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q9m64DHDtOnFFGGWpxAJ9ElXmAkUqAfLXEEr422XAMkn/DlSChkHoZVygNXFteM3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6035



On 5/28/2024 5:20 PM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The amdkfd support fails to link when CONFIG_CRC16 is disabled:
> 
> aarch64-linux-ld: drivers/gpu/drm/amd/amdkfd/kfd_topology.o: in function `kfd_topology_add_device':
> kfd_topology.c:(.text+0x3a4c): undefined reference to `crc16'
> 
> This is a library module that needs to be selected from every user.
> 
> Fixes: 3ed181b8ff43 ("drm/amdkfd: Ensure gpu_id is unique")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for the patch; this is already addressed with -
https://patchwork.freedesktop.org/patch/594816/

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdkfd/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/Kconfig b/drivers/gpu/drm/amd/amdkfd/Kconfig
> index d3c3d3ab7225..f82595af34bf 100644
> --- a/drivers/gpu/drm/amd/amdkfd/Kconfig
> +++ b/drivers/gpu/drm/amd/amdkfd/Kconfig
> @@ -6,6 +6,7 @@
>  config HSA_AMD
>  	bool "HSA kernel driver for AMD GPU devices"
>  	depends on DRM_AMDGPU && (X86_64 || ARM64 || PPC64)
> +	select CRC16
>  	select HMM_MIRROR
>  	select MMU_NOTIFIER
>  	select DRM_AMDGPU_USERPTR

