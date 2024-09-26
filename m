Return-Path: <linux-kernel+bounces-341156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E43D987BE2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 01:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EA641C211B2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 23:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6649B1B1D71;
	Thu, 26 Sep 2024 23:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v+y4tOKd"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8211B1D5C
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 23:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727393821; cv=none; b=nPi4hZJkrX5i9m/ec5y32Yc/s+XOGaS64xesVQpnTccypeT4hoHA9kPgp7rQl/aY3HPOqPAfpfFY/0Adxs0l9NRcetSpARQZakqeSHp9BS2/2IzOHdOovKDHxB9VzWtJoWLk4n1AnrY9so7H4Q4uMUbspe7K/vKqxxIRNG1jAPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727393821; c=relaxed/simple;
	bh=0wQLZGUBmhpsm/PqIKgF4vhryRNNUmvmm5suV7LfdPQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t0OCZoMa6xPw4c7UWwPIc17j205jGc9pp3819sA19mLZJHAUr34O40pFXT4GCTJxzV8o78UzUvikbnS8VB1TGQXyDwFY7m/421A9nWv7uqf6Lpe4SNSgCQQ9ZlIW3f1QlmoBARGmI7rSohCZIpxv98x03f/25dGBqIhu1qP27bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v+y4tOKd; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e2146737f2so29167227b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 16:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727393819; x=1727998619; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RfIWbsqxtW/srupdqZRxObhE1OoVW4h9NYCU5IwMPgQ=;
        b=v+y4tOKdaF3SUrMHGd6o3rLp5EsXosURuPJxpDqmxaa5y1f1VTif/sCjrXMOGiCyWI
         XXnI9AE7aZQGpPkqvsfq/70aYzDJH+IPrIkeI/g2/BD//I0sPvTu+Ams+Iw6g66cEKmq
         ELNNbrLcYJ23/x0/RBKqXq3uEZ+Ew550Wqu3WsNxWmmRhmFumq39Y6lw+Uweuu5xlMNp
         Y3KqNcUMfDYEHCzU9dWpDpeAMQ8F5fjq6J5WD025+Tx8LbijubWXtbEsUQToADagwgAs
         8v7KApAG7TdT5SnFOAkMReLL3iGuVU6/SK4P+FqHN12GZ4+pai4kRslx3WBOwuGK8x26
         dAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727393819; x=1727998619;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RfIWbsqxtW/srupdqZRxObhE1OoVW4h9NYCU5IwMPgQ=;
        b=QxYH2AClVEJ7MhK4WazbxlUpukXliCqemji11Z7VCYb0aHcz/b2oWBaapMVIHKAFks
         f2iowQHSUpX6deXS1KrYSOEXIJszMk9PWoko60vsPW+yVsHGxsUAjVmwQ6Wu/B6bLaKx
         ocKuadwJHHKm6q3vLuB3/GPVkQ1I993BH124E4e2IaFEQvead7+q2l/+fU5o2HvqDG3t
         kImFH5b+36k+IjCnsHJ+wZD2qIuJC91LG1+xWm9HTzsIZPw5C7LGwaZUxgngC76yQbPt
         tnLz//mHOFQ1qooqhex23NQitjb3KS2stRIt82hm3z620P9Rat+PRJq/gMQHsMQMu7oK
         62FQ==
X-Gm-Message-State: AOJu0YxVX34Qi6hJgj+bFz3CvNY689o6MM/MRb1lm/UhyZgWs6LP8Hrs
	yL3rOopreU+P/lxoVhLVPz/ATT8hYc1zhVDL1JETj51I//YsfSD0Eal1w0Bn0uqaQR8oZ8Za5WP
	FG1zA3yWpQQ==
X-Google-Smtp-Source: AGHT+IHqSJVku0EWEj2r5XcqywvzRvQB0jNHyuhNh9+DFeKP39ZT7Op+9wJEbEIowlN2bzx85VbN4A6f+KQP5A==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:690c:3708:b0:6db:afa4:75d3 with SMTP
 id 00721157ae682-6e2475a7f21mr434807b3.3.1727393819526; Thu, 26 Sep 2024
 16:36:59 -0700 (PDT)
Date: Thu, 26 Sep 2024 23:36:19 +0000
In-Reply-To: <20240926233632.821189-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926233632.821189-1-cmllamas@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240926233632.821189-9-cmllamas@google.com>
Subject: [PATCH v2 8/8] binder: add delivered_freeze to debugfs output
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Yu-Ting Tseng <yutingtseng@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Alice Ryhl <aliceryhl@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add the pending proc->delivered_freeze work to the debugfs output. This
information was omitted in the original implementation of the freeze
notification and can be valuable for debugging issues.

Fixes: d579b04a52a1 ("binder: frozen notification")
Cc: stable@vger.kernel.org
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 7c09b5e38e32..ef353ca13c35 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -6569,6 +6569,10 @@ static void print_binder_proc(struct seq_file *m,
 		seq_puts(m, "  has delivered dead binder\n");
 		break;
 	}
+	list_for_each_entry(w, &proc->delivered_freeze, entry) {
+		seq_puts(m, "  has delivered freeze binder\n");
+		break;
+	}
 	binder_inner_proc_unlock(proc);
 	if (!print_all && m->count == header_pos)
 		m->count = start_pos;
-- 
2.46.1.824.gd892dcdcdd-goog


