Return-Path: <linux-kernel+bounces-356129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2025995CDC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 03:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 635AB2862DD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 01:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C549A208D0;
	Wed,  9 Oct 2024 01:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="Ed5PNegE"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D1818EA2
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 01:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728436663; cv=none; b=rdiIgHiSkyjPKlAhwvxg5WYona+r2F2XzsR9jousRQyO5t7jCvjRtj4VJAVxzqHBj3ejNnVowfEROOM4oWzt9oMq1lszIcivQrmgQbeREeAd3Z4LmmlYl9rop0C9HNrC9nPrJvYOedyGpLCiaL9yETLrHLqDNxE1Hi3HEqgmEbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728436663; c=relaxed/simple;
	bh=7ubliB8JusR2RI2wLStwhyZ3dp/eNFEcPKxo60r52SM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RElD9EZkNpmjoy/V+HvCa7MLGVpg3g/EjYpc7/MmJRcpERHD+CzOreL+nFlD6TANMz0IqM2topL582gXIqBMNf/qaPQQZjBX+x8X/H0nGz1g2mX6Ek+x/1/rfuJqc3NgcjZy+cDGaBUdC3XSa7XCRzv2YiT/+DP7y3tMQ0P7cEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=Ed5PNegE; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7e9fd82f1a5so2234296a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 18:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1728436661; x=1729041461; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5gXIoKwehMAZvKSi1ZW9gJSgNU8emklB6JJg58GCOnA=;
        b=Ed5PNegE6KJB2T+ajipMvvma4d/+2xrvGh93xwVrMjUQXC/G0F6eNMQ2ywq5s1Wlfm
         ql7xfK8myy2K+oG0V1bbS/i8FxiZ8qAB2PjGQC7HSv0MsTdFuX8JjHsG0m9sIuqTMeXJ
         NVYeWMxgsJ5CONIMFcBf2DLAqmCwVrJMD4bJoOR1Lk1afhACNV7EtLeJ/c20F3Io4vJW
         0NBo5gM9DUr46eZUfRAJKYdeDDyQ0vaoUJUgP5HwuE6EilPjhGhZFQKcoTSrrDkd2gjc
         ShlFPRJaQxM80XeRAFmo8g6pn9ybnDn3VWMYmHKHHFqtYSqQb0iOE8sfaOyNNANJEol2
         xchA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728436661; x=1729041461;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5gXIoKwehMAZvKSi1ZW9gJSgNU8emklB6JJg58GCOnA=;
        b=QuxJSRJuRkT5Eb8XvmB7mb18ZS/X/FBOwAkPdYOlOv8XNersY7Vr/szw83XXf+H1az
         8XXRWBOcFXaxjAWRNu+PEVappXZkkjob40nNKUa8Xw0NT4e9XG643BfY3YWkm1DIniyr
         PhltsAy7xG0PqPijgWMOdP6BDU8LJRN654GfT6Vv401vfxevorLA6+9VizHFWgL/K8xk
         fBL0W817bnq2oSBU9xdWj/ab4qXx+E17hyNXlnhybIvy1lojw6WOcssWxHQAYOgH84Jq
         YlUO0HugmzJYkxOAIBHzs+AW+clL4TjSlERONRgwTBDnQYmFdJa1nGaKm3OAJ1KkhKQy
         eGFw==
X-Forwarded-Encrypted: i=1; AJvYcCUBYDoB4LFQxyVBtH4Z/+Vkli/Mrlb2M8WLHfmqbhe80iuycJGaTtQXYAIEDoa0vstxvdF5Ivyp52vwNac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwjrja8mOvAlk2GmxlHCRabkMrrCKfTbIBZSdUZUOACm7fE6yg
	rFCIQACqMJ/0I8N9087W8D/Ln1I7c692q3L/wb/Jvg3nwwo4L7gUPlB/8ryUUVI=
X-Google-Smtp-Source: AGHT+IEnse84BySsrxxDqF+rx4nHQxQNoK1aENuWT8okmvAHlh6k+aHET6PvGLInmguwwhVposdu7Q==
X-Received: by 2002:a17:902:d504:b0:20c:5d78:4d88 with SMTP id d9443c01a7336-20c6379ae73mr11464655ad.60.1728436660857;
        Tue, 08 Oct 2024 18:17:40 -0700 (PDT)
Received: from [127.0.1.1] (71-34-69-82.ptld.qwest.net. [71.34.69.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138cbbc2sm61076365ad.78.2024.10.08.18.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 18:17:40 -0700 (PDT)
From: Drew Fustini <dfustini@tenstorrent.com>
Subject: [PATCH v3 0/3] pinctrl: th1520: Improve code quality
Date: Tue, 08 Oct 2024 18:16:45 -0700
Message-Id: <20241008-th1520-pinctrl-fixes-v3-0-5b60db446a49@tenstorrent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH3ZBWcC/4XNQQrCMBAF0KuUrI1MpiYtrnoPcZEmUxvQtCQhK
 KV3N+1KEHH5//DfLCxScBTZuVpYoOyim3wJ9aFiZtT+RtzZkhkCngSA5GkUEoHPzpsU7nxwT4r
 cIthetXXbkGJlOgfaD2V5uZY8upim8Nq/ZLG1f8AsOHBplLTDoMECdIn8ZgTy6WimB9vYjJ+U+
 kFhoXrRImqqtbLNN7Wu6xtU7pvcCQEAAA==
To: Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-riscv@lists.infradead.org, linux-gpio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>, 
 Drew Fustini <dfustini@tenstorrent.com>
X-Mailer: b4 0.14.1

This series contains code quality improvements for the new TH1520
pinctrl driver [1]:

 - Fix smatch warning that the return value is not correctly set when an
   unknown pin error occurs
 - Linus suggested using guarded mutexs so I've converted the thp->mutex
   lock to that usage.
 - Linus also suggested using a scoped iterator for the DT for-each
   child node loop: for_each_available_child_of_node_scoped.

The series is based on the linusw devel branch [2].

[1] https://lore.kernel.org/lkml/CACRpkdavPAv2sPRREQhx_A7EtOj6Ld_n+NcO+vH0QCnfVedXKw@mail.gmail.com/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/log/?h=devel

Changes in v3:
 - Remove declaration of 'child' in th1520_pinctrl_dt_node_to_map() as
   the macro for_each_available_child_of_node_scoped already includes the
   declaration of 'child'.
 - Link to v2: https://lore.kernel.org/r/20241006-th1520-pinctrl-fixes-v2-0-b1822ae3a6d7@tenstorrent.com

Changes in v2:
 - Move the scoped iterator conversion to a separate patch and remove the
   child put operations as they are no longer needed
 - Link to v1: https://lore.kernel.org/lkml/20241005-th1520-pinctrl-fixes-v1-0-5c65dffa0d00@tenstorrent.com/

---
Drew Fustini (3):
      pinctrl: th1520: Fix return value for unknown pin error
      pinctrl: th1520: Convert thp->mutex to guarded mutex
      pinctrl: th1520: Convert dt child node loop to scoped iterator

 drivers/pinctrl/pinctrl-th1520.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)
---
base-commit: 2694868880705e8f6bb61b24b1b25adc42a4a217
change-id: 20241005-th1520-pinctrl-fixes-d20db68387e6

Best regards,
-- 
Drew Fustini <dfustini@tenstorrent.com>


