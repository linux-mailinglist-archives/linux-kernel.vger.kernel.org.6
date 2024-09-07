Return-Path: <linux-kernel+bounces-319683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFB3970081
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 08:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E60991C2213B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 06:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F138148FE8;
	Sat,  7 Sep 2024 06:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nHWWcqsZ"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD5613D248
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 06:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725692333; cv=none; b=cI56SsOxNiQl/FiirGCJRp+hjVl3CEZJSU2e3L/y8DknVyU/tOFESbc4LC28mmk4a6++dmLkjyzlrm6IW+HXhVesSt7IgHmhqYOqMY1KC1KTtI22k6xxAF+xpAgJj50sh0pZtX225MEAS3VfvNIhx89MuUT5Map28ggT2Wn1TAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725692333; c=relaxed/simple;
	bh=rgaGjgEabV2AZI1mYeylbTN9fxh/1IY0+yKdiZ9hXl0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=RTdaCmZYKH+ltSFYs6UVuo/CN2iNJNqB/x6TVZIVUNwjjF0UmBL4OXKReDiZjQ+pDA3c8QBUD2OWWZ+dvIrB1MTu1d69on3f1dBKwfGogn2bjfdc7dtjQulQiYGvfR/dBMDZL2DCAkbqVfUMzCtgBJMvvbSQqDlgG/iL4XFpjKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nHWWcqsZ; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f66423686bso24330691fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 23:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725692329; x=1726297129; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PPG/uD8SZZ9HQeRTUezsbbELYqqE6wi9aZnU/g/IvvY=;
        b=nHWWcqsZymLeX5Ll11Prcgms18hFO7Z8ON0f2fwdjFLRWuJckNr7UNIqGVkpN0oCsL
         waJL7aLYTczvAvDMCNgKYvPdd6gEpwfh/ecQj7cAXaeVO5m1gxRePjnR3DhWZJkSJIkM
         +KcwYs38Uod8jM4CC4QsbQ7SuRgDjEStY7tLdO6KpmbGBymGkXuPJ/LKY1mMjuGOHMst
         UvV1H2ao+gWjakl0r4p79YW1M2z4rsR+q1jsabPiVmHb+FCr6dyauWEuVu+V2g2YHpY2
         /5TPkXhvS4A3r0YcxGiLefQBK6rqZXXl5HwqNcHsU7irNviX3SzBNl2pnpoFFQ9m4OyI
         bXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725692329; x=1726297129;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PPG/uD8SZZ9HQeRTUezsbbELYqqE6wi9aZnU/g/IvvY=;
        b=vO0ZI7gLabOpLgvLO78C3XDJHSOph39ndMlQx4CJzjSxy6xVQIUJZmNYfw+7opqSdQ
         /0GeuVj9rrWqSRMWBVT189VNxgGZmyD92TgbpeJOVf7eGHxbUbg28qZgIHwm+tdkmWYc
         MkQyCUMVvD2OvJQbWlKm+sx03zw34RqF6QufcbDEhQ83LedWv3JbZVLp9hDGQdDdI5FQ
         vsyxbS88hIC2Uli9HpKR4ZTLgTEEn9DSQGPbY5rKjeI9lFFyyoVfXRTkrVL87PgsFLJF
         CrDkIvSBsO6Xee0UuKfG6CfdM8JfjTMZZPjmLjGoKrkPNFXFn6o1USqy6C9Z2jOFx4fQ
         QMzw==
X-Forwarded-Encrypted: i=1; AJvYcCXo18Y7f01ILaAboJ1b2LPeCYG9k7QbbnE+NOXgZLibozhvEhDa6Fp5dy1k2BTxBYD1PwAc/qoycuaXVoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJykVK3uBVEC6OBJL9zcfH8TyDYtm7vAdYuho/fYi0slEM4huG
	WQ0CjTMVauLLhP+MKysjlvvLxVM7cAEnhR6oq19hJ26Zg7aObrh4P49ymFlp7Yn0/3sAvOQkZ/2
	hFLrMANJsiEeRCoDah4o2yDcDiHVbDrGrBbk0dw==
X-Google-Smtp-Source: AGHT+IGv5vE7FDTgdRe1M+YXuq3EjLJ8f7JAA0CMbIA7imH5TdPdPm87UXNbt5jLrgHXzb+2dRUXPtMD1uL0F53zgSw=
X-Received: by 2002:a05:651c:b20:b0:2f3:f39f:3719 with SMTP id
 38308e7fff4ca-2f751f5d783mr27611151fa.29.1725692327975; Fri, 06 Sep 2024
 23:58:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 7 Sep 2024 08:58:36 +0200
Message-ID: <CACRpkdb130FuEhKC2M6Ge42-sMDnKE04LGFv6uyAAUEvKXWyUA@mail.gmail.com>
Subject: [GIT PULL] pin control fix for v6.11
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	Stephan Gerhold <stephan.gerhold@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

I have this critical Qualcomm fix pending so sending it to
you.

Please pull it in, the signed tag and commit itself describes
the issue.

Yours,
Linus Walleij


The following changes since commit 431c1646e1f86b949fa3685efc50b660a364c2b6:

  Linux 6.11-rc6 (2024-09-01 19:46:02 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v6.11-3

for you to fetch changes up to 602cb14e310a7a32c4f27d1f16c4614c790c7f6f:

  pinctrl: qcom: x1e80100: Bypass PDC wakeup parent for now
(2024-09-02 11:07:48 +0200)

----------------------------------------------------------------
A single fix for Qualcomm laptops that are affected by
missing wakeup IRQs.

----------------------------------------------------------------
Stephan Gerhold (1):
      pinctrl: qcom: x1e80100: Bypass PDC wakeup parent for now

 drivers/pinctrl/qcom/pinctrl-x1e80100.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

