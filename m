Return-Path: <linux-kernel+bounces-315533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E219F96C3DE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 201E11C21B97
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0FF1DC184;
	Wed,  4 Sep 2024 16:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k3sOJvwS"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17521DB55E
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 16:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725466696; cv=none; b=Yn1Qoy5mZVK+4cHxL+f7pKzZ9RCakg37G1EMU6n7JqGFusJlK22VH4kG7sKu/9zAZ8rqnI7iAlsst32NpXtwWsXssDIHEonfxIdYLjC1YLVYZYznZgjieINjXYtoKPUqSet64fC+hLNz9zSQCdz81iDpnYVgm6/nTSvz5ftZLcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725466696; c=relaxed/simple;
	bh=YjgeBQx1vUvZtzHDl8kC+TeEaUMQNUyI2Gymk2f+KpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JDYKdd6Ig8mRIUX7R1HyEDaORhQmWwWdHVCBYDyav44cd95zxhfaY6+oRMJMkHeF5YRvZkKoPgsgDihoZXrdQkRqLRSd2RcehMtyLI653WmLQjmw+frNg5a7tJlybaecgf+u5kmnHPP8IQncRuf/cU+fDNA3aLGtaEhcijeu25o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k3sOJvwS; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-457c6389a3aso293371cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 09:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725466693; x=1726071493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7WeGJH80bEcJ0365jFT2qsdMy+ow6oBRUAZDQ7XPYag=;
        b=k3sOJvwSNyoqmFwZ6KJRNdTmx949ghUrk9dS1AG+zMsKpggyVE6HCiEGVnfcnuOaLf
         TkTEqf4cP91N2+cwvraWDxvFooC8ww4Xx19BGERVltESfC9wbbUwKX8hym1OaKgo3LV+
         qjRaQssYgpRRg6rX88KVhGwY7Mwb4lAOMEG7/yIwW4VvUXGyb6y46lpZF/0K/qHRYOwS
         U3tZ3+b0KEDaLloI5DJWffQU+qaZWCmswxEsJdzu8QS12nXeAjenk11GkqxadWoSH9cI
         RZvdq+IXL3PH2gI8sCfbRJZp6d1cFYOGF8Hq12m42N7d18N5oyr/Q0DqpdkCuDMOgzWK
         V9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725466693; x=1726071493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7WeGJH80bEcJ0365jFT2qsdMy+ow6oBRUAZDQ7XPYag=;
        b=t5AreZniOjz8yXLzt7lcYgWsI8dTPQIzDht4Gn+liCc1iAvnqXy4e+CLRk9+fRM/4Z
         5OdmZXTjsScExg95BgmKKf2Dhv8q8io22+QOA9fM2Y+LWnGMS6Y4LJakhy1/h+OzvQ9K
         RtTlLxRiMere6BzWJDTh6KuENw067SpbAb3yyo97j7I4WFpJI614wOe4Zn2u1SDMrNNb
         zj2nHOhPYIp07gy5YYjLzJtbLhs0TrNv3oWVW3AxVZXo61SMvTpZ9dKt5WtKk8Zli6HZ
         qNzD6NxR/vwnovlrD4gSNpn3W5uUB0xpJybM29yHKNjg6oTLrDD33Xx6CnizCNPjRSYH
         HueA==
X-Forwarded-Encrypted: i=1; AJvYcCVIKazESBhDOccLDwfPMKUWmRbW3yktRqhAYSrkqT2elaYjqGb0gVAVp91KTkrM/7RfB1L1xCiWAexoktg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKiVk2x1gZDuIVLp6MN24suALpplp6NsXTDnqN50qgUl9ot783
	uEoP7n6cqnLeyqyH909jkHK8jyyGLzce+pOCzsNdM/Kl0YwMP87dR1Ir/g5b7pL+/yNZnyLze3O
	dCxdYAsGaXTvcBjN+Tht/TSkYhApvk4vR2yGr
X-Google-Smtp-Source: AGHT+IEykJoO0CUB9s8s6fVSGbKiIoASEttssn/0WTzizKwfBV/HeZPmuqrT5IbD+slBtZTDHwI1j3Scv6KP974j2CE=
X-Received: by 2002:a05:622a:15c9:b0:456:9498:6b53 with SMTP id
 d75a77b69052e-457f623ac57mr4374521cf.16.1725466693017; Wed, 04 Sep 2024
 09:18:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902044128.664075-1-surenb@google.com> <20240902044128.664075-7-surenb@google.com>
 <20240901221636.5b0af3694510482e9d9e67df@linux-foundation.org>
 <CAJuCfpGNYgx0GW4suHRzmxVH28RGRnFBvFC6WO+F8BD4HDqxXA@mail.gmail.com>
 <47c4ef47-3948-4e46-8ea5-6af747293b18@nvidia.com> <ZtfDiH3lZ9ozxm0v@casper.infradead.org>
In-Reply-To: <ZtfDiH3lZ9ozxm0v@casper.infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 4 Sep 2024 09:18:01 -0700
Message-ID: <CAJuCfpHJ9PwNOqmFOH373gn6Uqa-orG6zP3rqk-_x=GkpUo2+Q@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] alloc_tag: config to store page allocation tag
 refs in page flags
To: Matthew Wilcox <willy@infradead.org>
Cc: John Hubbard <jhubbard@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	kent.overstreet@linux.dev, corbet@lwn.net, arnd@arndb.de, mcgrof@kernel.org, 
	rppt@kernel.org, paulmck@kernel.org, thuth@redhat.com, tglx@linutronix.de, 
	bp@alien8.de, xiongwei.song@windriver.com, ardb@kernel.org, david@redhat.com, 
	vbabka@suse.cz, mhocko@suse.com, hannes@cmpxchg.org, roman.gushchin@linux.dev, 
	dave@stgolabs.net, liam.howlett@oracle.com, pasha.tatashin@soleen.com, 
	souravpanda@google.com, keescook@chromium.org, dennis@kernel.org, 
	yuzhao@google.com, vvvvvv@google.com, rostedt@goodmis.org, 
	iamjoonsoo.kim@lge.com, rientjes@google.com, minchan@google.com, 
	kaleshsingh@google.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 7:19=E2=80=AFPM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Tue, Sep 03, 2024 at 06:25:52PM -0700, John Hubbard wrote:
> > The more I read this story, the clearer it becomes that this should be
> > entirely done by the build system: set it, or don't set it, automatical=
ly.
> >
> > And if you can make it not even a kconfig item at all, that's probably =
even
> > better.
> >
> > And if there is no way to set it automatically, then that probably mean=
s
> > that the feature is still too raw to unleash upon the world.
>
> I'd suggest that this implementation is just too whack.
>
> What if you use a maple tree for this?  For each allocation range, you
> can store a pointer to a tag instead of storing an index in each folio.

I'm not sure I understand your suggestion, Matthew. We allocate a
folio and need to store a reference to the tag associated with the
code that allocated that folio. We are not operating with ranges here.
Are you suggesting to use a maple tree instead of page_ext to store
this reference?

