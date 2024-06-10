Return-Path: <linux-kernel+bounces-209071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8265D902C9F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 01:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B960CB2227A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 23:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5274915278A;
	Mon, 10 Jun 2024 23:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WmVwVdni"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8A415250D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 23:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718063553; cv=none; b=plwI/V3TdZCTdvVzDdqWMFyV6A4pz8w/6lpWyfeh97ZETwYPhxLKiQJktj+N5WLnFaN3I37enO6g1ewjZ8KMLgkCUP3ZI/PiZc6QmPohoKL4K6OznXGI0my7h7ENef4ekiBNoWO3PoCWC8HO9QUuS6JFzS2VwVZis5IYkTrr2eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718063553; c=relaxed/simple;
	bh=yhoEmJg27/Tq8Hg3TZJQhkLMO/opRq6IHsJgd01KjZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qlv1WEPkySDg6iFXFZRv2wjqIH6yXOt+crS88oaIV2b7xwmbvwIa/ZbyT7C74DebwmXB76UL5qpjnJn0kn9G+4hlE7NXWvTyxF9t9PBvzSNsKR8tqERMVW9GfqSDn5UHCP9PUG8842PV1e30Rm+Czh/63ZdQ8t5JMJ7C9SryDeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WmVwVdni; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-797a7f9b52eso59138785a.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718063549; x=1718668349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yI7oeA4ugo7i1lcCgMOoLmqHrdLmEsXBFh/0GoJ3ACI=;
        b=WmVwVdnipZpHlvS7riXFMqBE6Do2jNis2xcyFz+ruKmYrUhpbha0UW+alxhvxLE+o4
         jircyJS0iN9SBtxld55r3L1N0cyjOweNb01Ipj6H4kxMglh3wzVHrDxw3A/w+9ZRTf9k
         2GpGXlVXq9cq/of1jFmW4i7rk69dz0+4GmtQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718063549; x=1718668349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yI7oeA4ugo7i1lcCgMOoLmqHrdLmEsXBFh/0GoJ3ACI=;
        b=nufGwRvtuq25qa2W7N7ECTjAhN0XmDzyrc7y0WmD96UmM56G6Me7cnxgG2YcU2pDdk
         oNswNT9cG5f5jXD+KLbwS4dlet2A2PXIAxhV/uLT8/puH1418FSd6A1Mz75V6+Dp8qsK
         DEI7xiAjSO3DRiog2RL5CqrMuDAmFA5xeH46Ic1s2POV5BPW8aS166TaXeSvaP3LZwmz
         rIdLWgzhkQBWJV3rK3FplKUTHwAI/+73tZbHhzaR8Fauydc/UbZCYaD0cO9f8oyWTnnU
         1IPBj38tiEhqMnDrfzKg98KrVOIu+J68t3gnSQcCDDl2IjAHWhetWHwXmpxKcb+T66z6
         f5sg==
X-Forwarded-Encrypted: i=1; AJvYcCVOIm7m0yLh9hJDKzvTLmoFwdhyrpWnI4+VVl6KSpY0E21WGQA4VOq0bqB2ySCi0h/93gGj9Dtmc/oO1BdYAsLdgYXhEprNkKi6nngP
X-Gm-Message-State: AOJu0Yy2qtZDaSkLJnLTCoulh5gTv12Havjvi8KZfNXj/0akpHefb+Fc
	wTbHe+ztrKwFysikMspIDSaNJ3rEg/Ur2uYilOwtuIlXQoiWjF7yb3tiY3Fv6Z9DyjvNNYKmwWY
	=
X-Google-Smtp-Source: AGHT+IHxVv0x1UMOvwTKijUlRoxRJxmPR0tmkcqEdOm2Potej0OQJ6GQoeT+MkfvMnnr7a+Ei9rkiQ==
X-Received: by 2002:a05:6214:5681:b0:6b0:73c1:bcd3 with SMTP id 6a1803df08f44-6b073c1be45mr80548606d6.4.1718063548633;
        Mon, 10 Jun 2024 16:52:28 -0700 (PDT)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com. [209.85.160.172])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b06ae2266bsm30391896d6.3.2024.06.10.16.52.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 16:52:28 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-44056f72257so140781cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:52:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXVBJaai3NOIdae+t14TL6jXjPVLa85i1a+/chXYwpGZ4T85aWp56nhWtGunYyHUy3qMEAGiqnLhssre9lpHbZKFzmAOX14F5MjaFno
X-Received: by 2002:a05:622a:5b09:b0:441:4920:1fc4 with SMTP id
 d75a77b69052e-44149202169mr577491cf.28.1718063547155; Mon, 10 Jun 2024
 16:52:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517170246.1.Ia769fe5fbeaa6aca2edfb01b82eb7df0c6955459@changeid>
In-Reply-To: <20240517170246.1.Ia769fe5fbeaa6aca2edfb01b82eb7df0c6955459@changeid>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 10 Jun 2024 16:52:10 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wd4UdjGdFODGCa4acviQG2V_YuM9J8oxi8A--ZmseNUA@mail.gmail.com>
Message-ID: <CAD=FV=Wd4UdjGdFODGCa4acviQG2V_YuM9J8oxi8A--ZmseNUA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: If memdump doesn't work, re-enable IBS
To: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Stephen Boyd <swboyd@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
	Johan Hovold <johan+linaro@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Sai Teja Aluvala <quic_saluvala@quicinc.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 17, 2024 at 5:03=E2=80=AFPM Douglas Anderson <dianders@chromium=
.org> wrote:
>
> On systems in the field, we are seeing this sometimes in the kernel logs:
>   Bluetooth: qca_controller_memdump() hci0: hci_devcd_init Return:-95
>
> This means that _something_ decided that it wanted to get a memdump
> but then hci_devcd_init() returned -EOPNOTSUPP (AKA -95).
>
> The cleanup code in qca_controller_memdump() when we get back an error
> from hci_devcd_init() undoes most things but forgets to clear
> QCA_IBS_DISABLED. One side effect of this is that, during the next
> suspend, qca_suspend() will always get a timeout.
>
> Let's fix it so that we clear the bit.
>
> Fixes: 06d3fdfcdf5c ("Bluetooth: hci_qca: Add qcom devcoredump support")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> I'm nowhere near an expert on this code so please give extra eyes on
> this patch. I also have no idea how to reproduce the problem nor even
> how to trigger a memdump to test it. I'd love any advice that folks
> could give. ;-)
>
>  drivers/bluetooth/hci_qca.c | 1 +
>  1 file changed, 1 insertion(+)

Totally fine if you just need more time, but I wanted to follow up and
check to see if there is anything you need me to do to help move this
patch forward. If not, I'll snooze this patch and check up on it again
sometime around the end of July.


Thanks!

-Doug

