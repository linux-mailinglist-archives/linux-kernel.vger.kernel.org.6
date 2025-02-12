Return-Path: <linux-kernel+bounces-511251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DECA32858
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 15:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BA8E3A74B3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 14:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E40A20FABB;
	Wed, 12 Feb 2025 14:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vtn/DO64"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8D120ADE6
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 14:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739370360; cv=none; b=OhIJJr3vNr5P5j6EKpX3EUNzKPNW/K/Fhiaxo5DT10JypwOu5IxZNQNFiS+PfzC8qcWQfsqj7U/0c54P5/j/oXi2LJnFaJf0A+79qFhSiTgB3l1rg34loqpceRXq33bijiY8o9VakKgCyJqUlOP1UO8z2HqcayiNG2qaJpUakzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739370360; c=relaxed/simple;
	bh=zcXWaRkaJjCIPGBiscSo1i7xmvlzhcHiUj4mQZlyTs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H4WUyzNhUtu10L6eR4lTxdYBL72iNFRon5yDhmnW4/r8BDuQqXT6iSw/D4K9I+m9R3II635TfD+Ntl+UgciA9y/srPB3uFuW9VkwckQ3EthWZA24/KOApvhXTd6Bot8gw90r09Ryxrq159DgNh74khTtPHnTWXz+J3864ZhH77E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vtn/DO64; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2b85131e68dso2989485fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 06:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739370358; x=1739975158; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2hK7UnJXH2AprjpvtJDB1m2Emp+3eQ1LxgiiYwfIphg=;
        b=Vtn/DO64WhC+TTtZ0ExQ03Rc7Pg+W/ys7IXSxP+SSI3nFvBfEBM66FS6ke3wHqfUc5
         Z/UDOIzzu8FzfF2dzLFNDK837Rq3x4PVz2C0km8wytw35F71qmJgUAPOYnaSWR1RPBpa
         ZA0cfyAPfHGb5ZVZFZ7r9ZHqduW9zsBCKdR+FXSoHjN/biQvNNBTnj0XHq/JgJQZma70
         qQ5PR6CXDm/JZgw29vKnJIaT7olsm9jPic2NAp2IcdsMIKwXEoZVELEeOGgNWbVRAXmx
         iyzgtpHRSvAMVRsI0JzZ1QYlsVlvc16S87gapN92LGJHMlR+UxEvPy1rf3kKCW3gJ1i/
         2Q7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739370358; x=1739975158;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2hK7UnJXH2AprjpvtJDB1m2Emp+3eQ1LxgiiYwfIphg=;
        b=GTwUIIXDJj+lNDiZ5rgPRsoyTkkaSgVlMKJf3Y80juYHb06eA0de4RPiMUvOLmgUe+
         aD/C+Mzdvb2ZDMj8JoavpA0bsQfqb3U12fCdJWA8JA+5DyvKkqM4/Atnq0d1+u7sjxMr
         sRFJvFTgdHaxOYvKi725990NVV7ZmGRoXDB4Jkd5YJNYwYC61xUzaLlPNxsfyoQSFNhN
         vf8D6koyg4CdZnRx7zPmLKSHqqLrlNqU9Qw8BI9y5GHe1dE4Ik3VFJ8hgXzB2f6TcQiF
         gM5zwRRt5sbojwkGxFeUiFcryz+vbP5Z/Idcs/BWdaM4U0Q0ZcLnUck7TxBk4X08DD3a
         TwKA==
X-Forwarded-Encrypted: i=1; AJvYcCXjPw3IDZVY195TiypMnKPPhfQrHN6bNb2aY+nlTCLCRbJ4Ux2OLocKmzuUbTLLGbOxZyWxbbG3kk3FKRM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfe/9eEVidpwk8tDqBm3F/mOEDeJ0uO9ohH/He5M6e2ugWmWy5
	XFSxnVeNUZkjDXvV6cbxNfPfdZfjtHHdViFFA1FJbeXtUfnQ5iXckIMC8kSEdoZ8L9BTpOgNfRh
	Go5+E7sCzRbgV2zRA+cA0Z652e4FP9jSSDP6yjw==
X-Gm-Gg: ASbGncsA2XxSkV3cGUimHgbquDt8FmKkHoBE9yGaRGI/BgJyjDEJXudbA6BPJC4vnnA
	RkQUUfRKPw25N+iJS7ZKEkaSfx135oAyeFWFN6S2x4qNpeWUM60rvf2tMNQl8GnDySY7HmrWFX/
	n8G3lO/9S5fxu/IG838e/Oen1+gQA=
X-Google-Smtp-Source: AGHT+IFuyxlXlPs2e+IscY2DSB/6uY0nP0Wzf+ASbJ4AIZ/oWACpaja7G9+Khx0xEQd/fq0SR42vVSonovhGGFkMhb4=
X-Received: by 2002:a05:6870:330a:b0:29e:5aa6:2bb3 with SMTP id
 586e51a60fabf-2b8d646fb44mr2246018fac.1.1739370358095; Wed, 12 Feb 2025
 06:25:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212-mhi-wwan-mbim-sequence-glitch-v1-1-503735977cbd@linaro.org>
In-Reply-To: <20250212-mhi-wwan-mbim-sequence-glitch-v1-1-503735977cbd@linaro.org>
From: Loic Poulain <loic.poulain@linaro.org>
Date: Wed, 12 Feb 2025 15:25:21 +0100
X-Gm-Features: AWEUYZn5XLF6zTakIKin9eoC74sCw4in5MQ3He_rxkMU8G3y_yrGsz2-CkgeaTQ
Message-ID: <CAMZdPi8pybqtKQq9irxwGwvW9y3EC=g9XkbZ4hthBkXQRUxUDQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: wwan: mhi_wwan_mbim: Silence sequence
 number glitch errors
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Sergey Ryazanov <ryazanov.s.a@gmail.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Johan Hovold <johan@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Feb 2025 at 12:15, Stephan Gerhold
<stephan.gerhold@linaro.org> wrote:
>
> When using the Qualcomm X55 modem on the ThinkPad X13s, the kernel log is
> constantly being filled with errors related to a "sequence number glitch",
> e.g.:
>
>         [ 1903.284538] sequence number glitch prev=16 curr=0
>         [ 1913.812205] sequence number glitch prev=50 curr=0
>         [ 1923.698219] sequence number glitch prev=142 curr=0
>         [ 2029.248276] sequence number glitch prev=1555 curr=0
>         [ 2046.333059] sequence number glitch prev=70 curr=0
>         [ 2076.520067] sequence number glitch prev=272 curr=0
>         [ 2158.704202] sequence number glitch prev=2655 curr=0
>         [ 2218.530776] sequence number glitch prev=2349 curr=0
>         [ 2225.579092] sequence number glitch prev=6 curr=0
>
> Internet connectivity is working fine, so this error seems harmless. It
> looks like modem does not preserve the sequence number when entering low
> power state; the amount of errors depends on how actively the modem is
> being used.
>
> A similar issue has also been seen on USB-based MBIM modems [1]. However,
> in cdc_ncm.c the "sequence number glitch" message is a debug message
> instead of an error. Apply the same to the mhi_wwan_mbim.c driver to
> silence these errors when using the modem.
>
> [1]: https://lists.freedesktop.org/archives/libmbim-devel/2016-November/000781.html
>
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>

Reviewed-by: Loic Poulain <loic.poulain@linaro.org>

