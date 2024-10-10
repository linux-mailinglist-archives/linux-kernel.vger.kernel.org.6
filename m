Return-Path: <linux-kernel+bounces-358249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D71997C05
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 06:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4589285DD1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 04:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AB019DF7D;
	Thu, 10 Oct 2024 04:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMS6s0s6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0114A07;
	Thu, 10 Oct 2024 04:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728535942; cv=none; b=Wnuia6esMruyF0wu/rnZ0aWXwbZkpEbU8+8wH480vVTxhCl9OAjGnhAcjNqZhpC+pmvGF8GBpTKl8yyeNsAS1uwfHbM3209mtaMC8HqBt2cvrJM+sHYRx0nuVVZi1Iw40IOccOtUvow7MquhqN+26s3WakF1N2AmERDoHOK/PGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728535942; c=relaxed/simple;
	bh=unHAhpTlcXmGgRRxD+5eMfkCFlRtvsOf2E77spDnXow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/zdwqOv089pkzUBkm6nb3qH8AGerO1NbCFIOXNdX9dbW+XOe90YRbbjJXF7mDJ/7LKLOJZzPaMcJtLYP8nAfAkoER7a6JJ5+wKmCow92IyuRqi/7n/nrarHUiShmN74M3t3mFt4gR52aVczPSKT9Od4UKClMa54WEuSn7hMp7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMS6s0s6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB50C4CEC6;
	Thu, 10 Oct 2024 04:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728535941;
	bh=unHAhpTlcXmGgRRxD+5eMfkCFlRtvsOf2E77spDnXow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aMS6s0s6ZOlwW8CvPE1lHPUUUIHQ7ma1Cvarf9CIKJMZ8eweyqyi5mUUk6FkZp9lF
	 WvxkkoH/raFz162aLmrY37bg/Qjh5bKo5HtvNChaaRqLAKT+fAO/qxzvQH4Hvx4ZRP
	 gXTqxU1hU01cJXpcLANZq9lw8ZISF6zTrpgTML9rzNhhccYuZcFChLm4srJWTf6/t3
	 5HKp9YGdR40C6zWPZ9mi5LQ/fjXxZPTtKvOdUZOMazCoNMC2btmUY3VSmkBwsU/WA3
	 +dx2VJHgHThovBtFgAd5h9QN0RCuPgDBx4msB/T+sHqDp7F3iWVKqT5yAyDIRw0XHB
	 etezacO6opYDA==
Date: Wed, 9 Oct 2024 21:52:19 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: "Kaplan, David" <David.Kaplan@amd.com>
Cc: Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pawan.kumar.gupta@linux.intel.com" <pawan.kumar.gupta@linux.intel.com>
Subject: Re: [PATCH 1/6] x86/bugs: Create single parameter for VERW based
 mitigations
Message-ID: <20241010045219.vgpcl7nfqaimqrne@treble.attlocal.net>
References: <20240924223140.1054918-2-daniel.sneddon@linux.intel.com>
 <LV3PR12MB92651F4DF654C886B9F2BCF7947E2@LV3PR12MB9265.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <LV3PR12MB92651F4DF654C886B9F2BCF7947E2@LV3PR12MB9265.namprd12.prod.outlook.com>

On Tue, Oct 08, 2024 at 07:24:01PM +0000, Kaplan, David wrote:
> > There are currently 4 mitigations that use VERW to flush different cpu buffers. This
> > can cause confusion when trying to disable all the different VERW mitigations.
> > Simplify enabling/disabling these mitigations by creating a single parameter for
> > controlling them.
> 
> Just curious, what is the use case for disabling the different VERW
> mitigations (but not other mitigations)?  Is that a testing/debugging
> use case or a production use case?

I'm also wondering about this.  I like the idea of cleaning up the code
mess (like in patch 6) but I'm not sure I see the benefit of this patch
to add yet another option.

Is this a realistic use case?  Are people really going to want to
enable/disable VERW mitigations as a group?

-- 
Josh

