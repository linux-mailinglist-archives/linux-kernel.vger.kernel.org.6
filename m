Return-Path: <linux-kernel+bounces-512167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D42A334FF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 02:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E7817A30C3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 01:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2AB13B284;
	Thu, 13 Feb 2025 01:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BsyCS10N"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B8E1372
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 01:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739411599; cv=none; b=smYKVM9WowEORcAvjooQUxWTl4wxP0XLY/TLKpXSr4H8msCUDaFyZub9XvcjpO4EDnDPGoy9DskPObw+SVC+W9Nn5qZJSyAFp0/Jlzt6o0JX+VQsZodrgQGBqjMjWZbO5RaP5XsykGWVhMZ3e+X5E7wd7Lm2ldEa1/Cej1ek9ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739411599; c=relaxed/simple;
	bh=Td287W9DpLSwaluBQZhR/5o8Vl6RQ9WspBwcxCKvTkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MRlTesTVMOTegqwDmq4h/7B108L+PGchI+QuegJFdrfc8HQsSBGqxZgwo8fvnRzZ7wV7qUyb1ToU3Au9fOt47HTU/+TnRbF53VNMJXK/OvmODv0NHcMEhS8UuaS5yR4ugKNt3Sx+6j/Dhl6i/6bGe/zRrdqNwlcBaU4VRWmuyXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BsyCS10N; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2fbf77b2b64so763150a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 17:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739411596; x=1740016396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mjgq8Dv9L5Zlmb2+3WRJFHG3qseBbMgQXG2FucXZtPg=;
        b=BsyCS10NHYNyEmhfCMY295ijfcHfPuwbJ0byEKFNvvm5X2vXkA3BcgLz1IQWVAONKo
         +8Uwua850pVDmxkI0zCpkYvh+rbVEWDNtmQekSi0s5NwoW1h4cmZjnXQyBXqtV1qXTqe
         4oyCY397rSRXR6Dw3QES6K6d1gZcIiJjedVsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739411596; x=1740016396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mjgq8Dv9L5Zlmb2+3WRJFHG3qseBbMgQXG2FucXZtPg=;
        b=sVg1RKdgYfLzYI2hLJYtDa3QcfUfIevdx0m/vH5S7/xBUANAcSHY6pLjvgsSvgn6eF
         LrZUbKlCr9fpKQ/p7crgPj51yNY9JfqoSxH97XcGKJXH/cPxCKbyJ+m2zoC0P8DS+Mz7
         oZK0WFxHQiFOtEgFuflWuIWEyJ3VtsHi2MUmO6VOB4cJTwbZREsq0K/rgxTzn7l35x7O
         +XgH6BnDb3wjL6H+O8LSqXgcc6otjgZXpna/d3kX8C4jzqVSt9Qp9bObAgmWST9qT+Sb
         NFV9pcITja/wsvj+SFSlelBcra4zg+mssMUz6kF02lyPyhHGm1RlyBKecFYT+5qU0B0p
         o5/A==
X-Forwarded-Encrypted: i=1; AJvYcCW0Nwy9XaWn6uq1VmKFGp2nLjQRebV0pR+57+FvUpHGLEFYc6bFOLkxLJsb1zB4VhLgaJuPbiTYaiW091s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNOeyEcYjEob290dRXJpfQI63T3041BRC4vfE6PVG/IZMhsdEp
	M7MDhrbt4by+vrc9qoJTeH5XtP9EzKnllnyxLtLIdAui2nTHPxI02dDqY6WULw==
X-Gm-Gg: ASbGncvlrn5gNZZ8TzkoqPqL+sHBtqwXbBkLjdNwypz0yQjYZtivqLEiUjV/RGOJ8rE
	53zJ9DlKUCQCKWNbBLCryz470kA9JiXB5rdIcM1/I78ZKkvvApoj+2OSxiSjH9P8y9tVvr+s3Sg
	njUA2LixcvXKZk6n6bSsNjVwJfWOXkfUBpTEP9//b9RQwLROyvxBHdKptFewl72qRV7r/YD4vsS
	PfQ1FvHBg3Y4PHUmQzNqrzDUorbI35yftToJRmFt0Y7Pwu+E3W4QS5QKgY9UgP1QTSkKb18gjWd
	3jBsOPYU8iEzyCKAr7Y=
X-Google-Smtp-Source: AGHT+IG6+jByA0PrH/eC1+V2PyBt31aGCsCjFz2zdX4WSKw9zHmoUsOnQ2y4Ak52aJjuOcTgc7eMqA==
X-Received: by 2002:a17:90b:1f82:b0:2f2:8bdd:cd8b with SMTP id 98e67ed59e1d1-2fbf5c6f522mr7810051a91.29.1739411596690;
        Wed, 12 Feb 2025 17:53:16 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:3ed3:97ce:5f5f:1f61])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fc13ba564bsm111460a91.40.2025.02.12.17.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 17:53:16 -0800 (PST)
Date: Thu, 13 Feb 2025 10:53:11 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Kairui Song <ryncsn@gmail.com>, Minchan Kim <minchan@kernel.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 12/18] zsmalloc: make zspage lock preemptible
Message-ID: <cn6utb3m7ftchpnygi36sm5fbib6momo6voiix6wlknw4dwg7h@7km27pic5lh5>
References: <20250212063153.179231-1-senozhatsky@chromium.org>
 <20250212063153.179231-13-senozhatsky@chromium.org>
 <Z6zXEktee8OS51hg@google.com>
 <etumn4tax7g5c3wygn2aazmo5m7f4ydfji7ehno5i6jckkf27e@mu3fisrw5jcc>
 <3f4ff25513fa8a6589288418694f614e4d0399c4@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f4ff25513fa8a6589288418694f614e4d0399c4@linux.dev>

On (25/02/13 01:31), Yosry Ahmed wrote:
> > >  Hmm I know I may have been the one suggesting this, but do we actually
> > > 
> > >  need it? We disable preemption explicitly anyway before holding the
> > > 
> > >  lock.
> > > 
> > 
> > This is just to make sure that the precondition for
> > 
> > "writer is always atomic" is satisfied. But I can drop it.
> 
> Right, but why do we care?

Oh, not that we care, just wanted extra smoke-detectors.  It's gone now.

