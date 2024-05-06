Return-Path: <linux-kernel+bounces-170119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B238BD215
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 18:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7933D1F227C1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 16:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B850155A2B;
	Mon,  6 May 2024 16:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BiaG22tt"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF701DFE1
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 16:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715011353; cv=none; b=XR7OfgmBpoIiSWYa3S7YIaF7pRLiOTkpSfoDyLm2ltQzWun0KRVWIRDfQaQ+m72ZYwmfePFNiWtX08maZIacHxHWIZSleJ94YIezv0T0rEm7DGa1ldLzyTtOB+cmXCUIwcuDCvPeRI9s+MwQFXlVQ2UBIKW74F/ciFevqKQHoU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715011353; c=relaxed/simple;
	bh=iY66zTtGyVrYWQIMoz6ljJsYhpi+JYxauxj2oip/hxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EEL0RYuXYIFtXqE2wo4ggrrD6hIVUBT/4ODtHPYC/3dVWzDc0K3ty9jH3mnOBkKfkl6SPC3YJfDW7ZLbbDEprGgaJSn2rp3DPc5P6TL92TwJAIfAGU2EclnxR0y2VYGmp5QIPkoWy34KL1SRIod49c9AT2+eAomzutxINSISgfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BiaG22tt; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-43b06b803c4so14881451cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 09:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715011348; x=1715616148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g5H9ldalJcbmvgPRS+HnifHYCRDDP3C7W4j1Jjysd7U=;
        b=BiaG22ttx0Fv30ALuVyoQGJzdaOZTYnKSxCtpsH9mqGUatbKAGgtTzUB1dz8EJDROq
         bqhbP6RF+NfG1Eha8SdbfkYr9QNvsUI6s7Ld5uip+KvTJ4I43FhMYGyp1tzzMej9S+SW
         Q1S6Wu+svRdrEpxgxJK2v26tbfXvKusM7+MLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715011348; x=1715616148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g5H9ldalJcbmvgPRS+HnifHYCRDDP3C7W4j1Jjysd7U=;
        b=hZBeZTOqsD5Y5YglVPq4T+BsCwyX8ybBg1XwriI6ledQymyHRW6S8VEDpsFj+xcaQL
         LK+a2nEskJ/vago1B2xVhSwWJXpOdLvvbcCuWOlerjAyQAxoknRnqkYdvHpa4IPGuJY5
         UEaqy4Glwimb/wBTICNUg3Pp2h9HVy8IMHYPD60bkKKzeHiFeDSIPJjZ9nOK/aZu6gJG
         kVsNL6tqEDGditXL9E+dp8Lu3PK0Q/PBpO1ko4bDg04Dd7T75LigIb+FwD5LmH33SBtw
         rNvHm+BEjBKKWvA2c1KyNfjCxHKuwj/JSr6+BiDrIUxp/W1fQYu93fbeg1NTF2JdARSm
         IH7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVBnNZD1mJ0K1eZXDrs3jWNmZxdkhXnTud1N59hUrmwYP4oh+ddOvwkroW9gca/x/jquvKM1MIn5sUQW/Z5Rd6AcW7rCD8NDfIQXPJA
X-Gm-Message-State: AOJu0YxM0fJfUD3q1C27aBC+Xm3i042lzvfcHBVBTXXKj5MRm08/Zwkn
	gxMPQbriRegWArmHn8aj/v0JN7ILMgi0cCENw7tc8jN7vSsaibjtogKXlzed9NMOMEF9blSxic4
	=
X-Google-Smtp-Source: AGHT+IGTvtxyEitWf7X5xQPMfyRUhG2gUshlK2bf7hLkwGWdy7zU/TnYKD/YwzJR9Cv6eNI3TTmiJQ==
X-Received: by 2002:ac8:7d01:0:b0:434:7c49:a94e with SMTP id g1-20020ac87d01000000b004347c49a94emr10653299qtb.27.1715011348352;
        Mon, 06 May 2024 09:02:28 -0700 (PDT)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com. [209.85.160.181])
        by smtp.gmail.com with ESMTPSA id dr12-20020a05622a528c00b0043c58b6d941sm5303749qtb.42.2024.05.06.09.02.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 09:02:27 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-43d361a2124so348261cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 09:02:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXElz5lL4AAZzmXUgWngurQA30oECaHSimIQXSeevd7P+c+EGIp0HYvz4ZLOJ3QAYkl+OKuj7v+aUmI3INf3pM3n7ZyCmRmaXRH7Gox
X-Received: by 2002:a05:622a:108:b0:439:a979:ccb2 with SMTP id
 d75a77b69052e-43d031c9bd5mr5684701cf.16.1715011346712; Mon, 06 May 2024
 09:02:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502164746.1.Ia32fc630e5ba41b3fdd3666d9e343568e03c4f3a@changeid>
 <CAJMQK-h24xoO6jsYu4NK8ENoA6nsidcF8aN2pCzNMPgmu1NxEw@mail.gmail.com>
In-Reply-To: <CAJMQK-h24xoO6jsYu4NK8ENoA6nsidcF8aN2pCzNMPgmu1NxEw@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 6 May 2024 09:02:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UavcwPud8q57bWGPaJn4z0aP_abuBddhNh8eKVhjF4tg@mail.gmail.com>
Message-ID: <CAD=FV=UavcwPud8q57bWGPaJn4z0aP_abuBddhNh8eKVhjF4tg@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Add ID for KD KD116N09-30NH-A016
To: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Sam Ravnborg <sam@ravnborg.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 2, 2024 at 4:55=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.org> w=
rote:
>
> On Thu, May 2, 2024 at 4:48=E2=80=AFPM Douglas Anderson <dianders@chromiu=
m.org> wrote:
> >
> > As evidenced by in-field reports, this panel shipped on pompom but we
> > never added the ID and thus we're stuck w/ conservative timings. The
> > panel was part of early patches but somehow got left off in the
> > end. :( Add it in now.
> >
> > For future reference, EDID from this panel is:
> >         00ffffffffffff002c82121200000000
> >         321e0104951a0e780ae511965e55932c
> >         19505400000001010101010101010101
> >         010101010101a41f5686500084302820
> >         55000090100000180000000000000000
> >         00000000000000000000000000000000
> >         000000000000000000000000000000fe
> >         004b443131364e3039333041313600f6
> >
> > We use the ASCII string from decoding the EDID ("KD116N0930A16") as
> > the panel name.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> Reviewed-by: Hsin-Yi Wang <hsinyi@chromium.org>

Pushed to drm-misc-next:

a6cd27d92a96 drm/panel-edp: Add ID for KD KD116N09-30NH-A016

