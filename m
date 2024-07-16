Return-Path: <linux-kernel+bounces-254257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D96399330DD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 110141C2290A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 18:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6201A08C9;
	Tue, 16 Jul 2024 18:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmXBzMm3"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133721A01DB;
	Tue, 16 Jul 2024 18:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156305; cv=none; b=OTcPQlXbAIvgYV5TzkQeEjlnM3bHt7KmUBDxPp/AfkKWfIpwm9QwaxQos7YKEBxqZ9ovLw+TyIamiR36mWDZTTLt6aZNvvkngeRIYfXrm2ICBfIu78FG0rGrw6Lz75cZWlYm0QXoIW31+E4QIWv7SpiWyNvL2R37qih+1Kkjc6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156305; c=relaxed/simple;
	bh=SicJpcI+BtX1T3osyqjgxwJrfmLN+824rrUnpMOe6aU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YhHcMYBFTYIs6kfWipyetb+fI27LwUFNZiXIMLUXxW9s0QsuhOZbvFD1e7SKFTAidufD0QuqDRqX0QN73DhIqZFA/WFBdZx/OChRnLc6CQH97tMvq8Wv+bbEHuMIeWEbgy24AtQtxudwwsonz2i/0J28hdrkEsMitAB07q04uLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmXBzMm3; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-816d9285ebdso1218239f.0;
        Tue, 16 Jul 2024 11:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721156303; x=1721761103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4gHhZlZC9lRM4IBPTZ/FMwaYyy9pebB6jMENYSRc4Ds=;
        b=lmXBzMm3OGNA1rGYV17UfmfWwDQU3hwLYg6+DIi1BTxOEU2mh9YUC76TYZ11AeV5wY
         kxGoB5q71TsiExRO8JsFSOvbxz9hRnOA4VWslLp7f0IUBNIdOq33G961vtMqmTIEDghB
         5Uf17ZBhZT+4WDh7F2jPBy43rJg8kUUBXf9LpDjaySLS6CkMA/kbiFnkZDRmi3zxnWN3
         Sv2kjP84I5JxE/V34Tsx6iLMdgJM6ZR0uSwPni5uz0j7KFRimnkhv3mlBD+PfQhtxmMA
         GS4ZTGc59rdNtLe5HK/irwn7ApwgdTZMHMdnre2e8hHgCNZNi+WShg/UVkBstOGDJysk
         rUKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721156303; x=1721761103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4gHhZlZC9lRM4IBPTZ/FMwaYyy9pebB6jMENYSRc4Ds=;
        b=LOTg7bDwWfkUK02vZThSBj+3EeF6u41cO0AuiCsPOflTjQH2Lu1qfcREknH2mnrQcn
         VGzPpXhdi9xTl2L7p6dlpb64seXMwEeJhuvSkQnWTmjCzcis0DrzH62hxXEJ7rvHA7ci
         7aAJHimy+1kbNRAM0ainABdFOyw7j62Sptmk4MeHMdOHSc0UPUN62zrBIRtLEsOTrhPE
         iH5NFGFoOKAxEaaOL6uwUcoM0D9ju0glcXf0J0rqVJEOf85aGHYzAKLQzCmnFYo5bK9R
         WTw/v543+/yefggH4i/zyVdVKyGi72C+rYPtUt1enUqFlF5EIGncs6iuaq7/38NHPdQd
         VDdA==
X-Forwarded-Encrypted: i=1; AJvYcCXOJ7Y7NwYxzRgSfUoikpnLfVd4acDwCzfzwaoyXp1ZX6Xvno0votjn+99KaLE5A7zllMReOGrDa03zYXmXq4Fxua8IQaKpQZNm
X-Gm-Message-State: AOJu0Yz7n/ac1jvPhr/rDPZ3TgCLW+MzsPLD0teD10JwdWlgRg6IGXFy
	cwgjrtKS9HAvKAqJE83hwBamcYXS9B+0KUm/gYrHuKorIIbnEOYeqb1f+bBc
X-Google-Smtp-Source: AGHT+IFIRyDhcxDXmtmK1HLnwwi/E2q7SlYEHNYrBcbDILq7EAQB2veK147HqsG4fbMsp7Bh70n8xA==
X-Received: by 2002:a05:6602:6408:b0:804:411a:16fa with SMTP id ca18e2360f4ac-816c34e606bmr41423339f.9.1721156302764;
        Tue, 16 Jul 2024 11:58:22 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4c210f23f1csm75301173.102.2024.07.16.11.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:58:22 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org,
	jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com
Cc: ukaszb@chromium.org,
	linux@rasmusvillemoes.dk,
	joe@perches.com,
	mcgrof@kernel.org,
	seanpaul@chromium.org,
	robdclark@gmail.com,
	groeck@google.com,
	yanivt@google.com,
	bleung@google.com,
	linux-doc@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	kernelnewbies@kernelnewbies.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v9-resend 03/54] dyndbg: reword "class unknown," to "class:_UNKNOWN_"
Date: Tue, 16 Jul 2024 12:57:15 -0600
Message-ID: <20240716185806.1572048-4-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716185806.1572048-1-jim.cromie@gmail.com>
References: <20240716185806.1572048-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a dyndbg classname is unknown to a kernel module (as before
previous patch), the callsite is un-addressable via >control queries.

The control-file displays this condition as "class unknown,"
currently.  That spelling is sub-optimal/too-generic, so change it to
"class:_UNKNOWN_" to loudly announce the erroneous situation, and to
make it exceedingly greppable.

NB: pr_debugs are only alterable via >control, and to protect class'd
debug's from unintended alteration, "class name" must be given to
change them.  Classmaps map known classes to reserved .class_ids (the
1..64 val range per module).

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index f2c5e7910bb1..73ccf947d4aa 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1154,7 +1154,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 		if (class)
 			seq_printf(m, " class:%s", class);
 		else
-			seq_printf(m, " class unknown, _id:%d", dp->class_id);
+			seq_printf(m, " class:_UNKNOWN_ _id:%d", dp->class_id);
 	}
 	seq_puts(m, "\n");
 
-- 
2.45.2


