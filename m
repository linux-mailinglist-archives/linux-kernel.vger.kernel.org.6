Return-Path: <linux-kernel+bounces-440762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 399099EC3D0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 05:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68D0218866FD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 03:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EAD21126D;
	Wed, 11 Dec 2024 03:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BEq/uW2a"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B4F2451CC
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 03:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733889592; cv=none; b=HwCaOE8wJsnTy8XD0nZpBT+dHNtGjlFhk7lFhC0viu2haSy9X5ci+XSYYAfzG9RM8DRInYhGZxiroUqssVAoIE3Gjs1COa3Exh/v4fNcG6xP3Mg1bTXm+RQjBNcGMSl86f2be3LDMFCGh0ORHyvbAOjlYlVEreomSIJQiGKSuD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733889592; c=relaxed/simple;
	bh=k7JfgaVtbVYd0hE/6l1UQtJXQyDVOK8jnBgJXzXf7t0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JDb3pCN4k/x43Xzb/cZqzsDxZ5FXqbqm/Bn0dqNrj/WWLPBfEhuoCpVhDca4/sboAfHnsVJ8/Tun2PgQrJehjwFZqr3VSKAszLCJhVVtM6pZ3z+loxu6rzUmuBXr05CS/1dBW3bDnVnJ7I5QsxRon7ZZfHYcT5+xi7iruvJCWAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BEq/uW2a; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ee76929a98so218217a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 19:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733889590; x=1734494390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=njf8OJpFVXMbVX0C+f5KNITGhFOXglE4gSoAtOgVehA=;
        b=BEq/uW2a+xpcMkXV99TlD9zs8ENoSEUibW/Z2Z2gfW8tFbsYFzvxlApnHh9MJ+rjx3
         Msna4/7jFLN6AGsBzOBRp27BByHfLOSIRWaAz1J5DhHq8JNNK2yTzzr8/AsXVbpnO8YL
         4mPAKB1LD8Q4IrMC7h7laF1xxOdklRNKwDnHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733889590; x=1734494390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=njf8OJpFVXMbVX0C+f5KNITGhFOXglE4gSoAtOgVehA=;
        b=X21zWlM1u6X+VrXw6FcMTEtTp9eTheKBqNQpgi+KNeqMccZmbu8X82id2OSAHSFc+E
         wbbfKFll1bKM599exH2GtioUuDMarH5p9jU1Fh7Cv2RRBdOHqeS5dqdM+w3Y0yIPSocn
         /I6NrHZcySk8OFqj+UcYiTd+PTjbTWKxWTysvITGCgaB0dkUGZ3+ORqyBXh6v0HTk0Ge
         HAcTJv2q6RujzQTVFsm7YMk0FFPunSduQtKZzY5OyWQa7xXB6qZ3STKbFbTv76ZrgJio
         GknmYyW9AgSQvShmvpaG8EMQbwBaPod7poLKzNmmsg25WvaCptB+m6dP/x5ehcRPLjdK
         kcDg==
X-Forwarded-Encrypted: i=1; AJvYcCUDgxZAW9b+y0Fv8Cq5HoEkCRDjuWXcbSVrLR3aUaYni7v2oAFI8NQI6Luui7y7Q5yUPnoE/iKpfCTldKI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2zSP3IyykuwMciUB1XWWZItExpWJ93HDbQZ9izw1P9vG05FMD
	CRSTwAbPrjBKqWrLfZxw3wWP5z6m8Mo4/mVZFc/GBk2EgcYGtFV0YOGsu7ilROjQFAq2nC3iKXE
	=
X-Gm-Gg: ASbGncvXB3+kJU+cUyFyCATy8QnAc1YzI5zgzffeyaPiZnPmdlo+kGVePT4HaEk1CGF
	w6hHnvJOzGxdycEpOuxbN7JEdfX7wA71eKhGgBAAFPvwhIEJd2vdFfIqFQnyN6Jcgbus6K/8yE/
	wxjrmHzP8VvxST52GBym3TnDy4KM9T109iHqlmnykmF7M7GlrlJu0+navA+xfWKM2I/9xKpCMZj
	pDTUyPLVoHwjRESJddikweoCvphXZZotZetRUW/fOHyoeejQKapsyLdKFfN
X-Google-Smtp-Source: AGHT+IGJegBOEWdVhM0WVW1wdzc4yOR1xbAozGfFLqn/RyvXEdXJNWJXGFUF9MsGNB0fyG8QhoQunw==
X-Received: by 2002:a17:90b:4a05:b0:2ea:4c4d:95a1 with SMTP id 98e67ed59e1d1-2f12881ab96mr1898707a91.17.1733889590161;
        Tue, 10 Dec 2024 19:59:50 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:4d97:9dbf:1a3d:bc59])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef45f7eae2sm10659507a91.7.2024.12.10.19.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 19:59:49 -0800 (PST)
Date: Wed, 11 Dec 2024 12:59:45 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] zram: cond_resched() in writeback loop
Message-ID: <20241211035945.GB2091455@google.com>
References: <20241210105420.1888790-1-senozhatsky@chromium.org>
 <20241210105420.1888790-2-senozhatsky@chromium.org>
 <20241210165456.288ed82b8a66a08ac36a4d15@linux-foundation.org>
 <20241211034348.GA2091455@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211034348.GA2091455@google.com>

On (24/12/11 12:43), Sergey Senozhatsky wrote:
> > Should this be treated as a hotfix?  With a -stable backport?
> > 
> > If so, we'd need to explain our reasoning in the changelog.  "Fixes a
> > watchdog lockup splat when running <workload>".  And a Fixes: would be
> > nice if appropriate.
> 
> Good point.  This fixes commit from 2018, I guess no one runs writebacks
> on preempt-none systems, but I don't see why this should be in -stable.
                                                 ^^ should not be in -stable

> I'll send updated patch in a bit.

