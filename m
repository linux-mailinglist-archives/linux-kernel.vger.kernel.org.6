Return-Path: <linux-kernel+bounces-418204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB989D5E9E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 13:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75FCB1F22A00
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 12:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BBA1DDC39;
	Fri, 22 Nov 2024 12:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRIQIqAy"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0FC1B0F0C;
	Fri, 22 Nov 2024 12:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732277495; cv=none; b=Uwazl6u+z7jygzkDVIsx3GulY9JItps+YObHUcx4XeVvHLZw1nRHEQL5Iv7tTfzDUPcTP95MEthsIBV1w3Lybgo4KjxGVvkR/rgu1h/Bo+3E8PrO4ZC332Icw7cJEy6Dm2DDaFmzEONMdlZZXMqaEa5lZA8RKurmWgwZI2zO/g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732277495; c=relaxed/simple;
	bh=H6LU5NqN29Gru8BfOLQuBCel+Sikavthh/CeQJBzL3k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=leKn+zGjvX1B+JH3GJv878LsZtXdAKAPNwz01sJtQtcuZHjOJIBm70TDNMk2JFGnsmPu/xcFgpnscRxMcfTui5EF0y0NnpMLiwy9p5b92R62xvW8UHFttMHOVkrnTxnMlTQnbHy6tQqL+2zGKePvEL1lQxL2gS2o858r9jKb3Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QRIQIqAy; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3e5fef69f2eso1222703b6e.3;
        Fri, 22 Nov 2024 04:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732277493; x=1732882293; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H6LU5NqN29Gru8BfOLQuBCel+Sikavthh/CeQJBzL3k=;
        b=QRIQIqAynrIY7RcEyogmR4IXPgmoCNQVG6Iu5JvljUU8DjgCHoWe2nZoVO6g2n1IW7
         /BSyYoDVXDys53kLiZzjQl/PVzJHlndRUeKOEWwo/bKxyY0OFGLo80wssNQuB0F0B+54
         W9yW93FC0frisvo5B+hWookLyiHNQ+gIrOIpji9urYUCSfl8h8sSSb5ppqXp65v5imZc
         oQVKk2CBHAODKgS8j+pU9nom6abja8qluvNR+wvXmWxS6ho4jOoXAmfQ6a11xyQnMSNB
         gs6b5TzS2+H+Pb5t09Ucs7xNci/hL4sArsdf9IbT4ysfggHmJQcsngWOlO4IowQOhAGT
         D8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732277493; x=1732882293;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H6LU5NqN29Gru8BfOLQuBCel+Sikavthh/CeQJBzL3k=;
        b=QfV/0MWd0apV+I7ywIQYcds52JGRiuDAzOIGHrBC1hMLRszK6jh5IRuWzN6X16wYvX
         E4aXfl/SugvW2/W9YLg4oJNueJ8fcn/jgPJ5dlI2kgMRQFTXkpI+JIm7CkT3gsveW+JT
         LyiUSRkANpPZWKPpQSeF0pw64JcxyX2Rp2VGrg+SwzZVtO/X/JVbn0tpo9wZ8L4G0jxq
         3cnE8/56p80A63x/fgtUtVT1pBKWUxKY+D89Zl46dQbuuSOCu7YIF+eV8XmmoQpDAROM
         xn32NcLrtom/95gjIQa14jhzQ8YNUNFUrENTw0Gwzi9hw1SO7L03l4h28Ojtqskw7sCp
         jmPg==
X-Forwarded-Encrypted: i=1; AJvYcCWbopcnC8T83bXYQ76P+R+R4fIvOPQhXYXUlmxzwEiJgkAYMRo2g9qPvVKKeYVcT7PpS3J6w2g7tkfa@vger.kernel.org, AJvYcCXuXYElr2g9WkXqLdK13PRrPRb2TE/1Lc5/vHkRjJZOj0yMM9jjXbEc9bR3+GQwhC6BwEKRY12DV+yuWFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE6T/xO19LjMdJ6evnU38yaBNvgpppglG1u723kx7x3FtK0H8+
	XLPTyBZ+x8tMV7x2Z6/9VkoPwkREjMEtRETP07kDF3936ODbhou5BnwQXiXiiIyss1A1/SM7CBa
	c2biCcxNJeQ177WV3NXH7ze60u74=
X-Gm-Gg: ASbGncuFM8Lafo1F4E+DWkZ3cgE7ip/mOsyfh9GpvPl/Xejwz+0dLXjgbb61YWkhuEn
	LwOD9hK3/OuR+oJZbu5BjU1wHEp/qi+mY4puJJAFGtQOsZE5j1TcbfUloArQrfhkToA==
X-Google-Smtp-Source: AGHT+IFJc3Lm3/vC9HNNAcXFb5RTiNyyhjENLj8ZfekJebt0VK8JuV6U02HfpMPHalA9ZDx8HQpUF05xrqkmrWagIa8=
X-Received: by 2002:a05:6808:4495:b0:3e5:f172:3a3 with SMTP id
 5614622812f47-3e91582c81dmr3394831b6e.19.1732277493405; Fri, 22 Nov 2024
 04:11:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Adrian <thirphattt06@gmail.com>
Date: Fri, 22 Nov 2024 19:11:29 +0700
Message-ID: <CADoo-my4_ZUUUQkE4B1OG0EqYNrDwFUwhXbDhQ3oZamviVB05g@mail.gmail.com>
Subject: =?UTF-8?B?4Liq4Li04LiZ4LmA4LiK4Li34LmI4Litc21l?=
To: linux-kernel-owner@kernel.org, linux-kernel@archiver.kernel.org, 
	majordomo@vger.kernel.org, linux-kernel@vger.kernel.org, john.allen@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

4LiC4Lit4Lit4LiZ4Li44LiN4Liy4LiV4Lic4Li54LmJ4LiU4Li54LmA4LmA4Lil4LmA4LmA4Lil
4Liw4LmA4LiI4LmJ4Liy4LiC4Lit4LiH4LiB4Li04LiI4LiB4Liy4Lij4LiU4LmJ4Lin4Lii4LiE
4Lij4Lix4LiaDQrguILguK3guIfguJzguKHguIjguLDguYDguJvguYfguJnguIHguLLguKPguYDg
uKrguJnguK3guYDguIfguLTguJnguJfguLjguJnguYDguJ7guLfguYjguK3guYDguIjguYnguLLg
uILguK3guIfguJjguLjguKPguIHguLTguIgNCuC4l+C4teC5iOC4oeC4teC4geC4suC4o+C4iOC4
lOC4l+C4sOC5gOC4muC4teC4ouC4meC5g+C4meC4o+C4ueC4m+C5geC4muC4muC4muC4o+C4tOC4
qeC4seC4lw0K4Lir4LiI4LiBIOC5guC4o+C4h+C4h+C4suC4meC4reC4uOC4leC4quC4suC4q+C4
geC4o+C4o+C4oSDguJfguLHguYjguKfguJvguKPguLDguYDguJfguKgNCuC4lOC4reC4geC5gOC4
muC4teC5ieC4ouC4leC5iOC4syDguYDguKPguLTguYjguKHguJXguYnguJnguJfguLXguYggMS0x
LjUlDQrguKrguK3guJrguJbguLLguKHguJ/guKPguLXguJ7guJnguLHguIHguIfguLLguJnguKrg
uLjguKDguLLguJ4NCjA2MjY2OTc4NzkgKOC4nOC4ueC5ieC4iOC4seC4lOC4geC4suC4o+C4neC5
iOC4suC4ouC4geC4suC4o+C5gOC4h+C4tOC4mSkNCg==

