Return-Path: <linux-kernel+bounces-214887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E76908B8D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A5B928133D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 12:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DA819750B;
	Fri, 14 Jun 2024 12:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="NjiY0UgO"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D58218C350
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 12:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718367699; cv=none; b=Z+LhEyNCoYitlxS/Mau8ok+O6V+ZHW2+tyKFSHQ4CwEMjP11ygdadl4LQOD4QMaccOd5S2BwH+TA4QSF0qLtvVGRbjGtAX+hk3e/QNkZffeELOsghErCGoYHgSieITOqYXMzaZhvXpj4fi77WabjkZufIZiyPeDH8Vr1RRBFTns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718367699; c=relaxed/simple;
	bh=vVMnkKP23EquRnJbPIazwvrYt+/IR7+ZK7NhvQrGL3k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=A0yWK5PDhVowbzbGT2KkLRBBK47SGyXcGzm3gjYfHJkQEpATbkn8lx+fdFsiA1Gall8VN6Cga1dQoxZXZynH7J9sdbeQSPXCaGIo6dRSvus4A4bokarzjmEqNI+18y/EgmIOer7oo5RmnwHF/QYNAAIuQGijK6RbIVGo2oukL5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=NjiY0UgO; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f6f38b6278so1913365ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 05:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718367697; x=1718972497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KBGz84Kp8zPxGVcYMqV/SC8aRcbUSCJ8X0DqtX5D0Kk=;
        b=NjiY0UgOw6ApJ7NE+0JfNxdlS1kqzqHOZuCwSW9Wprg6hXrNyYDCx2NC7o66tPKTsE
         WP/Y5GRqKDV4bFS6vvCkzPLI5Lbnn4e4USFv+y+0/RRkPtfWZwsPE1cyWb1fS1sDaHbj
         vDSVuwC6rDSX47dcqv9C33zPKJcZP/b2FeotCnBWi2F8owsC2ToDBOaXqyIk6FqLROD+
         FodCTNpnpeTZ+jeEvjAX+FLguRX5F75GT7g9cJhcGx/YcaP9bwIhqTS2Pu5X2eRBM8OQ
         pHKIHO/aDEMGvxYQIXNQ7DsJqUFaqLdpwsI4ity9wq+zVD5/f+Vep9ONjrY312gOTMYk
         5hcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718367697; x=1718972497;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KBGz84Kp8zPxGVcYMqV/SC8aRcbUSCJ8X0DqtX5D0Kk=;
        b=OYImnCGN1of5Sj6zhVvoJse+3zu5EVDJZ++7FoZ1HAHRt3Iv95s5B4t3GbqLetpT04
         ruBbv0/ALqsV5yDQ9KGUDxSxIpXJnT+JXL6YjXrjCSg6N1TRAs52FeGWp7MBLHSUgvpS
         i2fw2go7Ldcu6K3B3LXPkoN5yHJTo0aFxdtwvKlDiBbQIOAcJnV3BfvG0XTOng55PpHO
         tPmni/7Oq5oO09gzweP92n5O18w1O7JiAG5xLAU261mILErKujeu8LhgK+oIxqBkHubi
         c/NFYEiZpT31OU3fmqhngvcl5DcJrWpREbXIadxw3BhiRJnG6l9ZJExLBOtQtq3DZr3Y
         jYSw==
X-Forwarded-Encrypted: i=1; AJvYcCXZiYYpHfrj2bDHV43nIoV6/96+eNKoTWiurURL7OTtoOepPdCjX7Npwiem00M7Rb3jBrP4cfjZb/KyBIxwjIwwt8PeprlDfRlGxvux
X-Gm-Message-State: AOJu0Ywi7PZQY/WJCQNccapq2tV66cb+RIZ/ZpF7fQAHFZzjA1CDSvAb
	zZ1cPd+j6qvreUPNUo+nyx7jqGp/Nz7CyebchIARHgh5tdVyjIXIWH6sOf53++k=
X-Google-Smtp-Source: AGHT+IGgrI5Z53eE6slIeb5D//L9zkN9U1Fpf2jCXTu1Zs6NpCOAXPFi1P0d0VowXih3bXAEQZq2Pg==
X-Received: by 2002:a05:6a21:183:b0:1b2:53c5:9e67 with SMTP id adf61e73a8af0-1bae8259588mr3195150637.4.1718367697350;
        Fri, 14 Jun 2024 05:21:37 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f3947asm30750075ad.264.2024.06.14.05.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 05:21:36 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Cyril Hrubis <chrubis@suse.cz>
Cc: Jan Kara <jack@suse.cz>
In-Reply-To: <20240613163817.22640-1-chrubis@suse.cz>
References: <20240613163817.22640-1-chrubis@suse.cz>
Subject: Re: [PATCH v2] loop: Disable fallocate() zero and discard if not
 supported
Message-Id: <171836769633.229112.12813343173922846778.b4-ty@kernel.dk>
Date: Fri, 14 Jun 2024 06:21:36 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Thu, 13 Jun 2024 18:38:17 +0200, Cyril Hrubis wrote:
> If fallcate is implemented but zero and discard operations are not
> supported by the filesystem the backing file is on we continue to fill
> dmesg with errors from the blk_mq_end_request() since each time we call
> fallocate() on the loop device the EOPNOTSUPP error from lo_fallocate()
> ends up propagated into the block layer. In the end syscall succeeds
> since the blkdev_issue_zeroout() falls back to writing zeroes which
> makes the errors even more misleading and confusing.
> 
> [...]

Applied, thanks!

[1/1] loop: Disable fallocate() zero and discard if not supported
      commit: 5f75e081ab5cbfbe7aca2112a802e69576ee9778

Best regards,
-- 
Jens Axboe




