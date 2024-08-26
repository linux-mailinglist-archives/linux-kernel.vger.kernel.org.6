Return-Path: <linux-kernel+bounces-300924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B67495EAAA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 09:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48F1C2895EC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 07:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8863113A250;
	Mon, 26 Aug 2024 07:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dIpOao+B"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479C0139CE9
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 07:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724657921; cv=none; b=Jo0MBmb1D+pjuqd4ZeddQN3yfTgGkTAqN70S8A02s0DAt47aG4CCPcS+bbFw/7Cv5YW63NGAEeufF6bqeMCKbpW7j1mppjR0U1FUQM+JvI6H3nDjeknRRtHbHesqxo0+YarXD0oD4FuWeDyuX77nwPVyhNnaoJe7cqWnBSEn1Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724657921; c=relaxed/simple;
	bh=+r4KwkPF56YUwM+jpmfwdS9lGM/2/YCwHdaYZ+XtylY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dt6dtweZb1jGDETnYLEM6Q0xVfEgxk4KvioET9dopnVeQT9/Gs2M7llxMKuKBwMTIgrE6m2Ph9VK84DPSqjtOz3CUjVU5GPU2HzlzWwMKjaW7+PcxkVuEwFsNTQnnbngHWcPnyJgfqo6jV/+5u+Sn3wz+20kAwZ9Lo5kkD2Be+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dIpOao+B; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-27045e54272so2617761fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 00:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724657919; x=1725262719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDZNyfBrMFfaLFVLKV7IGwwjfLMSPx3nMeg3fzbktXM=;
        b=dIpOao+B7IwT8APODqv4uOlSrO6lTcnRFNWLZGXDxAz2Zi/ToscUMCsaXw2hurMEoP
         Rdsgg9/EL8NoMAMCVpsY948s080PdE2tO0NIxweUVIhwt3Y9fqn8N932mzXhgWsQjLMW
         y6W6YPnji6SI0/7OQLEBkUG0N7doRqpolcIoI5Y9z0kKbz/ty0Dyg/VusJzMA9rrCsi1
         NvTiOqwl04GTD5kWMEbiwzFuwlHGuf3ozwarnKHjbluhGUViwc2LwjkiYmLG3JeVyWwR
         QXbrQK1QkGwZQka4QkIgJybIuhkyD8uOFFXObkufhaC34EwzQ5I/Myz0E/AokVUV1d3P
         83cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724657919; x=1725262719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GDZNyfBrMFfaLFVLKV7IGwwjfLMSPx3nMeg3fzbktXM=;
        b=KLnVKoOU1GSMGzt27ci7DBKtICj87fTWGHFGR5ZRNbD1zMXZ6zhwxVeCXh5zpo6Ho2
         u2kkAfjRL0ZLSm7EdfxBYFBdY6qaF7xEA3P9Jo6v3VkhB4Zw2R4kOnk5kEH7MV0jtcOv
         fmjzopoL+4ysW+lyzp1wpGTFfbL7URMYXFoDL8DwDhQUbHnNrrSAtpslGB7LJc8y02Is
         exy4Y+3c7Gese+xnhH3LSrMtlQWOQ8Gu5bz1s+9QyHl5RHCcYBe6QmitwsMuUdTBJTzc
         3XAwvNu8+RJ4WtO8A0CJLgaSExT1m0ZUjSW18NLKe7saPmzENY9DcnpLVzIyshDQm8eh
         FSHw==
X-Forwarded-Encrypted: i=1; AJvYcCVussz4d0+uvHj38xen2t+d3w9vkUccOHNL8ZUPswRfAlbPrjUWo/qzfxkkBR55xvz9F59HQfWN38f8f9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuA1DPxi65VfVhvhR/kpq3sLWts9sTItgU8ff3TdbGzt+sBrKi
	Gl1IRuC0fj/lIX4oWI9qgbvS7xPXL5mrkDoyEJsV77E1dNlqQr2ILlgv8a+Sh6B7H8RquKFQ3PS
	tMAYcbyhGA3WOqbEe9PQXf8LTrpAfdUxyMINyqA==
X-Google-Smtp-Source: AGHT+IFc6Mj0Tgj0XqyDn+SsU43dIjPUaGWD2bukfLuYi7jP12SKM8BJS+t3+Mvw0Ibj0o4W3JcieCw8qj6WJHQBfpQ=
X-Received: by 2002:a05:6870:8292:b0:25d:ff4c:bc64 with SMTP id
 586e51a60fabf-273e6469d5dmr10239625fac.6.1724657919407; Mon, 26 Aug 2024
 00:38:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814153558.708365-1-jens.wiklander@linaro.org>
 <CAPDyKFqBuQ8uUdeThRaJtd2CYNWMmpLCEDxfO+znhwjPamH+Gg@mail.gmail.com> <2024082414-doily-camisole-b5c7@gregkh>
In-Reply-To: <2024082414-doily-camisole-b5c7@gregkh>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 26 Aug 2024 09:38:27 +0200
Message-ID: <CAHUa44E0bLYHzoGs3onu6sK5dwXB=1t-GsFWt096z+u4aN6R1g@mail.gmail.com>
Subject: Re: [PATCH v9 0/4] Replay Protected Memory Block (RPMB) subsystem
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, op-tee@lists.trustedfirmware.org, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Jerome Forissier <jerome.forissier@linaro.org>, Sumit Garg <sumit.garg@linaro.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bart Van Assche <bvanassche@acm.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Manuel Traut <manut@mecka.net>, 
	Mikko Rapeli <mikko.rapeli@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 24, 2024 at 7:18=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Aug 21, 2024 at 11:23:03PM +0200, Ulf Hansson wrote:
> > On Wed, 14 Aug 2024 at 17:36, Jens Wiklander <jens.wiklander@linaro.org=
> wrote:
> > >
> > > Hi,
> > >
> > > This patch set is getting ready to be queued for the next merge windo=
w. The
> > > issues reported by Mikka in the v7 patch set has been resolved, the i=
ssues
> > > turned out to be outside of the v7 patch set relating to configuratio=
n in
> > > the secure world. I'm planning a pull request to arm-soc, but before =
that
> > > I'd rather have acks or at least an OK for:
> > > - "rpmb: add Replay Protected Memory Block (RPMB) subsystem" by Greg
> > > - "mmc: block: register RPMB partition with the RPMB subsystem" by Ul=
f
> > >
> > > Arnd, please let me know if anything else is missing.
> >
> > Greg, Jens,
> >
> > To help out with the merging strategy, I don't mind queuing this whole
> > series via my mmc tree. It would also be nice to let it cook in
> > linux-next for while, via my next branch.
> >
> >  From my point of view this looks good to me now, but please let me
> > know if you prefer a different route or if you have any further
> > comments.
>
> No objection from me, please take it through your tree, makes it simpler
> for me :)

Same here, Ulf please take it through your tree.

Thanks for helping and reviewing this.

Cheers,
Jens

