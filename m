Return-Path: <linux-kernel+bounces-570223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B03BBA6ADEB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0DA97AE518
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F8E233149;
	Thu, 20 Mar 2025 18:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZvMbLg8d"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158E5231A42;
	Thu, 20 Mar 2025 18:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496822; cv=none; b=qKXsiBqEMQtq5XhDF/SNHEYzoOn5MvVRhZOQGieTWZZhrPdxpWc/qt2aittcNVUPMynqWDTQ8G57y5MwJH3qwumqsVZ4UJ6fLjv3uL1Im9ShRIegGMFI/Wxko9K/mew3SHfbpVkJ82v66802wnDw/exVgOZuaIryM7zs5jBwiTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496822; c=relaxed/simple;
	bh=jreOkTAnalclva5phDVYbmGUMVQIlw7AM8+PxERHahs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OPNvD7Cf21FoAKNGxwmbwY8hbvF+wBC93qOzKq0SGThtef7NdPZI+mczbfxJ5IxEZ2Gg2qi0zPwjUALMeGIo0OnbkoY6uXIdghbblB6vISUU5joGv81YZB4F5QuxD8+4VNh9uyKOyhvL2KShrZYhLAuTjhCaD09bhXRqXEuIvAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZvMbLg8d; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-85da5a3667bso37832039f.1;
        Thu, 20 Mar 2025 11:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742496820; x=1743101620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+JojmC+9FxP2Ro0EyDJ7vhOxZoHEZd1XTtPdoBZyU2s=;
        b=ZvMbLg8dB5GiO6R0W2UbMdt/7OUN6+V7EEOLoSDjf6o0tPDR8Mp/IaY/7ryDDRIc1z
         XyBfWsg6bmaKZ4KtGm2X9XEX+UVVdSPAH/hBuyjMyc9BWHoz0JyDTfqtIDum/8wKVCKS
         WHmNMnZ8HeCId/BbVGxtuB/fQQbvWdCQThhrYdm63FdR5sXKc3yKaFJ6q5ZQBlHlXhqU
         wzZDoE4mUjnnGcyWssvq5anogO2lhFtpu51G2+vGmLEUNwQFOidF0p5rXmyoRJP3Zh4v
         l1LmAw4s+nXktKWnB1R8cgy54MMa8UBPjLJ21oBaBYUa7zueJsMslmmJjLiJK6GVY6WU
         wsUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742496820; x=1743101620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+JojmC+9FxP2Ro0EyDJ7vhOxZoHEZd1XTtPdoBZyU2s=;
        b=ssyrNAY2CW3252Tl+Ov7ylDOAUhIBxi+zZfUwoMtbpoFTcj7Ue/rqaczYVb7xlU0HL
         0QThhgomJMaktgC7twx0w6SSxid72HvBNtAPy0fD6TdvcrnENL830hbKg8acBmQbJs1p
         9ZGka23wTvFy3w/qipllpWaEOwN2DqqbA4QaQD67uFrPMt3d69O8WtOTObSw+hhiKU+I
         kzlol+D14vWXlnIoCHdcv+wkMRz/fV7rv2i+gmyqAZ7h3NFRd+Vv7BYT4wBQZLk0CrVY
         vU2Q3IT9K/0EXZPuaDNQejiZgoQe90FfBK0gDp6jN0EQQqsMSYOGwjN9ILZWbP/Ciab0
         yYig==
X-Forwarded-Encrypted: i=1; AJvYcCV/r7XEXq0p+kzXpf7x6dgzL2Cs+5NyO/5m8z+cP6iWkGNBc/TCYYTni+0HortJsM6x17gQ7CAVHxY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj4bj90G/gUcOrowaskTL0HWUyHsEe2JQ0wsALBI0n/NEn67Se
	BlDz5thCPnVmfz6dezBJxv2FfGVUJ/V5ZOixnZNOqjk7BmQDXY4ZFC9XKs2+
X-Gm-Gg: ASbGnctDoUaqaUAiGQ5sFfATT9fwwEx47Sp3Og1qY09gN8OEhrT9juaHHKZA3H4gJC4
	JLZo+Ev6QbJCLr1gj9pQ9XoIUa/XWi/M142ZbvbNFEv+wtCM6Z59qfJQzXZeWas1PTxYc5Np3zw
	/u4CNCK9k9yVVwAFAJi10ReCVXNfGzSseEBETmz0SplO+pN9ffP5vQEUyd9IAda7lp+SrXi8Q5n
	2wXwenBJ3TCNcVFGDOwy2DYK+CWZfZGkZzvAQj0tKS8z2S5MjsX5uU/uztgnWAxwTOFzVhsdIlP
	F4kmEg0tj9c12cUKcSp+C0/nzgvzNz9TadizADsh6APh+zAxD7dFimmCktf9WSsflhICCxTaR0i
	9NfCSry1TsKnR
X-Google-Smtp-Source: AGHT+IG04lf95fJO+S+3AZcgEaNcIF03DKuyxl+Fgiex9RLp35StpaNvWFb8uwJT3IqqzXUNqAF8Fw==
X-Received: by 2002:a05:6602:398c:b0:85b:4ad1:70e with SMTP id ca18e2360f4ac-85e2ca8a7acmr52986639f.6.1742496820040;
        Thu, 20 Mar 2025 11:53:40 -0700 (PDT)
Received: from gandalf.. (c-67-165-245-5.hsd1.co.comcast.net. [67.165.245.5])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-85e2bc273e7sm7078039f.17.2025.03.20.11.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:53:39 -0700 (PDT)
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
	Jim Cromie <jim.cromie@gmail.com>,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 32/59] docs/dyndbg: explain flags parse 1st
Date: Thu, 20 Mar 2025 12:52:10 -0600
Message-ID: <20250320185238.447458-33-jim.cromie@gmail.com>
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

When writing queries to >control, flags are parsed 1st, since they are
the only required field, and they require specific compositions.  So
if the flags draw an error (on those specifics), then keyword errors
aren't reported.  This can be mildly confusing/annoying, so explain it
instead.

cc: linux-doc@vger.kernel.org
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 Documentation/admin-guide/dynamic-debug-howto.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 8e2083605bd7..d2928884c92b 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -112,6 +112,16 @@ The match-spec's select *prdbgs* from the catalog, upon which to apply
 the flags-spec, all constraints are ANDed together.  An absent keyword
 is the same as keyword "*".
 
+Note: because the match-spec can be empty, the flags are checked 1st,
+then the pairs of keyword values.  Flag errs will hide keyword errs:
+
+  bash-5.2# ddcmd mod bar +foo
+  dyndbg: read 13 bytes from userspace
+  dyndbg: query 0: "mod bar +foo" mod:*
+  dyndbg: unknown flag 'o'
+  dyndbg: flags parse failed
+  dyndbg: processed 1 queries, with 0 matches, 1 errs
+
 A match specification is a keyword, which selects the attribute of
 the callsite to be compared, and a value to compare against.  Possible
 keywords are:::
-- 
2.49.0


