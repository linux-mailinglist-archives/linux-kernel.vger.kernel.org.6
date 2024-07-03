Return-Path: <linux-kernel+bounces-239954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CB7926738
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 19:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A318B281462
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE571849C9;
	Wed,  3 Jul 2024 17:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eTWlujqL"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90358181B9F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 17:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720027958; cv=none; b=YmSapaVq4qAYZ6PMWPozyYm5oLm6lLgBelKs4amploz2A9JtyDCbe/iM/zggWXvByVFinNCRXFshpZsWJkiPfGYPZ/pON+KPsiTfXSvEyWWW71DH3/mNnbz4sF+rIj2d9a0HHuaR3FC+KjR57hcj8mzofUt5KE6lAp1saidAIAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720027958; c=relaxed/simple;
	bh=yiZwVs34KAsMmVpnWF6wgCRNg80IMF2DlKj/9xcYU0M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=C9kDHaYEW+Xh84thPSiYP2u2KVVqy0tPHjmXinM6TtAwvZ851BvDbw/x1yDcGQ3B7nLJorQbP6o6d6ny1HqdnobzU1G4PWylVcecTeJFS/9uM6lupZ4foBjFdG3d+lFKzzutQa8b+SeWfy1alPfJUI0uxEBWMPhuUrieWSpWZYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eTWlujqL; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-424acfff613so50485205e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 10:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720027955; x=1720632755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oskWmBG9bN19QP7asfXU5sdItpYr22CgLvmAviCVAVc=;
        b=eTWlujqLM+umQk7t5A/MWr33MXJesha1YVdJcYTTW22h8dmQxBncJ+6C230qeT5akz
         I3yiI/PrRD/VurtrTDcaO0BJShmQNzirUzQ8zFIBWSBrIMf2w3sr3DPMiYe5rr7KYcM4
         Uohg1pgKxx8DfcAXJapYKYdr5NMRKbJnJFE6LtdWi8bcRToEi1nJgAXCM+PavuiQRQxZ
         OuoxFWW7nSNg7MIBe/prTyhizPFzUTFF7/wQlO3aFBG+SRuVX1Dg1E7d8AYcZXcFlrud
         me612LP7vMRdXnEv0UCSkKzm5VqNX7uROQu1nwUYawo754l+srzs6GEP1UIZCBjW+jm9
         rxDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720027955; x=1720632755;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oskWmBG9bN19QP7asfXU5sdItpYr22CgLvmAviCVAVc=;
        b=g7uZAZq9g/HyklQ8UnnpGPuywR6BNG0fCmZZFScU7yQ/FKNKbpTvq38BgdoWwgaGWC
         rwl9hqMJ0ERQP4oKgEg0zYHs0opEhDV43VHB0H0MIQGvpR+BmFLcSfmgmm2cKvc8zNvo
         cHDOnATuauUyc1XC6NR0usL9Qyx82IZFw/LdihdRJztY/r39v2/q1mYGdTIesJpCsovD
         Vjcpz65/GWoj2P0i3NwEho4Zas0df/Craat+rovWutOW6A5DGeS1hGEAjRhdjH9lpkli
         zo//pp02srni4n3SqfzIsCsRq9kg//SlTFgLk5x7KCCnkdW0umN15UV1AxXrDSu3oBgx
         qjVg==
X-Forwarded-Encrypted: i=1; AJvYcCW0C0Eg+u1ER1DQ2It3MbiqRTFs107oQevWG25LW3LPROtFaXMx5N+PbmWYG7iaaTNJTQK35F+Js5h5gzQ8veFMngLQDLF7+6esUJRE
X-Gm-Message-State: AOJu0YwZuX35hgNkWkEIHSScFDk/MpSv9Z/Fq3jUIGNzK6X8aI8dwBUp
	K4fM1bVDQcrmtbs+deVab7DqYHQrIZ67xbEj0NQlja5R8W4T0C4wY9kolHMEwWY=
X-Google-Smtp-Source: AGHT+IFyHHiiFlnwelv6JSIST8hjX2FhMJ9p/4P+xzny04uXYYyA9EwNzHKULeV4HsPzKoQ5t0WQLg==
X-Received: by 2002:a05:600c:181b:b0:424:c837:f54b with SMTP id 5b1f17b1804b1-4257a0270f4mr102800275e9.38.1720027954898;
        Wed, 03 Jul 2024 10:32:34 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b0c0f99sm252728595e9.41.2024.07.03.10.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 10:32:34 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, 
 rbmarliere@gmail.com, skhan@linuxfoundation.org, 
 Amit Vadhavana <av2082000@gmail.com>
Cc: linux-kernel-mentees@lists.linuxfoundation.org
In-Reply-To: <20240616203231.43724-1-av2082000@gmail.com>
References: <20240616203231.43724-1-av2082000@gmail.com>
Subject: Re: [PATCH v2] slimbus: Fix struct and documentation alignment in
 stream.c
Message-Id: <172002795407.299941.2477625564170300581.b4-ty@linaro.org>
Date: Wed, 03 Jul 2024 18:32:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Mon, 17 Jun 2024 02:02:31 +0530, Amit Vadhavana wrote:
> The placement of the `segdist_codes` array documentation was corrected
> to conform with kernel documentation guidelines. The `@segdist_codes`
> was placed incorrectly within the struct `segdist_code` documentation
> block, which led to a potential misinterpretation of the code structure.
> 
> The `segdist_codes` array documentation was moved outside the struct
> block, and a separate comment block was provided for it. This change
> ensures that clarity and proper alignment with kernel documentation
> standards are maintained.
> 
> [...]

Applied, thanks!

[1/1] slimbus: Fix struct and documentation alignment in stream.c
      commit: cea500f1ad5f6e93e67ab6f9a317d713524732cd

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


