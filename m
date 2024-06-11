Return-Path: <linux-kernel+bounces-209229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE2D902F37
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 05:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 440991C21C8F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 03:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D72416F918;
	Tue, 11 Jun 2024 03:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aJmJ0s1n"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037A764B
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 03:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718077749; cv=none; b=JEv6/orRK/jbFpp7PumYrvKQmDVZyaLw1T91u0Q9KTjWhMOlJkSEbh3zeQLmuE9VfwVBd5B4nohp/GZqGSAUHBXX/0VK1mlICg6d+v7b6ob/xLgv8JIj4J23J7eHpbVvkf8lPsVYVZATSD0gbihtGE/o+4yXADTGdG/EM1bD7/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718077749; c=relaxed/simple;
	bh=mvTHHduyDyQDcSxw/5hAysI9ob7z1i3HgWonMeyK0hQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pT+LqAeAEOr2XUR23fho2gDyu0lTiIZKtGnYO+SayNv3ClTeSoSQbBeYDSoHJo7+tKmDGofAAANHbY02cPiSqpUd3ieyHcjGoi51875YFTq6yC3JF0OAsq1Pc/iLlKKV2hPMHOOhlvDzT8klLieM2qN3pOqQ6uBySebr8hjvk4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aJmJ0s1n; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f6f1677b26so17313905ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 20:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718077747; x=1718682547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zbet/qCsm/2TCPHjObU4qdEEAftnzY0yLDlxMiRcwWc=;
        b=aJmJ0s1nNCfok8MN5htb3ghFfug89AbR6nQZ3dodzgMbQzYF14rEzCz0ZHUiLP8bUR
         AfvBPAozQFav9HDj2Gz5iKDBFyBCrlhiLbZ6i3ZPQ9cHgYUgvHnv5W1fa2zKIpwwmScc
         hrosDXehtUM5lw1lQ7AkQfi8BGOVgsm7bsf9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718077747; x=1718682547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zbet/qCsm/2TCPHjObU4qdEEAftnzY0yLDlxMiRcwWc=;
        b=drmUzdpLSBCOB8Xrk7vowgSvQTgtZi3knNBFcmJWY3OkoK+1dSGrFWRiGoMGeFLdAY
         era/XhImCaNx0kYNrjFBlhy87qXIuYFeELyiRFhKkI2Ldu2CZkacBM6lw0AQocxv6k7u
         iGEe14CUjuGKCFsv1PPxPOVAho8I1GlhwUZzRJlDaSR2pSI4vpbngvNiGD4oSyTyv7Lv
         I87MF6qFuikMrgWjAl3Yx696H25Ourqt+3ZIOMddJf2d7TOc7BdieEqE71WPZR2BZbB3
         5VHyxthSatYa2jJsoq7nfhHwb7LXmw1RUWhYDJUIq7BC9iCIAdpJnfkJCufd1NDFtoYO
         3aXg==
X-Forwarded-Encrypted: i=1; AJvYcCVHf0ER0E48/im9oENYTfh0uiV3L03i997an/6iL8yqfVcSYwPBGGtr/zn42m4P4fb2wMRZ7nG7YPSlmXoYDu6K+R5+0VdLshncfaLd
X-Gm-Message-State: AOJu0YyI6M/FEdTYQic+LvPCmN+DCmxycTZKXX+NGtizyqy05yQHCxK8
	eBKd/G8TzQwp6BWy8JrzW808uo+MREUsuzJJpN7cl++k6b7uS4uY4psDZRdVoQ==
X-Google-Smtp-Source: AGHT+IHc486Sh9GK7vNVE/HuV4p1o7cMvnyauzgMICmENuV9dbEIiRZJ2+tr8DYeGg7g0SkFrMxJuw==
X-Received: by 2002:a17:902:a617:b0:1f7:1b42:42f3 with SMTP id d9443c01a7336-1f7287bc2a5mr14848415ad.18.1718077747267;
        Mon, 10 Jun 2024 20:49:07 -0700 (PDT)
Received: from localhost (213.126.145.34.bc.googleusercontent.com. [34.145.126.213])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-1f6bd7e05d4sm90373605ad.191.2024.06.10.20.49.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 20:49:06 -0700 (PDT)
From: jeffxu@chromium.org
To: rdunlap@infradead.org
Cc: akpm@linux-foundation.org,
	cyphar@cyphar.com,
	david@readahead.eu,
	dmitry.torokhov@gmail.com,
	dverkamp@chromium.org,
	hughd@google.com,
	jeffxu@chromium.org,
	jeffxu@google.com,
	jorgelo@chromium.org,
	keescook@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	pobrn@protonmail.com,
	skhan@linuxfoundation.org,
	stable@vger.kernel.org
Subject: [PATCH v2 0/1] mm/memfd: add documentation for MFD_NOEXEC_SEAL
Date: Tue, 11 Jun 2024 03:49:00 +0000
Message-ID: <20240611034903.3456796-1-jeffxu@chromium.org>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

When MFD_NOEXEC_SEAL was introduced, there was one big mistake: it
didn't have proper documentation. This led to a lot of confusion,
especially about whether or not memfd created with the MFD_NOEXEC_SEAL
flag is sealable. Before MFD_NOEXEC_SEAL, memfd had to explicitly set
MFD_ALLOW_SEALING to be sealable, so it's a fair question.

As one might have noticed, unlike other flags in memfd_create,
MFD_NOEXEC_SEAL is actually a combination of multiple flags. The idea
is to make it easier to use memfd in the most common way, which is
NOEXEC + F_SEAL_EXEC + MFD_ALLOW_SEALING. This works with sysctl
vm.noexec to help existing applications move to a more secure way of
using memfd.

Proposals have been made to put MFD_NOEXEC_SEAL non-sealable, unless
MFD_ALLOW_SEALING is set, to be consistent with other flags [1] [2],
Those are based on the viewpoint that each flag is an atomic unit,
which is a reasonable assumption. However, MFD_NOEXEC_SEAL was
designed with the intent of promoting the most secure method of using
memfd, therefore a combination of multiple functionalities into one
bit.

Furthermore, the MFD_NOEXEC_SEAL has been added for more than one
year, and multiple applications and distributions have backported and
utilized it. Altering ABI now presents a degree of risk and may lead
to disruption.

MFD_NOEXEC_SEAL is a new flag, and applications must change their code
to use it. There is no backward compatibility problem.

When sysctl vm.noexec == 1 or 2, applications that don't set
MFD_NOEXEC_SEAL or MFD_EXEC will get MFD_NOEXEC_SEAL memfd. And
old-application might break, that is by-design, in such a system
vm.noexec = 0 shall be used. Also no backward compatibility problem.

I propose to include this documentation patch to assist in clarifying
the semantics of MFD_NOEXEC_SEAL, thereby preventing any potential
future confusion.

This patch supersede previous patch which is trying different
direction [3], and please remove [2] from mm-unstable branch when
applying this patch.

Finally, I would like to express my gratitude to David Rheinsberg and
Barnabás Pőcze for initiating the discussion on the topic of sealability.

[1]
https://lore.kernel.org/lkml/20230714114753.170814-1-david@readahead.eu/

[2] 
https://lore.kernel.org/lkml/20240513191544.94754-1-pobrn@protonmail.com/

[3]
https://lore.kernel.org/lkml/20240524033933.135049-1-jeffxu@google.com/

v2:
Update according to Randy Dunlap' comments.

v1:
https://lore.kernel.org/linux-mm/20240607203543.2151433-1-jeffxu@google.com/


Jeff Xu (1):
  mm/memfd: add documentation for MFD_NOEXEC_SEAL MFD_EXEC

 Documentation/userspace-api/index.rst      |  1 +
 Documentation/userspace-api/mfd_noexec.rst | 86 ++++++++++++++++++++++
 2 files changed, 87 insertions(+)
 create mode 100644 Documentation/userspace-api/mfd_noexec.rst

-- 
2.45.2.505.gda0bf45e8d-goog


