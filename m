Return-Path: <linux-kernel+bounces-277890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A689B94A7BC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 420A7B22032
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C4E1E4F0C;
	Wed,  7 Aug 2024 12:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar-org.20230601.gappssmtp.com header.i=@fooishbar-org.20230601.gappssmtp.com header.b="t5du0zdM"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395BB1DD3A6
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 12:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723034005; cv=none; b=fd6t6kGmywlR73kl8AsLotB+oi9HB4AYvmG8lxqnXIFl+V5NDDJvQzZ+t/+S2u6v0p6D5DUQbJ30SLIDX3ZwGf8taXNhNiUGIEHjAeO9FitP2xrE3N5LIOqQ6V0V/rvDKhyYRwwEzhcJWqH/9F1aq+NOxMZyV7QnYvInRWyIvVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723034005; c=relaxed/simple;
	bh=IyhseLdbTcH0HQjwdopNFEMJ8vOCRMD61AHrQ0ocnI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kQnu7QB2/23yVx+gZ1GnqUPytqZFMeMP6aSdFSVl0f4JAevYxygpuJ+zUsps/reElDSK5jeclOiYMwhZ+62mSBXhWrlHMavXQzIBCnR8zNwJyKtH0iC5dQLnXzg8ecYHhn5S9DlyPQde/UlPHRRQjbfQWdINEdKeFWp3/kBxiuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=none smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar-org.20230601.gappssmtp.com header.i=@fooishbar-org.20230601.gappssmtp.com header.b=t5du0zdM; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fooishbar.org
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7a1d42da3baso98160285a.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 05:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20230601.gappssmtp.com; s=20230601; t=1723034002; x=1723638802; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IyhseLdbTcH0HQjwdopNFEMJ8vOCRMD61AHrQ0ocnI0=;
        b=t5du0zdMx53AnOQxbw9nNoeCqWl9sK6IRsi2OjWEvq/v/c0xm1lEGp551RpvFHtBxH
         d8GSfiQ8RaHw9fbg0V7ypI8049RjM+cezgAZXxLqXQBpMIyJeEQZM4e2sAO0TexpENdP
         HLMF4e1iig0gKdjIeeUNy8lesuv+zyvtZtKvylUKoi6q9jOkx/InectuGjmMbzi79XRS
         ZGOmZeJ4M8NXBWNw9of7gUjSk2IE3wHMxISC2XS9Fd2UvP/9Hei0azTBD8EHHs5DBtO4
         7YxSH84EITjwzBFHM4ZsdN/uPAdT14XeOqx/l07+Rfpv0IKGjGPwBHJO00ZipVJ4Im2B
         R6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723034002; x=1723638802;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IyhseLdbTcH0HQjwdopNFEMJ8vOCRMD61AHrQ0ocnI0=;
        b=IN5gMO/MmAXOVlIaaQnz+3j2z8qf2pQd8dXdBT/cYmyqLLIoj8ecw2j8JuQhGLGGK5
         sM613SzFbdZBE04hkH/RMmtdpy8XFlmYFz90WL5ZExwpyEpNdmu2elddVJoGVtHIpqwf
         VmHzApeHX29QS+NVN80fIFKYROvUzTQ9GxxxS8f9p7MsvCLLcYR3I2vZRceWg/s9X14u
         HjFC/cNaT5mWfjs1XUZ/I90qQM1QsIGwptNABB2+cpVmtAF5xDTBIgSzjPB3K9Disd7B
         BmORNgCgXdKGuVuNRwX9MWO1RiOacr2w/FGzE9qOJiw6BdlIIN8DWxn0onDaDO87XSn/
         V9yg==
X-Forwarded-Encrypted: i=1; AJvYcCX8lr/byAjF8zRZ/Ge/cRuNrEuiHCepXMs0+UaU2PC2sZLeksTwHuQCLXxRJQfPY+q40xzvcn3ZNmcdCNwt4PkSvU6Rc/mjy5HRohBB
X-Gm-Message-State: AOJu0YyUfV+DjduOSKhZq48oJ1DryXXNUf43auz7I8hdyy72PL207oNY
	MQ/MAS7PWlDtC+P8Pjn9awU7H/y/8JUtR9grHpi3l+J4Irh1vwWFDSlVKLYKI+CHUZ/8pLdkPuw
	o6qBr013R3WzlHX+UYJc2jrld4xoUrd3Fu1kRaxsMbYTx8iVm
X-Google-Smtp-Source: AGHT+IGQwAyTHhFa5d+FgtHDb/BNARGoCOB1HyGv1K0p8jaGlwe20AFtdOyHBmDOX28AhldVlxO/Uqi7jv9po6LmYek=
X-Received: by 2002:a05:620a:f0c:b0:79f:178f:99e6 with SMTP id
 af79cd13be357-7a34efdce00mr2225516985a.64.1723034001790; Wed, 07 Aug 2024
 05:33:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807082020.429434-1-vignesh.raman@collabora.com>
In-Reply-To: <20240807082020.429434-1-vignesh.raman@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Wed, 7 Aug 2024 13:33:10 +0100
Message-ID: <CAPj87rNO4ckvgggn=FE4odpAsGDb95XZ7py0GrguJqB0Y0TN8g@mail.gmail.com>
Subject: Re: [PATCH v1] drm/ci: uprev mesa
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
	helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch, 
	robdclark@gmail.com, guilherme.gallo@collabora.com, 
	sergi.blanch.torne@collabora.com, deborah.brouwer@collabora.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 Aug 2024 at 09:21, Vignesh Raman <vignesh.raman@collabora.com> wrote:
> Uprev mesa to adapt to the latest changes in mesa ci.
> Project 'anholt/deqp-runner' was moved to 'mesa/deqp-runner'.
> So update the link.

Reviewed-by: Daniel Stone <daniels@collabora.com>

