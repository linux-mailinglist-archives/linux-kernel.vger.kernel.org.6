Return-Path: <linux-kernel+bounces-190417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C52B08CFE00
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E84CD1C218E4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB9F13AD30;
	Mon, 27 May 2024 10:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y7tJRNXf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1971E572
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 10:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716805398; cv=fail; b=YpXZKTgPSjg0D1rOIpV7zEQ7VlJpfg/05Ds55UXvSOV0w86i1fD2JmatwBeSXmljqvqXFMo6Ct9gTe8Enz9YSURed+B6jB9Rk9qPYjVP5P/BvREvpDkgXbC5q+scueKzZU86yZWBuFrn+LxmjLdhRv/Rzxc1qwafHyGF+z49LQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716805398; c=relaxed/simple;
	bh=7Noj+sBZgkCBrYhezpBzupGmQb6viG+LWxTzedZcuec=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lgcbpHR9oQ1BiDxZLbyHugwngCbKxXq4uGaJoJKfXD9myUKyRlWefvXJRIrtBqGBYJEFC4tk8H4wiwUtlcaXZMa+SvgvYLJK1qJv5GZnyRnbFwcOqWmqLScDShQHnb65VG9u9Rrz8YOAJfCP3urzS35e0YLrS34OTNkVZvqy+8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y7tJRNXf; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716805397; x=1748341397;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7Noj+sBZgkCBrYhezpBzupGmQb6viG+LWxTzedZcuec=;
  b=Y7tJRNXf1yby9zPM+9WT6VWr18f94RcDvkay8p3/5FQsWBFVZCUgxhRg
   rnco9SqNvZQF19uzr+XXjhn1iCgUBsg6p9j1T1VSf5si4BOwRHNdUOdzj
   1xs01DMB4XngDlc1PbxUXEmtB2mPcd9QPP79SVu+sBzXPXM7j+nf5FEU9
   xI0LX03nzxqKq1xUbpO/XnJXCprwya4nos4QvU4Yo1zpBCdZuTeg/e5uI
   QEd1y4N/1/l0xKhz9Y5APo0kFlg2saCbjDm/1+OO/aMfRiDOEphvb6Np8
   ynuWBbxnh1Wa0pOshIqv8Gq2uuXkPfilYckm34B+/leGmjbX6d6v1qwQp
   w==;
X-CSE-ConnectionGUID: 6EVOZtkjQh27kpsmGq9yIg==
X-CSE-MsgGUID: K7RaxdrfQUSfxSwf7uou4w==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="13237658"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="13237658"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 03:23:16 -0700
X-CSE-ConnectionGUID: Aqr2AJdgTSS9iHYRA9imqw==
X-CSE-MsgGUID: rYLiaW8mQlqjQYXkMQQKiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="39567830"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 May 2024 03:23:16 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 27 May 2024 03:23:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 27 May 2024 03:23:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 27 May 2024 03:23:15 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 27 May 2024 03:23:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/X6xJN+TlcGrUANQ4cfaWsNeXiW8cVhV7G2LYh6qhe/W2hnYq51llmq5Xc9WsW5W5pbMxrNrUop8pb/DgRhmySy+i4l1aVLIQsOtHWfKF+WWXJz/8WG+goOzJWtO6vw4kmIGyTuRlyepj8aqsAieFaRdjvbTVi5aSSZumkwAHpX+HTYWLIZq2vVNeAkQsfuANQxeuYOKZZ6CbPSpg57M8NdmB0aGsaL5TWawURHJXEzUDU5hrJFe4/lCODGSVXv5G9zTlK3/6fE2wpyWbmNDDXPXZABRSu7Lszbx9oYL8dvvwbT2shmHTnCDIkNbCG+HGDUzzmZZrB8yg7yQ3weAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RTrLMY5S9ccBqveW9RiM8oLRfQTpYF38MeM1eRVM9VI=;
 b=OJGjcSUemJTQ5JKyT6F85Cjys8c9k6hh9fiWhBKUij28xnbFt7BGAdDI60BDRe1gWo37JDPOZK2dGyHOe/2zG0ikKASjtLAqEZ7UAeO5D+q7WiqXm9TQRyeMa9HdbLJtWH1VowbZWJKAbcnVvrFSRoAqKvJfvYdbtb/kz0EB9a3llkCYtGpjoO6wEKPFcr/I8eHgsmkJ5X9NE2KhsKMGox/1fKYBeTpTEhOdqI4QVAUkWKwp5WRZA9G2eAjOIPomacutQxq1JCFXKgSrsqcRPLtp0O4oZS25G/ly52XQiY8m7EpJVghiRsipEOYhC5NuBpnZT8ugU78DeDuiiqps0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 SA1PR11MB8351.namprd11.prod.outlook.com (2603:10b6:806:384::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.37; Mon, 27 May
 2024 10:23:13 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::4046:430d:f16c:b842]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::4046:430d:f16c:b842%4]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 10:23:13 +0000
From: "Wang, Xiao W" <xiao.w.wang@intel.com>
To: Qingfang Deng <dqfext@gmail.com>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Qingfang Deng <qingfang.deng@siflower.com.cn>
Subject: RE: [PATCH v2] riscv: lib: relax assembly constraints in hweight
Thread-Topic: [PATCH v2] riscv: lib: relax assembly constraints in hweight
Thread-Index: AQHasBesp4ThaqJ1FEqryEoDIMEN07Gq32yA
Date: Mon, 27 May 2024 10:23:12 +0000
Message-ID: <DM8PR11MB575188FDAB2A07A15A589F76B8F02@DM8PR11MB5751.namprd11.prod.outlook.com>
References: <20240527092405.134967-1-dqfext@gmail.com>
In-Reply-To: <20240527092405.134967-1-dqfext@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|SA1PR11MB8351:EE_
x-ms-office365-filtering-correlation-id: 287214c6-ffc5-42f5-11fb-08dc7e3703b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?Windows-1252?Q?wqF/+wxGnBodzTbGr7cq0OFuGaotdV2fQTFXmD5a9ntwwgee/vhAJ8OU?=
 =?Windows-1252?Q?0fYDTG/GetnGYLXTZIa5qscdQ5fH6DhyFKlof+2L85pyl1XV9VVk0W+A?=
 =?Windows-1252?Q?LTgJe6weqvuE0xFy58C8kBNKrmpFDcOcIzr+KbTLm8LPwn7HYy/OXn5/?=
 =?Windows-1252?Q?tpODUIFqESOqtpdsE8aGJonjUDkEhFipXYCHsyScUacmHTC8l8/0wNft?=
 =?Windows-1252?Q?XKS30+wwfdqeV2LXx0ca627kIEPU0glkWQc3LvxLdpgRrbPl8mAZyh8e?=
 =?Windows-1252?Q?BI8M2xt/eDh6fNC5ALLE+pP/Ap7c8jQ7YRuaGRZysPtTKOjg8HOL4Fvg?=
 =?Windows-1252?Q?X7Z154CoICHk0PX5NQZuU8ZM2xHr7k9OhO9HdBp7sRpLoqAQzkRaVwTV?=
 =?Windows-1252?Q?Nz4T1cGQzukRSK9vyG93lXAg1uBWfWFwveyZgSQVwn4a1vD8Dk8nc3VL?=
 =?Windows-1252?Q?1PqgSQuRtsRi3G11qBDW2BhMOcLzl92uT+2h5gXhbwopBvrFnGAaNDbM?=
 =?Windows-1252?Q?YZXcZWRBgPyArh5gAc8MQq6OzA1OsqpMlvRqQvNc0sihqIclTxGgZDSp?=
 =?Windows-1252?Q?3uX+6SXIYk8OgM1UTmGMw77GDjkcEstRJWNmhNcjjlzSty3N5D/0yJsH?=
 =?Windows-1252?Q?VUtBbybpxxbQAuD6L+uDOrpI1qxOFQbGJj385pDxJnACMdteJVKXP7YQ?=
 =?Windows-1252?Q?2IKbOR8VpEnLBJqMQ+LdT5fK76TM7WCc7ku1edFeZlq/fWRqMDuwKZWL?=
 =?Windows-1252?Q?TdS5HQ2HfTuPd9VJYISy7beHNu2AXTfUpIfZeWHxhgdQHcfwJqbr51K9?=
 =?Windows-1252?Q?lu6GOx0RA/X9bHyI5Yd8UrA6xzJISN3sFrtaZI5LSipGPRUUenrTO4/1?=
 =?Windows-1252?Q?4dvNF7xPCYqWb3xVqem614o//6sTSDVWTqQrDJg0EhY04xpTHnE9wQeM?=
 =?Windows-1252?Q?MY7W6ACy1oKMsY1jpU5aK8RF3P5Mea1E8ht45cSwp/BgzsvB68EoSTjo?=
 =?Windows-1252?Q?u6iC1EeZC4C3PxYbVoXalpqVQoyINtt5OdU3RPn6dtH4Me+rc/xFttnN?=
 =?Windows-1252?Q?nY8mmQ108bJs3pw/ubn9E2PY00cFVqVE0UBJOW5To1D+JEmqGEY/acZA?=
 =?Windows-1252?Q?5YFDI0iZl+ohys34pkqzIPvb3PqWn5CqqlB5XF+KbQZ1hHN0lxX3+AHV?=
 =?Windows-1252?Q?nLDyLcM7wNDDY+VtAtp6BJlS7xC2BbdFI2sRQcZpQNYAUNvdl72QYP5H?=
 =?Windows-1252?Q?iy3YMeXj/qNFR2ePj9R1YsX0WkuH+nss6YcePyjvQraSS2oXd/x3i7xd?=
 =?Windows-1252?Q?/XEMw5tCCYZPA2M+DJPuiglwknsVAXs0x7FSoOPn/PD12NDYw1vi5Yqb?=
 =?Windows-1252?Q?08EtWUD8YXv3ynV4BYHGR3JyiT4P8rF5uvV6994vB+1PgH6ljFBJwZev?=
 =?Windows-1252?Q?Bj52E78cijQJ5NsepzG36Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?oUrfR8uTza4Qd4HXABmGpKhwFdA1BkDqxwt7FX6Qz99kqH+iNgtzFdNS?=
 =?Windows-1252?Q?A5j6vPA1n01XW9CYJdCr/QAab1yXBMYZQUDYYvOAMHGFKzz6RZjJeurr?=
 =?Windows-1252?Q?flcgs4QKWyuBspm0nVXyKX3A9rjbWYkf3AyU9/zW+ClorKBrYsc5ltnT?=
 =?Windows-1252?Q?nYOtiDPTQeqc5arv3pEOlc50V3S8Zy/COHMuy/HbfTSac68w+H+TEPhQ?=
 =?Windows-1252?Q?nTVmZB9k4WNYQFJVrJQSuFO+HT0b5Vrc9fpvamQq7uzdFhMbwHum3ecU?=
 =?Windows-1252?Q?HrN0HVa9tvkrUbIoL24nBlb2fD/cnO7ylWqBFUDz6bHP+V9Va4ASLyy/?=
 =?Windows-1252?Q?bhRquiuu+D5gXdScLb4CiDdLp6EGzIvnFiiiMQ7kwKD5Xa5Jiea5quU3?=
 =?Windows-1252?Q?pSAF2p3l5xertNo2k+x+g4Zwip10mtagxJnoMJyYpKZDJf+8ovlO4TE/?=
 =?Windows-1252?Q?UfrCc1oucbcayR5VMannxEJoMMlT81YBQsBEFX3koxuTazwE0mftmc2K?=
 =?Windows-1252?Q?uXf3/kmiWc0DZxDNsAacQkadiO9fY+67la6kweU4UOQFxNfGV//AuX+j?=
 =?Windows-1252?Q?k38sWwZE67+OleMqHS8Xbqv4HJO6mhdJnz1eNNVRXwwOfaoDhTYoRZwK?=
 =?Windows-1252?Q?9YG647fEiGIan+5FSNCTgM6DdggObSNLlC2cEuxIUypNW+ZyrTE6twRY?=
 =?Windows-1252?Q?h9+xoZ7Wpjkrpu7wefxAYYvLDbvujPBHd+FsscoTZRBldnvUNpVifFwU?=
 =?Windows-1252?Q?g8CrMdW1TF+XXXhswNrnC3cnzbt/ip903+4T5ArD8LD80E0sQBeVe4Z4?=
 =?Windows-1252?Q?Or9MLaavMtJqr7xPUOLMdsBzvQAqtt9GVFlOk9ACxqojumJ5OZwVtbvU?=
 =?Windows-1252?Q?dRwf5941mLYkcRuCC5JT61/YhGQ1rR+ihXowuVmnjrDWx6Ef77cwwQhs?=
 =?Windows-1252?Q?M8ichhnTLlmdy2gEGyzKLSTakemDpVEr+TU6Rmu36X3sKGwjvT9g6MO/?=
 =?Windows-1252?Q?CWBOTrXgLW+8M977fbnvTGaiQ4qEE7an//MmHm3ej3UOAV1XpVPTjCef?=
 =?Windows-1252?Q?N7R70sxRA/8HjWyJCQ1S1YpnmdtKglpOj3S8UaIk602iLOCckEPh63U+?=
 =?Windows-1252?Q?PFXH0zI/uT/YivcCs2foXhcwgqx8g5iaWBEB6Fc/5t+Fb7SnxgowLeML?=
 =?Windows-1252?Q?2dtTZYJiSVJVpsTRpS1LVhBuBzbbRmPnGbGPPY9nfp3VavJU7CUryhZv?=
 =?Windows-1252?Q?Nw/pB8MN1mxRObhXxVSr+qz1Hy7VVUVXaTpCcwLZ8+qan7ya4qE/0wpo?=
 =?Windows-1252?Q?IPhWh67WzhTRZZJYsqpfgU+99WCmdT9FourEZfjeVFiyugOpO3V+F/am?=
 =?Windows-1252?Q?5wm/UTVXwXfvYcqePIZ1JlebrvHkKXAz0jeTt3am7eKy6pjH4e96Z2VQ?=
 =?Windows-1252?Q?xr+QIVysTUA7YmkKSiKioRFs5scZHMSBObgTsqczM8KlOgJ2Z4wlkmM8?=
 =?Windows-1252?Q?hGVmxIEyCYcnjPZfGEY8ZE2SWaJJVBVVJrtTiO0J8K6bhqTJwmp44nSr?=
 =?Windows-1252?Q?kkLdekv/MSoBw5fe9hoKgk5Vu42DJVjSJ1QwA1+2y5TG7aEUdrTeoMNw?=
 =?Windows-1252?Q?NNpdfMqSNyQA9NOQontwHeLUiHIF6RmAh1ay/M7AXqLL1dMR2UOXvNlB?=
 =?Windows-1252?Q?iSbfZ3BDPsksak0WgvAb1Vd8wGpt+TlN?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5751.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 287214c6-ffc5-42f5-11fb-08dc7e3703b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 10:23:13.0181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RCdgdP5+Ni2tJSsVAqDjt2ZfszE+Eha4fdjeN4gblkP/UNIORPWIQ76GplRQPaczzMKSG3pTv27DCs6zRpiMEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8351
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Qingfang Deng <dqfext@gmail.com>
> Sent: Monday, May 27, 2024 5:24 PM
> To: Paul Walmsley <paul.walmsley@sifive.com>; Palmer Dabbelt
> <palmer@dabbelt.com>; Albert Ou <aou@eecs.berkeley.edu>; linux-
> riscv@lists.infradead.org; linux-kernel@vger.kernel.org
> Cc: Wang, Xiao W <xiao.w.wang@intel.com>; Qingfang Deng
> <qingfang.deng@siflower.com.cn>
> Subject: [PATCH v2] riscv: lib: relax assembly constraints in hweight
>=20
> From: Qingfang Deng <qingfang.deng@siflower.com.cn>
>=20
> rd and rs don't have to be the same. In some cases where rs needs to be
> saved for later usage, this will save us some mv instructions.
>=20
> Signed-off-by: Qingfang Deng <qingfang.deng@siflower.com.cn>
> ---
> v2: updated title as suggested by Xiao.
>=20
>  arch/riscv/include/asm/arch_hweight.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/riscv/include/asm/arch_hweight.h
> b/arch/riscv/include/asm/arch_hweight.h
> index 85b2c443823e..613769b9cdc9 100644
> --- a/arch/riscv/include/asm/arch_hweight.h
> +++ b/arch/riscv/include/asm/arch_hweight.h
> @@ -26,9 +26,9 @@ static __always_inline unsigned int
> __arch_hweight32(unsigned int w)
>=20
>  	asm (".option push\n"
>  	     ".option arch,+zbb\n"
> -	     CPOPW "%0, %0\n"
> +	     CPOPW "%0, %1\n"
>  	     ".option pop\n"
> -	     : "+r" (w) : :);
> +	     : "=3Dr" (w) : "r" (w) :);
>=20
>  	return w;
>=20
> @@ -57,9 +57,9 @@ static __always_inline unsigned long
> __arch_hweight64(__u64 w)
>=20
>  	asm (".option push\n"
>  	     ".option arch,+zbb\n"
> -	     "cpop %0, %0\n"
> +	     "cpop %0, %1\n"
>  	     ".option pop\n"
> -	     : "+r" (w) : :);
> +	     : "=3Dr" (w) : "r" (w) :);
>=20
>  	return w;
>=20
> --
> 2.34.1

Reviewed-by: Xiao Wang <xiao.w.wang@intel.com>


