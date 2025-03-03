Return-Path: <linux-kernel+bounces-541943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9B6A4C3A4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D47CC7A4E57
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66780204081;
	Mon,  3 Mar 2025 14:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ha3O32tB"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A1B12FF69
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 14:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741012891; cv=none; b=js9UBMre3zru/Dilk/zsqD4PFaQbWoEhxXDq5UDhygIIwKja2PHZrrCDjMOLjnnc9aGra6vH7dRKjnkI+xtqX7XNtyrpzB9WOkhmMfBnYILpg44eZ1Lw/Xcgox3FqQQyJiYs/WTs3XRKjIYWyA5IgaRcQNhB/WYcMnzk2YQqnTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741012891; c=relaxed/simple;
	bh=aZmT+dUE/4t2fCfe4CEiC1nAw0DRflyAxm6MpXTO0ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MmuUWRLWO45ayTrROfA28WpFrHYaAXyU6Gv4821z5ASJVuQOtWCykaKlwxJIWkCatm5lRHTp8DimOa/DiDGNb5d74qd85dPZ+6MS1JwKXE+XWSfL6LE+8+0dwGxqsh3HR+tZ88HkRPfVQJEbyULpyOGwi103mte2NHl/MMcXQZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ha3O32tB; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43ba8a87643so89205e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 06:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741012888; x=1741617688; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=egMLwgX+4g6rb8FbE3IRa+4Vm/5YU6NsfMcpKXEu4kE=;
        b=ha3O32tByjAP6sUYTd6Da16Z2i8XKcIE/e3hLjZ0bXcRxCdpYyDYHuZw7xpXwOEKiE
         dSvUwM+kcigXUx7Qq4xhOcafu8hWJSrrXx/DUnGLy2JmCWV4fN95i0cyVERxTFFc1ENW
         pUWWUlJXRIrgeXzf7W7RFSDnDChlIUwHNNZ3cjxrymW7iN4RE+o6N9sgjyubvsAIYMP+
         qOk1cE1av7v2tqvyzOQVXerFyheLaZADA5NQpP2JvFFuGivojkqY+560PijqOh0eNjEL
         m8chdCAHn1efVXKUNUArO3vmtIX22L/b/IQORIXG/5CWTLeGKLrKGsbWO1p8D85fP2+t
         oLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741012888; x=1741617688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=egMLwgX+4g6rb8FbE3IRa+4Vm/5YU6NsfMcpKXEu4kE=;
        b=AihhD66EcZx1A4mFOi5tYaobetuKqXVLdI6cybQypcrmAdKHp2dQb4vfM8jJwB0bmB
         JxzoAy7slZYD+tzfEYM5s4mP0Q+Ksj7PcUnpmo8c8gGLpupoa/RenAFb9A09Wgca0LdZ
         o4kDoGEPtKm/POwKiWO2Uo5dfu9j9EbcP4DJfLHrGmnM84CHBe3DDxNeuXfiDYi0BNuf
         dKpofNwypDii2ikLBtTOgoZeYJgR82cVjomTRTH86vgEB4tvFDrqj4Q8YX9kZEyDRx9k
         eldcJ/KMyooYkQWvdxgKo+pzfbTw5HBv9tNMp6QJ+FDvkeiSu2uOAtwAfnDyNkHwa27A
         Hjiw==
X-Forwarded-Encrypted: i=1; AJvYcCV1AOBwuJN7JO2uKaSejRogxuCxO0Lm4F9BDoktShBq7Aj5RNDEZHF2SAd9jLSTD7hEDQ2VHkN4f6XJyQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJa4Sdcc+REDtN3g53I37Pzw8DPQilCsZ+5P0lyHfNPOcIIlOM
	smoJbzF+e5vETzbCfPorTFFrPZD7MNk4ss/4zvwRfrVPsD+FSvsjKTMvBdZY4Q==
X-Gm-Gg: ASbGncuO9QyYPuKlXrikacM9N5bZ7mecK6uoLAf7zzkO9d3DLjoBZ9TpyQUSZ7b3KfW
	OqnPHZiUfmTTgKZt+MqUE8ABwTFBCHKyyRDBAhzSeMdjy0S+M/Lpio04sPvWHUDINCY0N7VPABO
	fAXOQ4aKpcZLrhthnQl8E7JWVohjSQUzq9jK1l8+BN/WwH2Cpae7A1Ah1hJXrkVK46SSJD+luvQ
	j2o/SFKm5qz/whwImCYkAx31Np124Lh+QaYmlHSHsjwE66iajmlpoP3omPIl0KF1SBZ/KjAA9l4
	F8lxptBOhB3NucM68msKjb7sB5MQTHP7MNIDkY8wPKBtvJb3VqCfle87aOFrQdS7DVqiQFlHCd4
	sPGdI
X-Google-Smtp-Source: AGHT+IHO1Nbn09jkVoFLLqMX4NW+BO4HfXiWVCPB/n7FFGm1eIqk2YrLtsq7xUv891hZ1z+4ZKSjVA==
X-Received: by 2002:a05:600c:4a19:b0:439:9434:1b6c with SMTP id 5b1f17b1804b1-43baff0940bmr2571725e9.3.1741012888246;
        Mon, 03 Mar 2025 06:41:28 -0800 (PST)
Received: from google.com (44.232.78.34.bc.googleusercontent.com. [34.78.232.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4844c2bsm14742014f8f.77.2025.03.03.06.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 06:41:27 -0800 (PST)
Date: Mon, 3 Mar 2025 14:41:23 +0000
From: Brendan Jackman <jackmanb@google.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] x86/cpu: Add facility to force-enable CPU caps
 and bugs
Message-ID: <Z8W_k8a04aSdO0B5@google.com>
References: <20241220-force-cpu-bug-v2-0-7dc71bce742a@google.com>
 <CA+i-1C2dB94t7nDEd-41MgLeHMYGN2oQJyQE8qnkcx+xYdHfpA@mail.gmail.com>
 <Z8GK10q_ouii0O5F@gmail.com>
 <Z8HkeZq1-Ij6MUZE@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8HkeZq1-Ij6MUZE@gmail.com>

On Fri, Feb 28, 2025 at 05:29:45PM +0100, Ingo Molnar wrote:
> * Ingo Molnar <mingo@kernel.org> wrote:
> > Integration with clearcpuid= is so much more generic than the original 
> > variant and reuses a lot of that logic, so that's a big plus.
> > 
> > I've applied it to the x86 tree under the tip:x86/cpu branch and if 
> > everything goes fine in testing it should hit v6.15 in a couple of 
> > weeks.

It seems you applied this version (v2) while there was actually a
review from Boris on this and it led to v3:

https://lore.kernel.org/linux-kernel/20250218-force-cpu-bug-v3-0-da3df43d1936@google.com/

This is weird, I can't see Boris' comments on Lore, even though they
are Cc'd to linux-kernel@vger.kernel.org. I think there was some
downtime on Lore recently, maybe they got lost?

> > One additional thing - which I'd suggest we make a 4th patch, because 
> > it affects the existing clearcpuid= behavior - is to extend 
> > set/clearcpuid= with a bit more boot time verbosity, right now it 
> > taints the kernel:
> > 
> >                                 /* empty-string, i.e., ""-defined feature flags */
> >                                 if (!x86_cap_flags[bit])
> >                                         pr_cont(" " X86_CAP_FMT_NUM, x86_cap_flag_num(bit));
> >                                 else
> >                                         pr_cont(" " X86_CAP_FMT, x86_cap_flag(bit));
> > 
> >                                 if (set)
> >                                         setup_force_cpu_cap(bit);
> >                                 else
> >                                         setup_clear_cpu_cap(bit);
> >                                 taint++;
> > 
> > 
> > I'd suggest we do what PeterZ suggested back in December: in addition 
> > to the tainting, also emit an informative pr_warn() for every CPU 
> > feature bit enabled/disabled over what was present, and maybe make a 
> > bit of a distinction between 'feature' and 'bug' feature bits.
> 
> Ie. what I mean is that at minimum upgrade the output from pr_info() to 
> pr_warn() - but maybe also make it clear in the output that the kernel 
> is tainted and things may break as a result of modifying the feature 
> bits.

Anyway, yep, I will send some upgrades to the logging, plus any diff
that got lost from v2 to v3 as a new series.

Thanks for taking a look!

