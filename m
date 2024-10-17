Return-Path: <linux-kernel+bounces-369974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 519519A2519
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12AF8287480
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 14:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AC81DE4D8;
	Thu, 17 Oct 2024 14:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CPTQCCjn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ut6uA1cE"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A191DED73
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 14:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729175533; cv=fail; b=B0iIZqecMzufNrUHnRGzxst6JUzDBI3cZVvFN7Z55+5EH93oEmFdcy0Pe7ObYjG12HzlpN/7qXPSvZv/tonBLPlg9/r8Tv655F6k3kkvjiV9QHg3lAtIY6htjn+1RgrytFRdh2qfoRfi8zAzZ3UGYTMSuGnzPIRNnCBC+oMqLZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729175533; c=relaxed/simple;
	bh=AsVJiqKXa927ZW2CpngTTjKX+8I9k62IX0PxIBSowQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ux+Nz8AXbldKFAGY+eYZTApZrgN5xTogD5x4a8YhjxEXD5hRb5KItHGQKrzaaxzzHHpNeMw6FYd93RMbLgaJhWHC84QlnFzjG7N5pdefVh7c3DGVWKfAQwTIDbrgcNTEa/xq9fRDnE9fR/udGxfWPKAzgSmWTcf+280OBop3PNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CPTQCCjn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ut6uA1cE; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HEBh6H024154;
	Thu, 17 Oct 2024 14:32:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=1Zdr+8oUZdKWzec5VqzUsqQsiYTNGhLqf5HOxhs17XU=; b=
	CPTQCCjna0ru/lsgCMOsHe3nVwk/2K71AiVMEAOmxzRUfFw1yJsRc9dfMdGqLM8D
	4DtLMmZT+8zwxrI7DMyKc79dNoSJk+Xn/C6ZDFdBDmgnImRqAe+f/6WJnX+l0BNI
	yJhBtsqJJ3sEBQMxAd382aSj1scNAeCjbPH4XZDwUFOda6cHUK5Lu8u/bbx0O+o5
	vh3iIBO3byDcOvHFFzXmOeApWM1Vhjnbby/QaJdwc+fuUCtO4EW6IdfLjfqcrv/s
	91ztWFIAvUxqzNT7Mox+ZwKXQg7424u7rJf5SVa9Ev0nUQBklOBvBnTxbkLquo7N
	9PFDRQnU8gcK1L7i8nYMHw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h09p17r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 14:32:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49HDC80A026424;
	Thu, 17 Oct 2024 14:32:00 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2042.outbound.protection.outlook.com [104.47.57.42])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fjaak4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 14:31:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rnWgNMEgcWwWwIj1LbHZS5q1CcvKwSgrDsF2EnrR/K1epZRlm1m9UFcQ0Lsv4/KKlHJ70WDnv6Wvm2wdAZgco9vxc9VS9qCy7gpe9foHcM59HIalibkaiMaFYrb2zmm3Ssm/NUPZsDowis9G5ffD7Y9OPxMINumkuRTzykH4hK9xUmUEACt2CIUTEkrnF1WiSJOAH0yXoFR6agytCOSVX8W2fY8SRFki8GZ4j/SA814d7wA9QxPn3G6+CsX7bvVyQTLdr8z0fGNBHhjXJFJVpUrYSIXIAlfCSM0U556+Zg4hNvgDGYihZWA3wjb7mJUc2mDVYk/lne1vyMm8O7nccg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Zdr+8oUZdKWzec5VqzUsqQsiYTNGhLqf5HOxhs17XU=;
 b=aXB1fA4NRmJur7793LBduUuNpNGB/cKM25eNy0CtPmZaRGO232a6a2TWmV+1q7UX8g6ySTuH/sAJRuZa7gl4iJwnFi8Xw6lLGPXTK7EzvqLiRuhcT8nupDkhuOLhVKVos3nSBlwYqv7sxfzzVAYPn1aU8N7hQQGrn69sliRBfn+uRGnB3G7mCvBPsAGtQDOtf8x8G866m5Xu7Od0LOjfEojNaKwAii1mMcU/D9u31dI0BqQ1ykzD9tDyQywvwh3UirnWF+CDySFJAMaPfLotgWbNjvGsZPDw8cgDd2aMvw/hljtakOlAhLyk8OFj9yvF+dT5vFDfPmmGazUsR1/dIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Zdr+8oUZdKWzec5VqzUsqQsiYTNGhLqf5HOxhs17XU=;
 b=ut6uA1cE8k5JRsUy0ig406MR7jDxemafnOwjsgYuTNJsQ6g9r5OPY337eM+hn2W08GHjRa/ECo02GjYTsZX2SFIuUgkyJn2wObg8R2jOXEUyB3IbK7zxtX/m3xYWlk744OWarX4mCBsj8ighnSN+1KTDkwi57H/+pdzSDHMlQ1w=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by PH7PR10MB7056.namprd10.prod.outlook.com (2603:10b6:510:275::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 14:31:57 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 14:31:57 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Oliver Sang <oliver.sang@intel.com>
Subject: [PATCH hotfix 6.12 2/2] tools: testing: add expand-only mode VMA test
Date: Thu, 17 Oct 2024 15:31:46 +0100
Message-ID: <d2f88330254a6448092412bf7dfe077a579ab0dc.1729174352.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1729174352.git.lorenzo.stoakes@oracle.com>
References: <cover.1729174352.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0083.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::16) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|PH7PR10MB7056:EE_
X-MS-Office365-Filtering-Correlation-Id: a4783e4a-2511-4a15-7fcc-08dceeb8744a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VuGIrwMFQUQcku2ya0O7EHgiSBgfCudlJ1X/xUc/bLFDwyj6xFjlIbAuBaMe?=
 =?us-ascii?Q?SP4zqxUPvz0NREiBVaYY/ZvHsqLB+YX3WTwukBvwwj9ZUV3uHyfL9CsLy1ao?=
 =?us-ascii?Q?KGxN/lwGESSkJHtoSiWxM4j9bWqvLpmLrP/UWnQ6sXes9N03i9A0CmOft3EH?=
 =?us-ascii?Q?Y33Rwv4by4Vov4Uc1LRtKfZjYncC5So1aIGNlD65VdFehksVlLORmcGGu2mk?=
 =?us-ascii?Q?gAbtjNWZXgW44/O3WbnDen0z1hnW4AdHTVddJpzqBS35Hv97KREe7h3+OeE5?=
 =?us-ascii?Q?bC9bEkhZWMGr5NyKFAVrSv4hvz9tTVlp+pLhCtZC3a8MtbCaAmDjzf0kAQ5V?=
 =?us-ascii?Q?lbg0UwRz+OatOWY+oVt346ogKeyr+UImCUZhnyLEppCU9WmwwDqzuJIOXw4R?=
 =?us-ascii?Q?hqU4kQQapQ8zBJQpUYX4JMU7sv0MC1cZs+A5SOEXeevm0m/s6qLTW4XormXT?=
 =?us-ascii?Q?P08T5lFN5mLQgvY1uX7PwE25IFqtBbv36ByJoanF35BCl58h5TKyXk/VEhmm?=
 =?us-ascii?Q?ZfAn1LrHsv6Q4fe7TGo9ELGNv7dZ/6x0tRVjQOadR9+VvgbzO3f9Vd626n71?=
 =?us-ascii?Q?p5+AIoRPIRlFuWKbmyFxhNpBZvg7ECbnzQB/PJXS962meXfw7TpLUOqwCvkN?=
 =?us-ascii?Q?nKnnz6muD9Rb7n0AaxOkryi+n47fOe45fHQfrvEWsN6/BsKT//Y2aRbTgxCS?=
 =?us-ascii?Q?5Ld9hcdB1PL6KdSqmuX8aqw6PR6ByWJb240FfD/yh+GUnm4ULkeLK7ZvFsts?=
 =?us-ascii?Q?FWyZnCzwE1ylJLvrBWhgAl7BDIcaWwqRBlyTGt7DRxiJyKxpnfdSCd9Ic7Mu?=
 =?us-ascii?Q?PyLCvTs6d8QmIPTMbg64UxB0DawvZfHvvJ5Ad6C4wmqNnCAU9JTgvsqg/dDK?=
 =?us-ascii?Q?7pLswOs3YLIcNGKK//CXNs/cvxYKAfXswGcXCbVqdhM+ji5rF+XOtcf8CU8m?=
 =?us-ascii?Q?TwA9h+IrQKVJgc5YBY7YvPO1IudmvcWFHIDarOc+ztNO1Kg/GTyJ5acRBU8C?=
 =?us-ascii?Q?wXUnbJWN/i38lyw7nqXJYfc/JNnYyZh8YE806PyQeaa+BoyIjM3tTNPAFY9f?=
 =?us-ascii?Q?V4uePcrua3JV/JWR8Rh8Uj9LZ1fINPfzBIwVQpXfvRzxBxXkrZHVs/gdsrp/?=
 =?us-ascii?Q?M5VEVJEDc2rYPyUzosslueJ8L5n3kb+AAuvgP1OCt1eE7TbOdxnu9l/w5cJt?=
 =?us-ascii?Q?Kpd4kaqaoIIf+UxRpzoZHOgLVoTgOkAVjDJJDvetw/vgtq1s0l/KXgfGYDMS?=
 =?us-ascii?Q?ZJVHEtvDg2S+PeoGTCmDKNPA2V1aPcnrE4rJGT2gWmk9OMZKZWKSXZ4gJ+Yz?=
 =?us-ascii?Q?u3O0xgJx5ArY92qkZLcBshfT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sWpUY9gxSdR61BK5krgeJceGteiFiF+/JlFYXYb+M7XaH8B7rkcu1ATSmqAS?=
 =?us-ascii?Q?gkbzuhgp6ktytZB6TadjD+plBGZEovyfg9XC+HtQOlh2+1c16GoNyM/L7cjF?=
 =?us-ascii?Q?oLtMRHSzUA/nDFe5U6V9+QgoW7x39pIyoSZtL5krWc8iriqTEKHF5X8dwCh9?=
 =?us-ascii?Q?I4m27UJnZBXqvg4BnV2u93AtM5I+tQsEIGh5OhdKm8Y4MdTQWAlu4EQJX6wS?=
 =?us-ascii?Q?nt0c3FtrCMkdWtrulOcSQkeiLycomUl9E80FBb//F4SSxn500NyxHJAudgcQ?=
 =?us-ascii?Q?dCB4nYn1BPjx5m5+0ku/zzBS/qpzY5PbfKF5gGhDIG0sScdpdK8z/t5fbg3T?=
 =?us-ascii?Q?698rxdK6d5yuAGZPe7pgfSK0YFMgPetBL4ZAvrefkBD658ie1vd3lE/kNwPL?=
 =?us-ascii?Q?K3FtSqIPf3bwpkHsmlnv+9h4lVsz9moqFedhAcaDoKZ8xefLLdrFW8ZfFqZZ?=
 =?us-ascii?Q?p4Jj96O7UD4mafV5s28FmAWkSuNgKoLPHJKXEHEOHrEtNnnWbfkhyzNiSWJr?=
 =?us-ascii?Q?ZR5N83crpNmQbCCR5R9AuLAqi340iZlkCKn3E4o9Ay8wrLFCCLMCD2jmquAy?=
 =?us-ascii?Q?Z02Sh/yk6f14wWzn8HMRehJjzCJ4McyV1kzYW4zMO9KbdRjfu3HeY8ydZ/we?=
 =?us-ascii?Q?4aCF7WodEHG/1xXfZF5zZFcLjZkPpQO/8VliUq99PrdC2YHdAz2b06yYMzwb?=
 =?us-ascii?Q?Lgkxa5DyI+sGUy+YdeyXLlpLuMoTkOd5wIoR3xjoYWs9CGv0jLqYcD5kVv5V?=
 =?us-ascii?Q?GUmdh+vI7/YrFMfYokH5tcBWFLMQpbtIHPdOakOSO/wZ19Eqrnwk6amyc92O?=
 =?us-ascii?Q?AU1mKzIMZG1ZAzmRsVwFAMS3nk7FohYnm/ToJCLIKPdNTbGrgm1WiLNcDDgk?=
 =?us-ascii?Q?u/Bl7lFD65vguo/U9PWr7phDG0ksxn81v6lkYQL1M/ksU74rKlDHZkmWkbtK?=
 =?us-ascii?Q?YlhhUXuFhOkTVVf6OEpzsQ/XsCy2S0zXM5BZE1Ly8fTiBZZ29M0GAJywXoHA?=
 =?us-ascii?Q?0Y0VKzMP599oX0IxjAqLX4Y0Vd+13R0S2yXUz14hfORqoHAN3ZgnUhCzZYH0?=
 =?us-ascii?Q?p7XPCOKG7UsuGd/B9ApkZ3RWhpGvfx4ErHfvLK5wws4EwF9OnDB4sABwP8ak?=
 =?us-ascii?Q?eUstIfneNxTFkeAuXJe2ZTlObHYIs5eywMSUsUHb/M4n5PNY0MdBpCvrVJik?=
 =?us-ascii?Q?BIL0V0BH8ux+jkqw9qdp3zoxeEJX5xWRVVCubHhqxf8uNrKYUs1mSkEt9HuC?=
 =?us-ascii?Q?wRTszWzIf/FZTxks5/QMY70UjgtDuZL6r2A/i7VWfdKM/QGRJVUwhKG7XjHL?=
 =?us-ascii?Q?p0ePvpcTWjFeQwSssvHwbTuyAwcgFdBsh2YykYZB1QL1UR4hMTGcmZXBkGKy?=
 =?us-ascii?Q?8sqMZWj8nITdlPLa+uwkc8Y5KlFrS7JA8WubQdIFUgI/1yf7/LZgJy2KNdXS?=
 =?us-ascii?Q?F+RCQpq0vaG4uAvqFQQLL83K+fG89Z4bDGs1t04iwDgOn3K64JhEnB7GFNZh?=
 =?us-ascii?Q?v4gxfsfKRI2ay9WEqT30tPf1esmCMAQ8QWH9HFoWcU6S720kP5DhAdet1sFq?=
 =?us-ascii?Q?tH/PSncjmqAg6ie1WfSqEq5mpCB7A+Q+OAe7rmgKy53jGmIgpWOBIRWTTKFZ?=
 =?us-ascii?Q?Ag=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RbpD4/fxSipLq1KQ24bTHV4ghfBoYy8YN6gKWExcv1WaHDxCng+cyIaVe11TAiaoRS2mePmK8GFCL3H09jmphJfsaq8DpG2Xh4+ba29CO8XoZ+hQq7mxeCTiJTF/nJzjp0LdMzQa+FULXRTltnhA2pPXkbP6WKIxkmkEKi/8g+tco8rlBgU2DHOquZqGE3SOUC4RfaO0YvWBAQ7TkYKiKLp0mFaM/OZMzwJxuVfy0QTDTj1/7pTHJBvBVt+rS15NreVt6vwN43Dh3zMqybwMLqpC5cBa+rIctsfK1A/8zxu2jNSbCgAW3N+yeQN+OKU3bjdWl1a1+vpzndp9JFtpKDn+HEerlFHQOjx+TfIMoUxCt2RhTPzkPv7ivJOS2S6KZSnBebQYCgIqNlfq4sWbkVymagcKIICrNAv9j+CQ7QuXapHFMc/GURTzS0SxBGRJL9osqWyxsmZ/xFwGEjBiEh/+PTSWuVLEdCAO2FqNtSnMkXX3Ssc/eJWQAUDtLBqvwJdGb0SSPWcJUdLWwyA6W5qpBQA3sgqRZ78BsCp9sRtZal+Z4FqfYYB+vmhiZZ8yrgeU4ct+7C2UeyzH2VyE/W9e5tXtk8UU4Faz+6aYzes=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4783e4a-2511-4a15-7fcc-08dceeb8744a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 14:31:57.3108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vTeSJWU0E3a1geTU4XB2Sel1WMXcSd3sAnI430SXJMS2anauX6E5LLQyfvswIJijk15sb2quEfTc0EGZbyxXVQoK8JNxu2Uu5lclr4yzW4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7056
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_16,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170100
X-Proofpoint-GUID: tnx4CgAlnBt9qGqGDsV3X5XbYG082ZcW
X-Proofpoint-ORIG-GUID: tnx4CgAlnBt9qGqGDsV3X5XbYG082ZcW

Add a test to assert that VMG_FLAG_JUST_EXPAND functions as expected - that
is, when the VMA iterator is positioned at the previous VMA and no VMAs
proceed it, we observe an expansion with all state as expected.

Explicitly place a prior VMA that would otherwise fail this test if the
mode were not enabled (as it would traverse to the previous-previous VMA).

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/vma/vma.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
index c53f220eb6cc..b33b47342d41 100644
--- a/tools/testing/vma/vma.c
+++ b/tools/testing/vma/vma.c
@@ -1522,6 +1522,45 @@ static bool test_copy_vma(void)
 	return true;
 }

+static bool test_expand_only_mode(void)
+{
+	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
+	struct mm_struct mm = {};
+	VMA_ITERATOR(vmi, &mm, 0);
+	struct vm_area_struct *vma_prev, *vma;
+	VMG_STATE(vmg, &mm, &vmi, 0x5000, 0x9000, flags, 5);
+
+	/*
+	 * Place a VMA prior to the one we're expanding so we assert that we do
+	 * not erroneously try to traverse to the previous VMA even though we
+	 * have, through the use of VMG_FLAG_JUST_EXPAND, indicated we do not
+	 * need to do so.
+	 */
+	alloc_and_link_vma(&mm, 0, 0x2000, 0, flags);
+
+	/*
+	 * We will be positioned at the prev VMA, but looking to expand to
+	 * 0x9000.
+	 */
+	vma_iter_set(&vmi, 0x3000);
+	vma_prev = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, flags);
+	vmg.prev = vma_prev;
+	vmg.merge_flags = VMG_FLAG_JUST_EXPAND;
+
+	vma = vma_merge_new_range(&vmg);
+	ASSERT_NE(vma, NULL);
+	ASSERT_EQ(vma, vma_prev);
+	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
+	ASSERT_EQ(vma->vm_start, 0x3000);
+	ASSERT_EQ(vma->vm_end, 0x9000);
+	ASSERT_EQ(vma->vm_pgoff, 3);
+	ASSERT_TRUE(vma_write_started(vma));
+	ASSERT_EQ(vma_iter_addr(&vmi), 0x3000);
+
+	cleanup_mm(&mm, &vmi);
+	return true;
+}
+
 int main(void)
 {
 	int num_tests = 0, num_fail = 0;
@@ -1553,6 +1592,7 @@ int main(void)
 	TEST(vmi_prealloc_fail);
 	TEST(merge_extend);
 	TEST(copy_vma);
+	TEST(expand_only_mode);

 #undef TEST

--
2.46.2

