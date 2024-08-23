Return-Path: <linux-kernel+bounces-298325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D3095C5CE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35485B22B70
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 06:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF25139D00;
	Fri, 23 Aug 2024 06:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Gvv+tMGc"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30541311B6
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 06:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724395814; cv=none; b=lMkyVsm20AqdCFMEoSpokHmEpsds9ezlYGLkSRB/VfSpwgy/vZRxREdNV4qLPmh58A5/hvmODmVwi/qzYAKzH53axpSwJjMaeEJFx/KJueIg3MbkM1QLZSIDA//Y05qJFRpOD0QA2kVmS4dsEnATlvIe1lyQqAdxi/wNKwBgu2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724395814; c=relaxed/simple;
	bh=TB2ZVz2m724zZx6Ujp8dGDELTqfijkJibPZvF/Zp9rA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UK11+lSD/f8y5k43gE6Y7ZPyNkWEBPzsOqlzunDAmt+6d2Lvn6/gMXNT/lAcDgXBiOfPZyrK309AngkU+zvIv24None+Y4AJYT5gmZNhzcWGvFd/boAh6a7Q75mnHW75LKetvBSgp69HTkeXbGMZGpOXOVNL0ACPbUtIhdyhVbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Gvv+tMGc; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53436e04447so772589e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 23:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724395811; x=1725000611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TB2ZVz2m724zZx6Ujp8dGDELTqfijkJibPZvF/Zp9rA=;
        b=Gvv+tMGcaLCAIo95DPOu4NGSBE+k6B01zkdprZ62Qutz19xQa91MkTYV4l9iQNOALQ
         h1vkNduotd17W0OBWHEA42DcDmWOUCk5RZzEnKarDeYtqmhpxSjQSb3YRPo2RgEXb4aN
         zoJVr8Pj7lPqp1BHY0GAtRGoH6mqIDidRTQos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724395811; x=1725000611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TB2ZVz2m724zZx6Ujp8dGDELTqfijkJibPZvF/Zp9rA=;
        b=F+4Iw0oueQKA2t6AMt2HLciyiRSiZPe/tA30FSMfSduHBy5UgPV77J6qGJ56gibGlc
         zIcLYvK2Yw4BfA64xMSSuxdYXWCqJsOx9YmJvTx9bzKuzyuuASG0LyO52KyIMCIfHKj0
         IDLv0b4k+SYa0R13EbejIfS8XNPY8xA1SBTiLRXNPYAYLOS65K5H6ErGX8uzfJXeavrz
         PYKQw4Zhj6IvWfaoHb27ihhzWbMvAyxe6dwS4ZfCcoEyKDu6aKMfT8rTq9qBugzFcuzv
         Go/SWHM/SQ7t3qTjltzyyEE4o02NINie29NIHS92HzI0+jOqGbFlkamVU3yojQMtdk2r
         oYjg==
X-Forwarded-Encrypted: i=1; AJvYcCXcnWAhiumHf0GeOtP3fFzrZkp83rKnxyruun3aZjxvM7Qppwh9kMUEGqLSwgWhOY7AJGLE8tYUS858AH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YynlXapH/4vHNmjo7CiszmTU8EpbaAX/itJnL1ovjKRYPYrlCft
	dhmYTkUj/oPqbNCf0RLmcqDSK4hZChE9aUqjBE4a6oPI6Vb7bm0cUZi5S6WcHos0VHDsIHU84oN
	cY8qXZcznVMqqwzSImit9ZcTSo04hc6RdId9K
X-Google-Smtp-Source: AGHT+IGa3g4OYj5kLrZwDfDw6Q/Usbiq0edBIdEx656twbCcRzHHZoU+PFE0vnmEsF1p09zxCx1iToHq1XRcOx6R0cA=
X-Received: by 2002:a05:6512:3052:b0:533:4613:21be with SMTP id
 2adb3069b0e04-5334ca861e8mr1890209e87.18.1724395810568; Thu, 22 Aug 2024
 23:50:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822092006.3134096-1-wenst@chromium.org> <20240822092006.3134096-3-wenst@chromium.org>
 <ZsdBddTDuvNasHNq@smile.fi.intel.com>
In-Reply-To: <ZsdBddTDuvNasHNq@smile.fi.intel.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 23 Aug 2024 14:49:59 +0800
Message-ID: <CAGXv+5FjwxGQgV6SdLfTeNRYbpcgwkEnCWvaZiWh4rs3bhs-2A@mail.gmail.com>
Subject: Re: [PATCH v5 02/10] regulator: Move OF-specific regulator lookup
 code to of_regulator.c
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Wolfram Sang <wsa@kernel.org>, 
	Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	chrome-platform@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, 
	Johan Hovold <johan@kernel.org>, Jiri Kosina <jikos@kernel.org>, linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 9:47=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Aug 22, 2024 at 05:19:55PM +0800, Chen-Yu Tsai wrote:
> > There's still a bit of OF-specific code in the regulator device lookup
> > function.
> >
> > Move those bits of code over to of_regulator.c, and create a new
> > function of_regulator_dev_lookup() to encapsulate the code moved out of
> > regulator_dev_lookup().
> >
> > Also mark of_find_regulator_by_node() as static, since there are no
> > other users in other compile units.
> >
> > There are no functional changes.
>
> ...
>
> > +/**
> > + * of_get_child_regulator - get a child regulator device node
> > + * based on supply name
> > + * @parent: Parent device node
> > + * @prop_name: Combination regulator supply name and "-supply"
> > + *
> > + * Traverse all child nodes.
> > + * Extract the child regulator device node corresponding to the supply=
 name.
> > + * returns the device node corresponding to the regulator if found, el=
se
> > + * returns NULL.
>
> At the same time you may fix kernel-doc warnings (no "Return" section) in=
 these
> three (on your wish you may fix others in a separate change, but it's not
> related to this series).

As you said some other functions are missing it as well, so I'll do a
patch separate from this series to fix them all.

> > + */
>
> ...
>
> > +/** of_regulator_dev_lookup - lookup a regulator device with device tr=
ee only
>
> Something went wrong with the indentation.

Will fix, and also add a "Return" section.


Thanks
ChenYu

> > + * @dev: Device pointer for regulator supply lookup.
> > + * @supply: Supply name or regulator ID.
> > + *
> > + * If successful, returns a struct regulator_dev that corresponds to t=
he name
> > + * @supply and with the embedded struct device refcount incremented by=
 one.
> > + * The refcount must be dropped by calling put_device().
> > + * On failure one of the following ERR-PTR-encoded values is returned:
> > + * -ENODEV if lookup fails permanently, -EPROBE_DEFER if lookup could =
succeed
> > + * in the future.
> > + */
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

