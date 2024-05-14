Return-Path: <linux-kernel+bounces-179126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B74258C5BFE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 21:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E893E1C21DE8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 19:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452F718133D;
	Tue, 14 May 2024 19:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HPXv4VCQ"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46895181320
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 19:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715716753; cv=none; b=Yl5Dger9NwCLdB5vU/5309k5XsSYjPfGpPxJbHwvK2EUc0SZN0Blm2WDsKGlmaKEsr8M2OLqHEeZpuyqsqc9ZNppgexVUj+44PJsOe/0a07xXncPWj/4X6mpoLeDxYSeZ+eaw0YVkBqsbZhOr5nEEmUlp8DiNEqsUzUNiPoB21g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715716753; c=relaxed/simple;
	bh=ASOifTaYkEbXRoLvAaMixYKD9XKfRPUvH9WBVQA50zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hHRxqjjBjhEuIe/Hogqq6pbxzx4Ha9Loi4w/KdEMfP31DRggNvl9DACdaN2kGZBxgdH6rladegKQg6AqP4VTiHhVt+QXyfHa4jIiL3XeDbvkwyhewbT4l3WbHRjuFbBHIMkff02MdHJ2+RyWGpa4pvmaH9bk3S/rnATPdFmVxJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HPXv4VCQ; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6f45f1179c3so5681120b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 12:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715716751; x=1716321551; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IDIxmO8O4oEi6F9/Vlt0Coyv3oXpib+ejgDTpJEMwH0=;
        b=HPXv4VCQ96HCMttF6cbDZYjLbSbamVwhiOhMLs2cGEEE/qpPB49kocwL7dB6OfOCWc
         whqo/2wO6AJuGJ0ef+o1IDAMnO09yqZ9DjvpjxJ6IpFKX+DLdwq2huvGaImirHtwwldW
         qA5XIUX4HkS8lENF6u984pqx2gDaVlFxsfglA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715716751; x=1716321551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDIxmO8O4oEi6F9/Vlt0Coyv3oXpib+ejgDTpJEMwH0=;
        b=kdvfe8wdg6lkuJxq1LWopCHSa605nYK6HJyFtwhkl4aQRnUa5sZYVdCkMxrd+fy+ix
         KK3Eiw56YFvL+e36LAC2+37haGr3Ca3grqaniXatidxYYe9NS50F2gALVGx97R38EKFq
         xf9/3XAvC4f1WJuEi8MlwlWktX7jeW9Og/DMxgmTu9S8Iu5wV8B5wrxakYg1uRdbCsMt
         2wFT3Alclt6HHIZE4L4bh12BFsdKfOy3DvGuuiTCgV689+FKDdV8Se294AWJFsaqKLue
         wrvZ5u30Imk2avDHkDvUAE+sIcfd5/HqAKaQxSMUs8vMJ/Gl+GsflxlbamBmOtuqBtgQ
         glIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWz69dd0jFpvMbU+Yjpr/obEoiouSJjU9xsf+UhmQnPKWN1OO30xs8NRsuA7KiIIQkifSmxY98kwHCja1Y6+EB8OYO+zwE/cZXg1UTz
X-Gm-Message-State: AOJu0YzxfTFtz/BMxPgl9ub1LW1YCKFAnITJIZB20/nFgzmHT891KTLl
	a4kkqPN9fF8x16ybQWMrWYozyzgYMV5YL+765Vfsj2a1eiFmV2hniR+a4Z50yw==
X-Google-Smtp-Source: AGHT+IFMsUNE1shtNKBoX9RzuQwz1fwsS0gskM8WW1Coq2tK+eDh8hIV25DdF54UPDs1+2Ge75iaTA==
X-Received: by 2002:a05:6a20:3c94:b0:1af:cd4a:1e0c with SMTP id adf61e73a8af0-1afde0a8d6amr15225799637.9.1715716749654;
        Tue, 14 May 2024 12:59:09 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f5028d7738sm4031400b3a.71.2024.05.14.12.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 12:59:09 -0700 (PDT)
Date: Tue, 14 May 2024 12:59:08 -0700
From: Kees Cook <keescook@chromium.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Marco Elver <elver@google.com>, Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	kasan-dev@googlegroups.com, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ubsan: remove meaningless CONFIG_ARCH_HAS_UBSAN
Message-ID: <202405141257.3979DCA2@keescook>
References: <20240514095427.541201-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514095427.541201-1-masahiroy@kernel.org>

On Tue, May 14, 2024 at 06:54:26PM +0900, Masahiro Yamada wrote:
> All architectures can enable UBSAN regardless of ARCH_HAS_UBSAN
> because there is no "depends on ARCH_HAS_UBSAN" line.
> 
> Fixes: 918327e9b7ff ("ubsan: Remove CONFIG_UBSAN_SANITIZE_ALL")
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Oh, er, we probably want the reverse of this: add a depends to
CONFIG_UBSAN, otherwise we may end up trying to build with UBSAN when it
is not supported. That was my intention -- it looks like I missed adding
the line. :(

-Kees

-- 
Kees Cook

