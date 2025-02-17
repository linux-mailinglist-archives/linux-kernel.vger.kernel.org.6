Return-Path: <linux-kernel+bounces-516931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF80CA379E6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 03:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA98E160FEE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 02:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA6D136349;
	Mon, 17 Feb 2025 02:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FemkON2l"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8D3DDC5;
	Mon, 17 Feb 2025 02:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739760422; cv=fail; b=PYC0gSczG8NKB8mMg2I12A/O9bQYlsUB9SX8BPBaPMzh/lC6dHwMFsyqk/oiUs6snHVrHMV+Pu+aqtP/b1b7RK62lTn4LtfyhDEZsE3iSj4EBy8i8h22P1eurJYdyvnL9rEyN2YoaOf6EgnG1egWoIaD+/eUueJ1O8dMhnvqGMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739760422; c=relaxed/simple;
	bh=nBL5POqw8A5t/8H83Bipeo5aSAqwN1ki9zAHfAGR+lY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=resoDGadvt7xYRdTbKAuOTPzvBKvp3/p+zJ+1h2NGjHWgAi2V/Iz8pduB8soxAKI4ZgEfwWEnrNtV6ZfrTIQb9LyMaOfjaAMe4TVM6lt6v24u3uescFzxIol5cv3IZR8RV0p1g8n3Q5MsHq2WroRNCsrO9TSlEYr5nTcxh39/5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FemkON2l; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739760420; x=1771296420;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nBL5POqw8A5t/8H83Bipeo5aSAqwN1ki9zAHfAGR+lY=;
  b=FemkON2lfc9Kx4Fcftu2SQohu2DcUgedFYSjZv4GFJq1W4cZQIkyKyU3
   EcP+e9deFdV9l5bjl2jdKtvOndDfWaNq85Yf3yN6zHV6dKJ5KDZ7/2xaS
   3UFfq1NNeo1npCP+ItzbsMFN9F3y2RSCvEVKhcatYZPFwjH7CJHfadSk+
   40toAN303UkivUwB+rfFBGDv937rw64+JGdhxA00Qvh1W6hwH1l5pe5gf
   GDgoWk4/p4x4iZtJdKqnD8d9PocNk0hPWivccXinwGC7DmeV4IuL4lcZG
   8HDzpKuZzCVcR6o8iugIb00B8Vh2OV/MsUzuqTFHXnQ3CauyRJjasBxGz
   g==;
X-CSE-ConnectionGUID: smMrWunpSYS9uuNt0miIPg==
X-CSE-MsgGUID: +Saf/BdVQQGWlKmjaG+fJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11347"; a="51080918"
X-IronPort-AV: E=Sophos;i="6.13,291,1732608000"; 
   d="scan'208";a="51080918"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 18:46:59 -0800
X-CSE-ConnectionGUID: TLnB5PwBTXO4NLqbm+tSiw==
X-CSE-MsgGUID: O+s1Vz3LR5GPYwvcnovNWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114885284"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Feb 2025 18:46:58 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 16 Feb 2025 18:46:58 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 16 Feb 2025 18:46:58 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 16 Feb 2025 18:46:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g2ShdIIUtHGsJEGQAIo0y4icZLtUWbVCNmlxh2Q+sLVc0lRV1tZ/jdqpnlb1diQwH42YQJ+t72F358MoMj4ZzSbVWD79hcUPxrG/ceAz3zAB2aluEUhy76yymD45lyZNUisgw9SISWgAWX4pVPigH57YcDo6O8tS3TASIPzb/4le1u9tT3/AWWHbwsasC3bnEGDpgVSP8UNmuQk+unV08yJUQG0AqHYxMq/hgCoo8ACBMIR7Ue9wMN4GvmZ03UZAZ3zU467bV354ixALkKOBi4y2JtNPGiUmzpZQmAOPOHYASIATIU4gMO/81eJQbi8NdsvQhzAclc2TqVVMb1ocSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cFjGtYVl3dWXezYn99zAtYAV9kFhUbKx3lItYVxF0Uk=;
 b=xUfqUJaBUaV/qcA/TkrC2G1ngBP2awRSaeV9H9KPaATO1CEIacrU8IIZaRDlA75SinusMOcxAIYKXImatGLD38oncH8HtJTQGlCPrKVSzrlqc2OEvwm8WZr3fswSS4GcNYb1sKDye54NnvkrA6u3dKFWgN1lxnvX6ZRnxe7MSOSDtuSbztK3opUnP9PY5bPpc9j58JFumTIy55fUVBSqv8X0ie2/kIPtxYjBc8cNVs8qPlD1BQtXNXss4WSY2w3DdPHiuUN1h+SDLCuZ4wfQOmy+g6LElFpE75UxpnJkaYUXnAyDMX+kBiHYf9v4nMzs1gWnHGDa8Ht44w3OMp6Ffg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5862.namprd11.prod.outlook.com (2603:10b6:510:134::6)
 by DM6PR11MB4641.namprd11.prod.outlook.com (2603:10b6:5:2a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 02:46:14 +0000
Received: from PH7PR11MB5862.namprd11.prod.outlook.com
 ([fe80::7d59:aa70:2555:e6fd]) by PH7PR11MB5862.namprd11.prod.outlook.com
 ([fe80::7d59:aa70:2555:e6fd%3]) with mapi id 15.20.8422.015; Mon, 17 Feb 2025
 02:46:14 +0000
From: "Mohan, Subramanian" <subramanian.mohan@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"giometti@enneenne.com" <giometti@enneenne.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "corbet@lwn.net" <corbet@lwn.net>, "Dong, Eddie"
	<eddie.dong@intel.com>, "Hall, Christopher S" <christopher.s.hall@intel.com>,
	"N, Pandith" <pandith.n@intel.com>, "T R, Thejesh Reddy"
	<thejesh.reddy.t.r@intel.com>, "Zage, David" <david.zage@intel.com>,
	"Chinnadurai, Srinivasan" <srinivasan.chinnadurai@intel.com>
Subject: RE: [PATCH v14 1/4] drivers pps/generators: replace copy of pps-gen
 info struct with const pointer
Thread-Topic: [PATCH v14 1/4] drivers pps/generators: replace copy of pps-gen
 info struct with const pointer
Thread-Index: AQHbfsAFLOUewDa0/EiG+RhuFWcKKbNG41GAgAKI87A=
Date: Mon, 17 Feb 2025 02:46:14 +0000
Message-ID: <PH7PR11MB5862339EA0E6E366457CFC28F7FB2@PH7PR11MB5862.namprd11.prod.outlook.com>
References: <20250214090755.37450-1-subramanian.mohan@intel.com>
 <20250214090755.37450-2-subramanian.mohan@intel.com>
 <Z69ZPy5T5eXxVTuH@smile.fi.intel.com>
In-Reply-To: <Z69ZPy5T5eXxVTuH@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5862:EE_|DM6PR11MB4641:EE_
x-ms-office365-filtering-correlation-id: b5c41dc1-af9f-468a-153e-08dd4efd3f07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?VSGEfX4h44t/E7qxia04TjqQvwg2kI32XLKAJod7WxWSmGhjrSMwVWVqsAsl?=
 =?us-ascii?Q?Bw+9JSg1iUUEF85rwOKPLHUzuZmmmYZLO7uNvDd2/7DkWk+zXK21ehLG2hCA?=
 =?us-ascii?Q?K+riJo6FVCbuxBSMfbVvBU/o3Pmgkyfx5H1e7Ud72GpC2GmtBcg9v+PHyO8N?=
 =?us-ascii?Q?zk26mnAN2pBWDdj7ENai9t++TjV6y8NNQTTH3e4qnHojcB8fGNnSFigsaMse?=
 =?us-ascii?Q?URuINb+BrKuCdcdrhKPV/60RQyuehu1AVkTCo2LJmzdwLqRk6/Idmrw9mh7r?=
 =?us-ascii?Q?ek7sGUBU85w6MUEFejWO8zfd0KSNWuZ5ikRyLSUpVpa5L6Wp5ND4IDyvsgst?=
 =?us-ascii?Q?rWu8xKLehXwJdgYa1YdY0CSx4MnFHH+akWxDXeSZPPvl+t9G3qg/O1SwWtzD?=
 =?us-ascii?Q?WVQJD9Fa/lMNo90WNIKJnvUQ7AeYwoi4Sf1YfZklk3uYRPu9GCOrJzAyUJCe?=
 =?us-ascii?Q?QXbfY2PUjOStFGbd5bBu0/dpUo3LwduEuJhyZmPh/6xBYzK5szXVO/cqz4Uz?=
 =?us-ascii?Q?jopX3qMHCoBlhqHGMHLf/ssDH5ZsMX1EeN1P1OSQlps4IEanZPYgtQp65wA4?=
 =?us-ascii?Q?1gKbLOh54bXOWLEZiM0ZR+jrlMSyGdK+Ed9GLJ2i83ZN4UtOqip1ycW7RRDJ?=
 =?us-ascii?Q?ZWvavCMSVtk7LUZ2PaqkGeM9B5Wz6DCe/Nz3GNbQvjv2UkWzSEPBEnLFU1be?=
 =?us-ascii?Q?vNH97U6mZ8sMn7oSQCVbBAwuJSXLqv31V+q2t9GU0zP8oU4rDwixrESrAjRB?=
 =?us-ascii?Q?PKv+F3ktCB/dVwvGgl6j616PwhZnhVBrph7dO0MJAiPBj+fdiAK7NHDRLeF/?=
 =?us-ascii?Q?KMLMoMrQsib9m4in8IVf2NiVwdRFFQxJxoqeouC/Ty0mTFRlUwaU2NDYUB1z?=
 =?us-ascii?Q?eBYxfr7TC2yhEqV36rScsSnl4TZXlctw/CIcJlMXoAtdeifipD6lTsWQ/qLE?=
 =?us-ascii?Q?6YNPBR4fe0MZcxvCVfk5fi6JcRhep46twe8FWV6XlXFWsJhNYZdZFo9aZ9nJ?=
 =?us-ascii?Q?pr1GKSNwYvj4Z0r/c6JEJG0WJCBHRAIkmZyNga0tlItHcqQhkwj6jtt0FjUW?=
 =?us-ascii?Q?u3klqqRHCd1PKA9y+IX3/m/TOH7q9irlL4CLhVJo7Av4uiF2mmDz9NcskQvL?=
 =?us-ascii?Q?KZ0cGqRfsyDTQ3aUsvVy3rxEGifdJ15pFUM2bgjo4CMLHO3ADPuKkp4bTS32?=
 =?us-ascii?Q?ISxGcpPxeGia6ycQjYzgavuKRf7B1cyH2t0wbRjN5m7S6FF8IT16TuK5pS2/?=
 =?us-ascii?Q?UC3G5iX9COkDO5xq3KL0g9l3ArVTiIoRsn0G76YT8VOkI8+jSPeEzXHBLINd?=
 =?us-ascii?Q?MRjuZFUKIfNV6D2bjDMJfWj0bVwOyOG1Ada/vRF13j6irN667x45obvUI1A+?=
 =?us-ascii?Q?O9O6mNc8YaDF6oLar0HHzi0ALZ7c9zA94cal77D5t0debK5nG7qxNog9aivH?=
 =?us-ascii?Q?eH8sNUlb76neNFLhRYWABFltBw/ASTkS?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1NvcHGTL2hRCeeX2I2TaJ+po5fuvidco3X3p54XgHW9XalvfHATjjpzSGxds?=
 =?us-ascii?Q?e8ueSNUkjXAeZnL00AjTxoFNZIHPvsG7BlipbdR/VCQv6FsgA51WQ6xsjj/g?=
 =?us-ascii?Q?jX1IQr3KQR9iRjuROKkZKyfcdN+WiP0ljgj3OEsg76a3+99PggJaul1VySpR?=
 =?us-ascii?Q?s4ksiVbtdqxXsMiaJC1ZjwNJtw3kcF3oyMhtV7zKU20j/q1oiobOqqzwf0G0?=
 =?us-ascii?Q?NInmGrMr/MNFPhjkIO1tfMfy621E2KKtv77NpbURvvnbc/rlCus9SWoNyCYn?=
 =?us-ascii?Q?dPoVJffPaslHafWlPHmAxk4r7Cj6gyDnTOFe5ilJzXXnNwzrEVDYX6un1s1w?=
 =?us-ascii?Q?yKNqKtaKl2F8pYqUKXwKBQ4aQs4asLPDbBn2/3V26FE0RgYMxbce8Uidw3QF?=
 =?us-ascii?Q?wxpG9moQJEARmaCFH9rxxiNAHCzHi2bIfT2EqbIQbNjUpSYipWryYWY9Pz2Q?=
 =?us-ascii?Q?zFB/41QzyHOktkTCCi6PWRa9RcBXkC8AS9WWZrTS1Yt+5d4LJPDEcIvyaDWw?=
 =?us-ascii?Q?kPQNayx0gipI/iIMOM3w/nXVFR9xt9n5fNERWmSYXcqPBQmGAzifBmWW7DS5?=
 =?us-ascii?Q?ZuQBAPA9WEylcXmwmPGt53dElI+GxyHSA43y7xrkRKJzyI2WU2OpUjMJAFj0?=
 =?us-ascii?Q?PSnPnO/wRR/HbHKvTVHvTmtVo8KyjUzw1MK6kgF3xbLA7jVNU+PqUFsW7CeG?=
 =?us-ascii?Q?FYHgs/iUG/zraFj81Dul9m9TNjLQQTceH0uikPnO/XV7/Sx3vQQOQro8rtcO?=
 =?us-ascii?Q?pdL3YI85atVRWydBbE0hzWfP0dzduSmQ9IpmtJWx7JKm7cvPV85GcsTvkpsB?=
 =?us-ascii?Q?/gdcwuHYObjjU1dylo4F+jte3fVToERc/I8b9oCgTkBTN5c86LrCcykpkwvA?=
 =?us-ascii?Q?U1v1yKHPnq0vheA/ujtFM33w3hj5XKSjkUYNQnoSTxDSZUHifJjJ0QQB2WPz?=
 =?us-ascii?Q?Yy8Gu1VMpCGiqGpZBd44qTbv1ZwWqNex1rSqdgUdmWS/oI76MX+JG9jmHTD+?=
 =?us-ascii?Q?kmW0EzvVySHxZEOD2YMV1C2CND1B25arBNgEGoGaj4cnrXR04H9dcPcpGh9G?=
 =?us-ascii?Q?xA0glZiJIsD8kzwsK8TdhXwz5A9f3eJpjqxHropKzXaQHMGQ1YWHyoDpEkJo?=
 =?us-ascii?Q?hiDaEp2tAglZuJvrmmF1xCCF/Lsp41RlcoX3E0nKQguJbRtXePllupKGuQvk?=
 =?us-ascii?Q?W668b+3yCpcEwSJKwnLsIiYiNBLPmIbRXX4WODlo+PbrSQOsQ5YUTJOO4bin?=
 =?us-ascii?Q?OOFztjh8tCi2Ivrr/UjUwo0KYgtvm1aKLMd1LWhjtY8Rr5yC+ZCickC4r8Gd?=
 =?us-ascii?Q?017D798YwxeqdiDdkU2NvE7NnGS95ysImmJpPZf9H8JmV+QHTkZmVqeFFDTQ?=
 =?us-ascii?Q?wWYqJg1J34LgcpHePcXKK3L1peAxIJYPI6D1F2hitDeiPSSVr25dEItlPIGe?=
 =?us-ascii?Q?D/mmGSJSzFVdYxLZuwP5yl6cgqwDe9HraXx1cv5kM88ciV5wjnS6EAUtaSev?=
 =?us-ascii?Q?dAtwcfSX5beXPN/y9eKOFvhS5Vv+Egm22Ru2aW49JcRzHK1eEMM0FBMen5Z/?=
 =?us-ascii?Q?vMGhVBgg8uO8Uwk6dDm2/DYz7Uvu3xk6jsO1rain?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5c41dc1-af9f-468a-153e-08dd4efd3f07
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2025 02:46:14.7120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rl+IbKP2z7g9R5XoJAL2bixxOk/GELdYntg5RqvJfXmzTRGxaJNluGjNgFKDhopAX8YJOTTq2bNBUcF79TT28LgyIjwM4X/dQTzbKNUVaZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4641
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Friday, February 14, 2025 8:25 PM
> To: Mohan, Subramanian <subramanian.mohan@intel.com>
> Cc: linux-kernel@vger.kernel.org; linux-doc@vger.kernel.org;
> gregkh@linuxfoundation.org; giometti@enneenne.com; tglx@linutronix.de;
> corbet@lwn.net; Dong, Eddie <eddie.dong@intel.com>; Hall, Christopher S
> <christopher.s.hall@intel.com>; N, Pandith <pandith.n@intel.com>; T R,
> Thejesh Reddy <thejesh.reddy.t.r@intel.com>; Zage, David
> <david.zage@intel.com>; Chinnadurai, Srinivasan
> <srinivasan.chinnadurai@intel.com>
> Subject: Re: [PATCH v14 1/4] drivers pps/generators: replace copy of pps-=
gen
> info struct with const pointer
>=20
> On Fri, Feb 14, 2025 at 02:37:52PM +0530, subramanian.mohan@intel.com
> wrote:
> > From: Subramanian Mohan <subramanian.mohan@intel.com>
> >
> > Some PPS generator drivers may need to retrieve a pointer to their
> > internal data while executing the PPS generator enable() method.
> >
> > During the driver registration the pps_gen_device pointer is returned
> > from the framework, and for that reason, there is difficulty in
> > getting generator driver data back in the enable function. We won't be
> > able to use container_of macro as it results in static assert, and we
> > might end up in using static pointer.
> >
> > To solve the issue and to get back the generator driver data back, we
> > should not copy the struct pps_gen_source_info within the struct
> > pps_gen_device during the registration stage, but simply save the
> > pointer of the driver one. In this manner, driver may get a pointer to
> > their internal data as shown below:
> >
> > struct pps_gen_foo_data_s {
> >         ...
> > 	struct pps_gen_source_info gen_info;
> > 	struct pps_gen_device *pps_gen;
> > 	...
> > };
> >
> > static int __init pps_gen_foo_init(void) {
> >         struct pps_gen_foo_data_s *foo;
> > 	...
> >         foo->pps_gen =3D pps_gen_register_source(&foo->gen_info);
> > 	...
> > }
> >
> > Then, in the enable() method, we can retrieve the pointer to the main
> > struct by using the code below:
> >
> > static int pps_gen_foo_enable(struct pps_gen_device *pps_gen, bool
> > enable) {
> >         struct pps_gen_foo_data_s *foo =3D container_of(pps_gen->info,
> > 						struct pps_gen_foo_data_s,
> gen_info);
> >         ...
> > }
>=20
> Shouldn't Subject start with "pps: generators: ..."?
>=20
> With that fixed,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Sure Andy will modify the subject line as suggested and add Reviewed-by tag=
, Will resend v15 accordingly.

Thanks,
Subbu

>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20


