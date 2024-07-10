Return-Path: <linux-kernel+bounces-247276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D586292CD6D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23FC8288EB0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 08:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF7E13C821;
	Wed, 10 Jul 2024 08:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="zMlVYQPB"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADE412FF6E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 08:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720601249; cv=none; b=UW868rq6ulWsMFh6kpeh3uHF18eU3tID0TAH4gaVtiuAJ9H4rLb7okiIE15QLH1a5XoPi9TVMuGxTVFqsWLgoxdXDrfSavlXrMJbtNN+4jHoolt68zo7PEAbH0xsqtkLCdoM7Vle8rrH/rX5MIJp2cORo4BjIkiG/pbuB9x4xnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720601249; c=relaxed/simple;
	bh=sywUPBEnnv0b7qXGDQ0uxTWdAlENtChXdjIKVPkGsmc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=E/e1K6sHOLcGo3OTQ2/vBs8+8of5wsKBhVQkLnWR463/H8M3bU7P1V02o7+h2WDZBKqDoehYo2NKHhnHfmCmHZK7l9u9kwrf92S64omSH/rhZN9Y/fAPirWCABx1YfT4B3ppiWly9cq6rusv9qofnFRqk0A+GwBSfeEvfol94cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=zMlVYQPB; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3d96365dc34so744716b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 01:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1720601246; x=1721206046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+4vhb4x+1ngj2cwnEYd7V6NzeKsvkyPmJT2A1p8eqn0=;
        b=zMlVYQPBmc0tlob/r6QDx841F0QYwky2zE0kuX3eRGgri/7VGjxU3EOHzrcLaYOHqV
         HY0dn9TLMrfklCx3ytd7p1imIu8FXamwwMEGjQODzAPZbladrUw+5ngrZI6tGwHQ0l2k
         z4bH6oCLUhwibGclwZjU9n7gY6VqcLSKOfVI6P5bCHcqXqwaQiPKk2uUYDtzZVJYtDLL
         Utkue5AZRPlwJK7hxdFzuI45So3ugIO2ZM1TwFbzlkADZ4BkP25NDKMJ+ZgqFfJXYfbU
         TpAxjO9kjTa3MezG0bQnho/FN4IbArjaQWMwHsLKmt/gGEUwt0eoQQOkLsSCAAH4kfyw
         OYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720601246; x=1721206046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+4vhb4x+1ngj2cwnEYd7V6NzeKsvkyPmJT2A1p8eqn0=;
        b=TKeOrvJbqEKgG5P4h2iYfbT1JZ/WQ6JPHk1GW32SCyxbguCB6LxRsBHse+ciLMXu1q
         CU6WYUtrywttMlW20C39ODg+a4QYfvO+phOz2iUnzMjNBZDnBOUA6NQrupWxwoc67HoE
         m1OHisSpH7hZqXvwRTPNulRRIQNk8TvO+thyypREorv9Csijb9OyLpTI1O/jmFUJyLr2
         0DvNVsJGM4MZAf6F/nJmAmayVrXe9/MHib5vVwOFQOVk7xuNYQqczSIekxWbKmLdlCvR
         i4GZSCeWMTuaBYSIYw0ZfSKKc1twmQA+OCjF1ONJa5tgteKJWISLUPfWjqRyGTvDEJOa
         RGHw==
X-Forwarded-Encrypted: i=1; AJvYcCW+YCM6BudZ2KR7TiUjuj1R/NbqWPT6BAk/F779QBoq6VgA3iVVKcdTCIj2LvqESa16vME3wU7RGl7PO5Fqv6bdWoUPSAHLBtQRG1qZ
X-Gm-Message-State: AOJu0YzNitnYYINsTM6MmGWG/c6LVlmGPlrGQ5acjfilyXdvfRtniII0
	LjwjXXs5oxzE+mEex5kdAGzfsAFiHzfpDHcMSUu9ztRoPDjiIFxwmO1tM7dWxlk=
X-Google-Smtp-Source: AGHT+IGQT0q7ZvCjUcYcC2KSlIBRszB33wvFdbqGu6VxoW8hdCjhAZ3/FBfpHsJvLaKlLcZR5GMGZw==
X-Received: by 2002:a05:6808:30a2:b0:3d9:232b:e275 with SMTP id 5614622812f47-3d93c0297ffmr5077041b6e.25.1720601246553;
        Wed, 10 Jul 2024 01:47:26 -0700 (PDT)
Received: from yc.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b438997d4sm3216077b3a.28.2024.07.10.01.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 01:47:25 -0700 (PDT)
From: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
To: quic_jesszhan@quicinc.com,
	neil.armstrong@linaro.org,
	mwalle@kernel.org,
	dianders@chromium.org,
	linus.walleij@linaro.org,
	airlied@gmail.com,
	dmitry.baryshkov@linaro.org
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Subject: [PATCH v1 0/4] Break some CMDS into helper functions
Date: Wed, 10 Jul 2024 16:47:11 +0800
Message-Id: <20240710084715.1119935-1-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=yes
Content-Transfer-Encoding: 8bit

This series main purpose is to break some common CMDS into helper 
functions (select page and reload CMDS), refer to the discussion 
between Linus and Doug [1]. It is expected that there will be no 
impact on the functionality, but I don’t have an actual board to
verify it.

[1] https://lore.kernel.org/dri-devel/CAD=FV=VssfZBxwh6i4e_mHhT8vZ_CnXCrUhoeTUeo5xN-FmASg@mail.gmail.com/

Cong Yang (4):
  drm/panel: boe-tv101wum-nl6: Break some CMDS into helper functions
  drm/panel: nt35521: Break some CMDS into helper functions
  drm/panel: nt36672e: Break some CMDS into helper functions
  drm/panel: ili9806e: Break some CMDS into helper functions

 .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    | 190 ++++++------------
 drivers/gpu/drm/panel/panel-ilitek-ili9806e.c |  14 +-
 .../gpu/drm/panel/panel-novatek-nt36672e.c    |  69 ++++---
 .../panel/panel-sony-tulip-truly-nt35521.c    |  29 ++-
 4 files changed, 138 insertions(+), 164 deletions(-)

-- 
2.25.1


