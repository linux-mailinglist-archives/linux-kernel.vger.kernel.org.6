Return-Path: <linux-kernel+bounces-169507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 478FA8BC9A6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DADDD1F22643
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 08:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD741422C9;
	Mon,  6 May 2024 08:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="E+Aqj4p4"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B01541C64
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 08:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714984650; cv=none; b=T39WbVgSukKCkp8sL9snqfWjx1njMQlmJSZMhKi+ptn2Eoq2Oe4soAgw2O//RTFFL0oFINkce8f6OO2+Fx1tGj6+iC5uYxza2zPHY/LmMFikejF//YBLch/x86xWtVoBm/oJqZ7BomSi8TB7/Uvx+ZT85CVdy+w10SkAdLCyfLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714984650; c=relaxed/simple;
	bh=WlmeKD9rl2Rp427dzQgV7vKcZv06lyOSKT16KjABjKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=go2cWMHrYUrWijPGE+MGZ1AN3ojCiP/tyPtolKZQ7KFhrpLAd0Tevo+w5Ebnkbid5s8aLzDiUIMA1YC2pEPDj4hBnfBDSj9+J7pBZIS6w7zADG+VrCy8WH63dB9TdslFu/ctdSSQll0eP9u25CCxnFMdC4RHqep3wbyZCFhu67c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E+Aqj4p4; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-34de61b7ca4so1167486f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 01:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1714984647; x=1715589447; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=afhrWXwI4RV8usxYlSerLXIupt6toB52OABQqb4bdK0=;
        b=E+Aqj4p4AcDCyHV4G7YXLKjEIaRQjxy8vzpRlJVhcgW4vqY0qvRzC1xRmvEywWbRyR
         nuW8/uGwx9v1u6cQzyepPyH1vPO2+YDwJCtb/zT0i6w+VM7ZKARKgJru2DN50mwJmTiE
         mP94DFbSUS/1afzpi2mcLqk0ZAAnkSdYJ2xE/hcX9JbCfeG7nvpCiZy4mgWTo7U+GrYl
         c8/BPCfmcTX7ZV6Q2TpJqXAIydAWzOAGLQCzuke1lIcByxdmyJtevnDgFzXq22UW7KwS
         4t397WKHbivCoufC1Ux3/fTNEf30zCrANFC8WDEfaV9C2TJh111Y6xJQK0cMWKh5/6s+
         crGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714984647; x=1715589447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=afhrWXwI4RV8usxYlSerLXIupt6toB52OABQqb4bdK0=;
        b=gnNHfCoHf1d0B1PFzV/mZ2N1WvQMobqmWZTrFUXCY8pSuOc3CAbrfVQboOuvhWKyAl
         tmnLwBz1H/X42+HmiOpQDo5+ZWFBTjiybO5gf0MdFii5/J8nh4yb5H55sGQOHb5NRdj8
         nXvHPZg/eTmmCDwrjzETPf40rOuPL7iS3xVIp7oPF6bPhD4GawoMyMBK0Vf4ps7CNnN9
         I/F9Bp3w3ZYEV3LajrBctgeNg1tmcfr0A+nbsMTpqByo33wI45KlLPxCVKFEamh8O9Uf
         eETFIoSsfuhpgf5F9hEf9G7F0TfFVQUdPTkqQctlQZqZGh8U6FHQnbRCA+pxJMBNyGwv
         oDLw==
X-Forwarded-Encrypted: i=1; AJvYcCW/EO4P9lUoI0g/yuMpwlwn1QWdo69Z9LkVUuTvXp57aJy4RY6aNugK/lToVpIcRx1l8HtoYTD1PzohLpUqmC289qEn6eZnP4NfIqZj
X-Gm-Message-State: AOJu0YyWnTgY5XN8kJsUnl47DBM65BYVxkZ6uHA5Il2NhLDgA1wKnPQy
	0QClXmgenebAqnBrgq+ld29TtQDPNk7DkS92CfqvmyRj9eStnfGQ9t6+ClQhbj0=
X-Google-Smtp-Source: AGHT+IGV8NrR7pgOjUZQNfQV/VQkt+YMsq9MKLFk0tHMnITV6dwBQ9RSo42mHsdUqLmW9e2Fm0P4hg==
X-Received: by 2002:adf:f3c9:0:b0:34f:4c0:83a4 with SMTP id g9-20020adff3c9000000b0034f04c083a4mr3257323wrp.40.1714984646741;
        Mon, 06 May 2024 01:37:26 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id n10-20020a5d67ca000000b0034dcc70929dsm10082148wrw.83.2024.05.06.01.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 01:37:26 -0700 (PDT)
Date: Mon, 6 May 2024 10:37:24 +0200
From: Petr Mladek <pmladek@suse.com>
To: zhang warden <zhangwarden@gmail.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, mbenes@suse.cz, jikos@kernel.org,
	joe.lawrence@redhat.com, live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] livepatch.h: Add comment to klp transition state
Message-ID: <ZjiWxNLI3yS9nFI1@pathway.suse.cz>
References: <20240429072628.23841-1-zhangwarden@gmail.com>
 <20240505210024.2veie34wkbwkqggl@treble>
 <F3E94528-EA85-4A15-8452-EA2DE20EEB88@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F3E94528-EA85-4A15-8452-EA2DE20EEB88@gmail.com>

On Mon 2024-05-06 10:04:26, zhang warden wrote:
> 
> 
> > On May 6, 2024, at 05:00, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> > 
> > On Mon, Apr 29, 2024 at 03:26:28PM +0800, zhangwarden@gmail.com wrote:
> >> From: Wardenjohn <zhangwarden@gmail.com>
> >> 
> >> livepatch.h use KLP_UNDEFINED\KLP_UNPATCHED\KLP_PATCHED for klp transition state.
> >> When livepatch is ready but idle, using KLP_UNDEFINED seems very confusing.
> >> In order not to introduce potential risks to kernel, just update comment
> >> to these state.
> >> ---
> >> include/linux/livepatch.h | 6 +++---
> >> 1 file changed, 3 insertions(+), 3 deletions(-)
> >> 
> >> diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
> >> index 9b9b38e89563..b6a214f2f8e3 100644
> >> --- a/include/linux/livepatch.h
> >> +++ b/include/linux/livepatch.h
> >> @@ -18,9 +18,9 @@
> >> #if IS_ENABLED(CONFIG_LIVEPATCH)
> >> 
> >> /* task patch states */
> >> -#define KLP_UNDEFINED -1
> >> -#define KLP_UNPATCHED  0
> >> -#define KLP_PATCHED  1
> >> +#define KLP_UNDEFINED -1 /* idle, no transition in progress */
> >> +#define KLP_UNPATCHED  0 /* transitioning to unpatched state */
> >> +#define KLP_PATCHED  1 /* transitioning to patched state */
> > 
> > Instead of the comments, how about we just rename them to
> > 
> >  KLP_TRANSITION_IDLE
> >  KLP_TRANSITION_UNPATCHED
> >  KLP_TRANSITION_PATCHED
> > 
> > which shouldn't break userspace AFAIK.

Great idea! It is better then nothing.

> Renaming them may be a better way as my previous patch. I would like to know why renaming KLP_*** into 
> KLP_TRANSITION_*** will not break userspace while 
> Renaming KLP_UNDEWFINED to KLP_IDLE would break the userspace.

As I already wrote in [1], both "task->patch_state == KLP_UNDEFINED"
and "KLP_IDLE" are misleading. They are not talking
about the state of the patch but about the state of the transition.

We could not rename the variables because it would break userspace.
But we could rename the state names at least.

[1] https://lore.kernel.org/r/Zg7EpZol5jB_gHH9@alley

Best Regards,
Petr

