Return-Path: <linux-kernel+bounces-309517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8145966C31
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 00:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16F991C214E1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 22:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E3D1C1AAC;
	Fri, 30 Aug 2024 22:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QyxgQiBS"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9011C1728
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 22:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725056277; cv=none; b=sKmVlItHj3ZXDJTdkJBgcbfwGFPhk/2LIVnCaF71mcZLs42JHY0GyyvE22cy6jvLjGt1AJYK/zGO/psCxNs0EiT1PHj+GdIi12NBZZcK8+U3rRQOcvqItbuf7DDYX3zu+Ak4QQE53gvSoXxRfkGL8meAitVld1BTt7do3MP6Vqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725056277; c=relaxed/simple;
	bh=k5WO4QDBBlsQUtbcAzwg6NCzLWWJqOLIFTUVIpEZcoU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uDMsEuLharhHgGBQaGlbBe0Y4G5e0qINzhA/gDLj0dL7K47arOLaQfPW3XDfLcuHN2Rr9be3jo2o9trtCYcFeUbVowxkbGLZjpzzafbAioiiSZNeyG9jb+WcD4Mim2OoS5O107Gl66k0m8SPhAK9qY/5v1FwmJAMuHXijzldVPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QyxgQiBS; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e1a7f1597bbso794448276.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 15:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725056274; x=1725661074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5WO4QDBBlsQUtbcAzwg6NCzLWWJqOLIFTUVIpEZcoU=;
        b=QyxgQiBSq+KXSXH66XgHsHC9AHoz78OEpswWAmLCMBL8ZWtJwQX2s45iUPwS/oiWw7
         gDB9m34IotELmdsinHrjlseK+xFHfqrVe+rn+QGkr5Tiv3SxVXeL54lwtnT8shlX49d8
         qjuos5ZNgcQBQtuUdYC/RLXxKpHa3MuDlHoGUUGXTBVNTxPpDAaiW4aF0OfpUZlRAA0R
         npekk402BCaABiTNbj1IMm1o7dRTr8oHrnhW91RLS5gaNh6Psq1lzORnQ9VEQws//gp0
         b+td32i6JxRSDXw7Qhao+C39NDGx24uDgQIY61ne4XIgSTfocStqeohQJNqxYvzGHNil
         PzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725056274; x=1725661074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k5WO4QDBBlsQUtbcAzwg6NCzLWWJqOLIFTUVIpEZcoU=;
        b=kbke2h4iNepkBRU31qUIwcdkaE0VHNk8IjrJKVvCme0GMSxUEz8b2Q+cdTCWbf+ukc
         vefwMKFWbeTaA+lfMELo241W0EaZS4jS5ZRpEwXyxQdUEzvkJyJXjYom3H8Trg82AqGR
         sWp7bEWcmj7OECX6mFaqDt5Xcye2TeHSHzNP2zsza1buGJLI5487RXSBT8KWGLFjO9zS
         fo/M31BN5RpHORpXmmMqUoGMFyN7Hq30vohTJKQtpxBixSvFHxVz9KoNNr6qJyYFEmOo
         zv3FrYcHrRhJ2ms5x4RAkDI7UabZQ1m2P6bl0rU4cgYNxsdOLQx28sQjC6AZbjmrW+KB
         2s2Q==
X-Forwarded-Encrypted: i=1; AJvYcCV9glYEOUHF72q5RfEgw6Da94fkQINsAayQ7vuNjfmxhb+fQ7FB9vWbw7Mz0TSxQRVvAuItwJK709Em0mY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZeOS4QkbdfGMyEllOBpfkf6C11HN2l5UI8k7HVRoyBlgrYkm4
	IzFuM21luvw1KMfZU0Ulu27bXgrGfpSh2fa3eQ4teILgLnc5jtsIqiowLoUaWjrdO3sAsxO2tb/
	7paNcvHqgJbr1mwO0iXdZ22rsbXYEDYRt4gXVwA==
X-Google-Smtp-Source: AGHT+IEmUy2IA6mF/xZvxmao3unx9PJZHOnyHquLRhrCfhleDGsJQGbKCiuRac4ps36sc2viLuEP9uTKmgAJ4mvsDS0=
X-Received: by 2002:a05:6902:1ac5:b0:e1a:7033:73b2 with SMTP id
 3f1490d57ef6-e1a7a3d8163mr3422353276.24.1725056274315; Fri, 30 Aug 2024
 15:17:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827075219.3793198-1-ruanjinjie@huawei.com> <20240827075219.3793198-3-ruanjinjie@huawei.com>
In-Reply-To: <20240827075219.3793198-3-ruanjinjie@huawei.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 31 Aug 2024 00:17:41 +0200
Message-ID: <CACRpkdayBQ6TrV0Nn9jWX45YaP6repY0FU6CP=FnubLbonpEbQ@mail.gmail.com>
Subject: Re: [PATCH -next 2/7] net: dsa: realtek: Use for_each_child_of_node_scoped()
 and __free()
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: woojung.huh@microchip.com, andrew@lunn.ch, f.fainelli@gmail.com, 
	olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, alsi@bang-olufsen.dk, justin.chen@broadcom.com, 
	sebastian.hesselbarth@gmail.com, alexandre.torgue@foss.st.com, 
	joabreu@synopsys.com, mcoquelin.stm32@gmail.com, wens@csie.org, 
	jernej.skrabec@gmail.com, samuel@sholland.org, hkallweit1@gmail.com, 
	linux@armlinux.org.uk, ansuelsmth@gmail.com, UNGLinuxDriver@microchip.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com, 
	krzk@kernel.org, jic23@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 9:45=E2=80=AFAM Jinjie Ruan <ruanjinjie@huawei.com>=
 wrote:

> Avoid need to manually handle of_node_put() by using
> for_each_child_of_node_scoped() and __free(), which can simplfy code.
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Neat!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

