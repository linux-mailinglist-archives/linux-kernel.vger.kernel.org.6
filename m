Return-Path: <linux-kernel+bounces-379155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD8C9ADAC9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 06:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 096581C21A7F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 04:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29663165F16;
	Thu, 24 Oct 2024 04:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SRrpqxPD"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01A72C9A
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 04:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729742698; cv=none; b=Li2b6Cun3uCjgv0qzznYdrF4i9tHpM0/GkFs9j3oH56LADEHtsWP92p3lUBKq83a8dhUSeBe7J9I8Qr+xSjKIzF3+NBDt8BoJVdcVvS28PsB8N3Oi6zfUogc8asdsU/RjIxmJO5JmvoxVudHB259Hx1yb9T7F2ToCmB/fiOkpcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729742698; c=relaxed/simple;
	bh=ilDAU2ed+/RE/0w8213A9drNw3Mkja7sfuCZq+l3Zqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cs8VKJHaWMNGW1wB5uViAUbSrymjtCp3maTDnbE4gDZbv4b1dzK84veJQb07wAfwrhvCl/kLSf4Q/88qcAMpZhzCzdOsWWNF3lGZNZWg9wcBRD9+Gq+62Tkhb81b25U++XsP5vQC5+jplfTWN7fl2JZwzhFMqE5YiZlRJBF7xnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SRrpqxPD; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4315c1c7392so4552645e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 21:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729742694; x=1730347494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i2Ee+wYLrjeTPkZJqG2V+F1SrMBEJkzp1fICKTcr5UA=;
        b=SRrpqxPDEbTvSv0Z1R+HRJItM3J2z0l2lvUX/3WFK75a31xDy/NLATlO1xKFiXEFKX
         wdBbC9Pyi+QX0b7qi6Lke8x+7I56Muojo4HjsZofbYEs6MNmi7m/HxjFoW9ZtwdPPm35
         8lHCVVPBe0Kyf5nVsF0UY9Ao587oi+q8eIXP1/E3i59x6EPL5RrYgHwelWW8tfQzGW3F
         yJiL7/rhvtBwFATOIDM/Oy4h07oYk1ljTiOOxUXhn3I1grufGD8EsluWFpogx9CDr0RC
         +35ne34kFty0Urv+juqHaOMWxB9RAr81pbkIauXYgHo8i4GQ0/m33sTVlSmu84Oo2M13
         A5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729742694; x=1730347494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2Ee+wYLrjeTPkZJqG2V+F1SrMBEJkzp1fICKTcr5UA=;
        b=Dsg6C6qhiWWut5M+V3q96siowMn3rmhRpWhF7KtWaM4mKKgbgVGHwBQMAXqBKu5pC+
         x01+VPDqnv/M/kmlbNaJox3WKmlPZTCYCCoOozvWe+Fsq+NHVLGVmBvslNJ70bFactJt
         tsm/ObZMTvXBz4sgkTIF+ranSJgFfG+mcktILeM66sSFjxCdbdFLKVRr3ZTNG/dgnj5i
         u65p5YVPX7zqfOc4XB9BN2k0nSlDpUBRkjTzc074gB7umMdaWgBb+p5NMJ3yWw97OIDu
         jFtzsUhTA3y2SgSK4aWOUYV5+Y5TVxOuGkfJugKm2G+b9KsPoP0geRpeBJbe8xhF0igY
         P2cw==
X-Forwarded-Encrypted: i=1; AJvYcCVJ5WOwMlLUZlWhyTYmH0p2SyjKbUgqLDrRgbkgrIq1DrGEU8mzzCsGdjRIhlx4Y1qRbpI6D9PEDaNTnFs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy298UXm0zrw4zBOuiPu4aCckt23D25sczNnlstbbCGXOSsnaMD
	jnkV7IHFPOzaTFxVx2yruYJ922JEs2H7xbgNX/FOi9Gr4yFnZIEKlaYuGXUtxhtfGvbmapANXgp
	W
X-Google-Smtp-Source: AGHT+IGd/gB6y7xLOG2JG7hMBW5M5PHbk7MPG2s5coFekXkmwgszm0maUkXzdH+g6y3bzrC72Vbv1A==
X-Received: by 2002:adf:fdcc:0:b0:37d:4a68:61a3 with SMTP id ffacd0b85a97d-37efcf86958mr2772664f8f.49.1729742693977;
        Wed, 23 Oct 2024 21:04:53 -0700 (PDT)
Received: from u94a (27-247-32-52.adsl.fetnet.net. [27.247.32.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb675eb1bdsm5158544a12.10.2024.10.23.21.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 21:04:53 -0700 (PDT)
Date: Thu, 24 Oct 2024 12:04:45 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: cve@kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org
Subject: Re: CVE-2024-50063: bpf: Prevent tail call between progs attached to
 different hooks
Message-ID: <phyhoab337c2vgpfgtrjru2so6luvmymfrugdazacz3sk4to7n@nutpfnn4ivdx>
References: <2024102136-CVE-2024-50063-1a59@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024102136-CVE-2024-50063-1a59@gregkh>

On Mon, Oct 21, 2024 at 09:40:04PM GMT, Greg Kroah-Hartman wrote:
> Description
> ===========
> 
> In the Linux kernel, the following vulnerability has been resolved:
> 
> bpf: Prevent tail call between progs attached to different hooks
> 
> bpf progs can be attached to kernel functions, and the attached functions
> can take different parameters or return different return values. If
> prog attached to one kernel function tail calls prog attached to another
> kernel function, the ctx access or return value verification could be
> bypassed.
...
> This patch adds restriction for tail call to prevent such bypasses.
> 
> The Linux kernel CVE team has assigned CVE-2024-50063 to this issue.
> 
> 
> Affected and fixed versions
> ===========================

I do not know that exact commit that introduced the issue, but given
that the fix addresses the following BPF program types:
- BPF_PROG_TYPE_TRACING (v5.5)
- BPF_PROG_TYPE_EXT (v5.6)
- BPF_PROG_TYPE_STRUCT_OPS (v5.6)
- BPF_PROG_TYPE_LSM (v5.7)

The earliest affected version possible should be v5.5.

> 	Fixed in 6.6.57 with commit 5d5e3b4cbe8e
> 	Fixed in 6.11.4 with commit 88c2a10e6c17
> 	Fixed in 6.12-rc1 with commit 28ead3eaabc1
...

