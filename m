Return-Path: <linux-kernel+bounces-218480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 943C890C06B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 02:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F30C1F2184E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 00:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612A52A8C1;
	Tue, 18 Jun 2024 00:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iizLPgnV"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D762263A
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 00:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718670982; cv=none; b=IjfMpKIangzmLQGAOraix/wKdkii5B8WChAfLTjj3v4VOD//B6UvR4oBDjaQC8knoR/WUzjPemjAfCeEiPsJjrXy+Jl03P42CGzUlRVKPck9y7e0HYmK69jeZnbvHsegUjBBDBJ9WAwVyS7bfUprsViwE8mME6i2s2GXhef/tMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718670982; c=relaxed/simple;
	bh=vV5BCl2X2CXWKQEh3jzt8EHrQMlfsVVU0MMSYe2XhSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YZS7l2D0CKwPfWBqOoLxgAaVv5uY2jZbOukYrwhRhBvi95E+FWiFos0yXBtxKzNDMrtqkYqTFOHPuh/x0hdACSaUTgOz512vMaxKBd46YgkiOUqjcwJbTrs7iHLcPiiS+Ywlqnbf/rcrj5DYIodhLLO8vcnD2UmsMxv5EEkkKCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iizLPgnV; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7061365d2f3so746289b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 17:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718670980; x=1719275780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0wDlLxN8nsz23vuD5cVykEn+53xHNnMwK+3wqmFHa8=;
        b=iizLPgnVvYAH+UHpIw99CICVki0DH42DZO6t4xfhroKT+sv1iQnqvqTwGIWyY7P3PG
         JUgKabETkBQjhUA1/cMxF1AeheWxhc0+9dTnUgwmVAFzMMoSOPIs8bwSa/8MYdQuZM++
         Re7v8skH4OCqlSs6Gx1DmusUl1S6TnOEb+ZIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718670980; x=1719275780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k0wDlLxN8nsz23vuD5cVykEn+53xHNnMwK+3wqmFHa8=;
        b=cMbpR3YCXtfa+RXCHlP4im557sse/7yzwcQI4W42SkkIkYFlaXje0uWGYKMBr59o9d
         jlLEZAz0JfNKyi7tcfdpUneP6W/XjtR6YqcvqtHoA9qQqXDmGN5FNSxMM404lhErdLC5
         xgyNw8EajqtRBA2CrA/ULios2UHx7Dd03JpvuZt9eDsgf0HoqTlv3Z8NiZVx2bi16O16
         lRKzWvw+ufbbZuIH7aSv/peCqfXmxjg5X9gK3gL4ZkIjfdGagTMDvmCosSZ9+hL7xZ8h
         5cNigqN/zb7MGP797bZFea34cns2B6zX4LcW96gJ8XN8Zh+xY/3jBmx7Qiwb3JEVlB0p
         jhwA==
X-Forwarded-Encrypted: i=1; AJvYcCUEZBvZpOzalplAAkNPEBOX8i6TVYRW7EdyVpGT7ie9IpfDvLzU9lS6R4KvD2LnBuMzbZFWeILXFFHsn/53HWY4Hjh0pRJYMg+hJjwf
X-Gm-Message-State: AOJu0YxG1+nCELmCXLIs/e8zaM/48FFwrXwQS9Ca4jklJAjQUbvabqca
	dN9I/NC6XqSRrS0V6VqsBNFycCZzHSp4a9XYPAsPJ4f8JdtRP+H8MRjBnVsUrw==
X-Google-Smtp-Source: AGHT+IFy14sjKwgsvXgu8myES4EXDcuaWAWfoXtGNeK0UrAt4zfV1HHSU27q2aFhIP++Yo5ZHVgVLA==
X-Received: by 2002:a05:6a20:12c1:b0:1b5:d143:72e7 with SMTP id adf61e73a8af0-1bae7f0f0b5mr10933240637.32.1718670980430;
        Mon, 17 Jun 2024 17:36:20 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:1798:e71b:11ad:8b94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb99f4dsm7905917b3a.216.2024.06.17.17.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 17:36:19 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: kgdb-bugreport@lists.sourceforge.net,
	Douglas Anderson <dianders@chromium.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Jason Wessel <jason.wessel@windriver.com>,
	Thorsten Blum <thorsten.blum@toblux.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/13] kdb: Tweak "repeat" handling code for "mdW" and "mdWcN"
Date: Mon, 17 Jun 2024 17:34:41 -0700
Message-ID: <20240617173426.7.Ie8aa2af2df12c2e9dc510f003a301401a1ac97fb@changeid>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
In-Reply-To: <20240618003546.4144638-1-dianders@chromium.org>
References: <20240618003546.4144638-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In general, "md"-style commands are meant to be "repeated". This is a
feature of kdb and "md"-style commands get it enabled because they
have the flag KDB_REPEAT_NO_ARGS. What this means is that if you type
"md4c2 0xffffff808ef05400" and then keep hitting return on the "kdb>"
prompt that you'll read more and more memory. For instance:
  [5]kdb> md4c2 0xffffff808ef05400
  0xffffff808ef05400 00000204 00000000                     ........
  [5]kdb>
  0xffffff808ef05408 8235e000 00000000                     ..5.....
  [5]kdb>
  0xffffff808ef05410 00000003 00000001                     ........

As a side effect of the way kdb works is implemented, you can get the
same behavior as the above by typing the command again with no
arguments. Though it seems unlikely anyone would do this it shouldn't
really hurt:
  [5]kdb> md4c2 0xffffff808ef05400
  0xffffff808ef05400 00000204 00000000                     ........
  [5]kdb> md4c2
  0xffffff808ef05408 8235e000 00000000                     ..5.....
  [5]kdb> md4c2
  0xffffff808ef05410 00000003 00000001                     ........

In general supporting "repeat" should be easy. If argc is 0 then we
just copy the results of the arg parsing from the last time, making
sure that the address has been updated. This is all handled nicely in
the "if (argc == 0)" clause in kdb_md().

Oddly, the "mdW" and "mdWcN" code seems to update "last_bytesperword"
and "last_repeat", which doesn't seem like it should be necessary. It
appears that this code is needed to make this use case work, though
it's a bit unclear if this is truly an important feature to support:
  [1]kdb> md2c3 0xffffff80c8e2b280
  0xffffff80c8e2b280 0200 0000 0000                            ...
  [1]kdb> md2c4
  0xffffff80c8e2b286 0000 e000 8235 0000                       ...

In order to abstract the code better, remove the code updating
"last_bytesperword" and "last_repeat" from the "mdW" and "mdWcN"
handling. This breaks the above case where the user tweaked "argv[0]"
and then tried to somehow leverage the "repeat" code to do something
smart, but that feels like it was a misfeature anyway.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 kernel/debug/kdb/kdb_main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 700b4e355545..3c6fffa8509a 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -1611,7 +1611,6 @@ static int kdb_md(int argc, const char **argv)
 
 	if (isdigit(argv[0][2])) {
 		bytesperword = (int)(argv[0][2] - '0');
-		last_bytesperword = bytesperword;
 		repeat = mdcount * 16 / bytesperword;
 		if (!argv[0][3])
 			valid = true;
@@ -1621,7 +1620,6 @@ static int kdb_md(int argc, const char **argv)
 			mdcount = ((repeat * bytesperword) + 15) / 16;
 			valid = !*p;
 		}
-		last_repeat = repeat;
 	} else if (strcmp(argv[0], "md") == 0)
 		valid = true;
 	else if (strcmp(argv[0], "mds") == 0)
-- 
2.45.2.627.g7a2c4fd464-goog


