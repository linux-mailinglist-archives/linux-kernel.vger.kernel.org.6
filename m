Return-Path: <linux-kernel+bounces-253869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AAA932816
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 16:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B202D282BED
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 14:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D036419B3D1;
	Tue, 16 Jul 2024 14:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="pqdhl8ZY"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4785D19B3CC
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 14:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721139410; cv=none; b=qRJBcDS1020YmHo2fUU+YIOc/69jNXI+KFH8U+qIy9OOFR39NO7vFd6QmoWN+Heh0rnjEXjflJOa2kyp1ad2qe7gkwuK46AVMeTTRhCOQU9sKx7vLnLek8zwNdeuNSa1uGbtW3S4UfnPRarfbsRNDSy3NHOepEHIZoWROTnHpX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721139410; c=relaxed/simple;
	bh=qTkHAr/zaughV+7F2fCubDw1JUCR2+6MQRGZo5D7N9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BkSFuFbWKGvb3j3Z8lvm/80dEfr81yt3sfP1lSh7O43IYkgBU1gy4K7rtSoYzmPzkgmW6Z1HjCMhtirVn0MsC4iX9ErL3x0g3GuAOIkml58gPJNkX4Jy3qde/IJIgR084BZCo/S56IpUzjwEvEUR4BUQkz5gTYu++orsrb5du6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=pqdhl8ZY; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4266fd395eeso38812895e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 07:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1721139406; x=1721744206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2KkJLDf/5u/Uw5t/Hcj9+N11OZDQuObq6Wr33VJS5Zw=;
        b=pqdhl8ZYzS6NRD/6O4XX/t9REr391JH39fRm2LKO8+MdIxie/3K73LiWwlA4ongV3p
         4CI5wsMFpa4EWqXY0lKlHFbOaApD7/sqoeXu7gLZjJBx+xL1xE1fcAVqeSQa1FIVkINO
         bDROg7MC45aYYjvIkQwX8k5oXNjftEhHYZgGxxtX0jcYXU2sm/6mufo0Zw8ZuEJbvAM8
         2sr9JbphvtCVwmSjaE4LKWiFRypJm4tr1D11Oa/Hg6uJOhnlb7LdXkYYYpO4xj4Vs8Fj
         7PzDYyWkpkBSQSDZtK5bR7jAI5LieYbJy+BrKSc3b46VWrxmTbs7+hcvfwUy3YtcAe0x
         tw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721139406; x=1721744206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2KkJLDf/5u/Uw5t/Hcj9+N11OZDQuObq6Wr33VJS5Zw=;
        b=gbOFJhcsLLphj1tULO5DU/9QLqv8GZVGKm+pv2mZ7cywoTTIRdcsTbt+eaUrNgvqW0
         nHBs5J7uN2pm86NQqRB3/gkXdz19qmTbp8xaL/4pQwxowoS9QNPf2uqIaMWI4lp/ViOk
         0swaGh1/uodfsjTJcKkfu/l2KQZ1xux3bO+68X/8uTydnY555L7/XOR2e5Gjn7j7azgw
         B1ZAhg5z5ZF+0wr1TurWjA1EZE+/Ns779OIyZRbH8eaX1ub3haoLA0iH5qb8XH3a4/4i
         RTyZ7fhvbQLqcXIBmj8hK27n15KAPKJPKmR0Rpg3XvjtjMQ3oOWPUvTtprqy6QostqRk
         ACQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXl1YgPXoq1lKrWuX7srmPlmbROQ1ZsEJj0cfau3G+YXT7j3Q0hhP6sMv1HBzqGB9IFuA2/E9PzObZTHRSxSncjNfpVV3tvQbrYdWnT
X-Gm-Message-State: AOJu0Yy6nCTdohRZ46GXxVjKlIU5bJcPE+Fi8ykn+i/40aU+t74hD1L/
	dgAYkpDi5pMbstzRQ4vEu+ZcFnD9NCize/CR0nlwQiHvfbTtwlEtR2SzaSdTs+8=
X-Google-Smtp-Source: AGHT+IFfL6E4hI/T1tR0oz1iyUrTJid2XbxoyXx3FWCjygq0WwhLRxbzUqTffjsXBNewprqZS24bHw==
X-Received: by 2002:a05:600c:5114:b0:426:6eae:6596 with SMTP id 5b1f17b1804b1-427bc3bd337mr17062835e9.25.1721139406375;
        Tue, 16 Jul 2024 07:16:46 -0700 (PDT)
Received: from matt-Precision-5490.. ([2a09:bac1:2880:f0::319:a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f2cc32esm165310455e9.35.2024.07.16.07.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 07:16:46 -0700 (PDT)
From: Matt Fleming <matt@readmodwrite.com>
X-Google-Original-From: Matt Fleming <mfleming@cloudflare.com>
To: yu.c.chen@intel.com
Cc: aaron.lu@intel.com,
	dietmar.eggemann@arm.com,
	gautham.shenoy@amd.com,
	juri.lelli@redhat.com,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	mgorman@techsingularity.net,
	mingo@redhat.com,
	peterz@infradead.org,
	tim.c.chen@intel.com,
	vincent.guittot@linaro.org,
	yu.chen.surf@gmail.com
Subject: Re: [RFC PATCH 0/7] Optimization to reduce the cost of newidle balance
Date: Tue, 16 Jul 2024 15:16:45 +0100
Message-Id: <20240716141645.637620-1-mfleming@cloudflare.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1690273854.git.yu.c.chen@intel.com>
References: <cover.1690273854.git.yu.c.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Hi,
> 
> This is the second version of the newidle balance optimization[1].
> It aims to reduce the cost of newidle balance which is found to
> occupy noticeable CPU cycles on some high-core count systems.

Hi there, what's the status of this series?

I'm seeing this same symptom of burning cycles in update_sd_lb_stats() on an
AMD EPYC 7713 machine (128 CPUs, 8 NUMA nodes). The machine is about 50% idle
and upadte_sd_lb_stats() sits as the first entry in perf top with about 3.62%
of CPU cycles.

Thanks,
Matt

