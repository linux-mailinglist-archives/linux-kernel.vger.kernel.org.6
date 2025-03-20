Return-Path: <linux-kernel+bounces-570194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E1AA6ADB4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E3629830B1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92731229B1E;
	Thu, 20 Mar 2025 18:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNdg+3wQ"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C67227E99
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496787; cv=none; b=DOeoFyj3Ivh1b1ixiDJF3UZrBh01vzVjJPYpXSz2WWDgvKEzNK6KXs27qjCWF5g6EnHARC8TKHlFeJvIrya1PAOBgHZ5wF5tgPh5cl/7bX0RjnbmSZ6gyztWGHoJTKnOkUfYECe816Pr221ezIOb2V8iDKOArobFD7ld3Xp344s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496787; c=relaxed/simple;
	bh=72Uorn+GYmaKnhcpoSxU8shLko2mjtbfeGAjAHL7YeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c6kVktyBryXza6kmvEpkT2OlBkxLOoT/4MRpIh1oM2OScRYCKkNLAc7eYjGrrPZF6xwfw9o2LUsyqXaBruidsuyOVQfJevqh/AwwUTsP9ptbACcKt9ZtxcAN0jrED26UMy/Y6ae4J+aKqQ0miZAuouTQonP960vfXY9OaV/Ky+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TNdg+3wQ; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-854a682d2b6so76704339f.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742496784; x=1743101584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zri7fWbQ6hYMke6+GekcmDcZwwxzqxWIAq8zKNxMydw=;
        b=TNdg+3wQPHQu5DWDop2M0iABEt44NoF9wXmNKioEYYrMItH7kiAimZMAqIfFGMyhfi
         vW6hnI9Slb/PGOXKlcq15gblDKfD8XEo0/V9UgYd4gJ3MI4B/bP/qwYLmIsOJRyvB4n1
         i8UyNVFksMaEifr4S6BKX9LF+wZTF77lesZbUEtpYfxWB0iW49l1y872B9Ey277kQ5J4
         sQIQSSy6xhKGAofdw4Qwse7QfmdboeckN/ik4J3r0kQKeL1RvKeKHwpPEqLO/1Xj4MW7
         giHkfApoNwXbnzDRX7dIvy2ud60oNW7jIWEUOuX+sZ7aHaRArF9JIDHF9LRkbs3bzm+4
         fLqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742496784; x=1743101584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zri7fWbQ6hYMke6+GekcmDcZwwxzqxWIAq8zKNxMydw=;
        b=BvlIvI7PB+DJFJyoxTrKipYvd96ynqn77hxxbOAazUv8wcm9dtZNbB32th520LMHW0
         JjuzTfi/krv/xRaKUp3HCpfY1Kba5nUcnaBin6mvJedRkdn4JaAYhfYJnNyo0cCJXRAo
         WaPdQAtPNmxj/fZnNl/O0qDYcCfPaogKKB6zxtBNwCBUrpGaV1ZLI2e1vtdWUFx6RAjD
         Jc6LRc08uV1YUK7KywWzHJZoUyQGkJai/E2EP6OgegLJTW5iKJYeeyEP9FH7MuBkh+Je
         u05kNViIWh/38qJNFcaK45vJXtPDqGrF/CFZCcE9AR+CNEGPSaQgdjCVAC71M01qRCkz
         HWHA==
X-Gm-Message-State: AOJu0YwAJTA0BTCVqoQyv+ODy15cHG+a/g0WsrmLJrMElnI3ztaDCO2U
	SdhCJdIqFLnMGWdcdN6kXVr0uGJw206koI/D20Azgr+LLuJS+w+eg7Q+bfUC
X-Gm-Gg: ASbGncvGY9UHN/EJtO0jCwolhygjpMF5/ApFsLphY5TcxHwheCJzksklgnbLvtoRcTK
	+6n8nRP9UKTMpWBj4INrFMXQvUssXlQrIIAQzuFpOr6RF5RnThsfmgyssHEuOYWoBm5jVmySeF7
	gI13QME5A91z/lpxDV2aY6pYg7EfYi4mYcG0IooagUnynj1QVMKejFF0ghr9Hd9IqiDG5APHjqE
	Lz1G3TsYdDq2HT8Co73CqYg+wugYOJZqig9ivv2lF+siaCfMrQECebmZ6bzxzLEthQu1HM+wCZo
	wJGEJT+BPyg3H/O0Ht6sIK0PcVBm0aYwd2bswFiagRG3WQRrFXVw8X3ud03wm9V0rOeAR6nvTtg
	vqw==
X-Google-Smtp-Source: AGHT+IH1P/jk1OIslkAUGgFRZQR/oxbnvI28Bj54hNazA+wkeOw9UlyQ7Q8GNNj4dKRg9NNNZoJpTw==
X-Received: by 2002:a05:6602:3a0e:b0:85b:4362:3403 with SMTP id ca18e2360f4ac-85e2ca8a796mr50382139f.7.1742496784432;
        Thu, 20 Mar 2025 11:53:04 -0700 (PDT)
Received: from gandalf.. (c-67-165-245-5.hsd1.co.comcast.net. [67.165.245.5])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-85e2bc273e7sm7078039f.17.2025.03.20.11.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:53:03 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	intel-gfx-trybot@lists.freedesktop.org
Cc: jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 03/59] test-dyndbg: fixup CLASSMAP usage error
Date: Thu, 20 Mar 2025 12:51:41 -0600
Message-ID: <20250320185238.447458-4-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250320185238.447458-1-jim.cromie@gmail.com>
References: <20250320185238.447458-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 6ea3bf466ac6 ("dyndbg: test DECLARE_DYNDBG_CLASSMAP, sysfs nodes")

A closer look at test_dynamic_debug.ko logging output reveals reveals
a macro usage error:

lib/test_dynamic_debug.c:105 [test_dynamic_debug]do_cats =p "LOW msg\n" class:MID
lib/test_dynamic_debug.c:106 [test_dynamic_debug]do_cats =p "MID msg\n" class:HI
lib/test_dynamic_debug.c:107 [test_dynamic_debug]do_cats =_ "HI msg\n" class unknown, _id:13

107 says: HI is unknown, and 105,106 have a LOW/MID and MID/HI skew.

DECLARE_DYNDBG_CLASSMAP() _base arg must equal the enum's 1st value,
in this case it was _base + 1.  This leaves HI class un-selectable.

NB: the macro could better validate its arguments.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Tested-by: Louis Chauvet<louis.chauvet@bootlin.com>
---
 lib/test_dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index 77c2a669b6af..396144cf351b 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -75,7 +75,7 @@ DD_SYS_WRAP(disjoint_bits, p);
 DD_SYS_WRAP(disjoint_bits, T);
 
 /* symbolic input, independent bits */
-enum cat_disjoint_names { LOW = 11, MID, HI };
+enum cat_disjoint_names { LOW = 10, MID, HI };
 DECLARE_DYNDBG_CLASSMAP(map_disjoint_names, DD_CLASS_TYPE_DISJOINT_NAMES, 10,
 			"LOW", "MID", "HI");
 DD_SYS_WRAP(disjoint_names, p);
-- 
2.49.0


