Return-Path: <linux-kernel+bounces-521386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1694BA3BC91
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA673170186
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 11:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10061DEFD8;
	Wed, 19 Feb 2025 11:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z2581nYo"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C987D2862BA
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 11:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739963799; cv=none; b=UpwrZI+UCFROKth2V9MhpJAlU+N1jmV3vYL04MpQPwH87SOckXQb4osZ+9cf5e7AgYjUjgrU1g2Q6JsfTaSkpz1kRBTVCDB0r+T57Btzd+YlKHJgUvz1SfDvbyvYiCCWXVyKkIhTlbIypfn3u3egHPEALfZsNuOV+I21yE/vmMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739963799; c=relaxed/simple;
	bh=uWOktcaedUBDqKd4C1NzqImpFID0KSF/Je2o+kES7iI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xg79mP5Nmd3lERjboOXllsWqpn8aVmAhxt6D7E/m/08vpqkw19D7lPqjqaK3SUws8+CWuuM98w6+aGedMDTMMyK5zPnO9OeZexTdRAifr0m4YQ6l7Il8Zv6zqxVGgKR6/n+xa80Ghq2/1UloBUxFOYc9fLKpqdRp4FlmzaiVGDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z2581nYo; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43995b907cfso10670515e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 03:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739963795; x=1740568595; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uWOktcaedUBDqKd4C1NzqImpFID0KSF/Je2o+kES7iI=;
        b=Z2581nYoZUdJioFE5Qe/WCZqp1jMbVtJxdc85r9YGhmkDG9ZDO/YX9XW4+YbcNqXk7
         wPSGSB13j+VdtOCCANTniQcKOGgpXGQ0/0U0adRjifpr9iCMve7vFgBy/viWcyUZuIPc
         9ztSo+N/b6XqBh8HX2SanjwS4p/ebg7SLRaeVqbWbEu1uekLQ0SAHTDruFBv0FKj6mhU
         AZ7+6H/1TqQaer23ovbdYRngBNMODTIArItoTxgtZjD5EIz2CcpFbEs3YllrIhSF3yFI
         1ZxpFGbk9HVDofkDVgTNZpxNrFmW6letGneRlByL2XS29ruV26OjCiKD4d49xDZyjHpp
         KnzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739963795; x=1740568595;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uWOktcaedUBDqKd4C1NzqImpFID0KSF/Je2o+kES7iI=;
        b=I2d+YyfxNQVZLTA/w98Dut6TDhoWVkdgceAagj7cNTDPNsfQNz/4OykXvGnh4X5yHD
         QynU4IRYMCW0DrxhSA+H0OTQ1J86puL9qHS6OnGE2/KYHLiZnqeUgSsCh/fF7jchNaic
         YwAttxmBdg8tfzAXIRd6NYKfuWdcCJ2Bpfv5D+CfjICpiPKuV/wqB13Rltbsc2H6JRMO
         l928Czl5zUZFBUd1MwcYYDmSjCeokRxrRpzDd1RlzrR76XsKsNjiibZIP25DYV3iUmaf
         aOswWzVTn11N+f3OFjKAUo2VJKpZn7TDWzNRxCYpjHxz6jP99xcecfzzzSduK2Xp4u3G
         aJrw==
X-Forwarded-Encrypted: i=1; AJvYcCUcXTMDxRdw7XU+8rhAfiaO4AkJ44INQN/I6d9MtbPmpXioKrUrbKTSE21cEVW4CGobTItIt+sZYAPlgbI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv4xwQdothK9oFZRDTqpF++bw4vUjpFI2Cmk3mUJ0rJl6D9yzv
	D1LV8QB6p6ryUilytok+LpVo3kTHld41roV2N6rYtCKSdAgz7IggI6Ri0gV8Hyw=
X-Gm-Gg: ASbGncvXuTq7iU9SMOLkMjBmLYk6HahD9XSrdwUO2nwGFoygLY3JTue0MTEJmmalvN8
	fYLayiWE9bAkzzrSQ/sXb9U3e5NSPFDzmL4Mx6iPSa0TnMhLbYg3quimrlTxCqq1/Cy8n3ygGpa
	Oh6V7bfV5bCf23Bb12SiFpdIhzb7w65mqShZiZVP0XGvFp8pX0H6yr0DIR4PV6M9GVC/BYKvRwf
	oxEOCRldMSlQWja9U1EK7RaxpYogAhOwgSoYdkbaOLHE8P2QW04VYxZUJyYgFr3qqhZ71N32BLu
	osXxIWDuGP9OJMT7QftI
X-Google-Smtp-Source: AGHT+IEmDDRkG1uSwNL1pvVknqup0gDz43+E3qOgrQNfjOcr23dfo95v/reLZTyiBdBUjlLYYhhYOQ==
X-Received: by 2002:adf:f205:0:b0:38f:2726:bc0e with SMTP id ffacd0b85a97d-38f3406cd88mr15712193f8f.44.1739963795144;
        Wed, 19 Feb 2025 03:16:35 -0800 (PST)
Received: from [10.1.1.109] ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258ccdabsm17536949f8f.28.2025.02.19.03.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 03:16:34 -0800 (PST)
Message-ID: <b60fe253fdf581399c11cb7e23db0e9883c81255.camel@linaro.org>
Subject: Re: [PATCH 1/2] arm64: dts: exynos: gs101: Change labels to
 lower-case
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Peter Griffin
 <peter.griffin@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 linux-fsd@tesla.com, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Date: Wed, 19 Feb 2025 11:16:33 +0000
In-Reply-To: <20250219085726.70824-1-krzysztof.kozlowski@linaro.org>
References: <20250219085726.70824-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-02-19 at 09:57 +0100, Krzysztof Kozlowski wrote:
> DTS coding style expects labels to be lowercase.=C2=A0 No functional impa=
ct.
> Verified with comparing decompiled DTB (dtx_diff and fdtdump+diff).
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>


