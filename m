Return-Path: <linux-kernel+bounces-194941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8AC8D44A8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 07:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EBBE1C2151B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 05:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6101F14389E;
	Thu, 30 May 2024 05:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BsMVim/Q"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C581E25763
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 05:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717045350; cv=none; b=mXmlIN7PCUsgXHJe6b52yWfEUTJOlVQKA7PXD/UZDK9fY4esnUsPSOTtR06ANDeyNC3DT6KxPTeZexjAD82PLHowuf+FJ/FDdYlBdvvS9vRdNyE31bd8WNemSx/NPGXINtMTY9GVlyREmsOuNO/U/p5ATKeECtcbt/sbWc5cRFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717045350; c=relaxed/simple;
	bh=wV4gpbB6zW0xSYYObobATH8bdGUR62w3eMnW/D5wleQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVW2aHdor3BKiHpSsG6T7E4Oj3jeVve2nTzXIMEXqA+oEbdxqbbkzqwDq6ZkRw3fnZpSzAB2qMkgMsUtdOEahYECyd6OL42uEcmVtG7u9jtxHOrURCNKyM5kUoVHScY4E0Kq6vSfnotxclWgwzX0R5eCOchEp2dLVm0Kgni5Mq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BsMVim/Q; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6f6911d16b4so474711b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 22:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717045348; x=1717650148; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E2rzSDb215bjTuDO8BCbneyrOEpC1jpSqJofLgkhMlo=;
        b=BsMVim/QNlGNIa45eyV+cV+1qkw2Q2X6EfNaud00Pr2e9QMBi5S23XI0JbmYLxxRtr
         T8sdhRGx+TI+mhEvDOjg71QR26ewmcNtx2ku22ZMC2Jbe7l2QVkGWupTnKeVFDvZemoQ
         0Zeqdi/+eINop8ne+iZGUo10W+pvwk4pQYGlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717045348; x=1717650148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E2rzSDb215bjTuDO8BCbneyrOEpC1jpSqJofLgkhMlo=;
        b=QfbiO2t26CjwaXvv3T9lua/Fbla9+ySFRAB/WCahJtA4+JyoRQx0Boau1s6TLGfZIJ
         Qnv0tO8No7VF3wNFwGt/zl3E6G4MTtr05gDpyRZU2vUpzirrrnQs9Fvc0zFduoDCCHvb
         TeZZy7hhRxj79P7t0p/XCMIkaX+1gJhNcEUdOj1yPVPVoSh5nuQZv3wTHKB7XS979x++
         le7RLlF5xTGH+c338wXLgelrwqImg3AeM3M80Ud86hkBSqhxW8R4Nedf7OhVN/R+1xas
         WgDFi4PvcLh6S1EtPZltW+P+fFA6lM543uWdMau3cVly/yHhEgY7Sej/aE8duW5pSvOZ
         IQTA==
X-Gm-Message-State: AOJu0YysmA+lJ0dF0YIWkfoCaUJm8rvMmgFA/HYFTC7cfr89Ux29A27R
	y5JapeBU5sIbAfuYOPWy6j8XIWQxBi0pQ14v2QqL6wKNdfgWwGPJhsxuWd4gkQ==
X-Google-Smtp-Source: AGHT+IHN8ur5W5Ju5M/+GYL/UfE5kg+ae0967SpV28BilHbdephBhNKqKAOeEMhgmvM9yQIP5TZxRw==
X-Received: by 2002:a05:6a20:a120:b0:1ad:7e4d:5b81 with SMTP id adf61e73a8af0-1b26452b4b2mr1287569637.5.1717045348180;
        Wed, 29 May 2024 22:02:28 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:52e7:354b:db96:c366])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-701b7cacca4sm3875395b3a.37.2024.05.29.22.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 22:02:27 -0700 (PDT)
Date: Thu, 30 May 2024 14:02:23 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Mike Rapoport <rppt@kernel.org>, Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: Re: [PATCH v2 0/6] mm: page_type, zsmalloc and page_mapcount_reset()
Message-ID: <20240530050223.GB8400@google.com>
References: <20240529111904.2069608-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529111904.2069608-1-david@redhat.com>

On (24/05/29 13:18), David Hildenbrand wrote:
> Wanting to remove the remaining abuser of _mapcount/page_type along with
> page_mapcount_reset(), I stumbled over zsmalloc, which is yet to be
> converted away from "struct page" [1].
> 
> Unfortunately, we cannot stop using the page_type field in zsmalloc code
> completely for its own purposes. All other fields in "struct page" are
> used one way or the other. Could we simply store a 2-byte offset value
> at the beginning of each page? Likely, but that will require a bit more
> work; and once we have memdesc we might want to move the offset in there
> (struct zsalloc?) again.
> 
> ... but we can limit the abuse to 16 bit, glue it to a page type that
> must be set, and document it. page_has_type() will always successfully
> indicate such zsmalloc pages, and such zsmalloc pages only.
> 
> We lose zsmalloc support for PAGE_SIZE > 64KB, which should be tolerable.
> We could use more bits from the page type, but 16 bit sounds like a good
> idea for now.
> 
> So clarify the _mapcount/page_type documentation, use a proper page_type
> for zsmalloc, and remove page_mapcount_reset().
> 
> Briefly tested with zram on x86-64.
> 
> [1] https://lore.kernel.org/all/20231130101242.2590384-1-42.hyeyoo@gmail.com/
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Tested-by: Sergey Senozhatsky <senozhatsky@chromium.org> # zram/zsmalloc workloads

