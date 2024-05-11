Return-Path: <linux-kernel+bounces-176615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5EB8C3233
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 17:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AFB81F21AE4
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 15:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFEB5647E;
	Sat, 11 May 2024 15:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="JTudANMZ"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2048.outbound.protection.outlook.com [40.92.20.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1761758B
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 15:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715442003; cv=fail; b=fjdVEuvKlDkAvEzr0oCbzVx6+YhBMeLzY5G30mmUuwGGSbSfypprNvKuW6la2bEvD5fzj0UNufs8aPzfyMjsRbRKowE4hOnafdPEdFxFy8lxqHE9EOXe7rv3AOcd4sfpAC8faUpcJ+QBf7qxMhaAf2RApWXNpKFdXXGfcXKy+hM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715442003; c=relaxed/simple;
	bh=dCLcl7KP5BA5YVreic23nJSp7Kfm/yf55It9YTyirqk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=uYOGjHKAdXJKREQSSX+z9AsSvEXnW0yRaoSxPCkiRt/JQ8vTWfjndnAjPY5VYxEQPy8KNl+Wjj5WUullhQxl/Bbaazidam51WYADgq5xtT6/necIjNZOLl0U4APv45InkyVaoRTwsPhjSXj75k952f7QjXe7erFOMuSdiirX1XY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=JTudANMZ; arc=fail smtp.client-ip=40.92.20.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mUzyGfFwYVR9EOHj9ibv4JMpJw6qPvVYAJBlhHOZBZFfxK7QI/RhkiWGdBdt+dF63GUf9kVCiqFLazr91c1GgLUBFLpPl8/q1xurHPVOJSXHHGlo44fTuJXe8RZ43Fje+pGo4wtwjXlYgTZXx7s+uD8pvV/7NytTRTOMwNKgjvucvoInvdFUbk3H8U5uMVE579apOhgy6n4oAxX+h8fWB0ke7Mv1lRfDHmEKTgNTQe2YEWuph6Fyqm3UHORBQu+qUOJQz3DYzPXyXnyb8s6XcbOKLgtaEak1uXQw1bpHBX495P/bNmPx5Thth4M5ylLG8RQeltq6yfy5gNwok/G1LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7f4uynIvVYErYvRnMWtwNPO4N7vH+ouVjoYTZddoEA=;
 b=ayIyJGSc+9x1nfn6kvPcXw0Jdsc1xLZhwB1wIBUtrshuDRT5sKAGdyLxPsKpz7dWr92rqQpjLa1/2PPllOjegP+mqbYkVxOj1bNBZ7z5y8+QA6G7ZZEGXAJYN8tpB88DbKJ16XcyP9KqAvy0tzXL9SgVDqpbADEJuNwHF/sVBrbjrX07YMC5Zs+nZ+Le1tzSypiU9JQX81WlYcusWcZK2mBRUMs10tI7gL/TIOLDCXkbaoABHcknU9yQvWxflYBKoDjXepRwUenP8ANCFfvxR2bNFkuJiuwq4ONZFh3plfJF3H71uMSKFv0NUZcaIo3QPD4W8fAdKzzTkClwCL+Tjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7f4uynIvVYErYvRnMWtwNPO4N7vH+ouVjoYTZddoEA=;
 b=JTudANMZyJyttrBN3jBgINB6lV1jHwRrlyYhAs0Ej3tK5eV+PtVZnEklohHCq1v1995n2LJyTuNKFzn1FTbjRK5y9vnIUpDVezCTewCTrzz3+pVCmMpskURhmoM/2hakdKWqB7pMmCtq3QHw1wMgQLIH1WpWdyDGxQklgQLSSf/Q4kR3VFd7ZYgQT9Ct6eM0m1V33cQ2O/8TlB+wjLY79UONd+PTwdvftuxp/vSB3IVYn+g0eJBESxcmm/gPnRRtcNHkn8uZ3OvAIEwt5S/l96stLdHErJaj/5has+1BwVVAILNjpScLepCcPeqv9iVBQnjEhDfzdzYKh5TlmWGCyA==
Received: from BYAPR03MB4168.namprd03.prod.outlook.com (2603:10b6:a03:78::23)
 by SA1PR03MB6500.namprd03.prod.outlook.com (2603:10b6:806:1c7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.54; Sat, 11 May
 2024 15:39:53 +0000
Received: from BYAPR03MB4168.namprd03.prod.outlook.com
 ([fe80::b8b1:7fdc:95d4:238a]) by BYAPR03MB4168.namprd03.prod.outlook.com
 ([fe80::b8b1:7fdc:95d4:238a%6]) with mapi id 15.20.7544.052; Sat, 11 May 2024
 15:39:53 +0000
From: Jiasheng Jiang <jiashengjiangcool@outlook.com>
To: jani.nikula@linux.intel.com,
	joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com,
	tursulin@ursulin.net,
	airlied@gmail.com,
	daniel@ffwll.ch,
	chris@chris-wilson.co.uk
Cc: intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Jiasheng Jiang <jiasheng@purdue.edu>
Subject: [PATCH] drm/i915: Correct error handler
Date: Sat, 11 May 2024 15:39:44 +0000
Message-ID:
 <BYAPR03MB4168128CFE29DF3ECB029EC7ADE02@BYAPR03MB4168.namprd03.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [u03Cg56Kyiw0k4AYqB1HkbCyxfSX9Xk7]
X-ClientProxiedBy: CH2PR07CA0043.namprd07.prod.outlook.com
 (2603:10b6:610:5b::17) To BYAPR03MB4168.namprd03.prod.outlook.com
 (2603:10b6:a03:78::23)
X-Microsoft-Original-Message-ID:
 <20240511153944.38442-1-jiashengjiangcool@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB4168:EE_|SA1PR03MB6500:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d862075-b8c1-4ab2-50a5-08dc71d09990
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|440099019|3412199016|3430499023|3420499023;
X-Microsoft-Antispam-Message-Info:
	rlA+cyiDyZD6kn5UooEhG41vlmK60EX+E62rGvrDYZ/QYGFuAGAAzBMdkPNr2ok+m0GBPWgQW9PE4TNv8dQnjv+uluciPoWw4jafnKWMCRUooIGKt/SQTvmXp33Q+0flTFwH4jN+9WvdDmbcqhm43wThkDOR84XOSgy5F980IbusvX2GjWlSvfKvAi2kwuthPkpcBthY7PQU5OgbNUHnW0NzDFZnnIFPkGA4lFN2YltDdxqNYe6fKsNeC+kj6ST6ANmrkzNF7td7cCxilS8c9kppQRWkbPtpSh5p4CZAbBI6eR0Ym41qoKj8v1LjlQJVI1KIOrGumGpnh6XIHtJiQgaq5KiNOGIUavizeqji28GBZZovQ8/0OQReudt7BkyoXAnWCmqyjvsFgUtmdxFaGx+yJ543NHk+dpC1X8JMA/G5wtcrFP7YKx9WrQPNXUjEUpWNysalLgNYtJM/ZpA8khdA5yNGuSmhO7YmvIqyLugTEcdZZs5BN16FlucZ1J6UW/zn2FU5ph43P9sRaPW3mugCZ4gplWpaN0xQE6njcoGPL+zfvWRZSvbOcbbgYDF1
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wqdTzo2iJTbcJAGi49+uO/RMqBKuhBp1RKy2SNX5wrB+VciyQMT2FEas2w/P?=
 =?us-ascii?Q?NGOrzZ9KyKxWWs52Gqh4ftumANJ3pEd8jkH4+VuJxAQ5ReAYS6/CUPi2amjg?=
 =?us-ascii?Q?reBW9puynwTg9O0AhTa/30QPYY3NL3Q9Fi3Y3/Ms+Z+NOYQEcF0RI3dpwPKl?=
 =?us-ascii?Q?62oGc1Nq22h2E3UQngH88jnV3hI9Ubx+20ShRvINuuzN9XPQjUUX4citM09V?=
 =?us-ascii?Q?9gFiB8Xk1KSSgMj6F+AvRytLdrVhfUSD++mJ0fqCgxYqvmFjhd206F5cnItP?=
 =?us-ascii?Q?yfriBb3eA9fBX8eQnzvYj9HrD/LN9uCsTa+5tw9Okq9cTfvixqRdiXz0QttK?=
 =?us-ascii?Q?Inde3s1MChVqCuh/tPtIC3XKktVEu6DftxleG8S9tP+z4G0e6pYfYep6jZsf?=
 =?us-ascii?Q?uqAR9ZzrZtKV5ejfgpc0YdgZpUqgSOaY6dotZD9TJ9awEKKdxV/JOexb2QLw?=
 =?us-ascii?Q?0TjWaRIK4soFG/E5jDa1egS0sL8gEBxUrMW1mNv3Qp9upAOkTFG2ZtnUtbV9?=
 =?us-ascii?Q?uIhnb+A5F+AyFjOw2GdsI4Qd61uocljPCo9kdkLAunxjAnG4olDu7VkKAzQP?=
 =?us-ascii?Q?qcRlkLs8YZG8X3rlh1pGlzApoWtY18itgA0gEjMcyZbDuDZMlB9g0RelGReE?=
 =?us-ascii?Q?0m/2/foxqm35y8cbb9jFN02T/bo6RpsWdGo1Irjb95xT5CcMYLAw3gXiKU5T?=
 =?us-ascii?Q?Ww4CClCP6LjOe080T614g6hZ/4LEbmAYdG1Z+NlQWtV+Wv+v8Y7Gi69+KCwO?=
 =?us-ascii?Q?9aG74QIO4xZ1RxhH5XEI2iLUHwxILUYv++MQu3v5xgUjoWBX2O13YfoT3vSI?=
 =?us-ascii?Q?ZyEmxUteDRBgBNRC4DFVwzNn6vi4UCHBkD5MTsCNZW/Ay0EqbamgXHWn7Cmg?=
 =?us-ascii?Q?i3QDI8i0jC4N9EB2rEg6ECZFJj6Z8sK0XCbMP2aHg8m9thNcmKi451w10Au9?=
 =?us-ascii?Q?dCzKCNGU1XCHVvzZAdFznq7hPQC+lBdl40nlEIh/+ojzp9gjvClrC48kcdhU?=
 =?us-ascii?Q?HnC982slVKv8XD/6lcN1u6zKgB4IKzn77VkrdDbrwCdYGH4A9jzXTsbuKVl9?=
 =?us-ascii?Q?QKgiZhzwQZddw4B+SW4UTKswKe+uc9SObGIUdqxNXdES9CGdz6rjb4zwhjKo?=
 =?us-ascii?Q?iOImu2ZsFvK0gRO0y7NEdUXUYcXSf3uN4pDxErB1Ie7eocmcaqieY3CddNrM?=
 =?us-ascii?Q?7VRPY1PRhBj7S3mvzkRqwz+SvQFZfh2V2bbxmVmjjON+HrvIinrmyJdWSUj2?=
 =?us-ascii?Q?nlCuidjLMLTOJQ60Aoib?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d862075-b8c1-4ab2-50a5-08dc71d09990
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB4168.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2024 15:39:52.5385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6500

From: Jiasheng Jiang <jiasheng@purdue.edu>

Replace "slab_priorities" with "slab_dependencies" in the error handler
to avoid memory leak.

Fixes: 32eb6bcfdda9 ("drm/i915: Make request allocation caches global")
Signed-off-by: Jiasheng Jiang <jiasheng@purdue.edu>
---
 drivers/gpu/drm/i915/i915_scheduler.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_scheduler.c b/drivers/gpu/drm/i915/i915_scheduler.c
index 762127dd56c5..70a854557e6e 100644
--- a/drivers/gpu/drm/i915/i915_scheduler.c
+++ b/drivers/gpu/drm/i915/i915_scheduler.c
@@ -506,6 +506,6 @@ int __init i915_scheduler_module_init(void)
 	return 0;
 
 err_priorities:
-	kmem_cache_destroy(slab_priorities);
+	kmem_cache_destroy(slab_dependencies);
 	return -ENOMEM;
 }
-- 
2.25.1


