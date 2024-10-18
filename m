Return-Path: <linux-kernel+bounces-372222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 810FC9A45CF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 20:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B107C1C24EF1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 18:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B2120CCD7;
	Fri, 18 Oct 2024 18:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OBafmOnS"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4F9204931
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 18:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729275775; cv=none; b=QsmFqnr2suxKc2TZSHFXbsEKFiqKnHAAKD8UoZn8hR8Y9JbwyiA8+X73nAXyIU1YIhq/PooSreJYHTvvthYKnNS8tcyhHp0/Shdy6elRK6pHPCUnsahzjm2ljRy/oI8nq2weC/OwkV7GKdP5+oDb1ApC/vEkrFHUjk9+NPTvfqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729275775; c=relaxed/simple;
	bh=YPE2wfgFUpfGjCt7I7YEVirC1JDFDUT1zUe9c6pGcAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f5O9UX09cY8M9jLSSbVVvyYDgC0smaq/AfxdseXIN1VgRJm8S5gdjcfMNGlCPsrKH98gPgMPXrNfQ+1l+Bp6dd0zfv9QzDbnJsZapt6skiBzywr5X+uSSSroPsuO3CI59h7im4B3L7FDiTwdQlGDKSxiV7GigpMYTkUCiTkiunY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OBafmOnS; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b1467af9dbso163120585a.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 11:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1729275772; x=1729880572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QoeLr+Env9OxeJz6wgxQ3SDKr6mSRXZtgxBKlhvoc7U=;
        b=OBafmOnS/6vCZwnDJ7rIbRgB33qnP0gg081Mr/jH6SNDvwfvMY+DC4asd6nBk3HfEZ
         mJL/WGoJLn7ujKqgzzfJxlm1XDsF+w+kwIklN0XHERx1L+xpHGgJ56GRygbuZrFcIlUL
         7xEY/3sg+Q0fVYUjOu26CM2vZVL0nBXqoDTGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729275772; x=1729880572;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QoeLr+Env9OxeJz6wgxQ3SDKr6mSRXZtgxBKlhvoc7U=;
        b=r5/otrNFeR/VY8DLdkYnZaZR4FmcsQxU77aGtY+XK4iWjIyDU5jtVjSYGhPV2XU2HE
         tg3zRJ5ZurV0xPu3T9lg5TNWx/0YT1DHC4xpUIAGBLlOs6o+ao+esISqnt4Gb4BHZnFv
         +03/rwoUu5HL9BMGoN8M7pzj/G2ICjq1llO6KR8zlrtMKiF47T96sUKwgQ5yv/rw4ypA
         wHgdCX9DROnJrwpTtItMhBQvkiXmRzvvwTd/r1aVjbVRAcZYWddCxYBJ/ZM8dDd4Enas
         ZQiqDdsgjajFW0iSF6/Hi1sjpfTALtPMuMjYZ38Y/SSa/H3ICOLmpwnkX4kmexBo2Lhb
         GY1w==
X-Forwarded-Encrypted: i=1; AJvYcCVW1Z4a1gDiQodR2XIUoOpEVowrIn8Wv5MEIWomwA7Fhq+0UzurMOA9Qwyk3Zsum7qENPfQ2GVhlpPxewA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvm4chd2n7ToezRQEo4Cyis86j3skSQAtITQVRpxHMRz23geEX
	LN+ezAv6+tPR29C9sFM2TSCBsnLk6dSuOnBAVi+1OibDFgfY0lH+HkB+jc4k3g==
X-Google-Smtp-Source: AGHT+IHc/HKas0ASDn+E7LNSiE4UY9i52NAvrSum+6BgLJ0cc3r86rr1PHaN99ZIt0zPccg2V59prQ==
X-Received: by 2002:a05:6214:4984:b0:6cb:d583:3765 with SMTP id 6a1803df08f44-6cde14c2817mr34582426d6.1.1729275770517;
        Fri, 18 Oct 2024 11:22:50 -0700 (PDT)
Received: from stbsrv-and-02.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cde114d782sm9307616d6.46.2024.10.18.11.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 11:22:49 -0700 (PDT)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	bcm-kernel-feedback-list@broadcom.com,
	jim2101024@gmail.com,
	james.quinlan@broadcom.com
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list),
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE)
Subject: [PATCH 0/1] RFC: Need feedback on PCI dt binding property
Date: Fri, 18 Oct 2024 14:22:44 -0400
Message-ID: <20241018182247.41130-1-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We'd like to get early feedback on a dt binding property.  We cannot
submit the code with it as there is a backlog of commits that must
be submitted first.  We are just looking for some initial comments.

Jim Quinlan (1):
  RFC: dt bindings: Add property "brcm,gen3-eq-presets"

 .../devicetree/bindings/pci/brcm,stb-pcie.yaml       | 12 ++++++++++++
 1 file changed, 12 insertions(+)

-- 
2.43.0


