Return-Path: <linux-kernel+bounces-444261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E12B9F0369
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 05:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE138188B2F2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 04:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9218718C01E;
	Fri, 13 Dec 2024 04:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IbIAjDI9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AQpw7ptb"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A00218BC26
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 04:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734062869; cv=fail; b=Z9L1HLQZh9B3AYwp5g8BHFCWFwIH3MJRPk9Ek2DU8VE49Iu841v4F57PIJrRa0MCsINLxeUASHZbeOj924y2HQm2ybUXlL3RXccLN1wrxsoUuzgCpgAAZlO2wWzOpWEgCJV8fUqtRFyts/hSh8KsQ8uOwIGIVqlqMFlpzFu7voc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734062869; c=relaxed/simple;
	bh=ornf5Kp53K37TbPbviijyBAd+DwCOzHhwk4gj01HTm4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BSq9vG37lQrPNl17Qyj7sJsCv55UU9XCucv/aeyMrYjsGC3v7Jkothb0yhJGgg+g8voiZrk5rdUxkh+Y/z1FhYGTGuOsBSg6DgX7dqJj+xzRWxN1r9uz8qrHYJeFI16WQFAgNn0HfCaQuUZvEEvpJW+MdmjBiW/ObiR55hu+I2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IbIAjDI9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AQpw7ptb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD1fo63023719;
	Fri, 13 Dec 2024 04:07:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=lnHUxIAmGE322q6BsYiHeXC3AlXMc+x3uGC+3fLGqV0=; b=
	IbIAjDI919Im6lY3yFdNMU7IXygxZtVuch1ckZoXiWtSUBT4/pFVrzdEhEJid2rn
	8vE48/7EDFVbzL0rdw84ap3P1XjfYRUxHfvTvOg/HClxTFOZgE/WbhA+/fLaF4RI
	l2ll8UV6IUTHJZ+ByW6qVQXVLHnDPdwCaa3bTSklm2ENpEofn8t5dabSvvlOwXnb
	HFKvcTOAnclYUjBOfNv6sx0+UrxsXdElvRFdnFHagV+sMgPUPEij41AgSSYMjloX
	W9k4+/XumeWMa0ajfxwxjmyOiFRcTH3C1SutTVNErXEuKv1lFtEPD2etrzhC0XeX
	kedNJnA28fMSCGm87Z6CJQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cewtcrvq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 04:07:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD1oeOM009411;
	Fri, 13 Dec 2024 04:07:29 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2047.outbound.protection.outlook.com [104.47.58.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cctc10n6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 04:07:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pr13ejnk4iPCnjvXz91is9wU/XW3DSLgU8+5ev7oQytw9GHL6ydl74QZJVYA+v/VL47Z0RzBBPPnDJOFjlpyjVdh5mNOXxQHxxkL4pIQqCoYe609qQpEuAJ4voj2iayz5qlpUmkkLIywb2XsHOLgrla714kyxAsIM93QnYdkn7qt1IUOrGcawe/3gOYQ2lz+h4W5JkkjJYV/oSQp2J3SScMjgN/y7uy2Yh5OwcDpKBZ9izzmtTtKw65rcvAoenOIMzy10/ZP8Q2Fik/quP51U8PBGsTD2FYwoSIv2EGCFbw1Ft9oe0EKqCV9C4otGwOmdIVyc8tBUk4LbWT9VU93ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnHUxIAmGE322q6BsYiHeXC3AlXMc+x3uGC+3fLGqV0=;
 b=cH8KdG5flbXfumY+0wj6uQRJUxV/TKSr6SSf/RvTett4RKaxfboVgZABvDNsyMg56TGLKfUroPZxErHuSCnR2UoN+DnyRP6j4urscUmVZdskL7JTStN8KpRKIKkgnzD8e3dHOqrOSmEOd9lAzxlf5uJBZbgTb2yRZpzyBMEK8Dhe0R/gUNeZOnbSqil62J1xvIeOgWLNsbiQqtdBhtNLj/Ym5az0f2rF6RBuLMBBneRtGtWXbeT4Z5d+gv4zAkpkVvec+c/YtqmE2kcrbxZoT7Epa/ekrigqt5x9y2Lzx4xm6uPEvKuldYTw2bIbJ6PEX2XnruwhtxurVvXvsYdXhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnHUxIAmGE322q6BsYiHeXC3AlXMc+x3uGC+3fLGqV0=;
 b=AQpw7ptbhIeR2AdBQ9lASIbI+k+kCAmo2BjkXNZ03m9ctvhyCpjs+Vg3h5DYbBIcrhtMH9rX1WRwmxmc2FE/KHAnblUkGmtGqSHVswQFLQg+3B6mxU5cpS4x2Yio/bV+92UAx3VXb0phPGN/8wBHaYHX/Q3e66/PJypTFP734lA=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH0PR10MB5848.namprd10.prod.outlook.com (2603:10b6:510:149::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 04:07:27 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%3]) with mapi id 15.20.8230.016; Fri, 13 Dec 2024
 04:07:27 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, tglx@linutronix.de, paulmck@kernel.org,
        mingo@kernel.org, bigeasy@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, frederic@kernel.org, ankur.a.arora@oracle.com,
        efault@gmx.de, sshegde@linux.ibm.com, boris.ostrovsky@oracle.com
Subject: [PATCH v3 7/7] rcu: limit PREEMPT_RCU configurations
Date: Thu, 12 Dec 2024 20:06:58 -0800
Message-Id: <20241213040658.2282640-8-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241213040658.2282640-1-ankur.a.arora@oracle.com>
References: <20241213040658.2282640-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN8PR04CA0041.namprd04.prod.outlook.com
 (2603:10b6:408:d4::15) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH0PR10MB5848:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c18e65a-ad7f-4596-0e32-08dd1b2ba7d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xXaPAUViumWKGjsxn3vj0VlMtX7RkY0zOETpCxBhKYd3qcjZfLHNs8tmrmGh?=
 =?us-ascii?Q?nW3ksgRRJcLjePD5gZIACWaQxt40p9Tz2k/QbuaWquG3gxxZ1Fid3pMvrZqz?=
 =?us-ascii?Q?Fgs1uZa6ulYT1P75Y6lAPrFRGcwMi4jHTMl45cJsAKYbt3otCBGIE11uvnyi?=
 =?us-ascii?Q?fWJQNITolcoDYZU/kQCUb+h/R9Vda3HPi6V1fH3hBFbTaVD+0gEvz8Wie2Rj?=
 =?us-ascii?Q?guIwry9IgGN3PfH/js1oJyRQhFoWf9+uQiSCsm7d+8W1cqassxSHOxnH9OqK?=
 =?us-ascii?Q?+WmWb0q1dZNbuSB0ia4o5rexMOTc3hCQ/Hr3ObuWW24iTkYX6BBT0giL18GJ?=
 =?us-ascii?Q?PtbK3VTvjAtJ0KJjJfC+dXzha8w3mMpUV85+fFulHYRQ2FE4nSHcUqT28COO?=
 =?us-ascii?Q?0bQVlMcULNL8OaX+ZblO7E9FkE3HqB4kvXDmbceEPm26qRhxIgkLhsyVwe5U?=
 =?us-ascii?Q?aA/5DtJ8myynefyG8S0G0n3ltxIvLWC6BXQvrJKLUf0GH7wkHsohi8UUIE7G?=
 =?us-ascii?Q?Uypvq4fc5i70BwfDtgzs9jZGNUiJEfOQ6amEM7w8sbEeWRXiT75xZF0nVFk2?=
 =?us-ascii?Q?N/JQ5rZQhK4NE2qCzaTvi0Q0FXaXLHZVVDLnkDQZg/X5vd3Dkvm7AEqTQzfN?=
 =?us-ascii?Q?e6rrGJYLpsPIuWxTMglKk1kcBSORN7rDUJfZkBG6NI4MwWk+eAxPd16HKX9s?=
 =?us-ascii?Q?b5+sFR/81Op11xPqRD7saUp4h4SqMUZDTNdav1W4KOCwJEnsJMZ0UdoIUdgv?=
 =?us-ascii?Q?WOv8uh5/21UaT07wDg1QmNCMcCDoqRYPgQNAvRygnmij0d3d7CbC49UqYMQG?=
 =?us-ascii?Q?YLgJ2BsPFfJj2SPWPBhxT4qOvWwafJVOHTDpwjfVXt3T/z1awPGovp7r/bf5?=
 =?us-ascii?Q?MQMOROQu1YX04fsrmfPwkemgyeqUZzgh+0xqqc/NgRTTi0GXNfZxu5Zr3Om4?=
 =?us-ascii?Q?15rGJ5p7V51zftbG0YUYIyDKqGGb1HUckuvkCWbQIEN9YjI5TCoGBuBdYC3+?=
 =?us-ascii?Q?aoM9GeBqKBmMwwUxHs8XQtF82NR37Ws4wI0qrom91avwnfVU7l8yZQIesCiz?=
 =?us-ascii?Q?yWfOwtplTDbZS0zXJtFjlvH0vXZ+pq+vyhyXRMj2yrsbQZkE9TUjZJbFrDFe?=
 =?us-ascii?Q?hzABF/N4TWbClxqEwI91j30R0AL28aelLfi/X0p7cIPxouqfiLGcBmZqrYL+?=
 =?us-ascii?Q?stjBBU6bbRyN2shi3beFkea/aTN7NZJS3Anh5j6l5Z0bo752GRLaf/8R/Pja?=
 =?us-ascii?Q?kAG2JYg5cuaI0nx8rNsSCNcJUb0Oat/2rysArMjs4HFjk6mHlwxp7KbVHXfO?=
 =?us-ascii?Q?GlMgDfwAjNYky4lYgTypprVlYH2H9CRO+UCCEWzbXj9VpspvEYx7UJqBdjrq?=
 =?us-ascii?Q?6Ibbd8DTkRKmjhrcG8RuXPpJRVYl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?joYMWrUCXmP1QQ7axL9+6HBKrHsqhQ/2+pArRWr93HWyqhocw7byG6WD+uP0?=
 =?us-ascii?Q?Aezma6AceKj0rveGFdf4xmlPXL8QK3RtWqbsfbqKZL85oGbXkKxt3FvvkbNF?=
 =?us-ascii?Q?UNVR0fdekfECRSOfvrdTTfcjr5yxoTvaj7zuJDSGx5Dr3es16lYAhcYc5og5?=
 =?us-ascii?Q?nAYUDzEaOp8t5tWFMr6KlNzBXikFBMbrhZ6cAWFxIJZaMfwJ0FBGnJj88vh8?=
 =?us-ascii?Q?vmFXfE9u0Vd94QQZszkDRjBM5kgWs3cjnhP30QD96fxQDkXyShLSrIYULKUi?=
 =?us-ascii?Q?S17LB4NBuOxdklMcIyNqlvQHhQyeph2XAw9/CJhbXMX+nRzicSAr4wR3NNt6?=
 =?us-ascii?Q?Li1hQDCLeNYlyCGyoK7/pskOi4bQfbuOjB+mpe2DqM+7wpftOjgUMCfTQ1R6?=
 =?us-ascii?Q?0lsCBp5OWje7pitJX9CMmf0FH1gR2YHL5sw/PPH5OzIN2W+O7PH7BFdVMSY1?=
 =?us-ascii?Q?aZwxq8tKSYeun/ZSvXwR8UY6tUvns1sxlQcF655awVSxW5XV+7R0xOFvEWJt?=
 =?us-ascii?Q?2NmmMVyrtgHtkfugm5GPekEpD7Y4Jk4JsAJsdgPD3RegowxrdcLsn9G6lJQV?=
 =?us-ascii?Q?wTKOps7KoPkBzpFtnXNK9QJV72JR9nGocU8nHgmO2aiG+BWrMYNdUPqW7fgG?=
 =?us-ascii?Q?Z710Au2Bdnazz/kX64TQpb6EwHGQgIGNfXkmYE5UtCW8uaPkvEuH2zoYFVO+?=
 =?us-ascii?Q?JPhCEhu08EawHf3/u7VWRhaGoU8fI6mNffQsA38oU2DNqWTFWpsRUvi/Qwbj?=
 =?us-ascii?Q?t5t2rFYOWkSHe7f0hqv+GWK7Shz3Ul7KUPsbLAyRCU8dVG54wTyVS/I05R2X?=
 =?us-ascii?Q?/IZU7I2Y1AY7Vq5psw5RS/Fq4Fh0tjT6CQt6gYgvKnbkpUXUrTwQV94mPdG7?=
 =?us-ascii?Q?iZ80DfDUsoWaQji8vmxJdinuSGHnY4OrDOpuQv2l9CMd2qMjcFPQTXQxzWkU?=
 =?us-ascii?Q?XK5zYji9h4ArxquXb2NenZE9JS+FJJRqwHHgKWDdew+ESILxoRiCaYyO1Off?=
 =?us-ascii?Q?YbgI/axeXHbcQ+7U18fjMJ/WTrNIo9TYJDmkKSNeTCg+9N/AYyLS2mb7k+27?=
 =?us-ascii?Q?GawwIZ7+qF1ALPEYlhdKcxN9xfaGLOmrF4xttkpYI41d9ua6C1fFICBQxUw1?=
 =?us-ascii?Q?34d1xy+H78GSZG9iH/w34cmJdoV9CZV++3xxHTe9FEHwXbJ/8Qw59Z919G8i?=
 =?us-ascii?Q?cZarPcdfFE/3o1XzEOamAu8ek5F0XYebDwLjAeWdh/g/fjg2eJ7fJCc0OhWm?=
 =?us-ascii?Q?gGoJuMpsts0ExosduWLZ8pWpW+vLZJYY/IQcdf7XcxzBsfE3ZohA8h3lAAeF?=
 =?us-ascii?Q?X9vv/CJGY1dbfHhS+fNX7vludlZfGEgH7hf0v+nEda1pgfbsKKjV0OrmwPyB?=
 =?us-ascii?Q?iBqsjWpk0qsy0CCIMYciY0q9l2aqXH+eZmA6rBPMqPfGDJBoURPAEqEekXjT?=
 =?us-ascii?Q?t4sDV1SMrWZlEOsloWc9wU7cux9uWF2DPd1y4xWlzLwhKwQvV1nd6qUncmV0?=
 =?us-ascii?Q?lew8wmIfHSiIK3pK/0zL4Zk1W1rJ272G/D2uOOwMxchZ+n+oOovF/yQUOFwQ?=
 =?us-ascii?Q?3tDrTFz587OMuP8Qi4l0mI/B+BdFXfeKj4CuZf/EZXo1pOmNZfxPWodfgPB+?=
 =?us-ascii?Q?Vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SS/uyrCITIXZx9IQzR8S1hp1DpkSAe4wkOmLuKne7qIOONHVoaYAJalq9ygD1zGEckZjboVNn0kqWjZhjNBPhu4MmhmCQvnQf8EcPeqD/a6Nn+8hx99P8ZmHIk0mApZj9fWIhm3OKQh/V53XjA7z1vfwa3SxrfH8KwflZwRoXjBUeVmCob4rLGXLB1QVSZUB2AIdGlIuCpP6ZZs4NbS1tUut6qLtCtXtoeTBAbEEA7+VkdxSPqnMKSYfTNie8FjpvzXc5jMlrjXbaAzatxxJoPlfRgKNtEO3b1UXgUYkgyCO2QaNNgDZIzE4tpbIfuFAzY/PxH+bMsiB3xTLr5lMvycYuPx2kDJag3JO80pkOyxjAfu3id725Gn1AZBXoEafIn92MhXz5HOPUESRLF14xTlqM12DjypAFS/+O2q47ho6hdRBMTH5LYLSfIvu9j19NYBlR8Gutoq/WOY2OUaQKq3/fEBR8xQnkAnH8qPrneickfjXDBfeo52ODzGwwSar6auYq6QD0apx/2wa83yABdirFXX6HFZZFSuoNdhQ0UpnSoC4733muJv1G6Ls37X/8W9o/V2+sJKGvhMCOC+mWstuQ5mNc1T4xkeAEvlwOLE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c18e65a-ad7f-4596-0e32-08dd1b2ba7d1
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 04:07:27.1250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hQTWhpit9QHyYRlEKln1Q6U6AQe6+FH2Sn7G1T/M33467j8RxkEtApYGrgDue+lmiDonN9vt9SwiHY1jdL06pB2CIrNsta4zFUvTOSxOCUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5848
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-13_01,2024-12-12_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412130029
X-Proofpoint-ORIG-GUID: F3OZO866Sqp32S4SBaE6LFiRzilikKvf
X-Proofpoint-GUID: F3OZO866Sqp32S4SBaE6LFiRzilikKvf

PREEMPT_LAZY can be enabled stand-alone or alongside PREEMPT_DYNAMIC
which allows for dynamic switching of preemption models.

The choice of PREEMPT_RCU or not, however, is fixed at compile time.

Given that PREEMPT_RCU makes some trade-offs to optimize for latency
as opposed to throughput, configurations with limited preemption
might prefer the stronger forward-progress guarantees of PREEMPT_RCU=n.

Accordingly, explicitly limit PREEMPT_RCU=y to the latency oriented
preemption models: PREEMPT, PREEMPT_RT, and the runtime configurable
model PREEMPT_DYNAMIC.

This means the throughput oriented models, PREEMPT_NONE,
PREEMPT_VOLUNTARY, and PREEMPT_LAZY will run with PREEMPT_RCU=n.

Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/rcu/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index e2206f3a070c..dd6251678e99 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -18,7 +18,7 @@ config TREE_RCU
 
 config PREEMPT_RCU
 	bool
-	default y if PREEMPTION
+	default y if (PREEMPT || PREEMPT_RT || PREEMPT_DYNAMIC)
 	select TREE_RCU
 	help
 	  This option selects the RCU implementation that is
-- 
2.43.5


