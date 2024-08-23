Return-Path: <linux-kernel+bounces-298320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 693C195C5B6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24A132853EF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 06:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1016D13634A;
	Fri, 23 Aug 2024 06:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qtn2tGBr"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD4E47A60;
	Fri, 23 Aug 2024 06:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724395412; cv=none; b=A0OEw23zxNH1gNeerC6ykENAMbEV+wQvi1JWTJt8Qq49oyKkIcDCK2feCMBzub2xGTM/cVAkZ1MW0qaPBfuCopSdE5/gINfEHY/2ixWXfDHMa3cNOkweVzZ4tyYvztnjo9FYyHErPwgbSwmxuZTUuHDR9+O9Y1YdpAfjl5R83Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724395412; c=relaxed/simple;
	bh=1sJ5+FOd+4XmIQMm4djzaZijr+Y+QcP7+2Ob1OpEWG8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hI1n8YbnVGNvSyl7ECwXj2lEKi7HM0DkrZLzp2vB7tLwD6EgAlqU1MqqM1WkZuUQJ/PpUZiFfRLPAzQ1DGLJNSRKRIe2YHP/cSjB6dR2byRAREUfklqoxnqm9YTEG0kNrLkIm+Sx1cPy2CcOzZtToSOq6ChlXRqturMOh7NQlW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qtn2tGBr; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-201fae21398so12699055ad.1;
        Thu, 22 Aug 2024 23:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724395409; x=1725000209; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0LIGiCqAT5XD49+SAqkLUK5mOjqO4w1JHNemNZLGIEM=;
        b=Qtn2tGBrF73eZlZ7NIGSZXpvYFTQA2EiVv97RErkd4DrIMyRmrCMKl/VWaJ6tc8t+a
         Kaje55C5hadTGG7nh9LlMJnGDvaAMfHC5upN4fCALZ5/bd23buDOGOL2wRUVC4iUbohJ
         6ISV1vg1gT7CyV/oxKzuNgNLqtpJwgvfXg4wHuTcM2rBtJL/V+1Mak6o7T5Jr1QxgEMD
         4oA7hiCB8yuBws5LZKb7DgBuu2whWsmiTSlzzB1RlPrYUGcwsMrDT80pZpha3LrEsnZ3
         h7P0scdQ0RAaEqgSCkGRRcwiH/GVqdSJUstF8e72yWmpWrE7zC9NgtdAVpVvmCfOb/U0
         Zu1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724395409; x=1725000209;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0LIGiCqAT5XD49+SAqkLUK5mOjqO4w1JHNemNZLGIEM=;
        b=MClnYYQdu3YzN18eRRcaqkEqgfTNyW8keOfA45eZX/BhxSE/1UnOnjYExY3rn8En56
         mgyCW72NTTzoJyXyIK2uE1IsZJR6JFe+3f9SmxUXC/mjP9yYdz7+x7K8nbIkV/B+LOFo
         cCZJ8HvvUXi33ZUEPtVerGi4sVqjznPgTVJuVXQ24izIumup0ThnmMjf6UXpUu+DhiFP
         GbDhYKimVYB+1EmEvziFtqpIBN0kW/b1jZ1NvjqLxow2iIOtQxA0MvqKlAxOFvic6262
         LSu6krhFadQYsmB5zR2Awks1wJVtoWejqfL/Wl6BuOr7Mt69vqb/5iFZ+HJNt6n/LTb7
         6R6w==
X-Forwarded-Encrypted: i=1; AJvYcCUj4Mr6HjEzvi+GYYjwpN9F6FT+YT5kqZ+UObq/tpqPE8VAhTkE2KcusnIKHiLCS5kpfKu1APSEboiyq9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkHk5g2XjlloYzrBu96uaJolUF4kWl5OZ+PlNm0Vuf5qqpRzOd
	6DPECLDxv5CzECXEggGDBsfth/t2RLc9iSxgGTCGzJW+5jum5LzqrZ993g==
X-Google-Smtp-Source: AGHT+IFtonOLbg2TSwnqYkGI74mkskP4aGUv7SwsG/OQ5GZrOBat4xRdE/gdHqCe0HJmkGAqBe7ESQ==
X-Received: by 2002:a17:902:e54e:b0:201:eb57:dfaa with SMTP id d9443c01a7336-2039e4d86d7mr14245815ad.17.1724395409209;
        Thu, 22 Aug 2024 23:43:29 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385565468sm22339945ad.11.2024.08.22.23.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 23:43:28 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH 0/2] ARM: dts: aspeed: catalina: update IOEXP nodes
Date: Fri, 23 Aug 2024 14:41:09 +0800
Message-Id: <20240823-catalina-ioexp-update-v1-0-4bfd8dad819c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAUvyGYC/x3MQQqAIBBA0avErBsojaiuEi2GHGsgTLRCkO6et
 HyL/zNEDsIRpipD4EeinK6grStYd3Ibo5hiUI3qmkFpXOmiQxyhnJw83t7Qxah7tqbvDNlhhNL
 6wFbS/52X9/0AEGK2F2cAAAA=
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Potin Lai <potin.lai.pt@gmail.com>, Potin Lai <potin.lai@quantatw.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724395406; l=571;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=1sJ5+FOd+4XmIQMm4djzaZijr+Y+QcP7+2Ob1OpEWG8=;
 b=M0rdWdkV3BFq7RD1ttVS27ZrTQGjfIoWy0GFg8FNGLL3loWhwKQv2B2eOD4sN5BftAfs+hYXt
 6XfWebX6T8CCufD+lECxPOyl7wxmK6rtcPxcFFv3f82c+waEaJe3MkC
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add new IOEXP nodes and revise the line names.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
Potin Lai (2):
      ARM: dts: aspeed: catalina: add pdb cpld io expander
      ARM: dts: aspeed: catalina: update io_expander7 & io_expander8 line name

 .../dts/aspeed/aspeed-bmc-facebook-catalina.dts    | 135 ++++++++++++++++++++-
 1 file changed, 133 insertions(+), 2 deletions(-)
---
base-commit: 471e7c75d0e5c2bf1d65e384b48f625a59ceed45
change-id: 20240823-catalina-ioexp-update-36efd64daf89

Best regards,
-- 
Potin Lai <potin.lai.pt@gmail.com>


