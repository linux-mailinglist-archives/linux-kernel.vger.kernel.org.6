Return-Path: <linux-kernel+bounces-194255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 316668D38FC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 16:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA501B23D22
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 14:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9AE156C63;
	Wed, 29 May 2024 14:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZVECzVw"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BE1156C4B;
	Wed, 29 May 2024 14:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716992398; cv=none; b=RVvlM808k6HP3nmWZcX01SwFH5AhBo9DFi0eSn6EinH30i3Ql1FrGWGbD1AyLOvlicUY89VP3hjp8QD5+I9oj87iwzuhfEWeBc3oLuwJJwWqY92TPdVcuOOPSrEnisOFwflsciMgpU+XVs90Sg51flvJqI868DE3Hx6Uw3bB4hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716992398; c=relaxed/simple;
	bh=/idmh+yvnaSR4zr7lwwZqADvCmrc14Xu+3n/mNDAxNU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=sz6gylTIsMUVwW8BfVTa91LL+QfuZAjPyKDCgY9c8sxvRCD2Q/X+bjiv+JPM+mV8e9bjrEChf7/jIAhUYbM3rGmP7YaLjEpOTUqj/Pk7wu80x+7cPSGMUCuqGvice6CcZX5JytWmcctutokkiMzUifNn+aG+tVgYMQRn26TfNNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nZVECzVw; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52ac0c4b62cso918783e87.2;
        Wed, 29 May 2024 07:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716992395; x=1717597195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tq+U7SgBQTVMSMlIy3UdyJxbPASA6waFh60Q4P8YQkA=;
        b=nZVECzVwUjR2O3TRRyCf8XoQRHT8DKdDcLvHld9IcaeAIH74yTv/ypspp/wfInDSTJ
         0pI1c8tUiPP+7uGjLPniTbkhRS5gJ7LdbnAcghK5YvjEPVC0JtB3c0CBKtjfs/KTZDjw
         CEc+ZBLuAIX5irJ9ZakPQirj1T1fmmvdV9IqCOBm+V3Z+KWwRfkNqeRfOWNUElyVBKd0
         hl/V6GXmFtFapYGgWOp8eNvqrakyLqg33Fd8fv1IDO4Jca0bZLTjcg7akVrlVixCHxmL
         wSqsi+JVGe3Q+WgLUNYdZPKzMLD3BWVyteKG9pQ1Mt3ZELd1lc+uSMqFpvVryyNpVa5x
         eiQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716992395; x=1717597195;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Tq+U7SgBQTVMSMlIy3UdyJxbPASA6waFh60Q4P8YQkA=;
        b=UAPMujnyOQC2tkWVIw3aSQXXSPv0f3ZOhaMe5of06BOVoqe3Iv5KpA6WCJEsXAmi6H
         c4pgd7r3kdJVJ53tm+o3D2KepagLkvj7plXaEMkhKr1etGRG88DlD5ynRQMkT+cCCs9A
         FtDicipk75wVvX7HvRrtL80NqW1GAXu83wuj6UYDstSkUz2w5gX4fBcoVqOSKtMzrDWl
         mIAoZ/IwAZ5zz8sKgNMhb858nTvpu/Ot3SaYcAm9z8UvtJdRIvGrjzgLH1HqfsTEoDMU
         jHXaIlVrH0kVTHkEMXX+j/27hGHhDVBwLgqJt9InCu8hUTJG97bp0+/o9dkKQdlMSCto
         mQJg==
X-Forwarded-Encrypted: i=1; AJvYcCWnBgFWdX7goh/qHYczyj0FyEuL0dZDw+2xBn8NF+Fr3N2iCZ1XUH7OgJtQ4hHis3BhqBCw7up8YDUiOpZXvWy+umecb3N/rXmWAT8gMtCbrDn2wLKSWxpn4t0zOhRnJ7C6Lo8T23u9F4M=
X-Gm-Message-State: AOJu0YzmWDBLn4SQ3tkKBdiRR5PBYfVtiFDELfMGtKiKe+MwR3UhqRzh
	hznyfXVnTPqEgCOyiVD5PmjJz8otuqMDNAoXLbcJh+dUTvTPIPAp
X-Google-Smtp-Source: AGHT+IEBaR/9ZV/mnHVsdgn/YHZs8SuvACBliDuxAG8jTdpQo11v0iyEkLahEvTKgb1TwDgy1y4KxA==
X-Received: by 2002:ac2:44a6:0:b0:51d:d78:4952 with SMTP id 2adb3069b0e04-529666db627mr8232383e87.65.1716992394518;
        Wed, 29 May 2024 07:19:54 -0700 (PDT)
Received: from localhost (host-95-246-50-43.retail.telecomitalia.it. [95.246.50.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6286457089sm629483866b.64.2024.05.29.07.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 07:19:54 -0700 (PDT)
Date: Wed, 29 May 2024 16:19:53 +0200
From: Matteo Martelli <matteomartelli3@gmail.com>
To: Mark Brown <broonie@kernel.org>, 
 Matteo Martelli <matteomartelli3@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, 
 Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Maxime Ripard <mripard@kernel.org>, 
 Marcus Cooper <codekipper@gmail.com>, 
 =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>, 
 linux-sound@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org
Message-ID: <665739895996a_26e4f3704a@njaxe.notmuch>
In-Reply-To: <a003dac1-de47-4a15-8959-25f7d5f1c129@sirena.org.uk>
References: <20240529140658.180966-2-matteomartelli3@gmail.com>
 <a003dac1-de47-4a15-8959-25f7d5f1c129@sirena.org.uk>
Subject: Re: [PATCH 0/1] ASoC: sunxi: sun4i-i2s: fix LRCLK polarity in i2s
 mode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Mark Brown wrote:
> On Wed, May 29, 2024 at 04:00:14PM +0200, Matteo Martelli wrote:
> 
> > I found an issue on the sunxi i2s controller driver while doing some
> > tests with a Pine64 A64 host board and an external codec (ES8311).
> > The A64 i2s controller is compatible with the sun8i-h3-i2s driver.
> > The LRCLK was being inverted when the bus was operated in i2s mode:
> > normally should be left channel on low LRCLK and right channel on high
> > LRCLK, but it was the opposite instead.
> 
> Please don't send cover letters for single patches, if there is anything
> that needs saying put it in the changelog of the patch or after the ---
> if it's administrative stuff.  This reduces mail volume and ensures that 
> any important information is recorded in the changelog rather than being
> lost. 

All right, sorry for that. Should I resend this patch without cover letter?

