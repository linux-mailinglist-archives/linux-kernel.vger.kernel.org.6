Return-Path: <linux-kernel+bounces-339997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DE2986D17
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86A9C28818B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 06:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B305189539;
	Thu, 26 Sep 2024 06:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zr4Ex9sr"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CEA188CB0;
	Thu, 26 Sep 2024 06:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727333880; cv=none; b=eFAvhqhse+FPXVgFhrnZLYgGFXC7gdOq7+jtgfXybUKJ6W+yFpk4wLzFplw/ciSg8RV8lSMeaQjNU8ovb0opts7OLlJKQw2q70Qhg918jKZ7GYK/5lwiKf4JVWRr1NcK+VcTd7f7zOWcQRXOBfwjQfUk3vbmN06Nq4tRC+xkJC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727333880; c=relaxed/simple;
	bh=V6n9edNBDvqt48afSqkdgg/mg3IbpQAEQ6jOWHmeCPw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mk3+uLTOHS7ItxUfHvAiz6Vd3V/hjFP1V5p8SogwK+3yMbQjGTZVecByvqf4CijHpvHPCmLOl1/Mi59hRj/Mg5/5yzfdY2cbB4viyEqHtpI//bQU2jL1PJmj+iTi6zGL+cJISR4b0i4i1EBeoeZfG3g7y+DEZWlN0KJ8P+GJbJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zr4Ex9sr; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3e042f4636dso470372b6e.1;
        Wed, 25 Sep 2024 23:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727333878; x=1727938678; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PBWIbI7jE7sd+RW3Qy02QvuEF2BGI4JVfTAMtYHNXps=;
        b=Zr4Ex9srY2wXNL2L5O26qXODUOzGc8AbmC4Qjp8/JZWhqCqTVwBEAm0MUpuTiRZQq+
         lCnVcYej4ofi+j/JjlHUZ5ayIOsaoF8nXeSgwwDaamEEhnTuH2umJXMkTKR0qpnquUv2
         gkQ1S2RZG8mzggXM2KL46ol9SrmI9dzRE02T76+s015VV8nbW/hYNe/cqKuHNyMlWN/j
         0dr/DMKTPRzujR5k2jl87ozaa8xZrAB6TMx8lcxKjjm3xq8x5mVn9lVmaxg+FJyqKPC6
         wpZaKVuQbu9+4jtLNjKVJIvivlJbzjVxMZzhk44JsmSuRUYhURdwbMQwMqZiiEO+DOyH
         MZlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727333878; x=1727938678;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PBWIbI7jE7sd+RW3Qy02QvuEF2BGI4JVfTAMtYHNXps=;
        b=lwOfqZZhLlW00wwnJAA6hvPECCjd5h6IX2DmEsc6bXFPuA/PWpsq6Bp+P7yj65k5Tk
         vIleOAjN8YqUMeWJdU3gQ26L0/dsGixaMdbBJawYC5R7TBVmgzNZQopri4TJvCA+b7vS
         R5/H9vNxE9RsGiGuCJGguHuyaG6vDkzvYeuuvHIC3wfOCqFcSTwOHJngC7QfUIrFriaZ
         pU7oNCftySGy9+uBpPitb454asNC9YQnZIX92pmzH2cGKN9QJeuHj56lGjKer4keYr6U
         GcpKC8NpiCGI9IRd+50Y6CbH2UOYQiaMVODXsT/8Rh/xwRbWNsEG8xAq3ElBV43FJ+KX
         uHBA==
X-Forwarded-Encrypted: i=1; AJvYcCWorEE7oRTQYOAiGuLQtZIEzt5qLkDXf6ms5Ik6rM3xOlNLce2mPZZzLfihXZRbpG7YU5n8S1NlprK4uQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdrQMohIPtx4nTmzZQ5HvUW2F2CfpNbsxPB6QyvuR50DHZCks1
	nErpbfw4miSqvEc3CsWUG9emGmyRc/Q5QOSboI/EL59S3REk3Ib3
X-Google-Smtp-Source: AGHT+IHUD8wx+sxcJ3GTl+5YTHIAoc9Yh4cnphshWgvvC02107L7oyMgXpacGerBYUkuSjB90QmE9w==
X-Received: by 2002:a05:6808:1288:b0:3e0:3a72:e727 with SMTP id 5614622812f47-3e29b79e31emr4388513b6e.23.1727333877958;
        Wed, 25 Sep 2024 23:57:57 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6b7c51112sm3656709a12.42.2024.09.25.23.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 23:57:57 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH 0/2] ARM: dts: aspeed: catalina: dts update for EVT and DVT
 schematic
Date: Thu, 26 Sep 2024 14:55:30 +0800
Message-Id: <20240926-catalina-evt-dvt-system-modify-v1-0-84a27b47040b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGIF9WYC/x2NwQqDMBAFf0X23AWNjVR/pXhIzUu7UKNkgyjiv
 zf0MIe5zJykSAKloTopYROVJRZpbhVNHxffYPHFydTmXvem48ll95XoGFtmX9BDM2aeFy/h4Pb
 RvWBtg2B7KpE1Icj+HzzH6/oBNL+hXHAAAAA=
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Potin Lai <potin.lai@quantatw.com>, Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727333875; l=577;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=V6n9edNBDvqt48afSqkdgg/mg3IbpQAEQ6jOWHmeCPw=;
 b=S11o17rt46kL05FyZieVQiv8RzWkn69jQE6bA24o4Pt6gKfL8Z4362cySgTxvRrFE/XasqTH9
 uwnH3c0QY3/BKLdq5OCKYBmlyqum5IcKIJ+OVIT/U5pzbTcbGQTqBan
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Update Catalina devicetree based on EVT and DVT schematic changes.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
Potin Lai (2):
      ARM: dts: aspeed: catalina: move hdd board i2c mux bus to i2c5
      ARM: dts: aspeed: catalina: enable mac2

 .../dts/aspeed/aspeed-bmc-facebook-catalina.dts    | 172 +++++++++++----------
 1 file changed, 90 insertions(+), 82 deletions(-)
---
base-commit: e56a4f51601d8d874237557a359a3db0dc50b0a9
change-id: 20240926-catalina-evt-dvt-system-modify-386be551ef59

Best regards,
-- 
Potin Lai <potin.lai.pt@gmail.com>


