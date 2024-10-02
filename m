Return-Path: <linux-kernel+bounces-347372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3D898D1C9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28D52287E80
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2D220126C;
	Wed,  2 Oct 2024 10:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IDSxSkMp"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C178620125C
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 10:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727866578; cv=fail; b=iDp5joTxjIN7VZ2Zx+oFsKdxKlpDOa/bb42Nl+elYIgiRiJHuJeqkZOCAwJ4VChmoZ7bd7VphcdMjCJAge6IGy02MUU5neiOreRnlr1IpUaZfGvu5CBv4ULVrqWRT+jkW+VFTlTET4uzOikkW+nyQGIm9S2F7wTGMiYt8woChF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727866578; c=relaxed/simple;
	bh=kx6FbcIo/B2Ex5LF2tVStxG0rIJgQSPAasjYKd8wN1Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W6CR7y7dKFIve6TEA4ptgqZ+Wk+TTxZFKkGbrTXPifIG7JJ4obSYYSuM8XaM9kzPv+As4doYHmwd2YGQ1891aFpUm4V3Z8Un86XlxmclH61nVHATF3amFCzOzpEvZXMlgODgV7UB23SHeQctLA0dN9f5Uzfh4t32XdI6h/VgeLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IDSxSkMp; arc=fail smtp.client-ip=40.107.93.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h9IPqmgDMxGQfyArGCZkOuBZ1/7ROS9/qJQk9egQQyHSCHiQ5eDAKFicN4Mlc7SUkvQTcdmZ2xlbSm1KMDfbYW3KxkQFSWmNPXVYXb/DylrAxF1vazINiM6h8q7hc03vfluA9bMRwY/GbRkHul/rh7B0Uc9Y3sNXlhW+GFXsaxkK5U4ej6KU4Vqvis03lbL8hVT63ZvEjy/DHMeFKVdRQ0YwzEn6G26omscaNnWXk/CDk+uQBv0rMxbrt+QJI3HcCXbfp4250DSLNgVdGKeHmCSqUvXYOLRG3tV8TTmX+aQTdDrE0j73lZLhH9my0LjEPp0raWS+U7WDfwQdznfX3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GbS+k+YvWAwiydFDHXIH6G3uqbBnmQzgdHee0tzQ8T4=;
 b=enDTYqIaeBnnfFK7OXER7fZX5LCmQVRnD2jRzaCyM+bYl+WelqAMnWEgJ4tcxHefPJBD3KDlzzhJScGgLtp/VxTGGIxGMA44AFkR7SlNyt9D2kfkYtyCjGYAoEtzFQZk3X73ZzooiD4qeYZ+mk4VPDxa8dAkHYGx3gsYGMNiUdNl+lXy3ueouRv9j6lyOKpWueJV+VYFdddodw7p13jFeZWkEHJDXYLdxs4/upF+hjCAOCsVPW9tbfQaBkz0gA2rUI6nQFMdLDehck9DLs1x55pV/cvRDSvO2biOo9T/K14fpRjItXAqRkjsNKf4h8DoaIKO6y+SUEPP/DtyfQhqMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GbS+k+YvWAwiydFDHXIH6G3uqbBnmQzgdHee0tzQ8T4=;
 b=IDSxSkMpjSZ8bHhhakyiuCAeJrQ/63FOxRcGcAleDsv0zI0NuwvV0S7d29WwpwUA6DIiecJ85EJT4uVB7l9+ERMu1A7awVMHPuabfgAfFllQ/MpkC6CPmdupp7lLu0mdPzMZi8fSSNqxO8qUPObYMMe6PZUqfcslG/NxgBBIqlY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by BL1PR12MB5876.namprd12.prod.outlook.com (2603:10b6:208:398::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Wed, 2 Oct
 2024 10:56:14 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 10:56:14 +0000
Message-ID: <dfc5cace-cfaf-4c51-9df4-5ba82017ef5c@amd.com>
Date: Wed, 2 Oct 2024 12:56:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: xilinx: fix feature check logic for TF-A
 specific APIs
To: Ronak Jain <ronak.jain@amd.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240920055546.2658783-1-ronak.jain@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240920055546.2658783-1-ronak.jain@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0107.eurprd09.prod.outlook.com
 (2603:10a6:803:78::30) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|BL1PR12MB5876:EE_
X-MS-Office365-Filtering-Correlation-Id: ff3d953c-719e-40fd-aa3b-08dce2d0d549
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SmtUZytUYVRJbHF0WCtIOXVGaWVxU21wL3ROcXZJdzFPa3RvejVzUEF2bHNs?=
 =?utf-8?B?TG9nS3F5cFJjV29SWDlVMkZ1V0d5aTl4d0llZEd6Rmh5VkNGNFU0TlBnV0xC?=
 =?utf-8?B?UHovQzRoc090djVWRHdZQkNJQjdGQkhNQzJ1b0l5eDhjNGNrRWlJN1NxNGdH?=
 =?utf-8?B?NS9UWW82VFA4RXVubTZ0M2dycWRBUy9FMGJuWmlxZGN4SlZaN20zVmRHS3ZD?=
 =?utf-8?B?M29qRHdlYm9oUEhCSStCR0t3MUplZG0zNDlvR2QxVHF0VzR5d1lYMDFIRk5J?=
 =?utf-8?B?Q2FKRWVBK3MyS1cvVXNXbXdRSUdMcHlQR2dpQlBZelJTa05wR29sdXZXZG9r?=
 =?utf-8?B?OUVpN2JOQlhrTjBxclBxL2hRZ1l0NTJuL0Y2bGxUL1NLbDIzOS9jLzNLMTNP?=
 =?utf-8?B?WHQvR2I3cDMwMjQ3VzVaTnp1eEppNXc2Y3NEdnYycjg2SEFPYW0yQ051Ynho?=
 =?utf-8?B?OEg0SE1oZU0zZVZydi9NNWZ4THBLa01QR1RNZEhmcFVNTGRnc3RFT3UvM0Ja?=
 =?utf-8?B?MlljVTlyb1JZTWp0SkVKeWNKcmcxNE9oVi84akNzRVlvcDlESzNNQUoyRTRD?=
 =?utf-8?B?dU42eVc2Q2JleFN4SVNqc1FTLy9vRVEyOTE1N1Y4VXR0cmh4NFRMR0M1YURS?=
 =?utf-8?B?QlFjVGtGQms3aXc4QnEyZ0N3cXB1aEMrWjJaYkUxeTRkeDgzVDlNWkVGOVVj?=
 =?utf-8?B?N1BoeTZMK0pmZVBXYUNEUkZMckFmSTY0cG5Qdm9sLy9QRlRQN1NTOWFOa3FD?=
 =?utf-8?B?RTRsN0hZclNnN05LUmhwaFVxei9nZHl1MDRRd2M4Ymt4WGJDRGtDaTBFVzBK?=
 =?utf-8?B?RFIzZzNLMEIxMEgzQTJhQTRPSTI0bExjVk8wbnZmbG92RXhxRFkrSlhmSmFp?=
 =?utf-8?B?Z1IwV2c1T0dhZWkwZ3FzWFBBMDYwL3h4bmVUenc1YUhiNExWdXo3SDBLdUdi?=
 =?utf-8?B?KzhwellTaEoxcmFCZTZ3c3lLZ1dvUG9qcHlOTGtsTVB4Z214OG45VDUwSldM?=
 =?utf-8?B?anR0MXNLRmoycE8xRnBpWWZLVXArOTN1UnNOV0RLRzYrOW1MRzcvNGp3OGtM?=
 =?utf-8?B?L2dSWDNuRzJ2N1F1Q3RQM1BOYndrbmpWYWZiUGM3OFRGNlJPQ2FMUUFyM09G?=
 =?utf-8?B?YTZoMGUwYWI3bnFPNVFsRThOQ1ZIRURPajgvclp6RUVkZkZHWVZ3MjVSSWM2?=
 =?utf-8?B?QlVSRWI5c0xQQUpQWnJiSE5BRjRQZEJFR1BRK2tWZmQ2dFhKV0JHWUYyQXE1?=
 =?utf-8?B?eWVGSnlHMk9lMHB4b1k5bFUzbVBTR0ZYU0VRaEFYVDQ0OHVMWTFDbFQycFJo?=
 =?utf-8?B?WDZzTE1EdGhBZTRjcUtIVEJzYzFHSVdKNFkxbXFFTHhHaEVXM1N4bmt0aW1W?=
 =?utf-8?B?QkpWTUw5NFlyNHVNeXNhMHNBa2xyZXg2aXJzLzR1MnRSeTNEbmZyZHhYTHJK?=
 =?utf-8?B?eGZQTW1jbEFBZXZubmQ0blVJVmJHM3kyZUV5eGxWTXYwOUFocXlLOTh4dXJr?=
 =?utf-8?B?YXNOdnVKdXdMZU5ZZ3RHclhPSzdyd0FzYjh3cWZiRHJtakNVYmU2Qy9Xa3Ex?=
 =?utf-8?B?RFRRZUZpNVVUczhQSFU0SHEzQ3A3eHh2ZzMzLzFpaVQ4SnNsa0FYeUVyRStX?=
 =?utf-8?B?dkFiTmVoN3BpWXl5UkdRanBNaWsreW9NK29SaTdXb1pEYnM4RVY5YVNtU0FG?=
 =?utf-8?B?Tll4dEtNM2NlVjdyR3BMRnVpdHVOSEFOR0hERjJ1aFRUbmpsOUhGZzFBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MzdLQThmZWFKNE5HdURHSnkwckxibExzUDRaSlVUS0J3c05hYklKV3c1V1U1?=
 =?utf-8?B?dm4vQTFWL0pBR1NPMUtMYzZEaWVoeW9wREJSdUdMVE05R2JVdW9PcmFlTnNT?=
 =?utf-8?B?TS84UG1oNHRYSW5XaDE5Uno3VjZ3WC92RU9VdlJJK3JHN1k1aE5INlZOYi9P?=
 =?utf-8?B?VjJ2V2VMWERHaVRZZER6Y2w5eGdaSjZ1Z1BGTjd2Y2l2Z09sd3ltQlJJMUJv?=
 =?utf-8?B?UFVuQS9HT2tPOXg1S21aOVhPZmh5a3FNYTg4MTM2djRFMDNFK3BwOWdNTFVV?=
 =?utf-8?B?anhqMmFqVFM1NmZTTDBPZEdIUDRWckZSZTgvMUhFUlQwRWE2MVVLSXg3YVY3?=
 =?utf-8?B?Y3hVYnYyS3ZPV3k1ZTRhNDBvV3B2bGFqYlF0RHkvTHMrVEZ0cm5OYXA2bXd1?=
 =?utf-8?B?eHZhSDM2am8vS0hjRTUxN1VlNGFuSTlOTnRjOXFNTmljVWdRZzN4YXI3YXJh?=
 =?utf-8?B?aUFrMk5kVkhkK3lVTldiUGVtSFpFNkRHYS9RSDVpTTdvbU5PWmRXQXFYWU9v?=
 =?utf-8?B?TUxla2s5Z3ByWGNrVHZxZHlvODVaL2daVGlZcTE1dkJuQ01VMkY0YjZaUzJa?=
 =?utf-8?B?cTNsNlBQZDBaeXNhSm1vYXRCdEQ4ZlJxb0haTWdWWnp1L0Q0QXFaWUdIeUZt?=
 =?utf-8?B?R0RHN2RkRUI1TTdCNm1VSkM0ZkpGK2t2cEQzUXdZZzdkczZzQlBoM0YzcWhy?=
 =?utf-8?B?WTZLdXVPaXU3TDVTWEhobVdCUHhqRCtlUkFxSEdTcTZpR3llTFd5N01VNGVQ?=
 =?utf-8?B?Z1M0L0ZDa0hIY1RQaEFBM3c1UXlWb2VIdE8wM090VG1mNmhKcUZTU0hBMWlw?=
 =?utf-8?B?SWk1NjRaYXRaRHBjVGtOQVk3MXhOSjFUSG1NSURvMGt3L1RLdyt0Y2xhQm1l?=
 =?utf-8?B?ZlBjUEpTTDkrTGRxZ3RZNVJjcDlhN1pFd3FFWG1ZY2hlQUN3WEgzb1duMEdt?=
 =?utf-8?B?Y0ZidHJhbEtjekFmZlFNbmlYVjVZUGZqRW1ucU9QZmRxTFc3Lyt0bkQ2S1pK?=
 =?utf-8?B?dzJRQlgreGcxOTEwRjBZT08zeVlRMGlQNGRScFd0ZldkL0JuNzBWRC9zb0U3?=
 =?utf-8?B?eHR3dFIzeTRBcG1HOUZnOVNKT29sZEpOR3JWWjBFYzE2ejhHZGYrVGFLdFQ4?=
 =?utf-8?B?Nk05UlhESTRJNk5YWWZUU011NEpXUWxTdmFJQ2IzbjdsNjcwV2VoL2d1WE1o?=
 =?utf-8?B?cEtnYWtXUUt0VGRmb3dWRWtCajFNZnFsMlpCUk9Mcmd0d3hqZmFPRk9wNnRJ?=
 =?utf-8?B?WnlGdmJnNTVwaXpIaGhlMnAwaTlqZmdSSGdjWVFqb3BTM0FueHk4UHQyRFNY?=
 =?utf-8?B?Zm8xYWVCMk5oQUUrVnZHVTNmcXoxOTZsYlBpYzJzTlJ3SE5QZzdiMmtvZXZh?=
 =?utf-8?B?QnN0WHJNTzJ4VmZkNVhsTExZVjhaY0xVQXVXSytKd05ubm5aR1I5YURVbkxV?=
 =?utf-8?B?NkJxT2QvZ21GSW1GeVZ6NFNXc3FGcDcxaG9XUlRoRitkOG8yc05kL3UvN05G?=
 =?utf-8?B?NFlvc3pYYnBUVlZQeXFsZEY3NHBUdnF5QURNQjFWbXNjTFhKMHVscEFUTEM3?=
 =?utf-8?B?VUIrcWE3OHdhR3FxVnBCR0FRNnh2WUsvcmwwbnRnN2p4R1JGQXF0ek02VXlS?=
 =?utf-8?B?VEhaOUxMNjcxRWptNGJpRXJ6OTdpc3JtU0x6aEQ5TU1aeUF2ZW4vSEc3ZlF3?=
 =?utf-8?B?Rjdka3VjbXdUaHpCaW0xQjF1SnpWNnBBdG5PVDJXQmdSbFh6NHVLZm1MS3BS?=
 =?utf-8?B?Qm1lcHN0c00rbC9veUZnN2FVbUpBNE03a3NwWEswOWRhVENqVE5UVlV6c201?=
 =?utf-8?B?WDcxTldaZm9JZjBYZUtyWnk0L2U2cDRhL3U1UmFSVUQyUWh0dzZabWlQSmk0?=
 =?utf-8?B?Z1FEUSsyY1lhN0dFRjhhRjIwdVpQNmw0UjEySEIrMG5VSXk5bzFDWDEvdU1P?=
 =?utf-8?B?ejE0UHgzd3VoSDhReU1oelR2NWsyOEpTcTB1djhabzEvbGxydUM2OFpzWDJC?=
 =?utf-8?B?ZFczS3MxOEEyRWUydm1PaHhBQ3dWM0pwTEx4UEZTMnlrM0g2Nm14Z1lKNE5t?=
 =?utf-8?B?bWYyM2h6QzFOZzRzNHNLdEdpaCtlc1l4dm5XUWxvRUVHYkZLa3gxWjRQNExr?=
 =?utf-8?Q?iSsn/90cnwWMRORMfsDbR9O4b?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff3d953c-719e-40fd-aa3b-08dce2d0d549
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 10:56:14.1432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TVeMJOVnmZJUwNa6YBYlzkXdK9e8TYpVqSBTAkDZayZcETkEShaNj+vaJuMqn4Ky
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5876



On 9/20/24 07:55, Ronak Jain wrote:
> Currently, Linux is passing only API ID for feature of TF-A specific
> APIs but for feature check of TF-A specific APIs, TF-A is checking
> for Module ID + API ID as a result incorrect version is received for
> all TF-A specific APIs. So, fix feature check logic to pass valid
> arguments to get correct version.
> 
> Signed-off-by: Ronak Jain <ronak.jain@amd.com>
> Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
> ---
>   drivers/firmware/xilinx/zynqmp.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index 5ab0dfb2b225..0b2ad46c8bce 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -225,11 +225,14 @@ static int __do_feature_check_call(const u32 api_id, u32 *ret_payload)
>   	 * Feature check of TF-A APIs is done in the TF-A layer and it expects for
>   	 * MODULE_ID_MASK bits of SMC's arg[0] to be the same as PM_MODULE_ID.
>   	 */
> -	if (module_id == TF_A_MODULE_ID)
> +	if (module_id == TF_A_MODULE_ID) {
>   		module_id = PM_MODULE_ID;
> +		smc_arg[1] = api_id;
> +	} else {
> +		smc_arg[1] = (api_id & API_ID_MASK);
> +	}
>   
>   	smc_arg[0] = PM_SIP_SVC | FIELD_PREP(MODULE_ID_MASK, module_id) | feature_check_api_id;
> -	smc_arg[1] = (api_id & API_ID_MASK);
>   
>   	ret = do_fw_call(ret_payload, 2, smc_arg[0], smc_arg[1]);
>   	if (ret)

Applied.
M

