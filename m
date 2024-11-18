Return-Path: <linux-kernel+bounces-412461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDB69D0944
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 07:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 887401F22649
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 06:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29529146D59;
	Mon, 18 Nov 2024 06:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h1O6cVvK"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C533126BF5
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 06:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731909811; cv=none; b=tc0BYXPc3NsXu5EGr001pdeqRRqCiOXvd+aNfHD0xfRNoEdJfak9GuTJYxxBr/OBSHu906R97FPBDfQwAAXfZ8sM8IkEtXmC26ubbkSxzg7iC1zrRRcpDgiAcl44gW8rJiojpvVoibYFAJLna+Bo6+JdqybMkp2qXaSr3+uLpLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731909811; c=relaxed/simple;
	bh=4BAXl/N5qs5x1KD1SM9rYhuStYyPUTHtfJIvrbnxABo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oK+FfiG/9x3eNL+TN/uW3vOjHLgabebDt+4fbtbEYZiEu58Y7MVgd6A93eztNPVbuUumVvc3wX9wUgGLXKmtlVjVJp6BC8EmHvfcLBzB46IEjRFAySK7tMKrwpkKYG1T3cQtbJu6cOmCowc8k7hHcC4IQRXk+JJMTa7EaXnxWGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h1O6cVvK; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4315df7b43fso33078375e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 22:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731909805; x=1732514605; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AR8vRiyQWafhkwLMuApVW/fxma/Zo6ed3zIRAdgzhAY=;
        b=h1O6cVvK6aOIMYaUWJprIfXU8YVaS2b3GxbNg/wa1glq40lKAnNvDEFZLYoyRym1A+
         eEoX30YAmEouelMstFimJmFcpUs7hDyVBjMAjuhWUgOPoNBwlPQC6hOHuDFcL+SLCRAJ
         QrCOAMVoL/Mz6vwSrDFRt2aqDMo2L8qZ1osUoPgfHn9pR4xqVWgVGkEJgyPsn6I2gpWA
         EtVBM0CSJD09rajrVnWOsmMqKeTnmu6m4XumK6kYW6s6IlkqJvEiLs9kPBB7XCOFDQFB
         syKEIB3lY4BR/YGuB4Va5/QWR2MTiGja+m6tM1RhmzopuTcJ1aiCaWLEKcwmSo/P5twq
         bWEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731909805; x=1732514605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AR8vRiyQWafhkwLMuApVW/fxma/Zo6ed3zIRAdgzhAY=;
        b=nC9TZGcFNuoCIlxUCTAjQzmDl/+H8w5xoRFVzTaCsFcgHyCdrNf08nX201rCefu+IQ
         5SDh41fWiVyC20v3vxRGgul4Fdyrqi8Do+f/fdvsjrxv3gI3E9dDqQndo3y1EIxDMRG2
         gk6O4Jfa+LKAVjH4LGuKKtjeXEy6b9U1Ud98sWPgWWsdOvLA858vIGNP1Ztb4DMqxkwA
         98T+zlPzVBjm16ZXLQHWDvV2gUiLM8MwldYG8tjarSacDbclLjO7IAfyXGwnPnQFKVyF
         2+XzQZknnrDMsvWy6V2BD5m0D6vcUicH0gHokA36hz6mZ+e7O3RlLv3VYxLLM6OsXOrx
         9mgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMgVQJKEOLBWhvd7MC2k3KhTbBaMlsjgzdvEq0kLtl0udsufdNuX40LrJVvueGszrUwinXyx+95wiLkq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFnJRUrjbORpgjovtuqSCPWrmVpgzsyAidmy8PrbBQtsNoOCv+
	cI8f9utSrkDOaiDfNm2L8LV6EeIZMEf8oSB1uFT7Lep++J0QSzftuWVz+B8EzVY=
X-Google-Smtp-Source: AGHT+IGbozm5imyvI1diBD8cPltGKKe70Wh5xUrFEtI3IIMcZHzRvhf6hhocFPZiJAaaikEibw1ZfQ==
X-Received: by 2002:a05:600c:1382:b0:431:5d4f:73a3 with SMTP id 5b1f17b1804b1-432df74f0d4mr84755155e9.18.1731909805553;
        Sun, 17 Nov 2024 22:03:25 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3823ef97042sm4424753f8f.35.2024.11.17.22.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 22:03:25 -0800 (PST)
Date: Mon, 18 Nov 2024 09:03:21 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>, Kalle Valo <kvalo@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] wifi: mt76: mt7915: Fix an error handling path in
 mt7915_add_interface()
Message-ID: <98b8f06d-e8b7-4a49-8508-ea87c385bd30@stanley.mountain>
References: <b9d8fbfc19360bfe60b9cea1cb0f735ab3b4bc26.1727639596.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9d8fbfc19360bfe60b9cea1cb0f735ab3b4bc26.1727639596.git.christophe.jaillet@wanadoo.fr>

On Sun, Sep 29, 2024 at 09:53:40PM +0200, Christophe JAILLET wrote:
> If mt76_wcid_alloc() fails, the "mt76.mutex" mutex needs to be released as
> done in the other error handling path of mt7915_add_interface().
> 
> Fixes: f3049b88b2b3 ("wifi: mt76: mt7915: allocate vif wcid in the same range as stations")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

This fix is still required.

regards,
dan carpenter


