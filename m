Return-Path: <linux-kernel+bounces-208866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CCA902A0D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 22:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5740F1F23FF5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8B64D8C5;
	Mon, 10 Jun 2024 20:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NbAFal6+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDBE4D8AF
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 20:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718052177; cv=fail; b=ZFgQJZlABZ4onydOO/f9nzPYT4x5WkjSyNR7GU7YTjiYRZZiJQ2kcKWX2g7SDrrSX7mee+repHWR0bI336l4reUEROI2vV04Tu9HBq6fbMwex7dxHysYag6eU8moMncxYLkQkG+twN7QanFguI6WEhvWm5JpF+Y2swyBumTyiXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718052177; c=relaxed/simple;
	bh=uIsbdytB6DyggprjNjX+VAD50PYi+nkdkCmNqZNaPyQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E0eG5fOBCC7xaRl2+c7pK4200VC5a3KqNNRzPL2zkLIPv8/CqFRZz5fWA5pHYnb8x5KmNsApji+aSsNxoqfhcS5IMwivkqiBoVZ+hODZyekHnB3Dubq4giHUQVjB8LtPPLXkGtQ+yWPkqJ1+kMGnXS//Uy6SHthZGFK1OumKqzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NbAFal6+; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718052175; x=1749588175;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uIsbdytB6DyggprjNjX+VAD50PYi+nkdkCmNqZNaPyQ=;
  b=NbAFal6+YrBh8QO28qeRBncAhoqfMB9+kcAw60kMUwhEDJJ1OQthzpYq
   AAO1ktcLgXNwF2PZY3mJOQQNtb77Vj4Eet/hnxfkBy55ylvJ1K1zfz2LW
   ANYMz+I0LKdolbkoN1QM81KTWTxqkJVrrR1gTpTw0urzbwm6H68oltCIC
   C2FncWplS1Z4kMyZYZz2QXdgTIJPz3s+XbxHlYKL3Y8MFye1IhOzT7Aje
   FxGamWb0P50PNqSwWXurccFgiNhKeO52sL+ZA/BsX2AWYRWfEODT8zIDJ
   wcINhovIt8uUxFajun5isZXSdD+zrahDuTraQ8iQzl3cNKUKo/UPidyBC
   Q==;
X-CSE-ConnectionGUID: 6IbBmQD8RCyJr0dio/bTMQ==
X-CSE-MsgGUID: 6DDpsqTKQMu6Ev0/GrqLsw==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="40134517"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="40134517"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 13:42:53 -0700
X-CSE-ConnectionGUID: QpNHWgFpRxWSqNY8UB2wiQ==
X-CSE-MsgGUID: jjWK+WhhQf2nuZ6YwXyt3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="39177714"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jun 2024 13:42:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 10 Jun 2024 13:42:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 10 Jun 2024 13:42:52 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 10 Jun 2024 13:42:52 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 10 Jun 2024 13:42:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V24EMssWXuupC/sxe8il+DB6hDy87mcvhPg+YzGgfGm2ku7xc1oZmgely9axtFXp6o8MpNqUxaBeNxn7hwtZcJqw/Nvi/jesR05G+5+NjjSNBASvB5f8jZ9zqUZdKSZeQJwLinWLFVpfL3abdouoUjFjyfhFqVZmCe8tG1Q64lJP6BGCrFo52U2mv2If2nIGaWYe1AIyA1yU5u1UjO4vxGAB/8ci8xGED7lrhD6KzAShpp8qEPTicakzO9S7OEXLuxNzX7IzBJUucrauE8x5ymiQhNnmxxcJ86JDzD1DgRH8RbaOJhpVS5mQpHPxTnbTkyJvCvGXvdeax+gh0D2C4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WyRz/UdZoh3O2weD8bN9KBxYJ3UZrUnFtrXcaOMW89M=;
 b=i0uKOLpe8mtn+IWtNoGdLjjmWJye7RUP+PQLhmvXR/YnTyc1OYZYLownqsKFVgtzvldoqefipu6+iwLMPq7pxlXJ1rPvOqjJOeFEx/AutQJ6Sua4Efyr5/gP26vSM6lO//yxeGxxjj/nysB6kZcmgTdhpyJMx76jWALEmlQNHTLbCGUORGe5Ya5kNYxi8gXg4HmzK9qQPky5xwKy9DCICXfhVJt5ZWIj0IXnfqXjIcfaId3wqQqJPqxV3UT7dqLRfDOixItQN/YUgWLkc077ph5eQ95A3r/uHFjA9CpaxXYY7YOmnm0FseghZ07j1VFV1wMlxvarqhKL4sAmVKQsDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH0PR11MB5444.namprd11.prod.outlook.com (2603:10b6:610:d3::13)
 by SJ0PR11MB4847.namprd11.prod.outlook.com (2603:10b6:a03:2d9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 20:42:50 +0000
Received: from CH0PR11MB5444.namprd11.prod.outlook.com
 ([fe80::5f89:ba81:ff70:bace]) by CH0PR11MB5444.namprd11.prod.outlook.com
 ([fe80::5f89:ba81:ff70:bace%4]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 20:42:50 +0000
From: "Cavitt, Jonathan" <jonathan.cavitt@intel.com>
To: "Vivi, Rodrigo" <rodrigo.vivi@intel.com>, "Souza, Jose"
	<jose.souza@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, "Mukesh
 Ojha" <quic_mojha@quicinc.com>, Johannes Berg <johannes@sipsolutions.net>
Subject: RE: [PATCH v5 1/2] devcoredump: Add dev_coredumpm_timeout()
Thread-Topic: [PATCH v5 1/2] devcoredump: Add dev_coredumpm_timeout()
Thread-Index: AQHau1DoQu8+yrWKRkWaeVYGh7eCRrHBb2wAgAAGpEA=
Date: Mon, 10 Jun 2024 20:42:50 +0000
Message-ID: <CH0PR11MB5444A6196C5AC7D3AE960FD3E5C62@CH0PR11MB5444.namprd11.prod.outlook.com>
References: <20240610161133.156566-1-jose.souza@intel.com>
 <ZmdfCDCQSZIsAWOQ@intel.com>
In-Reply-To: <ZmdfCDCQSZIsAWOQ@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5444:EE_|SJ0PR11MB4847:EE_
x-ms-office365-filtering-correlation-id: 2bb70e78-7578-4237-35c4-08dc898de4c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?CgxEzmvyygFJPdak9n2ZNGbaxAsWuxER6NEu39mhqzWkB7rRPaq1l4OxL7?=
 =?iso-8859-1?Q?+TMkOS56WXQjStD2K3GQeGb84OJyDpsr7e7XYzcnrCHCDhJ25ev7/+K0FX?=
 =?iso-8859-1?Q?yV0rRr+u1I2zGnJBih85uMrAvCZVGwVWbCOi0TbA7vDGdhlUKLoWT25Qxe?=
 =?iso-8859-1?Q?V6kbIIBU1G0fjgF0LxXadBYdXEvF0A1bWPpBB73Dkgz0IFPueqiJeMZ5Nx?=
 =?iso-8859-1?Q?xK+GpWFVTsvaFq3eWq5EKdj0HiqfTjzOXvWlZ3JDiv7QoXEglBqU0F/uq0?=
 =?iso-8859-1?Q?F77dRlRTqfVMMIZKtQTzcUUx/jMe0o88GyO/cOArqMaVJ6VRg1amFk5ALd?=
 =?iso-8859-1?Q?6VoRpynnE+TTVfGd45S9T+H0+3HLoLUWQrEy7F/lfb/F969QQjVB9uXSi6?=
 =?iso-8859-1?Q?iKX93zIObhSxgbJgZBmojgjPe1RcROzIFYbs0tYTwAB6g3XXyOI8i663zy?=
 =?iso-8859-1?Q?gqafzHSqfj8amDxsHCeMAQrdsVMokoduNHQCEp362PkOFHMqi1CuiS9hiZ?=
 =?iso-8859-1?Q?G54Uax1Yv2vcsglHABCsp57QvJvXE64oO+nn4rTOAFVas3/fb1hTcM/bm7?=
 =?iso-8859-1?Q?7x8djWLoFepaukBGOJqkBE1vP2tela5XPVnmGB7z+sYH24iAljLcpkKs7a?=
 =?iso-8859-1?Q?EKqbXw1srzB47zn6JOZHxEDUGqtwsNIhHK6Qy/3Vxis62bc3jv23BvhKxc?=
 =?iso-8859-1?Q?ZT06FZERVOa8VXs40EY5EoJe/hJBb8AAxmVze16QGf7xZ4cgJfQUdqpM3Q?=
 =?iso-8859-1?Q?o/7dTkzsRc9a88mI5cPCFEm6erI6MuABmQm3Octmh9nmIAWa6Hvh1MZRXJ?=
 =?iso-8859-1?Q?QrMaGZArSiddjy71EIgw+6Ax0zq1Qg0eznHUUvmdVvLheVFTdIhOyBPYPJ?=
 =?iso-8859-1?Q?+K0i3RZYauAKI+USmtzRHxsDRBd8bSqRa4vic0+I4bi85WkUVbObjs407a?=
 =?iso-8859-1?Q?gi4LWuvdRHLZUwp+StOnEwKcdqUeHRiqjLDFdMA5AAz+IVQpxpBrCqonw7?=
 =?iso-8859-1?Q?H7IeY5GwFB+1Ee0k/y6wtigYbLrL8trH5fCOAw5QquskSyy93F05yHR5yC?=
 =?iso-8859-1?Q?SfonkI2B8ZRyWSzRbxvGPiEk0s910saSuqPMjSyNZpOMzOq/M7JMRQQ9+2?=
 =?iso-8859-1?Q?P/uoctk8cqSQQMEqWzrIqWay/z4/3xg/3SB6stRWjVO71vvao+htaG1PhZ?=
 =?iso-8859-1?Q?ZY9tvquIWIBGdbDA9v9y3cm1SWWHUx54mEjOLPn4ks3uMVz6SPXFDQNXS5?=
 =?iso-8859-1?Q?5ePzYDwdU4fzwsv2I8HOjxL6Y8iFFuJhUqH2WDPX3PwzxbIzLerjJ/VCaq?=
 =?iso-8859-1?Q?HL1q/IkmGky7bNPCiuoWE79PiuTGbN0nEkl161AHiAxiwf51+FR9xv7SIG?=
 =?iso-8859-1?Q?ZDhAqWoIV5nePDBqCDTUzJo09UJqF8LZqAx2zrHvvSOQ5XesxC+gk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5444.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+TqXp69oQ6INqpTt1jCW6l1HB3wdz/GKPAL6RcXNnSZzQ9pxfPhqt8HICs?=
 =?iso-8859-1?Q?KTUopoGyZnJMyCishgzFQfpC9f41qLikdlQ2c5dL0QujYpdl7x17KN91Ek?=
 =?iso-8859-1?Q?Q5tWXSJOQHdTYwHZQ0DKx4klrsy3yXcY6lcAF1ywVL6Wi4rZOaHQAzD8p7?=
 =?iso-8859-1?Q?PyRFc8ChX9KBAe+8BGHsYaD0EskcN1p6Eh3xo6HluIqZK7XRyspi/frmh6?=
 =?iso-8859-1?Q?YycfiIivoalr1hStxYvD2jsjoWH7AIDGNq5e4u/5ZKWY1G7PYb0eoMPF1w?=
 =?iso-8859-1?Q?H06Y1rf5ykpin4qpSuddyHwTjvWbHj5PG80/0k6eX+AfptFe13+IwX21/P?=
 =?iso-8859-1?Q?UQvTD26ho7YKMvzB+Gjnx/ALhPs8/EwFLqVq1JB9q3rN68HF2Xz4R+pYXk?=
 =?iso-8859-1?Q?fBjJI2oDpUz5GzSsOaL+f9rYCSjhbN5bR3485CwgKubNYRF5Iynzbt5y5f?=
 =?iso-8859-1?Q?DAa5/GeyCC4e4QTE2hYjUQdWLjN17TcatnvgUZMhZjIIcX9QtrKfCWQxUg?=
 =?iso-8859-1?Q?8ZprgywseHyYiGBmAlnRYSiwSRjClNBXXHG4SgXEGo4CXO+RCFsNK4IDSy?=
 =?iso-8859-1?Q?Ab/jDQ7ajdxLMoEC+oJLbTgBD3rl4/0NGCYCngtlkuNuDRtVcya1qt54Tv?=
 =?iso-8859-1?Q?Wbqt2Ql6WWBcA22lk5UzBu4ke73YhQ6Fj3dJCAzvysqXOadqMfiPT2CdMu?=
 =?iso-8859-1?Q?39n11OJ+SziGcWUNg+x/SNU7cd0BwI5Gz473dZ7ngDEUKpx7zV5/JyRhI/?=
 =?iso-8859-1?Q?mzQdS2M02pSYJvLlLg5C8p+94Ewlw+hU5gPLnugCItUJDwQJxuoQ9PWsVl?=
 =?iso-8859-1?Q?SH6KI+alH5gGbxLZ8f4FUDFkTM1pWGY/W7ooX7WCz4GOusTJVgZvuawkR5?=
 =?iso-8859-1?Q?8ohqNkWb3FJhpR0CYhVsN9Kzvzza3SH9qgSJUFQhx9h80ufw/lGBi1Cznm?=
 =?iso-8859-1?Q?sQs1v+ZbxJLClel+wbotiRmG1RyX+JdKq5kk3WsBQnW8bCze+0anMMnJk3?=
 =?iso-8859-1?Q?3qWfq9KxrIOme2QcEDQAy2o1qBfRWiPMfQuE8JrzpnWNMMeBsSnwcBx8iT?=
 =?iso-8859-1?Q?2PdkjH6akgIDAZQ+mD/NsSP1HcS0die6mjS+e2iv1lCjkGLw5K0iNlyjur?=
 =?iso-8859-1?Q?LIbREB6yTyjzMxYOOm14XOFFaVQ01vjKBx8KkSZwyDE1T7imlysEtMs24P?=
 =?iso-8859-1?Q?yBfQqqbyFPWR7bvg1wUARsGF0KUpTrIE63IYbqbSOnVVRBNBf/MIs0+Op3?=
 =?iso-8859-1?Q?N2KYvZVniU//7iMiNyLqSIfhkkcYmSJwihD7DItNoiP872VsE5aRhAFOKw?=
 =?iso-8859-1?Q?xGxr164bqYLnBwSKf8e788e/8Zud0Q0pc42nNoG1hCi6/808K2hji1uxMh?=
 =?iso-8859-1?Q?ieL6NTeJpIG4dR/ZYZGI4YnOi3AejKQ64EuoEUPX5U2ABUuP32kc0q/Ght?=
 =?iso-8859-1?Q?T8bVMYETOAs9Tt/CfvYkpBY9TZjYkslJFGwDn5nNXL1CVbvnN0xS+ukMDw?=
 =?iso-8859-1?Q?liN6h2sY/DqhxJnj+WaWYb8JkKRBirWCpU2zvIjqh4skcmIZ/bSGAm5SgA?=
 =?iso-8859-1?Q?eixeLEdqp2KYX0Gn1KYyBupU0z4ap34j14Tbbdcjk7KG7dJ06BsDMulksD?=
 =?iso-8859-1?Q?/npur+Zvb+7rqIPWePu/ZJDo4VpzN6P40oLjch9zsjg2nsvqtnPcfe9A?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5444.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb70e78-7578-4237-35c4-08dc898de4c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2024 20:42:50.0952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J2yW3aOyxQwCwxV/RH02ulMWGPvVHdiU25iAYFidIYOAfso49U6glUEMw869otCt/m6BAZEVVqR9wWQyZiP2X8TWpe7+amjSGH7wuS37T5Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4847
X-OriginatorOrg: intel.com

-----Original Message-----
From: Vivi, Rodrigo <rodrigo.vivi@intel.com>=20
Sent: Monday, June 10, 2024 1:16 PM
To: Souza, Jose <jose.souza@intel.com>
Cc: linux-kernel@vger.kernel.org; intel-xe@lists.freedesktop.org; Mukesh Oj=
ha <quic_mojha@quicinc.com>; Johannes Berg <johannes@sipsolutions.net>; Cav=
itt, Jonathan <jonathan.cavitt@intel.com>
Subject: Re: [PATCH v5 1/2] devcoredump: Add dev_coredumpm_timeout()
>=20
> On Mon, Jun 10, 2024 at 09:11:32AM -0700, Jos=E9 Roberto de Souza wrote:
> > Add function to set a custom coredump timeout.
> >=20
> > For Xe driver usage, current 5 minutes timeout may be too short for
> > users to search and understand what needs to be done to capture
> > coredump to report bugs.
> >=20
> > We have plans to automate(distribute a udev script) it but at the end
> > will be up to distros and users to pack it so having a option to
> > increase the timeout is a safer option.
> >=20
> > v2:
> > - replace dev_coredump_timeout_set() by dev_coredumpm_timeout() (Mukesh=
)
> >=20
> > v3:
> > - make dev_coredumpm() static inline (Johannes)
> >=20
> > v5:
> > - rename DEVCOREDUMP_TIMEOUT -> DEVCD_TIMEOUT to avoid redefinition
> > in include/net/bluetooth/coredump.h
> >=20
> > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
>=20
> Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
>=20
> > Cc: Mukesh Ojha <quic_mojha@quicinc.com>
> > Cc: Johannes Berg <johannes@sipsolutions.net>
> > Cc: Jonathan Cavitt <jonathan.cavitt@intel.com>
> > Acked-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
>=20
> Jonathan, also ack to merge this through drm-next flow?

Ack clear for drm-next flow.  Actually, you can upgrade that to a
Reviewed-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
I provided the Ack back before I knew I was allowed to provide
Reviewed-bys, or that they were different from Acks even in my
case.  I trust that my past-self who originally reviewed this meant
for the Ack to be a stand-in as a non-committal RB.

-Jonathan Cavitt

>=20
> > Signed-off-by: Jos=E9 Roberto de Souza <jose.souza@intel.com>
> > ---
> >  drivers/base/devcoredump.c  | 23 ++++++++--------
> >  include/linux/devcoredump.h | 54 ++++++++++++++++++++++++++++---------
> >  2 files changed, 54 insertions(+), 23 deletions(-)
> >=20
> > diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
> > index 82aeb09b3d1b5..c795edad1b969 100644
> > --- a/drivers/base/devcoredump.c
> > +++ b/drivers/base/devcoredump.c
> > @@ -18,9 +18,6 @@ static struct class devcd_class;
> >  /* global disable flag, for security purposes */
> >  static bool devcd_disabled;
> > =20
> > -/* if data isn't read by userspace after 5 minutes then delete it */
> > -#define DEVCD_TIMEOUT	(HZ * 60 * 5)
> > -
> >  struct devcd_entry {
> >  	struct device devcd_dev;
> >  	void *data;
> > @@ -328,7 +325,8 @@ void dev_coredump_put(struct device *dev)
> >  EXPORT_SYMBOL_GPL(dev_coredump_put);
> > =20
> >  /**
> > - * dev_coredumpm - create device coredump with read/free methods
> > + * dev_coredumpm_timeout - create device coredump with read/free metho=
ds with a
> > + * custom timeout.
> >   * @dev: the struct device for the crashed device
> >   * @owner: the module that contains the read/free functions, use %THIS=
_MODULE
> >   * @data: data cookie for the @read/@free functions
> > @@ -336,17 +334,20 @@ EXPORT_SYMBOL_GPL(dev_coredump_put);
> >   * @gfp: allocation flags
> >   * @read: function to read from the given buffer
> >   * @free: function to free the given buffer
> > + * @timeout: time in jiffies to remove coredump
> >   *
> >   * Creates a new device coredump for the given device. If a previous o=
ne hasn't
> >   * been read yet, the new coredump is discarded. The data lifetime is =
determined
> >   * by the device coredump framework and when it is no longer needed th=
e @free
> >   * function will be called to free the data.
> >   */
> > -void dev_coredumpm(struct device *dev, struct module *owner,
> > -		   void *data, size_t datalen, gfp_t gfp,
> > -		   ssize_t (*read)(char *buffer, loff_t offset, size_t count,
> > -				   void *data, size_t datalen),
> > -		   void (*free)(void *data))
> > +void dev_coredumpm_timeout(struct device *dev, struct module *owner,
> > +			   void *data, size_t datalen, gfp_t gfp,
> > +			   ssize_t (*read)(char *buffer, loff_t offset,
> > +					   size_t count, void *data,
> > +					   size_t datalen),
> > +			   void (*free)(void *data),
> > +			   unsigned long timeout)
> >  {
> >  	static atomic_t devcd_count =3D ATOMIC_INIT(0);
> >  	struct devcd_entry *devcd;
> > @@ -403,7 +404,7 @@ void dev_coredumpm(struct device *dev, struct modul=
e *owner,
> >  	dev_set_uevent_suppress(&devcd->devcd_dev, false);
> >  	kobject_uevent(&devcd->devcd_dev.kobj, KOBJ_ADD);
> >  	INIT_DELAYED_WORK(&devcd->del_wk, devcd_del);
> > -	schedule_delayed_work(&devcd->del_wk, DEVCD_TIMEOUT);
> > +	schedule_delayed_work(&devcd->del_wk, timeout);
> >  	mutex_unlock(&devcd->mutex);
> >  	return;
> >   put_device:
> > @@ -414,7 +415,7 @@ void dev_coredumpm(struct device *dev, struct modul=
e *owner,
> >   free:
> >  	free(data);
> >  }
> > -EXPORT_SYMBOL_GPL(dev_coredumpm);
> > +EXPORT_SYMBOL_GPL(dev_coredumpm_timeout);
> > =20
> >  /**
> >   * dev_coredumpsg - create device coredump that uses scatterlist as da=
ta
> > diff --git a/include/linux/devcoredump.h b/include/linux/devcoredump.h
> > index c8f7eb6cc1915..e3de1e545a4a5 100644
> > --- a/include/linux/devcoredump.h
> > +++ b/include/linux/devcoredump.h
> > @@ -12,6 +12,9 @@
> >  #include <linux/scatterlist.h>
> >  #include <linux/slab.h>
> > =20
> > +/* if data isn't read by userspace after 5 minutes then delete it */
> > +#define DEVCD_TIMEOUT	(HZ * 60 * 5)
> > +
> >  /*
> >   * _devcd_free_sgtable - free all the memory of the given scatterlist =
table
> >   * (i.e. both pages and scatterlist instances)
> > @@ -50,16 +53,17 @@ static inline void _devcd_free_sgtable(struct scatt=
erlist *table)
> >  	kfree(delete_iter);
> >  }
> > =20
> > -
> >  #ifdef CONFIG_DEV_COREDUMP
> >  void dev_coredumpv(struct device *dev, void *data, size_t datalen,
> >  		   gfp_t gfp);
> > =20
> > -void dev_coredumpm(struct device *dev, struct module *owner,
> > -		   void *data, size_t datalen, gfp_t gfp,
> > -		   ssize_t (*read)(char *buffer, loff_t offset, size_t count,
> > -				   void *data, size_t datalen),
> > -		   void (*free)(void *data));
> > +void dev_coredumpm_timeout(struct device *dev, struct module *owner,
> > +			   void *data, size_t datalen, gfp_t gfp,
> > +			   ssize_t (*read)(char *buffer, loff_t offset,
> > +					   size_t count, void *data,
> > +					   size_t datalen),
> > +			   void (*free)(void *data),
> > +			   unsigned long timeout);
> > =20
> >  void dev_coredumpsg(struct device *dev, struct scatterlist *table,
> >  		    size_t datalen, gfp_t gfp);
> > @@ -72,12 +76,13 @@ static inline void dev_coredumpv(struct device *dev=
, void *data,
> >  	vfree(data);
> >  }
> > =20
> > -static inline void
> > -dev_coredumpm(struct device *dev, struct module *owner,
> > -	      void *data, size_t datalen, gfp_t gfp,
> > -	      ssize_t (*read)(char *buffer, loff_t offset, size_t count,
> > -			      void *data, size_t datalen),
> > -	      void (*free)(void *data))
> > +void dev_coredumpm_timeout(struct device *dev, struct module *owner,
> > +			   void *data, size_t datalen, gfp_t gfp,
> > +			   ssize_t (*read)(char *buffer, loff_t offset,
> > +					   size_t count, void *data,
> > +					   size_t datalen),
> > +			   void (*free)(void *data),
> > +			   unsigned long timeout)
> >  {
> >  	free(data);
> >  }
> > @@ -92,4 +97,29 @@ static inline void dev_coredump_put(struct device *d=
ev)
> >  }
> >  #endif /* CONFIG_DEV_COREDUMP */
> > =20
> > +/**
> > + * dev_coredumpm - create device coredump with read/free methods
> > + * @dev: the struct device for the crashed device
> > + * @owner: the module that contains the read/free functions, use %THIS=
_MODULE
> > + * @data: data cookie for the @read/@free functions
> > + * @datalen: length of the data
> > + * @gfp: allocation flags
> > + * @read: function to read from the given buffer
> > + * @free: function to free the given buffer
> > + *
> > + * Creates a new device coredump for the given device. If a previous o=
ne hasn't
> > + * been read yet, the new coredump is discarded. The data lifetime is =
determined
> > + * by the device coredump framework and when it is no longer needed th=
e @free
> > + * function will be called to free the data.
> > + */
> > +static inline void dev_coredumpm(struct device *dev, struct module *ow=
ner,
> > +				 void *data, size_t datalen, gfp_t gfp,
> > +				 ssize_t (*read)(char *buffer, loff_t offset, size_t count,
> > +						 void *data, size_t datalen),
> > +				void (*free)(void *data))
> > +{
> > +	dev_coredumpm_timeout(dev, owner, data, datalen, gfp, read, free,
> > +			      DEVCD_TIMEOUT);
> > +}
> > +
> >  #endif /* __DEVCOREDUMP_H */
> > --=20
> > 2.45.2
> >=20
>=20

