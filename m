Return-Path: <linux-kernel+bounces-566465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB37A67859
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ED74421EB5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F7D211261;
	Tue, 18 Mar 2025 15:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YIKctc1B"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D69420F060
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 15:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742313054; cv=none; b=QUBxjlLHc5aqhtLPjs3hv1wFpqKP8orI6tpkyNk7jwwxt4h5XG9NDrHbnA44OX7mW9sy1LChfEpl/9vEcmIMSOAgytugXTbZQOvRTmyiX137ETifjEHO28cB8pDBGGBPET95hyxZekrdRRY6q+MD7mGVTAn06AIvYy2QuHxi3X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742313054; c=relaxed/simple;
	bh=jTH2WrbnBbQ+egDlbRSrLxqBvblOJqGCERFwMmJWqDU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=u8YjwyJ9tF5rb+6+0tSVvNVKLjFNkdD4DA0IFKN58epRylg/tynstexKlEsjNgXOvg1CuJB0BfuGxkZbSNzBkXnO3Y25qe2J0F6N6Jtw3r8mvK0sR1fCjnNSUK+Pw79dXcnDE/uLQd2zStD73da6D+tqhUfxAplgGkVRqwQCHc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YIKctc1B; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e535e6739bso8591398a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 08:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742313047; x=1742917847; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IfvWKJMde9o+IkABs0RI8lpum1QExrCI9eSnJDVH1fE=;
        b=YIKctc1B2YdB2PjZi5CR4YStZfXLUOw2RBCyfShjp8L+8hhDSwZrmlkdA9Sketqcm8
         EC6+4phfJqWrJDuWZwnafmuA33CxAbFrQPyikHNrILm0xkaumu/ZXB3qM9U1SLCB4pH2
         cskOo9HK887f1SF86iJq+52Jqui43AaEP9M3KprlOEb4zd6sf41h/ys4gpObP9Aur01T
         LnoTrv5GrdxyuK597wzV9PqxoVQd0309FvyqyzHErGdwNxb9Sm3BC2SaDkn0wAAtQC7W
         wHJiapNyQaeExkC7H+n3cWHLoJDT6uAHENbXi2l1BzlUudXqXWYp8ubtzH6sPUU1/NwE
         aKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742313047; x=1742917847;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IfvWKJMde9o+IkABs0RI8lpum1QExrCI9eSnJDVH1fE=;
        b=o8vUCGXQ6F+zEqqfuc6FgMIE4cwqYzUiH4zW6rrDosW0KZWmzTh+eMjbrxvdbMgN4w
         2mmp89vonJQcpWh1r7zRW/eWo+l3FkmGf7TJo4BQXrYFjmaZF9s7qdZSC1ugNU3ZI/5u
         bqYF/CJKmliELVRuF11qFNfHUyENp0m5SbLrqjJfG//SQj2jPiS0TTNqVZFC+0TrGQ/c
         AZQhPS6DdRjAHvOyUI4c2Mi/OHwiSTp61udOpRsuNn05EaKsTJEOotqA3Jgo1DrYBghN
         zpFtjkaruDV7FhWTqlArnmGtElMEkR7ygDJY7b2iPOtJ1IA62a9EyRT6DVlgP1VK646G
         s+sQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwtMMDLTSlH41q56pwZuuGuBy/pn9MhIi01wsgyuuJk3EiZqxxuasYXCjNnjFbmO1++oBjLT8JKW6GVKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFz3dHFhyjk2vJ56nMCLWDmNBQ0P7FQXAjdBeiTtlo+2OlJi7V
	wWq01U1KZd4KVQcIPflmVRqqpey/+KPHElblx1D0icZT3l/I/9ZYl7CnbDpqInc=
X-Gm-Gg: ASbGnctBZEECgAW/XRBS549BDhvDOI/Dgf/cHJ5WU9wMqrLmPYbM5eNi1Dek3gaBLT4
	0Ta9yXHgyPb7O9kInBrFAXSOqaVIyHEoEpE1AYRWD17w/wekOBa9sCh2e2BqYTQQUU/+1k0LLqP
	2KJeO0o+S9JsfVPLceW4JcnCNlQHzLTHyFqx6XKwRqs5HdfbNegCPCWSy1ZfM7wmMEOS4Qu971e
	3eFdAd+z/2sm0fSpxEz3xz+ItLnTewcKR1XQWfi4nRrk+2oKsaU68Kh/UyoAkk2ywvewPjJy8hs
	aN9vWBDYBkWReBimwKcdSshjLhMaM3RqCX22AVWhACA=
X-Google-Smtp-Source: AGHT+IGoiGaMMvLdvCNbl4oN1jAZOiN+aUxBKf5IrKehClPIdc/Fl8fuM7g07f1BaR9y5WCLJoRqyg==
X-Received: by 2002:a17:907:d7c8:b0:ac3:8987:5ca9 with SMTP id a640c23a62f3a-ac389875d4dmr495893766b.19.1742313047366;
        Tue, 18 Mar 2025 08:50:47 -0700 (PDT)
Received: from [127.0.1.1] ([62.231.96.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3149d0077sm875615566b.93.2025.03.18.08.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 08:50:46 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH 0/2] arm64: dts: x1e001de-devkit: USB retimers related
 fixes
Date: Tue, 18 Mar 2025 17:50:33 +0200
Message-Id: <20250318-x1e001de-devkit-dts-fix-retimer-gpios-v1-0-1c092f630b0c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEmW2WcC/x2N0QqCUBAFf0X2uYVdtbB+JXoo92RLpHL3IoL47
 118HBhmNgokR9Ct2ihh8fBpLKCnivrPcxzAboWplvosjXa8KkTUwIbl65ktB7995YTsPyQeZp+
 CX7Cu0cu1Fe2ptOaEIh2f+2Pf/+tJH+x3AAAA
X-Change-ID: 20250318-x1e001de-devkit-dts-fix-retimer-gpios-bed83169401c
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>
Cc: Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=747; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=jTH2WrbnBbQ+egDlbRSrLxqBvblOJqGCERFwMmJWqDU=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBn2ZZNfKSUqAC8rhDFUbrmlhH+B9Oczz7Xs/ce+
 v+0PuG1ubeJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZ9mWTQAKCRAbX0TJAJUV
 VmN2D/99jgLljP/op0bui+kS83hAOi89P4Q32M7a6y+Vh3PqkHIG6ASRNbiZ3pEAhB+foJBBFg5
 8UKI5BEZ7fs3N9RIQKvObMH+/km4kHlFg2A01boUF4pTweeanPcuQBxHP4mUSp2mFFqhu0RWrM0
 eU5T/IC1IIIlVVMrvqJOFkOv9Rzdx+nfC4DWpDAUA8aESw5bDbWlaS6bIjBzwDQZudAUcZfi/u3
 0u0AmPyzz64aO324/laUnYWBB65LHl/2ZzOEwa0VZov/JZ2Tj3ykHdRhUlYVL1UggiBVA3LIj0m
 s29MnNO9Qa/UmQk63C8H9Lhx/zsQge7MJHmLiuNr+bJEDZX4Xn9CILf7uEIRl3MDzGjlV+UoT4V
 8GhUNOwXnA+Eqe5t0V1vvZTgifxxp5foQgEM8rfwIMVt05zRpR75CWNcxQYxO1TInY/lfMaouNi
 7SrjBiurceN1yiyPIvLnJzakahtnWIVWdKVQDMPxTNVS3Y0lkxoLvAolUcPpqMAAKKnZdKq4eTh
 DMNSzsVBHZw2RfuMUj2JaVjawBzVRv8+RtP8QZHSJZB3eMJ4/z9p0Mq7hGK+/0ttnPFPTR33q1n
 MrQkt0bOBsceyT0hE+8NVKBQbh32ul692bCGuvBG+EZ1vXcIbelWa1c5sKf2IcjWtAvKP3YzH1K
 qqN6zR6BtFx5/mw==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

These fixes align all the USB retimer related nodes on the Devkit with the
CRD and T14s.

This patchset is based on Johan's:
https://lore.kernel.org/all/20250318074907.13903-1-johan+linaro@kernel.org/

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Abel Vesa (2):
      arm64: dts: qcom: x1e001de-devkit: Describe USB retimers resets pin configs
      arm64: dts: qcom: x1e001de-devkit: Fix pin config for USB0 retimer vregs

 arch/arm64/boot/dts/qcom/x1e001de-devkit.dts | 44 ++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)
---
base-commit: 571801ee930e6061456a14ded670006f738d05bc
change-id: 20250318-x1e001de-devkit-dts-fix-retimer-gpios-bed83169401c

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


