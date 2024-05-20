Return-Path: <linux-kernel+bounces-183942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB2A8CA058
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 17:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A2C328209F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 15:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC4C137760;
	Mon, 20 May 2024 15:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P6Fq21zJ"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18934C66
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 15:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716220612; cv=none; b=ToJVdne1bxrF7NvohoLUhPrPmxCNfjxIPAmKzwqq7UaYMpOdR9kUXVlxDGeTy5OPI6x2CFTAxuz09eDGFrayjlUS/7TwMJUfP6Hjls/JPMOX1r7IS4iV4HvG+2EXclbPm+ZFisAHWTxN295AGjs2Lr/1ooE9/hRhYFhRzYSfUYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716220612; c=relaxed/simple;
	bh=CP0ZA9PYcEs6x4vau0aHq+RdPXaf/fqBDeOsmXzNn2I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=dHg2sL8F1HaqYaq3Jl/Y12KOvnUOA1tX8apWyIibQQs5eDMiCxPHJenoc7j6emXAEdn28nwTpJBTB8NFvQFkxXmsQGzOYxHUGy7kMAFPqHThmoUjczJP+D1072SCh5OzlAFKkpr/TlVgdYWlTfzCKv5Q7quLtKuTKptXzAG9VJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jwylder.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P6Fq21zJ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jwylder.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61be5d44307so192790417b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 08:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716220609; x=1716825409; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k71/7VL0ZvFVNLFyJr0mQ6OVb2SIlkc1E/+KvwagaLU=;
        b=P6Fq21zJqJ8fWqk3eDZVpr+c48/U6NZqUoYj0HCB92N6WjIqjvUGP2PKRiSD2EUlPr
         XjJmq5aYR12/yyyQH6miDron6XocxYZV7eYV+Zpjbpsw+VoHDY27Ax55WQjNzhJRWDEZ
         uJFM0wrU8LMUbDMyuaWDmOW66TGAlfw2lFg7SNRZ7DazEr0efw/l99uRC9BcEYWQD798
         J4MYGnpb7Cf2XkK7jhR+Ipc2Gyw0L+JB0N0hBE5GSkiCQqGCjb27hD7WsrH4gXM/mEBp
         XLj8Em4OBs6s8nBiYh2tUwkB/eKs9LOk+4G5hKoV/kf4gUWlBBKF+V5k80erXInRGL5C
         pOCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716220609; x=1716825409;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k71/7VL0ZvFVNLFyJr0mQ6OVb2SIlkc1E/+KvwagaLU=;
        b=CCVt7+/F2KYhjRQwBbYHM4zrat2K7aH6eqTOgN4FpO5IDik84mR9TfIjz6sqiIovYt
         yJp3BQfD67Yqzuaa1gJxE7SNq5+PZJQOpe6W29W2e92KuoLFvpc32KYRdQdWQ9AZ1FUk
         bsuleN7MMjtmlmBHJ1lRR6eCwK2sruABCDiub7MMbgZ71yUw1MgIM8Ds/YZba3hWKIXg
         MzBubkQr0nzV0Jzk0fW7dqZIGZWJTSJfJsoI6MLdFfbOLNK5bjKoptfaoHQ+55j1wROu
         hBoYfp9/OAbik/gDEEnM/XoD6CosO7xq/TtnyM8x/IZIuUT0MHtUmuuenyRQN/909cOe
         e+FQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8ybRlq/RLfdH2MnZo7Z4ZbexbE5JJR5/52ez72J/1zmSTECgtI4cqSl3JRl0vZhRqZpEZuihQoTXAvkA4xlQGn37DFgrzJ04QVT3r
X-Gm-Message-State: AOJu0YwkBCYqIjz2Mus+eyw/rRDlpW7JUByDLgHURriVjE2yknZr0kbI
	1nIJVTpaIHgH286AZTRHo7d02EnKONL9AYUkXEoYGkdYflUTALMbfB3nWeEG0Dd7Uesx0XU5Fue
	1Wkk8bQ==
X-Google-Smtp-Source: AGHT+IHBcgiST2Lj6n7laJSmi1YlvlcyBqSxSJbFcjZ8I5/Oae28wZWTgUNkY7seRE60ykCGbpmKWj2y0U3N
X-Received: from tetrad.chi.corp.google.com ([2620:15c:2:a:3ad4:9b42:3a8e:37e3])
 (user=jwylder job=sendgmr) by 2002:a05:6902:1026:b0:dee:6147:7e26 with SMTP
 id 3f1490d57ef6-dee6bf164abmr2514888276.11.1716220609702; Mon, 20 May 2024
 08:56:49 -0700 (PDT)
Date: Mon, 20 May 2024 10:56:37 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240520155638.994719-1-jwylder@google.com>
Subject: [PATCH] RESEND: regmap-i2c: Subtract reg size from max_write
From: Jim Wylder <jwylder@google.com>
To: Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jim Wylder <jwylder@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Currently, when an adapter defines a max_write_len quirk,
the data will be chunked into data sizes equal to the
max_write_len quirk value.  But the payload will be increased by
the size of the register address before transmission.  The
resulting value always ends up larger than the limit set
by the quirk.

Avoid this error by setting regmap's max_write to the quirk's
max_write_len minus the number of bytes for the register.  This
allows the chunking to work correctly for this limited case
without impacting other use-cases.

Signed-off-by: Jim Wylder <jwylder@google.com>
---
 drivers/base/regmap/regmap-i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap-i2c.c b/drivers/base/regmap/regmap-i2c.c
index 3ec611dc0c09..3b1e78e845bf 100644
--- a/drivers/base/regmap/regmap-i2c.c
+++ b/drivers/base/regmap/regmap-i2c.c
@@ -350,7 +350,7 @@ static const struct regmap_bus *regmap_get_i2c_bus(struct i2c_client *i2c,
 
 		if (quirks->max_write_len &&
 		    (bus->max_raw_write == 0 || bus->max_raw_write > quirks->max_write_len))
-			max_write = quirks->max_write_len;
+			max_write = quirks->max_write_len - config->reg_bits / BITS_PER_BYTE;
 
 		if (max_read || max_write) {
 			ret_bus = kmemdup(bus, sizeof(*bus), GFP_KERNEL);
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


