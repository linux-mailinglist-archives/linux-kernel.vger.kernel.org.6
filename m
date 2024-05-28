Return-Path: <linux-kernel+bounces-191573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6908D1105
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 02:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B47B1F21A90
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 00:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5114C13A3F3;
	Tue, 28 May 2024 00:37:11 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80DD12B17C
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 00:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716856630; cv=fail; b=h+q2kU3b5vqKhbkEcQByrgg0FjAk3MDjpei9wrrp8oEiPvnn2GS0ag8k9F/4FQl4jQGecJzraiUEeH9pZ9l/X6qe5WRzr0iO/4u2FHuWX2B6DJWr4dJnh+0zlwxwA7PtUWD9I9ph+2o1IcK1zVAMGiie/5cioxej3LUVh4PUGyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716856630; c=relaxed/simple;
	bh=3ceJG9gJqAjC0LmlmbR7yzBaj0ZqJs+adUmG+61hlAQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J/RLaFVrSSCsXm94k6g9mZbOK4Uk1vH6xbri32kNzdLfAC619YDMnOd/sAw07+9xtXG20pk9BnFABXA3+b7Myqz1RGTB1hqbFyE1dw2K87p8EixFsriYmYT1bVb+zbB5NaV+HGMHOnYU7dkAjXha9bwHeqbUcOHe1fRYN7XKX8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44RG89mp026064;
	Tue, 28 May 2024 00:36:54 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DREdixNT5VQLqLMqf8JvB/Fl5AFaya6TLnsm8XTNvZAk=3D;_b?=
 =?UTF-8?Q?=3DHAa4JHsEVfmgSOcffAZ0MP179fuOHpe9A93gzRDcUlzoMc7ZuVwhOvnU2lnj?=
 =?UTF-8?Q?bE90HM4K_w/4I+WFM7WtIo8dlo5iwEa4soL3JT3gTKzlPs+2WyA+lddvDndqnG/?=
 =?UTF-8?Q?iLKmiRN4JnE/8P_AZGjl32QWxIM3KW8OIJiZQWjak1TgqPznXpYFES/kVHIAYdH?=
 =?UTF-8?Q?81qH1FizpkCjF1Nui37n_M+0UKNUa0CB/VTWFzsEW1zrpEPC5aYSa3EGETuhKTn?=
 =?UTF-8?Q?JTKYLw3pyl1MU0scwpTXrMmyrt_DZlcAUMJp/lO4cvzG6RQ+JI9NQAoKGE2Rjkk?=
 =?UTF-8?Q?ra+jOA1NsEZpRzidyJewvE/S0MqZ7q8L_HQ=3D=3D_?=
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8kb37rk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:36:54 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44RME2PD016172;
	Tue, 28 May 2024 00:36:53 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yc55vtgb2-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:36:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BMC0nB/3Y4qCN5UUUKigHuFu0Z92Cz5uMf1nRqhsXUchhAFQ/5c3+y0CHX6L6wNgrpMs71WvA1gvvjmFOmZF9rPK7mskGRsLHI/CUTDnRXxrKIif5Pe/5VW1YclM96thz/J0jrHgPiGtn7/nh4VvYxUBChyoDhG0aTL4MHc70G07PqQ7E4p0fWvtYcon1yzZEFabK7THDc6BsC4a4sySR5Y629OZrVga+gb6wcUSg70IUucWUS37Zc/BM355GeI9qXmIIUpg4MCb+nUifSrKPHzsZnmfVU/Qx6jdFsrigvTatIF8ki86bVDssMy6UMMDbIzeBz8RoNNJZSfW0UFV3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=REdixNT5VQLqLMqf8JvB/Fl5AFaya6TLnsm8XTNvZAk=;
 b=XT8ojj25+LT3Uzvb/SxHK4qREICWduoefAlx9EAPtcNlGzJ9/zAQJ5W5AduAMewdvEwcLDnBr08Nvi+L7e7tKOaQLKTKQrb4FX69xDFau0qjDO3tHoIVelTV97XDAZFDLswxezXY6Wi2kG1ybnmlDGvWb1p7KEzOEmijKkZ6FkHhiy72z2QCPBGDGngUlVPmLLu+fKZNKMKwWQFMQrWeWYDpBZaNsYHCQxsmMLPPe12m9aodoqX8uNexu48cRm4/s9qRgZvbvLjM/GkavKael/hPYkvj3roTZznp7Z+eKJkQKD6d1ot0fAuDeLS/sezcYzAB2+/MDearG6Q9XXs14g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REdixNT5VQLqLMqf8JvB/Fl5AFaya6TLnsm8XTNvZAk=;
 b=fwsRHp572kGUNFvI4WXFl3UUltw02h/UyE9VBnB4eMJKq6vwgeQooNGjYVlH1R+zYM6DEzsP0TT7FQ7lZ4mTwNYShKPm/Z81T05IxF8DkTzW4aDduxAMyl2Fr8lVbCi/+xak19VeAedAxQ0qHF7lV0W9JQtyGoHpEWZj10O9khE=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS7PR10MB7177.namprd10.prod.outlook.com (2603:10b6:8:e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 00:36:51 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 00:36:51 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, rostedt@goodmis.org, mark.rutland@arm.com,
        juri.lelli@redhat.com, joel@joelfernandes.org, raghavendra.kt@amd.com,
        sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, Ankur Arora <ankur.a.arora@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 29/35] sched: handle preempt=voluntary under PREEMPT_AUTO
Date: Mon, 27 May 2024 17:35:15 -0700
Message-Id: <20240528003521.979836-30-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240528003521.979836-1-ankur.a.arora@oracle.com>
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0330.namprd04.prod.outlook.com
 (2603:10b6:303:82::35) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS7PR10MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: fc4bd3c8-1971-4b9e-d8a1-08dc7eae442f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?juBKbfgoNWd+DGlgRJ+o6o4f7dfzoUdqBLCpM959vt5xPobnvltX2G1ZTUhk?=
 =?us-ascii?Q?bt3yRDz49eUXbjkwxeNrLaFFIWI7DIvaG+kGO5j/9rWEl14y/p7aCPchpCEL?=
 =?us-ascii?Q?0uINedjQqm7z5sKpowfH0/haZ/I1WX0jrsA8K3WxWv8ktmlTmluTPdRTu0FX?=
 =?us-ascii?Q?ffCxc+mTWnOm/y1AO6D3wiWCs4VaE/VFzPYIl7hiz9PEJ5PiFN9KB68SLXlg?=
 =?us-ascii?Q?mOL3+w5hpUnUz47fLciHKZdT/fdNBz2RvlIcg35ZwnS+qa2LVVqq/Yff5qAb?=
 =?us-ascii?Q?l0Abt4HgeQGeGCsrzZfrkGHk/xF35o367ZzdvYoUTITW6LRDdDxE5QQrFaXn?=
 =?us-ascii?Q?VvE9eiQeHusZl1uYBUpCoLkSXQjMGHD9nDYlUgyNG3kpkf+l4hZ3ONjAHvbW?=
 =?us-ascii?Q?sW0cJjvJwcpetf7jAtstK+CLQgwJyaFRqmMjk/hh1bReOj5o6+rnTZc8s2tO?=
 =?us-ascii?Q?/7nilbG5K4YbYDt7roG9z9hiXj665UiZp0m7UA14V3S14fbzPZQABPcUbwa/?=
 =?us-ascii?Q?f7WUNdrub5zO8wLj+wII+6m8bRgY26BoqHTzFBSBUnroJTNZ+IG4V6lntAMu?=
 =?us-ascii?Q?I3LZ9M7yGvIck1TqZywBosxw0158XMlnj8VMA2AKoVIT2mEiYd1XwUT+b/gQ?=
 =?us-ascii?Q?Bll/TjtyV2f1VKfC8wGTZi+pvzTrjM2fm1DbL52vhkNhLw2qsy7lhzgejaR/?=
 =?us-ascii?Q?WBRPdWwzCucJzu/9WjI9REkULOey/YP/6Y6DF5ZuLIlKVO1Dkjaqcu3zbQXx?=
 =?us-ascii?Q?jBVb2SoAWWdSUfTdR0uxBnQL6sfhsfZtexIcvs8UneN7E1PzeZ66YXYGcHU8?=
 =?us-ascii?Q?8KUZgIJlJAc5FWkslreXZJk9ZHUt1ZDzr01dg+rDBfxYoRjJQaAwlzXtgK7e?=
 =?us-ascii?Q?xgekQIW6G7FZ9MatVninDZlvlsBQMWbDXlw5xpqMR8ML9vgr3lPw6ZdM9epB?=
 =?us-ascii?Q?47jT/J956237S8F//lyQRJgZnrASE/cmXnW+zoU/i+Vj7ikf8tF/Fu63Nba4?=
 =?us-ascii?Q?95JMb9bVsXXGPB5QfivzlTP2bzW1rvLrk5i0v6JxyDZCtHip53xe61KcHkrt?=
 =?us-ascii?Q?ZCubFvfjgv0eFA/J0gQDb/YiatXgSuP9qSxnFI+E0uAWfXnIuKLr3Jgy778r?=
 =?us-ascii?Q?HQyGLB1GJr9EQkP7EEPm82iKqBj7lCQODmhTofJWcaurMptLgD6FuzIwG2Lv?=
 =?us-ascii?Q?IjX9OEK9Yck6KV9TSMPy5jwNydbrMRGzoYXmsQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?fc0Rc9NCVRcDSu9vsp/Oid1ZufiGghcWvR2YJnmNebFkFE7hwQx2vBbCPKGy?=
 =?us-ascii?Q?+9ui7tNS7lQpTf/fuu2TpGkqKAp3TyPz+Ou8qEt4uqbZ9cw8w7T7qXK5i5ki?=
 =?us-ascii?Q?9LOcQUCnuX/5w10dKVX+i2EEo3r7NzaWPH03RJ2evavwmfiL69wgvm0SrXJ0?=
 =?us-ascii?Q?vK+9bhq2yqsAhefzAXznu8dtgyRN225TcChCljQGMEX8OwPmO6aYq0BhxwFB?=
 =?us-ascii?Q?YwwG25kCaeYvr53lM9nkddK9sBe6ZqRpd/mMxP5q+mP3F5SjCBlqdQM+f/q/?=
 =?us-ascii?Q?ZvtAjNm40A8JTgrMz14zFEEjZj8BS0m2C08vOU5sUMfI7IrT1ikuIk/XPbVP?=
 =?us-ascii?Q?U1x5OuTEPzRDSLYaecPxLHB1KeWnqlVzkQghZ3YkL1LaTsfI3bPK/PhlWIlt?=
 =?us-ascii?Q?g5vn/HenuZNf/VHt/7Z7jsmVdtLW3tm27mdmZ8Ez1Y3N7CMokNZy13zv7z71?=
 =?us-ascii?Q?vLmlB0N+4pEFl/UGGw6+/8Sbh/8I5qABzJMunPgwhL56I9F+RhkAG5jOuAXC?=
 =?us-ascii?Q?nH8XgbNhgk2OGWuZ0+OrroqsQm+haI/H0WM0xTOYO+qF1goFKfK+ep2Z77iE?=
 =?us-ascii?Q?/bi1kCTbSW/hPO6jlUJ+nYvnTwrf1dgDOH6f72jcVUk/uw6Hu2uX4fdUuHte?=
 =?us-ascii?Q?NU4ii5eeQIZqYRW0HM62VlD5I+JM2IryK7SnzAa5UgKX9FwaqvJhrZDNbgCg?=
 =?us-ascii?Q?e+ugatMIB9At04Inb6In71PF0bW5GVqd8nA67yF51dYmFYg7tsyg4/qMkv6+?=
 =?us-ascii?Q?x8mAA1/pR+ZN498UGiQEYc0jRgdCFre2vmKk1rpcTzGJmeKjtMk9nflDm0/k?=
 =?us-ascii?Q?+d2So6NsEjDGflN67agDRugjghA1NGI4vBWQPH9tuEjwMxrxy3+Y333Hzj+A?=
 =?us-ascii?Q?d7nC/9GN74czgu4XHDCrjImkxAmSmd0m0WtRcvXwXAy1yfiiI3RUIpg+qpSc?=
 =?us-ascii?Q?lAzh3n8+Uv3NqWNWjGEtIGg5FB3ikJdjeHj4I01U6XAvQ3Hi9aXcfb07ZDsM?=
 =?us-ascii?Q?2+GPgdm4fPEne1uHdhal020egYSBeacF+3nrxbcKroTHHPz2iuzsdkjMwKnG?=
 =?us-ascii?Q?J1RcTbEeBtQfTQtiNJGXoig/h9HfUuY1mhqQyqMnEBNlMVReLvSZ2IDNg8ZX?=
 =?us-ascii?Q?upIqg/lmwimEFnWjz2j7S4t3jPXdCgs1TldieY2xt1OyUxG5FRNKtu3+Tyxd?=
 =?us-ascii?Q?5N+DRtTyCTLk6CHzCzBzshdFrBNXPAK7Jo+PJL3nQrm6U9jVpxvaQIt3jrqp?=
 =?us-ascii?Q?ksaahGN5QkHdV2UZGoJwfsO4eVketqOKhNIozhh8XxAWFWWNy8D3v8le659a?=
 =?us-ascii?Q?bMhUAn0gi3MJs0mUd2zh+ppBUcJ5OS0umS/j7vaPUf2wtv/vz8ZKgZx3G9/P?=
 =?us-ascii?Q?aQPDvgHeVf6vjlg/kLAfGu1awrCUgySI6mnfyn4oBzRB3Xjv4/9UpgHZmQah?=
 =?us-ascii?Q?BgxbvorQ6RVU3PXI5AdvhfaJj24qfyZWb22WNg8A1YrbkKTfgxYHAspV7ES7?=
 =?us-ascii?Q?6ZqH7QPS1aMor0RGKbXAfFKKTRqYkpJz47RACa07McUnvpN6XzrsYSk0eGym?=
 =?us-ascii?Q?nsS/iBE5yLIn9ERb06hz2CEeojP46PB3bKLlge7MrpsUq4ZJ6PLPW4KEBErM?=
 =?us-ascii?Q?Lw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	WxCfkZFA2Jm6zplXjgWEM3iT7OTVecs6erNOr8mVEDa0NpkefbGQRdLJvIz41WktoqalG5AVm+s/q2q3bhw+AAQhBSV2m0TR7HEDeNL/gV319Lm7uF3hGKHp3xi88Bp3Ba7WLs6ImSaa/yS/Nk7m3OKLjTHmwxBRBKCmPkqgQQ2gUUQ/wlM3OzTMWKeBSJb+TtZUaVjTAIA/uKtmHdOL4Xo/WswlrauCFJF4Q+pU2nCvcVom/wZkVDkbJzyVQdfCMuCxPNo1JEuR40BSL2eAruv/CIpgyhuLceeytWdpzf5TrtTAH86PfhBQzueZisbRKGtd7QOdsZlw6F5ssEBREiwb7SKBuBRJTqJStCEae4UvIoHzNTZGNiiqSBAad4sB9BUhWT8BHUmCcBzoKvZleQkK75Ypr55Hz07CBjHTDtiaidCvLwwllXy18NvfAzSoxNJRc9ChhpCOiDQBX55XqVv1PVtHX2VKmx/bqJ2N4iEkwYclnmUf0eT1zWubqp6g7SDX05pInP/bO8aCX9VLxjM9duggADc5PIX52LlEMuJL9IaZ3IFpeolz75U/h/Yfwmd9jwUOdE/pPWR1a/fIMTVvG/u7Fvy1NcLbBh9YYXA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc4bd3c8-1971-4b9e-d8a1-08dc7eae442f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 00:36:51.4655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BFw70yCJqoal6X0eMmCQL3yM6fBRzXf4oOqjSWU0cylY12eMLoo2fQdGoMVcgR0CtWpEkn2cmalPw7A6aD1XcUPrRQmwhZJ2Z1qZkPw8rOY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7177
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_06,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405280003
X-Proofpoint-GUID: T10g880XklQF7SQI3i1f6ijutrj9-P_P
X-Proofpoint-ORIG-GUID: T10g880XklQF7SQI3i1f6ijutrj9-P_P

The default preemption policy for voluntary preemption under
PREEMPT_AUTO is to schedule eagerly for tasks of higher scheduling
class, and lazily for well-behaved, non-idle tasks.

This is the same policy as preempt=none, with an eager handling of
higher priority scheduling classes.

Comparing a cyclictest workload with a background kernel load of
'stress-ng --mmap', shows that both the average and the maximum
latencies improve:

 # stress-ng --mmap 0 &
 # cyclictest --mlockall --smp --priority=80 --interval=200 --distance=0 -q -D 300

                                     Min     (  %stdev )    Act     (  %stdev )   Avg     (  %stdev )   Max      (  %stdev )

  PREEMPT_AUTO, preempt=voluntary    1.73  ( +-  25.43% )   62.16 ( +- 303.39% )  14.92 ( +-  17.96% )  2778.22 ( +-  15.04% )
  PREEMPT_DYNAMIC, preempt=voluntary 1.83  ( +-  20.76% )  253.45 ( +- 233.21% )  18.70 ( +-  15.88% )  2992.45 ( +-  15.95% )

The table above shows the aggregated latencies across all CPUs.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Ziljstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Originally-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/sched/core.c  | 12 ++++++++----
 kernel/sched/sched.h |  6 ++++++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c25cccc09b65..2bc3ae21a9d0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1052,6 +1052,9 @@ static resched_t resched_opt_translate(struct task_struct *curr,
 	if (preempt_model_preemptible())
 		return RESCHED_NOW;
 
+	if (preempt_model_voluntary() && opt == RESCHED_PRIORITY)
+		return RESCHED_NOW;
+
 	if (is_idle_task(curr))
 		return RESCHED_NOW;
 
@@ -2289,7 +2292,7 @@ void wakeup_preempt(struct rq *rq, struct task_struct *p, int flags)
 	if (p->sched_class == rq->curr->sched_class)
 		rq->curr->sched_class->wakeup_preempt(rq, p, flags);
 	else if (sched_class_above(p->sched_class, rq->curr->sched_class))
-		resched_curr(rq);
+		resched_curr_priority(rq);
 
 	/*
 	 * A queue event has occurred, and we're going to schedule.  In
@@ -8989,11 +8992,11 @@ static void __sched_dynamic_update(int mode)
 	case preempt_dynamic_none:
 		if (mode != preempt_dynamic_mode)
 			pr_info("%s: none\n", PREEMPT_MODE);
-		preempt_dynamic_mode = mode;
 		break;
 
 	case preempt_dynamic_voluntary:
-		preempt_dynamic_mode = preempt_dynamic_undefined;
+		if (mode != preempt_dynamic_mode)
+			pr_info("%s: voluntary\n", PREEMPT_MODE);
 		break;
 
 	case preempt_dynamic_full:
@@ -9003,9 +9006,10 @@ static void __sched_dynamic_update(int mode)
 
 		if (mode != preempt_dynamic_mode)
 			pr_info("%s: full\n", PREEMPT_MODE);
-		preempt_dynamic_mode = mode;
 		break;
 	}
+
+	preempt_dynamic_mode = mode;
 }
 
 #endif /* CONFIG_PREEMPT_AUTO */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 107c5fc2b7bb..ee8e99a9a677 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2468,6 +2468,7 @@ enum resched_opt {
 	RESCHED_DEFAULT,
 	RESCHED_FORCE,
 	RESCHED_TICK,
+	RESCHED_PRIORITY,
 };
 
 extern void __resched_curr(struct rq *rq, enum resched_opt opt);
@@ -2482,6 +2483,11 @@ static inline void resched_curr_tick(struct rq *rq)
 	__resched_curr(rq, RESCHED_TICK);
 }
 
+static inline void resched_curr_priority(struct rq *rq)
+{
+	__resched_curr(rq, RESCHED_PRIORITY);
+}
+
 extern void resched_cpu(int cpu);
 
 extern struct rt_bandwidth def_rt_bandwidth;
-- 
2.31.1


