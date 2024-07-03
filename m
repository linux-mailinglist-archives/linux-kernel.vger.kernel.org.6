Return-Path: <linux-kernel+bounces-239174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E599925786
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 11:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06BD11F26D97
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 09:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1141411F9;
	Wed,  3 Jul 2024 09:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="2wn6T3Ja"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4341411E1
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 09:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720000615; cv=none; b=dEVuUgevAk8/ZNIVQFVEZ1+yKKl8VYRS8N8YEnsjJLL0mA0uDkJe2VShswpBVpy025Fx1B1zCeGod+aPmS+nsovZwua1ZYl5ePDTAHyQ76A8zug1BeP7oDFraFbrBvJAqflIwNI6wCerbP63FKo5wXnzMgrb+ngY8LVvbZ4UTVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720000615; c=relaxed/simple;
	bh=VRqNg8ZwdNFYMwEZZ15y9oaDxErqj4bO5XutmPE7nnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lujmNmP5HJyskC4Wm9eUpk2GFX46tut35X8h56vVfgjpxkiPh3k3bQLcwZXjN6QLDKW7+g/DRZUtxqiL33PtyTmQOjGJecb8yAGu2DuxirsARYARNN2hGN3sfOkyD4c1xfUqFhXbcjq3miOs24BuRntQkYe9WFAeegpoEz2PdBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=2wn6T3Ja; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ec3f875e68so57793801fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 02:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720000611; x=1720605411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=644p2OqNe2TyfiDk6OFRaYAmlAu9C2CNKeyr0ia2jQo=;
        b=2wn6T3JaeNHqvOS7BSJ17fgtERPLe2qH3ikYGO/YZscDHq9BF0FgfJsKowczXQ4TaT
         yAdLmllo2q2IpLFoW5BrHw2+OA6YHfRlBXny2ZjBkS60VfXNwMxOg2Fh8m5VEPM3iubW
         KdcNkbn27ATiwXTSwOPCE5K8gAPgCtYQ7YamQzxNF4sjE1BCwIFZJfL3iaiT8bpxVhhZ
         kZRbm3BT8iS/RHGZAnYqrjLy7giMHi0cbwCq+ZFoSlWVZjPFD0pnvM8Hk8tbE4XzRdXo
         nXkDazg3t8RckakT4JXtWAjFIb9Z9i2Ndmo6lk7sjK+LAxRhcI21xoli9DFKZYLzScs0
         HLvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720000611; x=1720605411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=644p2OqNe2TyfiDk6OFRaYAmlAu9C2CNKeyr0ia2jQo=;
        b=p0t+0DarK6Zv1lovjiNq4n2qkPO1MGMGSW36qvBDR0T4hmKh5B52xCIs0qjzbmmyqZ
         TVhsOkod0VYb2lleGZuCrukfmSQfGVcqKoypD+bh/Q8/uMg6hHN0bCQHjuXgc2+H29yP
         Qi1UVIB+oRnsP1eKCkrqXliM28Sx/ClS33Yqj7JP5iOPRYMEWYYIWrv/ImiUoF1oVztP
         TMY+yt7U0aYfa2mxtybO8HMkDa7KD6SGKCvpa82uFDmKJYYGVDJtgFzohp5Kj1MQFUNZ
         SCRjyrfAAreGPFPpue2bcIWdhXnNsqjgGhuturpKgbL0pQo5ny6j34xhZbcWHaZVDDZz
         JQDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZaHOrEPMs4hmpIf5gtnahl/g4q8cdUbzL4K15QaiofJ8F04M7eK50s1feEV2RwqYGjFKp34qnujqx2NL8798c1qRgymAA0/Bf1j1p
X-Gm-Message-State: AOJu0YxT6IaXrZ8NFnnENfRr8Np/fvnVaRAx0ii/PqaWNctbcnytW4hP
	OaeM/aWoYUAyRCRLnzxBthvhf7J7jJWCva/XQmQ0fU4mptNqWyCAN4pHilxGYdzLKwCJqC47HCG
	Z
X-Google-Smtp-Source: AGHT+IG0w3E0EYqPeaL1EPJl8rWjAk6xvFAdS0J0CS6iElVHC8biwZiYbyTZBy9yDP3+x2rBjsmnzQ==
X-Received: by 2002:a05:651c:150d:b0:2ee:8698:10ed with SMTP id 38308e7fff4ca-2ee86981404mr8101741fa.49.1720000609610;
        Wed, 03 Jul 2024 02:56:49 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:c37f:195e:538f:bf06])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b0c1018sm231190095e9.40.2024.07.03.02.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 02:56:49 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: brgl@bgdev.pl,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	Andrei Simion <andrei.simion@microchip.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 0/3] Read MAC address through NVMEM for sama7g5ek
Date: Wed,  3 Jul 2024 11:56:47 +0200
Message-ID: <172000059532.11489.8300421582989880074.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240703084704.197697-1-andrei.simion@microchip.com>
References: <20240703084704.197697-1-andrei.simion@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Wed, 03 Jul 2024 11:47:01 +0300, Andrei Simion wrote:
> Our main boot sequence :
> (1) ROM BOOT -> AT91Bootstrap -> U-Boot -> Linux Kernel.
> U-Boot is the stage where we set up the MAC address.
> Also we can skip U-Boot and use the following boot sequence :
> (2) ROM BOOT -> AT91Boostrap -> Linux Kernel.
> Add EEPROMs and nvmem-layout to describe eui48 MAC address region
> to be used for case (2).
> 
> [...]

Applied, thanks!

[1/3] eeprom: at24: Add support for Microchip 24AA025E48/24AA025E64 EEPROMs
      commit: b61ea8705095e5d242762268cfebf48c848315f6
[3/3] dt-bindings: eeprom: at24: Add Microchip 24AA025E48/24AA025E64
      commit: c1ec80e54afd0460d02b29a5731fd2a7b31f400b

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

