Return-Path: <linux-kernel+bounces-370292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 068069A2ADA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94F72B2C271
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D2B1DF74F;
	Thu, 17 Oct 2024 17:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VzCA4baq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xYpKJm7k"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1FC1DF252
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 17:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729185112; cv=fail; b=Vs6KNbWgEEtJDAgvlpwf//muZuZV+FpHe9YCkmbn/UC4Lil+Pg2m7xHJgPfKzIO44V+5vbHoE3H75RIb/Lyh/w0qQG6WWjbzs+8d7jav2jZ7KSSx14gO9ezdBMsj32YujxAtMb09LJAWSlai9I9EVZdXrsvxC6AJmvfb94Ckdj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729185112; c=relaxed/simple;
	bh=79ZYNqzNthR2uFRabdzILwzZeUY1146UfYjBfBvxUV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LnlpIK8bM5i9u4Y0IVy7Brf/Cddd29Tq/TO528Y3qQP3mC6WVnGWbuxoz3JKsG3wOGZXPet5Tpq/SC3ezjNMVWmGs16GqOyMUTdaVBKWGU2WTzXuttD4KrvdAHadVN0fGTuc3DMqWSbAXZO1eGSMoYlG10Fimn7dUxrBXN+75BI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VzCA4baq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xYpKJm7k; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFBoug002227;
	Thu, 17 Oct 2024 17:11:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=GNf6oNKGHerk3h9eJ8
	uJsss1nQYB/Ttx8TKj0q74Opw=; b=VzCA4baqK9VLkE3NvAeoWVuDCVJgRylsSh
	pKIDcb+SK+CwG0T6eX644HnAk9zC5bOyKX3Oy65DNyXS9As68RIsv77BW4o08w+T
	ERFEtxdRlj7GwprB00QOkHm/CVgJwoN4nEkzmY2Iv+/fjAhgRtcjPIHm3Jz2DNYl
	TSk6Z91qAc0vHOHNky2hno3VtU0SJG0rQzr43x1zPOcSUiz04cdvCqKmT+3pej+4
	nPS3gLbZo/NdoGIScWVoLNSI6pKs/lFb82n2WLB2lvrgMrMCO6g7pyg9+/FfqmmR
	2E7qG0yXdp4afjIlbDqxTIbdUkDzHHYlEwdqMG98zbIR8i6ctOYA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fw2q3vw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 17:11:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49HGhi9N026275;
	Thu, 17 Oct 2024 17:11:37 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fjahrw4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 17:11:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QcQaIkvURlT2rj+IiPF+z8k4DtRgmQ3i0Sp+vma4afyNZQUS9vl5JzvXMrs1CtowPl/x6m+jS+7MWNoTYmnMcBTqiRJnjgltDzlqHgLHHfAmvFC2SISexRKd5sPgvXlBSFNVmGmLTD/gjmB8vWXqVY+zRV0U3r7KwqINWDhYmJYL7xlGxbT3B4suPvuZXE8ITqTR57Xbx9WYIigaq4VIGTgSDFg4vXC2XL/IYdPPPNSmAkeVZQHvzkxMVb6C3vKOApRmI+KRTF3EY63fcDNqmjgvCEkeYmpgkas7sPcp4+MQ2M/AVDIPDgsOrIzjmr5TNVeT4sDYYgX0D4cKQfGh7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNf6oNKGHerk3h9eJ8uJsss1nQYB/Ttx8TKj0q74Opw=;
 b=McFREi7CDvd+C95AwVw44+FMKYt6FeGf4oWZtYj2qS5ZEdXyxhluK7TttYloTTRmmQC2vdjpgfWrAeCSPIFNynelcNJPFYW10lxKVndGhldDA20CgDFSk/JtfyvFm6ZaiYhGzhEiOlTXi96CWvJPaR1OO50uCz+efbQOD4b7H97Hpv93QrOvOmFZoV9HD6p7gd4k+dKyiwWgaNQbLjJnZp5V1qkPJp93QfojYosNMXmBvC4WeTZrg+/Co8QpCts+i9yHZFUwiyGfZ5gLjavDKKg6rGrSRVIs5AWVR7K6n4RKa2ASoAtT5bkjDDkr9p4SNHKOW2/IgtKJWzy/eQnH/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNf6oNKGHerk3h9eJ8uJsss1nQYB/Ttx8TKj0q74Opw=;
 b=xYpKJm7klLyMX+wT92HXnowTMiBSBZ20ozur7LpErMLYGfhyBrsbflNZ1285VCiNNGh7l2ie7/Z/i5/xDmkwqJljBJb4QPsGArw9LyOsHy/yPsx3ARFypDNh3RuCIzg4Z6zXedAj0iSX+/QuJFntqo+csJJ6qIdGqDxgkdw+tEo=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by IA1PR10MB7514.namprd10.prod.outlook.com (2603:10b6:208:44e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 17:11:34 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 17:11:34 +0000
Date: Thu, 17 Oct 2024 13:11:31 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools: testing: fix phys_addr_t size on 64-bit systems
Message-ID: <6kyywoniki6lfs5hhhqxttigsnuipgm6x6doddilabswjsjbfm@qmhf5ojxgixx>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
References: <20241017165638.95602-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017165638.95602-1-lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0210.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::13) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|IA1PR10MB7514:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b4ca1bc-9524-4234-8f4b-08dceecec05a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YfZ/0ZHdXfTSQ1EmS3zE2yBlabtFUCwAR8HhAuTGQAugCRnqUHHPMmgy/KiF?=
 =?us-ascii?Q?PrVOnMJo9frZV/S8Peg5c3Cz76fg8S+3d7rvcW1xt5rQDQ981eTi8TliTtMd?=
 =?us-ascii?Q?wSPYUXGWpsh8CLJ0Wdf2jBIyxxCVqYlpGpy2QOoQgAfBQFJ1u20Hiu7YlK9R?=
 =?us-ascii?Q?4V0eILWFcwYnG84Zseey8LcpIj3LnEkTnTjTseLVS9v+xMsRkS4rF4bXdZll?=
 =?us-ascii?Q?QHdp3kXx5aCNv51c5b1TSAvZln97VLWjcjipq/lbKkFLXBemKL+oJXtIqUaR?=
 =?us-ascii?Q?TIM03Pbpvvu6SFCw/VGqCzpUEovSUTclMDwvoJWNBPoG2rPdCu68TKdKPP+L?=
 =?us-ascii?Q?gMh7cPVfbAA+FKssOjYNPODqp+Cmfq1s1VSz7W2O80XwxPPT9FZi27y1tQtp?=
 =?us-ascii?Q?rjcTkygZtZTG95o6tDpOJDWhG/df0K24K1dNokbH1fwQEbW4HSGrA94w+2B9?=
 =?us-ascii?Q?AEujLLpIMkSODRkcxBVKGuaxAHolWLYhKIwsVVPOymNXx1dUiwJSQY9QsNmZ?=
 =?us-ascii?Q?7Ce4Sina/VeQj1tvvHXS6vfTJkdh/fyjq9x4/BP82WinV9a3uVMTJ0Zhdgae?=
 =?us-ascii?Q?QipbkZQ7X5im053GYzxOGavBwQfSGKfPy6TsS675cum7tesZZeDkdPscoyDl?=
 =?us-ascii?Q?clXGMLBAhS90a2SP6GQVGCsRFynSLGSJa49eMEt4my9q3UHJV2rsYoRiPUGI?=
 =?us-ascii?Q?5wS8y/BhjJOLhTo390ZwBcAgO9NYi9j9QZqFPGtATqqw29qOgen4sqh+ZGYT?=
 =?us-ascii?Q?lamDEWv6kIMvyFhR8gk3+/Cxnom2slxjmKW9zSfuE7ZX2u+soPue9BUk+NIs?=
 =?us-ascii?Q?Vf0Hpd6yJaW6w+F5gPDk2r/MzZOWvar6eQ1G8pQSBs7auj3SHg8M7Dzei7eI?=
 =?us-ascii?Q?xxJzXBaFZPnSkkJ23GdHeb94xohtPYULa7XGYfNIjHwOyY06ViSrzxfFGeAN?=
 =?us-ascii?Q?13OyBoh3MA9Xss/Mc/LIYv+j5eN4fH+PEg+Y9+u0M04KTx/pbyNJ2gnyhagD?=
 =?us-ascii?Q?aLCb7X5aK4IQNamlV8uYOovt/LSvyeQWL1NCz1QUdRaHFmVtp8p4ej1jmHay?=
 =?us-ascii?Q?37i+s0ISFPFz49HZ2xlDruzX/fnMYHR08S1GCKsr+EwyvnoyWPAH+8IDi2MO?=
 =?us-ascii?Q?v9jXrj6gu5DzHeu//lhsLyoWX0j5cYxPgcshbSWZkJ0VWK0v/BArz297I/9S?=
 =?us-ascii?Q?MDkwpZMPZushOaZAb6TTCbiHnuOtN2SeSSl+Yg3TjLCROCuWWy3hRyUk40D8?=
 =?us-ascii?Q?bql0E+MQLe0Xb844Gq7ShnmLYLpplqt42WEn9xUHrSGDd5RXdwfVHMFpJIzn?=
 =?us-ascii?Q?4lFwXD58qhTcF5+KbfL4hlcq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CQG5paPYBPZ5Bld2zUNlXYWzMDd5VX+kq/1v6pIuZM8NMhTJghOn0g3PhiEO?=
 =?us-ascii?Q?BJBkwlTWPE8vn+2Oi0bBTK7qIUQ8iRVfB53ZK7J+JkLOSw9oeWsvPHWM0AK6?=
 =?us-ascii?Q?m3TM9rqaG/Mhxu5E77kxs7EUEtxi6bpKpJc4LtImucHqCeB6z5Au51G1U+r5?=
 =?us-ascii?Q?pVsEFMgtXbbJ7iRKjJ3jah2VtQRDlvdKg96gH8o+Zi39re6fvKQyGlD+l8Sw?=
 =?us-ascii?Q?1GeozWCK0/L7ZpVq+KFCHghcclv4HFxc4P+wyDLvNGBUjkLBb/Jq6X/HUqC0?=
 =?us-ascii?Q?K4CwJnCttubz4GO4Dm3vVVtqUWPRs4O8TKHnQdrP/7FbL81aD+hQtnrKLqQ1?=
 =?us-ascii?Q?TCBClDxK8Nveul1dNdKsq8y5ToFYCqtGzyzkRSv8E9Tu2jewPRCG3AiiKmC3?=
 =?us-ascii?Q?aQ+KnTB5WYubYD3ta+GYScyId7rHydiV+9bDxRYf3KKkV75WpQRMwlaRIuH4?=
 =?us-ascii?Q?GOHIROREzyGpJ9N9uwC443LHuxWmNEBXJT3hiee2Zao4ulZn9givo/WRA8GU?=
 =?us-ascii?Q?NWy8mrHC/iUp8dabsR7avGAw2ZdA+wniujtZZW6bJDVvDun9dvEO0jPGwgMr?=
 =?us-ascii?Q?nCNqAlhlH8k2IaOtSW7IZHAMBFe6dOYxJrrjwhbddEVL4GlqDSFhSw1Esoq6?=
 =?us-ascii?Q?fVXQYYjoUSRUz6jSOu+yrMaW5OELQmuvpH8Pq4p08nH0L5hZlPAgqvZXxW+0?=
 =?us-ascii?Q?bMJaqWUsX6oBmRizKFFWq0XDFae9ILox6+/TQlHhagj5JIEI85UY4W9ydUb8?=
 =?us-ascii?Q?tGXIcKAsYNCm1bUgF9HFIoNGe5t73Pp6wkkdZIesBjgsbujIjG4q1rb8k/Am?=
 =?us-ascii?Q?anxbTHudcP2Q20I8ncHFaHi2aWzUfSqTkGk0ZGM1HBMhJTxTwNvNEypVZnUe?=
 =?us-ascii?Q?/L38J4Jy8NPgYAiLN/Wiekh1kg8TH2xBbCM9Yi+iz+scTZWjOVUKGTSx+HyZ?=
 =?us-ascii?Q?4pbOr6v2IKDgMsjouwbjcPZ02R+sx8/EharrCA2vU4rXjuZ4xdbaXTg9olKD?=
 =?us-ascii?Q?HwF9jOSTXmB141B2CMCrzpnuWG4ZPXV7/7DM4YlLIij9TAG2bRaL/8RweTky?=
 =?us-ascii?Q?RpO6d5epb5DcwXiriey9EgJS3XFqHCL4GZUz8EcXf0cutkydDK/1XeijIOmp?=
 =?us-ascii?Q?1JvSRFWCT1x+zwV0BeIR9vlkQAeMiUmH+XZiaaj2nyxnsAFxVq20wdEmFbK5?=
 =?us-ascii?Q?TqSQvnhHs50oIqudQ7EzL6sA1JHPZoY/CBaQ2Bc6lNosPvpYfQ7OmK3uJ3Fy?=
 =?us-ascii?Q?NpuvhvwNCdCXHtGNipuJjxzs4MXxx/IeRbu5H426FI5qpuwCzdhD/MZnw3kB?=
 =?us-ascii?Q?Emr6lfJPJkS7BMkpkSNG15e8LUPSdY42p59b5YMR+tSIJFqM0IABbslJUS/T?=
 =?us-ascii?Q?JRpMExXEYAJNaXxvHn9yoKgKbbni4NTF8GqgxQ6VKg0sbrJBCJLXmHh/yS3l?=
 =?us-ascii?Q?Ykl+mjsHKFcPe9mQ+xWZ9qRRMpGypWnsAhuBkjCc8ZoiXvNa/ClfvX0Ezv/K?=
 =?us-ascii?Q?WFlkopTjalqWcPKCSSrAbPYN7PE6bXhhV5hPbtJ0jVzG+tuT0LagT/Vq4UqS?=
 =?us-ascii?Q?sJRINPs6zH1ZefMk2ewjLCwXOAsl/bBgVwQNRiCGz28uQ+ZYQRk/F/+uhTuT?=
 =?us-ascii?Q?Ag=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tDgsUB+yF+NqhwfRIS4+czNl2Y+QeLyfflp3wkk7Tck64M9iu3dJQt2mmFVp6DTRPAOIrHhDImHAwUJCr5ewa6fAu1buA3hS1RqIeHmpyDLaFjdbZ7xQPwGauzdGbm5Hskea1IjWY5t/2pDdBAPgQ2ymntsg2z4P12WiaI9qg8Vecs8D2ZVEIbjhn8fxiolykHJrC8lcT/sjt2PlT4L5hLfvWo2r19W4KKJc37GcqL8uHDUGMN34mE0oS3QazYxizeoAp9Ub3NaUT1zF8HauzRsAxCMr6iGBtREzKPnTVqKqH3tqPGlFArR2OkU3Sl2RskH6RjfMZvJQJPj64OFbAJktoCblqA9Caljwo2sXJ2hTf1E/pQ1g619TbWMIZpat1EboFtx+R0Zurx+d7fMTXLpl1ER483LQ/QXNO3jhPMJvCOtTbfHIXGB+mmgTT8XwQijGvWRj2KFoaUcg4zHDh0pMPJKqHSj4E5RgHJBekuHtx66PQ8xjcXKdVrgLKjhs4LhHGT3mi32KMmAeumBirS+zzDFhwCSHIR0FnKdhVDkMWv3ZxBzD4tXyUjnqTyWffk821IVvpMPqNHbdy6K87T7egzqbR9yr6NmAsB1yDu8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b4ca1bc-9524-4234-8f4b-08dceecec05a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 17:11:34.0125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0PHjmjV6n3qH4o2+xhHrk4MS5+mBoZ1unUNGWX9zmGuDiovvwYsZXpnmdKWtwzLgFHcbRXSf+2xbN07hDE0fGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7514
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_19,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170117
X-Proofpoint-GUID: IosBhPmE9X52UA7PV3734hE-lWPjcBTT
X-Proofpoint-ORIG-GUID: IosBhPmE9X52UA7PV3734hE-lWPjcBTT

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [241017 12:56]:
> The phys_addr_t size is predicated on whether CONFIG_PHYS_ADDR_T_64BIT is
> set or not.
> 
> In the VMA tests, virt_to_phys() from tools/include/linux casts a volatile
> void * pointer to phys_addr_t, if CONFIG_PHYS_ADDR_T_64BIT is not set, this
> will be 32-bit and trigger a warning.
> 
> Obviously this might also lead to truncation, which we would rather avoid.
> 
> Fix this by adjusting the generation of generated/bit-length.h to generate
> a CONFIG_PHYS_ADDR_T{bits}BIT define.
> 
> This does result in the generation of the useless CONFIG_PHYS_ADDR_T_32BIT
> define for 32-bit systems, but this should have no effect, and makes
> implementation of this easier.
> 
> This resolves the issue and the warning.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Thanks, I just saw this, but your change fixes the vma test code for me.

Tested-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

(both tags since I don't see the double tag in the submitting-patches
doc)

> ---
>  tools/testing/shared/shared.mk | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/shared/shared.mk b/tools/testing/shared/shared.mk
> index a6bc51d0b0bf..b37362224a73 100644
> --- a/tools/testing/shared/shared.mk
> +++ b/tools/testing/shared/shared.mk
> @@ -69,6 +69,7 @@ generated/bit-length.h: FORCE
>  	@if ! grep -qws CONFIG_$(LONG_BIT)BIT generated/bit-length.h; then   \
>  		echo "Generating $@";                                        \
>  		echo "#define CONFIG_$(LONG_BIT)BIT 1" > $@;                 \
> +		echo "#define CONFIG_PHYS_ADDR_T_$(LONG_BIT)BIT 1" > $@;     \
>  	fi
>  
>  FORCE: ;
> -- 
> 2.46.2
> 

