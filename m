Return-Path: <linux-kernel+bounces-205239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FCF8FF9DE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15F0DB21BA4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 02:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F27F12B77;
	Fri,  7 Jun 2024 02:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="robFGF0U"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2DFB64E
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 02:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717725904; cv=none; b=B0azSX17KrYZ6IKOis8jiWLP+EQDr+ABmovhe6+VTIHD5ZsexQJG/m9LdJ+ZHyV4Bf9P/Vkqm07MU+LhSTD+qbg/DsfTJtQ+O3gV61LF6bX+GWdNnle2oGqbqvkyubAcUPagiwsYFpG1qqApgLTxJ8yRvEgzNvtlHlvIcaoOEmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717725904; c=relaxed/simple;
	bh=zWikLDUbPHzpkyuMa9SvJfhr99C0pRruMAI38ekM2cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQU8kPz70koOgjq2m73UcmyESdzCnoPs/GV/QI+Dy6NT1+93hkcsypGurXSYRHv2Y1kHLJk1+FCVIaTAfoej0sq6ktNzGk8txDu2IoMsg9RX14CxkTayOzlSC6/Evd9ElCoO/Mcl2vGpNjvtjpK43MpUhCeYjCoKk7WZSXmwcEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=robFGF0U; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2508320e62dso811928fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 19:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1717725902; x=1718330702; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HKuuaXk4YNdRbMNXNWT/TcuUhZ1SuAkFriq95pCZdUs=;
        b=robFGF0UW7hpXvpys9yc0fpSd1xUkDYMAWmRxVUvpe8dKxtOzxflIC9sxnD3fUKQbt
         QdraQkBgdwY5NQqtm4TW+vXv26p+JFU/s+0YqtqKGbPMC54ggKEUdCquIZRcKkNL75q6
         iG8P8I4tNToh/GKO86BPnodiQTZ86b6OoNMFg1Z4/bkEBzLiHRtLCvdFr9CH4rX3NM4O
         xU0Kldy2k3K/EqRc+ML9BtbH6nn6rrcZloW91Gi8KzJ1ZAeMnr6z3MnmBMsK8/2TEbUA
         9AbygJfucBr7El+fkzvw1P/RXlLG4teq/AYyiNEvR04UoRnB4cEyG0qWBnff8S21mopR
         VEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717725902; x=1718330702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HKuuaXk4YNdRbMNXNWT/TcuUhZ1SuAkFriq95pCZdUs=;
        b=jRQpSHuSP3I5gxGsEuJi1BuFNzdttD9QtUaGSiscyOvJARG3H+rV0nGS7eNnmqbHwR
         T1uBxLaR6YDe0+co7502PlW4n+7buDY91KH/q5P/6bTVoIGCDJf2rtyEKLEGAG1+NEl2
         sil6sZml4eLJn0rX7b9hCieVo4xPFaHGZGL1qM0eQe71KtIpE2IazRERd3cSd9nsWIrq
         PxvctUubVC+j8auWB2H9XZX/jExq/JodxyJzXtYm+3E1i7gTyFiFh68sFXKoIE/ernt/
         gS2UIdbTM5BLFcAISUePxDmtrhAbzUXVK+30nWXn/Lflnca9AZLae4LUMLntYBmAL2IQ
         CgUw==
X-Forwarded-Encrypted: i=1; AJvYcCWEX0ULUX18W3iYpMadbtQrtt08KIkocL7TYrLR88WYa9cjo6TREJtyJX9WaOHV4I1gq3JcdhOvXC1DhN4SarBn3vzNKk/V1n6EQfHQ
X-Gm-Message-State: AOJu0YxNTBFo/IzajS1YYo35SBhfkWI+raHstk4ZUVFeeOt72CVZ3CWb
	zWY4CVHlN2wL0zJ1RJ15naPrgTXYK+LuI05Zzw2ERkuFxXktmeEeimAsqcXath4=
X-Google-Smtp-Source: AGHT+IG0TPOxnGysWka2PW7vDNgAiA6BVNC6fKtQ+0c898BXoBu9nsrqdblxPQrgncIqEfCUsLuOCQ==
X-Received: by 2002:a05:6870:548c:b0:24f:ebcd:6aa9 with SMTP id 586e51a60fabf-25464384754mr1399622fac.1.1717725901930;
        Thu, 06 Jun 2024 19:05:01 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd495083sm1682576b3a.136.2024.06.06.19.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 19:05:01 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sFOyQ-0070gF-0J;
	Fri, 07 Jun 2024 12:04:58 +1000
Date: Fri, 7 Jun 2024 12:04:58 +1000
From: Dave Chinner <david@fromorbit.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] vfs: add rcu-based find_inode variants for iget ops
Message-ID: <ZmJqyrgPXXjY2Iem@dread.disaster.area>
References: <20240606140515.216424-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606140515.216424-1-mjguzik@gmail.com>

On Thu, Jun 06, 2024 at 04:05:15PM +0200, Mateusz Guzik wrote:
> Instantiating a new inode normally takes the global inode hash lock
> twice:
> 1. once to check if it happens to already be present
> 2. once to add it to the hash
> 
> The back-to-back lock/unlock pattern is known to degrade performance
> significantly, which is further exacerbated if the hash is heavily
> populated (long chains to walk, extending hold time). Arguably hash
> sizing and hashing algo need to be revisited, but that's beyond the
> scope of this patch.
> 
> A long term fix would introduce fine-grained locking, this was attempted
> in [1], but that patchset was already posted several times and appears
> stalled.

Why not just pick up those patches and drive them to completion?

I have no issues with somebody else doing the finishing work for
that code; several of the patches in that series were originally
written by other people in the first place...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

