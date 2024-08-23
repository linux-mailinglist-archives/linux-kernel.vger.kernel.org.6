Return-Path: <linux-kernel+bounces-299671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AB195D871
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 23:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 035291C217F6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 21:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD9F1C8228;
	Fri, 23 Aug 2024 21:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J4IdGAEe"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC86180C02
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 21:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724448525; cv=none; b=Tp46bSO8wJkijeo2666oDWj0+oIjWPuvi7npYnimUm+HNj9O/XwAwQIg4K684LSsE/gshPT8tApftYfFYj3FEnzqbAKwNzpPHa6wz4ca7IbVxD3dWp7dGXPd2JIFy8pWManuezjcMsNAPMdRfNF66ehRamtFB64yXfKPxaRuvOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724448525; c=relaxed/simple;
	bh=UDYnajIV2KOYW/jm/93SAiBCM+8IKtae0Uxn7ZsdlkY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fa0295KmUWqoB2MAACOycV9GQ1ovqipQchM7i8ZlYpIUCKWL5kGBlmvBaoiAQ9ZPJYZWYTs6p2hJNCIhj9XXrz61WVcJKhlL6B6aWioSVaWy3oxjWm2A7EibXAOvvEv7PNqAWeoZV7Jhs+BWU11lbcPP0uR0dOL7vGa6VxPYO7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=J4IdGAEe; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-202146e93f6so25308965ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 14:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724448523; x=1725053323; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x6yyPOjZiqt8OBw3MWeKPxceSdJUt3buN6TZjEitZlA=;
        b=J4IdGAEeuVnja/EstDLaW/oJ3oXvVX65vnxZXdRx2ci7U7Gc2wKVYuJ76p1a0Dxrdb
         Qk+cIWfY6mii5p3CpuBpFugUucOWruCrt1KKcMV88m5hnPF0iQ9YH3Wv/qlzzGN4c7zI
         SdanKZtVawi2qCwrdUiNg8b3P6keSaAOKV34c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724448523; x=1725053323;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x6yyPOjZiqt8OBw3MWeKPxceSdJUt3buN6TZjEitZlA=;
        b=HoCXf9t9JjUc6xyz+kAxwk8CHvzfw64x6cZ+BjnbOSIGWLPhLvOY+vIELi7eS85J9p
         8Q+u0DZBV1kwjLhQxa/UzCepoQRyQ4XL+3p+dWQPvdcRLFBWExVQRmV3nTsGs70F6Hj8
         xeVDjpE3Q/H+2C86L1T+gOV9wH/rnGxy7a39EKOkDSGTxurw9HaWhmGezljZPKZiRahQ
         piakWfc1lx/UWGTb0Dt6v7WD5Id69QcZF7NZBA9uBcjupvtFVNgD8zA+3l5KJTJdjyqw
         GzPcEDJO4gDCm6f9NmBL7YXVLb9Xwcm+cpt8vKZSVyp7gZOd+TCCtrojAiYw8zxPw+8V
         BMqQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9BCYI5Le+2dZ/XdxiNV/3T+QVfsNYxxIRh/cE6a7US6afW87LH3clVBjjvxU+DKVbfKMPEiXor8dfYzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7vyapxlxxoWWZOX+fZHGAqbBaNIyB5SfR/jfMzkXTcFYDB3n/
	u0CdsuR8pXL2zlWEFgGOXN1SMz1fy6KelKiR3IedUMGqSCjietBbSaOcPgUIWA==
X-Google-Smtp-Source: AGHT+IEyiELvUQ08sRXKAsH1w4lS8Mpljm5W6KidIpNO/oUI/CTnm9GKW1kRt4ARb+bsEYqhFyMDeQ==
X-Received: by 2002:a17:903:1c6:b0:202:100f:7b9b with SMTP id d9443c01a7336-2039e4ca62amr43391485ad.35.1724448522990;
        Fri, 23 Aug 2024 14:28:42 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:9d43:7af7:9970:8219])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-20385594057sm32605055ad.119.2024.08.23.14.28.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 14:28:42 -0700 (PDT)
Date: Fri, 23 Aug 2024 14:28:40 -0700
From: Brian Norris <briannorris@chromium.org>
To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
	Jon Lin <jon.lin@rock-chips.com>, broonie@kernel.org,
	heiko@sntech.de, linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	shengfei Xu <xsf@rock-chips.com>
Subject: Re: [PATCH v3 5/6] spi: rockchip: Suspend and resume the bus during
 NOIRQ_SYSTEM_SLEEP_PM ops
Message-ID: <Zsj_CJR56TcahXBO@google.com>
References: <20220216014028.8123-1-jon.lin@rock-chips.com>
 <20220216014028.8123-6-jon.lin@rock-chips.com>
 <20220621154218.sau54jeij4bunf56@core>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220621154218.sau54jeij4bunf56@core>

On Tue, Jun 21, 2022 at 05:42:18PM +0200, Ondřej Jirman wrote:
> On Wed, Feb 16, 2022 at 09:40:27AM +0800, Jon Lin wrote:
> > From: shengfei Xu <xsf@rock-chips.com>
> > 
> > the wakeup interrupt handler which is guaranteed not to run while
> > @resume noirq() is being executed. the patch can help to avoid the
> > wakeup source try to access spi when the spi is in suspend mode.
> 
> This patch causes oops on suspend every single time, because it tries to disable
> already disabled clocks (one disable in runtime PM suspend, and other one in
> system suspend). It also fails to properly handle errors from clk_prepare_enable
> in rockchip_spi_resume, potentially causing even more clock enable/disable
> imballance issues.
> 
> Please send a revert and figure out a better fix for the original issue.

Did anyone ever resolve this? I still see this issue on 6.10.6.

IIUC, we can actually do a partial revert -- we *should* be using
pm_runtime_force_{suspend,resume}() (so that we coordinate clk-disable,
etc. with the runtime PM state), but we also want to run in the noirq
phase.

If I don't see anyone else's solution or input, I'll plan on submitting
a partial revert, which seems to test out OK for me.

Brian

P.S. One can work around this problem by disabling runtime PM for the
controllers:

for i in /sys/bus/platform/drivers/rockchip-spi/*/power/control; do
  echo on >$i
done

But obviously that's not ideal.

