Return-Path: <linux-kernel+bounces-536318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C75C2A47E20
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0E133A625B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC033010C;
	Thu, 27 Feb 2025 12:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="askmonWv"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF02F27004F
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 12:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740660320; cv=none; b=ji3g8AvXsWw2ZqMIPCYnbIWICiQf9n+6v3R0+UQRFDTVAVKBiiIT1B1jsQRcryMjsL4Zjoe0NVgfi7NssIYNX+HhSw0PB67VSExO+1btPyDK0Dy6t8SU87Z6yfrh3WD6xvcCdMrnW01yxAe5Ql1bR51L5NAW8pwIFTC1K8C0TNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740660320; c=relaxed/simple;
	bh=4qjFpj/O8EuqzwrkbdkZ7vhHoDiHRRuS/phjk+EMKXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hES4kZ5oTdbp4M+ZFOxMZr1D4/W41b+P+rVgOSybpt6CLWas8oK+jtJAZyAii1/I7V0IVJG8zujVCFxWFF+AAjdIGpBc/nVlHOcNEzTydO5d9gn8fNukoyzsx3h/+dKQHZ9q1AePBAAph+gYOH3fPcCbcyatn4zO4rfJVlxZHyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=askmonWv; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2feb47373d9so227913a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740660318; x=1741265118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CoDMNsdCwpD9bQQAMMSaST4NFpnfhrfHKJqEonZ3Wrw=;
        b=askmonWvzdohtf/a9Bz5hSNH1rmBjvy1+SH9RB6jxmTucDS2UwpLWVb3GAimLBPaWU
         CfDzyxyXScUpZOHuJxkUk45OiK0Bahaix9mI4cB8CdhfXNvMMsW+L0OxjJgmwZ+wGwTe
         xSmS7FntTern7B1u7d4j4tHlpfYOB0QdCPNZSzFmj/NudGFrdvty/Wy8rL1hhRJfaopW
         luAKzIGsZzU5Iu8Yt65Z17U37ejL+F9jZKR6mMNlZYqaeARqebz5LiQAoNkDwRKh8bj9
         Z4LsbtXPrW6/QPtQxvMgw/li53p/YjzvHtSOWpUqZDCzv8uZA4jTQJQze3DGtQMvrAvX
         Rv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740660318; x=1741265118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CoDMNsdCwpD9bQQAMMSaST4NFpnfhrfHKJqEonZ3Wrw=;
        b=rIMXY6eUSM6jd1KlWbpRuDHzwnkTHSF5MHYHtspzU0VusLwWElQY0HhMHMJ1YGULyf
         ksM/aGC46cCr0/MxC5ikyb+M+lj7mW46zqXDJtAS9jwtBdhaO9mjnk9bTLIXl5ZzcSuo
         E9k/UvUw84R1iAgCKqZKfjTo4lgZ9IDHx8A6qXA+Mmsuvc5y+5hKbwHAe6NEL8FpAxbS
         EL5VlpcuMk7DwWH8+qBxpRA7jQ1HKbDknOZV/vx2jGwpu/0lK5XaCWoF2C2RbJTvB6H/
         TrYzF+WLggkuWU/eylhYdSE4g0j/6MBZYgflDnjtCeqwvN4MWvxjJgatrQ5LmBrGEs/O
         yvqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGllppFdUY/521zndkKGUTT6ce2tlcXwhoQ4jxMeKK51QGPGBIUVCTWQsNrpEZ4fhCVIeiZjqRV6uRteo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1d0eUHYrcz/7E20BD8P3U3Nb6oIHF2iExiiZXUqZDeI9jfS+p
	UESNlGcRUM3kJGVO+NedTUDHb24GAVg/AomVKXhOdYp5JEj/xzDX
X-Gm-Gg: ASbGncshVPkD85qO25fZdf/uXFz0U4z6goktYgfy1JqMgzQ1bphvrr+6Uwzo0BoV3g9
	8S6ydrHfQo4e8PIZFv50MEjus2+yqJR/99JueuVGZE/AOR75rlcbf3whboVjsYjHAjTjCpHr6b4
	vfLUi7aeiKij1ydaMy+U5LRfC27emJUVeEZetPtnxtMOk+nR1Bav+JWCsTpKEphhwxJqww2W7BW
	3ld38g/tu15dGOqFpjxSTi45MSPS7X5V2qEF+JzoG/0shH7qOogDUz1A/XD1OSOLyrKRofFe1WM
	ihcWODVNDJXawKrR/Vv836uoxyiPPgbN0tEdTdCTJm3ua8/wscbx
X-Google-Smtp-Source: AGHT+IEzrBJRbVzaSyVYDGURbJtLzkxr1lRt0lFTgMwEWfOfbcUgHPk+Qm8SuV0cOFvnVlh2GlTs6A==
X-Received: by 2002:a17:90b:5201:b0:2fa:1e3e:9be7 with SMTP id 98e67ed59e1d1-2fce76a1eb6mr37308207a91.5.1740660317927;
        Thu, 27 Feb 2025 04:45:17 -0800 (PST)
Received: from ideapad.tail50fddd.ts.net ([139.5.199.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501f9dd8sm13406065ad.57.2025.02.27.04.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:45:17 -0800 (PST)
From: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
To: gregkh@linuxfoundation.org
Cc: ayaanmirza85@gmail.com,
	dakr@kernel.org,
	linux-kernel@vger.kernel.org,
	Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
Subject: [PATCH 1/2] drivers/base: fix checkpatch.pl warnings in attribute_container.c (v2)
Date: Thu, 27 Feb 2025 18:11:28 +0530
Message-ID: <20250227124417.132020-3-ayaanmirzabaig85@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <2025022606-carrousel-unstable-f2f3@gregkh>
References: <2025022606-carrousel-unstable-f2f3@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch applies only cosmetic changes such as
whitespace fixes, formatting and typos. These
changes are flagged by checkpatch.pl

Signed-off-by: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
---
 drivers/base/attribute_container.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/base/attribute_container.c b/drivers/base/attribute_container.c
index b6f941a6ab69..69637b2ec3bc 100644
--- a/drivers/base/attribute_container.c
+++ b/drivers/base/attribute_container.c
@@ -5,7 +5,7 @@
  * Copyright (c) 2005 - James Bottomley <James.Bottomley@steeleye.com>
  *
  * The basic idea here is to enable a device to be attached to an
- * aritrary numer of classes without having to allocate storage for them.
+ * aritrary number of classes without having to allocate storage for them.
  * Instead, the contained classes select the devices they need to attach
  * to via a matching function.
  */
@@ -21,7 +21,8 @@
 #include "base.h"
 
 /* This is a private structure used to tie the classdev and the
- * container .. it should never be visible outside this file */
+ * container .. it should never be visible outside this file
+ */
 struct internal_container {
 	struct klist_node node;
 	struct attribute_container *cont;
@@ -449,7 +450,7 @@ attribute_container_remove_attrs(struct device *classdev)
 
 	if (cont->grp) {
 		sysfs_remove_group(&classdev->kobj, cont->grp);
-		return ;
+		return;
 	}
 
 	for (i = 0; attrs[i]; i++)
-- 
2.47.1


