Return-Path: <linux-kernel+bounces-248144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7C792D8DA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 21:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8829F284C52
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5541197A9F;
	Wed, 10 Jul 2024 19:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U6qhzHfk"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F834197A93
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 19:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720638787; cv=none; b=hPnGIXxrRZJCuZoK5qtHf9/g/9ZcHukCYrQTTgnkLsA3U+JLXNNexYCTYOeb1XUkiQUW3mp2tIieZMkHFrlmquzsym+uZONyel6Lgm0sZ9Fuazy4ive0IZqimV/CgveYsBliVwffmY9YXifFk4kUKfS3+UA3TxdyDK81n3nIX+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720638787; c=relaxed/simple;
	bh=TBqlRU7dCTTmZjQE306rKQdmF8zRVusY86qGMrHNxLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HTR1TVsIHdDOBYlGI/SOb21cEwAthRiGiXNGIGGc0lb+Bbw2EPIGDZqvNflKX7TEvlwcumhbTYR5VVAg0lHDsGGJLxFPTuaEbfbEqqwg6+hNLuGZt4cAc18M34CVAtS4aS6rE8Q9kZKLPkGVu6jHO3TvHnCmGY30B6XJy6ZFX8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=U6qhzHfk; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-79f0e7faafcso7858385a.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 12:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720638782; x=1721243582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3lzoBY9/yiM7+D5Gb2Lvu+52q3dl18EqlM4F4NkXNe8=;
        b=U6qhzHfkVSVUvdQTY3FBdCBE5K5iVsfoUACNlE2ttosDQ3MP2jI5hGl5UXzYPpNHtE
         p93TqFtosZ8cfNTVRmQDTA3KPWpJv5WYrvQOaSZGAwenQ5j1AErrlQ7/JUs/U20lnl5F
         jf8nKukuKuPvvfoOnHbXhcBVE0Go+x2KdvFNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720638782; x=1721243582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3lzoBY9/yiM7+D5Gb2Lvu+52q3dl18EqlM4F4NkXNe8=;
        b=jruIosqmpPcXlahM5oOWsIp0CfarcnsKdQzFikjYEDnQYEV0Tb18mJCH5LvjRkt4s8
         xK9WGR6LbPQBXJ2WcIeuFCAZylEeod/laHQT+gz0sBYbH6UtjnubcZSJR6hetQ+qt2Bw
         p1ySLN71p9I4ymlVMlIRd3JFjOJg794JVVmDQYVcEtx2Bhw+IHUn/LsFmOW5zI8vazIw
         ufFlpWfLPOkZjx3nZucCAra/07i/s8++QMduquSuPXZaTXyzcRIVWD+pqF7cv0Av2PsL
         ik8Wr5a3Ac6RYt9hriDwaOiLdIo3CNXoM2An95sJbq7gUxWiCdcn9mFI7vhzfaUnJP+r
         CK+A==
X-Forwarded-Encrypted: i=1; AJvYcCWyHErpgJHJM+GH98MI1geF0tjmb21sSQuJROo34BEUoAGmO+2rwOnddzz2/tCJsiqZMfClh0k3IbH2YHX8SLUHyRDjN76PjcVEyYRX
X-Gm-Message-State: AOJu0YwuVK5mS2ltESYoEV5eepzLCkhf1ZdbzkO/JEHMNNazVPISRey4
	BVf83zWtyQWvWYShZ6StkRNYN00b7sjGqNAvrOvJ6pl7jecM4nBcsgEZ7/5w2yXfRPh8l8zrRce
	CEw==
X-Google-Smtp-Source: AGHT+IF9jHQBMx7HHRXN2r3/BnsfkV4EgTV9iH43joZmts56mCZCJTCtMByf7Naeck2S/nbE8uoxQw==
X-Received: by 2002:a05:6214:f05:b0:6b4:ff5d:3ca with SMTP id 6a1803df08f44-6b61c1b2b5dmr78949746d6.40.1720638781963;
        Wed, 10 Jul 2024 12:13:01 -0700 (PDT)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com. [209.85.160.170])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61ba74bdcsm19400146d6.97.2024.07.10.12.12.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 12:12:57 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-447df43324fso56601cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 12:12:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVZdA6+ShWzVYvtkM9oKOZ5Y7n9Q90Zjm5ZWEwm9jRyiBondoXnef8dIR2/l2EIKEkv5mrpdfnLV8bqzlcGxlEzhQ6hfvsqs9ZiFkXU
X-Received: by 2002:ac8:6b94:0:b0:447:e76a:c04b with SMTP id
 d75a77b69052e-44d0aa46fd5mr520361cf.10.1720638777116; Wed, 10 Jul 2024
 12:12:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710084715.1119935-1-yangcong5@huaqin.corp-partner.google.com>
 <20240710084715.1119935-3-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20240710084715.1119935-3-yangcong5@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 10 Jul 2024 12:12:45 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UCvbuMbsuproyyDumezHa7eVQHQt-kWxmMwUmxXgh_Sw@mail.gmail.com>
Message-ID: <CAD=FV=UCvbuMbsuproyyDumezHa7eVQHQt-kWxmMwUmxXgh_Sw@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] drm/panel: nt35521: Break some CMDS into helper functions
To: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc: quic_jesszhan@quicinc.com, neil.armstrong@linaro.org, mwalle@kernel.org, 
	linus.walleij@linaro.org, airlied@gmail.com, dmitry.baryshkov@linaro.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 10, 2024 at 1:47=E2=80=AFAM Cong Yang
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> Break select page cmds into helper functions.
>
> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> ---
>  .../panel/panel-sony-tulip-truly-nt35521.c    | 29 ++++++++++++++-----
>  1 file changed, 21 insertions(+), 8 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

