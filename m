Return-Path: <linux-kernel+bounces-530297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D13A431BD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 01:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 726133AD7D0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 00:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6537FD;
	Tue, 25 Feb 2025 00:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="WFXviq8W"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C04417E4
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 00:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740442236; cv=none; b=kabKs5zGTDsnDai2e1tDL1OPveaTd7G8cnebsjkQmnGDTupJ7TmraF6vP8PR50GaGXQdGu6D3o5xlwMMVSh3YavFZ7WQqfk8CeUecF3mqiZtRJNvur/g6bo5HCrZJ/LUi40+GtHPipCp3jXRfSgiyW6vMXWNdrEoEFeVJuKAS0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740442236; c=relaxed/simple;
	bh=3+7BH/bclvnMdS0LgnhN5P0SWHPJED5iA8coaLRxly8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OY1iG1kBq5+5EqSYFOgc3uLkKLT5tbwSPHSVT6K7+e01573/WRQtXflaVuxWtfPms3YbAOWS7dtspzmEXtCzJv4rL44jW1ba2xDnUWO8DmIvfqxECXFxsHkMx6m60EyXCsvsw2CNXLNzt3qDfx01bDPWK3PYyqbroCmkQ8EEjGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=WFXviq8W; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c095b5365eso327322085a.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 16:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1740442231; x=1741047031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3+7BH/bclvnMdS0LgnhN5P0SWHPJED5iA8coaLRxly8=;
        b=WFXviq8W4FC1lq9hwoOcCm3qqvFpeN7Cpu1DJBoOESQtJIxsfREJkoMDkjfURMz8oQ
         3HXsVje1ONjK5CO+9R8FVtwHwVRnVZFzuMA0jCOcL7s7lTcToYUchd6sv8h8QFUmWpWP
         tvIOmU+iXO64515hzl4RoHrP55krxgVL/3xKbOHa0SeP+UJAa8oKS5k8pzSOerkSYNw1
         scUUOteSfssXoz7yCwJ4gMLLV+U63G3bI5GDQc8NDwDbLBfxXUZn2RkRXYRDMkYoEiFE
         CaaWvFhxd5wbGiFlQqx6Vtb9wtoVuwX2j2cXAQfvtHXmxa7HI8MF//fvHQEQI58u1bJY
         9ljA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740442231; x=1741047031;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3+7BH/bclvnMdS0LgnhN5P0SWHPJED5iA8coaLRxly8=;
        b=hTHcPFVEQZ7hiWZtU50yGx6RRckz1LoMoRH1h9bAq1/JQTNras+ONbUn3iWO01JOC/
         g5pMKwDQPcKWrY/iW4XEu+oAdQS5zRUlFHXo2FIz9cQ81Of94kPh1bO+VM4DhawuSWqf
         BtT0JgTp1dSrur7FFK5/ahZRyKij8MaGImq/qF2vnqPmDEOn6ZypftycrI36T5lh+A2d
         OWJWpw5TT+eng8Q/2JhB7jeMAzVbisEcnSAhujRKTbdMnKqEgl4kTHtjBpiikWHwlopT
         zUkrREfQU1JYY+YZ4ZeS27v+4SbIUlkgNGCwqt54UGRlZES7hELfO+2cEWvdoBMFWUwD
         Dt7g==
X-Forwarded-Encrypted: i=1; AJvYcCUUIsbjsr0QeUUiBzYYWZsgYLUgq7GnDBThNH6RruHIWiwVXRPlK8xMSr/XwO+EIifXTByEkMtUikViPjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YytlhcZ8bSbrORV1slR4S+Bfu4eIyvFD+FMWO5JZqvjBbV6bWh4
	nXuZsuBxQnxS9XFbW8eRYXtrCEwjtObcaOMCnBco39C/lfdjpQiSt9LfNRiQc5M=
X-Gm-Gg: ASbGncs4IcZ7QON4inNzFbdJt3tieJhJCVySxnfpLd+ve3crCY8OPq2yPNVyNtMoOvW
	kkypsxzIZN2+nfTVKflDsca+Y0ceY9quHARVw7y06waCH1hUhrOkvYJcD3xdc2kN1+8itk2rLtg
	Pkgv9KwRI8M6Lh7Up1MpTnleIewS7n57MbSmLq1GyvLEMkh3r+6QixiGmgUY7O4SzwvHDc/b8o9
	wtcbVysZOeHudU4trot1Wprw9A+xhJSvXcwGAqdRa5toaYbI70MfJICxhKAqNs1BdTuz8GeDo1s
	quDLHdfxB++92fRcKGfAGMvA
X-Google-Smtp-Source: AGHT+IH/zvsmPStPGvK10yBgCkpLDdFhiuKn0MDncYI5GicNfgn70lIuJ3QUyfgqsE84jj34rQ7OGQ==
X-Received: by 2002:a05:620a:4113:b0:7c0:82cb:f430 with SMTP id af79cd13be357-7c0cef1056bmr2256780585a.27.1740442231357;
        Mon, 24 Feb 2025 16:10:31 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c23c33ce24sm37328585a.99.2025.02.24.16.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 16:10:30 -0800 (PST)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Brendan Jackman <jackmanb@google.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] mm: page_alloc: freelist hygiene follow-up
Date: Mon, 24 Feb 2025 19:08:23 -0500
Message-ID: <20250225001023.1494422-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

One fix, two cleanups. Based on mm-unstable of today.

 mm/page_alloc.c | 490 +++++++++++++++++++++++++-----------------------------
 1 file changed, 230 insertions(+), 260 deletions(-)


