Return-Path: <linux-kernel+bounces-278480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DF494B0D0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 22:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 867E81F22D90
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 20:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA4784A51;
	Wed,  7 Aug 2024 20:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ckl2slCP"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8F829408
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 20:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723060939; cv=none; b=pfKDQuaiOKYvWpebeEQryFRbSIsvn6gP5yKMpcUkXJNuPX23JoKTFBOitzyufZymwauEYynD7VxiGaUhZdHVtDmq6knX9nXXrz2HbYwgzwXN4mLEw/xuDACr4NfpsVGyqnMwfaXfr3WFm92npHVGfd7Z8RAEit0VptMCxPC73YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723060939; c=relaxed/simple;
	bh=JqI/7JY0uwHO8jeHmfDAkuQSCd4muvWmJPLKHs/4J70=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U0xJdAvk8jSe4d31yypi/ILugn7BqfERdBfViTHD5I+GcC32MYGo98SX58sG/NJeBkdOMKKx8emjz37dsHd9UH/b9Ts7SeSISvcPWqwtbp/Ji2YXwiRFfET5RaoqnM3PETvTtdKkQ4BXL+xKvSYvgitsjXOHCPHRnTJJIuHBSZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ckl2slCP; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-70944d76a04so135635a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 13:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723060936; x=1723665736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LsITnJxqyk3GLU8VoWLUSQ1dx7O5PrUBJFkjcQc8Yi0=;
        b=Ckl2slCPnKSgr8UNq8Ph9sqxOeN6LcIvmi7Tp9jhlNe4dANMmudJk0IaChD1LwdvQ7
         CsEjf+RfubYyGNybetFxV/Lm/q4fTBHowZqcqySCKOWAF9r+wb2Ltlx9eAWrlMJ3FOUe
         MgHEYqT0pZ7AwbxDTOrHhaR1XoNjjiYuYp06sLHVmgZhJ57cuV7Zfcg1c2rlEHWC2jJH
         npGrNJ/zHP4u3H4UoeC54TKjISYDqN28+jzFZhllOaJP258MOBl985yhwCyWqU1QugSA
         oww7/QMDKw5/OKVJhjKVPzijvhHQxTqKCE0j3JxG+RMO0hyFPfKuph0GW9jkBADUYQYE
         hOmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723060936; x=1723665736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LsITnJxqyk3GLU8VoWLUSQ1dx7O5PrUBJFkjcQc8Yi0=;
        b=QWAuzrmm0yj8C/TRD9Wjkl9iUqgStoXjdgT7NCVs/UGRsEAhGkpSI9MNzlmwG/F5qd
         pEcPM2wjYUT+w3UXMhKsLzPMH9BfihcRWcfmB1egEfGUEcLA8Bjpk7VoPIj6hC6Y1sTn
         BzrqC+2thWUjorVhBqlE9QYAsF4dCmC/FUeVTCMsHkVQKwmR1dN4DfVT7xpFMafv5DYN
         sCek32lA9WFg6BPNpd114fr2nGi6pA8m2HGe/PZjsQ0QAundwjVGqnG4zXwwJwkx/9U5
         azHkJovOplPQoYDkqp7/yUSa6OoaAxcrhYE2UHkBAF9ZHzkgEiDjqIzOLvKXKlnA8Tgb
         hiNA==
X-Forwarded-Encrypted: i=1; AJvYcCXcCPYj8vhhbaBjupDWZ+GpKv0jFf/7rMT3xJn04eB8Fem3+O+Glc8CLuSIeqFbv1UqecJDP5GItgIj80w=@vger.kernel.org
X-Gm-Message-State: AOJu0YydbyuULmzqQ+dsRfjSZOZPRbdVf1J/R+PxeXkPCwRUdzCSG5F4
	Z472MLoInishKypWfOFDlQ+V0m8WODBWIpFvVJpUdR3/JU5Jyetr0jg28IwI7jk=
X-Google-Smtp-Source: AGHT+IHXba0L9xz2feaAjHZF5HL6FfrLqc1XVJbv+ptCNbxlgacOca0GRhf/jsOysJCJOOgMtHOHpQ==
X-Received: by 2002:a05:6830:2a86:b0:703:6f95:98e9 with SMTP id 46e09a7af769-70b4641c8f2mr1430507a34.10.1723060935925;
        Wed, 07 Aug 2024 13:02:15 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70a31eaf7b6sm4951003a34.24.2024.08.07.13.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 13:02:15 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 0/2] iio: adc: ad4695: implement triggered buffer
Date: Wed,  7 Aug 2024 15:02:09 -0500
Message-ID: <20240807-iio-adc-ad4695-buffered-read-v1-0-bdafc39b2283@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.0
Content-Transfer-Encoding: 8bit

This is a fairly simple series that adds support for triggered buffers
to the ad4695 driver.

Not directly related to this patch, but as a side discussion about
future possibilities with this chip while we are here...

The advanced sequencer on this chip can repeat the same channel multiple
times which, when combined with the autocycle feature, can be used to
create different effective sampling rates for individual channels.

For example if we set up the sequence [IN1, IN2, IN1, IN3] and the time
between each individual sample in the sequence is the same, then IN1 has
an effective sampling rate of 2x the other channels.

Have there ever been discussions before about implementing something
like this in the IIO subsystem? I didn't see anything that looked like
this already implemented in the kernel.

---
David Lechner (2):
      iio: adc: ad4695: implement triggered buffer
      doc: iio: ad4695: document buffered read

 Documentation/iio/ad4695.rst |  12 ++-
 drivers/iio/adc/ad4695.c     | 233 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 241 insertions(+), 4 deletions(-)
---
base-commit: 7cad163c39cb642ed587d3eeb37a5637ee02740f
change-id: 20240807-iio-adc-ad4695-buffered-read-f49eb511e300

