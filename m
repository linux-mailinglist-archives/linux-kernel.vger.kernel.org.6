Return-Path: <linux-kernel+bounces-294700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D470A959175
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 01:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E773281969
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 23:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9061CB31F;
	Tue, 20 Aug 2024 23:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gHT/UZ2X";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qxW5yciJ"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458411C9DCD
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 23:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724198302; cv=fail; b=XeUH4bKxm2+YuHZ8ppwz3XaRBn4bnEoBfuaCs72w+WIJI5brkCfxeKl+dUGZhZburPggrS0AHtWkId/0bRgbOiXdpj25xkvDd2DqYG44VHCJnL/rrbNSXhYDBu9NbCFYr/Eu4HskonJVpNNRXQYIez7Y07WEw0AFsjRRlYcVLv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724198302; c=relaxed/simple;
	bh=3n/0eoFZaBEsTFSF/sDM7IeJudyjqS/ym9HvOX++stE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sEiGcX6fq6DuLui21/UTPq44DH+f8SK7QL9TESOdgvXXNF+tTDh39Yj43BLPqENUuY9PQuB9ZPhBcI8iQOPE6IA2LGv9Fga0dBS7Y+v5UzU8SZrMjavMW+7fKiUErAwz2E1GrZYf+mtZjRYwTXljSu5bA1tWIbGPmP6rqyydOEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gHT/UZ2X; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qxW5yciJ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47KMBdUL016632;
	Tue, 20 Aug 2024 23:58:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=cQBQ6roZjofnRdkNhVdNis6vJDFY3ZS8i57oI04+9wY=; b=
	gHT/UZ2XGHPaWbGdLU8kzcYLD4ZoN5uDEjjiD8rKOi2rxKfN3vMWjdPAYOHi7jih
	74HBxs2YxYsP+eftmCUZZhzUbDDh2qOprioGbGWwAYw/nVJnhLMNJp/daP4WJ0FW
	ReblBIMgHyPH3wVBBLRMS7JZYbscCs3ENnOZMCvsYpPTqbBad9zgw/0OoT8a5jQ+
	WBsZNTNUnKldRd/gGqBZb4EAhDPfShIg6lBGLHbO3d8zOIHHMXzjAWYl+b2gswSA
	qIRvXJKuxxIBG+Ya9+OM1Hl+nQ4s7p9UbBa7m38fjdazyqL+AkC2zov5L+0hsQJx
	JT+mlo02txaDpy5fP6ZKlQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m2dedrf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 23:58:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47KMJJkF040123;
	Tue, 20 Aug 2024 23:58:05 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4153u2tbef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 23:58:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hCTNDcvbokyxtxoTmUVE1EmsUfOTIVjxqmelhC/tESDi+fgXuRC+Z8ypxOOk/7JJ6ZA24jOTmx24pYFmsLgsCqOi60cH73ZTtHYK45HpUsWmZ5t9BRTM3I5o6zGjkUg3VtCBRAa3yc2iclyxigV4cG9kjyVN7zT3sUQRii9k3aFC3UuCX1KqyKs+nlKuBamVSv01O0siKLHAWFjoMPJSrqIXwq+Bx4ovgKEpsjlmYMGl5Qnvp/+GAFOjJvLlhaexCc7PJCdpbYAXb3OodDFT2Rnim/8L/F19tG2UNECJgMkWI29jZoiF1KdeKY+vpzP7lwoMP2rGsGGxLEXoolOe3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQBQ6roZjofnRdkNhVdNis6vJDFY3ZS8i57oI04+9wY=;
 b=Zkf05U3VL8DvDQkB0/d5SBeTmxBtlKEZwiAuaMcPR/9fZKTsHBV3w3iultdyJeZVKcZAqsWjZqMQnQ8JJlGTtNrZANq5q8qAPzuKuomypWWApNEtyG1sGyMvyKbu1IJ+hJPCCg8+Qca2waxjewk6zD9pnvuPlIHdlhZZCkum7lH77AH6gFOqOqsvhCCp89m+ekOPMS4oUxkrbaaGh9fO2kZBhBt3OdYDwPUXtLE3R4t19krNvka2fwMqzw+pEb3Gr4ExpaMBKyuC9kjpMPlhtCLYTgYJwOJr3JRePn9PeHNyJEG4ybgtaf5Q5iylEwqUn7fqnUhiG2D4wHQbdWwx9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQBQ6roZjofnRdkNhVdNis6vJDFY3ZS8i57oI04+9wY=;
 b=qxW5yciJnI2bxjktxFIKbxdjq+Prfl6+g42IVofVHkswLr3jHax0KuqJfsSQMlcTrY21uU2Wr8iZrNkjW5moPe1PPQbBjxpwJEX1c5EBSI5KbOwjiOlUbW+TwXa15s7+20kvoJ8tOeri/JD+Muq643rhqZeuRCj7LFFDkuv8ssM=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH0PR10MB7099.namprd10.prod.outlook.com (2603:10b6:510:26d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Tue, 20 Aug
 2024 23:57:55 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7897.010; Tue, 20 Aug 2024
 23:57:55 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v6 04/20] mm/vma: Extract the gathering of vmas from do_vmi_align_munmap()
Date: Tue, 20 Aug 2024 19:57:13 -0400
Message-ID: <20240820235730.2852400-5-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240820235730.2852400-1-Liam.Howlett@oracle.com>
References: <20240820235730.2852400-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0127.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::20) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH0PR10MB7099:EE_
X-MS-Office365-Filtering-Correlation-Id: 10e1d107-0e20-4ec9-fe7a-08dcc173e8bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?joAVgMahoCN5vmO068krskpFUgJmSXkZZZZu44HuG0rGbJzr8cm14cAGOMOt?=
 =?us-ascii?Q?wXxiVaMjB+7V6CIzQsCFdu8zvj+XOutnRlywK5+iJKETl6FnX+JDzHgKil6I?=
 =?us-ascii?Q?4jMtn4Z43YGYtZKZd5isJMdbvPDftXKZWkWH9la1a/fgVL6Z+H+LP1U11vo4?=
 =?us-ascii?Q?qIEvXBLKj4wz63IK8MfavZ1rmjCQDovjACJZdARneUtyIpyCaZtX1Gh20bR8?=
 =?us-ascii?Q?38Utko9etKqBf86WHBSv6vWb+KRCGS2QQpMQ+wQA1Tc9xcoeBpuGqgukAlJh?=
 =?us-ascii?Q?NJL92oECt1Wquw/6rAbjId3UY8ggrF64MwYuIHfmVfOhC7AYTABxXwJjHiZk?=
 =?us-ascii?Q?0FA/RZQehLEf/eRMfY5Rmjshc6prwqqGMDXMoTIdY5/ZLi4NO89RGjmkuyPi?=
 =?us-ascii?Q?0nAEaEQ0H7ouRZ4qrU2supen/mRZCDckRvQ6ajqoQMSATZ6Vks9O8kZS3SJ3?=
 =?us-ascii?Q?BocZebcXfDXDUK4hqhVB6W6fcGhIp63BcyY+GoZB0EMEwwj4fwjrCbnR3hpo?=
 =?us-ascii?Q?MD5yHTOk7OWRx2mCzoz+2AjToJh4A/0wpSr/ZLbGBhPm3dfYxjDly6pGM2ow?=
 =?us-ascii?Q?QPw+Gb82ftDedd1KSCBhKbXPcXabW7ozWKmSuN4Zv1bl5JDgjIUANRkQgDjN?=
 =?us-ascii?Q?tlqMW5d3VmEFsM8P7AA6Q/s5JCAu5yPeyJuL/hh+FDq/+xewXb2ULbM9KBZy?=
 =?us-ascii?Q?KVGXZNZfsUIO/UiDjvfjnIKLOLZl3Stb634JDWKoSyRbHY9f3WJf2hE4BUhk?=
 =?us-ascii?Q?dgpL47+86l5ieX3EH6oNDeGGrfoVv30IMXsoW8dXR1tvfb43w+W4bGoWUQZS?=
 =?us-ascii?Q?VWVYOx9CiYTwup449R/seRNB6KnEapfQkFI4pLpu4dOGyxMlzhBUTV2edzuf?=
 =?us-ascii?Q?U89Oy+gavOX9zdJ7YY7xWM4Ji+GhHJ090cD9ynQUlkTAD2mCUSPFefrWKQSZ?=
 =?us-ascii?Q?mBLfVxBJIja1M55GbgZ5W4ziPtlAsPrhZXixNFBEyn08PAoTcLO3U5yB072G?=
 =?us-ascii?Q?LfQSrEdt/22/B7+ASXA4QqPY3eBDpfEbgpRqpi5u2dS3hA78PiV5ONNX2qHs?=
 =?us-ascii?Q?ZFNIjfJappuRTajAN73NnigpoCHEppdHP60lfLyIeS7sVJbjBZpQF0zfveMf?=
 =?us-ascii?Q?Ndjm5Qt+uIv2ahRPOgp+B2lT8I3VR/sRGpKCBLAqm1suTJ3+vt3lVpxWRWVC?=
 =?us-ascii?Q?MGRp+TYoMjI3Xz3AXcsFBQC+MgotJQLfWWdiXuKdiKVzcvdYmLx95EKUBdy9?=
 =?us-ascii?Q?cA+dDdjs9hsusGT88+ujBwNX5YDveuWIMhCZXqsI0i24CSaXJX4l17dygwYA?=
 =?us-ascii?Q?euoCF1VRMZKtIcd+jmfNJtJRNigq5BjvMP5/iMWG5h73lA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oPBjHbJ2TgR0t4I45IQAYJW4Ly6TlT43iWi+i+LwZoEHrNDcW01NRJBcEZnh?=
 =?us-ascii?Q?z6wrMGhaNru/6HHcb5x67ebOk80Erq2tUEgFgpw2b4tDkdyrM5dl2r2ssRVO?=
 =?us-ascii?Q?p+grR5E1bXYTOGnn8KP/+vdkeKfeJwojC0QsUYv1qEs0Aa7KKTBF68btfXiz?=
 =?us-ascii?Q?09mWnssuDVJGlysGQUU47wIXt8+FpHilcG2V019tClrMu85WTDnvv2ZGW6y+?=
 =?us-ascii?Q?AVweCPTNGu267V5Go4yEvpgwtmCe5lvCmXHqCLFk0ZkNAHRRH3Hnz66xV72G?=
 =?us-ascii?Q?oAixzSW+pagbZP8aSR9kE+uFh3dmtVqwC1y1BA2VAqItwqKmneJgEIoJQOMs?=
 =?us-ascii?Q?CMuJHZklydbpR8jeh49xa1pkXDd5ftIn4zvqhcsM/q3VBUGLgWBp5NQR0YJf?=
 =?us-ascii?Q?hviu3YtEhQ5JXDl8wOPdzOyXAq56CYnNXgkgrg+2pJlrtgY2s1fIo3HPji9d?=
 =?us-ascii?Q?Wq4dLXX+CW2Q66mZpgjTxFkPoW23IMPtv4vhaxLX37akOpLsgj3Ra14sWxrH?=
 =?us-ascii?Q?eO2I+dwfbUrj3PKkFVGzwbBv6MaKqTeXIeg6HJpmjQ5fle0Yz1w5NYN0oQ+h?=
 =?us-ascii?Q?qutUt4P1i0Zu9KnI2qfoYnUxej4JlmB86K+XVJup7oYOw+FkWvhoo9aprdKC?=
 =?us-ascii?Q?lTX+jtgO3bhZg5mDSfuU8zhtwzaERGzIQ7nEIfL5HcVEQWqZDlgdtdiFh47F?=
 =?us-ascii?Q?Ja3QDGo2190iJ35eTCtpiARCBRiHr91z7fCaLrW3i4hkSasoeL3gnkEFByNw?=
 =?us-ascii?Q?UJYBD3z/+UG9l3kkCqy+ggbGO/WH8AG4fkG+dB7yf3Sh/dEe9h5eZDQBgUBN?=
 =?us-ascii?Q?WA++vOgWMt8N0lTZ+MJep9n6847VOkSo3Uz3Q3AahE1dMPy92YUclCBoZ14S?=
 =?us-ascii?Q?jpiHzsF86/oJpf0mGu0WvnQ6vPJeu1WsMP8fftz94Y6YG1sJdFuiYmEGDrLf?=
 =?us-ascii?Q?4OsupCOFDGg1gJGEkq82bvo77AlgKUSWNuF/TznbswDmwpRMc15IoBJGXkWn?=
 =?us-ascii?Q?OIBOTX7Xh6E1Q+mce8fbdeKJK0XV6QNe2HXIsIZf/XVykfSL3WUbCECS7jYk?=
 =?us-ascii?Q?XjklyP1JthYTKVzX44IB+hpatFoxvRPuJhIdx/+nVoghCMRhqbqHsTD3FwrU?=
 =?us-ascii?Q?l9BTT6ITLxBmvC6/bjsQrW41i/Aic4UtEHZL7ODGrdADHqgrYtd8makXUuqq?=
 =?us-ascii?Q?8QrLOqm/eFkN6tgSvUAZAcHz/9uDpkxhJQBsyjjVwbouPzr3JGu4OSk2bBiK?=
 =?us-ascii?Q?iiFsh8/QvYGW4NC1rN00HZ7wxUxzOMVG7Sdh7044PzL+KeZkOYrSkKNVlhIO?=
 =?us-ascii?Q?n6kALYxZhdmpVuhqP7e6kfJHOtIfgHGZnMGSDwaqHIitT2wIoYHkrJNmPdHD?=
 =?us-ascii?Q?3rQ7TAClOOshadrd2GaGHHlBA9W3zYvwaNF2TITxUJL5+cQN3VXaqV66MZHv?=
 =?us-ascii?Q?2m7EK4Xu8kHCjOBUuedU+XSqf1bTgCjiX3OcUVtMme1hMXRAEyl8YAnvJ3Mj?=
 =?us-ascii?Q?ADNqKwWb6L9IqueUMwp1K+yLLDF9gDBINL7Tev/RvgvqGG60ggtiBFRKobhI?=
 =?us-ascii?Q?ZyHmDPLMtdG6yQsdMGOsefsapiuo92s8yc0b+8vc?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9jJa6pRlhNZlV5aBRPTxkbB52ljIPNxhUbFobRuEeldPLqdMSOD9f+8ZDcLwAuIOJGw6UR0OWnZl0C/FWvWca44LNs6N9tjgHhWC2Qu+E3RDu/jfJkx13WEagP4Itb4WDa/onfWwwLaIgRF/+V2g1nzpz7Ify/YN/FflsIdNcqmSOkcHQiGH4IKnGvpMUMxIr1ntduGePCRSETGNpIdTDZrilcLMvid1DyQyBBVeqpHpdjPOp6vd+5gPIGurlrPDDggMt2B2KY1Hc7097faDuF4jHS1PI+UBBcHiKs716sTyO06DeaJ17xu7060WnsT2ifWuvU9EME+8bUTmIH1hDnMI24lJFSULsnIqnisqyOGUUVMoaoFhsQNQYNJxZLcpYR6uXEPpGVUKq9QJ7zFMY5djKu2d6uvEUo9Oa3OaSrrcxoLiXdZsDaomx54IMe6Fvy/flBzHVcKxKIayEPc30igth4sgSUWnJV8CN88DNlhG9FEYohSn7H6yk324tLXf7xbP45xcnYZTKncXXr0CP+cFMSXLjSwrjJ7ztMciJIPi39JXfFGvQTKVArTEbN4BdZCPR103hymq5aYjNY8VVLhPZ7+VRyu8LaEl6tvK4Rw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10e1d107-0e20-4ec9-fe7a-08dcc173e8bc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 23:57:55.0731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: en3YZtgZEkPD5kT0UtaNcO5SbtSr2SJNh9m0hu1ZTSQ88n89B7Wna1fZBgUayLhYDHw/bzANkP4iIewm1mXFpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7099
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-20_18,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408200176
X-Proofpoint-GUID: wtzRhf-Pg4_hFcY_4eORulCcuujwlk4L
X-Proofpoint-ORIG-GUID: wtzRhf-Pg4_hFcY_4eORulCcuujwlk4L

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Create vmi_gather_munmap_vmas() to handle the gathering of vmas into a
detached maple tree for removal later.  Part of the gathering is the
splitting of vmas that span the boundary.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/vma.c | 82 +++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 58 insertions(+), 24 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 3a2098464b8f..da489063b2de 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -737,32 +737,30 @@ vmi_complete_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
 }
 
 /*
- * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
+ * vmi_gather_munmap_vmas() - Put all VMAs within a range into a maple tree
+ * for removal at a later date.  Handles splitting first and last if necessary
+ * and marking the vmas as isolated.
+ *
  * @vmi: The vma iterator
  * @vma: The starting vm_area_struct
  * @mm: The mm_struct
  * @start: The aligned start address to munmap.
  * @end: The aligned end address to munmap.
  * @uf: The userfaultfd list_head
- * @unlock: Set to true to drop the mmap_lock.  unlocking only happens on
- * success.
+ * @mas_detach: The maple state tracking the detached tree
+ * @locked_vm: a pointer to store the VM_LOCKED pages count.
  *
- * Return: 0 on success and drops the lock if so directed, error and leaves the
- * lock held otherwise.
+ * Return: 0 on success
  */
-int
-do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
+static int
+vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		    struct mm_struct *mm, unsigned long start,
-		    unsigned long end, struct list_head *uf, bool unlock)
+		    unsigned long end, struct list_head *uf,
+		    struct ma_state *mas_detach, unsigned long *locked_vm)
 {
 	struct vm_area_struct *next = NULL;
-	struct maple_tree mt_detach;
 	int count = 0;
 	int error = -ENOMEM;
-	unsigned long locked_vm = 0;
-	MA_STATE(mas_detach, &mt_detach, 0, 0);
-	mt_init_flags(&mt_detach, vmi->mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
-	mt_on_stack(mt_detach);
 
 	/*
 	 * If we need to split any vma, do it now to save pain later.
@@ -812,15 +810,15 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 				goto end_split_failed;
 		}
 		vma_start_write(next);
-		mas_set(&mas_detach, count);
-		error = mas_store_gfp(&mas_detach, next, GFP_KERNEL);
+		mas_set(mas_detach, count++);
+		error = mas_store_gfp(mas_detach, next, GFP_KERNEL);
 		if (error)
 			goto munmap_gather_failed;
+
 		vma_mark_detached(next, true);
 		if (next->vm_flags & VM_LOCKED)
-			locked_vm += vma_pages(next);
+			*locked_vm += vma_pages(next);
 
-		count++;
 		if (unlikely(uf)) {
 			/*
 			 * If userfaultfd_unmap_prep returns an error the vmas
@@ -845,7 +843,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
 	/* Make sure no VMAs are about to be lost. */
 	{
-		MA_STATE(test, &mt_detach, 0, 0);
+		MA_STATE(test, mas_detach->tree, 0, 0);
 		struct vm_area_struct *vma_mas, *vma_test;
 		int test_count = 0;
 
@@ -865,6 +863,47 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	while (vma_iter_addr(vmi) > start)
 		vma_iter_prev_range(vmi);
 
+	return 0;
+
+userfaultfd_error:
+munmap_gather_failed:
+end_split_failed:
+	abort_munmap_vmas(mas_detach);
+start_split_failed:
+map_count_exceeded:
+	return error;
+}
+
+/*
+ * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
+ * @vmi: The vma iterator
+ * @vma: The starting vm_area_struct
+ * @mm: The mm_struct
+ * @start: The aligned start address to munmap.
+ * @end: The aligned end address to munmap.
+ * @uf: The userfaultfd list_head
+ * @unlock: Set to true to drop the mmap_lock.  unlocking only happens on
+ * success.
+ *
+ * Return: 0 on success and drops the lock if so directed, error and leaves the
+ * lock held otherwise.
+ */
+int do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
+		struct mm_struct *mm, unsigned long start, unsigned long end,
+		struct list_head *uf, bool unlock)
+{
+	struct maple_tree mt_detach;
+	MA_STATE(mas_detach, &mt_detach, 0, 0);
+	mt_init_flags(&mt_detach, vmi->mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
+	mt_on_stack(mt_detach);
+	int error;
+	unsigned long locked_vm = 0;
+
+	error = vmi_gather_munmap_vmas(vmi, vma, mm, start, end, uf,
+				       &mas_detach, &locked_vm);
+	if (error)
+		goto gather_failed;
+
 	error = vma_iter_clear_gfp(vmi, start, end, GFP_KERNEL);
 	if (error)
 		goto clear_tree_failed;
@@ -872,17 +911,12 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	/* Point of no return */
 	vmi_complete_munmap_vmas(vmi, vma, mm, start, end, unlock, &mas_detach,
 				 locked_vm);
-
 	return 0;
 
 modify_vma_failed:
 clear_tree_failed:
-userfaultfd_error:
-munmap_gather_failed:
-end_split_failed:
 	abort_munmap_vmas(&mas_detach);
-start_split_failed:
-map_count_exceeded:
+gather_failed:
 	validate_mm(mm);
 	return error;
 }
-- 
2.43.0


