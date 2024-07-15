Return-Path: <linux-kernel+bounces-253005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DA1931B17
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 21:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F204A1C21BB6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 19:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8C3139D19;
	Mon, 15 Jul 2024 19:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=patrick-wildt-de.20230601.gappssmtp.com header.i=@patrick-wildt-de.20230601.gappssmtp.com header.b="cXTiYOxj"
Received: from mail-lj1-f227.google.com (mail-lj1-f227.google.com [209.85.208.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3611E136658
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 19:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721072300; cv=none; b=hqKrue+J5+tKSr13drSDo6S0BMB/mX+vUaoRZwP8mFp44c33RAOo8xKRcL59tix2+J8J2QzSo6USIAlXDwjanRPSfIEXncobskj8c9pV1XzaGaohXt0HAHbM8pHF9Gwyj+37eJSzowrFrrriDHZlAJcrkDb8z8bPB6SqY/3zuGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721072300; c=relaxed/simple;
	bh=cemq+9OuqeY3+ummp337Mvo5F4mXDIT79m4hgKaBI1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=G+HQ7LMysUDZwAMOscCMLGr7LHlLK5JxZj5erlwxy1YFUaA7J/65p+nRLCw+v3ieKREEgpdAHtZKYeY1jNOnPr7kzYmMpLALD0bud6Wzv8f8e24KrM7zqv4VNIzeqrV4fIVq/UoHLSLG3qgAhY/L2Uo1d4qdSKK1tUhs5Ck5U8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blueri.se; spf=pass smtp.mailfrom=blueri.se; dkim=pass (2048-bit key) header.d=patrick-wildt-de.20230601.gappssmtp.com header.i=@patrick-wildt-de.20230601.gappssmtp.com header.b=cXTiYOxj; arc=none smtp.client-ip=209.85.208.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blueri.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blueri.se
Received: by mail-lj1-f227.google.com with SMTP id 38308e7fff4ca-2eee083c044so26603161fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 12:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=patrick-wildt-de.20230601.gappssmtp.com; s=20230601; t=1721072296; x=1721677096; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NFsCI/nUGMHpQYBhPffSAiv0o4Z8VMEXV4FQksJuyUk=;
        b=cXTiYOxjsrz5BFWB5pXFPYwf5UusjMzd5o6+Kwrii5SuKh/2njn3BY9/edtzCLuxWn
         TRzSnXtUIkdwbyAxibs7EOTVlJEVmAxZdOiRsM71pRbF+eNhztMeijNDVSxe2SlziSxX
         EMAq3G5sVqhGIYC9cXO0/yxR9YQaPtRAZPt/RT5idM5vwS8Qj0Rb4Ztvx4wGIlOxE9Zm
         A9B8d2QaYZZ3XnEsbt+aYRGczVBra+jhfdbqUbt/osRgy2JofcSWdya490iHGSHts3us
         lEY5zUnHVMJE+KG82VozYh659abwJ7jmNvY0Jv9S93Ly3RTwKpLBDTkPGEqDFgMdjxm2
         zBAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721072296; x=1721677096;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NFsCI/nUGMHpQYBhPffSAiv0o4Z8VMEXV4FQksJuyUk=;
        b=Q3HYFzEWD3aLijF8TbTD8QVGpPm1HO6DX/jCDUyfhy6D75xxqwPltIFo1/wbxDBZ3z
         aG2gk0oG55Lu5srTcxXWgADpZ8uQWyt2juOsaW8/naIv3DMaiVEt9/6pbbVyztm1qcTO
         joghneGjSJy2ddQVKavIcG0mcdQrR7nwS/VbLRX1pk4medQckBflvsRxlYoBy+FqE1k8
         hsaYSMTLSt+9O3yXDgRiG29l5g8RcHM0YfhV0ztnKG7xw6N/4u7iHINJAYoIxdQl45gd
         GFeMu46LBWbrwIxmYO5QuMJonEbfXi3yQyEDBTJWa2Fei1AyiKS66WCTeQjQuvbBIr8M
         I5rw==
X-Forwarded-Encrypted: i=1; AJvYcCXPT9QG2pLGZi5t76n8xKXUzIFbgRKQ+DPuAh1TDrptK1uGR9GNc3UvyAibAW2rENUefmbwjuVkxOlBRGwDckFQYfAlRiikUSe7ifRM
X-Gm-Message-State: AOJu0Yx35ZJaWzGyDmapR4Bh83+cTJ3AEcQKtAINpap2L4PK+y/DNfe3
	+cWUuEgcK6+4RN/1vjHHaqOMcTm8/TCQXbEAC/IQ/9iNW6a9TkOPHOAqYASaEI8iYbVKhRgXUvt
	Kd95WxwdWtnG+HJKqsadN3Y+ih1V4kZa8
X-Google-Smtp-Source: AGHT+IHjhs7lFn6xanLhyvwaA7PatZ3sOOeEdpx/Nn5lzGlDNwLD/+lV4ElphVBjqkaDIyu0IV9Qs/ersaIQ
X-Received: by 2002:a2e:91d3:0:b0:2ee:8eb6:ff61 with SMTP id 38308e7fff4ca-2eef4156be4mr722331fa.2.1721072295803;
        Mon, 15 Jul 2024 12:38:15 -0700 (PDT)
Received: from windev.fritz.box (p5b0ac4d1.dip0.t-ipconnect.de. [91.10.196.209])
        by smtp-relay.gmail.com with ESMTPS id 38308e7fff4ca-2eee1936872sm625101fa.64.2024.07.15.12.38.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 15 Jul 2024 12:38:15 -0700 (PDT)
X-Relaying-Domain: blueri.se
Date: Mon, 15 Jul 2024 21:38:11 +0200
From: Patrick Wildt <patrick@blueri.se>
To: Kalle Valo <kvalo@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Steev Klimaszewski <steev@kali.org>, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	Patrick Wildt <patrick@blueri.se>
Subject: [PATCH 0/2] arm64: dts: qcom: x1e80100-yoga: add wifi calibration
 variant
Message-ID: <ZpV6o8JUJWg9lZFE@windev.fritz.box>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This series adds the missing calibration variant devicetree property
which is needed to load the calibration data and use the ath12k wifi
on the Lenovo Yoga Slim 7x.

Patrick Wildt (2):
  dt-bindings: net: wireless: add ath12k pcie bindings
  arm64: dts: qcom: x1e80100-yoga: add wifi calibration variant

 .../net/wireless/qcom,ath12k-pci.yaml         | 59 +++++++++++++++++++
 .../dts/qcom/x1e80100-lenovo-yoga-slim7x.dts  |  9 +++
 arch/arm64/boot/dts/qcom/x1e80100.dtsi        | 10 ++++
 3 files changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom,ath12k-pci.yaml

-- 
2.45.2


