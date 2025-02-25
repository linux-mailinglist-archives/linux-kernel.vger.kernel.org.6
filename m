Return-Path: <linux-kernel+bounces-531423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA91A44061
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9DFE19E0407
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8113D268FE9;
	Tue, 25 Feb 2025 13:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NBAza7K/"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C8E268C40
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740489049; cv=none; b=PqPFrY/7RCd8Szl4Vp95TErp5a2UUOrtVUTYxjWsLjjrWc6d0kaXobXrsScPEFeisHB8ewze9H9sVRGArcIZRu/zFu4qAqrT0KwiqNsbU5Y9b6DUkLjBegrgB3N0Hp5RIGNqqIdVhG8eAF7jAEMtXs02CwwlNWPpuujYu6ZEgpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740489049; c=relaxed/simple;
	bh=5YEF+jstnWy7/0vubwbJg7dOnf1P4zQx345sO6nYAWw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eQYSg9W06F/YTTtxZJydM/Uu/K+hb7oMhG2u1pp+KvpwpetulQg47QL+rHZpiCQwfeKFR4KeGd5e5OU+HRkbby4HZmE0GCYIRUL9A3oUhLradWJ2Yb12TEDbZf+/jtBdqUHZQB7a6iJrGP08VoU1GDJGPZ8ceK5uPJYhnfEcoN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NBAza7K/; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6dd1962a75bso43322326d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 05:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740489046; x=1741093846; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IkagoJjJX//F8ZAz8tjpxEvWJOpdWzJAPbQJpEIxATI=;
        b=NBAza7K/oTqn5OCcFwJ6CX3QoWa12k2ihcnTn6hAZEF4ErZIhPUIORvgwK6PgpT+Tk
         5Dz+ZXlnJMmxzghrffOacS3nXN9lUsZlKaDWjQChUzkul745kR/MOBomgh+Z+52+hcWv
         33ZOeZRX7VG38L5aaK26fBwVXi2FPrX3k+r8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740489046; x=1741093846;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IkagoJjJX//F8ZAz8tjpxEvWJOpdWzJAPbQJpEIxATI=;
        b=VFhMw6xvP6+v3Kne5VWmSG7h33eL5XWCO/v3HJNerWgGh3Jry0AYz3hrqJ2itYX684
         uRqyrsJkWcTNsjZp0FmQZ1sLGltcb0Ux6sez/sx4v45/kpoCcK4oA7JOrnluVzTPJC/K
         6QIah8+zSwalUfsJzz6kYH1j2AUkKwdw7vO9YkhoNOBxcewg2q8DCuAZL8csq+IWGDPQ
         ITLZUUZrpyKd2Ck7ifnEMRdRPqo5hEGuqXp5cDz20WhqwuL8Phb2gcmJ+0DzhVyBZfMG
         wrqo/FjIw7zCZeM1cZSO7NkZ79a6eh013wJI1v0kiXPQCJRY47+bNliGE0NPM3JClLT1
         osWA==
X-Forwarded-Encrypted: i=1; AJvYcCWmSO63VNkE9ROIMEM8PXrFQymasrgWgd39KfTET3y3BqfSQzKnRIyXea2ndZFTt7UE7ZCBfaeKyuzU4ek=@vger.kernel.org
X-Gm-Message-State: AOJu0YweiC1qCzbpW1IlX6EVEuiujNdI8YRgMoDVj8qQ3CN2G1NyVY1e
	7ZdTRG57bhEfOB6PrBCE3dJ4ZALaN9ad3TvTQc9kZlR+xk2wKTy6aVF+7T32Fdy23qCIbbU26TA
	=
X-Gm-Gg: ASbGncufQ3Z7qwQEC5pKSyawhodkQNVpxb85dOkGfQPm0CnjrSZXawvLUJ4XXd8u6bp
	IhPE21HbVXRJy9gB8+uFhxppcxlGE9E+qTMZDLaain+tRPImNNIfB9arPgfgxd7IpzZYIFItbnm
	mo1rXxqarwTDm2DSm4u53Tzvnb/uQz/7sNIgRxepxAEYiCqJzFtcvsTYrFEaYptdQMajHJJ5uj9
	Pq8BnNPJxucVN0pVacIcxDRiXL9hJrtanzzyzo2AKCWH2mlGyQkFSMgoBK7/ceU39tw4S8Foz7s
	sJWuQrcctYap+D6ib4c/kGFw77Fwysi4+xoR8zRHW2WnP0rRJ50wgYD0oB+MSRxe3+yAT8Ooxrw
	4es0=
X-Google-Smtp-Source: AGHT+IFStKQAwWRvJwouI6DTl4jomer8HvasLLUepvoeRNew+SRO7KoDYWAAQMXggyGTsUqWvxI86w==
X-Received: by 2002:a05:6214:c2e:b0:6e6:66a6:558b with SMTP id 6a1803df08f44-6e6b010ce3cmr238375676d6.22.1740489046280;
        Tue, 25 Feb 2025 05:10:46 -0800 (PST)
Received: from denia.c.googlers.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e87b0871d7sm9263656d6.28.2025.02.25.05.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 05:10:45 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 25 Feb 2025 13:10:41 +0000
Subject: [PATCH] scripts/spdxcheck: Limit the scope of git.Repo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-spx-v1-1-e935b27eb80d@chromium.org>
X-B4-Tracking: v=1; b=H4sIAFDBvWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIyNT3eKCCl1jC6PkNFMTY2Nzg1QloMqCotS0zAqwKdGxtbUAChz0rlU
 AAAA=
To: Thomas Gleixner <tglx@linutronix.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-spdx@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.14.1

If the git.Repo object's scope extends to the Python interpreter's
shutdown phase, its destructor may fail due to the interpreter's state.

Exception ignored in: <function Git.AutoInterrupt.__del__ at 0x7f1941dd5620>
Traceback (most recent call last):
  File "/usr/lib/python3/dist-packages/git/cmd.py", line 565, in __del__
  File "/usr/lib/python3/dist-packages/git/cmd.py", line 546, in _terminate
  File "/usr/lib/python3.13/subprocess.py", line 2227, in terminate
ImportError: sys.meta_path is None, Python is likely shutting down

Use the `with` statement to limit the scope of git.Repo and ensure
proper resource management.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 scripts/spdxcheck.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/spdxcheck.py b/scripts/spdxcheck.py
index 8d608f61bf37..eba808cbaeeb 100755
--- a/scripts/spdxcheck.py
+++ b/scripts/spdxcheck.py
@@ -349,11 +349,11 @@ if __name__ == '__main__':
 
     try:
         # Use git to get the valid license expressions
-        repo = git.Repo(os.getcwd())
-        assert not repo.bare
+        with git.Repo(os.getcwd()) as repo:
+            assert not repo.bare
 
-        # Initialize SPDX data
-        spdx = read_spdxdata(repo)
+            # Initialize SPDX data
+            spdx = read_spdxdata(repo)
 
         # Initialize the parser
         parser = id_parser(spdx)

---
base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
change-id: 20250225-spx-382cf543370e

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


