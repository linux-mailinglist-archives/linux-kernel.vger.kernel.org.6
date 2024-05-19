Return-Path: <linux-kernel+bounces-183083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D7F8C9446
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 12:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65CA01C20B4F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 10:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A127C2BAFC;
	Sun, 19 May 2024 10:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dt+IJdVy"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FD91E534
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 10:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716113244; cv=none; b=kv/qRICO89mhWa5A/gVcdz7NNuM+5g2OfYpeT/I1u7MvHaJ6u8oTpbCTKQTIpMhU59uVhCQuVUpaqai6WZ1fdaUzpzsoFzaRSkCHafvcW9EOwYkskWLjJL6XWxR0ixH1UR9U9kRxIzF3821JGh+sJE/pARyZl1V4jYZec1dqHJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716113244; c=relaxed/simple;
	bh=etQGD/Sc3GMgATEbVZpoDBSCvoQuUlRHiYOy0ekge0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ofhRNFGxP/VY6FYnz4vX/0Q5vf5Z3PwKbJRuBQ/bCnsABRMr9r8gWVWt/UNcA208oKkkL0YrGOZGnGnPmB+kkrG07CYBSA0juGhIiDZFF8MHE43FDTaOqc6/pLt2QmMbP4dQsg86QfzhRAITDXNHHy5ZKAJmlv1ZivltKcHIUVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dt+IJdVy; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-34db6a29998so1434103f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 03:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716113241; x=1716718041; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=320z9E/86yc2wudgNLgLL8g4U1YGIAZ7tfBbM4eHHIY=;
        b=Dt+IJdVy86jpIhRaY/yCHj0qSl17DRnFnq4DB56mPH/5/Ww9/YEtJyVul2zqDg4FzR
         Bd7+9hbB/eudYbLVP+K/upwz7x4qCxZvNVFmpzUJnBjKNiGjOFsOyOXCJsqVJwF+Yjhh
         r2NMVDa63ne2JIpaFHcZRgQXyDwZdVFqUL7ei76mlDdCmMwTHK5quUI95R2k8KnHuP7z
         9VZzOYDa1U+CShxvLiAXQ8OyowiZQeHh3paxc6GwbojSQcQvM/iiuAP4M8guFDV4lUEK
         kbwk5eeC9a74ad63RfJr/gquYOfeHe53MohFTRLprsOMBD7g4EF2QEg2C594/OpDOCAG
         KRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716113241; x=1716718041;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=320z9E/86yc2wudgNLgLL8g4U1YGIAZ7tfBbM4eHHIY=;
        b=ev7rR5ecyJlon1G9umat0AVQdNCN2INXtDFAHwTxHALTagkdRbJo3H5r3glqSYjJpf
         cvSoIXhkSKI0Gf4ezRvgWfQZkPr6L5I5z4Ul6SAbLtzqNy5ItE8msezBKnRBXy35/150
         +PgDLCCtLtDFPV3uOw5LppNkimhyr6TBLORV+Ir1f8Cuk3AAbIcxuwi+fM5hwQL3m2+W
         v1/JV14CHXgUQ+V6SEgh/VGVfPMSIBJqCZl0bCyMYTL+w5XFSW8KKfneDYxJMDxU5N9L
         pxYBuRnULTfRUrMQMUBiLU+2cU7xsaGvjlNKTXsd3LCBiuivijD3LVFQl2CLefdizq0m
         n1lA==
X-Forwarded-Encrypted: i=1; AJvYcCUutm/Z5NitupGSPkeySPCQZEvYP8cJ9hZzRt0LOHoDrsR2+EOs9fxzNEOD3U/E7HVxlnmk+MKAi8WSAMSDo4h4yvuyvaBSxlSzdTX8
X-Gm-Message-State: AOJu0YwD3LEkyuPtgGPZLh873vK5ZDj6cRwCazc4OMgw8DTyClZ17Ael
	jsPYl22lS0hXFx2ltT9scjM+KC7c3e/KrH00+uH+M3sOySkSz9Gl
X-Google-Smtp-Source: AGHT+IErv8QLrHO4ewcOMEXQoUPuwcgDRLStIisOq5DrjhknuIwGVYk6eO38TVuLwkJFG9FcCwb51w==
X-Received: by 2002:adf:ec4d:0:b0:343:7b6b:dcc6 with SMTP id ffacd0b85a97d-3504a73bc6amr18580623f8f.30.1716113241336;
        Sun, 19 May 2024 03:07:21 -0700 (PDT)
Received: from f (cst-prg-73-12.cust.vodafone.cz. [46.135.73.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502bbbbedbsm26261151f8f.92.2024.05.19.03.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 03:07:20 -0700 (PDT)
Date: Sun, 19 May 2024 12:07:07 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	lstoakes@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: batch unlink_file_vma calls in free_pgd_range
Message-ID: <wcc2azm3iy7yhhl4c7ge22a7jpsekxl6vhl4aftusej7btzbrg@jlgir5kaobuk>
References: <20240518062005.76129-1-mjguzik@gmail.com>
 <Zkk6SCZl70o3WXpW@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zkk6SCZl70o3WXpW@casper.infradead.org>

On Sun, May 19, 2024 at 12:31:20AM +0100, Matthew Wilcox wrote:
> On Sat, May 18, 2024 at 08:20:05AM +0200, Mateusz Guzik wrote:
> > Execs of dynamically linked binaries at 20-ish cores are bottlenecked on
> > the i_mmap_rwsem semaphore, while the biggest singular contributor is
> > free_pgd_range inducing the lock acquire back-to-back for all
> > consecutive mappings of a given file.
> > 
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index b6bdaa18b9e9..443d0c55df80 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> 
> I do object to this going into mm.h.  mm/internal.h would be better.
> 

Noted.

> I haven't reviewed the patch in depth, but I don't have a problem with
> the idea.  I think it's only a stopgap and we really do need a better
> data structure than this.
> 

I'll send a v2 after some more reviews pour in.

The above indeed is just a low hanging fruit fixup in an unpleasant
situation.

I think the real fix in the long run would provide the loader with means
to be more efficient about it.

strace /bin/echo shows:
[snip]
openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\220\243\2\0\0\0\0\0"..., 832) = 832
pread64(3, "\6\0\0\0\4\0\0\0@\0\0\0\0\0\0\0@\0\0\0\0\0\0\0@\0\0\0\0\0\0\0"..., 784, 64) = 784
fstat(3, {st_mode=S_IFREG|0755, st_size=2125328, ...}) = 0
pread64(3, "\6\0\0\0\4\0\0\0@\0\0\0\0\0\0\0@\0\0\0\0\0\0\0@\0\0\0\0\0\0\0"..., 784, 64) = 784
mmap(NULL, 2170256, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7dbda8a00000
mmap(0x7dbda8a28000, 1605632, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x28000) = 0x7dbda8a28000
mmap(0x7dbda8bb0000, 323584, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1b0000) = 0x7dbda8bb0000
mmap(0x7dbda8bff000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1fe000) = 0x7dbda8bff000
mmap(0x7dbda8c05000, 52624, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7dbda8c05000
[/snip]

Hence the 5 mappings.

Should there be a mechanism to issue all these mmaps at the same time
there would definitely be savings in total work done, not only in terms
of one i_mmap_rwsem lock trip.

The mechanism should be versatile enough to replace other back-to-back mmap
uses. It would be great if on top of it it did not require the size
argument, instead it could return a pair address + size. Then the
typical combo of open + fstat + mmap could be shortened.

As in that was just a quick note, I have no intention of pursuing
anything of the sort. I'll probably submit some other patches to
damage-control the state without altering any design choices.

