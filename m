Return-Path: <linux-kernel+bounces-340349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC73C9871EA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 113911C23345
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332391AD9D3;
	Thu, 26 Sep 2024 10:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inmusicbrands.com header.i=@inmusicbrands.com header.b="ZQsixcDH"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2104.outbound.protection.outlook.com [40.107.95.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95311AD416;
	Thu, 26 Sep 2024 10:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727347465; cv=fail; b=ooo2JFVxWOc8ODzU8jYa3z+/OgHhifUqeb8q/z04gRrgvjJkfjj+MsgfoFognYPz8zZCeEIQdUdUYCVg/tX8A0C0BGd0hWOwOvKuxIxClGcaRgeHw/wEQWlHkKHaWXBwTA6rwqn+Omi3XyFOeqB5V8oUC2cP19oClRIRgWUwagM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727347465; c=relaxed/simple;
	bh=dFoVSTXViHVpCWRtRzr6RjHEu91RU9r4brWLT7BpXjI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rhtkIaD0tWaDmjzUGBK1bk6/RlVSYp6pmrba+yigPV+PK3SsMvxYNNMAt9SzZSXPS/Cs8xK7faLSRMmGFVJScKPXyea8Rr/Q07YHohtl40oD9ywbgv9GskscQ86xZPnBLRhimOxZCrlOYu7arPCr95IRRRpTHi8KwUw+9JQzYmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inmusicbrands.com; spf=pass smtp.mailfrom=inmusicbrands.com; dkim=pass (1024-bit key) header.d=inmusicbrands.com header.i=@inmusicbrands.com header.b=ZQsixcDH; arc=fail smtp.client-ip=40.107.95.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inmusicbrands.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inmusicbrands.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SbFSoSD0VTwNQs+MXSKQVb1Eu/yF6xWP1eDxx8vVk+UizULzIqyas9CWdpnfiE0t10Db06KUMWPs7QMyTKJUDQciX/MGzClUmHj9ySTtPOGwIzewo6wihDgqHc3USDPMZmK77K3OqCxR3hPzI3WZj4X/SuOpAhSkpi5Yy+Rmir4/9QVKBGfbWScYXbX91HDLpqWBsvbkOYMKq1QOST80G7jh4KsapR2GDpHD94ci7KJYAG9123V4p9KcKJ7BzjrYINBz4lUAKr4cGsoDGabfKyBryJfB/woXTuRk0XgDONS+GVO6dMm7G435mzklaRWscF05uZb5NGtfy0rZwdRP4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/CoUEyLPqdyUI+PBq+uGlXaosEAqgWzTJPL4RwROkY=;
 b=pK8U1UOuM6RdjeUMepDiEKV8mZ0OsApcNrUQN2kDradA+qZNyokT6CWXWd/iuyl0zGCUUsocOj2Z5KXRdrJNLY2uR/k5oMNYg5pAr/pm878s8ZtP7qYESNV71vuKiLnwAgz5IxP2jhSqy+SkJ25QOHXPm8sUj4RS6YmjdhxroF9dOiAlcUwR+5kyAGk37vUt8uHKG8hKxHkmQhPAJ0R7n6HQr0b4KbI21VmYQOfrncUSfF5Gxg4XxNPyCfOrAvS29xgECqWGhLXbjiZxTG3VDletGWkkm81WysEy0GeHeIc3/8ru4KMywWC9b0URWXR+EU+63bp2PkkdnbQ7QZdmGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=inmusicbrands.com; dmarc=pass action=none
 header.from=inmusicbrands.com; dkim=pass header.d=inmusicbrands.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inmusicbrands.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/CoUEyLPqdyUI+PBq+uGlXaosEAqgWzTJPL4RwROkY=;
 b=ZQsixcDHwDurrU2qOJzAlbUQSTEJ8qM8PYum8GskYC5x0WkYco482M1oJXlKOBv+yq0vLfnaTnyuh65Zh3RdDHRxwTZAcEvFcbX8nSm9281cuDT+/rfRspwEpvOcGLBO7+qI3xBv0/dg8e1/02aCnziag3GqSywmFQF2WCD5ll4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=inmusicbrands.com;
Received: from MW4PR08MB8282.namprd08.prod.outlook.com (2603:10b6:303:1bd::18)
 by CO1PR08MB7000.namprd08.prod.outlook.com (2603:10b6:303:f3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Thu, 26 Sep
 2024 10:44:20 +0000
Received: from MW4PR08MB8282.namprd08.prod.outlook.com
 ([fe80::55b3:31f1:11c0:4401]) by MW4PR08MB8282.namprd08.prod.outlook.com
 ([fe80::55b3:31f1:11c0:4401%6]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 10:44:20 +0000
From: John Keeping <jkeeping@inmusicbrands.com>
To: linux-sound@vger.kernel.org
Cc: John Keeping <jkeeping@inmusicbrands.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alex Elder <elder@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Lee Jones <lee@kernel.org>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Daniel Kaehn <kaehndan@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: serial-generic: explicitly disable flow control
Date: Thu, 26 Sep 2024 11:44:03 +0100
Message-ID: <20240926104404.3527124-1-jkeeping@inmusicbrands.com>
X-Mailer: git-send-email 2.46.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0164.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::7) To MW4PR08MB8282.namprd08.prod.outlook.com
 (2603:10b6:303:1bd::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR08MB8282:EE_|CO1PR08MB7000:EE_
X-MS-Office365-Filtering-Correlation-Id: 37df8c2f-e9e0-46df-1be3-08dcde182d42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q07YJSMoI+bvef8PW1lvZl6/Nxje7ugbqoKC9ilDS1iAmPSsuh9OUaNiWHrg?=
 =?us-ascii?Q?BjBPUovlVKh0nASJYx/0cTmaGkwmMqzzb6LNqJUzTTsxOR5eVjFyFnn/fRMU?=
 =?us-ascii?Q?Fp+8AnV4Hy+uiJ9G4Ao7pUTrcRiAEg9vaidmxRqFmCzwUJkzHcqy8IOY13GA?=
 =?us-ascii?Q?GmFK2eFxMANQGXgK9+FIqCA/jsQ/2O8J57KVSuKGsdD+C1URyEIN/NaJ1X6p?=
 =?us-ascii?Q?gKmW8eCRYoQnfaGoXZ8TmhHxOKZK6FiiPBqD2Rdzd4KcDDVLsptTh5izZkPj?=
 =?us-ascii?Q?gbmND3YBNEeBbXJfflzA5L60WOTBWVboyAe0AecH0g5/zzUwonAwDGYaRzDE?=
 =?us-ascii?Q?w098mCSD7fekAm32hwWzE9cEGbPV8kUAIHDQhvLQuRzvJZRl3ORybhnmRoSS?=
 =?us-ascii?Q?8BlvFQAJhYG/nLB/C+l0HiqY4qQHqYVjPSqd7VL+SWubVk2QJQKhqdjWHEaK?=
 =?us-ascii?Q?HB+Py///jYuIyo/I2txB6wpAhmWAW1inidetZIhJNH7WjhnksKFPuxdKd9J2?=
 =?us-ascii?Q?fy/+ZwGqKoHrI03/zjavhJ3cIgxFzZEjgY4xtpf18jj9OsByZP5a4d+tOziy?=
 =?us-ascii?Q?S8V+uCpXyAwNxK/6iEY6yUJ96nsCH7VqIJak/ma1i8WO2lXu4D5KSLEYVz3h?=
 =?us-ascii?Q?9D6FVaH786UuOHmTSswVqBhCUU9AJO/qNRPJaYGj7QYTaPUp9rgN9NNL345e?=
 =?us-ascii?Q?6hnP8qyod3NL/uM/+GYhrZgKh+qgEgkDi68wMvJ0jN+wXrayLhT88Lq2HEer?=
 =?us-ascii?Q?FPADZGfPlX0djgqOpWaANE+i6RFOE0BDdLqRlozJrX86V3eKqZeMmFoIdsPf?=
 =?us-ascii?Q?eBvwhr8hdbS85zK0stZWB8boXkcCgODxjdYnvpKWlRKvkEN4JiOz6ePeIvcY?=
 =?us-ascii?Q?+BDdhN8vvB9z1gotCYDVm9f1gRmuyaDYvkDnkmWVa7Fb1c2jlgiP7yjnSv4o?=
 =?us-ascii?Q?1YtmLD9hgVqwphPfGy/WbLaDlbOR0FwhtfZuzspZhdoVbKSjW0NKBQKm8/Xq?=
 =?us-ascii?Q?Q8XbaykRovqXhP0Iie7oA8yNBT4bOW1a07AU3sTZ3X0fXx6GKngGTc4BTAzp?=
 =?us-ascii?Q?GXHJB1SJQHJXMPj+nr4wciEtiUrFdtPFPzywRALvRl9xd2ZNvxlrq4OBWe2U?=
 =?us-ascii?Q?AQNMxsLFF4WRSY+GItTYL0n/BHwfSmvQNKI17BrpcKfubIUrb9p73Obd273O?=
 =?us-ascii?Q?HS8YRi7oVwVtqAiqOqnIUR9l3DyK18MiBY8w2l2H7x/wSPsPNutObxmNOKkC?=
 =?us-ascii?Q?oVcCM6jj1mGE06uIkeQUV3WjVY/44jMaeQn8yRLin5GVXy1slsYnvcCOtXAj?=
 =?us-ascii?Q?zGFwMhAjZYjUpep7kI0y4tW1RBGwcuvOWDDEctoA4F+Vkw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR08MB8282.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zF9inagIA97p+L4K1ByJvvf6u6h0U4lzBUMJ7Do7m2B8j+DiBuImN2T9HLyj?=
 =?us-ascii?Q?YDI4cQJFKCz7XX+OOyHQqe+Wt2dA84rN4DcnHvVe6Swrzvg2IqpHD05dRiFw?=
 =?us-ascii?Q?JZbAKYGzS9113KbhTa8+l18TAxQMaON0Cbtv0kXJ7iLazpX9um4nM3poOLzk?=
 =?us-ascii?Q?gLlfc9WbeA9fjztlHnuKDuC8/Z8LfwDveumwHcylGZOuRbQt6xRcUzfzbV4I?=
 =?us-ascii?Q?3yWAuAKj+whIhAjuQ3Yxop2b7PE4XBpy0ew+2+qeGwnmUODuJA2/f8nafCIj?=
 =?us-ascii?Q?80jhgOd9Vey0+p2+ZPFJXJW4tHTJgv8jx+8Bh31uF8zVuxOwRL+M0Z8W7fVp?=
 =?us-ascii?Q?AgT84Ivxj/gDDUDF1/GGGyH8mnh8BK/Hc1fbgpo5A2qVEeqCLylwYGhg061G?=
 =?us-ascii?Q?nGuQtMjtETFyKYhxW6WJyBKT78TiHpwSaryT5gIO6mDj2ck8rAn3ZLMO46VN?=
 =?us-ascii?Q?RLCbPfuxTWzccoR0Qbx/ja7i3LdmgHtYorXFoDePDqYTwGtHH1bMEWSv78Iq?=
 =?us-ascii?Q?2vDhdruGqKf26eclo7DLGsFIqkqQ1/J4OOx+1obwr/Oep9Ymr6iI/hXF9Gg7?=
 =?us-ascii?Q?c5YIaR5zkCXeBDvcV1pOBJ4+sPrk7in31ZGiqjrPpdsfMzHnWSQYjSDpzgHs?=
 =?us-ascii?Q?maXWlk5OlG82UBXuwbRrz1hbcf+63a4lZhXlkVsRIti9VzwMFm+oBXEB53oJ?=
 =?us-ascii?Q?bBs349rNEwpBzAVbkJRjf6rL9Loa+VC5/f8OvVDVZmasMoALjgwCP9onnZDe?=
 =?us-ascii?Q?W1Eo1TAlDL7ya7hfIFRs1LH1GR3CPv9LM40DfQcfoOXHm5l9V+D/VX6iqmQB?=
 =?us-ascii?Q?E2y71VatDBbYJ6LCo87+XYzmuYnpdpO5yfPec2Vfvf6ZwSRs9risFvjpcQsD?=
 =?us-ascii?Q?6mjS/Q0ZQ8tWgTCwMpNWQ2hg4Qbkh/PHZotPdgJRAWJgf3jESLysCLGnlGQa?=
 =?us-ascii?Q?dMz0EX44NQw0EzU6rfphxXTCQamaaE+X7kgODDj1gzNo9wOx36iB8ecuC8XJ?=
 =?us-ascii?Q?d+7AQa9E9GiMnC256WSjCEkQQXVhAZ6cKPKUCeIoiD5LtZkZ6EFxoR2U5N/4?=
 =?us-ascii?Q?7chaKLXCn63taAXiqN4DLcAbqvwL4EmATrn5aqq7/Ce3B9WOlOPtnBMaA6+5?=
 =?us-ascii?Q?vmR+KnyivPF2VUHn61HKuv6kd/WNzrzFPJGJDhczQ3soTCjg2fk2Xrry546M?=
 =?us-ascii?Q?RUZWf0/viQLfBRxvkmbyUUPTS0OUJOB7wuN5UvHPy4aLC0ARXaYfhtm6xtsK?=
 =?us-ascii?Q?2l1Y5DW0iznKACPkbIBe7yYSllLYKLGVK+UWSp3q+q75Ey9Unf8tucyg56AF?=
 =?us-ascii?Q?MhlnAzc9w7i5B6udZSmZ2A9a96Bw5IseL+R8LMqS8h+u8shaVQvZTwwtXXzO?=
 =?us-ascii?Q?1mX7PT9sjLUPBcfk7niti3I5YZDY6DnbHcFRiUPcRmlcOAcQcLOTXwQKAfhY?=
 =?us-ascii?Q?k09RtLIxbpThDh3p+P4H4oDHzyz7NUf5MojD0acXygpDkJzSwT86yNvRD0Jf?=
 =?us-ascii?Q?cDWujH9LW+DG0GxnSebCVxVMfdRvriJpIMjJRtTrFcQ/Dl0DaUrrISIZvrFH?=
 =?us-ascii?Q?jH4aknfS8b9tsSGon14qYTV/K3zvCz6jAYxJe9a4SZjbYRZOinZSFrW+dG4K?=
 =?us-ascii?Q?xg=3D=3D?=
X-OriginatorOrg: inmusicbrands.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37df8c2f-e9e0-46df-1be3-08dcde182d42
X-MS-Exchange-CrossTenant-AuthSource: MW4PR08MB8282.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 10:44:20.2954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 24507e43-fb7c-4b60-ab03-f78fafaf0a65
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RXpiYjuaYZzXvZpQJWKddcWFhVuHB4ROnRP1PE1b4Q9t/fZvZUBK4Xgw9Az/Bbye8ZOsmL875JE6pd2raosjLusziQM5vDnkXrdMphNHOgY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR08MB7000

The serdev subsystem does not specify the default state of flow control
when opening a device.  Surveying other drivers using serdev shows the
vast majority of these set flow control explicitly after opening the
device.

MIDI does not use flow control, so ensure it is disabled.

Fixes: 542350509499f ("ALSA: Add generic serial MIDI driver using serial bus API")
Signed-off-by: John Keeping <jkeeping@inmusicbrands.com>
---
 sound/drivers/serial-generic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/drivers/serial-generic.c b/sound/drivers/serial-generic.c
index 36409a56c675e..322b5029ea49f 100644
--- a/sound/drivers/serial-generic.c
+++ b/sound/drivers/serial-generic.c
@@ -139,6 +139,8 @@ static int snd_serial_generic_ensure_serdev_open(struct snd_serial_generic *drvd
 			drvdata->baudrate, drvdata->card->shortname, actual_baud);
 	}
 
+	serdev_device_set_flow_control(drvdata->serdev, false);
+
 	return 0;
 }
 
-- 
2.46.2


