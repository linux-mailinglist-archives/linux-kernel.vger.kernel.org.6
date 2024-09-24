Return-Path: <linux-kernel+bounces-337271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E129847E7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 16:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36D7528663D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F411A4F1A;
	Tue, 24 Sep 2024 14:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="Gc5ySbop"
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com [148.163.133.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E281A4F3E;
	Tue, 24 Sep 2024 14:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.133.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727188958; cv=fail; b=pxAqSVxLsKETLCAYbML9I4mAOrWYEmwif0Yi8B6sSAs9DnFimH5hhLTDuWPffm/52Xq5NH/vsZdlexL5xqY2wmb1kPlpPHAQDjHlCJrwET+MmTUD2llHpjalhjtVdkE2369QEuCuIErz7MyRvaW6oy6ur45C+/Sdd97rbxGxOAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727188958; c=relaxed/simple;
	bh=mApZigBm0Gk7oILNv9tSWch0gBnw+/ScXlpBQKFHzaA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uUCjNN3LBK5DfG2Qm7+q7da6MkaNeuLInaUC5uu7vbMyvY1ChLIkdIummc+LaAci2J/qx2q8MNjkjUl57YWaqjb9jakvJPOAdEMWEIeLjgFAueYToPjNacALG/JSem8YovceSa5C0eAWgXf8qFtGSayuSic7NG2zpCgavp3c3zw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=Gc5ySbop; arc=fail smtp.client-ip=148.163.133.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48OBJrtW022647;
	Tue, 24 Sep 2024 10:42:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from
	:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	smtpout1; bh=mApZigBm0Gk7oILNv9tSWch0gBnw+/ScXlpBQKFHzaA=; b=Gc5
	ySbopX1vmjasCaMYC6CXpdkz2TEUnLEaQE8AuC9o0aA8QCDrC9m79igvN8edFRkc
	8PpfG5R2K1ROS/H/vtebNX0TWRnB+8Fr+Sq8eMiuGv/GrjNRJyBVl9X/zBVP2l+L
	o0Hk4yc2846cZfT2TGkbL0305DkzicmgtbD4oEMADEETXexKHVO7Qz0dlcrSYj8M
	dQcL0s4/FdEdGVjIKY302w4H5E9tfIfIa2omQ3f5wYcxtXh4NaDzBggFlvfRXVwt
	XZbhmIjsH7HlYCmP3DxtU6K8KhHc2ckX/skZrH6GhnON734/QPolUp86XIPxX+W1
	B/Rki3PomQLIg69pcRw==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 41u36rfrun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 10:42:32 -0400 (EDT)
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48OEf5pt036539;
	Tue, 24 Sep 2024 10:42:31 -0400
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 41utkqmw6k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 10:42:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dCOipz317c1YIAJP6vyZ9QePP96REzaGLmOjRyfvQW8ftj0zT8yRvzkTL6bhqxttW90T0z2HaD2Y6Bu0ou+Mex5ZuLgTL7+P564R7ZJvz4X9Y0aE0/fPQvVkgb6tLSRL8RNXuDupD1kuVEG/zJtThexu/TDnltKtS9H3n+C/JRTcAswl13W31nvxuczRWiGKbUIT9yFT/b/ap7mG6818fLlknoPN6HD2O5yU0UiyffIUPLX3gHZiNtCrzd/O1gISdSkh3z22q6rNn6oFP27fQx02ijBquJybjMjZjnzk6jZzgSO+TcqpudGOGm2ky6TV6/Uyt5dWWYz3kCAKGCth3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mApZigBm0Gk7oILNv9tSWch0gBnw+/ScXlpBQKFHzaA=;
 b=DWUI8kl8I6dfYIwCKMqoex6scMglOfCE1fpIL/Jxqu4tQQes04Lx2e4RDx0tDu6GCDTQntWPXP1xp3vVZqWZavfGd1Q16FZIbHqw8L49sYJiutIH1gDPGy5li+SGlOMCKlQIKiQiXfa/Ep1tdlzzQ+Ty8oIJRVUcFKg8a9vqedCK7nG6cTz7AijbkPgntbCmxTY0993eiP5ROwfF3/N5kLRp+NDNu5tg1KWIoV2SdNxMDAzSDYP39/jKz9vd3V+kxV409V07fvQG/O9kQsYibzYV2gGvvAzyCYrBYo7Ql55XEIl9shJHpIQEu4cuV8LD3l3Js65YJV/u86Ac8QkKQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from PH0PR19MB4988.namprd19.prod.outlook.com (2603:10b6:510:99::17)
 by SJ0PR19MB4605.namprd19.prod.outlook.com (2603:10b6:a03:28e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Tue, 24 Sep
 2024 14:42:27 +0000
Received: from PH0PR19MB4988.namprd19.prod.outlook.com
 ([fe80::1079:e3e4:be37:8589]) by PH0PR19MB4988.namprd19.prod.outlook.com
 ([fe80::1079:e3e4:be37:8589%3]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 14:42:27 +0000
From: "Wang, Crag" <Crag.Wang@dell.com>
To: "Tudor, Laurentiu" <Laurentiu.Tudor1@dell.com>,
        Mario Limonciello
	<mario.limonciello@amd.com>,
        Crag Wang <crag0715@gmail.com>,
        "Ksr, Prasanth"
	<Prasanth.Ksr@dell.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: Dell Client Kernel <Dell.Client.Kernel@dell.com>,
        "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Wang, Berry"
	<Berry.Wang@dell.com>
Subject: RE: [PATCHv2 1/1] platform/x86: dell-sysman: add support for
 alienware products
Thread-Topic: [PATCHv2 1/1] platform/x86: dell-sysman: add support for
 alienware products
Thread-Index: AQHbDj84OhQozpGmYU6l6KFlQ9svh7Jm7agAgAAThICAAABNUA==
Date: Tue, 24 Sep 2024 14:42:27 +0000
Message-ID:
 <PH0PR19MB49884B9347569041F4EE234BE3682@PH0PR19MB4988.namprd19.prod.outlook.com>
References: <20240923063658.411071-1-crag_wang@dell.com>
 <20240924050302.317522-2-crag_wang@dell.com>
 <0a31cb22-e3f9-4212-8fc1-77d6cafa7277@amd.com>
 <CY5PR19MB61479854D62CAD389C99BA15BA682@CY5PR19MB6147.namprd19.prod.outlook.com>
In-Reply-To:
 <CY5PR19MB61479854D62CAD389C99BA15BA682@CY5PR19MB6147.namprd19.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=83462e2f-3ea9-434e-8041-cec6fed885da;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=0;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2024-09-24T14:31:56Z;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR19MB4988:EE_|SJ0PR19MB4605:EE_
x-ms-office365-filtering-correlation-id: 330d34de-5123-4fc6-abc2-08dcdca71c37
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?XNnMjBqr0ybyXK/LSMML5QhNUojQodW92HTrCCrungO2qnP+PvFIPtEWZp?=
 =?iso-8859-1?Q?5/une3C7sJ+G6VcB3qMOb34X26/wqS75/8KzKirdoefaaoIjFgMfYmL5Lm?=
 =?iso-8859-1?Q?+Z0p0+P/xQ2Q25OgfBbYs0V7HabPy5w4OKVdKqIqovwH9jDZX4o5ey2cqM?=
 =?iso-8859-1?Q?4gw83ffEH1uxaItK/texUhy97b5qAYqlLIFw2Hc9K8if6U4ywvB2LXEXCm?=
 =?iso-8859-1?Q?8d8c7Q3gHOIMtvKtJsHjANzjjt6JHD1i9+//kerKLJTOpxhMlOyzYzkz7E?=
 =?iso-8859-1?Q?KibBFlW9wIwgAjGyxZizDwFH82QIfodVU5fknEtXiET/c8oGUSJwbV+cOM?=
 =?iso-8859-1?Q?IDp46fYXXQp6ZPMEkB4JKjsCyR8o07gEhGOK/32afbBDN+MNlIxq63O6Kk?=
 =?iso-8859-1?Q?TxTMAEyY83x5qrDmEbvPQzrVRlC/cI6eSF2DNo5M75uzEum0mg4+g6sQeD?=
 =?iso-8859-1?Q?zNvQLoWpLrT5Y1r2UfTnRVGUOSOB5dWNquUMa6Zg1tp7O++7qajEUZjsAC?=
 =?iso-8859-1?Q?UqnrtvEISvcHdbLra1dkIQGSMCU9if2VPQ/PFrDGQoDTaCM3FyN/JskxQl?=
 =?iso-8859-1?Q?dOCs7dVlFRvbyIvahFokjI7rRvSY3XItoCKg37hjH0WxY2XecWcAy4o3MQ?=
 =?iso-8859-1?Q?niQksV27KGXnqmDpqHVDvq5BzEQy+XOJ6Y2CUL2Wnjitg5bbYhxhn7YPJ+?=
 =?iso-8859-1?Q?daeH84oaGyCAxabpHv8V+V/hyzWkj90mH8S1pApifIlQhgLkbZld24mkL3?=
 =?iso-8859-1?Q?BtMuEhjLBfcjWuAxXGb2k71jmgx3NGDoYVW0pU0XsY8tEbzeyiDRdxZL2Z?=
 =?iso-8859-1?Q?i6qZq4bng4hGEYaOeyLcq+cn7l9N661jHjzjzAE7tjxN2a5ZUlvwACCI97?=
 =?iso-8859-1?Q?+0h4myilgHK1M8lE7Uhkw8rWDkHwr5miIUk/DT/Ye1rF+ZQWFqCVyxWd31?=
 =?iso-8859-1?Q?4kNRbvWOeBhB7AytOwwZ6UG1uknPieDijejon3ml2+gR5Zv71n66Xz6lAK?=
 =?iso-8859-1?Q?69m59p09qbvRRdzXn+bLIDXnjlNkXB7MqVIr2Nkg2yKtaaZXfVNpVUt/JI?=
 =?iso-8859-1?Q?UKId5FB31MAA/cMpG5wgAHwLY33d5qDE/5Vh+Dv7zaFn82J4mF9jzbz3I6?=
 =?iso-8859-1?Q?dHyKj1cC3GMpvTyRP3lL4geX6D1UxTdJZF7Uw/bokuw027OTiBE2YgiOqN?=
 =?iso-8859-1?Q?UyjKyRtaeZfHYfq5RVnQd0ism55d8dOn2slQY8oKvM5sAkFQER5RngXoKb?=
 =?iso-8859-1?Q?0GD/HwdqGLq9LEew3KuR+pNC/U1OCPwWZdXFCt0OxwDETCL0ulkXPK1u0M?=
 =?iso-8859-1?Q?CAGAPlz8ilQcmHyagye/3f/VPWzOd7wKS/ukNSGQPwQ2+9cpxzd1C2hsXS?=
 =?iso-8859-1?Q?1d/TaXA7HQuaWrFm4/5/R9xm/tD2Bu4NNo8P8Ey7m+8PM/T2OIuxlOsOjb?=
 =?iso-8859-1?Q?6m/A1sT2g5r7X6R0p3CL4kGVaBr7fCFx9TrzpQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR19MB4988.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Vpbhr6oWOz6OtZLYKr9ofSfAc0jEeu17FYzznccb2i44K7fGNm8yOIYaP+?=
 =?iso-8859-1?Q?JuNrORTRgE6jcJ87RNH7dLEY8a3ou9PosVwz9khQN/RcHQ8K+SrOdgojD1?=
 =?iso-8859-1?Q?K8B05gguJac6Q2ppyyNXgMddZ8X1natRVh6tXPf/t4OAGXa03/t+NTzbcs?=
 =?iso-8859-1?Q?QuOymt2YGkoYcDs9BNUZVQxI2qE3Bmtth4qUwndiqkaEio6fj8kYXOb405?=
 =?iso-8859-1?Q?L/DITCWj7RU462wt1fpl4+pvKnIiYa5xv34yuko2iEYjKBblfinbB6SoXw?=
 =?iso-8859-1?Q?vhdtWRl0JHIozJvnGls74D9GPDyiVe01jqrwmG+JXOhkj2opYzslW0OgMT?=
 =?iso-8859-1?Q?BrrL9zwx9cZiKMoaStNJ2UA+iy0FHRhKw8AwrVGFm+e9JnWK3N+ErMnitH?=
 =?iso-8859-1?Q?Fe5FO2EMOnCjWxhzI/Vqsic1eCcMPiO5nKeNgUJnCT98pbrzRqXkmCAZd6?=
 =?iso-8859-1?Q?kz6YD46Iwc2FLEOm6A9BLqNkGSFXCTEzkZxgKhaLlvpF2tOIFHaxHbqyRe?=
 =?iso-8859-1?Q?XMVtjDNkJjKmNmAYBBqp0s8g4viJ93+ynU54k0JWk/DJBdS3+IaUV/daPH?=
 =?iso-8859-1?Q?mFlOEJlTm33muIzarwVzetYmjZpTylSoV+FtVbHyPL6FaiyDNQje1ddLgM?=
 =?iso-8859-1?Q?pnlFTkG2D1MsJcExhHHF3f0IQADFX7fPbintkIxW1yjVue/9FLZauvCCsg?=
 =?iso-8859-1?Q?QFPZYX/3SFxnlUz7pbcdaKJ8lj9kwWkj7BmlCT11xXdB7s5yq4WkQvp/XM?=
 =?iso-8859-1?Q?Sd5AWNFYEQ8WYqIU/ZP4hF1bqn7TqQyE+jVJYddlELeDPj6g9JDBefpEVK?=
 =?iso-8859-1?Q?KaRwDdQm7p7/iPcHBW0LSsy52OBXJcMW8fgJ2J1Uam/YUzjcO+zX5gN2sJ?=
 =?iso-8859-1?Q?9BFnV7aWC2H7oeGcUCa8s8MdNi4FeXagThI6aH+Ixqmtif8hSdmxLUUhKJ?=
 =?iso-8859-1?Q?kcjUo37Ie5U2/JSHfnGhSRx1fsMjIduDU6jkwVmWWa255P5grbR2eSRqAz?=
 =?iso-8859-1?Q?Vzi3OU2xniW/yKB9VYoPjgtArRvtt2A5wWWktXLY9QSfgMQQcLS1N2yi/1?=
 =?iso-8859-1?Q?vDKEDFDFrcRk6bIRbwU7UVvIVynzCq3/KPvrUt5otTMTIJhi6hQGQV0W00?=
 =?iso-8859-1?Q?sgLKtTcybclYHUlVHlzrMN1pdVAPMUlBkJSHacijlI2uBqrbe+Pr5uWpBu?=
 =?iso-8859-1?Q?ESYiQdQHz49911khyD+6mZzMNU0VPKANKakc9X7vawicagzrvz6zLZxgn0?=
 =?iso-8859-1?Q?RYc9hi7oNaCQzusNA26yuEsGu5UOuTUit8ZXsno4eawxERgG/x7OyK0xiz?=
 =?iso-8859-1?Q?ngNrL//k8TQXFGNjHCw8NhnQHaKEwJ+awgRE7v/aug9pNYxeE80yJu1yGT?=
 =?iso-8859-1?Q?Bh9VEs8S1JhYuYRyxN9S4KnVCA+4O+C4w4hbuTezHlpadNTSEmaftlIMkU?=
 =?iso-8859-1?Q?dpJJ3WMsz6btvSGhjESoL87Gk/Z5j2Hn48gcp4SLkLr9w9g0u6jzqyj7xO?=
 =?iso-8859-1?Q?UUKH7xS1D8dUcTo4TjYdsRJEOAaEkNvGRfcKxFaSSoM+ErnhGFBfJll69t?=
 =?iso-8859-1?Q?+RtbIuRllRGVRdB4RFTibh4MoKUh2zKnz/PPKYElUTlu6+tnZlbzS/VL70?=
 =?iso-8859-1?Q?DwvxE/5UHxVW8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB4988.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 330d34de-5123-4fc6-abc2-08dcdca71c37
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2024 14:42:27.0518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XbfpJdQ3Nr+Sssg/NQ0g/5QeaYbAVRcuW+0FkbkmahyeKO2yZBL3wzsxrU5P6FCble69sFVuUHnQChQs9jOJLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB4605
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-24_02,2024-09-24_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=703 impostorscore=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409240105
X-Proofpoint-GUID: 29-XQVgGmemoAbJiHYMCgIBMnPVBSR_E
X-Proofpoint-ORIG-GUID: 29-XQVgGmemoAbJiHYMCgIBMnPVBSR_E
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=654 adultscore=0
 suspectscore=0 impostorscore=0 spamscore=0 clxscore=1011 malwarescore=0
 mlxscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409240105

>
> Couple of newbie questions: what's the reason for dropping the URL check?
> Would it make sense to include the reason in the commit msg?
>

URL in type 11 is subject to change according to OEM ID Module specificatio=
n, for
standard Dell and OEM inclusive the string 'Dell System' should be sufficie=
nt.

Crag


Internal Use - Confidential

