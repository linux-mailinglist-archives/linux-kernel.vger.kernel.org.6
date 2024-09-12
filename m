Return-Path: <linux-kernel+bounces-327002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC073976FB1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9671B286710
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 17:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AEE1BF80B;
	Thu, 12 Sep 2024 17:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dS4wlnTF"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B453188592
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 17:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726162749; cv=none; b=rT6uHmhZN9AvLSNm+M19H2Kq7UJw31KrZyKNARp4bm68cpGlHtrdLpGlFRwhIGr/sZh0vadWGNcmcA1dDvyhG1MUpNYy78kIQaF9IWCeMoLEnApy7qibUd6216YqllJWLUM4AWRwrwT7IewzHwZ9v01ZXr64P6J46pYecdnj4Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726162749; c=relaxed/simple;
	bh=vnB+9idXhCgy5AVg4jFbptofzxlS7h1aP1hq2toSSZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lzaua9TgsHiGPMKwjqpOP2pjFY0gjoNbjk5rQLUqskpkQH8GSK5yUbd4Wed3YpLpKTghyhcE/ju9UDw8I+VwzwekHCQNzOR5F0IIkYX0RgC0k0atfVRhf+xCNB1KcjpognDpjn0n27V1LWRWad7Y+HR3UIsCX1p9F+AVJolK9EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dS4wlnTF; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a08043b226so522475ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 10:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726162746; x=1726767546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kkPvlYPCbX57sBLIscwM1o4s5S3tQ3XUG2CHY2rXX5g=;
        b=dS4wlnTFWaBOdIvM+L8o9+/rkD1o42AvboizmiMPAWG9C2qOuoq1517sqdV/lH2kXc
         Of3KUBA/eZyvAZLDQ6Pwoi6Dl0y43ZHyvhrMQR/ogHrBPNA9zw/wbdwrWSitXXFAq92t
         vYjy+SHU++wzVl/X46ABoCF7QQgr5Pl/6zOZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726162746; x=1726767546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kkPvlYPCbX57sBLIscwM1o4s5S3tQ3XUG2CHY2rXX5g=;
        b=DbF8Y8Uw0j2KzB/cwTDsjf5IDhq4TL2x6/uHiX8116asNRAXMBDLvG026HWs8Fw+NS
         EIH4ZC7kEaWYDaVXLayd/L9gbvwjYh0o7iCoe4aR5kKXQQvmmOJIAjnfZD3UFkXCDcgt
         wIVMuOd4cI6N3lw7EV/kdmb8cqSNtUsThsu+SGv++FdoeGiMjRxjZ4SbUmbps+4KBt0k
         IHTBNiOySpqeAk08BR9OUYrzDRBVUO+CjSAU7a6sbyeG8xDQx/rV09fqkOw+Nslq8snT
         YrufoRu0JwlHjr+5t4VRXlbdD0pa38kjthm61lBdR8kqOICoeMDRf/1m+dX021rlLvyx
         LhvA==
X-Forwarded-Encrypted: i=1; AJvYcCWY0qq+hNTcI4nlZRov3jXKK+9fnm7rP3eyTtXfkAGUzJyiVyVzrkNVGIJBSOO0W5DE7IjceEyBjGvGY5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtT3lzT1idn0BcFYhX+GG8XHDOvfh6dhwN/yJY5d5kfNQH+Exb
	NgSQVth4Bm2GctuTY6PAU5hAA+JLKbxL9aVqJlKKn1LoAhWWyuVeEG1OATwp+Q==
X-Google-Smtp-Source: AGHT+IFVUkbp4TmmxAsFzcXQPNvxYhKtSHk8lxW631++WJrjz1s5/fgX7On0NuVst8yiDDtcDIcjOA==
X-Received: by 2002:a05:6e02:1aac:b0:3a0:4d6b:42f7 with SMTP id e9e14a558f8ab-3a08495dfc6mr41140215ab.22.1726162745917;
        Thu, 12 Sep 2024 10:39:05 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-226.arvdco.broadband.dynamic.tds.net. [24.56.189.226])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a05900e618sm32570135ab.55.2024.09.12.10.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 10:39:05 -0700 (PDT)
From: Raul E Rangel <rrangel@chromium.org>
To: linux-serial@vger.kernel.org
Cc: pmladek@suse.com,
	rafael.j.wysocki@intel.com,
	ribalda@chromium.org,
	Raul E Rangel <rrangel@chromium.org>,
	Adrian Ratiu <adrian.ratiu@collabora.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ingo Molnar <mingo@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Len Brown <lenb@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Xiongwei Song <xiongwei.song@windriver.com>,
	acpica-devel@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Implement ACPI SPCR v3 support and minor earlycon cleanup
Date: Thu, 12 Sep 2024 11:36:18 -0600
Message-ID: <20240912173901.3969597-1-rrangel@chromium.org>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Getting `earlycon` working on AMD platforms is a bit tricky because the
uartclk is 48MHz. If the uartclk isn't specified, we default to
115200*16 which results in an incorrect divisor computation.

This patch set adds the uartclk to the `console=` documentation,
prints a notice to the user that it's using a default uartclk, and
implements support for SPCR v3 so that the uartclk can be provided
by the firmware.


Raul E Rangel (3):
  Documentation: kernel-parameters: Add uartclk to console=uart
  earlycon: Print a notice when uartclk is unknown
  ACPI: SPCR: Add support for rev 3

 Documentation/admin-guide/kernel-parameters.txt | 16 ++++++----------
 drivers/acpi/spcr.c                             |  5 ++++-
 drivers/tty/serial/earlycon.c                   |  6 +++++-
 include/acpi/actbl3.h                           |  6 +++---
 4 files changed, 18 insertions(+), 15 deletions(-)

-- 
2.46.0.662.g92d0881bb0-goog


