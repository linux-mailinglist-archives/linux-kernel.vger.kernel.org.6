Return-Path: <linux-kernel+bounces-252580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 073E793156C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 15:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AD2E283907
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 13:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8FC18D4A4;
	Mon, 15 Jul 2024 13:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gByfCWMu"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F40318C33F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 13:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721049064; cv=none; b=uwIybvqZsX3zLehECE7wddDSUdcvddX3qGBfmvx37Ywy9gDpavJrChMYfDQrSxn8QfejbubhrrrAGIkfgD60bAWWHZu8SMvZkiFnrZI3gKUCgrGLZkFqN17QMUwo6Aa3s7jZTM6lySEa8Iw1IKj8H9yLnXpDALiy+YalnCSkQHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721049064; c=relaxed/simple;
	bh=QOmrlh86HNBabKQAYhgfGUKbP84IU6qGzPgWb0wPX64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WgcIqH1BhOwdjJT7G4BqYbWcYZrVUk6D1wN0vSsxamKhTIcGjPGuQ+n9q0xhgbFjUupUwEP0Ov6R+DFIjU3HVVBofQLSqQHcAmOHLGbNwO7h894BZD0uKEJXOLNGZ/atLEcxtaQ/EJtsuM+2R/s1kWgtAQUyveYCiiI6huLJ31Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gByfCWMu; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4266ed6c691so26897665e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 06:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721049061; x=1721653861; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CccdwCAsE/kNApiEDZLKr3tDI54YdE2r4/ctaUuOXYQ=;
        b=gByfCWMuLwR6mgICy24frGgBfMsWvmvLjlYw3UNzi4uZx0XktLiSqPRMQzJ8DKtgb3
         TF78+1bIDXH6Ms/8HcK+rUWG6GwgsqE29SvJvvg6BpAxyZ/YIUP4bCWPRL5oPwCydFSf
         bKruXNrvsLDfFt0prsmX9lHNNwYLGW8kDsjPUVvOz3m4F/j+3HFMskI8j6GML2FFoUTk
         yT78ibJkGIUiX97sZOGgxL1eFDoPf7bshYLQzze3xTx3fE3I3PpPbeYlXxoOSpxXOZX2
         ESdHgGIAfrdGPotEqtIwWL21wg7GMyuqLzj9Ue6kIbWtTOTX0tSJNFvHT9AdqUm/IXJG
         f7NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721049061; x=1721653861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CccdwCAsE/kNApiEDZLKr3tDI54YdE2r4/ctaUuOXYQ=;
        b=AY3U+8VkfewyLx4DRLC2stMQTMA5GsvRiN/lBsKPxWV6XQkJQpi/0EiHDiKvlWTar0
         zt70QFRk8hoqJZQ2NxyhfIPWJU1TARridN3UqIURZAb8UTk1rZX1iKF5t8njxc5EWRRQ
         DwIje+qjZ1KdVxg3K7r05hHuB3AIu39rQuf3Y0QpqB7mJoAocNV+tsJ3QmgyGPkSbu49
         ub4N1qliDMnhJa5ORgjd89w8nZLbauEVVVylR0DBojZVuuRkEfPg+DRqJPkHeWGGnrMl
         85Zvp3PshcMMXrU5WDuAMUzQ3FVEeZp6lozIjkDpOr8BgnETMjYM2CbU7mec6NfbedIJ
         7w7w==
X-Forwarded-Encrypted: i=1; AJvYcCWSRUEgrsqniOHC103B7G4W+MVvRpQJEV1aEDGCr0gGAM3z/xkvvRvz3/JA/C2DAO6SoaTQE8OtL9Bd/nbwdwg+K98aASDfIBklUiFE
X-Gm-Message-State: AOJu0Yw5Cfi5ZDiBcDTBEkizHwIoJwlaW4iwYf+4TC+ULP6SH6ewZaDE
	ktXAmNP/XAKAzAW9ui1HqUTIGX8HyrL54CQOln7IfXZBVeQy6fsWVsHMyhKnGko=
X-Google-Smtp-Source: AGHT+IHxl518O6ITVCk9V/YPVUHaWCVxMHpCeykVBPqlp1eRMIDm6iZ4oNUH532REJXAAfP1dtKMXw==
X-Received: by 2002:a05:6000:50b:b0:367:980a:6aa with SMTP id ffacd0b85a97d-367ceaca978mr11732523f8f.54.1721049060962;
        Mon, 15 Jul 2024 06:11:00 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff1f:b280:82fb:4328:f644:289a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dafbec3sm6389737f8f.85.2024.07.15.06.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 06:11:00 -0700 (PDT)
Date: Mon, 15 Jul 2024 15:10:54 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Abel Vesa <abel.vesa@linaro.org>, Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v2 2/4] Revert "drm/panel-edp: Add SDC ATNA45AF01"
Message-ID: <ZpUf3sUz8zWWHhPI@linaro.org>
References: <20240715-x1e80100-crd-backlight-v2-0-31b7f2f658a3@linaro.org>
 <20240715-x1e80100-crd-backlight-v2-2-31b7f2f658a3@linaro.org>
 <7daa3c0d-cecf-4f50-be32-ae116b920db0@linaro.org>
 <ZpUcI3KkIa58zC55@linaro.org>
 <d1603248-afe8-4594-9e2e-81ba208dff00@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1603248-afe8-4594-9e2e-81ba208dff00@linaro.org>

On Mon, Jul 15, 2024 at 03:01:57PM +0200, Neil Armstrong wrote:
> On 15/07/2024 14:54, Stephan Gerhold wrote:
> > On Mon, Jul 15, 2024 at 02:42:12PM +0200, Neil Armstrong wrote:
> > > On 15/07/2024 14:15, Stephan Gerhold wrote:
> > > > This reverts commit 8ebb1fc2e69ab8b89a425e402c7bd85e053b7b01.
> > > > 
> > > > The panel should be handled through the samsung-atna33xc20 driver for
> > > > correct power up timings. Otherwise the backlight does not work correctly.
> > > > 
> > > > We have existing users of this panel through the generic "edp-panel"
> > > > compatible (e.g. the Qualcomm X1E80100 CRD), but the screen works only
> > > > partially in that configuration: It works after boot but once the screen
> > > > gets disabled it does not turn on again until after reboot. It behaves the
> > > > same way with the default "conservative" timings, so we might as well drop
> > > > the configuration from the panel-edp driver. That way, users with old DTBs
> > > > will get a warning and can move to the new driver.
> > > > 
> > > > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > > > Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> > > > ---
> > > >    drivers/gpu/drm/panel/panel-edp.c | 2 --
> > > >    1 file changed, 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
> > > > index 3a574a9b46e7..d2d682385e89 100644
> > > > --- a/drivers/gpu/drm/panel/panel-edp.c
> > > > +++ b/drivers/gpu/drm/panel/panel-edp.c
> > > > @@ -1960,8 +1960,6 @@ static const struct edp_panel_entry edp_panels[] = {
> > > >    	EDP_PANEL_ENTRY('L', 'G', 'D', 0x05af, &delay_200_500_e200_d200, "Unknown"),
> > > >    	EDP_PANEL_ENTRY('L', 'G', 'D', 0x05f1, &delay_200_500_e200_d200, "Unknown"),
> > > > -	EDP_PANEL_ENTRY('S', 'D', 'C', 0x416d, &delay_100_500_e200, "ATNA45AF01"),
> > > > -
> > > >    	EDP_PANEL_ENTRY('S', 'H', 'P', 0x1511, &delay_200_500_e50, "LQ140M1JW48"),
> > > >    	EDP_PANEL_ENTRY('S', 'H', 'P', 0x1523, &delay_80_500_e50, "LQ140M1JW46"),
> > > >    	EDP_PANEL_ENTRY('S', 'H', 'P', 0x153a, &delay_200_500_e50, "LQ140T1JH01"),
> > > > 
> > > 
> > > How will we handle current/old crd DT with new kernels ?
> > > 
> > 
> > I think this is answered in the commit message:
> > 
> > > > We have existing users of this panel through the generic "edp-panel"
> > > > compatible (e.g. the Qualcomm X1E80100 CRD), but the screen works only
> > > > partially in that configuration: It works after boot but once the screen
> > > > gets disabled it does not turn on again until after reboot. It behaves the
> > > > same way with the default "conservative" timings, so we might as well drop
> > > > the configuration from the panel-edp driver. That way, users with old DTBs
> > > > will get a warning and can move to the new driver.
> > 
> > Basically with the entry removed, the panel-edp driver will fallback to
> > default "conservative" timings when using old DTBs. There will be a
> > warning in dmesg, but otherwise the panel will somewhat work just as
> > before. I think this is a good way to remind users to upgrade.
> 
> I consider this as a regression
> 

Personally, I don't think we can regress something that was already
broken. There is no point in continuing to use the broken state - it is
rather frustrating if your display goes off for power saving or suspend
and you cannot get it back on until you reboot.

> > 
> > > Same question for patch 3, thie serie introduces a bindings that won't be valid
> > > if we backport patch 3. I don't think patch should be backported, and this patch
> > > should be dropped.
> > 
> > There would be a dtbs_check warning, yeah. Functionally, it would work
> > just fine. Is that reason enough to keep display partially broken for
> > 6.11? We could also apply the minor binding change for 6.11 if needed.
> 
> I don't know how to answer this, I'll let the DT maintainer comment this.
> 
> The problem is I do not think we can pass the whole patchset as fixes
> for v6.11, patches 2 & 3 could, patches 1 & 4 definitely can't.
> 

Fair enough, I'm also fine if these patches go just into 6.12. I think
there are no changes in the patches needed for that, the Fixes tag is
still appropriate and I intentionally omitted the Cc stable tag.

Thanks,
Stephan

