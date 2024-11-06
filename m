Return-Path: <linux-kernel+bounces-398984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 398A49BF8E7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 23:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AD7D1C21D83
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 22:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79B320C31C;
	Wed,  6 Nov 2024 22:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ggpFlS7d"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81517824A3
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 22:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730930803; cv=fail; b=mQo3B9dWVLY7rjZ9PPk8H/oJHFphqXgGBhBmtM2EQtdiOVsNoqD0DMuwp9NyFPdZln9eAt8rysoxJfia2d59L+NQTmwhtWAqO1bJPdX1C/7caltdYdE30wnX723gAlLX9dcVTkFpSOO6r8S1Sh3sHHicSvz+47M64x3EtPCE+F4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730930803; c=relaxed/simple;
	bh=gtA0/rFAsBAmZpm6/zS/X5NXTNPX13H/aJr4FrZ6O1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ls9GhLNIR/ddKXrJCvawp2+PCwulHCkhNOKgzSYWHmsS5EukqeIVBkqwiNMzGFCE9KqV5GrolR4vTKv1uQ2SDpucVwa+b0IrrmFUP8RgqG2ZSpfUEIb/3hka+krlM4mcdmvAJrPM1u84IxmnMscu7y7A5XWl1GhCO+DQejy1xAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ggpFlS7d; arc=fail smtp.client-ip=40.107.94.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kqS3xogayWwAfzE6ArL1eUK/NO/lll8FqMbtUPbdZR11cVsLc4NVk+NrXy9MHiW/xYitS3as1Ys1hx9eMWWRu0s78hEFkxGrII7E1vCZGctHCEFmd9K8KrTdk/ILQfCr/MLTT9mDVnJNYGl7P1GTKRKOfhGaTXl18NXr6zljauh3i//G6TV31CvpesgklFDRYxv/nP2odQlBocRlHXYU5i1LfkHv3wZNeU1eaO8Duc9JSkyaTOvXGgBzAUyH05N6rFVQmutywYDxR4d9xPBzsdym1Ys3X6gYEEAovhGNVRhkQF28Rp/GmTnvtQ7uLFOE+Rb7gOL6NlabFb4FFuZ1Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qI8T8J03ORrardkxKPI+/qqIjOrD7qYYU2mfNRuvQy0=;
 b=ktKqE1dWSsx9hXyBhLBt80sa4e7aBZGzZj+fFs3MDxmkEeOGf9mcFV8nEqFKpFBDp6Xm2QDRxZ83zx+QDytOllRWm6VIsaxHjqCswy3rmk4Ya3HzU/Shrt0/HHBhpzDYljQZxM21iaF6RsVsWzHw2OFpTMSJiIRl7TRob2hRV/MAglMDiw2l9njrQZUyuOvp9ll/+USdr8d1fyPyR5TRue/18Q+sBctR6UO1uqv1pvyY5kqtoJ6ip/axvw3pfw4Ynwj9jyxlJ+7WS2sXNKHzANHUCoSUvIKt3VV3uTyOcS0cQNLAz7MN3bgMDwncwnbnUpYjZtmsdeJCooGsEx3a6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qI8T8J03ORrardkxKPI+/qqIjOrD7qYYU2mfNRuvQy0=;
 b=ggpFlS7dMg39mt0u7mDNoAximEVGlKAQkRT8iW8nQ7ISE6sA91BT5lzoN5JF0/Sd/zMTngBmBTPMXCzrbiUjTnubR+M7Sp1BXRD4dSh/8yujEZUFOhEXOyhFU4sZcYqkUwKNhA2UyzTOZzUn7UxBjss5x4itjMDiagyD77Fn+yN+y4HKu+VGFTvyKFsntSwnuVpQVX81bv1DUi5HZV9HUaMDKFFPhOz/9S6QxJiG0VEXu6h9Z5DBmowcZOevvtirBBLhIraZJ83oqrm/6WlbLnSFC56X/LMEKLEzTUTu/LwNKr7N6BTYKpVt++sJXYMuyh44NZonj4vKMqzOQQ8Nbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MW5PR12MB5597.namprd12.prod.outlook.com (2603:10b6:303:192::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.30; Wed, 6 Nov 2024 22:06:35 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%7]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 22:06:35 +0000
From: Zi Yan <ziy@nvidia.com>
To: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-mm@kvack.org, Ryan Roberts <ryan.roberts@arm.com>,
 Hugh Dickins <hughd@google.com>, David Hildenbrand <david@redhat.com>,
 Yang Shi <yang@os.amperecomputing.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Yu Zhao <yuzhao@google.com>,
 John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] mm/huge_memory: add two new (yet used) functions
 for folio_split()
Date: Wed, 06 Nov 2024 17:06:32 -0500
X-Mailer: MailMate (1.14r6065)
Message-ID: <C9096636-C91B-42C0-A236-F3B7D9876489@nvidia.com>
In-Reply-To: <e6ppwz5t4p4kvir6eqzoto4y5fmdjdxdyvxvtw43ncly4l4ogr@7ruqsay6i2h2>
References: <20241101150357.1752726-1-ziy@nvidia.com>
 <20241101150357.1752726-2-ziy@nvidia.com>
 <e6ppwz5t4p4kvir6eqzoto4y5fmdjdxdyvxvtw43ncly4l4ogr@7ruqsay6i2h2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BLAPR03CA0055.namprd03.prod.outlook.com
 (2603:10b6:208:32d::30) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MW5PR12MB5597:EE_
X-MS-Office365-Filtering-Correlation-Id: d028764f-29cb-40bc-d20e-08dcfeaf4788
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bm95VzVUcGNSM3BSZHhGK3VKSnFDMkZTR0RkSWp1UWtGOVBsVEpaYk9PTWpQ?=
 =?utf-8?B?WkVsTitQb0tZUXhFTkxNUG5TbEtaU0I3ZlJoUndmeFNkNFpLU3FiZ0ZHODRQ?=
 =?utf-8?B?NzRLNVBJU0ZtQm5JUWJHYktiaFBRRklMNkJmK2pxcWpVN1BSTXI0M0ZyWFZE?=
 =?utf-8?B?UGdpYUxxYkp0NjJuUFlWME9rN3lhS3hRVUV6WGhXbGkvZVdRSlRRQXAvTy96?=
 =?utf-8?B?VG1YYUhmZGViRm1SOTlUY0lWWFprMENXWTRFVDNSanpmYWtUNUlYT3lnTWpJ?=
 =?utf-8?B?OGUyY3lNSWprYTRDQ0NjZE1ROGRudFVtcTZwYTljeTBydmVKa0p2dnpvOVhT?=
 =?utf-8?B?WEVMcDFHYlVudXprNnI0bExENklCKzA5Sm9KWEtNNkE5MmZnSTVHdUdjWUt4?=
 =?utf-8?B?akhMRXlJWGZSVnl6RWdRR0hpbThnZmtXeW9EWEtBK1AvSzgzSVp2L0swUE96?=
 =?utf-8?B?YjBIUGRTQU5tdmFGUmo1Sm5EdXhNTS9HVlp6MkUvdysyZy80eXF0ZEpYZENE?=
 =?utf-8?B?UjBidHlhRXZ1OHBJSERDcHF2MjVUVDNUT0RMbzlnU0p1MnpWZ3BEcnFEY1BG?=
 =?utf-8?B?M0RZZE1YbFhYTGU0aW45ckUrY0QzdzQ1MXNqRmFTRlAyTUJaMGFTelhRRzV3?=
 =?utf-8?B?RzBQTE1tTzBKS2FNbWlrcVppNElXWWhhbFE3Y3pySUsrTnY2T1h5aEZ4QmJF?=
 =?utf-8?B?aFVJOFd6Q2RyTThoRjRzdTJ0NmVxanZ1aWs1MURSRUFvaHJhNS9NUVQzdWVC?=
 =?utf-8?B?WWU1U3lkbWY2Y0g4ZThOcENGZU1oZEk2ZVVRSWRoQ1ZPYkxZdThLcjJGbk1s?=
 =?utf-8?B?MVZXbWMrNytyT0NIRDJEQ1E1NUk5cDhJdmRLQXFiVHhveXF4UGhhMGpDWkkv?=
 =?utf-8?B?ZkgyNks5Q3E4cEhPUVpaZVhSR1dwd3hIVUdJTXZiZElQVHV5aTY1U1d0RXVy?=
 =?utf-8?B?a3cvT0xCcnV5a1ZSVEVXWENTOXNPbUM3YTZZbGNPUzlWK3ZEMWRRc0laV1J5?=
 =?utf-8?B?Zmx5Y2RPd3hEQXM0bWtQOCtTTDh2MENaajRySEtVNUExcmZYdXVSVWRhQmh5?=
 =?utf-8?B?a0J0aGxOOFRlNmV3N0U5ZGtqRzgzc000Q05aREJOcW9CUGtOMVNCdUZ1UWhK?=
 =?utf-8?B?MFdlL293d1FWcFNkcGRJSnlaSlRoeDdGbnBKdDNYaXBCYWp5OWtSaVRGZEx0?=
 =?utf-8?B?ZmtIQ1BHcEFBOXFGa0NqdXB3WUVwNytBZytMSWFDWGFCK2hvbUs3SkNPK3RW?=
 =?utf-8?B?VGdhM1F0U25QcCtVd212S2szWG9SL253cjhHTFdpeTRCcnNFZ0RmbU9YZmk2?=
 =?utf-8?B?YXQ0a1BDdGRLWldjQVdFc3lvc25ramt3eWxzTUxDelVWRTc5Z2xsLy9TZTBU?=
 =?utf-8?B?Vm00YnAyRkZOMG1pZkFIT1liQ0hUbjg4NHhQSDZwVUl1WEFRekNtZG5Qazdi?=
 =?utf-8?B?VjBoUWRxMWd1ckdIR2tsZUpwWlB3N2d1NkVLY1RIckNwMkVxU3dBZUxJU2NW?=
 =?utf-8?B?V1BOM3lPVjh5VXFXdlcxUUJBVzFnQlhIU092eDFRMkg3U0NzOXluZXdXUW9q?=
 =?utf-8?B?TkluSUdjS0xDNGRMS0NCT3pPYVM2OC9DOXgxcE5TbzFjRGRkbFYxeUt1dGFM?=
 =?utf-8?B?RmN5Wk5UWDRZUFNWNk94SmVJaGtHTGdCSURGNWJENEdnYkpaMjRPeGFYNHBx?=
 =?utf-8?B?L3lEaHoraEhqN2lWNUpERzRaaWZtbnJ0VTNoU2hDY2UrUTFDOXhsckRWUUZ4?=
 =?utf-8?Q?8hqMN44t7wa/xEG0PuzC2n77tXqqE0oP5phvmiZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkZFSVZGS0htSVhqSy9DeExxVUxhOUh6RzFmdmRoMlA0ZllTSW1zMGdKbmlK?=
 =?utf-8?B?bkpNZkN1bjl3ckQ3bTVhTEIvNUF3OXlzeWZUK2hWeEhlZDR2Uml4bU44M3M5?=
 =?utf-8?B?N1FYSFM1SWZNU0kzQ2lEUUlJRjVSRHBidG5CZmlaZzRTd2ZPdjlVWnVVVW0x?=
 =?utf-8?B?Q3VScDJlY1VXamFYSktwL21MaW1henlUSFpUQ3VpN1hiaVNlckFyZTdxUDFx?=
 =?utf-8?B?OXNmZ1l6eloyWVNyNVpUWTZqUkxVM0ViMzBhNnQ0cXFVYXgrZFNqS0NGYlRt?=
 =?utf-8?B?M2lIKzlGRWhnQkdIbGZYUnVCSlhobSs4UG1mUHdwQWdYTFZpeEtKVU1JMDVE?=
 =?utf-8?B?QzhVVFBWWnBRaEhjNnZzZUIwYTVIUG5HczhIWlhjamVLSllxbVBpakZMQnJR?=
 =?utf-8?B?VjlVdnVxZUcyK3EyRTVvM2RHN2JUYVpVb3pYS0tYcWJpYk40VnFqL1JrL2pV?=
 =?utf-8?B?eWdwamdhcnNzTkd4ZkpFcnR0bmgweEVjMnVEVSs0UkpocGRHcmJKc0dKaUw5?=
 =?utf-8?B?cm83V2tVRCt1T0g2eFpSQVV5bkkyVnBpbUY0WUp4OStRQ2lHTExvNUZkaldM?=
 =?utf-8?B?SjBPWTd3aHpIdjNOWmpNUVMwNG42MmgrbGp6SFRQYjVFVGJabUl2RDNNemN4?=
 =?utf-8?B?YUNhZ1RqeFpnVjIweHBKVVpQbk8rS0pNYTR4dlp6Q1NYS2JwaFM1a2tCVmpO?=
 =?utf-8?B?Q2pLOGpLRE9lK2xVanZ5V0N5bHFoZ3V0RFg1L2F6OTQ3OEdKLzdqbTdFdFly?=
 =?utf-8?B?T3pZYzVXVzU1VElHS3Bvanp3d0QySTVvM1R4WTRZMFFqQUJtaWR4cUIyMS9E?=
 =?utf-8?B?SzZCMTloamJQTkpRS2dFYnlpWGVLcENWZk9UUEN3dTVqN2tuU1M4MURGL3Rn?=
 =?utf-8?B?Kzd6ZW1zNlYrYjNSSm1EbFo5dldRaE1jaUlpQzI3UUFTRytsQitKWmFCRm1y?=
 =?utf-8?B?YXgrMkg1WE1ZSUtmclh4cVpsMU5hdE01aVVqN1hQaEU4NzdPdk5xK2ZNQ296?=
 =?utf-8?B?LzR2UXdvMlRWSGFtM3U0OWtYQkQrV245Y21XWFBnZ20yc255cmpueSsydjFj?=
 =?utf-8?B?U1RDZTVneFI1QkVqSElXRWNESloyS1N1UTBTd0lrNUllSmxjeE9MVzBVMnRU?=
 =?utf-8?B?alNWdkxkK0JLdFpBbmlvWCtxYWp0V2hRS3hIMGdZUktGRXV2K3ZjQ2l4YmEv?=
 =?utf-8?B?OXVIZ2VxeUc1dWlsbVhvTkRvZ3FYMEJCNnBBbnB3aFM3aGxpTjJxNCsweTE2?=
 =?utf-8?B?ZS84cTNOMjArRU0zYzA1Z0xaTE1nY0tLUGZ6aVFDWFFMR0h0L2Zxdm1zUVpy?=
 =?utf-8?B?cHk1a3lxT3dTMkYyRnNsTmxFQUdabG9wOVUvRHZYRUg5SVdsaDZoRGZjQnpx?=
 =?utf-8?B?Y0ZWV0ZUVWdRTGJBdGdLTmlUWWVZVVA4eUpqbFFpNm1mYVVhZzlYNzhRRDNt?=
 =?utf-8?B?dXhwU080anZjNmNWU2xUZTZwUWttNUJWRW1YYUlLVHZSWUVGVjlnTHcxTzZw?=
 =?utf-8?B?THZXeXlvZVN2dDREdW5QU2VPTkNmUThpQWdRbStSOHpyYkZrVm1ZZVZGL1lE?=
 =?utf-8?B?ZlJrWkpqRkpDZFFKWm5xNXYxa1VNYTIvZzRibDVLK0hNdzJja2E1RnRKdTdy?=
 =?utf-8?B?U3Z1S0ZsejBKaUtnQjBxR3pzdS9UMHdnd2RVVjVFVlZGNmVBa2ZlYW9YcXFt?=
 =?utf-8?B?S2Y0MURveFBhWkJIeDZ0Ym5tNXo3dGFnSzV6THR3UkdnZHhTSlkzdXg4YklM?=
 =?utf-8?B?QU5kVGkzRkcxd1F6RjNpS3hLRkgzRDZFdmRLNkJFOHhSQjloZ3J4UitiNjE0?=
 =?utf-8?B?YlZpNytCMlo4a2k3L1IwU1RyVThhZUlUYTdwbGwxSkY1bDVFdXNpNGFkVERE?=
 =?utf-8?B?U2JOakVlQjJGYWJJWllEU3B6OE85eE9KLzY3ZFZqQngyV2dMV2xmNTUxdDlE?=
 =?utf-8?B?RFZ6bEJ0ZEo2R0NxczFDcklZTWZjbTliN1daWHFFcGdFdSs0Y1ZoemlQOGND?=
 =?utf-8?B?emRJNG4wMXVFend5RCs4aVRVVis2dmFGUVFERXBFeERzYXdGejV4Mm9EdlQz?=
 =?utf-8?B?ejJMT2RzSHFkdlpXQUY4ZmMxKzRVc05QdUpMZE9jZmhaVTNKNGdWN3J4MWp4?=
 =?utf-8?Q?MeeSNQKteyzkiBySjaTo3mC3y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d028764f-29cb-40bc-d20e-08dcfeaf4788
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 22:06:35.4071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ODHiPF10ap4wbXoFbIEmUBFuYc6K5hQH1u7peMcsYeyCCDIcj6KKpf9USGg0zhvh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5597

On 6 Nov 2024, at 5:44, Kirill A . Shutemov wrote:

> On Fri, Nov 01, 2024 at 11:03:52AM -0400, Zi Yan wrote:
>> This is a preparation patch, both added functions are not used yet.
>>
>
> In subject: s/yet/not yet/

Ack.

>
>> The added __folio_split_without_mapping() is able to split a folio with
>> its mapping removed in two manners: 1) uniform split (the existing way),
>> and 2) buddy allocator like split.
>>
>> The added __split_folio_to_order() can split a folio into any lower orde=
r.
>> For uniform split, __folio_split_without_mapping() calls it once to spli=
t
>> the given folio to the new order. For buddy allocator split,
>> __folio_split_without_mapping() calls it (folio_order - new_order) times
>> and each time splits the folio containing the given page to one lower
>> order.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>  mm/huge_memory.c | 328 ++++++++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 327 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index f92068864469..f7649043ddb7 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -3135,7 +3135,6 @@ static void remap_page(struct folio *folio, unsign=
ed long nr, int flags)
>>  static void lru_add_page_tail(struct folio *folio, struct page *tail,
>>  		struct lruvec *lruvec, struct list_head *list)
>>  {
>> -	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
>>  	VM_BUG_ON_FOLIO(PageLRU(tail), folio);
>>  	lockdep_assert_held(&lruvec->lru_lock);
>>
>> @@ -3379,6 +3378,333 @@ bool can_split_folio(struct folio *folio, int ca=
ller_pins, int *pextra_pins)
>>  					caller_pins;
>>  }
>>
>> +static long page_in_folio_offset(struct page *page, struct folio *folio=
)
>> +{
>> +	long nr_pages =3D folio_nr_pages(folio);
>> +	unsigned long pages_pfn =3D page_to_pfn(page);
>> +	unsigned long folios_pfn =3D folio_pfn(folio);
>> +
>> +	if (pages_pfn >=3D folios_pfn && pages_pfn < (folios_pfn + nr_pages))
>> +		return pages_pfn - folios_pfn;
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +/*
>> + * It splits @folio into @new_order folios and copies the @folio metada=
ta to
>> + * all the resulting folios.
>> + */
>> +static int __split_folio_to_order(struct folio *folio, int new_order)
>> +{
>> +	int curr_order =3D folio_order(folio);
>> +	long nr_pages =3D folio_nr_pages(folio);
>> +	long new_nr_pages =3D 1 << new_order;
>> +	long index;
>> +
>> +	if (curr_order <=3D new_order)
>> +		return -EINVAL;
>> +
>> +	for (index =3D new_nr_pages; index < nr_pages; index +=3D new_nr_pages=
) {
>
> Hm. It is not clear why you skip the first new_nr_pages range. It worth a
> comment.

The first new_nr_pages range belongs to the original folio, so no copies
are needed. Will add this comment.

>
>> +		struct page *head =3D &folio->page;
>> +		struct page *second_head =3D head + index;
>
> I am not sure about 'second_head' name. Why it is better than page_tail?

new_head might be better, as it means the head of a new folio that we are
working on.  =E2=80=99second_head=E2=80=99 was legacy code since in my unpu=
blished version
I was always splitting the folio into half.

>
>> +
>> +		/*
>> +		 * Careful: new_folio is not a "real" folio before we cleared PageTai=
l.
>> +		 * Don't pass it around before clear_compound_head().
>> +		 */
>> +		struct folio *new_folio =3D (struct folio *)second_head;
>> +
>> +		VM_BUG_ON_PAGE(atomic_read(&second_head->_mapcount) !=3D -1, second_h=
ead);
>> +
>> +		/*
>> +		 * Clone page flags before unfreezing refcount.
>> +		 *
>> +		 * After successful get_page_unless_zero() might follow flags change,
>> +		 * for example lock_page() which set PG_waiters.
>> +		 *
>> +		 * Note that for mapped sub-pages of an anonymous THP,
>> +		 * PG_anon_exclusive has been cleared in unmap_folio() and is stored =
in
>> +		 * the migration entry instead from where remap_page() will restore i=
t.
>> +		 * We can still have PG_anon_exclusive set on effectively unmapped an=
d
>> +		 * unreferenced sub-pages of an anonymous THP: we can simply drop
>> +		 * PG_anon_exclusive (-> PG_mappedtodisk) for these here.
>> +		 */
>> +		second_head->flags &=3D ~PAGE_FLAGS_CHECK_AT_PREP;
>> +		second_head->flags |=3D (head->flags &
>> +				((1L << PG_referenced) |
>> +				 (1L << PG_swapbacked) |
>> +				 (1L << PG_swapcache) |
>> +				 (1L << PG_mlocked) |
>> +				 (1L << PG_uptodate) |
>> +				 (1L << PG_active) |
>> +				 (1L << PG_workingset) |
>> +				 (1L << PG_locked) |
>> +				 (1L << PG_unevictable) |
>> +#ifdef CONFIG_ARCH_USES_PG_ARCH_2
>> +				 (1L << PG_arch_2) |
>> +#endif
>> +#ifdef CONFIG_ARCH_USES_PG_ARCH_3
>> +				 (1L << PG_arch_3) |
>> +#endif
>> +				 (1L << PG_dirty) |
>> +				 LRU_GEN_MASK | LRU_REFS_MASK));
>> +
>> +		/* ->mapping in first and second tail page is replaced by other uses =
*/
>> +		VM_BUG_ON_PAGE(new_nr_pages > 2 && second_head->mapping !=3D TAIL_MAP=
PING,
>> +			       second_head);
>> +		second_head->mapping =3D head->mapping;
>> +		second_head->index =3D head->index + index;
>> +
>> +		/*
>> +		 * page->private should not be set in tail pages. Fix up and warn onc=
e
>> +		 * if private is unexpectedly set.
>> +		 */
>> +		if (unlikely(second_head->private)) {
>> +			VM_WARN_ON_ONCE_PAGE(true, second_head);
>> +			second_head->private =3D 0;
>> +		}
>
> New line.
Ack.

>
>> +		if (folio_test_swapcache(folio))
>> +			new_folio->swap.val =3D folio->swap.val + index;
>> +
>> +		/* Page flags must be visible before we make the page non-compound. *=
/
>> +		smp_wmb();
>> +
>> +		/*
>> +		 * Clear PageTail before unfreezing page refcount.
>> +		 *
>> +		 * After successful get_page_unless_zero() might follow put_page()
>> +		 * which needs correct compound_head().
>> +		 */
>> +		clear_compound_head(second_head);
>> +		if (new_order) {
>> +			prep_compound_page(second_head, new_order);
>> +			folio_set_large_rmappable(new_folio);
>> +
>> +			folio_set_order(folio, new_order);
>> +		} else {
>> +			if (PageHead(head))
>> +				ClearPageCompound(head);
>
> Huh? You only have to test for PageHead() because it is inside the loop.
> It has to be done after loop is done.

You are right, will remove this and add the code below after the loop.

if (!new_order && PageHead(&folio->page))
	ClearPageCompound(&folio->page);

>
>> +		}
>> +
>> +		if (folio_test_young(folio))
>> +			folio_set_young(new_folio);
>> +		if (folio_test_idle(folio))
>> +			folio_set_idle(new_folio);
>> +
>> +		folio_xchg_last_cpupid(new_folio, folio_last_cpupid(folio));
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +#define for_each_folio_until_end_safe(iter, iter2, start, end)	\
>> +	for (iter =3D start, iter2 =3D folio_next(start);		\
>> +	     iter !=3D end;					\
>> +	     iter =3D iter2, iter2 =3D folio_next(iter2))
>
> I am not sure if hiding it inside the macro helps reading the code.
>

OK, I will remove the macro, since it is only used in the function below.

>> +
>> +/*
>> + * It splits a @folio (without mapping) to lower order smaller folios i=
n two
>> + * ways.
>
> What do you mean by "without mapping". I initially thought that ->mapping
> is NULL, but it is obviously not true.
>
> Do you mean unmapped?

Yes. I will rename it to __split_unmapped_folio() and fix the comment too.

>
>> + * 1. uniform split: the given @folio into multiple @new_order small fo=
lios,
>> + *    where all small folios have the same order. This is done when
>> + *    uniform_split is true.
>> + * 2. buddy allocator like split: the given @folio is split into half a=
nd one
>> + *    of the half (containing the given page) is split into half until =
the
>> + *    given @page's order becomes @new_order. This is done when uniform=
_split is
>> + *    false.
>> + *
>> + * The high level flow for these two methods are:
>> + * 1. uniform split: a single __split_folio_to_order() is called to spl=
it the
>> + *    @folio into @new_order, then we traverse all the resulting folios=
 one by
>> + *    one in PFN ascending order and perform stats, unfreeze, adding to=
 list,
>> + *    and file mapping index operations.
>> + * 2. buddy allocator like split: in general, folio_order - @new_order =
calls to
>> + *    __split_folio_to_order() are called in the for loop to split the =
@folio
>> + *    to one lower order at a time. The resulting small folios are proc=
essed
>> + *    like what is done during the traversal in 1, except the one conta=
ining
>> + *    @page, which is split in next for loop.
>> + *
>> + * After splitting, the caller's folio reference will be transferred to=
 the
>> + * folio containing @page. The other folios may be freed if they are no=
t mapped.
>> + *
>> + * In terms of locking, after splitting,
>> + * 1. uniform split leaves @page (or the folio contains it) locked;
>> + * 2. buddy allocator like split leaves @folio locked.
>> + *
>> + * If @list is null, tail pages will be added to LRU list, otherwise, t=
o @list.
>> + *
>> + * For !uniform_split, when -ENOMEM is returned, the original folio mig=
ht be
>> + * split. The caller needs to check the input folio.
>> + */
>> +static int __folio_split_without_mapping(struct folio *folio, int new_o=
rder,
>> +		struct page *page, struct list_head *list, pgoff_t end,
>> +		struct xa_state *xas, struct address_space *mapping,
>> +		bool uniform_split)
>
> It is not clear what state xas has to be on call.

xas needs to point to folio->mapping->i_pages and locked. Will add this to
the comment above.

>
>> +{
>> +	struct lruvec *lruvec;
>> +	struct address_space *swap_cache =3D NULL;
>> +	struct folio *origin_folio =3D folio;
>> +	struct folio *next_folio =3D folio_next(folio);
>> +	struct folio *new_folio;
>> +	struct folio *next;
>> +	int order =3D folio_order(folio);
>> +	int split_order =3D order - 1;
>> +	int nr_dropped =3D 0;
>> +	int ret =3D 0;
>> +
>> +	if (folio_test_anon(folio) && folio_test_swapcache(folio)) {
>> +		if (!uniform_split)
>> +			return -EINVAL;
>
> Why this limitation?

I am not closely following the status of mTHP support in swap. If it
is supported, this can be removed. Right now, split_huge_page_to_list_to_or=
der()
only allows to split a swapcache folio to order 0[1].

[1] https://elixir.bootlin.com/linux/v6.12-rc6/source/mm/huge_memory.c#L339=
7

>
>> +		swap_cache =3D swap_address_space(folio->swap);
>> +		xa_lock(&swap_cache->i_pages);
>> +	}
>> +
>> +	if (folio_test_anon(folio))
>> +		mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
>> +
>> +	/* lock lru list/PageCompound, ref frozen by page_ref_freeze */
>> +	lruvec =3D folio_lruvec_lock(folio);
>> +
>> +	/*
>> +	 * split to new_order one order at a time. For uniform split,
>> +	 * intermediate orders are skipped
>> +	 */
>> +	for (split_order =3D order - 1; split_order >=3D new_order; split_orde=
r--) {
>> +		int old_order =3D folio_order(folio);
>> +		struct folio *release;
>> +		struct folio *end_folio =3D folio_next(folio);
>> +		int status;
>> +		bool stop_split =3D false;
>> +
>> +		if (folio_test_anon(folio) && split_order =3D=3D 1)
>
> Comment is missing.

Will add =E2=80=9Corder-1 anonymous folio is not supported=E2=80=9D.
>
>> +			continue;
>> +		if (uniform_split && split_order !=3D new_order)
>> +			continue;
>
> What the point in the loop for uniform_split?

Will just start the loop with new_order for uniform_split.

>
>> +
>> +		if (mapping) {
>> +			/*
>> +			 * uniform split has xas_split_alloc() called before
>> +			 * irq is disabled, since xas_nomem() might not be
>> +			 * able to allocate enough memory.
>> +			 */
>> +			if (uniform_split)
>> +				xas_split(xas, folio, old_order);
>> +			else {
>> +				xas_set_order(xas, folio->index, split_order);
>> +				xas_set_err(xas, -ENOMEM);
>> +				if (xas_nomem(xas, 0))
>
> 0 gfp?

This is inside lru_lock and allocation cannot sleep, so I am not sure
current_gfp_context(mapping_gfp_mask(mapping) &	GFP_RECLAIM_MASK); can
be used.

I need Matthew to help me out about this.


>
>> +					xas_split(xas, folio, old_order);
>> +				else {
>> +					stop_split =3D true;
>> +					ret =3D -ENOMEM;
>> +					goto after_split;
>> +				}
>> +			}
>> +		}
>> +
>> +		split_page_memcg(&folio->page, old_order, split_order);
>
> __split_huge_page() has a comment for split_page_memcg(). Do we want to
> keep it? Is it safe to call it under lruvec lock?

Will add the comment back.

split_page_memcg() assigns memcg_data to new folios and bump memcg ref coun=
ts,
so I assume it should be fine.

>
>> +		split_page_owner(&folio->page, old_order, split_order);
>> +		pgalloc_tag_split(folio, old_order, split_order);
>> +
>> +		status =3D __split_folio_to_order(folio, split_order);
>> +
>> +		if (status < 0)
>> +			return status;
>> +
>> +after_split:
>> +		/*
>> +		 * Iterate through after-split folios and perform related
>> +		 * operations. But in buddy allocator like split, the folio
>> +		 * containing the specified page is skipped until its order
>> +		 * is new_order, since the folio will be worked on in next
>> +		 * iteration.
>> +		 */
>> +		for_each_folio_until_end_safe(release, next, folio, end_folio) {
>> +			if (page_in_folio_offset(page, release) >=3D 0) {
>> +				folio =3D release;
>> +				if (split_order !=3D new_order && !stop_split)
>> +					continue;
>
> I don't understand this condition.

This is for buddy allocator like split. If split_order !=3D new_order,
we are going to further split =E2=80=9Cfolio=E2=80=9D, which contains the p=
rovided page,
so we do not update related stats nor put the folio back to list.
If stop_split is true, the folio failed to be split in the code above,
so we stop split and put it back to list and return.

OK, I think I need to add code to bail out the outer loop when stop_split
is true.

>
>> +			}
>> +			if (folio_test_anon(release))
>> +				mod_mthp_stat(folio_order(release),
>> +						MTHP_STAT_NR_ANON, 1);
>
> Add { } around the block.

Sure.

>
>> +
>> +			/*
>> +			 * Unfreeze refcount first. Additional reference from
>> +			 * page cache.
>> +			 */
>> +			folio_ref_unfreeze(release,
>> +				1 + ((!folio_test_anon(origin_folio) ||
>> +				     folio_test_swapcache(origin_folio)) ?
>> +					     folio_nr_pages(release) : 0));
>> +
>> +			if (release !=3D origin_folio)
>> +				lru_add_page_tail(origin_folio, &release->page,
>> +						lruvec, list);
>> +
>> +			/* Some pages can be beyond EOF: drop them from page cache */
>> +			if (release->index >=3D end) {
>> +				if (shmem_mapping(origin_folio->mapping))
>> +					nr_dropped++;
>> +				else if (folio_test_clear_dirty(release))
>> +					folio_account_cleaned(release,
>> +						inode_to_wb(origin_folio->mapping->host));
>> +				__filemap_remove_folio(release, NULL);
>> +				folio_put(release);
>> +			} else if (!folio_test_anon(release)) {
>> +				__xa_store(&origin_folio->mapping->i_pages,
>> +						release->index, &release->page, 0);
>> +			} else if (swap_cache) {
>> +				__xa_store(&swap_cache->i_pages,
>> +						swap_cache_index(release->swap),
>> +						&release->page, 0);
>> +			}
>> +		}
>> +		xas_destroy(xas);
>> +	}
>> +
>> +	unlock_page_lruvec(lruvec);
>> +
>> +	if (folio_test_anon(origin_folio)) {
>> +		if (folio_test_swapcache(origin_folio))
>> +			xa_unlock(&swap_cache->i_pages);
>> +	} else
>> +		xa_unlock(&mapping->i_pages);
>> +
>> +	/* Caller disabled irqs, so they are still disabled here */
>> +	local_irq_enable();
>> +
>> +	if (nr_dropped)
>> +		shmem_uncharge(mapping->host, nr_dropped);
>> +
>> +	remap_page(origin_folio, 1 << order,
>> +			folio_test_anon(origin_folio) ?
>> +				RMP_USE_SHARED_ZEROPAGE : 0);
>> +
>> +	/*
>> +	 * At this point, folio should contain the specified page, so that it
>> +	 * will be left to the caller to unlock it.
>> +	 */
>> +	for_each_folio_until_end_safe(new_folio, next, origin_folio, next_foli=
o) {
>> +		if (uniform_split && new_folio =3D=3D folio)
>> +			continue;
>> +		if (!uniform_split && new_folio =3D=3D origin_folio)
>> +			continue;
>> +
>> +		folio_unlock(new_folio);
>> +		/*
>> +		 * Subpages may be freed if there wasn't any mapping
>> +		 * like if add_to_swap() is running on a lru page that
>> +		 * had its mapping zapped. And freeing these pages
>> +		 * requires taking the lru_lock so we do the put_page
>> +		 * of the tail pages after the split is complete.
>> +		 */
>> +		free_page_and_swap_cache(&new_folio->page);
>> +	}
>> +	return ret;
>> +}
>> +
>>  /*
>>   * This function splits a large folio into smaller folios of order @new=
_order.
>>   * @page can point to any page of the large folio to split. The split o=
peration
>> --=20
>> 2.45.2

Thank you for the review. I will address all the concerns in the next versi=
on.

Best Regards,
Yan, Zi

