Return-Path: <linux-kernel+bounces-426082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 570589DEE96
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 03:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6F97B21AEE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 02:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE585FEED;
	Sat, 30 Nov 2024 02:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VF5dqM+p"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852762AD00
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 02:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732933662; cv=none; b=r53W0lGJaUxlHLSV/jSIRvsJz9i1RNp3vbIZKfJ79ynHvc6JmsXvtIondiT1eW5HhWs64t744btA61wYN03CtlsuG12dH0Vzjbm6+UNw+cfu5MxDgAncLXja/Amch4hhmCoB46l83/W3+Z+r2DrUhJYzrYX3pFMRxdCOvXmArXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732933662; c=relaxed/simple;
	bh=aWnmarBawaRLlTgny6s97w2dRCAw14joD5nX5cQZVF8=;
	h=Date:Message-ID:From:To:Cc:Subject; b=JeiS7SZWqGxacIpZTppjpNUDjaf5JFzcPOj2gEvyv7jpIYJKUE9AmhbvnjldxlbW8anBWNSMytCyMy4+hhLi0QcN9MZ404HiKpWzwYkBqKTgK+LyNBYHHaWvBzs+/+XfcVYUZA+VHjaJwOhS6eijzERSAzkr84FUIa8RY6+y5dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VF5dqM+p; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b6600c9338so169588585a.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 18:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1732933659; x=1733538459; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ny/xOclvKvO96CaJgqDIoJ71/Sn21XjQ/xxsbfZgVno=;
        b=VF5dqM+pP/gUpot2DVRAZqXtyJ0bEEi4VNHmDrqQ5L+SddiFjKIFcQJe5LopUQKsWM
         S5SINF7Wgo/I02eIAPovwsVp/zOCp+9417CdNWTzT9NYlQsHApu4aP8T5b26JPMUEZJa
         GqQx/iCBTUMPwxkPbeoXodeiuE3iMnBUxyqmeg7z4tmJhd/avK4KDsOgMsn4nRWOv8yK
         +jRNmpadLBAY+h59c2NPJp+cCnwOirAvFEMkNvGJChySIp8h5RQ0AH75GBNcT4IFib23
         25PPGtxMdew4+E8NVMAWyCl+QMsk6LmkHsgpt1ZJoT1Kp6nBEVEr4RYHW01W08fSZmRS
         j77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732933659; x=1733538459;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ny/xOclvKvO96CaJgqDIoJ71/Sn21XjQ/xxsbfZgVno=;
        b=ai/cnS2Jrau8v1Rlq1ecopID3VVrpggw5eQceJbH53dt4/qGYxQVZeh41hGM/lK377
         NRBV6NlehZHhcgCeiJNVEETRxR3InQ7TTefjQFNh4odwiI4XXgFJoT+qqGtPDFhgfIpu
         ir+vGI9MM3epOE6bmIuEf30ioHTUkzBAeeFazcwQAbdN29MT1i8fJrdPhN3FIfYbig00
         q3qy3N9GT+Uq9Un0ZdpX5/k/HJSjnKFfPpK6IcT+OrcT5FORtUO0cicKAZwQfpo6Z7E5
         1mlsbNjqbgSZhpqUD7Bz+iHv5j09wlLzSbumiW/76NyQwsFaA4o5r8sDisHXcURvnXob
         oXCg==
X-Forwarded-Encrypted: i=1; AJvYcCXR5ekN+f2yfUzIdKuPjmWidA6c7D7ZDMpmmZeAyie/Ny7ZLR8VIx/7ZNDf7HTZEyQ0clL/F4haQ1gHPkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnEeDn/FLRs1MulzxA5gBva32G43dwmdv0xesyJqvCecyx5r/I
	yh1nQl1v4fWN9UTUL6J+/JVY5F/lma+IgRvBw3quP46fWafArfxBvEsdhifvNSeHCf87Okcjwko
	=
X-Gm-Gg: ASbGncteiC0MsdY0n1wXIpVVVgaEPhlt19uu6F9zKW0+DXggHWtxD1qlDu8qGnZcrJw
	cVVcFpHltBLLdp5VS0N4A+Ht4/MD57VY5TSj2/iHauzR+QhQE7YWMV0edH6xwhQI8tNzNOwnsof
	IjZq8SCdEOKL4oCi+E/nPsOy0FFBtOfxvVyilVmmJTWRg5X9L2PqpjgcCCqG5ijv05OSnITpqhE
	6KKy2z+E9itZfpvT/pW0iXLjXPvgPHGVPcmpGRFKf2K
X-Google-Smtp-Source: AGHT+IEaIDdrWw106ZDQw0mbWestIN+m9HBQ9vmiOd4JwFtKrDnxFQ8CI9ZeiVjBiiizd4mXDAYLNg==
X-Received: by 2002:a05:620a:4109:b0:7b6:6634:5a38 with SMTP id af79cd13be357-7b67c278e4dmr1869693385a.19.1732933659414;
        Fri, 29 Nov 2024 18:27:39 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6849aaaf9sm192839885a.79.2024.11.29.18.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 18:27:39 -0800 (PST)
Date: Fri, 29 Nov 2024 21:27:33 -0500
Message-ID: <86752346e28a77c830cb8249610f0f00@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] lsm/lsm-pr-20241129
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Linus,

One small patch to fix a function parameter / local variable naming
snafu that went up to you in the current merge window.  Please merge
for v6.13-rcX.

-Paul

--
The following changes since commit 8afd8c8faa24249e48f5007aee46209299377588:

  lsm: remove lsm_prop scaffolding (2024-10-11 14:34:16 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
    tags/lsm-pr-20241129

for you to fetch changes up to a65d9d1d893b124917141bd8cdf0e0e47ff96438:

  ima: uncover hidden variable in ima_match_rules()
    (2024-11-26 22:58:03 -0500)

----------------------------------------------------------------
lsm/stable-6.13 PR 20241129
----------------------------------------------------------------

Casey Schaufler (1):
      ima: uncover hidden variable in ima_match_rules()

 security/integrity/ima/ima_policy.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--
paul-moore.com

