Return-Path: <linux-kernel+bounces-296220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDAC95A7D6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 00:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 576FC1C21D36
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 22:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A76317C7B2;
	Wed, 21 Aug 2024 22:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YFgWLSgN"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B7817B402
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 22:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724279498; cv=none; b=dBnHZoSgZt/OViMb3zjQRfMZzZJyhAi6Tc1NvpAsvZZ+GDcxDeX0d8ku19MZrx6sZkvLrc5oZvLQsC80tWzrmiGSQXwdmGm2jBvHJRXGZQFKnus+xWOVaxgPlVGh7YgoPXAM3Khlva0ax8zjgV5raZUWPWK9yG28vubfPjQEjp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724279498; c=relaxed/simple;
	bh=VHnOsuLOHcS9aTUTjqS5wnlMuLfjvp7z8WRujcbjlB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GgLu3WwToy5MNNpACQt5ggNbDHnII0EgIfIDokjKsRaMAivVeR4fE1EgaUMVP2d131txriRTnYOR9s1xxgU+Luam+tt2Sburqw4lKZbmZBiVuzW2+lJFfym9o0EjrjK32SfdkYNCxKxqgkKsX7HuwAhmeTg+edsQ/YtNKFHkzBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YFgWLSgN; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5bec7d380caso276765a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 15:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724279494; x=1724884294; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K993JXtSvwBhw2YnjxICMfWixqNrlsGwD0szTRN/Zuo=;
        b=YFgWLSgN9Ik+5ObKfbVnpWNIsAwsnTliZUiaY5nFy4U6V2pggQCjTFWRF/S+K9S3FF
         V1iq0nWvWgE1NE8LJrn/oN4w8Vgvv81FgWZo8D4P1B9N1na9Cd4qgH/Cw5JW1+8AOnMm
         ey0550YBhs/Q8RxuzmfE2W+NyYMcrizDhp35W2prStWks7q6IK5aMM35PLfNIXiOctWd
         DsyeCiWbBXlFdFlCrpEL+M0VfIBiQlNXwFiz2WLeG47gGEt+659ZUNTktcpHMwzlxzec
         PKG1yS5Q4rvmsp2abmWV62C0TNW4v9c8sUirFEHBzX72mV0CamCe3SF/XltC3Yjb52gH
         ZbTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724279494; x=1724884294;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K993JXtSvwBhw2YnjxICMfWixqNrlsGwD0szTRN/Zuo=;
        b=nFnnCNiB1I9qxbsQGibaeD5wAjHM4P1EuQA1hRu9IQLkhsbNviJhix3iAQtPhzMCjw
         OzjOczK7UORxj2KDakWDAds8osW4VnbdJiIkowIHirh4wfg9g+Rb9QS4Z+9eu7Gdt4Nu
         E8H0svHHgQMQRyxO3CRrIDXP2jeYcEJ8Jq6nKehopoyXt5rt4MuxroW3GN3HhQweA/9l
         JeXURisR+DWuiiAywiBypjUwY5GszOba9HHRuxWqUsmX893w4dDyL2HKvG6RVdpTh4pJ
         zHoD9etI3ymRvKLb0NEWPb/s3RttoFt21JmYqHTqRibV4D9yrkEJGl5tnvob7WU0uJgk
         ZJKw==
X-Forwarded-Encrypted: i=1; AJvYcCWgZxj3RrVg9kGV3zdSoyqmLzMFOOqMb/mgQTZdfEZnh9O90jnP6JrHI1M8kAMDjJf/aniioY678Iq3C5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXvEn92CGvA3b9FWIRLbwiDE6spx/5ALujDqrlA4B1inRDW6gC
	jRwo+p00ohv23ORtTEf3dOfVWDHCKNBbNS9zCNqX8S921EB1wYE392GnvOWkofA=
X-Google-Smtp-Source: AGHT+IHII40SsgS0mAGZv50zy/g2ohtH8QY8JbeFhgeRBAL7t3qmvNAsi1roo+udoQmQ042mvB9qow==
X-Received: by 2002:a05:6402:528d:b0:5bf:d53:ba89 with SMTP id 4fb4d7f45d1cf-5bf1f155e01mr2255716a12.17.1724279493771;
        Wed, 21 Aug 2024 15:31:33 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c04a4c5999sm111612a12.64.2024.08.21.15.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 15:31:33 -0700 (PDT)
Date: Thu, 22 Aug 2024 01:31:26 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, Hao Ge <hao.ge@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	bpf <bpf@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, Hao Ge <gehao@kylinos.cn>
Subject: Re: [PATCH] selftests/bpf: Fix incorrect parameters in NULL pointer
 checking
Message-ID: <cc10c08a-a9aa-48e1-896f-46b566930271@stanley.mountain>
References: <20240820023447.29002-1-hao.ge@linux.dev>
 <02dd26b5-16a0-4732-80e4-c7bf183e965a@linux.dev>
 <58f57d70-a787-4012-8763-cc6eb642ef8a@stanley.mountain>
 <CAADnVQ+iTrTmbMcjt7fR7uTS=1tFcjv=z2CY6fO-4=kkM4YSMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+iTrTmbMcjt7fR7uTS=1tFcjv=z2CY6fO-4=kkM4YSMw@mail.gmail.com>

On Wed, Aug 21, 2024 at 03:07:27PM -0700, Alexei Starovoitov wrote:
> On Wed, Aug 21, 2024 at 2:50 PM Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >
> > On Wed, Aug 21, 2024 at 02:03:17PM -0700, Yonghong Song wrote:
> > >
> > > On 8/19/24 7:34 PM, Hao Ge wrote:
> > > > From: Hao Ge <gehao@kylinos.cn>
> > > >
> > > > Smatch reported the following warning:
> > > >      ./tools/testing/selftests/bpf/testing_helpers.c:455 get_xlated_program()
> > > >      warn: variable dereferenced before check 'buf' (see line 454)
> > > >
> > > > It seems correct,so let's modify it based on it's suggestion.
> > > >
> > > > Actually,commit b23ed4d74c4d ("selftests/bpf: Fix invalid pointer
> > > > check in get_xlated_program()") fixed an issue in the test_verifier.c
> > > > once,but it was reverted this time.
> > > >
> > > > Let's solve this issue with the minimal changes possible.
> > > >
> > > > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > > Closes: https://lore.kernel.org/all/1eb3732f-605a-479d-ba64-cd14250cbf91@stanley.mountain/
> > > > Fixes: b4b7a4099b8c ("selftests/bpf: Factor out get_xlated_program() helper")
> > > > Signed-off-by: Hao Ge <gehao@kylinos.cn>
> > >
> > > In the future, please change subject '[PATCH] ...' to '[PATCH bpf-next] ...'
> > > so CI can properly test it.
> >
> > It feels like there should be a technical solution to this.  The CI system is
> > something on AWS and it's too expensive to just check every patch that's sent to
> > the bpf list?  My understanding is that there are only two bpf trees.
> >
> >         if [ "$FIXES_HASH" == "" ] ; then
> >                 TREE=next
> >         elif git merge-base --is-ancestor $FIXES_HASH origin/master ; then
> >                 TREE=linus
> >         else
> >                 TREE=next
> >         fi
> >
> > These days the zero day bot people are checking around a thousand git trees.
> > They pull emails off the various lists and apply them to the right places.  It's
> > a doable thing.
> 
> Dan,
> 
> Various people pointed out that you need to use the proper subject in
> the patches.
> You clearly knew that rule and yet you ignored it,
> and worse still you keep coming up with these excuses.
> Don't be surprised that people who are supposed to review your patches
> will take a long time to reply or "forget" about them as you "forget"
> about patch submission rules.

You're emailing the wrong person.  This isn't my patch.  I don't send BPF
patches.

regards,
dan carpenter

