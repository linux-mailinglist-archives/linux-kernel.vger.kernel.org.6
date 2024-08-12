Return-Path: <linux-kernel+bounces-282760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A6994E846
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72BEC1F24908
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 08:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387B81662E4;
	Mon, 12 Aug 2024 08:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="hWzz9UkX"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B145A166314
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 08:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723450209; cv=none; b=b2ktjq5sC7mkMMjJTz908qKAmbLL+926t/cRdXiKEwN562UJSD8+k63y1m3ypM2IG+y13sncIjrN2oZh6IeEeSm08/7l5GgQkyQf00SupqvEhGzIv8neq9NETP2SvmrW7v1iv2XeniflHYzGG7yj/v3DbBcwg4GIFc+gICkb8ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723450209; c=relaxed/simple;
	bh=Yx4cqZlUQY95wHNtdSfcc7xdE80Yiwz/eqS6GuCZYzY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=r5ADDM64ln2yn9VSBMLAtSRsz50ktyUYPdC79p0K/GV3bkzD2K3OG8qP7DOnQRJsa8EX18qPSON4ymSGy14Mss4ZS7Z8PJ03c9eWRQAD0zMkRjniByVHYkXUr9j0IbcVlBiJKQue75mOs+SwIQKfI9ge7nta8xvM8FiE9gk62rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=hWzz9UkX; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5b7b6a30454so4556006a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 01:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1723450206; x=1724055006; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eumFNOJne5NIDDbkH7iIANtwFA++5/Wf3m3xmLWbJ2E=;
        b=hWzz9UkXv6eBH5ekOokqSBwlr6AM9V4ujZQn1BY3A1aXX/NhK9+xpqZBMjwBwGEhwB
         kXcRJ1R3+H16qyoACQeCRvra3GSbGXeFC4PQJ2RBrpEgwFe0xn7iUvZKfeFfJrSO9kKo
         WZeEGQAcDTJ1N7FTclNZ/Q63bamnwhzUi/+as=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723450206; x=1724055006;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eumFNOJne5NIDDbkH7iIANtwFA++5/Wf3m3xmLWbJ2E=;
        b=fz0G8G3k+CdYCEv5SS4gw+/bkw779s9EDt9IucMDFJMIN34o28BhQ1NF7AtGR2U54E
         HIMF7AhaQ3DLOc6t/lHfsRImzJp9WuQ6xCGYLHxUtNu6o2qFY9MOe8t6nFYa2QzsnFwM
         IbaYZP/kU2OQzUw2z6Bj2st/YTpbxdkxbKepY2iFR/A5L54XTtjub721/JuVD+Uqy7YC
         ftbHquqHVDHvVt59r9RZix/h4drdXDqrT8GlFRfgtc8LGwxVCZdA/3qnmFPi8YeQI9ap
         rvAi2pJmG/0XDXZXQk+wX7y4pR8Tdj8EetauO7Hq62J6GVEenXB5fbRr9ovGAUZCPcQX
         IbLA==
X-Gm-Message-State: AOJu0YyUTkj9tsTutSJg9zRPGh31dVO4vsToBu6rZw7YA9TAn0zJ4b/J
	3IYLfGZt6B9O0Oq/wjz+/Tfaxr98UMAIs8NsBLETzZfNQsQRRONpTcYryvEvfNndQhsnk4ZQ/yl
	om9ETmgnLy8tWMtfV+gvKZRLWZ3aqU9CfhDw5aP9LA8khk/lycLwtHA==
X-Google-Smtp-Source: AGHT+IH0gPjRDANyYWX+DhWvpiyGiiO7Tq/G8rad0ElwLuflFVzA+gmB6H5l3bJxyBGRIQthjqqDnrrIjihLfJnQbNQ=
X-Received: by 2002:a17:907:3fa4:b0:a77:bfca:da57 with SMTP id
 a640c23a62f3a-a80aa65cf9cmr607005066b.44.1723450205621; Mon, 12 Aug 2024
 01:10:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 12 Aug 2024 10:09:54 +0200
Message-ID: <CAOf5uw=r_eZs6d93bqposDfgcBvax+ZUC865g-H2BwC5g3Hdxw@mail.gmail.com>
Subject: imx6q random crashing using 4 cpus
To: LKML <linux-kernel@vger.kernel.org>, NXP Linux Team <Linux-imx@nxp.com>, 
	Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi all

I'm getting random crashes including segmentation fault of service if
I boot a custom imx6q design with all the cpus (nr_cpus=3 works). I
did not find anyone that were raising this problem in the past but I
would like to know if you get this in your experience. The revision
silicon is 1.6 for imx6q

I have tested

6.10.3
6.6

I have tested to remove idle state, increase the voltage core etc.
Those cpus are industrial
grade and they can run up to 800Mhz

All kernels look ok if I reduce the number of cpus. Some of the
backtrace for instance

[  OK  ] Stopped target Preparation for Network.
[  134.671302] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[  134.677247] rcu:     2-...0: (1 GPs behind) idle=3c74/1/0x40000000
softirq=1197/1201 fqs=421
[  134.685445] rcu:     (detected by 0, t=2106 jiffies, g=1449, q=175 ncpus=4)
[  134.692158] Sending NMI from CPU 0 to CPUs 2:
[  144.696530] rcu: rcu_sched kthread starved for 995 jiffies! g1449
f0x0 RCU_GP_DOING_FQS(6) ->state=0x0 ->cpu=1
[  144.706543] rcu:     Unless rcu_sched kthread gets sufficient CPU
time, OOM is now expected behavior.
[  144.715506] rcu: RCU grace-period kthread stack dump:
[  144.720563] task:rcu_sched       state:I stack:0     pid:14
tgid:14    ppid:2      flags:0x00000000
[  144.729890] Call trace:
[  144.729902]  __schedule from schedule+0x24/0x90
[  144.737008]  schedule from schedule_timeout+0x88/0x100
[  144.742175]  schedule_timeout from rcu_gp_fqs_loop+0xec/0x4c4
[  144.747955]  rcu_gp_fqs_loop from rcu_gp_kthread+0xc4/0x154
[  144.753556]  rcu_gp_kthread from kthread+0xdc/0xfc
[  144.758381]  kthread from ret_from_fork+0x14/0x20
[  144.763108] Exception stack(0xf0875fb0 to 0xf0875ff8)
[  144.768172] 5fa0:                                     00000000
00000000 00000000 00000000
[  144.776360] 5fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[  144.784546] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[  144.791169] rcu: Stack dump where RCU GP kthread last ran:
[  144.796659] Sending NMI from CPU 0 to CPUs 1:
[  144.801027] NMI backtrace for cpu 1 skipped: idling at
default_idle_call+0x28/0x3c
[  144.809643] sysrq: This sysrq operation is disabled.

What I'm trying to figure out what could be the problem but I don't
have similar reference

Michael

--
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com

