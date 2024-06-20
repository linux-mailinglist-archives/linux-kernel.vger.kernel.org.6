Return-Path: <linux-kernel+bounces-222884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EE2910923
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C49551C214AA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 14:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308311B1416;
	Thu, 20 Jun 2024 14:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C6dL2nQl"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266381B140D
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 14:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718895387; cv=none; b=H5ISG9naJtEPSfD2SfBqINAX5kxVHJ1yDNlfopTrJG99FWYXB/WwA0JPSvPVkCFAWME7gpaAHN49OauIfJrmo8bsJqnV/f3vHcTfIj1D+a98PdVmNfYarcTg0MGHEov3m0V44cP3oQXu3Zw282g8pjAqei9lb0zzt4CM/OQtjTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718895387; c=relaxed/simple;
	bh=og0uhEaGRnjHIeZZ+4t2qH0VJYHDPegPVDBAqTISp4Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Hx7r5tT3h2GS4cq8zdY9k1ZVKhSOGj4c6U7JJjl4aEwot9zgJ3c5mxFvq4F8qdoEDVhSGf6JSDiuCMns7Z0Zm/9k/g1CTlCwhEAKipXm/x8Ajv0Uye9EK+cPz6WGlgRcqqnQpVzlLPFzIBnHexIyAluR7mnzlEC4LzR4w40Rj+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=C6dL2nQl; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f9885d5c04so8919355ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 07:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718895385; x=1719500185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G9oSfSdf1z67I0KtQRjOtLB51pCoRgY/UrBbJg+NXAY=;
        b=C6dL2nQlkEF/cGFVvGJz1MuEOW7lgd9o7oKYXxXjj3Nzy22iykfv0PVKJrwvBlg7QR
         aTpoRIP7dG7CnvLc5ZGquAWdSCHNxC4VuOqTOpiN8JA0Y/NlSiOWXW4uuPMpnddRUlYT
         J+WOwcymDhWbu+1hi7PB8pFNP42/zszpTGbm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718895385; x=1719500185;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G9oSfSdf1z67I0KtQRjOtLB51pCoRgY/UrBbJg+NXAY=;
        b=bTgDbdwJEgB8Dg52Bb8iQZEnPd/4i9kZIYF7893BXoNY2muXnfUMd9OzLtCuOtbHDJ
         mcAz1H1aMIXCDTddzmc/feGNmKJJ68jdRNC2Eg8/XD/cVHiwAHaV2blpgKyNGTaq2JpK
         QJmv8FJlLGRH3siX7LteoxN/C0V3bpYI3yGxq6xT4qphVzMUE/HetwXtcH7MaUOxxv5d
         9v0q9nCiVk5OWaVMJprKwyt2LMJqObb8VGB5i2DKcxhF8e0F9e27SpMO3/8KP5s9p7GA
         crjdY+3+V2YbPXPmsCwMlSP/QgXj/h39Z8BBcW8k2cqy2D7LrOc5/EIn6CF/EEpX77yk
         nUqw==
X-Forwarded-Encrypted: i=1; AJvYcCXOOgQ1d7/+Or9ywO6oBiczqjQhBm1SCTCC02lRnc+v+xa3Kvpsc8/a9dHQNazKarWsqAa/iJBPafZ5JgdcL2aI3WyfzsrhiHOa2Zcc
X-Gm-Message-State: AOJu0YyFfIG1KKU5RQEXo3/ErnViW/nhXG/5faDnK9aiL3lQkL7Ag1TS
	AgyTxLFVx7IGeAIJzx6OYCuu+ym9ssjSHkcE2D+bfLAY9ApbMaFKjrZT9LVT1Q==
X-Google-Smtp-Source: AGHT+IGvWrm3Tv2FDZs0pJA9F4+SMsaHh0/HqnibcqOGLHKEUuScOl3L9viWc0DKtKRzX/yyt8s5KA==
X-Received: by 2002:a17:902:ec8f:b0:1f7:13b1:753f with SMTP id d9443c01a7336-1f9aa3dd88amr65229765ad.22.1718895385480;
        Thu, 20 Jun 2024 07:56:25 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:66d:f48d:817f:91ec])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e55e82sm138378885ad.22.2024.06.20.07.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 07:56:23 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, 
 Tejas Vipin <tejasvipin76@gmail.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240612163946.488684-1-tejasvipin76@gmail.com>
References: <20240612163946.488684-1-tejasvipin76@gmail.com>
Subject: Re: [PATCH v3] drm/panel: truly-nt35521: transition to mipi_dsi
 wrapped functions
Message-Id: <171889538321.1493372.4537499331018724639.b4-ty@chromium.org>
Date: Thu, 20 Jun 2024 07:56:23 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Wed, 12 Jun 2024 22:09:42 +0530, Tejas Vipin wrote:
> Use functions introduced in commit 966e397e4f60 ("drm/mipi-dsi: Introduce
> mipi_dsi_*_write_seq_multi()") and commit f79d6d28d8fe
> ("drm/mipi-dsi: wrap more functions for streamline handling") for the
> sony tulip truly nt35521 panel.
> 
> 

Applied, thanks!

[1/1] drm/panel: truly-nt35521: transition to mipi_dsi wrapped functions
      commit: c62b4fc4b9b86ab35e5c4236f2053ce21ee81ebc

Best regards,
-- 
Douglas Anderson <dianders@chromium.org>


