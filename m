Return-Path: <linux-kernel+bounces-325576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF652975BA5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 22:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CD94B22B53
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 20:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE2D1BBBD5;
	Wed, 11 Sep 2024 20:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mWVV6MMU"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B088C1BB68A
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 20:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726085995; cv=none; b=aYyPf8MbbVBJc3kp0A6vlqwec9+wpk9pkdUhbU6l1S0D6/cKVLpAl+BTzxAJauaDl6iqa5/ZrhXnAaXJ9LnJfbRLwcUbTjDDiGUYbuSgfqMScpC44qKJDCFiakmyIlMv3YT+OKf8WaBXS4RtAv7p9QqTXCiennuXkmeDtPM8PGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726085995; c=relaxed/simple;
	bh=LNjfIqdnJ7xDwaFYjSU3zgI/rR85Tz4XyQ8E2ga59QQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mrRRGnkb9Z+ym+yf6ccrdFiU6boO5NLS/RAOoffmAtwZb45kSIxayHwV9136rVaMh0/dNtDAtBODCdUB6I6m0rpqxqODHBbMLRFTsE5fT1JUS9iiPB6yG6jPrqxpahy6S6f7OP0FThtgZHz0iOvJooT+p0pDcRpPX+zzFVBiF08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mWVV6MMU; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6c53bc6f9faso1401306d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 13:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726085991; x=1726690791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQ2fUDORmV/sdyoK/2gbNCgI2EeD5lNRSWNYdKecCGo=;
        b=mWVV6MMUA0Zol+1l85DXRzqYPwBYiA/Kvt+N6uPiHR3O4XwwC1yvtIyxnOLC9c8VMF
         cwpPWd8p4LUi4c46+bo9h0nuQHIseMS+cH4cnazfl+5+iZxF0vxzEOTE8gbbFoygz3Ts
         8U0+iZTW/tezO0oCpUG+YSO+DPkuPW0epRa/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726085991; x=1726690791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mQ2fUDORmV/sdyoK/2gbNCgI2EeD5lNRSWNYdKecCGo=;
        b=pHSMwAKG/yqoKPbYPXNUyKuPsNpXhAsd3+E4n/Nrn+zj0p1v+5NN+FUqLrRQTTEUJa
         lSOgG6fIyIS6QPhqB73Cu45hz5rKAybzUhRPbL/+CJ3k21I3asdl3sGCGPp/USyP7QEM
         JnX07QnN2lu/UgLaVkdU5IM4Z0C2e9NGyF6jnsMEfN6gw5MPverV1raBPFIrHcy44dbg
         T+naqigHp4mDVlRRWojFdhdr46t3iKbtUAFV5d7+GTE1hOgoVkPNLlXGJRP1tnxvA2zJ
         8mDeuDgm50TmzwismFUkKSDsSKaTeS4t43fA26iUbSDLER841MoNK/AsTc8UoXiCHO7V
         /kyA==
X-Forwarded-Encrypted: i=1; AJvYcCWmmRz5mUxxAygyoYJ06IZIppVir3tRy/D87Nd8Hp/wPwyfzapxe7QWOsIyyeKqGLeQznPmIuCVOUKQDCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmMDNxlOYhVevLB6lm44vWB6UpiF3Yx0AdH64eBsP7eFKnpQ0J
	64SWQGEPCPa1iP4Fhml2fJE30MxHhJHBjbvHo5O7nhjk299aCBE6pxs6VSx2vSlerq2fz+tiGuk
	=
X-Google-Smtp-Source: AGHT+IHGRn2O0/9LtBUnZ/JfyEVnRuar0eP+fB1PbevUOJtnurOF34vXdFowr/a2m4N6Fn7mnAc87A==
X-Received: by 2002:a05:6214:598b:b0:6c3:55be:23a4 with SMTP id 6a1803df08f44-6c57350b90cmr9939036d6.1.1726085991153;
        Wed, 11 Sep 2024 13:19:51 -0700 (PDT)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com. [209.85.219.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c534329544sm45424456d6.22.2024.09.11.13.19.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 13:19:50 -0700 (PDT)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6c54a5fbceeso1137436d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 13:19:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXCHTORWF4GGF1+hXaZDZc36DXakwf5/guY451VjBL0QITYV0zIVrPahyh+8vEy56EI4QDNXlyL3d8DaQg=@vger.kernel.org
X-Received: by 2002:a05:6214:448c:b0:6c3:5597:406d with SMTP id
 6a1803df08f44-6c57347eb8dmr12957366d6.0.1726085989561; Wed, 11 Sep 2024
 13:19:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906131336.23625-1-johan+linaro@kernel.org> <20240906131336.23625-2-johan+linaro@kernel.org>
In-Reply-To: <20240906131336.23625-2-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 11 Sep 2024 13:19:38 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XBVct4e4oe+KP1_2FuFjZ4tsX+FavK56FUnrOfZfP=fw@mail.gmail.com>
Message-ID: <CAD=FV=XBVct4e4oe+KP1_2FuFjZ4tsX+FavK56FUnrOfZfP=fw@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] serial: qcom-geni: fix fifo polling timeout
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>, 
	linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 6, 2024 at 6:15=E2=80=AFAM Johan Hovold <johan+linaro@kernel.or=
g> wrote:
>
> The qcom_geni_serial_poll_bit() can be used to wait for events like
> command completion and is supposed to wait for the time it takes to
> clear a full fifo before timing out.
>
> As noted by Doug, the current implementation does not account for start,
> stop and parity bits when determining the timeout. The helper also does
> not currently account for the shift register and the two-word
> intermediate transfer register.
>
> A too short timeout can specifically lead to lost characters when
> waiting for a transfer to complete as the transfer is cancelled on
> timeout.
>
> Instead of determining the poll timeout on every call, store the fifo
> timeout when updating it in set_termios() and make sure to take the
> shift and intermediate registers into account. Note that serial core has
> already added a 20 ms margin to the fifo timeout.
>
> Also note that the current uart_fifo_timeout() interface does
> unnecessary calculations on every call and did not exist in earlier
> kernels so only store its result once. This facilitates backports too as
> earlier kernels can derive the timeout from uport->timeout, which has
> since been removed.
>
> Fixes: c4f528795d1a ("tty: serial: msm_geni_serial: Add serial driver sup=
port for GENI based QUP")
> Cc: stable@vger.kernel.org      # 4.17
> Reported-by: Douglas Anderson <dianders@chromium.org>
> Tested-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 31 +++++++++++++++------------
>  1 file changed, 17 insertions(+), 14 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

