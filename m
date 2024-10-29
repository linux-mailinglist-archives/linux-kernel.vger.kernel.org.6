Return-Path: <linux-kernel+bounces-387126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D54A9B4C41
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E148A2841A6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 14:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF92206E72;
	Tue, 29 Oct 2024 14:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZvpdcxOp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="U76I95ph"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA76220650F
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 14:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730212750; cv=fail; b=FhnxeuGGDBYdpUvn34P2wsliv/k4cB6t3Q4m5awFxUKkPtkHNL0VQZ9bXDZJl9e/fdSXQL1jZJgxme5j1C4qUjBNprGv/mzXR5ZqFC6bw4agnQmqVFyPsw4PdiWXzQzckWFG23F/AVLif8KKg4yTUyirsfdw5NJ0+9GzVwYniH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730212750; c=relaxed/simple;
	bh=eT423GV3WH5++3/XrV2xI6fFRmV7IkSbLv6a+5yGpnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cBwZMSvP3EWYwbPgC/v63G2hpRQ4dIz8mjycSzl85hMP5kgD1I+pl9BNutU0uzlmUe3934EUIz/5vYMmvbCptNAjHjLv4bz2go87obRjs6q0XLXHt+eUSZ3iAFPXjvJSLTYnQLZt2asdMn2+mzmEYxa60JcVaUxh1nf8AB3l//M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZvpdcxOp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=U76I95ph; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TCbmwN020947;
	Tue, 29 Oct 2024 14:38:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=2cO9zr1gB1msPTJCqP
	x60dxwCkpRbRddTKyJvRqYddM=; b=ZvpdcxOpNLllFIF4ivfprlIBaU9vtkjRZ5
	+DiBLQ8QPbNV0Ur4+0qncY0MEVjzAmRwm/wXDBLRZr5qkk/cMNSct8vtcRgBlI6P
	Kf3lc75YM88eLFW3OdzZXzNkNuFC89GDL5CUpIV7riHPtRhaIl7inrrT/8BpIQQY
	7PM58Y9iqYmxETOYSfTh6Kev5NE3iD/RoKEECfgDKf03p+V+lZohh2TxxSFj3xX5
	iq4DWqiWVhfl1PBUGzK+ZlIOFVLTqLZIBxryJypkeMrNChq5NjWZzqK3Yr9X3260
	YPTKZkEt1yGpQoskOu+87ipgbxWkb3hxqjG7NVpORi1Z+6SboKdw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grgmdpey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 14:38:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49TEUiLC010074;
	Tue, 29 Oct 2024 14:38:45 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42hn8wy0da-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 14:38:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NjE7RYckNYaczOpc1lgpyJTRaQKOZESPMTdjla6asRYsGvjUlfr08CwnOxGAWrCgexg4AAGQJikJrFNek2ZtNMsI1pCWYeuwPHr62Kt1QYjRRj3wfRKRDY+AlpVMIYYtj8vuPaK0AYgL46enRiotrbsSJZXMxD6/4fQwPT6yP1apWmksb4W1ETvoBO6BeKfAzM+IziRdUo+WEamSloAoO2vvp6UE1r0I+9fGy2UB1A4azGtlnq7+Ms2//+47HX3gx9/+ZzKnzi2FSJzV1U/0QLY4Ug+XK4Wu2zJoXe1wCBjSOF+rJkw663aGsuVt5s/5gyJ16jWPGIra7lLvYHlQ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2cO9zr1gB1msPTJCqPx60dxwCkpRbRddTKyJvRqYddM=;
 b=gJMaSp3ylnMN+WMZknfS8alGXaQm0rB//lkzsM8uypDACt6JFDS7W8e17WgM47UL/zWLx8l+RzNZghAvn+uHLqgUzilj9vS/5FNGTcr128/mK8RKX944AIB8fHXcPZ6EX7SMQlR4kdLEJgYNA1WIZKe/X+D5JEGhWQOqmtPwZdLpjpn/WfL+DNzpzFgtWYsNuzGr+di4bi0V4Vr7bar1lfDUlwl//a+WKMpudSLLB3ZicJMLuXZjS3LDhXdM7e+mpo0abxDrI5IBeCB53vdY+kdxuGRkKXEj2zJWDKh00GNT160jxwCMISLC1qklLaHYAtcuGCrMedB6XzEsppmOtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2cO9zr1gB1msPTJCqPx60dxwCkpRbRddTKyJvRqYddM=;
 b=U76I95ph1EJ8Qp4FIgCqaBnNoKYx/JXyhz392Fmn/OId8Z4pRK3sTobD657pqTWW79IueVt6ptuG/n6VpBkNciP+1VnnfqFgcp8TJHclWI+0bwE5fBJlVPRQSGkEaX0Ufo7tZIuJX5yS96Y4Kd7ENShM1dkqZ7lTKLep3dvbRbI=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by IA0PR10MB7301.namprd10.prod.outlook.com (2603:10b6:208:404::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Tue, 29 Oct
 2024 14:38:41 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8093.024; Tue, 29 Oct 2024
 14:38:41 +0000
Date: Tue, 29 Oct 2024 10:38:39 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>
Subject: Re: [PATCH hotfix 6.12 v3 4/5] mm: refactor arch_validate_flags()
 and arm64 MTE handling
Message-ID: <t74gfifu7pjxkuzly6xkuereaygq3uuby76vobtqn745q24rdw@alu6oyyvf6xh>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>, 
	Peter Xu <peterx@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>
References: <cover.1730206735.git.lorenzo.stoakes@oracle.com>
 <ea10a05be83c70cf610d470fe3b4c05513e3859c.1730206735.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea10a05be83c70cf610d470fe3b4c05513e3859c.1730206735.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT3PR01CA0037.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::14) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|IA0PR10MB7301:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e4ab23d-4500-4b19-1cdf-08dcf8276231
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e9bouP534TPaUk9RaEZoH6VN2A4nb3eiYwYk3K5zhMIOcv7U757klD472ApK?=
 =?us-ascii?Q?DDSQ5+iiyySAv4el9wq5eMopQHA6xF0goW6W84dtKgBnfVlLTD9/GtsFkoSS?=
 =?us-ascii?Q?Jxk+z0dHKhLoKMZEzJNWWrO8ND7is4/CBBVHD2Xc3WXYKKVgidq9T7vHImGR?=
 =?us-ascii?Q?u1rlzdedx/ZOdQMrfVtFGYCvtsfJ8gitbYrlG+8zZJkYQVCVb/xIAD06dUJn?=
 =?us-ascii?Q?Bmnmrn4NGVNt6othQ+GSrtTYOulIR4LkYlEMwRKk7zBi0GPrFWl+PefYeTqA?=
 =?us-ascii?Q?2MfUqtX3NPSp8IIcgy3pdTu9n78juNFiw0hKPAuzNtXier2iwq5VLBqaLXui?=
 =?us-ascii?Q?ee0pswcHydqli+myU72//0C5+f7nxkRZRk/GK4fw8CbtDkucphkHFtm87S/b?=
 =?us-ascii?Q?eAb56o66609J0nrC9yxqpZjQ51WeedVckvaxK9L7omLIQKI7nvrb21ZYcoaI?=
 =?us-ascii?Q?mtOAQG/nytjrTAcVv7RsuoeG9sKlhKfxLVlFQUfAEjMDZI9kDkunF4ZXTWAx?=
 =?us-ascii?Q?D7X+080uUdDxEsoNuscIn/Sfn1t5KCBkrNY6MRxF5+FtpdrhXwCpeWjUTdMu?=
 =?us-ascii?Q?BQysZ7dNzjHFCojh5guXw8bzMP8fnb6CVRAyXCofMmn5yDreNHO3wIgsdyG3?=
 =?us-ascii?Q?2hTH0DGj7nLAnaKqZsr0R4aG1n0lcTy+NJ9iCZRtS+lyjZZluexW2OUYFEFu?=
 =?us-ascii?Q?OqbDJbfw/sFBC9uD83abQ/LwNxla0kYprz8iPSWMuKFVUiBGTmmGEWbA7jeV?=
 =?us-ascii?Q?V3gKUu35sepucrF8xtO0lU6w0qZgXnbqZP92FMe0IqBKhj6RBHBwc1reQEXn?=
 =?us-ascii?Q?/VGLBgwuiGBAb+peqx25hxyYnoed/6j+KrtkQFEkzazj+WqNlCMQebE9hqmj?=
 =?us-ascii?Q?BMCANO8drfpkB9LHj3srH+yFZa4TKYSdLX9gwxDCqLgLRLVRpfZWrbHUepQQ?=
 =?us-ascii?Q?wofRVZQoHtcVqWCPXx01LBGRY3iAPl0CzQxy70435pGSD2xZeo8JTLVtbpXE?=
 =?us-ascii?Q?YcAboIVSegAbFxin2Ce7tKq3bP9eT6yZ8YTfy7clIDh3Kz3dGoFKbt6s3K2S?=
 =?us-ascii?Q?OYIsE35FmVn6GRFK5WKELuL2DdAHFjk8WjdB2brijJwhWPG14m9+hJGX9N5D?=
 =?us-ascii?Q?X5MfBEkQZz+ju7Dr6v3RM3v3Px9afEGc0izzeAiTXWjmIXUW9PspMVfIXJNA?=
 =?us-ascii?Q?ysunFBa+oTga/w9+TLzqNVke+OZX0zOepbgLXjeLbpicHLITK/Tm7DjuRnAD?=
 =?us-ascii?Q?2D5TrNivR+dVdt1+lsOsxRYk6mVDtgnqdvAsbEfVmxkwSwHPv6BrRgQp9CBa?=
 =?us-ascii?Q?Z3FjkGjIkyGLhv9ggI1mMCEd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zZ12Ev1eUQvTiUisntyJR4fmB41lsWukxGm0d5XZsYlP2mL7yKSpq9ZuyUEK?=
 =?us-ascii?Q?X7UGBGvfgqqP3I1stZAk6BgsvsxAUkrmQgVcYFoRm154qHKY8rGAzCPJMxWW?=
 =?us-ascii?Q?/fasu/VRKS+L/EItv2R+Zz9aGSPHh5OCmp6meT9RMFF9p1F9+6EOs1Tvz27z?=
 =?us-ascii?Q?E3XQA6fO0BLYdWLvT1Az6hcvb2W/wYKcjs+N+L8aX0qKS6XvCstsdhixudlS?=
 =?us-ascii?Q?tbYRoJK/LHS2yuWlQ9bqLuE/UtvgiOeOZJG9IZ3tgP251Ac+Ubjr4cWsgOlv?=
 =?us-ascii?Q?JJPMstmgnIuP6A5dCciviilX3Ty1rDVxN6Tg4JtPjci7LevmfwiTSShHz+w4?=
 =?us-ascii?Q?itOiRW53Y3j+IFZfoyZZYHSUAvsaWQWcNVdcM2IlAOqjwy3jA13E+ws6FLuh?=
 =?us-ascii?Q?00rX8sz18rGR2dkfPcThA8JBn6wQVkRNXYFwIh3TR8YQtrHw2an/27iAWeQX?=
 =?us-ascii?Q?mAsZX63IPmqs6F5rtoYm6wWFiDG/+MkblLKP9j1nNNEKIPvtWach+4jFKIph?=
 =?us-ascii?Q?rGAMO2ZpuiOgp72gpFvZt7h6iVJk90M7+JbGx9u4+isiF9tixmn3kGwCX/N/?=
 =?us-ascii?Q?+kBQExrQvRnPssUAqNCX3050Wso6o+C4cZ+qCUbQaMiCLltS5vmmsyjIIDc9?=
 =?us-ascii?Q?E2SP6OlsuynU2lUQgMfY+1sA67VQSSjSedBWwjjUMIGRr9RMCq8NVF518H6L?=
 =?us-ascii?Q?HwLMaD4VWlgJTMhOhnMvIUJqty4H1zuBaxjSoukO5rbYtB/ma7u405cQz3+P?=
 =?us-ascii?Q?dC25lW5R68M2VGhJ93zQPPo9f6hdx6iGRHOiGqEEHCyWz6QKwUAgWfgboEWi?=
 =?us-ascii?Q?jfu6zKmABBhkSWWdakvp5LNKBQ3H3x+9FDYrR97Ev8LQR8nFGDENhs4Oze9U?=
 =?us-ascii?Q?9cPXRIwbIxm0pDeNu3Dom6HSwL4kdAFBMZ5aF96n9b235ORyewwCfXDQ+fyY?=
 =?us-ascii?Q?9k1pU+R8GfgAhLw3n4rmJoqN1BT+H6r1J0BQFvtHAQ+cW8++rRKHfFPHf7vu?=
 =?us-ascii?Q?sDdAtZ7Ob/hChjhQTr9Eb6cc8LGpLiuDz/AMMkMmRGWaA02DfeU+iWlp65fO?=
 =?us-ascii?Q?jIE7vUfxD98MsCe4sd39ZsO5KBd7KjxVYB9RE/VGo1w9JLaCpy0t4pdbodF1?=
 =?us-ascii?Q?PgpuWY7lH/IrmaaVYP/sS5xFCdYvDdZejrS3NcsWEaJ9LhElGK1afu8kwbhD?=
 =?us-ascii?Q?t8js+VwQQhCnzddPqVH30Ff5e8g2fHRiTYqRC0U3+e4nI7zPSn0EUPC7EhrK?=
 =?us-ascii?Q?dbsKJjVYAV9i0GnBrJc5Ni10pC7wd4GRvqeFQjTPELXHRHhfY2zsiQrf0NnA?=
 =?us-ascii?Q?3UdbsoEOW8jXRsVtEd0DNvYw2IPUnTTCHKZSAXj08pxfXav5ayfmoj8/TtJ3?=
 =?us-ascii?Q?5j6VZFVlL/1b6QBXdmEv3jwDcLCmGdN3gzHeYd+wKQPpL+ZSb3gX90LuA/P1?=
 =?us-ascii?Q?I6XGgqCxZMYPnzsgWWROUfpSxFj9gswbJU7Ff2F4qOfwU3v+qyYLs5VGI/Ze?=
 =?us-ascii?Q?6o8Qt6nI4RFddwZuqkPHw6sAW6zaM0gsOBrTQr/TalfHNMemiaSIOGj2Ekf9?=
 =?us-ascii?Q?zYyMsDGez1bwWtQrx5Z2hNhaKiJcrBxlozGPpymF?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	v3Xvw4aIPWSkbG32I4A4AQDhf2TuAb9QIsYGtECfcD1MPfqUSUaCs8v+AG/PG5eeGSWld4QuGvWdc7MvXmAjPpP9LBAoPtfDVsozzaTYOjWeWCPHSiPFqzXlJNBBFHH8V7VOSQOW55200t/upHEh51uHqWbsrR50PuNQkQ+2/j35B20A+8ITeOZzaJcDFBRZlRfxkNRkMznXJSA/pAVMUuh420PivwGE9F0pNBY7lJY9a0sh+uIUU56/P7BtbW+rZcHIJCYsaEyLr9R6zCg8d2fSSr90W13q1Qp/WEo6mhkSsP7k05uzqY1AvkXR5zic6KzGHvDZuXKRgv/4/h+f1tu/Q4m+rm4gzBvHIZXVmm4egA6NO5ihEB4qk7WB5PHQU1ddxFmELjBxwL+qP+YySH6EXgiNh7dOY3Fc7odd1XjazxhFrSjE1UOPd5tNfQp9vcph8acSywmKyZrhLeXnQlMTbG1ig0Kf9iJk7R7e8gKjntacVSQJ1XdCDrlCxfisaGdzK++270xi3PvmGsjaASBpNKFif7IiK8/qCvRD6Vy5nHwEKiM8aqBYZeonVyIuFYr7dRjWEgcR6z85U2K9LINwl01dUgiqzWXQvagJmm8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e4ab23d-4500-4b19-1cdf-08dcf8276231
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 14:38:41.6043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3/xhuDykqatNS6r/87QCqKJ2Too37zGFdgfshRzz+IIbcWoGT4qDo+Dt6XP7v80iuumYxR0xf79LwS5YITFvTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7301
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-29_10,2024-10-29_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410290111
X-Proofpoint-GUID: RqHBrkBKisoqcVqWV6l6YXfY5U4q1DCr
X-Proofpoint-ORIG-GUID: RqHBrkBKisoqcVqWV6l6YXfY5U4q1DCr

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [241029 09:04]:
> Currently MTE is permitted in two circumstances (desiring to use MTE having
> been specified by the VM_MTE flag) - where MAP_ANONYMOUS is specified, as
> checked by arch_calc_vm_flag_bits() and actualised by setting the
> VM_MTE_ALLOWED flag, or if the file backing the mapping is shmem, in which
> case we set VM_MTE_ALLOWED in shmem_mmap() when the mmap hook is activated
> in mmap_region().
> 
> The function that checks that, if VM_MTE is set, VM_MTE_ALLOWED is also set
> is the arm64 implementation of arch_validate_flags().
> 
> Unfortunately, we intend to refactor mmap_region() to perform this check
> earlier, meaning that in the case of a shmem backing we will not have
> invoked shmem_mmap() yet, causing the mapping to fail spuriously.
> 
> It is inappropriate to set this architecture-specific flag in general mm
> code anyway, so a sensible resolution of this issue is to instead move the
> check to arch_validate_flags() itself.
> 
> This requires a modification to the arch_validate_flags() signature to pass
> in a pointer to the struct file associated with the mapping, however this
> is not too egregious as this is only used by two architectures anyway -
> arm64 and sparc.
> 
> So this patch performs this adjustment and moves the check to
> arch_validate_flags() which resolves the issue.
> 
> We'd ideally like to have eliminated the arch_calc_vm_flag_bits() case, but
> we risk inadvertently changing behaviour as we do not have mmap() flags
> available at the point of the arch_validate_flags() check and a MAP_ANON |
> MAP_HUGETLB case would be accepted for MTE currently, but a MAP_SHARED |
> MAP_HUGETLB would not.
> 
> This is likely an oversight but we want to try to keep behaviour identical
> to before in this patch.
> 
> So continue to check VM_MTE_ALLOWED which arch_calc_vm_flag_bits() sets if
> MAP_ANON.
> 
> Reported-by: Jann Horn <jannh@google.com>
> Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
> Cc: stable <stable@kernel.org>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Tested-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  arch/arm64/include/asm/mman.h | 29 +++++++++++++++++++++++++----
>  arch/sparc/include/asm/mman.h |  5 +++--
>  include/linux/mman.h          |  2 +-
>  mm/mmap.c                     |  2 +-
>  mm/mprotect.c                 |  2 +-
>  mm/shmem.c                    |  3 ---
>  6 files changed, 31 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
> index 9e39217b4afb..94925a0482e3 100644
> --- a/arch/arm64/include/asm/mman.h
> +++ b/arch/arm64/include/asm/mman.h
> @@ -6,7 +6,9 @@
> 
>  #ifndef BUILD_VDSO
>  #include <linux/compiler.h>
> +#include <linux/fs.h>
>  #include <linux/types.h>
> +#include <linux/shmem_fs.h>
> 
>  static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
>  	unsigned long pkey)
> @@ -60,15 +62,34 @@ static inline bool arch_validate_prot(unsigned long prot,
>  }
>  #define arch_validate_prot(prot, addr) arch_validate_prot(prot, addr)
> 
> -static inline bool arch_validate_flags(unsigned long vm_flags)
> +static inline bool arch_validate_flags(struct file *file, unsigned long vm_flags)
>  {
>  	if (!system_supports_mte())
>  		return true;
> 
> -	/* only allow VM_MTE if VM_MTE_ALLOWED has been set previously */
> -	return !(vm_flags & VM_MTE) || (vm_flags & VM_MTE_ALLOWED);
> +	if (!(vm_flags & VM_MTE))
> +		return true;
> +
> +	/*
> +	 * We explicitly permit MAP_ANONYMOUS and shmem backed mappings to use
> +	 * MTE. We check for shmem explicitly here.
> +	 *
> +	 * The MAP_ANONYMOUS case is handled by arch_calc_vm_flag_bits() which
> +	 * explicitly sets VM_MTE_ALLOWED which we check for here also.
> +	 *
> +	 * Ideally we'd perform both checks here but existing semantics support
> +	 * hugetlb in MAP_ANONYMOUS mode but not a MAP_SHARED mapping, which is
> +	 * likely unintended but we maintain identical behaviour for
> +	 * consistency.
> +	 */
> +	if (vm_flags & VM_MTE_ALLOWED)
> +		return true;
> +	if (shmem_file(file))
> +		return true;
> +
> +	return false;
>  }
> -#define arch_validate_flags(vm_flags) arch_validate_flags(vm_flags)
> +#define arch_validate_flags(file, vm_flags) arch_validate_flags(file, vm_flags)
> 
>  #endif /* !BUILD_VDSO */
> 
> diff --git a/arch/sparc/include/asm/mman.h b/arch/sparc/include/asm/mman.h
> index af9c10c83dc5..d426e1f7c2c1 100644
> --- a/arch/sparc/include/asm/mman.h
> +++ b/arch/sparc/include/asm/mman.h
> @@ -10,6 +10,7 @@ int sparc_mmap_check(unsigned long addr, unsigned long len);
> 
>  #ifdef CONFIG_SPARC64
>  #include <asm/adi_64.h>
> +#include <linux/fs.h>
> 
>  static inline void ipi_set_tstate_mcde(void *arg)
>  {
> @@ -54,11 +55,11 @@ static inline int sparc_validate_prot(unsigned long prot, unsigned long addr)
>  	return 1;
>  }
> 
> -#define arch_validate_flags(vm_flags) arch_validate_flags(vm_flags)
> +#define arch_validate_flags(file, vm_flags) arch_validate_flags(file, vm_flags)
>  /* arch_validate_flags() - Ensure combination of flags is valid for a
>   *	VMA.
>   */
> -static inline bool arch_validate_flags(unsigned long vm_flags)
> +static inline bool arch_validate_flags(struct file *file, unsigned long vm_flags)
>  {
>  	/* If ADI is being enabled on this VMA, check for ADI
>  	 * capability on the platform and ensure VMA is suitable
> diff --git a/include/linux/mman.h b/include/linux/mman.h
> index 8ddca62d6460..82e6488026b7 100644
> --- a/include/linux/mman.h
> +++ b/include/linux/mman.h
> @@ -117,7 +117,7 @@ static inline bool arch_validate_prot(unsigned long prot, unsigned long addr)
>   *
>   * Returns true if the VM_* flags are valid.
>   */
> -static inline bool arch_validate_flags(unsigned long flags)
> +static inline bool arch_validate_flags(struct file *file, unsigned long flags)
>  {
>  	return true;
>  }
> diff --git a/mm/mmap.c b/mm/mmap.c
> index ab71d4c3464c..40b5858ae875 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1511,7 +1511,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	}
> 
>  	/* Allow architectures to sanity-check the vm_flags */
> -	if (!arch_validate_flags(vma->vm_flags)) {
> +	if (!arch_validate_flags(file, vma->vm_flags)) {
>  		error = -EINVAL;
>  		goto close_and_free_vma;
>  	}
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 6f450af3252e..c6db98b893fc 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -816,7 +816,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
>  		}
> 
>  		/* Allow architectures to sanity-check the new flags */
> -		if (!arch_validate_flags(newflags)) {
> +		if (!arch_validate_flags(vma->vm_file, newflags)) {
>  			error = -EINVAL;
>  			break;
>  		}
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 4ba1d00fabda..e87f5d6799a7 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2733,9 +2733,6 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
>  	if (ret)
>  		return ret;
> 
> -	/* arm64 - allow memory tagging on RAM-based files */
> -	vm_flags_set(vma, VM_MTE_ALLOWED);
> -
>  	file_accessed(file);
>  	/* This is anonymous shared memory if it is unlinked at the time of mmap */
>  	if (inode->i_nlink)
> --
> 2.47.0

