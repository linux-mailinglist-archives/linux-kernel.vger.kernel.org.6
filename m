Return-Path: <linux-kernel+bounces-414964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1810D9D2FC4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 21:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93BFB1F23324
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 20:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C261D2F48;
	Tue, 19 Nov 2024 20:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="PhMVaFjv"
Received: from rcdn-iport-1.cisco.com (rcdn-iport-1.cisco.com [173.37.86.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49681D07BB
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 20:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=173.37.86.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732049468; cv=fail; b=J+3zONi0SH7AsoJNdkDVN23Qnje1+guvVUa6SnjbI9KmUk8YMQxHAKFIF3X737BTRJKMFGlU7MYvmn/G/Ep6HIK01nt0kfwcX+1rDeolwhMoCdrGjIfXNcUKTXo8PVg/kzQj9Fci2o5JOGmHiOxTKaHxPYAG9ksRLLZczBvzCYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732049468; c=relaxed/simple;
	bh=b2jUbxJ16ymkM2rMaYr2EpZVyhlns3hi3hOLhJp9+bM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OXzuVwUTHLKi6iWKxcWNryoY6RR3YPDSHzxMjOYJmhjs2wCkOSqZgn04n7/prYrZ6G9KohLFyT704Q6Mokn/057mejbbE9FL1RkDWoS105DbmbuP9nrQ8EDbg6Su7/p3lnZ42Zb2bR5Natn+x4mAwI71nm4Z4YMoOKAYGT6ohOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=PhMVaFjv; arc=fail smtp.client-ip=173.37.86.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2998; q=dns/txt; s=iport;
  t=1732049465; x=1733259065;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=b2jUbxJ16ymkM2rMaYr2EpZVyhlns3hi3hOLhJp9+bM=;
  b=PhMVaFjvEmMYCvyqqZr27GnnP2SGVj1Fmg1Mg9aoldUX4tRCR/Iry1DC
   vI0ibiKEV/skAIHvw9Dbr65uu3gWKd3gUSX2TBsNq+oNEsM1s4xqYNlU0
   meTPv6jO2pqX1gE0aY4OJG9MmGi2unM5VsGzr66oUMU+7IZKL+ypDEZEi
   I=;
X-CSE-ConnectionGUID: kUGanUZbT8aGBfvdZqtZ6Q==
X-CSE-MsgGUID: jmhpRtEgTimq7BgYRh1IRw==
X-IPAS-Result: =?us-ascii?q?A0C7AwDz+Dxn/43/Ja1aHgEBCxIMQCWBIwuBclIHghKFH?=
 =?us-ascii?q?YNMA4UthlGCIQOFeoxVHIssgX4PAQEBDQJEBAEBhQcCFoo9AiY0CQ4BAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBAQEBAQELAQEFAQEBAgEHBYEOE4YIhlsBAQEDEhERRRACA?=
 =?us-ascii?q?QgYAgImAgICDiEVEAIEDiAHhUQDAaV8AYFAAooreoEygQHgIBiBAi6ITAGBb?=
 =?us-ascii?q?IN9hHcnG4FJRIEVgyo+hEMXg0SCaQSCQYJmgTN2JYh/iXaQSwlJexwDWSERA?=
 =?us-ascii?q?UsKNQw4K0YhLAOCR4I1gVKCRoEUgy6BXgU3CoMJgTQ3Ag0CgkVzH4dmgQuDY?=
 =?us-ascii?q?YNFgRmBbYJxHUADeD03FBsGPaNAbERMIYF1WZMAg0cBSa8tCoQanjqDaYNxj?=
 =?us-ascii?q?QKZSC6HW5BuoyU0hSQCBAIEBQIPAQEGgWc8gVlwFYMjURkP13KBMwIHCwEBA?=
 =?us-ascii?q?wmRRwEB?=
IronPort-PHdr: A9a23:5rmBbRTwZO3HKULbJNv/mhy/4Npso47LVj580XJvo7tKdqLm+IztI
 wmDo/5sl1TOG47c7qEMh+nXtvX4UHcbqdaasX8EeYBRTRJNl8gMngIhDcLEQU32JfLndWo7S
 exJVURu+DewNk09JQ==
IronPort-Data: A9a23:XaV00aiehpBc0d9+LO1NcMDgX161NxEKZh0ujC45NGQN5FlHY01je
 htvXGrTMvvZZmOgKY1wOo+x90tSvZfTn9ZlSlM6pSA2Fi9jpJueD7x1DKtf0wB+jyHnZBg6h
 ynLQoCYdKjYdleF+FH1dOCn9SQkvU2xbuKUIPbePSxsThNTRi4kiBZy88Y0mYcAbeKRW2thg
 vus5ZSFULOZ82QsaD5NsvvS8EkHUMna4Vv0gHRvPZing3eG/5UlJMp3Db28KXL+Xr5VEoaSL
 87fzKu093/u5BwkDNWoiN7TKiXmlZaLYGBiIlIPM0STqkAqSh4ai87XB9JAAatjsAhlqvgqo
 Dl7WTNcfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQqflO0q8iCAn3aMqUbx8l+B1x8/
 8BIIR8nYA6Ptfuq8uyCH7wEasQLdKEHPasFsX1miDWcBvE8TNWbH+PB5MRT23E7gcUm8fT2P
 pVCL2EwKk6dPlsWZg5/5JEWxI9EglHzejtZpVaKrII84nPYy0p6172F3N/9IIzUFJwNxh/Jz
 o7A12b8AgkgKPGQ9TuA6y2Gid71nXraYp1HQdVU8dYv2jV/3Fc7DBwQSEv+ovSjjEO6c8xQJ
 lZS+Sc0q6U2skuxQbHAswaQunWIuFsYHtFXCeB/sF3LwavP6AHfDW8BJtJcVOEbWAYNbWVC/
 neCnsjiAnpkt7j9dJ5X3u78Qe+aUcTNEVI/WA==
IronPort-HdrOrdr: A9a23:1XY2rKFWXthYvYMUpLqFlJLXdLJyesId70hD6qkvc203TiXIra
 CTdaogtCMc0AxhJk3I+ertBEGBKUmsk6KceeEqTPmftXrdyRqVxeZZnMrfKlzbamLDH4FmpN
 1dmsRFebnN5B1B/LnHCWqDYpYdKbu8gd2VbI7lph8HI3AJGsRdBkVCe3qm+yZNNXB77O8CZe
 GhD7181kKdkBosH6OG71A+Lpv+juyOvqjLJTQBABkq4hSPizSH1J7WeiLz4j4uFxl07fMH62
 bqryzVj5/Pjxi88HDh/l6Wy64TtMrqy9NFCsDJoNMSMC/QhgGhY5kkc6GevRguydvfqmoCoZ
 3pmVMNLs5z43TeciWeuh32wTTt1z4o9jvL1UKYu33+usb0LQhKTvapxLgpNicx2XBQ+u2U45
 g7hl5xcKAnVS8oqR6NoOQgkSsazXZc70BSy9L7xEYvIbf2IIUh37D3unklU6vp2EnBmdwa+C
 4ENrCA2N9GNVyddHzXpW9p3ZilWWkyBA6PRgwYttWSyCU+pgEy86I0/r1Wop47zuN3d7BUo+
 Dfdqh4nrBHScEbKap7GecaWMOyTmjAWwjFPm6eKUnuUPhvAQOAl7fnpLEuoO26cp0By5U/3J
 zHTVNDrGY3P0bjE9eH0pFH+g3EBG+9QTPuwMdD4IURgMyweJP7dSmYDFw+mcqppPsSRsXdRv
 aoIZpTR+TuKGP/cLw5ljEWm6MiX0X2fPdlzerTAWj+1/4jAreawtDmTA==
X-Talos-CUID: 9a23:9zP5WW3yYd8f2DumZcqZGLxfGf0Ke3vg/n3sc0aXI2h3RI+MVW3OwfYx
X-Talos-MUID: 9a23:sRSkWAlnw/MHj0MYaKvGdnpgMcdw2biDB3wMlIxZkca1DywpGg2C2WE=
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-l-core-04.cisco.com ([173.37.255.141])
  by rcdn-iport-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 19 Nov 2024 20:51:04 +0000
Received: from alln-opgw-4.cisco.com (alln-opgw-4.cisco.com [173.37.147.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-04.cisco.com (Postfix) with ESMTPS id 87E4E180001A4
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 20:51:04 +0000 (GMT)
X-CSE-ConnectionGUID: M+ot3tzBTw2iSony1qsoew==
X-CSE-MsgGUID: IS3YhMU6Rm2auA6TjpZn+A==
Authentication-Results: alln-opgw-4.cisco.com; dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.12,166,1728950400"; 
   d="scan'208";a="40502732"
Received: from mail-mw2nam12lp2043.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.43])
  by alln-opgw-4.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 19 Nov 2024 20:51:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U9K+KMnGjtR1p5mpNR8tx6WUebZG9rEs8IiH1kIUF6ZDnwD+JfHpC1qHA86J5VjjCFfI1ygl3zqeZFv23N9AJseC8I8G1JpEZvN9yRV4hTM39IbX3LwqozuYRJQaFm2p62JHtURy4WsLm7m3iinNBBtbmk4N0LmITTgapH6CkqXUvigM4db0zADI/zTPl4zS+Anw6rdNh9Eff11CaLx+pK1alkQUKyxKd/hf+BnwtPN4gCNCl/qsZ8XJ3YIxLUtRFY7P78IRTzRLaZiVDIcYmHF+7iq56MlEcZFxdnLtOh22pjdLOrVevzlII+2Wly4WpxVEqxT9wQGkPBUQsKGV/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2jUbxJ16ymkM2rMaYr2EpZVyhlns3hi3hOLhJp9+bM=;
 b=nd+XZzBjIsiiKx/TM0ljYCqQrAvlBANm/PclY3yk2nLRC5R4gf9DwOxxGK5jojVQtS5DR2nSgnaZWCp1k9IVRqVdfkKqmnYdzT1vCRyXnk4kZAD2uFLT9sm1REuE+W9IXsXsOzNaaYq4qT4Zzenv5c836tmHRFGUlKc3PxeIcJ7aMuCOELfnGSobOiO6+VSJbsZAJ9Z07tcAUub7jh3QfciCzIrN+W73eP/G7/vNNTA8Amrp7Z8c378lDPrMW68o4ofx/9c0z/R/yKOdBvIciLznDv9+KC/PCBXCZEzcSRjEvBSkCjGS0hTiUR0I0vOITBnHlrb92BDltAMBR6xq/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from CH3PR11MB8775.namprd11.prod.outlook.com (2603:10b6:610:1c7::5)
 by CY8PR11MB7010.namprd11.prod.outlook.com (2603:10b6:930:56::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Tue, 19 Nov
 2024 20:51:00 +0000
Received: from CH3PR11MB8775.namprd11.prod.outlook.com
 ([fe80::d17a:fdd6:dfc9:19da]) by CH3PR11MB8775.namprd11.prod.outlook.com
 ([fe80::d17a:fdd6:dfc9:19da%4]) with mapi id 15.20.8158.021; Tue, 19 Nov 2024
 20:51:00 +0000
From: "Daniel Walker (danielwa)" <danielwa@cisco.com>
To: Hans de Goede <hdegoede@redhat.com>
CC: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, =?utf-8?B?SWxwbyBK77+9cnZpbmVu?=
	<ilpo.jarvinen@linux.intel.com>, Klara Modin <klarasmodin@gmail.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Danil Rybakov
	<danilrybakov249@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "xe-linux-external(mailer list)"
	<xe-linux-external@cisco.com>
Subject: Re: platform/x86: p2sb: Allow p2sb_bar() calls during PCI device
 probe
Thread-Topic: platform/x86: p2sb: Allow p2sb_bar() calls during PCI device
 probe
Thread-Index: AQHbNeKxizzLej0qw02u6pHMIY1jfA==
Date: Tue, 19 Nov 2024 20:51:00 +0000
Message-ID: <Zzz6M9y+X/o39f7N@goliath>
References: <Zzs1rw1YcoEEeW7+@goliath> <ZztABO3TyJBekZRs@smile.fi.intel.com>
 <ZztCB5hN2NBnPgiR@goliath> <ZztF7FKaBwZKs5dk@smile.fi.intel.com>
 <ZztQwLpoZDZzbi6O@goliath> <ZztjcntEj5Eo0Rw9@smile.fi.intel.com>
 <df1fa47f-7efb-4b0c-8ef6-100b12ab1523@redhat.com> <Zzt2JNchK9A0pSlZ@goliath>
 <p3lt3psoxenwlvxu6yjpjk4yskrplagj54vk4vxkg6biudghus@go6hpoakvfwh>
 <fbe53f25-2cce-4c1d-bace-e7976c4ba20c@redhat.com>
In-Reply-To: <fbe53f25-2cce-4c1d-bace-e7976c4ba20c@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8775:EE_|CY8PR11MB7010:EE_
x-ms-office365-filtering-correlation-id: 5eef267a-5a14-446b-b358-08dd08dbdfda
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RkxwcE92YWtUclF6dE14ekMvaVErUDZ4L3RZMGJ0dTBWWWtYcDF3S1hOZmNm?=
 =?utf-8?B?WXplMTY4L3NpQktNcE1CbjFIYS9hS0ZDSkp4MnpxWkx1OTBGdzlld09nRUNh?=
 =?utf-8?B?WUR3L3I0SzJpdi8zczdqL1FNRTNSdkdtemkrZ3JqRnZzVFNRQ2RCd0s0Zkxi?=
 =?utf-8?B?R0s4UHk3ejFzR0NxaFMvQ2tycHhqRGo0R01oSmFKVy9meXN5dUNCZnlPTDU0?=
 =?utf-8?B?YlFET2xqQzVIVG9hSmZpdFl3UTR3UGdDSGxQY2M3TmxwVDJ4K1ZQZzVFNkgy?=
 =?utf-8?B?bWx0Q1NQQ1RMSVUyamZHclQ4ZXArd0ZQK29mbU1xZzBnaWx0S3ROZzV0d2NO?=
 =?utf-8?B?R0xBZnJXY2xacXp0QnFNNDJiTEtBYk43dEVKbWRFZDcwY0Q4NER6aUg5eTFN?=
 =?utf-8?B?UVJoOFE4VkZpWnI4RkwxaDIvdmdYcDdGVnhmL3lrQXNaUDFkcnZpV21EVkkz?=
 =?utf-8?B?bEd1WENyYTM1WDExN25kL2J0U1NPd0NDbkY4SjhmRnB2T2N5YnJSV2c1UUxp?=
 =?utf-8?B?eTRRVG5ybEkvek94VmVIV1IrMFRINGlQeWVmdUp0eS9nRm9XUW1mQmVneU96?=
 =?utf-8?B?VGJmUVgwSFZaUGU3ZnM3YmdtS2QvQmszM1RmUmJiRitpN0FrYmdVU25lQVBD?=
 =?utf-8?B?WlRhd1JiQVg1cjYvNW9raU80Z3FUci9aS1c2L3ZBMWdPVjJPVUE0MmswcHE5?=
 =?utf-8?B?Y1hCbm5HU2cxbjk1ZEpqaW9ZQ1lLQVNHcVRkbmoyanpWYXBETDdUL1ZGTS83?=
 =?utf-8?B?RkFSVlQzNnVSTkhLaEpuNUd3a1RNcWJRaXM5aEN3OWpmWHdHemd3a3ZrR05t?=
 =?utf-8?B?NG9hUm9vMHp6TFFTTjkyYnNhc0xhSi9vcjhQbkM5WTNwbXg0ejc3ZTF5SUk2?=
 =?utf-8?B?RkV4NnNmZWVIanF6MGdQbEZBV3IyV2Z1eHFhZVc5cjJlSnM4MGJHejFiYy9F?=
 =?utf-8?B?UGtMbFpRSXQ1eko1OE1qL3ZCYk1yR0crNi9wczhXWWxSR1B1QzBJUmR2WEtG?=
 =?utf-8?B?UmhTY2NRVUcrVGRWNENGeUhReEpPWGg0RU9Kb2N2QlBpYisxTytYUmoyZWgr?=
 =?utf-8?B?cEtoQU9UOGZrWWdXZG9OSUU3YUhZN2pKVW1nc0FhM2drM1RRTUNCVVIxSTZs?=
 =?utf-8?B?RHhPZWE2TTUySXlnSkpydHRrd0JwdWxXRmgydy9qQ0JXY3lrdVhuM1o4YWxQ?=
 =?utf-8?B?RXhDdEI1VEo4OU15KzhmTlF1TGJlanRTTVlMaGliZmdkU1F4V3YrUTlTblNq?=
 =?utf-8?B?UUxuVzREa21kazQwcGNWYWRVYkw3Q01QOFJKQzh1SGdGenVTT3pyR1ErT000?=
 =?utf-8?B?U3V5aEZ6b2hZUm1jbUNnM2lCczR4V1UwbDVrY1BmVEdtSlVjbnFra0hnNm00?=
 =?utf-8?B?WUZCNjJFVzFCYlRrNnIwT2RsZE9RWWVqRlovb0h5MUJuSkt5MVV6ZmlqTDN3?=
 =?utf-8?B?NVJ1Q1pHRkdSMDAyeGhkZUJuTmFFTjBMaVBvZU0wMjNiRFNzL1NYUVJ1UC9r?=
 =?utf-8?B?WjlraWIveDdWNG9yT1J3WG5YVkRQK21LVW1LOGpjT0NKelcyVURudkZ4UWtZ?=
 =?utf-8?B?Z3g2OE1yN3RzMlk1akN6SFZhU1lwbk5nNmhXenphanduMkFWdXIzSHBtMk1v?=
 =?utf-8?B?SS9Wdnd6NmtodVNnclRmdHBnWm5IcFdlWnZRY3p5bWFEUUFjWThTS0tUN05P?=
 =?utf-8?B?TnoxNk1NbFlOcTQ5Q3lxNkQyVkFCS0ZhaEMvaTRFQkJVUHEzVGZLbmlCcEVR?=
 =?utf-8?B?V3JvNTllY0F0RnhBdm1jVm1wblhvcWN6VWdpR1RZcmRwZTFYYks3TGFCN1JB?=
 =?utf-8?Q?lVfWScmgP/xy+f5TwjMg1suJsRkIv8mSiCZaw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8775.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V0xDK2d6R2N4TG1jUkR5MnZwa2d4ZHpUSVB5cG5RZ1BxUG5YeitjTHorVVFp?=
 =?utf-8?B?Y0Ezdmwxd1JPSGVMRTNLdXhSTkVreFh0UnFQa1F0dEtKWGVyNnQra2hHODlI?=
 =?utf-8?B?NVk3WTVSM3JDUlQyT2pnd2pyWWJ1SmVZQkFVdFhROFRYaXhpcXg5WHRJYWxY?=
 =?utf-8?B?VjJEdHcyY3JPSkFyNlVnb2hlVEd1ekQ1RVgySEZmQ29yL2J5akNrTmMwRkM2?=
 =?utf-8?B?QW5pNEpZdW9iYUVnMFZoYmNqNmVOaFVHbVdIM3psOXFBNkhmdVp5Vm95NENX?=
 =?utf-8?B?MWJCakFKSGJNZW5uUUJYSEtJTmJ4STB0Tk82QTVSajVibDViQ1NlajM1NXNk?=
 =?utf-8?B?dUtKSHJ4VTVEQzJ2RFRKeUFCRXp5TWJIVlpNenprUGlVcjQvNWVxMEQ5VjVK?=
 =?utf-8?B?aEt6RjZXVTdCRHBRNnErQmlFTnJqbEwrQkxGbkpqNm5GZS9ZOXRuVGhkNkw2?=
 =?utf-8?B?Vm5icTR3c1k5YStUbnJzVjE1TDQvVHpPUG03dStpSHBBNDdkaFQ2a01QMkpK?=
 =?utf-8?B?c2VGZGc4T0tObzZNVit0cjBZOUpRVmJCaFZNV1A3OFc5ejNxTVpnQVRuVlNq?=
 =?utf-8?B?TkExbnhsMmxmTFp2VVAxQ0w5bXpFMHBKK29ENVZBQWZ2anNEZHNPREIyUmxs?=
 =?utf-8?B?OG1nN1ZSMHBsQ2dMSjZGNkkrTGxhZ3VPL3RETkl0RWpJbHU5dVBBb0hZWmZt?=
 =?utf-8?B?bkVGdVlnTDQvVEdTZEE4Q2NEVnV2RXhVQ2VuQVZmcWQxOWU0RHA2Um5OeDUv?=
 =?utf-8?B?TysxSDZuNjNIQW9wMXdEWVkxeFlVM2JKY3lLQmlaVmlIenVEcFgrVG9xZHNi?=
 =?utf-8?B?eXJiWHlHak56T2NiYVZCT1Z0VXRWcU5QRnNmMUwwVUwwWHhOUjFlbm5VQWNQ?=
 =?utf-8?B?L0RNZTFjeDNrdVI1NXd1VXI4cXFWS2paSzAyNW8zZkJlV0EyRDloZXcyM2Rp?=
 =?utf-8?B?QTlSZm5WQWxJOXB6ZlBnQU9kTW1YMnJzd1cvK3ErUFYzMW1aWTRVQjQrcC93?=
 =?utf-8?B?czU0aWZPODRRNVkrQTRMdW9xdWdlWCtwUXFOVXhYdVdTZmFqMW80Vkp6dFND?=
 =?utf-8?B?ZmZuRUgvYjFxalQrT2xUb3ZEaDBGZUhaZE9RZ3VUU3dadit4SVpJaWE1UzNS?=
 =?utf-8?B?Ukhjb0I4cXBaTHllZUYzRHFoUWpFVFdkM0tFTHJ4Q3RDVFNxRmNhUU9CLzRz?=
 =?utf-8?B?ODFYa3Y4WUNXaVVQUUYxdS8vL3h3ZVoyL1I0Q2lISjZpa1haMnJwN3RrRVZI?=
 =?utf-8?B?NzZ4OWg4cTQ0OWNZK0w4dXdlZWJSWGpHai9oQVZ5YkZmUkNjZVVXQW9oR1pP?=
 =?utf-8?B?dGRFWlBaUVhPaEt3cmRWSkkzRGMzNitNejRnWUlBYmE2a2MxaWhmS2tiUzRz?=
 =?utf-8?B?NmZ3YkJ4VDlnV0ZHb1F5KzR0b2lMQXpBNkVZNGdsTWtpNFJOVUc1UG1aZ29t?=
 =?utf-8?B?VGlnSjNoblM1Y0E0bm51TTM0SGZhajE2ZmcyVkoydGErQXJmalExWnVtRjNs?=
 =?utf-8?B?TFpiR2U3bVhoYmt1VGIxYkIyNGxuMWZ5Z2E4NTNKZFF0VzF2YjlIY09LNVM2?=
 =?utf-8?B?ODB5Y3Q1ajZUWmpJeU93dmFweXczL1d4STJZZ0YvdCtxZC9yYmsxSysrd3pZ?=
 =?utf-8?B?eXRPQkF5RVFLT3BWZjZFaUptUytlTmplS21SMXlqVWZSN0N6REY4ekxpVHhC?=
 =?utf-8?B?MlRvTmlPSGl2NkhVRWV0ZlRkK3dkU0tDeXNLRTQ5YUNMalUvT2hlZjNWcEdX?=
 =?utf-8?B?OTYwMm9FTHRwTFZycEJXdlY1RzlNdE1Qalp3ekxIcWZ5K3RablMxOVBZK0dY?=
 =?utf-8?B?czJOQlRBNzFLcVBPd2hTSkZ2b055QllQVG9Xa3o0NjJ4MHZuTmZCQktGSVhq?=
 =?utf-8?B?cE1yWG1jV2FtNEFwMlZoSzdFUTJhZXNKdEt3VkdkdlZFMFJQQTRYQXI5UEJJ?=
 =?utf-8?B?VVh5dzZ2TGhRbnVOdFRUQ0tjZ09qVzJJYkdFNEdtNDZSb215U3dkeFRiS3Vq?=
 =?utf-8?B?L1NJbzB3OFRqempRRkxZYVhMTHlMQ0pSTjA3VysyTmZka1F3S0t6SG5CSmtQ?=
 =?utf-8?B?RWNJazhiT3hVN2syWUlyelhHSjlEVkszeHA4aEhxRkduaFFMMmVxR3N6Szdw?=
 =?utf-8?Q?yHRXgqfN5MFAH7bTrJ0xM861m?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF2378BE5C702D4B813CAE89341BFC09@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8775.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eef267a-5a14-446b-b358-08dd08dbdfda
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 20:51:00.2485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0I2pHmYtefoMeAffs/rSdWnGLEgVs6O1JorFbb48r1RYBE8DIGxoQMbyiItA+uQ0+F6aBlxxKJKVSuXFxPNDbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7010
X-Outbound-SMTP-Client: 173.37.147.252, alln-opgw-4.cisco.com
X-Outbound-Node: rcdn-l-core-04.cisco.com

T24gVHVlLCBOb3YgMTksIDIwMjQgYXQgMDc6Mjg6MTZQTSArMDEwMCwgSGFucyBkZSBHb2VkZSB3
cm90ZToNCj4gSGksDQo+IA0KPiBPbiAxOS1Ob3YtMjQgMzoyMCBBTSwgU2hpbmljaGlybyBLYXdh
c2FraSB3cm90ZToNCj4gPiBPbiBOb3YgMTgsIDIwMjQgLyAxNzoxNSwgRGFuaWVsIFdhbGtlciAo
ZGFuaWVsd2EpIHdyb3RlOg0KPiA+PiBPbiBNb24sIE5vdiAxOCwgMjAyNCBhdCAwNTowMDo1MlBN
ICswMTAwLCBIYW5zIGRlIEdvZWRlIHdyb3RlOg0KPiA+Pj4gSGksDQo+ID4+Pg0KPiA+Pj4gT24g
MTgtTm92LTI0IDQ6NTUgUE0sIEFuZHkgU2hldmNoZW5rbyB3cm90ZToNCj4gPiBbLi4uXQ0KPiA+
Pj4+IEhhbnMsIHRoZXJlIHdpbGwgYmUgbm8gbmVlZCB0byBmaXggYW55dGhpbmcgaWYgdGhleSBp
bXBsZW1lbnQgY29ycmVjdCBhY2Nlc3MNCj4gPj4+PiB0byB0aGUgR1BJTywgaS5lLiB2aWEgZHJp
dmVyIGFuZCBib2FyZCBjb2RlIHdpdGggR1BJTyBsb29rdXAgdGFibGVzLg0KPiA+Pj4NCj4gPj4+
IEFncmVlZCwgc3RpbGwgSSdtIG5vdCBzdXJlIGhvdyBJIGZlZWwgYWJvdXQgdXMgaGlkaW5nIHRo
ZSBwcmV2aW91c2x5IHVuaGlkZGVuIFAyU0IuDQo+ID4+Pg0KPiA+Pj4gT1RPSCBJIGd1ZXNzIGl0
IG1heSBoYXZlIG9ubHkgYmVlbiB1bmhpZGRlbiBpbiB0aGUgQklPUyB0byBtYWtlIHRoZSBoYWNr
IHRoZXkNCj4gPj4+IGFyZSB1c2luZyBwb3NzaWJsZSBpbiB0aGUgZmlyc3QgcGxhY2UuDQo+ID4+
DQo+ID4+IEZyb20gYSBmbGV4aWJpbGl0eSBQT1YgSSB3b3VsZCBzdWdnZXN0IGlmIHlvdSBjYW4g
bm90IGhpZGUgaXQgaWYgaXQncyBub3QgYWxyZWFkeQ0KPiA+PiBoaWRkZW4gYnkgdGhlIEJJT1Mg
dGhhdCB3b3VsZCBiZSBiZXR0ZXIgc2luY2Ugc29tZSBjb21wYW55IG1heSBoYXZlIGEgZ29vZA0K
PiA+PiByZWFzb24gdG8gbWFrZSBhIGN1c3RvbSBkcml2ZXIgb3IgdG8gZXhwb3J0IHRoZSBwY2kg
ZGV2aWNlIHRvIHVzZXJzcGFjZSB0aHJ1DQo+ID4+IFVJTy4gVGhlIGN1cnJlbnQgc2l0dWF0aW9u
IGlzIHlvdSBjYW4ndCBtYWtlIGEgY3VzdG9tIGRyaXZlciBpZiBwMnNiIGlzIGVuYWJsZQ0KPiA+
PiB3aXRoIHRoaXMgYWRkaXRpb25hbCBwYXRjaCBldmVuIGlmIHlvdSB1bmhpZGUgdGhlIGRldmlj
ZSBpbnNpZGUgdGhlIEJJT1MuDQo+ID4+DQo+ID4+IEluIG91ciBjYXNlIGl0IHNlZW1zIGxpa2Ug
d2UgY291bGQgdXNlIHRoZSBhbHJlYWR5IGV4aXN0aW5nIHNvbHV0aW9uIHdpdGgNCj4gPj4gcGlu
Y3RybCwgYnV0IG90aGVycyBtYXkgbm90IGJlIGFibGUgdG8gZG8gdGhhdCBvciBtYXkgbm90IHdh
bnQgdG8gZm9yIGRpZmZlcmVudA0KPiA+PiByZWFzb25zLg0KPiA+IA0KPiA+IEkgZG9uJ3QgaGF2
ZSBzdHJvbmcgb3BpbmlvbiBhYm91dCB0aGUgY2hvaWNlLCBidXQgSSB3b25kZXIgaG93IHRoZSBw
MnNiIGNvZGUNCj4gPiB3aWxsIGJlIGlmIHdlIGtlZXAgdGhlIHVuaGlkZGVuIFAyU0IuIEkgY3Jl
YXRlZCBhIHRyaWFsIHBhdGNoIGJlbG93LiBJZiB0aGUNCj4gPiBkZXZpY2UgaXMgbm90IGhpZGRl
biwgaXQgZG9lcyBub3QgY2FsbCBwY2lfc2Nhbl9zaW5nbGVfZGV2aWNlKCkgYW5kDQo+ID4gcGNp
X3N0b3BfYW5kX3JlbW92ZV9idXNfZGV2aWNlKCkuIEluc3RlYWQsIGl0IGNhbGxzIHBjaV9nZXRf
c2xvdCgpIGFuZA0KPiA+IHBjaV9kZXZfcHV0KCkuIEkgZG9uJ3QgaGF2ZSB0aGUgZW52aXJvbm1l
bnQgd2hpY2ggdW5oaWRlcyBQMlNCLiBEYW5pZWwsIGlmIHlvdQ0KPiA+IGhhdmUgdGltZSB0byBh
ZmZvcmQsIHBsZWFzZSB0cnkgaXQgb3V0Lg0KPiANCj4gVGhhbmsgeW91IGZvciBsb29raW5nIGlu
dG8gdGhpcy4NCj4gDQo+IERhbmllbCBjYW4geW91IGdpdmUgdGhpcyBhIHRyeT8gSXQgc2hvdWxk
IGZpeCB0aGUgcmVncmVzc2lvbiB5b3UgYXJlIHNlZWluZw0KPiB3aXRob3V0IG5lZWRpbmcgdG8g
cmV3b3JrIHlvdXIgY29kZSAocmV3b3JraW5nIHlvdXIgY29kZSB0byBiZSBjbGVhbmVyDQo+IG1p
Z2h0IHN0aWxsIGJlIGEgZ29vZCBpZGVhIHRob3VnaCkuDQo+IA0KDQpUaGUgcGF0Y2ggcmVzdG9y
ZXMgdGhlIGRldmljZSA4MDg2OjE5ZGQgYmFjayB0byBsc3BjaSB3aGljaCBpcyB0aGUgcHJlIGNv
bW1pdA0KNTkxMzMyMGViIGJlaGF2aW9yLiBTbyBJIHdvdWxkIHNheSBpdCdzIHdvcmtpbmcgb24g
bXkgc3lzdGVtLg0KDQpEYW5pZWwNCg==

