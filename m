Return-Path: <linux-kernel+bounces-542173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD79A4C677
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A653E3A70C6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FEC2356BD;
	Mon,  3 Mar 2025 16:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UhZrV56Z"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078C9237164
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741018181; cv=none; b=q7SNDTYK+P2awTuoBa0z8cHtN71AFAInVMGilD6sFJ/5Zy13zZIhytgvi0dPXl2fMUEV5hlCeXe0yk8d0sTRLdxD0DZ19EIY6mKV0ua27IdPyjLizoYA2DJ77eVFZwSq//ibjfTxjtuE5oATyrV3QT6THBP2LphWMISjb0P4XPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741018181; c=relaxed/simple;
	bh=d11H8566oYzwg5fq7spMzPlOUQsJH7TAfPQ2UxiBLLw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6DToZTqe4xBmg0ZqH44QOBFi4yyi6Jb2xMwbfZ9KLTOlIvYPUJfRmlBXLVdU7Fgr3cpyM7C/3iCICvx8EbEL+JN/lKmJO7LT56U/emYHyGtSqOaIoX0uMRz5114I+SKhkPQeV7e3/GMq0tXqj7VfU3A3FIEpLHfZb71jNbxzZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UhZrV56Z; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30761be8fcfso49356951fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 08:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741018178; x=1741622978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6IjgIQMjyLmH0kadGKdaiTf4ALagXCihpSuhgGvaARY=;
        b=UhZrV56ZfIeRjB2wRBmVWHU/RaX+KdcLGvjEAYzuzrJd3u2JMdph+oqIweJZ/WvQw3
         ZxHk5fni7B3dDr8ytAFCLui62z9i6pWoHA3t8jWXznc8etLRjD9iGmITwWCeoMLqNajw
         JHfad6kFDkgSeQtosO4vf30nAN6MvXGubvt8Oc1quIwJPFbmqFESilT3R34eUEIOGn/B
         IpIZIcv8LjPvaf0kE2vu69bysUX41inZlCAIrYqsdNRPqXIqB8B7hk7DjbgJHnQkkxNr
         HRM4vg/9s4qJSw1deKl1Wl0bptpRx9wRIAgQmb5/sVdUJMKGE9wLjfDNHoRgtkV2g/gs
         uIFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741018178; x=1741622978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6IjgIQMjyLmH0kadGKdaiTf4ALagXCihpSuhgGvaARY=;
        b=GE6RTo81Ra4XdTa0u0vZgZRwAjflUj8lIXNhlpNlB+bsiaxwVX0iyco04tTj/rjNV1
         FSPV7ILYtrgWhirGl4ZvwNaPp8Ic6RKJziol8copkG2NfwaVVnOR73FCG3LLxVfDcLFX
         H0xPYPFEJbXo7sjVwpDYpAOY9dBWqCRX/RqIYQyRrtXg1L+4ACz4Yf31Z8ZeeiNdgHsb
         eHZ/4y9W9gluiQ4Op9XptW4zWAuNqk+AGi/B/flXdPJXBE/JrcFyQ/FkAxZ9UskaWyA5
         /bQ+BY/myGk1ZhwCHYpD7D/lyhgcQJUR7fZurNn2nMbzTzyVZQAb6Q4vPCA0xFnw2vvY
         vFjA==
X-Forwarded-Encrypted: i=1; AJvYcCXtXwL31MaTHdxZV3tTxN03j5nzDycXFRu3hUI98eWRV6jLEG8QWmwe8tY2qAYCpdwOpxKF28ovpSJLTuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkJwjL1nOqgWzXrVgWoOXcxgcVSh9Jbx0A7EvaEMlhrY4LO5QJ
	UVtb6SCHTaARLocujVCloOMbTaLeb2hlXJjQbWR3cDjNnAnjHVT2
X-Gm-Gg: ASbGncssR4fSgXnHeEE+MQQrrzB+QEoD2acm+btQdq+WMCkurHu0Me1XF8GedYYRCIp
	oIHWjkOitpP4Nrgzb/LaAnTPffKwwsHTrtideYo5fz2tX9/XjOZBxFw27NF+6jlWqVCoQbaS37Z
	GLnWgtZ5pNkHoft1RWxYBeszD1QgYfUYxSPbXBE6YU7Sljz0AczMY8Hz04sLcW+qVx/7DNemLna
	ZPNe6wHaoG/kiql1sR1Q3/J3yfHNpZa57VvnJzquaQCigBQKf5+W7Ydcm4f9YifYUio3fJh+O+a
	EL2oHAeOz8g=
X-Google-Smtp-Source: AGHT+IHgc7Gl60rYTzinEYN7iW5O6cXP91XdcTk8Vu4+nkAW/mFzB+LhMve9YpX4q53LKkINULovYA==
X-Received: by 2002:a05:651c:4cb:b0:309:1ee1:3512 with SMTP id 38308e7fff4ca-30b932f6e61mr57750541fa.26.1741018177893;
        Mon, 03 Mar 2025 08:09:37 -0800 (PST)
Received: from pc636 ([2001:9b1:d5a0:a500::800])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30b9db4e567sm9919121fa.38.2025.03.03.08.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 08:09:37 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 3 Mar 2025 17:09:35 +0100
To: Liu Ye <liuye@kylinos.cn>
Cc: akpm@linux-foundation.org, urezki@gmail.com, hch@infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Optimize __vmalloc_node_range_noprof function.
Message-ID: <Z8XUP10G3cTJlbuw@pc636>
References: <20250303094410.437985-1-liuye@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303094410.437985-1-liuye@kylinos.cn>

On Mon, Mar 03, 2025 at 05:44:06PM +0800, Liu Ye wrote:
> The use of variables real_size and real_align in function 
> __vmalloc_node_range_noprof is unreadable. Optimize it in four patches.
> 
> Liu Ye (4):
>   mm/vmalloc: Remove unnecessary size ALIGN in
>     __vmalloc_node_range_noprof
>   mm/vmalloc: Size should be used instead of real_size in
>     __vmalloc_node_range_noprof
>   mm/vmalloc: Remove the real_size variable to simplify the code in
>     __vmalloc_node_range_noprof
>   mm/vmalloc: Rename the variable real_align to original_align to
>     prevent misunderstanding
> 
>  mm/vmalloc.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
> 
> -- 
Let me double check it. Quick question, this series does not
introduce any functional change?

--
Uladzislau Rezki

