Return-Path: <linux-kernel+bounces-220173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A223B90DDC1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 22:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35834281392
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 20:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325F8185E79;
	Tue, 18 Jun 2024 20:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LG28IOwN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="evrLFT/Q"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962C917838C
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 20:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718743729; cv=fail; b=XUGmsWA6ly3fF3t7vpWoOxw81FC2n020r9bMEjemvz2fTTGt8Qpj7HzQkodCATNnG5EDsX2o6s/XhvOt6U2OmrqLJDeQjHFTVXMeRGWV/DJeOO/BRhCu+s87WKH6cgt4GiY7zX/Pgq9/vAmMGu9BXjewg1mn40ZzgqZXywb3UcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718743729; c=relaxed/simple;
	bh=lDABn5SjPNrxUvSQc3A2HvzKzQmvC0N4sLlSBKKZ130=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eBQkqxyJLoOtikmokNQ9aF9DrgTPnce1TbOjZklx7FpUm0fkaqZEhvobyFQ8vDr5H4VvjjWWmelu3Jmrn1eChuXdgh0sBSwdsUTMBtV/2Vw9yQYY/kIkhz3EnCZRFzngzFaRf1MDASNobtcJskntIobn6rodyEF20Xgy/29hLxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LG28IOwN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=evrLFT/Q; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IIUvXo031029;
	Tue, 18 Jun 2024 20:48:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=LbRUqzQTGgReNrj5x/34j4uZL7gNsaS8wJAQGdq1eJ8=; b=
	LG28IOwNvtanZ1cDEcuoYeIe8O6j0ck0/OQ+0htS31vV5zXUO/jaK54/RG5veioB
	TAjhlNiYE6Q4xW5viRPCUarOYSqHifuqaxomdlQdBZsJSsUkWupmkvEs7rZ5N3t0
	AbJFWgDYBViix+u8idLu5B74STWO/0HnXgnprRZmqTqNi4Sg0Kydp0V7ECertFsH
	i3o/VI8O3pA/voe6H8okZf0oEPdM++ZrHZh0Vac3ZJTMGMoa9MGbz4T36OiPmLd/
	6aEN3VgY0vg86lCONOFEIfLBDWvq4Wj1gyvXZFNL1EPttfbXxQ4fSLQP54LoPrB3
	sDq8xIE+PU7b6t5L/Usv7Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ys1r1wv5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 20:48:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45IJeuRa034707;
	Tue, 18 Jun 2024 20:48:32 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1d8p6p6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 20:48:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XitMcOMmsicDpt3zuKl+5cGFKyo9i2kbFB5H5xF/zIVabUinvqpPmuMj/Frnvw4bAcWJWc/apKn6pZDZrAxXDLGweP6ja+xFgkYW4XG5+7UE2kR5G8gHNzWIBEzSlL30tYWsXmVL9Pl4ZvfPhbIp49VFqYgatjj68L0HgFxE4gVTn3LSq0TEcIpyH93MylaVA5ltJrni0VV5jq8tcXnpgnklme/DJiQbK+UKsFdGiQJ4G6pgHK+ZWAaTo0B42am0tbBcQ5sDGxq16KaqHBzOHUpIKdo31/cclC7mhPSmzDYx+OBZ7g7Avj9tELXCSAfEZjmk9znnrIEalMtu0n9vmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LbRUqzQTGgReNrj5x/34j4uZL7gNsaS8wJAQGdq1eJ8=;
 b=HUjfKRTjHwdHnMhcRtmYc5wlVXVRe8kmS2EDXASOcHC/JDiNaV/qRsz/v5hvQRiogkF9ihCgz7X5TovhygHS2vaDudwvd820ETn0vbJg1RUeA3dGesLmy57RW2i6bK6NEcoIeTcwT/v9goxZapb4uhw8aZrcN9wrzuTogVBegi47u6Vls85tVFVfj6t+53+CbhGqi5z6BiJZt1+BUHA5mz8ZQNzIio8+q6eAwbqC84iYMtvc6prqRAJDHnNpbPH+y4+W6tPyK3v2q/iEHE65ajDiWj27Bl2nik7AuXmho04vBXsH0IFJLFXz4D/P0enatAQXF5sCzn4AcEMXy4Z4Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LbRUqzQTGgReNrj5x/34j4uZL7gNsaS8wJAQGdq1eJ8=;
 b=evrLFT/QQ4wgA8Xe298f0KDEb6CtM/Qjp6qFzzSOa49QxcErL3iBjAYBF1QuzRM3jGgna3jxcusmadSQQgm4IaGe60TZLZmSxJIo749Fi2rgJ/14Igy6Dzi/0p6/jWmMPvq8Ij50qqNueRR/LnLVdDCC24JqG8Mq08fhAVRx9Aw=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SJ0PR10MB5785.namprd10.prod.outlook.com (2603:10b6:a03:3d1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Tue, 18 Jun
 2024 20:48:03 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%7]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 20:48:02 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v3 01/16] maple_tree: introduce store_type enum
Date: Tue, 18 Jun 2024 13:47:35 -0700
Message-ID: <20240618204750.79512-2-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618204750.79512-1-sidhartha.kumar@oracle.com>
References: <20240618204750.79512-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0022.namprd07.prod.outlook.com
 (2603:10b6:a03:505::24) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SJ0PR10MB5785:EE_
X-MS-Office365-Filtering-Correlation-Id: ce288bba-b268-492c-7ccd-08dc8fd7f1af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?9eFr2xSLjSLDKDbZtjApfosPHxZnqIdGvmBhkiz4+By5q0JgHpyLSv2RNw8a?=
 =?us-ascii?Q?4RMgGFII0tEO0HFm3Ah5uUxHYrAm/p5ngqsKFNJY6OjfXp0JkEo5g4Z3vHOQ?=
 =?us-ascii?Q?OBbbh6W8iT04HSjKI0bRbFfKH9MKyh6mv6vCnC4JHe5H4c+AyLYXjD7RoOYp?=
 =?us-ascii?Q?+XkAnnQadmekeog+BNgkJ02rNU+1tGp0f+w/Qpevo/cQLzFvHHosK4iEGwU7?=
 =?us-ascii?Q?NoyccD8OMeScE+AxDXXDfqQV4LCx+8py/938YygmVZZFw+4aCWRLASgtjIJ7?=
 =?us-ascii?Q?wCrXcTScYKpNfgkB46cHZ9ZnNRw+hiHjx7iJpTRJ7e2o81XHKgmauE3Z5Rqx?=
 =?us-ascii?Q?FBnPQzvOjN+CdSeTn0Cg5TMb4iZW0GKN3MGYYqjnuLn5r73CeDxuUcJsKEVR?=
 =?us-ascii?Q?9iirAm/u/vw3xjfvzefLD4sTEU4MMxrapG6AI3WIjeTUBgtJRGvBkh2EDb9w?=
 =?us-ascii?Q?gTH0w3xUuAx6jUlblOAeO9qzdmLiY9jCz6Gnz4JwtrErpS/uOQk4QlOricXi?=
 =?us-ascii?Q?ubWEULIDWoSnaNRndbxw5SPvHYsrfZslRXjQ99EgXt0IyHuEL3paQFBXjqVc?=
 =?us-ascii?Q?s5lt98XBhRlTCzCuw5E/o9alQstu7Tt2GkDnVxM7CIuu9cD1o/4rBP4DXId3?=
 =?us-ascii?Q?7zd5yP547IdkaAL406PLlpQBppzqslWxFRRiCDyeXU6v2iMH1FVmSxu1xBAd?=
 =?us-ascii?Q?4a0I8d+yKplmJ2KdlGJwJFksRASQP1AGGmBKRJDfxlPC9XkpgxvGqHc8gwSc?=
 =?us-ascii?Q?IpLnfNdfTP/aeklu5Gw5kYGHaELMpRjgt+ZYiw+E01UwsiSNchF2fz256hoA?=
 =?us-ascii?Q?i0WsQWEMt5rYs6buRFIYiGX6y1PdfFChj2+dBXwX7mX29wKCHszZjjYKjCv4?=
 =?us-ascii?Q?9DKBWMP2sOC6nnltbrcb4dwZla5W3xanbrTLhBVwnYaEcfLSG7ApIy23Yrxu?=
 =?us-ascii?Q?IjCAi8HqQ30EQXvIypmoR35X9MADVw3qEvo6err+M+qFRLux1323804VEcPJ?=
 =?us-ascii?Q?aQrR25AnTb0NWXSjkShew2we1aE1uyAOLHuuA+NCZMMQwfNrSsndafpnEtXi?=
 =?us-ascii?Q?Fw5MG14QmIrpBI5YRckVcO6iVouFpqNAAmTDQC7bYmBai++5PPf41csIT0JA?=
 =?us-ascii?Q?dR29Yl4iJdPwuyxdpDUK53G0ss0p+qNfyaay6k9hrRMo2AacsF/CS8U0YxU/?=
 =?us-ascii?Q?WfjvollzMHiq0G2zkRIxn291mZR5TbofyyAXGISHY39b5mxoiOBaGyvLWT/V?=
 =?us-ascii?Q?VvImmQmPerQhTiPRn3QIZ1srOBqjTRA6Lk2+GXuwUacNn5EiRcxVv3PTll73?=
 =?us-ascii?Q?dsQpUToxALlIcCyJkXmciHdN?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?fpYGvxNs/IRJMovVuUQWxHM6zasBIhvIamID47qyNlkdUyyaNKyXvvMGZfqY?=
 =?us-ascii?Q?c3gSQRZWo3oUOGEEH/d5zPczcHCcGg+NFbTVerIJCTQwfAT1+97KUI4TsmYc?=
 =?us-ascii?Q?nqB31xsNB261EvjXRCOgm8HNwojWkYSZFhxa4RJIknQxaPBiJEDEq8KyRidV?=
 =?us-ascii?Q?UlgEE/U9wsiTZXPEL4lRduQ+oKSWS/Xv+c9KL04EfOKMMVm1fSV2KQfp+f8F?=
 =?us-ascii?Q?Oy4AAk+MMYyDoX6FquAFeukmYI2kFPcrggsgRtwWr6Wq2Jx/C5wVXJHi5q/B?=
 =?us-ascii?Q?9qCfWEBxG5jngwGm11CNJn1q4OEXPBeXyCxmOpaWLNBzWZ4Vpm9dOeLbPSeR?=
 =?us-ascii?Q?6jV4RsLbXMI4OzUWbqZmk1Ig4i+vpnA2RwMEevcUeyl3m+40OpZ8ePFn+j0/?=
 =?us-ascii?Q?LJACrOqOot1D0reQpzhvUue6i2osVECRuJtHQc6SzCOnDT4b3bU+w6mfxPjT?=
 =?us-ascii?Q?gAuzTnI6HHyfeANohdOBWIKyUrNbfdi+Cpvn0cso+6f6lIg/QzWfjYzDlofP?=
 =?us-ascii?Q?UZYX8Qi8Y3z7c675xuyJyPnDwiScfU6b6uxV3YiwPCcTHj9OibjMuX8z5zrr?=
 =?us-ascii?Q?L0m4P9t0MThEFx5m3zymzTVvadMddWSSx890D85J+1YCEDLafpKDEt2e+KNS?=
 =?us-ascii?Q?scsecd/jmKWmiqflUFLWyXbFadj8bL8nz2LjQQBn0c0CFMZB7fi2svobM1Zf?=
 =?us-ascii?Q?SVJNUOG0nch0v0vUyGnp9V3SHskqqvXrH7jLZaC2TleVG05lYfm/TDUxAp9a?=
 =?us-ascii?Q?pk9H3gl7D/BGoTxE57bBE0I0uEuPCKUJSpZT2J7GOZfk0T+xTVefMNbUhUuS?=
 =?us-ascii?Q?BjlW6JvHLNrkzMtTBnCR2dxOeIaWyP4x+M4eI3npzIwHQ8DxS5KA3uFIjXP9?=
 =?us-ascii?Q?ZBVoq7ds/7NYVzU6dlGMclr+43Y8yyljo6I6lAX8/hY5VrEcrTQlXwksefAh?=
 =?us-ascii?Q?0wv6iMoLo9tMp5YrY+FbGO3pjg4Gka692ps+s25hSXSDBbmqRpqQZyUQYvSJ?=
 =?us-ascii?Q?RhYoVBvtGkaoJtFdHO0Ef7efPgMMLFiQACGlLvPXDBrOzgeADnP4fzJYJCJ7?=
 =?us-ascii?Q?Ivk80uuHlaZWvBxi8ZPiKOBKNcUa246nqGtBMoT156qQr+nNQzphzAmVA8Ya?=
 =?us-ascii?Q?A5NGTcCiFImNiaUUsXod1memKfimpikBWwJnEVKDibOxcJcAdv57aig0oG1I?=
 =?us-ascii?Q?7ANQ3cIzkP6ayyr1+XUZhAn2PUb0lmG+s1vvwE1cyW9gZZKyrYh/HEVHPAyq?=
 =?us-ascii?Q?jr5z7RppVRsYhtw62gktpKG/KaXQPQNJbHCv9vgKecBWCsWv3Map0iUIQ+uZ?=
 =?us-ascii?Q?VEjiFI7KakN61vrCa0Zme62oBFkZ5uAFzdFC+Rn/ZlU+HKSAUiZNcGO3EZ0I?=
 =?us-ascii?Q?XzpHfz+vOc3s0HrFSqlrNyDhdwQSvBqNfdKVoWOkGgS4WPh6I8aBtE4vIeLU?=
 =?us-ascii?Q?aXYITbiK0E99XxLxRTkmLgx9zP6ktNvKysy9o0chyzZFqkiUH6DGgfdV2+/M?=
 =?us-ascii?Q?eWvUWXrBT12uM6Po+hPjzhCyQiCxDh0x6fFbbxhYpg98+h+TUu6+f5RI/xBb?=
 =?us-ascii?Q?beASzzhRkskMMIPkf8+cJ5FVNs6vK/yr/3SVdgrxguHjkuSEEtVknac/RBYG?=
 =?us-ascii?Q?Ycap+9wyA/+RkHzBsalajZk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	KpzrI9q11L1RKolXZbmGHvdUrB9FDKFqw5xkQo+34Irv9gbCI8BMW796ax5ktTe39hNrpe15bwtLHa7FCWBnM9yU8/tiA9jjBQGEQKZvzmhVVinAEwKje655/uitfSHke0mw3kxH8kXmT5i0/nzDFKtW9pD8Zhi+KTu/lC51JzMvSa2sAzbmcrQAQw4iuJRH25HaZhv3aTPpIoX+idI8dFaTjM1bJ7OOsei0ch/gc5Pdi3AoEnU72cijmt60ZzMaDKMgYXHUFsOeS21c8pmiN7FpZewEByVagHn3+o/ak0+RTjAtmZ6Lw7j/8zVxiqE/rO1kiUYGVqSw4GdTT034umpgw93pVWT0VgE2MUSLFDUEro2bPXUDnQrIccjtG9vbKjB1iOO3JqPS06vdlNmFZ7dJ36HmRA08I74Z/llAyzwwDdTWWhghWgAqRtsW5/HKIxdA8WVf7Z9oMLq0qPgNyrwM2jeLTtvDKEKL4BzUE/q8y+bgSPdtYlq91OMlaishlASyjRovdcF6Hf6ofgzv6EGTbIB3tyCmyKPNMDDa6wUO3W5yrrTn/xdLcs/59LdK+XtVCtebXh1C7E1J5xIRP3NXf1z2MZGNdVe+shNVsaE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce288bba-b268-492c-7ccd-08dc8fd7f1af
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 20:48:01.7399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ohGhTwhHMiyBe1GRDOLHNeHhdDMEB3UabD+J+DCkrDNMsrzMtYpvr4YMPDYKzbHst6rhbQWr2eMAZ4DVGQaDVEEEPi2Wrhw3J2oQGl6+UMI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5785
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_04,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406180153
X-Proofpoint-ORIG-GUID: 3yFq5Vu16nJxACEtrwUJTe3hk2Cv30ek
X-Proofpoint-GUID: 3yFq5Vu16nJxACEtrwUJTe3hk2Cv30ek

Add a store_type enum that is stored in ma_state. This will be used to
keep track of partial walks of the tree so that subsequent walks can
pick up where a previous walk left off.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 include/linux/maple_tree.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index a53ad4dabd7e..2a2abda9eb32 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -148,6 +148,19 @@ enum maple_type {
 	maple_arange_64,
 };
 
+enum store_type {
+	wr_invalid,
+	wr_new_root,
+	wr_store_root,
+	wr_exact_fit,
+	wr_spanning_store,
+	wr_split_store,
+	wr_rebalance,
+	wr_append,
+	wr_node_store,
+	wr_slot_store,
+	wr_bnode
+};
 
 /**
  * DOC: Maple tree flags
@@ -436,6 +449,7 @@ struct ma_state {
 	unsigned char offset;
 	unsigned char mas_flags;
 	unsigned char end;		/* The end of the node */
+	enum store_type store_type;	/* The type of store needed for this operation */
 };
 
 struct ma_wr_state {
@@ -477,6 +491,7 @@ struct ma_wr_state {
 		.max = ULONG_MAX,					\
 		.alloc = NULL,						\
 		.mas_flags = 0,						\
+		.store_type = wr_invalid,				\
 	}
 
 #define MA_WR_STATE(name, ma_state, wr_entry)				\
-- 
2.45.2


