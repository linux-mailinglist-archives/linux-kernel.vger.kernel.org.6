Return-Path: <linux-kernel+bounces-276848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 987A5949921
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40EF31F23648
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 20:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF07B13D525;
	Tue,  6 Aug 2024 20:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="EiG549gj"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62BB37703
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 20:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722976256; cv=none; b=np/d4GzOdta7cJ4T2S2E2WxgIDvYJz3ibCln6ymtlP3xcz08LinqcOURzgMydRCtdoC4VjCDI05wpa908gPG8LzgkuT6wJjTmGJAjSLvXyy4kf+KZ0ET1YLRWS8Mle+GlehbAabKkugA1b82aUHvpNAd3G6wXoqMbFvp/89ZMlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722976256; c=relaxed/simple;
	bh=pGjOP1lRrUIGHHfY/ucyJaa3OokEJdc3Rk3ANgx/cL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TpYsw9znS/16/6W3y0juqXKZ5DH1pAZ92PA9tReToVCvK+Bdax22q5QujZP5ObDEzZWiGz2OOYXekRhdopnM73GJoC9hzsH9oy9aN3vTwSa0WF9EUrHvprv5pWPXQ+RcVXtdq6gxnSA40YMWclCuQaIPOZf/gJ1ypj3DjH2HUis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=EiG549gj; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fec34f94abso10227285ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 13:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1722976254; x=1723581054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGjOP1lRrUIGHHfY/ucyJaa3OokEJdc3Rk3ANgx/cL4=;
        b=EiG549gjGbTqZdMEzXLBvzxehHXQ4WAuK7H9zhgm/MB0ClSLiz+Lx1MXfW8B7axF+l
         nBdKWFHIbcsD74USqO201OHHy5iI5J2J2usY6J1yiT/yw6fi7Q5XBymkmDs+i/iucfNQ
         1o9HJFrmKxsY9y+IA/Dv/UksFbh90udLNeXoHeKl7lP3uULojNniYPEz17DBqZMZ22vj
         bqiViQyNxj8z/uY5zHHEKZEteT1+tt9w1qY+yyIbo+1Fkp8to082dgayGq7biWAAT1F/
         F+bQG1GiUeMx5vDOXYhtV5k6snFQQn9jpobdzcZvnB0nLD38TeCa112XPvh/0Chh8J3u
         gDZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722976254; x=1723581054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pGjOP1lRrUIGHHfY/ucyJaa3OokEJdc3Rk3ANgx/cL4=;
        b=RSg/4KmwuCqvxvy+8sPCEN9UhMHi9XK70wtDiHam0cFg2A/dD82dfQ1AW0S7rIgr1U
         WeObn5Opwdm9KgUlXEPQtOsu2JpROSGJ4CwhK4iPn5Dd8c/fr8Q2PnynZ4MKj/Vp7T9O
         LoTIORkzZyob3czFaPKVLwlZnZmzIx/0UnV870l+oh21xYuXQtYXPxmpxovZyrgLs4S7
         ebKCuzIN0JvfRwg/kAVxTM+K4zS2GW5ji+fIAhUIb/AAUzODQMA2b1MtlSvN56pRMtdh
         ZMzO2hBkirYUNKjMeB2g0Z2uxoitc0xrt+v7CzfCBYijaysw+4QOz/BbnyOwDLIiv8x/
         OxqA==
X-Forwarded-Encrypted: i=1; AJvYcCUWfg5z0rzj45afzuvcB0+mFiYVBGcOnd/QJ2SDf60b3i3Fzap1wqfxKvWUjy3hShVuvggidsAGkxzCQV+qJGoW1ABR1oXY9ALcDOoG
X-Gm-Message-State: AOJu0YxPhzRM6FEsHhMbDBOyvmj8PR/Gcxm37e/mtRyTKlD0sUaAs4eO
	kD8yBjnNxKer/LE4xp69ieOU7SBmTxmRW5tj6oP8iVwczzUUJiEUSZxcB54Ax8c8PzhRKngKKvq
	kRYzcDqEFGgmAoXn6najDDHFyzN8=
X-Google-Smtp-Source: AGHT+IEks/oAZa8ntL5YZ2Jy/KZVr3ukaB2BFUAtpfcEpVrc9hTXXkB88UBCo3OXbZXNdpKSoeO+mLzLsyC2xIw91ds=
X-Received: by 2002:a17:903:18a:b0:1fd:9c2d:2f17 with SMTP id
 d9443c01a7336-1ff573bb69bmr145408745ad.44.1722976253993; Tue, 06 Aug 2024
 13:30:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730125023.710237-1-jbrunet@baylibre.com> <20240730125023.710237-5-jbrunet@baylibre.com>
In-Reply-To: <20240730125023.710237-5-jbrunet@baylibre.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Tue, 6 Aug 2024 22:30:42 +0200
Message-ID: <CAFBinCDun9kgPO9ko9seFvWxjZvHwpRO=SaPrdxT1_Yh-FzXVg@mail.gmail.com>
Subject: Re: [PATCH 4/9] drm/meson: dw-hdmi: fix incorrect comment in suspend
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
> Comment in suspend says TOP is put in suspend, but the register
> poke following is actually de-asserting the reset, like in init.
>
> It is doing the opposite of what the comment says.
>
> Align the comment with what the code is doing for now and add
> a FIXME note to sort this out later
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
(based on public S912 and A311 datasheets)

