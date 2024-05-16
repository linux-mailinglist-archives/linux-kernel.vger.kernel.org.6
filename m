Return-Path: <linux-kernel+bounces-181383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B18BE8C7B7A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 19:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E33391C20CD3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCD2156F45;
	Thu, 16 May 2024 17:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNyd3/YA"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CE8156F26
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 17:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715881453; cv=none; b=hJsR/5G1EBGMM4ST/xmcsduiLSFuZPMTAQjqSybbycyfW7GqH3VJvh/v4IGCZBNJHXKj3jTlsKsCBDuvrIjb/k5Th98huutpeETQFVO6cfrUC8GK7KtTa0EkZCfS7RQ/cXyrG+JMfAYWyxcJ76alCFbgp5wldmBOcsQTLJkE5Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715881453; c=relaxed/simple;
	bh=PRtI3uGezhrYV9s9WiYgJnFl7QwWMmeEdWT7WD3z0BE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OWtQtyAvtYX+rZX35wUfPbepLSK9LbjQyMGwUvv/Cz9Np68OcQR5UcYWWrD6VNRcLgJuQanyVR7Pvh7esX1veWrfZ5dWKJKF8R90nlmhbRgK8jCDA5x2LLlelUPZX1YHNGaSrk9xOUE1rOiDy3ywOqtjwbvm6DuSqzVeYh8X5Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNyd3/YA; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7e1b547cf45so70128639f.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 10:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715881451; x=1716486251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sd7QmDozimr8RZwLQJ2vCKHFTMMILyamLzpg7/VsK8E=;
        b=PNyd3/YATlEWTIg4kw6tZ1YMnrUQOjPT51jcwFO6wFp4831ZRjx9SJ2hNmc1XwZ09X
         YSguopQFba+XwFf61TTW/mxJyyZxfkeycPmCeoQ/Nl8K1L7bYRr1t7WmjY246eI4i5TA
         45caTuoGERPzRkCTWT3k35DWFUsQWRw49sIeLYNJE6D8eIUiQKfRZO0SXWiiDhrhFtzo
         E0uQOtzEKyfoN1SdrmvnjMAYQpJR7NK2//9sYsbvs4xdcdE1w8GMoqBOrjw8KsCuy0Mb
         wRlQDGS9VFhdJlWV37fMAXg/yL6wyjcnuxtvDwBXimSYLmLIi+tT9qZGf2vgKG8u3fhq
         uYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715881451; x=1716486251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sd7QmDozimr8RZwLQJ2vCKHFTMMILyamLzpg7/VsK8E=;
        b=KlbrZZdHmhwyKeGKxIDBjJFfD17HeJoAm9ANUOqbr+eB+0cVacpLVx3WwAOpuCP30W
         eeHY46uRIbb3jCG2dpjubXNyUGv7w3nX7d6sAP5KIE2rDdOKAWaiAZMn0+3JZ/nyMDP6
         P8GM89dDGAwBz7qGRHsCe6viIfaKAb7UX5VesDWi4IFzfmTOtySRWMUqkZVOf9nPem65
         q7MNB2QkvtOEEyLjDknswlMbfNjRf1r6+7qKjSsy4BFqPsbjaDr7Bng2mvgy/GpWckJ4
         WdjaeVtM5hSffc/HVB0TLwwVSXJlEPDTuXrRDJv0L9OcPt6UXVinM1rzTzh++AQOa7xI
         ShPA==
X-Forwarded-Encrypted: i=1; AJvYcCV/hTzZFDavtC+auPa8Qb32UcNZKILrhujDy/Y6s3oa0WCxzyPKtkEnbVcZ/MsIEf65tdWBj9rEjYrKy5144C6twq4BxWsjC9ycSShT
X-Gm-Message-State: AOJu0Yz+FvLveO1QZotZ8iUwDbM8Q1mlNkRv9UNdwdpq5TIwH+ANAqwg
	E9DqJhGpWPZ+I3vgeibYWD38/oq+KXXsTMFblYiCmyDUyX2S7q1h
X-Google-Smtp-Source: AGHT+IHAUaygKtHrQqYy/60d3WIbEspDA/Q7I3eKfqRRXXKohhEp0d0DUBm6o3mOEQOFq8wGlv7kDg==
X-Received: by 2002:a92:870b:0:b0:36d:bddc:2fb3 with SMTP id e9e14a558f8ab-36dbddc3217mr27213995ab.7.1715881451314;
        Thu, 16 May 2024 10:44:11 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4893715057csm4273595173.80.2024.05.16.10.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 10:44:10 -0700 (PDT)
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
Subject: [PATCH v8-RESEND 02/33] test-dyndbg: fixup CLASSMAP usage error
Date: Thu, 16 May 2024 11:43:26 -0600
Message-ID: <20240516174357.26755-3-jim.cromie@gmail.com>
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

A more careful reading of logging output from test_dynamic_debug.ko
reveals:

lib/test_dynamic_debug.c:103 [test_dynamic_debug]do_cats =pmf "doing categories\n"
lib/test_dynamic_debug.c:105 [test_dynamic_debug]do_cats =p "LOW msg\n" class:MID
lib/test_dynamic_debug.c:106 [test_dynamic_debug]do_cats =p "MID msg\n" class:HI
lib/test_dynamic_debug.c:107 [test_dynamic_debug]do_cats =_ "HI msg\n" class unknown, _id:13

107 says: HI is unknown, 105,106 have LOW/MID and MID/HI skew.

The enum's 1st val (explicitly initialized) was wrong; it must be
_base, not _base+1 (a DECLARE_DYNDBG_CLASSMAP param).  So the last
enumeration exceeded the range of mapped class-id's, which triggered
the "class unknown" report.  I coded in an error, intending to verify
err detection, then forgot, and missed that it was there.

So this patch fixes a bad usage of DECLARE_DYNDBG_CLASSMAP(), showing
that it is too error-prone.  As noted in test-mod comments:

 * Using the CLASSMAP api:
 * - classmaps must have corresponding enum
 * - enum symbols must match/correlate with class-name strings in the map.
 * - base must equal enum's 1st value
 * - multiple maps must set their base to share the 0-62 class_id space !!

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/test_dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index 8dd250ad022b..a01f0193a419 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -75,7 +75,7 @@ DD_SYS_WRAP(disjoint_bits, p);
 DD_SYS_WRAP(disjoint_bits, T);
 
 /* symbolic input, independent bits */
-enum cat_disjoint_names { LOW = 11, MID, HI };
+enum cat_disjoint_names { LOW = 10, MID, HI };
 DECLARE_DYNDBG_CLASSMAP(map_disjoint_names, DD_CLASS_TYPE_DISJOINT_NAMES, 10,
 			"LOW", "MID", "HI");
 DD_SYS_WRAP(disjoint_names, p);
-- 
2.45.0


