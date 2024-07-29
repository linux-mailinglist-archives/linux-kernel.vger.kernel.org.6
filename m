Return-Path: <linux-kernel+bounces-266131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A02E893FB8A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 18:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD464B23A6F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23E755886;
	Mon, 29 Jul 2024 16:41:19 +0000 (UTC)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849E180C0C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 16:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722271279; cv=none; b=pWSz0N27fBKfb8ykJ1cRbkQ3L4iTAXE0J3WSRUhHmg7duAXpITuUUvUJFiya6iNkvmeY6Iz6KZZUIubOrj2dcXPRrh0ShUq7H/PJbTAW1OQfneAON2j49MsKGyk3EEu+d0Z7Xp6RBEvajhCyHhu7mj0ZxPohNGEiUEDEWidbemw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722271279; c=relaxed/simple;
	bh=/LBH2AE5T1x+HwwWLJ9ynU7Gzgey507IZFg7HARQZew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KKhOjo5u0c46XjskUcwvnW6LFhpRpp82DFolmYsG0sYyVagzAy0rpcqKfqT/4gCzf1ozWDC7P47zy2PVTIVYD7AUPJHwcHNorAALLi5QiM3bes8kjP7LzR5FLiQOrW5+N6y0ZjkdPqt6z3VKEz6nOx74LPbPyWnSNfmsF8j2uIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7a8e73b29cso260602266b.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 09:41:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722271276; x=1722876076;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oNlK8TyoclvOKl+oabuvkdmYVfAX7JRpadbKfvWJqdQ=;
        b=GB9X1b49BxalZpAvMZKLlIZbuoipHc0kwEDzvehh9frep6uq+qnH89p/OF5a74s3aC
         fI1jw+W2m9UaOS/QOMHcuMFlrGw0cY/Ch8j9bhFCV0IlEfa9nbHiyg78af2D2OBvOQap
         qE1JuEQe0cjaky6XtOIn5Hon7K7VjErehjzYKVd6RsXBYzNVykEx8Pjs23pmsRoqb/hh
         DCoOk4nfnc0Bvbmgxsxr4l0KcquXGjtgbux6Fcb9Pu91K7wtrjrQDM9YwURgMqpY32pZ
         +Jfn4RDo0zAyHcKfmRmcp9Fh6ZFOKrnx6btZB5FktMX3yIXVZMjvRaZJxptp96OiVFAh
         56cA==
X-Gm-Message-State: AOJu0YyHRzAo8DUgRk325anrZAzHTcIlr4k4qb0fksm1AxMiGJqa/rEP
	qzXQX6dqRMGMFDzWowP/DK9GEWWlH+dSrKj0+T3w2L9XFyBH6ZL1
X-Google-Smtp-Source: AGHT+IFD7PcYcT+fMSuRc5ZL+CQAtIM2xB5T/k3h7jSNNsjagUDfQNpfPbb7e0JRPSA0R6ZKN1JEbg==
X-Received: by 2002:a17:907:2d12:b0:a7a:bbbb:624e with SMTP id a640c23a62f3a-a7d4004e8f7mr730010366b.35.1722271275355;
        Mon, 29 Jul 2024 09:41:15 -0700 (PDT)
Received: from localhost (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acadafd9asm529914466b.187.2024.07.29.09.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 09:41:14 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: bp@alien8.de
Cc: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	jpoimboe@kernel.org,
	mingo@redhat.com
Subject: [PATCH v4 00/11] x86/bugs: Separate config for mitigations
Date: Mon, 29 Jul 2024 09:40:48 -0700
Message-ID: <20240729164105.554296-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current CONFIG_SPECULATION_MITIGATIONS namespace is only
halfway populated, where some mitigations have entries in Kconfig, and
they could be modified, while others mitigations do not have Kconfig
entries, and can not be controlled at build time.

New mitigations, such as BHI, were properly added, i.e, having an
independent Kconfig, which depends on CONFIG_SPECULATION_MITIGATIONS,
so, you can enable/disable at compilation time.

This patch set aims to have the old mitigations in the same format,
bringing some uniformity to the mitigations.

These are the advantages of having fine-grained control for the
mitigations:

1) Users can choose and pick only mitigations that are important for
 their workloads.

2) Users and developers can choose to disable mitigations that mangle
 the assembly code generation, making it hard to read.

3) Separate Kconfigs for just source code readability,
 so that we see *which* butt-ugly piece of crap code is for what
 reason...

In most cases, if a mitigation is disabled at compilation time, it
can still be enabled at runtime using kernel command line arguments.

This is the second part of the initial patchset[1] that got half landed.
The first patch did some code re-organization. This second part
contains the exact missing patches from the initial patchset, and
basically adds build-time configuration for the other mitigations that
are currently only disabled at boot time.

Here is a detailed view of each patch:

With this patch applied, setting CONFIG_SPECULATION_MITIGATIONS=n, a
simple script[2] shows that all the mitigations are disabled:

  spectre_v2_user_stibp   	 SPECTRE_V2_USER_NONE
  spectre_v2_user_ibpb    	 SPECTRE_V2_USER_NONE
  spectre_v2_cmd          	 SPECTRE_V2_CMD_NONE
  ssb_mode                	 SPEC_STORE_BYPASS_NONE
  l1tf_mitigation         	 L1TF_MITIGATION_OFF
  srso_mitigation         	 SRSO_MITIGATION_NONE
  srso_cmd                	 SRSO_CMD_SAFE_RET
  mds_mitigation          	 MDS_MITIGATION_OFF
  taa_mitigation          	 TAA_MITIGATION_OFF
  mmio_mitigation         	 MMIO_MITIGATION_OFF
  srbds_mitigation        	 SRBDS_MITIGATION_OFF
  gds_mitigation          	 GDS_MITIGATION_OFF
  spectre_v1_mitigation   	 SPECTRE_V1_MITIGATION_NONE
  spectre_v2_enabled      	 SPECTRE_V2_NONE
  retbleed_mitigation     	 RETBLEED_MITIGATION_NONE

[1] https://lore.kernel.org/all/ZZ7c9EbJ71zU5TOF@gmail.com/#t
[2] https://github.com/leitao/debug/blob/main/spec/dump_speculation.py


Changelog:

v4:
  * Created a patch that removes the MITIGATION_GDS_FORCE Kconfig entry,
    then rebasing the last patch ("x86/bugs: Add a separate config for
    GDS") on top of it (Borislav Petkov)

v3:
  * Rebased the patch on top of linux-next, since BHI mitigation added
    some hunk to original patch series.
  * Broke down the patches even further, creating one patch for each
    mitigation. This make the review code easier (I hope).
	* Nothing was changed, code-wise. The code is *exactly* the * same
  * Dropped the "spectre_v2_user default mode depends on main default"
    patch, that will be sent later, since there is no dependency to this
    patch series. Hopping to make the review/acceptance easier as well.
  * https://lore.kernel.org/all/20240422165830.2142904-1-leitao@debian.org/

v2:
  * Patch 2: Changed `mode` type from int to `enum spectre_v2_user_cmd`
    as suggested by Pawan Gupta
  * Patch 3: Change MITIGATION_RETBLEED dependency to match the code.
  * https://lore.kernel.org/all/20240208174555.44200-1-leitao@debian.org/

v1:
  * https://lore.kernel.org/all/20240118173213.2008115-1-leitao@debian.org/

Breno Leitao (11):
  x86/bugs: Add a separate config for MDS
  x86/bugs: Add a separate config for TAA
  x86/bugs: Add a separate config for MMIO Stable Data
  x86/bugs: Add a separate config for L1TF
  x86/bugs: Add a separate config for RETBLEED
  x86/bugs: Add a separate config for Spectre v1
  x86/bugs: Add a separate config for SRBDS
  x86/bugs: Add a separate config for Spectre V2
  x86/bugs: Add a separate config for SSB
  x86/bugs: Remove GDS Force Kconfig option
  x86/bugs: Add a separate config for GDS

 arch/x86/Kconfig           | 124 ++++++++++++++++++++++++++++++++-----
 arch/x86/kernel/cpu/bugs.c |  46 ++++++++------
 2 files changed, 134 insertions(+), 36 deletions(-)

-- 
2.43.0


