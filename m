Return-Path: <linux-kernel+bounces-315318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B78196C100
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32F6F1F26BB6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FD41DC181;
	Wed,  4 Sep 2024 14:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jFKQFGBr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260501DC05E
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 14:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725461033; cv=none; b=pAVWQVcGURhrotTwj+AtgRpQhItA2hAr9N2SQOrppUNtEhvSW+5lPeDAJfMY8pA2yN0nrcA8yINXXz9jr/m6PnDz/LXJCl3RjWo1b3tbH2NQicrC9gp8ak/t30M+jHLFw24+99CbqtcytiYrSE3adooly3yTqwS6NJW4oWMk4qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725461033; c=relaxed/simple;
	bh=iKqWCvQaTNzfamaO6Kv/yW7GdXAB81lqclGxtEdqyLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dTXziHgYmhH8DpoiAFWtJKwh/bwjF7PY44s7UcQFmxGTMHKDtqn2AuxbR7gmRAxYEOKxhTfGVIflfa12Y7eWhoiIuix/35iUCAd2OEMr+lR9EqVlb1+p6hsxsLVOL9Kb7VBxoFE489XXo90RHLjJkjQugJLso5oaeQE4S2Fn18I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jFKQFGBr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725461029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iKqWCvQaTNzfamaO6Kv/yW7GdXAB81lqclGxtEdqyLo=;
	b=jFKQFGBr0Ptw39hoNkmi4kExyaGiQM14j6bd+pk99W10adyprwEyy3JkSoPeRwriQKz6T/
	Z6AjV9WzNIUybl24Xyv9MZ77ue/qraSSRuJKatkqnOWxkTlSAsUhw+AXBNszeYADxBAqpR
	T97TQxPILKbOXyFUpYZA7lpIO3rdGIo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-jbSezcxqNgmoSyIMNjwOsQ-1; Wed, 04 Sep 2024 10:43:48 -0400
X-MC-Unique: jbSezcxqNgmoSyIMNjwOsQ-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5c24e546f3fso3219708a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 07:43:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725461027; x=1726065827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iKqWCvQaTNzfamaO6Kv/yW7GdXAB81lqclGxtEdqyLo=;
        b=Qy2IqVFJy+1qJLwPaVbmehRwxXVxrManqgLcShFLT1O4oLyy/chijaHA4/PxGKpljD
         reydrLIHtfxU7ma6N/CKeEmua6ss7/VS1VF+q6yS+Vuu+ddUnraWWu57r96yFf1mEG65
         bYi8w6przjmdGXNBHyXx8v/NZb4PsRbc5fb5aKTVihbzKTmXVfyOKNHFA/Exxat0CDnS
         qZZrlwcrBdlf60SFF8fHJoTjneQP7amrAOLD0g1C36PCEUeoYRq6FX90I2BfygYLAXrZ
         4/ZiIv+SJWW2yXx824OcgNjWQcQEMPN4bnWPEO/NuRvbdNcQX8bqGcTmMJIbHoD2AWdh
         1xxQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3KD5mVPByvSvjyzAYdW/21OFYWp8JWJLjeHAaOVT3E1EF6M+vWk/5Q7uWMSpOz8CUEfmv3LmYBf9nTbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN/AcguptexdB7YgErCZ/bOikaWoZRbl88MxNzVi8CQkyQbXdC
	byfoC+ENTI1iLJrUsAVXtRA7qVZW5/3kAB9JDIbhuYZKzJNBIejTnxyZHw0PywkwJd/ZtI+URiD
	4qyXzeFPNM7YbapK+W4Nanv/yK43nJ/w1toIjFGyCAIUtKOJiYvcUaEavwk3ZbCM73s8pIBLLjK
	vyV9YWvUxPZIIJIrqH/EC3UES1E2KtrSJHPWGG
X-Received: by 2002:a17:906:c10c:b0:a7a:a46e:dc3c with SMTP id a640c23a62f3a-a89b94a9cd9mr1022117466b.15.1725461026906;
        Wed, 04 Sep 2024 07:43:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFo5JYtqte+s3eAerfKy35rLUJR8ZL908LjB1GKu3jHSIElZjWXpFnbsGyYvHG9OxwhFiGpzYAtdwVG44/vrLg=
X-Received: by 2002:a17:906:c10c:b0:a7a:a46e:dc3c with SMTP id
 a640c23a62f3a-a89b94a9cd9mr1022114266b.15.1725461026259; Wed, 04 Sep 2024
 07:43:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903212230.707376-1-bmasney@redhat.com> <20240903212230.707376-2-bmasney@redhat.com>
In-Reply-To: <20240903212230.707376-2-bmasney@redhat.com>
From: Brian Masney <bmasney@redhat.com>
Date: Wed, 4 Sep 2024 10:43:34 -0400
Message-ID: <CABx5tqLh_8OMSrZsCFz3wpw4dQf6pQtQ_Ffh35Abop2fqhobTg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] crypto: qcom-rng: fix support for ACPI-based systems
To: herbert@gondor.apana.org.au
Cc: davem@davemloft.net, quic_omprsing@quicinc.com, neil.armstrong@linaro.org, 
	quic_bjorande@quicinc.com, linux-arm-msm@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ernesto.mnd.fernandez@gmail.com, quic_jhugo@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 5:22=E2=80=AFPM Brian Masney <bmasney@redhat.com> wr=
ote:
> The qcom-rng driver supports both ACPI and device tree based systems.
> ACPI support was broken when the hw_random interface support was added.
> Let's go ahead and fix this by adding a check for has_acpi_companion().
>
> This fix was boot tested on a Qualcomm Amberwing server.
>
> Fixes: f29cd5bb64c2 ("crypto: qcom-rng - Add hw_random interface support"=
)
> Reported-by: Ernesto A. Fern=C3=A1ndez <ernesto.mnd.fernandez@gmail.com>
> Closes: https://lore.kernel.org/linux-arm-msm/20240828184019.GA21181@eaf/
> Cc: stable@vger.kernel.org
> Signed-off-by: Brian Masney <bmasney@redhat.com>

I found a cleaner and less intrusive way to fix this after looking
through some other drivers, so let me post a v3. Sorry about the
noise.

Brian


