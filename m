Return-Path: <linux-kernel+bounces-383716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C469B1F75
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 18:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49ADD1C208B2
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 17:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081871714A4;
	Sun, 27 Oct 2024 17:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTs+46ne"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3684C83;
	Sun, 27 Oct 2024 17:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730051321; cv=none; b=pilehPF+2/tOT0LKEftA7jO6ebrEbpqsXh6V5jmgYSXQqtqa1BHq+h9y2rDMnzxQxqKbALELdq5GL5UdrVoWUShgwK1H8NRS8t0Ric4OwFHSqRoBvcRLS8JDSr3XQdUAozYTaB4RexcmSIQf/H2/mQL0V9izQEmlQra4PQjODYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730051321; c=relaxed/simple;
	bh=0vUHzi67pMzq1RGaGQjqttjoI06vRvun+pQ7lZ+m81Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DolcNjFQYt5FZ9m9deooz8EzxpG9yvn6Jhw+isa2xNHSBitH62fR3mWQymsMc6N9mmAPxro4uL/yzD4GfYj2ydQcfjnfgSF7etPgZ0PHH22Q2IkRJPALHe/va1NoFPWqEGlKkWtkTNSS4F2RRgilOd0xMNH73geN/xqMFdcJnII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YTs+46ne; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e2cc469c62so2534610a91.2;
        Sun, 27 Oct 2024 10:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730051319; x=1730656119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fW7cYVNATA0lggd3viDmK/yYwUGBKvU/eStDk3KNt3Y=;
        b=YTs+46neSL09qHdUfA4Rt/hn7ze9+yIRbDrhjgPGdGUE4wCx4U8nQu8vtOiBF677PK
         aBE3kSMN7FKwljAHd0IHlWcKDRIvC2J/SnIJmIS+yV+RIN/QMTk6U2yQJf2WaCxKb2mS
         L+92RbvM9T6qNBxP+9KuYnTIDkooCNSWYCCb0nJ3GnHXJLpdXViWtK9MPt7L9Q8GHdwy
         fNfSnLiPZt6Lt3ezT/nQT+fPnuk8QK2l9iObXMZ1xic0P3NeXqQc57EMCohtDc8Qwwf6
         X73goeuCxjgWc6Lv9FwAvJKjv2kBNdqSEYT2OYemnFceKtBxrP+Yt1NrTH9USG/tM6oY
         LliA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730051319; x=1730656119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fW7cYVNATA0lggd3viDmK/yYwUGBKvU/eStDk3KNt3Y=;
        b=EjtVp6mAwi2PyGs7Iqx/bWStU9wxDMexzaV/KZ6SOa8Ordx9D6U6X4a5qhm6IpCrxO
         ZEG1Rnr8L4M6gxHgIAIXBn25Tg2aUc5T5r0/OVnuviXZHW8f4qB2g8sn5NY37zHDxn+x
         mHdkVfdM0udWHNUt2d73IxSZg1iwomlSeoVMGKyT7P6fGRPoBJl8f7sT0Vm1nmf3JLkG
         0rs5RGYvlMTNTebpgLPIcBH04I/Ny/sdY17aTKJiJLyepXiFQv2Ttnuure1KzohlDQBT
         9YImh6lGt7Vs85zq48Ri/oAQIk/kB9XN2u+D5JiRs05EQrqcQXWdwHofZZZmAAloypmG
         MKMw==
X-Forwarded-Encrypted: i=1; AJvYcCUogD2H1BT2/giXn05r8yi9TYX8v4Pc9/l1DBdzXe9vIPF1eIV1qz3KOcHTkhE78s0TnhZ/102b4VWQNg==@vger.kernel.org, AJvYcCWEZc0nitx0w+QGLixQE8D4gBzYrL8VP0n1X3n+TKJhV8dN9Vnax6+hkdj4SjsOb9xaEyuIz7RRpHCS4KY7@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/fHdhsnBxU7JI2qxCYAyAqypsZ6e0DG7DwkGUuBSFiLk7CuNG
	vGZNRTEbpssWoXfh8erXVTq1j72UjX+dWYVwxt4RnsuotGEp5ccL
X-Google-Smtp-Source: AGHT+IG7B+tHpeFxE3xZho5H08dMcpxyv6wmeiyetl8XMdItUQ43e7sRvJB0hxPiiRQlttWz7cYwcA==
X-Received: by 2002:a17:90a:3985:b0:2e2:991c:d7a6 with SMTP id 98e67ed59e1d1-2e8f1073411mr7098926a91.19.1730051318889;
        Sun, 27 Oct 2024 10:48:38 -0700 (PDT)
Received: from localhost.localdomain (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc867a2ffsm4251913a12.28.2024.10.27.10.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 10:48:38 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Cryolita PukNgae <cryolitia@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC] hwmon: pwm_enable clarification
Date: Sun, 27 Oct 2024 10:48:14 -0700
Message-ID: <20241027174836.8588-1-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings all,

I am working with Cryolita to fix up the GPD driver she submitted recently:
https://lore.kernel.org/all/20240718-gpd_fan-v4-0-116e5431a9fe@gmail.com/

We are currently having a discussion about the meaning of this part of the
documentation and are seeking some guidance from upstream.

> pwm[1-*]_enable
>     	Fan speed control method:
>     	0: no fan speed control (i.e. fan at full speed)
>     	1: manual fan speed control enabled (using pwm[1-*])
>     	2+: automatic fan speed control enabled
>     	Check individual chip documentation files for automatic mode
>     	details.
>     	RW

In oxp-sensors we took 0 to mean "no kernel control" so a setting of 0 is
technically "automatic" but fully controlled by the hardware with no
interaction from the driver. In her original driver draft she had taken this
literally to have the driver set the fan speed to 100% on this setting rather
then give back control to the hardware. My question is simply what is the
correct interpretation here? Ideally I would like to see this interface match
as existing userspace software is expecting 0 as hardware controlled and 1 as
manually controlled, but we also want to ensure this is correct before we
submit a v5.

Thank you for your time,
Derek

