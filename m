Return-Path: <linux-kernel+bounces-311529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6FC968A22
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA49AB20D6B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A54C21C186;
	Mon,  2 Sep 2024 14:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vDTJi09u"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF85221C170
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725287853; cv=none; b=rgw6Ea7TUM+sXV6vU5xkW8pt00K+84etw/dn1ll+fZTfBmmqthTUEEeUZmUIKUtb2uMKzY9QShLoRXNgbuPko5/eLSxZBaWEublzLKH36C4svFK+mDV0gcD62TXjONyMhKtSR0V49kjlsKi4BygYnwF2SO8oZdRQhUT0Ze+XYhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725287853; c=relaxed/simple;
	bh=QlJUtfucbcB9eU4G1Pzz7EZrVBuytWidgoUWwmGGoxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fex4SMhLPU6TQwET0VXlXpXXAIUJRkhMk/XlvPjFOb/Oj+wOtEOewlBBnrVeL/xVfraq5YwrIkT6KhjCBQF4NCnOwHzKdjUzgYeUQuO9wb0csO6ekUR5wUoOdfzzwb6+26HIwnPcWLuWLuT6/OpINXnjaG0AZTsJYPIKqLP9YwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vDTJi09u; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a86b46c4831so479579366b.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 07:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725287849; x=1725892649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ksimq/X8z36n93auL3QzW0MCIhynenZ4+E4hepBpL4c=;
        b=vDTJi09uQA7m9+8iQCw31eazVk1Xi87uFdUe+Y2KM+7q/3stmrrU8CJmSXnE2rRdES
         p0LznZtc3GUNfoYSGYzsCXwGMxO5oTC/2cerKOMHHIpQ3L/PO56ph42jV+4komVA9iNZ
         WZ2ueRdOcRxRKBesmIqcNP2GE333r0V5mB0QCRZaJsN2tN4NkXR68dApv8yaiem1oatL
         Q3NLHEe+FI2puJG0fHiOzqS+eoDJFBrlxcm+5TCcd9xaUF+rdeUQEpZcyAeSf+bZK3Jt
         Vd35nK3cLqyOC0SvPdXolaiA0FiZaGo4KVV00nvfm7UKKHZha/bNus1IKtznTL/cBzbW
         Fs9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725287849; x=1725892649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ksimq/X8z36n93auL3QzW0MCIhynenZ4+E4hepBpL4c=;
        b=Cr4X96wSWRlvoXLYb1eri9xlwXbaSiat6gZYa8MIuba3XAvFhtr6pfW97xfmniqFAr
         baMSC5AxJrf0GtaCZKhJ1dkPccemsP5LlxAU0kRwnTFxx2QxnT4ACzw0LU9bmwbPsxiw
         VGIhqnTBES0RMzLCowz1zJeEfEVgjWcFtjguFRTdsT42sEWSIG1oM4j5vwgcMH0MK58b
         ictsjqOu7pFSIbMqO6seZPBVzaekXNKeC/nM1ZwNb/+vvyrVZt+rKoL+ih98VGUgCrDl
         PASK72NIf9aX8AAfA6ZOxUe2kI4aL5BWVjOODLmr72daGQ6eNaeYP2duv+hmwK84pCD4
         MgPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCTeCjKhf43ElPhT3pVmIyxjLg4cZZFAnQgIipBXcX+RvcHn5z03OUIaCdv74csjl/k8Ca4dS+wBW55yo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBUN0gtImqEKN14aRGLLWLsg6pZiqcJHoKaSWe6lBMI8S3QzT1
	SA820JTgVMtz36mc8LpP2Ze7Kdz9NDi33Eu9VvKQy/Xe4fUyZHGB+EWy16SheC8=
X-Google-Smtp-Source: AGHT+IFN/BuiU/VQTETMCNCGYmY9dG4wN7RdxT/6udZdCaJHhUriHjg2+YKFMK55XW9pJnkO/V6Duw==
X-Received: by 2002:a17:907:7b92:b0:a7d:e98c:5bd1 with SMTP id a640c23a62f3a-a89d8782279mr554770666b.26.1725287849184;
        Mon, 02 Sep 2024 07:37:29 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891964e5sm570121066b.98.2024.09.02.07.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 07:37:28 -0700 (PDT)
Date: Mon, 2 Sep 2024 17:37:24 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: almaz.alexandrovich@paragon-software.com, ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fs/ntfs3: Use swap() to improve code
Message-ID: <9212714c-7f75-47da-bc34-48d775925194@stanley.mountain>
References: <20240826103939.63548-2-thorsten.blum@toblux.com>
 <041F9CBB-17E9-4D6F-B981-BC861E1048CB@toblux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <041F9CBB-17E9-4D6F-B981-BC861E1048CB@toblux.com>

On Mon, Sep 02, 2024 at 04:26:16PM +0200, Thorsten Blum wrote:
> On 26. Aug 2024, at 12:39, Thorsten Blum <thorsten.blum@toblux.com> wrote:
> > 
> > Use the swap() macro to simplify the code and improve its readability.
> > 
> > Fixes the following Coccinelle/coccicheck warning reported by
> > swap.cocci:
> > 
> >  WARNING opportunity for swap()
> > 
> > Compile-tested only.
> > 
> > Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> > ---
> > Changes in v2:
> > - Address kernel test robot feedback and assign match_offset as before
> > - Link to v1: https://lore.kernel.org/linux-kernel/20240731135403.80805-2-thorsten.blum@toblux.com/
> > ---
> > fs/ntfs3/lib/lzx_decompress.c | 3 +--
> > 1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/fs/ntfs3/lib/lzx_decompress.c b/fs/ntfs3/lib/lzx_decompress.c
> > index 6b16f07073c1..4d5701024f83 100644
> > --- a/fs/ntfs3/lib/lzx_decompress.c
> > +++ b/fs/ntfs3/lib/lzx_decompress.c
> > @@ -512,8 +512,7 @@ static int lzx_decompress_block(const struct lzx_decompressor *d,
> > * the same code.  (For R0, the swap is a no-op.)
> > */
> > match_offset = recent_offsets[offset_slot];
> > - recent_offsets[offset_slot] = recent_offsets[0];
> > - recent_offsets[0] = match_offset;
> > + swap(recent_offsets[offset_slot], recent_offsets[0]);
> > } else {
> > /* Explicit offset  */
> > 
> > -- 
> > 2.46.0
> > 
> 
> Hi Konstantin,
> 
> I just noticed that v1 of this patch is already in next (commit 
> 7495ce846bbe4f38d7ea5e023e44ad864b6348ad), but v2 fixes a possible bug 
> reported by kernel test robot (match_offset is still used later).
> 
> Could you take another look at it and apply v2 if possible?

The kbuild-bot only complained after the code was already merged.  Here is the
bug report:

https://lore.kernel.org/all/38752402-3a41-45f0-97ba-4f208d17337b@stanley.mountain/

I don't know if ntfs3 git tree rebases, but generally the advice we would give
would be to assume it isn't and write a Fixes commit which can be applied on
top instead of a v2.  If it's a rebase tree, the maintainer will know how to
fold the two patches together.

Thanks for following up on this.

regards,
dan carpenter


