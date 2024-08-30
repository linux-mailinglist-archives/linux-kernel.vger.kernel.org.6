Return-Path: <linux-kernel+bounces-308329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF1D965A65
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A90F71F24662
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 08:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECAFE16D317;
	Fri, 30 Aug 2024 08:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="De445aRC"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6AD1531F4
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 08:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725006855; cv=none; b=SyXXt+blcztk6mUWGpWxsiwb95eNLuqKUh0LCZVmZCP0FQdqSrun2erPXMbAYXxJn6xs38zzcNHwbUuRgL/VqU4Z3qSnZwwO24/u2cdC1A3RzUAmtB+4/OPNnY1ntuhNTqMI+syeIILbxFWe4IupSgpakEIEs/J1bi+nSAACh2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725006855; c=relaxed/simple;
	bh=jQlMz6m6ImgAtZY+h/kMHodc98XyH/iEoFZSqdyF+M8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T81GhK+WoPwtTMqlRXtKmSnxsguZov2INulGb/ALWNSuL/DKjhYHh4O+KmmzXdunatzFircpBqsowGAVyIpvTvNjYyImvzWh7Iu2l5TLccq3KDzkN3I42S7T1DsdLr0uoV26hTj0XvtG4Q7w7euYHqHlsuUTJRoeJjry3FBPvVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=De445aRC; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4280bca3960so13504645e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 01:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725006851; x=1725611651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XOKEPccSNFFD//icEe5bzT6Y7LWUp0u6SzrewGqz2/o=;
        b=De445aRCJBIfh3zvk+K/9NINFcBAZoTYoGTVib5xaRIEAFHWqu7+aEPAHL+0A/y3+v
         teoUxsXv0eiSSKaCD10d72VavwZ47nGzs/6/NgQeuYUtsbAICovciDzZesw2COypzzoL
         W/q97QPNu2Ob+wo7COfr6Hy7V1w+h9LsqOk/q7Lnr+PPaasHJMfZtWJaopyiefJtM9Ey
         U8HL5w1bhqgJiQ56I/6RU+4rgmv1oueXe+dJKYEJzPNw269gi8rH2+HpljNDskcq0iXe
         kgp/93mslJXB/LOi9ETKIjMUCin6JlUpVSQ249m2uXr4sT8VbPgWRrmLvG4QigDlTSBJ
         lDpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725006851; x=1725611651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XOKEPccSNFFD//icEe5bzT6Y7LWUp0u6SzrewGqz2/o=;
        b=WApIpqOdwexrCLi02LnQ+P+x8ANsEzExrg4mNrd5YWIpqc4S+BSCiCF0lvZoy5BYrR
         i7AKz/AkWvJfecG66TH5BX6iWKxMdKrYRG9vDRX78e7cORXqlDWh6ZyaOBy6N3G6lfvU
         gpiqgT/Ox806vip1X0ZqjD/dj5t9+VinoXAxLXTjojmNNuLChVkLXeSh8549MwOFUc0Y
         +rah/drhJsOgPgkhOIhL6OxHnSLFx5jWmWDYQqUdUJ4pg41sxkN0lUOFbvvmpZhMWnq3
         rW1SypF/MsdIDOorB8igyAw4ieHmoe766kJRC9pkSEuLSVT6FPR4AEeo2rXhXjTZVDpt
         KDAQ==
X-Gm-Message-State: AOJu0YyuE02TFTiDMg2WF47B8Q9otBy7f2FwG2a+rE+b7y60nSm+W6fv
	ilATjIzLDNPplh5HCksA072Xzk9K5hoX8cMgIYvOylN2zbuqpnHq7gVUUuuA
X-Google-Smtp-Source: AGHT+IE6AXTRZ7kSL39FJj7wotGJB+k/REwn6j8zN0Amqwwq1Hz7kPNgnWG2Co3lfEPPi9rzoqsICQ==
X-Received: by 2002:adf:f30e:0:b0:371:7e46:68cb with SMTP id ffacd0b85a97d-3749b5806a1mr3400292f8f.50.1725006850203;
        Fri, 30 Aug 2024 01:34:10 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee868adsm3380152f8f.46.2024.08.30.01.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 01:34:09 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH] devres: Correclty strip percpu address space of devm_free_percpu() argument
Date: Fri, 30 Aug 2024 10:33:52 +0200
Message-ID: <20240830083406.9695-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

devm_free_percpu() calls devres_release() with a pointer in percpu
address space. devres_release() expects pointers in the generic address
space, so address space needs to be stripped from the argument.

When strict percpu address space checks are enabled, then the current
direct cast from the percpu address space to the generic address space
fails the compilation on x86_64 with:

devres.c:1234:32: error: cast to generic address space pointer from disjoint ‘__seg_gs’ address space pointer

Add intermediate casts to unsigned long to remove address space of
the pointer before casting it to the generic AS, as advised in [1]
and [2].

Side note: sparse still requires __force, although the documentation
[2] allows casts to unsigned long without __force attribute.

Found by GCC's named address space checks.

There were no changes in the resulting object file.

[1] https://gcc.gnu.org/onlinedocs/gcc/Named-Address-Spaces.html#x86-Named-Address-Spaces
[2] https://sparse.docs.kernel.org/en/latest/annotations.html#address-space-name

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
---
 drivers/base/devres.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index a2ce0ead06a6..2152eec0c135 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -1231,6 +1231,6 @@ void devm_free_percpu(struct device *dev, void __percpu *pdata)
 	 * devm_free_pages() does.
 	 */
 	WARN_ON(devres_release(dev, devm_percpu_release, devm_percpu_match,
-			       (__force void *)pdata));
+			       (void *)(__force unsigned long)pdata));
 }
 EXPORT_SYMBOL_GPL(devm_free_percpu);
-- 
2.46.0


