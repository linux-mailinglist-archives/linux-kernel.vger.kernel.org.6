Return-Path: <linux-kernel+bounces-341334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 131B0987E7F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 08:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CB951F2379A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 06:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20232176FB6;
	Fri, 27 Sep 2024 06:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Ir6dw+iR"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D253E173336
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 06:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727419016; cv=none; b=sRJnT8kYJxRQgEQ3rstEuWxLzfDwtyxqfPs6qHFF2iR38U+8jOrVTd0vl2fleNx+IluVid/x5Qt0oiAn7S6vvVC8BkK/t+57mVuFnd5+nLco+YGIG5SsvIx20slPEqAW4BYsdWF8zUap3zdEMflpQjjqBNJTk3s3XarfDbKrK20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727419016; c=relaxed/simple;
	bh=vXRBt6+WPBCXEvFEojsG0JdYGPjOPLdAL5vKh0gVANs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gQXIQjz/aVq3mKBjvuPTuyef8Izqz/awlrtOhs6BSvoVzbBoafZqfwXPFBNdmKIevxGgkUo7MntzvcrMSlBYhfG4k8KshjvpH/J750s1H5kllDgRAVjOqoPwszh67N5+iNOZEEdawofckNeEkeQlaM1GWRsrBmwscfldzFwl058=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Ir6dw+iR; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f75d044201so17899121fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 23:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1727419013; x=1728023813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXRBt6+WPBCXEvFEojsG0JdYGPjOPLdAL5vKh0gVANs=;
        b=Ir6dw+iR6CtrY6N8rAQP/9siA6b/w1RYmRMxMXL4xVzlD7DrRTWG1Min89TymutdOA
         L6/OVskjjBlGWqLfBTKh/bqG9fl7TWu13pdj2VzMvUz9Cox2Hz9QWhuoph+uEt4YXpYl
         r3JHwnYtcDWyjHDybSgkhLF7o7J3ypmO5Xss3tZQGNcFzSKQvUIUvVpgEY7stIWA/x0Q
         t7RwOj1yOKShQKHTrNxFZNqYNXJAcVoZlM5428n1oM3kvpe7toPSBoCPhb6+p7j0BulC
         x5cDedVRIj8JDeFVnRYSUtxWA0jYVkEHWLyutR0WulhnasM4B0DOUikS8mxSs7BuyW7o
         dMCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727419013; x=1728023813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vXRBt6+WPBCXEvFEojsG0JdYGPjOPLdAL5vKh0gVANs=;
        b=qfgQ9N8PIFhWgafSB2HMfknZ5ZaVv8GrqGuMShxbXzu3ggywA8nFNKHEaIGKhDQQ/7
         b0byPDr+SWMFbrR9EidUblQwp3kLpNl2h2STnj48HLDw6Y15TpXJHiyoo4eLTcm16C54
         gKqtzHa7jdrW14PvYjSL0ZJh6AOWiSAFPxZQiyrg9STs7DKBKcuPLti8X9IuhQkKHnG3
         pvB8EnDIwHW3yNgApypKxnnzCynu10zw3FPAj8UJnyrSsrD7jDVr8Yg/n7X3FKSeFs20
         7BKrAyhfhy/+mfZxGsC7t6I3tkH2vyTrVxNkgZziKcStUBql6a3XbeXVtLjmhOqpmr5x
         D43Q==
X-Forwarded-Encrypted: i=1; AJvYcCU7JQEGfnf/9KZofjKa0FEhvCTwh/9tABrTM8G6Gon6RNwn4x1hcB46U53uttLZTMKSsJVeGO6L2AKHeD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGOyk6zDXeNXJBPshAqyecH3mjZu/+NuCF7ei0r29uK93l0wNf
	Jjw1mZhyqAzBu9TXy2oto+4USJlwbUbKa2ziH6qyQHN+OM0NqfKAWhT+i3DgN9vTA0P2KQboXSZ
	ptVQXGYBYVEG/6zNQK/A+95SWZaLDHeycLSDfiQ==
X-Google-Smtp-Source: AGHT+IGgFYfXHCal2e51gzgszcfItBm9C194Qyz5q41DI00iOJq9PeBaLsT1ymvZJa7VwGDM3d1wVm/E+xtj8hsF0w8=
X-Received: by 2002:a2e:84a:0:b0:2f4:3de7:ac48 with SMTP id
 38308e7fff4ca-2f9d33928c1mr6048771fa.19.1727419012116; Thu, 26 Sep 2024
 23:36:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927-leds_device_for_each_child_node_scoped-v1-0-95c0614b38c8@gmail.com>
 <20240927-leds_device_for_each_child_node_scoped-v1-11-95c0614b38c8@gmail.com>
In-Reply-To: <20240927-leds_device_for_each_child_node_scoped-v1-11-95c0614b38c8@gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 27 Sep 2024 08:36:40 +0200
Message-ID: <CAMRc=MeXxeXq4m4nvb+P2ZQuYbQ18n4572cwkkHG+=U7nfa7Vw@mail.gmail.com>
Subject: Re: [PATCH 11/18] leds: max77650: switch to device_for_each_child_node_scoped()
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Gene Chen <gene_chen@richtek.com>, 
	Jacek Anaszewski <jacek.anaszewski@gmail.com>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-leds@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 1:21=E2=80=AFAM Javier Carrasco
<javier.carrasco.cruz@gmail.com> wrote:
>
> Switch to device_for_each_child_node_scoped() to simplify the code by
> removing the need for calls to fwnode_handle_put() in the error paths.
>
> This also prevents possible memory leaks if new error paths are added
> without the required call to fwnode_handle_put().
>
> After switching to the scoped variant, there is no longer need for a
> jump to 'err_node_out', as an immediate return is possible.
>
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

