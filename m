Return-Path: <linux-kernel+bounces-368382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2939A0F3B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 18:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 777F6B21BAB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2340F20F5BF;
	Wed, 16 Oct 2024 16:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lSBC/NJY"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D8654F95
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 16:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729094537; cv=none; b=Zfyrz99g8o6BNpJBf9h+07STCo5pqQmcxw/ydPgoH6/QINWRO+0Nai45NtA4sCoZEcU4oGvOeyI2xnmBU+E6iMrLeVcm2rbdJlFh8IjGG6/CEQgMjds15eIb95N9Cvo0Be3x5vhHWyBR2wNEQPKgS9BjzfEFxpjrReQz9uuM+14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729094537; c=relaxed/simple;
	bh=izfJPuESLdADVyQIKgA65BaWb+dPd/rXtKW7oYvGde0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RLJhDqoEIXr266whIZ1D/R/Liu8Wlj9n2R5G/hdUh1rQhPjY8hIs+J/1JIRhOXHdrjjF2YVsKqzlkeoUHBjIwXBTQ4xUN6IILEbzJLh/rVqLcqPxCkDxOAKSdQoUzer6jd2lyrqQVs2eur++Tt2E8KjGucK68pvW+BNWgMlGKs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lSBC/NJY; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539f76a6f0dso3387022e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 09:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729094533; x=1729699333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUD59f78GtNOAlqBmjuglWzX0LStg1/+Dw/KZ/SMHA4=;
        b=lSBC/NJYhu1mXb4EIhJcUgbjb05G4kgqYouNihyL1ERmgjyOYc6woWimGAhi9pbJNt
         vJL85a2GnlVcLz2Y2hSpwMpjvIkIBkLKtL0LGaB1qzsl47gBNKNnRJfjb2TbubpuxSM+
         UOAcWXayhK+Pdwtfnpnmh/KRd5Dg2bA+x6i3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729094533; x=1729699333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cUD59f78GtNOAlqBmjuglWzX0LStg1/+Dw/KZ/SMHA4=;
        b=HLjh2U2gCSE490d3AY39WiE+Kddcfews/vnsP8kS8GaDnw3IraiE6P8lCQyB9NhzQv
         VZ2TG8/OocE0qAfhPvifv630WKYrz3T3GMJ7TZZXQ0vzJhQQTDlrZwZXEx6lICkwqfo1
         qYybAQfMbxIkjoub9gGK49db4XYTcLE3BALI2LQrAfG0DhYpxCHca+Ev+pNvvcpaVFAk
         3zIBKrKflD0yx+NqZuiENZYAMKUzqcy6tgJ2RBMtc0NRyVnH5IheCW1NfGh89aeWgSJB
         UGncYFmkALe4nD2QPcQ6HA6tsuKnBDPACYeF//sLqhz8n86kLYnO+tKJn3NpLHiZTdxk
         ws3g==
X-Forwarded-Encrypted: i=1; AJvYcCWIB/TUBXDFRm8stF6BaplIzVh3ltRbqvFjoPyWGxH5AcV6pRcF09XF2q1UmCmhcsBtc053oIaAd4nlPdo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcsaEqdELaUCLqCnxWzGpo8+fe1bXCuIcIr+a7VkyiQ1cCD+RL
	QtapLpgZezL4yfphXlG6R/H0Rbwr1NI3ly23y384UrIyyOJ5YnZHufSqjlEKEEuxxeQihxWP/GE
	/7FaG
X-Google-Smtp-Source: AGHT+IEUXVleXKYhl2NpvbZRlW/hcYtK3uSj23x4qHl0hr3l7JfI4BZWJO7Sc9LMIBL0zFYq3X5Q7A==
X-Received: by 2002:a05:6512:31cc:b0:539:f763:789d with SMTP id 2adb3069b0e04-539f7639a28mr6563104e87.43.1729094532917;
        Wed, 16 Oct 2024 09:02:12 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a0001d856sm486700e87.299.2024.10.16.09.02.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 09:02:11 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539f8490856so3842236e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 09:02:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUVTDltHPROzSJUsy0EgzXqqjXSVchTgthQWxk69g0fUlA/a6xFZ77Vvkd/89KIWIySQMNHH/BETd/6fHA=@vger.kernel.org
X-Received: by 2002:a2e:70a:0:b0:2f7:6653:8046 with SMTP id
 38308e7fff4ca-2fb329c2176mr77403341fa.25.1729094531214; Wed, 16 Oct 2024
 09:02:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819073020.3291287-1-quic_sibis@quicinc.com> <CAD=FV=VnQCO+y_wy=KQhK3wGwHGfO0+MQntgoPh78ZygcgNiig@mail.gmail.com>
In-Reply-To: <CAD=FV=VnQCO+y_wy=KQhK3wGwHGfO0+MQntgoPh78ZygcgNiig@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 16 Oct 2024 09:01:57 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UXm59wL3yX5+8-BKt+h+uBqvYKa-+y2kMo7SHdCqnVcg@mail.gmail.com>
Message-ID: <CAD=FV=UXm59wL3yX5+8-BKt+h+uBqvYKa-+y2kMo7SHdCqnVcg@mail.gmail.com>
Subject: Re: [PATCH] remoteproc: qcom_q6v5_mss: Re-order writes to the IMEM region
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: andersson@kernel.org, mathieu.poirier@linaro.org, 
	linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 19, 2024 at 4:40=E2=80=AFPM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Mon, Aug 19, 2024 at 12:30=E2=80=AFAM Sibi Sankar <quic_sibis@quicinc.=
com> wrote:
> >
> > Any write access to the IMEM region when the Q6 is setting up XPU
> > protection on it will result in a XPU violation. Fix this by ensuring
> > IMEM writes related to the MBA post-mortem logs happen before the Q6
> > is brought out of reset.
> >
> > Fixes: 318130cc9362 ("remoteproc: qcom_q6v5_mss: Add MBA log extraction=
 support")
> > Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> > ---
> >  drivers/remoteproc/qcom_q6v5_mss.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
>
> As discussed offlist, this isn't a perfect fix since writes to this
> IMEM could happen by other drivers and those could still cause things
> to go boom if they run in parallel with this driver. That being said:
> * It seems like a more proper fix needs a coordinated effort between a
> device's built-in firmware and the modem firmware. This is difficult /
> near impossible to get done properly.
> * Even if we do a more proper fix, making this change won't hurt.
> * This change will immediately improve things by avoiding the XPU
> violation in the most common case.
>
> I've confirmed that the test case I had where things were going boom
> is fixed. Thus:
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Tested-by: Douglas Anderson <dianders@chromium.org>

Just checking in to see if there's anything else needed for this patch
to land. Thanks! :-)

-Doug

