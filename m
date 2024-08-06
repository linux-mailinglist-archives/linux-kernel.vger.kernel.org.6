Return-Path: <linux-kernel+bounces-276836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C28F29498FE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DD671F233F7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 20:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06937155C97;
	Tue,  6 Aug 2024 20:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Tdc2ktht"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F000D40875
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 20:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722975902; cv=none; b=RnIlUnnVSD1nZEHtuWSt9pso5eubzx2rYgq7/CpcMECvuvgTEpip9TiQGBUepycM7V/AVb1560v/luUqGuh+Wzy9UO7H4wtiZ9vgswzQHcsT+30OvZe2fW0zgUuQvSQm9wj3UVEodb6iY1/RLo15Pdoyk4TmmhGSmfVv6animdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722975902; c=relaxed/simple;
	bh=N/OZFOxNdt1/7u2anSXT4uxWU90giXBBt1zgEgss+ZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RgYPLMCamhX4LFVQW1QzdhC94oo4zd/3/4C+Zrtc6FIgMzps4jxFAJqzGSh/ZrgXICJLL3sfnoW9EMGltGxFGRayE2AEXoie73AtiK9jdAUNnuBf5N5Xr/AUhdg/bJJherYHXWoIbs9kG/NT86Fr8wEbInv6LOJfcxcQyUjtKvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Tdc2ktht; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1ff4568676eso11966345ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 13:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1722975900; x=1723580700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/OZFOxNdt1/7u2anSXT4uxWU90giXBBt1zgEgss+ZI=;
        b=Tdc2kthtrTxy8pZvxrDObDeku/aWlpEweR5LkSnARKcESXOHbe8Yp+KHkVnmhpGPr2
         P7hke4tfPtfNpUMP3RrSykKxZnQ0Rw2xHuYT99DN0EyBrFKQsDAtM0C3/Xc+m6DAmc2M
         rYkKH8hAqJYijRd5cfDHRkw//SX/lYCZdjJrkbN3I43JXjTdQnhhLLRc3BSE5MtDCtrR
         Jp3sZNn7fUFjQYRC4j0dLoWkAGPy8bUgNkH4XLNzveqdkHxjtEQ2EStmM4ex4cvPQ182
         FxdNWJtYCRiU8EzQ5LB1jhBXUjXD32pSoUPqdf1KcXrVAZsDe7G5khgNR2tViLvOLZde
         fr/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722975900; x=1723580700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N/OZFOxNdt1/7u2anSXT4uxWU90giXBBt1zgEgss+ZI=;
        b=ddWFQev88krAckpb+NnQvrn5DylLXLjuN5PSWXAj+wvSauGNwJ2MZaYZuaTocKxvud
         ht2BCSRFgmMBE11Q/uwe698os2EPXCyzaZQMtuep9AzfovUlEnij3K1puMObz8ihl97X
         O4K4v54TdH//gU6fik6JbREjgAhoFWQZjg16wNeQm7Ca4ZdMhEiDCfQTJhkNREQkXkWE
         AV6qI2+rk54MwjLMr59Yu2cKsxJ4sx8YipIW5bD4EDovFvsKkkfpvEt7KlxOID1653CS
         od6FclPmIIGNOQpee+0vDUgXuVgqR7C9drdXvgYcoOCDdog8vkn6hMPdCsZ5jiSodQYa
         f6mg==
X-Forwarded-Encrypted: i=1; AJvYcCWJa0WkAEj+ind3NNwGJ6V8xV0kSCUcm71NyMq6kF4GnK+HB3+/AaTFovNKftjhEVKiwpTr0v59NziPpf+zHsV0Gl1uYEqiusmpOVIA
X-Gm-Message-State: AOJu0YzauGOh49RMB5cqOVtj86wbAb8nfEkBYCLY8pZI3f02dobk+zwt
	KWgExENyb9cpqSEB3O2fS7Rcs7iJGpamTUolRbwcO5t2zGiivkfp3VUlSIc5TFP3KWF+ZBtMCip
	1itXpV8YQo5og9w7sUq+OF3pVa6w=
X-Google-Smtp-Source: AGHT+IFlOXea9xY5WykUEmvYYAM8wx4DwXepEDxVhNlPibwTYKIK3m/8aLtBzWoY74h9NIrpPaky4Gm7SJWyH642cHA=
X-Received: by 2002:a17:902:f681:b0:1fd:73e6:83c7 with SMTP id
 d9443c01a7336-1ff573cc797mr178847085ad.48.1722975900222; Tue, 06 Aug 2024
 13:25:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730125023.710237-1-jbrunet@baylibre.com> <20240730125023.710237-3-jbrunet@baylibre.com>
In-Reply-To: <20240730125023.710237-3-jbrunet@baylibre.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Tue, 6 Aug 2024 22:24:49 +0200
Message-ID: <CAFBinCB6x3cs3HvrZLaL+qpF1bfuMiRO0nywJPYDa+QUj3c3=Q@mail.gmail.com>
Subject: Re: [PATCH 2/9] drm/meson: vclk: drop hdmi system clock setup
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Kevin Hilman <khilman@baylibre.com>, dri-devel@lists.freedesktop.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 2:50=E2=80=AFPM Jerome Brunet <jbrunet@baylibre.com=
> wrote:
>
> Poking the HHI syscon is a way to setup clocks behind CCF's back.
> Also, 2 drm code paths, the encoder and the hdmi-phy, are racing to do th=
e
> same setup of the HDMI system clock.
>
> This clock is used is used by the HDMI phy and should not be set by the
> encoder, so drop those HHI pokes from vclk.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

