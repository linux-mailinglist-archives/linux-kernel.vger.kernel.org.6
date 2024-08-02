Return-Path: <linux-kernel+bounces-273123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B719464C2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 23:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CA651F225E4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 21:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69646E611;
	Fri,  2 Aug 2024 21:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZmsCX7Dy"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7227D1ABEB9
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 21:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722632575; cv=none; b=Q4GXJhyBA2RAgEo6MmX4T4OsPwUxJ+9znnzbBvB571NNmD4O1vVANoiDCLnREAJq/V+nBhqUnvtxQuJVIGuuOK1AUOySQylTQHpchiX+lOmL2Aj5a9xhaFwAMnMSdjKdLmmjaaHuAHlAIvwjafAybAifBMj17I5pyocp5p4G+2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722632575; c=relaxed/simple;
	bh=M8kFf0Jt6NA4sNyW9x1qC7SEh3iENhRBOScZoNi/YpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q9SmUCURiMgRbzGNKolpbYY0dx8K2tIbB6WcHz2yQYIJzJTnUy/sBoAveHBI6iB1YIqMOd+y7ctVRIF5ZV5eC49yQcNTsqFMt7542olyv1ebgJy5Nj41YdjIKUKHo7MUFfquAGsAgzQwNx10eJFxArTdweeHPEb6DB7xZMVzvrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZmsCX7Dy; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52f04b3cb33so18686161e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 14:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722632571; x=1723237371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M8kFf0Jt6NA4sNyW9x1qC7SEh3iENhRBOScZoNi/YpE=;
        b=ZmsCX7DytYOl0XnCZ8xlxEB6phSoYafcwUYJFFkfDSQkxMEKYiH7Oszm6B7KbjP+dH
         s3eF1svtBRtNRikTLcdxQVGX+i9x//JJPT7Fg7QOF7fFPhqSY+U3AovZjf9VtBOcSIkd
         QqgOxkDlRHV1AvWAJmbkWo381/J4n4fenqQNn+M6+FiF37UG/XBDkHc51wztyzZIhyEt
         qa8qfd3Kc5baKNrm3eLoZOZGX9LyNhx4/xFLfFZHov6MBWQ8uA3jlM038Kx6WmsZ4QKx
         W2cl62CRYYaey9qQZK/tRtHYKSMAX5dB3rDWcMYIcD6dUobXuCadElkJ3BEEwNqK4WZX
         6BBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722632571; x=1723237371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M8kFf0Jt6NA4sNyW9x1qC7SEh3iENhRBOScZoNi/YpE=;
        b=rAqs6LvC62P1vqHR7dSLfH91tMJt3rjpjE4reGaLGIn/3fPzk3eZHWmPoUBMWIUfSB
         zGgeT2hCwcTp6BgtAynEE3q9dg1seJW/yZAmvLgsVui3kxFFu4fJWUU/iGAGM74+RdSU
         a89EUZIxIaE6rbgs1bXaehjCbZnk2Dc4K1iZM3+EpnuvzyR9JOND+RRhJmeipsloPp0s
         ui53q8oh1do+YUDcVhUgZx8XfwERHD3O0OXzbF/w31/K7a9tPGIbSIn7X1cPMoTe7cad
         GxGDTBKvTkZb7AgRs6WHGP5EpoeU90RzErscRyDdHRw6BW/kZU5seiyJwL1WrI1idA+o
         QzSw==
X-Forwarded-Encrypted: i=1; AJvYcCVIASwsyxsl1Ur45RVfYkly4LR5lglLlev4+QWWDCG5JN3RuRrCcgX/ZCMJi5bU/5vBpx4kdWA74k/Gv3/6g7qv8vrl3OlYruF4rYR2
X-Gm-Message-State: AOJu0Yw9BQSi5rSsKSO5pTtL7XwPPZcAck905i7YKzbvb/uRJ83aP4ui
	ye9jC4gbKtvtvws+MpSXF6YyTFJ7M+EAFIfc7eyHMzZ5eoEtvwpjUOWJ8AsoP+AA0+UVHO7kUDA
	JVz5V9k2iwF4rfluu9Zshnf+ZBK7u86YJDWV6GZBhqkkbpz+i1FM=
X-Google-Smtp-Source: AGHT+IG9iocRNKrKKnUuVyBrBnCQiAmae7NKntQVMqeZsr5uEwqat79wo6dWkIPEOd5pUjoq+VHGi6dJhy+T9uAyKOY=
X-Received: by 2002:a05:6512:b07:b0:529:b718:8d00 with SMTP id
 2adb3069b0e04-530bb3734f5mr3615718e87.8.1722632571416; Fri, 02 Aug 2024
 14:02:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802080403.739509-1-paweldembicki@gmail.com> <20240802080403.739509-3-paweldembicki@gmail.com>
In-Reply-To: <20240802080403.739509-3-paweldembicki@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 2 Aug 2024 23:02:40 +0200
Message-ID: <CACRpkdYrmQ3HUSyY0BGq90ZigwuorOGZWehxpxw9M_K-n9-SDQ@mail.gmail.com>
Subject: Re: [PATCH net 2/6] net: dsa: vsc73xx: pass value in phy_write operation
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 10:04=E2=80=AFAM Pawel Dembicki <paweldembicki@gmail=
.com> wrote:

> In the 'vsc73xx_phy_write' function, the register value is missing,
> and the phy write operation always sends zeros.
>
> This commit passes the value variable into the proper register.
>
> Fixes: 975ae7c69d51 ("net: phy: vitesse: Add support for VSC73xx")

Actually that should be:
Fixes: 05bd97fc559d ("net: dsa: Add Vitesse VSC73xx DSA router driver")

Yours,
Linus Walleij

