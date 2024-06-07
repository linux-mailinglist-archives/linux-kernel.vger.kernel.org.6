Return-Path: <linux-kernel+bounces-206727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E125900D10
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 22:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A2A4B23622
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 20:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330F21514FF;
	Fri,  7 Jun 2024 20:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Yu8c9Syv"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC006819
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 20:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717792556; cv=none; b=E6lR1uyREha/G6b6EVsHddaWh9aURHAKUfi3+82poji9t88yDIx4KEHckaxWsZ32slRyTggjOWyL3aVl4BaPEv0vYX69m0EkmfKN2PXTn7EPIBiUCWO3WRSCG0RGrVxPyNaYiLYuU6dsB/LTeThrC4BHHayKmfZioXu0BSl8okE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717792556; c=relaxed/simple;
	bh=0oUY7YekuzTgZuoCTclJAAQEBpsdR68wucgu8oAuMyg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tMKkdZatJPe/vg6orecDwyD8q+ntz1AwcJk/jbUMF/dgDYOLe2L3Eu06l7Hze1DJdUvjeCMgt8SMbYoIFY+zvrdCAQ8WBbZ2y915QLmxBuXUQSKgw0dbjo3zdqr+yzKkB+ZUVmROXj8WoSFxYrcvLiUi8getI0UmF21fGikXNwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Yu8c9Syv; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-6e57506bb2dso456530a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 13:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717792553; x=1718397353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/aZumHyRcpOIT74DOJSEusSl9YmG7Mt7kBbt+rZmDfc=;
        b=Yu8c9SyvgOlVfndEI1c3sF7rl+2xLUBM5r4MAKSuEpDyrc4OJaURtDXOFAjzh3w83d
         K1lX4xG+6jC2W9XbzQpn1y0c++GYLmYIJ07eZWkmMkCocpNFvmB8TUfTWXsEEyfGi6iB
         vfmNZ3qlNpJ9QKkuhSsO6O2ZRS1qHyLojlUmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717792553; x=1718397353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/aZumHyRcpOIT74DOJSEusSl9YmG7Mt7kBbt+rZmDfc=;
        b=BrPHqOpxlLrhzZlBYIGqIUdd7ILKrzLUZRvf6sabKb8cEqC5ghoritlD+4iCg/1N/8
         u3Txqo200uVXhhyrUI7Y9tOAQcGfS0d5vicQOhWQKmZ+N5aTmr4ZU3zfOpf7gbJBbf4Q
         VZuuFdUoUkRShpOW6gSGUD+g08UWYQ9ELIcEEENPn6EAfDvzlh1qxEDnnZEtvtJYmTAY
         joFTJVv0u2O22KlZ4g9ntQ25unumpp/6G92KzrVB+lbEKZCBPbgIe5GWzPj+VqrR/v1r
         JyyI/qoyxUQ99M+wKqmybkxlQcgKSFtBbDz/AIUXtqnHRsqxlT/pkXP3AUEfNDmwYC1/
         SQvA==
X-Forwarded-Encrypted: i=1; AJvYcCXMOtWCMq2vdTC5OLK1hSkYOmxF+tcByP3VL2VXJg4gtdYqHDKPyml+AUfhmhCRjKTb/RPffLsiA8IwiJ3Nuet3F2c7Bn/Y0ylI3z8u
X-Gm-Message-State: AOJu0Yy87wYdkoQ4wgVLTtwwwZyRFrkv6iNq0b55QAhGyASBIyPeDq71
	Xc30DGKAPF6DSIvUMRxM8S36uLma4aumVltS2VMhf6d0MiEZn34YlJMSoWjK0Q==
X-Google-Smtp-Source: AGHT+IG0zwY6vWwEtQpPZbj4cEzreBvdQwz6RkitHdPJvAt200tHqjh+4UzHLnKkUgI6qaWZ3+6VsA==
X-Received: by 2002:a17:90a:ee4a:b0:2c1:aa8e:d70 with SMTP id 98e67ed59e1d1-2c2bc7cf895mr4084944a91.0.1717792553031;
        Fri, 07 Jun 2024 13:35:53 -0700 (PDT)
Received: from localhost (213.126.145.34.bc.googleusercontent.com. [34.145.126.213])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2c2806d1be2sm5904787a91.55.2024.06.07.13.35.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 13:35:52 -0700 (PDT)
From: jeffxu@chromium.org
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org,
	cyphar@cyphar.com,
	david@readahead.eu,
	dmitry.torokhov@gmail.com,
	dverkamp@chromium.org,
	hughd@google.com,
	jeffxu@google.com,
	jorgelo@chromium.org,
	keescook@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	pobrn@protonmail.com,
	skhan@linuxfoundation.org,
	stable@vger.kernel.org
Subject: [PATCH v1 0/1] mm/memfd: add documentation for MFD_NOEXEC_SEAL
Date: Fri,  7 Jun 2024 20:35:40 +0000
Message-ID: <20240607203543.2151433-1-jeffxu@google.com>
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

Jeff Xu (1):
  mm/memfd: add documentation for MFD_NOEXEC_SEAL MFD_EXEC

 Documentation/userspace-api/index.rst      |  1 +
 Documentation/userspace-api/mfd_noexec.rst | 86 ++++++++++++++++++++++
 2 files changed, 87 insertions(+)
 create mode 100644 Documentation/userspace-api/mfd_noexec.rst

-- 
2.45.2.505.gda0bf45e8d-goog


