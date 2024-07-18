Return-Path: <linux-kernel+bounces-256456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E82934EBC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 16:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38A2C1F2185F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 14:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06B41411D7;
	Thu, 18 Jul 2024 14:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cu5tTbyL"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4470B13DDDF
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 14:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721311672; cv=none; b=aPqlFj4QS0Oz5Zd+L34S+++IHcGg9qzJIyQAK+OM826xg/0zKKsCgAPpzpkIu6BbrZzult2t/cGi872H6++eqdRocGfVAUekoJoBjfoHxJx+YMjS68fZQzlaRT0lP4kzQgtCkU2LPJT3jY+5k5+Xb0pXby0W76eKRwbSoQ6LdK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721311672; c=relaxed/simple;
	bh=ginLRc2xnW0A1GmvhnVox7UgRQTqCO1LX3sjJ+8BHiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VRGhQmHOOmD+q2RliDdsgZK8JLY9vPvDU/myU3PaX8bl134ymqFRWAxCWuBcDALmN7F4ox9ZK9Wp0PkcVVDJ33q4QMKKIRkkBTwybV45DIoB2dd5QcdeHOBaS5t+yO4IY+DVhBtwS86lCYyyjy+g6ZHxX2CNz34A7euuKOqZKEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cu5tTbyL; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5ce74defe43so446242eaf.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 07:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721311668; x=1721916468; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ginLRc2xnW0A1GmvhnVox7UgRQTqCO1LX3sjJ+8BHiE=;
        b=cu5tTbyLe7r3nQTDeDM7vxST5dJNTYCN2DAwqtmqXOIxqypZM3ben6Bs21WcA6qFLd
         +ZH8jnwGD5IB3129cJdQRejYi1yZ5JR60hiAmMkT+vxfFaJirtQIEj8bAPH2ooI1uXye
         r8mTJQ8Y3wEqx6cu/TAsh9Fk18MMxWflfwufznikbbVd/+MmnbbJEyscPiJfSmGYZcf9
         8SMLRy9VuwhBbT2q1RZO1RVgbvk+gJzlLxthbUFMqZMHkQTCDp1kpG+kaGdZ4WTM6gFc
         GWWdp8I73ogeDA1MBEzImM+68bHBMyHHrwdiZ1wa64YYdbs4zVdCer7ZSMNjPdV+G5qb
         jpMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721311668; x=1721916468;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ginLRc2xnW0A1GmvhnVox7UgRQTqCO1LX3sjJ+8BHiE=;
        b=BPso29RbgW6zeSRGTiCkWLm70QF+FcspUmSxl9Ld98++pu8K5MSXlJoIwyHr6a2+5X
         aOP3RGzoz7Beo5y360tGtjolu9EoFfjV6bsbS8JNj13YbnQ+yAIQxQRji2vzuHg8cdCK
         TAHANejGEf0afqsX82lPXJCy7Nt5eLl1DkSG3lTzyn4HH7BW59zRXT4I0rV4MtFQ76b6
         rubPrlHFYrOxZHU1/CMgy0hY3tu24nM7/0D7sxfRtDDQmasAAL47u3oseawfP+Q0y4LZ
         lsCDDDI2rQXZH+n3AXakr1FV0d6YmQpBr07BrUTnOTeKqRjBb+viUxpi1N5YNKHTUqgf
         xWZg==
X-Forwarded-Encrypted: i=1; AJvYcCWyCdvBKOfXVBCXcBBQ1KC37HmQ7qkgGN4lzjXhNP/o9IJsFG1UiGwa2cnMEkPq1ZJ8eXFL9ZAj2wtoYlWTxCvkMSyFJXOPC1Gu/qvL
X-Gm-Message-State: AOJu0YxjYpF7DycnK3tqh1PJIKuW43d4z0J2ZmpPVnlxx12uDG13Epg7
	QcQJhxk/cBC4tvkZPw32IbEKN6LGvbeXDxzD1/e2p4U+GbEpwYvVeM0lllRSDuuxTEWwIu/YaPf
	i28VMASHhaJSIPmOmvZmhqE86PfHkSC4yRQ41nQ==
X-Google-Smtp-Source: AGHT+IGo7kWj6LRgg50CbX2vgq5HYM6cG6nd+ssW8D7KH6ek0XiRt2YeGDCasRSYvUJvO2GbobbvUcmVkiUp+te3/4E=
X-Received: by 2002:a05:6358:2909:b0:1a6:b070:a58e with SMTP id
 e5c5f4694b2df-1aca9eb8939mr243714255d.9.1721311668209; Thu, 18 Jul 2024
 07:07:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718125545.2238857-1-amit.pundir@linaro.org>
 <qitt2j5hw6pax7yekdooutxebhkznhdv3aafnhkysr5fjcbmd7@xqbp7h3ld4gs>
 <CAMi1Hd1wzvzStEv2zoNocvYBkJDis27vzCDcBtMruQQ5TdOkDw@mail.gmail.com> <CAA8EJpo1go=4zU0zvi_dd8ST+phP7+aMJz+sM-Jerwpf6s2=Hg@mail.gmail.com>
In-Reply-To: <CAA8EJpo1go=4zU0zvi_dd8ST+phP7+aMJz+sM-Jerwpf6s2=Hg@mail.gmail.com>
From: Amit Pundir <amit.pundir@linaro.org>
Date: Thu, 18 Jul 2024 19:37:12 +0530
Message-ID: <CAMi1Hd14AeScwEjLt0Z68yatum_gnFKBwgndK-KYqd5Ox0G0Ow@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: sm8550-hdk: add the Wifi node
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	linux-arm-msm <linux-arm-msm@vger.kernel.org>, dt <devicetree@vger.kernel.org>, 
	lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Jul 2024 at 19:34, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Thu, 18 Jul 2024 at 16:56, Amit Pundir <amit.pundir@linaro.org> wrote:
> >
> > On Thu, 18 Jul 2024 at 18:36, Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> > >
> > > On Thu, Jul 18, 2024 at 06:25:45PM GMT, Amit Pundir wrote:
> > > > Describe the ath12k WLAN on-board the WCN7850 module present on the
> > > > board.
> > > >
> > > > Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> > > > ---
> > > > v2: Changes suggested by Neil
> > >
> > > Which changes?
> >
> > Neil suggested a few changes to enable 'bt-enable-gpios' in
> > sm8550-hdk, now that the hci_qca driver uses the power sequencer for
>
> You should have described such changes in the changelog. Note, no need
> to send v3 just for this reason.

Noted. I'll keep that in mind for the next time. Thanks Dmitry.

>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>
> > wcn7850 https://lore.kernel.org/lkml/d3416be5-b97f-4db6-a779-9c436e41dd72@linaro.org/
> >
> > Similar to this sm8650-qrd change
> > https://lore.kernel.org/all/20240709-hci_qca_refactor-v3-6-5f48ca001fed@linaro.org/
>
>
> --
> With best wishes
> Dmitry

