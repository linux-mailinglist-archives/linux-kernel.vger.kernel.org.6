Return-Path: <linux-kernel+bounces-371475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B0E9A3B92
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 12:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41F7F1F24418
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 10:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1F72022C7;
	Fri, 18 Oct 2024 10:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=philpotter-co-uk.20230601.gappssmtp.com header.i=@philpotter-co-uk.20230601.gappssmtp.com header.b="aRRKGttV"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68D017E00F
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 10:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729247490; cv=none; b=CtDHppDj/UOqMyo+y9vErXYW5v6VA/eGrQmyzP2BX+TaU06M1pXLYX6K6l5vz5lNAjpT+wzFI8OsOengF21H2V7s0tuw5pWoMC9lxw1Qgk7/ZyH55vER8qlNBnIzJu9kzzhtbmJA6XmIxK4aV0hmYullUM7kMRpKFHxEOl+aopM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729247490; c=relaxed/simple;
	bh=LSoBdcG8z1yBSfSmQI/2gfmPkYAjLk/CpeJDC4twC8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NLLNz35D5Zmg+TO+Us0WEGGHeL7MFuSMzKbsW6o9ECDpVuerRoHYFznxYRLIZphIFfdiYiEHBG+68KAOLUGhVEUVFjKBwJhR7zQMN2CGPhJbNe2Xxq5NuyLj8RJdg+XLx9dJKy7xiOeQ35iTp8Baoek1PKSPdAunECxCVxwlpYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk; spf=pass smtp.mailfrom=philpotter.co.uk; dkim=pass (2048-bit key) header.d=philpotter-co-uk.20230601.gappssmtp.com header.i=@philpotter-co-uk.20230601.gappssmtp.com header.b=aRRKGttV; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpotter.co.uk
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4315abed18aso14919035e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 03:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20230601.gappssmtp.com; s=20230601; t=1729247487; x=1729852287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NGMLCK6yi6tPIAZcZpIiXSjnyYflSSElp2q2UMFWQK0=;
        b=aRRKGttV2Vu3UyK4sIpHdT5ebISTEtsi+07KNPydl6zx70XWe5bwXnIkKcr7k+3s3l
         aZ2mipxjwLnEkV+1G1pSfZjLK82hzokdAaGq3IMFXZe6hUNooomE7mtcDn0II53ObPv0
         h8uYHLK5I4inEDNhjPu0DmyWaLffAyRV+dxSI+8bXXduS9e10DT/dfUEur5hiuQ3hu3T
         1OQ22pA7ONpNcUEQm+Xh9/+znlvCpRs8QOrOXUgRbl0Rdh0G5EB0bYftdSYqKKjkq/EW
         fN+ugKxl6tHt4reoVDDWvzcm94ePG19VCKKHHyfwkJjnWoq9AeBZc2HWT+82zUZh/k8M
         LkMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729247487; x=1729852287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGMLCK6yi6tPIAZcZpIiXSjnyYflSSElp2q2UMFWQK0=;
        b=ajjL0K0Xim/GoZ5bPAYzau90WptY0xYnMuyays7zkhUhVNIiEkMTvaJFD89Z8Vj0Wd
         kOMqHHNpODkU7zl96SVm8MoLrX7oqikc9svDjQIYeiqdGkqtBOTX5aF2zilO4pkTfUbc
         oVG/J+2a0BY88MDA8QzExnultr+6aazqTismqm5dEVNCkYXUvKw0r4LAZEb3Sv4LsKps
         9wq6ZG8+kuFAaJXtkga9/IZ2d3KDGcJD1z1vyciE06XWAZtiIPZ75tpAo0+2+1tQyuzN
         N8dAcQ1k6Q/PRN7w10/KDDfScJNJzFNf8Dd7YWb60RaOuS8yAyRLoRwCYtZ7Hf1qGJfe
         jJPw==
X-Gm-Message-State: AOJu0YxziZXYNELJtuhiC74Ms0+Rbz1ovvuzj17Sm8CCT7nJ8FjIX1HM
	MUVm8pvHYUOvdBLrtNF1dJHByfmHvW/roVVpmNZlvYD4sjfFG0DByBefPpN3I8g=
X-Google-Smtp-Source: AGHT+IFuuh8c1ut8M9NQK4hCaHHnsIoKPOgyRMUWBNaoOrm+wNYFra8udYrf1etTHGv78ukeJaKqzw==
X-Received: by 2002:a05:600c:5490:b0:431:5aea:95f with SMTP id 5b1f17b1804b1-4316165a78cmr15389735e9.16.1729247486808;
        Fri, 18 Oct 2024 03:31:26 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431606c64b8sm23559035e9.38.2024.10.18.03.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 03:31:26 -0700 (PDT)
Date: Fri, 18 Oct 2024 11:31:24 +0100
From: Phillip Potter <phil@philpotter.co.uk>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, Jordy Zomer <jordyzomer@google.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [PATCH] cdrom: Avoid barrier_nospec() in
 cdrom_ioctl_media_changed()
Message-ID: <ZxI4_BlGL99OX7b4@equinox>
References: <1d86f4d9d8fba68e5ca64cdeac2451b95a8bf872.1729202937.git.jpoimboe@kernel.org>
 <172921605188.361223.17436309372879358744.b4-ty@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172921605188.361223.17436309372879358744.b4-ty@kernel.dk>

On Thu, Oct 17, 2024 at 07:47:31PM -0600, Jens Axboe wrote:
> 
> On Thu, 17 Oct 2024 15:09:02 -0700, Josh Poimboeuf wrote:
> > The barrier_nospec() after the array bounds check is overkill and
> > painfully slow for arches which implement it.
> > 
> > Furthermore, most arches don't implement it, so they remain exposed to
> > Spectre v1 (which can affect pretty much any CPU with branch
> > prediction).
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/1] cdrom: Avoid barrier_nospec() in cdrom_ioctl_media_changed()
>       commit: b0bf1afde7c34698cf61422fa8ee60e690dc25c3
> 
> Best regards,
> -- 
> Jens Axboe
> 
> 
> 

Sorry for lack of reply, this conversation took place in the early hours
for my timezone and thus I was unconscious :-)

Change sounds good to me for the aforementioned reasons.

Regards,
Phil

