Return-Path: <linux-kernel+bounces-296335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D246595A963
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 03:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B95BF1C22D1B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 01:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B324A79C2;
	Thu, 22 Aug 2024 01:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FtctVcKy"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2E51D12E1
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 01:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724289320; cv=none; b=BtPMvjFUDMrytzSoYYO5MIIIhw/aMvo36V0gz9MZZNwQ+PRKOr4AK/hhmzqiZdM78n7uLZWnRy+xYNcRDF0cfU55xB50NiqyBlRtXlOTYykCJkf+NUYRWJI2H/Hs+lRIGTCFVADlakbNvDirAt2Oc9viYDi9m4mscl+HW6M2GeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724289320; c=relaxed/simple;
	bh=BkPMs50zZc13AIm05w79Kkl6L8vilNFRPKZV7U9hmTE=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=nQ4KT2n6QkVTC1k4+5/VbU67VEZupugadTD9x9nJpYhqp3ooBzjyQ4ILz5CUMcCThmbA7Of7bHyrBdMtbCEZ8g38/dC6MyBAgWKx9LtjCbtqTPWMLYguqcMzURqyBkMdT6TIf/dFBrZT5h+OTyc1n7WYiDKwQK1rzZHTDtA7tVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FtctVcKy; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6bf89e59ff8so1163276d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 18:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1724289318; x=1724894118; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/yhTGH7B+0bIS9/Xf7YTxbX1d8basfp6eUrsQRQNnPQ=;
        b=FtctVcKyxp4m6jS23HJopYF5sHwVaOuQRc4oXoNO9hunOhBawhE8m7sqnputCIdtpV
         i6yCkeZ06ntZWNasOSrUpkpu7PhUc/3lFGC4Q1PodwyyDc+enaHSvthmezDHtWOnLext
         czfFnl8K7/7pUnC/encTO9gHBzI27WfXQ4TEcftdSd8NylT0HqiSCxfDPIMPfqAjVw/b
         ctNiilJgU6+84QCR8/mRYpQz4zqeuj2h6LP56cQHZbkaMHymoeXOGXBe3Sax7yDOWJrn
         H4419+Pt7PuqVXBSwu6qnkt/vIx4A/DfeSeziVQyd0atH3dsSa+/QA9mtBjyhumgAt8a
         IX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724289318; x=1724894118;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/yhTGH7B+0bIS9/Xf7YTxbX1d8basfp6eUrsQRQNnPQ=;
        b=KED/aL+xuUegPs9nKa4iEZRftzZRfqkvjOWykQCONnifX51vyy6hQ7ptCVhizNFszh
         bkFdVHmK3Qnr3IoG03T7fHInFSWXgUOKM5rjSHAzYJhR9hy8C5bGfrrXCesh7T67zPuP
         cRBEraBXb+OayH3jjK3E4aDjb27QFIaYCSpu9ypy7XA2Dj9pHep2ZccHTg/f4C1ZxwxB
         UWHXbTjq6dZ/beahmvy3+SMiEho2URbsh+xgfCvC29FIZttv6W4xwqxL9BS7iRFYZlXQ
         YzQ/9l0qWqDN7LPQsXlCkSmhs2DnN2uDrCbZtzbX3Gv4lGgjK4NQI0cnvuiDxH4TnkXt
         ki6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVAyUeSOqSaBa41JoNyCvCvmiHL4u3GwZwjXH3VaALBmDLg22c9xANM+xap6pxrrsQZvO5TmjRl72Fld0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMuG6/SFTfJ2m8mwOwuJK+lJxmeWRmlRxNDE7vcfnwarjW/3VR
	0cvsp6ep96rTBeKCox1ulGHXqY2HGibLFlhpQ8BDowarwEAO+n11Dft8GDDgMYurRUqcBxkU6Nc
	=
X-Google-Smtp-Source: AGHT+IFg+T2SWaUpA0ZTAUOuKnsncWSGUp6DTMp/CKzgv9Wbl2Lt9OAlx4XAVzNo9EwGAbX6FtnZfA==
X-Received: by 2002:a05:6214:3a02:b0:6b7:b441:8fdf with SMTP id 6a1803df08f44-6c1568b08dcmr40545306d6.56.1724289318129;
        Wed, 21 Aug 2024 18:15:18 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162d1d6adsm2491236d6.27.2024.08.21.18.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 18:15:17 -0700 (PDT)
Date: Wed, 21 Aug 2024 21:15:17 -0400
Message-ID: <99e5b2c57719f6e1ca0162e77a61903e@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Yang Li <yang.lee@linux.alibaba.com>, wufan@linux.microsoft.com, jmorris@namei.org, serge@hallyn.com
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] ipe: Remove duplicated include in ipe.c
References: <20240822003123.118140-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20240822003123.118140-1-yang.lee@linux.alibaba.com>

On Aug 21, 2024 Yang Li <yang.lee@linux.alibaba.com> wrote:
> 
> The header files eval.h is included twice in ipe.c,
> so one inclusion of each can be removed.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9796
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  security/ipe/ipe.c | 1 -
>  1 file changed, 1 deletion(-)

Looks good to me, merged into lsm/dev, thanks!

--
paul-moore.com

