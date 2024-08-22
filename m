Return-Path: <linux-kernel+bounces-297888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D10295BEDA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 21:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 508CE2849B3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AE61D1F6E;
	Thu, 22 Aug 2024 19:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AWYXOXwt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uSMO7MVO"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16BE1D1746
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 19:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724354819; cv=fail; b=niGlzNTIfxXpu5UwQooLUjhFWoVoR1qgrya8kJ8UfLO3L+gooKdCpDgoqIEJqUyR21Eprjn2axkPoE5SSDhKdG5mTiBbiTY4YJac/HSFKGgGTqOes3oUqPcxir0quzKv+2WMq5wliyZckoCBGQhNLXwKSOBEdd/xkg8v9HFM3aQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724354819; c=relaxed/simple;
	bh=ncxLoHOYvKhD9p0Uw7yzZOrTBl6n+t9XSLekvMBO7L8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ej79r4vzfV9fQ4shCUp8K1RuDFU54IAJxSWYCfjZv36ROxB+TlQDlDKrMPdyMACgJAVLNeXatRkD6YL0Ml6BEYjpX7q5k8nYEQmEwKZSwnCAs6hxaNzFpG2B6v16XQDP9bWBPndH28IF7Tm1ZlowhnwxOROCQygtRsWbQlWs/40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AWYXOXwt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uSMO7MVO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47MIMWZZ026341;
	Thu, 22 Aug 2024 19:26:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=3MlH+o+RVXMOs3uRNnBWOsfwouftTpxW+3+Yfxn9fgw=; b=
	AWYXOXwtcwa/oPvCiQWRg7oPYBPF5QX2rb2x12UPjET1DPQPE6tI2H9J0T/mrj6c
	3H5y0jXlShWrNqdQNz4JBQkf8EiTtkFOp/tn1GMnqO4I2aNbvUEYdpLjlY0neyTZ
	SQWceC3+lS5eNhR5TPs0CDKKxaNJtGMxNDYrL2B6FSlwQ90P7O+2clF1JYFE1jLw
	g7IWygBwoskfQmJgYANaX90hEvFmEzHWzvNUadOTUS6KTZjC1fBOO7tTlhGd90f7
	aBrBqpHYJhR3DcmK2B4SBW+MFNs3oa5877aowBcCCExO/KVrV31TVuUDIPdNT0qt
	NtLDLuVaTxFh0BjkRLm+WQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m4v2wa2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 19:26:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47MJJGAK028263;
	Thu, 22 Aug 2024 19:26:43 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 416bct87sx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 19:26:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=plmq3VUVrJRCD8HI0Ty1JLfa2jrog+NTZIpo9qEUpMsSFwQOQTxH++T4RWpYhzLA2RQhWuE2f+kWpaCZ5oxDl1brUs7ZPqQRDlgk3iNEphNGvPwyK6M1K6Iy7QSEkCag/RstKHXN6OnIId2V+VkkDzjyM3zCHm9i+cAs2zWjTLX9cnC6SJUbJGwDo5QBWJ1K9kZkDTq48PxYP6CxD3G/3h+8q/pEXIKdNsQuv396YkcrZ7qgS+O98zth3rqDZb01VTUMktZzO1h83CkqThdDFD+nTZ5GS5eGpuTA0nfJPhrwiAoDoJZAJ4wx3YCy+By0z2a5TabPOYZXdrf5eSvguA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3MlH+o+RVXMOs3uRNnBWOsfwouftTpxW+3+Yfxn9fgw=;
 b=tK+hCrVZ9ik0DVkxBDcIA7BeCwzDwyJBX8zzSf7sPiYAlz+CsHSH0h4uAgMqkoNSLYdzk9yuUI5s2JYVqYGmWnNrXC/9ycO8ztDChQIuNjI0TlMYCUG2aB5zRQrLQWj6r4k67HCYPrcTZqkT2vvV+W0DXytqX9yMUkL5H6mGkjdeCR6RR4Ez6BPyLR5xHEc9UU7lrLqZTAgbcVygkI2fm+Yse36UpIsWmOdIbljclKP3UwVlokAYYV3fKSAkqKt16lVIzg5ar6ldFtdCJ6R7NeaybNKbMzK9lzVtiMok3PKuTcL+fsDz/nZmsoQGcvsJnEVrcQwok0hFq6Q5OdRV3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MlH+o+RVXMOs3uRNnBWOsfwouftTpxW+3+Yfxn9fgw=;
 b=uSMO7MVOAYf1FGZNGPiiB/lbHpRnPlKaTfhIwJqlxrRjKhIdikWmcM16XiD6Lri+fbcOYAZ6sRykPFSqWobdpxV+//HhQovJdSkjQP5FWyvsOxEl62pRokpgZZ9WsRVmiB+tkMEmXvneT8tfl/6yFPnlWnSWOsFOoIPeoH0GB2M=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH3PR10MB7761.namprd10.prod.outlook.com (2603:10b6:610:1bc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Thu, 22 Aug
 2024 19:26:38 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 19:26:38 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v7 15/21] mm: Change failure of MAP_FIXED to restoring the gap on failure
Date: Thu, 22 Aug 2024 15:25:37 -0400
Message-ID: <20240822192543.3359552-16-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240822192543.3359552-1-Liam.Howlett@oracle.com>
References: <20240822192543.3359552-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0045.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::13) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH3PR10MB7761:EE_
X-MS-Office365-Filtering-Correlation-Id: 57581fdd-0d88-45fa-21cc-08dcc2e05795
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CpCtepK9bkSLT3PwkCq7o7yb3+mxs7b+XxMfGtT42wy6SqexosZEbf4Pr2Sc?=
 =?us-ascii?Q?HD5LbA1luF7MHno5mEdfSXCF2CRtjrrlNf7Zzpr+w3JgfkJ6kSyTMEfaJ2Cc?=
 =?us-ascii?Q?EYIpqtBfCaq7MGgxybj/vBe4b238HdfoiMDqY8WaYqTnYdxcj1QJynfjzCp6?=
 =?us-ascii?Q?0vRkb4h06Sa+MziYrNTy3Atouk3pNCXmRaKpnp3bDB4Vc3NRXroqWrM7BuLJ?=
 =?us-ascii?Q?MMobyC6zK/4h1AJv+6zBB6e2kg/AUdmVxXhxuDX/5mIQJ0nozlCpBzaslvfK?=
 =?us-ascii?Q?sJp7QYpLAVV2No3rea5HFvDH6+ViPUdw4A37zuiWikCUNzi6R1inEEh2hvjK?=
 =?us-ascii?Q?osRtANfRYtooRmLRRfFUK5To6We+YIRpk8kHbX09s5l0C9sYRCSYRtbxFeWi?=
 =?us-ascii?Q?PWYhal9HojR2NlLtw/TAhc8CrgsUl4sFXQ7RCIXOBNIVaZIqhfM/v3hOjA6z?=
 =?us-ascii?Q?vxlmwgNP6N1lGDXbmKQNefWbXQR1OvlnjzKciprXy2EflPmjpurMX+VAMFVc?=
 =?us-ascii?Q?9kmX2Nn8tyRvNw7qFMKVH1MrBNWqemOKdcQ5vOUuTymHIZjjmtYF24ByuP+I?=
 =?us-ascii?Q?zR8YcVDECMXbSXXBcHmRkSP0Aa8t9ekFh7kqS1omVBCK/Mw7Ib0yoe+eopFr?=
 =?us-ascii?Q?FjVxRAHSZ/YirFnhb6to7CE+aVhFTe5dvAujn90uuwXUtvEjOx8kIrTmid1M?=
 =?us-ascii?Q?geeV2jBogZsC/vbVUO1UhzfVCGy7jYGRl/aECWwmdUubStYecuLzcLa52ccN?=
 =?us-ascii?Q?X2XmG75mSIdPS44oeCJoC+ShJa2Mvf33b+aoV0l8RFeKddTAfBNuxsI5h6mo?=
 =?us-ascii?Q?oStKR8YnuRaD5EYn3U5KMdlUMIg2XMybONr1qsBggKnCHG2P5lM8weRQK+ph?=
 =?us-ascii?Q?AK6J8dnQ5IUPeTYpVBheTvAtHUQpyws8kC3NZ5Gcn0EAr8aOhYF68yEvfEE3?=
 =?us-ascii?Q?v6Z5Rshmoh9Pj5zjg0/TkXTD/BJthU2aFxHfCq+TAriZCbjik+20feoWL5u/?=
 =?us-ascii?Q?4+hV8D/BH1lxqizo1rcf1gov5tGInnxhbwc7gGrYLHC+0EaMaw/EI0yXjx9a?=
 =?us-ascii?Q?6h8tydRoYHDXA3IC1hP/8rHX6Ue+KnoQIU6zxLkerRnGyb8AvM2+fg4vWUwC?=
 =?us-ascii?Q?EB4brfgpiOVAqYqydA3wFhZ8xX2SILqLUvapprIrSyu9d1MnyDX7RVCVS0wF?=
 =?us-ascii?Q?DCbI1rBqSe0JZC3jzQBwaK/5/dPd8aE+I24wJe+pUEOzTNwsmiZAAB1AQeWP?=
 =?us-ascii?Q?k/a5+TVYbv3A9VciPTg/lMTOisYs5CJJ0J/iqLflSa8Krqe0FF2xpiY4Xelw?=
 =?us-ascii?Q?np0D6UB0PkgeU3uKR0sp/hMgGxFY4axL0vU2jks/8ODBDg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OU8q14i5FdYt8lsuES22JZX38MDgXIaGT8v+ahiIzjn/5kNTYnT+rJbTwZGg?=
 =?us-ascii?Q?XlZfgXMtv4so4J12jIl05bWFBPX4s0eRzqkDeBswLqcYB4pgCG4liQ3LqjBX?=
 =?us-ascii?Q?nw7cH5y4nVxzfSdbmdWH6lFC1vtUr9pB70wMG/yzI6ytE1SOfaxX0mUh6BFi?=
 =?us-ascii?Q?9itYt67b3I9SHE0Qfnjtycv5y1cRznnyT3dtLkavEauTE1lM+ShxJGs56WO8?=
 =?us-ascii?Q?ShPMZ94rzpNQzERhA6GRTqQj5esjcuCDdaAxoQHs5RYpKpCBkBD5JLmi+Jdh?=
 =?us-ascii?Q?wQ4a8c1zByFa/CG8rCtkAdjHoTlSy/n/IWOi0hj3L2/SPYGa/LYGrD1RI5ks?=
 =?us-ascii?Q?DT8AcoCfyTDf7fDCeITDKdZZOOpOgz23v5BgyzkZTGZAwbbY5Sa5eNmtf/cs?=
 =?us-ascii?Q?2SCpnbQogiduNbL+aNEEbvfGi+Qir4RjFED1YGFJz9z1tGzcyopqD5Put3Eo?=
 =?us-ascii?Q?Jjjf7p0jMD/E16OF9jqsLof7GDIDaYBJVtqTbuEP7PiSouSbhMgCJsFex0aM?=
 =?us-ascii?Q?UsERdyFOplVp9EWeddVptBi4vfbFOgshIydUg6FaNFrXyrtIIygrZ2EeUttY?=
 =?us-ascii?Q?dYkFu2sfDDzNrrJuXDRCV93HHdFYy7jXqAyW+O3XccjR6Q5YEDXcLWt3nuxl?=
 =?us-ascii?Q?SiVAZNrRiUcQd8GAAdz8Nf/He/dkvErmm7ArzRvL6o0IwVrN6Soqb/eC2hEy?=
 =?us-ascii?Q?YCwzlkMUsSFMX5CabvaLHshet48Q+yUqAMkStRp/K0Aj//2WHQ9jY0PSp3h9?=
 =?us-ascii?Q?DXE0hUosXXeZvgLQKV8nx6LOk697S+ctjSDo7E6C2XHPOXJ0NIUdLabkBSK7?=
 =?us-ascii?Q?CoG72ndavTAjveX7kCFU0OJxeqF1ijTVXaJywoxsTiKRp6IHC6tTJGrlYeh5?=
 =?us-ascii?Q?ADorBXBa+2hrPtfebZ9noLtTG3eeAZF3VBvKNaBiWW/V0fhhsveWVLqxB9wL?=
 =?us-ascii?Q?CYjRTdg8dOgbgGT+IBCQD1GdoZvdOZJbKOxhZzeigK55Cnx91tMq8ORTM2lp?=
 =?us-ascii?Q?oGcHVfluMAtVyxQyIPgrSRvfuSrk92YrbNfRbpMIJjxfQz2qKxpi10e1TEm5?=
 =?us-ascii?Q?5mSnS98aI/q7KG6qHZp9Ihm2hQMV5MaZzQ8tapP1lOGfWC3E58cswtzCYZmZ?=
 =?us-ascii?Q?2HBUrk+kFrVmtn4U+m+/TT5fpnC5EM5C20DSxqaFDi6Thx7srjdq/OmR1cck?=
 =?us-ascii?Q?8SdALxZroepVtGGEkKkVtCvtvPIn+GTsANuodygbelv8tyCiN3jooA9QXoCr?=
 =?us-ascii?Q?ztWSVooTyE72k66ldXar1K2V//Ka1tjmG/ssHlKkhLPyZZuz5RihOoc8TSeo?=
 =?us-ascii?Q?muLyfGXibMzTuF86tYEqCIYztVZQrU0kqa4IbJIlatbvyNUrEw8f2iQa6qYd?=
 =?us-ascii?Q?H3WIZs/tTc8zS6LWDMTK7QBTWrg0gMY8hSTb3aiMCsizi3ozKkQ4b21a4p4u?=
 =?us-ascii?Q?zGno78bU/7yPiDBsdJbbYfDTeZEcNiQQvO+i936cLyXopbAzh2kAm1JyLjik?=
 =?us-ascii?Q?CgjYIIFd6NKW/ZaS+d2X/lclz+dIPko03TnPjGoYYUy+9mD4APvFpwl37ggi?=
 =?us-ascii?Q?GRddDiIBa6uMY+jsrBYRTpQyKurWNHFymI1PE7f4j+xakquEzqXO0+0jxKdy?=
 =?us-ascii?Q?Xw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	42vEWhJ9kcjTlPez7aP61r/0bLOszU9+oWu+LkfUx5+mumOVVzZ/O5YIsE5mUiEmMIBDslJCFl9znfAsFY0CwbhL14fB2/9DrXWihLGPW1Q3XH+aGOrTn/KC0zHYcWhFuiVkxKi80QmDHzghAaqGYXMXLCG0LQmYXzIei0n4nC3pMdSbpJCSfttoeT0ieLYY7kj9/SiWkTLp44OaD0VZTgRTxVSHW0EUWH1srfZKOUwx9HAuIiKu9ajJB0cfBIOnDU55kPu+TmAbsn7nB6rZbaeNGT8RkV04hSOYqtv+rIeirl9k+17M+hAVe+yHKeYEUu4P8gZfJvn5GCP1DnX1t08SSWbOOwNOKv62en2o51rIBJcvqaL/nvTLwcNrYH5cpts3NYzddC6O9Kl9eGy8laIGCWNgQU7Ok+Xl3y+sB12p+yKy1vDiAtTcG4XZRJgEQlvz4hRIQSy32kSkPPPltgAJO3M5eghXBhhwqmW6YdEK564PrDVHyjfIRInXHUtrkLAU88Cf3LNt/KlNKxTKe9Qui25ZDWYpAbkK9fuw5iFDcqUtAE2NB4X3DSV71ZXlgh5IJGjU5lusGtjJUBcERGybhW60CQST8biIPyaS6lM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57581fdd-0d88-45fa-21cc-08dcc2e05795
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 19:26:37.9639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rb0TTYoLKo4wr8wOPmfYzMlSr2YRDr4Sm6Ss6JYLp2kQs+EGFOuIM74DYbnbkqW+g1XTDpPNSV6azLPOTHNzOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7761
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-22_12,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408220146
X-Proofpoint-ORIG-GUID: 172SnK5gjyVSOoobUO6vUBRuQDIcSWNi
X-Proofpoint-GUID: 172SnK5gjyVSOoobUO6vUBRuQDIcSWNi

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Prior to call_mmap(), the vmas that will be replaced need to clear the
way for what may happen in the call_mmap().  This clean up work includes
clearing the ptes and calling the close() vm_ops.  Some users do more
setup than can be restored by calling the vm_ops open() function.  It is
safer to store the gap in the vma tree in these cases.

That is to say that the failure scenario that existed before the
MAP_FIXED gap exposure is restored as it is safer than trying to undo a
partial mapping.

Since abort_munmap_vmas() is only reattaching vmas with this change, the
function is renamed to reattach_vmas().

There is also a secondary failure that may occur if there is not enough
memory to store the gap.  In this case, the vmas are reattached and
resources freed.  If the system cannot complete the call_mmap() and
fails to allocate with GFP_KERNEL, then the system will print a warning
about the failure.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c |  3 +--
 mm/vma.c  |  4 +--
 mm/vma.h  | 78 +++++++++++++++++++++++++++++++++++++++----------------
 3 files changed, 59 insertions(+), 26 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 6550d9470d3a..217da37ef71d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1622,8 +1622,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		vm_unacct_memory(charged);
 
 abort_munmap:
-	if (vms.nr_pages)
-		abort_munmap_vmas(&mas_detach, vms.closed_vm_ops);
+	vms_abort_munmap_vmas(&vms, &mas_detach);
 	validate_mm(mm);
 	return error;
 }
diff --git a/mm/vma.c b/mm/vma.c
index 3715c5c17ab3..8dc60dcb6e8d 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -883,7 +883,7 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 munmap_gather_failed:
 end_split_failed:
 modify_vma_failed:
-	abort_munmap_vmas(mas_detach, /* closed = */ false);
+	reattach_vmas(mas_detach);
 start_split_failed:
 map_count_exceeded:
 	return error;
@@ -928,7 +928,7 @@ int do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	return 0;
 
 clear_tree_failed:
-	abort_munmap_vmas(&mas_detach, /* closed = */ false);
+	reattach_vmas(&mas_detach);
 gather_failed:
 	validate_mm(mm);
 	return error;
diff --git a/mm/vma.h b/mm/vma.h
index 756dd42a6ec4..f710812482a1 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -82,6 +82,22 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	       unsigned long start, unsigned long end, pgoff_t pgoff);
 
+static inline int vma_iter_store_gfp(struct vma_iterator *vmi,
+			struct vm_area_struct *vma, gfp_t gfp)
+
+{
+	if (vmi->mas.status != ma_start &&
+	    ((vmi->mas.index > vma->vm_start) || (vmi->mas.last < vma->vm_start)))
+		vma_iter_invalidate(vmi);
+
+	__mas_set_range(&vmi->mas, vma->vm_start, vma->vm_end - 1);
+	mas_store_gfp(&vmi->mas, vma, gfp);
+	if (unlikely(mas_is_err(&vmi->mas)))
+		return -ENOMEM;
+
+	return 0;
+}
+
 /*
  * init_vma_munmap() - Initializer wrapper for vma_munmap_struct
  * @vms: The vma munmap struct
@@ -127,24 +143,58 @@ void vms_clean_up_area(struct vma_munmap_struct *vms,
 		struct ma_state *mas_detach, bool mm_wr_locked);
 
 /*
- * abort_munmap_vmas - Undo any munmap work and free resources
+ * reattach_vmas() - Undo any munmap work and free resources
+ * @mas_detach: The maple state with the detached maple tree
  *
  * Reattach any detached vmas and free up the maple tree used to track the vmas.
  */
-static inline void abort_munmap_vmas(struct ma_state *mas_detach, bool closed)
+static inline void reattach_vmas(struct ma_state *mas_detach)
 {
 	struct vm_area_struct *vma;
 
 	mas_set(mas_detach, 0);
-	mas_for_each(mas_detach, vma, ULONG_MAX) {
+	mas_for_each(mas_detach, vma, ULONG_MAX)
 		vma_mark_detached(vma, false);
-		if (closed && vma->vm_ops && vma->vm_ops->open)
-			vma->vm_ops->open(vma);
-	}
 
 	__mt_destroy(mas_detach->tree);
 }
 
+/*
+ * vms_abort_munmap_vmas() - Undo as much as possible from an aborted munmap()
+ * operation.
+ * @vms: The vma unmap structure
+ * @mas_detach: The maple state with the detached maple tree
+ *
+ * Reattach any detached vmas, free up the maple tree used to track the vmas.
+ * If that's not possible because the ptes are cleared (and vm_ops->closed() may
+ * have been called), then a NULL is written over the vmas and the vmas are
+ * removed (munmap() completed).
+ */
+static inline void vms_abort_munmap_vmas(struct vma_munmap_struct *vms,
+		struct ma_state *mas_detach)
+{
+	if (!vms->nr_pages)
+		return;
+
+	if (vms->clear_ptes)
+		return reattach_vmas(mas_detach);
+
+	/*
+	 * Aborting cannot just call the vm_ops open() because they are often
+	 * not symmetrical and state data has been lost.  Resort to the old
+	 * failure method of leaving a gap where the MAP_FIXED mapping failed.
+	 */
+	if (unlikely(vma_iter_store_gfp(vms->vmi, NULL, GFP_KERNEL))) {
+		pr_warn_once("%s: (%d) Unable to abort munmap() operation\n",
+			     current->comm, current->pid);
+		/* Leaving vmas detached and in-tree may hamper recovery */
+		reattach_vmas(mas_detach);
+	} else {
+		/* Clean up the insertion of unfortunate the gap */
+		vms_complete_munmap_vmas(vms, mas_detach);
+	}
+}
+
 int
 do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		    struct mm_struct *mm, unsigned long start,
@@ -297,22 +347,6 @@ static inline struct vm_area_struct *vma_prev_limit(struct vma_iterator *vmi,
 	return mas_prev(&vmi->mas, min);
 }
 
-static inline int vma_iter_store_gfp(struct vma_iterator *vmi,
-			struct vm_area_struct *vma, gfp_t gfp)
-{
-	if (vmi->mas.status != ma_start &&
-	    ((vmi->mas.index > vma->vm_start) || (vmi->mas.last < vma->vm_start)))
-		vma_iter_invalidate(vmi);
-
-	__mas_set_range(&vmi->mas, vma->vm_start, vma->vm_end - 1);
-	mas_store_gfp(&vmi->mas, vma, gfp);
-	if (unlikely(mas_is_err(&vmi->mas)))
-		return -ENOMEM;
-
-	return 0;
-}
-
-
 /*
  * These three helpers classifies VMAs for virtual memory accounting.
  */
-- 
2.43.0


