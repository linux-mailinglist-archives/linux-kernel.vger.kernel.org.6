Return-Path: <linux-kernel+bounces-314994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D1C96BBDF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C2DB1F26405
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 12:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4470A1D9330;
	Wed,  4 Sep 2024 12:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H1H4sKvM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F3C1D79B7
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 12:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725452315; cv=none; b=Xt+PQKC1lvoLnAXNHpU10Iggs46wzMBVvNspw/+3w+CNBldWdDFhXkzmV0pska9WGVX5Io0t4HmR+ZU3F6wk9R11qlJRBiDAqWWAeS5iMP40PlUnpBD0zEUzoPKDzJyqonYZ+KfqOV1b5D1mtCXICn0kmNedySWV4mzM48K/7UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725452315; c=relaxed/simple;
	bh=aDfOCfO2pRprM4ipOkB4bYUPfKw3QrJjVh9Hmr4gZGk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=juvTMafx3ZMDhYYcN16y93Z01cRePcPp9SLd4g1W5THmqMBx+H7i9IrOt85rydOU0xttp+gWxZjvYPOqnz2o+SEA6htN3k64ydnPDyevmXdUNEaNeYdGKK1BO/GaqF7Ug1SfWvL74d9ZvWh3CVLJyJI85rHGMaoPwXUZcFTYg2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H1H4sKvM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725452312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ff0y4X+QVhf0p/VEjOvJFSOlimmYM5QTv85PADhlasE=;
	b=H1H4sKvMqFB4fcIV38aTvch2MGJ56EE4CQENI/83Bwzy348kYHT+FB1RtlSKR2iqAiTLdj
	11cnbjEiCMeTlGbPW+YveDtbuXHLrTfGQRT13fzXf2MJhtQHa+bXrja4uv/eG+IEUbEQk6
	Y9oR2/dyK3YrOh0wGneI5BSnYzV2obQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-aWGYhaXKNGibeVw4T7qyNQ-1; Wed, 04 Sep 2024 08:18:29 -0400
X-MC-Unique: aWGYhaXKNGibeVw4T7qyNQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42bbf928882so45464535e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 05:18:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725452308; x=1726057108;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ff0y4X+QVhf0p/VEjOvJFSOlimmYM5QTv85PADhlasE=;
        b=jF2Ctx52jiR3nCRnCtnVpUQoCyv1fNlNmcITxLbzx9Qb+Tg8tmVSC3FOWCUEpWyHbt
         EJLYmbFGlG8qc/cM5WnLsQVs2ZHfT9bSUPHKJY+Bd7ydKB9voO3zBurrvC71yV+ohrkw
         gmibjxr3r+7kNquX9UVZPUW7YCRUuULMa5oUVIgqufEhEGulqwlEQp5V3osmE43FW/JL
         KzVAVPc4hi8kiZ11aPALtOOANT5EXDJvSNYKojqURpxIIlZnZEU7zph2f5Wf/+CaygQt
         BWp4Hhuxqz6DMVc8PV4k69TJk2AIBvZNi0pqR1BuV5W4ySFVgP36sPfMZykQi/6zM5E0
         zqOA==
X-Forwarded-Encrypted: i=1; AJvYcCVrE58nBHO3iEgGF1qQY5/JGWn2NCvhTRd++lY8+cyrVctUJePNarQMYuLFuMfAun7Iu6VZaWLpCChE8Cw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw/FDG8hYqr9qhVNvzbe8rc69hL0bsH1GrsR43PxajhJgJCQlT
	6xRC00fHudeZy+Z8V88E7BnFOlvo8/UNbf7uZS57i1gahBarIGMpYiHP4omhSi21E0x/Qw6ECDH
	a6tf46mKm81b3JQgI4G+fVqN/FOohn3W0+rGVJXLiZoC8SBR6Fj0Vpl9NVvIJxw==
X-Received: by 2002:a5d:5484:0:b0:374:c45a:8afb with SMTP id ffacd0b85a97d-376dd15a9c0mr2962478f8f.19.1725452308149;
        Wed, 04 Sep 2024 05:18:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFM58SacVW6qB3OGbwInnBlOw+x1XdCaBLKOjGAVJ7DXNTIXZ7mf0D4cAdkVzP6Q8BUhRUNrQ==
X-Received: by 2002:a5d:5484:0:b0:374:c45a:8afb with SMTP id ffacd0b85a97d-376dd15a9c0mr2962449f8f.19.1725452307586;
        Wed, 04 Sep 2024 05:18:27 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374ba30d5b8sm13069521f8f.15.2024.09.04.05.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 05:18:27 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Abhishek Tamboli <abhishektamboli9@gmail.com>,
 neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 daniel@ffwll.ch
Cc: quic_jesszhan@quicinc.com, skhan@linuxfoundation.org,
 rbmarliere@gmail.com, linux-kernel-mentees@lists.linuxfoundation.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, kernel test
 robot <lkp@intel.com>
Subject: Re: [PATCH v2] drm/panel: hx83112a: Transition to wrapped mipi_dsi
 functions
In-Reply-To: <20240903173130.41784-1-abhishektamboli9@gmail.com>
References: <20240903173130.41784-1-abhishektamboli9@gmail.com>
Date: Wed, 04 Sep 2024 14:18:26 +0200
Message-ID: <87v7zbboj1.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Abhishek Tamboli <abhishektamboli9@gmail.com> writes:

Hello Abhishek,

> Transition to mipi_dsi_dcs_write_seq_multi() macros for initialization
> sequences. The previous mipi_dsi_dcs_write_seq() macros were
> non-intuitive and use other wrapped MIPI DSI functions in the
> driver code to simplify the code pattern.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202409040049.2hf8jrZG-lkp@intel.com/
> Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
> ---
> Changes in v2:
> - Update the commit message to explain the reason for the change.

Thanks for improving the commit message. The change looks good to me.

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


