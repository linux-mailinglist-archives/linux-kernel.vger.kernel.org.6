Return-Path: <linux-kernel+bounces-262933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8C793CED1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 09:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4208F1F223FC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 07:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEBC176252;
	Fri, 26 Jul 2024 07:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar-org.20230601.gappssmtp.com header.i=@fooishbar-org.20230601.gappssmtp.com header.b="jBtQzH9q"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCDD13C80A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 07:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721978705; cv=none; b=qkH6LdBxCpVNCwvpdsSqWkYdDCOfnACWh7MzNRbaPLdVOV0ipjjR3tccMwjFusHrHTe7qHPZrtg3TVe0B1z0Zi+oWIfQYMQ1lVgESHnJeH1mGjII+e2MESYDBcDIIbQqttwzhruPI/hJEXfwq2/ITYN9LCmkWLmPzN3Wdw4NnmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721978705; c=relaxed/simple;
	bh=avcZ0XeDvxhFCHHWnLz/cvRXaQLXwQeaSCVLcihXW2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b2BniqjBSdEK18CAH7LhN7aWVU+an//GhEiDLmxs69ZwT9+uIhSwwVKfd83pJGo8/sQY+g7L4fL+NwtBGSGIjMu8hnoo/E2rU2mbA5FA4o5lxViXbWfYbXizicyjK+hThycpcK6OMk7LJffu5tHa5lFQKYOlFpUZ4I62KB/FxtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=none smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar-org.20230601.gappssmtp.com header.i=@fooishbar-org.20230601.gappssmtp.com header.b=jBtQzH9q; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fooishbar.org
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-79f014a53b7so22997985a.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 00:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20230601.gappssmtp.com; s=20230601; t=1721978702; x=1722583502; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=avcZ0XeDvxhFCHHWnLz/cvRXaQLXwQeaSCVLcihXW2k=;
        b=jBtQzH9qBQ/uzJ2ypN90yc1MitrrF079QCQG49QFPrM5fXo2lLunbWaR7as9dyywqg
         YD2luWJsbr81ndqzYoaKOHZ1LI6E048HPInDdqdliu5A7t+quzxTlu5QwsABxTBgczmx
         +RVJdgwVDc8vBrdUhDBaPFMycprRFqlaQUfBORd2ZN5jTwZbmDHKG0GX/kAjcCLixnHU
         Jm9wsZYHYWTKpKXj82O13ZlT+flesW0u48hX1azRZpm0N7fJ9pAhkfXFu6vUTgsL4Gf+
         eXHXsZO5WXtyJNtB8knyl7aWO+dVV0s9Z4VLFDgWLjnmXn2710jkbBCm2pzwLTfr8Mf2
         PfuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721978702; x=1722583502;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=avcZ0XeDvxhFCHHWnLz/cvRXaQLXwQeaSCVLcihXW2k=;
        b=FfbmMU4DIznPesRGNsLyxhh4F53dvtFhFfsKuQ7Q02yt1LhydwSy+v8xNffa6P5t2T
         km+Kb9MkzWtpW9k+vUTPc6+qeVzQVmg8wQ1PlesSPb68Bh2d9DXBbxbCkad9TCAzd8Du
         /CcwlMWROaQKs7onGNzmNz1cGOpvdbGihnDNEkcojBld8RDGX60eUV4Lliw/fN+m6BMc
         ihTZwPzghYSZwRU0m8vOMyyoAZWuTLmSaKhZHjF7xjSELPJ/lzGYHT9JWNHwwKG0Lmvs
         NY72TmZ0jxYPGMwkdXy2i4nao1av8Kp5P1nGeBmk3y5mL61EG9x8vSq4KI4NBwwwyu0K
         QUEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCicoAGslCdVTbek6ISXq7Wm5lN9bW7IEmTOdlQuhWGQ6ejyDGZ6BjPMDUFlXHLESl7m2579qhitOX9+smJs1PVLsxHrEDgvsgUDFw
X-Gm-Message-State: AOJu0YxX1Z7Ee4P33dXKNk+v35/tyCgIpu0yqzSEHFtsaY1N1UpXZb19
	poKq7auiFmGCItjBtcpzCJm+7s4tiJqNa8tONiEBhvcDfQO2yAgms6bS/LKg/pYG6WLRIUm1Dw8
	PL/GDN15ms3Fh2q+5+srw9OC6N9o2Ahf7SoDGqA==
X-Google-Smtp-Source: AGHT+IEQMpCGcCv6MJDs37LwNfhYJ/aHQOmhySiSwOE4b8vVqH4/XnV6OaZWgrzn4PNCU6z/pjfP9qGkBv6/dQosuiY=
X-Received: by 2002:a05:620a:1a15:b0:79f:c9e:6269 with SMTP id
 af79cd13be357-7a1d7e8463cmr446035485a.37.1721978702356; Fri, 26 Jul 2024
 00:25:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724101015.523535-1-vignesh.raman@collabora.com> <20240724101015.523535-3-vignesh.raman@collabora.com>
In-Reply-To: <20240724101015.523535-3-vignesh.raman@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Fri, 26 Jul 2024 08:24:50 +0100
Message-ID: <CAPj87rMfs+_EMyJT1PoLTXmrosDiqQy_N4VYSA+M3R5q4sit5Q@mail.gmail.com>
Subject: Re: [PATCH v8 2/5] drm/ci: mediatek: add tests for mediatek display driver
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
	helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch, 
	guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com, 
	deborah.brouwer@collabora.com, robdclark@gmail.com, 
	linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Vignesh,

On Wed, 24 Jul 2024 at 11:11, Vignesh Raman <vignesh.raman@collabora.com> wrote:
> +dumb_buffer@create-clear,Fail
> +dumb_buffer@create-valid-dumb,Fail
> +dumb_buffer@invalid-bpp,Fail
> +dumb_buffer@map-invalid-size,Fail
> +dumb_buffer@map-uaf,Fail
> +dumb_buffer@map-valid,Fail
> +fbdev@eof,Fail
> +fbdev@read,Fail
> +fbdev@unaligned-read,Fail

Please skip dumb_buffer and fbdev tests for all GPU-only drivers,
because those are testing display functionality.

Cheers,
Daniel

