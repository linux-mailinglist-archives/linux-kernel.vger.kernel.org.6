Return-Path: <linux-kernel+bounces-188008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA558CDBC6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 23:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51F2B1F24A59
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 21:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3148127E04;
	Thu, 23 May 2024 21:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eF0J34zu"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9970684E1E
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 21:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716498904; cv=none; b=cgfxfhOZDcTLfrBnoHTwdPLLyhTSpfU343M7199TbSl5yi/tb83EIFPoCK0cvYzRG49mGGzce2FCmox4ipdDaXdXtxERDdsB/kJiNE4VUDR64yBxtk5wiPItjO2SIBbFIpWxoe+AJ/bKwny1WJl7QDrQmQXsxOzMrmMoM0oYWTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716498904; c=relaxed/simple;
	bh=uc+fbO51JAgrHHKzQByvLrZwrpEye8agfALuE4RBUv4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gGEJhsZKYNZ8a9kUbXgVsjYVIs+gRniOjXFfuOU/IHldtMsAfJbBXWvcz4fGM8H13f03zmIo/k1fyGmtVYnn+2ZJ7hGwZcM+q0qLlJdce7X/9nU7jjPDyxc2XxUZvyyug+N86yY6kM7w5lvbwWRmc+pivzgORo/oZG5HE84oeQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jwylder.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eF0J34zu; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jwylder.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-627ebc309c8so37062317b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 14:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716498901; x=1717103701; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2R6UodRaLm6pGjY7twVjUfcDvm1sCMloJlBSSkefp+U=;
        b=eF0J34zuQvUerYhexvKTtFFn2vWk3EDcm41vtUM6Ocb9UkXIbluHDM2V2RZUUUoTJr
         /v2HWaJ0fs2Nk3gDKeD6StFD3aLDb6GS5DLlDrZ3p9y8+ILBChMoOImzGGY2ZnCJANoO
         Coe8ucbBxhK+8IfUcsFTBJKbqwsNzERuuKal/e8hNH7p3Jh7DwC75jA2iaB9K6ZwJo9e
         +BzeJQdCV9uaCfQ16giZl8TnAdKpgQhGLlEC+9wgmi8r04FHFsYitTZLVXZvM1lFMaCs
         uyPxgPd+XykOi25VTv5Ykzyme1bVEiEYKmNfqYXG8fzQn9GViaodtnMKtuHsCkM5XXNt
         nAkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716498901; x=1717103701;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2R6UodRaLm6pGjY7twVjUfcDvm1sCMloJlBSSkefp+U=;
        b=QoUJ0PnDMcqHaf0xpaRAhmuv08BDMrylzaJx8uP/qoo8NQ5nd5BcIKZFtx3ztkYgQQ
         IJ4HuDSRnEVAhIGbUbrd7vPSAETFJ0CA81Zi41tmWV10euv8VYo3UaNVNMvt0CnY6kqO
         8Olbxl0OlZPGrCSu4OFPiv0MYIRelaA90LnFrHr5kqZbbldJ2ANhvCnr1HlbmEI3w+S9
         7t51k+7HujrmshjEeGSiiCP2ZfBu8OCeZSwWSNxVqi/mwV5KoKNcn7GaaL9re+q0Oufj
         TSgRDy5P5smsXGJxGp0sXkw/2EJZtzaQ5ueBYXWtk05Qil3PHcDikFx3hcVple5UcX4/
         e+sQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSVreJzGu9L/A9pi7o+o52woFT+O/UZfsNtWAhzFcXr6DI5q25Y2V9McW3DgZjLl+fv2HG/gf7ld3fZ8s4YchRJq66yxDJavqZ4YJG
X-Gm-Message-State: AOJu0Yy05U6Lxo8bZUB0j1UrRm8CIBWNnlG7fDWUqS8N1t8CMoGsmLc+
	nN9MyHuwF3vAajnVYz62g5PyGPAs0eiJhALe7LeDfbazwwqExyAB24ZNixHXmoCgHwcwdLVgRk+
	G+HHrfA==
X-Google-Smtp-Source: AGHT+IGFgDixp9WXDzxYibbnkX86lHYmuK6aIdklTycmox1duQb6nKkn7YooMvJccyf7tOyLDItG2gadJy1J
X-Received: from tetrad.chi.corp.google.com ([2620:15c:2:a:aa92:584:c15e:b255])
 (user=jwylder job=sendgmr) by 2002:a05:690c:4a02:b0:61a:b2d4:a3fb with SMTP
 id 00721157ae682-62a08f9ddb9mr867237b3.8.1716498901490; Thu, 23 May 2024
 14:15:01 -0700 (PDT)
Date: Thu, 23 May 2024 16:14:36 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240523211437.2839942-1-jwylder@google.com>
Subject: [PATCH v2] regmap-i2c: Subtract reg size from max_write
From: Jim Wylder <jwylder@google.com>
To: Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jim Wylder <jwylder@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Currently, when an adapter defines a max_write_len quirk,
the data will be chunked into data sizes equal to the
max_write_len quirk value.  But the payload will be increased by
the size of the register address before transmission.  The
resulting value always ends up larger than the limit set
by the quirk.

Avoid this error by setting regmap's max_write to the quirk's
max_write_len minus the number of bytes for the register and
padding.  This allows the chunking to work correctly for this
limited case without impacting other use-cases.

Signed-off-by: Jim Wylder <jwylder@google.com>
---
 drivers/base/regmap/regmap-i2c.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap-i2c.c b/drivers/base/regmap/regmap-i2c.c
index 3ec611dc0c09..a905e955bbfc 100644
--- a/drivers/base/regmap/regmap-i2c.c
+++ b/drivers/base/regmap/regmap-i2c.c
@@ -350,7 +350,8 @@ static const struct regmap_bus *regmap_get_i2c_bus(struct i2c_client *i2c,
 
 		if (quirks->max_write_len &&
 		    (bus->max_raw_write == 0 || bus->max_raw_write > quirks->max_write_len))
-			max_write = quirks->max_write_len;
+			max_write = quirks->max_write_len -
+				(config->reg_bits + config->pad_bits) / BITS_PER_BYTE;
 
 		if (max_read || max_write) {
 			ret_bus = kmemdup(bus, sizeof(*bus), GFP_KERNEL);
-- 
2.45.1.288.g0e0cd299f1-goog


