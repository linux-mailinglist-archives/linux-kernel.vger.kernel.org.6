Return-Path: <linux-kernel+bounces-379612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B92C9AE115
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 049C4B21DE6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 09:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F431D9674;
	Thu, 24 Oct 2024 09:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QeS4yqWs"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B7E1D63E8
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 09:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729762537; cv=fail; b=N8Z9V3weCSduK2kz1EaP7SBYyeTILcM5drP8II29nyy1Y1ACw++B98RZX5aK7oG8nKzYLgKCAOge0JTgLGySPNDzCBViUr/rdP2XjXean3OHwUS1nBhHDFHntGXkiaAvCQPleKgfqQzOz98r/IU2ve7nGO8ktQrVX87jUeSoCB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729762537; c=relaxed/simple;
	bh=pVuwyjgEf7rpruxEdcvuPemMbV2+SHKGThVKaoI0NkI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PHpBsWmw+Pl9m+nKvsgYKcceHNV6UlTntJm/zSOCz+R5ZzF32UYZ1i6n28kLqJGB0xCSdsdTPWQCsVohzV6inM8Nr1EaYeegPEuM3ILuwts+y/uw08DIqcDJ41T1UP1k0A/D9Hh6aOJ1/l/qYNhr94tKFk1F56FvO6j9EmS83jw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QeS4yqWs; arc=fail smtp.client-ip=40.107.236.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t/yIUTq1Jv5XwgIJJ+fuJDKh6rUKzwNqjpHmcbgrceqfG6ZaTyqLf3O2SQvQo4028/nOPqwLFQ+HSy2nCbctdpDlbqYgOeNOD250y1T7LOpLkfCf7wvww8ZPDqwj+mkhFM4LtWDlSe19rWO1jYwfo0yPPFEadeHLlQh/2CqQSpGchxVeQXB2KY5l8ctJKOjJq9X1bSlbH0DWSYoJQE+ExxxH2782GjgKr0tjyBbNCamwKi9oR1Y5b7AG1BWdKCAYmXwD6KDL7+q4l3pFVCHhoLWBUR0LnIJa7SK5+2b7PD6c/UsMqg9dweUoz3+u8KvBzZkC1COb4gqb7TsBAWjlhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g++kMRI1XVG/3gG81Jjbv2DVsV13uttQxS7EaA5rP+M=;
 b=EAtbZetKvj3Okv+CZ/zGKUz8HUFg03iI8wKmS1hBUZ8n4RA+eJcsOiFvp1sQZBBE7i54bmgfeufs0GIZcqL5mwoTLwbo0wCNkYhtEvQt0/lZDk0FKJxeSjtu/jyoPIcqv6N2vZ3AKl3j05KE+QSBN1OhYVrbFrXzEYjx8aTM+Vr3Z78GU31/y882aZJCmFn5twBEMH9+wm7bi6oENyPf6fqmrGhE4591U4DQHwYJqFe2ZL7qH/CWafaIeim4122Od6c7YjfmxfCKYMFJxs583xMqa/OjJ+ap6mHYrxMKD+idh2SA8pLwrPs3kKr5drjQLVeySnOvFmweuLbP5N08jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g++kMRI1XVG/3gG81Jjbv2DVsV13uttQxS7EaA5rP+M=;
 b=QeS4yqWspHQmb2Hp7BZ3G7LtyR9e4WaLQqied3itXj+V6onMkmqN0sWrjM0qmIUgYPEscT3k4jhNsKOYP+ykvEhASeg4On7CWNCx2i5aCYT+/8fVQSW8MTGtyV8qqMZv8h3WKzAvlGOt9esAll+QBNsboH9VK1Bez49th8sIpqc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21)
 by PH0PR12MB7079.namprd12.prod.outlook.com (2603:10b6:510:21d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Thu, 24 Oct
 2024 09:35:29 +0000
Received: from BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::c170:6906:9ef3:ecef]) by BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::c170:6906:9ef3:ecef%7]) with mapi id 15.20.8069.027; Thu, 24 Oct 2024
 09:35:29 +0000
Message-ID: <e6003804-1f91-45db-8ae7-368fda354acd@amd.com>
Date: Thu, 24 Oct 2024 04:35:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] firmware_loader: Move module refcounts to allow
 unloading
Content-Language: en-US
To: Russ Weight <russ.weight@linux.dev>, Dionna Glaze <dionnaglaze@google.com>
Cc: linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
 Danilo Krummrich <dakr@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
References: <20241015201424.2914652-1-dionnaglaze@google.com>
 <20241023201654.pjz67e5cv7kbki5t@4VRSMR2-DT.corp.robot.car>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <20241023201654.pjz67e5cv7kbki5t@4VRSMR2-DT.corp.robot.car>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0015.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::20) To BL3PR12MB9049.namprd12.prod.outlook.com
 (2603:10b6:208:3b8::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB9049:EE_|PH0PR12MB7079:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c356628-001f-4880-58df-08dcf40f328b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a1NPME1yeXlDalNta3VvczFwVnQzTEh5U1R5VlRBUFBIbTlaQkpSbHBvQ1Ur?=
 =?utf-8?B?MGhjeU0zbGt5eUpwOVJ0M1djTjZpRVpsYno4UTBKMk51S1ZiYWNjUnZiQzVr?=
 =?utf-8?B?eEtSNE1Pb2tHa0V0M0Zpa3o2OWhEN1dxWG5XSkpNR21aK09VN2RzMXZtUWgr?=
 =?utf-8?B?Y1V1L2U1aVRFUjFSN0JOdjlNQ2V2N3Z2WVN6UjV2T0pXVzU4dWJNRjNsaWc0?=
 =?utf-8?B?R0Z2bGIzc2ppbHpvYjdYMkozVVA5RHpGSGk4Q29MVnJpT2MxcTVqeG5BWDBR?=
 =?utf-8?B?VTZCakRkVkRVWkVlbXZ3VWpVL05Wa294UzVyN2haUWpjd1Y1ZEs0Yi92cytJ?=
 =?utf-8?B?YU9taWdTNUxvZ1ZrNVBndmpiZTI3MnMwY0tnY3JpM2hlajZsNERRRjl4OWwy?=
 =?utf-8?B?NDNoQ0JjMGI3YmY3ekpLWGdkc1VKdHRuQlp2aHVrbnF1UlVaRkpja0Y3a2d6?=
 =?utf-8?B?TUJ6cnppU1NaZWtyd0pSaDhZNU1KUlhIZStkTWxjcWsxSlh1VkVDbFF2LzZW?=
 =?utf-8?B?aFNiZDhjWTYwaC9KcFZsdzE3bmh6WHBQZG9ub1h3VkRhR2VhQVFpNGdscDhh?=
 =?utf-8?B?MjNUSDYyZS9RR2puNE54Nnp0WGdnZHpLKzR5aGRha3V1WXFCNmhNUDNBRzlV?=
 =?utf-8?B?TTFZZlU3Q3RqcGRCZnZENjJiSWJtcTZNenJEanRJU1I5a1NSNGZ3aXB1eGUr?=
 =?utf-8?B?dUZGcXFQS3pqU3grQ011WW5zTDJFSTF0ZXhFclZONUIzZEhYelBSZldIblNS?=
 =?utf-8?B?aWd5WVFRaHkrOVZtM2g5ZTFPa0p4TjFIT3BkOUtHdlZ4VFFEcEh5Q1FjNmtT?=
 =?utf-8?B?UWZRSlhid0grVFFsWXVEZ0hJdy9VNUdndWlVcUk1NlZEK01nL2lwRkhtUGpR?=
 =?utf-8?B?ZDIzUzBXTG5RZmhPVktzZ3lYcENMV01uWFR0YnRIZmxENktnNStiQ29XQTls?=
 =?utf-8?B?eXhFTjUzTC9TbEo2eGZlMEhxZ05rUGN6bWdEYmJaL2pSdFdKOTFmcjkxZnJq?=
 =?utf-8?B?b2tsRXFNQVY5OXVFRHhJOWMzRTZXNW14WFlmbkpMR201TXIreHZ5cmR2M3pT?=
 =?utf-8?B?dlZ2RkxjNmZmWEJ6R3c3TFdPV3BvNEIvR2pQUDNsMTNVZnd3cmxQRDVjRWt3?=
 =?utf-8?B?OXF3L1pGb0dQb0dKbnlYMWtPZ1ZWc3hDNk9OK2ZrSktPWEljMnpha2xtRGZW?=
 =?utf-8?B?cWZ3SFlPa01VZWdrMW9LM0oyaG5BNU9pS1c1M0dEeFZMaFdhU1l1Yk9BODdl?=
 =?utf-8?B?c2VRcWNaNW9zQzg5a3FvS3BlVGRlazdFZ3I0L3FJMllWL25EcVgyZUNxNHhh?=
 =?utf-8?B?NTR5TEI4TjY3YjM2dUdlVS9EakxuR3JOelRVOThYeWU2R1RCTUxpRGNPMkhs?=
 =?utf-8?B?YU0wNGphTDJCbjlEdDcrbWloSXNzcmdQdDBmZWlxWDlXV0pQVEdPVXdSQktE?=
 =?utf-8?B?ZytWZlZiTUpiVXd1RXRNMDJvODBxUlVteXJJZ2VBOUVoSDlQT09JbVZOTFd6?=
 =?utf-8?B?NzBYSDZhY2JKK0k2UjJyemdxQVg5WS8zc1luTW9rUE9PU084b1RiQlgxbm1Y?=
 =?utf-8?B?RVdOZlprN0ZGd3dQOVpnYnp4OXVGc2draEZEV1BlRmNQVW1COVlaTmxBSmZx?=
 =?utf-8?B?Wit4b0dLcXFyMUZpSTI3a3k1aXpjdmdMMkQwRklqa2pXWGlaUW8xbGZmUnc3?=
 =?utf-8?B?VzlLVC9nSTM2NmZjREZBTFRRUHp4SU1jVXVmUkl1RmZtZU5BUVdYZnhEWHhJ?=
 =?utf-8?Q?rw/0bvp320YqkRjRGBp6bXVbxmeogcUGebelqpa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB9049.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekhnRmFmZUw1QUZWdWNGblBPeWNiNy81Mkx0a2REa0hPTFpsZ2V5RnNNQmVv?=
 =?utf-8?B?bGVmcUxrbTY5VllJaUh0Y0hwb2Z4aytaQTRSakcxcHJZRkRySGd1T0FnUCtY?=
 =?utf-8?B?TGFmRjlCUDNYSTJrb3pkblZMVER5L2FDbWdTemw3N29ySDhHUFNGZGxVbWFw?=
 =?utf-8?B?ekFKTEtSdjFYUFpuR0MyR1hkbGhUaWViUjhvcXBETEF3QVFvWkdRbE9RRENJ?=
 =?utf-8?B?VDcvOHJ1eUxHUk50blZlK2RVTXlDRnE5WkcyNmNjbGRQNHpGd3pwRTc3LzN2?=
 =?utf-8?B?VGhpR0I3VWtkMFM0R040M0tMK0F2dExLV3dJMUNhd1UxTmFBREpPbUV5Nk16?=
 =?utf-8?B?KzIvVC9FSVdmL01JdW9nUU03MS9XbzNaZjU4TWZZQTJtQUw1b0owdmhFRk4y?=
 =?utf-8?B?THZ2RjVEdXg4Wk1YUWtYOVpoUTd4ejZmclgvQjcwdE0vSm9yMW9JWjU5WlMz?=
 =?utf-8?B?aTVNZkZLZDFmWkp4MGRBUkh0MWtUaG1BdUxoQzlZLytpQXVZTHN0Q3N2RXZY?=
 =?utf-8?B?RWlTb3BueWFNS2lXbS9vVytYQWc5azFrQlpaNUhwSS8zcUFJVG10ak5VK1Bk?=
 =?utf-8?B?d2lFN0lueU9oc01TYkYwZ0NON1pqWkZieFlmMUVxYU5LTldNQXp4c1FSc2RN?=
 =?utf-8?B?S0UxL0JVd0ZHWXhsQkRZSzlrdVNWTkhremsvMWxmTUpLS2ljZkFaZ2M5QVNR?=
 =?utf-8?B?OUs1Q3JwTGdWN05iSWRXYlBWRzFONXhIVnlacnVXVkpNb0JOZldXY3JqTkFk?=
 =?utf-8?B?cmdQMnJrZ0RmQUROejZRYlhUSFU3M281T2kzSzdqcTZJYXZhVEo5SkQ0OENC?=
 =?utf-8?B?RkRLMWFMSnpETTkrM3FJcVVrMkRmYnZJWlpzRGsxWWU5UGJzZzhYemNqWFo0?=
 =?utf-8?B?RHlWdllhTVhQQ09iT0JNWWwrVTJHbjNKUWtMbGpPZ0N1eHptK1BES2t2WHkr?=
 =?utf-8?B?cSs3bHR4NlI3TVZuMG9zNEdSeXg3dDJTR2ZsS01Kc2t6Y0NKWnhzMGtINFlI?=
 =?utf-8?B?dmZmNEJtVXFaL0JhVjJBVUFJTys2UUZyNnhsbE4vT3BKTVh0NDlaTHBZcmlK?=
 =?utf-8?B?MUdONkNaOGwxYnU3MEJMenlna2VZRDNhM1A3Snk0K0IvMDJnOHFuVWtSaExy?=
 =?utf-8?B?U051M2VJMWg1dlBqbjJkM0NYNWl1c1U2S3N1ZUV1RWdqQWZJdWs2ZEdiK2pJ?=
 =?utf-8?B?c0RLcG1xY2Y5b0EyQjFJaDhPTDNZVWY3ZmQ3OStySU9KUXRVTlhsQzhiZ0lF?=
 =?utf-8?B?eWZ4LzE3Q082L0lwZXZjbUd3ZCswMmFqYnVoNEtPTnhrNEp5a2JwTG5jYllZ?=
 =?utf-8?B?Qk1NUEwxUGs1cXF0cTBpMEl2ZVBQejFNOXAvSXpKRFQ2NndUd2JldjVmWUZo?=
 =?utf-8?B?ejhyUy9Vajl6MjdYelZGdmFZTE03Wm5XcHpnSHd3UVRaUUI5WVV3OEdoVlBD?=
 =?utf-8?B?cXNsU1lqcnlrV25QNytqRFFySVBIWWJrMzExTUFFTERhVUtSa2JlcXQ4S3gx?=
 =?utf-8?B?M2ZNb24yQ2tUOFJmS2tEWlRaWjM0ajR0NXNrREVIdHJuNHV5R3l6S1RsK2dv?=
 =?utf-8?B?UkRqQVlwaHY5WU9JaUdkc2U3UVl2MTEwRVNnbjNVMjB6Vms4aGY1cVZCbGRD?=
 =?utf-8?B?VHRraEtWTzk3VmNuazVQM2tKdmRsYTdTZ2NsQ1NsMGswdEswVW0wZDB5bFNX?=
 =?utf-8?B?Ny9leUdIa3RZdWk1ck1Rb1o4Vys5ZnAwNmZNQTdZK0JRM291MDJnTk1rM25P?=
 =?utf-8?B?Y1JvMkx1c0ZtTkhFQVhDN2FKZmtNNmhqaFRXcTN0dmVhZiswaEJqR05ER0xB?=
 =?utf-8?B?VnZXSk9SSlQ0TW1sb0ZjWHdHdVlvc2F4ci9pMVdkUnpmVWVpeVVVNWFIMS9W?=
 =?utf-8?B?ZmxudW1GTS9FVEd1WkFPY0dyaVhEMFJJVDZObnhMZ3UyUmhKN2dHbjE5QjRz?=
 =?utf-8?B?SEUxOWNpR0ZRYldxVXBERE4rN0t1UW4rNGs2WGtHdHdIZUY1RTdyWldVRkZ5?=
 =?utf-8?B?ZkVBOHZBcEs3bHFiZkhwZ3FoTEZGalVNM2FzelBucWM2cll5ck00aDhxcWlB?=
 =?utf-8?B?aWdNZ0phQjFtNVRTa0RjUjZyQTlWUWtZL2FVKy9MczlmOGdydXh2MHJPcVQr?=
 =?utf-8?Q?XyvR/DWohKkN/WE9/PX5Egezf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c356628-001f-4880-58df-08dcf40f328b
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB9049.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 09:35:29.2186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k25sF/dSznonGJ6RC9m8fTQbjWLT1CEDxD0JVfh8RqYvL1f/UEFGxlyEEFwXJWU3dWZE4KmNQR4jAnTJFLrr/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7079



On 10/23/2024 3:16 PM, Russ Weight wrote:
> 
> On Tue, Oct 15, 2024 at 08:14:24PM +0000, Dionna Glaze wrote:
>> If a kernel module registers a firmware upload API ops set, then it's
>> unable to be moved due to effectively a cyclic reference that the module
>> depends on the upload which depends on the module.
>>
>> Instead, only require the try_module_get when an upload is requested to
>> disallow unloading a module only while the upload is in progress.
> 
> Generally, the parent driver that registers for firmware_upload would
> want the module to be present until it unregisters.
> 
> Is there a case where this change is needed?

We are using the firmware_upload_register() API interface for SEV firmware loader/update
with the AMD Crypto CCP driver.

Now, when we call firmware_upload_register() it does a module_get() and bumps the module refcnt and 
then we do the firmware_upload_unregister() as part of the CCP module's exit() callback, but the
CCP module's exit() callback is never invoked as it's refcnt is non-zero, so it is like a catch 22
situation, we want the module's exit() callback to be invoked to call firmware_upload_unregister()
to do a module_put() and decrement module's refcnt, but the callback is never invoked as it's
refcnt is non-zero.

Isn't the firmware_upload_register() API interface intended to be used by standalone drivers ?

Thanks, 
Ashish


