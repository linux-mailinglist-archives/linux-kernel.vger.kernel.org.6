Return-Path: <linux-kernel+bounces-259101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB32F939131
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 558521F21B61
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 15:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F5E16DC35;
	Mon, 22 Jul 2024 15:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VU0gC2av"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31C416D4CB;
	Mon, 22 Jul 2024 15:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721660473; cv=none; b=J2TnsCZOMcIB0ObCNDMKOUxEeVeqNL9nYHeS7hIPS2Sg6j/JDQk1+W+lBCAPeahqZukGQAXIP8sFPhPSNNl3NmUdjkrIxkRbSWt/fWZrAUEtAXqVdN9j7gKLNWpSoMaKYiF2REU7Nzgtxqa8pUd+Inog2yF9UCusxYqUMQqdT3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721660473; c=relaxed/simple;
	bh=tOTSEb+zxooFTv0SqVni8o6tNy6k03qvSLo2G9OoC28=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Jw+eebtWhYcCTLWlW1Ofs0TBK2luAusbVIAsS/11Wq0jH5K77LOpye5OuoYZxTCHJSOTBUCygq5emzWPKUB04y4+X8oqNxUmFe6X3n72OtwxaVgjmW75HGkDzKcGNmQqZfHZLUYpRP10ft9aHDlOgZIvEfEZC5HBBgB1kRZCfZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VU0gC2av; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2cb63ceff6dso2288531a91.1;
        Mon, 22 Jul 2024 08:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721660471; x=1722265271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LifFp8za0/fDe/DMyUuD2kVYz+L5AS9snMHlQAxSzgg=;
        b=VU0gC2avwzF1K+BP2CsPS8qTOZxUFueJadRaZkXaBw2XNxbPL78l553Zh7cpVBJ8ow
         tbFFcJF5zrsK60hfHgoKm3Ra9Po6g1WzRRjgWwqI5+qTwuz8gwVUaa9ptYJhxKwltsMe
         XrhgTlJdKHhyb0F1CFSBGpLCUpOfjlmXK6kYA9q+MmFkKfBj1h96waCGteqEtu+c6bfC
         1HXE+9f+CNTqxfEsnxIwB3XYquWVB4fA9KZhW1xhxtF5DaIP8LyyAnXvSVDpV7idGp6Q
         08LIdUyvabh6xVL1SWtHmlA95wJmFjZ8nidILcoXTlj9Zv8KTkUrZ+KFEQ6QepondoJO
         zxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721660471; x=1722265271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LifFp8za0/fDe/DMyUuD2kVYz+L5AS9snMHlQAxSzgg=;
        b=grdgv3E1mjqvyNN4K3U9cJtx9D66czAB57voeFLRSDGvKBrmQBBzXc3myebI9fJuB+
         NtAdUmA0yxUd/pnrb472iXd8tMsT9ACPhpNvlpt8Jmyb1kOd/9ho75byTyu0uoPoZu1W
         Xz8QcxE4hwKkEJzkNaNzP9+WmXkKt7OGl0cU3Qz8VgZfYavByxOz772Ej1SP8qLwSSMH
         PwM296h6s3cFrLEDqM1UW23CIBTOZ2kxClr/8KbaNQjlIDSPLltBL66UZF0ikuXbcea+
         5ZO6C15YoLANAxWNsDoeaG+kH316xb2jK1LfB1PjOtaZTFAUqZ7/Wkfmw0Q6fe/5rlsG
         aWNg==
X-Forwarded-Encrypted: i=1; AJvYcCUxdD1aGxsHhiBb8rkH4b70XOF/5lh2SznV6apHaP+9xn39P54WK1rk4f3klQ2nm5lugN4ouoSmCyid7ABTAswc2Fs5WzHosZGHIdJhYGohyLPgzE3mtzzqGz0heS10hgSmEQhK9mRzqA==
X-Gm-Message-State: AOJu0Ywu+/sPIlrgkqjq4TXobS2fq97ZGpKWjZPjmbZ6lEosXKlppMOL
	LWCBV+nDKETd8DCOVqEkJidGPcvk8t4ehQFTWwAVrYtekIKi2pwe
X-Google-Smtp-Source: AGHT+IHp0kMpE5js4nkQXc2GMSlg1Q0sPAxE54CT3VyYZOAoOxlisjAmUKLKIXkE8VYoyJ2O+rqSkA==
X-Received: by 2002:a17:90b:3d0:b0:2c9:5a87:f17c with SMTP id 98e67ed59e1d1-2cd2740f285mr3469822a91.15.1721660470911;
        Mon, 22 Jul 2024 08:01:10 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cb77304a15sm8224207a91.19.2024.07.22.08.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 08:01:10 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Patrick Williams <patrick@stwcx.xyz>
Cc: Potin Lai <potin.lai@quantatw.com>,
	Cosmo Chou <cosmo.chou@quantatw.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH 0/2] Add Meta(Facebook) Catalina BMC(AST2600)
Date: Mon, 22 Jul 2024 22:58:55 +0800
Message-Id: <20240722145857.2131100-1-potin.lai.pt@gmail.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Linux device tree entry related to Meta(Facebook) Catalina specific
devices connected to BMC(AST2600) SoC.

Potin Lai (2):
  dt-bindings: arm: aspeed: add Meta Catalina board
  ARM: dts: aspeed: catalina: add Meta Catalina BMC

 .../bindings/arm/aspeed/aspeed.yaml           |    1 +
 arch/arm/boot/dts/aspeed/Makefile             |    1 +
 .../aspeed/aspeed-bmc-facebook-catalina.dts   | 1032 +++++++++++++++++
 3 files changed, 1034 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts

-- 
2.31.1


