Return-Path: <linux-kernel+bounces-570197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDAC0A6ADC8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDDC7188BF73
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3E622A7E0;
	Thu, 20 Mar 2025 18:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+aEEK6N"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181021EC006
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496790; cv=none; b=YjqGaaObyzoh/EL1kDWb6urArT6zXtqoFnzTlp3JMQKrBeDjnEkddm6QlRUNmu23Ba9iI0OivUtxBhJpj52z0uKjut0rsXGaHc1Xa/3W9cLfT2vfRtcD6Ej1xTL3D9XSj4wmqiNC68qOrAmizILltHgMFvSZCJN6H23AzBCimBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496790; c=relaxed/simple;
	bh=gFCzRxNPecs9k7iS1AinJ3zcerrYQfViU7GYvlDAdnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cD4HvsTJamxQ1NJbpoz4Ib35jXjoysQuQdfjkiiy8ZN5wEYbFkIvxBDNP0gN8O3/5QOcxtqyDWO7lfJ6HSf195j7m1SUFlJqZ5z9F/7pEKsVQPiGkuXqLZ0BuFOPf4uLxBob7nnIn3ovqeZwBOrBDHe8ayHqjWxxuHwAvfQftX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+aEEK6N; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-85dac9728cdso28587339f.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742496788; x=1743101588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+AN9v4KQ0PiEc7jM3vE8QrHxAiVUi2zmd1sx7ARoRMg=;
        b=Z+aEEK6Ne4R/3JH8khhcIktUPAX2AmDhh+f6OZ+NvEvgEauUCuSigGMdVwWkLhrr6W
         scZAzlbgW8iHRjnN0vZrbTVWIjMeQVRiNvvEDigy1w80rTALDnrNvMuCcsnPZWSXijwa
         l/eLMDHs0zCgsqaD85+O+GwSpf6DamXNofVtcddvgl/ObKV2WElxvfXlXDazJ0dIDVR/
         D9UwNKl7CBvwNx0sA0hvk7vDVEAeouncHITCv0sxTqTLuS5ztZ7jEssD0VtroiaoYK86
         eYcLs8raPDr02AWWWKFrPnC0oGt6VLWBLQd+dYCWiEFXm+A6JkksJX6Dlrir7G25Aqg1
         +T7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742496788; x=1743101588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+AN9v4KQ0PiEc7jM3vE8QrHxAiVUi2zmd1sx7ARoRMg=;
        b=HBffQjiiAEbU5qYVARMRw/S8svxzuy7ZnTnxFsmOGVt7EJYNQyyHtPwItAOnue5RRA
         N3BouK54rejjN8ST5+jV2b1ryLZsQpWytb+MqXchAQhTqj4oiuvZhi+vZMJDY9anllRJ
         1B9NrrtlfkXBl7+jzzkB/aLjj33z5WDanQu+HSZrSINpfioiYmLhcALcMIXP57GZMdZ9
         BxSBBaMyWUCKRwR/NW66z2jmzUSyz/K/d8DYAhjEkgROxXCTQtk2KZOA9LC+VM/rrDrz
         MMV/E0ON1FX3Rv9iqG5I7/7wDCbsmi6v2+5PVmfxGzPfGwiY7a667jGJOZTw4iOnwOvD
         O/ag==
X-Gm-Message-State: AOJu0Yw7yWa6bFWPR04yWkfKqlUjaqadI8Gli4oKZX7dndXqZ1rxKrLf
	TIPMfWlotUIdn8hTSVRd073U5NyWYrHTXQaQ/yPKYf7yXasoFrvxHMCLj2pD
X-Gm-Gg: ASbGnct9dkySU8/MN4JiIjfOquTrHh0A7MjUnkx2RIUdF1bQjpne/FiwBsAriLwTldG
	9xzksdedo/l0FWtMUf7b2cdYLP9JYc4Qu+BBzuwFxz0/PoY1f4iAkCt+uojVVMUOsOfQ5S+R3aS
	UtIBMiSqrP5nk5zJRHTIJW5BGRArW+4W5I/PVkzPg1zfYUBhsJgnbqmE4FoOMyy3OKYgwjLx9Wf
	QwdlucKASnDztthlPF79lGj7t58DVtxAxaCQM+4xxIwdpSoQe0K0E5u2N0k2DJ+gTPPhkVo2FLs
	uW6HjDFlT+/gl4NjJsKv1NhHmL7v2Njc76LC07OHe9MhL5e3OV84qZ5qrq23jBG4iENdu0T+LRy
	50g==
X-Google-Smtp-Source: AGHT+IFbrrpvBNEPH58XZa57qwfTNPaqQ6djTba1ednjlTTFGKunOgWQUFpBMAPJ96poTWt2fyLc8w==
X-Received: by 2002:a05:6602:298a:b0:85c:c7f9:9a0a with SMTP id ca18e2360f4ac-85e2ca6f4e4mr41062239f.4.1742496787996;
        Thu, 20 Mar 2025 11:53:07 -0700 (PDT)
Received: from gandalf.. (c-67-165-245-5.hsd1.co.comcast.net. [67.165.245.5])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-85e2bc273e7sm7078039f.17.2025.03.20.11.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:53:07 -0700 (PDT)
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
Subject: [PATCH v2 06/59] dyndbg: drop NUM_TYPE_ARRAY
Date: Thu, 20 Mar 2025 12:51:44 -0600
Message-ID: <20250320185238.447458-7-jim.cromie@gmail.com>
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

ARRAY_SIZE works here, since array decl is complete.

no functional change

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 include/linux/dynamic_debug.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index b9afc7731b7c..ac199293d203 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -107,11 +107,9 @@ struct ddebug_class_map {
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
2.49.0


