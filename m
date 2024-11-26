Return-Path: <linux-kernel+bounces-422881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F6B9D9F43
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 23:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 111C5168AC6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 22:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA911DF973;
	Tue, 26 Nov 2024 22:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OhPbybRa"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED921B6D0E
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 22:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732660728; cv=none; b=HHfBnkQWzhEEOqHgFAri3awj8D0Em5y5AYvDMzfAJVp0/LJ6t44vLA9c0noo3qnKhN/RNgu7tiOi0Jfc6GTgy6imFRzaJRbMGJA7mhNgxwBjXhRpydkmLQ0VEpr3rg3+TNZbLJPBrSSMFg10hlncSApuM3DU3SM1ILB26Bdeheo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732660728; c=relaxed/simple;
	bh=aYAG80AUb6hJtCIVLYBuWYRFc4jMu61+jpqFyZT67/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TANhP3IXicUBLezMISXRTATgHvt3MNNRk+kYlpKKmVCVuls7Zbv+vjQT6uKtsepM1lT6+LeFPSDxrDpnsEIXkXL7QWGzgxA4zv6sECdFA1aAxCoRgFLBzSHvRTZMLPhYYnGz7D2U9wjF4kAAT4QwoApOXVqpkoksypOn8hYKvgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OhPbybRa; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-211eb2be4a8so20245ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 14:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732660726; x=1733265526; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IrA1NKcxVtbG/Sg0LqOr5M6ECoDqus9nZM+Fd1vZdGc=;
        b=OhPbybRaRf7tKwDHTQ6q9uP5FC2FdcGuGwazIGZYka4Q1NLit8WNMlqT6X/xibf6qK
         +orLOjhSNTUuUCfP9FZNw1k7XaOQUP2n+z2p8OSGS6Pl954gtDG+dKHAyxmJKay72Ofs
         +LMPPIsjjpQ2ERUMjcNAOyZ9y/efhaBxR50tSUQAf/mkPaDu0dsjo/s37jpIsWPBRawp
         76NdiaMt3sjTOsHkDOHhoIl+BXW16SKSUbM9Mal2D610AQ+Ej+0sHrmag/pNBbifYGV6
         5UYxvaYIQQ2TpgJwxoI2jyTJC3+sEm1F7klRZdOTpxvBvR+WkOZQkQG15pkMYVnsrN9h
         IrVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732660726; x=1733265526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IrA1NKcxVtbG/Sg0LqOr5M6ECoDqus9nZM+Fd1vZdGc=;
        b=L2voNiIdgOoDxbqnkkBOSGrGKyBjT/LbpVZ46/TNFRkdczAj180dFn7+hIiSxRvP1K
         Wq8IKqeu6SRXDStTHuPNsBeJVDprCX73N2DSIYJLIxsTVNS9SEfrcmbrZptYu79W9c7X
         zUnObPtcbY7lD8YIEeS23I9ToPrD/Wddbjgee5t12D/HK+rmyMg8OanDscz0kwxD83hb
         3boQEEziGrT1pL6xSVqWp8twmIt3YEUK19BQh02Uu+NY/DoI3N1I+/NXqMqSGrxabLQD
         au8bNR7tjumIwWPRtiwRWxhCyizm3y3PUMA/mywTd6zpHGpwPAdP2c6qFqhLVMIR7xMG
         ZwZw==
X-Forwarded-Encrypted: i=1; AJvYcCUFw9jxiHzyg/m+ylT8m256u8RJcuX6FLxbpfbXkpAtDKPUgA2vM9+xan182+TYlX84OKwrKecuqCQPG18=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGdvF83tYYr+eVny9Bc+we92ceCsvUyrGQwuQ6zFuJtk7CC7/l
	EPUAmU9Tq88DuEhEhOAm4ibP1uol1Xg4HVTdmR+78szaI7ARshngD7XdzTGToA==
X-Gm-Gg: ASbGnctOY+R7XdhSANuEU9E5riL9e2GAerXrjEfQLf9Qw6hbL/WwPaoSUl4XDtx7kuF
	lZ7wFeWfAx/3dmMwofE4k6/xHEfltWGZPkzzhAKbGls03NH86UVOoeGgeTACfPm2AFw42E4NzbJ
	2LOmEaRB/W8coWBZf7z65CVZfcpgLiKfqVvYkrEfmVUwqEn7YnpKG/WkS4HvKv98KIpzEO7Z1Og
	wRTKwDlGQm8T3csUf+bEW2de0csNewhVqIry2W7hLh9wrPhl7LjGqO7oKdnb/vzD1dQkat+dhlo
	fNAUThlAhsUR
X-Google-Smtp-Source: AGHT+IGjOOgSJBiZ7sK9f0uxVrf2fCFcHPeEzGGCIHTWrhZooaU9aR4k7+IgfbXd3uqJssPgulPoNw==
X-Received: by 2002:a17:902:fc43:b0:20b:bc5e:d736 with SMTP id d9443c01a7336-215063e999amr241945ad.11.1732660726215;
        Tue, 26 Nov 2024 14:38:46 -0800 (PST)
Received: from google.com (226.75.127.34.bc.googleusercontent.com. [34.127.75.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de575d2asm9206575b3a.181.2024.11.26.14.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 14:38:45 -0800 (PST)
Date: Tue, 26 Nov 2024 22:38:41 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [PATCH v5 4/9] binder: remove struct binder_lru_page
Message-ID: <Z0ZN8QzIlK_NpOEg@google.com>
References: <20241126184021.45292-1-cmllamas@google.com>
 <20241126184021.45292-5-cmllamas@google.com>
 <Z0Ylr1cJ2AZ6rcXO@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0Ylr1cJ2AZ6rcXO@casper.infradead.org>

On Tue, Nov 26, 2024 at 07:46:55PM +0000, Matthew Wilcox wrote:
> On Tue, Nov 26, 2024 at 06:40:07PM +0000, Carlos Llamas wrote:
> > Remove the redundant struct binder_lru_page concept. Instead, let's use
> > available struct page->lru and page->private members directly to achieve
> > the same functionality. This reduces the maximum memory allocated for
> > alloc->pages from 32768 down to 8192 bytes (aarch64). Savings are per
> > binder instance.
> > 
> > Note that Matthew pointed out that some of the page members used in this
> > patch (e.g. page->lru) are likely going to be removed in the near future
> > [1]. Binder will adopt an alternative solution when this happens.
> 
> It's not just "near future".  page->index is going away if not next
> merge window, then the merge window after.  page->mapping is going to
> follow it, and page->lru after that.  Please find another way now.

I see. I've found your patches removing page->index now. I'll go ahead
and rewire this to hang everything under page->private. Thanks for the
heads up Matthew.

--
Carlos Llamas

