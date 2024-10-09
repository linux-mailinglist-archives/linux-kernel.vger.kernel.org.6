Return-Path: <linux-kernel+bounces-357547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B2C997266
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FFA11C23A8C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA391A2544;
	Wed,  9 Oct 2024 16:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b5VmEmXf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uq6dezTE"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10D51922FD
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 16:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728492897; cv=fail; b=Dd2eZ6BYmg9bleEzZRh/6w20GLAOx69rYBR6qf++Jc+ruhArGjvuQCR/ztwv/nvOF32waj1QIvE1nwhVMk67Z7CsUnx26/Su1dVhUlS8zDet5CpTbaqXPCB6rsEwHRc0YF7Ol91i2IPjlV5l6t2ngGgGFKhk4dQqYcxF55EkIz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728492897; c=relaxed/simple;
	bh=XkDLi5ol59gRERPDVk3D5C+wdBJEZPFArCBZTwoj2Os=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GZvVGj6xO2mmybZa3itc/xJpJtwY1OEBRH0+1SGrfpl/jOBodKnaq+0zhV79zD/8n3MxgWdN8twlsVoDpLBcntP7axN5m4riIsz+pei5nNrC6fLZgz5GqHq/2xs/DzXHJxaYJnLcx3aMY1s6w9+oqg1XlcTfPrZqvKoBiktYA1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b5VmEmXf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uq6dezTE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 499GBdna027293;
	Wed, 9 Oct 2024 16:54:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=DePIVHClCjpAOXGADN2fMS/sfjzxG63DBLHmmkjwoGA=; b=
	b5VmEmXfmVDuQ34FuVUaqI5kCojG1PNtIHs7pZ3vrnKbp2pCnyECgSWuH91PFmad
	Uonp76qNwvUSHv+mRpFoSBbh659hCe4HhKjNTVn5PrvQDJK93aU7tX9WFA53s/OB
	eNTJTO/cBv8ToPZc+CeHw1fd24FBRD2kJizCk/ju6NvxFmH36PvdMI2KsSXJdpzq
	dMvt6mflfe24zXzLhoq0lqLImq82toaWs2n3N8R+T4/LooOoTQ/9vC94XUaT5FYM
	/8qu+dzINQd/Xla5UJGQh2jQbgmyMqcnbowFnty9vtFE7Y0xKbvPs3Xc1QG+YbsD
	QjzKgJdGsWvz81hqx6KfrA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 423063rsq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 16:54:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 499FMRtU022992;
	Wed, 9 Oct 2024 16:54:29 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uw8vdwq-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 16:54:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FIteo8q6E/FvLRv21sTX/TjRv6IT+PBIQPVYm3R5wUnrvfUoEIZd92Smi07IFRNN7tj6j+YA62RzwUgHfnQ7u6Tgj8RYpHcnHIcuORbDjDPk2xsj232kZKfJQjtPV2M+c9SOepExf9H8mAcG9v5LNh7A0uz+KVP4A01BMzYzaJp0iZLMGlf7M3kNzHHLvTsreesC+cLBYgWoAPaEa3Dwf9G+tCs7wD7GhxV8UvxQz5kULQAlzL4YRsNER5O7aEfdBWzePloByVkZg4XBhDGTZOjGYkZZBcRNhxstEA3ShSQSddqW2wgSq/aG0pDWQ6X+fSGMlTsEWNHMxQCiR3bVIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DePIVHClCjpAOXGADN2fMS/sfjzxG63DBLHmmkjwoGA=;
 b=qYCx9QfJauYobJmCCe6TGHP1d7mMSSjIf6E0KbeA1OvZP5QROX7VAidfxpnWUlEh8z8gGj98kbxEpYhCLtMyDlvrD0EJGuG5jlYZi76MXyW3jRW0gDASvGvlB0nak60bGZTvCLwl9OX0r+7jYSfIlXzMyKkadl5owlWj2JtXMadVSlsXNn7J5UsjUNg0CzD2e5E3VPvYE2WLcy+/NkslaaMZkUNib5uN6np1fQK9c7gqisFTtwwuHFymA6xtaZjKIlTMB9Wx1fn5k5FJMqUTMP/OcMHzzmEr4bBp/3cGhaG7zizIl4221DOPPmDPQ3TgGsPy7q/syRtsalc/eYz64Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DePIVHClCjpAOXGADN2fMS/sfjzxG63DBLHmmkjwoGA=;
 b=uq6dezTEcQRkegXBUROiDnKHmpPtXulyIZiO3+UlxSG8e1UEvRnlRnQpwzugMPLXUAB+3xxokFezh1ZnO4B1XRVqnwawQ5ugu+2XnSDnv8txGi2XUM/596ROg0ZBGP/7MZwGOoFPPrGUwUFyydIqyjRhrBg3zC0Khm5y0DyMKYo=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BL3PR10MB6044.namprd10.prod.outlook.com (2603:10b6:208:3b4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 16:54:23 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 16:54:22 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, tglx@linutronix.de, paulmck@kernel.org,
        mingo@kernel.org, bigeasy@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, frederic@kernel.org, ankur.a.arora@oracle.com,
        efault@gmx.de
Subject: [PATCH 3/7] rcu: fix header guard for rcu_all_qs()
Date: Wed,  9 Oct 2024 09:54:07 -0700
Message-Id: <20241009165411.3426937-4-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241009165411.3426937-1-ankur.a.arora@oracle.com>
References: <20241009165411.3426937-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::12) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|BL3PR10MB6044:EE_
X-MS-Office365-Filtering-Correlation-Id: 963bf54c-4964-484e-448a-08dce883062f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yXZarYYENE23ViQv6fgAShVhmx74buB+PNsyPu8pApKxZAAYk5Zsj7QG6yVw?=
 =?us-ascii?Q?9iIrVU1Cdnkua3zbVnRrfqa7/ACMG955EnANZR2n8ywkeq1JT7N4fZTMjuQz?=
 =?us-ascii?Q?fErd+OsoaTSBBgrZjcLCnG0lwhYZw8dpW05w34GHXN93OzS2BEdbP3YAIVh2?=
 =?us-ascii?Q?Qmkh2Ne5wcWqdBjRc8uSuwL+TlWJm5MPh5g9OLnMa/wNQ/XolI7fsbm066kE?=
 =?us-ascii?Q?Sdk+VIs96eBCSv6Z/22K8+/8pOmNQgiCWsr531e/E4EIbUyNe2ruGWySqy/Z?=
 =?us-ascii?Q?OngGI3DmUjY7j4z5vOAivzBN3f0iDe8vq8s6fUWBSDKa66Jj9Zu7xAy+0LbO?=
 =?us-ascii?Q?JXYa60UH89kl31lcSVBugXNx4ttfrJt2mD/Xi1SoBvVpJuvj4p1IVmXbp827?=
 =?us-ascii?Q?M/04j0npKmxG7nedw+skNgD48ckFxEMGZAGrEZ66iUKgbRFDYxX9HbgqMAdB?=
 =?us-ascii?Q?vsVXGVLyuL9w0IQ6dDSGFBcbZQXhDo3368iHcwOxxptuAZ1UaiDqJ21DJBl4?=
 =?us-ascii?Q?o/CT6W+8jNJ0lgPRpLlPXmeLTWqFcDtEqNUCKNkTZ65FWUQ6gmucIr9HCWLM?=
 =?us-ascii?Q?yM+YfaBKGGIYZX9E43GkQSCRfyeyYp+30SFkeh4dlTNGHQ7QWcEqLBJ3wm84?=
 =?us-ascii?Q?gB6NbsMKVZcWXLvqLFz46LUhQS36v6wXP6yZgw7tMiQDe8Ds3sxwPpWwSVKD?=
 =?us-ascii?Q?ZEWZPaD3/64Mm5pSOIHCLroSF+PRN5NW6xFunbO4WEq1IFiYEHOPeGMq5p6n?=
 =?us-ascii?Q?lEC0NAqCrZDPFIfmfZWm+Slz+0K5ZNXqwfCSqp6kgbe8IqnqlQkRyBBSJZT9?=
 =?us-ascii?Q?0a/OrpLCOJYnSbh/36IkCo9vFjay7FjWJQYqlcRVm98a2GWp7VzWNlngsNws?=
 =?us-ascii?Q?GzUVk1adGdApd35zYXd69jD2hZrLndlVObzsRYWKjYsAJEEvcTrIpt4p1GrK?=
 =?us-ascii?Q?wV60WFphHJ7oSI8lsQzrHKZirfezf1Od4Xjfm/k56/llDag+sJResCg+vqUO?=
 =?us-ascii?Q?8LrZu5KsbVQODK+UsMV33mTlhU/6sf6OKaw/ZG8dI/EiN+RVvzTZbYRLGgrl?=
 =?us-ascii?Q?JW7U4JespU24UtzRR9kiQuPI2Qlgm3fiqa6uiQOvmDGneQyNYvEyqCSFHJp+?=
 =?us-ascii?Q?jg+wdDeJb0hqC81s7z1AqUrGV/MjkyclR2p8vFlv1GGNrDEBbuMrSOCQ+ZZA?=
 =?us-ascii?Q?2ZCBXP79T9awNwTlF3AoKZKPKiD7DI816dW3vLBpuy0fPBqC1RHcAzOluIPg?=
 =?us-ascii?Q?L0OK6ALdJivfZGueMhusj6UM6NWdjQCPIkL9xk533g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tQG0NfG8BGkoXFSk1oRG4oDjpXi8DNsqR25SmY6GT9s20vcQninOe1KJ/ZmI?=
 =?us-ascii?Q?vZLhWmYCj3tzBdDaFTKNpYXBknSvnRyGYf5gqw5yfruGH+38tzyZ7El+8CYa?=
 =?us-ascii?Q?higFC1/7HCf6eFsUmr+HR/8CLAaPatFGLTP0IQzUuTHxOGx0b5HUwAFDdowb?=
 =?us-ascii?Q?Ci7W/XX3MkyiHQpih6I57RHWweldnTMlAOFlEpMJ5u0/hi7tr50qSmaeqIEt?=
 =?us-ascii?Q?sFXS3isQIP81ZlMZfRejCssPG6g0i3yphKBreCWhL/pOkwLUQw3VbFN1XTep?=
 =?us-ascii?Q?AcQRyhNET6OsBDnOqSmw7o3cKnBrY8vQfGS940Ocl7A39L0pp6pDl16WDSd0?=
 =?us-ascii?Q?E4hd+/lIw0neZDQprkCtafAT+58AdBpt5dYbNP0i8sRmK4n1ZHM74Nk5GlTB?=
 =?us-ascii?Q?MHHK8rFzrgPaVo+EaoZ07sT1ISYtQH51WsBh+vV1QSeU8BFaJKuyW5b6lvUc?=
 =?us-ascii?Q?ufneyGGJDxWTzKyNzD0bUyfBdKOt0s7LnG7xrRodsGGaMakoZb199LYzjgfc?=
 =?us-ascii?Q?kVlBd8NWUuwbDNj9J2m+E7cbkPbelV9lyqCde6afBEfMiHDSWdox8aeRsIkv?=
 =?us-ascii?Q?hvySr+neEQSYQFfReSvZkqW9mghquhRym2LfUxP+6olBZOmmDNu2kMizkb1K?=
 =?us-ascii?Q?NyBlbHRujRUvWlYiw3SGPJDgI9IxLeYaVA2heUdcSURRBfo82oJqRJgI0Xry?=
 =?us-ascii?Q?SZa3wgH1F4lY1HgFYn39//f1+X+THcK6zjJ4tnDC9KMsNKlHxTbnOAFklJk0?=
 =?us-ascii?Q?CBKSjO2V3LkaHp66woItK7ckw2G8mljRm9VSUw1YmF18ZhsqziuVBwI7mIfX?=
 =?us-ascii?Q?TNTjIL6WbQG/XNzkBtUYtQ924/0moGiALF17RU9OH5Qj7sndjQ2J+wBcu1Ou?=
 =?us-ascii?Q?T8KInVjIAv5+w1K/h17km87tZy7feCEc9Ew+Q84waC7b6SelK/SdmMIZVDB5?=
 =?us-ascii?Q?xNUfWDjWfVbuxJvuUzSYSvzuS0wf6qUVE3kGvbghNrozTk16j0Wz8oPBBf+1?=
 =?us-ascii?Q?fEFOeK9LeYIJIDFghk+VT0HR+EGyrU5WHeQkq+fxI/FJW13xdPZRG22VwMBn?=
 =?us-ascii?Q?2benAVht6n62RW71wImVxKsk3SVqzVurRB0XzMFUFKgIQlxVFxHc+L2g02Sg?=
 =?us-ascii?Q?zSI8mMfop8qRyCwEAE9URbuzN0pjir7Zp7UJb0Qq0bMLMNrPoY1SJP/4prtQ?=
 =?us-ascii?Q?Gu/O+sAmXNxvamONXBdCBMCz7G/NpLLNIaYsNy9KNljK5men2b6tSwSI5E6t?=
 =?us-ascii?Q?dUcwqnnxV3Bb7o45gKe422bVX+imuE2iQkrz90TqURv6Rq27y2OTRN4Fctyb?=
 =?us-ascii?Q?d5Bz6vl1H1lqxqpHvpmRteV8OhxYhfvMRrK/YaK79LRNvV1pW48g1fWusCyS?=
 =?us-ascii?Q?E0fpy7Nk9VqIl8XC4IjjEnb0SbsxQJFjNG/y4w3iC1yk+Xr8X9xz/qiDfzXn?=
 =?us-ascii?Q?FSfZWkbRCrtfPS20WpvvpcFsMpCeywoHuPgiD4XeVDwFOzs17tRalrGhM3sO?=
 =?us-ascii?Q?Q5c9SmrcCs9g9urBnT1DICpYFPEd7Lxt2vzRZEAQT8FFQnYSsZHhWw21nRsL?=
 =?us-ascii?Q?/1uJx5q+jlkDwiPboyimiad35SCzL36rOGHxtfm4V7nRMZfxIZuPH/7PCqq5?=
 =?us-ascii?Q?Mw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	z9ws8K9jSSHdk2YfvyE8la7nCktzsho3V4s6tbNnVK90VzSTAjiXvFliUrlYDR+aXyG/kokl7HZM1vCn2Ihg1sc9sZDSy9wb8J3I9JXIf4gXDTKHl2R+ZSt2ijzNu5e9NXyItZjjxpxkId71MRdtDdfF9q4itmlhW0LVv6Z0m0lApBY4gLYfTgX7emBWDzoPuhHmCQx2UhwqzEtzCmhB6qAjkCf7/8MJsHj4dncJCOizI36PB3lSRl9w/Bf7NYMeJ3hYgfrWyGtF4Iph5xYwS+YDfmu26qMy3fzD8WV8t8ql7h1L/Mph5dw4ioyAVP81Bj0yBunwD0GKPhmT2ix9h4z9CFJSBygxfaTAbLFyTH+mPG0Vny/PUlqVNShIko574NQCa6OPa7p99yB8NVYvBaJT//TyWS4mk+rE4x7TPGPRLNh4DmuZXiIzlIQqSMnvTszEpOmEMxh6Dy2vD/GHCjIGicMOcV1HkKguoe2C80UOoBAaeWdRs/IodWpClxr4PjL0RZNtKo3oWQ6q7AKaGn2ggOc34fQ2dnh7h8fmO2wn3MzyuA9xvdmm7hzt6x1chGM+6kfry7LASpiYvI1C6JFnThh4br8+Xsul66iqpWc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 963bf54c-4964-484e-448a-08dce883062f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 16:54:22.2952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4dpwC0SmzihiaHcyv5slnp1zxZ1uKc8Pzw96kGwMWQn6RgclnELK9I+Q/awgm9yqSVk06ydhpSxwHccQCW7InY1RFpTaO0iZl0dXJQyNqOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6044
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-09_14,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410090101
X-Proofpoint-ORIG-GUID: fUKFlr4Mq6bzmDd0BSxEludXvx4MWwah
X-Proofpoint-GUID: fUKFlr4Mq6bzmDd0BSxEludXvx4MWwah

rcu_all_qs() is defined for !CONFIG_PREEMPT_RCU but the declaration
is conditioned on CONFIG_PREEMPTION.

With CONFIG_PREEMPT_LAZY, CONFIG_PREEMPTION=y does not imply
CONFIG_PREEMPT_RCU=y.

Decouple the two.

Cc: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/rcutree.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 90a684f94776..ae8b5cb475a3 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -104,7 +104,7 @@ extern int rcu_scheduler_active;
 void rcu_end_inkernel_boot(void);
 bool rcu_inkernel_boot_has_ended(void);
 bool rcu_is_watching(void);
-#ifndef CONFIG_PREEMPTION
+#ifndef CONFIG_PREEMPT_RCU
 void rcu_all_qs(void);
 #endif
 
-- 
2.43.5


