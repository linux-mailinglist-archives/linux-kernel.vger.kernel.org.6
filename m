Return-Path: <linux-kernel+bounces-349066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2CA98F054
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 15:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92C1C1F22557
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 13:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C491993B0;
	Thu,  3 Oct 2024 13:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HmqNBzo4"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB83019AD93
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 13:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727961994; cv=none; b=QO8PI3iYBIsFkS2xENyXtp/VjHjt8sDU1C40TKNVClIXCbh6S96/6MwkjD/6U75otxqhynFK1+4i3h4MsXGiw+YfjNkoSBIHMJxKrstLdLTH35KjdngZmYZGaS1vqpwqf2U/8Nvmu17gpIqcQhifDG3r4ZCYdZE+efE/6cfm2K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727961994; c=relaxed/simple;
	bh=nA5GaEVYUUBd8/aiOT71SDIgFDlOb5sinMexac6lqHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=corjxNj4S36ZK9COj+T1BxEOJVYubltUBGiUSpTjISUHEg+fPRHK1BsimYmcHTu1Sa/YA9erQn1KQ04z0CSoxHIEaLDhaF6awXZeLlRxwXUdbYXyzxncilnyLhGSce+T/R07GEsAmB19UomOrmo0UQjDH6SGaO6rmS1aJakBDqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HmqNBzo4; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7db908c9c83so549887a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 06:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727961990; x=1728566790; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R0z1IutvGWteEcw8avXeUQEdQgn8W2z4Ae9xOQ0YGWU=;
        b=HmqNBzo4HMcrFijh1ubNTfQCRN8zlu34vWhw9paU/SDo6GN+36vybYhIZiWMc5RH0P
         V/9PI6gQlW5CoO4mK629taVxIpfL8eqTQbNxeUjoVaQgDnZtM+qlUtEPVljCgRrCXNuQ
         /9W4AjtH7xNtk4VcplP7V1g8hICPUN81kzGqNlyER6+lgtI8BjEZJ9Gd5a3mnAZKqlvJ
         GS8Gitw+tAT9hFHzvDgdwSBWC8AyiN6NdwzAoHa9R9mAf8bebPREfBskmi7L4KGWVn6d
         4H/hx/kXQXKA/Lm8ZH+wTytJi1dv/FmSOlu7fMkuGnwFMSrBVAy7nNNGcaTNwsDjDdpG
         9Btg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727961990; x=1728566790;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R0z1IutvGWteEcw8avXeUQEdQgn8W2z4Ae9xOQ0YGWU=;
        b=LCw48TqOFqB5gjjIQ8ybatUQnI0IbDyn9r3SPQqasKnrRkXj/RJ0MpxqZWd4Oz/6g8
         3p0phfLmOP6A3yaNHlKcNrAyOi4DXQMDxsXEL4LIsBLF/+ilvHnGDqecziDEc2sj+xK+
         zW71jskb876nC2T+rWIuc6Zky7JdN7ltWETWLXY6nOztjN3cNUhqecK0zVKaJTRw+wOf
         0vtCznWtDcI+eDPb+xgaEae6pKyovuBHlllrh97TxWq/myDksI4tJjMyqtgv947379rw
         p6DoWD5cOvE33FizeXdCRjKpI0pCpqI+IgxTlkjax1VLQpbd/2DmB190RzatR3hMynVh
         bDXA==
X-Forwarded-Encrypted: i=1; AJvYcCVkyqH2OXeZRDNRSenCbYnuHTHy5kVCX2U+vkb06EvPzlTZYDLNWsxmhXjITrRc/H8nOruV3t/KS3Ukm2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU+mBEhLX8s4nEyb5KUpHayR8/oP5lZXexfCbmbZeLwiveaRFa
	p2aUufHTJ8b/Q7IGUl6ah3T/d4OaWc3tcEoIoZZ4dt9gK4IHEItG52gLr7RD0Bee6hV0K/YQgia
	DrHGWPgU/cj6nBeSTQgCwwZvci6WzsaVGvFt+Yw==
X-Google-Smtp-Source: AGHT+IHhmWlf8n4E/ZhvKBnPWnKjZMHmmKFZNTnNy9JwQL7li6RKiQzkhZb/P3LutOAyMzfa2hDpafc+FxEj6pcnTMQ=
X-Received: by 2002:a17:90a:ac16:b0:2e0:9147:7db5 with SMTP id
 98e67ed59e1d1-2e18496cc2fmr7831264a91.38.1727961989946; Thu, 03 Oct 2024
 06:26:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830130309.2141697-1-vincent.guittot@linaro.org>
 <20240830130309.2141697-5-vincent.guittot@linaro.org> <Zu2gHOv7mqArWXLZ@google.com>
 <CAKfTPtCvwPq+8pQcTZePiee9EXxKAQS=J57X2OavWFrQwkDt5A@mail.gmail.com>
 <ZvUlB8s-zIkDQji7@google.com> <CAKfTPtAzG7u0+e=8skMhnCETVxbDTOxT-zLaoqUXB-Zz5=4t+A@mail.gmail.com>
 <Zvw2O4JGBpMXwOZA@google.com> <CAKfTPtDOhNmL0Nn3g-agnL5HH5nhwXb3-sfzydEe4nvRKAq3HQ@mail.gmail.com>
 <Zv5UDufqpoXvSocy@google.com> <CAKfTPtAmgi0QbtjqjJ_mzq6qat8ivd3vXXNYMiniDeKvLwujDQ@mail.gmail.com>
 <Zv5pSdRsSsfRSNsJ@google.com>
In-Reply-To: <Zv5pSdRsSsfRSNsJ@google.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 3 Oct 2024 15:26:17 +0200
Message-ID: <CAKfTPtARhtaN=ApYzkYucGp06Gb-m260gKG9hVLkE7BJSVQvQg@mail.gmail.com>
Subject: Re: [RFC PATCH 4/5] sched/fair: Use EAS also when overutilized
To: Quentin Perret <qperret@google.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, lukasz.luba@arm.com, 
	rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, qyousef@layalina.io, 
	hongyan.xia2@arm.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Oct 2024 at 11:52, Quentin Perret <qperret@google.com> wrote:
>
> On Thursday 03 Oct 2024 at 10:57:55 (+0200), Vincent Guittot wrote:
> > The current pelt algorithm track actual cpu utilization and can go
> > above cpu capacity (but not above 1024) so a  task utilization can
> > become bigger than a little cpu capacity
>
> Right, the time invariance thing. So yes, I still think that a mix of
> co-scheduling and task migrations (which is likely common in the
> overcommitted state) will cause some CPUs to appear lightly utilized at
> least transiently, hence tricking feec() into thinking it can help when
> it really can't.
>
> > As replied to Lukasz, if you want to discard utilization of a trask
> > you need to check the previous cpu
>
> Please help me out here because I'm still not quite sure what we're
> talking about. Could you please expand a bit?

If you consider that utilization of a task is meaningless because of
CPU overcommitment then you need to check if the prev cpu of the
waking task is/was overcommitted or not the last time the task run in
addition to the overcommitment of the next cpu

>
> Thanks,
> Quentin

