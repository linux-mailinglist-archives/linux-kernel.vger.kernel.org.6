Return-Path: <linux-kernel+bounces-254258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 364D19330E5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58C701C22D19
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 18:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF241A0AEE;
	Tue, 16 Jul 2024 18:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lyly81JK"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E39D1A0734;
	Tue, 16 Jul 2024 18:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156306; cv=none; b=EVeZbnnNC3sY2O3x198FJz3OvQ2v5gTaWPwdR6AjSvBHeobhff6JGxUtsXo41doH5iAym1A3LFFiNQd/LflqvtkKYMZkjo+DN94t/IukEB077B0MLoJcSyH8Pr/TkurHHjICZ6vsKY1ymSD13xMVlFbotrZ4byqKphGcVMZtbGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156306; c=relaxed/simple;
	bh=2ejEZTfMnNkbjfcLpxvVrkW4M7/Fnzq1fAoZZKhXQWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GPLGiaTSMZEzpCd+nNzM7Fg2kgGIrNeCygR4KTUjkGyRVd8P8ihOPMNrEDclT7Ie80OuIWvADvMrupbzE+lOLhP8zmevd4PFtHrm396ahoEfkdvzSK6aEQ4FZPQWKk9Eg2DlqJTPRbvmyWlEZ4lBSTsUrht0gQp88PJUom/gHdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lyly81JK; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7fedb09357aso5194139f.2;
        Tue, 16 Jul 2024 11:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721156304; x=1721761104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=al8xZ+YlvhlhYR2QqHaR49xBruYIKMULtZOXYmr91IY=;
        b=Lyly81JK+fcjQCoovYDJWZd7KMbdadQxPWHfbrY1mbkxtWTMgUdvmx1gS6h9osD7g4
         ktk7NTzNF5t2YSOwefsyrF/tk6EU9vblGn4UfhKVqGm1O8358+fetoZHluChSsd70BeS
         ZG1YouTrUSHD+2pjvb3ws4AYD+697hxcJs4RnLnodnE5ZHqgCFmMIvBpxOzkpT1YiOir
         LuInEQaSX/BpdTakVoZ793O45EcKiW9iJHEZFm5In7N1FSZq4RJATm3NAbE0z4cSNw7G
         lUGFa7elND8Q1BTwpxEPC4dy1M6OmJzYmFE50qSCR3yf0CxbG5DhOciU1u0W7EktaFW1
         qHmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721156304; x=1721761104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=al8xZ+YlvhlhYR2QqHaR49xBruYIKMULtZOXYmr91IY=;
        b=pUjRyYXM5RiVqvq0T6x2VFhx6qbaXCwo3RSMsYT2pcOZ8GsgoXodDHP2oyh9YG+LNV
         k/BUxHdJgCqJ5EJXKakUwQLGCIGyrgq9eW4+FiATLoKwRFf0P++b+tb+nbNT3K8pYZAT
         gv2bDN14GDcqPadCJgDO2qn+NdPv5ZtI2im2SC560lmRWasCB+e5z8QfUSrto7091gUb
         FRELJrEjbWm4uwAYzFG+Ws8ESJ//lIqN90kqquMVQW7XzEQCvMhxMBE29P2buC0SxEDK
         Ki3LL6IxdUNZYN/5s9hsRRdiDrBpLJReu1etiOMK8WloBbTKg/FSEsvBHX91Jela5ysp
         lkFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVp4/qPji44keNWjjj7FWJmULMK/Cc+Fj/aIhb5KG4W6MKiH/KZUvoWYzpXdeMIgPUrtyTQ6R4rMXP/7A8qC99t6lShnN9dHk8p
X-Gm-Message-State: AOJu0YykqFELLvPb4aN2QdKjIA2sFSOPZ5agw+x0d2nOa5C4vtSzrpav
	07PO91km4dQ6NG5fYQ1NIo55KNLBTyHo2//PQ2AM5NXxxTQsQSJ1oMRF02cX
X-Google-Smtp-Source: AGHT+IEHXZgya8fxlhk9i3WpXa3f6xKgjLFbnVvzZUw1PQJh5tx0JX3MrDcdRp4L7TxET69MO77yeg==
X-Received: by 2002:a05:6602:3fc7:b0:7f9:bef6:2068 with SMTP id ca18e2360f4ac-816c35dac54mr41417039f.10.1721156303915;
        Tue, 16 Jul 2024 11:58:23 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4c210f23f1csm75301173.102.2024.07.16.11.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:58:23 -0700 (PDT)
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
Subject: [PATCH v9-resend 04/54] dyndbg: make ddebug_class_param union members same size
Date: Tue, 16 Jul 2024 12:57:16 -0600
Message-ID: <20240716185806.1572048-5-jim.cromie@gmail.com>
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

struct ddebug_class_param keeps a ref to the state-storage of the
param; make both class-types use the same unsigned long storage type.

ISTM this is simpler and safer; it avoids an irrelevant difference,
and if 2 users somehow get class-type mixed up (or refer to the wrong
union member), at least they will both see the same value.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 2 +-
 lib/dynamic_debug.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index ff44ec346162..b9afc7731b7c 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -124,7 +124,7 @@ struct _ddebug_info {
 struct ddebug_class_param {
 	union {
 		unsigned long *bits;
-		unsigned int *lvl;
+		unsigned long *lvl;
 	};
 	char flags[8];
 	const struct ddebug_class_map *map;
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 73ccf947d4aa..152b04c05981 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -799,7 +799,7 @@ int param_get_dyndbg_classes(char *buffer, const struct kernel_param *kp)
 
 	case DD_CLASS_TYPE_LEVEL_NAMES:
 	case DD_CLASS_TYPE_LEVEL_NUM:
-		return scnprintf(buffer, PAGE_SIZE, "%d\n", *dcp->lvl);
+		return scnprintf(buffer, PAGE_SIZE, "%ld\n", *dcp->lvl);
 	default:
 		return -1;
 	}
-- 
2.45.2


