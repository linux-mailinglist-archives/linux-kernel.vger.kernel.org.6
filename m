Return-Path: <linux-kernel+bounces-308418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 739D1965CB4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31CE32879D4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 09:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015FA17B41F;
	Fri, 30 Aug 2024 09:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpRLGGxY"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796B1171E7C;
	Fri, 30 Aug 2024 09:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725009835; cv=none; b=EYw5pXl3EeN2RZIPYjsT+k/1PuzkHTgJjqjOzN/nDq89D2qFlQDr5ujvOWKB2HsrGTh4yorjfiL1XqN+F804fTNUV4Uey3JSfkcP0A5SiNdfbEp294Av+2bI7OiG9IJsxLSNDbjuREQDjJ0Y/Uhh7tDcD8rrCkSPihCb9V2s8BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725009835; c=relaxed/simple;
	bh=c2W6vnyUdu7zkuGlU5LqN4S/BPf5vHucXE8e79ocG9o=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=QMakrgTFEhY3Z1YnRl7hmZTJtJVecGK0HV9Ef9I41l8HVel3KU9vmx/J1b+wXtxv0Kq36SEa2whRGlZeXo+uzh6ERsEmYVDiIibEl7Z+NAnJr4MJmNGWDIRiIw+FtRsC+8WgiXIpHTEpOAEPdJvgY4VL9gm6PKMFtitnYYr3NVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NpRLGGxY; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-39d4a4e4931so6303365ab.2;
        Fri, 30 Aug 2024 02:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725009832; x=1725614632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xZDAutDjqhZj7c0NNMu29YVXiCz0AlDollbWjsVJAnI=;
        b=NpRLGGxYVjJbwtpyDlCTOAvlDfWsRhw7Yz2d0SmPXmmY+ouSxe9jTPrqVwiQ1y5adx
         9/yVO/Ub5xS8MCBLOJUAhqOy8PAtf3z85xPMWTQfe5HVsar4GxGPXo3TiAfBvhdBQvjb
         K7hy7yBktMLpGRqqNZ/GDghhwafZkDg6nNR3cxmRet8M4L5LzRDs9ey3vq9EclUw1S/3
         yNTNCf8+Ahxs+nVNGLeg/MmVKlaLFiKdJdbmbOYzZRDDLIY4dhmsFjiKzC/2YPvuRKLH
         P7wr57bvBzVN3IcMsiBsl9mHD0A82UEm+0wmr4JuKi6cXMmxgvbQ9oSh6QhAqgaBUToO
         fzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725009832; x=1725614632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xZDAutDjqhZj7c0NNMu29YVXiCz0AlDollbWjsVJAnI=;
        b=ebAQDalX6dmFUg+9fcfHhNVcT/cL3eV8b+PvusyuKizMSbIq3yjjqLPS2W7K7TLhUi
         UFSQ49IOctoqZDo/0k9sZfSA0otO57v1YvKTKtgSNqe9FMnUjiYxrlE31l+N08O2g2ww
         w4lB/wfoCqvf2lVyrDxAiqcqKBsAGtl/8C+gIPm2+VzxgM8wlF4hIAOpcMFaD/exl5Hu
         T7O1jrutvzLWVlx3bvU+wEBESM/qDT8k/UIMU/TZx+1iqDOwWK95jfUKY6AiR64hWdjT
         7YTjehEkl9FPs0bJqoSMvd5uneTTXt7SqKaYZozUVtq6PqARVZ6CztAAzKU3iv76lC2K
         B60g==
X-Forwarded-Encrypted: i=1; AJvYcCUV5fkbHiZEDizc1DVGf12oDXcTbAbFdnbCvyXtpw7hwi3+i07g24I72CGH71YHsQ7bpulYtVcJbaMZ@vger.kernel.org, AJvYcCUvMiCuyJ+oaho+fquDtP/0Apln74IXh63Al93UeTMMt8UvhpjU/pEebaJ5w99/kd8DYUkSLp7SCKBSyNHb@vger.kernel.org
X-Gm-Message-State: AOJu0YxJmDfsH+PrKBZFXuP74qeMOM2RJYDHj5ELi51kRuyyyVxSZUPT
	fR52id7ViOUOeIhZQU6lkRsARb1cIaBq7lyjGBXQcSP9EIvC6u5Q
X-Google-Smtp-Source: AGHT+IEvRI+J7ec9MMAI8J4MgnZzteIzgy1idxmJxN6SpADJY9EojNwl6YKOP/9WF3/rXLkY3wx23g==
X-Received: by 2002:a05:6e02:1988:b0:39d:2e35:4d88 with SMTP id e9e14a558f8ab-39f379e6c36mr56657545ab.28.1725009832349;
        Fri, 30 Aug 2024 02:23:52 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e66d8f4sm2566744a12.0.2024.08.30.02.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 02:23:52 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Revise Meta(Facebook) Harma BMC(AST2600)
Date: Fri, 30 Aug 2024 17:21:45 +0800
Message-Id: <20240830092148.1574520-1-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Summary:
Revise linux device tree entry related to Meta(Facebook) Harma
specific devices connected to BMC(AST2600) SoC.

Base on: https://lore.kernel.org/all/799dbd97b09693fba6f837e73d4ef3421d604a8a.camel@codeconstruct.com.au/

v1->v2
  - Fixed the mail and author.
  - Revise presence-cmm to sgpio.

v1
  - Patch 0001 - add rtc device
  - Patch 0002 - update sgpio line name


Peter Yin (2):
  ARM: dts: aspeed: Harma: add rtc device
  ARM: dts: aspeed: Harma: update sgpio line name

 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 41 +++++++++----------
 1 file changed, 19 insertions(+), 22 deletions(-)

-- 
2.25.1


