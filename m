Return-Path: <linux-kernel+bounces-446934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C52859F2B14
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 08:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3CF3164D91
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 07:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EDE1F7097;
	Mon, 16 Dec 2024 07:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z65HamKQ"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDBC19066D;
	Mon, 16 Dec 2024 07:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734334940; cv=none; b=Z7/GfD6RRNOjT1kudrVvDSeix1BCa4uqsly+IndensJmI00ufjV5jgpAvcXVQKwPzh0LzO2zSach2tOO38WhB2alwNxoFO0qIwvZDLBlEEmxCQb1ACYn1eWDciJ6/cCPugn7YspT7ZKaVCypaxHqiKKW4pGPtg02awCu8EMRH8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734334940; c=relaxed/simple;
	bh=ZkemQ+wf4sm3pmKBzXNzp+ga38+dW6eAAvewr01DKlE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rrMCvCIwhRkDf4khdpjiN+eaeWhOVGo+X2brayQfGBP2XvltVpAK0dznLQGGorV9YGbZiz4HTWqEcsr+QbfdW5cUTTL46zXcmiOivDjJSe6vscGzO7Di3Io/cbp3dtIgHeRYnjW+b0EWH7AdPGeJJlQ8qtZ6OkzyE5KKcvoYV4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z65HamKQ; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa679ad4265so913343566b.0;
        Sun, 15 Dec 2024 23:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734334937; x=1734939737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZkemQ+wf4sm3pmKBzXNzp+ga38+dW6eAAvewr01DKlE=;
        b=Z65HamKQ/zKv1GabKyI4Io8dFoOwdeabIUi66+DFWIzyXCqOOD5YrYFXiyE7QgpzGl
         yqmJXGrAmUjyTlkAIfPR4KJmM0/DSqWpK26ONt/IQBdS1Cs/hZ2q5z8QBx/VacolOKED
         lCiH2TJ3cImS9VCag1F4LBjGWF5ReFZgXwUPhk41G4Katm5uUGP0G7DAQU/ORVmbCPcX
         QCYs7vmMuTSXpv6fI5wl+3o4OdHVbMyWIPVrfGENorxjPRH3azxdf93wyE0fstsKyVVI
         aiZu2b3OwE6hJwWdytxftBglG0bWzVx+AMnqqjgCJguyu5xY5qkr/2ITk0W4phwKs1PU
         BwCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734334937; x=1734939737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZkemQ+wf4sm3pmKBzXNzp+ga38+dW6eAAvewr01DKlE=;
        b=ES4pSgxgu6Qxd3u0VzBbP2hXj5iBkNUyMSwSXLaD+C5hQotJSG0qVtu+NwCrgXMDbJ
         yckpQ4HWs0Svx4MQCODg13NOux3zDHuJOq3wLmUbjGW9tbFPToES1t3lKx0Lbxt4PUzG
         0zumPZ82xl+jsMInbAxSiShqheSCFsNXo7HXtV7joMErE5rhStTYQFWrPltIOhtEarYz
         Ip90rxSwAoKjJTAwsZ6E7SHgVEKYtg0magEpyhedZ4WaLLT4MSEfmZIw2EwH+CeVMRHW
         r5Ruzjo6ELeYhI/fCJ+vQ8zt1eZz1VSNanLoJKZtS8xch8d9+pa/jgGSIA7t7cs+qeJ2
         e1Jg==
X-Forwarded-Encrypted: i=1; AJvYcCVmejBV4KD/sFGNahZ9U0iu4T1Xm0qwleTP0h8DUKgFVwlJx1/zSWKiODGhXsVCcl/3rVkApOxnBZRPpBk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzi8/Eqa7guyaEHrgpK1jy1XhpX6TJF+2qx+r1WZpf1fKijq8x
	/ybSutLTGwtDdBry+PoHXXbYbFLrpnPzCQ29P8jVIdVH/TCW2iNTSozVC51lJe0aTic8UNAVj1B
	Lrhhp+WStauGTneiABYxA2R6PyOI=
X-Gm-Gg: ASbGncs3GiTEbux/MjTvdjf9OhjsHd2i6uUPEy5Jg/FzKInx2fysbjXEfU+8EGBh7Xn
	tnRWm/8MQhdpJynteLlyHDwQhosv9SvtHNBUZlQ==
X-Google-Smtp-Source: AGHT+IH79Q9EfBurUM5kKPezt8kcckucAdLGtdMJvJa+bW0UNQ7P8Bg2GIDRNa3xY89Qo1+/xj0RtyR8/AFpfPCQpQE=
X-Received: by 2002:a17:907:7d91:b0:aa6:8937:8a6d with SMTP id
 a640c23a62f3a-aab7b0e924dmr1216190966b.4.1734334937130; Sun, 15 Dec 2024
 23:42:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216043910.11875-1-fido_max@inbox.ru>
In-Reply-To: <20241216043910.11875-1-fido_max@inbox.ru>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 16 Dec 2024 09:41:40 +0200
Message-ID: <CAHp75VfLa4VvfM1aRPie9k69Pw-Bg-6P_S=Fq6VDpZz68tNVJQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] ASoC: codecs: nau8824: fix max volume for Speaker output
To: Maxim Kochetkov <fido_max@inbox.ru>
Cc: linux-sound@vger.kernel.org, u.kleine-koenig@pengutronix.de, 
	tiwai@suse.com, perex@perex.cz, broonie@kernel.org, lgirdwood@gmail.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 6:39=E2=80=AFAM Maxim Kochetkov <fido_max@inbox.ru>=
 wrote:
>
> There is no audio output if Speaker volume is set above 25.
> According to datasheet maximum allowed value for the Speaker
> output is 0b11001 (25).
> So adjust this value with datasheet.

...in accordance with the datasheet.

Can you add the section number and its title and possibly the version
of the datasheet?

--=20
With Best Regards,
Andy Shevchenko

