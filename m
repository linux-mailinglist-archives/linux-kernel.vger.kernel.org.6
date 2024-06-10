Return-Path: <linux-kernel+bounces-208810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA83902978
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 21:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D326FB23481
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 19:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8155314E2CC;
	Mon, 10 Jun 2024 19:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="JV5Eh2bn"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB8017545
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 19:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718048635; cv=none; b=uN99HTlbSISnGMRPnxnkIoNfd+NRxi4zRj3wsly78FWOr/bg32bnntxA6BLj+2+uzEULXLUWtzvRhP8SLWnV6xF4d0sLxb37FG2jv5+LdVB5LLu0IYghxZuIuMLlPL1c6jJHCa/tcMhk384ZEUHDaRVoJoMnQe8jjvScMjah5aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718048635; c=relaxed/simple;
	bh=NwQJNx9srCsHR1oXqicEl2zxyVzc0tYR1H1+T/lrpNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PoGEE/t1iKB2NqD/pFtYlACNm2m7IzHUoiPyz+lHkrxcHrlffi1FCbbbeQwC4Qo5h2kW7VRojv7fmAZtkMmDWH+Lnsz/srEOEFkt2R4rOYoGTCNtJcoiHwylZrWY8IqOReLH7mHpMpsYCflDVlJ1SVpglezaYgxiphgjtyNl1bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=JV5Eh2bn; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dfaff6bee06so2888071276.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 12:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1718048633; x=1718653433; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qw5+VsdhRywpk2BTwqyAr7RLtJMnVZ6iQGrwmpugQIQ=;
        b=JV5Eh2bnd97K9r0XUO2eW9cs3WujONVK461rQKSYudpPfs0FYC/ZLoKCGEP85Sh4W+
         uThk4RT4DFeWFUfiP5IZjrpqzZe5x6AedZqsKmTaF7HfTibkNUaNrxK9gt0iLND3qq1K
         xAL1eZGkAM3wWJnHNruc2qYMMlL8QDp0Mw/335nigBILGzr6R1zNNg55ghR1WeoyXhud
         iqQTOWchxqnTF3cE+FgWqRXESEdW6950ITR7uZnje0UINKI/tOYdCIUbkJ6DHSOk9wvb
         3oHmNQ/33mHgQDGvu/3b+i3UX8o9z9Uh9CRoyV6p1k1yyxmsyQmyic7Ej5QfOlr+olI1
         vzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718048633; x=1718653433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qw5+VsdhRywpk2BTwqyAr7RLtJMnVZ6iQGrwmpugQIQ=;
        b=Q4ogfj23llKo9BYdBYj2dVSzzh06eu2JRprnwe4Gffmi4YWZFvAN9m4qm8CYMcX7WY
         WBvAOWz5eyaVexULOKFeC75bh5y3XfMknI+xhfSh+22IAF95MvODlF+SRtE72slF8nMh
         sSoB+RIT4c2eUXQHTtYanCaC1TpDYhebRX08lozSrYff0fBrvLm5PAI8ep/90P0otQcu
         jf1UFNAR4Hy6/VvyjL70BzR0O+TZoIfF1Pf0WDOV/DSDDv47e8VsGDa+e6hCyU5rA+n8
         bAsi3vBdsV74vWxUdw9kDXUx9gnP2DgBqSmnC5zSAUmZ48ry7wTiHhgPZlL67DRKVSb7
         fg0A==
X-Forwarded-Encrypted: i=1; AJvYcCVPAz0Ai3pCGWiXPJJYLSlJ76pv66ts5eoVaUmdyflhCkdhQDGuV0AvSjtrrZpK8PZN3fQlY+6gLWIS7d0DuUygk9pDDRLeXyuZMlVX
X-Gm-Message-State: AOJu0YyRSFh8QELExDNbRWMcMhMK+747tEu91OjaKs8NRIbCOqZ2+g6l
	3k80oIQkBXZB4pggw7j3nARx/13vEJyZNo/Vvvk/j/SADAHynojACfhyh//wWAE=
X-Google-Smtp-Source: AGHT+IFx1drU/OF9dPe5rnR3QcIKC6kbD7HIcAqjMWyaisYYHIilRo2oIwKwsrToihX3KGS+MCceDg==
X-Received: by 2002:a25:d347:0:b0:dfa:febf:5a72 with SMTP id 3f1490d57ef6-dfafebf5d04mr8707739276.38.1718048633375;
        Mon, 10 Jun 2024 12:43:53 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-dfae53027b5sm1735103276.38.2024.06.10.12.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 12:43:53 -0700 (PDT)
Date: Mon, 10 Jun 2024 15:43:52 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Johannes Thumshirn <jth@kernel.org>
Cc: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 2/3] btrfs: replace stripe extents
Message-ID: <20240610194352.GB235772@perftesting>
References: <20240610-b4-rst-updates-v1-0-179c1eec08f2@kernel.org>
 <20240610-b4-rst-updates-v1-2-179c1eec08f2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610-b4-rst-updates-v1-2-179c1eec08f2@kernel.org>

On Mon, Jun 10, 2024 at 10:40:26AM +0200, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> If we can't insert a stripe extent in the RAID stripe tree, because
> the key that points to the specific position in the stripe tree is
> already existing, we have to remove the item and then replace it by a
> new item.
> 
> This can happen for example on device replace operations.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/ctree.c            |  1 +
>  fs/btrfs/raid-stripe-tree.c | 34 ++++++++++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 1a49b9232990..ad934c5469c4 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -3844,6 +3844,7 @@ static noinline int setup_leaf_for_split(struct btrfs_trans_handle *trans,
>  	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
>  
>  	BUG_ON(key.type != BTRFS_EXTENT_DATA_KEY &&
> +	       key.type != BTRFS_RAID_STRIPE_KEY &&

This seems unrelated.  Thanks,

Josef

