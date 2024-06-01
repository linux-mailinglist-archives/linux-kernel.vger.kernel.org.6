Return-Path: <linux-kernel+bounces-197760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A168D6ECF
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 10:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC3C1B25619
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 08:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3EC620DFF;
	Sat,  1 Jun 2024 08:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="UXAeb+nT"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B981BC39
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 08:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717229928; cv=none; b=C/MAf3/60Baj164C0JX3uRqxGFT/0K5h16v4BGHcQwEtLqkotlwFFaB9643NHYmWzOj7B8ICX9bIl2+qhINJR/onX/8KpREIsqJBC1q8ZmGFAFUZ0AIuCYZb1ANn2yKY83vBekjYmH0Qx4fXXUV9l66Kht0P1Ton+7UlhGOXMCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717229928; c=relaxed/simple;
	bh=juRogTLPO2qs3UM+cO6uXQ3Ufimi9V6rXzS1gdbXpLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F1G2w+dzv52ihm+HReFMXOFQ+inWiBp3BGqmh13fO69vpdeTkuxDMJdwsgS3a9uWciRVmm9GpktZSdfg0kVIUIqpKDDIZb+w0kCgijfu19jXcKJVo/kv2eosQ+5bUXpoxwKhLvPI+WkTuFhU0dpYI596QGzj2yWwJhYvosmEXuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=UXAeb+nT; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-35dcd34a69bso1792007f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2024 01:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1717229924; x=1717834724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qDSrS2M7i0BNRPCtONpXbPIlnKGYcwSP27wPNDFPtFI=;
        b=UXAeb+nTAXYVlf/wWSR6UtWpUp1HdEJnm9CFFgcSUfUzYH/0sIUktygmcLEIO7VYQQ
         tnWgHESeAQJ4H+XORw+Z6OLTCtawqYU+C2otIFGAjd8b3LFBJiXfCM32OivPBTNuZTqB
         Y3XPXrqU7Ex+/cUXVu808VmwS/rc+NSVEnUewag1q8CLrK8BWR2pRh7imhL927WjTCO0
         VzHUgQmxU9jS7Y7A/C9FUL7em4eZBRRmDgSPFcnpSp8+jZMpzt6h6VDz6aee7SDSr87Q
         Z9u0slFVcXK6yk6B/mkmQDU6UJhqS3WRqRUL+H4PdnclxD4aJT8Ew5uRxaA/zLA/dhjH
         4H0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717229924; x=1717834724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qDSrS2M7i0BNRPCtONpXbPIlnKGYcwSP27wPNDFPtFI=;
        b=D8jwwflZXTG2ZMuhoAkdoUxbqao0VrugefgicisR0kQmZm2AS3JDB1vcm7YBIeXn2I
         tmuC5XYSVYLZ3CT7HvYERxgqAYvyAarUIE8Oi8mlZlmjpsKMpwJUt5kbae8rSgU1S/aK
         qYlxEjge60a6gpPDxZdkeTwOp4PUU1cGSYA8Ha9yzXrjQyRBrpiT8vZd2CkYQX/UJaEC
         WWQgOIH21TDkxWwARGLREJZ0m53Iakc3E1FSvHtAB+D2G4XIWXr5CeDKE59k7XUGJL+c
         t2vEaD3hIBU0hbQgOa33i38AemdX9LcrkYJsBk5nPoXdjkEGRRf9hYgm1jC2E/bKWqLv
         u0Xw==
X-Forwarded-Encrypted: i=1; AJvYcCXPnFiFW4Vcn1Jh3zwvjpGT7fjEiz/D1YKOzHhaEB7HppaWjhgdE0kcDXa+jwixn/Chz0lk3onsSExmOgkiItZrQ1EIjDcT9VbCG4X1
X-Gm-Message-State: AOJu0YzHFY7f1049CApiSNHgBP6B+2UTId+f6swEgkV/OkFXt2d2kUaJ
	LPL2GPR50e4FecIUetaoI2n75/rJisJHeyATjB1pu1aNUDWIhuzpWGhHa9uAf1c=
X-Google-Smtp-Source: AGHT+IHUHqF5zw5T0LAYRAz4EodAka68lyRIDO+dvLKGP6ottBNPhvhdtLKKamX3vjh65SPUKbcu8g==
X-Received: by 2002:adf:cc82:0:b0:354:fa0d:1424 with SMTP id ffacd0b85a97d-35e0f2580fcmr2520631f8f.14.1717229924498;
        Sat, 01 Jun 2024 01:18:44 -0700 (PDT)
Received: from localhost ([194.62.217.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04c0839sm3547736f8f.23.2024.06.01.01.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 01:18:44 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Hannes Reinecke <hare@suse.de>,
	Ming Lei <ming.lei@redhat.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: Andreas Hindborg <a.hindborg@samsung.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Yexuan Yang <1182282462@bupt.edu.cn>,
	=?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>,
	Joel Granados <j.granados@samsung.com>,
	"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Niklas Cassel <Niklas.Cassel@wdc.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Conor Dooley <conor@kernel.org>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	=?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>,
	open list <linux-kernel@vger.kernel.org>,
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: [PATCH v3 3/3] MAINTAINERS: add entry for Rust block device driver API
Date: Sat,  1 Jun 2024 10:18:06 +0200
Message-ID: <20240601081806.531954-4-nmi@metaspace.dk>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240601081806.531954-1-nmi@metaspace.dk>
References: <20240601081806.531954-1-nmi@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andreas Hindborg <a.hindborg@samsung.com>

Add an entry for the Rust block device driver abstractions.

Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d6c90161c7bf..698515b0b0b3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3782,6 +3782,20 @@ F:	include/linux/blk*
 F:	kernel/trace/blktrace.c
 F:	lib/sbitmap.c
 
+BLOCK LAYER DEVICE DRIVER API [RUST]
+M:	Andreas Hindborg <a.hindborg@samsung.com>
+R:	Boqun Feng <boqun.feng@gmail.com>
+L:	linux-block@vger.kernel.org
+L:	rust-for-linux@vger.kernel.org
+S:	Supported
+W:	https://rust-for-linux.com
+B:	https://github.com/Rust-for-Linux/linux/issues
+C:	https://rust-for-linux.zulipchat.com/#narrow/stream/Block
+T:	git https://github.com/Rust-for-Linux/linux.git rust-block-next
+F:	drivers/block/rnull.rs
+F:	rust/kernel/block.rs
+F:	rust/kernel/block/
+
 BLOCK2MTD DRIVER
 M:	Joern Engel <joern@lazybastard.org>
 L:	linux-mtd@lists.infradead.org
-- 
2.45.1


