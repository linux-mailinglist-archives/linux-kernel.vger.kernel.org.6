Return-Path: <linux-kernel+bounces-418387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 733639D6118
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26952B21B1F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 15:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725A413A3E4;
	Fri, 22 Nov 2024 15:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qyl7+Ywf"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A1D73501
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 15:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732288023; cv=none; b=MPyL37rkl8PlHVdjYC5nwKCAZ+kVn5ZaxxpJ/Xd07i8XOwDaOok91eBp3v7GxU8waDjBjqBVmpuPr8uOySC2hIGJzOK9mLkaZ7V2U+aZrGrGTbhHMq+sBXVvMeoGyzPiNmS0MI3nbGvTZGTmst9j4NB7pOXfTfghdt+s7K7/Pbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732288023; c=relaxed/simple;
	bh=ZIE0TbJ33bF99CurhWw5u3B+7prsO8eQjAo6CzhabKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i84sbes/xo+C/kR3MLsdCeLvc1088UHcuR6wpEzXFKPsSw/ly5YWctrPL874HM0zGmGcWUStJfo1VvEA14moQ/WZHOOcY2KMsBXnR6s7elV5btKpgUkw9tXcw45yl+tmCLk/wkfkLzVPT2odWob2Atdbq+ub+nsrEgcCg0H/RZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qyl7+Ywf; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-460969c49f2so285841cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 07:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732288021; x=1732892821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZIE0TbJ33bF99CurhWw5u3B+7prsO8eQjAo6CzhabKs=;
        b=qyl7+YwfC//aNtK92nfBalz/X/Sl83rQdTtFc5ViBCXFbszeFSwpl24wfVsj/HfIeH
         5v4/fCo4l6YeMyt7rXIrgrqMRxj0gTBj1WIcAzzwd+K30c/j311OJMbDCp9hG7Hqe/UM
         RM1IKyAyHjodfqEG7up5nsgH1w0QV/OU3VHUBFaQTlGLL3TF5hp2j81J5OgP/kdBLnKR
         mZ44+UrCJhL9D28GWmrL8g1xo+BnZmgXs7lxvMifZp4FLCl2P0pauy7giKqc0a4I1UBt
         Nwjw3dJ5vMFcDuqXWOcYpGwLZSBQ7CUn5sxVOVe/wjgBrIPxAI6xBtiNflpQrhBr7T87
         S5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732288021; x=1732892821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZIE0TbJ33bF99CurhWw5u3B+7prsO8eQjAo6CzhabKs=;
        b=b7AjYAZfQ9G0fJ+SFRfs90jkWt0Jn8W0uTydahfOL5R6flHEESkKWMpqCgVfKGvM0t
         OkXD9SQ2I8vvljr/sEWL8EWaw8rZDa6XakFelpdoBhLa5rDI14kRJuuXnpvnW3Jwwr2O
         1tcbXKCxKQbDGTbvkemijszREoYFPshuzBnyHr2giiNnOj4+wMVC2ZGy/LQMPkY80DmT
         iIwyvGjXPH+4CJBP1LfkZ+kmQ//LEiyEJzvlJCM/kspREoXmhj83Fat+Y0qfVbFboc7i
         rYcLRFX3oZ2iY1tQt5F+IIgUc2DoPffDd/znVV9642bzk7Nu9pbQ6o3ygxMF00zMN4EH
         rCsw==
X-Forwarded-Encrypted: i=1; AJvYcCUvAOt8dVqnthU9mQD6weXGq7Pr6Ve74W+GYJQ1ckEFOZj1eib8U4luUl7nZOBKHfrVE2m2iMKop98i0uY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTrcw1iDxCa5IXyO/rn1nSCsE1CSUs3IhMdw5gye4pOER9lEje
	0Jvc8citavgQ3gJlWWtyg2hd6m9FzAQqvtxDGMzYI2X3TBVKey3TzZ7juu/SeUa4RklQ6sH+eoE
	cMjXR/IuR19gqTAeZqgoiu8QF5iAnusrxcwLs
X-Gm-Gg: ASbGncuXZPGA29ia9iVrnNptHJH1igmsFEpDveJMXRJkqgzycUY8DY7s2uK1pNUVG9O
	EbKqjrhsjw9tQnrggqc4DzABqcxaqX4g=
X-Google-Smtp-Source: AGHT+IE3NFWMPB84awBTKVHQKpIkIzfpP6rj90b+t0wNWbJd2/ytMK3K3Pnfa7aAXQadq08IftnKIN2x22mbUHavO30=
X-Received: by 2002:a05:622a:54:b0:465:18f3:79c8 with SMTP id
 d75a77b69052e-4658aadae39mr3213131cf.13.1732288020964; Fri, 22 Nov 2024
 07:07:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120000826.335387-1-surenb@google.com> <hdvig2tptf3hi6nmszafarzqb6j56abfbebppqmruvpihlf435@46b57hyw2pfc>
 <Zz6UTvERgg9ubRu4@casper.infradead.org> <e71408ff-b088-48e6-8b18-bb846a60cc1e@lucifer.local>
In-Reply-To: <e71408ff-b088-48e6-8b18-bb846a60cc1e@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 22 Nov 2024 07:06:49 -0800
Message-ID: <CAJuCfpHZH5MHVPeV_EgNb8cMR6hqq5p=Y76tgRCZK6mXL4LG=A@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] move per-vma lock into vm_area_struct
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	akpm@linux-foundation.org, liam.howlett@oracle.com, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com, 
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com, 
	oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, brauner@kernel.org, 
	dhowells@redhat.com, hdanton@sina.com, hughd@google.com, minchan@google.com, 
	jannh@google.com, souravpanda@google.com, pasha.tatashin@soleen.com, 
	corbet@lwn.net, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 3:57=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Thu, Nov 21, 2024 at 02:00:46AM +0000, Matthew Wilcox wrote:
> > On Wed, Nov 20, 2024 at 02:10:44PM -0800, Shakeel Butt wrote:
> > > If 'struct vm_area_struct' is prone to performance issues due to
> > > cacheline misalignments then we should do something about the
> > > __randomize_layout tag for it. I imagine we can identify the fields
> > > which might be performance critical to be on same cacheline or differ=
ent
> > > cacheline due to false sharing then we can divide the fields into
> > > different cacheline groups and fields can be __randomize_layout withi=
n
> > > the group. WDYT?
> >
> > Pretty sure the people who think security is more important than
> > performance are the only ones who randomize structs.
>
> I agree that I don't think we need concern ourselves with users of this
> setting for precisely this reason.
>
> I wouldn't want supporting this to cause difficulty for users who do not
> enable this when those who do aren't really concerned about the perf issu=
es
> as Matthew says.

Ack. Will keep it as is. Thanks!

