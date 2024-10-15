Return-Path: <linux-kernel+bounces-365209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BAD99DF00
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 09:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45721B23E1B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 07:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A54C18B46D;
	Tue, 15 Oct 2024 07:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="mBUVDk3d"
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021107.outbound.protection.outlook.com [52.101.129.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0C8175D54
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 07:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728975777; cv=fail; b=UuPTT3xgePhcZdTiSR5sOQ0lUJL5FAUAjkrQ9FYqraKLGkUaIS8UEP0U2TG2Z3pfs0LbC8fzsxDxNy6MXxhxsAstarET07tW0tMPGOn6awt4D+N3v+yTYD+h6z6MIrRacqMW9i8vWXwyXPDiKM7iSmvFh92w6HSPDOb8NPLtlAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728975777; c=relaxed/simple;
	bh=oWdoqbgU80W8/rXucY2Lhsia5RglJhx92ArKh8Btfzc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZoDeAPYFzTf5ZMdKX2k1dfvFFPSz3AVMENrVv92VBb5D4HLyhlevDBAJhea9w2Mva4dzIbDTUvOk7MAIGG3309CE9KSoeigSENp2dXejWveukdOW2NWotYj3V9nmxgwkIBAXxAjDZTkg0q/+P86cjJjCfT6s363PvBuHRoofRAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=mBUVDk3d; arc=fail smtp.client-ip=52.101.129.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QiFJAuTEojjoadD1gZierTPhzSboLbaVBLUODqZzaObusL9qPoZ+JnZiePHOXCsG27mb8erM/AQibo9BCsXu3kr6YKIeSxXJNlob7AG9gptpybPNGfmTdolKVIsrE+iqpORGDo2I+p8QFhPSRHVv6gH4pp2/kp+I2n3WmLw1wKpa4e22WK9/aZUfpsw+C2X+4Owp8yPjTkAa7RtofCH+e5DBRZqfsIaMKBLp/PCoOWlDN//DSCRg1hwOrepp8F3l3KJ6wcuKHMI1stKLhOSC4lRPGRtuiIYpk1YVf1ldiNDl1iVBgRNs7GLUbQQzG1NRp6zOyv+7ZMM1QAQcbXA4qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWdoqbgU80W8/rXucY2Lhsia5RglJhx92ArKh8Btfzc=;
 b=BM+h7yvJo3lkyc2DYP2RpFfpF6lsUdhE4vbTgnnvmghCSjM9YlJkPlKvTGH9e5LnBtfEbA3zw0TF7ElkpFyITIQHzgPsTCt9wN/ufGWg28dgboRQEI0jgcfWICuewlDIjax8iDxOZDiU0u7QkvpYlHd4mxs/bPCX52PmSg8jd9Rh9G3ucC+gdlhqSTO8fwJngDvnM3xdQRviA00dkhWaKMgcrb3atRGzR6XfZuuxfNvoavRvx+BCtaOZO/Yz0q5eQx161g8fpu0k7LXXbb1RaLVsp3qj7nwvoTvapMQIlNUq3YSfl7Sbrd5aB9lhnKrN9cXIWNEG4VYaZHVDZRWd1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWdoqbgU80W8/rXucY2Lhsia5RglJhx92ArKh8Btfzc=;
 b=mBUVDk3dJuef/8QpAAaf0pQdXeiir9t5kLXUwj9E6T80MFEZQal2Hp4PHADD9JeSWCZVQkOuO/FQDfla7u4tKy85v9i/fjGwFkQA1zViUvDlr30T3Pqii2TR9NHUQS0lXD+ZLvGPGAdRLZfZjzGAZGgcZWQvVew0NXiImUm/4BB3MlYzcLSDqVCwbW1/kco/XdEhXGkyFe5Erxgo8CJnyN9189Qx3tN/PY0yGadvYpQgelKKCHGUhgcxUQ6xoD8K52fU7b0xlqJBVCI3BvmYFkCkz2FzUmmSXsqNpzOFSIv7Lm2d7ztQJVLg8wKnkTqFwdpj42sKS7ROEp2PtZ5gCA==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by SEZPR06MB6870.apcprd06.prod.outlook.com (2603:1096:101:19d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Tue, 15 Oct
 2024 07:02:47 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%4]) with mapi id 15.20.8069.009; Tue, 15 Oct 2024
 07:02:47 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "jacob.e.keller@intel.com"
	<jacob.e.keller@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [net-next] net: ftgmac100: corrcet the phy interface of NC-SI mode
Thread-Topic: [net-next] net: ftgmac100: corrcet the phy interface of NC-SI
 mode
Thread-Index: AQHbHqbS0/A8IRhvDkaGkGGfA6q0K7KHYRoAgAABTZA=
Date: Tue, 15 Oct 2024 07:02:46 +0000
Message-ID:
 <SEYPR06MB5134D9F5BF6DC62BD86A03B99D452@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20241015020610.1824763-1-jacky_chou@aspeedtech.com>
 <mtaia5jqcpyx4bbybsvqa3kyl7o6mlavbhn3jk5gdb42ftypxn@jeydtf7ldprv>
In-Reply-To: <mtaia5jqcpyx4bbybsvqa3kyl7o6mlavbhn3jk5gdb42ftypxn@jeydtf7ldprv>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|SEZPR06MB6870:EE_
x-ms-office365-filtering-correlation-id: c7742a1d-55da-4b97-5149-08dcece75fd9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?DlQoYTknu0cTZABRwa54LgRIRBEB4VCj/1jwkCq0MSWCKP6NPmTix/xiY7?=
 =?iso-8859-1?Q?GzxScK7a4v6UXBsJZWQMZ+Ax14qi7wll3Wv/uVQW+69x4KStWUlwlq62w0?=
 =?iso-8859-1?Q?tQAJCET52Lzq2TJAdhz+2kT7CWiu8rUCc0YASdM3jGRFfdZlk5fIT7MIU8?=
 =?iso-8859-1?Q?BOQxUkOYMsvVyY5VFdhRLInNXbvSXl49nd3aozxpSsNO45SeaEY3A2jsSL?=
 =?iso-8859-1?Q?26Z688r8r15SULtceOP9KZDFgrfTJ9523ZKt2xRacUAxxB5l1mKX9jiCai?=
 =?iso-8859-1?Q?YwLDPMijb8ecRFL82QqbFqSA5hQNrZfvr48bI6CkMsA5VL4e5omx1eLKwM?=
 =?iso-8859-1?Q?nDKj7y0ZmG+JWjY3y03kQbE/4toxUGGJpn58FfL1X1HpzvM0Tcevsz6IzQ?=
 =?iso-8859-1?Q?Fke/x9C+PJXr4fY+yEx7CAO0aAxwbVwF+2Thz07mxhDLXCgpFgKdhFwJ9B?=
 =?iso-8859-1?Q?3RQi2xvqeKqILxVgRnzOC0dOvYfi/OSbZUqq3rCX8AK7270/WJB7m0SqUa?=
 =?iso-8859-1?Q?pDOSavUXqz/fhbv/cZr/N2lSvT/a4AGntpAX3w+IN4FepT8XbhBOVzzxnb?=
 =?iso-8859-1?Q?ILV7Jqezuf6Elaf4lLs/m4UghCEykHvhqFGYzzfQY0Ae1VzEbPeq/oc+/b?=
 =?iso-8859-1?Q?UY/yKIUTdD9PtS2uSw2NgOEmqQEqm/Hehy790CXyZatWkpr0s9q1lfpieo?=
 =?iso-8859-1?Q?vlJfrBgx6yZF4dkU53kRgB48DzbXZpBPpr16vdzs85v1JZtAAUcppkzDhr?=
 =?iso-8859-1?Q?SDZrSWGETJarcHQqtP4j3I04heKnt9jjQLoUCbPznDIN3WBIzYVjyrKf1J?=
 =?iso-8859-1?Q?+pnRBAi2tSFXT7cOYX71nB+qkFDnaC7CxhCW18qXWXFOvswr8Xyygpn1+q?=
 =?iso-8859-1?Q?I1OvdTPZSX80xYSh7b2Hr8XhboY7w4ko82O6t6UupoOwz4OhL6XYMiAgpm?=
 =?iso-8859-1?Q?hNI0HVZwu4lsxKzfMdHBNCFELnKRq+TInrjY+W+0gYOkWs/ofQyUVUxphD?=
 =?iso-8859-1?Q?9JauF1ZnJrzEQ7eMitf2Lxodf8tstxAsIaeQnZCRmXQL+abMkPLARM6Svv?=
 =?iso-8859-1?Q?0fweIUs9KmBGAx/GgYsVWAxgZD2r29zRfMIna4mVDxy7gOLX3fiUfd4rEW?=
 =?iso-8859-1?Q?QBRbj82j2a5K54/QORWEqjb8yecuqAs9B0vzipBDoQ7i/0RL05qpH9n5la?=
 =?iso-8859-1?Q?7Ioq8JOPNhCLpHFcsEG9/I3A2xYJiyahqVRGDimZ2phrz0AVC+HZsImrl5?=
 =?iso-8859-1?Q?ESYW10nRJkrpFgwIVjd2/cFs2tV0jxZVCooN8etJXM2DibkCrOiJp3cuhr?=
 =?iso-8859-1?Q?5m0RSUIHQ1w/3goKVlb5xbFspyz3AZ6aiP8rH18CnA3vu9t42D7rD/md6v?=
 =?iso-8859-1?Q?E19nUS1qe4UrHzXYO4a61sNyrtr5/7UA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?xj19J8KB9tF7l8pI/ZcILRQOR8OIDiZRb4Azi6ZQWAscmYMlIKbOxcrHda?=
 =?iso-8859-1?Q?nbG7v8N2tNue4S3D598QsPZ8lB7drSruENwXpNTXDSmpzh5Rg+GMw94RpD?=
 =?iso-8859-1?Q?Q5u9cGZMe+NWxyIvwGXkEOKcC126UUQR8VbkDbyElJ/y3C0NINc0Dw4+NS?=
 =?iso-8859-1?Q?7y+oIEUBHtckghddxWAWgjX3T6dCNq17TqqGNzqI9TAeaH159N+Sdvud5u?=
 =?iso-8859-1?Q?TZBk5OVl8cnRVD3lxk6+YE8Qv4PGO9JrgbMG9ZAluHAP7LJJBtWMrFmw6y?=
 =?iso-8859-1?Q?hKpjGhyXcZVp/w8m9vPr18/dqp22y8jJ324SSA/ZDPnPspMslIg68+/TM1?=
 =?iso-8859-1?Q?Mkce9OXrNeeGtsdXorYAhQs1FG+PGjz4WvlhQ0GOg48f5IO7FDqwvI+WEU?=
 =?iso-8859-1?Q?aU+M5h/mlNaFtfGTp07lf0op9BWvYuK3b9Kbuxf7F3V9GseLHOm8MNRf4W?=
 =?iso-8859-1?Q?e5KChpfAirSG2SlxMVwRa8aVMxlUZcR8OmmMn0AOmzKeWi3AG5UWg5eSTM?=
 =?iso-8859-1?Q?UZZ7CHDarcFeYssd74w/xnqgjKDZoSvqSPDotxNAFQyRflwdykiTe75JPP?=
 =?iso-8859-1?Q?PYm/0Urt2Zy5kl3P9tCU65US6f8PW7QtJRSw0fz+b4LMYE+78DW61aMg43?=
 =?iso-8859-1?Q?C6VI+P0Fu/DKee56IPw0ps5JCbldxLRdpytnmfSzJQ3IgTAV86Me3sE/WC?=
 =?iso-8859-1?Q?DkEMeIOtclO8KzgnUWgHMxGN8H7NwJapQSoNFfF9uEi7QNf8mqGEv+B1a8?=
 =?iso-8859-1?Q?krflUVdYIi07FA0hCHKSV578I41UwvrGcj00DxI7xEfKb2mRZo6qC8UpxI?=
 =?iso-8859-1?Q?FvJeI/QYOdmQugannCCj2US4RU9PfREWrkdZy0aWB8bDvz1bab9PnC22k0?=
 =?iso-8859-1?Q?U1UlSqOG4eyB1jEPJeAhghkibaBjBPnoWXgTvQhyulDywfMbzQyloTa9U8?=
 =?iso-8859-1?Q?wqT/6BqviOYZZG5QWiUmgcxCogmnSxv7SAPf23xBcctceZqnOSCc6Q1qTI?=
 =?iso-8859-1?Q?FTKEO2zbp+w+HBLxRduBKLxOVQFUbCwe228g2Q0O8eEqMgP+f+WKS7ofV+?=
 =?iso-8859-1?Q?djU2COHJwKxSqB5BaYONJt7QmnQqg08bWkWa1btoJqXJIiMGlxtEG1OMky?=
 =?iso-8859-1?Q?lPn5Rngd/zhvgH1qangj0DHFzwVx/puT8FLvruyqzizIKjtuMF4xYDk7Ff?=
 =?iso-8859-1?Q?pOP1ADaOLBWAqZJy5NKkK1idtAwKBiKQq/wY6XG95KrN/ZvCqL2zNv/wd9?=
 =?iso-8859-1?Q?ek1I4joa0HtEacCBNjsQlvJuMzVFhYbS0yKGx9HLugs09YKJingNY8M4dk?=
 =?iso-8859-1?Q?RxMN5m/XZQav2a1Aj+Df8NCWCgpvsmeK3uiPKLmTv7/enkmAcMsR0DRAqH?=
 =?iso-8859-1?Q?DQ1bPxDIZ+8C9y3rAOD9qSrvr4LaX9n579mEGQiYvLWIL7+Q7UxTEz3sN9?=
 =?iso-8859-1?Q?aBQLJk0+rUDzHN4+JS+xtUf2w3a0LIZ3/n1rqOpFYOP+0LhPzrkLtlmq3C?=
 =?iso-8859-1?Q?rtBjlYt7x7eeDjLMeuBkUA2QTSp96NxKFYy+Z1DDyf+fVNI/qj03LJuizO?=
 =?iso-8859-1?Q?/1fPYTZ/OR5b2QWTiwcZyirMelJuCFgm9tClfoyPP+BAEA8cgfbwWt/r7N?=
 =?iso-8859-1?Q?iZuTA0EBIjHA+ntxdo+wAcuYA7NbLHOIBk?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7742a1d-55da-4b97-5149-08dcece75fd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2024 07:02:46.9102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZDV4A1xpLPxQ7cYwyyQwicXrBaVljdGxM6qC47lUd88+ue8OQnNqHu0CookMW6CEEJbNimjfurCrTUNpgn2/HnZk+R8fhcgbY11f6TXaGYY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6870

Hi Uwe,

Thanks for your friendly reminder.
I am sorry it was a typo.
I will correct it on next version.

Thanks,
Jacky


