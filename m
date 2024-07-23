Return-Path: <linux-kernel+bounces-260025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D820F93A1AD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 15:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E43B283EFD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 13:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17F515351A;
	Tue, 23 Jul 2024 13:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="aSHIvwDk"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D57D208A0;
	Tue, 23 Jul 2024 13:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721741841; cv=fail; b=alt5AfwatIUVdXHT/IUWQqWu9xdPIgK0QNJddiWyRonilxWNGbv2miN4pF3uSviWHuZ1w4uNng/rbC7S/DE9JIFghAWfpnEWFR/JYR5mjCOU/CTPoo5V07TCqR494jGQctFzwm9EhcJVmq/h+okvB2hthCpONQp9euJASfTkOp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721741841; c=relaxed/simple;
	bh=30mksBfqM0+DJ7GkP+PLoGm0X0/pvIjv6LITtwaGqYA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q7eK6oOd6v9VQUOqLl3824lqwcFW/mmVEM2PAYoI1xNDgAHdq431NieFWHVF2MK2rDVF+lC+oPQU7Ri4U/aJOXj6bjzppLojj//Rzfa2Xd1qpB/UXRXgGICZB2FpLIubts981XxLQt0pRx1CIAnn4WKh7OCdJ0dNl39u3LTDg9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=st.com; spf=pass smtp.mailfrom=st.com; dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b=aSHIvwDk; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46NBxRX3013342;
	Tue, 23 Jul 2024 15:36:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	STMicroelectronics; bh=30mksBfqM0+DJ7GkP+PLoGm0X0/pvIjv6LITtwaGq
	YA=; b=aSHIvwDkoy2lIXn0xZNAFrvMsV0Zalp4jPxbM2OIShM0O4bfBAJHTzJrV
	uejjbLuYqeh0B4urv9RMBpYGTK8A4TqhqIRjSryGEDLd3ixlgSeFkrRhGe5Jcazt
	4PhmCRUyJRwgebZf0QZ0Kw7ImgFsd5+wHzqwK1aPQ+YVXX1bxGkgyKbR3QJIVAXz
	Won251kKmaQci5w5F6nbha8LAJeKjYaSjKfd8yl0p/8t+cJLAQ0P1rFoOTAXogfW
	IDEJdLjnXdSYlhnwJM6a5EvRL6dE3azPrdb4tF6Y9j/KCJJZaHZDdTzCsBbHXeJv
	MBZ/9voFd6aD39VNagx7s+cCdyPeQ==
Received: from eur03-vi1-obe.outbound.protection.outlook.com (mail-vi1eur03lp2107.outbound.protection.outlook.com [104.47.30.107])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 40g44d285f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 15:36:57 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iiz5aoBtiuYUOdHHQBZRnsbrw6Il44SFdyDO1Beho7fZzVWH2Mtb72xZ7U729bnddatjCDy81CEpldlXpE/biiV8ByEx25lhMfAp5kKbrvVpws4i1CURiSnRhw4iZoU6V5PbIcOqeKYbQG5wmvC7phiIDjOt/+dLs3g4/dxLs2PEQrVeFuRm0uhLHThoIhSGIPZpLoxYQ9PuBEOeGAEMmEab+GyXj26dsUypg8g/Gz1ZstHT6XN0qjUR1d+tPX82KQEiulhLklPqVoXzT+UjF1OhUhF9B+l3AlAQJ2UZLrPEAZKrYTMKlHgtOYsLe734kX4yA+BBcEM0mKOh0nK3Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30mksBfqM0+DJ7GkP+PLoGm0X0/pvIjv6LITtwaGqYA=;
 b=CrIgCPU/3UTG1MO9oz5SwxykFGVeLj5Q0NZDCYie8kZR9FFjlyfUApBoj5lKR9UQapdhG3E5Ev+vPofI736xanLZMkZrXKmz3ZoF5xtWBXBRkny2Hnhb2hrs+SCEuVMvHK7wAe0+RUbZLZkILI1YtVAG46DLtpyUYKnNtYWwhrOUnMHOyYyUSFyKR6B6xRG9RpvqL+bUlIIiEayHRsyWnu3qVijoVP/WLMraywhUeCAzD37NF7adDQsDtKnW7J+9lyv+RFetZuP6h1TU/vYQyKbj06ctTReJw64Kq2NB/NFWYMX0VEoUP9489tkoykXbYKcrFAuVH/xOScCt20SrOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=st.com; dmarc=pass action=none header.from=st.com; dkim=pass
 header.d=st.com; arc=none
Received: from PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:157::13)
 by PA2PR10MB8818.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:426::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Tue, 23 Jul
 2024 13:36:56 +0000
Received: from PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6004:1d1:46c2:e67c]) by PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6004:1d1:46c2:e67c%6]) with mapi id 15.20.7784.017; Tue, 23 Jul 2024
 13:36:55 +0000
From: Etienne CARRIERE <etienne.carriere@st.com>
To: Cristian Marussi <cristian.marussi@arm.com>, Peng Fan <peng.fan@nxp.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "arm-scmi@vger.kernel.org"
	<arm-scmi@vger.kernel.org>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "james.quinlan@broadcom.com" <james.quinlan@broadcom.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "vincent.guittot@linaro.org"
	<vincent.guittot@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "michal.simek@amd.com" <michal.simek@amd.com>,
        "quic_sibis@quicinc.com"
	<quic_sibis@quicinc.com>,
        "quic_nkela@quicinc.com" <quic_nkela@quicinc.com>,
        "ptosi@google.com" <ptosi@google.com>,
        "dan.carpenter@linaro.org"
	<dan.carpenter@linaro.org>,
        "souvik.chakravarty@arm.com"
	<souvik.chakravarty@arm.com>
Subject: Re: [PATCH 0/8] Make SCMI transport as standalone drivers
Thread-Topic: [PATCH 0/8] Make SCMI transport as standalone drivers
Thread-Index: AQHa0u8dYiYl9go+nkKv95DYE5QWabHxhfIAgAAPpICAErgPsw==
Date: Tue, 23 Jul 2024 13:36:55 +0000
Message-ID:
 <PAXPR10MB4687398182E577AD00B447FBFDA92@PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM>
References: <20240710173153.4060457-1-cristian.marussi@arm.com>
 <PAXPR04MB84592E272D5C16813529815588A52@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <Zo_qly7DOJkb05B_@pluto>
In-Reply-To: <Zo_qly7DOJkb05B_@pluto>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_Enabled=True;MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_SiteId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_SetDate=2024-07-23T13:36:55.372Z;MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_Name=None
 (Unclassified);MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_ContentBits=0;MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_Method=Privileged;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR10MB4687:EE_|PA2PR10MB8818:EE_
x-ms-office365-filtering-correlation-id: 4913484c-8e9e-4147-b88f-08dcab1c84df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?8VweVNGRtTbU186/NisRFgydTHmhf+H9QzrWiPyAqnVK87GRD6w7C2vxMq?=
 =?iso-8859-1?Q?gSeRaBP3i95MPndizUIIs4ER8YXw2EodubmM6mbarOYNf+EGaravHhYlp+?=
 =?iso-8859-1?Q?v7legUbFiVfa9/ZD5gUZ5VcVeB3AWw3mRab3XBcw1H7KrUadU+fnwSleXQ?=
 =?iso-8859-1?Q?F4dj7S0+IZSuJ4u3utr11LdfLKcLZJdrHNzXxXaUpWhq7AvjUjuo5gBtQl?=
 =?iso-8859-1?Q?Mptx0zjXVMiIIU3m0nkSuZ+DmUhy1C2natBofGYyI9AUNkhLWGQa8FWgYv?=
 =?iso-8859-1?Q?W/cDkpavaKDGgjJfwz6oP5ddURBxaCOHPh5KqTlkVFl9dAi+ewHh4xqN2p?=
 =?iso-8859-1?Q?C4hGhuTZdte1rGQyO5+V8KefHK1UGt5yNdIpztaKZ7RXpWhTyEWEQFdf0r?=
 =?iso-8859-1?Q?jZyAF+uiod03OX3l0AbAyloTQnEZlInd/xmFJwU7nS6LUI13Vmd+uCK1nB?=
 =?iso-8859-1?Q?efn0eoGyR3cz56vJvQjp+iCQGHTI99ckydd6+pXSASrfTprG1bTYmpa1mV?=
 =?iso-8859-1?Q?ofgjA0XMTZWBjQqBI1/+20E1i5kRXktUKPRIwYwh0vfAtBOz3mPNPXztxP?=
 =?iso-8859-1?Q?/Q+RjpJYUC0cRscID0PUyudczX1eAc2JnuCNsSXfYkaLq38D7X5AcLWjAR?=
 =?iso-8859-1?Q?+Pcvt7eLRpv5o5Gr0+QiAvDmWrifeVkriMf383dbVS1mGVwWSfV3h8NOSt?=
 =?iso-8859-1?Q?rqygnJfoTe9iwwQ40jpJLTbZomaNMM9XQr1DWoi7s2SsL34NHBkBVhaL8k?=
 =?iso-8859-1?Q?wJA+lrKhpw5X/9McF/RnsxHXf10zWEfWAdTCeh89oLuYQeH7kJreaxdjvG?=
 =?iso-8859-1?Q?EYdpWs+ik85mlJIEgkUateZlBA0wHfyh73msM9WLtBU7rY+cUktcaXd9C4?=
 =?iso-8859-1?Q?mAS1addJVu8WD2AzcGV/G8l1qsFgtOgMd7e+AVD2gectB0CPnAzzCj6Wc1?=
 =?iso-8859-1?Q?1csWQlTEW1xHNBmlnBw/X5HjtgZQRPpt0tXBdyOpyN1WgMTQlbnwYyFHue?=
 =?iso-8859-1?Q?eBJtl1lEUivbjBMCWP2WqEsJqN75eQUzgPO6SpmVZud04yO1lRg5aKLXm9?=
 =?iso-8859-1?Q?aCgSt3adC3uuhpmVHFaH9vuLEDRgmIKU9xOa7cAVqqlNPBgTg0tEXtgmGt?=
 =?iso-8859-1?Q?/UUGkBQaV9oPvxg7VDIhtpFtBS3uwDPO4pS4VoZtfG2jZ4PU2fH9WMiSIb?=
 =?iso-8859-1?Q?vU6BTTZipgIJIBXU/SVySiu/WHy7Vxu9D5B9kZ0qydy6SYKLucwPtpbH1s?=
 =?iso-8859-1?Q?iCVAGJM1HFHAFfKGi73PzyoFlO7KfJpJgsWU2FB7BLUIqu6cgaq5+w03Nq?=
 =?iso-8859-1?Q?nrL2iePTxn9GfvgnF4/GFlyAQbeNqgzkiH+zwITf/Grexe4/St/2lA+rfX?=
 =?iso-8859-1?Q?8glt3bqHKQofv2cWl5XDYvWsuH6FXFUvxXadip5T6o6tLMotv51MuhwIAp?=
 =?iso-8859-1?Q?tZJP7zZwfeoEycezdk4qpbnkdH9l/Lj8wmuGfg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?aGYPeMdapImPuJeRi8HLZUbmBZEOOlzFYxOC0DhCvsH3KbGrxG/N2pLHS0?=
 =?iso-8859-1?Q?v6JdG9f5ddv1A2rpSRzUpw8RLzl4JoxKgQqIleQQ7w4DBclLvJ8gEpEteN?=
 =?iso-8859-1?Q?Ui8kwRpN/w7+/wa74Sl88DQ+glBBC9YJaa6AJPyqE3Lo1okIgrzJ7fjno5?=
 =?iso-8859-1?Q?GYmb5Fv5SFPkd2Ny7HcwPNbEiQcLGsfhvv9Vvf96h1szW9Lq+zg2U4iylM?=
 =?iso-8859-1?Q?Us23aGdoQP/rrs/LFSSjEM/6jWhfM13aq7iCHFxbg0cTHcRzD3oYaZl7uU?=
 =?iso-8859-1?Q?W0IRJooDeh5jnDvCCmYAXX/b1eJRYfR4TteB4TfgVhcU+gxTXnAPwhla8O?=
 =?iso-8859-1?Q?DO9Zy17nv3i7QMazMs2n/j7eirSUOuL9PPQERSvBOHwbIqX3nXnC0cqh32?=
 =?iso-8859-1?Q?r9E63eUfEalQbOoA1Od6nx5E57I/sGiiexG7oAPIfIHJ+DEQCIEUHlpTnt?=
 =?iso-8859-1?Q?Pi+LwLXwEmnw6ePzNrJqo4C1kGwok/Ga/wz1OI08DCgYlMcbZ/EL7wFk4y?=
 =?iso-8859-1?Q?rEzV3xXCNy82zrgueFjjDLEt61HYZeA8TVH49Dn6uc3E/sqY2xkYMgi+XE?=
 =?iso-8859-1?Q?/OWJ14J0na1bmdNsvE4tmXlfDP+Te3M/nv8tLZ8o0abTYlhRaDxdijnPKr?=
 =?iso-8859-1?Q?Db8XZOl9lhNnE6heVnSJGtHWAO1I016Nmx9t9lc0rg/5lPJVAnET8Z9sFi?=
 =?iso-8859-1?Q?e0YPNlcBIuX0LwUps+/reQY/f8JiRs240WrArndOnGBXIzutZJ57FWuDSQ?=
 =?iso-8859-1?Q?O8/9trwLV9joG5xJrZyPFxgjtiY1zSlSNxL/LYVTu/q8j3f8RwKQcK7NAz?=
 =?iso-8859-1?Q?RxQcfkhvh2Ud4ehSCd0TAd8rgO3DAS34gtxqjW4G87CMei1FsHFFnH+KZD?=
 =?iso-8859-1?Q?L2gETLZXi+b2LCcWaq8Qv0DkuIBTepq5shlcrKt1GEfV+NdSd1DwCE0XrP?=
 =?iso-8859-1?Q?70/kV+C912mX5ImKSjTYJhx3A599y0X+p2ZhygmGaUVMP3JCXtQaEAFXl3?=
 =?iso-8859-1?Q?GVZhyq5L2oKaUbiKjIjA74QnM8fwpZ+yqI8mHL4faAwuY+dMdde7jjldh3?=
 =?iso-8859-1?Q?gtKsBFzpDY6lg5PWIebMxmANj5e69LUb66xIr4JhOIae4MFXRzYHdjfuZ+?=
 =?iso-8859-1?Q?FMlK4OM3VjCTCnxYzkIaWcufiEBhbjHVPJDpLb9Lb0VWH6eo2GwJghuhPi?=
 =?iso-8859-1?Q?bItOAjFmS0FGtQu/IqPtdw7aADCYm+wIqq7XxQx72xEHhjN5X/Xzfv2jmM?=
 =?iso-8859-1?Q?84xrSUD9Xf7JMn0UBltQ/yfXlNQS4wqRAbG7xbdpe+5M5NgsWVOH3bK0q5?=
 =?iso-8859-1?Q?aQLRUn7/bUCfsqHECG02Ba9J+CgRBlD4iRWovesVaG7XMwyOUcLWHYhKRt?=
 =?iso-8859-1?Q?QvB579AhxDICAvs2KKGQYk3LlS7bvoMPQV+ZKxVuGxq0owzDxTk8FPDazv?=
 =?iso-8859-1?Q?SDcG/ee8xMMka1PA+/MiarhCXjQJ+0UrvzheiAzVYMCFu9oxriN+66mf9O?=
 =?iso-8859-1?Q?8CmDEOsbjOCk1xWXUyKNozTF0d4b1gHP8eDpueICHKyGfy9xOkwgJdgR3i?=
 =?iso-8859-1?Q?KLQYXTp+aZyjHQO2HFso9r+GP+tY2eRw0d1r90Kbz4thgLrcJ4nawJzzio?=
 =?iso-8859-1?Q?OWogoAc2IBPgYr0S8ZmmDH3jVQciabl2Tv?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ST.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4913484c-8e9e-4147-b88f-08dcab1c84df
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2024 13:36:55.6302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AXRbszG1V45TSARThG2qC4FACStSu+/oMXqBg1cwWrMd/xMOpwBbvUHOgXaA9n70S8aPisMsPo/M3EGZB+ps3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8818
X-Proofpoint-GUID: UmzJuawnZkCzquhFdHzrUUDbd8qme1OI
X-Proofpoint-ORIG-GUID: UmzJuawnZkCzquhFdHzrUUDbd8qme1OI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-23_02,2024-07-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 mlxscore=0 impostorscore=0
 clxscore=1011 suspectscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407230097

Hi Cristian, Peng,=0A=
=0A=
On Thursday, July 11, 2024, Cristian Marussi worte:=0A=
> On Thu, Jul 11, 2024 at 01:26:16PM +0000, Peng Fan wrote:=0A=
> > > Subject: [PATCH 0/8] Make SCMI transport as standalone drivers=0A=
> >=0A=
> > You may need use V2 here :)=0A=
>=A0=0A=
> ...oh damn :P=0A=
>=A0=0A=
> > >=0A=
> > > Hi all,=0A=
> > >=0A=
> > > Till now the SCMI transport layer was being built embedded into in th=
e=0A=
> > > core SCMI stack.=0A=
> > >=0A=
> > > Some of these transports, despite being currently part of the main=0A=
> > > SCMI module, are indeed also registered with different subsystems lik=
e=0A=
> > > optee or virtio, and actively probed also by those: this led to a few=
=0A=
> > > awkward and convoluted tricks to properly handle such interactions at=
=0A=
> > > boot time in the SCMI stack.=0A=
> > >=0A=
> > > Moreover some partner expressed the desire to be able to fully=0A=
> > > modularize the transports components.=0A=
> > >=0A=
> > > This series aim to make all such transports as standalone drivers tha=
t=0A=
> > > can be optionally loaded as modules.=0A=
> > >=0A=
> > > In order to do this, at first some new mechanism is introduced to=0A=
> > > support this new capability while maintaining, in parallel, the old=
=0A=
> > > legacy embedded transports; then each transport, one by one, is=0A=
> > > transitioned to be a standalone driver and finally the old legacy=0A=
> > > support for embedded transport is removed.=0A=
> > >=0A=
> > > Patch [1/8] is a mostly unrelated (but much needed) clean-up from=0A=
> > > Peng, which I included in this series to avoid conflicts at merge.=0A=
> > >=0A=
> > > Patch [2/8] simply collects the existing datagram manipulation helper=
s=0A=
> > > in a pair of function pointers structures, in preparation for later r=
eworks.=0A=
> > >=0A=
> > > Patch [3/8] adds the bulk of the new logic to the core SCMI stack and=
=0A=
> > > then each existing transport is transitioned to be a standalone drive=
r in=0A=
> > > patches 4,5,6,7 while shuffling around the compatibles. (no DT change=
=0A=
> > > is needed of curse for backward compatibility) While doing this I kep=
t=0A=
> > > the module authorship in line with the main=0A=
> > > author(S) as spitted out by git-blame.=0A=
> > >=0A=
> > > Finally patch [8/8] removes all the legacy dead code from the core=0A=
> > > SCMI stack.=0A=
> > >=0A=
> > > No new symbol EXPORT has been added.=0A=
> > >=0A=
> > > The new transport drivers have been tested, as built-in and LKM, as=
=0A=
> > > follows:=0A=
> > >=0A=
> > > - mailbox on JUNO=0A=
> > > - virtio on emulation=0A=
> > > - optee on QEMU/optee using Linaro setup=0A=
> > >=0A=
> > > Exercised using the regular SCMI drivers stack and the SCMI ACS suite=
,=0A=
> > > testing commands, replies, delayed responses and notification.=0A=
> > >=0A=
> > > Multiple virtual SCMI instances support has been tested too.=0A=
> > >=0A=
> > > SMC has NOT been tested/exercised at run-time, only compile-tested.=
=0A=
> > > (due to lack of hardware)=0A=
> > >=0A=
> > > Note that in this new setup, all the probe deferral and retries betwe=
en=0A=
> > > the SCMI core stack and the transports has been removed, since no=0A=
> > > more needed.=0A=
> > >=0A=
> > > Moreover the new drivers have been tested also with a fully=0A=
> > > modularized SCMI stack, i.e.:=0A=
> > >=0A=
> > > =A0 scmi-core.ko + scmi-module.ko + scmi_transport_*.ko [ + vendor=0A=
> > > modules ]=0A=
> > >=0A=
> > > ToBeDone:=0A=
> > > =A0- completely remove any dependency at build time at the Kconfig le=
vel=0A=
> > > between=0A=
> > > =A0 =A0the SCMI core and the transport drivers: so that the transport=
s will be=0A=
> > > =A0 =A0dependent only on the related subsystems (optee/virtio/mailbox=
/smc)=0A=
> > > =A0 =A0(easy to be done but maybe it is not worth...)=0A=
> > > =A0- integrate per-platform transport configuration capabilities=0A=
> > > =A0 =A0(max_rx_timeout_ms & friends..)=0A=
> > >=0A=
> > > Based on sudeep/for-next/scmi/updates.=0A=
> > >=0A=
> > > Any feedback, and especially testing (:D) is welcome.=0A=
> > >=0A=
> >=0A=
> > For the v2 patchset:=0A=
> > Tested-by: Peng Fan <peng.fan@nxp.com> =A0#i.MX95-19x19-EVK=0A=
> >=0A=
>=A0=0A=
> Thanks a lot for the review and testing,=0A=
>=A0=0A=
> Cristian=0A=
=0A=
=0A=
I've tested this v2 on stm32mp157c-scmi.dts. Using built-in modules=0A=
works perfectly.=A0 I've tweaked my platform setup to test the .ko and=0A=
modprobe part. It works ok for the probe part but I faced kernel oops=0A=
when unloading scmi-module after transport is loaded, used, then unoaded.=
=0A=
The issue I saw is around calls to info->desc->ops->chan_free in=0A=
scmi_cleanup_channels(). I wonder if there are some ops that were not=0A=
unregistered when transport driver is unloaded.=0A=
=0A=
Aside this, I'll sent few minor comments on few patches of your series.=0A=
=0A=
Best regards,=0A=
Etienne=0A=
=0A=

