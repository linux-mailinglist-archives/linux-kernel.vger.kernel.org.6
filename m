Return-Path: <linux-kernel+bounces-299372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B2395D3B9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 18:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8494A2851AA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 16:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4C2188A25;
	Fri, 23 Aug 2024 16:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fkLCnrsG"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E82712B6C
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 16:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724431804; cv=none; b=IjQZKc+yaINNUbyvDzfW5F4VGAn7s/BJBQ+owWMPbNHjW1h8/+dddTHVZ5e5HYhfsNls9K6HP9YFL3mTGb9MV1ngdi1/y4DvdVbi1cESn0AmRpIW/ndtZ4IpuLTBccatG0eCbY/Cz491c4g+uhxFuGKNh8bqCGwfuoMxx0qlcD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724431804; c=relaxed/simple;
	bh=NRAzFhxhICWfQx+6HTK86ljw76LNHKDYb4ARkPeKleU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OighiLZzPyB8NdtU9ItgbAv/SWsUJRgDsbV2fmj4l6lUxQHOhfClI8t80h3uE9/dfygoGn8os7HKNJsrf1QNWDuRlvNhp9/J4BOQ6IA9H1V5rRD9NBAuUwVPY2objSFPkjmWA/5IWa67414mWDlwU3rZJ44Q1GHqx1Dti8N27Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fkLCnrsG; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6bf8b41b34dso10854426d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 09:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724431800; x=1725036600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YF7d6zgK96oUF/UdvRet8Wq1EsEpokqSbVExBvPEI58=;
        b=fkLCnrsGwMW3T7/scHkg0PkFP1mu+g+nylstaFl3f5Yre4aRyJcU3CYcVvWXIaDuLa
         tQ/BR8zHo9l5g01K2nMx+J4njCxa0zeC8fkmm7xGzD4PMmk6QZES99QBTOjUpSLRG5r/
         ZU3EHXQv9wG7CxdSXKY9jFxBh0GMi0NzJPzQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724431800; x=1725036600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YF7d6zgK96oUF/UdvRet8Wq1EsEpokqSbVExBvPEI58=;
        b=My2wisbWrE2k0IUGlCrhfPMGyPl7rTvnv5MPnrgOb1+7y5fRFkczpIfE31cr1zBHXW
         nydLlaQAKvYQ2i2+3zor8lOqERLydqjVe6Dc4Jis4+RRqAJE9ORwXlEyLDoODq0rhwbj
         P0xIGwCqEPqgSHZcEyzDp2MBOyQLcSAbBubHT6YQXEIM2GjIIgrptqCCM/SRCk3aqrSm
         OMk4iV1YbudhhkL97nU14+BIVxjgpDkbkL2Y4jLrp7RjWdjbqvd8yUiGh3XQeTprqUKo
         i5bziU3pbPoqYJgkXv3avpOZlsHIf9V4LSBrefE3CYbyYm4mPhwlCaIQylbMy2f0dE9X
         tGYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaELNa+p7wmpOsKXyjL574BKMWJMAYYY2xb9Mf++ObWYWvAvk0ZzninIhj5Oq10K0oRSZEYb+fapl3DbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLQSiynnyY4VfQvjXO6dhnFCnT4MTfIoCMD77/NWN6RLIsbWpf
	Si2hdKsvhwZshSWzKkdzYgxjW2bElC/9a2DKX9JbEjDzoC9vGQXUaljVmUR7YSwDpzhQChGB5oo
	=
X-Google-Smtp-Source: AGHT+IHxmoNzQDyKekbVELK+tOI84pAbHA3ZOr5JCA6kT8SDHx0lmqV1iazFV0U4zvlhQ4t3U1IApg==
X-Received: by 2002:a05:6214:3f8f:b0:6bf:89fd:90f with SMTP id 6a1803df08f44-6c16dc21690mr34688516d6.3.1724431799601;
        Fri, 23 Aug 2024 09:49:59 -0700 (PDT)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com. [209.85.222.181])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162d4a003sm20311806d6.35.2024.08.23.09.49.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 09:49:58 -0700 (PDT)
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7a1e4c75488so130990185a.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 09:49:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVjY4BpiPCKgNp5qZsU25B6dyKg9i3mrq+JsvqRNRducQ+/rdlCloswc4yyEs2EFfb1EOQF3y+ypAHq5mQ=@vger.kernel.org
X-Received: by 2002:a05:6214:4199:b0:6b9:5fb9:113f with SMTP id
 6a1803df08f44-6c16dc6309emr28510476d6.27.1724431798162; Fri, 23 Aug 2024
 09:49:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823163513.4344-1-hanchunchao@inspur.com>
In-Reply-To: <20240823163513.4344-1-hanchunchao@inspur.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 23 Aug 2024 09:49:46 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X_a2NzAi6L3N-Bgta4Vn7uSd3DPZ355LBg1gpd=A7H+w@mail.gmail.com>
Message-ID: <CAD=FV=X_a2NzAi6L3N-Bgta4Vn7uSd3DPZ355LBg1gpd=A7H+w@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: himax-hx83102: Add NULL pointer check in hx83102_get_modes
To: Charles Han <hanchunchao@inspur.com>
Cc: neil.armstrong@linaro.org, yangcong5@huaqin.corp-partner.google.com, 
	quic_jesszhan@quicinc.com, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, liuyanming@ieisystem.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 23, 2024 at 9:35=E2=80=AFAM Charles Han <hanchunchao@inspur.com=
> wrote:
>
> In hx83102_get_modes(), the return value of drm_mode_duplicate()
> is assigned to mode, which will lead to a possible NULL pointer
> dereference on failure of drm_mode_duplicate(). Even though a
> small allocation failing is basically impossible, kernel policy
> is still to check for NULL so add the check.
>
> Fixes: 0ef94554dc40 ("drm/panel: himax-hx83102: Break out as separate dri=
ver")
> Signed-off-by: Charles Han <hanchunchao@inspur.com>
> ---
>  drivers/gpu/drm/panel/panel-himax-hx83102.c | 2 ++
>  1 file changed, 2 insertions(+)

FWIW, this looks to be v4 of your patch, right? The subject line
should include a version number and you should be providing version
history "after the cut" in your patch. Tools like "b4" and "patman"
can help you get this correct [1]. If you plan to continue posting
patches you'll need to start getting this right. The next version of
your patch would be v5.

[1] https://sched.co/1aBGS

I see:

v1: https://lore.kernel.org/r/20240821095039.15282-1-hanchunchao@inspur.com
v2: https://lore.kernel.org/r/20240822093442.4262-1-hanchunchao@inspur.com
v3: https://lore.kernel.org/r/20240823083657.7100-1-hanchunchao@inspur.com


> diff --git a/drivers/gpu/drm/panel/panel-himax-hx83102.c b/drivers/gpu/dr=
m/panel/panel-himax-hx83102.c
> index 6e4b7e4644ce..e67555323d3b 100644
> --- a/drivers/gpu/drm/panel/panel-himax-hx83102.c
> +++ b/drivers/gpu/drm/panel/panel-himax-hx83102.c
> @@ -565,6 +565,8 @@ static int hx83102_get_modes(struct drm_panel *panel,
>         struct drm_display_mode *mode;
>
>         mode =3D drm_mode_duplicate(connector->dev, m);
> +       if (!mode)
> +               return -EINVAL;

I would have returned -ENOMEM since drm_mode_duplicate() is defined to
allocate memory copy the mode (like strdup does for strings) and it
should be clear that the only failure case is failure to allocate
memory. Other callers convert a NULL return as -ENOMEM.

-Doug

