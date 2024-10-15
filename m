Return-Path: <linux-kernel+bounces-366911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 055A999FC2E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 01:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A56AE1F21B72
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 23:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6B11D63F3;
	Tue, 15 Oct 2024 23:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UYtUg4cx"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5B61B0F30
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 23:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729034222; cv=none; b=d3riNvbl7mFdXcfSu4oRCDkmWx/kHqqfH9e9iSbi1ncWfq8zDqm4+oAi2mqE93u0ltcR0CXtN7ddSubVZuVb/6acp9KBsY39OROGEYr/R9YMCk50tcRKKQiB0980pl8WsXHcZ7Ears292G4VMydu4/EtBaFMAku9DgP+FPL83Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729034222; c=relaxed/simple;
	bh=+RilbqdhmWa1t4pvNpgCLBopLcVUsyKeWfzBpA7u4KI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=f+/2s2RMV7+YYaPcB4+4CsWk9nY0t+pQ53x9V1Sc2u+avmhyx1nIrZW1UA+s8LKXpkrLFqqDP554E8zCfWPqquJz0Yafo4aOxCv6GHYRXBt7YV8OVyvamdDk3zqIJHCXzK7ZrBCirt5wldCBjklfrt2F82trjfvRP/yqKtsZKCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UYtUg4cx; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-690404fd230so112062337b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 16:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729034219; x=1729639019; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DbU5L1HNnvGi4SfbIk5euXMkUm30knwW6Q9Xw1d4gcg=;
        b=UYtUg4cx0IPO3HbL8jfYdyaPuxXQXNAHwc7lYuFdsVpa9qb3BqMI5O5JdPEhImy190
         BRQ12Lpe8mNtcXgQzS9rfzQZPCVFlb0XWcI8KphoM8oZHh55N/U8C2lAtwgkzdpvdzav
         wwdocIqqN0+rDx1Aej/c39xNQMreFUx7STYLXXsFTKTOo1zZG5hqGyhZC/ikOXFRTHAQ
         nwJS3oYa7728VgKKXd/q/1OH2QbqS3TzdQqHsmLyMoe9sSwMM939FFbSC3phUBt8pN+b
         Ko5p+ZtwMXbVxjC0P4BdldOM907trNO3BfOv2aHQU3+3uziUMEj+QU93wmgH8Xvn4sz1
         hUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729034219; x=1729639019;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DbU5L1HNnvGi4SfbIk5euXMkUm30knwW6Q9Xw1d4gcg=;
        b=Lo9LnCPyq+slegg16uTDAiLB1W8NOgpfXM43l7sgkeP7sxIqw7E1Y5i//NVajKCe9b
         DSmHo6DZxMo1eUjzUjKUi3+SE058tTWlDbNdoqkAazN47k7/IuH3fsCltky6Gc466ZUV
         Cs2l3bf8gPGCot9Vcqgw04GCuashe/Cd3e3Q96mAXwp7vmomnWNiMmdE/LNYMUcu+dNo
         PdBXGohr0c9h3ePcDD1J+sx5JjoicqbRp4o3egVzO2GRM3Og9jrbb6TTS6gcXRIAwl9z
         r8SugHBRqyATHFecCN5JNIzu+7NMbi8Rj1Dhmb45lq6bmyXxyS5KXbjf9Xi9l9R8Hjw1
         krOw==
X-Gm-Message-State: AOJu0YzdSQ1fTBydgsGnBJor2qGaVEyLPdB1Xe+GJR9eUcjxWx7AwIfN
	j02kT84ttbymZFM4FMyYhl6CPjNAvj4XuJL4Y5phZa3XyHe6Q0mGeVxhrQWkwgqMXfyP+KxGTc8
	v4aqPsw==
X-Google-Smtp-Source: AGHT+IE9M/QPEawpkYrmCgoLO4MqhipBXakrVD75onOl9tgo/7Jaz/A58z0xOGdMWl08TQoMGHL6CygxKbeq
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a05:690c:6408:b0:6e3:da91:3e17 with SMTP
 id 00721157ae682-6e3da915a37mr7657b3.2.1729034219005; Tue, 15 Oct 2024
 16:16:59 -0700 (PDT)
Date: Tue, 15 Oct 2024 23:16:34 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241015231651.3851138-1-mmaurer@google.com>
Subject: [PATCH 00/12] Module Validation Refactor
From: Matthew Maurer <mmaurer@google.com>
To: mcgrof@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	samitolvanen@google.com, Matthew Maurer <mmaurer@google.com>
Content-Type: text/plain; charset="UTF-8"

Split out from Extended MODVERSIONS Support [1]

This series refactors module validation during loading to ensure that
everything is checked on its way in. This is intended to make the code
robust enough that we can more confidently add new pieces like extended
MODVERSIONS.

[1] https://lore.kernel.org/all/20240925233854.90072-1-mmaurer@google.com/

Matthew Maurer (12):
  module: Take const arg in validate_section_offset
  module: Factor out elf_validity_ehdr
  module: Factor out elf_validity_cache_sechdrs
  module: Factor out elf_validity_cache_secstrings
  module: Factor out elf_validity_cache_index_info
  module: Factor out elf_validity_cache_index_mod
  module: Factor out elf_validity_cache_index_sym
  module: Factor out elf_validity_cache_index_str
  module: Group section index calculations together
  module: Factor out elf_validity_cache_strtab
  module: Additional validation in elf_validity_cache_strtab
  module: Reformat struct for code style

 kernel/module/internal.h |   7 +-
 kernel/module/main.c     | 569 +++++++++++++++++++++++++++++----------
 2 files changed, 428 insertions(+), 148 deletions(-)

-- 
2.47.0.rc1.288.g06298d1525-goog


