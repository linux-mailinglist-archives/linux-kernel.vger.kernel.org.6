Return-Path: <linux-kernel+bounces-418783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9C79D659B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 23:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C25C51611B4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 22:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F781185935;
	Fri, 22 Nov 2024 22:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ij7m8Td7"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C532615ADA6
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 22:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732313800; cv=none; b=nNwgzrdXB6nHJqz8ADfsrB3qDAkQWJ+GSO6WwjspI2FT9e/lvVFqA9NMkm3N1CCAWfa4va5vwRs109Dec2wCeWNT8ubY7H2Vpzi7b5rZsb7/P4HDOgjop04fRPVe/hla0OTlYEvvPDXKa4Du1OtQXE2AvySavHe2R76CxwE/Nlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732313800; c=relaxed/simple;
	bh=aOG6ClrY6lqefMk44UT4DZQKlYJU8tKP5/H9aVO6OZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XH1jx1xWPsrqz6Oa0S2i+Gsv0QoCYWJ/qTf9oANnbsBCrLJkA6DYWW2JoFd4J9tNh599kIB134ZA65yhqH3pn5Lfyq1GP0tzFxDkHsYbvpGuNnL3UJisocrYNGJewQ2WBKdi0PVaJZDDcjTWWYqYbHJZAJG8NBq/cSiXH3MsZjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ij7m8Td7; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53dd8eb55c4so1268473e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 14:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732313797; x=1732918597; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5NFj02jhNQNdIiYin2GDKXP53mu5BQwP426EP/zKK4E=;
        b=Ij7m8Td7fNbHjeweGrfGRLoKLkmolfOZGfArAhCcmj7slaALn4LZvdjdRBPrN4ssFO
         jxl7llYkbCdnJ8g9OGBqXfNZhloP+damFSiot3l8TxbEE9t3yLrBKKUf8GPLC2nfAtE4
         42uUJZKX6e5cDuhMAKHKOyZMPWCzA2hBwBPCkOs/3Z8SLLY6iHQ6n4ifskWX4gPfY4R8
         P4TSGSMzaITeCyRC3cVmuzZQJZsad2uHCR3V53sTpgp+Dh24xC+q2xlHemxi5bMJ53m4
         QNnwpx2UluiA0smFKkyySXfXiu7+gFJGqpBjuFo3LEii8TPoglPYv0/QH0odqB5Rjk0y
         6EmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732313797; x=1732918597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5NFj02jhNQNdIiYin2GDKXP53mu5BQwP426EP/zKK4E=;
        b=AVNUMQOah1qj1I93n7ch5viMuI64+CWIt5ROK/AAzGSTbo8qSXvUcSOuLudb6niGfz
         /Dj1fw+qO6A3Siurmy2ueJ7R7E3hFdqPG0WMLbOvgi+T12zLDklpVSXnfpjt+yW00EiA
         eaDddeIcbOjNFrKyCKWiueWCy7gB8Yjz6rkBSfiP42xnPPeRbNU+PWWW4KFm7YyJOHU3
         s+p4qxOrCX7biyxWNPo2KkcVX7nctc6Di5dhUAq9xYn30jkB3JOn4yw4f0eZTiJmfWYd
         oS9XL4+neiWOd3chcnWkTS/T55lmqWv94i2mJyiy00XmhL9pxqcPyoQ7aRPBLx+rcdKq
         nVBg==
X-Forwarded-Encrypted: i=1; AJvYcCUOeyE86CNJPSmERz09eVCX/hVdWZknMhZP3nEiWsQTq4YuLnwnXWz5rop3JN6lfQlnUqe9yCG2Eiw5yYE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxje2gBdXqsAnk0DpVKgCjipAY8KyIXaOZwRnqN0Ir4c/dj22Ny
	fCSBVq73pbbc3enLznDyGV5cekkssJetshA26jXduen8h9LJb0KyXEhA6MEhLWI=
X-Gm-Gg: ASbGnctfCiiYsEpGPF4+Yhgiw3XKTddyxoRnz/IxZN5YNlls12y/xEdsh4a4OnU8o8E
	S5KFU4hN2eofJ2uIzp12khh2VFE8/AtOjnzFVwFMYez68VnCXMuv78YXgJG01+XFDGCgQP4QqxQ
	bCm0aSgk51a64omCT9G3YQwbhDg3A66tIJR+lF1WtY6vPIyH/QkHGZEqOqJxEfiKOpRbcVzWEHz
	Q2v5GZYi+HFZLNLdwuLcTVu3OHreg/qiYhdR6OsCA9t5Tg34sPdHQxnpFulx1035Ta8ZNsKdow1
	qQhZejv5mJdjhA4Kl6wT4bNyPwZGGw==
X-Google-Smtp-Source: AGHT+IGDdynUZU/f9IFLUQqvS6pNdTQ+VSJ+DMeR8Cru5dJY0qXDuv5b6VTt88UdQU0hNw5zRSNqgA==
X-Received: by 2002:a05:6512:2382:b0:53d:c322:e782 with SMTP id 2adb3069b0e04-53dd389d3f5mr2814612e87.28.1732313795952;
        Fri, 22 Nov 2024 14:16:35 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd248b40bsm575233e87.198.2024.11.22.14.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 14:16:35 -0800 (PST)
Date: Sat, 23 Nov 2024 00:16:33 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] arm64: dts: qcom: sm8750: CDSP and modem
Message-ID: <gt2kci6nntiq33fkcu5tmffsmsbjn4ivuiaxc24btjj72wp2ws@iumjaevtdgbc>
References: <20241122-b4-sm8750-cdsp-v1-0-9a69a889d1b7@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122-b4-sm8750-cdsp-v1-0-9a69a889d1b7@linaro.org>

On Fri, Nov 22, 2024 at 04:26:47PM +0100, Krzysztof Kozlowski wrote:
> Hi,
> 
> Context of this depends on my audio patches:
> https://lore.kernel.org/all/20241101-sm8750-audio-v1-0-730aec176459@linaro.org/
> 

For the series:


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

