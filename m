Return-Path: <linux-kernel+bounces-570195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDB1A6ADD4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D69DE481792
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD0522A1D4;
	Thu, 20 Mar 2025 18:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9D0WZog"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC51229B0B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496788; cv=none; b=tpxbIcS80ddl6uN3ipHe+3YIeQAPSl5ZBWtkb16ZFfqw1NYp6lmxDf0WnTNTl6FNxThrUw3isGLfje66wNuPDjoFXtR6YkvMIQLQZAjcx0JaOSDY36EOJJhStssuSX6B4ebkairNGCbZTduVEc5D0X3iTl7RnuNdQqgYZj2HBew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496788; c=relaxed/simple;
	bh=WoRYA2tpLgnZuGnp9hThjLb61379Aly6hCsea4BFktM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WZTYaLHQ1GIi8APGT8EP++gRGVa83r4hgl1sWM175fYdgGhbjNq8nufRcO/OygpSOa3+OJi07zboabxNe/pf5LrCMH59J49oMs/a/On7KtvcGhOU3exFMy83YgBBeDftjUaxg/3nkjIteaO0XbBrxR/hpbnFAkdfCIRntLdr6Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9D0WZog; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-85b3f92c866so15947839f.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742496786; x=1743101586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MlpyI1Cbu0G4E1iYQnKaYcyXlhpWchDiOL6/URF3toQ=;
        b=U9D0WZogDBnk3Nh9SQMZw4wOmHrjX7N3o8BWjlXxS2h6XlklRJehidGLQ9y7Kc2Dfo
         pKhOtxZpmY2Nq+y0ZVrQvoPSm8u1PNxIDFnxEH0065QpZVDC1XKqSNp7zO4TuZ18PA5+
         bUt+waBb07E5gSuSxH1x9CWOvIBbL5ZKDnFG8dDbeokX2wJw1OiSEYPFOggu+fitGlZV
         /71r1OuA2Ei4KPD36oQGWQSvR6JiG+n789JrR+fGxgcv6Pkpbsdsji4iTvrreMDncGDq
         sU+RHxAwuRNmKHuuWEkFbaj5Wr84oR+z+bHS52hZ1KrvYMxhp+fBa7PGG63ShRKu8yBg
         +TJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742496786; x=1743101586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MlpyI1Cbu0G4E1iYQnKaYcyXlhpWchDiOL6/URF3toQ=;
        b=PIkccIMyTfGINT/4406YmPl0DhUd2Uw8uIGr+TxUbiU4kJPlE5coEYvAlx7K+anZIE
         qXkSVRLVEdyxYUk6kXFk8dtPUNDquMFvMoCKJQqIWRGwXgJGA4StY3v9JqtjjraIbOzk
         ZC0g8JZqrwXgpGtKkHKLw4+yOziMUdUl7THf6AMKjYpWY4Qn3ivHIHq5IV8m6MS/ej8c
         M9NmqB49jFCuTkPBkesfasLJEEmnMZBXJsbpPBRN/p9GLmwty/1rmGFw/UQ6v6N+WtnR
         aZrFl2oVpt78YacDH3xcVF1fmRIeNg0gY8jcWSV1LP+5BWT4+ky92Xrn8nmP4S1YLOrY
         d/ng==
X-Gm-Message-State: AOJu0YwdP6ZH1WcTeX8/oogK+rdgZ61s3y2hgdXdqxsVT4iRYr7+O5Us
	SudXk6VpTLVHmX3FKA09XTmQqHLNY67HJnawkCSospKrxzYzojm/pJwYvaFF
X-Gm-Gg: ASbGncuZQlnq7hGiZWQC1/cGuhyBQdvBFDehz7P/gV0EL29bPgrQZiIsdI437YtPLK4
	MPKWPbnCYnlHCraQifnxg2hxbRxd3SCQcgb4t0ZUIFebVghhjKeltVBR6unopeXTWDFAn/MNG6V
	NI+l2NTfr6YDl8HyBACIMSSiZ7s1Ox0Gs5zmzPSnEnpwEiPu+eluogZjY5nrYhdNSZUUT9mupkr
	GnaPDRm41uS6vIopVP+ui/ZLRfN+2J0dFGXDXO4mEwqoJqShlpdrO10La+x7RYxq6HIzsUY4NVY
	PpTRBOxR9B1KlBHgF6elH/i4cZtWsTKs1u0Idt+2onul3dic+i25swG6WAakHRpkviDfefsyK+W
	Jaw==
X-Google-Smtp-Source: AGHT+IHZGJevvkMs4YxEUV0pCQu6gVQ//x6whWye34wVeeLCxKLW2X7NtRjdgFS2bgshHHbVSK2SGA==
X-Received: by 2002:a05:6602:c8b:b0:85b:4ad2:16ef with SMTP id ca18e2360f4ac-85e2cb0e8d8mr38905139f.9.1742496785621;
        Thu, 20 Mar 2025 11:53:05 -0700 (PDT)
Received: from gandalf.. (c-67-165-245-5.hsd1.co.comcast.net. [67.165.245.5])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-85e2bc273e7sm7078039f.17.2025.03.20.11.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:53:05 -0700 (PDT)
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
Subject: [PATCH v2 04/59] dyndbg: reword "class unknown," to "class:_UNKNOWN_"
Date: Thu, 20 Mar 2025 12:51:42 -0600
Message-ID: <20250320185238.447458-5-jim.cromie@gmail.com>
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

When a dyndbg classname is unknown to a kernel module (as before
previous patch), the callsite is un-addressable via >control queries.

The control-file displays this condition as "class unknown,"
currently.  That spelling is sub-optimal/too-generic, so change it to
"class:_UNKNOWN_" to loudly announce the erroneous situation, and to
make it uniquely greppable.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 5a007952f7f2..147540c57154 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1154,7 +1154,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 		if (class)
 			seq_printf(m, " class:%s", class);
 		else
-			seq_printf(m, " class unknown, _id:%d", dp->class_id);
+			seq_printf(m, " class:_UNKNOWN_ _id:%d", dp->class_id);
 	}
 	seq_putc(m, '\n');
 
-- 
2.49.0


