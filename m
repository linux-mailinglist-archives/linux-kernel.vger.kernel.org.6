Return-Path: <linux-kernel+bounces-195427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AED8D4CD9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 15:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 838631C21C47
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 13:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052BB17D371;
	Thu, 30 May 2024 13:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aBKbPCxq"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D295B1667DC
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 13:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717076084; cv=none; b=pMQ0w2kE3DSgQZv+LhjUx6CEGF6MxWD4DSgviS5XTjwkIX6fm8syBPvbRlhiv8FCFYHugVzz4D7DAzgDR8aH9zUiKiXeM+5polR8SYuXZnmhlW+cYFYK1jxh5Qb4kecQdeIUr8fzYMR09C2rloHgI6tUDKbHS8D0Jc7mqPAWztQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717076084; c=relaxed/simple;
	bh=iEY3TKMBR3VjMOO18gro7lwUoFToxzJsoKmK2rYmRAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SFAK9MuL2DdWZvWC2EQGKi3ChNZ82itYW5NyW8W05mHPDawINiBapAaW/8B8en4qZFLkHF3JY3fn2iHM2W1ZavRUrmivQIJXPn7lMn1MXMyiGwidYqCQrwmc9xWpgmRhuohrJssMoK9rSml4CzK/hhiwQR9KrFznBWsxGsvJTvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aBKbPCxq; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5b9817a135aso466314eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 06:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717076081; x=1717680881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ekpEHUCDsezH1RNk3+5n/lewOHNyOHOYkS0J9gidF8=;
        b=aBKbPCxqHwC2dYJcMPzqWL1Xa+xBizSMYD/GHdED2k8s9cnnuUZr4J+NmrwYiey/gY
         ZE+1TXM0SjfRckd3YiHio0inL2s5vr8BaOm0euzdHcJkfFeIyd71eEnW8h0UrVhrpbSO
         gOS6x11fHogddAcXuJr9AdjmlNtpE4oR8prVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717076081; x=1717680881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ekpEHUCDsezH1RNk3+5n/lewOHNyOHOYkS0J9gidF8=;
        b=mtCb0OvvCf6cWtDGK4RDj9Z3GPm+Q+++VpNjg8SAoyP9P4RYaUVVgtYCokERm14y70
         crYU/fxkc0oYwF1N3ZzLmTvm8ChOsZolUdpPkTDBdkIt2YsahABCntnhe6PHzURqVt9m
         5W23Wm3bwGmEAE8VetriwB5Zyy8Ks+x7cVVaZ9w/doFbLiQJ63kKwC8444uE0H3erCNE
         ivlSp6aGuwxsGEAoMFBPrFGlSBpgNliDK+75aqEqGwz/jeN6AyNdDFq12uqlXO5YFnj1
         YzxwEk8toaQ3RQD0oOs+1CUOxbdpqM12H3EMQWKfAQA/I0CkrZmvZ24HbdNOEamJYcLM
         OeGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfNoL0+agLI5L8wj01Nk9xoM+XLjb/2Ko05lglgwggaOFsi84rCk2I4ARa8wDMVDS7FbbpT+WtP8Zysjqwlc6Yk025x3lDvo8Qa/np
X-Gm-Message-State: AOJu0Yx31hioC/qWdGUN9GPUz4R1oNW4vf7krFIdJIgWL4/jj+AK5LqT
	3Md0gqxeXrN9fOLWONQ1VWvNzCxhXrswts+SzMzSNzhdWn61aqN0i4KCPTzw5hfCMg0cysi+erM
	=
X-Google-Smtp-Source: AGHT+IE9rrE+bCakY8NOUyslRw7XQfER07KnNZww1RwkG7CCqb+rnGZQdrj8K09olHfcVLFTJaAnkQ==
X-Received: by 2002:a05:6358:138f:b0:197:3d6f:ccf6 with SMTP id e5c5f4694b2df-199b938ff39mr269425455d.1.1717076081204;
        Thu, 30 May 2024 06:34:41 -0700 (PDT)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com. [209.85.160.170])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ae127b343esm4285686d6.116.2024.05.30.06.34.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 06:34:40 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-43f87dd6866so363021cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 06:34:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVOQZZ3ImIRm/7BolcYufJxbnJahdL2yo5ejX17SbCKI6gsttrTQGSvI28tZQgbn8OUUhc9c1qlV4qFyQptS2WKZpJYQPr72tpcE3rB
X-Received: by 2002:a05:622a:410c:b0:437:b4d9:ddc6 with SMTP id
 d75a77b69052e-43feb50e3a2mr2651001cf.27.1717076079721; Thu, 30 May 2024
 06:34:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530082556.2960148-1-quic_kriskura@quicinc.com>
In-Reply-To: <20240530082556.2960148-1-quic_kriskura@quicinc.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 30 May 2024 06:34:28 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UhrCKCv5R-LAAugrLXFp=cDcj2=Pp9-N3qk5pk2=sGEg@mail.gmail.com>
Message-ID: <CAD=FV=UhrCKCv5R-LAAugrLXFp=cDcj2=Pp9-N3qk5pk2=sGEg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Disable SS instances in park mode for SC7180/ SC7280
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: cros-qcom-dts-watchers@chromium.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <swboyd@chromium.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matthias Kaehlcke <mka@chromium.org>, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, quic_ppratap@quicinc.com, quic_jackp@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 30, 2024 at 1:26=E2=80=AFAM Krishna Kurapati
<quic_kriskura@quicinc.com> wrote:
>
> When working in host mode, in certain conditions, when the USB
> host controller is stressed, there is a HC died warning that comes up.
> Fix this up by disabling SS instances in park mode for SC7280 and SC7180.
>
> Krishna Kurapati (2):
>   arm64: dts: qcom: sc7180: Disable SS instances in park mode
>   arm64: dts: qcom: sc7280: Disable SS instances in park mode
>
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 1 +
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 1 +
>  2 files changed, 2 insertions(+)

FWIW, the test case I used to reproduce this:

1. Plug in a USB dock w/ Ethernet
2. Plug a USB 3 SD card reader into the dock.
3. Use lsusb -t to confirm both Ethernet and card reader are on USB3.
4. From a shell, run for i in $(seq 5); do dd if=3D/dev/sdb of=3D/dev/null
bs=3D4M; done to read from the card reader.
5. At the same time, stress the Internet. If you've got a very fast
Internet connection then running Google's "Internet speed test" did
it, but I could also reproduce by just running this from a PC
connected to the same network as my DUT: ssh ${DUT} "dd of=3D/dev/null"
< /dev/zero

I would also note that, though I personally reproduced this on sc7180
and sc7280 boards and thus Krishna posted the patch for those boards,
there's no reason to believe that this problem doesn't affect all of
Qualcomm's SoCs. It would be nice if someone at Qualcomm could post a
followup patch fixing this everywhere.

-Doug

