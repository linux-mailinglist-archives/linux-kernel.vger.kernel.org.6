Return-Path: <linux-kernel+bounces-283665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9606494F789
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 21:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EFDC283A27
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 19:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B601917DA;
	Mon, 12 Aug 2024 19:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3564UlK"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BA418E05A
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 19:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723491444; cv=none; b=DgZCpYbK48yqgMR6uObSTHqCHsIG2c/Jsc3GgDG6qXZ9FsqXykOth4BmczI8nlTphy/jb7zelOxzI7hrlBaLi55DMkGubcvQ99MsyI6jNRL2jdJhMMWtGaS65DiYDi3mMl2C+KjghWQZ0ElgESeRjQE4Nb5u74lcYylf1E6uV+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723491444; c=relaxed/simple;
	bh=Rxx+DMoKnMaSXPEAm9seNFSlpcb7ZMKSV/nNzg3wsb8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gLX+K2I1Va+Jvb43QMeyfIFy18lLMjoygurtS6tr1oYgJCc8f48tMuQZYzc+0aIztWQrspxyNx8eX/oDjBZcGQ8ZiOZQwjAEOQ3jd7DqgtZ+LliKYRgd8qN+GJqpYrcHHcYGWpFIr3oimIjeeBXgt2RSUohR7RLp6YJvIV98j4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F3564UlK; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fc52394c92so43763945ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 12:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723491441; x=1724096241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rxx+DMoKnMaSXPEAm9seNFSlpcb7ZMKSV/nNzg3wsb8=;
        b=F3564UlKG8bQl5TPE4VC4UpmwPH5CUK0CessBd0ixrtOdql8rCWogkw78HB10XdnmQ
         bjj7yAwuEDVU7c51VLV0EyoQmCD0rYS+tKlGNvAXNFX+NKf4XB68p3YqMdV2GrIH99Ki
         ziiH9cnSjWgqDzUDuDlV+RNuamFE3zp14pBFvTgWdVR9gRppR+9YD8Sjq0/9Ql00FYwb
         lSY8KUufSoW+NmEBiTaMxXli+xF9x9+sTLoDdh3RKt/I94GTEE0pY2rpEYCy0iEWYAZi
         6xMW6veEgkp1oGeDVagETmWjEt7N9veA3hWQygIuDa2jWuy6j4WViKpl9K8lXmG4v+k7
         /Y1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723491441; x=1724096241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rxx+DMoKnMaSXPEAm9seNFSlpcb7ZMKSV/nNzg3wsb8=;
        b=oPLC6CkGuq8LDWRaX/0gPzuuG3CbAfFv1uBlIxbycHeW9l05Q2vElw7ZHmPQ+TrDkN
         BQ/YDPfsdLLh0+AgnfrjDohR9YQZ8r/NZi3f0w8NSlhAtTG2rccXsQnf1I8JpRUsjbZ2
         r6Nb8mA2pn5kYg0sdlUXsyGbm6yi90RBUMzZL9BA1DfneBnHW6vVhz38Z1mS5KsVYepj
         LhmURGjfjBqxL3LdR/XI6cnOcJ/9SBZLmybLO4yMFh0XO2Cu/FDYnUXFyJGjt2LtYzwW
         bKN6GXl+6BgY9hV+OkmcSFHm/v9k6R6kg2YMDEd9SzA9DBpT6ytFpdXKUWh4bVhepyZt
         By+w==
X-Forwarded-Encrypted: i=1; AJvYcCV0QqvZ1oSSkoz0zCjr91aaGmpvXe0HrrnFGovivILojfWcU2635NTe7t1V+uPDcAP+BZLqMdTykge0zPFTV57aqvKOM0KXr17DTZ+5
X-Gm-Message-State: AOJu0YymIXEW8/hutMepCMboF+0Ygcfa9Wg9K/P7uh/3gzhJni2u9vR1
	7kumKrBTAq+KiwK86gV+sEvSKnyUODQ1EwEL9kUofqPjaVuZhUGB
X-Google-Smtp-Source: AGHT+IFIyrmDNlSikdo054BBiVyTFfoxQOYL77pyuRHcWQTEILqG0SAYU1sUxlIh6LQiJIzM/kDYDg==
X-Received: by 2002:a17:902:c949:b0:1fc:2ee3:d45a with SMTP id d9443c01a7336-201ca12a60dmr15961945ad.8.1723491441309;
        Mon, 12 Aug 2024 12:37:21 -0700 (PDT)
Received: from dev0.. ([2405:201:6803:30b3:3671:7e47:70c8:c710])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1a939fsm488965ad.169.2024.08.12.12.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 12:37:20 -0700 (PDT)
From: Abhinav Jain <jain.abhinav177@gmail.com>
To: jain.abhinav177@gmail.com
Cc: airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	javier.carrasco.cruz@gmail.com,
	julia.lawall@inria.fr,
	linux-kernel@vger.kernel.org,
	p.zabel@pengutronix.de,
	skhan@linuxfoundation.org
Subject: [PATCH v2] gpu: ipu-v3: Add cleanup attribute for prg_node for auto cleanup
Date: Tue, 13 Aug 2024 01:07:14 +0530
Message-Id: <20240812193714.1094339-1-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240704132142.1003887-1-jain.abhinav177@gmail.com>
References: <20240704132142.1003887-1-jain.abhinav177@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,
Can this be kindly reviewed? Thanks.

