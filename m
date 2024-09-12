Return-Path: <linux-kernel+bounces-326954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C850D976F03
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 18:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E1431F21643
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CCB155744;
	Thu, 12 Sep 2024 16:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inmusicbrands.com header.i=@inmusicbrands.com header.b="aMN3wGLk"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2120.outbound.protection.outlook.com [40.107.236.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90481AC884;
	Thu, 12 Sep 2024 16:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726159519; cv=fail; b=MpOXDFYLa6Gyimgvqsn5WxZ3wE3vfvEVcehZ+4BUY8v9rPFhfLZ6Uzpkdj7FV+ePoBXEAckXxZrbqf+rLrptH3dogRlIsKIsB/jSXgTvAEVehLyXVkJ75D/RWLYLrCz8Oh99zkc1h1THgZT3Eqf8vEmx5NML9m8hgLYX2700nOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726159519; c=relaxed/simple;
	bh=BHuIJ96Gt4xd5uYMNw+aOkIRAJHxXqco1FOOCCbyFCk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AZfgrsFHRlVM09tlWE8rh+poHaxBoCChvnj3jsI4mBUfi89GsC5GCL325aLXgio4pCaTYnpJl74GbeXiLoTRu518foT/ighj17w+rrXHCcKsYoGiwPaBX0Wp9XMNhD3PKRc29OiXoHiLYSxeji6fanLUJm3tMRkbIbGSZ58Y+3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inmusicbrands.com; spf=pass smtp.mailfrom=inmusicbrands.com; dkim=pass (1024-bit key) header.d=inmusicbrands.com header.i=@inmusicbrands.com header.b=aMN3wGLk; arc=fail smtp.client-ip=40.107.236.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inmusicbrands.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inmusicbrands.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xwL7ZfNcSznYl2KGFbbJFqmc16uYOP4vcHhQAeaUU6Ku5vzm1Lz01ydy++hZM90INpcHQQ0NmHpAGjF5/fWhBeCi5WP5FrUZSA9z/Vy5VaOVw3/z+Chz8EttCQ4hDNy34roBoBrPLBw3cZgavTJeTLZU/ZGIojv82EmihrHZ0fuEvDNK3gK7fdisCb572w6Zxis0LPC5xAc8fAgyjYRvZPcmMSzIoNmzWHRmzpno97ldYUY3xZap8yMCMYwaB1AWaK/VeQAWvmYwZSNzxPwIdSfJ9CnaLzLozintqb7MXIbw4ftNrX07S6+ubIdXoX4lOrVRmdVOm1m+GahDXAUPZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKyPZwGbw7+gXm8WfcDvpyx1mDAyJq7LqIAzYkT3X1Y=;
 b=GrLl+UUKblenVWCppWbpMn2f3wixy2AR66sJdMn7YIAvO4xkjkE5skPobmD8LWtbyiJpDQA3mfxKhf6JpP4J+ASiEaSpatCki3lu+Lw8BVqzq+O0D8waC1L89rFNar0hLQPZTc283ABwENldtd9QvpaeqnmWoFDxl3A0MMb2JZELKcumgU3l7qda+a1U343vNxDwQvvx62qvuaxQmfjWxgphLkOksadwvAGf0OMG7k+YWfqF65bSpArs6nyi23szL5s9wOUs3QryXRBRaHjxMySC79ztYjDna0T5JiepLB62w5td7Qs2VWvlE8KN0D9Wk7c08c2J5asDl2K8RWvt9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=inmusicbrands.com; dmarc=pass action=none
 header.from=inmusicbrands.com; dkim=pass header.d=inmusicbrands.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inmusicbrands.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKyPZwGbw7+gXm8WfcDvpyx1mDAyJq7LqIAzYkT3X1Y=;
 b=aMN3wGLk1TP/iCDV5TxW+kVeMwrWLZbTX7gOoMQhZch+yflNWxW5gEDUHReqbJEPAVfioYnlzG43NwE15OE14bVwpAxpBtW02P8cGAa7h40zPAFS9Qhpnb+i0Sff15bT4Aw8R2V6XWVvyuD7Dr9ym2dS34+p9IY4k9tXli2LiKc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=inmusicbrands.com;
Received: from MW4PR08MB8282.namprd08.prod.outlook.com (2603:10b6:303:1bd::18)
 by SA1PR08MB7167.namprd08.prod.outlook.com (2603:10b6:806:185::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Thu, 12 Sep
 2024 16:45:14 +0000
Received: from MW4PR08MB8282.namprd08.prod.outlook.com
 ([fe80::55b3:31f1:11c0:4401]) by MW4PR08MB8282.namprd08.prod.outlook.com
 ([fe80::55b3:31f1:11c0:4401%6]) with mapi id 15.20.7939.017; Thu, 12 Sep 2024
 16:45:14 +0000
From: John Keeping <jkeeping@inmusicbrands.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: John Keeping <jkeeping@inmusicbrands.com>,
	Roy Luo <royluo@google.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Chris Wulff <crwulff@gmail.com>,
	yuan linyu <yuanlinyu@hihonor.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Krishna Kurapati <quic_kriskura@quicinc.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb: gadget: core: force synchronous registration
Date: Thu, 12 Sep 2024 17:45:00 +0100
Message-ID: <20240912164502.2134084-1-jkeeping@inmusicbrands.com>
X-Mailer: git-send-email 2.46.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0203.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::10) To MW4PR08MB8282.namprd08.prod.outlook.com
 (2603:10b6:303:1bd::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR08MB8282:EE_|SA1PR08MB7167:EE_
X-MS-Office365-Filtering-Correlation-Id: fcf82447-d69f-453d-1490-08dcd34a4663
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WL45x97t+121wuEfv1pYFrWmfLNqEEkKkxQcSKvCZoA5SgrJ8K3lIX1+eCgi?=
 =?us-ascii?Q?Dnes+2CuoFRBpV89KX2EgUgkrwMqq6qY2lXyWcI75R+AF5ie92vvzOx0Xj3a?=
 =?us-ascii?Q?bzXfzpb4bmm3qEmNVhDrQWdrdkQtXp2G+lTu4c8+oSVmzMaodHQVX1wwhWp4?=
 =?us-ascii?Q?84wbF5anyo1qGuSC/tIid4iojRG3/vm7yTTHSIqGp364RX5sB25T/QKvj45W?=
 =?us-ascii?Q?I/rPlRtfSwc4Y6pYvKe9ZqPqt8zsg0/g5xzeNSl3DHR0rWUhslQg3P8e+P1W?=
 =?us-ascii?Q?20aJloL1c7cWHDB3sP5VF7gPThh/ZGjsSpziHteLUxvQsTrvVWr8zKLxba2f?=
 =?us-ascii?Q?dWg0bIJhP+t45m8P7JvnGkmc4wqydqN/RwLFqH7+HDQpdwHhjzE7yuWaTe8I?=
 =?us-ascii?Q?WAV/M74mGdxBJz1F55Wx6l3LR51GsuSzj8B+biRUiBysTsKkF6MZVPmrGVTL?=
 =?us-ascii?Q?ZicYxPqhpM48N0P6ZoU80tPO5JtAK9Xh9pi+fZcFoz3Cje1JLALkEg3Hi+Nc?=
 =?us-ascii?Q?1ZuhmhiVo73+gHleVbSwG6lKqj4VRvvTqZGehBLd4aRI8+setLbLSlxnO02L?=
 =?us-ascii?Q?+Ii1NFoCN/1AkuazFQKxR3AVTjM3/Rh/pq4qor0axcfM0o5/zJlFmFMVyNjA?=
 =?us-ascii?Q?6sbXrU/4D1NyCanuGtN4cZh/C/ITvPNR8lCMmEXVjbEd+qYjBoPWTTxM6BJ4?=
 =?us-ascii?Q?lam0/5gs5NwiZTOR0QJouMFvpafb8jgiX0lTmJ9RPnTzMOGJNAj0opIbXGOh?=
 =?us-ascii?Q?VWYUJO01//7E0zBjPgjJ4gpKsfuKdDyFAV1wa50KVsotW9vgHs7GCrdo4COL?=
 =?us-ascii?Q?MGwVc2J4X5OhqnzU9eICFwuMSuv0oLQnKnCcw9OPI0lvlHkwjZIcppfKFJke?=
 =?us-ascii?Q?jpP5Cx/IZgiwymUDyD76SF20V4QonKcK4Ty8opxdbGW1cpmH1Rpl+hOz/X0r?=
 =?us-ascii?Q?kwuZkJ/K/nxApSy6VeNO71b/HTxf06CbKq+JQOTmAjob8uZogWSQIiMaTsGQ?=
 =?us-ascii?Q?kqa/jHVKESIXCu4nFRFBgk3x+HmZRLFAd0wi2Ias3RzEtDLHgpIEJdty8dhB?=
 =?us-ascii?Q?Nh+ZTdQAus907dwZ4X1eFnkLzn9xG03zkfbb+j1V7bhbBiTZk7QXKyHo7nTn?=
 =?us-ascii?Q?YPS0OFkc99ztBeLHYLzI+3u+cyx3dt5JLHkp8D9G7+pxoGzLNtj1LTktaaUu?=
 =?us-ascii?Q?IR450itqQ5mBhPpe8KhUdzT4FXfZUzKIeAj7VaU/jkzK2qmZhNjLzTDqWd0t?=
 =?us-ascii?Q?3A/6OxMpuTQhs6qxGf87XTiLWOuSh6u7/5uOeh6unOp06WQ8jHIgxJ/2/kl/?=
 =?us-ascii?Q?Vkra/egYMxQ9Q2LxMVzE5vklFe9kk7PN6/p4yajrjMxoRQJu2NVezvoRL0n7?=
 =?us-ascii?Q?pKxHyNJ+jO+LqKkPlcyxSLTy8fyNlQ656ovp7r1crCccBva+gA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR08MB8282.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KxijITHbbnev7CROiqZYa/7B/Ouhen2MTNbmxOCuzvHgKDMydjYx4lTte5Bw?=
 =?us-ascii?Q?TxHrB7LbV1yyKvGuqSvoRaQV+hj5gHc2JasKDz/v3HpkKTPSYTuBOk3fz8T0?=
 =?us-ascii?Q?YsSpWXe5zwtDjnOaZ26kymDPy++qD0NBdqi3frIhVbOn5HvVt/kaUB/nLogx?=
 =?us-ascii?Q?403umYoZEiJqiwoho7BH3lkZbxut6QW8YLZzjqhBxpXKocaiyeH2xDHKYTSy?=
 =?us-ascii?Q?RJCXVIon2N5kLRuIsf0qK4uRvEub7KcwPdA7hJs4gLoCifcTcmODhW5iXGup?=
 =?us-ascii?Q?FsStRxXhUSLKcZkD+Tvkx+DDsyYELB6nYm4f9Fam1M7qad4JzGjOYqN+8lgM?=
 =?us-ascii?Q?XOGx+L3MltuNAcI0lHasznlcu6XBooq4EkT+aBako8j38u3tIfbvRSD3ntSk?=
 =?us-ascii?Q?69n+aydwMUhRTEJAjxQ/Pb2mZyFHZTdhvCp9EHxU4FwQ0CoOYL7B76VVdv62?=
 =?us-ascii?Q?jSgnL/6F81mEwaVeRbI3X6Kgh2MJMVcRjn2oZt0ltzP3mPHVvotUTzDhQsP+?=
 =?us-ascii?Q?aRdequbj/fqKoqiDjA5YHsZLUYfE8EZHD6CX2eL9RxwOwtbloQCZ0HOHy0RY?=
 =?us-ascii?Q?c2BA1FlowmF+GfKITkT3l4/TUlnFP3BirwU+GPYeLmGwPCP6eXUaUudTlx2x?=
 =?us-ascii?Q?7mUsyZLWQ/JXD22ViOsPW3Xgm8f9q9bWzJnJsZxQhceL1thsPNWr8xYLORnX?=
 =?us-ascii?Q?y2vWUeb1ircfyuz9en7xdiI8mZfTqDPtDenotgoN5tueL9YEu7Z6jWtxVGtN?=
 =?us-ascii?Q?CtNw+SoXMllUedN0vhmDFePj7jjL+h122XXz0AeB8uma/WcRd+c3yhV6/mKU?=
 =?us-ascii?Q?ZEy03kJuLIlWGl2GIQRBowBGQDxs0S93uBogifNmStXB5H+Jif+GjcWjcKH8?=
 =?us-ascii?Q?LEV9UqJhxUuiw+Nseny4OWz2LXUDkFea56c5O1Y3YcJONEajY8OfrlcGmUb5?=
 =?us-ascii?Q?FUcZpNg4n51FF5f1KuOT1BMnZRIM4jpNJubZ1u3b7wPEO0WrWIq/dwCGPNIi?=
 =?us-ascii?Q?+bZ018IfYT2/a5kRnhcS0cfCc0JhB09uNJ+ZNgoYYXlBKGvCXZ9rvaZi6J6Y?=
 =?us-ascii?Q?QbIcZP+odh3Liwvy5/BV80dFHblKRESfrauJAy2NADDcdGBlApYv/dnpWzme?=
 =?us-ascii?Q?wIZ4ZjoQ9faWBZFHzkRMGhJzpWud4PoMVnciPKLcBjxM84wGMVxYiwnrs4lt?=
 =?us-ascii?Q?zFwS1fg5lFGSIiD3yhGJHKsMvUMzK09Qx7kb4BXC92o/fU20TpTvLEyIR71L?=
 =?us-ascii?Q?9vkwC68dxp/9Z2ChGSGzQJBqxwG3Qy+acnNGGt7lCUUayRFLBmPaJ1E8p0KB?=
 =?us-ascii?Q?FAnulqkhgbPU/YRkdeVTmlO4fhdxi+QhaIsWdYcfJctkR+V8iHZDDo+OObvY?=
 =?us-ascii?Q?vZrPqmcwlwrd6bvZ5kV0VmVGnJdf3NgRbuXLs3wMqrnpStiTiLv0nTvuTLJH?=
 =?us-ascii?Q?EmgTB99pBuVz2LmJ+7PP6VwG1ZuQ/VDuq7yR3rekJ+1yK9hAaXCykGrOdmjP?=
 =?us-ascii?Q?hOTEeA4vUB8NPcj8nABo+tH7zl7iWIZOs0yKQ7tfbB4KmAWxi9jvxCMwj7F/?=
 =?us-ascii?Q?BPpXRbvWRI1zXvlcgAMFa3BjnhXAnFsiMvuiaz4bB3w7B1UJ0ZqAgfyE6cBo?=
 =?us-ascii?Q?tQ=3D=3D?=
X-OriginatorOrg: inmusicbrands.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf82447-d69f-453d-1490-08dcd34a4663
X-MS-Exchange-CrossTenant-AuthSource: MW4PR08MB8282.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 16:45:14.4675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 24507e43-fb7c-4b60-ab03-f78fafaf0a65
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QM/AgBwxhlKyByLDH4aQraLFb8v5/PoN8JhDBMr0yQM7Ii6ToBSZ/fRG5JiqoyFahg6LRNesr73j1JVQoH1veQ1JhIfVJgvb4f/kV96njnM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR08MB7167

Registering a gadget driver is expected to complete synchronously and
immediately after calling driver_register() this function checks that
the driver has bound so as to return an error.

Set PROBE_FORCE_SYNCHRONOUS to ensure this is the case even when
asynchronous probing is set as the default.

Fixes: fc274c1e99731 ("USB: gadget: Add a new bus for gadgets")
Signed-off-by: John Keeping <jkeeping@inmusicbrands.com>
---
v2:
- Add "Fixes" trailer

 drivers/usb/gadget/udc/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index cf6478f97f4a3..a6f46364be65f 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -1696,6 +1696,7 @@ int usb_gadget_register_driver_owner(struct usb_gadget_driver *driver,
 	driver->driver.bus = &gadget_bus_type;
 	driver->driver.owner = owner;
 	driver->driver.mod_name = mod_name;
+	driver->driver.probe_type = PROBE_FORCE_SYNCHRONOUS;
 	ret = driver_register(&driver->driver);
 	if (ret) {
 		pr_warn("%s: driver registration failed: %d\n",
-- 
2.46.0


