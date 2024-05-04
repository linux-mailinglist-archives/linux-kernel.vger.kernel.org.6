Return-Path: <linux-kernel+bounces-168566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 161C38BBA3F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 11:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 157981C212D9
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 09:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6566B171D2;
	Sat,  4 May 2024 09:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEKmw+LK"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D28639;
	Sat,  4 May 2024 09:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714814734; cv=none; b=rs/4TQBYy0W00/ayBS1vjcasoElIWtRIP1IgUSuOf/EsTLYlCNaUB9QNuPKHSgEtyC/s9w0JBHWPZwxjqAwwdaAlfkaW2tbNirMrIo+aJ2ZlVVxvqsPXtlji6k3OOnoeq4ZKaukLC/5NTR5zSOnfJAMs5YBBtu5nfwXPGgSbBWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714814734; c=relaxed/simple;
	bh=vtgJi36sMoYwAKl5i4UgliExL+PqTPRhqrRJiW8nXpc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DkbbqarHcXi5kVSO2IPqWmuGKR8x8crA+w9E/fUOC8m3rMuCNGiCxgd4wJskxiarfjjCnpw9bsfDUXPWRLONEhoT0voVeEMUeGQQMR09ShaS46D8Ec1r/OStDKsjzF2ELsy04aoqzA/xao2E2iLGgpxt003Llu4dyGHfWg5TzZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEKmw+LK; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a5966f5a76bso419372966b.1;
        Sat, 04 May 2024 02:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714814730; x=1715419530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j3reEgU3owMqAQcOynJPthj/UK20sgv+opLyAsCpLeE=;
        b=EEKmw+LKoq12537U+JVZh+RwBz/VPC2MBaE+9W3P7gofM47N9wUvVF9T89HpYhScZi
         090hSxhbi2sPkduiPwCWmG0mgxOBm5IbF2wq98tELDO9p9lob65zrDh3wlEtYurn3+1K
         HOVlTyLqF+1Ez38ftCLM4OH+Azi2BRIk9T4AojMEAxKWoKpNnd31H+pbBR01egQzQlBZ
         lCaSnyrOz3gTmWx6VZC6QHtf27kfdOMYYfxBUgqdB+lK1m2Mbm81ROGr/SGDP4ID3iDJ
         3/rNj/ctaQarjpmniwcJe06ddwEaMFhrb+ltlEFJg8vedWuLLPG5rps+Kn4x8Hc9avDd
         J/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714814730; x=1715419530;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j3reEgU3owMqAQcOynJPthj/UK20sgv+opLyAsCpLeE=;
        b=oON/1G3foRi513NR5yOcWPFHhUIwzV4k5Jli+Xp8Z7xvglR1yEsE0fEnL//LprgP2C
         KQ9/53SbUdk/mYllQx+bQAqrk5IRJY/arN3kbq0MvXqeQFR2ub1JEj9Oh79DFiQPaVA/
         0wX71pTeU8hzek3mzlHaxlmbcWtcl28wPt9L/p1GPQl0yCBqaMF1uAo1coo4TRRpHLWA
         yAdYC5233q9gv8N0ZKA87OZCGA0L1taAkLZENvt+hHA8JBQSggID8/zPEvjazK6eQGU4
         ewxpxhVg+j8F+W2YDmWUcby/uxF/7fMdqy2GMver9ltw+pfxXJUuSMixHElRamjWKsc1
         iJRg==
X-Forwarded-Encrypted: i=1; AJvYcCVtScAhcJ//YvnT5f+Smq1b7rqGEM7DLIag9ds3Eq/ndQFqBzcxwZaABXstNwMCxm9wQIXZP54SErhdHaIo8ioTfmV8s+ORFikuhao/
X-Gm-Message-State: AOJu0YwvHoxtTJh0D8zMWLkFIGe0s/Iexjv/e9hz2oz7PaYB+0JPkF8h
	hjaPTUhc1nxI7pp+v7S+2PyhWTJRU5+GGzxlBakxzpxegVOhhR9Ho51y3bHLn/4=
X-Google-Smtp-Source: AGHT+IEr9QK3djS4oDr/qVZGUB3u1VG0r5Nq9vkOIWG+ZdaVLR7TOwzL5WD8u/b4GQj0RbugzgL30A==
X-Received: by 2002:a17:906:264a:b0:a59:a7ea:dd22 with SMTP id i10-20020a170906264a00b00a59a7eadd22mr863099ejc.14.1714814730405;
        Sat, 04 May 2024 02:25:30 -0700 (PDT)
Received: from fedora.. (cable-178-148-234-71.dynamic.sbb.rs. [178.148.234.71])
        by smtp.gmail.com with ESMTPSA id ce3-20020a170906b24300b00a587831c09fsm2740231ejb.186.2024.05.04.02.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 May 2024 02:25:29 -0700 (PDT)
From: Aleksa Savic <savicaleksa83@gmail.com>
To: linux-hwmon@vger.kernel.org
Cc: Jonas Malaco <jonas@protocubo.io>,
	Aleksa Savic <savicaleksa83@gmail.com>,
	Marius Zachmann <mail@mariuszachmann.de>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] hwmon: (corsair-cpro) Fix issues when hidraw is used
Date: Sat,  4 May 2024 11:25:00 +0200
Message-ID: <20240504092504.24158-1-savicaleksa83@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series fixes the behavior of the corsair-cpro driver while
hidraw is used from userspace.

The first patch introduces a separate buffer for sending commands to
the device to prevent it from being overwritten thanks to a hidraw
userspace call.

The second patch replaces the complete() call in the raw event parsing
function with complete_all() to signify that the completion is done
until reinit.

The third patch introduces locking for the ccp->wait_input_report
completion as it's touched in functions that could be executing in
parallel.

Aleksa Savic (3):
  hwmon: (corsair-cpro) Use a separate buffer for sending commands
  hwmon: (corsair-cpro) Use complete_all() instead of complete() in
    ccp_raw_event()
  hwmon: (corsair-cpro) Protect ccp->wait_input_report with a spinlock

 drivers/hwmon/corsair-cpro.c | 45 +++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 13 deletions(-)

-- 
2.44.0


