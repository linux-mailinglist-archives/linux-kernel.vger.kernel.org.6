Return-Path: <linux-kernel+bounces-205905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF660900205
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D181A1C20F34
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524A318F2E4;
	Fri,  7 Jun 2024 11:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HQbFeVbn"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAA118F2E8
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 11:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717759260; cv=none; b=H7Z9Y/C4trP3SnAryXBg4al3wM7ErlOtjUcZb5DfUpjM2udCrETP4GwLNlv+M3NvWKikEUfCkxFVH/pEfqgNmYuJbtsrjnEO4QyPA7H1g/bBDbydgoKDxgCT9lbtzQHrORrxg2Ooy6Xilk34IaE66NxXU82OKYwuhptgjQWwg18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717759260; c=relaxed/simple;
	bh=wLlqEnTMzvl4zezBFVRXjpR1/dHO33xlCjj0rcjfKtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZW5f0FSBBk/gGqb7hAWNID6gj9gLCG2nlvnhu5pP5aXPSH4bEt5wIP+3/9ODmp1mNNHrlJiGZKZ/3r+JRtH+qufttDinftNeie/IxMqETqM6EcyQu2WabfiAPM7XY42Av/ioUtrZdyat0D7ut6UfF8ubeT0NgjpNxXEh2/59uxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HQbFeVbn; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6f4603237e0so1239075b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 04:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717759258; x=1718364058; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E2l49zcksVFHxJOzvcguhpGhpvEDYlJVx4kXyjc2FXw=;
        b=HQbFeVbnJaVy24pI52EgsGxpC4qWyz/cMVjGhb0FwYYevP1C8xYYFj+MA1+4uzgwMk
         XC1Tp1VMRdEb35mYIl7cwThZ8YmKoPN8nZKQ5peeRxCqVjpP3csXoH8Um5PoxZKUcW/7
         W7nkO6O5WHEUrfeiQ3NJFPCgxHZThNuyiRFtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717759258; x=1718364058;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E2l49zcksVFHxJOzvcguhpGhpvEDYlJVx4kXyjc2FXw=;
        b=rUMKzmhA3L0OvNGj17zaxWtp1TNaPqtZ8EqZsT32m019Ms+a/HbgCpy8bSvHmw0cZY
         PIkJRPH8irsT8odBLsprupA4oaEmabGTsBz0TbqehkOHAdiSl1tMOEqT/I00lZOLNati
         kLsi3B5iyStbwPHLtSjwU3U5ZMUUiFrzLvIsjewHNpGOCvhZd9WBF3rVR5jjQ+peEMO+
         XK7nHa/h0ng5dVs+m5IrNN9/1diLawGraOlBaj0EnRiNCN9eurauA6q8LNMadPCCrvVi
         lQP25gC1ksK6qe2R0L0VYWoBS/iOF9f7C8B5y/smSbimuQwNJt/E3KONVISi1xXl4pZe
         yscg==
X-Forwarded-Encrypted: i=1; AJvYcCW4BILyBKX2ccBHZo/jWQrJYOC1ed/W48OplYrsZ4eW5ON00ioGeKNwZn8d9SyqoaglA09dMgKgTxMLq3xju7Mal08yLB6o0fyX+bh6
X-Gm-Message-State: AOJu0YyrYK7hYZ47UTz9Xt730okVQ4kytHSyPC2p2UWTZOa/Jc427Ktp
	c6H+33S6f9U978jm3wDrZ+VrIp/bgirgmbqR0KsBFOlQhBsNH2kxjP6rtmWCbQ==
X-Google-Smtp-Source: AGHT+IFZnai7nKK+47+INXizzgR1Xx/LFDvPDJsaelMa42GjTo09b1xp3Xvko+TvKEPwpjRbZYeKxA==
X-Received: by 2002:a05:6a00:308d:b0:702:5514:4cb8 with SMTP id d2e1a72fcca58-703f85f2828mr5811403b3a.4.1717759258453;
        Fri, 07 Jun 2024 04:20:58 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:bd91:9a1b:54a5:7a73])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd3b187fsm2392521b3a.85.2024.06.07.04.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 04:20:57 -0700 (PDT)
Date: Fri, 7 Jun 2024 20:20:52 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Yosry Ahmed <yosryahmed@google.com>,
	Erhard Furtner <erhard_f@mailbox.org>, Yu Zhao <yuzhao@google.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Johannes Weiner <hannes@cmpxchg.org>,
	Minchan Kim <minchan@kernel.org>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Subject: Re: kswapd0: page allocation failure: order:0,
 mode:0x820(GFP_ATOMIC), nodemask=(null),cpuset=/,mems_allowed=0 (Kernel
 v6.5.9, 32bit ppc)
Message-ID: <20240607112052.GA479513@google.com>
References: <CAJD7tkZ+QY55GTzW9A7ZCm=rxAEfrW76cWXf8o5nwiKSXp8z=w@mail.gmail.com>
 <20240604231019.18e2f373@yea>
 <CAJD7tkYq5u7B+0UH2XKpeWJnUxoO2kJ1_XZ2JOgYpyNEVR7u0g@mail.gmail.com>
 <20240606010431.2b33318c@yea>
 <CAJD7tkbhWYzx=6YmzAh0F+cK-_Bn8mPOH7gMbQS7YVXmaFSgFg@mail.gmail.com>
 <e68bcc6a-25b1-42aa-83b3-5d457b254cbe@linux.dev>
 <20240606043156.GC11718@google.com>
 <6335c05d-9493-4b03-85a7-f2dd91db9451@linux.dev>
 <20240606054334.GD11718@google.com>
 <CAKEwX=OAEzKW9zO9pn41V71A8Ua2dJjD3DY6RsDMNdSd-4ts5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKEwX=OAEzKW9zO9pn41V71A8Ua2dJjD3DY6RsDMNdSd-4ts5w@mail.gmail.com>

On (24/06/07 10:40), Nhat Pham wrote:
> Personally, I'm not super convinced about class locks. We're
> essentially relying on the post-compression size of the data to
> load-balance the queries - I can imagine a scenario where a workload
> has a concentrated distribution of post-compression data (i.e its
> pages are compressed to similar-ish sizes), and we're once again
> contending for a (few) lock(s) again.
> 
> That said, I'll let the data tell the story :) We don't need a perfect
> solution, just a good enough solution for now.

Speaking of size class locks:

One thing to mention is that zsmalloc merges size classes, we never have
documented/claimed 256 size classe, the actual number is always much
much lower.  Each such "cluster" (merged size classes) holds a range of
objects' sizes (e.g. 3504-3584 bytes).  The wider the cluster's size range
the more likely the (size class) lock contention is.

Setting CONFIG_ZSMALLOC_CHAIN_SIZE to 10 or higher makes zsmalloc pool
to be configured with more size class clusters (which means that clusters
hold narrower size intervals).

