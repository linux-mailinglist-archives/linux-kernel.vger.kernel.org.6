Return-Path: <linux-kernel+bounces-445224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC4B9F12FF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FBC616AB5B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA751E32A2;
	Fri, 13 Dec 2024 16:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fB53aj6D"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1471C15573A;
	Fri, 13 Dec 2024 16:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734108897; cv=fail; b=fk/08+IpF80mXMFupnbGXm3Y9hF9qi6jthfVxT3uVdJBFjCbm6uA8BwQTtFSjNJWHA+pq+i4mh/HHhG2P3yTSwLuxCzB/X/gk1QGyo6HvNjJYOuizFRlCLfTRHBRvkgTYhx+SG1PzVAkQRrqPuy2jMBKla3/lKL4lpC1kFW9u5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734108897; c=relaxed/simple;
	bh=az71uCb2yQ8X2kq2iUoBv79ExFpbGdSHxf+3269uy0s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NC5/TYqaVlPQCpehZTe9ArjMrncYAQl1GdKO2maVqEYtJyocbQ4TfUfTc+ACk10OAdH0W4X9a0gfrbur6HW3wPbAD4HWoSdy8B4hPd7m8fX9ZewuVvV7hM93UeN++2H1pqXI+AJgKZRoekbWxLySRADQFTczlf9M98os68jXA+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fB53aj6D; arc=fail smtp.client-ip=40.107.93.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LNQIRKa5LWfF0+HGcIUDCM5A8ip2O9SlREEmBrOEfiKjn5Yv+ZNclsEE0L6jssyh6ybmmSSREkpa2iDPkXwWi43KQSjIz4Os5wc0nIXV6MzDmvNsscfdJP1zVAqL+TB+cS7l5lrHHREsDOgb+6asd84k+gvKjpLOoWtuFrhJdfGsBsC3g8JBbGS/oV7R/tIEK5I/5FbhL41Ywq5o9TQud3Bnf8VbrcBR26u2wt/sQGT9nWn0OT7GmpFHfpOtatvMSXB+K+i3olrt3ZiMUnwQKEYZ9Xe7XWagBK3i0jsskA14WSFbCwHCwrXk7U3JfHAiWFyAtz8oeR/SbsTn2B+sfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2IvcrtdPuodWDwu/yAD3lBt9PVSBbghIHUhGm9Hg8E=;
 b=ur1sXDWjYT5w2s7Hg9nQEBGZsGagn/fJhThKFo3lwxBOEDXMAUVzMwEF0nH48kj024Ph6OZsc3lFAZrXFk992aMrAyo4sQ+/LPggJX0yW9yC/5IdTDIOD56X88TNb3pHg5SLgZ2BmUsRx7LP7dAaPpq2MH15jokGqHpoRutM9kq/Vi/gBJMQ4KvH6rQhj1LyOuxrPKGY/eeBVuo5eWK4a80oAY/cHY5S7gTSmwh4GFyBidOE/GK2sI1PUAe0j2lqFOhaoKG0DryP0LYUrergaKdtYznPUT4TVmX7JJC3VMnGVNcelHg1/w82qjB9XUQxkGeueA/KZGtOljmLgHRU1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2IvcrtdPuodWDwu/yAD3lBt9PVSBbghIHUhGm9Hg8E=;
 b=fB53aj6Dpq6mf+6W+iQ8U4ghsZ3YkyZaCAoCkQ+N/X732uQ7oPNxw2LsYgo1kgj2U5I7uU3pIl4nECAI8G5ZkJEQmj1ecfPtAYY5l4WAdb1+qYEhQuMKqJy4hGSwCp9EQdUP136IDn+3gakPKSTNr6cMd11BzDsS/AGZYJZhMwE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by LV8PR12MB9419.namprd12.prod.outlook.com (2603:10b6:408:206::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 16:54:53 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 16:54:53 +0000
Message-ID: <8cffb2ad-6645-45a4-8d05-c967c82eb111@amd.com>
Date: Fri, 13 Dec 2024 10:54:46 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: RE: [PATCH v10 16/24] x86/resctrl: Add interface to the assign
 counter
To: "Luck, Tony" <tony.luck@intel.com>, Babu Moger <babu.moger@amd.com>
Cc: "corbet@lwn.net" <corbet@lwn.net>,
 "Chatre, Reinette" <reinette.chatre@intel.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "peternewman@google.com" <peternewman@google.com>,
 "Yu, Fenghua" <fenghua.yu@intel.com>, "x86@kernel.org" <x86@kernel.org>,
 "hpa@zytor.com" <hpa@zytor.com>, "paulmck@kernel.org" <paulmck@kernel.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "thuth@redhat.com" <thuth@redhat.com>,
 "rostedt@goodmis.org" <rostedt@goodmis.org>,
 "xiongwei.song@windriver.com" <xiongwei.song@windriver.com>,
 "pawan.kumar.gupta@linux.intel.com" <pawan.kumar.gupta@linux.intel.com>,
 "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
 "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
 "perry.yuan@amd.com" <perry.yuan@amd.com>, "Huang, Kai"
 <kai.huang@intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
 "seanjc@google.com" <seanjc@google.com>, "Li, Xin3" <xin3.li@intel.com>,
 "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
 "ebiggers@google.com" <ebiggers@google.com>,
 "mario.limonciello@amd.com" <mario.limonciello@amd.com>,
 "james.morse@arm.com" <james.morse@arm.com>,
 "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>,
 "Eranian, Stephane" <eranian@google.com>
References: <cover.1734034524.git.babu.moger@amd.com>
 <a72e23d8fe43038cd319403ed68b657fb36e23df.1734034524.git.babu.moger@amd.com>
 <Z1tzyrUYTFR_iHuJ@agluck-desk3>
 <e43b10b7-60b0-412a-b55f-96271764faa1@amd.com>
 <SJ1PR11MB60831C44DEE7711F93C3C26CFC382@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <SJ1PR11MB60831C44DEE7711F93C3C26CFC382@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0002.namprd11.prod.outlook.com
 (2603:10b6:806:6e::7) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|LV8PR12MB9419:EE_
X-MS-Office365-Filtering-Correlation-Id: cae179d8-c5ab-4ed6-c391-08dd1b96dd82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dnIycDduNjZVNnRvMGRtbllMVnFXNnlnakxwV2FCanVTNmc3dFFma2hpUGRo?=
 =?utf-8?B?aGJFY0k5OE1LNHppTXdiOEJtVlZlbHNjT2g2S2hNN3U0MjN5UlN2cUJkUHc1?=
 =?utf-8?B?YjYrNDBTSGk2TXNkbGQ2SE9WMFlqZlY2R2tZOWhxOUJhN2IyZ3NFdHFjR2pH?=
 =?utf-8?B?THk0UHBIU2E5MUdOUFlBSjViUGg5aGFuQW9EeWtodlM2R0ZLbmVmbnFIMFNS?=
 =?utf-8?B?WXRXc3ZMMjlzc3FkRmZiclo4b282U2t2UnFRUHhLdUZjNVFkN1hpdEtodWhG?=
 =?utf-8?B?bDVjWnRteFExUngybTJPLzB4Q1JwdXhJUGgvVXNENzhlR3RVSGxGMEpkNkdN?=
 =?utf-8?B?elc5c05wbGtiOHNyeWlySVhNcFdnZzZmZVducW1ydEVJOThWanROcmVMbnpr?=
 =?utf-8?B?bFFtVlFJbktBTFk4a0V3Q1RDUDdsRXJIcldNLy9SNnlRTi9zT2RXaHZubDhJ?=
 =?utf-8?B?M1JoazNnZFF1aS9xTzJjdThiUXNPbnhDWVNsQUZPdTVTL3Jtdk5xNlVPaWtX?=
 =?utf-8?B?MC9DSDJUckI1OHd4ajhNcFRMMGdWbU1qREhMWlJWVW5QSmpxZEVveWdMQjJr?=
 =?utf-8?B?NGZSZ2tvM25hazc5S3FYSFliZ3gyWld5eG5YZ0FBSEdPdmdPL1dDSTFLdk41?=
 =?utf-8?B?YkZCb1pZUmhEckxoVEJvZ3BUTStGbnFTekthVU4ydFFKSlZldjI5T0k1ZUZj?=
 =?utf-8?B?VER0cUdHTmxYaU5nRXQ5S1FkN1V4SkUyWk10T1BYaC96TmdZcmo0V3dKL1I4?=
 =?utf-8?B?bEczYjFhWVU1Y0lnbkkweTFTczI5ZnkwM3N4dWQ0MEpaLyt3enY5MGNTY3p3?=
 =?utf-8?B?dmhZRHpkWk5sRjlzUDE0UXNsQUJVaEY1TkkwZ05vaU9VVTFreHFOMCs0NVo3?=
 =?utf-8?B?dWtUd3dlRDBUUStiK0k3ZU81ajVFU2ZLMHdRcjJmd0NhaFNNd2p3azY3bS8v?=
 =?utf-8?B?M2hCZ25RNGw4Skc4WDQ1a1cyazdnZFcvMlRHb2lmKzZMbzc2ZGZjendoRTAx?=
 =?utf-8?B?Vm5xVWF4MExuS2NGTjVodXpXMEdhaURkNjJrOFUrdXk4RmhsT1NxWTg3S0Y2?=
 =?utf-8?B?bE91RGU2K2ZaL3FQY3UyWUthOU9QRmJsQ0FiUWNhUGE4NFFYZnBpZmRTazBu?=
 =?utf-8?B?cnFkZWFjMTZsMG9FTDU0Qkx5L1VBdzlCWUxqb0JHZHZybkFxR0VFTXVEQmkz?=
 =?utf-8?B?UEJ4NHlUcUNHbkN4My9vS21idHVjVGZ1M0lHdWZ5ekFZR3VydWxFdWpyWHF2?=
 =?utf-8?B?TjlROGVtVzJRZ0JtdmliMTErUGIvNis3eHp2WXNyaDNOVS9WMHhCMDdEVEJq?=
 =?utf-8?B?QWxReURwdXRzVmZ3UkJBaGtlelNndGxxTktZdVQyR0M3cEw4bDlMaGJFVWx5?=
 =?utf-8?B?b0NrYnQyYXBNTlFtdW9RV09wbnpXSmttNVJhVGk5LzFyK2J0cGhNSkRrU2p5?=
 =?utf-8?B?S1dab2VRREFTZ003VFFVaWoxMlNCN3FXMy9wVktnb1RxVVZzT0ZzbWR3Njh4?=
 =?utf-8?B?OGlUM2RRVThjY3VRSGJkN2NMWTQ0OFhOVGxqMTBNd3U4VzBqR3B1R1J1R1lC?=
 =?utf-8?B?cnRvWEZ4VUl6cDMyZm1iUG9QWXJ5N2FQeXNPc2s4TEY2cnZvbEk5ekV5QjQz?=
 =?utf-8?B?Tm1zRStDbVJ6dHFacmpUeGhaM0NuMkVLRGNiTDRCdGUvZ3R3WU9EaW91VFZG?=
 =?utf-8?B?MElTWjVJWEhKNFJLSVBnUUZ3VG82djV0U1ZmUmVLdm5XQ3JhZW1UQk1sbTVQ?=
 =?utf-8?B?eHFmaDVMQmVXdDdzM3FNSkNlQVJXTnlrdVpueENVajBYSFV4RXFkc2tUMmhZ?=
 =?utf-8?B?TU1rOWFFeHIzZzhKOE1oUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGdRaXF0WlVDckkwS1c0SGR4VWlYT0NyR0E2QjlFSXBGTVRtV1RWZEhHSFVt?=
 =?utf-8?B?YnBEeDhVZ01DR0pvOFg1ektTSDdGbDBPcFpQYUJSajVRTEpqSlVuZ3JQUVBE?=
 =?utf-8?B?RlJWSjlOMDBwSWFZbWJ5ZWs2OGZ1OGNoMGlBd2Vibk44SDFMN3hHaG1nZ0lH?=
 =?utf-8?B?bjRIRXpFek95UkkzeS9tQnJIVG02cmhoa0lkblVTRm9VSU5MTTFWUXlKK0Na?=
 =?utf-8?B?RVdTd0NQZmczbXdvQS9EL2w2SWZNdGRMVG8xVVFxYk0ra3A1L0RMRkpDeWRh?=
 =?utf-8?B?L0I3UnF3MnBTcGd4a1Fvdm90cFA0Q2d3Qnd2bFMzY2J2aFJwU0FpNHhqWWp1?=
 =?utf-8?B?R1RFS2xNdWppUmdNMzlSM01LbkNrVnVUTnRSZDBwSCtVUGo1M29XMW1yTWky?=
 =?utf-8?B?SlJGUTFFTXZXMDlFN2lISDFEOVlkTjJTT2dlK09BTXY1YkVhSGFLNFhNRXNI?=
 =?utf-8?B?b0swNGRBOVJxcys0bmdQY0N6VmJ1Yzljb0NjbnRrUDlOQVc1K2poOVJyTUpN?=
 =?utf-8?B?TWtzUkhISUtaKzlsZDVXNUtqV2ovaFdwWDh1Q1VhSzFsQWkzMjBoWnJRNmEz?=
 =?utf-8?B?NjVQM3ZrOHh5THVDZEx3TndZd0lwT1lkOGZIbXU3bDZ0azJtZzBIMW5JWC92?=
 =?utf-8?B?dUdmSlZSZXdVYlI0MVpxNjB6RE9KUjRuQ1hvS28xTU5Ndjh1NnljTkVmemRM?=
 =?utf-8?B?d2QxZm1FeXo3Zkw5YXBSNTJqS3R6S3o0M0w4bkxyYVcwSkt4MHpxZ2taMjcy?=
 =?utf-8?B?TTFJNzBiV0JKYVBvWmNHMysxWi9pOTV0bkhqLzVxTzBGSTRTM1VHTlVHTmpH?=
 =?utf-8?B?UXIxbVg5MDJtdlA5WEJQVm1id1NxWGZlakM1bVBUV3BaSFFqR0R4ZGZVS2Ix?=
 =?utf-8?B?ZFN1MXVKeDBSKzczT2pCK1VaRENveFBvbTNLN20xSkdYaWM1aXVTY3dzYkFS?=
 =?utf-8?B?TmQ4aWd5Y3N6OGwrR2J0dDBrVVNrcUc3MUIyTUhvZ2pINytpMCtSM0VoUE9B?=
 =?utf-8?B?elI4cjBzM1M1cWRiTm8wd1JVbGU4N1ZzdnZZbFQ5WW8vMHBsUXYvRXNVaG1j?=
 =?utf-8?B?dWlpYktzTUpsMnVncHdKN1cvV3lLUHRzM1VRZGR5dVM2QzZWL3JLeEcwTFVF?=
 =?utf-8?B?MWttZmVZT3JYN2wzclJMWGhuNG1WQlM2NmhlZ0Z1WEdTUENrZXZ3dWpDb0RE?=
 =?utf-8?B?QlBrQlFaR3hDaEpybHIyUzNQL2tlMCtGZlpzNkg0akg1V3Bzb2owMVRTUEl1?=
 =?utf-8?B?NFFjNVJRQXJNa3ZxUmk4Zm5ET0NBQXQ0VG5hNlliQ1Vib29hYllmeFgzSDhR?=
 =?utf-8?B?TUxnazZOcEdoNzJqR0h1SWtlb0JWdlRnSFd3cE5tRmlqVU9XZFZncnR5VVdE?=
 =?utf-8?B?VXBqWjJ1dktROEFXY3ppNlMxKzFzbFYyQy9maE1WTTA4RTlodnJwaTBZQVZr?=
 =?utf-8?B?K2ZXcjdOa1RoSytLb292TmZZSVpoTHZ0WWZXQjdwcU81UU1zMkI3b3FCRFl3?=
 =?utf-8?B?NnQzS1lXZHRXVndUb2VaTXppdHN6Y3N1TE1oc2VHMkVqYVdLKzU3SlVWTEth?=
 =?utf-8?B?aFFFTkR6U093Mm5IeDg1Tmc2VjM2T3lqOEhPMFBua2k5UFJhb2VXRjdYaDNj?=
 =?utf-8?B?K2k0a1A5TXBWWTVabVhid2ExeCtRM1g3ZnNVNFh2WXd4SVZpNTFmRHRwc2lI?=
 =?utf-8?B?M0FCcTdZSU9GN0FPNDBEM2FrT0piTlhQT05wUGVVNmRZcEt4MWtRbEpqNUtk?=
 =?utf-8?B?UWY2ZE9hdFd1Z0JOcEdnNjdZU1lpZkFGU1pqR3hFSHYwbVRZamVuRlZWUzJx?=
 =?utf-8?B?WmJqak1uQ1kwWDYzemQ3YnhobW9BNjdYdE83QzAwQjkzMzVEUzU0eC9ESXNi?=
 =?utf-8?B?ZnJmSHhzbkh6YnVuUXA0cDliM2xlbXhSOW5Bekp0QWRWcks1TFU5UE9EWGd1?=
 =?utf-8?B?Rm5MYldpZ3lrOEdnZzhMUjY5bmxlSHVXUk5tdlcwMGZmQXdiYzBRY0ROalNI?=
 =?utf-8?B?QW1RUmZSS0t5Q0RpNU1CK2NFdUhRUkxnN1JxTW9DMFp5ZkdxQjNRekNleXgw?=
 =?utf-8?B?cmo4Q093dXovL0ZDSGZYQzg2eUdGWml3Q1pSWHpvbmdwMnR2c1doK2s0VE9O?=
 =?utf-8?Q?TNgs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cae179d8-c5ab-4ed6-c391-08dd1b96dd82
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 16:54:53.3390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fWKUFJmyIUyPXqvNHcqPO08az/CObiGsHBEEBPEFI+fh2E+V79PTsBVMIwym2/mJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9419

Hi Tony,

On 12/13/2024 10:24 AM, Luck, Tony wrote:
>> It is right thing to continue assignment if one of the domain is out of
>> counters. In that case how about we save the error(say error_domain) and
>> continue. And finally return success if both ret and error_domain are zeros.
>>
>>     return ret ?  ret : error_domain:
> 
> If there are many domains, then you might have 3 succeed and 5 fail.
> 
> I think the best you can do is return success if everything succeeded
> and an error if any failed.

Yes. The above check should take care of this case.

> 
> You have the same issue if someone tries to update multiple things
> with a single write to mbm_assign_control:
> 
> # cat > mbm_assign_control << EOF
> c1/m78/0=t;1=l;
> c1/m79/0=t;1=l
> c1/m80/0=t;1=l;
> c1/m81/0=t;1=l;
> EOF
> 
> Those get processed in order, some may succeed, but once a domain
> is out of counters the rest for that domain will fail.

Yes. I see the similar type of processing for schemata.
It is processed sequentially. If one fails, it returns immediately.

ret = rdtgroup_parse_resource(resname, tok, rdtgrp);
if (ret)
       goto out;

I feel it is ok to keep same level of processing.

> 
> Updates to schemata are handled in multiple passes to either have
> all succeed or all fail. But the only problems that can occur are user
> syntax/range issues. So it's a lot simpler.
> 
> For writes to mbm_assign_control I think it's okay to document that
> some requests may have been applied even though the whole request
> reports failure. The user can always read the file to check status.

Yes. We can document this.
> 
> -Tony


