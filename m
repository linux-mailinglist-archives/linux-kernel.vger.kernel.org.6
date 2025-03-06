Return-Path: <linux-kernel+bounces-548680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAE8A547E9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCE9A17120A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5754204C26;
	Thu,  6 Mar 2025 10:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JYy3Ql5/"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEDF1F63E1
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 10:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257420; cv=none; b=qgN5PLhWSKyNAXUmhPR6w1PIiTEokRDVmR0HvaqjPCsMrdNAFObWloTt9FRCaNwsmxB3133EWxlwZn0ht9drSjuaLhGTnDj1kGTm2aS2dBj3/DkIHfPKRUzN46t4At82nfkqXTaV+3wl69EBkHy4CtXYTCRrJWPwpyxRnw1pT54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257420; c=relaxed/simple;
	bh=OA6xas3OZHH2hAK748oTfdeYdg8otpDLDOU8Exf7Z6o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XACv/X1KSQSz0kcDc8iJmeAP+RpYSZnSSJktXCAOIG9VjdpXdhk2tH7m9om4G5ojrWF2OFT0ZeAMwAPnrAbOswH15f0wDv2H3OBv6xmPsMCXdSDKQSSyErrTkAS/lbLo10uD4d8SD8gfMBMYolWwlAKxxGp0KzqE3TYeYGYMNzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JYy3Ql5/; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22398e09e39so6758305ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 02:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741257418; x=1741862218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yiXjEDf+juP/trg+zOJtHBIF6nQ063y8G2qUqzF0lO4=;
        b=JYy3Ql5/dA/oMBM5NHZeN8TRYhdr1JH75JOO+4t3O5t0QsXeS27QkFPQlYFuOLXiaw
         aHO3f3a0VlcCjlDhCvow25vkYxIoALrjK+F+/LzGPcuZXho6YA6TS19qj6ae4edmUPLf
         VdTr33uHUmh2N/UzyQnWgg6tqDPhhGKvP87KP5ttKNXBF6OXHgKPmQ+AvCs5oIPUuTeK
         QhZCINgWttOlSLJ1twcX4UhP9XT17Lpv29X7CjBM6bwpF69iJWO0L/KV5cWs2CLicpYS
         Y0E46oqa9L//7DYKsLv1sUTQx5jZmmzLb+qDDM2fwlmfg4EQPYQgSBLpPjSYATKvWg0q
         yejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741257418; x=1741862218;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yiXjEDf+juP/trg+zOJtHBIF6nQ063y8G2qUqzF0lO4=;
        b=rJzGQMo64uP9Npj9yWC2LP+6aYFyQoMj+SYrV7fqDpcHUR1K4hr5ViNiBlO2MZju90
         2U/UD+mMDdCdt5EyvgVxKtwYUC8v4DHfaMetXLcnlC7sxlMCnog5GIKltRNxV08gQ6tf
         HmDnM73pnwh0DSgekZpS9PwkBJwY/jeZBeaEe503QoyA+bCLdfr/CM1W8pTfR/hh17F6
         cvX9lffZ3SEGhrEV2HqVsWM3+8Vl3ZqvPOe0ouPBU+lykXEpZpHih4svatfsZoREF3Ow
         QFmVpnKcGbueB1CqlWHoe5WW/0wc5p5Z4zE1dRVEGhxhiTu6sOrC5s3T8B2dBezh+ZRI
         3ZnA==
X-Forwarded-Encrypted: i=1; AJvYcCU5U0cJYsb/A2IFBKhNrxBISYMZgeb7mD65TPzlEHzQNLaof6pXM81Kr+ogYjn37eF3j6dSOlyLfeYv5fY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz57V10Y130qNf2t7UFdi6VZU6FJvuC9Y2XxE927TbLvdNH5d4F
	RD5gYvHs6lwUs6vanADFHvlK2T3gTMEf51ZYClSnv7OYzOBnCSSxYvJ463g9iuQ=
X-Gm-Gg: ASbGncu7gvw3jKqEWsV1uFbEHRCGILzHV+77GZ/etogoQg8o5BbMceO0h/Elvc+edKB
	wN2yVwMx4WdLF4ICdxz9Tguvb2RQ8OBgqeeTAuSBTSumYgeFQ6R1k0hwOrxEQFrqNhKUx2ldR4N
	oo8+A9A6Vty2gcrBignZGva1eO/nJ8MyQ88oHsygECc/1RbT9juXvhHawuRlwenlP/oaJMgZspw
	f1LrzcjXiU3ej93f/Z8kwzIPk1ZZ2C//aOMIm51XGeDowHVAu25uo/l32jVfeCXuYGyxLoUNpO6
	mHBVzo+UKDlqQupW3t2w0IosaIgRBd2HT+2CEx2o88AL4A==
X-Google-Smtp-Source: AGHT+IHcMs+PV7uDFH/Rmpek6rv3YjbBK9IJnCI1pXQAz+dbkjHnKWAHcDTLLpfw3p4Tp6c4UwMheQ==
X-Received: by 2002:a05:6a00:2e20:b0:736:3954:d78c with SMTP id d2e1a72fcca58-73682b737c4mr9197455b3a.6.1741257417710;
        Thu, 06 Mar 2025 02:36:57 -0800 (PST)
Received: from localhost ([122.172.84.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73698206eadsm1033435b3a.16.2025.03.06.02.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 02:36:57 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Yury Norov <yury.norov@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] docs: core-api: Update kernel-api.rst to include cpumask.h
Date: Thu,  6 Mar 2025 16:06:49 +0530
Message-Id: <cover.1741257214.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This includes cpumask.h in kernel-api.rst and fixes some kernel-doc formatting
warnings/errors.

Viresh Kumar (2):
  cpumask: Fix kernel-doc formatting errors in cpumask.h
  docs: core-api: Update kernel-api.rst to include cpumask.h

 Documentation/core-api/kernel-api.rst |  6 +++
 include/linux/cpumask.h               | 65 +++++++++++++++------------
 2 files changed, 43 insertions(+), 28 deletions(-)

-- 
2.31.1.272.g89b43f80a514


