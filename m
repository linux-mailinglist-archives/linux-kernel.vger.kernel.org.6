Return-Path: <linux-kernel+bounces-260592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B17A93AB43
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 04:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3627D1C22EB4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 02:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6695A17C68;
	Wed, 24 Jul 2024 02:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I0eCB0fD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FA02595
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 02:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721788620; cv=fail; b=O6jJdin1zYgx7LM9PX2Z+F7ix1q32wy7i4wf1KuyVraqEfeNh227Ag7Qfofqw/U5cSha1DpdHyNGgitikHYKFswHouZE9jZPFWvBoH6ujBRj14LTQui4gi7BsoKkigSEiaqZHEdV8eBnnB7I2sQ/zxA21K534Fi8kLeyMXpZkgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721788620; c=relaxed/simple;
	bh=+HMrrOflV4A9jjedNGfq/6I5VutNZyjtvu+LEGvyAY0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u9UvXzsJCFBtYomC5Pg265DMZlTzEun5vQftlZ5wBrk0jTRLOopv8uz+bQ00O0NhLyrXJt+M1tuDY0kmGGbjiiclYtHAfk0NAcenxmMfLwP5rBUBhNNBVxrr6Ypn+SG0jXShakRhgFabBFOYLP0pQzcniQAgnFNYaOaooIXawmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I0eCB0fD; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721788618; x=1753324618;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=+HMrrOflV4A9jjedNGfq/6I5VutNZyjtvu+LEGvyAY0=;
  b=I0eCB0fDZWQJSm6GancwmWX1gGBlQyJD294qtDAdJWG0+vEmQ3YdEhXF
   ob/xGd7ypXKwwCSXYDhL73+NKexaC3EfISNOt9/SWzjJNkCjSzf4Tquwr
   EbQzpm2Ct27MTk77X75rJR0baenbR2JcYWmiWnApd3pO6YU5y1RKL0PqN
   qC6SM1DZR6vsREDSUKTXeq4LwncykqsMP/ARKkb2DHeFNIKQzNXG9TVrw
   LU/XkdrHIQWOhzW/UkkeXQF5kCZBxZ/XoEBa0a+3PtAecP+bRbs2D/erx
   XRRwpuGY649FNgL1Lt37Az+0yMCoH4LZOZ08zXv04j7v/p1/NlnGT2Abq
   A==;
X-CSE-ConnectionGUID: R2suRSpyTcuSMqSdTkcUcA==
X-CSE-MsgGUID: s6AoxjJzQpOygGx5suI6vQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="12679353"
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="12679353"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 19:36:56 -0700
X-CSE-ConnectionGUID: qJpJYERDThSAXm3DW1mlWA==
X-CSE-MsgGUID: dt/qhDrKTGmGcH/Ht2vaDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="56735034"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jul 2024 19:36:56 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 23 Jul 2024 19:36:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 23 Jul 2024 19:36:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 23 Jul 2024 19:36:54 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 23 Jul 2024 19:36:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=suVnZRDfcaxDTKxB1iCHdA9ozHZYNX5MaPhlj4mnbaaoo3Z1AgMxam/mA96k/ykFho6Y/kpk64+gQ2HIdtu8N8iNK1T/U+Ep/YXRnzZWM6TYhgGiFx0XSVMA0zcxFsef3hUAeS9z2W1nBDGNDrSoHEUtwuDhH8GE/20vNz2K82BUZFZt5PfAaardBxoy7AuNVJS6F6kAfaWQLP9DHO2TN3U3wYNwdA+5zhlkNjmMaEZZWkV1AvJMoG9g6b8fZ1CqV/Y7VC7yuCCpc3o5oPMwJ+9L3v+Ry9tJKJ9wUF3rKvJGNARM0XTBFQhU27/Q+xwbdeswclTzS0SsDHwoqc9Nnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pegraRfC/F890Y/T24BCI/0aeBB9bUwbiSqXfUYq5Iw=;
 b=Y53l5TJbJm4wDUNBc075kgBWMoUvyaxML9MLQ51x0/ion/slJpRzRLCSvAqLzzYBClc5Y2dKm4olYPd5x63Gl8+Zw+ReS1mQ/BDtNf2I/3mduxxBScCTOiWx3Kqa54hNps7PBc0veiK/ozRl7ViOjP6zhhh7J9S6ogRlBEm0kQ8WdvJjEBnSuLi1OHas2RV236ZINLatcPzmRfdazxtXbotLXdV/WUpwTenhE6dwOo9CjqJqufz4jItYBrvHcnkZAB6DrJpRJUIJYT4PQo6aI2yzKwKxyftqyq4lMbGMOc/T8lKzPbYr1nE9WbjysknjmkXz0XwOyP23M6x/afbrwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6039.namprd11.prod.outlook.com (2603:10b6:8:76::6) by
 DM4PR11MB5971.namprd11.prod.outlook.com (2603:10b6:8:5e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.20; Wed, 24 Jul 2024 02:36:52 +0000
Received: from DS7PR11MB6039.namprd11.prod.outlook.com
 ([fe80::3f0c:a44c:f6a2:d3a9]) by DS7PR11MB6039.namprd11.prod.outlook.com
 ([fe80::3f0c:a44c:f6a2:d3a9%3]) with mapi id 15.20.7784.013; Wed, 24 Jul 2024
 02:36:51 +0000
Date: Wed, 24 Jul 2024 10:36:43 +0800
From: Philip Li <philip.li@intel.com>
To: Qu Wenruo <wqu@suse.com>
CC: kernel test robot <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, David Sterba <dsterba@suse.com>
Subject: Re: fs/btrfs/lzo.o: warning: objtool: lzo_compress_folios+0xb0:
 unreachable instruction
Message-ID: <ZqBou6g6iC7OLGZn@rli9-mobl>
References: <202407232006.7Gelsbv4-lkp@intel.com>
 <ZqBgvYYl154a+bV6@rli9-mobl>
 <fbe7c1cd-ff4f-4252-baf2-88d3c5e50fdc@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fbe7c1cd-ff4f-4252-baf2-88d3c5e50fdc@suse.com>
X-ClientProxiedBy: SG2PR04CA0154.apcprd04.prod.outlook.com (2603:1096:4::16)
 To DS7PR11MB6039.namprd11.prod.outlook.com (2603:10b6:8:76::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6039:EE_|DM4PR11MB5971:EE_
X-MS-Office365-Filtering-Correlation-Id: 46880990-3ab5-4392-5c9f-08dcab897982
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aEJnV2o1QkZoVDVwWGNuenNZbGtEZGJ1aDgrR3VIOE9CcHY5OXAyTE9Lb3pq?=
 =?utf-8?B?cFZkVmNrT3Y4UDFxSkdSRmhqRDI3TmlNTnJxY0ZYT3IwQWRsbnhwb3R4c2la?=
 =?utf-8?B?ZmdTZzBSTzZZYkJvdDkraVdsZXpVUkF6M3ljZEt6NTVweTJxMzhXWjVKQWF5?=
 =?utf-8?B?a21NYXhGMEZ3Nm16Z3RpLzlGUHBqbzRmS29aQlFQVEVmdXNneGM4QSswWXF1?=
 =?utf-8?B?Rkk5dVF2RTNGc1FkRDhIOFEvc0srbDhNMjc2V1AzSTVOQytKNjdUSUtPcE5k?=
 =?utf-8?B?ZkVGNndXNG50VXpQNkp2RzdHZEZSeWFwNS9YNE9Pc0JwWi9veldtbVd5bkM0?=
 =?utf-8?B?MEhUOUZ2U2NvRVI5dTF3K1R6V05CWlg0ZVZIdzluVncvKzdDU0RMOG9JcitJ?=
 =?utf-8?B?UGN1VzdEQlpkYzhXY0ptMEdNWDd3TDBZVGpxZHo2MHZET0s0MW9jaGd3ZnE2?=
 =?utf-8?B?RTVteko2Q1BOemRqeWxVVGtVRnJPYXlpUmpQdVVMWGtoUkVZOTVhMHFDWkEx?=
 =?utf-8?B?MUk0anhDL0hHVVAwbFVtTnZqU3Q3TzJTcGRQWFQ2eHhtVFBMMjhuOUdCajkz?=
 =?utf-8?B?RVg1clhDVlVyaGtMRXRKWGNkNDRBZlJsU2lVamlFbUZ5NmFQa3owcWRUU3Bh?=
 =?utf-8?B?MGZTYi9HTTBRYU11SEwvb2UyYmpuRVFzZHdqekVHaldKUm1YWnJPZUpIeWtr?=
 =?utf-8?B?dVdVdmJZVXNtd1BMaUtNVUtDc25rNFpsalljbCtwbWQvUDZCSlErWmpXRmhO?=
 =?utf-8?B?Y3lnMlpZQ2liV21nSisrOU1aaWlkVU9BRXdZa2tOczY1UDNJaVNKMEh2YVl5?=
 =?utf-8?B?T3dTaWlOWTNQSkZSa0V6bERtNVRXWCsxaFRpU0grUkZsVlVFRUVPeWlaSVdX?=
 =?utf-8?B?ZnpLNzhKemZ2WWxDZjdxNFBEWWEvc3J0V1JhZUFCZk1uUG1ZVWRwdEZZR3N2?=
 =?utf-8?B?bkpYd0ZQbmhyOEpoVUN3ako1WnhFZFVhUFQ2K3lucVlHVW1uaVZRU3JYNjA5?=
 =?utf-8?B?WmVmR1BBK1NIeXlPMW9oWGI1N294T084b2hIcWcxekpSOU1Fc2RmdlZWaG5z?=
 =?utf-8?B?T0dCZEptUmFocWNha1owL0QyTWttOGR5azBTOHFpUHVITFowWEtSMkNHdWhJ?=
 =?utf-8?B?UFFFdjRMSjFreDVZUXRKMFNkTkdicjZJelJLZmNlUm9SSlowREdLeVM2Ti84?=
 =?utf-8?B?TEJwZXlCa3dTYmI3NkhBM1dLWTgxLzkzcHRzd29EYnl2b0I1WE4yaDYzT0lr?=
 =?utf-8?B?K0g1QWRXbzMrRm40a2I4NHZ3WFRnK29JZDVDR0psNHk3eld4RWRyUGRSVVh3?=
 =?utf-8?B?aEZTdWpWaWZ0TGY2aDd2VXZGL0JQVmd2dEtqWDJ1Zm5xb1lFb0FmYVVyV0hj?=
 =?utf-8?B?ZkV5bVlPZ0JUOTJHWFduMUU2V0ZxY3g4dXRTS3BqaGN1TjA2TFdrZVNIcERQ?=
 =?utf-8?B?NFlSUElTS3lSUGU1SmNpRDNSMkpMNVJKK2g3czZvbEpVY1RGaGtUTXVHdmtW?=
 =?utf-8?B?ZlZhVVFVci9BQ1ZrSEhIdmNmcURJQ3NDSzBLOXlUS3ZoQU0wcnR3Wm12dFhz?=
 =?utf-8?B?MUY4U25jREFWd2k1bHlxREN1MnlXVkVsb2hIWHgraEllNlNwN3ZETmlZVHgy?=
 =?utf-8?B?ZkpTS0sxV3dUYy8yLzEyVzdZYWtFTWlaTENra0d2c0NBdWRTMk5qc1EwTm1E?=
 =?utf-8?B?WmZaUVExUEIwbll5VVR5SUtSNDIyanR1SnV1M3hiTjlldDFseStKbG5QRkFQ?=
 =?utf-8?Q?/w2cf0hnbOBjO9WExIzpc4VXBBzY+dTaniKI4e4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6039.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0p1S2t6bS9wc0QvSHptRDl4K0NjZ3MyYmlPRFBFemtNUGMxMzVZZVM3aDN4?=
 =?utf-8?B?UWJONGhqVEZ6THpsUy9Xa1JEdTdwZ3N3NnArL01TU3hGV0VSY0lEVmsxdm03?=
 =?utf-8?B?c0JDbDNDYXc2bG8wMW1JQS9rN1ZpNEU0TG12K2wyYmpJbDJVajB2b3pPZjZ3?=
 =?utf-8?B?ZmF6RzJJWmF0aVFidXBjSmh6SWZJeDRaUGtUNXJjZlNlSkk3bUhKclgyeUlz?=
 =?utf-8?B?SnIySjdQTXl1cHJ4cnRoSUlGZ0hVREJrbVRMZTFXMEFQb1FJWjByejdiSWwr?=
 =?utf-8?B?a2hDaTBtcmN1Y1hqcENkUnAyYncyek5zNUxmdEF0SFRnNjJnRzVFbXVKSE53?=
 =?utf-8?B?K2VPc0RhYWVlOXVBcTNROTYzdkhjOXR1dHNlekhXWHk3RHRLVnJPUk93MjNl?=
 =?utf-8?B?Wi9HcDJqb0kxeGFTcjJTN1FMTFUxQ29JR1BtTWFENDl6NjE4ZFRnQmhrajh6?=
 =?utf-8?B?Y0U2Q1JnNVE1UWtmTGJYbEQxQUw1dm1IajJRNno2ckVpQTZKWVNMQ1hLSFlt?=
 =?utf-8?B?NXdXZkJ3WElYUko4Si8yMTZuVHJBMjBwNjJrQXhJclBndDdNVjluTk0wN0hB?=
 =?utf-8?B?eVpvZ3A1Q1RTb2x6amRPSDV1VTVqV3g3QjlQakx5VjFFZ2I2V2V2TnNhRys4?=
 =?utf-8?B?d005ZkY1THhHeFF3OVhtbGN3LzE2ZWxRaUgvMHdvYUk1SWdyaElVWVhrWHRi?=
 =?utf-8?B?V3dYSkNjTWRYQjhhbXhTWGZXb05jZTY3T3hiRWNjL2Q1eEk1YjZSWS9pMnJE?=
 =?utf-8?B?b0g1SklwOVBMYmhIV3VtZjkrN3dha3RyQlZQR1MwMlpXc2oyWml6d2lTNFg5?=
 =?utf-8?B?cUZZb0kvTDFGRHQ3L21BN0QzTXEyUGd1a2hDN2h1RERtWTFrWncxajU5RVd0?=
 =?utf-8?B?TWZFSnNWY0k1YUFud0czSDJ1VzlEaUQ2VG1MbHdhdEJYbmVmTnpWQmlqNUdu?=
 =?utf-8?B?M09UTXljL3lxZkxGV3hmMHVSTFFNT05pNVdZalVxdmt6ZUFKSkdOTzVvNEtZ?=
 =?utf-8?B?UnpOYXBwN3Q3OTQxWHhQNCs5dEQ4NVVpTlFCeElBWnZaVE1xSkhYanJlWnY2?=
 =?utf-8?B?RFpWRDMrTmMxa0FhOUk2TitPSUpCQUM4Q25QWk53ZWdkMnAzVC8vU3dyVnRh?=
 =?utf-8?B?ckVYWnpmNzlQSmFmVC9pUUFEOTVkWXFuVmZMamJyT1czUVpzM1g1LzRlZGlq?=
 =?utf-8?B?K3BDRURBYWE2TERVcW5jZWRLVkpEa3ZFL2ZWbkJkeVFqTmhIN0hLWEp4VE1F?=
 =?utf-8?B?d1RGSVJ0RkdvejNHQ1FKTHArd0M5ZjM0MG1XODJNbXBpMGRqSDVMU3l6THhE?=
 =?utf-8?B?M0VmcFdFN2tWY3ZueEFEVHRweWxRdXdNNktWckR4ZXhBMTFueFRDTXhtaVVH?=
 =?utf-8?B?M2lOSHJRTG1mUm5NS2wyL0g1b1V3Y3BWQTZQdFAvUWJocVByV1pKWEdRK1F5?=
 =?utf-8?B?V2Vsb3NSOGhxN3JvZm5SQitlbHZlZC93NWVvejBoVU1hbDdtMzNSNTZOWG1J?=
 =?utf-8?B?TE5WZ0ZUMkR2M3ZKT1RJeWJNSnp5L0RwbWhVNUcrMWdOV0FjWWRlZ3RQdGFn?=
 =?utf-8?B?cVNlZWZyWFZyb0QwNXQzNy9iRmZJQjh4cTMzZWNxd2VzTG96VWRocU5mQlBh?=
 =?utf-8?B?b0dxY2gvMm1Rd1hudnM1QVRyMWdPclZZV0VyeTgxMnIzT2UyMGVLS3NIZDNa?=
 =?utf-8?B?YUg2WVlhRWxKd04zTDlwSFcySXFtWkxGdG9TNHZDbE5xbVJkNUJaZmdQZ3N4?=
 =?utf-8?B?eTNtZmFBc0NiZnBPWEx1ZE9jcUNnRUFoWUhITGllSE4rWnV1L0FjTFZtKzFo?=
 =?utf-8?B?bExqVHl5c2cyaENoUklFYkhlNW40cjIwODZ3YkVlai9sUm4rMjcrR0pxcnlM?=
 =?utf-8?B?eERnSnEvd1dIdWwwZmJUUU02RzFoeXpsODFWWHlXeXRGZnBzOTdCYjFFTGMz?=
 =?utf-8?B?cDRiQldML2ZNbDdkcTMrdHM2eUhFZVc3aGk3N3lXZWNPUHI1Y3pkaUJPOS9M?=
 =?utf-8?B?VEVCMTRPeU9tdWNjSytmcU9kR2Y4N2V2SUx1L2NVd1lBbEZ0NTkxK2hLS255?=
 =?utf-8?B?b3VQRmc2WEZFOWloZ3NqYWVVODhjdE9ac2s0eko4MTFSZ0FRdFk5cVdub2hT?=
 =?utf-8?Q?SPg1V4DJu41AcWWkVyJj5KIjj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 46880990-3ab5-4392-5c9f-08dcab897982
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6039.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 02:36:51.8879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3u5O8Z7pjXjjFmc0IjHL2hkqcEogWG02koMAcbpd4D93zUZv43V/n/f+mzS3h2R0nz9BtgIZYgbrHzJCafARfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5971
X-OriginatorOrg: intel.com

On Wed, Jul 24, 2024 at 11:45:42AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2024/7/24 11:32, Philip Li 写道:
> > On Tue, Jul 23, 2024 at 08:18:41PM +0800, kernel test robot wrote:
> > > Hi Qu,
> > > 
> > > FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.
> > > 
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > head:   66ebbdfdeb093e097399b1883390079cd4c3022b
> > > commit: 400b172b8cdcff87038697169fe9e4222120dd9a btrfs: compression: migrate compression/decompression paths to folios
> > > date:   3 months ago
> > > config: loongarch-randconfig-001-20240722 (https://download.01.org/0day-ci/archive/20240723/202407232006.7Gelsbv4-lkp@intel.com/config)
> > > compiler: loongarch64-linux-gcc (GCC) 14.1.0
> > > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240723/202407232006.7Gelsbv4-lkp@intel.com/reproduce)
> > > 
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://lore.kernel.org/oe-kbuild-all/202407232006.7Gelsbv4-lkp@intel.com/
> > > 
> > > All warnings (new ones prefixed by >>):
> > 
> > Sorry, kindly ignore this report which could be related to tool chain upgrade to
> > loongarch64-linux-gcc (GCC) 14.1.0.
> > 
> > We will further check whether the issue can be reproduced on gcc-13.
> 
> Gcc 14.1 is totally fine, as that's the version I'm using already (although
> a little newer, 14.1.1)
> 
> It would be even better to focus on more common architectures first (x86_64,
> aarch64), and put a lower priority on less common architectures.

thanks for the suggestion, the bot covers all archs, for the case here,
the commit works fine on x86 or aarch64, and only triggers a bisected report
on loongarch. We will block such false positve report and do a comparison
check whether this specific issue can be reproduced on other compilers, though
we can not quickly tell whether this is toolchain issue or real issue.

> 
> As most developers are not really able to access those platforms easily.
> 
> Thanks,
> Qu
> 
> > 
> > > 
> > > > > fs/btrfs/lzo.o: warning: objtool: lzo_compress_folios+0xb0: unreachable instruction
> > >     fs/btrfs/lzo.o: warning: objtool: lzo_decompress_bio+0x140: unreachable instruction
> > > 
> > > 
> > > objdump-func vmlinux.o lzo_compress_folios:
> > > 
> > > -- 
> > > 0-DAY CI Kernel Test Service
> > > https://github.com/intel/lkp-tests/wiki
> > > 

