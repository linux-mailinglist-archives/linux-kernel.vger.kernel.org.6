Return-Path: <linux-kernel+bounces-390392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6799E9B7953
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 12:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2800DB26CCA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 11:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7F519ABAA;
	Thu, 31 Oct 2024 11:06:31 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E63199FC6;
	Thu, 31 Oct 2024 11:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730372790; cv=none; b=miLfg5PysWWoQnKO64lpeKZATt5FmDFCkTsdendIFHb/pzlRZnphHNDIS6WX9xc0XSKgy4FMs28ca4fUNgkCVHWUgjz8omsW9FSG2emeTYIJNff441zlyGWxky8Ht+AY/mfUFXXIAbR8KFWb2mIPVyKCAW5wRGuYbZf6gGHBem4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730372790; c=relaxed/simple;
	bh=ZBN0W8BcE9Q5aKWuCWSFA/w5EPDOGkHkgksio0pa6aA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hMz72mGOpQ34/H2gG3aRvlmU3S5GJkUpnlDFpxfAaOpRGD+MKes204nDjk3XyonLr6mM9t7dCkyx0P6MmUwGcGcOlVeaIoWRt6oe9MyC6lNLuMkYcRmHGkNkg7A5dkp0Aon8npSIyuFywmR5+yestqm+s6YdYTvYIrbkyFyp13k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c941623a5aso3324137a12.0;
        Thu, 31 Oct 2024 04:06:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730372786; x=1730977586;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fI0obEY2fOPVsshDc4EINPODg5wAd8JBksvUKXbxFzs=;
        b=sUlD2sVIeo7z50DawC02eOcH+3JHxeH7ltMb69Ajb6fOrygtflNq8pUAkyR3nkYqIP
         TUsBrhJledYFUzuMdAUG4DCaIEMIisAMfUkBJgPtlLJOzhKrbKKkb/TkjlLaSia0pWph
         GIagYqZ6MR4B4+k0srPaV/fgQfH/Kjigtkh2yYjTnzaWoXF+gys7d0CAvxdtHGxasnmS
         LLSVYbfmus9KTtGNz9TfNSVgfbrNJaa2z7zCUlvlxWICDoSU0G9pbc32MtTmqkN8/l3e
         6by43viLBlkJiom7kRWR212GE1nSM4q7o4TfvPPFVAaWFVkUbsD7hDxsnZ93v+AUANtw
         IKKw==
X-Forwarded-Encrypted: i=1; AJvYcCVktu93cDd53N6/xhB3N1/Cvgr/MYeeZVmVT2e89Y2UJW50PHjBq6/BLBO1rNZzmhs9c9d6PnERJUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS8zctbUJ8IAeZtjpmWCF3u8sCOuojkkGCNQzgh+IXSPtOLk9d
	EoWOuuflf8Nlf7KCZG9pU6GqMMCfO/q0k8czeyIGqjL3TSBoP7QP
X-Google-Smtp-Source: AGHT+IGdBBqXwDf26omGbpm6rsmYdTyMfipjhzsVooqc1JRhzWRBH0LtOcrSAylwxxS4v0mC4/u1og==
X-Received: by 2002:a05:6402:400a:b0:5ca:18c9:f382 with SMTP id 4fb4d7f45d1cf-5ceabec5c98mr2113689a12.3.1730372785655;
        Thu, 31 Oct 2024 04:06:25 -0700 (PDT)
Received: from localhost (fwdproxy-lla-114.fbsv.net. [2a03:2880:30ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ceac76ffdcsm475159a12.28.2024.10.31.04.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 04:06:24 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH v2 0/2] x86/bugs: default spectre_v2_user_cmd depends on
 Kconfig
Date: Thu, 31 Oct 2024 04:06:15 -0700
Message-Id: <20241031-x86_bugs_last_v2-v2-0-b7ff1dab840e@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKdkI2cC/y3MQQrCMBBG4asM/7qBJBUtuYpIiGZSB6Rqpi2F0
 rsLtsv3Ld4K5SqsCLSi8iwq7wGBfEN4PNPQs5GMQPDWn5xtnVm6c7xPvcZX0jHO3qRcuuLspWT
 HaAifykWW//J627vydxKV8cBt+wGkSEoldwAAAA==
X-Change-ID: 20241031-x86_bugs_last_v2-adf8f107fd1e
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
 Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1818; i=leitao@debian.org;
 h=from:subject:message-id; bh=ZBN0W8BcE9Q5aKWuCWSFA/w5EPDOGkHkgksio0pa6aA=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnI2SvE3a6eZOrJ4Xf+W7ou7YKvn+UT68T7KMDC
 0dnRNqgqVWJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZyNkrwAKCRA1o5Of/Hh3
 bcaTD/wO/J3csSEPMKnMOiJuluZD/RYPaEa7jdFi6xKG81jZY5Rs5wLd2jy2IHGKtvUPuRKEVgO
 js/ugOIng/jKG6kzvuFsDb3qyyPeNSfNbXzTNPrMMRikVP8Y2+nhNaRD0kRx23Cl5qdDZhR7+kd
 V64TZryu0uFH8rHVyruzLZsiN4DV27l0UsFWaYJB/Xyw4Mmn4jpSYLk0p/GqjbeneEWluIZn2OP
 za+v+qp7Z8uLxYW5RRvyIUWX7wFwYqWEI9WEC/hmBKaHyEintAwiItMVUCZErANpYv5npDXPM6i
 sN7u5TY72P1mK5ntKd6lQsjID01iwGFPJ/ONEZ0+OW2GLTO1pt31sZldJij2GFKDT0EdHYYHGaM
 6VzUkSXAHHePhWhELgjTbkej68MsIXPNF7JbxJZQG+EV6HB3kF7gaVWerkjV91UfXYdppvEZsBU
 SkBaqtcDxjdHuJE/B7JbMkuboJ1IZJ2mhXDf0vRSh/gYYPLEaptBfUQpU+2crGt/yyN1ui8H7UM
 mbhSJCYOsXdY/9ke2/J0/U0OyGqJbz+FgF/jOEphWLpT4ccHrZU1Hqi9ObxzvzZLPp3o13g+NuX
 aWDEBnieekn8swGn/dT9oKE+K08yRi05EBAdBNCNPu8FdozZwMfV0rk2yJ37HIVD8htgthO7EpI
 q4MpcK9zlAso0GA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

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

Changelog:
 v2:
   * Added the documentation bits in kernel-parameters.txt, as suggested
     by Pawan.
 v1:
   * https://lore.kernel.org/all/20241015105107.496105-1-leitao@debian.org/#r

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Breno Leitao (2):
      x86/bugs: Use cpu_smt_possible helper
      x86/bugs: spectre user default must depend on MITIGATION_SPECTRE_V2

 Documentation/admin-guide/kernel-parameters.txt |  2 ++
 arch/x86/kernel/cpu/bugs.c                      | 17 ++++++++---------
 2 files changed, 10 insertions(+), 9 deletions(-)
---
base-commit: 81983758430957d9a5cb3333fe324fd70cf63e7e
change-id: 20241031-x86_bugs_last_v2-adf8f107fd1e

Best regards,
-- 
Breno Leitao <leitao@debian.org>


