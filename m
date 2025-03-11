Return-Path: <linux-kernel+bounces-556493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D64A5CA8B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A48D3A4319
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928B425E833;
	Tue, 11 Mar 2025 16:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="jPFxb08y"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684BA259C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 16:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741709728; cv=none; b=rqfB/Hd3Ugg4aOuOl7gUvmyO4NFjU+e+QvZ5K6wKE5ApY+97sQwsA9wsqlyJ1BHE+SXzblBww7sb7B7spdxslDvoZy6qRkvKGA/Zcuyo9Ph1x4tYYZb7SPXaj4zuZO8irjh4+y2vzrtEg5xogPzlTgn8o8mAlvXP1lhREPL/1fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741709728; c=relaxed/simple;
	bh=y9NcK49R6V3WQBMU/3Bd8ThsPavXQqygi3RvWAeH9gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=POzkU1E0M0W1HbtRj7RKs74LACJxRo5hqQWih76K8f8gBXX6En+JA5kNOwgP0oVoJi774RqtHPLftCavWpSKj4SkpxbdA7QlgzuQpQT/sJ89Vo0olGavCu6yWIds/mJmPWbiD+jZBs3KX7dBTi+1HTRylw55WmyV7Z6Kvn92NBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=jPFxb08y; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6dcd4f1aaccso83003476d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 09:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741709725; x=1742314525; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+ctWxbKDFvJQjTOqLK3W0WOLogRld+0VnOA3SYeJG4o=;
        b=jPFxb08ysrsT6ixCkbd/80JbbbixvuIHBC6Kxxt99wAk4oIp+LDkCdtdKql+jL3mAc
         tJp+yHaY+vKwN8G5nLUPwiJ11VfbN4MhYP+5ems1Qa3zBmmZdFJuRemy3ZgteWVzyX81
         EICgGLKDs5GRuKjok7FPs64qzoDhZhka0aqt4ZyxPGibAFXd7yLcDHLfzwxbhWT+qeUM
         yagttXYVW1syCBpeZKsaRjrjvGrB+TkyWQUXIhLCNuii7w1RZuwO9YMZN/RxdW+ckwdw
         nDw7i0sqnfw/9u1CVbf3cySslnYLQWNBQoiAKORkGe5+ZpxTSenwvSWxGST9ZSdqyepT
         eTYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741709725; x=1742314525;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ctWxbKDFvJQjTOqLK3W0WOLogRld+0VnOA3SYeJG4o=;
        b=WQNvTjpLOP9B9/mSXYzrDj38FkkZz9vNFYZt19dnno79XsdAdVtaeD4WisenpqQfop
         zxWgg3JCi7Ltd0u1HjWJwosUIToqtWptIl8Ojw3hmCCvKiVzOYjeyY2knUi3bv35dG3k
         lNgC6eauVaVF6+gtPhRO3rmrE6oDbgosJeTW0nm4mie1XZTaxQ3jCeiIdzMX0Dil3gmt
         MCdyBHzdMVppoXpEmwcehi6BtW3g6moBjHHOvR0RweBi++Scfa7pyvto/YDJ7N+/wAX5
         yRiFcFd1iSfWI0TqGuv2hGwojybdSgrm4BJUOS1F7JAjsrsSZYGt7/4ws+FEZruD68so
         UUag==
X-Forwarded-Encrypted: i=1; AJvYcCWk2gzG5KZx4+k5TUtRKLA5nLQ64vlUaz43nhExtwuXNx2iWaarez7dXNeRCgHTHGIi7TNmmvjjLd65IZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIo4Fc+lplhjlvmoKrVnL07C0Nv91atfv8wnbtofJliVsN0kQm
	p7fYWZJZ9yXgtxZ4f5MTtd2UfKg0EUStXZ6iu66ust7gNNqB4POtOaMjsq6IdbA=
X-Gm-Gg: ASbGnctL259Zrn+muyqBr7Ddd8+Ti84yfu/w2P7nRxlYH+36jE0nGj4g/ESm2Zsy0tB
	YDEyvFp+P8naUZCW+fgboxm1TnRzKExM0aYZRdHIXYz3IpdVMuOSELi/cCxy+U35lJPvXG2MlqF
	D9zW1wsPBofjjHemiUK677PWeo1AysT93sl0aGYmwpkXyRUDLL7lXQN0vmHcZeY1NXyhgIN4PCG
	04qPT1XHGSlE2IZQ6G+JZryuzVRb1/DX6ksZNmOuO7SOrdziZYewawZ4iVTGXu6/6orIvGgqguM
	a20+VYO8e9Q4bI46HZnlz6z5iZJRZ3iMJiA2n8SRtjCJpxsTlgnn1eVRjg4O+ZlnzrFq4iG5GD2
	lgSvxIZqaHOLA9vkyVqi+W6pjwsE=
X-Google-Smtp-Source: AGHT+IEngW+whjtSsGen92TRPPuxKluaJqI8wEtaAWqqtJh7Qsb0QErvZ+cCKG9luxZznTxhTIBdSA==
X-Received: by 2002:a05:6214:c64:b0:6e8:f65a:67c5 with SMTP id 6a1803df08f44-6e90061f684mr206274106d6.11.1741709725208;
        Tue, 11 Mar 2025 09:15:25 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f7094611sm74058526d6.50.2025.03.11.09.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 09:15:24 -0700 (PDT)
Date: Tue, 11 Mar 2025 12:15:23 -0400
From: Gregory Price <gourry@gourry.net>
To: Zi Yan <ziy@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>, Yang Shi <shy828301@gmail.com>,
	lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CXL Boot to Bash - Section 3: Memory (block) Hotplug
Message-ID: <Z9BhmzZBOU3NyTkR@gourry-fedora-PF4VCD3F>
References: <Z7TLwtQY3vGUw2bO@gourry-fedora-PF4VCD3F>
 <1b4c6442-a2b0-4290-8b89-c7b82a66d358@redhat.com>
 <Z7TswQbpPV590ADr@gourry-fedora-PF4VCD3F>
 <bda4cf52-d81a-4935-b45a-09e9439e33b6@redhat.com>
 <CAHbLzkqDQcrHLPzk8n0SMgkidH2ByCqdwfYXX=uBPQfOArWf8A@mail.gmail.com>
 <Z7d3vVdJ8UWU5oex@gourry-fedora-PF4VCD3F>
 <4ae838ee-b079-408e-8799-e9530ca50417@redhat.com>
 <0C5749C4-B3EE-4393-A8EA-AA56B399E9E3@nvidia.com>
 <Z9BdwFZ-ZRpMSabG@gourry-fedora-PF4VCD3F>
 <7A60A7B1-0BFF-45ED-8A11-06F0D5286723@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7A60A7B1-0BFF-45ED-8A11-06F0D5286723@nvidia.com>

On Tue, Mar 11, 2025 at 12:08:03PM -0400, Zi Yan wrote:
> On 11 Mar 2025, at 11:58, Gregory Price wrote:
> 
> > On Tue, Mar 11, 2025 at 10:53:41AM -0400, Zi Yan wrote:
> >> On 20 Feb 2025, at 14:26, David Hildenbrand wrote:
> >>
> >>> Yes, the only way to get some 1 GiB pages is by using larger memory blocks (e.g., 2 GiB on x86-64), which comes with a different set of issues (esp. hotplug granularity).
> >>
> >> An alternative I can think of is to mark a hot-plugged memory block dedicated
> >> to memmap and use it for new memory block’s memmap provision. In this way,
> >> a 256MB memory block can be used for 256MB*(256MB/4MB)=16GB hot plugged memory.
> >> Yes, it will waste memory before 256MB+16GB is online, but that might be
> >> easier to handle than variable sized memory block, I suppose?
> >>
> >>>
> >
> > The devil is in the details here.  We'd need a way for the driver to
> > tell hotplug "use this for memmap for some yet-to-be-mapped region" -
> > rather than having that allocate naturally.  Either this, or a special
> > ZONE specifically for memmap allocations.
> 
> Or a new option for memmap_on_memory like “use_whole_block”, then hotplug
> code checks altmap is NULL or not when a memory block is plugged.
> If altmap is NULL, the hot plugged memory block is used as memmap,
> otherwise, the memory block is plugged as normal memory. The code also
> needs to maintain which part of the altmap is used to tell whether
> the memmap’d memory block can be offline or not.
>

Also just to be clear, this is only an issue if you intend to use CXL
memory for something like 1GB Gigantic pages - which do not support
ZONE_MOVABLE anyway.  So for this to matter your system must:

1) Require smaller than 1GB alignment for memblocks, and
2) ZONE_NORMAL CXL memory.

The whole thing is mitigated by telling your platform vendor to align
memory base to 2GB and having DCD's allocate in 2GB aligned extents.

Both of these are reasonable requirements for hardware, requiring a
major kernel reconfiguration seems less reasonable.

We should continue talking, but I've reached the conclusion that simply
telling platform vendors to fix their alignment is a better overall
solution.

~Gregory

