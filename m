Return-Path: <linux-kernel+bounces-548987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55032A54BC7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDFBF3B3744
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3EF320F072;
	Thu,  6 Mar 2025 13:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MIeD1qum"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AB520E710
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 13:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741266932; cv=none; b=XYG0hKYAtyBZJPjF/93XUbB4u73/PFEb1Q47Y6kKf5/UApKNxPNO+mtn3CfftuI9Dg/OI+yZQsS2sMZHw7m8QWjenD+VuAR62CGBMFtNWY31Geu9PcHLKrj1janT77akFvCvLjKh3WTwzlEQmFG/n5eiDioOWe8ULqkwVixklr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741266932; c=relaxed/simple;
	bh=t9WUE4puJ3y/u1gPad4p78vEDZXVaqsDCLjaQIolUf8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lk5M/bxv5ERJgemo9WFNdHCsI5DluNAWOqM60Sxdwox8zn4qyAy1czYr6rvECgjFBIwUP8MM1ummWrNatDFe7rUFd0SaISLAEtRbJd4Mz2lURH1xpGe7cfhsnd8rQdfxEeN6s4xMY/WRGcAAt+4DN30TH+bUkiOr8UT3IyHa2q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MIeD1qum; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43bbc8b7c65so7135475e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 05:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741266929; x=1741871729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XvqE0gdDd8D80g4QcmunzIAXwiMoEWGi2ibgkUreq8w=;
        b=MIeD1qumAArSC7exNSs3ricWz+59+FCdxDfnEWtDCTePJDnI2b8j+IVFztpSUT+5o7
         zU1OFfJ8wFcq9M3b3mAnLERCVtfIhOW3ajlyyxGCNAuPx6mV3Now0cD4vFzNjuD0KgOw
         loU8sPfamk/6xZ0qp66b25HGUSPXODtHmwZhWgX8c08zAjb5FCwkMB8wJeaqWFsEGTem
         eJU/JYPmSGBbIlp6FIGydP+Malk8xxCrc7tOFAp/ojh5fejmq0x9+9ox9zG7B1Ri7jqJ
         MHWekudtOYYwzjDlNnuq5BM4l4TbNuusFD6kEFHL5qKRcTNFnEZsoGNAIDSFC2KifrVP
         dW2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741266929; x=1741871729;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XvqE0gdDd8D80g4QcmunzIAXwiMoEWGi2ibgkUreq8w=;
        b=KhENjMBdt2aC/rwNLVHCvzdrsb2EFe0QghJcYnaVXmJs9K6/QkBBM+AA2xekFK1h77
         EdqpV0RzgV0KOKs5ENujHl2AjgvemF/hjusbS8OLLZWmFuSTeK8Vsgj+ZiPQgSSt11pv
         7PY9PstA7LBXzOos4pYGHAAkymqYE6HRyQ7NSE35AZep63PTTKa7xMGREjLZrMMQAhW6
         hAqa3CLNDyRUqwQbAbt1CYLBJNUuGSA67u7Ked22/edXGsoU1Sk1mHAao9xv7rT6pMGB
         LZqeAXrSgBeuH0zRLX+Me9MK+/Ovp7TPGPPvg3u0ye0kC//l2/aXLDmqDKZevm53wkGW
         Jmlw==
X-Forwarded-Encrypted: i=1; AJvYcCXR52cf1knEhioDLLQCdGZcOR1lh1wRBcwAFO4u6IYptcOsbJhq0mgOtr5PgIKaq/4lEJGu2EUKR606HOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGcF9nlQdI/g7ikuYxb37sXLNDd4szflDEbeswOCO7cmaChAE9
	CstFbADkpQJ2sv/sFsJyMfdRVP+HXrrStHKlpVoOYHBVRTmShvdMR+zmq7Midb0=
X-Gm-Gg: ASbGncvIjxSq1coYGKC380VDRMKGG5YCYE8LSE6DYQzrHJy0kA2AlcT8gx+shFi3/+b
	V+JC4ngf9AM/fxK6N+gsTueMUZxF2N+dqtHICy3o0WtOqBf+KbIb5hSYiROZAeaN8LXkGoRu2e3
	JGhRmdGcl9BIydi48wQfLNYhL3ADE5DiiwYHKLAgu/gzsbvhHTTl0VdSZ64v6cusIfPVV+MfyI9
	Oq8ob7FA1g6reaqK575BQX0d19TFOuSaWZ2QDEY6OBOYYvTa9L9fODJGHRPGYQXS/DCBq7J14hF
	vuefopGpJixPj9t6Flei7VAzJPyRb8OGS4dIvhdTCiH+uctQ
X-Google-Smtp-Source: AGHT+IGN9G2IHEnZL3cvPtt7JMOOBNRM/b0RxlvzKWb5wGb0QePNN3COkLKHXonQaY7+rv3elRBeMQ==
X-Received: by 2002:a05:600c:4f11:b0:439:916a:b3db with SMTP id 5b1f17b1804b1-43bd292fee0mr67965375e9.6.1741266928699;
        Thu, 06 Mar 2025 05:15:28 -0800 (PST)
Received: from dhcp161.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd8c327fsm19704485e9.13.2025.03.06.05.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 05:15:27 -0800 (PST)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>
Cc: Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] module: Make .static_call_sites read-only after init
Date: Thu,  6 Mar 2025 14:13:51 +0100
Message-ID: <20250306131430.7016-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Section .static_call_sites holds data structures that need to be sorted and
processed only at module load time. The section is never modified
afterwards. Make it therefore read-only after module initialization to
avoid any (non-)accidental modifications.

Changes since v1 [1]:
* Rebase the patches. The kernel now has commit 110b1e070f1d ("module:
  Don't fail module loading when setting ro_after_init section RO failed")
  which addresses a previous problem with handling ro_after_init sections.

[1] https://lore.kernel.org/linux-modules/20241223093840.29417-1-petr.pavlu@suse.com/

Petr Pavlu (3):
  module: Constify parameters of module_enforce_rwx_sections()
  module: Add a separate function to mark sections as read-only after
    init
  module: Make .static_call_sites read-only after init

 kernel/module/internal.h   |  7 ++++--
 kernel/module/main.c       | 18 +++------------
 kernel/module/strict_rwx.c | 47 ++++++++++++++++++++++++++++++++++++--
 3 files changed, 53 insertions(+), 19 deletions(-)


base-commit: 848e076317446f9c663771ddec142d7c2eb4cb43
-- 
2.43.0


