Return-Path: <linux-kernel+bounces-187746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DA98CD7DA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 17:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4661B22CDC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 15:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AE21BC49;
	Thu, 23 May 2024 15:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NhtO7cb9"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DDB17583
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 15:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716479747; cv=none; b=J1LnZl/6QFRi9iPNUwUvwiHLFMTQOqQpHSAYq/Jzt4lZ3oEr1HjtrSLwDNfy6yoTru0HxaHMx4R75lg5LkDZe/GxMvnuE0ietP7KOETux1edM6SNhhaCyGqoA8yciNWvda8NOkisXsA2QtKO5SA6BRy+TmAQPKXu3MXca29lJdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716479747; c=relaxed/simple;
	bh=3gX3Ztjr7i64c5zaCwKW9awJ+IB6EVe8caKn295fLcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WeXtZDgCXBDsLQI/IVI79SE1JvUUd7RVRl0LOuN42y1+aotSUxHWMF0bKs39g5rlh7cacZUa73iofBJXT0AzJf9UDY5c5I2Hb17iZEtPvm8jL3GfBckQEqFWkS69SU02nssnNzvy4PqI2AColQ2n8UjQLFLZyh/OHkZkRVgsxPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NhtO7cb9; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51f60817e34so8978031e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 08:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716479744; x=1717084544; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u4Cxm+I9SW1RzY9dhQ4rpc6mA9qWWtUSwtKxHenGgOw=;
        b=NhtO7cb9lspavmAPINrIgc7/qtxGD2hhrhX0MF1ZH4yMVg6hSlwWRw3dRIsYbbCkZn
         0wMZ8kJH/qz4cnTd3+zBXnjACcJHY9tov9AMCdyGhlcmmNKtZBfKCUQDYSAYLdtbP2F1
         IhA5FFr6NK2qcmhH1aYEZOonnta9TOLYc6nms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716479744; x=1717084544;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u4Cxm+I9SW1RzY9dhQ4rpc6mA9qWWtUSwtKxHenGgOw=;
        b=oO7XR8Dpsx3L8V6vGgUrvoc0rIjAvNZ3tPtvPjEjeBLevp8MEdCK4fQuA+VmYFZFge
         CSvBLiibpO+PInk3K/9FpzE5lM7MjKMMuM7xSniRTFgqoUfGeEd9yGqWrms2Zbo5AgIE
         /RrAKuXnVmDHckAKwsS9BfPECANS5E5LoGShubX8wXoEueJIdm83CVeSdPcEfhLbxQHb
         6voPBf20cXTr3gexO1YVoTBvXAxZ+rqoQvAsEWuVXDEFVGYsG/sHr1anhhaN+ZZATzLB
         MDfQsuwodVe6lX0oZHXBQanb630XQzblojbo2B/kudJQ5lkz0+eN1lkDv96kRIua2pkE
         0cbg==
X-Forwarded-Encrypted: i=1; AJvYcCXazcDfupdKRDamVURBQRMI1eA10u/IOXqYYNJRS3CywzDtaKo5+Dd3lAd3f4AkB5nzS0PTSE58Z01cGtazAILTGYOoaIh/qvfy3kFF
X-Gm-Message-State: AOJu0YwLBgq26mvJ8w+/ZnDal8XriwuoeI0vulI86TmVLJIh3bTAZ6eA
	dwIwWA0vs/WzpH4Vvk77/Jc0pIcLFIrz8TNzQqn0AzvhxkPtS8P57EbH6a27ni5OWlSVEb0O1VD
	sxawsVg==
X-Google-Smtp-Source: AGHT+IHVRnh+PbiqQnC9DSvnwwTENbWW5rc9oqb7jYHyaKisBKz+Nz+xRGDOYet/mYM8vs0Ds1swzQ==
X-Received: by 2002:ac2:5606:0:b0:51d:7d5a:af05 with SMTP id 2adb3069b0e04-526bf82d168mr2993852e87.32.1716479744015;
        Thu, 23 May 2024 08:55:44 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f39d2cf8sm5364851e87.255.2024.05.23.08.55.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 08:55:43 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5238b5c07efso7287005e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 08:55:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVeap7OlCK3+3s+2+UjG3LljqUkiDbbbFZx5ZcKijTwQO44Y74cICAv3Mq2AltCvDAt7y71zi6enLGyy51sry8ZLow5/7Zpl6ud6sJt
X-Received: by 2002:a19:e001:0:b0:51d:70d9:f6ce with SMTP id
 2adb3069b0e04-526c0a68e9amr2936135e87.53.1716479742873; Thu, 23 May 2024
 08:55:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <o89373n4-3oq5-25qr-op7n-55p9657r96o8@vanv.qr> <CAHk-=wjxdtkFMB8BPYpU3JedjAsva3XXuzwxtzKoMwQ2e8zRzw@mail.gmail.com>
 <ZkvO-h7AsWnj4gaZ@slm.duckdns.org> <CALOAHbCYpV1ubO3Z3hjMWCQnSmGd9-KYARY29p9OnZxMhXKs4g@mail.gmail.com>
 <CAHk-=wj9gFa31JiMhwN6aw7gtwpkbAJ76fYvT5wLL_tMfRF77g@mail.gmail.com>
 <CALOAHbAmHTGxTLVuR5N+apSOA29k08hky5KH9zZDY8yg2SAG8Q@mail.gmail.com>
 <CAHk-=wjAmmHUg6vho1KjzQi2=psR30+CogFd4aXrThr2gsiS4g@mail.gmail.com> <CALOAHbAAAU9MTQFc56GYoYWR3TsLbkncp5QrrwHMbqJ9SECivw@mail.gmail.com>
In-Reply-To: <CALOAHbAAAU9MTQFc56GYoYWR3TsLbkncp5QrrwHMbqJ9SECivw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 23 May 2024 08:55:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=whwtEFJnDVrkkMtb6SWcmBQMK8+qXGtqvBO+xH8y2i6nA@mail.gmail.com>
Message-ID: <CAHk-=whwtEFJnDVrkkMtb6SWcmBQMK8+qXGtqvBO+xH8y2i6nA@mail.gmail.com>
Subject: Re: [PATCH workqueue/for-6.10-fixes] workqueue: Refactor worker ID
 formatting and make wq_worker_comm() use full ID string
To: Yafang Shao <laoar.shao@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Jan Engelhardt <jengelh@inai.de>, 
	Craig Small <csmall@enc.com.au>, linux-kernel@vger.kernel.org, 
	Lai Jiangshan <jiangshanlai@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 May 2024 at 06:04, Yafang Shao <laoar.shao@gmail.com> wrote:
>
> If it's not urgent and no one else will handle it, I'll take care of
> it. However, I might not be able to complete it quickly.

It's not urgent. In fact, I'm not convinced we need to even increase
the current comm[] size, since for normal user programs the main way
'ps' and friends get it is by just reading the full command line etc.

But I think it would be good to at least do the cleanup and walk away
from the bare hardcoded memcpy() so that we can move in that
direction.

                 Linus

