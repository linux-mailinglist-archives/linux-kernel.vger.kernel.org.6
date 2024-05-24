Return-Path: <linux-kernel+bounces-188462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F10028CE24E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 10:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DD0A1C218E0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 08:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19183128383;
	Fri, 24 May 2024 08:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M/A+1VCG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FF4127E12
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 08:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716539092; cv=none; b=SsniK0snpdsleqUt9XfGQQFzzLd8xx0fCyjwmeDGzJNBdWqb/awAL9Y6ry89AharPXGx41Bv9jzjZbAOrPvFlp+FDTxD1x0/rGaR2QWLtUaPJ6FTcO/9/5Igcezw9S4UJaH15uyyp2md0nUHPBymQjCdnN4XvL9gl14WgsXwIbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716539092; c=relaxed/simple;
	bh=OoeEiGup8kxbvVebwYL9smtlfOOm6MqCCnMknxBm4BE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MFqLhGlnmzh39nRhz6p2mwkofn0AMdcEt7mm8A3jdgKIGZyBoPpJcBj5wlUc4yahsi9BmwQE5ZGo71t04ZSaU/XOiULFOzkLO4y89a/rJJamx0uTQKrTMrkQjX1u73inbP0vxG5aCS9E94iXvGPaiJGJZnyWBoSIAyP0zZkdLug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M/A+1VCG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716539089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KRXrVEjE7hwIwPecyo3X3AyrQafZGVYbwM3Pgp/6o0s=;
	b=M/A+1VCGwOlT01CHM6MI2rGb6t10B5IxMScTjMNxsC7EIHQARn/E8ea0t2Ud7Di05tfX4g
	zQ9MbSc72Gv728Wy7r7WbbG1Z6KFRtjcbrUQqCkdWSwADRNJj7NdXOcXw+jJyAM30FMktc
	zPxKambSyLvNyNX3ZBnkTiF06/Rp8rA=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-uls1BQPJPR2plUVCYELqDg-1; Fri, 24 May 2024 04:24:47 -0400
X-MC-Unique: uls1BQPJPR2plUVCYELqDg-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2e95a1f049aso5645301fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 01:24:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716539085; x=1717143885;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KRXrVEjE7hwIwPecyo3X3AyrQafZGVYbwM3Pgp/6o0s=;
        b=URZVLUL9dT80hJnMrKg//L592vZBVfD+4ScPiMumu1rHC5OzVLYQsSXjTISiS8pqtB
         jQBIRpFmzaxxt1Xq9BTo69WfWI/8fhDGKN1LoHxdRFr9axYH0iuLsWtSR6bH3HUT/Jb5
         GIc9/cz6JJ/Hg1CPSVf2525hTu0KMqkghYSFSkKuBu5WmMKgqbfhcr2cZx9rnAzISssY
         b4zuJ6VAyVexkBTdDK82nZaCQmNCKokQ2HvxurGgYHmtDGb2A6gsuznOZZRotWzhEvPr
         wCfxl9TaHs/A41eP5c5j68EL//zLE09dFVeuQOhflfrMxuBmLZUFlbOtcifbZWPBoT57
         PEJA==
X-Gm-Message-State: AOJu0YxU0MCF2lE1A3s8iT8A1SuoES7G+nA7Hf+ptJ9jud1Qei9B/Lbq
	P7MHyJ6iMWchW6idMbfm7YGHA2MczH07dNcG7dnnASZnMgt3UHXXeySvX4D5PVa2YCK/I8kfhzb
	7h2hfN7Cn2J7OD51XWsv34PZVXkJwRoQjEp4LBRWIrmeu8/sST9SFOVOKf28E8nHdsccGMfTSLP
	RK/Ur1BFEAvBsdd0YZEi1dAnA9ay/JAwc4XGyy3s8QBNZG
X-Received: by 2002:a2e:a304:0:b0:2e1:a504:f9ec with SMTP id 38308e7fff4ca-2e95b0c1546mr12076631fa.23.1716539084938;
        Fri, 24 May 2024 01:24:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsD0Zx4R+bJoGaWEffXAyMLyRFY6ccJIG51S7LwCY1/ZZSqzhyemWROaM0WC1rr4KFj45nzA==
X-Received: by 2002:a2e:a304:0:b0:2e1:a504:f9ec with SMTP id 38308e7fff4ca-2e95b0c1546mr12076201fa.23.1716539084310;
        Fri, 24 May 2024 01:24:44 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089ae976sm13796085e9.38.2024.05.24.01.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 01:24:43 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	javier@dowhile0.org,
	Christian Brauner <brauner@kernel.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Petr Mladek <pmladek@suse.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Yoann Congal <yoann.congal@smile.fr>
Subject: [PATCH] userns: Default to 'yes' when CONFIG_MEMCG option is enabled
Date: Fri, 24 May 2024 10:24:16 +0200
Message-ID: <20240524082434.657573-1-javierm@redhat.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The default value for the CONFIG_USER_NS Kconfig symbol changed over time.

When first was introduced by commit acce292c82d4 ("user namespace: add the
framework"), the default was 'no'. But then it was changed to 'yes' if the
CONFIG_NAMESPACES option was enabled, by commit 17a6d4411a4d ("namespaces:
default all the namespaces to 'yes' when CONFIG_NAMESPACES is selected").

Then, commit 5673a94c1457 ("userns: Add a Kconfig option to enforce strict
kuid and kgid type checks") changed the default to 'no' again and selected
the (now defunct) UIDGID_STRICT_TYPE_CHECKS option.

This selected option was removed by commit 261000a56b63 ("userns: Remove
UIDGID_STRICT_TYPE_CHECKS"), but CONFIG_USER_NS default was left to 'no'.

Finally, the commit e11f0ae388f2 ("userns: Recommend use of memory control
groups") added to the Kconfig symbol's help text a recommendation that the
memory control groups should be used, to limit the amount of memory that a
user who can create user namespaces can consume.

Looking at the changes' history, a default to 'yes' when the CONFIG_MEMCG
option is enabled seems like a sane thing to do. Specially since systemd
requires user namespaces support for services that use the PrivateUsers=
property in their unit files (e.g: the UPower daemon).

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 init/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/init/Kconfig b/init/Kconfig
index 72404c1f2157..208e2f500ef0 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1239,6 +1239,7 @@ config IPC_NS
 
 config USER_NS
 	bool "User namespace"
+	default y if MEMCG
 	default n
 	help
 	  This allows containers, i.e. vservers, to use user namespaces
-- 
2.45.1


