Return-Path: <linux-kernel+bounces-389744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4B89B70A8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 00:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C397282862
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 23:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D781E47A6;
	Wed, 30 Oct 2024 23:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BdI0Jzcr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B3B21745E
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 23:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730331906; cv=fail; b=rrn36m/ouugusGuEyYIQPymek6aJlP2JlFdom084DNCn+Xu7nGth3nqAm4Fa1oPjOd7f/Iu+19C51KTcIKBn0seAiB1oudn1viHWWWnBrm3GbnJKs1QfdUgT9oJQk7FnGzgye2/gpNwKOOnZ7d7rQkrBLcPygJPLzug3PTMOw/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730331906; c=relaxed/simple;
	bh=bzvI1TBDlnzoAm6+WA301DFgNlbB3ObxO5C08XXTudI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mBHCq4f4CQdopLmkLSbS7OX4MARwAK5MgzPzag0f8cjp98J0/A7Aid1T8ZGNvTwKv7Vj9noH6fAbJzYI+WTA4wpdx/K0AgRCm81XNBlhM08ySCIhqPAlvSvzEGtbvpKxTSkZjkpXUq8SHvZFwDIJ2iyCCy+3LIOCSKU/O38DQwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BdI0Jzcr; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730331905; x=1761867905;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bzvI1TBDlnzoAm6+WA301DFgNlbB3ObxO5C08XXTudI=;
  b=BdI0Jzcrkw62tqCEU/GGK8VNE3vwdf/48i3zz3SwhVk/q3pM8e2M3CCm
   aTFKZIsZIzNki0bgIH7Kkxs7cS4ukmixl6WRlUx3YsJ7DQ/rSEhgBXgZx
   FTsUppicPwAujb4RHvQ5ZxZrTVp1SrKkFYUpzgc5/lXiMsuHyKIwN1Oh+
   nmhMjcd1qZeDQwYGgAT/83GxItBC8zgxVx/aXSnuJMc4fraYGmixEjjc9
   7DTdjxpNa9kKiuUyRQYQezL8czkLD/1YLWM4wSBFstrzcH9ECnNM5TKEW
   oNUYFzZHOwJqf4gLbfr0wY4wcVZUbdKjpz9hZAx8eO+fch9mjUkq2PZYU
   w==;
X-CSE-ConnectionGUID: b4Qvrq7DQ/eFB+HXHbpDmA==
X-CSE-MsgGUID: jEmysJZmSxqHkWiAU0cYfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="33752170"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="33752170"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 16:45:05 -0700
X-CSE-ConnectionGUID: vTkEvl78TzKOoRZHtXG3tw==
X-CSE-MsgGUID: JS2CPVYGRTegAhM9pXV+TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,246,1725346800"; 
   d="scan'208";a="87024304"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2024 16:45:04 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 30 Oct 2024 16:45:03 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 30 Oct 2024 16:45:03 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 30 Oct 2024 16:45:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SZB3rZLzVGfFeDhFBDGPytVje1BBKpS47SPgg1kK4hR3FI17xYmIa/EY3YV/SesDrtseIplfIkw864bsc7XsixiWLyiO0T/5fpaLBBAp9rJnO/Mf4QTilyg2ZmXEYAUztAAM4TUVYw6nH2yC2ZkxvEvCya7FXaH63qeM676zTvcUyrReKjTNKK3uDGrP8aCZ5gHlF+BeTHDfS5nWGZ170Y8Gig0UjmeqyxveTHYmKvjoDmJ5LkTrOcSD6O6FNj4ttmvp/NWfWgKjyXEqQ6O48PKSM8LVdekSGpJGELKTde5QUCV3DZOn7CqOOeV5XDww9BVMFao72TXGC84m9BpPBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NKkm280ZG3jnQ2Xkce1V/+wE3bCDsTrZdqvVLTlcc2s=;
 b=wHCLQLzeazWlN8pD2h43Yr38LrRQAoFktTWmTYmdzbZ7R3/t/ISFvYNUJO0gmCjioOj8IkvfgwNmbiXG/ox7KsOhrQd3HoDGU1Jq+S9tzvjR7QsrJTK3BtA0c1oAyhdClClZJSKSmevyOwQsjXqnUa39qAUgKfv3Gfjlk+JV/XwX0L/931itv1YDvzOhliACJ6A5EyleBMWOXR1iSosifDYfNtf5M0YEH3jQB3Lbp69Q1Mv2NiSFyjnPY4c3XQIS0mkNBKVaAwFzWRk2PgvK1+6hcjssNxZMjDZ+lM3Ahx/xsPidg2tCOfmuDNk0DcgEl5lkheZsgcit6J6RKHIDzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by MW4PR11MB6861.namprd11.prod.outlook.com (2603:10b6:303:213::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 23:45:00 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%3]) with mapi id 15.20.8114.015; Wed, 30 Oct 2024
 23:45:00 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Mehta, Sohil" <sohil.mehta@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H .
 Peter Anvin" <hpa@zytor.com>, Uros Bizjak <ubizjak@gmail.com>, Sandipan Das
	<sandipan.das@amd.com>, Sean Christopherson <seanjc@google.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Vegard Nossum <vegard.nossum@oracle.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Nikolay Borisov
	<nik.borisov@suse.com>, Eric Biggers <ebiggers@google.com>, "Li, Xin3"
	<xin3.li@intel.com>, "Shishkin, Alexander" <alexander.shishkin@intel.com>,
	Kirill Shutemov <kirill.shutemov@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] x86/cpufeature: Add feature dependency checks
Thread-Topic: [PATCH v2] x86/cpufeature: Add feature dependency checks
Thread-Index: AQHbKyQaC5X5bE2iQUWrnCpA7YAwvbKf9GrA
Date: Wed, 30 Oct 2024 23:44:59 +0000
Message-ID: <SJ1PR11MB60836BD27B436E3E8B404AA2FC542@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20241030233118.615493-1-sohil.mehta@intel.com>
In-Reply-To: <20241030233118.615493-1-sohil.mehta@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|MW4PR11MB6861:EE_
x-ms-office365-filtering-correlation-id: eb09d512-27cd-40b7-6c21-08dcf93cde28
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?t1t3CE+eyYULEfTHb2/hAoV6Ll6qOf/IbglSzy9WqVVGQJA3tpP8i0UbzkMr?=
 =?us-ascii?Q?fZJeSXhvndIpPAXKdTh8v2Bn2tUGRbkBJm21zWAnQ1vcC8D6i6fhYwpGA9N7?=
 =?us-ascii?Q?Xg47yYPLMFuIZ45ol+3umlxQzuPKBV9l442QEbQm8N2mkggqONJdxdJkIDaT?=
 =?us-ascii?Q?Y+eiJcA5j0yEVeYl/eP83fiIh35cPQZOLdHisKAmiFiIdZ9m57ZEcMs5Ry6w?=
 =?us-ascii?Q?3msNUBkU4S4gV5Pcld+zEHk/3rNCCPpVhyHIh+3nPlQxpb6PH6A0HapEL99x?=
 =?us-ascii?Q?jcV+vTAVIsVzZoJMWo7UrgA7n6EnLo4ddIrVQcxErct/ok5KQFP8obBp6BCZ?=
 =?us-ascii?Q?mYCJm2MstLtzeyEa+eUP3vVp1sFV+CUO5v9SLbAxvsUX9Z+iKjGdhU5a2b40?=
 =?us-ascii?Q?iMjxDI/Cpk8/LT4IebNd937n+zEHglLJ+Dxl7PPvYchKyiM6oAUqz9f4DojG?=
 =?us-ascii?Q?6Dwp418cS6c5a87ia6ujTNYpuggcB5szoOXdlfXE6P/eB9YQ92ZbYEikgkq1?=
 =?us-ascii?Q?5xT2S+7YbQYsbznG1OgAvu4Qa6byyKPIOrlq8+lXjVGCCr7UkoRnOe36snR4?=
 =?us-ascii?Q?OOmR/53bowGLg7V4cQ4HGorY5QL6Hzwhk5p+7i/rLPVz9tlQd7pgvGPX21GJ?=
 =?us-ascii?Q?/7+UHzL85ximln+cw4nxIgp4UH/UNhqiS6yfyREOXLXUqOmBJ0UIBR2q0rSY?=
 =?us-ascii?Q?isyEYHXUZFoDjC4+C8C2NIiDYjGfcT8s8utKUrO3RGIYdKenic8ozRuOJV3J?=
 =?us-ascii?Q?kJNLcT/ak0yE2u0U2QzfQM7Go3nTUP/qseKO6JZGKjRxsRqYmjiylNRenchu?=
 =?us-ascii?Q?wsrbf8lemoFmN/w8E2g59K3C9or2auMSA8ZPaQeyAkqjjsaEgKqYkDsN9M0G?=
 =?us-ascii?Q?Sr5HDlZmyc7FS6Heqo1KE3TY2CGp+VuQjR7Xn8Y7YykuLCLZ43fhOZpJDAeS?=
 =?us-ascii?Q?ejGbiU7w87TzCQ83SnaELvGFOELRNSn9ojV3JoDyw5r2SS6dmiG+wmftNsMR?=
 =?us-ascii?Q?L5b2NnDwFko7YV3VS5Hto0KA+jcAFfpt+8LhUgOUv16yxEs9QOPHXOD7XsjA?=
 =?us-ascii?Q?GnlxkRgm6Ur73Umomyb7zMNoPiXIZs57LajtvOhL+7OtaHt45iRSWIvvf86v?=
 =?us-ascii?Q?08O/cOaWrKWb1pRhPnCet+BgMBCY3R7BCBOIPmOI4O9WriizTwqEeODGr0Q5?=
 =?us-ascii?Q?LLr5mNYOm8jGOz5gVaq2LZN/AKvLHrMQwtCoIDPME3/28jiKL4rDgE/J/9nj?=
 =?us-ascii?Q?XQxoQ14XquH5Gdu2Gug5vJniGDe5Vex4IWUqwlWNHwBsPyVvYXrOEbhA22aQ?=
 =?us-ascii?Q?8RuWgRq5Y15lcppw3SdzrJfu3/ieT0p7maCKjovtwp788aofXHyGwLxRaCM1?=
 =?us-ascii?Q?7xAMySk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZGcJsZ/VRTLO9LEmnqcumq2YfHBep8VILJ1ozSXUxwa6ZkB9eFrcR0w5Adgf?=
 =?us-ascii?Q?UY6qD4zQQbQcRjg+XxgIZa0Z6reV5KJEwjwTRCYcjW9Qvl9bqIO9cirqNWN+?=
 =?us-ascii?Q?lP/lR74zW0oaVdwf2p7Z6psHBzBABpQ30XY9w/vlFGnSfAWRk+PNyfz9nUMK?=
 =?us-ascii?Q?ukIleZFY12bm0bWmQTExO23FgLhJGfLplb9dpzolEa5ZlhKcwxqXswjoi3e/?=
 =?us-ascii?Q?0kF4E56WcdQVTEXaU65205Y9CiPGTJS3qZ1HVhjbl0rNatwotGTJmMBpkXVJ?=
 =?us-ascii?Q?1Pw1JEjko4FRoWHvlPQsMNJBJCICiPpEJAcUzZYFL3E2HZtfKePkzkGxqQk+?=
 =?us-ascii?Q?T2b6bwQM33/g4flPIMoYatAvkr7chVvSjfiiNrg5MFBYH6LL/v35gS0jPZDA?=
 =?us-ascii?Q?gFW+qed7FRWIYQtv9Tp6DfRq+segiwwWu2CXlM9Xb79rLScRVDu2wWObmHnM?=
 =?us-ascii?Q?v2xUMzxrKEd9aj2ycav6XUbjqjNIVYC/kEryrF68sp8NMYVsIkLskwUouWi0?=
 =?us-ascii?Q?h3RzNW1GSc+T8hVcMOdXV8r1RJXBPw3CpZ91JBs3TPEBNhhEbWrJVpivkSXe?=
 =?us-ascii?Q?GLEfb+uS6z1rTlpmoJ287+eQEgWVJrLHNBCbhUVAoAuC+S/SSrfxRWVi8xYV?=
 =?us-ascii?Q?zY/VxlIP6WtZhsEDK49z/YnRO9YwZ3lf2RSg/0n7TpPm+ANKSJ5SoKaiOU+7?=
 =?us-ascii?Q?serf7HOOx5xSShMfVEpJRR6zU9JZZqWYj2xlNMDxOEgZZoSUgAqP3VhGuWtw?=
 =?us-ascii?Q?vM4/PehE8zJ2igW7h23V2gUpnvk6L5+qfDELz+hwc9bVf+eKE1uRKx502FAH?=
 =?us-ascii?Q?pxeW8Mx3a3vsQwCv+lyKfGKv3M8FPCejfY1DwGLAdCX0OFHHLYa5i9KVniBT?=
 =?us-ascii?Q?LBZIWD7M4nBq/pyvlaWf0Ve71rCmZoRaLQqwO9tHzHxU9ZmJJ74EQTmsRlaC?=
 =?us-ascii?Q?iz79o5eHOd1j0zN/mdhINoWuDeBzpR6BXaumq2ekffoDbXwJ2ItY61njJQ0h?=
 =?us-ascii?Q?OIgVQghNEKuwYey2w/jEiqrlELO78Ab1+s97u4hMe0SbL+1qp4d50t1wsWa1?=
 =?us-ascii?Q?XsyhvZAesV7EMCaDQ0Zcwjtcol9p+dSj4YrTYIRawEx1rWGaJi0bWI7Feevs?=
 =?us-ascii?Q?TMEyMqrHSq8hbl+7uBctDxEeVN5OqDRK+VAWS/YA/0D8SwfbewyXrDcoWiZm?=
 =?us-ascii?Q?q/0FN9A8ldkWSR8aGVNrt2yDFzztlERD8dMTpO3evgGv+NxFvQcTxDLfpZ/1?=
 =?us-ascii?Q?3LBjsSxA4wRP6Aa++RfBIS5vij+mpBfRFTpc6dA5cWUFiFLmxrPqghyDes2q?=
 =?us-ascii?Q?ap7o17Y41QzC4chiAj4pKUdinxmlDUPcqQDWGsFzaWL0Kza1pXZNP5IuH+Ir?=
 =?us-ascii?Q?qmkWyIHE0qk1IeUIYwuw64KeXIa48345i6nOZmVHlXH4XPCGgUuQmZ6C5TEi?=
 =?us-ascii?Q?ARvdlsEJQNtGnd6Bp9EARLMH9i0xKGObkyp3CbJMCVSlfYy9xG0l5piptEVO?=
 =?us-ascii?Q?5fQbc9NS2Ln8rujlJWc7X+AgaVOz9UMMSQnacyjYV0PKIhyljTos+KDtXl3D?=
 =?us-ascii?Q?Nu41r9qWlamMWnJmDjOP1svqCLU+5kZ7beQxhWxx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb09d512-27cd-40b7-6c21-08dcf93cde28
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2024 23:44:59.9931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /DJNhiBEF9fkGxyjKikJDJzWoRSHymf8OpwLn52bBWHIOJkpitgteQvCDsi0Mw6gxPnZGu/qpib0a8xtdJ6h8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6861
X-OriginatorOrg: intel.com

> +void filter_feature_dependencies(struct cpuinfo_x86 *c)
> +{
> +     const struct cpuid_dep *d;
> +
> +     for (d =3D cpuid_deps; d->feature; d++) {
> +             if (cpu_has(c, d->feature) && !cpu_has(c, d->depends))
> +                     do_clear_cpu_cap(c, d->feature);
> +     }
> +}

The dependency check found something very wrong. Should there be
a pr_warn() to give some clue that Linux papered over this problem?

-Tony

