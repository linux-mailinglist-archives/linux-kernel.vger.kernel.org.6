Return-Path: <linux-kernel+bounces-390530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A72679B7AF2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 13:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F8961F23064
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 12:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25CD19DF61;
	Thu, 31 Oct 2024 12:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzYii7EL"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21611E495
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 12:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730378532; cv=none; b=RRKqIYpqniA3mfFRjzyYXU7cIwTun25NIbEPS91D9gTvF6zQ8VXWJUAby1D6TToVs7gH3RhgBCx5VqmOnamrtiHablfYVCDJc6ixEAQFXgCT2E3VB/HXmmlZQetySn7zY9K8cQr0rXEjVWjH6+uWKZblzHqNT5uDq4ijsWBfjks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730378532; c=relaxed/simple;
	bh=LFQR7eBo0ij1wczV7lkAC0M5sAHFTroNUUMbeBATbc0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HHaFRfJdSweQoNoXqZWu7th/W7XwkRtmMLIGGGeWPPeM643ad5UGRrV/wLfOitU8Xl1AxsI6XNEpXdv+QKd4zVvmJGdGZ+LL595o0zjA2Se6LA4wa3r5+0fxfn/qzqQqRnthFRLCFCBIuySGoVuDlIbSJQjQl7FtkP8u+CTMLq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EzYii7EL; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2110a622d76so3814295ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 05:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730378530; x=1730983330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Zxu6U1/EeE9hsOSQ/DZR977RvLIqZxhKQgAobJ0lU4=;
        b=EzYii7ELO9xCDf48wI/+sWE/DyGaJG3dEJx0xtXW0x3JIEqCGobOv62vhPlpob0lhy
         Lk32ou1sH80VqazysyGjUeB3hflWUXb+mkWIPNDu9g455tTJBXHZDPVuMiqOeGtpzMyI
         3V89XyjicNLRMZSLrJYNYJVaSm3hYR25mVHekPthgLI0NjjZhzm3KjQykOYuJdsddNOl
         w60Q35DdKeUwR4wJR+/rkTujn+ySZq+Q7yJJttQoDW8sVSJ7ILntLIiMTVortM41/cJ6
         jHbgWKeQfYLx1z3h8ZHOq4NyoCkH3UXPRq/IcKXfmnncbMK+5GK3EwwgMLulAp6+QEAd
         zhYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730378530; x=1730983330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Zxu6U1/EeE9hsOSQ/DZR977RvLIqZxhKQgAobJ0lU4=;
        b=jS0WEBZPiH58jlCG2z5hdEM9U5MVMRC3Ozohavlxh0/BoT4hRjYdDisd6EKh1EU+8p
         rw9xftRHuwyFTU1LEUIyv5n82ghEtSwimlWDGoSQeDK0Ipk0TWvmRc87zDeeQpGWX1Yw
         GnM/5lY/MqfFVbe0++Pff7Qx4GSzUrrAk2X6e7NHfT3QSdymyr86iUPCEzzieDGCxWaT
         Uy6NSp0mF4i+C7SwzKSgymkrBhJOAo2C3+QBj4ZhGpS90QN7+HX54oz5Q+zkNhLcD+g5
         ZeT5kjwuO27RU6G8IPk28a1i66t8YV/8x/Jz+cbVtbDvRPKHZA4xmmtI3xHwC6oCfseI
         aWtw==
X-Gm-Message-State: AOJu0YwMF0libDKaj6kDG65QUNNk64pzxCq5DWFwIt39vRISo2A/bsy/
	eSZ0fErXdQuIAaSmHhenRX5F88apa8+jJ33LED47sSLigKzy4fSQdr4KEZaI
X-Google-Smtp-Source: AGHT+IFVEm4EVV3sQFHWX6aa2RsWkkXY83kKkN3vrooeHpj47xma64lpbqfEl+2gcUHFwAAN8MfR6Q==
X-Received: by 2002:a17:902:f691:b0:20c:dbff:b9e5 with SMTP id d9443c01a7336-210c6c0e54dmr240529125ad.33.1730378529864;
        Thu, 31 Oct 2024 05:42:09 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056edc71sm8307845ad.60.2024.10.31.05.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 05:42:09 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+41ebd857f013384237a9@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [syzbot] [exfat?] KMSAN: kernel-infoleak in pipe_read
Date: Thu, 31 Oct 2024 21:42:05 +0900
Message-Id: <20241031124205.10372-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <67234aeb.050a0220.35b515.015a.GAE@google.com>
References: <67234aeb.050a0220.35b515.015a.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

---
 fs/pipe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/pipe.c b/fs/pipe.c
index 12b22c2723b7..596780490a32 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -324,6 +324,7 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 				break;
 			}
 
+			printk(KERN_INFO "%p %u %lu", &buf->page, buf->offset, chars);
 			written = copy_page_to_iter(buf->page, buf->offset, chars, to);
 			if (unlikely(written < chars)) {
 				if (!ret)
--

