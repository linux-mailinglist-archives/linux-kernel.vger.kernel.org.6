Return-Path: <linux-kernel+bounces-444254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C46079F0362
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 05:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B812284B7F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 04:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D018317C21E;
	Fri, 13 Dec 2024 04:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bzEZnDCH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hFr0tnDF"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A54C1459EA
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 04:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734062854; cv=fail; b=MuaDl7fnJWtBHv2AAkI3fVf+FFdQ3BVcyX7GCopICPFMRJttQ1xQZ2ZDZAwQme2Wh+9JyyLFkIPcc9hRGnYv3+BextRVJidKhypBNPjcnL72HayWS1vBCg26UQNqY11iTSnmNf+cb0Iuhh1fq9zudKoho8P+tRhFGRaai5ZxP2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734062854; c=relaxed/simple;
	bh=7js1sx3JbfPMpHK0oed2RFgncEDBTvcpJ+YEG+/iOGk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ov3mx+h8JpFUo56wT46tceKA/iTp2Bsu1fiQH/HXkQ0dadrlEf2wxOgO7jwKVvMAA1noIsPFAm4MSANd26T/XP1V1ZqSbfPbCdaHnVu4s621hyo8+hEuKN1i/P/VLG4cfup3Pby5s6iinktLBI1qeQqtgOXqPMwhKDfsg9spczw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bzEZnDCH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hFr0tnDF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD1foAq023723;
	Fri, 13 Dec 2024 04:07:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=AdhWJm90yn2OMVE/xm4O1UU9LEKIIARoARLRoKwr2XI=; b=
	bzEZnDCHW682xlBCxxQPh6H+kHuvHFaxQdueWG1PoowxwxKlswrDqdK9oSRs1mG0
	0VbtvOV/7Fzhsm+Pz+yYbZ54PYetpOpu1mf8Vby7zNJWJJ+qjdLBD6M0mRZgexIY
	Mg5vLv+pEcVlf2ikaW929EUUjg0zo7bKgTDtl9cW8XjIfgw6zoCLreQTLO/dE/JN
	x5ZFNeWPc4SV1Z4lwF/skr+OU0m3P/XmS2+h2FSFjUT7CUUifFa222O4qJlg6Wzu
	DdynPJwHZ1ZDESESRKvp6XHxcpPik5tP2bRDF0CjS4nxdaMc73uPPnJdcO+q+btf
	rFQKm9SbaC+qJCCBTZ6LOw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cewtcrv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 04:07:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD2u4d2008623;
	Fri, 13 Dec 2024 04:07:07 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2049.outbound.protection.outlook.com [104.47.58.49])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cctc10gm-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 04:07:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mHsR8PwVVsElR9Q1FmvzksgJuM7pzxmH5CZDK/eyPRG3hDMe6t4iPY2v6gqmnScQu+x4StjepDRvCm499fr8AUUOWTW2FbpWQVfEFPgelpAJiMlMe7NAzoAuoSHF8LHC1zzTCTDcf7tCdVLAIAuasooKlz2LIOaTSbKqq/WaxKBvazkzQEUg7/Fsrh2m05jcpVvlsc9XsKcX90wDmltOKoBQN/yfnJ8JFY4PX1AYNejdW9DuWlWAekD/xjXxTvp5MmdYPE1wADIzy7UfHu3esdoLHQoa5EAt8yb+4frDEraE4ZfwJXNh5I1mvYHwzVnX/oGTHcl3huqGmr002DjVcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AdhWJm90yn2OMVE/xm4O1UU9LEKIIARoARLRoKwr2XI=;
 b=W6u6m15yHa4PySxfOBT7WWTjnjBqNQP92l5ZCBxsrKapTsg4ZurmP8iC4XIZi4L+ugZgSKpWSO7KJseKPHF5suJbQR6HCth0lGp2eRxVAutFn9zcrR4PSbj5A1n4JZvXPs58AaFsCaB1stcS9C3E83gobDiCaEyIZQTOP6owjqw0CFnhtkXkcLXtMF//yCUT4GI3q5rx/6skn50eiyqwSrtrOBk0oQ/bsljwYRxk+lqFLh5kPVLWl+qJ0WCWXsIkr3KmiaketHf5mu27uoihXrAVm8PzAJpFvFijvHuSoeJcq2deoQueeCKECg76TIYCDRNzlt7LqBPKb0f1b5qskw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AdhWJm90yn2OMVE/xm4O1UU9LEKIIARoARLRoKwr2XI=;
 b=hFr0tnDF2kkq3XGLNkHRQNGJxHUNMqTKlFqsx8xZatIBYYX7wEEwnXuaD7WYD/Ih8R3unZ4UF3ql9nyjrtfFeUbPaa0iYIv56EN0NLi9iotMA5pBgCAaPPZxb9YPaVS+ZQaLVNCC3SMjfw5dG0r6/oU10UCdr53bieZeh8DMPN8=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH0PR10MB5848.namprd10.prod.outlook.com (2603:10b6:510:149::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 04:07:05 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%3]) with mapi id 15.20.8230.016; Fri, 13 Dec 2024
 04:07:05 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, tglx@linutronix.de, paulmck@kernel.org,
        mingo@kernel.org, bigeasy@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, frederic@kernel.org, ankur.a.arora@oracle.com,
        efault@gmx.de, sshegde@linux.ibm.com, boris.ostrovsky@oracle.com
Subject: [PATCH v3 1/7] rcu: fix header guard for rcu_all_qs()
Date: Thu, 12 Dec 2024 20:06:52 -0800
Message-Id: <20241213040658.2282640-2-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241213040658.2282640-1-ankur.a.arora@oracle.com>
References: <20241213040658.2282640-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:208:23a::16) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH0PR10MB5848:EE_
X-MS-Office365-Filtering-Correlation-Id: 875a98a3-064c-41c9-e21d-08dd1b2b9a9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?czYw8b90K8c53VZC2ASpiagI6Yx7u+7xppxb+3DnOt2hu6BTcFUFfX1LY83U?=
 =?us-ascii?Q?Qh2H5BBkIh999lE4OUIN6MVKTtHbiayO3uvKT07cm00Hbb9904Y0+m4ZM3zV?=
 =?us-ascii?Q?mmoTIYuO8CeX9Ub6crqtpp+Wab6qtBAiTFjUhRBJZCbZ3a09JumWRAM56j3v?=
 =?us-ascii?Q?JBSeIGYe+YPHadZ3LN0boKkkmjloiGd9T+khKutHdQ/MIueq77IEYmbN1MVq?=
 =?us-ascii?Q?MtN+bzu6jEPiZZAcO5/zbvJt3MSwLApgIYWDgAk8GFXT6I2fumLJ36WINJ2x?=
 =?us-ascii?Q?GqmfQcWLGdK2Ol47bvMCxStqJi49qr+Hjy5skGZgLNsSPs9iR8WrqS26qXMa?=
 =?us-ascii?Q?1Oqc+x0QUtORRUEnr/c7zcHbAbGO1x1gN982ZrRK6JxM17jcejNhPV6UxGjw?=
 =?us-ascii?Q?bCZEkd0WT9LIhwcHuYrb4uQ1XU+KkNHYYAJZoYVSu5+yQKXpSKacOVa2gC65?=
 =?us-ascii?Q?gGRZNEdY9oQYYGS9yQ/E7niTaDQyPMCQY4yS6pQ72z7YL7Zx7mMGp47172EU?=
 =?us-ascii?Q?gq6e315rJqKIqgkSXyDDtYoTvXFxSkHHED5n2NhRmGsiByAgCgmtJyu+LUbr?=
 =?us-ascii?Q?ownjwvd7eEmTAHy8ZfKM4laz7oEQ06BUWgTTkLblkzEaGAmx/uYNNvEFkYw6?=
 =?us-ascii?Q?HqQdevE/DNtWQfeTI6YsrMVOkD0tgnPNTrrKQ2TlnwObU/eFH1XmWT3XENuR?=
 =?us-ascii?Q?EJYt8R1qrThJi8FLw7hW4MEdjkkSJrB5M8RnIOShmJTT+E4zoUSm/wfabeoR?=
 =?us-ascii?Q?bRV/rTtevvtp/8zMj4BOgitNClz3cwAav2YU6wO7BXAh/sXQLaABEJ/QUsSq?=
 =?us-ascii?Q?zI0iN0Z5fM3Hq5TVy+KyLGr5IU6pFHzzrCHQjOXHc2BreB5vAHIXFsMSLjRM?=
 =?us-ascii?Q?Wr75mkFK3xDyHvj4c4FpcbKFyyT/ijzZiAeD2mzI7R5rtbwo7jhjTBO0zR8Q?=
 =?us-ascii?Q?/6F6kkOfALdbBgXYx6T+ogMB4b3g3fP5QqGZ/U6AuQud70sWyxwE7tNtxAfa?=
 =?us-ascii?Q?jmWl5UCxa6WN2Px+t1Otr8wINxik6I0igqfGCJ6LsB/p7hz4pSPXRgEQe1+w?=
 =?us-ascii?Q?L/Rfo52J5WAQHSV24A99FkS4doMX02TdcWC0Vdx5B4wd2P+2W6y4ritZV23A?=
 =?us-ascii?Q?T3qIgGIJqx7mgABsY2s8V6vxbsrSY0ywxJ3+mGJrGds11ONUCe0y1wLdLFzB?=
 =?us-ascii?Q?AHNGy+BtJbEZhmnDh15WMg+zgvNKSdYE/R6mR83t6g9tl2TkOIhGg0QZrTYe?=
 =?us-ascii?Q?UFp4o2aa9i77DQ7NXpsH5E1Zv/SHuGPyq/4Az7suaxnnir/wzcjYV0MHMkUl?=
 =?us-ascii?Q?2rXI45HbB5v+FnUH03QhNFNiy3m9w/00liBGm8RJ6fKIrf5WMhaYG8YiDfvp?=
 =?us-ascii?Q?B9VKDpw8wc01EdNTyQ3XNpGBx4Vh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5cfkCuQE+afHwBKAW9YG4TGHTudI9jk2NRRfUiy/YGxgfk5KOqWFAWAvW7AV?=
 =?us-ascii?Q?POAIjxLHnRUMpWWNt/5mQ/SSIhXHcY4ICJ5eX68KhbvhfjAOvA75sYo1PpIz?=
 =?us-ascii?Q?AC/WKsNv1UBTIlmzYz27tQ7dEH6J4RtwCvKkLEOvIW7jOhFcdP6lmrpBqs+T?=
 =?us-ascii?Q?vrYpb1XmuJG89MQni7w2xXl2Jkv8q6VhEnCSbId5gMSZS02ID/Id1KTVZYCD?=
 =?us-ascii?Q?ai++bAXKk08dO1r9U66/WhEkQ6bdqFTkAQHK9d/a/dsOJpV6rspgNU8XFKo9?=
 =?us-ascii?Q?6l3lWet18JHCQzZtG+UJCsjG/Imkq2zUeyXOE7b06liWeNBNTV5ajEyX1dRW?=
 =?us-ascii?Q?GOub8wtbExag/555PjzX5JIjVvNi0TwGjfsWnSsCQz08okE39AAhX2VdLwA7?=
 =?us-ascii?Q?YNLu4Ds07e3H8NXis0Ct5dlyxMpN2IOM89SX4YuB2UdoYYM9TOE/PUYNb0gP?=
 =?us-ascii?Q?lG4IGqd2xvtmltg/YKsBHWSMFEigdVKQDMY4vkB7O8BGb5dQDFhkKb7+99pZ?=
 =?us-ascii?Q?KQdL2akUSqlrAEQlZg477CEtx3uYBfn6xS1Z3Mykqg9vOhxS1kYi4Y486k2q?=
 =?us-ascii?Q?n1Mu5lqnp0xRjoxgvDFZR50h4L0HAFnWcnxRxKFkQtIMiulPFXj1FsevX/j1?=
 =?us-ascii?Q?+cEAm+AU1AbxsFwg1NoFXRATb3Lx6r8sHz0tRduS/M6Zo/2NYuhscXrSno6D?=
 =?us-ascii?Q?OCXa6ynaKOaeHi5Anq/x3uzMbCo+UWiOSt7fJd3s+/mr42tViTNCAOP3qxN+?=
 =?us-ascii?Q?91T1Ab0rLcsyFRDu2oLQyBvgT4COhuShkYjuFN/8EM9bBSriMl6zOSqAGg/A?=
 =?us-ascii?Q?eGeQ76vivjWkIJL0/u8fe41pzhceSOZGaGpLDHa+vZoRVLRkmBiDuwNKmWxo?=
 =?us-ascii?Q?U5tol2ZpJ/ujBr2tPAKdlcLAUqBF8Ufht7NasnMKEgQVvE9O/CtTgmoc6p1+?=
 =?us-ascii?Q?7C2zkgdnfBu/xnsXepbRGTgjZTjjZE8wjwmLS5MiMX9ht0Qtfo69vb948W/R?=
 =?us-ascii?Q?2hxRn4JQCJpeZ0KAw4RwsvJnHA24znQozAxe/Lu5J8HmMViUcC6WRa4KkaP/?=
 =?us-ascii?Q?X5Zw3BILxGQl4Rdn5bXIwcjqB6uMGRhwOXqrjFEhB/YIKiPwChAY5yoO2wuE?=
 =?us-ascii?Q?qUOZH0usFnH4JqORfMxTcDKHpTXXbOhdZjZI0l0Mae2xXaZb2WIgEkkFo4AO?=
 =?us-ascii?Q?9rx3s6gqJdxre1/2Ky+rJs43WqkVRK4hrBcxTxb5yuCH6pxyx9lnvLT/mEi8?=
 =?us-ascii?Q?nTgGVb1wPHT8dUvF6TiHd5T3GPEyEE2SJt4Iu9y8h6MSFRg11tyT0kdsbAgz?=
 =?us-ascii?Q?N9ODoo7zZwlinxckrH7dnWKmrP3Kn4A6Ija3JeTn07Zm8Uhz0ouqkqCxmcq5?=
 =?us-ascii?Q?wZfm0KR5c45vsKpJaSDyt2b831gANpW4276qbBlLAO80/XKQ+mIWlWm6DdXc?=
 =?us-ascii?Q?9kRyzIh96u4DorX1gt+X+MBYqm7mhlYW5w9Rg3eB3psmcWZM3zqTp/kKbukV?=
 =?us-ascii?Q?0U75gYm6guPKSxu8RFGyxVQqp90nxx+pKOWTiVxdarKtn34OlPJL9TpQTuuB?=
 =?us-ascii?Q?iH1mXuzwdI6gg3+cuNEmGHJAqj3mAtNPa2RcuSe65e59BGEIay7ujwU9Un6i?=
 =?us-ascii?Q?+g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	A92hNpBXesoMuyClYn+kiVpCxSc1pmRGtP9GG2f2ZHVJ2qoXFiu8ahYJecGcXb1TB4K/99QAgNj48WQLfxMiQcLmgb39jDmt3IwwtBwQK6MKRr6e/Lh7jAEudwmOZxYkQSzgHmn3lDSXTT3OL6mVeYoulPb4RhmNK9pb7re0KOR9GytL+S/S8b/b5IRew6imifOxtsrMUmaxZ4USdefhligwC8W+pVTXUei5ydCHsN5X56bhwh5jtgvZ3ATvBgUXtaBorPTROziyorEfyk8sbEOxWDfT2sSvMwGW7GYP9Y0E0BJotrmE4g2S3WF2Up+Q9zf+5dpOqcS2ODZZsWtPnWH4DQvxVmpw5cDUFhykIU0sh5M8VcZYub2WSDZlo07Sm5oL1AHBCWFraY2fh7hNDP49ggmzqrh9dQqLlVB8Om9YrlodfkxMjIM6Rs7QFNGaFkEdiU+x7Yf7tAChujXiIABXGozB8bfE2geq9wQFwvY3dXgEX+jMFf7w1kDYlXKYrpIelf8fFRfPbk15y8AhtaP/LGZuqo9NGpVDmnVX6a6Kk6/Ge0KbeEYsUvymCzOHreH16iH7f5JxCzZ/tFuC/u5Kv+FAWNpMkSwL8VjvuSI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 875a98a3-064c-41c9-e21d-08dd1b2b9a9a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 04:07:05.0705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hWuSzC7gi9TKgUp16UTNG4SUdPXh0HjLMu4PA9hEAaRqjdrZQcXdIbl65ub0nQNkq5jN0yq1YlXgf6GV8S+Lg7+Kx6pUmF/jzI+ITTArc0A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5848
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-13_01,2024-12-12_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412130029
X-Proofpoint-ORIG-GUID: Jx7WPvTTvXJGtdzxrT-4z2AKiaXp-stc
X-Proofpoint-GUID: Jx7WPvTTvXJGtdzxrT-4z2AKiaXp-stc

rcu_all_qs() is defined for !CONFIG_PREEMPT_RCU but the declaration
is conditioned on CONFIG_PREEMPTION.

With CONFIG_PREEMPT_LAZY, CONFIG_PREEMPTION=y does not imply
CONFIG_PREEMPT_RCU=y.

Decouple the two.

Cc: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/rcutree.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 27d86d912781..aad586f15ed0 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -103,7 +103,7 @@ extern int rcu_scheduler_active;
 void rcu_end_inkernel_boot(void);
 bool rcu_inkernel_boot_has_ended(void);
 bool rcu_is_watching(void);
-#ifndef CONFIG_PREEMPTION
+#ifndef CONFIG_PREEMPT_RCU
 void rcu_all_qs(void);
 #endif
 
-- 
2.43.5


