Return-Path: <linux-kernel+bounces-557751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F94A5DD39
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1968E189873E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68E3243965;
	Wed, 12 Mar 2025 12:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZlxhnSb"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D0042A82
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 12:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741784387; cv=none; b=NUl+lm3cvNIPGZSPjMyuCXJD4G791/YtttIH5FZ1gtsqtbcIEDaW3BpvYX/k/FohVuT5muJIrPjXhfApFip+e8Lu1yVTURd3FWXOQzDWDgx+pymsuqUfWIgZW73P4LIcUmjyIx7tsdMLaw8Z3WUmUtvUZg3hd7Ud3Y6BnqRIKB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741784387; c=relaxed/simple;
	bh=s8sASPOMo47S253so280vz3MGuiVi9Z3hXJHZwVeryw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PyiDoYijPXbrEMqTMiIyA2N7rOoKh7p6kmaU4OvKvQsp1WP6ZDPk1RIvMJ6Ae7jQGFv1eT1fRfrmnuUjVzk6TZGdJEjU4FQVuTYkCOwTbE5xA+Qc83+oT96WfKB3VrC7Ellpa2ghVce8EAa96ro3q22ejx+82p/1R+751TybWl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZlxhnSb; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30c091b54aaso41956571fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 05:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741784383; x=1742389183; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fggELxQLCLR7eKf5JPdKHRjsa56C6Hwmky6kSd6ySn8=;
        b=ZZlxhnSbP4mAL3UMX3O5SE13wNMaRLbkLiO1Ds68yBPVP3u7/1RWEkhWNOVP6LnSFk
         FHqwuHKVetFhQgQi4hFm20TgdhqpCE/tIzkMOVKJwC2Lm3gRoyLAxbE2foXngBbbxHmw
         tTSevTI7AfsQyak+COqtOFmE7gWytUQDEiD3wfjmGbfjq06Kc83dtgqj/qLev8njpmh6
         JIa2UU03H6dN7NQGoz9xj88ic/gG4S/d9uegYuCCub2tmXAo2D89SCxkMU1hI7NvRHEe
         Bm2jHxGu90E0My8y8caORaafYXlws0UaSMxP8uHuEBZTeH3BIgDdmJZPhSOmRTUSI/mO
         U2EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741784383; x=1742389183;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fggELxQLCLR7eKf5JPdKHRjsa56C6Hwmky6kSd6ySn8=;
        b=Nl2jV5/MxutbtDcMVAfqOYwwtioh7ilNryAqLqQga97IPLqncmXm72wSW7c40X6NGf
         XYqz/353lxHdaSyKndFZAZmV8zC2SCO/amuS5oFgZz4dsAHcVafnKo5v2Kbry4JTkvCq
         7P6qYZMq1/CbDMUnz3P8AmE5ue/rKrTGjbi3acJ8FIaYWPBFM6H9lPMPXFfiTq7MiB2e
         NeWchyi/7c8QAsRaIBVvdSzilkNUjYxihIi5z9w6qABBL9J/cdDqo1nxK+Zg/oEzH9Cp
         2AQHYbL0bmik7+Wpsw82gitMxJRZ9Uv219hMZspIpL34GgTf0pHn9uU8+8TstgopE0uX
         YQeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRdjgdA0ukBgbQK3XgEa0ME/mgMEglwyCnIHu7JTjNsLq8gbiagDim2of2taTpJlbRJyiIjprubinXbGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFgWntYF1xBwyMh3uWJSLRNnJmcQGSHc7JZSEnGKcPFb4qigGA
	vI4fhxWe2u1HWX2WyuqU6sGTp+I+kcdi83WLOydJ4m4vxPGWxmlD
X-Gm-Gg: ASbGncvZpbHb+exKj/unzBDdPJO75dYand+THva6nsBpEtkm86DupnF1MVMJHwm3XKJ
	cPnDcwwJuiCOP6vQ9qbiQVP/UpX42qIwNxfGZVnUz3K4HkLY3zBAxyHbx9+ar4QC9rI8G1kY4At
	HKccL+oXsofJXoidBtsSr82Ur/U86RzD3Dj+MvbXp1uFwdEiA+ruQx5EAxUzzz7xCb9J1enGURT
	jYQO0/dcBk3pu56qN4tR8qUfXjOxQwi02OGdzRQvSne5vbyrxwlUcGk2VXi1CrixdIFlJ5T6wPj
	2dKZq5AcIGXJ0Hs/WkDyyGCr/38yFvpviMP+q/SmXVXvjJI=
X-Google-Smtp-Source: AGHT+IEyBPHGeACQEApQfi8+oQCGxoTXwlLbnBHsRBzsrMCG2vEyKvZtIi/gjtQmBXPP25F0ryjivg==
X-Received: by 2002:a2e:be08:0:b0:308:e803:1180 with SMTP id 38308e7fff4ca-30bf4632c5dmr71240791fa.31.1741784383276;
        Wed, 12 Mar 2025 05:59:43 -0700 (PDT)
Received: from grain.localdomain ([5.18.255.97])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30bfb9f900csm19410771fa.84.2025.03.12.05.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 05:59:42 -0700 (PDT)
Received: by grain.localdomain (Postfix, from userid 1000)
	id AB29E5A0044; Wed, 12 Mar 2025 15:59:41 +0300 (MSK)
Date: Wed, 12 Mar 2025 15:59:41 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Benjamin Segall <bsegall@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrey Vagin <avagin@openvz.org>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch V3 17/18] posix-timers: Provide a mechanism to allocate a
 given timer ID
Message-ID: <Z9GFPffpN81va8bl@grain>
References: <20250308155501.391430556@linutronix.de>
 <20250308155624.526740902@linutronix.de>
 <Z9CsstMf-EVZpsiH@pavilion.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z9CsstMf-EVZpsiH@pavilion.home>
User-Agent: Mutt/2.2.14 (2025-02-20)

On Tue, Mar 11, 2025 at 10:35:46PM +0100, Frederic Weisbecker wrote:
> Le Sat, Mar 08, 2025 at 05:48:47PM +0100, Thomas Gleixner a écrit :
> > @@ -364,6 +389,16 @@ static enum hrtimer_restart posix_timer_
> >  	return HRTIMER_NORESTART;
> >  }
> >  
> > +long posixtimer_create_prctl(unsigned long ctrl)
> > +{
> > +	if (ctrl > PR_TIMER_CREATE_RESTORE_IDS_ON)
> > +		return -EINVAL;
> > +
> > +	guard(spinlock_irq)(&current->sighand->siglock);
> > +	current->signal->timer_create_restore_ids = ctrl == PR_TIMER_CREATE_RESTORE_IDS_ON;
> 
> Is the locking necessary here? It's not used on the read side.
> It only makes sense if more flags are to be added later in struct signal and the
> fields write can race.

Actually this is a very subtle moment. The @timer_create_restore_ids is a bit field and
updating them without a lock already lead into hard to catch bugs in the past especially
when we have close bits members such as is_child_subreaper/has_child_subreaper near it.
I thought of fork(clone_vm) calls in multithreaded application where real_parent may
point into our task which is doing prctl but didn't find any problem so far (though
internal feeling says that this is not hot path call and better would be to keep Thomas'
original lock code :-). Anyway, seems to be safe without it.

	Cyrill

