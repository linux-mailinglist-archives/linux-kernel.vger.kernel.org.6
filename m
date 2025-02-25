Return-Path: <linux-kernel+bounces-531774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC43A4449A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A02C73AEF07
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6783E1624ED;
	Tue, 25 Feb 2025 15:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="da6+hVYj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rszokJVX"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1D61624E7
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 15:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740498056; cv=fail; b=uks3e1J9gPcL2C77tQGRkhRb64n5QuPGHrgiY9BwHhCai+UE4ua72U+HSPp9NPWVRZRtKp8nlBfqqGDryFnp1Gw8muFWYqfO+tSlJvVG5y3OpEft2qegKZan5aSF/FQSep3ESxkNMq1YLTpn7vC5uyjgN0G2ichfWNxIZcHUJds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740498056; c=relaxed/simple;
	bh=5t8dxMf2jp3KNBi+94dwnila3qjjBIvglyEMviCsEtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Rx+0lyi5TnlXYjPQX9sCF4OGtH0cFrKUsnszE2Etd+OHxA97qgGbOXn5I69g4bduKZz0dejVMah/npzVTotcpxicuwJpnsZR4fLlkJpDPh/OpXGfyWBF0H0aIsd7mNl21hzZlrFip30KeR4/bA8SJlS27Biw0bgFoEvCyzA3ooE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=da6+hVYj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rszokJVX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PFMa13007169;
	Tue, 25 Feb 2025 15:40:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=jAZdGB023BcpIWfyPp
	zV3kBX+XXYmvzo7YPk5G9ufYA=; b=da6+hVYjwePiFXCWxS/cyy4v+R9xXOcdIH
	2lm7yTBNmEnSxyEjIekJfT6NWEG4F7GuMzWA4/WKy1qZNZjdBXY5Pm0Duas7+yEh
	BoSzEJYmdCagGcv2eVsR1tEYyRM2exARK0CJS6WTcwBJjs2vkLtFJ2uqOp4tS93h
	YRaLbAJDsJ0VC9U79JUua021BaZh63wqgGZuQXsGdKIyxpd2UeUYrxjj1zpfssi5
	a2WNKWhIOZqti4Ao1r2vssTWOntdi+cvFGI3Hg7MYmqHtegAzSEgN0+DNr3zpcFp
	klvFaIDVGb8ItCZnTdX6MnmPMMxXx/f/x7oT9eJmHLo8HWbrSTRA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y66sdgtj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 15:40:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51PEUnqs012665;
	Tue, 25 Feb 2025 15:40:45 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51an027-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 15:40:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G2YmLfoDki7mkbJU8Z6TA9X9Xi+ZQzELC4EP4o9I3jPinK8oBfQaYRSY+8m3MzuYjESxzK4C3EM7v4Rx+UQMhS72ixCVftLhocjHI8qVDo13H0EshSZEF9OjMM7CLz6yH33GaIJckxeokJUP3yaMpR3xy6FicmZF2ivYb8OSo7lGDRsnwYvnXLuGvKmFc72KectalevMlzphqM2QNvLdiiwn7w6F9Bn1Lg6sh9xQthLqtIqUhONc4KUzDlbWS6SfZG8EwsbFoRtGjspSfMoGQTMw3N0xtp8V7bulVzSifAxfYxmPjn3LDcZGCYV1vTi09gHO1VN+xvfij3CIVb1a/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jAZdGB023BcpIWfyPpzV3kBX+XXYmvzo7YPk5G9ufYA=;
 b=IAgW3uQcwr467z1jC1FNwr3PhtDY2om0zqeVBE8Xyekz2XbNYxY4M+LOC9mZDjoNRYNl3cDK4o2BfoP2F6iPKj5AjjPYnw+sEK59L9axCqddtN56VzO4I31Prn4RiPY/6gglh80RzZj9unviidRepUrt3CumLuv+JBe6dJuaieUv3zIXmoLHwqO8xzIX6WfNhpnetYBX2Or5m2jhvgHBiohjfecvdl2O7iSiW/1z4GcdnLqfZsI+gRSB0usnr/omwySEnGsBZE5iYJCEyaxdO1vtg5j97xnL+K0H7vTs2rvUUR0tnkOccH6ND1xDkmEA6l+QBvQwYeGrrOo/eEIBqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAZdGB023BcpIWfyPpzV3kBX+XXYmvzo7YPk5G9ufYA=;
 b=rszokJVXdha8c7vJF2Zic3K/8/PtnN5lIBL6vjh2J/WHZ2LOBPzjcc32zAtlunNs0I1cYxujnfM4X8C7wIXvFisCacetMHV/kmb4r+ogx3Q4pMXvshVfBxzfzPHQLqpxbcCIEd+yFMLmDybD+6a2YQXeqdOblkk03BQ5jINWa14=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by BY5PR10MB4274.namprd10.prod.outlook.com (2603:10b6:a03:206::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 15:40:43 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 15:40:43 +0000
Date: Tue, 25 Feb 2025 10:40:41 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        richard.weiyang@gmail.com
Subject: Re: [PATCH v2 1/6] maple_tree: convert mas_prealloc_calc() to take
 in a maple write state
Message-ID: <fp7vgt5zvqkjrg34aqztpvhywraqua2bzr5hs7h4adsm3jiu52@kier4m2xkqva>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org, richard.weiyang@gmail.com
References: <20250221163610.578409-1-sidhartha.kumar@oracle.com>
 <20250221163610.578409-2-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221163610.578409-2-sidhartha.kumar@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0215.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::24) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|BY5PR10MB4274:EE_
X-MS-Office365-Filtering-Correlation-Id: e63728bd-f563-4869-28f6-08dd55b2c3cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?40hCpysU6ay2KbJAzeMNih9W6YcXzugozunJRORGQahsXcvsB1cFsJYGSRdu?=
 =?us-ascii?Q?6bFNENviiTLZCXs2Ry9Jv38rSZpggvs9tCEPe8MYhjiWgh5+iCNKzCgQMPXo?=
 =?us-ascii?Q?/wGkdzxPkMp2AO9aj2tpKSKkryKlstTCLpB5i4Ux3+YW02ysfOWHrATSEu71?=
 =?us-ascii?Q?xuLzJF242vlRtpqBP0G9I+cGGoRU0iXc4F2ILAgq1nPG1zIjw7O9z6q7UqOM?=
 =?us-ascii?Q?DdHB4o0OK4OwgnuWGJI3B3M25LA41uaixrLZDKlMrq7uezxW3SV6oGjL7s9n?=
 =?us-ascii?Q?yRFW2OB1iyfL07qYBAv9x3BWk8f8YjoGKQSY7I7OtzIljd0cy9Zmh2cjl2l6?=
 =?us-ascii?Q?pjzuWKTcw0Xe4RmxGvkzLL4UBJADZe99Xrvz2mufXnOiaEzvLLmD/k5Z5bST?=
 =?us-ascii?Q?w/TCOv5AKZekBZk8aFAWb3YlNjTMqG+iFg4MxDWf4TL1qm8YS13csKkxZT3F?=
 =?us-ascii?Q?7UzfgVYIIJLiTxoomWIt9S4gQVVv8sDEqXyvtgBUluL7qaCyDAcUHrBoDYUS?=
 =?us-ascii?Q?ojfLNKFL1j4sj73I6o3my6gsp1+vuRFvSnPbB+SfCqqylvrzWOrlIpB3U38y?=
 =?us-ascii?Q?ZTD39uGeu+L44LQ74BxXDRvaiwp2zMTyuQiqHP8kuiWnnMAPiWBxG7uz+PEY?=
 =?us-ascii?Q?vMxLzn2LtQhhn1qaQ0+UJ1xsKfPoKuahUOIFSuOStZzoWqoZJOsdJVINHHfW?=
 =?us-ascii?Q?mrISBNYZ0MoWZi6EpnFH97IBPvXJya4V78V01irbokgRV3BFpX7wLglWLPdf?=
 =?us-ascii?Q?V/LnA8TB4xEdD85ojNyYLKWyqYsMufOSzbfcb8oXkPEqLYR+fEhTWivw+ku+?=
 =?us-ascii?Q?pBP7tVqcMBJD4XW9L86W59tyVZTo9EgcrBM3i3CGIrgx9yYD7DnCrUSoFB0Y?=
 =?us-ascii?Q?cstVmZ06a78DoVf9bV8O4GlHwyPLrGv+OmiL8gEIoKnqczTltxS3gC1glCiL?=
 =?us-ascii?Q?pl0d4MvhgBy/xy4SgLgqPhYlsV8nztE6CaWtOUCsg9UOBOzhjOD8g6rZ3FvE?=
 =?us-ascii?Q?uEQc9IKvcbKcYAQXZ5YhsArU3/xg0c/Q44NwuoQZI0LSHr59pUOZdwOt8Xsz?=
 =?us-ascii?Q?JeufSliJ1XtV5MiOB02kJsx0tGmQlD+Q8Q0kMKPffdTEN8rodU2DpwLwx8n5?=
 =?us-ascii?Q?rse6KQXSMgOCHTYvW8K/0V9b/dtA/v+D5qeBzTFzpJ8mRm6E3ToI3o9AMNaX?=
 =?us-ascii?Q?MB2/ebNeFLXTaxVM2ySP6BSHFMh0mj3izzjKS8XwZsTlL9Olf6hh9fDmhPzU?=
 =?us-ascii?Q?qHwsPYmZmpx+Ankn11cAZ9hD/xnL8+nlvs2KxAVXTWweWC2dUU4jZo1XTdS1?=
 =?us-ascii?Q?HWcwFbt6r1Au58NDx9bhPwzAn9QejBCiz4E8p8s8pidCVCTbqRrUjrGD4QcT?=
 =?us-ascii?Q?kf7EOuGrX2Nv9JGSxSFDquTDgvMu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Wveeg63iDsF7bbuI3BhXbWx6vJrpLeCUXb5PGtoLIfwn3At5ja3kZEho/uFk?=
 =?us-ascii?Q?wQzUP4kAOVed9dJBQMlX7+MHHAPIl+4vYpB+FlcbOosrR3yZ++O0GXUJfXoj?=
 =?us-ascii?Q?OJwrX42WFVuLPr8hGcg102DX60y02nAywq/ccvU3MM3PEVlf1wdlmkYiGhUh?=
 =?us-ascii?Q?sykS26sns1f3X748K0jHbrV7rmcDauELytRzqOQ7eUilBycRBO7ikBxwxpIU?=
 =?us-ascii?Q?kBGdxfd1rlDacUXFHnKG7F25+cm8u+A6I4KLBUHHDwcWdBeh8saZKpS48OK+?=
 =?us-ascii?Q?dN71JfZOva9SL+kR5YAp+kpWzkFbsbExKhD3+c8nfGzWJFkPXM2+TaqKvwNn?=
 =?us-ascii?Q?UkDew4dR4wtNx0rS8KbolhrSczNxaLaETkV82GAbbpWsM5NmV9eCqJH6S9pv?=
 =?us-ascii?Q?pgjWe5Uc434Fb99qbAo6hhqEH72hFKfg+bRzhXHAax/4Vm6pnGgpROYqLcl2?=
 =?us-ascii?Q?BzYnngK1t0OXcgrzxAGUeQWoxHYovRyq9cltI/7E6W66/+8i/BsE/G8+KX6G?=
 =?us-ascii?Q?Zi81ROYGkFUcyCFaAcbK1hDYboxXqE1QgkDTTJ0T6s1GjQcwgW1v6XLFJkvv?=
 =?us-ascii?Q?fdQSbI6ui7xQXLD5VR9WrPefFbmaYfSNJA5tRM3TCX6Dmb6snmRUB/MSvxMa?=
 =?us-ascii?Q?IDReiMA1+VIqB21ErR0sC+V+0LoZi9Ux940KKqBj5KRCeukx/BAwwzCciKcj?=
 =?us-ascii?Q?r1k3v1LIH3CRg0xrtQy2l6drVYfpE5DHQ49eLbrfjz6Y9Gr4DCdEnumnrPXj?=
 =?us-ascii?Q?2WcFRTP0TlbglGVJSmFWaXyBzKkSP0tD1ux2oA/B0z4F0VoAqjYRdUb423nU?=
 =?us-ascii?Q?smBKFT9zVf8S89Pvn95cAAlpPkNMSUfcxFs6c3XOOOpMs39h17iv+Mf76CUo?=
 =?us-ascii?Q?bvj62fVBBc4GLi1DFRcOmz+5bUOSUqkFv3cC4ajYVQIcB9gxFCW7+7LeFZO+?=
 =?us-ascii?Q?2CWVNsuM1MpmjDz+zehuphXedkvPPrhCWrVkFxkQr91+PhhHKJkgFPwYMVt+?=
 =?us-ascii?Q?vj84FV4KWV9F45533VH/zBQRePj/52j7jN01tCGbVSoTjt89OBzDTzWi8K4X?=
 =?us-ascii?Q?+eLI0ACCFD3NkR5EcfANeaUfh/puYOqPTG6ehoIHNVhYlLj7FLIcLVSB32kL?=
 =?us-ascii?Q?Un5xlqE2UkCONKJq4P3Qw1sVg6xhFAiCtLXd6pl09/BExjIqcFTvU2ujExJO?=
 =?us-ascii?Q?48FVyBZMqcUNp4XkwHDBxB4FEnDXsUy0vPQFsQ94RBhJ4X5BvvaGVsgXuHmq?=
 =?us-ascii?Q?w3adQG24g/apynK5294TidnXuisZMly9f7wrIwtRHn2Mf1iB78V41hGpxRPZ?=
 =?us-ascii?Q?3g2M+q52od11wz5OKqIzlJSqiujAYRMw9TyUh08BOez4i5AVsCwNqTGMDGwy?=
 =?us-ascii?Q?vuRnewScrfzfWLdUELGkurR0y1sZ9RNUOgrF8WzDptdefv32T/YenKRBiqbW?=
 =?us-ascii?Q?n+PrF1QN6C8TVec8bsJEUWiqgS97hGyRialWGjwSDDyaz0Xw5qkFIF48oqbb?=
 =?us-ascii?Q?LJZw3iJyIsSwmrVXfW1HfeE25ccgFKFLlavpUrTF5ZzZgxbWRYF7j0qF2g8G?=
 =?us-ascii?Q?bu53cIObENZGntNekcXAhVnjtAkGc2H2uXkwbs9pJiFpObBobU7lbFag/F5+?=
 =?us-ascii?Q?nA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JljaRc2szEc83r+UdusnPBHiamNZ5RForYV0O66L7vnOUI0WnlrjPX+PjIABpNWRNSqREM9Rk55wtiSv7np8KgYmSOM9QijGOJnNuiLdIu7KApqHbXPTeDjUTAWvDULMmFZPv4ijCci3IEe2Tylag0408c61BFdpHxw8wxGEmtm5wIshbFFpwZnP44w7w2mBkTZoJO/pHDUQviOkjgU9WJga1mLqBc6ei0xCVudsavNhe+dK+0SmSyzfgoOlusKYAeTEHjXma2BdrjDtHr0LGkIGslfueJez/PzUYv8+kAzhTLiXm7BNAnfMIxGifphRFmJpO1I7kAi0TgmX0cNk3IhNx3yGaFDM/nnrFNr8wM2akLwwAHS8zF3roMuD11zqAXBcl5Qb/lv3tD0WQk3SpyAWy+ZG6/sYwthcLeMYc5TQrvav9gl5lFaNrZbb4IqXwtDmzKq1ki7guvFte3HMzaZiDAqYdwbAXxgESAEBWJy3tt4xiJPy9XZwiJU0lf1/fLXeTnFFAjJVrAqFe25w3JiK25SmB+6zInhVje7hSUoA4fkVteEcz5GOfWXhNmgZ0Npg2aHkhElEGfsefaxseQTc9akeJOWxd25UVeEyWgk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e63728bd-f563-4869-28f6-08dd55b2c3cb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 15:40:43.4910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pmE8lWId/Xr/qyELLCrSE4vPqMb2yASpS7rr4yo/f53NriPBBcTVabg1AF/TfPTSbBeC0cUN3Ep5iyC+H+FH0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4274
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_04,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502250103
X-Proofpoint-GUID: FWGy5velWOVqpClMsQKukoeqzrt4WVRW
X-Proofpoint-ORIG-GUID: FWGy5velWOVqpClMsQKukoeqzrt4WVRW

* Sidhartha Kumar <sidhartha.kumar@oracle.com> [250221 11:36]:
> In a subsequent patch, mas_prealloc_calc() will need to access fields only
> in the ma_wr_state. Convert the function to take in a ma_wr_state and
> modify all callers. There is no functional change.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

> ---
>  lib/maple_tree.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 42c65974a56c..0410e13a099e 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -4144,13 +4144,14 @@ static inline void mas_wr_prealloc_setup(struct ma_wr_state *wr_mas)
>  /**
>   * mas_prealloc_calc() - Calculate number of nodes needed for a
>   * given store oepration
> - * @mas: The maple state
> + * @wr_mas: The maple write state
>   * @entry: The entry to store into the tree
>   *
>   * Return: Number of nodes required for preallocation.
>   */
> -static inline int mas_prealloc_calc(struct ma_state *mas, void *entry)
> +static inline int mas_prealloc_calc(struct ma_wr_state *wr_mas, void *entry)
>  {
> +	struct ma_state *mas = wr_mas->mas;
>  	int ret = mas_mt_height(mas) * 3 + 1;
>  
>  	switch (mas->store_type) {
> @@ -4247,16 +4248,15 @@ static inline enum store_type mas_wr_store_type(struct ma_wr_state *wr_mas)
>   */
>  static inline void mas_wr_preallocate(struct ma_wr_state *wr_mas, void *entry)
>  {
> -	struct ma_state *mas = wr_mas->mas;
>  	int request;
>  
>  	mas_wr_prealloc_setup(wr_mas);
> -	mas->store_type = mas_wr_store_type(wr_mas);
> -	request = mas_prealloc_calc(mas, entry);
> +	wr_mas->mas->store_type = mas_wr_store_type(wr_mas);
> +	request = mas_prealloc_calc(wr_mas, entry);
>  	if (!request)
>  		return;
>  
> -	mas_node_count(mas, request);
> +	mas_node_count(wr_mas->mas, request);
>  }
>  
>  /**
> @@ -5401,7 +5401,7 @@ void *mas_store(struct ma_state *mas, void *entry)
>  		return wr_mas.content;
>  	}
>  
> -	request = mas_prealloc_calc(mas, entry);
> +	request = mas_prealloc_calc(&wr_mas, entry);
>  	if (!request)
>  		goto store;
>  
> @@ -5498,7 +5498,7 @@ int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
>  
>  	mas_wr_prealloc_setup(&wr_mas);
>  	mas->store_type = mas_wr_store_type(&wr_mas);
> -	request = mas_prealloc_calc(mas, entry);
> +	request = mas_prealloc_calc(&wr_mas, entry);
>  	if (!request)
>  		return ret;
>  
> -- 
> 2.43.0
> 

