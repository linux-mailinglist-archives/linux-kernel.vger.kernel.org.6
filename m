Return-Path: <linux-kernel+bounces-531816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B286A4456D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A991218964CF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1614188A0C;
	Tue, 25 Feb 2025 16:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jfM037W6"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF6717B502
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740499463; cv=none; b=Gn5Ve/uETRmPq911rw3/knOlsOnE1JAAhLNnaoLkfXQEEtt58ALCWUc5UJ/csFo+tulk5AJBX/tfdt1JHdeFRzzYzWD4dJjSdfX/2+GfoMCB5AKm2iXJrLDgUoOiw54R++ONB2jjfuvLgLGc286gTvhge/51qS1yGpioStBCDuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740499463; c=relaxed/simple;
	bh=ZWUvknXfYYLvFqt4wPTgbskSKIiWK+wf2r8m18E1vnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fd4I+2VDj74q+i9uFKpOISF66LRHU5o8TFfMUmBaIuuAb0HRjN0kqR4rU4AvVAoiZb+mNfmqfMfzP3T1QxApN1L4peSvgmk51QFql/koOrXH/LGQd0dig6w86csjUNb5Dg6KwQtp8PYi8VJfbT+gTa99pbekWpKatbVH+KeJw+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jfM037W6; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5452c29bacfso6267749e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 08:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740499456; x=1741104256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWUvknXfYYLvFqt4wPTgbskSKIiWK+wf2r8m18E1vnc=;
        b=jfM037W6npixrvHkU2dAPgCmCfVgmjgOFuioD0HZVD1MOfJYnZDM9FDrKA9c4NO9/o
         qip1kCOHiU+cXPSCgc+ct0ZpuOqa5iejwTQO0/5YiDrWRHLDg3mdNI/oTfEYwAbQRiFB
         ZbM3Eb8dYV30YYUmJHLU0UhhcdXKWAA9NKLXTO1XN8xz3UxpO6auieacaqnEc0OUQWI8
         YI8KTYdoxbTIs+txMrk6BC0Nd9w4Wl41wnmi4uO+YBS75iL71/Z8SkQjDAQpiXvjkwtY
         319eE2pxYCD+fUR1PecFps0A8NxWBwIkG77sNO8jjKZgMvfLU8ewNZGzEnQ6uT9P9awz
         G6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740499456; x=1741104256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZWUvknXfYYLvFqt4wPTgbskSKIiWK+wf2r8m18E1vnc=;
        b=oDOJmLceXQ/EWzdufWrPDhHunEtTerTNk+lXYVtm5bqQVah8CVjxEqgF7rHLab5+w6
         /S3L5NdAJlV6X4r9rti73hzBgCyzhJkJm6JHImrPpA5SeOU50xDh9C0o26HvBuTVgR58
         1BppWtQeuXoJqQtYWRCq0EiGjYn6bF0TavN+qSM+wkr/f8vIJ3EOb9Ho15ESdNEJHa1H
         jQTi41A6/MJw1fgGFFc5sD6JBYQ4k3rXwlL7ylTpjXxNriOjcRvnrXcqi8/xjf86pUEE
         ipEF60HMUSK+9j+rJ3us+v1pOwVzgp7SrGt4TG0QdHi/L9cP21kS0UFMNjIsbvj3SlWr
         RS5g==
X-Forwarded-Encrypted: i=1; AJvYcCVoV3+UYYMEmv6X2gsOmFTGgzmK3FAmIt8eHdC+ASCYkJUoXAztiyDNK0FtU3gjWyYoPu+99L79BfcebTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqY5YfL6c9EkX49nGr3bjNCR9SbU2pavZ88CkXVlvhGS9xB2sP
	E8Ex6W8TTXgcq2dvZOS5FPf/8cpN98HdsOqTwd6Gi6SlMqf9ekmoptQS+y7IwwqYPO+8J0Ra77N
	DX+yneykgJz7yVWH8bGDUQ7ymzHseGflyFfuTbA==
X-Gm-Gg: ASbGncuOvnGNIKv6nSIqUjoMT+EBJlLZkjphlyAYmXTo2XA9WOie1nrcUTGD5bEFN1h
	hJeHUO6lcytNrplu32Wt4XSu68zUJAFktPcWHEtKMODcPNrEqLEcxkly1HzUvpRWwy/5fPFxgwg
	F/mTgKr/4=
X-Google-Smtp-Source: AGHT+IHNL/Gah3mevPZy4cnB+3l/3UaI9egw81hpQvTsWfBgPed86olYK84spCPWAgNJnWS+LPsg/bk0GhoKPm/zotM=
X-Received: by 2002:a05:6512:3e1b:b0:545:8cb:218d with SMTP id
 2adb3069b0e04-54839268650mr7339170e87.41.1740499456063; Tue, 25 Feb 2025
 08:04:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221180349.1413089-1-vincenzo.frascino@arm.com> <20250221180349.1413089-10-vincenzo.frascino@arm.com>
In-Reply-To: <20250221180349.1413089-10-vincenzo.frascino@arm.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 25 Feb 2025 17:04:05 +0100
X-Gm-Features: AWEUYZmNsEy3fFFOlFl9Mr8FzjBUhEhxzOfrGNxvr7eNpQOWSTLd5B3Z3JZojQY
Message-ID: <CACRpkda2A-3LDM=rbdLO9F=hAnMY02a+_m0hLxp6Rp6dsHWoLQ@mail.gmail.com>
Subject: Re: [PATCH v7 09/10] arm64: dts: morello: Add support for fvp dts
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Russell King <linux@armlinux.org.uk>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Jessica Clarke <jrtc27@jrtc27.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 7:04=E2=80=AFPM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:

> The Morello architecture is an experimental extension to Armv8.2-A,
> which extends the AArch64 state with the principles proposed in
> version 7 of the Capability Hardware Enhanced RISC Instructions
> (CHERI) ISA.
>
> Introduce Morello fvp dts.
>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

