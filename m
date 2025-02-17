Return-Path: <linux-kernel+bounces-517542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 714DCA38231
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 12:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1F083B3E49
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B965B21A426;
	Mon, 17 Feb 2025 11:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="OPIR4ns4"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F0C217658
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 11:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739792720; cv=none; b=JqPQ4zJrGHksTStl1ppCvBTzVFjs440QkeJj6J+MfWx63OnHy6t5PO9VJp6pcn0moRuY1htYlKNqxBSEHwbaVmaUK9OeWlHm/n8uC64M1GAaECxWH8M0AyzpR9hphw3cuVJcOGVnytBzSF0y4ejWRZNX6JYbS49LpyLZ72ryFdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739792720; c=relaxed/simple;
	bh=LJzyYC27+HOlViAPyDrmNg+XNfhv7OAIpEW0t4wLg7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hu9b7SDwLx5oaXjh0IxsQjR62WFvpvH8V7mGVZ5K67f851MAbjC9kFrth0mOiX4l+ba60e8BQd3Q1qyevkdTXDfXECFtHZjMSqBrwAG2TyuoglxNAbnhRW69UAq46Z5UviyGAhVnH7AO9FT/DAB1EHTUywWhM5f7LwF5Rzg/sMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=OPIR4ns4; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38f488f3161so292850f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 03:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1739792717; x=1740397517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gslSeLU065wOuo/exeqAIaqsKgFJISNX/u1ft+G91Cc=;
        b=OPIR4ns4eFhm5u+AqWjyQ2Ew1OdbYk+Kw5fcmBiGDx2Jm65SR5bSLGArH1t/mmU4/8
         NJXrElDgBw8GEuaYCElkweYR45eLIbfKPXGXcaafKrfkOVeSafWcdTG/DbZbqRD7LRa2
         w10HpSl+i89YsufNCC4gV8b61Xyal2l1TOyjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739792717; x=1740397517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gslSeLU065wOuo/exeqAIaqsKgFJISNX/u1ft+G91Cc=;
        b=CTG1ryuA5kFerpWjpQLdpm7+DvygAHN+7LrCzgRsff8A6K9pURc0G0aPGr5ZGQdtMN
         AGVRq2SONvXrStarV4ivboC1px4Fmdd/XMSJzjzy7feSmOibgQeM5onRpRJFhLVxFinp
         8fpdTN83Jhm/3/i4IyaG6+vzhRcPNHv5opFgXCn3cGyhs9AuB3r1YfkJrBcPCB4dj54I
         i6ZUfkbz8Em1dQpnH8tY9VjsZPCXtdv1pjmOYbWP1rSBkfNzGADo+jWfE8RqeTVY3HAH
         MQN3/78Vnt/UzqSL5NJqCRmLQLxYeJIRSeVf36U6FNF6f26l8LThrI8nquCkGtnw2elF
         BDwg==
X-Gm-Message-State: AOJu0Yz5drt78oiOOJnKTKY4oMpEhjqrDOFm9+XE/8dr96wjDt2lTKds
	VXRZEqlZ4VO+ZpgZFERnBLEmfohOaGgQa7Gn0NMNSZH6m9lyG5r0CHr/lTSoXdxlLjrzfF1xcyS
	4
X-Gm-Gg: ASbGncsIA+Erk4gr4cUkw1EWNpHpVJQk24BGY6OOnJopcpz4zLa7cURSCAJ4kNbsqop
	B+5HGhyXBEZKmwaD6qMt92FzqBFJA4qtFXBBRpLNXTzKz68s9oc7uIvbC9xAJ1/OzGSMQe9lBLP
	TnkOuA+7L58pjLc+Fs0AaRLPYd8T5cmZ7yBpd/GmTJEe4eRT7owKiReTmk+sSQdBS2hkUU+s3hp
	Yin2JG78NggdwW4DpT2rdTnUIBDPRWb/4Yj1m1ivx2S2MNGia975urVAn91eMtopd1PVf38imw0
	DvA+FBcM0yRWBf0Lo4Co8nngzzIb+BFXavkYJmdMK8XzXP9KQP92c8SYub0xwFuzQIz+OUy6eVo
	HVX10A+7c7Vc=
X-Google-Smtp-Source: AGHT+IEWoZF68RXu+nKi7MNugaByBfNsuJdBAp6ZRW5eMiRrJibFJTDidK0cVOcEQlNep0we4lB5PQ==
X-Received: by 2002:a5d:47a3:0:b0:38f:37bd:1707 with SMTP id ffacd0b85a97d-38f37bd18f8mr7646742f8f.0.1739792716753;
        Mon, 17 Feb 2025 03:45:16 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com ([2001:b07:6474:ebbf:78d7:ec72:38e9:87de])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258ddbe0sm12181637f8f.39.2025.02.17.03.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 03:45:16 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 2/2] ARM: dts: stm32: add usr3 LED node to stm32f769-disco
Date: Mon, 17 Feb 2025 12:45:09 +0100
Message-ID: <20250217114513.1098844-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217114513.1098844-1-dario.binacchi@amarulasolutions.com>
References: <20250217114513.1098844-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As indicated by the board silkscreen, there are three user LEDs.
Add the missing one.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 arch/arm/boot/dts/st/stm32f769-disco.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32f769-disco.dts b/arch/arm/boot/dts/st/stm32f769-disco.dts
index d52e36aedcfb..535cfdc4681c 100644
--- a/arch/arm/boot/dts/st/stm32f769-disco.dts
+++ b/arch/arm/boot/dts/st/stm32f769-disco.dts
@@ -86,6 +86,9 @@ led-usr2 {
 		led-usr1 {
 			gpios = <&gpioj 13 GPIO_ACTIVE_HIGH>;
 		};
+		led-usr3 {
+			gpios = <&gpioa 12 GPIO_ACTIVE_HIGH>;
+		};
 	};
 
 	gpio-keys {
-- 
2.43.0


