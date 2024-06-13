Return-Path: <linux-kernel+bounces-213644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E49FF907843
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 18:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEAC61C2420D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 16:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794BE12D757;
	Thu, 13 Jun 2024 16:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcPvUC5W"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4401428EF
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 16:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718296004; cv=none; b=cbyDZ1PxiQL9aQw4v+oPlgmALrjxMhxMZ1r7cSNv8/4lJkZuEJ18ukHfCswnjYZ5DlJg1ITGZEFPavj/88eIC34Cxfig9fo6RZRXR8F5Rq0J6o21lD4s9e5F+4tfgfqLlz+ExOzkMyaLriJvDOrJuQJl43NH3xg+eZxbx5yH/mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718296004; c=relaxed/simple;
	bh=SLAMqQrPfN9uJV7ziyrWbCdtmQk1fwT2/ftGRh6ehlo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KTSkIwTyhAwQgchEsbjNhBG6bcqef+2mi4SBUvNaqmS9JYNSFQVFaVgfFnsww9tw5FOcHtXyhljGIfwSoa7IRYcNMm6lEIwir/jDGNmf+yo3VITYQ0rzyXVkT3ZqHQrDEwQFBM8ZqhW3NYT8BhtK4R5CUVCtokT6HbQmytrpb1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fcPvUC5W; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f44b45d6abso10122735ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 09:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718296003; x=1718900803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jpfupifUWRjEWXSRFkPnEzWD919BOKz8LYHjIiDIHpU=;
        b=fcPvUC5WjcTtw1jH6MyT1t1XJHvuPP7BA5WP71fZ1iyq81OysjFD2NxOXkUMp2llXp
         JVglwGatpItzDA+GNv6pEycEH9nC9b0CpUNeXT/hCy1wwnF/zqrT5cKk/cRgZ2ffynXu
         sT2QIqv9yjHx2/1vEqAViuj5zw40hpfb7/gdhC7x+7T9tsmtUOucxMa5oo2CIpoPNyoP
         OMf3F2/0kKEDcsrVjob+ULdC+bcE3YP+K3bYkYNYf29ldlm6dYprbTI4pWL09+dvi/uf
         h+wl9scXvqxOE0kwoDdrY41yn6mFntvaXVwgYkF+Sv+ix6hNjrt+Jx5IwDO9LtIwPcDV
         ADjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718296003; x=1718900803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jpfupifUWRjEWXSRFkPnEzWD919BOKz8LYHjIiDIHpU=;
        b=Ed+u0TM/Voczw7wmLBUC0aNcNuRHSJcnTOuGNVzzN8pqYUuEfoDqJ5AhfhOx0ab2dc
         Y9mg6k+zZS/Gp2Xxa0TFDEGxmoqCQantM6Z6GcMebFoexX+s6mhg0vA/CSMthWI4+NhR
         dBPNx3dPKrszeqBAUOUpYIcd6zMIZjB8E8gePQmIfNHvB0XRXTIbarHx9IbqGTm2tYQp
         fjJ7r2ZJiR3bOd9DW8ndNOIBvcSj2lhA11tzb6u/CkNMo+Zc4Gq5oue9gYJeglMTYSmL
         McDRGnTvHnCYYyj2/yaQDVUWddUbXDJP4COC3khpge1tuQix4+UwDiulOwM7oblpZSDl
         eL5g==
X-Forwarded-Encrypted: i=1; AJvYcCWAA8Ul4ZEpa59vlMbGqEokdiv0pGB6scQPYOiQatTd09oWBt0aXPBA2lbOrRoCHQV1brzCNltwUf0halxRsPNr7kKeigL8rD7XXsk2
X-Gm-Message-State: AOJu0YxGTpfxB96079tzd9yqWrVWtsMjdy7CHk2k3GQzVetn4piXIfza
	qUN/fSZ6n2IhIVgEZsKQoEiYJpH8KnqYH2eX3IS9POj/UShE7n8SPbRI7EGw
X-Google-Smtp-Source: AGHT+IFQZ7TreFX+MuHWfU3c8/pJOKTSk15d6PXmnzSSxZ4nnGjnuU1csrJaNr4+eDxIUFfcasMYwA==
X-Received: by 2002:a17:902:f54f:b0:1f7:42e6:ada2 with SMTP id d9443c01a7336-1f8627cab2amr1685545ad.41.1718296002522;
        Thu, 13 Jun 2024 09:26:42 -0700 (PDT)
Received: from dev0.. ([49.43.162.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855ee81bfsm15848995ad.137.2024.06.13.09.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 09:26:42 -0700 (PDT)
From: Abhinav Jain <jain.abhinav177@gmail.com>
To: agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: bmarzins@redhat.com,
	skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	jain.abhinav177@gmail.com
Subject: [PATCH v2] dm: Add support for escaped characters in str_field_delimit()
Date: Thu, 13 Jun 2024 16:26:32 +0000
Message-Id: <20240613162632.38065-1-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove all the escape characters that come before separator.
Tested this code by writing a dummy program containing the two
functions and testing it on below input, sharing results:

Original string: "field1\,with\,commas,field2\,with\,more\,commas"
Field: "field1"
Field: "with"
Field: "commas"
Field: "field2"
Field: "with"
Field: "more"
Field: "commas"

Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
---
PATCH v1:
https://lore.kernel.org/all/20240609141721.52344-1-jain.abhinav177@gmail.com/

Changes since v1:
 - Modified the str_field_delimit function as per shared feedback
 - Added remove_escaped_characters function
---
---
 drivers/md/dm-init.c | 53 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 47 insertions(+), 6 deletions(-)

diff --git a/drivers/md/dm-init.c b/drivers/md/dm-init.c
index 2a71bcdba92d..0e31ecf1b48e 100644
--- a/drivers/md/dm-init.c
+++ b/drivers/md/dm-init.c
@@ -76,6 +76,24 @@ static void __init dm_setup_cleanup(struct list_head *devices)
 	}
 }
 
+/* Remove escape characters from a given field string. */
+static void __init remove_escape_characters(char *field)
+{
+	char *src = field;
+	char *dest = field;
+
+	while (*src) {
+		if (*src == '\\') {
+			src++;
+			if (*src)
+				*dest++ = *src++;
+		} else {
+			*dest++ = *src++;
+		}
+	}
+	*dest = '\0';
+}
+
 /**
  * str_field_delimit - delimit a string based on a separator char.
  * @str: the pointer to the string to delimit.
@@ -87,16 +105,39 @@ static void __init dm_setup_cleanup(struct list_head *devices)
  */
 static char __init *str_field_delimit(char **str, char separator)
 {
-	char *s;
+	char *s, *escaped, *field;
 
-	/* TODO: add support for escaped characters */
 	*str = skip_spaces(*str);
 	s = strchr(*str, separator);
-	/* Delimit the field and remove trailing spaces */
-	if (s)
+
+	/* Check for escaped character */
+	escaped = strchr(*str, '\\');
+	while (escaped && (s == NULL || escaped < s)) {
+		/*
+		 * Move the separator search ahead if escaped
+		 * character comes before.
+		 */
+		s = strchr(escaped + 1, separator);
+		escaped = strchr(escaped + 1, '\\');
+	}
+
+	/* If we found a separator, we need to handle escape characters */
+	if (s) {
+		*s = '\0';
+
+		remove_escape_characters(*str);
+		field = *str;
+		*str = s + 1;
+	} else {
+		/* Handle the last field when no separator is present */
+		s = *str + strlen(*str);
 		*s = '\0';
-	*str = strim(*str);
-	return s ? ++s : NULL;
+
+		remove_escape_characters(*str);
+		field = *str;
+		*str = s;
+	}
+	return field;
 }
 
 /**
-- 
2.34.1


