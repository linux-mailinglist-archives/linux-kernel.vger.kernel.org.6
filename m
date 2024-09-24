Return-Path: <linux-kernel+bounces-336644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F253D983D6E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4BB8281858
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 06:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C307E824A0;
	Tue, 24 Sep 2024 06:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K1SVnSB5"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A50481B3
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 06:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727161020; cv=none; b=SZAJB4GkXlZGkK1bYmpQBMWOdcdV6Fank8j/+uPLtZuF/N94D9Vc6vEg7WjhSOQI2Nwo7kyTJ9U4udRxSNK5cvZDLEVL+Nr8Qg0lCg3HNwlDSddnk9UJAMJ7ReCKxIpCx2ucKy8qZn7sdadqUaSIQIEczCDjJ/2LEDU2bGvvZQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727161020; c=relaxed/simple;
	bh=rZCmcKHKcYg+MlUJLS8/2Z+mZZnt6STAuG+4AaRUi+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xn6xERPGtCY6iE097ZU28nEL6N0m0T+euUf3lfOGlDEOKZdkWhqd6w9Jl6Hw2gsPv3fZOYZ0UpFy5qaJByVQzdihHzjPFHgw3/iQbMo1/2d+p9+WWwZJduYtXCRrP5lA846LW4k4hha2QLfin+cC67jx3ZRH8ZunJJCyiy6V5QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=K1SVnSB5; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3e033e66a31so3209237b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 23:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727161018; x=1727765818; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jmU1v9KX4n6GLJqBkkbAiLzfM4YZaK2LngCXnM7X3Yc=;
        b=K1SVnSB5JFEHbZD4lu82TjIaYJYEUeKm2bjgAsIv1vK3wDgm0gwaYf2k03V8DREeLt
         HZrcH94cOc+8OQVbyU04kQz3Rbj48OyD2l0kNdTT0zE+lFjlAAVerZPhBcranMKWm0fH
         rOFdv0qSSmTBmVkUW7dtWOsHF6QxPgTR2ZDQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727161018; x=1727765818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmU1v9KX4n6GLJqBkkbAiLzfM4YZaK2LngCXnM7X3Yc=;
        b=TDDL/esMSgxJQuUUR/NnY02QeI7xE9IT2P+tO5owRqdNlbDyiDfN4/0CbYl9q06eT3
         76+sNPtu4iFGYdxxAgY3iiDOAZCZ2dpOM+7oRFJVHL6S8zarPTGopAu+yGrqlGgf7fRT
         5Bx+gVuo95pJmh/4/4ilufDbKDGWASn3Sj1jYbjBn+I4yVkRx/xBmyBJ+PJSgT/3aaTE
         SFLTgi5EA2RQfck7AWCG8+KO6PRl9k21XrrLZfJoo6GuytJJQeARcfzeSmSWGi6LEjav
         zoqjKeAwYFHNGUvVHTZaebRnM57GKt7WvbRK+IYdc5PzNj4AtIPkYK+KAuLDxiTrxdzp
         rt3g==
X-Forwarded-Encrypted: i=1; AJvYcCWo53Jdcy5sfxPE1rkaLQpiea1MrMxaTIgmZxeoDESi3FnOSmzmuUkRSiA5gpzFq4zTLE0YNIHbOA+2FDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIFJ8s7iBQPnPS708o1ZOqxEgBX4WjDZtdchOp5z5nLl2g+Cqj
	1Oyo5qgOPkxU6ZbYOO1GAXLj2spbbtVFIX62pqaGZSAL8iQF3z/NhoEV/7qRGA==
X-Google-Smtp-Source: AGHT+IG7hYRPMTRkHU1EalQzBqR1bwxDO/fhEf0IjTgWkuptwoVgLofvxpc27W/PHGhYwCMTqFpxOQ==
X-Received: by 2002:a05:6808:1401:b0:3e0:4dbc:34f7 with SMTP id 5614622812f47-3e2729334b1mr8520782b6e.21.1727161017759;
        Mon, 23 Sep 2024 23:56:57 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:93d1:1107:fd24:adf0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6b7c4f04esm566711a12.44.2024.09.23.23.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 23:56:57 -0700 (PDT)
Date: Tue, 24 Sep 2024 15:56:53 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Andrey Skvortsov <andrej.skvortzov@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] mm: do not export const kfree and kstrdup variants
Message-ID: <20240924065653.GQ38742@google.com>
References: <20240924050937.697118-1-senozhatsky@chromium.org>
 <ZvJfhDrv-eArtU8Y@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvJfhDrv-eArtU8Y@infradead.org>

On (24/09/23 23:43), Christoph Hellwig wrote:
> On Tue, Sep 24, 2024 at 02:08:37PM +0900, Sergey Senozhatsky wrote:
> > Both kfree_const() and kstrdup_const() use __start_rodata
> > and __end_rodata, which do not work for modules.  This is
> > especially important for kfree_const().  Stop exporting
> > these functions, as they cannot be used in the modules.
> 
> Well, they do work when called from modules, they just don't work
> on constant data that is in modules.   There's also plenty of
> existing callers in modules.
> 
> So just unexporting them is going to break.   The API is kinda
> horrible, but an implementation to check for constants in modules
> would also be quite horrible.  So I don't have a good answer here,
> but simply unexporting them is not going to cut it.

Totally agree with all the points, I haven't looked at how
popular that API was before sending out the patch.  Is there
some sort of "built time const" but for strings that we, perhaps,
can add to kfree_const() (and make kfree_const() always inline)?
So that we can turn this

	str = "boom";
	...
	kfree_const(str);

into a safe scenario for modules.

