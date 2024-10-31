Return-Path: <linux-kernel+bounces-391431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 072959B869D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 00:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D0DC1F21AEA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 23:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03F01D12E0;
	Thu, 31 Oct 2024 23:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XkIovhKV"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC94197A87
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 23:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730415987; cv=none; b=HCTkz6k61IZZY4F8MpahRPX5roxx7BLOZ/PGqQRQuZvvlRTTq7iKCeLw0M4zhJvd3JjpkmieswqqdMWUqMfUu4buGXKO7hRza45nocrky1HYd9vZG1+CikoaTPULv1zhVppLAFSkMkvx8ndXWdDVrSa7xFuUwCIzmSjrg3IxIUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730415987; c=relaxed/simple;
	bh=PPVDI2IVlfWT3HYsIyOCojyn1W68WzuwhUUMNivVEl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=faMYR4CfzeZn2GAJBMZ2PUEiN5Q+alCx/nu1f0HBVHJ/t/8NhDt5AOIjKI793yuG53RZbxSYZ+vhQ9n6yVNfylCb+e9nspRsYDTt0vnIScN/H+8HqVbTrqQAqORSPYwOg5UPIgpcQLkndjfX8rPyEpuxq6NUxPN62225wRTvlUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XkIovhKV; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fb3ce15172so24038551fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 16:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730415979; x=1731020779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PPVDI2IVlfWT3HYsIyOCojyn1W68WzuwhUUMNivVEl0=;
        b=XkIovhKVV+JjFcU2gKPyvDN4/jfmYC69D5uam+fjtt1Dv0+Z8o24DM/V6LnNDdybfc
         MdMK/l5cxW09xsiCI0zSg+BlTDcsUGcfp8MNzeOO+k2eg6mdRe6KhHKRaNBgottDuDh6
         aoV3juzSE6+x0miXGJPeTBvRvloVlQRGBTS2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730415979; x=1731020779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PPVDI2IVlfWT3HYsIyOCojyn1W68WzuwhUUMNivVEl0=;
        b=B76gadTJpSVDajHJWTsuCLUBbyFqsG6WPLgdjhdf48O8zBSr63ZvYTHZnorHbAEE54
         7fqplPOHMKbqGLIVSqdNfwb5wg9TjcoLeKgvw95D9IrLZbSIekYD3PYvyZ+UffasLcdT
         gJpLQQCovlRYMKgjF2AX4fTo8hfrG2u0cVrwED2q6aeze8XcdNdjBsZHbCPGtsgKyGhX
         Gm9vc6+f7AnpPANQxKX+ye18m/R+0N8yISdfFHJHp5zV2d12STMYU15/cCFQOgU+e6Tl
         JuIRnW/1Ng4TllAZxjLZeKMhc4xW9rUzUPaODLlGg3JI1WS6N5WcTFhUbuDb2pDReHqp
         9+Lw==
X-Forwarded-Encrypted: i=1; AJvYcCWNFm4ccrhYamx23IFyUiMrbE/Zv4garlXoKOQ8cgTQ0WLZ7mSQpooQhXTJkaWXknVZSV9fTrSekBKb50w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXcHie1gUbYi7tCRdEQ85JaRS2ab0JWgQpJ9GTIK+iyVyCsWmm
	wI2GbXx2Wq2oNou7FjhS4HXW1uapCH0jETYEytPYk44qx+K9O+q2CHfcFT75GzHTLFvgtWoC9sz
	A7oDX
X-Google-Smtp-Source: AGHT+IH1PgVO1N9o/lxB3/QVzOWHbZl/lLNDDcwXsvVhFEm3d5ljHV9Y7cd9ow00vcA3tllm9o8b3g==
X-Received: by 2002:a2e:bc1d:0:b0:2fa:ce0d:ec34 with SMTP id 38308e7fff4ca-2fdef231127mr13724481fa.2.1730415978752;
        Thu, 31 Oct 2024 16:06:18 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fdef3aeca7sm3514221fa.16.2024.10.31.16.06.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 16:06:18 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53c78ebe580so1545650e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 16:06:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWKCJdAlHcqIFxwQ2mdrxEdby16k1Ne9XJQtqmHOtWmgpzEmn5gTwX+5QVOjYDiwsAb2JQZ0FVUGCZYDj8=@vger.kernel.org
X-Received: by 2002:a05:6512:3b86:b0:539:f6b1:2d05 with SMTP id
 2adb3069b0e04-53d65d96802mr508896e87.9.1730415977461; Thu, 31 Oct 2024
 16:06:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031192350.GA26688@lichtman.org>
In-Reply-To: <20241031192350.GA26688@lichtman.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 31 Oct 2024 16:06:03 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WC-ce14rgrYsVbg75dNX5tL6Saj5T8YqpAWm2ndLGdXA@mail.gmail.com>
Message-ID: <CAD=FV=WC-ce14rgrYsVbg75dNX5tL6Saj5T8YqpAWm2ndLGdXA@mail.gmail.com>
Subject: Re: [PATCH] kdb: Fix incorrect naming of history arrow keys in code
To: Nir Lichtman <nir@lichtman.org>
Cc: jason.wessel@windriver.com, daniel.thompson@linaro.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 31, 2024 at 12:23=E2=80=AFPM Nir Lichtman <nir@lichtman.org> wr=
ote:
>
> Problem: The kdb CLI code that handles the history up and down
> navigation incorrectly names the up and down arrows as ctrl p and n.
>
> Details: This could be some kind of left over legacy.
> (maybe inspired by ddb which only reacts to ctrl p and n for history nav)=
.
> kdb doesn't react to ctrl p and n, and following the code flow with GDB
> reveals that these values map to the up and down arrows.

Really? kdb reacts to "ctrl-P" and "ctrl-N" for me. It also reacts to
"ctrl-F" and "ctrl-B".

I think the code as-is is fine. The arrow key code just converts to
the arrow keys to the (also working) ctrl keys and by the time we're
here we just need to react to Ctrl keys. Ctrl keys are 64 less than
non-ctrl keys and so the definitions of Ctrl-N and Ctrl-P are correct:

>>> ord('N') - 64
14

>>> ord('P') - 64
16

-Doug

