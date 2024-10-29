Return-Path: <linux-kernel+bounces-386146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 524669B3FA8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 02:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D679A1F231E5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 01:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126DE2B9DD;
	Tue, 29 Oct 2024 01:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gnhdL8Sn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06F917543;
	Tue, 29 Oct 2024 01:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730164753; cv=fail; b=mBUvCRwcPgQFibZ7T2I41/a5Xcj4tBMu8UMxEMXgYKH8EkdSPH/9Ca0C/KEROtade6jRjHm+uuvi6rmU98VuzA1roXTZM8sgFiiqXOENuEYY56PcqCOg+l+ssm6RrOIOiQHJ5OU3Pw547+E2M9JkDvLNyoAUPl9PED0C2/wF1Wc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730164753; c=relaxed/simple;
	bh=AgKBk60mEXhHAott3DCDlXCszoxMeiyOqkswosUbV2U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ERj6pQLKf8CUbMDozi5khvoi0Epnsh633ePqHdmWkQjc6y3LLKdMkaG8CynC5DUmq5HknTAEsXD3KgXEsCl23BM4GqKv0GN1V1KrJorX1xsYKywNj3+jBblsT3KxR7VqlhLihuNwgPu4tVIp6C9ujX0zJHP+jE76VF1mR1Dun0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gnhdL8Sn; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730164750; x=1761700750;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AgKBk60mEXhHAott3DCDlXCszoxMeiyOqkswosUbV2U=;
  b=gnhdL8SnKup5ahQRh/Hmj5ZdmDD6WMs4KUpFHA4Z8TG9sSctiXNvhpAK
   BHMkcUeoYdMJMFRhPxIxcVY6V5yAJi+Vc1NptunMxd1/0dpSUoWQqo9co
   fcRVqeK3gpj7Ekpxw9I43qYZEKpGozjXRfMy+WSyqPoRGjJ1wA6aMvTqd
   2tMiE8PX/RSvMkebukODkjd3WMjhs+8GVxGmQg1ry1/7PMdGD/Pe6/fTf
   H1KTjgJenWcLAHO6p7K6bRekSaKDLrJLDB9bYX1YybewTVZG+0OgIB/62
   J3oVhcUGsfcppWCAm12mkZXRckP674yBtb5pD3rQXrnWrI0jN7bX87Vf0
   g==;
X-CSE-ConnectionGUID: dTD+OpUlTHCFC78EpDwmiA==
X-CSE-MsgGUID: FDZwL33lRWChBgyfOvd/ng==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29969506"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29969506"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 18:19:09 -0700
X-CSE-ConnectionGUID: 9w2aXH4URF6aWlApaimNSA==
X-CSE-MsgGUID: lLUlny2hRyC1Q1hKs1S/uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,240,1725346800"; 
   d="scan'208";a="86353226"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Oct 2024 18:19:09 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 28 Oct 2024 18:19:08 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 28 Oct 2024 18:19:08 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 28 Oct 2024 18:19:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MGxyblx8d1rsBjKsHaana9EH88YQy4LRfyGLxb2N7jNvTH/JqDOdnLIIDxQK1c8gy5qHQk+j2czv6q30lJOcfUBZ6d+JcTvIiuzSDgC+BsDQb9Wr220NL7WYB4AVTy5qxasYFARPkJz98H29K4cp1JglR8MF8iQ2YCG7hWW+lGgGNUZQ+WiL7VKx5w3S+Iptfkj+r/g3NfIvIBARnE9RYu/VX7nrHkuqBzG0EpTdPR8UM2kQWG/vKdjDH57UlJbm45XiiLY/r/Pz0G5XFlpeL9zNXdwYdsDMC1RW7Sydj21RWRwqfLiZX3Nu6hZYP7ZzdjOB+Yeo+KZFTeQYOFc/fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/Vi1RG1zEa4GEzkQFpcuT+2Y4C0WpCzr2sKRSouT9c=;
 b=SXGtfqQZEtXZ9ED/7kdHW9lC6yQYlXFm5zn1MZRcEmqb7f8spIzo0CSA0h0eQp0aY+IB3FcpP1PaT+3BhyrmLJkRaocLieL9I+pOBxH0QH8C5hSjohcJXWvhcutbMPdyxQfLaMIS2pwM4trqrMa5sBB+ZthWWs8CBruMZ+nTn4mWhVekpzS6xO5MKHv9nTwZtnRN8xFIaIQkQ7LlGDhPDDCzkfDK3WalZ3O5wKSZ7Lc1vs0tciIYOkMVul8MSamW47pp4bay91Wmbt2u2oTOp7B3aZxXov6GNtEjgFa7jo5Ui+ZzVoWdXBk+HxfDBA4FMWZJfVhjY5f9XV6I49lGzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8184.namprd11.prod.outlook.com (2603:10b6:8:160::7) by
 CH3PR11MB7300.namprd11.prod.outlook.com (2603:10b6:610:150::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Tue, 29 Oct
 2024 01:19:05 +0000
Received: from DS0PR11MB8184.namprd11.prod.outlook.com
 ([fe80::f0db:4659:3880:6aee]) by DS0PR11MB8184.namprd11.prod.outlook.com
 ([fe80::f0db:4659:3880:6aee%5]) with mapi id 15.20.8093.024; Tue, 29 Oct 2024
 01:19:05 +0000
From: "Bowman, Casey G" <casey.g.bowman@intel.com>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>, Armin Wolf
	<W_Armin@gmx.de>, "corentin.chary@gmail.com" <corentin.chary@gmail.com>,
	"luke@ljones.dev" <luke@ljones.dev>, "Ghanmi, Mohamed"
	<mohamed.ghanmi@supcom.tn>
CC: "hdegoede@redhat.com" <hdegoede@redhat.com>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
	"Michael@phoronix.com" <Michael@phoronix.com>,
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] platform/x86: asus-wmi: Fix thermal profile handling
Thread-Topic: [PATCH 0/2] platform/x86: asus-wmi: Fix thermal profile handling
Thread-Index: AQHbJxJTjvlKQbIk50qQYOkUMuaUqLKYa3+AgASHUFE=
Date: Tue, 29 Oct 2024 01:19:05 +0000
Message-ID: <DS0PR11MB8184A4A4746815462B2C220ADD4B2@DS0PR11MB8184.namprd11.prod.outlook.com>
References: <20241025191514.15032-1-W_Armin@gmx.de>
 <583d58620eb3a26251c109470030d46d96677cad.camel@linux.intel.com>
In-Reply-To: <583d58620eb3a26251c109470030d46d96677cad.camel@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB8184:EE_|CH3PR11MB7300:EE_
x-ms-office365-filtering-correlation-id: 0bec3d73-6d59-4d79-d0c6-08dcf7b7ae3b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?SZoS4yr2VX+OHcx0dtFY9nKbdCOUOpei7Jrb4XQZejLksMdX/iERfceirE?=
 =?iso-8859-1?Q?9a3r1Y6PPaocTy8e3w41vbdLDcWpj0Oc/Eo4jZe04V7m2yCz5hMyLjH2xw?=
 =?iso-8859-1?Q?pttZuQYh8KRbx1qQVnu80Sj37BsgrpNZiWFypnlP2gduJoksO2B49r7s/2?=
 =?iso-8859-1?Q?N3Vhb0LlUPydT/Sr2WwJWalI/3rJJ5ZlCAnsPl+KaAOkeeEeCY4OCG8jhU?=
 =?iso-8859-1?Q?MyJXeKWSuI5bfG3p7fM7i0bvP7DOvPoSknqj4GA8He0+oy9jW9E1AVXebl?=
 =?iso-8859-1?Q?S64gM+8BZzck+SBfGSqcd2BxkN5kEgeepXWmzQTSWqCKZvzd2FltzhlXPm?=
 =?iso-8859-1?Q?RabG6yyR//YmusDacXCBA/dK4eyfWCHVmLSOuIVzJZMFrGZPKfcnTnXn9O?=
 =?iso-8859-1?Q?eLmr7AlT9v4WLbSW2A1LR9Q7/WCwy3IzbvECRx9//ewP45N+i8O1TwZ8Eg?=
 =?iso-8859-1?Q?aVFTeva/TL+OIaYzZJsGaHdenN8tmv2XzTW7ru9sceXUa+fo2i9uTk32fe?=
 =?iso-8859-1?Q?uJxrsRQYIM5iff5Mj4FgDpBadqyMHhsODD77lriGeJJz08JwbC5p02vfn/?=
 =?iso-8859-1?Q?HK5KCB2hM4QoaL/P2IOXwQxVhdkZnsr/LCZzNAFJ9b7lvwr0z23yakL5vn?=
 =?iso-8859-1?Q?PgCpU81Gx6uyHsnuyal1pu1EBOonKa1rc2CEcIQth6pO5sZRLUbAk6XxBY?=
 =?iso-8859-1?Q?Li46ZTtHR6cSk6xh4s0bxzFjIh1WGWhYcgFM7YxA8wumah4Ew/Mz+8Ujoe?=
 =?iso-8859-1?Q?2uZKbIvKmkV694NKVQq2MfaWWwqH+KHValAQn5kraIqknn/UwTXaW3YxdE?=
 =?iso-8859-1?Q?8Z5bviKgBOWvY/tba5/xIC60gCZ26GXNIqAX0b1D9QPhu4LCAjZVX2V2Kc?=
 =?iso-8859-1?Q?EPpXInUQH1s8sC65TVK1wt2zV4Ti2mO6AS88dDvXSUUK8hQ/lW7QRo3kZ4?=
 =?iso-8859-1?Q?zoMtA5q+W3DCOAq6vQjgijrkc+yxa/jsw/sT5TTSdWfLa3OVNcrna5fClu?=
 =?iso-8859-1?Q?qDyXBPjlWsqB7FvvChgrytStyrIFFuS3+2QgNzPenZIdWAWtz8pN/sUsth?=
 =?iso-8859-1?Q?8pVePEsZdloJqgxO+Mmtov5wIAetz60CLMsGHSLQpZ4eUu2R4GHt8quwDK?=
 =?iso-8859-1?Q?bvhrXG8UC7KNmQxqI9qg4etl+ADC1W0pwXb43mkhsMsiRgfyUOKYX07ndE?=
 =?iso-8859-1?Q?W9hivoHgs6k/24ek//nSMoalbBjVw9A33FRJg+3lt8nVf9w37cOrsXRfUs?=
 =?iso-8859-1?Q?5XB3gWPgW596TLOSr9/7R3jcRTnHga9HlgF2ydHuKAAT3rqU4AY6WnXRqk?=
 =?iso-8859-1?Q?5GKTMNzBwLQrt8gBvv/3i+xo83Jhsjny1NyfsRsE145iXsyC2DmE4KM/6K?=
 =?iso-8859-1?Q?TnLluhaH1zENHXko2GBIKPowF2UQWIJM4GRwzSf5VYCgcGalClJbI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8184.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NJLdCbrYeJ9xujn3gA+oj2OHcq1QBHkYbGCOwgDn/bw37oV3ACldrtLnuF?=
 =?iso-8859-1?Q?EMLtF/0dSuK0xUOudX+VY5lBCVFZTCD723KPgO35dCEqF7WPwesLesYGVM?=
 =?iso-8859-1?Q?Q8Fc55/97j/7VAPvTTGIkxVWmv5YXgZdVQKNjE25uE8ozU5FbR94ZFUaEO?=
 =?iso-8859-1?Q?rrke+LIXjD2T/PGdJj15E5XNvPBhXltW6CTV7c1CDgbifxVe6zCfDS0WEa?=
 =?iso-8859-1?Q?ddsNuxAJBeDoBF9+xReqNAlpr63x23cyvz6KFca6Yymtb3sSJSv0CZQub5?=
 =?iso-8859-1?Q?LFIW/9hEZhcvGuJnRIBfp2NsfKlLeCi8cYu7ssGO/1mooROJ2zHkV9eFtc?=
 =?iso-8859-1?Q?CwZiwhJzQ3IGTriAHEO0IdVtKanQdyPX+G1jcjiHlNrDE8D1QUtA6zpLES?=
 =?iso-8859-1?Q?SFyz6V9WU30d0LVwtoenkpxi2FyJGZX8Ubv0sp9zfjUTZJbkyClwjqGls2?=
 =?iso-8859-1?Q?I2zzN5Fc4MTvCnBRFUVCIvoq+KkYAXNcu84eyc+c4/S+6FZrTqJvfNFXzl?=
 =?iso-8859-1?Q?JscvEHzscUuN9qq/7kTj4PP17Otsyb/mKmi1q2gL0NpL0+wlX8eMWTLKSa?=
 =?iso-8859-1?Q?T7M+2si6FV0HsmeBfAhqmI3WADIlLebob0GZYonT6LphMDr/il8whA10d0?=
 =?iso-8859-1?Q?j1cqCrv8EqpZhgsndyQTnuRImG23qGxisVIVXoihKmCPZSWPDTWkns79Bg?=
 =?iso-8859-1?Q?4HGPXl1Aqx/UdeUc5DkuEC4ZHTj6DGdlsiYEEq1xweJSHBwEG21tGApCkD?=
 =?iso-8859-1?Q?0P754Dgj2V/iFEEqB6XJu5sEL6NQuH74XO7I095mPB7ZvJU9Bw6uPNY4Dj?=
 =?iso-8859-1?Q?w+WUUnjJB7fGZpBF5m1dsU1PrQLUxjTVHdS33POfNASbE3S2ru7aCJ4Wbo?=
 =?iso-8859-1?Q?B7hwcWrR61Q9RO4yrlS9trU685JY189y7aHf8j9LJh6Sc8uIe3ZIFdBZBt?=
 =?iso-8859-1?Q?cOujnN75vHNaHMNVTvLERLqePpWqRrgPC4T5rKW+tRlQL4jXlQLB1eLM2V?=
 =?iso-8859-1?Q?Z//92/8QM7jYrEZ4eoIj7UgP+dfiwZCDIXDoXPlucgC6cVDFsougYke/S5?=
 =?iso-8859-1?Q?w2Lnj8ZsQgUwi5hPKJEmSgGMnZmE7X0EgjJhUC1Iq17DMBH8az+ST3PW6f?=
 =?iso-8859-1?Q?WHIpmmRZpleZ83H0kIC8fT08e9vqaVVQRr8nU3o7DA/U/B0ZIroC4xksgs?=
 =?iso-8859-1?Q?txzAjMpCxnHLKW2oAtY+Ok8gtZjrxM3JP7sHO1dV1VJB/I7igGLl5T8Oc6?=
 =?iso-8859-1?Q?bGsLa5LUrJMS+gtrTNGZq15cLG1RAC+01seLEjgDsIxZIg5Qs6TMSlVfrO?=
 =?iso-8859-1?Q?GYdNsCKcuDSCY4YWQvNofQfWRfjHVyBIEf3pTkgunrj9/4DXUKebBJ4ylw?=
 =?iso-8859-1?Q?W8ULqYqTn1DJNkQ3Ii1VhUow+2vJPN61MwqxP+LE/SSCLrw6QKXRhcVw78?=
 =?iso-8859-1?Q?Obzwu80rV0KZ1iHWq1pQbn8+yf/mIhGBUfvuo8SCikNK+ohpJNwek/zEGf?=
 =?iso-8859-1?Q?Pe/y18ZszyZ9RP9eRIlYOUUr4CxG/GOt8pA/tby5GXiOm5ylx4ToNNCFvk?=
 =?iso-8859-1?Q?AazdNx3DMP7NzZPyx8A27Pj7LOp3Mzh42YSZhH8A05ma2P/rojfwZem9xe?=
 =?iso-8859-1?Q?qB973LaaD9EVM7nHOQZGCD77a6W61PwLgG?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8184.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bec3d73-6d59-4d79-d0c6-08dcf7b7ae3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2024 01:19:05.3616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 10UuiUc1Ej17p1vvmFEsyQoqhDXOOmN3P6KJ/8SpPKFmvQZ3pn/wFsWmHM3dEPOsxmGUfsNDGKyWADsBQVoD7F+lSmYgWo2a7UmLrv9cAk8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7300
X-OriginatorOrg: intel.com

=0A=
Ran a quick test with the two patches on top of drm-tip while monitoring th=
e sensor's temperature as well as thermald logs.=0A=
=0A=
While running "stress -c 8" for around two minutes for each mode, I can see=
 the SEN1 temperature plateau at the expected areas for the various power m=
odes:=0A=
=0A=
- Power Saver=0A=
    - Max temp observed: 51 C=0A=
    - Trip temperature: 51 C=0A=
=0A=
- Balanced=0A=
    - Max temp observed: 56 C=0A=
    - Trip temperature: 56 C=0A=
=0A=
- Performance=0A=
    - Max temp observed: 61 C=0A=
    - Trip temperature: 61 C=0A=
=0A=
Cycling from higher power modes to lower power modes works as expected, wit=
h the temperatures falling back to the peak values listed for the given mod=
e.=0A=
=0A=
From my observations, these patches are working as intended.=0A=
=0A=
Regards,=0A=
Casey=0A=
=0A=
________________________________________=0A=
From:=A0srinivas pandruvada <srinivas.pandruvada@linux.intel.com>=0A=
Sent:=A0Friday, October 25, 2024 9:09 PM=0A=
To:=A0Armin Wolf <W_Armin@gmx.de>; corentin.chary@gmail.com <corentin.chary=
@gmail.com>; luke@ljones.dev <luke@ljones.dev>; Ghanmi, Mohamed <mohamed.gh=
anmi@supcom.tn>; Bowman, Casey G <casey.g.bowman@intel.com>=0A=
Cc:=A0hdegoede@redhat.com <hdegoede@redhat.com>; ilpo.jarvinen@linux.intel.=
com <ilpo.jarvinen@linux.intel.com>; Michael@phoronix.com <Michael@phoronix=
.com>; Bowman, Casey G <casey.g.bowman@intel.com>; platform-driver-x86@vger=
.kernel.org <platform-driver-x86@vger.kernel.org>; linux-kernel@vger.kernel=
.org <linux-kernel@vger.kernel.org>=0A=
Subject:=A0Re: [PATCH 0/2] platform/x86: asus-wmi: Fix thermal profile hand=
ling=0A=
=A0=0A=
+Casey=0A=
=0A=
On Fri, 2024-10-25 at 21:15 +0200, Armin Wolf wrote:=0A=
> When support for Vivobook fan profiles was added, two mistakes where=0A=
> made:=0A=
>=0A=
> 1. throttle_thermal_policy_set_default() was not called anymore=0A=
> during=0A=
> probe.=0A=
>=0A=
> 2. The new thermal profiles where used inconsistently.=0A=
>=0A=
> This patch series aims to fix both issues. Compile-tested only.=0A=
>=0A=
Thanks for these patches. The first one I already tested with the same=0A=
change, for the second one added Casey to check if he can give a quick=0A=
test for both on the new Asus Lunar Lake laptop.=0A=
=0A=
Thanks,=0A=
Srinivas=0A=
=0A=
=0A=
=0A=
=0A=
> Armin Wolf (2):=0A=
> =A0 platform/x86: asus-wmi: Fix thermal profile initialization=0A=
> =A0 platform/x86: asus-wmi: Fix inconsistent use of thermal policies=0A=
>=0A=
> =A0drivers/platform/x86/asus-wmi.c | 74 ++++++++++++++-----------------=
=0A=
> --=0A=
> =A01 file changed, 31 insertions(+), 43 deletions(-)=0A=
>=0A=
> --=0A=
> 2.39.5=0A=
>=0A=

