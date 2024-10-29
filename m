Return-Path: <linux-kernel+bounces-386078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D919B3EDF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 01:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7A92B22143
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 00:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15A128FF;
	Tue, 29 Oct 2024 00:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nk6fe8ve"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A6F23BB
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 00:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730160601; cv=none; b=b8yfXW2DPj5L4pohQ1XvgR2vpTCf4jo2wTvM865w2R9fR2Z+VVWKDElROcgrErL3KCRrNb03QMoWIZzEQVF91Lp/d5iqa1/U1PHoq5D6tOFG29DEzkDR9gvwaQ0kpAU9TUXO7lV792X4Kemr8YSfmVva1O0lXxUgtrw1dx7qvCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730160601; c=relaxed/simple;
	bh=Wvd7y7NCZsR5g5DUTAa1+XtV4RUFP0+yut9cgqwZX/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKJHSx3YLgYAcbsbZjkt0rABsLF90ykq69TeSvWSdhEF/KZH9uacjudvAoXKASlu4jZvEkF6xkk5nkG7opA+Hv8oYEmiFhFCgkonaiS/zS2XMlP8xgFROBWrmaTX2oR71qxgunJzoltCZss/CF6mHoRchqTtLLTWbt5lZ3UI4n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nk6fe8ve; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-207115e3056so42426365ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 17:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730160598; x=1730765398; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DyNj9yhVqBo8rP3kKnrY+7ZOwQuV7aQIAYn1Xhl/8tY=;
        b=nk6fe8vevP7nadzWGcYSZZmAA9ig/3jr3Vn3al/t2F2h4u+NTNdj3QGZDRrZKj4wed
         gEISGTFEjVcT4MniuWERpphZn+GKpIrCkhF4Vign3WWPG0ghb1OLWS/JxVT8QxzQEXGf
         Y/HCUDYRjAAFDVGBAfIQuSd7amwsxrAvuUfZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730160598; x=1730765398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DyNj9yhVqBo8rP3kKnrY+7ZOwQuV7aQIAYn1Xhl/8tY=;
        b=DHb9x9y1yMAAe607ZskW0Bx7jdISoSFTZO0BangxyBAJjlXhIom6t8+qpugefwYGJ3
         evOXYw+VvHQJ8iK2h7c6bm9VTYoi0m/ekyGQPPdLpqWaUSa9Noo+0UXksC2EvOShpZja
         6pG1vvB+z7khHN5trEts4e05hbMOlLlEur30CwYTHkYXMkPnV7JjHTWewZf/LrOfZvpf
         x+439M+rrJ3r1p8eX29DbNQQpZOWX2ScML4YJLg0/X6sJgNXOqCszgptkN+6YJI/chis
         45D/SeOGjhF8FidZxK/iFDFr/9X7ox4w1s5LOvQTIGzzIIudnb2QpOX7X0EiFe/EKqsX
         g7gA==
X-Forwarded-Encrypted: i=1; AJvYcCXpey4UFS3BoMehTOl0tXtIJbHCQVeBfT/jrRkZ8izPyhmb9OU/hNc24oysj8a8THD5srSaO9KzyyMzVv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwceSkLl9+bo655DDR6Z9ztAWJWGb7Pjl5CVT2mhxcTQeDQqiZg
	C9iio/XIUG6aLzGvvdk9zGvcGhF2NrlCwRCExlJ7AF/6QlPJY9/ejeujvicUdxGZ4ef1wr/ryk4
	=
X-Google-Smtp-Source: AGHT+IE2HFwFcx+qYPVftgpCRRknWjlLHbqaYVcm679LojSp+LUrsSXd4rZJs5l99oFP8OTxrKIKSw==
X-Received: by 2002:a17:902:fc4e:b0:20c:9821:69a4 with SMTP id d9443c01a7336-210c6872726mr127498535ad.6.1730160598535;
        Mon, 28 Oct 2024 17:09:58 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:f1f8:97e1:9c5b:d66f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc02df82sm56278975ad.189.2024.10.28.17.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 17:09:58 -0700 (PDT)
Date: Tue, 29 Oct 2024 09:09:54 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Brian Geffon <bgeffon@google.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 2/2] zram: clear IDLE flag in mark_idle()
Message-ID: <20241029000954.GU1279924@google.com>
References: <20241028153629.1479791-1-senozhatsky@chromium.org>
 <20241028153629.1479791-3-senozhatsky@chromium.org>
 <Zx_QblcMMLznXd4P@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zx_QblcMMLznXd4P@google.com>

On (24/10/28 13:57), Brian Geffon wrote:
> On Tue, Oct 29, 2024 at 12:36:15AM +0900, Sergey Senozhatsky wrote:
> > If entry does not fulfill current mark_idle() parameters, e.g.
> > cutoff time, then we should clear its ZRAM_IDLE from previous
> > mark_idle() invocations.
> >
> > Consider the following case:
> > - mark_idle() cutoff time 8h
> > - mark_idle() cutoff time 4h
> > - writeback() idle - will writeback entries with cutoff time 8h,
> >   while it should only pick entries with cutoff time 4h
> >
> > The bug was reported by Shin Kawamura.
> Reported-by: Shin Kawamura <kawasin@google.com>

This is how it was in v1, but that triggered a warn

    WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
    #16:
    Reported-by: Shin Kawamura <kawasin@google.com>
    Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

so I switched to less "formal" reported-by tag in v2.

