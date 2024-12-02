Return-Path: <linux-kernel+bounces-426888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEA79DF9CD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 05:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C7BDB2148F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 04:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16D6EC4;
	Mon,  2 Dec 2024 04:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KCwUc3i0"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B538438DE9
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 04:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733112637; cv=none; b=L02+bmI5W6jXO0syC/y7ac6KtHnLfuHEYBuX3y6bsjPBGNNKlAZ0o6fiX5USLQvlS1IC4HrROE1gn/mVeGFN+i7+DkjqgzlHaX//qecBAi0flDYhzd9iXgf60pspngExeJtm5ck6KyAYoh8esoQ25OA/TvYJjox3x0JkM/P4Eyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733112637; c=relaxed/simple;
	bh=vMWGWHg/et5CqkIdQLtUU5ObJLzO5NosJVeARTBqbag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uttmwql98aXrGkBmmk5xiCzc23GW1dJBlHx75q9s1HpveReL1uOUO1J6A5Ld/0NuETFb4v0aeW6zDu7pNDgXYsDLcahr8ESPszdsAm+C6B87azn/MGTS3a7qL9TUnYRokJ4vGR6GR7tPklexG7cZdU1aiarTGVSbvrjfnfdIgGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KCwUc3i0; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21288402a26so26659225ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 20:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733112635; x=1733717435; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=76F7lD0eouVg6d3auGQDcfuDktfWQWRUnQNVSJA2ubk=;
        b=KCwUc3i03mNYEK0a5dofjhlYqiVD5sd7+Mqn7AgpUcETYbTWRo7SOsSXUKKxfxx7UJ
         SHyJWF5FvA1vjn7+utOgL9vrKI/9ue+EpkmWsAJ6DA/iGHXGXWfqb0Vp6Aw3tOxcccsi
         lO6o/Y+KgpI184wI77H8nvGxk6ukX6XHInVyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733112635; x=1733717435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76F7lD0eouVg6d3auGQDcfuDktfWQWRUnQNVSJA2ubk=;
        b=vl0k6N0xeVDfPTbO7qIcQKjAfsFHxQXBv2HOQWhWUHvmPZuUTzS9gYnA2sn62UUHH9
         5xhuo/eq+47MNkO332kRG31LbUz1ysfCSfCcrzkvnS/E8mHooGqdSdE4uP+b9vnGMP/l
         iL9cP3RLfDGKW+9JWQBHNVdSgGbUJ6pLfkVJxCnxxjywkgKq6t3hZ+VbExU4o0YfrTwF
         a/S65d/v4ula+iVlUWS7SKnw7+qmZxQZL3SqDI9ZdxMr3DyN5sLSI2TF7FTmG49pvd9+
         B3tnwyR3SQEefngZlmPb+qpkB3EJlBM2Np3tqeU6S0IuqKmrchek5vZCyQuHXbf0Tef6
         PDmA==
X-Forwarded-Encrypted: i=1; AJvYcCV7oPH2ZTsQrGKdWOUy6G7RL7wUHn0xbYAmTpCKP4rgtF2Y/W125oQuS3EnOhqmqfbUoSR+byljNx8kMQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfMIh40TTD7xIodUc+NEtSgt9T1+w2pgrJQUcsnLQ+iwB3XZtm
	jEnRanMj0z8PTwvUDJIYbCteV49y2GnEXpT78DwHkZTLgBZLNB9sDQdvueuEiw==
X-Gm-Gg: ASbGnctonr2XgNf2PmPkwQOY+zcuv8+WMYLsi8CehV/ErqN+p6GGC1P0KZbvs/LaJd+
	gStFV1PFSituKyOp5NK3DJcCz8SXbEL+8AUqo141XKu28muDSrbxwb4YO83WFIXBVa3Xl+2hqwI
	JmQ13AYk3ncMEpvdfWsprRBJ3lqOOPYRhxCK4I4LtYwIZm7fKkBNsCebYwNK/bCnBN5lorHXDE8
	ztDxTfUc20fvNPBbns62RUMYLuaE7tJVAdPkkCODioCHsjLe1d8qQ==
X-Google-Smtp-Source: AGHT+IE880m9aaD/PfpcfjpV+6a29yccMszSLvtOM5pzxyZnHHZv7iq/hZ128/DKx4K03e9uIlt/rQ==
X-Received: by 2002:a17:902:ce08:b0:20c:da66:3875 with SMTP id d9443c01a7336-2150175eb06mr346021735ad.24.1733112635088;
        Sun, 01 Dec 2024 20:10:35 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:13dd:b39d:c5ab:31c2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21521905f2bsm67078175ad.93.2024.12.01.20.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 20:10:34 -0800 (PST)
Date: Mon, 2 Dec 2024 13:10:28 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	20241015061522.25288-1-rui.zhang@intel.com,
	Zhang Rui <rui.zhang@intel.com>, hpa@zytor.com,
	peterz@infradead.org, thorsten.blum@toblux.com,
	yuntao.wang@linux.dev, tony.luck@intel.com, len.brown@intel.com,
	srinivas.pandruvada@intel.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, rafael.j.wysocki@intel.com,
	x86@kernel.org, linux-pm@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH] modpost: Add .irqentry.text to OTHER_SECTIONS
Message-ID: <20241202041028.GJ10431@google.com>
References: <20241128111844.GE10431@google.com>
 <87o71xvuf3.ffs@tglx>
 <20241130114549.GI10431@google.com>
 <87iks3wt2t.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87iks3wt2t.ffs@tglx>

On (24/12/01 12:17), Thomas Gleixner wrote:
> The compiler can fully inline the actual handler function of an interrupt
> entry into the .irqentry.text entry point. If such a function contains an
> access which has an exception table entry, modpost complains about a
> section mismatch:
> 
>   WARNING: vmlinux.o(__ex_table+0x447c): Section mismatch in reference ...
> 
>   The relocation at __ex_table+0x447c references section ".irqentry.text"
>   which is not in the list of authorized sections.
> 
> Add .irqentry.text to OTHER_SECTIONS to cure the issue.

This works.  In fact, this looks like a local fix which we applied
here on our side, but we were very unsure.  Thank you Thomas.

