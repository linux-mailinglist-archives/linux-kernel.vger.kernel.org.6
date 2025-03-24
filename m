Return-Path: <linux-kernel+bounces-573295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CDDA6D557
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 08:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7992A1884199
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 07:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B22825745F;
	Mon, 24 Mar 2025 07:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TNjgYoIo"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C4D19ADBA
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 07:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742802217; cv=none; b=KugXEUvJeqqeN+R5+lv2AuBAKq3ft4c2oIeO+sw9i7eSl9IIr76ncAupLlrjg235/C9aMOQqsNLQTi3sW2aCOBphmbZZ2kyltajj1WTCeLJJutqD0rOTV8wcI1hw/T9g/Aq6bE6wN/vkcfssdtEvmyGhwbNIUV6GRWoSEt/Iuyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742802217; c=relaxed/simple;
	bh=Wja2HIkcCc/qn+fhg7yuV0A96iCH9nSXOnTIZdyzsNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VyfaqQb2cbWh+gz4zrOxERnoonCkuJjWa0sxWrDCTln5m9IYVYu4vdzzWermp128lBs12p+nVdHrysNpKwxSc4N4Q4K+547murt8QR/XIM9vlOENfs4AL1zb2MixMjYA2oMWs57QNLb79ERpLjXiwTs93icf0NIPtUJTiSCgF4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TNjgYoIo; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cfe574976so22103985e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 00:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742802214; x=1743407014; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ENeTUflag0l1WgJ9MraeaFTIx2U/M6/MceOO9Gs6H40=;
        b=TNjgYoIoyymn/4+AglCvAOvp4FaS/0FG8fA9O9PbdR/7fN9vrgyJjmc/SPY3lV8xlr
         8/joueCTVzHixOvZN6frHL4ivVU/SsOsdNrawpEFsfFJX8Ye8aa8whkthKUs7mLen5w7
         /mdFYAc64y6rOx7U4HGM27lvHLIqdGhs1KN61LnUwG7/Iil9yo7MSDHqhru4CPTbSyxm
         RpZs9KA1TUh9A4GU1yGOuOJpeW7Myd7x4gsr/5+lo1M29K44IQgunwSBxZL1x3ZTX9wX
         Qv7ykq1CMHn/DbwsVw006bHR3pW2kLj131sRb06ODHwzJRUyO15uRXw3eHQFKCLX66Fe
         mOYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742802214; x=1743407014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENeTUflag0l1WgJ9MraeaFTIx2U/M6/MceOO9Gs6H40=;
        b=l53dlOxjcOB0mOBuFHUw+SO0Vwnl0cBeEFQQL+F3X4PPXtgcG7/BPyV8m5BsQr/E/m
         mJnwAVDJKqeA47IDdP20kRjKaV1h1AytNME0c2GIoescGe09dZFRUTA/ziwfIxX5lMLm
         IqL/99SvgdRUjF2Db3zSL7nLyqJn9TIbfEnWt7BiqeoMDA6vK9NVw6+zpNEDxdiVi4UM
         rE8p+g+onm+2hGEV/fiJVa8QwK6WX1IQgGmKCLlFQh0uQIKIexs6SoJqooB/BbuiP9Uz
         BOxFKDWrGnDoHb2ZJfIzWWoRrgVsFJZJsfh256JojHuhzZtgTgZyiKJA6T+FW5Ngesw+
         AfDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGWaHQiRagr5KDqCBVMO4wz/sHKJRPdPB6DCvKIPzyQW19cpNOK08AtEpHr2o8gn1KFimzsVo2uPe7kCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEAqlrjYoAmvP0htbxCirzJ9G11IrL/zCM9OfY/ezPVVemxke6
	UjsNU7OAQgWpzxYSm2vbtrINfgdMbOP3qpyKl1c3fjdViWwlTkJjuo98e3mkrbM=
X-Gm-Gg: ASbGncu0hxFO6R6sGkg9tafT+kUHuXTIuxi9vWHEClsugYSsZlwTxPXsr1i9zPk161y
	bhWcvKNs7Hbr76aiZiVimi+UV7TClzpahAKXs6ShbM5e3ky5kk7K0qoIbkh0p3ffZG/oIXGpRdK
	QdjaucvDqvvurLg3p3gCLJ1UGSJvDnEvnwKAOsOHOjvfj4SxRsnSehuMVIIhMNhh2C+OpHPaG8W
	nsl3QJLHR8UBAUR3BdKF0HFgUp9ZGuJtslTNK6xkHTVYkR0zggYHxLUXP8k7CkUsv4b9Lgqn/LO
	/jfZoO4FSw53N94WaLQNM+K2Q+IxuVZY5KxWW8oukMPShai7hg==
X-Google-Smtp-Source: AGHT+IGmGmS5ufUfMSrgfk7DIRjiH+iIQAHj6POw/bNjEYZrqwMBfch1zIjXMn5LOd+CGNnKdNiELw==
X-Received: by 2002:a05:6000:2a2:b0:390:f400:2083 with SMTP id ffacd0b85a97d-3997f89a039mr9195803f8f.0.1742802214396;
        Mon, 24 Mar 2025 00:43:34 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3997f9eff9asm10311692f8f.92.2025.03.24.00.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 00:43:33 -0700 (PDT)
Date: Mon, 24 Mar 2025 10:43:31 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Qasim Ijaz <qasdev00@gmail.com>, linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	LKML <linux-kernel@vger.kernel.org>,
	Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Bo Jiao <bo.jiao@mediatek.com>, Felix Fietkau <nbd@nbd.name>,
	James Dutton <james.dutton@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Peter Chiu <chui-hao.chiu@mediatek.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>
Subject: Re: wifi: mt76: mt7996: avoid potential null deref in
 mt7996_get_et_stats()
Message-ID: <d723d5c1-ed17-41b8-9bc4-274fd8e2b615@stanley.mountain>
References: <20250322141910.4461-1-qasdev00@gmail.com>
 <d1df5d97-4691-40d4-a6cc-416505f35164@web.de>
 <92d1a410788c54facedec033474046dda6a1a2cc.camel@sipsolutions.net>
 <CAAMvbhGrJ9b3Aab9+2a5zmvEgf0GZFmHLCC7Hud+egUE28voHQ@mail.gmail.com>
 <223c7280-443d-49b4-96b2-90472339dcd4@stanley.mountain>
 <46a53498-6c20-48fd-b090-02163baefddd@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46a53498-6c20-48fd-b090-02163baefddd@web.de>

On Mon, Mar 24, 2025 at 08:33:39AM +0100, Markus Elfring wrote:
> > Also the "phy" point will never be NULL so the check should be removed.
> How many tools can help to determine such a software aspect with
> inter-procedural analyses?
> 

You can just review the code.  There is only one caller.

Btw, it's fine to have unnecessary NULL checks so long as they're done
consistently.  Generally, we prefer people not add unnecessary code,
but if it makes you feel safer, most maintainers aren't going to nit-pick
you about it.  If you are doing the work then you get some say your own
code.

regards,
dan carpenter

