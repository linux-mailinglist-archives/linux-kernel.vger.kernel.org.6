Return-Path: <linux-kernel+bounces-570196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F348AA6ADD5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFD974A002E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD5422A4E3;
	Thu, 20 Mar 2025 18:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkUVkpBT"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B99229B27
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496789; cv=none; b=FZWZ2Ryc3xZHSnAuKYTd4g4FRqJabeucZoyTUS0jxhw37UExo2x/wrlAz3uKYia/NIWGBW4MC6wLWmn4GzbPLsvSqE+3l2+YY2y2Qbo2ii+8GKnvbO1tq2EWSTPX3Ex9xsEeZD6tvFcu2b3pfwUjvANJLkueN9KPYk8Lxg5aQZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496789; c=relaxed/simple;
	bh=owZYpNR2pwuDCcONhl7AIBARkXlaRrZAKNrUgbc8WNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NWChzT8nirIIGoSNirOzPEBB9zx0jnPEsBubSXDUX0HFS7o6xgWqy4MZcMIpxqcjREdeuBiRWVds/Ym12OUmLfL2qYmKkZSHq9bg21si9Vrh4h/dEKdIdpyKIjFp0LnKhONfwzyNyzeB3cqrReKm0BkXhLK3uhZh2A7BsfPb9v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KkUVkpBT; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-851c4ee2a37so75091939f.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742496787; x=1743101587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F1MDFYF/EJ2a7UGqvWTU6dzs01F9Q8UeZTgbtP6X+58=;
        b=KkUVkpBT8Pf2H6x3P9iaRIbXsaBVTjU9bGlKEmsaZl28Rp0p1HzDoZIYr3FA+32AdW
         ZJvzDCufmWCzY4cWv06rQicjl/82/UEtsdig/T0h2s6OWnoEfis503+qzvmBvvU5ES1K
         MLs1OEUeOrhq9QnOvn5WJMvQv2D5c5TNm8Ecb7nnC6rT62e2IqYxBWMfzaIeLT9iPA/Y
         eBdDEvwzYpb/GJV3bveJT0F51py8R/DhqUwUzX5YTZ0OBa+B7LfNleeuoLM8eRYluU3F
         Vhi1nPwMLzYrnhvt0KFXbxC8LiSTrIutuwMxnKjIDuECgIHglLEzzqAPzxRhzQ5JL6h0
         uMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742496787; x=1743101587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F1MDFYF/EJ2a7UGqvWTU6dzs01F9Q8UeZTgbtP6X+58=;
        b=HMJlWMp6ftpmDFYxyVcGh2asGmL44KtXL4Fqn5qzB5ekkraH9Zec/bN8/gkoFtzJZn
         i5XNjrSX1V8PSmT1aZ71YGwm6Qh9HEuAU+DS8ReypUdvIBv7ROeeZl/Qrr2OIWzcjMsr
         e72KfXwkXzObzUUR+4w7c5bHS4dhX1ZVdhYcLQsWq50JcTk+kQz8J8/Z/UX8U4cZP4/4
         40RACAv5POH+roIV/RL/muNlNjkAEXXG4iz0y4X2Oe+a/2TkUn005o2icMx8N4WsaNmf
         PthbQ4yjRzF1LWqz5KwT80HIxbhJRqgZZKagdgD+UHYK1FUsaAn5pvDz7OT//5i7BXW2
         Wisg==
X-Gm-Message-State: AOJu0Yw6mP+2jzIY9mRvwyG1YXx01fqFE1qsxSv5zl/9y/M0cSlc3hQO
	FxgAgBpbz7bAux4Ko/uT+3prxtQThRbc41eBujnXIivLNnRW+TA3ZatmjOD+
X-Gm-Gg: ASbGncuPVfFNM37Kk62zCUHXxm/yqcxRW7g2PJ+xqEWfqRa044KorzSCXeedTYk2AJS
	NVEH7ex8IUxcQLmfiLoNdH397DrUkeaCaf2D1r/j36CkPcGjK2MNkhl3qwtAzoNnmzrXB9ANv8U
	2uj5C/fHY2PfPuk2mXj0bj/mafPjXc/jJdVN7SYKjaOYSLbIYSys86EhJxr3UlW35qCJ9C7ilqI
	KduclxxIq25/P8FWv4sE92VRdPuTpOyvcodBdXRlH83sBdDCblyI8eMouY9mHySmY/iXmgeR9YO
	H8ogfR+IfLWL/PY3WW/SdglB7h1dLxV+aEPx4Kg2U1Hip48+dGb6ZB2vAXsgygxq3KrLgI4Tsl8
	O8A==
X-Google-Smtp-Source: AGHT+IH6p6JbwuEedC2NHEExWYxKZwpUK/wnyzikTQHE9duUTCvqa379yLREiYl5a1vshzn3H//0+w==
X-Received: by 2002:a05:6602:750f:b0:85a:efae:2f15 with SMTP id ca18e2360f4ac-85e2ca305e5mr45152739f.1.1742496786850;
        Thu, 20 Mar 2025 11:53:06 -0700 (PDT)
Received: from gandalf.. (c-67-165-245-5.hsd1.co.comcast.net. [67.165.245.5])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-85e2bc273e7sm7078039f.17.2025.03.20.11.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:53:06 -0700 (PDT)
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
Subject: [PATCH v2 05/59] dyndbg: make ddebug_class_param union members same size
Date: Thu, 20 Mar 2025 12:51:43 -0600
Message-ID: <20250320185238.447458-6-jim.cromie@gmail.com>
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

struct ddebug_class_param keeps a ref to the state-storage of the
param; make both class-types use the same unsigned long storage type.

ISTM this is simpler and safer; it avoids an irrelevant difference,
and if 2 users somehow get class-type mixed up (or refer to the wrong
union member), at least they will both see the same value.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
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
index 147540c57154..55df35df093b 100644
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
2.49.0


