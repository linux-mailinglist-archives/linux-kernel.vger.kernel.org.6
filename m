Return-Path: <linux-kernel+bounces-344592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 284A798ABC0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 20:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 565ED1C212EF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8201990CD;
	Mon, 30 Sep 2024 18:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="opX7zek+"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C403E1F947
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 18:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727720078; cv=none; b=GWSeCqox3cgsD9uTwFdEmikaswv3fLRFye0PVsBxm9KXcn2hS0bJTOvYpQF5xIZ8kswZOOd80Adj6zgaJZ7peQ1i/IOz4dm3xK5He+uwAU/1IxGXP/RZV3Ln5pA/MgYWaL0NSuhosE+9urGR6Hk7Rb+nPqWx1PoIdR7DcuXM//E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727720078; c=relaxed/simple;
	bh=6F+/q0/jRva0c2EPI8M6r0iUZiDuLIyyAisz5ZI78Yc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fnjGfejZ/RucDIuZP5YPE1NrHZxq8lw9hfgkInFTCAcxtwcNyO4yerUTSJ9WfR+UsyA33yVc0pMxHZPCoYi9uWoWK94iQnWMYJkqK+xLoDJPbgF9eATXIL3fhzkSDxtNUl33B994I61DnlTgcjISNwQviZaql0x40yvTPSl6K28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=opX7zek+; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cb806623eso36313875e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 11:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727720073; x=1728324873; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=BnuPu2GyBAH6sHexBsv2SDLbI/yG/KxkbgJVgNvLoIo=;
        b=opX7zek+sIefpJuT7AIWb/kjyC6yR1AJ/8JtQMuGWt6jV+elTij8jI5Zoe9wqKSdde
         5kOddsdLLSSimHLpLP6BXprapMbuHP+O3TKRDjuwVWJLveF+NK1tHTz3HY8O276FR3pc
         90y0saj4iKzJDawOx3jRjf4G9mCV/2z0lzqEp1ZfxtiiJYWR9TpGDuEDFBoXzHNip3si
         D/IVpD0r4OBw9MOjmu7gCsZktEZjdLJpS/rlq4hLredL5lGwT5ulIulgEKWrm8pEWLQX
         7mGb4vrImaWMcypFdU2lk5JzI9nwvcHbiFMeXlU5MRmcVlerDeUBAsG7VoV3Dk287y9n
         NFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727720073; x=1728324873;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BnuPu2GyBAH6sHexBsv2SDLbI/yG/KxkbgJVgNvLoIo=;
        b=XIT2sagVTDQEaSMWdw5ZZcOf8aicPmx86Va8P2rmAlwec+uj6JAnfZf5Qk3VU2tdBk
         7Tuo10kw9FZ4u5ZMpxnZzn5/cHSnQF+19mocumpFbN5oxzZIm+sovdQ+WgE9Zh+8OAMR
         vuDbGyQaCyqgD1VCRRXydJeBPD7AoHuGMET39eHSuiDVIQeZZAgNoh/TnkvkLqlVC3lM
         yf3VNozFc+KLKlxG/ecPV6cHWhG3X0Q/7/0sSO8y8MFuJh7OFffrXLrvhiFC5zdJM7XB
         HbcxT6qDtUpkFBxn7r06LQvvx9MNBOI7jy5pb359WOBxmVAn4Ow7ZVYiKXkWnbZp+3Cf
         0Q1A==
X-Forwarded-Encrypted: i=1; AJvYcCX40zLLPAnHFL3hZ5K/S7dJjeKWRBmUHAkfvdioBzrK9qQrRoMfP1yV5VMomladaXerJoNPS9eMt1vvJ1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEvhYRAJVZkdCfBwdh8hkd9fVu2SmkyYb1AiHieDQ5ZScnxZ1y
	CBZnqyl1yVJYE2OEjhGZpXWHtW7wLG5gUygR6GgdNVh41OgsaalP1CjLf8qsjZE=
X-Google-Smtp-Source: AGHT+IFVbFICq/gutzSxAKiw5gYsrp87+XDgg3juU+GA1eGUW05qmSByQBe9AmAMhqxRW7a0aLW0qA==
X-Received: by 2002:a05:600c:4f92:b0:42c:ba1f:5475 with SMTP id 5b1f17b1804b1-42f58484eacmr94026735e9.26.1727720072714;
        Mon, 30 Sep 2024 11:14:32 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:b6ba:bab:ced3:2667])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e969ffa22sm157539545e9.25.2024.09.30.11.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 11:14:32 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,  Kevin Hilman
 <khilman@baylibre.com>,  Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>,
  linux-arm-kernel@lists.infradead.org,  linux-amlogic@lists.infradead.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reset: amlogic: Fix small whitespace issue
In-Reply-To: <20240930-reset-align-amlogic-v1-1-f64ed5c4efc1@pengutronix.de>
	(Philipp Zabel's message of "Mon, 30 Sep 2024 18:55:56 +0200")
References: <20240930-reset-align-amlogic-v1-1-f64ed5c4efc1@pengutronix.de>
Date: Mon, 30 Sep 2024 20:14:31 +0200
Message-ID: <1j1q11t3eg.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon 30 Sep 2024 at 18:55, Philipp Zabel <p.zabel@pengutronix.de> wrote:

> Fix a checkpatch --strict issue:
>
>   CHECK: Alignment should match open parenthesis
>   #48: FILE: drivers/reset/amlogic/reset-meson-common.c:48:
>   +static int meson_reset_level(struct reset_controller_dev *rcdev,
>   +			    unsigned long id, bool assert)
>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Thanks Philipp.

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>

> ---
>  drivers/reset/amlogic/reset-meson-common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/reset/amlogic/reset-meson-common.c b/drivers/reset/amlogic/reset-meson-common.c
> index a7b1b250a64dbf94530d06138f4270fff8f56d7a..38a767c06fc71b6dd8a998958b20592499db3c8a 100644
> --- a/drivers/reset/amlogic/reset-meson-common.c
> +++ b/drivers/reset/amlogic/reset-meson-common.c
> @@ -45,7 +45,7 @@ static int meson_reset_reset(struct reset_controller_dev *rcdev,
>  }
>  
>  static int meson_reset_level(struct reset_controller_dev *rcdev,
> -			    unsigned long id, bool assert)
> +			     unsigned long id, bool assert)
>  {
>  	struct meson_reset *data =
>  		container_of(rcdev, struct meson_reset, rcdev);
>
> ---
> base-commit: 5b93105afcdcdb94d654f253850c5432555b283e
> change-id: 20240930-reset-align-amlogic-cd4076c1421e
>
> Best regards,

-- 
Jerome

