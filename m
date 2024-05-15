Return-Path: <linux-kernel+bounces-179316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 924208C5EB8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 03:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3C641C20D77
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 01:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBE8BA5E;
	Wed, 15 May 2024 01:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ASe7zdLS"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA916A932
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 01:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715736134; cv=none; b=QJDBTcP9T17J3bE7zj7T+djuJ9PZF3x+UNSqaaVDH3x2pmO47HGgQixc0HmeeS/x5vcafZ4Zdlg86J3xwJMPr5/FVwFfJllG642+2Y2+E2bE0nty48hteL315sNqez2n8zCDUAifUuLD1uEjGy3KeAVPj1jnDO0Bv5zbdC1O4/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715736134; c=relaxed/simple;
	bh=PjmdoL8aK6SpmWV+gcuuagXO08GZB4SplEuasH9OLnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b4LAmAAs2hB4s/fztCMqMOyu19hrJAZlSqQMnwbgo4qKILxIn1I7yVv7TS0nC6gbxpIdU1s0v7welCgSc1ncxWXBORM/6loFeqofPjOOB/D0YK+SPm5rkw3pJFhZ3s/2q/jJRd66cTcdSE2CrRyFkO16mjH4KHf5ZiRjww9S8T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ASe7zdLS; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-de603e3072dso6988650276.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 18:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715736131; x=1716340931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjmdoL8aK6SpmWV+gcuuagXO08GZB4SplEuasH9OLnY=;
        b=ASe7zdLSA6BwDWb84ni3pLUF7iQ+z1sAxwlV0FQOGh3tspLa+sppejMt7N1fmaxGoc
         y9nxGCWGjHBsKooPpmhqCyi03Ary3qmK9HyxlHmhDRbgDqlD+nYghiCk0p8kOTMYboAO
         Dt8j/hXr/IyOiDDZeqenz5O4M7ZR2L2v4KqYQIZpQSeL5KMqZXZSQPAOK4/NcRmnDYtl
         u7V5b0Ay2XYAZ8NExg01yOSBhw6WIbH2aBavWO2tr41lFSV20a9mrUIWTDcNX0/xCHGT
         I+2N8BrB+ckevkHQg13wxUvNmLfs4Mr6rA79sjRYElo0Li/3a2JkhXIrYL0cne57T2hC
         QMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715736132; x=1716340932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PjmdoL8aK6SpmWV+gcuuagXO08GZB4SplEuasH9OLnY=;
        b=YZ4lNNL1zTqv0yUgV8n0JF04kiqjZEVnqtlxBfvbQgM66kjM/VC1RDOQmQpL3IMDjr
         FcXbSkntHRUPgMYDM4ZC2lNhYvgIqBXUssSZHz9XOLQ8JnS3OS01WnXY9DYtpk8HX1dK
         FR7g7AtD/3KHSibynxs7JwuzkzWmhGQehopEFiL0Yeq9KXlhdbrz7HgG43EycqfL0SRW
         56qCqiGjcyNqzbWPtK43p91iKafPhmgWGRu/hk0XumzyC1F54g5XEiOjoFFkaoBOqVM2
         aVJbZ1Q8ZHNha43/KNSUBeghZW9rdSAjSuOMhG5VZQk1z4jpSj6GLaSN/F60VeMbxVz9
         eCKg==
X-Forwarded-Encrypted: i=1; AJvYcCX5Hig7yBUtVjTEUbmmHYNhmCFfNmgMAouHFQv49dhV6oqrVjDhZ+oFD3yP7pitygdUXbxSFLCCZERKX6vYnIO1LTa67Ckw/f3GZ2WL
X-Gm-Message-State: AOJu0YwPPdlW5hQV8C8fITqSa/WuOvHCplU2lofI5NXziypIq7ar3G2M
	mYOn3vXwbhK64rVmojqveU9xGd/nex7cMl1/llbQVE4hV2qmuzu4WkrmoC2FVsaq7cH0MHPxZcj
	NQG9FAuQlrt20rQA7TrhWhCnhpo7SrQTyS5xU
X-Google-Smtp-Source: AGHT+IFWUUjU6sUNOq/Evye+BgmL3GiqmZBAyQyzUv6knnlnP8bIsfU6R8l0apQ6lQi0JL7TPW8eDB/LOqLphZSlreA=
X-Received: by 2002:a25:b1a3:0:b0:dee:5cb6:483c with SMTP id
 3f1490d57ef6-dee5cb64977mr12258845276.49.1715736131408; Tue, 14 May 2024
 18:22:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514020301.1835794-1-yuanchu@google.com> <2024051414-untie-deviant-ed35@gregkh>
In-Reply-To: <2024051414-untie-deviant-ed35@gregkh>
From: Yuanchu Xie <yuanchu@google.com>
Date: Tue, 14 May 2024 18:21:57 -0700
Message-ID: <CAJj2-QFnOjzwbsMrTcrzPsbCFchtJLM0hiJDbR-xe1HcmV+ytw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/2] virt: memctl: control guest physical memory properties
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Wei Liu <liuwe@microsoft.com>, Rob Bradford <rbradford@rivosinc.com>, 
	"Theodore Ts'o" <tytso@mit.edu>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Jonathan Corbet <corbet@lwn.net>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, virtualization@lists.linux.dev, 
	dev@lists.cloudhypervisor.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 9:06=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, May 13, 2024 at 07:03:00PM -0700, Yuanchu Xie wrote:
> > Memctl provides a way for the guest to control its physical memory
> > properties, and enables optimizations and security features. For
> > example, the guest can provide information to the host where parts of a
> > hugepage may be unbacked, or sensitive data may not be swapped out, etc=
.
> >...
> Pretty generic name for a hardware-specific driver :(
It's not for real hardware btw. Its use case is similar to pvpanic
where the device is emulated by the VMM. I can change the name if it's
a problem.

> Yup, you write this to hardware, please use proper structures and types
> for that, otherwise you will have problems in the near future.
Thanks for the review and comments on endianness and using proper
types. Will do.

Thanks,
Yuanchu

