Return-Path: <linux-kernel+bounces-525779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F305EA3F4E6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D072421DBF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 13:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CC720E703;
	Fri, 21 Feb 2025 13:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="Fl4TRcXJ"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6B3150980
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 13:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740143025; cv=none; b=YTL1nbjuc4A0uZW37kJM5O9vsnShSy77xq6dwjmKskqN/W9re7xR24oX9kvXqUdgArgz2Yd1DT3r5XmhO+iRclth00w78X6yaeB3GjjFLdHPF1ZqxqiY2nod1Vk3rLEdC//C6qGMfhvWOjkTHJ1FJVg63/GX3ooYHj0lCyiu8kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740143025; c=relaxed/simple;
	bh=gQdsptGZ9CaMj//xghZ72pdP5w5JRXTNCAWzn3QbAtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O/W20LBt2Nhsw+R9jnicbPO2henF4ki211CHrOYNkaqhBblR1LcUbN+yybDkj5y3pdML60Dydj/TsFU/Kerno0/n+Zfljwr2PL4w04ADZrTEf5thgkK7C+p/rewN0Yw066i8Cz/mLlX7vEKHWJTKbC2l+pbXr02pc+GVkiMd0vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=Fl4TRcXJ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so14299275e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 05:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1740143020; x=1740747820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNLCdFptAS+7IKWDtBhu1m5ZWhtk7jbJJUz+DR9hOno=;
        b=Fl4TRcXJEYFpWPN5QFqYFgRhfb+x2/anQR3xaPLvWkSRUE0DDhkYWOSRPKlSRCoczp
         Q5Dg6QS9rcyWsTZlZvrhx6zzHA8fsCbaK9m/wyjEPNECCouIhr/ybG/WteCNSyHul2hE
         0VP+MpEoAw6fVQQFwKIo5hzbaLBRl68LvfGXcxTfyYS7g7E+OkxQcDIG8PUcGpH2JiBS
         DeViz/ivP25Z2Gj3njAzeeULNIeZ81Qwb+Qd+7k7/9+4ZGDta54D+VQdhWPTcDhQM0Te
         DXZw4EdaiwjG8KO+DZAAnsJiDQmOddg/XRYjSuPuNRCmnYpf3MXBIjCfq3xh4TLNOX+T
         QfDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740143020; x=1740747820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FNLCdFptAS+7IKWDtBhu1m5ZWhtk7jbJJUz+DR9hOno=;
        b=utN/zjGKsAjZWxLNxM2Q8tjsz3nSBoTFgQg48F8HyD3tcM6nIB8w2OoIaER9NNwtaJ
         FgPrK/elQa5DitIEkhqQp8YzCG/ptQP7wumk9jr1l2wAkn0Fm+12r+kfSVTAuVp7i+7Z
         S2ceajKis+xxXjWRO4qmflUVsQLU8WzusC2zuVcsZyklukZausRjniVn4IocDke9vfcK
         mwMWHvWkepGhR3xydrJcUusrDl0lJpWFELGNeJOS1hMdksSgeHRwhpfmSD6AbWTkf/6l
         KhXFJwRGzY9Tcot8L3W2/NwHJh9puaKhAFnE+M0jjc4gGHiLGIKFHf1flJlQiQJR03En
         E0dg==
X-Gm-Message-State: AOJu0YxwIiDdYk9WwE9wXBLaai66n85zDtdMjFMr6UcITms7jKZ2Oihl
	9tT9RqftUZvfouMPfUYAOKRqHOlcwttZ6zomXg3XqrQPsJau5+MARRMR9PTEovA=
X-Gm-Gg: ASbGncvtLcu1676l/OCuCRjtmFaMFYVa3NwzHc2JiCiYW4RELuNPPEz7QpC8t0FHzGl
	e67T/a7DiP6WyuYdj8g3aVRfn2Kn2AdODkF6bvSzGq9sDmJUtDJyasS0ROl6lp9SIcM9O+WilFz
	xse7xmZojw9AuiVRUTm1MsEE+VGH2b7UjGAX6C3h35KXsTMTAlBaUEo239k5XJ5kqZo1KZ7iQSn
	sxAo8GenigtbirfrQVpRRBLRBghyNQiTF11q+Cupf3b+fbEBX2ibWjHOqLZ3nqoQNWzEW5OUeuz
	+l66ZWNgnTxG5mvPGILA37CtPuX0MXnRTUmEhUhh
X-Google-Smtp-Source: AGHT+IH2ZlxkzwCrkB6WfL1Ww6nO/RRvy91sdSepv2GdVnmGAXn0nEcSCYeYcY0Bpkux7jlqsNSPbA==
X-Received: by 2002:a5d:6d0a:0:b0:38d:dd70:d70d with SMTP id ffacd0b85a97d-38f6e947399mr3346487f8f.18.1740143019862;
        Fri, 21 Feb 2025 05:03:39 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:13a9:f3c7:539a:f1c8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258ccd51sm23343361f8f.29.2025.02.21.05.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 05:03:39 -0800 (PST)
From: Antonio Quartulli <antonio@mandelbit.com>
To: jan.kiszka@siemens.com,
	kbingham@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Antonio Quartulli <antonio@mandelbit.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH] scripts/gdb/linux/symbols.py: address changes to module_sect_attrs
Date: Fri, 21 Feb 2025 14:03:04 +0100
Message-ID: <20250221130304.5882-1-antonio@mandelbit.com>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <8e16609a-7e19-4d4a-951f-58c8bd012086@siemens.com>
References: <8e16609a-7e19-4d4a-951f-58c8bd012086@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When loading symbols from kernel modules we used to iterate
from 0 to module_sect_attrs::nsections, in order to
retrieve their name and address.

However module_sect_attrs::nsections has been removed from
the struct by a previous commit.

Re-arrange the iteration by accessing all items in
module_sect_attrs::grp::bin_attrs[] until NULL is found
(it's a NULL terminated array).

At the same time the symbol address cannot be extracted
from module_sect_attrs::attrs[]::address anymore because
it has also been deleted. Fetch it from
module_sect_attrs::grp::bin_attrs[]::private as described
in 4b2c11e4aaf7.

Fixes: d8959b947a8d ("module: sysfs: Drop member 'module_sect_attrs::nsections'")
Fixes: 4b2c11e4aaf7 ("module: sysfs: Drop member 'module_sect_attr::address'")
Cc: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
 scripts/gdb/linux/symbols.py | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
index f6c1b063775a..610a3dd3c7b4 100644
--- a/scripts/gdb/linux/symbols.py
+++ b/scripts/gdb/linux/symbols.py
@@ -15,6 +15,7 @@ import gdb
 import os
 import re
 
+from itertools import count
 from linux import modules, utils, constants
 
 
@@ -95,10 +96,14 @@ lx-symbols command."""
         except gdb.error:
             return str(module_addr)
 
-        attrs = sect_attrs['attrs']
-        section_name_to_address = {
-            attrs[n]['battr']['attr']['name'].string(): attrs[n]['address']
-            for n in range(int(sect_attrs['nsections']))}
+        section_name_to_address = {}
+        for i in count():
+            # this is a NULL terminated array
+            if sect_attrs['grp']['bin_attrs'][i] == 0x0:
+                break
+
+            attr = sect_attrs['grp']['bin_attrs'][i].dereference()
+            section_name_to_address[attr['attr']['name']] = attr['private']
 
         textaddr = section_name_to_address.get(".text", module_addr)
         args = []
-- 
2.45.3


