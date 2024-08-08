Return-Path: <linux-kernel+bounces-280042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3586094C4F6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 20:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66A0F1C215E7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 18:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9197154C15;
	Thu,  8 Aug 2024 18:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NAiMSbz3"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDDB146D6F
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 18:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723143332; cv=none; b=Fqe68omVfFbgMopYNflb1dKwZNJUlrLEf+kno86hY5Y1kkegu89PEM9meJXekCWLfUYtkLyB0cxYxufBmzjdffOtUPGz2S7WtXVIRyz3/sM+r4QG3KC4ADVNkSA270jEPNvw4FdMRWfC14hCvfmv7NfFw+/deodm9mEYEjFTw9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723143332; c=relaxed/simple;
	bh=lNkDxEjqXY+lnTpLDK2Jg90TC5u4Y/9yANlHx6UZOwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FQj2KeZBDdEjiykzu1lJdvWxMssfpWFXplZ4Y3AOw5CU59QdvDwzEIhN/24sfOrUdMIqyfMbXi3E7ZCmWe1c3XMeVHl2/FNsMvk0aFR2hs0kMVM1HtPTmcSKi+PWRTGw5HzlDlEpZ1LoaUPfAqctyjo4p1NqJPwfmS8XOf/drPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NAiMSbz3; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6b7a0ef0dfcso7188546d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 11:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723143329; x=1723748129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ia3gn65ZzmXsv1RewV6q6A0e4ePY6aOjBbUhD4zPmes=;
        b=NAiMSbz3vTvK/j53AkosOetDKK8JndADONPvZ7FDnrOZTCpYRN+pEsutuXpAnSuLes
         KvlrpTX5DdEMP9Eu82OWrSczQYwBX5dvAR5m15+z3PsF2bONIZA4BlKoGZj3p8TeP0Id
         ZQBB/vaLQeoxwaxW0Q6oizRvhFQIJl5eA2jkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723143329; x=1723748129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ia3gn65ZzmXsv1RewV6q6A0e4ePY6aOjBbUhD4zPmes=;
        b=wDpkNAFPjdf7AQLdjHkTgWQi3N8oZgyWZ1Po7gdXwWABk98XDhG3uS5OMO7sCSO19s
         GDfVYpIf2sQrX2I/x39W+TZ3+EaJ81TKfi83fapq4y/e2ZdsYD6IpOIHtrqf6NSR64R2
         kC1OoNafmJsML8JcOpSUATRAa930Vj52XMCwEIWIzY1CzYh8JtfGEmqkIgwtPv0xOY1k
         hDXMl7jZLVHiNXauC+yXzrw5ndZN28e2yftry6uhucmyVBeWhgG7cuJ95OdSXqtR9csr
         ZQyIbgNilBQnHjbY9hpJ7iR1Lx5UxD6EUdLqKsZkD+5PgomzH5Wg3VlMnDbdTt0GT7Uu
         y1Bw==
X-Forwarded-Encrypted: i=1; AJvYcCVbfQrsM1QWrbQDW0XLnsFy5t3hOBytoG/bc65bzvm61B4jCS8nPlMRJZ34j9GERt3Bb2Bajudt2aNR6GdWxBcCWeWzlaqRupGKUx2m
X-Gm-Message-State: AOJu0YxW80aVZXrfeojpq8+l9ZbynEJEXnpCFzliNmxbg/MNuFA3S6Z2
	NBTQOF/U+jtI1iEakwT9r4U6JB1uTWsuZZ8k9JcG2fjFSLXXrHIC/o+XvdMrq6uVwx7H24I9uie
	3B0W9
X-Google-Smtp-Source: AGHT+IH7X0TTGN9sCHrULkPhmn5/0af7Q3KC0MIa6xpD/zp1WZ4mHzOWzKLpo6JWJRGTEeQkrFZ14w==
X-Received: by 2002:a05:6214:5b0d:b0:6b5:17a2:887c with SMTP id 6a1803df08f44-6bd6bcc329dmr38283256d6.10.1723143329145;
        Thu, 08 Aug 2024 11:55:29 -0700 (PDT)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com. [209.85.160.174])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c839fe5sm68873046d6.84.2024.08.08.11.55.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 11:55:28 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-45029af1408so26511cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 11:55:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX0K2iJ8I3j02qgdsZnjHbfVjX50pespzlXFT6AatwUfVEdYbpre1byib18cOYbcNwsK7YkQzoXqGZEBBNn0lfvrTSl3SzaRyToitmc
X-Received: by 2002:a05:622a:5797:b0:447:eaaa:c852 with SMTP id
 d75a77b69052e-4530de62980mr344201cf.23.1723143320261; Thu, 08 Aug 2024
 11:55:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808114407.1.I099e8e9e36407a0785d846b953031d40ea71e559@changeid>
 <CAJs_Fx7GN1_2xAM0Qg8oezQ2Foxy2smOXb3zMhNiJxCDMPUNug@mail.gmail.com>
In-Reply-To: <CAJs_Fx7GN1_2xAM0Qg8oezQ2Foxy2smOXb3zMhNiJxCDMPUNug@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 8 Aug 2024 11:55:08 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xt0_yhVGDv3X+uZoVQ-_Wiwq4ENJUpi6__J6dN_aMm0g@mail.gmail.com>
Message-ID: <CAD=FV=Xt0_yhVGDv3X+uZoVQ-_Wiwq4ENJUpi6__J6dN_aMm0g@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: display: panel: samsung,atna45dc02: Fix indentation
To: Rob Clark <robdclark@chromium.org>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 8, 2024 at 11:47=E2=80=AFAM Rob Clark <robdclark@chromium.org> =
wrote:
>
> On Thu, Aug 8, 2024 at 11:44=E2=80=AFAM Douglas Anderson <dianders@chromi=
um.org> wrote:
> >
> > The yaml had indentation errors:
> >   ./Documentation/devicetree/bindings/display/panel/samsung,atna33xc20.=
yaml:21:9:
> >   [warning] wrong indentation: expected 10 but found 8 (indentation)
> >   ./Documentation/devicetree/bindings/display/panel/samsung,atna33xc20.=
yaml:23:11:
> >   [warning] wrong indentation: expected 12 but found 10 (indentation)
> >
> > Fix them.
> >
> > Reported-by: Rob Herring <robh@kernel.org>
> > Closes: https://lore.kernel.org/r/CAL_JsqLRTgQRPcfXy4G9hLoHMd-Uax4_C90B=
V_OZn4mK+-82kw@mail.gmail.com
> > Fixes: 1c4a057d01f4 ("dt-bindings: display: panel: samsung,atna45dc02: =
Document ATNA45DC02")
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> Reviewed-by: Rob Clark <robdclark@gmail.com>
> Thanked-by: Rob Clark <robdclark@gmail.com>

Pushed to drm-misc-fixes.

cd9aae921ab6 dt-bindings: display: panel: samsung,atna45dc02: Fix indentati=
on

