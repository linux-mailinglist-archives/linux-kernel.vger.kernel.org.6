Return-Path: <linux-kernel+bounces-273031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A5A946392
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 21:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4333C1C20D64
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 19:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C155F1547C6;
	Fri,  2 Aug 2024 19:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vk9ppAxT"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5E97F6
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 19:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722625922; cv=none; b=cFkW8i+YQ/nvjg4HthfD/FLAmCz6Qv3DfJhfoh5yplCu9pUawUtuWTjwnMz6UHTpYKZKBCVuS4H/dxDrDI1nFOfZUWjpTBlgIb941PREQNmiotcIKlznRFDUcZXsFGSGMnYT48cuR2wCmceTqPzymsP4zhQop1AfUkHd90aWK/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722625922; c=relaxed/simple;
	bh=EWtYVhmS7Rc/4BT9faJuAk+IlhdCI/19TyuATieFKd4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewjhTa0lNqrMH3vlch4MjhYdD9EDAfWCOdBOFaDe4pvCkFWCc/QrsOoXCeLKjUsQSoWaZB+dhuXmsWISA+1VEyK2iDEDzGUFfuUyKTu0+f6kYI7MJt7nBjptv+HCCZJSATnkR8IKgHVwKyNLPREUkrGe7SfI4/O809fHm+unvC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vk9ppAxT; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fc587361b6so64778905ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 12:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722625920; x=1723230720; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tb35QWLLfD/xsYl9CucCtFL851FIcfbnJfN3ybM+l8A=;
        b=Vk9ppAxTFpOQpLmOeUSQF56BN/qt7K7Y//3pEXPahn9E7NdPtdWXNUzifZdDQTWQ50
         XoiPY3NBxGwC+7fc12S+MX4sCh/1NIb+pz3aawwbOZol0gIZQ7hfQx7omCcyo5BasTAT
         vfeKZxQgOwVA1yjoXX29rRfQbPIegi/M6Gx1UUdsrx4/uKzyl//KOsPGBAH38We+4E65
         RPU3zvbLOWhl55La03QEt0NwnL+FI1WWg/2qLWnl3KKcUOJphC6p3fNadzxmLMsIZU7f
         lN/MNxEKSNh0IY2mC6sQGRBi3TG1TppOdQUrT5RQe3VgeMaAYAr5HWr4y0kWcr0si6f5
         wN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722625920; x=1723230720;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tb35QWLLfD/xsYl9CucCtFL851FIcfbnJfN3ybM+l8A=;
        b=CvsQcFcJgc3sG4nbayS2LI+8vxRDt5jVMlT7HI5itovrJ+YVmn7kxEEYmuBVsI72ns
         5aK0A/MUeE5V3avJwL4TibBapjWIjO3e7ocs5qpPWIDvnue9YkDe6KoHTvGCxINEpgQ7
         Wm5THNsU+WsZs1cDo7iBVeKaLRccGtRZMzGZQNE71z08s3MSP6W+5MPRrdGfWVYS46yC
         Cf1x6CTs/hcOfcSa0P0yYIaac8fp5VYHPFlo8OtoxwRQo9z2hC6Fo9YJX6R4VwRTsNSc
         WRhef231BZBLCQm9PEi3ZdNlNMyjosfFmfIlWuI9TC8FIXwa0p1R6TO3M/ufOitPOIy9
         57Mw==
X-Forwarded-Encrypted: i=1; AJvYcCXCAKgC5aK01aKvcd2zOSHKRuT0Ha2aIt1K+jRdKd8XWIhgVKARo0HQhj1W1v8o246WWhKUHoFzqi+snee7tf9OaU7TGT5kAhzcEYf4
X-Gm-Message-State: AOJu0Yx08dPYh35MI4UJ/TGenpzjROjTQrtigKdTM7gxw0DNyMuLJu1T
	dRtZeYIhRTzGFrQDl8yEu31OAXAsgCtVMxM3H6zCIFxo5YmqAWJtZGyLCA==
X-Google-Smtp-Source: AGHT+IEKXYt6pFdyXMkGJcwp7ptJcH221g1Bq57XCSZ2a/jU+ImUyDZfEhckltnD+YYSt3ikqIzJoA==
X-Received: by 2002:a17:902:e5c9:b0:1fb:64da:b142 with SMTP id d9443c01a7336-1ff574f685bmr54474635ad.59.1722625919988;
        Fri, 02 Aug 2024 12:11:59 -0700 (PDT)
Received: from DESKTOP-DUKSS9G. (c-76-133-131-165.hsd1.ca.comcast.net. [76.133.131.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f27358sm20823585ad.44.2024.08.02.12.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 12:11:59 -0700 (PDT)
Message-ID: <66ad2f7f.170a0220.2d3b0e.763f@mx.google.com>
X-Google-Original-Message-ID: <Zq0vfAelJYbqQqiC@DESKTOP-DUKSS9G.>
Date: Fri, 2 Aug 2024 12:11:56 -0700
From: Vishal Moola <vishal.moola@gmail.com>
To: alexs@kernel.org
Cc: Vitaly Wool <vitaly.wool@konsulko.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	minchan@kernel.org, willy@infradead.org, senozhatsky@chromium.org,
	david@redhat.com, 42.hyeyoo@gmail.com,
	Yosry Ahmed <yosryahmed@google.com>, nphamcs@gmail.com
Subject: Re: [PATCH v4 20/22] mm/zsmalloc: introduce __zpdesc_set_zsmalloc()
References: <20240729112534.3416707-1-alexs@kernel.org>
 <20240729112534.3416707-21-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729112534.3416707-21-alexs@kernel.org>

On Mon, Jul 29, 2024 at 07:25:32PM +0800, alexs@kernel.org wrote:
> From: Alex Shi <alexs@kernel.org>
> 
> Add a helper __zpdesc_set_zsmalloc() for __SetPageZsmalloc(), and use
> it in callers to make code clear.

Definitely just fold this into the prior patch. It effectively does the
same thing.

