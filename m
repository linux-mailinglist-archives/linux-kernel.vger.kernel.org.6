Return-Path: <linux-kernel+bounces-531755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E840A44474
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8C12188C37A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B007DA73;
	Tue, 25 Feb 2025 15:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iZm9//JQ"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3189328F1
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 15:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740497497; cv=none; b=qsUEsZ9uIz/rov/rhCAc4PPqBxNVYM7Zr7mN6PgvEblDgymVds3P8JZpR4AeGtz4fOhiZkLH6Vwf75xW8cbZ3UL5f10lDK09+lA6VVHSoU5KbGUfIn6rkIrzFi13sXuEXZ7QI/crU8vWSnC2EuX/jgsRzeImmbnBJrDh1pKdfvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740497497; c=relaxed/simple;
	bh=roYBOgtGzUsHXQBIXuQZWu8SiQnbw21Lb6vf9yQV4wQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VnftosX2iapj0NOZ3PiknxSF0HPE41++oim9Dl9F4NHJ0AtWDCW1Y8/Dvbzrksau4PaURM38LVSy25YIQM0JsE/v+34cohb0IRZiFjzcBPizye7cue6La8OYJt/rWNvaA3MzI+yiV92wxS1VvHO2J4lqquaX8d5EjmJ1XO3UU5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iZm9//JQ; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5461dab4bfdso6848421e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 07:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740497494; x=1741102294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=roYBOgtGzUsHXQBIXuQZWu8SiQnbw21Lb6vf9yQV4wQ=;
        b=iZm9//JQfWw7/jrj02IvkwUqJnMEEHNE/PwqYYiQlDrjL5t43xGOZIu1SlC47T42dp
         UPlUHMuC3dOeNVm9RevcrxKBlESh+fpBxEpmo4KSx1/hNtd6pWcdEp8WubA0ULkBOXfT
         pddqkgFVZBseb9Ihb79eJrRJAxjnUquuIJ5QDh2EW4yqck/en33jkDl0WLyUJ6qC4mHX
         JMuFIjpF4zwH0bnaOSuD2quRZqlQ6yTyEtDWSxwxrW6a+89nwflOZa9s+e7VYlIZKF8o
         cS6liMUz4Nj0TTtinhWwSnOtmQPgH8tFlgAYJy82McL+OtGhXVVeWwNiYfAyY6mLsR6N
         vvvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740497494; x=1741102294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=roYBOgtGzUsHXQBIXuQZWu8SiQnbw21Lb6vf9yQV4wQ=;
        b=v+lKh6ASRzwThZqI3se4psdEASTiXYh/VoBVW6On1xzClH1WNJheEyMdZIuTtAloTl
         UnQfxvx67ASlJaELHgM2RLH0PTM7lkwqu2Cpd/yr1Z5Tzz+ziLq2wXzfcvm3PWiFzHOs
         IHXsK46a+pd+M0SujlD94hKzpZO1fx5ERs8ixyilVSCarddwwbt40+ObKKjPuYfVY0BQ
         Z88/5lfU5ruUaD6FNEoSTkkABbh90W4nYVM/esrXAr3iRa5jOelHCjN6Iu0J9JlOtSHg
         QxhFeULdehpYSPqSmolKBb5ZMz/MrnsvTl3nSgBoS9tSEy4r92EverXAbgxx9WEg+WJQ
         w+jw==
X-Forwarded-Encrypted: i=1; AJvYcCXPPxl2GpyS6pXhm1bK0Qs9CQcgbuaxse9xM9p7tHAlpsUb1Y1kSP8vEvEAS1P6dlsHEBTn32eCtJUYvsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyITlZIWUlSPq+8AWtju03RZvdD+St5y//9vGAyrRJdd3CMaKe1
	/h7ZZbw0B0X0ZrDQ8rjjf4SAOw7Ity5RlhvfQ8vxVOB7F7xPbSsfBUdpX0q7T2+SPJBI3px8Hpe
	vPsNCq5qSsx7IcGFj17uMDKJSEIyLBsB4NQgg2w==
X-Gm-Gg: ASbGncu6w+ugiYiuk/S6R9quGRqk6LI1Z1SC4fPzPaIVaLo2o9jgwYTFRjBDtaiOK+7
	Jizms7sTnjwsDpgCH68zmBEjXabt5KANfyKz53G2OSzxjerCq3hlGAIsE+4Uc1cc4sWK7hWqn9j
	+ufmyYoxk=
X-Google-Smtp-Source: AGHT+IEv8sW5Rf4zOcIAVA9dNYgFhkXoWsDkuqwaPaAQjPElrDg/4tWrxkT/p9rUgTIhAQZij4qx9JhUQwq8UCvtKdQ=
X-Received: by 2002:a05:6512:280b:b0:545:bb6:8e41 with SMTP id
 2adb3069b0e04-54838f5b913mr7041479e87.52.1740497494049; Tue, 25 Feb 2025
 07:31:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220180427.3382482-1-vincenzo.frascino@arm.com> <20250220180427.3382482-10-vincenzo.frascino@arm.com>
In-Reply-To: <20250220180427.3382482-10-vincenzo.frascino@arm.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 25 Feb 2025 16:31:22 +0100
X-Gm-Features: AWEUYZkE0B0UpjmJyEFbrAVTIFpOAVWVgLL9JuguQEW4Mtoe1czJXzaBv81bD3s
Message-ID: <CACRpkdbZmQxtVqtc=Fw6kiOe3NdEE2mBHr2rKXLP76U7Dguhgg@mail.gmail.com>
Subject: Re: [PATCH v6 09/10] arm64: dts: morello: Add support for fvp dts
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

On Thu, Feb 20, 2025 at 7:05=E2=80=AFPM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:

> The Morello architecture is an experimental extension to Armv8.2-A,
> which extends the AArch64 state with the principles proposed in
> version 7 of the Capability Hardware Enhanced RISC Instructions
> (CHERI) ISA.
>
> Introduce Morello fvp dts.
>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

This one has the PL110 graphics as well, right? (To be added
later, just asking.)

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

