Return-Path: <linux-kernel+bounces-231039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 019BC91857B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 17:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ECA7B25B50
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA7F18A923;
	Wed, 26 Jun 2024 15:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKOlySSW"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6F818509F;
	Wed, 26 Jun 2024 15:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719414506; cv=none; b=JwZQyqVLgjvS4lKlpuCkm4u4YMRLALwzm363PMcONPZVy4bD6SnC71U/J9aRAzY9WM29sbKgPF0u2DhrunQV4d47iYlYTWyGfYQhpd5kVw+2Z6OHDua2Q5cCtIu8dDBaIi95hzzFo+L3hiursIZwTd8fEMvYitJ+wucLq6dPbdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719414506; c=relaxed/simple;
	bh=43FkPRae793YLZ9Lpekm1+NTDzvCf+L1463miSaTVkA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sf/nEDf97y5GzMrwhkfy+y1NFvTAYiKylaCvH8atZpjsZrfdB4v3kiY/5QqzxEkx2lewfmt/I5luM1G8F8hfLygOaGVMMUiMEGNOKGyihCQO9nI5dtnQqlgm5en/sVbwpfYxx+5D9dPWuW3w9JW4YeLZgKvyha0/7G8SvAMpW1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKOlySSW; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ec3f875e68so76109551fa.0;
        Wed, 26 Jun 2024 08:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719414502; x=1720019302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Aiz1xP79g5MWOcw+N04ZQRRPPPjd2aK1InqzkyIXJpw=;
        b=BKOlySSWN21xLbrrNybpvrD9buqlnJVsal4H/6HnIOIJbgXLf0LINcuilameq+D3j8
         kevUom8hDqlixbbtNBdAEyNTBPr20MQt/a3KnKZefbj7V9bVYHoPf3+iubAtzsMskZv3
         bk4wsSu5wakAbcCu8nY3muOTWHbD4nwZSa7gpRO6IexM4UddiLHZkuctdGSUM9vbbIPy
         xKayzF/59MCauNJLIFYVYmrpsfAt2AKwwSkz3KkuHBLo9LP2jWbKjtdGe4UPUvNwav27
         +wAKsj7oTeOkRc/8pz/7ul4K1ci6oL4zb5rCoispGCP+mNW14yAyAcgAbMMDAXi/nkHl
         UGjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719414502; x=1720019302;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Aiz1xP79g5MWOcw+N04ZQRRPPPjd2aK1InqzkyIXJpw=;
        b=hiOZQqE7oviXvHdLQ3D7nG4bQoSfh9mb728Q6ZSO/ivTe6HMoPZuJAhBTgj/GK43i1
         YPwbX/QsBzXieg+iCWOZbwiFIqXoLHiJZFKEO6zifrNqynCRy3raiTOPIZdw9J7ka5zv
         5Sjt+bWL4iS7pa/jIHSJb3nrJhOL//Cjwq9n8D7xFpKyLRpuh8fPAibIuO2lke1DcqRN
         O6SHWvAjFK7CtDAlKL9D+YDMGd27H2wnwmmVIuSdxR/TE6n3idjRvWvU/BQwUHaPGhWk
         qZtdvXqQkDZXTKp2aw64ECDuSjdjZoAZ281PUamODRp53BrRbfw9jDavcdOq2HZYl8jD
         Pw8w==
X-Forwarded-Encrypted: i=1; AJvYcCUEk6iPohWXgLuEHAON6YmHxgfm5ezqeBQqdOMOKe5GL8cHpjoCx9VXYK7BcRqcKU1Y6cJ1XWIeyQc5DuOplttMVANRiXzWdKkmh3Fu
X-Gm-Message-State: AOJu0Yy6cp3MeF8rQMSY9SwLDQ6Pal6q+ccOo0+Yv5qvPLfrI7qzyHby
	lS82jRITBlR7y5HvMqEoEvO1PFurfE71NjfBSapgqNgOtihpewuye3z+ADtWTzY=
X-Google-Smtp-Source: AGHT+IHZ7jM0OuwV/LmUhLIeLlnOQ4aaGlWGhH/0x43uOEV5CJlqv/GtYVvfMpBP8gdspq55bkEg3Q==
X-Received: by 2002:a2e:9e96:0:b0:2ec:588d:7eb8 with SMTP id 38308e7fff4ca-2ec5b37a303mr60830501fa.21.1719414501240;
        Wed, 26 Jun 2024 08:08:21 -0700 (PDT)
Received: from seskpc0236u.linux.cat.com (static-dsl-173.87-197-126.telecom.sk. [87.197.126.173])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-424c837f1cesm28296385e9.37.2024.06.26.08.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 08:08:19 -0700 (PDT)
From: Jiri Kastner <cz172638@gmail.com>
To: linux-doc@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org,
	cz172638@gmail.com,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] Documentation/tools/rv: fix document header
Date: Wed, 26 Jun 2024 17:07:27 +0200
Message-ID: <20240626150727.156397-1-cz172638@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

align header of document with filename and rest of the content

Signed-off-by: Jiri Kastner <cz172638@gmail.com>
---
 Documentation/tools/rv/rv-mon.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/tools/rv/rv-mon.rst b/Documentation/tools/rv/rv-mon.rst
index af0f329a7c9c..bed937120dca 100644
--- a/Documentation/tools/rv/rv-mon.rst
+++ b/Documentation/tools/rv/rv-mon.rst
@@ -1,7 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0
 
 =======
-rv-list
+rv-mon
 =======
 -----------------------
 List available monitors
-- 
2.45.2


