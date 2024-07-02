Return-Path: <linux-kernel+bounces-238476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFD3924B38
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5AB61F24BBC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66104210189;
	Tue,  2 Jul 2024 21:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BiHcNwiV"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611C61CA2AB
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957555; cv=none; b=IKvUf58/qRsi2RO3hnJ18Xy7KGlecMgOQsgRqYKZUUUio4cZ4Y3yLxkTtqK4dwlv0TpCkc/t8RJOnFVtxvrRxolv9LLUjw+ziE2uXvfXWQUXjCnAIUyaBu17yfr9/YUC7EUPN6eziGHm3maFZkndyiDO3RoYAMKvzV7GsI9vW/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957555; c=relaxed/simple;
	bh=zmyLO65yPZ2P+sQ2d3HjTXHc3m95hCKtg7yLZG+YhsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JkGa5RcfkCEOSUgOUTKAV1MmOafGm/h0Pdxv7PDC6dJ4rGj++xKYRLhg2++06mUCDCQKkRnzS72qDBCmltxRY2U+rtr4mUtVlaz4HypAny5LzDqeIx1KG/bugq5eqpfWe0/MMIMgKzLDCn/+6lMvjQ7RlihpIr1JqULfs4V1ROI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BiHcNwiV; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7f3d884e70bso237627739f.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957553; x=1720562353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzxAaDu6jznCkYGTIESxKGj+agIaj+uEvHm/3W7k4f4=;
        b=BiHcNwiVT7EJy4BMvXDyHErX1SJJ8X1BSl/BhEzMuYvnoKsqESBlFYmHwDLH5/vK2O
         kb6uHDkW5Utzd+3LokRR5hUBQzrrslQKzEH+dUTUFGgTVSZ7lb5MBymVjkol51ddfNyq
         A9Iftedl+WTXZrhTduXpokKA4GU6mEKOTSv1pXmQrocQc8genAR8/bKaHT9BxsHiaIEo
         KvOLmu+m5OAZ24EG2upYrtUE9y145hci6MF9l1ToxNDkvgYKxLIvLOAqkh7xTuFi/6/T
         rmq1N3TlxoDpP24107FoLr6zjS/3cnq7XHoIzLT/nE+zx+0sMsXvo7ddcorqL7GwgJ0N
         5/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957553; x=1720562353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wzxAaDu6jznCkYGTIESxKGj+agIaj+uEvHm/3W7k4f4=;
        b=fw3PKX9pHmuZCzsod/3G6bBHv0yC3FWVAbfHdgOg+OS8NPkdyUBk63qbd7VVdnicmI
         A63mjxdBIcJKOfJLRNANVKKsXAT/s2IXg7n+P/+4lmos4N9pehrNbqo3VAbxJDZxXs7d
         sBXua0jzrs7jQhWR9r/oeDFTtmr6YpXcXY80ZpSJlv7TmMPQ6VY7gYpdJqowq/js3cl6
         XpmqmwGlCwnC5Tl/67VlgUE7eJ8sEX8s7VHy9rMh3RH3OfVuvVtD7THvr/3eKvreog72
         MQcZHHoGn87qcpWZIXEE9k8Dw+pZV0aoUAZHOckM09VOkcEy1EWT6GL38Y95qSfjgYSj
         QB7g==
X-Gm-Message-State: AOJu0Yy02+ACb0QhqxbnuxO0uQgrqKQQeS1OB6bFqJXHi1Z7rc3xK1w7
	Oma2+DsWYp1VATh55vHC3GoiwipjpYQ4SSrzvMR97IMOlNgh44tmzR8iHA==
X-Google-Smtp-Source: AGHT+IF2IV262mxUL5Fv2D4fSAIWDRHFT00nSwPai7dQls4045AmbHQ4mcu0vY1Ry054DisDUO53kA==
X-Received: by 2002:a5d:954e:0:b0:7f3:c683:2257 with SMTP id ca18e2360f4ac-7f62ee79dacmr1311983139f.19.1719957553542;
        Tue, 02 Jul 2024 14:59:13 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:59:13 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	ukaszb@chromium.org
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	linux@rasmusvillemoes.dk,
	joe@perches.com,
	mcgrof@kernel.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v9 41/53] drm-dyndbg: add DRM_CLASSMAP_USE to simpledrm
Date: Tue,  2 Jul 2024 15:57:41 -0600
Message-ID: <20240702215804.2201271-52-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702215804.2201271-1-jim.cromie@gmail.com>
References: <20240702215804.2201271-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tiny/simpledrm has 3 DRM_UT_DRIVER debugs, make them controllable when
CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg that the module has
class'd debugs.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/tiny/simpledrm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/tiny/simpledrm.c b/drivers/gpu/drm/tiny/simpledrm.c
index 7ce1c4617675..9cab48bd0581 100644
--- a/drivers/gpu/drm/tiny/simpledrm.c
+++ b/drivers/gpu/drm/tiny/simpledrm.c
@@ -33,6 +33,8 @@
 #define DRIVER_MAJOR	1
 #define DRIVER_MINOR	0
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 /*
  * Helpers for simplefb
  */
-- 
2.45.2


