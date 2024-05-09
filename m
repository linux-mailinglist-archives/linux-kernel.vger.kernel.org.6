Return-Path: <linux-kernel+bounces-174522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B332D8C1003
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 14:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 671531F23C34
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 12:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8425314A4EE;
	Thu,  9 May 2024 12:56:45 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D3813B5B4;
	Thu,  9 May 2024 12:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715259405; cv=none; b=PpHvLrEdXTlsE+gOmfxqQgC6c0O6wa/TAeIIl3ga6dWZq6QywTR42eRkEV0r+PUehRlLDlnbDDUN/eNnHnxsU9fGA44fQgtRRQUZnSeVjHLdSpQcyjaffwQbcL7C/s/6OTr/gQAQ9dsFRr6Mb+x1/og8WSkA+XPZqwUtVisPGMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715259405; c=relaxed/simple;
	bh=wpigIbeceMTaY2F9pP4aAlMrmJa5Qg4mScZk+XYaoK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJZBxvHSG7VY6kCz2Ua6jL/cTqEfJhZibYC5v16OFAHV4AteWH9AIfi3f6QZtPe3/vDzzTyVyRdY0Z4x8DLcGFjXUx/pUCXlC5iRexnTiepOoBs9yy70apvcd3DztPpxFaH+ANey7aZVPUfFrwKxXrXNdFjbQWZ0DOIaZFKbtV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE78C116B1;
	Thu,  9 May 2024 12:56:38 +0000 (UTC)
Date: Thu, 9 May 2024 13:56:36 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Neal Gompa <neal@gompa.dev>
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Will Deacon <will@kernel.org>, Hector Martin <marcan@marcan.st>,
	Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Zayd Qumsieh <zayd_qumsieh@apple.com>,
	Justin Lu <ih_justin@apple.com>,
	Ryan Houdek <Houdek.Ryan@fex-emu.org>,
	Mark Brown <broonie@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Miguel Luis <miguel.luis@oracle.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Christoph Paasch <cpaasch@apple.com>,
	Kees Cook <keescook@chromium.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Baoquan He <bhe@redhat.com>, Joel Granados <j.granados@samsung.com>,
	Dawei Li <dawei.li@shingroup.cn>,
	Andrew Morton <akpm@linux-foundation.org>,
	Florent Revest <revest@chromium.org>,
	David Hildenbrand <david@redhat.com>,
	Stefan Roesch <shr@devkernel.io>, Andy Chiu <andy.chiu@sifive.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Oleg Nesterov <oleg@redhat.com>, Helge Deller <deller@gmx.de>,
	Zev Weiss <zev@bewilderbeest.net>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Asahi Linux <asahi@lists.linux.dev>
Subject: Re: [PATCH 0/4] arm64: Support the TSO memory model
Message-ID: <ZjzIBEDJPdvrtGm2@arm.com>
References: <20240411-tso-v1-0-754f11abfbff@marcan.st>
 <20240411132853.GA26481@willie-the-truck>
 <87seythqct.fsf@draig.linaro.org>
 <CAMj1kXFqG7D2Q_T_NXZ-y3NYOjK6d8bP8ihJTeFz8TUJ77W7tw@mail.gmail.com>
 <Zjyv23IuJFrk9Zh0@arm.com>
 <CAEg-Je-OXR_dxCUc2Vgm8jzZgs7Ph06jqPKsVQML8Qb5FuTWPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEg-Je-OXR_dxCUc2Vgm8jzZgs7Ph06jqPKsVQML8Qb5FuTWPQ@mail.gmail.com>

On Thu, May 09, 2024 at 06:31:04AM -0600, Neal Gompa wrote:
> On Thu, May 9, 2024 at 5:13 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > I see the impdef hardware TSO options as temporary until CPU
> > implementations catch up to architected FEAT_LRCPC*. Given the problems
> > already stated in this thread, I think such hacks should be carried
> > downstream and (hopefully) will eventually vanish. Maybe those TSO knobs
> > currently make an emulation faster than FEAT_LRCPC* but that's feedback
> > to go to the microarchitects on the implementation (or architects on
> > what other instructions should be covered).
> 
> They cannot ever "vanish" because we are supporting every Mx platform
> back to the first one. The M1 series will never have FEAT_LRCPC.

Well, you missed "eventually". It depends on the timeline you have in
mind but, say, 15 years from now there may not be many M1s around to be
worth maintaining these patches out-of-tree (and they don't make sense
in-tree either because of the lack of standardisation).

> I do not think it is unreasonable to support this method when we know
> what the CPU platform is and FEAT_LRCPC does not exist.

If you want a portable emulator, you better start supporting FEAT_LRCPC*
(I think FEX does this), ideally detected at run-time with a fallback to
RCsc. Whether, additionally, you want to support the non-portable Apple
TSO with out-of-tree patches, it's up to you.

-- 
Catalin

