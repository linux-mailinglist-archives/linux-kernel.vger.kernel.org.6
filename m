Return-Path: <linux-kernel+bounces-191077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DAB8D0639
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 17:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61EAC2868C7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF906535A4;
	Mon, 27 May 2024 15:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="tG/5HrQ9"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A08017E919
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 15:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716823903; cv=none; b=LBztgifniYUJnvFjM/PCMmKSh/JURALEMu0GsWddHt4EhnVCV7WclA/YrCaghYgk1008vuu4ZSjq8f/6Fy3XwndOiTWInepBOE+EvGRYOnBENKP5Qs6YNAMto52fNMiRIAeLDwKp4ASXVKSpKy3+pMc2DWWjdPlj2guPEw+GtVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716823903; c=relaxed/simple;
	bh=YLPkFL1mlRWGYN1/bZyo0fyQUO+Lu+DNAr8KxhAQ86Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LcTEOUAcVvE2ViK5quEKw6m0CZORORkYWTY/t4xTCZx0TrhsRykhx/JT6vyj8MHWbCdW/gGsO7ouEYChc8zeWI3RPusuZ26wUvV+lt7USLMAQvicCHsbIe2RsGdNtcx+6zVs3VC8TUso/LnwakvJE+4nfjnZK0dut5I00mHTqbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=tG/5HrQ9; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42102c51524so24465195e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 08:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1716823900; x=1717428700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3NNSVjNWOYxdySt3enWuEY8NgLaDOrN76ngl0Gdie4Y=;
        b=tG/5HrQ9oheYULNl+7mwTb8eUiG8ye1wlTAHJI33jDJkd8ZD9ggGgA/I3fZe8zAHTr
         h9JsISZ0+DPHdpk5aqesUz0lgPvGYifP0MGOVqWFbVx39G651bNIB62X+XTDWx8ZzQnn
         eqtgdHG3Ddi4dAtxK9kQMZO3eTHbasX+67Uz+ehyFhmu5EuycVlwm++4pIH0NJF7vZSs
         sb4iec0lH5buvmTgTTCFmvVMf5XVmkKc/bUkUMTlzzyyGCUb9zWDxdx2DRfAyrPTIXlN
         oFezrxbzSJmm+8BSrr7z+2qcOpcqjqxnKv1+ERsVC5uswp7MrwDgf3GNBsEajbnq0PZf
         CVpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716823900; x=1717428700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3NNSVjNWOYxdySt3enWuEY8NgLaDOrN76ngl0Gdie4Y=;
        b=Tkda4O3uFtAKnOFD1y7V9HGdQbnguZVBp3Xaz/mCEUIf2EaAAh8/JGFIXvPO5gYfd0
         VHBi36VGPlpHukOuJdx8F/3Zwnjx1w6wjk9TbozBmEIML5wbshH8V1q3O1s1/pFyFv1h
         8P61ADajuygY8ZQ5igsBKC2ksZh0TPssdkPt+eh4rE72QvJCd7VWEKea5m9yfos9anLC
         5G99cS4hZAuVazI3uZnt8fZPpOm2p43IjHzFRsENUZNj/Ht2tFa0G/Hr87Af5O7PmLt7
         BX8mgVMs/+VWAVRBeNrb4HyOVKEVjwKcfxCX7GJ3DWtkNO2bZmxqF2UuhbwQiFEILy2s
         7s1Q==
X-Forwarded-Encrypted: i=1; AJvYcCURBKLg8PXcblpiI7DOMAhSjN1r71OJc7CPwLEtJz1QGI/zRxA93L0r/P4wUUgx/O4JyyIw19U7nsdC1QpbVj3Q3Uvh9q3IfJYNvnIN
X-Gm-Message-State: AOJu0YwoysO0+4rbEkrjS0bC1tbY0oSxHbm4AsSCAX1SpqeDvyJmq7Di
	+4+qNETthXkm/D92F8fqq7bDN9CaQdnxFKGUO6gJJJXeoy0loDBwfC5c3+7LUvw=
X-Google-Smtp-Source: AGHT+IFSDuvlJ2R7D/NqkTDnql6BSN77CVwr33o+H6Jjh+G4hTBM9HNZ/ptH1Wz7cL3YA694hyF33A==
X-Received: by 2002:a05:600c:4449:b0:41b:f4e1:381b with SMTP id 5b1f17b1804b1-421015a60b9mr122553155e9.2.1716823899690;
        Mon, 27 May 2024 08:31:39 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42108970967sm113261895e9.17.2024.05.27.08.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 08:31:39 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH -fixes] bpf: resolve_btfids: Fix integer overflow when calling elf_update()
Date: Mon, 27 May 2024 17:31:37 +0200
Message-Id: <20240527153137.271933-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following error was encoutered in [1]:

FAILED elf_update(WRITE): no error

elf_update() returns the total size of the file which here happens to be
a ~2.5GB vmlinux file: this size overflows the integer used to hold the
return value of elf_update() and is then interpreted as being negative.

So fix this by using the correct type expected by elf_update() which is
off_t.

Fixes: fbbb68de80a4 ("bpf: Add resolve_btfids tool to resolve BTF IDs in ELF object")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218887 [1]
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 tools/bpf/resolve_btfids/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index d9520cb826b3..af393c7dee1f 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -728,7 +728,7 @@ static int sets_patch(struct object *obj)
 
 static int symbols_patch(struct object *obj)
 {
-	int err;
+	off_t err;
 
 	if (__symbols_patch(obj, &obj->structs)  ||
 	    __symbols_patch(obj, &obj->unions)   ||
-- 
2.39.2


