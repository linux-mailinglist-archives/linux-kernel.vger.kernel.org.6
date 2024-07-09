Return-Path: <linux-kernel+bounces-246160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6FC92BE5F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8ACF28840C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9916419DF8E;
	Tue,  9 Jul 2024 15:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OQWNW96i"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566A719D8AC
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 15:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720538929; cv=none; b=qDiEc+urPSRK8pHeelKXnvyYvjGV5ku5MS21zqtR05PD39hIHdP8bTYxprA/+DdR7lz5Q1PM8M8FTszGcpp5eiPPgBicIAYCDHCBzHOsvYqsFNQ01Fyggvn8vy9NYoG+AGanrPAFPWUOAr7JFZCYRLqpBcUpsBamPJ9LL80FbFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720538929; c=relaxed/simple;
	bh=PmtUUH5+SRaJORBxLu1SBDDmzPciiIl86iKpCyiu9SI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XRXbaJ9aMpZB1tFEonMYQ13VBGQPQa3/8L7sOo6WwOa9w59MWJgYcZS2Jf+JsTIcn0nMXGaYYGgg4kTXaChG/E7P+sNFyS50tnnnkuWviaKu3hs9rYX1pNnoDbXGCiXyNt4zd+qy3OtOiJullCs6ELzyhU6TtNprJDhsGCCgq/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OQWNW96i; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52e99060b41so5704712e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 08:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720538926; x=1721143726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4NePdy+sqgvYcgq7vKT1dOt3fvbuIs0FsUv1Bhxyjpo=;
        b=OQWNW96ilkySUbMUCMEDluJhCsYeTMX44fzoH9QSC+Pnwsxg+M2T+/EJ5UGnjvveos
         H7SjOzuE75l/4fwsNqBGS/uOLw/smZ7ig2h+voa6ZCxHKoSAeB/cBCKzuACqoKkFzusw
         0JbOcIUasp3iT2oUlnz0qiyWukVveraIYFnLhLWL4MtvE10naQ6MY9QDdZ9dAQgoIdG3
         URAlsNUexw9sgtvzeMTO1qVFN14Rce+BXIQyQdgkCJ1FtWlAvn1Vt9Uhzjda6X1MbX66
         /XtKVibIW1Iq1UIdZ9wb6H9z91bBebtrXwiaTjDRUbm4DEg9z7zft5+AF1qCmCgGX2mn
         HLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720538926; x=1721143726;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4NePdy+sqgvYcgq7vKT1dOt3fvbuIs0FsUv1Bhxyjpo=;
        b=VWxClshuNk59NvCGFyD1Z3BzfgrElfQZnVEuQ9unUueY/UaOw7WwDGWh2brbu6et3n
         qN1iJ7755VIyRu0MHbpAvxZu6xUlSODRweqrmGmSp/30lzH8RS+7Lxe+XSufIUe796pW
         NbhFBuuh7XFg/DcF2yCrxtoIAsR7bnHUIxbGAVic61dvyw0Tl2yHn0Cad1F2N+xfRNGH
         DcMj+Oxdcgg6l/EtjuqFKLDUuy4vSAJz9DwsDD8CVdCmPxnEz2PozrZZNh/lCW85JfjA
         ZZRLScuo1pMdgOV46J4E+/aHhpJywNok43OTdN0Fd9a5+a+0g80cVhTMXhokRReZn0IH
         R+0A==
X-Forwarded-Encrypted: i=1; AJvYcCWPj0BUxOOmrmUNIIC7ifiRKCYnjomwLQ33ohAAKlLH0s4yMv7d/B3gLpR15LH/ma6dpcN7IRDN+fZ57DQ1+X/e6Zn9OJZEASqe/4U3
X-Gm-Message-State: AOJu0YxUEF3s6uNPbEg0bni/bSXWHoaggwwx75R18ei1nH5AS1To7rIh
	dLsJ01iv3/fR62et6GOAWelsip+ALjbUwDLfsB63E0UfDpq+vmG1F7GhtbwVRNs=
X-Google-Smtp-Source: AGHT+IFP2dwZSg+oxisyaGCs/E6PHJKfQeB46et4kmXu8bV/igVFqGZpfvG8esLFZnNZsAe6qemJxA==
X-Received: by 2002:a05:6512:3e0c:b0:52e:9c0a:3522 with SMTP id 2adb3069b0e04-52eb99d1694mr2058719e87.44.1720538926338;
        Tue, 09 Jul 2024 08:28:46 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfab748sm2849119f8f.111.2024.07.09.08.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 08:28:45 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240709-s4_node-v2-1-b9a218603c31@amlogic.com>
References: <20240709-s4_node-v2-1-b9a218603c31@amlogic.com>
Subject: Re: [PATCH v2] arm64: dts: amlogic: enable some device nodes for
 S4
Message-Id: <172053892547.1166789.11882834446987648780.b4-ty@linaro.org>
Date: Tue, 09 Jul 2024 17:28:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

Hi,

On Tue, 09 Jul 2024 17:32:03 +0800, Xianwei Zhao wrote:
> Enable more device nodes for AQ222 base S4, including
> SD, regulator and ethnernet node.
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.11/arm64-dt)

[1/1] arm64: dts: amlogic: enable some device nodes for S4
      https://git.kernel.org/amlogic/c/d3cc1daf38aaa0dd6546dd915ce5d536c250f3eb

These changes has been applied on the intermediate git tree [1].

The v6.11/arm64-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
for inclusion in their intermediate git branches in order to be sent to Linus during
the next merge window, or sooner if it's a set of fixes.

In the cases of fixes, those will be merged in the current release candidate
kernel and as soon they appear on the Linux master branch they will be
backported to the previous Stable and Long-Stable kernels [2].

The intermediate git branches are merged daily in the linux-next tree [3],
people are encouraged testing these pre-release kernels and report issues on the
relevant mailing-lists.

If problems are discovered on those changes, please submit a signed-off-by revert
patch followed by a corrective changeset.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

-- 
Neil


