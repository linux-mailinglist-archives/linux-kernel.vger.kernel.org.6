Return-Path: <linux-kernel+bounces-382072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3F39B08B0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AFED2825A4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679E2176237;
	Fri, 25 Oct 2024 15:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pg8sVaGh"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B5215D5A1
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 15:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729871011; cv=none; b=Pk9qpwWFU7zs8bt/9vkXSlgotC05Ur0i4f//z16knYdioqYkfJ0TENRQufUqWj5oQw2SC1Gp4DAZyQ6VbKVphpte2e/Ib5bN4cT1QCkZa5+oAq0j8Eq20Kqde/QjxR2n1e2OAmY3w69d5q7Vr+7+Y7mQeJXBQE7qfUJWlkrqguI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729871011; c=relaxed/simple;
	bh=mKhfq1+puCapBn/RUaMC4AAAqYtKyCwyZwVMFXha+Vs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DHrR8nYOqK/l2MxdVYt60bI7WmqqVZt+1hezrbTqiUkFtyccGjmIvMwY9ppPCp5EhX89NDhw/8pwBdgLpSQpc4rlWoSxSHP5o9+jprWgXnr8D1M00as/uDHlfGDjd+C2RG5LoC8dP8k6AWDFtIvvm2Nlimws0DJMMcaZXfloQxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pg8sVaGh; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539f76a6f0dso2111731e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 08:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729871005; x=1730475805; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T0q2T2jCc+5Gv2IPhR62NKSUWGvWUihVhcOzP/hoqIs=;
        b=Pg8sVaGh3jgx7SIQavBO/yarjZgTKoZzSFJaLdXPJjSGqxESrr1nfsV74BUopDIskU
         tarjmPTuwq++7K6yfN4jliZzbhI8+JGJcExFGSQxEQOqKKBldDy+VtOyBVEXCm6nzja2
         0dJYFVk4m9CCKBmoY23VgXnYmc2VImhR4oVOhU6nTrhKwGzlsPPFaEd3kwyPuM5QXg03
         /TQPOX3/MqBFmpxAjqvpikRO0rU77gy7B/mKzVeuuXAJqaRcOEZNEM6r7SJv3APU2oBM
         zrIDvrqWxA1f9Pbc98xmVReQyHZ7gRHmCsCCdkNlmfFrx1E25/0u8Vff5O0oowtHc3R2
         hFFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729871005; x=1730475805;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T0q2T2jCc+5Gv2IPhR62NKSUWGvWUihVhcOzP/hoqIs=;
        b=vohL9s8fu+fHrNSi0M3Rcu5CxH1M0Fu+95P7MmYuBjg1K+KgQ/3h67hBjG4hAtJ/tr
         aSoJ1NfztQQdFzEUSQKo1REqWl0pQZpv88BZrP68YqZtPJobt1H8hSL3YKenfGqTuHn4
         ymQlC/b+RLgsjKsiF7cgdnwQk5hhbi3KiPMqNg5GFLXW0p20HHznPTRYGTBTsD7DtRxY
         Yq5zU7acRasU8G4Gt6jzpgwS/ZQigMrPOXN7K/Ba+EEjbmlXSEC/dSuEgfbJxi50z9sl
         EADvUUf573jY48fjErd8VezDkCPLiNNHtr50HB5v7GDu5dJjx8l3AZkxC/I9X/MWhuk+
         f9uw==
X-Forwarded-Encrypted: i=1; AJvYcCW+E3kDcq04/RAiMGDy6dyrXjSpo4UwdaoQbMlNQHfRQP+pVB2ZkjASMwQlpK2FriXy+xOd7+MWPB7Sh1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhNlts5vI7xiORDvsfZWI3Iuy3JKJvNtoTKmGeaLZO/5BPmuVP
	aaoJW7OCYP4HhA/FIAHpa8z0f3N0iiFGZHCS/HUPvX2eih+6KKw5w0+WVeG1cug=
X-Google-Smtp-Source: AGHT+IEJDvJfz9PQjE+CLFa3BEQgscijy/h3LHlHsKI/5k7HVTeduAwy55QLIXYmOX9gP9309kPoJg==
X-Received: by 2002:a05:6512:3402:b0:53a:aea:a9e1 with SMTP id 2adb3069b0e04-53b1a3a3521mr6945676e87.54.1729871005410;
        Fri, 25 Oct 2024 08:43:25 -0700 (PDT)
Received: from [127.0.0.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b479ffsm1829092f8f.49.2024.10.25.08.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 08:43:25 -0700 (PDT)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH 0/6] qcom: camss: dts: Prune and tidy x13s, rb5 and rb3
 CAMSS dts
Date: Fri, 25 Oct 2024 16:43:22 +0100
Message-Id: <20241025-b4-linux-next-24-10-25-camss-dts-fixups-v1-0-cdff2f1a5792@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJu8G2cC/x2N0QrCMBAEf6XcswuXkAr6K+JDTK56oLHk2hIo/
 XeDj7MDOzuZVBWj67BTlU1Nv6WDOw2UXrE8BZo7k2cfHPsRj4C3lrWhSFvgAxyjzyl+zJAXw6R
 tnQ0u8iXkNMYzT9Tf5ird/Eu3+3H8AM+6WVl5AAAA
X-Change-ID: 20241025-b4-linux-next-24-10-25-camss-dts-fixups-1a094dc5a60f
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Depeng Shao <quic_depengs@quicinc.com>, 
 Vikram Sharma <quic_vikramsa@quicinc.com>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.15-dev-dedf8

This series does a refresh on upstream x13s, rb5 and rb3 dts.

Firstly:
Moving from static dts files for the mezzanine cards to dtso.
A recent examples of this approach is here:

Commit: bc90f56a1699 ("arm64: dts: sm8650-hdk: add support for the Display Card overlay")

Taking this example this series converts rb3 and rb5 to the same overlay
format. The apq8016-sbc-d3-camera-mezzanine.dtb is omitted from this series
as I haven't had an opportunity to test on this platform but, will do so at
a later date.

Secondly:
rb3 and rb5 both declare clock-lanes in their respective sensor blocks.
Neither sensor actually requires this declaration.

Drop in both cases.

Finally:
Declare CMA heaps for both mezzanine boards so that libcamera's DMA buf
will work with upstream rb3/rb5 camera mezzanine boards.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
Bryan O'Donoghue (6):
      arm64: dts: qcom: qrb5165-rb5-vision-mezzanine: Convert mezzanine riser to dtbo
      arm64: dts: qcom: sdm845-db845c-navigation-mezzanine: Convert mezzanine riser to dtso
      arm64: dts: qcom: sc8280xp-x13s: Drop redundant clock-lanes from camera@10
      arm64: dts: qcom: qrb5165-rb5-vision-mezzanine: Drop redundant clock-lanes from camera@1a
      arm64: dts: qcom: qrb5165-rb5-vision-mezzanine: Add cma heap for libcamera softisp support
      arm64: dts: qcom: sdm845-db845c-navigation-mezzanine: Add cma heap for libcamera softisp support

 arch/arm64/boot/dts/qcom/Makefile                    |  6 ++++++
 ...zzanine.dts => qrb5165-rb5-vision-mezzanine.dtso} | 19 +++++++++++++++++--
 .../boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts  |  1 -
 ...e.dts => sdm845-db845c-navigation-mezzanine.dtso} | 20 ++++++++++++++++++--
 4 files changed, 41 insertions(+), 5 deletions(-)
---
base-commit: a39230ecf6b3057f5897bc4744a790070cfbe7a8
change-id: 20241025-b4-linux-next-24-10-25-camss-dts-fixups-1a094dc5a60f

Best regards,
-- 
Bryan O'Donoghue <bryan.odonoghue@linaro.org>


