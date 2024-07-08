Return-Path: <linux-kernel+bounces-244998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AF492ACD4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 02:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04EA71F220DD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 00:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1931153578;
	Tue,  9 Jul 2024 00:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N0AlmxtG"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B9F78C88
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 00:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720483216; cv=none; b=ugLo4MxVVUN0R5ZSbHxy0EPbmYiN0HfZ6xdYzKrMqoRDbZc5ZSk4cTHz30Rv/t/GKk2CHRW8tQVCSOiDy8uSlwC39tblCW3Ggb8hYbkCCvCaGl9JNOAUIdXUztlmTKO/mxMEsOOrYFfn1+/hFfoWCzm3fG0tXZcrtqRwJjWaq+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720483216; c=relaxed/simple;
	bh=/QOqCulkZsfJOvKr8tAyY6TDc5VsuMJQgVKvIy7i6Qs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HOn5BiOQOeZQKYKLnKDh71xuDR9DWoSPM7tqi8B/ZB/CVe63jQ1NGBo+eg4KdFpHcMbC1gqw6wjKx9pON2JwrlWT/+wxsjHLPPy0J71UxM96f17yU+CVKEnEYFHX6jIiYqYIX1klF8UHq23LmtCOqqC/Vl2Wb2BFQKwsZL0LfQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=N0AlmxtG; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dfdb6122992so3920725276.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 17:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720483212; x=1721088012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=osmmEbE4YrUJJsgw8B/lNsRFY328cYQyEWy+PHmk7lU=;
        b=N0AlmxtGWogx00M0ebnvDMXvNXVOHpbM+JeaXuuGff3UujfIEnv+9HSLzz3pSVrIJ4
         /Sau7eKa3zFTzlwbNuOzL9ZVcp/jViZmsIwbR85VgcFQ0/f6zXnrH8BlmofulgqTnB7z
         cn7AROibVXQm6cHNRA6O7oMdKZNZ2il9bMm5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720483212; x=1721088012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=osmmEbE4YrUJJsgw8B/lNsRFY328cYQyEWy+PHmk7lU=;
        b=txy1OaQYSr30xWyEyJa0fQk2IBAUCqiS22jg4uO9hTSKwGqluu5+ymYCFZT0QTtOKM
         huBaGdLscub0xJ61VrASh2bU7MwgzHQIXd7PVQInpSUO2b2BahjiHO3AQvIhK3Pnan3c
         xq0hrgJH5GSMC76ocDuUcgOLxup1hD6A4TBYZlWX8PPid3aRnuuVE9UxbG3yHdfPAO1S
         bw5VpCp6J9HTHcCZ83Llx8fLcBCO2YpSo78mETYQIDJnk4xfnoXiPoQfXKIwFX6kon5J
         CZ9wSF8O3aq2PVhW9ph9kKwxlB4Zw077V4wa1lYw7UNrrVCdaAK/n9Zh90F/ptfLJwvh
         i9sg==
X-Forwarded-Encrypted: i=1; AJvYcCW2GbGCeEJmDzkqDaGixHPdiYd3yGp+t54JpB8MVy9nhchHifJTqGMQX01jHjpvA8/fRPJ0mlIq1kVKMArpni6mC732l5LDmD+KThmA
X-Gm-Message-State: AOJu0YwHs0noGlm3JmU+rc6OWcZzBANHLs5FNGkQENLTCemHrq2qidOa
	+Tl0+ME9UB7o/d0MUBd3sLaumxH7/ZyJjhYSkl3W8GEjB8Yc3h4xC3FeO+mv44VWScQ+JoWHp9w
	hHuEh
X-Google-Smtp-Source: AGHT+IHa3FWbjIf4ebSeObf/ajHO7ofdPut5WaZnpBa61sXkwBnUYET5mtLQa+BV2SyreeCUfIe7ow==
X-Received: by 2002:a25:26d0:0:b0:dee:7fc3:ad6a with SMTP id 3f1490d57ef6-e041b178773mr1304495276.56.1720483212183;
        Mon, 08 Jul 2024 17:00:12 -0700 (PDT)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com. [209.85.160.180])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61ba73c6dsm4000016d6.90.2024.07.08.17.00.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 17:00:11 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-447df43324fso77061cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 17:00:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWKJRCqTLPq31gHWwS5st7/GZKbuUOO1CVHMj1VwNVVv38VMVQiNrUeqTA8Q2yID9U9sHXFUA3e740h+Y9oZaNLGlnub23sddBjDNys
X-Received: by 2002:ac8:74d:0:b0:447:f21e:4d5b with SMTP id
 d75a77b69052e-447fba68a15mr1320821cf.18.1720483210739; Mon, 08 Jul 2024
 17:00:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704101805.30612-1-johan+linaro@kernel.org> <20240704101805.30612-4-johan+linaro@kernel.org>
In-Reply-To: <20240704101805.30612-4-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 8 Jul 2024 16:59:59 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VHOTQKNNbkWX17o57weP_wTm__MCSGPhFHQ+uG1CD+Bw@mail.gmail.com>
Message-ID: <CAD=FV=VHOTQKNNbkWX17o57weP_wTm__MCSGPhFHQ+uG1CD+Bw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] serial: qcom-geni: do not kill the machine on fifo underrun
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 4, 2024 at 3:19=E2=80=AFAM Johan Hovold <johan+linaro@kernel.or=
g> wrote:
>
> The Qualcomm GENI serial driver did not handle buffer flushing and used
> to print discarded characters when the circular buffer was cleared.
> Since commit 1788cf6a91d9 ("tty: serial: switch from circ_buf to kfifo")
> this instead resulted in a hard lockup due to
> qcom_geni_serial_send_chunk_fifo() spinning indefinitely in the
> interrupt handler.
>
> The underlying bugs have now been fixed, but make sure to output NUL
> characters instead of killing the machine if a similar driver bug is
> ever reintroduced.
>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/q=
com_geni_serial.c
> index b2bbd2d79dbb..69a632fefc41 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -878,7 +878,7 @@ static void qcom_geni_serial_send_chunk_fifo(struct u=
art_port *uport,
>                 memset(buf, 0, sizeof(buf));
>                 tx_bytes =3D min(remaining, BYTES_PER_FIFO_WORD);
>
> -               tx_bytes =3D uart_fifo_out(uport, buf, tx_bytes);
> +               uart_fifo_out(uport, buf, tx_bytes);

FWIW I would have rather we output something much more obviously wrong
in this case instead of a NUL byte. Maybe we should fill it with "@"
characters or something? As you said: the driver shouldn't get into
this error condition so it shouldn't matter, but if we have a bug in
the future I'd rather it be an obvious bug instead of a subtle bug.
I'm happy to post a patch or provide a Reviewed-by if you want to post
a patch. Let me know.

-Doug

