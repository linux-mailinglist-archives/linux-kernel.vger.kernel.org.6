Return-Path: <linux-kernel+bounces-169352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB7F8BC77A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 08:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31FCA281457
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 06:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8598E4C62E;
	Mon,  6 May 2024 06:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xkB7YHqq"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CE619479
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 06:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714976514; cv=none; b=MvR0KcRoOUxioh5G1vvm6LCr8guxp+87iwUnIX0YGZAm3NNZRzrCy08zZ907mBgAtMEalTHG1hLZmt6VbANOCusc/oEfb3uDqBMOA5Rjt0x2EcD7EbIAnd/uNNPC13gFKPn11CWefmQHOmPeh8iI5l57zxG7HpxlUSNXDHxcd2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714976514; c=relaxed/simple;
	bh=5tenC0j8T9uI7/6pvgOmP23FOqeIIoMHzohX2q3IKgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sov05YRmwctAbttk2uNRjrXLDCgWDLWCa5Ei5MPyLc0Rz/E0PPQagyabDvvM9rNu/v9MkuNRddPabEmfb+DUgqftIHtBPRvCZrZHkKcS5XdwTkzQQWGccixahm2e0buS1NNAraMPROpNObsLhQ3XIqhrIVrCMyemlHJoN8gYn2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xkB7YHqq; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-61be674f5d1so16927007b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2024 23:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714976512; x=1715581312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5tenC0j8T9uI7/6pvgOmP23FOqeIIoMHzohX2q3IKgg=;
        b=xkB7YHqqxSrqDz9Xk/U6MYAWYUjEvmTe+RU7eXeIKDEl+u7qmctqQOPK9WWpqlgmy6
         6lgGNue8lcSB0TTxrZVRemsZzBqzFMNGRE/1+FYWU+sI3xjG3JP5fjqdRFX7krcvguHF
         HRmVzpBT4DESClR/ubjMj9PjsvV87f1l2B173h+RcJ1zCk74U5Dbh5TJr7sJYfz4vdXA
         6HR/W3eccT7PCNffml++g7sQkx154Zd0nKLBVV2IQa/yNBWH2qxR4iW9drkRMLE4lOwn
         8vk1WkgdDlmIoXp7ii7purSqgNSFUx2VWN5XAFhY0dDkQk/xaizB+xnwbDM/90ZEwTI6
         Ur/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714976512; x=1715581312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5tenC0j8T9uI7/6pvgOmP23FOqeIIoMHzohX2q3IKgg=;
        b=pbPtpzEMt7Bj1m3Erpw19cLNU4E3eX7A4wF9GOH/jFcoeeHduWBz52ed3gXA3cEkUv
         /agnn0U2epe9gY/knvCNwjinkeSdARAI7RkyknY+DKy7iVia5bOiHM+FBWWasMSsJAeK
         NQnZmHjyZYBnY99y3tZw5L7odIwoLYX384L9ATpBZglmQxOmk7cijjWOqqy9nKtOLCEW
         lGk4ZY1dAF465f3bAvNXI23WujUVcgvV2zkltfPn+NCoeIzZz7I1lMTfbNQLAjWa6mj6
         ZpjWoBjOFtoH64+i9etMJ5qSnDLiiJIx+2gNNwPUfeeO9fKZq+cXELI3/NGHdh0U2UAn
         jdYw==
X-Forwarded-Encrypted: i=1; AJvYcCVO970+vh3voBerhX17iDBzkSK05Rmsk+0z/cnXhK8e/oKwVnievbnjRtK6S6vh2as2mXGRnIGTr6nMFA/ybREIQT+IJL3KUbZ7hANQ
X-Gm-Message-State: AOJu0YzoCXPNDbo8tpuEGCOp3qDZs8UpG05t4IOsghy+43t7+VWUJU95
	t3v7JRJNDbtw4xaWui0MBkNDejq8C90ehAEkJoFlCy+/JBphu+Kw8Ry1n7TE2rhJS/5aKWtgV8l
	gFUUfhjB9zBnD9Sey/meHezLjenlWp5bof8E1Gw==
X-Google-Smtp-Source: AGHT+IEZYgOJxpOS8RgvqSwa7T9Vce5FOiyRslGmfTswPvAflgTZwuTElXfafN0eRcsZ5PsUlWzd+xot5zeuqDcAm8Y=
X-Received: by 2002:a0d:f944:0:b0:61a:ca09:dae3 with SMTP id
 j65-20020a0df944000000b0061aca09dae3mr10983765ywf.26.1714976512254; Sun, 05
 May 2024 23:21:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426235857.3870424-1-dianders@chromium.org>
 <20240426165839.v2.4.Ie94246c30fe95101e0e26dd5f96e976dbeb8f242@changeid>
 <2af446d3-7834-4a6b-897b-b14c6bccff65@linaro.org> <CAD=FV=V=EvEGp4tGDd-UQ1R=XkAwDn04ftd8oWU=UE=3Gi7SLQ@mail.gmail.com>
In-Reply-To: <CAD=FV=V=EvEGp4tGDd-UQ1R=XkAwDn04ftd8oWU=UE=3Gi7SLQ@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 6 May 2024 08:21:41 +0200
Message-ID: <CACRpkdYn+jpGWDcWDUL5yj-pG_oBMLpFO-QhX6Sa-XzJNmhZjQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] drm/mipi-dsi: Introduce mipi_dsi_*_write_seq_multi()
To: Doug Anderson <dianders@chromium.org>
Cc: neil.armstrong@linaro.org, dri-devel@lists.freedesktop.org, 
	lvzhaoxiong@huaqin.corp-partner.google.com, 
	Jani Nikula <jani.nikula@linux.intel.com>, Hsin-Yi Wang <hsinyi@google.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, Joel Selvaraj <jo@jsfamily.in>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 4:26=E2=80=AFPM Doug Anderson <dianders@chromium.or=
g> wrote:

> So I guess I'd say that I ended up being pretty happy with the
> "context" even if it does feel a little over engineered and I'd argue
> to keep it that way. That being said, if you feel strongly about it
> then we can perhaps get others to chime in to see which style they
> prefer? Let me know what you think.

I'm in favor of this design.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

