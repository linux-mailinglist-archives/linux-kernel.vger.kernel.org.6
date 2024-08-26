Return-Path: <linux-kernel+bounces-301275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9552B95EE7D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 12:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51F21284450
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE1614A4E1;
	Mon, 26 Aug 2024 10:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f2+HPIG+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83B0149E0B
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 10:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724668301; cv=none; b=CL8qJ7ol2WLKb4o2pNTvCQu+SaolEgMjswoaHb50GfPNPzjF772rbt/Hhgh56CmyeJ/KTzt4BR84NlPmFb4252hmxCmS4wy36odSDca9KDbG4SnYabfW0tv2ICWbhqsWqLJb1BllRhrspX7lObfDVHpcw7GwcS0x11MXjiKS3oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724668301; c=relaxed/simple;
	bh=D56uU97DHLTAV46MruOMwh3ENgVDe/CheFULj4BVelg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ld5IqU9A50028CNzwyEfdH2TmMR43Qt+iyykZdCafbrtcA5ROff2u8R8sycAT/gs+OeQxn3M9tKftEYfSnttwto5DX0aGXjLdwUYAOYTY1D8KhUxwA/EEshvZALfUmnMxRTXUbmQwxtsor0qqv/j+jviqblm6pddUbc5+0wB2ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f2+HPIG+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724668298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0caQWYctkzPWXc3lfa4QY9g9vHYDKQdJAJoab25gorQ=;
	b=f2+HPIG+6vgvr0wi/6EF07Ig2NBbrRf/x6ADQyPM2MIgPBAGBKkWItqdlotG/KBsYpLmmJ
	IHRJVNgDIO/t0JquCzJB4IcwY6+Ec+6xAzHyDiqSbhvhUQmI1NHgQuRE0OHx5MjMJLmB8y
	QhWwFkKH2oIETfs9Uh2LML4PCyEU/UY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-2mxMM-inOf-rxF4uXtB5vQ-1; Mon, 26 Aug 2024 06:31:35 -0400
X-MC-Unique: 2mxMM-inOf-rxF4uXtB5vQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37188f68116so2425197f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 03:31:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724668294; x=1725273094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0caQWYctkzPWXc3lfa4QY9g9vHYDKQdJAJoab25gorQ=;
        b=Ue2Nj+ciKldXNuiBP/Zk1mNkPAQG23bX+3fdxgIJdCFRl0/eHOQOciELelp+ZUxzMz
         Y0NBFz6EUgBMwxqaOcx2J2wwFyaVkGmdLjlMTkO8zcrGFwabv91xySX0fuC4YpR5P/Ou
         c8ty0BELFQl2p/bR59nSQtbL11bgjK74wgSVDDejbE1PrvdK3ucqR/QV+WcuelkmBleu
         YIm/jsiowMq/Pow9Wq5p4L03plp5Hk0pGG7TPqioUjZxeGxMtC4tKITT4UnWgIYJYPPV
         hkNAoggXnvVrMqDnEBmx+IwEEhhx+tLlQNIFYtzhsG5jA3D+tZAqT2N8bCWdS+Yrw+6P
         qwHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtOyPk31ygrB8hx3fviTMb1lL8ByG1q/QU9fASyf6nUyvLUjmiH3Xpd8GMTXNEbCF6k+eMnB3hasy+p0I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2a7lVC2cfBHmLh7uwB+6PnhuIDzXfS6Ky3CryBpvfI5zLUtK8
	Bg9mjUYFZ7bIEHS7SLvL7uBNdFXtceY15OIjPyoPSgG0KNX/qzQXNfNyXg8sk2pblL4l859dMTB
	mRKWq5MvkKS9JQDFjpYvYric1H5i0CzCAiLYW21f2D43k+6/KLrArnGqewEWCpg==
X-Received: by 2002:a5d:6702:0:b0:371:8db9:939e with SMTP id ffacd0b85a97d-373118e356cmr5559984f8f.51.1724668293902;
        Mon, 26 Aug 2024 03:31:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUeeP55UuNdWAbZbdqz9KsjtE0dvBbjRTHSYopNttrDKLMjjvyaUEJgoMgra3xM9ZAZ8FKfQ==
X-Received: by 2002:a5d:6702:0:b0:371:8db9:939e with SMTP id ffacd0b85a97d-373118e356cmr5559965f8f.51.1724668293420;
        Mon, 26 Aug 2024 03:31:33 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e40:14b0:833c:88f3:25a9:d641])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac518043csm148327225e9.46.2024.08.26.03.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 03:31:32 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: adjust file entries in TEXAS INSTRUMENTS AUDIO DRIVERS
Date: Mon, 26 Aug 2024 12:31:29 +0200
Message-ID: <20240826103129.18882-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit e486feb7b8ec ("ASoC: dt-bindings: convert tlv320aic31xx.txt to
yaml") converts tlv320aic31xx.txt to ti,tlv320dac3100.yaml, but misses to
adjust the file entry in TEXAS INSTRUMENTS AUDIO (ASoC/HDA) DRIVERS.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference.

The pattern ti,tlv320*.yaml in the section already covers
ti,tlv320dac3100.yaml and ti,tlv320adcx140.yaml. So, further file entries
in this section are redundant. Adjust the file entries in TEXAS INSTRUMENTS
AUDIO (ASoC/HDA) DRIVERS accordingly.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5dd88c28c0f7..6aa85a43d8c1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22753,8 +22753,6 @@ F:	Documentation/devicetree/bindings/sound/ti,tpa6130a2.yaml
 F:	Documentation/devicetree/bindings/sound/ti,pcm1681.yaml
 F:	Documentation/devicetree/bindings/sound/ti,pcm3168a.yaml
 F:	Documentation/devicetree/bindings/sound/ti,tlv320*.yaml
-F:	Documentation/devicetree/bindings/sound/ti,tlv320adcx140.yaml
-F:	Documentation/devicetree/bindings/sound/tlv320aic31xx.txt
 F:	include/sound/tas2*.h
 F:	include/sound/tlv320*.h
 F:	include/sound/tpa6130a2-plat.h
-- 
2.45.2


