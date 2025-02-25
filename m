Return-Path: <linux-kernel+bounces-530808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E626EA438A9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72138170CF5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA33426658A;
	Tue, 25 Feb 2025 09:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpSSn8qQ"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE44266188;
	Tue, 25 Feb 2025 09:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740474057; cv=none; b=RAod1BrJPi0kaupupsyM/+O8jn/Otha9Ta7usNpb6fUlQMNdfiOKemdfnkj8rs57wYJYjU7YNhLfFUfBjD7jNyrxVvSAj2LZw/6y9TqzuHLZX4+HI/pT5Qma3ktCoB0NZZpHe1RxrUI3JAPCsoZSWr5+c+iCM4Xvl0UBmlWGPzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740474057; c=relaxed/simple;
	bh=/Fv39Jo0jadOw0OiC5vTkKdRqmylw7JPKUrhOXMFU1g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VcDqqdOnPU4DiRr2DbarhittDoIUsS7UiPil2ElYSnj8h2fSCHTHZfpRyYUqFKqBvjL0zUoVB3OR2coz2Og3TqKJLr/M11YVZ0ALjKh+9FJclcgZZY7sT+fNrA/dpGchaQGrwCE7f9GDYynn9IUwjNdJsE6GZ2vn8/i6T/BrjTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gpSSn8qQ; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-abbae92be71so592340066b.2;
        Tue, 25 Feb 2025 01:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740474054; x=1741078854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Om3IzK7yyRY8bbiB04scY8tMm4ol/fteKkZMIrySwZ0=;
        b=gpSSn8qQ8uoA2Qf55va+bRFUOTtiRs+6uJRkVAVZhuEKDgW+RGzdeVLrltxoQQNzpk
         55Q0tgcxlecwYE3OLSQmPDeT4nLyJwYHm0dG+YqLtyxQuT3C39kXUDlWMMy30U3IesMf
         MmrOQ8RDvH1q0wN+RYguTQrKaeAqWf1Efj9J4E7e+vluwI2LlYCpTYV0SJhYE/jPZBQX
         PUq3wqnPyE5igY4zDPr1ScAIhbj4WhTxag0SfFdV6ssK39lHZDf9bs8FPLSCQWZj3KHN
         NvSqjzS1+goDCIvkK6VwiXWgHupS3kL7I/Fm2GT3kzdPEaTyZ/0tftDb2nU0AWAdZ2Z4
         KxCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740474054; x=1741078854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Om3IzK7yyRY8bbiB04scY8tMm4ol/fteKkZMIrySwZ0=;
        b=BtuQu5x4uRydRpuRZSMAOxT7qwY0xfmAU1hBWcPrgCdk+WSE35wYX9CCsEfoX0kB7D
         wiSSXi77eI3qov8B9ZZ+a8ke173sTAQIZd1CWuWXsdFrmzYTCyFyKQw7TQlWajMMteeW
         Vv1/fpvm1+WmBI/+TORDN5zXJL9a+ANL1ZCeSUU1tBz67nJALuYh+7em9Ez1DiQjld6h
         Fp/9C6Bm9ge3E8nQwu7/Ql3wAYz9INuzM/yc/ErVTFylkZe0MJkG3FM9IjtlNtr3NijS
         mC+smooeBVaYQ5QpxGG+911jWjY4TGIyHHoZINBOz/Cx206FOum57CdPGSSH0vLAu8WY
         9uzA==
X-Forwarded-Encrypted: i=1; AJvYcCVAJ2e4QzL45ncTZuETnz6+L6Chg3NUfZ4T6x929nxkEzci9iya7/Y8CAoN9k1X9Cy9RzBPz1xos7+4@vger.kernel.org
X-Gm-Message-State: AOJu0YwkVMTp5tM+BA71eIh7NKsZP1VaINeh/xqyeblneH+SLan4xtQC
	QogS5lPuvYhG2OLmxvHAKvrAnZrAYgvvCrtuUomvuqwDgSmOuKjQ
X-Gm-Gg: ASbGnctsHbMTSii7vcOXZqPMhgKmFNjeq6XbTf3a7jI4IvpvXmL2ESuFxam6ol7LiEv
	2EI2fHhjtPiVUauLT//UJW4EQ6S/DSgy82mCs0VbNf2F7iah7uuFIgL1niLOVDUOmXto+5qx9sx
	aVkEpcuPRCJ5SDcOJTWJpa+ELzs+79C/9qKb1YrkMJfyojRhgKoer6nA0wsfW8Cz8Yy0p8a5nOl
	t/OZUmc2HMb0B+5Od3G4zDUe1irvC7Mbyl4n4sm+mN8eBS6NQuLe6zSvm1vJEOjBF/CVdZHe453
	kkflYgQY68EAYgMzqQ==
X-Google-Smtp-Source: AGHT+IFQb5HiaX7WKvFwRbY85oTucm09/xAE19PYffJ3nmNGM5GkdOR4qg8ODxBWDWGFNNuUYmdhow==
X-Received: by 2002:a05:6402:13d1:b0:5d0:c697:1f02 with SMTP id 4fb4d7f45d1cf-5e4469dad6amr5923894a12.17.1740474053281;
        Tue, 25 Feb 2025 01:00:53 -0800 (PST)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e45bdc6fcasm911881a12.48.2025.02.25.01.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:00:52 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 0/2] extcon: add basic Maxim MAX14526 MUIC support
Date: Tue, 25 Feb 2025 11:00:12 +0200
Message-ID: <20250225090014.59067-1-clamor95@gmail.com>
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

---
Changes on switching from v1 to v2:
- added port and connector to schema
- removed -muic suffix
- removed unneded comment header
- removed unneded gpios in private data
- improved code formatting
---

Svyatoslav Ryhel (2):
  dt-bindings: extcon: Document Maxim MAX14526 MUIC
  extcon: Add basic support for Maxim MAX14526 MUIC

 .../bindings/extcon/maxim,max14526.yaml       |  80 +++++
 drivers/extcon/Kconfig                        |  12 +
 drivers/extcon/Makefile                       |   1 +
 drivers/extcon/extcon-max14526.c              | 301 ++++++++++++++++++
 4 files changed, 394 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/extcon/maxim,max14526.yaml
 create mode 100644 drivers/extcon/extcon-max14526.c

-- 
2.43.0


