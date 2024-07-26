Return-Path: <linux-kernel+bounces-262752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8222693CC36
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 03:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E22DE282C52
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 01:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8609D1860;
	Fri, 26 Jul 2024 01:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="psekbiTT"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754EAA34
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 01:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721955944; cv=none; b=ttjflU09ZKipkqn9BqdUWbLmpxslkgJFeLwrt4jteZbXpsZ9ka9uICdIkB/nYv7PHrNWxG5m95au1M+U3caRU1t1T11vqreDtkZiQTCGS0lzETt8tBcYcAhHPpri2cSVf6duyXmep0UexnCtbklQeDNcEBXe2WHuGTtAsHBdhfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721955944; c=relaxed/simple;
	bh=SYiXtPtA7u1goqwd0iJdJa6uUwj2jarWAZpR6Ns6Dk4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=G6cdoTafx98OCIJfpRd3yR6gZZ/XuvudhlqAfFuupRcIncdxrGa3BZctIkpY26SCrWcq/ZttMuf0lANrVBifikv1c1FJPw7a++nmRM5ZMHB6kO8hs6k4sos4dyG+8j+juGwp79eLNX9uDgXWEECDLGSKfeV3fqLPyhTJY/ILORs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=psekbiTT; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5d5c7f24372so21807eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 18:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721955942; x=1722560742; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wplub1KYBY00My21K+3e0Cz2sX6Rz/xbxhkg+HgxJvY=;
        b=psekbiTTFHay9shkJxoheIO3/dWGTsEXJXiUFlvGUtU8OsSz4r6sPIx80hg/NUxHOQ
         2GAAAcccdlqr4TTvILzxp7y20CWCcxDOfYCx1qXV7qNjMm9Z3kjuNMVjQW9+c0s2vjmL
         Rc4VQgqvHfbTJuDzviTkPZckquo2DiaLW2O9Fa0oXWXWmZsqK+PiC8YNaGdVtHrtNPwT
         mMsYQ8V5kaRVF4ltroYGArWMfGndTvHol+sdjNOKahjuC75wfsHwJqCxyOMfkgHC3zl/
         n5UKCS2jgoPkydBYyFSb9uKis+F8C1LTenl0DnAG5zjUEcshtZwfx+WrNLx/7Ei4FoXy
         hCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721955942; x=1722560742;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wplub1KYBY00My21K+3e0Cz2sX6Rz/xbxhkg+HgxJvY=;
        b=gbATQrwAvTpatiRV4EwvBCwBfSMkDmC5sk/Wmwd1RbVWytSN1Y5Mc2bLCgSNDS37zp
         2BVYLB5wTzCr1UZAXa6IZTTb7aabPlfMQIiv4nIPsPI+GeKnWX5aj3R+/rtin3Wb1ZLI
         5UBuF0fBlgS9ynLeIA7B9r/Nao8UR0NP0/IkGhJouKPVDZKSqzjOiOIPBoLKBIJSPRxz
         4Us9KY1gK7OmZKSwByiFcFi+KUWmqMnajj2cc4aw9404M6YhWBJ3q6JSlgKGHG2BHpDW
         VJQCsi4ajxLIoeh+9Os3a1D6l7CV2v8tzRi7zI/jNhCKUmlkUIrtjB629oEoCz4iceGF
         9MqA==
X-Forwarded-Encrypted: i=1; AJvYcCVn2ToQTp3FzSrZEsfY8O4+WUnhO8eo9soHLmDDid/mwXxlM0REiEXLAws1o5GQuke4rMzPKPDUJbFzOn5+Lgx0uIQKzD+JVYBbN0pT
X-Gm-Message-State: AOJu0YxNf16lXJeNbfJ8oB1ACgH1ZOwYZmSQTpWvTvIwzzHxs1L/5Q/c
	R3KORcNhXyIetq40fhgJsgRqou87DnHrM/gC1XhJ05gt0l4nq7AMVgl+eqImsQ==
X-Google-Smtp-Source: AGHT+IGnXV3TJ01uIVgCnW2YbhkwhU19alV6F/dmPEewcN1biNfibE6YR5zlLHgLvW0JKfRTuG4OLw==
X-Received: by 2002:a05:6820:270b:b0:5b9:e7db:1cf8 with SMTP id 006d021491bc7-5d5b429a512mr4384785eaf.4.1721955942191;
        Thu, 25 Jul 2024 18:05:42 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-709307923acsm552014a34.76.2024.07.25.18.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 18:05:39 -0700 (PDT)
Date: Thu, 25 Jul 2024 18:05:27 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Chuck Lever <chuck.lever@oracle.com>
cc: Hugh Dickins <hughd@google.com>, "Hong, Yifan" <jacky8hyf@gmail.com>, 
    Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org, 
    linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
    bugzilla-daemon@kernel.org
Subject: Re: [Bug 219094] gen_kheaders.sh gets stuck in an infinite loop (on
 tmpfs)
In-Reply-To: <bug-219094-5568-fyOeXKhNmt@https.bugzilla.kernel.org/>
Message-ID: <a2808893-d257-e6b3-e168-0478d7255621@google.com>
References: <bug-219094-5568@https.bugzilla.kernel.org/> <bug-219094-5568-fyOeXKhNmt@https.bugzilla.kernel.org/>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Please send responses by email reply-to-all rather than through bugzilla.

On Thu, 25 Jul 2024, bugzilla-daemon@kernel.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=219094
> 
> Hong, Yifan (jacky8hyf@gmail.com) reports:
> 
> I have hit a similar bug to https://bugzilla.kernel.org/show_bug.cgi?id=217681, but on tmpfs. 
> 
> Here's a small reproducer for the bug, from https://bugzilla.kernel.org/show_bug.cgi?id=217681#c1:
> 
> ```
> #include <sys/types.h>
> #include <dirent.h>
> #include <stdio.h>
> 
> int main(int argc, char *argv[])
> {
>   DIR *dir = opendir(".");
>   struct dirent *dd;
> 
>   while ((dd = readdir(dir))) {
>     printf("%s\n", dd->d_name);
>     rename(dd->d_name, "TEMPFILE");
>     rename("TEMPFILE", dd->d_name);
>   }
>   closedir(dir);
> }
> ```
> 
> Run in a directory with multiple (2000) files, it does not complete on tmpfs. I created a tmpfs mount point via
> 
> ```
> mount -o size=1G -t tmpfs none ~/tmpfs/mount/
> ```
> 
> The other bug was fixed on btrfs via https://lore.kernel.org/linux-btrfs/c9ceb0e15d92d0634600603b38965d9b6d986b6d.1691923900.git.fdmanana@suse.com/. Could anyone please see if the issue can be ported to tmpfs as well? Thanks in advance!
> 
> I am using a `Linux version 6.6.15` kernel, if that's useful to anyone.

Thank you for reporting, Yifan; and thank you for the easy reproducer, Rob.

Yes, it appears that tmpfs was okay for this up to v6.5, but cannot cope
from v6.6 onwards - a likely-sounding fix went into v6.10, but that must
have been for something different, v6.10 still failing on this repro.

Chuck, I'm hoping that you will have time to spare to solve this in latest;
and then we shall want a backport (of only this fix, or more?) for v6.6 LTS.

Thanks!
Hugh

