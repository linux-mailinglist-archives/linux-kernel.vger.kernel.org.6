Return-Path: <linux-kernel+bounces-567328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A391A6849C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 06:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56CE019C2631
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 05:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91AB130A73;
	Wed, 19 Mar 2025 05:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jdC9LqUV"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524AB198A08
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 05:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742362511; cv=none; b=F/O/wdcfZlMN3Qv4sR0LXDpwO6xZCeYJfmJuOMG6yT1vk4icV7khQhkNB1oYMeJpRx8Lqh+rH0Om0fediuaIDhvMKMtrRtgRTDDogGoX56nBiSgcA4qLmp3q57KfABL4+cHudwB9LTbhDjmtAjDhMaE2TfCtTHOesdrgyJeaDGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742362511; c=relaxed/simple;
	bh=BJqc2V4r6FqOy56nnp0RIfpnpHABd9NTrRkrL3bqP0o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qpw612JeEGZ/Uix2n6ViOwZL76gqHUGVC87GI4GsZIA39YPwrqnedM8fGLqbZXCt1PWXcGYHsCXeiEkiDOgnBj5PcsoW3E+/bjcGTjVnMFslSAGQ9pw1M6ekJpOdxQTbd8FrxfA6KxElcqXUeKFlgnEBljJIyCJwgx802ik6tAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jdC9LqUV; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38f2f391864so3639398f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 22:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742362507; x=1742967307; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BJqc2V4r6FqOy56nnp0RIfpnpHABd9NTrRkrL3bqP0o=;
        b=jdC9LqUVZrBJwSgXWzXWHyON+TwBUdI+F0w4DVTBXnHvko8786qrD1kbEzmHR9qrCo
         PduBpHWUzxLJSw4CM/Dkc4C/ME2bI81WFOdQcKFLix6GqOsMJqoHZhw2qRPvW1CxC5zm
         khk67HCGkxKI291ZVAfaHWnHz8uRlZIaaoon0dBRS8UTNWvPgNb6pPqEafG930P3Skjw
         l3yVWExtHs29F6VsYwNbPDhX/wClYz0/t9IRSyR2RlILevJ8YZmroDaY5kTM1nbWcAU7
         7/5tJIqn6Qqx4X4KUgbjSYC4knuyPf65YDvD+Fad+72om4qa1EuBOrOkHcJMUizOUA+T
         OdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742362507; x=1742967307;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BJqc2V4r6FqOy56nnp0RIfpnpHABd9NTrRkrL3bqP0o=;
        b=VEqU/WyiPUfogSjifzw7Bk0IPmiBgXplqp1nqTAN8yBeHZGbcCTA+8W5jzBvITUAu4
         v6n6gP5H/YXweY3jIGiDMvB3VkHLhCIAPtZwmP/Fh1LKyslJ9pg1cyskzSdjsdRPHmLd
         8JAX8QmfcpZH8wQZRvAg0Qzpo371SmH4T5NJdjUX5XtbAB8yr6ufpLvnzMZqNbTKOiR0
         nX1rOX/dIaR/SEwILzAyud0JhEFe39RBnnzEWmoWcY/hcnMMsHaqZ96JD+l2vSFuUZj+
         MwPvPTqTdzN0EA7jodJFK/TWDGJvU/+6AAjwbGH0zN71R18SBPzCGIn36HBVzDypdVGB
         v6HQ==
X-Forwarded-Encrypted: i=1; AJvYcCW57Wx7rXDVeq0P8sWgBYAbWsPfSIXSvtQN0V2AO4Q90PtfHmSWGqbjAFgPg5Cy6bM0Hzb51il+cM0Rq+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIFCxzybbO2kK2wUS6S+nbkL7+aK7W0M5CtaWR+ohz39qb9Qtm
	glq1EEfXUcYjBV7GAd+9TqFA3c1mZmekRhTAB4Hi1W5jzesy3fQ6CuxctRAlkys=
X-Gm-Gg: ASbGncubXGkhB7545RMJcNenRIUKrmkSOMD3JXH9XT/ZeDaDabMZyAVZ9Yw1HWXoS55
	WQPcfh+R/R6mz/5OY4qF8J11LAHe/dKl4mJzLhNRQIR/AqxtWY4IqOqnyDM+YmO6yZVeM2YWxiL
	vc/0ermh5HTPxXJ+NUxtAWqR4txV4wPN6mcg4C2ljJRAXjAhkdNjswQGGhsXGlLbykTFVg6MAhv
	ubTjzrNBCxa5sOMiyLP1mmyDWPFaLyrLWaf6oyHXwZf9h2iXkyePNkYy2sDcBSg7cxdXVzKsBGd
	UZBLAGueYCM8CemRQlYKUt2/+QDH1uiTpOIoV8fHtWIFY9k/0w==
X-Google-Smtp-Source: AGHT+IFEhSoQ/DQEODNld9+47I3jsF4TAZ+I7PfGqqGTO6NCSHxQ1Hg/oJ8JzcAfC5cy6PlHPs8sDA==
X-Received: by 2002:a05:6000:1888:b0:391:2e97:5788 with SMTP id ffacd0b85a97d-39973b725b6mr1281339f8f.55.1742362507353;
        Tue, 18 Mar 2025 22:35:07 -0700 (PDT)
Received: from [10.1.1.109] ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f6befesm7891435e9.25.2025.03.18.22.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 22:35:06 -0700 (PDT)
Message-ID: <4f928b89586aa836ad3a905db740fdb5d9545b81.camel@linaro.org>
Subject: Re: [PATCH] power: reset: reboot-mode: better compatibility with DT
 (replace ' ,/')
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus	
 <tudor.ambarus@linaro.org>, Will McVicker <willmcvicker@google.com>, 
	kernel-team@android.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 19 Mar 2025 05:35:05 +0000
In-Reply-To: <20250307-reboot-mode-chars-v1-1-d83ff95da524@linaro.org>
References: <20250307-reboot-mode-chars-v1-1-d83ff95da524@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.53.2-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Fri, 2025-03-07 at 07:50 +0000, Andr=C3=A9 Draszik wrote:
> This driver's purpose is to parse boot modes described in DT, via key
> (node name) / value pairs, and to match them to a reboot mode requested
> by the kernel. Unfortunately, DT node names can not contain certain
> characters, like space ' ' or comma ',' or slash '/', while the
> requested reboot mode may.
>=20
> This is a problem because it makes it impossible to match reboot modes
> containing any of those characters.
>=20
> For example, this makes it impossible to communicate DM verity errors
> to the boot loader - DM verity errors trigger a reboot with mode
> "dm-verity device corrupted" in drivers/md/dm-verity-target.c and
> devices typically have to take action in that case [1]. Changing this
> string itself is not feasible, see e.g. discussion in [2], but would
> also just cover this one case.
>=20
> Another example is Android, which may use comma in the reboot mode
> string, e.g. as "shutdown,thermal" in [3].
>=20
> The kernel also shouldn't prescribe what characters are allowed inside
> the boot mode string for a user to set. It hasn't done this so far, and
> introducing such a restriction would be an interface break and
> arbitrarily enforce a random new policy.
>=20
> Therefore, update this driver to do another round of string matching,
> after replacing the common characters mentioned above with dash '-', if
> a match hasn't been found without doing said replacement.
> This now allows us to have DT entries of e.g.:
>=20
> =C2=A0=C2=A0=C2=A0 mode-dm-verity-device-corrupted =3D <...>
>=20
> and so on.

Friendly ping. Any thoughts on this?



Cheers,
Andre'


