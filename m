Return-Path: <linux-kernel+bounces-213753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFB89079EA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 19:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BE9C2829FD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F33B14A4C9;
	Thu, 13 Jun 2024 17:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f36hYXdC"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C02E12CD8F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 17:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718299920; cv=none; b=OMQP3bRUUqUR4aYcD/biEMYndOOsMts/1TB4jB3wQzOJ9Kf5lBvupiCjcB5UZ2WaY70vS4pz2x+F4agONBd3Rt2f8P1Jr5Uw1zqw7Zxdt8VEda7UIcmXN0dQOCHNjypwJPQomyHyVVyMjHzURIpypxmzvA/AhCN2ErRM3FFc4NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718299920; c=relaxed/simple;
	bh=xbE+/ETFeEQlT4vgIYucCFchmJYHLBJk8LKXtJ10G6I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UmhtHN1CY5uD6HSexvDe1UGH2tGgLX2IGxUCe8A5JnISFKXAgIPTWzLG1ZKZmwH8m5QV/mkjG6zT0MbFj337cU2gnLf7+Pmwkwu4QbnfdgWZUZlsGOd9MbVjUk+Cx2XeqKugzCvaiYiexNMjPp1w1h8vL+JCOqDYSxWpWUS0nU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--maze.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f36hYXdC; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--maze.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62fd1655e12so25913587b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 10:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718299917; x=1718904717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xcnrVmBX5qHwP9gdhcfAMKGSVU0cmZnsSa23d9Ql3w0=;
        b=f36hYXdCoURs7v2OpnN7QnGwpF/vmkr62VaKj48QClWCxAxzUxPkL/N/mvAwOAHh4s
         dSp/lNzvoVdQprX6AQWr79LlvCnxPDvgi14V9u1qkgAOZVo3rRBSQe/ftMQlMiITgIac
         K7PyvJ90kAODn1DdwlSl9rpkBQOgDGfP5ccyG8LstDPa9gUmVbL5a350Bc8Ip51Ryta7
         2GSSF+bQMppn5wwgSn6+WwGYQINGqYyj3laqoXEDrhPA/kXawHgyJXAffigBVN1JGsvO
         k6M0QfSM3YXHbAHWEBcG9rU7Mb0nYAtDY8ZTYwLrSj849ohmFQBJkP6F3FlQDLaF4i5o
         acwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718299917; x=1718904717;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xcnrVmBX5qHwP9gdhcfAMKGSVU0cmZnsSa23d9Ql3w0=;
        b=ApywVjdautmFPZAPncZIQ8nmvZhwkNjdscuF9Y14t5ILKgD1F+2bydaDW/K61YjeM4
         qTOLbTHjqFh1Y0KrgGiyrLG6uEyRL9oE2+s3H56FyN1nDcHoP54bgqMfW9eXDFgpGw9Y
         zUDINehqIHn1Wl7P9iCzm0JIZ8KldO47Om40ZkUpq6u9RT+4quz5XlUxuOSkANUNGjJY
         NcNHQ0CkrgSzifTgoA6R0LX72b/1dClq8NltRsc7wI8bBnpw67exNkt2h+D3BAM48frE
         dFwT14JQzJtpeJvfoUU6YByFfBR5FR5LpRQRdODpvpkVDDX235WWvWpJ0l74z9x9UOZ6
         E5JA==
X-Forwarded-Encrypted: i=1; AJvYcCWUI0cz61KI5CTnqj9MxTj8x9dwG0Swi+XAGpTqhL08dBBvV43F8XHEYAFzzdtp5umjEujVegun7hERFz2wGaXkmzVi3FpPB9fX2zel
X-Gm-Message-State: AOJu0YwDesf1CClHRQ7kEkKzFt3clz/pguKdep52EmM9PAflow8QCHvx
	Kti0EQeOKqICTW4zxy+faH3h2MZ4V23CSKbuTkQZMonRaJAiBAYy09lZOEe5C+kUenyuiA==
X-Google-Smtp-Source: AGHT+IF/EDbDOw9PfT/Z0FCcjwucpuLWvcOdvkfWpSLtmSbYw8wjEr28MzGUsEM1/rBoZK/ZAPLnjeS5
X-Received: from varda.mtv.corp.google.com ([2620:15c:211:200:31e9:ec1a:5b87:e9f8])
 (user=maze job=sendgmr) by 2002:a05:690c:9d:b0:62d:42d:5f63 with SMTP id
 00721157ae682-63223c4070fmr277607b3.5.1718299917421; Thu, 13 Jun 2024
 10:31:57 -0700 (PDT)
Date: Thu, 13 Jun 2024 10:31:46 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240613173146.2524647-1-maze@google.com>
Subject: [PATCH bpf v2] bpf: fix UML x86_64 compile failure
From: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>
To: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <zenczykowski@gmail.com>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, BPF Mailing List <bpf@vger.kernel.org>, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, Andrii Nakryiko <andrii@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

pcpu_hot (defined in arch/x86) is not available on user mode linux (ARCH=3D=
um)

Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Fixes: 1ae6921009e5 ("bpf: inline bpf_get_smp_processor_id() helper")
Signed-off-by: Maciej =C5=BBenczykowski <maze@google.com>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 36ef8e96787e..7a354b1e6197 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20313,7 +20313,7 @@ static int do_misc_fixups(struct bpf_verifier_env *=
env)
 			goto next_insn;
 		}
=20
-#ifdef CONFIG_X86_64
+#if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
 		/* Implement bpf_get_smp_processor_id() inline. */
 		if (insn->imm =3D=3D BPF_FUNC_get_smp_processor_id &&
 		    prog->jit_requested && bpf_jit_supports_percpu_insn()) {
--=20
2.45.2.627.g7a2c4fd464-goog


