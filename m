Return-Path: <linux-kernel+bounces-556657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FC1A5CCF2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5CE5189D923
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37359262D0D;
	Tue, 11 Mar 2025 17:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X66YWyFW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883391EDA3C;
	Tue, 11 Mar 2025 17:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741715973; cv=none; b=QFrn1I5NffD161p7++5kQdpORwyM5BW7TOUfhb93ZhiJCOvF1pQB4o8Cg4pkUyPrSChoTgmnBsS6ZtxsZs5Kkkgptw/YbsfwKY6Us2/yZT0mT9uc7fUFGcPg4iVplrIMrbVwgUOuxMnBLx39YfWcB9VWkoc4bDT/53tJSwpKX28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741715973; c=relaxed/simple;
	bh=LcVYG/7KVwJ7seJ/zI0EBvrVmDu677dDQezkVFkJ2JM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J09Pql/SlgWjml90nJKZIyY8AsIfFk8eDWGyuLiqLHUVw0eaJa1FyTq+hQiR+TivhMtaOoAp5JDKRGm96dKhDgcW2lwyeP2MYwQF0x5ZCkYzzDJ4Wq1CfgKoAomV+Epp12j+MENLfZ2iYUg05lINwZFxf8tTXtB+5C2Q9+tlOfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X66YWyFW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB94CC4CEE9;
	Tue, 11 Mar 2025 17:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741715973;
	bh=LcVYG/7KVwJ7seJ/zI0EBvrVmDu677dDQezkVFkJ2JM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X66YWyFWlQavZMSEKVZpeKS06oGHxn3Fzk+AmTT69O4dxKbRK3sGh6aWZDEhK2fAC
	 S9Lof8uquiB/HTbsxsA592/v98n5mnmvVx1meVzpgzkaARG9PpwprwdUH6r83k6bMu
	 pVgKqSQ4hrBmuT5tkecjRIEgdgzig3lrBcCbG4tXmffxD/JjR9vJoWuuTRIm2FUQ+e
	 5AAzWWY0AMmBIw0DHcfJrmVjbqxE4yUFR3sglRidn4TLiuoFkb9XRS/TjO5IKBB0i2
	 QLvZkVsrlRdAy1uR+5M7QJvptjevcYE154Tfo6fpYoTf/liAyQhCVrkghRrQEp43in
	 +PBDFAiWcKcbg==
Date: Tue, 11 Mar 2025 12:59:31 -0500
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	patches@opensource.cirrus.com,
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v3 3/5] ASoC: dt-bindings: wm8904: Add DMIC, GPIO, MIC
 and EQ support
Message-ID: <20250311175931.GA3885406-robh@kernel.org>
References: <20250307135244.100443-1-francesco@dolcini.it>
 <20250307135244.100443-4-francesco@dolcini.it>
 <20250311-solid-poetic-camel-77a29b@krzk-bin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311-solid-poetic-camel-77a29b@krzk-bin>

On Tue, Mar 11, 2025 at 09:42:45AM +0100, Krzysztof Kozlowski wrote:
> On Fri, Mar 07, 2025 at 02:52:42PM +0100, Francesco Dolcini wrote:
> > From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> > 
> > Add two properties to select the IN1L/DMICDAT1 and IN2R/DMICDAT2
> > functionality:
> > - wlf,in1l-as-dmicdat1
> > - wlf,in1r-as-dmicdat2
> > 
> > Add a property to describe the GPIO configuration registers, that can be
> > used to set the four multifunction pins:
> > - wlf,gpio-cfg
> > 
> > Add a property to describe the mic bias control registers:
> > - wlf,mic-cfg
> > 
> > Add two properties to describe the Dynamic Range Controller (DRC),
> > allowing multiple named configurations where each config sets the 4 DRC
> > registers (R40-R43):
> > - wlf,drc-cfg-regs
> > - wlf,drc-cfg-names
> > 
> > Add three properties to describe the equalizer (ReTune Mobile), allowing
> > multiple named configurations (associated with a samplerate) that set
> > the 24 (R134-R157) EQ registers:
> > - wlf,retune-mobile-cfg-regs
> > - wlf,retune-mobile-cfg-hz
> > - wlf,retune-mobile-cfg-rates


> > +             * Config registers per name, respectively:
> > +             * KNEE_IP = 0,   KNEE_OP = 0,     HI_COMP = 1,   LO_COMP = 1
> > +             * KNEE_IP = -24, KNEE_OP = -6,    HI_COMP = 1/4, LO_COMP = 1
> > +             * KNEE_IP = -42, KNEE_OP = -3,    HI_COMP = 0,   LO_COMP = 1
> > +             * KNEE_IP = -45, KNEE_OP = -9,    HI_COMP = 1/8, LO_COMP = 1
> > +             * KNEE_IP = -30, KNEE_OP = -10.5, HI_COMP = 1/4, LO_COMP = 1
> > +             */
> > +            wlf,drc-cfg-regs = /bits/ 16 <0x01af 0x3248 0x0000 0x0000>,
> 
> <number>, <number>, <number> ...
> 
> unless you wanted 64-bit?

Why? You would need "/bits/ 16 <number>, /bits/ 16 <number>, ..."

Rob

