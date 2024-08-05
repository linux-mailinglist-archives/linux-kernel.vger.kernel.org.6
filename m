Return-Path: <linux-kernel+bounces-274985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69063947F24
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 18:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A5E01C20FE9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 16:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9430515B97A;
	Mon,  5 Aug 2024 16:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dx23vZWP"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82AC15B13B
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 16:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722874882; cv=none; b=P4atbnmvCs2CdEmIit54/gyBi4O2RxEQqrBsb24OGhvpERY6bADEJKY2gWRIxWma/GoBytF/9ZgDayQ0/urHDP0oRiuAjclsTzXN++5AyAgQsexlEPS4jKuWO2HHRRxasEeMXDD2UrSLdJ0iJ+tk8yQouvF95Tu2PZGUQ0KtzrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722874882; c=relaxed/simple;
	bh=B32shkeZCG6mFD6P+kT6Z4Ez/QMYwXjeiQfZrygg6fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZodQbv4wyLAOY58NHZbS8/Ymm1JjP2KGgJBnQl/R8JnzwtRaU6pMi5vPDHvX3gQXY57yQ9zYyhKNiJxXw0arMAUuVVk+TqTyG4bxD+wUT6J3roF/HEjElgUHuJC0XPbCyHCPN67v/h3AUPYaAdr7malmF/QXWFi0ggK8X+QeLqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dx23vZWP; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2cf213128a1so6863053a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 09:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722874881; x=1723479681; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+CoAJMCsHveIpfHZDH1fwzV0mbxd5KQw/DdBCUG0TjU=;
        b=Dx23vZWPG3wtcoVWB43FsaH5SQgCI+JgrsJWLd5KgCwwk/TOIvgQ5NbDHeNv/m9GPi
         AkMWY+XZ3moRq4KZq5lveDSXP/J/SwKoO9rQkGnpV9Gir08HkeLfjYUqrYr6Y7QaBtf7
         g5iuzeVLY/ZxSCpX93euy0F2woGERUwDa7NRyrwoarpUgxt13EKOGOU/iUUBYWKMp/+v
         DL2p3mP4I1xaJzd76iJCUwe9WgubXVTKg4r+giRBTs2ofjqE7ufBFyDlNg0yRBS+DcOC
         B0IUPjs1JumXqC0azsjLPtA3SpkDAcq58LYagDzJihcRHVyAGMcw+6qXqhaArb7AA0sK
         rwDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722874881; x=1723479681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CoAJMCsHveIpfHZDH1fwzV0mbxd5KQw/DdBCUG0TjU=;
        b=T74DkY1eET4Drr5bMh7VF9u+lh7M/RlZ1zFdcQwYXmfEBFctMYKiVeMCiCXxajy/vM
         l40gAHTo6W/POMDii8eNrw83jXSeWTEyB3Qj7jmLWr0vLdjH1npjxXhyVpNxbaroz3TN
         j66LN7MrjeuIsXhstwOlH2GSZRcm6lsclmHkmrHGWBvLATme63mmYPetoisfJKdym82R
         P6xLGlGz2yI+zLUYKpRRMeZoj7CxKvuibbM3L97GcSSC+eLqXvhzu75aiENS3AjUqEfq
         m96lKzRmoWNFCIYsnVh1Nqafct6ri/MPQtjGZdq2TEs/rTqKCyNlz4+tVIfgbl3uozSF
         DA9g==
X-Gm-Message-State: AOJu0YygZadelzQcZwiAGrcDj8/qpzwweCDj2KL1dEACXO3Ao1kCzx65
	91CzutSa1yjKuIeG5L+UgF3IawQ2KUMty4mF4O3pN1e1+Q1m/VK5zp21fBEb
X-Google-Smtp-Source: AGHT+IER1nzmXQbHXY25s9XyYcK3iVQQiOk1bc0rC0MuWprSR7WQH1o+I7NBvFCKSnMhZyskYIrqqg==
X-Received: by 2002:a17:90a:ea11:b0:2cd:27be:8218 with SMTP id 98e67ed59e1d1-2cff93d5aa4mr11210908a91.8.1722874880743;
        Mon, 05 Aug 2024 09:21:20 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cffb36bd48sm7239981a91.46.2024.08.05.09.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 09:21:20 -0700 (PDT)
Date: Mon, 5 Aug 2024 09:21:17 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>,
	l@yury-thinkpad.smtp.subspace.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] uapi: enforce non-asm rule for 128-bit bitmasks macros
Message-ID: <ZrD7_TZrh0N4Fkx3@yury-ThinkPad>
References: <20240803133753.1598137-1-yury.norov@gmail.com>
 <c834a806-215b-4375-a5e6-89954fbe7519@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c834a806-215b-4375-a5e6-89954fbe7519@arm.com>

On Mon, Aug 05, 2024 at 04:58:25AM +0530, Anshuman Khandual wrote:
> On 8/3/24 19:07, Yury Norov wrote:
> > The macros wouldn't work in all assembler flavors for reasons described
> > in the comments on top of declarations. Enforce it for more by adding
> > !__ASSEMBLY__ guard.
> 
> Right, this makes sense, should have added in the original patch itself.
> 
> > 
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> 
> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

Thanks, adding in bitmap-for-next.

Thanks,
Yury

