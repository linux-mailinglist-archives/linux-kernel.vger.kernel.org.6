Return-Path: <linux-kernel+bounces-303940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2788E961728
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 20:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 892BBB22C87
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 18:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333FA1D318F;
	Tue, 27 Aug 2024 18:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfHqzdDT"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289A71D2796;
	Tue, 27 Aug 2024 18:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724784262; cv=none; b=ANW8n5N4m7rZB/s0iO4P15SzeoQelCO3ZlpkHPL58CHubowfJPz4ji1jpS4LH7Ph897ErWZnAg+bGm6ex8nnbsUCjj+7tJDV9ubIqNsZBKz4fQQy/W5L3Zh4P/ODch1aBLGY8NwtUrzjBkjmp11dmjhV7zprdNHGoP2lXoID5uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724784262; c=relaxed/simple;
	bh=u6kW+6ArbewrNzZcKJ3cCim3nQ5/kCbS8zfS9851Gio=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aJgeWiENbU62682EEgukPCik/18aIbKJQctugKuSzQ4E5jC+s7H3rgZ8dVLupVjL3FLzZwi0aH2FiAmZ1Rik0IInwtS8lvA+t6AN85lFAJASdi11HtEQQvYQ2YEfFGSMVjMTNhlDoagNAGjrWuuzzXpXUfBAjnj3HqwQ4vR3AsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bfHqzdDT; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-201d5af11a4so52146525ad.3;
        Tue, 27 Aug 2024 11:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724784260; x=1725389060; darn=vger.kernel.org;
        h=content-transfer-encoding:commitdate:commit:author:mime-version
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XdyQszHmpMjA1lielnMCOCT+CVl9suwnpweUfFJE9W4=;
        b=bfHqzdDTrLGi7ie3Bh7Q7EBPj1iRlE5n0+ld/R2xpFczS/kM2qjSDez6efCUjdev7l
         YbkBGKWW01TLf8aHXEwFEMzJBl5Z/SqkKHx9qrOxYNuj+Rn2bNEXdwqywWEEKqki1IdV
         RdSxycwTEyLxEs3Z6lOgByGHrsyV2Ona9oseEWMfRTaUwOzbNuGdT0O2jrgAWidzZE8+
         XKkaf+z868nfUzQ52t+uelq5hUMw+nktV4B6yQMR3QUtcVLy0OZ6LzymLD65NATlesrZ
         ETZSXXuGbl4mpiUtNigyjjYK8Zdhjg3yDZ6/s6KmaGyyscODzL/3YDCljrukLC4VHdPl
         9mag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724784260; x=1725389060;
        h=content-transfer-encoding:commitdate:commit:author:mime-version
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XdyQszHmpMjA1lielnMCOCT+CVl9suwnpweUfFJE9W4=;
        b=l/ELzjjraAljvG8i3LvgIxQjuu97pOIw2WYwUJU7U135qVKMzkfmwFF2Pmhl/Dw9lP
         nbbWIb9PWU2TmJcwIdJQkdCF7hLoiUO3WMxFusWASbfCG3zYS+yhFFmsqrTjC9P4LahZ
         5eOL9Yppq4rQnqElAXGMrsMsY+qj3FEriT1MZmq72NV9+tj2D5ncBpzia941bh8x0UZP
         Acr7ec8C0DlQKYGGgMbzhDP1i6RxhZOAdwf89qPuaxG4V97T80R4Stnn8io6Tu1agPt9
         1idWSBCP0fXE9Cr7tfoFLpOJajvef5JbOEgmOwp67n50o+ZsBJUWkOsQ+6bXj7aHq9uq
         5eMQ==
X-Gm-Message-State: AOJu0YzD8gfSMn+7JjTLZs3R7idAOALSGxtSJVzrm931KCigDKZcg6x5
	effkchKzj9m2Kr26ruzYuPj0NCYQYIBiea2wefUA7Ffj++GyuQlnYvzQ1CSxwVcMfw==
X-Google-Smtp-Source: AGHT+IFsLXIZScZAJ2TBLqBoc9pEROKLjGEiHL1U3h3kRucKfLmGZZTuWQ4JAzS5QiQQ10KFYHpvow==
X-Received: by 2002:a17:903:35cf:b0:202:1db8:d9aa with SMTP id d9443c01a7336-204df46e52cmr44607005ad.30.1724784260178;
        Tue, 27 Aug 2024 11:44:20 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:f022:f804:2fa2:fde0:4987:3a52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385fd0e91sm86660385ad.309.2024.08.27.11.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 11:44:19 -0700 (PDT)
From: Siddharth Menon <simeddon@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	apw@canonical.com,
	joe@perches.com,
	Miguel Ojeda <ojeda@kernel.org>,
	Siddharth Menon <simeddon@gmail.com>
Subject: [PATCH V2] scripts/checkpatch.pl: check for non-permalinks to Zulip
Date: Wed, 28 Aug 2024 00:13:59 +0530
Message-Id: <20240827184359.46968-1-simeddon@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Author:     Siddharth Menon <simeddon@gmail.com>
Commit:     9c32b4f2ad277b94a54955b0285ff7dcfb5087aa
CommitDate: Tue Aug 27 23:39:18 2024 +0530
Content-Transfer-Encoding: 8bit

Zulip links to https://rust-for-linux.zulipchat.com can break in
case of renaming the topic or channel if they are not message
links (which are permanent links).

If a non-permanent Zulip link is referenced then emit a warning
and direct the user to the Zulip documentation.

Permanent links are of the format:
https://.../#narrow/stream/x/topic/x/near/<numerical_id>

Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1104
Signed-off-by: Siddharth Menon <simeddon@gmail.com>
---
V1->V2:
Corrected the Github link to the right issue,
Fixed grammatical errors and Replaced the link to reference 
Documentation to one that is easier to understand.

 scripts/checkpatch.pl | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 39032224d504..41630532a056 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -735,6 +735,10 @@ our $obsolete_archives = qr{(?xi:
 	\Qspinics.net\E
 )};
 
+our $zulip_forums = qr{(?xi:
+	\Qrust-for-linux.zulipchat.com\E
+)};
+
 our @typeListMisordered = (
 	qr{char\s+(?:un)?signed},
 	qr{int\s+(?:(?:un)?signed\s+)?short\s},
@@ -3415,6 +3419,12 @@ sub process {
 			     "Use lore.kernel.org archive links when possible - see https://lore.kernel.org/lists.html\n" . $herecurr);
 		}
 
+# Check for permanent Zulip URL
+		if ($rawline =~ m{http.*\b$zulip_forums(?!(?:/#narrow/stream/.+/topic/.+/(?:near|with)/\d+)?($|\s+.*))}) {
+			WARN("PREFER_PERMANENT_URL",
+			     "Use permanent Zulip links when possible - see https://zulip.com/help/link-to-a-message-or-conversation\n" . $herecurr);
+		}
+
 # Check for added, moved or deleted files
 		if (!$reported_maintainer_file && !$in_commit_log &&
 		    ($line =~ /^(?:new|deleted) file mode\s*\d+\s*$/ ||
-- 
2.39.2


