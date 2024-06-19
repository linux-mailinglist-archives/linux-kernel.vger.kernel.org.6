Return-Path: <linux-kernel+bounces-220580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3902290E3F6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 09:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D74F1C240F3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 07:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE6574057;
	Wed, 19 Jun 2024 07:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QlC/PQzr"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B9617583
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 07:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718780714; cv=none; b=QTxA4rYoPsteXq3zb8VeWAmAdbnGr5+gFoJLRBqW0zfrCcOzTCAeYrVr/F9XTWduGBd52kcPwjGcBVpGOXHg/THeaSn3JDy8+S7SLS9nNDIR2UzvlOxHDaneWHFyx65cRzimjcqacDEX5zSlG483juMpsO0xy1CRy60rqJdVBqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718780714; c=relaxed/simple;
	bh=x5nGr+EAONrqkj6P9t/dtlrL61on+Chcpa2cnnYxLKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hISCDKelPs29via7W2EMBDvzKPO5E69GbK2g4xMh8Io3Tx9vIuXVWhHDStZV3TyeJ8kHxUnaosRSqOhQ94R0MnndX9hfUoMkvFKl3qVmgCK1hiOqGkXoIJqcxpaf15xZMx0ljvpkYdlKVBmlrLveMaeOLIs277FUKPRyhOAsDLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QlC/PQzr; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dfab5f7e749so6037643276.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 00:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718780712; x=1719385512; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fkApUyq4661XB0S5M024vzKYelC21nq0nL2JJnK6W80=;
        b=QlC/PQzrSJ8sFhB9MBR/MrHzeR2KShS83G7rv9xa+IRxbtbCkIHllY7NlVS3kv7RWV
         QBVVsfMXS+QBTV1qjeMrvAJlzLfcSzHYmg748pC97Q2J4z+XnkX9ygQn9x1WPgRQsB4x
         /mdi53o29jqz0OU00qpYAgDQ9tBV/PpsM2FAtWZ2nLBkKw90FiEUZoWzhHTHXgrEBodc
         j7eiDyhbOtnwjDj2+C/KFTfkvHnQGAY0AAtiQCGnPVdhZhxpOS1Ac9TFya9unKhddrMQ
         MYi9+hDXERXc1UAgA7RzvRZK4Y724lymAhkDee/4f7VpP/XSJ2oft1qDXWBxHpFt4cwi
         lvTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718780712; x=1719385512;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fkApUyq4661XB0S5M024vzKYelC21nq0nL2JJnK6W80=;
        b=XNof2a2432zjRle0rrs5DYDagKzFzmOoFUdcQz/qLAS3Mhokhx/Sj9JENsQyomGEIz
         XcWJjHs2GjljsUUhwl09qY9VqCZLHrW/C5nTpEBbWXiOoOZGrjO2ZyxJwuZUT/XAu/zn
         rXm20CL8DhlyyT94W3hhLy0mtggR3PGI8fqwJHpAkKbr0o64asSfZWo0B1wr2Kga0tF9
         i9LJ0eAK8Qii5eztP9KozznJxaoPK7hMI6xDAIkMw+U+iilm6vkW+AKNHxkS2UutnPKG
         Mvmt5w8jJ/PiF81kJhzW31hrW32PP+7UK04M3TOJEKUGvNdt/haYAOab3OJQb/rtYgZo
         EtLw==
X-Forwarded-Encrypted: i=1; AJvYcCVyxVAGuIcaUwwM+fNPD4eYKFxiMoFZVvrpXKCbp9ltK1VB/7UFY98WMZ2kRqbdbXbdnUsn+Vhm8Bc/paqtyh/lXrzSv9LhYIS9nzPv
X-Gm-Message-State: AOJu0Yy4SPY7DX1G8pXzAX843m1OiGZXlNjm1NSFxyxDsK2Sfqr6+5rr
	sSXWbOxBfSNpEUBqE6iQHgniM8TfOiMQxkVb/dCfJXd7ancxIb6nMO75raN9H/ftWJw6gWziaAm
	bhhT2lDXJ68Krx4CTDJ2+c9DIZTJuImT6E0qu2Q==
X-Google-Smtp-Source: AGHT+IG4sbbowz2oRR6gmRouJDUmd7eUdivK4bF3a5N6Vmj6voe6Jh1AZr4utLY6DC/DcbpG2kflee5f733GsJK83/w=
X-Received: by 2002:a25:81c6:0:b0:e02:b580:d0b with SMTP id
 3f1490d57ef6-e02be203e4dmr2083486276.40.1718780712294; Wed, 19 Jun 2024
 00:05:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612064731.25651-1-quic_ekangupt@quicinc.com>
 <zbpia232dh4ojfsvhcqxrp6cwfygaalu5cycdrs47pqmnrisvk@dq24nww26gkm>
 <00b2c65e-c00e-48bf-b118-4785d216cd19@quicinc.com> <CAA8EJprOf9vvdBcdX=Xem3UMFo2pmh37ooreqRX0Bzvadv_yTQ@mail.gmail.com>
 <9fc370be-89f4-4006-a4c0-1040dadfe4cd@quicinc.com>
In-Reply-To: <9fc370be-89f4-4006-a4c0-1040dadfe4cd@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 19 Jun 2024 10:05:00 +0300
Message-ID: <CAA8EJpoqWvL5z4cG0EBEm1eXWUQ=qP0RmedfLbqiFaOjYX7kWQ@mail.gmail.com>
Subject: Re: [PATCH v1] misc: fastrpc: Move fastrpc driver to misc/fastrpc/
To: Ekansh Gupta <quic_ekangupt@quicinc.com>
Cc: Oded Gabbay <ogabbay@kernel.org>, srinivas.kandagatla@linaro.org, 
	linux-arm-msm@vger.kernel.org, gregkh@linuxfoundation.org, 
	quic_bkumar@quicinc.com, linux-kernel@vger.kernel.org, 
	quic_chennak@quicinc.com, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Jun 2024 at 10:01, Ekansh Gupta <quic_ekangupt@quicinc.com> wrote:
>
>
>
> On 6/19/2024 12:21 PM, Dmitry Baryshkov wrote:
> > On Wed, 19 Jun 2024 at 09:45, Ekansh Gupta <quic_ekangupt@quicinc.com> wrote:
> >>
> >>
> >> On 6/12/2024 11:58 PM, Dmitry Baryshkov wrote:
> >>> On Wed, Jun 12, 2024 at 12:17:28PM +0530, Ekansh Gupta wrote:
> >>>> Move fastrpc.c from misc/ to misc/fastrpc/. New C files are planned
> >>>> to be added for PD notifications and other missing features. Adding
> >>>> and maintaining new files from within fastrpc directory would be easy.
> >>>>
> >>>> Example of feature that is being planned to be introduced in a new C
> >>>> file:
> >>>> https://lore.kernel.org/all/20240606165939.12950-6-quic_ekangupt@quicinc.com/
> >>>>
> >>>> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> >>>> ---
> >>>>  MAINTAINERS                          |  2 +-
> >>>>  drivers/misc/Kconfig                 | 13 +------------
> >>>>  drivers/misc/Makefile                |  2 +-
> >>>>  drivers/misc/fastrpc/Kconfig         | 16 ++++++++++++++++
> >>>>  drivers/misc/fastrpc/Makefile        |  2 ++
> >>>>  drivers/misc/{ => fastrpc}/fastrpc.c |  0
> >>>>  6 files changed, 21 insertions(+), 14 deletions(-)
> >>>>  create mode 100644 drivers/misc/fastrpc/Kconfig
> >>>>  create mode 100644 drivers/misc/fastrpc/Makefile
> >>>>  rename drivers/misc/{ => fastrpc}/fastrpc.c (100%)
> >>> Please consider whether it makes sense to move to drivers/accel instead
> >>> (and possibly writing a better Kconfig entry, specifying that the driver
> >>> is to be used to offload execution to the DSP).
> >> Planning to keep the driver to misc/ only as part of this patch. Moving to accel/ might
> >> introduce some conventions to be followed which might require significant changes
> >> in driver.
> > To me this sounds like "we are trying to avoid following the
> > conventions by hiding in the shadows".
> Not trying to avoid, just trying to look into this separately as the need to take ABI also in account which
> includes current device nodes and the uapi header which is present in uapi/misc/fastrpc.h whereas I see all
> accel driver uapi headers are part of uapi/drm/.

I'd say this depends on the accel/ maintainer's opinion.

>
> Will be taking inputs from fastrpc maintainers also.
> >> I'll write more meaningful Kconfig entry in next spin.
> >>
>


-- 
With best wishes
Dmitry

