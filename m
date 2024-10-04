Return-Path: <linux-kernel+bounces-351335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1857B990FD6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 22:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8389283B38
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C23D1DE3CD;
	Fri,  4 Oct 2024 19:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kCbr3YkM"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2F31CACFB;
	Fri,  4 Oct 2024 19:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728070614; cv=fail; b=dQn6ZMEO8jc6Tv9p+QMiDAadbNCIVSOaFPXnbJsr8rHY3kdqMG4CKW/J3BIWR/gSVv/1tOll4AsCEXYexeZj91BIRhqeNhrMlJeahsA58fIKG1U8+u+36+J8MX/tOliQbFuuv40OeOu9n277MEvOR7vEI9xHwOBfHz5mgDF9Th8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728070614; c=relaxed/simple;
	bh=jSU/B91s88sRPn4tt2MVHeXlhaKJzghkpjw77GrnD64=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nYt8xH7QFdJkxtIZMJGEQZ4/9f1ib2Ymx+Eu3/MhoG0zNmyU4Q5Ye9d/qkIDZySbrH3QL8ftOH+Ir5wau/mbtszYStsYI0ASZ8/C0H+Q3RiXvr8TVGILrcjRhe6H+twmcncwVx8lMAIEqe27k9Lrsm9lNeXlf7ryOrWC5Ano53M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kCbr3YkM; arc=fail smtp.client-ip=40.107.94.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ovhtshJmyaapnl+CrvTdyxME8vpJu27ZNBLO3vkLxtHHm/DCq90Lja0vEGXTqnRe9XfTf2OF9ATDafKEh9Z3ArsfabWcYTJ06aBCr4VN/tmbFjCHmtXf2YPPHYNPwHwe6Qm9s5EJGR4CQ4SVI3btlhGDCpBfHe6HtUDyhImxRBYFj/u5IcUNRo/ZLxwjnBIxLYp5WnXBoHDG6SDGiWuFl9/BSopPishl+1TjgwbTyXuXUJU6Dtm+LygNBggaHC0hE3izn095oPtjmOpefDSl1utviMlJU+jFVMf5/q/a5+sI1h+ZcTIZZkeeeGs+E4JsWZBUBBLXvfwuHqYuCCNudw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2n+xneBQzSvbqgKvOODAJX+wTo7XJNQa3uGLmmh5Q4=;
 b=DslObqZUtOUhQ2fuzhStco5xBdRROa+cCbGajOQZRlFHU3hNZYXI6fHKBed2/hFLxFlxPtJnOikkT4ZXPPaE+NSRGZUOOCZNQ0TzgbJ0h1iP+ubyupmJtwUPLSxeQAhGXRNkR7LkpYcLMxqUbEljrFzvf9k7RoY6t+nfZbgwP9+lxJ+kB/qSwCWyoXYWJe64v7N77jddwexFbgYcqNDHrTcxec5/JigNWHOlEPh0mDJIs8Ndfu1O9nKqZMOdnjpFlcP/p0GGCguiMjcywg231gex1/S+Pe/7ebzhqApxrYjHwF1WxGjIQqyT4Gbr6yGcOyecM/txWU5pVhUx6N9bXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2n+xneBQzSvbqgKvOODAJX+wTo7XJNQa3uGLmmh5Q4=;
 b=kCbr3YkMxOmXK9fCIusdlTnxJoj/El7CvIjeeq1xmns3cTCDM3fYLSYwPVoEK/kQI6W0jkG5tzayIPdrFYhVaJC7D0YGYiGZXATE8FPVWZlG/yYvG2jMKetBNblrLqzBegDjkbJguCRwjE0tC+XfzASzI2FQKB8BBooz5ZgoKwk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SN7PR12MB6743.namprd12.prod.outlook.com (2603:10b6:806:26d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Fri, 4 Oct
 2024 19:36:50 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 19:36:50 +0000
Message-ID: <1f7addbf-51e3-7f24-ad64-b8a6d9c5e0ba@amd.com>
Date: Fri, 4 Oct 2024 14:36:46 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 24/24] x86/resctrl: Introduce interface to modify
 assignment states of the groups
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>, babu.moger@amd.com,
 corbet@lwn.net, fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com
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
References: <cover.1725488488.git.babu.moger@amd.com>
 <68c8ef0592c653c5b99cd26d982966cd4a41cb31.1725488488.git.babu.moger@amd.com>
 <faf50d1f-d3c1-4a9b-a87f-4598e88dc9a1@intel.com>
 <c43171f4-48c6-b6c3-d71e-1f23367932d7@amd.com>
 <1d987ed1-0065-4e4b-a719-65af93907974@intel.com>
 <ca7b1d14-e37d-5f0d-9371-32d8506e51eb@amd.com>
 <cd2d835b-cc63-4416-b0ee-20334b9b43dd@intel.com>
 <3b6a8ec9-5e4f-e4ff-cd01-96ecc366565a@amd.com>
 <4c212746-6d61-44aa-abc6-2d2155ee538f@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <4c212746-6d61-44aa-abc6-2d2155ee538f@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0090.namprd13.prod.outlook.com
 (2603:10b6:806:23::35) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SN7PR12MB6743:EE_
X-MS-Office365-Filtering-Correlation-Id: c4c29d97-94c8-4df5-3d2e-08dce4abe451
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z3Vjd0c2QitvUHpiRmR3RmNLYnBaMVU4OFBxNFpLVCtjc3VNYmFnOHQ5YjVo?=
 =?utf-8?B?Nmo4dms3bTFlQmV2OUZOS0k1ek1Pd0NZSHVlYXZDN0w2NHRIa1ZialBtRHoy?=
 =?utf-8?B?K0ZycUdsQjA5dnRQY3VFSWpOZURUNUJlNHE2cWtJaEIyTFdEd3ZvMFBsL2VR?=
 =?utf-8?B?YTl4SnVUODVQdGJnOUxkUnQ4Z1pqUUZrTzgrSmpRQnZLcm5nazVnN0tFTXlN?=
 =?utf-8?B?WUpEN2J4U3NZTXhrVTQ3b29BajE0aE5jdlhuRHZyMHFtTUxCSEZINWNYVnRw?=
 =?utf-8?B?WGFzY2hXZzJDbk1JOTlHQ1dVVlF5MEM3UUhVN1JDWmxTS0E5L0t5M09POEVa?=
 =?utf-8?B?S1k1ckpobXVEaFpCVW1ySTJkVml2a1lsSzZEZndFaXRoUDhhSi9Dc2NmUnRG?=
 =?utf-8?B?cUtCTUcrMVBYZlFvLzYwc2VsYy9CNEJVeG5VVC9WbXVNOHU5bGFIUC9TTkZk?=
 =?utf-8?B?TnIvRS9INndKUjAwbE5sODgyVlU1OWFoMlNSYWhvd2RIMGFzdEp2Y1ZtRTdI?=
 =?utf-8?B?Qm9pa0g4SzQzM3htSnFGOGV5ZDZjMkZSelV4WHdGdjNQRWZMZWpBRFRHcHNU?=
 =?utf-8?B?UFVPL0wvbHg5RjFjVU1oMjUrTkRTeE8wRVM5VXlQQzRlVForUlJpUjZQSmVs?=
 =?utf-8?B?MUxSTFl1aDJDdEZPOHZ0N0FEd0xSSU1uVTE2dUZwekROSzBya2dLSjVQUjh5?=
 =?utf-8?B?c1ozdWNvaVpIUit6ZVhqUGpLLy9leU8wdVBRb05MaU5mT1VET2JQbFVyaFRu?=
 =?utf-8?B?SngzTkxVbFd6M0dqdXpkc2h0L3RYY3NQeDA1cFdxYzR3Zlh3YTY2Nm9ZaWRH?=
 =?utf-8?B?M0RyOElzTVFzRkE1a2J4d3VHa2l3MmtIRkZqQjErL29nVGgyWThJd0FJUWMy?=
 =?utf-8?B?cDhHcS9KY2xWeEx1WWNneWxCOTdIalVLVzJrTHpiVjBYUmtSeGd2dkc0NWhD?=
 =?utf-8?B?SnJTWGt2UHRpWVNsS0dtQWZxQnRMek51YWFlcWt2VnQrM2I2c3piZWtuS2Z3?=
 =?utf-8?B?RDRBdGVpUEtSRVkvbVVQdU9CVTJGWDRKdTlKM3JDWjhiRWhqdFB6Ukc1WFlz?=
 =?utf-8?B?bUY3Sjd0OFFLN21EVXpCMXUvc0JaM3pjUzRvdzNLMlFuQjJLRFVBY0xzaHZZ?=
 =?utf-8?B?NjdzNElRdnByTFpEcnU4cVM5M3hqOC9XMUxiaHFSVjFNU1NHUHdGd2JSdEw4?=
 =?utf-8?B?ci80YityUzg0akg1cjVyRmFDcHIxS2ZzMWJvMG9XdlgvV3NuNmpzVllTTnow?=
 =?utf-8?B?azZYMEZOVGFMYzYwVXJwS3RRQXQ4MFQ2ZFVPdk1ZdVpHOHZNc1MrREdlTTlm?=
 =?utf-8?B?WW9YdlhYc3dMWTJzUFdNM0JhVXBUSEhEaWVHNW55V3hndFZGUTAveWhDN2pz?=
 =?utf-8?B?QmJ0YmIwMHpQNjZ1VURpTTFvUVB1NTBTN1VnZ0hBU2pJWGFpekpZN0ZSdUdp?=
 =?utf-8?B?UlJiNExiQ0U4TVIvSHI1YUlyTFBBT1E0Ri8rSmp3M29pcXVadGVPZHFlWlFz?=
 =?utf-8?B?WWlMektPci8wcjM3dFFodW90cWhRRThBMXdRdmttN1VDOVBmclhDOVpmME54?=
 =?utf-8?B?RW5xbHVTTEJmdVE3UWN1RlhQUExvOUEyZ2loNWgwalRyUFBwTmUzQ1FrU3dU?=
 =?utf-8?B?WGpSQVJmUldZejVTM3BUZWRQTy8rQWFnNjd4Z1JpQktydk92S2E0em9VdTYz?=
 =?utf-8?B?dGJqTlVlTGNzTDJZcEx5akIzVzhIeUlrVlEyek9hSUtxWGhwNDhFVGF3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWtQRmVpWmxaUjE4ZEp3MXFTcTJZeDIyeG54R0FvVzg2Tlk3d3oyVnVYb1l6?=
 =?utf-8?B?RVF0a3c0NGR2SlZOVlZpTm1iMmVKRWY3TVdZeDRZcnVreEFmeHVBajIyU2xC?=
 =?utf-8?B?b1dhUWc0K1F2Wk1kbGFDN2tJTlM3d1JqcVhVL1cwWkI4Z3VhWmgyZEVQS043?=
 =?utf-8?B?N3JGS3hIZ1dQZFBEWkprd3c1VG1vVTY3aHdyeFREVGgzT09DNy9tVFJLV3RZ?=
 =?utf-8?B?aGE0UDg2SmhoZVdRcXh2ZnZKdGhOUmRmOUw1N2FFc0NVallKcVdSUWVIbFAw?=
 =?utf-8?B?ZUl1N3owR2VBdFlzWXZQN0VZOEE0WUd1YlF5MVFHa1lhQVR4YjBnV3FUNHFH?=
 =?utf-8?B?ZndLZGFkclBJUlhqckZKNEMzOFF6VTFDMnVUZFNDMVg1SUpOdUZpb2JGUjJy?=
 =?utf-8?B?U2hmaTZLKy9hRDdJTG10VXN4MkdkWTdoSUN5NUU4ay9CUklFbEdwdHp4UXJV?=
 =?utf-8?B?T3RyeFByWjRzVVJzMnZmaXp0UFQ5STdiNURIRXZsZWdDeUZSM2R3L1dXaHBr?=
 =?utf-8?B?K1pVMEpDeEQvcGp0dUVyOWIxOFYzdFJmaEdVQ0x1VW5jTTRwcFBMd09ldDdk?=
 =?utf-8?B?TFNlUDhWUEx2aXJJdytBcmUwNUJ5VEdIZ3k2d2Qyc2lyenhId1ZoZGhWTUE1?=
 =?utf-8?B?T09ocHFxZTZESUJzcGU5L2tYTWwvc3NzNnBjQ1gvY2c0K0VtTGZ1Ulh3b09G?=
 =?utf-8?B?NWRpWmhZZEhOODB0MlhlYXN3SFZ6b2NTR2Ryc2ZKMjY1dkpCcDB5K3pGZGZV?=
 =?utf-8?B?TEJWQVlCaHNFRlUrSFlhMnlBaS9kbE1yOTdTZmQ1VCsreUYwaVNjT1dMZjk2?=
 =?utf-8?B?NFczWlRDREhpamF6Z2hScVpqWHc4N3pCNFZFangycU1zaTRyL3liTi9sUmFQ?=
 =?utf-8?B?eG5vcmhBbTh0UHJCUU4yVWh1d2xacEpsN082QWU3aVNBODBaM3lQTUl3VUxM?=
 =?utf-8?B?ZEFLYXNxY3BzelRvRkNUbzg1ZWlIQUZqSzk0TlJRWFN4ZktvRW9ya3ZITDFo?=
 =?utf-8?B?eTk2QXVwQWdHVWxwNGk1THoxcW5jUjRjbi9jdTM0S0JpSHR5eEFxYUx6b0V2?=
 =?utf-8?B?MlJ3NndUeUhybENFamJqd0NmSTg1cHgvU1pOSW8raFpIWWNNUTU3c280ZGZS?=
 =?utf-8?B?RzYzR01WQ3FDS2MyZGpaSm1icjlINExQeEFmMzJuZDNQOXZXb3kwNldCZ3Ax?=
 =?utf-8?B?ZlVqOWV1aUo1eVNMM25JTFdmeGRXdW1rSS9xT25OalBMU09HT05hU2hCOHk0?=
 =?utf-8?B?aEdnSkthVXJKNGJINXdHQ3ljU0Y5eVhRNUNZRkNrUkpocFI5QjdBRnBLYlN1?=
 =?utf-8?B?c09HZkthTFpjNGg5MDNnanNkVExZaTZqanNrcER0QXBGbzJETTdtZkhZb255?=
 =?utf-8?B?UzVNN3ZqOXZjUll2d2JCbjEwUGgrUHRaVmFYd0NhY2Y0YW1WU1FZU1k5UTV2?=
 =?utf-8?B?dTd3aEpVdWFCV2VaSGJKMEFxQXhPWU9mVTBzbURYZlhnZm9oTzBDOXIzeDNN?=
 =?utf-8?B?dGNyYnIvZnBIL0JqeUFxTXNNRzMvVWNPNmZsalJRVStRSW1EV2p0eUhrYnMv?=
 =?utf-8?B?WW5sQTlvQjNSWFE5RVpKQkxVMmxld2ZkcktvdjRIRzZUNmlsbTJpaUFmNDJ2?=
 =?utf-8?B?OGR6eXRpSTA4UmFDNE1XRVdpaVRDMDZZSE1vQk5Mamd6cXhVOTBUWCsxdldB?=
 =?utf-8?B?M0ZZZllkandmU0gwcUpxNW1lSDNCUk95WS9GSFdyTnJYOU91OHlvM0FpT285?=
 =?utf-8?B?cUx2UUErY1VRdUVGZmJuWGg4SHl1dkJ0NjRzVW1jNkU0MHduc3RDVk82Qmdl?=
 =?utf-8?B?b0hLcWpwVklnMkhJYjlINjIxZ2Fwd2VsdiszbDhsd3RBNGE1ZDdSckpmUzNp?=
 =?utf-8?B?Zm5Od0t2dTkyL2hGTWF5TXhPNEY2Q1hJK1VIZVFSN2Z1Rm5heC9OWUZ0dGRi?=
 =?utf-8?B?enBtV3FOWHl0K1c4NWhFakM5aFprRzFXcEpKL1pvMHFRVEpqUHFnSTl4cld1?=
 =?utf-8?B?THlIcG5FTElWbWUwRGxjSmkvL0c4bEk2YlU2T2hFRy9CYmFDdnpMVnFQaUJv?=
 =?utf-8?B?RFZJS3djQXB2QkJEVzVXUGNZNHEyb1VNMUFYNDlWR0pWNUkvNjA5V1k5TkhI?=
 =?utf-8?B?aEl4dWx4LzdtNDJqKzlEczFCVE5meTlDbnoxU3Z0Qjk0d0NSMlpoWUUxdTQv?=
 =?utf-8?Q?/hcPk4kvotdUonye+hujhiW3ATWL9d7NKvE+SYsVLkD2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4c29d97-94c8-4df5-3d2e-08dce4abe451
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 19:36:50.2511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b4reBQ14w+6663QwGP3EyWg98QSD+jCqU2ZphRrh13LPh1XHxsuMeHKm0V6M38rF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6743

Hi Reinette,

On 10/4/2024 11:52 AM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/4/24 9:38 AM, Moger, Babu wrote:
>> Hi Reinette,
>>
>> On 10/3/2024 9:17 PM, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> On 10/3/24 6:11 PM, Moger, Babu wrote:
>>>> Hi Reinette,
>>>>
>>>> On 10/2/2024 1:19 PM, Reinette Chatre wrote:
>>>>> Hi Babu,
>>>>>
>>>>> On 9/27/24 10:47 AM, Moger, Babu wrote:
>>>>>> On 9/19/2024 12:59 PM, Reinette Chatre wrote:
>>>>>>> On 9/4/24 3:21 PM, Babu Moger wrote:
>>>>>
>>>>>>>> v7: Simplified the parsing (strsep(&token, "//") in rdtgroup_mbm_assign_control_write().
>>>>>>>>         Added mutex lock in rdtgroup_mbm_assign_control_write() while processing.
>>>>>>>>         Renamed rdtgroup_find_grp to rdtgroup_find_grp_by_name.
>>>>>>>>         Fixed rdtgroup_str_to_mon_state to return error for invalid flags.
>>>>>>>>         Simplified the calls rdtgroup_assign_cntr by merging few functions earlier.
>>>>>>>>         Removed ABMC reference in FS code.
>>>>>>>>         Reinette commented about handling the combination of flags like 'lt_' and '_lt'.
>>>>>>>>         Not sure if we need to change the behaviour here. Processed them sequencially right now.
>>>>>>>>         Users have the liberty to pass the flags. Restricting it might be a problem later.
>>>>>>>
>>>>>>> Could you please give an example of what problem may be encountered later? An assignment
>>>>>>> like "domain=_lt" seems like a contradiction to me since user space essentially asks
>>>>>>> for "None of the MBM events" as well as "MBM total event" and "MBM local event".
>>>>>>
>>>>>> I agree it is contradiction. But user is the one who decides to do that. I think we should allow it. Also, there is some value to it as well.
>>>>>>
>>>>>> "domain=_lt" This will also reset the counters if the total and local events are assigned earlier this action.
>>>>>
>>>>> The last sentence is not clear to me. Could you please elaborate what
>>>>> you mean with "are assigned earlier this action"?
>>>>>
>>>>
>>>> I think I confused you here. "domain=_lt" is equivalent to "domain=lt".  My reasoning is handling all the combination in the code adds code complexity and leave it the user what he wants to do.
>>>
>>> hmmm ... and how about "domain=lt_"? Do you think this should also be equivalent to
>>> "domain=lt" or perhaps an expectation that counters should be assigned to the two events
>>> and then immediately unassigned?
>>
>> Yes. "domain=lt_" should be "domain=lt".
>>
>>>
>>> Giving user such flexibility may be interpreted as the assignment seen as acting
>>> sequentially through the flags provided. Ideally the interface should behave in
>>> a predictable way if the goal is to provide flexibility to the user.
>>>
>>
>> My only concern is adding the check now and reverting it back later.
>> Basically process the flags sequentially and don't differentiate between the flags. I feel it fits the predictable behavior. No?
> 
> This is the point I was trying to make. If flags are processed sequentially then it would be
> predictable behavior and if that is documented expectation then that should be ok. The problem
> that I want to highlight is that if predictable sequential processing is the goal then
> "domain=_lt" cannot be interpreted the same as "domain="lt_". When flags in "domain=lt_"
> are processed sequentially then final state should be "domain=_", no?

Yes. that is correct.
> 
> If sequential processing is done then "domain=_lt" means "unassign all counters followed
> by assign of counter to local MBM monitoring, followed by assign of counter to total MBM
> monitoring". Similarly, "domain=lt_" means "assign a counter to local MBM monitoring, then
> assign a counter to total MBM monitoring, then unassign all counters".

Yes. That is correct.
> 
> If this sequential processing is the goal then the implementation would still need to be
> adapted. Consider, for example, "domain=lt" ... with sequential processing the user
> indicates/expects that "local MBM monitoring" has priority if there is only one counter
> available, but the current implementation does not process it sequentially and would end up
> assigning counter to "total MBM monitoring" first.

Sure. Lets accommodate the sequential processing. Process the  flags in 
the order it is provided. I need to make few changes to 
rdtgroup_process_flags() to address it. Hopefully, it can be done 
without much complexity. Thanks
-- 
- Babu Moger

