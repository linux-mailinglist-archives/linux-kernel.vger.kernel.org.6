Return-Path: <linux-kernel+bounces-405904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 078139C5A3B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62741B38802
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 13:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E9214F114;
	Tue, 12 Nov 2024 13:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D7IxsDAf"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E0413BC0E
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 13:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731417238; cv=none; b=GHr0K54vUK5IPWGXwUWkohONH2HHhWID3llCi7VD5e40fiujGhpgEBiP46V6eugZlqT+HEOZz1cFTqB3+OpCycw+W6C1pXnS94EvDp+Mc+MnslWTIT1tFeGsTxu/7ZlC8Rfw9LnkUjnzZOJ9+kVUdfqoGlKwEwERh+dHPhRoiMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731417238; c=relaxed/simple;
	bh=R0ap3SAItWplZeYoD85VtDznS4USEItbV/zIMLvZGlg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fREHSKs99DsJ4Qo8Mhtjd6UsOTRn1SG2bCbWxJxqHV/I4n1wMP833vJAT67Ylytkqlf8nnKHnU9sOa+eGWfCQ/RcGc+qJIck7cztXBLEB+bsioBFJAHWYWim27MtCmSCsH2shTFQLAneypdngzq9V8bSv+8MwTXywzgiQEnQKdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D7IxsDAf; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e291f1d659aso5410914276.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 05:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731417236; x=1732022036; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1It9fi+t+M6AhVlg3Wzgar/wjJMVUKxS6BvTyqKsiZw=;
        b=D7IxsDAflFgFyqYqB87r8pRf3vl4HrAhlkQ781FEdeGhXy+R+hvEj7h418YU40kSUT
         Q2sxDva9l4HtM7SMH3mvejhJQCeU2yEZDuLfWBV+nckiQ68WQ0I7vuiHgr5DW4W6fIyK
         lxxa373lqsQHhx7/LPU2zN3/pVBLfC66/9m5Dx7HXklBlm5MWbZaPmfh07rszKyLrT0F
         5qj561rJqmpkncR5kHJCSn/aDcR/Plbk3KpfvvLCOF3hQdHoSASFw/Y6Q22uoejPFPuM
         dKTirDJ+QSNrhD8NgxSOC8PH3tCto+T8NEeB5nZM02IdvXwH0POVRsZvM1WD6MN77uiE
         VSDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731417236; x=1732022036;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1It9fi+t+M6AhVlg3Wzgar/wjJMVUKxS6BvTyqKsiZw=;
        b=arKIzxfSsdn/X9o9NAZzUV+DBbBk9LW/mp5TFo+A6AxShtgJ3I9qYBXJjI7V9N0xly
         bYQ/2Wo5Lp5d/10opCkxtCGnOX/GdReRrLlN8MpiZDAH9DIv+dCzKEi0J78AjteVa23Z
         dzO0nazdiOf4zpORqMlhK9nQx68zJwIk6iTm9ua+qeWo3zsKJNG2uNhGSdFf62Gqs1As
         f+PYmJoSXZSoe7WEewuuqyqEiWL4GPz8Lw2uV0qLwgYsuhJUyI7EXqxNdID74o9Ux9Nv
         RrKFmKH6iUDkaNhbKfmqplUimCz10id2BTbbkE/D0d40aOqG5GHxymt6OM3BFVCt8j4y
         x9jA==
X-Forwarded-Encrypted: i=1; AJvYcCWFJftVbV2Vj+0PJ8qLo2lMBQrE+o6JrH/OaKm1J+8/ZAg9ByirLaEDrf+EkYfvSFvnkxyWkOWjSVFIyMo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/BLNeqJR+FqNoYN8S50R6t9py1UVwYU4gq4aOPPN/OxgNz3Sg
	xs1/hWcKkHwgTCDVktSFSSZk0Zy8JGM2A9GmOiA5VzSHVCOGk098zxL4isOeMvlHoW567wGX37K
	TzEeu3mSdqs0MVrXJLDeGc4fWPfjOI80bg5sOqQ==
X-Google-Smtp-Source: AGHT+IGwm6LQcl3bbBYTV/i0blyM2mY5ueTBIKTBAfvD+NL74sm096VC0xqni2fhQwmA2z1qTkrWHWuH3ei6PUdsxQA=
X-Received: by 2002:a05:690c:6c91:b0:6e3:1fbe:9aa8 with SMTP id
 00721157ae682-6eaddda1013mr166450737b3.15.1731417235945; Tue, 12 Nov 2024
 05:13:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004-venus_sc7280-v1-1-4d7d8fd7e95b@quicinc.com>
 <kezh3lmysij56g2tjwwuas5r26ro5i777yxxitsdcjeg7zp67v@oknrdbkzison> <78e6ff6b-efe1-496c-a1fb-c9a0a4aba2d2@quicinc.com>
In-Reply-To: <78e6ff6b-efe1-496c-a1fb-c9a0a4aba2d2@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 12 Nov 2024 15:13:46 +0200
Message-ID: <CAA8EJpqqZL7xybcbJMsbTQB+ht5-A+ocNs+Sq30j=v1zM3JL9g@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: enable venus node
To: Vedang Nagar <quic_vnagar@quicinc.com>
Cc: cros-qcom-dts-watchers@chromium.org, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Nov 2024 at 08:17, Vedang Nagar <quic_vnagar@quicinc.com> wrote:
>
>
>
> On 10/7/2024 1:20 AM, Dmitry Baryshkov wrote:
> > On Fri, Oct 04, 2024 at 04:22:31PM GMT, Vedang Nagar wrote:
> >> Enable the venus node on Qualcomm sc7280. It was made disabled
> >> earlier to avoid bootup crash, which is fixed now with [1].
> >
> > NAK, there might be other reasons to keep venus disabled, like the lack
> > of the vendor-signed firmware for the particular device.
> Can you pls elaborate more on this? Any device with sc7280 SOC can use
> venus.mbn which is already present in linux-firmware git.

Can it though if the device is fused to use vendor keys and to check
the trust chain?

>
> Regards,
> Vedang Nagar
> >
> >>
> >> [1]
> >> https://lore.kernel.org/linux-media/20231201-sc7280-venus-pas-v3-2-bc132dc5fc30@fairphone.com/
> >>
> >> Signed-off-by: Vedang Nagar <quic_vnagar@quicinc.com>
> >> ---
> >>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 2 --
> >>  1 file changed, 2 deletions(-)
> >



-- 
With best wishes
Dmitry

