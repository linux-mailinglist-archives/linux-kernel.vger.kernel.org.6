Return-Path: <linux-kernel+bounces-423709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 796C49DABC2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 17:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29A8F166ADC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 16:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5304200B9C;
	Wed, 27 Nov 2024 16:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PjAcdS7C"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A221FE45B
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 16:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732724835; cv=none; b=Z8VcU+GkddD5C+agq5WVG37QfD4pGt6N27ZB4fISnaoyIY1Y86txC5UIceFca1Dh9s17kfuxUU3RMr2FsQV7yO58oUkak+pvtYMDfGKMNsHal4bwAHyve1lk9cdNge42BKEF2yMrJPDjHrxJTKbgiZnXOSnKdG7HeJvFu2Xbp6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732724835; c=relaxed/simple;
	bh=mOKMr2rmARyVxmtacbasnCb3Rp24G0x2C/kgLo5QtYQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fEqJMKjamKku/lRUyB3LmuX7829g2Crl5yEKF5tBHeCKs9AjTVvP8n77F4kY3As87ATOlc4VeJ3fTwOOvvhVkLDUhQ1tNDId0q3ckdC6csp802RmfBZAs+P28hNNqzY3wjbErszBzt3zhEDPXC2mJtb+nt9aCfPEkbfHE+ylPzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PjAcdS7C; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4349fb56260so29686215e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 08:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732724831; x=1733329631; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mOKMr2rmARyVxmtacbasnCb3Rp24G0x2C/kgLo5QtYQ=;
        b=PjAcdS7C7NuSfXE/iwem1j770tASQvdfBcXVXqdbEZsRrj84yX1/70KP5ofldrowCe
         ZpLnvOQUFxQlWBlGQ+kShhuv+F3kHDlSvDb77nFbjDNyxVodq5z95xzir3oEeEqxcMaO
         8z/oMk9vaasXfHSelCn7Gmnzio4B5fsBvs3qTZ0Q55j939Z1RxTIDVbhq0//A/GNC2KM
         CUL5A37+VQm3As+VgDmhj1yI/0SG+djhaqe0hz77f0i6d18XuU5wOfw7Konr1juxOTwK
         gQ81CfvZpCbuaIZcvBUnYXq+mwE8UeU+7YQsvlOSXsejECK6GR5OEi9/qrkeRqbFhhJB
         JAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732724831; x=1733329631;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mOKMr2rmARyVxmtacbasnCb3Rp24G0x2C/kgLo5QtYQ=;
        b=OloanRmf84+ZNojr88gWvBfdggiovfCQMvB36nV8GLsF2gi78HCNj9RbZEDFkkAzhZ
         EaJzeM9KO1N4SmXCu9pVHIt26/ZMOKBjNLKZ+46PlXyJ736MGDNdwCFDSpVnluT7zxFo
         YVUE8eO98nnUVwPLb8Cx3h4GIJgk5pH7HltKLlOxF9PU/Hg0Brniy7Mio/WvSIDGC/pZ
         5MYLFpXzyy52UOLbDcHPjSfajmT+HWNJtEgsFwNZlXjuH8bc5+ugg6cbs8A3DRQz25XI
         CuZUVyoFO4McB8Hwm77doIJoKfWZtMro6LqCccgRkYN6fRRYaN8zYXmnNmmbsAaxa0Ww
         Mc6A==
X-Forwarded-Encrypted: i=1; AJvYcCWRRw478HeTIp70pUVQHfZEEV5F7YqArNzfqAvE4T5LgqYdO1kBaSjYKapfAvWLEwJJahubkiKnWKXSQuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxknFqUQA7fZBKtA6XFaZk6zdtWQviGlEiqm1pbtsoRwXCpPmwm
	uj7WsvZkSWViSoe8z7pAx4hLL1iLOt2233TGYa1Sh3tdHAP6Iv+1I+e1ZbbkYMA=
X-Gm-Gg: ASbGncswZbJh6d/DJFcHqZgXvnLOIafg4vkh7pPZi9all4coICIIxL5A+q017yQJLw8
	213yjHq90p4ngIjgBlHEsjNZbU8/Wen1g3v5ZG4U3QMcoszrsCv/3s+CrHKtU7pzfPJMSWOUptB
	5Z1ce4JBNQPsloC/VkjyRgJJrOvBDJ+nTV0SuLvRSOcUNDRo9GYjrZ2wRbjhP/OSCKTNoCdNGnV
	MNDuLQsrD0qjA3KTZjCNFO7MnXf+TmpDBQ6uy27K616D1pbz2RCrw==
X-Google-Smtp-Source: AGHT+IHUXF8Dlt2R0M0tUhRjJZfzXWTd2QVl3Kj7qIQfuLN+iAXj3NQBYlBwZKmabbvWQBuy4HyzAQ==
X-Received: by 2002:a05:600c:474c:b0:431:5aea:95f with SMTP id 5b1f17b1804b1-434a9dc824dmr37930625e9.16.1732724830938;
        Wed, 27 Nov 2024 08:27:10 -0800 (PST)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa74efbesm25624895e9.7.2024.11.27.08.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 08:27:10 -0800 (PST)
Message-ID: <fba9c9df33dc2e060238a9bb3466a2fea020efde.camel@linaro.org>
Subject: Re: [PATCH 2/9] dt-bindings: phy: samsung,usb3-drd-phy: add
 optional orientation-switch
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Conor Dooley <conor@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>,  Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,  Marek Szyprowski
 <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Alim Akhtar <alim.akhtar@samsung.com>, Peter Griffin
 <peter.griffin@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, Sam
 Protsenko <semen.protsenko@linaro.org>, Will McVicker
 <willmcvicker@google.com>, Roy Luo <royluo@google.com>,
 kernel-team@android.com,  linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,  linux-samsung-soc@vger.kernel.org
Date: Wed, 27 Nov 2024 16:27:09 +0000
In-Reply-To: <20241127-pushing-baboon-4afafcf8322f@spud>
References: 
	<20241127-gs101-phy-lanes-orientation-phy-v1-0-1b7fce24960b@linaro.org>
	 <20241127-gs101-phy-lanes-orientation-phy-v1-2-1b7fce24960b@linaro.org>
	 <20241127-unturned-powdered-d9d1b695732d@spud>
	 <20241127-pushing-baboon-4afafcf8322f@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1-4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Conor,

Thanks for your review.

On Wed, 2024-11-27 at 16:02 +0000, Conor Dooley wrote:
> On Wed, Nov 27, 2024 at 04:00:59PM +0000, Conor Dooley wrote:
> > On Wed, Nov 27, 2024 at 10:58:12AM +0000, Andr=C3=A9 Draszik wrote:
> > > orientation-switch is the standard declaration to inform the Type-C
> > > mux
> > > layer that a remote-endpoint is capable of processing orientation
> > > change messages.
> > >=20
> > > Add as an optional since not all versions of this phy currently
> > > support
> > > or even need the orientation-switch.
> > >=20
> > > Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> >=20
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
>=20
> Actually, this patch unconditionally adds the property to the binding.
> Is it valid for !gs101?

Good point. I've only made it required for gs101 in the next patch, but as-
is, somebody could still add it (in error) in !gs101 cases.

I guess it's best to squash patches 3 and 4 in that case, and update it to
disallow for !gs101.

Thanks,
Andre'


