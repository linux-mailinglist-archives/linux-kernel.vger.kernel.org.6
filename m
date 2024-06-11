Return-Path: <linux-kernel+bounces-210391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C077904313
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 20:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CE77289283
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 18:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5123A7E57C;
	Tue, 11 Jun 2024 18:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NGzu64w5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kzvHeBJu"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5095768F0
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 18:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718128956; cv=fail; b=sWccI5WvehrIG6FJkVyj6uvD6lnBZJQ7UFSyMYMsxIVec8D/W7mhQanjlrt6zM6Rp4hob2tzg8kEkJxUjL7TDB4oYcFlLL8gUMvuaXAmY4mhH3YvsFO1BM+HSuBsOFgX6rVCuAIs++Y161EvF3A3hPgrJBWZAUaXFBFZs+rjn90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718128956; c=relaxed/simple;
	bh=Oo3iet3v3cMcoPvhPpngz3jP7uQATPzhq+4h0U4944A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cRWWBduXFW7cRxI6oNFdQ4SJCzOR3MJpsIvNCemIkGf1uNyYX+3k7Dx0lQcuANhaQh4Ddt1AdjghDfsEVBu36h3+Hj54TC7ac+rzYsxnbu0RnSQj6lxFdEJrYkXv6cXuyAS59sfoYcqA7LBGuNCkTJAWqKpaIDSU7s9vPA0+/2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NGzu64w5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kzvHeBJu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45BFp2AT026892;
	Tue, 11 Jun 2024 18:02:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=NtDTgpOYmw2L9sa30CTDrsZtbzbSrSA9HR48G2SIoc0=; b=
	NGzu64w5f0IROt8lzQ8T/byFU1em0jhOC+Y27ozpl7BUJdmE/5U3AVfp+1UjmkKj
	oe+/8PFCd5mMxX5/XkFm8REhoWcT+xXmEO45HrhsxKHii0GTfVn41hWqdRLPfDRO
	cUHSPTpNXfnOGg3UmB3z14Hv8ZDxl9mEKpB6SRp/joU7sngxhDlS+gA6tVEo3xgB
	cLDXNPxkeBwLGSElvWgdiDHM7R7bBdI2OzxPIpveDiztBj7eIdThH5l+/H8YM0oi
	0xeqoZWcNKDMshtdl5/LSSOUWkmoyvN6uD/xecl/ohoe0EfRWuIKM/v4WDXQssKg
	8nAq+lRMpOnpLYbYylJ7mw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh1gdh53-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jun 2024 18:02:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45BGjHfI019928;
	Tue, 11 Jun 2024 18:02:24 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ync8xjusx-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jun 2024 18:02:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ogmRZTe+atuIevziUbJsXFQ8xKRskGoVJa20ZHNM/OKVeRpVjXCZx5Oy0wlDRRK/jOsxL/ya1AAnV0blEqNJFJ/ED9tGL0MT9+/p9hKkRlenCAZu9oBS706fuEtWFHZAEcaHqS4FhHvSwNGV1M7FMZ9h0jKVLJkKzTCYEkh668SLBBCz4GSdNNbroqf3JjTJ+23M8BM1Dh3u4tfAppiy5zMpbOH09HYbdiG/H0c2iytu3d8wkCU4muaiUmif6nm5dgXIYIdF0I/GPXr4QKUuZ9D/Qa2+36r8nWQDrhOtCu3tG0NN9MatNJ7kAvMigmkp7TlZtDo170vr4DANuQLlOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NtDTgpOYmw2L9sa30CTDrsZtbzbSrSA9HR48G2SIoc0=;
 b=KnTLPt6o2QCZ9jJbf7rjso7KV7wY47c0P9YH+nYExX/EBgvrspNLE4kCHw/JQeQaOsw8g+hix54N55oqy1tOORq5CpicB8WjG21DdCfQm5GM2F2w5rxtrgNexXDY25kdtlQf/xid9jX5cQO/EiYXI5maxqnqNJ5k4FSZq1ifWVfL9ZwNLLBjsZ5LywkHrLhLXLSwAnhxDGv1bJgLfu8Y/+/P6OeKmU3RAeDFzL9FC4/G68QaOp+6TcZ23/gfsQ5djwDtr3gwvY3R5MTdSYy4DMxYS5YyhqnTR1+LjD40ptgT/9XDrq0ddvWsndyxeYTUKGg6FWzNeynHfrY0Df3rWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtDTgpOYmw2L9sa30CTDrsZtbzbSrSA9HR48G2SIoc0=;
 b=kzvHeBJuQT8lpMSWhKuFJ8FMAbBHFDUgdn+j65ynUvowrp3nmgoL9VOGq7RMRHuM9TJLfUkbrIcOtwhOyE4BubbTcaXlf/EYdyRQeRJh0NZ4xNoFYZ4a46p4dGQVGW/VWj8bk6fIZcS3z8OVIZiVIwm7ZYDDo+5oEZgiWqoFwmk=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH7PR10MB6154.namprd10.prod.outlook.com (2603:10b6:510:1f5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 18:02:23 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7633.037; Tue, 11 Jun 2024
 18:02:23 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 6/8] mm/mmap: Change munmap to use vma_munmap_struct() for accounting and surrounding vmas
Date: Tue, 11 Jun 2024 14:01:58 -0400
Message-ID: <20240611180200.711239-7-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240611180200.711239-1-Liam.Howlett@oracle.com>
References: <20240611180200.711239-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::21) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH7PR10MB6154:EE_
X-MS-Office365-Filtering-Correlation-Id: 3187f6e1-d892-41f4-110b-08dc8a40a532
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|1800799016|366008|376006;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?0XbtzXmbM9JUbznRhTXlNqduItg/IvPhUM7XXsA++SWuIUKLCoc9AmQeslQn?=
 =?us-ascii?Q?t89ldx7dXEJAnX8uYFjpXvCfMVU3yfA3y4Jhi8pf3QgysE+Ybhl3N1eQ/MHL?=
 =?us-ascii?Q?HSEVCdRxbrZ3YBCQFCaK+54+WLvW6YSR4wcD/xxh+ZZHybyInBpE39cyXHNo?=
 =?us-ascii?Q?t19qCMGpcrU9kY7+xDAUPivp2bdMoSrVQItXpbtkemh2Uq+Rtkh3N0lyvosh?=
 =?us-ascii?Q?0joLM6xA11f70ffKbWwfM/Wg/jl9DGpfQ/y1ubAJ6ysHq0MDd+6GcrzK8wPv?=
 =?us-ascii?Q?sWE9Vy6c1RiSjFcEvpbu5VhU9yvEJwOCcjctBHX+g/3nrI4slz9BTYWErUSD?=
 =?us-ascii?Q?sV7pJa08llqdUaATDL/B7BiL9W5tGCqLyHVcZYPIjos7ufsCzZ/xVQZlVbUO?=
 =?us-ascii?Q?6yxsuxfF8gyr4aL9G3ZdpqNxrc4mJqHsUAftyrL13vIduPHOrnq7FClCpFPL?=
 =?us-ascii?Q?78n9NUd6JT3X/f+DOmHBSiz95HRu98sSgeJukSdW16F7NR5lGAJNPo4xdDH5?=
 =?us-ascii?Q?TgzsHFhmsvgMCR38jU0dKRh0uNeO2G7ziH5EMAYcotc5OhPrNQ6hR3apsEca?=
 =?us-ascii?Q?WUUh91C7gh5Q/gxtkkB6UxDyrDwv0YP1sw+ryIYtu+XfJ/mqhovKSiIdnjQb?=
 =?us-ascii?Q?M6+f9VdpX93EVlte+ukJnDopZAJBBdoAGmwNr+lt/Yo/jYKPA2760EK4nuFT?=
 =?us-ascii?Q?I1FTlX1q7ts0AcS7H/NV5FHODuC+hUDaJutRrHbJ7I2F3G9+CkrneTIxqCMF?=
 =?us-ascii?Q?PJ5tANOoctLaCflgM9Stp4kroIZHJcAHphwgM35sCbwW0MPttxRUHruCaGw9?=
 =?us-ascii?Q?2wo+RlJwPS0C8hzsUNUsubqtTE2F7dZCtqde6+8dyfcI5sdKBNmqgzflwpNH?=
 =?us-ascii?Q?Cb5vEdrTuNScz3SZFKqOXVhxqEr8FJ+JsvoUZydtImRiKrjwT3hCoxtk2w4t?=
 =?us-ascii?Q?MyfPrdkvHv+mbesv10QJNUkUuNW6aD3nV28nAxG8VxSkh9xVNevMUHCE944E?=
 =?us-ascii?Q?bSvZtJE8/lmPM0M1bloheXpemYVjzTQelV9sNORLOdp7CwCHPXeJwF0x9bpk?=
 =?us-ascii?Q?iqP4tc6ZD7mv5MyaRvxqLzGprg+cuzn3DRx8yBJrs99uaSk3T5zRd87ko/I8?=
 =?us-ascii?Q?2TYABq6sn4y8jm7mQDyPEUUtNIDlMKl6mSE5iwy9EAPYMZI1CNa1YckTQ/O3?=
 =?us-ascii?Q?N8DnQ9lfbd/2PEWrOaOKgrdLc1Kb0C9nzEVHgDCtKsvpP+WkWPEJnRvyUCO/?=
 =?us-ascii?Q?3b1PhHuj6tDv/xTPh+9LCSU46BmbutaesBIpmAAMTD5GFiMTnMJvJYhRMV7j?=
 =?us-ascii?Q?oJ48XIcCoIfkc+jO3NEPLzEK?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(1800799016)(366008)(376006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?o4GWb2izDziZVHgIyX7EalBsdWarTn+TH5Z2jEAvTzsn9M7dQSbAl/s5wLxO?=
 =?us-ascii?Q?doLPego8bQhNHS0h12q5gGG49272WjWKNfjz5p/vdV6joL2yRNFRHNA2Zqpl?=
 =?us-ascii?Q?izke1OQXS3lKqb0NhUjZtittarlHBfD8ncyO3nfZ0dFjOQeozJtoOthx3XIn?=
 =?us-ascii?Q?q1UheU1H1LGNTHUx8OKSpGYul5Tdc2D7cXAosgtTNi2jUHIj70EhVXAyolUu?=
 =?us-ascii?Q?mZmnmdOojDH4RT10ZGkmtwO3Po/9NVzKiCUAhMwIxb0N4O8CNWnjU2t+5732?=
 =?us-ascii?Q?pdHPrtjE+axR3MT5z76s9EBf5cnS1rEDnK6uaS6t4h9R7Ptv9RVJLgEVKRXK?=
 =?us-ascii?Q?nj4v30BewqZXaNENa4NTcxCh4xsZ/QFOhHnWXnzUO+/oZ9KIblg3nb5l5UPW?=
 =?us-ascii?Q?gc2w4Ew1emTJ9aG1T3NK+03JibrhkQHjAg7PbUYMeEA5uiPv8MI9sJOMldk1?=
 =?us-ascii?Q?LJ1T4hc8HFxzkaa3caHHLajJ9/RVZ303mm97OfRbDFPD8oOzGY/aT1Nx9lns?=
 =?us-ascii?Q?r3F6/NJKqUp+UJELde76bK+3z1FEXQBQvViNX3XyPK7uc6IzxHJlS+GPAbC3?=
 =?us-ascii?Q?WH+Akx4jdO+BbifvoJAhtbZmnSj9xxKGM1ifGfApoipGEbZhR79fGf2iCP6V?=
 =?us-ascii?Q?0Wf0Okr9T6Bkhnzxz80cWWakRg1553RxALuX3tXrfufLZbA0aFtZ8hZT4Ek4?=
 =?us-ascii?Q?xZ+PDO170n0uWUADvze97E5APiGphcTdZZhUhuzGYueZSii6SKNJ6luIglXT?=
 =?us-ascii?Q?LmeJT8HKy71d9G+PVZ5vmZ5AtP1r7K8wzCZ2+h23X+PmPIrijc2IuOlLZMXn?=
 =?us-ascii?Q?1kzibqnNMILoc9BJUjAZqlbq060knr9buaiUNgf6sOox2szGPQ6bl+94HvNj?=
 =?us-ascii?Q?Ew2x5uTFuSU0k2x2rJDAnXSp6ErQrXc6K7vpw0oUIKPALItvoQDkwPq+nE7+?=
 =?us-ascii?Q?AjvgQIGpkvZOSZqIuEq3eySFak5Beamgxwfs44mLIr9yQ0wBeZ5I1uWdaQZT?=
 =?us-ascii?Q?hlH9FmaLMt6SUtQQ3/fiA+SHKIkvoTvK0LNemU+Dhx0WMwS3Vu47wX87TvKn?=
 =?us-ascii?Q?IKeTRCS9Kpvtc3vN14WzaE7DNoukeckQHWAP5AMeEOdZT91FJf71tIn9DxJW?=
 =?us-ascii?Q?Nw04EZWl6gMudZ+s7bZPNXWk8PMRNJA6ku3LG391PDnEm6yggW7tU6miY8Qw?=
 =?us-ascii?Q?IZR74A+Slm7LQhj0Bw7K6Iw8g9OrWwH56qlLAMc3TJ3C9RQkiH3NsWkTcL71?=
 =?us-ascii?Q?Wb1gAZt6dI9/jakHnqxeanYF0ttM1RFyIvSge3qz6q8mKmnAORZQSGxd9iY8?=
 =?us-ascii?Q?5mCNNZlFMayyAxX98nq9nF9nZo8RpJogGhmyrUURstcP+WhBWElE11T1UlFI?=
 =?us-ascii?Q?SRrH3/ydwkuDYxCDAPpu8A3aAM8u3Bi+UfjB2mvljMcMVcF4BDtUmwOO1Rp+?=
 =?us-ascii?Q?FHoYlVXcI35xkeWF4GWYO+TJFqb8+nvFG7E+WbeKWQezYt2utDvKcPYYGRm6?=
 =?us-ascii?Q?RdbYLjHVSadzJ6ww1hZA8o/rS5i11npriSp47HK1wXHAghsd6+opqQDtdjjq?=
 =?us-ascii?Q?CwV8qv1zBgUNDT75kL3OUHVdjKFF6mFUpPm4osyT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	OPM+h9LuSIngl06PhoJ4aKBobfckAayNaafSg4UpZUM+apc+Arw5Oi2VmIHtR7Q8dofLLmJDoRgtBhgXiMWMm4OavP+jWb3RVu598Hi/pw+8ns8cDDWvL3qpZ3KHDBbUbgcC5m3JcUch0KDaWuCrdmGY4r2g7bn2ctLxR78YvF2JkRHTu62dCPru72PaW//RkDx7DccIM+CdL17CytcRsc4YwqT5OYk0LthQu5a3OTWT/jR7Uqf28sDIURJy/+1EOctCNDqwJG5TORHH7IZmWzhTmf324G3x0zIztFTG41545UmY4aclURQ2CRP5JAKCTZQhr6mFPQhxj0VN8a7a3peyI9lvscUm/wjWQTOyWt0MATNSOUOqkVEyRyp7smo0IkKITIjEAMHHFQmZGBd/rwSrzQ5EA2AdJfSMaLgoinws0zqJ4/p0MeGKv5QfBVTFxupBWlI9RLQxK+7sDcAtWk4YDeXr6TKOZ0MGss6JSjMk2tq4NpERXzvxvZdPGojRIuC/aa8NGRpUybyC3N3Tln3p7C6BVVIPP0Y7voMp/nXQDYH9kbaIuStAo59W5kceZmkoIcXaV+hhjhGwvMuXMYXJS/irO81SWawN9g/Zv7I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3187f6e1-d892-41f4-110b-08dc8a40a532
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 18:02:23.4824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9DTdHcJn6TSRE3l6n5ryphVKXFN79MYxfOcizABuOXTSWCPqVxxYa0UOnd/UoM0GjqWo8qpak6JsTGm8no7jKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6154
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_09,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406110123
X-Proofpoint-ORIG-GUID: uqKKyjR7leLkN6epM_XFWB4dKcB75pwl
X-Proofpoint-GUID: uqKKyjR7leLkN6epM_XFWB4dKcB75pwl

Clean up the code by changing the munmap operation to use a structure
for the accounting and munmap variables.

Since remove_mt() is only called in one location and the contents will
be reduce to almost nothing.  The remains of the function can be added
to vms_complete_munmap_vmas().

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/internal.h |  6 ++++
 mm/mmap.c     | 88 ++++++++++++++++++++++++++++-----------------------
 2 files changed, 54 insertions(+), 40 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 6ebf77853d68..8c02ebf5736c 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1435,12 +1435,18 @@ struct vma_munmap_struct {
 	struct vma_iterator *vmi;
 	struct mm_struct *mm;
 	struct vm_area_struct *vma;	/* The first vma to munmap */
+	struct vm_area_struct *next;	/* vma after the munmap area */
+	struct vm_area_struct *prev;    /* vma before the munmap area */
 	struct list_head *uf;		/* Userfaultfd list_head */
 	unsigned long start;		/* Aligned start addr */
 	unsigned long end;		/* Aligned end addr */
 	int vma_count;			/* Number of vmas that will be removed */
 	unsigned long nr_pages;		/* Number of pages being removed */
 	unsigned long locked_vm;	/* Number of locked pages */
+	unsigned long nr_accounted;	/* Number of VM_ACCOUNT pages */
+	unsigned long exec_vm;
+	unsigned long stack_vm;
+	unsigned long data_vm;
 	bool unlock;			/* Unlock after the munmap */
 };
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 374cf89f0c30..ea3edfa8b22c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -482,7 +482,8 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
 	vms->unlock = unlock;
 	vms->uf = uf;
 	vms->vma_count = 0;
-	vms->nr_pages = vms->locked_vm = 0;
+	vms->nr_pages = vms->locked_vm = vms->nr_accounted = 0;
+	vms->exec_vm = vms->stack_vm = vms->data_vm = 0;
 }
 
 /*
@@ -2347,30 +2348,6 @@ struct vm_area_struct *expand_stack(struct mm_struct *mm, unsigned long addr)
 	return vma;
 }
 
-/*
- * Ok - we have the memory areas we should free on a maple tree so release them,
- * and do the vma updates.
- *
- * Called with the mm semaphore held.
- */
-static inline void remove_mt(struct mm_struct *mm, struct ma_state *mas)
-{
-	unsigned long nr_accounted = 0;
-	struct vm_area_struct *vma;
-
-	/* Update high watermark before we lower total_vm */
-	update_hiwater_vm(mm);
-	mas_for_each(mas, vma, ULONG_MAX) {
-		long nrpages = vma_pages(vma);
-
-		if (vma->vm_flags & VM_ACCOUNT)
-			nr_accounted += nrpages;
-		vm_stat_account(mm, vma->vm_flags, -nrpages);
-		remove_vma(vma, false);
-	}
-	vm_unacct_memory(nr_accounted);
-}
-
 /*
  * Get rid of page table information in the indicated region.
  *
@@ -2589,16 +2566,20 @@ static inline void abort_munmap_vmas(struct ma_state *mas_detach)
 	__mt_destroy(mas_detach->tree);
 }
 
+static inline void vms_vm_stat_account(struct vma_munmap_struct *vms);
 /*
  * vms_complete_munmap_vmas() - Finish the munmap() operation
  * @vms: The vma munmap struct
  * @mas_detach: The maple state of the detached vmas
+ *
+ * This function updates the mm_struct, unmaps the region, frees the resources
+ * used for the munmap() and may downgrade the lock - if requested.  Everything
+ * needed to be done once the vma maple tree is updated.
  */
-
 static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 		struct ma_state *mas_detach)
 {
-	struct vm_area_struct *prev, *next;
+	struct vm_area_struct *vma;
 	struct mm_struct *mm;
 
 	mm = vms->mm;
@@ -2607,21 +2588,21 @@ static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 	if (vms->unlock)
 		mmap_write_downgrade(mm);
 
-	prev = vma_iter_prev_range(vms->vmi);
-	next = vma_next(vms->vmi);
-	if (next)
-		vma_iter_prev_range(vms->vmi);
-
 	/*
 	 * We can free page tables without write-locking mmap_lock because VMAs
 	 * were isolated before we downgraded mmap_lock.
 	 */
 	mas_set(mas_detach, 1);
-	unmap_region(mm, mas_detach, vms->vma, prev, next, vms->start, vms->end,
-		     vms->vma_count, !vms->unlock);
-	/* Statistics and freeing VMAs */
+	unmap_region(mm, mas_detach, vms->vma, vms->prev, vms->next,
+		     vms->start, vms->end, vms->vma_count, !vms->unlock);
+	/* Update high watermark before we lower total_vm */
+	update_hiwater_vm(mm);
+	vms_vm_stat_account(vms);
 	mas_set(mas_detach, 0);
-	remove_mt(mm, mas_detach);
+	mas_for_each(mas_detach, vma, ULONG_MAX)
+		remove_vma(vma, false);
+
+	vm_unacct_memory(vms->nr_accounted);
 	validate_mm(mm);
 	if (vms->unlock)
 		mmap_read_unlock(mm);
@@ -2669,13 +2650,14 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 		if (error)
 			goto start_split_failed;
 	}
+	vms->prev = vma_prev(vms->vmi);
 
 	/*
 	 * Detach a range of VMAs from the mm. Using next as a temp variable as
 	 * it is always overwritten.
 	 */
-	next = vms->vma;
-	do {
+	for_each_vma_range(*(vms->vmi), next, vms->end) {
+		long nrpages;
 		/* Does it split the end? */
 		if (next->vm_end > vms->end) {
 			error = __split_vma(vms->vmi, next, vms->end, 0);
@@ -2684,8 +2666,21 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 		}
 		vma_start_write(next);
 		mas_set(mas_detach, vms->vma_count++);
+		nrpages = vma_pages(next);
+
+		vms->nr_pages += nrpages;
 		if (next->vm_flags & VM_LOCKED)
-			vms->locked_vm += vma_pages(next);
+			vms->locked_vm += nrpages;
+
+		if (next->vm_flags & VM_ACCOUNT)
+			vms->nr_accounted += nrpages;
+
+		if (is_exec_mapping(next->vm_flags))
+			vms->exec_vm += nrpages;
+		else if (is_stack_mapping(next->vm_flags))
+			vms->stack_vm += nrpages;
+		else if (is_data_mapping(next->vm_flags))
+			vms->data_vm += nrpages;
 
 		error = mas_store_gfp(mas_detach, next, GFP_KERNEL);
 		if (error)
@@ -2711,7 +2706,9 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 		BUG_ON(next->vm_start < vms->start);
 		BUG_ON(next->vm_start > vms->end);
 #endif
-	} for_each_vma_range(*(vms->vmi), next, vms->end);
+	}
+
+	vms->next = vma_next(vms->vmi);
 
 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
 	/* Make sure no VMAs are about to be lost. */
@@ -3632,6 +3629,17 @@ void vm_stat_account(struct mm_struct *mm, vm_flags_t flags, long npages)
 		mm->data_vm += npages;
 }
 
+/* Accounting for munmap */
+static inline void vms_vm_stat_account(struct vma_munmap_struct *vms)
+{
+	struct mm_struct *mm = vms->mm;
+
+	WRITE_ONCE(mm->total_vm, READ_ONCE(mm->total_vm) - vms->nr_pages);
+	mm->exec_vm -= vms->exec_vm;
+	mm->stack_vm -= vms->stack_vm;
+	mm->data_vm -= vms->data_vm;
+}
+
 static vm_fault_t special_mapping_fault(struct vm_fault *vmf);
 
 /*
-- 
2.43.0


