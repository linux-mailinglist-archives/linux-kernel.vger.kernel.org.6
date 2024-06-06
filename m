Return-Path: <linux-kernel+bounces-204153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 152A68FE4D4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 702CFB251CD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A17195387;
	Thu,  6 Jun 2024 11:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UqxccRwf"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7051922CA
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 11:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717671774; cv=none; b=WBrqYnGPB6TcUTpSRouwJY/S5HV3Vr6B501Yyf2zCRPbkRfFY3IDq4FgmLzXTLX5O8TiRxwHjmDrJAXTVXY+C/oUN5Z7RiadcZR/Y9Fj5xbbMIvpf0ekm7ZPEjqZgH86aWo0MdN5y+YitwIy3UDvchXHxkMwO7797QKcCdG0Nt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717671774; c=relaxed/simple;
	bh=Cy7BDIGhJq90NEejjiiM/tCn55ABVYtvqQk7JroaAV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UiqYWY8E+FF/dNmAmYokIYyIb678JDJky/Nh8A3v5ShNbNqfZ+zxrtzg8d+OhDmPmpAq7QvQi6AzHeUY5Wp+9lUpQVUzvlnvL2DQOFlgJKuv4OobaF3EiqBj8xpHUHh0B+5oEHqIGt/esUpCHgGPmPwOFhCsNzn7Hh34RsWu9Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UqxccRwf; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52b9af7a01bso1008131e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 04:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717671770; x=1718276570; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2we3UvQm0ruc9y6s7vLBgq2e/TF073I7KSHo1LCy+WY=;
        b=UqxccRwf5sIz08iNLQjlbgLxW6u0n2M/lQ9sv/WJ0Qx6BV4RgQq3DtlpLjv64lLGwo
         A0tf1K2SMeJRkJUiKTDrLX/DRzLeVzl8DoZO2jC0FbI0g/D8GIiM7NeW1oz6VGRgXHcO
         JhSJbKEmvaCZ32LXW5j0pgtrhaDLa7EGf3dezbhNJiScAL+LLFS8M/dr5nzZsiV55PR+
         XesNsxpEUxr6EDeO/8v+HOl9X7iTKbD+Hh6kKKTJIx9rhHK7CYXHeXQIlKa5NScvRdxE
         uE6sLVNgJMSps6PgW3bWrbXLeLsdeln9jCoBnJGBOLXcKSfhoE+8MVGIDmqo3lLbUnXK
         t7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717671770; x=1718276570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2we3UvQm0ruc9y6s7vLBgq2e/TF073I7KSHo1LCy+WY=;
        b=IJm2gVZ0XP5og1ELNTfpIggInvXGJLlabE2nA6LP7ySw/F5/FS1ihPSIgj6QQdqeZS
         60u1J47Teje78m9wO8EWE71EQlR+kfE5UsVr+lcROpI0t/9h2KPhy8UqvkGm5gFP2a6+
         gwWUJd/FLCeM0RKnsfq0kRdOxFG0ud56qDTE1JTfz8Lds3/lVQM/HiZw/2TTrX5YvVKN
         TKGyrp6uQHxRs5l4U9M63iiW9VVt8XSMG9pp00f9WTQYjgcdGduHea9HsQUUv1lV8pWx
         AhD5CBF1Z7bhYAK6OSJceIwKwT3biLRi2KV2RaynQfrSyj1zh2td5KjHVyWDSXT8AYBP
         0cgw==
X-Forwarded-Encrypted: i=1; AJvYcCUVwa9yNP8xgIGKgoMrJTdNE/tOILNUUsNkOMwHC9vpukTFbHSpocFPysU+kbhI5l0F6ovcODZUjdDpm1axDvQIcXUHqqyt2Z0VTCZo
X-Gm-Message-State: AOJu0Yy9zAP6U+9qq5IXRH0+UCUP/ARN5npXC0UnJ3fK4KQ3tz7BKNM7
	vP1+YSSQQfdyRj+rZiXOpEFufRkip3AJEg7vYX4km92skOACD5fwukamTqcn8E0=
X-Google-Smtp-Source: AGHT+IF9p1szntCshLotWnxCi/rmgp7YpoVJZQDdl0N+OgyfDtLJTqF8KnfgwTxy662gFKSGekyIjg==
X-Received: by 2002:ac2:5227:0:b0:529:b3c9:7276 with SMTP id 2adb3069b0e04-52bab4c9999mr3043026e87.28.1717671770468;
        Thu, 06 Jun 2024 04:02:50 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52bb41e1f1fsm163923e87.46.2024.06.06.04.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 04:02:50 -0700 (PDT)
Date: Thu, 6 Jun 2024 14:02:48 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] arm64: dts: qcom: x1e80100: Add remote endpoints
 between PHYs and DPs
Message-ID: <pnjfcxrlkzfteky46wpkpji7vhxpdsn2zamklbqvaaqtfiqym5@uo3one26nxhb>
References: <20240606-x1e80100-dts-pmic-glink-v2-0-972c902e3e6b@linaro.org>
 <20240606-x1e80100-dts-pmic-glink-v2-1-972c902e3e6b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606-x1e80100-dts-pmic-glink-v2-1-972c902e3e6b@linaro.org>

On Thu, Jun 06, 2024 at 01:41:52PM +0300, Abel Vesa wrote:
> Describe the port/endpoints graph between the USB/DP combo PHYs and their
> corresponding DP controllers.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

