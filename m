Return-Path: <linux-kernel+bounces-206615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDF5900C12
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 20:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7DB1284E04
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 18:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2895713E41D;
	Fri,  7 Jun 2024 18:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SrZjdlJS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="feqNBvCJ"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6084A13EFE0
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 18:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717786403; cv=fail; b=Y2bqwDQs8IywQ0TH4tKpU3G4n2RFaQnp/XcqCCTIxvQstrrZndx4luENGSoyZZDM/V6+XrJR48A7rHxOdTyY5TMUFGWA99OQ5I+0MQPiFVXGsDd6IQkQKGNC1xosWPoVBm2y/aUE5qGQPwmgkbq+C3cYsB4KS0XK+Y1Tm9j37cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717786403; c=relaxed/simple;
	bh=W4W4OB2htE50fVmGDGbCW5xtZ3NaCK/dngSRSfiAB00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PpYhzaUcgohFuxKyNnGA4Iyb7ix5d/J9wMkOp1hDGzxT4a4X9uyQxn5jwaQVdtGVR5MUeaOdyW+J8czpt+/0uHrNBd0zlZ/tjFItkHqdsMImY8SOrm6r1dreSHOytWX2KsYq6hUYuGEhy3tloVjQmxPHgNAanel7hRBEHUuubaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SrZjdlJS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=feqNBvCJ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 457CuUSj023582;
	Fri, 7 Jun 2024 18:53:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=R5DSk3bdiGslX9Z7wkh3/TmOZQ0ej4zmzvHswv6wkU8=;
 b=SrZjdlJSQi0Or8bhoRBC3BOv+mKPrkFAY2NocLf8u/dww8jAlvLZIAOhW2SBxjEU+62c
 rb+yTnKewUmUS9NApWXkHzYNLUHAoDa+uc9WNOCFEqCH4HFUCGhR+jBkYW305V/iSp/K
 KPpLrrKq/yWgun09pgcTnLK5ZJqSb8mzsomViSB/mmO0iot+vW+lhJtb0tslM3D+adbr
 gwgnU1qxFBAM0NgQ1qVAJ08HZY4nkuUaAl2NIM9mrG1oP6yBF++lw9E68diftVxGzz0i
 S22mpAQFB4cTFxyCEb9vdeIm5Stj7z6oInJK1WcH0/3PBrFFBVjAGy1MkXRkyeqFL2fr 1A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbrse5ja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 18:53:10 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 457Ik5lj020634;
	Fri, 7 Jun 2024 18:53:10 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrj6xy8d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 18:53:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=girx4l3d2GFdHMlJTc7Cst6oTS3+8ad5+tmIUhxctlnnSKuL6NngvXUWlDWJMO/LlI524mBYKLTZLU8FF5ND+OnwCXcCwgjJfgTD6RQxq4amojsexa4tlyAuX/inA/cclg8n2mBPoR3Kb75y63OPs6bQKogpoISmx+jG0wF57UoQpDjR/Mj9PKa9pPd243lVLLTuzYUn7VoLOtckH6TvhcwDA4xcZ/HI3MTlWUOGcTpX8oOjIGAUHf1MTMc5415faNwycWskLi1cbH1c+EqpOtHm2c16PI0rbQq9Ep0ob8tzTbt4gzYCkxJ5SnS/tOY8t8QUJq92GoD4vOEGJDhFhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R5DSk3bdiGslX9Z7wkh3/TmOZQ0ej4zmzvHswv6wkU8=;
 b=RHwoM91F5A93wtnWA+ovRRCeIZ9R6FfLZzjn+HQ36nrfxkx+u9qa8jgzeBiDyqtQDGqJN1MAdRJPgN8zl6PpqF6+kkhuG8Lt2oeCqgsOK8e1OD3YrvRFXZfqyy5CHMYrp4QLhvI8bJpqCA7EyKgE/2Y9UGeRKw8+3AEWTtKMOE/pmjSGhT1iHX23kg9lRRY4JOeiUrvfxR/cX7Dpyp8NYuJqaC+5+WDVq9au+lw9kHlRXh0enTK8lhlj4f4X5nbtAZnPJz9zkKmFQ+EH6p47QPGPat57N4M9dXbAsNZW+d9I2V60UUV586oiKfxKtN7P3GAIbE88AaCNIp9VNrCNJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5DSk3bdiGslX9Z7wkh3/TmOZQ0ej4zmzvHswv6wkU8=;
 b=feqNBvCJ6Q+Lppft7sRsNeeIA+AHvBYGIfDlcOVMwYUkoLRMN28yJcCH2Rjd7Oi0lVQfW4CMUzDFd8LWzj02RT4u+P0Z74s0h1u1qGfBJ/EEOpZI73sL1p5m3V7UjjcGAVq0FcXpT5DjX/zlpdBl8muYujvQiFAO7EUB4Os1vxw=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SJ0PR10MB5629.namprd10.prod.outlook.com (2603:10b6:a03:3e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.26; Fri, 7 Jun
 2024 18:53:08 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%7]) with mapi id 15.20.7633.034; Fri, 7 Jun 2024
 18:53:07 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 02/16] maple_tree: introduce mas_wr_prealloc_setup()
Date: Fri,  7 Jun 2024 11:52:43 -0700
Message-ID: <20240607185257.963768-3-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240607185257.963768-1-sidhartha.kumar@oracle.com>
References: <20240607185257.963768-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P223CA0024.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::29) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SJ0PR10MB5629:EE_
X-MS-Office365-Filtering-Correlation-Id: a665820b-41ed-4c94-053d-08dc8723121f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Y36SVGahmumVXVN9w/QrGYrQDQZY66ynzTEN/nwNQzgYb67YQDRi3AeTYUGd?=
 =?us-ascii?Q?hQ3UKRHDEpXfCmwT0CCjsBYkU9OWoWShyVYbAMDV0+3DJ1vRWBhIXxyE7dZL?=
 =?us-ascii?Q?B8pezMkL4DiTFrrcm/zNRk6pS5oc36KseGL3Qfzk0Jvc8LQ3BBD++vfFUkPz?=
 =?us-ascii?Q?rReeAiBfhQjq0URJEvh6HYqCVrjZCNelkfiyERPhqOzszykQ63iUcmjHd5Ot?=
 =?us-ascii?Q?0RDwgcC3Pe27VlNrtVpkiboRPjUbxO1+JnZjzstZc442cW27WLwIETwQi0C0?=
 =?us-ascii?Q?XJ/DZ9KLxaHE8ex0wlDlFv9jcGIUQ5YbfYlUheenPTJSvhEnAyJFQNimFz22?=
 =?us-ascii?Q?MrjPnbuomCCPaAc5fFpjGDKe0fP85IPm3JVgE4T/U3YmOAiocBoTfeXZQWMa?=
 =?us-ascii?Q?wbT25sU745FhMUQ7BW3Z5Uzdq+sCchnG9Fom1POlr2/7BBsx+p5CN1iweAh7?=
 =?us-ascii?Q?5FnGFEaVwOfPASQck1qPhl4lzGBOugZVBsvHVIlzkqixA31SiCd2mpicAKb0?=
 =?us-ascii?Q?hOU/Ju/mqOtS0q7y9vvb6zSNJDfrJIDQd7sL246MG1xmwS0XAihDlO0Y5grr?=
 =?us-ascii?Q?wIh4f5AJPcccEr4L5p37UPZrfjDBXkvDbh3+tqje9ynHGrMVHevlaTm6NZv2?=
 =?us-ascii?Q?pRZ8B8/eW62Yn1T5Gv3nO4GO+kAl4rmqsQ3mAD8yot7QqrT9r5/S7sIduNpw?=
 =?us-ascii?Q?w7igQLwwP9OMWTmpMXHplJ8axe3wXXbzRO8hCcwaB+XPdstQ6wkaZd8j38JQ?=
 =?us-ascii?Q?olI95wqoWuuBAnP6P/2ySxBR0bxiGpxnjbcFs2vkidGbc80shmJ9VLuAadlr?=
 =?us-ascii?Q?iAVAd6LxYip/xbHfdSWPFROY3RWy7AzlIb8KR/omARGA1AGe8mN98TuohgSe?=
 =?us-ascii?Q?7LOVhhoeroR270QTLk1+aWJ9O4L5+CNR+eyYo/asJXihMaFokqjEyqC21quO?=
 =?us-ascii?Q?an24YH/Klaugqo3cSTBHkpmzjU1aHC+r3fKeGQ7wmiTUe0oS35El4mYShnG8?=
 =?us-ascii?Q?bRn9qbgVg6MtWYQYKVz8ix6qDPOXslo8/699EtwPY4QnwYQ77aSZy7EYP/38?=
 =?us-ascii?Q?Ahk3meP1PRRFoMccQdQByVHI18IYBoiuZHPC8wnuTIca4G8aoTkjigxii1cR?=
 =?us-ascii?Q?ASTJ6ydQGI4w6VBdLqFXQ2CsrThH3++705XrCLeDwXdHgo1PUlNZIImWgTJG?=
 =?us-ascii?Q?6wkki/h2MPV4yZXdf3wdQXnPJqQfvA4XBiUGukTecXcAEag9VnJJOsQ1ta88?=
 =?us-ascii?Q?Dqm/emZg5E5uCyhkIF/tb9v/hrhvfTEQA55YfWWsAO6jdZxE2YB5t4MhWH/T?=
 =?us-ascii?Q?rMt7aO+rw6Y2oeh2bWFjQhmj?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?WLtB4uZA2/Wf1iwUa4Y8fZqKKpq88SxbzBrqzRVKHnMAXaX3WTeWP5u1QjaT?=
 =?us-ascii?Q?lkqeC3cbBE9sm09Wq1qJZdbRsivyiWaS4HqfwXfEYj7u1SFtl1xPaDEHMfyl?=
 =?us-ascii?Q?0dCQv+/rSnBUALmT9XmKujzVkSp7YSbw9wgpFYb9l4CGE+o8OJ958zPuLI0D?=
 =?us-ascii?Q?5E41to+ZFILWZUBBptZb87DON2CzVcN3nvE9iqmmJJZdyzgbWCqmVVFXtEWk?=
 =?us-ascii?Q?AZ7MvWTAG+1MWTOUsaTMmxH9f0/yZng4U4SxAcKcjbuENqaWLG2qgtVcMetI?=
 =?us-ascii?Q?LhZgm6JYM6AM3S1YMf0R6FJBXGBDg0Hb5zVoGDLaYJqdIcWM45smrjrRFUwj?=
 =?us-ascii?Q?M5PiMyrkfbalkVJQNCZZJ8Yd4cEGPKtZsdCmay6tlIj6EA70AEMd6AYSAjj8?=
 =?us-ascii?Q?WEamPUOQ03xjU/xOoofpIDtLwR7XzlOaFU1OPKa21RTth2NmlLW5QBzBAHv/?=
 =?us-ascii?Q?lFmFIrQep8aSqCTqm8rHk3PVCjflIEkRQIvt8ATzJF4ShcY/flLkBqDVUZ+q?=
 =?us-ascii?Q?lJqWXf3CyPWcs/uGSIqWvqet+0sFlZn8auBQ1H34asO6uYCC4dUpAU/uqSsG?=
 =?us-ascii?Q?ei2zh4PbcW0hH/ZYhbyKpfnIRVpY/rFQ2b4NS5m3GtOIxWmhGOBECNTj9v6v?=
 =?us-ascii?Q?KbtrXknetsQHO2Kd3S9MtHgX7ztfukvIXzHg20eooyPuV0CMpfM7osYM/PdV?=
 =?us-ascii?Q?kqjK5l56Ja9fEXULTok2arKLTIPTFwoUAn6mt4QA+CbXqt89iEuCpAKGBNqK?=
 =?us-ascii?Q?C05rytv3YMltRP/pNmt8+LMYWMDpf7YOut5L0ZK+119Vq7+SmPBpctAN+F97?=
 =?us-ascii?Q?VrKDtpzy2Tlif3r8/B19j4+WvLOUtxJCnY/N33EZI1cl2x/tFfSZta8d+AeR?=
 =?us-ascii?Q?OEMw2YWa021JKzYXQtXRfuPNtnNqSenwug9ThQwJ4LCm+KCQn6y4fQi0HBYa?=
 =?us-ascii?Q?Xudm622PjcsnIhFKmV8B8TNbeJDMcv0s7yyymGJOhNzgbFw7KkJRDCrbrR28?=
 =?us-ascii?Q?nhYhaUE/CBXP83Wavclyqg2KAewDFoJyGrOcJsT2sy+UVVAuTLtTseYnTXAV?=
 =?us-ascii?Q?9d7kk6zgdpyDGnTjMxriMbABJQ73aTOYQ2BNjhgi6OKDjyWuvqUYVcZ51nHg?=
 =?us-ascii?Q?QMJWNj97/3phN+/jRl+KLjtddWJMllSe1FQKwd/ELft52HLqauiwJaP976cZ?=
 =?us-ascii?Q?v4dcQ0PE/ABYmGeANJ0WKa1gq3vfwlues6zngFO6Poy1Nkj0DEzXxwSc/HWx?=
 =?us-ascii?Q?704z7//2RSCzQSoPOxx+qc+f/JEJLyjSq/qMNwL7zxsN9AYwgDvdtS4N4Qoq?=
 =?us-ascii?Q?M80UbsL4GXVxGuINaeFAaThhmF7peWJmRa24mBxi/8ge0LQO0Hk2m5N/2aqu?=
 =?us-ascii?Q?gd39jbO0Sh3RtdH5yZkj+IcrODYURzRrpTJC34V4PnsPUBv/WX5ssrjtJrZO?=
 =?us-ascii?Q?5JTJQyagNUhjHkJIadLMFfDGTxmrmHZpfufYE1d1fi8Nk81d4Cf8QIgEbGSL?=
 =?us-ascii?Q?gAGnIAk/p8OlhcdKUeYK1OcXBt4tHqX27KigMhQlXl1G6488AL/711G3EFvg?=
 =?us-ascii?Q?jyo89ST+yYnofHPnJc8HkBQhQarsni3DI9l9CVifcNfeuxrQOPyy9GWQH80m?=
 =?us-ascii?Q?2h4ehKdtJyTLyFIXp9+gWZ4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ClmEHYhk3Qk6clmAs/K0nudBEz4vpjGzL3rgF7VJYDR7+zMlYy0ZsVRcUDJAZ6WgXmX58gLeOPOlekxhPcoptIdSbO1tNtjh+Xp0N6Y2aXQSPC/FgAtDZCo8YhRMct+Gv490tmOPz61aw72GEJEPxGtKlIZY60Yatjse8A4kJ/ZRF9fzEsaNgGFWz/qqYKooeeARm7Nvr2N7WfMnp5ktlV51tTETPBLOjgrOrlsyPyGE0qmskUsQqBaztJif87yE0KR4kl5+Axi2aIIALIkNv1Ic/ml3MrOwLp5E1Sde2OSg4sFBITPSjgA/HLzA04KugmRf3VIJ9NRvTVGRKRozkjMsJefOKrs3g1CV1SrO6HqdbseDLf46uqfYzVUIh7FeotncGppIHpPg1JYULkAj2To5uVZvsye9+Pj3p+yU7FBx59wWVsnJn4lvt6J72Xhe0xXW9qAQ7WwwzGC+GdlDRpXIGZLPXxVAzVVRVdZm2cyg6dyd3S9Z4Bx7F3ItwayMniyL1bEnGclVYZLYVF8v1uS7OstAFdQ6qXML+AxK4YBRup2t5rFGyEjcomK7Sw8IfyuvMgEwBYeaMEA5zhLE1ynByEOBgA9HkOqZMfrWJO0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a665820b-41ed-4c94-053d-08dc8723121f
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 18:53:07.8644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LGwA4+zctvNE3gUkzfdRbamTI1FL+rDRDbdeG32WcTOHE64lLB44aRnAJzuMCAYBy9MfFiwJY1KrGvVxiskeGSTsfDMgiMivo99S+Brg77o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5629
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_11,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406070137
X-Proofpoint-ORIG-GUID: y0HlS3sp1E0qKoPNvEr7C4JUB0XeEYbi
X-Proofpoint-GUID: y0HlS3sp1E0qKoPNvEr7C4JUB0XeEYbi

Introduce a helper function, mas_wr_prealoc_setup(), that will set up a
maple write state in order to start a walk of a maple tree.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 2d7d27e6ae3c..ccbec0f66562 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5402,6 +5402,13 @@ static void mas_wr_store_setup(struct ma_wr_state *wr_mas)
 	mas_reset(wr_mas->mas);
 }
 
+static inline void mas_wr_prealloc_setup(struct ma_wr_state *wr_mas)
+{
+	struct ma_state *mas = wr_mas->mas;
+
+	mas_wr_store_setup(wr_mas);
+	wr_mas->content = mas_start(mas);
+}
 /* Interface */
 
 /**
@@ -5507,8 +5514,7 @@ int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
 	if (unlikely(!mas->index && mas->last == ULONG_MAX))
 		goto ask_now;
 
-	mas_wr_store_setup(&wr_mas);
-	wr_mas.content = mas_start(mas);
+	mas_wr_prealloc_setup(&wr_mas);
 	/* Root expand */
 	if (unlikely(mas_is_none(mas) || mas_is_ptr(mas)))
 		goto ask_now;
-- 
2.45.2


