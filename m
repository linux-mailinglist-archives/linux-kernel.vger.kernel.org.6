Return-Path: <linux-kernel+bounces-285068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E45719508D4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A04CF287FDB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2826E1A0AE1;
	Tue, 13 Aug 2024 15:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="LtBVlUoA"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025561A08AC
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 15:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723562368; cv=none; b=mdd1MyCZGq/qP7K/dG9tsUimXooiDpLogK+T8nK5aRdZLhwb2/UhNLXcb2DwTc4cMxtDwo0XqCKN583VbHb1+myJcfIb7e8AKQLo4JjOpCwjN3Wkov3+fbg0x12GcI8WkQ9vZKjOY8NjrXHsDBNJYNPyGEIs5Oub9Jg2W0oyl8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723562368; c=relaxed/simple;
	bh=WEGOV/eNmS0JwTGq95TbV76XsATL+GH7esD7KLSP5Ac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OxMk3XdRBPFVAAUs7iUoUcnRPmkRouqJgaoWr3CQfPnnHUSQ4bYR8rS9WK79XF44+tccXtuUtxW/pyZHqzhjjKhgXjFPnsbCAEoerjJdH+NZnyD+uDpSwxg6znUfIBkqAeWxrH8+9AQW43X68o0QkWayiiUakCEpHwMA0UUEw0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=LtBVlUoA; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f149845d81so62212351fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 08:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1723562364; x=1724167164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nLy7GIRQMaObsC/QtzsBD1LKVmCMkjVFm0GOFd+PCLQ=;
        b=LtBVlUoAR2tgEEzSize/rtLSaP7N+bx3ohzWCB2d0aj2ACq6InTygnmpcaaCSVmE4o
         enA7J2+d/1kBNwrRXuDr9+4O4ZtGiWz6SpFtpMTCt8bIWL4hRhdWutyuLHC2LweeCIQm
         XK21H0Hq9KhLqdCU3nuumQVXWUVIwkRPpeMaKYYJUlIHnGwozpiJT3oAaj19qOntN26e
         I1LmGD4zGL60EpT3IWALewNz9922wEPZVZ7AEFT1JvGE1FFFR+bKW2hsID37YuxNYzMS
         7dYkk/yERk3NvfwOUs7sGnmzs8vvmMcYv2eUQ9gMaRfwPIspGOWzQEsgvC07C6RARpm4
         zUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723562364; x=1724167164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nLy7GIRQMaObsC/QtzsBD1LKVmCMkjVFm0GOFd+PCLQ=;
        b=v6fBN3HKn5xNm6suKhnxvs5FBUmYGXfJdGD8KFCLGwFOhMJp8H1O8hRAtmC+1e8nbO
         /UMmUcS2Ipnw4d1bATVYu4+u6G4Hp8F4t4D/UmYaeKZgW+MkM85iBf7IeY88Hq6EUk9z
         Zm7/UQ1TISzrK3zLhMTJpbFNN4pSLctxb0XUj0BaK89ORwKeHhEMAkQkSPrEeuRvu5kt
         6f7BKGhjoCERgZ3txLVdv4i8YnH7sR35/V1aN5KJPRfykoMsfK6gVEP8aX8JuR5Nvr0T
         hfASmIsmgbkjKWDJesdsgEgCl9p9TXuLbzdVPCarfpCpbq70IgkToQCMGNC2KNJChWct
         42MQ==
X-Forwarded-Encrypted: i=1; AJvYcCWADtDzN3K2nRx+sTUDZBJgbiISeI7Q7t4i7k4DwYlDujZMJ3que3v8h53yUVxD3YXqFmW4ZO/1l+oo3/TBT6IJ1ZADXB8SYCzOiXTz
X-Gm-Message-State: AOJu0YwFj4LDpVVYl82w8lk++LaCGI25Rd1y+pCH2scbqfA1aynCh2wY
	b9Mv5FB2B3e/rNgHUve2Nle537x0PMboijRKCPDvgHTXwR1Xb8tkBnJLJNugBTY=
X-Google-Smtp-Source: AGHT+IEQB9NVlJBHy3poayI8faoI7ySKxRBVnFDVKOGewt3x4rzWQUAPonzs+++1KgfNdJo0I641nQ==
X-Received: by 2002:a2e:611:0:b0:2ef:1b1f:4b4f with SMTP id 38308e7fff4ca-2f2b7178671mr24425421fa.34.1723562363831;
        Tue, 13 Aug 2024 08:19:23 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-163.dynamic.mnet-online.de. [62.216.208.163])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd196a756esm2977597a12.52.2024.08.13.08.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 08:19:23 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	kees@kernel.org,
	gustavoars@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] bpf: Annotate struct bpf_cand_cache with __counted_by()
Date: Tue, 13 Aug 2024 17:17:53 +0200
Message-ID: <20240813151752.95161-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the __counted_by compiler attribute to the flexible array member
cands to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Increment cnt before adding a new struct to the cands array.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 kernel/bpf/btf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 520f49f422fe..42bc70a56fcd 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7240,7 +7240,7 @@ struct bpf_cand_cache {
 	struct {
 		const struct btf *btf;
 		u32 id;
-	} cands[];
+	} cands[] __counted_by(cnt);
 };
 
 static DEFINE_MUTEX(cand_cache_mutex);
@@ -8784,9 +8784,9 @@ bpf_core_add_cands(struct bpf_cand_cache *cands, const struct btf *targ_btf,
 		memcpy(new_cands, cands, sizeof_cands(cands->cnt));
 		bpf_free_cands(cands);
 		cands = new_cands;
-		cands->cands[cands->cnt].btf = targ_btf;
-		cands->cands[cands->cnt].id = i;
 		cands->cnt++;
+		cands->cands[cands->cnt - 1].btf = targ_btf;
+		cands->cands[cands->cnt - 1].id = i;
 	}
 	return cands;
 }
-- 
2.46.0


