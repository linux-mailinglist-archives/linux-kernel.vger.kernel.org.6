Return-Path: <linux-kernel+bounces-174903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BDC8C1701
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 22:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0F4BB23ED4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 20:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77459145A01;
	Thu,  9 May 2024 20:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X0s9Rv2a"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E5B145353
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 20:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715285013; cv=none; b=pqLPrnv8d+Tzunblu5uCoBVbLlTjuA1R9c5RVVLwCIjw4VDQTRvVVeSFcFq4Hoym5QZgbu4NPAaNZcGg8+49sPjbD5VbV48KjC3w4Trge6MzTmusLteTYvLaXZHNk6c+ZuMD9x8C86A38/H2wVLTcXiFO3O8S7JfI8JHZSZkxtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715285013; c=relaxed/simple;
	bh=o7KUhJ/cOqBq2zS4JjqZwWYxL8EjBdrcYICOZdNPSGw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j1KzAlDCSdo0HwyqQ431SrR06eMXzx1cLxlvcpSPhvSuX71ZJzzs/BlGgO6cetmTVOSot/397A5H1WWLWWcV+WNRK7snGog53V+vza7oe282Dv6K1uKMlLhM3adQ2U0VOZuiLEONJCtEdvWXpiwG/fRtNGja0OADlyJAcsCdyMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X0s9Rv2a; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b269686aso1825827276.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 13:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715285011; x=1715889811; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=k5k6MfrHn5zAXreDA+C7cs5PpXHJQO9KnwpSZ9g5UlI=;
        b=X0s9Rv2aOc+LOf/OVg6NKTYvFB1t2/Pm6E0NHQn+vuyJsPXn0PSrXfLLCDFkRayUwZ
         6Tu86GGveqS6BdUkl+lnJme9zicarZ+O/NJVnK687xSGlwr/bCUzZsbG9TEtzU9w+GPb
         5sDfc0+MZbJl+n0V9/9YWIExGHe6I0iH2sNa1Jy/NN9At/QLYbiAdKzD8qQzxj/1KQ66
         VKf4bb/+17AzeI5c7szppn0eo8v0ciWWn774OPy9ZVPeyFR8voFTMnF8yRGLVUiF7ySu
         ZmsqW4jvCqWLn5B5sTbb6Jthn+yPy0COqY0Ha70Qd2nbN8fXwCdS1WJnGZ3Ixwq6xQGw
         0KTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715285011; x=1715889811;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k5k6MfrHn5zAXreDA+C7cs5PpXHJQO9KnwpSZ9g5UlI=;
        b=Pjg/bbCWsPARzHeoXl6pigeMhsoNo2M2LlbEMTsp79+xv6qlN20dN6vmN0dOr0OnqT
         5fZDLDL0Ni6XEQLv7apyU6indKiTUvrapV77d11V+ZRAtBrF4CZI/8H7n6YbdJRFjxNJ
         9tjPoDBqh1K3ecDGnY38WKjpe0xFKjksmQ/o556sFwzfeIkA0aq5i8HBG9N0zu4hWqRi
         78+NpxpYqOxm4gIN2Rei8329dnXfYsuwoUuS6bVu6xBz8vn59Ey6ByAW78jFfQim+frD
         iFUhS6VYRjU9fvbgo/ZUvo0grXW+m1WjK4eNxSIUMYVgxgS0oydAYoyoYXJYxIAmxXPs
         IAdQ==
X-Gm-Message-State: AOJu0Yy8lX93iv2q7xJokHX+NOVQzqhjBMR0dHBcyVo6j7PTscxdkgzy
	q1fEOxWDUrhfsufKWqRlOTsXpEfompUD5ojLJvK+Cpt603GcMEjzFbm+aVkujoMt4Wedvy6h+K2
	ApQ==
X-Google-Smtp-Source: AGHT+IGb4ng9OJg5Fp+YefUa4FZNwRQyl6/nmjKMnKC/LgTLkL3Ns0/OurcHg47bBiuW1FC3zvfiy+ei/Po=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:c09:b0:de5:5304:3206 with SMTP id
 3f1490d57ef6-dee4f52d715mr61724276.11.1715285011299; Thu, 09 May 2024
 13:03:31 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:48 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-57-edliaw@google.com>
Subject: [PATCH v3 56/68] selftests/sched: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Edward Liaw <edliaw@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/sched/cs_prctl_test.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/sched/cs_prctl_test.c b/tools/testing/selftests/sched/cs_prctl_test.c
index 62fba7356af2..abf907f243b6 100644
--- a/tools/testing/selftests/sched/cs_prctl_test.c
+++ b/tools/testing/selftests/sched/cs_prctl_test.c
@@ -18,8 +18,6 @@
  * You should have received a copy of the GNU Lesser General Public License
  * along with this library; if not, see <http://www.gnu.org/licenses>.
  */
-
-#define _GNU_SOURCE
 #include <sys/eventfd.h>
 #include <sys/wait.h>
 #include <sys/types.h>
-- 
2.45.0.118.g7fe29c98d7-goog


