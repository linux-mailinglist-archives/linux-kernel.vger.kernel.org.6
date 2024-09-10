Return-Path: <linux-kernel+bounces-323424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 528BD973D23
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 18:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 850F91C24D9A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640571A0734;
	Tue, 10 Sep 2024 16:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eVesFppu"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC80919B595
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 16:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725985423; cv=none; b=jsgVEwgIQvAqc3EFqMaQ/9OsPISu3hry1ERAfAo6xRIOsxAq29xUlFXx6ywXNTbJKEfCS8THZI2VWp5e/zmY8d4tIqCWn4m2ctJxGFvjM/Hix7c6xKBBJgiOGslxaWCauZF3qCPh5eS873ne5lEgmpBRv7y2Y909KEUb0HOprNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725985423; c=relaxed/simple;
	bh=gXjTEcttA5QttM+LvxBqEoFRUycgUByM82qJ/zmUKxU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gLQPFV3lBuzhooe9oXUykFP6krp3rVx2cmwQIZIeLmke97GXuBWyYySpEUXNHLwK5F5eirNSb4yKR+bykQFcUorDPTk/XuQ3KsVaWo6wJghUD6OomEFCtHROnSEdHbWxZIADJEAio+1dB+1nUxVGUfq2xK68zqWBGTx27OnQFFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eVesFppu; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-42caca7215dso26833465e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 09:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725985419; x=1726590219; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AYa30QP8uHW8yVnRTztEeL2KarXkSUIIYXYg/0AlhYM=;
        b=eVesFppumX7x4b+aKXyVMBmS/OuryIx8vcGxVyEnBi9UHE/KcmJ+/ss7mSUtUQ0dEo
         0posC4HaPvcYtHawgw35gCROTqF941CpXe3XK6mfxB7TJvDJp6fXUxeInfyXFnESuuZH
         w8bU5IQwCgROAyiOkDd4GpXPAL2JpwxcFnTXdJzvJoyJ1UWdC3h8MEi/qWBj3UELhDwN
         q2X59/vX/JkozMFU1LzzBzMwJJxEhJQYgANduhCgVitiHh+uuQ4gAzQTFIEr3WxYS3HN
         twEaBZImhP0cEUz87ejR4el9R3Wvfr+MZwXB/NfXtsYH7aelJ+p7P2bjz9vzohtIJmZJ
         1LAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725985419; x=1726590219;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AYa30QP8uHW8yVnRTztEeL2KarXkSUIIYXYg/0AlhYM=;
        b=qvr5GSnIcApxmo0D8z8CVV/TNxTPMs2S6Zqs62mrytEOGc/dV8fToUCjne/VX23WWf
         z413ckXLvRkFC9n2tzJ2PDMSfyGWXvKFl2VOsW+nHgQeRAwzwN5aaP6rhJ8BdxqOrsHf
         k5weEFC9YwRyHLHR9ZxV2Q1hS8G7VuojEcB26HIglPw0T4W2WvJsnwztqNfubJHv74R9
         ALVJXD4kk5mIY9LUS0X7mcx1yrWe5FKL37xGeQ5OygPEyqmBZtXp347g/wEkAH4GJrO9
         sEYdkeqkiwurbnQnZAWNrCYzBG9PRfJCM9rAdMPfIrQRZJt6P2PmqtfLub5AQmQr2Axy
         pEmg==
X-Forwarded-Encrypted: i=1; AJvYcCW2IH2c3z8EIl37+Zbu7JtgbeCAYfZ09GyQlHim909PsQ9h5qjtlTo2lejwQ9P8V2hLTINwVE352r1WuxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy79O0CEcqwdBNCc7vhKRef8UcWa8oqTT3JtRsjRJtQE57r0ZbB
	SkPEwnupyNUgIZNZUvMzHY3s9WTyenpVEcVdPYA5uJ0sdHdtWn13WV+U4iCkkaWKpE/9RCxNCIg
	Gs21nR+fa+7HXoA0Wlw==
X-Google-Smtp-Source: AGHT+IHF+DLdSIrtOimcbKrwLaVS9XMpj84vdlov7q3dILQ6UN/1Xtu53T2ADmbOySXbsfAXdgrBIxnxL+rzsM6t
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:600c:520e:b0:42c:b63e:feb5 with
 SMTP id 5b1f17b1804b1-42cb63f0132mr167875e9.3.1725985418935; Tue, 10 Sep 2024
 09:23:38 -0700 (PDT)
Date: Tue, 10 Sep 2024 17:23:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <20240910162335.2993310-1-vdonnefort@google.com>
Subject: [PATCH RESEND 0/2] ring-buffer/selftest: Meta-page testing improvements
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, kernel-team@android.com, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Following the comments on the original patch [1] here's a set of 2 patches to
improve the selftest.

[1] https://lore.kernel.org/all/20240628104611.1443542-1-vdonnefort@google.com/

Vincent Donnefort (2):
  ring-buffer/selftest: Verify the entire meta-page padding
  ring-buffer/selftest: Handle meta-page bigger than the system

 tools/testing/selftests/ring-buffer/map_test.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)


base-commit: 2fcd5aff92aab479a9a89cfce2dbc9c6a9455b4f
-- 
2.46.0.598.g6f2099f65c-goog


