Return-Path: <linux-kernel+bounces-330758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DD297A3D9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 16:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8FFF28AFA2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 14:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D36E5258;
	Mon, 16 Sep 2024 14:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eKtpv3ks"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D762B156228
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 14:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726495751; cv=none; b=B56XoP4sS3pHnWdshaj2poHIUa8NMp1/zFwSGwoG+Cxtk5EzStqlH8kLQyk+uDgI2YQrBTId9ckTpI+z9mNXFPTjln3V36/tYNikzieeAbAQUuoqvCXoh8kbEGC4yUDPCK6/rBLP9MR/Vg96XUcUa3qi+JVSHG/NqmrN+J9j0lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726495751; c=relaxed/simple;
	bh=HmAK7CniaJQtMmxMwrtBOeKPih2cvAldTIyclY21mRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eLIXugb1TbPNYIvWApxZNKeYWPSB0AkCveU/DHJ9xbfz04kJHlK0+g+AVgJT0jLJlbzb3TpmvEY7g2hv4iB4nLdogAohvDIBK366wd2lK7xazotfwZZua6UEmzLvbSl5DxmmiIaNaQ/Jblhf0nVmFWMHcPAo3eZR4O7fFT0MavE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eKtpv3ks; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c255e3c327so5819475a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 07:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726495748; x=1727100548; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N1Z+SmDWQl+ToljrRXHidOzvuWiHEmYlCJkt0VHonRE=;
        b=eKtpv3ksAYZmDex8k5JLNxRPf+lqwwl3CvLK/kW5fuRyfURT7vbMBlF98J9J64VGa7
         uxU9A8YuMJCxGuT6NED4mfO0z3JxgILPSQxOXfXxhSayHf9PFilm8B8l6VtHyQc6VoRC
         sQKiQlIAzSB1ApZa4x6T3klDPQUMdRyYbG7esqiazVxLhAOaMthCK07KpCn72Qf/aGPh
         LySCZi+yPfctRdyEiD7rB1BpbGP/kGfuyvoJu/ejG07EJnJ1mTBs4sb4c2ZJdi+djNKc
         LxrYO5S7SVqkzuxdULnQDUCSmsH0uTKJM7efq7G96ClNl5hVAqueZZbBdBukRQECmwhd
         z6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726495748; x=1727100548;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N1Z+SmDWQl+ToljrRXHidOzvuWiHEmYlCJkt0VHonRE=;
        b=th2EZEnlnO9n0XjIh9GCxSH1qnvx/CBd6/mD0xCVxV4yJg1tu+UbSjvngTaBcx4lzU
         aersUwN7hnDoLWzRUAEggSmSe5ZWdaHHoq+IdVxnKsusfDUu2GLHnldzUNHmY/HP/TNT
         Ys/DqcDA8vV91b3XwK5M3qyC4aFr+bfFKZ3AkA8Mj01BZT83y208bOFBaAYtkWp12g3j
         uW/uSitjnc6ePvvbZUUkUa5WY0tujbUez/yiiLoAmeUVgJTegimAz8CYb+Az6B4BYaJn
         FJBxP/641a8qlCv13Gc7lOFS8LkXBAvNzW0kuqepPMEoleJL6k44wDRRGnmxNMu+KNJn
         u6VA==
X-Forwarded-Encrypted: i=1; AJvYcCVBNHKyNNItn1fW+YYzk1KvIkR7p57TNBvyMD6Ao3Cr+mRVuYFM0BqaHVNkxLlrkUIvASI2e7Q+Bu9EtYE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc678s7vZpRBN4r35TYubLOr+Nay+x6agdYFWd3gHsq4X6iEeg
	qEEoHdBwhct/rPmd8xjdeGQqGg/7AxiAOi3j8xM6C+bic2cZdqnfrVeAtbk2lHk=
X-Google-Smtp-Source: AGHT+IGTIuoTiYSqzwlejafPpW/Fd3fLJblO19bLyEiOs75IO8kJfKTL0OQanRC2moMSY/TIko+L/A==
X-Received: by 2002:a17:906:f5a9:b0:a86:7924:11bd with SMTP id a640c23a62f3a-a90296178c9mr1737460966b.41.1726495747986;
        Mon, 16 Sep 2024 07:09:07 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610966aasm322014566b.26.2024.09.16.07.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 07:09:07 -0700 (PDT)
Date: Mon, 16 Sep 2024 17:09:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Denis Benato <benato.denis96@gmail.com>
Cc: Jagath Jog J <jagathjog1996@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] iio: bmi323: Fix some bugs in suspend resume
Message-ID: <e5a7bfc4-7c30-4d68-a522-1d780e910da1@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

These were a couple bugs I found using static analysis.

Changes in v2:
Added an error message in patch 2.

Dan Carpenter (2):
  iio: bmi323: fix copy and paste bugs in suspend resume
  iio: bmi323: fix reversed if statement in bmi323_core_runtime_resume()

 drivers/iio/imu/bmi323/bmi323_core.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

-- 
2.45.2


