Return-Path: <linux-kernel+bounces-517391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B851A38032
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2B543A5971
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C322C216E20;
	Mon, 17 Feb 2025 10:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GL4C5LqP"
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB68101FF
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739788263; cv=none; b=Ava8gUcvAoRjP40qq9u1KRP71eWscEfCi0FKNV67V8cljmT1UneEGQmtUV2ZoWrzv7fpN4uO0Us4r6h/Z/hrTdW6M9NOpFkNNhDvJVIImvEqCVZlwBLTtCpZYC8wtMS+hDNUe5z+E+ns1NBZ3pZNI4Kn9sPJYWMIbfuiZyhRGGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739788263; c=relaxed/simple;
	bh=080Z4wK9EH3MjqeP8zBi2rpewLDDrS7pCi1DZ0WVkE0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jdGEfgLidDFsapgZn0uat7NhWeWoAoW+J3gotpWP5mmJRbZ++BNg+3GY667C87vC4rqa3OMBNBM5QFnb/zNHNAQi5imYPntV3hLZtLmI/mPKdJ6VWA3YY7xB9EPG6kDQnAWuIhOpeWh6eVdjRFW59a8jQLJW0AYavz+SKhkMVtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GL4C5LqP; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-220d601886fso53884055ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 02:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739788261; x=1740393061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=85D9OooNZswo11gxtTbtf41n+VaqASeLQXWypT0ulVY=;
        b=GL4C5LqPCVnpFEhWqNSsFNJlY2EubfSSRBmmTyRBvlm/h/cfUZbAcgGgohyuJ2f1q2
         QVxWWGHaALKRPIDTJQEaFbEn5PQ3TkBkGgFKx7YRDfLhHcxmSGhc6KCxGW0aQbSbZhYV
         aRjVC4cMLNFU8P5dM5letVdzVnKHH4sn/slE1QR2ntR6wpEaPRLquj4/B0NCfrMBQ5U1
         PEQ3Q24fWup9KBSoQ9zZYbaXpGbWYh/pfTcCEKZl/o9eZq1qRL9q2KLuiUYKvhHiFEQQ
         BTcLwB1L7sX4ej/jhU1s3kEe6812B0E4HmdZIiz3+Ik+xWeTsn65a7iajsnt0k1rSyIF
         UZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739788261; x=1740393061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=85D9OooNZswo11gxtTbtf41n+VaqASeLQXWypT0ulVY=;
        b=npzC6ZiHIQbtL1SREXLx8JLZ8rf7hoUlHUUrYNJeymuKNkoZUI5rQWU6M75aMHKKDJ
         mulELbn2ppyU5Hk1KbJsMeR52nkIZxjQobfLrolM3EO+smkiwtbvEyWzvBJi2YnmzW3r
         pMS70R007RgGTkljd17B25iBeepv8uSgqx7U45SyDf8pu1hDWG3LOXiCCLYzmoq6T7RK
         vXFLi+v4bF+8Y48+7AqYbb7aCbonMqKSTHneHO/1fMKl4MYZlHh3IMlhl4P0lYTmVkBL
         SJrPXBmcP/tZCIr3pRlyPPwXX6bYOVKzx1HCdpD+B0UU55LKWuogDkTb4dCteJBXT65s
         O7qA==
X-Forwarded-Encrypted: i=1; AJvYcCUO+T4lTAP3+OiyEofBiJ1wYc53YswCIiHw5dS4YIOFUTs891FeREVh2ATdHk0O5g0EFPbhCzT4Z0ErXMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVApt2VlGYkJ+6PIWLVPaDr9+NrhR94ro5Yi6DcXbz5EDF6oji
	KEZyhjdgv+sLaW9HUU7+FcU9jWk2+1l4TEEt19ynyrwpMvR66hcsolNjnXwf8DE=
X-Gm-Gg: ASbGncuiucvjQ878QxDMH9u6jUUIMuXxKHD7e5bLrdP9X6MXXawr59beUxitSoJixJB
	zDOTIyo2qJDfan1A2Ibt+ABR8Dl+93TSV+9o1K7O/dDLiPADmVV4w2+GKBNQOorefC/IbAb1wAt
	/TUvUCG8LsHBpBbUmB7dvfqqiImc6ZrsYbE1FdOjJWbwmb2uS/Lz6O/RDslo9DKAVoCzNDf8Lbx
	TwVQD4lqfhvnSIaP1quXGgun5xA7yIVTKgb/izZjxuBKz2EUwmO1KITNSo3Sss3jLMbifsCkHXm
	5/X/TqAoB3YuVnVOAjS2
X-Google-Smtp-Source: AGHT+IEQaXTY1qxk+NaxY51RFRu2PEcSWfy909O9l//GMcEQq9KicCAyb04t28KVbM1eaJWJZDdA1w==
X-Received: by 2002:a17:902:f54e:b0:220:ca08:8986 with SMTP id d9443c01a7336-2210402d6b2mr172061855ad.22.1739788260979;
        Mon, 17 Feb 2025 02:31:00 -0800 (PST)
Received: from localhost ([2409:4066:d04:319e:1d76:db25:b6bf:4f52])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d545c897sm69294305ad.118.2025.02.17.02.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:31:00 -0800 (PST)
From: Ravi Kumar kairi <kumarkairiravi@gmail.com>
To: dpenkler@gmail.com
Cc: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kuba@kernel.org,
	dan.carpenter@linaro.org,
	rmk+kernel@armlinux.org.uk,
	Ravi Kumar Kairi <kumarkairiravi@gmail.com>
Subject: [PATCH v3 0/4] staging:gpib:agilent_82350b: Code cleanup, spelling fixes
Date: Mon, 17 Feb 2025 16:00:34 +0530
Message-ID: <20250217103046.54294-1-kumarkairiravi@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ravi Kumar Kairi <kumarkairiravi@gmail.com>

This patch series addresses the following changes:
1. Fixing spelling mistakes such as "havn't" → "haven't"
2. Removing unnecessary commented-out code
3. Cleaning up whitespace and formatting inconsistencies
4. Removing an empty line in if{} which was causing it to be read as a single line

These are minor changes aimed at improving code readability and maintainability.

I appreciate your time in reviewing this series. and I'm deeply sorry
for the spam beacuse I messed up last time I sumbiited
Thanks,
Ravi Kumar Kairi (4):
  staging:gpib:agilent_82350b: Fixed spelling error
  staging:gpib:agilent_82350b: Removed commented out code
  staging:gpib:agilent_82350b:Removed blank line
  staging:gpib:agilent_82350b: Fix Indent issue with block

 .../staging/gpib/agilent_82350b/agilent_82350b.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

-- 
2.48.1


