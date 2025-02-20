Return-Path: <linux-kernel+bounces-524664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 338E7A3E594
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 21:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5AEC3B791E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 20:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7C42641EB;
	Thu, 20 Feb 2025 20:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ovXM+/vW"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726C81E9919
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 20:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740081980; cv=none; b=anxlfHQFTQzh9nT44sM80XBxwaEG8Tu2vLIPE/vsvnjJ5p6CN0EhZuo+zgwecaOvD4Z8yyz2D/Om6QR7BNZ6QSITPcld+/t87Zyw5cL1CRltiMXWmfG5/8f5RTtUtvCpBMQS1JASDuCIKLq645DYIKYPxVWXMxM68hET1aJziQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740081980; c=relaxed/simple;
	bh=Lu62kKHMAjMzflS7Jlf2vQo4LhUNA22Sn176RTqDkwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6ZeS2lRmIu86zW2ju7p9/ADYn+qT9b1Qk0MrFKeTmqjIPpW/7LM8b5zswDNBJc19U147RCN/55u0Fl/nZq6xEjn4twQR4hKA6A1I4FFfLDy/nxcUiFhvDTPMlh4Sr7tRgIeGVIzd0Zd3Tt4dqKIy6trptQRIjyS0eMs6QfwiGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ovXM+/vW; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-471eb0e3536so6976771cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 12:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1740081977; x=1740686777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K1KlFOn7Hg/ku1RTZ3R0CMdwBj99t0GI1rv1OK6Mr2w=;
        b=ovXM+/vWrkZBcNky/EZT6KkymxwUILtIhEBx0FDrm8vblAWSmFGjy5ULAFdee9cRje
         tbazEfal6L57f22h9rWyzAv8H2A9QCb+nmqmqXQr3NCrC2XfU2Pi3bXToYY0Ah1E6mIx
         oIaamsoCRumKV7OSeAHSRde2D7PcstFsw0qBWjTXAP16RtXkpeW7yuKP5KXS2Hww6uh2
         Aj8ffWZBBdCW4hno5CPiRq8KiwS4TGxLJsuLltvsLGUohxJxyEkZsBOlutY53Xjtqb2R
         o3upJL9aPg4ItdXyf2MVyidvX/EjUVQ/0hwuzsvtTFzjLu1i/YiCbizzqGGlfrzHiOn/
         6+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740081977; x=1740686777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1KlFOn7Hg/ku1RTZ3R0CMdwBj99t0GI1rv1OK6Mr2w=;
        b=U/EpNMs0MLQ7X71lMgsWQ2D5DFT5EteKZ20J3/4JUFXieQhSVBTacgslXLHP6ur/hu
         xmNCvmycMWOUf0lEQ8v+JzkgTx2DW3BT8FZK5QPd4z4sBnV/Pm+n8rFBWUDtTqJVAdZY
         SKw8/BpQi58EcWagHL+HYA0rcZv9i3nTDOhV6lXLvukVrsdGzMuyevuB1VeRjzxTYx11
         rUkGhivhFimNB0Yc2asi3Si709gc+CN031r+ly78DbS3VtZXSaR7LNDSPVVn3DUYYp8t
         PSrNIaJb7h8kKcApu+5SDZjEIE6+PbHa/NQcOFuCvLDrlB1WB+hnr+u0ycpJUTZphJef
         GB4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUOkA5ZbaXgz7rTvUnOZBYM7AqeS67vZUEOmomAlZdcvLI+zH8Dg1hgz5/e9qC5uawcYcJ7jN2adZX/3N8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4WY4qEljX4PXC+RabFPABI+P2xeoAIEsgBP5nADgjAU4oKwI3
	9DOW0DZXiU7BtYDmfcG6C/omlLkw66eSX1WuWuLI+BVb7iL6HzEGMRdd1QgukrcWe35ee6flxli
	K
X-Gm-Gg: ASbGncvomTqU5Zaieg3RcojV054CjBPsZZoaxBKvbxSeERya8rOa840BqZ7zcdj/e/H
	moEKmy5tuT/ol2qSTTYNq/C+10iM0VBwvnjqSMLNwU6YfC38Zy1zPKWGU69T/Ujt5FgKMxW6cxY
	IW2uitpVP9Fk6vOYZRchumeUIwaD2FLJEVmC0YYohVkUFeDVVajsnUX0JULosZZ1hV+ufrq/ALJ
	TSWRCdvX/dT7zFVLfuuavmk18g7j2XIwl181t5aKThEeGR+vMzND0ts17d0F4AxCHxbuMdV63Kc
	CN9BEKi+ZHFRENRsSyLKV6hDICQrFCGn6fo41W8kozP/YoebAwhNNd6Sc8VAr53XgpasuT0bOA=
	=
X-Google-Smtp-Source: AGHT+IFqBXc3noHLl5J5ssCf0WWyGmo3wgivenGX96bW8nMSdpZU57GvoBw1O5ge2vFl9td66zPrCg==
X-Received: by 2002:a05:622a:13c7:b0:471:f3f2:62eb with SMTP id d75a77b69052e-472228ce17amr8517751cf.19.1740081977267;
        Thu, 20 Feb 2025 12:06:17 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471ead6bdeesm51910061cf.32.2025.02.20.12.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 12:06:16 -0800 (PST)
Date: Thu, 20 Feb 2025 15:06:15 -0500
From: Gregory Price <gourry@gourry.net>
To: David Hildenbrand <david@redhat.com>
Cc: Yang Shi <shy828301@gmail.com>, lsf-pc@lists.linux-foundation.org,
	linux-mm@kvack.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: CXL Boot to Bash - Section 3: Memory (block) Hotplug
Message-ID: <Z7eLNyB230-wYof-@gourry-fedora-PF4VCD3F>
References: <CAHbLzkq6Me6nRaL6b09YxJ_nFkxb+n+M3-q_aJwOs2ZO4q8VCg@mail.gmail.com>
 <Z7TLwtQY3vGUw2bO@gourry-fedora-PF4VCD3F>
 <1b4c6442-a2b0-4290-8b89-c7b82a66d358@redhat.com>
 <Z7TswQbpPV590ADr@gourry-fedora-PF4VCD3F>
 <bda4cf52-d81a-4935-b45a-09e9439e33b6@redhat.com>
 <CAHbLzkqDQcrHLPzk8n0SMgkidH2ByCqdwfYXX=uBPQfOArWf8A@mail.gmail.com>
 <Z7d3vVdJ8UWU5oex@gourry-fedora-PF4VCD3F>
 <4ae838ee-b079-408e-8799-e9530ca50417@redhat.com>
 <Z7eEGwFltjWaoX-r@gourry-fedora-PF4VCD3F>
 <b4b312c8-1117-45cd-a3c3-c8747aca51bd@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4b312c8-1117-45cd-a3c3-c8747aca51bd@redhat.com>

On Thu, Feb 20, 2025 at 08:44:36PM +0100, David Hildenbrand wrote:
> On 20.02.25 20:35, Gregory Price wrote:
> 
> There were some discussions around variable-sized memory blocks. But we
> cannot rip out the old stuff, because it breaks API and thereby Linux user
> space. There would have to be a world switch (e.g., kernel cmdline, config
> option)
> 
> ... and some corner cases are rather nasty (e.g., hotunplugging boot memory,
> where we only learn from ACPI which regions actually belong to a single
> DIMM; dlpar hotunplugging individual memory blocks of boot memory IIRC).
> 

Probably we just end back up between a rock and a hard place then.  Let
me finish this documentation series and cleaning up corrections and I'll
come back around on this and figure out if it's feasible.

If variable sized memory blocks in infeasible, then the only solution to
misaligned memory regions seems to be to wag a finger at hardware vendors
as Dan suggests.

Thinking about my current acpi/block size extension, it does seem bad
that the user can't choose to force a larger block sizes without a
boot parameter - but i hesitate to add *yet another* switch on top of
that. The problem is complicated enough.

~Gregory

