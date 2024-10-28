Return-Path: <linux-kernel+bounces-384975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE84A9B30E1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5125C1F20ECD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9B41D619E;
	Mon, 28 Oct 2024 12:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eeke3Wrr"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A811143888
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 12:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730119708; cv=none; b=tROuV/1NkEhV06KmvzwjNge9cb6VU34tRxD7G2v4/6CWYjPgis7n7XsYT2uv6Zb4caYONFP518pO75Js6nj4BEWZ17ADhcntPoEfBTJoqfTDGxmVt6X9YD6bA0zMDVh+ZGUf8D0RIwyVg/UWr+z23aHGiEpOKp130y5PbuaPvks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730119708; c=relaxed/simple;
	bh=0ZWUNAZkjh4i8ZHz1Zb5tdNt6cnIl0djDk4m+REDOoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=chEsAtcL6bjRARzpap/htzxgRwI+UbAinJFnggggdGZwBRd9+fW3BdoLTw3dPiiOm3aPyK5q2fqoIsj99LIl+a+G4khavXFGxjBW4NlnjVPX4Wjcdqro0Hx5vt0meuUKm6V8AQ4XbkSjJrwSe3n7Lexw7cSVD8EtIfULC4vmZ7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eeke3Wrr; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53b34ed38easo1590378e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 05:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730119705; x=1730724505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ZWUNAZkjh4i8ZHz1Zb5tdNt6cnIl0djDk4m+REDOoQ=;
        b=eeke3Wrr+2FLsBceRTjaESY8mRoFN8QBtdJ/Y7rZ/vH5f12LmbWhbD2ErMPo670ub7
         kTcEHBQoQwfELAyPIWs70d//FZkTFATxD48oTHeDtEjw/c0mQaVJ0K18R7DYYEn7TYy/
         nDARCJzpWhq28yqnT/g5dbxuOmvcGUwTukPl1UMU6DlcyP7PmzQOpXxXv/P+37MRuN+3
         1lI5P5o0LFEHHw8cr6VDzhZLB002NOn9HxdC1AgsfJkrAhVz4D08KNA+EVyhHSF3yFwN
         LWpRgkIw759JEZgEAuYKeXntXWNK048OoxnCIJHPNun4qCqSCUDZRlqeGuFWQ49l6O1D
         afUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730119705; x=1730724505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ZWUNAZkjh4i8ZHz1Zb5tdNt6cnIl0djDk4m+REDOoQ=;
        b=kYJ7fAhbr9LAUL8xTfOZuxsQThHfOr02YBX6LneBmRXW3ZvnvuHTgRjc+zo1WnvznS
         SYTMDfOfCdWasf8irsdYmXQBWLhfq7+XPBjUpYj0siP5tmn2yjRMw1xqnw5jDKIpsBf7
         8Tlmpb1qvXVy1Argl4ZhRv7Zew2whYkYzDiM891tcxva4NGHwDNtyJqx555Tw+mn3a/l
         Y2bh6bCiNI6Mw3E1C1xhJRCKzy8k27+e1zNHXaILEIV3MuCrhBJGEFhy25UonMN7RxTN
         jo4lD4LUIrrzCQGkMcLDPbJTez+SBXpyQfyc7z76EVcTzvvq2QLQcvXREkvdEhcOxtaN
         xCeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKy3VQOBsC81hVreMMkb5th/UkE0zhyqSg13edtfD/Cj/RcgevYrqa/AIZPtnJRUxcXcQ6C097mEtDK6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrkpM2jhhL9uMZOTNFOLIj+54H8hckiNJmk3Y7S1HU2ssVrqU1
	pK5SrU0n52UtJchBgIcbzd+69qZBIU+kW/1DC2bzIAdy9b6V0fnrnzvh/W2ygS4palrhpWMlYjL
	FwD5mypvwB3/OrWz4aSiUSDJ30pimGCBIJsOK6A==
X-Google-Smtp-Source: AGHT+IFrhvMjX8/aa8jqHoP0zpK1RRQOqtmj3IzPoyyxAnyjxTz9eMa0cucI5FygR60Ev97yHT0Ebri7gJ+jD6p3Y2Q=
X-Received: by 2002:a05:6512:3e1d:b0:539:fde9:4bbe with SMTP id
 2adb3069b0e04-53b348cb110mr3322609e87.20.1730119704740; Mon, 28 Oct 2024
 05:48:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1729865485.git.namcao@linutronix.de> <f4e18d2fafd5a412626456ec3d5be427ad1035e2.1729865485.git.namcao@linutronix.de>
In-Reply-To: <f4e18d2fafd5a412626456ec3d5be427ad1035e2.1729865485.git.namcao@linutronix.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 28 Oct 2024 13:48:13 +0100
Message-ID: <CACRpkdbVsWs9anBodguTKtRhftUsYO8buBgkYn_j+qDADyMGZA@mail.gmail.com>
Subject: Re: [PATCH 16/44] power: supply: ab8500_chargalg: Switch to use hrtimer_setup()
To: Nam Cao <namcao@linutronix.de>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Kees Cook <kees@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 8:35=E2=80=AFAM Nam Cao <namcao@linutronix.de> wrot=
e:

> There is a newly introduced hrtimer_setup() which will replace
> hrtimer_init(). This new function is similar to the old one, except that =
it
> also sanity-checks and initializes the timer's callback function.
>
> Switch to use this new function.
>
> Patch was created by using Coccinelle.
>
> Signed-off-by: Nam Cao <namcao@linutronix.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

