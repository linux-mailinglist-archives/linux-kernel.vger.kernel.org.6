Return-Path: <linux-kernel+bounces-522563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E851A3CBD6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 22:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C86E7A870F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E902216389;
	Wed, 19 Feb 2025 21:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HukxBvoq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7719A20F082
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 21:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740001973; cv=fail; b=Tu5wJPmHs8iW2TgpDy1wQAOZh9PNIK7x7rerfJMSILZnBfTznOn4wNvPgg9vBPo7a2muhkpzyBkgxsz+wZs6rxP49e0H2gA/xCSOXBn409Vk/LWcL44g7zlzE050DvH4fHbiG8Wmc+JKRCaHPUEq+1PyO/vaSjDBMV/mEeV88XI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740001973; c=relaxed/simple;
	bh=Cpu/3wXftd415x0qemD7Gg2AOf0WML5kXg0CGcg3Gho=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JMapjeh20TvZuQ7d0Iu9dsVhfD8R4MNdprOI5aC4uyIQXDwi0RJZVSJdmarfppr301dJmMhihJ2fxbVlPkX7KTWWzTcNJH8YRXeu/gcR7/Jqs/B0ndG+j8QqwFpknORaBasaM75miq/8QKzf6J2zH/SXUy7bucEfFKSqBbm3U8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HukxBvoq; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740001972; x=1771537972;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Cpu/3wXftd415x0qemD7Gg2AOf0WML5kXg0CGcg3Gho=;
  b=HukxBvoqY0WDQ5sIOyMltMnSz2sbj9QON8d2eJv0iFvFYHNUZw2D+892
   Z/syDSGxeq5ETd/qQNjUpjQWKI28FJh/uoDg04vEJaewKmZxNx+gcFiCU
   N44bQ4aRlWV6fYXiDpSfBlzzoen2o7RM/3oibiWBoexbanMUwEUYol5p8
   2GfUSbeAHRsQHl0c0Whowq8/7Ha07gUWu+tJBTRRjEw8NJzNB+kdE/R7Y
   4IArc/0AKbb3XcnCOar0M4GrrOq4sn6ubu41S5qP4lOhYXL5UbzKxtOl7
   4Fb8JvjLOpBl7IDp4/nc77alNjlEXy1VWgWQJj1ArQRvfgwJAHIwdjJjY
   w==;
X-CSE-ConnectionGUID: RQbeSopPQ+idezi/J6tZcA==
X-CSE-MsgGUID: +03I7kikTg6XOaQn1DgZeg==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="50973330"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="50973330"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 13:52:50 -0800
X-CSE-ConnectionGUID: EK93sS6JRQOoQwFlPKjxKw==
X-CSE-MsgGUID: KXpuhATuQeOTI2YicIUyxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="114819022"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 13:52:46 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Feb 2025 13:52:42 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 13:52:42 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 13:52:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qy4WtsCr7G87RioICD+quNVduzqXVP3yn4NJlPqqIU7yx6rLMI7Xnm/JHMQGp4PoPLaiDc6WY7w2cPck91o6bPt2WQgbAcISfQ0Prv7uzyIUOR7QquStsCAH2G8NeGD6izntsbnKFqE1RCDIHcHUuHNeRaN3dVvguFEY8c7C4liMoXPB85vuE/PMQMcODkI89A5WnuXzgPbiIj8vtbcu143xwb+RbV5X5Yurp6bMMH4OgSpsD3xdSAQoT4Z0bHjr6lso5hXX5q2Vmqr66DOkPJgzPfc8aRJlVKfxa+A8IiFh/pqhXPD1E2CoA5p7mCOGYMLXJ9l04RyAOzU+v+kAsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tIYdkaQU8bFues2csH7FrtzaXKebFitncTPW003VmRI=;
 b=OpnhzSR2GLL48yRMlA1N0y7W59tqvB75v7/JjDsaLXjYgwpEP7tGMxa8aPJZG0BeX9kGxa4sygs7kOpKk2uqMgPM6LbgYgur/6q+JPBTFCfgSGtynPwxc+bh0XbNbKknaFypPFTh02b6obNuUbI7CXWhT8kriY8WgwaC/T+lkfUuYBWhZMFYCtDNjlZoC02h1XhGfa3nOc0Y1li6HSqMd8ZOCL8pIUiQYzjdlA5mkHzsc5C+n9TsZuZfz3IkiB9tpUE5yunYmRqVsbgGMERXrs7srhTDGN58pr4q/NC6y+ZJv6Vg0WQ3uuJw01hRH/oGhomAsDpFK1T6W+JHqta37A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7566.namprd11.prod.outlook.com (2603:10b6:806:34d::7)
 by CYXPR11MB8754.namprd11.prod.outlook.com (2603:10b6:930:dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 21:52:10 +0000
Received: from SN7PR11MB7566.namprd11.prod.outlook.com
 ([fe80::2b7:f80e:ff6b:9a15]) by SN7PR11MB7566.namprd11.prod.outlook.com
 ([fe80::2b7:f80e:ff6b:9a15%6]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 21:52:10 +0000
Message-ID: <e47db1dc-72cc-434f-bd07-4f0a1ffc6d36@intel.com>
Date: Wed, 19 Feb 2025 13:52:07 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/42] x86/resctrl: Use schema type to determine how to
 parse schema values
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, <shameerali.kolothum.thodi@huawei.com>, "D Scott
 Phillips OS" <scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
	"Dave Martin" <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>, Shanker
 Donthineni <sdonthineni@nvidia.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>, "Tony Luck" <tony.luck@intel.com>
References: <20250207181823.6378-1-james.morse@arm.com>
 <20250207181823.6378-5-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20250207181823.6378-5-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0109.namprd03.prod.outlook.com
 (2603:10b6:303:b7::24) To SN7PR11MB7566.namprd11.prod.outlook.com
 (2603:10b6:806:34d::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7566:EE_|CYXPR11MB8754:EE_
X-MS-Office365-Filtering-Correlation-Id: 71ffb1fa-2c13-4826-13cf-08dd512fa976
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y1ZEWmVtNjFlZE9zUHlPL1lSaElma3h0K3VNSHhpZzI2NzRSVFR5MDlKTzNH?=
 =?utf-8?B?cmtPZHdhWWRjZStZQ3EwRUdjVFJiY1ppNTRlbS9US01OZXlRemVHc2p0WXhN?=
 =?utf-8?B?eXRRSlVKNFJWK2VraHMxNXJ3aytWbjZGRFB3U1RIdHhsWllEY0FiS3I4eWtm?=
 =?utf-8?B?MklJdXdHUS85aXZiNVMrVmhrQzNsL1RsYVc1K0lZbWhWY2lKVjdPSTJMeWxP?=
 =?utf-8?B?aVhmWVVUcDlWczJLK1g1Z0V2WFpOQ0VSRzE3bkpVaVhldVRYOC83WkRUSkdX?=
 =?utf-8?B?d2dRYmZCeGo0RDU2cjkyWjlYZHRGeVIzWDlrRnhPd25JSFFVOEdkLzdaUFN0?=
 =?utf-8?B?UHlOdzg4eUNQZ28xa1IzKzJoSnRaRW01c2hNNFMxQkt4S1FjVUtOVXVrUUEy?=
 =?utf-8?B?Q2dNWUtrYmdUUllyUkx1SDJDNE4zNXRIUWJtM0VlVXNVK2t5UkxKdGVINm9O?=
 =?utf-8?B?cXZVYTZ5TFlBdVJTR3lHeTdKU0djcys4ZW0xd2Y5dXkvdjlmdjVGS3VzM1Bl?=
 =?utf-8?B?VVhMODFGWmhjQllDcWNoZ094LzV1Vi9WTzhqalRTaGttT0c4L0RQRDd5bklO?=
 =?utf-8?B?bFlUYmFERVlsMTdmZzU1bVpESTU1RTJJZi9PbHhmWElRVGtlOHJndGRud0F6?=
 =?utf-8?B?T1RRQldyRldlczVmSDFpelBmcXE2VzBPT04weU9MYmdsOXpoZCs3WjJRa3Ey?=
 =?utf-8?B?Y04vbUlKU0NnRjFabWprTHBXVitBR3IzWXh2V3kwNTBWenIvZEE0Z2ZKQ2gv?=
 =?utf-8?B?OHRyblBHRklBc2xpaVRyREpTQ3UyeVFvYi9YR2I4ZmxnSDlZWGZqQkxXcEg5?=
 =?utf-8?B?R2RZRW5mMk14aTFUMVlEK21pdDlqektRTTdsd2lSbXl0TEorSThLZld5cjNk?=
 =?utf-8?B?aWNLYVhnZ2lRaDFPNU01eVpzQ0ZGdWhZcEpsM3craFRLUkttVnN2VHdQbUtj?=
 =?utf-8?B?NXVkd1UxdHlTSE9aWlNXSEFRdE0vTDhnTnBiUDJtaWJMbUc3UTMyQ081TnNs?=
 =?utf-8?B?R1E0dlVJV1A0bVNmMzNMdzdsRWdVcDFZSnYzYmdKMlc2VzhhN1AxYVFxSkc3?=
 =?utf-8?B?Qlc1RTMxekd4b1RmckdrdmhpSWZrT3FXNUtDR2hqbWszanFpZzRLNERScTRE?=
 =?utf-8?B?R2VpaWJKc3BoTlhjUkZCZ2YvUjFzWXJpUHZGSGFHblVVeUdyZ2hyYVV2d0I3?=
 =?utf-8?B?aUE0NE9qWXF6azZqNlowWXRuOEVSYjZ4ZTJKUE1mYWNpOXBSdWRVUHVyZ3ZS?=
 =?utf-8?B?T1pncGpGWWh5SEk4bnBKdmE5dmRORnFQU21KenpuVWhZWEtlRENOTkhlWmNC?=
 =?utf-8?B?dGZKZk5sN1BUZ2xDNUh4MVlBdXhFZ0EwYXVNNzNiVUtIWXBXWHBwR1V6Yy9L?=
 =?utf-8?B?dlQyNStpRDRjSSsyVkNuV2pSeW9qSFpyY3piYnpuT3lsRTNXN0xIRTJnQmlt?=
 =?utf-8?B?NkI3S1Y3dHp4RFd2NTFQbXdvb21SK1hGb3BCRDU5UjlRdXhvOWdlSFVDT0ky?=
 =?utf-8?B?YXZNWmo0RVRmQlBVREVBT1kzT3pHZ3JiRFRkb09rSUR5ckUyaEdBVlJ1bEY0?=
 =?utf-8?B?MjVlQTlFMlpIdDQvSHhwL09ZYVFBL2NRUktNZVBSTDVhc3J5eGFiUEgxN1FB?=
 =?utf-8?B?Nm9xYUtKYmlGc0pWSkdtTG9OQi95NlFQUWZaT21lWFZHT1hYeUhiamxwTm4r?=
 =?utf-8?B?WlJhTUZBSnBzNkJnbzdVUmhxTmZhOGUzNVhEb2wrNHhZWHh0QXl0YzM5cDFm?=
 =?utf-8?B?SnBTYjZqU1pOVzhETFRtUHhpL3RYLzg2SGpubWZ6KzNsZE1zU3JLL044NDRO?=
 =?utf-8?B?SDJVR3JoZWlGVXpvOUxGWHlULzFzR1gxb1NBWkg5bWs0YWsvN1h4MTBsYWVn?=
 =?utf-8?Q?jAq06HaMOqVcD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7566.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3h1V1dtM2dJYzliOTUwT3FkYk5xK0NlK25DYUthb01EUjQvazdsemorbUVD?=
 =?utf-8?B?WnNybnFDenhYMUcxcEFwZnJKWkg1QU5WNGpOYjk2ZktpRWZEakVpM3BMU3dU?=
 =?utf-8?B?UmY3VjdZT3dwdDU3YmFaU3Fzc3p4ZklIZWVZc296bUUvMkdHMUY5TkNQcEJR?=
 =?utf-8?B?SVg3YW1tMjhXMWlncS9JQXU5dTNvQ1NRdXFxMjRFTFNJaDFJM01JVVBZdndt?=
 =?utf-8?B?NGgwUEl0SHk0OWpHcEZPMisweEpRSzZHam9sWnBDa2MzUnVkc2tTTFR6ZzhP?=
 =?utf-8?B?TThEVTJIZGlIcUNnUEVCL1NrM1ROVERjTzc4OCtBK2QramtzZ3gySUNNRE9k?=
 =?utf-8?B?aW5EWFVKU3RzLzFoRTlCbC9EWVFUTjlwZ0NROWxidHlKeHFGa2NkeHFSKzhE?=
 =?utf-8?B?ODZ2eEVlTDBOWU85WVNoSEZBRnVlVGRqTEN1RVJBeUdhbFozWmhNZnBVZXBG?=
 =?utf-8?B?M25EeUlWZWFoV05WYzZVVVc3bGxjaW13N1pxRXp1b1BWdklXMnRxSDRBUUQx?=
 =?utf-8?B?RTNjS2I5RTRPUnpYbmFPT1FsSkxETVBnUzRrTnFRTS9lK1dJTDhSYXkxOGpW?=
 =?utf-8?B?SzNrOGIwRy9VbisvTjJvSGhTcGFRWFZYVUx0YUZmZVUxbUduNGQzSkJza1Ru?=
 =?utf-8?B?UWZRdmV0eW8xOENiUjhRRko2RHlMQ1pYVDU5azRySEM2YjFLaktMMklQTXBk?=
 =?utf-8?B?dytjMXJCelh3ZzhFQkxNVE51ZmsySEJDd0dtbFlkV0hnMVdwYThBWUpZNDZv?=
 =?utf-8?B?dFRRWk91ek5BOVdxTjQ5QW5TS0xUUVNTcTlIQlErTkJIT2pEajMwQ1Y3Wjdo?=
 =?utf-8?B?ckdnU25rSFNEOVRqNTBnc2ovZGpidUFqMEd4VHlSVFNHQTEwUGp4RlFpVjQ3?=
 =?utf-8?B?NW1ZTHpWbHRsaDNxNWFJeTJFcVNldU5UM1c0cEdLaCtrYjhrZVBoL04zMEM2?=
 =?utf-8?B?a0RjazFXbVpHdFR6cjY1OVBSbUMvcFVNQW1oY3pjM3VkbSs0cTFsZ2NKY2JJ?=
 =?utf-8?B?dW8xUFlUMUU2NjVEVXdYM013MnBDaFhtY2gyaFV6V3JNU2YwU0ZKdWd3UHBU?=
 =?utf-8?B?em00MU1jYmdISjBqNFFmOUY1MW9WK2VzTi83cTlmc0RQTWpYTEkxSVIvVW1K?=
 =?utf-8?B?QllRYzVLcjQwWEtXUy9JY0RFSC95aXBPbHdJYzRYMUl4QUZJK013Qmh2Qmdh?=
 =?utf-8?B?SEc1ek43dVJWdmdTYXVhTUNNTVNLS205dklHd3FydlpmTEREU0tKenFkZUNa?=
 =?utf-8?B?ZVFOT3hSbTNjYlNhSFhGS3VwOWdzUjhKanpCUVRpcHlPMzNRcWZZci9RcTlr?=
 =?utf-8?B?SFNOSlo0UVBEaXNxRFhUSnkyWE00QllPa2c3LytNVWZNWEM5K2pZamFpcnVB?=
 =?utf-8?B?VFBOR3B3WkRuWjVwQXpnanFuMGFoTkM1bmFWelJrdC9kUS96cEVpc1ZPamxL?=
 =?utf-8?B?ekY2MzZaZ2FwbFJUcWFYR1VSYVJ3WHhFMll1dSt4UzhiZmhndHFwT3JzaHBG?=
 =?utf-8?B?b24zanhRejZrUDJubjllczFLcjQ5T3dZeW1YSmhQZFZ0a0hVT0NxMEVheGdx?=
 =?utf-8?B?c0Z0eEZ6czlVSVh3WjJUWlFKaHdScHRlZGNnT05xVWNZU1BMUjFlTDVIeXda?=
 =?utf-8?B?VUpTanlvbEZvdVdqNk1tMUN0Y2RwSnIrK2xhenBHZEE4cTgvVmlaWURIVTBj?=
 =?utf-8?B?TmZtRWVraVd4UzVXZmhqcjkvWEpJbkRNaktURndtUTBXSFBDYTFadXd2Njhj?=
 =?utf-8?B?Yng3MjgzblBGbFJoYldFUU8rSnZpbEtaYzYwQzhneUtyaG1vci9Iak1ybmk1?=
 =?utf-8?B?akIvdkZKZXY2YkFUcXlaazhSbmhvcXp6d3o5bkRMNzBEdCt4SzhPdGxRWXQv?=
 =?utf-8?B?MFI4WWtuWWtlelR3OWpwaG1pWFpSS0N3SzNoUXZDNmlmWks0ZUovdFU2KzZl?=
 =?utf-8?B?am12dldyLzdoNWs0V3Uxa2dNY21QOUIxTXE2YU1qTFNLZThGL2VmN0FpYkFC?=
 =?utf-8?B?QW5CcnRrYStzdFk1emlHaldwYkRuOUtwU3dJdTI5S05HZWNsNWttN0cxYncr?=
 =?utf-8?B?b1pBYm5nZzVFcmh1Z3Z0SEg3ejA2MmtQcTVwVWUzRzZPWWpSbUlaQWZ3N0E3?=
 =?utf-8?B?dVlZaU9jYStsTVhtVUxEQUpJTmIyOGZiL292bXB5S0psNldNcDhQdFJ5TUZh?=
 =?utf-8?B?cWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ffb1fa-2c13-4826-13cf-08dd512fa976
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7566.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 21:52:10.5948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8SJSRci+R68yqJ4Vcc64CC34auaMJLS7Bja+JSzJoJHQiIFeYrBcJWmye6WyRZvbSn0YNakCwwwdPI3/5SrA1xXd/Q9cuNIf/Xa2XuNjsJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8754
X-OriginatorOrg: intel.com

Hi James,

On 2/7/25 10:17 AM, James Morse wrote:
> Resctrl's architecture code gets to specify a function pointer that is
> used when parsing schema entries. This is expected to be one of two
> helpers from the filesystem code.
> 
> Setting this function pointer allows the architecture code to change
> the ABI resctrl presents to user-space, and forces resctrl to expose
> these helpers.
> 
> Instead, add a schema format enum to choose which schema parser to
> use. This allows the helpers to be made static and the structs used
> for passing arguments moved out of shared headers.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---

...

> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 496ddcaa4ecf..aed231a6d30c 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -183,7 +183,6 @@ struct resctrl_membw {
>  	u32				*mb_map;
>  };
>  
> -struct rdt_parse_data;
>  struct resctrl_schema;
>  
>  enum resctrl_scope {
> @@ -192,6 +191,16 @@ enum resctrl_scope {
>  	RESCTRL_L3_NODE,
>  };
>  
> +/**
> + * enum resctrl_schema_fmt - The format user-space provides for a schema.
> + * @RESCTRL_SCHEMA_BITMAP:	The schema is a bitmap in hex.
> + * @RESCTRL_SCHEMA_RANGE:	The schema is a decimal number,

Nit: Please let sentence end with a period.

> + */
> +enum resctrl_schema_fmt {
> +	RESCTRL_SCHEMA_BITMAP,
> +	RESCTRL_SCHEMA_RANGE,
> +};
> +
>  /**
>   * struct rdt_resource - attributes of a resctrl resource
>   * @rid:		The index of the resource
> @@ -208,7 +217,7 @@ enum resctrl_scope {
>   * @data_width:		Character width of data when displaying
>   * @default_ctrl:	Specifies default cache cbm or memory B/W percent.
>   * @format_str:		Per resource format string to show domain value
> - * @parse_ctrlval:	Per resource function pointer to parse control values
> + * @schema_fmt:		Which format string and parser is used for this schema.
>   * @evt_list:		List of monitoring events
>   * @cdp_capable:	Is the CDP feature available on this resource
>   */
> @@ -227,9 +236,7 @@ struct rdt_resource {
>  	int			data_width;
>  	u32			default_ctrl;
>  	const char		*format_str;
> -	int			(*parse_ctrlval)(struct rdt_parse_data *data,
> -						 struct resctrl_schema *s,
> -						 struct rdt_ctrl_domain *d);
> +	enum resctrl_schema_fmt	schema_fmt;
>  	struct list_head	evt_list;
>  	bool			cdp_capable;
>  };

| Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

