Return-Path: <linux-kernel+bounces-276843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD56949915
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B85E1C21442
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 20:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD6E15688C;
	Tue,  6 Aug 2024 20:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="NSSimto/"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64576EB4A
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 20:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722976103; cv=none; b=uPIef+yETMsFLyRCahO/yg668ReGN/uoKWipwcUaRCSjAsB+AyGQf0qdDVkPV/NPd/OvQ/WteZpcCE1Eff2n2pdhzVdIkBLJxaG+VNAe3uA3jm6om0a1qC8ax0PXJP4++RGwm204K0ElZP56dKEc69w84+JrdJwzQrDljRqOuN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722976103; c=relaxed/simple;
	bh=NewxizV/QrE0bDS6mTJcWWeH0ghijd0o6ZQvUX6X8Co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VK3yyhBz3ki0AEbmlilOlxsZ/i/TTebE1qVUCdZABeRuBWQs7kWKP1p0GrezrcZAcbLOwB5Jpx3U3UbTcAcwaAwbANONI8NLg37b3NWcxfu7VoOmVANf7Gcs/1/RcQUwn9airEjwKv98e1U53rvELuXOoQ+hSRF45GmdMIUwnH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=NSSimto/; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fc56fd4de1so1772295ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 13:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1722976101; x=1723580901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NewxizV/QrE0bDS6mTJcWWeH0ghijd0o6ZQvUX6X8Co=;
        b=NSSimto/PRLt5uHA1Wa9qAzk2WKijXTsPtp7+hybXGvo3XDk2B2kASm36m2srm5W1x
         DhOzn7BSWXnK/DrovuFagXocDFypAZIZXjvRLKi4f8XHjL8servwsaqS9aua28uqTlnU
         vcRkvS2aes7atOIHEOuALZx7/ucBajyDTlQBRK0HuxggKZEic5AjcoBef6w8f6oGLzCc
         H+S+z8A+jRaWk2hdRvH+f95ywz/dg6S0yXThHBxE/GCcVg5KNUalcVP5/2WxTms/RoQN
         MDbj4l17tmUML3KRlhH8hRlLpkWWDGxKuhi6Pj/GcquSg34dZ6hqU+h0+wk0mEqTuafK
         aQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722976101; x=1723580901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NewxizV/QrE0bDS6mTJcWWeH0ghijd0o6ZQvUX6X8Co=;
        b=pmY6KP454aJ+4hnXjglfkxzTL+tK/CgbDcc0KkChP3td85fc5kwIARebndBQSfiIqc
         FfUNTdHYXs44+xnyAu950KonMDXOOyiRGAW1y3xFnNt/SeyohKyEmmAv4B554hqFHx3e
         00X96F2HL2AJmPgNs+d7q0xRdqR6roRR13S75gaJKyi343pXURfp5p1PLIicDWEflS04
         E76ZP5zdViBN0NlW+VdtfbonbbSqJ49S9ex2qlgwNFWr5l34RGG/rvoE1mJZiGNQJb6e
         a8d09s8cGQjGzFBI2xtkPL+pclQt2J7bEbdBjaArVZsbARM2MSjPmAIkTlRuT8c6+vh0
         3Cgg==
X-Forwarded-Encrypted: i=1; AJvYcCXJYuY1cabJt78DZy2lWXemdzjl+nHe7IziKfuXMbmAzgqqHdvn08OBsBz1gvyho0EcE+dAnBCcIhTXLqDhKUFgg0DzeI0hpq7TN9EM
X-Gm-Message-State: AOJu0YzlMFH1ti/eHwmpFyeU/VFr4wIe7E8EsZcPkSRJqFAcA9wPYNzh
	3cnY6K4nAalT1Oylvl66W0heie7OQhnvQCWIU+L208zjkHoJ5IpDPpuLN/xcI9V/FppyLop2jI1
	z/gF/nvjnOy5oB9G7ZAfGR50YUlI=
X-Google-Smtp-Source: AGHT+IHJzplOe6T346XHNyXlXK1O9+ysbtzTM327nVE1L0ilozkYUPHpw1p+kyXVwiPZ5odozVxc038s2IOyIQTUyCU=
X-Received: by 2002:a17:903:1206:b0:1fc:253b:5951 with SMTP id
 d9443c01a7336-200853a50c0mr27695ad.4.1722976101123; Tue, 06 Aug 2024 13:28:21
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730125023.710237-1-jbrunet@baylibre.com> <20240730125023.710237-4-jbrunet@baylibre.com>
In-Reply-To: <20240730125023.710237-4-jbrunet@baylibre.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Tue, 6 Aug 2024 22:28:10 +0200
Message-ID: <CAFBinCCW9bNtHLRaJNBvqLXN_vCm4mFSVhhV6OcrUb+j-0x3kg@mail.gmail.com>
Subject: Re: [PATCH 3/9] drm/meson: dw-hdmi: use generic clock helpers
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
> The Amlogic HDMI phy driver is not doing anything with the clocks
> besides enabling on probe. CCF provides generic helpers to do that.
>
> Use the generic clock helpers rather than using a custom one to get and
> enable clocks.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

note to self: even if we need to manage one of the clocks specifically
we can do it with clk_bulk_data

