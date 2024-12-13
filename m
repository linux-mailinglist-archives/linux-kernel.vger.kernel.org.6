Return-Path: <linux-kernel+bounces-445098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2939F1137
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FB17164108
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667B91E32B6;
	Fri, 13 Dec 2024 15:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RBNOiR4o";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KYwM//Pc"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5101E2306
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 15:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734104672; cv=fail; b=rJU1B9nC65OvMWDlNXtEFeNJ7TuLFRBgFIQ8w/LdXqHdPPASinlI71aEUhcwj4CBpL5l+degYHnmFhifOaIex3zL7YRbs9b2ohRzPlP+NUIXQUHle/ASdyXKWWOlfDvXABRpYviDXpDEh2n+sBJ9oETd3NNc+lmRJcGeA3eJMO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734104672; c=relaxed/simple;
	bh=6dK5lenZcbZzTPpIUlu4SrV9MrJ43lrtMlpZx3veuh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NwroHHSYYp5l8QvtpQIE5AS73l+uV4C+Klmo7mXE513EXgktazxgJqHJJwqnuaqkkSCCUKzP2ihIvTSJ4/ag86KxnKddLzsMA8SCL4fod7/Hyi0vt+9IdJ6+NYXPB3b3clzLJ9GeozBzXkMvantdYDJTDaX818ecUg0B3eVsgwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RBNOiR4o; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KYwM//Pc; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDDkAVw004535;
	Fri, 13 Dec 2024 15:44:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=WCzGMyIwA4DRjsMpQo
	xibaMp4vmYK8dmBsQ2Ip8JrAk=; b=RBNOiR4ot6cg37yrhzIGZknP4AVcCUEud8
	zGCWf9tcKxuD2yds3oRu26SL0O5rYKDzX2Zkht3E/fwYrBSj7P+olb71J28uuk6o
	HTZL53zb/PtimJ64tiPmlSziQrKdegzcjs7AZqYNlN6wFNRN6xyZWk8528tyPzvH
	wQspAuvsK+l/fn4Z5rRnifM7Rz8Nh9D5SCKo9arzqT28f+eVLsnO4A6mdivK6tDo
	oZDe0bL7JbymQAiopNAokRyp07CcaYtutRd0eiAMancWsNPNwBU8PGCUH+9ppeTW
	FURaxxToZEnityO+xhTZwEmRt3rxPyhoRoVzAQUda57Pq8JgOJtA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cdyt5jts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 15:44:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDEfVMR034971;
	Fri, 13 Dec 2024 15:44:20 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43cctm4wpx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 15:44:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TWZ90/4qcoD1NsIfalO8E/xBW0W59vBrJXda9YhUgs7gh8vb6+aTw/mX90S8itjhq3CHTLXp7V+OEgHgFZj5g1ktcRNbNS4YkoftAwJdbvDqZhYmV5PNBq7WFB4uOpnl84/6O2PisGPUsARCcRJ3lrlY2BiubPjKPs+z5/UQKzCm6L+U2K6fUBW+uSbWEYR9bA6Ar+MHmmj9Lkwm4rZm9HBUPjCpfropvd8hGPc0MUL9zRhlGPG8eHagsp6+T4AJEatrRjCq+rzaWMrjsq/ok9/tkUaJN4LOaTCGiZoP/QpexK8rwxBz15OhFYndiWo3DxjofPBRjmqYhoGKN0YQRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WCzGMyIwA4DRjsMpQoxibaMp4vmYK8dmBsQ2Ip8JrAk=;
 b=GlDuXc3P1WzfFuKP2YoyUkicEYWcwME8u1xj6abtjyP4dFt51Li1jXoRrKlmLz2vkplRzHcyU/Am4zUjN/hxdUrMltgzUwjgyo7EtWMy5g7huuUalwvOrgY62nNiyt3BJAmmc7Bk3ZacDZMkEpAfG10jWmdzK+C+UzSi5/6xkN/9lPN75fs4cQsJRI0/oe/pSn3cDRYua8VUMsPhDFLiC1MynBs9tBrDTBzbbWfp95SwH546QnsstWWjUBs4Ldoqvhy0jN/NVkhdxc4jzUswyCWkb8hiGKLkCLWOI+JNS+ktF2jkzqJlJ460xk1bYeLpvmUmV9TV3zI5x2Cxx5Pqdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCzGMyIwA4DRjsMpQoxibaMp4vmYK8dmBsQ2Ip8JrAk=;
 b=KYwM//PcUz6QIUm1GnSqkU9tAm7uV+LBE6QkzKohX7pXgjA8a8YPO0RcBK2s8y20d7s4WfvuB/XWcHg6WAGXtBU8ssNkpUN0QizPJTxU+xDKCKqD1ZotHdDsDZA5CGq/67WJ/ssNp5GzJSb9Mhw7zSekEi5rTROl5ihb2sk/wMY=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by DS0PR10MB8199.namprd10.prod.outlook.com (2603:10b6:8:1fe::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Fri, 13 Dec
 2024 15:44:17 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 15:44:17 +0000
Date: Fri, 13 Dec 2024 10:44:15 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: zhouzihan30 <15645113830zzh@gmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, zhouzihan30 <zhouzihan30@jd.com>,
        yaowenchao1 <yaowenchao@jd.com>
Subject: Re: [PATCH V1] mm: fix bug in some memory information update
Message-ID: <edigemkxkze3iicku3orrufdadevca33ndqxw2etqvustykpv6@smaext2j3bzp>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	zhouzihan30 <15645113830zzh@gmail.com>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, zhouzihan30 <zhouzihan30@jd.com>, 
	yaowenchao1 <yaowenchao@jd.com>
References: <20241213081618.53458-1-zhouzihan30@jd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213081618.53458-1-zhouzihan30@jd.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT3PR01CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::12) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|DS0PR10MB8199:EE_
X-MS-Office365-Filtering-Correlation-Id: bda67d37-d9b9-4c8d-2320-08dd1b8d00f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PqfCxmXV4q/WesKSUW6QVM7YwfyKo+dzmaKBeL/41XYvcN4lVMh9199unEWr?=
 =?us-ascii?Q?25KHs8nfAQ2TH1rw9qUARxB5jDHo3+5/epDx2aWjQr3BhmAtd0/FVTMOQBvK?=
 =?us-ascii?Q?zP9HcIfqgUwFeI8VusVfcOkCJnPTz/lGuIsiPDALJ/lDoAxOxubCSqpQNFES?=
 =?us-ascii?Q?DK0TyR+71QyX9DKOp72DU+/yJpSJ+wOQbCLD7y+leF71k99ibKfP8bDLsqda?=
 =?us-ascii?Q?Thzq67dRpsygEjjdVXSMUNyTBh0UDkMA9XUw7jZZ/zkjE3hy42i7fV4vShx3?=
 =?us-ascii?Q?JGbv6GdB+hjnqa1N7zlY+bU6IdjR7M7oz1yidC0eZPXQFFC8JoudQJwYiLZc?=
 =?us-ascii?Q?h5ybQdzmgtufBMMI/m3EknFHI3WfWtThwxKW0k6O+1HNJHhe225m6dL3qahS?=
 =?us-ascii?Q?UFnBCO6UmJHE+CQIsvBAcoJybb4sWuNDaiEug3LfqMre1jAh1JJkBGlPcygU?=
 =?us-ascii?Q?8RyH7APBpteQ1XIKxhoEtH99iT8E2WD8DilAMcQ0YjCWwDsaHY2oejYGsyDP?=
 =?us-ascii?Q?DAXOF8hFjWaMM2s862UQnKKqlwXm2OKY2w1KHAoBEkV289LUC0hkf3bzruoS?=
 =?us-ascii?Q?DzagveeHteWQsJSg1B2+RdupQ1IwoTXb8M0DJnv1xpc1Ei27VEdXABgpzCIq?=
 =?us-ascii?Q?QlIie/rwN3RSd1YM/k1Zb/cZkuwPvo8eYX0vT42yiiiCvwvXLFT0d92bieZj?=
 =?us-ascii?Q?PrK3TLw7fbrv/B1zTLn8gajMZNkxLOhIEp1r/RJTgR5grIlfPrEcrq6LGv1K?=
 =?us-ascii?Q?64OkFGYL5kg4NKATVQPPMkJ+dbVPepR92rSrYUU8GbofxxnAGanolpuN2P07?=
 =?us-ascii?Q?b6cqYTq6gwEzofRL4yd4aDtxKjGxV8sF7vU71ag16ErohNvCEqVymvt/cjc/?=
 =?us-ascii?Q?ZrkRv20wszvkNFc4EJfVUieaIHpVhU4W2uDRUo26udP4xqZlCbGFxXiPD/Ne?=
 =?us-ascii?Q?gRX1QpVUkkcvl/e3fwqxzSD3/yIFpTD5/PJxBELG4Nh7eH1bkAAi/hXPQIJ/?=
 =?us-ascii?Q?rj2zY8A2lbGo6sMmmRrUGzA8UmeaCb42mTM3YgYfl0vtDJDLBgSNMjpfDWMI?=
 =?us-ascii?Q?4m28qwAVba5UzDNFHs6vDf/a1r0BdswdXX5Gn6k0PUP77GqOgyFpw56KxBYq?=
 =?us-ascii?Q?cum+17CGvGQspCN/+zpn3kHKtQyuWWqnCjIN0tqEOW4yhklZw3Sy0YM3VKnd?=
 =?us-ascii?Q?eZeWtBn3hipsooYE64q03TClLp5WimdS+hw1x4eYVSqJB5mlxq5OLElnkgAJ?=
 =?us-ascii?Q?jwNgH0DbnF2XFAQb+DPk0xKSx6NeMQaHULYAX28cMuJF547BxEJUTmyWnCyx?=
 =?us-ascii?Q?Jkn1Jw1JtSI7iFSLuIgDm+N4agBcn0YuX1ANqIpET6flz5bxPa0uly5MsgV1?=
 =?us-ascii?Q?M7thmv28bsq1tB5LsabeFWUyher9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AOvYqtq825IjvFdQ4+QGdGYOw33BXoNjqIyvPZd5G3MUGDRi7xW7q4/BG9kC?=
 =?us-ascii?Q?CDzyBC/4WvWk6lFdXxHD9fU663dHJLIhMig1f4g4O1ycxMPvg2F9HnEGNMZe?=
 =?us-ascii?Q?iMXcwMxk9xZWK5q5rnrEoVjWYaVXplmxxRUo2OeKMi0693BXR9Kh+vtLjn5M?=
 =?us-ascii?Q?VPHG0tpr1IJEa2wBkQLpG1RxGjNnF0/0+5tviksrLn3wcWoj4052KwJNrIfi?=
 =?us-ascii?Q?oTE0fz1ifULQ1BEsX/1xEZD8IPiMhvYd2qrbxNoKLVbruGTFWcZo6wZ9ruDO?=
 =?us-ascii?Q?Hc33gMPnDC+6btICYr5GHBDcF7kHPVOr0Mr1UwY8UEMJ9SA3l1TROTfFM6Yz?=
 =?us-ascii?Q?hRrdB8JSK8AAwgQjMtvwtnNz/B3DbOOUBQoeqs6NLKaUbXLXRIQAnOiEZqKh?=
 =?us-ascii?Q?2JtE8/6xmCqqUKP/pwkS3JHyT/hj7xYlzywO/ubcwjfQV9XWx+wkPsmIb/HK?=
 =?us-ascii?Q?cmFuifnlG6rCNYNasWlmpUHRLXMPMYQ+WzoUZINCeow/42/gf5thcl1ZNWm3?=
 =?us-ascii?Q?/8wsr+21SLlQ/L3a6e7XGShMfjsEwpYacedHrqTRwgu16ZTnxVvOcvKC+T5/?=
 =?us-ascii?Q?AHoSMvVT78jbmUCoZvEskg2nPJ7x7u6lmaW2DXx6AqFV8D/gUKj2GJ10U+Mj?=
 =?us-ascii?Q?kRKJecFyITk5fC19fTMieSqrlVodasAwL3Uq25GsGyz6Lo2G7L2H3dbiGPsk?=
 =?us-ascii?Q?R+9UN2tjsDWHaFuLDdbnpg+d9AKlMIkFkl5c1C3Nqi0vqdU6IoFEM/246REI?=
 =?us-ascii?Q?+C+Rrm7PXmxVqFvcbLoaSAGMFv7MeH9AwzTzYvF6Fd88SOkNodVi/dT9LuHm?=
 =?us-ascii?Q?fAOvKV2IXqhEw2ajRTjP4fTncRJ0YHSyMGfIds0v8KcbiavKrU4fhHgGjHYv?=
 =?us-ascii?Q?XBjxzqQdqbQvnPUxkAZ8Uit/ysa2pvkkg6gSHrnBG701v37iA9iaY7GQegJZ?=
 =?us-ascii?Q?YCyIp7cAHI3h8RQAzGwKHZVUUbLQPdKeugNTGqAuLiRVpuWPOcNAj39tHaM8?=
 =?us-ascii?Q?OYYtb7cKyGMIvWzHWnhHs2gchxV5zk9LUGl7lmJGiJOdEmP6wypqSMkH6hDG?=
 =?us-ascii?Q?EhgQMpQgPp6Fg5H4HrpGVImfSyaA9r26tMZeoEHX+TDF17EI3Lhne8Sf+5xJ?=
 =?us-ascii?Q?/J9lr6FK3x7O2Eq5fDVl/5vWZ0GOu8nbOHvUd4lhi8EzVjCUDVdoVhjBryE8?=
 =?us-ascii?Q?z1yq5BcGzl2iwemwRoACAy0Cfh+1NyfJQ0sjprNKXn+eDyavsPfTb3xYr3n/?=
 =?us-ascii?Q?VAL5syqF5XH+mmrE6tdi++AJq+yBGnqmACMvJZiERyGPab7Oq1lfjMiLhe5v?=
 =?us-ascii?Q?HysC6n0ZKo4Sy2kybem2x9FrxkGe0GMdH2rKpBzJCnvD+GXihjHs7I25/QdJ?=
 =?us-ascii?Q?mIe8hdqwK+OBzl8j5iAiHoS0OkLJE3V4hcNn1hItVxtRD9MiJ1y5zChbvuVW?=
 =?us-ascii?Q?8rEKATMdRbWPPPtgzlqQEEHMt3rX+7s1caki5IuQk0YZpdv4HkINIClCdaWV?=
 =?us-ascii?Q?+Oc+T8Qp7AJSnpiTsAGooraFpUB7ShGkgdJ1zKjWyYaMSkMDO60dRF9pWso8?=
 =?us-ascii?Q?XFuV94oxzzLmUN+zlokluQIlSY39O0YZvmVYdK19?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mN5T5B39dowVbCWbONGjHLDAsYdQ3dO8/5pMLJacR6QoeUOpl1yJUidla33rK4MXMmLTr8tLSPg9CKdH5IxhHW/SUTL+2Ss4/8me3HV/cyoHcVUSxlI7x5SvVWIws6RHNv6bl0n6lOwAXhYGwVlPOd+YJuE39RVoCkwUEynAilYpMh149LJjzbkj6Gp5m29Z0sjVWzzzqez/JvnbD7jEXmDDO0pXQJsiDiHQbOYO6Y+sdvo5oG9pIqDMbqPndDfFtNw4a4EDNcDNGG0hJw2ypwP7s20b7lQdPta5k5PAFaShuzHLy+uiELDzAke2D+mdYENTfkY8X4EXohPAQY6mabJvD1+/d+IrHbNwanmkDExAtMxjERCKhVCPgvZQTJJjX09hTpNqgo1n2WO3l+fOMVkllfKIr0mLKCUUTQjPz9MZ+Q85cZd0d9nw/KRZFiEMTpVoUmFA2kqWt6j8ngZ1NORbOSsAky/t5Fq5gN4LbsaYEBf9KQ2bZHpPUhUDjmg2WqdxmoyPYtgv0UWL7HAEeP52Tj1RfBFf277NItptbUou5WQsqw3nXm6BAOYSx6hh/sMDGkrs/FkDNoG2GYffvAYBgW1nRKbtL4rCsxcpb8c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bda67d37-d9b9-4c8d-2320-08dd1b8d00f9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 15:44:17.8535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JuYAi4IDxMl6FnAbwJB7wZF6qf7va0oWYuHQ1riL2KcRQoWeTtVr2bVPPlr9PkmC88eM1e75Exqegr1e9pJnTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8199
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-13_06,2024-12-12_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=759 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412130112
X-Proofpoint-ORIG-GUID: _7-MgF5v8H4zJXwZDoPKDTJAToorUDVf
X-Proofpoint-GUID: _7-MgF5v8H4zJXwZDoPKDTJAToorUDVf

* zhouzihan30 <15645113830zzh@gmail.com> [241213 03:17]:

The subject of this patch is really poor.  "some memory information"?

considering the text below is so much more descriptive, could we have a
meaningful subject?  You will not get the proper people looking at this
without a decent subject.  At least make it "mm/page_alloc" ?

> In the kernel, the zone's lowmem_reserve and _watermark, and the global
> variable 'totalreserve_pages' depend on the value of managed_pages,
> but after running adjust_managed_page_count, these values didn't updated,
> which caused some problems.
> 
> For example, in a system with six 1GB large pages, we found that the value
> of protection in zoneinfo (zone->lowmem_reserve), is not right.
> Its value seems calculated from the initial managed_pages,
> but after the managed_pages changed, was not updated. Only after reading
>  the file /proc/sys/vm/lowmem_reserve_ratio, updates happen.
> 
> read file /proc/sys/vm/lowmem_reserve_ratio:
> 
> lowmem_reserve_ratio_sysctl_handler
> ----setup_per_zone_lowmem_reserve
> --------calculate_totalreserve_pages
> 
> protection changed after reading file:
> 
> [root@test ~]# cat /proc/zoneinfo | grep protection
>         protection: (0, 2719, 57360, 0)
>         protection: (0, 0, 54640, 0)
>         protection: (0, 0, 0, 0)
>         protection: (0, 0, 0, 0)
> [root@test ~]# cat /proc/sys/vm/lowmem_reserve_ratio
> 256     256     32      0
> [root@test ~]# cat /proc/zoneinfo | grep protection
>         protection: (0, 2735, 63524, 0)
>         protection: (0, 0, 60788, 0)
>         protection: (0, 0, 0, 0)
>         protection: (0, 0, 0, 0)
> 
> lowmem_reserve increased also makes the totalreserve_pages increased,
> which causes a decrease in available memory. The one above is just a
>  test machine, and the increase is not significant. On our online machine,
> the reserved memory will increase by several GB due to reading this file.
> It is clearly unreasonable to cause a sharp drop in available memory just
>  by reading a file.
> 
> In this patch, we update reserve memory when update managed_pages, The
> size of reserved memory becomes stable. But it seems that the _watermark
>  should also be updated along with the managed_pages. We have not done
>  it because we are unsure if it is reasonable to set the watermark through
>  the initial managed_pages. If it is not reasonable, we will propose
>  new patch.
> 
> Signed-off-by: zhouzihan30 <zhouzihan30@jd.com>
> Signed-off-by: yaowenchao1 <yaowenchao@jd.com>

Who are these people, really?

https://www.kernel.org/doc/html/v6.12/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin

Also, the Signed-off-by doesn't match the sending email (gmail vs
jd.com)?


> ---
>  mm/page_alloc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index b6958333054d..b23e128afbcd 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5826,10 +5826,13 @@ __meminit void zone_pcp_init(struct zone *zone)
>  			 zone->present_pages, zone_batchsize(zone));
>  }
>  
> +static void setup_per_zone_lowmem_reserve(void);
> +
>  void adjust_managed_page_count(struct page *page, long count)
>  {
>  	atomic_long_add(count, &page_zone(page)->managed_pages);
>  	totalram_pages_add(count);
> +	setup_per_zone_lowmem_reserve();
>  }
>  EXPORT_SYMBOL(adjust_managed_page_count);
>  
> -- 
> 2.33.0
> 
> 

