Return-Path: <linux-kernel+bounces-233204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4590F91B44B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 02:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 780551C2112B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 00:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867A36FC1;
	Fri, 28 Jun 2024 00:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LdmHBwJw"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91432567F
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 00:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719536129; cv=none; b=FJuDMnBB5eMlJEzonAFuI+WM8MH0nuMWbecSeNqu0F34R8YKvb0SRiyh+543i6ozGhh/H/3uzeXKXDoul4YBQi2+PSCAZZgFZi1IRt1kIUTNTYZtq87DhnJouLDzycFW5FZbvWzoMQivqYCWDD1l/vZ/X6t8BuLrlzb/NW3B8GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719536129; c=relaxed/simple;
	bh=sSpXWCyEk2EDRMlCds1q4O2Vm7aRvAgsbc9ryA4bNHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUYyyqwRVJ9Xxc8IcrOhtadqFOjmeT2BbMJmMaxOUffRC/J3F+5JvATsIUwhizpzsEs064wkK29Pq5bbdKLC+ApmTUMXWj7QVQSPTdJlU+6qZXXHVZzLzYMEOwB0a8wFrkK1IRsXIHKwzVvTYjliACQqwSkoQlz0EWclKhFGLkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LdmHBwJw; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-71910dfb8c0so22013a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 17:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719536128; x=1720140928; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X4lJQzCRPoEPhHVSEfjDtIXs2Lfn884K9fgq+Lhgsbo=;
        b=LdmHBwJwWPPIFZ3i5wHk+nTywrl5zz46syf9vud08LPB4CdWW+hPY4p6qpznqD34Vf
         WAAqcouEHNGmdlmTGD2vaIay8QuGFLQLjmGUDjfgNvAK9fOY7Ty9XkOHTKdMUZponsRK
         TgOWw2jQyHiRoDwb/EbUCyB3avC5LF4qtBJvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719536128; x=1720140928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4lJQzCRPoEPhHVSEfjDtIXs2Lfn884K9fgq+Lhgsbo=;
        b=Lv7t3ZbfyRywDtEZ1/+3j9EolDnq8P6xPw6qaxK0tmDhQDMA5LTr4Hok7g9gmrLX9n
         3QKS9IIraDAuBfNDdicQjLxmG8TWbDKKLvpUDSlRoL2oUXPhQr85ON9H8cRYqGL00ot9
         9iKNzCtmSXlaGTtzJsIFS/Ssqbqo8WH9qjxr2BWkHxeH8VAhOnU9ABSDwLI2xHThLbO0
         Sl1Yf8Ytw6wJbg5fS0xlP2QoqXSiIaYUBFe1i7aS0RyEeT+mWl6sOjv+e6mh1L4XMjTE
         98m6HEaj3NqdWU1TMd+VrMbPQM8LSJOOqSED2DcW9Eqb6sduEqt9c++wBAW7rUCocFFN
         JloQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwNH6zIhRarFd1+Tmw3TPQYjjWIO2+8X+91MAp9r8EdXonDfjikWGKL+4rlDpBcNQMjuPbuUsUWVjmLsde+XGDz1HdVZM/WsFkylh5
X-Gm-Message-State: AOJu0YyEvujcTzKua/keJsKJdPf9tGHptNu8hlXveLKbavOEYq7e01Rf
	+H6wQvtlsqA5V4EmyhqOZRcrvf2sm5acmzZfWW/M6bd5veflBJK+MUvaNo/8rg==
X-Google-Smtp-Source: AGHT+IEOCloo8kkoRoiQKPVId5pLv0VtG6h8sTIAWnQGJ5/+CLOJodNeklIIV+t7oQQsWSdNQD6UWA==
X-Received: by 2002:a05:6a20:8b28:b0:1bd:286c:b0f5 with SMTP id adf61e73a8af0-1bd286cb1efmr7445570637.42.1719536127797;
        Thu, 27 Jun 2024 17:55:27 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:c19a:b9a8:4bd1:72c0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10d1482sm3804625ad.3.2024.06.27.17.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 17:55:27 -0700 (PDT)
Date: Fri, 28 Jun 2024 09:55:23 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: minchan@kernel.org, senozhatsky@chromium.org, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/zsmalloc: fix class per-fullness zspage counts
Message-ID: <20240628005523.GC15925@google.com>
References: <20240627075959.611783-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627075959.611783-1-chengming.zhou@linux.dev>

On (24/06/27 15:59), Chengming Zhou wrote:
> We always use insert_zspage() and remove_zspage() to update zspage's
> fullness location, which will account correctly.
> 
> But this special async free path use "splice" instead of remove_zspage(),
> so the per-fullness zspage count for ZS_INUSE_RATIO_0 won't decrease.
> 
> Fix it by decreasing when iterate over the zspage free list.

So this doesn't fix anything.  ZS_INUSE_RATIO_0 is just a "placeholder"
which is never used anywhere.

We can land this patch, if you insist/prefer, but it's some sort of
a NOOP, essentially (in a sense that it has no visible effects).

