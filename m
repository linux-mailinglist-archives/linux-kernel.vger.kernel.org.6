Return-Path: <linux-kernel+bounces-389112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D66729B68B6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 16:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95BD2284561
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CE72144A2;
	Wed, 30 Oct 2024 15:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zVA+0vdy"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEFD21441B
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 15:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730303950; cv=none; b=KDfu44xjmNMgdHude/7M+68Ngj/6YNodQSZXCv2LN5i1B1n+L0QVSaHLcPjnygRVyt82vnP17k8Cv1rCwkxDYeVBDJJt6unJw3v8jylgEdTmTHdFcfdk0O+RJ4QwC90e5cHb+JOLV7Z2AgVSd69e5pl69XjyvK3yTVsnTMTOL5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730303950; c=relaxed/simple;
	bh=HIxxikhzDMWtdyaOhUJ5dv/cxvC7QWX8RE3H4C7G+k8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YKz5xr4ibQYYvIXZnYye1WTGchj8qs2d1ZW6PaEvnKghishytve4ou9c7YvnEuGRvDohFTtXQ8ClMVEU6NK5bgYGiyjDfT9XEKC1hFRRG3mOO+V9Pq/+BMy430tJujvxhAZTwB64npt5Fqwm8FyfP7GzBxOJioMy7LbhKVhXRcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zVA+0vdy; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7180d9d0dcbso3062025a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 08:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730303947; x=1730908747; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eh9Rgk7ggpbAIfmbuIxK8vjEN7ZF46nd11xU/V0drIE=;
        b=zVA+0vdytRlKrska7A+SDkT2kbnrGW7gdQpMYMJADtDg60Ekuw0P/HgXJ/3oPuIr24
         MbcHmRAmW1Daxuy2jlrdrLn/rptAWW3oWsTOkjhPwGY8Vxc/xX5VoK1iAFNYiXkJ4NDW
         KzIZC9HRfACMKbTKxXxj8SYrU9Bqlsn07+7739Eq26XWqBkiU+rxxQXsOIiT4JJ9YSdB
         8iwuU94xJxB9vhEO36aSNjLOD0fswwb00KcIDknS0Wg30cZHljwK4Rd4UU/CNK6dIBYp
         78aXaYGdb1agOORp7KmgccgSuZJE9lz4ltj4UThgFWET2j2VFrscVxJeRNJBvPNOr7LV
         XBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730303947; x=1730908747;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eh9Rgk7ggpbAIfmbuIxK8vjEN7ZF46nd11xU/V0drIE=;
        b=wTDwjoJkHwJ5IeGE7Nz0TsnqZvLC99pFrC+xz0CospBZkf568qtxYDfrZhsxocYIz5
         ilpWTZrxEYq8t3KpJup6KadIMqCQNNuv+IIN5sQ5KpIVLkJY0iRY2wkKorkreWW+8rzH
         Da2jqLS1ATl1SYvAObmw+tRrPZgnnOiPzLxTgsHSevITkXJvn0A0WSgEsSD6MUd/Zzng
         JkbHg/fwI+tsuHvQPE+O2QTZ1WADVWXnEokNDzZvkvuB11htJoI3EVSjEA4cE0VT2R7G
         pdPbzNOSPZgxx9Px/XHUPjAi1viSv43da8fEUVURIAoDSaKXNFWify2ooY01Y7lNfBtc
         BJgw==
X-Forwarded-Encrypted: i=1; AJvYcCUNo6PrOmrvnIyYU+xNJ18uYa0Mt1gxMetlmFEKFouq340XJm37bK1CgVg+pChYdgjPdhoHAa//W+nrQDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW//VejbcEE4NdPwrmymDS8hheVh7FSZtx+rt+F9G9JKbWAe5Q
	Rg4D3rBTQOo/MkXZ/FKR9b+qUA048yC7hMOtUAvSEybP/O97MrgsLe2uM2d7qAGI8iknK1WoUEC
	X035WWtpVunabKeFNYUsko7fL/w3KQ+xb9eMGaQ==
X-Google-Smtp-Source: AGHT+IGcvdh6hUVAY/ghEqHaTdX2aYhEr0HkUHbGO2MLJDsO31xGVP61B+nN11Z8X8ZW3LGsIq5cI9Ila4LMFwxgeNo=
X-Received: by 2002:a05:6830:912:b0:718:1109:9626 with SMTP id
 46e09a7af769-7189b4cb6dcmr122701a34.6.1730303947477; Wed, 30 Oct 2024
 08:59:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906-lpm-v6-10-constraints-pmdomain-v4-0-4055557fafbc@baylibre.com>
 <173029317079.2440963.17313738472826934777.b4-ty@ti.com>
In-Reply-To: <173029317079.2440963.17313738472826934777.b4-ty@ti.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 30 Oct 2024 16:58:31 +0100
Message-ID: <CAPDyKFptHq6xkKSAmeHsEuhBoEhzvudcMf2+nG08MFPwnMi+ew@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] pmdomain: ti_sci: collect and send low-power mode constraints
To: Nishanth Menon <nm@ti.com>
Cc: linux-pm@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>, 
	Vibhore Vardhan <vibhore@ti.com>, Dhruva Gole <d-gole@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
	Sebin Francis <sebin.francis@ti.com>, Markus Schneider-Pargmann <msp@baylibre.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Oct 2024 at 14:01, Nishanth Menon <nm@ti.com> wrote:
>
> Hi Kevin Hilman,
>
> On Fri, 06 Sep 2024 09:14:48 -0700, Kevin Hilman wrote:
> > The latest (10.x) version of the firmware for the PM co-processor (aka
> > device manager, or DM) adds support for a "managed" mode, where the DM
> > firmware will select the specific low power state which is entered
> > when Linux requests a system-wide suspend.
> >
> > In this mode, the DM will always attempt the deepest low-power state
> > available for the SoC.
> >
> > [...]
>
> I have applied the following to branch ti-drivers-soc-next on [1].
> Thank you!
>
> Ulf, based on your ack[2], I have assumed that you want me to pick
> this series up. Let me know if that is not the case and I can drop the
> series.

Well, that was a while ago. The reason was because there was a
dependency to another series [2], when this was posted.

If that's not the case anymore, I think it's better to funnel this via
my pmdomain tree. Please let me know how to proceed.

Kind regards
Uffe

>
> [1/3] pmdomain: ti_sci: add per-device latency constraint management
>       commit: 7c2c8d2651b5ffaffb2d5f723bd5b0493bd66f36
> [2/3] pmdomain: ti_sci: add wakeup constraint management
>       commit: 5a2d997b1bf8b05379309270063d7b9bd3767dd2
> [3/3] pmdomain: ti_sci: handle wake IRQs for IO daisy chain wakeups
>       commit: e8f35dc8de8c3216d28dab51b962bb31f20934c8
>
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent up the chain during
> the next merge window (or sooner if it is a relevant bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
>
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
>
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
>
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
> [2] https://lore.kernel.org/all/CAPDyKFr9isnz66B+n5y3=QO-ndB05JKZN3kgXO+kXBn7ofcwMw@mail.gmail.com/
> --
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
>

