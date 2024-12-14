Return-Path: <linux-kernel+bounces-445790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAA89F1B9C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 01:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7636B16A2E5
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 00:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7517614012;
	Sat, 14 Dec 2024 00:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DSyIGI9m"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9D36125
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 00:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734137624; cv=none; b=iB4m31TcHQZzZ3os2o/gv1Lmzh6ONP4qRVYWvpM1CvnopSdD1jVYUWjt5xyyfLvzeHbBiSSgYb5/j8PC5qFhMyudg9c3Adg/WzqCaXtCCi2OOwP+TOhPpc8yadIhRah12f1uc6ksCxcpI7m8AFbk/sjiCywwx/rzXmngn7a5uq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734137624; c=relaxed/simple;
	bh=cGPU+ei2UNXPVjxwRtXib9gV3ppcgfLysjVG+R1rZDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P0ZikBdWv2fkGaR+/bPjis5ON7waT8a06+dmk5N8RixcJPZmDjjmkqL8IMap4yYI/15NvXvDKYM5/yyvFEbNWx7wGj/cDEdxR9iIQF347Xvc8M214VyASxRL/tzQ4FUTMG4/sNre0t4Y2kLPWEFA4FbgSDv+Tq2d42U1zx7Bx0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DSyIGI9m; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ffa49f623cso26620391fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 16:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734137619; x=1734742419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cGPU+ei2UNXPVjxwRtXib9gV3ppcgfLysjVG+R1rZDo=;
        b=DSyIGI9mxD0EaklErzzE+VC1RUj2b+fTYgPmXPObnZGYP28SZFWZKKVoudlAHWdUnO
         H5nqtSE/IJlTZs879WFpGZJZiYhhvazLJCBvJmerTK+SK4WGVklTKIj48zJ0KKGpPkAa
         U/FA8fXlZ1RP0dRLtIdItjjkxbHQQZM43QnUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734137619; x=1734742419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cGPU+ei2UNXPVjxwRtXib9gV3ppcgfLysjVG+R1rZDo=;
        b=n0YS8qI7FKFfATR0Fc4aUkD5rL+SDWQFou/fMm/+mEMHdwX5lFdL3CqgGY6X4a/Kmy
         be7oDjnIFOPmr0FJm8rPAfGoKz/trN9cp48K7oYCeBvMMAn1d8Bu2cAOUYM7h/JXjqmp
         oLu5LJ2il9eiB2jaEU+jHd8e3pXmxaJA0YP2iHLVcIX0RzR8y602tOwyYkM1H2Eku1Bn
         qzrQkDwv9/PlHalZ60y1Rx+34+q2QZW7LZowVCYDku3VpPynMmaQy/2HDIx1fmw9Eisv
         37mV/uOh5MfMo08BEctVe0tUaQ9gYv0DC0q8BsfeLiRdMIidTOYx+JP63/ncZggWyqjS
         NLEA==
X-Forwarded-Encrypted: i=1; AJvYcCVIWRa2WM+7aRQSuKeR/3hn8rsoboa86Isi3IADh1w9DToQDjRC9uSTOXZDytD5ia4ejRaaEH3FopbgLys=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj7F+ETvW4lihHLM1D68+M0QJi/qBCXHa2hM4NMlsP8SZZSoOY
	oPvXiR3v8Gn+UsOvkugKapJmX6q7aGWfMejJzIBonlcWtY8cB2tL0YFAVx/mhH+n5CTfoPs4kiH
	IgrOL
X-Gm-Gg: ASbGncvkMPbKiTHqBW9KqOrRdkED0t9hAaIdabfOZ+VsIFdd+6nKlbgE0XMPKeUl0W6
	nj1Gl4FFmvu5mX+Rtkb2xBpA52p6gH0psJLFY0s1sIr5SZ3kMPpH7ObGpcqR6ITGov9cfu9fjz3
	Xq7DdXHGPWPI+FTQ6MU2WaEitYeXD+97S9LKaDXIwAMsXrxRQCJdaC+ucqzyWhuEk40x+mpw/lm
	TlFNRnl30olXUI5IcLFiXg2GCI88COvwsdbA44BrmvyahAtKmah19sDZUFRs16OYLs9ParppX0U
	ndGk8iGPpH2REiYrcXNk
X-Google-Smtp-Source: AGHT+IGkxa5cjjHCx71DQ2Qt3jKeyi/qNdU79hUoeuPzaQEWnO20apLsL+Iqr4SiKjIc9y5QQVPDdQ==
X-Received: by 2002:a2e:b604:0:b0:302:251a:bd04 with SMTP id 38308e7fff4ca-30254438172mr12440061fa.9.1734137619264;
        Fri, 13 Dec 2024 16:53:39 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3034401d546sm731291fa.11.2024.12.13.16.53.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 16:53:37 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54025432becso2274600e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 16:53:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWVDY+RX2+N6CGilpKcoob9M5Q6FZPCu60ult9nRvbxO+ceM6mvsNvkjoqvjWxXR6HAYw4WGB0i3uNDp5A=@vger.kernel.org
X-Received: by 2002:a05:6512:3b90:b0:53e:3a73:d367 with SMTP id
 2adb3069b0e04-5409055de77mr1099342e87.25.1734137617142; Fri, 13 Dec 2024
 16:53:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209174430.2904353-1-dianders@chromium.org>
 <20241209094310.5.I41e227ed809ea607114027209b57d02dc0e98384@changeid> <l5rqbbxn6hktlcxooolkvi5n3arkht6zzhrvdjf6kis322nsup@5hsrak4cgteq>
In-Reply-To: <l5rqbbxn6hktlcxooolkvi5n3arkht6zzhrvdjf6kis322nsup@5hsrak4cgteq>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 13 Dec 2024 16:53:25 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WQf+ig21u316WvQh0DoKsdKAmZgqPn5LB-myDXsJtXig@mail.gmail.com>
X-Gm-Features: AbW1kvYMP3ofEliinmKmD5c4JW-mKQ4nNcdLo-yjvAZoISWzi-Wl91dy2zD3Sw4
Message-ID: <CAD=FV=WQf+ig21u316WvQh0DoKsdKAmZgqPn5LB-myDXsJtXig@mail.gmail.com>
Subject: Re: [PATCH 5/6] arm64: errata: Add QCOM_KRYO_5XX_GOLD to the spectre_bhb_k24_list
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

On Mon, Dec 9, 2024 at 3:07=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Mon, Dec 09, 2024 at 09:43:15AM -0800, Douglas Anderson wrote:
> > Qualcomm Kryo 500-series Gold cores appear to have a derivative of an
> > ARM Cortex A77 in them. Since A77 needs Spectre mitigation then the
> > Kyro 500-series Gold cores also should need Spectre mitigation.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > Yes. I know. This patch DOESN'T COMPILE because
> > MIDR_QCOM_KRYO_5XX_GOLD is not defined. That value needs to come from
> > Qualcomm or from testing on hardware, which I don't have. Qualcomm
> > needs to chime in to confirm that this Spectre mitigation is correct
> > anyway, though. I'm including this patch so it's obvious that I think
> > these cores also need the mitigation.
>
> Kryo 5xx (SM8250) identify themselves as 0x41/0xd0d (Gold, Prime) and
> 0x51/0x805 (Silver)

Interesting. So the Gold/Prime are actually IDing themselves as
straight Cortex A77. The Silver is IDing itself the same as
KRYO_4XX_SILVER. ...so in that sense there's nothing to do here for
those cores.


-Doug

