Return-Path: <linux-kernel+bounces-402571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A939C2925
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 02:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBA7F284A17
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 01:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A484F8120D;
	Sat,  9 Nov 2024 01:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="uWa5rgwV"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EC154FAD
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 01:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731115741; cv=none; b=WAPX5Ltdx98y9iApbn1KZhllKiUNF/d31ISafPJeGFFczeMshal4N7H3QA9Pps2+O4RUYs1G+e5IqoZ8tk6H72b4olq0ch8seXg+1iDEKbem44nON+SzN5s1lIFzorwapxw3lR4kAG7jrjGkw/mhd/2Pd/i+6FPBllgfq9/WZKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731115741; c=relaxed/simple;
	bh=uZOIUaRs+7H+jn62BpsP+uX28ASu2b/m0Dd0veYqTPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BAxSZZJrRwdA4UMaoH7fz3uCHL5mNbi10DcilgsFdtw3xVNinOFOsq7LNV3nDa232bTKh5ZkuN5Ay2hl0Cf7M2n11vB7EBQq+cSPuvHdNWibzJFT8I6YNkIVQsUllV4W5UJVHOjlWko78XZ9L0U743y3qhitXc5ngv+RrHpVKPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=uWa5rgwV; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e2ab5bbc01so10395a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 17:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1731115739; x=1731720539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4yNjGAg8qf3fKwWurXSx/s8j5dgkc97k/3nCeXjiZI=;
        b=uWa5rgwV4reeQFAdaDLk35MfwdFUPJ+wVO6Da+WNWAYyb5XPToSp87v5GfTcvvf+Iw
         YFNI/j6fwJbqa/71fHRWmClD5tPNynamdv5tsaHarZ0XVm/3hAReAFLb+pmxJgwDH4Nr
         dhHT6U/ex2MYmEiI7rpFj5u51hD3Eh0HAmk0iTB9bToJpH/KHfo80EW/YX/GEa90LTmE
         LbFZr9j6kSl4aF0y0ztLQ29KXgVP0wI1FabeW4z3P/5H+ILw1bqFD7Fuqdi4fma8WfcV
         +TeTaxTHhC3PmAWqA95HbMzaX/LPjfsUFpXzvt1KEq0z/F4JSjKUydICAKw/PssWD9qN
         eqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731115739; x=1731720539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e4yNjGAg8qf3fKwWurXSx/s8j5dgkc97k/3nCeXjiZI=;
        b=w/gmpQa347sWcPUNgreIbWNhqbEMM3YaMuc8XjmZ6IOPr40S9eDiCDmKhBiWKR9WYp
         ign21l7XDGWTRA4brmNQgUDz3UVwSVnv1HKLeOuTMDZUmhTV76RqC/aArprZrgNCkL6N
         kaUjZhhZ24CRwj0ZAhuDElgnFhROYa7s/ULblIls26mSxZm5sTsqv4WYBKglNj8GxYMP
         ONnsRd+e/cPDdMGDlExXP8IaAOiTuzmfOIv+M2YzKsvN7qNzljNxhuWbfAHurTzsHhCv
         V2K62IND/zZCQvZQT6FEw4W097Pq2TCipNNZefYRqlGWkuGI5keCG5uSYdFsLCUiOEMI
         gCXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlGGb97STYLQQwYIr2DvP1F5pUmRt22FtVdjSjD8FpwSmEgm7MM6+YtgzbUcWgk+J3gDyEVv1ghw9GnBU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/c2/FMgwa1zOqeHL1v0sS1mAMTuqg/PUrF8C7aeIcyjSSWa0c
	Vo9i1+lgM7n0UOTqPlG2/jHhKX1VcOa++oz2dJW5YegxNG+Wh3KT+qd6jKALTam/EYrMwBXjWoh
	S
X-Google-Smtp-Source: AGHT+IGxDPbGoufHSHqpkSKM+XO+452K3765m0FRuWx/5mfOxgW3YLlOJkt1wHWgGfUa1caBsRR/ng==
X-Received: by 2002:a17:902:dac9:b0:20b:80e6:bce6 with SMTP id d9443c01a7336-211834f8c81mr28605025ad.4.1731115738993;
        Fri, 08 Nov 2024 17:28:58 -0800 (PST)
Received: from telecaster.hsd1.wa.comcast.net ([2601:602:8980:9170::5633])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e6c96fsm37493355ad.255.2024.11.08.17.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 17:28:58 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
To: linux-fsdevel@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: kernel-team@fb.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] MAINTAINERS: add me as /proc/kcore maintainer
Date: Fri,  8 Nov 2024 17:28:42 -0800
Message-ID: <fb71665d1d10a8b3faf7930e4ad9d93143a61cef.1731115587.git.osandov@fb.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731115587.git.osandov@fb.com>
References: <cover.1731115587.git.osandov@fb.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Omar Sandoval <osandov@fb.com>

Christian volunteered me for this a while back given that drgn is the
main user of /proc/kcore and I've touched it several times over the
years.

Link: https://lore.kernel.org/all/20231125-kurhotel-zuwege-10cce62a50fd@brauner/
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bdae0faf000c..89645de6faba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12242,6 +12242,13 @@ F:	Documentation/kbuild/kconfig*
 F:	scripts/Kconfig.include
 F:	scripts/kconfig/
 
+KCORE
+M:	Omar Sandoval <osandov@osandov.com>
+L:	linux-debuggers@vger.kernel.org
+S:	Maintained
+F:	fs/proc/kcore.c
+F:	include/linux/kcore.h
+
 KCOV
 R:	Dmitry Vyukov <dvyukov@google.com>
 R:	Andrey Konovalov <andreyknvl@gmail.com>
-- 
2.47.0


