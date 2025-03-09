Return-Path: <linux-kernel+bounces-553060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8DAA582ED
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 11:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EC57188E337
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 10:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A641B395F;
	Sun,  9 Mar 2025 10:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x4JTJYVM"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE56A18FC67
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 10:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741515155; cv=none; b=jNNAmbkGzqxSVlfUW1ub0Kozui4U2Su90By5zLrZvn1DK5zdHklS70uvzdxn6F0suKx3HoJ/3G6sjvGGtAY6/w9nIRHeiLQYHAc7REf5hxulJ4IDmaK9RsZirZae7zodZZg2cPRdEf+TWqLr2pB0gSHT33b3znQY7tKfY/g6O6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741515155; c=relaxed/simple;
	bh=mIlz259ufduUWTat8fdPuZvMVVJ3vEs1MSK1lt0IzqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ByE6owUjDFMZRaiqUCQeyrvNsz3jpQZziJozFtYoRIwt0PRxBCp9kvrKlm4ZXQQuYzdDZyuw6FvW4uU+IjohnI5nYsl5Scz+qQZGJhUe1isqKdC11bH1xOQjWIhYHGeJFYcsAO1p/p0XzuSzIlbBGDSl5gDyfPI6I5SRVoO+FOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x4JTJYVM; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e6343c68b8fso2386673276.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 03:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741515152; x=1742119952; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a3pmPX9mi3l6MtSftgTcp61DrI1vlvr8C0D0WUCrKDw=;
        b=x4JTJYVMU41PezGuwiOqQ2ONBIfUQExvIyL20IiUIERR5gfa7UV7lz2xOn+JU6FQkS
         1eEBOINa7fXU/h2HDrXug4CdugPptgnIGjkOTN5Ro56XFEkQfc1KyrJSfCqLAGq/24aj
         MAKOYdvJo8jMIvCV6zrbZ0BKA5bqhECS8+cHJhGdxGuQKGBx8EAlTXnTC3IaANtoMOqR
         hIQzDbB/H14v/0jdDAVFjgdz7BkKGzKEcoSAs8XSgUv4PwfwMk+EKZMI0GwI/6c8hn+r
         kOMnUuMNgBuZQiVRFBA8jk0nh9886lD7qvFUV1+mj8f6OzcG1//sbOy6nTPJMjF9j01O
         HRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741515152; x=1742119952;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a3pmPX9mi3l6MtSftgTcp61DrI1vlvr8C0D0WUCrKDw=;
        b=Lc88uteC7qrQ4C+se23opq3bhG3FgWvYqFAR0ncoFgPoFhGVcEh5Denk888dtSUJp4
         Ldjf5jxfdX+vsVux8xb/+ILaOCuKcs2mwplpz0KCh+GXnkYEEJZVP2qlQ+Hoom4IUNGl
         H/NgBTxdNfypPRHURvpG0ueSfIbrxJyWiT+uhcNGEVbpN4IhrUd8zhznjNmU3Rle8Cqg
         Af/p8rP1N+yzPMtcPhsVpeHJpOFfqXG2wtju+GNDELXFJniXEWSh7z1MPg9k/VwbXgkz
         UEfaa/br96PlDx4yZIkdfuSwCyn5hXPTZqZGFYFjKaXia7BU6cC4xY+T3P1AhNMqUYg8
         yGDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMrwz7ipPSJA9pAw8axgqQGBm/ve9dlLBQ7PEIE8ojXh51EnF399JZ8SHbf48zWh6asqL/zUydPJbZpz4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9r2H+WQLZf0pjAOZc60ISt/wFhUf8RTR1LmAI8jqZnmylq8C0
	eKACP1BemHeMGAlZsecDLVxoVxK/+9Gb2Tp1YiKZcNyKJPfGQ7atsx8g8B4VXcT7rnsqc9z3XM4
	s2oe25aIvl9p0xmkD3iUNP/RlwtY39zJ4pdocTQ==
X-Gm-Gg: ASbGncu6hEWAgrt7cRwsmVl/1vAbkLL7YHHovaKj1MYDrcPdZswC6OOMMNGW6EgDYbX
	4RlP38Np/wtAxyoXADfiyA4YG4u8+gbpedKZPt2nB6SS2MU/F2lt3JwbZhVHcL94MvMsXlmMomw
	fy1Gb9m1SyQCALf86DKyt4AKK7pMgMUCN5JUI5xTvN
X-Google-Smtp-Source: AGHT+IEZFS8P/SqBnB+WkQtnz50kE/KLVe8z1PUmhj0XLEUm9sUtkaGVMLjPe61piys4lVxnrSqV5nhPuLtN0bbXmko=
X-Received: by 2002:a05:690c:3386:b0:6fd:6589:7957 with SMTP id
 00721157ae682-6febf3e141amr139728327b3.32.1741515152574; Sun, 09 Mar 2025
 03:12:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250308-phy-sam-hdptx-bpc-v5-0-35087287f9d1@collabora.com>
 <20250308-phy-sam-hdptx-bpc-v5-3-35087287f9d1@collabora.com>
 <CAA8EJprBcGz0tZ5SDVC_WK2bzjXZAtOj+LfGnSxmwktvaQw=VQ@mail.gmail.com> <f1e33b02-5646-4219-98ac-c09e31d8215b@collabora.com>
In-Reply-To: <f1e33b02-5646-4219-98ac-c09e31d8215b@collabora.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 9 Mar 2025 12:12:21 +0200
X-Gm-Features: AQ5f1JrmwkN2RQ2GrRt72vVxlzBhDHQIaChvycTVxwU7KB8WVuxJ3KFj7BXSb9I
Message-ID: <CAA8EJprNTUuOwu__GcRhYmNi5rT0+3r16fs+n7Gdy3sjgTp+nw@mail.gmail.com>
Subject: Re: [PATCH v5 03/12] phy: rockchip: samsung-hdptx: Fix clock ratio setup
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Algea Cao <algea.cao@rock-chips.com>, 
	Sandor Yu <Sandor.yu@nxp.com>, Maxime Ripard <mripard@kernel.org>, kernel@collabora.com, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 9 Mar 2025 at 12:11, Cristian Ciocaltea
<cristian.ciocaltea@collabora.com> wrote:
>
> On 3/9/25 11:17 AM, Dmitry Baryshkov wrote:
> > On Sat, 8 Mar 2025 at 14:21, Cristian Ciocaltea
> > <cristian.ciocaltea@collabora.com> wrote:
> >>
> >> The switch from 1/10 to 1/40 clock ratio must happen when exceeding the
> >> 340 MHz rate limit of HDMI 1.4, i.e. when entering the HDMI 2.0 domain,
> >> and not before.
> >
> > Am I correct that the only functional change is a switch from
> > greater-or-equal to simple greater?
>
> Yes.

If you were to repost the series for any reason, could you please
spell that explicitly in the commit message. If not, it's fine.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

