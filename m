Return-Path: <linux-kernel+bounces-438570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 895669EA2DD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 00:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44E772828A6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 23:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0631622489A;
	Mon,  9 Dec 2024 23:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="adL21zlt"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8D721171C
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 23:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733787314; cv=none; b=bnyZ2/Cua/ScqQVN6Hl7Sy0Yv7Cle+8tZRM8BmcO4OzPDAdt4A0aqcXiXfZJelZbKGwSbS/R8scXRJzKv0t8liGXzq8Rp4lq//VA8ZH4OZClDzEMZik4Z8O/5CQsxLbuwAKI0FuwplhfHrO3+5MVaLONPzWMRuQw1cSXlD+dVRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733787314; c=relaxed/simple;
	bh=Ol03no2dvKfCX77dORK9oxswnoxJuMa+LnUc2hkNM0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oQOrwRH7CFcD/tjSMB9PQUrkKiI/yUwlcLmSr2ccfyXSqSiS8N8A8sQkbILD2oKVRV0qHt9GGkXcse6crS+CxyAAU8I9OOhgL1w+CRXwXFKaX6g7pgkB244k6iQkCRd3sftUM+kIfVFBvBCPCYff2OvqDQS6mbYpVjKYOpBGlQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=google.com; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=adL21zlt; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-467431402deso19231cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 15:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733787311; x=1734392111; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ol03no2dvKfCX77dORK9oxswnoxJuMa+LnUc2hkNM0M=;
        b=adL21zltDa0PxxcBgMIHcXc5knaDVGBihaGdNOJBY8kF3OVQKaF5TWcORgJXzScFDc
         /OjtfOQ8t6SX7FgIAdMgLGqgmYgy4YYUDK8g2Sayky1EeK4X9rYzNM6c9HTrgv3bjDJB
         t1rX2x7rSqzPceeYeUK+4H3a7kxLCHrtuj1c0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733787311; x=1734392111;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ol03no2dvKfCX77dORK9oxswnoxJuMa+LnUc2hkNM0M=;
        b=B1NYZfy6Ss5mCPhEgRoAGY7m0vJItaa/9PFs0kZ0sPqJ0ryc46OVTg6vkj16TsEdO5
         0Dwozx3iU13RPb1bML7NSeGRfLpzeILGXKmJTNXc8Y75vpcATRg5aZnYeJj2YZgz+Jn1
         6ACgh6Tm1xFes6AXFFq+K0INoikh+Qv5WHwwkMj3dGXkGPEmE19vEHpEHfJnt6PIhkZq
         9GhsfY7gE4yRzzJn/4MkkjumWRKZQnbdyEgRc8Ye0FEYFv+X5rG1f+sSoccjWE9Y1TwI
         jPjq1Qs6pueRs0qtJ9C/iSrnVaK5ky5xmPZRtaXxWS+Wk9HgsnFOjq75/OjZOUhUo+Y7
         jwsw==
X-Forwarded-Encrypted: i=1; AJvYcCUs6IROAGUnmzzpmEGGbqyghy/VgswnGliR9x8KKW7agXx8l7GdcFDQFEvM1DgZE11MM9UyiQNk+8H9v18=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl7GiWDvXFIdgDcvQpsQmGjgZkwiH5GR/vTAlQsxHGWgH7YLyB
	b9RF7AFXCiWI8/N2/NZojalLsBXep0y2kWgSHY7KQKN9evHyIKrD3e+dhXegfgcdbFGAirNU2PG
	Oz8my7nexppByMqkPpH0p4EG4tp0ujh6XL4Wd
X-Gm-Gg: ASbGncsoBnD/7rbkoVucHbkCUn6j4LG2yPy/OkfXw5lY5UW4PpCgmK2ICJ+xxD1LBbO
	uQCC2jec8LL0y2TmMGfPswcGO3KTlD6Uw
X-Google-Smtp-Source: AGHT+IG6vBSDnyo8DnXzx5kPzDIJg4/9NRCPEUWYVmSZGIix1BOzyQgBNO2RxNpvwUriTGNn5xGsd58zCPlKbjcYd9k=
X-Received: by 2002:a05:622a:4ccd:b0:466:a3bf:41ab with SMTP id
 d75a77b69052e-46777683c7bmr441641cf.21.1733787311096; Mon, 09 Dec 2024
 15:35:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209174430.2904353-1-dianders@chromium.org>
 <20241209094310.2.Ia3dfc0afadbfbee81bb2efb0672262470973dd08@changeid> <wx6qbdbcrvbq34snzkxawlbpxm6vogt5ccjmdqqyazukfbjy7t@qkvax7tr27bs>
In-Reply-To: <wx6qbdbcrvbq34snzkxawlbpxm6vogt5ccjmdqqyazukfbjy7t@qkvax7tr27bs>
From: Julius Werner <jwerner@chromium.org>
Date: Mon, 9 Dec 2024 15:34:59 -0800
Message-ID: <CAODwPW8mq-saJuTYnMhA6bCopcjQwBxEoyWhQB60Jg1m7wUZkw@mail.gmail.com>
Subject: Re: [PATCH 2/6] arm64: errata: Add QCOM_KRYO_2XX_GOLD to the spectre_bhb_firmware_mitigated_list
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Douglas Anderson <dianders@chromium.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Julius Werner <jwerner@chromium.org>, Jeffrey Hugo <quic_jhugo@quicinc.com>, 
	Roxana Bradescu <roxabee@google.com>, bjorn.andersson@oss.qualcomm.com, 
	linux-arm-kernel@lists.infradead.org, Trilok Soni <quic_tsoni@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > NOTE: presumably this patch won't actually do much on its own because
> > (I believe) it requires a firmware update to go with it.
>
> Why? is_spectre_bhb_fw_affected() returns true if (cpu in list OR fw
> mitigated)

That affects reporting, but the mitigation works by making an
ARM_SMCCC_ARCH_WORKAROUND_3 Secure Monitor Call to firmware, and that
only works if that call is implemented in firmware. Trusted-Firmware-A
is currently the only open source firmware I'm aware of that
implements this call, and it only supports Kryo 4 and 6 upstream (not
2 or 3).

So in order for this patch to actually be able to do anything other
than report that the mitigation is missing, it would need to run on
devices that either use a downstream fork of TF-A with added Kryo 2/3
support (I doubt this exists because AFAIK Kryo 4 was Qualcomm's first
attempt to use TF-A) or use some other proprietary kind of Secure
Monitor firmware that has this SMC and mitigation implemented
separately. (It seems unlikely that Qualcomm did this in their QTEE
firmware, since if they had they would have probably also added the
MIDRs here to Linux to activate it.)

