Return-Path: <linux-kernel+bounces-359685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6DD998F05
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 19:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A232286A8E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 17:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A21519D89E;
	Thu, 10 Oct 2024 17:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l+IAEqH7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rRBnzhxj"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25671C8FB9
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 17:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728583024; cv=fail; b=RNNIUb/xp7DZs7Pb2OaSKb1gcdBQP2VJ+1BqLht/EVWGgdYUGmXgd1fHBYK2PMApmxdahahVhn4YlTxJ5yb0zwNJ0ngZws8e8uVSk6uOFr4cSp7+LgEt+bmniV1Z8NxQjiE25a8PzDK162bDt2tC5sCf0WHvPnzVI/Mm2USyTIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728583024; c=relaxed/simple;
	bh=hMNK4ulbwwCMFL8MndXo6SfhNhR58qGdOy4RDsD/Gks=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=a3JOplzfFu4kZhi+0hKgyWPI2k6ikOns+syiOlsCpfPQ3eNOUmVCsbYst020ZVQ2z24c7sH3I37VCHr/5+9YYXlBLN/nlCzIHg8hFbPfQpdFaHWaRyLDVintnOaoV2BH4SK500RcS2QuNKLSXmApYxBQVAsqTV8bUPOY16/6sjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l+IAEqH7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rRBnzhxj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49AHteFt013641;
	Thu, 10 Oct 2024 17:56:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=utgI8cQub2haIEje1i
	8/NQr3PP0f4K105E+yK4DwSeU=; b=l+IAEqH71tBUf3/gv94EoPftjtjRBskDwg
	XlBz2I5PqrraFhmfLJOocb9W2syZx0CX5DEXZgR2BT3t+pgY8Lwc1jcicZdFyQ2u
	P62AWaSyAvK/9iniqBgoimuPRa/IvT812rkz2bvDYBShqsDBk7mR9CgfxIE2MyxC
	lwKth6WLrIB6pCdhNvTCOetc94mY9QFINYiLgLzhU/EWWNNTpIGLW/2KvNzywHok
	zM5oTxZaljMck8bsJ/Pbv2lUvNVcLP1B8h/6r9f39fRWemMrEqk+zvZ8EE4dEiCu
	Q1M+z2goyMaWd7RSjB+51cwM8AVy/5zzyLZDA1hUXIT6buk1ypxg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42306ekdnx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Oct 2024 17:56:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49AHGMgi017120;
	Thu, 10 Oct 2024 17:56:42 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwgqegd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Oct 2024 17:56:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PwZeDYAKRT1c9hxNBSlWL4+NIW8mYRD2kAf8VzSVFqWeJtfNPKEf38/jaM53veZCsaxl1+5SN+7+4pZHyJy/m6pg6VLtLD43/kCa+MIVlt/x7xCR+aLqg+62LnUHjKiMysIx1m5x6CsgQSP60JkJ7SossPmKIDI9WG8C/Z0vMYrsfUQ54JKoh5OF2MfLNqyKWyPXBwYPrnKZuIvtI4UxpCaGNpCsEnwKWVGpXx2BE+heCuLO0SGctP0OT4wxavIxX6HhkfSt3c+8nZ0uRHEGMTzTZcATylATQBta94cQPFD2c0K8EOc8OtCUGp2CRSU2V7+u1Co8NO6pFyzHU4Odsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=utgI8cQub2haIEje1i8/NQr3PP0f4K105E+yK4DwSeU=;
 b=fyUz/XYchvoOnTNGUYmU4Lvec8hHePADtywd2UJWaA3RIXflLhi0m9SMoKcwGDhPU6cTT64A//tC7Mzz+vU9Z43gka2RaaMSLw8dzr/o2tyf3ZwXLtaiob9eFIgZjpjQm4e/fPADFoxuK448y3c9IanJiziI0v+/27Oemm5OgdOvnDX9074nFciI3Vx4vcFgyzg/wCzJqOUNHBgB+rdHM4pyxc3dyxXHU6ARu1X2iHn5b1yEOayJQbIWGmRsnR3hesbcS8Btnu6iU8BpCnzHLn6AmysoL1yqfBRbPIHp3PsLE3awkAma7Nbj+J8xE/I+B6VbroI4gDsIBIax3rSlDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utgI8cQub2haIEje1i8/NQr3PP0f4K105E+yK4DwSeU=;
 b=rRBnzhxjdQm0MjhK/97r0QDlkGnVSUI78yFY/0ng7upacXTBNTnkcUa5gdrwwVSf03jVPE7e/29K2Hci+Dc4pP7i09jDc0jrrg1zM8DTLS4/CVvgADXxbz/Hh1XAZ22ijfFM0VXiGVRapyxYtQ4SfnlVy+Atm9dCxhGzPmaQ7eU=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DM4PR10MB5941.namprd10.prod.outlook.com (2603:10b6:8:ab::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 17:56:38 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 17:56:38 +0000
References: <20241009165411.3426937-1-ankur.a.arora@oracle.com>
 <20241009165411.3426937-5-ankur.a.arora@oracle.com>
 <20241010065044.kszYbjKa@linutronix.de>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        peterz@infradead.org, tglx@linutronix.de, paulmck@kernel.org,
        mingo@kernel.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, frederic@kernel.org,
        efault@gmx.de
Subject: Re: [PATCH 4/7] rcu: handle quiescent states for PREEMPT_RCU=n,
 PREEMPT_COUNT=y
In-reply-to: <20241010065044.kszYbjKa@linutronix.de>
Date: Thu, 10 Oct 2024 10:56:36 -0700
Message-ID: <87a5fb96zv.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0208.namprd03.prod.outlook.com
 (2603:10b6:303:b8::33) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DM4PR10MB5941:EE_
X-MS-Office365-Filtering-Correlation-Id: 78760ba1-17f0-40ec-3381-08dce954e34a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kWE/L8Xe+Xp8BspIhIQKFojcD5ORw6+D6Ah/ykd7q+2y53rYnuW8dwSYOsZb?=
 =?us-ascii?Q?r1DmhfbmpSfzVdCvzbwTuXFO+680mfI+L8C4Nj3+RgVaTBlJ5Ggn7ESatATZ?=
 =?us-ascii?Q?hO6Zf9sypdS8O1AwM+J7Bs6V90tuthYRpYLR6kJSLCZWBo1WvvvRsq7+IhuW?=
 =?us-ascii?Q?55nbRYjbtyC8HYIe4QYEAZss/SwQdShBxruUa9rqjSOs7lIEpCqGBfZ07IyT?=
 =?us-ascii?Q?C5G2pA0yz4kOvSKlCuTcNZSdRoGCaF/mNoFfb52nCygX0BQNzxE1REJOWu0q?=
 =?us-ascii?Q?Cy5MjLz+I6FYoE3/T5j4mmaiJT2x2ZSOtkMbGN3SXbBIkNFv+wrPUpqpVDmD?=
 =?us-ascii?Q?NH5wkj1OT8IC+fSA4oIZm1o/9PIYX0u2n9RfOTJ+Q3MREpiw2lbYWL0oTH37?=
 =?us-ascii?Q?5+1ma6dE2CSbPchQPtUW7ICBrUKEUiKANMhOV4K7jGK4wwl80l+GC3GZ9r35?=
 =?us-ascii?Q?0PE9gOVE/7tBMHnluEHhuv6/WTYYwN+yBa9/mUFbbVUlqK4XaGwyIWH1zEFa?=
 =?us-ascii?Q?eqQBjVcyKf8ZCEiL8cRMs9NkVqkBDsw1qoZOXAQrNvniJDV8N6wvEVuUIL9j?=
 =?us-ascii?Q?kt9KvggwvlxNnAtm9m0QBzBI9PovWQsrzF//SarrePHi2/oQfbUj/t+W5Bgh?=
 =?us-ascii?Q?v9ufMPF2QDV6a7rLwpn3UxWJUS9jkvzVNKg+5y8GRSembe6ItOgty39m6HuJ?=
 =?us-ascii?Q?qJJEPYC0XnNQ76KHmF/6nRnaCI84Kk2et31eePn+g3z/9iRcDh3O5dD5j1kI?=
 =?us-ascii?Q?cN3Ike4eD2kBs4zsL4w129gNpDmf83Iz2GPWAW+hxU/W7sn+Jfs9XR/aqKWT?=
 =?us-ascii?Q?hXyM/9niBlh5JKD7F1kF3dOuKvSUVNc54UsIh1Hjp08A8Q/Vp7YTPAytaCmc?=
 =?us-ascii?Q?UShYj/U9KMW84+ELJmo05s3ie3d4jpuZaHqfufC+ozplldERDNZ1JsFfPG2o?=
 =?us-ascii?Q?LzoIy15t+KBam9PwSr+XGhmkmYT2q709QgiTcLo/1eiI9+QLIG601zMh9sfl?=
 =?us-ascii?Q?L0kFzJHNYMjPvLXGaH4pCM4pFfNf/J57LQcLiQxjWm7B1JJOcwHS/7p5GZot?=
 =?us-ascii?Q?DEjVLDGpGsI8K9acj4cHxmVfs61heUCR5P85yBpHWrMQQYqA7gWkUwbUTK92?=
 =?us-ascii?Q?QmX8hho3Rf9rt7uadNbO5Wn523FgTHckXMKwoY4WFXJgLMkqSH3uAG8H0sRw?=
 =?us-ascii?Q?4Ne+xfTwabc6Gc5ffHdwbmhdoLILqdxxV/B7Xpfufe6qpvNJgn4/Jtq2oTHq?=
 =?us-ascii?Q?wXB1HWo8vlyqPEZTJPoZana4L4DmVc2V8v/YuvQhWw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A1vBiW1O5Utw4ZhOP57wGXbUf1Cqo/tD3CeLUK1VmPU6Er1Kj+RZhjBNb54L?=
 =?us-ascii?Q?YdUwtUMqAiXrf2nnt4Ay0c3tTu5RqhXzW2jrW/t/cmNAt7aG+OW636ptRK/b?=
 =?us-ascii?Q?0qlBMJsoCXVwHzk0AZdxfXqY4G9HONoF15jJ4BlMrFqR5fMrQb8JAfLeCiXD?=
 =?us-ascii?Q?04rvuNaQoqJc9q6Pn1Tw079IFjNByJA5Y3TMQsFwlOPOpM1ebVqe3xL5KGwp?=
 =?us-ascii?Q?kGHyvjP/xSA9eiybbI3YCuR+N7+eJpP0VHThObTRI5twljIsvtr5ipEPqtLE?=
 =?us-ascii?Q?FeJ6DBCi7lpvmmhxYfK50O3fRbERVlaVDnI0cHBDE7eJViMz6u1SA9q/JgfD?=
 =?us-ascii?Q?ql1uKOTP0B/TpYL9cMYQ6OffCxRIl6kscaa3FVfMk+a0+HFqVOd0urn8G1XE?=
 =?us-ascii?Q?uqAcN8Inj0d3LLTmsOM55X6Usqw2VIEN0PBcbrVmHs0vEuNsutuJ6wAOmE+R?=
 =?us-ascii?Q?O7yaTtl2yb4K3arf2zbpvJjj46PxA5oVU8qC7PqrR8xeS1/9zKmqkhYCXc7S?=
 =?us-ascii?Q?V3sGTtE88floOqMc+k/w6U9gNjmQQdz0lYObKpu7wjam/xs//wHE4lhRx21W?=
 =?us-ascii?Q?DF83EBSk2L3DXkwxpMoObCpb6AhACUfpR+Kj/TKyGKXoWCD5CYYKHHq6YiCY?=
 =?us-ascii?Q?tjpai6VjjoG5m0M8u7JkkWCdtCcX0q+17jiwJTANFMaNu7fZsWRfJKHK1gdz?=
 =?us-ascii?Q?Rqdo7l8w6A95kOviFWm+K6dT0TszPnkYeSTNodGqGEEb6kR8x21PfeYGz7qz?=
 =?us-ascii?Q?o0LyEaL6X9a+dd5jQvuBu4Aa6knmjTfcA8QRQR65Imx93UgbGxJqmcYkpUDO?=
 =?us-ascii?Q?CKs/8JTzvWJlCFkdVfdDRnGrwQY5MUGIDeuAoXgquNex4+WGZ5bkxBSV2co9?=
 =?us-ascii?Q?AAtg1MfrR0E7a1ZHasl2hw7gr06H9YyJxLA2ino1UfuRAXQcfQeImwUPMz0x?=
 =?us-ascii?Q?ivMYXmOAr7iqALDC9HQWcLligxZjHwZ6IMXqViZQLAQ1Yp4HsVjGR1GCOzad?=
 =?us-ascii?Q?v0PQQRUrzvy8N9NDh9IeE/ZLv1FgtFRM9QT8zNL0iW7UiQ/LASKHR4UfgRBw?=
 =?us-ascii?Q?KoXG4rdCPW02YBgQLll6Jh/4wpw7ET6+03SWR6AdB6afH95A3au4XuIVVXJI?=
 =?us-ascii?Q?80xdcW4pY9M5dPIEsajFut3jq4Z6yEFrSWdMpJemIOi8O1bwuBRFRMUdwunG?=
 =?us-ascii?Q?mtdWlCOEzSoSKhypKTUxWuM8oetqhAjhrJgKmkFahE417ka0iT2hGvaMWg0o?=
 =?us-ascii?Q?ZYULud40QgHW7qdXSFcH2nGnyT0Rra0I4vexh9Tt+6ejlofqHacOfBL+XH3g?=
 =?us-ascii?Q?CWV4WftkeXmP5XeUCC+VhTl7fff20NH3Jkz++BzDg7FgLUwfnSoF+QcekuPk?=
 =?us-ascii?Q?aGloSvLHViiyYJ/1PzTrlByJXJ/+ER5tzPgk4uVZs7Zg2X28cOOZjXptsEL7?=
 =?us-ascii?Q?EyYf6MYF3DiUBWq3p8WE1zQEhA6KqFTrNk8jlIf97SiXLfsrZQW2Zp+RocKi?=
 =?us-ascii?Q?tlDYx1l6zyicRHLeh8pyfX6xZKXXQ2SrGmdzaw0CTJGi/0iU4HZ+SFlbxz7g?=
 =?us-ascii?Q?XtOxbFn6pxgExRjXxyIwUau8OMQPyituowgTh4cN?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MIXjEoRnNw1ojkHGRHncMGs6WXQcTGn8ze2fpfR4OaQuOfQdhY5IerPcN4kHaHzm2aIz6+tUG3rh8aOoAkxUtQJ+uWXnP7l2nru5S6hUgQbR1g3Ib6+uKq1td4EcLHfUBlYUuxTYdOEZdZsNxXzN2Tud6WeZwbSDDywtBSd8iMJu1kvzxhawnLMNtj6Rzedu9Qi/1EA7kMuRHAAqxCRb/DpwuTNZus/T9M7/upZ/zZ0CzpJPkNwTkifIVnybejzE5t/pcCkVh8xafZeQQzN10zI8LNvcj3WZ8rPTVftW2WfV0XVOmn1K9FSTfXYp5Fh5mWlpCzny8yypOeRsK7c9xMqZd8KRgZ4YUt72sPq9jqreSqEkReph323Vl+R4eNUt1zKV9sx3QTaIQP0Nvm42Q3Kwt9/Gsk1e6pxOila/Wgzn8wvBAqyIjpDuXCHc60DHE3itoYzrQDNmnNl3krbXxhqkE5w9FOGN6kWvaf/RdQ4EJ4NhMO6FkT0Mx4wTbpWIsRIIq7VrtVXAebhkMMhGTYYNGn0EqtcpRsQlGQN+m+xWDZ2bjF1SIKPP/zhltnuSU0P6tQZ+w4y0IGEEeh+HAj13naAnHfzbc9tsYOKaUAw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78760ba1-17f0-40ec-3381-08dce954e34a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 17:56:38.1354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7UIyoBB68SQOXlk9OdBeBqh4yKlSjwkiHJf2JPBZje+vVwjDgfxyddVZxouR6PiXT3fyD8ixhhPIl/Y+ap9xWGiOJ15C1NoQUGflUp+PVzQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5941
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_12,2024-10-10_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410100118
X-Proofpoint-GUID: NNk8GtL1lrvmbfyP98RTgzoI2X8M32BC
X-Proofpoint-ORIG-GUID: NNk8GtL1lrvmbfyP98RTgzoI2X8M32BC


Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> On 2024-10-09 09:54:08 [-0700], Ankur Arora wrote:
>> With PREEMPT_RCU=n, cond_resched() provides urgently needed quiescent
>> states for read-side critical sections via rcu_all_qs().
>> One reason why this was needed, was lacking preempt-count, the tick
>> handler has no way of knowing whether it is executing in a read-side
>> critical section or not.
>>
>> With PREEMPT_LAZY=y, there can be configurations with PREEMPT_COUNT=y,
>> PREEMPT_RCU=n, where cond_resched() is a stub that does not provide
>> quiescent states via rcu_all_qs().
>
> PREEMPT_LAZY selects PREEMPT_BUILD which selects PREEMPTION which in
> turn selects PREEMPT_RCU. So this is not a valid combination. Do you
> have a different tree than I do? Because maybe I am missing something.

The second patch in the series?

>> So, use the availability of preempt_count() to report quiescent states
>> in rcu_flavor_sched_clock_irq().
>>
>> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> ---
>>  kernel/rcu/tree_plugin.h | 11 +++++++----
>>  1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
>> index 1c7cbd145d5e..da324d66034b 100644
>> --- a/kernel/rcu/tree_plugin.h
>> +++ b/kernel/rcu/tree_plugin.h
>> @@ -974,13 +974,16 @@ static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp)
>>   */
>>  static void rcu_flavor_sched_clock_irq(int user)
>>  {
>> -	if (user || rcu_is_cpu_rrupt_from_idle()) {
>> +	if (user || rcu_is_cpu_rrupt_from_idle() ||
>> +	     (IS_ENABLED(CONFIG_PREEMPT_COUNT) &&
>> +	      !(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK)))) {
>
> couldn't you use a helper preemptible()?

Alas no. This check isn't trying to establish preemptibility (this is
called in irq context so we already know that we aren't preemptible.)
The check is using the preempt count to see if it can infer the state
of RCU read side critical section on this CPU.

>>  		/*
>>  		 * Get here if this CPU took its interrupt from user
>> -		 * mode or from the idle loop, and if this is not a
>> -		 * nested interrupt.  In this case, the CPU is in
>> -		 * a quiescent state, so note it.
>> +		 * mode, from the idle loop without this being a nested
>> +		 * interrupt, or while not holding a preempt count (but
>> +		 * with PREEMPT_COUNT=y. In this case, the CPU is in a
>> +		 * quiescent state, so note it.
>>  		 *
>>  		 * No memory barrier is required here because rcu_qs()
>>  		 * references only CPU-local variables that other CPUs
>
> Sebastian


--
ankur

