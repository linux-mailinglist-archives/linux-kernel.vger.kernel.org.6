Return-Path: <linux-kernel+bounces-276679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B1A9496F3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F5BF281BDD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C7651C3E;
	Tue,  6 Aug 2024 17:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="D5vUjobn"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACDE4AEF7
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 17:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722965719; cv=none; b=LPKXuk67OFHunnDkFmENkkvIpddZTEFD3uohaD9FEb5aXLfO/sTyowplSwvWLs6sb9Fk5YAPlXX6cjwiGBcN84+6o5smlItAJIO9+iwaRa2JhbbGKJQj37oTK4phh2LtKBL1DqOjxCp2o5ic1TFwUwfP8+oJg8knOP7bqP6fMyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722965719; c=relaxed/simple;
	bh=x/0Rwwf3sL6eObSWtVAHQl+6VPHDvR37Bio5ufX4WSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LPUmKAq4Ytb5w9vKRySOJOEQzjJhjCXZEqLzWRa9du62MnyPhyzgXmKSILdXxhk8WPIQwBapnKZPrzNhv71EVkJthLd3lyCq1pnI2mNaafCAovLUci9NaRcWYbAmFO03yX9x/0MFZkOr/dzWlb735f6qJN+aT31CofdJ9SWmNtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=D5vUjobn; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52ed741fe46so926199e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 10:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722965715; x=1723570515; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LIr81wLV478nMm5ZMAvtL7E7AQSHTILuqakDKpJspcY=;
        b=D5vUjobntbbqyzSwYa4BZEpM9440So8FKpoBTFoX+z8adANvzEhehbkkbJdiWS6/86
         BurJX/oXfS0lSfZ+LHhkj+Khiw0HFpX1vc/svnegr9AvhuGPc5hrZ3cNYxeE5qTimtY7
         eoURPZ6RhwJpJwm57mF6jlw94KmlZ1TtDUlt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722965715; x=1723570515;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LIr81wLV478nMm5ZMAvtL7E7AQSHTILuqakDKpJspcY=;
        b=TSc8RW+7XPiZgQlSkvqd+PMXO5Fdm6OVtveMwOaS7gsBblit1bfKNWftRaRjbQO5M5
         exKrXpV+70Py9u65MjwUm4c2BOLMURTrHtNBkbubiJRPRBpQzX8CEVvXTSMO/j3sa8Lr
         NDwD1Cy/WvAdcNW1KD03HyJ6AoM8PDLOxSxxHonx5XBOH0cls7k1ozB6yLL237Imsvsk
         lgpWtR/kafBduHxsFDZIZntLFAypHqnNZ0TJ4WKSY0qNwKMuxlG15QoPgJ7UgFYBe0cd
         iv874Y3e6kGUex8D1NHzFGQsjfFsoSZgwA1+pL6xUMfZbs4G2qmjOwDC0Os6ObCf6sT1
         qIyw==
X-Forwarded-Encrypted: i=1; AJvYcCW0Pz5871QQtrIIMSwoNdNssnf5Wd22F27b7x1mOj+udtfdkzsLt3by+OqmMV0NYAwxPwC/XWkUXCF7QtnsP61Y/8N86HskO86LFGmN
X-Gm-Message-State: AOJu0Yw9PKMlSLhdq7jsIGmm5SzQOMHqV8mX4uNlra+NlGBRqGfxopeV
	RkBEaWBosZc46bDDVztBxn/AUCmc/N12JCqDsoyJf95RVdZz+OznDk5yIdz2eRG9tkCTCgwy0Zm
	Oxurw9Q==
X-Google-Smtp-Source: AGHT+IGQM/p2mEV+5yk8+kR+5gMqzGk+6f7OiYdrfH4ltPwfGs1JQakrtuHGfo/g8VFq9B/+sYBzGw==
X-Received: by 2002:a05:6512:2249:b0:52e:9f6b:64 with SMTP id 2adb3069b0e04-530bb3b6fcemr9904363e87.34.1722965715169;
        Tue, 06 Aug 2024 10:35:15 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83b92cbccsm6131659a12.68.2024.08.06.10.35.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 10:35:14 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5a156556fb4so1044280a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 10:35:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWN0kH95K82UhHcyXiif5VLi9fK+Iew8pvzuv5b3IfD2yKIzAXun8dr73IUQN3u2FqefRV5GM2Xd5F2DRccitE2Z9cXzBhMA+gVPpLQ
X-Received: by 2002:a05:6402:129a:b0:57d:72e:5b3a with SMTP id
 4fb4d7f45d1cf-5b7f56fb7cbmr10460898a12.33.1722965714121; Tue, 06 Aug 2024
 10:35:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731095022.970699670@linuxfoundation.org> <718b8afe-222f-4b3a-96d3-93af0e4ceff1@roeck-us.net>
 <CAHk-=wiZ7WJQ1y=CwuMwqBxQYtaD8psq+Vxa3r1Z6_ftDZK+hA@mail.gmail.com>
 <53b2e1f2-4291-48e5-a668-7cf57d900ecd@suse.cz> <f63c6789-b01a-4d76-b7c9-74c04867bc13@roeck-us.net>
In-Reply-To: <f63c6789-b01a-4d76-b7c9-74c04867bc13@roeck-us.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 6 Aug 2024 10:34:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjmumbT73xLkSAnnxDwaFE__Ny=QCp6B_LE2aG1SUqiTg@mail.gmail.com>
Message-ID: <CAHk-=wjmumbT73xLkSAnnxDwaFE__Ny=QCp6B_LE2aG1SUqiTg@mail.gmail.com>
Subject: Re: [PATCH 6.10 000/809] 6.10.3-rc3 review
To: Guenter Roeck <linux@roeck-us.net>
Cc: Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org, 
	Linux-MM <linux-mm@kvack.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 Aug 2024 at 10:20, Guenter Roeck <linux@roeck-us.net> wrote:
>
> kmem_cache_node      197    210    192   21    1 : tunables    0    0    0 : slabdata     10     10      0
> kmem_cache           197    200    320   25    2 : tunables    0    0    0 : slabdata      8      8      0

Hmm. Do we have some alignment confusion?

The alignment rules for 192 are to align it to 64-byte boundaries
(because that's the largest power of two that divides it), and that
means it stays at 192, and that would give 21 objects per 4kB page.

But if we use the "align up to next power of two", you get 256 bytes,
and 16 objects per page.

And that 21-vs-16 confusion would seem to match this pretty well:

  [    0.000000] BUG kmem_cache_node (Not tainted): objects 21 > max 16

which makes me wonder...

            Linus

