Return-Path: <linux-kernel+bounces-398121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AF99BE5C9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 12:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87509280F47
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 11:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D051DED71;
	Wed,  6 Nov 2024 11:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aiven.io header.i=@aiven.io header.b="J9u4KoBu"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F411042AB0
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 11:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730893261; cv=none; b=OcprAv8JRJuV9ApCF9JwWfmD8dPPQxnnDG1c1MYfw0vrxIibMbj7/KWpQH3hCG+w9iol/Qf8a82Ma5eAXf923yBT5N2HwHoGD9iA4bBNXJAFRLx+vdj+Se6uGYeqPdnPAotMgjmQ+rWj0ISbENNfuuXkyzKrtxPfPUj5uBU/wMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730893261; c=relaxed/simple;
	bh=lR3BHzYJ+UyV5g9B+Lpd5GZdOu4D7coiM+7Iq9nUw/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f1Nj85VZsKOnl+lLnSZDoutCVuMsBRTedbu7itlt40GgA6XVWdlH4jJ4vZTlPaGteRxRoOdcJsRKU4kNGjeJeIxiDxRe4hPRWHrSA8EFFS1L13J56sQQvgohdTMdWc0D/2jx6Nitlh53l9rX/Ss4re5HzV+rCqGf7QM/0xTQvvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aiven.io; spf=pass smtp.mailfrom=aiven.io; dkim=pass (1024-bit key) header.d=aiven.io header.i=@aiven.io header.b=J9u4KoBu; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aiven.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aiven.io
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539e5c15fd3so6446185e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 03:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aiven.io; s=google; t=1730893258; x=1731498058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ySISSvlzxGmhoArGiKFmusnd5mBhAFrK+lrvasOrzrU=;
        b=J9u4KoBug/iW+3tmd4aho9CTqL+2qTUSky8XchTKsjhELKtlrmHIu9Eyz9gZPrEnsb
         KXkoqCsP1w5dizeHaBUxANWFCQCr70k3laR4o/kYO1Ex0KnNvW2K4lCKyc32I36GoEaQ
         Bq4R+roe42KcUvyX2pLNPG9QPAR6izBl/CLVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730893258; x=1731498058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ySISSvlzxGmhoArGiKFmusnd5mBhAFrK+lrvasOrzrU=;
        b=tP1Nf6Su9En7zZ/3+S/xkjZBlys+VO1sdq1epNsYfVSJetdei/5l5nKAisitdmBBz0
         CmstQ/GtqN6aX71HRkdQE1hi9Ll75kVDIle8Iy1BOvpY0unaahh5dEAG6aWUD/RAbPeB
         cr1JooqsFr+H+mJ2m4zvEBdjPnEop5uuCyRR07OU8xaOFCspr23DmYnTMTM3TUg1d+dY
         UMfN/tsugfnzTI6sY5M6oRDhCDOioOPkqdXjctMzPlnXJpdU2GvCvTXo3fdSlIQ6JsJA
         LBOzix7i9qJEku3zdhK7pmwWwnuDYa0zz2TDyaGDhzmLq8KDZl4dTWvokJHUaOo9G3sG
         04QQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0BlCuLq++ZXmoCO3Bmws9K83QhmmqYKk0J6B5sWEFgIWoQap1m1ne05Ea/NOBHQE2WO/x1W9NBQbDo1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPWpQZkA3A/u8Lv19F6VjqRgqai+bTZsaNoSmFgLYmPKk2KLGT
	3DIH6tH8urfzRYjCsdJbNNbz0KS6LgkOnKXkZ2aLXhZ6aPl9AiZN7MBtbKLEbrA=
X-Google-Smtp-Source: AGHT+IGCHVL6P1HXUIFeV1W/f48tEQy51ZzoJzKtvWFdHm5yoh0RdI0mYxcLchXItqfbpw/xnKBozQ==
X-Received: by 2002:a05:6512:398d:b0:533:711:35be with SMTP id 2adb3069b0e04-53b348e154fmr20203489e87.26.1730893258143;
        Wed, 06 Nov 2024 03:40:58 -0800 (PST)
Received: from ox.aiven-management.aivencloud.com (n114-74-229-70.bla3.nsw.optusnet.com.au. [114.74.229.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057d3f87sm93796755ad.249.2024.11.06.03.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 03:40:57 -0800 (PST)
From: Orange Kao <orange@aiven.io>
To: tony.luck@intel.com,
	qiuxu.zhuo@intel.com
Cc: bp@alien8.de,
	james.morse@arm.com,
	orange@kaosy.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mchehab@kernel.org,
	rric@kernel.org
Subject: [PATCH 0/3] EDAC/igen6: Add polling support and allow setting edac_op_state
Date: Wed,  6 Nov 2024 11:35:44 +0000
Message-ID: <20241106114024.941659-1-orange@aiven.io>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you Qiuxu and Boris.

Here is the updated patch. I would like to propose that we keep the 
edac_op_state as a module parameter. Because it would allow users (regardless of
CPU SKU) to test different options on their machine without compiling their own
kernel. I hope this could lower the entry barrier and make it easier for them to
test IBECC.

Patch 1: Initialize edac_op_state according to the configuration data
Patch 2: Add polling support
Patch 3: Allow setting edac_op_state

Thanks. Please let me know if there is anything I should improve or if anything
does not make sense.



