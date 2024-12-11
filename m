Return-Path: <linux-kernel+bounces-441167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 585D29ECA88
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 11:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A81A1888A98
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F8C239BCC;
	Wed, 11 Dec 2024 10:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UowCYq3o";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dPrB3uPO"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD268239BA8
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 10:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733913919; cv=fail; b=cr7wmVnBMx3RIiPkNcjANZIvjwSfy38w4KnZWZdySsRqxVI/HIHtnZwliqG+PiF1PUwlHrsemRG6xXrrL8UJNuI0gUDPOGfJsGPx/g/Uua3lE1ZnPOCYSAGQtiPPtPBbraHPPuLA8FLF2+7UV06yg1hpgpDqBCZmjZeqrkzADa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733913919; c=relaxed/simple;
	bh=K4+5nagglAxb/LVpiHk+O1jECA7hEaAtTwvmB02VvIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VfYgzAtLTsmkZdXTFNigSJ/D8/pl3sCl43YtJBKNU8/FHnD2p8TSih6Aa0WnF2sHwLpTo/tQI3+kiFbBfcRZAxjf3PqAVFNDMOgBMr5Hr51whv1jOJ16h35xNpNA/BETL1XKq1C2gPaTu3FpWJkW3IR8xpog0th8YiEX/Yuqr9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UowCYq3o; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dPrB3uPO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BB8RLo5016795;
	Wed, 11 Dec 2024 10:45:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=wldtXuWw6fKq5+OZ7P
	99gchPQHZSwPcVcjxLK6Fvf1U=; b=UowCYq3ogtNGn14kUayJCPUUKCArHMot42
	YhO0qHqqn/urfrQELh1YyijKWW6MwcJJ5Aw3kOg4VgIU+PFDbtmLEeNM20dNQczz
	WXFS/Ngkg71f6myglTMt4sHMVGopPXi8icyGlh07szPncmTerUvnA7UlM1xZTBDc
	xhI4xQdfkkYx2s15cP9gs0n4Qy+MJHfTTOUnIkYYaImeKHZEBsnJRnOtVJpBup5E
	gzAgDA4zflZc0RyJykSucpghswh9NRXMQlt9Sdbp3mJxZ3TqG2y+G4RE6W5MXaUZ
	oUQLGZcuCocOnJbonvrNE2gee7hDguIA8ceNE4/sDV/g3ZjB370A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43ddr66ask-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Dec 2024 10:45:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BB9HsFL008680;
	Wed, 11 Dec 2024 10:45:05 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cct9k60x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Dec 2024 10:45:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KFLO866II1EsT5Dw0bb+IYZcfdNjvx4MF1DxpRHyPZQ9TD7Z4AtTAjO2O6HF70tf+roDR9idiqrercWy27w0GcJdix6BHYDVqn9D8eYR/yz17P7BY6ptOgIi9DyJifGXda80VfjV1qywKNcuAUcOmnHWJkzssOZPA4B2PsTz/FNr4TBxFh5xlW/sEslyOeKNlFXP4cBrdILZyW6+WYX6P/6px186gcbOc1GglxiwkLozEvAEi/1Ldrv9vBubmk9TSAygycj/G0Wto5QNPr8axS8ROdY0OKYOp2gbhVWPVev90fLhH902GNQPSmVZTlX0Enf/CGhS7vug1SBt2xcuJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wldtXuWw6fKq5+OZ7P99gchPQHZSwPcVcjxLK6Fvf1U=;
 b=w6YlOmkWfSxO8lswJ4cz+bra2iwNywpH6ehZoBh78/sN2RstUREsW8wr5Svj7+DxLV9jFjnZ57eHNNQI7ze14cF3Lu8y+Wky1kN4m+NiaiO1I5SknJePKCmpqc6xcXPKWmaXyLpNNuWE1iuOjW+TwViMdr6iPq864c2oa9yezlNIm7W7qU+PwAZWfpqhamOmCcbmLWp1EIsRKoucSnqgFHn+G8HnfocwAazUG/75e7WNXQs30pSNzo/yaZBukwn9FXqcdb1w4Z8NTosWa7psV2npeQTRg3VVAhOWDvnUZRvJhXxxLJjyIizRcCem6Hd2NfBGeUy4ysJBVBwfo0JVrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wldtXuWw6fKq5+OZ7P99gchPQHZSwPcVcjxLK6Fvf1U=;
 b=dPrB3uPOHSF6SsnUQKRI4Js/blulh0jZ/fhkzqCNXvR4UK0G8gwkQAFzty/CT6htM2ja+RCiBqceUhoI/xbCaIZRQHC4I2u3AjZgzRbanl1PXPXFWWyVlIx9NQFu/Dm2F9roMU8r8b1DeMi/oefv6d+AmIK7HUHgG8aEQeKNmys=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CY8PR10MB6537.namprd10.prod.outlook.com (2603:10b6:930:5b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Wed, 11 Dec
 2024 10:45:01 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 10:44:59 +0000
Date: Wed, 11 Dec 2024 10:44:56 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: group all VMA-related files into the VMA
 section
Message-ID: <e74f5696-7a95-4e93-b11c-c70079a6dd7f@lucifer.local>
References: <71beb3d1-21ac-4037-8363-6484c0c333b8@lucifer.local>
 <CAG48ez2s2mY83uce9mGUgc61_50nOp9VPJKLHMtyRYTTeKpo=A@mail.gmail.com>
 <81fc4cd1-55f4-4569-aef7-0b0da9684fdf@lucifer.local>
 <af887f35-0831-4c7d-9f1d-bc857b52975b@redhat.com>
 <67ae2a5f-0c86-446f-a122-f14decdb84d3@lucifer.local>
 <a3cacdde-8dab-4dcb-a720-9e00833ee9c1@redhat.com>
 <dfe6b339-a742-4adc-9a53-c653510428d8@lucifer.local>
 <50e194c2-914d-43eb-bff8-47c4a1119dce@redhat.com>
 <bd0ebc49-e5ce-4cb2-a7a1-14e864c5888e@lucifer.local>
 <ba149c5b-e213-4047-b660-f44b1c8643b4@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba149c5b-e213-4047-b660-f44b1c8643b4@redhat.com>
X-ClientProxiedBy: LO4P123CA0040.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::9) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CY8PR10MB6537:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a288914-be3a-4805-0cce-08dd19d0dc52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?brZHMhRAYAbUkZmJctnUwbq98VPPoL27WIOv5+5NKi+8R+TCxv04Tk/SEbE+?=
 =?us-ascii?Q?jeZirzddBP3eFv/BjL/1JOB4OnqoUq+7gajmjvyZhrBLN9El/wz0rbc/9Zgb?=
 =?us-ascii?Q?Vz6gA+XIMlfVv1iLQ4GZP15kJ2sBsL6nzs4cRUF57Edktdyq6q60da0KL3qV?=
 =?us-ascii?Q?wB7k7HkdqnBGnXFELJpTsjaw5LBVIRXH9S/Vbae5OcdxBOeWITbpWaGY1nyQ?=
 =?us-ascii?Q?IXM0dKAktbUdQfUMJfpdQVRyWYEqWq2iNuSV26AINiLprQO8cp1gaaY/MEQV?=
 =?us-ascii?Q?PToCbOnlmFjh/inTuiFMcOHl+V/21UGBqgby9ZJUJjdKTyjRz8XqA/3/D2Fi?=
 =?us-ascii?Q?QDtonSj1mD2ibIIdeBHkwQFdlmQcALiDubnY5+WbccdOWXF/7O4rCPT/wN24?=
 =?us-ascii?Q?GraDuyJUTZoGL/yJkufnEgmllzUlomgENNj+fLqG6I3wdRrCyi9CnW6X/JEQ?=
 =?us-ascii?Q?7FDkqRw+6Xj0BcTkCqJk3qQWalOKxrCmo9lABEapZ/5UKn/huJ+IQIXWcgi8?=
 =?us-ascii?Q?q9KoBks2mpftUj0EgR12+t413jXmi2OFld7PCz1iXfGz9nbEJYji6x1efVqh?=
 =?us-ascii?Q?hFHXyC48YTV4XQOXyrHYmEasKSv+nZs8z6X/POWdpEbaPzSNpsW0ARe21SBg?=
 =?us-ascii?Q?+e8564D0cPyDJGad7MAV66D0vVAWIkkqu/VxNV2etoZeRAhHAVgWWomfMPG4?=
 =?us-ascii?Q?2IPtKoxDhuTan7z0np2cjpXVCcTeTnZDK3tjXPLz8DNHQm6qUknLPIfKg+YW?=
 =?us-ascii?Q?3UasKNAl5O1NWiig2dnqYF8vrkq/umhf6vqIRv5jJ2vQHANl3RXqhjnSiDxQ?=
 =?us-ascii?Q?hoS9qVFFVnYNsyrFCpEYHWk/ep8UgB2yeAB30NcV6HggPtlH2J3RUbUXfbrc?=
 =?us-ascii?Q?HrZlX3ei9JfrUn8R6K76bcQH9EKX3E78qziQUlJZYRWdcwwhVkWUCrYAdDA2?=
 =?us-ascii?Q?dszv6Rtx//FNI1U9NqaLmxc/kE/VSEA2RR2pVNvx/Ueb9l43P1uqt00ZBbic?=
 =?us-ascii?Q?z9xnRSstQFu1i/4uT6qpncnPGyZloSdj6EUjJr3LAFMundqMMPfqGrlEj0xR?=
 =?us-ascii?Q?KhhMoyM6hvRnpr9EP++9pBqc9MJK5KY5sxFf36mh0YMsWGms693w089HPJNi?=
 =?us-ascii?Q?4S7qlIZPJZAjAyUgWQB1a4UL33PgSBOLTSmg5nUjLMNfGSfBI9eqtdzeEzsy?=
 =?us-ascii?Q?61QYmRES8XBcjc8Y+21FMYyd2F279OGAGqqXbAX4rhyltLIo8C+B91lMWTz9?=
 =?us-ascii?Q?bxYqBxXFT+AGRhMdXqz8QnkiMR+JolJp2qTy2/EEc5bc54f9QdRtKBcbDW0R?=
 =?us-ascii?Q?4Lbq8jqfZPT7sLgPa3sifvBGPunHAoPGYaIw83tIWAk5iw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CA4pPLRNSP3YfjqWZWDd8+C3/ZoXDeFadYiQtxSTq4cWQrC1Vu8kQYl7ds7S?=
 =?us-ascii?Q?IKZbYPtNo5bBEiY1hEOY+cDgOJUp/FPAPlzpOQ6N3SLfd1U6HZ+3mpKQ3aun?=
 =?us-ascii?Q?RK999FgOSzleSGsumDatUlpARUulGEWWknsVcUmoUjLCuMxdzQYKCnCrXyNH?=
 =?us-ascii?Q?YePj0rXAgIOZRsnWAAOHBiK+pO7VoRPGfKhxlKUvsmWeSghnyve3hX5NcKfV?=
 =?us-ascii?Q?FbDOPt4Yrau/X9CS4Ah4c/3zr7TiJ8Zzz8RS4i3M09BtZ/FTNKvPzNt0TpEW?=
 =?us-ascii?Q?7Z7TwAg+jCTdqH8Qx+2WIjb5rH71M8Sb70dFSnNeVly1sSa6ZDgWtIeNmslq?=
 =?us-ascii?Q?9ftsrYAarzLfzPjAB4FsekFecv4fe2QTakElSGzlA/+srNUyWUMtCgS4uEWk?=
 =?us-ascii?Q?RpvFZYHr1yw+weIxTWML+NIt601Oa5mGSdsCj9Q57/+ZBF3NxNfZo1nRb63+?=
 =?us-ascii?Q?wgkz6e9UXQO52k/MyD87JchoWBi/GEE9VXckDJNH/IKMMTLPiRGfO1zKmcWs?=
 =?us-ascii?Q?Gv3PQGnDsZdcyo5BcXx8LXUxlR9jRiUzI5adUXfkFHqADb/ULmPs5bxnu0k8?=
 =?us-ascii?Q?bgyEBEGvLaT+wjsgLM3fR7FQs99/wTdk5UPPtf9nwWKZWoqXdpQ0BTRFxrS5?=
 =?us-ascii?Q?TtuGuRCnC1jyYNKbekCC03PxlV8bGB0NrssgCVpjKdJfy8IrAt+UvSH+L+HO?=
 =?us-ascii?Q?ZPtJNHrYC99MUiyR29OvG3jUMGA3lxgDbILOd4U/ZZsqOfa/JriZMOuAsCYO?=
 =?us-ascii?Q?rHhxyRLfgJ7gOskirpFhWYU6K7cSZxZH22jaAsbup/XmRRiJAgOPSY7JnVfg?=
 =?us-ascii?Q?bSUS9IvQuBUXkJPOdL5KTO3uEtNSVTICVFlofPVqZW5Q1Oskg2JTxHW4PlyA?=
 =?us-ascii?Q?snfFM9Coie4e2M2eLkQszdt2+hXaLN6cPNEpjNgqv+vQQYMdLIlrRkEMWfdr?=
 =?us-ascii?Q?r4JODnWMoXfMVg7sSERwjXcnNPn/AborCEjheD/U4OXyghKNl2tGcSnnvSDY?=
 =?us-ascii?Q?0wRAEd0WejF56cS/GwtRZK9WilTrx/V2pjwZHcMTA45m2fHOuiweuYJuvtGY?=
 =?us-ascii?Q?78miWDwYVF2TWqLQv+wJeebZkUIQg46d/3qg2rNmZixLrFvKp65J5us59nQG?=
 =?us-ascii?Q?AZBbhsEjlK5ZqwTYYdAp5yw4AkfgRmMKouk1AhKNPWsGmr3CLUORJNm5LrPS?=
 =?us-ascii?Q?+UsHYsRZ5URvyXT2Uiw5xr9hb5O8DYx41nKoMuHLSe79lyR0ONmof6JCn72I?=
 =?us-ascii?Q?wXhGyPWLhmWUT8JsIIcVMCe3+IalczWVoHNZRi4SfT1UIb0v/C4dm3AlM6Jy?=
 =?us-ascii?Q?g1g6V9HGxotGUbCBb2uMXNHa4udrzlSKpxOcOFMzqECdMst0XujsRLlr9X2D?=
 =?us-ascii?Q?EyDy6fQpi1D/alhFB2cZou/MWdP4jaA9Jjtdcictgv0rCrcoBIcSzeBHIORm?=
 =?us-ascii?Q?NNRGL/ovqdvH4Hofp1uQP+UU6seFm+jYEGvKeD5I8HHBIZhFnPi6KfMf+nGg?=
 =?us-ascii?Q?nxrX5oPtGbfbhRIT58ZKFFrjYHi+GJt5JSSHkC38eN57e10EIDmFgW36aLC8?=
 =?us-ascii?Q?EQ8MjhEPV9MUmMZeK4CR/XPoFVpgr8e/vOClx1AgPvXcXYj68kDAx/sbZMcL?=
 =?us-ascii?Q?sA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	k9C4Zvur/KpqlYSmVzPLeVPooZVAWVQzoryy77jyiuV5JnxYMnB/FzqU1GkIF1/e2BCGhcnHL2WXYDmsg0mWQyo2NvjeOuPf1zYLg+VR/fJBhC8fCPF15ysS8Qh6xrbHJi9RVAmqxTMWK5LbE7Y65CosgbcZQxmmbECKx+9GQbohoJ8k0rZmoxD81lfhpHD3VcILg6KwgireHNp+vcte0sc2SMEIMRjcPiRH2SntF0FlnC/zLUTBCi1GKpLOQR4ALinbtbaVcOA/vZjbKvUTaRxn6KFB2APaRxsnRHu6fMDHyeWQcDfk5RF1VJL4upWUSC84h/gR4rN+DOYblO0KDCbongevb/uN4T+WQVqULqVHzNdHjr/A6Mel0ppVAk5+w2i/zjREbovJJSIzzV2lPrVpPvNTIzLIhOrPFtY+z3X4krbxV9KDbr7GQs9LFNDUxSLyqzC0XvotPnIhl2k+pWSGSpXgl1TThfb0xpTyIRMTaCP90k+9Tmp5+LEEgWxJh4ndbohOO9rKo5u0wA6uAfhTExEkfJTkzf3Xgq6nMg4q5cRqV6VhP7mVCwk2BfTB0I636vMTW7WeMKuw4KxXnI/6+u/aylCKskMR3TeSjv0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a288914-be3a-4805-0cce-08dd19d0dc52
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 10:44:59.7834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: njZn+fR/eL6kwDnRuv0os0w2GpNsZMf8jcIkx4Tk+W9hmJW02h7eGA/3GOMGeLHYkQ+6g26xFF04pTrm20p5xHQ3Wo9ZX0gSNyEDmF5qySs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6537
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-11_10,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412110081
X-Proofpoint-GUID: gbSTPSqxaVLyYLY0E4j0j5jbWnapf1n8
X-Proofpoint-ORIG-GUID: gbSTPSqxaVLyYLY0E4j0j5jbWnapf1n8

On Wed, Dec 11, 2024 at 11:27:39AM +0100, David Hildenbrand wrote:
> > >
> >
> > OK so I think we're (probably?) now agreed, I will submit a patch shortly
> > that:
> >
> > a. puts everything in MEMORY MAPPING
> > b. Drops mm/madvise.c, mm/msync.c from the list
> > c. I commit to moving things out of the various files that truly belongs
> >     elsewhere
> > > I mean there's stuff that's weirdly used for page table moving in
> mremap.c
> > that should probably live in memory.c as well for instance.
>
> Yes, and hopefully we can clearly frame what MEMORY MAPPING is supposed to
> contain. I tried to tackle it with "/proc/self/maps output", but that's
> probably not the complete story.

I think any definition will end up a little fuzzy. For me it's anything
relating to mapping memory and changing its attributes.

I quite like the 'anything that affects /proc/self/maps output' but of
course you can find exceptions to all these rules...

I think we just have to live with a bit of vagueness unfortunately.

But we can definitely do future work on moving things around to make this
clearer. I think there's more benefit to moving stuff around than some
strict adherence to a sense of X belongs in file y etc., because it also
encourages de-duplication and prevents unrelated logic sitting in a file
where it might be neglected.

Anyway one for the new year :)

>
> For example, maybe mbind() should, for example, at some point be separated
> out into into mbind.c (making use of mempolicy.c functionality?) and covered
> there as well? I really don't know, maybe it's not one of the
> mmap/munmap/mprotect/mremap/mseal/mlock gang after all.

I sort of feel it's ok to have that in mempolicy.c with other NUMA related
syscalls, it's still grouped by syscall pretty much there.

We do have weirdness with random things that don't seem to belong sitting
in random files though, vma_migratable() being there is weird for instance.

Anyway, one thing at a time :)

>
> --
> Cheers,
>
> David / dhildenb
>

