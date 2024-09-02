Return-Path: <linux-kernel+bounces-310854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B501096820E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D651A1C2222F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93C11865EA;
	Mon,  2 Sep 2024 08:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ixXgburW"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBE4185B67
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 08:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725266073; cv=none; b=R0myp+RcfSPp0+whOL80WOp44biHrDJDzsIcoesIwHaJUHfVpDZHaUonNeqap4R0fZx1y8+A7Y/kxoqWUXV6CDgoxg3uYkAQuyKSd/n+9402UXcBylxWDvC81YeVSK8oCH7TBgswVYzQSF+7HU6Np/Rpb28BTsNqDpGhbgbUWCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725266073; c=relaxed/simple;
	bh=HUSSY6a3ZyhD/x5/cwC68u5/Zm3TMt5InaFYyBQMRz0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BkstW7/4tbwK8YUA7a51x9ZFXUd5BUvdxJKc2NKNgPB5DMMmXaM189Mai2ruOdGQeUYdyEGADvXtxoqSFwwQHKZd1d1YSxRJRfHnip8BqNeD23FqaE/IcPKr+w6vYcp9/zVNwJqC7pHk1STkamwUWhWSYr8Qbe04xB9EzLLWT9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ixXgburW; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-428e0d184b4so32629075e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 01:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725266070; x=1725870870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+za/cAcdZ0XOTg3FDU5KvmgY/loVMFZsFxv5CioePC0=;
        b=ixXgburWSXpB1uQ3CfuARFbrVXSWavhGkxt6kgy8XgMGUHB+ku5GKcjPz0pvuWNccQ
         CN/yzYKuT9WnoxN5QQ4iNZR6ek8kCvIgz/DABSspUYJSjqwYvCY/AkdFDMn1yzESuMoL
         AWt2S3X+Ij3Z99ao4pftgDmOnDu8jAD8odbKAudyJXbXXuEvjuM6UOzaifb5LtdgHbe+
         d+3g6HcbtA714Zf1K7+SOgIQ1AlbQleHoFgk+GbSBixIMJ67GkTy8OPHJM3qQWLhAORB
         VUyyAPyK9vXf+fQnLjlpFAdbNQ8PK4OphpY/XnVkrsaFeQyJLMTBPlnJtfWcHukkYdMk
         q9jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725266070; x=1725870870;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+za/cAcdZ0XOTg3FDU5KvmgY/loVMFZsFxv5CioePC0=;
        b=diX+AjEHfFTQiUjhj7ri6Kg8pdx0Bb/7a+NAiEd2InFtavEYnn8fVzSowewuYsU/ES
         lxqk9oNGUj7LFhgA5ZLMbgPALpEPykoHP0+O0PHO5R9dRc6VyhNeVqxbgLHMluv8Scfw
         sxaF8M0hFZeLUNnwBBn1THe1alQ1m87+S//2mZI0rO1LHRkwtafevTmM7xyZHd8ojPLY
         v/zSrkhXXmjRg5ijlMjKY/Lm3ZunQa/QWzYRbhattczhWSgupLI7mfQzZMRd30YpPSaE
         BXdirAFpUGLsHKTHZszMM2HTRZhc07IaXSf59WagwNHNQCQeHSo8yA/jV4Hnm5+wkL+H
         7lEA==
X-Forwarded-Encrypted: i=1; AJvYcCXPW2aJbzbUiPw8coAkUmCCc/4HrX0u5SA1QXcSN8cwfle6DmjhBH55oHSNuEFYGyhvELmG1GrEbjT4lKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZd2rdgXFfBnl/OCj8xBnLtKU9l3ig78qsOoS2yIHxoZ1fT5Z+
	qfMgLIfNGhyPE5/muQ/fHs40X0sHrFeDTmopUrBu6Nbfew/EplHS+T6DqDwAAFA=
X-Google-Smtp-Source: AGHT+IFJUVovWbnX5nY+Y2YkBfcSM9FaAqLveWckf0TJzKcGo4CXWwjHWFVMGHxm8ScNSGaXGnfepQ==
X-Received: by 2002:a5d:50ce:0:b0:374:bde6:bff5 with SMTP id ffacd0b85a97d-374bf1c94aemr3336071f8f.46.1725266069342;
        Mon, 02 Sep 2024 01:34:29 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374bfbfc7b7sm5807456f8f.88.2024.09.02.01.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 01:34:28 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>
In-Reply-To: <20240902-fix_warning-v1-1-037029c584fc@amlogic.com>
References: <20240902-fix_warning-v1-1-037029c584fc@amlogic.com>
Subject: Re: [PATCH] arm64: dts: amlogic: c3: fix dtbcheck warning
Message-Id: <172526606853.2176850.7789984946561002736.b4-ty@linaro.org>
Date: Mon, 02 Sep 2024 10:34:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1

Hi,

On Mon, 02 Sep 2024 13:29:39 +0800, Xianwei Zhao wrote:
> Fix warning when use W=1 to build dtb, as following error:
> 
> arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi:65.7-76.4: Warning
> (unit_address_vs_reg): /sram: node has a reg or ranges property,
> but no unit name
> 
> arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi:168.34-413.6: Warning
> (unit_address_vs_reg): /soc/bus@fe000000/pinctrl@4000: node has a
> unit name, but no reg or ranges property
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.12/arm64-dt)

[1/1] arm64: dts: amlogic: c3: fix dtbcheck warning
      https://git.kernel.org/amlogic/c/ca55a30d27cb37c07f58e5c3448f4d19edb1829c

These changes has been applied on the intermediate git tree [1].

The v6.12/arm64-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
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


