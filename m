Return-Path: <linux-kernel+bounces-258804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E894D938CDB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 12:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93D241F2717C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 10:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB61317164B;
	Mon, 22 Jul 2024 09:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+iLYUU/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F7A16EBF2;
	Mon, 22 Jul 2024 09:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721642120; cv=none; b=JUxGCIO+KnZU1GChuUQruUmHRbaVuyBSOoXIi4o1ezDggDH+cUWbP3IW4r+Hba4yPLsNCMeRP84ISrpwzAh9QXwYhnqdGu8yVPk4oi4BnD5JbKtQQbybuvHN8k/9YNsCQ6XuZwqgiJrn15FuajiGZIPqun9740Ki5FG55L5AhSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721642120; c=relaxed/simple;
	bh=ikgyp8pmvlfMUClhFBZWrBkM+wgPyISauwYP7aiip94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oGKM8mCN1h0g8nGVXEZGyWREZJLb32DcvCTNZRc/CoKx9ctlrgNyqQx+9qGO/m5URPwAnbnRAInyBkVYqMIte3HJxVL/2fsSHk2TVdv882HEbelMrx/+gBTtBxiZ4oyC2Pvt93LXmMPs5OAgsmRdTWV58YKVj2ToIdPtfVJd+ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+iLYUU/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BFDBC4DDE1;
	Mon, 22 Jul 2024 09:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721642120;
	bh=ikgyp8pmvlfMUClhFBZWrBkM+wgPyISauwYP7aiip94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d+iLYUU/36LVPkvB0SD4+cHduzizASmGmI6Sp4RH7udC7EBXSepLyNV6M50gVmgot
	 fnl+khKVFfyijr9rBanrojlmRQQJ2AjrJBrzgjheat/AtcxiF4vhGAW9+egv1gpGBU
	 /mXkOJ3bcMSA7Eo8JQWxJ9lX8GvKZdXA9WEYA1YzKsoZjVzKxzkr3unScfEyvhIFYv
	 sKP3GwNEh+B+OYlRndBUy8pEk5lJ0BdxXVpqWUNowvoaNMR6VwKVFFFrpkUn55mWEU
	 liXf9XU7GgiDv9KXkI4kZn5veeiMQtHgjEqQEB5K+Kr1+DHICxW1NOgMNGhekAi9sb
	 G2s2BV2p93ZWw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1sVplH-0000000079a-2irj;
	Mon, 22 Jul 2024 11:55:19 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	Abel Vesa <abel.vesa@linaro.org>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	Xilin Wu <wuxilin123@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 07/12] arm64: dts: qcom: x1e80100-vivobook-s15: disable PCIe6a perst pull down
Date: Mon, 22 Jul 2024 11:54:54 +0200
Message-ID: <20240722095459.27437-8-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240722095459.27437-1-johan+linaro@kernel.org>
References: <20240722095459.27437-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Disable the PCIe6a perst pull-down resistor to save some power.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts b/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts
index ff51dd98351c..1eb0abcbf650 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts
@@ -536,7 +536,7 @@ perst-n-pins {
 			pins = "gpio152";
 			function = "gpio";
 			drive-strength = <2>;
-			bias-pull-down;
+			bias-disable;
 		};
 
 		wake-n-pins {
-- 
2.44.2


