Return-Path: <linux-kernel+bounces-320667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9659970DEB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 08:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46E2A1F210B8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 06:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045EA1AC8B0;
	Mon,  9 Sep 2024 06:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="TmjloNBV"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2124.outbound.protection.outlook.com [40.107.215.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90AAB658
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 06:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725863610; cv=fail; b=UP6HM6nAcaQYe59UQeFELfvKxDYllvpbaX0rOj6a5SqzX+ahQdCaR0eUyRjHMGCe66R0PKsKi0ZfZJlx/0jharalkWESDEOxOZa0JCilEvNHrjNnRtYbIXiUCUwMFzVbt7abZTHKIzBdtjD2HfMjbWIwYZEecGQN8w6zrf1eVP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725863610; c=relaxed/simple;
	bh=WPNtR9xsoyK/IBAAsPK3GUnHIDoCuavmKZNv8s4yfII=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=qXcja+wh5nkAMU9rtU+LAX/UfoS/Jf3V02bETktifwcTHcoalAAoU2eaBRRa0buHIxuvMJjzWA8oN4tQr7+kSbaBv3wBbSYjziQaZ63n6HkMRVDnzKNpIev8TL86y8gvtghldkJZdgWQFT88uk65CwCi2UeTXfP23A6tU2PxRYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=TmjloNBV; arc=fail smtp.client-ip=40.107.215.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ob7gn7rSIBPz3gPwkzWKxJKVaQc7B+03qDkKrCsdNV7biopq055u2Fd3gAD3RMPRepMTyBY+DZxKTYXddmw07PY8xVAhQ4mcVLOXdsrZILREL0RCDQCybIJAqR3R2nN7XUd9Wq5dpnwNS9RKjbHj3+cDwubh2yWwrbS/5opdMGrGBXr1M6foFI8KuURPBJDxH+1kiRc9E82kDbkIroIT3DYG62eWpgJy/GLjEcG22RzIel3ZeT29HuNd8fzbKl62gKVoKL6jBDJ4zmhR4zHWmKkNhK9yYYrqo9gjLIlvjlERgnkTClAGy5wrKXFT5qH4PKBfoOZ9eo/XqUhQQDIfEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rl1/cP/r+sNaG8LPik4cC9acY47sknQRoNv9KZVmSJk=;
 b=UnxH/5wnBU4+aBeV1AZK0yQWQlQeWlHMwgnZhI/KrZ2SbX7U0Y1xvfgL4/RO6p7T8dm7ErEKyX8TcAll5Pse6zosfkmNE+su/Su4vsY8YQ2Op+XMV6tyNOTnqI99PQOePOfW3Xx9UhLbuGGoKB3b7oNPMgnOseouN/cfbFUCwZVM+x62ZKha68ul3sRueXeDdWogJrPDI3pnEIUEtYPoCh0VDl2k9PUh8ViXzoETkSH3f9A5Ekhyp9pfIMYyZj6s/kfQDozWr7rnYD3bjezFKGZUspC1cmI2PugigxCYWUW5OK8l6n1HktFW5BrFu282KPxyUiL8tCUSgj96Z955iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rl1/cP/r+sNaG8LPik4cC9acY47sknQRoNv9KZVmSJk=;
 b=TmjloNBVwzbf1HcihM9E51LNRklA9INAe7rAhEicJz3DApM7yGHZbihIe1tvL3Ojt3/BDt6p+MZVNQMU6Je9AmxhPRB4hdswsgM3SsU3kjp8suMufkZXioy3/wElFgXQWnNZHc3By5HGMrMtEmx436JB1vHlHvlYOV7LsQ06ahL8D/QSXgQcSNrXoOumnri++uACrZlmiIi2gyPmy7BnLHhoLTdy4WY1luo8/1TGsD6P0OOfpVzNVk9tJZrxDhxaH7FxHPW8HQVAciq8tUKf4rjWFn7MkL4EVhQAEJn8fnSw4+GhIS8u3rARH0EDlwFKLoX1uJYTmHZx0bWu/kQRdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from TYZPR06MB3933.apcprd06.prod.outlook.com (2603:1096:400:29::9)
 by KL1PR06MB6473.apcprd06.prod.outlook.com (2603:1096:820:ef::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Mon, 9 Sep
 2024 06:33:20 +0000
Received: from TYZPR06MB3933.apcprd06.prod.outlook.com
 ([fe80::9b60:a415:f5ed:a367]) by TYZPR06MB3933.apcprd06.prod.outlook.com
 ([fe80::9b60:a415:f5ed:a367%7]) with mapi id 15.20.7939.022; Mon, 9 Sep 2024
 06:33:20 +0000
From: "Shawn.Shao" <shawn.shao@jaguarmicro.com>
To: jacob.e.keller@intel.com,
	linux-kernel@vger.kernel.org
Cc: Shawn Shao <shawn.shao@jaguarmicro.com>
Subject: [PATCH] lib: Export the parsing functions and related data structures of the PLDM library
Date: Mon,  9 Sep 2024 14:33:10 +0800
Message-Id: <20240909063310.1730-1-shawn.shao@jaguarmicro.com>
X-Mailer: git-send-email 2.37.2.windows.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYWP286CA0001.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::12) To TYZPR06MB3933.apcprd06.prod.outlook.com
 (2603:1096:400:29::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB3933:EE_|KL1PR06MB6473:EE_
X-MS-Office365-Filtering-Correlation-Id: a8ae3b1c-4b3c-4627-de03-08dcd0994bd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SFFTNWdHYk1GZTlyVVVCZi9yaTc4aUpJbitRRnQ3bXYwbGV5TDZTRjNaaUJn?=
 =?utf-8?B?czFhS3dQdzMwa2lhQjJpTFc5SHpGTDRlYSttck1QMFh5ekxFNUJuY2JDVi8v?=
 =?utf-8?B?TFhBNTYrMlFFWDNZTFZLQXpuTmV3VXU1N2hLQ2VMeURUVkpUU2sxZ1FLaWx3?=
 =?utf-8?B?Z3U0QjJlVW1jMVhnUk55SGtPbnhtU3YrT2Z1UGFSbUhNTnB4MWJsR2tlU2Zu?=
 =?utf-8?B?Si9JV1g2YUZvOVlhMG1CcFF6MnZ4SGNYOTBENk56RG83cG9hT2lBem5HWm9P?=
 =?utf-8?B?UjlPNk0xYVM3Z0tqWTA3TVVJV2E5SXVjYSt3U1dtZ2tPYUwvbVd4TndLdENX?=
 =?utf-8?B?b3UzQVdPMVpJWW9GWmdNV1hMd2p0bDVQOG1FYVBkL1E0Yjd5STcxMzlVSDJt?=
 =?utf-8?B?aktYK0lKNThQcm5odU96OGk1R2RDZEVjTjVZUlFya1VLdmJOendUS2hlZUl1?=
 =?utf-8?B?cXlxbnFpUUxHNTVWRllySHZzc3N1Vmh5MG9rQVJEWUpRM0p4a3VrUjNCMWRU?=
 =?utf-8?B?cEpsRit4MzVqVjFRT1laTVYxNXJ4R1pwZ0hWVXdiSjVkdUg5K3h0dXE2dVBp?=
 =?utf-8?B?bDUyZHphZGpEQ2J2cUlvV25NTGhQRmlMd0NZYU9wNXFsQ2N3cU56aCs3Z2l4?=
 =?utf-8?B?RjNEMWkvUUMrcTVpNVZiSWR4cDRneVpGQktRTWozMmhjVUpBeGxqUVZ0cmtE?=
 =?utf-8?B?UUpiRC9udzJHRXlKZVQ2Z2lNdC90MHUzaG1SRld1VkRiL09mZXI4S2N2emFJ?=
 =?utf-8?B?djllWkthY0kydlg0ZXVCcVFoMGtyWFpFMlRmQ0pqMFJJdVBVSEZZZDFrL21N?=
 =?utf-8?B?Rk5kUU5jYmZTN2xYbVIvYS9jbDFoNTdtL2dpbCtEdkdoWUhOUTA2TWJOMXI2?=
 =?utf-8?B?bmxJbkRVTDc4eTNJUXI1TEc2Ujd3MERuZ25vRlByNDZOVEZoUkJuV3BYR2lm?=
 =?utf-8?B?Nlh4RWp1RUFTZE5ySU9PMElMaTlhMUpEMCsyd0FTb2g3dWs4QS80djlwTTFJ?=
 =?utf-8?B?Q3VjV2p2TlF6NW0rQ0VFeVZ5NFhud1VEUGR4Nm0yK1JDZndOaU9YSzZwcU92?=
 =?utf-8?B?V0xpZmdjYjRQTEcvOVNGbzBwTjZzZ2VXK0tITDdwYVRYRlEvSjVKNUJ0bWJY?=
 =?utf-8?B?MEppVjlYNFU3RHI3ZkNEYmE2eGUxVExpTXRlWHE1ZXhpREtVWHNLdFVOdkl2?=
 =?utf-8?B?NGxFcG5GL0Mzd3lZOXcrR0s0YUpkbTJxWXhPWkx4YlpxK0M2ZCtQY3ZHZ3I5?=
 =?utf-8?B?cjFUNjlKQmpkYmVEL1VOeHVjbENHQXZhUmhGZGlSMkFtZFdPMldrTlZ3bzlN?=
 =?utf-8?B?cVRHT3ZFQlc3VmVjZ3lLUktrcUQydDhtOStPL0RtTk1OenpSQUZxbkV2a2JE?=
 =?utf-8?B?bnliYXRkS3hMRE1XN3NiNWYwZktHbzc0NzhRWi9ac2RLbnFYVm9HQ1c1bU5j?=
 =?utf-8?B?eHZidE9HNHkvTmF0eVByUlFiTDFJa2NncnBMaGxZVUxhcExnV1M5NnZ0VThX?=
 =?utf-8?B?a291S3FNOFpjRU11clBRS2wwWUdMd05YMHVQb1N1QmhGcFhLQWdiSEUwK3pv?=
 =?utf-8?B?bVNGOFVGL3V3dTBsajUrNmpWT3dKWDBhZjZTNnlGazNTMGFkU2hiR292TG91?=
 =?utf-8?B?NElJQ05saC93SXFkRzZLUlNIT3kxOFFiVnZwa2puSWowcGw0MGo2S3J4amM4?=
 =?utf-8?B?c21GTEF4UVJNZG5RWkp5R0RkdEZiM1JZTzdheW1RUnJaWTE2cVBZeU9DVk9q?=
 =?utf-8?B?RTc3UFRCWnhlVnlSYUZEWHhuK0RBbG1ieE5qRHV0OEJuTFpZaXQwSTdIWENp?=
 =?utf-8?B?MzEwb1Z6dWJrZmZhVDVxQXI4Mm16ZmRpNHlBRDVJa3BKVWVKaG90T2ZVS3R4?=
 =?utf-8?B?ZVMwS04zd01KdjhqQkFBc3BlVTdVUTJwVlFyQ2Qxc0swSnc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB3933.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SkF2VXJWNkVUek00NUs4aUxNNTIrTlZrcnlacmFickFBVm5VdDN3Ty9mcTZJ?=
 =?utf-8?B?YmJiVDBodGY2bjVxem8wL1BNWHBCRCs3V0lId25iUFZucFJ5QmtvazUwVXgr?=
 =?utf-8?B?SjZCN1QvMTdCbmhzZUtwWXlqYmVsTEozR1pCSW5oSElWLzRzTUlPWlRXZ3FJ?=
 =?utf-8?B?dVBaTW9JWHYzaVg3bGNKN2d1Yjk5cWtaeGhSbVptcDBud2ZoQ25lbU13T2Vn?=
 =?utf-8?B?bmZCVGdJb2ttWHBtUTlQdGQ0R3ZMRVpDR0RmajZRWFhoc0dDMUNzWGM0aldD?=
 =?utf-8?B?NG9QUDJwRkxtK2U5MlZXdHYwWlV5TzhIUnNjSkxkTVl0bXR1UVZ6cnp1SldN?=
 =?utf-8?B?Qno5ZURwbHlaWS9tYjRyZHhFWXZkM1BnSWNCMVFHaVZjN3RoYzRaOS9sYkZi?=
 =?utf-8?B?OTgxQXpkbG5UME50YnBVTTVxeHZ2NTMxdElMczFqYzRwSmF3MlQzUmlkS2FU?=
 =?utf-8?B?eWhoNXFhODg3bm9ybmRrV2Q5TEN6ODRzS1RuTnNvcTBnUDU1ZDZKWW5FdVVv?=
 =?utf-8?B?dnNNcHFibDlXZm9wY2gxdXdnYms2T0UwOVRia3JWR0RCR0M5UXcwdVFhNCsv?=
 =?utf-8?B?bWQxc3pOUVlVcXJBNzc4bjMyc2lFckhBc1dodFZyZ0Y0RnJkdjgwUDIzV2hk?=
 =?utf-8?B?c1NJN01tRGhSdVhXWGs4QnBUZFZTbXJpQVR2R1hzeFByU3IwQ1RsWm8rdXE2?=
 =?utf-8?B?MzVHUWpzbjg5bTVOVFZnSUt3anovcXhPc3ZrNHFCZVkvYTNreEl5eGgyR29I?=
 =?utf-8?B?K1EvRGZER3VIUEVQd1A4d2hiUnJ1RFJMbXZ1azhqZmNMWlZCc0hScXVnM2gx?=
 =?utf-8?B?Uml0TzF4ek4yN2U3SGQyMGt5Zk5iajcwY2E2RzlxYmp0NVRESzFGOFl1VS9n?=
 =?utf-8?B?S2JqUW16UUNQWTNWR1dlR2N5TjM1RWpjQ1ZYMEUvV2lqUlAyWnNUbUpSRWxN?=
 =?utf-8?B?c2NnOUxVcTM4amVDdzVna3FBUzE4L2ZkSE1nSSt3emYycDMzUzVJU3lPcTJB?=
 =?utf-8?B?NkZQZEtpSWdhUHpHOHhCWjFiZDRrV2VRaEVQbjkwQU9mZzYzRTByME1GMjlT?=
 =?utf-8?B?Y25zMkdlenBvZTZIRGZ6SnhYOGNnaHJoVmp6TjFkb3BmZHRtSXlkUkg4NkpM?=
 =?utf-8?B?V2xhTUFQUDUySG0yYk9KOWhKTmtkcWx2TVlqb044WlViZnd0M3ZQcXBUSUNi?=
 =?utf-8?B?cTFqUXpmdDBjc2hicFFjMFNpWFRZK1VSRGNYRnZzWGszWFI0MWZxVjYyVUN1?=
 =?utf-8?B?and0UkI2bm9CSkFqRUdxY213WUluWUEzaUlJZ3ZPbkxiMGQ1dFVqN0RKTlcy?=
 =?utf-8?B?MDd3amJXZHpCb0U2dEtNdVlZb0szNzZWVTBpQ2JNaTBKSjk5c2R1WVRpU1Nr?=
 =?utf-8?B?c0kzbWJ4a0FPUlp3V0IwTXNRRWJocmNOSkw3cHpxNWdram9LMThXNi8zbkJr?=
 =?utf-8?B?by9uZ1BGeElVTnFGQ3l4TDZhbE9QdTV5RUFmZzgyU0pOZzZiWGpQbCt4QmVx?=
 =?utf-8?B?L3NSMmZhejJlQm1GK3hVYmkraDQ0YmJwUTZvaHRCeGptWmlWSDdmUTcxL3Bh?=
 =?utf-8?B?anRKTEJWMUQycUdWZXdja0E5YjdkaFYreVYyTUtBTHoyV2szUndXSUtIek4w?=
 =?utf-8?B?eEl6ZU9BanQ3enpXbjltVWFOaU5rMUFTMWk5QmJka25CVFc5L0g2R2JnR0s3?=
 =?utf-8?B?aTl3TW8xeWpGa3djMVphY2xLOGFHUFlDa3E4Rm1TYmRXcDVjTWNVb3phQXRE?=
 =?utf-8?B?OUFETWYzVFJKdi93OXhKcXl6VW1vVU4wQzhrK0N4ZDhKakZoTWx3c3FRbmVT?=
 =?utf-8?B?ekFMNVBzMU00TG4rcWFuRko0Z2xIQlBXUHUxeGZQODh5OWI1Tm1jMDVkWUM3?=
 =?utf-8?B?TlNIRDRUSzBIcVhiSE84Zjh1ZmlCQWxLNXgrRmxTR3VwVTZSRHBZY0NwN3V5?=
 =?utf-8?B?c0hiSkcxZEg4OFFwY1JlTlcrQy9NNHNaekg5NlB5cjYyTUtZNnlLcUt2RVNQ?=
 =?utf-8?B?MzQ3ckFLVGhHbmFyY3RNd0llcmRhQzM5UjEyY2hrRERXL0s1WFk3R2RoMzZq?=
 =?utf-8?B?eVBlWGYxUWRmVjBveDNzdnk5dy85UjEycDRMY0VuVkZ5UmZHYzVNMnVtY215?=
 =?utf-8?B?Z0tPeVgyT3BsV2d1SWtCcmdBNkJsc2w0czdtdjRwNDFkOG5GdHUzZFh3SW9y?=
 =?utf-8?B?WWc9PQ==?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ae3b1c-4b3c-4627-de03-08dcd0994bd9
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB3933.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 06:33:20.3440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xxeraH8dmqmtCUPGkJM4y+fnznYkVeeX4vkver3X6gMl8qQWrTx91nhNy27l+X0wUTnvzW+HLpNK6KtDZijaErcXlmt+osUANPBG0mcfdIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6473

From: Shawn Shao <shawn.shao@jaguarmicro.com>

The PLDM library is used to implement firmware upgrades,
but the current library functions only support the
`pldmfw_flash_image` function to complete a fixed
process of parsing, sending data to the backend,
and flashing (allowing users to implement custom
logic using `pldmfw_ops`). However, this poses
significant challenges for device vendors using
PLDM for firmware upgrades.
The following scenarios are not supported:
1. Only using the PLDM parsing functions, as the
   current library does not support this operation.
2. The firmware upgrade process differs from this
   fixed flow (the firmware upgrade process may
   vary across different vendors).
	|-> pldmfw_flash_image
		|-> pldm_parse_image
			|-> pldm_parse_header (UUID/revision校验)
			|-> pldm_parse_records
			|-> pldm_parse_components
			-> pldm_verify_header_crc
		|-> pldm_find_matching_record (xxx_match_record)
		|-> pldm_send_package_data (xxx_send_package_data)
		|-> pldm_send_component_tables (xxx_send_package_data)
		|-> pldm_flash_components (xxx_flash_component)
		|-> pldm_finalize_update (xxx_finalize_update)

Signed-off-by: Shawn Shao <shawn.shao@jaguarmicro.com>
---
 include/linux/pldmfw.h | 38 +++++++++++++++++++++++++++++++++++++
 lib/pldmfw/pldmfw.c    | 43 +++++-------------------------------------
 2 files changed, 43 insertions(+), 38 deletions(-)

diff --git a/include/linux/pldmfw.h b/include/linux/pldmfw.h
index 0fc831338226..5058a07a5ea4 100644
--- a/include/linux/pldmfw.h
+++ b/include/linux/pldmfw.h
@@ -130,6 +130,42 @@ struct pldmfw {
 	struct device *dev;
 };
 
+/* pldmfw_priv structure used to store details about the PLDM image file as it is
+ * being validated and processed.
+ */
+struct pldmfw_priv {
+	struct pldmfw *context;
+	const struct firmware *fw;
+
+	/* current offset of firmware image */
+	size_t offset;
+
+	struct list_head records;
+	struct list_head components;
+
+	/* PLDM Firmware Package Header */
+	const struct __pldm_header *header;
+	u16 total_header_size;
+
+	/* length of the component bitmap */
+	u16 component_bitmap_len;
+	u16 bitmap_size;
+
+	/* Start of the component image information */
+	u16 component_count;
+	const u8 *component_start;
+
+	/* Start pf the firmware device id records */
+	const u8 *record_start;
+	u8 record_count;
+
+	/* The CRC at the end of the package header */
+	u32 header_crc;
+
+	struct pldmfw_record *matching_record;
+};
+
+
 bool pldmfw_op_pci_match_record(struct pldmfw *context, struct pldmfw_record *record);
 
 /* Operations invoked by the generic PLDM firmware update engine. Used to
@@ -160,6 +196,8 @@ struct pldmfw_ops {
 	int (*finalize_update)(struct pldmfw *context);
 };
 
+int pldm_parse_image(struct pldmfw_priv *data);
+void pldmfw_free_priv(struct pldmfw_priv *data);
 int pldmfw_flash_image(struct pldmfw *context, const struct firmware *fw);
 
 #endif
diff --git a/lib/pldmfw/pldmfw.c b/lib/pldmfw/pldmfw.c
index 54e1809a38fd..cd1698e9c340 100644
--- a/lib/pldmfw/pldmfw.c
+++ b/lib/pldmfw/pldmfw.c
@@ -14,41 +14,6 @@
 
 #include "pldmfw_private.h"
 
-/* Internal structure used to store details about the PLDM image file as it is
- * being validated and processed.
- */
-struct pldmfw_priv {
-	struct pldmfw *context;
-	const struct firmware *fw;
-
-	/* current offset of firmware image */
-	size_t offset;
-
-	struct list_head records;
-	struct list_head components;
-
-	/* PLDM Firmware Package Header */
-	const struct __pldm_header *header;
-	u16 total_header_size;
-
-	/* length of the component bitmap */
-	u16 component_bitmap_len;
-	u16 bitmap_size;
-
-	/* Start of the component image information */
-	u16 component_count;
-	const u8 *component_start;
-
-	/* Start pf the firmware device id records */
-	const u8 *record_start;
-	u8 record_count;
-
-	/* The CRC at the end of the package header */
-	u32 header_crc;
-
-	struct pldmfw_record *matching_record;
-};
-
 /**
  * pldm_check_fw_space - Verify that the firmware image has space left
  * @data: pointer to private data
@@ -341,6 +306,7 @@ pldm_parse_one_record(struct pldmfw_priv *data,
 		return err;
 
 	record_len = get_unaligned_le16(&__record->record_len);
+	record->device_update_flags = get_unaligned_le32(&__record->device_update_flags);
 	record->package_data_len = get_unaligned_le16(&__record->package_data_len);
 	record->version_len = __record->version_len;
 	record->version_type = __record->version_type;
@@ -540,7 +506,7 @@ static int pldm_verify_header_crc(struct pldmfw_priv *data)
  * Loops through and clears all allocated memory associated with each
  * allocated descriptor, record, and component.
  */
-static void pldmfw_free_priv(struct pldmfw_priv *data)
+void pldmfw_free_priv(struct pldmfw_priv *data)
 {
 	struct pldmfw_component *component, *c_safe;
 	struct pldmfw_record *record, *r_safe;
@@ -566,7 +532,7 @@ static void pldmfw_free_priv(struct pldmfw_priv *data)
 		kfree(record);
 	}
 }
-
+EXPORT_SYMBOL(pldmfw_free_priv);
 /**
  * pldm_parse_image - parse and extract details from PLDM image
  * @data: pointer to private data
@@ -581,7 +547,7 @@ static void pldmfw_free_priv(struct pldmfw_priv *data)
  *
  * Returns: zero on success, or a negative error code on failure.
  */
-static int pldm_parse_image(struct pldmfw_priv *data)
+int pldm_parse_image(struct pldmfw_priv *data)
 {
 	int err;
 
@@ -602,6 +568,7 @@ static int pldm_parse_image(struct pldmfw_priv *data)
 
 	return pldm_verify_header_crc(data);
 }
+EXPORT_SYMBOL(pldm_parse_image);
 
 /* these are u32 so that we can store PCI_ANY_ID */
 struct pldm_pci_record_id {
-- 
2.34.1


