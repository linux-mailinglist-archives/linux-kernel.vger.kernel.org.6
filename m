Return-Path: <linux-kernel+bounces-220171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C85C890DDBF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 22:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9B5F1C231FA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 20:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE10185E5A;
	Tue, 18 Jun 2024 20:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="opwmJ/mN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GYwFZZmr"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F00178365
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 20:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718743728; cv=fail; b=YbF6drLyrzWBCzqyXmsGNqGQMJDnZN7u2+nMIfKBuJ6c1Y3YKn9axwlrmYt0OmaO3acRBLLwfEqsGQ6AZsloScJ29nnaO08L5zeRprfQdkur6Fy/mirU+DZfi47lc9WMBYVcqk0/2s4vT1oqOjrAtfrk66KZA2sdqfuGQmtx0X8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718743728; c=relaxed/simple;
	bh=zCbaNvaBmVmJlyd5o5WUXlr5wo97P0c7jmpqQjWVnqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e/2k4WgZJMTmcJlSTOVe+CWOU+PKAFYEejpjrFCnZW+lCdGpKxGPfHi6I6AqeYcShAHOxKTNQdYw4UOIwl1viU+NZCR8ZmiRzRCZctV0gDSJ6yOBbzCOCdIUHEmejITwOT07X56NkbBVvk7F4+ZpSXhgUs3CHxeWHjz+pnxEMgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=opwmJ/mN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GYwFZZmr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IIUkgb029421;
	Tue, 18 Jun 2024 20:48:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=+7Q97s4qRY3TtX0Im3NHWdCMkhGqb6Gnlnqsc/XlV58=; b=
	opwmJ/mNWTXe9s6j3D8XjU9gfHRQmVg+Oj/xf6xlyWTJNwmNuPmMn5Mz/xKZMEB/
	DZqZf7lFoMyrVSpVtGmHNtpCMTO8fNUBvTGII6DD5FxInUv/VaXFpIMG6j3oJyXJ
	qGWoE9XawfO6e2cY2JPp6O3lSriqArpc3QOa863bMixOHj/HWbnnYMkObTLdjBVb
	8DyAnB4vcZ6V0ogm8qUB3EituBkYzKyXlTjpRm0sto50TZ9q895gkCIb5Xr1kV5E
	MF7uQ1+8PlQv7nQYfZVp8ZjoDm6vGObK6JCwl/BjqvqqtLKqIp32PqSVCMfmAong
	ETpvNZLELifWxoUbCKBgpQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ys2js5tnx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 20:48:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45IJlTIT034656;
	Tue, 18 Jun 2024 20:48:33 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1dey4ud-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 20:48:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NpNH5RdnRp88SV4ZUBvxXeA2b5tFa5byx8qX0GDbDMuxNDqtq5ojRXwe/FV6hLnOiC8h3OLIc4eHsBiIICNm3xmDCOJUKhssVxsaxrZeu6nrOrONCMtpAs5+xu6X2EKPGXeLe5V+KtbAvYtUUlvVKHrUhCEis2IyJqAMNfgyISIRn3Lj4eDMvc0DSt6D5BMAUfxKnRiLUJoiTBrSBZaicePAJN2I0twYcN6uoD3q80NyqBfAlcF5gUpDTTepHNiq9vzU/szC63biSb6d119XKMN+QGqsGe+NPzJWwWUsEoaq83R4L/fSg8xql0ZXXuy1LsI5Bo/74oUdO3k+dDV+BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+7Q97s4qRY3TtX0Im3NHWdCMkhGqb6Gnlnqsc/XlV58=;
 b=GENVcuvL+zhYWOJdsmsVTjQql/LgZ7fc+ZSQD69VY1exblXsSP5QssQlyt6BYhccBPb4qb/9RwTiDen/vK6PUxdz7Ui/CTi7VVK744TubhqGdRItpoihPCdfIRfDAfNk5RR2VBW0VO0TrTVsc7f+oy6FKlhI+WN6x0AhLBg5RWExAX6QQ//gXx6RYgdElBUghAYA1fB7/77Fj9Cmx58F5aS1tFdjhXG/O92GmKPTpCDKOCTD0wTngJ/3vxWSve69b1NH+f/wqSBpR1g/m5X4XBj7byhV4jnVxQ+VesEsOuiMYH1ICo3EULgyXxNQDIs0FPQtE3qnXvALkeFyRSsnvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7Q97s4qRY3TtX0Im3NHWdCMkhGqb6Gnlnqsc/XlV58=;
 b=GYwFZZmrvNnAsGmFtOszJqW2/+Mqr+fh1cWOoCmOLfCs6bb2cjS6ZAPxsBQY/SF23rgSSd5AMvrTjoImYne7IpHWRsI+X9tHOK8KqVnXaXEYd8WNgRp1JDBpoRPmB0/c1r4K6D/sohnj0cAz5XTIkLf6bG123fAfXsfoY4Xs3JU=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CY8PR10MB6465.namprd10.prod.outlook.com (2603:10b6:930:63::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 20:48:25 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%7]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 20:48:25 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v3 12/16] maple_tree: remove mas_wr_modify()
Date: Tue, 18 Jun 2024 13:47:46 -0700
Message-ID: <20240618204750.79512-13-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618204750.79512-1-sidhartha.kumar@oracle.com>
References: <20240618204750.79512-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0022.namprd04.prod.outlook.com
 (2603:10b6:a03:40::35) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CY8PR10MB6465:EE_
X-MS-Office365-Filtering-Correlation-Id: dd3ae489-917c-4026-ffb4-08dc8fd7ffba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?TQTP7I1oyLVCC5JVedKXu4MPKqKRL8NvoRvdcMQ0EpzXzUxGuU9IvDH8Q0qn?=
 =?us-ascii?Q?b2CupDznOnHdDZkak8EShdfYWxaBRv/KgOWG4QXNRYoVEgGJGkL5zQ9P6htT?=
 =?us-ascii?Q?7C7YdzIztG9MJ36uNewUPuIB8Z0/NB+3J0nJTewuHU3VJPKdNgJcTbnCU7rB?=
 =?us-ascii?Q?OfeZr+su7vS3FEvHbnQprCs6mlQSb/rQpZ+W8BEbyu415fO9zcBSk4D7ku9c?=
 =?us-ascii?Q?ATIUVxVjP4hxvwqtgALJomrjViZdfiDE/WFxcEa0s10Z9oI7twAVncMPbuiW?=
 =?us-ascii?Q?8iUZ2PaihzvtedJva+gDatOUDwdnfc6xZYCJOVOTJ6whQdBSkT8RMmTAwQWH?=
 =?us-ascii?Q?5l1yzM/uGmwu3kRfMki5UcqEx+2kDaJwA5xS/QUox+Y+egVY6c3BUhk1tevG?=
 =?us-ascii?Q?KFdtN4EI+/HTuWnVe2if8xxIfsYOJwA57kzDEejN2nvDLnGa50Gg4BI5tRQj?=
 =?us-ascii?Q?/KLJWu4FuFiwPgFJf1Dfxxq+fSbMvPPJCzxsWcKXPtyViE79M0iZO0C78mfC?=
 =?us-ascii?Q?O1RuYFa5kgjV8cpUdjSmInXgaRcLkKtuBzTTMKUPkpNPxl1aIXqQPbSniOXP?=
 =?us-ascii?Q?+RmtAB4ZXqAXJhNBWrVzIe9XFjeH0Co4ojr7HCut1Hdj8uefJUhoTpZbeGGx?=
 =?us-ascii?Q?HJtwtmiiIgPPdVqmvBrAF5WwTDx2qEM0MyK0szwF36epFEqbt/yVMvcV8d2w?=
 =?us-ascii?Q?1kXXHM3GZ7VTQ0Ade+2x1nN/dMj8ptsfABYC2TtJBp+pujsIVj+pyfMwtuWF?=
 =?us-ascii?Q?YExhL4YYTQxesUoknKDcZa02R+uyG7LOcIxpUJ6WCnV9v5MgoczJUWoO3N7O?=
 =?us-ascii?Q?NFInzosFlt83r+27xXqJ7X2Rj1P34FcU/+AklN/A+OYKLw0PDeGBX14i6p1j?=
 =?us-ascii?Q?emPPCapRdmIKGPIurSwa3tQOL8DvzUzEs2WUTmPDbsQgp6zFMnCI2v5LcD5U?=
 =?us-ascii?Q?9j0BaLyhmja3R/vzu+Nsea5y8+WzPzhV+eHq+vykShaOWr87CeWnVLyIp/2m?=
 =?us-ascii?Q?4jc4liQA6InoQ4o52jFIOGVtaV7/QfLN5lH9J7LxwBO2WMhrgdLeNLR3ZXsN?=
 =?us-ascii?Q?caRjjk2cOVt5WCFcnlymuZ5n9HQYciES1H31QZlZhCQRCpNLncG1EC4M7w44?=
 =?us-ascii?Q?P4Vv7HljB1bBbzjtz1NTuyRFn0xE5WIIsYZ29DB6qsGcwZ97aHlGxrwywNoA?=
 =?us-ascii?Q?gHGczzTtY5N1hhUNHbpWPI1uj/Me+ptZW6wi3KYM/NG/VYlqynSOTJMMAVgt?=
 =?us-ascii?Q?veEQ4v3IUOpHNsfS5VZ5vtvIuCZZa9Pfeaz83P6jZXOKMmcKUCzN1RhtwC6h?=
 =?us-ascii?Q?zGg=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?1pAjqSFGFwhtkGxoVT0a43ZRLrW38uDJyR/AJdQiaoQVuPaWD71ILDALpoQL?=
 =?us-ascii?Q?bX7L3iIDhmKEB79XzDDKW2O2HQXsChAo5X1IFB0drFmwZg42gHFMHcQr9963?=
 =?us-ascii?Q?4MBBeHjP3OZE8Jyyf+43QVNVHr8ICqPW+JghpLO3Aq2OJVtQutqIHN/uwVy6?=
 =?us-ascii?Q?7Z7I46tk1ZJi/AxaPIDl4ERcVdJgtrULKuTZq79bRkAlMTrSgEACRjnPbp1n?=
 =?us-ascii?Q?vPcEstCnf+jya9Km8zFdE6u5itmT4xhSJOfvQmir7QX2p7btJiAX8ZmdVT/z?=
 =?us-ascii?Q?HfyaXzbeoQF2KjAPoq7bz1Pm+ABmM1NQvAQIGBduAjEnYtQHfBmlMantHJR7?=
 =?us-ascii?Q?ptzJSjnYS6zCGlC8vY4dPQvsB/qA3F7aTk1zOUzGMWr6aazqw8Hg28T+ITCq?=
 =?us-ascii?Q?irQe/H5cRrGotrzXL5efcFmS/JV8ti0nmScU6r1tvxlVjyuPIhf81X3eIXNM?=
 =?us-ascii?Q?EuDPCafWoEavfwOPfixTlAEa93I8JfqrtR9Iaax7E44yj+pDBrdBv7H7wW6Y?=
 =?us-ascii?Q?zJ345tqoYO36zvSxdw2jrF8gjK0wIehQXf1D6MO6yzVDcN4KUm0O5tfo/pwX?=
 =?us-ascii?Q?LeFLtaHusjc72JKmCGbzq9nYEHdvcEC+lkfVKUQIBx1agdiDfnzGRxv4fxG+?=
 =?us-ascii?Q?eFEk4D1opEbnpAuMjyDGxWPYM5IEjHPFXOtQ57VuYSIFFqQmsO65WjtVdVO7?=
 =?us-ascii?Q?LD4lv76QRSvru03Ef65BcOCktJb+ucYDWBvTGik4rwLPohBoMsluM4iDQ9Gg?=
 =?us-ascii?Q?yMLwf97voO5mWJFupNKjETxpDr2cmO5gjbzt2OWNXSIkPY1/d3IZxjuy7caL?=
 =?us-ascii?Q?NBhgvoj5HTJIeHaq1Xg5A0/Cyv6CdPA9CKcTfSYdPXfggENqTmmphsJyVmep?=
 =?us-ascii?Q?dsL8QVcICqaUQHag9Tg1tZ5HppjZbg/tiYNgBmY2G0u2PwwB2gA0gMBG0GTH?=
 =?us-ascii?Q?DXcDOMe36cy8WWALf22ljy90t51zT+uxVWC8T+aGe9F+ObUUOq2XQX/Ik4Ac?=
 =?us-ascii?Q?8yNjNjpdUbRJMWHFiQD14Ry2INTeN6lDmSuobc3FtsE6C1YxMupqt6dUn3ly?=
 =?us-ascii?Q?C6WO3/EQmTmuxaOUXh3dt2CeCk18+VLUaDuX/WqhHeb3pRvU+QeiwjLKfYIl?=
 =?us-ascii?Q?OeiZY9wGO6xgUJQqA5QNgsfe4bLlI0vLZngLaKoqYUU+RSmbf/e9LMkN+W/H?=
 =?us-ascii?Q?+CCMy0qFX0MimEePRHbo+ABzmmkVLyq9t4VTmxQ5dLKfRWPTiPavK9sfpcK9?=
 =?us-ascii?Q?e/me+7m+gzqoDWkh77KLvn8Ws5VNw8jvvBzd7dr2mLy6mavU45Cp3KeJG0dg?=
 =?us-ascii?Q?ZuFXbkDlkMmAVrQsUPSuSVDdB3ymV0DCUu1/AbzHv14AGDlOZWInOWZygmiJ?=
 =?us-ascii?Q?ui6pHhxiPPvhqF/YHF+A0A19IaGa3nmQ2EIUcAfr5uPu+pNSYi1sJ6A1Y5ug?=
 =?us-ascii?Q?d5zYs7K7LjHI+iMku8GSPV/v9os+Eirf3fqcDxpsssNK8UyytlI2LwDZuNqm?=
 =?us-ascii?Q?N2K1cPWYzFEUs614/5e+9AwpHWdQDyi9r+TcTUXuAWO3xw2xkuyE1xWyeah1?=
 =?us-ascii?Q?suV6kMTm/RQEAjlA4ze36UsLuzG2sMsUVhdWCo8SLXKrUCJbBu1TuRryM6tp?=
 =?us-ascii?Q?85hEzBIsfwYgfc3ulZG3lVI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	xL9KqQPuPiZTTaUC2AAKrjtfTnXWetyI9FO7Rc8z9L4G9VEL4GzgrDG6N96w2lxgO0N7k0JHVtBXYmmRAWlygA8L15dMzPd/nIF6d7eTJ5yP/Cv3DpUk3SeDXaGmalQC42xxvBOh5+atf4/0F7rS+PL721pSzPTgNMqZgIXbffLhmpG+Kjcfvyn8D68EWipS9j9ETEpm0vuEtFempLuXl2EKCteK41264XVBeclWVa6Qv0fJq3ocELkCXuIYt4FoZDAAA3iZDAfpknaQ9PawXZ49bAONIM8YGfxt/Ure2rNxkpsszaJMjVDnVC4M9yZK2zTjZXamsKzb0D9wLMZDgh+7QnqbslDTko6D6sBq1TykAK7M8ygec2evZxli5oxl8LnAeYEMIP9BAPAGxFE2d3Ck6BM3RVaCT4q7P0l/77M74tuYcYXWmFWYyHLiiNk+/AEE8FG/t+IWs/qs8LCsdqgCzUjCzQ4SPz3a3vFQeSl6EqozzeOVH8Uo9Urnbt6M7r3bg6W+AJsdsmrycS6vn0h8UVBrnlgDVZ1PLvQUw/CAa3pg/zvsthNpUg71CKsUQ9PKMfy0HxQuU0X+EZ+SU8k/aRTQNq6MYQMVbvCU2hc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd3ae489-917c-4026-ffb4-08dc8fd7ffba
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 20:48:25.2591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 433mKzRK86Ervj+OT4INQrr2XEvgTZq7/1oUJkug2eV27iltZ3hDyDoE7vfdz9LXZzXsORxDvtHy9Pvysbrg6jvvFO6FyFT1FcgqxOAhCYY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6465
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_04,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406180153
X-Proofpoint-ORIG-GUID: sVJTecTe5WnNxmJPMsQ8mhMJWQ2MqGcQ
X-Proofpoint-GUID: sVJTecTe5WnNxmJPMsQ8mhMJWQ2MqGcQ

There are no more users of the function, safely remove it.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 38 --------------------------------------
 1 file changed, 38 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index b2062e034f89..98c64aaedb55 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4155,44 +4155,6 @@ static void mas_wr_bnode(struct ma_wr_state *wr_mas)
 	mas_commit_b_node(wr_mas, &b_node, wr_mas->mas->end);
 }
 
-static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
-{
-	struct ma_state *mas = wr_mas->mas;
-	unsigned char new_end;
-
-	/* Direct replacement */
-	if (wr_mas->r_min == mas->index && wr_mas->r_max == mas->last) {
-		rcu_assign_pointer(wr_mas->slots[mas->offset], wr_mas->entry);
-		if (!!wr_mas->entry ^ !!wr_mas->content)
-			mas_update_gap(mas);
-		return;
-	}
-
-	/*
-	 * new_end exceeds the size of the maple node and cannot enter the fast
-	 * path.
-	 */
-	new_end = mas_wr_new_end(wr_mas);
-	if (new_end >= mt_slots[wr_mas->type])
-		goto slow_path;
-
-	/* Attempt to append */
-	if (mas_wr_append(wr_mas, new_end))
-		return;
-
-	if (new_end == mas->end && mas_wr_slot_store(wr_mas))
-		return;
-
-	if (mas_wr_node_store(wr_mas, new_end))
-		return;
-
-	if (mas_is_err(mas))
-		return;
-
-slow_path:
-	mas_wr_bnode(wr_mas);
-}
-
 /*
  * mas_wr_store_entry() - Internal call to store a value
  * @mas: The maple state
-- 
2.45.2


