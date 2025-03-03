Return-Path: <linux-kernel+bounces-541031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF64A4B7A5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 06:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C7147A5499
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 05:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882271E5707;
	Mon,  3 Mar 2025 05:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wq7kVt2+"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE3B1E5B99
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 05:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740980269; cv=none; b=u7gpaSYnBYee8mYhdBRZWeL/eSj0z1/+j3S5AZcu2F6sFmLVPMxmZzT1Ng0sX999f/0OIPvRPrvve+TX+LMSRKfiNHhfpat3gL/AOXjdPTCcZKKth1FkovREHWhtwx/ZaUgUhWf+/oN9PEGEqZx5R+EXarObE6FO5QYyBIwVZ40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740980269; c=relaxed/simple;
	bh=WaoyZuEwsQ2p34OHEBdLIzMV0xIL1iFyXsJfdPLGXbA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sHZOZIASjUWaJ7cxYN8UjELDpLot3GeGBXQK4vqEeoMyFddTS6TMxP7/S8h1Qth0AYHS+nDhhSRFGAGULH2jf36yDK4YwnxirY0SLwPzJhAghbWdUPhTFCo8FAiSiT53wWQHOIr+tLdVeD5ebWru9U5ree5qsjcmwkkJazowXAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wq7kVt2+; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fed5debb85so3000826a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 21:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740980267; x=1741585067; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xDRlPmyHtUNZ0yOQY1bkQ2kEbwvsRJ/+HMV3GdLKk6A=;
        b=wq7kVt2+pVCCbOzAjuWL86BQZ+WHkhF73Z0D6iP/N7eH1NWvQGljRGYfbwQ9jTcXY4
         u82eXZn+MhBCPDz69J9WNqtuxyoJpCyQpglDGukO658qOUE1Nn+aVCiiG5eRAAVUBdjR
         oFVUThxQ+8kOu6SsiRa0XkpYY6WCWC5PZN1Aep+HzEUY3XY87rwqdjhMMlI1ilLORaha
         +ZzhLAml+p/PMX6nmNN4th2znibxdEUSdBR0GcvmbCUVe7GiM1RI8WHlx1cHgz2YyivX
         GVyAoQ/QI0dib1gO0R4f2uZBqPjWHKNwQRg7NAZbzdccsuB52vclEak1b0NDG+0OLY3u
         UBdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740980267; x=1741585067;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xDRlPmyHtUNZ0yOQY1bkQ2kEbwvsRJ/+HMV3GdLKk6A=;
        b=OVkQ1hUtk7MQq35fm21MHIMIxqx3MHOW1jdTjIruXTW0ntJ+ZgA+q3lMC90Q5CT5d1
         BYs0fRHlyWzIcLEbu/7Q28bi3J5rsHO5QgSUUHzEcyWE+izoPcwM3nRHCo8GZJZrcE4h
         6ccyLa6jQ22jbY5XcR9Hw10A0DwB672iBZ81YLrHA/n85aBTPNEqLez7vakdOSalkWef
         tyTdmNK5DKcjL4SXz+u4nnyPZWj7d+AntdLgqbPl8hHh5y38it9XyrywVy9aVvhHcu/t
         UbNDXs7dEhvmVow/QffRU/rlw2ZabZLS/0DZ0BFa9NqHwll2pcrmnidW86CATz0VSYL7
         wI1g==
X-Forwarded-Encrypted: i=1; AJvYcCXYXoz3I2QpMxlyAdayGBVF5yeqlLxMNtPjUlUQ8OLR6A8js8eRnvSgUfzzhBB5aa1B0DqvFQek+OHbDR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU+dPX6vfv1GWKlAIhmwcE8BbkOejVpcUbJT/hTj/qpisYZKtv
	t7XdL2VSO2W/JvF2LsSKIjBBBXNWmbprUAjvTn5TFMBRnZdLzZd+BL+MACBEHbDCMApGujcFT1V
	xDeIy/zMwjQ==
X-Google-Smtp-Source: AGHT+IEyeR4LjO07+giiIXLMHgTNqF3xV9ys5aBY0UaUCNsB7smdHPPbNq89GHq0OP7YKsBN/rIFz4H/QXqJzA==
X-Received: from pjbhl3.prod.google.com ([2002:a17:90b:1343:b0:2fa:2661:76ac])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3ec4:b0:2fa:15ab:4de7 with SMTP id 98e67ed59e1d1-2febab3df8cmr22652320a91.12.1740980267592;
 Sun, 02 Mar 2025 21:37:47 -0800 (PST)
Date: Mon,  3 Mar 2025 05:37:44 +0000
In-Reply-To: <cover.1740978603.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1740978603.git.yepeilin@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <03ceb882fa759f503b3f4b7f4ff2a5ce69a0eb05.1740978603.git.yepeilin@google.com>
Subject: [PATCH bpf-next v4 05/10] arm64: insn: Add BIT(23) to
 {load,store}_ex's mask
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


