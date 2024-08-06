Return-Path: <linux-kernel+bounces-276070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C9C948E0F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E16B21F25CF1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 11:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290E91C3F02;
	Tue,  6 Aug 2024 11:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="WwUZVWKa"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3501BDA83
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 11:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722944894; cv=none; b=KGvOj/QJ18sMheScVR288ycHqXf8diIwCZdn4PwETOtyw3xfapcHWwvjeLqL6QdwYWDZT4I1JQiX8AM+ZjJOQfm5lknsKKA1GLNC5cE8qVtMElQv1ogI/HxbiM905TCxLEKjkjQGir2SUmKxqzXu+zB35q2K2Fb03ustF6z1LT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722944894; c=relaxed/simple;
	bh=u5zRJaTuSvBseINgkqS6UlZoRxRUZSWXK0n4RffFhoA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FSCtUyyNkvxA2+csj+SyqC6EDlfk3IJk1o455ErRuoTpWd3lECaprlU6JvDMc0SiusnKrATXJtUzD2xPmQ49ztgePZxekjChmnenHMXU8TAONtT/DoMZGPgoW70M3zkfgXRtrX4oJgzxzHdlBIq5AY0PG45rHfp6MVT6337oRG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=WwUZVWKa; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7106e2d0ec1so394198b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 04:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722944892; x=1723549692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QSWgsBZpug9uAeZNuJufTFCNLfK1NntM3pErkn2XtXA=;
        b=WwUZVWKaefJ+Fx3iaeSCSJDj+kacJIlv2gzVcd09GTxWXslJ3nlSux7/Mi43OHv1Sr
         +hLgwP5vyMUCNHAuC2EUC4Kvkyklc+rXMR+4vTdWVLP+wxUSq2Z+nyfBj8vig+2xWYVg
         wFpL0OI9XJiyZT3mIpNRMok8A+STpib2RArXiNHGdRVQNE3NYZTdpLsCLKlBqAXRMNZc
         ZHX7r9XCL/00gvFtqsfx0nQphyr4leBHTzsl4hkkN4J+qNSq15r/38mYQ1hYiFnsusJX
         FoWkvlXTMUtq+lsRuFpyqCW3ldrQZBCJEFLOJ7JBN+qkOG5NO4OLpi1pPJPbgeZdDReV
         t9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722944892; x=1723549692;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QSWgsBZpug9uAeZNuJufTFCNLfK1NntM3pErkn2XtXA=;
        b=s4ndhuKBsj/OKKzB8tbLjyr+3/Dqe/tMasyLOWepkK6Hu+XWOoPXj7FTGW1RDr93o0
         FPV8LhjMc9RnO0z8NomHIeEK1Ai7tCSktaBxxBKj0O9NU0a3toZOchBneQ5KoBm+x4P5
         3InBTscgbpy8/9MYwZ2gZuP0DAP04TQqc/Tc8UlCfq1/UZzC+DRNzEpLXZKFhOfQYwAZ
         Q55JLNFJb1Yog6UZRs8+C0KcdtL+pXrJ2Nyzl0OnC9J+96XKeOpi/1gGaLv11izEGjoi
         PxppdiiHNwCnPgAXs8Vqu/on/OnE4Rz7YUkk8+DBzhBq7IO170Xa7uqYU5tLHI5hvzuu
         cVYQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2NOSdZ0mvwIQ95MgxHdYRpwnnTdN3eYH/HY82yyLIKw2TKpnEUpeZ3oigo8HufoGd4VFJGKcJYBKT3fXTjlm4gY4W2B/5OVKeyhds
X-Gm-Message-State: AOJu0YzemwhICZhwiHb9l0gn2AOlI+RRNrbJxjI5tC/GZdxswEwPgXY+
	71H/izkOZUwvFFLV7kqTLfKBGBPmLVh1OOSIr02rZNdZZufDDcL4Y7pZPMjWOoI=
X-Google-Smtp-Source: AGHT+IG0l4RbcapZ/5fHoMHXUqZ9zGO50TQOiCiOJC46xPX+zqq+MStm4ii4pxaKSGZ/HnZDrpFUoA==
X-Received: by 2002:a05:6a00:6f4e:b0:70d:1a82:f9a4 with SMTP id d2e1a72fcca58-7106d07bdb1mr11122155b3a.30.1722944891642;
        Tue, 06 Aug 2024 04:48:11 -0700 (PDT)
Received: from ubuntu20.04 ([203.208.189.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ec43944sm6831705b3a.75.2024.08.06.04.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 04:48:10 -0700 (PDT)
From: Yang Jihong <yangjihong@bytedance.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yangjihong@bytedance.com
Subject: [PATCH v2 0/3] perf: build: Minor fixes for build failures
Date: Tue,  6 Aug 2024 19:47:58 +0800
Message-Id: <20240806114801.1652417-1-yangjihong@bytedance.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset contains minor fixes for build failures when statically compiling in Ubuntu 20.04.

Changes since v1:
 - patch3: Remove UTF-8 characters from build failure logs

Yang Jihong (3):
  perf: build: Fix static compilation error when libdw is not installed
  perf: build: Fix build feature-dwarf_getlocations fail for old libdw
  perf dwarf-aux: Fix build fail when HAVE_DWARF_GETLOCATIONS_SUPPORT
    undefined

 tools/build/feature/Makefile | 4 ++--
 tools/perf/Makefile.config   | 2 +-
 tools/perf/util/dwarf-aux.h  | 1 +
 3 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.25.1


