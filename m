Return-Path: <linux-kernel+bounces-545566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B85A4EEA8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 21:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D3E21736BC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B5E25FA0A;
	Tue,  4 Mar 2025 20:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P9Phi7bb"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789642063F3
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 20:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741121129; cv=none; b=tSjxw3htYd7cYWKEMNTOUhK2CKPL52vMsexHcuGq0OoUW1/IF2OEtkjOVW/WQ5Dqmpcp5m/U76coDCCcmWAFUpR/J4onAQ/qCLULhuCDz7QMVPyOP6GqhaeGrFavaj93Gr/VAO9eT5zC2J/C3ENc58ZkEXRCf2XS0UKC9E2uF4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741121129; c=relaxed/simple;
	bh=GBTYcWM988+PKQB7e+LWCSDv1bTZ9jOTHc6PlHK11LA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=TSo4vF2OiOvsFfUy8ghgSS+JTbhl9I9zxcHAALFKNkPbFSDzzGK8egAz4zmOKDuuvTrJ+hURI1OSbspmOZj9EuvXMz5kHmf6Dnyp5B9QhCgPe3OtLObNaxgvW6snxkUpyHz2d2uxjeE3qTlGhqSV3Sl9KdbmXQ/xy1shRnt3IKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P9Phi7bb; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2217a4bfcc7so104731315ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 12:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741121126; x=1741725926; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O/h3K1VAjVU+85Yct7CoBzw18CRZr0W5WJZ0048JDtU=;
        b=P9Phi7bbhFM4EUHnYOBI5owmxpoPMASwmpEAEortBpeXyhguguVeo74oFZX32R0DFx
         NZYokAQqSWjyAkjVNutE3quPraDyc83tLUxNKKuWUvVW7rTsHbuJmfexN2mvZSLoAd59
         S4xNSB75SncT6uR8Z6VJ5AftCR+yiSS0tiiRBBbQ3dsVluysmuc6IUO+7qLHGDJNSc0P
         W5jqD2nCV8Flts8qSfFkUOd/5fUqSpCvFMksjqSr68u8xcnjcUgJb3iP28+S8xwGN8UO
         tsftjoh5zCrtD4HFeVPlttOphg8sJdCKnqmpb9Q+qu8mpDuBaTDhR0BkiDzKSWEbv9xT
         88Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741121126; x=1741725926;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O/h3K1VAjVU+85Yct7CoBzw18CRZr0W5WJZ0048JDtU=;
        b=brcl65RGbOmDwFONTVvT2ei9XYL+l2/u3p40KA0F/k5wl0ReCIkbBSbDbfOmh4NRCR
         z514SceJmD4yiH5qDKfqHo9S5Pe98gAb3Rf126PNOzKQORAdKeSv3MsSb5VBsgmPImra
         ZDD2ioI+Cnn/fHNRV/N7fixgCqG1tCzs5TrNrwUYqRUSMyXX9TwQb5oN63atEWDBm2or
         BJqYCZn2qTW1zuKcNQ81yNByg9XOCzQa5NWg09DJ9mQVC691cla//wYsM4Clf7MHQWUO
         7mAvKAcfRWVA20H0wjmwynS5fQgrZ40a4e/wLNtooZunaU5/4q5uyFM1R6E3mdpMYdkp
         +FeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLdniE+o0MFwqwpx7tRziAIPJghj9Fb4lKPnQzs+VFR/wCVqJ2app8No6gQu5h+aMwKtPszx10EzCsVzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX6kd3u95NsjN5udFXNdIV9tS/cTlilq1nUnAwdi9HL1gMgOcD
	DCDZ6iYuWkrnq+FijCE2yhVwb/gkgDgONucCztq7kmeM62s9sBl4nAY0cYrzhDCI+gUdTp8qfVB
	N2rcNzXata2J35A==
X-Google-Smtp-Source: AGHT+IEvAad14fuI/QYpN+y45DYnXWvF1S16Js2zs5xq9qmOkzSmCsB9Vo4K4dzj+al9VXMxX9NcMQF4YzW17IM=
X-Received: from pjbkl12.prod.google.com ([2002:a17:90b:498c:b0:2ef:7af4:5e8e])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d50f:b0:223:5e76:637a with SMTP id d9443c01a7336-223f1c97445mr7020845ad.23.1741121125659;
 Tue, 04 Mar 2025 12:45:25 -0800 (PST)
Date: Tue,  4 Mar 2025 20:45:19 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250304204520.201115-1-tjmercier@google.com>
Subject: [PATCH] bpf, docs: Fix broken link to renamed bpf_iter_task_vmas.c
From: "T.J. Mercier" <tjmercier@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Dave Marchevsky <davemarchevsky@fb.com>
Cc: "T.J. Mercier" <tjmercier@google.com>, bpf@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This file was renamed from bpf_iter_task_vma.c.

Fixes: 45b38941c81f ("selftests/bpf: Rename bpf_iter_task_vma.c to bpf_iter_task_vmas.c")
Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 Documentation/bpf/bpf_iterators.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/bpf/bpf_iterators.rst b/Documentation/bpf/bpf_iterators.rst
index 07433915aa41..7f514cb6b052 100644
--- a/Documentation/bpf/bpf_iterators.rst
+++ b/Documentation/bpf/bpf_iterators.rst
@@ -86,7 +86,7 @@ following steps:
 The following are a few examples of selftest BPF iterator programs:
 
 * `bpf_iter_tcp4.c <https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c>`_
-* `bpf_iter_task_vma.c <https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/tools/testing/selftests/bpf/progs/bpf_iter_task_vma.c>`_
+* `bpf_iter_task_vmas.c <https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/tools/testing/selftests/bpf/progs/bpf_iter_task_vmas.c>`_
 * `bpf_iter_task_file.c <https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/tools/testing/selftests/bpf/progs/bpf_iter_task_file.c>`_
 
 Let us look at ``bpf_iter_task_file.c``, which runs in kernel space:
-- 
2.48.1.711.g2feabab25a-goog


