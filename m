Return-Path: <linux-kernel+bounces-510996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3151FA3249D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00C5D3A9847
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C202C271839;
	Wed, 12 Feb 2025 11:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iKnKNN+R"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393532046A6
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 11:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739358956; cv=none; b=rJOcrj6O9cbJ8BPh9+Ox0G3vLi0vKjO/pOlI8XGOWrhVuFuUJ2a7fTP6OZ9VB/OGoN45FjHyEIhjTWz1FeVZcZCnDrskTL8wMh6OOdZfwyeZ5Bka//Caw1pA4Frl6Vopd4ZM4Ouw/wTVOzY4Qm3RaHAYEwI2GDvnwbDha6HoK14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739358956; c=relaxed/simple;
	bh=KmLVO3U+iYEBCW5o4eq2WIngopSvAfgV6pjFjxxYZ5Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=f9izC5geT4BJ7DnMn7EFP4yjCNfCEEa2gG1IIcIIOAC8/fWLgGTlN5SMU2xACDt79CbtiWX4G3NcqHGOPlukCLHAev9e9KakQgzMMrEX2FrAJIRWG+TVpFFnU/Hs/x5j9J5XrPnVVkUjf01Wd7jWuU1fNuj4LcM0/G32fx0P6rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iKnKNN+R; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38dc962f1b9so3112371f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 03:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739358952; x=1739963752; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WWxCp0GqUGglcxropI6IErz42Kj74gEydU4plAioMCA=;
        b=iKnKNN+R7tePyntGwRysOoG/b4ZHGPKpSRPTognZfRc9J8kR9Qk8b5EuJtZTjkmvKC
         T65zey4BdRtBVr3bNo7wA43zTExEyzjVio54RUU28kRAjtujLRrZGgU9P2eSil4wkMDx
         sSV2jTzd1ejdroDVj3GU69/VnEH2Sc0yWxmxE+V5kDIJcWhr+yjz9sLbJ8wuuWsvr/Xt
         99rJmG+1NihsjOQuzA90/pK0HUcld+O6Hk8gOtoOoestzH725EqS2wCjh+efAPIDQ2mH
         xAu00eYJRI/nFj5I8RMAiox9G4wBEhgbmimYCyp9JIKMhrfJZdBkKwrNhJ3PWuFMFx5a
         zWyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739358952; x=1739963752;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WWxCp0GqUGglcxropI6IErz42Kj74gEydU4plAioMCA=;
        b=jJFOKgvc1vngBkphLD8h6ZZVNfOGQrcFQWkGxIGc1HK2mM5YWtDNkcl2MlVO8zdkLz
         Ez0nl1ufOOLiHWC94g6wAHZFSfY+qSc5fqNsdTLqii+Iog2FaoVngLDcwvdnFJ1siHQs
         KRHKMxdihAYxtgUhUfKqd+1MvU9LhGB34RIm2v2EHG5Qrdnsm4KnRmBxkftA4XHY+WSC
         QxLYkRGUg2o1LoYNlpE2PzSRcRw3fuTF7HVzy6I2X2SBmn4kY2R8UrOfXU6EvCR5Kd4r
         NJuDgBFCwr59j1icEzcEgsOjTd/d6md/a3+RYkur/Ay/9/YpR+qZTdbHm5A/KUE+Af+k
         5dgg==
X-Forwarded-Encrypted: i=1; AJvYcCW4UBGw59TS8NIoHd/6gl/wR0jWUvjnkqV5BI5AS5kCQCpTrrHHyn4VlAs/xc5cDW/9uKI0ILA7PVo1sUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqeKeZUZeQ/sBdBOoqyNt8iXoi22gZryo0RaRlui0ezOzG5ovg
	Ow/A7sGnAFEQ58V3mjasJ5p5JfesUrP1JXeOAhhRTSjsUr+JePODMSLfYGtKFqY=
X-Gm-Gg: ASbGncswgItRm8W43lzD83jePk9VCU7pRDQmADqn+J1UCZ3aoKwH91Yp9j/T4nQOD1b
	v+E65Y3gnQnSIYN3Uj3+FF3ilIqzb2ulsw+6eCpjt1Nrh/P7VsoUr4zUInYvPmFxa6zNztaudkJ
	EcUV7WflzzJrMY802F9DgBvmEaxP6qpmIJF9DzggTJLjL/JghqQ7NMopI/iPXUqKUQBzwjdT/Ky
	UuuoGNkT2b/2StVdXpyruly0bHJygfkKGP5FerrerE5zmL6YIocaYW8rjK9mLaoh40IFmxW9XWd
	9/6YSY+HHLDigTrY9nMYvnk=
X-Google-Smtp-Source: AGHT+IEB8DPUJVTBcgIwTQ6Z6zvG98TpNWXfZaHucYN4Dxa3b44v/ASA0iItfsERoar6F0CFs4PV1Q==
X-Received: by 2002:adf:e60e:0:b0:38b:f4dc:4483 with SMTP id ffacd0b85a97d-38dea28c1e0mr1755786f8f.29.1739358952465;
        Wed, 12 Feb 2025 03:15:52 -0800 (PST)
Received: from [127.0.0.2] ([92.206.191.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a07ce08sm16538325e9.39.2025.02.12.03.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 03:15:52 -0800 (PST)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Wed, 12 Feb 2025 12:15:35 +0100
Subject: [PATCH net-next] net: wwan: mhi_wwan_mbim: Silence sequence number
 glitch errors
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-mhi-wwan-mbim-sequence-glitch-v1-1-503735977cbd@linaro.org>
X-B4-Tracking: v=1; b=H4sIANaCrGcC/x3MQQrCMBAF0KuUWTsQI3XhVcRFJ/k2A2bUJNpC6
 d0NLt/mbVRRFJUuw0YFX636tI7jYaCQJpvBGrvJOz86786ck/KyTMZZNHPF+wML4PmhLSQOUaK
 PMspJhPrxKrjr+v+vZGhsWBvd9v0HyF3ou3kAAAA=
X-Change-ID: 20250206-mhi-wwan-mbim-sequence-glitch-cdbd2db5b3bb
To: Loic Poulain <loic.poulain@linaro.org>, 
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johan Hovold <johan@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.14.2

When using the Qualcomm X55 modem on the ThinkPad X13s, the kernel log is
constantly being filled with errors related to a "sequence number glitch",
e.g.:

	[ 1903.284538] sequence number glitch prev=16 curr=0
	[ 1913.812205] sequence number glitch prev=50 curr=0
	[ 1923.698219] sequence number glitch prev=142 curr=0
	[ 2029.248276] sequence number glitch prev=1555 curr=0
	[ 2046.333059] sequence number glitch prev=70 curr=0
	[ 2076.520067] sequence number glitch prev=272 curr=0
	[ 2158.704202] sequence number glitch prev=2655 curr=0
	[ 2218.530776] sequence number glitch prev=2349 curr=0
	[ 2225.579092] sequence number glitch prev=6 curr=0

Internet connectivity is working fine, so this error seems harmless. It
looks like modem does not preserve the sequence number when entering low
power state; the amount of errors depends on how actively the modem is
being used.

A similar issue has also been seen on USB-based MBIM modems [1]. However,
in cdc_ncm.c the "sequence number glitch" message is a debug message
instead of an error. Apply the same to the mhi_wwan_mbim.c driver to
silence these errors when using the modem.

[1]: https://lists.freedesktop.org/archives/libmbim-devel/2016-November/000781.html

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 drivers/net/wwan/mhi_wwan_mbim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wwan/mhi_wwan_mbim.c b/drivers/net/wwan/mhi_wwan_mbim.c
index d5a9360323d29df4b6665bef0949e017c90876a4..8755c5e6a65b302c9ba2fe463e9eac58d956eaff 100644
--- a/drivers/net/wwan/mhi_wwan_mbim.c
+++ b/drivers/net/wwan/mhi_wwan_mbim.c
@@ -220,7 +220,7 @@ static int mbim_rx_verify_nth16(struct mhi_mbim_context *mbim, struct sk_buff *s
 	if (mbim->rx_seq + 1 != le16_to_cpu(nth16->wSequence) &&
 	    (mbim->rx_seq || le16_to_cpu(nth16->wSequence)) &&
 	    !(mbim->rx_seq == 0xffff && !le16_to_cpu(nth16->wSequence))) {
-		net_err_ratelimited("sequence number glitch prev=%d curr=%d\n",
+		net_dbg_ratelimited("sequence number glitch prev=%d curr=%d\n",
 				    mbim->rx_seq, le16_to_cpu(nth16->wSequence));
 	}
 	mbim->rx_seq = le16_to_cpu(nth16->wSequence);

---
base-commit: 4e41231249f4083a095085ff86e317e29313c2c3
change-id: 20250206-mhi-wwan-mbim-sequence-glitch-cdbd2db5b3bb

Best regards,
-- 
Stephan Gerhold <stephan.gerhold@linaro.org>


