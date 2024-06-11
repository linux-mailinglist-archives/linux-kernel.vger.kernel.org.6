Return-Path: <linux-kernel+bounces-210387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C07790430F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 20:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AB661F22BBC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 18:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924975F870;
	Tue, 11 Jun 2024 18:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K12AloHO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="g+0PS4Ga"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B848959162
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 18:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718128951; cv=fail; b=AIYQrVySA8QFLoebYnTF3MOr/+daYoErFGXIU8J7In/4I9VAOOef7E0KGW5CQ+RA8OCeAnAkO1jpCOkejL32q8xKzQpCn9V8g6FWK2usGy5VaVjkILtwOxUuWyAccBPxbAOnPiV/wm+OOhqDy+SSkZnrFxFRY3OBanNdB82xFo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718128951; c=relaxed/simple;
	bh=icEF52ZBLcxfPutDh/uPC+ieNIWtNDxjQKeUnpxVZ9o=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=c3oJGbs1TfFMaCjvKg/otl5c0leHgDVVUuDE0Vuxvfy/PnsT0P0PY0yySa1iEdAR0Nq9NcfqSo4LoIPL10XqmrAheB7xWmvniFCC5i4MJlOhROX05U0HkFvHAjYq4U2KPwzVmzabE+J3hWvyIc7uH17FtHL26ILsD0xyj/ldHHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=K12AloHO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=g+0PS4Ga; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45BFtBmf011751;
	Tue, 11 Jun 2024 18:02:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=xssR9pF+Epp3EU
	4dzuGiILc3cQF5UCYv07lngULU5fk=; b=K12AloHOqWaif7X5QbyfgeSruIxJGm
	ibrNF6h/mK7KLkTpbgt/ggk2+6hdYdnJ8U9tLlUr4Wx5GoiZOhWtUsn8Ugvnur6O
	bywrtJOj1dh01nIozTQlHQoI8CB9lJ/2x4JrcZTfGHRSP/txmU5EsxfHCBGEGx3w
	7W133mOxuVD0jWZtL8LtWoaRFwMbwalsEHOtOC9sQOBkqIYxR/+TijI5I5ezU1Vf
	UJU7Y3qRtaOXLAXMUUgXGrs7XqPcFc618vVwhCBmnp3Gjk/B/r2e8Z9gfLbyaikE
	/2mbdr+a41fux9rdF4jSfp3yVLyat4tR2ecWlO/t59NeqK3RMhxsKdXw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymhf1depx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jun 2024 18:02:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45BHw49w036562;
	Tue, 11 Jun 2024 18:02:18 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yncdwm7x9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jun 2024 18:02:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ea6bupxxM3zA0NiwKVj3VmKR2NgIKj1h5+RyL7C+ZjRu3bzYSrCwFSW72bGHeTnmjeBmK+HzdgWDzY1Hp0tYZWpPzqJkEUeu8mYHXVF4gr/X+qmirngNleJOJSMoNRIk1IqFSeUNG0/UB2q13+tTH9RVXSFk35QBR6g2K/47CX6aSgRr0YIN+l/6Xhpw6myZv8QgQwr/VJPaaNLqDXJXSyjeTxqYH4pbkFG9ymlm2UVKWPLjtmv0Iu4PCaesNpabyayDUaFNe2RYTq2Wz+mSx2iBKLwoPkMILVETuKrxP4/Y3NHkG6eo5/83lTEejsH9KkyVKFfAmUdvu+A5OgY1uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xssR9pF+Epp3EU4dzuGiILc3cQF5UCYv07lngULU5fk=;
 b=EAxuE+JE9c4MiLSHlSEaQ0d1aIqozN2wSr61I9XLayF8mPGH9KMPRc5qvcUW42xa+SD41Pr0jzs4E8UrO41zJN+vh9puViscg8bVB7bXgxPtCedLSs2KVGc1c62mUxhiyed4Uu7mN/mjdYR6Iv1zYhK4MlW/3oia5kv/viEaiz/Te9H2jT+CmSvTCLOTqvJzihf0VjaJ3cC7xcqQ2Iy6OK7N8g1JUlw3RnrlBiwW838zxk/Hr75ijq7RlZlhqNC+jkEeNKdZF5YWCwQDTczLafUZRROX2hSD14TH0VPr8IoLqYS6onnB2sibjMTF9+QVmDI++t66wnwbvyA1j2Y6iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xssR9pF+Epp3EU4dzuGiILc3cQF5UCYv07lngULU5fk=;
 b=g+0PS4Ga8Tr8vlh5D+DxAHUURlFVwSD3YKxjhujZeJkNn4GnWU9nxaESE2jFB5E2U+FmrxjYS3RqJNWkDtfop21TbOGyKPGoJgYP4zLgQ7dcou6Mm5gE0JSA1YGGEqdeiLcQL+0c0FsKDtBYjymnbrLe0kJxLMlvvEIrYQX5rGg=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH7PR10MB6154.namprd10.prod.outlook.com (2603:10b6:510:1f5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 18:02:12 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7633.037; Tue, 11 Jun 2024
 18:02:12 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 0/8] Avoid MAP_FIXED gap exposure
Date: Tue, 11 Jun 2024 14:01:52 -0400
Message-ID: <20240611180200.711239-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0366.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::11) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH7PR10MB6154:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ad352a3-83d3-4d0a-d840-08dc8a409e70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|1800799016|366008|376006;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Lji04tj67jCAFwQQXxnubln0V3JRqisPplXARTSyJxLfSwUT30i3UYtRUDkp?=
 =?us-ascii?Q?ppcOB0rIuiS62/LWnFkUbnbDe/cvwHS1GPrertv1WrkH5+c6CmoR59rDC3T3?=
 =?us-ascii?Q?SXNEefIAwdreKCXW+3seUq2P8KlnA8tKBdBmqQROBn6Gcnci251PNsuFY5wC?=
 =?us-ascii?Q?fTo1rf/gJp/0o0U3XlKVeVtf1UgZ5eDCIBcrY2PhLympTyn1SsLcjxHtSK0K?=
 =?us-ascii?Q?cEAIKHgmgSwGCt8G1JAoqCHq6+aHPKhqZ8jEdaWuLmsBUT85Jp6wRXhj4eZ+?=
 =?us-ascii?Q?q6UJFxrz3LtYbO1yUoKp2uiY32BpgjrjNk5RS8ZLH94SgVoY98XkkUwwLwUg?=
 =?us-ascii?Q?GwIuS7oKYvoFciCzfwyEpQ7FXlcZU57e72NrsefWTmqfoL1uMjDn0MTZiZcO?=
 =?us-ascii?Q?lAK7ax1seKiPyTnxB/lwtbbAa8H5HYRPBft+ooWr0+jKMMPlSKTzXRylVXvB?=
 =?us-ascii?Q?n8cOPG+w7VmzvgI3l4zjVzdjF52NQnjLI4Tg6FIYnHKIAoX5YBqR9lQsZfpE?=
 =?us-ascii?Q?0NbbocnsqUgnhqjvPJTThaqkj0N7PaKFAWOMnd9bNMvhoFAClapx7Uf20K/S?=
 =?us-ascii?Q?rgvrFrsPjGU5d58pNIbacKWVcsdgJdLN4nnwsY5r19Iwl75/Y/ZPOxnl13SD?=
 =?us-ascii?Q?y3hOMJhj03+0h9vYf2rtySB/0V1lhCIZxeajgr3AAZ/HhPbipC1xatzg7M+U?=
 =?us-ascii?Q?lewHgTQXQjvTmjQcBAOr+FVlzKGY0vyDR5n9EltjnjD9RFcL43M/6zD3PuHB?=
 =?us-ascii?Q?O+7/iBiZvEb6jyX7uPaPppvFTyXRVxwqtK3VD10cWvHbptuHJ8NwAOe+onT0?=
 =?us-ascii?Q?b6AYmtYSNC5b3NcBI5m6o0z5a7utFFyyycf/9Jr8+jycVJsf2h6Sgiwo21Ss?=
 =?us-ascii?Q?ZyiOC+oSBRThAUO87O44RAx5laAOE2WhqFqQXY2FVjgMAof5ClL4idSPrbF/?=
 =?us-ascii?Q?LO/ue3iFd+UiEQxIGOUbiToZ+/hvDXIfQKq1xjiiOl54jlZ9G/i8ea5MxU8K?=
 =?us-ascii?Q?QjguGWDNS7Um86hu+CW2uGJ7sMtPnZ9T6SfxtU2A6M7DdCQ3/zJPu7is8r8b?=
 =?us-ascii?Q?cWN+V5qtg7+Qt6rUM8V0c0jTYBkSy8gkK2ZoR5VBUh648rIgDKgul7js5cLw?=
 =?us-ascii?Q?xKrn/QiO5pP1AsvURmiDIGSRZkwJDkGjpcBZBbtp8CcDEY4/StKkCrzQ0uBB?=
 =?us-ascii?Q?gXepv1R8hsEaC5tDi1h/1ViE/B2kZX+Z1x8PCYSfWhvs5FwKUEEI4DFHH4WL?=
 =?us-ascii?Q?LK1JEgsjrhOCnpmALmArlLor/BL3ycY2c2C7AFDGRENJgKQnUb+eYdyygnDt?=
 =?us-ascii?Q?Qxd3VhV0MlVs+SsASB/hapRf?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(1800799016)(366008)(376006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Ys0u8qXLaJc8iaPaR/x6gBjjcV7KhHlVTi2bLGsNbp0Fil51GtCc+5HMcCjj?=
 =?us-ascii?Q?VkGzAQaCsX3M7+m5Ugqc8lATnMfabTN6TqJc5BO6jFATU2HFpMvoYttd+uJn?=
 =?us-ascii?Q?a8UFqxbSTrRJbz3gZVGFR6qeiNPh+sR0WRhOXZQBF/SbQRDTvmnrn0C4w/wK?=
 =?us-ascii?Q?WCNGKyyTmBf+QjkM89mfssOt3NYN2NB0D/E3MzM5AmARbNZ398MWmRayPuIL?=
 =?us-ascii?Q?0M+f6hUsyT8ZwmzTvRPOoS+nZSKTUz+KJs20J1/W8m7ceACfMxu1LfERWb4X?=
 =?us-ascii?Q?TVFIoUp37jzADO4GkVVuuTLVYVs526R/W8uXKCbhYmTG4Ki0VDoht7Nalfw5?=
 =?us-ascii?Q?McACLtKftSbSuGaf9Ft0QIR5dwNwY1LXXXVOErqqkrWVKKaGdl0wfQBrww+v?=
 =?us-ascii?Q?XSg5AR59Eo0AWRUqoMtFOfUY+6Pud0RRBybiBaJgueQii28Buc4WtUkrqLBn?=
 =?us-ascii?Q?L9FWY3BjR0erfkP1sX/ehuSb0Vu4UOq3S/5o8vsRPCkttTlyUkSSmcPLG30c?=
 =?us-ascii?Q?Vk8lUVYm8XV2CPHrithyqWum5XmlT1S4ErYzOSYf9xgxvd3Fcn6E3rt859eg?=
 =?us-ascii?Q?2xgLaehzMvIieN7RDx3orGlfYnaC2+/6Z0R5pemfXRMCneC0YeiHBSRkA7+p?=
 =?us-ascii?Q?b1ZVa8CJ4om/haj8haTLzVbuKm6SG0vQBNDzX/qsp3cuqUD68ReaHncD1oc2?=
 =?us-ascii?Q?5+ANiwZhNdq987M+9ILiHp2nH7dlqrixDQEuHaI87o4PautcXlbRQ2fuhGZT?=
 =?us-ascii?Q?pR+QeS3N6JXEqz4DoJJOmxaTev0zLKtdlg2ob/Rn9yj0AG9oNqljbh5b4EpP?=
 =?us-ascii?Q?kscJD1ZsK706w2opQR8mY8/WytHiVHfLNn/WS/JK1sT1O6HuMRk4+E87IDzA?=
 =?us-ascii?Q?uMeZaoylmM/mX970eWaRf4HM+cCliFtR/JZL+mJ+rthV5YWsyjp3KitN/Z80?=
 =?us-ascii?Q?KpNqkWVJUJSlzCHjS9HOUAVoEaa8h0wrJFH2n1GqFkbd77u0L+ayhlwhYFm8?=
 =?us-ascii?Q?2eFXpYT33XaIHzuwW8cEor90OWPDDPpqH8Sz+CFPJlJG8xvH/PRKYFdbtomb?=
 =?us-ascii?Q?Fr8IcL8Q5kYa+GHzXPHuv3h63Bd8HSVzCvIAyY0wW2/D3ev0orcK7DEqbtkZ?=
 =?us-ascii?Q?Ijh+omph9A1b73FAJ/m0mYZp1XQff66DpDpZVgHEvWts4MRyNmQikzQwn54n?=
 =?us-ascii?Q?kw8VHMiudzylxv20seDlVhPGNiGTnYXXaZ3j/S060sJvLManGkSGGCPoXDkI?=
 =?us-ascii?Q?Reto5prtisAIlpw48ywcVC+ZNQXZy8xKRKhC5KfbganjUptW9C8Io6diapXE?=
 =?us-ascii?Q?YdDYIg+V9+mPR15ft85gfeX+WZd1BgGhSJpJ46O2AGo9hQIxQs8Yos5LS1IO?=
 =?us-ascii?Q?yW0/JSEsozR3tEneCxJIaAZe9p/F1yFK042A0JfVrlvCqEGVHIqAnLHzTw98?=
 =?us-ascii?Q?iWhzDUNTyFZj5kdMiRkRU/VDMP2mD2eOTxzy27mHjTcFS8aKaKMU7MKv6lz/?=
 =?us-ascii?Q?N1m3TBXr1zXp7nzeLH3W2RMSWVoZJxKL+wtbDERIQkQYyp67LhtfFNnX88dg?=
 =?us-ascii?Q?mb1IcXBSkTVRSWB18hqcMV0oF8YpYpL/kxUa2HUa?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	O2iUZDrUSqoadf2vEQ2c9+cMS5WfhnCXVVMSZmEdg+SzMLyUr4M/ToVNgvQL+ucEae1Xpq1nQ1ER4bTJy3aAcRsMWBIP3ivs63vU5YqsUvS91bUJ8DPGBH4qcI9vBW7bw5h7uDQIT+3n5kJUOC9cxyGBU2mJIga4rmKYPHis6g5G7DbKfwqpp23jRXk0+3z7gW9WR1Q4QtxLDbQf/J/428G/X+O28cVdMf6iLBLIuC2CTEqDCeOYcsKNl1VYib1pfSPmyo5/muihegtCz5TVtuNJ9jz/nJG7ZPL574sEYOQmnF8uNc+364CkbK19KBtcJ7OMeJOkLiHgILjzNiUxpaA4anQv1iKp+neafqwtgVZuT4TEWvP4LdsvZ4ZyOrMzZr0eRF5sNDMmJMdtIDRzxYOdWAIOKgDkGZ8fh6sLFcr0lgTN4vzMReMspIGGOWQRayfLnlqjRJjsQJtn2/oCA3FRNRCbnZvco8N9Ux/jzNK01HW/do5blTdWPmo+3+3lVIcFpRg+WPxu8zZFhc9ePVtXz5EjF8MPBnjinUe2HDhY+noBd3+kUcCu5vyO9uJrKwQ9m8lcVw8wPi22wLmAcXu/SE5p8JbHRUAiqFRiAek=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad352a3-83d3-4d0a-d840-08dc8a409e70
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 18:02:12.1564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BD/UoemPrRqFXoX7eWYIR2JSiOkmsaEWbTZf58nG2wMhEcYjL4ptzwR+e7hLAGBtdIs4gxAtxk/TxGwHmydicw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6154
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_09,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 mlxlogscore=920 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406110123
X-Proofpoint-ORIG-GUID: HCkbwLsS4uWeTtarT9W2oJvBZUvLI9Xo
X-Proofpoint-GUID: HCkbwLsS4uWeTtarT9W2oJvBZUvLI9Xo

It is now possible to walk the vma tree using the rcu read locks and is
beneficial to do so to reduce lock contention.  Doing so while a
MAP_FIXED mapping is executing means that a reader may see a gap in the
vma tree that should never logically exist - and does not when using the
mmap lock in read mode.  The temporal gap exists because mmap_region()
calls munmap() prior to installing the new mapping.

This patch set stops rcu readers from seeing the temporal gap by
splitting up the munmap() function into two parts.  The first part
prepares the vma tree for modifications by doing the necessary splits
and tracks the vmas marked for removal in a side tree.  The second part
completes the munmapping of the vmas after the vma tree has been
overwritten (either by a MAP_FIXED replacement vma or by a NULL in the
munmap() case).

Please note that rcu walkers will still be able to see a temporary state
of split vmas that may be in the process of being removed, but the
temporal gap will not be exposed.  vma_start_write() are called on both
parts of the split vma, so this state is detectable.

RFC: https://lore.kernel.org/linux-mm/20240531163217.1584450-1-Liam.Howlett@oracle.com/

Changes since RFC:
- Fixed comment on __split_vma() - Thanks Lorenzo & Suren
- Split out abort & complete stages of munmap_vmas() to reduce
  complexity of review - Thanks Suren
- Correct accidental removal of validate_mm() and split the extraction
  of the validate_mm() to its own patch - Thanks Suren
- Fixed merge error in comments - Thanks Lorenzo
- Added reviewers, but I didn't add Suren's review of patch 2 as it
  significantly changed into 3 patches to make reviewing easier as he
  suggested.


Liam R. Howlett (8):
  mm/mmap: Correctly position vma_iterator in __split_vma()
  mm/mmap: Introduce abort_munmap_vmas()
  mm/mmap: Introduce vmi_complete_munmap_vmas()
  mm/mmap: Extract the gathering of vmas from do_vmi_align_munmap()
  mm/mmap: Introduce vma_munmap_struct for use in munmap operations
  mm/mmap: Change munmap to use vma_munmap_struct() for accounting and
    surrounding vmas
  mm/mmap: Extract validate_mm() from vma_complete()
  mm/mmap: Use split munmap calls for MAP_FIXED

 mm/internal.h |  22 +++
 mm/mmap.c     | 399 +++++++++++++++++++++++++++++++-------------------
 2 files changed, 270 insertions(+), 151 deletions(-)

-- 
2.43.0


