Return-Path: <linux-kernel+bounces-555108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E70C4A5A579
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 22:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07D123A671D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6611DE2BB;
	Mon, 10 Mar 2025 21:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V7lwYIgt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="h/Ds+h6g"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD94C1E0E13
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 21:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741640513; cv=fail; b=CuEc1geQamXI61HbtA/L+bN/7hmnPjDxnOM5O3w4wapg+2yTc++aLPDL8X71LKC6fwdeOunRXsF0ptTcJvXpwIvViQMSaVA2lYNPc1kfYkqZV5UYs5wFYbQvrqNDEptjrkGfsu4T8gv0lPdycwzn/AXcDnt34Obaqjbt54Q4C5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741640513; c=relaxed/simple;
	bh=Jjv94YeJ/sK8PHLDNYTRebRiqKXvF/leItKtPaIQjuU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MRcw+2DRGpSFNIvoLTxkpDNb7OYAyfwTCdvpYd+dMtBlEpvgLSQ2piwT62R9fX692+IHXDjvlM2Ht+LIDDe6veQR1HBKdIkzUDVUpVXPcqyY8MNqXf2s5cLx1Y5YtSJ+OSyb4Sfo4p8vtt7ObxgQYYA9SqTo/YZQzeNZ/Fbv4uY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V7lwYIgt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=h/Ds+h6g; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AJtjpE002549;
	Mon, 10 Mar 2025 21:01:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=EhSqGDh1+u/fc5sd7xpkkqUCqsO28nfD6A+IfIzp7nU=; b=
	V7lwYIgta1xKyv9yQa8iFT/zzyNw80++8x3v54fp5l7AyYO+TUD7QkZcC+WlqLLj
	TXpRtx9/SmqKGVMEXcxe4yKiJg7oFYeGgfCi/pgUR1PmITgQqYHpUr24c0YsW6kz
	81I1/R+CMfHhv12b+3ZxiwlJi9jiAdQH8CI3mVmI3Eevqr4uVMD3FEptZ0ImuEKa
	VlgIzUqJ19a0DxPRcFA/x5ao604IvTFOEamOur/CD92Pw0ANCIrhogw6Pfus0DMs
	jzOS3sOtADYKVD8kjiygTdwB1T2vVD0vxvSnIiJsnlMnsUNXHQYpftu4atXFQrls
	ncNLY5yL8ONYiWm4L5kNaA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458dgt3h2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 21:01:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52AKBYhU030641;
	Mon, 10 Mar 2025 21:01:37 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2040.outbound.protection.outlook.com [104.47.55.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 458gcmgt2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 21:01:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b3+XxS0xUhQeecwSu1RdkDjMZ7FAf2AWOhf3p42GyjZcphSDVP4ZEZegLYG3UNfXaQ9y5Y5jaiGrucfUThfwghTJF0muW9IoD7LKYVQJiitrPnYrbWm3X872iHmqLP1WF7XpDKB5rQgCr4iIDpy9T2E6wKEOjH4NKTEovUBL6FImkFxP741VtShVMexlyP+EKNK96Na6B2r21hmJbsmvctdDTBSYkNEZLyVm78LGifCKcgbx5gdvGi9snKd30rv4o0c09khfE6XHKafsxANBy4xRzHs8MaFu5rDaE10dHKqI3KEfIMsHK3p0zmglj/0MwrXULC7i+p54bYUe077vYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EhSqGDh1+u/fc5sd7xpkkqUCqsO28nfD6A+IfIzp7nU=;
 b=f2zZmJ/RJteso0HcMUfTAsFpM3CNBbmTQgzzZIssES8BVc3nxVy1jxLTsMRHE7c78QgVIxbc2gKY27JbckzZQ3TdKIlRCjK+zO+72k33ojkgp4zhpn+EblaiMYg8A/8417M1MzNoui2zI/wM5cCp+fFCbZw0xWQuZSqwxevHhhWaH2FA9MSM1mYtueTT3IqZ5EiZlRUlUw6K/0eSNX/irmji362jOM4oePyXTUzoXSg4seUbfGTlr36jTV6cJXsOEdb41umZ7RqX1oF0jdaZ0u44XQHzTc3e+w6f1oHNGRDyGCn/yZtwhBY/jxPvjLRsukNJZ2mEKwDNiBcbYzs3KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhSqGDh1+u/fc5sd7xpkkqUCqsO28nfD6A+IfIzp7nU=;
 b=h/Ds+h6gQvDWMk43Uyg+x0wx0ujAJcG4QP6MDcRdKVO72xGH26Ymk0qdz4VbcrupUh+vixL6j+j/YcCvlfJgmDkG4Dc8TNJWeQvL4jNI8uJ1OwJnjboE1B5bRgKLiTMHBfyNqGMupgQ3wztIln4sdgpEz2loWunSwsUrCH5mpfs=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CYXPR10MB7924.namprd10.prod.outlook.com (2603:10b6:930:e6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 21:01:34 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%5]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 21:01:34 +0000
Message-ID: <b9175f2c-a28f-4f21-8879-fea7bbfdc5a3@oracle.com>
Date: Mon, 10 Mar 2025 17:01:28 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] maple_tree: add sufficient height
To: Vasily Gorbik <gor@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, liam.howlett@oracle.com, richard.weiyang@gmail.com
References: <20250227204823.758784-1-sidhartha.kumar@oracle.com>
 <20250227204823.758784-6-sidhartha.kumar@oracle.com>
 <your-ad-here.call-01741630424-ext-7048@work.hours>
Content-Language: en-US
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <your-ad-here.call-01741630424-ext-7048@work.hours>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0414.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::23) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CYXPR10MB7924:EE_
X-MS-Office365-Filtering-Correlation-Id: 89f16dc1-cd35-4fb2-1160-08dd6016bd4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1ZNY3dhTGZtSzMrOGhuVFFwTHZiYXBmcjNrOERubE9GUXJpVTVtRWhuTFlV?=
 =?utf-8?B?ZFp6WHRTTTR4eEpNU2lqU0xnZG02SGxnakRGai9BNS8rZEZFd1Bwa015M244?=
 =?utf-8?B?RHhwMXVsYmd2MVBXbHVMSGFJV0RUMU1vd0hnZ1FDeTF5UDhFYk5mTDdHWHJR?=
 =?utf-8?B?QVJUOXBVeGxDd2ZRNTQvazlKZHlZT0ZLb3JBa0FGZEJjeGNOeGxFV2FKTVlm?=
 =?utf-8?B?aXA4WjBRTVUrOVdhejBxWW9SYm14QjJvV1piay90Rk1lM0JEMThoaGR2YlhU?=
 =?utf-8?B?UHc2Q0pCMlhhRGdBdlh3c3ZqTkZ6aTNjSmpmZHV4UGNYRGVQT3kveUlVczgr?=
 =?utf-8?B?OU9FdW1OcDA2NnNjdDF1SkNRVVFQMnhWSEdDSXplMWp2SU81V0s3VGFaNE93?=
 =?utf-8?B?OUw5STQ5OFVWaFd2Y1h5Y1RMVlJQbUJBR01rRG1qbmY4ZUt2KzdoSmNZaDh4?=
 =?utf-8?B?eXJsWmM0eThZVWNqamxhVXpZaWFMMTlaeDZoOTYwYWhTcXBzVGpRemJabHVw?=
 =?utf-8?B?WW9ZS1l1TWZnQzYva2RqcFZWbWtibFhQcnVEVHZHSVhSdCtKVTJ4U1UwOHNv?=
 =?utf-8?B?MEpLZTQvaG42OWpUaW5IUkxrOS9SUmdpMGdhaDRVYlNmVFlrRzBNN0RMeGpD?=
 =?utf-8?B?T3l2NzFZblYrSVhJVHozVmtzdzZ4eS82bCs1bVZkSHhEdDcyTG5RdyszRGk4?=
 =?utf-8?B?RmpRT2lQUzgxbFdCNmtTMmQ1bXdkRXcvSjl4ditqcTJtcXk1bGYzVWwzZVlm?=
 =?utf-8?B?bllrcU5iRHdWalFpSEJXbzc2aFVEb1VUMmxXQ1RTY3FVMXk0bWJEc05kUS9q?=
 =?utf-8?B?aHJJenJIVHlybjVGUWJaYjcxTEJXVEFMc3ZpWEdrMFhtRFAzWjQyQURJTyt6?=
 =?utf-8?B?QkZCSzJWVThDVVZuU3VhWS9GanZQYTVST2ZobkpkMVdldWhROFVZeHJTdHls?=
 =?utf-8?B?K2U4TG5xbzNBNXBqNVU4UG5WTkh4QUZlVGNMemNYN2pqV2l0RmN1ZFpOc250?=
 =?utf-8?B?M0pIOXd5bllqOFRWWnhVZDdKdmJ1bG1zcWkyeEs2SVJTS3oxNmNzZXBLY1dH?=
 =?utf-8?B?MlZwQkl4eStrU1N5Rk1waC9EczhKZmNycGdxSFhLYjBPUDBxRlRWVVJlbHJF?=
 =?utf-8?B?eEpVZUhlU3JBRHBVNnpNeUFTNTFwUVh2ajgxcCtqWkcyOTlKZzF4OGlUVnhn?=
 =?utf-8?B?aWdIM2ZrQ3h4UXVjMXRxR3VRL05HaWQvTXFuMmwwdXFNUDVaMHRNUVI3QVk5?=
 =?utf-8?B?RmR3ODI3elpwdkZJQTBwaDdNemh1RXIxVTJmZWNYYU5RdXhnTEdKSUtaN0E1?=
 =?utf-8?B?Qm9mNC8rOWlXSWpHamNDZllMc2NIcVpKZFdNMUN3TDdqb1JWeUNtbXlDazda?=
 =?utf-8?B?WS9SdEVlLzNvbEc5M3Q0b2lnTC94MG5XY2Q2M3liZWRtajNnL2g5LzJoWURO?=
 =?utf-8?B?K2V4aGdkREkxMU1WcEJONDVCbmp2ZStKb2VJWVM5TFQ5MmlpZnJ6OUtBS3By?=
 =?utf-8?B?elZvZlhPdmoxYzU1K1NTQURGYVpEWUNCaDg5bUVYaS94aGV1NVBaTURFYm9V?=
 =?utf-8?B?bHF2YjkvVTdmOGFDRVc4VnlzcXphanlicm02TTdIV054VHh6NURBSnZiTXRC?=
 =?utf-8?B?QXRRSnBjcGVQSDhKdzQ1b1VNTCs3aHFHVDRvMW50Z2xjNVRaT21qbDNmenpO?=
 =?utf-8?B?WDVtNjV3ZnIrLzZ3Y2hWb0xJa2VNTmVtTjVzckYyaUs3YkQzdGhRd0MvbWVa?=
 =?utf-8?B?MjQzZisxSDZDNUtXNVRsSklHcEZVeGovUVBCSlpwRW5kZnBWVjNkT3I0b3Qw?=
 =?utf-8?B?NGNWRElxZVlDcXBxQTN6MnZUaUdqVjNkYll5bjRPakhtWXdRYUowY25HTzUz?=
 =?utf-8?Q?09Od/Ex5tR8Gh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnprZTI4WUZRbkVDQmdBelhTS1RtN1IzdUU2YUNscWlNdTNRZDhPNlBEWXFU?=
 =?utf-8?B?dkpJVXFYU0pWQzlkTmM2NVh2bXlaTkdsS0F1djVOYjFtcVBlRHl2dkdDcWx0?=
 =?utf-8?B?MFhFVEh3clM4WVlUenkybjJYSHFjcG9BQnk0L3Y4cERmZXJnc1Y5OEgzZmJ1?=
 =?utf-8?B?SzVvMlNja1dwY1NVTlhGdnNUQ1M4ZlUyRnBua20yRytLaTVBVW9LN2RvVWd5?=
 =?utf-8?B?MU5VSXpHUVRDSmZUY0QxMTM3K0x6OHlhZ3gzZjg0bFFWZ29OWmd6aXYvWm1t?=
 =?utf-8?B?WmJjTkdPbEZiUHliMmw3R1lrWGxaY0JNZHNNZG5GZ2tybis0SUYwcUFyZjgx?=
 =?utf-8?B?V00vci9IcEhJNFZia0l2bXNuOTZ5bjNKYURDUFU1akcxOHRyd0svS3VqckNy?=
 =?utf-8?B?azhweFdvdDduSkNaUmo0SWI2Slh4U3NjM0NIZzR6akErYndFbGJmZUdDek1G?=
 =?utf-8?B?WkFFNGNFV1kvbmZIdEl2enpiRExYakVCb3h4eklnZzZiS1Y5RENKOWJEMFlH?=
 =?utf-8?B?MnhaRGhJOHpReGlhcG40ZWY4Um9BK3Rqby9rNXR6Z21iT2FoelRXVTU2cSs5?=
 =?utf-8?B?UTZqU2ZPcHRtOG1GY2pGTmJ4ckpHK0xtY0lDa2hwbGE4TFc5dE80ZnpsWDB1?=
 =?utf-8?B?aFgxYnRHTk43ZzJBUHNSNWxaYXlIVzN1ck5Tc1B1eEJXYlpUSXZEK0ZpUFB5?=
 =?utf-8?B?UW54aFhpdldYazlzTkdGZFZQbGlEdyt3MURreGFzKzgvRTUzRUcvZnZHQUFm?=
 =?utf-8?B?YWtQL2VkdVJta2NLelpzd3lDSGlXbjFLZHF6MXZQeGRwQnZ2VjN5N1VQa3h1?=
 =?utf-8?B?TUY5N0x5emd3dkxRcUFoNStsOThXdlBuWGhGeFJsS2xQditPMWNpaVFRRmVS?=
 =?utf-8?B?WmV3Nmd3cXQyNms1ZHArNnhLazZPVHdybm81TkVCeWVBOFY3azd0VndCL0U0?=
 =?utf-8?B?WUxZWXplQjMyUUU1Q0g0cFpOdk5LcTRMQUpGNVZkT1dPcUhEdFRqVEdhNVpy?=
 =?utf-8?B?R3VrMjZoaXFIU2Fza2xERStNS24yOVRwajNnbWFLdm9ZS0dXV3djOVV4NVA5?=
 =?utf-8?B?YVpGeUhCZGs2YjdtSTE5TjMzc0U4bnZhYVdpL2hoRDJPc2FpYU9GREJRdlZ5?=
 =?utf-8?B?SXNOQmhleGFsWnJXMVFYeFppSHhGZU5DVmxCR09YNWc5VDhxb1Q2OXFLb2wy?=
 =?utf-8?B?aW00LzFrK2xBR2orcGRBemVtamF6aDZqSEY5ZTdBT3lrTC9DT3JQWHA1T3lr?=
 =?utf-8?B?MEFPbFpnQ3NidE03VENRdzVkUWFXUmRQZ3c0clpScTdURWJGdzFPTG9BUWlG?=
 =?utf-8?B?MmNqeC85WFJyZE9hYlBTQTE1WE1JdDFRdUhUck9SYUxhSndER2c5di9hQ2gw?=
 =?utf-8?B?RDFGeFd6K0NKTU5KdFFXTkZUMXVTSXg1aW1sZWluRmtta2hlaTFjWGV3QkdU?=
 =?utf-8?B?MmFlVEJPcStaajY4NVJ4bDU2YXZBZ1R4M2RBSTNGQUJucjY1T1cvblU1TjJ2?=
 =?utf-8?B?ejN4Ly9zOTVMbkUyRVZKZ1FIdC9zUFZLbk9IL1dmMWVhTUx3R2IvdHhxVFBn?=
 =?utf-8?B?RjQ3c0VVOVBkUE9jQ1JQZE5vcjlRUkpHQUdoMHhHdmFxWWs2YlExYUZBQ01v?=
 =?utf-8?B?NDVFcyt6Wm9OUlhFNmRRRWFBWEdIYldDendhc3c5QVAwS2ZCbm5DdWs2Vm1T?=
 =?utf-8?B?UHN2eDlCczE0V0I0TXdzT1czb2pwVzJwVmhja056WXVmd1orSitieFlwdzZK?=
 =?utf-8?B?SE1HNmtNcUFQVFBDQmNZMS9HOWtmaE5jazVwU08yTzlVSjYyWkIwQ0N5TXVw?=
 =?utf-8?B?dmt5cGRRNWJYc1lmK2lSOWZ3YW5pVFI4dTBPYnpwSGhQOENyMXhHTHFlSWhv?=
 =?utf-8?B?UHhYQXlCUWdlTEM1OUJpcDQ2RFA5bmV4bXBIcndlS3lMZUJEcWJrMWVMdEkr?=
 =?utf-8?B?ZnB4VVpvYW9aMjNRMUNBV2Q1QS9aZGdMc2ZRVXBuTUlTN2VQd0c4MnpOaHhx?=
 =?utf-8?B?Wk9UNmNWVHRlYmdHOWpwanppWlU5VHBjdjJSTDBBdDZnbjFhVkNPdTVqMDdS?=
 =?utf-8?B?Z0lzRXBKbGxHNXNpa3FDMlY1V1p3M1dIcGFyeGJaRjhxamZOa05ZRXhqYTF1?=
 =?utf-8?B?U1djekQ4OStjYXpJWk02dnpkc08xcERZTVZkNzkva3IzRnBmc1lRcVlFQU5C?=
 =?utf-8?B?RVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eKOyQXUJfIftli/tsN2JUQwatPqQId72VoaUWTKGI60zV2aXGV4VHjnhIeJQMNev+jsAAjovwrXjt94SZK0dau26DT3Bq2O7Bv9IruKAP1D18w/55QEklB5Ab8cjdk0IIqpjN4zTdzQx92vIxSuvHiu8Ud4KAClejLETvzUV6F3e84udHOVAOy3gYcsC8qr5/Blrs/sAU/loF7oKrE4reV/i54fYvFNXD6X7tGBQRF4a48YbaIJ61DPPjUJs+kv5k0wMuFv9UzyvMhX3BLpUcxW0PAOH5aO3b2zIlnn8T9M0QGKIJlszX/w3v1qo7iruZO5o7VAwPXTz9KDA3M1YBBDuwX4hajTVYbcjMhmEvfo7b7oMdp5AUAAv3rHo+5J2661zpkgG8UmII+3ULJOVavCxLNz+ln0H0jLARVJ+h8uR6wa4IZ3P9gdsXkiPx36GJGLB0KbXb9NnH1UjDkmZ85S5rd733kn9dyqttTSHVnDyqwRBX7FrRDUyoSFlqQEU+LB9Q1prY/S8wRpyEyKkEmTXD3S0pgpDBYzVMDANOkeCoOz/FJmhQAVTHvYvwOcEgzdM1hvWj4yK97f5puCdYlkPyCuayyJyz4FDQNySGHU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89f16dc1-cd35-4fb2-1160-08dd6016bd4a
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 21:01:34.0753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SwBzfiwNKG4XTfczzjcnVi0l/lAGz6BleAI8UweWcahOImnmzDhZ39oKOTcSrifyNEdPMSo8dgkTn9m+rb+fkZbRZMqXsbYGfooBZKk4/Og=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7924
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_08,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503100160
X-Proofpoint-GUID: CZo12YmLFTZiZnriUBcUFJsOkyFVnemw
X-Proofpoint-ORIG-GUID: CZo12YmLFTZiZnriUBcUFJsOkyFVnemw

On 3/10/25 2:13 PM, Vasily Gorbik wrote:
> On Thu, Feb 27, 2025 at 08:48:22PM +0000, Sidhartha Kumar wrote:
>> In order to support rebalancing and spanning stores using less than the
>> worst case number of nodes, we need to track more than just the vacant
>> height. Using only vacant height to reduce the worst case maple node
>> allocation count can lead to a shortcoming of nodes in the following
>> scenarios.
> ...
>> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
>> ---
>>   include/linux/maple_tree.h       |  4 +++-
>>   lib/maple_tree.c                 | 17 +++++++++++++++--
>>   tools/testing/radix-tree/maple.c | 28 ++++++++++++++++++++++++++++
>>   3 files changed, 46 insertions(+), 3 deletions(-)
> 
> Hi Sidhartha,
> 
> Starting from this commit, the LTP test "linkat02" consistently triggers
> a kernel WARNING followed by a crash, at least on s390 (and probably on
> other big-endian architectures as well). The maple tree selftest passes
> successfully.
> 

Hi,

Thanks for reporting this, it looks like it doesn't reproduce on x86 so 
I'll try to virtualize s390 to reproduce. Andrew, could you revert this 
series from mm-unstable as I work on fixing this?

Thanks,
Sid




> [  233.489583] LTP: starting linkat02
> linkat02    0  TINFO  :  Using /tmp/ltp-8P2ZJL0mgN/LTP_lin3flG7N as tmpdir (tmpfs filesystem)
> linkat02    0  TINFO  :  Found free device 0 '/dev/loop0'
> [  234.187957] loop0: detected capacity change from 0 to 614400
> linkat02    0  TINFO  :  Formatting /dev/loop0 with ext2 opts='' extra opts=''
> mke2fs 1.47.1 (20-May-2024)
> [  234.571157] operation not supported error, dev loop0, sector 614272 op 0x9:(WRITE_ZEROES) flags 0x10000800 phys_seg 0 prio class 0
> linkat02    0  TINFO  :  Mounting /dev/loop0 to /tmp/ltp-8P2ZJL0mgN/LTP_lin3flG7N/mntpoint fstyp=ext2 flags=0
> [  234.690816] EXT4-fs (loop0): mounting ext2 file system using the ext4 subsystem
> [  234.696090] EXT4-fs (loop0): mounted filesystem 29120d07-e10b-43b8-bfb0-6156683a2769 r/w without journal. Quota mode: none.
> linkat02    0  TINFO  :  Failed reach the hardlinks limit
> [  239.616047] ------------[ cut here ]------------
> [  239.616231] WARNING: CPU: 0 PID: 669 at lib/maple_tree.c:1156 mas_pop_node+0x220/0x290
> [  239.616252] Modules linked in:
> [  239.616292] CPU: 0 UID: 0 PID: 669 Comm: linkat02 Not tainted 6.14.0-rc5-next-20250307 #29
> [  239.616305] Hardware name: IBM 3931 A01 704 (KVM/Linux)
> [  239.616315] Krnl PSW : 0704c00180000000 00007fffe2b6c314 (mas_pop_node+0x224/0x290)
> [  239.616334]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
> [  239.616349] Krnl GPRS: 0000000000000005 001c0feffc355f67 00007f7fe1aafb38 001c000000000000
> [  239.616360]            001c000000000000 001c0fef00007f05 0000000000000000 ffffffffffffffff
> [  239.616371]            00007f7fe1aaf3e0 00007f7fe1aafb08 001c000000000000 0000000000000000
> [  239.616381]            0000000001026838 0000000000000005 00007f7fe1aaf020 00007f7fe1aaefc8
> [  239.616399] Krnl Code: 00007fffe2b6c306: e370a0000024        stg     %r7,0(%r10)
> [  239.616399]            00007fffe2b6c30c: a7f4ff83            brc     15,00007fffe2b6c212
> [  239.616399]           #00007fffe2b6c310: af000000            mc      0,0
> [  239.616399]           >00007fffe2b6c314: a7b90000            lghi    %r11,0
> [  239.616399]            00007fffe2b6c318: a7f4ff89            brc     15,00007fffe2b6c22a
> [  239.616399]            00007fffe2b6c31c: c0e5fefc1f8a        brasl   %r14,00007fffe0af0230
> [  239.616399]            00007fffe2b6c322: a7f4ff4b            brc     15,00007fffe2b6c1b8
> [  239.616399]            00007fffe2b6c326: c0e5fefc1fa5        brasl   %r14,00007fffe0af0270
> [  239.616454] Call Trace:
> [  239.616463]  [<00007fffe2b6c314>] mas_pop_node+0x224/0x290
> [  239.616475]  [<00007fffe2b85ab6>] mas_spanning_rebalance+0x3006/0x4e90
> [  239.616487]  [<00007fffe2b87e7a>] mas_rebalance+0x53a/0x9c0
> [  239.616627]  [<00007fffe2b8c10a>] mas_wr_bnode+0x14a/0x1a0
> [  239.616639]  [<00007fffe2b9a87c>] mas_erase+0xd9c/0x1120
> [  239.616650]  [<00007fffe2b9acbe>] mtree_erase+0xbe/0xf0
> [  239.616661]  [<00007fffe0c3b4d2>] simple_offset_remove+0x52/0x90
> [  239.616674]  [<00007fffe093dc16>] shmem_unlink+0xb6/0x320
> [  239.616686]  [<00007fffe0bc0830>] vfs_unlink+0x270/0x760
> [  239.616698]  [<00007fffe0bd473a>] do_unlinkat+0x40a/0x5c0
> [  239.616709]  [<00007fffe0bd4a48>] __s390x_sys_unlink+0x58/0x70
> [  239.616720]  [<00007fffe0155356>] do_syscall+0x2f6/0x430
> [  239.616733]  [<00007fffe2bd3668>] __do_syscall+0xc8/0x1c0
> [  239.616746]  [<00007fffe2bf70d4>] system_call+0x74/0x98
> [  239.616758] 4 locks held by linkat02/669:
> [  239.616769]  #0: 0000780097e89450 (sb_writers#8){.+.+}-{0:0}, at: mnt_want_write+0x4c/0xc0
> [  239.616799]  #1: 00007800a7de6cd0 (&type->i_mutex_dir_key#5/1){+.+.}-{3:3}, at: do_unlinkat+0x1f8/0x5c0
> [  239.616831]  #2: 00007800a7de7ac0 (&sb->s_type->i_mutex_key#12){+.+.}-{3:3}, at: vfs_unlink+0xc6/0x760
> [  239.616860]  #3: 00007800a7de6a58 (&simple_offset_lock_class){+.+.}-{2:2}, at: mtree_erase+0xb4/0xf0
> [  239.616886] Last Breaking-Event-Address:
> [  239.616895]  [<00007fffe2b6c12a>] mas_pop_node+0x3a/0x290
> [  239.616909] irq event stamp: 5205821
> [  239.616918] hardirqs last  enabled at (5205831): [<00007fffe03d2be8>] __up_console_sem+0xe8/0x130
> [  239.616931] hardirqs last disabled at (5205840): [<00007fffe03d2bc6>] __up_console_sem+0xc6/0x130
> [  239.616943] softirqs last  enabled at (5200824): [<00007fffe0246b6c>] handle_softirqs+0x6dc/0xe30
> [  239.616955] softirqs last disabled at (5200687): [<00007fffe024508a>] __irq_exit_rcu+0x34a/0x3f0
> [  239.616994] ---[ end trace 0000000000000000 ]---
> [  239.617009] Unable to handle kernel pointer dereference in virtual kernel address space
> [  239.617019] Failing address: 0000000000000000 TEID: 0000000000000483
> [  239.617029] Fault in home space mode while using kernel ASCE.
> [  239.617049] AS:0000000005dac00b R2:00000001ffffc00b R3:00000001ffff8007 S:00000001ffff7801 P:000000000000013d
> [  239.617150] Oops: 0004 ilc:3 [#1] PREEMPT SMP
> [  239.617162] Modules linked in:
> [  239.617170] CPU: 0 UID: 0 PID: 669 Comm: linkat02 Tainted: G        W           6.14.0-rc5-next-20250307 #29
> [  239.617243] Tainted: [W]=WARN
> [  239.617248] Hardware name: IBM 3931 A01 704 (KVM/Linux)
> [  239.617253] Krnl PSW : 0704c00180000000 00007fffe2b6a988 (mab_mas_cp+0x168/0x640)
> [  239.617264]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
> [  239.617272] Krnl GPRS: 0000000000000008 0000000000000000 00007fff00000008 00007f7f00000009
> [  239.617279]            0000000000000008 001c000000000000 0000000000000008 0000000000000048
> [  239.617285]            001c0ffffc638e09 001c000000000009 0000000000000098 001c000000000000
> [  239.617292]            0000000001026838 00007f7fe1aaf608 001c000000000013 00007f7fe1aaef68
> [  239.617302] Krnl Code: 00007fffe2b6a97c: b90800e5            agr     %r14,%r5
> [  239.617302]            00007fffe2b6a980: 9500e000            cli     0(%r14),0
> [  239.617302]           #00007fffe2b6a984: a7740262            brc     7,00007fffe2b6ae48
> [  239.617302]           >00007fffe2b6a988: e548a0000000        mvghi   0(%r10),0
> [  239.617302]            00007fffe2b6a98e: e3a0f0c00004        lg      %r10,192(%r15)
> [  239.617302]            00007fffe2b6a994: a7b80000            lhi     %r11,0
> [  239.617302]            00007fffe2b6a998: eb2a0003000d        sllg    %r2,%r10,3
> [  239.617302]            00007fffe2b6a99e: e320f0f00024        stg     %r2,240(%r15)
> [  239.617350] Call Trace:
> [  239.617354]  [<00007fffe2b6a988>] mab_mas_cp+0x168/0x640
> [  239.617362]  [<00007fffe2b85bcc>] mas_spanning_rebalance+0x311c/0x4e90
> [  239.617369]  [<00007fffe2b87e7a>] mas_rebalance+0x53a/0x9c0
> [  239.617376]  [<00007fffe2b8c10a>] mas_wr_bnode+0x14a/0x1a0
> [  239.617383]  [<00007fffe2b9a87c>] mas_erase+0xd9c/0x1120
> [  239.617389]  [<00007fffe2b9acbe>] mtree_erase+0xbe/0xf0
> [  239.617396]  [<00007fffe0c3b4d2>] simple_offset_remove+0x52/0x90
> [  239.617403]  [<00007fffe093dc16>] shmem_unlink+0xb6/0x320
> [  239.617410]  [<00007fffe0bc0830>] vfs_unlink+0x270/0x760
> [  239.617416]  [<00007fffe0bd473a>] do_unlinkat+0x40a/0x5c0
> [  239.617422]  [<00007fffe0bd4a48>] __s390x_sys_unlink+0x58/0x70
> [  239.617429]  [<00007fffe0155356>] do_syscall+0x2f6/0x430
> [  239.617436]  [<00007fffe2bd3668>] __do_syscall+0xc8/0x1c0
> [  239.617443]  [<00007fffe2bf70d4>] system_call+0x74/0x98
> [  239.617450] INFO: lockdep is turned off.
> [  239.617454] Last Breaking-Event-Address:
> [  239.617458]  [<00007fffe2b6a8f4>] mab_mas_cp+0xd4/0x640
> [  239.617468] Kernel panic - not syncing: Fatal exception: panic_on_oops
> 


