Return-Path: <linux-kernel+bounces-235123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C12D91D076
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 10:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 747751C20A2B
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 08:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125BC3D0C5;
	Sun, 30 Jun 2024 08:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FBfhfxhC"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94427139F
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 08:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719734847; cv=none; b=YKmIuJ3y3ZpXP7SlpYEQIx2UKEiJTw0yf4BtDdGsJZm5kvV0SpERPcvxTwixBsjgfW01dKw9e6nCK2ChdLY8kFGXHXEUwZBk1/CO/wGwrp8g4NC7BOWlZSUzFIoQO0UE5qjqrDv9oyoxms7cepFNtMxzSoQ1O+XkSv2QTylGByk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719734847; c=relaxed/simple;
	bh=x14W0zMcNYfSjfgEi8hckZrQ+GGSiswtHwN8pa2QffQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ahb1CBP7X9vt9u5P6ZTQX+fTTqNT46cIKAHynAYnigeNPPMOC4cXD2hMupDUH6GNxbyxMaTdNdRIDTo2M+xWZ8Tbne/57SLFVyymxZz7IeyTmoprk49SfhMmZ6w8o3du1DPmCEI4Y0ZRRu1XB3lfnH8GoKbazjYd6LTSeFyx80Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FBfhfxhC; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ebec2f11b7so21878111fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 01:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719734844; x=1720339644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x14W0zMcNYfSjfgEi8hckZrQ+GGSiswtHwN8pa2QffQ=;
        b=FBfhfxhCYa5kiDach0xU78dmb91QkwTeLf44nq7iO813JesS3FYb17VSA2G7B8FKjY
         bRNIzxdCxa67nRWeD6FHZ1T08o7MYYkE25ZZ9H/r5mDk/tWPkpaPcAFKzXMoigSk7UFk
         qla2g91ou4J/8TB/473aIx6FqZj5YVKSIe+1HuBaJvLHfzNE9gN3Wn7c/zCLl5cZWAmH
         4eOv4I4OxjnoGQ50eupa5b80Hd9MO7DAFblMh6QnhXJ2AKby974WBGKN03OHAv25u7au
         AFpShfqQWuucMHK/txmj/nd06fqvTFvuOGLcF01bshknSdaQ8z3zbH37C2bzWNLk5zIg
         D6kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719734844; x=1720339644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x14W0zMcNYfSjfgEi8hckZrQ+GGSiswtHwN8pa2QffQ=;
        b=ID/PWTKBQfvTDH50/Dr/55IdbQBgN6gkrEmGi3LVXp1s2KwjtDfxB59UFYMweW8rN9
         zlxoEeGPSR4wp7EC9Ub8PDOUs13wlnSs+8nAbcHS3RDIibcsb4BQImH3m+2fXPqCl4ol
         bzf5dLHEwQ+JlwzEGu7RJ4AGec5N1NHaigHdClSl6vtm7IBO0tnMcQUinpFv4q6i4oKO
         o+eRI+lSLjTU2UNBCrdA9GH+nMKUTYlWSeoe41FbRD2tejbN9ySjDNkk2UH3Bksvp77V
         8EKjEu8vBCCOy0lAtTfj0R7LKqjEjSIfCtLFjvoQpCGThGUepp10mys/lcHm8uzX88sk
         BO2g==
X-Forwarded-Encrypted: i=1; AJvYcCWRzvwYjZ1eduqxnhkaWJxshBz5bbQdgXRykGjZbBioxAYwBXMcItC7fXk46F/Hq3rszB8ysqtqazUMURM0gWBT3BQDiyZO2kS8ViRJ
X-Gm-Message-State: AOJu0Ywe5D2io9cFT17fZDu1LXF7hJUPxKuSkIeVx5TTX6CRtcswqvSK
	qJQV2utYnbxoNWhqFJc9g8AuZgIo3lydiLROudWxcK50NqJsUvstfVYyzhZYKsl76zdSpJw/kE6
	y9xS6JLKBhyXdtgnPuQfFBBQudXwc1z81Kl0LhQ==
X-Google-Smtp-Source: AGHT+IFp3NqyIYTlNJnzRJc9aynoy/jFOr3NFhoRp1fIAA9xDMWp4BlmkhBYvRQf+SSix30ahl9U5AB2+G44KmoyGv0=
X-Received: by 2002:a2e:9c58:0:b0:2ec:3180:d4f7 with SMTP id
 38308e7fff4ca-2ee5e375a38mr16017461fa.26.1719734842537; Sun, 30 Jun 2024
 01:07:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628180852.1738922-1-dmitry.torokhov@gmail.com>
In-Reply-To: <20240628180852.1738922-1-dmitry.torokhov@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 30 Jun 2024 10:07:11 +0200
Message-ID: <CACRpkdYA9BCtNNf31uGkF4_Zp7uUZ-Zp6-PLa-qVVSi6NJ-_sA@mail.gmail.com>
Subject: Re: [PATCH 00/10] ARM: pxa: use software nodes/properties for GPIOs
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>, 
	Robert Jarzmik <robert.jarzmik@free.fr>, Arnd Bergmann <arnd@arndb.de>, soc@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 8:09=E2=80=AFPM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> This series converts legacy pxa boards (spitz, gumstix) to use software
> nodes/properties to describe various GPIOs instead of relying on GPIO
> lookup tables. The benefit is that structure and behavior is closer to
> DT-described GPIOs.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
for the patches I didn't write myself.

What this really needs is testing... :/

If nobody is testing, I think you should just send a pull request
to soc@kernel.org and users can find out the hard way and help
fixing regressions. It's a bit hopeless to work on this sometimes.

Yours,
Linus Walleij

