Return-Path: <linux-kernel+bounces-512665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCC7A33C46
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E72E7165F56
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 10:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EEA212F98;
	Thu, 13 Feb 2025 10:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k+ge+sL5"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC9A211A2A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 10:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739441698; cv=none; b=Y6GWWpiEHAO86dc3fTsWL5vfk7GHDVqJ2bBNvLoSc8L+cdUVFYzJJwbZKw95kpIPI1AidUdChn6J92NWQb4NsXBEDnK0gkdywa3tf6fNipbzbTakp6RM6ynyxCbrl+269OtTgZJ3T3u0N4ywJ4kqfZd/UrEHtNGzJ0vyjCKperQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739441698; c=relaxed/simple;
	bh=0JHLjjH3wN3gKoNMAITUlA/dbwq1/cIECi2PiVJ/tcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MNghVzS85O9Tp0tTE1lcNGfZP35D9K824yr5OiIWrPHk5re/L6jsss0rzHCFWckKlHsfG62ulJFg3w/2h0B7oL07TeBZQPdhAhoJqD1+aA6dAmQkPtAh5EIFmglVOyQjs0VJeLSdKS/zk/3npQXAD5OIuWwko+FbuhGX+7sf25M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k+ge+sL5; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6efe4e3d698so6282637b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 02:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739441695; x=1740046495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X1eVK89bhCPbjzPBOHZGvUXIBLjSrcJ0fLGshOR9gD0=;
        b=k+ge+sL5s+NtgrMD78bbbpj0c5kdlf3CEXSXixkz6hFKa5mgmkKiD/gGgWOGF1UHQd
         WM014bIJkqZ+UXdyzrCZ2E5pU5eZwChPNwYBINS4leYjTzdohJOoWrrenqVspQEJ6aAO
         hEo43dCFlzVmG2ci61UOCexZsT6lCMBEb2OtmHpjcy9xn53JSkFyuyZnI4UqskIL0y9V
         T8SlA8pwS/XNpf+e8iX0Z6zwTdQYZXqiCdnFlw1IZOnj1xe9L5cGcKxkdAmuroYQl9Vb
         7KQ0KtNeLNbMn5ZGzeM/4/KARbtwN8MGe/hdTG9cMPlZv3H0CE4FMD13ADaOUQ4LX1HY
         nLDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739441695; x=1740046495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X1eVK89bhCPbjzPBOHZGvUXIBLjSrcJ0fLGshOR9gD0=;
        b=cfhcZb/oLJmcEgYhurRGFmjS8LOVpAaXTx0czVonNlE1yb5wQuc58Ukcy/lPoL6EYn
         TdKm9qCAFiZw0fG2CrXikMJUgfycqKs0CEyh/1K6q4uUaEo9LDM6KQ81zpZH1HEHQOvB
         QL24m/aiV+wk+wATXjAGDc8ppTdy8SCnbzI8nNS/G9z9wnCJ+kEqABlYtP0vkXRs2Yv6
         kALO3lMe9z9z1oLvva/MywmHiYS1LYeUgxI32PRVpErLmp/4q0tv4AsiAscQ3FXB2BeS
         OIPdpwhAZZBQ8ySgUav780kt7Izx/PuNhC6ux5RbUH3rdftAWm0PsXOsMwz04uhMpawe
         YjnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPcRN01FD5Z+/alD8MCN5IiEYn8mr5ZnVKZUfNcUBo5zNjHJV8YXxa/XSf0mmn9O8gGw5qsYSFL7miwps=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS3ouCQbD3g0vnzdtU6t4Ifu0HMMeJDF8+WQ1x45QgVCdo2abJ
	eakJgEYBno3zR0BjqtHdszYf1w2gcFAJfB5n77jCpr9JHRrw/69dM5GtGa8IvGBch9shaj4U8SB
	I5jWRjojf0lA5rUDiUm9IdTvL5UiqDjdjNCIOYpc2g3XsHFOROA==
X-Gm-Gg: ASbGnctdLYynFQnrBQkZcq4V9M++OkZMBuFKVtmyT3ctMAShSgBCzkKags9F78+VBmu
	Cf2bc9Qv1b/Po++hrm4dTa6Pkc/iKTootGDqiwamCRQJEUUT7Ahg53pw5vHq5dPeOs19voaWiMQ
	==
X-Google-Smtp-Source: AGHT+IHPKl+ezhAUg4Kb41lGAKIH6dhZQultCWWIoAFnUW2zUViDxbcSm4BXT5TxbZk5VxwC8YkftKBAy5cgosM/gUE=
X-Received: by 2002:a05:6902:11c7:b0:e48:5b35:af2e with SMTP id
 3f1490d57ef6-e5d9f171fe3mr6630880276.33.1739441695278; Thu, 13 Feb 2025
 02:14:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213114400.v4.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
 <20250213034413.3808375-1-chharry@google.com> <2025021325-faction-upward-6395@gregkh>
 <CADg1FFc9_QH10UqxGqjf8hnJkHWjhy6EMPrfDCgvBx2OdOydLg@mail.gmail.com> <2025021328-limes-hacking-2ddc@gregkh>
In-Reply-To: <2025021328-limes-hacking-2ddc@gregkh>
From: Hsin-chen Chuang <chharry@google.com>
Date: Thu, 13 Feb 2025 18:14:27 +0800
X-Gm-Features: AWEUYZlfSGjZxS6z-uKid1N6mQEJpV4pvRzs3n_reJDY3tni8vqfLbrjLm6V2fQ
Message-ID: <CADg1FFc4XRc1fqYZj_J6xq0nBQFRLqyAsFhf1Pt0JNr8mizjjQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] Bluetooth: Add ABI doc for sysfs isoc_alt
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com, 
	chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Got it. Thanks for the feedback

On Thu, Feb 13, 2025 at 6:13=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Thu, Feb 13, 2025 at 06:07:59PM +0800, Hsin-chen Chuang wrote:
> > On Thu, Feb 13, 2025 at 6:01=E2=80=AFPM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > On Thu, Feb 13, 2025 at 11:44:01AM +0800, Hsin-chen Chuang wrote:
> > > > From: Hsin-chen Chuang <chharry@chromium.org>
> > > >
> > > > The functionality was completed in commit c04f2e4f4ea1 ("Bluetooth:=
 Fix
> > > > possible race with userspace of sysfs isoc_alt")
> > > >
> > > > Fixes: c04f2e4f4ea1 ("Bluetooth: Fix possible race with userspace o=
f sysfs isoc_alt")
> > >
> > > Where is this git id?  I don't see it in linux-next, are you sure it =
is
> > > correct?
> >
> > This hash is the first patch of this series.
>
> That's not a valid git id as it only exists on your local system and no
> where else :(
>
> > So I guess I should send this patch after the ancestors are all
> > applied then.
>
> Or better yet, include the api addition as part of the patch that
> actually adds the new api.
>
> thanks,
>
> greg k-h

