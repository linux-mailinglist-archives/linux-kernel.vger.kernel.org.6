Return-Path: <linux-kernel+bounces-518149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 185D4A38A98
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 18:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA7B016A0FE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C5D22540F;
	Mon, 17 Feb 2025 17:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hIMBKmnM"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A82D528
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 17:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739813539; cv=none; b=X5pBinrNehx60aX29hhghy4eNebBcW8dmtDL+EYjaLIPS+yjaCAjViKz1hDvDoEdvCo3FV5O9Q6em/ZvZn7EJDbOv/3i2x/gwgoHtkJ0NFA74EnwKKOJmMlz6+yUjun/APaLc+QRhQAr0tAPm112vFW7oZJ60xXzRIlroP7IfNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739813539; c=relaxed/simple;
	bh=KFP2R/TEoQs/HPOcYZBYMz6WTXXfGWe3Uff7RYjgJzs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Ve/AN3MHnALKnYfL3/PCyoLfpNmEgyewRPA69ljbJY8pX9Sdaa+KTDn1oab2nGhjFNg/7FkcamVyt77D+vyGIhcFmlGaOC2wpMNpdQQCKLYvSDTUIDItDXrUVlCd9fJ7c1RQ7l71uuWdCc9DPqedbnCsVNF2TLQCfx5BaG7bCV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hIMBKmnM; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4398a60b61fso4702755e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 09:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739813536; x=1740418336; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BJBiaucnVrlyZGdfwKV5yu0lTpLHyTZbtjA6zJmjN0c=;
        b=hIMBKmnMtD+YOsMjjRNrOgEE2I3dhBIeC8ofHAoIw48Xy+aKeSIlWhzTvBS0a+LAcn
         hAYLynhsgdYXRfWDTmSmy3O+ea6T9wLWSZDl7VaDUqr6XmGND4KunpaNI3PV0MGtWG84
         s5OdKoJvnxFt+03PYwYfD/5lZbyaYb5g/amWstYroX5jCrr+Oa8U4x+SN/yOoNYZUu71
         wyuUjZcXKrUMj5JjxaIyRr4DMYEWdefMnmPZzJ+OTVOCRyW+6E2iWTb4I6icLdISeMXi
         iF2kgqm9Km4Uw69dwOQRrai0K62qWRDvH++4M2aB4ay2nuPZgL+z7nwit4wQLsOtu5VT
         iVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739813536; x=1740418336;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BJBiaucnVrlyZGdfwKV5yu0lTpLHyTZbtjA6zJmjN0c=;
        b=ZSsHAsMrsXWeibBY2POYyVHEkOOOD9azBGg34b0KAtBwN2xrQ8etM8AdruAgzYB91a
         xqOdLrnOvPYx/WQOKHuLSmRNJHmmRoAkdpdxrexq6XsqFiW1IwzI1Vk/ASGX7XjY5kNM
         ZHZU6Y+NL9gGohacMdZiLxIyRA9FlXLLPEW9OZKjibKP8vrJWA7tl8EN3sjSbcX1Y5uz
         XpQJf7utB9I0lVhP4B8Wn4iNdPdkN5NjXCHVrI5xKXm0x6hFPvZTNn6ik55AHHcKnKIe
         znY6FH3mDThZeJUdGZ3ZC4AZfql0Ex7P2VyReGlsSzEX47YAKJLtlysNzL/ByOq04Xau
         wL/w==
X-Gm-Message-State: AOJu0YzDo6klXfjNJnX9L2SizNlINKZzDaXReqT2GaLh5XKVRB7KFHlU
	hglMw/xbVHwG8agh9W1xm5tu+fzPK7e5s0ibNdqc6t3mZmeBtss1rM4s9pjQX/j6dLETg4lMXvV
	dNdFan09DAw==
X-Google-Smtp-Source: AGHT+IE5jPgEVsSxIuJGXGUw+3v//iF2J6brAaVYjtJIUEC2xhRWmWP+EKgasIeGSMeRMeIDp9K4HtBhF8fANQ==
X-Received: from wmpz21.prod.google.com ([2002:a05:600c:a15:b0:439:8cc3:4f3b])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:870f:b0:439:84ba:5773 with SMTP id 5b1f17b1804b1-43984ba5989mr45001175e9.31.1739813535785;
 Mon, 17 Feb 2025 09:32:15 -0800 (PST)
Date: Mon, 17 Feb 2025 17:32:09 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: b4 0.15-dev
Message-ID: <20250217-checkpatch-ignore-v2-0-ecfb50e03bb0@google.com>
Subject: [PATCH RESEND v2 0/2] checkpatch: Add support for checkpatch-ignore note
From: Brendan Jackman <jackmanb@google.com>
To: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, workflows@vger.kernel.org, 
	linux-doc@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

Checkpatch sometimes has false positives. This makes it less useful for
automatic usage: tools like b4 [0] can run checkpatch on all of your
patches and give you a quick overview. When iterating on a branch, it's
tiresome to manually re-check that any errors are known false positives.

This patch adds a feature to record in the patch "graveyard" (after the
"---" that a patch might produce a certain checkpatch error, and that
this is an expected false positive.

Note, for Git users this will require some configuration changes to
adopt (see documentation patch), and not all tools that wrap Checkpatch
will automatically be able to take advantage. Changes are required for
`b4 prep --check` to work [0], I'll send that separately if this patch
is accepted.

[0] https://github.com/bjackman/b4/tree/checkpatch-ignore

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
Changes in v2:
- Switched to the "graveyard" instead of the actual commit message.
- Link to v1: https://lore.kernel.org/r/20250113-checkpatch-ignore-v1-0-63a7a740f568@google.com

---
Brendan Jackman (2):
      checkpatch: Add support for checkpatch-ignore notes
      docs: checkpatch: Document checkpatch-ignore feature

 Documentation/dev-tools/checkpatch.rst | 46 ++++++++++++++++++++++++++++++++++
 scripts/checkpatch.pl                  | 34 +++++++++++++++++++++++--
 2 files changed, 78 insertions(+), 2 deletions(-)
---
base-commit: 619f0b6fad524f08d493a98d55bac9ab8895e3a6
change-id: 20250113-checkpatch-ignore-1096914844eb

Best regards,
-- 
Brendan Jackman <jackmanb@google.com>


