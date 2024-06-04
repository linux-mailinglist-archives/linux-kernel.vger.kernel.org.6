Return-Path: <linux-kernel+bounces-200825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 386DE8FB569
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE6DC2843D6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A527C145A1F;
	Tue,  4 Jun 2024 14:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p/Eygaex"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AB4144D22
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 14:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717511514; cv=none; b=htdRO8NX3IoWZbzGBDxo7mHsi/xlxU5M34R6OrAPcwyOuqV+lJp+iLUlfyi2Q/hil0XJ8GNpbb0SJq3wzJuCcABxm292X77EvpxCOKtGjLQYwIFJevSTwggdQjdb1XeWJTVPm6gGMqgEmY9CbM1ISrEgzPmjGFLJP7MOEjb1lJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717511514; c=relaxed/simple;
	bh=gGDKWu3B5VRRZlu7zBNJnku5j12cvC/da0ucF6mg0aE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ga/4T1ywOcQhGZC5R7meI1QyBPpKnh2o4JA/dv3sPi1UspRr3bvFFNoqKWynOneCpDM6P/2ZFz1v3M5xzi86fFysGT+xdMekX+2u+VYuO++souo5k8jmqYZV+Mm8RBSpkc+vqYrqtq0j9wTIS+Iv/OEDF6Nb6ngpY0n0aLMe/KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p/Eygaex; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-43dfe020675so355841cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 07:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717511512; x=1718116312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8l00WT5M+hkw2d4NnjSJbqOkW1RZzStGuA1CvK2sUM=;
        b=p/EygaexJi7LiNUYm14Ga7G/St6vgZsjA1Cb63va3SQhJc/tb41xAgPHSjkhe0nATs
         ZQ4NvaSkYer9B/COM8Buefb9bTtzQLdPKZD/NGgra8FFvvcmSafjPJqZS5jCtcQV8A8f
         mwBHemakOoFwylGIUl4JcFjUjRQDhfdgn3g7ueSOVHndqGfm6Xg+iRV5z6JGapYkqckn
         F8Y+D1YFv1jtFGafYI2NxQb9BRpc6CAVBq9TWhU2mPrUVVHhw805+/ZNd+zFgRQb+Hv5
         7u85aQ//pfdjbuNdC+5yDiiqK9wPwyK+WbOXgsT41UQtgWfnmsODkZ4gEjUL2Yz2LdxD
         f7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717511512; x=1718116312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w8l00WT5M+hkw2d4NnjSJbqOkW1RZzStGuA1CvK2sUM=;
        b=DCCcMj4bCaLixsZTkgtuqmmjKX2iegPQLyHvK+fypyjarFk5pc0Pp5lQfrxI59NuQH
         TFR/TIOuj0GoSFKwTp2GwrumALjzOesFFTZiaCHOLpRl+B2Nj4ZGFtqNoP4YXFHudBw1
         XcJ2nk0neRUwUbKNRIoQah/r9KY4g0N+No7fjQJLDtgwGA4E6RSI2QyT0UOO+RUhQKhb
         WmMT/BOxcKxuCbzMTU3Ogd+dqMgUQ4WQ44YbtV5dVjkCIh3cv60Hn3aiTZDN+IC++C62
         r5KhjZAlG9qxZUjOaXeAe1oBnRX2ZyG7priY34ifV24kYtlA5CNwFkKtcjew5sg2YgQC
         yOHw==
X-Forwarded-Encrypted: i=1; AJvYcCWQsjqsazQxrx5FMs2NxUriOHIOeFiOlhePgpFvZ7ma93UNCaoSjXh4toQLArPFOKvlTMKXIebz9Xti1ZvvE5eXTtI6wEs2QSkef0EX
X-Gm-Message-State: AOJu0Yy/l6b8Jkvbg/V4j0/glOE7xWSW5K4FRSH/xq28QEGOXzAqlm1u
	H2nDE9SHooY4W8WqXLYWF5uldWWAa6PZIIvdbeBwwbuu6n5VtTh5S62Db+K9v5nUixVEOn3BaQI
	6oePqBgzQcXUicKNpUJXYFVsJKLkx079fOAem
X-Google-Smtp-Source: AGHT+IH/O61+QNBbKWIt4c3u1Z1AJi93HK8DE8/RW5ricyD3nsufx056k6EOeUUTHgwQelBTxwPZMgXy8F51jYSIh54=
X-Received: by 2002:a05:622a:6116:b0:43a:db0c:ed9c with SMTP id
 d75a77b69052e-4401e63ced6mr2558031cf.15.1717511512081; Tue, 04 Jun 2024
 07:31:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604060659.1449278-1-quic_kriskura@quicinc.com> <20240604060659.1449278-2-quic_kriskura@quicinc.com>
In-Reply-To: <20240604060659.1449278-2-quic_kriskura@quicinc.com>
From: Doug Anderson <dianders@google.com>
Date: Tue, 4 Jun 2024 07:31:35 -0700
Message-ID: <CAD=FV=XKKtd3vArUzo+5_o17Prm-G5_tLBCzv+5q3gp_UfR8gQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm64: dts: qcom: sc7180: Disable SuperSpeed
 instances in park mode
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: cros-qcom-dts-watchers@chromium.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <swboyd@chromium.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matthias Kaehlcke <mka@chromium.org>, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, quic_ppratap@quicinc.com, quic_jackp@quicinc.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 3, 2024 at 11:07=E2=80=AFPM Krishna Kurapati
<quic_kriskura@quicinc.com> wrote:
>
> On SC7180, in host mode, it is observed that stressing out controller
> results in HC died error:
>
>  xhci-hcd.12.auto: xHCI host not responding to stop endpoint command
>  xhci-hcd.12.auto: xHCI host controller not responding, assume dead
>  xhci-hcd.12.auto: HC died; cleaning up
>
> And at this instant only restarting the host mode fixes it. Disable
> SuperSpeed instances in park mode for SC7180 to mitigate this issue.
>
> Reported-by: Doug Anderson <dianders@google.com>
> Cc: <stable@vger.kernel.org>
> Fixes: 0b766e7fe5a2 ("arm64: dts: qcom: sc7180: Add USB related nodes")
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
> Removed RB/TB tag from Doug as commit text was updated.

It was a minor change so you could have kept my tags (especially the
Tested-by, which isn't affected by the commit text), but in any case:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>

