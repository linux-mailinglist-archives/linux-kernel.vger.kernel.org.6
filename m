Return-Path: <linux-kernel+bounces-571540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3C3A6BE93
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A885A189CCF0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C348225387;
	Fri, 21 Mar 2025 15:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="g3PZRZKt"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0A3223703
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 15:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742571976; cv=none; b=hl4wVtieLO9XIbB5fSF2v7TLhn4qv53ag6Vt9uJhSoucJoMfePPtgw8GQNStfH16yzl1xS95HozRrZ/2RwmUE7TAqCYjLLVFOiNf03SBRcdf+VouBN/nDGXvCpAYfiNI8cuXxKI+FUGmdKJY5J8h8IEX01SEd+EwzWCZZp/i+YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742571976; c=relaxed/simple;
	bh=PMbFL9w/T16MY1wFXjhG084gr8a/ScmrDwtmwbvle1E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R2OCt30J91rHIdShNuFZ4bCQF9WQsUL8j2iDdxeAlgjpB8pib/oDZj039/YixtDuwpboSD7j/gE/8MQorahqmXHyd0yJCliRr6vgcO++G4L/0Rgkqclho/egB8GeA50faPMfC9Oj/QS/UY3Em5+9186FQ78wOGdTNQKZhLLwkus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=g3PZRZKt; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cf257158fso15183265e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 08:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742571972; x=1743176772; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sxyu4837xaBsPKdh19s14kC1VMDWEUK2aQpdlRhN9bY=;
        b=g3PZRZKtbxVmKNgoIVKCKQlYd3dc/BQUjzMhLOluavCUvyPAA5aFOuRHPhjUZYyp91
         XFtcGrP4lVlpDLsKcdEhBjPaK0u/BfcbZnWzISxrEpKiZiVmTBzoNOGTYk/mt0ltYDJN
         lL6qaurBVST+jG89DE6whDaaM0KX6sZEfv0cpwvIbiUr7KUwlAz/w/zBeYmhPkOvzutU
         BVm0ncggMPy9bUWidEoh4EZJavq64Rkr1/KfvZmsYUODKmZbJctSbIiuWc4LHzxl+qN3
         bkkz4BisudiDUknOjQr4H03nfVw16y7U8WlgWf1wBCbzaPjIsXuZlfEcnf9J6lEeat7n
         f/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742571972; x=1743176772;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sxyu4837xaBsPKdh19s14kC1VMDWEUK2aQpdlRhN9bY=;
        b=wSuC/F3SOSBSAPsNgtJRWtoO07w5TTZANZbxWBGCMFulc5QZfqs186T/4r5l9JHmgY
         Svhmx/ejLmiD2cgKRGTTPXcF7bkz5oq1eIvI27MT29X7o2U1nViQVxsNQm30g+wsyrYK
         hfW0kPHeez0wAd6FcLajkA48fNJgko9oyXFR0NqDGsItvwrIkzgjL6BEYQW2o0lk16ON
         BXzmJATyvNSUDdYLa7pHXiXPTtdpsFBxiRJ/GWbWwQp3f0DUd7BoFk4QApN2Jt7XqrCB
         fSmc+i51XEfkDOgXEqiNS9BaUlizNw8Y7cpZ7JxMJgQr9G4lCnPpmJbV0RAWWtgnCOlw
         imdg==
X-Forwarded-Encrypted: i=1; AJvYcCUQsq/Grt8meel4W6s9gicgZAtxGyjrS2vS3sF8/D0VZltCC09zwU0jnRqZY4kCP6xnmiBH8A7gYxa1cQs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu/2z037ciCITXM1LtKKfIx7pfYuialMowzS/rUAE28EZRbhCp
	FNX1mwDcEWLRHaEdVOCrw/DG78GGaDPsCyXsKqtWB3v+6KK+PEP05hw4DswfMaE=
X-Gm-Gg: ASbGnct7gDcAHsUFgtx/RwYj4ztv5RARX5hN1znmdbpbAuSc7Prbdu25aX0kctCJ387
	k9RAOqwRHIiGqYarLgO7Ljjg4Zw6Ayi3xkkDPETqofDcr0FJe8AC+BIe0bh5oeHSPyyplIFUyRh
	JHLN/xCmmI+v9wl7sWzEFqX7Nf5s9/MzxVKCQ8RBe9NZRejb+AIKF8RIQM8qsz/Z4uD81caF3+8
	aXkLqVmxlexf/ZBAdUw4Oyp4gPio658/mKOC4sBrUSe/zlN8AEHSEu0EBaDmt5ua0yr0fAXVxVO
	odYnGI/e6UgR6u3pC8FmmROH3V5bLJO4MONX8qwYCJhu
X-Google-Smtp-Source: AGHT+IHA8cRGoAIkPVPFNmZnRzpsn7R6Bm6hI1qPItBl8eiyD+ALObZwrN5Smom3mHRzHmPrld4JMw==
X-Received: by 2002:a05:600c:1992:b0:43c:f332:703a with SMTP id 5b1f17b1804b1-43d50a553f2mr30247065e9.31.1742571971921;
        Fri, 21 Mar 2025 08:46:11 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:2102:ce42:30c0:9b40])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d4fd9e96bsm30814545e9.25.2025.03.21.08.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 08:46:11 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Kevin Hilman <khilman@baylibre.com>,  Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>,  Michael Turquette
 <mturquette@baylibre.com>,  Neil Armstrong <neil.armstrong@linaro.org>,
  linux-clk@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-amlogic@lists.infradead.org,  linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] clk: amlogic: drop clk_regmap tables
In-Reply-To: <5109de7fe1a1a8467118daf80c7b7f8a.sboyd@kernel.org> (Stephen
	Boyd's message of "Thu, 27 Feb 2025 14:55:00 -0800")
References: <20241220-amlogic-clk-drop-clk-regmap-tables-v1-0-96dd657cbfbd@baylibre.com>
	<20241220-amlogic-clk-drop-clk-regmap-tables-v1-2-96dd657cbfbd@baylibre.com>
	<9f1d69ebe1ddce5dfc170e986c9213f2.sboyd@kernel.org>
	<1ja5cp8f87.fsf@starbuckisacylon.baylibre.com>
	<88fe909ab182d1f17f6ef18161c7f064.sboyd@kernel.org>
	<1jfrlwb69r.fsf@starbuckisacylon.baylibre.com>
	<ed20c67e7d1a91d7fd8b921f156f56fb.sboyd@kernel.org>
	<1jmsg2adgu.fsf@starbuckisacylon.baylibre.com>
	<697b634770d789ef8ff0e05cec9465f5.sboyd@kernel.org>
	<1j4j205ark.fsf@starbuckisacylon.baylibre.com>
	<5109de7fe1a1a8467118daf80c7b7f8a.sboyd@kernel.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Fri, 21 Mar 2025 16:46:10 +0100
Message-ID: <1j7c4i2xq5.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu 27 Feb 2025 at 14:55, Stephen Boyd <sboyd@kernel.org> wrote:

> Quoting Jerome Brunet (2025-01-15 07:58:55)
>> 
>> I'd like to register controller init hook to apply on all the clocks of
>> a particular type. The reason to do that is to drop the big clk_regmap
>> table that are a pain to maintain (in addition to be ugly). I hoped it
>> would also save a bit of memory.
>> 
>> The solutions we've been discussing so far feels like we are moving
>> around the problem, recreating the memory saved somewhere else,
>> perhaps in a more complicated way. I'd like to find something more
>> convinient to use, which does not scale the memory used with the number
>> of clock registered. The point is not a different hook for clk_hw after
>> all.
>
> What are the goals?
>
>  1. Drop clk_regmap table

That my first goal

>  2. Reduce memory

Would be nice

>  3. ??
>
>> 
>> Here is an idea, how about list of hook identified by ops and controller ?
>> 
>> The node would look like this
>> 
>> struct clk_type_init_node {
>>        struct list_head         entry;
>>        
>>        struct device_node       *of_node;
>>        struct device            *dev;
>>        const struct clk_ops     *ops;
>> 
>>        int (*init_hook)(struct clk_hw *hw);
>> };
>> 
>> The change would be minimal in core CCF, just searching the list for a
>> match in clk_register. On most platform the list would be empty so there
>> is virtually no penalty when it is not used.
>> 
>> From the controller, the usage would be very simple, just calling a
>> function before registering the clocks, something like:
>> 
>> int clk_type_register_dev_hook(struct device *dev,
>>                                const struct clk_ops *ops,
>>                                int (*init_hook)(struct clk_hw *hw))
>> 
>> or the 'of_node' equivalent.
>
> Why can't we register the clk at the same time? I don't understand why
> we want to search a list to match something up to what could be another
> argument to the clk registration API. Isn't this the same as 
>
>  clk_hw_register_data(struct device *dev, struct clk_hw *hw, const struct clk_register_data *data)
>
> Why is that hard to maintain? Is that because the clk driver is
> registering various different types of clks and it wants to do different
> stuff depending on the type of clk?

Exactly

> Why wouldn't wrapping the clk_ops
> in another struct and then using container_of to find the custom clk_ops
> not work there?

For this particular problem, it still does not scale well. There is more
than 20 different ops (and counting) for that clock type. Those would
need to be duplicated for each different way to get the regmap. That's
really not ideal

Side note: That's very interesting idea for another topic I'd like
address someday - not having all clock as global, but the just static data.
That would be a nice way to attach an allocator.

>
>> 
>> I admit this is heavily inspired by how devres works :) but it does solve
>> the early clock controller problem and does not scale with the number of
>> clock registered.
>> 
>
> I don't know if devres is a good model. It's about tracking allocations
> and things to undo later, not really to track things to do when called
> initially.

My point was more the decoupling it allows.
Maybe it is me being too picky, but what I'm trying to do is related to the
clock type, so it bothers me when it scales with the number of instances
instead of the type.

More generally, something devres-like allows to register an attribute
and link it to a group. Then the group members come and just pick what
they need. Whatever manages the attribute does not have to track
them. That is pretty much aligned with what I'm trying to do.

-- 
Jerome

