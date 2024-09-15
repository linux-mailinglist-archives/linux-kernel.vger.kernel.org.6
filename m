Return-Path: <linux-kernel+bounces-329976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7A497981F
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 20:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EBAB1C20938
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 18:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457311C9DFE;
	Sun, 15 Sep 2024 18:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mneoY3Ri"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8A517C77
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 18:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726425331; cv=none; b=eSyTUjuE0bthKtxUOsuAnKyjrhqn9WQqhyVFjJJ2z20BPBXt2NCupZ/NdGX0Z/EFXWovS1g3OCEuEKB+Ue+73bdt5Zpq18KA3M6xWA1qwixoqfj3GH190XgR3NTqZ8sIACdMQwzNWPIpcrOe1RgUdgynw04ILm2DA9I2EmfnMzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726425331; c=relaxed/simple;
	bh=R/FKE+Vqjw1b26cP1BW8Gn5IExiNl/9oqrudwSS6Dq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IJYZe33XjKrrTYCyj8S34NH03FItGjPr9ot+ut+IvxxxUqy3Nv/CP65s3IA1gShqQ6J3TzeC7e74opWlVxCIiHLFEPXyo6UXdpf42+fuDcdG/kOBIkfeSNf1rO9DkL7PmJKtLUYR5hHbchFQ2LM33WnAlt0aqyj4IRV5df7ZH0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mneoY3Ri; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6c579748bf4so26811056d6.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 11:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726425329; x=1727030129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yz/m+I1mEPoG8hIE0qavFnWoabah9gVgrFM3JQlh/wg=;
        b=mneoY3RiMdgBqRiTpYFjX1w3ZCoH4PwyBij5bZMPuwPLnk3E8htUp6+Fhgy52igRZz
         x2NkJgO1FtoDcTSCOArVGBn/lENaKkFGjvHLQlj4KGg5IcXXmsJC/rrH8ut4HLhDFaSK
         Pd5VfuQrXP6YJfDHj9ZAj8BwECG09vZ/P/DiFXatK1dKU7xqPFxK0YrlrKUO/TK7T6pI
         5NkWxE9Kjjov/TElBGXHqA5Vv6kBZmennXDe80lqZ2d9L9l4FNKmFMLQfL0UZ27oRdVn
         iqEa9wa++0YvZLdxA+RgOiJOGLoFeBSSBWJj0TeaJbaiFWLwce175PxS2GeNyBqnvX4s
         Osww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726425329; x=1727030129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yz/m+I1mEPoG8hIE0qavFnWoabah9gVgrFM3JQlh/wg=;
        b=Otp+5Kx7n1ftPeUSQ+3nghFH4ApHf9p1wi2P/9pAE80fzGRc9aPQpyys5BCxw0qQtG
         5A4Hk4iGUi2FLIdZFbAmpL0E2AK4E80+VZPzI85XCACpcIDXE4sFGid5v1j0shIZUtii
         wOHCIah4n09jeihuXT44nJq/LrkXP+ivJsv4QwELPNYT9iCS7dEwYEL3ExDMYFDjjevW
         gUGdii0BMV4Zo6pbZJAkZw3+efrQEtTNm9g6Ulzu4qzT8tPw0zDYQOQ9wFa6af9imgD+
         tckmZ3EAXmh07HQYX/iXhDmBAilm5ReDejDYT43gfQwINUp9HuMluTHBMu4Iv0DQF5/d
         rLGQ==
X-Gm-Message-State: AOJu0YxxKEzSVQ+b5pZpoMODsYzNQ5YTlT4dhYXXgGxTKWRDl7p+JW1F
	8qBYByvD1Oux8u9PUzbfDyEKx7V+FIN6g3YjtzegJg+xxg/UKe+4
X-Google-Smtp-Source: AGHT+IHjJ9IoNSUmulvij6GuhEPzd1wXC6qMcbzu/Elq7CLIGfrR8q6VEpHevw4E3UQhZQzFoZc3lg==
X-Received: by 2002:a05:6214:2f0f:b0:6c5:55bc:2705 with SMTP id 6a1803df08f44-6c57df773a1mr151218786d6.6.1726425328988;
        Sun, 15 Sep 2024 11:35:28 -0700 (PDT)
Received: from aloks-arch.taildd577a.ts.net (d179-68-123-141.evv.wideopenwest.com. [68.179.141.123])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c58c645d27sm17476946d6.73.2024.09.15.11.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 11:35:28 -0700 (PDT)
From: Alok Swaminathan <swaminathanalok@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	Alok Swaminathan <swaminathanalok@gmail.com>
Subject: [PATCH] lib: glob.c: added null check for character class
Date: Sun, 15 Sep 2024 14:35:25 -0400
Message-ID: <20240915183525.13464-1-swaminathanalok@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added null check for character class. Previously, an inverted character 
class could result in a nul byte being matched and lead to the function 
reading past the end of the inputted str.

Signed-off-by: Alok Swaminathan <swaminathanalok@gmail.com>
---
 lib/glob.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/glob.c b/lib/glob.c
index 15b73f490720..aa57900d2062 100644
--- a/lib/glob.c
+++ b/lib/glob.c
@@ -68,6 +68,8 @@ bool __pure glob_match(char const *pat, char const *str)
 			back_str = --str;	/* Allow zero-length match */
 			break;
 		case '[': {	/* Character class */
+			if (c == '\0')	/* No possible match */
+				return false;
 			bool match = false, inverted = (*pat == '!');
 			char const *class = pat + inverted;
 			unsigned char a = *class++;
-- 
2.46.0


