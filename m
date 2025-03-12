Return-Path: <linux-kernel+bounces-557703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5297A5DCAF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0588516E1BE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEBE24338F;
	Wed, 12 Mar 2025 12:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OyNC9Wjo"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F356B24290F;
	Wed, 12 Mar 2025 12:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741782682; cv=none; b=NAH7iYmpJaqgaMFpMgmddEjwSlAv41RMFcqSVBFrhUnG3NiOME2X9X+BkWQBI1CWWfN7dcL2i8959GLHqHVPO3HG3ZMvs58nIHN7RCKUN5jpS7TpYNhU0Fo86mwG0WuAgqgt/x+kEKqdg2CrahsvRVrwzAAWMDRm0UGsi7g0S2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741782682; c=relaxed/simple;
	bh=tnONY/RQNvtZCto7VQopTVIp60hfgPw06GGqWWW+rKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hYCC48lBfCD0Vsbp4Mf7dwGQDlKkrCONQ4ShvAjnB9rmx5f5rfIAXWpH8qrmfFIg4hF25BZuIV2OISfVD9FjI8uxGDsQqJ2JFwXQkEePy0UUcwO+6XF3ScswU6f/oONPvPfQHQHLV+AQtfFVl3agiByITEKg+oe8nXDRK2Z7ZkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OyNC9Wjo; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2feae794508so10059520a91.0;
        Wed, 12 Mar 2025 05:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741782680; x=1742387480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eH+Zc+8U1jYlMw4XPs5Gy6C78U7mqSd1LPiePviwPpM=;
        b=OyNC9Wjo1VtK2txr9fYwne0QEwMVmWKmt+3Tz1HpIk41v6tNlW73M+2j4bed9rSrr3
         rX6z4eK4jQRG84N2CkHVWbFLvK/8QzzSo39L54MLafYvt6cFh1RL9UOPQ+p6I8hO+nyR
         3jeQSVLzzYNqtAj6uYcDlTDZfeddCpu8G7UA8NgoHkN+09EIScXNB1Fukk1NoBCuETyc
         Xwh1Jlc0I/sezCOlMdIeyy5HZtLQ3bMudsZ7cfRzICLjrtGYbzMygTOPplYkoq/jj041
         eCNsqQG6sIvdVjDMqa1krOvjMYTNr0WdepY06Vhdx3wFmDlmmELCT1cNOydCtm0xb4H7
         0osg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741782680; x=1742387480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eH+Zc+8U1jYlMw4XPs5Gy6C78U7mqSd1LPiePviwPpM=;
        b=Cxu461JWXWJd8JhVxkrlicQm92cvtToBQghnhgsJ1PVmAKYhoewqR7sN5sGs2kaDv9
         nSYcP7FR1IVFeVE25XFXefzlur4R5ESejJO/8ZcOWEivp7pt1W9Gk7DCBXOKUu5OhVSt
         Coly1qCO4Ij34QDQ2TKzGyb3SDt6M6s8Hoz5ecoWYklpgKB/t8YyPXtH35/MBYQN0Pp8
         CddWSOv2b7gQpKMVavlBvYPy4BezWgVdw02Hs3EOTAbV2bi/DZvOitoiS4yRwEMuoDCD
         3n7NRCmVQmGIHb0XOTSgmzMgkl6ZSbNB0TJPyBO8udN93wjE1ysLWNqqufrFTrpOlO+T
         ESvQ==
X-Forwarded-Encrypted: i=1; AJvYcCU96EXGCMVAo0q6clXmA8evt4Ef8PYSzfemBieV+M0Il+zpVXprowbfQ0pB1JdRhn9c9cu0wYZkknqD8w==@vger.kernel.org, AJvYcCVyGGOcBGvjQQ7DUpusB0HS/OFt5jn4fLzHVEpTi7N6vdeHaA4XzhhFnbbslS6TDoqZpdnW+9xx1MMfDGMh@vger.kernel.org
X-Gm-Message-State: AOJu0YzFDbcQQwLJElzH7DRfgNAKMk732Pewz/UEjwDfbk3dQHA5KKRs
	hLZ3rsDrSNNlakia0ed8zGm8KxqpSsfidlVb+Avau4xgBUjGAW5K
X-Gm-Gg: ASbGnctG35V6ORW1v0JKoA7JEcMraQvUz7G9cX4JzI3RgYX/BXMsgNo008M6mSpY7zc
	BQFTQBxs/KBBLYEdwTuzNEB48dtMZhpDRQ1TqpF+NvEoqwtxD/Uxe3nn4kbmiQjdw9wNJQX9zWU
	RlD4uwhz7ik8qrRbSk8EnZx6NzI5xrU7du3dtNn7kQXtgmbE32sb9oo9upq4Aqq1/xCWNvJZ38x
	SEkJ0qfW6ezyYmaVzERPjk1EJi+JGOhDN9lTNldJSdKi5lgcZyHpThkDO7fTBqNhwLocCoPobGc
	Bjb4nzrJPOrc6Uq66u3BwCQ+5wVwvMuGxGrn7LYnBZZPqZZ1zgJmaKWetTF0FHE5xwBYJxMUbJ+
	ES9XyLq79vrjsR+qkPZDYzEzP4gA=
X-Google-Smtp-Source: AGHT+IFKIpucrjHKP6RPGNSbjQYHspWO/KRFesWXHu/MzLghXPt3tbmvQDG6mnq+Rqr2ja54oh56Iw==
X-Received: by 2002:a17:90b:3ec2:b0:2ee:f22a:61dd with SMTP id 98e67ed59e1d1-2ff7cf22ac4mr26845681a91.32.1741782680074;
        Wed, 12 Mar 2025 05:31:20 -0700 (PDT)
Received: from kernel-Apple-Virtualization-Generic-Platform.. ([2401:4900:8898:8129:deb0:598c:ebb7:dc81])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301182181c3sm1621784a91.5.2025.03.12.05.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 05:31:19 -0700 (PDT)
From: Subu Dwevedi <messigoatcr7nop@gmail.com>
To: 
Cc: Subu Dwevedi <messigoatcr7nop@gmail.com>,
	Henrik Rydberg <rydberg@bitmath.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Add support for newer macs in applesmc
Date: Wed, 12 Mar 2025 18:00:21 +0530
Message-ID: <20250312123055.1735-1-messigoatcr7nop@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds MMIO support for newer Macs in the AppleSMC driver
and enables fan control for these models.

Patch 1 introduces MMIO-based access for AppleSMC on modern Macs, replacing
the older I/O port-based access where applicable.

Patch 2 builds on this by implementing fan control using the new MMIO method.

Subu Dwevedi (2):
  hwmon/applesmc: add MMIO for newer macs
  hwmon/applesmc: add fan support for newer macs

 drivers/hwmon/applesmc.c | 347 +++++++++++++++++++++++++++++++++++----
 1 file changed, 314 insertions(+), 33 deletions(-)

-- 
2.43.0


