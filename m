Return-Path: <linux-kernel+bounces-312848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB196969C65
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 13:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D06301C23BB7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B981C1B985A;
	Tue,  3 Sep 2024 11:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="mwEFfW9j"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2073.outbound.protection.outlook.com [40.107.215.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EA71A42D8;
	Tue,  3 Sep 2024 11:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725364175; cv=fail; b=ROCfnCW4R891OyaqAjMPQeKEZLNWagc0sXmL2MkeBc/rhdC5D34FVyxyi4V28quZF37XEYF2YxDSZQBbBL+ZhLgJBfmmHHuLVBM3AytWUgcXGkTddbAo+Dwdv3APmfB3pE6GzSuCwDMzJNocgIB2wY1XPzG9BkxCH9ikpWr+7/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725364175; c=relaxed/simple;
	bh=SYdG62Tj4+r2m+RqqMQhAGvjw9buCX9D/XiYFZBjsJ0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q+kD6u+A9eZY5/jvZCzqLe7ja+tAvCp5U2HaCBsDDqZRbWKv2VMxYRaK5Uo4bndZMr2LGQDxHSRt/487jBST2ayUDlXamyhKRADi7XYV8hSrSWpr+AaASJonw5XcY/P4XI+ISjZxWGjK+Kt2o3XYVmPJ4c1OzUk0JET0Wp1TYRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=mwEFfW9j; arc=fail smtp.client-ip=40.107.215.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m7E5BICrChlz1G18OjBM+lCxMsTNoHd7Yk5T9qcvOJYSjdRYD2dbNCdiNaToR2CalBbPBr7OJZRn/4OECzyE9N6siFQ9QpgCyLcAJq/1Q2ZdnIB3C/Zl5/m60iFN6RLkPnLbm++Gc0pXM8hbOXvRQ15xqkOC+wN3Ws+wZiFws1bCy8Z+++LXE/4xybiLOahexGonjtvx5YtH0XHSWSJesJ/t2EItCKwEumV0kKWEqX+dCuaoxrywZJe2I7zOVrTPxn/nhMVtyD4ZcQ7FXYnsCXc/rpCJAmDKZF4LrAj2/0HhUl4HmpSCvI1eM/8FGP9bcM2tlUtZvrtSp0A2lAXqBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYdG62Tj4+r2m+RqqMQhAGvjw9buCX9D/XiYFZBjsJ0=;
 b=zHogJ2W/IrK3tAnWdOBR9GzBX6Mm0sYAEOA/rySZ1ZvJPjtNBATKQvwmx/Ug689CTItX3+jv19spzqLxeEj8vr99NK2Qh1oyp6JArdCTpiMc2fUw+8dTl4sugWkIo1yVkyH5jSCiOAYTLSCjSaNqyshBi0L7zJWRIpZqYvSY5lDwsKoFT3zI4qxgOTgU2qsLSnOvba5ecS1u3blri/wMYS5u3Hn4yAIA2DD5D4MAQbT5LzNljDIqGtflbDm4xdJv+RE4xlSJL7dVwXYR+XroxvzH7MYPC+3Ln32ehx3aLloH8nuhIxjS9KvBWdrNzyPP1Xrj/GWDkKFO880+31jv5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYdG62Tj4+r2m+RqqMQhAGvjw9buCX9D/XiYFZBjsJ0=;
 b=mwEFfW9jgEqV3F5T6m4RmiFYzh/48M7Ir0FGcv+Am1MO5cM8R1WQf/mcfvQMdG3cSaI/o8XVodH7jQpoGTir1IKhuIM1GtEgz/PK3rvejftuPgM7o74R48tW/4Dn3CT9PNXWm/Rn5xtqqTZ1eDtYqjdeppSH6NjrcCQzL0vrJBURmmB7nvFET7opuNlTG/K2LAmu1Mw182yypdcYbxo2q7MTwCXTULCzqdMVa2LcCZFZCKxylizOVM1WoQkcwh8uw/kR8C3CPDab2OpBsv6CatsAkgQbMufv2mvXk7QHknZP3p76uoUF9cYX4V4mt17Vos7GA/A08S5yN5JOOS28hA==
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com (2603:1096:400:358::7)
 by SEZPR06MB5272.apcprd06.prod.outlook.com (2603:1096:101:7b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Tue, 3 Sep
 2024 11:49:26 +0000
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe]) by TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe%4]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 11:49:25 +0000
From: =?utf-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>, Michael Nazzareno Trimarchi
	<michael@amarulasolutions.com>, Prashanth K <quic_prashk@quicinc.com>,
	"quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	opensource.kernel <opensource.kernel@vivo.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, =?utf-8?B?5p2O5bKz5p2+?= <liyuesong@vivo.com>
Subject:
 =?utf-8?B?562U5aSNOiDnrZTlpI06IOetlOWkjTogW1BBVENIIHY5XSB1c2I6IGdhZGdl?=
 =?utf-8?B?dDogdV9zZXJpYWw6IEFkZCBudWxsIHBvaW50ZXIgY2hlY2sgaW4gZ3NfcmVh?=
 =?utf-8?B?ZF9jb21wbGV0ZSAmIGdzX3dyaXRlX2NvbXBsZXRl?=
Thread-Topic:
 =?utf-8?B?562U5aSNOiDnrZTlpI06IFtQQVRDSCB2OV0gdXNiOiBnYWRnZXQ6IHVfc2Vy?=
 =?utf-8?B?aWFsOiBBZGQgbnVsbCBwb2ludGVyIGNoZWNrIGluIGdzX3JlYWRfY29tcGxl?=
 =?utf-8?B?dGUgJiBnc193cml0ZV9jb21wbGV0ZQ==?=
Thread-Index: Adr6Cd+UUO/sbS6xR4e70mPa/mlHZgDOySAgAANWEwAAFL5oEAAGJOOAAA4dvOA=
Date: Tue, 3 Sep 2024 11:49:25 +0000
Message-ID:
 <TYUPR06MB6217F14E7A4DEA451115F086D2932@TYUPR06MB6217.apcprd06.prod.outlook.com>
References:
 <TYUPR06MB6217DE28012FFEC5E808DD64D2962@TYUPR06MB6217.apcprd06.prod.outlook.com>
 <PUZPR06MB6224FF88145DAA364464EA7FD2922@PUZPR06MB6224.apcprd06.prod.outlook.com>
 <1179f9e8-1e5e-4658-8102-ee4d2c49575f@kernel.org>
 <TYUPR06MB62171CA61CC646756826B8D9D2932@TYUPR06MB6217.apcprd06.prod.outlook.com>
 <2024090328-carbon-feeble-3d84@gregkh>
In-Reply-To: <2024090328-carbon-feeble-3d84@gregkh>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR06MB6217:EE_|SEZPR06MB5272:EE_
x-ms-office365-filtering-correlation-id: be134f80-613d-4396-5ced-08dccc0e75e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WVdWZ3RMQXNDRVNCOUNtY2k5cDN0eFdsNkhCcHNnSUxDdFdSV0UxQUxGN0FY?=
 =?utf-8?B?NTZuOXBXbkZLN3pMVUg3RnhwUklKc0ZhUUdkZk02d2lLOGRrM2Vxd3FZZklx?=
 =?utf-8?B?d1hoM2NIMFhLQW9NTDJxTDZkWHUwS1N3UmRtK0dkbWp1cFRGNm1VYjNNbEg0?=
 =?utf-8?B?QmxyRDFXU2NLb3NqY3NhcGw1RGxKSjVZM0VwT3ZCYkNnaXd1ZGZyeWFyQ0t3?=
 =?utf-8?B?MUhwYm5qM0krNEp3d3phREtMeUZEOFJObjg3OXAzczV2NnkwZFFBUWdFYUVl?=
 =?utf-8?B?MUVtelpnUlkvdkZGcVZYVnZ3OTQvWjAvYzVhVzVvQnFYbFEydnhCVWF3alI5?=
 =?utf-8?B?NGdLNVE3SmcrT1poR1o2U2lhMENTelJ6NENqZlFpRTlaNmNsMzlvQUJqSGxs?=
 =?utf-8?B?eGljT2N4Zlg0SDRWSmFDNkR5MjFqcmh0L3pMMXZyNjNrOEt0dWlDS1pNSGlU?=
 =?utf-8?B?L3huUkYxbDM4WlplWHF5bXl2eXFJNU5vWUxRV0UrWDAyc1VkNEwwOU1CVDc0?=
 =?utf-8?B?R2dhbS9Iakp4TE84Qkg1QnYwQjFlN3ZnVzJXcXROam5BTTVTUlpTa2lORFQ1?=
 =?utf-8?B?VEx4TkJwYnZqVDRNaFlWNVA2UlVWVzZSVUFiTVR2SXNTVVp2NVNaK0ZQSGRv?=
 =?utf-8?B?OFZzRDQ5dng2YUNxS0RlaVcyOFJ1NlVwbUVGWG1XSGJkRXM1dXhubEp6YldT?=
 =?utf-8?B?eWVOWGhDRk5XbEhZVGlETVpYWW9hUmxBZlFSUkI3RUlTcmpud3lhcXhBQ2RD?=
 =?utf-8?B?cnZMOXpYWWRNVHhYQWhYZWpBZGxHelJZSlhIQ0hOTHNBK1F4WFUyRm5YRVFV?=
 =?utf-8?B?NkcrRVF0eEdQVWJmQzQyeXJTRWdqSTN2VmgyeWhKWmt3aDZjcWtqWXpIZkRZ?=
 =?utf-8?B?OFZlYUo5SnF0VVF2RDNsU2JNMlUzZUp6aFhxK0FlUHZncjIxeVdLVVZ2N2I0?=
 =?utf-8?B?MVV1cmdDSjZMZS94NmJUMEdRWW9EbDhGbHVZOVplYXo1d25vMHFjaG8xYjlV?=
 =?utf-8?B?MndjNUZURmJXZ251VFloU0lMcjVsWmFBTFpRMjlYT2FDcnErV0lqWFVFVmpu?=
 =?utf-8?B?YWhzRXdQcllBZ1NVcnZQUlg3Tk1YU0xBRHpZenBTY1FEWUMwd05iVGhRZWZR?=
 =?utf-8?B?YVhlSnRVZEVQdkZuZDhUMjZNRmhrSDlUMkdoUkIxMEVIT2JZNUkrL3VJNDZh?=
 =?utf-8?B?RDE3ZGpCaXIxVmFlN3V2L2dYVG9lV29LTkZvWEZXNFVmZGtnRGhhQUo0eXpH?=
 =?utf-8?B?N3dyZHZrVDlZTGhMRHVZdHltanB4aWJSSDh3VU1NZC9pTDBQUFlEanRXZ2pZ?=
 =?utf-8?B?NTUvd0kyNXRIbkRLYkVpY25lN2JhYVBhWkdhZkR5TEo5a2RzcTlOamhYVFRz?=
 =?utf-8?B?U2RoUmFIOXg2Q3VjdTdvbXRkNVZqZ0V0anVEUEhWaXhXbm5GNkg2VXVJRjRm?=
 =?utf-8?B?SVNTUFRmVFRNVkx5eDQ3NFkrM2c3WlNrNEpKUFZGRld1K2oyK1ArbmF0NGJ3?=
 =?utf-8?B?aGNHSS9JeWF2UXVTNEw3YVAySXZtbEU4azZQcUl6WjVSS3VkT1lBUExoYUJm?=
 =?utf-8?B?OExlMys0NnovaVBZa0sxbUFERVAwUkN5bllZV1RzbVVvV1Rhc09OcEZJOW1E?=
 =?utf-8?B?eTUvUm5OSkR1TytDcExNTG1sTkpNSHNNRGF6MGh2Y0FkQTVTUUdGVXNEaFdl?=
 =?utf-8?B?QmlFakY1My9qY0piNSt1TG5xdzUvblhqOUovWUVZd2NsaE5zdFhCdnAva2tZ?=
 =?utf-8?B?Qmp4blVad2xGNVhqMzBUVi96d1k1M1lvaWFoZXNzYVUzQW1meHVVNVZ2RG5r?=
 =?utf-8?B?cm9SZUNFbDRQV24rWHNPaE91M1JEN3BDTGN3Tk5FU3JidFBmSzRHYVpBVzNa?=
 =?utf-8?B?REpuKzNncGJwY1FkT2NLVXJjOFBDN25mRFN3ODhlc1luOVE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR06MB6217.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SHBRZjRzb0ExeFlINEJ0OW1sRHNsM2FTUHVoalFWSjB5alZrVUdQSWFVL091?=
 =?utf-8?B?MzhnNS9wMUhEVUl4NVNsZ0VpeGRmNUpGL0ZEQVRna2c4Y1FNWFVqNzVMNUkx?=
 =?utf-8?B?TU9DeXp1b3hZOFBWYWo3S0VvNm1sZUpSdkFtWjdoSUpJOFl5TWJpRHh4L2hv?=
 =?utf-8?B?elM5RE1SMDJEN0d4bElzekxpd0JMTEovdSszWStWbTJBVzVMZ2d5Q0dUZDVp?=
 =?utf-8?B?NktDSU82MHUvNFEvWnFXNlR3OHpxRFBjcng5UFl0OFU4d04ybTBhTVJPbkRZ?=
 =?utf-8?B?WHd3WW05RlZmVGViL0hmc0xBeVUreS8weU4zRGFES0hkSjN3UDhGT2hkaEVH?=
 =?utf-8?B?dHVyZ2Npd2UvZjdEUEE1NFpGdlhvTVhqN3lQZnJEY1Z1UHZEOHYwM0t1SjRv?=
 =?utf-8?B?blJNbEdsLzlmWXJrVm5YeEEwQ284dG9ZYlpMVEh3dnM2YkdJUHcrNXlYNFo3?=
 =?utf-8?B?V1FiVXN5WFRSbG1kOTREell2TFJVWWptbEdkbXBPaHNhTTBkYjBFSXFWbFZ6?=
 =?utf-8?B?WDMvUHhVOGtWaEhWTWQ0bWFsQlVwSm5FSkMyK2l4NmUzLzhQbmFwYm1Demtx?=
 =?utf-8?B?WFh6bmR4NHV3NjBEbVpUQWxaS2FWRzdzMlhJT1pwLzVpRXBtejVYTGl4Ym85?=
 =?utf-8?B?M1cwZGFJVGovdksvbVRvT0dtSFlxU1RRNjQyc2tkaDFiSHNQN25qRFlvN0Uv?=
 =?utf-8?B?eE0zc2VmOTZzRCtjRjUzaGpheXBHeGg4S3pGZnc2VGVabnhMRVNUTnBmcmJX?=
 =?utf-8?B?a2x1d0QxODJNaVkzZ2FEQ05uV0lKYis1M01iZ05uZzlZbXRZUFU2TVRSMWt5?=
 =?utf-8?B?anY0VVVWOGM4ZTBhQzB6RWVWNktLMDFvdEl1VkYrRktLUFM3S0Nqd1NTenU0?=
 =?utf-8?B?QTVnbjA3cVJ0TFQ1ZGxGRUk3YzNsbWtoVURVMlBidVFQdWFURG16aHBPSGlY?=
 =?utf-8?B?QTRJd1VvZlZZb3krNFQ4d3JSaWZGWm82a0tpTkR2cUltY3RDRWRlUXVjS1pm?=
 =?utf-8?B?VzRLcDNTVFFObnZJTU9YVXRGWnM0UEV3elhvU0lKQnQ1bjNhamw5Z1lLQlNI?=
 =?utf-8?B?U3lkeWRyYlVqS0lyQ05WNk1ZUFp6MFNiUE5sVFlyMDArdTNCcEN2SVc0UzFS?=
 =?utf-8?B?OXV2cThtUDROOWd2ZUlIYzNGOHhMeGlIc0paQ2NYNk5GVnM1TVkvM0F2Yldz?=
 =?utf-8?B?MFY5ejBuMERiL3h5UXg5NXlLdXREZ1pOTWtrOEhmN2dQdDlvU0tqcGFLd0FH?=
 =?utf-8?B?elpnNUhoUTdUSURsUG10QzY4V3RMV0dydWt0NFFHekdoNzdxTHZjTTlHcU4z?=
 =?utf-8?B?ZGs0ZmRDZjRvakJkK3dlNkp1WWxkanExM296YktUSVIwZ01qYklmb2czZ3Ry?=
 =?utf-8?B?bFZsVzJZUE5aeHVxRG1KVDNwSTJRNENBcEdJYTVKZVNVdVBqa1p6YVE2WDg3?=
 =?utf-8?B?dE9BWVJrR21vQnhtajdqY1YvR29FZTV1bmxjV1cxNjV5T0J1NElkbjhSUDJT?=
 =?utf-8?B?QWVHV3hQUktDWmZJOHVqVmVPNkN6cmx0OWpnMDBHYWJhdGRlTUYweEl3SVlQ?=
 =?utf-8?B?UFFWWlJ2ZFdnTDhCTk1zdzdxMjA4RkpWeElhTmFRQWtxOGJ3elF6bExvNThW?=
 =?utf-8?B?c1phYkpkNUJHaXBpOVFEZHB6VjZaSTFrSDBsUTZpMnhHUlk0OElvblJyRjJN?=
 =?utf-8?B?N1FnUXBsZjRDRnBYY0t2Rjg5R2hjZVR4MHhiWUgrZWt2cWZ5WmpQTDNkT2Vi?=
 =?utf-8?B?T1dYSS8rY0dXUWRiTENCL05kWkpkdEgrY2RKUWV2UkMrSlUxTjY1d0dheU55?=
 =?utf-8?B?SElFTnZyTnFmcDZ1TGwrNk11YWdKMkw2MVR2MUVOdC9nTGhuVlQ1blUzZmhh?=
 =?utf-8?B?VFVpakFZOWhMQUJQNzhlY3lUYmY0c2hnb2FzZDBucXd4NU1kNklhZHJiVUtV?=
 =?utf-8?B?dXFpZ2ZoMkdYdUdsZVhsNldKVDgzcGoxTXBVdkZNSTl4UncxekZoUDJTZEMz?=
 =?utf-8?B?aERRS3BGOHNPc0FpdkxVbjBSMGN3QUx1ck9STGNpbnhrU3E2YnhJSjdiQ1U3?=
 =?utf-8?B?V3JMNTRQQWZUVm1lOG5CMXZLSk9Md3dHUXZSK0Z4SFpvMXRvQ2dBdTR0Vm42?=
 =?utf-8?Q?KK6g=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: TYUPR06MB6217.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be134f80-613d-4396-5ced-08dccc0e75e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2024 11:49:25.8658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JGZur+if4Yl3NrnpPjPO4nje2tsF/HrZaMcD9Ao9ALHGOG2YXS++vD8SHiJu6WJaD42V3nvT6jWvVZMXb988wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5272

SGVsbG8gbGludXggY29tbXVuaXR5IGV4cGVydDoNCg0KPklmIHlvdSB3aXNoIHRvIGhhdmUgcGF0
Y2hlcyByZXZpZXdlZCBhbmQgbWVyZ2VkIHF1aWNrbHksIHBsZWFzZSBoZWxwIG91dCBpbiB0aGUg
cmV2aWV3IGFuZCB0ZXN0aW5nIG9mIG90aGVyIGNoYW5nZXMgdGhhdCBoYXZlIGJlZW4gc3VibWl0
dGVkIGJlZm9yZSB5b3VycywgdG8gaGVscCBjdXQgZG93biB0aGUgd29ya2xvYWQgb2YgdGhvc2Ug
b2YgdXMgcmV2aWV3aW5nIHRoZXNlIGNoYW5nZXMuDQogV2UgdXN1YWxseSBkbyB0aGUgcmVsYXRl
ZCBwcmVzc3VyZSB0ZXN0cyBhZnRlciBQYXRjaC4gRm9yIGV4YW1wbGUsIHRoaXMgcGF0Y2ggd2Ug
aGF2ZSBhIFVTQiBtb2RlIHN3aXRjaGluZyBwcmVzc3VyZSB0ZXN0LCBhbmQgdGhlIEFEQiBST09U
ICYgVU5ST09UIHByZXNzdXJlIHRlc3QuDQogIA0KVGhhbmtzDQo=

