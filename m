Return-Path: <linux-kernel+bounces-518151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F339A38A9C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 18:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F51D7A4D05
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0262A22A4D6;
	Mon, 17 Feb 2025 17:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jj9vFBkG"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A203B22A1D2
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 17:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739813543; cv=none; b=mXFxYA/wpaZ7prbLdCi6MssyjnxRVkL56uIKG8y3vti///YDmvAf4twUT0ZSATlAudwKEVCv4ewRleC5Owi23P7WLtHKjKvyEWVJIYO2qMWd75jlfYYRf3C/fImrY/ixqbZvAK3PHfqBhVCPdemsEKaZr0+gA63hek7usvnbCYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739813543; c=relaxed/simple;
	bh=fvmuqW/ZJcAD4hBEbeETgZmg0Ls+GSH5bz6gAvA8Kl8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QttbFiGign+1Z5411I+ei42RScH/0pansSO3JLZldYppRQwGS6eJrMMtbRsj9r3UoDIBsJKi5EUp3aEMqlOWqlRs7nEWi04hfSor1fDWz86U47+gYYisp1wTkPasa+2BpkhaokfD25Xxl25M2zS9kkLylQeGcE3pDWu5jkuEs+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jj9vFBkG; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4395f1c4354so33988555e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 09:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739813540; x=1740418340; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ic6fNEiwqUaErdD71Z2ghM25Q6o0kdjhWc5qDhK+hac=;
        b=Jj9vFBkG3dFcGvZ3+/S9loRQ1r7eBExmhORc0aZApkv4zWo2Hvxv2MKjY00QC1RpyB
         qIvvNMPY5UMK//ke8YezsXod5dtEUcrxpQMaINQbl3VVETlOBOPEToRxqFemxoLhPsHd
         7aLYKU5c2pvuVJf84e3SlKZhvAxRblmvBvXmrbRHlRFJsdW6RaHoD+NmOAm6GNBU5ZZc
         ycnrRSm1ddo+XRQjZ+i2urrPKjU/bRM1REp7O3p4iu9HEqPldzDyaKmXkXZrEIZ30kZC
         C9h6XV/gyNGr9uIL8BCp+qqSjYLYk8yizJj5VbAfIG+2AU1h7EPAFJkG29Glu0Oa8zLN
         CAAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739813540; x=1740418340;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ic6fNEiwqUaErdD71Z2ghM25Q6o0kdjhWc5qDhK+hac=;
        b=MpivLacjJW0xZJAeYAkS2oqEoCtmijg0zjZcIsOAYfmtQz3UqBdbk6C0YePDESrtAN
         YQeRxxQ6tDlsl6YuXhnHWo/hC0N4KjI8ljU1EYv1yCOB9iGs1wxkKoPR1oKqfFEDBvwF
         3kDN2fh+Bw2QDPdzgjvqyTcryotMvuHZgkkH+zu3H/1Paqpv5KghGEi7ciOCa6JVadfb
         8l57Hg06eRKZt+i3YEnEsYmPzjGs4x5kq8sl7dElFFjl9DUXKfQqoGMfh+RlRvY9NCX1
         cYzrjuCqIDQe68qjxjw3Vnk/oah+/v36O1O2NRrdsejf6AVntminiplhTyXWYLZ1L69X
         hKMQ==
X-Gm-Message-State: AOJu0YwF1uYNj8//aNrxNMpE15gxBZgdNTdeV5OIb6S2tHsm3ovaIcjx
	y2QvdF6GolK9bsXveZRCE4Q+fW5yhIbV3swUw9j7pSKqQtBDKmVngA4/RWO7o9GFrrfYhBebxfo
	XDMv5P2OoBw==
X-Google-Smtp-Source: AGHT+IEUB5VYAl8bmIXMGqW69eXtwaGsaDWcb614PTtxJRb1TT3XkkKinci/ZFXonR2CvEBlhUlN4vZ1Hw9fow==
X-Received: from wmbay14.prod.google.com ([2002:a05:600c:1e0e:b0:439:5f8f:6597])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1906:b0:439:6dba:adfc with SMTP id 5b1f17b1804b1-4396e70a3e0mr100329665e9.13.1739813540086;
 Mon, 17 Feb 2025 09:32:20 -0800 (PST)
Date: Mon, 17 Feb 2025 17:32:11 +0000
In-Reply-To: <20250217-checkpatch-ignore-v2-0-ecfb50e03bb0@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250217-checkpatch-ignore-v2-0-ecfb50e03bb0@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250217-checkpatch-ignore-v2-2-ecfb50e03bb0@google.com>
Subject: [PATCH RESEND v2 2/2] docs: checkpatch: Document checkpatch-ignore feature
From: Brendan Jackman <jackmanb@google.com>
To: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, workflows@vger.kernel.org, 
	linux-doc@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

If included in patch descriptions, this will function much like the
--ignore flag.

It requires some rather obscure Git features to take advantage of
this, so provide some examples of how to do that.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 Documentation/dev-tools/checkpatch.rst | 46 ++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
index abb3ff6820766ee0c29112b256bcc44ce41fffba..6215b24b25b36709c815cf08de33f1609c80c0c7 100644
--- a/Documentation/dev-tools/checkpatch.rst
+++ b/Documentation/dev-tools/checkpatch.rst
@@ -12,6 +12,49 @@ Checkpatch is not always right. Your judgement takes precedence over checkpatch
 messages.  If your code looks better with the violations, then its probably
 best left alone.
 
+Inoring violations
+==================
+
+As well as the --ignore flag documented below, violation types can be ignored
+for a specific patch by including a block after the "---" in the following
+format::
+
+  Notes(checkpatch-ignore):
+    TYPE_1,TYPE_2
+    TYPE_3
+
+If using Git, you can store that information alongside your commit using
+`notes <https://git-scm.com/docs/git-notes>`_. To set this up:
+
+1. Configure git to include the `checkpatch-ignore` notes ref in formatted
+   patches::
+
+     git config set format.notes checkpatch-ignore
+
+   If you use checkpatch in `--git` mode, this isn't necessary, it will include
+   the `checkpatch-ignore` note regardless.
+
+2. Configure git to persist notes across amends and rebases::
+
+     git config set notes.rewriteRef "refs/notes/checkpatch-ignore"
+
+   (To enable this behaviour for _all_ notes, set `refs/notes/**` instead).
+
+   Also ensure that `notes.rewrite.rebase` and `notes.rewrite.amend` have not
+   been set to `false`.
+
+3. Now, to set the note on the HEAD commit, use a command like::
+
+     git notes --ref checkpatch-ignore add -m "TYPE_1,TYPE_2"
+
+   Beware that blank lines terminate the `checkpatch-ignore` block, so if you
+   use `git notes append` to ignore additional types, you'll need to also set
+   `--no-separator`::
+
+     git notes --ref checkpatch-ignore append -m "TYPE_3" --no-separator
+
+To see the names of the error type in checkpatch output, set the `--show-types`
+option.
 
 Options
 =======
@@ -114,6 +157,9 @@ Available options:
 
    Checkpatch will not emit messages for the specified types.
 
+   Note that violations can also be permanently disabled using the
+   Checkpatch-ignore patch footer.
+
    Example::
 
      ./scripts/checkpatch.pl mypatch.patch --ignore EMAIL_SUBJECT,BRACES

-- 
2.48.1.601.g30ceb7b040-goog


