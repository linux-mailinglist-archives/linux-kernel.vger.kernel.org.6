Return-Path: <linux-kernel+bounces-238152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 059149244F6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 19:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31E121C22057
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 17:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B9A1BE232;
	Tue,  2 Jul 2024 17:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+u7OU6Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CC51BE22A;
	Tue,  2 Jul 2024 17:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719940602; cv=none; b=V30ZmZk0BlRWaP8sA1W8N3/UQvMFz791nI7g6yYh90C6oV0Fqwbi6QGykEMwqsrME4STqdC/KjdMxb/21bhCmanmeE1eGt6CQluHPvmHtlUVBpNBAAjMKcBrhuSKc7lgnhlyo4lSYcUYOmZg5NChKISoDyk5M71HAa+jQyi3Nu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719940602; c=relaxed/simple;
	bh=f/M+sNyCwuSUx8B+9svKR0RPND8pbkXc8FBBEmXL93U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RpJ/UFW+kZeVc7so9o2SoK7ctFeam9crhtNHsT3CH9LI2Gs6nDln+5MkojnSRDsfGUpVytn4aoLN7S3BPlDWBZjohaAcDxQ73fuHWrhpV5pO3HElgEhArvjvlMq3O20s7o/euNX6rr4xzBOTNa+Yg+Q+X7VV1R8+ANwPcmWozUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+u7OU6Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D27C3C116B1;
	Tue,  2 Jul 2024 17:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719940602;
	bh=f/M+sNyCwuSUx8B+9svKR0RPND8pbkXc8FBBEmXL93U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W+u7OU6YHMF9dg/txZ1c9k9EILUgrFVbUCo0ncrE0x+MX0+2u0WIw929KbOAHXQ0M
	 5+T55dcSEtoLXBvOAiSSOl0vUMhEGTZMOhmYqY0i2HRaRKSc0QcWyPA5oTykC/cO4b
	 hPpCKGryQ3UlnJttv/Y9JAepr8mHIgRsfAgwkghqq9yXurqMKWMXuEmLO+UFBZZioS
	 dDQroXDCwyDpcQsphR2sEHUpbcVMXZgP99+rSiMu4jemPPHuA9G36KnvKn5cEcDfWs
	 9HH5JajKNBLjl5PUi3EQ+p9AFzUEpnRKtncJP6A1D88lrOBf60A/ObbF9o/MGzsBTh
	 4/a+yoXZGrRZg==
Date: Tue, 2 Jul 2024 17:16:40 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: dm-devel@lists.linux.dev, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, linux-kernel@vger.kernel.org,
	Sami Tolvanen <samitolvanen@google.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 7/7] dm-verity: hash blocks with shash import+finup when
 possible
Message-ID: <20240702171640.GA1049704@google.com>
References: <20240702064835.120541-1-ebiggers@kernel.org>
 <20240702064835.120541-8-ebiggers@kernel.org>
 <CAMj1kXFE45J9fDJ9XtMyJiUP1F-odZUmH0zLKkuZeWL_bLdDZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFE45J9fDJ9XtMyJiUP1F-odZUmH0zLKkuZeWL_bLdDZQ@mail.gmail.com>

Hi Ard,

On Tue, Jul 02, 2024 at 09:41:19AM +0200, Ard Biesheuvel wrote:
> >  int verity_hash(struct dm_verity *v, struct dm_verity_io *io,
> >                 const u8 *data, size_t len, u8 *digest, bool may_sleep)
> >  {
> > -       struct ahash_request *req = verity_io_hash_req(v, io);
> >         int r;
> > -       struct crypto_wait wait;
> > -
> > -       r = verity_hash_init(v, req, &wait, may_sleep);
> > -       if (unlikely(r < 0))
> > -               goto out;
> >
> > -       r = verity_hash_update(v, req, data, len, &wait);
> > -       if (unlikely(r < 0))
> > -               goto out;
> > +       if (static_branch_unlikely(&ahash_enabled) && !v->shash_tfm) {
> 
> Is the static key really worth the hassle? Couldn't this just be
> 
> if (unlikely(!v->shash_tfm)) {
> 
> so that the ahash logic is moved to the cold path? We need to
> dereference v->shash_tfm right away in any case, and if it is never
> NULL, the branch predictor should be able to remember that.

The value of the static key is indeed marginal.  I included it because of the
precedent of dm-verity's existing use_bh_wq_enabled static key, which exists for
a similar purpose.  As long as we're going through the trouble of doing that, I
think it makes sense to use the same pattern for ahash too.  It's another rarely
needed option that can be patched in in the very rare case that it's needed.

- Eric

