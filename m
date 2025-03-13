Return-Path: <linux-kernel+bounces-559013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C981DA5EE59
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CED2166523
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355602620FF;
	Thu, 13 Mar 2025 08:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NsNl1upG"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D9326157B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 08:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741855737; cv=none; b=dCyMgtiUHZs+SxypXzfq1+vw7ym49GQCUP41tvdNH+WPZscBwNtw+zYCKnLC1A8MRoENlQbXuzqR/93ufZDk0df7BERisvRjkN4h1lsiY3mF20dclAwDfWW2a9dZfeHWMNbc9kV+UzPsqTLpbDchsSoyp0uz+2fpErxyUZINTV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741855737; c=relaxed/simple;
	bh=5JSx9yXVSMH1oIfWAZP5BAqaDyb/cZv1fzFwbXXkrDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IkgOnNi9Ghow21L2UuyNG/jThqKCjcrZ0rR0eMQBSVfnVWiNiKCUdSscwh5n81Bv1W3j0SH0I2e+f8EDswCq2zT4H1F04p1/0TebUWS4Qyn3wn2HmIEq2B+CCBe+69HYmt8gpDFvER9OP+FcPDCyKnSbexySJCRGyBKB8DvkuzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NsNl1upG; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30613802a6bso8101741fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 01:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741855733; x=1742460533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5JSx9yXVSMH1oIfWAZP5BAqaDyb/cZv1fzFwbXXkrDE=;
        b=NsNl1upGm2g3cB8QwYym3nRrJWTr9+POsRQX//o7PoQhJkG1Z1CzrI7mhIS8np2Eum
         hXWJq3Gy3ja4ltK0xSLNen2dpC+eavbkJZRZ4sSR+f99n+WtLRPfz7ElQnqifbGL9ktr
         cT2GS6leCSVcMFKv8w+yW1+Ast41b5tH3mD/tSHuC8+aHyVbhhn0qMpXEa2XPx8hKVev
         n6zlw45oMW/4gDGQP7OaRVysnbV9R4vr2M2w1u2rdb72htDmU/RoXqtXKbEgSlEu6Jop
         OekYzVZk98cSzzTirZ7I933ECuSISQXi6yPpLm55AwMtq9fuciP6OOoMoCUdUu8/tyRm
         upQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741855733; x=1742460533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5JSx9yXVSMH1oIfWAZP5BAqaDyb/cZv1fzFwbXXkrDE=;
        b=nf5oXSub6lc5Nn0uZX4JLjmxpRJODbf1Kh6gxqnt+tMWyp1cTpuewbQWgKkjgvyZvj
         Czli5FVI5tvp6OM+xfIPb3S3jZPDMMAl6OBkQUuWzekH3INdBy40HhJpHpcH06K2KxsN
         ID7eEANR6u1B8QH9rUeGkEqHAmCL8v/4KIHRcU2uHRUnbj3ZAcoCW27rQEdkNKSoplBg
         Zcg+WITLyiFomQUiG6OuyC6F4p7BHPXLTZB5sEgWVTjMZgSqQ+RUCgfu9+Mng1xA9xbP
         5ZwpKat7yEAa7EhrP+3JDc2ZX4EcsgMZ5nBAhLwWCJcXBEpUTCZvZ4Nfsfp7HfmDg//f
         rN1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXm6nycl8+dnQlu8wh683+jLHziHGToFCtPlMn8p6hIWIpccrQkbF4JNmOTwjIst5X2KMX77EJEqtO6AIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8W4/labOUtRC8jh66CYX1Sq0IfqGMJZGIks2o5MIoNUbZ02R7
	AupTs+GibhV5dFL/JUU0PvUghhS6xZzG3D/M5bk3iF/IPMxSXmXuUWtbZTe+iowPplvSQyCE/tP
	BA0gifdKRJ7Qiy0fM6STbQWmRbGya/vWihIayvg==
X-Gm-Gg: ASbGnctcRWpgPqSmkmwDN0Gx3dhNgTM6HMmdZMAbcwXsyT1gcf+K7/d+wgcx65HNseN
	IDbVRTBtaOWCGsaRhUqIJ+TMztM00pfrI/SEgcqh/vBMPX8sTVIs65Zr3PMkiRsO6bHZf0MIQ4d
	BKi0To5LI0XonDvobnWagMlqeW1w==
X-Google-Smtp-Source: AGHT+IGI8tFaOVTeJQCqFzI9EQ42o/9graFjduSws1PVhjUTSRn9EgLXRgQWygDrvrGqu/hZbh3Ks12WRVjlfFyAipk=
X-Received: by 2002:a05:6512:ba6:b0:549:8f06:8225 with SMTP id
 2adb3069b0e04-54990ec17dfmr7466352e87.53.1741855733121; Thu, 13 Mar 2025
 01:48:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311-arm-fix-vectors-with-linker-dce-v1-0-ec4c382e3bfd@kernel.org>
 <20250311-arm-fix-vectors-with-linker-dce-v1-1-ec4c382e3bfd@kernel.org>
In-Reply-To: <20250311-arm-fix-vectors-with-linker-dce-v1-1-ec4c382e3bfd@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 13 Mar 2025 09:48:42 +0100
X-Gm-Features: AQ5f1JqmIPVBXkWKiQ4L7FkcGH2_zJJXfhNRe652n92bAmXjxmmkzkQ8l-fLCmw
Message-ID: <CACRpkdY-yxaiG89Co+C2=vyd0i6sh9pP0UGWZh1yUg4jd9jmuQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: Require linker to support KEEP within OVERLAY
 for DCE
To: Nathan Chancellor <nathan@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, Christian Eggers <ceggers@arri.de>, 
	Arnd Bergmann <arnd@arndb.de>, Yuntao Liu <liuyuntao12@huawei.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 8:43=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:

> ld.lld prior to 21.0.0 does not support using the KEEP keyword within an
> overlay description, which may be needed to avoid discarding necessary
> sections within an overlay with '--gc-sections', which can be enabled
> for the kernel via CONFIG_LD_DEAD_CODE_DATA_ELIMINATION.
>
> Disallow CONFIG_LD_DEAD_CODE_DATA_ELIMINATION without support for KEEP
> within OVERLAY and introduce a macro, OVERLAY_KEEP, that can be used to
> conditionally add KEEP when it is properly supported to avoid breaking
> old versions of ld.lld.
>
> Cc: stable@vger.kernel.org
> Link: https://github.com/llvm/llvm-project/commit/381599f1fe973afad3094e5=
5ec99b1620dba7d8c
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Very clear and easy to follow.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

