Return-Path: <linux-kernel+bounces-398393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0F49BF0B9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EEE7280C91
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 14:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA8D2022F5;
	Wed,  6 Nov 2024 14:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCV2D6Fw"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF101C3F27
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 14:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730904649; cv=none; b=INkqzlxJgSqUNFE0qAYgnJAzhCg9h/0v1IUFMni8vCMwkaK076p6N7Qe0ac8a6w9Z7s6xENwgdtyTDLPaCX+PWbcZKWlmW4mbkJMWhlRO/t9r1iik7gZvs5hapyGc7wukQt2lhCbvPNrQzgz0hYCtW85KlYxvQV4suF23xWTRWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730904649; c=relaxed/simple;
	bh=mfRrzjFPDbjo6fBiptqC7KFCWKMy6+plwueTY8SUA94=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IITaDv2Otz1hFBuhWg90M5PyoTWYE7Ucof+Ok7wHv1hafyC7XctaLdMbtoAwok57YGPvnCFBAoGzWGSLyTcChhzLs4HGmA81tUfACca5CawPGILYRSlrvzRow0RI8mNx9qyqpekT+oqbXXkEUsW2fNL2j0+TLrpw80441Tor9w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCV2D6Fw; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e2a999b287so5555249a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 06:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730904647; x=1731509447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQmyYX7FMiZQv2tOpjXzul7EtNR9NJWNjptb4BK4qdw=;
        b=GCV2D6FwZuLGHQ1w9WO2IpV/MuErVHgaSz4zRK9dn6k8U1trBWYivILi+5/K85DnXN
         wjbYXOE51kuxJO8QfwqbVoi09hwZ/AZ/RhG5XrsZaICxixWUBra7uoU74FLOKpYDsxDi
         nY38E9fcnMFIAx/e33V1XPp4m9MA/ifnhB4Luw8U2Am05wcIymUPYO2cYtrecrrVnFjT
         Zi0u3R8IAlKQRsApwrOupOwEw3XEZRHI+gchsrDtPXn1BBblHtRBfixb8drZg4Nu5FoW
         swASMs7F3z3M4snNZ8OH0bwbGLYcT1FpDAT0PqGt6nYMMer+acYr5FzTox+RLTB9uEWh
         BkHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730904647; x=1731509447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MQmyYX7FMiZQv2tOpjXzul7EtNR9NJWNjptb4BK4qdw=;
        b=VC4R8f3X9YvXZDR4+eZtHNYFe5aMqTyXYR8hNftaq3b3p9JkMixjcLRrCVjOjJmdaa
         X4cM+rPXTY+4ZyDwmrePGbKBWVJFbEOnl1ph9BBCw+FxcqIjsFZ1cROKC/JiIE4gQiuq
         G4kVIegvugqU7NihxZuJDToQZE5QJZLpKXCyjrejgx+OqmDdryIjTYN8hDp/x01vCsGk
         MdmQaRLCYgIml8C72+uzicPsEGruYPXZR7Ys9DA/t34ozPtN5MpfvvBifYmj0LmB4J+X
         V6xDNjMrU9cXUB3erSoPhhE6L1j4QRzjdPkTIXCJOqOsu3k4lazEaiNAUfmWqn9K2H1G
         +qRw==
X-Gm-Message-State: AOJu0YxMqygUhMrmrYP6qnZnID/rPSPyoJxNu3TXVfy8wASfenkARm25
	EOH0Kivys5cPI9PLR5die3FnGUuPCGxBbIHMguIyfnGmrItQ4Gn+LpQLtJqv
X-Google-Smtp-Source: AGHT+IHx//7sS3Q4L2sWRRdC4OoFoDh1djM9mFRkVBDiYPqn2smpPZiDRsWdKtYM9eRWjXSkHCYISA==
X-Received: by 2002:a17:90b:5242:b0:2e2:d879:7cfc with SMTP id 98e67ed59e1d1-2e93c1a6337mr31122222a91.21.1730904647466;
        Wed, 06 Nov 2024 06:50:47 -0800 (PST)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a62bd4fsm1596477a91.50.2024.11.06.06.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 06:50:47 -0800 (PST)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [syzbot] [acpi?] [nvdimm?] KASAN: vmalloc-out-of-bounds Read in acpi_nfit_ctl (2)
Date: Wed,  6 Nov 2024 23:50:44 +0900
Message-Id: <20241106145044.90199-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <672a3997.050a0220.2a847.11f7.GAE@google.com>
References: <672a3997.050a0220.2a847.11f7.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

---
 drivers/acpi/nfit/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 5429ec9ef06f..863b59210664 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -412,6 +412,7 @@ static int cmd_to_func(struct nfit_mem *nfit_mem, unsigned int cmd,
 		if (nfit_mem && nfit_mem->family != call_pkg->nd_family)
 			return -ENOTTY;
 
+		printk(KERN_INFO "%lx", ARRAY_SIZE(call_pkg->nd_reserved2));
 		for (i = 0; i < ARRAY_SIZE(call_pkg->nd_reserved2); i++)
 			if (call_pkg->nd_reserved2[i])
 				return -EINVAL;
--

