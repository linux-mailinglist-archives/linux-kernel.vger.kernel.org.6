Return-Path: <linux-kernel+bounces-563045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 259F7A63624
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 15:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 430D816EDC2
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 14:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73811A01D4;
	Sun, 16 Mar 2025 14:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UvKPnzuw"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8684A134CF
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 14:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742137045; cv=none; b=I6uD9W9EWTQ9x1RBCGbLgh9Q/nIgnAHFrj2FkT9aDKOwmRi2B+T2Ba0oJcTf4eZfvJKhyJIGJwJvxt2XANsn+W1qKEyjFTq3gYA3r51T4ktArNbkXETfFWabW0nVgYPb0qrhsr7Ia9DBAR13e1pYESWWGKIpqy2LFzydrzYyJq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742137045; c=relaxed/simple;
	bh=SzSrEEl5s10UCn7mt6hHQY9dVWYbYgiLhKffwgX2Z/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V1xFOueWc6md7tQEMacsNpvLYj8Yn8yLGVDlbULv5mpnBKpW7YryFAgNH5dcOauroiqhg00gKpIuMSh+Gk1eQ2Ee92FQ6YiHhs7EyXp5pMR4nK5RX/2TeyoamDuNF6CatRQpXjS3WIVomfLAig4eqmqFTFtsf+FCT8he9nQiewE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UvKPnzuw; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac3123c0f72so36850366b.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 07:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742137042; x=1742741842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d5WniGcPfb6n38h1pOlhzqn0mKTfUXjkb2vztGOfwG8=;
        b=UvKPnzuwmN4Fk1WTrfVFFGNlKQizDWPHpzTUrV80raiiJElUVzBsPSB6joDJ2wYpeB
         XRw/haMCCORSBJ50g6K9pdV8mUWw/U3WUdUb1IjOA43oKROjD0KbgP4jhaOyrZ6Duruo
         GlV9fPm3apafb2M74w7fFtVdBLmq8gJm1WdEq5Wp1Rwej1kMQNfy8jWzD4vv47bn/77d
         fS+UcAp4BwD/RFbw/PJrfIxcK+qrcDtf0+usvFtO4/lOszwJAQsfFiJwwQA3tK5mzTHc
         JjLO96vcG9rA3QE115xcjuk/AonEjF0uBeMR3N0BzssSZ7ql2zUABfqiUFc6rKnHYnOp
         fRUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742137042; x=1742741842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d5WniGcPfb6n38h1pOlhzqn0mKTfUXjkb2vztGOfwG8=;
        b=mYgjfMpytk6Gp44Xmaanm60Ob7YQOU1uZCcdjVWZoNBsfhaxYxU1MXbg1JBT1obyj1
         fPqQnc0YB5e8jPaBnAAYBhc7NkGq3gdJYCkUn26YgzY254CYUuCqDplyuH2zY86zXgT6
         GeRcpupYZEvkNfwiy0fodIsmalidkvOPM5uZgRlX2K7Z9OUMK8HZSciSvXznDJ5o8W8T
         g5LKhC+1zPr4zzSFofH/iozyGR7h9SePUvtBF+lqOviea7krlMow2e14zzBmKTivzMSK
         PFl1Rv/vNU0uroy18kkA63ipBKSbJOA1PnbQPZ6mQU44PFJnKXIHEd8ICRdr1cEtbvn6
         mHTA==
X-Forwarded-Encrypted: i=1; AJvYcCWZqEgJYEzAlZFDcc7FTy/8vKgQlLghqbI7qkRNopu12jnUA0iX9HpIOScuWI9Z8MXaN2bAOw1BYZLEKJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEyVNYb+/4wPzrjk87kHGSb2JmPN4lLUdgN4U9mUD03XalmMhb
	i78aYrlvZIO9f78OAs9fxyr2HDrvHMA41h+kKaoPLhme6tsMnqcd4v71EX4PalM=
X-Gm-Gg: ASbGncsCzJVZiryYJnoU5WqvS+oqQEm+zzgYIXvsiet4+EIFGYLhyzDDQu1I6VfJLWf
	ERLA0Zc741RoLghDl2HfvolnjG2gXBN0d1ikFKJLkpAyP/Udrgh5v9cg1eKKu1TOOpFgfvQ00d7
	mymXON6ZnmmLkscXTSmpQGhnwHwovThib9JLcrRz2951+5Xe4FYMF/fbLGOE6Mrqd0JyPPMnPCI
	hexCpirB94eUm1J01VRo99byCQgJzn+ZZUSvej9rlgs5OCsMXNY/5ktrkB3VF7mKkgFG8hz1pg6
	1m9Lf0nedB5E7Y2cldfzKIeFArODbQlE/3qJDn+n3B3h7iQF9X1M+labQA==
X-Google-Smtp-Source: AGHT+IHb0yTievEjvzDziO6X2mziIeBpmaw0xnxbvKlx4mQTF6IdapOSpgfGwWxdUjdUq5YfFfAONQ==
X-Received: by 2002:a17:907:7ea9:b0:ac1:4da:3ee2 with SMTP id a640c23a62f3a-ac33046d851mr301833966b.12.1742137041708;
        Sun, 16 Mar 2025 07:57:21 -0700 (PDT)
Received: from krzk-bin.. ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147ead1dsm515457166b.58.2025.03.16.07.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 07:57:21 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] w1: drivers for v6.15
Date: Sun, 16 Mar 2025 15:57:18 +0100
Message-ID: <20250316145719.19935-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-w1.git tags/w1-drv-6.15

for you to fetch changes up to 33c145297840dddf0dc23d5822159c26aba920d3:

  w1: w1_therm: w1: Use HWMON_CHANNEL_INFO macro to simplify code (2025-02-03 12:54:18 +0100)

----------------------------------------------------------------
1-Wire bus drivers for v6.14

1. W1 UART: Fix theoretical NULL pointer dereference in probe due to
   serdev ops being set too late.  That's said such scenario is unlikely
   to happen as serdev read would need to happen before writing
   anything.

2. W1 therm: Simplify with HWMON_CHANNEL_INFO.

----------------------------------------------------------------
Chenyuan Yang (1):
      w1: fix NULL pointer dereference in probe

Huisong Li (1):
      w1: w1_therm: w1: Use HWMON_CHANNEL_INFO macro to simplify code

 drivers/w1/masters/w1-uart.c |  4 ++--
 drivers/w1/slaves/w1_therm.c | 12 +-----------
 2 files changed, 3 insertions(+), 13 deletions(-)

