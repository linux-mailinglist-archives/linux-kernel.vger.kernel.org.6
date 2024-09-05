Return-Path: <linux-kernel+bounces-317141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E6796D9EA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 15:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FCAD284EC6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 13:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3734A19C561;
	Thu,  5 Sep 2024 13:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ksjVNwCk"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB8919B5BE
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 13:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725541985; cv=none; b=UxJtK7knodai84ZwbgirrXr4OF6VLuK5Kh0avm7qRU4XMvHtDccgLUpT6YJNeE81QtcSQTUOdLKz4gEhNKrrPOdXT45l+nQGAHjVSQq1Bwn9LuZCax4IzHI3GLph7xllVwDgBcOdJQoEcX5e9R6G2qjRtzN7AAq0nJhhrusPrWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725541985; c=relaxed/simple;
	bh=h+8Hj5/BortzLMQ+9TV7xX2K37XjQFK+vsFCQRMXKNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p20TM9eH7sZUAau1gscYyMSTWed3eTbmQ62A7COKomUzAYZQsv8fBhAmbN381H5Dy+Mhasp4Qe+eCTbfIi83Z08CLBpiFI1hpXaO4ZWT5wtwy5AtKG6g0uCWsbpKGTRfhREiCznmtonPx+4THYvZE4HGulXQD9HwbXWu9yT9vBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ksjVNwCk; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5353cd18c20so895316e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 06:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725541982; x=1726146782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+8Hj5/BortzLMQ+9TV7xX2K37XjQFK+vsFCQRMXKNs=;
        b=ksjVNwCk72mVLyt1ZTygVJeKccjH5swn1QfdYxteyu+Gl0o5sCm055vvcVgV+YWNs7
         l/TG9T9QD5m+jsrjM1wLKz6dXIWXSwArGDTqnjIourTv4QDnUw9l1Mgp54XNTRoHNbJw
         AfbdlX4E6pTd6jrjva6Gx9iC5zMI4lWfeQ7M+f+xSYgB9MTzU1FjPNZ6TCpnR2ZpfNM6
         gn0Unh+GL/ELlhzwVNkIbJOGPDUlLUELgAaGL2sp8EuWLtNe68xz45iPATJ16AsBAfEg
         LZ2HzEqY+7w2BsR/0FB9ZSe6gz2mVmKWy/5fTfU659P5C1DVk6yruk1UKKD8oaSt2VhS
         nnjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725541982; x=1726146782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+8Hj5/BortzLMQ+9TV7xX2K37XjQFK+vsFCQRMXKNs=;
        b=DPpkHr0eOfL07u7QG2mrrfotVXX5cwjJNfI+6Ee6BQAVWkvZn9auKAmPYjTcpA51kQ
         rH+T9tI0K26ui4ifL6LgWO0i9nZkmZUurDQiFSfrrRRYuYQVGyE6QwyUSEONQbVYUHG3
         X862pXeD4Sur24RA7PrNxYHeVQZIWTN6WForvM115Wjg8za0KzWVQIjgkQxUXBekENyk
         BtbmG8UKNpeI40XO6l2ORu3xSSth0jQ5Q071pCtB8B4DB3gn1rjWe0dy+EcaR+Nur4dT
         gl4pYUWfNfIPCmUuHnIe/4nEAT8A7/J6WGEYX0aRApzhn+8nGhdH4RUStAmzIEdvRS0K
         QQKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNI7fBEjWI/H9sFn+5Ku/QMORsFDhtv/ZbPSzOk/FO+XQSFkBe9xL3zRANt66OAqXQuH9s0xmq3umIHhU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe+zTkQ5VRAnJKMz0u0Yer4ef3zLFGj6h7OXaw5ruhbpPFJr/e
	26hgmKH8OhNcEiLGLHuAF2+d4U8LT1QRj59IZloB66EMgRERCCxigvZHJJvYJEtQjeCRzlWrXDy
	Os9IvERiuvNAji0M2zUM80zZ2rCJkJJq5ibm7jQ==
X-Google-Smtp-Source: AGHT+IF8UjyRnNwMIQwUFBStNL5Otb4CgHfjl+otbh8Bbxjlkxb2dHENFDG1TqcbNMU59Ppougnux5HlFis6uf8hRh4=
X-Received: by 2002:a05:6512:3055:b0:530:e323:b1ca with SMTP id
 2adb3069b0e04-53565f20df3mr4744502e87.25.1725541981889; Thu, 05 Sep 2024
 06:13:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902-th1520-pinctrl-v1-0-639bf83ef50a@tenstorrent.com> <20240902-th1520-pinctrl-v1-2-639bf83ef50a@tenstorrent.com>
In-Reply-To: <20240902-th1520-pinctrl-v1-2-639bf83ef50a@tenstorrent.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 5 Sep 2024 15:12:50 +0200
Message-ID: <CACRpkdbZtMcfv8anZZywC_5LoF-8X2dPW9ft489smrw9=hpcSQ@mail.gmail.com>
Subject: Re: [PATCH 2/8] pinctrl: Add driver for the T-Head TH1520 SoC
To: Drew Fustini <dfustini@tenstorrent.com>
Cc: Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	linux-riscv@lists.infradead.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Drew,

thanks for your patch!

On Tue, Sep 3, 2024 at 6:08=E2=80=AFAM Drew Fustini <dfustini@tenstorrent.c=
om> wrote:

> From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
>
> Add pinctrl driver for the T-Head TH1520 RISC-V SoC.
>
> Tested-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> [dfustini: check unit address to identify the pin controller instance]
> Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>

Overall the patch is in merge quality state, I just want the DT
people to tell how we are to handle the groups. I personally
would prefer a custom property over the unit name but let's
see what they say.

Yours,
Linus Walleij

