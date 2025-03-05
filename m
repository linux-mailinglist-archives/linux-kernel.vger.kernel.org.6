Return-Path: <linux-kernel+bounces-547860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9A2A50E71
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E5F63A9170
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 22:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB81266561;
	Wed,  5 Mar 2025 22:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKzBhBHP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046541FF61B;
	Wed,  5 Mar 2025 22:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741213200; cv=none; b=KShGVrJGhrIPCyFyp6Nq/VS+PrESMMz3yZm4wIBLZeXk9b4+YcyfEQW4UY0BgtwD9Z37dVh5ISOd1oQW/PvdGzp8vG5hscPrHnhD0Rg/s40JyZMLPUq3YLK9LqrES6T8FmUYuwq4f/UqEp9P8VopsNdh6W49scr/xk9op0w9Xkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741213200; c=relaxed/simple;
	bh=odGwjXPuLoI3+Jrcw4b7Ov4gl4KEsYLb21Fg97K0Pb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hgjk/vawnh6zdkRoRN/wS098uJVQTDzR1AVy+VF6Ahwmnh8wFdJ40ucYwAk8qutMnxjG+u68qA3KM5HYH6P0rJFpvgFrQjsnAEWBQIATCNw1KmMr5QGlbizDwv09ctgs8fPECM7wcCLUlxPgdZ8ELI3PlhLhtbUNn8dnA2ntNL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKzBhBHP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D09FEC4CEE7;
	Wed,  5 Mar 2025 22:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741213199;
	bh=odGwjXPuLoI3+Jrcw4b7Ov4gl4KEsYLb21Fg97K0Pb0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bKzBhBHPDCKuhVEaReaQ76MMsX2G1SX6D/bEE6l0Z2qcbL9g+m8ImZLln3Z02uP7H
	 iQqyRHRtaCWtcg0HBo95FpeZ+F3G6yr35SrcUT2ZLRHt8PTRrzIGBdY0WT/wbt/mEd
	 jvhBbaBx5xc1kZLmU+PCHnsngL1rKm5KkpSGkTrBPbmxqlJVSL024qhcSeG/q+iAIA
	 2w7669UcigcbOGvIbi2rsSnBItY2MDB8B9uujNF4gZU0YxuylU/2HcJbiURsRxusd6
	 +fSV2SaFb3BmOwp+qsn3CKmtxNgaC/RrUW61PdmmFVFb5snhFHSafDfFAaE9UMjKo8
	 8HGukhVwTdq1g==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e4b410e48bso10998539a12.0;
        Wed, 05 Mar 2025 14:19:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUrbplXnsu5/x5ZbTq3Y1uRsxXA5knNUjBgFsnzsIKhORWRAKviHVWmtgvwUbCuQcBLDxONqfL0CdLBCdBu@vger.kernel.org, AJvYcCWDFnS9QyYd5t6Lyl4jTpWrvtThXmSB+t/7yC48Xle2Gm+WKl1GMbuH0HPbSwIjETUQ7zBvLkKVASpO@vger.kernel.org
X-Gm-Message-State: AOJu0YybsvL+SH0PCsD3SafoRuD79eZpa7rReBz6wBad5kSjhOK3sgm8
	kkHoi0odJuYa9U+Ye/5Ese+5MzX8l2aiuJbizR13U/NiaLazgyDyDTrep+XCu/Wov0jt24EJERl
	L1H9B77lNTPDsA1Bw8kkKJvg53Q==
X-Google-Smtp-Source: AGHT+IGmcbRnsKh4qmTIrjjZnvbSUllEyKfAIMmiWB3ZMYddCqtDRqGxn1VMbXWC0I5eXo67K8lElFHwxeHn8Rragx0=
X-Received: by 2002:a05:6402:1ece:b0:5e4:d75a:573e with SMTP id
 4fb4d7f45d1cf-5e59f4f8e28mr4935569a12.32.1741213198291; Wed, 05 Mar 2025
 14:19:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305140009.2485859-1-amadeus@jmu.edu.cn>
In-Reply-To: <20250305140009.2485859-1-amadeus@jmu.edu.cn>
From: Rob Herring <robh@kernel.org>
Date: Wed, 5 Mar 2025 16:19:46 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJgjD69wtJJfLuvBQ4g+JprxQ9mKGPWGgY1dmziehe-Kw@mail.gmail.com>
X-Gm-Features: AQ5f1JoAojNhKXJ10NzfyCQO9G1rFeCcWSk_-mw-M74iUoDe9bMGrTl0QURdgE0
Message-ID: <CAL_JsqJgjD69wtJJfLuvBQ4g+JprxQ9mKGPWGgY1dmziehe-Kw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: mfd: syscon: Add rk3528 QoS register compatible
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Yao Zi <ziyao@disroot.org>, Lee Jones <lee@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 8:00=E2=80=AFAM Chukun Pan <amadeus@jmu.edu.cn> wrot=
e:
>
> Document rk3528 compatible for QoS registers.
>
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Document=
ation/devicetree/bindings/mfd/syscon.yaml
> index 4d67ff26d445..fcfd293b9bf1 100644
> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> @@ -103,6 +103,7 @@ select:
>            - rockchip,rk3288-qos
>            - rockchip,rk3368-qos
>            - rockchip,rk3399-qos
> +          - rockchip,rk3528-qos

There's 2 spots you have to add this.

>            - rockchip,rk3562-qos
>            - rockchip,rk3568-qos
>            - rockchip,rk3576-qos
> --
> 2.25.1
>

