Return-Path: <linux-kernel+bounces-171491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0BD8BE50D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDE1A1C23E33
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FAB15EFD5;
	Tue,  7 May 2024 14:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QyQnBPPa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B8315FA60
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 14:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715090492; cv=none; b=WtOdyiHpNzZ35osBqdsJRkt+zhArZ3fjSysVU2OUs99zVnjmjpaV8aIoSjeZcjrW96WhilbDPDos66ZBkBlbYUiT1Q6G9YlSuaFr5m+hU0rV9jtWfOuVdpEyaY+Li+fZhgEGqKTz1QLwRGgw3cE4syOWGNxstHL1R0quYPX2a/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715090492; c=relaxed/simple;
	bh=+g8grQa8IFxIKr6O761BzLF6WlW57k8wJHHqWVnea9E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sr4SZrx1zS54wKEA2K1oLKcgUtGlWn6dSso/fiJDPepYLn4P6riB8Rv8Ofp5Z87bqqSmSrMreWP3w91PiRKZ4h5EDnSstJDeikZmtiGzDxDrPSevJT1EK2F7j03oWEKd4RAbtQNR7AZxef0dgfZnsGy6FzBumAsNl0cGcaEqMXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QyQnBPPa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715090489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ULn520VtyFUFvINDBmnGTg2429ZFbTlPrrXCyiYuIFk=;
	b=QyQnBPPadwxNNU3XPlipJ4VNjHKlFBY6jUTLZCcg15AmadsFo3HOeYImDkAQJpGhsadXQr
	G0gkt/bNGIz7G3nL5IdFXEOfIpAH1nhpseogtREzkNNy/MkrnPR1SraKV2kzRjqh8nw+fF
	k6rpz8rL5zPu0pUeQ9Kmt2WlY21+Af4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-gTqQR7jfMvW1kpcThoKWQg-1; Tue, 07 May 2024 10:01:27 -0400
X-MC-Unique: gTqQR7jfMvW1kpcThoKWQg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a59a212d874so232422366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 07:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715090486; x=1715695286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ULn520VtyFUFvINDBmnGTg2429ZFbTlPrrXCyiYuIFk=;
        b=aJJxegiYvM3zoWEqa6M5TeH7waMg9iwr36RsguygzLfxvOelXzOY7XZU8xD+qlBrgr
         Mxxg+IbXiuyc0wUgDmhwxDwaJxCpYYn1gD154VAk/FHL3jRXSb/NlcNEZCwCdsytVOoi
         4ZWI8Se++fHTl4QI0MU6BYfkSgjOONa/OKYXr8rKvA1GbWalJL/oUInJ6ez1drpMv1+1
         xSHCv5Qi5cF8gc1/x2qUtIPe8SXE7XiemUP/OnAVf7+BLZqTgqT8Tpg9uCDo7i8Kox2c
         aVB/Qa/xNzmDX30KR1B3aUJWqNoG3vPcknnwMi6wUpg0sxocx1v9iPGfmp2e3Y9P+tQc
         m95Q==
X-Forwarded-Encrypted: i=1; AJvYcCXOqXXHxS+aPjXr8TtMHPs0P4jzUs0ReccnBnIwwsEAY2q2FWuEd4I/QwW96VCNU+GuCz7ZhBB9BZ9iYgF/3Ai4PbMbEbXboojQbQtU
X-Gm-Message-State: AOJu0YyzPt120J0fsvTi0ImxkdjHkGcq0k6BD3wDPoDUInNfeTHGZ7eK
	4MARKjFxiSxxbXZZrIQMgDPGoFk35ujJTFYPes4RrpFaBZaLtweTCotO9nn8GNG6f/kGLTs4Vt6
	zAIgp7PwxzUVLKsq8XGVfohFynnmLcKlR4K9my4KPHD/KkzODmtb3t0bY7uZ68Q==
X-Received: by 2002:a17:906:c311:b0:a59:b099:1544 with SMTP id s17-20020a170906c31100b00a59b0991544mr4636184ejz.42.1715090486687;
        Tue, 07 May 2024 07:01:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWKHyguRFTZU0iJ+9SVdFZmCvdMPXw68yJmNWWRHcy4KBLCFlWQ0WOCjLrHyUtqT8caqLjSg==
X-Received: by 2002:a17:906:c311:b0:a59:b099:1544 with SMTP id s17-20020a170906c31100b00a59b0991544mr4636165ejz.42.1715090486292;
        Tue, 07 May 2024 07:01:26 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e40:14b0:4ce1:e394:7ac0:6905])
        by smtp.gmail.com with ESMTPSA id ag3-20020a1709069a8300b00a59a6fac3besm4341867ejc.211.2024.05.07.07.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 07:01:25 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: repair file entry in SECURITY SUBSYSTEM
Date: Tue,  7 May 2024 16:01:22 +0200
Message-ID: <20240507140122.176304-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit 67889688e05b ("MAINTAINERS: update the LSM file list") adds a few
file entries to lsm-related header files. Among them, there is a reference
to include/security.h. However, security.h is located in include/linux/,
not in include/.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference.

Repair this new file entry in the SECURITY SUBSYSTEM section.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a37cca3c47ef..ca79616a4836 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20140,7 +20140,7 @@ T:	git https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
 F:	include/linux/lsm_audit.h
 F:	include/linux/lsm_hook_defs.h
 F:	include/linux/lsm_hooks.h
-F:	include/security.h
+F:	include/linux/security.h
 F:	include/uapi/linux/lsm.h
 F:	security/
 F:	tools/testing/selftests/lsm/
-- 
2.44.0


