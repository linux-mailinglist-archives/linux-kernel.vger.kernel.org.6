Return-Path: <linux-kernel+bounces-293635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B3895823A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE507B253F8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832C118A926;
	Tue, 20 Aug 2024 09:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="WCQCXYsM"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2086.outbound.protection.outlook.com [40.107.215.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A3418C03F;
	Tue, 20 Aug 2024 09:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724146157; cv=fail; b=MlX2XTq2KiPeEumeOflsXg1SfQqdUOIP7HEg5NKksAmuKhywwvS6d4uRJe5KeG4q6Iy4gdTdXFfl28rbz9oFt8VLD339XfRJIxZ4X4mNA0Qh0AkCkHUK2LVzCw16Ss502ILmNL1fnEik/fcsu5sO+bnPyuh4wzc9f0g+5scTQK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724146157; c=relaxed/simple;
	bh=W5qoVQM4JKqZ+hAvap7h2Xzc2IUO10iAg65FAQI5HXc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HC8u57VuH6ouF2zyNyRguIAhWCKHQUFKH7NqUHvAIPGgUP+/tCwlMKQ9WYaL588w7ZTPoCyUGQwLBsOI2YUHoxhiCrt/ECv5yOeubmp/35A+xHt8ji6gIcS0IYbA6HrlOWMKShzMER4JFi5u5JtvoZxw18pvvf4F6nkjG+cy8d4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=WCQCXYsM; arc=fail smtp.client-ip=40.107.215.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cg+jyg3XZKwk+OdwnXvGgj8z+x5QoSWg+ImrfEaRHyki2sWittQplV2jyNWNvVQ05ca/tL21i/3TtsuyQlcF/HZTGsEHnD679QOaWby2ya3PCFteQMOseDzwlt32429OMkrE9IxL4Vt5yag7rzLW65gtCZSme0TjQUzCKNTaWofibWOCAv8RjYAD0+ANKZSBXLQ8o7syp/KSlcJ7riXf2mdJKWCrhuQl4HMh+AukCTiYes4oYeYi8hCgEIIGmyS5PHFp4KBjU9cwCnOLXD2WpE2TpWDHWBccEz1Iyb9jN3aJJIDLNs78gIA7xM0XWLPM0xJVCwaWW78eZGdFTGjRKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W5qoVQM4JKqZ+hAvap7h2Xzc2IUO10iAg65FAQI5HXc=;
 b=Wbgox81tUz+LR2X91mWxPYXss/urVmFqpgM9LRnSRPSELEFHd04kFC0GsEfl1itLBOffzYXntOXWFqoMmApDTvQGuBBnXjGbhms1j0gM8M3Y5Oa7ZJ6r56mf8iLs384prOc3LtUiPTiKs7sqXsH8S1cTVcQoBmennkRf7vl7I3dK9fFKDAhkbU206P+YQZziWVF9xwzhcHebSrGRqOhoL8W//Pb5JA56+3MIe4kkEkkuY7EqbzLaNycnhvlgce5k7HPzuzDyPNuBqlR/qGLLvvJdXSKK/ke/wmab8DheRBOXu7/atCtRygF+vn/Ui8qTZve4orneFq334+yjNXSj7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5qoVQM4JKqZ+hAvap7h2Xzc2IUO10iAg65FAQI5HXc=;
 b=WCQCXYsMRyBqV3BSznGF03HZhjakVo7pdfHef5dg0DQ2z4+XL/RqhYe1aXov9T971zqUr6WBEtMsHwVh7nFkJZI7u0zulYUAN39ozjdqWZrEipElZ+IHdPzreCxyiERiLxH4qq0AARwccmeS2M0cDyoYWoTlerMNVqzpZdnzKc4APaciwwR5Ia/hMwK9/bqZmIC5akXli+feniIlIt8Yla8gki/B+UaGGcvw5ejKmMg5aaiFsdDVyqNW6aCwFT+NZRwUbo9lv6DGsLAMCQZOu9Flxt4ZTWvXspbzFX4j1SzlynGLyY0xQnhnyksJbSuY8MQBY9DiJf+jSJ1g0nZPYQ==
Received: from PUZPR06MB6224.apcprd06.prod.outlook.com (2603:1096:301:116::8)
 by SEZPR06MB7226.apcprd06.prod.outlook.com (2603:1096:101:234::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 09:29:06 +0000
Received: from PUZPR06MB6224.apcprd06.prod.outlook.com
 ([fe80::d489:3d1:904e:8b73]) by PUZPR06MB6224.apcprd06.prod.outlook.com
 ([fe80::d489:3d1:904e:8b73%3]) with mapi id 15.20.7875.023; Tue, 20 Aug 2024
 09:29:05 +0000
From: =?utf-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "quic_prashk@quicinc.com" <quic_prashk@quicinc.com>,
	"quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	opensource.kernel <opensource.kernel@vivo.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, Michael Nazzareno Trimarchi
	<michael@amarulasolutions.com>
Subject: [PATCH v2] usb: gadget: u_serial: check Null pointer in EP callback
Thread-Topic: [PATCH v2] usb: gadget: u_serial: check Null pointer in EP
 callback
Thread-Index: Adry4ybSh1NbXw2tRg+lDnWYwqiqIw==
Date: Tue, 20 Aug 2024 09:29:05 +0000
Message-ID:
 <PUZPR06MB62242AA2715789D100FA2E60D28D2@PUZPR06MB6224.apcprd06.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR06MB6224:EE_|SEZPR06MB7226:EE_
x-ms-office365-filtering-correlation-id: eb295d4d-c9e1-4b9f-2b14-08dcc0fa893d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OGtuQ2JzcCs2R1QvOXBSN0hTNlFNbERNZTY0eWZlUzljY3YzRjVWaENPU2ln?=
 =?utf-8?B?WjJvQmtGMUVSSWZzREwya3MxQlRXRS9lQ2psS1lJS2crcW8zaXpTbjNyM0tD?=
 =?utf-8?B?cFNHbUxJVi81U0pzbjMybTBwRXUyQmRRYWd2Zmo0SjZ4TjFkTVVjWVRzNFdY?=
 =?utf-8?B?Ny9aV3R6UHhmV2cyTjRrT1piTERXZXBjeUova1RFRnYyYzFvcVpGVGZ5bk55?=
 =?utf-8?B?L2lrbHc0SFNQS1NuR0psSmRMaFdpb3cyT1FOOEYzWEZrVHA4M2hyVGZkSmV1?=
 =?utf-8?B?WjRnRlZiaDhBcEczWWZpamNudmp0cTVNTjhpcDZIdDdrVHZsN3QzZTgxZW01?=
 =?utf-8?B?QTlXM1M1V2ZxN0FLMC85bjZNd0xRZW82bEF4dHF6bnNOS3hmRDQ1d3o4WTVI?=
 =?utf-8?B?MmZLNFgrQWlFeFVQQ1drQTJ6c2E3WFE3aWgxOW9WYm9HakpQc3lSVndYckc4?=
 =?utf-8?B?YW5TOHFMVFA4RkJHRzNUV1JUYUtmWmw0b1FrZ1dSL053a2ViMWdSL05wSkxR?=
 =?utf-8?B?N2M5SjhsQlplWG03Mi9wdFMyNERzb1hTWWxnaUZQcVhFdDc5bzNWUGViSTBO?=
 =?utf-8?B?WlhNM0JpYXo1a1U2Tjd3MmZibkpiWlJsRlc3aEF0QTFHOVFucEEvT0l0Y0NI?=
 =?utf-8?B?SkdJWDNUc1RBak5lR1NXRGh4aExNUlZtdnpMbENvcCt6S1Y3MmlabG4wazNI?=
 =?utf-8?B?eHViV3Z1ZFcvUWw2dFU5VTlqaEozcm56SWxYZGhxR01rRWpCYzY0dTJUNVNQ?=
 =?utf-8?B?WkdXMWdtMjNIZjZNcjZsL25CK1BEck5COVY3a2ZqMVdnclEvdDVGdVJDVm9V?=
 =?utf-8?B?SlRHNDhpL29Ldk9MOW5oNEZaenJnM1pTeHk5cy8rN294Z05UVnViWVpHY2tB?=
 =?utf-8?B?MUFNeERsYlAyd1N3d291a0NBZEJQTWRrcEVaaXk5WXZmNFFwNFFYaVI5Tk9V?=
 =?utf-8?B?KzNRSFAxTkdhdUc3alBqb0R0SUVxQ2JPT0dHMHZUT1d5Q1F5Y2p1QW9hWWpP?=
 =?utf-8?B?ekpLYTZlZ2cxN3NvbmRTM3N1ZS8wMVJjL3hQSms0S1BQWUMyZTdWOWZDdTdH?=
 =?utf-8?B?V2x1K2xucjlkKzFHanp2SHBReCt6a05MN3g3cU5UajlzbytuTXhNRnB6YnQ5?=
 =?utf-8?B?R3QvWW5VazNSMzkwY1J1bjhpOGJTRzlpK2tPeHhIVzR1dGRFWW9FRmZOWFUz?=
 =?utf-8?B?QWZXQ1RCajFaOVRPVzlpajJGYXFXalI4dDIxQzN5RVhPNURWUWZCdndSUU1a?=
 =?utf-8?B?OVpMNEphMnJ5WW92Rjd5TTBjOVRIbGR3UExDL2V5SVR3aGRaejFETzIrY251?=
 =?utf-8?B?dUg4T1pMMEdwNHZhNldHMDExaVltMGxYSEVjWG9IbDdaTm10eXBPQzZuVEZz?=
 =?utf-8?B?djd0NUh2Q1FsanhWM2tCdkhMWGhyRGxkOElSdnlmaGxqaHhzTnNtYzdHcUJw?=
 =?utf-8?B?SFZaNnFDdWZHZW40ZVN3RjZCK3ZaYStLSEdTZDIyT1ZYUmgvTGRoSnVsQkQ2?=
 =?utf-8?B?NEx5VTZmNllvL1MrNHFYeUM2KzUwZ2VzUGN5Vm1hZ1ZBMmlYYkJieDJHZ3VU?=
 =?utf-8?B?OHN2TWRPTURQK2hpaWdmVHhDenNOelZCV25rU09JTXBYMWZBSklqcDgraDN1?=
 =?utf-8?B?ZzJsNG1SSm1MMjdYUEIyWjNEb0IxTGlCSXBFZmxWRjNKVkUrRjdHV3RVVmFo?=
 =?utf-8?B?Q04zZzBpb2RmSjc1eEtqei8vQ3RPcXl5OE1OYW5OVERUODlrS2xvVVpTbWl3?=
 =?utf-8?B?bVBMS2ZzNDFaN05SV3hxazJaa1FQSENLMGlTYTNvNm94SnJ1SkxvNTIwLzY0?=
 =?utf-8?B?YVRxZmtjR0hLbDI0cUQyRVRoM2xHUXpiaktzTVVxRlZGakxwcXFtYkdwT2ZG?=
 =?utf-8?B?c0V6R3ZNS3NMUU9yQ3JXeGp1VDdFeXk3V2ZnTzFWUllPaHc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB6224.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OGV6M3A0WDVYejVMVXIzL21IYVNBSDFlTWdWTXRRbU9iaWpCQ25Obno2eEk3?=
 =?utf-8?B?N3U5Q1hiL2xRdEN2cUFhVHJGNWZLVUxVdlVaUUsybldOcTdhMDBra3pNSlV5?=
 =?utf-8?B?ZzFtRHFXTjdhcUtqZVFDQUJrTTNxMzZBam1XQjdQZWk2QmxMSVY5QzB5T0JV?=
 =?utf-8?B?SW5ickNhcjJjZWNtRnNJZGpqMUhoTnZpcVlUWjd4OTJ1MEdkK0JtNk4vSnNR?=
 =?utf-8?B?ZDF0WThiWnlHRWtmMUFFL1J4WVp3TzVPOXA5VmV1N05MRUlWNTJOTVJZYXh0?=
 =?utf-8?B?Vk5uM1ArWDR2aWJwRDFCTTlZbjBYK0ludDVuNFJLUDlsL1RUcVhLZ2V6ejIz?=
 =?utf-8?B?bFVaaVBqVE5ZTjU3M0d0Z0RLSzFtYU43dzNIZWd1eGUwMkJTcDBCSkVpR3cv?=
 =?utf-8?B?KzdBYjgxak1EMkphNlNUeEhlM211UTE1QUxQOHliVmVWalcwZWd2UEZlemxs?=
 =?utf-8?B?a3FUQWRNNHVxblc3OTF5a20xTWhuVi91QzN5cDlvZzY0enNvZHhSWHdERG9r?=
 =?utf-8?B?ME1DTVMzK2NONzNuTFlHY2FCZWtVazR2V0J0dkFnU1dMeFhqdU1NajMrcTZH?=
 =?utf-8?B?RFI4c1QyMS96S0tob2kwMGM3d0daRStLM1hGR1NXQXZKY1lDOWVCUXd6TVdL?=
 =?utf-8?B?QXpLMXhNWFpVMEdlTlZMQlFMMlJHbTY3SzRDSEw5QWF1YTZrTzVaeUJSSHRV?=
 =?utf-8?B?ZitjRkJKTitaWGdlcllVN2NDY3R5NDdES3lmYmhuWWRDMTlWb3VmNklhUEpG?=
 =?utf-8?B?YjZ2ejU5dzVveldiTTUzYW0veHpUd2tXdDBtSjVnQ3dEdDRDYVRoR0xVYmh2?=
 =?utf-8?B?c21aYjYvazRNdlJpT3pVVE02RE02MVZObzA1OWdRQU1vbVIxa2p1T3EzRVZZ?=
 =?utf-8?B?NUJIalBiTFAveWhIQ1M2Um9oL0g5YTQ3VU4zK0g1cElKOFlydUllSkt2VEJM?=
 =?utf-8?B?NDE2RjhFY2FmOXV4OUtmeVVMTUo1b1lVSDhsVnU5MjZ6QUc5emtQT2tqSFY0?=
 =?utf-8?B?UmNLVnVhZWhGckJUTWZpMUtOdVRjN3F1NWFxUXU2U0s5SWZ4N1lYSUErTEYy?=
 =?utf-8?B?M1hxY0xLRFA4U2Y5b3F0M2t0cFUvVkxpc3d3UHFZNmE3NVNRZVlsOTFIa2hG?=
 =?utf-8?B?cEJPbDJxalVBVlF1V05XYXdyRzBCMmtqZXBaYVhmeWpydCt4aGk0V3BvUm5q?=
 =?utf-8?B?Y1hqTlpIQjdFaU5hUDhiNHY3RnNpSngzbmU2eDZGR1NmL3FTMmJYaE1uZXpj?=
 =?utf-8?B?cEJERjZzeUE3eVVhS2V4SlNqd1pPekdQcWNyenAwRWdKc2xxTjJ0bzJ0bStn?=
 =?utf-8?B?ZG1NVWxIVjY0aU1Yd1E1ZHFWb3JueDhXZk83UXhWZmU4Zk8zaEYvbk5Pektv?=
 =?utf-8?B?UE1DN3h5YmdUYml5VUpINVJPVmVoZ3RtTEF1UzJxaVRzallGWnZZd3V6ZDVI?=
 =?utf-8?B?dm04YWZlK1VlNmFTVm9ma2Rvcks2MVlUMXNtT0xLMTVEVHZnYW5uZHlFYjRI?=
 =?utf-8?B?anF1dGFuVDJ3aFZMMU54UUZtNm5YQnM1YWRONXlBYlNiR09UQlBJVW5WVVc4?=
 =?utf-8?B?NEtGN0RWRE91UWo3VUVTejdhZ1hpdTVYNkdGb2hVM0xXMUt6SG1Ma0owT0Fz?=
 =?utf-8?B?enQyZHNJNlJ3WnZTcTg1NlgwQWxwbWdDUU9qWUNzLzZlN29SOVV3cUk2bXEr?=
 =?utf-8?B?bEJ3cTliS2kwNm04VG50ZTlPTHRydCs5N2VsVUJTU2x6Z0l2MjQwVjZjeGpj?=
 =?utf-8?B?ZlBPMUthU2xodmlNQnlPeHZxdTB0RU1rMFhSNW90Skw2U1diNjZJMTJWNEdh?=
 =?utf-8?B?Y2ZFNFh2YXQyY0xrc1FucjYxWTFHZXk3YzZWVkFPQW5TNFYrQ2dXV0FGSW53?=
 =?utf-8?B?bCtVRFE2ckF0VjNLWHJmMzdhc01RSU1qL0M2OHh1eXFzNE9md2MvMVI3WXow?=
 =?utf-8?B?TDBOK1JpckxmN1JPMk9HRlQ3elFYcE1xZVhpSUdpREwyOUo4d2V4dlJpRHdI?=
 =?utf-8?B?YkNmK3dKOXhwSDJmV2RJdHhORmRBOXZHeDhmWTNsVGYySHJRSHdTQ0NQaFNI?=
 =?utf-8?B?dnJIRXM5cGJsWjRVbElRejVVeDVZVFBQNGJnL3UyNHNEVlVlc0lGVUZXeG1G?=
 =?utf-8?Q?otFY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB6224.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb295d4d-c9e1-4b9f-2b14-08dcc0fa893d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 09:29:05.6317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nYP8mjNQSRGzX68b3j+4x/QDN6L71zizS9+XxMUjr4bAdjqYFyd36cfPbdO7i21EGbAa6mY35f3Suk5p0aKpOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7226

RnJvbTogTGlhbnFpbiBIdSA8aHVsaWFucWluQHZpdm8uY29tPg0KDQpBZGRlZCBudWxsIHBvaW50
ZXIgY2hlY2sgdG8gYXZvaWQgc3lzdGVtIGNyYXNoLg0KDQpVbmFibGUgdG8gaGFuZGxlIGtlcm5l
bCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgYXQNCnZpcnR1YWwgYWRkcmVzcyAwMDAwMDAwMDAw
MDAwMWE4DQpwYyA6IGdzX3JlYWRfY29tcGxldGUrMHg1OC8weDI0MA0KbHIgOiB1c2JfZ2FkZ2V0
X2dpdmViYWNrX3JlcXVlc3QrMHg0MC8weDE2MA0Kc3AgOiBmZmZmZmZjMDBmMTUzOWMwDQp4Mjk6
IGZmZmZmZmMwMGYxNTM5YzAgeDI4OiBmZmZmZmY4MDAyYTMwMDAwIHgyNzogMDAwMDAwMDAwMDAw
MDAwMA0KeDI2OiBmZmZmZmY4MDAyYTMwMDAwIHgyNTogMDAwMDAwMDAwMDAwMDAwMCB4MjQ6IGZm
ZmZmZjgwMDJhMzAwMDANCngyMzogZmZmZmZmODAwMmZmOWE3MCB4MjI6IGZmZmZmZjg5OGU3YTdi
MDAgeDIxOiBmZmZmZmY4MDNjOWFmOWQ4DQp4MjA6IGZmZmZmZjg5OGU3YTdiMDAgeDE5OiAwMDAw
MDAwMDAwMDAwMWE4IHgxODogZmZmZmZmYzAwOTlmZDA5OA0KeDE3OiAwMDAwMDAwMDAwMDAxMDAw
IHgxNjogMDAwMDAwMDA4MDAwMDAwMCB4MTU6IDAwMDAwMDBhYzEyMDAwMDANCngxNDogMDAwMDAw
MDAwMDAwMDAwMyB4MTM6IDAwMDAwMDAwMDAwMGQ1ZTggeDEyOiAwMDAwMDAwMzU1YzMxNGFjDQp4
MTE6IDAwMDAwMDAwMDAwMDAwMTUgeDEwOiAwMDAwMDAwMDAwMDAwMDEyIHg5IDogMDAwMDAwMDAw
MDAwMDAwOA0KeDggOiAwMDAwMDAwMDAwMDAwMDAwIHg3IDogMDAwMDAwMDAwMDAwMDAwMCB4NiA6
IGZmZmZmZjg4N2NkMTIwMDANCng1IDogMDAwMDAwMDAwMDAwMDAwMiB4NCA6IGZmZmZmZmMwMGY5
YjA3ZjAgeDMgOiBmZmZmZmZjMDBmMTUzOGQwDQp4MiA6IDAwMDAwMDAwMDAwMDAwMDEgeDEgOiAw
MDAwMDAwMDAwMDAwMDAwIHgwIDogMDAwMDAwMDAwMDAwMDFhOA0KQ2FsbCB0cmFjZToNCmdzX3Jl
YWRfY29tcGxldGUrMHg1OC8weDI0MA0KdXNiX2dhZGdldF9naXZlYmFja19yZXF1ZXN0KzB4NDAv
MHgxNjANCmR3YzNfcmVtb3ZlX3JlcXVlc3RzKzB4MTcwLzB4NDg0DQpkd2MzX2VwMF9vdXRfc3Rh
cnQrMHhiMC8weDFkNA0KX19kd2MzX2dhZGdldF9zdGFydCsweDI1Yy8weDcyMA0Ka3JldHByb2Jl
X3RyYW1wb2xpbmUuY2ZpX2p0KzB4MC8weDgNCmtyZXRwcm9iZV90cmFtcG9saW5lLmNmaV9qdCsw
eDAvMHg4DQp1ZGNfYmluZF90b19kcml2ZXIrMHgxZDgvMHgzMDANCnVzYl9nYWRnZXRfcHJvYmVf
ZHJpdmVyKzB4YTgvMHgxZGMNCmdhZGdldF9kZXZfZGVzY19VRENfc3RvcmUrMHgxM2MvMHgxODgN
CmNvbmZpZ2ZzX3dyaXRlX2l0ZXIrMHgxNjAvMHgxZjQNCnZmc193cml0ZSsweDJkMC8weDQwYw0K
a3N5c193cml0ZSsweDdjLzB4ZjANCl9fYXJtNjRfc3lzX3dyaXRlKzB4MjAvMHgzMA0KaW52b2tl
X3N5c2NhbGwrMHg2MC8weDE1MA0KZWwwX3N2Y19jb21tb24rMHg4Yy8weGY4DQpkb19lbDBfc3Zj
KzB4MjgvMHhhMA0KZWwwX3N2YysweDI0LzB4ODQNCmVsMHRfNjRfc3luY19oYW5kbGVyKzB4ODgv
MHhlYw0KZWwwdF82NF9zeW5jKzB4MWI0LzB4MWI4DQpDb2RlOiBhYTFmMDNlMSBhYTEzMDNlMCA1
MjgwMDAyMiAyYTAxMDNlOCAoODhlODdlNjIpDQotLS1bIGVuZCB0cmFjZSA5Mzg4NDczMjdhNzM5
MTcyIF0tLS0NCktlcm5lbCBwYW5pYyAtIG5vdCBzeW5jaW5nOiBPb3BzOiBGYXRhbCBleGNlcHRp
b24NCg0KU2lnbmVkLW9mZi1ieTogTGlhbnFpbiBIdSA8aHVsaWFucWluQHZpdm8uY29tPg0KLS0t
DQp2MjoNCiAgLSBPcHRpbWl6ZSBjb2RlIGNvbW1lbnRzDQogIC0gRGVsZXRlIGxvZyBwcmludGlu
Zw0KLS0tDQogZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL3Vfc2VyaWFsLmMgfCAxNiArKysr
KysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKykNCg0KZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91X3NlcmlhbC5jIGIvZHJpdmVycy91
c2IvZ2FkZ2V0L2Z1bmN0aW9uL3Vfc2VyaWFsLmMNCmluZGV4IGIzOTQxMDVlNTVkNi4uNjU2Mzdk
NTNiZjAyDQotLS0gYS9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vdV9zZXJpYWwuYw0KKysr
IGIvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL3Vfc2VyaWFsLmMNCkBAIC00NTQsNiArNDU0
LDE0IEBAIHN0YXRpYyB2b2lkIGdzX3JlYWRfY29tcGxldGUoc3RydWN0IHVzYl9lcCAqZXAsIHN0
cnVjdCB1c2JfcmVxdWVzdCAqcmVxKQ0KIHsNCiAJc3RydWN0IGdzX3BvcnQJKnBvcnQgPSBlcC0+
ZHJpdmVyX2RhdGE7DQogDQorCS8qIFdoZW4gcG9ydCBpcyBOVUxMLCByZXR1cm4gdG8gYXZvaWQg
cGFuaWMuICovDQorCWlmICghcG9ydCkNCisJCXJldHVybjsNCisNCiAJLyogUXVldWUgYWxsIHJl
Y2VpdmVkIGRhdGEgdW50aWwgdGhlIHR0eSBsYXllciBpcyByZWFkeSBmb3IgaXQuICovDQogCXNw
aW5fbG9jaygmcG9ydC0+cG9ydF9sb2NrKTsNCiAJbGlzdF9hZGRfdGFpbCgmcmVxLT5saXN0LCAm
cG9ydC0+cmVhZF9xdWV1ZSk7DQpAQCAtNDY1LDYgKzQ3MywxNCBAQCBzdGF0aWMgdm9pZCBnc193
cml0ZV9jb21wbGV0ZShzdHJ1Y3QgdXNiX2VwICplcCwgc3RydWN0IHVzYl9yZXF1ZXN0ICpyZXEp
DQogew0KIAlzdHJ1Y3QgZ3NfcG9ydAkqcG9ydCA9IGVwLT5kcml2ZXJfZGF0YTsNCiANCisgICAv
KiBXaGVuIHBvcnQgaXMgTlVMTCwgcmV0dXJuIHRvIGF2b2lkIHBhbmljLiAqLw0KKwlpZiAoIXBv
cnQpDQorCQlyZXR1cm47DQorDQogCXNwaW5fbG9jaygmcG9ydC0+cG9ydF9sb2NrKTsNCiAJbGlz
dF9hZGQoJnJlcS0+bGlzdCwgJnBvcnQtPndyaXRlX3Bvb2wpOw0KIAlwb3J0LT53cml0ZV9zdGFy
dGVkLS07DQotLSANCjIuMzkuMA0KDQo=

