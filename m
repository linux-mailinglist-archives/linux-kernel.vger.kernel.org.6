Return-Path: <linux-kernel+bounces-317634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA0E96E14E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 19:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0819228D36A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 17:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA8F1A2566;
	Thu,  5 Sep 2024 17:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NIhny1SF"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8015914EC71
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 17:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725558040; cv=none; b=qb4YtVZHvI55ROZS2iEQmLtgluG3WL5M0SSrbvzjeIGHsbUNh7GMPdZUNRWpnSuX2A5GlJAiLy2lrdLmzX+l2Jr7FnfEoZ98Myalgcs2W4nQFE6ecAN0xBu2dkT/uFcW2GcfwXPhOH+DngtXEki+emcUovo7PrB7CQrAKTwn9Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725558040; c=relaxed/simple;
	bh=Qysi8imiGUpncymGKZrx2x7HV2/xuVvpQ87ip/3uScA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nw1Njd0uXiMJiY3ZbCnhGLqSjyZuG/vk+x1rIB0hXU4tMoxbiz3rbz4R0h67E20EMc8tVFAoL/o7GppSe9JIjYC3wxWFJ8Rd5STx/WR2AZtYB2A8piu/hEpILzqiI1OpmYLRUID9WbdHQsKt63acMW+FlHvmCzHX1cYwbJ4c7fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NIhny1SF; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c25f01879fso1332700a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 10:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725558037; x=1726162837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqt4dOKMC9n+iaQmLXgBrbCDHbh+BrqQnT7LDNp9dN4=;
        b=NIhny1SFzbdG4VBs2p950VUNjPUNd3AL9CCaxxBx4wleiTyx7tDS53OslSRPm9APiH
         wtL3F+F9rcJmjPvkVurZhIUQOff1aVV4c6alTwmTYZ4MzOaBLAYjEvuH4zu3KV6SZY34
         5/SkOcb+bfOPNpFoo6Rwc942Yw5rqpjeWUjKWoNhxbJ1/R97OyyvbTfgG34HsiY1VkeS
         FN/OfZ+Hq43cZQbOgXHjJASJejVAiZoQVdZ/MzOJwEJVQsfYh3dhg9ByQY7ktHhugWmG
         aURZoHsLpcmEtan9bLyqdZ3y7s7SfA+p1GG2a7zKmiknxLif3PmSTh4g52CfLzbwbWQj
         wy5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725558037; x=1726162837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xqt4dOKMC9n+iaQmLXgBrbCDHbh+BrqQnT7LDNp9dN4=;
        b=cBSHLnn+z/LlwDMwZ5YrFeDQD1ocEju4lRCUu72TpWwFfqfzy1lndafWQ/Ge5IbZMe
         RD3FYSb01xZE+8X7jzK8M0qEKHq0Pm1jq2A6KSEYb2O0RXtdxocnlIP/dvCsUy1lWxK4
         O9VnYZJsVBTfb2b8mYlOr6tOGgNh5ahKgnLfgpuOIyn9n1r0Dl/lEgWbHk2M6GD2HVPa
         FlJgbbCnNj7drg2DL4dNO+kzf9jSO2gVnGzZ5ICmYW/SUf65fO1BsHhgukIPYaXzp6fx
         cHXZo85pR++WGe+HFjmrq/LbUrjVC+GBDdjjnJ0+PZnTTwwcdXP0ZItB3SoRPSSSkH+7
         Y+0g==
X-Forwarded-Encrypted: i=1; AJvYcCVaLD+WuMTX4BuHJ1lWIvqrjEwZkf5EGVTAPX311idK1dsVG88/5lFoLNJrqpX+Em0wjrlwOy9vdwx7sp0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5SyjPQnNrf6kT4vmzDj6H8YwWEBjB6cL8Kf6JvcpUd2oyQLIQ
	bdY/piZEh+kACXR+UCi8Ri9nSrwcYc47Mh9zlvnZvjcacPuyvrWsHCGXZl94+vMKjXFx70snYPG
	DAosCHESP5LR/VILh7Yx9hwPyMw4=
X-Google-Smtp-Source: AGHT+IH/FgNOLprl3/MUj2lQlUm2Fme1DgjZBAT+U0kqCpiJovPuHqC/JMA+2bLFwhJal7DPJ2vM0CJJNjZOEBNTJ5c=
X-Received: by 2002:a17:907:3e10:b0:a8a:83e9:43e2 with SMTP id
 a640c23a62f3a-a8a83e9461cmr25235066b.12.1725558036491; Thu, 05 Sep 2024
 10:40:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904190856.1221459-1-andy.shevchenko@gmail.com> <CAGXv+5H8LBGQWC9uJk_ai8d5pfCA7FZMnDQve2QfTeA74acXmg@mail.gmail.com>
In-Reply-To: <CAGXv+5H8LBGQWC9uJk_ai8d5pfCA7FZMnDQve2QfTeA74acXmg@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 5 Sep 2024 20:40:00 +0300
Message-ID: <CAHp75VcVd7Zn2ZBRzor=jo0z9CtLDfacW6WXSiGCro4v9=VddQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] regulator: of: Refactor of_get_*regulator() to
 decrease indentation
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, 
	Liam Girdwood <lgirdwood@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 11:49=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
> On Thu, Sep 5, 2024 at 3:09=E2=80=AFAM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > Refactor of_get_*regulator() to decrease indentation and increase reada=
bility.
> > No functional changes intended.
> >
> > Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

Thank you!

...

> > -                               goto err_node_put;
>
> Nit: I would probably rename this to out_node_put. But if we're going to
> move to the scoped helper, we might as well just skip it.

It's a bit out of the scope of this patch. And yes, if we go in that
direction it doesn't really matter. It will be replaced by direct
return calls anyway.

--=20
With Best Regards,
Andy Shevchenko

