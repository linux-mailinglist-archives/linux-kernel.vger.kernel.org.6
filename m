Return-Path: <linux-kernel+bounces-338393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADC598573F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 12:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DD271C20D2D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 10:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9304615C15D;
	Wed, 25 Sep 2024 10:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQDOPTl4"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646911304AB
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 10:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727260641; cv=none; b=Hf0g4lpV8MgdTJ60jncJcwr8Pz/9lpeeRXA+0mgsEaIF8qO7+W51JC6vtLwZQ0u2vcEeUgRidnOiEOCImqQLWHpe2j/jNBTpj9p0E/NEvKab9QazKBNYR9AcC3bAaICU4nBvHThPNLNVadlPyFVOy2tBBaEq1vF8CJfXAseZh24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727260641; c=relaxed/simple;
	bh=k+jhJ2z9Ol8Z5CioaVMP1ZtfwDliFwlUP3Gx7CQVmSY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=grIpHqlLF09erVlOY35QvBQAKf0pToNJNdZmql0wgjxb/6cr7NLu61VoEX1a34b3vioXDOH/grK1hqZkSE8msvNYAGEgXJNG9qIwcxgtvmCCuZgDe0b8NfE74gquISxfM5jp+iz90xydZzRkzfyg49JX1/GfvC+blog/RGmKjfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQDOPTl4; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f762de00e5so67268711fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 03:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727260637; x=1727865437; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IMAMIauv0JorE2lgp7aNmYqM5pVwSx13jdCVHQTr/s4=;
        b=FQDOPTl44YtRY41Y8BIEUdJsHRFoR1DYVNejT9TNgWTWcG51sj5Hp9s/UdHPlG3xs2
         AwuWOK+f6sn496U4c8D3NwrNZqm9lq3axHdV+ZfoRu+wah+1Zta2ZDQo+d7dEztOS7rZ
         BiFxLVJSEq8q6fj9r8eZRUhnULF4GtfsSl+RWCBwump3vRirJ44LTiRC0N2J4KtRN1EY
         KmZbrs3vC85U19+Iud7cEImlLdNqHCfIND80rSCfZEIrEa4ZLI09h2m+ZzJa3x/UL8/k
         mLx+awYyL0I21stJIwTs/uvSbVSWDU9NjdXfJwx+v7nO9fXuFHmtNDzn4U+2DL5awOKO
         Njmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727260637; x=1727865437;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IMAMIauv0JorE2lgp7aNmYqM5pVwSx13jdCVHQTr/s4=;
        b=lrkP135/vlIUaZwJWAYLXxGfO3/t91UnwTkowjyddMytgJ2YNjeUcsvqVcKl/5s94W
         B/Q6yMTUTma+9MNn8/YroKtzf1JrJ2CIvDfqLLviirchZVPyirr0Bnva4sqpfsZzSxah
         XGXj8QftSGCu+0XPKtfCBuVhsCE4LTGPu80rS4ff+e+NkjFk8vkbOa3TKivVx2g5F0Oc
         Ain/PyMfop+Darg69VjB0yU23p/uYksG7xnep5nyWUXH0KvwSZ+jCTFYL85JKIbNFAmX
         KNxPq7raOI6z+Iygp6RKFUTi17v7RXrzTL6evSGVT8szAbSTnuYxs+GXohELzuEa8tc0
         xoMA==
X-Gm-Message-State: AOJu0YySh3fyzkNDYUzU6B85h60UacvSbiXhUxwg12JIHX/X7u+djcFz
	ChzBSjhN9fatVm5etM32ibklcimfucfKAIuviYr9NwSKgUhIiMUhZQue2kln
X-Google-Smtp-Source: AGHT+IGDLK8KHM4wQriCHGmH4AHG6bo1qOu6Oqa6YxVRkGitnuyXfc9DmF30/O3g6a7rHDv4+BeK0g==
X-Received: by 2002:a05:651c:b0b:b0:2f6:5868:808a with SMTP id 38308e7fff4ca-2f915ff5531mr12527001fa.19.1727260637005;
        Wed, 25 Sep 2024 03:37:17 -0700 (PDT)
Received: from [192.168.1.11] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f8d288e077sm4808361fa.88.2024.09.25.03.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 03:37:16 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Wed, 25 Sep 2024 12:37:05 +0200
Subject: [PATCH] scripts: config: fix don't typo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240925-config-v1-1-0f8f426a6dfb@gmail.com>
X-B4-Tracking: v=1; b=H4sIANDn82YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDSyNT3eT8vLTMdN3UlFSLpNQkMyNTkyQloOKCotS0zAqwQdGxtbUAKLx
 Ih1gAAAA=
X-Change-ID: 20240925-config-ede8beb6254b
To: linux-kernel@vger.kernel.org
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=862;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=k+jhJ2z9Ol8Z5CioaVMP1ZtfwDliFwlUP3Gx7CQVmSY=;
 b=owEBbQKS/ZANAwAIAYiATm9ZXVIyAcsmYgBm8+fXZZJJRxACiBTfWP4DzoVppBVLCKjJQpLXx
 vkyCD5/4FOJAjMEAAEIAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCZvPn1wAKCRCIgE5vWV1S
 MoI6D/9BYbeO5acTuXDBKamV2pZVzYoWz5hfudcNlGhglGIHhqbCRba6a+gmLIgCNMfE0z+PRHo
 0A/o4R6h5PmVfB6+2ZQI6KpB4EB0DiyI4SkG3gjLAOIjuTskrE1jIPXrMfbDbqE3szJstfmH+BQ
 Y6cmSfuBP7i0kPYVgwVgra1HY/F7vQepAELft23bFCBzvtq7X3aJorKm/iOf9atMi7fTe2xwDw3
 0aMUf/2eyaNRABouqAH4leERZ5Kqm+rTjEfeVQdaFkDQxUK6gHEc5XjBLeKp54G8mqNJMf2w0Kl
 iIYLPB9tTlCdwD3pQ9yoAE8Fi1fugQTW8jwSPt3g8RcVhYlq3HMP7wrEpJWlsu4yATxXMpfIqqb
 JFh5jDNgMnUtBeSN6PiDPHxQ2jFAVsUn5otXiF2vqT8jgo2DAA/WW4fFxYlKxVIA/vQlJYaCXdI
 9ZDutktTbGuX+0/FzjWJhjh+XdoOWnhCmpS0r04Y7vVg4VxlN8LdA1T7oOuaX/MyVIrTg2DWAuD
 C8sREuN+j5Yt+/9YJw567JCkFWusxZsRfTAcrIg+prSF+SmbLf8G2WC5sTDgklxlxEmGHxrqcp0
 CgLF8dby5iEofXhXqPMXYxSPT99VhK2YL0u1H+ak+h6HR8IB7HkGB4a6KjYy9F7NVAGjN71alcX
 vx+cQcV7I4lq4KA==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

dont' =>  don't

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 scripts/config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/config b/scripts/config
index ff88e2faefd35c2d763a1d485eef39140efaa300..95b2d79f07bdec7af676c7e9421fc2717297e7bc 100755
--- a/scripts/config
+++ b/scripts/config
@@ -37,7 +37,7 @@ commands:
 
 options:
 	--file config-file   .config file to change (default .config)
-	--keep-case|-k       Keep next symbols' case (dont' upper-case it)
+	--keep-case|-k       Keep next symbols' case (don't upper-case it)
 
 $myname doesn't check the validity of the .config file. This is done at next
 make time.

---
base-commit: 200289db261f0c8131a5756133e9d30966289c3b
change-id: 20240925-config-ede8beb6254b

Best regards,
-- 
Marcus Folkesson <marcus.folkesson@gmail.com>


