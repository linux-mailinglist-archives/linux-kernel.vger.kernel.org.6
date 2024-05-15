Return-Path: <linux-kernel+bounces-179876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBFD8C66CF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 15:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A8A21C22C01
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 13:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B98784D3F;
	Wed, 15 May 2024 13:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="T4S63KrV"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E8084D0B
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 13:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715778198; cv=none; b=e3ImMj1UNJAHnxzdQdcDKjEd1eYjOuUwQlIPy42R6e+6GYBJUyt2MbncnZCNavu9AxHz2dApwDnvibhYXPec+XwB+MxEB34r/lrPYUuNpv8Pl80DUWZzmBz+Zvj7kyupBt30M+0h/K1jngnmfk9RpJepC4ZRJqU+EVz7lHauQuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715778198; c=relaxed/simple;
	bh=rPRT0MsdY9af2mGauqLnrYy4g8q//Ph0rBvWLrVQuCs=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=bqNZfsR2DlIvt54EfnWMqzF2SJlJRPKZItAxRR8R3jVxfQiGYYTGJqS59Y3WKdmEWGxdgagoGHghFerzU0olzM02cpn+uUUwsatYK3+EOoM2vF5jixOcGpNbDLHrbhu+2t1apmm5nlPKdOIvCinfvqQLvwG1yrrWwHKFh19XuBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=T4S63KrV; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41fc2f7fbb5so37857585e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 06:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715778194; x=1716382994; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=vlvP4Aa3+nQGmGgcIFiojH5cc2twOueCv7IOqtUVD84=;
        b=T4S63KrVY6EmtTcQeta10Gr6N72BYFfiSoNm9VRMGg/mXU5D2AWmeVk1+/7MXzXWl5
         nUSWFTn4WpNmZseP+yz1B8lbsyC1WGa+GtH5NwoF8lIAMOU5i90wKMi2uqY8z0IfVDmE
         2c7/TH6b9GNL8/w5B57HF56kba5SRmQ+AhI8X/vgqUQjNUZzVIJnEKp+0usTZKl7Qtt5
         IcstSwE/hvsEXxd810PY7Jv+2qQVc5oFRbjeeD7YnuydQzmkwHsjx14Y70aSa5iHGXAW
         L/fptVds/i3fyM6Wtl97TFLp7ncJ8BEdFZdiQybNuE0vU5ersBkcH8cfWObjay6kJPXR
         A4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715778194; x=1716382994;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vlvP4Aa3+nQGmGgcIFiojH5cc2twOueCv7IOqtUVD84=;
        b=a4rR8jjxVFUxYjKPr1FxWHTBWTYFy+gYHnOe6sqxee/avpFXyf3MWirLa2o3xnuvhK
         AFwP8EBdKneRwXkJ8ve+Nh+Iq0+AVa8Y8QrinlUBCQIh1UHHbsxcKR4G/f+iCdYI13gj
         cF0kFtZYB27MsRnimTu7Q3U5ju8QCS2TVgBN05guKkqQ2BU0Qo2o8LERvbMGRdVAf3Mt
         QVXOMLP0FyYvDE2KSgQRCdkJvtT+QJ65MYQo823teCffcE3zdJark/ERSJvDtNEoDK/U
         NzXRVSv1e5wIhQvJYVyXSFNu6/jVs8ee6FoKcvDxkS9JSTrLCkDXQxNkrrO4OXN4Qv/v
         Rb/w==
X-Forwarded-Encrypted: i=1; AJvYcCXvH4xOnMvHb+oLyDU8IEkZgaB6SR+zukxFUz9c2oqXGhv1yB+Q4yl496st4Soegvz6oXeODKlF6yB2YtPkCZwIny2Oq+gzChlbqr82
X-Gm-Message-State: AOJu0YyZqDIYM5XnGbCGjKXzTZNTMHsBRpNQJMX6gvFWkI9ziwo7eEAm
	9PN8PEf+bmgtK9GPnOqGUtTJAczA5Bi6OGmDrx84dN87/eneKPqy95qg0hBo7ac=
X-Google-Smtp-Source: AGHT+IFd1u7hHWUOgkLnsccx8x9MoqmA5KeoD0+FaBvMmlYandqrEjUD4CsLZc7fApcCVFV1xfjlyg==
X-Received: by 2002:a05:600c:4f06:b0:418:2981:c70f with SMTP id 5b1f17b1804b1-41fbcfb8473mr168925435e9.19.1715778194502;
        Wed, 15 May 2024 06:03:14 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:2893:1a8f:5988:776a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccbe9011sm232644255e9.7.2024.05.15.06.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 06:03:13 -0700 (PDT)
References: <87o79azh65.wl-kuninori.morimoto.gx@renesas.com>
 <20240514143116.3824376-1-jbrunet@baylibre.com>
 <46daae9b-10dc-4f49-8a25-c387d03ae87a@sirena.org.uk>
 <87seyk2dmh.wl-kuninori.morimoto.gx@renesas.com>
User-agent: mu4e 1.10.8; emacs 29.2
From: Jerome Brunet <jbrunet@baylibre.com>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>,
 Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
Subject: Re: [PATCH RFC] ASoC: amlogic: do not use dpcm_playback/capture flags
Date: Wed, 15 May 2024 15:01:35 +0200
In-reply-to: <87seyk2dmh.wl-kuninori.morimoto.gx@renesas.com>
Message-ID: <1jpltnxm5r.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


On Tue 14 May 2024 at 23:11, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com> wrote:

> Hi
>
>> > dpcm_playback/capture flags are being deprecated in ASoC.
>> > Use playback/capture_only flags instead
>> > 
>> > Suggested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> > ---
>> > 
>> > Following Kuninori's series, dpcm_playback/capture will be ignored.
>> > However, properly disabling stream direction is important for Amlogic
>> > audio drivers.
>> > 
>> > I'm not too sure how this should be applied to avoid breaking bisect,
>> > before or after Kuninori's series. Maybe it should be merged into it ?
>> 
>> Probably better to integrate it I think?
>
> ASoC needs dpcm_xxx flag *before* my patch.
> Your patch is replacing it to xxx_only flag, so it should be applied
> *after* my patch. So integrate/merge is good idea, I think.

Ok. Then I guess it is up to you and Mark.
Please let me know if you need me for anything.

Cheers

>
> Thank you for your help !!
>
> Best regards
> ---
> Renesas Electronics
> Ph.D. Kuninori Morimoto


-- 
Jerome

