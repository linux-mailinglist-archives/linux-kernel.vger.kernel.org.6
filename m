Return-Path: <linux-kernel+bounces-548682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54842A547EC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CABD91892933
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67EE204F63;
	Thu,  6 Mar 2025 10:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jb6eQ7qd"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816311A76BC
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 10:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257427; cv=none; b=I6wTmaiAygHAo6GfWMvZzjfO900fLS2aUCfvHdo57YJMGNKlabjxNfQEVVsmzD+Qcn9qlxvMj2mX0748DwBIdUBZ/WZvQ8mjkSWsjzRRXgparxN+JnGvlCeTpBYzLyf+tEbnWE7wgX4NtBOI7cCeya2kaQay33gSHasZ9krx6KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257427; c=relaxed/simple;
	bh=fTXXbYfB0BUH1DTF0YolYq7hexyvidsXazu4RK0mlKM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oG5UP6wFkdlehvkO25Wq//Xtlyxcx8VGiOj5ExS01rEYebcYtZboofDmce4OC/m05ewTQCuLhhWIPHw/qmAgNe8boiiflimJTp6U4F9Vg+/fJHy/j/k8ZjK/5LrLNkV+rSCTvwplBkxZrOvDrIecXk6MNOsTqfPknPCUHoP4+PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jb6eQ7qd; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2fecba90cc3so1069172a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 02:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741257425; x=1741862225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNjPZDPj3mGb5UUG5cx3FWB8PP4SBA0xRr+ffK+aNvI=;
        b=Jb6eQ7qdtYYt67lsClY+ejQuLYzAol/A07wk7Kid0aw/Fap9uadL5XVakMLbln2Gag
         QDwJ3WqfHOPaBhfFbyVpNb3uSQ0oGpUROvqc+JWNYrkhASqbijW+x6D6n4fFyMn6aDgU
         LcPy4JlyCbG8DPSIzL/WV9vxgmOjiYHKgeIhSgiJm91vzCa/SKRu7rRl3qpZsKW0QRdz
         555cjpY9nX44gAAYpuBw19SAeebJup8x5FJal9f3eM0s2YyNNts+B6oiDSlJ/DGCuDgG
         i8NkOtCWlu2QlPQcflCp/tHtqtxTNmULiBVeZg6Y2j0669YRpoqGleUuOemo5q2iC7S1
         bPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741257425; x=1741862225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DNjPZDPj3mGb5UUG5cx3FWB8PP4SBA0xRr+ffK+aNvI=;
        b=JQk67M4dLE2LDtt++V6vkxys0qTPdTYHmoAg2H7/7akZUwRRNAyWO3ESlT3UF0rAqF
         /fT/6gaGECy9mVUGdjd9lXd6Y4jBwu9wkaaQT4qDPpfUzRYm7TDNYdXVlv0uHNMUFUve
         EDNheq4HgEcROHzU5IaMxsl/xXoGB5wfQxCAujtfztLkwL7zfzkr01De4Q7qfOv+0bob
         ODlzXmHblGZwBu/5jx8uR1b35v0zjnyA6uF4BINw2Kbqzl+IsJygTPMpCM8oL9orlMAu
         9KEanW1Db9UzirHj9u8ABzVg8/ederEum/Sf++hD6ULHoBQjyd0VtsOduw9fdO2rS4Ii
         bXLg==
X-Forwarded-Encrypted: i=1; AJvYcCWBhLMzvHkdtCognkRmfYWbtB2amxpWb66P+jU3aQpHqibZFwzaHu8OVNAut5bdXEYlBTUkBquxgtgftpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeNWptKIcDUusXzMI8OoZwyrUy8nJA5wcmLEcL3tk8cIL5RXZf
	NEjl33vNNtJsui3uKBEnocOt1Z719pkM33zEJcRd3iFnd3z1vxkyM52AESAa/ig=
X-Gm-Gg: ASbGncvxPPkwoAOi/B5DVhxNnceJtpge1Yx4e2zkKj6YdMZ3ikvAuuNtgWQEeO8d83I
	02qiPLNeJ/w2w3rHlyJeYT6T9/XN7BB7c4jRqNlnDODzfde8AEVsTWM4Lp7HmIF/DPyDj1rDECS
	CzOJwXyXfs262hXfHJQV4WItx+BuI8iA57DtKXY5QYCvWpSnUNezJtCgV/ULsynKk1gxAPTJT21
	DL0s1Lg5316TSvsNleiOdX9JMKs6tigvR8n++i7f3alk/uNoBvfMk7MySF53mxgqROVyxnmDR+k
	KwFF3YkFUnkCbVXBEg/iIBIlBsclUp0SRDwht/Mlm8WYyA==
X-Google-Smtp-Source: AGHT+IFuHhxzNVW3SAvDc0lqxCLDXj0WNJFxJ408MjQuPeCbrBOBGhTaE+toj4Ao+lcoYjY1bISWkA==
X-Received: by 2002:a17:90a:d644:b0:2ee:9d49:3ae6 with SMTP id 98e67ed59e1d1-2ff497a9954mr11062064a91.10.1741257424731;
        Thu, 06 Mar 2025 02:37:04 -0800 (PST)
Received: from localhost ([122.172.84.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e75edc9sm3143776a91.10.2025.03.06.02.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 02:37:04 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Yury Norov <yury.norov@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] docs: core-api: Update kernel-api.rst to include cpumask.h
Date: Thu,  6 Mar 2025 16:06:51 +0530
Message-Id: <3b38b431b4307829aef6bc0c17e19d363f86657f.1741257214.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1741257214.git.viresh.kumar@linaro.org>
References: <cover.1741257214.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Updated Documentation/core-api/kernel-api.rst to include `cpumask.h`,
providing better reference for CPU mask operations in the kernel API.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/core-api/kernel-api.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/core-api/kernel-api.rst b/Documentation/core-api/kernel-api.rst
index ae92a2571388..5817632381f9 100644
--- a/Documentation/core-api/kernel-api.rst
+++ b/Documentation/core-api/kernel-api.rst
@@ -90,6 +90,12 @@ Bitmap Operations
 .. kernel-doc:: include/linux/bitmap.h
    :internal:
 
+Cpumask Operations
+------------------
+
+.. kernel-doc:: include/linux/cpumask.h
+   :internal:
+
 Command-line Parsing
 --------------------
 
-- 
2.31.1.272.g89b43f80a514


