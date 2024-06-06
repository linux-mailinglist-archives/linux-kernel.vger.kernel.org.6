Return-Path: <linux-kernel+bounces-203956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D3E8FE27D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E96CB29ED1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729A314EC6B;
	Thu,  6 Jun 2024 09:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="cWfMu6Kh"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6500B14D6E7
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 09:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717664971; cv=none; b=toF7hfiCs/bcyCnTUYakW1NDiRb8ZXY2NpJjEM/fkACJpQf7E82zby+JnNY+VCL5ZsXNgpD7w+KlPExVjLh5bRQpDMAy65WoWTGCv0/5tV6eZxqTYS0/9vpbaS+1qqfmzpH8UTAP3HHuSbjSkQ4IHwwK9MS/4dWRIo6LcQ2m8xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717664971; c=relaxed/simple;
	bh=smlH6T7zNUxLgq0OmtV7Rk4JiobNDMTSW4bVj1LVQxI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AjJwzalNoXTV+9m4Z5gFa6KGF/QUuPAYFNz/rGrUYSUtnZulmVfwg+E8H6lxHnJXo4o6qwM+xRlKjNIeHWCAsdygsiu69SkLN0B3NyRcNydah3ejs9gfUdOjeF9Nn9D281/Oy2di0K0kbqAEJDJnIERIyaL51BFMTjRzXtthHQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=cWfMu6Kh; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a68b54577aaso76861666b.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 02:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1717664968; x=1718269768; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HeWTsjDgfYcjvzpN9AvdtAEHKQHZVOf8ieRqkfpvQRQ=;
        b=cWfMu6KhrgPF3imNOHEt+r8zGhrYPeKzdjvKNo9rMxmyW1t30p5KBJ7u1GW4+0vlj+
         Msyg8ifY2oqtB3fPB/wcyifJZv6/4wft/lxFsA5JCEmSF6vAbnwCfNokRjip1ww+3M+n
         ytDfFbsvB4Bgsog0Dm135LOHYCXqIHyRHHP12XvTKV3ZBL0SA9M7Ng/cnFl5cqs8Zfrz
         vSrFNKGeoaxfFgLcwMAcF/Yy276i3V0N+jLBw8Dmv8E8mR84vtuChr/n1vxW/JdAMNFQ
         PD0OSZA157Z8UNDi5EGTNpTDk3ux6U90h8xplRwwpN0tiAdPtPd1T9LuJuFmxU01ed8i
         +vPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717664968; x=1718269768;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HeWTsjDgfYcjvzpN9AvdtAEHKQHZVOf8ieRqkfpvQRQ=;
        b=sLBWk1aKmQRbdwQhPd0xk430zSw9TcGYuOy+26UTzecdM5NoHte+lH3n5UFxf/oVsW
         Sva82DD6iPfnt7KGNLPQxCgxfNvuocFwYxiEZCNqQgJ0sICpWFtrA9Jc2LI8swnbAbZw
         SJP3xRn5/VcMvZzrwtzcLuIhvmNIS6Z3zh8nXn5PzJkxsNAuu4eugkMiu2MhAQGWKmhm
         WMu+WTxZCunWc20dCGMT2IZTaPT6FdYxxQLqBmzOViatRN5Ats9snWpHmYT0pGWXUPcd
         nSKk3CWqsYO8pX9eIkhWOcMhw2voaeEE2+nlxdBJeFT74Q2v+iZ6EnxlQ87/vlTBOBCY
         uX1w==
X-Forwarded-Encrypted: i=1; AJvYcCVIiBILG2s/cav0WnYSGcEFsT60raJ4TeFVX/mAJ7XJX+JQLYU/75qRbBWVvmsrGuoJcJEeM80ZvVsUhDcYm3OPJqP0qLroz2IoTQZW
X-Gm-Message-State: AOJu0YwdFs0HcuU/QpEM0aWEVgrHA7cpul0IdHNhit+eklA77kwpaJNN
	WRHSRimt/us+Zqrwh1HXUYkq/fXDFp9Q45NBYL/ScXN1jWoW5lxohEQ1K88gUdQ=
X-Google-Smtp-Source: AGHT+IFATerlbshiVB9ZH69mQZNENHUzFhrPR4nN3eku2fN5TTpR1lr0p7A6w/6VhU4mf30ksR4j2w==
X-Received: by 2002:a17:906:174b:b0:a68:ad68:c7c8 with SMTP id a640c23a62f3a-a699f67ecc7mr310175866b.36.1717664967729;
        Thu, 06 Jun 2024 02:09:27 -0700 (PDT)
Received: from otso.luca.vpn.lucaweiss.eu (2a02-a210-20ba-5a00-9ceb-707b-2d57-26f7.cable.dynamic.v6.ziggo.nl. [2a02:a210:20ba:5a00:9ceb:707b:2d57:26f7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c805cdd32sm67724966b.79.2024.06.06.02.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 02:09:27 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Thu, 06 Jun 2024 11:09:06 +0200
Subject: [PATCH] arm64: dts: qcom: qcm6490-fairphone-fp5: Use .mbn firmware
 for IPA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-fp5-ipa-mbn-v1-1-183668affe58@fairphone.com>
X-B4-Tracking: v=1; b=H4sIALF8YWYC/x3MQQqAIBBA0avIrBuw0Fl0lWihOdYsMlGIILx70
 vIt/n+hchGuMKsXCt9S5Uod46BgO1zaGSV0w6Qno0kTxmxRssPTJwzaEAUmb32EXuTCUZ7/tqy
 tfZcL1xBdAAAA
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.13.0

Specify the file name for the squashed/non-split firmware with the .mbn
extension instead of the split .mdt. The kernel can load both but the
squashed version is preferred in dts nowadays.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
index 8cd2fe80dbb2..6b4ffc585dcf 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
@@ -551,7 +551,7 @@ &i2c9 {
 &ipa {
 	qcom,gsi-loader = "self";
 	memory-region = <&ipa_fw_mem>;
-	firmware-name = "qcom/qcm6490/fairphone5/ipa_fws.mdt";
+	firmware-name = "qcom/qcm6490/fairphone5/ipa_fws.mbn";
 	status = "okay";
 };
 

---
base-commit: ee78a17615ad0cfdbbc27182b1047cd36c9d4d5f
change-id: 20240606-fp5-ipa-mbn-d0466de6b5bf

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


