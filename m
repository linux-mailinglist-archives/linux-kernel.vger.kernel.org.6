Return-Path: <linux-kernel+bounces-230201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 388C59179C4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABEA81F249EF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 07:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00A715B115;
	Wed, 26 Jun 2024 07:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wrwyr0L1"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A777814A4C1
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 07:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719387157; cv=none; b=QX2WS3mThB7PMjbrr63p5rPNCwZKqGE/U/ZfHyx9PUKVZhhfQjqm12GBrZs2eTmFk8z6e21DPxIsqZ9Zq/qG85EA7/tbDyByc4iXkZkzcXpbhInfJhoEn2QkX4nURSk0OUmiVYh6AOgMlPbLWZutbNFMVUy6Y7VH0nUqE+vHbp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719387157; c=relaxed/simple;
	bh=7l4Uime447ech62qmw3e1+CoLS03F5S+sN0ntrzvEbs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=J6zkwyz3o1oVeKCs1IBUgfrUvZyzbuKQebzsnet0OSO+wwXPXUfgsCKj+9znZmP2qX52Io1sxyrhilD4GNevC0f7XWhcJSBb7TbIKXIvNqPPOGGSXidtidaZs6sFkqI3Iq8J9vjpZxIBdhaNnRlh0SKEkDqdEqDX+bflhxb8peQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wrwyr0L1; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-362f62ae4c5so146763f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 00:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719387154; x=1719991954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWdwFGLisZTjIZj5f6mqYa4O5wFiRQ0vmR5lx8cA8wI=;
        b=wrwyr0L1MGsVwH6dxLRNAqyCP/Fva8xMQbMoHupAcFVJ99AYr0N90Me0NaGaC+pDAN
         tbj7PobHmcwZy+UTYYX/dx04PyDWTR4kogSIC7gD0Nu2omgLLiVz7nNnKeShUaXpoSeV
         a0zfIgwxWBcHkW6/VU1i2wrgiZMVc+oeXWOwi02zGsQ2843tuc3oj/jcDlcdxcx+/1rs
         gSyYcmK2PqILa4CL3+AThOurdrmby1KAe2PRqhmRoxN+T/nej1e21fJpNp9emsl6G3G8
         WSGlY9jrHMHcMOdFPmelAj7LBBCrBXwt4qPiQyzftOYC0cFnzDozR4/vU7QL6WLuPbXZ
         01oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719387154; x=1719991954;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWdwFGLisZTjIZj5f6mqYa4O5wFiRQ0vmR5lx8cA8wI=;
        b=EdwLQDql8q1LsxUxplD7Ixob2TmxiFtjXU2LA7UyRSsXy+5CorDdg8TBfhImbaY4v+
         TZd8SmOK2Au3cmhaA630m/v8x90EumT2uPrSD5nWf/U9S/pDB/FhQoXEUhmTLFoIaI1t
         piGieBFWhLQR/mzUkTBfdH4qE26HKzelNdv8zU3/9aKDGttE9cI/3cO5i8/OWAIQHOBL
         pe3UhTOtrvfMQ9LTagEb9bzlyfeI+JMlst0qCnJ+PQpCEjqjiTQxcMo0kqoFlYO61TbT
         ImRkLbuno3CwTSRoy9CiB/Ncv7LeUeMXLvU/8+Mk3m7gAznHcjDJuF1br5gVcGxqUcRj
         n1UA==
X-Forwarded-Encrypted: i=1; AJvYcCVz+E2u8av7Uf2Z62NRiVI62BnHDo1w2aoWIBmLRBGXSZCOO2kABC27vNCbw/7karzbIXO1DQta3jLkYPvxWc+G3NY087sNXtYa/nuq
X-Gm-Message-State: AOJu0YzncVod4yfc3b9ujQYm2RXXJ1bZVPkXygbdmDnQzP9Dir8wpzKd
	1WFXpgEmB/xtCS7qcIB86T2fYDwB+jqdOO3PoxkeeP9u3l+r1/GUaR3L3eOZQN4=
X-Google-Smtp-Source: AGHT+IGJuKO4xRdWJJ6w9hrgqcoyAjnmhy1mlVONlk9q3lHadUvykbc5FStD6K1tQLlvYfQE0ICfmg==
X-Received: by 2002:adf:e410:0:b0:366:ed80:d054 with SMTP id ffacd0b85a97d-366ed80d15bmr7224161f8f.10.1719387153638;
        Wed, 26 Jun 2024 00:32:33 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a8c8f07sm14962150f8f.110.2024.06.26.00.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 00:32:33 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org, 
 linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20240625111845.928192-1-jbrunet@baylibre.com>
References: <20240625111845.928192-1-jbrunet@baylibre.com>
Subject: Re: [PATCH] arm64: dts: amlogic: sm1: fix spdif compatibles
Message-Id: <171938715287.1644768.879633042309393465.b4-ty@linaro.org>
Date: Wed, 26 Jun 2024 09:32:32 +0200
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

On Tue, 25 Jun 2024 13:18:43 +0200, Jerome Brunet wrote:
> The spdif input and output of g12 and sm1 are compatible but
> sm1 should use the related compatible since it exists.
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.11/arm64-dt)

[1/1] arm64: dts: amlogic: sm1: fix spdif compatibles
      https://git.kernel.org/amlogic/c/b0aba467c329a89e8b325eda0cf60776958353fe

These changes has been applied on the intermediate git tree [1].

The v6.11/arm64-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
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


