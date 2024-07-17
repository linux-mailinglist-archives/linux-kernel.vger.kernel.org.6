Return-Path: <linux-kernel+bounces-255359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5C7933FA4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 17:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 313451F248FF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 15:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9324D181D11;
	Wed, 17 Jul 2024 15:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/89wbnx"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411E5181CF4;
	Wed, 17 Jul 2024 15:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721230086; cv=none; b=E84cMMo+ZB86u4cuUu/SnBEJeRMeYSwoNRxEbwb+riqJ/+N/XhroU4atuYxBQDpizWGm3usKOkIj0/akuzJNGcaV1CptF91xb+r2vX9SJ1CvRKJVpdv1Ag1JRkPxnkSLoops6XiPP+O/18jFP2ZG/p8oY6eImNtAFVP2R+bZLYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721230086; c=relaxed/simple;
	bh=4FcpG6IbFADmvtblRtk9vXV8oEzE06lVCRQDHzV+qJw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AH0dyihItf3HYwvjGbWePmK0WBKEURcrsIqJO1E8yqEXky5ZFcIIkOCULWw3NRZFHNWYLvtq7YDBegDyhutwerNYlNpI8sYGmgJlAoru9AQ7iEjohraQ0Dr30YLIxaG41vhfiVTqvduzeMKRge9yYZzjIRAC9g9tszrK0pis3vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/89wbnx; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-58b447c511eso8874962a12.2;
        Wed, 17 Jul 2024 08:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721230083; x=1721834883; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LWBxa0wp95pNfqw8iTBuh7KIx2bGeIDEbf28wFPwYBY=;
        b=d/89wbnxgVhsbq/IkKiUYfKKNckNJJsn9Otq9AdmJ5Ww3RAZOUrIt0JAY7IGrPBpjN
         LW6WlxQNES1oEiUCxjoCLi22nj0UuO+oKUNlL2DxqB6W216fZyyB3Kn8pnJP3NDE3qvk
         4yC+/ZIUHysyjzfQN+EaG0vCvROEMQ1oYFJ/h9ZAAmq3rQq0idySxmsysF4zK2nB6AlL
         4sV7nkMOjvRzLixNT+8sw4zoCJ2VQHFcgbiTRnPU41A57ke+YRLqD7Ui9BRZeo18OabD
         MeQUqZ4NxfGqKdGwFn0+iRo6MdHr9Nq0wvQVdASMvG9LrKapENXHOzeCyRdCD/NGiVMJ
         Pzdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721230083; x=1721834883;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LWBxa0wp95pNfqw8iTBuh7KIx2bGeIDEbf28wFPwYBY=;
        b=TPL2gn8SpyVV5YrD8xnMwrYf/DTJ7cLVxCr4yA2JoWwYJd6tL4uuPsmRPoyKx8+AXv
         rwN7+FN0NGt0O00zBM4M/nUdpSTW7cdKm9rjn0cxPsC7zetarAmIFukb2Tkxs6EPBWVB
         +bMLSKUO86yIOd9ufZQC6y33VjM4qm4wWYU8lJ7wYjTmnLw8DXvu75zlEtWbCliIdi/e
         NG/XJdqxRxKBs+Ym5UXVNc2K1fOlxviHIiihw6p3Vt/cthBMRlcsGvxr2hG/BvCbjJ8c
         sYvKmS/e4cc6e4FE4TVNvfWYwitIpbqPIFegTgmpp8XdbmdTy4pHYML5jhKR5ACQxL+X
         3gKg==
X-Forwarded-Encrypted: i=1; AJvYcCVZiP4AX/PGXPSfftrtCTEjxYydIhPA15aiXp6r2ijeD5WDjpzyLKn0OChtdzKyWBO9YrkDhXqo9our/DcY2FtMREaGklWb3QGroqL6MYhcCQSLQObk4ryFmGFNgp0bYGzqHuQWsq8C3A==
X-Gm-Message-State: AOJu0Yz9TFo/O/6MEIExI6un9xErIv23xmSyyAzbK5kBlgEB5bU7ZMAJ
	cmyjUCs/7WaS7pRM49ynb0DQNVLBfwcSl2Zha+L0RdtvRwB+tNEY
X-Google-Smtp-Source: AGHT+IGPvxuZMq65v9C4bg+XgBUJ2Jucn/APpVkYImqna3Y17mddN5pqbrDdnDsn0LTvEc/3D7uyAg==
X-Received: by 2002:a17:906:40cf:b0:a77:af07:b98a with SMTP id a640c23a62f3a-a7a013e90c6mr143773766b.73.1721230083269;
        Wed, 17 Jul 2024 08:28:03 -0700 (PDT)
Received: from tablet.my.domain (ip-5-172-234-79.multi.internet.cyfrowypolsat.pl. [5.172.234.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc7ff780sm456378766b.169.2024.07.17.08.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 08:28:02 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Wed, 17 Jul 2024 17:27:54 +0200
Subject: [PATCH v2 1/2] ARM: dts: broadcom: bcm21664: Move chosen node into
 Garnet DTS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240717-bcm21664-common-v2-1-e9bd6cf435e4@gmail.com>
References: <20240717-bcm21664-common-v2-0-e9bd6cf435e4@gmail.com>
In-Reply-To: <20240717-bcm21664-common-v2-0-e9bd6cf435e4@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Stanislav Jakubek <stano.jakubek@gmail.com>, 
 ~postmarketos/upstreaming@lists.sr.ht, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1415;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=4FcpG6IbFADmvtblRtk9vXV8oEzE06lVCRQDHzV+qJw=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBml+L+ZGeLP6/J1Mx9a89UAUX/RBmSuMAQelBai
 zuJ9/MGq9KJAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCZpfi/gAKCRCzu/ihE6BR
 aFp7D/955jbFnq1KbFhNjb4ZXmjieOFBLHv3nYLa6zj4/px+YIuib8QJ2S+1kdp8QYGT87VpIVE
 e8nPqXEjryn826ew2jiykXck9Yk/2vmMT9P3YyX8v/rA74XYFynlgy9W5cAOEkyEet0FJ+69x+s
 Op5MCTsZjEQSl7PB1bDgzgaxQ3JKfQDrXzAbvmWchJ7X6CwPCwrXpNUcTFEKPjPQvvyySnhkDKy
 m9/pfIVIyXLw7aDHlLdKOqlbD6NVUkQFZ3rQxsh2ei7NSVuOkhHMfNoIxGmuhsAR1/M8cuopZYn
 DoQbYUaW3uF5y14A2IhK0SNDnLptU0tr0qSXbCh/bRMclSlbPU2oiROvVOMdXf2NedFrpsCoOGT
 mqJndZfKRpP3pE2FYfhLJUYwO8piA7O9h/NPG0EL2lw3Oo9s0E5JlK6UjgmbbuEwNHyjMzt/qC5
 vvaTmE9dWLFPhDvyQ1gum03iHaZfX0U2QH7sKWA1+bmpZQI30vZGbBc62+4mhb85LDpsxX+bYfI
 m8vGiFanmzCvV2XoiX+4YtYAkUqsFMgJ8G4iRnuaqOqmqnxbxwhGsFKILAzEyvvI79doY61ld9R
 Jij76AqRzRRsa14lH5nscFTPfxurJrVlLVbsSFXW6WsyhHpFGOSgxae4XZNJtLFqWcPlieVXmWR
 4mfu9/Hxm/SH0ew==
X-Developer-Key: i=aweber.kernel@gmail.com; a=openpgp;
 fpr=E663000EAC1DECCD6AD2890DB3BBF8A113A05168

The serial console settings in the chosen node are device-specific,
not SoC-specific. Move the chosen node out of bcm21664.dtsi and into
the only DTS that uses it, bcm21664-garnet.dts.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 arch/arm/boot/dts/broadcom/bcm21664-garnet.dts | 4 ++++
 arch/arm/boot/dts/broadcom/bcm21664.dtsi       | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/broadcom/bcm21664-garnet.dts b/arch/arm/boot/dts/broadcom/bcm21664-garnet.dts
index 8789fae178bf..4f8ddc1b3ab7 100644
--- a/arch/arm/boot/dts/broadcom/bcm21664-garnet.dts
+++ b/arch/arm/boot/dts/broadcom/bcm21664-garnet.dts
@@ -11,6 +11,10 @@ / {
 	model = "BCM21664 Garnet board";
 	compatible = "brcm,bcm21664-garnet", "brcm,bcm21664";
 
+	chosen {
+		bootargs = "console=ttyS0,115200n8";
+	};
+
 	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x40000000>; /* 1 GB */
diff --git a/arch/arm/boot/dts/broadcom/bcm21664.dtsi b/arch/arm/boot/dts/broadcom/bcm21664.dtsi
index fa73600e883e..c1ad5123bad4 100644
--- a/arch/arm/boot/dts/broadcom/bcm21664.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm21664.dtsi
@@ -12,10 +12,6 @@ / {
 	compatible = "brcm,bcm21664";
 	interrupt-parent = <&gic>;
 
-	chosen {
-		bootargs = "console=ttyS0,115200n8";
-	};
-
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;

-- 
2.45.2


