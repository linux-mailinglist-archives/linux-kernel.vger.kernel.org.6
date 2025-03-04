Return-Path: <linux-kernel+bounces-542950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD45DA4CFC3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 01:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AC4F1895FEC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 00:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75EC55228;
	Tue,  4 Mar 2025 00:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AM5wU7Yl"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711CB13AC1
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 00:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741047236; cv=none; b=JQqtGpX/7RehYU1Twk/A5sX2CK7QzhZOr6TIqYif4+2q2AgyO+1jJTE25fM1PK1HrSzdrOR0t8t+PxORpbRha/lYMiufacCa77YdTUisgS3VzvT1D0lS9nhrpfma5ys7Z31SBxEPsE/576RmSHmqogPiVAvVMMayFPvu58ERxek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741047236; c=relaxed/simple;
	bh=WaoyZuEwsQ2p34OHEBdLIzMV0xIL1iFyXsJfdPLGXbA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lriNrR3+oQu30e2BeN9FgSSLfA2ccxPz0uHYXy9u/R2nSRs6urArxBNUQjfdviteOdMF+615Z06cGyBD9SPifcJ3c6elecV+RwV6DxygIqgKgmh4h3FEpmx3gWBhUTzzoPr96azMgOwzhQKe104ussghdSo0h7JbuNQ7qBg7AcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AM5wU7Yl; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fee4c7ef4dso6987193a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 16:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741047235; x=1741652035; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xDRlPmyHtUNZ0yOQY1bkQ2kEbwvsRJ/+HMV3GdLKk6A=;
        b=AM5wU7YlYAqmAq1r0oaBA/et5eq5zrFQ2wDipwlboXVBha/cohT8LT7wf3+UiQYdw1
         O30uZ0AAtHdNilZiBcyVYHjN3Rg/JHCl1VDyp9jZ8c/6XMbQ2qOwk95Me5JEOhum809u
         Ljjp784MZ7sIYITag+cuaK5PJ4ytdyYSo5vxQmGWT1+T/rvM73W5ZJ3CMMAlx1s5GINd
         AhF3QD+wq5aB0UpCwvEYVwrjXfLcTWg9i49a/zJAcBK30NxeGtP3D6TClFd0e2bHcI39
         os4M85RnxD4Rlp+Aqf5Te/mkOODcN1zEcyimE3AkJStyLYZyoQYdXgW77SwfDoB8sCdK
         1l4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741047235; x=1741652035;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xDRlPmyHtUNZ0yOQY1bkQ2kEbwvsRJ/+HMV3GdLKk6A=;
        b=XxGASt10/mkp6i+v/OKy2fSnhcUxrmjY6hy0O76UFVyYnQ4AuRrZvjqmBBUqxwUqKo
         8T6wYSa1QBMqZiuoQ/hsBtvxNGdrZ+r/DAHeSpz1F2KHnME5HEBltsbFq2zLvx6+Y7uY
         Rssp51Al//i4OAg2z/OYANdzSi2BPFYgi6PPUFbCoaunalJAyqF41MnnMmu/VfGIh1tv
         QcjaGlljzWjLFZQVdcABtHxhpfUE25Lz+ky9Fbz0Hba+aUDB3HzmHtg2Dzt0IRPs/niz
         M7FQ4xBTBDV3zL3J1W2wSGvkHD/BXftFuVu3mFJf4LoorZWoM9ErmUgSijFpC2gJp6Hw
         8mGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOcJkvA0tqbYlaZFI9cQb/Jrszu+dJ6rsUvWUnz07ZJKvqIJ3MXJyvZo8/s5W3SrjoS79OeadT9YoMrns=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4WecLHeh1bfgo4o9Fx7EX6gA07rYmFB5EFp2uKMUxRNS655lJ
	vzV0r0a8UW2QVFqE4N7xPgnI3oGT1zke5GHF8IBMa8+YwoHXsxby/FJfB+xvk3p6ZwNpt4+f7uc
	aVUFdG8ih+w==
X-Google-Smtp-Source: AGHT+IEdt4cHd77mRMPQGhwekDKbD+CN7Z/qOgmO85qt0Zhy9STzN/3oNCxHzMYfYpYk9NYtUNA1zbaLFqDQeQ==
X-Received: from pgbdo4.prod.google.com ([2002:a05:6a02:e84:b0:af2:37c4:2ad])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3a42:b0:1ee:efa5:6573 with SMTP id adf61e73a8af0-1f2f4c9c8d1mr28131587637.8.1741047234794;
 Mon, 03 Mar 2025 16:13:54 -0800 (PST)
Date: Tue,  4 Mar 2025 00:13:50 +0000
In-Reply-To: <cover.1741046028.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1741046028.git.yepeilin@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <e64f97503ec5b0e811ce7ed3534cd754ba81fbc3.1741046028.git.yepeilin@google.com>
Subject: [PATCH bpf-next v5 2/6] arm64: insn: Add BIT(23) to {load,store}_ex's mask
From: Peilin Ye <yepeilin@google.com>
To: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Peilin Ye <yepeilin@google.com>, bpf@ietf.org, Alexei Starovoitov <ast@kernel.org>, 
	Xu Kuohai <xukuohai@huaweicloud.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	David Vernet <void@manifault.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Quentin Monnet <qmo@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Yingchi Long <longyingchi24s@ict.ac.cn>, 
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>, Neel Natu <neelnatu@google.com>, 
	Benjamin Segall <bsegall@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

We are planning to add load-acquire (LDAR{,B,H}) and store-release
(STLR{,B,H}) instructions to insn.{c,h}; add BIT(23) to mask of load_ex
and store_ex to prevent aarch64_insn_is_{load,store}_ex() from returning
false-positives for load-acquire and store-release instructions.

Reference: Arm Architecture Reference Manual (ARM DDI 0487K.a,
           ID032224),

  * C6.2.228 LDXR
  * C6.2.165 LDAXR
  * C6.2.161 LDAR
  * C6.2.393 STXR
  * C6.2.360 STLXR
  * C6.2.353 STLR

Acked-by: Xu Kuohai <xukuohai@huawei.com>
Signed-off-by: Peilin Ye <yepeilin@google.com>
---
 arch/arm64/include/asm/insn.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index e390c432f546..2d8316b3abaf 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -351,8 +351,8 @@ __AARCH64_INSN_FUNCS(ldr_imm,	0x3FC00000, 0x39400000)
 __AARCH64_INSN_FUNCS(ldr_lit,	0xBF000000, 0x18000000)
 __AARCH64_INSN_FUNCS(ldrsw_lit,	0xFF000000, 0x98000000)
 __AARCH64_INSN_FUNCS(exclusive,	0x3F800000, 0x08000000)
-__AARCH64_INSN_FUNCS(load_ex,	0x3F400000, 0x08400000)
-__AARCH64_INSN_FUNCS(store_ex,	0x3F400000, 0x08000000)
+__AARCH64_INSN_FUNCS(load_ex,	0x3FC00000, 0x08400000)
+__AARCH64_INSN_FUNCS(store_ex,	0x3FC00000, 0x08000000)
 __AARCH64_INSN_FUNCS(mops,	0x3B200C00, 0x19000400)
 __AARCH64_INSN_FUNCS(stp,	0x7FC00000, 0x29000000)
 __AARCH64_INSN_FUNCS(ldp,	0x7FC00000, 0x29400000)
-- 
2.48.1.711.g2feabab25a-goog


