Return-Path: <linux-kernel+bounces-260029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFEE93A1BD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 15:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3118C1F2349E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 13:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8096F152792;
	Tue, 23 Jul 2024 13:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="b2CCBSbg"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14DC153506;
	Tue, 23 Jul 2024 13:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721742006; cv=fail; b=i2B3p5i2fEBPn4rwmcvVEHSzTlYX5jiXVPwwRTxG2Tx5MEFiB1NyfzouGN+LFEfy7m3SBmBvsRjyaXfXz1OjDQlmdDqfJA3sPSb+cxX8OxgpCRnSWAHzWQ2h1OjTMpJoiWp38lshQfs6EzKN9VtpCzh0u8I5x3IBut3PNYAeL0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721742006; c=relaxed/simple;
	bh=EEOV8LlIz7o53grwf6cRP+gDT+FyeITPScBYwLa8yYo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cMi0RAOg6VWffbXxHKtW1kwWeVZAD7Jw3o/pFP+XglA7NF6y0s+u3sYUuNV1f1E2lBa6m7ZeBHlHlLRoYNjxqKyMfyfM0KTC2tnedSv0E3F7Wm3s+oM3IuZhrSff7ojikCnKDiktqbPehvUD3T0+8csHyE456n5Kjs/gfWaUyU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=st.com; spf=pass smtp.mailfrom=st.com; dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b=b2CCBSbg; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46NBcXbY032420;
	Tue, 23 Jul 2024 15:39:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	STMicroelectronics; bh=EEOV8LlIz7o53grwf6cRP+gDT+FyeITPScBYwLa8y
	Yo=; b=b2CCBSbguCyvTfSOf8H/Qxa+VhsHAF0l9j2Z/VHEUH2zAyBX5ZZuNMYjA
	PzwQQPPnJPnHRdHOfAFSZorxEUppraylzJ5NFYq9yZJCB5UVjWpQ/JLjMPuB/hd2
	nI1KEbeUOh6St6U9YK1neq0+E3+FEyEUxDoAeGHOV4GGXeakL1tjMO7bVNY8XRPe
	j7ImJBv5VyS+QHMD8JV1aCS5VF/lv3hEl1qvy6IEekeV/dFjjmSbAgf40vcOhufc
	Ye4nsI97Qt2H8bErh+XW2HcM8MpKmSFElDj4ErU9NNXOoHq4UAdS6+pq3qvboKPG
	tumnI2kbZwV3myOs/ZIiOoancKktA==
Received: from eur05-db8-obe.outbound.protection.outlook.com (mail-db8eur05lp2105.outbound.protection.outlook.com [104.47.17.105])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 40g4jxjk5p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 15:39:43 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VAC3jLAAzPCCjMx7QWS0jMG7qFLI1Ez9Cg+iOL9ZR24orvw17qUyu75Bc1d6GOR88biVEYf9FgIKbYeiaEo/PjyOAy87Ve/RAytq5Qy8rn1sCbuxKUbqd5QA56vn7uIca99y/oCvOORG4LTqm9aWH3xMyapXnqzEHjC/oO4xhj/nVVZa3bYCtN3dy8OMMjhUH2R7qWQM9sLrMZDkomQNvhM0ykbk+V51UzDd8+3dmuY7smGW0CMfu6I0/fYlpyD0nRNS3GU5CCelWwtqw456q5YH2lbNSrKs/ABqQk3M+jN6LCdd7eBHHCWQlpU4e4UPgI07BntionEXme2ixFr+Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EEOV8LlIz7o53grwf6cRP+gDT+FyeITPScBYwLa8yYo=;
 b=pJ6MEl4vUPtYSd17aAAiba9lY5luirCkHu1QvjeYPCWzE7EHHyySZN2Oft7CDTl3JjXNYDDj7xa7wQt8y9qdiA+MBz6G0/Qs8V9IBNs/l2EfydnHNTVcQGUi0oeCrSbitNjcBcOe2yM+B5sUGsDgwW08gwY1v/jULLunX4lFxicBCV2T8BcqJHVeuvOpDiw+jqMHstGO0yjyepSF2fX5a/0ZtWkzJNtgAWfee5vuiqePpjOFhXA6Q54WuQ+8cOKF31ZmM1B4L++0kGbqyjclK40hbiZOOoD2TSsxCNRPk22VX7IcRQ+BVoDaRpezfLS/q1wXC291ZYY1Rl6xepmVrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=st.com; dmarc=pass action=none header.from=st.com; dkim=pass
 header.d=st.com; arc=none
Received: from PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:157::13)
 by AS8PR10MB7523.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Tue, 23 Jul
 2024 13:39:41 +0000
Received: from PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6004:1d1:46c2:e67c]) by PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6004:1d1:46c2:e67c%6]) with mapi id 15.20.7784.017; Tue, 23 Jul 2024
 13:39:41 +0000
From: Etienne CARRIERE <etienne.carriere@st.com>
To: Cristian Marussi <cristian.marussi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "arm-scmi@vger.kernel.org"
	<arm-scmi@vger.kernel.org>
CC: "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "james.quinlan@broadcom.com" <james.quinlan@broadcom.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "vincent.guittot@linaro.org"
	<vincent.guittot@linaro.org>,
        "peng.fan@oss.nxp.com" <peng.fan@oss.nxp.com>,
        "michal.simek@amd.com" <michal.simek@amd.com>,
        "quic_sibis@quicinc.com"
	<quic_sibis@quicinc.com>,
        "quic_nkela@quicinc.com" <quic_nkela@quicinc.com>,
        "ptosi@google.com" <ptosi@google.com>,
        "dan.carpenter@linaro.org"
	<dan.carpenter@linaro.org>,
        "souvik.chakravarty@arm.com"
	<souvik.chakravarty@arm.com>
Subject: Re: [PATCH v2 3/8] firmware: arm_scmi: Add support for standalone
 transport drivers
Thread-Topic: [PATCH v2 3/8] firmware: arm_scmi: Add support for standalone
 transport drivers
Thread-Index: AQHa0u8kX4SciVGjgUS+6UFfwsXP9rIEBU/U
Date: Tue, 23 Jul 2024 13:39:41 +0000
Message-ID:
 <PAXPR10MB4687B74810CA8EDB5BFC4781FDA92@PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM>
References: <20240710173153.4060457-1-cristian.marussi@arm.com>
 <20240710173153.4060457-4-cristian.marussi@arm.com>
In-Reply-To: <20240710173153.4060457-4-cristian.marussi@arm.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_Enabled=True;MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_SiteId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_SetDate=2024-07-23T13:39:41.139Z;MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_Name=None
 (Unclassified);MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_ContentBits=0;MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_Method=Standard;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR10MB4687:EE_|AS8PR10MB7523:EE_
x-ms-office365-filtering-correlation-id: 0293dd1e-8a27-47ca-efe0-08dcab1ce7ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?PPbAI8Bw+mKGyhC6Beu8+ml/c9PSHJ8glcu6uV49Le/MVCB0gbiFZQre/f?=
 =?iso-8859-1?Q?lL0eVSWenk25Dm9Db5FhZ/4l+EUkiX8KrqETwRArqHcGwLCAiD8qTFoLQX?=
 =?iso-8859-1?Q?d+Zhdhv8fPZv73uqZC4+FAsV8x9ZxgZA3eXAet1txjioT64Z9GwAs7qOUk?=
 =?iso-8859-1?Q?RjdZRgheG6Y89QnLsiam6BoQJ3xbau60heAC000Xn/f3ko/TrDPKrsPKaD?=
 =?iso-8859-1?Q?Cy6kBCirF02UDFQs2rLCjYlo/C0tetXgVdRhtNtAsgLu2ajNvBb292QA5P?=
 =?iso-8859-1?Q?w2JGGVKCBHjIKDajmo9gDdxELPgtn7hNLQAxKi/R2OredyuWVNMlGj6AVl?=
 =?iso-8859-1?Q?HPl3zSPDQMtdasxOKN0LVeKDBbO/+q5iFd6vshJ0eibQa5uzVguRiLCQxr?=
 =?iso-8859-1?Q?HhWkYuA03GxMwkBHWCzrXnAvZ0WwOf0Eu80/lWgO5KhlN9zuOivLQLjK4s?=
 =?iso-8859-1?Q?ESGwM0HnN6kO8CKl986Cd0+569mi8taa/qv1650jUtnT9NWe4AnYtCLvuS?=
 =?iso-8859-1?Q?poL1dyKRzaTCpdfbmVkOv5iyuZ9+VWNKQGxIXjFgCERkjeX4xCC1jO/9tg?=
 =?iso-8859-1?Q?BlUPN1rfUDTX4ZzLlULlWILg5anB5DIBfj1jsrsi6VpyAxIrE7zRDRNuGW?=
 =?iso-8859-1?Q?Ly1K3aRJb4X75gh8dFJZjpExmGv8J8NUkCnm+aJIvNWEevJQguNOQdzh/D?=
 =?iso-8859-1?Q?uIm8eo6w5VvtnoWZ2Kj4Ut6ClwasGZAzv8j/TfCUqWR2rnoFVgyqEgOY/T?=
 =?iso-8859-1?Q?1cCLu0gWMTKBxe11LC9LZwe1wh8DELxBXB+kaJ0quXGhQrL1iNeKx9un3m?=
 =?iso-8859-1?Q?qIjxfUZd8DMMKWGNLDoO8r9O6/6cgrKXl3m9AuxAQ8lX4YGAtfTULJ69Ia?=
 =?iso-8859-1?Q?4T5xcrZVmhdfuyHKosjchM3FB6dLByqjv37QDi8iDNN1tWoR3iOZE6601T?=
 =?iso-8859-1?Q?4UPFml6PJDwWFovdskxmbagsD22dVfBijp5FGyWCFtd+sdNWkd6zto7YUt?=
 =?iso-8859-1?Q?qOGiphz6JbNXcVre9E5dFst+b8SkMk2HilEnhFinK3xzeOUeSs/GSUDRpQ?=
 =?iso-8859-1?Q?6YXIRsv9LfCB/BeGDej+fwdcxXlc12+kbYMharehrcVAlJRWdi1DNKAMsp?=
 =?iso-8859-1?Q?ycb600ChHsoee/Xt0DWgNQjKeXuMqQpe84ntP5nyQo46/Kg8Z1yVtYiMYd?=
 =?iso-8859-1?Q?spaZ72KHXs/Q/Q3CloZEsxPVT3mrVUkZDSu7TXTyewAbaBcLVasnIGmcla?=
 =?iso-8859-1?Q?adwjvbHsvqr+12xrTpaWTexTToRWbexzJqjXuTGgjLnWSb/61ka3oxxJcg?=
 =?iso-8859-1?Q?186ZVzlAt+0rIQ4NlFdg8fINpG4dR9YLJwvQAyLLOZcIJqZbL0gIj/DUkS?=
 =?iso-8859-1?Q?J0as6mpXFNGSqOy5Xj0q/0zoy43zYuqb5pllIhs1XoNqkiRwo4g3MfrY8G?=
 =?iso-8859-1?Q?ReGgv9Vy1wUU6ZuuhQWxhQ+ElSa+tiE5RqEVHg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?slMvWkzc0xyC0S4XEiVSo6Xrqw0lpljy//AFhvfw2i6fdn2+Moa/gtQXa9?=
 =?iso-8859-1?Q?iPXzy8tpjQcEUxDjwY2G8ZmxoRt6ktOsVNkfeaYT/NnpvKv0P7FeDaiGTL?=
 =?iso-8859-1?Q?klJttYrVmgioFJHuphHeH2ti5fkW5outr5Rj9y5V4bG5hMGZHvctVKwD0I?=
 =?iso-8859-1?Q?FkBHdswwZ3A0uWUVXpJGzOTuWXv18DQjXEkTLGWR326G4qxc95ZgdPrh7X?=
 =?iso-8859-1?Q?kO1eHCW6dm+a3yiAQSc4pgepxxtQtbvNOCpxkXQ3DXUi1GuqgQddGG69kI?=
 =?iso-8859-1?Q?CaXk9wFosD6rmT1AbTwtTHzOwT90xb2uTDLldsFchMK5eP1oEG+4D+hCYr?=
 =?iso-8859-1?Q?c7o75/YhgBTeTVos6jVxcYbH7R9W9tHT+w653nY0JYzWAHG0Cw4eArxhBy?=
 =?iso-8859-1?Q?OZ2XZHX99U52EqRbEkFpXV6D5UF/k8UUvecTSpdqydSwGuDT2xP/4ND8WC?=
 =?iso-8859-1?Q?VsvVcuf/7lWV5jesi7p5+NxBRmu27sIGix7Sq7m+z94MI0jJGy3F34FMln?=
 =?iso-8859-1?Q?0/3zeIYoE7eZOvYmqYj1uQCyJZReg+v+7AVOTlp/uwBgf7y9XwtVa4qeP4?=
 =?iso-8859-1?Q?s6Br4a96qTXTSUTRVvtPPpIfs9Fz7oJbRxqh9k0TSsR1oPABpDP1ylUW3c?=
 =?iso-8859-1?Q?6AqD/0w6XLFcUvbSGZbD7fh4GloszOnuSadso7CX9T1GihAAS4UyYTb2De?=
 =?iso-8859-1?Q?hoy2MTCjJIAAe1j7FT7gu3uebf1gZ6AonqB0ndfwiri4l7B8VCnlV6nw/Q?=
 =?iso-8859-1?Q?J8iWjYGBHWJDSTmY0Gk9y5baWFYuSixHGk7kBblfqAenSSVaEXfhN6VYIk?=
 =?iso-8859-1?Q?44mBnPb/vRjndnzvAQRlejTk9Z4PinMoBPqcT/IN5GfKPI0GmlmUP+Hztk?=
 =?iso-8859-1?Q?E/MjGPf2gBo9IZNyMz8A9URqfSJFfOl4Ep8K1KsWhEVL3H7Axu4zzTHzuT?=
 =?iso-8859-1?Q?KiMMLeNj7VLLZsD8Bq+807igZacYg58yTLpxBeze3jfBR4JTmB0EQs6CZ1?=
 =?iso-8859-1?Q?rvq/D9FXQKfXLunt4VgvcZK0K0KgUpKH1B+pavRj+crBpJz/WO6J4jeEHV?=
 =?iso-8859-1?Q?rK0S/hf92JXeibFSPSrhnC1Gxe2UYsP08JYr9CStcxSXp7qcA3TI4Lhg0n?=
 =?iso-8859-1?Q?63DhwomU3085AEa1drNNoC9eyv/b5a2MzzQiFtnoQI1J/VzIZpxHFVSZEj?=
 =?iso-8859-1?Q?ptuBe5fYjVJdrlvB1LIKeAaspFdVX9wUIoMfbhV+GUsTC8hfomYKhhVat1?=
 =?iso-8859-1?Q?ygWu1E423vE4/aPdpRkdPFs+kIl+OWY/ZPbtv+zdI44cMqU7LUqAJPNPtz?=
 =?iso-8859-1?Q?2QiDwqwYA8X1Q9IehDMqzqiDg1JMLzxdXpZBenxrg270eTG9aF8ZuwApZE?=
 =?iso-8859-1?Q?PcdCJAq4kyZVKEY5HHZHttmowvLAb4/ls7IAVN/85HrkUARIZEEKPCYMRr?=
 =?iso-8859-1?Q?zkgxD02MT9I4+XTWeY40mq+vooGM0nqwav9Z2jPNgVhd3vrl9teHNRChTk?=
 =?iso-8859-1?Q?pfqvJHEh8HEZatJnnZkcWplcJU/9UIgicycFKfgF7iLojt+zm6OBMWP+vZ?=
 =?iso-8859-1?Q?NsFsH7vSLDfxSZunTmnEnGAUqXgHD1ukF0I9up+Gg7O1+rcbGZJ9PmxnGt?=
 =?iso-8859-1?Q?dN6KlQZ2PVU92dwz2hMd+ImtYdnvevTThG?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0293dd1e-8a27-47ca-efe0-08dcab1ce7ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2024 13:39:41.3758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QuVjRNCOkodtT3Gk8jmE4OlpEPOhXn4RDYUkLZodaev6ilaAVP1ZM93Wwk0Hbl5R6H5RVm3+ioH3n0xMo0LATg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7523
X-Proofpoint-ORIG-GUID: U3I5qdp-8bAyL1Syqn2ZUEjX45CM-psz
X-Proofpoint-GUID: U3I5qdp-8bAyL1Syqn2ZUEjX45CM-psz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-23_02,2024-07-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 bulkscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407230097

Hi Cristian,=0A=
=0A=
Few nitpicking comments.=0A=
=0A=
On Wednesday, July 10, 2024, Cristian Marussi wrote: =A0=0A=
> Extend the core SCMI stack with structures and methods to allow for=0A=
> transports to be split out as standalone drivers, while still supporting=
=0A=
> old style transports, defined as built into the SCMI core stack.=0A=
> =0A=
> No functional change.=0A=
> =0A=
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>=0A=
> ---=0A=
> NOTE: old style transport support will be removed later in this series.=
=0A=
> =0A=
> v1 --> v2=0A=
> - fixed comit message=0A=
> ---=0A=
> =A0drivers/firmware/arm_scmi/common.h | 84 ++++++++++++++++++++++++++++++=
=0A=
> =A0drivers/firmware/arm_scmi/driver.c | 44 +++++++++++++++-=0A=
> =A0drivers/firmware/arm_scmi/msg.c=A0=A0=A0 |=A0 5 ++=0A=
> =A0drivers/firmware/arm_scmi/shmem.c=A0 |=A0 5 ++=0A=
> =A04 files changed, 136 insertions(+), 2 deletions(-)=0A=
> =0A=
> diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_sc=
mi/common.h=0A=
> index 8e5751aaa600..4af06810eb39 100644=0A=
> --- a/drivers/firmware/arm_scmi/common.h=0A=
> +++ b/drivers/firmware/arm_scmi/common.h=0A=
> @@ -349,6 +349,8 @@ struct scmi_shared_mem_operations {=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bool tx, struct resource *res);=0A=
> =A0};=0A=
> =A0=0A=
> +const struct scmi_shared_mem_operations *scmi_shared_mem_operations_get(=
void);=0A=
> +=0A=
> =A0/* declarations for message passing transports */=0A=
> =A0struct scmi_msg_payld;=0A=
> =A0=0A=
> @@ -376,6 +378,88 @@ struct scmi_message_operations {=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 size_t max_len, struct scmi_xfer *xfer);=
=0A=
> =A0};=0A=
> =A0=0A=
> +const struct scmi_message_operations *scmi_message_operations_get(void);=
=0A=
> +=0A=
> +/**=0A=
> + * struct scmi_transport_core_operations=A0 - Transpoert core operations=
=0A=
> + *=0A=
> + * @bad_message_trace: An helper to report a malformed/unexpected messag=
e=0A=
> + * @rx_callback: Callback to report received messages=0A=
> + * @shmem: Datagram operations for shared memory based transports=0A=
> + * @msg: Datagram operations for message based transports=0A=
> + */=0A=
> +struct scmi_transport_core_operations {=0A=
> +=A0=A0=A0=A0=A0=A0 void (*bad_message_trace)(struct scmi_chan_info *cinf=
o,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 u32 msg_hdr, enum scmi_bad_msg err);=0A=
> +=A0=A0=A0=A0=A0=A0 void (*rx_callback)(struct scmi_chan_info *cinfo, u32=
 msg_hdr,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 void *priv);=0A=
> +=A0=A0=A0=A0=A0=A0 const struct scmi_shared_mem_operations *shmem;=0A=
> +=A0=A0=A0=A0=A0=A0 const struct scmi_message_operations *msg;=0A=
> +};=0A=
> +=0A=
> +/**=0A=
> + * struct scmi_transport=A0 - A structure representing a configured tran=
sport=0A=
> + *=0A=
> + * @supplier: Device representimng the transport and acting as a supplie=
r for=0A=
=0A=
typo: s/representimng/representing/=0A=
=0A=
> + *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 the core SCMI stack=0A=
> + * @desc: Transport descriptor=0A=
> + * @core_ops: A pointer to a pointer used by the core SCMI stack to make=
 the=0A=
> + *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 core transport operations accessible to=
 the transports.=0A=
> + */=0A=
> +struct scmi_transport {=0A=
> +=A0=A0=A0=A0=A0=A0 struct device *supplier;=0A=
> +=A0=A0=A0=A0=A0=A0 const struct scmi_desc *desc;=0A=
> +=A0=A0=A0=A0=A0=A0 struct scmi_transport_core_operations **core_ops;=0A=
> +};=0A=
> +=0A=
> +#define DEFINE_SCMI_TRANSPORT_DRIVER(__trans, __match_table, __core_ptr)=
\=0A=
> +static int __trans##_probe(struct platform_device *pdev)=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> +{=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> +=A0=A0=A0=A0=A0=A0 struct scmi_transport *scmi_trans;=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> +=A0=A0=A0=A0=A0=A0 struct platform_device *scmi_pdev;=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> +=A0=A0=A0=A0=A0=A0 struct device *dev =3D &pdev->dev;=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 \=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> +=A0=A0=A0=A0=A0=A0 scmi_trans =3D devm_kzalloc(dev, sizeof(*scmi_trans),=
 GFP_KERNEL);\=0A=
> +=A0=A0=A0=A0=A0=A0 if (!scmi_trans)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ENOMEM;=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> +=A0=A0=A0=A0=A0=A0 scmi_pdev =3D devm_kzalloc(dev, sizeof(*scmi_pdev), G=
FP_KERNEL);=A0 \=0A=
> +=A0=A0=A0=A0=A0=A0 if (!scmi_pdev)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ENOMEM;=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> +=A0=A0=A0=A0=A0=A0 scmi_trans->supplier =3D dev;=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 \=0A=
> +=A0=A0=A0=A0=A0=A0 scmi_trans->desc =3D &__trans##_desc;=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
=0A=
It's a bit weird the scmi_desc shall be specifically labeled __trans##_desc=
=0A=
in the transport driver source file while match table and transport core=0A=
operations instances references are passed as arguments. I think it's =0A=
worth having the scmi_desc label also passed as an argument to=0A=
DEFINE_SCMI_TRANSPORT_DRIVER() macro.=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0 scmi_trans->core_ops =3D __core_ptr;=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> +=A0=A0=A0=A0=A0=A0 scmi_pdev->name =3D "arm-scmi";=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 \=0A=
> +=A0=A0=A0=A0=A0=A0 scmi_pdev->id =3D PLATFORM_DEVID_AUTO;=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> +=A0=A0=A0=A0=A0=A0 scmi_pdev->dev.platform_data =3D scmi_trans;=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> +=A0=A0=A0=A0=A0=A0 device_set_of_node_from_dev(&scmi_pdev->dev, dev);=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> +=A0=A0=A0=A0=A0=A0 dev_set_drvdata(dev, scmi_pdev);=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> +=A0=A0=A0=A0=A0=A0 return platform_device_register(scmi_pdev);=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> +}=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> +static void __trans##_remove(struct platform_device *pdev)=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> +{=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> +=A0=A0=A0=A0=A0=A0 struct platform_device *scmi_pdev;=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> +=A0=A0=A0=A0=A0=A0 scmi_pdev =3D dev_get_drvdata(&pdev->dev);=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> +=A0=A0=A0=A0=A0=A0 platform_device_unregister(scmi_pdev);=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> +}=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> +static struct platform_driver __trans##_driver =3D {=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
=0A=
Same here. I think __trans##_driver label should be also explicitly=0A=
passed as an argument to DEFINE_SCMI_TRANSPORT_DRIVER().=0A=
=0A=
BR,=0A=
Etienne=0A=
=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0 .driver =3D {=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .name =3D #__trans "=
_transport",=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 \=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .of_match_table =3D =
__match_table,=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 \=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 },=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> +=A0=A0=A0=A0=A0=A0 .probe =3D __trans##_probe,=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 \=0A=
> +=A0=A0=A0=A0=A0=A0 .remove_new =3D __trans##_remove,=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 \=0A=
> +}=0A=
> +=0A=
> =A0extern const struct scmi_shared_mem_operations scmi_shmem_ops;=0A=
> =A0extern const struct scmi_message_operations scmi_msg_ops;=0A=
> =A0=0A=
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_sc=
mi/driver.c=0A=
> index 6b6957f4743f..a1892d4d8c69 100644=0A=
> --- a/drivers/firmware/arm_scmi/driver.c=0A=
> +++ b/drivers/firmware/arm_scmi/driver.c=0A=
> @@ -194,6 +194,11 @@ struct scmi_info {=0A=
> =A0#define bus_nb_to_scmi_info(nb) container_of(nb, struct scmi_info, bus=
_nb)=0A=
> =A0#define req_nb_to_scmi_info(nb) container_of(nb, struct scmi_info, dev=
_req_nb)=0A=
> =A0=0A=
> +static struct scmi_transport_core_operations scmi_trans_core_ops =3D {=
=0A=
> +=A0=A0=A0=A0=A0=A0 .bad_message_trace =3D scmi_bad_message_trace,=0A=
> +=A0=A0=A0=A0=A0=A0 .rx_callback =3D scmi_rx_callback,=0A=
> +};=0A=
> +=0A=
> =A0static unsigned long=0A=
> =A0scmi_vendor_protocol_signature(unsigned int protocol_id, char *vendor_=
id,=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 char *sub_vendor_id, u32 impl_ver)=0A=
> @@ -2950,6 +2955,28 @@ static int scmi_debugfs_raw_mode_setup(struct scmi=
_info *info)=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
> =A0}=0A=
> =A0=0A=
> +static const struct scmi_desc *scmi_transport_lookup(struct device *dev)=
=0A=
> +{=0A=
> +=A0=A0=A0=A0=A0=A0 struct scmi_transport *trans;=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0 trans =3D dev_get_platdata(dev);=0A=
> +=A0=A0=A0=A0=A0=A0 if (!trans || !trans->desc || !trans->supplier || !tr=
ans->core_ops)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return NULL;=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0 if (!device_link_add(dev, trans->supplier, DL_FLAG_AU=
TOREMOVE_CONSUMER)) {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(dev,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "Addi=
ng link to supplier transport device failed\n");=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return NULL;=0A=
> +=A0=A0=A0=A0=A0=A0 }=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0 /* Provide core transport ops */=0A=
> +=A0=A0=A0=A0=A0=A0 *trans->core_ops =3D &scmi_trans_core_ops;=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0 dev_info(dev, "Using %s\n", dev_driver_string(trans->=
supplier));=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0 return trans->desc;=0A=
> +}=0A=
> +=0A=
> =A0static int scmi_probe(struct platform_device *pdev)=0A=
> =A0{=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 int ret;=0A=
> @@ -2962,8 +2989,14 @@ static int scmi_probe(struct platform_device *pdev=
)=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 struct device_node *child, *np =3D dev->of_node;=
=0A=
> =A0=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 desc =3D of_device_get_match_data(dev);=0A=
> -=A0=A0=A0=A0=A0=A0 if (!desc)=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
> +=A0=A0=A0=A0=A0=A0 if (!desc) {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 desc =3D scmi_transport_looku=
p(dev);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!desc) {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 err_s=
tr =3D "transport invalid\n";=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =
=3D -EINVAL;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto =
out_err;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
> +=A0=A0=A0=A0=A0=A0 }=0A=
> =A0=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 info =3D devm_kzalloc(dev, sizeof(*info), GFP_KE=
RNEL);=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 if (!info)=0A=
> @@ -3130,6 +3163,7 @@ static int scmi_probe(struct platform_device *pdev)=
=0A=
> =A0clear_ida:=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 ida_free(&scmi_id, info->id);=0A=
> =A0=0A=
> +out_err:=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 return dev_err_probe(dev, ret, "%s", err_str);=
=0A=
> =A0}=0A=
> =A0=0A=
> @@ -3321,6 +3355,12 @@ static int __init scmi_driver_init(void)=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
> =A0=0A=
> +=A0=A0=A0=A0=A0=A0 if (IS_ENABLED(CONFIG_ARM_SCMI_HAVE_SHMEM))=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 scmi_trans_core_ops.shmem =3D=
 scmi_shared_mem_operations_get();=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0 if (IS_ENABLED(CONFIG_ARM_SCMI_HAVE_MSG))=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 scmi_trans_core_ops.msg =3D s=
cmi_message_operations_get();=0A=
> +=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 if (IS_ENABLED(CONFIG_ARM_SCMI_NEED_DEBUGFS))=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 scmi_top_dentry =3D scmi=
_debugfs_init();=0A=
> =A0=0A=
> diff --git a/drivers/firmware/arm_scmi/msg.c b/drivers/firmware/arm_scmi/=
msg.c=0A=
> index f4ba38afe0bb..0bed1d2825af 100644=0A=
> --- a/drivers/firmware/arm_scmi/msg.c=0A=
> +++ b/drivers/firmware/arm_scmi/msg.c=0A=
> @@ -118,3 +118,8 @@ const struct scmi_message_operations scmi_msg_ops =3D=
 {=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 .fetch_response =3D msg_fetch_response,=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 .fetch_notification =3D msg_fetch_notification,=
=0A=
> =A0};=0A=
> +=0A=
> +const struct scmi_message_operations *scmi_message_operations_get(void)=
=0A=
> +{=0A=
> +=A0=A0=A0=A0=A0=A0 return &scmi_msg_ops;=0A=
> +}=0A=
> diff --git a/drivers/firmware/arm_scmi/shmem.c b/drivers/firmware/arm_scm=
i/shmem.c=0A=
> index 208a289642c3..b1fc0c31495b 100644=0A=
> --- a/drivers/firmware/arm_scmi/shmem.c=0A=
> +++ b/drivers/firmware/arm_scmi/shmem.c=0A=
> @@ -187,3 +187,8 @@ const struct scmi_shared_mem_operations scmi_shmem_op=
s =3D {=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 .channel_intr_enabled =3D shmem_channel_intr_ena=
bled,=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 .setup_iomap =3D shmem_setup_iomap,=0A=
> =A0};=0A=
> +=0A=
> +const struct scmi_shared_mem_operations *scmi_shared_mem_operations_get(=
void)=0A=
> +{=0A=
> +=A0=A0=A0=A0=A0=A0 return &scmi_shmem_ops;=0A=
> +}=0A=
> --=0A=
> 2.45.2=0A=
> =0A=

