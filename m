Return-Path: <linux-kernel+bounces-317563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A08696E019
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 18:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBC591C23C05
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 16:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12AB1A0709;
	Thu,  5 Sep 2024 16:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eM61/XdL"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494EA19F433
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 16:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725554641; cv=none; b=Gw5qUyqZJcdjq722AgfwpbyG8X3U4aZT0NDq0KJ3eKArzkXb3oe8bXlJC3mawympUzlgMQh4cBbwBArJ1Xs8FYbx3THFeYFktMDfEx1te/6gZAM8WyGFku6ETU46Gd/OC/n54FPioh0CJqG/Iio2VMxML5qNwb3Gr40JDnIuvLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725554641; c=relaxed/simple;
	bh=Cw3U99JPIOapLVhYnSDk1daJZegBsN2Qpv6Nnjp/Vu8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bPxGbQQbmA5UxkSSVIOqyK2fKZ3g+7es/CDW8Ue886PB02fVHnxVCBWHYNIOWfsrThkTfukSVenWK0hsD67Xl7W0CsjrTmG6hTtevdA+txrdo42JxaG1ba40c59ODfaS9OwrvTcZUK14FYQ/2/HKd2hqXd16+iKAPAJIBNAFPNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eM61/XdL; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f502086419so13967671fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 09:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725554637; x=1726159437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CWD0CFMBOjkRPOcl/mw058bZdab8AGLnFV3fz4t//Dw=;
        b=eM61/XdLzhhuN+/V9hQ+D8zfZsLiKjRPDSbawJvz2N8Owc17IVRuOzINT/R4G9Kf8T
         L4TaNmBiQleiV6F/gbPu0G0GOarn/txw7z5Tys6uFBw29n5oGQA7LLxYzRqrxYXLX3TG
         mGPli9NJOkrpj9E7s694FAn5CkC+P1keHw7WXILiD7v0cVXWq2+RESbyMukoCN+Vh/X7
         dZHJ2UbP9Mouwx/dYjwtl7gFnntm5OpRkxx3mJyz8vBYd//9Zi7cpaaTRSBxJSlIrj32
         AzhX2kgYF7uIqH3NhC/3f1HjYT989cc7ALuR82x856XBByDRCwz5psNWYQ8t/1KM14gb
         trBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725554637; x=1726159437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CWD0CFMBOjkRPOcl/mw058bZdab8AGLnFV3fz4t//Dw=;
        b=a4SPGQ2jYkem8A2xliLcnICFxRZm6sKwbv5O1PFx5USEtejXSY4uJ9eIqZweT2UVyR
         mOWfQ7+ozXyA2cs78zPB4YaEA+6AWsKucuWKqyVStohrZAXwD3V/XakcJnuMNUgzxcME
         Kg4tQSdA7sh8/A92x8+mPo7b0s0T+cpqRB0gzQPw+HhZaMPgnsVmvMsjBgY9B4Srs5SB
         ioXYR5/OcauuN5qGYcjUGtjrWqoPvCmAWZ6qA5DtswLeI1rHkFqpidmM+X5hggCTLTRI
         /LFZ9DcR6G+lcw9U+57S5jsHQVcHpi+OtiWUr5+q/KNs07TIcjfojrm5MwECv4xpUYwe
         6loA==
X-Forwarded-Encrypted: i=1; AJvYcCVuhcF64ZfM1YTBO7UiElhjCuP+q+8dZZI9caT9lFhCLC1BbhUjv1lxHrBkV7UHBnJrSF8y9TImtt7ZXK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKwyZ/+M0SHE0S3oJbjY7hvc80JHW1k2lEW+La1PXDA23oOGcn
	LsacALBBfR3TRUm7eWW6Geo0q5RVOhmlNiPQNfHqmpsrG7Qa2KSymV2JdH7DN84=
X-Google-Smtp-Source: AGHT+IF07Md11BWV8oFFnBHbuiTIDWwJbHyyyk9jxHfr5601frX56+VpwBGGcRRCNqplS2HW+UGXdA==
X-Received: by 2002:a2e:bc09:0:b0:2ef:2c91:502a with SMTP id 38308e7fff4ca-2f6443faf63mr96804751fa.3.1725554637346;
        Thu, 05 Sep 2024 09:43:57 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f653d5a2afsm5539331fa.84.2024.09.05.09.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 09:43:56 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Yu Kuai <yukuai3@huawei.com>,
	Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Paolo Valente <paolo.valente@unimore.it>
Subject: [PATCH] MAINTAINERS: Move the BFQ io scheduler to Odd Fixes state
Date: Thu,  5 Sep 2024 18:43:44 +0200
Message-Id: <20240905164344.186880-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To not give up entirely on maintenance of BFQ, add myself and Linus Walleij
as maintainers for BFQ. Although, as both of us has limited bandwidth for
this, let's reflect that by changing the state to Odd Fixes. If there are
anybody else that would be interested to help with maintenance of BFQ,
please let us know.

Cc: Paolo Valente <paolo.valente@unimore.it>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a3eb6aaf5e47..af9d318cbfe0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3784,7 +3784,9 @@ F:	fs/befs/
 
 BFQ I/O SCHEDULER
 L:	linux-block@vger.kernel.org
-S:	Orphan
+M:	Ulf Hansson <ulf.hansson@linaro.org>
+M:	Linus Walleij <linus.walleij@linaro.org>
+S:	Odd Fixes
 F:	Documentation/block/bfq-iosched.rst
 F:	block/bfq-*
 
-- 
2.34.1


