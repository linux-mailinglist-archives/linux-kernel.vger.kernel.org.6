Return-Path: <linux-kernel+bounces-325748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67ABC975DB4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 01:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24971285D5F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 23:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC381BB688;
	Wed, 11 Sep 2024 23:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hO0Cw1oN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CA2149002
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 23:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726097401; cv=fail; b=o3LKhoUPdno6mhVxzfN2M8CAAjtirA4tXn9YZLjehj4dxbpyFVc4fi5p25RydNw9OyjxshGExzEG2U2DOL6eIwHaZotUiBenSNlkeLtz1GA657oU7dBmZJxmao5nfizOshI5/mMLgW1e5SeSf2QZkg9AklfQjI6G0j7ziJ9yWUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726097401; c=relaxed/simple;
	bh=tlZMBLom8TLlPqo0V6IwIUBL1KQw+waAoWjFqdyGLlU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=im9/CQDiXBHaFndDa3j8IhO6UJhEoiYwr3z9VXTWyFKLhJi9W1bnskSzeC+RFueBtotMSt8Jb9umZwQIlEz8z1rm153r5ixdmThgeZbwTATYCJDJTrNhgF06aWsEwotlqkZVf4i6DQtem4+DlpkOOtvUkLHA15AJ9E/0nZcJl7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hO0Cw1oN; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726097400; x=1757633400;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=tlZMBLom8TLlPqo0V6IwIUBL1KQw+waAoWjFqdyGLlU=;
  b=hO0Cw1oNVWWD5szhOi6AbU9ZJsF0IgN55WanelX3LRTx4dDl/TdXr+TE
   PCbqnN+X2soyyg3ZYBlEl3cCEhQTpuajrnE/NL7ZftVwBx0jgFger7k/p
   KVggifG1GXjshQ9v68BB80WXVL0M6AN67xJkbmsC6aoI2LS0S9a3kOncN
   IcJmRoDbNJfwfA6Zwc/hfmjEn7/yEK+fQbT3AaPV2hr/f+GRQizXCg/nx
   JATjG3AeXLpUWwojMi2KE+NKBEH+12EgYW6c37iUXyjhc5YUBK/8Xq+c3
   JUcKYoXWX1b8/FjZ4Zz1ZGl8WlyDmwQ2BCcuMZtFS2hDfejiP7w4geO8K
   Q==;
X-CSE-ConnectionGUID: RslELLweTgqaUw2mBA+n7w==
X-CSE-MsgGUID: QR7+IsIzSeuSZOMpifCHPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="25086638"
X-IronPort-AV: E=Sophos;i="6.10,221,1719903600"; 
   d="scan'208";a="25086638"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 16:29:59 -0700
X-CSE-ConnectionGUID: WYoDi7wZS46CcoDZjuKwzQ==
X-CSE-MsgGUID: b+PJJZzcTkSjPUnua0btpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,221,1719903600"; 
   d="scan'208";a="71903929"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2024 16:29:59 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Sep 2024 16:29:58 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 11 Sep 2024 16:29:58 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Sep 2024 16:29:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DQSmESJJwOorO94WTeG39KilsDmBLKvpjXhOKOyWVOjlmqI1POEB9ZeYkCqnfc6yDVXBqY3GEXNg2sSCJRGjZUyV+tDr0rmA00GkyCXssGgY+A37GSvKOZMuSaX9yYzEbMghWKDZFPIvq/RC7qhdawkE65VQIH61u7Cfde8C14uPmp0ZJOXY74oAhNq2UiYGcpSnamwUJDHaaiIaSe/vNkXwGlxTYz79RBentXFZYxyPXy7olEWFdc37L+PstLFGk/Ff5E18Ls2uau1dGoTPM/bKGilyaq87HbEUCSzBpMdUbqp35Dp7Mz1s4H0SWvTSAIKXiuz6u542j83E+0gJuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q67+iGi8z5U/HtEa+e2dZ/wx1Utte9WiPxtUL1yIgVs=;
 b=U1CISWydq3dqwg2No0cs++FeAMhML/l4oAMRoa9mXcHgaLQTj/FaB2yhkiRHwXxWOiYw/9maiKe8dnuJAIWl8FD/PowX5h22Mhcgjt5cAiUMCaIDgrvQCBoCJDZULrV6lA6rg6/76dk27sEcPbby8+6NSkIl+TM0SxuRYTObqumhpBmuzMG6wYkmTpgFNTrpYBspoCNZlUjSrrvKE8w8y56L+w5SRY72jC6kMGM0XDFyY5TcszuEB1+k+F5cHdEuZz5YfvzGHWRhSwPBhkxA5Sdu+B+HThg0udTDBxMsiYAhpW/dbgqoNtMOeh3aJZbn0+hIFfaiqBXlhh/sJ44Egg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB7742.namprd11.prod.outlook.com (2603:10b6:208:403::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.33; Wed, 11 Sep
 2024 23:29:55 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%7]) with mapi id 15.20.7939.022; Wed, 11 Sep 2024
 23:29:54 +0000
Date: Wed, 11 Sep 2024 16:29:51 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: James Bottomley <James.Bottomley@hansenpartnership.com>, "Xing, Cedric"
	<cedric.xing@intel.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>
CC: Dan Williams <dan.j.williams@intel.com>, Samuel Ortiz
	<sameo@rivosinc.com>, Lukas Wunner <lukas@wunner.de>, Dionna Amalie Glaze
	<dionnaglaze@google.com>, Qinkun Bao <qinkun@google.com>, Mikko Ylinen
	<mikko.ylinen@linux.intel.com>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <suzuki.poulose@arm.com>,
	<sami.mujawar@arm.com>
Subject: Re: [PATCH RFC 0/3] tsm: Unified Measurement Register ABI for TVMs
Message-ID: <66e227efbbf86_3263b294ba@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240907-tsm-rtmr-v1-0-12fc4d43d4e7@intel.com>
 <20240910170959.GA213064@myrica>
 <f6b0a1d2-c730-4b20-a8f3-afd9a7cf822a@intel.com>
 <14fc2ce22d224f05f4d382cd22f5242297e9fb86.camel@HansenPartnership.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <14fc2ce22d224f05f4d382cd22f5242297e9fb86.camel@HansenPartnership.com>
X-ClientProxiedBy: MW4PR03CA0116.namprd03.prod.outlook.com
 (2603:10b6:303:b7::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: 8397277a-7cf2-484a-831e-08dcd2b9a425
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?Z2hLadxImmbnDhzqjN3AEZ0jeNPd/j+CU/VG3WtyZPw8ywJjuUBPA57Pwj?=
 =?iso-8859-1?Q?daC8AkPZCrLWqz38hZnTu977Fb+3C5nDc2R9DsQ0LDl5eiS+IAky2FIOmE?=
 =?iso-8859-1?Q?W2MX8FVxOC1bHur7wS3isG8CkOQC7Y8gP+tsKCzvntBcjyDIyxSW9HlGcm?=
 =?iso-8859-1?Q?SahsDSUVKLgPviFG/Aj6HwL9x11yP0TPIFoTDR8e0OaaLFxDL+s6B96M0B?=
 =?iso-8859-1?Q?XrP1wUpqYplGvO7X/wfqG5bWjZ3oJ3NXWSIcvXGAFK17tsIkY7+qrtyPmd?=
 =?iso-8859-1?Q?dqyeve61uNPxkJrHanv0jYmyRur4jh7s7tTJg0roE4LkgVcsEaMvLT2Bf6?=
 =?iso-8859-1?Q?xd0zR6dJ1e1bOk+w1bey6yrOPauYChNx6JzeMBVq5dmQ8JjJyZJOlAIMgf?=
 =?iso-8859-1?Q?hzscveRcQRnL4n/9gLd3ogfJabbx8uPJ6IH0It9NuiXeSlR1tsU7kQs/N+?=
 =?iso-8859-1?Q?xYIWBsPyyHjvuspAVDmoS8Dt5IRPrg3PID/y4uK/tNkWZzJQGvFFNtNlHJ?=
 =?iso-8859-1?Q?LbpvvDIw4M86wnIX8+b8wTk3nfZjE2/IN3cQ0XdVEbMs1FyHlJPjw+oChR?=
 =?iso-8859-1?Q?f+X4/40gRkV0MwZQ/oQJJIKizfpls0Lm+OByUKzAAbUC8pmVxawHeEMgXO?=
 =?iso-8859-1?Q?dESeCItNrUCDSyfvEL/RMz2yQO8EkvSSP8b/qbs9vkuXh9VNPs9hfhySl8?=
 =?iso-8859-1?Q?qllfHENSQe4n7gwXDSwXpNxVQ2lfGyRGqMJE5l4WZkw9VRvJulbiIYGtZr?=
 =?iso-8859-1?Q?YJJPSu9XPqXvjYFmvon+GAP3dk8BCviMn+SUCUA3tZLgVuz4sCe+Ch4wUo?=
 =?iso-8859-1?Q?RCCCe1bXhkvCK8OzRCrDDjK6ILzHyDWfeVg0hYgGtQ5fSCOU8+AT1GNB34?=
 =?iso-8859-1?Q?bMYtGKzel7caFlwJ1miuMToI/cF9Af+4ThzDCfEH5cLIrcpFdG6AFQXOO5?=
 =?iso-8859-1?Q?YjumcamZsfCB4xFpoFiITos25cyn79ZkdcXV64//1URt39l8TNRrkUESTf?=
 =?iso-8859-1?Q?GcCyiF8bSME1emyeRw1hQMA0H+AseKAMMBI+IjcxIqnAfAzot4HakprXOO?=
 =?iso-8859-1?Q?vsuWH9qYORDaY8cl/Q8PSJNTIuzPTjPEB/9etmHjDj1JovJUSQrLgY5r/m?=
 =?iso-8859-1?Q?EySRJMCorhkLgQfJwRpCp4DPDQHFiaexRv0l5vQxK/8mcHdQNSpagiXyEK?=
 =?iso-8859-1?Q?ek94higaWG5E0WgLNyOW+7IJxoMUY3hTK+ssaVJVkUh3oL7Lic1Im9uNjL?=
 =?iso-8859-1?Q?D9l2RFX83Oib8phsqjWZXN5OMzYApNTPZWiVNHOSwipUMBGdwCK8CB4ZGT?=
 =?iso-8859-1?Q?y/CHiR67LuEZ8Wl0HphhvVg/wDspIMGl51OAE33KXvA0qkiEG/KU3M5Z6y?=
 =?iso-8859-1?Q?3yi8qB+R6zE53FcXFTrD91srxxK+Q/ENxBFNWe8vFhBXJnHpXaIwY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?+GSStCroMI/T3metsxmpktKDOMSUMw8pFqKGKAqGnUItxNegoCabksGQeI?=
 =?iso-8859-1?Q?1TPfLANx/mCC6O8VnmcuBJmBRz6en1yvO2yzo9Tl111sxJVFRdUFk+CP/6?=
 =?iso-8859-1?Q?QikYkQhAFUfSD/JukWw34Q5ELopAM1vS5IDPBMBLF/fL/BJV6fC30HFimB?=
 =?iso-8859-1?Q?1qQ3+4NDzZ0CWN2kbFrja7MGUoslM4/HVhf44bGcPkmMJFgXSNbKa1UowU?=
 =?iso-8859-1?Q?eOUQvjJcaR5SFipxEd7qcNxUgDqr/sGN1p5YKmbdrtPSbjcgco+lHGS/L7?=
 =?iso-8859-1?Q?fCmbW0fFbWfvblYTzarsxQoouidMEAH2LgewfH51YlwmVgVZU/u1tMuKK/?=
 =?iso-8859-1?Q?YYfa5zt331lk96Lcyz89TbYg8w1Ru/Vkwmiw7K5Z55BAkskDxdrj6lqPKh?=
 =?iso-8859-1?Q?QWcO/PPWiV0FdS6phAy4IsgWLL4cD1jZNOLQ6vunocvQxhynaZkHta4fd7?=
 =?iso-8859-1?Q?FCS+wD/OwzsTlSnWT23buH/wM7y8oq2GN4aime9v5XpKJsqB4nuDhgd9gl?=
 =?iso-8859-1?Q?R+a5XzSW3QDik1TmWTUWqOCFNFSXoIw7WjiOVJEQeqfz2y2T8eW7AqdTXx?=
 =?iso-8859-1?Q?gVkhoIT06JqJ2ssRftS3MIB1AX9Ggscwz/MaVQ6F7xI/JS2/yR+LjAntlf?=
 =?iso-8859-1?Q?GNmn1+S8TNSMUaj2H9U91vwImgsmbGsHOTnH6yuAJffvVZxV8XnwLTRZYp?=
 =?iso-8859-1?Q?953R2hRF9g5Ko+SE/qEkkJY9g/J5xxOApN7jFwRUwO9yh1Zw58fp1jjZ4g?=
 =?iso-8859-1?Q?0QgPuWLrOC2ETrofbJyg8LcJEPbpi8Q7YemAW2tfVVQfo33qe33XB7PXDJ?=
 =?iso-8859-1?Q?f7sJEPmHDcdAA2HRJE6/6FtW2HLPFBeZODivYf/Ag3tMIT+cA1oJHKBhZI?=
 =?iso-8859-1?Q?bBJpK0D6g7b1TesMbQ5Fv+d+pOG3N9etdZOx22rpFUZgCNkPl9Vhw4c7cE?=
 =?iso-8859-1?Q?c5GjRUutRLSb647Y3LF1kw2QP7IytRRjFaaAPDgGW3bp0RSBj+DZWPePZE?=
 =?iso-8859-1?Q?eSHtyk+DiNC7izJGXSfbZQiuTG4uLeli55yhFDT+a6wIyxtl1UPsyIIFo5?=
 =?iso-8859-1?Q?9bBEvGDN1OVXz5t0UyoKgpUhHI9kv6QvoLMEQgF4AwshorQYprTiyD2TuH?=
 =?iso-8859-1?Q?/yXf8iK5m9eVegHOxQqOb4GsUw1eAsPrY0TvfbCaJAp/d2DSMTZdwu72H/?=
 =?iso-8859-1?Q?2H7QwMuz1uxAzjbWNIa+z25GtrLHOlC/0noST+3jK1Tv+yY6i25ACpM5Na?=
 =?iso-8859-1?Q?14p4DPzJcta2vhxfw2ez2st1hggH4r2Bd3NXjThZmz85pl8PwP9glKtgTO?=
 =?iso-8859-1?Q?9oSZX4oavHAVu8PxVi98IgAe4uSLpVP3PuhLym+eXIfxWhY8Ytu5q31SVu?=
 =?iso-8859-1?Q?8xT1t08usUOqtye4au++7cVPWshy5SmYyDe5klCofJukfqwjCqSOdzyPHj?=
 =?iso-8859-1?Q?KX+onWdX4bazt4pFFy/J96kEoTxiP9AWU+RiycNUVlvTZ6CMPzmF/RTM/d?=
 =?iso-8859-1?Q?GQZ24KBGM6pfqo0gZzq5PjpJP2tpWr+9s8K41sR04/FkKqNZgHJkaEMG8n?=
 =?iso-8859-1?Q?ARits66C21LGmTxl5s0849XFpIxFjGe2zJbzp+1TBROLR/nEQhEhzkxgpv?=
 =?iso-8859-1?Q?EdfHVfgXF6cVPa/+cFTq7qr5byw7gWF3Qdg8KEwtnLmiW1kpdw2n9AlQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8397277a-7cf2-484a-831e-08dcd2b9a425
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 23:29:54.6064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4dNBZDf/XnfiZqwvZDRdmb8A6iKyPErMJd/tcHQjze15ZU2lTyBr7z4KgKAI+0KQDRd4s8Eap4FypDlJkShF777iehYYCO7Yy5nbZ2R3/0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7742
X-OriginatorOrg: intel.com

James Bottomley wrote:
> On Tue, 2024-09-10 at 23:01 -0500, Xing, Cedric wrote:
> > On 9/10/2024 12:09 PM, Jean-Philippe Brucker wrote:
> > > Hi Cedric,
> > > 
> > > On Sat, Sep 07, 2024 at 11:56:18PM -0500, Cedric Xing wrote:
> > > > Patch 2 introduces event log support for RTMRs, addressing the
> > > > fact that the standalone values of RTMRs, which represent the
> > > > cumulative digests of sequential events, are not fully
> > > > informative on their own.
> > > 
> > > Would each event_log include the events that firmware wrote before
> > > Linux?
> >  
> > No. The log format proposed here is textual and incompatible with
> > TCG2 log format.
> > 
> > The proposed log format is based on the CoCo event log - 
> > https://github.com/confidential-containers/guest-components/issues/495
> > .
> 
> Given that AMD is planning to use the SVSM-vTPM for post launch
> measurements, not supporting TPMs in any form would make this Intel
> only on x86 and thus not very "unified".  Microsoft also tends to do
> attestations partly via the vTPM in its L1 openHCL component (even for
> TDX) and thus would also have difficulty adopting this proposal.

When I reviewed this with Cedric before hand I had been convinced that
this need not immediately trigger the "TPM vs RTMR" debate. Cedric can
jump in here where I get this wrong, but the thought is that once we
have this native RTMR interface with a cross-RTMR-vendor (Intel, RISCV,
ARM) common event-log it can be used to build virtual RTMRs / vTPM for
applications to use. In other words, use something like vtpm_proxy to
provide TPM services to applications, but proxy those those events to
this native RTMR backend.

