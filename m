Return-Path: <linux-kernel+bounces-548516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48945A545FC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95CA3188FA29
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CDB2080F6;
	Thu,  6 Mar 2025 09:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="muKwXhUH"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A9A207DEA
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 09:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741252357; cv=none; b=XyRtPZTm9Wm7f/MiODTpRv4yQGh6QLb3w18rdpPIw+FPTQhfltf5yJpmAdrKLuTBzhOW5nCKyHcV8gbf2X+Fvrla4xSJSPhCB+I2WKrHmnzVpFyVoQ16Iio9MxLQ7fOZbhPIQmKgElq+JT17STmcgedNMMdJqwGG892jUrwarXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741252357; c=relaxed/simple;
	bh=GqmM445nk83WSKAnQchwc4aFd3IVUazkzTOEDmZ6Zms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M7XFwEB6TaQ8AH6x9zY3t3XbbgSAv31gS7tn9TOqna3M1U5KdkMBs4LgMubR6m8zEwdJEySPeE4JJbugq/9b3qPc2If1YNqmDaXaQiWs/sOrFoGloclf/Vj5EdMO0FNk30gLoTRREHmXRSquSVL5Tu3LaJc9hstO3Czu9WykNWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=muKwXhUH; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3061513d353so4322541fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 01:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741252354; x=1741857154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqmM445nk83WSKAnQchwc4aFd3IVUazkzTOEDmZ6Zms=;
        b=muKwXhUHzOOGfyheW/y2AMH2JSDH155PgxsNHIAFFK+1mP/Rcrn7r2y1Bj2QyFc3Fa
         ePoMcQWYCrTMGDtulRTk8BzAeyKinZI0a66Cq4woa0BW+JIZw4tDEQlQUxzKCRHrwyLG
         I0iQenQwxl6Ly8Bf9PK3nXHCpkZSdnb4RArmcmQsM6e90yjFkuzHspWiMfzcffmiOitY
         jrbeyXyTlq+1SEl2E8B6ELOgshiSy4wWA0vMM8PxI4is4DpNs+LFdWbSkJGxzluyTYRA
         LP005WtIz3ILy0yvdgg6nQjywUk+eTh30EwP11pY6SYMXER0L0hsfOfP/3Ln06BrHISD
         T6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741252354; x=1741857154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GqmM445nk83WSKAnQchwc4aFd3IVUazkzTOEDmZ6Zms=;
        b=B/yzMUK5pnWUJejgvFlJoMfAyA292RLj6lHzd3BbwPoQAFjq1K69B9MzI3tTawQCad
         vIi4r00ujfMuDv9UnhDZX6QGXQSb/vYVl+fUaqrS82aUjeLjVrFsW3OUUhZIiLZq0tz5
         U44LoTr4axVoUtCcCZJxvXkBE8L14d8cvESclaALZhhNfVhmHf03nV8Qy/8CQpLeKgTL
         kOcieaeZW5pgJZ+bW4qWOOALfyYCaLkP6/RYljmWMpemshfisEe8iW7voYuWchDgZGwB
         Oh2woGY3tYl9Um/+O151MBymbxyOHLkFlpTkD0sdYkfHfEvSENWltlOcjxroF2xjyM0q
         y8EA==
X-Forwarded-Encrypted: i=1; AJvYcCVtoQhNi+wVIKrpl4UVB1bJUCS4qs85cwLXc30K0Xxml9FCwIk0oAhAEQNhaTtd5vuglVL3UZ1s6fqEfN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA2Re00iLOqAtPl8R3PKnt/nMUmCl5DHfdaYWiVqA4e+Aq/YxG
	H5gwqDR2BkThCMwP56b5bNffi4zqg1FkrKPKk3nFot8wA8vLtLUs/vqyW97H3VNf2QUUiiCxyc+
	i3XkdIOB6H3QGnMoU1GLOG2wJMSLssD9wB0Luhg==
X-Gm-Gg: ASbGncsRZm6wv8UKIiqsB7WdO2xyQsd+gy/f/ClH4k/PgL/M9cH1r9hmPrztjimOXdG
	Wa2XPTkmYAnui578MTVwKbJ16ROfuQ+JYJxd/fetHoRIChuHM2C3Rn+RmaLJhuNudjd60fWGUxg
	4HLZeRu6/A+l1e2JBkpqt+xZw3Jg==
X-Google-Smtp-Source: AGHT+IHJbjr7n6MNFdoyJ5OcRjeliVrB+L/QnglEfbXH7bLR2SWadB2qjeLyT4uRMCDJc2UAADFOOmMVPfRkheSpHCU=
X-Received: by 2002:a2e:b8c9:0:b0:308:efa4:d277 with SMTP id
 38308e7fff4ca-30bd7a507f6mr21783241fa.15.1741252353675; Thu, 06 Mar 2025
 01:12:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305221659.1153495-1-alexandre.belloni@bootlin.com>
In-Reply-To: <20250305221659.1153495-1-alexandre.belloni@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 6 Mar 2025 10:12:22 +0100
X-Gm-Features: AQ5f1JqQwmuBLuVbVlZaXchGO6-cZ55N78DkfVd4KCTXsG2vg1w72ORT3ZwrFbs
Message-ID: <CACRpkdZKbEXEabB+4uYvbBRXfFR_Jk-hHVtrZYD+cpKXgcMsnA@mail.gmail.com>
Subject: Re: [PATCH] rtc: pl031: document struct pl031_vendor_data members
To: alexandre.belloni@bootlin.com
Cc: kernel test robot <lkp@intel.com>, linux-arm-kernel@lists.infradead.org, 
	linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 11:17=E2=80=AFPM <alexandre.belloni@bootlin.com> wro=
te:

> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
>
> Document the range related members of struct pl031_vendor_data.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202503011015.SYvdddTc-lkp@i=
ntel.com/
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

