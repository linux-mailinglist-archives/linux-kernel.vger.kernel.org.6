Return-Path: <linux-kernel+bounces-562373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3EBA624D5
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 03:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83C49883047
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 02:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5642818B499;
	Sat, 15 Mar 2025 02:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPqmGaGm"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5288111713;
	Sat, 15 Mar 2025 02:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742006615; cv=none; b=oMsfZUMYHxf9p3tmwSb0nkst68Dvteytlgtd4hNLtOKsaaYhgyg+9WoT+6tXpum+1glfnenUiFXaNYIt4nkqWEmbwUT12cQ/komQfJkC4QSbkw5f8trLmSfkBd8t+hORW2tAol3QGnOZI/AbbXff4CG9mCeOCjbOBYrYBYS4x5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742006615; c=relaxed/simple;
	bh=GlntjgU3Lxdii6DqpKNjs6+MaX1eRLZ0d3LBMTa28eY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z6h59vC1B7lCRpX3Q1sA03LdoFuftbyy4eScpVIjvlUi4xkpv3vGQvBiujrJqxKxqslrVfC7/klya9VkQAwoJZlZ/tgV6bmqNOXVFtGUcoexFa7/+m/hBUfz9aiKOtkwsno1ZjMw1uQEqagQjQmbZYrGp5OSOm5X+gh7xms4tg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZPqmGaGm; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-72a145521d6so1908736a34.3;
        Fri, 14 Mar 2025 19:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742006613; x=1742611413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MibvrQXj2P5QnlDxX5YbYon7Ne8dH6XMjJsYnk+RzkY=;
        b=ZPqmGaGmoYNJAtfzfsci1WDuJQd9Fh0XCGGImHJILodVGZRd3kjf1NZIrsZHGsEkG3
         Q0W2E0vAqCmdKDBU3bg9ncLzaGO0mOkmeF9bqLOSdu46/Zl/uecnaddy2bmjzhKoD7wu
         +3MuUWKSvAs2pc0WnqssGEaXfBwYImE/FYVy5NSjdgFpstuTSJrvaXN4GY6KaPujvrEj
         tJrHaLudL4RagYjOCtmZ2vxhfMxA3SMzp7LSeF6k2zxZrPYpaJIaOuginSAdEmKFdrIR
         WiLtrZeXIBHyIX5oK7zhAF9Q9sSKIrrZbOcoNf6n1zqb3on0ic5zX8AijmD8JsZgmyOq
         9zoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742006613; x=1742611413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MibvrQXj2P5QnlDxX5YbYon7Ne8dH6XMjJsYnk+RzkY=;
        b=lwcbv8TydL7O8th/jUUi7CFchzRWJEjiq/vgnvj+ewOnzl4bPOxgyyQWqyRlUtPXGm
         j0kLnaOUpblmhcGyJ3BVYYPvHGfS1jr8z3JHXRAql2WDPJ4LLwGk5IHytbsmB5OlekrR
         Sd2BddZ6cZ68uXNbClUNFWKSi6FsEjCl6N2GcL5ut+xWHiWT39Tnrpr08kp4Xs6NT6j6
         2feoQjAEx1Oz4lbFtx+TjBi61kJ1660ymv7vDOP48ZkvYc7o+LF7J0p9UQWK9fDlMREs
         aP0ejvgp9jCzTAvaJwg4QUMmfFhwntqr8HGLx1P44OnLaxs5E61UT0fDN4Q1d+cxHPXq
         EckQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVROctpK9/v6+2nFIqOcuokZkRd/JnnJiu052T0jm3AqNCupTl8cOeVsPUyc0gw48zx6GxAkF89ZJvoJeQFdM=@vger.kernel.org, AJvYcCXXJz4hbiEB1/qp22unM2aLXnzs3Dm9oZ13IlJ2gB8K6Jx5QCYvVri7/Q//wC9KxtQkpJNK8D1VYb0=@vger.kernel.org, AJvYcCXzfLDsHXKjwGbVwlOVHY+yRiJf8U5il6S6gOXAv/K1DL8RWd8rI9In3DpNmuaOLRDENO5DCnP10daOsmkV@vger.kernel.org
X-Gm-Message-State: AOJu0YywOnbToJ6rj9rkrqs0G8bUl+nQhaiPu3bz6ZvZT5S/XITR9620
	MOJg9CmgNzvlCO1s/fBA2ZHZ7/Cikjv2cGdT1fETvnOGKtcPqW47
X-Gm-Gg: ASbGnct2GphkIdn2Gbv7gbtyJjTEEv3akBf/XCmiOOQaS1GxBUxrSkaQrFLuZkvRmaW
	wx+XvwpnhR+TVKliQsLcz/irMmSQ/PjOy3xfaIE17nEvhMz+J2DRs3KsKnDG8Nqa5jtAJMfLcZZ
	Lk2BKk1vfYLPw407klOTnnevROI8l2AyJJ8YJUsa+OvcUgxbrsbf8YqdGky1V9TTo2WfoX37iga
	Xt+ZDTuopJ1EMYzPsYWSuUV6MJCXtXc622rmvx7yZB4PLY+Lx62wHbbQD6rgDk1w0Upee6+O7kv
	OxG/0gF6efMj8cRLn2Rl13lHS3RNAnrh5Q75U91wsAl4LC4dOArBxI3zYCwW8d9b73bRmUoAvo4
	vPeOaMUivFuJMfbxV
X-Google-Smtp-Source: AGHT+IH81UySJfquqqsqib4YT+37awiURcsJmKDQnrwiT5WTPoR6EFhWOtsz2pC9Fb1W+uChntifMg==
X-Received: by 2002:a05:6830:3c86:b0:72b:992b:e50 with SMTP id 46e09a7af769-72bbc4ea2a6mr3535769a34.21.1742006613460;
        Fri, 14 Mar 2025 19:43:33 -0700 (PDT)
Received: from my-computer.lan (c-73-76-29-249.hsd1.tx.comcast.net. [73.76.29.249])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-72bb26bb82dsm882990a34.32.2025.03.14.19.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 19:43:33 -0700 (PDT)
From: Andrew Ballance <andrewjballance@gmail.com>
To: dakr@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	corbet@lwn.net,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	andrewjballance@gmail.com,
	acourbot@nvidia.com,
	nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH 3/3] gpu: nova-core: remove completed Vec extentions from task list
Date: Fri, 14 Mar 2025 21:42:35 -0500
Message-ID: <20250315024235.5282-4-andrewjballance@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250315024235.5282-1-andrewjballance@gmail.com>
References: <20250315024235.5282-1-andrewjballance@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The requested Vec methods have been implemented thus, removes
the completed item from the nova task list

Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
---
 Documentation/gpu/nova/core/todo.rst | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/Documentation/gpu/nova/core/todo.rst b/Documentation/gpu/nova/core/todo.rst
index ca08377d3b73..234d753d3eac 100644
--- a/Documentation/gpu/nova/core/todo.rst
+++ b/Documentation/gpu/nova/core/todo.rst
@@ -190,16 +190,6 @@ Rust abstraction for debugfs APIs.
 | Reference: Export GSP log buffers
 | Complexity: Intermediate
 
-Vec extensions
---------------
-
-Implement ``Vec::truncate`` and ``Vec::resize``.
-
-Currently this is used for some experimental code to parse the vBIOS.
-
-| Reference vBIOS support
-| Complexity: Beginner
-
 GPU (general)
 =============
 
-- 
2.48.1


