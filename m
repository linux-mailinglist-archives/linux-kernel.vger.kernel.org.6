Return-Path: <linux-kernel+bounces-366717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EABCE99F907
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 23:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A00251F21330
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45201FBF66;
	Tue, 15 Oct 2024 21:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TEIznJvE"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F341F8185
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 21:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729027487; cv=none; b=h8FQhFa1zavZu6ZkSOSn/tLq36juSe1rsk7BeFMJcVbbU5s8J0MhClRSzfArLfYBzJHYvkki7+sEqpUdJ56tKvNbpzoAU/kLtn6RPIKq+A/f3HrzhuUnapbALp+puyPjVUJ6zzITRPa5ujRAzzGGKGehg3Dnqpl46i7zaJhTgJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729027487; c=relaxed/simple;
	bh=PhjciV57JA1oiSvqUGGOuUTneeyKGywd3NuDYX8iNpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SH4O0zjTNT3xtekDpMklQDbvmYwAMFQN/Tr9PDsJcZkB5pD/UlAJLgW4osTGEYmV+bxgsMiJqvd8GPCvLL2kwt/sqw1g+349J+Auxtixj3+44V1nHPASojtYlBZbrV4pABwi50fKmuqwySj6TDL76LiszEnFXX26wm3kf0piTlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TEIznJvE; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fb5638dd57so22867921fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 14:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729027483; x=1729632283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhjciV57JA1oiSvqUGGOuUTneeyKGywd3NuDYX8iNpU=;
        b=TEIznJvEbx4gyNTZOaUwWNzK9Y7dLvLT3tLiDmxKpCtKzRj7UXtbRMW9bOqpYxFLpM
         emrygGdSKwdcxUDU0IIxRxIKxjcy2lVb2OKRxJtUHxFUx06s8+9X4WE3eQmv4w1OcpTV
         yF5aNSdZzlpYhHvd9vDZTB2tTAwgSWPaAuDx8DnalwHj0OasunTqGmbnomLNu+yllOQs
         sWvVkDJlnPZRtliX9tCPy12NL5b8ZHT2x+e76dtMfJSTqvTUJ7j7BPlyeM6z+ZwkYi2Z
         b7BZqNJGxOLmaue7p1XYZFQ5AQMsAFTOoQbcpbPy0IC1oIm7XKPNg9rOp4cPQMGkCwBu
         Db0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729027483; x=1729632283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PhjciV57JA1oiSvqUGGOuUTneeyKGywd3NuDYX8iNpU=;
        b=LLheY2oW8BlwTLAr7jBZCHVYVY4VNEygPO/Ms2yzqPG7mK2/1ylXdT7mxuJqIHdj/7
         gfQhI3GGocPF4syQN2n74yLSB+nj0ISDaEVDC2rgg6o9Yq1FrB6p7TW7lovfFcopS++2
         wlWb2eDkNIKG7HKX92WI25c+FmmA3cpC5+Zd3SR1LkAPkZqTs+kpdVo6xAjrzYnqz1hd
         usKDTN2ciUOrrRVRzNvJUFqTddvHNi0RC7V6nrpVB9WItJ9WOiPThVPIxh7hszET0Dak
         fybST0byMBh4iUYfw8KJSzPNYestgJZnLnMIAzX8QsMvHlLuZ0Wrmtw0V2L4tsBZy++K
         o+fw==
X-Forwarded-Encrypted: i=1; AJvYcCVvv0+KVBk3krOIGYxJiQa8+SSwhU74F0bpKRRIzRKtG0d86NNNi1eG2TEnq12YqiK7tIHVTmdoAMLM1R4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW+t+Y+RlT2+jePddo6H2McisUTpebYEfcFeVEhRF9C7LHCRlJ
	SKphHnGd0e+CU1XGJBjBlkaqG6Wrhq55anYvuXOSA0rIndOsIkaIBg2bNqZ2Y2uzBTSGghX9zj+
	oTeWKzSdczFOPH7UkQQSoqKIewLGLOujmyd7PZA==
X-Google-Smtp-Source: AGHT+IF1R3ln9ac3U0sfakzsuNbOd+0ROdsV4OC8ZJQYCQZp67tLpSmpVzQ89WN+TtVyocJi0Q1Race8vWOhGwQH26c=
X-Received: by 2002:a2e:4c1a:0:b0:2fb:6198:d230 with SMTP id
 38308e7fff4ca-2fb61b510b1mr9173781fa.18.1729027483126; Tue, 15 Oct 2024
 14:24:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a1a1d062-f3a2-4d05-9836-3b098de9db6d@foss.st.com>
 <Zw5D2aTkkUVOK89g@J2N7QTR9R3> <CACRpkdY79nbBoaHe6ijuyJS9dDduNw_sv1J90pz121YDgCvC3Q@mail.gmail.com>
 <Zw51fhCkmCYrTOeV@J2N7QTR9R3.cambridge.arm.com> <CAMj1kXEcLD3PWd-9osjo9AOe5Jg-NMOmJ8afB_x7VeboueLoeQ@mail.gmail.com>
 <Zw59x0LVS-kvs9Jv@J2N7QTR9R3.cambridge.arm.com> <CAMj1kXEnhHkxywh8TH1i=fmyAR8cXZ8D-rvV43X-N7GpCf2Axw@mail.gmail.com>
 <Zw6Jk74-d0mhR0jx@J2N7QTR9R3.cambridge.arm.com> <CAMj1kXG3bwMGpArYNUm-qMO7PPgb3--wy5kp-3Ks2Uv9M479xg@mail.gmail.com>
 <Zw6X9KQT0-z7r7SY@J2N7QTR9R3.cambridge.arm.com> <CAMj1kXGGmsWs2XpM7zLURjKp67Uz2ePi1pSV1=rPCMgviLVUgw@mail.gmail.com>
 <CACRpkdYjeqaRzz+hBOGGLEAJn5QmFGof2ysQuVNC_+vV49WPRw@mail.gmail.com>
In-Reply-To: <CACRpkdYjeqaRzz+hBOGGLEAJn5QmFGof2ysQuVNC_+vV49WPRw@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 15 Oct 2024 23:24:31 +0200
Message-ID: <CACRpkdaTfrAwd8yzZLZHfuu7SB0pUTHZ9kUJq+2c2C8RSqpN9w@mail.gmail.com>
Subject: Re: Crash on armv7-a using KASAN
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Clement LE GOFFIC <clement.legoffic@foss.st.com>, 
	Russell King <linux@armlinux.org.uk>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Kees Cook <kees@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Mark Brown <broonie@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	Antonio Borneo <antonio.borneo@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 10:55=E2=80=AFPM Linus Walleij <linus.walleij@linar=
o.org> wrote:
> On Tue, Oct 15, 2024 at 7:28=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> =
wrote:
>
> > > From a superficial look, it sounds like it should be possible to exte=
nd
> > > that to also handle the KASAN shadow of the vmalloc area (which
> > > __check_vmalloc_seq() currently doesn't copy), but I'm not sure of
> > > exactly when we initialise the shadow for a vmalloc allocation relati=
ve
> > > to updating vmalloc_seq.
> >
> > Indeed. It appears both vmalloc_seq() and arch_sync_kernel_mappings()
> > need to take the vmalloc shadow into account specifically.
>
> I'm trying to look into that.

I fixed that too and now the KASAN is stabilized. I'll send out the
patches so we get something to test.

Yours,
Linus Walleij

