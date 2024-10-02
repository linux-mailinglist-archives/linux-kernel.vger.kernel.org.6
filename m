Return-Path: <linux-kernel+bounces-348266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACC998E4D3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 23:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41E701F23A4E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 21:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6667F217327;
	Wed,  2 Oct 2024 21:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QW8cEODp"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4840D1946B9;
	Wed,  2 Oct 2024 21:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727904118; cv=none; b=asQSdSe1Ttk1eWwL23jmv9h6BgnJM8sfWZKoTsVIOScYQ2x6wkIVkzrOJ6sj1guTDjUdMfYdqp39YSDppbnK4lJGDvs37ki5GGtjpnhkZVBRfQJYnE1LsLLS3yRTsrMy1vHwzt3rG64/wcKg3BXVuSbaf1G2TR8HBDmc+zG0Ffk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727904118; c=relaxed/simple;
	bh=Dh1HetinBC3Lp7wkQg3iq1yNhuwzKnogtmJMg0IpHFs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RWpvt+FqYe2walvCY4JJWdxFwvqk7r093H2rFgpmO7C0vhzh6yy8zwqhk1tlDVmLjYTZkBPp7L+JHIcQXKuIKgxGa4iwogJjsevv6B9xMNzlytsyfEhIcW8Sckk3Rd7B2yOjVb8FvHVcmCNnP+Sf9TsIFj5zHwEogvZFLNTuhDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QW8cEODp; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cb58d810eso8237215e9.0;
        Wed, 02 Oct 2024 14:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727904116; x=1728508916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kxVheSzFlnS80SxE0njZ5VOYQVUqoAMG0WXxzYHDWdg=;
        b=QW8cEODpKvrP73VfMqQKdHEdXXcAfS3Ev8S+vap/0B91NrpKPxxX/7t/24imaQAZpR
         2LU3C6R3sxEQPBqRu1ppIEDmLk8Vac3Ra3PHG8LPSo4XBofbRCIzdvn5pBw33vJB/lZy
         GYcWi2DQJwkxAedAaDTyJOTgVpIjmIQTh7FEV1HbQHZwzCXjSR0OjHKecfxd5dS/3gk+
         QkV+Ng5Jp0Ovi/fYEPMqNeLp04vzv+vq4oQCP3fet5eAkkot5xCo3xJaIqaok47DdCZH
         zzhq5hfWIolGaQeN5o+TFD9XzZHn05CBGaRjF3pQsb4PB89OFASMDauOl1E4Q+tlJs0L
         ZjSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727904116; x=1728508916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kxVheSzFlnS80SxE0njZ5VOYQVUqoAMG0WXxzYHDWdg=;
        b=OJgyXem1Ug7O6VPGrD7kcRe7BWFV2vxC8Pk1bjjUQCQ1ucVO39QsGS68xKXiTRQUIU
         saDdAGsLjYM2690lhlXHi3u7lkaz2VdtjdNXRmOSQPbZ+T2ej+6ApQSJKdUjaeiIUfEK
         K6b5a8yLy4JRsl5TUbX9V4yaHnHWl+WX7vSy2eA0LGF0K/d/fm0oQgp1GEDcLDMFEHtm
         jeU9h9rUDO4mxwgyw0XBeaxsM5YXofTqSTBXPjBOoN0jTNvac80UW8WSEZz44/w6M+yx
         1GrxFLtkGWjpZ0PeW7BS257NFW6jBPuZL26bmECxiw+g/y6yBhBZTLO1myQKg00WApP+
         wNhw==
X-Forwarded-Encrypted: i=1; AJvYcCWDCXoIlvcG6oOTexEJZgMchPFOYDf4m/kTGqWu9dN+FEqe4fC9qR+Nl/qf7eubuFMZZWm82PPMFhc0zM7/sFY=@vger.kernel.org, AJvYcCWnFY7FeZmDahQ+fcR3U+qSWvZVKikH23z53CFnA6OiomTMW0Va5xvI4du1FN8xiiaVkRrOfxf3serjSAvS@vger.kernel.org, AJvYcCXOGAurUzJgOMLiUFLISU+4vXwwPgJq1pD4CgNIxUJeBxekZtbxy2h7qaLEoHAbqu9+XJZ+gkHkAUnu@vger.kernel.org
X-Gm-Message-State: AOJu0YxAklHyKJj2jEO+Z5HdlM1i6uCnugvNfhzcGVFokFsG550o9jtf
	d5yDZajTdQNezac4MJWLEC1HYf3Kh31RdKWJ70txF5mwVlVnuWin4UsB0pak
X-Google-Smtp-Source: AGHT+IHdWqJLb/hFvPXvXZ+iqQx5fuwToMwyCpxkNMK+eLJRTemU9rsbmWqBGKs3AQVuEiFjWxw17A==
X-Received: by 2002:a5d:524a:0:b0:371:6fc7:d45d with SMTP id ffacd0b85a97d-37d049dd551mr580117f8f.2.1727904115408;
        Wed, 02 Oct 2024 14:21:55 -0700 (PDT)
Received: from void.void ([141.226.9.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d04e29280sm516323f8f.27.2024.10.02.14.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 14:21:55 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH] docs: backporting: fix a typo
Date: Thu,  3 Oct 2024 00:21:50 +0300
Message-Id: <20241002212150.11159-1-algonell@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in documentation.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 Documentation/process/backporting.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/process/backporting.rst b/Documentation/process/backporting.rst
index a71480fcf3b4..18e41e76ecba 100644
--- a/Documentation/process/backporting.rst
+++ b/Documentation/process/backporting.rst
@@ -74,7 +74,7 @@ your source tree. Don't forget to cherry-pick with ``-x`` if you want a
 written record of where the patch came from!
 
 Note that if you are submitting a patch for stable, the format is
-slightly different; the first line after the subject line needs tobe
+slightly different; the first line after the subject line needs to be
 either::
 
     commit <upstream commit> upstream
-- 
2.39.5


