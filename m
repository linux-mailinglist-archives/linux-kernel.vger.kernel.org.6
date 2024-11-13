Return-Path: <linux-kernel+bounces-407785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F35819C7452
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAD3B1F21F6A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92D82010F9;
	Wed, 13 Nov 2024 14:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PwwG8BwX"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF47D1FCF6D
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 14:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731508079; cv=none; b=BetR8nEWcH3lLzSVMyFD/N25EtaAb8m/4z8XnbbwJKv1jCHacQkdgnxGiesQsylbnHpA5XuAqm1e7RwOmWHjfoTFzY3Ac7U/Q9To5wnijM9faeP9DM8qB4Ph1SxEIoE0MLVMpTVT321cSP/XG1aBbBRC84Xr8OgVW3ZjvgthP78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731508079; c=relaxed/simple;
	bh=Y+2H4LdN8mN6PJGaLKpXtkX3V6r/tQyzwkTwSod6FNc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JvxvNus8FUtGlMPRB4BwKXSE1YH3wsDzY3DAp84K7BB4AwoZOp0AvV8xH6CImGONDHax1uEnjrN0DS4hiylCrrn05ygAYOqlaBVZjPIXM6xJkQYDtzxF96/AtyT2uRkaEfue7+WajPIEU9695w3n01Tna6am3RCICcvXpbfyT3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PwwG8BwX; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6cbe9e8bbb1so45485966d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 06:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731508076; x=1732112876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PvYXEOtoobfsjK9RlNl1WSgITYS4vYodr4T5ypoCMpg=;
        b=PwwG8BwX48E7l1wlbo6E2QcTFnMrvTuVrxgp4XINPytAvgCn40NKTTgmeR0fGLvfi4
         LT/gJEXucqr4713/yh+NQbRYIL5SLuRTgc2z3ylGC3+CIawGFUgViVNwl+rH1imXU2i2
         GIee5wJT/p1vPKOZVcQuTEsT0mTXMENe4xZpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731508076; x=1732112876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PvYXEOtoobfsjK9RlNl1WSgITYS4vYodr4T5ypoCMpg=;
        b=AuYCvExk6gr3lEN08eV5eREwKs7tiDu8KWfR5Zsz7lGzOSQo0NtlTBEjyzBE8vhfWV
         X/tNY1UV8GWlyL2nNHs9kLtUzzGTxBvQoT0mGeI7ycWKael9hYwDRhVyasGyp2/tqA5j
         P+mFmzOxt8xJVlYaNRcH9NR45ZN3Gv8uBjHfuLWOtu9fljDj5Iez2aa1obm+oUREqp4c
         GHtTE9fNDjiwJtHaWIMzBQ4BgiJGDKk8UjfRO3qttxsMCbYn8ASF2TNyj7PQAU2u2Fn3
         kdOzFSDMlvVTB0SJELsUu+cQaNDGj/tpxLIFFEyxbM4cq5/KBbVGNdL3eBGvQgA6dvsE
         Ec0g==
X-Forwarded-Encrypted: i=1; AJvYcCX/d8wLasoSidBAewwmJ6MO+ETtBZDESDwj5JADtm/3q/z2FqwgXB2uz2inRFE2F9kkK87OO7c3X8qO/Fs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmp+oWDiruPCWec/6QlZZjfMs11L5ieIX6F20J0ZDVFSn8+c22
	U4ivx9LYxZyanakotk/x5ztFoZLlNGk3FxUXfBk83nOM7J5UvBjR8zzQQJ6Fsw==
X-Google-Smtp-Source: AGHT+IHNU4BkuDoySGHigGN9ulN/IS07Uo7ecwBFdjEIsUxAiHxHdOdLhRm/oLLAi1XFBjrIj/1mmg==
X-Received: by 2002:a0c:f64c:0:b0:6d3:e7f8:e486 with SMTP id 6a1803df08f44-6d3e7f8e4ddmr746996d6.15.1731508076325;
        Wed, 13 Nov 2024 06:27:56 -0800 (PST)
Received: from vb004028-vm1.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3961defe5sm85134976d6.10.2024.11.13.06.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 06:27:55 -0800 (PST)
From: Vamsi Krishna Brahmajosyula <vamsi-krishna.brahmajosyula@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mqaio@linux.alibaba.com,
	namhyung.kim@lge.com,
	oleg@redhat.com,
	andrii@kernel.org,
	jolsa@kernel.org,
	sashal@kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Vamsi Krishna Brahmajosyula <vamsi-krishna.brahmajosyula@broadcom.com>
Subject: [PATCH v6.1 0/2] uprobe: avoid out-of-bounds memory access of fetching args
Date: Wed, 13 Nov 2024 14:27:32 +0000
Message-Id: <20241113142734.2406886-1-vamsi-krishna.brahmajosyula@broadcom.com>
X-Mailer: git-send-email 2.39.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Include additional patch (Andrii Nakryiko) since its a dependency

Andrii Nakryiko (1):
  uprobes: encapsulate preparation of uprobe args buffer

Qiao Ma (1):
  uprobe: avoid out-of-bounds memory access of fetching args

 kernel/trace/trace_uprobe.c | 86 ++++++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 40 deletions(-)

-- 
2.39.4


