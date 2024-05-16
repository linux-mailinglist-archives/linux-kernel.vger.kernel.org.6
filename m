Return-Path: <linux-kernel+bounces-181539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9198C7D62
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 21:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23E872822B3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 19:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684C515746A;
	Thu, 16 May 2024 19:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sWHzItkG"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE830156F55
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 19:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715888466; cv=none; b=hmszi4GB5vrbdF5FUkiY/2zhw3NUhpjiYCZcR9tutmnvGP1q3HnMn5i5TMj0U7S3XJ/IxyjfzhE5f0LaWjbrMzgwORzVmwqoHM0GtkPKP5SBiNKhPiRKLiS+o5vQMsjCOQeUW/nudg22WwkU0oRgV+Wk/KL83w+A4BjqCd2+Qyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715888466; c=relaxed/simple;
	bh=qRGrAjcAOw/BpdIDpIw29VUbCdUpk5nCvIPyhVcCtco=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=m8pWQkI0dnPSb51ThdTLTxNpbwNfxZEE4H7xU81W5aGNPWbbnK9OALn7COO7ck88sr/nXd6RO/yVRtY38ExEeLZ8O0kod9QQvvi7IPCHvL/a2ftM72aItPVat4SjBMp5fxwbJV/X69AnOH9WRM/EcHezJ/waz00AjFWWdLFWZxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sWHzItkG; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6204c4f4240so134014407b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 12:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715888463; x=1716493263; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e1P6Db3qkzX3owazVizLczKyUZgazBAYnFdo7ANHUs0=;
        b=sWHzItkGsGuUcWNOxHQF3Ctt3honpuyXin7TXnIw6s5PN6d/3ojvgknGkawPtGAWuz
         Nfy9MQZ+fO5xRSjPAJrK6MjYZDpqOCPQpn1xvm7qHEkv4o7WI6dfXPyxONWZc9358Z5S
         80XxFwYwtxU9+Td8F7wcyZh+fqL8/iuUO0yUgG/+SNMi6RvaJKy+OE0yfStjZrwNsr+9
         8Zwbw0Q2thAu5A+tfUyAP832Ww7XGzXaKopSI3WX276AYxVCWC5RmiGrptMImtWYIZbq
         Sqa7Kr5qQDg0StHwcTIoX61pJQYDqvO9vLyLOr51QKSCAHVMWRmCdeWnaOXnOUFoQhOy
         hDoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715888463; x=1716493263;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e1P6Db3qkzX3owazVizLczKyUZgazBAYnFdo7ANHUs0=;
        b=uqtpyT6pwS+jvNrLA6gWBeN/YlmVEaDK3JMM+U4bk4lS4O6IzLqzGe/eBHF9J4Hkn4
         UAT8ws8LkqoX7x4JkerPR7fODpJLgl03rGTQHE9u5dyGF65DYHs+wVSFFph9VyN2hubP
         5C7Ze5ZZid84SQ1H59nFhoApXAK4N+fjv5jtBkCrGJqMdViviqsOiiZS3lmPhX9WF6Ra
         CRRTu6EcvDUAOjtawhcpS3/KkezGUUeTJWLb7UVR1ivnpBu3FMZAIgp/4Lw3jvrBD1E2
         PKpZD4SKgWp/HJG+saPeRA2jPfZTbDokRUe90cpbT2iXRWIxH6KOyhXjmDUZgb6qD/r7
         z/fg==
X-Forwarded-Encrypted: i=1; AJvYcCX227He+ONoIisSGFF1udEzKDPh1q5SfsFIv/dKY2bo8s8eriEW1wOLDgpIjHHkmL1Xnjk6KBsuijYY3nKv1ymWDicKu+tPR4nczZ+8
X-Gm-Message-State: AOJu0YzKKQBR1zTf701ufjHJt7oKh/HFRE84WccWw6cr6IQsjqOwi5oK
	wlingnaYVhS0LwOeFwG1dc11YKoGwOP6DunDaY1fo4qfwAIcjMMwu15265MUMwVNMn8FKFC2YAK
	0ude1lMGI6A==
X-Google-Smtp-Source: AGHT+IFN8NHYHCx0Mp5JwPViDfrjX4xtgJESmyjLorrTrnPM7FlMf7IPZ+ZzzNyfzySoyjQbNXwc78fPagVkYw==
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a05:6902:1142:b0:df1:d00c:130c with SMTP
 id 3f1490d57ef6-df1d00c1507mr450667276.5.1715888462994; Thu, 16 May 2024
 12:41:02 -0700 (PDT)
Date: Thu, 16 May 2024 19:40:53 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAERhRmYC/x2MQQqAIBAAvxJ7TlCxwr4SHUy3WioLrQiiv2edh
 jnM3BAxEEaosxsCnhRp9UlEnoEdjR+QkUsOkkvFC1Gy6fC0M7suG834cTHeRea0VrxSvZUdQoq 3gD1d/7hpn+cFped4W2gAAAA=
X-Mailer: b4 0.14-dev
Message-ID: <20240516-kunit-compile-commands-v1-1-86e61857c820@google.com>
Subject: [PATCH] kunit: tool: Build compile_commands.json
From: Brendan Jackman <jackmanb@google.com>
To: Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

compile_commands.json is used by clangd[1] to provide code navigation
and completion functionality to editors. See [2] for an example
configuration that includes this functionality for VSCode.

It can currently be built manually when using kunit.py, by running:

  ./scripts/clang-tools/gen_compile_commands.py -d .kunit

With this change however, it's built automatically so you don't need to
manually keep it up to date.

Unlike the manual approach, having make build the compile_commands.json
means that it appears in the build output tree instead of at the root of
the source tree, so you'll need to add --compile-commands-dir=.kunit to
your clangd args for it to be found. This might turn out to be pretty
annoying, I'm not sure yet. If so maybe we can later add some hackery to
kunit.py to work around it.

[1] https://clangd.llvm.org/
[2] https://github.com/FlorentRevest/linux-kernel-vscode

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/kunit/kunit_kernel.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 7254c110ff23..61931c4926fd 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -72,7 +72,8 @@ class LinuxSourceTreeOperations:
 			raise ConfigError(e.output.decode())
 
 	def make(self, jobs: int, build_dir: str, make_options: Optional[List[str]]) -> None:
-		command = ['make', 'ARCH=' + self._linux_arch, 'O=' + build_dir, '--jobs=' + str(jobs)]
+		command = ['make', 'all', 'compile_commands.json', 'ARCH=' + self._linux_arch,
+			   'O=' + build_dir, '--jobs=' + str(jobs)]
 		if make_options:
 			command.extend(make_options)
 		if self._cross_compile:

---
base-commit: 3c999d1ae3c75991902a1a7dad0cb62c2a3008b4
change-id: 20240516-kunit-compile-commands-d994074fc2be

Best regards,
-- 
Brendan Jackman <jackmanb@google.com>


