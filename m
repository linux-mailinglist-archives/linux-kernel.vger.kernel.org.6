Return-Path: <linux-kernel+bounces-512212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC54A335A2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 03:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 645921885D6B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 02:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41241FECB4;
	Thu, 13 Feb 2025 02:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ax2OFELV"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB78C23BE
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 02:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739415262; cv=none; b=nI1L64wG80XJzosIcMThAgfCv1hnd0gypE3HFGOain4xpt5zsqGYkhGEzySTZdCCex+RhKzPJ/Gfm12gUZ1vN/8npzE7L8jW2ng0w6qD4q1PczzMAfuBb2bhiK3hIJtbZok2oDXIkDP2ju+36dxMTFscDPZ5gMZcxlAc7EgYb6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739415262; c=relaxed/simple;
	bh=OPpAHC26NrjdXOzuN12JLH8EaSipBSp+Ba2ATOtEVZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUhLNikOoNMcMfJFWYAIjT5zdQB8SBnIpc3gAbpXBfTWGgCeVxQKoNKDuINevWD+n6hdW7Iyo/dwEHp34UoQNZIIri4ljKCLpfhy+1XeOzFtX5Q3lh1oYoJE9jsiVwBOPrbZgsU2kSslqw3ebQ0EbuDvwgiUqJO7n2VwrlPzNIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ax2OFELV; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21f74c4e586so5793335ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 18:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739415260; x=1740020060; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FkEPKUK4TubZ6Z6+0k4LQ0SxXfbAAf7UoZRYB0nxrs0=;
        b=Ax2OFELVFyrpn2htgj9HkOYmhdpxR7N4gXqwuEDetJmkOy6WjinPfdX48ckmEilMtr
         0n3MqTES0QP+2Cmf1VHZfYce5zxDCISXpji1DdnYiZMVZl2+pIPMFZMGrlmFTqbTfmi0
         SyrEJyg8pBO1oHM14sd0gea/kdeD92WH9WmDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739415260; x=1740020060;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FkEPKUK4TubZ6Z6+0k4LQ0SxXfbAAf7UoZRYB0nxrs0=;
        b=jxnvaq0ZUSPJPCxIARS/6AssHeXicd9U6R6GCluxuYjF2obmwvtW1/7GHRqeaH3/4d
         VhinCif+u+21vxx2us1TrhbAQBDjqQR8QX8OTKY1T/Q9eYPtEwKkuoJZtIU5QoI+FTAD
         /8wa0ma8bVzZ1zbPoUtKtpHq+/6fVLxSvuhcCS0pg1+Q/iNQ6UD4RUWfRcszJazGV1GE
         Ezzk2nCQhIXHzmvXAicNtVtS4Yl0AjtdNbA+U28CMDcweH83dV/whBfuU7zQZEEg0A/C
         c94zxWYBc+aEhD3cZAAHBHtVq+2rPOV7uvstwQQhFfTftuFvgH3gBJ9YZVIYeZ2Sssie
         ti7g==
X-Forwarded-Encrypted: i=1; AJvYcCUL35DjOFivytamGMd4OKQg3r9HeV5xfH5bY9tCvDrDAYFTwnjcvKCWjRTUrPXazjt79YS8V5xp85yZkK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVUFeZkPs//ueBjg9XNUNaeTNwPpvLuEqXttVGLOCN9og0moE+
	J4Lxfy3Pppkm9TBs0/gUdlsv2/meHU2VgYE2FL0R5fLDJDbaNvQHmWNzsjtzyA==
X-Gm-Gg: ASbGnctKwYCOpLhXjyfyWbtJlwByGHeGH9qWnAkA4o7ANQnWZeKzvVlpfoCjDGDZsZ1
	HhR6ym/MDVNuKIbpCdKBkrtzSC+iQz7yIzTVuYBkwEaGKJvXzF7MxuwVUm755JITYXpqscoQRU/
	PN/5OtAzg86dzzGnZqC8QGaTWwv0LF7GZhaqOwF8kXmJYXXdVjgeQ1eha5IN0r1tC+K+q4ih+9Y
	pz1fyvB8fJVGrlaTmoZK+Cj5Lx6H04cKwP5tdNwCeZxb71YhvLdjUHS5MkEkw/7/txGUuvRwBcw
	IdAaUNLxX+QdPexxwWI=
X-Google-Smtp-Source: AGHT+IF359UMSOwJG5zyuaB6ecGZdxQbBzDMlQGReXoiCgo2R2yvu3zOnQgdn1+e1o6JRf3jPuZh0A==
X-Received: by 2002:a17:902:f643:b0:216:57a6:2887 with SMTP id d9443c01a7336-220bdf15c1cmr85751915ad.21.1739415260009;
        Wed, 12 Feb 2025 18:54:20 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:3ed3:97ce:5f5f:1f61])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d54fsm2340115ad.141.2025.02.12.18.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 18:54:19 -0800 (PST)
Date: Thu, 13 Feb 2025 11:54:14 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Kairui Song <ryncsn@gmail.com>, Minchan Kim <minchan@kernel.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 10/18] zsmalloc: factor out pool locking helpers
Message-ID: <cbbcq3vklpcrwizvbjupsyczcv7ccnygys7pg3njbrpostw2lh@7kwgdoopeyy4>
References: <20250212063153.179231-1-senozhatsky@chromium.org>
 <20250212063153.179231-11-senozhatsky@chromium.org>
 <Z6zJxvLbRQ6pKtue@google.com>
 <5htndqx74yv2lq2zr2odozrrbi5cz6zizn3vk4uosobn4ceoji@5zuknjmi26f6>
 <28ed23c00effdd531a9e027feb0bc08e22fc677d@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28ed23c00effdd531a9e027feb0bc08e22fc677d@linux.dev>

On (25/02/13 01:12), Yosry Ahmed wrote:
> > I want to hide the details, keep them in one place and at some
> > 
> > point *in the future* have the same "locking rules" as for zspage
> > 
> > lock. Also *possibly* throwing a couple of lockdep assertions.
> > 
> > So I'd prefer to abstract all of these.
> 
> 
> I'd prefer to introduce the abstractions when they are needed tbh. Right now they just make the code less readable.

OK, gone now.  I think I didn't screw things up resolving the conflicts.

