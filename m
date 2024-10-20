Return-Path: <linux-kernel+bounces-373330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4F19A5552
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 19:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C47841C20B15
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 17:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38681194C67;
	Sun, 20 Oct 2024 17:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z/2C3++t"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9438A2E403
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 17:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729444608; cv=none; b=kiu1hJVrgHsyFz9ZQx05eGL6UJShvyhcdXks2k460nSdKFWbS8+pWgWNVdgYkIE/mPsVjhWsL7qPYKNPvN5VbyreId42gNcSsZBbZhQET53TDmXgbF5tRYwIKC5WONt4pv/1gfocqtqm3C3BtZnyszpTwCUguysTByKKBzaP32U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729444608; c=relaxed/simple;
	bh=I6V8NQTEyfLTTEBu8Sn6bgUyr3ui4C1po8Bgpjc1aIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lr/GAU10IqElc21uv5z0UQDIBaXGMIa7trl1LYNP384kPsGi+NABqms541jzll+Mw96jbQaP2PXJ2ef0k5cfsZAJA1W41zOsTDGsQXz9YP4UlwgkFRDCm06T7XPE4REcl160fwBL8EhGB7VbpHD7+8Do6DFp65oyMCIg/i32aSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z/2C3++t; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539f7606199so3981435e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 10:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729444603; x=1730049403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6V8NQTEyfLTTEBu8Sn6bgUyr3ui4C1po8Bgpjc1aIE=;
        b=Z/2C3++t5QXX7Pk7dXd3W/jDl3pnzJIRzPPVmlsOZYdiHnWtz9J1BOjTCAPYMkEFDH
         wrVzqsjU/kEjUQ9T7aGcdLUoj3XguyjyAH01Ot+AGI3mAlZP8k3alx0leDjUqb+tZeX3
         tjhU6Y4j6pAc0w/xQ9hk7lKy2WuJsTtTwyTzdtugPnwTltJPrFItj/JFNgAQqLs6NjCY
         pjAy0VWmtdOasnJmQjQLRdTLsz8f7kZwnUo+Tiz8644LBbRH1ppPzrcsm895hDzfeq1w
         cCXpfsWpwqpBgZP9WXQHfFIbGFk34zhxWFn8pn8vanL/MuoYERQg4DsZ4TCIRyzuNMuO
         mGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729444603; x=1730049403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I6V8NQTEyfLTTEBu8Sn6bgUyr3ui4C1po8Bgpjc1aIE=;
        b=t/iM7MZr4rn2f7UtLJFUXwGku+GPkzGHZ0966TwHTu7m2/Qu3hU0UiNmXOpf/2JRVB
         1Bwt1USNVDmfYVdLh3vOPILbvuOrTZoibIh3vx8ApgiZVIHTcxrfbMLVl8+Xle3kLJg3
         Vmont3txBdk7jmvyMLETrRitVdEq9nSjIFde+6hTiiCmKuXdTMty6d3paGcVIyWsobTP
         quYEbo/C0kBi8KLGHR1jbekjqqNOkYgrLlAPRvzNDCZBbC3fgMlA1q6T6kvH0JnsmjLv
         F3wywjeJJSoGzJqyr7nyCs2wAG15uxsTbWEaUR5kJnSa2hEmRlnf8qEaHa/Z292px7W2
         vmeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPZiq4t8rx3CPDl9g7MP9+cbOq1ZqpLX/2dxzLf0WzFyFmgPJ9EIfZpGnNnor5YfTMiBRQgeuBoMe0g/g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7viCLDIqe71ORP9cpvK405/S8G7Df6wSZtyALxyN4ZGCvzdYl
	WbCK9/q50HnGZbikhtUsV7evXb7Lye0c5iDwDTcRTy5c56xa8hyR+q7V1oHzQP16ZZD8gT9Y6uo
	u0v7+Wd72mO9PXsMEwWlMOFjXkSQwADk9nAwIqDMxeMpEgxq+
X-Google-Smtp-Source: AGHT+IH2AqgSuWpQlh9ompn1q5wHaPZ1qFxrrbdVL9MqfxAkitzPq4pNAZ4XtjqY2wjU946yO1MA+AFW4BI1c8+w6HQ=
X-Received: by 2002:ac2:4c48:0:b0:539:f699:4954 with SMTP id
 2adb3069b0e04-53a1546ca04mr4715042e87.58.1729444603333; Sun, 20 Oct 2024
 10:16:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241019-mv88e6xxx_chip-fwnode_handle_put-v1-1-fc92c4f16831@gmail.com>
In-Reply-To: <20241019-mv88e6xxx_chip-fwnode_handle_put-v1-1-fc92c4f16831@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 20 Oct 2024 19:16:31 +0200
Message-ID: <CACRpkdY9jaXDoFzCC0ejLZPbbJ+QAgsb+QE29sDEw0Htgej1HQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: dsa: mv88e6xxx: fix unreleased
 fwnode_handle in setup_port()
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 19, 2024 at 10:16=E2=80=AFPM Javier Carrasco
<javier.carrasco.cruz@gmail.com> wrote:

> 'ports_fwnode' is initialized via device_get_named_child_node(), which
> requires a call to fwnode_handle_put() when the variable is no longer
> required to avoid leaking memory.
>
> Add the missing fwnode_handle_put() after 'ports_fwnode' has been used
> and is no longer required.
>
> Fixes: 94a2a84f5e9e ("net: dsa: mv88e6xxx: Support LED control")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

I was as puzzled as Andrew but I buy the explanation.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

