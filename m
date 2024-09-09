Return-Path: <linux-kernel+bounces-320749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A135970FD0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75CC11C222F2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 07:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358491B0104;
	Mon,  9 Sep 2024 07:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wbnXSlQN"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3131B0109
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 07:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725866705; cv=none; b=MYJJVT+vaXkUHJfxUnjxkAK00VR+a1B2xTIXVr6eh/RMCnVWOxYdzJQwJLv6QxwBTZj+bg6BhmlFY+V4N/vIQMtvYKERsltQFrRaMYmCUCQO7j6YgBQqkl5OONlNQ5lbmexvSL2z4JAv/Fzp+go7WnHw4DS/hh5cuqkjXN+qMSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725866705; c=relaxed/simple;
	bh=BZotEzAdsPB94eiOlgoBZGZBcUmxpW2YmTdHkRGyeUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lv+ChwTD5ckU/uCgBD7Cn6do26DY6sHU3V2J5dAbE0cjNunFmjwzH3Lv+79YcF3dBFFgCS2Hufiy+uWbHRN3MbVdOvP1go2REbDfCHHsGxHOU/TEMzzQfMN7qSOTfiRMUPR6VuMoV+L8j+QJXdnqd5fpdydiVUh/gwWn2C35mYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wbnXSlQN; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7d4ed6158bcso2812310a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 00:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725866703; x=1726471503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0rtKtc8xxmphgoE5GQqKgmgbEHiytNC7qXwrkhYLtAU=;
        b=wbnXSlQNUX98Ytlx8rfJQJi3M2xgmePSw/t90Qke/hlbxZdfDGogPTzEcY3MiB2SYy
         q4LZvs+dfK0k8jB9kOlrufwnvXc/UzrTVOElptRUcwf60AbCaKtOOcq/Gpyg6gVJHJSS
         G5sxo9Wi5DsUCEImBIp/HdT05b4ysiikGgz3mFCZabVu0BBdLh9+owgXFOOBB0Mvho/C
         zvTjE/fv2SZY6eCd12jNHpNtEkNJGtrwm6oSt7ZuiYvZnS939Xj4wbDvj2S4SakHKtXO
         1VipXSgmCrAIvjuPAXTH7dcJJpmYKJ8Ajf4YGuSsNu3MO/5XxJsZ4p1JVlU2H6X5Sr9P
         5xeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725866703; x=1726471503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0rtKtc8xxmphgoE5GQqKgmgbEHiytNC7qXwrkhYLtAU=;
        b=SfUlhwJ0e2KpBgsY0uoNrYDOULiREZsx6H61BZa9WYnmk/ZSg3Z657/iNaAJ4W5qEC
         zmTEe5F/3ebrG7swqkW0ApW3DDFRM1rRHLRLOnGRHLM2oiFiq+4/1lUEPJy6ZKTCDL9C
         T15+I3FrsvuLUg1a6iMESC1xfnx44LsVgJayMBqupPv3JGe/8MMa8Wse/lE5WLIcz0gb
         OhBKhEl9Zge+xdfTnW2TxVTIAkOHnigoN6PYFv5hxRj2022+b4zG9DLHTMok2VkcEzkj
         3RBELzE/qiE04JX5wGzHoaoFXOUMcq4hoje7BvdLkzYg5/s84iAcb7Y2n6bmM7syF8GQ
         vX4A==
X-Forwarded-Encrypted: i=1; AJvYcCXwCqxVZ0aj1Ixm3qk+a3YGv5ESxNZMdbdnNxhhhmpXeYwT8OTptG9OW3BjaBYwZl6xvRawA0vDYgUN+Ns=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnP53EXnngUyst2hGoKdyXnY5kkgAgxREuN6GMM4VCfFnGX9ZT
	/tsr4cdwZOTJHhBKmkeSRWb4dUCK9Xr+1BY+88q6aBv4YBCYP5mhqZnpLvRi0A2y/n0r0to/Pk2
	i57GeK8LhLlT58dmtuoK/EfrlUCc6oA0VNC7FqbIYEc0utZMvWQ==
X-Google-Smtp-Source: AGHT+IHk3xn4SEFbGV8Z445z8HBYrpGc+S7MEpBlNXInTMlAY54YC5wfJaqH9O2o0xnn7hwCBPkBNlNuKiP9EQVDm4U=
X-Received: by 2002:a05:6a21:4d8a:b0:1cf:37f8:7a23 with SMTP id
 adf61e73a8af0-1cf37f87d59mr2904160637.41.1725866702955; Mon, 09 Sep 2024
 00:25:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909-fix_amba-v1-0-4658eed26906@quicinc.com>
In-Reply-To: <20240909-fix_amba-v1-0-4658eed26906@quicinc.com>
From: Saravana Kannan <saravanak@google.com>
Date: Mon, 9 Sep 2024 00:24:26 -0700
Message-ID: <CAGETcx9X0m3=8PPtVsHp=AAjyCoUZ0-53H5RzVd4HCDtWRS0Fw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] amba: bus: Move reading periphid operation from
 amba_match() to amba_probe()
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Russell King <linux@armlinux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Isaac Manjarres <isaacmanjarres@google.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 8, 2024 at 4:38=E2=80=AFPM Zijun Hu <zijun_hu@icloud.com> wrote=
:
>
> This patch series is to make amba_match(), as bus_type @amba_bustype's
> match(), also follow below ideal rule:
>
> bus_type's match() should only return bool type compatible integer 0 or
> 1 ideally since its main operations are lookup and comparison normally.
>
> Which has been followed by match() of all other bus_types in current
> kernel tree.

The intent or need for this patch series is completely unclear. The
code you are moving around was also pretty delicate and hard to get
right.

Without a much better description for why we need this, I'd like to
give this a NACK.

Also, patch 3/3 is not at all easy to understand and seems to be doing
way more than what the commit message is trying to do.

-Saravana

>
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
> Zijun Hu (3):
>       amba: bus: Warn on adding an AMBA device without valid periphid
>       amba: bus: Move empty @amba_proxy_drv's definition to the front
>       amba: bus: Move reading periphid operation from amba_match() to amb=
a_probe()
>
>  drivers/amba/bus.c       | 130 ++++++++++++++++++++++++++---------------=
------
>  include/linux/amba/bus.h |   1 -
>  2 files changed, 72 insertions(+), 59 deletions(-)
> ---
> base-commit: 888f67e621dda5c2804a696524e28d0ca4cf0a80
> change-id: 20240829-fix_amba-0f09aa1fc3b1
>
> Best regards,
> --
> Zijun Hu <quic_zijuhu@quicinc.com>
>

