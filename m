Return-Path: <linux-kernel+bounces-385422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 735779B3700
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C67B1F241AA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EEB1DF96E;
	Mon, 28 Oct 2024 16:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="kijhPdzN"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD67D1DF752
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 16:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730133947; cv=none; b=kd8jOv2/9JgNT4WxEKj1VcdBrVrinyljqdUdYZZaMAkVfhez0QwhsDhkuEjAWZsoglvj13HbT+z4KXNtr8Ob8XY0ex8hwmVZHZBiKHo5KFt/i2yKlbIznxx1mocMIJ2dpsrM3WXz8iVYe5k133TBkxW2nrMHNrwkA8meO/aThz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730133947; c=relaxed/simple;
	bh=ToxVpap89sdmMrlRQDwTP3V9Zux3B7rIoxt1tc4MLys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W7yuyv60Eb8CMFULXqsaBLzUQM+Y1c6cvNJMq48oPWKlllipz/oJXvYviANIbTiiN39//5E6/wBCAO6zO1psjEoFd/6v+2v2oCAGGzuuSVyqUj2VyG3EAOFBDBxe9BxgdVD8QtofqRWPt+PjIIZQ2h/+XEdH1jnkRuO3qKsVwNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name; spf=pass smtp.mailfrom=chrisdown.name; dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b=kijhPdzN; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4314c452180so38206105e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 09:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1730133944; x=1730738744; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jVZb7rcW7K/0zR07WvqpGJJQNS5kDJRHk0M0yg+StJM=;
        b=kijhPdzNxQ7EEJ0Jt4NnlFsqgdSkB6JVYppOQFxkIzuWu8TXTmcU5dxqlC16QEKAsY
         fE4bVokBcork27NoCSMwp3M5lcohPzvjULD8Gzos4ku+YrsBWbh88gg4PCakwtfueVsB
         2bAbWG5EUhrAYCiukPPuRDXCAyICTceEBpeGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730133944; x=1730738744;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jVZb7rcW7K/0zR07WvqpGJJQNS5kDJRHk0M0yg+StJM=;
        b=E8wNsVaK4vApgyneJRaRTp0nFASvNtWYW6BLSkTxjvwAo9MnK0HvdlLxBGyJcz6O8T
         M+d969PeQcU+R4u+6pQ0qcRmLaFKDqyiUZm8ED0z1SICzNsp+u1w4hbj5+CiyL61jzTp
         Ws0g5tWCThsaz6YO4zDlNnyrmLVkwxnyO8XEUWWGUjNc46E1GQU3O3tGhsP4wkDYRmNN
         gekf4Ihmohc+h245HKb7+q666qFuTpa+EmxjJ133rWFf8i8f4FMnzHr3/uWxSIrlXFA5
         Ukn3/tIWmiW19dcJTyOMxpsPawbKbX9BhUnf2NSCbrqFnJkVMTza/ElS49cpeh9v8hSe
         30Bg==
X-Gm-Message-State: AOJu0YylmDcKbrdQT1Gi3kCHHHKuWWPh6Qr0EhYhsoUdOgYS8W9Uxf+D
	qtubbatBhr3Kz6M1g9yAfuPtpP/d0jhLe47F9ssrESIaEoUfC6TrXwH/1G5WaY4=
X-Google-Smtp-Source: AGHT+IFXK+pe4KdWXxKpJ1VWwSIYQUau5mXRPx7fYGC+9vgU1Sl6HheAYLJs8ocd9CzbesZ3zzbuPA==
X-Received: by 2002:adf:f84b:0:b0:37d:321e:ef0c with SMTP id ffacd0b85a97d-380813c9f8dmr181849f8f.11.1730133944115;
        Mon, 28 Oct 2024 09:45:44 -0700 (PDT)
Received: from localhost ([93.115.193.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b13223sm10002068f8f.1.2024.10.28.09.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 09:45:43 -0700 (PDT)
Date: Mon, 28 Oct 2024 16:45:43 +0000
From: Chris Down <chris@chrisdown.name>
To: Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Tony Lindgren <tony.lindgren@linux.intel.com>, kernel-team@fb.com
Subject: [PATCH v6 05/11] MAINTAINERS: Mark printk-basics.rst as owned by
 printk subsystem
Message-ID: <62e6a36052a1759e7d01669c5c760b6a1760a9c8.1730133890.git.chris@chrisdown.name>
References: <cover.1730133890.git.chris@chrisdown.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730133890.git.chris@chrisdown.name>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)

We are going to update this in the next patch, so while we're here, we
might as well mark it as owned by us.

Signed-off-by: Chris Down <chris@chrisdown.name>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 36490a1fc721..ea134675669e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18450,6 +18450,7 @@ R:	Sergey Senozhatsky <senozhatsky@chromium.org>
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git
 F:	Documentation/admin-guide/per-console-loglevel.rst
+F:	Documentation/core-api/printk-basics.rst
 F:	include/linux/printk.h
 F:	kernel/printk/
 
-- 
2.46.0


