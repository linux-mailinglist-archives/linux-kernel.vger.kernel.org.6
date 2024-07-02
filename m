Return-Path: <linux-kernel+bounces-238428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A87F924AEB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C87D0B237D5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E08205E13;
	Tue,  2 Jul 2024 21:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWtHFDQJ"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0E421C163
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957507; cv=none; b=YPw/kZd4CSp0msBrzb74hCOBgNBO/c7XgKd9lbhqZv2J57tTCYQ0/E+PG9MIXvZuYSmm9F+ySdW83m2Qpk5WMi/0Tcym/t6NIEzsuCN3axIypK02AVh5mC18OY8ONFXC9dVCrNmL4hKa57z5X4WcKP6tWBJFD+oZCTIbDx8H3CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957507; c=relaxed/simple;
	bh=bu5iQ1cG044Jo0mJlX4LGPT0cAZfwuxc+xwuYO2ZPY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O7SscQ6t/pfmGKwBKAu7GH6NdToKvquemEvqUQ/umg9bF/ix168ofY1oJk7/MSl5DICsiJyIzzvYzuBMSDn/uEPDxQNvgXNDXDOPx+oEYH2HV5hZlN2nVyAS+yVpGhf0wEuxEYwaxZrKW4Mn4jcN6yFiFfngEuZRdLefnF1sbfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lWtHFDQJ; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7f3d37d6bfdso440839f.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957504; x=1720562304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wso+Oi2/ut2legKe2oAWbXK/ItRspmzOjB4tGo2hISg=;
        b=lWtHFDQJEAgwAs2dhQsDQmnX0CNM8DD/d0M2+R9uJ675gk7lo6Gh1u7b03q7anqQpF
         uA8ew+ouOZpWOzTZInC/Yiy3NCTmfhSyPJ3uA49Szj/9EKirjBD7NuD2PRDwaSPWuyGi
         rG8u+gNKNKciQzCmWPVeFi2PKP9qM9+yPHYZL0iD3R3R0Uoa6kvOVR160s2+rpu0m71l
         fuuxQYHsn27eMKDSTDt5uBn8PCr0bqehJuSB8w7DrUCHemymBF1mtQck6NpDAo2ybqqE
         sD6yW9J3O31djPDgSuRIebH5LI2T228uuYqk+eGDduQfN4YBjB8t9igwkzOR5JietM76
         mNJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957504; x=1720562304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wso+Oi2/ut2legKe2oAWbXK/ItRspmzOjB4tGo2hISg=;
        b=q7AF6VnkmXiZYVFeKrR0rGms/kOX49MPJ0EW7ipryJkp8uDwbxRkeRq7AXjj69hX6U
         gi695qSbJQyWarhq1It+4WvFiRN0yMbkAqyE5txgi9IyKwLfFedTh7VSt0Imlgc4eGb2
         YRtUlNO0lpTt+1JERJlec3W05Piwzls465GbUSs5T5Yq16cTozsgbaog18WRIx2+6QEi
         DvWoS10koSYsQoXPugcKlwSfQPEzIQyq1CSM0xz2e4mIk7HlOlGRXm+ynZIOv6l4xMvl
         OZTm1AcD1pbvr8eIvyl/qzDdmg/guj/SZhPgPwcmP/uTNMA4kw+bo26YLO2gwaAgwZBO
         XHfQ==
X-Gm-Message-State: AOJu0YwWmQszld+cCSl3c4BD/nRhuQ2FCn7/PrENybbL5JsbNCKNpeOJ
	+S56IAvcXXPupfA8uRWxsWF9em4VWRqgK6MrWv+WwsnpIRn3L1fH
X-Google-Smtp-Source: AGHT+IEjihZo5dhJ6MSq0XVTxwNq7IPZF6HNZIFL7WZIO/OulVmLPGqkTjVhpi6rvHnYoJxnqgO6CA==
X-Received: by 2002:a05:6602:54:b0:7f3:9e2c:fdfd with SMTP id ca18e2360f4ac-7f62ee9d6e6mr484501939f.8.1719957504092;
        Tue, 02 Jul 2024 14:58:24 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:58:23 -0700 (PDT)
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
Subject: [PATCH v9 08/52] dyndbg: drop NUM_TYPE_ARRAY
Date: Tue,  2 Jul 2024 15:56:58 -0600
Message-ID: <20240702215804.2201271-9-jim.cromie@gmail.com>
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

ARRAY_SIZE works here, since array decl is complete.

no functional change

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index b53217e4b711..8116d0a0d33a 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -106,11 +106,9 @@ struct ddebug_class_map {
 		.mod_name = KBUILD_MODNAME,				\
 		.base = _base,						\
 		.map_type = _maptype,					\
-		.length = NUM_TYPE_ARGS(char*, __VA_ARGS__),		\
+		.length = ARRAY_SIZE(_var##_classnames),		\
 		.class_names = _var##_classnames,			\
 	}
-#define NUM_TYPE_ARGS(eltype, ...)				\
-        (sizeof((eltype[]){__VA_ARGS__}) / sizeof(eltype))
 
 /* encapsulate linker provided built-in (or module) dyndbg data */
 struct _ddebug_info {
-- 
2.45.2


