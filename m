Return-Path: <linux-kernel+bounces-354800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 628A09942BF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AECE1C246DD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132A31E0B7A;
	Tue,  8 Oct 2024 08:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lEu5KSVj"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021B51E0B6E
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 08:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728376151; cv=none; b=h3IIWiEDLn1RD8UATIxUUEX71/M82H28eaGV1xwV01W4bp7NzPlVCgmMPAGiKMz3oLP7DTdf/hihceqh2FFdmSnaL605OthpXvLiO5y8LFo1QMayhcdog8vRpRADeJjbjg25SfYCMrGQuxPJgEDpKsoZJOiME7owBKIaQzpfeaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728376151; c=relaxed/simple;
	bh=2kUlfzx24uSNRplKYF1sda+86294BesT58Y2Li1gfnU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XNz51PjPfO2mfzobOhFGeK0sK74MI1SD9L96hyGSBVnZfV0eO09cYpsaAHlXyF/Tr+EtpxceYBMq2pmkLMudVotIfAMVO27kHrym33NaVv3ngL4fIX0qANFc6z/+JMre6Xtad+9SuIZ/hM6QH6aZ1yJ1VnFrHjTUlvVatrwpKWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lEu5KSVj; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20b90984971so54967845ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 01:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728376149; x=1728980949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YPEjAdZAdKM8As8ooV00IBm7Qnjs2K7rlCo6iukXXxI=;
        b=lEu5KSVjJ1S1xQsRCRGSE1K2hb8dnQ9fmdkR5iUK2lUZC2syZeiChEU8hzcG1mnSLM
         4goeOZNHoSPriZA1gFSGt6tKEFDJfKQ84T9v2gMzi3/9mH0VIwgODZGrjuHRWGSiyfOw
         k3Ds1ESljZNoeZ8Ui0e91x/UlDlb+DeN3tyBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728376149; x=1728980949;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YPEjAdZAdKM8As8ooV00IBm7Qnjs2K7rlCo6iukXXxI=;
        b=SmCrpAG6VSHrBrxE838RIj6DLSsPeMv+ez+3QKDrIuqHACDB2bI7zyAinRui4CLPbu
         KloYbxDSSfxIgkDzFSRnr1xSykwk+2AziJ0srL1azbSqCdL2/pDFdF3/U0rmBonUxVXK
         x9597Fa8KDqz/BLE/xb6MQwonFyVAsYqefIYnz0S6kTNVk1IxkwgjHX6NGo9xI/CAAvb
         cvySe3gBTDS/9787YP8gSMhUTmYdoLkZdmxUmLjqwdKwD9wegka4luw30k1kIUrZt7oI
         vvWBRAFmV0S/fLFpfB3k6cHLnDZKrcQ5D8HgE6bjjt8QgE0nCMrladiyZwSwePy1PMwU
         Btwg==
X-Forwarded-Encrypted: i=1; AJvYcCXn14baHhqqJPOsN2yAIod/WSLBm2ERaFBJMgCNKI8sS5zgjkz7HlxVnMlmZTypHGtWuBy1VR+lI0u+5dw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI2nRV8GDL9ZKxMyOHkXHVIgXgTzP+/iPk6q94Zn6jxMtbgMQY
	+SygFrjcuROZ1lxyBaZjcrxnpgYiOenuOp9GNOMm0k03sTniePk8pXMrjK83bg==
X-Google-Smtp-Source: AGHT+IH56nKMsGdXXZPfM/++yBwGdaVnxpD6SPm/wRK5S73jh3n0gu+4M32NRbck9Xml9CGHgDT7MQ==
X-Received: by 2002:a17:903:1d0:b0:20b:5be:a403 with SMTP id d9443c01a7336-20bfde64ff4mr196014945ad.11.1728376149374;
        Tue, 08 Oct 2024 01:29:09 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:10df:d27e:8d4b:6740])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c1398ee06sm51069965ad.288.2024.10.08.01.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 01:29:09 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/kernel-doc: Do not track section counter across processed files
Date: Tue,  8 Oct 2024 16:29:04 +0800
Message-ID: <20241008082905.4005524-1-wenst@chromium.org>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The section counter tracks how many sections of kernel-doc were added.
The only real use of the counter value is to check if anything was
actually supposed to be output and give a warning is nothing is
available.

The current logic of remembering the initial value and then resetting
the value then when processing each file means that if a file has the
same number of sections as the previously processed one, a warning is
incorrectly given.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Found this while improving and checking the kernel docs for the
regulator core.

 scripts/kernel-doc | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 2791f8195203..c608820f0bf5 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -2322,7 +2322,6 @@ sub process_inline($$) {
 
 sub process_file($) {
     my $file;
-    my $initial_section_counter = $section_counter;
     my ($orig_file) = @_;
 
     $file = map_filename($orig_file);
@@ -2360,8 +2359,7 @@ sub process_file($) {
     }
 
     # Make sure we got something interesting.
-    if ($initial_section_counter == $section_counter && $
-        output_mode ne "none") {
+    if (!$section_counter && $output_mode ne "none") {
         if ($output_selection == OUTPUT_INCLUDE) {
             emit_warning("${file}:1", "'$_' not found\n")
                 for keys %function_table;
-- 
2.47.0.rc0.187.ge670bccf7e-goog


