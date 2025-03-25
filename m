Return-Path: <linux-kernel+bounces-575488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD578A70332
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 733BF189C7BB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88A6258CE2;
	Tue, 25 Mar 2025 14:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EvGg3EJm"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA762580D3
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 14:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742911313; cv=none; b=mcPtG7uht+Px9LJzONLhgh3XlkTK9N+A8LJDXOROuF0If2yzW+ZwZDa65z9xH0pIddHqFRy3SkwDYFNIdlFpBIrcGlbdKm9H1zNqDQXPSr94ijFK03S4uw+MC6UYXfhgxjO+stboYPabAemXpy2qKnIv2di9rLIeVt6TZ/B2I9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742911313; c=relaxed/simple;
	bh=psQr5bXaqv0tOjTaqj05BjvMiGbCZhFimnuoyPINOKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRhXScdRURNbb5K2wgHhNH6tAa+9pcG5yXvfP5P7W2r7eY1eIRyvYX6SCcuZSFHPu4qVhCKU119x/h/grDQbXWNSlOr1hCJhlqdRIkyB86i1Y5nwgWJF2P33+TimAkl6BuKVwqeWSNKAxB4m8Z6qB6rlkCcwGx6R5wTZw5L05+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EvGg3EJm; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so59519505e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 07:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742911309; x=1743516109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=46eT+Hy4Lu4vCxbnU4yufuUurX2jV0hosCGpG1W53Qg=;
        b=EvGg3EJmXanhdEc1eWjMde1MfqHwmBhC73pvSnp34hV/+BzgK2B//LJ+5cmoJi/rvW
         NbXWAVx5mYI8TFQlE9cgVSeA2tvSTpXO3V11cysJGaXLqGleW9NWwU7MSRDKhJP82WJc
         caZfwITpdi2UpNOY4Ul7TnrYq6xzpdXXZLCzBlFSpl32AdtiCjtbFm8MtnLGGXNlkyME
         jBz2MUuZr8lu624vPEa+0UhrJncORcEjp6H1Y8ABbQcYpTB8AcwNWTKeINfl4X09D5bw
         c5LKKKn6V1z9Gc+nw7I/JCRDAn8IQhhO22SOKQVyLcHL8Go0jieQkWos2Cy0E3AEcdGr
         KGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742911309; x=1743516109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46eT+Hy4Lu4vCxbnU4yufuUurX2jV0hosCGpG1W53Qg=;
        b=XrEOl47Op6fDYXzUkmObUGu7fVaCBbXnCZHw4KtSem1bRqqFtfRoa6jKIvu8bosGF4
         znwf4HGXOILuq90Q6e0GQ6eQhJX7YWWRnb8vK7yOtpA3DmZt/O6O6vFvst60Q2vrwbiD
         YbDjPopJYc74M2COFCiv3WY2aspRyc+zQlsfwcrDto0xTfvE3G2WxCf/4HBS5FxdiUER
         0Gf+BnR+4vbKrQW+gkmcJoyky+rlkip1pD8wey2oMbSEZQni9LuJQKQ5p1e8Hw11yIfx
         tSCXiw33GrTgZuF5O7+kQm0pveEpi5XbyN8pZNzgg1qypKmktg1UAT3v3SOFhl9nv7Qt
         7VLg==
X-Forwarded-Encrypted: i=1; AJvYcCUVeebMZO99crM8v43UjW+2ZqkzS/9V3mFwEyYe4W+kGggSxMIostSKmb3IfRpwubbEmiwCixk/YeL2pLc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz+uINnP9pR6ahKD57EwdpWIifXPhLajFW3YLtaVWFci49c3Mq
	zWAGiIg1R1jnp8HgvbKTzzpzp7230sv7hNhgRWKQPNVtpQtBxqOzdip08HKpq0w=
X-Gm-Gg: ASbGncvSkEKGdyXU5t18G2n4Ay0AH4SKuIgshidq6I5sg7aeqdRH0q/zA7v/xZA9Mp7
	XoBn4Nvqy4u4ZzfDTvQ2cIzC+gYWErfgoRxkaZatCBlupMv32GaWFg8Nwyci/LnHoziGK+uSvV3
	3l334wvgiUuOni48CnVvla+Od2/fZ807RXZKBTbNtuOrBJlblB/lxfXDqmbVZ8Kx1HPoFQm3gpi
	Lv0JB0fsh+M+N/vvo76OMmlaY0PhU2KZnoXnCG45I3lEILHTwGqWVKwI2J8qzX+qxyZsZGdvfZU
	1gnHGRjJFSpkOS8WlQzELiMz3lFLTKgqBVm0eqHSOLc6
X-Google-Smtp-Source: AGHT+IFlf0RRgubk2wvjrK6UsEWwmBIygf5+sWvt5dTqY3ym64zMC9BzC9I2GK0CiClG8ELDEGN4IA==
X-Received: by 2002:a05:600c:1e8d:b0:43d:4e9:27fe with SMTP id 5b1f17b1804b1-43d509e9ea2mr160093245e9.8.1742911309209;
        Tue, 25 Mar 2025 07:01:49 -0700 (PDT)
Received: from pathway.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9e65casm14025604f8f.69.2025.03.25.07.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 07:01:48 -0700 (PDT)
Date: Tue, 25 Mar 2025 15:01:47 +0100
From: Petr Mladek <pmladek@suse.com>
To: Filipe Xavier <felipeaggger@gmail.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, felipe_life@live.com
Subject: Re: [PATCH v3 0/2] selftests: livepatch: test if ftrace can trace a
 livepatched function
Message-ID: <Z-K3S4G5BtdP1Q-H@pathway.suse.cz>
References: <20250324-ftrace-sftest-livepatch-v3-0-d9d7cc386c75@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324-ftrace-sftest-livepatch-v3-0-d9d7cc386c75@gmail.com>

On Mon 2025-03-24 19:50:17, Filipe Xavier wrote:
> This patchset add ftrace helpers functions and
> add a new test makes sure that ftrace can trace
> a function that was introduced by a livepatch.
> 
> Signed-off-by: Filipe Xavier <felipeaggger@gmail.com>
> Acked-by: Miroslav Benes <mbenes@suse.cz>

JFYI, the patchset has been committed into livepatching.git,
branch for-6.15/ftrace-test.

I had a dilemma whether to push it for 6.15 or postpone it.
But it is a selftest and quite trivial. And it has been
reviewed by several people. And it seems to work well
so I think that we could push it for 6.15.

Best Regards,
Petr

