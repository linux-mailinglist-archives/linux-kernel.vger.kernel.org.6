Return-Path: <linux-kernel+bounces-560242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62814A600A6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 20:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6511171874
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 19:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53BA1F1506;
	Thu, 13 Mar 2025 19:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4n7yt8Ud"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35E3F4FA
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 19:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741892909; cv=none; b=S67Fqi+efekoFOfs14DJoAjDwicFPiMiqtefsLL13U0GpzJvlzoVU3e5yY0QK1RQIU2+ySanGGSGI8wxEGrKbXkvPGlOkZz58/Ie5O8LsS3fNwGDMaDa4sfi9hOzunhffkUtfAaMqZDG4AvKDDKKhc4aDjPaS8C83rLuRo2yP6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741892909; c=relaxed/simple;
	bh=zebU4/k/EeqtjpAsS6Cj6e8OZa3BjJTLbL/wQkDK6t4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ftORcaSKABxWmaGNpnBmkbaLtFGIKmpG5RfOlFITys9k7d76vEEmCKL4hq5TBu6w0qQ2abYhv6gYEXaz3VlqNxHCpgTxYRCL0tTsqAGLLDSEHltwaP9InfmIIGkYTKsbmOBWgN3MLtDPmAHatauBAUM09U0dIhdVswT0zyaLJPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4n7yt8Ud; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e5bc066283so2000502a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 12:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741892905; x=1742497705; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v8INpOFDdy6zgQZNj++IeYTATBDv20/pe9DlHWL5cZs=;
        b=4n7yt8UdK9/5gW9HMm7NewCvXJ0eVxR/ORAI2lKogF6bnnPb2gSvhMYSIkf3VeZVGe
         lCx17R4mxaZ1ROH6JzxkZscE9ZVhJfbGNXeoD9mtflsts1gSpAwo6j1G3alPstOpS411
         NL7D/ZCoVbRyrPMVKqvWb3dSe+fn2jfmvnZSK59ELvGF2rWE4x02gS7Tox8XpuQEeVvX
         sxj5MCFBTHBuN+6Lohy4SCeSAO/RNBSDV5aYsflvi+AZS+DyMBdLm8FE4XM++sx1Nt28
         TU5UVqjuPYHtiBZ+pV5AvT9dhiIoChQI+51fKhyiLxw17v9x7bv1JSnBXaJcqAh7g6gg
         kdOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741892905; x=1742497705;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v8INpOFDdy6zgQZNj++IeYTATBDv20/pe9DlHWL5cZs=;
        b=DgleU1ZN/6fRlQzPV7d1FIarRhdVbYpzmafNhFqIEYkf1sfhxAHz226cNnkNtHdPkM
         NfpIUZECnzkFRTJucAWk+PerMSpX7eaCrAB++sBWSO3UpN9osER4wnGu7dpW8k1mnMG3
         d2nExlCGOK8040eE8phAEw8Lm12m39vZjNRslalEgXsvLimsd3qsseZPe4LLOe+ypt0F
         a46Gkg6FdDkf2WSYUcSYCwCTuonHuFdZXXFFVzNCOYCw7BwvvGmdw38s+elSiy9QaK4N
         pj0UDY68RqfAK9t+5nkZrpXV7rNtMJdTPWyBWMTtp3Q6FhF9FFVZyljJcppt4V7TP+6R
         1SBQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1X7hp5Lkl2Inq29UvzPoeeFYC8jqDETQFloKF5bYFPt0aGFODHswHAsPz/eJ9R3MPj8owBNXygIEVNUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCthD1U9UHvukBbmNyD270wBLjYTl/mriCEA9QSTj70mNMNTJV
	90Nc/ilgWOwrPnZmpn/ei4FhKXV+P1RWNl/rO/xmxtLTgUNQelDe+Gg5a9WxUQ==
X-Gm-Gg: ASbGncv4XEfLjVZKp/+0edaontsE/KimDlrlYauC6twJbyd8cJwh6GfZ5hHEjEHmQRO
	CRGVKJWB6nIpIIisGjfJEouEKll0YGSM/O8XV3kIGbEsppkJ7rwwQHcToET97uhQyCapSt9WSXP
	HCw21Ecf6Cj7T8FLCPJfAVDtbI3y1ZN5ip/Xtq41pIWcBTA27P+ByQ8W7mZatG4EM2UppkI3DPb
	EmSJlG0Iu1wyVXRFVa4w0971zyjnY7wNGLfN3dX97bgZw4+GzN3zvlkTQdfnB+fol7ATt/ejtlV
	R4QsHosHlx+tOqaNz1RsEwLmy13kGW/Z/EOlQf0HIjWDi6pTFUlILiOoDqorFlEvPhod8RooWh0
	QVTlu7TL8Czf8DQ==
X-Google-Smtp-Source: AGHT+IFa00JtzqukTdU3WMYr5CjZc1RVh7xO3wiZcNVvi/pVcZene2/D4xio0rZGpWde7c+HTNy7zQ==
X-Received: by 2002:a17:907:9452:b0:ac2:bde9:22af with SMTP id a640c23a62f3a-ac3290943a7mr61434466b.13.1741892905085;
        Thu, 13 Mar 2025 12:08:25 -0700 (PDT)
Received: from google.com (140.20.91.34.bc.googleusercontent.com. [34.91.20.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3149cfb96sm112178066b.119.2025.03.13.12.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 12:08:24 -0700 (PDT)
Date: Thu, 13 Mar 2025 19:08:20 +0000
From: Quentin Perret <qperret@google.com>
To: Gavin Shan <gshan@redhat.com>
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org,
	shan.gavin@gmail.com
Subject: Re: [PATCH] KVM: arm64: Drop sort_memblock_regions()
Message-ID: <Z9MtJPNm1pLATGo7@google.com>
References: <20250311043718.91004-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311043718.91004-1-gshan@redhat.com>

On Tuesday 11 Mar 2025 at 14:37:18 (+1000), Gavin Shan wrote:
> Drop sort_memblock_regions() and avoid sorting the copied memory
> regions to be ascending order on their base addresses, because the
> source memory regions should have been sorted correctly when they
> are added by memblock_add() or its variants.
> 
> This is generally reverting commit a14307f5310c ("KVM: arm64: Sort
> the hypervisor memblocks"). No functional changes intended.

I think this was originally introduced in an early version of the code
where the reserved regions were also registered, hence requiring
sorting. But yes, with the code as it is today I can't see what would
break without it, so:

  Reviewed-by: Quentin Perret <qperret@google.com>

Thanks!
Quentin

