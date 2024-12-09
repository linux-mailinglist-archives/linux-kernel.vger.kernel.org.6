Return-Path: <linux-kernel+bounces-438589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C529EA32F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 00:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93D97160E8A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 23:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DB019ABD8;
	Mon,  9 Dec 2024 23:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KZy/V4FA"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFF8197A8F
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 23:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733788370; cv=none; b=A+grCHYjKBrnXsH2jz2tuca+6AFknzFw9XWFgo1pPwC1dcNOcja9Gv0bJY6zSmTtIXLHsaI9OeqXRy4jCBnO2ez2Ayb7Fa0QZC0aTqUSWFp0dt3h5oA2qPYRpRsIycHcjz2TEThF/36f8aR11Vi65kMnbeeodP0UndDf75ygFwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733788370; c=relaxed/simple;
	bh=ee9Yq/Rd/pSfnwyk+Gw8BNSUwK2jpwcl/Kc8CNSpHtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O998JJAts2zqveJ3BMHQidad4kTVAFw3oliHSRMxY3fbWjpj6RDX4i9HePgD4uuTCYRtbZxuQ9enRtjjnH7ZZnZFfQ5UoqthmDjqnbUzhhR4KmvRP26jWBTq9FBFpR1H7513ESPpeR771TP1oPfQelWWNqF2HaDyMr9Q8fiLo60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KZy/V4FA; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3003e203acaso23532161fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 15:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733788366; x=1734393166; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8pM7U1GSGMw58mKFSa/5KwQJ4aVmx/cTtBUSfrJJX6Q=;
        b=KZy/V4FA4JmjcMWKJzC0CMi4z9PMTSG9duuO62z73+pvK95akpS8I8uoMottvAazcu
         twcSM0ZjqOKjrCNvxkT+/EgkKNc9MZ6DESiy8jAvXyeU4w/AEZ7KuUNGfr1y8kiW8CWp
         JyTvKEHXSh/0MsyuGriBZFZvL4OdUT6H79g3hpZN9NTPGBsPg3sngiEoHRh91YvHQ6S+
         wWgMEqD6VEEr4XeJxqzVW/7IsabapXPa/lVHbjEjwFOSHY8e+k/6vxNQFmf9i21rncEo
         UBgD1mMjKSAGoBNaLzbrUjAJdz+1pI2TUrQap5gXtzDnwr7yqlYtkfSVbIvNl1Jc8QP7
         mQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733788366; x=1734393166;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8pM7U1GSGMw58mKFSa/5KwQJ4aVmx/cTtBUSfrJJX6Q=;
        b=KHJmrxjDV9BjiUyj512+cpipDfq80gTnnv99+6vIapktuxgucXN1U3ATu7t1ZK/mBN
         BGv7gIEbiySLpiws7abzCzEHLgF4q0VUigH0yBxzpkTa+fzFLH7tZptdsHBpfrEoLDUJ
         nakMCsDgSFQeNp1ug/HNFcEelxVq5jgHHWQcJ8UW4roOLSAS5QKMzss8QfvTLOuOM7WI
         /XBeOZHeOkCU4jrmx8S/+dQzSmMsuhLPl+bw4ZJrVsP/x1AV1lBHeNPE+PzfHFu1RxUy
         3OEFFb4GR5BH+jH3ZVkoNeCFQrcMYQ540BV6VAHv/GMuOYPN0O+lDVZVy6BQfbrbWaPX
         3SIA==
X-Forwarded-Encrypted: i=1; AJvYcCW6Wn+WS5xglnT0A4WJKqaWcf4lCbZKSG65wX7oJW+0uvasAaO9Jppy+zryr2i2+IsmFOadaZ0v40HauGg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/8rpbHGGsf81RyELgPdkdQ2OY8Z1bVprWzK4reNa8N4/opGb+
	WJxkmidCzvHsNQZ3irhJMjPSumUK/AASZINDFtb8aYKAAYS+AQG9fn2XOfkPYIM=
X-Gm-Gg: ASbGncsMIasfPJn8GZdims2G+jDFXMBwKGIvd7G61qUaIdW8jk7f89etr8FLgzE7ggq
	wpfjzRGPm3YrX/jtSeMidyI/Yk99d27UPm7NQacqA7JxgjTikrYWV13Tz6RJhYV80vTr9eCOSGb
	A+DTxU6ci/EPgmbRxV9xRoRCjE3NqKasR27TOK3nePI6eGCA15BjuM83RGeQ9SfCSkh40JJz7i3
	dqVXbGJgQtTilR2kNk7tD7xyH/tjvyAiqflzjoj5zlf0B2JD8z0VZelvZqC1cWJIusgDpP5K159
	mjq4FRM9ts4P35kY8npLNRl2yQAqcq8/Xw==
X-Google-Smtp-Source: AGHT+IHyF5rktCxD8kY/bacLUOJzx36QikPDeY4Bw3Za1LgYmjbnjgANCIKBZa1aDn+yZRzJ2gM1lA==
X-Received: by 2002:a2e:b8d0:0:b0:2fb:5035:a03 with SMTP id 38308e7fff4ca-3022fd42e9amr6845101fa.14.1733788366224;
        Mon, 09 Dec 2024 15:52:46 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3021a5fa257sm6740481fa.81.2024.12.09.15.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 15:52:44 -0800 (PST)
Date: Tue, 10 Dec 2024 01:52:43 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Julius Werner <jwerner@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jeffrey Hugo <quic_jhugo@quicinc.com>, 
	Roxana Bradescu <roxabee@google.com>, bjorn.andersson@oss.qualcomm.com, 
	linux-arm-kernel@lists.infradead.org, Trilok Soni <quic_tsoni@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] arm64: errata: Add QCOM_KRYO_2XX_GOLD to the
 spectre_bhb_firmware_mitigated_list
Message-ID: <w725lby34vpavm3knq3ikz2wb4tzlfr4elbgf25mjbvgamtq5t@zgc52dc2wvsy>
References: <20241209174430.2904353-1-dianders@chromium.org>
 <20241209094310.2.Ia3dfc0afadbfbee81bb2efb0672262470973dd08@changeid>
 <wx6qbdbcrvbq34snzkxawlbpxm6vogt5ccjmdqqyazukfbjy7t@qkvax7tr27bs>
 <CAODwPW8mq-saJuTYnMhA6bCopcjQwBxEoyWhQB60Jg1m7wUZkw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAODwPW8mq-saJuTYnMhA6bCopcjQwBxEoyWhQB60Jg1m7wUZkw@mail.gmail.com>

On Mon, Dec 09, 2024 at 03:34:59PM -0800, Julius Werner wrote:
> > > NOTE: presumably this patch won't actually do much on its own because
> > > (I believe) it requires a firmware update to go with it.
> >
> > Why? is_spectre_bhb_fw_affected() returns true if (cpu in list OR fw
> > mitigated)
> 
> That affects reporting, but the mitigation works by making an
> ARM_SMCCC_ARCH_WORKAROUND_3 Secure Monitor Call to firmware, and that
> only works if that call is implemented in firmware. Trusted-Firmware-A
> is currently the only open source firmware I'm aware of that
> implements this call, and it only supports Kryo 4 and 6 upstream (not
> 2 or 3).
> 
> So in order for this patch to actually be able to do anything other
> than report that the mitigation is missing, it would need to run on
> devices that either use a downstream fork of TF-A with added Kryo 2/3
> support (I doubt this exists because AFAIK Kryo 4 was Qualcomm's first
> attempt to use TF-A) or use some other proprietary kind of Secure
> Monitor firmware that has this SMC and mitigation implemented
> separately. (It seems unlikely that Qualcomm did this in their QTEE
> firmware, since if they had they would have probably also added the
> MIDRs here to Linux to activate it.)

Ack, thanks for the detailed explanation.

-- 
With best wishes
Dmitry

