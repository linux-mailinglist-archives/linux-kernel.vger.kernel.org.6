Return-Path: <linux-kernel+bounces-543739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D4BA4D936
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B8AC16C2BB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01A11FC114;
	Tue,  4 Mar 2025 09:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fSRwAdiZ"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F9D1FBEA1
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 09:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741081744; cv=none; b=MzKxOAVYRcTxYwgHPm25C5+1uR7pF9L/E5L71aOjE3U1nPZXEr+xcGDMQwNnYUG0kD/TfuqGmosPjuKejXs6RkLoqWNyivNUuhXfn28Ta3SWhWKmKvC/0K5xzP4xxKkDRwrX7ZNTk9VzbfXhRSJ8md6WAMUbtQN3rKYR0OrWHIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741081744; c=relaxed/simple;
	bh=Y1HtKlWFVpKGR7h2lpoH+TI53NE34azz4clPwR7tMig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jw1hTQ74eJOZhxlOpiZbmBcnbR8F5+OG6OIL+ue7/RctDL8eQRfvQ+0dSbkLGgIzYrPSPOqOiVsC6ovIiJKtosk1C5StMxJok/XsF2i9a8EMjWKOPtlz6bvBrqyHeuyZJ3+jQilJfufaQUr7vVUB50dEpEKqdH8+kfKruiRGawU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fSRwAdiZ; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e53c9035003so4087143276.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 01:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741081741; x=1741686541; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xAFeC7v0K/Wf/c7Ozud0jqrvhCdvL6NyonulbYWM8i4=;
        b=fSRwAdiZJbrQKgUdukYTwDJY5mOT+VfBZbu6sG+K/IlAV8UYQ9p8W3Uemk8A9HCQhI
         yhds8rBoXLvMcEIcSNXQWk+EYR9ibYxiNzeoM8F5RH0VCOM5l29AFgEDDoP7xDTTPxa+
         XYnC93noc8nsoTt/mwNCPiPvl/9r8okvoegNE7k2YlOXxcsS5tSwNr379mY060YqT7gI
         zyLWDaTxzCM1Kxa3cpeAw8NTQGa/BiuIYEpAq1z3oNqHqSUQVC4N3gu5Jc0lnR6JVPIu
         hqGLxIw8mT924F3ku0LKnFBE6V6q9yfoDCDJpL8+1oBbdoCdmnH1n4z6ytCknau9uYMR
         bHEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741081741; x=1741686541;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xAFeC7v0K/Wf/c7Ozud0jqrvhCdvL6NyonulbYWM8i4=;
        b=rRqaReBjskVInubXhQgiCqzmNGbEiV/aVTSDH/4XINVmBVrXKQQNHf+YV0DvTBSZpZ
         wF4btqkStGQQDBms9b1pQsiSxZ43V1XWexcw5iVsuXNfX433yfBuCi4MMXQKwdBtvOfY
         Zb6ar4Ulxa2RXr0NvhMVLzoUJOvDM++tIPiAxNs2toEVxmJKUwKlj9ShM+EgVRUVLnXR
         Q0BDRs/y/LNTYWGLHVj0VJrqaPxsYVaazHYhES6bRXQhjmAEIkGFkWKRzmHYx0JJ8itT
         cR4qHSfasf6Z7P8N9k3s+SGCI9xJ7DAXmB+rl4KwHlfrJYF+7Holmn+MS0EzlfLjOl25
         w/iw==
X-Forwarded-Encrypted: i=1; AJvYcCXJjCeTv0+wzALlX4q6tz4+8IwfiHJeIMo2CsAbsQZbLO4Vycuwy0oKk9FuZ3s153emEou24z+DI5EOt0c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs+b3N6ReQbR7t/zdQWzcSylo5VKfQlqPYzXoOIllQhOgqN5mE
	mwvrhSkbVKDbonZmOqJV157tcpRx21Ij2c+YffH0vZ+KtIaJva8TGI25x8VWtmg8A7eaw5S/UUq
	AOzTPTLTj8pYAAjaVZHA2dVSyx82HlnFzu2SFsw==
X-Gm-Gg: ASbGncuD9wQk/TgTXUFm5LQu+mC0Wd9gajWyDVmhuSMih4cmJR3Ac4jz/xGY5aXEMBr
	IPt0E7YRScgaR13uqnEw5e2JBmKyh2bYYK8b5FSBKa/TWPt9K+JQQjWMQ2VnXkNonRTSdZIJVBy
	wHWLB6u7No07hmj0ISOIBhpIyC
X-Google-Smtp-Source: AGHT+IH/3wcPaD28Oev/VK7lwAdhAYZD7JpdPaR8LyOphfZ0NEOtUEyEWzQ0aF4wOq/ViWPq3UF+ppzxkbbdoIKe3xM=
X-Received: by 2002:a05:6902:1502:b0:e5d:c798:146f with SMTP id
 3f1490d57ef6-e60b2e91f9dmr19189965276.2.1741081741421; Tue, 04 Mar 2025
 01:49:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225121824.3869719-1-quic_amakhija@quicinc.com>
 <20250225121824.3869719-9-quic_amakhija@quicinc.com> <tfd27qk543dt4sqcawogoszsjax3cqxmi6mcy3qd2mwzauedpf@l6xmy5okswrd>
 <5293f723-2a27-4d2a-8939-059226d460c3@quicinc.com>
In-Reply-To: <5293f723-2a27-4d2a-8939-059226d460c3@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 4 Mar 2025 10:48:50 +0100
X-Gm-Features: AQ5f1JruB_dwDjDw-42xWSBYe86aTlm19wISZt5Y85qlOfGWNvQ3_K00_1IWvio
Message-ID: <CAA8EJpoTQ5cg-rM=A3C8-VKbd973vMEKDbrkNFpbB9soCgewzQ@mail.gmail.com>
Subject: Re: [PATCH 08/11] arm64: dts: qcom: sa8775p-ride: enable Display
 serial interface
To: Ayushi Makhija <quic_amakhija@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, robdclark@gmail.com, sean@poorly.run, 
	marijn.suijten@somainline.org, andersson@kernel.org, robh@kernel.org, 
	robh+dt@kernel.org, krzk+dt@kernel.org, konradybcio@kernel.org, 
	conor+dt@kernel.org, andrzej.hajda@intel.com, neil.armstrong@linaro.org, 
	rfoss@kernel.org, Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, 
	jernej.skrabec@gmail.com, quic_abhinavk@quicinc.com, 
	quic_rajeevny@quicinc.com, quic_vproddut@quicinc.com, 
	quic_jesszhan@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Mar 2025 at 10:45, Ayushi Makhija <quic_amakhija@quicinc.com> wrote:
>
> On 2/25/2025 11:25 PM, Dmitry Baryshkov wrote:
> > On Tue, Feb 25, 2025 at 05:48:21PM +0530, Ayushi Makhija wrote:
> >> Enable both DSI to DP bridge ports on SA8775P Ride plaftrom.
> >>
> >> Signed-off-by: Ayushi Makhija <quic_amakhija@quicinc.com>
> >> ---
> >>  arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi | 66 +++++++++++++++++++++-
> >>  1 file changed, 64 insertions(+), 2 deletions(-)
> >
> > Please squash into the previous patch. It doesn't make a lot of sense separately.
> >
> >>
> >> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi b/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
> >> index 151f66512303..02d8a9c2c909 100644
> >> --- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
> >> +++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
> >> @@ -128,6 +128,30 @@ dp1_connector_in: endpoint {
> >>                      };
> >>              };
> >>      };
> >> +
> >> +    dsi0-connector {
> >
> > dpN-connector. It is not DSI.
>
> Hi Dmitry, Konrad
>
> Thanks, for the review.
>
> I will change dsi0-connector -> dp2-connector and dsi1-connector -> dp3-connector respectively.

Why? It's then dp-dsi0-connector. I think the board has DP2 and DP3
(please correct me if I'm wrong). How would you name those if you use
those indices for DSI connectors?

>
> >
> >> +            compatible = "dp-connector";
> >> +            label = "DSI0";
> >
> > Is it an actual label on it?
>
> The label for DSI to DP bridge ports itself on the device is DSI0 and DSI1 respectively.

Ack


-- 
With best wishes
Dmitry

