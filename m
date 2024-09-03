Return-Path: <linux-kernel+bounces-312110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE00969262
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 05:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09E8C1F24728
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 03:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8592C26ACC;
	Tue,  3 Sep 2024 03:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O7c2koTd"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EC6370
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 03:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725335149; cv=none; b=kyPbfGRbQrsy8HE4Hxud/lU0zE3tzat8eoaTSerOPV1OIi+fAadEc7+IICHzhq/2mpgEn7u9nPTToMwjCU+az+C3Sxyf3dGNlSfTnSnXO08jYO98XD2JmFHYbV2q6oqqC5QAOI/WoiYh0EvyK7MCM3d240J5OWVG0zKIZrF4OCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725335149; c=relaxed/simple;
	bh=bVKytLDxsE46Q/4tVFBnqttKHvvEj0MvdnQeEtXXsv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cMROnoEPpVt0vJL3PTJtia2yT1gPc4YV6DXXHuNrLgPaBbpkMLyW8DP7WhLRUnQ8Uf1ZammDKCQyUIjNsAuHZjXUZ3YoO2vY21eenZd/zjE5doRQ+f7dxHB270YUQS/uq7fiii5rcccWFHzTieam9GnQM1EAp7ftS57ID7DhXe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=O7c2koTd; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7163489149eso3216011a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 20:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725335148; x=1725939948; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Km5PVUKhCxGTdG5gL3fi9jYPA6gpZatneH7uhUAa6l0=;
        b=O7c2koTdNxGhvNuz4mp8gg4P8x6PWU3omHLxL7c11uiC6f66vcIcekrQOuFQ+MKKEZ
         CAzF+5fLsV/c00nac33in0AyJ+5EwoLltoZH9p2MmKkVx4CCFu+ucXAJLib2zUERvuXh
         5jtFm6VZdFSpAykptnSgOKJqT/mnnNrChncu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725335148; x=1725939948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Km5PVUKhCxGTdG5gL3fi9jYPA6gpZatneH7uhUAa6l0=;
        b=wAKIMcWflhyGOlwz2JwjtvAFIVhNxvmCxmi6vVfdubeiaP9ebuGe1svP/abQQOfLDc
         qw7Fw22HJPXW+wwwDEhcYt0rwJB5YQwPpZxmVyepYsl6DRVammkwQP6ouI1oeDhpBUoP
         hfSuz1/l+lvvYIxk1gHd0g4PsRejm0FHRcU9wPnYY1Iwh4/UeYFrQzGoldnDNaAwIyis
         /BfmenGq03aDWSNxJN2P4SQRhaucfOg6zQm4C4ww6DQTATVk6f3Iok5+FvXft4ps7bWZ
         X48SN1sa5zaGoqtXEpPw/frO06/OiHKm/DGycTGyN24e1vC8ARCyh8pmbFFZz4o0xK0l
         8W5g==
X-Forwarded-Encrypted: i=1; AJvYcCVXTguiqhoyPQFxzDlO260O5aQir3iFsPX27U4JPQGUWDLBe43Ew2F4zVpL7ExBbk6b5Q9my2svWdWkHo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcliYxA9+HAvFBxcTqZAo4SsuAusIfRyvJTJEB9aOpzaUB5+2N
	3dgTobemFT4Yf+lPzvfpfDao9PzkNizqJwufKw9RgKlHl6cUcbN6ocRBYnckag==
X-Google-Smtp-Source: AGHT+IF6K8JBsajQW0eAH1EmiEya4ZtXWiyNQ9qkJ5PAUuwlP6Gm7AvchdUNYhclKML3DqwhtiAR0g==
X-Received: by 2002:a05:6a21:3984:b0:1c3:b144:2ee1 with SMTP id adf61e73a8af0-1cece045483mr12371543637.44.1725335147814;
        Mon, 02 Sep 2024 20:45:47 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:43a1:71e3:7464:e91b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2053e1261cbsm48358895ad.228.2024.09.02.20.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 20:45:47 -0700 (PDT)
Date: Tue, 3 Sep 2024 12:45:42 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: alexs@kernel.org, Vitaly Wool <vitaly.wool@konsulko.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	minchan@kernel.org, willy@infradead.org, david@redhat.com,
	42.hyeyoo@gmail.com, Yosry Ahmed <yosryahmed@google.com>,
	nphamcs@gmail.com
Subject: Re: [PATCH v7 00/21] mm/zsmalloc: add zpdesc memory descriptor for
 zswap.zpool
Message-ID: <20240903034542.GD9738@google.com>
References: <20240902072136.578720-1-alexs@kernel.org>
 <20240903033558.GC9738@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903033558.GC9738@google.com>

On (24/09/03 12:35), Sergey Senozhatsky wrote:
> On (24/09/02 15:21), alexs@kernel.org wrote:
> > The descriptor still overlays the struct page; nothing has changed
> > in that regard.
> > [..]
> > This patachset does not increase the descriptor size nor introduce any
> > functional changes, and could save about 122Kbytes zsmalloc.o size.
> 
> Is this number accurate?  Where does such a large saving come from?

./scripts/bloat-o-meter mm/zsmalloc.o-base mm/zsmalloc.o-patched
add/remove: 0/0 grow/shrink: 2/6 up/down: 7/-843 (-836)
Function                                     old     new   delta
obj_free                                     211     215      +4
zs_unmap_object                              568     571      +3
zs_map_object                                661     633     -28
SetZsPageMovable                             135      86     -49
free_zspage                                  310     253     -57
__free_zspage                                284     226     -58
zs_page_migrate                             1304    1136    -168
async_free_zspage                           1099     616    -483

