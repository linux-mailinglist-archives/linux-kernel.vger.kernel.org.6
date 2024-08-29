Return-Path: <linux-kernel+bounces-307375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C82DC964C9F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 19:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E78001C220A1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 17:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4890F1B6542;
	Thu, 29 Aug 2024 17:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X+8R/ciI"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4B515CD62
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 17:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724951295; cv=none; b=N69A6qV21bBgs6fwAKl9m7B/lcF6DlXPyH/Ub67Ihv8HzZFIobMqIJQBvCuZsQSC4iMeXnXSA/59aiySkk6uPqpVrx0m9V6SLqZcs5d50qjRXZUyQ4USMdA6VU314yS5djlRDWvaoDVuuryMns23o8kYQTK8AGq3ONfUH4pQgB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724951295; c=relaxed/simple;
	bh=Zshn8fiUw1u378wY9U6oH5vvUMiIYTYK7Ur9JUnTAWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cWOJcQ3jHnRXGEwesM6KgxC3EaBz5yIgI1XYrgOM3fkJt0OzJF//ZOThJx830r+cnD4fAnUUM/oavhw7IWmYCrsSC7dVJbLnHZg3GNo0jLltS4BUF9NcZjhGLzeTgpg9O7wQVJPPgN4HqUZfTuyWHeUsQpa5eE7K4/UNisBU9n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X+8R/ciI; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e1654a42cb8so863502276.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 10:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724951293; x=1725556093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L8td7J/hz17EUIOLugx+WB3hC5g5J7mRONuvLRrSSJ8=;
        b=X+8R/ciIYMyHcNCt0EFI3Ozq1JMgiax8M376oNT87xwq6/RaSIQMOXL9r9WXGmYRNb
         nx/EKCnOvthLLLwXHfopBqdrBn5XQcsvZMX3tlSvHx56gAFpRwsstclgKd/dOAfwlzwG
         u5ceRXoZuRWz0/H4C4qW8v6DKfLfH7iSyqdbIknH/+Ci2avAyTS9wvJv+7GWgVK2RZmj
         XN9jymDYm8XcabT4r/l5Zy1RqrnoE1b7Um3CoTQWApK/bwq329tOVkK+l5a+RpoGqf0Y
         WaSw/YMm+wcWlvK6wrqQzZmYC7Enc//aw8ql1KViLq+J7onkrD3rtYIs4XV0RQpJmAiN
         2oZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724951293; x=1725556093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L8td7J/hz17EUIOLugx+WB3hC5g5J7mRONuvLRrSSJ8=;
        b=G79nkwJ1sSlBPKNIWYErpXbn/FbhE7hD9iAkeMeM7s5sGAZsBEoy/zT0mTnWHNyDLU
         BtYJlYxZt+89+0znb6u7PGCoBeOLl1xiVzU/A+SgNvlgc5Hgrt/3srE7RXpjCe/MCUyx
         9FT0yhFPVz9GyZqEbycRiruofFzFIDoqPmJ4/TEP4OmfE8emztdZrCNa/z5V1rvawkxO
         F4ygytvYYAod2GwSuINFv49zZqKWG20Meg181VKzle+9t6uupvsVlEStKmIi42ayRq4k
         gNSadt1oNGG66MtSzHElR8riFWVVHUrNgxKTSV7Ba4X3pnaXjGwBzucCnYGDF4sp3aHM
         2fQg==
X-Forwarded-Encrypted: i=1; AJvYcCUFRTKwnnXcY3Tx9cG9XmZnjdzpFe1WdjATaANn4KRSdg4B7Z7Dw8h/lN40KNTTc02l1zDwADpjssUJRzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YynCs26SPCcXqkF5aCM8+k2eCC1g6s1PJLEiP414D/pvJd/L6pi
	amePoB0dvOMB7vdWC2E2fpErIgMqt0yMJJVm/pVFRpqpJbhDVQhNoGJP9uu469EXyrzgvgVY5sU
	pWQ6S08MZ6caRXMtV/BBwgZfbAaGZ1szFmAL6
X-Google-Smtp-Source: AGHT+IGKOIUECZUmfSmy71XPJqb3BiYHBO0nZt7oGG/YN26ZbSppnpYC2EdB2Oic4J/3vKCAgx0B57v16cJmA7yLcFc=
X-Received: by 2002:a05:6902:1b81:b0:e11:6b19:d2c2 with SMTP id
 3f1490d57ef6-e1a5af23cedmr3358918276.49.1724951292622; Thu, 29 Aug 2024
 10:08:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024082224-CVE-2022-48936-9302@gregkh> <z3hh3yrf5wym3obgol6obh3dkmqoc3rwbkj23qcmadf63b47h2@nn2232wngans>
 <2024082854-reassign-uniformed-2c2f@gregkh> <jsnwzpmezgju7r7nkcauaicthkzizsqglb6p43zq25cdvdgbgt@dlkgwkch52qi>
 <CA+FuTSeHvADR5qbWnzRpYtpvNcvYrAeXAj8LYczUFLKREDwfpQ@mail.gmail.com> <2024082958-distress-outmatch-ab28@gregkh>
In-Reply-To: <2024082958-distress-outmatch-ab28@gregkh>
From: Willem de Bruijn <willemb@google.com>
Date: Thu, 29 Aug 2024 13:07:36 -0400
Message-ID: <CA+FuTSdT9Xf0TZm9JAv5tC3WN0UYO_Y9bcAwSsiKyCtwehOE4g@mail.gmail.com>
Subject: Re: CVE-2022-48936: gso: do not skip outer ip header in case of ipip
 and net_failover
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, cve@kernel.org, 
	linux-kernel@vger.kernel.org, Tao Liu <thomas.liu@ucloud.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 12:58=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Aug 29, 2024 at 12:53:34PM -0400, Willem de Bruijn wrote:
> > On Thu, Aug 29, 2024 at 12:18=E2=80=AFPM Michal Koutn=C3=BD <mkoutny@su=
se.com> wrote:
> > >
> > > On Wed, Aug 28, 2024 at 09:30:08AM GMT, Greg Kroah-Hartman <gregkh@li=
nuxfoundation.org> wrote:
> > > > > What is the security issue here?
> > > >
> > > > This was assigned as part of the import of the Linux kernel GSD ent=
ries
> > > > into CVEs as required by the CVE board of directors (hence the 2022
> > > > date).  If you don't feel this should be assigned a CVE, just let m=
e
> > > > know and I will be glad to reject it.
> > >
> > > The address of original author bounces back. Willem, could you please
> > > help explaining context of the change? (~the questions in my previous
> > > message).
> >
> > I don't know why this has a CVE.
> >
> > The patch reports that the negative effect is a drop due to a corrupted=
 packet.
> >
> > According to the CVE report this requires both user input with
> > virtio_net_hdr, which is privileged, and a tunnel device configured,
> > which again is privileged.
> >
>
> Ok, should it be rejected then?  If so, just let me know.

It is a legitimate bug fix, definitely stable material.

With the fix backported to all these branches, not sure what, if
anything, more is needed wrt the CVE.

