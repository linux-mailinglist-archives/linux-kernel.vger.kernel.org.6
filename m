Return-Path: <linux-kernel+bounces-323899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A589744D4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 23:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0AFF287A16
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 21:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12811AAE34;
	Tue, 10 Sep 2024 21:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lNkxiQYL"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAAA18C91D
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 21:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726003817; cv=none; b=fD1UnRfTi56CmWzRbugQSJd3cpZFCn4HT6cgAXiV6irPaDghyrc61sc3mkWHs6tgKs6vTK5eL+rW1aXQ7stMrFAxMQFCAXKeAm4IRlWXToB90NhitZ5FXsA3GYAGmBYmeyzM2q07aAhoXJpsFjWUglluI1jKJtYToV3BTIc8uZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726003817; c=relaxed/simple;
	bh=WKPITyXEUUt3FRz02xXVqusVXWhpg4tLRjvb6xPQr0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FnRjt2V14xWk7Xtkwz8RZcJ9eYp5qjl8luztX9kigcWCrRBt8WBUGAsXwnBqQ85j27fr/k7vsO0itxxe9DGWbFbVACR//D0HmkeaXNcmAoOLfwMR8hXMS8f2AMzts8e9T+ujujR+Z7faM1bPeefdLnprxcql0280dKvYoxdirSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lNkxiQYL; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a9ab721058so24019185a.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 14:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726003812; x=1726608612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNsOiBCl7SIooxW2ujNpj2hyBxCkDrdHM2De6QCq9rs=;
        b=lNkxiQYL/54kTmeR4eBWlKYi4/WE8yUvT0YiqIjTtuRN1cqPZwQyihFoTQbCd1O+SD
         SbH8XtYbkeUJR69Dc+m19x3xUhU0uvK6rUUGKS5WWPd+4ZeZFS2ZfLXh3OSA2AJgpz4r
         FIs0XPNEQuLm0+FXuiFW490850ylohrR1ASZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726003812; x=1726608612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KNsOiBCl7SIooxW2ujNpj2hyBxCkDrdHM2De6QCq9rs=;
        b=YOoqMM8GV6T2jdSkmiK6VMnn37+96X84v+WC7VgXN4iVd6pQaSI26SVuNLjEaNWlmd
         2C+AIyNoXPBImmSSyL+Kk0A7VnbbUUalL4zw/pKtyr8gHDJVpoM8+5e/kOWPoF6OWXLP
         Pstq7kSX2P5RnZSDw99Swj7Dc+WFd3HJVSm8qsx5KEjTjA6nzTvkAs3xEmRixO7/qVlI
         AZS+WYsPIPWt9rGsd5qLnA0Uit6wt+dZuebHWTrN8QnHUg2yfX5WcZ2Ts1os8AHslreV
         YXPcJHZ4g4wcEvt5r71YL/NlqlUGB0xFZCXduzTjnRuPM1jR1HUDCntofBVEikdHl5WL
         QAnQ==
X-Forwarded-Encrypted: i=1; AJvYcCULKYn5c64LhpUNK60oFRP+qE7gb2RjAudase0dU/8oN1Zw6vo2qLAJ/SO2hEckpcumZqKK6vbhW1oMEJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpXnXFLWgq7o46cTXWiqyinJ21Oap2/+MW6WLyutRZfrnTGxh4
	S4Lf557clqGydeTTVeaj5WXjSK0YBH3LxYxfN2CaAQ5th6AqRZb4LjpTLiRMDxMO56Y9OHDf/Lo
	=
X-Google-Smtp-Source: AGHT+IGWvi3i5gAvMxrfpvZVC9xWYhJ4+L3p/SMGALwL1rMNdFDbU79ZwrEKTALaPu4Dt2nHzU05gw==
X-Received: by 2002:a05:620a:4488:b0:7a5:1ca:d010 with SMTP id af79cd13be357-7a9bf96dc07mr671333485a.12.1726003812362;
        Tue, 10 Sep 2024 14:30:12 -0700 (PDT)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com. [209.85.219.48])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a7a1a8d5sm342747885a.116.2024.09.10.14.30.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 14:30:12 -0700 (PDT)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6c3552ce7faso2364556d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 14:30:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU43vrH2YH8d85sqeRBr7af21hH+11GDBXPh55CRm08Ebh/CBxKrR+OoJwZCAOvToF9V8B/QFC2tgoi+qA=@vger.kernel.org
X-Received: by 2002:a05:6214:268d:b0:6b5:1584:62bf with SMTP id
 6a1803df08f44-6c554d1e20fmr84428226d6.6.1726003810596; Tue, 10 Sep 2024
 14:30:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902071019.351158-1-tejasvipin76@gmail.com>
In-Reply-To: <20240902071019.351158-1-tejasvipin76@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 10 Sep 2024 14:29:53 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W4ExYGTDtBgQChGk_1BgSXXWoQKupJLAOcyqU9+Fbkjg@mail.gmail.com>
Message-ID: <CAD=FV=W4ExYGTDtBgQChGk_1BgSXXWoQKupJLAOcyqU9+Fbkjg@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: samsung-s6e3fa7: transition to mipi_dsi
 wrapped functions
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
	quic_jesszhan@quicinc.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 2, 2024 at 12:10=E2=80=AFAM Tejas Vipin <tejasvipin76@gmail.com=
> wrote:
>
> Changes the samsung-s6e3fa7 panel to use multi style functions for
> improved error handling.
>
> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> ---
>  drivers/gpu/drm/panel/panel-samsung-s6e3fa7.c | 71 ++++++-------------
>  1 file changed, 21 insertions(+), 50 deletions(-)

Pushed to drm-misc-next:

[1/1] drm/panel: samsung-s6e3fa7: transition to mipi_dsi wrapped functions
      commit: f327bfdbf6c6d7d8e5402795c7c97fb97c2dcf79

-Doug

