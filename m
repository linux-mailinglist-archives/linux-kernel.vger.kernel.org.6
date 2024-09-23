Return-Path: <linux-kernel+bounces-336015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E5A97EE09
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 17:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFDF31F21F37
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E9D19E7E2;
	Mon, 23 Sep 2024 15:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q4QWvyVP"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F7819B3F6
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 15:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727105020; cv=none; b=UlVt/XZLQUUXUXVerBnzrko/WpmA8HSDppGmJN+M3awQIzzWrNrONPobMqaZ0TUhf7UHong4IcTU5iVYv7t5vj7D0czXH/kLi4mhKruvLkE6NLDDZ0mo20q67SitxqS6EnZJXJz5IkvtiooEbl4foCmN5Tf6wooFxDG1+aR2h7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727105020; c=relaxed/simple;
	bh=P9K+MZUqwSTER+380qTQFXNfsNln6IVTVukmwduwtVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1V/uogSjOqtKMx6/2Pnx9pakuiIuTmvEHFyuu/fAgXTdyZhveBIf2ije3z/rrQwsjq6MurEUiOYciKvzuhpRPu9p5P/fXEfwyp9LjjHMvuauCE4QU0rO4nVaba+9GxCsSYZmckbszeh6LnUCmnoZ1eutHt8WRmjkZ10WvUbhGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Q4QWvyVP; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7db637d1e4eso3195298a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 08:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727105018; x=1727709818; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SRbHlAUD8+zFJXZcm/RxNEmbJtnDlqGFSqJp0i/pnEU=;
        b=Q4QWvyVPtgkHktjYKt+dWMiplKrmkZuN+B79/pWQAwdU1lgitXk15RAVxgwpwIcLm3
         K+jzB63mxyvGhUjQr1rv6X6+4XE/2cLZctWs6i+2djpxYBRvmca4FTS3veskIoXBwj9k
         zgaN+85kUy10fmwVIeO7eN4r2A+r1+qAEZXOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727105018; x=1727709818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SRbHlAUD8+zFJXZcm/RxNEmbJtnDlqGFSqJp0i/pnEU=;
        b=V5hjVnl59v9UoZi7ZMexh3xlBN/DrjS+xszfxHfHE/ipBaltneacv3Nay0hGxcVT19
         H7rUoRgQRMkOCE8ZYEMe/RnRZZSjxxGrkCrlQP7Oto4ZTlt8DO4SD+r/1FrtWWkPzpwZ
         eFdHLJRq3BKcMP6wcjiVdnBDKyDs8kboTM7OdAX7nIQM3sMopoEpQUf6MtF6jIzoqKI7
         eJgWVMH3jUBfm115UnbML0++25Ho72v9M2DhfJO0L6Xg3sfogtcveUze3tTI4XYfykLj
         hDehqU/2n34TgESc77eZzYh7ZA4oPzKoJOBDBYetI8DcStdb3qaFZwfbQZUTptIU+0um
         DuBw==
X-Forwarded-Encrypted: i=1; AJvYcCURP1osOKtN0goRCd6cIh1lmjrgYsPccutNmeGLS23bn7NP/WCJ6skIlqNaEJWZ/W2PGEj5OkGBIlZISf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJkFYD2OCwhcmzuOpNtKPfz9xFYHvuMMIFotyWAgEHfSkcCYbs
	6LZgEeuFjv12l2sj20S//UlZXDt6sYat7yrTZB0kdIuR+f4MrMAOsvid1JalsA==
X-Google-Smtp-Source: AGHT+IEoqLYJOZjRKTpWHHQA/7YZunca0vmEGaKX7nwVC1pccwb3zqQkHK24skxuscdAt5DSm8gq5Q==
X-Received: by 2002:a05:6a21:e85:b0:1cf:4ea4:178 with SMTP id adf61e73a8af0-1d30c9e55ccmr14680839637.14.1727105018358;
        Mon, 23 Sep 2024 08:23:38 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:fd63:e1cf:ea96:b4b0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944abb60dsm13975913b3a.70.2024.09.23.08.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 08:23:37 -0700 (PDT)
Date: Tue, 24 Sep 2024 00:23:33 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	akpm@linux-foundation.org, minchan@kernel.org, terrelln@fb.com,
	sfr@canb.auug.org.au
Subject: Re: [Bug][Git-Bisect][6.11.0-next-20240917]BUG: Unable to handle
 kernel data access on read at 0xc00c020000013d88
Message-ID: <20240923152333.GB38742@google.com>
References: <57130e48-dbb6-4047-a8c7-ebf5aaea93f4@linux.vnet.ibm.com>
 <20240923021557.GA38742@google.com>
 <03a55b4b-eb45-4187-9de6-ef06f8176d05@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03a55b4b-eb45-4187-9de6-ef06f8176d05@linux.vnet.ibm.com>

Hi,

On (24/09/23 11:06), Venkat Rao Bagalkote wrote:
> Hello,
> 
> Below is the TC, I was running.
> 
> https://github.com/avocado-framework-tests/avocado-misc-tests/blob/master/generic/ltp.py

Out of curiosity, does this [1] patch fix the issue for you?

[1] https://lore.kernel.org/all/20240923080211.820185-1-andrej.skvortzov@gmail.com/

