Return-Path: <linux-kernel+bounces-264214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0D593E042
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 19:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE37A1F21450
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 17:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827EE1822F8;
	Sat, 27 Jul 2024 17:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efExj+rw"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500FF3C0C;
	Sat, 27 Jul 2024 17:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722099817; cv=none; b=O8yi29pF3NEqVmBcp+2qLXDmQ+b4QoLovDmIDKdIHChf0HI1vL6538yhjPWeCmRI9VXHMowTUP/q4Fyqxe6FfwY7jQE9deDdV3L/DJoWb+eONcMwvo0cRELp/6Psx8V8t+nHq4101YXN8U3rpS5D2WruEdtKGkxWtY4fIrV0kO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722099817; c=relaxed/simple;
	bh=5amuWvR+JRsoakIAMRzQ/bFcfKLN7HDNXrIOS0b/VKg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hcaz2JbKnFDR7vx2j8cAVtnfJWAfbqMGdLESjrajbouYw5Dh7NjqqJKMFCrPMyhtDFyEKuAs5M6J68UNRPBoTu2+xFsyMEWdHNW7Cb5BicthOIKo2pyvwjMsYAO3W074PeT9mQqCecAKjyfaJ8zyePIh7ji4BieGouETFVUzJa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efExj+rw; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7a8caef11fso279029366b.0;
        Sat, 27 Jul 2024 10:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722099815; x=1722704615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cxWfuDJYIcOc0xSEiPM94xX8fCUhasmVEIzBW9vhx30=;
        b=efExj+rwtmFxeqJrRCIRgRn84BG4ch9GzZSatg0TOmRekuFSNII+DZ0olOe9l7XxNM
         z4O1mM6eKaiumgDIoMfiJrUqC7pITXQmuSVUzZLrx8gTjM6GR3PXxhO5f5eQ02UQPBFO
         yb5QLnbOZuJJTMIPmq4KxqnFVrpjN6ITtxE20YBJoX1rEqVNIbQuo8ikOU9DdNl/h3hl
         bcCEkXnS0pcINjqKOPTfg5FbgWahx+DHaomD73IlRgHVsxeTvrKi50s5vOMNmLM4cnZx
         DEo8WH5zpgVgkOTPaKQB2V9Ak4+ItpQJg9RbYiqEhCK8X36XKBx6D/agrRXqshWlFTN3
         KHFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722099815; x=1722704615;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cxWfuDJYIcOc0xSEiPM94xX8fCUhasmVEIzBW9vhx30=;
        b=c+7yFbvyi/8FgndKn+PnLfnfrv3MorNdD8kjMqqJmCejIp8yElmIi3ORiNVRUKQiwK
         9LngB3i9qmQJMMucSZAJK4xIECCnhBTV/nC7vsEB//9HiU+Dq2uZnnNVWc79MgYZBgHJ
         5A9kuEBPS/vi5F8MyESTli1TYu0U9v95CgHdadH1UG57XQBl9APmFHenLvXsjTwYTRxz
         rPZGRNdMeHQaIfP5URRRWffAhf2sf8YL9jZycyn33aXRxZAd8F9GipH0iiVhNMBWAqXl
         7Jy/7OxB1WXR3ZEV09UrMuf49/DiISUxXmNpB4P8tIYHLzXjGeEHIL3GovOpgIY9ZtIY
         2w2w==
X-Forwarded-Encrypted: i=1; AJvYcCWXKSQFdjRDp57MGM1/gzxjfFpmIePxIiNnkRDW791HudNjSQ+0VdHz5/leD9XLzF/8Z7urp6Jm8KsKLXUtbrZ3xfSUTh7I29QH5y3DWGEImASClPJqeweg+tsoNryXvwJRg/Hoa8tgBaI=
X-Gm-Message-State: AOJu0YySAXMDi2zcjcbpP6MjvUhiX6+Bmu5TmO5IsRBsZjvZxqu+UoNN
	Jvz9Pj5lOu5upTClG84L2xgkvi6Rgz+ufGp5aIS1j6mjbQfZE96v
X-Google-Smtp-Source: AGHT+IHpL/dOQ1bFe+f6JrHz44fW3ywuod+9Il1RETc9MsNNgrgn1Xdxwkmskz3A/HkGBEoQwLidxQ==
X-Received: by 2002:a17:907:d17:b0:a7a:bae8:f2a1 with SMTP id a640c23a62f3a-a7d40150b4dmr219076766b.42.1722099814375;
        Sat, 27 Jul 2024 10:03:34 -0700 (PDT)
Received: from caracal.museclub.art (p200300cf9f1ec5003008007610402bf2.dip0.t-ipconnect.de. [2003:cf:9f1e:c500:3008:76:1040:2bf2])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a7acadb82e7sm296666066b.208.2024.07.27.10.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 10:03:33 -0700 (PDT)
From: Eugene Shalygin <eugene.shalygin@gmail.com>
To: eugene.shalygin@gmail.com
Cc: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] asus-ec-sensors: remove VRM temp X570-E GAMING
Date: Sat, 27 Jul 2024 19:00:34 +0200
Message-ID: <20240727170324.8867-1-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no VRM temperature sensor in these motherboards.

RobotRoss (1):
  hwmon: (asus-ec-sensors) remove VRM temp X570-E GAMING

 drivers/hwmon/asus-ec-sensors.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.45.2


