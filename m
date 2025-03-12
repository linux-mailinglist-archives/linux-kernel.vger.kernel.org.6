Return-Path: <linux-kernel+bounces-558367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2C8A5E4DF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 21:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C31E7A67AD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 19:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DEA1EB190;
	Wed, 12 Mar 2025 20:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QQiioHf3"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715F41DED49
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 20:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741809613; cv=none; b=KZI7R36B3DDxUrWbD0Lp+xD+LZducEoBZeH7ds8+pjSsFntp0XNw2UAIqOW+la/9sKz18sfeBxtome9ACHlQZ4KSs50iGZuNfvUyStq1jrOx63+8RX+SQbPKNtryC6nNOmWNMWSO3SkSTUMztg/qeyHlKGMekVTIeoIjQoqLVKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741809613; c=relaxed/simple;
	bh=P5NZbbFKye8GqSKijmH2j8hmBxSuTTWkUAi9/ZWgQC4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GkKgXehOp1npDsrTng7NMrElPqxHMF4u7clVdpaEY5cMLAfCMkvFxVP1+Onxqd3orwQqwSA3m184jWuGZoF9qVqMb3NGsd5JQmhMrOouBCxNNtJtwPPCZGpU6qcw/MzTq7aUU3AR1VT3uYikHMeZVuHs+u88eqJUnXaOnhx54ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QQiioHf3; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff798e8c93so379658a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 13:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741809611; x=1742414411; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GCtXfZQjeCD3fq5iyjoL5SOi4U37CC2OFkybAtefkLw=;
        b=QQiioHf3Zbd/ixAEVGx7t8CgLaW3qGOaz8nWs6arKhsX32hc3Ifvg5R/aGCAODnTtl
         KX0yW11TGIUBTXULeuMY4BZnzIgZIlIO7CCOtsCh4FJt8yP6b8p9cnsCa2nZzeqwULPt
         pY5G3vV8dK+wBs3Lj0a+E9dvQT5ibWdwZDiMNkseLg0Vk5pbOd6H2xnaNX4EPdiKjndn
         Maa3zJeGWD3aT5sOp0KmlPAHBJDgSBX4S5vRABPbUsEsK2l1fSk5te/HnvsZj8bBOss0
         cFrJHp6vq80ioSuoAxmR5ZuE4CoN1NBqQUU40AEOqYs4fpFBr5iCMZk024gjKVxyxTYe
         lYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741809611; x=1742414411;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GCtXfZQjeCD3fq5iyjoL5SOi4U37CC2OFkybAtefkLw=;
        b=fXbkW2jo8Owjv/Y7dmUQJT6XK7Z5W2dDAFfn2mTl2UyChRgYGlVVM6hfOcVmgT5at+
         6oh/5UwvuJoKYymssBrElUdLXI3H2ip1WdG/kWta6j4XjVPHTxZjK0eR34bliwn/V4D+
         QIz7f8GsT1SsTU8hh9Pa0h+vVXIwyHr4oUeubD9A1bXNJ/IJPYBDJ4cM9/zL/Qw1DFVp
         hhzH7KsHm/3Q/E+iTgZRk9W1L1KaaKfUmwZbT/cHS86HWrAPloisDLex4LEVoabsSrgg
         8nKsNTXWYlJ1InQUR/e7AjbqoEp2acnpw3THgUoXnGoXU5jppZqZE2iC7Qjw/WV5plij
         4NcQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+rwe032MB+90cNj1u1qZIewRtzfX7/BDW4d1bTJA1ZABYfDZwLI7JqdgmUgoosgwkkzMsqqs/RkhppEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCW+m6trxCCUiP2x2HI+qa0PnsyuVCnqPlyJDiO+dL4wWF6E6r
	24pAuXdmPzcg5r1pGuFGCkABCHurOqHbCfRannt0PW6RTb21Bs86w6iYUP4kF5VyPtTCj/shNWH
	HYQ==
X-Google-Smtp-Source: AGHT+IHv0lWNMl7veaoEBiVdC1it/rtCEXkxkD7IR0gVxFD7q3EHrQjh4nCeL+gbO2bxgEmR+LqkqRyXAro=
X-Received: from pjbpb8.prod.google.com ([2002:a17:90b:3c08:b0:2fa:15aa:4d1e])
 (user=jthies job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3fcd:b0:2ee:aed2:c15c
 with SMTP id 98e67ed59e1d1-300ff350ce7mr11396305a91.28.1741809610712; Wed, 12
 Mar 2025 13:00:10 -0700 (PDT)
Date: Wed, 12 Mar 2025 19:59:09 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250312195951.1579682-1-jthies@google.com>
Subject: [PATCH v1 0/3] Load cros_ec_ucsi from OF and ACPI definitions
From: Jameson Thies <jthies@google.com>
To: tzungbi@kernel.org, ukaszb@chromium.org, bleung@chromium.org, 
	heikki.krogerus@linux.intel.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, groeck@chromium.org, swboyd@chromium.org, 
	akuchynski@chromium.org
Cc: devicetree@vger.kernel.org, chrome-platform@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	Jameson Thies <jthies@google.com>
Content-Type: text/plain; charset="UTF-8"

The ChromeOS UCSI driver (cros_ec_ucsi) currently gets added as
subdevice of cros_ec_dev. But without it being defined by an ACPI
node or in the OF device tree, the typec connectors are not correctly
associated with other part of the device tree. This series updates the
cros_ec_ucsi driver to load based on device definitions in ACPI and OF.
It also changes the cros_ec_dev driver to block adding cros_ec_ucsi
as a subdevice if it is defined in the device tree.

Jameson Thies (3):
  dt-bindings: Add cros-ec-ucsi to cros-ec-typec device tree
    documentation
  usb: typec: cros_ec_ucsi: Load driver from OF and ACPI definitions
  mfd: cros_ec: Don't add cros_ec_ucsi if it is defined in OF or ACPI

 .../bindings/chrome/google,cros-ec-typec.yaml | 13 +++++--
 drivers/mfd/cros_ec_dev.c                     | 39 ++++++++++++++++---
 drivers/usb/typec/ucsi/cros_ec_ucsi.c         | 26 ++++++++++++-
 3 files changed, 68 insertions(+), 10 deletions(-)


base-commit: 9fc83373f0ffb8834da48b1446a5c2fef9525bb1
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


