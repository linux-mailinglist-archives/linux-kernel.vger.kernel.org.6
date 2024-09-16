Return-Path: <linux-kernel+bounces-330301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7BF979C52
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 09:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B61CC2831F4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 07:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4957812D766;
	Mon, 16 Sep 2024 07:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PyslfLXi"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1437B3FE4A
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 07:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726473420; cv=none; b=Sfw5mRAuyNj1ghUWAKPoEZLUeNh7Wnd2LqH2ifIkLYLsf3d26ZRlGeVbLz+qj1o24n/gsUu5tEAWb3F/36PXQzlnk47ZPF/gQso6FYtoLpdzJBNCGDX6ywuwSfUDWholPpiLGdQbbwJT/V1D7c4RlFVI+U2y6cfDPmZxF9edJvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726473420; c=relaxed/simple;
	bh=hhxrIv9khiX1RfOrE0H/8k446mgPGdGKEs9+pui5JV8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l4RYQxmnC1Map0TBrZTwr5iNHbURr9UcVzyhvcEipVVuDud5MjeXlmh6mWolCyH+HXbEY4HQSn2GWePPXqicmDTHqBXAdBseSvSit/IIXEVjHCLAlPpOAyvBSb6Xzw8Uj2JKq0JMAYmgG+Y8VzwWV8Vcjo7TdPIW0eIJJD/bB0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PyslfLXi; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-536536f6f8fso448898e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 00:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726473417; x=1727078217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xHqTL9vDvOZZy9QnUiEJyUF3wHvGDGtFLKadEYFtbOc=;
        b=PyslfLXiQHG4WhLjYGWeWoFjqORX51Z0ha99il/aN6U9VkLqdG7s10vVEdYRqro+V9
         Lrv0XcWT2Mf7pLyylNuR2wdkfNhnqi4fafTlYD6SWWC7HTIkxv1+PN5TOmgWioNzLUig
         AzlUfCVpUbQbt2Z/nyXLh9iyQFsLF7uYItJmw7YeJKhvKAUkt2HdYSKY6gfGW4TPhDXe
         BNWoaXCmDFzqHtvB5D09iq8I+2CnuZ99LANf6dV5bbqI0pzNW70wmSyMuC+d3LPl0Zhe
         CToxx4sjMXq9bDZIsnxkzMnzQ9qerf4Lljl6KFGIP6bO4zrWdHb5Ex/MhjlAorGcOXDX
         1fwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726473417; x=1727078217;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xHqTL9vDvOZZy9QnUiEJyUF3wHvGDGtFLKadEYFtbOc=;
        b=hTNYr/XXtikobaPn5NP8KqJZy6zfJU+BnvpJBEI5g0hvUM0T1iMrpVQvanqFZIW9ri
         /XlZEwanRVOXCJjwtLG0la5+Fi0SaBjJqioiYR+bpxOcXrqB/7tZPP3gF1UCON1dFxw7
         edCD2Dx13fUEC/SrybpoUegkvgVzs+c4yX39gtMdoO0MnYGfJHodoOPNLAjxuBzze0cK
         lHiIz4hbJRFGzZcJJHTESJ+gksnbZyyhoQS1/YiHsSrsBuvhAO5EzLE8iVmLKdhuAJUJ
         71gkKsiFIyANEA1BYW+lh7ffGPREWh+sUfSy0iiagaI3Q6QIwn9lau/3X8LRTkQEJtQj
         doeA==
X-Forwarded-Encrypted: i=1; AJvYcCUglp3aP8C1gi5TJAoJATc8l0oKNmp1SdOq+0p7t/JkFEz3Mns6diofjrJWvT1Nu45ybyDc99sfmHPi1vk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy50cLijmvhPSaxHChWmOS+L8ls5W5TXVvELVja1sKpN/K1srBt
	oCWntWDGzFYQLFyBZICsh5/b+eSBoBrHW5lP9Y/3rY4ayv6OmrkocB6k2PHIkbk=
X-Google-Smtp-Source: AGHT+IFXzjEuV/tVax8Sc2ZfcCB+uYJFgWibtigRv636eDm7VF6ru3JXrEirsMP82sZ8xKiM91fgqg==
X-Received: by 2002:a05:6512:401d:b0:535:6a7b:9c03 with SMTP id 2adb3069b0e04-53678fef731mr2260577e87.6.1726473416604;
        Mon, 16 Sep 2024 00:56:56 -0700 (PDT)
Received: from localhost (c-9b0ee555.07-21-73746f28.bbcust.telenor.se. [85.229.14.155])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5368709684dsm801618e87.148.2024.09.16.00.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 00:56:56 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: shuah@kernel.org
Cc: willemb@google.com,
	kuba@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests: Makefile: create OUTPUT dir
Date: Mon, 16 Sep 2024 09:56:55 +0200
Message-ID: <20240916075655.4117151-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When cross building kselftest out-of-tree the following issue can be
seen:

[...]
make[4]: Entering directory
'/src/kernel/linux/tools/testing/selftests/net/lib'
  CC       csum
/usr/lib/gcc-cross/aarch64-linux-gnu/13/../../../../aarch64-linux-gnu/bin/ld:
cannot open output file /tmp/build/kselftest/net/lib/csum: No such
file or directory
collect2: error: ld returned 1 exit status
[...]

Create the output build directory before building the targets, solves
this issue with building 'net/lib/csum'.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index b38199965f99..05c143bcff6a 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -261,6 +261,7 @@ ifdef INSTALL_PATH
 	@ret=1;	\
 	for TARGET in $(TARGETS) $(INSTALL_DEP_TARGETS); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
+		mkdir -p $$BUILD_TARGET;	\
 		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET install \
 				INSTALL_PATH=$(INSTALL_PATH)/$$TARGET \
 				SRC_PATH=$(shell readlink -e $$(pwd)) \
-- 
2.45.2


