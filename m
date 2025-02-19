Return-Path: <linux-kernel+bounces-521131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C77A3B4D9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32F313B2FD1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338091E5203;
	Wed, 19 Feb 2025 08:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZxcmtt/"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293F01E5219;
	Wed, 19 Feb 2025 08:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739954265; cv=none; b=hoLdUXh35xjPCF9qTD015qodzxWALocsOKaa+cwsV8liD2e78x5ruj/3IUM5UptIl3SgZGc7BzjUzha3hA+kX80s77eoCRBcn7LyqHWVUgS8bLifeAIwyK9qE8CgZ+IfbjiVVm98tqETEFmvtnAo9e6DPGgm1tLbCekIspg8m5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739954265; c=relaxed/simple;
	bh=6PvpWyUlJr1JrXpOq5b9KVIFXtSr6e/OFucjN1kuZ6g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Oq+x6g41CqCxhLqORoNMys/UD4Uao0zAyE0zzyHeiXgNAHvA6l0eNeZuKNkSKUGyUqA8UieF/i8+8GM6AyS+8m3rF7uOrJaWpoqjXs6GbpYm5icL1fCkqV94C7A7bG+efZ7byJp4AmZweH+EKZgqy+czrPqOLq9Z7X73BkbbxV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZxcmtt/; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-545316f80beso3505166e87.1;
        Wed, 19 Feb 2025 00:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739954258; x=1740559058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=adqVmCnS5uT2sSC5Nt1D/tH/YhkxZfG0Rnxs9zqPhxc=;
        b=DZxcmtt/2isNKcPmbh0W25WJhmgKKusoMYoi2OmfT+bttNwzHkTkW8MGU4mgfixH98
         t7MA8cTBgLrQG+G6/2j8gD8uHRrne76Jd80VCag1RlrxqzsqdyfSCLlC46jvewoNgaCf
         N90ffNE6umRjPfc6ILOLxWZGt4RRu9htQfB1vR2dX6PGMmJw6SdWNUh8f07ymNY6x4sc
         sVq07n4+VZk615E97CX+krqctSLe+CHjc+2gBheds/K08TcyEL0BiD9WrpnRqson9sk6
         Fli7EHvpzy70fH7Z7TEpnaQYp/A5x6I5D1pBHVmT9ObJlr1OLsxt5D4hjbPt5EHRQdiP
         kYew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739954258; x=1740559058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=adqVmCnS5uT2sSC5Nt1D/tH/YhkxZfG0Rnxs9zqPhxc=;
        b=Ayh65BaUTd4YLIufWCK6K5IU2u23ZXfaWozGBdEXM3/FRGC6xVjY+n/LlLMYCS0ZHb
         C7bCrt7IgCqca8FPQvshItcVlXXCnc7s2GxecpKQ1ZDqA1mtjHfQEkbs+vjGyYpN3LBC
         gobT1ChzllDPhZlDBKFPs79rutsY7pnOwphbw5zcl3RvMmFNL/YiyRMn8GOwz/YWblAe
         wtQSk24P0HMKk6YlrCZHBT8oCLaTbTVR3CphHnOgYrF6wRitrCs/6g7HubKvZbQhHkbY
         dH1uPB7D5KG1r1GkyJvsUn8v3KU7kpVHAy27lsGNeS07Mrm1xShko1o12BJPOlOIifQX
         QQqA==
X-Forwarded-Encrypted: i=1; AJvYcCW9lBLEbGKiTWmY+P4UeKbsHOs/6d5v9yaknE2WdB5LcIF7suIixA3NFkoO/BQPHKooE5BjP9VnN4Ca@vger.kernel.org
X-Gm-Message-State: AOJu0YyJNenxwqeLxxUAkDqTlJVBuZp5mtCE/iYfWkhB9ynCdMjj5CGb
	I24g1ObZYusDYoz0UMY0ccwhJJkwN7iuZ25qYKznm6PNvKWg7RRY+pfVXA==
X-Gm-Gg: ASbGncvKlgYduhoqZFkcRH3Ckb7th77Wxv6g12si8e7E6NRoyTYgOD1FoAT8G30Qb0r
	5CKvWVItxWA3gXvtA+EOGPvxan8RGcBnGUtbaq2EGTj5KEn406SP3zt+ZZf0jbYdGnwhoP1OCM6
	l8WQSCo6AM2yEpS3C+0yZ46MGqih09pphCbnQSoOce7+pT19eu5x4qcH7rb+LGLCp4XwHX6BsQ+
	EPaK+0GzPmGlmHuZqn+4jjMEFbFpTWEmq61TljocemYCdA7R73XRw2EVtzCbdZDfrAmzLnArDvz
	J233t4k=
X-Google-Smtp-Source: AGHT+IGXBdJnh9W9V8TuQUmNWAYbOUGjPIBgd4HpnPHeaP89ZWNe8M4sAwibLKzPGO1rhHic6wedYQ==
X-Received: by 2002:a05:6512:3d88:b0:545:b9a:b4b8 with SMTP id 2adb3069b0e04-5452fe7b62dmr5797655e87.51.1739954257796;
        Wed, 19 Feb 2025 00:37:37 -0800 (PST)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5452d8e54f7sm1692319e87.9.2025.02.19.00.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 00:37:35 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v1 0/2] extcon: add basic Maxim MAX14526 MUIC support
Date: Wed, 19 Feb 2025 10:37:22 +0200
Message-ID: <20250219083724.56945-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MAX14526 is a simple multiplexer of common inputs on a single
mini/micro USB for portable devices.

Svyatoslav Ryhel (2):
  dt-bindings: extcon: Document Maxim MAX14526 MUIC
  extcon: Add basic support for Maxim MAX14526 MUIC

 .../bindings/extcon/maxim,max14526.yaml       |  46 +++
 drivers/extcon/Kconfig                        |  12 +
 drivers/extcon/Makefile                       |   1 +
 drivers/extcon/extcon-max14526.c              | 308 ++++++++++++++++++
 4 files changed, 367 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/extcon/maxim,max14526.yaml
 create mode 100644 drivers/extcon/extcon-max14526.c

-- 
2.43.0


