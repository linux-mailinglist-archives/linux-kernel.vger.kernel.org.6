Return-Path: <linux-kernel+bounces-436975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA8F9E8D6D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41D34281D6F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 08:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE665215077;
	Mon,  9 Dec 2024 08:30:56 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DA41C0DED
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 08:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733733056; cv=none; b=RT1v/Qmp/c5HcF0wGddx9UQplfnTrPVIEcw5fsmGFRYHBTUPSc5ZmfV4Xwe/kHSXX8Mtq5bY77Kvm9/7l/W7J5gXc1eMeR4RZTnepYL0M65fM6qFrISTt1LV+EXNn0YQbLSEpxOJidbYbqqAlfI6c4/xoedRvTb9Dwgp/Jvup3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733733056; c=relaxed/simple;
	bh=VnugjWMxy9vnbgvxMaqOGzmJqRs3foJyoyjhqB0RijE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=aIwY0Lg54eknDAgViz+LlrxZnh6WV4FLy9t3FhlIq/IiG2wBNhy68/SgaoI+Xs4O4LU9ja6bToxZlyWRDW1SafIVHAZvp6KhiPPZuK6iivlXRAziSpXhwsI5qb9mm2vv8OSV2REopInmq93p44PhM+7NOYTu1rLZvbQjhyts0PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-434f80457a4so3528945e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 00:30:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733733053; x=1734337853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uvI82vcivs+7i1qjX3nrH+6GW+65oOxYP4PhLZywbXY=;
        b=eqC5u3fC+qxGr9GraRWdp5HCyugtCDR8dv//BShSBl+aYV2qr2onJ9fO4pDzPB7bDW
         SF64RdQYwQWXtG+gMhoAvVY5JyA6uRVHUGGh16MVMMpGnKiE/rRLhe6VOIT9Qd/+P/Zp
         87A5FmFyyWxBBK6k+4AYA7BmulyWWbSGE57V38/OjjXYB8yt6JCPNX+oQKmXs3M8APWM
         aFhU70IiOuV/yVRxrjjaCJaH4wCuYrmFtiTgXPsiGGpGe1ua7aYfkDOeOc72CYaWxHy6
         t5JXnsyQm+BlrdCzgJ/CTR6mwij3hO2lP9ezTzGz0eWdz4QCzhWMoXd5WRaWGs7aR5Th
         vf3w==
X-Forwarded-Encrypted: i=1; AJvYcCXXZaonrDfKczyzl7D8KjYCj3L4Dd+pbxvMs6yrvP5IceulTaYnlz81BrgCykhWEL44M0lrbX78GzjhEPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWfbBiESl2JJ8biXLcEhIUWpdAL0FOhNFM08hT6xyNJGkMw2ur
	gKmYbGzSo/9HCyB8MFKQGqj2fgAI5tVWLG6YDuhoeASY5S2IfGPP
X-Gm-Gg: ASbGncsHzCg/gStvF6CB46f5C1aujoEmzei400V4RYIId2HDJrOqa1Cw8rtAmVGLgUL
	a2boAZRNhKiSphOksKyAdphnvuUIa7DBkmR8e4I6vm3wgxB1Q0CCf9P5g2IwGz04jwVKs/lnsHZ
	9IGwRk/NahTUyTdPgM9ev6Cw+IQoaKXcbeWv34boOzGA5CrE2UwZp5G4NqK1uSxvfAwHT5atUZq
	IFff88+RP6y99NcnZN7/swY0KUDRYp6kyvkCQcimEotWYOj3u7jSUc1mGD4In7wf5Q=
X-Google-Smtp-Source: AGHT+IGNl9d5+7jtlWQkpHc2oXXfeBP2cTm4F+xLFNz0wluBzzm8gDfkX/+cxMv0BPUnYLgEmk67Mw==
X-Received: by 2002:a05:600c:4f4d:b0:434:fe3c:c662 with SMTP id 5b1f17b1804b1-434fe3cc9d8mr3233445e9.12.1733733052983;
        Mon, 09 Dec 2024 00:30:52 -0800 (PST)
Received: from costa-tp.redhat.com ([2a00:a041:e280:5300:9068:704e:a31a:c135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f9da4cd0sm24295375e9.26.2024.12.09.00.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 00:30:51 -0800 (PST)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	=?UTF-8?q?Ren=C3=A9=20Nyffenegger?= <mail@renenyffenegger.ch>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] scripts/tags.sh: Tag timer definitions
Date: Mon,  9 Dec 2024 10:29:57 +0200
Message-ID: <20241209083004.911013-2-costa.shul@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For timer definitions like
DEFINE_TIMER(mytimer, mytimer_handler);
ctags generates tags `DEFINE_TIMER` and skips `mytimer`
because it doesn't expand the DEFINE_TIMER macro.

Configure ctags to generate tag for `mytimer`
ans skip the `DEFINE_TIMER` tag in such cases.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
v2: elaborate description

 scripts/tags.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/tags.sh b/scripts/tags.sh
index b21236377998..7102f14fc775 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -188,6 +188,7 @@ regex_c=(
 	'/^PCI_OP_WRITE([[:space:]]*\(\w*\).*[1-4])/pci_bus_write_config_\1/'
 	'/\<DEFINE_\(RT_MUTEX\|MUTEX\|SEMAPHORE\|SPINLOCK\)([[:space:]]*\([[:alnum:]_]*\)/\2/v/'
 	'/\<DEFINE_\(RAW_SPINLOCK\|RWLOCK\|SEQLOCK\)([[:space:]]*\([[:alnum:]_]*\)/\2/v/'
+	'/\<DEFINE_TIMER(\([^,)]*\),/\1/'
 	'/\<DECLARE_\(RWSEM\|COMPLETION\)([[:space:]]*\([[:alnum:]_]\+\)/\2/v/'
 	'/\<DECLARE_BITMAP([[:space:]]*\([[:alnum:]_]\+\)/\1/v/'
 	'/\(^\|\s\)\(\|L\|H\)LIST_HEAD([[:space:]]*\([[:alnum:]_]*\)/\3/v/'
@@ -260,7 +261,7 @@ exuberant()
 	# identifiers to ignore by ctags
 	local ign=(
 		ACPI_EXPORT_SYMBOL
-		DEFINE_{TRACE,MUTEX}
+		DEFINE_{TRACE,MUTEX,TIMER}
 		EXPORT_SYMBOL EXPORT_SYMBOL_GPL
 		EXPORT_TRACEPOINT_SYMBOL EXPORT_TRACEPOINT_SYMBOL_GPL
 		____cacheline_aligned ____cacheline_aligned_in_smp
-- 
2.47.0


