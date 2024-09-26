Return-Path: <linux-kernel+bounces-340437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC94987366
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 14:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 947B01F276C9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED401607AC;
	Thu, 26 Sep 2024 12:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LMnPKVgg"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74589156230
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 12:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727353046; cv=none; b=KXDXdzhKoyp+CvmydMJ0oQgsr2DVUNrfaENWdds0bTA6s+cdOHcdtgViwN+xQuxxQxXYtHPD58ta4OrtavTBmuICdvUnf5il5GDN1vtZNbv4k1B0vFEIsYalMgBOpXm8wCOTRxGRPIDOH0W2Lar454JhN4DuB4+SCL0eNT42zj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727353046; c=relaxed/simple;
	bh=bxqIEtDWn+T+6asE2sTMSLX9tiHbJL2z3tCo1iFjeC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W6cwWHoD4T93FdZF9NJqrsPZEBI1zdLHEjjKQstKaleWxktE0b5jEk2LvhUfgEB4mlVD5Ms/0TxNlv5LmD49MX3XncA1zeSWcGGmtTOfTbaz214jc9GLKli1nQuULJbEDHRBdC004CGpFgeYcs4jLMIy8/4HIAoYqRV7TigMlyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LMnPKVgg; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6d6891012d5so8454137b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 05:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727353043; x=1727957843; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oPezUo7IHtau4M8aP14bhxHN2HJlm7hObFAj6Hq/cNU=;
        b=LMnPKVggvq+uHvNZsK94wkoDp5uV3K4FAJZOwjf4hlXCJfckghbE7SAwN2XP+ep/M6
         nru1EdmeFUENPZw+3lmhfavvmKMc4VXjv3rq8zamkTNTI3YTiFjFJvjnzoMSyzBy5pbL
         JRvHovER2mtJPYwWzZp9vjthmREIaprzsHMXjmBbOnbeagBRctah1J74+HftWDT+SD+E
         OzlxpYfbBVcun6Q/+AXBz4DyCMYXE6PSlRUcW8kEFH+H0Plmvef3IVv9TH1kVYddlfSj
         6KnE0wYwOT4Q1UCVp/l0XbzjmheS+3bXOLk2eei7qBh140GUYkJpPQUTIOztzz4106kV
         Oc6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727353043; x=1727957843;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oPezUo7IHtau4M8aP14bhxHN2HJlm7hObFAj6Hq/cNU=;
        b=NtT4fnTmtmuwBDBxwt1FS9OjGG2c8XqTEHm2yoGSbCa61tlql9CW0G02KdOzfrYyP6
         PLWK6rY4vnE3V5JBPgEXpJXxcvvESSrrkZSRuaVRUtuHZEKtqtN5jTXIHWM9vGDl9E4W
         P+InUy+tEWouo7UH3kwnYz59Ui4qQmm1/A0ozzVADK7ZmKjmtX5PwOSPQV5lyF/RXAkL
         WyyDG0f1z+eYsSGmCshSxLzItFazfNchNGxO+XgiaOdcw/Ny/MlGhWxqgAkZv3yGQHR5
         VOshKWEticWXBbK7yTK+BBrQeOjgNcXXfDifKWyGZuPcxzwleaFefLIKi2AOkvG4feN6
         eDFw==
X-Forwarded-Encrypted: i=1; AJvYcCVA0+pJo6hlDzhkgh5Rj+4NTgYqjduRu2bT2OlwfEJqZdyNqM0rIClETGpotPOHm9/nqNmFA+3SxGYMziU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAgtOasq+lmtDN8w8DTyieVfC56mHRWyL5Pi3914Uc03daQCNs
	3PM+NTsU0apa9IkWIWp9I5XGNZwr0Z/AxECksqKWlfXs7UNm/XcW3jqjC7wWlWXDfgegMZ2gf6P
	r9Irmdz5MZxKXqk/3PyIUaq8ovpbUf4YkhBcmoA==
X-Google-Smtp-Source: AGHT+IERFZTphSck/X7sBSRVdUIASeIlELvO6WJqk5lXaPQza+9zNfYdoiFEcn/lLJ7tRwG/6daz91b90kSXoMscyIk=
X-Received: by 2002:a05:690c:ecf:b0:6e2:1626:fc4a with SMTP id
 00721157ae682-6e21d6c605fmr51978797b3.9.1727353043318; Thu, 26 Sep 2024
 05:17:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926074755.22176-1-Hermes.Wu@ite.com.tw> <20240926074755.22176-4-Hermes.Wu@ite.com.tw>
 <acpumgqlyjyt5ql2imnhrv32apdjzluahnx77xpqu2lzltko4q@j6fhqrb7sxai> <2b3d3295278c47b8a79c9ff9b10cc7de@ite.com.tw>
In-Reply-To: <2b3d3295278c47b8a79c9ff9b10cc7de@ite.com.tw>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 26 Sep 2024 14:17:13 +0200
Message-ID: <CAA8EJppErpCagvTQ4TTnBvUbAFci=BvMEmoeOxT1YmPdOPwu-w@mail.gmail.com>
Subject: Re: [PATCH v4 03/11] drm/bridge: it6505: add aux operation for HDCP
 ksv list read
To: Hermes.Wu@ite.com.tw
Cc: Kenneth.Hung@ite.com.tw, andrzej.hajda@intel.com, 
	neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, angelogioacchino.delregno@collabora.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Sept 2024 at 11:46, <Hermes.Wu@ite.com.tw> wrote:
>
> >On Thu, Sep 26, 2024 at 03:47:53PM GMT, Hermes Wu wrote:
> >> From: Hermes Wu <Hermes.wu@ite.com.tw>
> >>
> >> Add aux operaction command which supports read DPCD KSV FIFO with aux
> >> fifo.
> >
> >Nit: AUX, FIFO. Please be consistent in your commit messages.
> >
> >>
> >>
> >> Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
> >
> >Why is this considered to be a fix? From the commit message it sounds like a new feature.
>
> It will be a necessary change for HDCP reads KSV FIFO.

First of all, it should be a part of the commit message, because the
patch itself doesn't fix an issue.
Judging by the amount and the intrusivity of the patches, I'd say that
all KSV / HDCP-related patches constitute a new development, rather
than a bugfix.

>
>
> >
> >LGTM otherwise
> >
> >> Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
> >> ---
> >>  drivers/gpu/drm/bridge/ite-it6505.c | 12 ++++++++----
> >>  1 file changed, 8 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c
> >> b/drivers/gpu/drm/bridge/ite-it6505.c
> >> index b451d3c2ac1d..0583abdca75f 100644
> >> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> >> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> >> @@ -324,6 +324,9 @@ enum aux_cmd_type {
> >>      CMD_AUX_NATIVE_READ = 0x0,
> >>      CMD_AUX_NATIVE_WRITE = 0x5,
> >>      CMD_AUX_I2C_EDID_READ = 0xB,
> >> +
> >> +    /* KSV list read using AUX native read with FIFO */
> >> +    CMD_AUX_GET_KSV_LIST = 0x10,
> >>  };
> >>
> >>  enum aux_cmd_reply {
> >> @@ -965,7 +968,8 @@ static ssize_t it6505_aux_operation(struct it6505 *it6505,
> >>      it6505_set_bits(it6505, REG_AUX_CTRL, AUX_USER_MODE, AUX_USER_MODE);
> >>
> >>  aux_op_start:
> >> -    if (cmd == CMD_AUX_I2C_EDID_READ) {
> >> +    /* HW AUX FIFO supports only EDID and DCPD KSV FIFO aread */
> >> +    if (cmd == CMD_AUX_I2C_EDID_READ || cmd == CMD_AUX_GET_KSV_LIST) {
> >>              /* AUX EDID FIFO has max length of AUX_FIFO_MAX_SIZE bytes. */
> >>              size = min_t(size_t, size, AUX_FIFO_MAX_SIZE);
> >>              /* Enable AUX FIFO read back and clear FIFO */ @@ -1030,7 +1034,7
> >> @@ static ssize_t it6505_aux_operation(struct it6505 *it6505,
> >>              goto aux_op_start;
> >>      }
> >>
> >> -    if (cmd == CMD_AUX_I2C_EDID_READ) {
> >> +    if (cmd == CMD_AUX_I2C_EDID_READ || cmd == CMD_AUX_GET_KSV_LIST) {
> >>              for (i = 0; i < size; i++) {
> >>                      ret = it6505_read(it6505, REG_AUX_DATA_FIFO);
> >>                      if (ret < 0)
> >> @@ -1055,7 +1059,7 @@ static ssize_t it6505_aux_operation(struct it6505 *it6505,
> >>      ret = i;
> >>
> >>  aux_op_err:
> >> -    if (cmd == CMD_AUX_I2C_EDID_READ) {
> >> +    if (cmd == CMD_AUX_I2C_EDID_READ || cmd == CMD_AUX_GET_KSV_LIST) {
> >>              /* clear AUX FIFO */
> >>              it6505_set_bits(it6505, REG_AUX_CTRL,
> >>                              AUX_EN_FIFO_READ | CLR_EDID_FIFO, @@ -1079,7 +1083,7 @@ static
> >> ssize_t it6505_aux_do_transfer(struct it6505 *it6505,
> >>
> >>      mutex_lock(&it6505->aux_lock);
> >>      for (i = 0; i < size; ) {
> >> -            if (cmd == CMD_AUX_I2C_EDID_READ)
> >> +            if (cmd == CMD_AUX_I2C_EDID_READ || cmd == CMD_AUX_GET_KSV_LIST)
> >>                      request_size = min_t(int, (int)size - i, AUX_FIFO_MAX_SIZE);
> >>              else
> >>                      request_size = min_t(int, (int)size - i, 4);
> >> --
> >> 2.34.1
> >>
> >
> >--
> >With best wishes
> >Dmitry
> >
>
> BR,
> Hermes
>


-- 
With best wishes
Dmitry

