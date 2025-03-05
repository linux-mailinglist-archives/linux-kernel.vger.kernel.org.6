Return-Path: <linux-kernel+bounces-547978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F1AA53E62
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A70116D7AE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B702066F2;
	Wed,  5 Mar 2025 23:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="iELWRdRC"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D7F20550F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 23:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741217114; cv=none; b=BweK0BOwIiIQ9SUOWMExMgiyzHL+rjN8ZVHGwuVykTUMzpt7YZHHbbFCsqzzy6XEqB5JiPg+CVhiTNB+7w0xLh6RlEOv/hek4tYH2B5e8XxpAbB1c1KOBuwbQkcC1NkPr0dToDIZfxukRvdY4Vj/GWQYOquUgRzVPLM0v5E5e+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741217114; c=relaxed/simple;
	bh=AnJYcyyPuSQ4pNrFrYAJyHf2ljozt32xk7TDdF8nbVM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IRKw8oOzSl0lQIX+wmBeaoMK7lLGv5zHPsjBbs9bsF/WY7oMuOPHI0hO/OsvMwP7nl45lqU6ViCxnH0pvpbsm6LESkeKED9GIMMoggPBMibzIIKsFLUp1kpqkLF/BfYAtOBG5Mzj/F0uUEACjvNUpJ0292+RZMwqS45EM2U7uak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=iELWRdRC; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3d2af701446so601165ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 15:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741217109; x=1741821909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7kX7Ef8fyaxBwW7MaGLY5EScGfcxKucjoKcRNwnL6E=;
        b=iELWRdRC3yglom12TSoFzTShH7ez6cj5DJdLwQpSMiCr1tpPRtvFGeejPnRu7U/bhy
         VLGZtGdbRNGNTFbt3UZMv5gblgZatnMJHyOmPVunM6IBx7PCKmiRHCwkmB2X9c9kK+i/
         WW+JqpkOMWi+51XeZbwKSS7AfratUMT0euXzAHdV/IFSos62bu+zbc1N8Q8HggxPcDfy
         ptRINXruGoTn85heQ2xEK2ZPR7sp+PS8Ru2FE6DUWlNgK1PHPYaThECuaOFBZ1qGFsZx
         /qfwcyOjf5at5fV4BpkgETZrVMXFQDV5+QlQwij2AP/NV73hakGO/NZlpjNRpY8pYN+i
         +yAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741217109; x=1741821909;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l7kX7Ef8fyaxBwW7MaGLY5EScGfcxKucjoKcRNwnL6E=;
        b=Xpbj9oc7+PqIHL8DqQ8proZ9cWO+VdMVQIzMWkzoATPd2ylNH7aPVE38KLytTGK9Ua
         roVWy+tbJkbyUssBGRx8DCc88/ypaww70md+I9xo/QQyvDVVJ6nQJieLKjiJUJCUPh7G
         dO8Cu3BSi5jtt+zFbkK9gQAf6lMCleW+jL7LXU5iEFUI4vHxK4H8YmTqWf/Dc7zJiKO5
         k7G60vZIh3wE8TZLUsdjItrIMBFCFUEnbqyZQl2z5Wz2oHwA9okjxEZTgfg4mnAK76q/
         DsQ4SQ0/B8k6BP/vyW5YqVTG2UShplLRqP0VmdmBl9RCQCfkGKYhfpUQp8IxZQO+9WXy
         SJXA==
X-Forwarded-Encrypted: i=1; AJvYcCV+NQ00AL29RnjXOMi2zl0EvcJvCxWP2nO8culFnNWyf5EQbWF/9CaVWXaovJES7GULx0UpyVQy+nw5EZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOzbYyGUVAYtXr6J5pttp6Z7jNhJY8yYUPHx7NMlQWrCjOglPH
	cvWjMTH7ktfDgnnam6ANnqaEcls/yIdZRuvxEVsPonHU75EP6D/sV1hnBZslFA0=
X-Gm-Gg: ASbGnctmyaqpH1ZAQzuWYVuV2cOoid8M6gz+7b9bjK/qE+098HejlBMGrfO+k48oJs2
	OVH2PuNnqkFzd6PvL2nguwuqcxQIlUGmTWfGl4N1Z+UUyEvt46sAB0kJyDTPVXjkzoHgkSJhPwP
	TKo/jiigqqswl+4VcQyeiKuMllSlq0logp0WMreAHDHsuj3vgVv/4WDLlOAecHTyqI3+sNCdaTa
	m78zm0D/uDOM9DcNaHU7Vokj5w1GHJMsOdrjJTBvPgSa2C/fPC9QzDWQp7yK24gnqEZ2k3q+Du/
	j+27NXGd8waI6AbzMFJ4c1xaLef10c4n0/p/
X-Google-Smtp-Source: AGHT+IFw7DOF2AlpkNGRt5nKYLzCwHXDlYJ9rI13bHT9B8yZEwsvGPw15V0L62f7x6TiXP73rO1Krw==
X-Received: by 2002:a92:c26d:0:b0:3d2:a637:d622 with SMTP id e9e14a558f8ab-3d42b8c1c5bmr71442235ab.12.1741217109024;
        Wed, 05 Mar 2025 15:25:09 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f209df3ea9sm17360173.27.2025.03.05.15.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 15:25:08 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: ming.lei@redhat.com, tj@kernel.org, josef@toxicpanda.com, 
 vgoyal@redhat.com, Yu Kuai <yukuai1@huaweicloud.com>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com, 
 yangerkun@huawei.com
In-Reply-To: <20250227120645.812815-1-yukuai1@huaweicloud.com>
References: <20250227120645.812815-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH v2] blk-throttle: fix lower bps rate by
 throtl_trim_slice()
Message-Id: <174121710777.165456.10255728984898278903.b4-ty@kernel.dk>
Date: Wed, 05 Mar 2025 16:25:07 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Thu, 27 Feb 2025 20:06:45 +0800, Yu Kuai wrote:
> The bio submission time may be a few jiffies more than the expected
> waiting time, due to 'extra_bytes' can't be divided in
> tg_within_bps_limit(), and also due to timer wakeup delay.
> In this case, adjust slice_start to jiffies will discard the extra wait time,
> causing lower rate than expected.
> 
> Current in-tree code already covers deviation by rounddown(), but turns
> out it is not enough, because jiffies - slice_start can be a multiple of
> throtl_slice.
> 
> [...]

Applied, thanks!

[1/1] blk-throttle: fix lower bps rate by throtl_trim_slice()
      commit: 29cb955934302a5da525db6b327c795572538426

Best regards,
-- 
Jens Axboe




