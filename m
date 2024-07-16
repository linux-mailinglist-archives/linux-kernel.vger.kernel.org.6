Return-Path: <linux-kernel+bounces-253971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E276932975
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 16:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 383961C209F5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 14:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45B219DF7A;
	Tue, 16 Jul 2024 14:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AGc1LUQv"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6314819DF77;
	Tue, 16 Jul 2024 14:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721140591; cv=none; b=MfFs+S7t5Nf48KTZvOq45CKWuuOaGuACCgVYwX49H6BzaLIQCCnWQyqP/Xj2LiQGKgMJ7hggBP6MwmPnJbeC35IkOSYPAOnxt99Tlcs8fE8NwEfMArQaSCuqV0YsmzZEvnJppG98Yo4oM7Dgx0W7noJAiIxLnxfpuyvsw4cutXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721140591; c=relaxed/simple;
	bh=cVBLJYeQ4Y93+llDXaQT2azxM9Oa16LXngchgJI+10Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GcjljV6Rxrm0gRzBccr9f3FH6tWATF/OtLT49F8HFqOEAX5/PdrwUtQ1b2D+Wne4nlbhbi5KxuomZN7mmbjF9K1FarFKn/iHpHgCGdXcoIk+roQ/FLcIq8vVgghndy3gCFgIpFPz4lv/B9AuyHQzXuA5nO+ZYHnO6a7IY9xFTsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AGc1LUQv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=5evkk+ddmqxAw9fwrmRt+qolzEFINFzdf+d6kxAKhJc=; b=AGc1LUQvnD4jjIo0vOeYHngP7D
	9VStVzSu/mte6PmaAZHnlDc+cZi2TDXvm5PuZXWwUrD4uVdx19Dn4WwR3bFj5054vmmq0fXByl8Ah
	oB8Fbt2goUrgJMJ7/2uV9g9bxEezjAt/W2EcRCtAuggJELX6UoBt9qBXmP2qhel0s2fnUXFkpKUVh
	ThPFaD/cGO1g/3XtLF3dNWQY6wcTuIalKgs5jRLsyv9UrIoieDOtbt130By61Xmh8Krh0bj7JjFTD
	7zPNfVDhgz1W0NX/kLiGlKOohl2DSh5MuWLbG6KtFUm04RRToQey44/6oe6VWh9dr2htgCg12Z08c
	J8+hHoeg==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTjI2-0000000Akx4-1OB9;
	Tue, 16 Jul 2024 14:36:26 +0000
Message-ID: <c81b25ec-3e6a-4b9b-8e3b-9991f1645d47@infradead.org>
Date: Tue, 16 Jul 2024 07:36:24 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hwmon: document: add gpd-fan
To: Cryolitia@gmail.com, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-doc@vger.kernel.org, Celeste Liu <CoelacanthusHex@gmail.com>,
 =?UTF-8?Q?Marcin_Str=C4=85gowski?= <marcin@stragowski.com>
References: <20240716-gpd_fan-v1-0-34051dd71a06@gmail.com>
 <20240716-gpd_fan-v1-2-34051dd71a06@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240716-gpd_fan-v1-2-34051dd71a06@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi--

On 7/16/24 4:49 AM, Cryolitia PukNgae via B4 Relay wrote:
> From: Cryolitia PukNgae <Cryolitia@gmail.com>
> 
> Add GPD fan driver document
> 
> Signed-off-by: Cryolitia PukNgae <Cryolitia@gmail.com>
> ---
>  Documentation/hwmon/gpd-fan.rst | 68 +++++++++++++++++++++++++++++++++++++++++
>  Documentation/hwmon/index.rst   |  1 +
>  MAINTAINERS                     |  1 +
>  3 files changed, 70 insertions(+)
> 
> diff --git a/Documentation/hwmon/gpd-fan.rst b/Documentation/hwmon/gpd-fan.rst
> new file mode 100644
> index 000000000000..0e5bb8b5feed
> --- /dev/null
> +++ b/Documentation/hwmon/gpd-fan.rst
> @@ -0,0 +1,68 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +Kernel driver gpd-fan
> +=========================
> +
> +Authors:
> +    - Cryolitia PukNgae <Cryolitia@gmail.com>
> +
> +Description:

No ending ':' above, please.

> +------------
> +
> +Handheld devices from GPD provide fan readings and fan control through
> +their embedded controllers.
> +
> +Supported devices
> +-----------------
> +
> +Currently the driver supports the following handhelds:
> +
> + - GPD Win Mini (7840U)
> + - GPD Win Mini (8840U)
> + - GPD Win Max 2
> + - GPD Win Max 2 2023 (7840U)
> + - GPD Win Max 2 2024 (8840U)
> + - GPD Win 4 (6800U)
> + - GPD Win 4 (7840U)
> +
> +Module parameters
> +-----------------
> +
> +gpd_fan_model
> +  Force specific which module quirk should be use.

                                                 used.

> +
> +   - wm2
> +       - GPD Win 4 (7840U)
> +       - GPD Win Max 2 (6800U)
> +       - GPD Win Max 2 2023 (7840U)
> +       - GPD Win Max 2 2024 (8840U)
> +   - win4
> +       - GPD Win 4 (6800U)
> +   - win_mini
> +       - GPD Win Mini (7840U)
> +       - GPD Win Mini (8840U)

so how is the module parameter used? like so?

   gpd_fan_model=wm2

> +
> +Sysfs entries
> +-------------
> +
> +The following attributes are supported:
> +
> +fan1_input
> +  Read Only. Reads current fan RMP.

Should that be                    RPM
?

> +
> +pwm1_enable
> +  Read Write. Enable manual fan control. Write "0" to disable control and run

     Read/Write
or
     Read-Write

> +  full speed. Write "1" to set to manual, write "2" to let the EC control decide
> +  fan speed. Read this attribute to see current status.
> +
> +pwm1
> +  Read Write. Read this attribute to see current duty cycle in the range [0-255].

     Read-Write
or
     Read/Write

> +  When pwm1_enable is set to "1" (manual) write any value in the range [0-255]
> +  to set fan speed.
> +
> +pwm1_mode
> +  Read Only. Should always be "1" by now to indicate the fan being under PWM mode.

                    Drop             by now

> +
> +update_interval
> +  Read Write. Set the interval in milliseconds to update fan speed. The default

     Read-Write
or
     Read/Write

> +  and minimum time is 1 second

-- 
~Randy

