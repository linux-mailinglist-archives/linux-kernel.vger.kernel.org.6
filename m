Return-Path: <linux-kernel+bounces-325207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C008975621
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 148BF289BF0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A84D1AAE32;
	Wed, 11 Sep 2024 14:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CUDBZQdb"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A091A3044
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 14:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726066577; cv=none; b=jYKTv+0ZjL8w8yfKMpQ9T91lH/w4foMmVB06BfSSAxJTOcFFVEm2kdP4YG3Pk9K5nGvlfVLi9PfDOqyMqMufJVPjbEbTM3r90h4ZnRUNXpVFarq9Km4ld2tQEPVrXyM2LGU8T4gi82W7k9eEIejkfrKWehtiehBB7RyHlATg4fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726066577; c=relaxed/simple;
	bh=5y6hlVFNZ9ghFAZ/dOgsxCt/q59tWWK+iBtItb690SU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ublmEIiJEQ8mUq3ux41ZMmcQ+pJayQH8EhDUemM01euqMS/PzVEIeMari1Yv+MdD7i63HFibbadttDVDz+l501qGiMNXIF6WOtf8HclXjYX7j44gYp521MIcHoymYOAtval18PCQO9c2XBgM6YBZymEOMbFFtwGbDyTqUEKg9BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CUDBZQdb; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42bb7298bdeso82945725e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 07:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726066571; x=1726671371; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5y6hlVFNZ9ghFAZ/dOgsxCt/q59tWWK+iBtItb690SU=;
        b=CUDBZQdbJSXU5H0c05OvytdyQG2ctYFHXVJyWto0hYCduHRsYVfC1cbZ6pRidEOzaU
         4AARucgZIX6HyXXc12JKac97DUvf01IGFbySFISs2sLOkeakv614aql3PoKoOzkX7rxI
         hiVYGG81JAg6iGq/IEd2tlsHK/9BoPH+8r0v2zT0gyAoQLrJiAdP55J1NX0Fl8D6uqrk
         5hCwvseiZZ2BNDWfg7Z+TPdCSLjarUKdI/gKk/elB+NZGSl645ALbiQ6kMPVaJk0JEyA
         roaeqlQ4Uqg/rUg39A3ZJsXCz1kRMgLV37n2FwypSfRRmddNnmEM7H/aUxBmZ56uW4i7
         fFJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726066571; x=1726671371;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5y6hlVFNZ9ghFAZ/dOgsxCt/q59tWWK+iBtItb690SU=;
        b=VBwpqaQnIgVwbMkjxIxCEfr0/T+KAJ/l+lJtjxtKU8cMupF8AeuzakrIwea9icCPOf
         edGZMddIGQ6Qcp8qpVjuVYfSAUM+hr9IP5b7CkaQfSYyeTM10D+XjfyEUGVGChNtajYB
         esv6qzA2oqG4CczxUiJcNn80TVSLFv0X06Ber22dV5GKUZiyK94wNFgRQVq1r+ksau/I
         wEp8nyM7/7u+iQFTNvghADcipsVNWexueHMs4bNaeSCZtPJ+fipxctUlXTtBuhe+QZr8
         KYHv8RqMdaXupKa0DXwZbpa+voyEZB6HGwhACaQgP/j9d4ZFIDCSjs+nLNQrwj1S9NWP
         Q0Gg==
X-Forwarded-Encrypted: i=1; AJvYcCXuin1CrC9I58bbDla4f2upSdqQo3iEei/TBWJO4U7TosYOG2uV2DWMh6NN00X+Dgz6Wy74WQ9CyyYjzf4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw8KT0TAntH0Pkbi3xC2Ht9HDsNBrtaKSXBz2oOCJq7PAnJY0M
	5Hv31CwhUolLolXQaNTSiuIqnNcv7ZB8L2ABAh5Z6MB+3+UhAT+/TJY1qxt1uQ0=
X-Google-Smtp-Source: AGHT+IGXbGreRimd0uqLh23FCjFV/446HYpWf16uni3SRkxonRMyp0eon2FdyilvNaU/tKo5u9ETgQ==
X-Received: by 2002:a05:600c:3b9a:b0:42c:aef3:4388 with SMTP id 5b1f17b1804b1-42caef34492mr123874855e9.6.1726066570926;
        Wed, 11 Sep 2024 07:56:10 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:7388:2adc:a5d5:ff63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cb77afd5asm105511255e9.17.2024.09.11.07.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 07:56:10 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>,  Mark Brown <broonie@kernel.org>,
  Jaroslav Kysela <perex@perex.cz>,  "Takashi Iwai" <tiwai@suse.com>,  Neil
 Armstrong <neil.armstrong@linaro.org>,  "Kevin Hilman"
 <khilman@baylibre.com>,  Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>,  <alsa-devel@alsa-project.org>,
  <linux-sound@vger.kernel.org>,  <linux-arm-kernel@lists.infradead.org>,
  <linux-amlogic@lists.infradead.org>,  <linux-kernel@vger.kernel.org>,
  <kernel@sberdevices.ru>,  <oxffffaa@gmail.com>,  <Stable@vger.kernel.org>
Subject: Re: [PATCH v1] ASoC: meson: axg-card: fix 'use-after-free'
In-Reply-To: <20240911142425.598631-1-avkrasnov@salutedevices.com> (Arseniy
	Krasnov's message of "Wed, 11 Sep 2024 17:24:25 +0300")
References: <20240911142425.598631-1-avkrasnov@salutedevices.com>
Date: Wed, 11 Sep 2024 16:56:09 +0200
Message-ID: <1jo74uqlx2.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed 11 Sep 2024 at 17:24, Arseniy Krasnov <avkrasnov@salutedevices.com> wrote:

> Buffer 'card->dai_link' is reallocated in 'meson_card_reallocate_links()',
> so move 'pad' pointer initialization after this function when memory is
> already reallocated.
>

The title could have been a little more specific.
Anyway

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>


