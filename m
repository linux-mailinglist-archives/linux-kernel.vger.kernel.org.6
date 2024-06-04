Return-Path: <linux-kernel+bounces-200828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2148FB570
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D54EC1F24450
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B10148304;
	Tue,  4 Jun 2024 14:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q78JyIsh"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C93913CA9A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 14:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717511530; cv=none; b=Vaqhwm9N4r3hmir5FVM/04sZHBq9nZrHEOQCIUbt/Zt8SeY5JeucLsMCQrcU7nWbvoMnP4xf0o57If+ICpgfnjgKdKttKjWjEGEYuFckPy9YnunUOgQVle1LJYwkNwDeLpsiGD+M/stkkVFTvRIhO8pBQWFnJPMTG1ZIU8pcvqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717511530; c=relaxed/simple;
	bh=vGp3ovyzZdpRyR1W94NZG7tQypJhWhNwsTCZl5Q5Tek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uHoLW8ynyU7h88NhecJo1EuWxHAl9yFvKCqBmwHsAouxqOMasvXSVro9pHcnd98OY9yhOGyTpkc8hs1MJuVFUI+3KY/OoH68kLQxFC2hlSZ4EO9DvTdT3X0DW66ZXiEJ9tOnPCcVhA2YtrWG+Qm2mX9qQ5MrCBkWK+g7ikCwuY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q78JyIsh; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-44024f5271dso154911cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 07:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717511526; x=1718116326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQpV5dfzXhIlBBaFJofdAT+Rq9XDrHNaF91R1+IyrHc=;
        b=q78JyIsh300QLsOzWB0cIrO5QteKg38itV0Zky9xhQNsMKqT/bJqXtn93le7vXbA2a
         kcBFFRhPsHYoYSlkDwdDNtG9wycigglwu18jp3iUPoQ5uEjYZMV85Jzx1ZhEpRYYWiR9
         7CpT3aDElHqpDOnmIEGdIo7GpuAVHvHqS/CgYVY5Cz4CWU2NfunGG7W+lESaduWARcED
         vqmsIyt+it93mQ9j5/5bj6zaEYha7ZA/EA5oyAvsnJJ9N8A9nAvYXS095DU/IDgfYHcv
         y/U/B7gzeO0fme01F1gn7R+/QwGIl2uHzFkUlbVsJJTDcJyhiyiUPcJBuVulULClM+6E
         h4rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717511526; x=1718116326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MQpV5dfzXhIlBBaFJofdAT+Rq9XDrHNaF91R1+IyrHc=;
        b=Yws2+h311EJfGrdnaewIJOoCcyUIFgZK2bl/lUy4UnzHHblRp8+y67wUO3yY65doDC
         hGttp3UpJ5Zz74eD8q1wRHGQItRG1tavtk3Es36J+HwUsJTZXzBB9gM8zmLRY+UI/9J1
         RuUsCL/jy8nSsYRSWljDLOJT7Ajtba4uSxxInfbNoHiTeeMPzsHISAltggAL1/2a3b50
         4IrexaRewzVXLzOnoK3zwXItB+cjdl0bwLlhCENOcA2oDLHDgaNwUBk5UMes1835XroC
         FkBAw3DVaZujuUmje7MpV5gWK4Mp5JwkDIKQmMIpqFsqRyD1MGXQXYuY/WAdtRIGVB2/
         7aTA==
X-Forwarded-Encrypted: i=1; AJvYcCXYZaXK6UvEu+0CgHlKEyC7l24TeAwYisoHGCQ0ML/1ksY/O6QGffUk7VSP8EkR23RmlyayZF1g2ab6dXmYEpG2ucqV8yqdbgFf29j/
X-Gm-Message-State: AOJu0YwntpSN/ibUQ1iC5RIax7Lufc2U0F9/FZg5ARlz2l+A4NH6HLZD
	L1Wsno1coEDnf1YMqNKp8HN5plzQD57jhaE37WQfn7SPkba20gnCbRAlhwtyZ4C1beiipWWOJ8j
	/iD9jXhH8sRtUO6B+oEodNdaLHHROYa1hP/hm
X-Google-Smtp-Source: AGHT+IGEpedUSaa44exiq+so0jKgv5XcNH+0+P8IoQJ2kUlE8+YPjvD8hE8Ie7JCngfSpIvxHm8sJNewp7aY8fLH1PQ=
X-Received: by 2002:a05:622a:7392:b0:440:1fb0:1726 with SMTP id
 d75a77b69052e-4401fb017d1mr1630971cf.19.1717511526273; Tue, 04 Jun 2024
 07:32:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604060659.1449278-1-quic_kriskura@quicinc.com> <20240604060659.1449278-3-quic_kriskura@quicinc.com>
In-Reply-To: <20240604060659.1449278-3-quic_kriskura@quicinc.com>
From: Doug Anderson <dianders@google.com>
Date: Tue, 4 Jun 2024 07:31:54 -0700
Message-ID: <CAD=FV=VpYVE6hksZiyVTG+9qOZnpdyt45Av5JizeUiOHaVzvjg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: sc7280: Disable SuperSpeed
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
> On SC7280, in host mode, it is observed that stressing out controller
> results in HC died error:
>
>  xhci-hcd.12.auto: xHCI host not responding to stop endpoint command
>  xhci-hcd.12.auto: xHCI host controller not responding, assume dead
>  xhci-hcd.12.auto: HC died; cleaning up
>
> And at this instant only restarting the host mode fixes it. Disable
> SuperSpeed instances in park mode for SC7280 to mitigate this issue.
>
> Reported-by: Doug Anderson <dianders@google.com>
> Cc: <stable@vger.kernel.org>
> Fixes: bb9efa59c665 ("arm64: dts: qcom: sc7280: Add USB related nodes")
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
> Removed RB/TB tag from Doug as commit text was updated.
>
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

