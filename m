Return-Path: <linux-kernel+bounces-284418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DB99500BF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 11:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3A391C20F26
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4BC186E3C;
	Tue, 13 Aug 2024 09:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ONGFam6b"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF36B17B421
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 09:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723539837; cv=none; b=CBfmkoJ3O33uRmwKFXB3FHoWe+GZNYn4frhOgEoxP9AhFDIKJr13ExsgnF/BLeilMFFqgebAfltMxDby8VG7wy2U5DAf9aGgTDBRXL7QZ3jb4gIHwEH1Tlxsc2wCzVzv1487I7PkxSiuEAAA9XoHHkjmsoo3oqjsf9Zp7doNUKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723539837; c=relaxed/simple;
	bh=Ve4jbSU7S9ExZbxJjtrrBtClvd5I5lhR/E8IhWEXAFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MPZ9RymSpOuakWpk6REkEinHgVOhDRZnIZpKuV+EoC9rozaf4BwW5GUQfq+gzO1Ze77b0k+oln/wupxl29S3YKdtnSSYaOXZpnh/9D2Iz5Dyj8jkS8HJCg2SOGNy/C5LUczvWqONB/F3G0Nrn7JrjqUg/ZkrsNooEQhuRzaky4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ONGFam6b; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f16d2f2b68so73139831fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 02:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723539834; x=1724144634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ve4jbSU7S9ExZbxJjtrrBtClvd5I5lhR/E8IhWEXAFc=;
        b=ONGFam6bA0iGA9MQv5hJOKYPZaL7w8lImm/rEfITGq291/kZhx4qFQnDwCWRJLuQQt
         1eVN3RHKeEQfGAoZe2SSeVsFYcFaJFJXyyOXCAYC/U8GPEsKSu9h0Pzo0Yl+HfAGJGUk
         wvf81LRQ8vP5o36JImmBcvGphC7nXgn2PAmoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723539834; x=1724144634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ve4jbSU7S9ExZbxJjtrrBtClvd5I5lhR/E8IhWEXAFc=;
        b=LLqT/IvzC+1jqJAsPZWsEeger5zqQQS3G0mjjTWReC5LF3EKO5XwndtYBw08BGfo7u
         /pM0nQvKzOy6+MNMjkNKcp4AWNiJNss7Bv9ff/D0v9MlH7BGv1O2ZTpP/uLjwIszEriO
         y+lECLNiOGrWcjPLRT+x9GOcBloOkEGxWL0C9I96G4TAHULzsDX3DMaFrADFCC9Qi133
         7PAKpNzFv5xwm/uWRW1T+5KfeCdnuXKKVrf9o8/0YgybY8H9nrNi3PKC/I5yjS5coruW
         kJt1IrZWuVFXZOOq07yT8LCxU5N6VOK3bSoSWQIpr7ntx2hjzESvArebPE58+3LXCEPe
         tZZA==
X-Forwarded-Encrypted: i=1; AJvYcCXO/UikULCFBdh3DpPPnqy5NhjuSXU6GRAnTRN0yRJc789ojMPuAptSlyCQrRVybMp++Evkp46yI62RBf0NIKD3H8iW2wkm202VFD42
X-Gm-Message-State: AOJu0YyXeGjRB3cpykG62q8PoB7EX+GRFPp3esrGMhLFicoWa0AzIQpe
	7/hj0ElK60t9bRvmgt8hoEcWIKC2p9Sml3YtRyD5ucLrIrQp6vTgOO8BQ6ZSEfI8mrg+h719KYk
	ZAYbAeAunyOOIDvy0LQKxk04de9F1/O5hJd/A
X-Google-Smtp-Source: AGHT+IG7NaoKLkQNmaW+Q8ybfg+2Fkm3g2gdZmqPP65jKw5bs2Y5MuNgZOgxthLiif5iORngSqZhzj93hj3oIkVu1A0=
X-Received: by 2002:a2e:3c14:0:b0:2f0:27da:6864 with SMTP id
 38308e7fff4ca-2f2b7150009mr22309211fa.17.1723539833287; Tue, 13 Aug 2024
 02:03:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809135627.544429-1-jakiela@google.com>
In-Reply-To: <20240809135627.544429-1-jakiela@google.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 13 Aug 2024 17:03:42 +0800
Message-ID: <CAGXv+5FpYxyANqp+uMoJP4my7e_yjSS7eFOodG-UuGG6eHCj-A@mail.gmail.com>
Subject: Re: [PATCH] ASoC: SOF: mediatek: Add missing board compatible
To: =?UTF-8?Q?Albert_Jakie=C5=82a?= <jakiela@google.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
	Bard Liao <yung-chuan.liao@linux.intel.com>, 
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, Daniel Baluta <daniel.baluta@nxp.com>, 
	Kai Vehmanen <kai.vehmanen@linux.intel.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Trevor Wu <trevor.wu@mediatek.com>, 
	sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 9:57=E2=80=AFPM Albert Jakie=C5=82a <jakiela@google.=
com> wrote:
>
> Add Google Dojo compatible.
>
> Signed-off-by: Albert Jakie=C5=82a <jakiela@google.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

