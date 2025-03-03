Return-Path: <linux-kernel+bounces-541600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E74B8A4BEE0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5171F7A11D5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82ADD1FF1D0;
	Mon,  3 Mar 2025 11:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GK5kaHtU"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C27C1FF1C6
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 11:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741001837; cv=none; b=hMeTVnBYOn0rFw/awPTMmBaI88sB4p3AfDvz74fdDPVZEI3FmrFAuGGcIKpmpXXHSfp5KchVAbcTl6HrNpupXBo7TD5ibeVWiKPg9r1TWhRjbC+Ky/Qr6K4WHL9d9ii3hzazgU3BRstbM/u/j0UKcD8yZ5mJRBB9Tz74FGdx5fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741001837; c=relaxed/simple;
	bh=gSmqjl48I2bftmg98TgvWKfCxzYiI8y99YYV12eiWM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GSsoLjvVWdhcfeTlErDMMDnGQaMBilxD8v94Gigi0q8tKRmADqXv4BHlvVukWoC58Ww0kBsPUgkzXWJ3LgkUVhZeBppzKuYbrwuBcnTMIdsdQOA5ZsAn6tgaf+pT/JEfd83u7wdCN+BIqwP46PEXpOgr+Y5fgCE3HS33BlP+RB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GK5kaHtU; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e60aef2711fso2206845276.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 03:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741001835; x=1741606635; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VZdcPlKGwSUQ1/c/x0IEBqiGcJoStRQT2SaVJ9Y6HOg=;
        b=GK5kaHtUi355ItY4ZtFQZHjzfQM9dQ/O8+wFfAlJtSJtfA+6d504PRieJb7idYbzIw
         WaKxOnqCHKib9Xo1vw3S5hQ8KFtiTaNi9ydDkMvAoTJjaTFJWvM6YeooujfMT0hu0TxE
         RFsxE8bXf9Xbiy1S5qMDCpjRUlyruwjM6iK3ZdpWuW5hp8eUjVw738BJErki1eWHztbw
         BzOvM+sxwJZeLQyyJB4ZArWpAsxcJWaUYeafzJ5RBXFZDAW5qjrdlzVNtJLgzbTNJPdJ
         dJkretoVTEUgbUjvdDKMwhmZziScCtnsmMO+1K//AmCMRCnN1SdKbEQSjoQVwtAlV7Ie
         xBrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741001835; x=1741606635;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VZdcPlKGwSUQ1/c/x0IEBqiGcJoStRQT2SaVJ9Y6HOg=;
        b=CxpoahdlBqqZD75VVFs9yGXcWybQ7F9+I5ATual+iFTvhZzg0kctHX+CiuP1B9YSEe
         ObRLaS9ha2BruEXxMdzErbWPESj2vUkaUGbZljHObMXI0FeXdr9xriIIF9w2sWmelFYx
         28wsIjiVLoPT8jwJ89/Dzl84OphQE/1eOjuDoeViiB+xGCB9tW+XC0ijrmbEHZ/w8n9B
         QPnhYGFKAVk3H8rrI01WPGB4NQUoxOO2esu5wA4IfM2FpbQR2211r/OVM19ACY9u7NG7
         moEYZ0F1Y6ZFFsOij6dT7cWztxhPrWFLQ7hnUhrn0un9QrvdDsqRI8XYxi4qZ0Qrxfj5
         yoQw==
X-Forwarded-Encrypted: i=1; AJvYcCUX0lN+qfITlIDVo8JwNKeHCB7SOlNh9kmBCRAcaUwbdaZHzRnFY1olUl+kqIsu+RYkevRHU3cRR+DtJ9s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7z1eXUFXU4YGHsf7QupzYpAoqWfsDZfrbJ3XRYZ1W74PIF2CB
	6x2PispRdF4YXkjdwvFix3I+/Q4McpcKNZfZQuXZ+CMKCkQPoCbiNTWYvB1Lil7v4lxUuPLPmTv
	Sd6CFbKaq5SMN3VsHBSkR/PHjHLI6n2N+x5Nlmw==
X-Gm-Gg: ASbGncv55YCIF1B87kEOrMedJOY1ML4NNaoObvUKSY10mzYZH80saoM0nHauR7MQdYf
	FeoHQ7p5G3hWq81mDSpkgVNziD57SKd28nMjgkR4hBxgjsGrE9ttIDblIq8SjtDOH8eFm3dAHRf
	ptB/WteCQP5S8JZUSrqjbBcGZcBU4=
X-Google-Smtp-Source: AGHT+IHrccx3eeYx7Ph57lcw3jkpDa9UoiqwNC12MOXPb6LaFAIEcFkZzSIkizPiqpdEw1ZhtDOIw4oKutTggiYjUA4=
X-Received: by 2002:a05:690c:3001:b0:6fd:44a5:5b68 with SMTP id
 00721157ae682-6fd4a100420mr180752197b3.35.1741001835219; Mon, 03 Mar 2025
 03:37:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12620037.O9o76ZdvQC@rjwysocki.net>
In-Reply-To: <12620037.O9o76ZdvQC@rjwysocki.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 3 Mar 2025 12:36:39 +0100
X-Gm-Features: AQ5f1JoM9bXFkjeEORxBmtsj4iFuLmWabqtiwT-NoP3RpdVWmI2bcHKAnUHgW7Q
Message-ID: <CAPDyKFqdD760Tn5nHghXK1DgSQ6K=hv7D32m9w0-jgi+nA7-gw@mail.gmail.com>
Subject: Re: [PATCH v2] PM: runtime: Unify error handling during suspend and resume
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Oliver Neukum <oneukum@suse.com>, 
	Ajay Agarwal <ajayagarwal@google.com>, Brian Norris <briannorris@google.com>, 
	Raag Jadav <raag.jadav@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Feb 2025 at 18:06, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> There is a confusing difference in error handling between rpm_suspend()
> and rpm_resume() related to the special way in which -EAGAIN and -EBUSY
> error values are treated by the former.  Also, converting -EACCES coming
> from the callback to I/O error, which it quite likely is not, may
> confuse runtime PM users.
>
> To address the above, modify rpm_callback() to convert -EACCES coming
> from the driver to -EAGAIN and to set power.runtime_error only if the
> return value is not -EAGAIN or -EBUSY.
>
> This will cause the error handling in rpm_resume() and rpm_suspend() to
> work consistently, so drop the no longer needed -EAGAIN or -EBUSY
> special case from the latter and make it retry autosuspend if
> power.runtime_error is unset.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Seems reasonable to me!

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>
> v1 -> v2: Add comment explaining the -EACCES error code conversion (Raag)
>
> ---
>  drivers/base/power/runtime.c |   40 ++++++++++++++++++++++++----------------
>  1 file changed, 24 insertions(+), 16 deletions(-)
>
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -448,8 +448,19 @@
>                 retval = __rpm_callback(cb, dev);
>         }
>
> -       dev->power.runtime_error = retval;
> -       return retval != -EACCES ? retval : -EIO;
> +       /*
> +        * Since -EACCES means that runtime PM is disabled for the given device,
> +        * it should not be returned by runtime PM callbacks.  If it is returned
> +        * nevertheless, assume it to be a transient error and convert it to
> +        * -EAGAIN.
> +        */
> +       if (retval == -EACCES)
> +               retval = -EAGAIN;
> +
> +       if (retval != -EAGAIN && retval != -EBUSY)
> +               dev->power.runtime_error = retval;
> +
> +       return retval;
>  }
>
>  /**
> @@ -725,21 +736,18 @@
>         dev->power.deferred_resume = false;
>         wake_up_all(&dev->power.wait_queue);
>
> -       if (retval == -EAGAIN || retval == -EBUSY) {
> -               dev->power.runtime_error = 0;
> +       /*
> +        * On transient errors, if the callback routine failed an autosuspend,
> +        * and if the last_busy time has been updated so that there is a new
> +        * autosuspend expiration time, automatically reschedule another
> +        * autosuspend.
> +        */
> +       if (!dev->power.runtime_error && (rpmflags & RPM_AUTO) &&
> +           pm_runtime_autosuspend_expiration(dev) != 0)
> +               goto repeat;
> +
> +       pm_runtime_cancel_pending(dev);
>
> -               /*
> -                * If the callback routine failed an autosuspend, and
> -                * if the last_busy time has been updated so that there
> -                * is a new autosuspend expiration time, automatically
> -                * reschedule another autosuspend.
> -                */
> -               if ((rpmflags & RPM_AUTO) &&
> -                   pm_runtime_autosuspend_expiration(dev) != 0)
> -                       goto repeat;
> -       } else {
> -               pm_runtime_cancel_pending(dev);
> -       }
>         goto out;
>  }
>
>
>
>

