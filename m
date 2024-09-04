Return-Path: <linux-kernel+bounces-315690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 872E196C5D3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 19:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB0DC1C20D51
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186B91E133D;
	Wed,  4 Sep 2024 17:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Jg7hhNFW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BSvJ/vVo"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE9A2AE9F
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 17:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725472544; cv=fail; b=Hljr0/+JI+vL8flh7upRQT5fXKw/In/xG401SoR6s5gVIexkeVyEJc7jasj0o/1uShp6fOEFyK+61drU6J3uCmxPmF3Ta8nqmAyUE1y6aoP7jf2ip09RavRPn/tCO70c0FgJa24SvTU6FXsD0tKNtqbmgsxBhxs6fpKmyU4wScU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725472544; c=relaxed/simple;
	bh=/nQkigZAOWvW12VOtwcsuwrYtT8zUKTbY9MY+L8c+6E=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=heZTnSernM30t0bK2y724avaKVgaY7zOHBZK2DBdLP0RlfWGV7GPYJfcw4T9YvfXy4XCF0JSK5XttfbZiPMIukmJQZ849VUsXTm5psj518cDmuoogaK7mhCbGX5Nh1t4sxN+e2tE1kN0YiHG47fjnJaIWea7wkG7nncAYGxD26U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Jg7hhNFW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BSvJ/vVo; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484GtWpi010653;
	Wed, 4 Sep 2024 17:55:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=InwKvS+/yHjUQK
	B3Eht/c7Z9/l0a3k74/Y1lp8rhrjw=; b=Jg7hhNFWhUztgKxvR54YQAHEaX4wRS
	MYmuMbDvrdoXEjjdRGY3Yn93aB5iJk8ayR0HkxPuJFjuhHFXKF+L/LC/nEHOumPu
	AomEXXlWxtpXdQKs4fVa3+fjXbZpMYCevhIhJtLaaSs7TpRGW9XR/sxpskXCVcfR
	POM5wn7FjEITcYRNb7Kp/NUDuFXoO1H+V2Mg/ubeptnjc7uKEhSozESruqg5tdCY
	ftYwQLeI1jSD50ydjDkoGNeqWBKwY2WmkY4FCG6tHZK+rigQ2skzi9AJxX53sxOn
	3RftPxSoygVnGMg34QJaCf+xlkieDlYNM22pdFlh8U6dUEHjcKw0dCbQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41dvsac5y1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Sep 2024 17:55:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 484GnS6I023567;
	Wed, 4 Sep 2024 17:55:35 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41bsm9wtap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Sep 2024 17:55:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YORSY5b+UhrJk+GhGXF/EE1Mgf/IaDESqnhN6vOET9uUKV94ugAC2mGZD7PG4QPq2w6rBXKVVzzA2EHO8vbhOXxvPTN2ChEDjQNI6z214ICPvP8xl4REtee/JWCX19vVsWeQJoDGKKKszUNwcfibK5fciWvqE4XAk60JM2OUX4kjOKe70JzpRbQASV9CXksKNgDIkPwNPCUGtka4HJ8yxoLxRfY/cqDm1vucgAWkeYsG+JPQUW/jhK/a0kBewyliT3R0v0qNA+IK1tGEZZtpEKPY6MnKgxserxFMkVxTAk+3eCUoTKoQlgRdHnGGRPt2xBaIt9lBWQSJoRXKN0sKdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=InwKvS+/yHjUQKB3Eht/c7Z9/l0a3k74/Y1lp8rhrjw=;
 b=F9REZtKnWDhAQmRISg9JiLyiO17tKJ1FhHHeVfuHWmEj9kYa2v99aED6GA0qytR2kE2E6PXlq6wXQS7J8OT2PULOoWTQJiLun8SARZSb5mlmA29eTB/rhSEy7x4GEub7Z3O2B/l0uYPJ/2qXlYF3YRxNq/4Ssrb59SGFBIZ4HF8pQJfmqtr4K7UUBVGFzISp33wSV34kGMz1mv29zBFWrcxbjuhZkddWkKyT0QKK+sbq6BJbEdur1NyzU5gI+evrDdCbiFFgvHnyGS0PE8FmYbjzrq6yRfYLbHGcQ0PfsMKPqdO7XH+ENx0vVvPfRJ7T06WCF3w/023wW0LAIhqKUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=InwKvS+/yHjUQKB3Eht/c7Z9/l0a3k74/Y1lp8rhrjw=;
 b=BSvJ/vVow+GjKa3C5WngQo84Ja4CbGe5dLqPNlhOWH0ATi8oIir0Ao0m5A/z4dXszBBsXIYuUzXFeGu6XtTEtgKRI8P5km73ZUi0Bv29LDhvmq0BvIE3iHsKQH4r7DAUg9lVxT/JAfah5q+2z27hKykk+iBGMnWl8pus1oTRNE8=
Received: from CY8PR10MB7265.namprd10.prod.outlook.com (2603:10b6:930:79::6)
 by CO1PR10MB4420.namprd10.prod.outlook.com (2603:10b6:303:97::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.10; Wed, 4 Sep
 2024 17:55:33 +0000
Received: from CY8PR10MB7265.namprd10.prod.outlook.com
 ([fe80::d299:36f1:493b:33fc]) by CY8PR10MB7265.namprd10.prod.outlook.com
 ([fe80::d299:36f1:493b:33fc%4]) with mapi id 15.20.7939.010; Wed, 4 Sep 2024
 17:55:33 +0000
From: Daniel Jordan <daniel.m.jordan@oracle.com>
To: Steven Rostedt <rostedt@goodmis.org>,
        John Hawley <warthog9@eaglescrag.net>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ktest.pl: Avoid false positives with grub2 skip regex
Date: Wed,  4 Sep 2024 13:55:30 -0400
Message-ID: <20240904175530.84175-1-daniel.m.jordan@oracle.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:208:335::10) To CY8PR10MB7265.namprd10.prod.outlook.com
 (2603:10b6:930:79::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7265:EE_|CO1PR10MB4420:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b1a58ad-b534-497a-057a-08dccd0ac5d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P1b9l1d58fJxfxceERB/Eo1KUM523xz5Oevs/txRc67CTLtR6i23IPZ9Jfzo?=
 =?us-ascii?Q?XNbGKgDpIunvt9XBXPV3TxVB0w6YbCyfMYhcpzogEQ9BzajKx7Fq2Jx9diIv?=
 =?us-ascii?Q?5EqKXFFrgHkzd8qzWpyUTdvaFS7ovD11Zqp0KfDfBi1jXTc4Sev6pmBnY/aY?=
 =?us-ascii?Q?6CZxUkaKuErCsYWXrCwHBEhOMchZDPnQf10JKcVZKfTzUjQUCrF6TIUPa9CR?=
 =?us-ascii?Q?/dobITuhvBJVbMF9sezwbHrCzSecmftIAWH19zXaNhez5wRIJiGA9WFC2SqN?=
 =?us-ascii?Q?rmGLDbbd/h/CsLE4rvwLXRuEsbh87sEjaeht04Lpr7pDwZZOMQW3RFQl1Jn6?=
 =?us-ascii?Q?JaMghflBGdvWJYONOnWuBtCBgKn0ajhfNSsvYz8ABxJHbfZLupqY44JAKcw1?=
 =?us-ascii?Q?U4vmAa4gysnxdfUgb2g+uIPnFKvML4+DXF1r4DzGIq09nVgFKDw3rHZiiySb?=
 =?us-ascii?Q?dKXsfer0vYfKsKHFYp4t7dGfN8ATtRzbQo/utcwZqNg2/Kwm8hYC/UwU1/mn?=
 =?us-ascii?Q?8wjiR632Rj3FziC2t/yTOd/sonq0UmMTkuMJA2dNoXw9BZ9AX+7V9bLY6lCR?=
 =?us-ascii?Q?aw5+hyoLCFOCs/ctR3cDJFrbC/UfLRn/M3m7bXEhoHJkkNP1FyFayXNL5dTa?=
 =?us-ascii?Q?b4XfU/PD9PgG0N+e5awQWmVinPy8LrlytLNvJKvQ3Ym0AAkqpYl0mQbjaxKr?=
 =?us-ascii?Q?q7BlIKY9FnqysXECY/BR3ZA5TmOJC8wMR5jxKwQmAd8IqADpc1UAJfAy+nOD?=
 =?us-ascii?Q?LczgmJgkRNe/FoYYvqGEFT7mOxqFTHmR/rQ+UODqcRpl6RU++rbOy8/OHvCL?=
 =?us-ascii?Q?Vc53PzEo0Xfoupv8NWmhxneU9xS9hCyuWzBNHM/mKRQ+WcANPiK8LGg2JbKn?=
 =?us-ascii?Q?Ud9mvS1MOXBDdRqGusMuuP4UxklB1DgNBybhkBrLt+jUcVy1A8g62X/5yFhD?=
 =?us-ascii?Q?v6Ov2pGO3YUqnGomrhOA9j6bEv1xyAqWxrV/S4Nr4x0w00YLWQECWJGjb9wS?=
 =?us-ascii?Q?i8GW+mnbSfjDBJdEg7LxrbGsjx2QMm8k37o6oa9MAjmyBrv7R2y+FiInZlQI?=
 =?us-ascii?Q?zsE/cTBRPtGYzt6mvUz8DLpwGmZEt6xLT/E3OX0StThlmUVOL9G4FkfHrdDQ?=
 =?us-ascii?Q?+SjDH3N5vWiuArYk8Uu95PItDQg7TwVVNRma2pvMR8gTyLUSdWUtCOMz5IWl?=
 =?us-ascii?Q?CxTc3kk4xp6Oz6IWFlH6yjB2ueDdbaNqvh26lsF16KFKT4VKACpOXhIXqoUv?=
 =?us-ascii?Q?pf93yLhn0AAzsGLojhyn4PFcROZJxEHQyzwDAcGbcJ+zl95nLMwd0yOl7/+T?=
 =?us-ascii?Q?mVEJPFvsWouVWwaWU7nnum+klOEKvlGgp6Z2DXYU1rxEXaZqxJUZ4JsTOplN?=
 =?us-ascii?Q?2aOeHIc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7265.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LRecqIMls2xMVXdVZSRlQAg2xmbMDESgCHCvKTcPAFd8M8cu2HOLpkXpKGH2?=
 =?us-ascii?Q?izv32afuJMVjAYwZJHLFcLmB2fxRCSNsQcY6sWzuavi7Yq8WRmZciuf2aBTh?=
 =?us-ascii?Q?7fcBOBZZrXhAB0LjHyDVeDEejo9Ez/MoCksGVsFCPvcSMAzw0gTlrM8SOHKM?=
 =?us-ascii?Q?gncQrKJY4jWv+GNevwKZvHXArmHOU6psvzSKBQ2gFpVuPujkEBk3Kh4dU4ou?=
 =?us-ascii?Q?av88uTw2z+KA9DPzUkWm/Qe7viodzd80tm07WOf5O27OmIn/72V0U+o+MIFR?=
 =?us-ascii?Q?iJf5zqqqFm1M7qrM9pFNMvAYWz9rQEztiArD+d8X2kKL5nJy7gjrsa+loT/U?=
 =?us-ascii?Q?o+Aj2yrU74ASRR/i7Aqao6G9yfTA5a2NzwYgk++vzPGOcsPqjVOi0a6MuxOc?=
 =?us-ascii?Q?/C5r2DmG0hThVqxdXm8uLT4EbWPAcjZzfc2LfONoyEt5hrakAw2HSS6mAC+4?=
 =?us-ascii?Q?4UmBxNsOBNKcfO9Q47ke6eyUNE5atershg6Jj3qtupFZJOS2kI8LNxZCTez9?=
 =?us-ascii?Q?pxaOW46YaZeVaIrQCffx23KzHrIWH7gwrQuVdqbJvyi6r4JnAyoZ833uCL++?=
 =?us-ascii?Q?zXfy0krK7p2rD12nAFZLMulrhc8auV4WK0vxNaBZ/URNeDnfgX05lawoA9n/?=
 =?us-ascii?Q?mhUzmvLoGvGej+bxTz560Y/CCpKi+qfGyOkw9Snjqz36dqyl/C7iKI4JEUy8?=
 =?us-ascii?Q?FMf4m+5aWS2gshO2ZAUmwUY3catOWmblY2j26YjYQf89G3Qo65+3CR9+fPMY?=
 =?us-ascii?Q?+z7sOXnUWp1sJO4pmr1zsj1aAWSnoeFZ70m+UoOv94TuaTSbUaOcG42gIPQ6?=
 =?us-ascii?Q?Jky4j9X5Ji7rfrALSpfe+gGBG98PT0GqADC1KHI8l2grcE8lnpNm/hkcJX3I?=
 =?us-ascii?Q?Ai91kp10rmCDuvn/HPzUFf0+Uc/znnPlf/KYyQMltHqX/6XeTPeh03kJ5Z2K?=
 =?us-ascii?Q?XTGjKLolSi+CDzz6qN+ZX7/VYLC8nHu7qFSbp6RzN3PqdaEHV3DnN5B1Kjhg?=
 =?us-ascii?Q?xvkUsaXSQCFHMXbq3gq5MeGQ9rmHafpdLi0nRzZ7hvJ3fF2Y4h0HHeIesqiK?=
 =?us-ascii?Q?sPCGUxUzOuBK9z2//95WtPOBZd5Iux5h8sTbszfp2FOvsWAVzUXtCT5mhg2Z?=
 =?us-ascii?Q?a+jcJpNQNra918hssYHFF5Z55CYc2jiWnE2oeRM5Q0KYGfGC9Op0ekLqWydZ?=
 =?us-ascii?Q?Q1yTFV3bYHwk36GtS54zFnGU6+cy0chdLgnwjjdmJO6x3jBGk3jbzXWsXXVN?=
 =?us-ascii?Q?0XvCvLMVw0p90lgVPmuHHtiJzBknfoFHe6H24X1HJukg0V4JwgZ4M6C2fVwx?=
 =?us-ascii?Q?CyqerI+pGd4j4z9QinaKYPfpKNPkw58/tS6z5S21pzH5yGmdTvALBi0XXG9W?=
 =?us-ascii?Q?v5D7aPDkSedG7hlnXGk7Yq5Vcq8f0Ds3UOhJnT9NibFcXbO7Qlc7B9mcLmhM?=
 =?us-ascii?Q?O3uvnAjMIGE6bicBxZVdp8KMjYcwItlggKXfhQons1JqlLvqiYIbN0Pjkj6K?=
 =?us-ascii?Q?brCDKZ1GThQQNzbUnPItS8+zt4t1YcmdPCFi8L0aOsvg7b3AyDODrimMum1d?=
 =?us-ascii?Q?HqcjC/YmkqRdHZ1HnHxYt6/wJuSAe+mjaOQHfvT8bF798KhGrZ0P0cMiKoHk?=
 =?us-ascii?Q?WA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7wIFAaoHZJv6n3ohcM+OZLJ4zAP7vqG6VZQXVDq1T6i57zMDDuQB2uL/SpCU0hKYdLkMJDgvHrRQ2qwic9PSvyU6K1YmiCroodgkYdVLmKFgahbTBS3r3KctlqWBd88g3JATsD4Jozyy97rVNh0mq7U00IAOnXvnlghsALjIjRkifUA1JyRsfL/6bmxzHfJyT5dOhtrYbz+Thb2F6c5UHNru7HxJNrdqdznbDTZ8CxQcAPMRtY1nQ2n0AyxJdh65mUfjtU6MXKl1B3xo27E8hUpzImDJR7qOULIUpVG7okhv5bYzZlwKAUkhkjTFjnPT0ygldYtT0H/HMWhniJcyjYo7YKqYYjQvg4CpKXsyiPuqMwj+qC94G+iogopgY6zzcO4RYctrPW5c4fwZPrJRTzIgtFK6CFoGDYDOMG455412wOhL+xVeo2daqfpNfC1awTn8JJ3qRP+zCsaMClLYuI5VACkN5KKjGrSHfxkRnGYFzihyrJ1psMVzldF/SJ2v+TZwidD0JSpaQOQ3EnkSS8lQwamt8KANv7+Ap+QCco6IZHvP9SSi7BHODQaspCcPSv5J0rebTgU7rxplHghuCfhdTS86Je0/59X8KA87Lhc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b1a58ad-b534-497a-057a-08dccd0ac5d0
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7265.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 17:55:33.3520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0hbZzppr0pV109Jr0cr4LaDjKpU6ys/J0JK6++ao03bvcqrY6V+5eP4jiCCe2TvMGTL7psfH9XNpNlTvTh6Wh6bEncRVbqWpSrGj186J9bg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4420
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_15,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2409040134
X-Proofpoint-ORIG-GUID: jQoq-sPkVKFLV24ZeWusAk6lw_W-_9LQ
X-Proofpoint-GUID: jQoq-sPkVKFLV24ZeWusAk6lw_W-_9LQ

Some distros have grub2 config files with the lines

    if [ x"${feature_menuentry_id}" = xy ]; then
      menuentry_id_option="--id"
    else
      menuentry_id_option=""
    fi

which match the skip regex defined for grub2 in get_grub_index():

    $skip = '^\s*menuentry';

These false positives cause the grub number to be higher than it
should be, and the wrong kernel can end up booting.

Grub documents the menuentry command with whitespace between it and the
title, so make the skip regex reflect this.

Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
---
v2: Resend, removing unnecessary terminal + from regex.
v1: https://lkml.kernel.org/r/20240802145706.1283189-1-daniel.m.jordan@oracle.com

 tools/testing/ktest/ktest.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index eb31cd9c977bf..621a874b24264 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -2047,7 +2047,7 @@ sub get_grub_index {
     } elsif ($reboot_type eq "grub2") {
 	$command = "cat $grub_file";
 	$target = '^\s*menuentry.*' . $grub_menu_qt;
-	$skip = '^\s*menuentry';
+	$skip = '^\s*menuentry\s';
 	$submenu = '^\s*submenu\s';
     } elsif ($reboot_type eq "grub2bls") {
 	$command = $grub_bls_get;
-- 
2.45.2


