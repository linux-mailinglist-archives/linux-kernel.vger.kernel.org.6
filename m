Return-Path: <linux-kernel+bounces-179276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F1D8C5E4A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 02:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D36B8282824
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 00:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EEF64B;
	Wed, 15 May 2024 00:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bEt5aAYF"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95CC370
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 00:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715732073; cv=none; b=Dh7MMIm4+GxPBXiX/UemaLKZ8auAh7/oo+1N1RyAhBBqjRKX5lOzd40YDrkYN0TMswGMSR/t3p2VHo0QUMiaJbI+qJH+ay6n5ru5xJd4fzl7Hlk3nHfMc1hBz2A6d4qTU6DS1x93t2fT4aDOTCBqvIN3OcLf5Pfasv15fLiDro8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715732073; c=relaxed/simple;
	bh=j2ftCty9dq7CpmwKrZ0mgXy5J5YjgnGh+o1tmDbpfbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jcHVrPkvg1OmyPgiOMwWRfsPdECllChzMojA5dFeccSt/lKJISVwQhSYXjrj2jzIXHS86K6avJWHt1kVj/fMoRZIfz0KXX8Jn6CayoKnIPUrIPssHrWPZAQN5hgiMt/ZC1PyBj3UuDri1tERdEB0nBbpGYSH5fUp9pgrrLQPc1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bEt5aAYF; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5d42e7ab8a9so3561338a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 17:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715732070; x=1716336870; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PR13R7wA8xvagj4MkK2uLoNpb1rYfhn9QSsexVqusxI=;
        b=bEt5aAYFLY8H7QgN4XJ92X2bXk10qtNMdgqskSRQJoDzDb1PseFehSgnARdWMQijL5
         /dEJ0vQeqp8jt7GsDqE7oscxz9YCkM7o873ENpafyaCsi8epozUAucrMKddyBtFILCKB
         2mJ4z+RcKdbQ9D4HHrZzSGQn8l8jJHVDQ/1w0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715732070; x=1716336870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PR13R7wA8xvagj4MkK2uLoNpb1rYfhn9QSsexVqusxI=;
        b=LCe6wvHO9630X2nIOBvmnABlpw2iK7K0JUusn7YCC9bZooQGwDvLl87NHvn4A/ArRK
         g7pH53hPssHHVCVhnttWBB5CAiBfqCO0FCR5hVFzizL9p/S6pinLmy7Q/huZj11WzS2a
         WDb/ciqDybnLGlT8OLFivkTFFkCRYnvGDPH8mn9Y2R2tqPcEnymqZoxDg0+d4EJrkBAw
         VEfOuGoKqvC074IhxEUObhaNVRIkFmCWT8m0IRKAyENT6jm/AN0bMgt1ZH68hhjpOpKE
         lSW4yfEk4uEdn7DRfQKX4WVnx1i2RN/VAGb4x/CFfgSlI8ajD/Ci757R37hhss5AU1O6
         eqsw==
X-Gm-Message-State: AOJu0YxADzOW8z+Cj82VpP7XuwHq7IpYq73n2QPtT9cMRxaHPIG12/dx
	Q06gYYNlgfLeGiRWfYq8GnqrQwECLKWs2aWY2mvKAvmKpB+3/8lhymbWi0gVsg==
X-Google-Smtp-Source: AGHT+IHI84aVWv6OYG1lmk1S9IWpcul3GSEd/hZbL/Gpm7Vrk41WzON/cfdyzWWClcORYetfDzuT2g==
X-Received: by 2002:a05:6a20:5504:b0:1af:a35b:a34f with SMTP id adf61e73a8af0-1afde0d5401mr12216988637.25.1715732070290;
        Tue, 14 May 2024 17:14:30 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b671782d89sm10298457a91.55.2024.05.14.17.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 17:14:28 -0700 (PDT)
Date: Tue, 14 May 2024 17:14:27 -0700
From: Kees Cook <keescook@chromium.org>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: linux-kernel@vger.kernel.org, nathan@kernel.org,
	luc.vanoostenryck@gmail.com
Subject: Re: thoughts wanted on dead code hunting?
Message-ID: <202405141706.1D5D26C@keescook>
References: <Zjy82Ja6G2iIHl75@gallifrey>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zjy82Ja6G2iIHl75@gallifrey>

On Thu, May 09, 2024 at 12:08:56PM +0000, Dr. David Alan Gilbert wrote:
>   That's found me ~200 candidates; where I guess 150ish are probably
> real; but my hacky script is, well trivial and hacky, so they each
> need eyeballing, then a git lookup to see why they're unused, and a
> compile just to make there's not some subtle macro somewhere.

Nice finds! People are usually big fans of code removal patches. :)

>  ** Questions:
>   a) Can anyone think of a better tool than my script (see bottom)?
>    The simplicity is a blessing & a curse - it doesn't know about
>    #ifdef's so I don't need to try lots of configs, but at the same
>    time, it can't tell if the struct actually gets used in a macro
>    and I have to eyeball for a struct which is assigned to as
>    a variable at declaration time.

I'm not sure I've seen anything better.

I tend to use stuff like Coccinelle (spatch) for finding specific struct
usage, but it can sometimes be slow when trying to process headers
recursively. e.g.:

// Options: --recursive-includes
@find@
struct to_be_removed INSTANCE;
struct to_be_removed *POINTER;

(
*       INSTANCE
|
*       POINTER
)


(I bet this could be improved, but it should be a usable example.)

So this might very a given struct isn't used.

>   b) The dead structs are all over; so they've mostly been individual
>   patches rather than a big patch series - how do people feel about
>   another 150ish similar patches ?

Generally the smaller patches are preferred. For this kind of thing,
though, I'd probably collect them by individual header files, rather
than one-patch-per-struct.

If you have one giant patch, this tool can help break it up into
per-subsystem patches (it isn't perfect, but does its best):
https://github.com/kees/kernel-tools/blob/trunk/split-on-maintainer

>   * There's a few cases where people have added 'static' to a variable
>    to cleanup compiler warnings, but actually they just needed to
>    delete the variable.

Hah. Yeah, these are nice to find and remove.

>   * A harder problem is unused structure members; some I've spotted
>    by accident, some follow from what else I delete; e.g. if you
>    delete a LIST_HEAD, there's a good chance there's a struct somewhere
>    with the list entry in it that's no longer used.

This is especially tricky because a giant amount of structs in the
kernel actually describe over-the-wire or on-hardware structures that
maybe the kernel doesn't care about all the members, but they're still
needed to keep the layout correct.

-Kees

-- 
Kees Cook

