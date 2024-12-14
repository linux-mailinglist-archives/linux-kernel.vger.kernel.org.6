Return-Path: <linux-kernel+bounces-445791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8C19F1B9E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 01:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B917A7A1283
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 00:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BD61CFBC;
	Sat, 14 Dec 2024 00:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T1FDbm/c"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4159C6125
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 00:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734137634; cv=none; b=p0yEJSEoYPUBP286DHbL3hcoeQAkDT++wBnhiRw+PISQNcSudWd7vsx+NHg4z1K699Kq9zEeL8kPfFQHkjavJxzd6KqLFrx7Bz+iC8//LDkWpL3fVGwN35LzfDTC9fJoPgDPFd2TY+ILqUTOPyEHDnNQcS1fKOATalg+XpQa0I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734137634; c=relaxed/simple;
	bh=Q5cd0cjWyJ6Gcpn2MCFi80hTQsy0Q72Z9blKAZtUJPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Msyud0mMJ6DElBnyYNnmTwWrMixgTUm5Rx9hKBnHtK5eLHpteiydkMnPoyCNc7Sw7rstrAs4ED9vRNtwzRIQHpt8xOJTT6jnBBmoyVT2ZRFm7aIo7khePi2CtGVHUcNRvRq/UOPEKQvFVfmoT6D6lW8IoxNNlVX9arN//QvOaXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=T1FDbm/c; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53e399e3310so2678758e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 16:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734137629; x=1734742429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5cd0cjWyJ6Gcpn2MCFi80hTQsy0Q72Z9blKAZtUJPM=;
        b=T1FDbm/ctv7k4GgzFYAq+guLh9azLbQTU3dLgNsEuQleVH5HvvqCBnu5x2VuV/5tcr
         YMZQRvBVGXSPpzAXVuKvKv2tl262QGFwJ05HVjpGdwphtLXhha7FRl+v+V1lhAXvQ2pc
         K66IMd78KccQrir9a13D8vCLbXh5tWAXGP0bQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734137629; x=1734742429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q5cd0cjWyJ6Gcpn2MCFi80hTQsy0Q72Z9blKAZtUJPM=;
        b=XInWNbb+Fg1HIkOf7R+XD+Jdf/vNIHLoIXrsUXNfF+cPdn/xYPVxjCOPVIqXN/wPLa
         D5D55kOffIdJpAwndvQ9gPhOL79z7PkSuDZCn1SZ98/jkNhlEVUP8mkRfiaewX+moN0A
         TkT1oaJQx4qB/e2egqkZdgfoQEXgmU/VtSfj5V18oJF8X1cDT48xXQ6BJtijoSCuuMny
         UAaxZj6g8iOim8NTFmbBs4laHXo1l37qy24aScaGBIkda/L9CrXT3F0KvvJ66oLdlXCC
         86ctG9eoAJMY+jObVtTZnhXmBihA9Hutpz83CwizPePvJuoweBFyjZqQa21OioTIS86M
         ahnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRckVHwTOqke3EqdQzCoI9vo+ygMonCqitQljHV51pVff3Ykafiu4sTIbPp4d1V5eHZQJozOUd8yd5rAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfR0Zj8LelWJyHyCqQDcf1PbBs2CZHv6G3A8df6kxd+LP9UCJg
	tZx1KAcI/SN3GvWWcb1wSkDl48/Au6xqJucSS0UHz6gDP88NEQcJ3cpzYnTYjOst+kTTC0/ToxO
	AbBF8
X-Gm-Gg: ASbGncvQaIcIYEuq2Vomw1XuSlH3RzsLords7/MoiDeI/GgZZCDK/fA8WxhTxhL8y9M
	+HtoKJA8/fejcJYqSqCIHDpTegJTSfILa9USFyeaPec7n1SW9XEd7pzXlZOKOJSiEELnXkIOx9f
	K2RW7eN5zjK90o5SsRGo4/vKQYcl5hr6X6DBSx08hlJIa+6UcOZDMFjIRgb7o1RubMdPqsJcqcJ
	JHz7SjYraql5Jc8rb8FIcRZ87E2Bgeehs2j8RG2SlReP4NdUk84R+w3qHhdWU7WjpAyfth9BzLy
	Zzm0lqqT80BrcwtQ34ZkokYJ
X-Google-Smtp-Source: AGHT+IG7ovMbgAXPr5hkN7viDqsKwldXT3ukF+Tj3ebSizG7XSKFJsFIeIGt+lzhtnQ20rLkc89G7Q==
X-Received: by 2002:a05:6512:220f:b0:540:353a:5b1f with SMTP id 2adb3069b0e04-540857f5581mr1440349e87.0.1734137628988;
        Fri, 13 Dec 2024 16:53:48 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120b9f4f1sm66391e87.24.2024.12.13.16.53.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 16:53:48 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3003c0c43c0so24380111fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 16:53:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUIzNphs9A9JgpGcBKRHVcTPs0UFvf7AQCgd/pWnzaz6Kws62urdF4TNY0Ke/tkCTt0erM3ces8NLAw0Z0=@vger.kernel.org
X-Received: by 2002:a05:6512:3088:b0:540:2111:db71 with SMTP id
 2adb3069b0e04-540905a6fd4mr1322255e87.42.1734137626438; Fri, 13 Dec 2024
 16:53:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209174430.2904353-1-dianders@chromium.org>
 <20241209094310.6.I722621804be859e4ae4b7479ce191c5e3367b37c@changeid> <tx7vtur7yea6ruefrkpkccqptahgmxnsrudwdz5uzcfxnng25b@afrr5bmdk2xa>
In-Reply-To: <tx7vtur7yea6ruefrkpkccqptahgmxnsrudwdz5uzcfxnng25b@afrr5bmdk2xa>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 13 Dec 2024 16:53:34 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XxL=HjA8pgpQjY8AQAkJns3H0BMV8nO9jKUxiuu2vKqA@mail.gmail.com>
X-Gm-Features: AbW1kvYcJpO0sSHq-EaRR9tcdt8oe3PTBnA6qFnauBDoIBqVcERtioVBqqLZdLw
Message-ID: <CAD=FV=XxL=HjA8pgpQjY8AQAkJns3H0BMV8nO9jKUxiuu2vKqA@mail.gmail.com>
Subject: Re: [PATCH 6/6] arm64: errata: Add QCOM_KRYO_6XX_GOLD/PRIME to the spectre_bhb_k32_list
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Julius Werner <jwerner@chromium.org>, 
	Jeffrey Hugo <quic_jhugo@quicinc.com>, Roxana Bradescu <roxabee@google.com>, 
	bjorn.andersson@oss.qualcomm.com, linux-arm-kernel@lists.infradead.org, 
	Trilok Soni <quic_tsoni@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Dec 9, 2024 at 3:09=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Mon, Dec 09, 2024 at 09:43:16AM -0800, Douglas Anderson wrote:
> > Qualcomm Kryo 600-series Gold cores appear to have a derivative of an
> > ARM Cortex A78 / ARM Cortex X1 in them. Since these need Spectre
> > mitigation then the Kyro 600-series Gold/Prime cores also should need
> > Spectre mitigation.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > Yes. I know. This patch DOESN'T COMPILE because
> > MIDR_QCOM_KRYO_6XX_GOLD and MIDR_QCOM_KRYO_6XX_PRIME are not
> > defined. Those value needs to come from Qualcomm or from testing on
> > hardware, which I don't have. Qualcomm needs to chime in to confirm
> > that this Spectre mitigation is correct anyway, though. I'm including
> > this patch so it's obvious that I think these cores also need the
> > mitigation.
>
> SM8350 (Kryo 680) identifies itself as 0x41/0xd44 (Prime), 0x41/0xd41
> (Gold) and 0x41/0xd05 (Silver)

Wow, all standard ARM cores. OK, I guess we can drop this patch too then. N=
ice!


-Doug

