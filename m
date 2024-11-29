Return-Path: <linux-kernel+bounces-425427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF659DC1E7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 11:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B312A1632D2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 10:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3144417A58C;
	Fri, 29 Nov 2024 10:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ww+U3jRE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SNXlm4sU"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E61714C5B0
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 10:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732874662; cv=fail; b=IZ1qF8QpbTul0Kc2tHIK/1lAWKngguOLEPUY9xwd2bZu3Kzp5sffvTMLz1k3yIeV9SdGj1ijewQikjNV5HEqhnnHOKmhV3m2d/q6Tk2QXn53pV3FQR64LT4c0NZyAOCYtRScZghexcP9R2O3najuDu8mt9szLFNuDpyZ5rHHcGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732874662; c=relaxed/simple;
	bh=JOQ0DSpabjzS34EFDqAptnUYF5/Crw5hpg+CGpA0nW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nn9UnKyu60Obvne/EqPhesnTE+50JSWxH8cZbtfzFkoGEQrlRw3V8BiMV5V856TBxwMrGNsV1IPHFHi5usZTnxFFzlVnWEso4w7X/6i4Sn58T0jgsZPPwCBhrOVdu9hcXHqHOWy5VhBUCL9cwHnoAsHNaDwfGucTnWd6dgumMNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ww+U3jRE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SNXlm4sU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AT1fqAM013712;
	Fri, 29 Nov 2024 10:04:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=Q9AmNX0Sxb23/bWWaw
	mKRSNeiTxoY5KnjLSmOim/lmw=; b=Ww+U3jREbslgMReZZPOpteKz4TrB0B86dF
	H2vvvsMBC2NutmGY71y0CW983OAEQQXlF6zocdJ+wum4qzEu1C8+9isxHY+SRP6U
	4vRCQ1V6RxzMqfHEzzzWAcUq9jlLQd+olk89sj4fb05Cp+dfWs+v4X3I5yh31s6O
	mQ6Nyn+Pbrq3TJZZFZ1zMcxAyAH2prUC9V4R93MGxEypN8Moac6/IPiZalUV0xHe
	2L1/k+DItNbXUHUSXFmyCs7xu88hOiHx5yslBpHF2Jcjb1RK1ecDmGQvfjmWO1sM
	oj/f0RIsu3BP1NHMnze0UoRd/7OF4faBPKSi2uGMicp+CcvP//Lw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4366xxb2ga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Nov 2024 10:04:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AT8rKmO027508;
	Fri, 29 Nov 2024 10:04:01 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4367050pbh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Nov 2024 10:04:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YgxoAhVT1FY4FbE0HuZyWYnjqyjiZBs1fwmgAzGjeujDP3OpWMcTVnmFjnkYB+10E8ZkRFuMy6bTnP0SCPFse3DeGLrWR8/s/eDZhSZGDrWnUYcSA420rFzafnVNHRst8XPNsJ/SQ1hg78/JMBCF4SXK/4Nv3QySJAhvod2A6Ff52fQSgXTjuxwSGw60t6B3VkNGh6C9f4rrc42o5gTnxu+PBdieI+lZDrAb17DmkdFbPofv+THv2l6D24g73UrTKgiaMpNAerrSoyM9VzhnKAAGnhmI+VvW1J+AtbpgzJ0L+B74mVwvDLSPwJ0Z4GQRNEHfCMGdMCmGDMMByB1w0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9AmNX0Sxb23/bWWawmKRSNeiTxoY5KnjLSmOim/lmw=;
 b=s6UcfdFrw94MD9E/nL+bIzqmbVu1a68jeUl/6BFrU0STyiz8YiASw5XUdF/gyqR75j70Zb0USL89QBE/h3GAEFgf4CEnAlc4B1/YIzVVyHfk5/x18g8J7FD55ohw+LUUMHDg5SjB4/cprI8H+OhHTdcN2xarl5GE1Wl0uFXR+5HGhUFfGblbxz1oYBYjyPbxJ7cLkA1fbixNlFToVO2ZzbE5QyQ707cr73KwLcJimVQ5aD8ZOxTLjjSXcQb8ajZ/SXbXIlY97tQAJjiLV+WRa3a7keYdbhVJhMPwaZ3DflVGeVRSTEi9/1f4dHjMBEYOagbcOvXaXroDxZHZdee2mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9AmNX0Sxb23/bWWawmKRSNeiTxoY5KnjLSmOim/lmw=;
 b=SNXlm4sUcoa8unINf+K31oVpqgnb0GzQasnR+QX72UDdHXOa5cbPA9Ktw3mk0ErEWcFsu5uEp2zYkIvKJ0MqgLPLOj2CTqYk1ylzQypS5tE5OjlLmueQ3j1ax6vFrB5vPCpCpp1SYdxGzIf5aMPnw3XGMkDN34a7/RlumDA4pyg=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by MN6PR10MB7517.namprd10.prod.outlook.com (2603:10b6:208:47d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Fri, 29 Nov
 2024 10:03:54 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8207.010; Fri, 29 Nov 2024
 10:03:54 +0000
Date: Fri, 29 Nov 2024 10:03:51 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Shuah Khan <shuah@kernel.org>, Julian Orth <ju.orth@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] mm: reinstate ability to map write-sealed memfd
 mappings read-only
Message-ID: <0b1bec54-e45e-408a-a770-3d5bf2cde101@lucifer.local>
References: <cover.1732804776.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1732804776.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO4P265CA0167.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::12) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|MN6PR10MB7517:EE_
X-MS-Office365-Filtering-Correlation-Id: 36b2d620-5422-4889-9f6d-08dd105d21ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OlMulqMqK8IFj1qzs4QwPrOzt4IeGjBoS3OglyhAmqhjoSDvStAjXOaRwfaA?=
 =?us-ascii?Q?KfQrwUtkklCKN3MHoXCNoXJhweKFLPD+gBilNz74a5gUqcm9HeOtfGsehEWJ?=
 =?us-ascii?Q?x4ts0Z4ONl0bHWrCGCUVXgiNnhqI0N5F7ZXmZdpdZ/IRdbnQxO3FsqKgPMg7?=
 =?us-ascii?Q?YMg40dZ2J1b4kiurjTygNcbVrdBXC+e0cpNXj0UnDXYF04iXaILyoOlQyrNr?=
 =?us-ascii?Q?avOqUJC+ImsZMS0ZDzZxz40txV5X/Nvc2q+vmOQM4UT1gyzsP5NaJ103f6iq?=
 =?us-ascii?Q?VBnRL7pXZXo3fWEmNMBJcs9Un04wK470XbefFrTUg+kt2jBem7ohNtbBSq43?=
 =?us-ascii?Q?jWgWSWce8Gk7CaXGko1/HNxEqAhfWJlhlOrF7hlovqnbqYyUxIflB7EfX6H6?=
 =?us-ascii?Q?wibmgOYsYrsKfoCFWj5Cc865Bd2z/ye9bn00Ws4m1M0gaDWwuNug4btcQpbt?=
 =?us-ascii?Q?p4RxL+ZAkfHWN2yVLG2Ua8050f+AUdy2a88TVHr5FZATI8+yvlvpR2Oh7hk7?=
 =?us-ascii?Q?fzgyfbcSh6xbYXBi3xdleaqJ6umOZ9nrc8PIApcr2YphvpCyGYKE/VemTZlY?=
 =?us-ascii?Q?wMCp0AURv8VaFUDeIpO4e+n1cx4Mp9aHEbNNSv9QQOl5ni2KWt+fXCPJFrAP?=
 =?us-ascii?Q?t6SdYobdCZZHiK7Cxx2Tvo7V5Q279gxmAF2HpJmY7UlXRIde6887Vw46Njh6?=
 =?us-ascii?Q?3MCABxtnGKWMFTdj4fMNiIz8aE/ymfwhRm7BPWxDHuHeQYvf0Oj9+pLieNMO?=
 =?us-ascii?Q?buZ0a9vsOTLyvw7JAkyuvby92e4cZjVwGfFEPP+iBFdC20otJPWdnymza015?=
 =?us-ascii?Q?yu4X6H5mp0btL3zNjxuwBOhP7LmZaqSpl29Bcz6rf4sThWCJUPFK1j/vCwim?=
 =?us-ascii?Q?MvVj1nLa4+PUeZ8IzIxcnqznQkbgnvBF1RWBigguUkNC4ZCXFSlgSN5MrFAW?=
 =?us-ascii?Q?OU3C1MxTK2nv7HB0ETU/0CN06PNFqHM+hXQFfDBQT5xaVRa+8fhfPcjtiyyv?=
 =?us-ascii?Q?bzFYrnAtUj0669RHpw6vBmWZsPZf/nKOdGakj43NZVBwzqVW5bhfa7R8DpYm?=
 =?us-ascii?Q?N5jOIspnTdAyo86/t3l27ADnnIRUcDU05VhEpsHnuf4L8Zp5A9j7/llZP+YQ?=
 =?us-ascii?Q?NYLl+uHESLAzUde0FRZyglGF+2Be0HS4+OMjwPR/z4mFu8rUAZlIXPgyb984?=
 =?us-ascii?Q?y7BwCKIf1h6VstmZZ9wwah4NK68en6FhBKQmo8dXomihdsCL6nf3F/3xOO7+?=
 =?us-ascii?Q?uieVLsQUvnBlGhBT5CO59XysO6qYMOkJgUNxySSQIEaE8VHqmv11FUi75jiZ?=
 =?us-ascii?Q?yeP/5hWVoOvfEPBo7pqK8wv2nygxVh7wLat5gmvc9L5TMA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Eu+iXcluX54Fz13MM1fn/S08FBjfWds/lnY1+PZen0sBFo5+940hv1CmYy99?=
 =?us-ascii?Q?MmkTzglgDWo6EsVNhferOP6pZn2uQTumpuXhG/RaHVGnIOpYlKprfnCUWyii?=
 =?us-ascii?Q?fa3vjiNlVVlojoRcEjgI8H31kP/r4RTitFVbanjxxlEBU0xKTWzdhfSS1dyz?=
 =?us-ascii?Q?bjTx6j3R+2a+brNNcu5IdbNGsbhXGdJa7Kwpg1LTTfyM4tzEZSgvhfg/FBD3?=
 =?us-ascii?Q?ToM8I+RpnT77/W9lIgqtqHJgAA72aZJnNjxxx9jSFG/5BXGgCCIP42XkLoHw?=
 =?us-ascii?Q?122y1edHbyTW380xR3vsOe4hSQgCDzsSUfYXqp1jNHlUNH81mVxG48LCfo5f?=
 =?us-ascii?Q?jQnHPRrijdwJjvUlHtwfAy3NEDsWSdP8S57aN3l9vkGJD5BuRAbJNqQkYSTa?=
 =?us-ascii?Q?aFfVwRNgS4uj2pxVIR11fZXSu7iWtUaEymhJjs36piob22PYHHz5HMz/0SJI?=
 =?us-ascii?Q?lEWjRtFLREF0N78CzrwQw8ND1R020EU6hdsn7//TJf4G1lnkJ/F3IcSnyCdZ?=
 =?us-ascii?Q?Z6SeY2i/SCAvMFvL3Y1OKnFAEhGPw0U5EZoysP4Yq1vixMYDJBzGHYF7wyNe?=
 =?us-ascii?Q?cvzx66+B8UgVc2aV1PwvFhj0BgHfzYb4DXs/ksfM/iSaob2z/zuGolCY3l8Q?=
 =?us-ascii?Q?5X6J1fnaqA8+TwCjMrjPFZF0S1eylFfq21uFafzyZHHON39Xc3Yh7YEcVPhF?=
 =?us-ascii?Q?Vhv1Yf4zrHJrBcY6VNXhVkfMCQpgYwJNjGxLhJxYD9QE38DNW3R6ydUqp2W+?=
 =?us-ascii?Q?4+pG2xGtvN8mWg5xVINi7FAvBiKDX5XgQ5yMq8bD3feUENBSlvE+GcK34Fia?=
 =?us-ascii?Q?lN1VzMenyNNVN7U1zlpQ1HGCpM/9BdGInzKz8dreuCHIXjoZkbWPOE498Ggv?=
 =?us-ascii?Q?R7zfzgLFd7lUcJMZj1J27T/hFYgMm1l6pGYR0WQFLrMMsptSeww7j7NVXbnd?=
 =?us-ascii?Q?ZaeYxTe9kvzSK+MwKS6NjI1LRUQM0QSyfs80+7iE1oXm1s7jJryz62Il6oXY?=
 =?us-ascii?Q?7a5f/Pfzp4v8Jm/7ZX5pY766g+jw+hLnxdMJx6Km5M5w6Hw0YOZGFhODBgiD?=
 =?us-ascii?Q?iNXRrSPHGt9wi5hM+z4m/Hm4pJ7rA+0zD0RVnfU/FaQfRyw575AIX1JL/6Cy?=
 =?us-ascii?Q?2hnMDcMhuUlq1gJOPapehUSm4bf/naNWnSmzGOBrziD/S/J0w7O5nNJiJbWs?=
 =?us-ascii?Q?YO/K/N0k60AbrcpLgD2IQFZiPrHavXjKw3TRavSy9YTo48Q/0pQTiroTbS6p?=
 =?us-ascii?Q?wiTpzYY28kTyPo9PIF75ep5w2DpKzLxNHilq/XsZlh8w6nBPFXfvs0U26wNh?=
 =?us-ascii?Q?h5VWgF6DWztJc7jMRhm2XhBWn9c+cQzqpGp29cxvPO4JZhGMgftfe73e31Fm?=
 =?us-ascii?Q?+ldsEE2UR2eButhIdjTj+MF9DmyPv983xfkaUQuOjrADww39bAEnzCfsUZR0?=
 =?us-ascii?Q?jKQT5Ic/lHSXGC8tq84cdkPdpOsCuUUZbSzFonad7i1UE05j+zvFbVp6g92U?=
 =?us-ascii?Q?jDBhSheOeSsiLdZmaH+HO1Sw+3b5znLvSq3xl1E8jrRtxteEMH5DBrYxaX2z?=
 =?us-ascii?Q?DULMTYEv+oEDyJkBXOVuTGBfNePwJMURTwmfqSd9JGOqxSsROwtqaKus9RN4?=
 =?us-ascii?Q?ag=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jTSjYldqK59faVIApTekOMIJ/O1T5WtShcOf4f97COPVFPsyOBYd2Cleny2+rGAIYB5j5yJDh34zDSE5qWMzUhU3xuxz+NkC68pJSf2IdW1u7LZ0WR8osKs16ILTJ7C9MUb+LIUcx4SpVulLgqihLWfOzASaVtFzZby240U6eeEUxIHwTwzFqn9VBtsERc7R93J66YscV/1a/Bfg/yw54eh/E5NCFoOZ/1v0uAyv56yapNSPYSP8esvgo/f46tj+uwdFY4ZZy9qU93TulzsPa/Y5ze13xbeBNt2eWUED0JoGzGRt1kx1q/rcRp5e/koG+HiZGDvdh0vrXIv/HiBSRoD5uoCS4r//pSkYvAkiJQrgnKFfMMst03czhr4NLoayrWHi4DeQpNEQj8Pel5/9U7iPOqH9fcqYXyDkewpZhyGINxL4L3crv4rVi/m1yOrFALs24KWJYmFW4+RlDjEI62TV/eT4DjBTt3c4MlvzzJcF3Ho2TaoUIJR+uXH5FrKYy3JuaTTBPOb1tg3u98VOdvjX+4dbNMcI93uXD9I2xjKL8HJJpRCF1aGs0dfmwFXmsp01YBFqdOmd71xvDidz5t+IDxPJj5ZbnK7tZcVKj2w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36b2d620-5422-4889-9f6d-08dd105d21ca
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 10:03:54.2593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BkG6Oqbb+hX7VSL+KO6owMN05T408DaPKqn0gkmwfvoS2L1e0jIhlaclLsxZCmmKnYKUVvN4IQHyhLsbxeLMbMfpa6xZtJGY/THGcGL6nE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7517
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-29_09,2024-11-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 spamscore=0 bulkscore=0
 mlxlogscore=866 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2411290082
X-Proofpoint-GUID: TMn_ubWsZygOh3NbY11brSEPlhMWmSfm
X-Proofpoint-ORIG-GUID: TMn_ubWsZygOh3NbY11brSEPlhMWmSfm

Andrew - This is a hotfix for 6.13, sorry forgot to tag the series as such :)

Thanks!

On Thu, Nov 28, 2024 at 03:06:16PM +0000, Lorenzo Stoakes wrote:
> In commit 158978945f31 ("mm: perform the mapping_map_writable() check after
> call_mmap()") (and preceding changes in the same series) it became possible
> to mmap() F_SEAL_WRITE sealed memfd mappings read-only.
>
> Commit 5de195060b2e ("mm: resolve faulty mmap_region() error path
> behaviour") unintentionally undid this logic by moving the
> mapping_map_writable() check before the shmem_mmap() hook is invoked,
> thereby regressing this change.
>
> This series reworks how we both permit write-sealed mappings being mapped
> read-only and disallow mprotect() from undoing the write-seal, fixing this
> regression.
>
> We also add a regression test to ensure that we do not accidentally regress
> this in future.
>
> Thanks to Julian Orth for reporting this regression.
>
> Note that this will require stable backports to 6.6.y and 6.12.y, I will
> send these manually when this lands upstream.
>
> Lorenzo Stoakes (2):
>   mm: reinstate ability to map write-sealed memfd mappings read-only
>   selftests/memfd: add test for mapping write-sealed memfd read-only
>
>  include/linux/memfd.h                      | 14 ++++++
>  include/linux/mm.h                         | 58 +++++++++++++++-------
>  mm/memfd.c                                 |  2 +-
>  mm/mmap.c                                  |  4 ++
>  tools/testing/selftests/memfd/memfd_test.c | 43 ++++++++++++++++
>  5 files changed, 102 insertions(+), 19 deletions(-)
>
> --
> 2.47.0

