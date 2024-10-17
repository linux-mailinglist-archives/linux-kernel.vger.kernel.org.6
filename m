Return-Path: <linux-kernel+bounces-369324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D94079A1BCF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 09:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5284BB21146
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 07:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812901C1ADA;
	Thu, 17 Oct 2024 07:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f8JOqd99";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PHpMNa++"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E660739FE5
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 07:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729150748; cv=fail; b=XJdXckzcMn0T1x6ZWAJYetTCeRycGA3RTjyPqmD4CbSmArwOaKTkb2taallFhAr/1YNNFZ4UAo3APILZRLmbMrSfd+ysGdVhsqquNsZv1hoNoDsCAPiqF0kFyIHzfREfrC2jp4Pcl+tNjEfASkR03X4wUI206yk37Q/LUIVnQYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729150748; c=relaxed/simple;
	bh=AdM10UrfICWN4Rpzvg2lTCbzWVVb3fVwn/RAuNOxBHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DOxQE4dymTCI6k2NgauZ44prWVrVSQvVou1FxKiNPd0zrz4P60C4Dj0tqLD5u3CPSzKbG8oK4uasibSx1P6sl+g3s5FyC1BDxqEEJm7PAQV+osIG38xlkWH/iBOK7ju9GoGCzg1SNu0s652MC/zinPdTFmItb73RYNELr9Zsa5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=f8JOqd99; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PHpMNa++; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49H6MoL6003569;
	Thu, 17 Oct 2024 07:38:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=WmEuEz/h2GVYpccisS
	eecZkrc/yUQBTWDajtIltzOFs=; b=f8JOqd99Snend7A4NWdroF13BQDObZOOTe
	/xqHbYpbuo7+Bschqr/cISjftAJ4U9xsJhLS9GMYmaotSHbEdpVn+vP1usRQcerC
	FUZaBELyVu2a3BWEkO/vFT2RnF3PK8W1NzJE8Z18YzYDjgP03oKPJ3TiBIAbPUIb
	e5hPOdVws1jMgnOIanMJYe1hzEQ0SXmo16RDo0sXvFPY4Lw9Ccq/iDH6IIASnLvZ
	h3xkMThGMENoEqjDf1duNbHfs+b/b3o0lO+tYrZM80gTuljy9xjcjjGQzAS5lDn3
	pW9VVWxj7rDjOSCiSJrwoHW4LkTdxscn+7ipK7RBNIjD34M+0tZw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fw2nsg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 07:38:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49H7MoX8010968;
	Thu, 17 Oct 2024 07:38:49 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjg6cfs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 07:38:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RAqFiVRxIrG58WyrSULBvDnsTV6Hn3uKIO9d2gjiHh8N2YZ1mC3OaBKOJQhi+KCGG+m7jN+sgEJlzb6IYP07FYYcqLgq+KoFifwUN92OVJKexHPndbNY9qbx2+MD3wM8Abntw7xvcbzeHN0LxTKBcBsVy0FaeALIYoAf/0cWv+vZjEUKz2+OIdN3ou/ldrZDsPp6PE1lhGvN0V6dUZ9sXgIOSw6g4b+ADyrJVo533+8DYj2J2YaRQglJMW+pmku3nKr4wUTl7YJev9RY5yGne6BNlpMFgnWv63RVGMJWBLle+1ucQ0JzHfQmTJ9h5TNOo5K0N5sHhc8Y0iFHfl028g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmEuEz/h2GVYpccisSeecZkrc/yUQBTWDajtIltzOFs=;
 b=wJZXQeZGXueld7JRc72UO6K6UMfY7/XgwkhkShc9E+I2S2pWyrI4wkICGLug50SgEkCxOuBbmDdihkydK7iK6SOnEyiZzJ9O6H669mNY6P4Ng7yJ3dahXfl/ePyxGr7RdlaCH+UokunX3Y0UodIhONSPgg/BWebAInzoMNSdaPBz4vv3nTZahzOE1l6Vjm94/Snm6l24OxTSOEypSCBKQiYqYVjJ3ndYqyUxdNv2Yg+5pjWPAzQw+JC1oRNYFa22tUJ9F58gZP+vr3zpiOY2S2qpquzMIVIRHDZUo7GlnwbFpM96PF9DqivZKhilBCcfXRlz1OoF3tsfrUwWLJDxKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmEuEz/h2GVYpccisSeecZkrc/yUQBTWDajtIltzOFs=;
 b=PHpMNa++mzjDjwhFpOJFih2ZeXyPXEq5ovim0I+GQtaalcLBFBtn4cQjTJB5XdCtBmaLbL+9TwrZ2AKSFxpVvM4hMVpbfIfCNfuQo9hS4wAoPvKN79QKpz3QntvogVpebgNn4Gdbbf0InsSwGzeVWntrpYBtoxSMwozsgeW0K5U=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DM6PR10MB4265.namprd10.prod.outlook.com (2603:10b6:5:217::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 07:38:23 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 07:38:23 +0000
Date: Thu, 17 Oct 2024 08:38:19 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Bert Karwatzki <spasswolf@web.de>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH hotfix 6.12 v3 0/2] maple_tree: correct tree corruption
 on spanning store
Message-ID: <bc858008-6c02-4a77-aca4-39a6c62af13b@lucifer.local>
References: <cover.1728314402.git.lorenzo.stoakes@oracle.com>
 <20241017001723.82bdd8c48e5be32c4fc70f5d@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017001723.82bdd8c48e5be32c4fc70f5d@linux-foundation.org>
X-ClientProxiedBy: LO4P123CA0084.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::17) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DM6PR10MB4265:EE_
X-MS-Office365-Filtering-Correlation-Id: 665a70db-9784-4bf5-6267-08dcee7eadcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5jcR4YdgyOW/f4zP5azVqb/wYh5BQoohX2O4FiTGUBNnnMIMvRhthD3Q0xcj?=
 =?us-ascii?Q?37BR+foJiGmSoYx5SiwKZ2MwHqfCNtm12RwFdsuPwq9DHkGGYSG2amOZbY/E?=
 =?us-ascii?Q?2bJWUkQqjDFpPdX/LU4AR5yx1lgZ18Am7uPCBTZJeEjX6qg2VKsRyGIVf7kM?=
 =?us-ascii?Q?dnOZN/OeGBnrfzxog0Lerlo8AMeUSfvE3sXjK3oiDVUlEU+ZIOBIwveqo6wC?=
 =?us-ascii?Q?2shJnxFEmWva3WLzTt0gxTm8Bshb5izxQaYYWP9kzySVwjjidxSthPaPUvzI?=
 =?us-ascii?Q?ZKqe9nwPkuHqsjWUcm+3UtfYMxuIHO/osDjy4van0djL4nOW1piOGfqgQNNf?=
 =?us-ascii?Q?HerGwzXiRTggX1L3ZyEMfL8HZI3YSs7CqLIIJblGtnuR0T3ccwURoETsnU+o?=
 =?us-ascii?Q?7A5WoziTBXyrzaHMQ5oKhXmB9dmBAlN0QDQ4o881oSnl6cijUzyUYUwCtxyz?=
 =?us-ascii?Q?wRunaWzo0ntpZcmP86Q8Z5uVk7s6pVMF0k9UiByvaW02k4Xur8n7Q/IVCkO+?=
 =?us-ascii?Q?/ewxgoRPbjHbHaadlADls+djR3bI1WJIkdwgZOPWPA5o9wucG8RkWmA6iFuO?=
 =?us-ascii?Q?rRTkr4HAVztxoujMzBRZJKe8zLGVBUvcFwvOefkdTC0092Fzwq7iiqGQl565?=
 =?us-ascii?Q?t2Vp+mRJh5soY76Qi5hzDj3N50x0F/KBhFCGitrXVZcmwElIw5WIthxzBIbT?=
 =?us-ascii?Q?5ciIggWVzJ5IGPkQoGYhoY1xj4JKo4nQbNj/rWOrw5KblsKbcbSIc9nJSIPU?=
 =?us-ascii?Q?zb2ahOv6kc1mhDeb2Xh9W7UC46mG9Zovm1XZy7au8ls+YcfT9YrfJ0LNZwjn?=
 =?us-ascii?Q?RHeGk5H74K75eLl7baTfkIEXunt/kLDTKK/4Htr7Kdw0neIDcfypAh81T5B0?=
 =?us-ascii?Q?EAczvSj0axYlvJ59coHsHSFuiw5OPJgxQu/ro3zEFgu0WdX2UQtAX5BV9gGz?=
 =?us-ascii?Q?1OCpFvZ6dWeHe41jnmenopD6bYqlyI6ytoRdponh+q68wA0PgeN3muYsAEwM?=
 =?us-ascii?Q?WQy4wY5pdb+hp9W+j3gLyD7Q6WUdw+fw6NMolk0MHpGbQ12cjpqKM/OtS176?=
 =?us-ascii?Q?gQUWX9OsTRuZzOG3vo4dXzbWqGUgYqSvQsgyHYHFQ9CmWgXayH6yrKOoe04V?=
 =?us-ascii?Q?UzmtxGGc6//Ri9WWVBo8WWnJ3tcQQ3YiljMIiw2oGqVTlWcku8/HCYuY9JT2?=
 =?us-ascii?Q?HzCaorKO9BMlpmOlP01SGLBEqGkZF57Dl7sEAL57xAmDsa0Ugfw26op9zDSj?=
 =?us-ascii?Q?DIO5hfP2jzJTlKVqrR9yScXeEHJ6QhicTDKXRI30frpi3IbUdZOC5GswD2ME?=
 =?us-ascii?Q?sbbdgezYkItXSSnfOGqHxAlc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A+fQZWT+swp3Gv3Qgo1SU0QyyCN+rGcYOswOVEnCNq2J9DgpvL/eDGid5+6a?=
 =?us-ascii?Q?Yzm1nkXF/9iFzafvleVImHLe5YiQTEu1TJWIGEBCeuOD924fmdKshqLq+hit?=
 =?us-ascii?Q?/QVmrE6nTFDCvKdta0FRXw/DceLnHe2XpD5ppEM6T4gZ0wOhQQIOQl58xVhM?=
 =?us-ascii?Q?YKVbV7jfa7RFU7tAPFCG12eYOn/eG90uT8vqeqZZmMg2YLO0RaqM2l+m64ie?=
 =?us-ascii?Q?aBcvJNRMkP8jmbS9GFNA5RoAV+mE45j0QKVIHtpWhcODui9O5r6n22c7+VPD?=
 =?us-ascii?Q?u4AI2biUVKMjEwUVHdhQk4TOyEE0cxr0mYpjDdktEdXgsP2n00eAK65HHIcg?=
 =?us-ascii?Q?YAnsUYpvkVfPqQQzACxOS+yMLgR3zWO2uzrgX3JLJ6a+2Zcw/RuCBXxzXq6y?=
 =?us-ascii?Q?KuVNobAk1+62PE9ONQQNuh6Gvn9Io8ZS0ryQkQEYt3LoYZvUUB9c40qe66N4?=
 =?us-ascii?Q?w3FtfOLpUZ+7hS1z+VxW8Ljd3LPyRepodDYMlUwfDwYvHEIiLSz/0Az7+CzB?=
 =?us-ascii?Q?YDW/vYMglVst7awj83vbZIE/s5JFAAcYp5c6LWKn4y3c7us7PjxVtbQYJIF2?=
 =?us-ascii?Q?mu9kErEl7O8ev6U8Vgq9HiqYB5M2gpAiQ4crAuejzN/jTAgk2RYtkyNd6XNS?=
 =?us-ascii?Q?teYrZZ0n6q0xb5b1h2q+MkT+cWwk1/+1DYl6hx+sGlxEKpUp+FZ6R2Yz+Giw?=
 =?us-ascii?Q?Ng1oWiyWKmqPHA4MlMqrHCvkmjWp7d+pTVlhqQ6dYAhk3rkxHVjiNR+xhAfU?=
 =?us-ascii?Q?gPReUCcktplmBmF/iSldDshunl/5Lx/Ury2tV/qGcwojJjUrAmKRxqcctpAq?=
 =?us-ascii?Q?JJ811ClKBZ6ZlakW3EoepfMH2cliLbQb31CsdxxseTw9dU6R3Ke/zK6NkMv5?=
 =?us-ascii?Q?kUmrlZ1+qHgq/wCFgPCaIr34x/XHAxgStGIODfJu6PLqkNz+w2z0Vnh8GKJH?=
 =?us-ascii?Q?7NNJT8zJArTh0bx0Hq3GALEsCrvpO1w1eWUSQdLvFYySl85diqTtQ5Pjzw5t?=
 =?us-ascii?Q?wQnHG+WwS+InAuqMOGPhUqv6XpN1CZx2roaDoqErHpN4IgoX9DT4mrfNNTnR?=
 =?us-ascii?Q?rVg5qwxqzw2mHBZYJGA4s2ePe3CrlpV4STZ97D0q/1LvHpwDvIaDyxghhzYU?=
 =?us-ascii?Q?jEChoETb1m762JOG86G+yrw6kyOxZZey4c61RtKVYdL8qZ514Sh0jcQgd+y4?=
 =?us-ascii?Q?AdfhskRwF8viRrhhUronq/aHb8u3GEQTQGAguFXlDKBHI3OOaYzyzd2o2aCh?=
 =?us-ascii?Q?71HWgNlWD1HboC5oZIlpmYfQL2+Q3kDxqBTjnkf49Y/U6Ub5kd1ZdadBFiXm?=
 =?us-ascii?Q?Nkx4Wssv4GMNSpsv7yHKlxZu7EgZ3z2YkPXqgl5KuE8sEmdvcqQPrjHGfs/b?=
 =?us-ascii?Q?UYbQfRDJXZzwLZa9Nw1zqBIyJXwB4WVMB01sEe+ytWX4u0cUITge7idwDpMY?=
 =?us-ascii?Q?/I+tDWm2ccZm4RxO2j3773Xrx63F7YjSVT++iPorBMuJdb5AmqmXpUUOPZTy?=
 =?us-ascii?Q?IDOrsSYZr84FvTcx1Cb8aYU8jsj8kecoB3U/cA63Mb0MHvIdJTAy0O+aCHnJ?=
 =?us-ascii?Q?ovdalEFQhTmK/hJy1tXGM5sjf31kHe4wsfL39Es5XX5lK2/q9izReUof8Txh?=
 =?us-ascii?Q?nw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	og+/fJv/C2DylVvskFkW/6gSFif6XlvyXfn/wXHDSbvRqJ5GXV9ww24Xyy8dUKOUbtYBxIi0mybV3AXotsV5FPKs4aQksUaS1NZAEsCFuR+yEiCbzm9FHFwjSLuPogcGhixh0ajQtuG7HbQ0o3OJ7oPuvi8nATa7kvESzv15gyUOBAzKCNuaGQpciw/vPjsHgtQRx5Ln1xBbU/bMPxyns2cXsQDflXod991zkb2H2ps+sBfm5hb8+3JwJYYdTA1cswNDzjDpOVHQwl/Pjsa9/HcKKsPQG/8KrinyQlorZT4gtCR26Gp0qzpbDCMzfbIYbnOFGuk0i5emmKCfavONj9ihkuYa7rah1xQ0Yu4lvSdXPl6KLnqMZidfzTIpTRJpMPIu0MYZGmNVmRiZ1UVh05yw4I+fyTx+t/AJBxKiE3KOTo/oXmdRyCeJiTPwWFnPQ5nKPCG4PV+y80oIc4Qrlecw3g2XLnaPxhB9AFu/H6CX3UGLQX6ZxczmnuwRl73wXm6qPRksZHysvXhtiIVLOHzDBSpFTfnZkzTkylIAQj+GGKOc2Hm6R/c8rw4baVyz+4BXZrtWEUPCAhMfw+hfeEzK0BCOGTegZu7wSisreFM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 665a70db-9784-4bf5-6267-08dcee7eadcf
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 07:38:23.0294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IJgsjMeo31qwePWoAE7CL0CSufc4ye5hKihbTreWlehC4KGg8EUJfceFvPl0Gi2bdyuFPJdvnnz8GZ/3zM8rJu40IIdaoIZcA2+kgGm//Q0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4265
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_06,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410170050
X-Proofpoint-GUID: 4brYYYWKXZagmuBnTlw0KBUuYi6j5Clx
X-Proofpoint-ORIG-GUID: 4brYYYWKXZagmuBnTlw0KBUuYi6j5Clx

On Thu, Oct 17, 2024 at 12:17:23AM -0700, Andrew Morton wrote:
> On Mon,  7 Oct 2024 16:28:31 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> > Please note - I am intentionally holding off on cc'ing stable until we've
> > had a chance to be satisfied the series has stabilised in 6.12 as this is a
> > highly subtle change.
>
> What's the status here?  Should I upstream this?  With cc:stable?

Yes please, this very much needs upstreaming, and seems stable so please cc stable also.

Thanks!

