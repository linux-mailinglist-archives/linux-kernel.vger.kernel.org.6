Return-Path: <linux-kernel+bounces-269490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B92CC94336A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EABE61C2191D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5C85A10B;
	Wed, 31 Jul 2024 15:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ssauAQ18"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852631CA94
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 15:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722439984; cv=none; b=lCESWLPRAFyza1xIVUO7RIIgZuls2BCuHWqvFbNFdkLRmXuw9XK6HpoJKA62/Wr8BvcmOp+5EIOFFKkXybTXs6Ewr4oAT2/FNXySOZgeO6QOyi86TU7Mf7jPYtYv7tLJtrMQfja8GSC4epGhnBWGpFdrvIUJWQRrX9pFMc5IaKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722439984; c=relaxed/simple;
	bh=K5cl9bFFOQsQkgsBe1uONRNEjOF7EIQmAyOyeO6xScw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8qtVdkKvgFcdIKDZ5ZTaRPeLXePs57m3sMQ3R8Vq/TeFviFnilMaOB6rtS7XlP43BlOn2qilf13cJj3pfxfpqif2pfm/q9d7Xe+2YPHzmTsdOIdpkoRXS3JDzaqV+NSzi2iQFLmZUfjGLv7wSk+YEn/7UPCe6e1dbVH3KWCBa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ssauAQ18; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52f024f468bso8730005e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 08:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722439981; x=1723044781; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dXlLZKVnKFeg1W8l1nLnNf9l+TIhvJC1ODBH4s6Xlac=;
        b=ssauAQ18Jvn0EAgzEUz+PP4vK6eMSDI3cPL8nD20yykmzYIwEhJmWJrchqIA0mN7ki
         smgAKa89DPw/iUyyWbM54fXrhbwed2y+zo0LPIVdYJwSOeo5g9OHANlvpup1Ey3M4te0
         91efaftatF89j9b6LNnGK5ytD6pSKBX0/ZNvIuPq7tFj/A01CXiQdHEqo8M3d/dK0EYr
         JWnEGR0KQ+LweU1JCW729lZ6AtjbOQtiZF/mSUbWC/xnUEwD+y+MBYGBF9w3a6BAbOb6
         orHY/IPPbHFqnAjER48oZ2t9V83BSlN73ZkvFzMCTMLjwaMEMj6lGXE6X6euXpRAzTlk
         OlCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722439981; x=1723044781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXlLZKVnKFeg1W8l1nLnNf9l+TIhvJC1ODBH4s6Xlac=;
        b=tIsrG1yc7sjtSUrrISHVxqXFHYe8qIw7PF1GQ7CnwIdweICIBJtBwjzCAN5vFS6GDC
         Ok4hwkk+rCEY5sP5Wtn91TuPffo1kDrAqxsl+QRy1DyAAmL3gVRs96ZTZZZX7l+o4s/r
         4SymrMWLXJNcuwda0jhmY6vfuR7G8YqVRitn46dJD8DoHTYsOdO3DHui2QgHigkplAZZ
         OanF7gLTgFZQtHTPab7PVf+AHsFAaXC4QT7f9TtncSmtQ8bfCHM786Bcqv9HNVIB4YXs
         yuas1bgABHZyOqk0eaTF2lbdaCpYmX0wCSjI6B2FIxgQVr+OEjwE01Oi06qy+4/yWkN1
         WJrw==
X-Forwarded-Encrypted: i=1; AJvYcCWelihHpA4audGQwRDBuU4req6ZQELgG801aTUtlzcT5yAQnBx980a0SVZXNQtGQwXzQc++FrOfrjUAHGF7MOKckf8g59Gqs9xRty09
X-Gm-Message-State: AOJu0YwbzbuygN2qfnBURI4uHaBFEDfRAJj7xHwnHIE9sZlRxrRT31fA
	J5UFs+1OM2rUrqlEyjlmyf1xPvmCLMBqr2xIMeveUqArCjtbmi98CStneV6dd6o=
X-Google-Smtp-Source: AGHT+IHI/yfE5A0j3uFKHs9ToyYhliRfd4GUbCj0FUG/IfGzykUbmyYaIY9jQeHZnTg4OYprB40zeQ==
X-Received: by 2002:ac2:57c3:0:b0:52e:f9cf:cc1d with SMTP id 2adb3069b0e04-5309b27a631mr8628670e87.23.1722439980554;
        Wed, 31 Jul 2024 08:33:00 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c19645sm2280514e87.189.2024.07.31.08.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 08:33:00 -0700 (PDT)
Date: Wed, 31 Jul 2024 18:32:58 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: vkoul@kernel.org, kishon@kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] phy: qcom: qmp: Add debug prints for register writes
Message-ID: <qqppkj2ksfrt4vwhgnxqwlob5zmqdpf6rqxky246urg6ssn7x6@wgp5cjs6alus>
References: <20240731152548.102987-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731152548.102987-1-manivannan.sadhasivam@linaro.org>

On Wed, Jul 31, 2024 at 08:55:48PM GMT, Manivannan Sadhasivam wrote:
> These register prints are useful to validate the init sequence against the
> Qcom internal documentation and also to share with the Qcom hw engineers to
> debug issues related to PHY.
> 
> Sample debug prints:
> 
> qcom-qmp-pcie-phy 1c0e000.phy: Writing Reg: QSERDES_V5_COM_SYSCLK_EN_SEL Offset: 0x0094 Val: 0xd9
> qcom-qmp-pcie-phy 1c0e000.phy: Writing Reg: QSERDES_V5_COM_HSCLK_SEL Offset: 0x0158 Val: 0x11
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

