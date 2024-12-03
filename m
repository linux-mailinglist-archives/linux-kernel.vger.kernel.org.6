Return-Path: <linux-kernel+bounces-428806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 238439E13C4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 08:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBB931643F5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 07:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FEF418A6B5;
	Tue,  3 Dec 2024 07:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qDMG7BJ8"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38488188701
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 07:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733209972; cv=none; b=YQQW3J5iVoPqLXHoTT/tRESt9Tt9VUvt7w+QgYwomxbbQxEXV70sndR4pArkXrXoWkAflN80o3sw71A5EFl1YzVYuV+1AUcfeJE3Oh0DmeWONXY924ec/fCOpvEIF5CLen0gCL/r1GBGyCe9rYX+Ix3QiyY6uPaYFJYldzIRmOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733209972; c=relaxed/simple;
	bh=EVBM5qoQmU3xuxiwaVTztbikwXOSdVscc5nB635UeFk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T1kgusUrfl9l3lFSQCT9pZnlbXSE3oUlqvW5MFgzViswVdlcOiCu/BtrV+lIN40GPYhtwgQyhBF7rTM9qnBM6K/4khZKsfduUzJeMASr1WXZc2dC3DzNrw6RtQmehdYfHmeMM9xNXpQ7i5j62sHeQUWVDBLsRqRacvI0fzBWwxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qDMG7BJ8; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-434a90fed23so43033895e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 23:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733209968; x=1733814768; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EVBM5qoQmU3xuxiwaVTztbikwXOSdVscc5nB635UeFk=;
        b=qDMG7BJ81Lf/g9f1GghHh7MzczQegiRSoRy7y6fp4ppq0iDNaCpXGgIhmJrtUaVfMd
         QSkx9LYCNcS3+UsmkVo11zXTf6Gm80uofi2ZPSzYg5EmJ47IZ6GzDuBR6rGw1ABVP6Et
         /biKtlYuoVdh3U0+qfeDt3A7BkX5nkJKF4I1cV84UZAqmFuLmFJLjR9+FUsi5pZNw043
         cVF50/JTLOqj3kMxI2oTs8VdYXBwzV7DifO6ytf9i9rjjhK1YolfCn+Ym8NDKCwdAYXH
         NdCvO4RhIXlCtksCcOU4dJ4ozHAMvzVS0SUI6W+JG2n1ZTBjArh8JIU/5pkOL4ZcA8nH
         NjIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733209968; x=1733814768;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EVBM5qoQmU3xuxiwaVTztbikwXOSdVscc5nB635UeFk=;
        b=e2T6+Bu8X6ZKiJq0GSX+iWdxHsybJvU3A8yy2FKKtODg8E0IRWLNxVgURCM9cR49xR
         dJsolUevW8TlZlksIz1KfLNTDo0+2Qk+p+eKygkEZYdQhw5dX7H4rI9qjZDfprzIg5+3
         Jqg9HakwFa5sJjAIM5Yq3mzA+uJmpy9V21lPN+lOWNXvDeKjbkDfrKCYXPDNAFHRYa6B
         /9TPLXW6nX7vwKe+aISx9q4bYRuFPhFoNG0iigT1WBvttZVrsKiKJmxDnjWQ61/SOw8o
         w2ayWO+WXxFa6ai9s9aba3PWOJyMeSf/K60vTbhECT5LiES7pAoKxqv8lJDI3Tnz9Y11
         fvUg==
X-Forwarded-Encrypted: i=1; AJvYcCWIDvcEe6ZfjQeTvJzQZJS55nvvS4o0BUoe0Ok9B5Gmm4dUQP0kesyMZkpbY6HlslGJX5RxflijSkqmAU0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm2fF+wpAjg2gO1OgkWHba1mLFTd2uLPvcO2v6uUsiVND10xNx
	7riZAtO4UGywosBarfHudVWWe7qo1mQpbmYKIh1rhbuR7eeavgd9Gzo5kA3w+HY=
X-Gm-Gg: ASbGncsQvRjvqhb1UrpVf7Me3xLZtnuIz/Ni9Jmo/YlSjugr7TQZJhyrnWOVMwIVjnr
	2fZsfhybBOvpO/U782YOybKDfVFzt1RhjLTTwKZ++oET+weVT3eZMua+KgWbhStnoCL0uVgWW8a
	pkvzqpjDzQ0FlRNRdYsEb9e29uSvHPunRjtqbQ1V0/nXdQACT9HzZD1Zsc5FNbZ3CGUvXBIlZBl
	m7YDTtC7sx/vhIKeNYm2vzgPlkeMFsJelYaVVYoa6vag/1VPD5KA6w=
X-Google-Smtp-Source: AGHT+IEplB7jYEBVeBsm9qKzYjb6Q/52WlhBD/Tf3x0VCfolLamrC+TuTTucz1KuLRGPu4rrqQllDQ==
X-Received: by 2002:a05:6000:1fa7:b0:382:51ae:7569 with SMTP id ffacd0b85a97d-385fd3e8f28mr1191117f8f.18.1733209968624;
        Mon, 02 Dec 2024 23:12:48 -0800 (PST)
Received: from [10.1.1.109] ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e2c84d52sm9859752f8f.49.2024.12.02.23.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 23:12:48 -0800 (PST)
Message-ID: <e23721ebd766f410103ddfb8705f3d7d6e5ae3e9.camel@linaro.org>
Subject: Re: [PATCH 2/4] dt-bindings: power: supply: add max77759-fg flavor
 and don't require nvme address
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: t.antoine@uclouvain.be, Sebastian Reichel <sre@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Peter
 Griffin <peter.griffin@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org
Date: Tue, 03 Dec 2024 07:12:47 +0000
In-Reply-To: <20241202-b4-gs101_max77759_fg-v1-2-98d2fa7bfe30@uclouvain.be>
References: <20241202-b4-gs101_max77759_fg-v1-0-98d2fa7bfe30@uclouvain.be>
	 <20241202-b4-gs101_max77759_fg-v1-2-98d2fa7bfe30@uclouvain.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1-4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-12-02 at 14:07 +0100, Thomas Antoine via B4 Relay wrote:
> From: Thomas Antoine <t.antoine@uclouvain.be>
>=20
> As the Maxim max77759 fuel gauge has no non-volatile memory slave address=
,
> make it non-obligatory. Except for this, the max77759 seems to behave the
> same as the max1720x.

What about the battery characterization tables? Aren't they needed for
correct reporting?

Cheers,
Andre'


