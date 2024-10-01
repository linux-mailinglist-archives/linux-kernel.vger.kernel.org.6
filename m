Return-Path: <linux-kernel+bounces-346490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B22B898C545
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 20:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 470421F21AA7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F491CCB3B;
	Tue,  1 Oct 2024 18:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N2UkhBDi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9121CCB38
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 18:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727807066; cv=fail; b=KajyWuoGinhMVtZsOlQLPG3DS8qEXOgxK1UQ7d0+uKkUjtwVeEaNxO4XWWq5s6hzSJ0wmyiWKJmKlBSgPcxTfwAMzb+gLeQa+pE9ZE+qIdpNITJSj/zP+iZ7ovv348gTUP04RLoEwV8dTa883p3lKGHGIZVvB5Kp3yzo9m0yWc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727807066; c=relaxed/simple;
	bh=eqItd0IJidX1JF87YoA6RwhNITDdNP7gQEhbse2fuCc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qclL4x/ho154IXq9cqKjj0uksrXN2aIKHuq6P03A/UBLR0YWu9inOY72W0w+QeZqdNc8Onmeu4g2Hn1UQDDqYFWeE44PMPWwAaz861u9lPm7w8bLaZfuttr5dbQUkuQMNfIXobIcF4L2dcDTeQ1X/Ia2Pg7j7ruF9RGFhZZ9GHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N2UkhBDi; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727807065; x=1759343065;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eqItd0IJidX1JF87YoA6RwhNITDdNP7gQEhbse2fuCc=;
  b=N2UkhBDio1MSJr9Ry21bljDbaH012R4OwAitTft2eznL1FWaLf7Y2EpL
   VlxCeUiNB6gm15hHiQweu5EmNutdcTZaO773Udo0r4ZSk1z3Wu2oWKUoK
   0IvjZR0Bq5fuSNOlTo8Iuobuf0dfVf689tYukZsh8rPWDOfCFazx8o13l
   KlA7VikVvjTwLknxwKvXvs05W+ltJ6w+t0WSrHcx0Z9Qq5N1D53ccdnCf
   0coSrDGrn4kNLGwmTxyC+J2IVXUxMNMnz7LXp9zDRb108Wg5b4NE1VcjE
   3oF8uWfFYVvOZU+gIi/to0hgg3sYLKve07Ko/um3nEkRXT25i7G53bmIm
   g==;
X-CSE-ConnectionGUID: Km+aIqRlS+Cux+bK571i1A==
X-CSE-MsgGUID: ZTqGz13PRJqDCITd2+lE3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="49481960"
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="49481960"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 11:24:25 -0700
X-CSE-ConnectionGUID: DRAfKeYVSG6byWHjjZ88yA==
X-CSE-MsgGUID: 3boDOdKLQD6FOihqNQugIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="73794147"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Oct 2024 11:24:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 11:24:23 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 1 Oct 2024 11:24:23 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 1 Oct 2024 11:24:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJ+0JE2tvBBM6CbdtnHo7cr93QsLT+OOmHgQDgg3Hd5w12QIebhJpmY+tnJ+7wPfQCdjXF7WL261xMwrVmHKZ3J5fs/1QWiwCkjtp/Lvdu6mKSh5Nsji/qfDyN+E+K92I5Xcz4f0H8xKAkaQc+fOQYSfnNDZbgBL1R9jxX8hN/PvEX93Hmh0kP86ThVT10ZCQR8keKuW2fnAQscSDQ0ZzqhLnw59cFq/nd4KT5vjkS+WfbyEN6j1SpPr49e+ae7kRJ2247bwDsuZ0gNyd36mUf2n5l76gE1M3j6hoSgFq6qMouQci/0datuspBuUqbLPFNgr/Dr+NCFS2IqVVdrS4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqItd0IJidX1JF87YoA6RwhNITDdNP7gQEhbse2fuCc=;
 b=TroE7xViGa2oT+eoBpFw+nNYGTLP/W9rKgr/bTLfBxCDwTck3ZtNb/vH18gn8yaQAlbp39qWuylW1NdJ5Q93Cb3A6HTyqYnumv2vZ+yXfPqb+pkRj5RHRnAdLj0Au4Dm4caBsn91npxmmBN9KLlXwWdLKqvZXUQqn14Uxap/AwN+0xJa1JbMa1pH9h+jALBBqGUBCmZpols5rtEXYo/+d2NRThcl7Qrf9nnBz65zJPpKKytDT8x/oEyO8fS0yVXptJw8GoL3+4TIQij8Q8RBWrNdwHSroUytuuIUrPZD8dtwgm+QKUaNhVN6vYUDTFl6+ZLnmm3Og1zLLAs4SbR+Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA2PR11MB5001.namprd11.prod.outlook.com (2603:10b6:806:118::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Tue, 1 Oct
 2024 18:24:20 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%4]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 18:24:19 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Meyer, Kyle" <kyle.meyer@hpe.com>, "bp@alien8.de" <bp@alien8.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC] RAS/CEC: Should cec_notifier() set MCE_HANDLED_CEC after a
 soft-offline?
Thread-Topic: [RFC] RAS/CEC: Should cec_notifier() set MCE_HANDLED_CEC after a
 soft-offline?
Thread-Index: AQHbFCw1aTFq/7mGNEaDy6BzPGWq7rJyMuTg
Date: Tue, 1 Oct 2024 18:24:19 +0000
Message-ID: <SJ1PR11MB60833BFA53B5E617C526828EFC772@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <Zvw5SJQwBB-xo82K@hpe.com>
In-Reply-To: <Zvw5SJQwBB-xo82K@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA2PR11MB5001:EE_
x-ms-office365-filtering-correlation-id: 98cbfdbb-4e2e-4c97-0332-08dce2464435
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?fSMmewX0b3Hh5UTJBgOjzeJAODdtF0xTzmVjowuX95UWgidm9e2/O3C3bgXa?=
 =?us-ascii?Q?uPhwG3AUgCY5L5uvfJaXbL2NjR0ixR74ULonvEI8ra0BBV/P6EteK6viU7vU?=
 =?us-ascii?Q?xJv09UThIBf4v2baCE+y8KfPxwum3pF2EM9lanCC3Vr+BkAL4WH1yq+QDIqu?=
 =?us-ascii?Q?+U/uJjn8MFwDhOO7/e57GqlvQp9LTgwxlx5H//IOFfUopyD5sq7UWcYD48NY?=
 =?us-ascii?Q?Nd7Gttlx6GURBsmB0O1yJ6IfiLyqM5aadFEcM2oQV8/eDMTP54rTR3kY9RWt?=
 =?us-ascii?Q?iMzOIyaSjaAFhDgzrdd2SM0w0Z7Pc/1/Pez4UHrAgZr2dOdFrzjuO+ZMoBiN?=
 =?us-ascii?Q?fHmHjXb/wuDQtiFse2B0sojQ1rd87pPTeu2+HsqkJ7cNHRrrGIm5SS5wOayL?=
 =?us-ascii?Q?+k7zrruwmLtjuK1Vchh0cd+dI3iGpXCpUn6l/u2hVUv+1bFCt1oRGH2qVNDL?=
 =?us-ascii?Q?iOMnMq7oVAiwIKFHesVt/FvSldlZeoaoU7g0eZ77tVRh3dzhKkWWRxilsgVZ?=
 =?us-ascii?Q?HNMo71QjMqWYQ/zLs6s5dAWuZPhYe6a1MxWvEEQHBY5pHxz7hDEoZjCXX15e?=
 =?us-ascii?Q?CyXZyaA1lIe677svk0VgTxjZI26Uipy0ZVowpzdn3ID0g9POaCcc+lUv3Dpo?=
 =?us-ascii?Q?I/b6hJXNsXNV0BbUM0nPJiV/CarfOm90Cj37aK+h4xi2OXStnqbarI92AApK?=
 =?us-ascii?Q?/k67cPklruglezpVczi9HqHFUCuPCu3yZPWdL/QBgt20zHFvlih7ophMmv+9?=
 =?us-ascii?Q?V1WrgxPfqRZDHcMIvtBsT6h8KSp7YHdW88SA/Xspe41hzYg9uihInqBAsNUV?=
 =?us-ascii?Q?X7N0Q/Ch3l6QS9D8qRIOcOg5//GcH0BGZ6MbWm7vh/SgwyvkdCs2GesthoV2?=
 =?us-ascii?Q?c6gEX6bJrU0cLWGqAKn7y+0jsw22nu5Mu1SPrF3FqOAYdmkEktbeqiQ6yemF?=
 =?us-ascii?Q?IJbDaRvgBywrxe90Hq7j5gChXUwwlwhqq4RXAetaEvtLsX+HZ/LnJgnLHfJZ?=
 =?us-ascii?Q?1B4x14bb8ljTNV8qrauA+H5mF0VdZDKkGm9SJGsZQWFonZfYHzFKF6tvpiRc?=
 =?us-ascii?Q?CWzjGTtFHKFunT+JUioj09G2/6F/6QaslC8EbbW3Bh9XC6C3YUFg8N2pRyvy?=
 =?us-ascii?Q?WyFLqd4UW77TX8XAgbe1/5z9fJZZ1ICQ3TH0UTyHMF/KAOSdkjag9ReemBHS?=
 =?us-ascii?Q?/p5qRdliS68hAl41+oVOIsaJmz+wb/rmz6oACW/LSnslCp7sc/iE9LTQ1crk?=
 =?us-ascii?Q?Gjp96/JTki/Kfs9sCaUYnblO0/NG73k8YwBbkZdxFH0PHVvt08mAPhnRDrbF?=
 =?us-ascii?Q?5Rdl3QgO6Mdjd9cdtppdbKXHa4koTTzMKw0SaM6vrtJGYA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0/c1zqlPFWHrH735VE63O0xFTFP6iJ34evk3a3k4WXY9IVjFrwrxGCgd50vO?=
 =?us-ascii?Q?3EoETaIMZY2kq5cgWVmMY5SEFxdIpuadm10MkAEqF7tIln22oLQDwTGpC0fn?=
 =?us-ascii?Q?sTvwCy0SXFK4+5277nAt9BZxQ25X9ojobIk3D5AlvHTkibvSSSOGFMFBzXfx?=
 =?us-ascii?Q?ZOLPadhs37+X3VUebcowX9JQQy0GQHfFTyb18N8fLzUThrWM7L+TTMP89ODt?=
 =?us-ascii?Q?RW/sxeNVNtkE7oMe61ZPxSRPfBFX3W6SriEF9D09tKb/Ek9gSM9zztVW14Vd?=
 =?us-ascii?Q?6+uWjNOZaZiYUTe5nWayMfTSEsE7Dm+aAEbaSYBYo6mWR4NY2uvF2MTJCTij?=
 =?us-ascii?Q?DoWmFDzHwL/2NKAnd9sQE0Kb5y1dK21Bux1HuhgoMJPv1m5BiAmHbIHPlYoZ?=
 =?us-ascii?Q?3TsmCvZk17A7nm66v20Sztc7QpKAqUGBLIkf3CjUI6i6gooq3lPd/l/L7lg/?=
 =?us-ascii?Q?X94IDBn3JCCvAGtH6kiSRNImZFz4VQigHFPwW8CVSOJBYbsRH8wkB7tPGDrX?=
 =?us-ascii?Q?y0vVi+d2ShgZ6dwG7k8FTPG2iBssxCiGfZy6+RolxtxIyQ12ZNpupcDUHxvX?=
 =?us-ascii?Q?GFWcN4Pkoon+0CoqGJJQB0H/suvBebjTAacU3vCsW8Abnf8KCDM7ELaGzGhr?=
 =?us-ascii?Q?jIRVMVVqlmBLmFTrE8fi/Kr+OX9IwH7H0SviDIU6dg3l4E+3GsUbLlWHFYMi?=
 =?us-ascii?Q?2ezfIsB97oEV5K/LPxVUzy917fubuSymGnn9iZvA5KKtnZFbaRB9ilW9Zj24?=
 =?us-ascii?Q?/Fj6KmHvmI1wD+Lk1tewzSUyNfyai/cs4iK0df8Yaf9LU0yImv7KYs+vClV+?=
 =?us-ascii?Q?EjtkL3sdGdWMYMHZsevGLZt2Ub7T6Wvu2P5cciBtKujtcgkezcKQ7jiVadpM?=
 =?us-ascii?Q?MdvQ2u15UoruIh4MKt278PmegX/+mnX7YvPuuzz9bPCuLWk1bzfmgwx4jt18?=
 =?us-ascii?Q?l72PCDdmloqqnSsoHTL8Q4m7nihkBTi6AQnuZ/vbsJ7vMpVzGFPxRF7cqP/D?=
 =?us-ascii?Q?5wI89cVfz15cIhR3zmYy6Ed5ZH2lorGMQLrJL5JO9jGhpG5MSzbcfQGnZydv?=
 =?us-ascii?Q?4HCbpbjpD/CyIIN0Xo5HPTR6uLJ8k1vP/FwxrdTjUNE+2nYdT/nsuV5Ezii4?=
 =?us-ascii?Q?nfR87+ecRB+4MFAwbQKjhcO7CgbVbP82RkklKKqKg81J+oSSsNkwpQUkYvl9?=
 =?us-ascii?Q?89Hy6mS57hAFf8USN7XDUPWHhTBykLyQ8QReXPABo6U9sbKGARM8b8jegHiB?=
 =?us-ascii?Q?Js+hB4G3HP+RLflHaI1R0Dl8fbqotaQlOWqgm3rHhFcLODDmu8QxB8hYZuFF?=
 =?us-ascii?Q?KjcbTGLu9sFQTJvK7LYIo8HaugXQ3dHXx9MpocEbutmgh+S+1/va3HsMosC4?=
 =?us-ascii?Q?C3wCEXvXfcsxuzmxNeBKnLgEmq1lFEYjhRDEQgiz3f5uX7XJkOmN3sbcEFAL?=
 =?us-ascii?Q?30pj0UuS/oiMLPPnY9TAJbmA1PG61VRn/x2Al5Y6jARz522wp8kxWAx4owyG?=
 =?us-ascii?Q?6QX9cXK+Ooss/E0BbPtnTPSo+TDZ+uGsc3SravLUnA7smCcKOBDwWecQiRA3?=
 =?us-ascii?Q?ZHURPCRfkDH/i+Gz1VG2RWowgD4zcNSTsRGP23f8?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 98cbfdbb-4e2e-4c97-0332-08dce2464435
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2024 18:24:19.9231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TSspeIkSCh37LAcT/DG87uox4RYvXpQVbJ0jMsDmxUOiAla2wr6sE6NvLW6p9pHFOzrebNaM9TChQtIJlzOFEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5001
X-OriginatorOrg: intel.com

> I noticed CEC should indicate whether it took action to log or handle an =
error
> by setting MCE_HANDLED_CEC (commit 1de08dc) and that EDAC and dev-mcelog =
should
> skip errors that have been processed by CEC (commit 23ba710).
>
> cec_notifier() does not set MCE_HANDLED_CEC when the offlining threshold
> is reached in cec_add_elem() because the return code is not zero. Is that
> intentional?

Kyle,

It seems a bit murky. You are right that cec_add_elem() appears to expect t=
hree
different actions from its caller based on the return value being <0, 0, >0=
. But
cec_notifier() only has two actions (0 and !0).

But I think this may be OK. The main purpose of CEC is to avoid over-reacti=
ng
to simple corrected memory errors. Many (most?) are due to particle bit fli=
ps and
no action is needed. So setting MCE_HANDLED_CEC for the case where CEC
counted the error, but took no action feels like the right thing to do.

Conversely, if action was taken (because this was an error that repeated
enough to hit the threshold) the we do want mcelog/EDAC to give additional
reporting.

-Tony


