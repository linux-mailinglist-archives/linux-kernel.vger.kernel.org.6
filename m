Return-Path: <linux-kernel+bounces-280566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 040B294CC30
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 10:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86337B246C7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 08:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44E918DF9A;
	Fri,  9 Aug 2024 08:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pP6aFQTe"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D38218E053
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 08:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723192150; cv=none; b=Mb+HrsxlWC8d+sQ7ZGAKUBcFzVo0swJ6BmWKYynhYI+j2r7L/saPGpM8fF3gx9ZRR/YV/XiXJQ6mYQ2pNcxnZertufjfvjnfPs/wmXaCmHdigatNvL8bZN7SJNRwNhQLH8qgF6NewrbrG2DrgWrjqvuAMSDJihAnog1CUnBtIU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723192150; c=relaxed/simple;
	bh=rRzR7Rhb6KTpSoOJoC/MP6DtbgV1G83HjbsiHEJJe+I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Indf3yhZwD696Q6DB9Zymr2oCV/cqkwi49ezZj9RpSAzxc+9Su2DMXkKVn43W2XqfLxXoea/Rk4dhuOm85vwjP0A1pxc4B1N69+Og7FkipCqMRA4fC2Sf3yXP7UhH48K3Cv/eZT7xHOMUwhEK8EE/tLOu1ywqkFAECmP6n3btaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pP6aFQTe; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4281c164408so12883755e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 01:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723192146; x=1723796946; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=M9XgrXqJt0/9CkMxHNu45QhllGaF2W8Tzkt4pRfBbFk=;
        b=pP6aFQTeXcYBB2v+/KOa5DfRHS5a0mulNtQVyA6YFPmPptnlKWb4kQF/WyUpGIcowl
         HeNJVbrsp48N6/mlFzxprJQ2X5NK24q3ncES7KG+FCuu9WoDCZLgbxC08LVJ6kJlpeFK
         yYcPQ/73xs+A3pOgj/0VsH3+WAjLGFkpOXcgfCIrMzkgO6XcgCQxJK/bEsx4gUi4J/1e
         AqQh6JiG49LI64SDfCTP85IHVL04yG7JsgubJLKWZggpU6Z2mxnBvBG94u9NIVixLhMh
         ebSfzt7LKQRrhCHXWU9FMYXbEb8tpnnrXTkBWLTQ2NV7oYne3y5fcC4y7oAKTsJZzpQW
         u8Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723192146; x=1723796946;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M9XgrXqJt0/9CkMxHNu45QhllGaF2W8Tzkt4pRfBbFk=;
        b=wLVrBmWG8WTnh/tbBK5gQGMEH4Hw9GJTggweqH1QJ1O9iJLVlpR1MhlUK/JbaGxVLL
         EAaiwrpyGpSkVKI5/vqalOT7VIf/Eb/hBS0nbVCwtlUL6BBqo1NtMKY25bLucmUV31vP
         Zx7CB22/zuBQfYoPhgtZ4SQ937EMRG0iP2clFJ6XamBMbt81LKP+/Gp1DOc3cICzv/4H
         q1sRUyAnpL8BELIcGCe/+mDy5xz1vt5QismiQJBtJflIDVExILCpo1JBlLd+kny1vNrM
         306GK+McBqVa7MWYBqJ096b0cMQl1XjdOZK46jvfRNe9AKg/DsT5QGm+HwuCmQb+hBqN
         +QZw==
X-Forwarded-Encrypted: i=1; AJvYcCX80rbBT3nWPv/JnY20JzzTOlgACgOoGDIJwKDevnMBxOcg0fjAjwecXtqaf6mzB0ywCgdS5VdwMfeCRlSEB47/CvPJTNf0el7kpypE
X-Gm-Message-State: AOJu0YxKFmCLumC4hQ3YuDAKSpZAeIlLklZAB2D5KT1ZeWs/OrMakICb
	oz9C/KNeeAgCNwwNPD5IGTgo4Yi02lGtL9lZ8zryzTdHSl4uQve57AXgfzQgNIY=
X-Google-Smtp-Source: AGHT+IHe4KRBbn78xJ+uhzDvBdPlN0FDRDNiUwGsnx4SLammGg6F32dtNQbopsE3P9TfIiTwaOcj/w==
X-Received: by 2002:a05:600c:4514:b0:426:5fe1:ec7a with SMTP id 5b1f17b1804b1-429c3a58c23mr6422525e9.31.1723192146423;
        Fri, 09 Aug 2024 01:29:06 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:f0cb:cecc:348d:4d08])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c74a855sm63260855e9.25.2024.08.09.01.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 01:29:05 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?=
 <amadeuszx.slawinski@linux.intel.com>, 	Mark Brown
 <broonie@kernel.org>,  Liam Girdwood <lgirdwood@gmail.com>, 	Takashi Iwai
 <tiwai@suse.com>,  Jaroslav Kysela <perex@perex.cz>,
 	alsa-devel@alsa-project.org,  linux-sound@vger.kernel.org,
 	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] ALSA: pcm: add support for 128kHz sample rate
In-Reply-To: <87ed84rnk7.wl-tiwai@suse.de> (Takashi Iwai's message of "Mon, 08
	Jul 2024 16:00:24 +0200")
References: <20240628122429.2018059-1-jbrunet@baylibre.com>
	<20240628122429.2018059-2-jbrunet@baylibre.com>
	<326792b9-e706-4ab0-a1e8-cc48943e357d@linux.intel.com>
	<874j99434a.wl-tiwai@suse.de>
	<1j4j90hurv.fsf@starbuckisacylon.baylibre.com>
	<87ed84rnk7.wl-tiwai@suse.de>
Date: Fri, 09 Aug 2024 10:29:05 +0200
Message-ID: <1jcymixfou.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


>> 
>> Apart from the problem reported in sound/usb/caiaq/audio.c, is there
>> another clean up expected ?
>
> The change for caiaq/audio.c is rather a "fix" :)
> As a cleanup, I meant, whether this extension can be applied to the
> other existing drivers that already use 128kHz with RATE_KNOT and an
> extra list.

Grepping in sound/ for 128000, I've found only 3 files which could
benefit from solely adding 128kHz to the defined rates:

* sound/pci/cmipci.c
* sound/pci/rme9652/hdsp.c
* sound/pci/rme9652/hdspm.c

The rest are unsing other rates which require the use of RATE_KNOT.
The most regular rates being 12kHz and 24kHz. Adding those as well could
help in:

* sound/soc/codecs/adau1977.c
* sound/soc/fsl/fsl_asrc.c
* sound/soc/fsl/fsl_easrc.c
* sound/soc/intel/avs/pcm.c

I admit that's a fairly low number of drivers, maybe it is not worth it
at this stage.

Takashi, Mark, what is your preference ? Should I:
 * tweak the spdif codec to use RATE_KNOT ?
 * add just 128kHz, fixing the 3 file above ?
 * add 12 and 24kHz as well ?

I don't really mind one way or the other.

>
>
> thanks,
>
> Takashi

-- 
Jerome

