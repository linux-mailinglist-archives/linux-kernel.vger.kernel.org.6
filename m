Return-Path: <linux-kernel+bounces-434640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB42E9E6940
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19616283252
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407F91DDC33;
	Fri,  6 Dec 2024 08:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AD+EvKMS"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3132192D89
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 08:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733474938; cv=none; b=H5nciDAZykmcRCOctMOmImYXCMeRdI/g38WY6i0BBk375N/Wkv+Y3EynD7oxaq9OGOApL0/yX30KragaS3bksTOx3nWqYb5hJwmYI6RQ29pdHITIX00turrUG46R37C3m0/Kk4QyRwjlL/cmpseIlKS1CalIz91dIhipu7PdBZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733474938; c=relaxed/simple;
	bh=utjkZbDeEMTthCs80VCBUvjS3enz36ctYpoj7DLBIEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iE+Rk/kpFn399XHDkaDMYH1LKGmjkZg9Yx6tnHFMDi5/AQ9gON+fMOQFvyvrOM+kBrtHZxCHUoUZH7+WcxWQWiKZcx5D5UNmVtM+Sk0n4o3WZ4TrE6CAIbzN8owaQqDqpArfs25ZxBcPvNJkSmwdzz4GfxbYU6kICkjEW/2OQxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AD+EvKMS; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-300392cc4caso614721fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 00:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733474935; x=1734079735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1+KHZbWUUIbfPMrkQ0dg3yxh8EkZEBHyzYKLApYVQfA=;
        b=AD+EvKMSiOilJIqp62aW6ZPUUB1rC1LCIqSWSIjJ6rcEwtVc3TRLKj/NytlOS7mME7
         sidpkXc6eHIjY5eDC9ibYP+IZmxwR+RFMd0qAjh29kaWVWEmMlkjzDpY4cQHOx2rFwkQ
         i9dHIxkXc7UZTep/CtoaCIBENsbvTb5NLDPm57ozrKDlNWj4VhHeQXBZv+0DPMJAK4HO
         LCwj3IwayqoFmbHXvnsDIKUNIcqwpNbC1qSqqiu6520tsmZmpL50GBeKoUaqv1GqlSXh
         pqGZH+2eL0/wovW5TTwPV75SaOnOrda4PMwvGvl/yVNVPcTgW4ViHIjscH3YRjqyp59M
         CDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733474935; x=1734079735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1+KHZbWUUIbfPMrkQ0dg3yxh8EkZEBHyzYKLApYVQfA=;
        b=LPO8FUgtYclzBnSIbTpHXz2WbLACC5t68kh8bjz+p/r4Qp+BW9ReNeoufMGnEFCqe7
         TWk+1KqADVJjsRYwXgbqby0HtTDx8v/gfOpRbXdjN+Cj4D5tfZYQc0eJ3eUVhup9UTYr
         vDuWfZ7X4EAaDYFezQQMCU4ph47e+TniY5dvmSJ8vr7EMfNYwjpfHrdhRn9NsT2YBAtS
         b9oapxVxQj60YkERPzVIw6YcqmgKh3u0ktJreSGz+NmUDjV3cOfHXRo7wz4fP60SWtky
         q5ha5Ve99KA9YH9fuBjnFuYAJtmy/N+pxfavjL0qGRDamxNKsiT1XYRhoCMY9Atnj/wZ
         YeMA==
X-Forwarded-Encrypted: i=1; AJvYcCU4cm98S2bzvk+ES0HZo0x23i3viYuK6qIfbUm9st5hRIvZJgBUs8QqBl7tkFVRF73IMHX/IVAcg7MjlCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAhnSNPPtHvWsClt0uQsChqZmZ8DUHaSrUn5aJU6fbBhQ/tP1+
	r7FTjvIfIt0LKxqbPlPSLvoc+LoSKTWlc8y3uAniJY4HdOcUwXVL7kpJU3UzJV0=
X-Gm-Gg: ASbGncvr2OzK8d+VoRL4UK5J6N+bdOA05MKrNWBFZ+ZVJu/UBcwdXgm/79E3gQeG5iJ
	PZroOTaKMv41B9aA7y+Hypa6tVRXL4cndQr/J+VerPqBwveKeVD/NDXuqkG1DUYQmyrC63zO0P+
	C97pL9NLHeEni94b0gzxWSXwN+EixQN05VnxSR5rwWU+WyI0COFvM0zVQVlm7tjTfLD1qPuiaWj
	njoChLXwNcHTB759aWGhUa+lOaqhkpOiKeK8OXr2Y5O7kAsoEYLk6KOlsgN25WEYLPlQ/JLeuBm
	CcavdajtICtboGRLahtaEiO8
X-Google-Smtp-Source: AGHT+IFhY/F+2PQCWkWIZiH6/atvzrmubiERnGlL5oxg15r9QqhSnIsJkiSQjR3EzbfRECrt0dNZkw==
X-Received: by 2002:a05:651c:505:b0:300:2ddb:aaa5 with SMTP id 38308e7fff4ca-3002fc92a19mr6541821fa.30.1733474934985;
        Fri, 06 Dec 2024 00:48:54 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30030799f35sm1374041fa.93.2024.12.06.00.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 00:48:53 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.13-rc2
Date: Fri,  6 Dec 2024 09:48:52 +0100
Message-ID: <20241206084852.119710-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v6.13-rc2. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson

The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.13-rc1

for you to fetch changes up to 87a0d90fcd31c0f36da0332428c9e1a1e0f97432:

  mmc: core: Further prevent card detect during shutdown (2024-12-02 15:37:16 +0100)

----------------------------------------------------------------
MMC core:
 - Further prevent card detect during shutdown

MMC host:
 - sdhci-pci: Add DMI quirk for missing CD GPIO on Vexia Edu Atla 10 tablet

----------------------------------------------------------------
Hans de Goede (1):
      mmc: sdhci-pci: Add DMI quirk for missing CD GPIO on Vexia Edu Atla 10 tablet

Ulf Hansson (1):
      mmc: core: Further prevent card detect during shutdown

 drivers/mmc/core/bus.c            |  2 ++
 drivers/mmc/core/core.c           |  3 ++
 drivers/mmc/host/sdhci-pci-core.c | 72 +++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-pci.h      |  1 +
 4 files changed, 78 insertions(+)

