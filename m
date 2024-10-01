Return-Path: <linux-kernel+bounces-345857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9834A98BBF7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 14:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 496A52849FD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 12:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2081C232C;
	Tue,  1 Oct 2024 12:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PQ2V9UNF"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D130A1BFDE7
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 12:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727785205; cv=none; b=ikBhLhNrL9yacm2KV+Zd1Hhl8+d9yru7SOApUALanNA1Jb8xlmn/lPrpUczNtGuddCTtBcUCz9tqYb2kjrFCkgkRlS4LCyRSQW8jmamJsOXWmU05FN5rzAVQcTG/NcbvwHeRiq1JdbDOI234x0dxt5y56KphlN2vFVvvZqCkVTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727785205; c=relaxed/simple;
	bh=Z8EKtehk1xEe2cpvvzUTJMmi+AHneIFob7zq0Qe/FCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EuQQrbI31XGZ4bxUpm5b2ZXoEPnBvoIpBmjEnYLnb2WRv/9bUaQDUmaBhywfNwJArcxXE7NF8LOOBxp2hKr5kjM4Hva2EmxP69xg9d0OFNlz1OQnG9nr/PZFsZU/ji/i0pLr+ApwZ9GD5RYK6dptlxfptFi3KAedXaHL1dQPIp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PQ2V9UNF; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53994aadb66so2170097e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 05:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727785202; x=1728390002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z8EKtehk1xEe2cpvvzUTJMmi+AHneIFob7zq0Qe/FCY=;
        b=PQ2V9UNFwEyUJ+BID+QKrvYnCqM9nAr+7hH6XZ2uz+vbziVmSSmwag4l2F0rTiU7D0
         1WV921/Y1Qce24sztOjS+lirGPVNWj7EF/9KRSsHce0AcU87Q+fykep037JmQsUiPzk5
         HQmYNeJjjBpucqHr3+mee0F/0cL7wuH1SxenV8Jdp/b+EulCtKRUCCoIKFXaa4P2X0yr
         5NczJykTGRMeieXrPClw6eX6JUwf7KFmN/I6vg+L1ND85i84trvkqMBys7Ri12TprSL2
         fgRIR9QSHEM3h8ccSWNnMzWULu6OQWl8jfCWc5ADl0kEhxPwhnra+2vkIu4K6mQZ2o+x
         y8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727785202; x=1728390002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z8EKtehk1xEe2cpvvzUTJMmi+AHneIFob7zq0Qe/FCY=;
        b=d19Jmolz8NEulranR8067ycoQTBft4sIM/nKV8np4ux0fM5QHLAPoNPG5gMMzjlaF0
         6ifNQH+YhRJmu75GWnr5n7FmO5boCAOsjGwJswEitlywQ6t9pH4tt7gS1+w+W4g4LS+4
         HnHdj41lCbsH7JCxzgttvHCwxwiqnjIrl83Lt2Kll/C14qgiELtGaQ2HJQ297NBqeyTD
         nwacKMo2mLl+0Dl2vrjwWG/p4HevJdZOTdSlFfNQO8TUKJZZLT0CAFPeAQQgJPLaEO5z
         tCRJ8y1uu6qEX7rYOmJSaH8PDuPCYMCCwZgI4KpSS6cCMbNJ1YAAdZP4upOmRjLqU5xv
         f0Qg==
X-Forwarded-Encrypted: i=1; AJvYcCUSTmpQtofgCYu+MvElhDQ7CgROE+NC3Z7xfFsWIYwX8wN9Gp6qrUMjrfidGiD+xsEIHle4qHxGHt//uAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP9sN5Haa832KOWOcoJ/44FgnjyIwzS05jB3zPDe/LTUOVERaG
	WHBa1yxWY2a6gDSORAGLVb/YuGHMPuhaCypBY9JgqjBtXoXJPXygHLmMM6u3gtQZRIKyBGqMnMO
	6CECSQkKr9E8MvlGeV0WUyvik5dp7o5CEsvpKhw==
X-Google-Smtp-Source: AGHT+IGQyoP6qjFmrcn14xtETA1f1cCCbR/mpmwH6czArmHvs0YQk4qj2UOndGVDVGLdK0FAKjVu24mo266PWh7RqOI=
X-Received: by 2002:a05:6512:3994:b0:535:681d:34a4 with SMTP id
 2adb3069b0e04-5389fc348d8mr7248060e87.7.1727785202031; Tue, 01 Oct 2024
 05:20:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927065244.3024604-1-quic_srichara@quicinc.com> <20240927065244.3024604-6-quic_srichara@quicinc.com>
In-Reply-To: <20240927065244.3024604-6-quic_srichara@quicinc.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 1 Oct 2024 14:19:51 +0200
Message-ID: <CACRpkda1iNxpuRjEJNZW9ufNz1TCyVNk2S7cAttB5iCVqQGGww@mail.gmail.com>
Subject: Re: [PATCH V2 5/9] pinctrl: qcom: Introduce IPQ5424 TLMM driver
To: Sricharan R <quic_srichara@quicinc.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, mturquette@baylibre.com, 
	sboyd@kernel.org, ulf.hansson@linaro.org, catalin.marinas@arm.com, 
	p.zabel@pengutronix.de, geert+renesas@glider.be, dmitry.baryshkov@linaro.org, 
	neil.armstrong@linaro.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	quic_varada@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 8:53=E2=80=AFAM Sricharan R <quic_srichara@quicinc.=
com> wrote:

> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>
> The IPQ5424 SoC comes with a TLMM block, like all other Qualcomm
> platforms, so add a driver for it.
>
> Co-developed-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>

Nobody complains about the patch, and it sure looks good to me
so patch applied for v6.13!

Yours,
Linus Walleij

