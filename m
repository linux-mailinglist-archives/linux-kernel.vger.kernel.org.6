Return-Path: <linux-kernel+bounces-307320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AF6964BC2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 075891C22922
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3506A1B580C;
	Thu, 29 Aug 2024 16:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mraA67B5"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5F71B3737
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 16:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724949249; cv=none; b=VTwWcyJcF5WmFA2d0bZHBIevQpY5q27yYw8w6E2tqtpx9yh3vjR/S+g7m3NXurrmxs5NzDv5znrXCkfN8Msri+07J0thbO/OUvcVjzGvyyRIqQewiu3HBx5+R8B7gn8L1tAzsryN/GJwr242Bn9Y64gf4JL5P5yDnuT9jjTWt3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724949249; c=relaxed/simple;
	bh=f9ggnbaNx6g7QkKhE0uWKvaLNCn+0nMqKl1EdSDlrko=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EsA5CIWIPS9UCiRKSaIuTsYhtTW0oDHt8om3O5o7N8M/38MSPpAs/ZIFmb6tyHfspumlegmN1vQfRM7IRgXKdEMc/vzy3gOYRMrS0fd/DS3QLAR9S98tnQF24kmj4TecB1oDJj/h0E6FcSEr7aF+rdXGLsTRbw06LecRR1nO1lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mraA67B5; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dff1ccdc17bso994723276.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 09:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724949247; x=1725554047; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pRtM4U4oM4flFzKh5LtNwM6RZHqWXvQpSJa0+3EzZV8=;
        b=mraA67B5KEbmdGdQpC5K14X56XzO2OBQc66GU2oiZsJ9/bMnWegyeXrnw7Zv/JBBYd
         Ex/444xCk3UDvP7GZaR8Re1s6Ks1Xk6HajfupiveOZYZ+V0A3YYT79/6s5dHI6G4c6H8
         4MbV4lLbO5qo8vmK7/WlCmBEIqVv+c8GBnbfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724949247; x=1725554047;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pRtM4U4oM4flFzKh5LtNwM6RZHqWXvQpSJa0+3EzZV8=;
        b=cDGJ1XAmjJ4r2NDIgCPyPYi1zucMWu6TrGhorY5oa7SLKiqSKgpKKyIve5gckgZ1Z3
         Do7RQidxh0gZLN4y0o5VhNjoBXE0brzUH2VwGEqEyRKWmxsQ6enkm536CLk9cE5tSUfO
         SAJy1BpHOInu0jaBI/h48lRIBepdFp3CWdRbIbg/ia+lSZ3a5oSZeI3dGX6oS6NIvZl4
         E9CYothBcM7CjdxLCf+cOpx4sb5j9DnmTqHhm4Jsg4LBSNgKIjwAjZqNe6BNI7RFOqVS
         we7Gfvh1KroAm5PWQv91HEjrLOWInI5TK1TeR2M1L12dAL9+YKtSlJPRILpyXMqtsYfp
         GzmA==
X-Gm-Message-State: AOJu0Yz1QB9nir7d3SjHuuDIZ2U/RJBPbwD/7NgtqLiWZdJScdYlGNGt
	hc2Tfw78qoUJf1195ffiG/TVM8WNGNo1oTKn2fVQ6OnnxoZklsbKn4o/h29yfsMoWUnuuowQ+Fp
	fqz0bWDbqQpJvkW1UK5/Q9b6o8RHajUoNSutJ
X-Google-Smtp-Source: AGHT+IFdgoh+wmsAD4IyiGquH5DZqMo6QnoVdZGml88Zv9QvUTnxFAeUkWxpW+y2lOckQ5m2pUWWUdo0OYOdQx3Ns8o=
X-Received: by 2002:a05:6902:2b08:b0:e16:6c41:1601 with SMTP id
 3f1490d57ef6-e1a5acab419mr3163028276.33.1724949246921; Thu, 29 Aug 2024
 09:34:06 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 29 Aug 2024 09:34:06 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <c1e35d3d-fa00-4453-aaa3-9f23a07acb4f@linaro.org>
References: <20240828171722.1251587-1-swboyd@chromium.org> <20240828171722.1251587-2-swboyd@chromium.org>
 <c1e35d3d-fa00-4453-aaa3-9f23a07acb4f@linaro.org>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Thu, 29 Aug 2024 09:34:05 -0700
Message-ID: <CAE-0n51Ag1wpj0uUPVtMvgZJE2FF_FZkw+j=bRiAq3vYk=Y_Fw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] clk: qcom: dispcc-sc7180: Only park display clks
 at init
To: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	patches@lists.linux.dev, linux-clk@vger.kernel.org, 
	Amit Pundir <amit.pundir@linaro.org>, Taniya Das <quic_tdas@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

Quoting Neil Armstrong (2024-08-29 08:32:48)
>
>
> I've been testing this serie on SM8650, and with 01a0a6cc8cfd ("clk: qcom: Park shared RCGs upon registration")
> it fixes an issue we have that triggers:
> [   18.740736] ------------[ cut here ]------------
> [   18.745837] ufs_phy_gdsc status stuck at 'off'
> [   18.745929] WARNING: CPU: 1 PID: 197 at drivers/clk/qcom/gdsc.c:178 gdsc_toggle_logic+0x15c/0x164
> ...
> after waking up UFS from runtime suspend.

Oof that's not good.

>
> So I suspect we'll need to figure out which SM8650 GCC shared clocks would need
> to use clk_rcg2_shared_init_park_ops ?
>
> We also had random boot crash when initializing the display very late on multiple platforms,
> and so far "clk: qcom: Park shared RCGs upon registration" fixed that, but I also suppose Ill
> need to reflect the changes done to dispcc-sc7180.c to dispcc-sm8650.c and others.

It sounds like it's better to make the default always park at
registration time and special case the one or two places where that
isn't possible, i.e. USB because it has special rate requirements. So I
should just go back to v1 then and pile on the QUP patches.

In the long run we probably need to put the clk rate and enable control
into the pm_domains for the gdscs that require them and implement the
"parking" and "unparking" there instead of in the clk_ops layer. That
way we know that when the gdsc is turned on it will have a clk that
works, and when it is turned off it is always parked. We can also use
the gdsc on/off state at init time to increment the enable count on the
shared PLLs by using clk_hw_get_clk() and clk consumer APIs. This will
let us move the boot state into the kernel in a way that doesn't break
when a child clk sharing a PLL is turned off.

