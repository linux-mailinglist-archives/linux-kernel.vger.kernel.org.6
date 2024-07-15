Return-Path: <linux-kernel+bounces-252749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 824AE9317AB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 17:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 340E0282BBB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 15:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7035C18F2F6;
	Mon, 15 Jul 2024 15:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iJMDZeZM"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E1118A95B
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 15:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721057610; cv=none; b=N/ltNF8JtNK3+a5XV0gdJYL1Ql4tPeb0GWYgwLHu+628aAWuFi+mGiVMBm6aD9szmGcA8errmohQ8aTknbPEwYD9CwKz8/lbFQf+r4pDyZ2K0oP7OXGvUf/LFuuNrzzvF0kO3wikReI0EHavm5egEWZAd1gG6aZXzuF/OiUryD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721057610; c=relaxed/simple;
	bh=E+yqBgrP1UPJq+8J1/84UWzdIokD9cy7vK/4QbsLD5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pd/hIwBLcjqXk1RJWwVV2wkT4dNA4Niyt32CqkNbDfGYtVSaZX3RrOIvylGTRmR2k6fUfHDXqYi39D1hCsOQLoUMpJ4miHZI5danAyCLq7Rv3NM/AuxY65BuLY2UWnHbH9/wRHS1Iwbgt88fmOnvEHJx5/CKp/RYNNvMgj7gXxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iJMDZeZM; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso21514a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 08:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721057607; x=1721662407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+yqBgrP1UPJq+8J1/84UWzdIokD9cy7vK/4QbsLD5o=;
        b=iJMDZeZMuqJNfVgpMwmuDpKOUAUjhZqOeZ1IfBdfTd2slkE2cuaadNIj3UtmLTWOcz
         tzLVwfUnBYxuYiumSiz0nN2kAdQMkMZ0Cp+BRw9dR63cR2so0PWGfLlEar0gI/ENdfrp
         IixzEVbeSFKB9pYK40N2BGSoCgtxkyfUn5Dlsgs7mQ01OQt/7qHVO+r107dTMAUQpVMo
         TySOn9BAEOlqh6BJ6MQXK9Wl+PXvDHqCenjGlxQQC8rJmpPzPR+WRCD3hRTIT8uZAOP7
         x9+u7542k0tBENeaAxVPG7329WNWSCz+w9SXb/hqaS48uaYZTw2ssjL5VLI1EhV9F98V
         ynyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721057607; x=1721662407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E+yqBgrP1UPJq+8J1/84UWzdIokD9cy7vK/4QbsLD5o=;
        b=kuLFhtf0QfVjWoGJ82sYisAUYIL8yE3PpFsArjHrVlE3iP9k45bUcFJ/acm3r23c2S
         xQbJPA/6TfvwXLQA95mGfqrVXsX7u47nc4sg0zlAycq+ctT9lHkTCHjx+uJ4yAIBCL6j
         BJRtWG/gQq5GFcxvY7UfXpjIun0gmOb1Jy1u59zQvMIIeJlu5zeYsBL1fxtfQSSAK46D
         MFsyTYaYeiEXDKkR6SMEmPuP4bqj2RzuGrgK2sV6+t16JET8ZDECiwQ/NEB78MNN4nVG
         pZo8dBBtaNVHY3VpiLkA0qvscA77uyIzGKbSi4mwRK2eWn4KLUbe1JOUCvf9N4iXwuHr
         wlNg==
X-Forwarded-Encrypted: i=1; AJvYcCUqsMNp1IoJokFQPTDVy1qNFJO0HBhRxbfSf1y+P4/HVEbYNaAb8Ixj8blhZKjFrMGtxo+sNgBKLCUJadcOqjZ+YoeVPKtxWkt8W2NC
X-Gm-Message-State: AOJu0YyGGdD/8hGUfrwYh84YtI/6BM5pUhgrgnZqu1kAgcwTCwdE8VES
	qFTeFX0AhgoYNDV8mG8Z1y2l187JLObBVArnm1/8s49BClxUGP9v6NoixYz0ZGPp9vKO27ysdKT
	DeLu/qbA11fIuyFPDyBiJRhstBuNhN9aymDYP
X-Google-Smtp-Source: AGHT+IG4zOGhlqECPSqe5NnzkSQaewh2qBn+E2XZcxxObGHWBKbinkLXc6ZZ02OJHMttBdSXb90pTnw+IvWoKmukbJU=
X-Received: by 2002:a05:6402:34c6:b0:59e:9fb1:a0dc with SMTP id
 4fb4d7f45d1cf-59e9fb1a16dmr8041a12.6.1721057606980; Mon, 15 Jul 2024 08:33:26
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116141801.396398-1-khtsai@google.com> <02bec7b8-7754-4b9d-84ae-51621d6aa7ec@kernel.org>
 <2024012724-chirpy-google-51bb@gregkh> <CAKzKK0oEO5_-CBKvYSw4DKY4Wp5UPrrt1ehBFRd79idy7FsUuQ@mail.gmail.com>
 <CAKzKK0pmswLnGa8zabp_wo=6BcvCd9DR368FCJ5mcpZ38i4Jdw@mail.gmail.com> <f9f0fb8b-2261-452c-878d-8b0f831bdf5d@kernel.org>
In-Reply-To: <f9f0fb8b-2261-452c-878d-8b0f831bdf5d@kernel.org>
From: Kuen-Han Tsai <khtsai@google.com>
Date: Mon, 15 Jul 2024 23:33:00 +0800
Message-ID: <CAKzKK0o0Mu5woA5AOrJRGicn=SpuB1+S8=zb4T79YUJ=7V=Agg@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: u_serial: Add null pointer checks after
 RX/TX submission
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, quic_prashk@quicinc.com, 
	stern@rowland.harvard.edu, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiri,

Sorry for the late reply, I've finally been able to revisit this issue.

On Thu, Mar 28, 2024 at 5:02=E2=80=AFPM Jiri Slaby <jirislaby@kernel.org> w=
rote:
>
> On 08. 03. 24, 12:47, Kuen-Han Tsai wrote:
> > Hi Greg & Jiri,
> >
> > On Sun, Jan 28, 2024 at 9:29=E2=80=AFAM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> >>
> >> On Thu, Jan 18, 2024 at 10:27:54AM +0100, Jiri Slaby wrote:
> >>> On 16. 01. 24, 15:16, Kuen-Han Tsai wrote:
> >>>> Commit ffd603f21423 ("usb: gadget: u_serial: Add null pointer check =
in
> >>>> gs_start_io") adds null pointer checks to gs_start_io(), but it does=
n't
> >>>> fully fix the potential null pointer dereference issue. While
> >>>> gserial_connect() calls gs_start_io() with port_lock held, gs_start_=
rx()
> >>>> and gs_start_tx() release the lock during endpoint request submissio=
n.
> >>>> This creates a window where gs_close() could set port->port_tty to N=
ULL,
> >>>> leading to a dereference when the lock is reacquired.
> >>>>
> >>>> This patch adds a null pointer check for port->port_tty after RX/TX
> >>>> submission, and removes the initial null pointer check in gs_start_i=
o()
> >>>> since the caller must hold port_lock and guarantee non-null values f=
or
> >>>> port_usb and port_tty.
> >>>
> >>> Or you switch to tty_port refcounting and need not fiddling with this=
 at all
> >>> ;).
> >>
> >> I agree, Kuen-Han, why not do that instead?
> >
> > The u_serial driver has already maintained the usage count of a TTY
> > structure for open and close. While the driver tracks the usage count
> > via open/close, it doesn't fully eliminate race conditions. Below are
> > two potential scenarios:
> >
> > Case 1 (Observed):
> > 1. gs_open() sets usage count to 1.
> > 2. gserial_connect(), gs_start_io(), and gs_start_rx() execute in
> > sequence (lock held).
> > 3. Lock released, usb_ep_queue() called.
> > 4. In parallel, gs_close() executes, sees count of 1, clears TTY, relea=
ses lock.
> > 5. Original thread resumes in gs_start_rx(), potentially leading to
> > kernel panic on an invalid TTY.
>
> If it used refcounting -- tty_port_tty_get(), how comes?

If gs_start_rx() uses refcounting, the race problem will still persist
because gs_close() currently decides to reset port->port.tty to NULL
only when port->port.count reaches one (i.e. last open), without
checking if the associated TTY instance is still in use. I am
uncertain if you are suggesting that I should modify gs_close() by
considering the refcount of a tty instance? I'm still unsure how to
fix this race problem by using refcounting. I'd greatly appreciate it
if you could provide more detailed guidance on how to resolve this
issue, as I'm not very experienced with TTY drivers.

Also, I noticed a typo in my earlier emails, including the commit
message. It should be port->port.tty instead of port->port_tty.

Regards,
Kuen-Han

