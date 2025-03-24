Return-Path: <linux-kernel+bounces-573175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A62A6D3E1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 06:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FB501693C8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 05:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829CC139CF2;
	Mon, 24 Mar 2025 05:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iHycOaRX"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6B22E3392
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 05:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742795299; cv=none; b=WtDH0OgYOWDM9y4l1ZDZdrb3+ieMlKp4isdxxuSGcn2Vco3jsQSjwIdS9NkAqj8FsPyN224BJELfZnmy+un1UQOdukDhhhx5e6Am+neLCT8OBTPdugAzbU6qTCCJD2ggS2a3oTM2duYF4s55bTzRC+87p9Rdy8N3ibsrTq7eDWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742795299; c=relaxed/simple;
	bh=hFzwVsvlTm6FzsGdNshq6DKl0QckI85JLKWYGluazmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gvcFYkvobZ5uvVsC0dPNscMChwj2qHdtmmkceyAR6SZg8ErX3INCRfG+G6h0q35AVvHsnuvFSVDZJbN3CNwKq7zRsgcl0MrdbKgeSFarIVWQamVmtuisPKSrnYCkEp5yjHvDFoL6IgQ+Z/igGHohONPpnG0nWmS3mdBoOAFS+Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iHycOaRX; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-223fd89d036so71359555ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 22:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742795297; x=1743400097; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/R5x+1WOSlr2ATn0vFw3CXpQGRrxOjJ4eIn39P6K6yc=;
        b=iHycOaRXVSPS6yb6dEnf8W+4Q2WsAdhBQ1hpvlPa66apUY1Cuer/vKlWnnA6o2WZoT
         Uj/FI2HxeO+UnG9zHWSeLELuILRARVeXysqWha6+l3lQ4LsK3h7qnFz6ZxH7aP9DNRzx
         l8dOc9zbP+5MlASmu2XIC5FHv8xAMdq3NGHsnFwYMTiO86/gJfpmGkb3Ty/rQL2Pk13g
         7/YwgFdZ+f2BxNRgKRfW2/akKT6KOAJkg8Mcto0D5GnPSgHNGPwew0JkdIIXC36ItNke
         Szjw/Ku3NCMjbwbYX+tsuUYlSjnwW5t6fjzZz+ChfJd/wTP65DI/yGqjE3XCaWIR3hHA
         ucPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742795297; x=1743400097;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/R5x+1WOSlr2ATn0vFw3CXpQGRrxOjJ4eIn39P6K6yc=;
        b=E1yCy0rX4WTW1/B87e9os4sq0O5hXPo++zbaMiTJ8xkfE7Kyh7zTvphGa8Oc+hZIqt
         /Wv1bBSabj8fwRu78mz9HkyQAdoECgXz+SA4MobSmpFtOIENMvAxjI5dhskrJDPBCaas
         qzxJm5BZB2b2yt3nsHYrUNZYAEs5M1iHlaL34y7lN/WKcEuCNH/omCiKdb5DXVWD0aHC
         V44k3PagJngjY3HI4Qke0zCFztcOHep6Iv8JYTmDJJ5Ut5EEuI9djyRQDH5pNxXMRyCD
         cxyik9KdapxG2OKxBFu7MLrmNGO+HDYGMepmsasuD3YoXKxhEBE+X+NMmdmDnyLMaO0y
         8xYA==
X-Forwarded-Encrypted: i=1; AJvYcCVMlG29fNqMQLy3zb9hJ3stJ2W4ullpEl4MlBOvsK6rRBMK9M1gtLy/5ZdZjbcUHYOL0I5ImZmCIjb0o2g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk7/rGaiv5yCXsLIEZRJEZbsdKrEt6xaq9nv1zL4j/zMpFIvog
	5w/KiLK/MBeaUPXBdM8fZMrADXjHz3m8epRDkL/dxs3B87cto0Ie0kantl/7zVqJO2+ynRU7yoe
	v
X-Gm-Gg: ASbGnctz2Wf3xM4Gw5PtvzY42fcSYjotpaFI2QHFxVTtmIb3iCryYWGphRmOccpFOCf
	ZKgSY5RvOG28TkdULUEOrcz6sStnuQtAPRIa/h/tQIYltphH3WWIQHDHrZFnxHtABIaXbQUrpFp
	ZC44To/KJiNoTN4EGgpVkZeDHqj208+lZ9yP5JVcBF0xpMCMKWvWj4u2WhI4e4p7J3kFjYJF8+x
	qF4midzLmg7YsRP83i+2LPb0cDtiADA6zIR7PE2v1DU+rDltjSrk45Tzhfa5+6z9Az+4nEryheR
	bNJfOSKmOXXXVtDgwd5oT0tNxtrxYqPT3lvjDb0Illkpjw==
X-Google-Smtp-Source: AGHT+IEjzOfTYFKH7m9L7KhblERHs6U5SD2x2kJlkL36nq/EuBvZ3tJQu+dClNO0tHh2wUcONaNzMw==
X-Received: by 2002:a05:6a00:b4e:b0:736:34a2:8a20 with SMTP id d2e1a72fcca58-73905a2300cmr18173268b3a.21.1742795296466;
        Sun, 23 Mar 2025 22:48:16 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73906158ef2sm7170982b3a.141.2025.03.23.22.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 22:48:15 -0700 (PDT)
Date: Mon, 24 Mar 2025 11:18:05 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc: Yangtao Li <tiny.windzz@gmail.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Brandon Cheo Fusi <fusibrandon13@gmail.com>,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: sun50i: prevent out-of-bounds access
Message-ID: <20250324054805.3x3nwl4vtvf63rwj@vireshk-i7>
References: <20250320155557.211211-1-andre.przywara@arm.com>
 <2772067.mvXUDI8C0e@jernej-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2772067.mvXUDI8C0e@jernej-laptop>

On 22-03-25, 08:38, Jernej Škrabec wrote:
> Dne četrtek, 20. marec 2025 ob 16:55:57 Srednjeevropski standardni čas je Andre Przywara napisal(a):
> > A KASAN enabled kernel reports an out-of-bounds access when handling the
> > nvmem cell in the sun50i cpufreq driver:
> > ==================================================================
> > BUG: KASAN: slab-out-of-bounds in sun50i_cpufreq_nvmem_probe+0x180/0x3d4
> > Read of size 4 at addr ffff000006bf31e0 by task kworker/u16:1/38
> > 
> > This is because the DT specifies the nvmem cell as covering only two
> > bytes, but we use a u32 pointer to read the value. DTs for other SoCs
> > indeed specify 4 bytes, so we cannot just shorten the variable to a u16.
> > 
> > Fortunately nvmem_cell_read() allows to return the length of the nvmem
> > cell, in bytes, so we can use that information to only access the valid
> > portion of the data.
> > To cover multiple cell sizes, use memcpy() to copy the information into a
> > zeroed u32 buffer, then also make sure we always read the data in little
> > endian fashion, as this is how the data is stored in the SID efuses.
> > 
> > Fixes: 6cc4bcceff9a ("cpufreq: sun50i: Refactor speed bin decoding")
> > Reported-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> 
> Thanks for fixing that!
> 
> Reviewed-by: Jernej Škrabec <jernej.skrabec@gmail.com>

Applied. Thanks.

-- 
viresh

