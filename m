Return-Path: <linux-kernel+bounces-203965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E0B8FE2C6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A56A4B2E16B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C8213F43C;
	Thu,  6 Jun 2024 09:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A64w3Pbr"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3687813DDC5
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 09:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717665219; cv=none; b=TQtAF5c27lUzS8nCt4iZaGLmuPBctWBAvQOEAILBWE+bMxAznChjR6zjZTJEBrH2opmdr6vGEIQODiCpsDd2dRbAJGpFpD4e0wGwABe9aapfRU8PiB0ET6LTTq9QQBHDt3lq9cAo6+mUo5shmheAOFGqN87HmXQvdS8gl6GxQYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717665219; c=relaxed/simple;
	bh=675Kr1uZ6lGtfybtFdJlmhLpwlYNE2CQBKQqnZWuZII=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fPcZGDgx2/pwaskwga7unQ8RzQZbspUey7tz0OgYjkWUBBctcAgup+g0oFvvLIWrdU4rlqfZBnHQstEwrg0ue+y7WiaNgMqB/H+Duo7jgw8i0v/UvlEjBTjF1h5C84JMuz4wBalmC90h1h8Ip6imx/dzFaNdolS2jkvPND7+yH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A64w3Pbr; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4214f803606so7958135e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 02:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717665216; x=1718270016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u7hiDQFRdRBFfKeqxCjHkLufjUfT0buj2+w6oCqBN/o=;
        b=A64w3PbrE1TqxOW152YkxRlQ9JLZLOzkTgPPIyjUQGCrqnqT6RTDaMJ5nqXIfTtV4f
         F+mDzOEVtUwnHUw/6izTUzGcM17qr0k0AKDOKf5idjoyyIfnW5Hvg5ZqvCnLmvq9ZHcK
         TTPq8/FMCM4EDLaMhgeCQ7+2mDPJSPSYD7DkPISRRbFaMN0dOHEK0NCO2oxeH/49O64l
         BJIpCItdDV5UlSFeGUpx90m3O25THOOPGTfjXwb467gSAQqpUzBrImDG9EXme0lxkJyt
         VE5C4ZyTGdaZWp1rX+to/J6UKoU0OI68LHL7gABLvoc30nVETqslun6wp6CuBLBvlzD7
         L8Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717665216; x=1718270016;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u7hiDQFRdRBFfKeqxCjHkLufjUfT0buj2+w6oCqBN/o=;
        b=Tx+5yMiqGoQA7GJk3jMt/kxqlMOboYypigmBceZHL3uSCQyVO3+jLIkyu/UqaszuAT
         3Xx8NDMZlbHchTATmhPiOmVGHUGykAHSw0Mm5IyEvbsCjW/OKznNuNeXVoCJ4onKiVjF
         ykkomhNfVy9IJfUr6N0FON81g9+Ha3aQYTk06/8S3EFvwFGqjqryJisyxMLK6p3shIhh
         bRnmE3K4dHeJJgK9ceJtqupdzmwxnN7f9BHTwQIIfQmdN5slzpC4Yw0HcFYCQCDt7zTR
         ezl0VYS+WSXEYt8JXM4VT1z+51GQUSxuH641W/h1Mdx+EvrqTOT37yA7bW2zMy4YcaXZ
         lTQA==
X-Forwarded-Encrypted: i=1; AJvYcCWCEfaVpO++65qPMmoVhcOaaPGQmgVdyiNg21GVhnRRmXGiqylUInASXdRq6sL/i73EeyMNj+h7q/BRWNUMjBGa+KXikSrImydgvVjg
X-Gm-Message-State: AOJu0Yw0zR2p422UHXN11VL1Tmga54RbzPvNUSIS7wRL454UAU9YJpxa
	DjMcFcsJO/mE4tWDM2MdkJlrb7bTujV9uiUGk20zU3wZC7pOUXTPegoTb+OwXmM=
X-Google-Smtp-Source: AGHT+IHtyCwh9CmHAU8WBlcMrLbk+Z5UM643qQi3c42FsuzxsDGC7SvGqqn2rUSLfqFXsl549PS0sQ==
X-Received: by 2002:a05:600c:45c8:b0:420:d54:7003 with SMTP id 5b1f17b1804b1-421562de063mr35200745e9.20.1717665216650;
        Thu, 06 Jun 2024 02:13:36 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c2a544bsm15038175e9.21.2024.06.06.02.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 02:13:36 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, Viacheslav Bocharov <adeep@lexina.in>
In-Reply-To: <20240604140612.1179323-1-adeep@lexina.in>
References: <20240604140612.1179323-1-adeep@lexina.in>
Subject: Re: [PATCH] soc: amlogic: meson-gx-socinfo: add new A113X SoC id
Message-Id: <171766521601.3911648.2220702176918701226.b4-ty@linaro.org>
Date: Thu, 06 Jun 2024 11:13:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

Hi,

On Tue, 04 Jun 2024 17:04:51 +0300, Viacheslav Bocharov wrote:
> Add new definition for Amlogix A113X SoC found in JetHub D1/D1+ devices:
> 
> soc soc0: Amlogic Meson AXG (A113X) Revision 25:b (43:2) Detected
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.11/drivers)

[1/1] soc: amlogic: meson-gx-socinfo: add new A113X SoC id
      https://git.kernel.org/amlogic/c/2faaab64de0e89697e01f1a0c5d401ea74d52447

These changes has been applied on the intermediate git tree [1].

The v6.11/drivers branch will then be sent via a formal Pull Request to the Linux SoC maintainers
for inclusion in their intermediate git branches in order to be sent to Linus during
the next merge window, or sooner if it's a set of fixes.

In the cases of fixes, those will be merged in the current release candidate
kernel and as soon they appear on the Linux master branch they will be
backported to the previous Stable and Long-Stable kernels [2].

The intermediate git branches are merged daily in the linux-next tree [3],
people are encouraged testing these pre-release kernels and report issues on the
relevant mailing-lists.

If problems are discovered on those changes, please submit a signed-off-by revert
patch followed by a corrective changeset.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

-- 
Neil


