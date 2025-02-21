Return-Path: <linux-kernel+bounces-526630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDD5A40137
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 21:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 581FE3AFCB4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D162D204581;
	Fri, 21 Feb 2025 20:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="e6j5QazZ"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CFF1FECA0
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 20:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740170453; cv=none; b=Ld5YjKW/WFv2Oeay7+Nsb9F7o3XEe3S5+svOqufspv1GQNzYUNo+w2MY5sxP8GvtSwxFVh/PLUDlwy7jaYaHMKUOBtOvtxMsf4WLXIrS1pTdSVJ60oC2fRT0YXx7Exjm2lnAx7M9rfR12wuTx9IU7m191w3IYesAm2OFJIEJCQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740170453; c=relaxed/simple;
	bh=pH31vEcCf8Da5tR13/k7nZyU2ju7qkWlo9Q4p4GrhqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P5z0JLsl24iflZbhfsoS9Ka3UR6n8Auvl/t697teqe0R2F7lVCx2Bnfwj7VoUMJnNzZRHKIkEnA0WiN9lgqBTd8FP6u7lxoo/jK2Jk5B702P9OkqBJbZXvtfxwOhVIGZ80l/TrY9dJvcS+seR4/+JYVwlBLMBxFrJMI1ibfrUVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=e6j5QazZ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38f406e9f80so2272832f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 12:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1740170449; x=1740775249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WfLTur3x/XLUNq696D7Bfj5QYXowjo7xugeDogl16MI=;
        b=e6j5QazZ/qfnnrvBj6P0nBd8se5IxpaA6yVCBwez8kIaFkTRh3cdyN7d8f0QZiXkq4
         V1N6EkqX81qPiwzuvciWQe/5b4n3nIksJ7wx0wTYs/PWfkyLYEocb5yWyf0+WAYJ6oEw
         zZHjNefI1rE3q2luKm2MM5NjFvxtoAVFYzXRxvX6b1/roKWmLXX9BZaTSduEoaQbF/Zs
         cZXC8J0XOQ6bgwC2U1MuOsTtKKECG82Epi6Tf5wbiUT/BgumFqs2ybNtu1rdBCymTwfS
         UDoy0cjYdF4YrNSsUUoKcPqIhlTqGY6o6MSeZmyIPiN4LY0wPaQ8wXcuhHEtOFAkewgg
         CpCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740170449; x=1740775249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WfLTur3x/XLUNq696D7Bfj5QYXowjo7xugeDogl16MI=;
        b=YXmcsVnPttC4g/E6w7vFS1PnGVFrbLICrQzpOt+JOY2TmVbUHCsZOHb/j3cEWGOJae
         TxVFP7CaNTbxzuFqOoIz8dQCsrz3kGqWMzuRELcHEGO6cCediYwIE6g+or1h12K0Jzkr
         6B16aXSEjU5thnDgH3GtaEH0ljhMrJsLzo5x37vkTHwFwN7clRCFkk1u57HtiaEMdprF
         UyxBOo17PiFH0me6UBSqk8wpz/tC+2/5m+caXhN9D5cRKQ/YWlU+btCHsv/QG40/PIp+
         pG3N0SRTjOnMs/qK7A4JLGDSsbWFtLF7/vUDx58TU/Wjc+tlIGy7lBeXRrBKk2+A37CL
         RD9A==
X-Gm-Message-State: AOJu0YyHafGSa4rzWT10G49Ut2+KrGWuk/lAuB3q3ljJbJkIgvJL4vko
	JZtUQXwV3cteXc22syL1DqpgeQhVK/jp54vzIA5XWxPWhKloVRv2netdieHSQjo=
X-Gm-Gg: ASbGncuQB8NN5FppPXLfM6NwoQnzWUXs0m96Ps3pj3cjtvdBZIuKInJub+vFoYQx+hB
	LrE79Uxad8sTKOyHuXTpvPGdvV8dZW85jGvAfizR6VCd5CuIqMZcMzzQRjY9JsmtmsDj7ZutVjp
	mvUBUmTLlytUyF6HLR/lv1tfaPKXaXpDg3pV3Sh8sHs94jR2P7GKvobLhGeBd9Jdv43Q43DL0ts
	feswl0ZtXJFIyHnEh3sAhDbsAk958lnu4bmilv9jXuSrvhF+n8qk5ZWhs0NxetmzOVJFAsE3GyL
	wadNPrge593lQABcWBvusGgnA9SE30+K8405drs0
X-Google-Smtp-Source: AGHT+IHQdfJRRwhEpZxddSNoaOI+LzERsTvrH0lHRQq57btrpFMg5ylXbwHSHZHuRpIrLH5SKWDlEA==
X-Received: by 2002:a5d:5011:0:b0:38f:44eb:40e with SMTP id ffacd0b85a97d-38f6f04fcfbmr2814448f8f.30.1740170449195;
        Fri, 21 Feb 2025 12:40:49 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:13a9:f3c7:539a:f1c8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02ce735sm27683625e9.3.2025.02.21.12.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 12:40:48 -0800 (PST)
From: Antonio Quartulli <antonio@mandelbit.com>
To: jan.kiszka@siemens.com,
	kbingham@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Antonio Quartulli <antonio@mandelbit.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v2] scripts/gdb/linux/symbols.py: address changes to module_sect_attrs
Date: Fri, 21 Feb 2025 21:40:34 +0100
Message-ID: <20250221204034.4430-1-antonio@mandelbit.com>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <0849b8a0-e1b7-4486-a376-43403e52dd1f@mandelbit.com>
References: <0849b8a0-e1b7-4486-a376-43403e52dd1f@mandelbit.com>
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

Changes in v2:
* changed attr['attr']['name'] to attr['attr']['name'].string() to
  ensure extracted value is a string, otherwise an exception is thrown


 scripts/gdb/linux/symbols.py | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
index f6c1b063775a..15d76f7d8ebc 100644
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
+            section_name_to_address[attr['attr']['name'].string()] = attr['private']
 
         textaddr = section_name_to_address.get(".text", module_addr)
         args = []
-- 
2.45.3


