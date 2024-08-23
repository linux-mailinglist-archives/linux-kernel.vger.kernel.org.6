Return-Path: <linux-kernel+bounces-299224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DF495D1BA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D17A1C23D2C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8376118B47A;
	Fri, 23 Aug 2024 15:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nGrb7kF5"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AB7189BB1
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 15:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724427536; cv=none; b=VVOcU21y02VJrozludo3zBIrhcjcjIZlDWuNtKbtAwqM6vTswRdaU6YI8HyBYTPnL0f5zu6SKZIo7Yvbj7SJ5tPIOxPciGcBeQbJ1aWAik448hWoxewODLkxrfCPluePBbhxfOalOygX+oF+VAdxO8kfCTRUK8qnd+QgPsrEgoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724427536; c=relaxed/simple;
	bh=I1SOWiIGPu6vY2GBisGqQLn9Gw/7zARxAsMqXEON4rU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WYzmu6zRruwxXoavgPEK2Ozd+Fp1sXK46cK8xMn1p404SGvn7IC/qbUc+T/pa7o28Ma8NG0JfVBhnpF8s+1xITxGa3bNemPlwE5mSj+PoRgn9WLNAmiAJ9AoMtAX6bAak2KQ9oWeHw+wuPEnXXGQYmQQDisUA5aZf4Ub1EUOZWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nGrb7kF5; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a868dc3ffbeso10471566b.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 08:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724427532; x=1725032332; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=02t30s/ybPllnLA3TyUJSbU8BgvNyPfDBBck1hFXkxk=;
        b=nGrb7kF5Abymgbn+PvfdUU/iEcgTrUWk9Tzuzvq58xrUEJqmJncdiRntA3sEl9N5/q
         3sRLHdiIV2TwXEhWRbD2aLojAFoSOuvfzcVUWqmEYw64KQBi970lm3YeVSAlBqIU/bE4
         VOvFP3ZJKI1rUQ3pxUJvDTHun+NG7Cxn8xBJmXw9WolMUKs90lJ2a3cJGi7a6m7nz2L+
         QPqoM+6Y/dsMFmukWqF1jaTQ1KNNr9LooR34FysFmxTliAmFqh5pD0XnD6J2uK+2/FbA
         wXiCehPg7HJZOWrmzzNR9iVEmuh2NM6NR3U+nP9prBcs0N2I57/xMeqURaUAmaLwhRex
         mqYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724427532; x=1725032332;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=02t30s/ybPllnLA3TyUJSbU8BgvNyPfDBBck1hFXkxk=;
        b=WNMRLezWQHgXkMraiz2GBJVM6PddmOarb2EMuRsPLEW+MhxovOVCZVLrqnpRIkCTkX
         QXzg2qtyAToMZZjdb9yyatXr+HgO3o+PIG6JMTy+anU6rCR82O96G7QMi8OoI7YoqMzM
         96EtONCK/wbXml1y1+3QAfRsp/ZwXDQMhlX5Iu3rnTxrbnP5atjMenwavr9ORpHtnMR7
         gO/rTJNiekqSTYyw2RaLjAhFDLyEF45UCfbJRuzI5u4/eSc+ricHR8h1MRU+I7RF7/6r
         xrfP9ocOxJI6z+gGR9ZMeyPjcJngPnsvTdTiBHWaEs3j1E7l2aC9wgjrdOCWV5ilUL1n
         ukIg==
X-Forwarded-Encrypted: i=1; AJvYcCX40sqKtm747/Ikck3zYTu/giB6cPxeTC3uHZZdUM518Ue2/bHBstnoA//rzDs4xrlZJ76yLwl+v7osk3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDfpTe0oe6wAwvzHXbqR0vAlTMiGJKBWX9awu4pVQ+3i5duCcM
	V087fiy1HrWxfdOf9Nu1kMCsWKnMvq7eIRbPP4ecN/CnzdmRfrtHk/CIV1fy570=
X-Google-Smtp-Source: AGHT+IF+oQ/oTjHRbmUr6WGmP63IA5idFyALrsMFoNHmXhsK4HxGj6ZLMO2u1Ea+dVgRNa7oqKaM/Q==
X-Received: by 2002:a17:907:daa:b0:a80:79ff:6aa9 with SMTP id a640c23a62f3a-a86a54bbc5bmr95455266b.8.1724427532157;
        Fri, 23 Aug 2024 08:38:52 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f2e6722sm273279866b.91.2024.08.23.08.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 08:38:51 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/3] clk: qcom: simplify locking with guard()
Date: Fri, 23 Aug 2024 17:38:42 +0200
Message-Id: <20240823-cleanup-h-guard-clk-qcom-v1-0-68bb9601c9dd@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAKtyGYC/x3MQQ5AMBBA0avIrE0ySkpcRSyqBhMUbYhE3F1j+
 Rb/PxDYCweokwc8XxJkcxFZmoCdjBsZpY8GRaqgSuVoFzbu3HHC8TS+j57xsNuKypRaE1HXFRp
 ivnse5P7XTfu+H33wRfxqAAAA
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=756;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=I1SOWiIGPu6vY2GBisGqQLn9Gw/7zARxAsMqXEON4rU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmyK0E5oVO76GQ4lUsSKXTyKg1q37ZGutvV4lFI
 V+OGz6MhTWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZsitBAAKCRDBN2bmhouD
 19aFD/9DTXsgKVzm38+yVPk+FF8ijkYsQKdKmnee/5f0/gF+z6P+LBvcQwDIJTa/prG94BHl85l
 3+GvXg67LWC4U/9ygi72U1nB5KZM7r7+TPc8tRAxzt+jHWLdoCUNU94hcRez03387xuTKLssBcf
 q87PEFVUsNTLzDkMfMUhnymwte6/qCyTJSsVdg4ZgfhXdKKe3oae46R7O3VoIUHEeXOF39Q+I9d
 wAYz1YR6w9kER9BZGVw1i4hnYNCliFItXJnSBgAbR4qBNDNUXj+oTYeYGD70/kiU7z9bJd255jH
 B4zJBgLidZXNSWgGokwqPY14MZwMc/tiGFGuSMouh5iBW2+p4YB8oh4VSxb6osFQl8bCzZVgdO4
 kpHqMZ1lJOpiEjtfY5yUir+QEYV/FPoPuDLDQGvv9xoATTA5JCW9qOH4fwuEgl3rQF60z+YbhPi
 VVQ41j1gc2+/VllinXNCrk9v28V+c7DIO08/yKa1fYXUTE5zuHYIFZweORu41PLT3RuteyCO6C8
 3S78nTt97MZsacqPjNXtRkcVXQZkCEYxp4c2HG640qj7y9mlKlpt+s2bbwZMSWWYCFJv3/VSXPu
 r96ykj8aa0B5Eo/N8R4/2sPLIpZtoRFh7eYNQf6Ocjmy4DQMteaReNV1JXgLvzYC4jPOTyCjpKW
 0LRWTPeyzr+sLNQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Simplify error handling around locks with guard().  Less gotos needed.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (3):
      clk: qcom: rpm: simplify locking with guard()
      clk: qcom: smd-rpm: simplify locking with guard()
      clk: qcom: spmi-pmic-div: simplify locking with guard()

 drivers/clk/qcom/clk-rpm.c           | 27 +++++++++++----------------
 drivers/clk/qcom/clk-smd-rpm.c       | 25 ++++++++++---------------
 drivers/clk/qcom/clk-spmi-pmic-div.c | 13 +++++--------
 3 files changed, 26 insertions(+), 39 deletions(-)
---
base-commit: e188fd67a69319f3d105d9b90e424b8d1ff9580c
change-id: 20240823-cleanup-h-guard-clk-qcom-2a766000bb46

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


