Return-Path: <linux-kernel+bounces-553348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18600A587EC
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 20:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2545188D64F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 19:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE3F21518A;
	Sun,  9 Mar 2025 19:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nG9+PLoA"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA8D2163BA;
	Sun,  9 Mar 2025 19:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741549641; cv=none; b=sTn+P1tYNqVIFw128xTWBi5LswI38I0dJ5WBWBlIlmmDK2kcLrAfpvDmHCP+ZYrH3ob/d1BUehV0hGOmT7FZiZPn0M0DyUfx23zWxew5NChyfwaVfWSebwVF57jAwPZCmuObBlogKnlr2PBTv1NMzQFu55JHz1mn7zy19gjQEIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741549641; c=relaxed/simple;
	bh=LuzCRHnvpuVhnMqDA9xglWfZmtVj74QioTOIWbfZG+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mTs01cYD8UwGFa9aUUvxUSnYWnOxhxilW4g9GtMZM2ICItKSdldi7vzpV6Q6MS7rowIwIGtP+sY6TXC5j+2N290bZCP6oN0Hn1M5lr8lPNHKjJeKDu+0L9sGAZc8o3ezN18G9Ix3X7gSBCSUZgJgm4BDAfYBbpeoMGjhtrLpb3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nG9+PLoA; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ff5544af03so1029532a91.1;
        Sun, 09 Mar 2025 12:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741549639; x=1742154439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6LXqbbpc96phjvhebW8GaL/4xLdI8mz4owb9MCS+rcg=;
        b=nG9+PLoAPLzgHVNpNWrITtm7B7DTZ+VQ+D9vQPHTFtOiXWolrcMkevj9sd7SWE/IUO
         6isVCWaso2QHzgqyne29iYbc8zgmwkSOon6JYL0KdEIH4UsaP8WQsdOXVRWUXycZ3xvK
         Tw1R4oLHdEu4pB0O7XP8nQvc3F2Wa9XklCZc6RkcBaT/1WcvLHiMtItcwFNdR7tRjvRz
         E6TEortOtjAY6aKubLHptDc1z0QrP3jfemEB7bTRGMGzOXR9YcMiPlTOG3PViy8Z37sA
         8/rnOUVLo0yrKWFa59abLOQtY/K+WFvacmE5EcJY6Yz3mfeQQLQAJdke+xuZRt5oQNO3
         Wxsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741549639; x=1742154439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6LXqbbpc96phjvhebW8GaL/4xLdI8mz4owb9MCS+rcg=;
        b=r+a+jBFiSsMc/QrLpP9KNwnPALXfA5cyksyyIlTxwCPLfyqL24337GE/yXPZ6DseQu
         gIPyxAS/cca/C6C43KEc6PvBm3/S0D9RrpPmAYj3mjobGXIAk3acxfey5OXXPFc445gO
         vP7Q/FrCr/2yLVUeOcwYWJhb5d6K4opU8vDb9et/DLUMfWd4xsKwHnyXcAT/+meyiIqU
         j+Q91fEdE+cGNgrui2Avd3O/3JdYcVlXR1UWW3Q/OvncsGtso0mZdd49bPbmFGDLOKwV
         hnoPaoVrLDPVFNjP5RQGscNISESwVecROOsfWezlmGZSbXxBrmeCsFYDtec9I6y4DW8O
         wwUw==
X-Forwarded-Encrypted: i=1; AJvYcCVZvtYW81eZl5em0ZQalAvVng93dfikDqqDWtUoHdKePvWedBVXSxUyYDVQAggjuGVBtbOPiSQLHoUH47g=@vger.kernel.org, AJvYcCXfyv/PyXr27iSJjsWLTM+hFBgPWj5wPuZ7N4nMTDSpEXeHheJWoO3gOGrxZh+Ri9PDlfYmyLsk2Khtck477kI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSZcJc4KuM3NIN9bWOPRynntKXM2aneWUXqxQ7JGM+xRH6J3Xq
	tyHxNTSce9RThdWC0ViFH3wofWX50JS2ZU7oesUJi3boeUiAI+JhAgaCoxwSAYM9HRlnl9eL4GY
	w+lp4D6y86CQT3cXD+8oNADM7RQ8=
X-Gm-Gg: ASbGncv26TQ3M8jgB9g1kW922fK5tbUtNKBeIBCZuvfIQ0V+5VDivKRqwmfVgovJsQr
	NRllRSOW6g2hSVz6gzBn6TJk8KRwM3artQ1Iyrso9KHn8EjkaTsoA4yoXvgRTrH1FahSiOnEpb0
	bmMgMdg3Du4QNltvNO6W1zPe6tVg==
X-Google-Smtp-Source: AGHT+IEyGullnBYUpXgIqNnZde5ax+LnWjNmXoc5mBjlSloy9jVLjoT+Z7rqVLpnZ+VUXcDmqjVvriv2TiJj8dycwtw=
X-Received: by 2002:a17:90b:1a91:b0:2ee:6563:20b5 with SMTP id
 98e67ed59e1d1-300a2891aeamr4197957a91.0.1741549639629; Sun, 09 Mar 2025
 12:47:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228170530.950268-2-guillaume1.gomez@gmail.com>
In-Reply-To: <20250228170530.950268-2-guillaume1.gomez@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 9 Mar 2025 20:47:07 +0100
X-Gm-Features: AQ5f1Jpm9dNa1Yf9UOig5trDFomD2EoZOqqA36NCirt76xK7EHSQNQGlZxXO5Wk
Message-ID: <CANiq72k2_vXpm=hTiLvCVkrSH10yz8FAOeBj5AQWMpoyjhUmTQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] Improve error message in case the original file name
 from which the doctest was generated from to mention the doctest file path.
To: Guillaume Gomez <guillaume1.gomez@gmail.com>
Cc: ojeda@kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 6:05=E2=80=AFPM Guillaume Gomez
<guillaume1.gomez@gmail.com> wrote:
>
> In case the conversion fail, it will allow to get directly the file name
> triggering this bug, making the bug fixing process faster.
>
> Signed-off-by: Guillaume Gomez <guillaume1.gomez@gmail.com>

Applied to `rust-next` -- thanks!

    [ Reworded and removed an unneeded added parameter comma. - Miguel ]

(For instance, titles are supposed to be sort and use prefixes :)

Cheers,
Miguel

