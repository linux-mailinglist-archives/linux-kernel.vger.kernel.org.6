Return-Path: <linux-kernel+bounces-323893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 198C09744BA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 23:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D351A284683
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 21:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7FD1AB508;
	Tue, 10 Sep 2024 21:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A9fPBPvn"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DE923774
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 21:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726003379; cv=none; b=nmfu9IYNYeyWLNlKQPfYmze+N0537YBBtehoS3yeFXzZONZV352gcazrNwRCbwYj2G1pNBYDpwbk25H1IeLnIj1n4LALQAXY8ZzLZKul0nOUZpp384NPmyU14dJM7SjIqR0f9EFzxjv7PSf/2CrrnUtglvfe4o3T4mCQl87IF/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726003379; c=relaxed/simple;
	bh=J9E4Pbp83r9l9JyhG1IiSk1/8H53dwAA+eo6UPCOQyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EoWld5JhUctZ6EEgP2JmY+0ZtUS1gOR1tSTX+PQjuEPNqctl+Ee0tPLqpmZ1+DGDgor3kiTSVzwbIH/N54ZGl8XHW1N3NXLFw4nmft1Io7hzudzpl8QcnVsnUuE7Cb8N2Slu51J3IEG6D7Krcl3wK1P6nntM2VlI2vYDBxxQC2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=A9fPBPvn; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6c353f2f954so43323666d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 14:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726003375; x=1726608175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UzSu/kXOj+AyNMyap+JZaf4+i0lOR352iz38kAetQog=;
        b=A9fPBPvnsa8Vt7q3X/pZZZN6yv9VWObnumJaczN1aqtPuZzh1SurMJucXhzabq1W6v
         8pIOF3EC4KYsomhdogDn8LAUxssHhAiFdjbViRD4q0juD8osXnHZz+xWcBfe5G7pTKye
         /SFtqrLoPT1QDDmcMrEvn2O0BUw3s3o7WVE4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726003375; x=1726608175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UzSu/kXOj+AyNMyap+JZaf4+i0lOR352iz38kAetQog=;
        b=P61GnLmBqNcoreWJpVviRIJy1T+C3PlQ86bIHpRFjBBnYQyu3t0lsOR8EdCLhUICYQ
         Y+3H03IaLkuwYSBQo3ufw3BUVRrrq3T2Nb6GHlWNFgGZI3OssJ0GZprRsNFcoMxxvVYp
         Yl5a1mKrqzVb3grWeXakedgM0KojgsUspEbjQD7aNgt1AT1veM5zQ0wUBKKRaABcO83d
         hbDlCJWGPQGf0ubk4X7oWOPFVBn2H9Llq0VHWmDa78qB4pm9QZhYRIiXWMydh03ajLga
         YocwkklGLDBBTZe23fLBsZfu29dqyW6ZxmRocwJRNDGNhZm940Zl9OzoerVl+n2zi7dQ
         I6ow==
X-Forwarded-Encrypted: i=1; AJvYcCXZ9E+lMgkvZgH8fML0F/ZGw64Fi6S19Cjaw0Px3KDK8H3jn5jR1oLbKqh9wTcHwCVMARaFH8dXdNQvgSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxcW+Mjv3DGd26ySSEllplm3GG/q5hIM2S3hs8jwrs0xehCXWz
	Mdk0NLCphXpgwPUDoweQ0EPkCtbRv0OE8i0SFhifO7nZIxJEu8Tpc0ndQAK0XVX1bYPFDClCmk4
	=
X-Google-Smtp-Source: AGHT+IHKJqLxCmemD9VRFOhl4XLq6CbieQnz8toaGw3ow9QWZ7OLgxkH/3fdeDG5EGOswOon3uGotg==
X-Received: by 2002:a05:6214:5403:b0:6c5:1614:9c59 with SMTP id 6a1803df08f44-6c52850056emr200032846d6.31.1726003375363;
        Tue, 10 Sep 2024 14:22:55 -0700 (PDT)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com. [209.85.219.44])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c534329448sm33503096d6.26.2024.09.10.14.22.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 14:22:54 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6c353f2f954so43323286d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 14:22:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWBE1rJIwMlGlJLS/no28SmwX+E5/NnWryjcXATaZz0wcroSsYcMJNEtPf2raqipC1cDK4VYIH7iFHWqko=@vger.kernel.org
X-Received: by 2002:a05:6214:390e:b0:6c5:1f05:dcec with SMTP id
 6a1803df08f44-6c52851dadamr250755766d6.49.1726003373788; Tue, 10 Sep 2024
 14:22:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903173130.41784-1-abhishektamboli9@gmail.com>
In-Reply-To: <20240903173130.41784-1-abhishektamboli9@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 10 Sep 2024 14:22:37 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VVxWBv2oqL39j8eoRdJf42byoiUJ+XvY0kwL-OXoe0fg@mail.gmail.com>
Message-ID: <CAD=FV=VVxWBv2oqL39j8eoRdJf42byoiUJ+XvY0kwL-OXoe0fg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/panel: hx83112a: Transition to wrapped mipi_dsi functions
To: Abhishek Tamboli <abhishektamboli9@gmail.com>
Cc: neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
	quic_jesszhan@quicinc.com, skhan@linuxfoundation.org, rbmarliere@gmail.com, 
	linux-kernel-mentees@lists.linuxfoundation.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 3, 2024 at 10:32=E2=80=AFAM Abhishek Tamboli
<abhishektamboli9@gmail.com> wrote:
>
> Transition to mipi_dsi_dcs_write_seq_multi() macros for initialization
> sequences. The previous mipi_dsi_dcs_write_seq() macros were
> non-intuitive and use other wrapped MIPI DSI functions in the
> driver code to simplify the code pattern.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202409040049.2hf8jrZG-lkp@i=
ntel.com/

You'd only include the above two tags if the original problematic
commit had actually landed. Since it didn't you leave them off and the
Robot gets no credit (even though it is awesome).


> Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
> ---
> Changes in v2:
> - Update the commit message to explain the reason for the change.
> - Correct the code by changing 'dsi->mode_flags' to 'dsi_ctx.dsi->mode_fl=
ags'
> This change addresses a build error in v1 reported by kernel test robot
> caused by using an undeclared variable 'dsi'.
> [v1] : https://lore.kernel.org/all/20240902170153.34512-1-abhishektamboli=
9@gmail.com/
>
>  drivers/gpu/drm/panel/panel-himax-hx83112a.c | 140 ++++++++-----------
>  1 file changed, 60 insertions(+), 80 deletions(-)

Just adding a note that there's nearly the same patch in
https://lore.kernel.org/r/20240904141521.554451-1-tejasvipin76@gmail.com
and we're discussing what to do about it there.

-Doug

