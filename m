Return-Path: <linux-kernel+bounces-575946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36531A70924
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 19:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE00916F995
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 18:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7371ACEAF;
	Tue, 25 Mar 2025 18:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WD6NCIXg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AknzfG/R"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35841A315D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 18:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742928111; cv=fail; b=uru7Vgrdk9VkaA20KJgZh5M9Z7s7cwYC0cjEXR4lJ6cEfGUOhKyuOtCfEIRXJKcI7PcCR2d/cwb/HJte7T2QPcpWEVGg4PcxJVIKqr9tmvTBbNIWqRyhQyo4fJn9yx3ywd27kiOti/1CsaPm1XrEDkG/GRL11g6eltSlhkiJC90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742928111; c=relaxed/simple;
	bh=fHKNLAqU4IUL624HTiaCEYYBrL0b7l3VCw/pDNFooHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XmFNTMFfJx9S529i2CElmwrlV1AeFkPC/E6NsOL8AbXX3DkKEDD/O/hIOP1E00cJhVg74IZvf5XyaZLlq/S1w9OMI+NHg2M+VI+0/1/r6VGUeMewU5I+E4E2Nhl7M+r8UhbhQcqGxtF1+VhBz1G6P85Y0sUMHu7t+iAJ60ZxIL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WD6NCIXg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AknzfG/R; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PGws79007573;
	Tue, 25 Mar 2025 18:41:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=2q8SL0tD9R073cyL7W
	ZQYVg+7gCAdmjdxm5I9Cu0SZw=; b=WD6NCIXg0zLnkUA7nqReLjENZiwLD7yX+W
	7tJNDFfnhgoF/d/UMie1gcR6bNG5GVvo6LTq7tPhYoS8IBPP5pboYkSzXM7kviu5
	AK2wyALjAAjQTTToMS+YK7792RFSdQCtiJXeSlgnVTYEsAG/kH2vwqRrKun1PC/L
	1KTgGDplkUHO65SiWtoZU5E1CgnciIBSuOtJhDkCIEqQrrZnk8ZrCszCd70Glet1
	xaD3A7jVhEgBbnbVBp7Tix0YSU2b5JXG71RLc0mL0mwnLpNxGJn0Jkx0szOsDieY
	ZO/WQXqUuCEn3carnp7PG9fNae4VUNyMDJl5FXknk5hJZWO5i7/w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hn9byvvp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Mar 2025 18:41:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52PIQQ2R037017;
	Tue, 25 Mar 2025 18:41:37 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45jj5csjwv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Mar 2025 18:41:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qBaozLuv1LVgFzEsxXM2zbnG1yQFspPN7mNT/4hgEssreHZuqvyQpDMxh7Ij8USInw398UmSsWMAH1Ir6hHYiLvKkFTJeBlmcPpRwuBarp89znD8FkPaxgmljT0H73bO0tHHvz/KBl6eGsHroYQSbaEhMVC2Cdr6yR+1XvOwFY38pKL/6iStucmmCXTH92lRT60agEZsrE+TigynxWcq5uBhKyntKe6H+/dvMhMLT1hlSg0ITVgvhtemRQGN4xXLkHCVCSzJ5Qu524rLLmarNn4toXuRUa37rlEsOyq84XtTiJMIDtkjAH0P2x2aunkYdKLo6j7wN/7JvxCbKrM19A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2q8SL0tD9R073cyL7WZQYVg+7gCAdmjdxm5I9Cu0SZw=;
 b=aMG1XlpXq6JYZBDGCaB1W61AmHPEpqSXcfT2DVf/3xY4FE44NfccSs+nlWgtVqSuIVDiy2DeuW+0woflkEU0uzx/yUHnOysbyY7Lg4pILONwfggcoqgytkI2WkaTAG4pH+a2gH0wvBNKE654eRDSGTxD0VLFfK2av82ZOaKPo+x2DRfHNfxg2W0UZbYMpTnNBINxebb2e/9cMqkCoJszGpO0XRFis6W40PVaqYzJKzMWJBginH+WcHpJfL/emjSBhiW/8EAULjUjrqvO1aoji5Lo3ljUxCKKqTYYFTswP9sQShqYc81JspfIPH94poNI0iB2VzlKiljkTg1btcSv7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2q8SL0tD9R073cyL7WZQYVg+7gCAdmjdxm5I9Cu0SZw=;
 b=AknzfG/RwbTokE1IkpEholJomtbsU1fjCKdV3iSPk6ChBaGPU+N+0/w2kcJv/qWl5RWFf+r1+Ql/SdcWZtyPG8tP6hecbjct9DRB1HIAfQ7yVbb0yu/zH9tpUfbXbusXtwMMLvZ30flEPV2TvTx3XMbw+/HjFtFrha2CW2XBI+U=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CO1PR10MB4803.namprd10.prod.outlook.com (2603:10b6:303:92::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Tue, 25 Mar
 2025 18:41:32 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%7]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 18:41:32 +0000
Date: Tue, 25 Mar 2025 14:41:30 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] MAINTAINERS: Add myself as userfaultfd reviewer
Message-ID: <y7zhc2wanmntl2r76ehuda2wcovpk5tss3bjnrcjnoak43q3uo@wwlmbz5ledva>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Axel Rasmussen <axelrasmussen@google.com>, Mike Rapoport <rppt@kernel.org>, 
	Andrea Arcangeli <aarcange@redhat.com>, Lorenzo Stoakes <lstoakes@gmail.com>, 
	David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>
References: <20250322002124.131736-1-peterx@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250322002124.131736-1-peterx@redhat.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: BL0PR1501CA0019.namprd15.prod.outlook.com
 (2603:10b6:207:17::32) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CO1PR10MB4803:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ff74d8c-c366-446d-ecf0-08dd6bcca9ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?11lTraTbxW9vvQ+L2ll9y5ecYenWMaC1MsOzuPPLv3XJoEcfCIsoSdmTSyGg?=
 =?us-ascii?Q?l8cTy/S6/mHXIiqvCWnYNvyvJSrwmGnQlhyKhLE5GygAVEqx05KLDprqHtBP?=
 =?us-ascii?Q?MCXEY0ZHRLmhUxAfLjt8SIwMxRa69CHQq/wDZ57qMirAG0VZ45cyDcu0mLtq?=
 =?us-ascii?Q?EJLAtK0RKPJatj2V5B/K26CU2veGO54Qr3P1UTlbdS53Cq3ReJj3gDvINXnD?=
 =?us-ascii?Q?K7/L21OdKbBAu1Gu+CL7So8vjV3dVKeSZKBPjp1HE+zt4N16ijYGI0H6dkAL?=
 =?us-ascii?Q?Tznfuf5vakzCXNZZnNReVlbWE6lxFX1CMQjLZJXg41jiKALxMsqqMj89z/+u?=
 =?us-ascii?Q?1NTekvCgd2F3HEPFh8E8jZxDHJz3WY7MvkzKhjEhTswxHKEmba0cK1NS0heO?=
 =?us-ascii?Q?tCZFW/bU1DtoIc2WAQNjQVf+D7lsXruuTPFsIFLsSKH/pztPZ+7dsZB5B6ZE?=
 =?us-ascii?Q?+T5iDEY8YM6X9gDEqCkUzhCy2OWNDc8dczG1uJQkVhkWlsJbsqBmVGZ/H9nh?=
 =?us-ascii?Q?MgrIHiZiKSMxWLSfb1UlEbqToMDEi3taW9CF8TdE/oQFETHWonI0cJ6+R+R5?=
 =?us-ascii?Q?mf1w/Sb8F2ssutLsMC2SagB84cKv6BPL9y3nWdxu2vkcP+eYfpOWqOI6C6yh?=
 =?us-ascii?Q?bin9eHMu38uLAp0PIA7+2aw6l4K/UzpEt4uvYK+tqqWO544dBEbFtwCdPnvN?=
 =?us-ascii?Q?rcu7d7IozufL3VuOICJwr1hMoQgOAgH1MXUzxbNv26MQQLacI/p28BSxLAZp?=
 =?us-ascii?Q?FjNnMl+hgqReQZTmjz8mPley0C/6sdsz3H9Ic6wgYsJwbFhqmsWKOsCVon8v?=
 =?us-ascii?Q?7VrZk6PkGJ+K5EhkSyWAzUNRDD4A4GGd5YIykopeLJrD4KKllZXQzRgYVjeW?=
 =?us-ascii?Q?XQ5GaTbCWgOtkxpfvZZimolD2MsUE2HEecfRKEXn3tO0CfpqhtWeGecmNuby?=
 =?us-ascii?Q?zS1WnBUPTkMXtMOCTYSHc7xsOyTDxE+hmpXAHJPcJBXDKJO6jgx5N9+BHCjh?=
 =?us-ascii?Q?UklYr0ao6rfPW6X0ACjnBCEQVoZgd55IB0zLWSLkKj/9O+PjTcwtRW+thY3B?=
 =?us-ascii?Q?Z57l+ZSzwJiQttLEoEMqXaZa2zVX9jDgyP7b5UfRAdjssCvEFrJKFYcJUg3w?=
 =?us-ascii?Q?Y9PJIlnQvS+xRBtlPHgw8EOdpffQrZ/Xo8vNg/T7+L0O73oeAQraT2wX6dCF?=
 =?us-ascii?Q?rO39DR8n8LxM665hSX4Bj9TeHptUfng8GXbjmbogr3k7LNVcsWLR+zeNt9p2?=
 =?us-ascii?Q?m99HZHjDZmYE0ACAIlEx655iM4Aq2Gux8hKDQVUexElqUUj6b8ATAk9G5Snr?=
 =?us-ascii?Q?ly3zgy8CoiYxgHEG+p58gXcnIufbUCJsrc11uJEf+6kZEC0BSCwCvh2YLoXo?=
 =?us-ascii?Q?r6aXerqhDwsLzuUobKe85k1ogzaU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Yg/UhjDSCoMEJrKR2Vdl/yRTX9cBi4FAQbkrPUZ4/2P3G35SXwGXINK8hdlI?=
 =?us-ascii?Q?L9F5V4G8OdCnGRh+Bef1x54BkHBOCeXSNZKpz3FLaw3aJr9WKdtyovxuqGEn?=
 =?us-ascii?Q?IeLUqo9Hwn1b62G9KTiKI1B/PCkkmX4ZHZuz+/JZPhcxnZCHKp9X9u6bvPs6?=
 =?us-ascii?Q?+hJTaqwIXMA7qrp06GbznL3BXo6WeYESMd08rhPIyZvL6ES0/pXPOaPWpyTT?=
 =?us-ascii?Q?UNoUy6gmwPKZ4aBJ4geCQpd2dqeuNyJpJvyru1XfSXxt5zNHskOZk1Dcpcsj?=
 =?us-ascii?Q?01nIZJKj73mh3EkA7yUmxOvoNyWcHMyjD1lsvTe4zancTMA1q9OZZ01IIu5y?=
 =?us-ascii?Q?9iLEHRYehchAO0Y83SIMIevI9M//8gAmJyFaC5CpXjflvnHcnqeBcU1LD8eb?=
 =?us-ascii?Q?ctp8qZ5Dj8ZBGdNhJOdloD6ChjB95lvWVj66vLj6Xkyxuel5EHRnqvq+i9Qj?=
 =?us-ascii?Q?HUEEiQvGvQx/Y1MI0HJtwjGqQY/4prNfJDt5Nx4tjoxIcBBHp9FOOa3RX+Nq?=
 =?us-ascii?Q?4qzSL6zvAA5e36upbM8ayvazEeu7LO7X2AVycB5g96YDbVJBAiZUvoVb9VYW?=
 =?us-ascii?Q?uWfww8QX2phnuJ0SPDUEHesi5/Wadm91+Kr7uLrT4eoFV8cp2sWa7i+pEP3F?=
 =?us-ascii?Q?NphSIL2t9O/6YDhJFqUTII+5s/uk1wdUOzBcVbZ33zsy0bFXVoqJe3MqqR3r?=
 =?us-ascii?Q?fMjqhUDUh2rddfjIMiAQb2qPZ7sI6UAHxwKc55nbd3waPHRmhRZsNKhy330y?=
 =?us-ascii?Q?tCrSq8P8vjBR2C6Rgw+/bhiCz3u9EWon2h/yehBCPsmqW8iry0GtfX0a7+Xv?=
 =?us-ascii?Q?WHFaVPXhNjTEgnUHh0Ctad84UmRWiX95FwuCDWy6otXbuSsw7EEcfqKHFUF7?=
 =?us-ascii?Q?lBVdsWxAuSlzlmlHFeoM3BV2cwhnhffWGvFBKEYIhCEkvZMUzrIS/d9tlYQC?=
 =?us-ascii?Q?XMqGcgp7zIiUYozMkNEHfQzdzydy5o6K76FuQlbPzWAs4oG5Au0JCTnJ7HNx?=
 =?us-ascii?Q?X8SxFcnNtf4hkz8nh0IR7NfP44/Q1fa5n03/k/2N4vCw7Gjf4q6GCbCCI+k0?=
 =?us-ascii?Q?stPhRYGDjsF43EHp4SSdQyqdJKM8qtNFu4cpzXcmzGiKM6L+38Z6ZFIlpUuh?=
 =?us-ascii?Q?9M6fqZpIXHIf0G4MbTqpfWDQetNtVVK3q5yZ9c208iMRA+TasnkBtqyjwlFV?=
 =?us-ascii?Q?1KGAxEidUoS+AzDfGOAygiZgYvg7chmP82Z3+o9QJNYR1lDHrSgNCUJSH+xb?=
 =?us-ascii?Q?FWSiTHoo76U9nKOBUj4QngeKkV978Ek3atc2T18emPa/2bQC7ES4WsrS6DHC?=
 =?us-ascii?Q?hU0WN5EDLoAxEX/mc98CHA+EcKIe503mytV2wkfVfaQKXGYaCAdLbYkz5x5p?=
 =?us-ascii?Q?8We/1jZ4j4yMOHer3w2Sw6CuKzzgtWvQNj51VQw+ULkeFaojxeygqzflVQUU?=
 =?us-ascii?Q?ymlax0sta8vkEcFdWFB3XHDtZ7m7ZpHmRmRouU+JR0bmbep+DDvipvr7HAGK?=
 =?us-ascii?Q?QDtSEmRi+KavnPi89+Z+2O4gRsbqa4960tvaGKzHZiWpuCPGC9Kj2hFsDCJ2?=
 =?us-ascii?Q?blb51CGBc5CoaciW4ba0tO/4RrirZTouKmNfgmmJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JSLdtB5xezIwQNU5szVv0jSkHHlCyL5pbA4dnON5g/pDFLWLdaghMjoZ1ST0HHVR4OVMVBiYTI1fnThniDa7muz9U/0ztWVobORclW38Nt65WKrEHFpmYoLkKrA2HyXReErlzP6yCnFCOjHnh0c7dD0bihXc9/Snt7WTID3FPl3+PY3Bngdrw9P2GkEBjZJu/43Bz4M2VjZiafY77dk3q820FRG2vKD/1B4aNbBsIuT8kAGcetNnz0SqABYQKs3TfKGOqIn3uTs6chzo1XMY5jZHB9v80j3r9MIv8hkG2Rv6qYxuadB+xCVjEND/9NcVGiKm+gX3m2otevp8VZtNYrufAeY13OjUmpkz3t5hqZ+z+J+jgPvmR4nDOgvxucLY1uQ1KdfuYyYdbFP2xDb/heP7Fyu1uMD6io+iaNABZpCc5cn8ZehE8eic2aDXgj86DY+BbklU4zBp8BQ4CC+DIg6Q3XnSwATtlMcOfe3h4dEcPShoA/9ZnamuaQBe2Z0n6mD/lwgDRJobaisvafTNVSEnZZ94kQ/GpIAe+J0Av/4EJm+P97NhX9yxJdiZPEnSDehgFZCj0GVZdQd9dp7+sE7xUk0/XOtoJ6fQ6GWi31E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff74d8c-c366-446d-ecf0-08dd6bcca9ff
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 18:41:32.7738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LGYaNq7OhU14nt4TfPLg3Dq55/Mml47terVJaI8bP1+XDutmsowMeZXCx0eXE+wnGG5bChMZhMFHa05//P1Ryw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4803
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_08,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503250127
X-Proofpoint-GUID: 8WhbUVXDV2gsMzMTmLem1TtDOTkyPGOI
X-Proofpoint-ORIG-GUID: 8WhbUVXDV2gsMzMTmLem1TtDOTkyPGOI

* Peter Xu <peterx@redhat.com> [250321 20:22]:
> Add an entry for userfaultfd and make myself a reviewer of it, just in case
> it helps people manage the cc list.
> 
> I named it MEMORY USERFAULTFD, could be a bad name, but then it can be
> together with the MEMORY* entries when everything is in alphabetic order,
> which is definitely a benefit.
> 
> The line may not change much on how I'd work with userfaultfd; I think I'll
> do the same as before..  But maybe it still, more or less, adds some
> responsibility on top, indeed.
> 
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Thanks Peter.

Acked-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  MAINTAINERS | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e714ea3a7c9f..844e3e1e05d2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15220,6 +15220,17 @@ F:	mm/vma.h
>  F:	mm/vma_internal.h
>  F:	tools/testing/vma/
>  
> +MEMORY USERFAULTFD
> +M:	Andrew Morton <akpm@linux-foundation.org>
> +R:	Peter Xu <peterx@redhat.com>
> +S:	Maintained
> +F:	mm/userfaultfd.c
> +F:	fs/userfaultfd.c
> +F:	include/uapi/linux/userfaultfd.h
> +F:	include/asm-generic/pgtable_uffd.h
> +F:	Documentation/admin-guide/mm/userfaultfd.rst
> +F:	tools/testing/selftests/mm/uffd-*.[ch]
> +
>  MEMORY TECHNOLOGY DEVICES (MTD)
>  M:	Miquel Raynal <miquel.raynal@bootlin.com>
>  M:	Richard Weinberger <richard@nod.at>
> -- 
> 2.48.1
> 

