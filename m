Return-Path: <linux-kernel+bounces-522154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83483A3C6BD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EA1B188E87A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C79214232;
	Wed, 19 Feb 2025 17:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bwt4zKPE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003CC1DE8A8;
	Wed, 19 Feb 2025 17:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739987529; cv=fail; b=aF86XnM/vxsp5F9NhNZHXP6H8a4WoVyHiDLUtlM1KZA4tU/4+fvZIRxbTnMESDYx3u1eEmIwSS0psPvpd2Z2gl/cQDDYWBuMqeBWE369fyEKk7m345lksNXxQL9myxOZXtlValJDu8NKEIMnEqnpwaGxwgirvX/+NrCnxMUGpaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739987529; c=relaxed/simple;
	bh=NZu8zUqa1ip935oyFqcRaa9Pfo4rVmivWcWTYo+600s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F9E0lWLEjEPK06n6JC8h6K3sokBN4fewXAH1CFqfNMxpA7hOHduwhnype7pbgLoJ9har05otGm53qdA+8qAFvVMEpe4lT/535fbdmLNnMZzlZklFvIEVnLR7WIJrme2dmRQ4hEXDuYr5CvuR24c+seIwsVEDHdLS3NY9OzyT34w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bwt4zKPE; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739987528; x=1771523528;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NZu8zUqa1ip935oyFqcRaa9Pfo4rVmivWcWTYo+600s=;
  b=bwt4zKPEyQR8H/pqOuP0++WDfILUY8FJWHLXREjd+wCvd9DgxOMob4fX
   SCb3ys4SJsErt+A4Y8kyzLd4cox+bBRzphTkcXQGApZy1a62ETxz4Pqh0
   QbgNyNt9HkARI5d22kxYAalQtN/MdlawpL8WNjG3VKyhwn1xwIiVrScEt
   ugzD0ey7yjMSp2aBQKylTWFt8ysCnC8Ry5kaIRZe6y94Fo0WBTznNzMpU
   wU8E9DylYF7zk/ZM6EEAn7SSDiEHr0E/6rOs2iR3Ah3whFFsoX186JIMl
   9B+SF7S6PU7jThLsrHeId40l+ve6/7jv4QNOhlZ18kdxivi8x0JyGTMe2
   w==;
X-CSE-ConnectionGUID: iRcEQMS6Sc+/fvF9x1dOKw==
X-CSE-MsgGUID: wk4oxGh9QAW2OtPWHrmnRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="40861718"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="40861718"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 09:52:07 -0800
X-CSE-ConnectionGUID: LWVO/gRkQwGeFQAo50oq6A==
X-CSE-MsgGUID: uT05R2U+SOSIkvZFbYSzVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="119761903"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 09:45:42 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Feb 2025 09:43:46 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 09:43:46 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 09:43:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qk4vasZIQ9PZaXMW6DFRQvrkh2CBOboZCKKMNIn2N/BWACTYFnsPFew1XB9t+1rERLAJnZLkLTGOD8ZgboyaTeEU+VdtGzxksYXdQiXxvi3Eau4hTvryHdRpX1ZgCVSkXsQdfVYNmKqnH403LNXiU+EnB9uyBMrlFW+Vlo/VQ72DsSGz/Tc5Dixu/4KkSZAXDktmesu9UCzKzR6lZ/9cfZFPrW7NHg6lxApYnyYpkVVDzRpmy4DAOlmM/FJO1uJutrPmc+3V2KvOvyGjAxjR1QOO+enluEwSi4GDRF7sv7h4BcfODaONveZL263qaFnc47bbFKq1w7kVPB5unwmXSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZu8zUqa1ip935oyFqcRaa9Pfo4rVmivWcWTYo+600s=;
 b=T4MI0QQYByE0fsRUVfnJS2Do3ZuQzRo8tFonIoYXJ77ZeCou1vkqJM29uRC/PFyTXiUvhMRkuJYrD8cUWJ3X4njNFt8d/Gft9lWdBUk0iezi76WffWS4A5APuAH8Xt5nvT+6sM15JdQKmgp7FEl7hy5CRWyNeV/Lz/NX1l7EjDYsFMDv3WuXNk/qPN0J9dgQa7CxcEVsMbvI5vFUWycRUcKWaxPdYT/TpJjYFDrJfKataSrT7CY1A+E32xtcgqxfN+Nb6nlccHWtySjiqmvpM9gNBvaEpTFjQMy1+pn/LgbH3JLWSn+w08fXJBnPwcdV7JLpWxPcYuLRInGx7z/Z5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SJ0PR11MB4944.namprd11.prod.outlook.com (2603:10b6:a03:2ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Wed, 19 Feb
 2025 17:43:43 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 17:43:43 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Dave Martin <Dave.Martin@arm.com>, Babu Moger <babu.moger@amd.com>
CC: "corbet@lwn.net" <corbet@lwn.net>, "Chatre, Reinette"
	<reinette.chatre@intel.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"peternewman@google.com" <peternewman@google.com>, "fenghua.yu@intel.com"
	<fenghua.yu@intel.com>, "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com"
	<hpa@zytor.com>, "paulmck@kernel.org" <paulmck@kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "thuth@redhat.com"
	<thuth@redhat.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"xiongwei.song@windriver.com" <xiongwei.song@windriver.com>,
	"pawan.kumar.gupta@linux.intel.com" <pawan.kumar.gupta@linux.intel.com>,
	"daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>, "perry.yuan@amd.com"
	<perry.yuan@amd.com>, "sandipan.das@amd.com" <sandipan.das@amd.com>, "Huang,
 Kai" <kai.huang@intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "Li, Xin3" <xin3.li@intel.com>,
	"andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
	"ebiggers@google.com" <ebiggers@google.com>, "mario.limonciello@amd.com"
	<mario.limonciello@amd.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>, "Eranian,
 Stephane" <eranian@google.com>
Subject: RE: [PATCH v11 23/23] x86/resctrl: Introduce interface to modify
 assignment states of the groups
Thread-Topic: [PATCH v11 23/23] x86/resctrl: Introduce interface to modify
 assignment states of the groups
Thread-Index: AQHbbQuip2j9pobRWEmWqPWE/065gLNO9qwAgAAZwkA=
Date: Wed, 19 Feb 2025 17:43:43 +0000
Message-ID: <SJ1PR11MB6083C0A20067D84AFE16F2F5FCC52@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <cover.1737577229.git.babu.moger@amd.com>
 <fe1c0c4cebd353ccb3e588d7ea2fe9ef3dff0ef2.1737577229.git.babu.moger@amd.com>
 <Z7YBxNIWb7dqOnfi@e133380.arm.com>
In-Reply-To: <Z7YBxNIWb7dqOnfi@e133380.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SJ0PR11MB4944:EE_
x-ms-office365-filtering-correlation-id: 5d5f573a-6f0f-4a40-106c-08dd510cf462
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?V1NoOW11VC82eUo4MDhia3BQOUtpQzVMOWVZQkt6TGExa2kyQzlnK2dUd1pi?=
 =?utf-8?B?UWM5QkQxdUFXVDc4MXQzNW1zTU1VR21RRGhyajRieEVUVmJmamdrcTJranFL?=
 =?utf-8?B?eG1NTkpyWXRYRkFOMDNZdWJ4QW5yYlJlcHpNYitxdUMvbk5pV0RKcW8yZzhq?=
 =?utf-8?B?UTJML3BIRytyRS9UTnlRVGlYbkpMOGRTSE52QTNEdWJ3T05FMlUzRzZFMUdH?=
 =?utf-8?B?dUNLeFhoQ3hzaG4wbHBpZkIxL0xVTU5xcnFEc1JodW8wMjNwZ2h1eUNYU1Q1?=
 =?utf-8?B?d0duZXFMaWdhc0FDdlhpMXdkKzZpQ2RXYVZrR3Z2WXc1UEROZVpaS0M1VEVk?=
 =?utf-8?B?NEJKcDYrNWQwVkQwamlrWS9sek9idGhkWSsvZk44NjFuWWRVTmV0WEVUUFdw?=
 =?utf-8?B?bUtEd2trejQ5cWNaWmRQa1QvQUIvZlpBemM5Q1IxZmM2a1pmREtsNDh0dk02?=
 =?utf-8?B?Y1R3eG4yZS9xaElHTi8vMDQ5dGd6a2ZBQzZmVlplNmwvV0JHUnFLdnI5Y0FL?=
 =?utf-8?B?UmpYVysvR3lrb012MkNHWlMzOS9SSkZjV3hiOEN6SnA3RHVmNmxGOHBJTVA5?=
 =?utf-8?B?NlhhL1VsQW84Y1dqRklqcUJOanJaaGhQbHZSbWJFZVloZjRhTkFGZDVGRTQ5?=
 =?utf-8?B?cDlWb3pmaGJhbGtIcjEzWFJPVTF4RXp2OEVqa0VaRU5RdWh6T3lhUGw4RnhR?=
 =?utf-8?B?aDBhNmw5UTd4QnU3b1Vpb1FTTE1CQ09rUmdjaDdvVS9zZUY5VHNtV1NtUW9q?=
 =?utf-8?B?OU5qcU0yMElRM2tGUHNZUDJVRUs0aXQ3VDhJWHNKV2pHaThPU0dsSEtIanhi?=
 =?utf-8?B?TVJDMGlZZzFHVmhNSWtWTy8xL1Z1TldtckFpMVBOb0Vma0JFVzdSeEJJNnBD?=
 =?utf-8?B?T3ZYNHU4bW1HcVB1cm1aNFVlWUVwcmptZ0JlSjQxczgrKy9HK05BcmZPSjFC?=
 =?utf-8?B?L0JyZyswSDQ2UkQrYmZ2Z1RGaGc4UFo1ajNRaXBvWkVmbjNvZHNVY2tscXli?=
 =?utf-8?B?Z212ekoyemZlQ3FPTTJNSXVuU0RtRVZDamg2OHpBalZCakRYMHVZOTBEMmNZ?=
 =?utf-8?B?cXdIRFM0dHRpUWNzZ3NmeFNFckc4Z01acEM3QzV4S25EUVBZS0pOVFNSd3JV?=
 =?utf-8?B?c1BNYUJGeThMZmVzNVRueHQvbVNISFdwRGVRSGF3Um9xTlpYZUpkb1JDVXFz?=
 =?utf-8?B?cmNLQ1FyclBwK2Q4YXc3akZZSWVvMy8xaDlXdjMwSGY2L0hUVWJGb0tMQVFQ?=
 =?utf-8?B?bjhXai9YN0Rmc3Z3YWlMWmh0dGRmMk83MEpYTEFIdVViTUJJUjBLZGJCQWRC?=
 =?utf-8?B?VUV1cHRTMnNwSndDNnhFR0FSM0FydzdabmJSV2VrOXBkeHhxbGM1cW53Y05m?=
 =?utf-8?B?dWY2WkJTMTFhZWhiWWFkcGVmTlpQazJ2S3g2N1NLRHNBK3NPUVJIZzRqM0R3?=
 =?utf-8?B?RS9TZHlxYXBUdzViVW9QUEtPeDZWdW1ISm84TnoySmFXa0Rxc2RMeGg1Wkpj?=
 =?utf-8?B?ZC9HekNjbVNaRmdFY29wOFVxWFFrL3pCcnlQb2VYUER5U25lL1dqejd0VWpu?=
 =?utf-8?B?eDBFQ0ExSjlvYTZyUlBPQTROQXc2aUtwRXdFSldtdDZnQUhaR1JnUWFWM1k5?=
 =?utf-8?B?bUhHcFVVU2RnOTRaWmFtb0kzaEFONEhjZy8xcUhldDlwWDlBT3hQZUxmdmw3?=
 =?utf-8?B?Z09RNDRZK0VibG9jVVN1cER5ck96ZThvT2lhNmN2enpaR0tLSHlRazNkL0lh?=
 =?utf-8?B?RmZQeHVvVmZwR0FIbzV1bjBzNDcxRGg2MTRmd3JjbHZiTnpTbFhpaCtqdklC?=
 =?utf-8?B?RTdBbjNsRjhURU5CTmlPdDNheFdrSEZYYlJVamFOUFF6ekppWk1UVWcvVGsv?=
 =?utf-8?B?QjNZRUIvQ0dOSjhwUDdCVFJxTEZFWVN6WDRiLzJpNW5haWxqTmNZcXd1T1JW?=
 =?utf-8?Q?kRRgsV8thf2wuyhCLk3Lfq23KXc/IAGG?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RVlFbTliRVdUZE1lYWdEUndnTlQzL3pLSDdyK0k3WkQyQ20yOEU2d0JkTEVu?=
 =?utf-8?B?TGJ0WDFHajk0aVA5NGdhV0NhM09JOFVUdktKTk13UFV0Z0VEOHR6UUViUnlS?=
 =?utf-8?B?dXVyWDlYeVdwckxnR3NycTIzN0MySStwNGNsUTU1OXVGNllTa3JjUXlrTXd4?=
 =?utf-8?B?OW4zVnRZUHpWZk4zTTJJNHNTaUNYYitZMFVwRVhPbjVUZWE0QXcvNTh0VE1Z?=
 =?utf-8?B?UHRqM25odkJKNzluVlg2eUNBdFlZeFdkZ2t3ZW5mZ0pya3NqQ3FWYjRWMEFX?=
 =?utf-8?B?bmk1L0ZBdWVBc3JQTGNlbWxLODhKM2hKQ2Job3l1NEx4dVplT2NtOWJERDZi?=
 =?utf-8?B?dzVLRGJxSzRFazErVmwrdEJMdXJ6V2JlYkpzYXQwcjlxb1c0SUl0NXNobHRm?=
 =?utf-8?B?K25uN0Rxd21IbGR4MHJpY1dEUnllNm92UzJCYTBTdG8xK0pmYTdvVFhuUEhp?=
 =?utf-8?B?aHgrckxwL0Z6dG5PV1dJWkhVV2EzWXVSUmRORy9vZWxXVm9zbnlvSjZkK0hi?=
 =?utf-8?B?ZU9ZcEg0anVwZXpCSmhmekZKam1JdjFEdmpIdkF6MWVzaW5BUytCMkpOOWFm?=
 =?utf-8?B?aTMxMlB1Wnc3azJWR3A5Z3pRSFJaYzVtOCtPL25XQ1hqaW1Pc3lsSUpkdEFG?=
 =?utf-8?B?Y3VqSVpjaTNPRHk4VnI1QkxOUHJuZmVxY0NUV1NYdmgwTEVBU0VTOUEydWIy?=
 =?utf-8?B?ckdHcFhidkR1YjM4cENoek81NUo5Q3NleHFIaEpLdzNuREt1MGpPeGFtRm5q?=
 =?utf-8?B?Sk5naE1oRVpoVUoyc0xFbXJ0TzR3cmtSV3pKZHlNUTRMRnlTV1BOT283ZXpL?=
 =?utf-8?B?L25iU3ZPRXN0MjZwNVAxNVduYXgvNGVSTFlTSDVTWEM5b1VyUjNUazJPZTlL?=
 =?utf-8?B?NUU1NmhGQktrQzUyS0h6WXRLYTBhemhhQ2Q5RktHQ0ZXU1VUd2x5RkJTTkRB?=
 =?utf-8?B?ellnMEozbTVzcEltbHNrTExSSVJtUnYvd1BBeVNtWUlwWTAxNDhkelBOUG9k?=
 =?utf-8?B?TE5yQWtsQlRNZ0xvaFAyYnJwVDBmNlpnMjZVQTJsbksvR1A3SFpUbXkyTisz?=
 =?utf-8?B?MlI5cjUrYW1mZGdFNE5XaFU5VVRQK2RuWE9hek5jSExsWTM1Uyt1SHk1YW1p?=
 =?utf-8?B?cExYZE9ZM3dFNXlVaFhObkNnMnhMSWpwZENlbXVYdFhsMURKTy9Lbm5pNFpR?=
 =?utf-8?B?UHJIU0JNTkxkVFlaTWFoNHJ1ZmNXM2JnaDhRbjhndVRacXlvdXpWQTF2SkJq?=
 =?utf-8?B?NDNhYWMrR04wczN1UEoyMVlhUkZGTWtZZ3hXUi8vSm0rSThGVFdEc2hUU1lv?=
 =?utf-8?B?MzQyVHpWV3NjWm9HYktiU2d6ZkNKSU9MYlp5dVREcDkrNWZmbEFnZVk4RjVR?=
 =?utf-8?B?MHc1S09oaTRyaFVWclgxbjViS3IrNmdENkZkaEJOVW1sN096YUJQYVJMano3?=
 =?utf-8?B?bjdjUWpsYnJMeXdLVUlHYmNVekFieEF5L0lMT1VIS0ZrU1RoUGo4bDBZOHdy?=
 =?utf-8?B?SWFaUVlwTVhONWM5SzBiNXV2eTlZNEwrVTlFTDNTSnhjQk5lcGNMUGdYWnBa?=
 =?utf-8?B?ZTJLNk1qdW5ta1E2U3ZBTkNDR0E3VXpvVE8vNDd5MGVUVmZtL1MvUDJaclY4?=
 =?utf-8?B?WDlBNkc1cGZtWVdUQlQ3cHQwc1B3TFUwU2NYZTZSUlU2UXNCbmhURFZ4SHJy?=
 =?utf-8?B?aUtIdkdZUUthRGN0bDR3NFhreG9hU0RMTzhBd1diRkpxaFdIN0kyLy84ellj?=
 =?utf-8?B?OUFXaWI2aFlhSXJta2RuazZoSEdpaS9aRzFNbUpoZThHbU5SZnFPRXE3MDJp?=
 =?utf-8?B?WWo4S1VZYkI4YVpnQnhON29hVXNCcFV0dFRXZXN3Nld2elhwWEFwNVRnL3lN?=
 =?utf-8?B?SC9GVnVuN0t1ZEorRGFpMUxkcTFvRUNmVDA3cFJGQnhyaE91Rk9SZlEvcFlW?=
 =?utf-8?B?VUtRUndLNGI2UCtZZGxXUTlqOUNNWktaQ1MrZCswQmZYd0Q1R3NBN1Y0c1or?=
 =?utf-8?B?V1pHWCt5RFJNNlJWbnFzNnVjMXg2VUFpaWREYXJ6eDFqeDNXT0d5dy9XQU5K?=
 =?utf-8?B?TFNpaWVvcUxONzdQbE83d0NSUDhQSVEzU3VUTEtHSDZOTzcveENEeEpYM3hE?=
 =?utf-8?Q?2VkshUQG0izl5wIPSFWQabQXy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d5f573a-6f0f-4a40-106c-08dd510cf462
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 17:43:43.7875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lrn50ZFqSl9ojFKR/ZxWM3oTnihUpkJMhVi1fOe90H1j0xRG/edG0FrxxMTDg/KR26/2aOAIKAulBAGmdR+A6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4944
X-OriginatorOrg: intel.com

PiBJIGhhY2tlZCB1cCBzb21ldGhpbmcgYSBiaXQgbGlrZSB0aGlzIHNvIHRoYXQgc2NoZW1hdGEg
Y291bGQgYmUgd3JpdHRlbg0KPiBpbnRlcmFjdGl2ZWx5IGZyb20gdGhlIHNoZWxsLCBzbyBJIGNh
biB0cnkgdG8gcG9ydCB0aGF0IG9udG8gdGhpcyBzZXJpZXMNCj4gYXMgYW4gaWxsdXN0cmF0aW9u
LCBpZiBpdCBoZWxwcy4NCg0KTm90ZSB0aGF0IHNjaGVtYXRhIHdpbGwgYWNjZXB0IHdyaXRlcyB0
aGF0IGp1c3QgY2hhbmdlIHRoZSBiaXRzIHlvdSB3YW50IHRvIGNoYW5nZS4NCg0KU28gZnJvbSB0
aGUgc2hlbGw6DQoNCiMgY2F0IHNjaGVtYXRhDQpNQjowPTEwMDsxPTEwMA0KTDM6MD1mZmY7MT1m
ZmYNCg0KIyBlY2hvICJNQjoxPTkwIiA+IHNjaGVtYXRhDQoNCiMgY2F0IHNjaGVtYXRhDQpNQjow
PTEwMDsxPSA5MA0KTDM6MD1mZmY7MT1mZmYNCg0KLVRvbnkNCg0K

