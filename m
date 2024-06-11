Return-Path: <linux-kernel+bounces-210617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57312904647
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 23:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8C291F228E5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 21:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF20E1527A2;
	Tue, 11 Jun 2024 21:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Cjuw4N80"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D71D1514F5
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 21:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718141738; cv=none; b=F4PFCbX5utolc7F/bHqbuTO5cN+GiU7LyWiYlJG7p2Wjy1pJz2yOiX8Vx+NCYfnW96uhEfKt5uHNDxVWP54h8GAtKVQHICSR/8HMzZMmc/WGyiBq5BluNzdPXde9Wv8Mig5Q6XQMxr8hhLbDsFzzS3SwdE+LWHw/44nanE9Or+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718141738; c=relaxed/simple;
	bh=1z7srA7osNJj1aYJV58/IFOWkAWvG4t7SgHfg4hwbX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V/10aJBMo4MLanFph22QilSWAyHFFLGSpXhSD6ldpSKog8uiEy85yKgXLcsRi+oAIaGeAwwvbrGe8ziU0lz2CKei3LcRjPKXh9buQA9m7nVIr95K0fkvr0gIYv6ePDflMUXMVH6MPQ6H8Nlcz5yquHLAbzJF+d1bJEm/B5O3wxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Cjuw4N80; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57a1fe6392eso9119223a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 14:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718141734; x=1718746534; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kgwu43FUzPY5K/8QMmjEzl3qbHR+MSkeROUYSgbHmjU=;
        b=Cjuw4N80Y6qECmwMkhDTNa6VFsqqf0yr5PbwTjQxBtSLkURnOFCfrB5I2TVBRMNFny
         E+VrXsrrcK8hQVpa6w+YRhBzQEEyeyI45wm2exFx6QGDBzg1mR7/y8VaZwUkG2uUPJBw
         GIdF+qLG6HVt2rA8+Klnxcw8i3z8hy0CdsnDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718141734; x=1718746534;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kgwu43FUzPY5K/8QMmjEzl3qbHR+MSkeROUYSgbHmjU=;
        b=qjKzst4+Wcrq6YS1jVmkVpldi/3YtazDl3jjpekkFIOp2xd2tiQ7v346ljUXr0y1lf
         t5tjHNlzOkPZOXfCa5//fuulqIAf81rTK5q2+ID6z/7BHNOYrJMG8DwWRRbtQHmcV0Lz
         QzlVUkzP8sOurFJmtZLCC2c53SiLBS22vVTxI8VhjcJbFWCs5SWWxglHbUkarAcIjKqY
         QHVo+nypJ61Q8JW5eAJU8OUFD8TAWLveOkeEPYpBvEklVoF36ULwftlU5aK478/1Kuka
         mV/94ga13txe/kyFj7g8m2AC6MKuEtjLe+Pl0+3MW8cgCi+6raI6aySg2aaiE1Ua8IST
         9M+w==
X-Forwarded-Encrypted: i=1; AJvYcCVa6ZpkoZUTfEPnXR/po6kRVCAwWKovxLnmvejUbiiRpT9VxYSDMUrToUl3sRj//5fXVeXuhtwmC6ZraBCuBZAURBFTo+Cw4Qd0JCFC
X-Gm-Message-State: AOJu0YyvgC+utRPaoBEaBFZJyKWy3qfh/ybOIN38u65kMd3d3qEDXFVR
	yTTfDDV8NhKKGdqXyJyK8TCDU8VaKZqK964vsq+iAU06PqIH1FPO/fdPTchZJxzoieTelMy5F6j
	DaMXfbg==
X-Google-Smtp-Source: AGHT+IGmPh7xuN1r64B7hq0KCYIDMTHdsUpTDM5bOWZmB/Yax7rHm5q46NmJviZ6AhU3I7mn8Zxtbg==
X-Received: by 2002:a17:906:4117:b0:a6e:ff47:e295 with SMTP id a640c23a62f3a-a6eff47e33fmr624224766b.35.1718141733854;
        Tue, 11 Jun 2024 14:35:33 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6efed85dc3sm508642266b.124.2024.06.11.14.35.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 14:35:33 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4217136a74dso36552325e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 14:35:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX4FQxYhbyO7eSeFfYdbZ7YiNIXY8MSfvSfh+Io6n64NwreLMEDev6OVqQO3HHeFqD8L9BBJdvGW6e5NgZEdtjxZKRNebGOlEZnn5OV
X-Received: by 2002:a17:906:191b:b0:a69:2288:41da with SMTP id
 a640c23a62f3a-a6cd6665bc9mr812670466b.30.1718141712971; Tue, 11 Jun 2024
 14:35:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501151312.635565-1-tj@kernel.org>
In-Reply-To: <20240501151312.635565-1-tj@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 11 Jun 2024 14:34:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg8APE61e5Ddq5mwH55Eh0ZLDV4Tr+c6_gFS7g2AxnuHQ@mail.gmail.com>
Message-ID: <CAHk-=wg8APE61e5Ddq5mwH55Eh0ZLDV4Tr+c6_gFS7g2AxnuHQ@mail.gmail.com>
Subject: Re: [PATCHSET v6] sched: Implement BPF extensible scheduler class
To: Tejun Heo <tj@kernel.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, joshdon@google.com, brho@google.com, pjt@google.com, 
	derkling@google.com, haoluo@google.com, dvernet@meta.com, 
	dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com, 
	changwoo@igalia.com, himadrics@inria.fr, memxor@gmail.com, 
	andrea.righi@canonical.com, joel@joelfernandes.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

[ Tejun reminded me about this, and discussion hasn't really gone
anywhere for much too long, so now I just need to be the person who
makes a decision and people can hate on ]

On Wed, 1 May 2024 at 08:13, Tejun Heo <tj@kernel.org> wrote:
>
> This is v6 of sched_ext (SCX) patchset.
>
> During the past five months, both the development and adoption of sched_ext
> have been progressing briskly. Here are some highlights around adoption:
[...]

I honestly see no reason to delay this any more. This whole patchset
was the major (private) discussion at last year's kernel maintainer
summit, and I don't find any value in having the same discussion
(whether off-list or as an actual event) at the upcoming maintainer
summit one year later, so to make any kind of sane progress, my
current plan is to merge this for 6.11.

At least that way, we're making progress, and the discussion at KS
2024 can be about my mental acuity - or lack thereof - rather than
about rehashing the same thing that clearly made no progress last
year.

I've never been a huge believer in trying to make everybody happy with
code that is out of tree - we're better off working together on it
in-tree.

And using the "in order to accept this, some other thing has to be
fixed first" argument doesn't really work well either (and _that_ has
been discussed for over a decade at various maintainer summits).

Maybe the people who have concerns about this can work on those
concerns when it's in-tree.

I'm also not a believer in the argument that has been used (multiple
times) that the BPF scheduler would keep people from participating in
scheduler development. I personally think the main thing that keeps
people from participating is too high barriers to participation.

Anyway, this is the heads-up to Tejun to please just send me a pull
request for the next merge window.

And for everybody else as a "It's happening" heads-up.

[ Please just mentally insert the "IT'S HAPPENING" meme gif here -
because if I actually were to include it here, lkml would just reject
this email. Sometimes the anti-html rules don't work in our favor ].

                Linus

