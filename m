Return-Path: <linux-kernel+bounces-517443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE62A380F1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A3FC18909A9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F108217F40;
	Mon, 17 Feb 2025 10:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWzqQik1"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B3E21771D;
	Mon, 17 Feb 2025 10:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739789781; cv=none; b=oaZs7fVSbtnJN0N23KKBDOju+jJpjnfL27YzfqbZZV6Cr1iktb3YS+2UJUnnAnsyoLnmkBdXOVk3Hr/Ml7gSvevDPVBXA+pU7PSBnvGl+Z878XO4zFE9Rc45e+8GoP8wlESgbRJIp2RMmnkFYOTOmwqYMh6UE5SKg0CHkfSsEO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739789781; c=relaxed/simple;
	bh=BG4wDHqcON8TEcpNYPQ428+RyIbeVxbdy7bRcXAvmOw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jnSbBMrsIAD/1ydmjZ9jzzlexvZ4x7LePA5j7Me7ac0XloK4dgVCzNt6UdEoam1ArAP32SP57RFOR+4EROULzaoLUDXhTp28iM+kY/giJf3IeaBNPLiOrQudIuWAjmaa+iMauv5yfsX2BSo4UtFzn+mq3yAlS7oEJeW2AgVhAQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWzqQik1; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30761be8fa7so41991181fa.2;
        Mon, 17 Feb 2025 02:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739789778; x=1740394578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ena6zfdE32S39d9z2op7ggALKCuJxnepntNWa+pRRVE=;
        b=PWzqQik1p+Yg1CNPC/Ci9fFnQDv7AZmZ83w2JEo6w4HGAmhyyLbYmBs9VH5042UiAi
         sbbXaBaTLMlYjiiyu+PctZDRfb1/hjlNhaYW4iIFtFkxNh1FjKnOBSXOZFbQXol7Ww1x
         skqcq8awH/IEzm4PZiKkv83dJlG93RZ+MXfY0bs2M8u4iktP/cOaKW6xZIYnv8vzpckl
         M0zcgyWSYZq5CeOoVJMC74ya2tnJHcEEsINeT2BxgDen5WwHOawy7tMPfgeRdPSvQZDx
         3GuN/PTuwiyCaP5GeQyKVm+FUOgyCiNsQw0E4vuJnSV9rim3+G7N7UUEb8Rx0x+fSWOv
         qpgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739789778; x=1740394578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ena6zfdE32S39d9z2op7ggALKCuJxnepntNWa+pRRVE=;
        b=butJWrvDg+BgliaX2LJmk8KSYAw00ZNjey6sUWcuBUZdqY685ASrNXnI979BZ5MqaH
         mM1ny3K6goyLgLpCNIBMv0oJ5f3oma2/GrBg/J63TEGGxtC4v8Xqk4D8ewMGppF3HOaT
         zp5hUma0gHwV3Na7keDjzHkDhqrWbR73F+tnzqqqVCUx8gPoixMjxAZAHWKb8ijRQ1rA
         us8crs6G1WccmbBxEtqM6e3fkxwtdv9VEwFp+D0vRcHVF0EvAyJR6OoeYc3G0eQ36MoA
         NRDb9PST9afIoarzWW/YKsFtzHc5OcMNvIOjjjT1JdWk9lS1Wv2HUa1JvKTL3xAKvCR4
         kqVA==
X-Forwarded-Encrypted: i=1; AJvYcCWv9rnNjU8rHWGEvPswRX4bPI/DaGnH2sVDaCOKPmZJT+IZ8IROqcbM0fvDfEXoqvx/maKLivXX6hdV@vger.kernel.org, AJvYcCXRNwk/zlN6FCwv0mO+hN7Yq09PyQSne++jW58oSUsw0cBKYydw+4MV3PwDWrmAMGkcTy3eB3zM714lHUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzARC6jzmaUr2VlWn8UD985jqXagTILV2fuddzCPrqnFL7YpriS
	MvEU6rSw8iaaY5dyXyjgKWtCJlBOdbFRg+xmcGXC5kjamhFgbruE
X-Gm-Gg: ASbGncsDvVoYA+mkAlyjPd/6WK/VBaYHpxB1YVdpV9GEx0U7aL+obYe4WyTGo4PItkI
	1SAf3Y+lLvQaLq8DaXhzMNat3i1d0Xt8nNHYgRtG8ehBPamWZq4Q7nkJ9Vudqz08+iw8hDZwpqj
	M+WjeyyrpQDPqlW9UM6OPBbYEgGSE/8vo+e1EJXncGyb1VKJSG4G+fRQpji4gcaia7ryORGR90C
	2nTUGi9O8trHPDiVC0hJxdpUJlbfRSJPTfg9uld1x4pcSOc2uWrc+3pXExdIbxCAB3xNfu+o/gT
	NwFe7GI1JmevfPRaMkFBViu2oJOyYFD3DpHegXVSTw==
X-Google-Smtp-Source: AGHT+IHi06TCrL2EABDwDjY55oyj2JtDM4jJLQbdiL2uplrx3zg24fJUt5uD3GUzRR5Vjkrul+WOYw==
X-Received: by 2002:a05:6512:114e:b0:545:2eca:865 with SMTP id 2adb3069b0e04-5452fe8fdb7mr2521288e87.47.1739789777766;
        Mon, 17 Feb 2025 02:56:17 -0800 (PST)
Received: from fedora.intra.ispras.ru (morra.ispras.ru. [83.149.199.253])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5452b496aafsm1157086e87.29.2025.02.17.02.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:56:17 -0800 (PST)
From: Fedor Pchelkin <boddah8794@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Fedor Pchelkin <boddah8794@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	"Christian A. Ehrhardt" <lk@c--e.de>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Benson Leung <bleung@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Saranya Gopal <saranya.gopal@intel.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mark Pearson <mpearson@squebb.ca>
Subject: [PATCH 0/2] usb: typec: ucsi: avoid problems during initial PPM reset
Date: Mon, 17 Feb 2025 13:54:38 +0300
Message-ID: <20250217105442.113486-1-boddah8794@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch of the series is intended to fix a "WARNING in
ucsi_reset_ppm()" reported in mailing lists [1], in bugzilla [2] and
distro-specific bug-trackers [3]. I've got the same splat rather
frequently occuring on my system so took the patch [4] proposed by
Christian for testing.

The second patch is all about timeout issues during the initial PPM reset
attempt which I observe every time booting my Lenovo laptop (I'm not an
active UCSI user so didn't pay attention to them before but saw this
problem while poking around with the patch for WARNING). The timeout issue
is not a recent regression and it is reproduced on my laptop back to v5.12
at least. That said, this timeout also sometimes leads to the WARNING in
question because it is used for polling the CCI value there as well.

Link to the initial RFC version [5] with comments and reviews.

[1]: https://lore.kernel.org/linux-usb/Z18hJM55ED2hYJ6D@lappy/
[2]: https://bugzilla.kernel.org/show_bug.cgi?id=219590
[3]: https://retrace.fedoraproject.org/faf/reports/1113325/
[4]: https://lore.kernel.org/linux-usb/Z2Cf1AI8CXao5ZAn@cae.in-ulm.de/
[5]: https://lore.kernel.org/linux-usb/20250206184327.16308-1-boddah8794@gmail.com/

Christian A. Ehrhardt (1):
  acpi: typec: ucsi: Introduce a ->poll_cci method

Fedor Pchelkin (1):
  usb: typec: ucsi: increase timeout for PPM reset operations

 drivers/usb/typec/ucsi/ucsi.c           | 12 ++++++------
 drivers/usb/typec/ucsi/ucsi.h           |  2 ++
 drivers/usb/typec/ucsi/ucsi_acpi.c      | 21 ++++++++++++++-------
 drivers/usb/typec/ucsi/ucsi_ccg.c       |  1 +
 drivers/usb/typec/ucsi/ucsi_glink.c     |  1 +
 drivers/usb/typec/ucsi/ucsi_stm32g0.c   |  1 +
 drivers/usb/typec/ucsi/ucsi_yoga_c630.c |  1 +
 7 files changed, 26 insertions(+), 13 deletions(-)

-- 
2.48.1


