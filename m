Return-Path: <linux-kernel+bounces-197662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6B48D6D97
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 05:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7E691C21468
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 03:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC456FB9;
	Sat,  1 Jun 2024 03:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZ7iayFx"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EB1524F
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 03:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717210899; cv=none; b=dp4ZE0K8PXB/8ql/4MZ/NHdWKiZwN+xz0noG59XAK7YlfYpD1oZ8UFzImA8YFfWmQf7+prgWiW3JoxJQzBL6bM/38/mi/uwncOhhPHikHcwaT4yYw2sh2dWDizp92pugcEhYiNbrbh7A1ZEzxO8q+kQwvrEOQPN+IS4IDgQWf1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717210899; c=relaxed/simple;
	bh=6hqIX33sTV2/RnujVde5ha01kuZSbZiiUnve6BACFhw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HvLakoclSkQolV7Aou+LElc0aRZfVlxAGb4yKDac7TDMOodcQjlBoKG6l5xfJJsj6FDcUQg2zZM54fVU9ru7rY/HvuEZVM0W2hdPB9RNeCCL8FAOpriDVR2a9V8YOVvU78R8m/0EhYCnNjVsYUFoqoVZB+My9CrLXqW5F7fVTkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZ7iayFx; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7024791a950so869897b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 20:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717210897; x=1717815697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SF8pmvRNjcSY+uULWz0XGq93Nj4osQ/8/ZHPx4Suj+I=;
        b=SZ7iayFxOvYzPCAyP3jfB394C5qZ2+sGRE8oNHzkC5Tt4nieuQvewJ+slDdpN52tv3
         ZAEOpmnOgMzrdg+1wcwf7hZ87KNIGF9nY2gumWoZu77eqNMAlFHCb63JzI7T5SquXf/D
         EzgDbRu1AfUN2oEOi+QY3qW2amUTXrBJE3jUOwfniv7HaN3CMn5+Cb4vBFKp/iWMI1kh
         d31Dh2K0DzQYvTr21s+9HGiICwo9c5HU3kP5GchLlFZReQCHd3l61KZXzskPy3Q67Ya0
         5SOaOHzkMhYAL4e+ZlWQehQhaxYGDdG5fgRGbfyEh6HCo74pgNE5aA6agn+kfbfk6jRn
         oc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717210897; x=1717815697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SF8pmvRNjcSY+uULWz0XGq93Nj4osQ/8/ZHPx4Suj+I=;
        b=Tkm+ZrFnl39+4DFyT9MEv8BQYIDX0YmWhu280S8Bgb0545Qo4LnBLcm/1IlODVOE9C
         d6g4V1i+D9uJrbyuosk1rHHm2SypeuMVqtH6PiIxRpf3k0jghoMw76kbz6BUZo0vpHjk
         HS+qzxQ20z/QJ2KxY07bCi2koe5gw2QG+qdhKtPI7DIyTHHzHmNG7TlKGKCF2QIuixGn
         1kZvNdkLeNxjirbtk8GQpj7IjHoYhCjBmUBRX7LtFbeCf9493vPXWVEvrcpyyUu/wUSR
         w0wLopq1Za8KHv+AfX0m06qy9qbroN4S8rmonf2l1z4/xaIbV39kxSy/61x9AibiVf/u
         7r/Q==
X-Gm-Message-State: AOJu0YzpH3Dq4aPFyqxekvLmf6CjpJO/yAP1G1fHNpHYfdZ0FHkYAj7c
	Bty8RXN2unNOVatM8COErZBT+UelvLAT7KH2EB9huuyuqBfuTA9A
X-Google-Smtp-Source: AGHT+IG3N30mswX0/R2ObCkt2iG1XaieN2Rhy/i+mcHyDMcAgX5ebDHmTuj0waHFTnGRrSBSDN0PwQ==
X-Received: by 2002:a17:90b:3e8d:b0:2bd:9256:bbe2 with SMTP id 98e67ed59e1d1-2c1c4453843mr5446113a91.22.1717210897153;
        Fri, 31 May 2024 20:01:37 -0700 (PDT)
Received: from localhost.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1c25e0775sm2180726a91.0.2024.05.31.20.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 20:01:36 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+13e8cd4926977f8337b6@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [jfs?] UBSAN: shift-out-of-bounds in extAlloc (2)
Date: Sat,  1 Jun 2024 12:00:28 +0900
Message-Id: <20240601030028.22250-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0000000000002e9eb506178cdd71@google.com>
References: <0000000000002e9eb506178cdd71@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test shift-out-of-bounds in extAlloc

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

---
 fs/jfs/jfs_extent.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/jfs/jfs_extent.c b/fs/jfs/jfs_extent.c
index 63d21822d309..3d1273d35b13 100644
--- a/fs/jfs/jfs_extent.c
+++ b/fs/jfs/jfs_extent.c
@@ -316,6 +316,9 @@ extBalloc(struct inode *ip, s64 hint, s64 * nblocks, s64 * blkno)
        if (bmp->db_maxfreebud == -1)
                return -ENOSPC;
 
+       if (bmp->db_maxfreebud >= sizeof(s64) * 8 - 1)
+               return -EINVAL;
+
        max = (s64) 1 << bmp->db_maxfreebud;
        if (*nblocks >= max && *nblocks > nbperpage)
                nb = nblks = (max > nbperpage) ? max : nbperpage;
-- 
2.34.1

