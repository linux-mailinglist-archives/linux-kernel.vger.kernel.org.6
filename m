Return-Path: <linux-kernel+bounces-319606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B83796FF2A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 04:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 463B3284147
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 02:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E3312B8B;
	Sat,  7 Sep 2024 02:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T0J73n5v";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eVK8msXV"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516E21849
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 02:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725675334; cv=fail; b=gjaZNttjNxOXx/6j8ymvJFmKLKJeMc578sUHJKajS0NdvxYz7HvxfY0OIeJtxFs0K6dfNxOkJlsP6k5D2oChLMXx/pVqd0oswiFFNoMS0qheTCq+FK1DaPk3xvmKaDpvU1W+rRTHwQWxT0c3vOgPQGjQ23zCoLBOiI7dk0TkUN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725675334; c=relaxed/simple;
	bh=WU/iP7/N0+OFiyCL3DZ/cs7hvsBdrduwFXRtYf1H9AM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GhZedI247bCRpF9UzbMiNu3ueimZuPhx9rF8Gp9DXvbByWVVvoK8roDjLGtcl3jznV17Ex2NIy+EIiwzWLO+3eD+wwMLH3TJvMMbiv8X2puLp1OB0Jx1OD0jih0B2Wvi+luqScfZFtBrlX74/RgAzEvBqHY+VCfmlk2T1gSYFeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T0J73n5v; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eVK8msXV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 486KXVpw015024;
	Sat, 7 Sep 2024 02:15:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=5fAKtrDAb7Fh2D
	+5Keucz1nUXgXiVGjHPjoffTJ7E9g=; b=T0J73n5vQmYEZmoDXoDf7/qjrvH5lY
	Ors4IlloPd7M93AqGxS/1pL4iDCUbZ8XTPRaAb0Yd9dNG+SGFehv3uZiLyVjhEwN
	PUrzc3zXePi73rnYe5qCgVZJIYwSzEnaqEPgA7lMBvVRVi/eZL3ybDj4rOlCLKDU
	UNlPT/ivA6Lv/C3R3p5L7yO8Ryvu+DOPtCU6rGl4sl+RQgXuqo3hGdsRVRsYUEtY
	EKCwJQ6sPUvldJUCTdfNl3ZEbwNiU3Rw97pDD0uRksrbSinz66CNZvcrP48KN9RG
	K5nvSb7DCtHf9s2mHv9gcN3s6IdR61Rx4WiK45m5aqdVs4p6aAWzZ0Tw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41fhwjjvu7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 07 Sep 2024 02:15:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4871Y4uV019854;
	Sat, 7 Sep 2024 02:15:20 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9c0kvd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 07 Sep 2024 02:15:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=meW8LyI/Z9gDKC74QtLDIUlRCAOA/52FJR8sHXOTsjoXQ0UH03fMHK8nU5HOzsTTpA5ObSItW4d7faFhcY/s2JIDJR9kDzSnUL/0IUWAY4aa/1nR2UDJ3i0XRL7o56YC/UMi3WtZ8eMQ91ofCLfsrN1B8Sm8hbaXlola9TKRIal+AHUnttEu+km1Y/y3DXkK4c5+Ix0envhibBjwyYL6W7rREAQL/uw8qD2JbNXM0X4gSeVi9feHDu82h8itViAaU8eR+BbpeP4S7RJVjyZPbixB7RaN1xhp8EL7PKD0en6f/lHZ3wTSrot6jyAbWcIcGmZ03FVXB6BBuCGNeBnn8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5fAKtrDAb7Fh2D+5Keucz1nUXgXiVGjHPjoffTJ7E9g=;
 b=Dk9h8Sk7hl2pfTcfHvgLCkqDa+iGQ1WgPJ6PD+tRNPfmZMerORwe2QNaBLl9xQ6LNzDAbai21e4yhl0X8MpjC9m3Edd1PnjBwhrDoKVQmPuv7QuxPzsAKPGoE5J5wwlqXzV9YKe9Ms9qclQN21y/NdACwyHj7nLuhKzhK3YO6IMWkmfJ3atnfRV1MpCZFYuojEo1OzQph2q9HDZgg7o2U+s+CZeXpl348BjQFBaLuzDzer+hqpZJY4ko0k5yFj3spjBlESV/BXH0zwOc3loiqvRBkyXUhYfEVFJsme0lIfSLXliTe5Q5V9qyKNfIjgE54ISFwU0/2ldn4CMNggBNaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5fAKtrDAb7Fh2D+5Keucz1nUXgXiVGjHPjoffTJ7E9g=;
 b=eVK8msXVoW8P7rDElLeSrxFKizYvaaOlgfWA5KvxVx3c9sNmY2mY6GBsYpSiajKnNKWkyGFFgmMbzKTjJgZUGgEPX+v7Oo2eaB959ds6dimZAZ6vi0P7zlDXO8MjYVBlMnBhkE0v3Asunvb22xVsnSrkjzxLR79/vfponl+WOUU=
Received: from LV8PR10MB7943.namprd10.prod.outlook.com (2603:10b6:408:1f9::22)
 by IA1PR10MB6805.namprd10.prod.outlook.com (2603:10b6:208:42b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.10; Sat, 7 Sep
 2024 02:15:16 +0000
Received: from LV8PR10MB7943.namprd10.prod.outlook.com
 ([fe80::a8ec:6b6b:e1a:782d]) by LV8PR10MB7943.namprd10.prod.outlook.com
 ([fe80::a8ec:6b6b:e1a:782d%7]) with mapi id 15.20.7918.020; Sat, 7 Sep 2024
 02:15:16 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH] maple_tree: Mark three functions as __maybe_unused
Date: Fri,  6 Sep 2024 22:15:06 -0400
Message-ID: <20240907021506.4018676-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0071.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::23) To LV8PR10MB7943.namprd10.prod.outlook.com
 (2603:10b6:408:1f9::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR10MB7943:EE_|IA1PR10MB6805:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ea768c0-91d2-40b8-796f-08dccee2ea28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d2KnWCnCre0oy54wokIT0GrfWykUgoWQq/RzHvFNR5gDno03AnWj4gUv62kH?=
 =?us-ascii?Q?ZQH7MJgqNtdsbFQlRPVLp18H8fPSmYFmBo4JydHEzAgfFzu2N4APM7+IbNlU?=
 =?us-ascii?Q?sK3C9suKlaYh9E30CpsqTwuGQfTQZFHtP6U+25t9HmpfSvVvMCNWzzlhpuqI?=
 =?us-ascii?Q?XZz6Pokw+zt8uwa9twkRyJ8F5NOjRDuirQ67TpwfiXYXT8Bx5/bdeDj4Mz8n?=
 =?us-ascii?Q?Jr3IM8bF6pDxZ/vxRo/FZ/2sZFIt6AZ2sfJaOAB+KhAfKOm2TJ9FFUgca2/r?=
 =?us-ascii?Q?xhmSs0CoW6spj10vcOTrkxHFK3pH8hkR18ugjG0nN5UKzAvjX3LFXGmBeUG+?=
 =?us-ascii?Q?FuelS4l53u7RUMN7OuoHZuHhvYtS79UAtFsHLQiHE/InYmm3lS2BLw8T45tt?=
 =?us-ascii?Q?UJVXmAOiAktKQMkG/+aiATabcgdE1fL8js91BNl8EkAtQzWf5bjzOWC++Kmx?=
 =?us-ascii?Q?Qd/eJCpqPA4q/0ZnCb/hR89poPVyH04QLX0PKRSQTjQuDdtosuietKv3WnVJ?=
 =?us-ascii?Q?CDtSLH45M09eQu98M/O0dPcFx5H+69wjN3xQZlpyWtXJaVj7Grohrel8dnih?=
 =?us-ascii?Q?KbiwYgGojUsSYStSvFRAlYapstSjEYM/t53GG0da6lMz+rhUznEKODDVhtI6?=
 =?us-ascii?Q?2w9MX6X08m+PtRpQXtcbIhkQhCczaEZ93IAxYF4LKYSykNgc3/wSzXxed1G7?=
 =?us-ascii?Q?0x0w62Gkji75PbCI2l18V3wqgt+OA9WCvsyIGumYInLeevsG/B+1OiX6Wg64?=
 =?us-ascii?Q?5mCYxyAtbrIr+YHjmGc0ofAStrJ8d7xDNLsvfMJk5TaJ/zDLnwLOZocV+RgG?=
 =?us-ascii?Q?G1q8i9B/IlmEQTEq47iZ3uvVp5KyY9QztvZXMrG1adx7O5YnWsFJK1MJ/f+Q?=
 =?us-ascii?Q?XpEpeu9y8iqRQIlMNF0Zo28oEml62SpfApgZfKUK155SKLMRv41QZJzA8V6w?=
 =?us-ascii?Q?cS0zkFdi9DD9HtH69uubJIB8T75iZJegnKb8zaJm8fR0/daEfxkl0LhwDjUS?=
 =?us-ascii?Q?vjMGY/RUz+UFf8wlgogGa2gHA9LEVcxLiC6vLYphIBL1lTiuSMGA72ZleKSj?=
 =?us-ascii?Q?n2MxtLSBHLA6yVwR7PAiUzaYaOEi79Wka0BPyEwWT8Hcu8gsDB1iF9Jfmrfb?=
 =?us-ascii?Q?mCwTjLCX2vq9XgsVbPahemJ86YPX8YCsg3srWI690bcbhp7FqRfp3i5lNDHA?=
 =?us-ascii?Q?TW2S00npP+LMVL4wJdKbT33L7mE8JdKf/ANOnRqdosZYF/S1HI+/rxK/xDVj?=
 =?us-ascii?Q?dWz8g9LGuQaFgBuJnFFe0GNWfKXDbTarlEp2y1TXmiIHnRfX5uFPDDPXqpPo?=
 =?us-ascii?Q?tRj02h7FTfBbkbIGzv+C/rWJ1Rv7ocrL/7GbpFV0Bpieg+eg6ppYCkNpPFxn?=
 =?us-ascii?Q?bq35o9A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR10MB7943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dwb3N0i/W3o4KxmdnGYq5mqsl9T3JNmrA/vpXE0EH5vOiedB03QhxauMgaU5?=
 =?us-ascii?Q?pbZ6ldC8qnnnwhVw3DzS/HqGnR5guFpzzEN6USalNBd/eBZTBe2GAMchNe9c?=
 =?us-ascii?Q?co+y9cqgCh2nm7mSm4wFtPFmBVhOoJXGrlQk2/Ms2+jaKl5gFEpL4f1LvQqp?=
 =?us-ascii?Q?VkMtF3mND1+l9xoVxxGmuYr9mCC1qqIrsVfyIEi1Fj0YPxvsBKXX0BhPEPmR?=
 =?us-ascii?Q?cn7dnIj1wnGTgmohHy9ssfjAkYGGkVauYZQSSFG3sAg7RkXTmBa72mk5wqyc?=
 =?us-ascii?Q?MbSwQqT6LVE3+hASjskWwXgZ+6yXC02KIrgioa1rhVTWP08n1mSGH2/t0eCL?=
 =?us-ascii?Q?k+ejQYRGOaN0C+XsnGp6sjNcbhKOjLAW1VHK02S3d/i/UbAbKm0/GeS7tm61?=
 =?us-ascii?Q?KpPXJC8qOVvoJna7S8uKkRSlXnBvqdGpiayvuKgfla6x9NlV1eU33GxvWtxy?=
 =?us-ascii?Q?pNNkZKbF3f63XBih8L/8pd80zzZjp6gS/cexMbdCG6OBOLJ8VuY24lVzETWF?=
 =?us-ascii?Q?ZFhixlC3FumyZNouU/XIr23TJRrfbyBAuK/0COYNq69iW4l9LNV6d971pI37?=
 =?us-ascii?Q?05EAH8Uld0ijicTjcj8+wGJTLgugLt2K7XK6WVuhIeVtPdy1NfssREp+DFsw?=
 =?us-ascii?Q?NSOHUpzOaaLpkvrZvTdcF1Jwk7lMg1idep8uuu6mZbYPG5GFH+C+1avLAQDV?=
 =?us-ascii?Q?cZuoLE6VqTl9KYqEUAwZCRY1j/kn8C8qllSp4ytj56yzcJ+VrmTG+OCVCQB2?=
 =?us-ascii?Q?sY8E5SshRfMYCSHhjsfDCBMwBNOh2/qOHgwNfIa1cjmYoDd689uucQcreXh5?=
 =?us-ascii?Q?wSmGjuS4Vx8QVndLGT0OdX98N4UGMp+yC+nKFisXvV4RuQlwTTwdCQMfFOB+?=
 =?us-ascii?Q?6NdaljUCt/jqvwAZ5dCTvhO+P69QXOrMXkEJp2DvMiAO4uLi/tFIjSaQu5mE?=
 =?us-ascii?Q?2+IqBJSA3VKw5GVuuZOXxsSIEmfRwtH3VUjoXtMjEgG3ic0h0Hoci3tYYbHn?=
 =?us-ascii?Q?dreFdtnn9NowDcV32EMj8ebscH4nqwzTAa2ThrExTSjxCSRA7R8yxJuenl7w?=
 =?us-ascii?Q?Kxs3v+c9+s4rH08u2LkGobBseMuYHkL+1ypD1FzWQ8+1q5uXYVan7YfgmiSI?=
 =?us-ascii?Q?EmWMrlRdOj86CLh5XVGjE2X1a7gulvwWRoaQynCUFJOurtUO3Qc/q6/NWx+s?=
 =?us-ascii?Q?r7Zp41ZzyhR2WyrfnLLJwItjyUbXtkD0iiybM1hNtXAbYSadsT6pNEuS+B5q?=
 =?us-ascii?Q?tlXpdcgsAPL3GriKiNY5f3DGkej4dknuOj1K8+/WZatrNdwP8gNWr+/eTnps?=
 =?us-ascii?Q?rQesrnV2oq2KsFXArO4tXwbIAI5Hi6uS1IxvXVGFf8LMXFmbkzy3DwSjMkwh?=
 =?us-ascii?Q?3eK6ggeCOo+0jgvNIjeVokXqH2pUbhAsXHBtAEc1e191Kn+S54yfv9+eLv5N?=
 =?us-ascii?Q?IQYFeDLCo9dw49BElRv3/CWzMuY7g9wfb3I7uBdgQb2gWsQf17Dkmp/5tDiz?=
 =?us-ascii?Q?csFlyw09tZ+/Ts9SbYhU+sxazwTDFZu+lTgpWOemFGJdVcCDW5tDNJr6h6tE?=
 =?us-ascii?Q?ftJn5h2KCfW1lBiNv0SfVOG5RXoQ8i2l/cISsEfm?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LGWiFQnZLvo14y6cFHjNUWA82NHseVOPXTmercnLNooXgb8el+0xAp6R+1/kBMicDgrPkt9BAHmbz28WG6hypB6Cb7xUjKnnBmoIIpWkcKfWCta1EZsyCgZ4YIKFtvCXizgl46lYGXeiPJEGB3T+fg3dHe39OptFygaS9wuUF/G7pIFo01XfL39LyG7vwiboLML07FH92YLwsH4244W2phi2YwMMn03NKlAXuMbqjJOgXI5upOEe8WIebpyHDqwHoarOQOe54jp6EwWy3kWCzdiQXQXhi97SY4XxcEEnouzPi4HoV5FGLg6tEzr169JuU7WwgfmdGFmCnvC4lFw/+8ja94ZizYGPIyxi0JvOleuvs6890EusOQHF5gVNW5+CFHGDBuLk/pT8GXQNrvVum1e1vl/qxQbpdQaGqQfxU8vtWcnlD1K4aCWxx2wRSoqFPER0cBDbZKiXHLqoFX/QtckKLkMqpbO6hNoXhVtKPmkz/15vanMrqcJ272N/0gNYziauqG4W7snGsvYhXWtxVrUV7rTjvT71NyOtYRpxn/zZXP9Ii6MYk0uiqvtXR9kk1rCi8maSZk8aqykb9OWN4UNBQH9GUci/7WLZRv8cP/Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea768c0-91d2-40b8-796f-08dccee2ea28
X-MS-Exchange-CrossTenant-AuthSource: LV8PR10MB7943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2024 02:15:16.7412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wUZqMUXMVCs9miD8ChetoegZhv7qBBqc0xZL5vW94uwHZfHUH7JbN8/epoEK7GVqgSaX61zHr75xDJ/Ph2/8Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6805
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 bulkscore=0 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409070015
X-Proofpoint-ORIG-GUID: 1dlU19IePtnGo_TXtNNfaPSoOOMod-3T
X-Proofpoint-GUID: 1dlU19IePtnGo_TXtNNfaPSoOOMod-3T

People keep trying to remove three functions that are going to be used
in a feature that is being developed.  Dropping the functions entirely
may end up with people trying to use the bit for other uses, as people
have tried in the past.

Adding __maybe_unused stops compilers complaining about the unused
functions so they can be silently optimised out of the compiled code and
people won't try to claim the bit for another use.

Link: https://lore.kernel.org/all/20230726080916.17454-2-zhangpeng.00@bytedance.com/
Link: https://lore.kernel.org/all/202408310728.S7EE59BN-lkp@intel.com/
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 4f34e50c92b5..20990ecba2dd 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -348,17 +348,17 @@ static inline void *mte_safe_root(const struct maple_enode *node)
 	return (void *)((unsigned long)node & ~MAPLE_ROOT_NODE);
 }
 
-static inline void *mte_set_full(const struct maple_enode *node)
+static inline void __maybe_unused *mte_set_full(const struct maple_enode *node)
 {
 	return (void *)((unsigned long)node & ~MAPLE_ENODE_NULL);
 }
 
-static inline void *mte_clear_full(const struct maple_enode *node)
+static inline void __maybe_unused *mte_clear_full(const struct maple_enode *node)
 {
 	return (void *)((unsigned long)node | MAPLE_ENODE_NULL);
 }
 
-static inline bool mte_has_null(const struct maple_enode *node)
+static inline bool __maybe_unused mte_has_null(const struct maple_enode *node)
 {
 	return (unsigned long)node & MAPLE_ENODE_NULL;
 }
-- 
2.43.0


