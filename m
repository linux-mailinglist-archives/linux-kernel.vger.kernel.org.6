Return-Path: <linux-kernel+bounces-395155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F139BB956
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 16:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E711B22DAC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 15:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4DD1C07CA;
	Mon,  4 Nov 2024 15:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sXoIwJw6"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD811BFE06
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 15:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730735221; cv=none; b=hW9d5TXMgiFUoj4KLaawWBeSO9fTIkkmsPDNqQCDr1/d2/o6QVvCE5cicPpVMnonhzQ6g93ZPkbndC0uHaHgJBUCOrb7s6Q/7om/tNnVeaEuJCRbIzWhQn1AkEJyViqGpfElSd86s39Vx0OqrWWkkZpJvVbIGWeAbZBdGGmAc14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730735221; c=relaxed/simple;
	bh=7XmTWdceA789zLXRDCy9DLVqjaGLuwNNTr6M1f+t4u4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Sq5aoux0aRqaybqXHYw2mUlSqTnbiRtFjok809xb00NoOyoYFbvmsdvHT9z5ATt0mboyFknntzm5+ZZ/dCPfcIOWSzpXOZMQZ3+iF8V/839DrYbqQCcF4qDkj95NZ3OzeSJSSbyZvKGROzWz8oA49cCOJaWVNCTjjUWq/Wu5Mfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sXoIwJw6; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-431ac30d379so35988425e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 07:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730735218; x=1731340018; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L0O/k0EM991owPzjT/uFEDXi5Uv5lxapfhPAtizM5tQ=;
        b=sXoIwJw68Em5VCCfUledMxeQwkUHl/uKbJXtUkE1HRCii69EPMjvEGb4cqbfu58nqF
         6ezsutXX+k3w6Lzjw6UgtrEFwohncO3b5UXROlHyn/hjQ5RQua2QkRaRg/l22kx8y8NJ
         bPhgNiQQ25VklLoGWzv82X815murBchnCyBuKOJlSpxc/Hp1cWSNovzxOKuO/8AEnazG
         XqD8OwmyK6k6JpWgAPz/oS6Ed+P52Hs8HVxvzNbvS2Rg/psMCf1+uPc1XvSY/krwJbqg
         6QNeCqWrFUduCeadP40NxwiZOAhors/PsPizxd3WOJnMOpqU41Bq6hcKkliY4S9Jcar3
         oz0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730735218; x=1731340018;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L0O/k0EM991owPzjT/uFEDXi5Uv5lxapfhPAtizM5tQ=;
        b=joPtnzzgs3e9+enkxK9swdx2VsowLcAOWByKge2wkyMR1KMZJzG1Q5B2LNH+hfAqye
         EVvCF+9C8Ah/SJWavgtokHptrFfSSbzuQ+YSNeVcZ8i9ABY8/y3m0B40tW5hhmKCYlWn
         W6ZVHKBuqVlLKjVkeBaZMaSk2Fsbju/zZrotaaVZFdKzgDfOIcXht9zWNpoJMAN0F34O
         XtiSW3J9Qx8gCFMm/qvKnyOyY7BO7lFc5vwwrHDmCa3ypTxtqeM9mCeudC7IcEvHf5d5
         fPwWkXljnbjKDhMM2mKVHS82d6eeoiShLuAxo6TQGLpvn3GDAIJQJgXPGDavlv51LIzn
         iGpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAgLx3p6YolYaqQSYfbIVUZrFzLf3E0erZsvMyVW8SHL5VET/XWMDqYWZ2ZOadU29mpacC8lLkVIDMFNg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5uPshrAI171LrGgH9J8sJJLfIhnDXKjbJt7hmVx2g0NZe1gxl
	7RQpUZixNJe9yDTO9/Gk1CMa4h7PXm1mHGsYvjfgvE66AlotPyCz8u0xZl4e58U=
X-Google-Smtp-Source: AGHT+IEEkmyb929yUsKBTEGLefZsiht4G9EaaDSos9y3xQ19pNJEeb6GbSex7MiyikkDMd5O9bFYbA==
X-Received: by 2002:a05:600c:1d16:b0:42e:d4a2:ce67 with SMTP id 5b1f17b1804b1-431ae9c440cmr263039545e9.17.1730735218216;
        Mon, 04 Nov 2024 07:46:58 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4327d5ac002sm156886735e9.5.2024.11.04.07.46.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 07:46:57 -0800 (PST)
Message-ID: <9133c24d-a425-4c66-ab0d-31876730bfd3@linaro.org>
Date: Mon, 4 Nov 2024 16:46:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lukasz Luba <Lukasz.Luba@arm.com>,
 Linux PM mailing list <linux-pm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Emil Dahl Juhl <emdj@bang-olufsen.dk>, Icenowy Zheng <icenowy@aosc.io>,
 zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] thermal drivers fixes for v6.12
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Rafael,

please consider the following fixes for v6.12-rc7.

I wanted to send the PR last week but I've been busy with other tasks, 
sorry for that.

The following changes since commit 59b723cd2adbac2a34fc8e12c74ae26ae45bf230:

   Linux 6.12-rc6 (2024-11-03 14:05:52 -1000)

are available in the Git repository at:

  
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git 
tags/thermal-v6.12-rc7

for you to fetch changes up to 725f31f300e300a9d94976bd8f1db6e746f95f63:

   thermal/of: support thermal zones w/o trips subnode (2024-11-04 
15:38:29 +0100)

----------------------------------------------------------------
- Remove a false lockdep backtrace in the LMh driver (Dmitry
   Baryshkov)

- Fix sampling handler context ptr in the libthermal (Emil Dahl Juhl)

- Remove the thermal soft link when doing a make clean. The link is
   created at compilation time (Zhang Jiao)

- Accept thermal zone without trip points as stated in the bindings,
   otherwise the thermal zone fails to initialize (Icenowy Zheng)

----------------------------------------------------------------
Dmitry Baryshkov (1):
       thermal/drivers/qcom/lmh: Remove false lockdep backtrace

Emil Dahl Juhl (1):
       tools/lib/thermal: Fix sampling handler context ptr

Icenowy Zheng (1):
       thermal/of: support thermal zones w/o trips subnode

zhang jiao (1):
       tools/lib/thermal: Remove the thermal.h soft link when doing make 
clean

  drivers/thermal/qcom/lmh.c   |  7 +++++++
  drivers/thermal/thermal_of.c | 21 ++++++++++-----------
  tools/lib/thermal/Makefile   |  4 +++-
  tools/lib/thermal/sampling.c |  2 ++
  4 files changed, 22 insertions(+), 12 deletions(-)



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


