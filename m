Return-Path: <linux-kernel+bounces-431001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C639E3807
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A55251698FB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D61D1B3925;
	Wed,  4 Dec 2024 10:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ubUNQ/Zo"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C641B219B
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 10:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733309821; cv=none; b=fRJTnn6AvrGjNUus//2pXNYL3rmHey+om+U+a02MWJy0N4TBdJ1NurvGukTmKhOLAdfxXTxxkprJgRDjPI1CawYbolbaVOnz8NFQdC4fKNrpiJkEZwv6fvnjdNivXdQqRHA7u5jiWvDCj1C/UfsAZMSYx/PMYqK39FfIaphOUB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733309821; c=relaxed/simple;
	bh=qtBqcqEn/lY4EWphIaSlcK33geSovQkjuOYAQ+VZISc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mXr7k1kPGlmYkiaRtoAec+DSn/fxtxpo2qZeU77JBd3Os4yMqZD03v3CjvCtAKthh80nT8TcIijEdves1GguFYm09XlspKpAw8Rc+gccHMA3F4qyKdeLkT/pD0rcIAvcHEovuc9pUqfED+z8WIpR9+et9/RYBMWCuCFQDAptZPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ubUNQ/Zo; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-434a1833367so4429475e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 02:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733309817; x=1733914617; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KUOtpwQ3KMagjbDRxLtGL35AgcOAJpN0ccPfOWxogUQ=;
        b=ubUNQ/Zo7eXGudRjcjDGkID6y+bZ+qi7JS5CwL8qJ3ZnxkkUmU+HO4R3pUSmNWRaxF
         zR0mzNLZnMA9AuHon2Bbk8843BLkQisMD+CzAxVfw92HcWb3Lqc6/gMuqwt/npOfDro5
         Z1kJhMx6BlF1uFFkMYugDLE8dZOtXKLQoce+96XLyJCKaHztRB9mGIbM7U0IAedcNosi
         27cfUal/SHAwjbc2G+Zb/t+lKyLZBpmqYGM1teuDP0+oyp2KrhXMyN+n3DFOQR4VNaM/
         aJGunLhHBWsQI7G9THh4tGp+Xw4VxxRwVk9p/QAWwi0h1K2IPtbgkoC2t7QSbVkrS99L
         Hq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733309817; x=1733914617;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KUOtpwQ3KMagjbDRxLtGL35AgcOAJpN0ccPfOWxogUQ=;
        b=ZCMsvBq/MHH57ACRVkk1J650YGqRv2yv5vCf+z4ZScBnvljN9Kkd5mLqdvx6wLdoWH
         PmHR5j7SENgsF0BHte8uBR7vUxo5NmgYhRMudA4hLRnjJmYthqUaxL/4DK4KDw30tx/O
         JgOxkrqhzfCrnfhuuIm79ht7OVxWQGCd96dabotjEmjZDW9aVp9aOzs00n/SyrBO3upv
         /AY3YzXLx1DesgVwwxvXIrSH8Zn48zgMDFfiAyodOWo5AhZXkItUPSasQhYy7MUjWtmZ
         JEmLORMeb6WtVwK3BrFEWJUUvxJRr6wNUSLVDqJWkH7s4+WG33oexM5T5V9aWkae36ds
         n4gQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrTX+1yOv0JpaoNJcmpsXCCBypcJsnK6vzDVn0s2Q4OGvUzvxUhln2FbEQgN4zdXtCbG2De3Ph7lwOGQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfPD4EzeDTF8V30l8XRL53ky4Qz/M6BPSWNIx2EImFQSZLeg0P
	H03cTQW7UPFjIJoeQRl0iQFKQ9uuL+C7ueObJiET3SMrbNlXtM8z6Uh2ddO058Q=
X-Gm-Gg: ASbGncu0ZPS4RN1zJ/rZfppN0aWC+C0dBHEYhULcrn4RLXcu3l9rARkrQj8XZBE9nO2
	pXnfXdRFcF29VMImuuvyW2iFEA1nSLuzNJFpoYRgB/GBVuNZHFeJ2jZfOX4ENeJeuErjj2x7EZj
	Te71hLilUnrr9W8OtGIKAHnwenUkAW1sar9uY0XVlpcYuMFrB8as4kOJPK98RHjWO0DYRQtV2Ae
	cJf2STikCikQoIp7Nb5vnibfHbmL4fZXu7u8ItdWiOdxwPAAkB0Pn2+ov4StSyz7GWscBQ=
X-Google-Smtp-Source: AGHT+IFPGq113W8TSbVKyV70ifhWGbdOFb0tEnBuYinl8tALI+lYoh0ywADaRbQVtJyZZzS5eAD/lA==
X-Received: by 2002:a05:600c:1f91:b0:431:7ccd:ff8a with SMTP id 5b1f17b1804b1-434d0d7b89bmr50085205e9.14.1733309817589;
        Wed, 04 Dec 2024 02:56:57 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd687c3sm18459063f8f.77.2024.12.04.02.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 02:56:57 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/5] arm64: dts: qcom: misc DT bindings check fixes
Date: Wed, 04 Dec 2024 11:56:52 +0100
Message-Id: <20241204-topic-misc-dt-fixes-v1-0-6d320b6454e6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHQ1UGcC/x3LTQqAIBBA4avErBsoEfu5SrQwnWoWaTgRQXj3p
 OXH470glJgExuqFRDcLx1DQ1hW43YaNkH0xqEbpVjUar3iyw4PFob9w5YcEjTa9t0NntVugnGe
 iP5RxmnP+AKpl/LhlAAAA
X-Change-ID: 20241204-topic-misc-dt-fixes-6468da97a4cb
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1096;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=qtBqcqEn/lY4EWphIaSlcK33geSovQkjuOYAQ+VZISc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnUDV2MoaB0Baiq3Escr/3su21kioaQ6XYNT+UBtes
 cwjUkWiJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ1A1dgAKCRB33NvayMhJ0VtaD/
 9ar1/puJS665EkdDF+zXa2/tM5u8TffSBQClBS7ELM+fkk3vXa5xxtJxngQmu25huKYP88ncA1pL5I
 FZYkYUZD/L9xeSXqHAgwcmNrhzCkXaUz3Y47eOdHVBZddAn+uGiHpLQRoDHlHauDk5U4R7c3gyVr7c
 tWaeqqpdBMLVEumpdyEA05nFURXSm94Vf4XIoAfQkn52HicUyXGcBwl/Bf3DM702iJs2tDXjkir+mE
 VZfUcCDGrjV9HxgYHNxqLIyj+irM6bldLs/L0VGbL8/NbX0v2oRHsl92gX3AL1JPVxtqSScyrdl0ai
 B1tCRy0hkTcbxPjA9aN4FJ0cqvr5gVXgg0p5aqEQy0pqF1D3HkUOcD4ls5yusM71+rZqQiIoOTMnkp
 VwhzqJ9mu6G8lpdku+CNq5hGJGa87inckaaAJ2Fjj1F3N2c8S01BJt948lClWyTtBi9lIN+6ffZFlo
 j83BuK8dA85/9cFE5B1DSg42MSV3Q9KvOoIh4MYFirKKCcJ65oRxnS5d0CY++2Eeyai1a5wE+vqia+
 TAZmWjQ/9QmoLc8rzZJ3ym7rAQWD0ZxOl3HvKKv6wWYB5jxF6zTD+D3O8OJiPC2ZLz63nuz8hsqDoq
 p7ds4pntgWLYaQh0QQLpc0TVqeyfPy1tTYeOEiL8brug/8KwhSWlIsmmLHgw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Here's a set of DT bindings check fixes

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (5):
      arm64: dts: qcom: qcm6490-shift-otter: remove invalid orientation-switch
      arm64: dts: qcom: sdm845-db845c-navigation-mezzanine: fix ov7251 lane properties
      arm64: dts: qcom: sc7180-trogdor-quackingstick: add missing avee-supply
      arm64: dts: qcom: sc7180-trogdor-pompom: rename 5v-choke thermal zone
      arm64: dts: qcom: sc7180: fix psci power domain node names

 arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts       |  2 --
 arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi    |  4 ++--
 .../boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi    |  1 +
 arch/arm64/boot/dts/qcom/sc7180.dtsi                   | 18 +++++++++---------
 .../dts/qcom/sdm845-db845c-navigation-mezzanine.dtso   |  3 ++-
 5 files changed, 14 insertions(+), 14 deletions(-)
---
base-commit: c245a7a79602ccbee780c004c1e4abcda66aec32
change-id: 20241204-topic-misc-dt-fixes-6468da97a4cb

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


