Return-Path: <linux-kernel+bounces-278461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7140C94B091
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2609C283C09
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 19:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3D4145338;
	Wed,  7 Aug 2024 19:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="DMg0Li7W"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACDF144D39
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 19:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723059779; cv=none; b=buydyWl+XUhAcoEeu8pN6y9QbX8zV9WC5c7OYSum5NU2GEXmHcYMfs79XVrubIP8c4M5WpRx+hDSFGUqXJIOx7SUlaAkp5qDNpsnKrxq1Ez4AYrBkcp2GfSrFUqp8HG1JjBhkTJ+D/xm6JJJpUBh48CTrVktA3Q9B1FaUcqU1MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723059779; c=relaxed/simple;
	bh=4vWmcMOGkkyE6SpKOg+lxuJbBZmqhBwk93+K8cVoiVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PHMxsAjMeXagY8nZK+xPoya7DaYM+aWrk8U4yqTXtI/5ufmyrA/cBzPR/WkhlkcicTwdesmKUL0TF/rwxsEfMbiFFEqNt1n6aNjqt5V729SK9rVsLWqVeUYmOz1imlupcbaRgx7WrKbIJi9sHJ8CsflgMB4/YcDVszyQphfSA0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=DMg0Li7W; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e0bf9b821e8so152431276.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 12:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1723059776; x=1723664576; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ti+dWnafsTGNMHs+vxXfaBVPCpOMl1fNQUR/dBh5t54=;
        b=DMg0Li7WhSZot3FQpEyegHvFrSKmdOT7b1+e9S0dkQXGpylihmCeZdNuMaNZ7XaRMF
         5842fV463fVCMiDN4qfSV+ijhxnaU1aoTm0kzvAvco3rOCPyzPMHPz/m3JJuu7qRPoh8
         Vh9ssPNU7puvvdE79IZTIO+kouJhhWWl7w/NRgXhJ/1Hm5pEaFZnZGWFk9EY6GkvEMdk
         RyucaQIvwzlSzDjqatW+A309BBCi8N69A/9I1Tcalq5WO1CLtXVJEuGwohUAN0dmZDr5
         QpMj8SGYeKvqdsh2vykyQoO9W4Nw1UHgZVqfkBrkb6DfaqkNPNP2i1UP9gQ1yhJQXY14
         +LkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723059776; x=1723664576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ti+dWnafsTGNMHs+vxXfaBVPCpOMl1fNQUR/dBh5t54=;
        b=HMR0UTO+EZ5xhhCcD5RjE0M0AaWA2HKm3fcuYKcbv1s9zbsSVEfzYCq+IJ0kdoZVBh
         Dn6LQ3sfB1dJ871LN0BDB7KqokxpuvAamo/jcKCRxEpcPZkxu5jKO/657gr3xz5PPjUQ
         RYmrKmQVNNyJaLpFn/sgzToyZcpHJTDtFqv0ToTqlVnpxUp/8hR6YlIQN2qm0teqbrmA
         LN+l8Z717dx/J8x5MuybCH73sHHpl7WJuvBRdUuvGL3abmuG8uQOCoOGbSt+8LSwR/AV
         FzC+s4v9pRTFiBQdTJzRnu4QNTPHOhpkGCzAGLEYdtOej0lmgtDLsvxXMSLuXhJonymm
         bsRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVdz/8WlVOi7fV1wPg4tb0UU6DEOn6mZnGfZvFV4cTMsrD3WqJyb9aUK44zt0WE6A2ws14AhV+kWfiygwaPBf02j9PTl21UTgx0d4Q
X-Gm-Message-State: AOJu0Yy8rxJ6HP9e9mn0vFv52zE5sXUsGrWQ1TN81lnHBfDPpP1dVWYB
	K/cAJSq2avwvIyp8rj0HwjtiC3kiQ2it50Moia3zYXGGuTDYogy5pPKBdEE/egm5QyhqiokxIGH
	n0/I6UXeUbNMZtoT/VRBO2K5Dlx8MIz6PuUPl
X-Google-Smtp-Source: AGHT+IH0uDMTEvlhrjytzwDCCXqiKRWy1dc9NB4WG2rHn2putvbgMZXGt7BbJfYOpwZgKPiHTdtB1n+xOLBh+e8QgUw=
X-Received: by 2002:a05:6902:2b8e:b0:e0b:6039:dea with SMTP id
 3f1490d57ef6-e0bde4ad354mr27003143276.40.1723059775981; Wed, 07 Aug 2024
 12:42:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1722665314-21156-1-git-send-email-wufan@linux.microsoft.com>
 <1722665314-21156-21-git-send-email-wufan@linux.microsoft.com>
 <de7857fb-63d9-42fc-af1e-12ffcdfcdda8@molgen.mpg.de> <CAHC9VhRmcReVM_Le5bYor2deotnSe4OT08UYhL6xhiKCu0+3kA@mail.gmail.com>
 <5880e801-e896-4bf0-9a69-2cf5acb51ec3@molgen.mpg.de> <080c93d1-9c02-478f-a0be-f4bd3869c1fd@linux.microsoft.com>
In-Reply-To: <080c93d1-9c02-478f-a0be-f4bd3869c1fd@linux.microsoft.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 7 Aug 2024 15:42:45 -0400
Message-ID: <CAHC9VhTNTqK5Q446nQHcbxnV6cakAg0NEnvkvs4Tai+4UXOuAw@mail.gmail.com>
Subject: Re: [PATCH v20 20/20] MAINTAINERS: ipe: add ipe maintainer information
To: Fan Wu <wufan@linux.microsoft.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, corbet@lwn.net, zohar@linux.ibm.com, 
	jmorris@namei.org, serge@hallyn.com, tytso@mit.edu, ebiggers@kernel.org, 
	axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com, 
	eparis@redhat.com, linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, fsverity@lists.linux.dev, 
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 2:01=E2=80=AFPM Fan Wu <wufan@linux.microsoft.com> w=
rote:
> On 8/6/2024 9:48 PM, Paul Menzel wrote:
> > Dear Paul,
> >
> > Am 06.08.24 um 22:54 schrieb Paul Moore:
> >> On Sat, Aug 3, 2024 at 4:15=E2=80=AFAM Paul Menzel wrote:
> >
> >>> Thank you very much for your patch. Two nits, should you sent another
> >>> interation: A more specific summary would avoid people having to look=
 at
> >>> the message body or diff, and `git log --oneline` would be enough.
> >>>
> >>> MAINTAINERS: Add IPE entry with M: Fan Wu
> >>>
> >>> MAINTAINERS: Add IPE entry with Fan Wu as maintainer
> >>>
> >>> Am 03.08.24 um 08:08 schrieb Fan Wu:
> >>>> Update MAINTAINERS to include ipe maintainer information.
> >>>
> >>> I=E2=80=99d at least mention Integrity Policy Enforcement. As you not=
 only
> >>> include the maintainer information but add a new entry, I=E2=80=99d l=
eave the
> >>> body out, or mention that a new entry is added.
> >>>
> >>>> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
> >>
> >> Working under the current assumption that a new revision is not
> >> needed, I can fix this up during the merge.  Fan, other-Paul, are you
> >> both okay with the following:
> >>
> >>    "MAINTAINERS: add IPE entry with Fan Wu as maintainer
> >>
> >>     Add a MAINTAINERS entry for the Integrity Policy Enforcement (IPE)
> >> LSM."
> >
> > Thank you. That is fine by me.
> >
> > Kind regards,
> > Paul
>
> Hi Paul and Paul,
>
> Thank you both for your feedback and coordination on this. I'm good with
> the proposed changes and appreciate your efforts.

Updated as shown above, thanks all.

--=20
paul-moore.com

