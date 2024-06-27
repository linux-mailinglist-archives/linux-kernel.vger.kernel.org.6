Return-Path: <linux-kernel+bounces-232092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C60D591A311
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 11:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F8F51F22294
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 09:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95BB13B285;
	Thu, 27 Jun 2024 09:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sNntStgF"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C56513AD1D
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 09:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719482011; cv=none; b=SnyjF74ac+iEEzgZyh3FiFXnrP24cOXuWgvYt24QVAFZ1jgogE/x3ypPvgkTplvG7jgeqbvt9o32lSG9thT900I/rgDTW9oFp+aM1zrO7Sfx1HHA+51pR4igJOaoRD751zimAZlHzaEGBKg73ewObxIlUPgSlABLTOdIrbLNEgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719482011; c=relaxed/simple;
	bh=LimPB+DlE1fbi57FEquSm+DF9P3FN8gHEtleoYBzkTg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BkEyyIXDIuNZ/RhpcpnVOup4Hlv8bdee0tHbqUJssaQRl9XeQAXnN6F3qL1yTa7tzy/QOOkTiujX6cUq6y4hEmsqckSuCwYfuj3PfEh0RjyXn9jWdSY597PBwNiSdciUJCVuaZor3IW2iQgi2SdyMSoBov2mrYBDVA5n1Q1KCgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sNntStgF; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a6cb130027aso515496966b.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 02:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719482008; x=1720086808; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UbOt547hAIIlJlatetFlVG+c0+VndBbbd6B/YWLqHxY=;
        b=sNntStgFcwspD9rBY+6B7vAk8EOqyhMCVdljQ5Yd3Irfw7NA2zvizLkzEnAkGwCucl
         e6j20neuIipwFY7HxRyBHF238C5wBA8JPLLq7/tixsZ368XN9oHHzb5mYmAPIpEtKbb1
         8oWuiHlXFc1P/6YVv34bk7dUcHvGRtIGoEeXyayGSgbUtT7PTU8xqTt8Buz8Iw0797Vn
         wLyDVjSNqKUvrtNyhTJFdFRbuXwI0EMJAm6XfAZ+5ZUhjoSVAq3I5FOD/OI9+A5ToO71
         j8Ayu7VH/s7gJpMloq+7xm+weVYawFdfXJb3TF1CKzhYx6rqTQ6j7th441YHGtd77lBc
         tILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719482008; x=1720086808;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UbOt547hAIIlJlatetFlVG+c0+VndBbbd6B/YWLqHxY=;
        b=FxD40Vnn0FK8xcJ4qTdChJxFTe3WDkmmTkr2k4ghoEkmYfK3pMMqxT2r5OyTA4Md8d
         VjoM6IOTzDKQar7xN+q8pvUML48z0kSiXfNI8n761fZ5ZOS2Z4UZ0xHo8ZoYrQZp2ZJr
         n9tWIXUiN3x7Pzy05Csse6OGKis0PjmKAdHXNZqed8v6alEGeHzF0JHaxAfHPDQ24oLl
         yJNhjA8RJUcLTv+MbNfXQi6NnDxj17f2m/guIOKYTM8A2YYYzx3JHuUtOjcBI4j/aclU
         yYbBnrShM7NOWCoOineu1bL1MExTwRuVMl4XkX34JKGerU1gxWch3OudJql+E87YRJoK
         TrkA==
X-Gm-Message-State: AOJu0YwTUgAyNDSovWIewjwQSbCVoaYFPYO86EygksYAaZRH/BQBkiep
	S3ZiTr+dW5rVTasxUkeWal6yAvNd765DUZiYiRNAme76vEf2QF5co2gnI6Ztbq8=
X-Google-Smtp-Source: AGHT+IGIuuOsJS5XWtZr85fjChr/P2HzFwqvfLFgwoJ4jn/hrtHNWGJXklJFb9Xc7x1BlOEXMt2WqA==
X-Received: by 2002:a50:9fae:0:b0:57c:b810:1062 with SMTP id 4fb4d7f45d1cf-57d4bd746e6mr11563671a12.13.1719482007771;
        Thu, 27 Jun 2024 02:53:27 -0700 (PDT)
Received: from rayden (h-217-31-164-171.A175.priv.bahnhof.se. [217.31.164.171])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-584d16bbf1csm649779a12.44.2024.06.27.02.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 02:53:27 -0700 (PDT)
Date: Thu, 27 Jun 2024 11:53:25 +0200
From: Jens Wiklander <jens.wiklander@linaro.org>
To: arm@kernel.org, soc@kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] OP-TEE add notif wait timeout parameter for v6.11
Message-ID: <20240627095325.GA2585076@rayden>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello arm-soc maintainers,

Please pull this small patch to the OP-TEE driver that adds a timemout
parameter when OP-TEE is waiting for a notification via RPC.

Thanks,
Jens

The following changes since commit a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6:

  Linux 6.9 (2024-05-12 14:12:29 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git/ tags/optee-notif-wait-timeout-for-v6.11

for you to fetch changes up to 14ca6401d8703725c7297dcc4bf8de73323411ac:

  optee: add timeout value to optee_notif_wait() to support timeout (2024-05-30 10:19:28 +0200)

----------------------------------------------------------------
optee: add timeout parameter for notification wait

----------------------------------------------------------------
Gavin Liu (1):
      optee: add timeout value to optee_notif_wait() to support timeout

 drivers/tee/optee/notif.c         |  9 +++++++--
 drivers/tee/optee/optee_private.h |  5 ++++-
 drivers/tee/optee/optee_rpc_cmd.h |  1 +
 drivers/tee/optee/rpc.c           | 10 ++++++++--
 4 files changed, 20 insertions(+), 5 deletions(-)

