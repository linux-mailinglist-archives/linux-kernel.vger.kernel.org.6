Return-Path: <linux-kernel+bounces-576628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5389A71200
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06AE47A3387
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 08:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981761A08DF;
	Wed, 26 Mar 2025 08:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVh5qdtU"
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFB9157A48
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 08:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742976366; cv=none; b=S9lIAxqbsTew6rXtroYKBQ7d+8ICKNb3l/kxrYpGNts/tMVgIUm5zUHstnQMwhfzxs6jNfuTphRtLFe7zgA5HNKF1OEEGndN7crzSElM7EwQEW18++cWMigLSDKHNDJaEHuVOXk4+BWtjQ1kvruumIk2W4v3QvfyX4ZlpbyY85I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742976366; c=relaxed/simple;
	bh=fqtSiEWbdl9KiKlUVI6o2a5Tgr9ZxuUybi/5ay+aAMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iL9LKzLnS1gt2zY5q/nLNWBeHHRQXgopzfIOuabJQewTaOf7JnbIHjplL6Kw0yAf6Ni2kgtG1oyYk3i6Oz8OjlVI1c/dOokgBJsoQk8OJ4iyFbDf5F9mt9i4oby6f9C/PPauEgfO93LGWS+XdVYXBF4rOLtL3ocBUVSffyML8Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVh5qdtU; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-52410fb2afeso5454340e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 01:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742976363; x=1743581163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6kOvyvHEvdUACqpuxrtSqWcuiONSkskfUshgjr8oC18=;
        b=VVh5qdtU9W7qxN/93wzf/1B+Bv4OiGxmYE9vbBDjOxZ4T15chCZgCO+8mJVNflk/o5
         Ukx7Pw33lsPdfnK8TC7o7AS0L26hgN14qUxvv42QT9VwO4hlLOyPwhY8OFpr0WtEj/rM
         WVdAUJWeyJdnLmx6B+lSEwFX0cSu7GuoHpLyzGXXRze2rqvlG+4k4UjnEFXjFKcAStl6
         fdfbFttUBewFVXyv6st3a//no/KGI0E+69bYCcX7LV6vzDMDmPVyZ5L+1yEOy/ceLQP6
         fKhe2OH3xSCsjOL+jI9EasFEqD5lwbto8kUBC1v0aN74q0yY82WtJDSZf68jZhZPiby5
         Borg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742976363; x=1743581163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6kOvyvHEvdUACqpuxrtSqWcuiONSkskfUshgjr8oC18=;
        b=Sj2F5rDPxLn/7tQN+G5A7GLArbc+DxROgqoNVsjh6JwhlVUmbMhje3KSZptUqvJkQd
         RPTvQoqcGez2mJYmZdLHKPfPG0odLqme5Xo9RZ4vHRLC+UFGzoegBUoXxF7m901cPDoa
         L8fvl6HlI4qBLQP9cAiveoH5ekRlgBYMxobllPsYiIyVedgLa9svCMkDJv0ud8Z6sGaa
         Cnzf8JjaXySRNKV83RGTcOPml32VUcZm5Dqxtmr3VIz8g/2ln79v0veUOi94we2sKx30
         FHjnd7Z+wwgql80sPWByYnGkdda7BL/eQUbW0P5Mt+gcOiMmyC2Zlv9gZ/4jpg+dxpMo
         vA2w==
X-Forwarded-Encrypted: i=1; AJvYcCWPjlZpj1n2Uogkvn1jOLUMtho2RTez9zlTTFfrsTACkEamYj5qxGTB2QmLjLgxeKvj9eNiYTiI/ZeRhJo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0HzIo/bmhVm8YgeG9xVr4rACR8bPwS5hH6O2py6sAW514XL75
	Gb5lzpFEzxT4R8CzFe4JgRC6E3TWHsH0MrB6sDZsBzT9h0Iyul6P7oYmKpbdo24Mi7VTQmhHNt7
	H+ZCsgCPhiTzfjugGwZtjzGi7Vof+AnjE
X-Gm-Gg: ASbGncugFAK3c2fGHbrwDFVao12BNlh8MChzNFWG78uW2OdEUShuVSYh3BcpWOJnZXz
	GGw8AnnddwSdcDn7ZvorYwQilKhV1b+0y1R9z3PBb4scfR/mj+qIMv530SDdCCsgeAgiGgvw36A
	Z+fPDcrjZ5ARoRC7/dxkko51wwWaNc
X-Google-Smtp-Source: AGHT+IGaiUxSdccFQaMvg9pATNqqdFgJAcbDNlosomR26XlILMlL1OYPAoti+ujrGnDNnglOHPfwSS5rvk/fjhuHNic=
X-Received: by 2002:a05:6122:8c28:b0:520:98ec:b25c with SMTP id
 71dfb90a1353d-525a82fdff4mr13652666e0c.1.1742976363058; Wed, 26 Mar 2025
 01:06:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326072842.10344-1-karanja99erick@gmail.com>
In-Reply-To: <20250326072842.10344-1-karanja99erick@gmail.com>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Wed, 26 Mar 2025 09:05:55 +0100
X-Gm-Features: AQ5f1JoXPSOYVI_4jAAKLke1z-SXr8TqUC6EwQn4WF83GllMkHGlgl-V0RTLN8g
Message-ID: <CADYq+fa2T5k73ckaTgW36wM1BMNRQvYB+oO2fGYFOjvLH76WVw@mail.gmail.com>
Subject: Re: [PATCH v3] staging: rtl8723bs: Rename variables
To: Erick Karanja <karanja99erick@gmail.com>
Cc: gregkh@linuxfoundation.org, outreachy@lists.linux.dev, 
	philipp.g.hortmann@gmail.com, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 8:29=E2=80=AFAM Erick Karanja <karanja99erick@gmail=
.com> wrote:
>
> Rename the variable `mediaStatus` to `media_status` and variable
> `lpsVal` to `lps_val` to adhere to Linux kernel coding
> standards by using snake_case instead of CamelCase.
>
> Fixes checkpatch.pl warning:
>         CHECK: Avoid CamelCase: <mediaStatus>
>         CHECK: Avoid CamelCase: <lpsVal>
>
> Signed-off-by: Erick Karanja <karanja99erick@gmail.com>
> ---

Hello Erick, I think what Julia is explaining is that you should write
your changes in v2 here where I inserted
this message to you. Not to remove it entirely. Am I right Julia?

Adekunle

>  drivers/staging/rtl8723bs/core/rtw_btcoex.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/staging/rtl8723bs/core/rtw_btcoex.c b/drivers/stagin=
g/rtl8723bs/core/rtw_btcoex.c
> index d54095f50113..f4b19ef7b341 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_btcoex.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_btcoex.c
> @@ -8,14 +8,14 @@
>  #include <rtw_btcoex.h>
>  #include <hal_btcoex.h>
>
> -void rtw_btcoex_MediaStatusNotify(struct adapter *padapter, u8 mediaStat=
us)
> +void rtw_btcoex_MediaStatusNotify(struct adapter *padapter, u8 media_sta=
tus)
>  {
> -       if ((mediaStatus =3D=3D RT_MEDIA_CONNECT)
> +       if ((media_status =3D=3D RT_MEDIA_CONNECT)
>                 && (check_fwstate(&padapter->mlmepriv, WIFI_AP_STATE) =3D=
=3D true)) {
>                 rtw_hal_set_hwreg(padapter, HW_VAR_DL_RSVD_PAGE, NULL);
>         }
>
> -       hal_btcoex_MediaStatusNotify(padapter, mediaStatus);
> +       hal_btcoex_MediaStatusNotify(padapter, media_status);
>  }
>
>  void rtw_btcoex_HaltNotify(struct adapter *padapter)
> @@ -52,14 +52,14 @@ void rtw_btcoex_RejectApAggregatedPacket(struct adapt=
er *padapter, u8 enable)
>  void rtw_btcoex_LPS_Enter(struct adapter *padapter)
>  {
>         struct pwrctrl_priv *pwrpriv;
> -       u8 lpsVal;
> +       u8 lps_val;
>
>
>         pwrpriv =3D adapter_to_pwrctl(padapter);
>
>         pwrpriv->bpower_saving =3D true;
> -       lpsVal =3D hal_btcoex_LpsVal(padapter);
> -       rtw_set_ps_mode(padapter, PS_MODE_MIN, 0, lpsVal, "BTCOEX");
> +       lps_val =3D hal_btcoex_LpsVal(padapter);
> +       rtw_set_ps_mode(padapter, PS_MODE_MIN, 0, lps_val, "BTCOEX");
>  }
>
>  void rtw_btcoex_LPS_Leave(struct adapter *padapter)
> --
> 2.43.0
>
>

