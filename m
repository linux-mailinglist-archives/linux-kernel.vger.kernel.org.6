Return-Path: <linux-kernel+bounces-430526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7793E9E3221
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 04:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 435B3162A93
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 03:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8381343166;
	Wed,  4 Dec 2024 03:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NiR9RgT7"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020842F26
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 03:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733283175; cv=none; b=hlq5cGhuN4PCCK35GiZ8Da45F0tviKYjbZOQaNRhX3ykJhY7oaWjMj25Q3u7VipAMhbb7XzBpqwG9lJ2FC9QH0VffW3Kpi4Hkbvqfi2KLvkca2lT89KxdfwLIo1Wg/5go8M2aQlhrItGlLLrtw2m/ykD+FdqmcgInqWQt2nVBds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733283175; c=relaxed/simple;
	bh=rGxRr+3GnC8oRnWqfBazKCBIX3f96M/vvnV9gVhUqg0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V1CB+F61/aZCev8sakLx3RZtMHVQeKzxKtP/g/gnyW0WaZv99SLp2RX5ADsRsiCxzPbEW6Iv2oDx1SXUnw4Pu8A79GmRSpN9bYxpiEvM3/Yc6jAsZgHtxjjKr9o8AhtOl3VowTXSOsbZIzZTj8rr5LGPQjfe8ux1lYReGVTMRP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NiR9RgT7; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-434a12d106dso6297675e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 19:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733283172; x=1733887972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7JAjjJaJE2SqnwfAB7C5rQkjjf+jzpgp+0xXtzPoRG0=;
        b=NiR9RgT7fEXTcrXOSNOwR+FNCSvYizFwu7ddgUFtAgT7PgsH45S98/vl2ZjBVE7Bdn
         31e0zQOK1swEXHgPfqTGft92hXw2WuzGQSWQVKVGfwKtnW3wHW1maA4TDWZ1/f3rtbll
         t9fu/jYmeT9rxW/SAYFVrp66cf2oXArtERMncxvDwuw0PlC+UlZSUnQdZh70wPezWTHn
         YyGFqpXsU1PlhZjvoQ9dGrDazmPUm72O/rzvQvp2PVbfFofh21gDxaZ2l3L4q6bGeE3w
         4wpCt43rTTruagtjONXqNdAXMcr+y/hKH5z52vER+iGHNSNpzG/3zyu0PWHR+s7eB+JY
         vy9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733283172; x=1733887972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7JAjjJaJE2SqnwfAB7C5rQkjjf+jzpgp+0xXtzPoRG0=;
        b=eU3sRvsgz6qKD32Aqq35o5D2RZkgCh/FFE1zF2qFatsOGPF+JaXS35ENmQPuv3m4NZ
         S3hR42KTgBx6zznxn9QXQM2xNvLBnIM2sRCl7BH0HFBgqVwGWIIo87FUNSq/VHvRwPnG
         m4cyogqSsZMKsuqtvhgJLyPXwwolVgg7sf+9bEt2cS11P5W6+zkWFIM9ggR2z+aHClFI
         fL+DF2ekyxEfnHcYzWXIbW+EcRBWlDn7fq9FsbCAZDCsMAK9mu7OMb483a+Ls+sR5FqS
         bqpxkLNx8jxlHBl9IdhOtXa8HQxoV5RXy0KTBAl1Lz5UM7wba2oSBht/5Khkw7mZOLFa
         tFrg==
X-Forwarded-Encrypted: i=1; AJvYcCWzRw2lpLv6q/cTZGAakyI7/6KQelwZFzIXIYOkVhgW7yLo15ZddxrvmKb8iKLJYanPkN0gWE66BHpN97c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuI2xSYFFbz1zNM0HHfp2Yu+YCYlcw80ohN1G8CbLpE+6jud4y
	Yr8Wg6vp02vtP18K6YpxeN2FcsEHOF5J4NVk7asyDPllQYolUb8ZJ8fFhzYBqrE=
X-Gm-Gg: ASbGncvfRF7fadbnDvIYG4vjUIt512r3704OjhQjYrRrjPiWUs9bALQLEpeHDTU1LZP
	IADLNljPtFIh6jNOdtvZRPX1nYFHoDx3fNJwAKiM2t8qCY27jFaly44AtpN5Yu385dVZ2dkiB4I
	4efPzfQwGg0wACZgjQIxNo6P1bztknNEjawgbdB4/2WtDwDYlxRVfTgHmy+NTEPwwk+1kyC9mRh
	EZ7kNbIH1rotbQmYOvYDXzsifYsHfrvA2ipNWonXtZP+H4Wqr3O2cqQHFCxxQ==
X-Google-Smtp-Source: AGHT+IEwUcZcwfhH+KayGgzitkNGYCWrij8kJDqhz1bcku7MrZ3FcKOjRX65X0ZPwHdwOZtmGeMRtQ==
X-Received: by 2002:a5d:47a7:0:b0:385:f479:ef45 with SMTP id ffacd0b85a97d-385fd41b1damr1484510f8f.9.1733283172189;
        Tue, 03 Dec 2024 19:32:52 -0800 (PST)
Received: from localhost.localdomain ([114.254.72.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215a04dc249sm37476025ad.203.2024.12.03.19.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 19:32:51 -0800 (PST)
From: Heming Zhao <heming.zhao@suse.com>
To: joseph.qi@linux.alibaba.com,
	ocfs2-devel@lists.linux.dev
Cc: Heming Zhao <heming.zhao@suse.com>,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	gregkh@linuxfoundation.org
Subject: [PATCH 0/2] Revert then resubmit ocfs2 commit dfe6c5692fb5
Date: Wed,  4 Dec 2024 11:32:38 +0800
Message-ID: <20241204033243.8273-1-heming.zhao@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SUSE QA team detected a mistake in my commit dfe6c5692fb5 ("ocfs2: fix
the la space leak when unmounting an ocfs2 volume"). I am very sorry for
my error. (If my eyes are correct) From the mailling list mails, this
patch shouldn't be applied to 4.19 5.4 5.10 5.15 6.1 6.6, and these
branches should perform a revert operation.

Reason for revert:
In commit dfe6c5692fb5, I mistakenly wrote: "This bug has existed since
the initial OCFS2 code.". The statement is wrong. The correct
introduction commit is 30dd3478c3cd. IOW, if the branch doesn't include
30dd3478c3cd, dfe6c5692fb5 should also not be included.

I am not sure whether the revert and resubmit patch operations are
correct or not. Please guide me if the approach is incorrect.

Heming Zhao (2):
  ocfs2: Revert "ocfs2: fix the la space leak when unmounting an ocfs2
    volume"
  ocfs2: fix the la space leak when unmounting an ocfs2 volume


-- 
2.43.0


