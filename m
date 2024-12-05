Return-Path: <linux-kernel+bounces-432506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CD39E4C47
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 03:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B689F16A510
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 02:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A26E18787F;
	Thu,  5 Dec 2024 02:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xnEOumgz"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58DB79DC
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 02:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733366031; cv=none; b=ToACiq8GM9qJh9mRbTeyq/wacR5L+o3T27rKEV1MBd9PF+DJTIOUyD7EQ22NYvhIf39EtKW/TfOKdS7TUGV9GQC2wcv8CLTDFspJcRQ1m5ILCWlDKFJAUyay6IuUAuykepTDIU+pP+zvWIo4Yea2bGlDTW3U1CRt3PHJjOpVs6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733366031; c=relaxed/simple;
	bh=jpl9iVOYWeTiM6kCN3P64k/PHIdrq2ziUsX8zdUfXa4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p7g1FW3ktOwp+lUTzPuFHsQULyTAJFR2NVDTwtP+OZ7CmPeo4bNTgVKSrNghidYGga+rv6z+PcqHGVx314a8vQK+CUTI/xiHXABzLAZI3DKb89R9vwRsYbrJZLzoJvshbapH3XGtlLHdYW14fTlpn0e90AOoy1QcP5ANEp/XmGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xnEOumgz; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-434ab938e37so2725945e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 18:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733366027; x=1733970827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LEvSg5n9dPi25fVhvj+TfkDWWQ8DpWSUc0fAXy4y1N8=;
        b=xnEOumgzs87VUtt8xN8gVEOeFcrc5lUREn41aCvYTsk7FU1GHd7feedvLt2NHseiiN
         cik3i880J+9mc38lBEN2RR/KhmB8+hFjsCGCibyXi8JEexZh3H+xuyGvHVcna2cZQBLt
         JmClvzxoAyn9dg1Ja8hbWrtpffdRCUBMos/rOitmhfz84Tn3kQ94Yrf341eXW9dCSueB
         Tm9xiwnceU9zUH7HQq/igN6lqHGGKU/YpED3KR9ezKMUUol9PFq6u4EXbFs43H36857y
         c4pMsdcvjz+oEOeeMpG+DY3FN0ZpUvv9PwtQhF2XMxH3rOFVPnXfExFWW0JF6Hf+LSkb
         VVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733366027; x=1733970827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LEvSg5n9dPi25fVhvj+TfkDWWQ8DpWSUc0fAXy4y1N8=;
        b=VV8ubxe+YIAe2snTSPWve7BJZxgCvS4LR2gEaH0FzBk/h4y7vagWWpWcpUVHEFGEBx
         A6ISNtCsWJVSo4SlAFuoZ+UQEGer3y79znEAzBwb82wTFdKNxhV1LFzxQWK/uh54iQU7
         g+15fU7pPQlU6uryVn0eHiU/KY6Asco8jnYsq1hK8nx25iZXcj0gdXq79ZbJGSVhUxd0
         DnREHfgkQE2B7g7zJhyD65iA8Mmi57UbTGyGYq/cBBkW6Uk1ZQORMpRNDta3qhB+rReH
         OD0R6l/uC2evQKgUPDdN2EC4k3z6PSUSfVeZG7fpq+zS5bxqWJVJAzOwYA8c61yV2r1l
         UA6w==
X-Forwarded-Encrypted: i=1; AJvYcCXQnK5v5q1nhdgwWuoGj6BKg2//IzLeWqFsPpWLrJp8ZICIXHwvmITF/P/iLLMPp5/Dz4jEptFIqKow1QA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO5jACqKf/q/9YJxKRMzPHJ55PkeD7S6C9ZWB5JIqb9vWdQ1dM
	aeHVWVDyp388AZhWFs1kk5yYb7x1E8ALYylTtcmJZxgW9gs6TChixmhDIJPZGIA=
X-Gm-Gg: ASbGncs83rhDyu0lS4/nu3rINunlWqgnzm350ABxCZTx86hLBKbJWT1EyCp7/DJyt9p
	dQi0tb67mvX7GSEWwfmcKVSIR5stIWtiRw1zImw8ZBtQBqQ2CTM7E5CkkWIi7fIGmxS68/jQmG1
	rzQTXS5fwhQGvqBdytWA40Ov1peldrR3mrJSgk/qRkUAks3rc2oZJMjMTIB17wJ/ZHf2dCyUnku
	5ySS8YCO5+3oMsd+Dw04zAmiHV3GghxUwMAgaGT4v0a48bRY4ISiW2LJMhNbUCwlWi/
X-Google-Smtp-Source: AGHT+IHh2by/doGLjpPWCzeNRn54791OntfvKje7jWHAMUb5dn6DTgMFuSYzcKySXVmKinBfVAjamw==
X-Received: by 2002:a5d:5f46:0:b0:385:f349:ffe7 with SMTP id ffacd0b85a97d-38607ab5c9bmr5625677f8f.2.1733366026988;
        Wed, 04 Dec 2024 18:33:46 -0800 (PST)
Received: from localhost.localdomain ([2.222.231.247])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d5273440sm44444325e9.18.2024.12.04.18.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 18:33:46 -0800 (PST)
From: Alexey Klimov <alexey.klimov@linaro.org>
To: broonie@kernel.org,
	konradybcio@kernel.org,
	andersson@kernel.org,
	srinivas.kandagatla@linaro.org
Cc: tiwai@suse.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dmitry.baryshkov@linaro.org,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/3] db845c/rb3: add i2s playback support
Date: Thu,  5 Dec 2024 02:33:41 +0000
Message-ID: <20241205023344.2232529-1-alexey.klimov@linaro.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are i2s signals provided in low-speed connector on such boards
as required by 96boards spec. Looks like it is possible to actually
playback something via these pins after adding missing parts here
and there.

I tested simple widely available cheap DACs like UDA1334 and PCM5102A
and they works just fine without need for mclk. I guess any DAC that
can handle 48 kHz and 16bit will do.

In theory db845 can work without mezzanine board and this provides
one more use-case to playback sound and not all mezzanines have cosy
audio connectors.

After staring at
https://patchwork.kernel.org/project/linux-arm-kernel/patch/20210621074152.306362-1-judyhsiao@chromium.org/
I suspect that this might not gonna fly since it requires dummy codec.
Or maybe specific half-dummy qcom codec for such use-case is required to
verify hw parameters. Couldn't say.

Alexey Klimov (3):
  ASoC: qcom: common: set codecless link to be a backend
  ASoC: qcom: sdm845: add handling of secondary MI2S clock
  arm64: dts: qcom: sdm845-db845c: add i2s playback support via LS1
    connector

 arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 43 +++++++++++++++++++++-
 sound/soc/qcom/common.c                    |  4 ++
 sound/soc/qcom/sdm845.c                    |  5 ++-
 3 files changed, 48 insertions(+), 4 deletions(-)

-- 
2.45.2


