Return-Path: <linux-kernel+bounces-181384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B20008C7B7B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 19:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EDE91F22A11
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9252E156864;
	Thu, 16 May 2024 17:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IrtyXGoC"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887ED156F2D
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 17:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715881453; cv=none; b=eRanZ0biQ9m4Wtbk+fCv7a6cgAetqO0s/n7wu/n0Ueo9ue+C0edsVNegMR6nSvV4M0cbNlcsfj89porGM/PYw9iHBijxs8Hf1MCg9vPxRFLpKAL7gBC2pM+ZgZY3pCr8ijOioTUelgVFmipYvrHBZVdeuZnBZxabIsJQkUHK7Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715881453; c=relaxed/simple;
	bh=gtzS+9DVjEwLK3/WiQ+05m1QNOhyl608HV7VX6s6saM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tzLVj3rVAly9sveI+1QrCtvd9jp0gke0YEfex/uODz/C+WasZOGghQ7IZbcaCaKrTWmiSfkGbazRlywJAjDWe1qQhtV81HaoD9iLE78JC1D8y/DaLeczJXLGD+OmNCVZHFzUEwwfOleTlS4ef7OK8OP8gMemCDa3eueA2C2C9iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IrtyXGoC; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7e201ab539eso62866439f.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 10:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715881451; x=1716486251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8BXT8qH3+7khMh8QnRF/zRHf6x/WRU2V0wJ49wwPss=;
        b=IrtyXGoCD/lYM8IWFoJzY9GKGPvBey7ugmgBaEjCiHkMy83CthBO7C38csN+/XcGXU
         OAGONlir/2ySu3k6OmTLiUhSdZeQ1Qg24Uo/1JZZQtIdyA2Anv1NxrlqU0vRutQo+leI
         lNila8LY9VNrJhry75+AuIkB9qQ3URclO0Oe8FjWy9fZFzSAPQqJBOzKc+xIj14+4cHw
         3GrCL0spAo74rxOpaJrszx90T4y0EE0Yk5zQ/iCX9ymRvQ4QA7X1g5W8TDuajiGCBUji
         ArXPLRylDGnA5RPPEuu8oLTH5ai/2H82g2r5FXey+w0r43cqRzqmiyKHr3IG5Xest1EF
         UCFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715881451; x=1716486251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q8BXT8qH3+7khMh8QnRF/zRHf6x/WRU2V0wJ49wwPss=;
        b=FSm8hCFuVOpEQ+hBoTUJQ74Phxlt7ZY+kKprzIi4ihxb7wetvkWq7P/StZFgNL+Q1D
         H88814HcGlfNVU2sllPE/LzzA2mgOn55+tIqneHDttdjn+fd3C4/ysM8gH+84pS9wzod
         YYwSPC56k9FcNAC94K9PjGS5JCMBd3EGaajCFaVD9uwh4dNoawqVZ+7MhX+ooIBsiAxY
         ZypzhRXODzRbLjMfKEmMHXcw63zLOKWaMA+noSvn8CShm6q5AE7R4XTXfeGZQHRdWlQQ
         EWAyY+EJFJOSR/Tbc5YXL2vig7kS81uXEZfgwmbLi1FUUinJHMPwEyJuEDYAFg4EDfqG
         cfPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWE/wNOOeMjrRHoi7/9kPJzKTcn3Q2vtZQPcziuLbmuYqshoiMKJSZbBPBKG+hVYT3l/JYeSOHPzAEOl8yNzougD3SfIZ3Ty3ssVDJj
X-Gm-Message-State: AOJu0YxB+EQ1yg552QaRPBgI+XNqPJKXu/1HQPMwLJ/lJmW6hQW7p3iA
	Cl8jLaWnpl9OQz7UK0Ie4ZFo2GSjXXCDUzP2F6vf4KE+eSs1qgO0
X-Google-Smtp-Source: AGHT+IHjMgBSXwNq6mqpRnowlCGNcQiMuzRsRtbWlS8L8L4MT5tGo9g4QZMenLcqK0ZLy7AMDf8D/A==
X-Received: by 2002:a05:6602:2492:b0:7e1:b3f5:bae6 with SMTP id ca18e2360f4ac-7e1b51b6596mr2127032339f.6.1715881450207;
        Thu, 16 May 2024 10:44:10 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4893715057csm4273595173.80.2024.05.16.10.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 10:44:09 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org
Cc: ukaszb@chromium.org,
	linux@rasmusvillemoes.dk,
	joe@perches.com,
	mcgrof@kernel.org,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	seanpaul@chromium.org,
	robdclark@gmail.com,
	groeck@google.com,
	yanivt@google.com,
	bleung@google.com,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v8-RESEND 01/33] docs/dyndbg: update examples \012 to \n
Date: Thu, 16 May 2024 11:43:25 -0600
Message-ID: <20240516174357.26755-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240516174357.26755-1-jim.cromie@gmail.com>
References: <20240516174357.26755-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 47ea6f99d06e ("dyndbg: use ESCAPE_SPACE for cat control")

changed the control-file to display format strings with "\n" rather
than "\012".  Update the docs to match the new reality.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 Documentation/admin-guide/dynamic-debug-howto.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 0e9b48daf690..6a8ce5a34382 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -52,12 +52,12 @@ query/commands to the control file.  Example::
   # grease the interface
   :#> alias ddcmd='echo $* > /proc/dynamic_debug/control'
 
-  :#> ddcmd '-p; module main func run* +p'
+  :#> ddcmd '-p; module main func run* +p'	# disable all, then enable main
   :#> grep =p /proc/dynamic_debug/control
-  init/main.c:1424 [main]run_init_process =p "  with arguments:\012"
-  init/main.c:1426 [main]run_init_process =p "    %s\012"
-  init/main.c:1427 [main]run_init_process =p "  with environment:\012"
-  init/main.c:1429 [main]run_init_process =p "    %s\012"
+  init/main.c:1424 [main]run_init_process =p "  with arguments:\n"
+  init/main.c:1426 [main]run_init_process =p "    %s\n"
+  init/main.c:1427 [main]run_init_process =p "  with environment:\n"
+  init/main.c:1429 [main]run_init_process =p "    %s\n"
 
 Error messages go to console/syslog::
 
-- 
2.45.0


