Return-Path: <linux-kernel+bounces-239126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 640A39256C7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 11:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7C64B2266A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 09:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687BC13D51D;
	Wed,  3 Jul 2024 09:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XlOwN9B3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="k7rEzDpd"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7657A1369A1
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 09:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719998851; cv=fail; b=bewvajBXmqchE+0EWjNZmHDLPdAaQOjAsYWe2hE1zKE5K8oHv+GPIp72t6Dg1YCNoeOucGi9R/o/VfNKMBo95BC4ZUmZ6wAPVqFDVji4GV123FLg6LmJUrAQSSXPMgF5FblhbVVzx84CcYLmzUWSJTWWnuP0+NKz8+YG952o3q0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719998851; c=relaxed/simple;
	bh=2yWkonTGDSy+abzAcvyK48aaLdFLmS6njMOrwEFR9OA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=g/IuQNKGxm7GaT4PVIsvQrCMgw4pY2AqjIkELxVLEGbrFrnGWswbTzt/OjeGES4Vzwh5Vj+MkbkqHiRg2s8HDU+VSGZk95ogfHUtUq7N0hEu27aCbb3hKj2k3rMmnXfz5qnB2JOsTtykIP7Oikxa/83HcLgTKDU+oPzTzwncoxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XlOwN9B3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=k7rEzDpd; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4638OCnF008140;
	Wed, 3 Jul 2024 09:27:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=ssP8oAEkzMC2kn
	ZSCHq/NaYSKB9mjtbrRIzIhofjGzg=; b=XlOwN9B30fqwRlztTd9ZroGVHKnFwH
	2Ku4Oic0Q1B339X86ykjkLJ+ERESkCYv4Z9v+kBFHul5mCdCYd2RkrBfZ9NOiH5l
	CHHkcyzLlwiw5n4KN9/BfTAOdz39Zblqp3HgMCdv8hCUIZrp8nGDgXauRKb3swEk
	OJAswty/BtgKVNlpORECcbij4mUIVYPCj0a5MVvEShJCzY3faoipJaAis9vxDd78
	Ze9JoHDFk0OwLqzFjpntmn694uwfffCyNRhdjn6gcdENkleQaJayhZrwRGqxbOSB
	PzWZmHZRUmQS2eHkAfrJWnLg9pHov7MK+L8MnU+qVWamyWwCeazYJZlg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4028v0qta7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jul 2024 09:27:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4639K7po023552;
	Wed, 3 Jul 2024 09:27:19 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 404n0yw258-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jul 2024 09:27:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OJ9dRhcIMkzvw5EhvBmq6VgLMDEeOY3HHzTgB8SpZMqwIiBzF5IVTdvgp6OG/BQKn5xTWQLmAjPRWc/nDYIWitM9xMZf3Exl4s4JdE8VommoaBiqg+MRuVYzdc4h63Xo0i8dr4J6RQlv9mPnrtXs4o3pQ5trfsk6riY70gnJvRdc6n4pzrDEZQu46SCrmg8SPund4lO6WSD48VpqkS0piwGaUmWSpIwIiBw3U2v3VvCuFhgsn9ogzsq7x5DQTmrB6ytnoIHT23mHDmAxh3pGhLvj8tfFhbkvvmSngEB2BTgTME6VAhlVlo3JMGCl4r6s6FkbzukWR9WSLSP4lAlntg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ssP8oAEkzMC2knZSCHq/NaYSKB9mjtbrRIzIhofjGzg=;
 b=cYalnz/lxzAtFdeSLIqySFgpgsf7E4aLIsSoUGe3HFZebRWHe7jQZowevkQGHFj9sgZr/4zRH3a+vniYOAXcR1H7QOA5vmH48Bc1Timohquzpr6xGSqQP2ynjPP1w6X+zATUdR+nfhHlUxbGIh+W68uKMuoRwiiH9W6fXT6zmFAviFiKYHUE9xYNJ4HqfGGsQIgCZyJf7c/FVHXUW6GL4IYxCCWK8X7vW9BdzPbB1WR48ZSZkWDKxCR1Zbb4nNLwPsXV31SpZvd++JMoavK1o7E2mhJVTl8ACEtoRGkxP2EE4N53NjwKKe2CDsgD3Khm9HInBCAv9BMKuARhcerLnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ssP8oAEkzMC2knZSCHq/NaYSKB9mjtbrRIzIhofjGzg=;
 b=k7rEzDpdxZWF7/MBxxoc9lOeTbevkNmyy29o6HRW3jO7NW2AFTdqLvrAodIMtLqilJUCRf5KiS35RDi1HH2xi04EiuKJ4shVNDlkXvc+BKhv5iE8qkctcJy4edmgwXeSCeeHpEfqSK3G/b7+xwmrNRMY5aUt6pM8Q+9hb8wwydM=
Received: from PH0PR10MB5611.namprd10.prod.outlook.com (2603:10b6:510:f9::16)
 by PH7PR10MB7055.namprd10.prod.outlook.com (2603:10b6:510:278::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Wed, 3 Jul
 2024 09:27:16 +0000
Received: from PH0PR10MB5611.namprd10.prod.outlook.com
 ([fe80::d513:a871:bbf9:fce2]) by PH0PR10MB5611.namprd10.prod.outlook.com
 ([fe80::d513:a871:bbf9:fce2%5]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 09:27:16 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: lstoakes@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: mailmap: Update Lorenzo Stoakes's email address
Date: Wed,  3 Jul 2024 10:27:04 +0100
Message-ID: <20240703092704.11571-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0524.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::9) To PH0PR10MB5611.namprd10.prod.outlook.com
 (2603:10b6:510:f9::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5611:EE_|PH7PR10MB7055:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e0fb635-5078-47ff-7cb6-08dc9b425478
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?wQ+i3BSriMUn4zWd1VpFKiYpDL+RPbHGQLxPQ0e5OmS78sVkPbkcN1OF7KaY?=
 =?us-ascii?Q?iQMBp7xbRYMt2j+tI/XPat1lVz5Ni7PHPLLAwdcewKz/lG+ZpOhRtvYsydN1?=
 =?us-ascii?Q?LDZkgZ69DoTVX49dI+FHSBB3qIeaw1fBc/BmY2volRWvAXrapEkpNhnqmelb?=
 =?us-ascii?Q?rmQ2d+gYlqJVW6H90wpGTqw0FQqZ/broL8pzvqJ2XyMFHh6Po6Ggd7L1FdOi?=
 =?us-ascii?Q?jC/e+RWdbG+N8Mbi9OaettCuOQC7g2H3mVbBu0478v8+fmHktI9DT6cs5tiX?=
 =?us-ascii?Q?orVWGmuN9vLx+XMqmyw4dLfP9tcR9bcVmov4LBPQSTSiUmmJfV9idDiV8hf0?=
 =?us-ascii?Q?/uZwtbI0e6qTeEO7eIKbfu0K6V2Wp730F0WfT4ExbKAGjTl1+E98BqY9kw4H?=
 =?us-ascii?Q?YCxqsFjlplipElmy7CPXCGawGd9KHn+9p1T9I5gwtlOghdt8aByzndMZbwHi?=
 =?us-ascii?Q?ECl8NcVKX/bRgZFFMmU2MGEKy2cpALAwDEdgcb4aJ3AlHXshMJUY9YlrgtxW?=
 =?us-ascii?Q?MPKXorm57aPdynFJMCvlYE1+rldaR4CgUFFzKU6nmuH07Hyo3l8OZoOkAuBO?=
 =?us-ascii?Q?teMqme4PCmlJxUHL385ahZhFLN4g3LFJU79+tg8d8D7hTJYpfkJiZZ1S7o6F?=
 =?us-ascii?Q?/lcce+Mq9AauYRssJpqHgaC/uo2CsQki8wQRA+2GJKMtwDNnl5Es2DcOdFi9?=
 =?us-ascii?Q?nbTQgXKtpvUqJxI8cCOUWPrsZxVsISP/vZ+GwEGG59LdHifTxDG5nH7Xxjfi?=
 =?us-ascii?Q?NYZsXtPkLjCHOg970/a9lGiGcW25wHFJtzbFdle/6UDXl146BvJUMDJfZ/7h?=
 =?us-ascii?Q?XmwnQ+JURl4MVLLwdReR6em9W8xbXjz8XNgoUaXS7+nJM3u017YMu9021H3n?=
 =?us-ascii?Q?JqEj+NwqweRWzPCJXv8fj+YVdEXwLIkG4ZedEKoeYuNRUTmfobvNOFDnIHkp?=
 =?us-ascii?Q?TVvnegQdBxXurHWVHbSMObDWWgMa8PooJRoBNaz84SGz6J3EVk9Osk4rfxcW?=
 =?us-ascii?Q?05aSxckojCG60dRa7akQCf98BoMiH8AUVH0y9uvZCa8z4O3qju1kbQBLNXL/?=
 =?us-ascii?Q?0n8HMRtIH6s/NhTbOfAy+foOK4HkdfLNEijEJAKPk48DRTKi6lov1blZcPX0?=
 =?us-ascii?Q?PgvS5ZHLSMsDofaMkpapWsK4O6xGJTPzhR4CMC6ZSxh2ovepAz4eJzGVz9q2?=
 =?us-ascii?Q?OELU1MZWtIOGkrvekxnGOHr3zgzVilfmgkE1yhFL/HaecGp4d8R+OMa8p7LH?=
 =?us-ascii?Q?F8t6x6/2obFIchdgldS/UYcd2GcLndQ9DOHCyG6Nr6Cx6c3G0Yv83UWETeDE?=
 =?us-ascii?Q?lmU=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5611.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?1uhVAoaUH8v73L6flFaPqsARqWo8hJvOqQbENANb78X6fZhp0YxjO1Mbx3J9?=
 =?us-ascii?Q?WMaWntBhVmhWCUw/4MjCTDG9rJf17WUmYNzoZKjGoUQEF4fM5RGeqpFsaUKA?=
 =?us-ascii?Q?fZkGZ6cxzss8KZvHTPhIHoF3Ic/VI2Gtq4s7MDvj0hjDQu4fMlSr0/oGbHFp?=
 =?us-ascii?Q?u7pw8HgRno2CSANu89xxJAwdMYJdKAO6fvwsShdpbB4QLJbaeg/AL1WwxohD?=
 =?us-ascii?Q?wtBtYtnBDMa8Cggw5nqollWep9+hFOKB3Ws6l3rsTRWOz3MzgJo+wxTweivL?=
 =?us-ascii?Q?qtvaSCgjI6jbOsgNFAVEGW/m2PWM3+lvdMYezJYQ4SqdeoMX2jxAdwoZy5PC?=
 =?us-ascii?Q?E+F4QaQWGKspZ0byMZEkECprRkSFXw8kjGmD4s/AfrHN8zwjUfWFDC9+GqY1?=
 =?us-ascii?Q?ZQ/6iPeQXAyXbVjqIFCZ1HuX5hO3gdCTOVsFPoNzVza2NIgTkWncYCKkeb2U?=
 =?us-ascii?Q?WRM0nxbuJ42TCCCl7vrY1fs6cTkJxaHBxhFi4OH1ZlrJ49Y5VGmJyZ+2slob?=
 =?us-ascii?Q?kKAqxv7rlotFEt7MiGmeF8yGfelMq8h1AQqiUFX821RahoMux9Muhmn4ZXuu?=
 =?us-ascii?Q?ZI59MAfrURmMP7xg5VUMXI2J5YrRk06/7HknqAJL5QRk+Ca+XYWjZxjMVJ8Y?=
 =?us-ascii?Q?rkz7wLgg3OLN0pvd5AB33bN/01QdYMFrzQ5yW5sW5+crBxZhzQ4LGwQNH7X3?=
 =?us-ascii?Q?WhNk7keJcBHkomQW/1INGMKZNgAiOueH9A+qbVAizo+OL6SeY2bH7vw8S5JR?=
 =?us-ascii?Q?dr51p9lR2XvVe2sqXQ0ZC94PsmhWxydBzHlCxrG9prhQ5FHXZXe3c/57M2SE?=
 =?us-ascii?Q?GV7KKh0ofhYL2x7KTc3v00R83Sny666LKQER1HGGgOp6IKBI3TnWsfZBSkzl?=
 =?us-ascii?Q?TU7T5FT62sOV90DbxY+zHnkjChBFglyDj2YdY4xtyIMYPoHVYBLrd6wFb3L/?=
 =?us-ascii?Q?TTOL9dGsDeGySyLjWRXDDEoqKEEak9HfH2Kg5Ef9KJy1Ag4lk2uAfF0h/GiC?=
 =?us-ascii?Q?qfYXjfF4LfXdb/3nZbWFDnH8KBRg2vIzpov3sl4IjTgWCE6dPkziqjTXAEf9?=
 =?us-ascii?Q?P7MsTPDckY74O0SHXZby/OlRZ/t2naiCbHb0+tu2zcuM+4BAoQi9smpfmA8r?=
 =?us-ascii?Q?a14PtiFRUJ7+qFAgwPG/JayWoWoXTmEXo4ytccg/dwrRpHiIPDTInO0ElGbX?=
 =?us-ascii?Q?RKJ4P2gyppO88smROwneqNHoiqKAFMCK5yhge9+x7jOXDwJT0OXXFeGd5Y/B?=
 =?us-ascii?Q?KNL84KAXydXnl8BlBvIHEcpLRZfnZUOd4/KUPimT6mZLdZDJjoTSFx0Dzqdi?=
 =?us-ascii?Q?I2/Iqmc+9JmNWUJTyxLiWpcx4WnSt+67J5mUdDgncO2SBXzbxjyMzkMcqe67?=
 =?us-ascii?Q?HuAhYloRwY4Sqlc9t47wkYgNN8gEIGfyh437Txor7uxjB1KyS3r+ZTX+lS3+?=
 =?us-ascii?Q?i0PC9r2nKshLtgGQm/gxqO349QT9wDEQP/uQ8OJ1rRFcVIOnBlBtRUQ24z3r?=
 =?us-ascii?Q?9xy1jKqcFh/HqzWLHdGN1WRw3iQIT9mQ0rfhVcOQFGkkoWAQvmTqsQS41LY2?=
 =?us-ascii?Q?O8SQMvFEibJexzxmv1Fly6m6w0guvp8eGtqln4Npgnp0fs2xmQE9zIKnSZic?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Dqmvtdta+McY7PhWkOsxsyn+57ESrBTLTdJo8n8qk4zm/eVgCoh3kjsixRzoiOc3GOQK77dH8qcJwr0c1fmk7SxcVPziVc8VFJRHxXRDk7miQ9lYXjV6kdvbs8x+vWE4TVYPpGCJw4F7/dwtxAStuliR0e3vBM6vCa8FxC4cnFQ9+Ok3STPnKrhsN5SXgM6ykA2Z7/RXQmsgMsFGU0dVqTiPAGwdaWeTyANbfMEXoW2IG9dd/FS/G+omhdT5SliTUdr2CQ+dyfrAZqu5qdEbd+P3P5+FROQjiIY3tzh188UUVZRerRpg8XojK4SWaMCxTIu1/fmYvzPjvfBa4kVXWBqBtusGe0M6VkzLWCpOvV0v0s+J+rarwC31SDakNzmDqvjPU686/j35zGfQ9MVByazlT+1WxtErD+whZ/MKo7mY3E2fMxyn5h87xuktQvx3fWGHUHibR2KMJZ6Di+3+gk+7k/wahMd17QZP6qIU5AFLeMJyItduil6y7xelMQh8LQVgYVMdVR2ieVVPOMJswZRUKEYhUWNIlSfh5OEoCqVcovR6aIwZA9zW7ejihWmjcw3HJS86I3jywQfBy5PnttcCBfwQiZ2GwFztBdDYC3Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e0fb635-5078-47ff-7cb6-08dc9b425478
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5611.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 09:27:16.8014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yQv4BXCaQpS6RPrGfaGjrLvG6Pq90Px8xFyXEJ//DfniLwhH9NVrB2fVAoOHJoCsD5/8ryYOSLnlAkcLx/kSiJTuD+4A54ePyqqdIzmDEzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7055
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_05,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=928 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407030069
X-Proofpoint-ORIG-GUID: GPw28p8UyadhE3PFlIAdgng13pYG12ef
X-Proofpoint-GUID: GPw28p8UyadhE3PFlIAdgng13pYG12ef

Now working at Oracle.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 .mailmap    | 1 +
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index a6c619e22efc..81ac1e17ac3c 100644
--- a/.mailmap
+++ b/.mailmap
@@ -384,6 +384,7 @@ Li Yang <leoyang.li@nxp.com> <leoli@freescale.com>
 Li Yang <leoyang.li@nxp.com> <leo@zh-kernel.org>
 Lior David <quic_liord@quicinc.com> <liord@codeaurora.org>
 Lorenzo Pieralisi <lpieralisi@kernel.org> <lorenzo.pieralisi@arm.com>
+Lorenzo Stoakes <lorenzo.stoakes@oracle.com> <lstoakes@gmail.com>
 Luca Ceresoli <luca.ceresoli@bootlin.com> <luca@lucaceresoli.net>
 Lukasz Luba <lukasz.luba@arm.com> <l.luba@partner.samsung.com>
 Luo Jie <quic_luoj@quicinc.com> <luoj@codeaurora.org>
diff --git a/MAINTAINERS b/MAINTAINERS
index 098d214f78d9..cded71cc6362 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14475,7 +14475,7 @@ MEMORY MAPPING
 M:	Andrew Morton <akpm@linux-foundation.org>
 R:	Liam R. Howlett <Liam.Howlett@oracle.com>
 R:	Vlastimil Babka <vbabka@suse.cz>
-R:	Lorenzo Stoakes <lstoakes@gmail.com>
+R:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
 L:	linux-mm@kvack.org
 S:	Maintained
 W:	http://www.linux-mm.org
-- 
2.45.2


