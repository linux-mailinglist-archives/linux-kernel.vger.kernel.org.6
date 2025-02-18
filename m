Return-Path: <linux-kernel+bounces-520030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB78BA3A4E9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB12D3A962B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A328D271265;
	Tue, 18 Feb 2025 18:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="K0a6GdIy"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD30270ED0
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 18:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739901896; cv=none; b=X7kKqZ36cy8ZX53Qs9aAH78GYthABVY5zczm7GAr3dTCuNE8LrzZVH2KoDUXjnfS12AjopImJ535meQJoYl2JOawYWnC3aobATt4j+Q3BmKDSMRdC0Tc3/blfk6Gv75Nf5RWrypfGFmPNeFAuZT3Z3ypRPhMTndaZf7GRBd7n6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739901896; c=relaxed/simple;
	bh=89YH2L66JdBDvc/z1zr776bVYkPkPpM/OI3XRKn7/0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RXbRxkHMeKUCDEQ+ZTffR5/ss4gCFN8FTzMjc7UXqdfFYaNmaOACYoL07x4SBGuI0C5tIa7Il25lTldhfXWorQNISAKrtRnRzPvvQ/6jZJbmaAKMY6edTSRQUAtLsaqQjaQHxlno26rkvVX6xB1n1EmSrPTffgrTYScu2npbpM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=K0a6GdIy; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c081915cf3so131687985a.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 10:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1739901893; x=1740506693; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/2QkXBrR+RLY2Ff/8MHFN38wGfIHYvjpwObZxuk5dJA=;
        b=K0a6GdIyb3ewk6pQ6b1xuyURq3XEdUo5m64DbGAV0y45eDuLj/MDS2BZr/oRNzUGYI
         aNTlQkGSqRtSIlnkQFJE2sgfpbqzP2GwBh8A6pqGXjAc4QRpDJvDEQGE91YVI+5NYS3H
         AJLRbV2a0dJ8goyv+69bJjzEUwC50EJZW7IxZcghhIOOpyQExcKymOWqTukXu7HoYNkh
         9h0hMGg0YMrW1u4OsLEbKDlC3vj1eokY3Hu2IeS1cD1sUphPpsd5ASwniV7mh7h1EyQh
         nCO/ihxAZDkhvkA72NNbr9nWP9u+hp5mAO6SFW1JAtCjamDrF0p6CQx/KoiWjvSfyBpG
         kyqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739901893; x=1740506693;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/2QkXBrR+RLY2Ff/8MHFN38wGfIHYvjpwObZxuk5dJA=;
        b=rnG9m1tBUM06jph9FhruyNHEuYm7aTmsgImcfYQsPo019QBzSv6V0P/CUcsCUUcDLe
         2EDZ6gwygwGDAVeAeRhh30yuKD7w9Ckx3r3j4izo1lXn7ReGfgnRyub/CGBZzDXkLK7K
         KjVlkigym5X/+iHQL0LRQJjtz0JI+8AUmEb6hJun63XCNKF/bTy0qW9SmWyTKyIU/l//
         jAHO2i8lmaBGGwDOG8IYrV92To/z6Fc18qUwIoiif/44TYoUUijUwZdnkHByMYL0JmlL
         +FIohg+V39+EJqmHA9/EaeEZbjPKAfbaYbAO4ddjhedhGwpepgPwl9TjPYqfoa3MrXKr
         MEuQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7XaWA3qCw85aQGqsMCbfiV+9/u12qP5S4nbqinD4sr76hKs2oOnCHS8ElHoY29isqSBgOjo43zVuPSS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhZG2QYGcFnmyhHC6DFe553/CSsaFDTRyDzIWzcinLyZ8Dhm8n
	Cmi0hcCNGynO7Br+UW0GuuHBlJCB+EllzB6K5rQomJxgKVASMQ5zithQ+VLPixTmqe2P9y8bVPr
	q
X-Gm-Gg: ASbGncueZlvnsDd3H+Y6k1VvQqzDic+70bB7KrCyT3dZKsTrBuJot4VI7sISPdRg8q9
	DBJgZA/B4d30R2IBKbezrmVBcIerNYn0yf+1T+r1E2zh7ie2nog9CBY2gYMpPKm7W3yp5aI4/3k
	LjoH40U4xAxCvX0BOGfFk5dnLDpWSNU89/SUymn7gtlb3lsm+Mpn3mzaKx5VEUCDgdZG/L6+k+V
	M9P4Swp17Ez6zDymRmMLlCiLd2NAt+gljLcGcg7LTNojMgzpW6GHfcQeIzBA0fy11H0MIxYhwTL
	CXJ5FBh5ZfSqYcLbP7QVCDs36NygddRBTuJAltNgu1USZs2AuG4eN02H7vvUQ2NhDg7PR9TTpw=
	=
X-Google-Smtp-Source: AGHT+IEprOBQSn3Ytg4X7qFQ2WbvhHazV+Lw3tNlJvmsytmgmsjBdXJWK9TXucgmcuhpw5lyap3g8A==
X-Received: by 2002:a05:620a:2b4a:b0:7c0:ae2e:62ff with SMTP id af79cd13be357-7c0ae2e6516mr464537585a.22.1739901893011;
        Tue, 18 Feb 2025 10:04:53 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0a852b95fsm162892085a.116.2025.02.18.10.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 10:04:52 -0800 (PST)
Date: Tue, 18 Feb 2025 13:04:50 -0500
From: Gregory Price <gourry@gourry.net>
To: Yang Shi <shy828301@gmail.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CXL Boot to Bash - Section 3: Memory (block) Hotplug
Message-ID: <Z7TLwtQY3vGUw2bO@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z7OWmDXEYhT0BB0X@gourry-fedora-PF4VCD3F>
 <CAHbLzkq6Me6nRaL6b09YxJ_nFkxb+n+M3-q_aJwOs2ZO4q8VCg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHbLzkq6Me6nRaL6b09YxJ_nFkxb+n+M3-q_aJwOs2ZO4q8VCg@mail.gmail.com>

On Tue, Feb 18, 2025 at 09:49:28AM -0800, Yang Shi wrote:
> On Mon, Feb 17, 2025 at 12:05 PM Gregory Price <gourry@gourry.net> wrote:
> > The node ID passed in as an argument is a "preferred node", which means
> > is insufficient space on that node exists to service the GFP_KERNEL
> > allocation, it will fall back to another node.
> >
> > If all hot-plugged memory is added to ZONE_MOVABLE, two things occur:
> >
> >   1) A portion of the memory block is carved out for to allocate memmap
> >      data (reducing usable size by 64b*nr_pages)
> >
> >   2) The memory is allocated on ZONE_NORMAL on another node..
> 
> Nice write-up, thanks for putting everything together. A follow up
> question on this. Do you mean the memmap memory will show up as a new
> node with ZONE_NORMAL only besides other hot-plugged memory blocks? So
> we will actually see two nodes are hot-plugged?
> 

No, it creates 1 ZONE_MOVABLE memory block of size

                   (BLOCK_SIZE - memmap_size)

and as far as i can tell the actual memory map allocations still
occur on ZONE_NORMAL (i.e. not CXL).

So you just lose the capacity, it's just stranded and unused.

> Thanks,
> Yang
> 

