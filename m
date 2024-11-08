Return-Path: <linux-kernel+bounces-401631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A509C1D18
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC62F281FC4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 12:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A3B322E;
	Fri,  8 Nov 2024 12:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gRLig+Qp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CxuOW158"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF811E5000;
	Fri,  8 Nov 2024 12:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731069354; cv=fail; b=KUms0jrosFRPT2NKCIcUuU5NIZ/tLwQoN7E/7SCj7lbrbJpBgN5pNA0c5py6mcAq+PD0f+vSe2kZvIf3tIB7GBdFOgM8kyM8BiN+A9jfB8/mDfVwlJvjM8O+9EnxDdRu+g5xt8hnbiRDiFQNaS92lCq3zZBBHleXBm2IJudOly4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731069354; c=relaxed/simple;
	bh=Wr8MxzMsdGf480WVBHgVYy1HOn/oN8HdKWEFO7h8Ubo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CreGy5FVwj7o6JFMKjjmlfT7SL4ibVBoOOn2BAhcaJg3jP2gfz+p6fQ0MnOGCwDz9K9OGKAqZLsZ3cf8UIvX8obM6m0cPH7/GWRmlaS5IXT40p5JwYV6s46+boNcz2wnF9Dt5vN4j+BsSGNKIz1fG1uh2xVIfKzDbvKdGquzVC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gRLig+Qp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CxuOW158; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A8Bgftj016042;
	Fri, 8 Nov 2024 12:34:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=PsnZ2Mvma9j92M78V9
	2PgeluXUW2BO2/ExHWagTnkZM=; b=gRLig+QpfapApMccqKPlmJwNPBQDp1SWRL
	2b+k9kqrBsMulzuv/F5yH1IoHyXMrzg/iIszXhGmEFyDMFQyodohlmWQt1i3vxr5
	O3fKIlgxvrZCbcBScV4enbMk6KzgT6iTUZjP4GFFbZ1ExPj1VioreDeCmV5BgRql
	ep3sAu0nn2IkM/TJFbxoLQOzXLgS9h6dbdiMNwPcR+5e1Kd37FDzfAsKuqMZTjwC
	VlK/lRP+G6qEV/usgE+2LSm1eYDqTbVZ10Js28TYVtxy613fn7Bht1sQ5LXeVDl0
	+t55AjD7wUr/ez3KrMFEtsZEi1jL+SEKpnO5jvgitc/SUH5dhe8g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42s6gj1aty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Nov 2024 12:34:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A8BAuba031449;
	Fri, 8 Nov 2024 12:34:29 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42nahb3hf4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Nov 2024 12:34:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fKySf/jkiN3i3hQ12zwAUStABz0m6M2l9cFjaUvjTIE/fs54tjCo+Cau8qTQXtOcuTHSHR6vjlgQOMinDsIuFwfb837rBJeQca/VeIkyQUTI8YizOwkP4sB4ITpq/4Hit4EFs41BaE+R6pIWa8MBPo8dm4LUsJLuJUL760hVY86Dc8oDrKU+uQPJIxDvPSrnw/+LJF1tbvNTuTgTxCKfgKvZls52h2Bx9BUA5m3mrXZ4w8LQrqYqpoahpOwmxQtLzQuFCwLs8lxORxZCU8Z66qbp6XsP/8gJm0RctQnp6aJCcFS+OcsmHo3Ky8015nJ7mV88zxoKmKBIYQ/nKNjEZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PsnZ2Mvma9j92M78V92PgeluXUW2BO2/ExHWagTnkZM=;
 b=MJLVaDUoh9DS2N2RRWrT0UkuB5A0Yhtob7IMCiYW/aK0hIawsG2jbMk2zSJsdP+jF0YLMIoTk6zabvqdpYx1dcPvCqdSbwyGxPze7AhXinPA7IwOJhSVwR3BgrTTuxowrSIcbWBZ8AMA5CmlXfwg0K05kD/+Onsk2oXf0XXmwiOy3izP8rV9qvc5A4qzUW49ag+9FfrS3aEPfpS9+AwjekXRVRxVu3WAk7V9OFvZ/GwWkxxbUsAk2JPvFiA/g6t19oq4GO4GFKujsn1oS/3QzUp7NwqH3pN7A13dLb7vmgpZb+5WJPJDyEh9naoGxBPN/tannO7HueftSIqZIfg2/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PsnZ2Mvma9j92M78V92PgeluXUW2BO2/ExHWagTnkZM=;
 b=CxuOW15817TBmRR9w7N1xhzZuuY+Kk5IkKhecgshm3qw6AaMg2UIHjgbkR5UKUQ0bBEtFg2/ddKgKVNj48tqZZBxLQzks1a9b/sDCJSzfM1pDFms27JaJpiqAK9rez+28SdDZFgdr/CthJGw+5bH/PNbJuU1Snq+qtzBQBHGUFk=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by LV3PR10MB8129.namprd10.prod.outlook.com (2603:10b6:408:285::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Fri, 8 Nov
 2024 12:34:26 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.019; Fri, 8 Nov 2024
 12:34:26 +0000
Date: Fri, 8 Nov 2024 12:34:23 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
        Hillf Danton <hdanton@sina.com>, Qi Zheng <zhengqi.arch@bytedance.com>,
        SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH] docs/mm: add VMA locks documentation
Message-ID: <0d540192-3372-48ff-99fc-e8bfb960e3bf@lucifer.local>
References: <20241107190137.58000-1-lorenzo.stoakes@oracle.com>
 <Zy4DQmWHpC_QMGTP@archie.me>
 <b81e4cc2-fc86-4ed2-996a-ad78a3524f31@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b81e4cc2-fc86-4ed2-996a-ad78a3524f31@lucifer.local>
X-ClientProxiedBy: LO4P123CA0104.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::19) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|LV3PR10MB8129:EE_
X-MS-Office365-Filtering-Correlation-Id: 23054957-9844-4fa3-d0c7-08dcfff1ae8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hTRrgT0KBYMrO6zoDWfj5P4G9R7HVwD3r9d/onNfCm0FB73VKUYdFZsIl1T5?=
 =?us-ascii?Q?g4hszk2hbXLgpW7kRIlhxQweZnP1eHmFBYEPab/y3Jtac2b/76xBGKoNiPc7?=
 =?us-ascii?Q?h+bhSCtCkTqQMLBF+uwqFKJ3dPmUkNj6g4u1Lw7QcJRGPll5ZQWoPAnwgGyx?=
 =?us-ascii?Q?X9BLrR5PhSSubScTmuzoJTUAozoUphVFNeT6cWwCgzW26/+BTcXVK3kfKGX/?=
 =?us-ascii?Q?3PnF3yAFONRL75EJlgxTp6l0Ga82OTsyb8A5kN47/3YJVvZVfEpQp9vB/kkq?=
 =?us-ascii?Q?CNsYrNZOHVtzH7DBudZXhsS4nthJzLr/UaQfMeWWUTGjaiIkawDUi1dc8MW3?=
 =?us-ascii?Q?qHc7fSErtWcLYXFxlD1MPoMY7ZevVSr39+xDfsdy3EYQ1M+eLaqa1OQY7fj3?=
 =?us-ascii?Q?hg6c9m0+V0ZMf6kpk6d3XS0Va8Gwon3ccPnhPsnRyNKsN7QbkS+mt2cCwup+?=
 =?us-ascii?Q?lvDDFFoKrkMlz++Pl4iu4dbYW4VJ9sWikdYxJhsdoPTUkQJcQp2dgFuk9JOQ?=
 =?us-ascii?Q?kq/INjglO+maA7kP69mg6yyvJ3bBipS+msz5IW5Bu0NzdGJ+LzUTYbzlFC5j?=
 =?us-ascii?Q?6qF3MrDQtLP115vTOWX98q/Ev6jSXWT1rS6Q14sf5Md9XDQjDS9XioDl90cj?=
 =?us-ascii?Q?hw5VMQemGMjucrj2iUKuDlHGBnHWYbE4xCbL5uIGdiMe3w8A26K+UqZ1L2/a?=
 =?us-ascii?Q?Q3ihe1jGaSifc1FZnxuy2+qtbSfz921frxJAHdJ7a9jA086Hyc8UwP0FiGYs?=
 =?us-ascii?Q?ULjq4zgoW4K5C2NeIIuNg8cDuytMs407gml5/irqZTykv3H1pJQoGD1mUwAr?=
 =?us-ascii?Q?IfHIbOyC2PDJM4gHqDANz+6LL6MlHAzxXyPYki+LkHG3KDXKcn03/cGygqvA?=
 =?us-ascii?Q?r+v90kYhE08XcRlRM8ZioldJqUWNulEo4iEw6p1A+ARdcJ8lSRInxh5N2xpx?=
 =?us-ascii?Q?gxdVSCcGBJ+26HUGFdy8XIW6CqifVL/1mT/slFoKBnya7NzItrypYOYd9FRJ?=
 =?us-ascii?Q?pXT+xsUM3+jywaDH5r5b3a2qU737Z5RAVk7BE+4q7OnQvzLJQeQ9a4jeZxgJ?=
 =?us-ascii?Q?qnFoo+1B2eP6/10SwbixFvrzmhlcXU06yLbNwUP41zNvH8/oUdm05IcyUe0q?=
 =?us-ascii?Q?ti4kGF/MDK0kFp9EcZHmBakgZwL2+sigUiXpyEXYtPHbtW+oNSobEjSilw5Q?=
 =?us-ascii?Q?tJCdy6s/eSccmLsuJi53E6B5sQ8Z12tz7KWe3Lad0nMJmtQpjJ9XPE/1zUt6?=
 =?us-ascii?Q?8xxHai+wgZWgR8jH7veT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+HMDwNqBA36xEGJYMZGpAHq/l2vKZ9JLJL+quLjU87q/ObQnh0h6rKF+3Rap?=
 =?us-ascii?Q?933WkD9cUFlKnAQB5ZHe2e3QYptfQC+A3yeVMI4BgpjASb250fR1D25LE/L3?=
 =?us-ascii?Q?HCqq7C93pBReIUesoF+3kUOTR0Hrsf7blyMOHEAlviyywtQYBiukiN5FTCsC?=
 =?us-ascii?Q?M7JXeMcHdzKnqMWMu6VlSVfnLNuIMDfwoi2sDYHfNfpEcFu8oXXGH/kp3db5?=
 =?us-ascii?Q?jo/I2hMBtFavbNdeFgIDPpprETw5mYTAgOBgXAHQu5kByrIiJdWiNW+EBa/K?=
 =?us-ascii?Q?HZEFScq0eI4ZSXRm6EaylP4rLKQR6NQQIsOE1VXghJC72lXZxiOIaciMowCx?=
 =?us-ascii?Q?fAHmMmRttYp0aMIypcxl+w6SUo78FhodtJayXqrS6/2v4UwgsBmpe3Os28iw?=
 =?us-ascii?Q?MeBuplJGDBWT5HPIHs6lp8DlwFS9J6uOSwV0t47XqmBDUAxohBOYTqbT68bS?=
 =?us-ascii?Q?jlWAgh3NT/ZiNr+aO7Y3eVzAcwBvdEuZ0zQJpFROX5z/1p4BxXgIZtkcrzs8?=
 =?us-ascii?Q?6eVdZs9GwENuCW9ykshAMMsypAfNVyqovs/2oemkUvW+lqzxsE+Bd9bQ6FAk?=
 =?us-ascii?Q?zI950J8W9vmYNs3GV85PRzV1u2ch0pyQ4f+xcPMGS1EUdOnYVXvTLpD+VCPC?=
 =?us-ascii?Q?mp9H6YrwhRvYRQQKXinoou39HZUw4LoLEgHlP7dJsAfShk/HzfIBaGT6zlja?=
 =?us-ascii?Q?pMq1GU75gWXrAlXqA6wfV/lZk5qbQdkWycry8bm2I8j+YTmgQ7eKz7QYb/Jg?=
 =?us-ascii?Q?mysg0FaT7/uI0nb9QfqCgPO8ZH8s4erwFlO36oBb8s6oX1FyjIsSAUN3yAVD?=
 =?us-ascii?Q?6/SIt25FhJhwHZsO358ZHN5Xs+e7hKUSwFn3kxKKDvj9BqG4oOOjvEMKiBxT?=
 =?us-ascii?Q?yox4OF5syfbTCGgWxIUjy5ZA3MPwAAJ+JeDaJc3MAMPEqI8G6cuXI3XLLPr2?=
 =?us-ascii?Q?app9ZtVPUMEmUkQom85Fid21KzxLuZWNN+vGLSd1XN1rv/kJO9gkY813HvoE?=
 =?us-ascii?Q?u39hm0GcLik5MAVhiQR5DuYjZK+qZ5tgRZOLajSQScSMOLTOb9emcYn6Ytrg?=
 =?us-ascii?Q?9uvxgljyPfNy6uqgxhpMI58RRajJ6g76tMa2TN+4ToCgwAwKrYOO6AdjXKHS?=
 =?us-ascii?Q?P1jjqS8hG7fFUE6eDixTuL1EK67JiOnoamp98tx8y3gQUpEF68N/JjExNOZP?=
 =?us-ascii?Q?pI0NTuA3RMtNCKXsJ5IOxYLoNCqgDo+F3Cz7wKka5TqxvFJGRKBlHSPFYcdV?=
 =?us-ascii?Q?jrF4kyxRIFR851M7etaYfmoP1B82sMU+RShavyeti/JKd1J+W9US5lIg14UP?=
 =?us-ascii?Q?uoacTfLz3p2+zFNoVRJR1r1424VNS6pMDR0VIWHQcsTymrMv38SVhHJySiUc?=
 =?us-ascii?Q?dynQOeilnE1tbcm95ibwjiC7ApRai38e6e34/S6Zs4DQl/frv8XeVvKgjWnx?=
 =?us-ascii?Q?yqOSA7jMfyixJrVbZUpw9reAJvjwbkSXqhbgdDL44s9tHMf1uLFHZvDDO7Jq?=
 =?us-ascii?Q?H5cfRT4QmzypURRftD2wxVwsaxkxI9OBWf+rYTjEeAhtzKRjGw7UCfpZufGc?=
 =?us-ascii?Q?TQiwbdqcLcc5SlyIePbRF2V/8BXbweqtglFXci9UunL2ysD3Mu1GSu2sMxVn?=
 =?us-ascii?Q?eQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WX1yTPCzlu8d4ClV/9mg2qPFyAlHe7DQPnQZFu15b05ummO7g7xiq985a/udYv2Nq+QflCxHpi0fBUjCnXAKc6d7YKKt20KUuVSm+uTuykVD+5h/mZ5sCc8gmkBzw4dOjhougv7lkUCxUnIlXopOpy+PU2waCQSwNQl4zORlMjpgZwYgjQI26GH084ed3RVr2VdbMOjKkQ4T8YFqaRccqA07jN273WvxPHZXvkGHsVi9iA3Chb3BSf4et2AOYbWbDKftYRPF8Wi2eswGw8SAd6NaycMQ5wvRKAY8xkEJfiNDse+t9ZLnGx28uVVynrFR14IHexoHUtlYNZGfuP54y5t8nm6zP78GtVygYy7GKmIGOib0MSDV+V6F18Chnq4ecDCDe6qz7pu4xLZZWw2X2/r7g+P4Jxdbpv4bNnVqCUuaXKQnfFxoM2bM222tdPv7UwOODqRcmSUH/kD8y160cJG2eu1yNriLRfKBHLgwn8rQ/qimtjFoVtEtg1yUEI5pQR2VI5S283YjXDA0WogcVRy+mz7QGJwXslLX9Vmjcypf73kyjFb2f1sr2E+XSfpo3D/8kFIAf0mXhONF4zALw1CSpIAw7UXLjwC+JcniXgU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23054957-9844-4fa3-d0c7-08dcfff1ae8f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 12:34:26.1560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qCZnpcae5A7+LV5QOHl1K80escyYyhx/DPMhgebRDm+8akfdYtrEwdeYXIq+d279ApLYYElAD6qFoj1PIpQ1ALk5yMkRNkf1W3sl71wDix4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8129
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-08_09,2024-11-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=926 spamscore=0
 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411080104
X-Proofpoint-GUID: MiioPy1e-WwSXEeFqveG5xfIGYf5FItA
X-Proofpoint-ORIG-GUID: MiioPy1e-WwSXEeFqveG5xfIGYf5FItA

On Fri, Nov 08, 2024 at 12:29:15PM +0000, Lorenzo Stoakes wrote:
> On Fri, Nov 08, 2024 at 07:25:38PM +0700, Bagas Sanjaya wrote:
> > On Thu, Nov 07, 2024 at 07:01:37PM +0000, Lorenzo Stoakes wrote:
> > > +.. note:: In instances where the architecture supports fewer page tables than
> > > +   five the kernel cleverly 'folds' page table levels, that is skips them within
> > > +   the logic, regardless we can act as if there were always five.
> >
> > What are being skipped if e.g. we only have 3 or 4 page tables?
> >
> > Confused...
>
> Page table levels, see [0].
>
> Typically achieved through stubbing functions out, etc. So in the code you
> actually write and _conceptually_ there are five levels, only in the final
> compile you might have things like p4d_present(), p4d_clear() etc. squashed by
> the compiler into nothing.

I have updated this note to be a little clearer and to explicitly state
this. Thanks!

>
> I don't want to get too bogged down into the details of this in the doc, more of
> an aside!
>
> [0]: https://elixir.bootlin.com/linux/v6.11.6/source/include/asm-generic/pgtable-nopud.h#L9
>
> >
> > --
> > An old man doll... just what I always wanted! - Clara

