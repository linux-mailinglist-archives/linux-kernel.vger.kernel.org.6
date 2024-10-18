Return-Path: <linux-kernel+bounces-372521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC239A49C2
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 00:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36E681C22105
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 22:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C492190671;
	Fri, 18 Oct 2024 22:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aODlrxz2"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94961187876
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 22:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729291766; cv=none; b=BO8ufBred78y3ViuyFONq6uXOdiIeClvYexclrHk9fXv5Aa0HLe8nKF47EJL1/4UZRe5t7e8qVxfgyWOMVG5ao9MxIsOWYQc/lN9AzddQCDbIFYb4TeFrl9M8m0q7fUppD/AtuQ5gxLEKOxOrF8lDf+SHCXJuqCaU42jQcJsdfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729291766; c=relaxed/simple;
	bh=1bBwuyzzVOCNx5VvAd10N7xgL2slk66JywXHsESICFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KFs6niaYtQz2clsByZaIheHYGD584zNCJMZfBLAxcVUZGR6sb1X0QTi4nRI8W7A8sodV3QyNKd9PezBEJ42u+iAxFHxV/rK5T4tYRV5qklAPSFaXgroZoUD8CJH+uSRQD3lQbs2H86iftc7Hh8BYCBzR1cvvogr6B49Utz3jD7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aODlrxz2; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539fb49c64aso3865035e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 15:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729291761; x=1729896561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+s7F+58hcUpSSjAioENK+2lQzzQuZ6ITMw0yi3ng4I8=;
        b=aODlrxz2egE2Ndi+RivO0gpKBgT4w7RlDti9FobiiIHtmXFqfdSfhrScs9Yze0HwA8
         tgKIPmoKBc36FAxoPLVxe7eSire5v+T0iK31y8thEOX/YRpezIMYTbkP8gH56IXUDvsw
         twZ7qLOgogSepxxqf4ws/l9KFU5E/Lhi2aPkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729291761; x=1729896561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+s7F+58hcUpSSjAioENK+2lQzzQuZ6ITMw0yi3ng4I8=;
        b=j90TiwhnBo1EQ4Bpj6phbd3eCXk0nqGsj2NaEq2s0ksfgC8luv0urZHO291jeEKyda
         IihltfaS2SSSZww+ujoLpMzUQXRYhLowCxpfRITngDxAOP+cJm6DMEhsUTAwjWPTVElq
         GKo7I0zwKB+N8VSSoP9dBsc5uvJHIqP8sV/NWsPomEDNvOXV7vPE3Pv6cG5ep71CngGi
         xDScZBNkjsylnB3qiL15XBHfC5b93wNk/B1wyU8ogGoGvqc8I8yNaYYmvnnf8ij36fyd
         RsknDQudrNRIeV4E3sZ5yXqQ4t+YSbP0n3oZ4hC3kWkpG/gM6wq1K+/dE0k1FhzWB9mz
         Dmwg==
X-Forwarded-Encrypted: i=1; AJvYcCXR6szBOc3j6puZ6J5x5fvA3a4+UuKPG6AoB82ffefFtq06wL4xM4pG1dcWPe0bR0QzUzhLTHVfHKIg6xo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMIPl5970MH6xOAsAN4DXJ2P6Xo3CvMEtMPBL4wgpiFdNc+rAQ
	1zgfPjeJpjrLnKErJjP0nOvVk1X25l+YKPKSwIriVZqoV52Ji/f3JN/p7jUdMrnbnckYuUIalU+
	MGw==
X-Google-Smtp-Source: AGHT+IHbJH28Ba4rTge+WvqhPB2yjxq6hyFtCnNNSs/9KhSjZI2B2JXumefulXywFLZq6ieJuGToQA==
X-Received: by 2002:a05:6512:1244:b0:536:a7a4:c3d4 with SMTP id 2adb3069b0e04-53a154c9f17mr4176367e87.39.1729291761309;
        Fri, 18 Oct 2024 15:49:21 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a151afe28sm341622e87.53.2024.10.18.15.49.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 15:49:21 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539f58c68c5so4169473e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 15:49:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWgO6TiMv2Fqu+3xAKG6cqsWOSUtledaLfEmjsgy/f59bhV19W3c0+wh4iW/TfYfQL1ElfF2F1FGVsS5lg=@vger.kernel.org
X-Received: by 2002:a05:6512:39d3:b0:530:e0fd:4a97 with SMTP id
 2adb3069b0e04-53a151cf94emr3965821e87.0.1729291759641; Fri, 18 Oct 2024
 15:49:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018163136.GA795979@lichtman.org> <20241018175540.GA796909@lichtman.org>
 <20241018223536.GA799515@lichtman.org>
In-Reply-To: <20241018223536.GA799515@lichtman.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 18 Oct 2024 15:49:04 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UaNLoJBuzp_qrCVdYaq=-OB+726mWu4q9DCeTrZhpv9A@mail.gmail.com>
Message-ID: <CAD=FV=UaNLoJBuzp_qrCVdYaq=-OB+726mWu4q9DCeTrZhpv9A@mail.gmail.com>
Subject: Re: [PATCH v3] Documentation: English fixes in kgdb/kdb article
To: Nir Lichtman <nir@lichtman.org>
Cc: jason.wessel@windriver.com, daniel.thompson@linaro.org, corbet@lwn.net, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 18, 2024 at 3:35=E2=80=AFPM Nir Lichtman <nir@lichtman.org> wro=
te:
>
> Minor grammar and typos fixed in the kgdb/kdb article
>
> Signed-off-by: Nir Lichtman <nir@lichtman.org>
> ---
>  Documentation/dev-tools/kgdb.rst | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)

You could have kept my tag, but in any case giving it again:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

