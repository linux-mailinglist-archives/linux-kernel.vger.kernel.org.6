Return-Path: <linux-kernel+bounces-365574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B77A099E488
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D646B237C7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6081E7C35;
	Tue, 15 Oct 2024 10:51:23 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F69E1E377E
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 10:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728989483; cv=none; b=RJNce7lhRrkSG0BLIN/yX25G7rG0EfV68QWqsFBj44KQAKPZl/yGNtAQH3XvXausyAgUzRNqcVXzIac6dWFiy21csuIvhTLeJEsgrauoyDYoxxGM+Guw7ecRSacWKLcZTFJksv9KGjbQiwlmMMeI//KUD0R56p53XyRdrbKNQI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728989483; c=relaxed/simple;
	bh=3oVQ3SQncyYM2/01UQ5PDqqJTd10WleaD+VQ1SqIPHo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dd27TyLrmvCe0ACgcALjixW3H1N2nWQzIcYHCjLFajGv82tBRNuzZP3M4kR/MbZRJMTeVqT3pTFC/0rkDvwBYuEUi+iYrHLlcQ9+1IZhG7eFc2LFNB7IDaFaPyNjG5x5yJaAS7lDb+8m8yoK7e7OkDjy0HSV+WWfElGzAxKrWk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-430576ff251so45552175e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 03:51:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728989480; x=1729594280;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3QVnM28C4/r4nOFvwzycVy86dkKWy8OvatRLOZVoPhU=;
        b=Ia68DdtTBegT3srgbVQNnEiDTOIDr4tkc+EYJGrnwwnYQVewiMfFsWlDd+5uL/LQSu
         ZgYfGCdEwAIh2r6Q9CEZf+fguGB1vD7bdyUuC7MA0ryH76j0UWVys8GYyL8dhQWU/ufK
         QlRKad9DCxnYcsF5uOFGwRafe0B/i+cHplLKW8Jrgtwpsc9aovZsFwhN6DZv9KD8yF3p
         UCkAvNcXIkjWD7fOrAjSi9AYBXBt2Ota8gA2o0P5mYLFkjJ+xH6Las6m14u6zguk16w4
         Dz4ytSUWRYphW3cdz32Dtjdjw87xAa7yKg6f2pLbsvBRmMsNdwqct/1KSck87LP2aGs2
         7iiA==
X-Forwarded-Encrypted: i=1; AJvYcCU43XysYWOj/Lmi6FjHC3x7M1jC3FkFEcPMmvQPoAKtsBevNn7aDslTL0MBtK1IF+CJ5yt1HQGflq2Tj9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzADdFc1mCbJlJCyZ/CHm/LL15rkdmz0m2k5c0+i0P0Eqll660c
	mwcUqz5pIiXz/dkN23KnvVe12R9P+VErNZipoNXSWK+xoArqcvES
X-Google-Smtp-Source: AGHT+IFLP4BZ+/eds2drxiZWSbENqToHV5sW+4sCdyWTBt3MA+rLGYqezZWT1HQEBpA2pj02MbPkRg==
X-Received: by 2002:a05:600c:1f8c:b0:42c:a89e:b0e6 with SMTP id 5b1f17b1804b1-4311ded4962mr125287535e9.11.1728989479480;
        Tue, 15 Oct 2024 03:51:19 -0700 (PDT)
Received: from localhost (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fbf82b1sm1268224f8f.72.2024.10.15.03.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 03:51:18 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: bp@alien8.de,
	x86@kernel.org
Cc: kernel-team@meta.com,
	jpoimboe@kernel.org,
	pawan.kumar.gupta@linux.intel.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] x86/bugs: default spectre_v2_user_cmd depends on Kconfig
Date: Tue, 15 Oct 2024 03:51:04 -0700
Message-ID: <20241015105107.496105-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains two patches that improve the handling of Spectre v2
user mitigations in the x86 architecture:

1. Make spectre_v2_user_cmd default depend on Kconfig
2. Simplify spectre_v2_user_select_mitigation() using cpu_smt_possible()

The first patch was originally part of a larger patchset [1] but was
removed in version 3 [2] to simplify the revision process. Now that the
original patchset has been merged, I am resubmitting this patch
separately.

This patch aligns the default configuration of spectre_v2_user_cmd with
CONFIG_MITIGATION_SPECTRE_V2, consistent with other user-selectable
mitigations.

The other patch is a simple optimization that leverages the
cpu_smt_possible() helper function to simplify the code in
spectre_v2_user_select_mitigation().

Together, these changes improve code consistency and simplify the
configuration and selection of Spectre v2 user mitigations.

[1] https://lore.kernel.org/all/20240118173213.2008115-4-leitao@debian.org/
[2] https://lore.kernel.org/all/20240422165830.2142904-1-leitao@debian.org/

Breno Leitao (2):
  x86/bugs: Use cpu_smt_possible helper
  x86/bugs: spectre user default must depend on MITIGATION_SPECTRE_V2

 arch/x86/kernel/cpu/bugs.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

-- 
2.43.5


