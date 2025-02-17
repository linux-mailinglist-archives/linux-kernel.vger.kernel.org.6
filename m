Return-Path: <linux-kernel+bounces-517114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1500EA37C57
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 08:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B395170DAE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 07:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EE019D8B2;
	Mon, 17 Feb 2025 07:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TOXVVFPE"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BD0194C8B
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 07:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739777561; cv=none; b=h/xk4sOrbY5FAfT0V3p6CmhZdgn+o7jHx2MPIam8YfE1vnn6yhn9lt2Kv4hcIyCB44EhxqVit2fRcdlgbZNOesVsugVYPFqw+4UrQo658/+rM1AOhfyoey+we+s3+eKFuJKSWpRkc+c+KSLKVEhYlch0tHhzJznYDyj/wcFV9tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739777561; c=relaxed/simple;
	bh=iOSp9K3fulh0VbLRdj1Bcq7Vd9vXiDQNcOEL0h9MGOM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BH+fvi5OjLNTLx0A2EMGgKPB9gjCx2l+6xKE9hd/BmUqMKj8qPz0maIFaaCb56E6dvkDAugfC5r0mECVzizTcXcizSatAmH4F4hBe/yHmaIepBwpDfe7+krjCZ6OyHkmiR0hSuKDy6JwY21LFzEpMWZnCYGYYJcTjPSq2x9Wy+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TOXVVFPE; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-abb8f586d68so135311966b.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 23:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739777557; x=1740382357; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Iuq9jtDgHZUGKQlgExINfZtY7T0OwXIUJbx8KDqcL2g=;
        b=TOXVVFPEBlAEA9l8JpUN1RYaoM/lQdXa+8Onu6qpDJANJ5bCR9EYtjkd0Ui+1AyEJQ
         X3uPImLr7wSgVFPjkWX7vK/zKhGYntLM3PEtcK+xYVqP3TERdHUYQjH4kXYq+ng2LTCs
         tutY9q7umGpv2XH2Jx/sRNvsAfiDsqrI+vNT0i3YmKbZhWS5OJ93AdDTWPCBuw4q5tJY
         +1L1rcOLjY6kH67ne1xuvQQpzYd1CXcCQ6K/WTrU5fh6P2OATL+I6DUXi+qN5COkyjUT
         EuISwzf4qHjJ0Wfa6Zf7t4hJ+bYxCKg4uwk7hnsU/0v64LGAsMvknTyj/66fjTOUn3g/
         zLHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739777557; x=1740382357;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iuq9jtDgHZUGKQlgExINfZtY7T0OwXIUJbx8KDqcL2g=;
        b=xQlv2T3MhkyTeUf27GBcyQyvmXZd+TQsjAKtzG7AdIeeiMZYxjG9ory4yY1v5Wvqpm
         qraIwngXnzIGcIvLOt7od+nUkTVU6vjkkpVR5RRnwjnhv66xdX7ukBboxDD4uYDw76QH
         aqoHa8E5F3PP5TfIjZupMMregBDldZQwdZhttASHplwaxz84TqBzBEln8raxEnixNJds
         VDlLiaVC2I1eCqocEekjYQyozqCV7ncXhqQWYiVzYqlxjALa6GP1dvpnBklO1k85qn0c
         QP0JJKYYccivq6kFvnwVIUAshWBzjvT2NiGmm7HQqkOv9KZ+DHYtrrjLB4wSDewkDxjk
         8vng==
X-Forwarded-Encrypted: i=1; AJvYcCXfd8vlFUROe+L/t+yxA4rNAU0q5zXijgvWgKz2nq4yWpIxD3LhalJssuIVi4petwTK/faZ9eC7sxJfQM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwahXSZHXGjNSUyaZYAuk0as1TeUjtf3BRiI0sVHlxrEMt8lXuR
	hxmtfVpiIi3C/FlMKZiXcKa0b0R+G6erLSQsuuwd1MCbQ6BVGNqxSrg7DgXUE18=
X-Gm-Gg: ASbGncsOqNo3g2gM7AFlykwORrSrOHiHzBtknP7bLuG3tW8NMVig6daYz6g8gJUGaxa
	8dboyra6br/GLn2CMbsmeLV+FN49rZA5P+VVbkaBq/GFFm1BowXp8EYPj3bQCGNhCzkPNqHkdkd
	rcGETNL7yLIp8BcRYW0TIH+pGz+mrm1U6giokIbhO36iwxmQHgINjJIATQ8OicuYK8ajUiujPdi
	+VwafAUfGcL+rKvigMl4wO92NifpX0vGmZkX4P0YqTRvbIp7N/37aVOBUUrbitsjBzR/Nzi7F77
	neC8NrAkOtPw16LDKkTW
X-Google-Smtp-Source: AGHT+IEcdCzKmfW6zdCdnOroccwgNmmDLOlJUJcE91OJUWqcSxVf6IhB+cxML7fRc8rv7wfAKU/7HA==
X-Received: by 2002:a17:907:1b23:b0:aab:c35e:509b with SMTP id a640c23a62f3a-abb70e435abmr973427866b.55.1739777556866;
        Sun, 16 Feb 2025 23:32:36 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abb916db37bsm238238266b.165.2025.02.16.23.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 23:32:36 -0800 (PST)
Date: Mon, 17 Feb 2025 10:32:32 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
	imx@lists.linux.dev, Jaroslav Kysela <perex@perex.cz>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	sound-open-firmware@alsa-project.org, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 0/2] ASoC: SOF: imx: fix a couple Smatch bugs
Message-ID: <fffa1613-72e8-4cd0-a4db-b6b13a5222e9@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Fix a couple of bugs which were detected using Smatch.
(https://github.com/error27/smatch)

Dan Carpenter (2):
  ASoC: SOF: imx: Fix an IS_ERR() vs NULL bug in
    imx_parse_ioremap_memory()
  ASoC: SOF: imx: Fix error code in probe()

 sound/soc/sof/imx/imx-common.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

-- 
2.47.2


