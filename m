Return-Path: <linux-kernel+bounces-439397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BD29EAEB8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D03B1610C1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744EB23DE8F;
	Tue, 10 Dec 2024 10:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DmNf7bvV"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BFB2080C2
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 10:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733828067; cv=none; b=fJL+Ilh72VNp9HeHdB0YEpzlW4KhLvB36mhioQ9hGHvYlCBThwjLvoOwvGz5DPr4JHHoLseW+mnBfYqjVprysMpuief3H/3I66xAwLZeuCetj2y2tjhih/x8RQyY0qwlT26fT+QUd8US2MB+bXkRPeuNAxH/qnF0MPVCsSIPp6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733828067; c=relaxed/simple;
	bh=4mOOl8PnnaTHxuqDiSzezby1cT34tEnBOg5xp+NmJ1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CkjJwPNxDHCQmnCMKGEGUZvy5AGEe5KoKQbbLLmIrtQNw5nNeef2JxyXbvWXlCvizpuuhkKXbVFJXlnxBp+Ve7EJ0CVyRixNAqLKfuRHwhgdQsNk3QwgChTrdLNBeO7N/yljF8k3TEKynoznzxIPEcrMROxs9pSrgmhh5prYo/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DmNf7bvV; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7e6d04f74faso3828461a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 02:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733828066; x=1734432866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uxXspid5o6xpVw8za1MpKJmLJ8fRFah2X5zCKtc0slw=;
        b=DmNf7bvVPfH4u9x73yGqLN4TXiciPfOI7ZAka2tqs6qS8xguwEHf8lsEosT1RimGmC
         2T6JrgiuynRSOS2YE/5SQGgeeQEnMzVZ4CHSRHGJSVQILWItsnykTybx/1c2xBpMXDiD
         1TbjFiG9x6vkPemlfBY0xMVEHTCsj88jN9pL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733828066; x=1734432866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uxXspid5o6xpVw8za1MpKJmLJ8fRFah2X5zCKtc0slw=;
        b=FqaRoPZiISXDPxRW78LuwX0LKFXmtoL4aV0X+EcMV4FCLOYSe1mfIHty5R7PBEdlSw
         oVoh4wYPNy602vQt3/bucPIIQ5f7CR/hvyVM3WyrzaAucosAJCMXVSaQ1+o1LMTPFoNf
         qTsOLwOs/Avxi658wOU1C+Ebno9LMjDDACTKdWKobF9PeqWxpUUJYIgJgN4Pui0ACAEI
         it5dRcgh3U/x46XZIPgMmJRw12wJEJNCM47sA5iw5ZD6yALTS5dV1cAjmHxJqHWC2xi/
         NLa8z/P+M0Dy5EExjaVD6ivLnhuf0YTDWN+pF0nbJMnjXbvnZ4l+3qi6USWdsPXFiQZg
         7hAA==
X-Forwarded-Encrypted: i=1; AJvYcCX+affBwmPT81hTiRB9QEW5fXwHgi9M6cWcGzOG3woK6ua8/hqEwWfhvvD6Tnigj0N7WVxvtTDJ6K3JgDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdEAOEzvDgoNByqHtZl8NRpAw9+9QvB9SR7OzQQ0BJgNuLFbpH
	b2/a9RUd7XWukgs5FRG9TF3VGqMWhSM11iWkTdtBb0ANaA44wQRiJ1RZwQNrug==
X-Gm-Gg: ASbGncuoi6NRhzQwrZp1+CP1YNUpYJmbx81bAloOuVOP9O5f+VjO6ZA2a/8+Uv0bzbm
	/G19zuA/genDwr43i6goyIZctlYxKI9A9b94rV9prZKLd1nbB9WkJWUlA3+5xleZ1Gjxa9Ozl0O
	uehdkf5mhqCYS4sPLSUk5REdbo2qX23ydeJq7ljYkirz/qreSpyfzpTpc98hYXP4HN9r9kNn+a7
	t3VVj+fHRRoDqArr8Q/la6sOYrtvjz0lzBoTwwTdvlE4r2gyToLyhLX
X-Google-Smtp-Source: AGHT+IGp53Ssh2BWkhb6jnPEKiZjnDRr/+gFv3a0SYRD0KZP6Nm8RBtsd5rGqfbJxHJwB2M2ZG2h1A==
X-Received: by 2002:a05:6a20:734c:b0:1e0:b319:fc05 with SMTP id adf61e73a8af0-1e1b440a65amr3639790637.12.1733828065770;
        Tue, 10 Dec 2024 02:54:25 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:4d97:9dbf:1a3d:bc59])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-7fd157d45d3sm8808753a12.80.2024.12.10.02.54.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 02:54:25 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 0/6] zram: split page type read/write handling
Date: Tue, 10 Dec 2024 19:53:54 +0900
Message-ID: <20241210105420.1888790-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a subset of [1] series which contains only fixes and
improvements (no new features, as ZRAM_HUGE split is still
under consideration).

The motivation for factoring out is that zram_write_page()
gets more and more complex all the time, because it tries
to handle too many scenarios: ZRAM_SAME store, ZRAM_HUGE
store, compress page store with zs_malloc allocation slowpath
and conditional recompression, etc.  Factor those out and
make things easier to handle.

Addition of cond_resched() is simply a fix, I can trigger
watchdog from zram writeback().  And early slot free is
just a reasonable thing to do.

[1] https://lore.kernel.org/linux-kernel/20241119072057.3440039-1-senozhatsky@chromium.org

Sergey Senozhatsky (6):
  zram: cond_resched() in writeback loop
  zram: free slot memory early during write
  zram: remove entry element member
  zram: factor out ZRAM_SAME write
  zram: factor out ZRAM_HUGE write
  zram: factor out different page types read

 drivers/block/zram/zram_drv.c | 293 +++++++++++++++++++---------------
 drivers/block/zram/zram_drv.h |   5 +-
 2 files changed, 167 insertions(+), 131 deletions(-)

-- 
2.47.1.613.gc27f4b7a9f-goog


