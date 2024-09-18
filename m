Return-Path: <linux-kernel+bounces-332324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0A597B853
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 09:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8BCB1F2234F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 07:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A1E15B54F;
	Wed, 18 Sep 2024 07:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bQAUxIzi"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8403113AA2D
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 07:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726643207; cv=none; b=BHPQGOXlUtGN4bWBvrWDDUDStSNACB0K7DHpz/tbd+lhdKi98C7LKBsC1MhHq3SKF5NDsvRpJPy9KR1RdBKy2WTP4EkNytLc00uqPGtJ+0O1nSQ0ySRVo0bsCAlImHdXIwdKyyDwsBdqE92hZ1MbtuLEjrbJ4Ec9Jn74e6UMe1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726643207; c=relaxed/simple;
	bh=SUCLPRdiDfQEebQzofMtI7RfAk0joQ7oLPvKtvGVbpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qPESTXubXuRlFkJwpHKXFA8rYrQeWmnwML41RdK9lKTjKs9BhPMvIQoVVLmDd1RBNrrGg59e6slDYX7/xtalc/q4AjQ+EixuuDEA9IwhvBFrfmvbE44lYsyxXtdH87SVoYzcdvAq9qdGcWQ3BraF8fBksIF14Ck6nRf8KHcH1GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bQAUxIzi; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53567b4c3f4so6353545e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 00:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726643203; x=1727248003; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VL5JF+54OUBRwP0OaibNmFvncta2Ria7W8uRTQUIHio=;
        b=bQAUxIzighouUv8+k3Ef+BTwAKr3/OXn9nxq4ieMZ4KWYhgKQiCNa0XR/lo6BehmeS
         0zTCPy4L/SQNR8rRkV/eyiNzo9h3I/GtwMgkSEC9CwPk/V++VcAGK8JV/edkAdCZ4k0t
         rpaKusd3c7IGVkRO1smMjQGeKl1fQWWxkZz2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726643203; x=1727248003;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VL5JF+54OUBRwP0OaibNmFvncta2Ria7W8uRTQUIHio=;
        b=wPRsU8fNvu0Wg5EBm2qEx2+RRYSdcfKd8I0AU0HgX1xv8KD5Ww91hKyEekrXwdEbxM
         +Pw0SgKLFBk+59yCT65Mr/1IMLHoGwTtaQXqc/samFLSAa+WzlWLmTceBPidcpaAWS5g
         TIFyebwN/RVJnmSyJWjD2zgtsKegues6WlHQ8BWktxjkhDOJa3+34amqRAuvax6wC/xr
         wKqKovtp4yAGkgR2P9I6u7FMWHDQu+gLw50SkaMT+Ije1EiiJ5p+5yqCkEQsjiDLCge7
         bWDJW2VPO8NlKrh6C8UsnTw5lxY5B4A5spGTgE1sjEjS6Zn3ZN9w1jbH5C6gkLbM0QRd
         7YXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUO/6vDDMLnYG117q7VN/27GU+U/hvHAUIDephnt6Cqj0gbFjVr4tVqzXylJEXioTKOH1MeilcMQ6L6Xhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZkgVZuc3TVeawmhYsDw+kr2k4nYIsbU95cTBB//yEpHRDM2NZ
	02qG2TbzRczicp4O+5CgWbmOgahIYVlo/pZQj69z06mPTxkTPleFXMR3C4gkd0/8T10CA+H4rmh
	bIoeUSg==
X-Google-Smtp-Source: AGHT+IFQ5E+kmGSznnB4NkJKobFiRzgo0mOHabIIb25qltHh/v87nY/0hQeFfn0StJdU6IRfrMnMzA==
X-Received: by 2002:a05:6512:238c:b0:536:53a9:96d5 with SMTP id 2adb3069b0e04-53678fbb32amr10397495e87.17.1726643203061;
        Wed, 18 Sep 2024 00:06:43 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-536870ada9fsm1444979e87.242.2024.09.18.00.06.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2024 00:06:41 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-536748c7e9aso7713895e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 00:06:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXljtDWAigBX+TNNH/O3gtFg9QkF6SyMivmyJvkMTFrhDxdCVGDwbopvNw9QgqcA3fQKpbQvePPuqGz4s8=@vger.kernel.org
X-Received: by 2002:a05:6512:2208:b0:535:6986:9810 with SMTP id
 2adb3069b0e04-53678feb164mr12882725e87.38.1726643199826; Wed, 18 Sep 2024
 00:06:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8d6c5d10-5750-4472-858c-eadc105453be@suse.cz>
In-Reply-To: <8d6c5d10-5750-4472-858c-eadc105453be@suse.cz>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 18 Sep 2024 09:06:23 +0200
X-Gmail-Original-Message-ID: <CAHk-=wjmu93njmUVqfkAbGKqHaOKFrTmgU2O=UkP3OOmpCjo4Q@mail.gmail.com>
Message-ID: <CAHk-=wjmu93njmUVqfkAbGKqHaOKFrTmgU2O=UkP3OOmpCjo4Q@mail.gmail.com>
Subject: Re: [GIT PULL] slab updates for 6.11
To: Vlastimil Babka <vbabka@suse.cz>
Cc: David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Christian Brauner <brauner@kernel.org>, RCU <rcu@vger.kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Sept 2024 at 11:45, Vlastimil Babka <vbabka@suse.cz> wrote:
>
> There's a small conflict with the rcu tree:
> https://lore.kernel.org/lkml/20240812124748.3725011b@canb.auug.org.au/

Hmm. The conflict resolution is trivial, but the code itself looks buggy.

Look here, commit 2b55d6a42d14 ("rcu/kvfree: Add kvfree_rcu_barrier()
API") makes kvfree_rcu_queue_batch() do this:

        bool queued = false;
        ...
        for (i = 0; i < KFREE_N_BATCHES; i++) {
                ...
                        queued = queue_rcu_work(system_wq, &krwp->rcu_work);
        ...
        return queued;

and note how that return value is completely nonsensical. It doesn't
imply anything got queued. It's returning whether the *last* call to
queue_rcu_work() resulted in queued work.

There is no way the return value is meaningful that I can see, and
honestly, that means that the code in kvfree_rcu_barrier() looks
actively buggy, and at worst might be an endless loop

Now, maybe there's some reason why the code works fine, but it looks
really really wrong. Please fix.

The fix might be either a big comment about why it's ok, or making the
"queued" assignment be a '|=' instead, or perhaps breaking out of the
loop on the first successful queueing, or whatever.

But not this "randomly return _one_ value of many of the queuing success".

I've merged this, but I expect this to be fixed.

                  Linus

